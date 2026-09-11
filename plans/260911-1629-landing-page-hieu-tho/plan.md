---
title: Landing page Dịch vụ xe du lịch Hiếu Thơ
status: in-progress
created: 2026-09-11
mode: fast
spec: docs/superpowers/specs/2026-09-11-landing-page-hieu-tho-design.md
blockedBy: []
blocks: []
---

# Kế hoạch triển khai — Landing page Dịch vụ xe du lịch Hiếu Thơ

## Bối cảnh

Dự án trống, chỉ có 15 ảnh gốc trong `images/` và một tài liệu đặc tả đã được duyệt. Không có mã nguồn cũ, không có quy ước sẵn, không có phụ thuộc nào. Vì vậy kế hoạch này xây từ đầu và tự đặt quy ước.

Đặc tả là nguồn chân lý: `docs/superpowers/specs/2026-09-11-landing-page-hieu-tho-design.md`. Mọi con số màu, mọi đoạn chữ hiển thị, mọi ánh xạ ảnh đều lấy từ đó, không tự bịa thêm.

## Kết quả cuối

```
index.html                 trang web hoàn chỉnh, mở là chạy
tools/build-images.sh      script nén ảnh, chạy một lần
images/optimized/          ảnh nén, không đưa vào git
```

## Ràng buộc kỹ thuật

| Ràng buộc | Lý do |
| --- | --- |
| Một file HTML, không framework | Chủ xe tự sửa nội dung bằng cách gõ chữ |
| Không tải font hay thư viện từ mạng | Khách dùng 4G, mỗi request là một lần chờ |
| Tải lần đầu dưới 600 KB | Ảnh gốc trung bình 1,2 MB mỗi tấm |
| Trang vẫn dùng được khi JavaScript hỏng | Nút gọi là thứ không được phép chết |
| Không có thanh cuộn ngang từ 360 pixel trở lên | Phần lớn khách vào bằng điện thoại |

## Các giai đoạn

| # | Giai đoạn | Kết quả | Phụ thuộc |
| --- | --- | --- | --- |
| 1 | [Chuẩn bị ảnh](phase-1-images.md) | `tools/build-images.sh` và 30 file ảnh nén | Không |
| 2 | [Khung trang và hệ thiết kế](phase-2-shell.md) | `index.html` với biến CSS, thanh đầu trang, ảnh đầu trang, thanh gọi nổi | 1 |
| 3 | [Các mục nội dung](phase-3-content.md) | Dịch vụ, đội xe có tab, tiện nghi, lý do chọn, khu vực | 2 |
| 4 | [Thư viện ảnh](phase-4-gallery.md) | Lưới 15 ảnh và lớp phủ xem lớn | 3 |
| 5 | [Liên hệ, chỗ trống, SEO](phase-5-contact-seo.md) | Mục liên hệ, chân trang, khối chú thích, thẻ meta và schema | 4 |
| 6 | [Kiểm thử và tinh chỉnh](phase-6-qa.md) | 12 mục trong danh sách kiểm thử đều đạt | 5 |

## Thứ tự làm và lý do

Ảnh đi trước vì mọi thứ sau đó đều tham chiếu tới đường dẫn ảnh đã nén. Nếu làm HTML trước rồi mới nén ảnh thì phải sửa lại toàn bộ đường dẫn.

Khung trang đi trước nội dung vì biến CSS và các lớp dùng chung được khai báo một lần ở đây, các mục sau chỉ việc dùng lại. Đây cũng là chỗ chốt cảm giác thị giác, nếu sai thì sửa sớm rẻ hơn sửa muộn.

Thư viện ảnh và lớp phủ tách riêng vì đây là khối JavaScript lớn nhất và là thứ duy nhất có thể gỡ bỏ hoàn toàn mà trang vẫn nguyên vẹn.

Kiểm thử để cuối nhưng không dồn hết vào cuối: mỗi giai đoạn đều có tiêu chí xong riêng, giai đoạn 6 chỉ chạy danh sách kiểm thử đầy đủ trên thiết bị thật.

## Rủi ro

| Rủi ro | Ảnh hưởng | Cách xử lý |
| --- | --- | --- |
| Số 0888 666 373 chưa đăng ký Zalo | Nút Zalo dẫn tới trang trống, mất một kênh liên hệ | Hỏi chủ xe ở giai đoạn 5, nếu chưa có thì gỡ nút và mở rộng nút gọi |
| Không có ảnh xe 16 chỗ | Một tab đội xe trống ảnh | Đã có phương án trong đặc tả: khối xám ghi "Ảnh đang cập nhật", đánh dấu sẵn chỗ thay |
| Ảnh chụp dọc và ngang lẫn lộn | Lưới ảnh và tab xe cao thấp so le | Khung ảnh cố định tỉ lệ, ảnh cắt theo `object-fit: cover` |
| Nén ảnh làm mất chi tiết biển số và chữ trên thân xe | Ảnh trông rẻ tiền, phản tác dụng với thông điệp sang trọng | Kiểm mắt bản 1600 pixel sau giai đoạn 1, nâng chất lượng lên 70 nếu cần |

## Ghi chú

Máy hiện có `cwebp` tại `/opt/homebrew/bin/cwebp`. Đặc tả đã chốt chỉ dùng JPEG để script chạy được trên mọi máy. Giữ nguyên quyết định đó. Nếu sau này cần giảm thêm dung lượng thì thêm WebP là việc của lần sau, không làm bây giờ.

Không dùng emoji làm biểu tượng vì emoji hiển thị khác nhau giữa Android và iPhone, và trông thiếu nghiêm túc cạnh thông điệp sang trọng. Dùng SVG vẽ tay, mỗi biểu tượng dưới 20 dòng.
