# Đặc tả thiết kế — Landing page Dịch vụ xe du lịch Hiếu Thơ

Ngày: 2026-09-11

## 1. Mục tiêu

Một trang web duy nhất giới thiệu dịch vụ cho thuê xe du lịch của nhà xe Hiếu Thơ, đặt tại Quảng Bình và Quảng Trị. Mục tiêu duy nhất của trang là khiến khách bấm gọi hotline hoặc nhắn Zalo. Trang không bán hàng trực tuyến, không nhận đặt xe tự động, không công khai giá.

Thành công đo bằng: khách mở trang trên điện thoại, hiểu nhà xe có xe gì và nhận dịch vụ gì trong vòng một lần cuộn, và luôn nhìn thấy nút gọi ở mọi vị trí trên trang.

## 2. Đối tượng và bối cảnh sử dụng

Khách chủ yếu là người Việt, mở trang trên điện thoại qua liên kết dán trong Zalo, Facebook hoặc từ tìm kiếm. Kết nối thường là 4G. Họ đang cần thuê xe cho một chuyến đi cụ thể và muốn biết ngay ba điều: nhà xe có loại xe mình cần không, xe có mới và sạch không, gọi ai.

Suy ra ba yêu cầu bắt buộc: trang phải nhẹ, chữ phải đọc được ngoài nắng, và nút gọi phải luôn trong tầm ngón tay cái.

## 3. Các quyết định đã chốt

| Hạng mục | Quyết định |
| --- | --- |
| Tên hiển thị | Dịch vụ xe du lịch Hiếu Thơ |
| Khu vực phục vụ | Quảng Bình và Quảng Trị, nhận tour ngoại tỉnh |
| Hành động chính | Gọi hotline và nhắn Zalo, không có form |
| Số điện thoại | 0888 666 373 |
| Giá | Không hiển thị, chỉ ghi liên hệ báo giá |
| Công nghệ | HTML tĩnh một trang, không framework |
| Phong cách | Nền tối sang trọng, chữ vàng đồng |
| Bố cục | Một mạch từ trên xuống, dịch vụ trước đội xe |
| Ngôn ngữ | Chỉ tiếng Việt |

## 4. Kiến trúc kỹ thuật

Toàn bộ trang nằm trong một file `index.html`. CSS viết trong một thẻ `<style>` ở đầu file. JavaScript viết trong một thẻ `<script>` ở cuối file. Không dùng thư viện ngoài, không tải font từ mạng, không có bước build khi sửa nội dung.

Cấu trúc thư mục:

```
index.html                 trang web, mở bằng trình duyệt là chạy
images/                    15 ảnh gốc, giữ nguyên, không sửa
images/optimized/          ảnh đã nén, do script sinh ra
tools/build-images.sh      script nén ảnh, chạy một lần
docs/superpowers/specs/    tài liệu
```

`tools/build-images.sh` dùng `sips` có sẵn trên macOS để tạo hai bản cho mỗi ảnh gốc: bản rộng 800 pixel cho thẻ và lưới ảnh, bản rộng 1600 pixel cho ảnh đầu trang và chế độ xem lớn, cả hai ở định dạng JPEG chất lượng 60. Không dùng WebP để khỏi phụ thuộc công cụ ngoài. Script chạy lại được nhiều lần mà không hỏng gì, ảnh nào đã có bản nén thì bỏ qua.

HTML tham chiếu ảnh qua `srcset` để trình duyệt tự chọn cỡ phù hợp. Mọi ảnh trừ ảnh đầu trang đều có `loading="lazy"`, và mọi ảnh đều khai báo `width` với `height` để trang không giật khi ảnh tải xong.

Đưa lên mạng bằng cách kéo thả cả thư mục vào Netlify. Không cần máy chủ, không cần cơ sở dữ liệu.

### Tách bạch trách nhiệm

Dù nằm trong một file, mã được chia thành ba vùng rõ ràng, mỗi vùng làm một việc và không phụ thuộc vào chi tiết bên trong vùng khác:

- **Vùng biến CSS** ở đầu thẻ style, khai báo toàn bộ màu, cỡ chữ, khoảng cách, bo góc. Đổi diện mạo trang chỉ cần sửa vùng này.
- **Vùng nội dung HTML**, mỗi mục của trang là một thẻ `<section>` có `id` riêng, đọc từ trên xuống đúng thứ tự hiển thị.
- **Vùng JavaScript**, gồm đúng hai khối độc lập: khối tab chọn xe và khối xem ảnh lớn. Mỗi khối tự tìm phần tử của mình qua thuộc tính `data-`, không khối nào gọi khối nào. Xoá một khối thì phần còn lại vẫn chạy bình thường.

## 5. Hệ thiết kế

Màu, khai báo dưới dạng biến CSS trên `:root`:

| Biến | Giá trị | Dùng cho |
| --- | --- | --- |
| `--bg` | `#0E0E10` | Nền trang |
| `--surface` | `#17171B` | Nền thẻ, khối nổi |
| `--ink` | `#F5F3EF` | Chữ chính |
| `--muted` | `#A6A29B` | Chữ phụ |
| `--gold` | `#D9B25F` | Nhấn, nút chính, nhãn mục |
| `--gold-deep` | `#B8923F` | Trạng thái bấm của nút chính |
| `--line` | `rgba(217,178,95,.22)` | Viền mảnh |

Trang chỉ có một chế độ tối, không làm chế độ sáng. Nền được tô rõ ràng trên `body`.

Chữ dùng bộ font hệ thống để không phải tải thêm gì: `system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", sans-serif`. Tiêu đề dùng độ đậm 800, chữ thường dùng 400. Cỡ chữ nhỏ nhất trên trang là 12 pixel, chỉ dùng cho nhãn mục.

Khoảng cách theo thang 4 pixel. Mỗi mục cách nhau 56 pixel trên điện thoại và 88 pixel trên máy tính. Hai bên trang luôn chừa lề tối thiểu 16 pixel.

Trang hiển thị tốt từ chiều rộng 360 pixel trở lên, giới hạn nội dung ở 1120 pixel trên màn hình lớn. Không có thanh cuộn ngang ở bất kỳ chiều rộng nào.

## 6. Cấu trúc nội dung

### 6.1 Thanh đầu trang

Dính trên cùng khi cuộn. Bên trái là tên "HIẾU THƠ" màu vàng đồng, bên phải là số 0888 666 373 trong viên thuốc viền mảnh, bấm được để gọi. Nền trong suốt lúc đầu, chuyển sang nền tối mờ khi người dùng cuộn quá 40 pixel.

### 6.2 Ảnh đầu trang

Ảnh nền `IMG_4678.JPG`, chiếc Solati bạc chụp ban đêm với dải đèn LED xanh, phủ một lớp chuyển sắc tối dần xuống đáy để chữ nổi rõ. Chiều cao 88% màn hình trên điện thoại, tối đa 720 pixel trên máy tính.

Nội dung chữ, xếp từ trên xuống:

- Nhãn nhỏ chữ thưa: DỊCH VỤ XE DU LỊCH HIẾU THƠ
- Tiêu đề chính: "Limousine 9 chỗ hạng thương gia", với cụm "hạng thương gia" tô màu vàng đồng
- Dòng phụ: "Cho thuê xe hợp đồng 4 · 7 · 16 · 29 chỗ" và "Quảng Bình · Quảng Trị · tour dài ngày ngoại tỉnh"
- Hai nút cạnh nhau: "Gọi 0888 666 373" nền vàng đồng, và "Nhắn Zalo" nền trong suốt viền vàng

Ngay dưới ảnh là một dải mỏng hai ý: "Tài xế nhiều năm kinh nghiệm" và "Karaoke · nước · khăn lạnh".

### 6.3 Dịch vụ

Nhãn mục "DỊCH VỤ", tiêu đề "Nhà xe nhận những gì". Bốn thẻ, hai cột trên điện thoại, bốn cột trên máy tính:

| Thẻ | Nội dung |
| --- | --- |
| Tour dài ngày | Đi trong tỉnh và ngoại tỉnh, trọn gói theo lịch trình khách đặt |
| Đưa đón tham quan | Đón sân bay, khách sạn, điểm du lịch trong ngày |
| Cưới hỏi và xe hoa | Xe hoa và xe rước khách cho ngày trọng đại |
| Xe hợp đồng | 4, 7, 16, 29 chỗ theo hợp đồng ngắn hạn và dài hạn |

Mỗi thẻ có một biểu tượng vẽ bằng SVG nội tuyến, không dùng emoji và không dùng thư viện icon.

### 6.4 Đội xe

Nhãn mục "ĐỘI XE", tiêu đề "Xe đời mới, đủ mọi cỡ". Một hàng tab cuộn ngang được trên điện thoại, mặc định mở tab đầu tiên. Mỗi tab hiện một ảnh lớn, tên dòng xe, số chỗ và ba gạch đầu dòng mô tả.

Trong bảng dưới, ảnh đứng đầu danh sách là ảnh lớn của tab, những ảnh còn lại chỉ xuất hiện ở thư viện ảnh ở mục 6.8.

| Tab | Ảnh dùng | Ghi chú nội dung |
| --- | --- | --- |
| Limousine 9 chỗ | `IMG_4666`, `IMG_4670`, `IMG_4675`, `IMG_4679` | Hyundai Solati bạc, ghế thương gia, đèn LED |
| Limousine 9 chỗ VIP | `IMG_4667`, `IMG_4671` | Ford Transit đen, ghế da, nội thất tối |
| Xe 29 chỗ | `IMG_4668`, `IMG_4674`, `IMG_4677` | Hyundai County, hợp đoàn đông, lễ hội |
| Xe 4 và 7 chỗ | `IMG_4672` | Xe gầm cao, hợp nhóm nhỏ và đón sân bay |
| Xe 16 chỗ | Chưa có ảnh | Hiện khối chỗ trống nền xám kèm chữ "Ảnh đang cập nhật" |

Tab xe 16 chỗ vẫn hiển thị đầy đủ phần chữ, chỉ thiếu ảnh. Khi có ảnh, chỉ cần thay đường dẫn trong một dòng HTML đã đánh dấu sẵn bằng chú thích.

### 6.5 Tiện nghi trên xe

Nhãn mục "TIỆN NGHI", tiêu đề "Đi xa mà vẫn thoải mái". Bố cục hai cột trên máy tính: bên trái là ảnh nội thất, bên phải là danh sách. Trên điện thoại xếp dọc, ảnh trước.

Ảnh dùng `IMG_4680.JPG` làm ảnh chính và `IMG_4669.JPG` làm ảnh phụ. Danh sách gồm: ghế da ngả lưng, karaoke trên xe, nước uống miễn phí, khăn lạnh, điều hoà mát, đèn LED trang trí.

Chỉ liệt kê những gì nhà xe đã xác nhận có. Không thêm wifi, không thêm cổng sạc, vì chưa được xác nhận.

### 6.6 Vì sao chọn Hiếu Thơ

Bốn ý ngắn, mỗi ý một dòng có dấu nhấn vàng: tài xế nhiều năm kinh nghiệm, chu đáo và lịch sự; xe đời mới, giữ sạch sẽ; nhận cả tour dài ngày ngoại tỉnh; báo giá nhanh ngay trong cuộc gọi.

Nền mục này dùng `--surface` để tách khỏi các mục xung quanh.

### 6.7 Khu vực và tuyến phổ biến

Nhãn mục "KHU VỰC", tiêu đề "Chạy khắp Quảng Bình và Quảng Trị". Danh sách các điểm dưới dạng viên thuốc viền mảnh: Đồng Hới, Phong Nha, Kẻ Bàng, Đông Hà, Cửa Việt, Cửa Tùng, Thành cổ Quảng Trị, Lao Bảo, Huế, Đà Nẵng.

Kèm một câu: nhận cả tuyến ngoài danh sách, gọi hotline để báo giá theo lộ trình.

Không nhúng bản đồ. Khi có địa chỉ, đặt một liên kết văn bản dẫn sang Google Maps ở mục liên hệ.

### 6.8 Thư viện ảnh

Lưới ảnh vuông, hai cột trên điện thoại và bốn cột trên máy tính, hiển thị toàn bộ 15 ảnh ở bản 800 pixel. Bấm vào một ảnh thì mở lớp phủ xem ảnh cỡ 1600 pixel.

Lớp phủ có nút đóng ở góc, đóng được bằng phím Esc, bằng cách bấm ra ngoài ảnh, và chuyển ảnh được bằng phím mũi tên trái phải trên máy tính hoặc vuốt ngang trên điện thoại. Khi lớp phủ mở, trang nền khoá cuộn.

### 6.9 Liên hệ và chân trang

Số 0888 666 373 in cỡ lớn, bấm được để gọi. Dưới đó là nút Zalo. Tiếp theo là hai dòng dành cho địa chỉ và Facebook, mặc định ẩn cho tới khi được điền.

Chân trang ghi tên đầy đủ "Dịch vụ xe du lịch Hiếu Thơ" và dòng bản quyền.

### 6.10 Thanh gọi nổi

Chỉ hiện trên màn hình hẹp hơn 768 pixel. Dính đáy màn hình, gồm hai nút chia đôi: "Gọi ngay" nền vàng đồng và "Zalo" viền vàng. Thanh này xuất hiện sau khi khách cuộn qua ảnh đầu trang, để không che mất hai nút đã có sẵn ở đó.

Phần đáy trang chừa thêm khoảng trống bằng chiều cao thanh, tránh che mất nội dung chân trang.

## 7. Liên kết hành động

| Nút | Đường dẫn |
| --- | --- |
| Gọi | `tel:+84888666373` |
| Zalo | `https://zalo.me/0888666373`, mở tab mới |
| Facebook | Để trống, xem mục 9 |

## 8. Tối ưu tìm kiếm và chia sẻ

Thẻ `title`: "Cho thuê xe du lịch Quảng Bình Quảng Trị | Dịch vụ xe du lịch Hiếu Thơ". Thẻ mô tả nêu limousine 9 chỗ, xe 4, 7, 16, 29 chỗ, tour, đưa đón, cưới hỏi, kèm số hotline.

Thẻ Open Graph đầy đủ tiêu đề, mô tả và ảnh, dùng `IMG_4678` bản 1600 pixel, để liên kết dán vào Zalo hoặc Facebook hiện đẹp.

Dữ liệu có cấu trúc theo schema.org kiểu `AutoRental`, khai báo tên, số điện thoại và khu vực phục vụ là Quảng Bình với Quảng Trị. Trường địa chỉ để trống cho tới khi có.

Ngôn ngữ trang khai báo `lang="vi"`.

## 9. Chỗ trống cần điền sau

Ngay đầu file `index.html`, trước thẻ `<style>`, đặt một khối chú thích gom toàn bộ chỗ cần điền, ghi rõ phải sửa ở dòng nào:

```html
<!-- ============================================
     THÔNG TIN CẦN ĐIỀN SAU
     1. Địa chỉ nhà xe   → tìm chuỗi DIA_CHI_CAN_DIEN
     2. Link Facebook    → tìm chuỗi FACEBOOK_CAN_DIEN
     3. Ảnh xe 16 chỗ    → tìm chuỗi ANH_16_CHO_CAN_DIEN
     Mỗi chỗ đều có thẻ hidden, xoá chữ hidden là hiện ra.
     ============================================ -->
```

Ba phần tử tương ứng mang thuộc tính `hidden` sẵn, nên khi chưa điền thì trang không hiện dòng trống hay liên kết hỏng.

## 10. Xử lý các trường hợp bất thường

- **JavaScript bị chặn hoặc lỗi.** Mọi nội dung đội xe vẫn nằm trong HTML, chỉ là các tab đều mở cùng lúc thay vì chuyển qua lại. Thư viện ảnh vẫn hiện lưới, chỉ mất chức năng xem lớn. Nút gọi và Zalo là thẻ liên kết thuần, không phụ thuộc JavaScript.
- **Ảnh không tải được.** Mọi ảnh có thuộc tính `alt` tiếng Việt mô tả đúng chiếc xe trong ảnh, để khách vẫn hiểu nội dung.
- **Màn hình rất hẹp.** Ở 360 pixel, các lưới hai cột giữ nguyên hai cột nhưng thu nhỏ chữ, còn hàng tab cuộn ngang được.
- **Số Zalo chưa đăng ký.** Nếu `zalo.me/0888666373` không mở được hồ sơ, đổi nút thành liên kết `tel:` thứ hai, hoặc gỡ nút khỏi trang. Ghi rõ điều này trong chú thích cạnh nút.

## 11. Kiểm thử và tiêu chí hoàn thành

Trang coi là xong khi thoả toàn bộ các mục sau:

- [ ] Mở `index.html` bằng trình duyệt, không cần máy chủ, trang hiện đầy đủ
- [ ] Ở chiều rộng 360, 414, 768 và 1440 pixel đều không có thanh cuộn ngang
- [ ] Bấm nút gọi trên điện thoại thật mở đúng trình quay số với số 0888 666 373
- [ ] Bấm nút Zalo mở đúng ứng dụng hoặc trang Zalo
- [ ] Thanh gọi nổi chỉ hiện sau khi cuộn qua ảnh đầu trang, và không che chân trang
- [ ] Tab đội xe chuyển qua lại đúng, mở trang lần đầu là tab limousine 9 chỗ
- [ ] Xem ảnh lớn mở, chuyển, và đóng được bằng cả chuột, phím và cảm ứng
- [ ] Tắt JavaScript, toàn bộ chữ vẫn đọc được và nút gọi vẫn hoạt động
- [ ] Tổng dung lượng tải lần đầu dưới 600 KB
- [ ] Điểm hiệu năng Lighthouse trên điện thoại đạt từ 90 trở lên
- [ ] Mọi ảnh có `alt` tiếng Việt, mọi nút bấm thấy rõ viền khi chuyển bằng phím Tab
- [ ] Ba chỗ trống ở mục 9 đều đang ẩn và tìm được bằng cách tìm chuỗi đánh dấu

## 12. Ngoài phạm vi

Không làm trong lần này: form đặt xe, bảng giá, bản tiếng Anh, bản đồ nhúng, trang blog, hệ quản trị nội dung, theo dõi chuyển đổi, và mọi trang phụ ngoài trang chính.
