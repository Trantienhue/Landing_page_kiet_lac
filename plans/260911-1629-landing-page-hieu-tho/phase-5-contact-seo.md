# Giai đoạn 5 — Liên hệ, chỗ trống và tối ưu tìm kiếm

## Mục tiêu

Đóng phần cuối trang, gom mọi chỗ còn thiếu vào một nơi dễ tìm, và làm cho liên kết dán vào Zalo hay Facebook hiện ra đẹp.

## Việc cần làm

### 5.1 Mục liên hệ

Số 0888 666 373 in cỡ lớn, là thẻ `<a href="tel:+84888666373">`, dưới đó là nút Zalo trỏ tới `https://zalo.me/0888666373` với `target="_blank"` và `rel="noopener"`.

Hai dòng dành cho địa chỉ và Facebook, mang thuộc tính `hidden` sẵn:

```html
<p hidden data-fill="DIA_CHI_CAN_DIEN">Địa chỉ: <span>...</span></p>
<a hidden data-fill="FACEBOOK_CAN_DIEN" href="#">Facebook nhà xe</a>
```

Khi chưa điền, trang không hiện dòng trống và không có liên kết hỏng.

### 5.2 Chân trang

Tên đầy đủ "Dịch vụ xe du lịch Hiếu Thơ", dòng bản quyền, và khoảng trống đáy đủ để thanh gọi nổi không che.

### 5.3 Khối chú thích chỗ trống

Đặt ngay đầu file, trước thẻ `<style>`, nguyên văn như mục 9 của đặc tả. Ba chuỗi đánh dấu `DIA_CHI_CAN_DIEN`, `FACEBOOK_CAN_DIEN`, `ANH_16_CHO_CAN_DIEN` phải tìm được bằng chức năng tìm chữ của bất kỳ trình soạn thảo nào.

### 5.4 Thẻ meta

| Thẻ | Nội dung |
| --- | --- |
| `title` | Cho thuê xe du lịch Quảng Bình Quảng Trị \| Dịch vụ xe du lịch Hiếu Thơ |
| `description` | Nêu limousine 9 chỗ, xe 4, 7, 16, 29 chỗ, tour, đưa đón, cưới hỏi, kèm số hotline, dưới 160 ký tự |
| `og:title`, `og:description` | Lấy lại từ hai thẻ trên |
| `og:image` | `images/optimized/IMG_4678-1600.jpg`, khai báo kèm `og:image:width` và `og:image:height` |
| `og:type`, `og:locale` | `website`, `vi_VN` |
| `theme-color` | `#0E0E10` |

Zalo và Facebook đọc `og:image` bằng đường dẫn tuyệt đối. Khi biết tên miền, đổi sang đường dẫn đầy đủ. Trước mắt để đường dẫn tương đối và ghi chú rõ chỗ cần sửa.

### 5.5 Dữ liệu có cấu trúc

Một khối `application/ld+json` kiểu `AutoRental`:

```json
{
  "@context":"https://schema.org",
  "@type":"AutoRental",
  "name":"Dịch vụ xe du lịch Hiếu Thơ",
  "telephone":"+84888666373",
  "areaServed":["Quảng Bình","Quảng Trị"]
}
```

Chưa khai báo `address` cho tới khi có địa chỉ thật. Khai báo địa chỉ giả làm hỏng độ tin cậy với công cụ tìm kiếm.

### 5.6 Xác nhận Zalo

Hỏi chủ xe số 0888 666 373 đã đăng ký Zalo chưa, và mở thử `https://zalo.me/0888666373` trên điện thoại.

Nếu không mở được hồ sơ, gỡ nút Zalo khỏi cả ba chỗ là ảnh đầu trang, thanh gọi nổi, và mục liên hệ, rồi cho nút gọi chiếm hết chiều ngang. Đừng để lại nút dẫn tới trang trống.

## Tiêu chí xong

- [ ] Số hotline bấm được ở cả ba chỗ trên trang
- [ ] Ba dòng chỗ trống đều đang ẩn, tìm được bằng chuỗi đánh dấu
- [ ] Dán liên kết vào Zalo và Facebook hiện đúng tiêu đề, mô tả và ảnh
- [ ] Khối dữ liệu có cấu trúc qua được công cụ kiểm tra của Google, không lỗi
- [ ] Câu hỏi về Zalo đã có câu trả lời và đã xử lý theo câu trả lời đó

## Cạm bẫy

Số điện thoại trong thẻ `tel:` phải viết dạng quốc tế `+84888666373`, bỏ số 0 đầu. Viết `tel:0888666373` thì khách đang roaming sẽ gọi hụt.
