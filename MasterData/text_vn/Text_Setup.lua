__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Setup = readonly({
  Setup_117381_SetupTitle = {
    Text = "Xem xét nhận dạng văn bản"
  },
  Setup_132685_SetupDesc = {
    Text = "Xem những câu chuyện nào đã được dịch thủ công trong cài đặt ngôn ngữ hiện tại."
  },
  Setup_132685_SetupTitle = {
    Text = "Hiển thị biểu tượng cho các chương đã hoàn thành bản dịch chính thức của \"Điều Tra Hành Động\""
  },
  Setup_134015_SetupTitle = {
    Text = "Thay đổi hình nền động màn hình đăng nhập"
  },
  Setup_148459_SetupDesc = {
    Text = "Khi tỷ lệ đồng điều đạt cấp 20, Thể thức tỉnh này sẽ hiển thị ngoại hình thẻ bài đặc biệt trong chiến đấu \"Điều tra\" hoặc \"đối đầu pha\"."
  },
  Setup_148459_SetupTitle = {
    Text = "Hiệu ứng \"Bạc Ảnh\""
  },
  Setup_18433_SetupTitle = {
    Text = "Chữ trong trò chơi"
  },
  Setup_18434_SetupTitle = {
    Text = "Khử răng cưa"
  },
  Setup_18436_SetupTitle = {
    Text = "Độ phân giải kết xuất"
  },
  Setup_18438_SetupTitle = {
    Text = "Đỏ xanh chệch"
  },
  Setup_18439_SetupTitle = {
    Text = "Hình chiếu"
  },
  Setup_18441_SetupTitle = {
    Text = "Linh phìpeptide phục hồi hoàn toàn"
  },
  Setup_18443_SetupTitle = {
    Text = "Xác nhận cơn thịnh nộ bùng phát và sử dụng lệnh khóa"
  },
  Setup_18444_SetupTitle = {
    Text = "Chất lượng hình ảnh"
  },
  Setup_18445_SetupTitle = {
    Text = "Độ sâu cảnh"
  },
  Setup_18448_SetupTitle = {
    Text = "Hiệu ứng môi trường"
  },
  Setup_18449_SetupTitle = {
    Text = "Trung tâm cá nhân"
  },
  Setup_18453_SetupTitle = {
    Text = "Giọng nói"
  },
  Setup_18454_SetupTitle = {Text = "Nhạc"},
  Setup_18455_SetupTitle = {
    Text = "Đã hoàn thành ủy thác"
  },
  Setup_18458_SetupTitle = {
    Text = "Ánh sáng thực tế"
  },
  Setup_18459_SetupTitle = {
    Text = "Hiệu ứng âm thanh"
  },
  Setup_18460_SetupTitle = {
    Text = "Điều khoản sử dụng"
  },
  Setup_18461_SetupTitle = {
    Text = "Cắt xén cạnh mờ nhòe"
  },
  Setup_18462_SetupTitle = {
    Text = "Âm lượng"
  },
  Setup_18463_SetupTitle = {
    Text = "Mã quy đổi"
  },
  Setup_18466_SetupTitle = {
    Text = "Chất lượng hiệu ứng"
  },
  Setup_18469_SetupDesc = {
    Text = "30 FPS tiết kiệm năng lượng hơn, 60 FPS mượt mà hơn."
  },
  Setup_18469_SetupTitle = {
    Text = "Tốc độ khung hình mục tiêu"
  },
  Setup_21931_SetupTitle = {
    Text = "Liên hệ hỗ trợ khách hàng"
  },
  Setup_24952_SetupDesc = {
    Text = "Khi bật, giao diện chính, giao diện điều tra, và các giao diện khác sẽ bị ảnh hưởng bởi cảm biến trọng lực."
  },
  Setup_24952_SetupTitle = {
    Text = "Cảm biến con quay"
  },
  Setup_54468_SetupTitle = {
    Text = "Cài đặt hình ảnh"
  },
  Setup_54469_SetupTitle = {
    Text = "Độ phân giải"
  },
  Setup_54664_SetupTitle = {
    Text = "Hiển thị phím tắt"
  },
  Setup_54673_SetupTitle = {
    Text = "Chọn 8 lá bài trong tay"
  },
  Setup_54674_SetupTitle = {
    Text = "Chọn lá bài số 9"
  },
  Setup_54675_SetupTitle = {
    Text = "Chọn lá bài thứ hai"
  },
  Setup_54676_SetupTitle = {
    Text = "Chọn 3 lá bài trên tay"
  },
  Setup_54677_SetupTitle = {
    Text = "Giải phóng lệnh khóa"
  },
  Setup_54678_SetupTitle = {
    Text = "Chọn bài trong tay số 6"
  },
  Setup_54679_SetupTitle = {
    Text = "Chọn 7 lá bài trên tay"
  },
  Setup_54680_SetupTitle = {
    Text = "Chọn 4 lá bài trong tay"
  },
  Setup_54681_SetupTitle = {
    Text = "Chọn 5 bài trong tay"
  },
  Setup_54682_SetupTitle = {
    Text = "Cơn thịnh nộ bùng phát 1"
  },
  Setup_54683_SetupTitle = {
    Text = "Cơn thịnh nộ bùng phát 2"
  },
  Setup_54684_SetupTitle = {
    Text = "Cơn thịnh nộ bùng phát lần thứ 3"
  },
  Setup_54685_SetupTitle = {
    Text = "Bùng phát điên cuồng 4"
  },
  Setup_54686_SetupTitle = {
    Text = "Xem rút bài từ bộ bài"
  },
  Setup_54687_SetupTitle = {
    Text = "Chọn 20 lá bài trong tay"
  },
  Setup_54688_SetupTitle = {
    Text = "Kết thúc lượt"
  },
  Setup_54689_SetupTitle = {
    Text = "Chọn lá bài 1"
  },
  Setup_54690_SetupTitle = {
    Text = "Hủy bỏ và thiết lập"
  },
  Setup_54691_SetupTitle = {
    Text = "Giải phóng khả năng giới vực 1"
  },
  Setup_54692_SetupTitle = {
    Text = "Chọn thẻ bài mười"
  },
  Setup_54693_SetupTitle = {
    Text = "Chọn 11 lá bài trên tay"
  },
  Setup_54694_SetupTitle = {
    Text = "Chọn thẻ bài số 12"
  },
  Setup_54695_SetupTitle = {
    Text = "Chọn bài trong tay 13"
  },
  Setup_54696_SetupTitle = {
    Text = "Chọn lá bài số 14"
  },
  Setup_54697_SetupTitle = {
    Text = "Chọn lá bài thứ 15"
  },
  Setup_54698_SetupTitle = {
    Text = "Chọn lá bài 16"
  },
  Setup_54699_SetupTitle = {
    Text = "Chọn thẻ bài 17"
  },
  Setup_54700_SetupTitle = {
    Text = "Chọn thẻ bài trên tay 18"
  },
  Setup_54701_SetupTitle = {
    Text = "Chọn thẻ bài 19"
  },
  Setup_55509_SetupTitle = {
    Text = "Thoát trò chơi"
  },
  Setup_70541_SetupTitle = {
    Text = "Phát nền"
  },
  Setup_72153_SetupTitle = {
    Text = "Kích hoạt khả năng giới vực 2"
  },
  Setup_94404_SetupTitle = {
    Text = "Xác nhận bài đánh"
  },
  Setup_94405_SetupTitle = {
    Text = "Lá bài trước"
  },
  Setup_94406_SetupTitle = {
    Text = "Lá bài tiếp theo"
  },
  Setup_94566_SetupTitle = {
    Text = "Bối cảnh động trong trận chiến"
  }
})
return Text_Setup
