# Giai đoạn 1 — Chuẩn bị ảnh

## Mục tiêu

Biến 15 ảnh gốc nặng trung bình 1,2 MB thành hai bộ ảnh nhẹ mà trang dùng được, bằng một script chạy lại được nhiều lần.

## Việc cần làm

### 1.1 Viết `tools/build-images.sh`

Script dùng `sips`, có sẵn trên mọi máy macOS, không cài thêm gì.

Với mỗi file `images/*.JPG`, sinh ra hai file trong `images/optimized/`:

| Bản | Chiều rộng tối đa | Chất lượng | Tên file | Dùng cho |
| --- | --- | --- | --- | --- |
| Nhỏ | 800 pixel | 60 | `IMG_xxxx-800.jpg` | Thẻ đội xe, lưới thư viện |
| Lớn | 1600 pixel | 60 | `IMG_xxxx-1600.jpg` | Ảnh đầu trang, xem ảnh lớn, ảnh chia sẻ |

Yêu cầu với script:

- Chạy lại lần hai không làm gì thêm nếu file đích đã tồn tại và mới hơn file nguồn
- Có cờ `--force` để nén lại toàn bộ
- Tự tạo thư mục `images/optimized/` nếu chưa có
- In ra tên file và dung lượng trước sau, để người chạy thấy được kết quả
- Thoát với mã khác 0 nếu `sips` không tồn tại
- Dùng `sips -Z` để giữ tỉ lệ, không làm méo ảnh

Lệnh cốt lõi:

```bash
sips -Z "$WIDTH" -s format jpeg -s formatOptions 60 "$SRC" --out "$DST"
```

### 1.2 Chạy script và kiểm tra

```bash
chmod +x tools/build-images.sh
./tools/build-images.sh
du -sh images/optimized
```

### 1.3 Kiểm mắt chất lượng

Mở ba ảnh bản 1600 pixel và soi kỹ:

- `IMG_4678-1600.jpg`, ảnh đầu trang chụp đêm, xem dải LED có bị vỡ hạt không
- `IMG_4674-1600.jpg`, đuôi xe 29 chỗ có in hotline, xem chữ còn đọc được không
- `IMG_4680-1600.jpg`, nội thất nhiều màu, xem vùng tối có bị bệt không

Nếu bất kỳ ảnh nào trông rẻ tiền, nâng chất lượng lên 70 và chạy lại với `--force`. Đừng vượt quá 75, vì lợi ích thị giác không bù được dung lượng.

### 1.4 Ghi lại ánh xạ ảnh

Tạo một khối chú thích để dán vào đầu `index.html` ở giai đoạn sau, liệt kê ảnh nào thuộc dòng xe nào. Nội dung lấy từ bảng ở mục 6.4 của đặc tả.

## Tiêu chí xong

- [ ] `images/optimized/` có đúng 30 file
- [ ] Không file bản 800 pixel nào vượt quá 120 KB
- [ ] Không file bản 1600 pixel nào vượt quá 400 KB
- [ ] Chạy `./tools/build-images.sh` lần hai in ra thông báo bỏ qua, không nén lại
- [ ] Ba ảnh ở mục 1.3 đạt yêu cầu khi nhìn bằng mắt
- [ ] `images/optimized/` nằm trong `.gitignore`

## Cạm bẫy

`sips` ghi đè file đích không cần hỏi. Luôn ghi ra `images/optimized/`, tuyệt đối không ghi đè lên `images/`. Ảnh gốc là thứ không lấy lại được.

Tên file gốc viết hoa phần mở rộng là `.JPG`. Khi ghép tên file đích phải cắt đúng phần mở rộng, đừng để ra `IMG_4666.JPG-800.jpg`.
