__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_AwakerConfig = readonly({
  AwakerConfig_125346_Age = {Text = "1 tháng 6"},
  AwakerConfig_125346_AwakerIntroduction = {
    Text = "·Vị thần phương Đông thanh lịch và quyến rũ. Khi cô ấy di chuyển quạt, mọi sinh linh sẽ say mê trước sức hấp dẫn chết người của cô. \n·Niềm vui do dục vọng sinh ra như độc dược thấm vào xương tủy, khiến người ta sẵn lòng bước vào sự tan chảy và sự im lặng trong lời thề tình ái mà cô hứa hẹn. \n·Trong màn chơi này, sẽ có Xu và Ramona mang cấp độ 50, kỹ năng cấp 5, khởi linh 3 ra chiến đấu. Vào đầu mỗi lượt, đặt 1 lá \"Cảm hứng nâng cao\" và 1 lá \"Phôi thai\" vào tay, áp dụng 1 lớp \"Say mê\" lên tất cả kẻ thù."
  },
  AwakerConfig_125346_Gender = {Text = "Nữ"},
  AwakerConfig_125346_Height = {Text = "?+5'5.2''"},
  AwakerConfig_125346_Introduction = {
    Text = "Sức hấp dẫn mê hoặc có thể làm tan vỡ ý chí chiến đấu của kẻ địch, chất độc ăn mòn thấm vào toàn thân sẽ bùng nổ mạnh mẽ khi chúng chìm đắm."
  },
  AwakerConfig_125346_Name = {Text = "Xu"},
  AwakerConfig_125346_Painter = {Text = "Bala bala"},
  AwakerConfig_125346_SummonSlogan = {
    Text = "Chăm chú vào vẻ đẹp khiến người ta rùng mình này, cô ấy \"yêu\" bạn, Ngài sẽ mãi mãi, mãi mãi \"đồng hành\" cùng bạn."
  },
  AwakerConfig_125346_Title = {Text = "Xu"},
  AwakerConfig_125346_VoiceActor = {
    Text = "Điền Trung Lý Huệ"
  },
  AwakerConfig_125346_Weight = {Text = "?+105lbs"},
  AwakerConfig_130226_Age = {
    Text = "không biết"
  },
  AwakerConfig_130226_AwakerIntroduction = {
    Text = "· Khi tất cả bị thịt máu xói mòn, khi cuộc sống thường ngày bị đảo lộn, trong tiếng ồn ào hỗn loạn, bồ công anh rơi xuống vùng hoang nguyên này.\n·Hãy giơ tay ra, hãy nắm lấy cô ấy. Tình yêu sẽ vượt qua bề ngoài, neo đậu bạn và người bạn yêu lại một lần nữa.\n·\"Bài Hát Của Saya\" có thể chọn một đồng minh để tạo ra lượng lớn thẻ bài của họ đặt vào bộ bài, kích hoạt \"Nuốt chửng\" hoặc tiêu thụ \"Vũ Chủng\" được tạo bởi \"Mô Phỏng Sinh Thể\" có thể tăng cường các thẻ bài sao chép này, \"Máu Thịt Nở Rộ\" có thể nhanh chóng rút các thẻ bài này vào tay và gây ra lượng lớn \"Xói mòn\" cho kẻ địch.\n·Trong Màn chơi này, sẽ mang Saya và lơ-tan ở Cấp độ 50, cấp kỹ năng 5, khởi linh 3 ra chiến đấu, khi chiến đấu Bắt đầu Saya nhận được 200 điểm Điên loạn, 4 lớp \"Vũ Chủng\", 500 điểm Sức mạnh. Khi lượt Bắt đầu, đặt 1 \"Phôi thai\" vào tay, rút 3 lá bài, nhận được 3 điểm Điểm tính toán, tất cả Thể thức tỉnh nhận được 50 Điên loạn."
  },
  AwakerConfig_130226_Gender = {Text = "Nữ"},
  AwakerConfig_130226_Height = {Text = "?"},
  AwakerConfig_130226_Introduction = {
    Text = "Vượt qua rào cản giữa những vì sao xa xôi, chỉ có tình yêu, là mệnh đề duy nhất và vĩnh hằng."
  },
  AwakerConfig_130226_Name = {Text = "Saya"},
  AwakerConfig_130226_Painter = {Text = "Bala bala"},
  AwakerConfig_130226_SummonSlogan = {
    Text = "Khi tất cả bồ công anh đã bay đi, nhân danh tình yêu, chúng ta sẽ tái ngộ."
  },
  AwakerConfig_130226_Title = {Text = "Saya"},
  AwakerConfig_130226_VoiceActor = {
    Text = "Kawamura Midori"
  },
  AwakerConfig_130226_Weight = {Text = "?"},
  AwakerConfig_130384_Age = {Text = "?"},
  AwakerConfig_130384_Gender = {Text = "Nữ"},
  AwakerConfig_130384_Gi = {Text = "?"},
  AwakerConfig_130384_Height = {Text = "?"},
  AwakerConfig_130384_Name = {Text = "Tsathoggua"},
  AwakerConfig_130384_Painter = {Text = "Bala bala"},
  AwakerConfig_130384_Title = {Text = "Tsathoggua"},
  AwakerConfig_130384_Weight = {Text = "?"},
  AwakerConfig_130901_Age = {
    Text = "7 tháng 13"
  },
  AwakerConfig_130901_AwakerIntroduction = {
    Text = "·Cô gái tươi sáng khao khát tình bạn, có thể được khuyến khích từ cơn thịnh nộ bùng nổ của đồng đội và phát động tấn công phối hợp với đồng đội để truy đuổi kẻ thù. \n·Khẩu pháo khổng lồ đáng sợ không tương xứng với thân hình mảnh mai của cô đang khát khao tiêu thụ năng lượng, dòng xoáy sinh ra khi ràng buộc được giải phóng sẽ ngay lập tức san bằng mọi thứ xung quanh. \n·Trong màn chơi này, sẽ mang theo Mosk và Ramona, Orci có cấp độ 50, kỹ năng cấp 5, khởi linh 3, bắt đầu trận chiến nhận 200 điểm thương tổn xúc tu, vào đầu lượt rút 3 thẻ bài, nhận 3 điểm sức tính toán, các thể thức tỉnh khác ngoài Mosk nhận 50 điểm điên cuồng."
  },
  AwakerConfig_130901_Gender = {Text = "Nữ"},
  AwakerConfig_130901_Introduction = {
    Text = "Cô gái hoang dã thẳng thắn vui vẻ, với vũ khí hạng nặng trong tay có thể gây ra sự tàn phá lớn sau khi tích tụ năng lượng dòng xoáy."
  },
  AwakerConfig_130901_Name = {Text = "Vortice"},
  AwakerConfig_130901_Painter = {Text = "Bala bala"},
  AwakerConfig_130901_SummonSlogan = {
    Text = "Ràng buộc, dẫn dắt, thả lỏng, hủy diệt. Vortex sẽ nghe theo sự chỉ dẫn của cô ấy, để mọi kẻ xấu chìm đắm trong vực thẳm."
  },
  AwakerConfig_130901_Title = {Text = "Vortice"},
  AwakerConfig_130901_VoiceActor = {
    Text = "Matsumoto Nanami"
  },
  AwakerConfig_130901_Weight = {
    Text = "Do cấu tạo cơ thể đặc biệt, không thể tính toán"
  },
  AwakerConfig_132340_Age = {Text = "?"},
  AwakerConfig_132340_Gender = {Text = "Nam"},
  AwakerConfig_132340_Gi = {Text = "?"},
  AwakerConfig_132340_Height = {Text = "?"},
  AwakerConfig_132340_Introduction = {
    Text = "Bóng ma điện tử mang sứ mệnh kỳ lạ, chỉ có rất ít người từng thấy được diện mạo thật."
  },
  AwakerConfig_132340_Name = {
    Text = "Giả Chi Nhất Hình"
  },
  AwakerConfig_132340_Painter = {Text = "Bala bala"},
  AwakerConfig_132340_Title = {
    Text = "Thực Thể Cấm Kỵ"
  },
  AwakerConfig_132340_Weight = {Text = "?"},
  AwakerConfig_132374_Age = {Text = "?"},
  AwakerConfig_132374_Gender = {Text = "Nam"},
  AwakerConfig_132374_Gi = {Text = "?"},
  AwakerConfig_132374_Height = {Text = "?"},
  AwakerConfig_132374_Introduction = {
    Text = "Bóng ma điện tử mang sứ mệnh kỳ lạ, chỉ có rất ít người từng thấy được diện mạo thật."
  },
  AwakerConfig_132374_Name = {
    Text = "Thương Chi Nhất Hình"
  },
  AwakerConfig_132374_Painter = {Text = "Bala bala"},
  AwakerConfig_132374_Title = {
    Text = "Thực Thể Cấm Kỵ"
  },
  AwakerConfig_132374_Weight = {Text = "?"},
  AwakerConfig_132375_Age = {Text = "?"},
  AwakerConfig_132375_Gender = {Text = "Nam"},
  AwakerConfig_132375_Gi = {Text = "?"},
  AwakerConfig_132375_Height = {Text = "?"},
  AwakerConfig_132375_Introduction = {
    Text = "Bóng ma điện tử mang sứ mệnh kỳ lạ, chỉ có rất ít người từng thấy được diện mạo thật."
  },
  AwakerConfig_132375_Name = {
    Text = "Giáng Chi Nhất Hình"
  },
  AwakerConfig_132375_Painter = {Text = "Bala bala"},
  AwakerConfig_132375_Title = {
    Text = "Thực Thể Cấm Kỵ"
  },
  AwakerConfig_132375_Weight = {Text = "?"},
  AwakerConfig_132376_Age = {Text = "?"},
  AwakerConfig_132376_Gender = {Text = "Nam"},
  AwakerConfig_132376_Gi = {Text = "?"},
  AwakerConfig_132376_Height = {Text = "?"},
  AwakerConfig_132376_Introduction = {
    Text = "Bóng ma điện tử mang sứ mệnh kỳ lạ, chỉ có rất ít người từng thấy được diện mạo thật."
  },
  AwakerConfig_132376_Name = {
    Text = "Xích Chi Nhất Hình"
  },
  AwakerConfig_132376_Painter = {Text = "Bala bala"},
  AwakerConfig_132376_Title = {
    Text = "Thực Thể Cấm Kỵ"
  },
  AwakerConfig_132376_Weight = {Text = "?"},
  AwakerConfig_141302_Age = {
    Text = "27 tháng 8"
  },
  AwakerConfig_141302_AwakerIntroduction = {
    Text = "·Lãnh chúa của vùng đất không còn Luật lệ, tất cả những ai lọt vào Mắt hắn đều trở thành thần dân đi theo mãi mãi.\n·Tiếng Còi vang lên đột ngột, những \"Giam Mộng Quỷ\" ùa ra như vỡ tổ là công cụ săn mồi đắc lực của hắn, kẻ thù bị rút cạn sức lực rơi xuống vực thẳm giữa vòng vây, từ đó vương quốc vĩnh hằng đón thêm một thành viên mới.\n·Tại Màn chơi này, sẽ mang Pontos Cấp độ 50, Kỹ Năng cấp 5, khởi linh 3 ra trận, khi Bắt đầu chiến đấu nhận được 100 điểm thương tổn xúc tu, Pontos nhận được 75 điểm Điên loạn, 3 tầng \"Bầy Đàn\". Khi bắt đầu lượt, rút 3 lá bài, tất cả Thể thức tỉnh nhận được 20 Điên loạn."
  },
  AwakerConfig_141302_Gender = {Text = "Nam"},
  AwakerConfig_141302_Introduction = {
    Text = "Vực thẳm cho phép anh lưu giữ tất cả mọi thứ, sẽ không còn bất cứ điều gì có thể khiến anh đối mặt với sự phân li tuyệt vọng."
  },
  AwakerConfig_141302_Name = {Text = "Pontus"},
  AwakerConfig_141302_Painter = {Text = "Bala bala"},
  AwakerConfig_141302_SummonSlogan = {
    Text = "Ở tận cùng của biển, có một cuộc cuồng hoan không bao giờ dứt."
  },
  AwakerConfig_141302_Title = {Text = "Pontus"},
  AwakerConfig_141302_VoiceActor = {
    Text = "Suwa Junichi"
  },
  AwakerConfig_141302_Weight = {
    Text = "Không thể đo lường"
  },
  AwakerConfig_143941_Age = {Text = "?"},
  AwakerConfig_143941_Gender = {Text = "Nữ"},
  AwakerConfig_143941_Gi = {Text = "?"},
  AwakerConfig_143941_Height = {Text = "?"},
  AwakerConfig_143941_Name = {
    Text = "Thái Tuế"
  },
  AwakerConfig_143941_Painter = {Text = "Bala bala"},
  AwakerConfig_143941_Title = {
    Text = "Thái Tuế"
  },
  AwakerConfig_143941_Weight = {Text = "?"},
  AwakerConfig_145363_Age = {
    Text = "3 tháng 21"
  },
  AwakerConfig_145363_AwakerIntroduction = {
    Text = "·Một chiến binh sinh ra để chiến đấu, kẻ thù càng mạnh càng khiến cô ấy Hưng phấn. Cùng với thanh kiếm거대 Hợp Bích Trầm Kình, cô ấy Nuốt chửng tất cả, chinh phục tất cả.\n·Trong Màn chơi này, sẽ xuất trận với Lotan: Ngư Thần Cấp độ 50, cấp Kỹ Năng 5, khởi linh 3 cùng Ramona, Orci.\n·Trong trận chiến này Sinh lực tối đa của Người Giữ Gìn tăng gấp đôi. Khi bắt đầu lượt, đặt 1 \"Cảm hứng\" vào tay, tất cả Thể thức tỉnh nhận được 20 điểm Điên loạn."
  },
  AwakerConfig_145363_Gender = {Text = "Nữ"},
  AwakerConfig_145363_Introduction = {
    Text = "Chiến binh sinh ra để chiến đấu, kẻ thù càng mạnh càng khiến cô ấy Hưng phấn. Cùng với thanh kiếm거대 Hợp Bích Trầm Kình, cô ấy tiêu thụ tất cả, chinh phục tất cả."
  },
  AwakerConfig_145363_Name = {
    Text = "Lotan: Ngư Thần"
  },
  AwakerConfig_145363_Painter = {Text = "Bala bala"},
  AwakerConfig_145363_SummonSlogan = {
    Text = "Tiến về phía trước, là hướng duy nhất của cơn bão. Còn cô ấy, sinh ra đã là cơn bão."
  },
  AwakerConfig_145363_Title = {
    Text = "Lotan: Ngư Thần"
  },
  AwakerConfig_145363_VoiceActor = {
    Text = "Miyazono Miku"
  },
  AwakerConfig_147397_Age = {Text = "3 tháng 7"},
  AwakerConfig_147397_Characteristic = {
    Text = "Thẻ bài tăng cường    Chiếm đoạt sức mạnh"
  },
  AwakerConfig_147397_Gender = {Text = "Nữ"},
  AwakerConfig_147397_Name = {
    Text = "Mộ Tinh·Tincture"
  },
  AwakerConfig_147397_Painter = {Text = "Bala bala"},
  AwakerConfig_147397_Title = {
    Text = "Mộ Tinh·Tincture"
  },
  AwakerConfig_147397_VoiceActor = {Text = "Okabe Mika"},
  AwakerConfig_15560_Age = {
    Text = "10 tháng 28"
  },
  AwakerConfig_15560_AwakerIntroduction = {
    Text = "·Thông qua khai mở linh trí và thẻ lệnh có thể nhanh chóng tích lũy <RetaliateIconKeywords:phản công>, thương càng cao, nhận được <RetaliateIconKeywords:phản công> càng nhiều. \n·Hiện tại <RetaliateIconKeywords:phản công> càng cao, thương gây ra từ cơn thịnh nộ bùng phát càng lớn, nếu chỉ có 1 kẻ địch, cơn thịnh nộ bùng phát còn có thể gây thêm 1 lần thương. \n·Trong cấp độ này, sẽ mang theo Pandia cấp 50, kỹ năng cấp 5, khởi linh 3 ra chiến đấu, kẻ địch sẽ nhận được tăng cường trong lượt đầu tiên."
  },
  AwakerConfig_15560_Characteristic = {
    Text = "Phản công kẻ địch    gây thương nhiều lần"
  },
  AwakerConfig_15560_Gender = {Text = "Nữ"},
  AwakerConfig_15560_Introduction = {
    Text = "Trong khi đánh bại đối thủ, có được nhiều phản công, khiến đối thủ muốn trả đòn cũng đau đớn vô cùng."
  },
  AwakerConfig_15560_Name = {Text = "Pandia"},
  AwakerConfig_15560_Painter = {Text = "Bala bala"},
  AwakerConfig_15560_SummonSlogan = {
    Text = "Đừng mù quáng tin vào vẻ ngọt ngào bên ngoài, dưới lớp vỏ nhiệt tình có thể ẩn chứa linh hồn xấu xa."
  },
  AwakerConfig_15560_Title = {Text = "Pandia"},
  AwakerConfig_15560_VoiceActor = {Text = "Cam Yuuki"},
  AwakerConfig_15562_Age = {
    Text = "1 tháng 31"
  },
  AwakerConfig_15562_AwakerIntroduction = {
    Text = "·Khi kết thúc lượt, nếu 「Lửa Xanh」 ở trong bộ bài hoặc không gian siêu việt, nó sẽ được nâng cấp thành <DerivativeCardKeywords_19:「Lửa Xanh Bị Phân Huỷ」>, sau khi nâng cấp có thể gây thương cao hơn và <IntoxicationIconKeywords:trúng độc>. \n·Khi đối mặt với thương nhiều đợt, thông qua 「lửa dụ dỗ」 có thể nhận được nhiều lá 「Lửa Xanh」. \n·Cơn thịnh nộ bùng phát có thể phát hành tất cả các thẻ bài của Liz trong tay mà không cần sức tính toán, tích lũy Lửa Xanh sẽ gây sát thương bùng nổ cao. \n·Trong thử thách này, Liz cấp 50, kỹ năng cấp 5, khởi linh cấp 3 sẽ tham chiến, mỗi lượt sẽ nhận được 7 điểm <PowerIconKeywords:lực lượng>, 15 điểm điên cuồng, sau khi bắt đầu lượt siêu việt còn sẽ nhận được 100 điểm điên cuồng. Kẻ địch sẽ được tăng cường trong lượt đầu tiên."
  },
  AwakerConfig_15562_Characteristic = {
    Text = "Trúng độc bùng phát    vòng tuần hoàn tài nguyên"
  },
  AwakerConfig_15562_Gender = {Text = "Nữ"},
  AwakerConfig_15562_Gi = {Text = "?"},
  AwakerConfig_15562_Introduction = {
    Text = "Liên tục phát triển ngọn lửa xanh trong không gian siêu chiều hoặc bộ bài, phát động bùng nổ điên cuồng sẽ giải phóng nó để thiêu rụi kẻ thù."
  },
  AwakerConfig_15562_Name = {Text = "Liz"},
  AwakerConfig_15562_Painter = {Text = "Bala bala"},
  AwakerConfig_15562_SummonSlogan = {
    Text = "Đầu ngón chân quay vòng đã mang theo ước mơ của cô, sự theo đuổi của cô, và khi tất cả sụp đổ, ngọn lửa xanh lục cháy bừng từ sự căm hận và tuyệt vọng."
  },
  AwakerConfig_15562_Title = {Text = "Liz"},
  AwakerConfig_15562_VoiceActor = {Text = "Aoi Yuka"},
  AwakerConfig_15562_Weight = {Text = "?"},
  AwakerConfig_15563_Age = {
    Text = "8 tháng 20"
  },
  AwakerConfig_15563_AwakerIntroduction = {
    Text = "·Sử dụng thẻ bài và bùng nổ điên cuồng để giúp xúc tu đạt được sự phát triển bùng nổ\n·Tận dụng khả năng kích hoạt xúc tu để gây ra lượng thương lớn cho kẻ địch\n·Trong cấp độ này có thể nhận được thêm điểm tính toán và điên cuồng"
  },
  AwakerConfig_15563_Characteristic = {
    Text = "Râu chạm phát nổ    râu chạm tăng trưởng"
  },
  AwakerConfig_15563_Gender = {Text = "Nam"},
  AwakerConfig_15563_Introduction = {
    Text = "Dùng sức ép của nhà vua ra lệnh cho xúc tu trừng phạt kẻ thù, và bằng dòng máu của vua để nhanh chóng kích hoạt tiềm năng gây sát thương xúc tu bùng nổ."
  },
  AwakerConfig_15563_Name = {Text = "Tulu"},
  AwakerConfig_15563_Painter = {Text = "Bala bala"},
  AwakerConfig_15563_SummonSlogan = {
    Text = "Trái với suy nghĩ thông thường, anh ta ghét nước."
  },
  AwakerConfig_15563_Title = {Text = "Tulu"},
  AwakerConfig_15563_VoiceActor = {
    Text = "Miyazono Miku"
  },
  AwakerConfig_15564_Age = {
    Text = "5 tháng 20"
  },
  AwakerConfig_15564_AwakerIntroduction = {
    Text = "·\"Sức mạnh của Lưỡi đao khổng lồ\" và\"cắt đầu trọng thương\" có lượng thương cao và <PowerIconKeywords:lực lượng> tăng thêm, có thể gây ra lượng lớn thương cho kẻ thù đơn lẻ và nhóm. \n·\"Cắt đầu trọng thương\" khi tấn công kẻ địch có sức sống thấp hoặc tiêu diệt mục tiêu còn có thể hoàn lại sức tính toán đã tiêu thụ. \n· Cơn thịnh nộ bùng phát có thể chọn chiếm đoạt hoặc ẩn mình, lựa chọn thời điểm để phát triển hoặc bùng nổ từ đó gây thêm nhiều thương hơn. \n· Trong lần thử thách này, sẽ mang theo Goliath cấp độ 50, kỹ năng cấp độ 5, khởi linh cấp 3 ra trận."
  },
  AwakerConfig_15564_Characteristic = {
    Text = "Lực lượng bùng nổ    Chiếm đoạt sức mạnh"
  },
  AwakerConfig_15564_Gender = {Text = "Nam"},
  AwakerConfig_15564_Gi = {Text = "?"},
  AwakerConfig_15564_Introduction = {
    Text = "Sử dụng sức mạnh của lưỡi dao khổng lồ để chém chết kẻ thù, thiệt hại xúc tu và sức mạnh khiến hắn ngày càng trở nên mạnh mẽ hơn."
  },
  AwakerConfig_15564_Name = {Text = "Goliath"},
  AwakerConfig_15564_Painter = {Text = "Bala bala"},
  AwakerConfig_15564_SummonSlogan = {
    Text = "Khi anh ta giơ cao cây kiếm lớn, chắc chắn sẽ là máu và cái chết."
  },
  AwakerConfig_15564_Title = {Text = "Goliath"},
  AwakerConfig_15564_VoiceActor = {
    Text = "Mộc Hạ Chương Thừa"
  },
  AwakerConfig_15564_Weight = {Text = "?"},
  AwakerConfig_15565_Age = {
    Text = "7 tháng 29"
  },
  AwakerConfig_15565_AwakerIntroduction = {
    Text = "·Sở hữu khả năng phòng ngự mạnh mẽ và tích lũy <RetaliateIconKeywords:phản công>, sau khi khai mở linh trí thức, khả năng này còn được nâng cao hơn nữa. \n·Lá chắn hiện tại càng cao, lá chắn nhận được từ cơn thịnh nộ bùng phát càng nhiều; <RetaliateIconKeywords:phản công> hiện tại càng cao, sát thương diện rộng gây ra từ cơn thịnh nộ bùng phát càng lớn. \n·Trong cấp độ này, sẽ mang theo Nốtira và đòa cấp 50, kỹ năng cấp 5, khởi linh 3 tham chiến, mỗi lượt nhận 10 điểm điên cuồng, kẻ thù trong lượt đầu tiên sẽ nhận được tăng cường."
  },
  AwakerConfig_15565_Characteristic = {
    Text = "Phòng thủ Bùng Nổ    Thu Hồi Bài Loại"
  },
  AwakerConfig_15565_Gender = {Text = "Nữ"},
  AwakerConfig_15565_Introduction = {
    Text = "Vỏ ốc chắc chắn giúp đội có được sự bảo vệ tốt hơn và phản công bằng những cái gai trên vỏ ốc với đối thủ tấn công."
  },
  AwakerConfig_15565_Name = {Text = "Nautila"},
  AwakerConfig_15565_Painter = {Text = "Bala bala"},
  AwakerConfig_15565_SummonSlogan = {
    Text = "Chừng nào còn có thể phiêu lưu, cô ấy sẽ mỉm cười và tiến lên."
  },
  AwakerConfig_15565_Title = {Text = "Nautila"},
  AwakerConfig_15565_VoiceActor = {
    Text = "Kunimaru Kuruko"
  },
  AwakerConfig_15566_Age = {
    Text = "3 tháng 15"
  },
  AwakerConfig_15566_AwakerIntroduction = {
    Text = "·Có khả năng hỗ trợ cung cấp điểm tính toán, hồi sinh lực và tăng cường thương tổn xúc tu tương đối toàn diện. \n·Sau khi bùng nổ, trong trận chiến này sẽ hồi sinh khi nhận thương tổn chí mạng, mỗi trận chiến tối đa kích hoạt 1 lần. \n·Trong cấp độ này, sẽ mang theo Hilaster cấp 50, kỹ năng cấp 5, khởi linh 3 ra trận, mỗi lượt sẽ nhận được 20 điểm điên cuồng, kẻ địch trong lượt đầu tiên sẽ nhận được tăng cường."
  },
  AwakerConfig_15566_Characteristic = {
    Text = "Râu chạm tạm thời    miễn nhiễm với cái chết"
  },
  AwakerConfig_15566_Gender = {Text = "Nữ"},
  AwakerConfig_15566_Gi = {Text = "?"},
  AwakerConfig_15566_Introduction = {
    Text = "Bảo vệ hành trình, bảo vệ đồng minh khỏi nguy cơ cái chết và sử dụng sức mạnh giấc mơ để hồi phục sức sống cho đồng minh."
  },
  AwakerConfig_15566_Name = {Text = "Celeste"},
  AwakerConfig_15566_Painter = {Text = "Bala bala"},
  AwakerConfig_15566_SummonSlogan = {
    Text = "\"chiếc tàu đó, tại sao lại chìm?\""
  },
  AwakerConfig_15566_Title = {Text = "Celeste"},
  AwakerConfig_15566_VoiceActor = {
    Text = "Phong Đào"
  },
  AwakerConfig_15566_Weight = {Text = "?"},
  AwakerConfig_15567_Age = {
    Text = "12 tháng 25"
  },
  AwakerConfig_15567_AwakerIntroduction = {
    Text = "·Sử dụng linh hoạt dây xích để đánh bại kẻ thù, có khả năng gây ra sát thương đồng thời áp dụng một lượng lớn <BleedingIconKeywords:chảy máu>.\n·Tích lũy thẻ bài trước, tìm kiếm thời cơ phát động bùng nổ điên cuồng để nhận được tăng cường mạnh mẽ, kết hợp với hiệu ứng <DevouredIconKeywords:tiêu thụ> để giảm tiêu thụ điểm tính toán của tất cả thẻ bài của bản thân.\n·Trong cấp độ này, sẽ mang theo Dây máu · Hiro cấp 50, kỹ năng cấp 5, khởi linh 3, sinh lực ban đầu là 40%, vào cuối lượt nhận được 50 điểm điên cuồng và 100 độ hợp nhất phôi thai."
  },
  AwakerConfig_15567_Characteristic = {
    Text = "Đánh liên hoàn    tăng cường thẻ tấn công"
  },
  AwakerConfig_15567_Gender = {Text = "Nữ"},
  AwakerConfig_15567_Introduction = {
    Text = "Cô sẽ sử dụng những kỹ năng độc đáo để kết hợp tấn công kẻ thù, và kết thúc đối thủ bằng sát thương chảy máu."
  },
  AwakerConfig_15567_Name = {
    Text = "Helot: Xích Máu"
  },
  AwakerConfig_15567_Painter = {Text = "Bala bala"},
  AwakerConfig_15567_SummonSlogan = {
    Text = "Sau khi thoát khỏi xiềng xích, cô ấy đòi lại công bằng với người đã tạo ra mọi xiềng xích."
  },
  AwakerConfig_15567_Title = {
    Text = "Helot: Xích Máu"
  },
  AwakerConfig_15567_VoiceActor = {
    Text = "Kunimaru Kuruko"
  },
  AwakerConfig_15568_Age = {
    Text = "12 tháng 12"
  },
  AwakerConfig_15568_Characteristic = {
    Text = "Tìm kiếm thẻ bài    nhiều lần thương"
  },
  AwakerConfig_15568_Gender = {Text = "Nữ"},
  AwakerConfig_15568_Introduction = {
    Text = "Thích ứng sức mạnh từ những chỉ lệnh trong quá khứ để sử dụng cho cô, và gây ra sát thương cao trong một lần bằng thanh kiếm định mệnh."
  },
  AwakerConfig_15568_Name = {
    Text = "Ramona: Thời Quy"
  },
  AwakerConfig_15568_Painter = {Text = "Bala bala"},
  AwakerConfig_15568_Title = {
    Text = "Ramona: Thời Quy"
  },
  AwakerConfig_15568_VoiceActor = {
    Text = "Yamamoto Aiko"
  },
  AwakerConfig_15569_Age = {
    Text = "3 tháng 21"
  },
  AwakerConfig_15569_Characteristic = {
    Text = "Tấn công diện rộng mạnh mẽ    Tăng trưởng thương"
  },
  AwakerConfig_15569_Gender = {Text = "Nữ"},
  AwakerConfig_15569_Introduction = {
    Text = "Sử dụng những \"đòn đánh\" liên tục để gây ra nhiều sát thương, và đánh thức quái vật tận cùng nuốt chửng kẻ thù."
  },
  AwakerConfig_15569_Name = {Text = "Lotan"},
  AwakerConfig_15569_Painter = {Text = "Bala bala"},
  AwakerConfig_15569_SummonSlogan = {
    Text = "Quái vật sao khổng lồ phán: \"Hãy tạo nên cơn sóng thần cuồn cuộn! Khiến kẻ thù phải gào thét trong tuyệt vọng!\""
  },
  AwakerConfig_15569_Title = {Text = "Lotan"},
  AwakerConfig_15569_VoiceActor = {
    Text = "Miyazono Miku"
  },
  AwakerConfig_15570_Age = {Text = "1 tháng 1"},
  AwakerConfig_15570_Characteristic = {
    Text = "Giải trừ yếu đuối    phục hồi sinh lực"
  },
  AwakerConfig_15570_Gender = {Text = "Nữ"},
  AwakerConfig_15570_Introduction = {
    Text = "Cung cấp điên cuồng cho những người đánh thức khác với thành quả nghiên cứu hoàn hảo của mình, và phục hồi một lượng lớn sức sống."
  },
  AwakerConfig_15570_Name = {Text = "Doll"},
  AwakerConfig_15570_Painter = {Text = "Bala bala"},
  AwakerConfig_15570_SummonSlogan = {
    Text = "Điều cô ấy tìm kiếm, chính là bí ẩn ẩn giấu giữa trời đất."
  },
  AwakerConfig_15570_Title = {Text = "Doll"},
  AwakerConfig_15570_VoiceActor = {
    Text = "Ngư Cốc Gia Đại"
  },
  AwakerConfig_15571_Age = {Text = "9 tháng 9"},
  AwakerConfig_15571_AwakerIntroduction = {
    Text = "· Sở hữu khả năng phục hồi cuộc sống mạnh mẽ và cung cấp số học linh hoạt.\n· \"Món rùa nấu\" và\"Giám sát im lặng\"đều có <RetainIconKeywords:Bảo lưu>, mỗi lượt bảo lưu sẽ nhận được sự phát triển khác nhau.\n· Aliemus,\"Món rùa nấu\",\"Món ăn kỳ diệu\"đều có thể gây ra <IntoxicationIconKeywords:Độc dược> lên tất cả kẻ địch.\n· Trong thử thách lần này, sẽ mang theo Karen cấp 50, kỹ năng cấp 5, khai ngộ 3 ra trận, địch lần đầu tiên tấn công sẽ được tăng cường."
  },
  AwakerConfig_15571_Characteristic = {
    Text = "Bổ sung sức tính toán kháng cự cái chết"
  },
  AwakerConfig_15571_Gender = {Text = "Nữ"},
  AwakerConfig_15571_Introduction = {
    Text = "Cung cấp cho đội của bạn sức mạnh số lớn và phục hồi sức sống của họ bằng ẩm thực, đồng thời dùng ẩm thực đen để độc chết kẻ thù."
  },
  AwakerConfig_15571_Name = {Text = "Karen"},
  AwakerConfig_15571_Painter = {Text = "Bala bala"},
  AwakerConfig_15571_SummonSlogan = {
    Text = "Dù là chổi hay vũ khí, cô ấy đều sử dụng một cách rất duyên dáng."
  },
  AwakerConfig_15571_Title = {Text = "Karen"},
  AwakerConfig_15571_VoiceActor = {
    Text = "Nikomi Yukino"
  },
  AwakerConfig_15572_Age = {Text = "4 tháng 1"},
  AwakerConfig_15572_AwakerIntroduction = {
    Text = "·Cơn thịnh nộ bùng phát có thể gây thương lớn và rút bài, rút càng nhiều thẻ lệnh, trạng thái hoặc triệu chứng của bản thân, số lần gây thương càng nhiều. \n·\"Tất cả biến mất!\" có thể xáo trộn lại tay bài, đồng thời bỏ đi các thẻ trạng thái hoặc triệu chứng và nhận được điên cuồng. \n·\"Lấy vật từ xa\" lấy ra các thẻ bài từ không gian siêu việt để đổi lấy lượng thương và sức tính toán lớn. \n·Trong lần thử thách này, Kassia sẽ xuất chiến với cấp độ 50, kỹ năng cấp 5, khởi linh 3, kẻ địch thủ lĩnh sẽ nhận được tăng cường sau đòn tấn công đầu tiên."
  },
  AwakerConfig_15572_Characteristic = {
    Text = "Thêm bài vào tay    sức mạnh tạm thời"
  },
  AwakerConfig_15572_Gender = {Text = "Nữ"},
  AwakerConfig_15572_Introduction = {
    Text = "Có thể rút ra hoặc thay đổi nhiều thẻ như một trò ảo thuật, và nhận được sức mạnh tạm thời để tăng cường sát thương."
  },
  AwakerConfig_15572_Name = {Text = "Casiah"},
  AwakerConfig_15572_Painter = {Text = "Bala bala"},
  AwakerConfig_15572_SummonSlogan = {
    Text = "Biến mất những thứ hữu hình là trò gì? Buổi biểu diễn của cô ấy có thể đánh cắp linh hồn."
  },
  AwakerConfig_15572_Title = {Text = "Casiah"},
  AwakerConfig_15572_VoiceActor = {
    Text = "Thất Túc Lãm"
  },
  AwakerConfig_15573_Age = {Text = "6 tháng 8"},
  AwakerConfig_15573_Characteristic = {
    Text = "Thương    phá vỡ phòng ngự"
  },
  AwakerConfig_15573_Gender = {Text = "Nữ"},
  AwakerConfig_15573_Introduction = {
    Text = "Liên tục tấn công bằng việc phân chia tuyến tính để tiêu hao ít sức mạnh tính toán, nếu cần có thể tiêu hao tất cả tuyến tính để phát động tổng tấn công."
  },
  AwakerConfig_15573_Name = {Text = "Aurita"},
  AwakerConfig_15573_Painter = {Text = "Bala bala"},
  AwakerConfig_15573_SummonSlogan = {
    Text = "\"ừ? sứa? thạch?\""
  },
  AwakerConfig_15573_Title = {Text = "Aurita"},
  AwakerConfig_15573_VoiceActor = {
    Text = "Điền Thôn Dụ Gia Lợi"
  },
  AwakerConfig_15574_Age = {Text = "3 tháng 7"},
  AwakerConfig_15574_AwakerIntroduction = {
    Text = "·Thức tỉnh linh tri có thể trao cho tất cả thẻ lệnh của Tinkerer các hiệu ứng ngẫu nhiên, nhận ngẫu nhiên <WeaknessIconKeywords:yếu đuối>, <VulnerabilityIconKeywords:tăng sát thương>, rút bài, sức tính toán, và khả năng điên cuồng. \n·Cơn thịnh nộ bùng phát có thể giảm 1 điểm tiêu thụ sức tính toán của năm lá bài trên tay đồng thời tăng cường thương cơ bản của \"đánh\" của Tinkerer. \n·Bằng cách tích lũy lực lượng và thương cơ bản của \"đánh\", sử dụng \"đánh\" sẽ gây ra lượng thương lớn. \n·Trong lần thử thách này, sẽ mang theo \"Tinkerer\" cấp 50, kỹ năng cấp 5, khởi linh cấp 3 ra trận, mỗi lượt nhận được 15 điểm điên cuồng, kẻ địch nhận được tăng cường trong lượt đầu tiên."
  },
  AwakerConfig_15574_Characteristic = {
    Text = "Lực lượng chiếm đoạt, tiêu thụ giảm"
  },
  AwakerConfig_15574_Gender = {Text = "Nữ"},
  AwakerConfig_15574_Introduction = {
    Text = "Sử dụng tiếng hát vượt thời gian để giảm tiêu tốn số học của một lượng lớn thẻ bài trong tay, và nâng cao ý chí chiến đấu cho đồng đội."
  },
  AwakerConfig_15574_Name = {Text = "Tinct"},
  AwakerConfig_15574_Painter = {Text = "Bala bala"},
  AwakerConfig_15574_SummonSlogan = {
    Text = "Trong lồng vàng tơ, dưới xiềng xích vô hình, chim sơn ca chỉ hót, chỉ hót."
  },
  AwakerConfig_15574_Title = {Text = "Tinct"},
  AwakerConfig_15574_VoiceActor = {Text = "Okabe Mika"},
  AwakerConfig_15575_Age = {Text = "4 tháng 8"},
  AwakerConfig_15575_AwakerIntroduction = {
    Text = "·Điên cuồng bùng phát và Thức tỉnh linh tri có khả năng rút bài mạnh mẽ, tăng tỷ lệ dung sai của đội. \n·\"Dòng chảy sâu thẳm\" có thể khiến râu chạm mỗi lần tấn công gây <IntoxicationIconKeywords:trúng độc> lên tất cả kẻ địch. Khi kết hợp với việc điều khiển râu chạm tấn công và \"Biển cuồng nhiệt\", có thể áp dụng lượng lớn <IntoxicationIconKeywords:trúng độc> lên kẻ địch chỉ trong một lần. \n·Trong thử thách này, Pháp Luân Tư cấp 50, kỹ năng cấp 5, khởi linh 3 sẽ xuất chiến. Kẻ địch nhận tăng cường ngay lượt đầu."
  },
  AwakerConfig_15575_Characteristic = {
    Text = "Râu chạm sinh thành    bổ sung lá bài"
  },
  AwakerConfig_15575_Gender = {Text = "Nữ"},
  AwakerConfig_15575_Introduction = {
    Text = "Gắn độc tố vào xúc tu để làm nhục kẻ thù, và nhờ đức tin chân thành cho đội có được thẻ bài, chỉ ra con đường tiến lên."
  },
  AwakerConfig_15575_Name = {Text = "Faros"},
  AwakerConfig_15575_Painter = {Text = "Bala bala"},
  AwakerConfig_15575_SummonSlogan = {
    Text = "Hơi thở của núi lửa dưới đáy biển không còn vẳng bên tai, giấc mơ huyễn hoặc ở biển sâu cũng đã trở thành hình ảnh mờ ảo."
  },
  AwakerConfig_15575_Title = {Text = "Faros"},
  AwakerConfig_15575_VoiceActor = {
    Text = "Phong Đào"
  },
  AwakerConfig_15575_Weight = {Text = "?"},
  AwakerConfig_15576_Age = {
    Text = "12 tháng 22"
  },
  AwakerConfig_15576_AwakerIntroduction = {
    Text = "·có khả năng phòng thủ độc đáo, chuyển đổi thương của kẻ địch thành <SacrificeKeyWord:hiến tế>\n·sử dụng thẻ bài có thể nhận được số lượng râu chạm không bị giới hạn bởi số lượng tối đa\n·việc linh hoạt sử dụng hiến tế để đổi lấy phòng thủ mang lại sức mạnh ngắn hạn vượt trội.\n·trong thử thách này, sẽ mang theo \"Muphí\" cấp 50, kỹ năng cấp 5 và khởi linh 3."
  },
  AwakerConfig_15576_Characteristic = {
    Text = "Kích hoạt râu chạm    bổ sung sức tính toán"
  },
  AwakerConfig_15576_Gender = {Text = "Nữ"},
  AwakerConfig_15576_Introduction = {
    Text = "Cô có thể chịu đựng hy sinh để chống lại sát thương cao từ kẻ thù, và có thể triệu hồi xúc tu để phát động tổng tấn công."
  },
  AwakerConfig_15576_Name = {Text = "Murphy"},
  AwakerConfig_15576_Painter = {Text = "Bala bala"},
  AwakerConfig_15576_SummonSlogan = {
    Text = "Nếu dâng lên bánh ngọt và chiếc giường êm ái, có lẽ cô ấy sẽ sẵn lòng lắng nghe người khác hơn."
  },
  AwakerConfig_15576_Title = {Text = "Murphy"},
  AwakerConfig_15576_VoiceActor = {
    Text = "Ouchi Akane"
  },
  AwakerConfig_15577_Age = {Text = "3 tháng 7"},
  AwakerConfig_15577_AwakerIntroduction = {
    Text = "·Bùng nổ điên cuồng có thể cung cấp kháng cự tử vong vĩnh viễn cho phe ta. \n ·Sau khi kích hoạt kháng cự tử vong, khả năng phòng thủ và khả năng hồi phục sẽ được nâng cao. \n ·Khai mở linh trí và thẻ lệnh đều có thể nhận được nhiều phản công và làm yếu kẻ thù <PowerIconKeywords:lực lượng>, có lợi thế khi đối mặt với nhiều kẻ thù và nhiều lần sát thương. \n ·Trong cấp độ này, sẽ mang theo Phiệt cấp 50, kỹ năng cấp 5, khởi linh 3 ra trận, mỗi lượt nhận 30 <EmbryoFusionIconKeywords:Dung hợp Phôi thai>, 10 điểm điên cuồng, kẻ thù trong hai lượt đầu sẽ nhận được tăng cường."
  },
  AwakerConfig_15577_Characteristic = {
    Text = "Kháng cự tử vong    chiếm đoạt sức mạnh"
  },
  AwakerConfig_15577_Gender = {Text = "Nữ"},
  AwakerConfig_15577_Introduction = {
    Text = "Có thể thêm khả năng kháng cự cái chết lớn, và hấp thụ sức mạnh của kẻ thù để chống lại các cuộc tấn công."
  },
  AwakerConfig_15577_Name = {Text = "Faint"},
  AwakerConfig_15577_Painter = {Text = "Bala bala"},
  AwakerConfig_15577_SummonSlogan = {
    Text = "Đứa trẻ yêu quý hoàng yến cũng sẽ có ngày tỏa sáng."
  },
  AwakerConfig_15577_Title = {Text = "Faint"},
  AwakerConfig_15577_VoiceActor = {
    Text = "Yoshiko Satsuki"
  },
  AwakerConfig_15578_Age = {Text = "1 tháng 1"},
  AwakerConfig_15578_Gender = {Text = "Nữ"},
  AwakerConfig_15578_Introduction = {
    Text = "Có tỷ lệ chí mạng và sát thương chí mạng cao, Nâu và lũ chuột sẽ trở thành sự trợ giúp chính cho anh trong việc chống lại nhiều kẻ thù."
  },
  AwakerConfig_15578_Name = {Text = "Jenkin"},
  AwakerConfig_15578_Painter = {Text = "Bala bala"},
  AwakerConfig_15578_Title = {Text = "Jenkin"},
  AwakerConfig_15579_Age = {Text = "9 tháng 7"},
  AwakerConfig_15579_AwakerIntroduction = {
    Text = "·Sở hữu khả năng phòng ngự mạnh mẽ và cung cấp điên cuồng. \n·Bùng nổ có thể khiến 1 thể thức tỉnh khác nhận được nhiều điên cuồng, giúp họ có thể giải phóng nhiều bùng nổ hơn, thậm chí liên tục giải phóng bùng nổ trong 1 lượt. \n·Khai mở linh trí cho phép nhận phản công khi áp dụng lá chắn, cũng có khả năng phản công khi đối mặt với nhiều kẻ thù. \nTrong cấp độ này, sẽ mang theo Winkel cấp 50, kỹ năng cấp 5, khởi linh cấp 3 và lơ-tan ra trận, trong trận thử nghiệm sẽ nhận được tăng cường, kẻ thù sẽ nhận được tăng cường trong lượt đầu tiên."
  },
  AwakerConfig_15579_Characteristic = {
    Text = "Điên cuồng cung cấp    trì hoãn rút bài"
  },
  AwakerConfig_15579_Gender = {Text = "Nữ"},
  AwakerConfig_15579_Introduction = {
    Text = "Có thể cung cấp điên loạn cho các đồng đội khác, đồng thời cũng có thể tiêu hao thẻ tay làm ngưng tụ khiên lớn."
  },
  AwakerConfig_15579_Name = {Text = "Winkle"},
  AwakerConfig_15579_Painter = {Text = "Bala bala"},
  AwakerConfig_15579_SummonSlogan = {
    Text = "Ngay cả bóng tối trong ký ức cũng sẽ thu hút lời nguyền đáng sợ ấy."
  },
  AwakerConfig_15579_Title = {Text = "Winkle"},
  AwakerConfig_15579_VoiceActor = {
    Text = "Thất Túc Lãm"
  },
  AwakerConfig_15580_Age = {
    Text = "12 tháng 7"
  },
  AwakerConfig_15580_AwakerIntroduction = {
    Text = "·Qua thẻ lệnh nhanh chóng xếp chồng <IntoxicationIconKeywords:trúng độc> cho kẻ địch, sử dụng điên cuồng bùng phát để kích hoạt hiệu ứng <IntoxicationIconKeywords:trúng độc> của kẻ địch, gây ra thương tổn nặng nề. \n·\"Dòng triều đêm dâng cao\" gây thêm sát thương và trúng độc khi sử dụng thẻ triệu chứng. Hiệu ứng này sẽ tăng dần. \n·Điên cuồng bùng phát gây ra trúng độc sẽ tăng lên theo từng lần sử dụng. \n·Trong nhiệm vụ này, Ninh Phi Nga sẽ tham gia với cấp độ 50, kỹ năng cấp 5, khởi linh cấp 3. Bắt đầu trận đấu với 3 thẻ triệu chứng."
  },
  AwakerConfig_15580_Characteristic = {
    Text = "Gây ngộ độc    làm suy yếu kẻ địch"
  },
  AwakerConfig_15580_Gender = {Text = "Nữ"},
  AwakerConfig_15580_Introduction = {
    Text = "Kết hợp độc tố biển và điểm yếu, trong khi đảm bảo sự sống sót của bản thân tiếp tục tra tấn đối thủ."
  },
  AwakerConfig_15580_Name = {Text = "Nymphaea"},
  AwakerConfig_15580_Painter = {Text = "Bala bala"},
  AwakerConfig_15580_SummonSlogan = {
    Text = "Hoa súng chưa nở, hòa mình vào lòng đại dương."
  },
  AwakerConfig_15580_Title = {Text = "Nymphaea"},
  AwakerConfig_15580_VoiceActor = {
    Text = "Đông Hải Lâm Á Dụ"
  },
  AwakerConfig_15581_Age = {
    Text = "6 tháng 15"
  },
  AwakerConfig_15581_AwakerIntroduction = {
    Text = "· Có khả năng phòng thủ mạnh mẽ, sức sống càng thấp thì phòng thủ càng mạnh. \n· Càng đau đớn càng điên rồ, trong tình thế tuyệt vọng có sức mạnh một đòn chí mạng. \nTrong cấp độ này, sẽ mang Lily cấp độ 50, kỹ năng cấp 5, khởi linh 3 ra chiến đấu."
  },
  AwakerConfig_15581_Characteristic = {
    Text = "Sức sống tối đa    mạnh hơn khi bị thương"
  },
  AwakerConfig_15581_Gender = {Text = "Nữ"},
  AwakerConfig_15581_Introduction = {
    Text = "Chuyển hóa những nỗi đau đã chịu đựng thành tức giận để tiêu diệt kẻ thù, hoặc chuyển hóa thành sức sống để giúp đỡ đồng minh."
  },
  AwakerConfig_15581_Name = {Text = "Lily"},
  AwakerConfig_15581_Painter = {Text = "Bala bala"},
  AwakerConfig_15581_SummonSlogan = {
    Text = "\"mẹ, ở đâu?\""
  },
  AwakerConfig_15581_Title = {Text = "Lily"},
  AwakerConfig_15581_VoiceActor = {
    Text = "Thịnh Huệ Lý Hoa"
  },
  AwakerConfig_15582_Age = {Text = "7 tháng 2"},
  AwakerConfig_15582_AwakerIntroduction = {
    Text = "·Thẻ lệnh có hiệu ứng độc đáo <O07CardKeyWord:tế lễ>, sẽ chuyển hóa <O07CardKeyWord2:「thánh lễ」> tăng cường thẻ lệnh. \n·Sử dụng cơn điên cuồng bùng phát không chỉ có thể nhận được nhiều <O07CardKeyWord2:「thánh lễ」> hơn, mà còn sẽ nhận được các hiệu ứng khác nhau dựa trên tư thế râu chạm khác nhau. \n·Ba thẻ Thức tỉnh linh tri thức được đánh ra dần dần, mỗi thẻ có khả năng khác nhau, cuối cùng còn có thể liên tục nhận được thẻ tăng cường mạnh mẽ 「hình bóng thần quốc」. \n·Trong lần thử thách này, sẽ mang theo Miriam và Ô Ryta cấp độ 50, kỹ năng cấp độ 5, khởi linh 3, giới hạn bài trong tay +2, Miriam ban đầu có 35 điên cuồng, mỗi lượt nhận được 20 điểm điên cuồng."
  },
  AwakerConfig_15582_Characteristic = {
    Text = "Râu chạm sinh thành    hỗ trợ cuồng nộ"
  },
  AwakerConfig_15582_Gender = {Text = "Nữ"},
  AwakerConfig_15582_Introduction = {
    Text = "Cô có thể sử dụng quyền lực của Đại tế thần để triệu hồi nhiều xúc tu hơn, và cũng có thể dùng dao tế lễ để đầu độc kẻ thù."
  },
  AwakerConfig_15582_Name = {Text = "Miryam"},
  AwakerConfig_15582_Painter = {Text = "Bala bala"},
  AwakerConfig_15582_SummonSlogan = {
    Text = "Niềm tin chân thành cuối cùng đã trở thành lưỡi dao sắc bén, đâm sâu vào chính bản thân mình."
  },
  AwakerConfig_15582_Title = {Text = "Miryam"},
  AwakerConfig_15582_VoiceActor = {
    Text = "Bắc Kỳ Đồng"
  },
  AwakerConfig_15583_Age = {
    Text = "2 tháng 14"
  },
  AwakerConfig_15583_AwakerIntroduction = {
    Text = "·Sở hữu bốn bài thơ có hiệu ứng khác nhau, khi kích hoạt nhảy vọt sẽ vào một trong bốn trạng thái cảm xúc \"Hỷ, Nộ, Ai, Kỵ\". \n·Mỗi trạng thái cảm xúc sẽ mang lại sự gia tăng khả năng khác nhau cho tất cả các thân thể được đánh thức, cơn thịnh nộ bùng phát của Ôrla nhận được thêm nhiều sự gia tăng. \n·Trong lần thử nghiệm này, sẽ mang theo Ôrla và Lơ-tan với cấp độ 50, kỹ năng cấp 5, và khởi linh 3, kẻ địch nhận được tăng cường trong lượt đầu tiên."
  },
  AwakerConfig_15583_Characteristic = {
    Text = "Hoãn trả lời    suy yếu đối phương"
  },
  AwakerConfig_15583_Gender = {Text = "Nữ"},
  AwakerConfig_15583_Introduction = {
    Text = "Cảm xúc khác nhau mang lại những hiệu ứng tăng cường mạnh mẽ khác nhau và thay đổi hiệu ứng bùng nổ điên cuồng của nó."
  },
  AwakerConfig_15583_Name = {Text = "Horla"},
  AwakerConfig_15583_Painter = {Text = "Bala bala"},
  AwakerConfig_15583_SummonSlogan = {
    Text = "Cẩn thận, nỗi buồn của cô ấy còn khó đối phó hơn cả gai hoa hồng."
  },
  AwakerConfig_15583_Title = {Text = "Horla"},
  AwakerConfig_15583_VoiceActor = {Text = "Cam Yuuki"},
  AwakerConfig_15584_Age = {Text = "2 tháng 9"},
  AwakerConfig_15584_AwakerIntroduction = {
    Text = "\n·Sinh lực càng thấp, thương và trả lời càng mạnh. \n·Tích lũy phôi thai trước, sử dụng cơn thịnh nộ bùng nổ không giới hạn <DevouredIconKeywords:tiêu thụ> để gây ra một lượng sát thương lớn. \n·Trong màn này, sẽ mang theo Sorrel cấp 50, kỹ năng cấp 5, khởi linh 3, sinh lực ban đầu là 40%."
  },
  AwakerConfig_15584_Characteristic = {
    Text = "Thương    hồi máu"
  },
  AwakerConfig_15584_Gender = {Text = "Nữ"},
  AwakerConfig_15584_Introduction = {
    Text = "Gây ra sát thương lần cao với điệu múa vòng hoa rực rỡ, và chữa lành bản thân bằng máu của kẻ thù."
  },
  AwakerConfig_15584_Name = {Text = "Sorel"},
  AwakerConfig_15584_Painter = {Text = "Bala bala"},
  AwakerConfig_15584_SummonSlogan = {
    Text = "Đưa lên đây, những bộ lễ phục thêu vàng rực rỡ; đưa lên đây, những chiếc quạt lông chim quý hiếm từ phương xa. Đưa lên đây, chỉ như vậy mới có thể nhận được lời mời tham dự buổi họp mặt của cô ấy."
  },
  AwakerConfig_15584_Title = {Text = "Sorel"},
  AwakerConfig_15584_VoiceActor = {
    Text = "Điền Thôn Dụ Gia Lợi"
  },
  AwakerConfig_15585_Age = {Text = "5 tháng 5"},
  AwakerConfig_15585_Characteristic = {
    Text = "Xóa bỏ yếu đuối    lực lượng tạm thời"
  },
  AwakerConfig_15585_Gender = {Text = "Nam"},
  AwakerConfig_15585_Height = {
    Text = "Anh ta tin chắc rằng chiều cao của mình là khoảng 1.6 mét"
  },
  AwakerConfig_15585_Introduction = {
    Text = "Sử dụng chất nhờn vô hình để tạo ra bức tường và nâng cao giáo dài chỉ huy đồng đội phát động hiệu triệu tấn công."
  },
  AwakerConfig_15585_Name = {Text = "Ogier"},
  AwakerConfig_15585_Painter = {Text = "Bala bala"},
  AwakerConfig_15585_SummonSlogan = {
    Text = "\"Tôi sẽ không để bất kỳ ai bị thương nữa.\""
  },
  AwakerConfig_15585_Title = {Text = "Ogier"},
  AwakerConfig_15585_VoiceActor = {
    Text = "Yama Tsubasa (Otoha Risa)"
  },
  AwakerConfig_15586_Age = {
    Text = "11 tháng 2"
  },
  AwakerConfig_15586_AwakerIntroduction = {
    Text = "·sở hữu khả năng <RetaliateIconKeywords:phản công> mạnh mẽ và hiệu ứng độc đáo kích hoạt nhảy vọt\n·đánh thẻ bài tích lũy \"mộng dẫn\", tiêu thụ \"mộng dẫn\" một cách linh hoạt để tăng cường khả năng của bản thân\n·xếp chồng <RetaliateIconKeywords:phản công>, suy yếu kẻ địch, tận dụng <RetaliateIconKeywords:phản công> để tăng thương\n·trong lần thử thách này, sẽ mang theo \"Vanda\" cấp 50, kỹ năng cấp 5, khởi linh 3 ra trận."
  },
  AwakerConfig_15586_Characteristic = {
    Text = "Phản công cao    khởi động nhảy vọt"
  },
  AwakerConfig_15586_Gender = {Text = "Nữ"},
  AwakerConfig_15586_Introduction = {
    Text = "Sử dụng gai đâm xung quanh để gia tăng phản kích lớn nhằm xuyên thủng kẻ thù, và vung những chiếc gai để gây sát thương."
  },
  AwakerConfig_15586_Name = {Text = "Wanda"},
  AwakerConfig_15586_Painter = {Text = "Bala bala"},
  AwakerConfig_15586_SummonSlogan = {
    Text = "Nô lệ mù mắt thề thốt trang nghiêm, đọc lên những lời luật cao quý: lại gần nàng, phục tùng nàng, và yêu thương nàng mãi mãi."
  },
  AwakerConfig_15586_Title = {Text = "Wanda"},
  AwakerConfig_15586_VoiceActor = {
    Text = "Bản Đa Ma Lệ Tử"
  },
  AwakerConfig_15587_Age = {
    Text = "12 tháng 25"
  },
  AwakerConfig_15587_AwakerIntroduction = {
    Text = "·Bùng nổ có thể nâng cao đáng kể sát thương của \"Đánh\" gây ra trong lượt này. \n·Số lượng \"Đánh\" trong tay càng nhiều, sát thương của \"Đòn phá chuỗi\" càng cao, và lượng <PowerIconKeywords:lực lượng> nhận được càng lớn, kết hợp với bùng nổ có thể gây ra một lượng sát thương lớn trong một lần. \n·Trong cấp độ này, sẽ mang theo Hiro cấp 50, kỹ năng cấp 5, khởi linh 3 ra trận, bắt đầu trận chiến nhận 3 lá\"Đánh\", mỗi lượt nhận 30 <EmbryoFusionIconKeywords:Dung hợp Phôi thai>, 10 điểm điên cuồng, 6 điểm <PowerIconKeywords:lực lượng>, kẻ địch trong lượt đầu tiên sẽ nhận được tăng cường."
  },
  AwakerConfig_15587_Characteristic = {
    Text = "Sát thương đơn đoạn    sự phát triển của lực lượng"
  },
  AwakerConfig_15587_Gender = {Text = "Nữ"},
  AwakerConfig_15587_Introduction = {
    Text = "Liên tục nhẫn nhịn để tiếp tục tăng cường sức mạnh, một đòn kết thúc mang lại lời báo thù cho kẻ thù."
  },
  AwakerConfig_15587_Name = {Text = "Helot"},
  AwakerConfig_15587_Painter = {Text = "Bala bala"},
  AwakerConfig_15587_SummonSlogan = {
    Text = "Điều cô ấy khao khát chưa bao giờ là máu."
  },
  AwakerConfig_15587_Title = {Text = "Helot"},
  AwakerConfig_15587_VoiceActor = {
    Text = "Kunimaru Kuruko"
  },
  AwakerConfig_15588_Age = {
    Text = "1 tháng 20"
  },
  AwakerConfig_15588_AwakerIntroduction = {
    Text = "·Có khả năng phòng thủ mạnh mẽ và gây thương đơn mục tiêu, lá chắn càng cao, \"Tâm Nhãn Lợi Kiếm\" gây thương càng cao. \n·Sau khi Thức tỉnh linh tri, tất cả thương mà Elva gây ra đều sẽ được hưởng lợi từ lá chắn. \n·\"Lâm Chiến Thể Thế\" có khả năng xua tan phong ấn, cơn thịnh nộ bùng phát còn có thể vứt bỏ thẻ triệu chứng hoặc thẻ trạng thái, nhận thêm lượt rút bài. \n·Trong lần thử thách này, sẽ mang theo Elva cấp độ 50, kỹ năng cấp 5, khởi linh 3 để tham chiến, kẻ địch sẽ được tăng cường trong lượt đầu tiên."
  },
  AwakerConfig_15588_Characteristic = {
    Text = "Chống lại Sekka    Cảnh giác cao"
  },
  AwakerConfig_15588_Gender = {Text = "Nữ"},
  AwakerConfig_15588_Introduction = {
    Text = "Chiến binh dày dạn kinh nghiệm trên chiến trường thành thạo trong việc tích lũy nhiều khiên và biến những khiên thành lưỡi kiếm để tấn công."
  },
  AwakerConfig_15588_Name = {Text = "Alva"},
  AwakerConfig_15588_Painter = {Text = "Bala bala"},
  AwakerConfig_15588_SummonSlogan = {
    Text = "Trận chiến đã cướp đi chi thể của cô ấy, nhưng sẽ không bao giờ xóa nhòa linh hồn của cô ấy."
  },
  AwakerConfig_15588_Title = {Text = "Alva"},
  AwakerConfig_15588_VoiceActor = {
    Text = "Nikomi Yukino"
  },
  AwakerConfig_15589_Age = {
    Text = "12 tháng 22"
  },
  AwakerConfig_15589_AwakerIntroduction = {
    Text = "· Là 「Mẹ Thần」 được những người dấn thân vào biển tôn kính, bà đã thiết lập trật tự mới để bảo vệ tất cả thần dân, gia tăng mạnh mẽ hiệu ứng cơ bản của khu vực biển sâu. \n· Định mệnh đảo ngược đã ban cho bà quyền năng tối thượng, có khả năng hiến tế sinh mạng của kẻ thù như một món quà dâng lên thần linh, nhưng quyền lực cấm kỵ thường phải trả một cái giá rất đắt... \n· Trong màn chơi này, sẽ có sự xuất hiện của 「Mộng sinh · Muphí」 và 「Tulô」 với cấp độ 50, cấp kỹ năng 5, và khai linh 3."
  },
  AwakerConfig_15589_Characteristic = {
    Text = "Kích hoạt râu chạm    bổ sung sức tính toán"
  },
  AwakerConfig_15589_Gender = {Text = "Nữ"},
  AwakerConfig_15589_Introduction = {
    Text = "Với tư cách là Mẹ Thần, nàng ban phước và che chở cho thần dân, quyền lực vô thượng có thể biến sinh mạng của kẻ thù thành lễ vật dâng hiến cho thần linh."
  },
  AwakerConfig_15589_Name = {
    Text = "Murphy: Ngụy Sinh"
  },
  AwakerConfig_15589_Painter = {Text = "Bala bala"},
  AwakerConfig_15589_SummonSlogan = {
    Text = "Cô hiến thân cho lễ ra mắt của Thần, bằng xương thịt để hoàn trả ảo vọng vĩnh cửu."
  },
  AwakerConfig_15589_Title = {
    Text = "Murphy: Ngụy Sinh"
  },
  AwakerConfig_15589_VoiceActor = {
    Text = "Noto Mamiko"
  },
  AwakerConfig_15590_Age = {
    Text = "10 tháng 10"
  },
  AwakerConfig_15590_AwakerIntroduction = {
    Text = "·có khả năng gây thương có thể phát triển và khả năng bùng nổ tổ hợp mạnh mẽ\n·Cơn thịnh nộ bùng phát có thể tạo ra thẻ bài hoàn hảo vào bất kỳ thời điểm nào\n·Trong lần thử thách này, sẽ xuất chiến cùng \"Đào Đen Đá\" cấp 50, kỹ năng cấp 5, khởi linh 3, mỗi lượt nhận thêm 10 điểm điên cuồng."
  },
  AwakerConfig_15590_Characteristic = {
    Text = "Vạn năng sáng tạo    tăng sát thương"
  },
  AwakerConfig_15590_Gender = {Text = "Nữ"},
  AwakerConfig_15590_Introduction = {
    Text = "Người phụ nữ phép thuật có thể tùy chỉnh các ảo ảnh ngàn mặt mạnh mẽ và đưa chúng vào không gian siêu chiều."
  },
  AwakerConfig_15590_Name = {Text = "Daffodil"},
  AwakerConfig_15590_Painter = {Text = "Bala bala"},
  AwakerConfig_15590_SummonSlogan = {
    Text = "Cửa hàng nhỏ của cô ấy có mọi thứ, chỉ là —— cẩn thận với những gì cô ấy yêu cầu làm thù lao."
  },
  AwakerConfig_15590_Title = {Text = "Daffodil"},
  AwakerConfig_15590_VoiceActor = {
    Text = "Tiểu Thanh Thuỷ Á Mỹ"
  },
  AwakerConfig_15591_Age = {
    Text = "6 tháng 27"
  },
  AwakerConfig_15591_Characteristic = {
    Text = "Kiểm soát hóa đá    tăng sát thương lên kẻ thù"
  },
  AwakerConfig_15591_Gender = {Text = "Nữ"},
  AwakerConfig_15591_Introduction = {
    Text = "Biến đối thủ thành đá bằng viên mắt kết tinh khiến chúng không thể hành động, và trở nên dễ vỡ."
  },
  AwakerConfig_15591_Name = {Text = "Aigis"},
  AwakerConfig_15591_Painter = {Text = "Bala bala"},
  AwakerConfig_15591_SummonSlogan = {
    Text = "Những mảnh đá bong tróc chính là minh chứng cho việc cô ấy bảo vệ điều quý giá."
  },
  AwakerConfig_15591_Title = {Text = "Aigis"},
  AwakerConfig_15591_VoiceActor = {
    Text = "Yamamoto Ainoh"
  },
  AwakerConfig_15592_Age = {
    Text = "10 tháng 31"
  },
  AwakerConfig_15592_AwakerIntroduction = {
    Text = "·Có khả năng bảo vệ mạnh mẽ và vĩnh viễn sinh ra xúc tu, càng nhiều xúc tu thì khả năng bảo vệ càng mạnh. \n·Bùng nổ có thể gây thương tổn diện rộng, lá chắn có thể nâng cao thương tổn gây ra lần này. \n·Trong cấp độ này, sẽ mang sơn cấp 50, kỹ năng cấp 5, khởi linh 3 ra trận, kẻ địch sẽ nhận được tăng cường trong lượt đầu tiên."
  },
  AwakerConfig_15592_Characteristic = {
    Text = "Bảo vệ liên tục    Sự phát triển của râu chạm"
  },
  AwakerConfig_15592_Gender = {Text = "Nữ"},
  AwakerConfig_15592_Introduction = {
    Text = "Liên tục và ổn định phòng thủ để không bị tấn công sau, nghệ thuật thất lạc sẽ gây sát thương nhiều hơn khi khiên càng cao."
  },
  AwakerConfig_15592_Name = {Text = "Sanga"},
  AwakerConfig_15592_Painter = {Text = "Bala bala"},
  AwakerConfig_15592_SummonSlogan = {
    Text = "Ngoài vẻ dịu dàng và thanh tú, sự sắc nét và tính tấn công cũng là một phần của nghệ thuật."
  },
  AwakerConfig_15592_Title = {Text = "Sanga"},
  AwakerConfig_15592_VoiceActor = {
    Text = "Yama Tsubasa (Otoha Risa)"
  },
  AwakerConfig_15593_Age = {Text = "1 tháng 1"},
  AwakerConfig_15593_AwakerIntroduction = {
    Text = "「Tập hợp chuột」tiêu thụ sức tính toán để tạo ra <DerivativeCardKeywords_12:「đám chuột xông tới」>, tiêu thụ sức tính toán càng nhiều, số lần gây thương càng cao, có thể tích lũy sức tính toán để tạo ra sát thương cực cao trong một lần. \n·Mỗi lần sử dụng 「Brâu ra trận!」đều có thể tăng sát thương cho 「Brâu ra trận!」và <DerivativeCardKeywords_12:「đám chuột xông tới」>. \n·Cơn thịnh nộ bùng phát và Thức tỉnh linh tri có thể tăng tỷ lệ chí mạng và thương harming chí mạng của Jenkin, tiếp tục tăng cường khả năng tấn công của Jenkin. \n·Trong lượt này, sẽ xuất chiến với Jenkin cấp độ 50, kỹ năng cấp 5, khởi linh 3, mỗi lượt sẽ nhận được 1 lá <DerivativeCardKeywords_4:「cảm hứng」>, kẻ địch sẽ nhận được tăng cường trong lượt đầu tiên."
  },
  AwakerConfig_15593_Characteristic = {
    Text = "Thương nhiều lần    bạo kích"
  },
  AwakerConfig_15593_Gender = {Text = "Nữ"},
  AwakerConfig_15593_Introduction = {
    Text = "Có tỷ lệ chí mạng và sát thương chí mạng cao, Nâu và lũ chuột sẽ trở thành sự trợ giúp chính cho anh trong việc chống lại nhiều kẻ thù."
  },
  AwakerConfig_15593_Name = {Text = "Jenkin"},
  AwakerConfig_15593_Painter = {Text = "Bala bala"},
  AwakerConfig_15593_SummonSlogan = {
    Text = "Đừng coi thường chuột, bạn sẽ phải trả giá đắt đó!"
  },
  AwakerConfig_15593_Title = {Text = "Jenkin"},
  AwakerConfig_15594_Age = {
    Text = "11 tháng 11"
  },
  AwakerConfig_15594_AwakerIntroduction = {
    Text = "·Sở hữu khả năng hồi phục sức sống mạnh mẽ và xếp chồng <RetaliateIconKeywords:phản công>, khi đối mặt với kẻ địch gây nhiều đợt sát thương thì thể hiện xuất sắc.\n·Cơn thịnh nộ bùng phát và \"Vảy ngược bảo hộ\" có thể gây thêm nhiều sát thương <RetaliateIconKeywords:phản công>.\n·Trong lần thử thách này, Kẻ khắc sét sẽ tham chiến ở cấp độ 50, kỹ năng cấp 5, khởi linh cấp 3, mỗi lượt sẽ nhận được 10 điểm điên cuồng, kẻ địch sẽ được tăng cường trong lượt đầu tiên."
  },
  AwakerConfig_15594_Characteristic = {
    Text = "Phản công kẻ địch    thương tổn râu chạm"
  },
  AwakerConfig_15594_Gender = {Text = "Nam"},
  AwakerConfig_15594_Introduction = {
    Text = "Mở rộng toàn bộ vảy nhọn, phản công kẻ thù tấn công và hồi phục sức sống cho bản thân bằng sức mạnh huyết mạch."
  },
  AwakerConfig_15594_Name = {Text = "Caecus"},
  AwakerConfig_15594_Painter = {Text = "Bala bala"},
  AwakerConfig_15594_SummonSlogan = {
    Text = "Vết mang, vảy cá… bằng chứng của dòng máu là niềm tin duy nhất còn lại của anh."
  },
  AwakerConfig_15594_Title = {Text = "Caecus"},
  AwakerConfig_15594_VoiceActor = {
    Text = "Hoshino Keigo"
  },
  AwakerConfig_15595_Age = {
    Text = "12 tháng 12"
  },
  AwakerConfig_15595_Characteristic = {
    Text = "Tìm kiếm thẻ bài    nhiều lần thương"
  },
  AwakerConfig_15595_Gender = {Text = "Nữ"},
  AwakerConfig_15595_Introduction = {
    Text = "Cung cấp sự hỗ trợ thẻ bài mà đội của bạn cần nhất, và đâm xuyên đối thủ bằng kiếm thuật nhanh chóng ngày càng gia tăng."
  },
  AwakerConfig_15595_Name = {Text = "Ramona"},
  AwakerConfig_15595_Painter = {Text = "Bala bala"},
  AwakerConfig_15595_SummonSlogan = {
    Text = "Quan sát, cảm nhận, suy nghĩ."
  },
  AwakerConfig_15595_Title = {Text = "Ramona"},
  AwakerConfig_15595_VoiceActor = {
    Text = "Yamamoto Aiko"
  },
  AwakerConfig_15596_Age = {
    Text = "4 tháng 19"
  },
  AwakerConfig_15596_AwakerIntroduction = {
    Text = "·Có khả năng sao chép thẻ bài độc đáo, sức tính toán tiêu thụ của thẻ bài đã sao chép còn giảm. \n·Thức tỉnh linh tri có thể nhận được <DerivativeCardKeywords_10:Con Thánh>, sau khi bị cơn điên cuồng bùng phát của thịt máu tiêu thụ sẽ kích hoạt 2 lần hiệu ứng nuốt chửng, khi phát hành lệnh khóa còn có thể chuyển đổi <DerivativeCardKeywords_2:「Phôi Thai」> thành <DerivativeCardKeywords_10:Con Thánh>. \n·Trong lần thử thách này, sẽ mang theo 「Thái Di Sơ」 và 「Ramona」 ở cấp độ 50, kỹ năng cấp độ 5, khởi linh cấp 3, cùng với thân thể được đánh thức và ước nguyện nhỏ nhỏ ra trận."
  },
  AwakerConfig_15596_Characteristic = {
    Text = "Sao chép thẻ bài    Nguồn cung điên cuồng"
  },
  AwakerConfig_15596_Gender = {Text = "Nữ"},
  AwakerConfig_15596_Introduction = {
    Text = "Nuôi dưỡng con cái của thánh cây khiến hiệu ứng nuốt chửng nhiều lần được phát động, và mô phỏng kỹ năng của đồng đội bằng nghi lễ phong phú."
  },
  AwakerConfig_15596_Name = {Text = "Thais"},
  AwakerConfig_15596_Painter = {Text = "Bala bala"},
  AwakerConfig_15596_SummonSlogan = {
    Text = "\"Trở thành đầy tớ của ta, chiến binh của ta, và... đứa con của ta.\""
  },
  AwakerConfig_15596_Title = {Text = "Thais"},
  AwakerConfig_15596_VoiceActor = {
    Text = "Yamamoto Aiko"
  },
  AwakerConfig_15597_Age = {
    Text = "6 tháng 28"
  },
  AwakerConfig_15597_AwakerIntroduction = {
    Text = "·Cơn thịnh nộ bùng phát có thể hồi phục nhiều sức sống, sức sống càng thấp hồi phục càng nhiều. \n·Sau khi Thức tỉnh linh tri thức, sử dụng thẻ lệnh của bản thân có thể nâng cao <EmbryoFusionIconKeywords:phôi hợp tử>, từ đó nhận được nhiều <DerivativeCardKeywords_2:「phôi thai」> hơn, cung cấp hỗ trợ tài nguyên cho đội hình sinh mệnh. \n·Trong lần thử thách này, sẽ mang theo Reia cấp độ 50, kỹ năng cấp 5, khởi linh 3 để tham chiến."
  },
  AwakerConfig_15597_Characteristic = {
    Text = "Hồi phục sức sống    tăng cường lực lượng"
  },
  AwakerConfig_15597_Gender = {Text = "Nữ"},
  AwakerConfig_15597_Introduction = {
    Text = "Chuyển hóa nỗi đau của bản thân thành sức mạnh, có thể hồi phục nhiều khi sức sống thấp."
  },
  AwakerConfig_15597_Name = {Text = "Leigh"},
  AwakerConfig_15597_Painter = {Text = "Bala bala"},
  AwakerConfig_15597_SummonSlogan = {
    Text = "\"nhấm nháp đi, cái chết ngọt ngào này.\""
  },
  AwakerConfig_15597_Title = {Text = "Leigh"},
  AwakerConfig_15597_VoiceActor = {
    Text = "Kosaka Honoka"
  },
  AwakerConfig_15598_Age = {Text = "4 tháng 4"},
  AwakerConfig_15598_AwakerIntroduction = {
    Text = "·Bùng nổ có thể gây ra sát thương lớn cho cả nhóm, đồng thời nhận được gia tăng lớn từ <PowerIconKeywords:lực lượng>.\n·Khi bùng nổ kích hoạt <DevouredIconKeywords:tiêu thụ>, sát thương bùng nổ trong trận chiến này và gia tăng <PowerIconKeywords:lực lượng> sẽ được nâng cao.\n·Sinh lực càng thấp, sát thương càng cao.\n·Trong cấp độ này, sẽ sử dụng Yu U Hahi cấp 50, kỹ năng cấp 5, khởi linh 3, mỗi lượt nhận được 30 <EmbryoFusionIconKeywords:Dung hợp Phôi thai>, kẻ địch trong hai lượt đầu sẽ nhận được tăng cường."
  },
  AwakerConfig_15598_Characteristic = {
    Text = "Cơn thịnh nộ bùng phát    càng đánh càng hăng"
  },
  AwakerConfig_15598_Gender = {Text = "Nam"},
  AwakerConfig_15598_Introduction = {
    Text = "Chiến binh điên cuồng không ngừng chiến đấu và trở nên mạnh mẽ hơn, sẽ càng mạnh hơn khi ở trạng thái sức sống thấp."
  },
  AwakerConfig_15598_Name = {Text = "Uvhash"},
  AwakerConfig_15598_Painter = {Text = "Bala bala"},
  AwakerConfig_15598_SummonSlogan = {
    Text = "Anh ta không bỏ lỡ bất kỳ cơ hội nào để đánh bại kẻ thù."
  },
  AwakerConfig_15598_Title = {Text = "Uvhash"},
  AwakerConfig_15598_VoiceActor = {
    Text = "Morita Eion"
  },
  AwakerConfig_15599_Age = {
    Text = "5 tháng 30"
  },
  AwakerConfig_15599_AwakerIntroduction = {
    Text = "·Sở hữu khả năng tích lũy lò nung đỏ thẫm độc đáo, có thể tích lũy lượng hồi phục lò nung đỏ thẫm từ thẻ lệnh, sinh lực, thậm chí là sát thương từ kẻ thù. \n·Có thể linh hoạt chuyển đổi lượng hồi phục lò nung đỏ thẫm thành lá chắn hoặc sát thương lớn. \n·Trong cấp độ này, sẽ mang theo Salvador cấp 50, kỹ năng cấp 5, khởi linh 3 chiến đấu, ban đầu sở hữu 50% tỉ lệ chí mạng, mỗi lượt sẽ nhận được 20 điểm điên cuồng, nhưng kẻ thù trong hai lượt đầu sẽ nhận được 150 điểm sức mạnh tạm thời."
  },
  AwakerConfig_15599_Characteristic = {
    Text = "Hỗ trợ sức tính toán chuyển lá chắn thành sát thương"
  },
  AwakerConfig_15599_Gender = {Text = "Nam"},
  AwakerConfig_15599_Introduction = {
    Text = "Tình yêu vô tận có thể tích lũy Lò nung đỏ thẫm, cung cấp hỗ trợ khẩn cấp khi bị thương."
  },
  AwakerConfig_15599_Name = {Text = "Salvador"},
  AwakerConfig_15599_Painter = {Text = "Bala bala"},
  AwakerConfig_15599_SummonSlogan = {
    Text = "\"Hãy dẫn đường cho chúng ta, vị cứu thế trong thần dụ, đưa chúng ta đến tương lai không đau khổ.\""
  },
  AwakerConfig_15599_Title = {Text = "Salvador"},
  AwakerConfig_15599_VoiceActor = {
    Text = "Nan Đại Điển"
  },
  AwakerConfig_15600_Age = {
    Text = "4 tháng 15"
  },
  AwakerConfig_15600_AwakerIntroduction = {
    Text = "·Sở hữu khả năng phòng ngự mạnh mẽ và khả năng gây <IntoxicationIconKeywords:Ngộ độc>, kích hoạt tiêu thụ có thể nhận được khả năng tăng trưởng công thủ vĩnh viễn. \n·\"Sự bố thí không kiên nhẫn\" có khả năng làm gấp đôi <EmbryoFusionIconKeywords:Dung hợp Phôi thai> hiện tại. \n·Khi kích hoạt tiêu thụ, \"Luồng xoáy nhợt nhạt\" còn có thể trở lại tay từ rác bài, mỗi lượt có thể được chơi nhiều lần. \n·Trong màn chơi này, sẽ mang theo Agrippa cấp 50, kỹ năng cấp 5, khởi linh 3 ra trận, mỗi lượt nhận 30 <EmbryoFusionIconKeywords:Dung hợp Phôi thai>, 10 điểm điên cuồng."
  },
  AwakerConfig_15600_Characteristic = {
    Text = "Giữ mình tăng trưởng    liên kích độc"
  },
  AwakerConfig_15600_Gender = {Text = "Nữ"},
  AwakerConfig_15600_Gi = {Text = "?"},
  AwakerConfig_15600_Introduction = {
    Text = "Cung cấp nhiều hợp nhất phôi thai và đồng thời tiêm chất độc vào kẻ thù để phá hoại ý chí của chúng."
  },
  AwakerConfig_15600_Name = {Text = "Agrippa"},
  AwakerConfig_15600_Painter = {Text = "Bala bala"},
  AwakerConfig_15600_SummonSlogan = {
    Text = "Trong mê cung mà cô ấy dựng nên, điều bị đánh mất không chỉ là phương hướng."
  },
  AwakerConfig_15600_Title = {Text = "Agrippa"},
  AwakerConfig_15600_VoiceActor = {
    Text = "Ishikawa Asuna"
  },
  AwakerConfig_15601_Age = {
    Text = "7 tháng 19"
  },
  AwakerConfig_15601_AwakerIntroduction = {
    Text = "·Có hai tư thế là u uất và điên cuồng, tư thế ban đầu là u uất, khi phát động cơn thịnh nộ bùng phát sẽ chuyển đổi tư thế, hiệu ứng thẻ bài trong các tư thế khác nhau sẽ khác nhau. \n·Cơn thịnh nộ bùng phát và Thức tỉnh linh tri trong các giới vực khác nhau đều có hiệu ứng độc đáo, cơn thịnh nộ bùng phát còn kích hoạt hiệu ứng khác nhau dựa trên tư thế u uất và điên cuồng. \n·Trong lần thử thách này, sẽ mang theo \"24\" cấp độ 50, kỹ năng cấp 5, khởi linh 3 và đồng đội từ các giới vực khác nhau ra trận."
  },
  AwakerConfig_15601_Characteristic = {
    Text = "Đơn đoạn sát thương cao    cơn điên cuồng bùng phát tăng cường"
  },
  AwakerConfig_15601_Gender = {Text = "Nữ"},
  AwakerConfig_15601_Introduction = {
    Text = "Đội hình thích ứng với các cõi khác nhau bằng hình thức khác nhau, thợ săn liên tục chuyển đổi giữa nhân cách \"Trầm cảm\" và\"Hưng cảm\"."
  },
  AwakerConfig_15601_Name = {Text = "24"},
  AwakerConfig_15601_Painter = {Text = "Bala bala"},
  AwakerConfig_15601_SummonSlogan = {
    Text = "Hysteria, chứng điên dại, suy nhược thần kinh, động kinh… Nói chung, đó là một người phụ nữ mất trí."
  },
  AwakerConfig_15601_Title = {Text = "24"},
  AwakerConfig_15601_VoiceActor = {
    Text = "Yoshiko Satsuki"
  },
  AwakerConfig_15601_Weight = {Text = "?"},
  AwakerConfig_15602_Age = {Text = "1 tháng 1"},
  AwakerConfig_15602_AwakerIntroduction = {
    Text = "·Bình thường là một nhà nghiên cứu cung cấp khả năng hỗ trợ đáng tin cậy, có thể cung cấp lượng lớn điên cuồng, vừa tăng cường đồng đội vừa làm suy yếu kẻ địch. \n·Trong trận chiến thủ lĩnh, cô ấy sẽ dần kích hoạt động cơ hủy diệt, tích lũy \"Chung Cực\" rồi giải phóng \"Hư Vô Chung Cực\", gây ra lượng sát thương lớn và trở nên cực kỳ tấn công cho đến khi chiến đấu kết thúc. \n·Trong nhiệm vụ lần này, Melt·Đóa và Ninh Phi Nga sẽ xuất chiến ở cấp độ 50, kỹ năng cấp 5, khởi linh cấp 3. Ngay khi bắt đầu lượt, Melt·Đóa nhận thêm 50 điểm điên cuồng và 1 tầng \"Chung Cực\"."
  },
  AwakerConfig_15602_Characteristic = {
    Text = "Sức sống phục hồi    sát thương cao một lượt"
  },
  AwakerConfig_15602_Gender = {Text = "Nữ"},
  AwakerConfig_15602_Introduction = {
    Text = "Trong thời gian bình thường có thể cung cấp hồi phục và lượng điên cuồng lớn cho đội, nhưng trong trận chiến với lãnh chúa sẽ kích hoạt động cơ hủy diệt để chấm dứt kẻ thù."
  },
  AwakerConfig_15602_Name = {
    Text = "Doll: Tận Thế"
  },
  AwakerConfig_15602_Painter = {Text = "Bala bala"},
  AwakerConfig_15602_SummonSlogan = {
    Text = "Hy vọng chỉ là thứ thuốc độc khiến người ta đau khổ hơn. Chỉ trong sự hủy diệt hoàn toàn và nhanh chóng, mọi người mới có thể tìm được sự giải thoát hoàn toàn."
  },
  AwakerConfig_15602_Title = {
    Text = "Doll: Tận Thế"
  },
  AwakerConfig_15602_VoiceActor = {
    Text = "Ngư Cốc Gia Đại"
  },
  AwakerConfig_15603_Age = {
    Text = "9 tháng 29"
  },
  AwakerConfig_15603_Characteristic = {
    Text = "Vừa công vừa thủ    chuyển đổi hình thái"
  },
  AwakerConfig_15603_Gender = {Text = "Nữ"},
  AwakerConfig_15603_Gi = {
    Text = "không biết"
  },
  AwakerConfig_15603_Introduction = {
    Text = "Có thể tạm thời cung cấp sức mạnh bùng nổ hoặc cảnh giác, cho dù là tấn công hay phòng thủ đều là tay nghề tốt."
  },
  AwakerConfig_15603_Name = {Text = "Erica"},
  AwakerConfig_15603_Painter = {Text = "Bala bala"},
  AwakerConfig_15603_SummonSlogan = {
    Text = "Cô ấy là cơ sở dữ liệu lớn nhất của Misaque, là máy tìm kiếm toàn năng."
  },
  AwakerConfig_15603_Title = {Text = "Erica"},
  AwakerConfig_15603_VoiceActor = {Text = "Miura Cô"},
  AwakerConfig_15604_Age = {Text = "6 tháng 6"},
  AwakerConfig_15604_AwakerIntroduction = {
    Text = "·Cơn thịnh nộ bùng phát và kỹ năng đều có tính ngẫu nhiên, càng may mắn, lợi ích càng lớn. \n·Thức tỉnh linh tri có thể nhận hoặc chọn nâng cấp \"Di sản của Hỗn Loạn\". \n·Trong lần thử thách này, sẽ mang theo Lắc và Lơ-tan với cấp độ 50, kỹ năng cấp 5, khởi linh 3, ban đầu Lắc có 25% tỷ lệ chí mạng tăng cường, tất cả các sáng tạo \"Di sản của Hỗn Loạn\" và một bộ thẻ bài thêm, kẻ địch nhận tăng cường tạm thời ở lượt đầu."
  },
  AwakerConfig_15604_Characteristic = {
    Text = "Bổ sung bài trên tay    nhận được dấu đen"
  },
  AwakerConfig_15604_Gender = {Text = "Nam"},
  AwakerConfig_15604_Gi = {Text = "?"},
  AwakerConfig_15604_Height = {Text = "?"},
  AwakerConfig_15604_Introduction = {
    Text = "Rút nhiều thẻ trong khi thu thập Ấn ký đen để giành được di vật hỗn loạn, làm cho Ryker trở nên mạnh mẽ hơn."
  },
  AwakerConfig_15604_Name = {Text = "Ryker"},
  AwakerConfig_15604_Painter = {Text = "Bala bala"},
  AwakerConfig_15604_SummonSlogan = {
    Text = "\"Hãy cược thêm một lần cuối cùng? Lần này, cùng đặt cược vào tương lai của cả hai nhé.\""
  },
  AwakerConfig_15604_Title = {Text = "Ryker"},
  AwakerConfig_54116_Age = {
    Text = "12 tháng 31"
  },
  AwakerConfig_54116_AwakerIntroduction = {
    Text = "·Nhà thông thái toàn tri, sở hữu trí tuệ vô tận, thành thạo nắm vững mọi kỹ năng, tìm kiếm con đường tốt nhất trong vô số khả năng. \n·Có thể cung cấp cho đội một lượng lớn năng lượng chìa khóa bạc, cũng có thể chuyển đổi năng lượng chìa khóa bạc thành đòn đánh cánh để tấn công kẻ thù. \n·Trong cấp độ này, sẽ mang theo Tà Vy và lơ-tan với cấp độ 50, cấp kỹ năng 5, khởi linh 3, khi bắt đầu chiến đấu nhận được 100 điểm điên cuồng, sạc năng lượng chìa khóa bạc tăng 50%."
  },
  AwakerConfig_54116_Gender = {Text = "Nữ"},
  AwakerConfig_54116_Gi = {
    Text = "Không thể đo lường"
  },
  AwakerConfig_54116_Introduction = {
    Text = "Tawil am hiểu tất cả, có thể sử dụng mọi kỹ năng phục vụ cho mình, và dùng chìa khóa làm tài nguyên để tấn công."
  },
  AwakerConfig_54116_Name = {Text = "Tawil"},
  AwakerConfig_54116_Painter = {Text = "Bala bala"},
  AwakerConfig_54116_SummonSlogan = {
    Text = "Đi qua cánh cửa cực hạn, bí mật cuối cùng của thế giới sẽ hé lộ với bạn."
  },
  AwakerConfig_54116_Title = {Text = "Tawil"},
  AwakerConfig_54116_VoiceActor = {
    Text = "Yamamoto Aiko"
  },
  AwakerConfig_54116_Weight = {
    Text = "không biết"
  },
  AwakerConfig_54117_Age = {
    Text = "9 tháng 21"
  },
  AwakerConfig_54117_AwakerIntroduction = {
    Text = "·Điều khiển nốt nhạc một cách duyên dáng và linh hoạt, vừa có thể giảm giá trị điểm tính toán của thẻ bài, vừa có thể kích hoạt hiệu ứng nhiều lần. \n·Cuộc tấn công bằng sóng âm rung động tâm hồn có thể gây sát thương xuyên thấu liên tục cho kẻ thù, đồng thời làm suy yếu ý chí chiến đấu của chúng, đập tan phòng thủ của kẻ thù. \n·Trong màn chơi này, sẽ xuất trận Hamlin cấp 50, kỹ năng cấp 5, khởi linh 3, mỗi lượt nhận thêm 35 điên cuồng."
  },
  AwakerConfig_54117_Gender = {Text = "Nam"},
  AwakerConfig_54117_Introduction = {
    Text = "Gây sát thương bằng giai điệu luân hồi và để thẻ hoạt động nhiều lần, âm thanh liên tục còn có thể tạo ra nhiều \"Cảm hứng\"."
  },
  AwakerConfig_54117_Name = {Text = "Hameln"},
  AwakerConfig_54117_Painter = {Text = "Bala bala"},
  AwakerConfig_54117_SummonSlogan = {
    Text = "Tất cả các nốt nhạc, đều sẽ theo quỹ đạo của cây chỉ huy mà nhảy múa."
  },
  AwakerConfig_54117_Title = {Text = "Hameln"},
  AwakerConfig_54117_VoiceActor = {
    Text = "Dã Cung Nhất Phạm"
  },
  AwakerConfig_77911_Age = {Text = "?"},
  AwakerConfig_77911_Gender = {Text = "Nữ"},
  AwakerConfig_77911_Gi = {Text = "?"},
  AwakerConfig_77911_Height = {Text = "?"},
  AwakerConfig_77911_Name = {
    Text = "Kền kền"
  },
  AwakerConfig_77911_Painter = {Text = "Bala bala"},
  AwakerConfig_77911_Title = {
    Text = "Kền kền"
  },
  AwakerConfig_77911_Weight = {Text = "?"},
  AwakerConfig_77913_Age = {
    Text = "Ngày 30 tháng 8"
  },
  AwakerConfig_77913_AwakerIntroduction = {
    Text = "· Chủ nhân của sự bùng cháy mạnh mẽ, thiêu hủy mọi kẻ thù cố gắng ngăn cản cô ấy với ngọn lửa sống khắp trời.\n· Ngọn lửa sống còn lại biến thành bùng cháy tích tụ liên tục, bùng phát năng lượng không thể ức chế sẽ nổ tung ngay khi đạt ngưỡng!\n· Trong cấp độ này, sẽ mang theo Caligula cấp độ 50, kỹ năng cấp độ 5 và khai ngộ 3 xuất trận, mỗi lượt nhận được thêm 5 điểm số học, 30 điểm Aliemus, 50 điểm sức mạnh."
  },
  AwakerConfig_77913_Gender = {Text = "Nữ"},
  AwakerConfig_77913_Introduction = {
    Text = "Lấy ngọn lửa nhiệt huyết thiêu đốt mọi thứ, tiêu hao nhiều số học hơn có thể nâng cao đáng kể hiệu ứng thẻ."
  },
  AwakerConfig_77913_Name = {Text = "Kathigu-ra"},
  AwakerConfig_77913_Painter = {Text = "Bala bala"},
  AwakerConfig_77913_SummonSlogan = {
    Text = "Cô ấy là mặt trời không bao giờ lặn, sẽ mang đến cái chết bình đẳng."
  },
  AwakerConfig_77913_Title = {Text = "Kathigu-ra"},
  AwakerConfig_77913_VoiceActor = {
    Text = "Lông chim ưu hảo"
  },
  AwakerConfig_77914_Age = {Text = "?"},
  AwakerConfig_77914_Gender = {Text = "Nữ"},
  AwakerConfig_77914_Gi = {Text = "?"},
  AwakerConfig_77914_Height = {Text = "?"},
  AwakerConfig_77914_Name = {Text = "Lantigos"},
  AwakerConfig_77914_Painter = {Text = "Bala bala"},
  AwakerConfig_77914_Title = {Text = "Lantigos"},
  AwakerConfig_77914_Weight = {Text = "?"},
  AwakerConfig_77917_Age = {
    Text = "Ngày 20 tháng 6"
  },
  AwakerConfig_77917_AwakerIntroduction = {
    Text = "· Người thánh tử đèn thắp sáng, trái tim thánh khiết luôn theo đuổi ánh sáng.\n· Sử dụng sức mạnh thánh quang để tăng cường hiệu ứng thẻ một cách có chu kỳ, sử dụng quyền năng của thánh tử để phán quyết mọi tội ác đen tối.\n· Trong cấp độ này, sẽ xuất binh Polux ở cấp 50, cấp kỹ năng 5, Khai ngộ 3, mỗi lượt nhận 50 điên loạn và 1 thẻ\"Cảm hứng\"."
  },
  AwakerConfig_77917_Gender = {Text = "Nam"},
  AwakerConfig_77917_Introduction = {
    Text = "Sử dụng sức mạnh Thánh Huy để tăng cường hiệu quả thẻ bài theo chu kỳ, vận dụng quyền năng của Thánh Tử để phán xét mọi tội ác đen tối."
  },
  AwakerConfig_77917_Name = {Text = "Pollux"},
  AwakerConfig_77917_Painter = {Text = "Bala bala"},
  AwakerConfig_77917_SummonSlogan = {
    Text = "Dưới ánh sáng của Thánh Tâm, không có tội nhân nào có thể thoát khỏi phán quyết của Thánh Tử."
  },
  AwakerConfig_77917_Title = {Text = "Pollux"},
  AwakerConfig_77917_VoiceActor = {
    Text = "Phùng Triều Quang Minh"
  },
  AwakerConfig_77918_Age = {
    Text = "24 tháng 5"
  },
  AwakerConfig_77918_AwakerIntroduction = {
    Text = "·Người dệt bị trói buộc bởi số phận, không ngừng dệt khiến nàng trở nên mạnh mẽ hơn, nhưng cũng phải gánh chịu cái giá lớn hơn.\n·Thông qua việc dệt giăng lưới mang tên \"Số Phận\" để bảo vệ đồng đội và ban cho họ sức mạnh lăng kính, \"Tài Đoạn\" tích lũy sẽ siết chặt đột ngột vào thời khắc then chốt để trừ khử ô uế.\n·Trong màn chơi này, sẽ mang theo Arachne và Nymphia cấp 50, cấp kỹ năng 5, Khai Linh 3 ra trận.\n·Trong trận đấu này, hiệu ứng trúng độc do tất cả Giác Tỉnh Thể gây ra tăng 200%. Đầu lượt, tất cả Giác Tỉnh Thể nhận 30 Cuồng Khí, nhận 1 tầng \"Chức Mệnh\", nhận 3 điểm Toán Lực và rút 3 lá bài."
  },
  AwakerConfig_77918_Gender = {Text = "Nữ"},
  AwakerConfig_77918_Introduction = {
    Text = "Người dệt số phận, nàng dùng tơ dệt nên định mệnh để gìn giữ sự an yên dưới guồng xe, lấy sức mạnh cắt đứt để trừ khử ô uế."
  },
  AwakerConfig_77918_Name = {Text = "Arachne"},
  AwakerConfig_77918_Painter = {Text = "Bala bala"},
  AwakerConfig_77918_SummonSlogan = {
    Text = "Vạn ngàn sợi tơ hội tụ trên guồng xe của Arachne. Nàng dệt nên số phận đã định cho những con rối, và dệt nên chiếc lồng vĩnh hằng cho chính mình."
  },
  AwakerConfig_77918_Title = {Text = "Arachne"},
  AwakerConfig_77918_VoiceActor = {
    Text = "Oonishi Saori"
  },
  AwakerConfig_77921_Age = {
    Text = "27 tháng 4"
  },
  AwakerConfig_77921_AwakerIntroduction = {
    Text = "·Cô gái nhỏ nhắn tự xưng là \"Bà Tiên Đỡ Đầu\", luôn có thể nhìn thấu những ước nguyện sâu kín của người khác, vì vậy được đông đảo tín đồ thành tâm dâng Lễ Vật.\n·Cô quen dùng \"Phép Màu\" để đổi lấy Lễ Vật của tín đồ, khi Lễ Vật tích lũy đủ nhiều, sẽ thụ hưởng tất cả, biến chúng thành sức mạnh nuôi dưỡng bản thân. Ban ân huệ và thu lấy, vốn dĩ là hai mặt của một thể trong cô.\n·Trong màn chơi lần này, sẽ mang Caraboo cấp độ 50, cấp kỹ năng 5, khởi linh 3 ra chiến đấu, khi trận chiến bắt đầu nhận được 300 điểm sức mạnh. Khi bắt đầu lượt, đặt 1 lá \"Phôi thai\" vào tay, tất cả Thể thức tỉnh nhận được 20 điên cuồng."
  },
  AwakerConfig_77921_Gender = {Text = "Nữ"},
  AwakerConfig_77921_Introduction = {
    Text = "Món quà từ nàng tiên từ lâu đã được định giá trong bóng tối, thân xác nhợt nhạt nuốt chửng vô số oan hồn tham lam."
  },
  AwakerConfig_77921_Name = {Text = "Caraboo"},
  AwakerConfig_77921_Painter = {Text = "Bala bala"},
  AwakerConfig_77921_SummonSlogan = {
    Text = "Tiên nữ ban phước, hoan nghênh cúng dường! Vị ân nhân này, muốn chọn mức giá nào?"
  },
  AwakerConfig_77921_Title = {Text = "Caraboo"},
  AwakerConfig_77922_Age = {
    Text = "Ngày 3 tháng 10"
  },
  AwakerConfig_77922_AwakerIntroduction = {
    Text = "· Cô gái dũng cảm, không sợ cái chết, có thể bùng phát tiềm năng vô hạn khi đối mặt với đe dọa cái chết.\n· Người dẫn đường tàu, ánh sáng lạnh trong bầu trời đêm, có thể tái thiết thẻ bài cùng lúc với việc tạo ra một lượng lớn xúc tu, kết hợp với hiệu ứng \"Dư âm\" để chỉ dẫn đường chiến thắng cho bạn.\n· Trong màn chơi này, sẽ mang theo Kepersant cấp độ 50, kỹ năng cấp 5, khai ngộ 3 tham chiến, mỗi hiệp thêm 2 thẻ, nhận 1 xúc tu."
  },
  AwakerConfig_77922_Gender = {Text = "Nữ"},
  AwakerConfig_77922_Introduction = {
    Text = "Ánh sáng lạnh lẽo trên bầu trời đêm, có thể tạo ra lượng lớn xúc tu trong khi tái cấu trúc bộ bài, kết hợp với hiệu ứng \"Dư chấn\" phát huy tiềm năng lớn hơn."
  },
  AwakerConfig_77922_Name = {Text = "Corposant"},
  AwakerConfig_77922_Painter = {Text = "Bala bala"},
  AwakerConfig_77922_SummonSlogan = {
    Text = "Trách nhiệm của cô ấy, bổn phận của cô ấy, sinh mạng của cô ấy đều gắn liền với con tàu, ngoài ra, không còn gì khác."
  },
  AwakerConfig_77922_Title = {Text = "Corposant"},
  AwakerConfig_77923_Age = {
    Text = "Ngày 20 tháng 6"
  },
  AwakerConfig_77923_AwakerIntroduction = {
    Text = "· Chim cô đơn kiên cường, cánh vỗ tạo gió mạnh bảo vệ phe ta.\n· Cánh đen rơi rải có thể gây ra \"Phân hủy\" chí mạng, khiến trong vòng này chịu thêm sát thương lớn.\n· Trong cấp độ này, sẽ mang Castor và Jenkin cấp 50, cấp kỹ năng 5, Khai ngộ 3 ra trận. Khi bắt đầu trận chiến nhận được 100 điểm Aliemus, mỗi vòng nhận được 30 điểm Aliemus."
  },
  AwakerConfig_77923_Gender = {Text = "Nam"},
  AwakerConfig_77923_Height = {
    Text = "6'0.3''（sải cánh 9'9.8''）"
  },
  AwakerConfig_77923_Introduction = {
    Text = "Vỗ cánh tạo gió bảo vệ đồng minh, những chiếc lông vũ đen rơi xuống có thể tạo ra \"ăn mòn\" chí mạng khi chịu sát thương sẽ mất đi đáng kể cuộc sống."
  },
  AwakerConfig_77923_Name = {Text = "Castor"},
  AwakerConfig_77923_Painter = {Text = "Bala bala"},
  AwakerConfig_77923_SummonSlogan = {
    Text = "Anh ta là một con chim bay không khuất phục, nếu không có tự do thà chết còn hơn."
  },
  AwakerConfig_77923_Title = {Text = "Castor"},
  AwakerConfig_77923_VoiceActor = {
    Text = "Kato Shinya"
  },
  AwakerConfig_77923_Weight = {Text = "205 pound"},
  AwakerConfig_77924_Age = {Text = "?"},
  AwakerConfig_77924_Gender = {Text = "Nữ"},
  AwakerConfig_77924_Gi = {Text = "?"},
  AwakerConfig_77924_Height = {Text = "?"},
  AwakerConfig_77924_Name = {
    Text = "Chim Shatak"
  },
  AwakerConfig_77924_Painter = {Text = "Bala bala"},
  AwakerConfig_77924_Title = {
    Text = "Chim Shatak"
  },
  AwakerConfig_77924_Weight = {Text = "?"},
  AwakerConfig_77925_Age = {
    Text = "16 tháng 8"
  },
  AwakerConfig_77925_AwakerIntroduction = {
    Text = "·Bác sĩ tâm lý nhẹ nhàng và thanh lịch, trong quá trình giao tiếp với bệnh nhân, có thể dần dần cảm nhận sự tích lũy cảm thông của đối phương. Sau khi phát động bùng nổ điên cuồng, có thể tiêu thụ cảm thông để điều khiển trạng thái tinh thần của họ, áp đặt nỗi sợ hãi để làm suy yếu ý chí chiến đấu của kẻ thù, hoặc cấy ghép thương tổn để ngay lập tức phá hủy phòng thủ tâm lý của họ. \n·Trong cấp độ này, sẽ mang theo Clementine cấp 50, cấp kỹ năng 5, khởi linh 3, năng lượng chìa khóa bạc tăng 50, mỗi vòng nhận được 20 điểm điên cuồng."
  },
  AwakerConfig_77925_Gender = {Text = "Nữ"},
  AwakerConfig_77925_Introduction = {
    Text = "Tích lũy sự đồng cảm, thôi miên kẻ thù làm giảm sát thương của chúng, hoặc làm tổn thương kẻ thù khiến chúng bị thương tăng lên."
  },
  AwakerConfig_77925_Name = {Text = "Clementine"},
  AwakerConfig_77925_Painter = {Text = "Bala bala"},
  AwakerConfig_77925_SummonSlogan = {
    Text = "Cô ấy kiểm soát nhịp điệu của tâm lý tư vấn, cứu rỗi hay hủy diệt, đều trong một ý niệm của cô ấy."
  },
  AwakerConfig_77925_Title = {Text = "Clementine"},
  AwakerConfig_77925_VoiceActor = {
    Text = "Kunimaru Kuruko"
  },
  AwakerConfig_77926_Age = {
    Text = "2 tháng 17"
  },
  AwakerConfig_77926_AwakerIntroduction = {
    Text = "·Tàn tích sáng tạo của người họa sĩ đam mê sáng tạo, tác phẩm của anh ấy có thể mang lại các linh tính tăng cường cho đội ngũ bên mình.\n·Vẽ nét trong khi liên tục tích lũy sáng tạo, khi tích đủ tối đa sáng tạo, nó sẽ phát ra như suối trào, đẩy bữa tiệc nghệ thuật này đến cực điểm điên loạn!\n·Trong lần thử thách này, bạn sẽ mang Pikeman, Lotan, Ogier, và Búp bê cấp độ 50 và mức kỹ năng 5 chiến đấu, Pikeman nhận thêm 100 điểm Aliemus mỗi lượt, các Người đánh thức khác nhận 30 điểm Aliemus."
  },
  AwakerConfig_77926_Gender = {Text = "Nam"},
  AwakerConfig_77926_Introduction = {
    Text = "Sáng tạo các cuộn tranh khác nhau một cách linh hoạt theo tình hình, tăng cường đáng kể hiệu ứng bùng nổ điên loạn của các thể thức tỉnh khác."
  },
  AwakerConfig_77926_Name = {Text = "Pickman"},
  AwakerConfig_77926_Painter = {Text = "Bala bala"},
  AwakerConfig_77926_SummonSlogan = {
    Text = "Ngài sẽ dùng tác phẩm của Ngài, đưa bạn cùng chứng kiến sự thật của thế giới."
  },
  AwakerConfig_77926_Title = {Text = "Pickman"},
  AwakerConfig_77926_VoiceActor = {
    Text = "Nhã Điền Trác Kiến"
  },
  AwakerConfig_77927_Age = {Text = "?"},
  AwakerConfig_77927_Gender = {Text = "Nam"},
  AwakerConfig_77927_Gi = {Text = "?"},
  AwakerConfig_77927_Height = {Text = "?"},
  AwakerConfig_77927_Name = {
    Text = "Pharaon Đen"
  },
  AwakerConfig_77927_Painter = {Text = "Bala bala"},
  AwakerConfig_77927_Title = {
    Text = "Pharaon Đen"
  },
  AwakerConfig_77927_Weight = {Text = "?"},
  AwakerConfig_77928_Age = {Text = "?"},
  AwakerConfig_77928_Gender = {Text = "Nữ"},
  AwakerConfig_77928_Gi = {Text = "?"},
  AwakerConfig_77928_Height = {Text = "?"},
  AwakerConfig_77928_Name = {Text = "Afrugomon"},
  AwakerConfig_77928_Painter = {Text = "Bala bala"},
  AwakerConfig_77928_Title = {Text = "Afrugomon"},
  AwakerConfig_77928_Weight = {Text = "?"},
  AwakerConfig_78754_Age = {Text = "?"},
  AwakerConfig_78754_Gender = {Text = "Nữ"},
  AwakerConfig_78754_Gi = {Text = "?"},
  AwakerConfig_78754_Height = {Text = "?"},
  AwakerConfig_78754_Name = {
    Text = "Chúa Tịch Giấc của Nguồn Gốc"
  },
  AwakerConfig_78754_Painter = {Text = "Bala bala"},
  AwakerConfig_78754_Title = {
    Text = "Chúa Tịch Giấc của Nguồn Gốc"
  },
  AwakerConfig_78754_Weight = {Text = "?"},
  AwakerConfig_78840_Age = {Text = "?"},
  AwakerConfig_78840_Characteristic = {
    Text = "Tìm kiếm thẻ bài    nhiều lần thương"
  },
  AwakerConfig_78840_Gender = {Text = "Nam"},
  AwakerConfig_78840_Gi = {Text = "?"},
  AwakerConfig_78840_Height = {Text = "?"},
  AwakerConfig_78840_Name = {
    Text = "con mèo đen quen thuộc"
  },
  AwakerConfig_78840_Painter = {Text = "Bala bala"},
  AwakerConfig_78840_Title = {
    Text = "Mèo trường Misaque"
  },
  AwakerConfig_78840_VoiceActor = {
    Text = "Yamamoto Aiko"
  },
  AwakerConfig_78840_Weight = {Text = "?"},
  AwakerConfig_78841_Age = {Text = "?"},
  AwakerConfig_78841_Characteristic = {
    Text = "Tìm kiếm thẻ bài    nhiều lần thương"
  },
  AwakerConfig_78841_Gender = {Text = "Nam"},
  AwakerConfig_78841_Gi = {Text = "?"},
  AwakerConfig_78841_Height = {Text = "?"},
  AwakerConfig_78841_Name = {
    Text = "con mèo đen quen thuộc"
  },
  AwakerConfig_78841_Painter = {Text = "Bala bala"},
  AwakerConfig_78841_Title = {
    Text = "Mèo trường Misaque"
  },
  AwakerConfig_78841_VoiceActor = {
    Text = "Yamamoto Aiko"
  },
  AwakerConfig_78841_Weight = {Text = "?"},
  AwakerConfig_94450_Age = {
    Text = "28 tháng 11"
  },
  AwakerConfig_94450_AwakerIntroduction = {
    Text = "·Cô gái vui tươi cầm chiến đao, trong trận chiến sẽ biến thành chiến binh cuồng nhiệt và có thể bùng nổ sức chiến đấu mạnh mẽ hơn trong nghịch cảnh. \n · Khi hợp tác chiến đấu với đồng đội, có thể kích thích mạnh mẽ ý chí chiến đấu của Mouchette, sức tấn công của cô sẽ càng trở nên mãnh liệt hơn với việc sử dụng đánh. \n · Trong màn chơi này, sẽ mang theo Mouchette cấp 50, cấp độ kỹ năng 5, khởi linh 3 ra trận, vào đầu lượt nhận 50 điểm điên cuồng, rút 3 thẻ bài, nhận 3 điểm tính toán."
  },
  AwakerConfig_94450_Gender = {Text = "Nữ"},
  AwakerConfig_94450_Gi = {
    Text = "Không ổn định"
  },
  AwakerConfig_94450_Introduction = {
    Text = "Cô gái vui tươi cầm rìu khổng lồ, trong trận chiến sẽ biến thành chiến binh cuồng nhiệt và có thể bùng nổ sức chiến đấu mạnh mẽ hơn trong nghịch cảnh."
  },
  AwakerConfig_94450_Name = {Text = "Mouchette"},
  AwakerConfig_94450_Painter = {Text = "Bala bala"},
  AwakerConfig_94450_SummonSlogan = {
    Text = "Khách đến từ vùng sương mù, sẽ được rửa tội tái sinh trong bạc và máu ở thế gian này."
  },
  AwakerConfig_94450_Title = {Text = "Mouchette"},
  AwakerConfig_94450_VoiceActor = {
    Text = "Hasegawa Ikumi"
  },
  AwakerConfig_94451_Age = {Text = "5 tháng 5"},
  AwakerConfig_94451_AwakerIntroduction = {
    Text = "·Từng là hiệp sĩ chết trong oán hận, trong người vẫn còn cuộn trào bùn đen tối tăm không thể kiểm soát, chiến đấu vì thứ mới tìm được — thứ xứng đáng được bảo vệ.\n·Theo \"Ám Dũng\" không ngừng tích lũy, sát thương ngày càng đáng kể, gánh nặng bản thân phải chịu cũng ngày càng nặng nề hơn; vào thời khắc then chốt sẽ biến toàn bộ \"Ám Dũng\" thành sức mạnh bảo vệ.\n·Trong màn chơi lần này, sẽ mang Phụ Thệ·Orci cấp độ 50, cấp kỹ năng 5, khởi linh 3 ra chiến đấu, khi bắt đầu lượt rút 3 lá bài, nhận được 3 điểm tính toán, tất cả Thể thức tỉnh nhận được 20 điên cuồng."
  },
  AwakerConfig_94451_Gender = {Text = "Nam"},
  AwakerConfig_94451_Introduction = {
    Text = "Người hiệp sĩ từng mất tất cả, khi gánh chịu mọi tội lỗi, anh một lần nữa lập lời thề bảo vệ."
  },
  AwakerConfig_94451_Name = {
    Text = "Bội Thệ·Orci"
  },
  AwakerConfig_94451_Painter = {Text = "Bala bala"},
  AwakerConfig_94451_Title = {
    Text = "Khởi nguyên · Ogier"
  },
  AwakerConfig_95786_Age = {
    Text = "Ngày 20 tháng 11"
  },
  AwakerConfig_95786_AwakerIntroduction = {
    Text = "·Người ăn thanh lịch, mang đến sự giải thoát cho những linh hồn đang đau khổ, cái chết định mệnh. \n·Hãy tận hưởng di thể của những người đã khuất, dinh dưỡng từ thực phẩm sẽ biến thành sức sống hùng mạnh và năng lượng vô tận của bạn! \n·Trong cấp độ này, sẽ mang theo Doresain cấp 50, kỹ năng cấp 5, khởi linh 3 ra trận, sát thương mà Doresain gây ra trong trận này chắc chắn sẽ là đòn chí mạng."
  },
  AwakerConfig_95786_Gender = {Text = "Nam"},
  AwakerConfig_95786_Introduction = {
    Text = "Người ăn thanh lịch, gây ra sát thương đáng kể cho những kẻ thù có sức sống còn lại thấp hơn, có khả năng tăng cường bản thân và hồi phục cuộc sống khi thưởng thức di thể của những người đã khuất."
  },
  AwakerConfig_95786_Name = {Text = "Doresain"},
  AwakerConfig_95786_Painter = {Text = "Bala bala"},
  AwakerConfig_95786_SummonSlogan = {
    Text = "Ông đã nghe thấy tiếng gọi của bạn. Ông sẽ mời bạn cùng thưởng thức bữa tiệc của linh hồn."
  },
  AwakerConfig_95786_Title = {Text = "Doresain"},
  AwakerConfig_95786_VoiceActor = {
    Text = "Tử An Vũ Nhân"
  }
})
return Text_AwakerConfig
