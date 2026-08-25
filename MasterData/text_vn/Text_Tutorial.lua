__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Tutorial = readonly({
  Tutorial_120371_Desc_1 = {
    Text = "Có thể trở lại các vòng đã trải qua trong trận chiến, có thể trở lại bất kỳ vòng nào trong 25 vòng trước của trận chiến."
  },
  Tutorial_120371_Title_1 = {
    Text = "Đảo ngược thời tự"
  },
  Tutorial_124999_Desc_1 = {
    Text = "Trong <TutorialHighlight:đối đầu pha-Chế độ lựa chọn vòng>, nhấp vào góc dưới bên phải của giao diện \"Bắt đầu ghép cặp\"để vào trận đấu, không cần phải dự bị đội hình."
  },
  Tutorial_124999_Desc_2 = {
    Text = "Trước khi chiến đấu, hệ thống sẽ ngẫu nhiên chọn một <TutorialHighlight:Di vật>, có hiệu lực trong trận đấu. Dựa vào hiệu ứng của di vật trong mỗi trận, lần lượt chọn các thể thức tỉnh, vòng mệnh, mật lệnh cần thiết từ bể thẻ có các tùy chọn giới hạn được ngẫu nhiên đưa ra, để xây dựng biên đội của mình và đối đầu với đối phương."
  },
  Tutorial_124999_Desc_3 = {
    Text = "Bằng cách nhấp vào hai thân thể được thức tỉnh để hoán đổi vị trí, từ đó điều chỉnh vị trí của đội mình trong trận đấu. Các vị trí được sắp xếp theo thứ tự từ 1 đến 4."
  },
  Tutorial_124999_Title_1 = {
    Text = "Lựa chọn vòng biên đội"
  },
  Tutorial_126878_Desc_1 = {
    Text = "Một số thể thức tỉnh khi phát triển nhân cách đạt +12 sẽ tự động nhận được hiệu ứng \"Quy tắc cuối cùng\", hiệu ứng mà mỗi thể thức tỉnh nhận được sẽ khác nhau."
  },
  Tutorial_126878_Desc_2 = {
    Text = "Sau khi mở khóa \"Quy luật cuối cùng\" của thể thức tỉnh, bạn sẽ nhận được một tin nhắn từ bộ đàm chuyên dụng của thể thức tỉnh tương ứng, xin Người Giữ Gìn nhớ kiểm tra."
  },
  Tutorial_126878_Title_1 = {
    Text = "Quy Luật Tối Thượng"
  },
  Tutorial_126878_Title_2 = {
    Text = "Tin tức đặc quyền"
  },
  Tutorial_148475_Desc_1 = {
    Text = "Sau khi tỷ lệ đồng điều của Thể thức tỉnh đạt <TutorialHighlight:Lv20>, có thể nhận được <TutorialHighlight:Bạc Ảnh> độc quyền."
  },
  Tutorial_148475_Desc_2 = {
    Text = "<TutorialHighlight:Bạc Ảnh> là minh chứng cho sự Nghìn Năm Tri Kỷ giữa bạn và Thể thức tỉnh."
  },
  Tutorial_148475_Desc_3 = {
    Text = "Từ nay, thẻ lệnh của Thể thức tỉnh đó sẽ được hiển thị đặc biệt trong chiến đấu, và có thể trưng bày với những người giữ bí mật khác trong các dịp giao lưu xã hội."
  },
  Tutorial_148475_Title_1 = {
    Text = "Nghìn Năm Tri Kỷ"
  },
  Tutorial_17805_Desc_1 = {
    Text = "Bấm vào kẻ thù để xem tất cả trạng thái của nó. <TutorialHighlight:Cảnh báo> Trạng thái cần được chú ý hơn, nó đại diện cho cơ chế đặc biệt của kẻ thù, phần lớn nguyên nhân khiến Người Giữ Gìn không hoàn thành cuộc điều tra một cách suôn sẻ thường là do không chú ý đến cơ chế đặc biệt của kẻ thù."
  },
  Tutorial_17805_Title_1 = {
    Text = "Trạng thái kẻ địch"
  },
  Tutorial_17806_Desc_1 = {
    Text = "Đánh bại kẻ thù có thể chọn <TutorialHighlight:Khắc ấn>, cũng có thể chi tiêu <TutorialHighlight:dấu vết tan chảy> trong <TutorialHighlight:dấu đen> để mua. <TutorialHighlight:Khắc ấn> có thể cho thẻ chỉ định có được hiệu ứng bổ sung khác nhau. Mỗi thẻ chỉ định chỉ có thể được khắc ấn tối đa <TutorialHighlight:1> lần. Ưu tiên khắc ấn cho các thẻ lệnh được chơi thường xuyên hơn, có thể tăng cường lợi ích từ khắc ấn."
  },
  Tutorial_17806_Title_1 = {
    Text = "Khắc ấn"
  },
  Tutorial_17807_Desc_1 = {
    Text = "Cung cấp nhiều thuộc tính cho thể thức tỉnh, nếu ghép thành <TutorialHighlight:bộ trang phục> sẽ có hiệu ứng đặc biệt. Có tổng cộng 6 bộ phận, <TutorialHighlight:thuộc tính chính> của các bộ phận khác nhau, tỷ lệ chí mạng và sát thương chí mạng sẽ xuất hiện ở các bộ phận I, II, III; cấp độ nạp lại điên cuồng và cấp độ nạp năng lượng chìa khóa bạc sẽ xuất hiện ở các bộ phận I, IV, V; sự thông thạo giới vực và tỉ lệ rơi dấu ấn sẽ xuất hiện ở các bộ phận II, IV, VI; khuếch đại sát thương và kháng cự tử vong sẽ xuất hiện ở các bộ phận III, V, VI. Có thể cảm nhận trực quan sức mạnh của mật khế và bộ mật khế thông qua mức hoàn thành mật khế. Mức hoàn thành mật khế có thể được tăng cường thông qua nâng cấp và chuyển lục."
  },
  Tutorial_17807_Title_1 = {
    Text = "Giao ước"
  },
  Tutorial_17808_Desc_1 = {
    Text = "Trong chế độ <TutorialHighlight:Giấc mơ thám hiểm>, mỗi lần thử thách cấp độ sẽ ngẫu nhiên vào một bản đồ. Sau khi thử thách thành công, dựa trên độ khó cấp độ thử thách, thể thức tỉnh được cường hóa và các hạng mục đánh giá trong cấp độ để nhận được điểm số tương ứng. Mỗi tuần thử thách sẽ có tạo vật ban đầu và thể thức tỉnh cường hóa khác nhau."
  },
  Tutorial_17808_Desc_2 = {
    Text = "Giấc mơ thám hiểm thường cập nhật mùa giải mỗi 28 ngày, trong mùa giải hoàn thành một lần Giấc mơ thám hiểm là có thể tham gia <TutorialHighlight:bảng xếp hạng mùa giải>, khi mùa giải kết thúc sẽ kết toán xếp hạng và gửi phần thưởng xếp hạng qua hộp thư."
  },
  Tutorial_17808_Desc_3 = {
    Text = "\"Nhật ký thám hiểm\" thiết lập nhiều mục tiêu, đạt được sẽ nhận phần thưởng tương ứng. Mỗi lần hoàn thành mục tiêu \"Nhật ký thám hiểm\" hoặc thắng thử thách thám hiểm đều có thể nhận được <TutorialHighlight:kinh nghiệm thám hiểm>. Khi kinh nghiệm thám hiểm đạt đến giá trị nhất định, <TutorialHighlight:cấp độ thám hiểm> sẽ tăng lên, có thể nhận được phần thưởng phong phú. Có thể xem qua \"Nhật ký thám hiểm\" và\"Cấp độ thám hiểm\"ở góc dưới bên trái giao diện."
  },
  Tutorial_17808_Title_1 = {
    Text = "Giấc mơ thám hiểm"
  },
  Tutorial_17809_Desc_1 = {
    Text = "Thông qua sự kiện, dấu vết tan chảy có thể nhận được <TutorialHighlight:Di vật>, <TutorialHighlight:Di vật> có thể tăng cường khả năng chiến đấu của đội ngũ. Người giữ bí mật xuất sắc thường có thể lựa chọn <TutorialHighlight:Di vật> phù hợp hơn dựa trên nhu cầu của đội ngũ."
  },
  Tutorial_17809_Title_1 = {Text = "Di vật"},
  Tutorial_17810_Desc_1 = {
    Text = "Xua tan sương mù, phạm vi tầm nhìn bản đồ tăng <TutorialHighlight:2> ô vuông, có thể tận dụng nó để lập kế hoạch đường đi tốt hơn."
  },
  Tutorial_17810_Title_1 = {Text = "đèn pha"},
  Tutorial_17811_Desc_1 = {
    Text = "Mục tiêu ở trạng thái <TutorialHighlight:trúng độc> sẽ chịu thương tương đương với số lớp <TutorialHighlight:trúng độc> khi kết thúc lượt. Thương từ <TutorialHighlight:trúng độc> <TutorialHighlight:không thể crit>."
  },
  Tutorial_17811_Title_1 = {
    Text = "Ngộ độc"
  },
  Tutorial_17812_Desc_1 = {
    Text = "Mục tiêu ở trạng thái <TutorialHighlight:dễ bị tổn thương> sẽ chịu sát thương tăng 50%, và tự động loại bỏ 1 lớp <TutorialHighlight:dễ bị tổn thương> khi kết thúc lượt. Tận dụng thời cơ kẻ địch ở trạng thái <TutorialHighlight:dễ bị tổn thương> để gây thêm sát thương."
  },
  Tutorial_17812_Title_1 = {
    Text = "Trọng thương"
  },
  Tutorial_17813_Desc_1 = {
    Text = "Trong \"Dung Thực Chi Khư\",\"Cấm Kỵ Biên Soạn\",\"Siêu Nghiệm Tồn Tại\" khi hoàn thành cấp độ, cấp độ đó và các cấp độ có độ khó thấp hơn có thể tiến hành <TutorialHighlight:tái hiện>. Thông qua <TutorialHighlight:tái hiện> có thể nhanh chóng nhận được phần thưởng của cấp độ."
  },
  Tutorial_17813_Title_1 = {
    Text = "tái hiện"
  },
  Tutorial_17814_Desc_1 = {
    Text = "<TutorialHighlight:lá chắn> có thể thay thế sinh lực để chịu đựng thương, vào cuối lượt <TutorialHighlight:tự động loại bỏ> tất cả lá chắn, giới hạn của lá chắn bằng với <TutorialHighlight:sinh lực tối đa> của đội. Cố gắng <TutorialHighlight:để lá chắn bằng tổng lượng thương của tất cả kẻ địch trong lượt này>, đạt được chiến thắng trong trận chiến với chi phí tối thiểu."
  },
  Tutorial_17814_Title_1 = {Text = "lá chắn"},
  Tutorial_17815_Desc_1 = {
    Text = "Việc nhận được Thể thức tỉnh nhiều lần sẽ chuyển đổi thành <TutorialHighlight:Mảnh vỡ>. Tiêu thụ <TutorialHighlight:Mảnh vỡ> để nâng cao Cấp độ Khai sáng của Thể thức tỉnh, có thể giúp kỹ năng của Thể thức tỉnh nhận được khả năng đặc biệt bổ sung. Khi Cấp độ Khai sáng của Thể thức tỉnh đã đầy mà lại nhận được mảnh vỡ tương ứng, sẽ chuyển đổi thành <TutorialHighlight:Mảnh vỡ hồi tưởng linh hồn>."
  },
  Tutorial_17815_Title_1 = {
    Text = "Mảnh vỡ"
  },
  Tutorial_17816_Desc_1 = {
    Text = "Điểm tính toán là <TutorialHighlight:chia sẻ toàn đội>, đánh ra thẻ bài cần tiêu thụ <TutorialHighlight:Điểm tính toán>. Điểm tính toán sẽ <TutorialHighlight:tự động phục hồi lên mức tối đa> vào đầu lượt, và <TutorialHighlight:tự động xóa> sau khi kết thúc lượt. Để nâng cao hiệu quả sử dụng điểm tính toán, vui lòng <TutorialHighlight:tiêu thụ tất cả điểm tính toán rồi mới kết thúc lượt>."
  },
  Tutorial_17816_Title_1 = {
    Text = "Điểm tính toán"
  },
  Tutorial_17817_Desc_1 = {
    Text = "Đánh bại kẻ thù trong <TutorialHighlight:Sự tồn tại siêu việt> có thể nhận được <TutorialHighlight:nguyên liệu nâng cấp kỹ năng> cao cấp, mỗi tuần có thể nhận phần thưởng 1 lần. Các nguyên liệu khác cũng có thể được tổng hợp và thay thế trong <TutorialHighlight:phòng luyện kim>."
  },
  Tutorial_17817_Title_1 = {
    Text = "Sự tồn tại siêu việt"
  },
  Tutorial_17818_Desc_1 = {
    Text = "Sau khi nhận có thể sử dụng trong <TutorialHighlight:vật tư>, có thể nhanh chóng nâng cấp cấp độ thân thể được đánh thức và cấp độ kỹ năng theo giá trị đã đặt trước."
  },
  Tutorial_17818_Title_1 = {
    Text = "bộ tăng cường linh tri"
  },
  Tutorial_17819_Desc_1 = {
    Text = "Khi thể thức tỉnh đạt <TutorialHighlight:100> điểm điên cuồng, có thể phát động <TutorialHighlight:bùng nổ>. Hiệu ứng bùng nổ của các thể thức tỉnh khác nhau, sử dụng hợp lý có thể <TutorialHighlight:đạt được hiệu quả gấp đôi>."
  },
  Tutorial_17819_Title_1 = {Text = "Bùng nổ"},
  Tutorial_17820_Desc_1 = {
    Text = "Mục tiêu ở trạng thái <TutorialHighlight:mong manh>, lá chắn nhận được giảm 25%, vào cuối lượt tự động loại bỏ 1 lớp <TutorialHighlight:mong manh>. Nếu đội của chúng ta đang ở trạng thái <TutorialHighlight:mong manh>, hãy nhớ tìm cách loại bỏ trạng thái <TutorialHighlight:mong manh> trước khi phòng thủ, hoặc thay đổi chiến lược, tập trung tấn công trong lượt này."
  },
  Tutorial_17820_Title_1 = {Text = "Mong manh"},
  Tutorial_17821_Desc_1 = {
    Text = "Để trang bị <TutorialHighlight:vòng mệnh>, có thể tăng cường thuộc tính của thân thể được đánh thức và còn có thể nhận được khả năng đặc biệt."
  },
  Tutorial_17821_Title_1 = {
    Text = "vòng mệnh"
  },
  Tutorial_17822_Desc_1 = {
    Text = "Mục tiêu ở trạng thái <TutorialHighlight:chảy máu> sẽ chịu thương tương đương với số lớp <TutorialHighlight:chảy máu> khi kết thúc lượt và sau đó <TutorialHighlight:loại bỏ trạng thái chảy máu>.\n Khi <TutorialHighlight:hồi phục sinh lực>, loại bỏ số lớp chảy máu tương đương với <TutorialHighlight:số lượng hồi phục gấp 2 lần>. Sát thương chảy máu <TutorialHighlight:không thể crit>."
  },
  Tutorial_17822_Title_1 = {
    Text = "Chảy máu"
  },
  Tutorial_17823_Desc_1 = {
    Text = "Thân thể hỗn độn có thể <TutorialHighlight: phá vỡ hạn chế cõi> và biên đội với các thân thể thức tỉnh từ cõi khác, và sẽ có các hiệu ứng cộng sinh khác nhau. Nếu trong bất kỳ đội nào có thân thể hỗn độn, có thể nhận thêm 100% kháng cự tử vong."
  },
  Tutorial_17823_Desc_2 = {
    Text = "So với các đội trong các cõi khác, đội trong cõi hỗn mang nhận được năng lượng chìa khóa bạc nhanh hơn, và khi phát động lần thứ hai mật lệnh, có thể chọn trong tất cả các mật lệnh, và mật lệnh được chọn sẽ kích hoạt 2 lần. Do đó, đội trong cõi hỗn mang phụ thuộc nhiều hơn vào sự hợp tác giữa các mật lệnh, việc chọn mật lệnh phù hợp có thể tăng cường sức mạnh của đội trong cõi hỗn mang một cách đáng kể!"
  },
  Tutorial_17823_Title_1 = {Text = "Hỗn Mang"},
  Tutorial_17824_Desc_1 = {
    Text = "Mỗi khi có 1 điểm <TutorialHighlight:giữ mình>, mỗi lần nhận được lá chắn sẽ nhận thêm 1 điểm lá chắn."
  },
  Tutorial_17824_Title_1 = {
    Text = "Báo động"
  },
  Tutorial_17825_Desc_1 = {
    Text = "Sau khi hoàn thành điều tra hành động lần đầu tiên, bạn có thể nhận được <TutorialHighlight:vật liệu kích hoạt cảm ứng>, chúng có thể được sử dụng để kích hoạt <TutorialHighlight:cảm ứng> mạnh mẽ, cảm ứng sẽ có hiệu lực trong tất cả các cấp độ của chương này."
  },
  Tutorial_17825_Title_1 = {
    Text = "cảm ứng"
  },
  Tutorial_17826_Desc_1 = {
    Text = "Khi đội ngũ của tôi đang ở trạng thái <TutorialHighlight:Aliemus niêm phong>, không thể phát động bùng nổ Aliemus. Trước khi kẻ thù sắp tạo ra <TutorialHighlight:Aliemus niêm phong>, có thể phát động bùng nổ Aliemus để tránh lãng phí Aliemus."
  },
  Tutorial_17826_Title_1 = {
    Text = "Phong ấn điên cuồng"
  },
  Tutorial_17827_Desc_1 = {
    Text = "Tiêu thụ <TutorialHighlight:thuốc linh tri> có thể nâng cao cấp độ của Thể thức tỉnh, sau khi Thể thức tỉnh nâng cấp, thuộc tính sẽ được cải thiện. Khi đạt đến giới hạn cấp độ, cần phải tiến hành khai sáng trước, sau khi khai sáng sẽ nâng cao giới hạn cấp độ của Thể thức tỉnh."
  },
  Tutorial_17827_Title_1 = {
    Text = "thuốc linh tri"
  },
  Tutorial_17828_Desc_1 = {
    Text = "<TutorialHighlight:lực lượng> mỗi khi giảm 1 điểm, gây <TutorialHighlight:sát thương chủ động> sẽ giảm 1 điểm thương."
  },
  Tutorial_17828_Title_1 = {
    Text = "sức mạnh giảm xuống"
  },
  Tutorial_17829_Desc_1 = {
    Text = "Mỗi lần trước khi nhận sát thương, miễn nhiễm sát thương và loại bỏ 1 lớp <TutorialHighlight:rào cản>. Sát thương đơn lần càng cao, hiệu quả bảo vệ từ <TutorialHighlight:rào cản> càng lớn."
  },
  Tutorial_17829_Title_1 = {Text = "rào cản"},
  Tutorial_17830_Desc_1 = {
    Text = "Mục tiêu ở trạng thái <TutorialHighlight:yếu đuối>, lượng sát thương gây ra giảm 25%, tự động loại bỏ 1 lớp <TutorialHighlight:yếu đuối> khi kết thúc lượt. Nếu đội của chúng ta ở trạng thái <TutorialHighlight:yếu đuối>, hãy nhớ tìm cách loại bỏ trạng thái <TutorialHighlight:yếu đuối> trước khi tấn công, hoặc thay đổi chiến lược, toàn lực phòng thủ trong lượt này."
  },
  Tutorial_17830_Title_1 = {
    Text = "Suy nhược"
  },
  Tutorial_17831_Desc_1 = {
    Text = "Đánh bại kẻ thù trong <TutorialHighlight:Bản ghi cấm>, có thể nhận được <TutorialHighlight:Giao ước> nâng cao khả năng của thể thức tỉnh. Mỗi khi hoàn thành một chương cốt truyện sẽ mở khóa màn chơi <TutorialHighlight:Bản ghi cấm> mới. Giao ước cũng có thể được đổi lấy tại cửa hàng."
  },
  Tutorial_17831_Title_1 = {
    Text = "Bản ghi cấm"
  },
  Tutorial_17832_Desc_1 = {
    Text = "Đội siêu chiều mỗi lượt chơi thẻ lệnh <TutorialHighlight:đầu tiên> tạm thời sẽ vào <TutorialHighlight:không gian siêu việt> và kích hoạt hiệu ứng bước nhảy mạnh mẽ. Khi không gian siêu việt đạt giới hạn, nhận 1 lượt <TutorialHighlight:siêu chiều> bổ sung, <TutorialHighlight:Vòng siêu chiều có thể kích hoạt tất cả hiệu ứng bước nhảy>. Bí quyết cơ bản để chơi tốt đội siêu chiều: Lập kế hoạch cẩn thận cho lá bài đầu tiên trong mỗi lượt."
  },
  Tutorial_17832_Title_1 = {
    Text = "Siêu Chiều"
  },
  Tutorial_17833_Desc_1 = {
    Text = "Khi sức sống của đội bên ta cạn kiệt, có thể kích hoạt <TutorialHighlight:thể linh tri thức khẩn cấp> để phục hồi tất cả trạng thái. Thể linh tri thức khẩn cấp tự động phục hồi <TutorialHighlight:1> cái mỗi ngày, giới hạn tối đa <TutorialHighlight:5> cái. Hãy áp dụng hợp lý thể linh tri thức khẩn cấp trong <TutorialHighlight:trận chiến khó khăn> và đừng lãng phí một cách tùy tiện."
  },
  Tutorial_17833_Title_1 = {
    Text = "Thân thể Linh tri thức khẩn cấp"
  },
  Tutorial_17834_Desc_1 = {
    Text = "Tìm kiếm kỹ lưỡng những địa điểm phát sáng nhẹ trên bản đồ, đi điều tra có thể sẽ có điều bất ngờ."
  },
  Tutorial_17834_Title_1 = {
    Text = "Điểm tách ra"
  },
  Tutorial_17835_Desc_1 = {
    Text = "Đại diện cho tổng lượng thương mà tất cả kẻ địch gây ra trong lượt này. Một kinh nghiệm chiến đấu đơn giản và hữu ích cho Người Giữ Gìn: <TutorialHighlight: cố gắng làm cho lá chắn bằng với tổng lượng thương của kẻ địch>."
  },
  Tutorial_17835_Title_1 = {
    Text = "Tổng thương của địch"
  },
  Tutorial_17837_Desc_1 = {
    Text = "Khi <TutorialHighlight:Dung hợp Phôi thai> của đội thịt máu đạt giới hạn, sẽ nhận được 1 lá <TutorialHighlight:「Phôi thai」>. Việc phát động bùng nổ điên cuồng sẽ tiêu thụ <TutorialHighlight:「Phôi thai」> để kích hoạt hiệu ứng <TutorialHighlight:Thôn phệ> mạnh mẽ, vì vậy hãy cố gắng phát động bùng nổ điên cuồng khi trong tay có <TutorialHighlight:「Phôi thai」>, nếu không sẽ không thể phát huy sức mạnh tối đa của đội thịt máu."
  },
  Tutorial_17837_Desc_2 = {
    Text = "Sau mỗi trận chiến, 5% máu tối đa sẽ được tích lũy vào lò luyện màu đỏ thẫm, nếu có <TutorialHighlight:「phôi thai」> chưa sử dụng, mỗi phôi thai cũng sẽ tích lũy 5% máu tối đa vào lò. Lò luyện màu đỏ thẫm có thể được sử dụng để hồi phục sức sống của đội ngũ của bạn, mỗi lượt có thể chuyển hóa lò thành sức sống 1 lần. Người giữ bí mật cần lên kế hoạch sử dụng lò luyện màu đỏ thẫm một cách hợp lý để đạt hiệu ứng đảo ngược tình thế."
  },
  Tutorial_17837_Title_1 = {
    Text = "thịt máu"
  },
  Tutorial_17838_Desc_1 = {
    Text = "Tại điểm liên lạc, bạn có thể chọn phục hồi 50% sức sống đã mất của đội bên ta, hoặc chỉ định thức tỉnh một thân thể. Khi sức sống đội bên ta thấp, nên chọn phục hồi sức sống; ngược lại, nên chọn thức tỉnh thân thể."
  },
  Tutorial_17838_Title_1 = {
    Text = "Điểm liên lạc"
  },
  Tutorial_17839_Desc_1 = {
    Text = "Dùng để tiêu thụ dấu đen tăng cường đội ngũ của chúng ta, thường sẽ cung cấp 1 ô khắc ấn, 1 ô bạc tạo vật, 1 ô vật tạo vàng. Nếu ở đây không có vật phẩm cần thiết, có thể nhấp vào góc trên bên phải <TutorialHighlight:Làm mới>, dấu vết tan chảy sẽ cung cấp vật phẩm mới."
  },
  Tutorial_17839_Title_1 = {
    Text = "dấu vết tan chảy"
  },
  Tutorial_17840_Desc_1 = {
    Text = "Việc cố gắng vượt qua <TutorialHighlight:ảo ảnh> sẽ dẫn đến nhiễm \"triệu chứng\"."
  },
  Tutorial_17840_Title_1 = {Text = "ảo ảnh"},
  Tutorial_17841_Desc_1 = {
    Text = "Qua thẻ lệnh, thân thể được đánh thức có thể nhận được <TutorialHighlight:cuồng nộ>. Cấp độ kỹ năng của thẻ lệnh càng cao, lượng cuồng nộ nhận được càng nhiều."
  },
  Tutorial_17841_Title_1 = {
    Text = "điên cuồng"
  },
  Tutorial_17842_Desc_1 = {
    Text = "Đánh bại kẻ thù, điều tra sự kiện có thể nhận được <TutorialHighlight:dấu đen>. Thuộc tính <TutorialHighlight:dấu đen rơi> khi thân thể được đánh thức có thể tăng số lượng dấu đen nhận được."
  },
  Tutorial_17842_Desc_2 = {
    Text = "Trong dấu vết tan chảy, bạn có thể tiêu thụ <TutorialHighlight:dấu đen> để mua khắc ấn và di vật, cũng có thể dùng để thức tỉnh thể thức tỉnh. Trước trận chiến cuối cùng, hãy cố gắng tiêu hết tất cả dấu đen để tăng cường đội ngũ của chúng ta."
  },
  Tutorial_17842_Title_1 = {Text = "dấu đen"},
  Tutorial_17843_Desc_1 = {
    Text = "Khi bị tấn công, gây lượng thương tương đương với số tầng <TutorialHighlight:phản công>. Thương từ <TutorialHighlight:phản công> <TutorialHighlight:không thể gây sát thương chí mạng>."
  },
  Tutorial_17843_Title_1 = {
    Text = "phản công"
  },
  Tutorial_17844_Desc_1 = {
    Text = "Mỗi khi có 1 điểm <TutorialHighlight:sức mạnh>, mỗi lần gây thương chủ động sẽ tăng thêm 1 điểm thương."
  },
  Tutorial_17844_Title_1 = {
    Text = "lực lượng"
  },
  Tutorial_17845_Desc_1 = {
    Text = "phái đi Thể thức tỉnh hoàn thành nhiệm vụ nghiên cứu, sau khi hoàn thành có thể nhận phần thưởng tương ứng. Phái đi Thể thức tỉnh <TutorialHighlight:Tổng cấp độ> càng cao, phần thưởng càng phong phú, tối đa tính theo 240 tổng cấp độ."
  },
  Tutorial_17845_Title_1 = {Text = "phái đi"},
  Tutorial_17847_Desc_1 = {
    Text = "Khi nhận phải thương tổn chí mạng, có <TutorialHighlight:xác suất tương đương với kháng cự tử vong> miễn dịch thương tổn này và giữ lại 1 điểm sức sống, <TutorialHighlight:sau khi thành công kích hoạt, kháng cự tử vong giảm một nửa>. Kháng cự tử vong của đội ngũ tương đương với tổng kháng cự tử vong của tất cả thể thức tỉnh, việc nâng cao kháng cự tử vong của đội ngũ sẽ giúp tăng cường tỷ lệ chịu đựng trong trận chiến."
  },
  Tutorial_17847_Title_1 = {
    Text = "kháng cự tử vong"
  },
  Tutorial_17848_Desc_1 = {
    Text = "Khi bắt đầu trận chiến của đội Hải Vực, tạo ra 1 <TutorialHighlight:Xúc tu>, <TutorialHighlight:Xúc tu> tấn công kẻ địch ở hàng đầu khi lượt kết thúc, có thể thông qua công thức dưới biểu tượng xúc tu để hiểu rõ thương tổn và số lần tấn công hiện tại của xúc tu. Một số thể thức tỉnh có thể tăng cường số lượng xúc tu và thương tổn xúc tu, gây ra lượng thương tổn lớn khi lượt kết thúc."
  },
  Tutorial_17848_Title_1 = {
    Text = "Hải Vực"
  },
  Tutorial_17850_Desc_1 = {
    Text = "Đánh ra bài trong tay cần tiêu thụ sức tính toán, khi kết thúc lượt chơi, tất cả bài trong tay sẽ vào <TutorialHighlight:rác bài>. Lên kế hoạch hợp lý <TutorialHighlight:thứ tự ra bài> sẽ là chìa khóa để giành chiến thắng trong chiến đấu."
  },
  Tutorial_17850_Title_1 = {Text = "Tay"},
  Tutorial_17851_Desc_1 = {
    Text = "Đại diện cho hành động mà kẻ địch sẽ thực hiện trong lượt tiếp theo, sử dụng <TutorialHighlight:ý định> để đưa ra quyết định trong lượt này là trọng tâm của chiến đấu."
  },
  Tutorial_17851_Title_1 = {
    Text = "Kế hoạch của kẻ địch"
  },
  Tutorial_17852_Desc_1 = {
    Text = "<TutorialHighlight:Nâng cấp kỹ năng> có thể nâng cao thuộc tính của Người đánh thức, tăng cường hiệu ứng thẻ lệnh. Nhấn vào cấp độ tiếp theo trên giao diện kỹ năng của Người đánh thức để xem trước hiệu ứng nâng cấp."
  },
  Tutorial_17852_Desc_2 = {
    Text = "Người đánh thức đến từ các cõi khác nhau cần những <TutorialHighlight:nguyên liệu nâng cấp kỹ năng> khác nhau."
  },
  Tutorial_17852_Title_1 = {
    Text = "Kỹ năng tăng cường"
  },
  Tutorial_20768_Desc_1 = {
    Text = "Thể thức tỉnh khi chơi thẻ lệnh hoặc tiêu thụ điểm tính toán để Khai mở linh trí có thể nhận được <TutorialHighlight:Năng lượng chìa khóa bạc>. Thuộc tính <TutorialHighlight:Sạc năng lượng chìa khóa bạc> của thể thức tỉnh có thể nâng cao lượng <TutorialHighlight:Năng lượng chìa khóa bạc> nhận được."
  },
  Tutorial_20768_Title_1 = {
    Text = "Năng lượng chìa khóa bạc"
  },
  Tutorial_20769_Desc_1 = {
    Text = "<TutorialHighlight:cánh cửa rỉ sét> sẽ chặn đường điều tra quan trọng, hãy cố gắng tìm kiếm một vật phẩm có tên là <TutorialHighlight:chìa khóa rỉ sét>, nó có thể được sử dụng để mở <TutorialHighlight:cánh cửa rỉ sét>."
  },
  Tutorial_20769_Title_1 = {
    Text = "cánh cửa rỉ sét"
  },
  Tutorial_20770_Desc_1 = {
    Text = "<TutorialHighlight:chìa khóa rỉ sét> có thể mở <TutorialHighlight:cánh cửa rỉ sét> cản đường bạn."
  },
  Tutorial_20770_Title_1 = {
    Text = "chìa khóa rỉ sét"
  },
  Tutorial_20771_Desc_1 = {
    Text = "<TutorialHighlight:Vùng đất vô ánh sáng> bao gồm một loạt các cấp độ của bốn cõi, sau khi hoàn thành có thể nhận được bạc tâm, thuốc linh tri và các phần thưởng khác, khi tích lũy sao đạt yêu cầu chỉ định còn có thể nhận thêm bạc tâm, Hạt Nhân Sạch Will và các phần thưởng khác!"
  },
  Tutorial_20771_Desc_2 = {
    Text = "Các khe hở giữa các giới vực khác nhau yêu cầu đội điều tra phải có thân thể được đánh thức phù hợp, chỉ đội <TutorialHighlight:đáp ứng yêu cầu> mới có thể tiến hành điều tra."
  },
  Tutorial_20771_Title_1 = {
    Text = "Vùng đất vô ánh sáng"
  },
  Tutorial_20772_Desc_1 = {
    Text = "Khi năng lượng chìa khóa bạc đạt <TutorialHighlight:1000>, có thể giải phóng <TutorialHighlight:Mật lệnh> mang theo. Mỗi lượt có thể giải phóng 2 lần mật lệnh, nhưng lần giải phóng thứ hai sẽ được chọn 1 trong 3 mật lệnh ngẫu nhiên để giải phóng, và mật lệnh được chọn sẽ không thể được chọn lại trong lần khám phá này. Khi biên đội, hãy chọn mật lệnh phù hợp cho đội ngũ của chúng ta để quá trình điều tra diễn ra suôn sẻ hơn."
  },
  Tutorial_20772_Title_1 = {
    Text = "Mật lệnh"
  },
  Tutorial_20773_Desc_1 = {
    Text = "Tiêu thụ <TutorialHighlight:vòng mệnh> giống nhau để chồng vị, hoặc sử dụng <TutorialHighlight:Bản mẫu tuần hoàn> để chồng vị cho <TutorialHighlight:vòng mệnh SSR>, có thể nâng cao thuộc tính và khả năng đặc biệt của <TutorialHighlight:vòng mệnh>. Khi chồng vị từ 1 đến 3 lần, hiệu ứng của vòng mệnh sẽ được tăng cường; khi chồng vị từ 4 đến 15 lần, thuộc tính của vòng mệnh sẽ được tăng cường. Có thể nhấn nút \"Cấp độ tiếp theo\" trên giao diện chồng vị để xem trước sự thay đổi sau khi chồng vị.\nKhi nhận được vòng mệnh đã sở hữu thông qua thức tỉnh và các cách khác, hệ thống sẽ tự động chồng vị với vòng mệnh hiện có, Người Giữ Gìn không cần thao tác riêng."
  },
  Tutorial_20773_Title_1 = {
    Text = "Vòng mệnh chồng tầng"
  },
  Tutorial_22247_Desc_1 = {
    Text = "<TutorialHighlight:Nâng cấp giao ước> có thể nâng cao sức mạnh thuộc tính của giao ước, tối đa lên đến cấp 12. Phân giải giao ước có thể nhận được bản còn lại tương ứng, tiến hành thay thế vật liệu trong vật tư có thể nhận được <TutorialHighlight:Chấn ấn nghìn mặt>. Nâng cấp giao ước cần tiêu thụ <TutorialHighlight:Chấn ấn nghìn mặt>, phân giải giao ước đã nâng cấp cũng sẽ hoàn lại <TutorialHighlight:Chấn ấn nghìn mặt> đã tiêu thụ cho việc nâng cấp."
  },
  Tutorial_22247_Title_1 = {
    Text = "Nâng cấp bí ẩn"
  },
  Tutorial_22248_Desc_1 = {
    Text = "Thông qua việc chuyển ghi, có thể khiến <TutorialHighlight:Giao ước> nhận được thuộc tính ngẫu nhiên về loại và cường độ, thuộc tính phụ không liên quan đến vị trí, có thể xuất hiện 8 loại như tỉ lệ chí mạng, sát thương chí mạng, cấp độ nạp lại điên cuồng, cấp độ nạp năng lượng chìa khóa bạc, sự thông thạo giới vực, tỉ lệ rơi dấu ấn, khuếch đại sát thương, kháng cự tử vong. Khi chuyển ghi, nếu muốn giữ lại một thuộc tính nào đó, có thể chọn <TutorialHighlight:khóa lại>, thuộc tính đã khóa sẽ không thay đổi trong quá trình chuyển ghi."
  },
  Tutorial_22248_Title_1 = {
    Text = "Chuyển ghi bí ẩn"
  },
  Tutorial_23466_Desc_1 = {
    Text = "Khi cấp độ của Người Giữ Gìn tăng, <TutorialHighlight: sức mạnh của di vật và khắc ấn> cũng sẽ tăng theo, ảnh hưởng của <TutorialHighlight: mỗi điểm thể chất đối với sinh lực của đội ngũ> cũng sẽ tăng. Thông qua điều tra hành động và màn diễn tập, bạn có thể nhận được lượng lớn kinh nghiệm của Người Giữ Gìn. Mỗi khi tiêu thụ 1 điểm thể lực sẽ nhận được 1 điểm kinh nghiệm của Người Giữ Gìn."
  },
  Tutorial_23466_Title_1 = {
    Text = "Cấp độ Người Giữ Gìn"
  },
  Tutorial_47538_Desc_1 = {
    Text = "Vùng cấm hòa hợp với thiên tai là một hệ thống chế độ chơi có độ khó cao. Người giữ bí mật cần linh hoạt kết hợp nhiều đội thách thức, cố gắng thu được nhiều Điểm huấn luyện hơn để nhận được nhiều phần thưởng hơn. Độ khó cảnh giác cao không chỉ làm cho các đơn vị địch trở nên mạnh hơn mà còn có nhiều hiệu ứng giảm bớt khác nhau."
  },
  Tutorial_47538_Desc_2 = {
    Text = "Trong vùng cấm hòa hợp với thiên tai có những quy tắc hạn chế độc đáo: cùng một thân thể được đánh thức và mật lệnh, vòng mệnh cùng tên không thể ra trận nhiều lần, Người Giữ Gìn có thể linh hoạt chọn đội ngũ cho thách thức này dựa trên di vật ban đầu, quái vật và cấp độ được đề xuất, áp dụng chiến lược đua ngựa Tần Kỳ để có thể đạt được nhiều điểm huấn luyện hơn. Các thân thể được đánh thức ra trận bằng cách <TutorialHighlight:trợ chiến> không bị ảnh hưởng bởi hạn chế này."
  },
  Tutorial_47538_Title_1 = {
    Text = "Vùng cấm hòa hợp với thiên tai"
  },
  Tutorial_54390_Desc_1 = {
    Text = "Trong chế độ <TutorialHighlight:đối đầu pha>, tất cả các <TutorialHighlight:trạng thái> mà thân thể được đánh thức của cả hai phe sở hữu sẽ hiển thị bên dưới mức sức sống và điên cuồng, bấm để xem chi tiết hiệu ứng."
  },
  Tutorial_54390_Desc_2 = {
    Text = "Thuộc về <TutorialHighlight:trạng thái tích cực> như sau (nhấn để xem chi tiết): <TauntKeywords:khích bác>, <PVPPowerIconKeywords:lực lượng>, <EnergyStorageKeywords:Súc tích>, <PVPProtectiveKeywords:rào cản>, <PVPRetaliateIconKeywords:phản công>, <ReinforceKeywords:Gia cố>, <StrengthenKeywords:tăng cường>."
  },
  Tutorial_54390_Desc_3 = {
    Text = "Thuộc về <TutorialHighlight:trạng thái tiêu cực> như sau (nhấp để xem chi tiết): <PVPEntanglementKeywords:vướng víu>, <PVPVulnerabilityIconKeywords:tăng sát thương>, <PVPSlowKeywords:trì trệ>, <ComaKeywords:hóa đá>, <DisarmKeywords:chích điện>, <PVPMethysisKeywords:ngộ độc>, <PVPEmptinessKeywords:hư vô>, <PVPBleedingKeywords:chảy máu>, <PVPSeriousInjuryKeywords:thiệt hại nặng>, <ComaKeywords:hôn mê>."
  },
  Tutorial_54390_Title_1 = {
    Text = "Trạng thái"
  },
  Tutorial_54391_Desc_1 = {
    Text = "Trong chế độ <TutorialHighlight:Đấu Cờ Pha Lê>, một số thẻ bài của Tỉnh Giấc Thể sẽ có các hiệu ứng <TutorialHighlight:Phụ Tố> khác nhau, có thể xem trong hệ thống <TutorialHighlight:Bộ Sưu Tập> hoặc nhấn giữ thẻ bài trong trận chiến để xem. Các phụ tố bao gồm (nhấp để xem chi tiết): <PVPPenetrateKeywords:Xuyên Thấu>, <PrepareKeywords:Chuẩn Bị>, <PVPResurrectionKeywords:Hồi Sinh>, <PVPHoldingKeywords:Giữ>, <PhantomKeywords:Ảo Ảnh>, <PVPRaidKeywords:Tấn Công Chớp Nhoáng>."
  },
  Tutorial_54391_Title_1 = {
    Text = "Phụ lục"
  },
  Tutorial_54392_Desc_1 = {
    Text = "Trong một số chế độ đặc biệt sẽ có chế độ <TutorialHighlight:mùa giải>, tham gia bảng xếp hạng của chế độ đặc biệt trong mùa giải sẽ được kết toán phần thưởng dựa trên xếp hạng khi mùa giải kết thúc.\nTheo tiến trình hành động điều tra, trong tương lai sẽ có thêm nhiều chế độ tham gia chế độ <TutorialHighlight:mùa giải>."
  },
  Tutorial_54392_Desc_2 = {
    Text = "Trong mỗi mùa giải đều có <TutorialHighlight:Nhiệm vụ mùa giải>, hoàn thành nhiệm vụ mùa giải để nhận phần thưởng phong phú. Nhiệm vụ mùa giải sẽ được đặt lại khi mùa giải làm mới."
  },
  Tutorial_54392_Title_1 = {
    Text = "Mùa giải"
  },
  Tutorial_54393_Desc_1 = {
    Text = "Trong chế độ <TutorialHighlight:đối đầu pha>, khi Thể thức tỉnh bị tiêu diệt, các thẻ bài thuộc về Thể thức tỉnh đó trong tay sẽ biến thành <TutorialHighlight:ảo ảnh>. Trang bị <TutorialHighlight:vòng mệnh> cho Thể thức tỉnh đã bị tiêu diệt cũng sẽ nhận được 1 lá ảo ảnh, đồng thời hoàn lại lượng Điểm tính toán đã tiêu thụ. Ảo ảnh còn có thể được hợp thành <TutorialHighlight:ước nguyện nhỏ nhỏ> bằng hiệu ứng của các vòng mệnh cụ thể."
  },
  Tutorial_54393_Title_1 = {Text = "ảo ảnh"},
  Tutorial_54394_Desc_1 = {
    Text = "Trong chế độ <TutorialHighlight:đối đầu pha>, ở lượt đầu tiên, cả hai bên đều có 3 điểm <TutorialHighlight:Điểm tính toán> và giới hạn, bên đi sau sẽ được bù thêm 1 thẻ <TutorialHighlight:Hậu phát chế nhân>. Sau đó, mỗi khi bắt đầu lượt, giới hạn sức tính toán và lượng hồi phục sẽ tăng 1 điểm cho đến 10 điểm. Ngoài việc tự động tăng trưởng, cũng có những cách khác để tăng hoặc giảm giới hạn sức tính toán. Khi giới hạn sức tính toán đạt 10 điểm, mỗi điểm vượt quá sẽ được thay thế bằng việc rút 1 lá bài."
  },
  Tutorial_54394_Title_1 = {
    Text = "Điểm tính toán"
  },
  Tutorial_54395_Desc_1 = {
    Text = "Trong chế độ <TutorialHighlight:đối đầu pha>, mỗi thể thức tỉnh cũng có <TutorialHighlight:điên cuồng> và <TutorialHighlight:bùng nổ>. Có thể nhận được điên cuồng bằng cách sử dụng thẻ <TutorialHighlight:Đánh> hoặc thẻ <TutorialHighlight:kỹ năng> cụ thể, khi nhận thương và mất sinh lực cũng sẽ nhận được điên cuồng (mỗi khi mất 2% sinh lực hoặc lá chắn tương đương sẽ nhận 1 điểm điên cuồng), khi điên cuồng đạt 100, nhấn vào thể thức tỉnh tương ứng để chọn giải phóng bùng nổ."
  },
  Tutorial_54395_Title_1 = {
    Text = "điên cuồng"
  },
  Tutorial_54396_Desc_1 = {
    Text = "Trong chế độ <TutorialHighlight:đối đầu pha>, hoàn thành mục tiêu chỉ định trong \"Kỷ lục đối kháng\" trong trận đấu đối kháng sẽ có thể nhận phần thưởng tương ứng. Phần thưởng này là phần thưởng một lần, không bị đặt lại theo mùa giải, có thể xem qua \"Kỷ lục đối kháng\"ở góc dưới bên trái giao diện."
  },
  Tutorial_54396_Title_1 = {
    Text = "Lịch sử ván cờ"
  },
  Tutorial_54397_Desc_1 = {
    Text = "Trong chế độ <TutorialHighlight:đối đầu pha>, bạn có thể xem thông tin về tất cả thân thể được đánh thức, vòng mệnh, và lệnh khóa trong tab \"thu thập\"ở phía bên trái giao diện."
  },
  Tutorial_54397_Title_1 = {Text = "Lưu trữ"},
  Tutorial_54398_Desc_1 = {
    Text = "Trong chế độ <TutorialHighlight:đối đầu pha>, mỗi thể thức tỉnh có 2 thẻ <TutorialHighlight:Đánh> và 3 thẻ <TutorialHighlight:Kỹ năng>. Thông thường, các thẻ kỹ năng khác nhau sẽ có tiêu thụ sức tính toán khác nhau."
  },
  Tutorial_54398_Title_1 = {Text = "Kỹ năng"},
  Tutorial_54399_Desc_1 = {
    Text = "Trong chế độ <TutorialHighlight:đối đầu pha>, số lượng thẻ bài tự động rút mỗi lượt cũng là 5 lá, và mặc định <TutorialHighlight:Kích tước tay tối đa> cũng là 10 lá. Có thể thấy số thẻ bài hiện tại và giới hạn tay của chúng ta ở góc dưới bên phải của giao diện chiến đấu, và tình hình của đối phương ở góc trên bên phải. Có thể thay đổi số lượng thẻ bài rút mỗi lượt và giới hạn tay bằng các cách khác."
  },
  Tutorial_54399_Title_1 = {Text = "Tay"},
  Tutorial_54400_Desc_1 = {
    Text = "Trong chế độ <TutorialHighlight:đối đầu pha>, các thể thức tỉnh khác nhau có <TutorialHighlight:định vị> khác nhau, tổng cộng có 5 loại. Cụ thể là <TutorialHighlight:Bảo vệ>, <TutorialHighlight:đấu tranh>, <TutorialHighlight:Luminis>, <TutorialHighlight:Sao dữ>, <TutorialHighlight:Phúc lành>. Khi tiến hành <TutorialHighlight:biên đội>, cần chọn ra 4 thể thức tỉnh với các định vị khác nhau để tạo thành đội hình."
  },
  Tutorial_54400_Title_1 = {Text = "Vị trí"},
  Tutorial_54401_Desc_1 = {
    Text = "Trong chế độ <TutorialHighlight:đối đầu pha - chế độ dự tổ>, nhấp vào \"Bắt đầu phù hợp\"ở góc dưới bên phải của giao diện sẽ đưa bạn vào giao diện biên đội. Cũng có thể tiến hành xây dựng đội hình trước trong <TutorialHighlight:biên đội dự tổ> ở bên trái giao diện."
  },
  Tutorial_54401_Desc_2 = {
    Text = "Biên đội dự kiến hỗ trợ lưu nhiều bộ, góc trên bên trái còn có thể chỉnh sửa tên đội, mỗi đội gồm 4 thân thể được đánh thức, 4 vòng mệnh và 2 lệnh khóa."
  },
  Tutorial_54401_Title_1 = {
    Text = "Biên đội dự tổ"
  },
  Tutorial_54705_Desc_1 = {
    Text = "Trong chế độ <TutorialHighlight:đối đầu pha>, nhấp vào <TutorialHighlight:ảnh đại diện> của bạn, chọn <TutorialHighlight:biểu cảm đối chiến> muốn gửi để bày tỏ tâm ý với đối thủ của bạn!"
  },
  Tutorial_54705_Title_1 = {
    Text = "biểu cảm"
  },
  Tutorial_54706_Desc_1 = {
    Text = "<TutorialHighlight:đối đầu pha> là trò chơi đối kháng giữa hai người, mỗi bên sử dụng đội hình đã được chuẩn bị sẵn để tham gia <TutorialHighlight:đấu đối chiến>, khi tìm trận hệ thống sẽ ghép cặp với đối thủ ngang tầm."
  },
  Tutorial_54706_Desc_2 = {
    Text = "Thông qua đối chiến có thể nhận được <TutorialHighlight:kinh nghiệm dự tổ> và <TutorialHighlight:kinh nghiệm luân tuyển>, dựa trên kinh nghiệm đã nhận được, có thể mở khóa <TutorialHighlight:phần thưởng một lần> trong <TutorialHighlight:cấp độ dự tổ> và <TutorialHighlight:cấp độ luân tuyển>!"
  },
  Tutorial_54706_Desc_3 = {
    Text = "Mỗi mùa giải sẽ nhận được <TutorialHighlight:đầu đề> dựa trên xếp hạng điểm số, khi mùa giải kết thúc sẽ kết toán xếp hạng, và gửi phần thưởng xếp hạng qua hộp thư."
  },
  Tutorial_54706_Title_1 = {
    Text = "Giới thiệu Đối弈"
  },
  Tutorial_74798_Desc_1 = {
    Text = "Các <TutorialHighlight:chương cấp độ> khác nhau sẽ có môi trường khác nhau, thay đổi đáng kể các quy tắc tổng thể và hiệu ứng sáng tạo. Cụ thể, có thể xem bằng cách nhấn vào tab liên quan ở giao diện từng cấp độ."
  },
  Tutorial_74798_Title_1 = {
    Text = "Chương Cấp Độ"
  },
  Tutorial_81370_Desc_1 = {
    Text = "<TutorialHighlight:Quá trình hồi tưởng của Người đánh thức> có thể hoàn trả các tiêu hao phát triển của Người đánh thức."
  },
  Tutorial_81370_Desc_2 = {
    Text = "<TutorialHighlight:Quá trình phát triển> sẽ đặt lại cấp độ, khai sáng, kỹ năng và trạng thái sâu sắc tri thức của Người đánh thức, tất cả nguyên liệu và vàng sẽ được hoàn trả."
  },
  Tutorial_81370_Desc_3 = {
    Text = "<TutorialHighlight:Quá trình khai sáng> sẽ đặt lại trạng thái khai sáng của Người đánh thức, và đặt lại giới hạn cấp độ mà khai sáng mang lại, tất cả nguyên liệu sẽ được hoàn trả."
  },
  Tutorial_81370_Desc_4 = {
    Text = "<TutorialHighlight:Hoàn trả vũng đen> sẽ bao gồm hiệu ứng của \"Quá trình phát triển\", và cũng sẽ hoàn lại Người đánh thức về trạng thái chưa mở khóa."
  },
  Tutorial_81370_Title_1 = {
    Text = "Quá trình phục hồi thân thể thức tỉnh"
  },
  Tutorial_81371_Desc_1 = {
    Text = "<TutorialHighlight:Cấp độ nâng cấp của Người đánh thức> là một trong những cách nhanh chóng nhất để nâng cao thuộc tính của Người đánh thức. Tiêu tốn <TutorialHighlight:Thuốc tri thức> có thể nâng cao cấp độ của Người đánh thức."
  },
  Tutorial_81371_Desc_2 = {
    Text = "Khi thân thể thức tỉnh đạt giới hạn cấp độ, cần thông qua<TutorialHighlight:khai sáng> để nâng cao giới hạn cấp độ, thân thể thức tỉnh ở các cõi khác nhau cần khác nhau về<TutorialHighlight:nguyên liệu nâng cao>."
  },
  Tutorial_81371_Title_1 = {
    Text = "Nâng cấp Thức Tỉnh Thể"
  },
  Tutorial_81372_Desc_1 = {
    Text = "<TutorialHighlight:Khai sáng kích hoạt> có thể tăng cường hiệu ứng thẻ lệnh của thể thức tỉnh một cách mạnh mẽ. Cấp độ khai sáng 7 có thể mở khóa <TutorialHighlight:bùng nổ siêu giới hạn>, khiến thể thức tỉnh nhận được hiệu ứng bổ sung khi bùng nổ điên cuồng. Cấp độ khai sáng 11 và 15 có thể nâng cao giới hạn cấp độ của thể thức tỉnh thêm 5 cấp"
  },
  Tutorial_81372_Title_1 = {
    Text = "Khởi linh tác động"
  }
})
return Text_Tutorial
