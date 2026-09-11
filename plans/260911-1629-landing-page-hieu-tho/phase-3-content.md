# Giai đoạn 3 — Các mục nội dung

## Mục tiêu

Đổ năm mục nội dung vào khung đã dựng: dịch vụ, đội xe, tiện nghi, lý do chọn, khu vực. Toàn bộ chữ lấy nguyên văn từ mục 6.3 tới 6.7 của đặc tả.

## Việc cần làm

### 3.1 Mục dịch vụ

Nhãn DỊCH VỤ, tiêu đề "Nhà xe nhận những gì". Bốn thẻ, hai cột dưới 768 pixel, bốn cột trên 768 pixel.

Bốn thẻ và nội dung nằm ở bảng mục 6.3 của đặc tả: tour dài ngày, đưa đón tham quan, cưới hỏi và xe hoa, xe hợp đồng.

Mỗi thẻ một biểu tượng SVG nội tuyến, `stroke="currentColor"`, `fill="none"`, khung `viewBox="0 0 24 24"`, dưới 20 dòng mỗi cái. Bốn biểu tượng: la bàn, xe khách, bó hoa, tờ giấy. Đặt `aria-hidden="true"` vì ý nghĩa đã nằm trong chữ.

### 3.2 Mục đội xe

Nhãn ĐỘI XE, tiêu đề "Xe đời mới, đủ mọi cỡ".

Một hàng năm tab, cuộn ngang được trên điện thoại bằng `overflow-x:auto` với `scroll-snap`. Tab đang chọn có nền vàng đồng.

Năm tab, ảnh lớn và nội dung lấy từ bảng mục 6.4 của đặc tả:

| Tab | Ảnh lớn |
| --- | --- |
| Limousine 9 chỗ | `IMG_4666-800.jpg` |
| Limousine 9 chỗ VIP | `IMG_4667-800.jpg` |
| Xe 29 chỗ | `IMG_4668-800.jpg` |
| Xe 4 và 7 chỗ | `IMG_4672-800.jpg` |
| Xe 16 chỗ | chưa có, xem mục 3.3 |

Mỗi khối tab gồm ảnh lớn tỉ lệ 4:3 cắt theo `object-fit:cover`, tên dòng xe, số chỗ, và ba gạch đầu dòng mô tả.

Đánh dấu bằng thuộc tính `data-`, không dùng lớp CSS làm móc cho JavaScript:

```html
<div data-tabs>
  <button data-tab="solati" aria-selected="true">Limousine 9 chỗ</button>
  ...
  <div data-panel="solati">...</div>
</div>
```

Khối JavaScript cho tab tự tìm phần tử qua `[data-tabs]`, không biết gì về phần còn lại của trang. Dùng `role="tablist"`, `role="tab"`, `role="tabpanel"` và `aria-selected` cho đúng.

Khi JavaScript không chạy, mọi panel đều hiện. Làm được điều này bằng cách ẩn panel từ JavaScript lúc khởi động, không ẩn sẵn bằng CSS.

### 3.3 Tab xe 16 chỗ chưa có ảnh

Thay ảnh bằng một khối cùng tỉ lệ 4:3, nền `--surface`, viền đứt mảnh, chữ giữa khối ghi "Ảnh đang cập nhật". Phần chữ mô tả vẫn đầy đủ như các tab khác.

Đặt chú thích ngay trên khối đó:

```html
<!-- ANH_16_CHO_CAN_DIEN: thay cả khối div này bằng thẻ img giống các tab trên -->
```

### 3.4 Mục tiện nghi

Nhãn TIỆN NGHI, tiêu đề "Đi xa mà vẫn thoải mái". Hai cột trên máy tính, ảnh bên trái và danh sách bên phải. Trên điện thoại xếp dọc, ảnh trước.

Ảnh chính `IMG_4680-800.jpg`, ảnh phụ `IMG_4669-800.jpg`.

Danh sách sáu ý: ghế da ngả lưng, karaoke trên xe, nước uống miễn phí, khăn lạnh, điều hoà mát, đèn LED trang trí.

Chỉ đúng sáu ý này. Không thêm wifi, không thêm cổng sạc, vì nhà xe chưa xác nhận có.

### 3.5 Mục vì sao chọn Hiếu Thơ

Nền `--surface` trải hết chiều ngang, để tách khỏi hai mục kề bên.

Bốn ý, mỗi ý một dòng có dấu nhấn vàng ở đầu, nội dung lấy từ mục 6.6 của đặc tả.

### 3.6 Mục khu vực

Nhãn KHU VỰC, tiêu đề "Chạy khắp Quảng Bình và Quảng Trị".

Mười viên thuốc viền mảnh: Đồng Hới, Phong Nha, Kẻ Bàng, Đông Hà, Cửa Việt, Cửa Tùng, Thành cổ Quảng Trị, Lao Bảo, Huế, Đà Nẵng. Các viên tự xuống dòng khi hết chỗ.

Kèm một câu: nhận cả tuyến ngoài danh sách, gọi hotline để báo giá theo lộ trình.

Không nhúng bản đồ.

## Tiêu chí xong

- [ ] Năm mục hiện đúng thứ tự, khoảng cách giữa các mục đều nhau
- [ ] Tab đội xe chuyển đúng, mở trang lần đầu là tab limousine 9 chỗ
- [ ] Chuyển tab bằng phím Tab và phím mũi tên hoạt động, viền tiêu điểm thấy rõ
- [ ] Tắt JavaScript, cả năm panel đội xe đều hiện và đọc được
- [ ] Ảnh trong tab không méo, mọi tab cao bằng nhau
- [ ] Mọi ảnh có `alt` tiếng Việt mô tả đúng chiếc xe trong ảnh
- [ ] Ở 360 pixel, lưới dịch vụ vẫn hai cột và chữ không tràn thẻ

## Cạm bẫy

Đặt `alt` cho ảnh xe phải mô tả thật, ví dụ "Xe limousine Hyundai Solati 9 chỗ màu bạc của nhà xe Hiếu Thơ", không viết "ảnh xe 1".

Hàng tab cuộn ngang dễ bị tưởng là đứng yên vì không ai thấy nó cuộn được. Để tab cuối hở một phần ra mép màn hình, thành ra khách hiểu là còn nữa.
