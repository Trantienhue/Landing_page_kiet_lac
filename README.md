# Landing page — Dịch vụ xe du lịch Hiếu Thơ

Trang web một trang giới thiệu dịch vụ cho thuê xe du lịch tại Quảng Bình và Quảng Trị.
Hotline 0888 666 373.

## Xem thử

Mở `index.html` bằng trình duyệt. Không cần cài gì, không cần máy chủ.

## Sửa nội dung

Mọi chữ trên trang nằm trong `index.html`. Mở bằng trình soạn thảo bất kỳ, tìm đoạn chữ
muốn đổi rồi gõ đè lên. Không có bước build, lưu file là xong.

Toàn bộ màu sắc nằm ở đầu file, trong khối `:root`. Đổi một dòng ở đó là đổi màu cả trang.

## Ba chỗ còn để trống

Mở `index.html`, dùng chức năng tìm chữ của trình soạn thảo:

| Tìm chuỗi | Việc cần làm |
| --- | --- |
| `DIA_CHI_CAN_DIEN` | Điền địa chỉ vào thẻ `span`, rồi xoá chữ `hidden` ở thẻ `p` bao ngoài |
| `FACEBOOK_CAN_DIEN` | Điền link vào `href`, rồi xoá chữ `hidden` ở thẻ `a` |
| `ANH_16_CHO_CAN_DIEN` | Thay khối "Ảnh đang cập nhật" bằng thẻ `img` như các tab xe khác |
| `TEN_MIEN_CAN_DIEN` | Khi có tên miền, đổi `og:image` sang đường dẫn đầy đủ để Zalo và Facebook hiện được ảnh |

## Thêm ảnh mới

1. Chép ảnh vào thư mục `images/`
2. Chạy `./tools/build-images.sh`
3. Tham chiếu bản đã nén trong `index.html`, ví dụ `images/optimized/TEN_ANH-800.jpg`

Script tạo hai cỡ cho mỗi ảnh: bản `-800.jpg` cho lưới và thẻ, bản `-1600.jpg` cho ảnh
đầu trang và chế độ xem lớn. Chạy lại nhiều lần không sao, ảnh nào đã nén thì bỏ qua.

Muốn ảnh nét hơn, đánh đổi bằng dung lượng:

```bash
QUALITY=60 ./tools/build-images.sh --force
```

Script không bao giờ ghi đè lên `images/`. Ảnh gốc luôn an toàn.

## Đưa lên mạng

Kéo thả cả thư mục này vào [netlify.com/drop](https://app.netlify.com/drop). Nhớ chạy
`./tools/build-images.sh` trước, vì `images/optimized/` không nằm trong git.

## Tài liệu

- Đặc tả thiết kế: `docs/superpowers/specs/2026-09-11-landing-page-hieu-tho-design.md`
- Kế hoạch triển khai: `plans/260911-1629-landing-page-hieu-tho/`
