# Giai đoạn 6 — Kiểm thử và tinh chỉnh

## Mục tiêu

Chạy hết danh sách kiểm thử ở mục 11 của đặc tả trên thiết bị thật, sửa những gì chưa đạt, rồi bàn giao.

## Việc cần làm

### 6.1 Kiểm trên trình duyệt máy tính

Mở `index.html` trực tiếp bằng đường dẫn file, không qua máy chủ. Đổi chiều rộng cửa sổ lần lượt 360, 414, 768 và 1440 pixel, mỗi lần cuộn hết trang và soi:

- Có thanh cuộn ngang không
- Chữ có tràn khỏi thẻ không
- Ảnh có méo không
- Khoảng cách giữa các mục có đều không

### 6.2 Kiểm bằng bàn phím

Nhấn phím Tab đi hết trang từ đầu tới cuối. Mọi nút và liên kết phải thấy rõ viền tiêu điểm, thứ tự đi phải khớp thứ tự nhìn thấy, và không có bẫy tiêu điểm nào ngoài lớp phủ ảnh.

### 6.3 Kiểm trên điện thoại thật

Đây là phần không thay thế được bằng chế độ giả lập của trình duyệt:

- Bấm nút gọi, trình quay số phải mở với đúng số 0888 666 373
- Bấm nút Zalo, ứng dụng Zalo phải mở
- Thanh gọi nổi không đè lên vùng vuốt ở đáy iPhone
- Vuốt chuyển ảnh trong lớp phủ chạy mượt
- Chữ đọc được khi ra ngoài nắng

### 6.4 Kiểm khi tắt JavaScript

Tắt JavaScript trong cài đặt trình duyệt rồi tải lại. Toàn bộ chữ phải đọc được, mọi panel đội xe đều hiện, lưới ảnh đủ 15 tấm, và nút gọi vẫn hoạt động.

### 6.5 Đo dung lượng và tốc độ

Mở tab Network, xoá bộ nhớ đệm, tải lại và đọc tổng dung lượng. Ngân sách là dưới 600 KB.

Chạy Lighthouse ở chế độ điện thoại. Mục tiêu điểm hiệu năng từ 90 trở lên.

Nếu chưa đạt, sửa theo thứ tự này, dừng ngay khi đủ:

1. Kiểm lại mọi ảnh dưới ảnh đầu trang đều có `loading="lazy"`
2. Giảm ảnh đầu trang từ bản 1600 xuống bản 1200 pixel
3. Hạ chất lượng nén ảnh lưới từ 60 xuống 50
4. Giảm số ảnh trong lưới từ 15 xuống 12, bỏ những tấm trùng ý

Đừng đụng tới cấu trúc HTML hay CSS để chạy theo điểm số. Ảnh là thứ duy nhất đáng tối ưu ở đây.

### 6.6 Soát lại chữ

Đọc to toàn bộ chữ trên trang một lượt. Soát dấu tiếng Việt, soát số điện thoại xuất hiện ở mọi chỗ đều đúng, và soát xem có câu nào hứa điều nhà xe chưa xác nhận không.

Đặc biệt kiểm: không có chữ nào nhắc tới giá, wifi, cổng sạc, hay số năm kinh nghiệm cụ thể.

### 6.7 Bàn giao

Ghi một file `README.md` ngắn ở gốc dự án, nói ba điều:

- Sửa nội dung thì mở `index.html` và gõ, không cần cài gì
- Ba chỗ cần điền, tìm bằng chuỗi nào
- Thêm ảnh mới thì bỏ vào `images/` rồi chạy `./tools/build-images.sh`

## Tiêu chí xong

Mười hai mục trong danh sách ở mục 11 của đặc tả đều đã tích, cộng thêm:

- [ ] `README.md` đã viết
- [ ] Đã chạy thử trên ít nhất một điện thoại Android và một iPhone
- [ ] Đã commit toàn bộ vào git

## Cạm bẫy

Lighthouse chấm điểm khác nhau giữa hai lần chạy liên tiếp. Chạy ba lần và lấy điểm giữa, đừng đuổi theo một con số duy nhất.

Mở file bằng đường dẫn `file://` thì một số tính năng như dữ liệu có cấu trúc không kiểm được. Phần đó kiểm sau khi đã đưa lên Netlify.
