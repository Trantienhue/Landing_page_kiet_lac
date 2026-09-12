#!/bin/bash
#
# Nén 15 ảnh gốc trong images/ thành hai bộ ảnh nhẹ trong images/optimized/
#
#   IMG_xxxx-800.jpg    cạnh dài tối đa  800px  — thẻ đội xe, lưới thư viện
#   IMG_xxxx-1600.jpg   cạnh dài tối đa 1600px  — ảnh đầu trang, xem ảnh lớn
#
# Cách dùng:
#   ./tools/build-images.sh           chỉ nén ảnh chưa có hoặc đã cũ
#   ./tools/build-images.sh --force   nén lại toàn bộ
#   QUALITY=60 ./tools/build-images.sh --force   nén lại với chất lượng cao hơn
#
# Script không bao giờ ghi vào images/. Ảnh gốc là thứ không lấy lại được.

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC_DIR="$ROOT/images"
OUT_DIR="$ROOT/images/optimized"
QUALITY="${QUALITY:-45}"
SIZES=(800 1600)

FORCE=0
[[ "${1:-}" == "--force" ]] && FORCE=1

if ! command -v sips >/dev/null 2>&1; then
  echo "Lỗi: không tìm thấy sips. Script này cần macOS." >&2
  exit 1
fi

if [[ ! -d "$SRC_DIR" ]]; then
  echo "Lỗi: không thấy thư mục $SRC_DIR" >&2
  exit 1
fi

mkdir -p "$OUT_DIR"

# Dung lượng file ở dạng người đọc được, ví dụ 1.2M
human() { du -h "$1" 2>/dev/null | cut -f1 | tr -d ' '; }

made=0
skipped=0

shopt -s nullglob nocaseglob
for src in "$SRC_DIR"/*.jpg "$SRC_DIR"/*.jpeg "$SRC_DIR"/*.png; do
  name="$(basename "$src")"
  stem="${name%.*}"

  # Cạnh dài của ảnh gốc. Ảnh nhỏ hơn cỡ đích thì bỏ qua cỡ đó,
  # phóng to chỉ làm nhoè chữ mà file lại nặng thêm.
  long_side="$(sips -g pixelWidth -g pixelHeight "$src" 2>/dev/null \
    | awk '/pixelWidth/{w=$2} /pixelHeight/{h=$2} END{print (w>h?w:h)+0}')"

  for w in "${SIZES[@]}"; do
    dst="$OUT_DIR/${stem}-${w}.jpg"

    if [[ -n "$long_side" && "$long_side" -gt 0 && "$long_side" -le "$w" ]]; then
      skipped=$((skipped + 1))
      continue
    fi

    if [[ $FORCE -eq 0 && -f "$dst" && "$dst" -nt "$src" ]]; then
      skipped=$((skipped + 1))
      continue
    fi

    sips -Z "$w" -s format jpeg -s formatOptions "$QUALITY" "$src" --out "$dst" >/dev/null
    printf '  %-24s %6s  ->  %-24s %6s\n' "$name" "$(human "$src")" "$(basename "$dst")" "$(human "$dst")"
    made=$((made + 1))
  done
done
shopt -u nullglob nocaseglob

echo
echo "Đã nén: $made file, bỏ qua vì đã có sẵn: $skipped file, chất lượng: $QUALITY"
echo "Tổng dung lượng $OUT_DIR: $(du -sh "$OUT_DIR" | cut -f1)"
