# Giai đoạn 4 — Thư viện ảnh

## Mục tiêu

Lưới 15 ảnh và lớp phủ xem ảnh lớn. Đây là khối JavaScript lớn nhất của trang và là khối duy nhất gỡ đi được mà trang vẫn nguyên vẹn.

## Việc cần làm

### 4.1 Lưới ảnh

Hai cột dưới 768 pixel, bốn cột trên 768 pixel. Mỗi ô là khung vuông tỉ lệ 1:1, ảnh cắt theo `object-fit:cover`.

Toàn bộ 15 ảnh, dùng bản `-800.jpg`, đều có `loading="lazy"`, `decoding="async"`, và khai báo `width` với `height` để trang không giật khi ảnh tải xong.

Mỗi ô là một thẻ `<button>` chứ không phải `<div>`, để bấm được bằng phím và đọc được bằng trình đọc màn hình:

```html
<button data-lightbox="0" aria-label="Xem lớn: xe limousine Solati chụp chính diện">
  <img src="images/optimized/IMG_4666-800.jpg" alt="..." width="800" height="800" loading="lazy">
</button>
```

Thứ tự ảnh xếp theo câu chuyện, không theo số file: limousine ban ngày, limousine ban đêm, nội thất, xe 29 chỗ, xe đen, xe con.

### 4.2 Lớp phủ xem ảnh lớn

Dựng bằng `<dialog>`, để trình duyệt lo phần khoá tiêu điểm và phím Esc thay mình.

Lớp phủ chứa ảnh bản `-1600.jpg`, nút đóng ở góc trên phải, và hai nút mũi tên trái phải. Nền phủ tối đậm.

Hành vi bắt buộc:

| Thao tác | Kết quả |
| --- | --- |
| Bấm một ô lưới | Mở lớp phủ đúng ảnh đó |
| Phím Esc | Đóng |
| Bấm ra ngoài ảnh | Đóng |
| Phím mũi tên trái phải | Chuyển ảnh, quay vòng ở hai đầu |
| Vuốt ngang trên điện thoại | Chuyển ảnh |
| Khi lớp phủ mở | Trang nền khoá cuộn |
| Khi đóng | Tiêu điểm quay về đúng ô vừa bấm |

Ảnh bản 1600 pixel chỉ tải khi lớp phủ mở, gán `src` lúc mở chứ không đặt sẵn trong HTML. Nếu đặt sẵn 15 ảnh lớn thì trang nặng thêm vài megabyte và phá vỡ ngân sách 600 KB.

Vuốt ngang bắt bằng `pointerdown` và `pointerup`, ngưỡng 40 pixel theo trục ngang, bỏ qua nếu độ lệch dọc lớn hơn độ lệch ngang, để không cướp thao tác cuộn của khách.

### 4.3 Ranh giới của khối

Khối JavaScript thư viện ảnh chỉ nói chuyện với các phần tử mang `data-lightbox` và `<dialog>` của nó. Không gọi hàm nào của khối tab, không đụng vào biến toàn cục nào ngoài của mình. Xoá cả khối thì lưới ảnh vẫn hiện, chỉ mất chức năng xem lớn.

## Tiêu chí xong

- [ ] Lưới hiện đủ 15 ảnh, ô nào cũng vuông, ảnh không méo
- [ ] Mở, chuyển, đóng được bằng chuột, bằng phím, và bằng cảm ứng
- [ ] Đóng xong tiêu điểm quay về đúng ô vừa bấm
- [ ] Cuộn trang bị khoá khi lớp phủ mở, mở lại bình thường khi đóng
- [ ] Vuốt dọc trong lớp phủ không vô tình chuyển ảnh
- [ ] Ảnh lớn chỉ tải khi mở, kiểm bằng tab Network của trình duyệt
- [ ] Tắt JavaScript, lưới vẫn hiện đủ 15 ảnh

## Cạm bẫy

`<dialog>` mở bằng `showModal()` có nền phủ mặc định là lớp giả `::backdrop`, tô màu ở đó chứ đừng dựng thêm một thẻ div phủ nữa.

Khoá cuộn bằng `overflow:hidden` trên `body` làm trang nhảy vì mất thanh cuộn trên máy tính. Bù lại bằng `scrollbar-gutter: stable` trên `html`.
