__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_ActorAttrType = readonly({
  ActorAttrType_121209_AttributeDesc = {
    Text = "Cấp Tri Thức Cấm Kỵ bằng với cấp của Người Giữ Bí Mật, quyết định hiệu quả của 3 loại Độ Sâu Nghiên Cứu dưới đây. Nếu cấp trung bình của các Thể Thức Tỉnh trong đội hình lớn hơn hoặc bằng cấp Người Giữ Bí Mật, thì Cấp Tri Thức Cấm Kỵ sẽ lấy giá trị trung bình giữa cấp trung bình Thể Thức Tỉnh trong đội và cấp Người Giữ Bí Mật.\nĐộ Sâu Nghiên Cứu Sinh Thể: <Blue:{s1}>\n·Quyết định cường độ hiệu quả chuyển hóa mỗi 100 điểm thuộc tính thể chất của Thể Thức Tỉnh thành sinh mệnh đội.\nĐộ Sâu Nghiên Cứu Vật Tượng: <Blue:{s2}>\n·Quyết định cường độ hiệu quả loại sức mạnh, sát thương xúc thủ, khiên, hồi phục sinh mệnh, giảm sức mạnh do Tạo Vật, Khắc Ấn, Chìa Lệnh gây ra.\nĐộ Sâu Nghiên Cứu Linh Thức: <Blue:{s3}>\n·Quyết định cường độ hiệu quả loại trúng độc cố định, phản kích cố định, sát thương cố định, chảy máu cố định do Tạo Vật, Khắc Ấn, Chìa Lệnh gây ra.\n"
  },
  ActorAttrType_121209_Text = {
    Text = "Cấp Tri Thức Cấm Kỵ"
  },
  ActorAttrType_18103_Text = {
    Text = "Khiên nhân vật"
  },
  ActorAttrType_18104_Text = {
    Text = "Sửa chữa phần trăm sát thương của thẻ đánh"
  },
  ActorAttrType_18105_AttributeUpText = {
    Text = "Thương chí mạng +{s1}"
  },
  ActorAttrType_18105_Text = {
    Text = "Sát thương chí mạng"
  },
  ActorAttrType_18106_Text = {
    Text = "Lá chắn tăng cường"
  },
  ActorAttrType_18107_AttributeUpText = {
    Text = "Tấn công+{s1}"
  },
  ActorAttrType_18107_Text = {
    Text = "tấn công"
  },
  ActorAttrType_18108_Text = {
    Text = "Thể chất"
  },
  ActorAttrType_18109_Text = {
    Text = "Điều chỉnh phần trăm thương của thẻ bài"
  },
  ActorAttrType_18110_Text = {
    Text = "Điều chỉnh phần trăm yếu đuối"
  },
  ActorAttrType_18111_Text = {
    Text = "Điều chỉnh phần trăm lá chắn chịu"
  },
  ActorAttrType_18112_AttributeUpText = {
    Text = "Phòng thủ+{ s1 }"
  },
  ActorAttrType_18112_Text = {
    Text = "Phòng thủ tăng cường"
  },
  ActorAttrType_18113_AttributeDesc = {
    Text = "Hiệu suất sạc điên cuồng của thân thể được đánh thức"
  },
  ActorAttrType_18113_Text = {
    Text = "Cuồng nhiệt đầu trận"
  },
  ActorAttrType_18114_AttributeDesc = {
    Text = "Càng cao thể chất, sức sống tối đa của thân thể được đánh thức càng cao. \nCấp độ điều tra của Người Giữ Gìn càng cao, ảnh hưởng của thể chất đối với sức sống tối đa của thân thể được đánh thức càng mạnh."
  },
  ActorAttrType_18114_AttributeUpText = {
    Text = "Thể chất+{s1}"
  },
  ActorAttrType_18114_Text = {
    Text = "Thể chất"
  },
  ActorAttrType_18115_AttributeDesc = {
    Text = "Sau khi nguồn gốc của thân thể được đánh thức và giải phóng, giá trị điên cuồng sẽ được hoàn trả"
  },
  ActorAttrType_18115_AttributeUpText = {
    Text = "Giảm tiêu thụ điên cuồng + {s1}"
  },
  ActorAttrType_18115_Text = {
    Text = "Giảm tiêu thụ Điên cuồng"
  },
  ActorAttrType_18116_AttributeDesc = {
    Text = "Càng cao thể chất, sức sống tối đa của thân thể được đánh thức càng cao. \nCấp độ điều tra của Người Giữ Gìn càng cao, ảnh hưởng của thể chất đối với sức sống tối đa của thân thể được đánh thức càng mạnh."
  },
  ActorAttrType_18116_AttributeUpText = {
    Text = "Thể chất+{s1}"
  },
  ActorAttrType_18116_Text = {
    Text = "Tăng cường thể chất"
  },
  ActorAttrType_18117_Text = {
    Text = "thương tổn xúc tu"
  },
  ActorAttrType_18118_Text = {
    Text = "Khe Siêu chiều"
  },
  ActorAttrType_18119_Text = {
    Text = "Sửa chữa tỷ lệ phần trăm thương nhận được"
  },
  ActorAttrType_18120_AttributeDesc = {
    Text = "Lượng điên cuồng tích lũy tối đa và lượng điên cuồng tiêu hao khi phát động bùng nổ điên cuồng của thể thức tỉnh đều bằng điên cuồng cơ bản."
  },
  ActorAttrType_18120_AttributeUpText = {
    Text = "Mức giới hạn điên cuồng +{s1}"
  },
  ActorAttrType_18120_Text = {
    Text = "Điên cuồng cơ bản"
  },
  ActorAttrType_18121_AttributeDesc = {
    Text = "Cấp độ Kỹ năng 2"
  },
  ActorAttrType_18121_AttributeUpText = {
    Text = "Kỹ năng 2 cấp độ +{s1}"
  },
  ActorAttrType_18121_Text = {
    Text = "Cấp độ Kỹ năng 2"
  },
  ActorAttrType_18122_AttributeDesc = {
    Text = "Cấp độ phòng thủ"
  },
  ActorAttrType_18122_AttributeUpText = {
    Text = "Độ phòng thủ +{s1}"
  },
  ActorAttrType_18122_Text = {
    Text = "Cấp độ phòng thủ"
  },
  ActorAttrType_18123_Text = {
    Text = "Sửa chữa giá trị cố định số lần gây thương"
  },
  ActorAttrType_18124_Text = {
    Text = "Gây sửa đổi giá trị cố định của lá chắn"
  },
  ActorAttrType_18125_Text = {
    Text = "Sửa chữa giá trị cố định của lá chắn"
  },
  ActorAttrType_18126_AttributeDesc = {
    Text = "Sự thông thạo giới vực của đội bằng tổng sự thông thạo giới vực của các thể thức tỉnh trong đội. Sự thông thạo giới vực có thể nâng cao hiệu ứng tài năng giới vực của đội. Nếu đội hiện tại là \"Thuần khiết Hải Vực/Thuần khiết Thịt Máu/Thuần khiết Siêu Chiều\", hiệu ứng sự thông thạo giới vực sẽ được nhân đôi.\n·<Blue:Hỗn Mang> Đối với đội ngũ thuộc giới vực Hỗn Mang, mỗi 1 điểm sự thông thạo giới vực, sau khi phát động mật lệnh, tất cả thể thức tỉnh sẽ nhận thêm <Blue:0.05> điểm điên cuồng.\n·<Blue:Hải Vực> Đối với đội ngũ thuộc giới vực Hải Vực, mỗi 1 điểm sự thông thạo giới vực, sau khi phát động bùng nổ điên cuồng, có <Blue:0.25％> xác suất nhận thêm 1 lớp Râu chạm tập hợp(xác suất vượt quá 100% có thể nhận nhiều lớp), khi chuyển sang \"Biển Lặng\" sẽ nhận được lá chắn tăng <Blue:0.01％> sinh lực tối đa, và trong \"Sóng Gầm\", do sát thương chủ động gây ra tấn công xúc tu sẽ tăng <Blue:0.02%> sát thương xúc tu.\n·<Blue:Thịt Máu> Đối với đội ngũ thuộc giới vực Thịt Máu, mỗi 1 điểm sự thông thạo giới vực, trong mỗi lượt khi kích hoạt lần đầu tiên việc tiêu thụ sẽ nhận thêm lá chắn bằng <Blue:0.01%> sinh lực tối đa và <Blue:0.005%> sức mạnh tạm thời(tăng theo mức giảm sinh lực, tối đa tăng 100%).\n·<Blue:Siêu Chiều> Đối với đội ngũ thuộc giới vực Siêu Chiều, mỗi 1 điểm sự thông thạo giới vực, vào đầu lượt có <Blue:0.125%> xác suất nhận 1 thẻ \"Cảm hứng\"(xác suất vượt quá 100% có thể nhận nhiều thẻ)."
  },
  ActorAttrType_18126_AttributeUpText = {
    Text = "Giới vực thành thục + {s1}"
  },
  ActorAttrType_18126_Text = {
    Text = "Sự thông thạo giới vực"
  },
  ActorAttrType_18127_Text = {Text = "Sinh lực"},
  ActorAttrType_18128_AttributeUpText = {
    Text = "Tấn công+{s1}"
  },
  ActorAttrType_18128_Text = {
    Text = "Sức tấn công tăng lên"
  },
  ActorAttrType_18129_AttributeDesc = {
    Text = "Sát thương cơ bản tăng thêm càng cao, thương từ thân thể được đánh thức gây ra càng lớn"
  },
  ActorAttrType_18129_AttributeUpText = {
    Text = "Thương cơ bản +{s1}"
  },
  ActorAttrType_18129_Text = {
    Text = "Sát thương cơ bản"
  },
  ActorAttrType_18130_Text = {
    Text = "Cấp độ"
  },
  ActorAttrType_18131_AttributeDesc = {
    Text = "Khi kết thúc lượt, điểm điên cuồng của thân thể được đánh thức sẽ tự động hồi phục. Trong chế độ Bài tập, điểm này sẽ được hồi phục sau mỗi lần hành động của thân thể được đánh thức"
  },
  ActorAttrType_18131_AttributeUpText = {
    Text = "Điên cuồng tự động trả lời+{s1}"
  },
  ActorAttrType_18131_Text = {
    Text = "Phản hồi tự động điên cuồng"
  },
  ActorAttrType_18132_Text = {
    Text = "Cấp độ Khai sáng"
  },
  ActorAttrType_18133_Text = {
    Text = "Điều chỉnh tỷ lệ phần trăm điên cuồng nhận vào"
  },
  ActorAttrType_18134_Text = {
    Text = "Giới hạn hợp nhất phôi"
  },
  ActorAttrType_18135_Text = {
    Text = "Nhân vật hiện tại với Điên cuồng"
  },
  ActorAttrType_18136_Text = {
    Text = "Sửa chữa giá trị cố định của sát thương nhận được"
  },
  ActorAttrType_18137_AttributeDesc = {
    Text = "Khi thân thể được đánh thức, tăng tỷ lệ giá trị lá chắn và hồi phục"
  },
  ActorAttrType_18137_AttributeUpText = {
    Text = "Lá chắn và chữa trị mạnh mẽ + {s1}"
  },
  ActorAttrType_18137_Text = {
    Text = "Lá chắn và Chữa trị Mạnh mẽ"
  },
  ActorAttrType_18138_Text = {
    Text = "Sức chữa tăng"
  },
  ActorAttrType_18139_AttributeDesc = {
    Text = "Khi chơi thẻ lệnh hoặc Khai mở linh trí, mỗi 1 Điểm tính toán tiêu thụ sẽ nhận được {s1} điểm Năng lượng chìa khóa bạc. Khi thuộc tính này tăng lên, lượng Năng lượng chìa khóa bạc bổ sung sẽ dần suy giảm."
  },
  ActorAttrType_18139_AttributeUpText = {
    Text = "Sạc chìa khóa bạc+{s1}"
  },
  ActorAttrType_18139_Text = {
    Text = "Cấp độ nạp năng lượng chìa khóa bạc"
  },
  ActorAttrType_18140_Text = {
    Text = "Số lần kháng cự tử vong"
  },
  ActorAttrType_18141_AttributeDesc = {
    Text = "Cấp độ đánh"
  },
  ActorAttrType_18141_AttributeUpText = {
    Text = "Cấp độ đánh+{s1}"
  },
  ActorAttrType_18141_Text = {
    Text = "Cấp độ đánh"
  },
  ActorAttrType_18142_AttributeDesc = {
    Text = "Tăng tỷ lệ phần trăm tất cả \"thương cơ bản\" gây ra bởi thân thể được đánh thức, số lớp \"trúng độc cố định\" và \"phản công cố định\"được áp dụng, cũng như thương tổn xúc tu ban đầu của vùng giới sâu thẳm."
  },
  ActorAttrType_18142_AttributeUpText = {
    Text = "Thương mạnh mẽ+{s1}"
  },
  ActorAttrType_18142_Text = {
    Text = "Khuếch đại sát thương"
  },
  ActorAttrType_18143_Text = {
    Text = "Sửa đổi phần trăm sát thương của cơn thịnh nộ bùng phát"
  },
  ActorAttrType_18144_AttributeDesc = {
    Text = "Khi thân thể được đánh thức gây thương, tỷ lệ kháng chí mạng tăng lên"
  },
  ActorAttrType_18144_AttributeUpText = {
    Text = "Kháng chí mạng+{s1}"
  },
  ActorAttrType_18144_Text = {
    Text = "Kháng chí mạng"
  },
  ActorAttrType_18145_AttributeDesc = {
    Text = "Cấp độ đến từ nguồn gốc"
  },
  ActorAttrType_18145_AttributeUpText = {
    Text = "Nguồn gốc xuất hiện cấp + {s1}"
  },
  ActorAttrType_18145_Text = {
    Text = "Cấp độ đến từ nguồn gốc"
  },
  ActorAttrType_18146_Text = {
    Text = "Chỉnh sửa giá trị cố định của việc chữa trị"
  },
  ActorAttrType_18147_AttributeUpText = {
    Text = "Tỷ lệ khắcăng may mắn +{s1}"
  },
  ActorAttrType_18147_Text = {
    Text = "Tỷ lệ khắcIn may mắn"
  },
  ActorAttrType_18148_Text = {
    Text = "Gây ra sự điều chỉnh giá trị chữa trị cố định"
  },
  ActorAttrType_18149_Text = {
    Text = "Tăng cường thể chất"
  },
  ActorAttrType_18150_Text = {
    Text = "Điều chỉnh phần trăm yếu đuối"
  },
  ActorAttrType_18151_AttributeDesc = {
    Text = "Kháng cự tử vong của đội ngũ bằng tổng kháng cự tử vong của các thể thức tỉnh trong đội. \n Khi bị thương tổn chí mạng trong chiến đấu, có xác suất giữ lại 1 điểm sinh lực, sau khi kích hoạt sẽ nhận thêm 2 điểm tính toán và rút 2 lá bài trong lượt tiếp theo, kháng cự tử vong nhận được hiện tại và sau đó sẽ giảm một nửa, kéo dài cho đến khi kết thúc cuộc điều tra."
  },
  ActorAttrType_18151_AttributeUpText = {
    Text = "Kháng cự tử vong+{s1}"
  },
  ActorAttrType_18151_Text = {
    Text = "kháng cự tử vong"
  },
  ActorAttrType_18152_Text = {
    Text = "Gây ra sự điều chỉnh phần trăm Điên cuồng"
  },
  ActorAttrType_18154_Text = {
    Text = "Giới hạn râu chạm"
  },
  ActorAttrType_18155_AttributeDesc = {
    Text = "Tăng tỷ lệ rơi dấu đen từ kẻ địch sau chiến thắng."
  },
  ActorAttrType_18155_AttributeUpText = {
    Text = "Dấu đen rơi +{s1}"
  },
  ActorAttrType_18155_Text = {
    Text = "Tỉ lệ rơi dấu ấn"
  },
  ActorAttrType_18156_Text = {
    Text = "Chịu sự điều chỉnh giá trị cố định của điên cuồng"
  },
  ActorAttrType_18157_Text = {
    Text = "Ý định ẩn dấu"
  },
  ActorAttrType_18158_Text = {
    Text = "Sửa chữa giá trị cố định của thương"
  },
  ActorAttrType_18159_AttributeUpText = {
    Text = "Tỷ lệ chí mạng+{s1 }"
  },
  ActorAttrType_18159_Text = {
    Text = "Tỉ lệ chí mạng"
  },
  ActorAttrType_18160_AttributeDesc = {
    Text = "Cấp độ Kỹ năng 1"
  },
  ActorAttrType_18160_AttributeUpText = {
    Text = "Kỹ năng 1 cấp độ +{s1}"
  },
  ActorAttrType_18160_Text = {
    Text = "Cấp độ Kỹ năng 1"
  },
  ActorAttrType_18161_Text = {
    Text = "Cấp độ"
  },
  ActorAttrType_18162_Text = {
    Text = "Sát thương tăng lên"
  },
  ActorAttrType_18163_Text = {
    Text = "Số lượng xúc tu"
  },
  ActorAttrType_18164_Text = {
    Text = "Modifior phần trăm chữa lành nhận được"
  },
  ActorAttrType_18165_Text = {
    Text = "Điểm tính toán tối đa"
  },
  ActorAttrType_18166_Text = {
    Text = "Điều chỉnh phần trăm tăng sát thương"
  },
  ActorAttrType_18167_AttributeUpText = {
    Text = "Phòng thủ+{ s1 }"
  },
  ActorAttrType_18167_Text = {
    Text = "phòng thủ"
  },
  ActorAttrType_18168_AttributeDesc = {
    Text = "Cấp độ thức tỉnh Linh tri"
  },
  ActorAttrType_18168_AttributeUpText = {
    Text = "Thức tỉnh linh tri thức +{s1}"
  },
  ActorAttrType_18168_Text = {
    Text = "Cấp độ thức tỉnh Linh tri"
  },
  ActorAttrType_21322_Text = {
    Text = "Sạc năng lượng chìa khóa bạc"
  },
  ActorAttrType_22207_AttributeDesc = {
    Text = "Mỗi lần kích hoạt cơn thịnh nộ bùng phát, nhận được {s1} điểm cuồng nộ. Khi thuộc tính này tăng lên, hiệu ứng gia tăng bổ sung sẽ dần suy giảm."
  },
  ActorAttrType_22207_AttributeUpText = {
    Text = "Cấp độ điên cuồng +{s1}"
  },
  ActorAttrType_22207_Text = {
    Text = "Cấp độ nạp lại điên cuồng"
  },
  ActorAttrType_22214_Text = {
    Text = "Hồi phục điên cuồng"
  }
})
return Text_ActorAttrType
