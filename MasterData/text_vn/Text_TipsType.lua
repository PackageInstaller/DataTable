__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_TipsType = readonly({
  TipsType_100001_Desc = {
    Text = "Sau khi thay đổi độ phân giải, cần khởi động lại ứng dụng để có hiệu lực. Bạn có chắc chắn không?"
  },
  TipsType_100001_LeftBtnDesc = {Text = "Hủy"},
  TipsType_100001_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_100001_Title = {
    Text = "Chuyển đổi độ phân giải - Xác nhận"
  },
  TipsType_100002_Desc = {
    Text = "Đang chờ {s1} nhận lời mời chơi thêm một ván"
  },
  TipsType_100002_RightBtnDesc = {Text = "Hủy"},
  TipsType_100002_Title = {
    Text = "Chơi lại một ván"
  },
  TipsType_100003_Desc = {
    Text = "{s1} mời bạn chơi thêm một lượt"
  },
  TipsType_100003_LeftBtnDesc = {
    Text = "Từ chối"
  },
  TipsType_100003_RightBtnDesc = {
    Text = "Chấp nhận"
  },
  TipsType_100003_Title = {
    Text = "Chơi lại một ván"
  },
  TipsType_100004_Desc = {
    Text = "Đã là nền hiện tại của phòng ký túc"
  },
  TipsType_100005_Desc = {
    Text = "Chế độ đối đầu pha chưa kích hoạt"
  },
  TipsType_100006_Desc = {
    Text = "Đối phương chưa kích hoạt chế độ đối đầu pha"
  },
  TipsType_100007_Desc = {
    Text = "Cần theo dõi lẫn nhau để tổ chức trận đấu thân hữu"
  },
  TipsType_100008_Desc = {
    Text = "Đối phương đã ngoại tuyến"
  },
  TipsType_100009_Desc = {
    Text = "Đối phương đang khám phá"
  },
  TipsType_100010_Desc = {
    Text = "Trận đấu giao hữu hết thời gian chờ"
  },
  TipsType_100011_Desc = {
    Text = "Bạn đã hủy đấu giao hữu"
  },
  TipsType_100012_Desc = {
    Text = "Mời giao hữu bị từ chối"
  },
  TipsType_100012_LeftBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_100012_Title = {Text = "Gợi ý"},
  TipsType_100013_Desc = {
    Text = "Đối phương đã ngoại tuyến"
  },
  TipsType_100014_Desc = {
    Text = "Đối phương đã chuyển sang lối chơi khác"
  },
  TipsType_100015_Desc = {
    Text = "Mời quá thường xuyên, hãy thử lại sau {s1}giây"
  },
  TipsType_100016_Desc = {
    Text = "Người chơi đã hủy bỏ trận giao hữu"
  },
  TipsType_100016_LeftBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_100016_Title = {Text = "Gợi ý"},
  TipsType_100017_Desc = {
    Text = "Người chơi đang chơi trận đấu giao hữu"
  },
  TipsType_100017_LeftBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_100017_Title = {Text = "Gợi ý"},
  TipsType_100018_Desc = {
    Text = "Đội hình này bao gồm thẻ sử dụng có thời hạn, cần mở khóa chủ đề cốt lõi để tiếp tục sử dụng, hy vọng có thể chiến đấu bên bạn lần nữa!\nBạn có muốn tiến đến mở khóa chủ đề cốt lõi không?"
  },
  TipsType_100018_LeftBtnDesc = {Text = "Hủy"},
  TipsType_100018_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_100018_Title = {
    Text = "Chủ đề cốt lõi đã hết hạn"
  },
  TipsType_10001_Desc = {
    Text = "Thao tác thành công"
  },
  TipsType_100020_Desc = {
    Text = "Còn đang trong chiến đấu, có tiếp tục chiến đấu trước đó không?"
  },
  TipsType_100020_LeftBtnDesc = {Text = "Hủy"},
  TipsType_100020_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_100020_Title = {Text = "Gợi ý"},
  TipsType_10002_Desc = {
    Text = "Lỗi bảng cấu hình"
  },
  TipsType_10003_Desc = {
    Text = "Lỗi truyền dữ liệu từ máy khách"
  },
  TipsType_10004_Desc = {
    Text = "Máy chủ chưa khởi động"
  },
  TipsType_10005_Desc = {
    Text = "Lỗi dữ liệu nhân vật"
  },
  TipsType_10006_Desc = {
    Text = "Không có dữ liệu về thân thể được đánh thức"
  },
  TipsType_10007_Desc = {
    Text = "Thân thể được đánh thức đã đạt cấp độ tối đa"
  },
  TipsType_10008_Desc = {
    Text = "Không có đủ điểm đề tài"
  },
  TipsType_10009_Desc = {
    Text = "Cơ thể thức tỉnh chưa đạt cấp độ cao nhất, không thể khởi linh"
  },
  TipsType_100100_Desc = {
    Text = "Trò chơi hiện có bản cập nhật phiên bản, nếu không tự động cập nhật, vui lòng thử khởi động lại Steam và kiểm tra cập nhật."
  },
  TipsType_100100_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_100100_Title = {
    Text = "Thông báo cập nhật"
  },
  TipsType_10010_Desc = {
    Text = "Hoàn tất khởi linh"
  },
  TipsType_10011_Desc = {
    Text = "Hiện chưa có nhân vật"
  },
  TipsType_10012_Desc = {
    Text = "Nhân vật hiện tại đã có"
  },
  TipsType_10013_Desc = {
    Text = "Tên nhân vật trùng tên"
  },
  TipsType_10014_Desc = {
    Text = "Lỗi khu vực thâm cảnh"
  },
  TipsType_10015_Desc = {
    Text = "Không thể định vị khu vực thâm cảnh"
  },
  TipsType_10016_Desc = {
    Text = "Thể lực hiện tại quá thấp"
  },
  TipsType_10017_Desc = {
    Text = "{s1} đến {s2} sẽ được mở khóa"
  },
  TipsType_10018_Desc = {
    Text = "Sau khi đến tầng thứ hai của thâm cảnh này 1 lần, có thể thực hiện điều tra nhanh chóng"
  },
  TipsType_10019_Desc = {
    Text = "Sự kiện đã hoàn thành"
  },
  TipsType_10020_Desc = {
    Text = "Loại trong bảng cấu hình sự kiện bị sai"
  },
  TipsType_10021_Desc = {
    Text = "Sự kiện không tồn tại"
  },
  TipsType_10022_Desc = {
    Text = "Không đủ Dấu Đen để mua"
  },
  TipsType_10023_Desc = {
    Text = "Thẻ này không thể được tăng cường"
  },
  TipsType_10024_Desc = {
    Text = "Thẻ này đã đạt tối đa tăng cường"
  },
  TipsType_10025_Desc = {
    Text = "Thương nhân không bán mặt hàng này"
  },
  TipsType_10026_Desc = {
    Text = "Không có phần thưởng này"
  },
  TipsType_10027_Desc = {
    Text = "Đã nhận phần thưởng"
  },
  TipsType_10028_Desc = {
    Text = "Lỗi dữ liệu sự kiện"
  },
  TipsType_10029_Desc = {
    Text = "Sản phẩm đã mua"
  },
  TipsType_10030_Desc = {
    Text = "Năng lượng hiện tại không đủ để kích hoạt cổng dịch chuyển, cần {s1} điểm năng lượng để khởi động cổng dịch chuyển."
  },
  TipsType_10031_Desc = {
    Text = "Không tìm thấy sự kiện đối thoại cốt truyện"
  },
  TipsType_10032_Desc = {
    Text = "Số lượng thẻ lệnh sự kiện không đủ"
  },
  TipsType_10033_Desc = {
    Text = "Số lượng thẻ lệnh chọn sự kiện quá nhiều"
  },
  TipsType_10034_Desc = {
    Text = "Sự kiện, chọn thẻ lệnh không tồn tại"
  },
  TipsType_10035_Desc = {
    Text = "Hệ thống sự kiện ngẫu nhiên không có dữ liệu"
  },
  TipsType_10036_Desc = {
    Text = "Thương nhân không bán mặt hàng này"
  },
  TipsType_10037_Desc = {
    Text = "Không đủ số lượng vật phẩm sáng tạo"
  },
  TipsType_10038_Desc = {
    Text = "Sự kiện chọn số lượng vật tạo quá nhiều"
  },
  TipsType_10039_Desc = {
    Text = "Sự kiện lựa chọn tạo vật không tồn tại"
  },
  TipsType_10040_Desc = {
    Text = "Không tìm thấy nút sự kiện này"
  },
  TipsType_10041_Desc = {
    Text = "Bạn đã dùng hết số lần làm mới của thương nhân"
  },
  TipsType_10042_Desc = {
    Text = "Số lần làm mới thẻ lệnh rơi ra trong chiến đấu đã hết"
  },
  TipsType_10043_Desc = {
    Text = "Số lần làm mới vật phẩm sáng tạo trong chiến đấu đã hết"
  },
  TipsType_10044_Desc = {
    Text = "Chức năng điểm liên lạc bị khóa lại"
  },
  TipsType_10045_Desc = {
    Text = "Khu vực sự kiện không khớp! Khu vực hiện tại: {s1}, khu vực cấu hình sự kiện: {s2}"
  },
  TipsType_10046_Desc = {
    Text = "Số lần xóa thẻ bài trong cửa hàng sự kiện đã hết"
  },
  TipsType_10047_Desc = {
    Text = "Không tìm thấy dữ liệu bài học"
  },
  TipsType_10048_Desc = {
    Text = "Đơn vị đã được gửi, không cần gửi lại"
  },
  TipsType_10049_Desc = {
    Text = "Các chủ đề trong đơn vị này chưa hoàn thành hết, chưa thể nộp được"
  },
  TipsType_10050_Desc = {
    Text = "Không tìm thấy mô-đun bài học"
  },
  TipsType_10051_Desc = {
    Text = "Cấp độ không có dữ liệu nhiệm vụ"
  },
  TipsType_10052_Desc = {
    Text = "Không có nhiệm vụ tương ứng với thâm cảnh này"
  },
  TipsType_10053_Desc = {
    Text = "Điểm tín chỉ không đủ, không thể nhận thưởng"
  },
  TipsType_10054_Desc = {
    Text = "Chưa đạt điều kiện để nhận phần thưởng tín chỉ"
  },
  TipsType_10055_Desc = {
    Text = "Chưa tìm thấy nhiệm vụ liên quan đến chủ đề này"
  },
  TipsType_10056_Desc = {
    Text = "Đề tài nhiệm vụ nhỏ đã hoàn thành"
  },
  TipsType_10057_Desc = {
    Text = "Các sub-task (nhiệm vụ phụ) trong phân công đề tài chưa được hoàn thành"
  },
  TipsType_10058_Desc = {
    Text = "NPC đã được kích hoạt"
  },
  TipsType_10059_Desc = {
    Text = "Lỗi dữ liệu NPC"
  },
  TipsType_10060_Desc = {
    Text = "NPC không tồn tại"
  },
  TipsType_10061_Desc = {
    Text = "Trong thâm cảnh không phát hiện"
  },
  TipsType_10062_Desc = {
    Text = "Không tìm thấy dữ liệu cộng hưởng"
  },
  TipsType_10063_Desc = {
    Text = "Cộng hưởng đã đạt cấp độ tối đa"
  },
  TipsType_10064_Desc = {
    Text = "Không tìm thấy dữ liệu liên quan đến cấp độ cộng hưởng"
  },
  TipsType_10065_Desc = {
    Text = "Không có lần đặt lại"
  },
  TipsType_10066_Desc = {
    Text = "Chưa đạt điều kiện kích hoạt cộng hưởng"
  },
  TipsType_10067_Desc = {
    Text = "Hạt cảm ứng thiếu"
  },
  TipsType_10068_Desc = {
    Text = "Khởi linh đã hoàn thành, không thể thực hiện lại việc khởi linh"
  },
  TipsType_10069_Desc = {
    Text = "Thiếu vật phẩm cần thiết để khởi linh"
  },
  TipsType_10070_Desc = {
    Text = "Không đủ vật liệu để nâng cấp thân thể được đánh thức"
  },
  TipsType_10071_Desc = {
    Text = "Thiếu phiếu vàng để nâng cấp thân thể được đánh thức"
  },
  TipsType_10072_Desc = {
    Text = "Thiếu phiếu vàng để nâng cấp thân thể được đánh thức"
  },
  TipsType_10073_Desc = {
    Text = "Kỹ năng thể thức tỉnh"
  },
  TipsType_10074_Desc = {
    Text = "Chưa mở khóa kỹ năng thân thể được đánh thức"
  },
  TipsType_10075_Desc = {
    Text = "Không đủ\"Bạc tâm\"để thức tỉnh"
  },
  TipsType_10076_Desc = {
    Text = "Vật phẩm không đủ"
  },
  TipsType_10077_Desc = {
    Text = "Số lần mua hôm nay đã đạt đến giới hạn"
  },
  TipsType_10078_Desc = {
    Text = "Vật phẩm không thể dùng"
  },
  TipsType_10079_Desc = {
    Text = "Số lượng vật phẩm sử dụng sai"
  },
  TipsType_10080_Desc = {
    Text = "Kỹ năng đã đạt cấp tối đa"
  },
  TipsType_10081_Desc = {
    Text = "Vật liệu không đủ, không thể nâng cấp."
  },
  TipsType_10082_Desc = {
    Text = "Không đủ tiền để nâng cấp đâu."
  },
  TipsType_10083_Desc = {
    Text = "Tỷ lệ kết nối thân thể được đánh thức đã đạt tới mức tối đa"
  },
  TipsType_10084_Desc = {
    Text = "Thân thể được đánh thức này thiếu tinh thần cùng nguồn gốc"
  },
  TipsType_10085_Desc = {
    Text = "Đường nâng cấp không có ID nhân vật đã cấu hình"
  },
  TipsType_10086_Desc = {
    Text = "Không tìm thấy thông tin thẻ độc quyền"
  },
  TipsType_10087_Desc = {
    Text = "Thẻ độc quyền chưa được mở khóa"
  },
  TipsType_10088_Desc = {
    Text = "Không tìm thấy uuid của thẻ độc quyền này"
  },
  TipsType_10089_Desc = {
    Text = "Phần thưởng chương chưa đạt số điểm yêu cầu"
  },
  TipsType_10090_Desc = {
    Text = "Bạn đã nhận phần thưởng chương"
  },
  TipsType_10091_Desc = {
    Text = "Cốt truyện đã chọn chưa được mở khóa"
  },
  TipsType_10092_Desc = {
    Text = "Bản sao được chọn chưa được mở khóa"
  },
  TipsType_10093_Desc = {
    Text = "Khu vực phụ bản chưa được mở khóa"
  },
  TipsType_10094_Desc = {
    Text = "Cốt truyện dọn chưa được mở khóa"
  },
  TipsType_10095_Desc = {
    Text = "Không tìm thấy cốt truyện cho thử thách bản sao"
  },
  TipsType_10096_Desc = {
    Text = "Không tìm thấy nhiệm vụ cốt truyện của bản sao thử thách"
  },
  TipsType_10097_Desc = {
    Text = "Nhiệm vụ thách thức đã hoàn thành, không thể nhận lại phần thưởng"
  },
  TipsType_10098_Desc = {
    Text = "Nhiệm vụ thách thức chưa hoàn thành, chưa thể nhận phần thưởng"
  },
  TipsType_10099_Desc = {
    Text = "Công trình không tồn tại"
  },
  TipsType_10100_Desc = {
    Text = "Công trình đã đạt cấp độ tối đa"
  },
  TipsType_10101_Desc = {
    Text = "Điều kiện nâng cấp/xây dựng công trình không đủ"
  },
  TipsType_10102_Desc = {
    Text = "Công trình đã tồn tại, không thể xây dựng thêm"
  },
  TipsType_10103_Desc = {
    Text = "Không đủ đạo cụ để nâng cấp/xây dựng"
  },
  TipsType_10104_Desc = {
    Text = "Vị trí đã có thân thể được đánh thức, không thể nhập trú"
  },
  TipsType_10105_Desc = {
    Text = "Không đủ nguyên liệu khác để tổng hợp"
  },
  TipsType_10106_Desc = {
    Text = "Không đủ tiền tệ để chế tạo đạo cụ"
  },
  TipsType_10107_Desc = {
    Text = "Đạo cụ chế tạo chưa mở khóa"
  },
  TipsType_10108_Desc = {
    Text = "Kết nối đến máy chủ thất bại, vui lòng kiểm tra kết nối mạng và thử lại sau"
  },
  TipsType_10109_Desc = {
    Text = "Chức năng đã chọn tại trại không thể được chọn lại"
  },
  TipsType_10110_Desc = {
    Text = "Các tính năng của trại đã hết lượt sử dụng"
  },
  TipsType_10111_Desc = {
    Text = "Thẻ độc quyền chưa nâng cấp không thể thay đổi"
  },
  TipsType_10112_Desc = {
    Text = "Thẻ đặc biệt không có sự thay đổi nên không thể chuyển đổi"
  },
  TipsType_10113_Desc = {
    Text = "Việc chuyển đổi thẻ độc quyền đã thất bại"
  },
  TipsType_10114_Desc = {
    Text = "Nhận được thân thể được đánh thức {s1}"
  },
  TipsType_10115_Desc = {
    Text = "Nhận được lần nữa {s1}, đã chuyển thành {s2}{s3}"
  },
  TipsType_10116_Desc = {
    Text = "{s1}tín vật vượt quá giới hạn, đã chuyển thành {s2}{s3}"
  },
  TipsType_10117_Desc = {
    Text = "Bản ghi tải lên thành công"
  },
  TipsType_10118_Desc = {
    Text = "Lệnh không khớp, hiện đang chờ lệnh {s1}, nhưng đã nhập {s2}"
  },
  TipsType_10119_Desc = {
    Text = "Mất thẻ bài: {s1}, uid: {s2}"
  },
  TipsType_10120_Desc = {
    Text = "Không thể giải phóng"
  },
  TipsType_10121_Desc = {
    Text = "Không có kỹ năng này"
  },
  TipsType_10122_Desc = {
    Text = "Kỹ năng đang trong thời gian hồi chiêu"
  },
  TipsType_10123_Desc = {
    Text = "Số lần sử dụng kỹ năng đã hết"
  },
  TipsType_10124_Desc = {
    Text = "Kiểm tra thứ tự nâng cấp các công trình liên quan đến Tid {s1} liệu có tạo thành vòng lặp hay không"
  },
  TipsType_10125_Desc = {
    Text = "Kiểm tra xem tòa nhà Tid {s1} có cấu hình liên quan không"
  },
  TipsType_10126_Desc = {
    Text = "Xây dựng Tid {s1} cấp độ thực tế nên là {s2}, được cấu hình là {s3}"
  },
  TipsType_10127_Desc = {
    Text = "Không tìm thấy thiết lập loại kiến trúc"
  },
  TipsType_10128_Desc = {
    Text = "Không tìm thấy cấu hình công trình, hoặc không có kiểu công trình"
  },
  TipsType_10129_Desc = {
    Text = "Dòng cốt truyện này chưa mở nhiệm vụ phân công"
  },
  TipsType_10130_Desc = {
    Text = "Gỡ bỏ thành công"
  },
  TipsType_10131_Desc = {
    Text = "Đã tăng thành công \"Linh Phi Peptide\" × {s1}"
  },
  TipsType_10132_Desc = {Text = "Sửa xong"},
  TipsType_10133_Desc = {
    Text = "GM thêm đạo cụ dựa trên tên đạo cụ [\"..arg1..\"] không thể tìm thấy đạo cụ phù hợp"
  },
  TipsType_10134_Desc = {
    Text = "Sự kiện [ ..arg1.. ] không tồn tại"
  },
  TipsType_10135_Desc = {
    Text = "Hiện tại: Nhấn {s1}"
  },
  TipsType_10136_Desc = {
    Text = "Kỹ năng nâng cấp thành công"
  },
  TipsType_10137_Desc = {
    Text = "Tạo thành công"
  },
  TipsType_10138_Desc = {
    Text = "Thời gian máy chủ đã được sửa đổi thành công"
  },
  TipsType_10139_Desc = {
    Text = "Sửa đổi thời gian máy chủ không thành công"
  },
  TipsType_10140_Desc = {
    Text = "Số lượng công trình: 17\nPhiên bản tạm thời chỉ mở một số công trình"
  },
  TipsType_10141_Desc = {
    Text = "Chưa đạt điều kiện mở khóa kiến trúc"
  },
  TipsType_10142_Desc = {
    Text = "Xây dựng: giao diện {s1} không tồn tại {s2}"
  },
  TipsType_10143_Desc = {
    Text = "Công thức tổng hợp này chưa được mở khóa"
  },
  TipsType_10144_Desc = {
    Text = "Thiếu nguyên liệu"
  },
  TipsType_10145_Desc = {
    Text = "Tổng hợp thành công"
  },
  TipsType_10146_Desc = {
    Text = "Nâng cấp thành công"
  },
  TipsType_10147_Desc = {
    Text = "Vì khung quái vật trống, không thể vào chiến đấu"
  },
  TipsType_10148_Desc = {
    Text = "\"Linh Phi Peptide\" phục hồi"
  },
  TipsType_10149_Desc = {
    Text = "ID nhân vật đã bị trùng, vui lòng kiểm tra lại, không thể tham gia chiến đấu"
  },
  TipsType_10150_Desc = {
    Text = "ID{s1} không tồn tại, không thể tham gia chiến đấu"
  },
  TipsType_10151_Desc = {
    Text = "Quái vật không có kỹ năng tương ứng"
  },
  TipsType_10152_Desc = {
    Text = "Chưa được mở"
  },
  TipsType_10153_Desc = {
    Text = "Hiện tại không có thẻ bài trong bộ bài"
  },
  TipsType_10154_Desc = {
    Text = "Các thẻ bài khác đang có hiệu lực,không thể ra bài"
  },
  TipsType_10155_Desc = {
    Text = "Không có trong tay, không thể triển khai"
  },
  TipsType_10156_Desc = {
    Text = "Thẻ này không thể chơi ra"
  },
  TipsType_10157_Desc = {
    Text = "Thẻ này chưa được cấu hình kỹ năng"
  },
  TipsType_10158_Desc = {
    Text = "Thẻ này không thể chơi ra"
  },
  TipsType_10159_Desc = {
    Text = "Thiếu sức tính toán"
  },
  TipsType_10160_Desc = {
    Text = "Không có thân thể được đánh thức trên sân"
  },
  TipsType_10161_Desc = {
    Text = "Không đủ lượt còn lại"
  },
  TipsType_10162_Desc = {
    Text = "Sử dụng kỹ năng khám phá"
  },
  TipsType_10163_Desc = {
    Text = "Đã chọn %d thẻ lệnh"
  },
  TipsType_10164_Desc = {
    Text = "Đạt giới hạn số lượng"
  },
  TipsType_10165_Desc = {
    Text = "Chưa được chọn"
  },
  TipsType_10166_Desc = {
    Text = "Thẻ này không thể tiêu thụ sức tính toán để triển khai"
  },
  TipsType_10167_Desc = {
    Text = "Tổng tiêu thụ vượt quá"
  },
  TipsType_10168_Desc = {
    Text = "Đã chọn {s1} thẻ bài"
  },
  TipsType_10169_Desc = {
    Text = "Số lượng râu xúc tu đã đạt giới hạn"
  },
  TipsType_10170_Desc = {
    Text = "Gỡ bỏ thành công"
  },
  TipsType_10171_Desc = {
    Text = "Cường hóa thành công"
  },
  TipsType_10172_Desc = {
    Text = "Chuyển đổi thành công"
  },
  TipsType_10173_Desc = {
    Text = "Đã sao chép vào bộ nhớ tạm"
  },
  TipsType_10174_Desc = {
    Text = "Đã nhận được thẻ lệnh"
  },
  TipsType_10175_Desc = {
    Text = "Số lần di chuyển đã hết"
  },
  TipsType_10176_Desc = {
    Text = "Tăng cường đã hết lượt"
  },
  TipsType_10177_Desc = {
    Text = "Đã dùng hết số lần thay đổi"
  },
  TipsType_10178_Desc = {
    Text = "Số lần sao chép đã dùng hết"
  },
  TipsType_10179_Desc = {
    Text = "Số lượng thẻ lệnh đã đạt giới hạn"
  },
  TipsType_10180_Desc = {
    Text = "Chưa có thẻ lệnh nào được chọn"
  },
  TipsType_10181_Desc = {
    Text = "Cửa hàng chưa mở, xin vui lòng đợi."
  },
  TipsType_10182_Desc = {
    Text = "Xin hãy mong chờ"
  },
  TipsType_10183_Desc = {
    Text = "Mục tiêu nghiên cứu ở khu vực quá xa, không thể định vị"
  },
  TipsType_10184_Desc = {
    Text = "Không tìm thấy khu vực mục tiêu, không thể hoàn thành"
  },
  TipsType_10185_Desc = {
    Text = "Chưa mở khóa nội dung này"
  },
  TipsType_10186_Desc = {
    Text = "Khám phá thâm cảnh để mở khóa thêm nhiều cuộc điều tra"
  },
  TipsType_10187_Desc = {
    Text = "Hoàn thành nhiệm vụ trước để mở khóa thêm các cuộc điều tra"
  },
  TipsType_10188_Desc = {
    Text = "Đã nộp thành công, điểm chủ đề +{s1}"
  },
  TipsType_10189_Desc = {
    Text = "Không có nhiệm vụ có thể nộp"
  },
  TipsType_10190_Desc = {
    Text = "Chưa mở, vui lòng chú ý thời gian mở bản sao."
  },
  TipsType_10191_Desc = {
    Text = "Chưa đạt điều kiện mở khoá màn chơi"
  },
  TipsType_10192_Desc = {
    Text = "{s1} không thể để trống"
  },
  TipsType_10193_Desc = {
    Text = "{s1} và {s2} không thể bỏ trống"
  },
  TipsType_10194_Desc = {
    Text = "Số lần làm mới đã hết, không thể thực hiện làm mới."
  },
  TipsType_10195_Desc = {
    Text = "Cách nhận chưa được mở khóa"
  },
  TipsType_10196_Desc = {
    Text = "Cách nhận không khả dụng trong thời gian mở cửa"
  },
  TipsType_10197_Desc = {
    Text = "Hãy chọn sáng tạo cần thay đổi thành"
  },
  TipsType_10198_Desc = {
    Text = "Gỡ bỏ thành công"
  },
  TipsType_10199_Desc = {
    Text = "Số lần di chuyển đã hết"
  },
  TipsType_10200_Desc = {
    Text = "Đã dùng hết số lần thay đổi"
  },
  TipsType_10201_Desc = {
    Text = "Hãy chọn sáng tạo cần được gỡ bỏ"
  },
  TipsType_10202_Desc = {
    Text = "Số lượng đã đạt giới hạn"
  },
  TipsType_10203_Desc = {
    Text = "Vui lòng chọn ít nhất {s1} sáng tạo"
  },
  TipsType_10204_Desc = {
    Text = "Còn 0 lần chuyển đổi, không thể chuyển đổi"
  },
  TipsType_10205_Desc = {
    Text = "Tất cả các thẻ độc quyền đã được nâng cấp lên cấp độ tối đa"
  },
  TipsType_10206_Desc = {
    Text = "Hiện tại mức độ bài xích là 0, không thể giảm thêm"
  },
  TipsType_10207_Desc = {
    Text = "Chưa được mở"
  },
  TipsType_10208_Desc = {
    Text = "Số lượng Gông Linh Neo không đủ để thực hiện tăng cường"
  },
  TipsType_10209_Desc = {
    Text = "Cần đạt cấp {s2} để tiến hành khởi linh {s1}"
  },
  TipsType_10210_Desc = {
    Text = "\"{s1}\" không đủ"
  },
  TipsType_10211_Desc = {
    Text = "Chưa sở hữu \"{s1}\""
  },
  TipsType_10212_Desc = {
    Text = "Đã đạt đến giới hạn cấp độ"
  },
  TipsType_10213_Desc = {
    Text = "Vui lòng chọn nguyên liệu trước"
  },
  TipsType_10214_Desc = {
    Text = "\"{s1}\" không đủ"
  },
  TipsType_10215_Desc = {
    Text = "Nâng cấp thành công"
  },
  TipsType_10216_Desc = {
    Text = "Thuốc linh tri thức đã tăng"
  },
  TipsType_10217_Desc = {
    Text = "Đã đạt đến giới hạn khởi linh"
  },
  TipsType_10218_Desc = {
    Text = "Nâng cấp thất bại"
  },
  TipsType_10219_Desc = {
    Text = "Đạo cụ không đủ không thể nâng cấp"
  },
  TipsType_10220_Desc = {Text = "Lv. Max"},
  TipsType_10221_Desc = {
    Text = "Kỹ năng nâng cấp thành công"
  },
  TipsType_10222_Desc = {
    Text = "Không đủ dấu đen, không thể mua"
  },
  TipsType_10223_Desc = {
    Text = "Hết hàng"
  },
  TipsType_10224_Desc = {
    Text = "Dấu đen không đủ, không thể gỡ bỏ thẻ lệnh"
  },
  TipsType_10225_Desc = {
    Text = "Xóa {s1} thẻ lệnh"
  },
  TipsType_10226_Desc = {
    Text = "Hướng này chưa được mở, không thể tăng cường"
  },
  TipsType_10227_Desc = {
    Text = "Hướng này đã được tăng cường đến giới hạn tối đa"
  },
  TipsType_10228_Desc = {
    Text = "Hãy chọn hướng muốn tăng cường cho thẻ đặc biệt của bạn"
  },
  TipsType_10229_Desc = {
    Text = "Số lượng Gông Linh Neo không đủ để thực hiện tăng cường"
  },
  TipsType_10230_Desc = {
    Text = "Chưa sở hữu thân thể được đánh thức của giới vực này, chưa thể chọn."
  },
  TipsType_10231_Desc = {
    Text = "Thành lập một đội"
  },
  TipsType_10232_Desc = {
    Text = "Tên đội không được vượt quá {s1} chữ Hán"
  },
  TipsType_10233_Desc = {
    Text = "Tên đội không được để trống"
  },
  TipsType_10234_Desc = {
    Text = "Đã đổi thành công."
  },
  TipsType_10235_Desc = {
    Text = "Không còn \"Bạc Tâm\" nữa."
  },
  TipsType_10236_Desc = {
    Text = "Không thể giảm được nữa."
  },
  TipsType_10237_Desc = {
    Text = "{s1}chưa được mở, vui lòng chờ đợi."
  },
  TipsType_10238_Desc = {
    Text = "Gọi chưa được mở, xin vui lòng đón xem."
  },
  TipsType_10239_Desc = {
    Text = "Chức năng bản đồ nhỏ trong khuôn viên trường chưa mở"
  },
  TipsType_10240_Desc = {
    Text = "Được mở khóa ở cấp độ đề tài {s1}"
  },
  TipsType_10241_Desc = {
    Text = "Không có thẻ bài nào phù hợp"
  },
  TipsType_10242_Desc = {
    Text = "Tất cả thẻ Giới Vực đã được nâng cấp"
  },
  TipsType_10243_Desc = {
    Text = "Không có thẻ lệnh nào có thể nâng cấp được"
  },
  TipsType_10244_Desc = {
    Text = "Phát hiện điểm dịch chuyển mới! Có thể đi đến {s1}."
  },
  TipsType_10245_Desc = {
    Text = "Bạn đã sở hữu sáng tạo này và không thể nhận thêm lần nữa"
  },
  TipsType_10246_Desc = {
    Text = "Đã khôi phục"
  },
  TipsType_10247_Desc = {
    Text = "Gỡ bỏ thành công"
  },
  TipsType_10248_Desc = {
    Text = "Mở giao diện túi đồ"
  },
  TipsType_10249_Desc = {
    Text = "Đã phát hiện bạn đăng xuất bất thường lần trước, hiện đã hoàn trả\"Linh Phi Peptide\" và vật tư đã nhận, bạn có thể mở balo để kiểm tra"
  },
  TipsType_10250_Desc = {
    Text = "AVG bản chỉ cung cấp một số tòa nhà, ở đây, tổng số tòa nhà được biểu thị là 17"
  },
  TipsType_10251_Desc = {
    Text = "AVG bản chỉ cung cấp một số tòa nhà, ở đây, tổng số tòa nhà được biểu thị là 17"
  },
  TipsType_10252_Desc = {
    Text = "AVG bản chỉ cung cấp một số tòa nhà, ở đây, tổng số tòa nhà được biểu thị là 17"
  },
  TipsType_10253_Desc = {
    Text = "AVG bản chỉ cung cấp một số tòa nhà, ở đây, tổng số tòa nhà được biểu thị là 17"
  },
  TipsType_10254_Desc = {
    Text = "AVG bản chỉ cung cấp một số tòa nhà, ở đây, tổng số tòa nhà được biểu thị là 17"
  },
  TipsType_10255_Desc = {
    Text = "AVG bản chỉ cung cấp một số tòa nhà, ở đây, tổng số tòa nhà được biểu thị là 17"
  },
  TipsType_10256_Desc = {
    Text = "AVG bản chỉ cung cấp một số tòa nhà, ở đây, tổng số tòa nhà được biểu thị là 17"
  },
  TipsType_10257_Desc = {
    Text = "AVG bản chỉ cung cấp một số tòa nhà, ở đây, tổng số tòa nhà được biểu thị là 17"
  },
  TipsType_10258_Desc = {
    Text = "AVG bản chỉ cung cấp một số tòa nhà, ở đây, tổng số tòa nhà được biểu thị là 17"
  },
  TipsType_10259_Desc = {
    Text = "AVG bản chỉ cung cấp một số tòa nhà, ở đây, tổng số tòa nhà được biểu thị là 17"
  },
  TipsType_10260_Desc = {
    Text = "AVG bản chỉ cung cấp một số tòa nhà, ở đây, tổng số tòa nhà được biểu thị là 17"
  },
  TipsType_10261_Desc = {
    Text = "AVG bản chỉ cung cấp một số tòa nhà, ở đây, tổng số tòa nhà được biểu thị là 17"
  },
  TipsType_10262_Desc = {
    Text = "AVG bản chỉ cung cấp một số tòa nhà, ở đây, tổng số tòa nhà được biểu thị là 17"
  },
  TipsType_10263_Desc = {
    Text = "AVG bản chỉ cung cấp một số tòa nhà, ở đây, tổng số tòa nhà được biểu thị là 17"
  },
  TipsType_10264_Desc = {
    Text = "AVG bản chỉ cung cấp một số tòa nhà, ở đây, tổng số tòa nhà được biểu thị là 17"
  },
  TipsType_10265_Desc = {
    Text = "AVG bản chỉ cung cấp một số tòa nhà, ở đây, tổng số tòa nhà được biểu thị là 17"
  },
  TipsType_10266_Desc = {
    Text = "AVG bản chỉ cung cấp một số tòa nhà, ở đây, tổng số tòa nhà được biểu thị là 17"
  },
  TipsType_10267_Desc = {
    Text = "Không đáp ứng điều kiện sử dụng"
  },
  TipsType_10268_Desc = {
    Text = "Điều tra cấp 2 mở khóa điều tra nhanh"
  },
  TipsType_10269_Desc = {
    Text = "Mất kết nối"
  },
  TipsType_10270_Desc = {
    Text = "Kết nối máy chủ bị ngắt, sau đó sẽ trở lại trang đăng nhập."
  },
  TipsType_10271_Desc = {
    Text = "Xác nhận"
  },
  TipsType_10272_Desc = {
    Text = "Máy chủ chưa mở, thử lại sau."
  },
  TipsType_10273_Desc = {
    Text = "Thao tác thành công"
  },
  TipsType_10274_Desc = {
    Text = "Không tìm thấy mật cảnh tương ứng"
  },
  TipsType_10275_Desc = {
    Text = "Sự kiện Thâm Cảnh đã hoàn tất"
  },
  TipsType_10276_Desc = {
    Text = "Loại cấu hình sự kiện thâm cảnh bị sai"
  },
  TipsType_10277_Desc = {
    Text = "Sự kiện thâm cảnh không có"
  },
  TipsType_10278_Desc = {
    Text = "Không đủ dấu đen, không thể mua"
  },
  TipsType_10279_Desc = {
    Text = "Thẻ này không thể được tăng cường"
  },
  TipsType_10280_Desc = {
    Text = "Thẻ này đã đạt tối đa tăng cường"
  },
  TipsType_10281_Desc = {
    Text = "Thương nhân không bán mặt hàng này"
  },
  TipsType_10282_Desc = {
    Text = "Không có phần thưởng này"
  },
  TipsType_10283_Desc = {
    Text = "Đã nhận phần thưởng"
  },
  TipsType_10284_Desc = {
    Text = "Lỗi bảng cấu hình"
  },
  TipsType_10285_Desc = {
    Text = "Lỗi dữ liệu sự kiện"
  },
  TipsType_10286_Desc = {
    Text = "Sản phẩm đã mua"
  },
  TipsType_10287_Desc = {
    Text = "Không tìm thấy dữ liệu bài học"
  },
  TipsType_10288_Desc = {
    Text = "Đơn vị đã được gửi, không cần gửi lại"
  },
  TipsType_10289_Desc = {
    Text = "Các chủ đề trong đơn vị này chưa hoàn thành hết, chưa thể nộp được"
  },
  TipsType_10290_Desc = {
    Text = "Chủ đề chưa có mô-đun"
  },
  TipsType_10291_Desc = {
    Text = "Màn chơi không có dữ liệu nhiệm vụ"
  },
  TipsType_10292_Desc = {
    Text = "Lỗi truyền dữ liệu từ máy khách"
  },
  TipsType_10293_Desc = {
    Text = "Dịch vụ chưa được khởi động"
  },
  TipsType_10294_Desc = {
    Text = "Lỗi dữ liệu nhân vật"
  },
  TipsType_10295_Desc = {
    Text = "Không có nhân vật. Cần tạo"
  },
  TipsType_10296_Desc = {
    Text = "Đã có nhân vật, không cần phải tạo thêm lần nữa"
  },
  TipsType_10297_Desc = {
    Text = "Tên nhân vật trùng tên"
  },
  TipsType_10298_Desc = {
    Text = "Sai sót thâm cảnh"
  },
  TipsType_10299_Desc = {
    Text = "Dòng cốt truyện này chưa được mở khóa, không thể truy cập."
  },
  TipsType_10300_Desc = {
    Text = "Ở đây bạn có thể xem hiệu ứng địa hình và thông tin quái vật"
  },
  TipsType_10301_Desc = {
    Text = "{s1} đạt {s2} mở khóa {s3}"
  },
  TipsType_10302_Desc = {
    Text = "{s1} đạt {s2} mở khóa {s3}"
  },
  TipsType_10303_Desc = {
    Text = "Chưa đạt điều kiện mở khóa kiến trúc"
  },
  TipsType_10304_Desc = {
    Text = "Chưa đạt điều kiện nâng cấp tòa nhà"
  },
  TipsType_10305_Desc = {
    Text = "Không đủ nguyên liệu nâng cấp công trình"
  },
  TipsType_10306_Desc = {
    Text = "Có phần thưởng nhiệm vụ sẵn sàng nhận"
  },
  TipsType_10307_Desc = {
    Text = "（sức sống sẽ giảm <Negative:10%%>）"
  },
  TipsType_10308_Desc = {
    Text = "Mỗi cuối lượt, nhận được giá trị <BuffTipBlock:lá chắn> tương đương với số lớp bảo vệ hiện tại. Mỗi lần chịu thương, bảo vệ giảm <BuffTip:1> lớp"
  },
  TipsType_10309_Desc = {
    Text = "Đa tầng bảo vệ"
  },
  TipsType_10310_Desc = {
    Text = "Sức khỏe dưới ngưỡng cảnh báo, nguy cơ điều tra tăng cao"
  },
  TipsType_10311_Desc = {
    Text = "Sức khỏe dưới mức cảnh báo, nguy cơ điều tra cực cao, có muốn chọn cách ép buộc vào không?"
  },
  TipsType_10312_Desc = {
    Text = "Sức lực hiện tại quá thấp, không thể vào thâm cảnh."
  },
  TipsType_10313_Desc = {
    Text = "Hãy chọn thẻ đặc biệt cùng cấp để chuyển đổi"
  },
  TipsType_10314_Desc = {
    Text = "Sau khi thân thể được đánh thức đạt khởi linh cấp 2, hướng này sẽ được mở khóa"
  },
  TipsType_10315_Desc = {
    Text = "Sau khi Thân thể được đánh thức khởi linh đạt cấp 3, hướng này sẽ được mở khóa"
  },
  TipsType_10316_Desc = {
    Text = "Hiện tại"
  },
  TipsType_10317_Desc = {
    Text = "Tất cả các thức tỉnh thể đều chưa mở khóa kỹ năng, không thể nạp năng lượng"
  },
  TipsType_10318_Desc = {
    Text = "Tất cả năng lượng của các kỹ năng thân thể được đánh thức đã đầy"
  },
  TipsType_10319_Desc = {
    Text = "Đã sử dụng"
  },
  TipsType_10320_Desc = {
    Text = "Không đủ Dấu đen"
  },
  TipsType_10321_Desc = {
    Text = "Không đủ Dấu đen"
  },
  TipsType_10322_Desc = {
    Text = "Không đủ Dấu đen"
  },
  TipsType_10323_Desc = {
    Text = "Không thể nhận lại sáng tạo đã có"
  },
  TipsType_10324_Desc = {
    Text = "Số lần làm mới không đủ"
  },
  TipsType_10325_Desc = {
    Text = "Gây {s1} điểm thương cho đội ta."
  },
  TipsType_10326_Desc = {
    Text = "tấn công"
  },
  TipsType_10327_Desc = {
    Text = "Ở đây sẽ hiển thị bản đồ nhỏ của màn chơi, người chơi có thể triển khai chiến lược trước"
  },
  TipsType_10328_Desc = {
    Text = "Bạn đã dành 10 phút để hoàn thành một cấp độ trong bản sao hàng ngày. Tại đây, bạn đã trải nghiệm lối chơi độc đáo và thông qua thiết kế cấp độ, nhận thức về phong cách chơi đã được tăng cường"
  },
  TipsType_10329_Desc = {
    Text = "Hiện tại, giới hạn sức sống tối đa đã giảm xuống dưới 50%, vui lòng chú ý an toàn"
  },
  TipsType_10330_Desc = {
    Text = "Năng lượng duy trì sự tồn tại của thân thể được đánh thức. Thương sẽ làm giảm sức sống, khi sức sống giảm xuống 0 tức là điều tra thất bại."
  },
  TipsType_10331_Desc = {
    Text = "Sức mạnh tấn công được thể hiện qua thân thể đã thức tỉnh. Lực lượng càng mạnh thì khi dùng thẻ lệnh, sát thương gây ra cho địch càng cao."
  },
  TipsType_10332_Desc = {
    Text = "Khả năng phòng thủ của thân thể được đánh thức được thể hiện. Càng cảnh giác, khi dùng thẻ lệnh sẽ nhận thêm nhiều lá chắn."
  },
  TipsType_10333_Desc = {
    Text = "Nhấn vào bất kỳ đâu để tiếp tục"
  },
  TipsType_10334_Desc = {
    Text = "Chưa hoàn thành nhiệm vụ điều tra dự án"
  },
  TipsType_10335_Desc = {
    Text = "Đánh giá điều tra"
  },
  TipsType_10336_Desc = {
    Text = "Trao 1 thẻ độc quyền với Tinh linh Khai sáng"
  },
  TipsType_10337_Desc = {
    Text = "Chọn hướng tăng cường cho thẻ độc quyền"
  },
  TipsType_10338_Desc = {
    Text = "Bản đồ nhỏ thành chính chưa được mở, xin vui lòng đợi."
  },
  TipsType_10339_Desc = {
    Text = "{s1}{s2} giá trị"
  },
  TipsType_10340_Desc = {
    Text = "{s1}cấp độ bộ bài cơ bản được nâng cao"
  },
  TipsType_10341_Desc = {
    Text = "<Positive:độ thân thiện:>"
  },
  TipsType_10342_Desc = {
    Text = "Liên kết cảm xúc giữa bạn và thân thể được đánh thức. Khi mức độ hảo cảm tăng lên, bạn có thể hiểu rõ hơn về thân thể được đánh thức."
  },
  TipsType_10343_Desc = {
    Text = "<Positive:đẳng cấp hiện tại:>{s1}"
  },
  TipsType_10344_Desc = {
    Text = "<Positive:Bộ bài cơ bản:>"
  },
  TipsType_10345_Desc = {
    Text = "Bộ bài ban đầu khi vào giới vực."
  },
  TipsType_10346_Desc = {
    Text = "<Positive:cấp độ cao nhất của bộ bài:>{s1}cấp"
  },
  TipsType_10347_Desc = {
    Text = "<Positive:độ mạnh bộ bài:>"
  },
  TipsType_10348_Desc = {
    Text = "Khi số lượng thân thể được đánh thức trong giới vực này đạt đến cấp độ hảo cảm chỉ định, bộ thẻ cơ bản có thể được nâng cấp."
  },
  TipsType_10349_Desc = {
    Text = "<Positive:Nội dung nâng cấp:>"
  },
  TipsType_10350_Desc = {
    Text = "Mỗi lần nâng cấp đều giúp tăng giá trị cơ bản của một thẻ lệnh."
  },
  TipsType_10351_Desc = {
    Text = "{s1} tăng độ hảo cảm"
  },
  TipsType_10352_Desc = {
    Text = "Trong thâm cảnh tĩnh lặng"
  },
  TipsType_10353_Desc = {
    Text = "Thâm cảnh không chấp nhận kẻ xâm lược"
  },
  TipsType_10354_Desc = {
    Text = "Thâm cảnh mức độ bài xích tăng lên"
  },
  TipsType_10355_Desc = {
    Text = "Mức độ bài xích đạt {s1}, thâm cảnh đang theo dõi bạn"
  },
  TipsType_10356_Desc = {
    Text = "Khởi linh 1"
  },
  TipsType_10357_Desc = {
    Text = "Nắm vững kỹ năng này"
  },
  TipsType_10358_Desc = {
    Text = "Số lượng tối đa của râu chạm có thể cùng tồn tại đồng thời."
  },
  TipsType_10359_Desc = {
    Text = "Sức mạnh của đòn tấn công bằng râu chạm. Lực lượng của râu chạm càng lớn, thương gây ra cho đối phương khi kích hoạt càng cao."
  },
  TipsType_10360_Desc = {
    Text = "Chưa có thẻ lệnh nào được chọn"
  },
  TipsType_10361_Desc = {
    Text = "Chuyển đổi thành công"
  },
  TipsType_10362_Desc = {
    Text = "Chưa có thẻ lệnh nào được chọn"
  },
  TipsType_10363_Desc = {
    Text = "Sao chép thành công"
  },
  TipsType_10364_Desc = {
    Text = "Đã chọn {s1} thẻ lệnh"
  },
  TipsType_10365_Desc = {
    Text = "Chưa có thẻ lệnh nào được chọn"
  },
  TipsType_10366_Desc = {
    Text = "Chưa có thẻ lệnh nào được chọn"
  },
  TipsType_10367_Desc = {
    Text = "Nâng cấp thành công"
  },
  TipsType_10368_Desc = {
    Text = "Giao diện ba lô sáng tạo đang được phát triển, vui lòng chờ đón"
  },
  TipsType_10369_Desc = {
    Text = "Hãy chọn sáng tạo cần thay đổi thành"
  },
  TipsType_10370_Desc = {
    Text = "Phiên bản đã được cập nhật, vui lòng xin tải lại gói cài đặt"
  },
  TipsType_10371_Desc = {
    Text = "Hiệu ứng nâng cao"
  },
  TipsType_10372_Desc = {
    Text = "Thông tin thâm cảnh"
  },
  TipsType_10373_Desc = {
    Text = "Mỗi lần sử dụng 1 thẻ sát thương, râu chạm sẽ gây {s1} điểm thương lên một kẻ địch ngẫu nhiên."
  },
  TipsType_10374_Desc = {
    Text = "Hiện tại không có chủ đề cần hoàn thành"
  },
  TipsType_10375_Desc = {
    Text = "Hiện không có nghiên cứu đã lưu trữ"
  },
  TipsType_10376_Desc = {
    Text = "Chưa hoàn thành đề tài điều tra lần này"
  },
  TipsType_10377_Desc = {
    Text = "Không thể hoàn tác"
  },
  TipsType_10378_Desc = {
    Text = "(Đề tài sau đây đã được tự động lưu trữ)"
  },
  TipsType_10379_Desc = {
    Text = "Mục tiêu bài học đã hoàn thành"
  },
  TipsType_10380_Desc = {
    Text = "Bạn không có vật phẩm này"
  },
  TipsType_10381_Desc = {
    Text = "Giá trị chỉ mục sai"
  },
  TipsType_10382_Desc = {
    Text = "Chưa mở khóa"
  },
  TipsType_10383_Desc = {
    Text = "Thẻ độc quyền nâng cấp, không giới hạn số lần"
  },
  TipsType_10384_Desc = {
    Text = "Đã mở khóa 1 ô bảo quản vật phẩm sáng tạo!"
  },
  TipsType_10385_Desc = {
    Text = "Tăng tỷ lệ kết nối"
  },
  TipsType_10386_Desc = {
    Text = "Không có thông tin khe cắm"
  },
  TipsType_10387_Desc = {
    Text = "Đồng tiền không đủ"
  },
  TipsType_10388_Desc = {
    Text = "Đã đạt tới cấp tối đa"
  },
  TipsType_10389_Desc = {
    Text = "Đang phát triển, hãy đón chờ"
  },
  TipsType_10390_Desc = {
    Text = "Đã hết số lần nâng cấp ô thủ công"
  },
  TipsType_10391_Desc = {
    Text = "Có thể sử dụng sau khi mở khóa tại cửa hàng hoặc trại"
  },
  TipsType_10392_Desc = {
    Text = "Trận chiến đấu này mất {s1} điểm thể lực"
  },
  TipsType_10393_Desc = {
    Text = "Năng lượng thân thể được đánh thức đã đầy, không thể tăng thêm nữa"
  },
  TipsType_10394_Desc = {
    Text = "Đã nâng cấp năng lượng cho tất cả các thân thể được đánh thức"
  },
  TipsType_10395_Desc = {
    Text = "Cần sử dụng \"mắt\"để mở khóa"
  },
  TipsType_10396_Desc = {
    Text = "Đã khắcăng thành công"
  },
  TipsType_10397_Desc = {
    Text = "Đã triệu hồi {s1} thân thể được đánh thức, {s2} đặc tính giới vực sẽ được kích hoạt."
  },
  TipsType_10398_Desc = {
    Text = "Đội sẽ trở thành trung lập, không sở hữu đặc tính của bất kỳ giới vực nào."
  },
  TipsType_10399_Desc = {
    Text = "Hệ thống vòng lặp nhỏ được kích hoạt từ chương 4"
  },
  TipsType_10400_Desc = {
    Text = "Tối đa có thể kế thừa {s1} tạo vật, vui lòng giảm số lượng tạo vật đã chọn."
  },
  TipsType_10401_Desc = {
    Text = "Chưa được chọn sáng tạo không thể kế thừa"
  },
  TipsType_10405_Desc = {
    Text = "Nhận được {s1}"
  },
  TipsType_10406_Desc = {
    Text = "Đã đạt giới hạn kích hoạt thân thể được đánh thức khi xuất trận"
  },
  TipsType_10407_Desc = {
    Text = "Tháp vàng này không thể thách đấu."
  },
  TipsType_10408_Desc = {
    Text = "Tháp vàng này chưa được mở khóa - Xin hãy hoàn thành bản sao điều tra chỉ định"
  },
  TipsType_10409_Desc = {
    Text = "Hãy chọn thức tỉnh thể để ra trận"
  },
  TipsType_10410_Desc = {
    Text = "Thân thể được đánh thức đang nỗ lực hoàn thành nhiệm vụ phái đi, hãy quay lại sau nhé"
  },
  TipsType_10411_Desc = {
    Text = "Đã nhận {s1} quyền vàng hồng"
  },
  TipsType_10412_Desc = {
    Text = "Thu nhập theo thời gian cần tích lũy dần theo thời gian"
  },
  TipsType_10413_Desc = {
    Text = "\"Bạc Tâm\" không đủ"
  },
  TipsType_10414_Desc = {
    Text = "Hết lượt thử thách"
  },
  TipsType_10415_Desc = {
    Text = "Thách thức đang hồi chiêu"
  },
  TipsType_10416_Desc = {
    Text = "Không có đối thủ"
  },
  TipsType_10417_Desc = {
    Text = "Hãy chọn thân thể được đánh thức để ra trận"
  },
  TipsType_10418_Desc = {
    Text = "Thuốc linh tri thức không đủ, không thể tiếp tục nâng cấp"
  },
  TipsType_10419_Desc = {
    Text = "Đẳng cấp hiện tại đã đạt tối đa"
  },
  TipsType_10420_Desc = {
    Text = "Thân thể được đánh thức chưa mở khóa"
  },
  TipsType_10421_Desc = {
    Text = "Đã hủy yêu thích thành công"
  },
  TipsType_10422_Desc = {
    Text = "Số lần mua thử thách cốt truyện không đủ"
  },
  TipsType_10423_Desc = {
    Text = "Dòng cốt truyện không đủ sao, không thể quét ải"
  },
  TipsType_10424_Desc = {
    Text = "Điều tra lỗi nhóm của bản sao giới vực"
  },
  TipsType_10425_Desc = {
    Text = "\"Bạc Tâm\" không đủ"
  },
  TipsType_10426_Desc = {
    Text = "Số lần mua chứng từ hôm nay đã đạt đến giới hạn tối đa"
  },
  TipsType_10427_Desc = {
    Text = "Hoàn thành bí cảnh với ba sao để mở khóa"
  },
  TipsType_10428_Desc = {
    Text = "Thành công lấy được {s1} phiếu"
  },
  TipsType_10429_Desc = {
    Text = "Thành công nhận được {s1} lượt thách đấu"
  },
  TipsType_10430_Desc = {
    Text = "Qua màn điều tra 4-6 để mở khóa"
  },
  TipsType_10431_Desc = {
    Text = "Điều kiện không đủ"
  },
  TipsType_10432_Desc = {
    Text = "Số lần mua phiếu không đủ"
  },
  TipsType_10433_Desc = {
    Text = "Cấp độ khởi linh đã đạt đến giới hạn tối đa"
  },
  TipsType_10434_Desc = {
    Text = "\"{s1}\" không đủ"
  },
  TipsType_10435_Desc = {
    Text = "Không bán mặt hàng này"
  },
  TipsType_10436_Desc = {
    Text = "Cửa hàng loại này không tồn tại"
  },
  TipsType_10437_Desc = {
    Text = "Hàng hóa đang bán đã hết hàng"
  },
  TipsType_10438_Desc = {
    Text = "Không có dữ liệu cửa hàng"
  },
  TipsType_10439_Desc = {
    Text = "Không có lượt làm mới"
  },
  TipsType_10440_Desc = {
    Text = "Số lần mua \"Linh Phi Peptide\" hôm nay đã đạt giới hạn"
  },
  TipsType_10441_Desc = {
    Text = "Thân thể được đánh thức thiếu mảnh vỡ"
  },
  TipsType_10442_Desc = {
    Text = "Điểm khởi linh đã kích hoạt"
  },
  TipsType_10443_Desc = {
    Text = "Điểm khởi linh đầu chưa được kích hoạt"
  },
  TipsType_10444_Desc = {
    Text = "Mua thành công \"Linh Phi Peptide\" × {s1}"
  },
  TipsType_10445_Desc = {
    Text = "\"Linh Phi Peptide\"đã đạt giới hạn"
  },
  TipsType_10446_Desc = {
    Text = "Hoàn thành Điều tra 1-12 để mở khóa"
  },
  TipsType_10447_Desc = {
    Text = "Hoàn thành chương mở đầu mở khóa"
  },
  TipsType_10448_Desc = {
    Text = "Hoàn thành chương mở đầu mở khóa"
  },
  TipsType_10449_Desc = {
    Text = "Hoàn thành Điều tra 2-4 để mở khóa"
  },
  TipsType_10450_Desc = {
    Text = "Kỹ năng đã đạt cấp tối đa"
  },
  TipsType_10451_Desc = {
    Text = "Thân thể được đánh thức chưa đạt cấp độ thăng cấp"
  },
  TipsType_10452_Desc = {
    Text = "Vật phẩm kỹ năng không đủ"
  },
  TipsType_10453_Desc = {
    Text = "Hoàn thành Điều tra 3-15 để mở khóa"
  },
  TipsType_10454_Desc = {
    Text = "Hoàn thành Điều tra 3-7 mở"
  },
  TipsType_10455_Desc = {
    Text = "Kỹ năng chưa đáp ứng điều kiện đã thiết lập"
  },
  TipsType_10456_Desc = {
    Text = "Phiên bản thử nghiệm chỉ cho phép nạp tiền 1 lần cho mỗi hạng mục nạp tiền"
  },
  TipsType_10457_Desc = {
    Text = "Thân thể được đánh thức này đang chờ nguồn gốc đến, hãy thả ra vào lượt sau nhé"
  },
  TipsType_10458_Desc = {
    Text = "Bảng thông số nạp tiền không có cấu hình này"
  },
  TipsType_10459_Desc = {
    Text = "Đã nạp miễn phí, không thể thực hiện nạp lại"
  },
  TipsType_10460_Desc = {
    Text = "Cảm ứng đã kích hoạt, không cần lặp lại"
  },
  TipsType_10461_Desc = {
    Text = "Giá của đạo cụ {s1} đã thay đổi, vui lòng chú ý xác nhận"
  },
  TipsType_10462_Desc = {
    Text = "\"Tường Vi Kim Quyển\" không đủ"
  },
  TipsType_10463_Desc = {
    Text = "\"Huân Chương Diễn Tập\" không đủ"
  },
  TipsType_10464_Desc = {
    Text = "Hoàn thành 3-4 để mở khóa"
  },
  TipsType_10465_Desc = {
    Text = "Hoàn thành Điều tra 2-16 để mở khóa"
  },
  TipsType_10466_Desc = {
    Text = "Hoàn thành điều tra 3-16 và mở khóa"
  },
  TipsType_10467_Desc = {
    Text = "Hoàn thành Điều tra 4-12 để mở khóa"
  },
  TipsType_10468_Desc = {
    Text = "Hoàn thành 5-12 để mở khóa"
  },
  TipsType_10469_Desc = {
    Text = "Hoàn thành Điều tra 6-12 để mở khóa nội dung tiếp theo"
  },
  TipsType_10470_Desc = {
    Text = "Hoàn thành Điều tra 1-7 để mở khóa"
  },
  TipsType_10471_Desc = {
    Text = "Đã trang bị thành công"
  },
  TipsType_10472_Desc = {
    Text = "Gỡ bỏ thành công"
  },
  TipsType_10473_Desc = {
    Text = "Đã đạt đến cấp độ tối đa"
  },
  TipsType_10474_Desc = {
    Text = "\"Tường Vi Kim Quyển\" không đủ"
  },
  TipsType_10475_Desc = {
    Text = "Hãy chọn nguyên liệu"
  },
  TipsType_10476_Desc = {
    Text = "Đang được bảo vệ bằng khóa, vui lòng gỡ bỏ trạng thái khóa trước"
  },
  TipsType_10477_Desc = {
    Text = "Chưa mở khóa cấp độ này"
  },
  TipsType_10478_Desc = {
    Text = "Ngoài chiến đấu chưa mở"
  },
  TipsType_10479_Desc = {
    Text = "Ngăn bài vứt đi đang trống"
  },
  TipsType_10480_Desc = {
    Text = "Trong quá trình điều chỉnh chiến đấu RPG, hiện tại tính thẳng chiến thắng"
  },
  TipsType_10482_Desc = {
    Text = "Vòng mệnh đã khóa"
  },
  TipsType_10483_Desc = {
    Text = "Không tìm thấy vòng mệnh"
  },
  TipsType_10484_Desc = {
    Text = "Vòng mệnh đã đạt cấp tối đa"
  },
  TipsType_10485_Desc = {
    Text = "Vòng mệnh đã được trang bị"
  },
  TipsType_10486_Desc = {
    Text = "Vòng mệnh không phù hợp"
  },
  TipsType_10487_Desc = {
    Text = "Vòng mệnh chưa khóa"
  },
  TipsType_10488_Desc = {
    Text = "Đang ở trong \"biên đội\"\"trợ chiến\"\"phương án bí ẩn\" của bí ẩn, không thể phân giải."
  },
  TipsType_10489_Desc = {
    Text = "Đang ở trong \"biên đội\"\"trợ chiến\" vòng mệnh, không thể phân giải."
  },
  TipsType_10490_Desc = {
    Text = "Điểm điên cuồng không đủ, không thể kích hoạt bùng nổ điên cuồng"
  },
  TipsType_10491_Desc = {
    Text = "Vui lòng nhận gói quà trước đó."
  },
  TipsType_10492_Desc = {
    Text = "Hiện tại bí ẩn đã bị khóa, mở khóa để dùng làm vật tư tiêu thụ"
  },
  TipsType_10493_Desc = {
    Text = "Hiện tại vòng mệnh đã bị khóa, mở khóa để dùng làm vật tư tiêu hao"
  },
  TipsType_10494_Desc = {
    Text = "Hoàn thành Điều tra 1-7 để mở khóa"
  },
  TipsType_10495_Desc = {
    Text = "Hoàn thành Điều tra 1-13 để mở khóa"
  },
  TipsType_10496_Desc = {
    Text = "Mức độ bí ẩn hiện tại đã đạt mức tối đa"
  },
  TipsType_10497_Desc = {
    Text = "Cửa hàng đã reset"
  },
  TipsType_10498_Desc = {
    Text = "Thay thế thành công"
  },
  TipsType_10499_Desc = {
    Text = "Lưu thành công"
  },
  TipsType_10500_Desc = {
    Text = "Xếp chồng thành công"
  },
  TipsType_10501_Desc = {
    Text = "Thách thức hiện tại chưa được mở khóa"
  },
  TipsType_10502_Desc = {
    Text = "Hiện tại, thân thể được đánh thức đã tham gia thử thách trong các màn chơi khác của {s1}, không thể ra trận"
  },
  TipsType_10503_Desc = {
    Text = "Số lượng thân thể được đánh thức ít hơn 4, chưa thể thách đấu"
  },
  TipsType_10504_Desc = {
    Text = "Hoàn thành 'Điều tra 3-7' để mở khóa"
  },
  TipsType_10505_Desc = {
    Text = "Vượt ải tầng 1 với ba sao để mở khóa"
  },
  TipsType_10506_Desc = {
    Text = "Hoàn thành tầng 2 với 3 sao để mở khóa"
  },
  TipsType_10507_Desc = {
    Text = "Hoàn thành 3 sao tại tầng 3 để mở khóa"
  },
  TipsType_10508_Desc = {
    Text = "Cấp 4 đạt ba sao để mở khóa"
  },
  TipsType_10509_Desc = {
    Text = "Lớp 5 hoàn thành với 3 sao để mở khóa"
  },
  TipsType_10510_Desc = {
    Text = "Lớp 6 hoàn thành với đánh giá ba sao để mở khóa"
  },
  TipsType_10511_Desc = {
    Text = "Tầng 7 đạt ba sao để mở khóa"
  },
  TipsType_10512_Desc = {
    Text = "Tầng 8 đạt ba sao để mở khóa"
  },
  TipsType_10513_Desc = {
    Text = "Xin hãy chọn bí ẩn bạn muốn tăng cường"
  },
  TipsType_10514_Desc = {
    Text = "Đã nhận"
  },
  TipsType_10515_Desc = {
    Text = "Hoàn thành 2-14 để mở khóa"
  },
  TipsType_10516_Desc = {
    Text = "Hoàn thành Điều tra 4-7 để mở khóa"
  },
  TipsType_10517_Desc = {
    Text = "Hoàn thành Điều tra 4-7 để mở khóa"
  },
  TipsType_10518_Desc = {
    Text = "Biên đội đã lưu"
  },
  TipsType_10519_Desc = {
    Text = "Hãy nhấn vào khu vực phát sáng để di chuyển"
  },
  TipsType_10520_Desc = {
    Text = "Tên đội không được chứa ký tự ngoài chữ Trung Quốc, tiếng Anh và số"
  },
  TipsType_10521_Desc = {
    Text = "Tên đội không được dài hơn 8 ký tự"
  },
  TipsType_10522_Desc = {
    Text = "Đội ngũ không có đủ {s1} người được đánh thức, không thể tiến hành điều tra"
  },
  TipsType_10523_Desc = {
    Text = "Thân thể được đánh thức đã tham gia vào chiến đấu của các thâm cảnh khác của tầng này trong Vùng đất vô ánh sáng"
  },
  TipsType_10524_Desc = {
    Text = "Đội đã có hai thân thể được đánh thức của giới vực, không thể chọn thêm thân thể được đánh thức từ giới vực khác"
  },
  TipsType_10525_Desc = {
    Text = "Vui lòng chọn một thân thể được đánh thức"
  },
  TipsType_10526_Desc = {
    Text = "Không thể chọn thêm nhiều hơn các thân thể được đánh thức"
  },
  TipsType_10527_Desc = {
    Text = "Chú ý nuôi dưỡng: Trong \"Giấc mơ thám hiểm\", cấp độ thân thể được đánh thức và cấp độ kỹ năng đều về cấp 1"
  },
  TipsType_10528_Desc = {
    Text = "Tên đội không được để trống"
  },
  TipsType_10529_Desc = {
    Text = "Đội có thức tỉnh giả đã kiệt sức, không thể chiến đấu tiếp"
  },
  TipsType_10530_Desc = {
    Text = "Đã nhận hết tệp đính kèm trong hộp thư"
  },
  TipsType_10531_Desc = {
    Text = "Mở khóa sau khi hoàn thành chương mở đầu"
  },
  TipsType_10532_Desc = {
    Text = "Balo đã đầy, chưa nhận hết, cần dọn dẹp túi để tiếp tục nhận"
  },
  TipsType_10533_Desc = {
    Text = "Balo đã đầy,phần thưởng sẽ được gửi đến hòm thư"
  },
  TipsType_10534_Desc = {
    Text = "Balo đã đầy, vật tư chưa được nhận hết, cần dọn dẹp balo để tiếp tục nhận"
  },
  TipsType_10535_Desc = {
    Text = "Không có phụ lục thư để nhận"
  },
  TipsType_10536_Desc = {
    Text = "Vui lòng đổi lấy sáng tạo trước"
  },
  TipsType_10537_Desc = {
    Text = "Hoàn thành Điều tra 2-4 để mở khóa"
  },
  TipsType_10538_Desc = {
    Text = "Hoàn thành Điều tra 1-12 để mở khóa"
  },
  TipsType_10539_Desc = {
    Text = "Hoàn thành Điều tra 1-12 để mở khóa"
  },
  TipsType_10540_Desc = {
    Text = "Hoàn thành Điều tra 1-12 để mở khóa"
  },
  TipsType_10541_Desc = {
    Text = "Tầng 9 đạt ba sao để mở khóa"
  },
  TipsType_10542_Desc = {
    Text = "Lớp 10 đạt đủ ba sao để mở khóa"
  },
  TipsType_10543_Desc = {
    Text = "Tầng 11 đạt ba sao để mở khóa"
  },
  TipsType_10544_Desc = {
    Text = "Tầng 12 đạt ba sao để mở khóa"
  },
  TipsType_10545_Desc = {
    Text = "Tầng 13 đạt 3 sao để mở khóa"
  },
  TipsType_10546_Desc = {
    Text = "Tầng 14 đạt cấp 3 sao để mở khóa"
  },
  TipsType_10547_Desc = {
    Text = "Chức năng này sẽ sớm bị gỡ bỏ"
  },
  TipsType_10548_Desc = {
    Text = "Hoàn thành điều tra 1-7 để mở khóa"
  },
  TipsType_10549_Desc = {
    Text = "Đã đạt giới hạn sáng tạo, không thể nhận thêm"
  },
  TipsType_10550_Desc = {
    Text = "{s1}Hoàn thành liên kết, bây giờ có thể chỉ huy cô ấy chiến đấu rồi!"
  },
  TipsType_10551_Desc = {
    Text = "{s1} cấp độ và cấp độ kỹ năng đã vượt quá giới hạn do bộ tăng cường linh tri thức cung cấp, không thể sử dụng"
  },
  TipsType_10552_Desc = {
    Text = "Cấp độ thân thể được đánh thức và cấp độ kỹ năng đã vượt quá cấp độ do bộ tăng cường linh tri thức cung cấp, không thể sử dụng"
  },
  TipsType_10553_Desc = {
    Text = "Xin hãy mong chờ"
  },
  TipsType_10554_Desc = {
    Text = "Hoàn thành level trước đó để mở khóa"
  },
  TipsType_10555_Desc = {
    Text = "Trên đường dẫn yếu đuối không thể trở lại"
  },
  TipsType_10556_Desc = {
    Text = "Chưa mở, vui lòng đón chờ"
  },
  TipsType_10557_Desc = {
    Text = "Bạn đã sở hữu sáng tạo này, không thể nhận thêm"
  },
  TipsType_10558_Desc = {
    Text = "Sắp nhận nội dung từ bảng tạm nhớ và thực hiện <Positive:[dán]>, \nbạn có xác nhận không?"
  },
  TipsType_10558_LeftBtnDesc = {Text = "Hủy"},
  TipsType_10558_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_10558_Title = {
    Text = "Bật chức năng dán"
  },
  TipsType_10559_Desc = {
    Text = "Thăng cấp không đủ vật liệu"
  },
  TipsType_10560_Desc = {
    Text = "Đã ở trạng thái ban đầu"
  },
  TipsType_10561_Desc = {
    Text = "\"Tường Vi Kim Quyển\" không đủ"
  },
  TipsType_10562_Desc = {
    Text = "Chưa được thăng cấp"
  },
  TipsType_10563_Desc = {
    Text = "Cảm ứng đã đặt lại thành công"
  },
  TipsType_10564_Desc = {
    Text = "Điều tra cấp độ đạt {s1} mở khóa cấp"
  },
  TipsType_10565_Desc = {
    Text = "Điên cuồng đã bị phong ấn và không thể giải phóng"
  },
  TipsType_1056601_Desc = {
    Text = "Liên lạc với bạc tâm gặp vấn đề, kiểm tra mạng và thử lại ({s1})"
  },
  TipsType_10566_Desc = {
    Text = "Giao tiếp bạc tâm gặp sự cố, vui lòng thử lại sau ({s1})"
  },
  TipsType_10567_Desc = {
    Text = "Lấy thông tin máy chủ thất bại! {s1}"
  },
  TipsType_10568_Desc = {
    Text = "Chọn máy chủ trước nhé"
  },
  TipsType_10569_Desc = {
    Text = "Chưa mở khóa"
  },
  TipsType_10570_Desc = {
    Text = "Vui lòng nhập tài khoản"
  },
  TipsType_10571_Desc = {
    Text = "Không đủ vật liệu kích hoạt cảm ứng"
  },
  TipsType_10572_Desc = {
    Text = "Điểm cảm ứng trước không được nâng cấp"
  },
  TipsType_10573_Desc = {
    Text = "Đã đạt cấp tối đa"
  },
  TipsType_10574_Desc = {
    Text = "Nâng cấp thành công"
  },
  TipsType_10575_Desc = {
    Text = "Không thể thay đổi thân thể được đánh thức này"
  },
  TipsType_10576_Desc = {
    Text = "Vị trí này không thể triển khai"
  },
  TipsType_10577_Desc = {
    Text = "Số lượng thân thể được đánh thức không đủ, không đủ điều kiện thách đấu"
  },
  TipsType_10578_Desc = {
    Text = "Chưa thể mở khóa màn chơi tiếp theo"
  },
  TipsType_10579_Desc = {
    Text = "Đây đã là màn chơi cuối cùng rồi"
  },
  TipsType_10580_Desc = {
    Text = "Đã đạt giới hạn kinh nghiệm, không thể tăng thêm"
  },
  TipsType_10581_Desc = {
    Text = "Vòng mệnh đã đầy, không thể thêm"
  },
  TipsType_10582_Desc = {
    Text = "Hiện tại không có vật liệu nào có thể thêm nhanh"
  },
  TipsType_10583_Desc = {
    Text = "Vui lòng đặt vật liệu vào khe vòng mệnh"
  },
  TipsType_10584_Desc = {
    Text = "Không có vòng mệnh để trang bị"
  },
  TipsType_10585_Desc = {
    Text = "Hoàn thành Điều tra 2-8 để mở khóa"
  },
  TipsType_10586_Desc = {
    Text = "Mở khóa sau khi hoàn thành Điều tra 2-14"
  },
  TipsType_10587_Desc = {
    Text = "Hoàn thành Điều tra 3-16 Mở khóa"
  },
  TipsType_10588_Desc = {
    Text = "Mở khóa Hoàn thành Điều tra 4-12"
  },
  TipsType_10589_Desc = {
    Text = "Hoàn thành Điều tra 5-12 để mở khóa"
  },
  TipsType_10590_Desc = {
    Text = "Hoàn thành điều tra 6-12 để được mở"
  },
  TipsType_10591_Desc = {
    Text = "Mở khóa sau khi hoàn thành Điều tra 2-12"
  },
  TipsType_10592_Desc = {
    Text = "Tài khoản người dùng đã bị cấm đăng nhập, nếu có bất kỳ thắc mắc nào vui lòng liên hệ hỗ trợ khách hàng."
  },
  TipsType_10593_Desc = {
    Text = "Phiên đăng nhập đã hết hạn, vui lòng đăng nhập lại."
  },
  TipsType_10594_Desc = {
    Text = "Hiện tại \"Linh Phi Peptide\" không đủ"
  },
  TipsType_10595_Desc = {
    Text = "Có kích hoạt \"{s1}\" không?"
  },
  TipsType_10595_Title = {
    Text = "Kích hoạt khả năng đặc biệt"
  },
  TipsType_10596_Desc = {
    Text = "Chưa có thân thể được đánh thức này"
  },
  TipsType_10597_Desc = {
    Text = "Không có vòng mệnh nào để tăng cường"
  },
  TipsType_10598_Desc = {
    Text = "Tài khoản này đã bị cấm đăng nhập cho đến {s1},nếu có bất kỳ thắc mắc nào vui lòng liên hệ với bộ phận hỗ trợ khách hàng."
  },
  TipsType_10599_Desc = {
    Text = "Hoàn thành điều tra 2-15 để mở khóa"
  },
  TipsType_10600_Desc = {
    Text = "Đã đạt giới hạn cấp độ, không thể tiếp tục thêm"
  },
  TipsType_10601_Desc = {
    Text = "Hoàn thành điều tra 1-7 sẽ mở khóa bản ghi phát triển của Người Giữ Gìn"
  },
  TipsType_10602_Desc = {
    Text = "Hoàn thành điều tra 1-7 để mở nhiệm vụ giới vực chuyên sâu"
  },
  TipsType_10603_Desc = {
    Text = "Chưa chọn tài nguyên"
  },
  TipsType_10604_Desc = {
    Text = "Không có thao tác trong thời gian dài, tự động thoát bản sao"
  },
  TipsType_10605_Desc = {
    Text = "Đã hoàn thành phiếu điều tra, cảm ơn sự hỗ trợ của bạn!"
  },
  TipsType_10606_Desc = {
    Text = "Không đủ nguyên liệu để kích hoạt"
  },
  TipsType_10607_Desc = {
    Text = "Số lần nhận thưởng trong tuần đã hết, thách đấu sau sẽ không nhận được thưởng nữa. Bạn có muốn tiếp tục thách đấu không?"
  },
  TipsType_10607_LeftBtnDesc = {Text = "Hủy"},
  TipsType_10607_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_10607_Title = {
    Text = "Gợi ý thách thức"
  },
  TipsType_10608_Desc = {
    Text = "Đang bảo trì khuôn viên, vui lòng chờ đến khi kết thúc bảo trì"
  },
  TipsType_10609_Desc = {
    Text = "Thành công mời {s1} vào ký túc xá của bạn"
  },
  TipsType_10610_Desc = {
    Text = "{s1} đã ở trong ký túc xá của bạn rồi"
  },
  TipsType_10611_Desc = {
    Text = "Đang sử dụng mạng không phải Wi-Fi, bạn có đồng ý tiếp tục tải về bằng dữ liệu di động không?"
  },
  TipsType_10611_LeftBtnDesc = {Text = "Hủy"},
  TipsType_10611_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_10611_Title = {
    Text = "Xác nhận tải xuống"
  },
  TipsType_10612_Desc = {
    Text = "Tất cả thẻ bài đã được khắcăng"
  },
  TipsType_10613_Desc = {
    Text = "Lỗi mạng, vui lòng đợi"
  },
  TipsType_10614_Desc = {
    Text = "Thử thách hiện tại chưa được mở khóa"
  },
  TipsType_10615_Desc = {
    Text = "Đang trong thời gian hồi chiêu, có thể sử dụng ở lượt tiếp theo."
  },
  TipsType_10616_Desc = {
    Text = "Đang chọn, cần chọn xong mới có thể kích hoạt."
  },
  TipsType_10617_Desc = {
    Text = "Bùng nổ Điên loạn hiện tại không đáp ứng điều kiện kích hoạt, không thể kích hoạt."
  },
  TipsType_10618_Desc = {
    Text = "Đội hình hiện tại có mức trung bình cấp độ {s1} thấp hơn cấp độ đề xuất {s2}, việc điều tra có thể gặp nhiều thách thức, bạn có chắc chắn không?"
  },
  TipsType_10618_LeftBtnDesc = {
    Text = "Tăng cấp ngay"
  },
  TipsType_10618_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_10618_Title = {
    Text = "Xác nhận điều tra"
  },
  TipsType_10619_Desc = {
    Text = "Cần đạt cấp {s1} điều tra để sử dụng"
  },
  TipsType_10620_Desc = {
    Text = "Trạng thái mạng không tốt, vui lòng kiểm tra kết nối Steam hoặc khởi động lại Steam và thử lại"
  },
  TipsType_10621_Desc = {
    Text = "Bạn có xác nhận sử dụng <WeaponEffect_Num:{s1}> làm tên của mình không?"
  },
  TipsType_10621_LeftBtnDesc = {Text = "Hủy"},
  TipsType_10621_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_10621_Title = {
    Text = "Xác nhận khắc"
  },
  TipsType_10622_Desc = {
    Text = "Đang trong thời gian làm lạnh, {s1} giờ {s2} phút sau có thể khắc lại"
  },
  TipsType_10623_Desc = {
    Text = "Khắc thành công"
  },
  TipsType_10624_Desc = {
    Text = "Tên chỉ có thể bao gồm chữ Trung Quốc, tiếng Anh và số"
  },
  TipsType_10625_Desc = {
    Text = "Thẻ này sắp được loại bỏ"
  },
  TipsType_10626_Desc = {
    Text = "Vui lòng bật các tùy chọn sau trên Steam: \n[Cài đặt Steam-Trò chơi-Kích hoạt giao diện Steam trong trò chơi]\nvà khởi động lại trò chơi để thay đổi có hiệu lực."
  },
  TipsType_10626_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_10626_Title = {Text = "Gợi ý"},
  TipsType_10628_Desc = {
    Text = "Tên mới không được trùng với tên hiện tại"
  },
  TipsType_10629_Desc = {
    Text = "Nhập {s1}~{s2} ký tự"
  },
  TipsType_10630_Desc = {
    Text = "{s1}đạt ba sao có thể thử lại"
  },
  TipsType_10631_Desc = {
    Text = "Tài khoản của bạn đã bị đăng xuất cưỡng chế do vi phạm quy định."
  },
  TipsType_10631_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_10631_Title = {
    Text = "Lời nhắc thân thiện"
  },
  TipsType_10632_Desc = {
    Text = "Hoàn thành thách thức, hôm nay có thể tái hiện"
  },
  TipsType_10633_Desc = {
    Text = "Lần phân giải này sẽ tiêu thụ các vật tư sau, <Blue:Sau khi phân giải sẽ không thể khôi phục>, bạn có chắc chắn muốn phân giải không?"
  },
  TipsType_10633_LeftBtnDesc = {Text = "Hủy"},
  TipsType_10633_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_10633_Title = {
    Text = "Xác nhận phân giải"
  },
  TipsType_10634_Desc = {
    Text = "Số ngày còn lại của thẻ tháng hiện tại đã vượt {s1} ngày, không đủ điều kiện cộng dồn."
  },
  TipsType_10635_Desc = {
    Text = "Không đủ Nguồn Dịch, có muốn đến khu trích xuất Nguồn Dịch không?"
  },
  TipsType_10635_LeftBtnDesc = {Text = "Hủy"},
  TipsType_10635_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_10635_Title = {
    Text = "Chất lỏng không đủ"
  },
  TipsType_10636_Desc = {
    Text = "Hiện tại không có vòng mệnh trống"
  },
  TipsType_10637_Desc = {
    Text = "Hiện tại không có bí ẩn nào đang nhàn rỗi"
  },
  TipsType_10638_Desc = {
    Text = "Hiện tại không có vị trí trống để trang bị bí ẩn, vui lòng tháo bỏ bí ẩn sau đó thử lại"
  },
  TipsType_10640_Desc = {
    Text = "Bạn có chắc muốn gỡ bỏ tất cả các bí ẩn của thân thể được đánh thức này không?"
  },
  TipsType_10640_LeftBtnDesc = {Text = "Hủy"},
  TipsType_10640_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_10640_Title = {Text = "Gợi ý"},
  TipsType_10641_Desc = {
    Text = "Bạn cần khởi động lại ứng dụng để thay đổi ngôn ngữ có hiệu lực. Bạn có muốn xác nhận không?"
  },
  TipsType_10641_LeftBtnDesc = {Text = "Hủy"},
  TipsType_10641_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_10641_Title = {
    Text = "Chuyển ngôn ngữ"
  },
  TipsType_10642_Desc = {
    Text = "Cấp độ người chơi chưa đạt"
  },
  TipsType_10643_Desc = {
    Text = "Bước vào khu vực đầy rỗng, sức sống giảm {s1} điểm"
  },
  TipsType_10644_Desc = {
    Text = "Lệnh khóa đã được chọn"
  },
  TipsType_10645_Desc = {
    Text = "Bạn chưa nhận được lệnh khóa này"
  },
  TipsType_10646_Desc = {
    Text = "\"{s1}\" không đủ"
  },
  TipsType_10647_Desc = {
    Text = "Điều tra sự kiện chưa được mở, {s1}"
  },
  TipsType_10648_Desc = {
    Text = "Khoảng cách khe hở đã được cập nhật"
  },
  TipsType_10649_Desc = {
    Text = "Số lượng đơn vị có thể điều động đã đạt mức tối đa"
  },
  TipsType_10650_Desc = {
    Text = "Hiện tại không có nhân vật hiếm bậc SSR đã mở khóa"
  },
  TipsType_10651_Desc = {
    Text = "Cần đạt số lượng thu thập nhất định để sử dụng"
  },
  TipsType_10652_Desc = {
    Text = "Hiện tại không có avatar và biểu cảm trong trận đấu chưa nhận được"
  },
  TipsType_10701_Desc = {
    Text = "Hiện đã trang bị vòng mệnh, hãy tháo bỏ và thử lại."
  },
  TipsType_10702_Desc = {
    Text = "Khi số lớp cộng thêm của vòng mệnh SSR đạt đến 12, thì mới có thể trang bị đồng thời hai vòng mệnh SSR"
  },
  TipsType_10703_Desc = {
    Text = "Thân thể được đánh thức đã trang bị cùng một vòng mệnh, không thể trang bị lại."
  },
  TipsType_10704_Desc = {
    Text = "Cấp bậc bí ẩn đã đạt giới hạn"
  },
  TipsType_10705_Desc = {
    Text = "Số lượng vật liệu đã tiêu thụ đạt giới hạn"
  },
  TipsType_10706_Desc = {
    Text = "Khóa tối đa hai thuộc tính phụ"
  },
  TipsType_10707_Desc = {
    Text = "Chất liệu chuyển bản không đủ"
  },
  TipsType_10708_Desc = {
    Text = "Kích hoạt sau khi thân thể được đánh thức thăng cấp {s1} bậc"
  },
  TipsType_10709_Desc = {
    Text = "\"{s1}\" không đủ"
  },
  TipsType_10710_Desc = {
    Text = "Đã hết hàng"
  },
  TipsType_10711_Desc = {
    Text = "Mặt hàng này chưa được mở khóa"
  },
  TipsType_10712_Desc = {
    Text = "Đã đủ vật liệu"
  },
  TipsType_10713_Desc = {
    Text = "Vòng mệnh vị trí xếp chồng đã đạt giới hạn"
  },
  TipsType_10714_Desc = {
    Text = "Điều kiện sự kiện chưa đạt, không thể chọn"
  },
  TipsType_10715_Desc = {
    Text = "Vui lòng cài đặt ứng dụng phù hợp trước khi chia sẻ"
  },
  TipsType_10716_Desc = {
    Text = "Không thể chọn thêm vòng mệnh nữa"
  },
  TipsType_10717_Desc = {
    Text = "Không thể chọn thêm các lệnh khóa nữa"
  },
  TipsType_10718_Desc = {
    Text = "Kích hoạt thành công"
  },
  TipsType_10719_Desc = {
    Text = "\"Dấu Ấn Ngàn Mặt\" không đủ, có thể chọn đổi vật liệu trong \"Cài đặt hoán đổi\""
  },
  TipsType_10720_Desc = {
    Text = "Đã chuyển sang tốc độ bình thường"
  },
  TipsType_10721_Desc = {
    Text = "Đã chuyển sang tốc độ 2x"
  },
  TipsType_10722_Desc = {
    Text = "Cổng trường đang tắc nghẽn, vui lòng thử lại sau"
  },
  TipsType_10723_Desc = {
    Text = "Lưu thành công"
  },
  TipsType_10724_Desc = {
    Text = "Lưu thất bại, quyền truy cập thư mục ảnh chưa được bật hoặc thiếu bộ nhớ"
  },
  TipsType_10725_Desc = {
    Text = "Tiêu thụ nguyên liệu thiếu"
  },
  TipsType_10726_Desc = {
    Text = "Chọn thẻ bài"
  },
  TipsType_10727_Desc = {
    Text = "Thân thể được đánh thức này đã bị khóa"
  },
  TipsType_10728_Desc = {
    Text = "Hình thái nguồn gốc không thể phái đi, xin vui lòng chọn lại"
  },
  TipsType_10736_Desc = {
    Text = "\"Linh phìpeptide\"đã đủ, không cần thêm"
  },
  TipsType_10737_Desc = {
    Text = "Phát hiện phiên bản trò chơi mới, vui lòng khởi động lại trò chơi ngay lập tức để cập nhật và đảm bảo trải nghiệm bình thường."
  },
  TipsType_10738_Desc = {
    Text = "Hiện không có bài học nào chưa đọc"
  },
  TipsType_10739_Desc = {
    Text = "{s1}đã tham gia thử thách trong {s2}, không thể ra sân lại"
  },
  TipsType_10740_Desc = {
    Text = "Cấp độ điều tra hiện tại {s1} thấp hơn cấp độ đề xuất {s2}, việc điều tra có thể gặp nhiều thách thức, bạn có chắc chắn không?"
  },
  TipsType_10740_LeftBtnDesc = {Text = "Hủy"},
  TipsType_10740_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_10740_Title = {
    Text = "Xác nhận điều tra"
  },
  TipsType_10741_Desc = {
    Text = "Đội ngũ hiện tại có mức trung bình {s1} và cấp độ điều tra của Người Giữ Gìn {s2} đều thấp hơn so với cấp độ đề xuất, điều tra sẽ gặp thách thức rất lớn, bạn có chắc chắn không?"
  },
  TipsType_10741_LeftBtnDesc = {Text = "Hủy"},
  TipsType_10741_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_10741_Title = {
    Text = "Xác nhận điều tra"
  },
  TipsType_10742_Desc = {
    Text = "Các hiệu ứng vòng mệnh giống nhau trong đội không thể được kích hoạt nhiều lần, hiện tại <Blue:{s1}> có vòng mệnh chưa phát huy tác dụng, khuyên Người Giữ Gìn điều chỉnh lại trang bị vòng mệnh rồi hãy tiến hành điều tra. \n có vẫn muốn tiến hành điều tra không?"
  },
  TipsType_10742_LeftBtnDesc = {Text = "Hủy"},
  TipsType_10742_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_10742_Title = {
    Text = "Xác nhận điều tra"
  },
  TipsType_10743_Desc = {
    Text = "Khu vực hạn chế hòa hợp với thiên tai đã hết lượt hỗ trợ chiến đấu"
  },
  TipsType_10744_Desc = {
    Text = "Số người theo dõi đã đạt tối đa"
  },
  TipsType_10745_Desc = {
    Text = "Ngày sinh không chính xác, không thể cài đặt"
  },
  TipsType_10746_Desc = {
    Text = "Đã sao chép vào bộ nhớ tạm"
  },
  TipsType_10747_Desc = {
    Text = "Thích thành công"
  },
  TipsType_10748_Desc = {
    Text = "{s1} đã trở thành thể thức tỉnh hỗ trợ"
  },
  TipsType_10749_Desc = {
    Text = "Thân thể được đánh thức của trợ chiến không được để trống"
  },
  TipsType_10750_Desc = {
    Text = "Hôm nay đã bày tỏ cảm xúc với Người Giữ Gìn rồi"
  },
  TipsType_10751_Desc = {
    Text = "Tối đa có thể hiển thị 4 thể thức tỉnh"
  },
  TipsType_10752_Desc = {
    Text = "Giới vực không đáp ứng yêu cầu, không thể tham gia trận đấu"
  },
  TipsType_10753_Desc = {
    Text = "{s1} đã ra trận, không thể chọn lại"
  },
  TipsType_10754_Desc = {
    Text = "{s1} đã được đặt lại"
  },
  TipsType_10755_Desc = {
    Text = "Giải khóa thành công"
  },
  TipsType_10756_Desc = {
    Text = "Hiện tại không có vật liệu xếp chồng có thể đặt vào"
  },
  TipsType_10757_Desc = {
    Text = "{s1} đã tham gia thử thách trong sự kiện hôm nay, không thể tham gia thêm lần nào trong sự kiện này"
  },
  TipsType_10758_Desc = {
    Text = "Giới vực của đội ngũ không đáp ứng yêu cầu"
  },
  TipsType_10761_Desc = {
    Text = "Thân thể được đánh thức không thể ra trận cùng lúc với hình thái thông thường"
  },
  TipsType_10762_Desc = {
    Text = "Hình thái nguồn gốc của thân thể được đánh thức không thể hiển thị cùng lúc với hình thái bình thường của nó"
  },
  TipsType_10799_Desc = {
    Text = "Hiệu ứng bộ 6 mảnh bí ẩn của <Blue:{s1}> hiện tại chưa có hiệu lực do hạn chế <Blue:đội duy nhất>, khuyên Người Giữ Gìn điều chỉnh lại bí ẩn rồi hãy tiến hành điều tra. \n bạn có muốn tiếp tục điều tra không?"
  },
  TipsType_10799_LeftBtnDesc = {Text = "Hủy"},
  TipsType_10799_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_10799_Title = {
    Text = "Xác nhận điều tra"
  },
  TipsType_10801_Desc = {
    Text = "Số lượng phương án huyền bí đã đạt giới hạn"
  },
  TipsType_10802_Desc = {
    Text = "{s1} đã được sử dụng trong một phương án bí ẩn khác, không thể lưu phương án"
  },
  TipsType_10803_Desc = {
    Text = "Tên phương án bí ẩn không được để trống"
  },
  TipsType_10804_Desc = {
    Text = "Chứa ký tự không hợp lệ, vui lòng nhập lại"
  },
  TipsType_10805_Desc = {Text = "Đã lưu"},
  TipsType_10806_Desc = {
    Text = "Hiện tại, bí ẩn được áp dụng ở {s1}"
  },
  TipsType_10807_Desc = {
    Text = "Đã trang bị"
  },
  TipsType_10808_Desc = {Text = "Đã tháo"},
  TipsType_10809_Desc = {
    Text = "Đội hình hiện tại đã xuất trận"
  },
  TipsType_10810_Desc = {
    Text = "Kế hoạch bí ẩn không thể để trống"
  },
  TipsType_10811_Desc = {
    Text = "Hiện tại đã trang bị phương án này"
  },
  TipsType_10812_Desc = {
    Text = "Đã trang bị"
  },
  TipsType_10813_Desc = {
    Text = "Có xác nhận xóa phương án [{s1}] không?"
  },
  TipsType_10813_LeftBtnDesc = {Text = "Hủy"},
  TipsType_10813_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_10814_Desc = {
    Text = "Lần điều tra này cho thấy rằng thân thể được đánh thức không đáp ứng được yêu cầu của đội"
  },
  TipsType_10815_Desc = {
    Text = "Thân thể được đánh thức hiện tại được thiết kế đặc biệt cho cốt truyện, không thể xem thêm chi tiết"
  },
  TipsType_10816_Desc = {
    Text = "\"Giấy ủy quyền\" không đủ"
  },
  TipsType_10817_Desc = {
    Text = "Hiện tại không có bản ghi kết toán của bạn, vui lòng \"thử thách\" và thực hiện lại sau khi đã kết toán vào lúc 9:00 ngày hôm sau."
  },
  TipsType_10818_Desc = {
    Text = "Hôm nay đã hoàn thành nhiệm vụ ủy quyền, không thể thực hiện lại"
  },
  TipsType_10821_Desc = {
    Text = "Hiện tại không có vật tư, xin quay lại sau"
  },
  TipsType_10822_Desc = {
    Text = "Sự kiện đã kết thúc"
  },
  TipsType_10823_Desc = {
    Text = "Hạt giống đặc biệt hết hàng mới được yêu cầu cửa hàng bổ sung"
  },
  TipsType_10824_Desc = {
    Text = "Đã hết lượt nhập hàng, không còn dự trữ hàng hóa nào nữa"
  },
  TipsType_10825_Desc = {
    Text = "\"{s1}\" không đủ"
  },
  TipsType_10826_Desc = {
    Text = "Hạt giống đặc biệt đã hết, bạn có thể gieo trồng để thiết lập lại"
  },
  TipsType_10827_Desc = {
    Text = "Hạt giống đặc biệt đã reset"
  },
  TipsType_10828_Desc = {
    Text = "Đã đổi hết đồ vật, xin vui lòng reset"
  },
  TipsType_10829_Desc = {
    Text = "Đặt lại thành công"
  },
  TipsType_10830_Desc = {
    Text = "Đội có thân thể được đánh thức không thể ra sân, do đó không thể tham gia điều tra"
  },
  TipsType_10831_Desc = {
    Text = "Trong đội có cùng vòng mệnh, không thể vào khu vực cấm thiên tai"
  },
  TipsType_10832_Desc = {
    Text = "Đội chưa trang bị lệnh khóa, không thể tiến hành điều tra"
  },
  TipsType_10833_Desc = {
    Text = "Trong đội có vòng mệnh không thể trang bị, không thể bắt đầu điều tra"
  },
  TipsType_10834_Desc = {
    Text = "Thân thể được đánh thức để trợ chiến không thể trang bị vòng mệnh"
  },
  TipsType_10835_Desc = {
    Text = "Không thể trang bị bí ẩn cho thân thể được đánh thức"
  },
  TipsType_10836_Desc = {
    Text = "Trong cốt truyện, không thể trang bị vòng mệnh cho thân thể được đánh thức"
  },
  TipsType_10837_Desc = {
    Text = "Không thể trang bị bí ẩn thân thể được đánh thức cho cốt truyện"
  },
  TipsType_10838_Desc = {
    Text = "Số lượng biểu cảm trong phương án đã đạt giới hạn"
  },
  TipsType_10839_Desc = {
    Text = "Biểu cảm đã được sử dụng, nhấp vào biểu cảm trong bộ biểu cảm để gỡ bỏ"
  },
  TipsType_10840_Desc = {
    Text = "Biểu cảm được gửi nhanh quá"
  },
  TipsType_10841_Desc = {
    Text = "Biểu cảm không được để trống"
  },
  TipsType_10842_Desc = {
    Text = "Biểu cảm đã được cập nhật"
  },
  TipsType_10843_Desc = {
    Text = "Mục này chưa được mở khóa"
  },
  TipsType_10844_Desc = {
    Text = "Chưa mở khóa"
  },
  TipsType_10850_Desc = {
    Text = "Đội có chứa lệnh khóa không thể trang bị、không thể tiến hành điều tra"
  },
  TipsType_10901_Desc = {
    Text = "chích điện"
  },
  TipsType_10902_Desc = {Text = "Hôn mê"},
  TipsType_10903_Desc = {
    Text = "Chưa sở hữu: {s1}"
  },
  TipsType_10904_Desc = {
    Text = "Hoàn thành chương này ở chế độ \"thông thường\", rồi mở khóa chế độ \"truy mơ\"để khám phá cốt truyện"
  },
  TipsType_10905_Desc = {
    Text = "Sau khi hoàn thành \"điều tra hành động\" 1-15·phổ thông, bạn sẽ mở khóa \"truy mơ\" và xem cốt truyện"
  },
  TipsType_10906_Desc = {
    Text = "\"Điểm khởi đầu thực tế\" không đủ"
  },
  TipsType_10907_Desc = {
    Text = "Đã mở khóa"
  },
  TipsType_10908_Desc = {
    Text = "{s1} Cấp độ khởi linh đã đầy, tiếp tục nhận sẽ chuyển thành <TipsHighlightText:「Mảnh hồi tố linh hồn」× 2>,<TipsHighlightText:「Căn nguyên lắng đọng」× 250>, bạn có xác nhận thức tỉnh không?"
  },
  TipsType_10908_LeftBtnDesc = {Text = "Hủy"},
  TipsType_10908_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_10908_Title = {
    Text = "Xác nhận thức tỉnh"
  },
  TipsType_10909_Desc = {
    Text = "{s1} đã được thức tỉnh, tiếp tục nhận sẽ chuyển thành <TipsHighlightText:「Mảnh·{s2}」× 1> và <TipsHighlightText:「Căn nguyên lắng đọng」× 50>, bạn có xác nhận thức tỉnh không?"
  },
  TipsType_10909_LeftBtnDesc = {Text = "Hủy"},
  TipsType_10909_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_10909_Title = {
    Text = "Xác nhận thức tỉnh"
  },
  TipsType_10910_Desc = {
    Text = "Có xác nhận thức tỉnh <TipsHighlightText:{s1}> không?"
  },
  TipsType_10910_LeftBtnDesc = {Text = "Hủy"},
  TipsType_10910_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_10910_Title = {
    Text = "Xác nhận thức tỉnh"
  },
  TipsType_10911_Desc = {
    Text = "Không gian không đủ"
  },
  TipsType_10912_Desc = {
    Text = "Hiện chưa có thẻ lệnh trong không gian siêu việt, không thể sử dụng"
  },
  TipsType_10913_Desc = {
    Text = "Không thể dùng lại trong lượt này"
  },
  TipsType_10914_Desc = {
    Text = "Bạn có chắc chắn chọn <TipsHighlightText:{s1}>?"
  },
  TipsType_10914_LeftBtnDesc = {Text = "Hủy"},
  TipsType_10914_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_10914_Title = {
    Text = "Chọn và xác nhận"
  },
  TipsType_10915_Desc = {
    Text = "Giải khóa biên đội cần thực hiện theo thứ tự, không thể bỏ qua biên đội chưa mở khóa"
  },
  TipsType_10916_Desc = {
    Text = "Có tiêu thụ<Blue: {s1} × {s2}> để mở khóa không?"
  },
  TipsType_10916_LeftBtnDesc = {Text = "Hủy"},
  TipsType_10916_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_10916_Title = {
    Text = "Xác nhận mở khóa"
  },
  TipsType_10917_Desc = {
    Text = "Đã mở khóa thành công {s1}"
  },
  TipsType_10918_Desc = {
    Text = "Thành công mở khóa {s1}, đội ngũ đã được mở khóa hoàn toàn"
  },
  TipsType_10919_Desc = {
    Text = "Mở khóa sau khi hoàn thành [{s1}：{s2}] , có phải đi tới [{s1}]?"
  },
  TipsType_10919_LeftBtnDesc = {Text = "Hủy"},
  TipsType_10919_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_10919_Title = {
    Text = "Chưa mở khóa"
  },
  TipsType_10920_Desc = {
    Text = "Trong sự kiện giới hạn \"Pha Ngược\" tích lũy \"Hạt Sồi Phép\" × {s1} để mở khóa, bạn có muốn đến \"Pha Ngược\" không?"
  },
  TipsType_10920_LeftBtnDesc = {Text = "Hủy"},
  TipsType_10920_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_10920_Title = {
    Text = "Chưa mở khóa"
  },
  TipsType_10921_Desc = {
    Text = "Không thể trang bị hai Bánh xe định mệnh có thuộc tính chính giống nhau cùng một lúc"
  },
  TipsType_20001_Desc = {
    Text = "Xác nhận lần hai với dấu chọn"
  },
  TipsType_20001_LeftBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20001_Title = {
    Text = "Tiêu đề"
  },
  TipsType_20002_Desc = {
    Text = "Không có tích chọn xác nhận lần hai"
  },
  TipsType_20002_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20002_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20002_Title = {
    Text = "Tiêu đề"
  },
  TipsType_20003_Desc = {
    Text = "Tài khoản của bạn vừa đăng nhập trên thiết bị khác."
  },
  TipsType_20003_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20003_Title = {
    Text = "Thông báo mất kết nối"
  },
  TipsType_20004_Desc = {
    Text = "Kết nối với máy chủ bị ngắt, vui lòng đăng nhập lại."
  },
  TipsType_20004_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20004_Title = {
    Text = "Thông báo mất kết nối"
  },
  TipsType_20005_Desc = {
    Text = "Đồng bộ thất bại, có thử lại không?"
  },
  TipsType_20005_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20005_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20005_Title = {
    Text = "Lỗi đồng bộ"
  },
  TipsType_20006_Desc = {
    Text = "Mất đồng bộ, sẽ quay lại giao diện đăng nhập trong giây lát."
  },
  TipsType_20006_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20006_Title = {
    Text = "Lỗi đồng bộ"
  },
  TipsType_20007_Desc = {
    Text = "Mất đồng bộ, sẽ quay lại giao diện đăng nhập trong giây lát."
  },
  TipsType_20007_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20007_Title = {
    Text = "Lỗi đồng bộ"
  },
  TipsType_20008_Desc = {
    Text = "Đợt điều tra này tiêu thụ thể lực <Positive:{s1}>, có xác nhận kết thúc không?"
  },
  TipsType_20008_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20008_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20008_Title = {
    Text = "Kết thúc khảo sát"
  },
  TipsType_20009_Desc = {
    Text = "Làm mới sẽ cập nhật khắcăng và sáng tạo, số lần thân thể được đánh thức và bán thẻ lệnh sẽ không được đặt lại, bạn có chắc chắn?"
  },
  TipsType_20009_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20009_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20009_Title = {
    Text = "Xác nhận tải lại"
  },
  TipsType_20010_Desc = {
    Text = "Số lượng thân thể được đánh thức trong giới vực này không đủ, có tiếp tục tạo đội không?"
  },
  TipsType_20010_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20010_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20011_Desc = {
    Text = "Chưa chọn bất kỳ thân thể được đánh thức nào, biên đội sẽ không được bảo lưu."
  },
  TipsType_20011_LeftBtnDesc = {
    Text = "Xác nhận để rời đi"
  },
  TipsType_20011_RightBtnDesc = {
    Text = "Tiếp tục tổ chức biên đội"
  },
  TipsType_20012_Desc = {
    Text = "Chưa chọn thân thể được đánh thức"
  },
  TipsType_20012_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20013_Desc = {
    Text = "Đội ngũ vẫn còn chỗ trống, bạn có chắc chắn muốn khởi hành không?"
  },
  TipsType_20013_LeftBtnDesc = {Text = "Trở về"},
  TipsType_20013_RightBtnDesc = {
    Text = "Khởi hành"
  },
  TipsType_20014_Desc = {
    Text = "Số lượng đội đã đạt đến giới hạn."
  },
  TipsType_20014_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20015_Desc = {
    Text = "Có chắc chắn muốn xóa đội này không?"
  },
  TipsType_20015_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20015_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20016_Desc = {
    Text = "{s1} hoàn thành để mở khóa"
  },
  TipsType_20016_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20017_Desc = {
    Text = "Tại đây có thể xem thông tin bản đồ và thông tin về quái vật đã đánh, phiên bản hiện tại chưa được triển khai"
  },
  TipsType_20017_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20018_Desc = {
    Text = "Chưa đạt điều kiện mở khoá màn chơi"
  },
  TipsType_20018_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20018_Title = {
    Text = "Khảo sát nhanh"
  },
  TipsType_20019_Desc = {
    Text = "\"Bạc tâm\" không đủ, có muốn đi đến cửa hàng mua không?"
  },
  TipsType_20019_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20019_RightBtnDesc = {Text = "Đến"},
  TipsType_20020_Desc = {
    Text = "Nâng cao {s1} mở khóa sau khi hoàn thành"
  },
  TipsType_20020_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20021_Desc = {
    Text = "{s1}Sau khi vượt qua chế độ thông thường, bạn sẽ mở khóa huấn luyện nâng cao"
  },
  TipsType_20021_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20022_Desc = {
    Text = "\"Bạc tâm\" không đủ, Bạn có muốn đến cửa hàng để mua thêm không"
  },
  TipsType_20022_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20022_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20022_Title = {
    Text = "Thiếu bạc tâm"
  },
  TipsType_20023_Desc = {
    Text = "Lần nâng cấp này sẽ vượt quá {s1} điểm kinh nghiệm (không hoàn lại), và sau khi nhân vật đạt đến giới hạn cấp độ thì không thể tiếp tục nhận kinh nghiệm. Bạn có muốn tiếp tục?"
  },
  TipsType_20023_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20023_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20024_Desc = {
    Text = "Đội chưa đủ người, không thể vào phó bản."
  },
  TipsType_20024_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20026_Desc = {
    Text = "Bạn có chắc chắn muốn nạp năng lượng không?"
  },
  TipsType_20026_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20026_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20027_Desc = {
    Text = "Có xác nhận hồi phục sức sống không?"
  },
  TipsType_20027_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20027_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20028_Desc = {
    Text = "Đóng giao diện này sẽ bỏ qua việc nhặt [{s1}]. Bạn có chắc chắn muốn bỏ qua?"
  },
  TipsType_20028_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20028_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20029_Desc = {
    Text = "Đóng giao diện này sẽ bỏ qua sự kiện này (sáng tạo không bị loại bỏ). Bạn có chắc chắn muốn tiếp tục?"
  },
  TipsType_20029_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20029_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20030_Desc = {
    Text = "Đã chọn sáng tạo sẽ không mang theo, có muốn từ bỏ kế thừa không?"
  },
  TipsType_20030_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20030_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20031_Desc = {
    Text = "Bạn có chắc muốn thoát khỏi trận chiến không?"
  },
  TipsType_20031_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20031_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20032_Desc = {
    Text = "Cửa ải hiện tại chưa được mở khóa, bạn có muốn đi điều tra để hoàn thành mở khóa không?"
  },
  TipsType_20032_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20032_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20032_Title = {
    Text = "Chưa mở khóa"
  },
  TipsType_20033_Desc = {
    Text = "Số lần thách đấu hiện tại không đủ, bạn có muốn tiêu thụ\"Bạc tâm\" × 500 để đặt lại không?"
  },
  TipsType_20033_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20033_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20034_Desc = {
    Text = "Đang trong thời gian làm mới thách thức, bạn có muốn tiêu thụ\"Bạc tâm\" × 50 để đặt lại không?"
  },
  TipsType_20034_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20034_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20035_Desc = {
    Text = "Cấp độ khuyến nghị là {s1}, cấp độ trung bình của đội hiện tại là {s2}, cuộc điều tra có thể gặp trở ngại, bạn có muốn tiếp tục không?"
  },
  TipsType_20035_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20035_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20035_Title = {
    Text = "Chiến lực không đủ"
  },
  TipsType_20036_Desc = {
    Text = "Số lần quét hiện tại được đặt là {s1},nhưng thách thức bản sao chỉ tiêu thụ {s2} thể lực để nhận 1 lần thưởng,bạn có chắc chắn muốn thách thức không?"
  },
  TipsType_20036_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20036_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20036_Title = {
    Text = "Thách đấu: Xác nhận"
  },
  TipsType_20037_Desc = {
    Text = "Vật liệu tăng cường bao gồm vật liệu cao cấp, bạn có chắc chắn muốn tăng cường không?"
  },
  TipsType_20037_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20037_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20037_Title = {
    Text = "Xác nhận Tăng cường"
  },
  TipsType_20038_Desc = {
    Text = "Trang bị này đang ở trạng thái khóa, bạn có muốn mở khóa không?"
  },
  TipsType_20038_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20038_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20039_Desc = {
    Text = "Xác nhận sau khi điều tra này thất bại, bạn sẽ không thể nhận được phần thưởng điều tra tiếp theo. Có xác nhận kết thúc điều tra không?"
  },
  TipsType_20039_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20039_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20039_Title = {
    Text = "Thoát điều tra"
  },
  TipsType_20040_Desc = {
    Text = "<WeaponEffect_Num:Chủ động rút khỏi điều tra sẽ tiêu thụ「Linh phìpeptide」× {s1}。>Xác nhận sẽ khiến điều tra thất bại, không nhận được phần thưởng điều tra tiếp theo. Bạn có chắc chắn muốn kết thúc điều tra?"
  },
  TipsType_20040_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20040_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20040_Title = {
    Text = "Thoát điều tra"
  },
  TipsType_20041_BottomDesc = {
    Text = "Hiện tại bạn đang có Giấy phép nén thời gian: {s1}"
  },
  TipsType_20041_Desc = {
    Text = "Có muốn tiêu thụ {s1} giấy phép nén thời gian để tăng tốc không?"
  },
  TipsType_20041_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20041_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20041_Title = {
    Text = "Xác nhận tăng tốc"
  },
  TipsType_20042_Desc = {
    Text = "Trong quá trình điều chỉnh chiến đấu RPG, hiện tại tính thẳng chiến thắng"
  },
  TipsType_20042_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20042_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20043_Desc = {
    Text = "Có muốn chi {s1} bạc tâm để làm mới nhiệm vụ hiện tại không?"
  },
  TipsType_20043_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20043_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20043_Title = {
    Text = "Nhiệm vụ cập nhật"
  },
  TipsType_20044_BottomDesc = {
    Text = "Kiệt sức: {s1} Giấy phép nghiên cứu"
  },
  TipsType_20044_Desc = {
    Text = "Có tiến hành nghiên cứu {s1} không? \nHiệu ứng nghiên cứu: {s2}"
  },
  TipsType_20044_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20044_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20044_Title = {
    Text = "Xác nhận nghiên cứu"
  },
  TipsType_20045_BottomDesc = {
    Text = "Hủy bỏ nghiên cứu mà không lưu giữ tiến trình đã nghiên cứu"
  },
  TipsType_20045_Desc = {
    Text = "Có hủy bỏ nghiên cứu {s1} không? (Hoàn trả toàn bộ giấy phép)"
  },
  TipsType_20045_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20045_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20045_Title = {
    Text = "Nghiên cứu hủy"
  },
  TipsType_20046_Desc = {
    Text = "Có tiêu thụ {s1} \"Bạc tâm\"để tăng tốc không?"
  },
  TipsType_20046_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20046_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20046_Title = {
    Text = "Xác nhận tăng tốc"
  },
  TipsType_20047_Desc = {
    Text = "Thiếu {s1} <Blue:「{s2}」>, có muốn tiêu thụ<Blue:「Bạc tâm」×{s3}>để mua không?"
  },
  TipsType_20047_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20047_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20047_Title = {
    Text = "Xác nhận mua hàng"
  },
  TipsType_20048_Desc = {
    Text = "Thiếu {s1} <Blue:「{s2}」>, có muốn tiêu thụ<Blue:「Bạc tâm」×{s3}>để mua không?"
  },
  TipsType_20048_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20048_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20048_Title = {
    Text = "Xác nhận mua hàng"
  },
  TipsType_20049_Desc = {
    Text = "<Blue:「{s1}」> đã được trang bị bởi <Blue:「{s2}」>, bạn có chắc muốn thay đổi?"
  },
  TipsType_20049_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20049_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20049_Title = {
    Text = "Thay đổi gợi ý"
  },
  TipsType_20050_Desc = {
    Text = "Bạn có chắc chắn muốn tiêu thụ vòng mệnh đã vượt qua vị trí chồng không?"
  },
  TipsType_20050_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20050_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20050_Title = {
    Text = "Gợi ý xếp chồng"
  },
  TipsType_20051_Desc = {
    Text = "Độ chồng hiện tại sẽ vượt quá giới hạn cấp độ chồng của vòng mệnh, sau khi chồng sẽ hoàn trả số vòng mệnh tương ứng dựa trên mức tràn. Bạn có xác nhận không?"
  },
  TipsType_20051_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20051_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20051_Title = {
    Text = "Gợi ý xếp chồng"
  },
  TipsType_20052_Desc = {
    Text = "Cấp độ đề xuất là {s1}, cấp độ trung bình hiện tại của đội là {s2}, cuộc điều tra sẽ gặp nhiều khó khăn, bạn có muốn tiếp tục không?"
  },
  TipsType_20052_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20052_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20052_Title = {
    Text = "Chiến lực không đủ"
  },
  TipsType_20053_Desc = {
    Text = "Cấp độ đề xuất là {s1}, cấp độ trung bình hiện tại của đội là {s2}, cuộc điều tra sẽ gặp nhiều khó khăn, bạn có muốn tiếp tục không?"
  },
  TipsType_20053_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20053_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20053_Title = {
    Text = "Chiến lực không đủ"
  },
  TipsType_20054_Desc = {
    Text = "Phần thưởng thách thức hiện tại đã được nhận hết, tiếp tục thách thức sẽ không nhận được phần thưởng. Bạn có chắc chắn muốn tiếp tục không?"
  },
  TipsType_20054_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20054_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20054_Title = {
    Text = "Thách đấu: Xác nhận"
  },
  TipsType_20055_Desc = {
    Text = "Sau khi đặt lại, tiến trình màn chơi hiện tại sẽ được đặt lại về 0 sao, và bản ghi chiến đấu của thân thể được đánh thức cũng sẽ bị xóa đồng bộ. Bạn có chắc chắn muốn đặt lại không?"
  },
  TipsType_20055_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20055_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20055_Title = {
    Text = "Xác nhận khôi phục cài đặt gốc"
  },
  TipsType_20056_Desc = {
    Text = "Sau khi thách đấu thành công, bốn thân thể được đánh thức trong biên đội hiện tại sẽ không thể tham gia các màn chơi khác của {s1}, bạn có xác nhận thách đấu?"
  },
  TipsType_20056_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20056_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20056_Title = {
    Text = "Thách đấu: Xác nhận"
  },
  TipsType_20057_Desc = {
    Text = "Đội hình vi phạm các hướng dẫn được đề xuất trong Sổ tay Học viện, có muốn tiếp tục thử thách không?"
  },
  TipsType_20057_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20057_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20057_Title = {
    Text = "Xác nhận biên đội"
  },
  TipsType_20058_Desc = {
    Text = "Đã vượt qua thử thách của màn chơi hiện tại, nếu muốn thử thách lại cần phải đặt lại tiến trình màn chơi về 0 sao. Lịch sử chiến đấu của thân thể được đánh thức cũng sẽ bị xóa. Bạn có chắc chắn muốn đặt lại không?"
  },
  TipsType_20058_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20058_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20058_Title = {
    Text = "Xác nhận khôi phục cài đặt gốc"
  },
  TipsType_20059_Desc = {
    Text = "Số lượng thân thể được đánh thức trong đội hiện tại chưa đủ bốn, không thể vào chiến đấu"
  },
  TipsType_20059_Title = {
    Text = "Lưu biên đội"
  },
  TipsType_20060_BottomDesc = {
    Text = "Xác nhận sau sẽ không thể tái thức tỉnh"
  },
  TipsType_20060_Desc = {
    Text = "Bạn có muốn chọn kết quả của lần thức tỉnh này (sẽ nhận được tất cả các thân thể được đánh thức và vòng mệnh từ lần thức tỉnh này) không?"
  },
  TipsType_20060_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20060_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20060_Title = {
    Text = "Xác nhận lựa chọn"
  },
  TipsType_20061_BottomDesc = {
    Text = "Bạc hiện tại: {s1}"
  },
  TipsType_20061_Desc = {
    Text = "Có tiêu {s1} \"Bạc tâm\"để thức tỉnh lại không?\nThức tỉnh lại sẽ không giữ kết quả rút thẻ lần này"
  },
  TipsType_20061_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20061_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20061_Title = {
    Text = "Thức tỉnh"
  },
  TipsType_20062_Desc = {
    Text = "Bạn có chắc muốn xóa tất cả các thư đã đọc không? \n Các thư có phần đính kèm chưa nhận sẽ không bị xóa"
  },
  TipsType_20062_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20062_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20062_Title = {
    Text = "Xóa tin đã đọc"
  },
  TipsType_20063_Desc = {
    Text = "Xác nhận xóa?"
  },
  TipsType_20063_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20063_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20063_Title = {
    Text = "Xóa email hiện tại"
  },
  TipsType_20064_Desc = {
    Text = "Sau khi xóa thư trong hộp bảo quản, bạn sẽ không thể khôi phục lại. \n Bạn có chắc chắn muốn xóa thư này không?"
  },
  TipsType_20064_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20064_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20064_Title = {
    Text = "Xóa thư sưu tầm"
  },
  TipsType_20065_Desc = {
    Text = "Xác nhận tiêu thụ <Blue:{s1}> để tổng hợp <Blue:{s2}>?"
  },
  TipsType_20065_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20065_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20065_Title = {
    Text = "Xác nhận tổng hợp"
  },
  TipsType_20066_Desc = {
    Text = "Xác nhận tách ra <Blue:{s1}, nhận được {s2}>?"
  },
  TipsType_20066_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20066_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20066_Title = {
    Text = "Xác nhận phân giải"
  },
  TipsType_20067_Desc = {
    Text = "Xác nhận tiêu thụ <Blue:{s1}> bí ẩn SSR, in lại <Blue:{s2}> <Blue:{s3}>?"
  },
  TipsType_20067_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20067_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20067_Title = {
    Text = "Xác nhận in lại"
  },
  TipsType_20068_Desc = {
    Text = "Tất cả các thân thể được đánh thức đã hoàn toàn mất khả năng chiến đấu\n\nNgười Giữ Gìn duy nhất\ntiếp theo bạn sẽ chọn gì?"
  },
  TipsType_20068_LeftBtnDesc = {
    Text = "Chiến đấu lại"
  },
  TipsType_20068_RightBtnDesc = {
    Text = "Tạm thời rút lui"
  },
  TipsType_20068_Title = {
    Text = "Điều tra thất bại"
  },
  TipsType_20069_Desc = {
    Text = "Điên cuồng của thân thể được đánh thức đã đầy, bạn có chắc chắn chọn thân thể này không"
  },
  TipsType_20069_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20069_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20069_Title = {
    Text = "Xác nhận"
  },
  TipsType_20070_Desc = {
    Text = "Có xác nhận sử dụng {s1} không? \n Thân thể được đánh thức đã nâng cấp kỹ năng sẽ không hoàn lại vật tư nâng cấp"
  },
  TipsType_20070_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20070_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20070_Title = {
    Text = "Xác nhận cường hóa"
  },
  TipsType_20071_Desc = {
    Text = "Do hạn chế cấp độ điều tra của Người Giữ Gìn, cấp độ thân thể được đánh thức sẽ tăng lên {s1}, vật tư thiếu hụt khi nâng cấp sẽ không được hoàn lại. Bạn có xác nhận tăng cấp không?"
  },
  TipsType_20071_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20071_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20071_Title = {
    Text = "Xác nhận cường hóa"
  },
  TipsType_20072_Desc = {
    Text = "Bạn có muốn bỏ qua toàn bộ cốt truyện của phần này không? \nLưu ý: Sau đó bạn có thể vào lại màn chơi này để xem cốt truyện."
  },
  TipsType_20072_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20072_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20072_Title = {
    Text = "Bỏ qua cốt truyện"
  },
  TipsType_20073_Desc = {
    Text = "Xác nhận phân giải {s1} và nhận {s2}? \n (Bí ẩn hiện tại đã được tăng cường, phân giải sẽ không hoàn lại vật tư tăng cường)"
  },
  TipsType_20073_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20073_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20073_Title = {
    Text = "Xác nhận phân giải"
  },
  TipsType_20074_Desc = {
    Text = "Xác nhận phân giải {s1}, để nhận {s2}? \n (Hiện tại vòng mệnh có độ hiếm cao)"
  },
  TipsType_20074_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20074_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20074_Title = {
    Text = "Xác nhận phân giải"
  },
  TipsType_20075_BottomDesc = {
    Text = "Kiệt sức: {s1} Giấy phép nghiên cứu"
  },
  TipsType_20075_Desc = {
    Text = "Có bắt đầu nghiên cứu {s1} không? \n Hiệu suất sản xuất: {s2} quyền vàng hồng/mỗi 6 giờ \n      ——> {s3} quyền vàng hồng/mỗi 6 giờ"
  },
  TipsType_20075_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20075_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20075_Title = {
    Text = "Xác nhận nghiên cứu"
  },
  TipsType_20076_BottomDesc = {
    Text = "Kiệt sức: {s1} Giấy phép nghiên cứu"
  },
  TipsType_20076_Desc = {
    Text = "Có bắt đầu nghiên cứu {s1} không? \n Hiệu suất sản xuất: {s2} thuốc linh tri thức/6 giờ \n      ——>{s3} thuốc linh tri thức/6 giờ"
  },
  TipsType_20076_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20076_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20076_Title = {
    Text = "Xác nhận nghiên cứu"
  },
  TipsType_20077_BottomDesc = {
    Text = "Kiệt sức: {s1} Giấy phép nghiên cứu"
  },
  TipsType_20077_Desc = {
    Text = "Có bắt đầu nghiên cứu {s1} không? \n Hiệu suất sản xuất: {s2} bí ẩn hồi tích / mỗi 6 giờ \n      —— >{s3} bí ẩn hồi tích / mỗi 6 giờ"
  },
  TipsType_20077_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20077_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20077_Title = {
    Text = "Xác nhận nghiên cứu"
  },
  TipsType_20078_Desc = {
    Text = "Xác nhận bỏ qua toàn bộ cốt truyện này? \nSau đó bạn có thể vào lại level này để xem cốt truyện."
  },
  TipsType_20078_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20078_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20078_Title = {
    Text = "Bỏ qua cốt truyện"
  },
  TipsType_20079_Desc = {
    Text = "Chìa khóa bạc nhận thấy nguy cơ chí mạng, có muốn kích hoạt thể linh tri thức khẩn cấp không? \n (Sự phục sinh sẽ tiêu hao 1 lần thể linh tri thức khẩn cấp, thể linh tri thức khẩn cấp mỗi ngày tự động nhận 1 lần vào lúc 9 giờ, số lần còn lại hiện tại: {s1}/{s2})"
  },
  TipsType_20079_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20079_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20079_Title = {
    Text = "Xác nhận hồi sinh"
  },
  TipsType_20080_Desc = {
    Text = "Chìa khóa bạc nhận thấy nguy cơ chí mạng, có muốn kích hoạt thân thể linh tri thức khẩn cấp không? \n (Sự phục sinh sẽ tiêu thụ 1 lần thân thể linh tri thức khẩn cấp, thân thể linh tri thức khẩn cấp tự động nhận 1 lần vào lúc 9 giờ mỗi ngày, số lần còn lại hiện tại: {s1}/{s2})"
  },
  TipsType_20080_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20080_Title = {
    Text = "Xác nhận hồi sinh"
  },
  TipsType_20081_Desc = {
    Text = "Trò chơi khởi động thất bại. {s1}"
  },
  TipsType_20081_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20081_Title = {
    Text = "Thông báo lỗi đăng nhập"
  },
  TipsType_20082_Desc = {
    Text = "Bạn có muốn tiêu thụ<Blue:「Bạc tâm」× {s1} >để mua<Blue: {s2} >cấp không?"
  },
  TipsType_20082_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20082_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20082_Title = {
    Text = "Nâng cấp độ"
  },
  TipsType_20083_Desc = {
    Text = "Số vòng mệnh {s1} được tiêu thụ, bạn có xác nhận tăng cường không?"
  },
  TipsType_20083_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20083_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20083_Title = {
    Text = "Xác nhận tiêu thụ"
  },
  TipsType_20084_Desc = {
    Text = "Đội ngũ trung bình cấp độ thấp hơn cấp độ đề xuất của ải, thuộc tính của thân thể được đánh thức khi xuất hiện sẽ bị suy yếu. Bạn có muốn tiếp tục điều tra không?"
  },
  TipsType_20084_LeftBtnDesc = {
    Text = "Tăng cấp ngay"
  },
  TipsType_20084_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20084_Title = {
    Text = "Xác nhận điều tra"
  },
  TipsType_20085_Desc = {
    Text = "Xác nhận thoát trò chơi"
  },
  TipsType_20085_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20085_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20085_Title = {
    Text = "Thoát trò chơi"
  },
  TipsType_20086_Desc = {
    Text = "Máy chủ đang bảo trì"
  },
  TipsType_20086_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20086_Title = {
    Text = "Thông báo mất kết nối"
  },
  TipsType_20087_Desc = {
    Text = "Có chắc chắn tiêu thụ<TipsHighlightText:{s1} × {s2}> để mở<TipsHighlightText:{s3}> không?"
  },
  TipsType_20087_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20087_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20087_Title = {
    Text = "Xác nhận kích hoạt"
  },
  TipsType_20088_Desc = {
    Text = "Sau khi nhận,\"Linh phìpeptide\" sẽ tràn ra, phần vượt quá {s1} sẽ không thể nhận được.\nBạn có muốn tiếp tục nhận không?"
  },
  TipsType_20088_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20088_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20088_Title = {
    Text = "Linh phìpeptide tuôn trào"
  },
  TipsType_20089_Desc = {
    Text = "Tiêu thụ\"Tường vi kim quyển\" ×<Blue: {s1} >để làm mới kho hàng \n Số lần làm mới còn lại:<Blue:{s2}> \n Càng làm mới nhiều, càng cần thêm \"Tường vi kim quyển\""
  },
  TipsType_20089_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20089_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20089_Title = {
    Text = "Làm mới danh sách vật phẩm"
  },
  TipsType_20090_Desc = {
    Text = "Số lượng vòng mệnh đã đạt giới hạn, cần phải dọn dẹp vòng mệnh trước khi có thể tiến hành thức tỉnh, có muốn đi không?\n\n<color=#ADC0CB>*có thể thiết lập SR/R cấp vòng mệnh tự động phân giải trong \"Cài đặt\"</color>"
  },
  TipsType_20090_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20090_RightBtnDesc = {
    Text = "Hãy đi dọn dẹp"
  },
  TipsType_20090_Title = {
    Text = "Dọn dẹp gợi ý"
  },
  TipsType_20091_Desc = {
    Text = "Số lượng bí ẩn đã đạt giới hạn, cần phải dọn dẹp bí ẩn trước mới có thể tiến hành điều tra, bạn có muốn đi không?"
  },
  TipsType_20091_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20091_RightBtnDesc = {
    Text = "Hãy đi dọn dẹp"
  },
  TipsType_20091_Title = {
    Text = "Dọn dẹp gợi ý"
  },
  TipsType_20092_Desc = {
    Text = "Bạn có muốn tháo gỡ tất cả vòng mệnh của thân thể được đánh thức hiện tại không?"
  },
  TipsType_20092_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20092_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20092_Title = {
    Text = "Xác nhận gỡ bỏ"
  },
  TipsType_20093_Desc = {
    Text = "Bạn có chắc chắn muốn nâng cấp bằng cách tiêu thụ bí ẩn không?"
  },
  TipsType_20093_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20093_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20093_Title = {
    Text = "Xác nhận nâng cấp"
  },
  TipsType_20094_Desc = {
    Text = "Các thuộc tính phụ hiện tại có một số thuộc tính tốt, việc thay thế này sẽ không được lưu, bạn có chắc chắn muốn thay thế không?"
  },
  TipsType_20094_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20094_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20094_Title = {
    Text = "Xác nhận thay thế"
  },
  TipsType_20095_Desc = {
    Text = "Các thuộc tính phụ hiện tại khá tốt, tiếp tục sẽ không lưu. Bạn có chắc chắn muốn tiếp tục không?"
  },
  TipsType_20095_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20095_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20095_Title = {
    Text = "Xác nhận phiên bản chuyển đổi"
  },
  TipsType_20096_Desc = {
    Text = "Sau khi nâng cấp mật khế sẽ vượt quá giới hạn cấp độ. Khi vượt quá, hệ thống sẽ hoàn trả vật liệu chuyển bản. Bạn có xác nhận không?"
  },
  TipsType_20096_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20096_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20096_Title = {
    Text = "Xác nhận nâng cấp"
  },
  TipsType_20097_Desc = {
    Text = "Thể thức tỉnh này đã khai linh đầy\nSau khi chọn chỉ nhận được \"Mảnh hồi tố linh hồn\" ×1"
  },
  TipsType_20097_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20097_RightBtnDesc = {
    Text = "Tiếp tục"
  },
  TipsType_20097_Title = {
    Text = "Xác nhận lựa chọn"
  },
  TipsType_20098_Desc = {
    Text = "Sản phẩm có thể được mua bằng <Blue:{s1}> Phiếu Giao Dịch Bạc Mật"
  },
  TipsType_20098_LeftBtnDesc = {
    Text = "Trả bằng tiền mặt"
  },
  TipsType_20098_RightBtnDesc = {
    Text = "Thanh toán chứng từ"
  },
  TipsType_20098_Title = {
    Text = "Chọn cách thức thanh toán"
  },
  TipsType_20099_Desc = {
    Text = "Bạn có muốn thoát khỏi trò chơi không?"
  },
  TipsType_20099_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20099_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20099_Title = {Text = "Gợi ý"},
  TipsType_20100_Desc = {
    Text = "Phát hiện phiên bản trò chơi mới, xin vui lòng khởi động lại trò chơi để cập nhật tài nguyên"
  },
  TipsType_20100_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20100_Title = {
    Text = "Thông báo cập nhật"
  },
  TipsType_20101_Desc = {
    Text = "Cuộc điều tra đã hoàn thành, bạn có muốn bỏ qua cốt truyện khi điều tra lại không?"
  },
  TipsType_20101_LeftBtnDesc = {
    Text = "Bỏ qua cốt truyện"
  },
  TipsType_20101_RightBtnDesc = {
    Text = "Bảo lưu cốt truyện"
  },
  TipsType_20101_Title = {
    Text = "Xác nhận tiến trình"
  },
  TipsType_20102_Desc = {
    Text = "Có chắc bạn không muốn theo dõi {s1} nữa?"
  },
  TipsType_20102_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20102_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20102_Title = {
    Text = "Bỏ theo dõi"
  },
  TipsType_20103_Desc = {
    Text = "Sự kiện diễn ra <WeaponEffect_Num:miễn phí trong thời gian giới hạn> mở khóa, có muốn mở khóa không?"
  },
  TipsType_20103_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20103_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20103_Title = {
    Text = "Phúc lợi hoạt động"
  },
  TipsType_20105_Desc = {
    Text = "Để đảm bảo trải nghiệm cốt truyện tốt nhất, khuyến nghị hoàn thành các cấp độ điều tra sau đây."
  },
  TipsType_20105_LeftBtnDesc = {Text = "Thoát"},
  TipsType_20105_RightBtnDesc = {
    Text = "Vẫn phải điều tra"
  },
  TipsType_20105_Title = {
    Text = "Xác nhận điều tra"
  },
  TipsType_20106_Desc = {
    Text = "Có tiêu thụ<Blue:「Nguồn dịch」× {s1} >để mua không?"
  },
  TipsType_20106_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20106_RightBtnDesc = {Text = "Mua"},
  TipsType_20106_Title = {
    Text = "Xác nhận mua hàng"
  },
  TipsType_20107_Desc = {
    Text = "Bạn có chắc muốn chọn <Blue:{s1}> không?"
  },
  TipsType_20107_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20107_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20107_Title = {
    Text = "Chọn xác nhận"
  },
  TipsType_20108_Desc = {
    Text = "Lần này sẽ tiêu thụ vật phẩm hiếm \"mẫu lặp\"\nBạn có muốn tiếp tục không?"
  },
  TipsType_20108_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20108_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20108_Title = {
    Text = "Xác nhận tiêu thụ"
  },
  TipsType_20109_Desc = {
    Text = "Bạn có chắc muốn bắt đầu lại cuộc chiến đấu này không?"
  },
  TipsType_20109_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20109_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20109_Title = {
    Text = "Chiến đấu lại"
  },
  TipsType_20110_Desc = {
    Text = "Bạn có chắc chắn chọn ngày {s1} tháng {s2} làm sinh nhật của bạn không?\nSau khi xác nhận sẽ không thể thay đổi."
  },
  TipsType_20110_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20110_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20110_Title = {
    Text = "Xác nhận ngày sinh"
  },
  TipsType_20111_Desc = {
    Text = "Để đảm bảo trải nghiệm cốt truyện tốt nhất, khuyến nghị hoàn thành các cấp độ điều tra sau đây."
  },
  TipsType_20111_LeftBtnDesc = {Text = "Thoát"},
  TipsType_20111_RightBtnDesc = {
    Text = "Vẫn phải điều tra"
  },
  TipsType_20111_Title = {
    Text = "Xác nhận điều tra"
  },
  TipsType_20112_Desc = {
    Text = "Để đảm bảo trải nghiệm cốt truyện tốt nhất, khuyên bạn nên hoàn thành các cấp độ điều tra sau đây."
  },
  TipsType_20112_LeftBtnDesc = {Text = "Thoát"},
  TipsType_20112_RightBtnDesc = {
    Text = "Vẫn phải điều tra"
  },
  TipsType_20112_Title = {
    Text = "Xác nhận điều tra"
  },
  TipsType_20113_Desc = {
    Text = "Có đánh dấu tất cả nội dung hướng dẫn đã nhận được là đã đọc và nhận phần thưởng hướng dẫn không? (Đề nghị các Người Giữ Gìn mới nhập học đọc kỹ nội dung hướng dẫn~)"
  },
  TipsType_20113_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20113_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20113_Title = {
    Text = "Xác nhận đọc ngay"
  },
  TipsType_20114_Desc = {
    Text = "Xác nhận chọn <WeaponEffect_Num: {s1}> để kích hoạt hoài suyệt không? \nThao tác này không thể hoàn tác, vui lòng kiểm tra kỹ"
  },
  TipsType_20114_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20114_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20114_Title = {
    Text = "Lựa chọn hồi tưởng"
  },
  TipsType_201151_Desc = {
    Text = "Người đánh thức hiện tại không có khai ngộ, không cần thực hiện hồi tưởng khai ngộ"
  },
  TipsType_20115_Desc = {
    Text = "Hiện tại, thân thể được đánh thức chưa trải qua bất kỳ quá trình nuôi dưỡng nào, không cần thực hiện hồi suyệt"
  },
  TipsType_20116_Desc = {
    Text = "<WeaponEffect_Num:{s1}> đã kích hoạt phục hồi ký ức.\nBạn có muốn ngay lập tức tiến hành phục hồi ký ức không?"
  },
  TipsType_20116_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20116_RightBtnDesc = {Text = "Đến"},
  TipsType_20116_Title = {
    Text = "Mở thành công"
  },
  TipsType_20117_Desc = {
    Text = "Sắp đặt lại trạng thái nâng cấp, khai sáng, kỹ năng, thiên phú và tri thức của người đánh thức, và hoàn trả kiệt sức tương ứng.\nXác nhận hồi phục nuôi dưỡng <WeaponEffect_Num:{s1}> không?"
  },
  TipsType_20117_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20117_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20117_Title = {
    Text = "Thiết lập lại tiến trình"
  },
  TipsType_20118_Desc = {
    Text = "Sắp đặt lại cấp độ khởi linh của thân thể được đánh thức và hoàn trả tiêu thụ khởi linh. \n Bạn có xác nhận thực hiện hồi tố khởi linh cho <WeaponEffect_Num:{s1}> không?"
  },
  TipsType_20118_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20118_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20118_Title = {
    Text = "Thiết lập lại Sự khai sáng"
  },
  TipsType_20119_Desc = {
    Text = "Sắp đặt lại trạng thái nâng cấp, khai sáng, kỹ năng, khởi linh, tài năng và sự thâm nhập linh tri thức của thể thức tỉnh, hoàn trả tiêu thụ tương ứng, \n và sẽ trả lại thể thức tỉnh về hồ đen. \n Bạn có xác nhận thực hiện việc trả lại <WeaponEffect_Num:{s1}> về hồ đen không?"
  },
  TipsType_20119_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20119_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20119_Title = {
    Text = "Trả lại hồ đen"
  },
  TipsType_20120_Desc = {
    Text = "Thân thể được đánh thức đặc biệt không thể trả lại"
  },
  TipsType_20121_Desc = {
    Text = "Sắp đặt lại trạng thái chồng vị của vòng mệnh và hoàn trả tất cả tiêu thụ chồng vị. \n Bạn có xác nhận thực hiện việc hồi suyết <WeaponEffect_Num:{s1}> không?"
  },
  TipsType_20121_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20121_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20121_Title = {
    Text = "Diệp Vị Hồi Tố"
  },
  TipsType_20122_Desc = {
    Text = "Sắp đặt về trạng thái chồng vị của vòng mệnh, hoàn trả tất cả tiêu thụ chồng vị và trả lại vòng mệnh vào hồ đen. \nBạn có chắc chắn muốn trả lại <WeaponEffect_Num:{s1}> vào hồ đen không?"
  },
  TipsType_20122_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20122_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20122_Title = {
    Text = "Trả lại hồ đen"
  },
  TipsType_20123_Desc = {
    Text = "Sau khi hoàn thành thách thức, các thân thể được đánh thức, vòng mệnh và lệnh khóa trong đội sẽ không thể ra trận ở các khu cấm địa hòa hợp với thiên tai khác. Bạn có muốn xác nhận không?"
  },
  TipsType_20123_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20123_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20123_Title = {
    Text = "Thách đấu: Xác nhận"
  },
  TipsType_20124_Desc = {
    Text = "Sau khi đặt lại, các thân thể được đánh thức, vòng mệnh và mật lệnh của đội điều tra hiện tại đều có thể ra trận lại, nhưng điểm huấn luyện có được từ màn chơi này cũng sẽ bị trừ (không ảnh hưởng đến trạng thái thưởng), bạn có chắc chắn muốn đặt lại không?"
  },
  TipsType_20124_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20124_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20124_Title = {
    Text = "Xác nhận khôi phục cài đặt gốc"
  },
  TipsType_20125_Desc = {
    Text = "Độ cấp vòng mệnh hiện tại là 0, không cần hồisuyệt"
  },
  TipsType_20126_Desc = {
    Text = "Thân thể được đánh thức đang thực hiện nhiệm vụ, vui lòng triệu hồi lại trước khi thực hiện truy ngược hoặc trả lại"
  },
  TipsType_20127_Desc = {
    Text = "Hiện tại vòng mệnh đã bị khóa, xin vui lòng mở khóa trước khi tiến hành trả lại"
  },
  TipsType_20128_Desc = {
    Text = "{s1} đã thông qua, cần phải đặt lại mới có thể thách đấu, bạn có xác nhận đặt lại không? \n (Sau khi đặt lại, các thân thể được đánh thức, vòng mệnh và mật lệnh trong đội điều tra có thể ra trận lại, nhưng điểm huấn luyện có được từ màn chơi này cũng sẽ bị trừ.)"
  },
  TipsType_20128_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20128_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20128_Title = {
    Text = "Xác nhận khôi phục cài đặt gốc"
  },
  TipsType_20129_Desc = {
    Text = "Để đảm bảo trải nghiệm cốt truyện tốt nhất, nên hoàn thành các cấp độ điều tra sau đây."
  },
  TipsType_20129_LeftBtnDesc = {Text = "Thoát"},
  TipsType_20129_RightBtnDesc = {
    Text = "Vẫn phải điều tra"
  },
  TipsType_20129_Title = {
    Text = "Xác nhận điều tra"
  },
  TipsType_20130_Desc = {
    Text = "Để đảm bảo trải nghiệm cốt truyện tốt nhất, khuyến nghị hoàn thành các cấp độ điều tra sau đây."
  },
  TipsType_20130_LeftBtnDesc = {Text = "Thoát"},
  TipsType_20130_RightBtnDesc = {
    Text = "Vẫn phải điều tra"
  },
  TipsType_20130_Title = {
    Text = "Xác nhận điều tra"
  },
  TipsType_20131_Desc = {
    Text = "Để đảm bảo trải nghiệm cốt truyện tốt nhất, nên hoàn thành các cấp độ điều tra sau đây."
  },
  TipsType_20131_LeftBtnDesc = {Text = "Thoát"},
  TipsType_20131_RightBtnDesc = {
    Text = "Vẫn phải điều tra"
  },
  TipsType_20131_Title = {
    Text = "Xác nhận điều tra"
  },
  TipsType_20132_Desc = {
    Text = "Sau khi tích, nếu có đủ <TipsHighlightText:bí-ẩn-tàn-bản> thì sẽ ưu tiên tiêu thụ tàn bản. \nNếu tàn bản không đủ, sẽ tự động tiêu thụ <TipsHighlightText:「{s1}」> để bù đắp tàn bản."
  },
  TipsType_20132_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20132_RightBtnDesc = {
    Text = "Vẫn cần tích"
  },
  TipsType_20132_Title = {
    Text = "Tự động bổ sung"
  },
  TipsType_20133_Desc = {
    Text = "Có nên tiến hành linh tri thức sâu hóa cho <TipsHighlightText:「{s1}」>?"
  },
  TipsType_20133_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20133_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20133_Title = {
    Text = "Sự thâm nhập linh tri"
  },
  TipsType_20134_Desc = {
    Text = "Để đảm bảo trải nghiệm cốt truyện tốt nhất, đề nghị hoàn thành các nhiệm vụ điều tra sau."
  },
  TipsType_20134_LeftBtnDesc = {Text = "Thoát"},
  TipsType_20134_RightBtnDesc = {
    Text = "Vẫn phải điều tra"
  },
  TipsType_20134_Title = {
    Text = "Xác nhận điều tra"
  },
  TipsType_20137_Desc = {
    Text = "Xác nhận tiêu thụ <Blue:「{s1}」×{s2}> để mở khóa bản nhạc này?"
  },
  TipsType_20137_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20137_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20137_Title = {
    Text = "Xác nhận mở khóa"
  },
  TipsType_20138_Desc = {
    Text = "Trong thời gian sự kiện <Blue:miễn phí có thời hạn> mở khóa, mở khóa không?"
  },
  TipsType_20138_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20138_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20138_Title = {
    Text = "Xác nhận mở khóa"
  },
  TipsType_20139_Desc = {
    Text = "Xác nhận tiêu thụ <Blue:「{s1}」×{s3}> để kích hoạt <Blue:「{s2}」>?"
  },
  TipsType_20139_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20139_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20139_Title = {
    Text = "Xác nhận mở khóa"
  },
  TipsType_20140_Desc = {
    Text = "<Blue:「{s1}」> đã đạt giới hạn sở hữu, tiếp tục nhận sẽ không thể nhận được đạo cụ này. Có muốn nhận không?"
  },
  TipsType_20140_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20140_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20140_Title = {
    Text = "Xác nhận"
  },
  TipsType_20141_Desc = {
    Text = "Có muốn bỏ qua chiến đấu và tiêu diệt kẻ địch ngay lập tức bằng cách sử dụng 30% sức sống tối đa ({s1}) không?\n\nSức sống hiện tại:{s2}"
  },
  TipsType_20141_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20141_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20141_Title = {
    Text = "bộ nhớ cơ bắp"
  },
  TipsType_20142_Desc = {
    Text = "Có muốn mất <color=#BB646D> {s1} </color> điểm sức sống để nhận {s2} dấu đen không?"
  },
  TipsType_20142_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20142_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20142_Title = {
    Text = "Xác nhận điều tra"
  },
  TipsType_20145_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20145_Title = {
    Text = "Thưởng đăng nhập"
  },
  TipsType_20151_Desc = {
    Text = "Sau khi đặt lại, số lượng \"vật phẩm đặc biệt\" còn lại sẽ được đặt lại về mức tối đa, bạn có chắc chắn không?"
  },
  TipsType_20151_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20151_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20151_Title = {
    Text = "Xác nhận khôi phục cài đặt gốc"
  },
  TipsType_20152_Desc = {
    Text = "\"{s1}\" không đủ, có sử dụng \"Quyền vàng hồng\" × {s2} để bù đắp không?"
  },
  TipsType_20152_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20152_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20152_Title = {
    Text = "Xác nhận kích hoạt"
  },
  TipsType_20153_Desc = {
    Text = "Sau khi đặt lại, số lượng còn lại của \"vật phẩm đặc biệt\" và \"vật phẩm thông thường\" sẽ được đặt lại về giới hạn tối đa. \nLần thứ {s1} và sau đó, \"vật phẩm đặc biệt\" sẽ không còn được đặt lại. \nBạn có xác nhận không?"
  },
  TipsType_20153_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20153_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20153_Title = {
    Text = "Xác nhận khôi phục cài đặt gốc"
  },
  TipsType_20154_Desc = {
    Text = "Sau khi đặt lại, số lượng còn lại của 「vật phẩm đặc biệt」 và 「vật phẩm thông thường」 sẽ được đặt lại về giới hạn tối đa.\nLần thứ 3 và sau đó, 「vật phẩm đặc biệt」 sẽ không còn được đặt lại.\n<Blue:Vẫn còn 「vật phẩm thông thường」>, bạn có chắc chắn không?"
  },
  TipsType_20154_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20154_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20154_Title = {
    Text = "Xác nhận khôi phục cài đặt gốc"
  },
  TipsType_20155_Desc = {
    Text = "Vật liệu đặt chồng có chứa vòng mệnh đã bị khóa, bạn có xác nhận tiêu thụ để sử dụng cho đặt chồng không?"
  },
  TipsType_20155_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20155_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20155_Title = {
    Text = "Xác nhận chồng lớp"
  },
  TipsType_20156_Desc = {
    Text = "Có xác nhận tiêu thụ <TipsHighlightText:「Điểm khởi đầu thực tế」× 1> để mở khóa không?\n(Trong thời gian sự kiện Dục Hải Lật Sóng, số「Điểm khởi đầu thực tế」cần để mở khóa giảm từ {s1} xuống còn {s2}.)"
  },
  TipsType_20156_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20156_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20156_Title = {
    Text = "Xác nhận mở khóa"
  },
  TipsType_20157_Desc = {
    Text = "Có xác nhận tiêu thụ <TipsHighlightText:「Điểm khởi đầu thực tế」× {s1}> để mở khóa?"
  },
  TipsType_20157_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20157_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20157_Title = {
    Text = "Xác nhận mở khóa"
  },
  TipsType_20158_Desc = {
    Text = "Cấp độ hiện tại đã hết hạn, sau khi hoàn thành thách thức sẽ không nhận được phần thưởng, bạn có muốn thoát không?"
  },
  TipsType_20158_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20158_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20158_Title = {
    Text = "Xác nhận thoát"
  },
  TipsType_20159_Desc = {
    Text = "<TipsHighlightText:「{s1}」>vượt quá giới hạn<TipsHighlightText: {s2}>cái, mỗi cái được chuyển thành<Blue:「Thiệp Mời Vô Hình」× 1>"
  },
  TipsType_20159_Title = {
    Text = "Thông báo chuyển đổi"
  },
  TipsType_20160_Desc = {
    Text = "Bạn đã mở khóa<TipsHighlightText:「{s1}」>\nLợi ích miễn phí mở khóa sự kiện này sẽ cung cấp cho bạn các phần thưởng sau."
  },
  TipsType_20160_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20160_Title = {
    Text = "Thông báo bù đắp"
  },
  TipsType_20161_Desc = {
    Text = "<TipsHighlightText:「{s1}」>vượt quá giới hạn<TipsHighlightText: {s2}>cái, mỗi cái đã được chuyển đổi thành<Blue:「Phiếu Vàng Tường Vi」× 5000>"
  },
  TipsType_20161_Title = {
    Text = "Thông báo chuyển đổi"
  },
  TipsType_20162_Desc = {
    Text = "Sắp đặt lại trạng thái nâng cấp, khai sáng, kỹ năng, thiên phú và tri thức của người đánh thức, và hoàn trả kiệt sức tương ứng.\nXác nhận hồi phục nuôi dưỡng <WeaponEffect_Num:{s1}> không?"
  },
  TipsType_20162_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20162_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20162_Title = {
    Text = "Thiết lập lại tiến trình"
  },
  TipsType_20163_Desc = {
    Text = "Sẽ reset trạng thái khai ngộ của người đánh thức, và hoàn trả chi phí tương ứng.\nXác nhận có tiến hành nuôi dưỡng hồi tưởng cho <WeaponEffect_Num:{s1}> không?"
  },
  TipsType_20163_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20163_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20163_Title = {
    Text = "Thiết lập lại Sự khai sáng"
  },
  TipsType_20164_Desc = {
    Text = "Sắp đặt lại trạng thái nâng cấp, khai sáng, kỹ năng, tài năng, khởi linh và sự thâm nhập linh tri thức của thể thức tỉnh, hoàn trả tiêu thụ tương ứng, \n và sẽ trả lại thể thức tỉnh vào hồ đen. \n Bạn có xác nhận thực hiện việc trả lại <WeaponEffect_Num:{s1}> vào hồ đen không?"
  },
  TipsType_20164_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20164_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20164_Title = {
    Text = "Trả lại hồ đen"
  },
  TipsType_20165_Desc = {
    Text = "<WeaponEffect_Num:{s1}> thuộc về thể thức tỉnh đặc biệt, chỉ có thể hồi tưởng nâng cấp, khai sáng, kỹ năng, tài năng và sự thâm nhập linh tri, <Red: không thể hồi tưởng khởi linh> , bạn có xác nhận chọn <WeaponEffect_Num:{s1}> để kích hoạt hồi tưởng không? \n Thao tác này không thể hoàn tác, vui lòng kiểm tra kỹ"
  },
  TipsType_20165_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20165_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20165_Title = {
    Text = "Lựa chọn hồi tưởng"
  },
  TipsType_20166_Desc = {
    Text = "Người đánh thức đặc biệt không thể thực hiện khai ngộ hồi tưởng"
  },
  TipsType_20167_Desc = {
    Text = "Đợt hồi tưởng này đã sử dụng \"Hồi tưởng phát triển\", xin hãy tiếp tục sử dụng \"Hồi tưởng phát triển\" khi mở lại vào lần tới."
  },
  TipsType_20168_Desc = {
    Text = "Đợt hồi tưởng này đã sử dụng \"Hồi tưởng khai ngộ\", xin hãy tiếp tục sử dụng \"Hồi tưởng khai ngộ\" khi mở lại vào lần tới."
  },
  TipsType_20169_BottomDesc = {
    Text = "<Blue: Lưu ý: Sau khi chọn, không thể thay đổi hoạt động này nữa!>"
  },
  TipsType_20169_Desc = {
    Text = "Có xác nhận lựa chọn người đánh thức <OrangeQuality:「{s1}」> và bánh xe định mệnh đề cử <OrangeQuality:「{s2}」>, như là định hướng UP cho hoạt động lần này."
  },
  TipsType_20169_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20169_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20169_Title = {
    Text = "Xác nhận lựa chọn"
  },
  TipsType_20170_Desc = {
    Text = "Đã đạt đến giới hạn thách thức hàng ngày, hãy quay lại thách thức vào ngày mai nhé!"
  },
  TipsType_20171_Desc = {
    Text = "Bây giờ có thể đến \"Lao xuống huyễn tưởng\"!"
  },
  TipsType_20173_Desc = {
    Text = "Bây giờ có thể đến \"Bẫy\"!"
  },
  TipsType_20174_Desc = {
    Text = "Bây giờ có thể đến \"Hoạt động·Khó khăn\"!"
  },
  TipsType_20175_Desc = {
    Text = "Bây giờ có thể đến \"Tồn tại siêu việt\"!"
  },
  TipsType_20176_Desc = {
    Text = "Bây giờ có thể đến \"Khu vực d-khu vực\"!"
  },
  TipsType_20177_Desc = {
    Text = "Bây giờ có thể đến \"Cuồng loạn\"!"
  },
  TipsType_20178_Desc = {
    Text = "Bây giờ có thể đến trang bị\"Bánh xe định mệnh thứ hai\" rồi!"
  },
  TipsType_20179_Desc = {
    Text = "Bây giờ có thể đến \"Cụm hỗn loạn\"!"
  },
  TipsType_20180_Desc = {
    Text = "Bây giờ có thể đến \"Điều cấm kỵ\"!"
  },
  TipsType_20181_Desc = {
    Text = "Bây giờ có thể đến \"Nâng cấp giao ước\"!"
  },
  TipsType_20182_Desc = {
    Text = "Bây giờ có thể đến \"Phiên bản giao ước\"!"
  },
  TipsType_20183_Desc = {
    Text = "Hoạt động hiện tại đã kết thúc"
  },
  TipsType_20184_Desc = {
    Text = "Bây giờ có thể đến \"Hồ Sơ Học Tịch\"!"
  },
  TipsType_20185_Desc = {
    Text = "Xác nhận bỏ qua tất cả cốt truyện trong đoạn này?"
  },
  TipsType_20185_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20185_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20185_Title = {
    Text = "Bỏ qua cốt truyện"
  },
  TipsType_20186_Desc = {
    Text = "Tải xuống dữ liệu cần thiết để chạy trò chơi.\nCó tiếp tục không?\n\n*Đề nghị tải xuống dưới môi trường WiFi."
  },
  TipsType_20186_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20186_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20187_Desc = {
    Text = "Tải xuống tài nguyên hoàn tất"
  },
  TipsType_20187_LeftBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20188_Desc = {
    Text = "Không đủ không gian lưu trữ, cần thiết phải dự trữ ít nhất {s1} không gian lưu trữ, nếu không có thể dẫn đến mất mát tài nguyên trong quá trình chạy, có tiếp tục tải xuống mới không?"
  },
  TipsType_20188_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20188_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20189_Desc = {
    Text = "Tải xuống tài nguyên thất bại, có muốn thử lại không?"
  },
  TipsType_20189_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20189_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20190_Desc = {
    Text = "<TipsHighlightText:{s1}>vượt quá giới hạn<TipsHighlightText: {s2}>mỗi cái đã được chuyển thành<Blue:{s3}>"
  },
  TipsType_20190_Title = {
    Text = "Thông báo chuyển đổi"
  },
  TipsType_20191_Desc = {
    Text = "Bây giờ bạn có thể đến \"Sự kiện\"!"
  },
  TipsType_20192_Desc = {
    Text = "Tải xuống dữ liệu cần thiết để chơi phần tiếp theo của đoạn mở đầu.\nKích thước tài nguyên: {s1}\nCó tiếp tục không？\n\n*Nên tải về trong môi trường WiFi."
  },
  TipsType_20192_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20192_RightBtnDesc = {
    Text = "Tải xuống"
  },
  TipsType_20193_Desc = {
    Text = "Bây giờ có thể đến \"Hủy diệt\"!"
  },
  TipsType_20194_Desc = {
    Text = "Bây giờ có thể đến \"Giao tiếp Bạc\" rồi!"
  },
  TipsType_20195_Desc = {
    Text = "Bây giờ có thể đến \"Đề Tài Học Kỳ\"!"
  },
  TipsType_20196_Desc = {
    Text = "Bây giờ có thể đến \"Cõi tối\"!"
  },
  TipsType_20197_Desc = {
    Text = "Đã đạt tối đa số lần có thể thức tỉnh, xin hãy đến nhận phần thưởng nhiệm vụ!"
  },
  TipsType_20198_Desc = {
    Text = "Vẫn chưa hoàn thành nhiệm vụ, vui lòng hoàn thành nhiệm vụ trước khi trở lại nhận thưởng!"
  },
  TipsType_20199_Desc = {
    Text = "Sau khi nhận,\"Giấy ủy quyền\" sẽ vượt quá giới hạn sở hữu,\nphần vượt quá sẽ bị mất.\nBạn có muốn tiếp tục nhận không?"
  },
  TipsType_20199_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20199_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20199_Title = {
    Text = "Xác nhận"
  },
  TipsType_20200_Desc = {
    Text = "Đăng ký đại lý thử huấn sẽ tiêu thụ <Blue:「Giấy ủy quyền」× 1>\nSau khi đăng ký sẽ trực tiếp hoàn thành thử huấn hàng ngày, bạn có xác nhận không?"
  },
  TipsType_20200_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20200_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20200_Title = {
    Text = "Xác nhận quyền đại lý"
  },
  TipsType_20201_Desc = {
    Text = "Dưới đây là bí ẩn đang được trang bị, có muốn thay thế không?"
  },
  TipsType_20201_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20201_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20201_Title = {
    Text = "Xác nhận thay thế"
  },
  TipsType_20202_Desc = {
    Text = "Hiện đang áp dụng cho {s1}, bạn có chắc chắn muốn xóa [{s2}] không?"
  },
  TipsType_20202_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20202_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20202_Title = {
    Text = "Xác nhận xóa"
  },
  TipsType_20203_Desc = {
    Text = "Các hiệu ứng vòng mệnh giống nhau trong đội không thể được kích hoạt nhiều lần, {s1} đã được trang bị trong đội hiện tại, bạn có chắc chắn muốn trang bị không?"
  },
  TipsType_20203_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20203_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20203_Title = {
    Text = "Xác nhận trang bị đã chọn"
  },
  TipsType_20204_Desc = {
    Text = "Đang sử dụng bí ẩn trong {s1},sau khi phân giải sẽ được loại bỏ khỏi phương án này,bạn có chắc chắn không?"
  },
  TipsType_20204_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20204_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20204_Title = {
    Text = "Xác nhận xóa"
  },
  TipsType_20205_Desc = {
    Text = "Hiện tại bí ẩn đã được sử dụng trong biên đội {s1}, việc phân giải sẽ gỡ bỏ bí ẩn này, bạn có chắc chắn?"
  },
  TipsType_20205_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20205_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20205_Title = {
    Text = "Xác nhận xóa"
  },
  TipsType_20206_Desc = {
    Text = "Hiện tại vòng mệnh đã được sử dụng trong biên đội {s1}, phân giải xong sẽ gỡ khỏi biên đội. Bạn có chắc không?"
  },
  TipsType_20206_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20206_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20206_Title = {
    Text = "Xác nhận xóa"
  },
  TipsType_20207_Desc = {
    Text = "Đang không lưu phương án hiện tại, thoát sẽ xóa lần chỉnh sửa này. Bạn có chắc chắn muốn thoát không?"
  },
  TipsType_20207_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20207_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20207_Title = {
    Text = "Xác nhận lưu"
  },
  TipsType_20208_Desc = {
    Text = "Phần thưởng nhiệm vụ đã được nhận, hãy xem các nhiệm vụ khác nào!"
  },
  TipsType_20209_Desc = {
    Text = "Nhiệm vụ đã hết hạn"
  },
  TipsType_20210_Desc = {
    Text = "Để đảm bảo trải nghiệm cốt truyện tốt nhất, khuyến nghị hoàn thành các cấp độ điều tra sau đây."
  },
  TipsType_20210_LeftBtnDesc = {Text = "Thoát"},
  TipsType_20210_RightBtnDesc = {
    Text = "Vẫn phải điều tra"
  },
  TipsType_20210_Title = {
    Text = "Xác nhận điều tra"
  },
  TipsType_20211_Desc = {
    Text = "{s1} ngày {s2} giờ nữa để mở"
  },
  TipsType_20212_Desc = {
    Text = "{s1} Giờ {s2} Phút Sau Khi Mở"
  },
  TipsType_20213_Desc = {
    Text = "<WeaponEffect_Num:{s1}> đã kích hoạt nguyên nhân vượt giới hạn trong biên đội, bất kỳ hồi tưởng nào sẽ dẫn đến nguyên nhân vượt giới hạn không còn hiệu lực và sẽ tự động gỡ bỏ khỏi biên đội. Bạn có xác nhận chọn <WeaponEffect_Num:{s1}> để kích hoạt hồi tưởng không?\nThao tác này không thể hoàn tác, vui lòng kiểm tra kỹ"
  },
  TipsType_20213_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20213_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20213_Title = {
    Text = "Lựa chọn hồi tưởng"
  },
  TipsType_20214_Desc = {
    Text = "Sắp đặt lại trạng thái chồng vị của vòng mệnh và hoàn trả tất cả tiêu thụ chồng vị. \n <WeaponEffect_Num:{s1}> đã kích hoạt nguyên nhân vượt quá trong biên đội, sau khi hồi tưởng sẽ tự động gỡ bỏ khỏi biên đội. \n Bạn có xác nhận thực hiện hồi phục chồng vị cho <WeaponEffect_Num:{s1}> không?"
  },
  TipsType_20214_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20214_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20214_Title = {
    Text = "Diệp Vị Hồi Tố"
  },
  TipsType_20215_Desc = {
    Text = "Sắp đặt về trạng thái chồng vị của vòng mệnh, hoàn trả tất cả tiêu thụ chồng vị và trả lại vòng mệnh vào hồ đen. \n <WeaponEffect_Num:{s1}> đã kích hoạt nguyên nhân vượt quá giới hạn trong biên đội, sau khi hoàn trả sẽ tự động gỡ bỏ khỏi biên đội. \n Bạn có chắc chắn muốn trả lại <WeaponEffect_Num:{s1}> vào hồ đen không?"
  },
  TipsType_20215_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20215_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20215_Title = {
    Text = "Trả lại hồ đen"
  },
  TipsType_20216_Desc = {
    Text = "Có tiêu hao <Blue:「{s1}」× {s2} >để mua không?"
  },
  TipsType_20216_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20216_RightBtnDesc = {Text = "Mua"},
  TipsType_20216_Title = {
    Text = "Xác nhận mua hàng"
  },
  TipsType_20217_Desc = {
    Text = "{s1}sẽ mở sau {s2}."
  },
  TipsType_20218_Desc = {
    Text = "Đợt điều tra này, thân thể được đánh thức đã chọn trước không thể rời trận, chỉ có thể thay thế bằng thân thể được đánh thức tương ứng"
  },
  TipsType_20219_Desc = {
    Text = "Đã ra trận với cùng một thân thể được đánh thức, không thể chọn lại."
  },
  TipsType_20220_Desc = {
    Text = "Phát hiện hiện tại không sử dụng WIF, tải xuống sẽ tốn nhiều dữ liệu, có xác nhận tải xuống không?\nKích thước tài nguyên: {s1}\nCó tiếp tục không?"
  },
  TipsType_20220_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20220_RightBtnDesc = {
    Text = "Tải xuống"
  },
  TipsType_20221_Desc = {
    Text = "Tải xuống tài nguyên hoàn tất"
  },
  TipsType_20221_LeftBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20222_Desc = {
    Text = "Không đủ không gian lưu trữ, cần thiết phải dự trữ ít nhất {s1} không gian lưu trữ, nếu không có thể dẫn đến mất mát tài nguyên trong quá trình chạy, có tiếp tục tải xuống mới không?"
  },
  TipsType_20222_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20222_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20223_Desc = {
    Text = "Tải xuống tài nguyên thất bại, có muốn thử lại không?"
  },
  TipsType_20223_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20223_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20224_Desc = {
    Text = "Tải xuống dữ liệu cần thiết để chơi phần tiếp theo của đoạn mở đầu.\nKích thước tài nguyên: {s1}\nCó tiếp tục không？\n\n*Nên tải về trong môi trường WiFi."
  },
  TipsType_20224_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20224_RightBtnDesc = {
    Text = "Tải xuống"
  },
  TipsType_20225_Desc = {
    Text = "{s1} đã thông qua, có muốn tham gia thử thách bổ sung? \nThử thách bổ sung có thể nhận được {s2} giá trị huấn luyện đặc biệt"
  },
  TipsType_20225_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20225_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20225_Title = {
    Text = "Thách thức bổ sung"
  },
  TipsType_20226_Desc = {
    Text = "Sau khi đặt lại, các thân thể được đánh thức, Mật lệnh và vòng mệnh của đội thách thức bổ sung có thể tham gia lại, nhưng Điểm huấn luyện nhận được từ việc hoàn thành thêm màn chơi đó cũng sẽ bị trừ (không ảnh hưởng đến trạng thái phần thưởng), bạn có chắc chắn muốn đặt lại không?"
  },
  TipsType_20226_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20226_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20226_Title = {
    Text = "Xác nhận khôi phục cài đặt gốc"
  },
  TipsType_20227_Desc = {
    Text = "Sau khi đặt lại, thân thể được đánh thức, mật lệnh và vòng mệnh của đội điều tra hiện tại có thể ra trận lại, và đội thách thức bổ sung sẽ thay thế đội điều tra hiện tại. Tuy nhiên, điểm huấn luyện nhận được từ việc hoàn thành thêm ải cũng sẽ bị trừ (không ảnh hưởng đến trạng thái phần thưởng), bạn có chắc chắn muốn đặt lại không?"
  },
  TipsType_20227_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20227_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20227_Title = {
    Text = "Xác nhận khôi phục cài đặt gốc"
  },
  TipsType_20228_Desc = {
    Text = "Kéo xuống để xem thêm thông báo"
  },
  TipsType_20229_Desc = {
    Text = "\"<Blue:{s1}>\"đã đạt giới hạn cấp độ xếp chồng\nCó muốn tiếp tục mua không?\nSố lượng còn lại: {s2}"
  },
  TipsType_20229_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20229_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20229_Title = {
    Text = "Xác nhận mua hàng"
  },
  TipsType_20230_Desc = {
    Text = "Để đảm bảo trải nghiệm cốt truyện tốt nhất, khuyến nghị hoàn thành các cấp độ điều tra sau đây."
  },
  TipsType_20230_LeftBtnDesc = {Text = "Thoát"},
  TipsType_20230_RightBtnDesc = {
    Text = "Vẫn phải điều tra"
  },
  TipsType_20230_Title = {
    Text = "Xác nhận điều tra"
  },
  TipsType_20231_Desc = {
    Text = "Để đảm bảo trải nghiệm cốt truyện tốt nhất, khuyên bạn nên hoàn thành các cấp độ điều tra sau đây."
  },
  TipsType_20231_LeftBtnDesc = {Text = "Thoát"},
  TipsType_20231_RightBtnDesc = {
    Text = "Vẫn phải điều tra"
  },
  TipsType_20231_Title = {
    Text = "Xác nhận điều tra"
  },
  TipsType_20232_Desc = {
    Text = "Để đảm bảo trải nghiệm cốt truyện tốt nhất, nên hoàn thành các cấp độ điều tra sau đây."
  },
  TipsType_20232_LeftBtnDesc = {Text = "Thoát"},
  TipsType_20232_RightBtnDesc = {
    Text = "Vẫn phải điều tra"
  },
  TipsType_20232_Title = {
    Text = "Xác nhận điều tra"
  },
  TipsType_20233_Desc = {
    Text = "Hiện tại không đủ vật liệu cần thiết, bạn có muốn tiêu hao các vật liệu dưới đây để bổ sung không?"
  },
  TipsType_20233_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20233_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20233_Title = {
    Text = "Hoàn tất xác nhận"
  },
  TipsType_20234_Desc = {
    Text = "Màn này chỉ có thể trang bị lệnh khóa được chỉ định, không thể thay thế."
  },
  TipsType_20235_Desc = {
    Text = "Để đảm bảo trải nghiệm cốt truyện tốt nhất, nên hoàn thành các cấp độ điều tra sau đây."
  },
  TipsType_20235_LeftBtnDesc = {Text = "Thoát"},
  TipsType_20235_RightBtnDesc = {
    Text = "Vẫn phải điều tra"
  },
  TipsType_20235_Title = {
    Text = "Xác nhận điều tra"
  },
  TipsType_20236_Desc = {
    Text = "Để đảm bảo trải nghiệm cốt truyện tốt nhất, khuyến nghị hoàn thành các cấp độ điều tra sau."
  },
  TipsType_20236_LeftBtnDesc = {Text = "Thoát"},
  TipsType_20236_RightBtnDesc = {
    Text = "Vẫn phải điều tra"
  },
  TipsType_20236_Title = {
    Text = "Xác nhận điều tra"
  },
  TipsType_20237_Desc = {
    Text = "Để đảm bảo trải nghiệm cốt truyện tốt nhất, khuyến nghị hoàn thành các cấp độ điều tra sau đây."
  },
  TipsType_20237_LeftBtnDesc = {Text = "Thoát"},
  TipsType_20237_RightBtnDesc = {
    Text = "Vẫn phải điều tra"
  },
  TipsType_20237_Title = {
    Text = "Xác nhận điều tra"
  },
  TipsType_20238_Desc = {
    Text = "Để đảm bảo trải nghiệm cốt truyện tốt nhất, khuyên bạn nên hoàn thành các cấp độ điều tra sau đây."
  },
  TipsType_20238_LeftBtnDesc = {Text = "Thoát"},
  TipsType_20238_RightBtnDesc = {
    Text = "Vẫn phải điều tra"
  },
  TipsType_20238_Title = {
    Text = "Xác nhận điều tra"
  },
  TipsType_20239_Desc = {
    Text = "Để đảm bảo trải nghiệm cốt truyện tốt nhất, khuyến nghị hoàn thành các cấp độ điều tra sau đây."
  },
  TipsType_20239_LeftBtnDesc = {Text = "Thoát"},
  TipsType_20239_RightBtnDesc = {
    Text = "Vẫn phải điều tra"
  },
  TipsType_20239_Title = {
    Text = "Xác nhận điều tra"
  },
  TipsType_20240_Desc = {
    Text = "Sửa xong, vui lòng khởi động lại trò chơi"
  },
  TipsType_20240_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20240_Title = {
    Text = "Lời nhắc thân thiện"
  },
  TipsType_20241_Desc = {
    Text = "Còn cần {s1}\"<Blue:{s2}>\"để đạt được giới hạn cấp độ xếp chồng\nCó tiếp tục mua không?"
  },
  TipsType_20241_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20241_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20241_Title = {
    Text = "Xác nhận mua hàng"
  },
  TipsType_20250_Desc = {
    Text = "Để đảm bảo trải nghiệm cốt truyện tốt nhất, chúng tôi khuyên bạn nên hoàn thành các cấp độ điều tra sau đây."
  },
  TipsType_20250_LeftBtnDesc = {Text = "Thoát"},
  TipsType_20250_RightBtnDesc = {
    Text = "Vẫn phải điều tra"
  },
  TipsType_20250_Title = {
    Text = "Xác nhận điều tra"
  },
  TipsType_20251_Desc = {
    Text = "Để đảm bảo trải nghiệm cốt truyện tốt nhất, khuyến nghị hoàn thành các cấp độ điều tra sau đây."
  },
  TipsType_20251_LeftBtnDesc = {Text = "Thoát"},
  TipsType_20251_RightBtnDesc = {
    Text = "Vẫn phải điều tra"
  },
  TipsType_20251_Title = {
    Text = "Xác nhận điều tra"
  },
  TipsType_20252_Desc = {
    Text = "Để đảm bảo trải nghiệm cốt truyện tốt nhất, khuyến nghị hoàn thành các cấp độ điều tra sau."
  },
  TipsType_20252_LeftBtnDesc = {Text = "Thoát"},
  TipsType_20252_RightBtnDesc = {
    Text = "Vẫn phải điều tra"
  },
  TipsType_20252_Title = {
    Text = "Xác nhận điều tra"
  },
  TipsType_20259_Desc = {
    Text = "Đã lưu cài đặt hoán đổi khi không đủ \"Ấn nghìn mặt\""
  },
  TipsType_20300_Desc = {
    Text = "Đã có {s1} thân thể được đánh thức cùng vị trí, không thể sử dụng thân thể được đánh thức cùng vị trí trong cùng một đội."
  },
  TipsType_20301_Desc = {
    Text = "Bây giờ có thể đến \"Nhiệm Vụ Thường Huấn\"!"
  },
  TipsType_20351_Desc = {
    Text = "{s1} không đủ, có muốn sử dụng {s2}{s3} để đổi {s4}{s5} không?"
  },
  TipsType_20351_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20351_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20351_Title = {
    Text = "{s1} không đủ"
  },
  TipsType_20352_Desc = {
    Text = "Sắp liên kết với đối phương, sau khi liên kết sẽ không thể tách ra, bạn có chắc chắn muốn tiếp tục liên kết không?"
  },
  TipsType_20352_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20352_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20352_Title = {
    Text = "Xác nhận mời"
  },
  TipsType_20353_Desc = {
    Text = "Mã mời đã được sao chép vào clipboard."
  },
  TipsType_20354_Desc = {
    Text = "Bạn đã là người mời đối phương."
  },
  TipsType_20355_Desc = {
    Text = "Không thể nhập mã mời của riêng mình, hãy thử lấy mã mời của những người giữ gìn khác đi."
  },
  TipsType_20356_Desc = {
    Text = "Chơi lại có thể trải nghiệm lại cốt truyện và hướng dẫn của chương mở đầu!\nNhưng khi chơi lại, tất cả thưởng trong nội dung cấp độ đều chỉ là biểu diễn, không thể thật sự nhận thưởng.\nCó xác nhận không?"
  },
  TipsType_20356_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20356_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20356_Title = {
    Text = "Xác nhận điều tra"
  },
  TipsType_20357_Desc = {
    Text = "Có chắc không còn quan tâm đến {s1} Người Giữ Gìn này không?"
  },
  TipsType_20357_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20357_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20357_Title = {
    Text = "Bỏ theo dõi"
  },
  TipsType_20358_Desc = {
    Text = "Có những hủy theo dõi chưa được xác nhận, rời đi sẽ không lưu bất kỳ thao tác nào, bạn có chắc chắn muốn rời đi không?"
  },
  TipsType_20358_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20358_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20358_Title = {
    Text = "Xác nhận thoát"
  },
  TipsType_20400_Desc = {
    Text = "<WeaponEffect_Num:「{s1}」> không đủ, có muốn đi đổi không?"
  },
  TipsType_20400_LeftBtnDesc = {Text = "Hủy"},
  TipsType_20400_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_20400_Title = {
    Text = "Không đủ đạo cụ quay thưởng"
  },
  TipsType_300001_Desc = {
    Text = "「\"Vầng sáng Bạc Đầu tiên\" chỉ có một cơ hội thức tỉnh miễn phí, bạn có chắc chắn muốn sử dụng không?」"
  },
  TipsType_300001_LeftBtnDesc = {Text = "Hủy"},
  TipsType_300001_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_300001_Title = {
    Text = "Xác nhận thức tỉnh"
  },
  TipsType_300002_Desc = {
    Text = "Xác nhận lựa chọn kết quả lần thức tỉnh này? Sau khi xác nhận, lần thức tỉnh này sẽ tiêu hao 5 lượt miễn phí"
  },
  TipsType_300002_LeftBtnDesc = {Text = "Hủy"},
  TipsType_300002_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_300002_Title = {
    Text = "Xác nhận thức tỉnh"
  },
  TipsType_30001_Desc = {
    Text = "Gợi ý bên cạnh không có biểu tượng"
  },
  TipsType_30003_Desc = {
    Text = "{s1}mở khóa"
  },
  TipsType_30004_Desc = {
    Text = "{s1}chế độ nâng cao được mở khóa"
  },
  TipsType_30005_Desc = {
    Text = "{s1}(khó khăn) mở khóa"
  },
  TipsType_31000_Desc = {
    Text = "Bạn có chắc chắn muốn sử dụng xác nhận ngày tháng năm sinh này không? Một khi xác nhận ngày tháng năm sinh thì sẽ không thể thay đổi nữa!"
  },
  TipsType_31000_LeftBtnDesc = {Text = "Hủy"},
  TipsType_31000_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_31000_Title = {
    Text = "Xác nhận độ tuổi"
  },
  TipsType_31001_Desc = {
    Text = "Tháng này đã nạp <Blue:{s1}> đồng, hạn chế tối đa là <Blue:{s2}> đồng, xin vui lòng nạp lại vào tháng sau hoặc thử nạp một số tiền thấp hơn"
  },
  TipsType_31002_Desc = {
    Text = "Vui lòng hoàn thành xác thực độ tuổi trước"
  },
  TipsType_31003_Desc = {
    Text = "Chìa khóa bạc nhận thấy nguy cơ chết người, có muốn kích hoạt thân thể linh tri thức khẩn cấp không?\n(Sự phục sinh sẽ tiêu thụ 1 lần thân thể linh tri thức khẩn cấp, thân thể linh tri thức khẩn cấp tự động nhận 1 lần vào lúc 9 giờ sáng mỗi ngày, số lần còn lại hiện tại: {s1})\n<Blue:(Lần phục sinh đầu tiên không tiêu thụ thân thể linh tri thức khẩn cấp)>"
  },
  TipsType_31003_LeftBtnDesc = {Text = "Hủy"},
  TipsType_31003_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_31003_Title = {
    Text = "Xác nhận hồi sinh"
  },
  TipsType_31004_Desc = {
    Text = "Chìa khóa bạc cảm nhận được nguy cơ chết người, có muốn kích hoạt thân thể linh tri thức khẩn cấp không?\n(Sự phục sinh sẽ tiêu hao 1 lần thân thể linh tri thức khẩn cấp, thân thể linh tri thức khẩn cấp sẽ tự động nhận 1 lần vào lúc 9 giờ mỗi ngày, số lần còn lại hiện tại: {s1})\n<Blue:(Lần phục sinh đầu tiên không tiêu hao thân thể linh tri thức khẩn cấp)>"
  },
  TipsType_31004_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_31004_Title = {
    Text = "Xác nhận hồi sinh"
  },
  TipsType_40001_Desc = {
    Text = "Khi sức sống giảm xuống 0, cuộc điều tra sẽ bị buộc phải kết thúc."
  },
  TipsType_40001_Title = {Text = "Sinh lực"},
  TipsType_40002_Desc = {
    Text = "Di chuyển bản đồ, sự kiện điều tra sẽ tạo ra áp lực tinh thần, áp lực tích lũy sẽ khiến Người Giữ Gìn bị triệu chứng. \n Mỗi khi di chuyển một ô, áp lực tăng 10 điểm. Mỗi khi áp lực đạt 100 điểm sẽ nhận được 1 triệu chứng. \n Khi áp lực đạt 500, mỗi khi di chuyển một ô, sẽ mất 10% sinh lực."
  },
  TipsType_40002_Title = {
    Text = "Căng thẳng"
  },
  TipsType_40003_Desc = {
    Text = "Cấp độ phái đi càng tăng, nhiệm vụ sẽ càng khó khăn, và phần thưởng nhận được cũng sẽ tăng lên tương ứng."
  },
  TipsType_40003_Title = {
    Text = "Cấp độ Phái Đi"
  },
  TipsType_40004_Desc = {
    Text = "Mỗi lượt, bản sao tạm thời của thẻ lệnh đầu tiên sẽ vào siêu không gian. \nKhi siêu không gian đạt giới hạn, nhận thêm 1 lượt hành động siêu việt và giữ lá chắn. \nHiệu ứng chuyên môn hóa giới vực: Đầu mỗi lượt, có xác suất đưa 1 thẻ \"cảm hứng\" vào tay."
  },
  TipsType_40004_Title = {
    Text = "Khoảng không gian siêu việt"
  },
  TipsType_40005_Desc = {
    Text = "Người giữ bí mật có thể nâng cấp cấp độ của mình thông qua các thách thức như điều tra, màn diễn tập. Khi cấp độ của Người Giữ Gìn tăng, nhiều cách chơi mới sẽ dần mở ra."
  },
  TipsType_40005_Title = {
    Text = "Cấp độ"
  },
  TipsType_40006_Desc = {
    Text = "Chơi thẻ lệnh cần tiêu thụ điểm tính toán. Cuối lượt, sẽ không giữ lại sức tính toán còn lại, và vào đầu lượt sẽ hồi phục sức tính toán lên mức tối đa."
  },
  TipsType_40006_Title = {
    Text = "Điểm tính toán"
  },
  TipsType_40007_Desc = {
    Text = "Chìa khóa bạc cảm nhận được một luồng năng lượng đặc biệt, trên bản đồ có thể ẩn chứa những vật tư quý giá…"
  },
  TipsType_40007_Title = {
    Text = "Ẩn vật tư"
  },
  TipsType_40008_Desc = {
    Text = "Có thể kích hoạt khi gặp phải nguy cơ chí mạng trong trận đấu, mỗi lần kích hoạt tiêu thụ 1 chiếc, hồi phục sinh lực của Người Giữ Gìn và điên cuồng của thể thức tỉnh về mức tối đa, mỗi ngày tự động nhận 1 chiếc vào lúc 9 giờ."
  },
  TipsType_40008_Title = {
    Text = "Thân thể Linh tri thức khẩn cấp"
  },
  TipsType_40009_Desc = {
    Text = "Đánh ra thẻ lệnh cần tiêu thụ sức tính toán. Cuối lượt, sức tính toán còn lại sẽ không được giữ lại. Đầu lượt, giới hạn sức tính toán tăng thêm +1 và hồi phục lên mức tối đa. Hiện tại là lượt thứ {s1}."
  },
  TipsType_40009_Title = {
    Text = "Điểm tính toán"
  },
  TipsType_AbyssChallengeResetTips_Desc = {
    Text = "Vùng cấm hòa hợp với thiên tai đã được đặt lại, thử thách đang tiến hành sẽ kết thúc ngay lập tức."
  },
  TipsType_AbyssChallengeResetTips_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_AbyssChallengeResetTips_Title = {Text = "Gợi ý"},
  TipsType_AbyssChallengeRevivalTips_Desc = {
    Text = "Chìa Khóa Bạc cảm nhận được nguy cơ tử vong, có muốn kích hoạt Thân thể Linh tri thức khẩn cấp không?\n(Sự phục sinh sẽ tiêu thụ {s1} Thân thể Linh tri thức khẩn cấp, mỗi ngày lúc 9 giờ sẽ tự động nhận được 1 Thân thể Linh tri thức khẩn cấp)"
  },
  TipsType_AbyssChallengeRevivalTips_LeftBtnDesc = {Text = "Hủy"},
  TipsType_AbyssChallengeRevivalTips_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_AbyssChallengeRevivalTips_Title = {
    Text = "Xác nhận hồi sinh"
  },
  TipsType_AcceptConfirm_Desc = {
    Text = "Có chấp nhận lời mời <Blue:{s1}> của <Blue:{s2}> không?"
  },
  TipsType_AcceptConfirm_LeftBtnDesc = {
    Text = "Từ chối"
  },
  TipsType_AcceptConfirm_RightBtnDesc = {
    Text = "Chấp nhận"
  },
  TipsType_AcceptConfirm_Title = {
    Text = "Đối chiến mật mã"
  },
  TipsType_ActivitySignRewardTaskNotCompleteTips_Desc = {
    Text = "Hoàn thành nhiệm vụ tương ứng để tiến hành hoán tỉnh"
  },
  TipsType_AlreadyIsBackgroundMusicTips_Desc = {
    Text = "Đã là nhạc nền hiện tại"
  },
  TipsType_AwakerAutoInsertCoinNotEnoughTips_Desc = {
    Text = "\"Vé hoa hồng vàng\" không đủ để sử dụng toàn bộ \"thuốc linh tri\" hiện có, hãy bổ sung \"Vé hoa hồng vàng\" rồi thử lại."
  },
  TipsType_AwakerNotOpenTips_Desc = {
    Text = "Thể Thức Tỉnh chưa đến thời gian mở, xin hãy chờ đón"
  },
  TipsType_AwakerRandomChestConfirm_Desc = {
    Text = "Xác nhận tiêu thụ <Blue:{s1}>, nhận 1 Thể thức tỉnh <Blue:ngẫu nhiên>?"
  },
  TipsType_AwakerRandomChestConfirm_LeftBtnDesc = {Text = "Hủy"},
  TipsType_AwakerRandomChestConfirm_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_AwakerRandomChestConfirm_Title = {
    Text = "Xác nhận sử dụng"
  },
  TipsType_BattleCreateFail_Desc = {
    Text = "Tạo trận đấu thất bại"
  },
  TipsType_BattlePassAllCompleteTips_Desc = {
    Text = "Nhật ký giữ bí mật hiện tại đã hoàn thành tất cả."
  },
  TipsType_BestExperienceTips_Chapter3_Desc = {
    Text = "Để đảm bảo trải nghiệm cốt truyện tốt nhất, đề nghị hoàn thành các nhiệm vụ điều tra sau."
  },
  TipsType_BestExperienceTips_Chapter3_LeftBtnDesc = {Text = "Thoát"},
  TipsType_BestExperienceTips_Chapter3_RightBtnDesc = {
    Text = "Vẫn phải điều tra"
  },
  TipsType_BestExperienceTips_Chapter3_Title = {
    Text = "Xác nhận điều tra"
  },
  TipsType_BestExperienceTips_Chapter7_Desc = {
    Text = "Để đảm bảo trải nghiệm cốt truyện tốt nhất, khuyến nghị hoàn thành các cấp độ điều tra sau."
  },
  TipsType_BestExperienceTips_Chapter7_LeftBtnDesc = {Text = "Thoát"},
  TipsType_BestExperienceTips_Chapter7_RightBtnDesc = {
    Text = "Vẫn phải điều tra"
  },
  TipsType_BestExperienceTips_Chapter7_Title = {
    Text = "Xác nhận điều tra"
  },
  TipsType_BestExperienceTips_Chapter8_Desc = {
    Text = "Để đảm bảo trải nghiệm cốt truyện tốt nhất, khuyến nghị hoàn thành các cấp độ điều tra dưới đây."
  },
  TipsType_BestExperienceTips_Chapter8_LeftBtnDesc = {Text = "Thoát"},
  TipsType_BestExperienceTips_Chapter8_RightBtnDesc = {
    Text = "Vẫn phải điều tra"
  },
  TipsType_BestExperienceTips_Chapter8_Title = {
    Text = "Xác nhận điều tra"
  },
  TipsType_BestExperienceTips_ChapterS2_Desc = {
    Text = "Để đảm bảo trải nghiệm cốt truyện tốt nhất, khuyến nghị hoàn thành các cấp độ điều tra sau đây."
  },
  TipsType_BestExperienceTips_ChapterS2_LeftBtnDesc = {Text = "Thoát"},
  TipsType_BestExperienceTips_ChapterS2_RightBtnDesc = {
    Text = "Vẫn phải điều tra"
  },
  TipsType_BestExperienceTips_ChapterS2_Title = {
    Text = "Xác nhận điều tra"
  },
  TipsType_BestExperienceTips_ChapterS3_Desc = {
    Text = "Để đảm bảo trải nghiệm cốt truyện tốt nhất, khuyến nghị hoàn thành các cấp độ điều tra sau đây."
  },
  TipsType_BestExperienceTips_ChapterS3_LeftBtnDesc = {Text = "Thoát"},
  TipsType_BestExperienceTips_ChapterS3_RightBtnDesc = {
    Text = "Vẫn phải điều tra"
  },
  TipsType_BestExperienceTips_ChapterS3_Title = {
    Text = "Xác nhận điều tra"
  },
  TipsType_BestExperienceTips_ChapterS4_Desc = {
    Text = "Để đảm bảo trải nghiệm cốt truyện tốt nhất, đề nghị hoàn thành các nhiệm vụ điều tra sau."
  },
  TipsType_BestExperienceTips_ChapterS4_LeftBtnDesc = {Text = "Thoát"},
  TipsType_BestExperienceTips_ChapterS4_RightBtnDesc = {
    Text = "Vẫn phải điều tra"
  },
  TipsType_BestExperienceTips_ChapterS4_Title = {
    Text = "Xác nhận điều tra"
  },
  TipsType_BestExperienceTips_ChapterS5_Desc = {
    Text = "Để đảm bảo trải nghiệm cốt truyện tốt nhất, đề nghị hoàn thành các nhiệm vụ điều tra sau."
  },
  TipsType_BestExperienceTips_ChapterS5_LeftBtnDesc = {Text = "Thoát"},
  TipsType_BestExperienceTips_ChapterS5_RightBtnDesc = {
    Text = "Vẫn phải điều tra"
  },
  TipsType_BestExperienceTips_ChapterS5_Title = {
    Text = "Xác nhận điều tra"
  },
  TipsType_BestExperienceTips_MainStoryS1_6_Desc = {
    Text = "Để đảm bảo trải nghiệm cốt truyện tốt nhất, đề nghị hoàn thành các nhiệm vụ điều tra sau."
  },
  TipsType_BestExperienceTips_MainStoryS1_6_LeftBtnDesc = {Text = "Thoát"},
  TipsType_BestExperienceTips_MainStoryS1_6_RightBtnDesc = {
    Text = "Vẫn phải điều tra"
  },
  TipsType_BestExperienceTips_MainStoryS1_6_Title = {
    Text = "Xác nhận điều tra"
  },
  TipsType_BestExperienceTips_TwoAnniversarySubStage_Desc = {
    Text = "Để đảm bảo trải nghiệm cốt truyện tốt nhất, đề nghị hoàn thành các nhiệm vụ điều tra sau."
  },
  TipsType_BestExperienceTips_TwoAnniversarySubStage_LeftBtnDesc = {Text = "Thoát"},
  TipsType_BestExperienceTips_TwoAnniversarySubStage_RightBtnDesc = {
    Text = "Vẫn phải điều tra"
  },
  TipsType_BestExperienceTips_TwoAnniversarySubStage_Title = {
    Text = "Xác nhận điều tra"
  },
  TipsType_CancelCollectAwakerTips_Desc = {
    Text = "Đã hủy bỏ yêu thích"
  },
  TipsType_CoinBulkBuyConfirm_Desc = {
    Text = "Bạn có muốn tiêu thụ \"Phiếu vàng hồng\" × {s1} để mua không?"
  },
  TipsType_CoinBulkBuyConfirm_LeftBtnDesc = {Text = "Hủy"},
  TipsType_CoinBulkBuyConfirm_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_CoinBulkBuyConfirm_Title = {
    Text = "Xác nhận mua hàng"
  },
  TipsType_CollectAwakerTips_Desc = {
    Text = "Lưu thành công"
  },
  TipsType_CommonUseBattleHelpLimitTips_Desc = {
    Text = "Danh sách trợ lý thường dùng của Người giữ gìn đã đạt giới hạn, xin điều chỉnh danh sách trợ lý thường dùng"
  },
  TipsType_DiskIsFullOrViolation_Desc = {
    Text = "Ghi tệp thất bại, vui lòng kiểm tra xem dung lượng lưu trữ còn lại của thiết bị có đủ không"
  },
  TipsType_DiskIsFullOrViolation_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_DiskSpaceNotEnough_Desc = {
    Text = "Không đủ không gian lưu trữ, có muốn tiếp tục thử tải xuống không?"
  },
  TipsType_DiskSpaceNotEnough_LeftBtnDesc = {Text = "Hủy"},
  TipsType_DiskSpaceNotEnough_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_DoubleExBPBuyConfirm_Desc = {
    Text = "Có tiêu thụ <Blue:「nguồn lỏng」× {s1}> để mua không? \n <color=#ACBFCA>Đợt này là chủ đề đặc biệt, giá của chủ đề chính đã giảm</color>"
  },
  TipsType_DoubleExBPBuyConfirm_LeftBtnDesc = {Text = "Hủy"},
  TipsType_DoubleExBPBuyConfirm_RightBtnDesc = {Text = "Mua"},
  TipsType_DoubleExBPBuyConfirm_Title = {
    Text = "Xác nhận mua hàng"
  },
  TipsType_EnterSix_DigitPasswordTips_Desc = {
    Text = "Nhập <color=#5EF2FF>giá trị pha</color>"
  },
  TipsType_FilterMaxAwakerCountTips_Desc = {
    Text = "Chọn tối đa {s1} Thức Tỉnh Thể để lọc"
  },
  TipsType_FollowBackConfirm_Desc = {
    Text = "Có chắc bạn muốn theo dõi <color=#5EF2FF>{s1}</color> người theo dõi trên trang hiện tại?\n\n<color=#96947F>Đang theo dõi </color>{s2}<color=#A0A0A0>/{s3}\nSau khi vượt quá giới hạn sẽ không thể theo dõi</color>"
  },
  TipsType_FollowBackConfirm_LeftBtnDesc = {Text = "Hủy"},
  TipsType_FollowBackConfirm_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_FollowBackConfirm_Title = {
    Text = "Xác nhận theo dõi lại"
  },
  TipsType_FrenziedOmenUpgradeConfirm_Desc = {
    Text = "Thao tác này sẽ tiêu tốn lượng lớn tài nguyên, phù hợp khi muốn rèn luyện năng lực của Thể thức tỉnh đến giới hạn, xác nhận tăng cường \"Điềm báo điên loạn\" không?"
  },
  TipsType_FrenziedOmenUpgradeConfirm_LeftBtnDesc = {Text = "Hủy"},
  TipsType_FrenziedOmenUpgradeConfirm_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_FrenziedOmenUpgradeConfirm_Title = {
    Text = "Xác nhận Tăng cường"
  },
  TipsType_GnosticPotentialUpgradeConfirm_Desc = {
    Text = "Thao tác này sẽ tiêu tốn lượng lớn tài nguyên, phù hợp khi muốn rèn luyện năng lực của Thể thức tỉnh đến giới hạn, xác nhận tăng cường \"Linh Cách Nội Tại\" không?"
  },
  TipsType_GnosticPotentialUpgradeConfirm_LeftBtnDesc = {Text = "Hủy"},
  TipsType_GnosticPotentialUpgradeConfirm_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_GnosticPotentialUpgradeConfirm_Title = {
    Text = "Xác nhận Tăng cường"
  },
  TipsType_InCharging_Desc = {
    Text = "Đơn hàng đang được xử lý, vui lòng không thanh toán lại. \nNếu thanh toán đã hoàn tất, xin vui lòng chờ hệ thống phát thưởng. \nNếu thanh toán chưa hoàn tất, hãy thử khởi động lại trò chơi và thử lại. \nNếu có thắc mắc, vui lòng liên hệ với bộ phận chăm sóc khách hàng."
  },
  TipsType_InCharging_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_InCharging_Title = {
    Text = "Lời nhắc thân thiện"
  },
  TipsType_KeyShortNameDownLoadTips_Desc = {
    Text = "Đang tải tài nguyên nhận diện văn bản, vui lòng thử lại sau một lúc"
  },
  TipsType_LimitAwakerEnlightenmentOverflowTips_Desc = {
    Text = "Ký hiệu thức tỉnh đã đầy\nSau khi chọn chỉ nhận được \"Mảnh hồi tố linh hồn\" × 2"
  },
  TipsType_LimitAwakerEnlightenmentOverflowTips_LeftBtnDesc = {Text = "Hủy"},
  TipsType_LimitAwakerEnlightenmentOverflowTips_RightBtnDesc = {
    Text = "Tiếp tục"
  },
  TipsType_LimitAwakerEnlightenmentOverflowTips_Title = {
    Text = "Xác nhận lựa chọn"
  },
  TipsType_MainResetBG_Desc = {
    Text = "Bạn có cần khôi phục nền tảng của ký túc xá <Blue:「hình ảnh」> và <Blue:「âm nhạc」> về mặc định không?"
  },
  TipsType_MainResetBG_LeftBtnDesc = {Text = "Hủy"},
  TipsType_MainResetBG_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_MainResetBG_Title = {
    Text = "Khôi phục mặc định"
  },
  TipsType_MultiSelectBox_FixItemTips_Desc = {
    Text = "Nhận được vật phẩm cố định, không thể thay đổi"
  },
  TipsType_MultiSelectBox_SelectTips_Desc = {
    Text = "Vui lòng hoàn thành việc chọn tất cả các món tự chọn trước khi thực hiện mua hàng"
  },
  TipsType_OppositeSideCancelMatchTips_Desc = {
    Text = "Đối phương đã hủy bỏ trận đấu"
  },
  TipsType_OppositeSideRejectTips_Desc = {
    Text = "Đối phương đã từ chối lời mời của <Blue:{s1}>, xin vui lòng chọn lại chế độ"
  },
  TipsType_PVEExceedMaxRoundsTips_Desc = {
    Text = "Số lượt chiến đấu đã đạt giới hạn tối đa\n\nNgười giữ bí mật duy nhất ơi\nTiếp theo bạn sẽ lựa chọn như thế nào?"
  },
  TipsType_PVEExceedMaxRoundsTips_LeftBtnDesc = {
    Text = "Chiến đấu lại"
  },
  TipsType_PVEExceedMaxRoundsTips_RightBtnDesc = {
    Text = "Tạm thời rút lui"
  },
  TipsType_PVEExceedMaxRoundsTips_Title = {
    Text = "Điều tra thất bại"
  },
  TipsType_PVEReplayErrorTips_Desc = {
    Text = "Lấy lại băng ghi trận chiến có lỗi, vui lòng thử lại sau"
  },
  TipsType_PVEReplayMaxRounds_Desc = {
    Text = "Phát lại đã đạt giới hạn tối đa 25 lượt,\nKết thúc phát lại."
  },
  TipsType_PVEReplayMaxRounds_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_PVEReplayMaxRounds_Title = {
    Text = "Xác nhận kết thúc"
  },
  TipsType_PVEReplayNoDataTips_Desc = {
    Text = "Chưa có ghi chép hoạt động điều tra"
  },
  TipsType_PVEReplayRepeatClickTips_Desc = {
    Text = "Đang tải lại chiến đấu, xin không thao tác lại"
  },
  TipsType_PVEReplaySpecialTeamAssignTips_Desc = {
    Text = "Chưa hỗ trợ phát lại trận chiến đội hình đặc biệt, xin hãy chờ đợi"
  },
  TipsType_PVEReplayTimeoutTips_Desc = {
    Text = "Lấy lại băng ghi trận chiến quá thời gian"
  },
  TipsType_PVEReplayUnableOperateTips_Desc = {
    Text = "Trong phát lại trận chiến không thể thực hiện thao tác"
  },
  TipsType_PVETeamShareCodeCopyTips_Desc = {
    Text = "Đã sao chép vào bộ nhớ tạm"
  },
  TipsType_PVETeamShareCodeError_Desc = {
    Text = "Không thể nhận diện đúng được trong clipboard có <color=#5EF2FF>Hoạt động</color> đội hình"
  },
  TipsType_PVETeamShareCodeSaveTips_Desc = {
    Text = "Bạn có xác nhận lưu cấu hình đội hình tương ứng với mã đội hình này không? \nCác phần không giữ cấu hình sẽ bị bỏ trống."
  },
  TipsType_PVETeamShareCodeSaveTips_LeftBtnDesc = {Text = "Hủy"},
  TipsType_PVETeamShareCodeSaveTips_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_PVETeamShareCodeSaveTips_Title = {
    Text = "Xác nhận lưu"
  },
  TipsType_PVETeamShareCodeSpecialTeamAssignTips_Desc = {
    Text = "Đội ngũ này chứa thể thức tỉnh đã được thiết lập trước, không thể sao chép hoặc nhập mã đội hình"
  },
  TipsType_PVPExceedMaxRoundsTips_Loser_Desc = {
    Text = "Trận đấu đã đạt giới hạn lượt tối đa, bên đi trước không thể kết thúc trận đấu, được tính là thất bại."
  },
  TipsType_PVPExceedMaxRoundsTips_Loser_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_PVPExceedMaxRoundsTips_Loser_Title = {
    Text = "Trận đấu kết thúc"
  },
  TipsType_PVPExceedMaxRoundsTips_Winner_Desc = {
    Text = "Trận đấu đã đạt giới hạn lượt tối đa, bên đi sau đã thành công cầm cự đến cuối trận, được tính là chiến thắng."
  },
  TipsType_PVPExceedMaxRoundsTips_Winner_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_PVPExceedMaxRoundsTips_Winner_Title = {
    Text = "Trận đấu kết thúc"
  },
  TipsType_PVPSurrenderConfirm_Desc = {
    Text = "Có đầu hàng không?"
  },
  TipsType_PVPSurrenderConfirm_LeftBtnDesc = {Text = "Hủy"},
  TipsType_PVPSurrenderConfirm_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_PVPSurrenderConfirm_Title = {
    Text = "Xác nhận đầu hàng"
  },
  TipsType_PVPTeamShareCodeError_Desc = {
    Text = "Không thể nhận diện đúng được trong clipboard có <color=#5EF2FF>Bẫy</color> đội hình"
  },
  TipsType_PVP_PasswordBattle_BlockTips_Desc = {
    Text = "Có cần chặn Người Giữ Gìn này không?"
  },
  TipsType_PVP_PasswordBattle_BlockTips_LeftBtnDesc = {
    Text = "Từ chối"
  },
  TipsType_PVP_PasswordBattle_BlockTips_RightBtnDesc = {
    Text = "Chấp nhận"
  },
  TipsType_PVP_PasswordBattle_BlockTips_Title = {
    Text = "Có chặn không"
  },
  TipsType_PVP_PasswordBattle_GameStartedTips_Desc = {
    Text = "Cuộc đấu mật mã lần này đã bắt đầu"
  },
  TipsType_PVP_PasswordBattle_OthersEnterTips_Desc = {
    Text = "Có Người Giữ Gìn mới tham gia vào mật mã đối chiến này"
  },
  TipsType_PVP_PasswordBattle_QueueTips_Desc = {
    Text = "Đang xếp hàng……"
  },
  TipsType_PVP_PasswordBattle_QuitTips_Desc = {
    Text = "Bạn có chắc muốn thoát khỏi mật mã đối chiến không?"
  },
  TipsType_PVP_PasswordBattle_QuitTips_LeftBtnDesc = {Text = "Hủy"},
  TipsType_PVP_PasswordBattle_QuitTips_RightBtnDesc = {Text = "Thoát"},
  TipsType_PVP_PasswordBattle_QuitTips_Title = {
    Text = "Xác nhận thoát"
  },
  TipsType_PVP_PasswordBattle_RejectedTips_Desc = {
    Text = "Đối phương đã từ chối đối chiến với bạn"
  },
  TipsType_PassportHoistTips1_Desc = {
    Text = "\"Ion Hoạt Tính Cơ Bản\"\n·Sau khi mở khóa, trong suốt thời gian khóa học kỳ này, phần thưởng tích lũy \"Ion Hoạt Tính Cơ Bản\" trong \"Thử thách hàng ngày\" bao gồm \"điểm khởi đầu thực tế\",\"Hạt Nhân Sạch Will\",\"Kinh nghiệm\",\"bạc tâm\" sẽ được nâng lên gấp 3 lần. Sau khi mua \"Chủ đề chính\", phần thưởng bội suất bổ sung từ phần thưởng tích lũy \"Ion Hoạt Tính Cơ Bản\"đã nhận trong kỳ này sẽ được bù phát."
  },
  TipsType_PassportHoistTips2_Desc = {
    Text = "\"Thời gian ngược lại\"\n·Có thể quay lại các lượt đã trải qua trong trận chiến.\n·Có thể quay lại bất kỳ lượt nào trong 25 lượt đầu của trận chiến.\n·Sau khi thách đấu lại vẫn có thể sử dụng chức năng ngược lại để trở về lượt trước đó."
  },
  TipsType_PassportHoistTips3_Desc = {
    Text = "\"Bẫy\"\n· Sau khi mở khóa, trong thời gian diễn ra đề tài này có thể sử dụng tất cả thẻ bài của \"Bẫy\"."
  },
  TipsType_Password_CopiedTips_Desc = {
    Text = "<color=#5EF2FF>Giá trị pha</color> đã được sao chép vào clipboard"
  },
  TipsType_PayMoneyBuyConfirmDescDetail_Desc = {
    Text = "Bạn có muốn tiêu thụ <Blue:\"nguồn lỏng\" × {s1} >để mua không?\n\n<size=30><color=#ACBFCA>Khi tiêu thụ \"nguồn lỏng\", ưu tiên trừ \"nguồn lỏng\" được tặng.\n(Chiết xuất: {s2}, Tặng: {s3})</color></size>"
  },
  TipsType_PayMoneyBuyConfirmDescDetail_LeftBtnDesc = {Text = "Hủy"},
  TipsType_PayMoneyBuyConfirmDescDetail_RightBtnDesc = {Text = "Mua"},
  TipsType_PayMoneyBuyConfirmDescDetail_Title = {
    Text = "Xác nhận mua hàng"
  },
  TipsType_PublishEmptyCommentTips_Desc = {
    Text = "Nội dung bình luận không được để trống"
  },
  TipsType_PvpCollectionCommentDeleteTips_Desc = {
    Text = "Xác nhận xóa bình luận này?"
  },
  TipsType_PvpCollectionCommentDeleteTips_LeftBtnDesc = {Text = "Hủy"},
  TipsType_PvpCollectionCommentDeleteTips_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_PvpCollectionCommentDeleteTips_Title = {
    Text = "Xác nhận xóa"
  },
  TipsType_PvpHideCommentConfirm_Desc = {
    Text = "Có ẩn tất cả bình luận của nó không?"
  },
  TipsType_PvpHideCommentConfirm_LeftBtnDesc = {Text = "Không"},
  TipsType_PvpHideCommentConfirm_RightBtnDesc = {
    Text = "Đúng vậy"
  },
  TipsType_PvpHideCommentConfirm_Title = {Text = "Ẩn"},
  TipsType_PvpMatchingInterruptTips_Desc = {
    Text = "Phát hiện mạng bất thường, ghép trận bị gián đoạn."
  },
  TipsType_RailWayContinueReconnectSeasonSwitchTips_Desc = {
    Text = "Đang trong trận chiến, bạn có muốn tiếp tục trận chiến trước đó không? \n Mùa giải \"Chuyến tàu Hạnh phúc tốc hành\" đã được cập nhật. Tiếp tục thử thách có thể hoàn thành nhiệm vụ mùa giải mới nhất, nhưng không thể vào \"Danh sách khách quý\"."
  },
  TipsType_RailWayContinueReconnectSeasonSwitchTips_LeftBtnDesc = {Text = "Hủy"},
  TipsType_RailWayContinueReconnectSeasonSwitchTips_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_RailWayContinueReconnectSeasonSwitchTips_Title = {Text = "Gợi ý"},
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_Desc = {
    Text = "Tiến độ thử thách lần trước là {s1} - Giai đoạn {s2} - Trận chiến {s3}, đã nhận được \"Điểm khách quý\" × {s4}\nMùa giải đã được cập nhật. Tiếp tục thử thách có thể hoàn thành nhiệm vụ mùa giải mới nhất, nhưng không thể vào \"Danh sách khách quý\". Bạn có muốn tiếp tục thử thách không?"
  },
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_LeftBtnDesc = {Text = "Hủy"},
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_Title = {
    Text = "Tiếp tục thách thức"
  },
  TipsType_RailWayContinueSaveStage_Desc = {
    Text = "Tiến độ thách đấu lần trước là {s1} - Giai đoạn {s2} - Trận chiến thứ {s3}, đã nhận được \"Điểm khách VIP\" × {s4}\nBạn có muốn tiếp tục thách đấu không?"
  },
  TipsType_RailWayContinueSaveStage_LeftBtnDesc = {Text = "Hủy"},
  TipsType_RailWayContinueSaveStage_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_RailWayContinueSaveStage_Title = {
    Text = "Tiếp tục thách thức"
  },
  TipsType_RailWayHaveSaveStage_Desc = {
    Text = "Cần kết thúc thử thách đã lưu trước đó mới có thể thực hiện thử thách mới"
  },
  TipsType_RailWaySaveAndExitInBattleTips_Desc = {
    Text = "Bạn có chắc chắn muốn thoát khỏi thách thức không? \n Tiến trình thách thức lần này sẽ được lưu, lần thách thức tiếp theo sẽ tiếp tục với tiến trình hiện tại và mở lại trận chiến này."
  },
  TipsType_RailWaySaveAndExitInBattleTips_LeftBtnDesc = {Text = "Hủy"},
  TipsType_RailWaySaveAndExitInBattleTips_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_RailWaySaveAndExitInBattleTips_Title = {
    Text = "Lưu và thoát"
  },
  TipsType_RailWaySaveAndExitTips_Desc = {
    Text = "Bạn có chắc chắn muốn thoát khỏi thử thách không? \n Tiến trình thử thách này sẽ được lưu, lần thử thách tiếp theo sẽ tiếp tục từ tiến trình hiện tại."
  },
  TipsType_RailWaySaveAndExitTips_LeftBtnDesc = {Text = "Hủy"},
  TipsType_RailWaySaveAndExitTips_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_RailWaySaveAndExitTips_Title = {
    Text = "Lưu và thoát"
  },
  TipsType_RailWaySeasonSwitchTips_Desc = {
    Text = "Mùa giải đã được cập nhật. Tiếp tục thử thách có thể hoàn thành nhiệm vụ mùa giải mới nhất, nhưng không thể vào \"Danh sách khách quý\"."
  },
  TipsType_ReplayNullTips_Desc = {
    Text = "Thông tin phát lại không thể để trống"
  },
  TipsType_SchoolConflictTips_Desc = {
    Text = "Trong đội ngũ có sự xung đột giữa các thân thể được đánh thức của giới vực, vui lòng tiến hành điều chỉnh."
  },
  TipsType_SelectedAwakensAndCardsExceedLimit_Desc = {
    Text = "Đã vượt quá số lượng đã chọn"
  },
  TipsType_ServerRankDataLoading_Desc = {
    Text = "Dữ liệu bảng xếp hạng này chưa tải xong, vui lòng mở lại giao diện sau."
  },
  TipsType_ServerRankDataLoading_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_ServerRankDataLoading_Title = {
    Text = "Dữ liệu bảng xếp hạng máy chủ đang khởi tạo"
  },
  TipsType_ShopBulkBuyConfirm_Desc = {
    Text = "Sẽ sử dụng <Blue:{s1}> {s2}, đổi lấy <Blue:{s3}> {s4}, xác nhận đổi không?"
  },
  TipsType_ShopBulkBuyConfirm_LeftBtnDesc = {Text = "Hủy"},
  TipsType_ShopBulkBuyConfirm_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_ShopBulkBuyConfirm_Title = {
    Text = "Xác nhận đổi"
  },
  TipsType_SocialRecordHideTips_Desc = {
    Text = "Nhật ký chiến đấu đã bị ẩn"
  },
  TipsType_SteamOverlayEnabledTips_Desc = {
    Text = "Vui lòng bật \"Bật giao diện Steam trong khi chơi game\" trong Steam \"Cài đặt - Trong game\" và \"Thuộc tính - Chung\" của trò chơi này, sau đó khởi động lại trò chơi và thử lại."
  },
  TipsType_SteamOverlayEnabledTips_LeftBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_SteamOverlayEnabledTips_Title = {
    Text = "Lời nhắc thân thiện"
  },
  TipsType_SteamRestartTips_Desc = {
    Text = "Xác thực Steam bất thường, vui lòng khởi động lại Steam client và thử lại"
  },
  TipsType_SteamRestartTips_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_SteamRestartTips_Title = {
    Text = "Đăng nhập bất thường"
  },
  TipsType_SubBestExperienceTips_Chapter3_Desc = {
    Text = "Để đảm bảo trải nghiệm cốt truyện tốt nhất, đề nghị hoàn thành các nhiệm vụ điều tra sau."
  },
  TipsType_SubBestExperienceTips_Chapter3_LeftBtnDesc = {Text = "Thoát"},
  TipsType_SubBestExperienceTips_Chapter3_RightBtnDesc = {
    Text = "Vẫn phải điều tra"
  },
  TipsType_SubBestExperienceTips_Chapter3_Title = {
    Text = "Xác nhận điều tra"
  },
  TipsType_SubBestExperienceTips_Chapter5_Desc = {
    Text = "Để đảm bảo trải nghiệm cốt truyện tốt nhất, đề nghị hoàn thành các nhiệm vụ điều tra sau."
  },
  TipsType_SubBestExperienceTips_Chapter5_LeftBtnDesc = {Text = "Thoát"},
  TipsType_SubBestExperienceTips_Chapter5_RightBtnDesc = {
    Text = "Vẫn phải điều tra"
  },
  TipsType_SubBestExperienceTips_Chapter5_Title = {
    Text = "Xác nhận điều tra"
  },
  TipsType_SubBestExperienceTips_ChapterS2_Desc = {
    Text = "Để đảm bảo trải nghiệm cốt truyện tốt nhất, đề nghị hoàn thành các nhiệm vụ điều tra sau."
  },
  TipsType_SubBestExperienceTips_ChapterS2_LeftBtnDesc = {Text = "Thoát"},
  TipsType_SubBestExperienceTips_ChapterS2_RightBtnDesc = {
    Text = "Vẫn phải điều tra"
  },
  TipsType_SubBestExperienceTips_ChapterS2_Title = {
    Text = "Xác nhận điều tra"
  },
  TipsType_SummonFailureTips_Desc = {
    Text = "Thông tin vật liệu tiêu hao triệu hồi đã thay đổi, vui lòng triệu hồi lại"
  },
  TipsType_SummonPriorityNotEnoughTips_Desc = {
    Text = "Thiếu {s1} <Blue:\"{s2}\">, có muốn tiêu thụ <Blue:\"{s4}\"×{s3} >thay thế không?"
  },
  TipsType_SummonPriorityNotEnoughTips_LeftBtnDesc = {Text = "Hủy"},
  TipsType_SummonPriorityNotEnoughTips_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_SummonPriorityNotEnoughTips_Title = {
    Text = "Xác nhận đổi"
  },
  TipsType_SummonType_14SelectConfirm_BottomDesc = {
    Text = "<Blue: Lưu ý: Sau khi chọn, không thể thay đổi hoạt động này nữa!>"
  },
  TipsType_SummonType_14SelectConfirm_Desc = {
    Text = "Có xác nhận chọn Thể thức tỉnh<OrangeQuality:「{s1}」,「{s2}」,「{s3}」,「{s4}」> làm UP định hướng cho sự kiện này không?"
  },
  TipsType_SummonType_14SelectConfirm_LeftBtnDesc = {Text = "Hủy"},
  TipsType_SummonType_14SelectConfirm_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_SummonType_14SelectConfirm_Title = {
    Text = "Xác nhận lựa chọn"
  },
  TipsType_SummonType_14SelectLimitTips_BottomDesc = {
    Text = "<Blue: Lưu ý: Sau khi chọn, không thể thay đổi hoạt động này nữa!>"
  },
  TipsType_SummonType_14SelectLimitTips_Desc = {
    Text = "Đã đạt đến giới hạn số lượng lựa chọn"
  },
  TipsType_SummonType_17IncompleteSelectionTips_Desc = {
    Text = "Vui lòng hoàn thành tất cả các lựa chọn trước khi thử lại"
  },
  TipsType_SummonType_17SelectConfirm_Desc = {
    Text = "Xác nhận hoàn thành lựa chọn Thể thức tỉnh được chỉ định kỳ này?\nSau khi xác nhận, lựa chọn kỳ này sẽ không thể thay đổi lại."
  },
  TipsType_SummonType_17SelectConfirm_LeftBtnDesc = {Text = "Hủy"},
  TipsType_SummonType_17SelectConfirm_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_SummonType_17SelectConfirm_Title = {
    Text = "Xác nhận lựa chọn"
  },
  TipsType_SupportListLatestTips_Desc = {
    Text = "Đã là Trạng thái mới nhất, hãy theo dõi thêm nhiều đồng môn để có thêm nhiều lựa chọn Hỗ trợ chiến đấu nhé!"
  },
  TipsType_TrinketAutoRefineExitTips_Desc = {
    Text = "Đang tiến hành tự động chuyển lục, không thể thực hiện thao tác."
  },
  TipsType_TrinketAutoRefineTips_BottomDesc = {
    Text = "(Tự động chuyển lục cho đến khi một thuộc tính chưa khóa đạt cường độ 8 thì dừng.)"
  },
  TipsType_TrinketAutoRefineTips_Desc = {
    Text = "Tối đa sao chép {s1} lần\nTối đa tiêu thụ"
  },
  TipsType_TrinketAutoRefineTips_LeftBtnDesc = {Text = "Hủy"},
  TipsType_TrinketAutoRefineTips_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_TrinketAutoRefineTips_Title = {
    Text = "Xác nhận tự động chuyển lục"
  },
  TipsType_TrinketBagFullTips_Desc = {
    Text = "Túi Giao ước đã đầy"
  },
  TipsType_TrinketBatchUnbindTips_Desc = {
    Text = "Có muốn tách ly tất cả Giao ước không?"
  },
  TipsType_TrinketBatchUnbindTips_LeftBtnDesc = {Text = "Hủy"},
  TipsType_TrinketBatchUnbindTips_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_TrinketBatchUnbindTips_Title = {
    Text = "Xác nhận Tách ly"
  },
  TipsType_TrinketBindSaveTips_Desc = {
    Text = "Tồn tại Giao ước đang được kết hợp, không thể lưu thành phương án!"
  },
  TipsType_TrinketBindTips_Desc = {
    Text = "Xác nhận kết hợp Giao ước sau đây? Các Giao ước đã được trang bị bởi Thể thức tỉnh khác hoặc tồn tại trong đội hình/phương án/hỗ trợ sẽ tự động được tháo ra."
  },
  TipsType_TrinketBindTips_LeftBtnDesc = {Text = "Hủy"},
  TipsType_TrinketBindTips_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_TrinketBindTips_Title = {
    Text = "Xác nhận kết hợp"
  },
  TipsType_TrinketChangeBindTips_Desc = {
    Text = "Xác nhận thay đổi kết hợp?"
  },
  TipsType_TrinketChangeBindTips_LeftBtnDesc = {Text = "Hủy"},
  TipsType_TrinketChangeBindTips_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_TrinketChangeBindTips_Title = {
    Text = "Xác nhận thay đổi kết hợp"
  },
  TipsType_TrinketHighLevelBatchUnbindTips_Desc = {
    Text = "Có muốn tách ly tất cả Giao ước không?\n\n<color=#9BA3A2><size=30>Trong vật liệu đã chọn có chứa bộ phận Giao ước +12.</size></color>"
  },
  TipsType_TrinketHighLevelBatchUnbindTips_LeftBtnDesc = {Text = "Hủy"},
  TipsType_TrinketHighLevelBatchUnbindTips_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_TrinketHighLevelBatchUnbindTips_Title = {
    Text = "Xác nhận Tách ly"
  },
  TipsType_TrinketHighLevelChangeBindTips_Desc = {
    Text = "Xác nhận thay đổi kết hợp?\n\n<color=#9BA3A2><size=30>Trong vật liệu đã chọn có chứa bộ phận Giao ước +12.</size></color>"
  },
  TipsType_TrinketHighLevelChangeBindTips_LeftBtnDesc = {Text = "Hủy"},
  TipsType_TrinketHighLevelChangeBindTips_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_TrinketHighLevelChangeBindTips_Title = {
    Text = "Xác nhận thay đổi kết hợp"
  },
  TipsType_TrinketHighLevelUnbindTips_Desc = {
    Text = "Xác nhận tách ly Giao ước này?\n\n<color=#9BA3A2><size=30>Trong vật liệu đã chọn có chứa bộ phận Giao ước +12.</size></color>"
  },
  TipsType_TrinketHighLevelUnbindTips_LeftBtnDesc = {Text = "Hủy"},
  TipsType_TrinketHighLevelUnbindTips_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_TrinketHighLevelUnbindTips_Title = {
    Text = "Xác nhận Tách ly"
  },
  TipsType_TrinketUnbindTips_Desc = {
    Text = "Xác nhận tách ly Giao ước này?"
  },
  TipsType_TrinketUnbindTips_LeftBtnDesc = {Text = "Hủy"},
  TipsType_TrinketUnbindTips_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_TrinketUnbindTips_Title = {
    Text = "Xác nhận Tách ly"
  },
  TipsType_TryAgainLaterTips_Desc = {
    Text = "<color=#5EF2FF>Giá trị pha</color> này đang được sử dụng, vui lòng thử lại sau"
  },
  TipsType_WaitOppositeSideAccept_Desc = {
    Text = "Đang chờ\n{s1}\nchấp nhận lời mời của <Blue:{s2}>"
  },
  TipsType_WaitOppositeSideAccept_LeftBtnDesc = {Text = "Hủy"},
  TipsType_WaitOppositeSideAccept_Title = {
    Text = "Đấu trường mật khẩu"
  },
  TipsType_WaitOthersEnter_Desc = {
    Text = "Đang chờ những Người Giữ Gìn khác nhập\n <Blue:{s1}>\nkhớp mật mã đối chiến"
  },
  TipsType_WaitOthersEnter_LeftBtnDesc = {Text = "Hủy"},
  TipsType_WaitOthersEnter_RightBtnDesc = {
    Text = "Sao chép <color=#5EF2FF>giá trị pha</color>"
  },
  TipsType_WaitOthersEnter_Title = {
    Text = "Đối kháng mật khẩu"
  },
  TipsType_WeaponRandomChestConfirm_Desc = {
    Text = "Xác nhận tiêu thụ <Blue:{s1}>, nhận 1 vòng mệnh <Blue:ngẫu nhiên>?"
  },
  TipsType_WeaponRandomChestConfirm_LeftBtnDesc = {Text = "Hủy"},
  TipsType_WeaponRandomChestConfirm_RightBtnDesc = {
    Text = "Xác nhận"
  },
  TipsType_WeaponRandomChestConfirm_Title = {
    Text = "Xác nhận sử dụng"
  },
  TipsType_WeekChallengeSweepTips_Desc = {
    Text = "Số lần nhận thưởng trong tuần đã hết, không thể thực hiện tái hiện."
  }
})
return Text_TipsType
