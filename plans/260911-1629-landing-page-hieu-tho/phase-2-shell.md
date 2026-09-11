# Giai đoạn 2 — Khung trang và hệ thiết kế

## Mục tiêu

Dựng bộ xương `index.html` với toàn bộ biến CSS, thanh đầu trang, ảnh đầu trang và thanh gọi nổi. Sau giai đoạn này, cảm giác thị giác của trang đã chốt, các giai đoạn sau chỉ đổ nội dung vào.

## Việc cần làm

### 2.1 Bộ xương tài liệu

```html
<!doctype html>
<html lang="vi">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- thẻ meta và schema làm ở giai đoạn 5 -->
  <style> ... </style>
</head>
<body>
  <header>...</header>
  <main>
    <section id="hero">...</section>
    <!-- các mục khác thêm ở giai đoạn 3, 4, 5 -->
  </main>
  <div id="callbar">...</div>
  <script> ... </script>
</body>
</html>
```

Mỗi mục của trang là một thẻ `<section>` có `id` riêng, đọc từ trên xuống đúng thứ tự hiển thị.

### 2.2 Biến CSS

Khai báo trên `:root`, đặt ngay đầu thẻ style, lấy đúng giá trị từ mục 5 của đặc tả:

```css
:root{
  --bg:#0E0E10; --surface:#17171B; --ink:#F5F3EF; --muted:#A6A29B;
  --gold:#D9B25F; --gold-deep:#B8923F; --line:rgba(217,178,95,.22);
  --pad:16px; --gap-sec:56px; --max:1120px; --r:12px;
}
@media (min-width:768px){ :root{ --gap-sec:88px } }
```

Trang chỉ có một chế độ tối. Tô nền rõ ràng trên `body`, không để trong suốt.

Font dùng bộ hệ thống, khai báo một lần trên `body`:

```css
font-family:system-ui,-apple-system,"Segoe UI",Roboto,"Helvetica Neue",sans-serif;
```

### 2.3 Lớp dùng chung

Khai báo một lần, mọi mục sau dùng lại:

| Lớp | Việc |
| --- | --- |
| `.wrap` | Giới hạn 1120 pixel, lề hai bên 16 pixel, căn giữa |
| `.sec` | Khoảng cách trên dưới bằng `--gap-sec` |
| `.lbl` | Nhãn mục chữ thưa màu vàng đồng, cỡ 12 pixel |
| `.h2` | Tiêu đề mục, đậm 800 |
| `.card` | Nền `--surface`, bo `--r`, viền mảnh |
| `.btn-gold` | Nút nền vàng đồng, chữ tối |
| `.btn-ghost` | Nút trong suốt viền vàng |

Lề hai bên đặt bằng `padding-inline` trên `.wrap`, không dùng thuộc tính `padding` viết tắt, để khoảng cách dọc không vô tình xoá lề ngang.

### 2.4 Thanh đầu trang

Dính trên cùng. Bên trái chữ HIẾU THƠ màu vàng đồng, bên phải số 0888 666 373 trong viên thuốc viền mảnh, là thẻ `<a href="tel:+84888666373">`.

Nền trong suốt lúc đầu, thêm lớp `.scrolled` có nền tối mờ khi cuộn quá 40 pixel. Dùng `IntersectionObserver` trên một phần tử mỏng đặt ở đỉnh trang, không lắng nghe sự kiện `scroll`, để không tính toán liên tục khi khách cuộn.

### 2.5 Ảnh đầu trang

Ảnh nền `images/optimized/IMG_4678-1600.jpg`, đặt bằng thẻ `<img>` phủ toàn khối với `object-fit:cover`, không dùng `background-image`, để trình duyệt tải sớm và để có thuộc tính `alt`.

Ảnh này là thứ duy nhất trên trang không có `loading="lazy"`, và nên thêm `fetchpriority="high"`.

Phủ lên một lớp chuyển sắc tối dần xuống đáy. Chiều cao khối bằng 88% chiều cao màn hình trên điện thoại, tối đa 720 pixel trên máy tính.

Chữ xếp từ trên xuống, lấy nguyên văn từ mục 6.2 của đặc tả:

- Nhãn: DỊCH VỤ XE DU LỊCH HIẾU THƠ
- Tiêu đề: Limousine 9 chỗ **hạng thương gia**, cụm sau tô vàng đồng
- Dòng phụ hai dòng: số chỗ, và khu vực
- Hai nút: Gọi 0888 666 373, và Nhắn Zalo

Dưới ảnh là dải mỏng hai ý: tài xế nhiều năm kinh nghiệm, và karaoke nước khăn lạnh.

### 2.6 Thanh gọi nổi

Chỉ hiện dưới 768 pixel. Dính đáy màn hình, hai nút chia đôi.

Thanh xuất hiện sau khi khách cuộn qua hết ảnh đầu trang. Dùng chung `IntersectionObserver` với mục 2.4, quan sát đáy khối ảnh đầu trang, không viết thêm bộ lắng nghe thứ hai.

Thêm khoảng trống bằng chiều cao thanh vào đáy `<body>`, để thanh không che chân trang khi cuộn hết.

## Tiêu chí xong

- [ ] Mở `index.html` bằng trình duyệt thấy đúng bản dựng đã duyệt ở bước brainstorm
- [ ] Ở 360, 414, 768 và 1440 pixel đều không có thanh cuộn ngang
- [ ] Thanh đầu trang đổi nền khi cuộn, không giật
- [ ] Thanh gọi nổi ẩn lúc đầu, hiện sau khi qua ảnh đầu trang, ẩn trên máy tính
- [ ] Bấm mọi nút gọi đều mở trình quay số đúng số
- [ ] Tắt JavaScript, trang vẫn đọc được và nút gọi vẫn chạy, thanh đầu trang đứng yên ở trạng thái trong suốt

## Cạm bẫy

Chiều cao `100vh` trên Safari điện thoại tính cả thanh địa chỉ, làm nội dung bị đẩy khuất. Dùng `100svh` và để `100vh` làm giá trị dự phòng cho trình duyệt cũ.

Thanh gọi nổi dính đáy dễ đè lên vùng vuốt của iPhone. Thêm `padding-bottom: env(safe-area-inset-bottom)`.
