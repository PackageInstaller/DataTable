__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_State = readonly({
  State_100291_Desc = {
    Text = "Tất cả tổn hại Aliemus do người đánh thức gây ra tăng 50%."
  },
  State_100291_Name = {Text = "Phơi bày"},
  State_100292_Name = {
    Text = "Bắt đầu lượt"
  },
  State_100293_Desc = {
    Text = "Tất cả thân thể được đánh thức giảm 50% trạng thái điên cuồng."
  },
  State_100293_Name = {
    Text = "Bóng tối của nhân cách"
  },
  State_100295_Name = {
    Text = "Lắng nghe sát thương"
  },
  State_100296_Desc = {
    Text = "Mỗi lớp, sau khi bắt đầu lượt, tất cả các người đánh thức nhận <Energy:5> điên loạn."
  },
  State_100296_Name = {
    Text = "Bản ngã tối tăm"
  },
  State_100297_Desc = {
    Text = "Tất cả những người đánh thức gây ra điên cuồng tăng 50%, khi kết thúc lượt sẽ nhận được lá chắn 20% sức sống tối đa."
  },
  State_100297_Name = {
    Text = "Bức tường tâm lý"
  },
  State_100298_Desc = {
    Text = "Sau khi bắt đầu vòng, bạn mất 10% cuộc sống hiện tại và nhận được [DescArg1] điểm <PowerIconKeywords:sức mạnh>. Tất cả người đánh thức giảm đi 50% aliemus mà chúng gây ra."
  },
  State_100298_Name = {
    Text = "Sự sụp đổ của bức tường"
  },
  State_100299_Desc = {
    Text = "Tôn kính bùng nổ số lượng"
  },
  State_100299_Name = {
    Text = "Tôn kính bùng nổ số lượng"
  },
  State_100302_Name = {
    Text = "Tôn kính Aliemus giám sát"
  },
  State_100307_Desc = {
    Text = "Chỉ có một trong đội ngũ: Người trang bị phát hành Tôn kính sau đó nhận 1 lớp \"Cùng sáng tạo\", trong lượt này, lần tiếp theo Tôn kính của những Người đánh thức khác có thể tiêu hao \"Cùng sáng tạo\", làm tăng tỷ lệ chí mạng của Tôn kính đó lên <WeaponEffect_Num:[StateArg1]%>, và khiến Người đánh thức tiêu hao \"Cùng sáng tạo\" nhận từ người trang bị Tôn kính quay trở lại <WeaponEffect_Num:[StateArg1]%> Aliemus."
  },
  State_100307_WeaponDesc = {
    Text = "Người trang bị nhận 1 tầng \"Đồng sáng tạo\" sau mỗi Bùng nổ Aliemus, trong lượt đó lần Bùng nổ Aliemus của những Người đánh thức khác có thể tiêu hao \"Đồng sáng tạo\", làm tăng tỷ lệ chí mạng của Bùng nổ Aliemus đó <WeaponEffect_Num:[StateArg1]%>, và Người đánh thức tiêu hao \"Đồng sáng tạo\" nhận được <WeaponEffect_Num:[DescArg1]> điểm Aliemus."
  },
  State_100326_Desc = {
    Text = "Với mỗi lớp, sau khi bắt đầu lượt tất cả người đánh thức nhận <Energy:3> điểm Aliemus."
  },
  State_100326_Name = {
    Text = "<DarkEgo:Bản ngã tối tăm>"
  },
  State_100327_Desc = {
    Text = "Tất cả những người đánh thức gây ra điên cuồng tăng 50%, khi kết thúc lượt sẽ nhận được lá chắn 20% sức sống tối đa."
  },
  State_100327_Name = {
    Text = "<MindWall:Rào cản tâm trí>"
  },
  State_100328_Desc = {
    Text = "Tất cả tổn hại Aliemus do người đánh thức gây ra tăng 50%."
  },
  State_100328_Name = {
    Text = "<TrueConfess:Phân Tích>"
  },
  State_100329_Desc = {
    Text = "Tất cả những người đánh thức gây ra điên cuồng giảm 50%, sau khi kết thúc lượt sẽ nhận được 1 lớp \"<DarkEgo: bản ngã tối tăm>\": khi bắt đầu lượt, tất cả những người đánh thức sẽ nhận được 3 điên cuồng."
  },
  State_100329_Name = {
    Text = "<ShadowSelf: Bóng tối nhân cách>"
  },
  State_100330_Desc = {
    Text = "Sau khi bắt đầu vòng, bạn mất 10% cuộc sống hiện tại và nhận được [DescArg1] điểm <PowerIconKeywords:sức mạnh>. Tất cả người đánh thức giảm đi 50% aliemus mà chúng gây ra."
  },
  State_100330_Name = {
    Text = "<BarrierCrash:Đổ vỡ rào cản>"
  },
  State_100395_Name = {
    Text = "Máu Ân Sủng Tạo Cấu+"
  },
  State_100396_Name = {
    Text = "Máu Ân Sủng Tạo Cấu"
  },
  State_100527_Desc = {
    Text = "Khi Pikman kích hoạt hiệu ứng \"Khám phá\", thêm tùy chọn \"Cảm hứng bùng nổ！\": Tiêu hao 1 lớp \"Kính vạn hoa\", chọn tất cả hiệu ứng và nhận 1 lớp \"Cảm hứng\"."
  },
  State_100527_Name = {
    Text = "Cuồng tưởng"
  },
  State_100541_Desc = {
    Text = "Nếu hiện tại sở hữu 10 lớp \"Cảm hứng\", sau khi Pikman phát burst Aliemus sẽ tiêu hao tất cả\"Cảm hứng\"，nhận 1 lớp Kính vạn hoa và làm cho tất cả người đánh thức nhận được 15 điểm Aliemus. Giới hạn của Cảm hứng là 10 lớp, có thể được kế thừa qua trận chiến tiếp theo."
  },
  State_100541_Name = {
    Text = "<Chuangyi:Sáng Tạo>"
  },
  State_100542_Desc = {
    Text = "Khi Pikman kích hoạt hiệu ứng \"Khám phá\", thêm tùy chọn \"Cảm hứng bùng nổ！\": Tiêu hao 1 lớp \"Kính vạn hoa\", chọn tất cả hiệu ứng \"Khám phá\" và nhận 1 lớp \"Cảm hứng\"."
  },
  State_100542_Name = {
    Text = "<Kuangxiang:Mơ Mộng>"
  },
  State_100544_Name = {
    Text = "Slime Ngọt"
  },
  State_100544_WeaponDesc = {
    Text = "Khi trang bị, tăng 6% hiệu quả tạo lá chắn và hồi sức sống. Nếu chỉ số giới vực của người trang bị lớn hơn 50, hiệu quả tạo lá chắn và hồi sức sống sẽ tăng thêm 6%."
  },
  State_100545_Name = {
    Text = "Slime Ngọt"
  },
  State_100545_WeaponDesc = {
    Text = "Khi trang bị, tăng 6% hiệu quả tạo lá chắn và hồi sức sống. Nếu chỉ số giới vực của người trang bị lớn hơn 50, hiệu quả tạo lá chắn và hồi sức sống sẽ tăng thêm 6%."
  },
  State_100558_Desc = {
    Text = "Tỷ lệ chí mạng của phát burst Aliemus của người đánh thức khác tiếp theo trong lượt này tăng [StateArg1]%，sau khi sử dụng nhận được [DescArg1] điểm Aliemus."
  },
  State_100558_Name = {
    Text = "Cùng tạo"
  },
  State_100559_Desc = {
    Text = "Bao gồm các \"Di vật ánh sao\": Đứa trẻ hành xác, Lễ hội mùa xuân, Ổ khóa nặng, Mã não xoắn, Máu tặng thưởng, Cưa gỉ sét, Giấc mơ bằng vàng, Đá cuội nhuốm máu."
  },
  State_100559_Name = {
    Text = "<Chuanggouzaowu:Di Vật của Sáng Tạo>"
  },
  State_100562_Desc = {
    Text = "Thẻ lệnh tiếp theo [Layer] trong lượt này tiêu thụ Số học giảm 2."
  },
  State_100562_Name = {
    Text = "Thực tế, cũng là tưởng tượng"
  },
  State_100564_Desc = {
    Text = "Bao gồm các \"Lời cầu nguyện\" sau: Tính toán, Tài năng, Cuồng hoá, Xúc tác, Sức mạnh thô bạo, Bức tường sắt, Suy thoái, Cảm hứng."
  },
  State_100564_Name = {
    Text = "<Chuanggoukeyin:Ấn Khắc của Sáng Tạo>"
  },
  State_100566_WeaponDesc = {
    Text = "Trước khi đánh ra, thay đổi chỉ số thẻ"
  },
  State_100617_Desc = {
    Text = "Cuối lượt, nhận 1 giới hạn xúc tu."
  },
  State_100617_Name = {
    Text = "niềm ám ảnh bị chôn vùi"
  },
  State_100619_Desc = {
    Text = "Khi lực lượng bị giảm, chỉ giảm 50% lớp lực lượng."
  },
  State_100619_Name = {
    Text = "Suy kiệt kháng cự"
  },
  State_100621_Desc = {
    Text = "Mỗi lớp làm giảm 15% sát thương cơ bản mà người chơi gây ra, có thể hướng dẫn hành trình sau."
  },
  State_100621_Name = {
    Text = "ánh nến yếu ớt"
  },
  State_100623_Desc = {
    Text = "Mỗi lớp làm giảm 30% sát thương cơ bản mà người chơi gây ra, sau khi gây thiệt hại chủ động hoặc thiệt hại xúc tu, giảm [DescArg1] độc dược của chính mình."
  },
  State_100623_Name = {
    Text = "Ánh sáng lạc đường"
  },
  State_100639_Desc = {
    Text = "Thiệt hại xúc tu tạm thời giảm 50%."
  },
  State_100639_Name = {
    Text = "thành phố cổ xưa bị mất"
  },
  State_100644_Desc = {
    Text = "Giảm vĩnh viễn sức mạnh của mục tiêu, nhận được lượng sức mạnh tương đương."
  },
  State_100644_Name = {
    Text = "<TouquKeywords: Trộm cắp vĩnh viễn>"
  },
  State_100647_Desc = {
    Text = "Miễn nhiễm mọi sát thương."
  },
  State_100647_Name = {
    Text = "Miễn nhiễm mọi sát thương."
  },
  State_100694_Desc = {
    Text = "Mỗi lớp làm giảm 30% sát thương cơ bản mà người chơi gây ra, sau khi gây thiệt hại chủ động hoặc thiệt hại xúc tu, giảm thiểu độc dược của chính mình."
  },
  State_100694_Name = {
    Text = "Ánh sáng lạc đường"
  },
  State_116342_Desc = {
    Text = "Sau khi đánh ra lá bài <ErosionColorInkKeywords:Nhận Thức Hỗn Loạn>, khiến \"Họa Sĩ\" nhận 1 tầng <DecayDye:Thuốc Nhuộm Huyễn Thế>."
  },
  State_116342_Name = {
    Text = "Bảng màu dị thường"
  },
  State_116406_Name = {
    Text = "Tiến cấp"
  },
  State_116407_Name = {
    Text = "Trạng thái trống"
  },
  State_116858_Desc = {
    Text = "Trạng thái này sử dụng trọng thương nhân khu vực, giả vờ là một khu vực nhân độc lập.__\"Chỉ dùng cho phát triển\""
  },
  State_116858_Name = {
    Text = "Nếu có trạng thái nào đó, sát thương nhận phải sẽ gấp đôi__\"Chỉ dùng cho phát triển\""
  },
  State_116859_Desc = {
    Text = "Khi vòng tiếp theo bắt đầu, nhận được điểm yếu."
  },
  State_116859_Name = {
    Text = "Khe hở trì hoãn"
  },
  State_116958_Desc = {
    Text = "Sau khi chơi thẻ, sẽ nhận thiệt hại tương ứng với số lớp hiện có."
  },
  State_116958_Name = {
    Text = "<PVPCardLockColour:Khóa thẻ>"
  },
  State_117154_Desc = {
    Text = "Hiệu ứng này chỉ có thể kích hoạt 1 lần trên tất cả các cơ thể thức tỉnh trong đội, không thể kích hoạt lại."
  },
  State_117154_Name = {
    Text = "<TeamUnique: Đội duy nhất>"
  },
  State_117212_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>: Trước \"Kỹ Năng\" và khi kết thúc lượt, áp <Damage:[Damage:StateArg1]> lớp <PVPCorrosionKeywords:Dấu ấn tội lỗi> lên kẻ địch có <HPAndShieldMax:Sinh lực và lá chắn cao nhất>."
  },
  State_117212_Name = {
    Text = "Bốt Lợi Khắc Tư"
  },
  State_117213_Desc = {
    Text = "<PVPWeaponKeywords:Bánh xe định mệnh>:\"Kỹ năng\" và kết thúc lượt, gây sát thương [StateArg1] <PVPfengsuoKeywords:Ngăn chặn bùng nổ> cho kẻ địch có điên loạn cao nhất."
  },
  State_117213_Name = {
    Text = "Polux SR (văn bản tạm thời)"
  },
  State_117346_Desc = {
    Text = "Sát thương do Polux gây ra sẽ kèm theo [Layer]% chảy máu."
  },
  State_117346_Name = {
    Text = "Dấu ấn tội lỗi"
  },
  State_117355_Desc = {
    Text = "Thẻ lệnh mà Polux phát ra có hiệu lực 2 lần."
  },
  State_117355_Name = {
    Text = "Định Thế Đọa Thiên"
  },
  State_117357_Desc = {
    Text = "Đội ngũ duy nhất: \"D-vết\" và \"Di Tích Tro Tàn\" sau khi làm mới sẽ khiến người trang bị nhận được <WeaponEffect_Num:[StateArg1]> điểm điên loạn."
  },
  State_117357_WeaponDesc = {
    Text = "\"D-vết\" và \"Di tích tro tàn\" làm cho trang bị nhận được <WeaponEffect_Num:[StateArg1]> điểm điên loạn sau khi được làm mới."
  },
  State_117358_Desc = {
    Text = "Mỗi lớp làm tăng 1% sát thương chảy máu do Polux gây ra."
  },
  State_117358_Name = {
    Text = "<ZuiyinKeywords:Dấu ấn tội lỗi>"
  },
  State_117744_Desc = {
    Text = "Mất [Layer] <MaxHPKeywords:Sinh lực tối đa>, khi bị xóa bỏ sẽ không hoàn lại sinh lực tối đa đã mất, khi kích hoạt sẽ nhận [Layer] điểm Sát Thương Thuần Túy, vĩnh viễn."
  },
  State_117744_Name = {
    Text = "Dấu ấn tội lỗi"
  },
  State_117745_Desc = {
    Text = "Mất đi số lớp tương đương với <MaxHPKeywords:Sinh lực tối đa> khi áp dụng, không hoàn lại sinh lực tối đa đã mất khi bị giải trừ, nhận Sát Thương Thuần Túy tương đương với số lớp khi kích hoạt, vĩnh viễn."
  },
  State_117745_Name = {
    Text = "<PVPCorrosionKeywords:Vết tội>"
  },
  State_117755_Desc = {
    Text = "Không thể thực hiện bất kỳ hành động nào trước khi kết thúc lượt."
  },
  State_117755_Name = {Text = "Hôn mê"},
  State_117756_Desc = {
    Text = "Không thể thực hiện bất kỳ hành động nào trước khi kết thúc lượt."
  },
  State_117756_Name = {Text = "Hôn mê"},
  State_117776_Desc = {
    Text = "Sát thương cuối cùng và Lá chắn tăng cường của [Layer] thẻ lệnh trong lượt này tăng [StateArg1]%."
  },
  State_117776_Name = {
    Text = "Ngọn lửa thần thánh"
  },
  State_117777_Desc = {
    Text = "Độc đáo của đội: Thẻ của người trang bị được tăng sát thương cơ bản và sát thương chí mạng <WeaponEffect_Num:[StateArg1]%>. Khi bắt đầu lượt và sau khi người trang bị phát động bùng nổ điên loạn, nhận 1 tầng \"Tâm hỏa\", khi người trang bị chơi thẻ lệnh trong lượt này tiêu hao 1 tầng \"Tâm hỏa\", tăng sát thương cuối cùng và khiên lên <WeaponEffect_Num:[StateArg2]%>. Trong vòng siêu chiều, thay đổi thành nhận \"Thần diệm\", hiệu ứng được nhân đôi."
  },
  State_117777_WeaponDesc = {
    Text = "Sát thương cơ bản và sát thương chí mạng của thẻ bài trang bị tăng <WeaponEffect_Num:[StateArg1]%>. Khi bắt đầu lượt và sau khi trang bị phát động điên loạn bùng nổ sẽ nhận được 1 tầng tâm hỏa, khi trang bị chơi thẻ lệnh trong lượt này sẽ tiêu tốn 1 tầng \"tâm hỏa\", khiến lượng sát thương cuối và khiên tăng <WeaponEffect_Num:[StateArg2]%>. Trong vòng siêu chiều thì sẽ được thay đổi thành nhận \"Thần hỏa\", hiệu quả gấp đôi."
  },
  State_117778_Desc = {
    Text = "Sát thương cuối cùng và Lá chắn tăng cường của [Layer] thẻ lệnh trong lượt này tăng [StateArg1]%."
  },
  State_117778_Name = {Text = "Lửa tâm"},
  State_117779_Desc = {
    Text = "Độc đáo của đội: Trong vòng siêu chiều, người trang bị nhận 3 tầng \"Tâm hỏa\", khi người trang bị chơi thẻ lệnh trong lượt này tiêu hao 1 tầng, tăng sát thương cuối cùng và khiên lên <WeaponEffect_Num:[StateArg1]%>."
  },
  State_117779_WeaponDesc = {
    Text = "Người trang bị vòng siêu chiều nhận được 3 tầng \"Lửa trái tim\", khi người trang bị chơi thẻ lệnh trong vòng này sẽ tiêu tốn 1 tầng, làm tăng sát thương cuối cùng và Khiên của họ <WeaponEffect_Num:[StateArg1]%>."
  },
  State_117851_Desc = {
    Text = "Mỗi lá thẻ lệnh của Polux sẽ được tăng thêm 50% hiệu ứng \"Cứu rỗi khổ đau\", kéo dài trong [Layer] lượt."
  },
  State_117851_Name = {
    Text = "Ánh Sáng Rạch Toạc Trời Đêm"
  },
  State_117853_Desc = {
    Text = "[Layer] thẻ lệnh tiếp theo Pollux chơi trong lượt này tăng thương lên [DescArg1], lá chắn tăng cường [DescArg2], nhận 10 điểm Điên loạn."
  },
  State_117853_Name = {
    Text = "Cứu rỗi bằng đau khổ"
  },
  State_117869_Desc = {
    Text = "Mỗi lần phát động bùng nổ điên loạn sẽ tăng 1 lớp \"Gọi\", mỗi lớp \"Gọi\" sẽ nhận được [DescArg1] điểm sức mạnh, tối đa là 5 lớp."
  },
  State_117869_Name = {
    Text = "Đại linh mục thâm hải"
  },
  State_117870_Desc = {
    Text = "Sau khi chết, kẻ giết sẽ hồi phục 20% sức sống đã mất."
  },
  State_117870_Name = {
    Text = "Sashimi cá ngon"
  },
  State_117875_Desc = {
    Text = "Nếu phía sau có vị trí trống, thì sau khi hành động sẽ mất 1 lớp, triệu hồi 1 con \"Cá con\" có gắn \"Sashimi ngon\"."
  },
  State_117875_Name = {
    Text = "Khế ước hỗ trợ: Đàn cá"
  },
  State_117876_Desc = {
    Text = "Hiệu ứng <WeaknessIconKeywords:suy nhược>, <FragileIconKeywords:mong manh>, <HeavyInjuryKeywords:thiệt hại nặng> được tăng lên 50%."
  },
  State_117876_Name = {
    Text = "Suy nhược&Mong manh&Thương nặng thêm"
  },
  State_117880_Desc = {
    Text = "Trong trận chiến này, \"Đàn cá bay\" sẽ kích hoạt thêm 1 lần sau."
  },
  State_117880_Name = {
    Text = "Những đàn cá nhảy kích hoạt thêm"
  },
  State_117883_Desc = {
    Text = "Khi đạt được 5 tầng, ngay lập tức phong ấn toàn bộ thể thức tỉnh, hãy thay đổi ý định thành:\"Vinh quang của Lemuria! +\"."
  },
  State_117883_Name = {Text = "Gọi"},
  State_117885_Desc = {
    Text = "Khi bị ảnh hưởng bởi hiệu ứng sức mạnh giảm, cũng sẽ gây ra hiệu ứng sức mạnh giảm tương đương cho người áp dụng."
  },
  State_117885_Name = {
    Text = "Răng trả răng"
  },
  State_117889_Desc = {
    Text = "Khi xuất hiện, sức sống tối đa của bản thân tăng 10% và tăng cường [DescArg1] điểm <PowerIconKeywords:lực lượng> cho các đồng minh khác, khiến cho hiệu ứng tăng sức sống và nhận lực lượng của <FishLeapWords:Sức mạnh trật tự bầy đàn> trong trận đấu này được kích hoạt thêm 1 lần."
  },
  State_117889_Name = {
    Text = "Sức mạnh trật tự bầy đàn"
  },
  State_118112_Desc = {
    Text = "Giới hạn sát thương đơn lần nhận được là [DescArg1] điểm, sẽ bị loại bỏ khi sinh lực dưới 50%."
  },
  State_118112_Name = {
    Text = "Ngưỡng chịu đau I"
  },
  State_118113_Desc = {
    Text = "Sau khi nhận sát thương chủ động và mất sinh lực, nhận được lá chắn tương đương với 15% sinh lực đã mất và <AlertIconKeywords:giữ mình tạm thời> tương đương 5% sinh lực đã mất."
  },
  State_118113_Name = {
    Text = "Đặc tính thân mềm I"
  },
  State_118114_Desc = {
    Text = "Sau khi nhận sát thương chủ động và mất sinh lực, nhận được lá chắn tương đương với 35% sinh lực đã mất và <AlertIconKeywords:giữ mình tạm thời> tương đương 10% sinh lực đã mất."
  },
  State_118114_Name = {
    Text = "Đặc tính thân mềm III"
  },
  State_118115_Desc = {
    Text = "Nếu hàng trước có vị trí trống, thì sau khi hành động sẽ mất 1 lớp, triệu hồi 1 \"Phân thể biển sâu\"."
  },
  State_118115_Name = {
    Text = "Khế ước hỗ trợ: Phân thể biển sâu"
  },
  State_118116_Desc = {
    Text = "Giới hạn sát thương nhận được trong 1 lần là [DescArg1] điểm, sẽ bị loại bỏ khi sinh lực dưới 50%."
  },
  State_118116_Name = {
    Text = "Ngưỡng chịu đau II"
  },
  State_118117_Desc = {
    Text = "Giới hạn sát thương nhận được mỗi lần là [DescArg1] điểm, sẽ bị loại bỏ khi sinh lực thấp hơn 50%."
  },
  State_118117_Name = {
    Text = "Ngưỡng chịu đau III"
  },
  State_118118_Desc = {
    Text = "Nhận 1 râu chạm với <TentacleInjurieIconKeywords:thương tổn xúc tu> là [TentaclePower:DescArg1] và giới hạn 5 râu chạm. Cuối lượt, nhận 1 râu chạm. Hiệu ứng giảm sức mạnh nhận được giảm 50%."
  },
  State_118118_Name = {
    Text = "Râu chạm tập hợp"
  },
  State_118119_Desc = {
    Text = "Sau khi nhận sát thương chủ động và mất sinh lực, nhận được lá chắn tương đương với 25% sinh lực đã mất và <AlertIconKeywords:giữ mình tạm thời> tương đương 5% sinh lực đã mất."
  },
  State_118119_Name = {
    Text = "Đặc tính thân mềm II"
  },
  State_118319_Desc = {
    Text = "Giới hạn sát thương nhận được trong một lần là [DescArg1] điểm, sẽ bị loại bỏ khi sinh lực dưới 50%."
  },
  State_118319_Name = {
    Text = "Hạn chế thương của Khiên Hải Uyên"
  },
  State_118320_Name = {
    Text = "Số lần kháng cự suy kiệt tạm thời"
  },
  State_118321_Name = {
    Text = "Số lần kháng cự suy kiệt"
  },
  State_118322_Name = {
    Text = "Chuẩn bị dấu hiệu triệu hồi"
  },
  State_118323_Desc = {
    Text = "Đã kích hoạt những đàn cá nhảy"
  },
  State_118323_Name = {
    Text = "Dấu hiệu xuất hiện của những đàn cá nhảy"
  },
  State_118324_Desc = {
    Text = "Mỗi lần gây 1 điểm thương, tạo ra 1 râu chạm tạm thời"
  },
  State_118324_Name = {
    Text = "Ân điển thần linh"
  },
  State_118325_Desc = {
    Text = "Gây thương không bị chặn sẽ xáo trộn [DescArg1] lá ngạt thở vào đỉnh rút bài từ bộ bài"
  },
  State_118325_Name = {
    Text = "Người đầu rắn thế giới mới rung động"
  },
  State_118656_Desc = {
    Text = "Đánh ra thẻ bài sẽ chịu [StateArg1] điểm thương và loại bỏ 1 lớp. Khi hết lớp, ấp nở một \"Sinh Vật Trong Biển\" yếu hơn. Nếu vẫn còn trạng thái bị ký sinh khi kết thúc lượt, ấp nở một \"Sinh Vật Trong Biển\" có sức sống tăng dần theo số lớp."
  },
  State_118656_Name = {
    Text = "Bị ký sinh nhiều lần"
  },
  State_118657_Desc = {
    Text = "Đánh ra thẻ bài sẽ chịu [StateArg1] điểm thương và loại bỏ 1 lớp. Khi hết lớp, ấp nở một \"Sinh Vật Trong Biển\" yếu hơn. Nếu vẫn còn trạng thái bị ký sinh khi kết thúc lượt, ấp nở một \"Sinh Vật Trong Biển\" có sức sống tăng dần theo số lớp."
  },
  State_118657_Name = {
    Text = "Bị ký sinh lại"
  },
  State_118659_Desc = {
    Text = "Đánh ra thẻ bài sẽ chịu [StateArg1] điểm thương và loại bỏ 1 lớp. Khi hết lớp, ấp nở một \"Sinh Vật Trong Biển\" yếu hơn. Nếu vẫn còn trạng thái bị ký sinh khi kết thúc lượt, ấp nở một \"Sinh Vật Trong Biển\" có sức sống tăng dần theo số lớp."
  },
  State_118659_Name = {
    Text = "Ký sinh trùng"
  },
  State_118663_Name = {
    Text = "Nghe ý đồ Người đầu rắn thế giới mới"
  },
  State_118669_Name = {
    Text = "Khởi tạo Người đầu rắn thế giới mới"
  },
  State_118670_Desc = {
    Text = "Kiểm tra xem có kháng cự suy kiệt hay không"
  },
  State_118670_Name = {
    Text = "Kiểm tra kháng cự suy kiệt"
  },
  State_118671_Desc = {
    Text = "Kiểm tra hành vi suy kiệt của người chơi"
  },
  State_118671_Name = {
    Text = "Nghe kháng cự suy kiệt"
  },
  State_118672_Name = {
    Text = "Nghe ý đồ Người đầu rắn thế giới mới đang hồi chiêu"
  },
  State_118741_Name = {
    Text = "Xóa bỏ râu chạm tạm thời"
  },
  State_118743_Name = {
    Text = "Chuẩn bị triệu hồi vị trí trước cần dấu hiệu triệu hồi"
  },
  State_118759_Name = {
    Text = "Số lượng xúc tu vĩnh viễn hiện tại của quái vật"
  },
  State_118760_Name = {
    Text = "Giới hạn râu chạm vĩnh viễn của quái vật"
  },
  State_118762_Name = {
    Text = "gợi ý thối rữa lần đầu"
  },
  State_118763_Name = {
    Text = "gợi ý lần đầu độc tố thần kinh xuyên máu"
  },
  State_118764_Name = {
    Text = "gợi ý thổi tắt lời nguyền lần đầu"
  },
  State_118766_Name = {
    Text = "BOSS Bạch tuộc vòng xanh có ý định theo dõi"
  },
  State_118769_Name = {
    Text = "Gợi ý đèn cầm tay bạc tâm"
  },
  State_118771_Name = {
    Text = "gợi ý thử thách lần đầu"
  },
  State_118772_Name = {
    Text = "Lời nhắc lần đầu bầy rắn xé toạc"
  },
  State_118935_Name = {
    Text = "Nghe ý định quái vật Muphí"
  },
  State_118938_Desc = {
    Text = "\"Quý cô biển sâu\"đã thức tỉnh, lượng lá chắn tạo ra được tăng đáng kể!"
  },
  State_118938_Name = {
    Text = "sáng tạo"
  },
  State_118943_Desc = {
    Text = "Sát thương nhận trong lượt bản thân được nhân đôi. Khi bản thân mất sinh lực, mất số lớp tương đương. Khi số lớp là 0, giảm vĩnh viễn 1 râu chạm và đặt lại số lớp, tối thiểu là 1 râu."
  },
  State_118943_Name = {
    Text = "Sự hy sinh của Thần Mẫu"
  },
  State_118973_Name = {
    Text = "quản lý sự phản loạn kìm nén"
  },
  State_119051_Desc = {
    Text = "Khi kết thúc lượt, xảy ra kích hoạt, khi kích hoạt nhận Sát Thương Thuần Túy bằng số lớp hiện có và xóa một nửa số lớp, không thể tẩy sáng."
  },
  State_119051_Name = {
    Text = "<PVPSacrificeKeyWords:Hy sinh>"
  },
  State_119052_Desc = {
    Text = "Nhận hy sinh tương đương với sát thương [Layer]% sau khi nhận sát thương chủ động."
  },
  State_119052_Name = {
    Text = "Nghi lễ giáng sinh"
  },
  State_119053_Desc = {
    Text = "Khi kết thúc lượt, xảy ra kích hoạt, khi kích hoạt nhận [Layer] điểm Sát Thương Thuần Túy và xóa một nửa số lớp, không thể tẩy sáng."
  },
  State_119053_Name = {
    Text = "hiến tế"
  },
  State_119058_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>: Cuối lượt, áp [StateArg1] <PVPSacrificeKeyWords:hiến tế> lên kẻ địch có ít hiến tế nhất, lặp lại [StateArg2] lần. Toàn bộ đồng minh không còn bị ảnh hưởng bởi hiệu ứng giảm <PVPCapKeywords:Giới hạn Điểm tính toán>."
  },
  State_119058_Name = {
    Text = "Giấc ngủ trong bóng tối"
  },
  State_119059_Desc = {
    Text = "<PVPWeaponKeywords:Bánh xe định mệnh>:Sau khi \"Bùng nổ điên loạn\", toàn bộ kẻ thù trong vòng này sau khi nhận sát thương chủ động sẽ nhận được sát thương [StateArg1]% của Hy sinh."
  },
  State_119059_Name = {
    Text = "Độc tố vòng xanh"
  },
  State_119060_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>:\"đánh\" sát thương tăng [StateArg1]%, bất kỳ đồng minh nào sử dụng \"đánh\" sau đó rút [StateArg3] lá bài, mỗi lượt tối đa kích hoạt [StateArg2] lần(hiện tại đã kích hoạt [DescArg1] lần)."
  },
  State_119060_Name = {
    Text = "Cuồng sát đến tận cùng thế giới"
  },
  State_119061_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>: Tất cả đồng đội \"đánh\" sát thương tăng [StateArg1]%."
  },
  State_119061_Name = {
    Text = "Ngọn đèn lý trí"
  },
  State_119063_Desc = {
    Text = "Khi đạt được 5 tầng, hãy thay đổi ý định thành:\"Vinh quang của Lemuria!\"."
  },
  State_119063_Name = {Text = "Gọi"},
  State_119075_Desc = {
    Text = "Thân thể được đánh thức này chưa thức tỉnh… Khi sắp ngã gục sẽ thức tỉnh, hồi phục sức sống và bắt đầu chiến đấu với hình thái thật sự."
  },
  State_119075_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_119076_Desc = {
    Text = "Nếu hàng đầu có vị trí trống, thì sau hành động sẽ mất 1 lớp, ngẫu nhiên triệu hồi 1 \"thể thức tỉnh Lemuria\"."
  },
  State_119076_Name = {
    Text = "Khế ước hỗ trợ: Lemuria"
  },
  State_119077_Desc = {
    Text = "\"Gọi\"đạt đến 5 cấp độ thì lập tức phong ấn tất cả thể thức tỉnh."
  },
  State_119077_Name = {
    Text = "Miriam Thức tỉnh!"
  },
  State_119077_WeaponDesc = {
    Text = "Bắt đầu lượt tiếp theo nhận được lá chắn bằng với sức sống đã mất trong lượt trước."
  },
  State_119080_Desc = {
    Text = "Khi giải phóng \"Ký ức hỗn mang\" hoặc \"Bình minh chưa đến của sự lãng quên\", mệnh lệnh được chọn sẽ có hiệu lực thêm 1 lần."
  },
  State_119080_Name = {
    Text = "Từ sự lãng quên"
  },
  State_119082_Desc = {
    Text = "Sau mỗi lần thể thức tỉnh giải phóng cơn thịnh nộ bùng phát, điên cuồng cơ bản của nó tăng thêm 10 điểm."
  },
  State_119082_Name = {
    Text = "Suy kiệt điên cuồng"
  },
  State_119083_Desc = {
    Text = "Khi Thẻ lệnh được lấy ra từ siêu chiều không gian, giá trị điểm tính toán—1."
  },
  State_119083_Name = {
    Text = "Con đường cuối cùng của bên kia"
  },
  State_119084_Desc = {
    Text = "Mỗi lần phát động Mật lệnh, làm tăng Năng lượng chìa khóa bạc cần thiết thêm 100 điểm."
  },
  State_119084_Name = {
    Text = "Chìa khóa bạc dao động"
  },
  State_119085_Desc = {
    Text = "Sau khi sử dụng lò nung đỏ thẫm, biến 1 phôi thai thành con thánh thiện, thời gian hồi 3 lượt."
  },
  State_119085_Name = {
    Text = "Nuôi dưỡng đỏ tươi"
  },
  State_119086_Desc = {
    Text = "Sức mạnh sinh sản đang làm mát, còn lại [Layer] lượt."
  },
  State_119086_Name = {
    Text = "Sức mạnh sinh sản - làm mát"
  },
  State_119104_Desc = {
    Text = "Vào đầu lượt, nhận được [DescArg1] lớp \"Mệnh khế\"."
  },
  State_119104_Name = {
    Text = "Hải tế điển nghi"
  },
  State_119105_Desc = {
    Text = "Sau khi chết, mất tất cả\"Mệnh khế\". Mỗi lớp hồi phục 1% sinh lực tối đa và làm tăng thương tổn xúc tu 1%."
  },
  State_119105_Name = {
    Text = "Mệnh khế"
  },
  State_119106_Name = {
    Text = "Nghe ý đồ quái vật Điên Vọng Muphí"
  },
  State_119107_Name = {
    Text = "Quản lý trật tự Thần Quốc"
  },
  State_119108_Desc = {
    Text = "Mỗi khi mất sinh lực, mỗi 1 lớp nhận được 1% <SacrificeKeyWord:hiến tế> của sinh lực đã mất."
  },
  State_119108_Name = {
    Text = "Nghi lễ giáng sinh"
  },
  State_119109_Desc = {
    Text = "Khi nhận sát thương từ nguồn khác ngoài <SacrificeKeyWord:hiến tế>, mất lượng \"Trật tự Thần quốc\" tương đương, và nhận được <SacrificeKeyWord:hiến tế> bằng 50% sát thương. Khi số lớp là 0, nhận 1 lớp \"Mệnh khế\" và đặt lại số lớp."
  },
  State_119109_Name = {
    Text = "Trật tự Thần Quốc"
  },
  State_119132_Desc = {
    Text = "Trong lượt này, sát thương gây ra bởi \"Đánh\" tăng lên [Layer]%."
  },
  State_119132_Name = {
    Text = "Cú đánh tăng cường"
  },
  State_119134_Name = {
    Text = "Gợi ý lần đầu người khởi xướng hư vọng"
  },
  State_119359_Name = {
    Text = "Đếm nghi thức chìa khóa bạc"
  },
  State_119362_Name = {
    Text = "Tiến hành nghi lễ"
  },
  State_119363_Name = {
    Text = "Sở hữu Thẻ"
  },
  State_119364_Name = {
    Text = "Đếm nghi thức điên loạn"
  },
  State_119365_Desc = {
    Text = "Tất cả thể thức tỉnh gây ra hồi phục sinh lực và khiên tăng 40%."
  },
  State_119365_Name = {
    Text = "Bình tĩnh như thường"
  },
  State_119366_Desc = {
    Text = "Trở lại tay sau khi bị bỏ rơi"
  },
  State_119366_Name = {
    Text = "Trở lại tay sau khi bị bỏ rơi"
  },
  State_119367_Name = {
    Text = "Đếm nghi thức sinh mệnh"
  },
  State_119368_Desc = {
    Text = "Bắt đầu mỗi lượt nhận 500 điểm năng lượng chìa khóa bạc."
  },
  State_119368_Name = {
    Text = "Nhìn rõ như lòng bàn tay"
  },
  State_119369_Desc = {
    Text = "Tất cả thể thức tỉnh gây điên loạn tăng 50%."
  },
  State_119369_Name = {
    Text = "William ra lệnh"
  },
  State_119370_Name = {Text = "Di vật"},
  State_119373_Name = {
    Text = "Kẻ địch áp dụng hy sinh"
  },
  State_119567_Name = {
    Text = "Hoàn thành nghi thức"
  },
  State_119568_Desc = {
    Text = "Tăng sát thương nhận được [Layer] điểm."
  },
  State_119568_Name = {
    Text = "Cú đánh sâu thêm"
  },
  State_119583_Desc = {
    Text = "<PVPWeaponKeywords:Bánh xe định mệnh>:Trước khi \"Đánh\", trước khi \"Kỹ năng\", trước khi \"Bùng nổ điên loạn\" tạm thời<StrongEffectKeywords:sự khuếch đại> +[StateArg1], mỗi vòng chỉ có thể kích hoạt mỗi hiệu ứng một lần."
  },
  State_119583_Name = {
    Text = "Chúng ta cuối cùng sẽ gặp lại nhau"
  },
  State_119588_Name = {
    Text = "Huyết nhục cd"
  },
  State_119589_Name = {
    Text = "Siêu chiều cd"
  },
  State_119590_Desc = {
    Text = "Đội duy nhất: Sau khi chủ động chuyển Tư thế râu chạm, sử dụng Lò nung đỏ thẫm, giải phóng \"Sự diệt vong\", rút 1 thẻ lệnh của Người trang bị, mỗi hiệu ứng hồi chiêu 3 lượt riêng. tỷ lệ đồng điều nhận được khi tất cả Thể thức tỉnh khám phá tăng lên <WeaponEffect_Num:[StateArg1]%>."
  },
  State_119590_WeaponDesc = {
    Text = "Chuyển đổi tư thế râu chạm chủ động(còn lại [DescArg1] lượt hồi chiêu), sử dụng Lò Nung Đỏ(còn lại [DescArg2] lượt hồi chiêu), sau khi phát động \"Diệt Vong\"(còn lại [DescArg3] lượt hồi chiêu), rút 1 thẻ lệnh của người trang bị, mỗi hiệu ứng hồi chiêu 3 lượt. Sau khi hoàn thành khám phá, tỷ lệ đồng bộ mà tất cả thân thể được đánh thức nhận được tăng lên <WeaponEffect_Num:[StateArg1]%>."
  },
  State_119591_Name = {
    Text = "Cd hải vực"
  },
  State_119741_Desc = {
    Text = "Tất cả thể thức tỉnh nhận được hiệu ứng sức mạnh giảm 50%."
  },
  State_119741_Name = {
    Text = "Lời nguyền thánh tượng: Nỗi thương xót của quốc gia suy tàn"
  },
  State_119742_Desc = {
    Text = "Bắt đầu mỗi lượt hồi phục 15% sinh lực đã mất."
  },
  State_119742_Name = {
    Text = "Thánh tượng ban phước: Giấc mơ vĩnh cửu"
  },
  State_119743_Desc = {
    Text = "Tất cả thể thức tỉnh hồi phục sinh lực giảm 50%."
  },
  State_119743_Name = {
    Text = "Lời nguyền thánh tượng: Phá diệt chi hận"
  },
  State_119744_Desc = {
    Text = "\"Thánh tượng nguyền rủa: Hận thù diệt vong\" không còn hiệu lực 1 lượt."
  },
  State_119744_Name = {
    Text = "Miễn dịch thánh tượng chú nguyền: sự căm ghét hủy diệt"
  },
  State_119746_Name = {
    Text = "Số lần mất khối khóa Abyss"
  },
  State_119747_Desc = {
    Text = "Sẽ không bị sát thương, kéo dài 1 vòng."
  },
  State_119747_Name = {
    Text = "Chìa khóa bạc, chỉ lối đi phía trước"
  },
  State_119748_Desc = {
    Text = "\"Nguyền rủa thánh tượng: Nỗi buồn suy tàn\" không còn hiệu lực trong 1 lượt."
  },
  State_119748_Name = {
    Text = "Lời nguyền thánh tượng miễn dịch: Nỗi buồn suy vong"
  },
  State_119749_Desc = {
    Text = "Vào đầu vòng của người giữ gìn, áp dụng 1 lớp <SlowIconKeywords:trì trệ> lên tay tương đương với số lớp của \"<Abyssallock:Giấc mơ giam cầm>\"."
  },
  State_119749_Name = {
    Text = "Gông cùm giấc mơ"
  },
  State_119750_Name = {
    Text = "Ý định lắng nghe từ màn trời"
  },
  State_119751_Name = {
    Text = "Khiên tái hiện giải phóng dấu hiệu"
  },
  State_119752_Desc = {
    Text = "Bắt đầu mỗi lượt nhận <PowerIconKeywords: sức mạnh> bằng 5% sinh lực tối đa, tỉ lệ chí mạng tạm thời +25%."
  },
  State_119752_Name = {
    Text = "Thánh tượng ban phước: Giấc mơ của sức mạnh"
  },
  State_119753_Name = {
    Text = "Đếm số cơn sóng từ vực sâu u ám"
  },
  State_119754_Desc = {
    Text = "Tất cả thân thể được đánh thức giảm 50% trạng thái điên cuồng."
  },
  State_119754_Name = {
    Text = "Lời nguyền thánh tượng: Tiếng thở dài ngốc nghếch"
  },
  State_119755_Name = {
    Text = "Đếm số lần chết"
  },
  State_119756_Desc = {
    Text = "\"Lời nguyền thánh tượng: Thở dài ngu dại\" không còn hiệu lực trong 1 lượt."
  },
  State_119756_Name = {
    Text = "Nguyên hình thánh: Tiếng thở dài của kẻ ngu dại"
  },
  State_119757_Desc = {
    Text = "Tại lượt bắt đầu của Người Giữ Gìn, áp dụng 1 lớp <SlowIconKeywords:trì trệ> lên số lớp tay bài tương đương với \"<Abyssallock:Xiềng xích giấc mơ>\". Mỗi lần \"Màn che khu vui chơi\" bị sát thương chủ động phá vỡ sẽ giảm 1 lớp, và khiến thể thức tỉnh bị phá vỡ\"phong ấn hoàn toàn\" trong 1 lượt."
  },
  State_119757_Name = {
    Text = "Gông cùm giấc mơ"
  },
  State_119758_Desc = {
    Text = "Bắt đầu mỗi lượt tất cả thể thức tỉnh được 10 điểm điên loạn."
  },
  State_119758_Name = {
    Text = "Thánh tượng ban phước: Giấc mơ của tri thức"
  },
  State_119760_Name = {
    Text = "Giám sát cái chết"
  },
  State_119789_Desc = {
    Text = "Khi bắt đầu vòng, hồi phục [Layer] điểm sinh lực."
  },
  State_119789_Name = {
    Text = "Hoa Bùn Lầy"
  },
  State_119837_Desc = {
    Text = "Lá bài lệnh tiếp theo mà Ramona đánh ra trong lượt này sẽ có hiệu lực 2 lần."
  },
  State_119837_Name = {
    Text = "Một lần nữa nắm tay nhau"
  },
  State_119847_Desc = {
    Text = "Trước khi chơi, thay đổi Điểm tính toán thẻ bài.__\"Chỉ dùng cho phát triển\""
  },
  State_119847_Name = {
    Text = "Trước khi đánh ra, thay đổi chỉ số thẻ__\"Chỉ dùng cho phát triển\""
  },
  State_119928_Desc = {
    Text = "Sau khi sử dụng, hiệu ứng sẽ kích hoạt thêm [StateArg1] lần, <DepleteIconKeywords:tiêu thụ>. <RippleKeywords:Hiệu ứng gợn sóng>: Rút 2 lá bài."
  },
  State_119928_Name = {
    Text = "<Rune_20:Tiếng vọng của vực biển>"
  },
  State_119958_Desc = {
    Text = "Sau khi chết lập tức triệu hồi một \"ngư đoàn\" ngẫu nhiên, giảm \"vừng vương\" 1 lớp."
  },
  State_119958_Name = {
    Text = "Dòng chảy cá"
  },
  State_119959_Desc = {
    Text = "Sau khi chết lập tức triệu hồi một \"thai quần\" ngẫu nhiên, giảm \"sinh sinh bất tận\" 1 lớp."
  },
  State_119959_Name = {
    Text = "Sinh sôi nảy nở"
  },
  State_119960_Desc = {
    Text = "Sát thương chủ động và thương tổn xúc tu gây ra giảm 35%, xóa khi Sinh lực hiện tại của người chơi cao hơn 50%."
  },
  State_119960_Name = {
    Text = "<PurpleKeyWord:Thối rữa>"
  },
  State_120215_Desc = {
    Text = "Tại lượt bắt đầu của Người Giữ Gìn, áp dụng 1 lớp <SlowIconKeywords:trì trệ> lên số lớp tay bài tương đương với \"<Abyssallock:Xiềng xích giấc mơ>\". Mỗi lần \"Màn che khu vui chơi\" bị sát thương chủ động phá vỡ sẽ giảm 1 lớp, và khiến thể thức tỉnh bị phá vỡ\"phong ấn hoàn toàn\" trong 1 lượt."
  },
  State_120215_Name = {
    Text = "Khóa của chiều sâu"
  },
  State_120216_Desc = {
    Text = "Vào đầu vòng của người giữ gìn, áp dụng 1 lớp <SlowIconKeywords:trì trệ> lên tay tương đương với số lớp của \"<Abyssallock:Khóa vực thẳm>\"."
  },
  State_120216_Name = {
    Text = "Khóa của chiều sâu"
  },
  State_120218_Name = {
    Text = "Cuối lượt chọn hỗ trợ Murphy"
  },
  State_120222_Name = {
    Text = "Vòng bắt đầu chọn đảo ngược lời nguyền"
  },
  State_120292_Name = {
    Text = "Đau không được chấp nhận"
  },
  State_120293_Desc = {
    Text = "Kết thúc lượt, hồi phục [Layer] điểm sức sống."
  },
  State_120293_Name = {
    Text = "Đau không được chấp nhận"
  },
  State_120312_Desc = {
    Text = "Sau khi chết lập tức triệu hồi một \"ngư vương\" ngẫu nhiên, giảm \"vừng vương\" 1 lớp."
  },
  State_120312_Name = {
    Text = "Dòng chảy cá"
  },
  State_120320_Desc = {
    Text = "Mỗi lớp làm cho lần áp dụng \"nghi thức tái sinh\" tiếp theo của \"nữ hoàng hư ảo\" tăng 20%, tối đa chồng chất 5 lớp, khi đã đầy 5 lớp thì số lần sát thương của \"nữ hoàng hư ảo\" kép lên."
  },
  State_120320_Name = {
    Text = "Mệnh khế"
  },
  State_120321_Desc = {
    Text = "Mỗi lớp khiến khi chịu Sát thương chủ động hoặc thương tổn xúc tu sẽ kèm theo hiến tế 1% sát thương, xóa khi kết thúc lượt, giới hạn 75 lớp."
  },
  State_120321_Name = {
    Text = "<DwmofeiKeywords:Lễ sinh>"
  },
  State_120322_Desc = {
    Text = "Đội duy nhất: Giới hạn bài trên tay +2, không thể chồng chéo với giới hạn bài do các vòng mệnh khác cung cấp. Năng lượng chìa khóa bạc của người trang bị, sát thương cuối cùng gây ra bởi cơn thịnh nộ bùng phát, và lá chắn tăng <WeaponEffect_Num:[StateArg1]>. Khi chuyển đổi sang trạng thái \"Biển yên tĩnh\", người trang bị nhận được <WeaponEffect_Num:[StateArg2]> điểm điên cuồng, thời gian hồi chiêu 3 lượt. Khi chuyển đổi sang trạng thái \"Cơn thịnh nộ\", áp dụng <WeaponEffect_Num:[StateArg3]> lớp <DwmofeiKeywords:Nghi lễ giáng sinh> lên tất cả kẻ thù, thời gian hồi chiêu 3 lượt."
  },
  State_120322_WeaponDesc = {
    Text = "Giới hạn bài trên tay +2, không thể chồng chất với giới hạn bài trên tay do vòng mệnh khác cung cấp. Sát thương cuối cùng và khiên do người trang bị Silver Key nạp năng lượng, Bùng nổ gây ra tăng <WeaponEffect_Num:[StateArg1]%>. Khi chuyển sang tư thế\"Biển tĩnh lặng\", người trang bị nhận được <WeaponEffect_Num:[StateArg2]> điểm điên cuồng, thời gian hồi chiêu 3 lượt. Khi chuyển sang tư thế\"Cơn sóng giận dữ\", áp dụng <WeaponEffect_Num:[StateArg3]> lớp<DwmofeiKeywords:Nghi lễ giáng sinh> lên tất cả kẻ thù, thời gian hồi chiêu 3 lượt."
  },
  State_120324_Desc = {
    Text = "Khi chịu Sát thương chủ động hoặc thương tổn xúc tu, áp thêm hiến tế bằng [Layer]% sát thương, xóa khi kết thúc lượt, tối đa chồng 75 lớp."
  },
  State_120324_Name = {
    Text = "Nghi lễ giáng sinh"
  },
  State_120351_Desc = {
    Text = "[Layer] Sau khi kết thúc vòng, có thể chuyển đổi lại \"Vùng đất thần thánh·biển lặng\"."
  },
  State_120351_Name = {
    Text = "Vùng đất thần thánh·Biển lặng lại"
  },
  State_120354_Desc = {
    Text = "[Layer] Sau mỗi lượt có thể chuyển đổi lại \"Vùng đất thần thánh·cơn sóng dữ\"."
  },
  State_120354_Name = {
    Text = "Vùng đất thần thánh·Sóng gầm lặng lại"
  },
  State_120357_Name = {Text = "Xúc tu"},
  State_120362_Desc = {
    Text = "Khi nhận thương từ nguồn khác ngoài <SacrificeKeyWord:hiến tế>, nhận được thương 50% dưới dạng <SacrificeKeyWord:hiến tế>."
  },
  State_120362_Name = {
    Text = "Quản lý hy sinh quái vật chung"
  },
  State_120363_Desc = {
    Text = "Sau khi kết thúc vòng nhận [Layer] điểm sát thương và giảm 50%<SacrificeKeyWord:Hy sinh> số lớp."
  },
  State_120363_Name = {
    Text = "<BlueKeyWord:hiến tế>"
  },
  State_120364_Desc = {
    Text = "Sau khi bản thân tử vong sẽ triệu hồi \"Thủy thủ bảo vệ\"."
  },
  State_120364_Name = {
    Text = "Niềm tin tồn tại mãi mãi"
  },
  State_120401_Desc = {
    Text = "Thẻ này có giá trị điểm tính toán tiêu hao -[StateArg5], chơi xong rút [StateArg4] thẻ."
  },
  State_120401_Name = {
    Text = "<OrangeQuality:Biểu tượng mythag>"
  },
  State_120450_Name = {
    Text = "Bạch tuộc xanh ghi lại sinh mệnh của người chơi"
  },
  State_120462_Desc = {
    Text = "Sau khi chiến đấu kết thúc vẫn được giữ lại trong bộ bài, nhưng sẽ bị xóa vĩnh viễn sau khi chơi hoặc bị tiêu thụ."
  },
  State_120462_Name = {
    Text = "<DestructionKeywords:Xóa bỏ>"
  },
  State_120900_Name = {
    Text = "Chuẩn bị triệu hồi \"thể thức tỉnh Lemuria\" số lượng"
  },
  State_120907_Desc = {
    Text = "Khi tấn công bằng xúc tu nếu bị chặn, gây [DescArg1] lớp <IntoxicationIconKeywords:ngộ độc>."
  },
  State_120907_Name = {
    Text = "Dòng chảy sâu"
  },
  State_120908_Desc = {
    Text = "Khi tấn công bằng xúc tu nếu bị chặn, gây số lớp tương đương <IntoxicationIconKeywords:ngộ độc>."
  },
  State_120908_Name = {
    Text = "Dòng chảy sâu"
  },
  State_120910_Desc = {
    Text = "Thẻ này có giá trị điểm tính toán tiêu hao +[StateArg5], chơi xong rút [StateArg4] thẻ."
  },
  State_120910_Name = {
    Text = "<OrangeQuality:Biểu tượng mythag>"
  },
  State_120924_Desc = {
    Text = "Khi vòng tiếp theo bắt đầu, nhận được gia cố."
  },
  State_120924_Name = {
    Text = "Hoãn gia cố"
  },
  State_120929_Desc = {
    Text = "Thẻ bài được giữ lại, nhưng khi chơi sẽ xóa bỏ ô nhiễm và triệu hồi 1 \"Sinh vật phân bố sâu\". Nếu không có vị trí để triệu hồi, bạn sẽ nhận được 1 lớp \"Chuẩn bị triệu hồi: Sinh vật phân bố sâu\"."
  },
  State_120929_Name = {
    Text = "<SeastriderCurse:Lời nguyền Thủy thủ>"
  },
  State_120930_Desc = {
    Text = "Nếu có vị trí trống, sẽ mất 1 lớp sau khi hành động, triệu hồi 1 \"Thể phân chia sâu biển\"."
  },
  State_120930_Name = {
    Text = "Khế ước hỗ trợ: Phân thể biển sâu"
  },
  State_120934_Desc = {
    Text = "Mỗi lần nhận sát thương bạo kích, nhận 3% <Baojidikang:Kháng Bạo Kích Tạm Thời>. Mỗi đầu lượt gắn \"<SeastriderCurse:Oán Chú Đạo Hải Giả>\" cho 2 lá bài."
  },
  State_120934_Name = {
    Text = "Lễ tế biển sâu"
  },
  State_120941_Desc = {
    Text = "Sẽ làm tăng cường kỹ năng của kẻ địch.Mỗi lần bị thương sẽ mất một lớp."
  },
  State_120941_Name = {
    Text = "Sumpah Darah"
  },
  State_121006_Desc = {
    Text = "Đội ngũ duy nhất: Người trang bị sạc năng lượng chìa khóa bạc, sát thương cuối cùng gây ra bởi bùng nổ, khiên tăng <WeaponEffect_Num:[StateArg1]%>."
  },
  State_121006_WeaponDesc = {
    Text = "Thiệt hại cuối cùng do việc sạc năng lượng chìa khóa bạc và bùng nổ điên loạn gây ra, cùng với khiên được tăng cường <WeaponEffect_Num:[StateArg1]%>."
  },
  State_121014_Name = {
    Text = "Sự bảo vệ của thánh thể"
  },
  State_121015_Desc = {
    Text = "Khi bắt đầu vòng, khiên sẽ không bị xóa bỏ. Khi có khiên sẽ có 50 lớp <ReinforcePVEKeywords:gia cố> , khi khiên bị phá hủy thì loại bỏ <ReinforcePVEKeywords:gia cố>."
  },
  State_121015_Name = {
    Text = "Sự bảo vệ của thánh thể"
  },
  State_121151_Desc = {
    Text = "Thẻ bài được giữ lại, nhưng khi chơi sẽ xóa bỏ ô nhiễm và triệu hồi 1 \"Sinh vật phân bố sâu\". Nếu không có vị trí để triệu hồi, bạn sẽ nhận được 1 lớp \"Chuẩn bị triệu hồi: Sinh vật phân bố sâu\"."
  },
  State_121151_Name = {
    Text = "<SeastriderCurse:Lời nguyền Thủy thủ>"
  },
  State_121210_Name = {
    Text = "Cung cấp hiệu ứng tiêu cực <PVPWonderfulEffectKeywords:hiệu ứng kỳ diệu> cho tất cả kẻ địch, hiệu lực 2 lần"
  },
  State_121211_Name = {
    Text = "Rút 2 thẻ, nhận 2 điểm tính toán"
  },
  State_121212_Name = {
    Text = "Cung cấp hiệu ứng tích cực <PVPWonderfulEffectKeywords:hiệu ứng kỳ diệu> cho tất cả đồng minh, hiệu lực 2 lần"
  },
  State_121213_Desc = {
    Text = "Miễn nhiễm mọi sát thương."
  },
  State_121213_Name = {
    Text = "Miễn nhiễm mọi sát thương."
  },
  State_121231_Desc = {
    Text = "Mỗi lớp làm tăng 20% hiệu ứng \"Nghi lễ giáng sinh\" do \"Công chúa hư vọng\"áp dụng trong lần tiếp theo, tối đa tích lũy 5 lớp, khi đầy 5 lớp, số lần gây sát thương của \"Công chúa hư vọng\" sẽ gấp đôi."
  },
  State_121231_Name = {
    Text = "<MingqiKeywords:giao ước>"
  },
  State_121365_Desc = {
    Text = "Chịu thêm [Layer]% thiệt hại xúc tu."
  },
  State_121377_Name = {
    Text = "<RetainIconKeywords:giữ lại>: Mỗi lượt bắt đầu nhận 500 điểm năng lượng chìa khóa bạc"
  },
  State_121378_Name = {
    Text = "<RetainIconKeywords:giữ lại>: Tất cả thể thức tỉnh hồi sinh lực và Khiên tăng 40%"
  },
  State_121380_Name = {
    Text = "<RetainIconKeywords:giữ lại>: tất cả thể thức tỉnh gây ra điên loạn tăng 50%"
  },
  State_121719_Name = {
    Text = "<RippleKeywords:Dư âm>:Rút 1 lá bài, nhận được [DescArg1] điểm sức mạnh tạm thời<PowerIconKeywords:Sức mạnh>"
  },
  State_121734_Desc = {
    Text = "Mỗi lần đánh 1 thẻ lệnh, bỏ đi 1 thẻ bài có sức tính toán tiêu thụ thấp nhất của thân thể được đánh thức."
  },
  State_121734_Name = {
    Text = "Dòng Chảy Điên Rồ"
  },
  State_121735_Desc = {
    Text = "Tất cả các thẻ lệnh tăng tiêu thụ sức tính toán 1. Mỗi 3 lượt, khi kết thúc lượt, thêm 1 thẻ \"Dần Dần Hóa Đá\" vào tay."
  },
  State_121735_Name = {
    Text = "Dòng chảy than khóc"
  },
  State_121736_Desc = {
    Text = "Khi kết thúc lượt, hồi phục 10% sức sống đã mất, giải trừ trạng thái tiêu cực của bản thân và trạng thái tích cực của người chơi khác."
  },
  State_121736_Name = {
    Text = "Dòng chảy của Sự xuất hiện"
  },
  State_121737_Desc = {
    Text = "Khi bắt đầu chiến đấu, nhận 15 lớp \"rào cản tạm thời\". Khi kết thúc lượt, nhận 15 lớp \"rào cản tạm thời\", và gắn \"tan rã tạm thời\" lên 10 thẻ bài ngẫu nhiên."
  },
  State_121737_Name = {
    Text = "Dòng Chảy Xuyên Xương"
  },
  State_121738_Desc = {
    Text = "Hiệu ứng của thân thể được đánh thức giảm 75%. Mỗi khi mất sức sống, nhận [DescArg1] điểm lá chắn và 1 tầng củng cố tạm thời."
  },
  State_121738_Name = {
    Text = "Dòng chảy của tà tín"
  },
  State_121739_Desc = {
    Text = "Tất cả các thân thể được đánh thức có giới hạn điên cuồng tăng 50%. Kết thúc mỗi lượt, trừ đi 10 điểm điên cuồng của tất cả các thân thể được đánh thức, khôi phục 3% máu tối đa cho bản thân."
  },
  State_121739_Name = {
    Text = "Dòng chảy của nỗi sợ"
  },
  State_121740_Desc = {
    Text = "Khi bắt đầu chiến đấu và vào cuối mỗi lượt, nhận 2 lớp <ResentChainsKeywords:Dây xích oán hận> tạm thời."
  },
  State_121740_Name = {
    Text = "Dòng Chảy Kì Quái"
  },
  State_121797_Desc = {
    Text = "Tất cả sát thương, hồi phục và hiệu quả khiên gây ra giảm 10%, tối đa 2 tầng, không thể xua tan. Khi người thi triển cuối cùng của Si Túy chết, tất cả Si Túy trên người bị thi triển sẽ bị xóa."
  },
  State_121797_Name = {
    Text = "<PVPLostSoulKeyWords:cuồng si>"
  },
  State_121798_Desc = {
    Text = "Hiệu ứng thương, hồi phục và lá chắn gây ra giảm [DescArg1]%, không thể xua tan. Tối đa 2 lớp.\nSau khi Giết <StatusApplier:> thì bị xóa bỏ."
  },
  State_121798_Name = {Text = "Say mê"},
  State_121799_Name = {
    Text = "Thẻ hỗ trợ Lemuria chương bốn"
  },
  State_121850_Desc = {
    Text = "Giảm 80% thương tổn xúc tu"
  },
  State_121850_Name = {
    Text = "Goliath: Hỗ trợ"
  },
  State_121863_Name = {
    Text = "<RippleKeywords:Sóng dư chấn>:Rút 2 lá bài"
  },
  State_121878_Name = {
    Text = "Lần đầu tiên chọn cốt truyện lời nguyền đảo ngược"
  },
  State_122428_Desc = {
    Text = "Thân thể được đánh thức này chưa thức tỉnh… Khi sắp ngã gục sẽ thức tỉnh, hồi phục sức sống và bắt đầu chiến đấu với hình thái thật sự."
  },
  State_122428_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_122431_Desc = {
    Text = "Mouchette gây sát thương không bị chặn, nhận được 2 lớp<Monster_Fervor:tạm thời cuồng nhiệt>."
  },
  State_122431_Name = {
    Text = "Di tích sương mù"
  },
  State_122441_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>: Khi trang bị, nhận được 3 lớp <PVPReciprocalKeywords:Giờ phút đếm ngược>."
  },
  State_122441_Name = {
    Text = "Thời khắc đếm ngược"
  },
  State_122442_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>: Khi trang bị nhận được <Block:[Block:StateArg1]> lá chắn và <Energy:[Energy:StateArg1]> điên cuồng. Khi kết thúc lượt, vòng mệnh này tự động tháo trang bị, và làm cho lượng điên cuồng và lá chắn nhận được khi trang bị\"Sự thú vị trong hộp\" tăng [StateArg2]."
  },
  State_122442_Name = {
    Text = "Sự thú vị trong hộp"
  },
  State_122443_Desc = {
    Text = "Khi bắt đầu lượt, số lớp - 1, khi số lớp cạn kiệt, giải tán trạng thái tiêu cực của bản thân và nhận 100 điên cuồng, sau đó nhận lại 3 lớp thời khắc đếm ngược. Thay đổi vòng mệnh sẽ mất trạng thái đếm ngược."
  },
  State_122443_Name = {
    Text = "<PVPFlowerKeywords:Khoảnh Khắc Đếm Ngược>"
  },
  State_122596_Desc = {
    Text = "Không thể đánh thẻ bài, không thể kích hoạt bùng nổ điên cuồng."
  },
  State_122596_Name = {
    Text = "<Seal1:Phong ấn>"
  },
  State_122636_Desc = {
    Text = "Mỗi lượt, nếu \"kỹ năng\"đầu tiên được đánh ra thì sát thương, chữa trị và lá chắn tăng [StateArg1]%."
  },
  State_122636_Name = {
    Text = "Trâm cài hồng ngọc"
  },
  State_122650_Desc = {
    Text = "Sáng tạo <OrangeQuality:găng tay ma thuật> đã thêm thẻ này."
  },
  State_122650_Name = {
    Text = "Thẻ bài kỳ lạ"
  },
  State_122654_Name = {
    Text = "Mỗi lần bắt đầu lượt và kết thúc hành động sẽ cố gắng tái lập bộ bài của người chơi nếu trống, nếu không trống thì sẽ không tái lập.__\"Chỉ dùng cho phát triển\""
  },
  State_122706_Name = {
    Text = "<CardKeyWord:Gặp lại ước nguyện>"
  },
  State_122707_Desc = {
    Text = "Được coi là \"Kỹ Năng\" đã chơi lần cuối trong vòng này, Giá trị Điểm tính toán -2, đặt lên đầu bộ bài rút thứ hai."
  },
  State_122707_Name = {
    Text = "<CardKeyWord:Gặp lại ước nguyện>"
  },
  State_123109_Desc = {
    Text = "Duy nhất trong đội: Khi lần đầu tiên mua \"khắc ấn\" trong \"dấu vết tan chảy\", hoặc khi lần đầu tiên mua hàng giảm giá cần dấu đen trong \"di tích tro tàn\", cơ hội có <WeaponEffect_Num:[StateArg1]%> sẽ trở về 0, mỗi lần khám phá chỉ có thể có hiệu lực tối đa 1 lần."
  },
  State_123109_WeaponDesc = {
    Text = "Trong \"Dấu Vết Hòa Nhập\" mua \"Khắc Ấn\" lần đầu tiên, hoặc trong \"Di Tích Tro Tàn\" mua hàng giảm giá lần đầu tiên cần có ấn đen có <WeaponEffect_Num:[StateArg1]%> cơ hội trở thành 0, mỗi lần khám phá tối đa chỉ có hiệu lực 1 lần."
  },
  State_123177_Desc = {
    Text = "Vào đầu lượt sẽ được xóa bỏ. Khi đạt 10 lớp, lần chơi thẻ bài tiếp theo, Mouchette sẽ ngay lập tức hoạt động, loại bỏ \"cuồng nhiệt tạm thời\" và thêm ý định \"Nổ phá nhân gian\"."
  },
  State_123177_Name = {
    Text = "Tạm thời cuồng nhiệt"
  },
  State_123178_Desc = {
    Text = "<Guaiwusiwangdikang: kháng cự tử vong> hiệu ứng hồi phục sinh lực được tăng lên 5 lần. Mỗi khi địch sử dụng 1 thẻ bài, khiến bản thân nhận được 1 lớp <Monster_Fervor:cuồng nhiệt tạm thời>."
  },
  State_123178_Name = {
    Text = "Cơn giận khi thức dậy"
  },
  State_123243_Desc = {
    Text = "Khi hạ gục kẻ địch, xóa toàn bộ tầng và nhận lượng cuồng khí tương đương."
  },
  State_123243_Name = {
    Text = "Dòng xoáy"
  },
  State_123246_Desc = {
    Text = "Khi hạ gục kẻ địch, xóa tất cả tầng và nhận lượng cuồng khí tương đương."
  },
  State_123246_Name = {
    Text = "<PVPWaterPowerKeyWords:dòng xoáy>"
  },
  State_123294_Desc = {
    Text = "Trong lượt này đã rút được [DescArg1] lá bài bằng cách \"đánh\"."
  },
  State_123294_Name = {Text = "Sát nhân"},
  State_123507_Desc = {
    Text = "Đội duy nhất: Sau khi bắt đầu khám phá, thêm 1 lá bài \"Giờ phút đếm ngược: 5\" vào bộ bài: chơi xong rút 1 lá bài, và xáo trộn lá\"Giờ phút đếm ngược\" tiếp theo vào rác bài.\"<DestructionKeywords:Hủy hoại>\".\"Giờ phút đếm ngược: 0\": Rút 3 lá bài, nhận 3 điểm tính toán, và có <WeaponEffect_Num:[StateArg1]%> xác suất đưa \"Giờ phút đếm ngược: 5\" vào rác bài. Giữ lại.\"<DestructionKeywords:Hủy hoại>\"."
  },
  State_123507_WeaponDesc = {
    Text = "Sau khi bắt đầu khám phá, thêm 1 lá\"Giờ phút đếm ngược: 5\" vào bộ bài: chơi xong rút 1 lá bài, và xáo trộn lá\"Giờ phút đếm ngược\" tiếp theo vào rác bài.\"<DestructionKeywords:Hủy hoại>\".\"Giờ phút đếm ngược: 0\": rút 3 lá bài, nhận 3 điểm tính toán, và có <WeaponEffect_Num:[StateArg1]%> xác suất đưa \"Giờ phút đếm ngược: 5\" vào rác bài. Giữ lại.\"<DestructionKeywords:Hủy hoại>\"."
  },
  State_123520_Desc = {
    Text = "Đội duy nhất: Sau khi giải phóng lệnh khóa lần đầu tiên trong mỗi lượt, có <WeaponEffect_Num:[StateArg1]>% xác suất rút 1 thẻ \"Đánh\" của người trang bị."
  },
  State_123520_WeaponDesc = {
    Text = "Sau khi giải phóng lệnh khóa lần đầu trong mỗi lượt, có xác suất <WeaponEffect_Num:[StateArg1]>% rút 1 thẻ \"Đánh\" của người trang bị."
  },
  State_123521_Desc = {
    Text = "Đội duy nhất: Sát thương cơ bản của cơn thịnh nộ bùng phát và đuổi theo tăng lên <WeaponEffect_Num:[StateArg1]%.> Sau khi chơi bất kỳ thể thức tỉnh nào trong lượt này, sát thương「Đánh」của người trang bị tạm thời tăng <WeaponEffect_Num:[StateArg2]>, tối đa có hiệu lực 8 lần mỗi lượt."
  },
  State_123521_WeaponDesc = {
    Text = "Người trang bị sát thương cơ bản của cơn thịnh nộ bùng phát và đuổi theo tăng lên <WeaponEffect_Num:[StateArg1]%.> Sau khi chơi bất kỳ thể thức tỉnh nào trong lượt này, sát thương「Đánh」của người trang bị tạm thời tăng <WeaponEffect_Num:[DescArg2]>, tối đa có hiệu lực 8 lần mỗi lượt."
  },
  State_123810_Desc = {
    Text = "Thay thế ý định hiện tại của kẻ địch bằng \"không thể hành động\"."
  },
  State_123810_Name = {
    Text = "<HunmiKeywords:Hôn mê>"
  },
  State_123812_Desc = {
    Text = "Khi kết thúc lượt, sức tính toán tiêu thụ giảm."
  },
  State_123812_Name = {
    Text = "<PrepareKeywords:chuẩn bị>"
  },
  State_123994_Desc = {
    Text = "Không thể thực hiện bất kỳ hành động nào."
  },
  State_123994_Name = {
    Text = "Giấc ngủ tinh tế"
  },
  State_124010_Desc = {
    Text = "Vào đầu vòng tiếp theo, nhận được [Số học]."
  },
  State_124010_Name = {
    Text = "Điểm tính toán trễ"
  },
  State_124024_Desc = {
    Text = "Trong lượt này đã đánh ra [Layer] lá đánh, kích hoạt [DescArg1] lần \"gặp gỡ kịch tính\"."
  },
  State_124024_Name = {
    Text = "Cuộc gặp gỡ kịch tính"
  },
  State_124034_Desc = {
    Text = "Tất cả các thân thể được đánh thức có sát thương \"đánh\" tăng [StateArg1], kéo dài [Layer] lượt."
  },
  State_124034_Name = {
    Text = "Bão táp☆Rực rỡ"
  },
  State_124037_Desc = {
    Text = "Sát thương của Mộc Hạ tăng +1, tất cả các thực thể được đánh thức \"đánh\" tăng sát thương [StateArg1], kéo dài [Layer] lượt."
  },
  State_124037_Name = {
    Text = "Bão táp☆Rực rỡ"
  },
  State_124107_Desc = {
    Text = "\"Mầm Sao\" chết đi, miễn dịch mọi sát thương và thức tỉnh, máu tối đa gấp đôi và nhận được lượng máu tối đa tương đương với số máu còn lại. Sau khi thức tỉnh, xóa bỏ tất cả trạng thái tiêu cực."
  },
  State_124107_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_124108_Name = {
    Text = "Đếm số Giọng ngoài thế giới"
  },
  State_124109_Desc = {
    Text = "<RetaliateIconKeywords:phản công> nhận được từ bản thân sẽ được hưởng thêm 5% <PowerIconKeywords:lực lượng>. Sau khi mất [DescArg1] điểm sức sống trong một lượt, hoán đổi vị trí với \"Ca Sĩ\""
  },
  State_124109_Name = {
    Text = "Cradle thứ cấp"
  },
  State_124111_Desc = {
    Text = "Kháng cự tử vong hồi phục sinh mệnh được tăng lên 25%. Mỗi khi địch đánh ra 1 thẻ lệnh, tạm thời <TouquKeywords:trộm cắp> [DescArg1] điểm <PowerIconKeywords:lực lượng>."
  },
  State_124111_Name = {
    Text = "sao không giới hạn"
  },
  State_124112_Desc = {
    Text = "\"Ca sĩ\" chết đi, miễn dịch với mọi sát thương và thức tỉnh, máu tối đa gấp đôi và nhận được lượng máu tối đa tương đương với lượng máu còn lại."
  },
  State_124112_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_124113_Desc = {
    Text = "Đối phương sẽ không loại bỏ tay bài khi kết thúc lượt. Khi kết thúc lượt, lần lượt áp dụng 2 lớp <FragileIconKeywords:mỏng manh>, <WeaknessIconKeywords:suy nhược>, <HeavyInjuryKeywords:thiệt hại nặng>, <VulnerabilityIconKeywords:trọng thương> trạng thái."
  },
  State_124113_Name = {
    Text = "Giọng ngoài thế giới"
  },
  State_124115_Desc = {
    Text = "<FragileIconKeywords:Mong manh>, <HeavyInjuryKeywords:Thiệt hại nặng> và <WeaknessIconKeywords:Suy nhược> gây ra được tăng sâu lên 50%. Sau khi chơi thêm [DescArg1] thẻ <SlowIconKeywords:Trì trệ>, hoán đổi vị trí với \"Mầm Sao\"."
  },
  State_124115_Name = {
    Text = "Du lịch hành tinh"
  },
  State_124121_Name = {
    Text = "Số lượng Du lịch hành tinh"
  },
  State_124122_Name = {
    Text = "Nghe lén người chơi du lịch hành tinh"
  },
  State_124190_Desc = {
    Text = "Bản thân nhận được<RetaliateIconKeywords:phản công>Thưởng thức thêm 5% <PowerIconKeywords:lực lượng>Bonus."
  },
  State_124190_Name = {
    Text = "Cradle thứ cấp"
  },
  State_124193_Name = {
    Text = "Hiệu ứng hồi phục sinh mệnh của kháng cự tử vong được tăng lên 25%."
  },
  State_124198_Desc = {
    Text = "<FragileIconKeywords:Mong manh>, <HeavyInjuryKeywords:Thiệt hại nặng> và <WeaknessIconKeywords:Suy nhược> gây ra được tăng sâu lên 50%."
  },
  State_124198_Name = {
    Text = "Du lịch hành tinh"
  },
  State_124277_Desc = {
    Text = "Hiện thực hóa giá trị trung gian của quá trình thực hiện."
  },
  State_124277_Name = {
    Text = "Giá trị in 2"
  },
  State_124278_Desc = {
    Text = "Hiện thực hóa giá trị trung gian của quá trình thực hiện."
  },
  State_124278_Name = {
    Text = "Giá trị in 4"
  },
  State_124279_Desc = {
    Text = "Hiện thực hóa giá trị trung gian của quá trình thực hiện."
  },
  State_124279_Name = {
    Text = "Giá trị in 5"
  },
  State_124280_Desc = {
    Text = "Hiện thực hóa giá trị trung gian của quá trình thực hiện."
  },
  State_124280_Name = {
    Text = "Giá trị in 1"
  },
  State_124282_Desc = {
    Text = "Hiện thực hóa giá trị trung gian của quá trình thực hiện."
  },
  State_124282_Name = {
    Text = "Giá trị in 7"
  },
  State_124283_Desc = {
    Text = "Hiện thực hóa giá trị trung gian của quá trình thực hiện."
  },
  State_124283_Name = {
    Text = "Giá trị in 8"
  },
  State_124284_Desc = {
    Text = "Hiện thực hóa giá trị trung gian của quá trình thực hiện."
  },
  State_124284_Name = {
    Text = "Giá trị in 9"
  },
  State_124285_Desc = {
    Text = "Hiện thực hóa giá trị trung gian của quá trình thực hiện."
  },
  State_124285_Name = {
    Text = "Giá trị in 10"
  },
  State_124286_Desc = {
    Text = "Hiện thực hóa giá trị trung gian của quá trình thực hiện."
  },
  State_124286_Name = {
    Text = "Giá trị in 6"
  },
  State_124287_Desc = {
    Text = "Hiện thực hóa giá trị trung gian của quá trình thực hiện."
  },
  State_124287_Name = {
    Text = "Giá trị in 3"
  },
  State_124736_Desc = {
    Text = "Xác thực xem tham số 3 của giao diện BEAttachPostAction có được lọc đúng hoặc kích hoạt bộ kích hoạt tương ứng hay không."
  },
  State_124736_Name = {
    Text = "Kiểm tra nghe 1"
  },
  State_124747_Desc = {
    Text = "Xác thực xem tham số 3 của giao diện BEAttachPostAction có được lọc đúng hoặc kích hoạt bộ kích hoạt tương ứng hay không."
  },
  State_124747_Name = {
    Text = "Kiểm tra nghe 2"
  },
  State_124748_Desc = {
    Text = "Khi kẻ địch đánh ra thẻ bài <BurningKeywords:đốt cháy>, khiến bản thân nhận 1 lớp <MonsterExFlameKeywords:ngọn lửa bùng cháy>, nhưng tạm thời giảm [DescArg1] <PowerIconKeywords:lực lượng>."
  },
  State_124748_Name = {
    Text = "Ngọn Lửa Bất Diệt"
  },
  State_124752_Desc = {
    Text = "Xác thực xem tham số 3 của giao diện BEAttachPostAction có được lọc đúng hoặc kích hoạt bộ kích hoạt tương ứng hay không."
  },
  State_124752_Name = {
    Text = "Kiểm tra nghe 3"
  },
  State_124753_Desc = {
    Text = "Xác thực xem tham số 3 của giao diện BEAttachPostAction có được lọc đúng hoặc kích hoạt bộ kích hoạt tương ứng hay không."
  },
  State_124753_Name = {
    Text = "Kiểm tra nghe 4"
  },
  State_124754_Desc = {
    Text = "Xác thực xem tham số 3 của giao diện BEAttachPostAction có được lọc đúng hoặc kích hoạt bộ kích hoạt tương ứng hay không."
  },
  State_124754_Name = {
    Text = "Kiểm tra nghe 5"
  },
  State_124765_Desc = {
    Text = "Tỷ lệ chí mạng tăng [Layer] %."
  },
  State_124765_Name = {
    Text = "Tỉ lệ chí mạng"
  },
  State_124766_Desc = {
    Text = "Tỷ lệ chí mạng trong cuộc chiến đấu này tăng [Layer] %."
  },
  State_124766_Name = {
    Text = "Tỉ lệ chí mạng"
  },
  State_124766_WeaponDesc = {
    Text = "Tỷ lệ chí mạng trong cuộc chiến đấu này tăng [Layer] %."
  },
  State_124767_Desc = {
    Text = "Thương harming chí mạng tăng [Layer] %."
  },
  State_124767_Name = {
    Text = "Sát thương chí mạng"
  },
  State_124811_Desc = {
    Text = "Xác thực xem tham số 3 của giao diện BEAttachPostAction có được lọc đúng hoặc kích hoạt bộ kích hoạt tương ứng hay không."
  },
  State_124811_Name = {
    Text = "Kiểm tra nghe 8"
  },
  State_124812_Desc = {
    Text = "Xác thực xem tham số 3 của giao diện BEAttachPostAction có được lọc đúng hoặc kích hoạt bộ kích hoạt tương ứng hay không."
  },
  State_124812_Name = {
    Text = "Kiểm tra nghe 7"
  },
  State_124813_Desc = {
    Text = "Xác thực xem tham số 3 của giao diện BEAttachPostAction có được lọc đúng hoặc kích hoạt bộ kích hoạt tương ứng hay không."
  },
  State_124813_Name = {
    Text = "Kiểm tra nghe 6"
  },
  State_124826_Desc = {
    Text = "Xác thực xem tham số 3 của giao diện BEAttachPostAction có được lọc đúng hoặc kích hoạt bộ kích hoạt tương ứng hay không."
  },
  State_124826_Name = {
    Text = "Kiểm tra nghe 9"
  },
  State_124843_Desc = {
    Text = "Xác thực việc nghe các bộ kích hoạt BSTAfterAttachPostAction và BSTAfterDoActiveDamage.AttachPostAction"
  },
  State_124843_Name = {
    Text = "Kiểm tra nghe 9"
  },
  State_124886_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>:Chơi thẻ kỹ năng của người trang bị xong, rút [StateArg1] lá bài, ưu tiên rút thẻ của các thể thức tỉnh khác, mỗi lượt chỉ có hiệu lực 1 lần."
  },
  State_124886_Name = {
    Text = "Vòng quay định mệnh"
  },
  State_124887_Desc = {
    Text = "Số lần thương của \"dệt\" của Thể thức tỉnh này tăng [Layer]."
  },
  State_124887_Name = {Text = "Dệt"},
  State_124888_Desc = {
    Text = "Sau mỗi lần chơi thẻ bài, biến đổi thành \"Kỹ Năng\" ngẫu nhiên trong tay đối phương và giảm Giá trị Điểm tính toán của nó -2."
  },
  State_124888_Name = {
    Text = "<CardKeyWord:Lời tiên tri>"
  },
  State_124890_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>:\"Bùng nổ\" sau khi khiến bản thân dưới [StateArg1] lá đã chơi \"kỹ năng\" có hiệu lực 2 lần."
  },
  State_124890_Name = {
    Text = "Lưới dệt vĩnh hằng"
  },
  State_124892_Name = {
    Text = "<CardKeyWord:Lời tiên tri>"
  },
  State_124916_Desc = {
    Text = "Khi kết thúc lượt, loại bỏ tất cả lớp và gây [DescArg1] Sát Thương Thuần Túy, không thể xua tan."
  },
  State_124916_Name = {
    Text = "Điềm Báo Định Mệnh"
  },
  State_124917_Desc = {
    Text = "Khi kết thúc lượt, loại bỏ tất cả số lớp và gây Sát Thương Thuần Túy, không thể xóa bỏ."
  },
  State_124917_Name = {
    Text = "<PVPDestinedDeathKeyWords:Điềm Báo Định Mệnh>"
  },
  State_124992_Desc = {
    Text = "[DescArg1] thẻ \"Kỹ Năng\" tiếp theo được chơi 2 lần."
  },
  State_124992_Name = {
    Text = "Bắn Đôi"
  },
  State_124993_Desc = {
    Text = "Sát thương chủ động gây ra và nhận vào được chuyển thành áp dụng lượng <PVPDestinedDeathKeyWords:Điềm Báo Định Mệnh> tương đương, không thể xua tan."
  },
  State_124993_Name = {
    Text = "Mệnh Đồ, Y Thử Dụ Thị"
  },
  State_124997_Desc = {
    Text = "Sát thương chủ động gây ra và nhận vào nếu gây chết người sẽ được thay thế bằng cách áp đặt <PVPDestinedDeathKeyWords:Điềm Báo Định Mệnh> với lượng tương đương. Không thể xua tan."
  },
  State_124997_Name = {
    Text = "<PVPEternalDimensionKeyWords:Mệnh đồ, theo đây dụ thị>"
  },
  State_125002_Name = {
    Text = "Trạng thái@theo dõi giá trị lá chắn sau giai đoạn bỏ bài của người chơi chung"
  },
  State_125003_Name = {
    Text = "Giá trị lá chắn"
  },
  State_125004_Name = {
    Text = "Trạng thái@Áp dụng số lượng lá chắn cho người chơi chung"
  },
  State_125472_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>: Sau \"Bùng nổ\" áp [StateArg1] lớp <PVPLostSoulKeyWords:Say mê> lên kẻ địch có <HPAndShieldMax:Sinh lực và lá chắn cao nhất>."
  },
  State_125472_Name = {
    Text = "Mồi hoa ngọc lan"
  },
  State_125486_Desc = {
    Text = "<PVPWeaponKeywords:Bánh Xe Mệnh>: Sau khi đồng đội khác\"Bùng Nổ Cuồng Khí\", giảm tiêu haoĐiểm tính toán của tất cả\"Kỹ năng\"của người trang bị trong tay - [StateArg1]."
  },
  State_125486_Name = {
    Text = "Nhíu mày uổng phí"
  },
  State_125925_Desc = {
    Text = "Thân thể được đánh thức này chưa thức tỉnh… Khi sắp ngã gục sẽ thức tỉnh, hồi phục sức sống và bắt đầu chiến đấu với hình thái thật sự."
  },
  State_125925_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_125926_Name = {
    Text = "Trạng thái@quái vật Tà Vy chuyển đổi ý định người chơi theo dõi"
  },
  State_125927_Desc = {
    Text = "Sau khi đánh ra [DescArg1] thẻ lệnh, chuyển ý định thành \"Sáu cánh hoàn toàn mở\"."
  },
  State_125927_Name = {
    Text = "Bốn cánh dần mọc"
  },
  State_125928_Desc = {
    Text = "Chơi thẻ lệnh, phong ấn cơn thịnh nộ bùng phát và tất cả thẻ lệnh của thể thức tỉnh tương ứng trong 2 lượt."
  },
  State_125928_Name = {
    Text = "Cánh xuyên qua dòng thời gian"
  },
  State_125929_Desc = {
    Text = "Sau khi nhận đủ [DescArg1] điểm thương trong một lượt, nhận 70 lớp củng cố tạm thời <ReinforceColour:Gia cố> và 1 lớp <ResentChainsKeywords:Dây xích oán hận>."
  },
  State_125929_Name = {
    Text = "Sự tồn tại không tồn tại"
  },
  State_125933_Desc = {
    Text = "Sau khi chơi [DescArg1] thẻ lệnh, chuyển ý định thành \"Bốn cánh dần mọc\"."
  },
  State_125933_Name = {
    Text = "Cánh đôi lần đầu tiên mở rộng"
  },
  State_125934_Desc = {
    Text = "Khi tiêu hao sức tính toán, năng lượng chìa khóa bạc nhận được giảm 50%. Sau khi Tà Vĩ gây ra thương không bị chặn, thêm 1 lá \"<DerivativeCardKeywords_131:Chân · Luân Hồi Bác Luận>\" vào tay."
  },
  State_125934_Name = {
    Text = "Trải qua cửa khóa bạc"
  },
  State_125935_Name = {Text = "Im lặng"},
  State_125935_WeaponDesc = {
    Text = "Sau khi rút khiến bản thân yếu đuối 1 lượt. Sau khi sử dụng, khiến tất cả kẻ địch yếu đuối 1 lượt. Không thể bán."
  },
  State_125937_Desc = {
    Text = "Chơi thẻ lệnh, phong ấn cơn thịnh nộ bùng phát và tất cả thẻ lệnh của thể thức tỉnh tương ứng trong 2 lượt."
  },
  State_125937_Name = {
    Text = "Cánh xuyên qua dòng thời gian"
  },
  State_125964_Desc = {
    Text = "Khi tiêu hao Sức Tính Toán, năng lượng Chìa Khóa Bạc nhận được giảm 50%. Sau khi Tavi gây sát thương không bị đỡ, đặt 1 lá\"<DerivativeCardKeywords_131:Chân·Nghịch Lý Luân Hồi>\" vào tay."
  },
  State_125964_Name = {
    Text = "Trải qua cửa khóa bạc"
  },
  State_126010_Desc = {
    Text = "Đội duy nhất: Người trang bị gây ra ngộ độc cố định và kích hoạt hiệu ứng ngộ độc tăng <WeaponEffect_Num:[StateArg1]%>, trong cõi thịt máu, khả năng hồi phục <EmbryoFusionIconKeywords:Dung hợp Phôi thai> tăng <WeaponEffect_Num:[StateArg2]%>. Người trang bị mỗi lượt khi kích hoạt lần đầu \"cộng hưởng\" sẽ khiến các thể thức tỉnh khác nhận được <WeaponEffect_Num:[StateArg3]> điểm điên cuồng."
  },
  State_126010_WeaponDesc = {
    Text = "Người trang bị gây ra ngộ độc cố định và kích hoạt hiệu ứng ngộ độc tăng <WeaponEffect_Num:[StateArg1]%>, mức độ hồi phục tự động trong cõi thịt máu của <EmbryoFusionIconKeywords:Dung hợp Phôi thai> tăng <WeaponEffect_Num:[StateArg2]%>. Người trang bị mỗi lượt khi kích hoạt lần đầu \"cộng hưởng\" sẽ khiến các thể thức tỉnh khác nhận được <WeaponEffect_Num:[StateArg3]> điểm điên cuồng."
  },
  State_126463_Name = {
    Text = "Trạng thái@quái vật Liz lửa dụ dỗ bị thương theo dõi"
  },
  State_126464_Desc = {
    Text = "Giới hạn 10 tầng, mỗi tầng làm tăng sát thương của Liz [DescArg1] điểm."
  },
  State_126464_Name = {
    Text = "<GreenWord:Hạt lửa xanh lục>"
  },
  State_126465_Name = {
    Text = "Nghe ý đồ quái vật Liz"
  },
  State_126466_Desc = {
    Text = "Kết thúc lượt đối phương sẽ không bỏ tay bài. Khi ý định chuyển sang Lửa Xanh, nếu có ít nhất 6 lớp <MonsterLizVerdantSpark:Chispa xanh lá>, tiêu hao 6 lớp, nâng cấp ý định thành \"Ngọn Lửa Xanh Của Sự Diệt Vong\" gây <Damage:[Damage:DescArg1]> điểm thương [AttackTimes:DescArg2] lần; nếu có ít nhất 3 lớp, tiêu hao 3 lớp, nâng cấp ý định thành \"Ngọn lửa xanh bị hư hỏng\" gây <Damage:[Damage:DescArg3]> điểm thương [AttackTimes:DescArg4] lần."
  },
  State_126466_Name = {
    Text = "Hỏa Diễm Bất Tử"
  },
  State_126467_Desc = {
    Text = "Thể thức tỉnh này chưa thức tỉnh... Khi sắp ngã gục sẽ thức tỉnh, hồi phục sinh lực và bắt đầu chiến đấu với hình thái thật sự, đồng thời cho phép \"Vũ điệu báo tử\" xóa bỏ trạng thái tiêu cực."
  },
  State_126467_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_126468_Name = {
    Text = "Trạng thái@quái vật Liz Hình ảnh ngọc bích quản lý"
  },
  State_126469_Desc = {
    Text = "Mỗi khi mất [DescArg1] điểm sinh lực, nhận được [DescArg2] lớp <MonsterLizVerdantSpark:Chispa xanh lá>."
  },
  State_126469_Name = {
    Text = "Hình ảnh ngọc bích"
  },
  State_126470_Name = {
    Text = "Trạng thái@đếm số gợi ý quái vật Liz"
  },
  State_126479_Desc = {
    Text = "Giới hạn 10 tầng, làm tăng sát thương gây ra của Liz."
  },
  State_126479_Name = {
    Text = "<GreenWord:Hạt lửa xanh lục>"
  },
  State_126540_Desc = {
    Text = "Tuần xuống [Layer] lần kích hoạt \"cộng hưởng\" thì hiệu ứng \"cộng hưởng\" tăng gấp đôi."
  },
  State_126540_Name = {
    Text = "Lời thề dưới sương đêm"
  },
  State_126568_Desc = {
    Text = "Thể thức tỉnh mỗi lần gây sát thương chủ động, ra lệnh 1 xúc tu tấn công mục tiêu gây [Layer]% thương tổn xúc tu."
  },
  State_126568_Name = {
    Text = "Biển cả cuồng nộ"
  },
  State_126569_Desc = {
    Text = "Thể thức tỉnh mỗi lần gây ra sát thương chủ động, ra lệnh 1 lần tấn công xúc tu vào mục tiêu gây ra 50% thiệt hại xúc tu."
  },
  State_126569_Name = {
    Text = "Biển cả cuồng nộ"
  },
  State_126643_Desc = {
    Text = "Trạng thái này MaxLayer=1. Nguồn thể thức tỉnh: [DescArg1]"
  },
  State_126643_Name = {
    Text = "Giới hạn tầng 1"
  },
  State_126644_Desc = {
    Text = "Sau khi nhận, xóa và thêm lại trạng thái trình diễn [Layer] lớp. \n Số lớp tối đa của trạng thái trình diễn là 1 lớp."
  },
  State_126644_Name = {
    Text = "Phá vỡ số lớp tối đa"
  },
  State_126645_Desc = {
    Text = "Ramona gây sát thương cơ bản tăng [DescArg1]%"
  },
  State_126645_Name = {
    Text = "Tôi luyện chí thuần"
  },
  State_126651_Desc = {
    Text = "Giải phóng theo dõi sau khi truy đuổi đã đạt được [Layer] lần."
  },
  State_126651_Name = {
    Text = "Bảng đếm"
  },
  State_126652_Desc = {
    Text = "Sau khi nhận được, khiến kẻ địch hàng trước thực hiện hành động bổ sung, chơi ý định hiện tại của chúng."
  },
  State_126652_Name = {
    Text = "Khiến quái vật truy đuổi"
  },
  State_126653_Desc = {
    Text = "Sau khi nhận được, cho Thể Thức Tỉnh ở vị trí 1 thêm hành động sau, chơi thẻ Đánh của nó."
  },
  State_126653_Name = {
    Text = "Ra lệnh cho Thể thức tỉnh truy đuổi"
  },
  State_126654_Desc = {
    Text = "Khi lệnh khóa chỉ định bị kích hoạt, in ra 1 lần đếm."
  },
  State_126654_Name = {
    Text = "Nghe lén chỉ định"
  },
  State_126655_Desc = {
    Text = "Sau khi nhận được, hãy để Người Giữ Gìn thực hiện hành động bổ sung, chơi kỹ năng @nhân vật chính @giọng trong đầu."
  },
  State_126655_Name = {
    Text = "Gọi Người Giữ Gìn đuổi theo"
  },
  State_126677_Desc = {
    Text = "Trong lượt này, [Layer] lá \"Lưỡi Kiếm Khiêu Khích\" có hiệu lực 2 lần."
  },
  State_126677_Name = {
    Text = "Tiếng kình ngư vạn cổ"
  },
  State_126678_WeaponDesc = {
    Text = "Số lần gây thương của Cá Voi Nhảy tăng thêm 1."
  },
  State_126714_Desc = {
    Text = "Ai Jī Sī sử dụng [Layer] thẻ \"phòng thủ\" có hiệu lực 3 lần."
  },
  State_126714_Name = {
    Text = "Giọt lệ ngưng đọng"
  },
  State_126714_WeaponDesc = {
    Text = "Số lần gây thương của Cá Voi Nhảy tăng thêm 1."
  },
  State_126715_WeaponDesc = {
    Text = "Số lần gây thương của Cá Voi Nhảy tăng thêm 1."
  },
  State_126776_Desc = {
    Text = "Mỗi khi sở hữu 1 lớp, ngộ độc cố định nhận vào tăng 5%, sát thương gây ra giảm [DescArg1]%, tối đa [DescArg2] lớp."
  },
  State_126776_Name = {
    Text = "<WitherKeywords:Sa sút trí tuệ>"
  },
  State_126783_Name = {
    Text = "Tạm thời đã bị bỏ hoang"
  },
  State_126784_Desc = {
    Text = "Thương phải chịu ngộ độc cố định tăng [DescArg1]%, sát thương gây ra giảm [DescArg2]%, tối đa [DescArg3] tầng."
  },
  State_126784_Name = {Text = "Say mê"},
  State_126785_Desc = {
    Text = "Nếu các thể thức tỉnh khác đã tích lũy đánh ra X thẻ lệnh, sau khi đánh sẽ kích hoạt hiệu ứng tiếp theo. Đánh thẻ lệnh của chính mình hoặc sau khi kết thúc lượt sẽ đặt lại số đếm cộng hưởng của chính mình."
  },
  State_126785_Name = {
    Text = "<ResonanceKeywords:cộng hưởng X>"
  },
  State_126789_Desc = {
    Text = "Áp dụng 2 lớp<WitherKeywords:ngây ngất> lên tất cả kẻ địch."
  },
  State_126789_Name = {
    Text = "<WitherKeywords1:hứa hẹn>"
  },
  State_126790_Desc = {
    Text = "Loại bỏ tất cả <WitherKeywords:Say mê> của kẻ địch, mỗi lớp loại bỏ gây <FixedDamage:Sát Thương Thuần Túy> [DescArg1]% Sinh lực tối đa của mục tiêu và kích hoạt 40% Ngộ độc."
  },
  State_126790_Name = {
    Text = "<WitherKeywords2:Đoạt hồn>"
  },
  State_126803_Desc = {
    Text = "Thẻ lệnh tiếp theo được chơi ra [DescArg1] sẽ được gửi đến tương lai sau 3 lượt."
  },
  State_126803_Name = {
    Text = "Bánh Xe Vận Mệnh"
  },
  State_126893_Name = {
    Text = "Trạng thái@số phậnSiêu ChiềuHuyền bí thuần túy"
  },
  State_126895_Desc = {
    Text = "Sát thương, lực lượng và thương tổn xúc tu cố định, ngộ độc cố định, phản công cố định của thẻ bài này tăng [DescArg1]%, lá chắn cố định, hồi phục sinh lực cố định, sức mạnh giảm xuống tăng [DescArg2]%. Thẻ bài có \"Ngọn hải đăng kỳ điểm\" không thể sao chép vào \"Khoảng không gian siêu việt\"."
  },
  State_126895_Name = {
    Text = "<SingularityKeywords:Tín Hiệu Kỳ Điểm [DescArg2]>"
  },
  State_126896_Name = {
    Text = "Trạng thái@Ánh sáng Siêu việt thẻ bài giảm số lớp cân bằng Điểm tính toán"
  },
  State_126900_Name = {
    Text = "Trạng thái@số phận khởi tạo chức nghiệp siêu chiều 2"
  },
  State_126901_Name = {
    Text = "Trạng thái@số phận khởi tạo chức nghiệp siêu chiều 1"
  },
  State_126903_Name = {
    Text = "Trạng thái@số phậnKhoảng không gian siêu việtChuẩn tinh đánh dấu"
  },
  State_126927_Desc = {
    Text = "Đội duy nhất: Người trang bị gây ra ngộ độc cố định và kích hoạt hiệu ứng ngộ độc tăng <WeaponEffect_Num:[StateArg1]%>. Người trang bị mỗi lượt khi kích hoạt lần đầu \"cộng hưởng\" sẽ nhận được <WeaponEffect_Num:[StateArg2]> điểm điên cuồng."
  },
  State_126927_WeaponDesc = {
    Text = "Người trang bị gây ra ngộ độc cố định và kích hoạt hiệu ứng ngộ độc tăng <WeaponEffect_Num:[StateArg1]%>. Người trang bị mỗi lượt khi kích hoạt lần đầu \"cộng hưởng\" sẽ nhận được <WeaponEffect_Num:[StateArg2]> điểm điên cuồng."
  },
  State_126990_Name = {
    Text = "<IntoxicationColour:trúng độc>"
  },
  State_127108_Desc = {
    Text = "Áp dụng 5 lớp <WitherKeywords:đắm chìm> lên tất cả kẻ địch."
  },
  State_127108_Name = {
    Text = "<WitherKeywords3:Hứa hẹn>"
  },
  State_127109_Desc = {
    Text = "Loại bỏ tất cả <WitherKeywords:Say mê> của kẻ địch, mỗi lần loại bỏ 1 lớp tích lũy 20% Thể chất của Lò nung đỏ thẫm, gây ra <FixedDamage:Sát Thương Thuần Túy> [DescArg1]% Sinh lực tối đa của mục tiêu và kích hoạt 40% Ngộ độc."
  },
  State_127109_Name = {
    Text = "<WitherKeywords4:đoạt hồn>"
  },
  State_127176_Desc = {
    Text = "Mỗi khi sở hữu 1 lớp, ngộ độc cố định nhận vào tăng 5%, sát thương gây ra giảm [DescArg1]%, tối đa [DescArg2] lớp."
  },
  State_127176_Name = {
    Text = "<WitherKeywords0:Sa sút trí tuệ>"
  },
  State_127264_Desc = {
    Text = "Khi chơi thẻ bài này, \"Giác giả\" sẽ nhận được 1 lớp <MonsterTimeBeacon:Vòng lặp>. Nếu bỏ thẻ bài này, \"Giác giả\" sẽ mất 1 lớp <MonsterTimeBeacon:Vòng lặp>."
  },
  State_127264_Name = {
    Text = "<MonsterSightUnbound:Mắt Siêu Việt>"
  },
  State_127266_Desc = {
    Text = "Thân thể được đánh thức này chưa thức tỉnh… Khi sắp ngã gục sẽ thức tỉnh, hồi phục sức sống và bắt đầu chiến đấu với hình thái thật sự."
  },
  State_127266_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_127267_Desc = {
    Text = "Vào cuối lượt, nhận được 1 lớp <MonsterTimeBeacon:vòng lặp>."
  },
  State_127267_Name = {
    Text = "Sự đảo ngược tăng entropy"
  },
  State_127271_Desc = {
    Text = "Sau khi giải phóng lệnh khóa, bản thân nhận được 1 lớp <MonsterTimeBeacon:Vòng lặp> ."
  },
  State_127271_Name = {
    Text = "tù nhân Moebius"
  },
  State_127272_Desc = {
    Text = "Giới hạn 3 lớp. Khi \"Giác giả\" phát động ý định và có 3 lớp <MonsterTimeBeacon:Vòng lặp>, kích hoạt hiệu ứng <MonsterTimeBeacon:Vòng lặp>, xóa sạch <MonsterTimeBeacon:Vòng lặp> và loại bỏ trạng thái tiêu cực."
  },
  State_127272_Name = {
    Text = "<WhiteWord:Vòng lặp>"
  },
  State_127275_Desc = {
    Text = "Mỗi khi sở hữu 1 lớp, ngộ độc cố định nhận vào tăng 5%, sát thương gây ra giảm [DescArg1]%, tối đa [DescArg2] lớp."
  },
  State_127275_Name = {
    Text = "<WitherKeywords:Sa sút trí tuệ>"
  },
  State_127276_Desc = {
    Text = "Khi chơi thẻ bài này, \"Giác giả\" sẽ nhận được 1 lớp <MonsterTimeBeacon:Vòng lặp>. Nếu bỏ thẻ bài này, \"Giác giả\" sẽ mất 1 lớp <MonsterTimeBeacon:Vòng lặp>."
  },
  State_127276_Name = {
    Text = "<MonsterSightUnbound:Mắt Siêu Việt>"
  },
  State_127312_Desc = {
    Text = "Khi phát triển nhân cách của thể thức tỉnh đạt +12 sẽ kích hoạt \"Quy tắc cuối cùng\", sau khi kích hoạt có thể nhận được một số hiệu ứng đặc biệt."
  },
  State_127312_Name = {
    Text = "<UltraPotencyKeywords:Quy Luật Tối Thượng>"
  },
  State_127705_Desc = {
    Text = "Thẻ bài đã bị can thiệp! Sau khi chơi sẽ nhận [Layer] điểm sát thương và khiến số lớp <CardKeyWord:Phá Hoại Ngầm> giảm một nửa."
  },
  State_127705_Name = {
    Text = "<CardKeyWord:phá hoại trong bóng tối>"
  },
  State_127705_WeaponDesc = {
    Text = "Sau khi đánh thẻ bài, chịu [StateArg1] điểm thương."
  },
  State_127708_Desc = {
    Text = "Sau khi kẻ địch đánh ra thẻ bài không phải thẻ lệnh, tất cả đồng minh nhận được [DescArg1] lớp <PowerIconKeywords:lực lượng>. Tàn tro cũ sẽ không còn hiệu lực sau khi bị phá vỡ."
  },
  State_127708_Name = {Text = "Tơ Loạn"},
  State_127709_Name = {
    Text = "Trạng thái người chơi Sợi dây đen"
  },
  State_127710_Name = {
    Text = "Kích hoạt sợi dây đen"
  },
  State_128026_Name = {
    Text = "Trạng thái người chơi sợi trắng"
  },
  State_128027_Desc = {
    Text = "Sau khi kẻ địch chơi thẻ lệnh, tất cả đồng minh nhận [DescArg1] lớp tạm thời <ReinforcePVEKeywords:củng cố>. Tàn tro cũ sẽ không còn hiệu lực sau khi bị phá vỡ."
  },
  State_128027_Name = {Text = "Tơ Luật"},
  State_128028_Desc = {
    Text = "Thẻ bài đã bị can thiệp! Sau khi chơi sẽ nhận <FixedDamage:Sát Thương Thuần Túy>, và giảm một nửa số lớp <BrokenCard:Phá Hoại Ngầm>."
  },
  State_128028_Name = {
    Text = "<CardKeyWord:phá hoại trong bóng tối>"
  },
  State_128028_WeaponDesc = {
    Text = "Sau khi đánh thẻ bài, chịu [StateArg1] điểm thương."
  },
  State_128029_Name = {
    Text = "Sợi dây trắng kích hoạt"
  },
  State_128067_Name = {
    Text = "Trạng thái@nhện lạnh Pelayan Tàn tro theo dõi"
  },
  State_128069_Name = {
    Text = "Trạng thái@nhện lạnh Pelayan Vướng víu kiểm tra trúng đích"
  },
  State_128071_Name = {
    Text = "Trạng thái@Pelayan Nhện Lạnh vị trí trước cần dấu hiệu triệu hồi"
  },
  State_128073_Desc = {
    Text = "Sau mỗi lần hành động kết thúc, nhận được [DescArg1] lớp <ParcloseIconKeywords:rào cản> và [DescArg2] lớp <Chapter5_Monster_Fervor1:Cuồng nhiệt>."
  },
  State_128073_Name = {
    Text = "Nôi Của Mẫu Dệt"
  },
  State_128082_Desc = {
    Text = "Sau khi đánh ra, Hamlin nhận được 3 điểm điên cuồng."
  },
  State_128082_Name = {
    Text = "<XushiBKeywords:âm nhạc tích lũy sức mạnh>"
  },
  State_128086_Desc = {
    Text = "Sau khi kẻ địch chơi thẻ lệnh, bản thân nhận được [DescArg1] lớp<Chapter5_Monster_Fervor1:Cuồng nhiệt>, sau khi phá vỡ\"Tàn tro cũ\" thay đổi vị trí với đồng minh ở hàng sau."
  },
  State_128086_Name = {
    Text = "Túc Mệnh Luân Chuyển"
  },
  State_128087_Name = {
    Text = "Trạng thái@nhện lạnh Nữ hầu Trắng của vòng luân hồi dấu hiệu kích hoạt"
  },
  State_128089_Name = {
    Text = "Xuyên Tạc Trắng Kích Hoạt"
  },
  State_128216_Name = {
    Text = "Trạng thái người chơi vòng luân hồi trắng"
  },
  State_128245_Desc = {
    Text = "Vào đầu lượt sẽ được xóa bỏ. Khi đạt 10 lớp, lần đánh bài tiếp theo sẽ ngay lập tức hành động, loại bỏ <Chapter5_Monster_Fervor2:Cuồng nhiệt> và chuyển đổi ý định thành áp dụng <FragileIconKeywords:mong manh> và thêm ngẫu nhiên <BrokenCard:phá hủy trong bóng tối> của \"sợi đứt gãy\"."
  },
  State_128245_Name = {
    Text = "Tạm thời cuồng nhiệt"
  },
  State_128246_Name = {
    Text = "Trạng thái người chơi vòng hồi đen"
  },
  State_128247_Desc = {
    Text = "Sự phục sinh sau khi chết, miễn dịch với sát thương và có 100% sinh lực. Chuyển ý định thành:\"Cuồng nhiệt định mệnh\": Sau mỗi lần kết thúc hoạt động, nhận được [DescArg1] điểm <PowerIconKeywords:lực lượng> và [DescArg2] tầng <Chapter5_Monster_Fervor2:Cuồng nhiệt>."
  },
  State_128247_Name = {
    Text = "Phá Kén Tái Sinh"
  },
  State_128248_Desc = {
    Text = "Vào đầu lượt sẽ được xóa bỏ, khi đạt 10 lớp, lần đánh bài tiếp theo sẽ ngay lập tức hoạt động, loại bỏ <Chapter5_Monster_Fervor1:Cuồng nhiệt> và chuyển đổi ý định thành áp đặt <WeaknessIconKeywords:Suy nhược> và phong ấn ngẫu nhiên thẻ lệnh của \"Hạn chế Lưới giăng\"."
  },
  State_128248_Name = {
    Text = "Tạm thời cuồng nhiệt"
  },
  State_128250_Name = {
    Text = "Kích hoạt vòng hồi đen"
  },
  State_128251_Desc = {
    Text = "Sau khi kẻ địch đánh ra thẻ không phải thẻ lệnh, bản thân nhận được [DescArg1] lớp <Chapter5_Monster_Fervor2:Cuồng nhiệt>, sau khi phá vỡ\"Tàn tro cũ\"đổi vị trí với đồng minh ở hàng sau."
  },
  State_128251_Name = {
    Text = "Uyên Ngục Luân Chuyển"
  },
  State_128253_Desc = {
    Text = "Sự phục sinh sau khi chết, miễn dịch với sát thương và có 100% sinh lực. Chuyển ý định thành:\"Cuồng nhiệt định mệnh\": Sau mỗi lần hoạt động kết thúc, nhận được [DescArg1] lớp <ParcloseIconKeywords:rào cản> và [DescArg2] lớp <Chapter5_Monster_Fervor1:Cuồng nhiệt>."
  },
  State_128253_Name = {
    Text = "Phá Kén Tái Sinh"
  },
  State_128257_Desc = {
    Text = "Sau mỗi lần kết thúc hoạt động, nhận được [DescArg1] điểm <PowerIconKeywords:lực lượng> và [DescArg2] tầng <Chapter5_Monster_Fervor2:Cuồng nhiệt>."
  },
  State_128257_Name = {
    Text = "Lời Thì Thầm Của Mẫu Dệt"
  },
  State_128643_Name = {
    Text = "Trạng thái@Số lần người chơi chơi triệu chứng trong lượt này"
  },
  State_128644_Desc = {
    Text = "Vào đầu lượt sẽ được xóa bỏ. Khi đạt 10 lớp, lần đánh bài tiếp theo sẽ ngay lập tức hoạt động, loại bỏ <Chapter5_Monster_Fervor3:Cuồng nhiệt> và ngẫu nhiên chuyển đổi ý định."
  },
  State_128644_Name = {
    Text = "Tạm thời cuồng nhiệt"
  },
  State_128645_Desc = {
    Text = "Ý định sẽ được chọn ngẫu nhiên từ bốn loại ý định, nhưng sẽ không trùng lặp. Sau khi phát động bùng nổ điên cuồng ngay lập tức chuyển đổi ý định. Sau khi chơi thẻ lệnh nhận được 1 lớp <Chapter5_Monster_Fervor3:Cuồng nhiệt>."
  },
  State_128645_Name = {
    Text = "Vạn diện đồng điều"
  },
  State_128646_Name = {
    Text = "Trạng thái@ý định số phận hỗn loạn không đủ điều kiện Đòn đánh nặng xuất bài kiểm tra"
  },
  State_128648_Desc = {
    Text = "Cho đến khi bắt đầu lượt tiếp theo, mỗi lần chơi 1 lá thẻ lệnh sẽ nhận được tạm thời [DescArg1] điểm <PowerIconKeywords:lực lượng>."
  },
  State_128648_Name = {
    Text = "Kén Bạo Nộ"
  },
  State_128692_Desc = {
    Text = "Sau khi chịu sát thương chủ động hoặc sát thương xúc tu, loại bỏ lượng \"Tàn Tro Cựu Nhật\" tương đương và mất 300% lượng loại bỏ sinh mệnh, khi chịu sát thương khác thì loại bỏ một nửa. Số tầng \"Tàn Tro Cựu Nhật\"được đặt lại mỗi lượt."
  },
  State_128692_Name = {
    Text = "<AshesPastKeyWord:Tàn tro cũ>"
  },
  State_128695_Name = {
    Text = "Trạng thái@ý định số phận hỗn loạn"
  },
  State_129297_Desc = {
    Text = "Trong [Layer] trận chiến tiếp theo, làm cho tất cả kẻ địch có sinh lực là 1."
  },
  State_129297_Name = {
    Text = "Sự hỗ trợ của nhỏ\"N\""
  },
  State_129569_Name = {
    Text = "Trạng thái@ý định số phận hỗn loạn hạnh phúc kịch trường kích hoạt đánh dấu"
  },
  State_129570_Name = {
    Text = "Trạng thái@ý định số phận hỗn loạn thầm thì kích hoạt đánh dấu"
  },
  State_129571_Name = {
    Text = "Trạng thái@ý định số phận hỗn loạn vô tận hư vô kích hoạt đánh dấu"
  },
  State_129612_Desc = {
    Text = "Ý định sẽ được chọn ngẫu nhiên từ bốn loại ý định, nhưng sẽ không trùng lặp. Sau khi phát động bùng nổ điên cuồng ngay lập tức chuyển đổi ý định. Sau khi chơi thẻ lệnh nhận được 1 lớp <Chapter5_Monster_Fervor3:Cuồng nhiệt>."
  },
  State_129612_Name = {
    Text = "Vạn diện đồng điều"
  },
  State_129625_Desc = {
    Text = "Ý đồ sẽ ngẫu nhiên từ bốn loại ý đồ, nhưng không lặp lại. Sau khi giải phóng Cuồng Khí Bộc Phát sẽ lập tức chuyển đổi ý đồ. Sau khi đánh ra thẻ chỉ lệnh nhận được 1 tầng <Chapter5_Monster_Fervor3:Cuồng Nhiệt>. Mỗi lần chuyển đổi ý đồ nhận được 1 tầng \"Mệnh Đồ Hỗn Loạn\"."
  },
  State_129625_Name = {
    Text = "Vạn diện đồng điều"
  },
  State_129643_Desc = {
    Text = "Nhận được 1 tầng mỗi lần chuyển đổi ý đồ, khi sở hữu 10 tầng \"Mệnh Đồ Hỗn Loạn\", ý đồ sẽ điều chỉnh thành \"Cuồng Yến Phá Kén\" không thể chuyển đổi và gây sát thương lớn cùng suy yếu."
  },
  State_129643_Name = {
    Text = "Mệnh Đồ Hỗn Loạn"
  },
  State_129644_Name = {
    Text = "Ý định khóa biến dạng và tan chảy"
  },
  State_129650_Desc = {
    Text = "Đội duy nhất: Nếu Người trang bị là Thể thức tỉnh \"Vòng tròn · Ramona\", tỷ lệ đồng điều nhận được khi các Thể thức tỉnh khác khám phá màn chơi tăng lên <WeaponEffect_Num:[StateArg1]%>, nhưng bản thân không nhận được tỷ lệ đồng điều."
  },
  State_129650_WeaponDesc = {
    Text = "Nếu người trang bị là Thể thức tỉnh \"Vòng tròn · Ramona\", tỷ lệ đồng điều mà các Thể thức tỉnh khác nhận được khi hoàn thành màn chơi sẽ được tăng lên <WeaponEffect_Num:[StateArg1]%>, nhưng bản thân không nhận được tỷ lệ đồng điều."
  },
  State_129761_Desc = {
    Text = "Sửa đổi giao diện trả về giá trị cường độ phát triển trong trận của người chơi, mỗi 1 lớp tăng 1%."
  },
  State_129761_Name = {
    Text = "Sửa đổi cường độ phát triển trong trận"
  },
  State_129845_Desc = {
    Text = "Thân thể được đánh thức này chưa thức tỉnh… Khi sắp ngã gục sẽ thức tỉnh, hồi phục sức sống và bắt đầu chiến đấu với hình thái thật sự."
  },
  State_129845_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_129846_Name = {
    Text = "Đếm Đứt Tơ Chấn Minh"
  },
  State_129848_Desc = {
    Text = "Mỗi khi [DescArg1] thẻ bài rời khỏi khe nứt chiều, sẽ được gán [DescArg2] lớp <BrokenCard:phá hoại trong bóng tối>."
  },
  State_129848_Name = {
    Text = "Khai Màn Sân Khấu Rối"
  },
  State_129849_Desc = {
    Text = "Tạo bản sao của thẻ lệnh đầu tiên mà kẻ địch chơi mỗi lượt vào khe nứt chiều. Khi thẻ bài vào khe nứt chiều, gán cho nó <DepleteIconKeywords:tiêu thụ>. Mỗi lượt, khi phát hành mật lệnh lần đầu tiên, sẽ lấy thẻ bài bên trái nhất ra và đặt nó lên đầu bộ bài rút bài."
  },
  State_129849_Name = {
    Text = "Khảy Sợi Tơ Vận Mệnh"
  },
  State_129850_Desc = {
    Text = "Mỗi khi có một thẻ lệnh trong khe nứt chiều, giới hạn tay của người chơi giảm 1. Nếu đã đầy, lần tiếp theo khi chơi thẻ, \"Mạng vĩnh cửu\" sẽ ngay lập tức hoạt động, sau khi hoạt động sẽ làm trống khe nứt chiều và điều chỉnh ý định thành \"Bài ca bi thảm vượt số phận\"."
  },
  State_129850_Name = {
    Text = "Đứt Tơ Chấn Minh"
  },
  State_129854_Desc = {
    Text = "Mỗi lá bài chỉ lệnh trong Khe Nứt Chiều Không gian sẽ giảm 1 giới hạn bài trên tay người chơi. Nếu đã đầy, lần đánh bài tiếp theo,\"Mạng Lưới Vĩnh Hằng\" sẽ lập tức hành động, sau khi hành động sẽ xóa sạch Khe Nứt Chiều Không gian, chuyển ý đồ thành \"Mệnh Đồ, Theo Đây Dụ Thị\"."
  },
  State_129854_Name = {
    Text = "Đứt Tơ Chấn Minh"
  },
  State_129864_Desc = {
    Text = "Mỗi khi tung ra thẻ, loại bỏ 1 lớp \"Buồn ngủ\". Vào đầu lượt, khôi phục lại 12 lớp \"Buồn ngủ\"."
  },
  State_129864_Name = {
    Text = "Giận dữ"
  },
  State_129865_Desc = {
    Text = "Thân thể được đánh thức này chưa thức tỉnh… Khi sắp ngã gục sẽ thức tỉnh, hồi phục sức sống và bắt đầu chiến đấu với hình thái thật sự."
  },
  State_129865_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_129872_Desc = {
    Text = "Biến tạm thời."
  },
  State_129872_Name = {
    Text = "Bảng đếm1"
  },
  State_129873_Desc = {
    Text = "Nhận trạng thái đếm lớp [Layer] _Bảng đếm 1_."
  },
  State_129873_Name = {
    Text = "Kiểm tra đóng gói 1"
  },
  State_129874_Desc = {
    Text = "Biến tạm thời."
  },
  State_129874_Name = {
    Text = "Bộ khuếch đại 1"
  },
  State_130358_Desc = {
    Text = "Thẻ lệnh tiếp theo được đánh ra sẽ có hiệu lực thêm 2 lần."
  },
  State_130358_Name = {Text = "Rối dây"},
  State_130387_Desc = {
    Text = "Sau khi tiêu hao \"Con rối\", thẻ lệnh đầu tiên đánh ra trong mỗi lượt sẽ có hiệu lực thêm 2 lần. Nếu là Trận chiến Lãnh đạo, tất cả các Thể thức tỉnh sẽ nhận được 50 điểm điên cuồng và 1000 điểm năng lượng chìa khóa bạc."
  },
  State_130387_Name = {
    Text = "Lễ tang của số phận"
  },
  State_130388_Name = {
    Text = "<RetainIconKeywords:Giữ lại>:Nhận được [DescArg1] năng lượng chìa khóa bạc"
  },
  State_130389_Desc = {
    Text = "Sau khi chơi, khiến tất cả các thể thức tỉnh nhận được [DescArg1] điểm điên cuồng"
  },
  State_130389_Name = {
    Text = "Sau khi chơi, khiến tất cả các thể thức tỉnh nhận được [DescArg1] điểm điên cuồng"
  },
  State_130390_Desc = {
    Text = "Giới hạn Điểm tính toán và Kích tước tay tối đa tăng 1."
  },
  State_130390_Name = {
    Text = "Kiến thức dư thừa"
  },
  State_130391_Desc = {
    Text = "Mỗi lần chơi 1 thẻ triệu chứng, tiêu thụ sức tính toán của「Rối dây」giảm 1."
  },
  State_130391_Name = {
    Text = "Âm vang ô uế"
  },
  State_130490_Desc = {
    Text = "Thẻ bài này tăng thương, lá chắn, chữa trị, lực lượng, hấp thụ, thương tổn xúc tu, ngộ độc cố định, phản công cố định, độc lập tính toán 1+[Layer]%."
  },
  State_130490_Name = {
    Text = "Đèn hiệu kỳ dị α"
  },
  State_130498_Desc = {
    Text = "Thẻ lệnh tiếp theo được đánh ra sẽ có hiệu lực thêm 2 lần."
  },
  State_130498_Name = {
    Text = "Lễ tang của số phận"
  },
  State_130500_Desc = {
    Text = "Trong trận chiến Lãnh đạo, kháng cự tử vong +100%. Sau khi kích hoạt \"kháng cự tử vong\", ở lượt tiếp theo \"Con rối điều khiển\" sẽ không còn ép buộc chơi thẻ lệnh nữa, mà sẽ chọn một thẻ lệnh trong tay."
  },
  State_130500_Name = {
    Text = "Ánh mắt ngoảnh lại của kẻ tử vì đạo"
  },
  State_130501_Desc = {
    Text = "Thẻ lệnh tiếp theo có giá trị Điểm tính toán giảm xuống còn 0."
  },
  State_130501_WeaponDesc = {
    Text = "Trước khi đánh ra, thay đổi chỉ số thẻ"
  },
  State_130512_Desc = {
    Text = "Thẻ lệnh tiếp theo được đánh ra sẽ có hiệu lực thêm 2 lần và tiêu thụ sức tính toán giảm 2 điểm."
  },
  State_130512_Name = {Text = "Rối dây"},
  State_130517_Desc = {
    Text = "<PVPWeaponKeywords:Mệnh Luân>: Khi trang bị và khi bắt đầu lượt, kích hoạt ngẫu nhiên một trong các hiệu quả sau: Nhận <Energy:[Energy:StateArg1]> cuồng khí và <PVPSlowKeywords:Trì hoãn> bản thân; Nhận <Energy:[Energy:StateArg3]> cuồng khí; Nhận <Energy:[Energy:StateArg4]> và [StateArg5] lá <PVPDerivativeCardKeywords_17:「Linh Cảm」>."
  },
  State_130517_Name = {
    Text = "Trí tuệ của cuộc đánh bạc lớn"
  },
  State_131046_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>:\"Bùng nổ\" sau khi làm cho bản thân nhận được <Block:[Block:StateArg1]> lá chắn và <DelayKeywords:Trì hoãn>: <Energy:[Energy:StateArg2]> điên cuồng."
  },
  State_131046_Name = {
    Text = "Vườn địa đàng xa xôi"
  },
  State_131047_Desc = {
    Text = "Trong lượt này, [Layer] lần sử dụng lệnh khóa tiếp theo sẽ có hiệu lực 2 lần."
  },
  State_131047_Name = {
    Text = "Lệnh Khóa Đôi"
  },
  State_131048_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>: Sau lần đầu tiên chơi \"Kỹ Năng\" trong mỗi lượt, gây <Damage:[Damage:StateArg1]> thương lên kẻ địch có <HPAndShieldMin:Sinh lực và lá chắn thấp nhất>."
  },
  State_131048_Name = {
    Text = "Điên rồ bị giam cầm"
  },
  State_131055_Desc = {
    Text = "Số lượng rút thẻ mỗi lượt -1. Tất cả các thân thể được đánh thức tăng 20% hiệu ứng tạo lá chắn và hồi phục sức sống."
  },
  State_131055_Name = {
    Text = "Chải tóc"
  },
  State_131056_Desc = {
    Text = "Mất sinh lực sẽ chuyển hóa một lượng điên cuồng trễ tương đương thành lá chắn."
  },
  State_131056_Name = {
    Text = "Bảo vệ dòng xoáy"
  },
  State_131058_Desc = {
    Text = "Tất cả các thể thức tỉnh tăng cơ bản điên cuồng 10 điểm. Sau khi phát động cơn thịnh nộ bùng phát, nhận được 1 điểm tính toán, mỗi thể thức tỉnh chỉ có thể kích hoạt 1 lần trong 1 lượt."
  },
  State_131058_Name = {
    Text = "Cọ cọ má"
  },
  State_131059_Name = {
    Text = "Dấu hiệu nâng cấp chiêu thức Mosk"
  },
  State_131061_Desc = {
    Text = "Giới hạn năng lượng chìa khóa bạc và tiêu hao năng lượng chìa khóa cho lệnh khóa +350. Lần đầu tiên mỗi lượt, lệnh khóa có hiệu lực 2 lần."
  },
  State_131061_Name = {
    Text = "Cho ăn vặt"
  },
  State_131064_Desc = {
    Text = "Sau khi giải phóng điên cuồng bùng nổ, nhận được 1 điểm sức tính toán, mỗi thân thể được đánh thức chỉ có thể kích hoạt 1 lần trong 1 lượt."
  },
  State_131064_Name = {
    Text = "Cọ cọ má"
  },
  State_131069_Desc = {
    Text = "Tất cả thân thể được đánh thức tăng 20% hiệu quả tạo lá chắn và hồi sức sống."
  },
  State_131069_Name = {
    Text = "Chải tóc"
  },
  State_131073_Desc = {
    Text = "Đội duy nhất: Khi trận đấu bắt đầu, nhận được điên cuồng tương đương với <WeaponEffect_Num:[StateArg1]%> điên cuồng cơ bản. Sát thương cuối cùng của cơn bùng nổ điên cuồng của người trang bị tăng lên, tỷ lệ phần trăm là <WeaponEffect_Num:[StateArg2]%> của điên cuồng cơ bản. Khi chuyển sang tư thế \"Sóng Gẩm\", nhận được sự thông thạo giới vực tạm thời tương đương với <WeaponEffect_Num:[StateArg3]%> hiện tại, thời gian hồi chiêu 3 lượt."
  },
  State_131073_WeaponDesc = {
    Text = "Khi bắt đầu trận chiến, nhận được [DescArg1] điểm điên cuồng. Sát thương cuối cùng của người trang bị khi bùng nổ điên cuồng tăng lên [DescArg2]%. Khi chuyển sang tư thế\"Sóng Gẩm\", nhận được [DescArg3] điểm sự thông thạo giới vực tạm thời, thời gian hồi chiêu 3 lượt(còn lại [DescArg4] lượt)."
  },
  State_131078_Desc = {
    Text = "Mỗi lượt, lần đầu tiên sử dụng lệnh khóa sẽ có hiệu lực 2 lần."
  },
  State_131078_Name = {
    Text = "Cho ăn vặt"
  },
  State_131118_Desc = {
    Text = "Mỗi lần nhận sát thương hoặc mất sinh mệnh, không thể vượt quá 3% sinh mệnh tối đa."
  },
  State_131118_Name = {
    Text = "Kén Ngàn Tơ"
  },
  State_131123_Desc = {
    Text = "Vào đầu lượt sẽ được xóa bỏ. Khi đạt 10 lớp, lần đánh bài tiếp theo sẽ ngay lập tức hoạt động và chuyển sang ý định tiếp theo, loại bỏ <Chapter5_Monster_Fervor4:Cuồng nhiệt>."
  },
  State_131123_Name = {
    Text = "Tạm thời cuồng nhiệt"
  },
  State_131127_Desc = {
    Text = "Tư thế bị số phận ràng buộc. Mỗi khi kẻ địch chơi 1 thẻ lệnh, bản thân nhận được 1 tầng tạm thời cuồng nhiệt."
  },
  State_131127_Name = {
    Text = "Phược Thệ Khế Ước"
  },
  State_131134_Desc = {
    Text = "Sau khi tử vong, Nepherea nhận [DescArg1] tầng Cuồng Nhiệt tạm thời, nhưng mất 3% sinh mệnh tối đa."
  },
  State_131134_Name = {
    Text = "Cổng Uyên Ngục"
  },
  State_131186_Desc = {
    Text = "Sau khi đánh ra, hiệu lực thêm 1 lần, nhưng nhận [DescArg1] điểm sát thương."
  },
  State_131186_Name = {
    Text = "<ExclamationPointColour:số phận vụn vỡ>"
  },
  State_131188_Desc = {
    Text = "\"Kỹ năng\"đánh ra sẽ đi vào \"Khe Nứt Chiều Không\" và gắn thêm \"Tàn Phá Định Mệnh\" cho tất cả kỹ năng cùng tên, sau khi rời Khe Nứt Chiều Không sẽ xóa bỏ. Khi Khe Nứt Chiều Không đầy,\"Mạng Lưới Phản Bội\" Nephrea sau khi hành động sẽ xóa sạch Khe Nứt Chiều Không, chuyển ý đồ tiếp theo thành Cuồng Khí Bộc Phát mạnh mẽ."
  },
  State_131188_Name = {
    Text = "Khe nứt chiều"
  },
  State_131191_Name = {
    Text = "Rối loạn nhận thức"
  },
  State_131242_Desc = {
    Text = "Thẻ bài này tăng thương, lá chắn, chữa trị, lực lượng, hấp thụ, thương tổn xúc tu, ngộ độc cố định, phản công cố định, độc lập tính toán 1+[Layer]%."
  },
  State_131242_Name = {
    Text = "Hải đăng kỳ dị β"
  },
  State_131258_Desc = {
    Text = "Xoay sợi chỉ trên xa quay, khuấy động vận mệnh sai lầm. Sau khi giải phóng lệnh khóa hoặc đánh ra lá bài \"Mảnh Vỡ Vận Mệnh\" sẽ xóa 1 tầng, sau khi xóa toàn bộ Arachne giải phóng đòn truy kích \"Mỗi Sợi Chỉ Về Đúng Chỗ\", gây sát thương cao. Sau 3 lần giải phóng sẽ khiến \"Kén Nghìn Tơ\" của kẻ địch tan vỡ hoàn toàn!"
  },
  State_131258_Name = {
    Text = "Mệnh Võng Nhiễu Động"
  },
  State_131261_Name = {
    Text = "Hý Trường Phá Diệt"
  },
  State_131351_Desc = {
    Text = "Các thể thức tỉnh khác sau khi phóng thích điên cuồng bùng nổ sẽ tiêu hao 1 lớp, Mosk phóng thích \"Xoáy! Lưu! Đạn!\"để truy đuổi."
  },
  State_131351_Name = {
    Text = "Nạp đạn dòng xoáy"
  },
  State_131439_Desc = {
    Text = "Thẻ lệnh tiếp theo được đánh ra sẽ có hiệu lực thêm 2 lần và giá trị điểm tính toán giảm xuống 0."
  },
  State_131439_Name = {Text = "Rối dây"},
  State_131637_Desc = {
    Text = "Sau khi chết lập tức triệu hồi một \"Nhện Bầy Vực Ngục\" hoặc \"Nhện Bầy Lạnh\" ngẫu nhiên, khiến \"Hiệu Ứng Bầy Đàn\" của chúng giảm 1 tầng."
  },
  State_131637_Name = {
    Text = "Hiệu ứng tập trung"
  },
  State_131638_Desc = {
    Text = "Sau khi chết lập tức triệu hồi một \"Mẫu Thể Vỡ Tướng\" hoặc \"Mẫu Thể Quấn Tơ\" ngẫu nhiên, khiến \"Hiệu Ứng Bầy Đàn\" của chúng giảm 1 tầng."
  },
  State_131638_Name = {
    Text = "Hiệu ứng tập trung"
  },
  State_131645_Desc = {
    Text = "Đội duy nhất: Khi chuyển sang tư thế\"Sóng Gẩm\", nhận được sự thông thạo giới vực tạm thời <WeaponEffect_Num:[StateArg1]%>, hồi chiêu trong 3 lượt."
  },
  State_131645_WeaponDesc = {
    Text = "Chuyển sang tư thế\"Sóng Gẩm\" nhận được [DescArg2] điểm sự thông thạo giới vực tạm thời, hồi chiêu 3 lượt(còn lại [DescArg1] lượt)."
  },
  State_131657_Desc = {
    Text = "Các thể thức tỉnh khác sau khi phóng thích điên cuồng bùng nổ sẽ tiêu hao 1 lớp, Mosk phóng thích \"Xoáy! Lưu! Đạn!\"để truy đuổi."
  },
  State_131657_Name = {
    Text = "<WhirlpoolKeywords:dòng xoáy nạp đạn>"
  },
  State_131660_Desc = {
    Text = "Mỗi khi có 1 lớp sẽ tăng 1 điểm yêu cầu điên cuồng để kích hoạt cơn thịnh nộ bùng phát."
  },
  State_131660_Name = {
    Text = "Sửa đổi giá trị cố định tiêu thụ điên cuồng"
  },
  State_131675_Desc = {
    Text = "Thẻ bài này có [StateArg1]% khả năng sẽ có hiệu lực thêm 1 lần khi chơi lần tiếp theo."
  },
  State_131675_Name = {
    Text = "<CardKeyWord:đặt cược lớn>"
  },
  State_131684_Desc = {
    Text = "Lệnh \"Đạn xoáy！\" tiếp theo sẽ có hiệu lực trong [Layer] lần và áp dụng 2 lần."
  },
  State_131684_Name = {
    Text = "Musk! Lớn! Rầm! Nổ"
  },
  State_131749_Desc = {
    Text = "Đội duy nhất: Sau khi bắt đầu khám phá, xáo trộn 1 lá \"Trí tuệ của cuộc đánh bạc lớn\" vào rút bài từ bộ bài. \"Trí tuệ của cuộc đánh bạc lớn\": tiêu thụ 1 điểm tính toán. Xáo trộn tất cả thẻ lệnh trong tay vào rút bài từ bộ bài một cách ngẫu nhiên, các thẻ lệnh được xáo trộn sẽ có <WeaponEffect_Num:[StateArg1]%> khả năng có hiệu lực thêm 1 lần khi đánh ra lần tiếp theo, và mỗi khi xáo trộn 1 lá thẻ lệnh sẽ khiến tất cả các thể thức tỉnh nhận được 2 điểm điên cuồng. <RetainIconKeywords:Giữ lại>. <DepleteIconKeywords:tiêu thụ>. <GuyouKeywords:Bẩm sinh>."
  },
  State_131749_WeaponDesc = {
    Text = "Sau khi bắt đầu khám phá, thêm 1 lá \"Trí tuệ của cuộc đánh bạc lớn\" vào rút bài từ bộ bài. \"Trí tuệ của cuộc đánh bạc lớn\": tiêu thụ 1 điểm tính toán. Xáo trộn tất cả thẻ lệnh trong tay và đưa vào rút bài từ bộ bài, các thẻ lệnh đã xáo trộn có <WeaponEffect_Num:[StateArg1]%> khả năng có hiệu lực thêm 1 lần khi đánh ra lần sau, và mỗi lá thẻ lệnh được xáo trộn sẽ khiến tất cả các thể thức tỉnh nhận được 2 điểm điên cuồng. <RetainIconKeywords:giữ lại>. <DepleteIconKeywords:tiêu thụ>. <GuyouKeywords:bẩm sinh>."
  },
  State_131769_Name = {
    Text = "Trạng thái@Nhân giống thịt máu khởi tạo chức nghiệp siêu chiều 1"
  },
  State_131779_Desc = {
    Text = "Sau khi sử dụng [Layer] lần, thẻ bài mới vào rác bài và đặt lại số lần, nhưng \"Khắc ấn\" chỉ có hiệu lực khi sử dụng lần đầu."
  },
  State_131779_Name = {
    Text = "Có thể sử dụng [Layer] lần"
  },
  State_131789_Desc = {
    Text = "Biện pháp thay thế. Chọn 1 thẻ bài có tid là [Layer] và thêm vào tay."
  },
  State_131789_Name = {
    Text = "Thêm thẻ bài chỉ định"
  },
  State_131807_Name = {
    Text = "Trạng thái@Nhân giốngthịt máu thuần túy"
  },
  State_131824_Name = {
    Text = "Trạng thái@quái vật Tà Vy chuyển đổi ý định người chơi theo dõi"
  },
  State_131846_Desc = {
    Text = "Sau khi chết lập tức triệu hồi một \"Nhện Bầy Vực Ngục\" hoặc \"Nhện Bầy Lạnh\" ngẫu nhiên, khiến \"Hiệu Ứng Bầy Đàn\" của chúng giảm 1 tầng."
  },
  State_131846_Name = {
    Text = "Hiệu ứng tập trung"
  },
  State_131908_Desc = {
    Text = "Chia sẻ HP, khiên và cuồng khí của mục tiêu, nhưng không tạo thống kê chiến đấu."
  },
  State_131908_Name = {
    Text = "Tiệc Thối Rữa nhảy"
  },
  State_131909_Desc = {
    Text = "Có trạng thái này thì pháp sử dụng bùng nổ."
  },
  State_131909_Name = {
    Text = "Phong ấn vĩnh viễn"
  },
  State_132366_Desc = {
    Text = "Tiến hành truy kích sau khi Thể Thức Tỉnh khác sử dụng thẻ đánh"
  },
  State_132366_Name = {
    Text = "Truy đuổi"
  },
  State_132465_Desc = {
    Text = "Sát thương, hộ thuẫn, hồi phục, sức mạnh, suy kiệt, sát thương xúc tu, trúng độc cố định, phản kích cố định do thể thức tỉnh này gây ra được tăng, nhân độc lập 1+[Layer]%."
  },
  State_132465_Name = {
    Text = "Cường Hóa Nuốt Chửng α"
  },
  State_132469_Desc = {
    Text = "Sát thương, hộ thuẫn, hồi phục, sức mạnh, suy kiệt, sát thương xúc tu, trúng độc cố định, phản kích cố định do thể thức tỉnh này gây ra được tăng, nhân độc lập 1+[Layer]%."
  },
  State_132469_Name = {
    Text = "Cường Hóa Nuốt Chửng β"
  },
  State_132539_Desc = {
    Text = "Tạo vật kiểm tra tập hợp"
  },
  State_132539_Name = {
    Text = "Tạo vật kiểm tra tập hợp"
  },
  State_132539_WeaponDesc = {Text = "Kiểm tra"},
  State_132560_WeaponDesc = {
    Text = "Lửa xanh mỗi lần gây [Damage:StateArg2] lần thương, sẽ nhận được một lá bài tiêu thụ [Ngọn lửa xanh]."
  },
  State_132564_WeaponDesc = {
    Text = "Lửa xanh mỗi lần gây [Damage:StateArg2] lần thương, sẽ nhận được một lá bài tiêu thụ [Ngọn lửa xanh]."
  },
  State_132565_WeaponDesc = {
    Text = "Lửa xanh mỗi lần gây [Damage:StateArg2] lần thương, sẽ nhận được một lá bài tiêu thụ [Ngọn lửa xanh]."
  },
  State_132598_Desc = {
    Text = "Khi gây sát thương xúc tu trong lượt này, gây thêm trúng độc bằng [Layer]% giá trị sát thương."
  },
  State_132598_Name = {
    Text = "niềm ám ảnh bị chôn vùi"
  },
  State_132609_Desc = {
    Text = "Khi người điêu khắc áp dụng lá chắn, tăng [StateArg1] thương tổn râu chạm."
  },
  State_132609_Name = {
    Text = "Trạng thái quên mình"
  },
  State_132609_WeaponDesc = {
    Text = "Khi người điêu khắc áp dụng lá chắn, tăng [StateArg1] thương tổn râu chạm."
  },
  State_132669_Desc = {
    Text = "Sát thương, hộ thuẫn, hồi phục, sức mạnh, suy kiệt, sát thương xúc tu, trúng độc cố định, phản kích cố định do lá bài của thể thức tỉnh này gây ra được tăng, nhân độc lập 1+[Layer]%."
  },
  State_132669_Name = {
    Text = "Mệnh Định Siêu Chiều α"
  },
  State_132840_Name = {
    Text = "Hiệu ứng gia thành nhân cách thẻ chỉ lệnh của \"24\"được nhân đôi. Sau khi giải phóng bùng nổ cuồng khí, hiệu ứng nhân đôi gia thành nhân cách mất hiệu lực trong lượt này"
  },
  State_132891_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>: Khi trang bị nhận được [StateArg1] <StrongEffectKeywords:Mạnh>, sau khi đồng đội khác bùng nổ cuồng khí, cho họ nhận được <PVPOneMeetingKeywords:Nhất Kỳ Nhất Hội>."
  },
  State_132891_Name = {
    Text = "Mê tư dưới hoa anh đào"
  },
  State_132892_Desc = {
    Text = "·Khi nhận được, xóa trạng thái \"Nhất Kỳ Nhất Hội\" của các đồng đội khác, nhận hiệu ứng Sự khuếch đại tương đương với số đồng đội trang bị \"Điều huyền bí dưới hoa anh đào\", tối đa 3 lớp.\n·Nhân vật trang bị \"Điều huyền bí dưới hoa anh đào\" không thể nhận \"Nhất Kỳ Nhất Hội\"."
  },
  State_132892_Name = {
    Text = "Nhất Kỳ Nhất Hội"
  },
  State_133294_Name = {
    Text = "Lời mời đến Vương phủ"
  },
  State_133353_Desc = {
    Text = "<PVPWeaponKeywords:Vòng Mệnh>:Sau khi trang bị, không thể nhận biết mô tả\"Đả Kích\",\"Kỹ Năng\",\"Cuồng Khí Bộc Phát\" của người trang bị, nhưng mỗi lần sát thương, khiên, hồi phục được tăng ngẫu nhiên [StateArg1]%~[StateArg2]%."
  },
  State_133353_Name = {
    Text = "Cổ tích trong bùn lầy"
  },
  State_133354_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>: Giữ lại sau khi vòng mệnh này chết. Khi Người trang bị chết và sau [Layer] vòng tiếp theo kể từ khi ở Trạng thái chết, các đồng đội khác nhận được <Heal:[Heal:StateArg1]> <PVPFeatheredSeedsKeyWords:Vũ Chủng> và Sinh lực."
  },
  State_133354_Name = {
    Text = "Nguyện thế giới hóa thành hương thơm"
  },
  State_133369_Desc = {
    Text = "[DescArg1] lá bài chỉ lệnh không phải của Tavi được đánh ra tiếp theo sẽ phát huy hiệu lực 2 lần."
  },
  State_133369_Name = {
    Text = "Trải qua cửa khóa bạc"
  },
  State_133372_Desc = {
    Text = "Nếu đang ở lượt siêu chiều, kích hoạt hiệu ứng Kỳ Điểm Chiết Dược. \"Kỳ Điểm Hủy Diệt\" cũng có thể khiến Kỳ Điểm Chiết Dược lần tiếp theo trong lượt này chắc chắn phát động."
  },
  State_133372_Name = {
    Text = "<SingularityKeywords:Kỳ Điểm Chiết Dược>"
  },
  State_133391_Desc = {
    Text = "Nếu số tầng trạng thái này lớn hơn hoặc bằng sinh mệnh mục tiêu, xóa tất cả Phán Quyết Vận Mệnh và trực tiếp hạ gục mục tiêu. Phán Quyết Vận Mệnh cố định được áp dụng nhận thêm gia tăng cường hóa sát thương."
  },
  State_133391_Name = {
    Text = "<CutKeywords:Phán Quyết Vận Mệnh>"
  },
  State_133395_Desc = {
    Text = "[Layer] lá bài chỉ lệnh tiếp theo được đánh ra sẽ kích hoạt \"Xuyên Không Chiều Không Gian\"."
  },
  State_133395_Name = {
    Text = "Xuyên Không Chiều Không Gian"
  },
  State_133717_Desc = {
    Text = "Chủ sở hữu hiện tại là [Layer], tất cả lá bài hiện tại và tương lai của nhân vật này sẽ nhận thuộc tính tương ứng (hiện tại: Phong Ấn Lá Bài)."
  },
  State_133717_Name = {
    Text = "Lan Truyền Thuộc Tính Thẻ Bài"
  },
  State_133774_Desc = {
    Text = "Mỗi lớp làm tăng sát thương, lực lượng và thương tổn xúc tu cố định, ngộ độc cố định, phản công cố định của thẻ bài này thêm 2%; tăng lá chắn cố định, hồi phục sinh lực cố định, sức mạnh giảm xuống thêm 1%. Thẻ bài có Ngọn hải đăng kỳ điểm không thể kích hoạt \"Xuyên Không Chiều Không Gian\"."
  },
  State_133774_Name = {
    Text = "<SingularityKeywords1:Tín Hiệu Kỳ Điểm>"
  },
  State_133775_Desc = {
    Text = "Mỗi lớp làm tăng sát thương, lực lượng và thương tổn xúc tu cố định, ngộ độc cố định, phản công cố định của tất cả thẻ bài thể thức tỉnh thêm 2%; tăng lá chắn cố định, hồi phục sinh lực cố định, sức mạnh giảm xuống thêm 1%."
  },
  State_133775_Name = {
    Text = "<SingularityKeywords2:Lăng Kính Kỳ Điểm>"
  },
  State_133961_Desc = {
    Text = "Đội duy nhất: Sau khi bắt đầu khám phá, tạo một thẻ \"Thư Mùa Xuân\" đặt vào bộ bài: Giá trị Điểm tính toán 1, nhận <WeaponEffect_Num:[StateArg1]> điểm Năng lượng chìa khóa bạc, sau khi chơi vĩnh viễn biến đổi thành \"Anh Đào Mãn Khai\": Giá trị Điểm tính toán 1, nhận <WeaponEffect_Num:[StateArg2]> điểm Năng lượng chìa khóa bạc, sau khi chơi vĩnh viễn biến đổi thành \"Hoa Xuy Tuyết\": Giá trị Điểm tính toán 1, nhận <WeaponEffect_Num:[StateArg3]> điểm Năng lượng chìa khóa bạc, sau khi chơi vĩnh viễn biến đổi thành \"Nhất Kỳ Nhất Hội\": Giá trị Điểm tính toán 1, chọn 1 trong 3 Mật lệnh ngẫu nhiên đã mở khóa để lập tức kích hoạt và có hiệu lực 2 lần, sau khi chơi vĩnh viễn biến đổi thành \"Thư Mùa Xuân\". Tất cả các thẻ bài này đều có \"Giữ lại\"."
  },
  State_133961_WeaponDesc = {
    Text = "Sau khi bắt đầu khám phá, tạo một lá\"Thư Xuân\"đưa vào bộ bài: Tiêu hao toán lực 1, nhận <WeaponEffect_Num:[StateArg1]> điểm năng lượng Chìa Khóa Bạc, sau khi đánh ra sẽ vĩnh viễn biến thành \"Anh Đào Mãn Khai\": Tiêu hao toán lực 1, nhận <WeaponEffect_Num:[StateArg2]> điểm năng lượng Chìa Khóa Bạc, sau khi đánh ra sẽ vĩnh viễn biến thành \"Hoa Tuyết Bay\": Tiêu hao toán lực 1, nhận <WeaponEffect_Num:[StateArg3]> điểm năng lượng Chìa Khóa Bạc, sau khi đánh ra sẽ vĩnh viễn biến thành \"Nhất Kỳ Nhất Hội\": Tiêu hao toán lực 1, chọn 1 trong 3 Chìa Lệnh ngẫu nhiên đã mở khóa để lập tức phát động và có hiệu lực 2 lần, sau khi đánh ra sẽ vĩnh viễn biến thành \"Thư Xuân\". Những lá bài này đều có\"Giữ lại\"."
  },
  State_133994_Desc = {
    Text = "Sát thương, lực lượng và thương tổn xúc tu cố định, ngộ độc cố định, phản công cố định của tất cả thẻ lệnh thể thức tỉnh tăng [DescArg1]%, lá chắn cố định, hồi phục sinh lực cố định, sức mạnh giảm xuống tăng [DescArg2]%."
  },
  State_133994_Name = {
    Text = "Lăng Kính Kỳ Điểm"
  },
  State_133998_Desc = {
    Text = "Sát thương, khiên, thay đổi sức mạnh do thẻ bài này gây ra tăng [DescArg2]%, hiệu quả cuối cùng của sát thương xúc tu, hồi phục sinh mệnh, trúng độc cố định, phản kích cố định tăng [DescArg1]%, bị loại bỏ khi kết thúc lượt hoặc sau khi đánh ra."
  },
  State_133998_Name = {
    Text = "<TempPowerKeywords1:Cường Hóa Tạm Thời [DescArg1]>"
  },
  State_133999_Desc = {
    Text = "Mỗi lớp làm tăng sát thương, lực lượng và thương tổn xúc tu cố định, ngộ độc cố định, phản công cố định của thẻ bài này thêm 2%; tăng lá chắn cố định, hồi phục sinh lực cố định, sức mạnh giảm xuống thêm 1%, bị xóa khi kết thúc lượt hoặc sau khi chơi."
  },
  State_133999_Name = {
    Text = "<TempPowerKeywords:Cường Hóa Tạm Thời>"
  },
  State_134100_Desc = {
    Text = "Khi chịu sát thương chí mạng trong trận chiến này, hồi sinh, hồi phục [Layer] điểm sinh mệnh và cho tất cả Thể Thức Tỉnh nhận [StateArg1] điểm cuồng khí và [DescArg1] điểm sát thương xúc tu tạm thời, không thể xua tan."
  },
  State_134100_Name = {
    Text = "Chim thiên đường bất tử"
  },
  State_134191_Desc = {
    Text = "Đội duy nhất: Sau khi bắt đầu khám phá, trộn 1 lá\"Thời Gian Nghỉ Trưa Riêng Tư\"vào bộ rút bài.\"Thời Gian Nghỉ Trưa Riêng Tư\": Tiêu hao 1Điểm tính toán. Sát thương bạo kích tạm thời +<WeaponEffect_Num:[StateArg1]%>. <RetainIconKeywords:Giữ lại>. <DepleteIconKeywords:Tiêu hao>."
  },
  State_134191_WeaponDesc = {
    Text = "Sau khi bắt đầu khám phá, trộn 1 lá\"Thời Gian Nghỉ Trưa Riêng Tư\"vào bộ rút bài.\"Thời Gian Nghỉ Trưa Riêng Tư\": Tiêu hao 1Điểm tính toán. Sát thương bạo kích tạm thời +<WeaponEffect_Num:[StateArg1]%>. <RetainIconKeywords:Giữ lại>. <DepleteIconKeywords:Tiêu hao>."
  },
  State_134195_Desc = {
    Text = "Số tầng trúng độc cố định, phản kích cố định, phán quyết vận mệnh cố định do lá bài này gây ra được tăng, nhân độc lập 1+[Layer]%."
  },
  State_134195_Name = {
    Text = "Tam Tướng Chi Lực α1"
  },
  State_134196_Desc = {
    Text = "Số tầng trúng độc cố định, phản kích cố định, phán quyết vận mệnh cố định do lá bài chỉ lệnh của thể thức tỉnh này gây ra được tăng, nhân độc lập 1+[StateArg1]%."
  },
  State_134196_Name = {
    Text = "Tam Tướng Chi Lực β3"
  },
  State_134197_Desc = {
    Text = "Số tầng trúng độc cố định, phản kích cố định, phán quyết vận mệnh cố định do lá bài này gây ra được tăng, nhân độc lập 1+[StateArg1]%."
  },
  State_134197_Name = {
    Text = "Tam Tướng Chi Lực β1"
  },
  State_134198_Desc = {
    Text = "Số tầng trúng độc cố định, phản kích cố định, phán quyết vận mệnh cố định do lá bài chỉ lệnh của thể thức tỉnh này gây ra được tăng, nhân độc lập 1+[Layer]%."
  },
  State_134198_Name = {
    Text = "Tam Tướng Chi Lực α3"
  },
  State_134199_Desc = {
    Text = "Số tầng trúng độc cố định, phản kích cố định, phán quyết vận mệnh cố định do bùng nổ cuồng khí của thể thức tỉnh này gây ra được tăng, nhân độc lập 1+[StateArg1]%."
  },
  State_134199_Name = {
    Text = "Tam Tướng Chi Lực β2"
  },
  State_134200_Desc = {
    Text = "Số tầng trúng độc cố định, phản kích cố định, phán quyết vận mệnh cố định do bùng nổ cuồng khí của thể thức tỉnh này gây ra được tăng, nhân độc lập 1+[Layer]%."
  },
  State_134200_Name = {
    Text = "Tam Tướng Chi Lực α2"
  },
  State_134227_Desc = {
    Text = "Sợi chỉ do Arachne thêu dệt số phận. Tối đa [DescArg1] tầng, có thể bị \"Vận Mệnh, Theo Lời Ta Ban\" tiêu hao để phát động truy đuổi \"Đường Tơ Vô Tận\", \"Dệt Mệnh\" sẽ được kế thừa sang trận đấu tiếp theo."
  },
  State_134227_Name = {
    Text = "<SilkKeywords:Dệt Mệnh>"
  },
  State_134231_Desc = {
    Text = "Đội ngũ duy nhất: Khiên do người trang bị gây ra tăng <WeaponEffect_Num:[StateArg1]%>, khi người trang bị gây \"Truy Kích\"+ <WeaponEffect_Num:[StateArg2]%> cường hóa tạm thời, mỗi lượt tối đa có hiệu lực 5 lần. Mỗi khi kích hoạt \"Xuyên Không Chiều\", người trang bị nhận được <WeaponEffect_Num:[StateArg3]> điểm cuồng khí."
  },
  State_134231_WeaponDesc = {
    Text = "Khiên do người trang bị gây ra tăng <WeaponEffect_Num:[StateArg1]%>, khi người trang bị gây \"Truy Kích\"+ <WeaponEffect_Num:[StateArg2]%> cường hóa tạm thời, mỗi lượt tối đa có hiệu lực 5 lần. Mỗi khi kích hoạt \"Xuyên Không Chiều\", người trang bị nhận được <WeaponEffect_Num:[StateArg3]> điểm cuồng khí."
  },
  State_134237_Desc = {
    Text = "Arachne dệt vận mệnh kéo ra những sợi tơ, tối đa [DescArg1] tầng, có thể bị Cuồng Khí Bộc Phát tiêu hao để phát động truy kích \"<DerivativeCardKeywords_144:Tuyến Lũ Vô Tận>\".\"Dệt Mệnh\" sẽ được kế thừa sang trận đấu tiếp theo."
  },
  State_134237_Name = {
    Text = "Dệt Mệnh"
  },
  State_134240_Desc = {
    Text = "[Layer] lần \"Dệt Vĩnh Hằng\" tiếp theo sẽ tạo thêm \"Khiên Ti Dẫn Mệnh\" đưa vào chồng rút bài và chồng bài bỏ."
  },
  State_134240_Name = {
    Text = "Lưới Trói Mệnh"
  },
  State_134261_Desc = {
    Text = "[Layer] lần gây sát thương tiếp theo được nhân đôi."
  },
  State_134261_Name = {
    Text = "Giờ nghỉ trưa riêng tư"
  },
  State_134262_Desc = {
    Text = "<PVPWeaponKeywords:Mệnh Luân>: Sau \"Bùng Nổ Cuồng Khí\", sát thương tiếp theo bản thân gây ra được nhân đôi."
  },
  State_134262_Name = {
    Text = "Giờ nghỉ trưa riêng tư"
  },
  State_134285_Desc = {
    Text = "Nếu số tầng trạng thái này lớn hơn hoặc bằng sinh mệnh mục tiêu, xóa tất cả Phán Quyết Vận Mệnh và trực tiếp hạ gục mục tiêu. Phán Quyết Vận Mệnh cố định được áp dụng nhận thêm gia tăng cường hóa sát thương."
  },
  State_134285_Name = {
    Text = "Phán Quyết Vận Mệnh"
  },
  State_134313_Desc = {
    Text = "Đội ngũ duy nhất: Khiên do người trang bị gây ra tăng <WeaponEffect_Num:[StateArg1]%>, khi người trang bị gây \"Truy Kích\"+ <WeaponEffect_Num:[StateArg2]%> cường hóa tạm thời, mỗi lượt tối đa có hiệu lực 5 lần."
  },
  State_134313_WeaponDesc = {
    Text = "Khiên do người trang bị gây ra tăng <WeaponEffect_Num:[StateArg1]%>, khi người trang bị gây \"Truy Kích\"+ <WeaponEffect_Num:[StateArg2]%> cường hóa tạm thời, mỗi lượt tối đa có hiệu lực 5 lần."
  },
  State_134384_Desc = {
    Text = "[Layer] lá bài chỉ lệnh tiếp theo được đánh ra sẽ kích hoạt \"Xuyên Không Chiều Không Gian\"."
  },
  State_134384_Name = {
    Text = "Xuyên Không Chiều Không Gian"
  },
  State_134389_Desc = {
    Text = "Sát thương, lực lượng và thương tổn xúc tu cố định, ngộ độc cố định, phản công cố định của thẻ bài này tăng [DescArg1]%, lá chắn cố định, hồi phục sinh lực cố định, sức mạnh giảm xuống tăng [DescArg2]%. Thẻ bài có \"Ngọn hải đăng kỳ điểm\" không thể sao chép vào \"Khoảng không gian siêu việt\"."
  },
  State_134389_Name = {
    Text = "<SingularityKeywords:Tín Hiệu Kỳ Điểm [DescArg2]>"
  },
  State_134391_Desc = {
    Text = "Kích hoạt hiệu ứng này sau khi đánh ra thẻ chỉ lệnh lần đầu mỗi lượt, sau khi đánh ra thẻ chỉ lệnh sẽ tạm thời sao chép nguyên bản và đưa vào không gian siêu chiều, lượt siêu chiều không thể phát động hiệu ứng này."
  },
  State_134391_Name = {
    Text = "<SingularityKeywords3:Xuyên Không Chiều>"
  },
  State_135232_Name = {
    Text = "<AwakerCard_24Lost:<SingularityKeywords:Kỳ Điểm Chiết Dược>: Trong thời gian còn lại của lượt này, sau khi Giác Tỉnh Thể khác đánh ra lá bài chỉ lệnh, tiêu hao 1 tầng <SilkKeywords:Chức Mệnh> để giải phóng \"<DerivativeCardKeywords_137:Vô Tận Tuyến Lũ>\" truy kích>"
  },
  State_135233_Name = {
    Text = "<SingularityKeywords:Kỳ Điểm Chiết Dược>: Trong thời gian còn lại của lượt này, sau khi Giác Tỉnh Thể khác đánh ra lá bài chỉ lệnh, tiêu hao 1 tầng <SilkKeywords:Chức Mệnh> để giải phóng \"<DerivativeCardKeywords_137:Vô Tận Tuyến Lũ>\" truy kích"
  },
  State_135919_Name = {
    Text = "<AwakerCard_24Lost:<SingularityKeywords:Kỳ Điểm Chiết Dược>: Trong thời gian còn lại của lượt này, sau khi Giác Tỉnh Thể khác đánh ra lá bài chỉ lệnh, tiêu hao 1 tầng <SilkKeywords:Chức Mệnh> để giải phóng \"<DerivativeCardKeywords_137:Vô Tận Tuyến Lũ>\" truy kích>"
  },
  State_135920_Name = {
    Text = "<SingularityKeywords:Kỳ Điểm Chiết Dược>: Trong thời gian còn lại của lượt này, sau khi Giác Tỉnh Thể khác đánh ra lá bài chỉ lệnh, tiêu hao 1 tầng <SilkKeywords:Chức Mệnh> để giải phóng \"<DerivativeCardKeywords_137:Vô Tận Tuyến Lũ>\" truy kích"
  },
  State_135921_Desc = {
    Text = "Sát thương gây ra bởi thân thể được đánh thức tăng 25%."
  },
  State_135921_Name = {
    Text = "<CardKeyWord:Quát mắng, để báo ân cừu>"
  },
  State_138824_Desc = {
    Text = "Sinh lực rực rỡ đang ca ngợi tự do, vang lên khúc khải hoàn, có thể bị Bùng nổ Điên loạn của Saya tiêu thụ để tăng cường hiệu ứng của nó. Trạng thái này tích lũy tối đa 4 lớp, sẽ được giữ lại sau khi chiến đấu kết thúc."
  },
  State_138824_Name = {
    Text = "<KaiHuajishu1:Vũ Chủng>"
  },
  State_139039_Desc = {
    Text = "Lần Bùng nổ tiếp theo trong vòng này của Thể thức tỉnh, hiệu ứng cuối cùng của thương gây ra, lá chắn cố định, Sinh lực Trả lời cố định, Sức mạnh cố định, sức mạnh giảm xuống, thương tổn xúc tu tăng lên, Ngộ độc cố định, phản công cố định được tăng thêm [Layer]%."
  },
  State_139039_Name = {
    Text = "<BreedingKeywords2:Lễ hội phối giống>"
  },
  State_139687_Desc = {
    Text = "Sinh lực rực rỡ đang ca ngợi tự do, vang lên khúc khải hoàn, có thể bị Bùng nổ Điên loạn của Saya tiêu thụ để tăng cường hiệu ứng của nó. Trạng thái này tích lũy tối đa 4 lớp, sẽ được giữ lại sau khi chiến đấu kết thúc."
  },
  State_139687_Name = {
    Text = "<KaiHuajishu:Vũ Chủng>"
  },
  State_139688_Desc = {
    Text = "Đội duy nhất: Giới hạn Điểm tính toán +1, các hiệu ứng cùng loại không thể cộng dồn. Cứ mỗi 10 điểm căn bản điên cuồng của Người trang bị, hiệu ứng <Corrosion:Xói mòn> cố định gây ra tăng <WeaponEffect_Num:[StateArg1]%>, Dung hợp Phôi thai gây ra tăng <WeaponEffect_Num:[Float:StateArg2]%>."
  },
  State_139688_WeaponDesc = {
    Text = "Giới hạn Điểm tính toán +1, các hiệu ứng cùng loại không thể cộng dồn. Cứ mỗi 10 điểm căn bản điên cuồng của Người trang bị, hiệu ứng <Corrosion:Xói mòn> cố định gây ra tăng <WeaponEffect_Num:[StateArg1]%>, Dung hợp Phôi thai gây ra tăng <WeaponEffect_Num:[Float:StateArg2]%>."
  },
  State_139689_Desc = {
    Text = "Đội duy nhất: Sau khi sử dụng \"Lò nung đỏ thẫm\", người trang bị nhận được điên cuồng bằng <WeaponEffect_Num:[StateArg1]%> căn bản điên cuồng, hồi chiêu 3 lượt."
  },
  State_139689_WeaponDesc = {
    Text = "Sau khi sử dụng \"Lò nung đỏ thẫm\", Người trang bị nhận được Điên loạn bằng <WeaponEffect_Num:[StateArg1]%> Cuồng khí cơ bản, hồi chiêu 3 lượt."
  },
  State_139977_Desc = {
    Text = "Nếu đánh ra \"Đả Kích\" trong lượt này, thì\"Đả Kích\"+ [DescArg1]% xuyên thấu sát thương; nếu không, kết thúc lượt +[Layer] Khiên chắn."
  },
  State_139977_Name = {Text = "Tinh Thú"},
  State_140063_Desc = {
    Text = "Đây là \"giấy nợ\" do vay trước toán lực từ lượt sau, sẽ trừ [Layer] toán lực sau khi bắt đầu lượt tiếp theo, không thể xua tan."
  },
  State_140063_Name = {
    Text = "Giấy Nợ Kề Thân"
  },
  State_140068_Desc = {
    Text = "[DescArg1] lá\"Kỹ Năng\" tiếp theo tiêu hao toán lực - [StateArg1]."
  },
  State_140068_Name = {Text = "Khai sáng"},
  State_140135_Desc = {
    Text = "Mỗi lớp sở hữu, lần Bùng nổ tiếp theo trong vòng này của Thể thức tỉnh, hiệu ứng cuối cùng của thương gây ra, lá chắn cố định, Sinh lực Trả lời cố định, Sức mạnh cố định, sức mạnh giảm xuống, thương tổn xúc tu tăng lên, Ngộ độc cố định, phản công cố định được tăng thêm 1%."
  },
  State_140135_Name = {
    Text = "<BreedingKeywords2:Lễ hội phối giống>"
  },
  State_140186_WeaponDesc = {
    Text = "Số lần gây thương của Cá Voi Nhảy tăng thêm 1."
  },
  State_140454_Desc = {
    Text = "Đội ngũ duy nhất: Mỗi 1% Hắc Ấn rơi từ bản thân người trang bị, Mệnh Luân, Mật Khế, sau khi kết thúc chiến đấu sẽ hồi phục <WeaponEffect_Num:[StateArg1]%> sinh mệnh tối đa, mỗi khi kết thúc lượt sẽ giảm hiệu quả hồi phục 30%, nhiều lần tính toán độc lập. Trong \"Tàn Tích Tro Tàn\" sau khi giải phóng \"Cảm Ứng\", lần làm mới \"Tàn Tích Tro Tàn\" này không cần tiêu hao Hắc Ấn."
  },
  State_140454_WeaponDesc = {
    Text = "Đội duy nhất: Sau khi kết thúc trận đấu hồi phục <WeaponEffect_Num:[DescArg2]%> sinh mệnh tối đa([DescArg1]), mỗi lượt kết thúc sẽ giảm hiệu quả hồi phục đó 30%. Trong \"Tàn Tích Tro Tàn\" sau khi phát động \"Cảm Ứng\", lần làm mới \"Tàn Tích Tro Tàn\" này không cần tiêu hao Hắc Ấn."
  },
  State_140456_WeaponDesc = {
    Text = "Sau khi sử dụng, hãy loại bỏ nó vĩnh viễn."
  },
  State_140458_Desc = {
    Text = "<PVPWeaponKeywords:Mệnh luân>:Khi trang bị và sau khi bất kỳ Giác Tỉnh Thể nào phát động \"Bùng nổ Cuồng khí\", bản thân nhận <Block:[Block:StateArg1]> khiên."
  },
  State_140458_Name = {
    Text = "Gửi Muôn Vì Sao"
  },
  State_140489_Desc = {
    Text = "Nhận sinh mệnh tối đa tương đương, số tầng không vượt quá sinh mệnh tối đa ban đầu của Thể Thức Tỉnh."
  },
  State_140489_Name = {
    Text = "Vũ Chủng"
  },
  State_140490_Desc = {
    Text = "Nhận sinh mệnh tối đa tương đương, số tầng không vượt quá sinh mệnh tối đa ban đầu [DescArg1] của Thể Thức Tỉnh đó."
  },
  State_140490_Name = {
    Text = "Vũ Chủng"
  },
  State_140495_Desc = {
    Text = "Điểm tính toán tiêu thụ của \"kỹ năng\" tiếp theo - [Layer] ."
  },
  State_140495_Name = {
    Text = "Cải viết"
  },
  State_140517_Desc = {
    Text = "\"Kỹ năng\" tiếp theo tiêu hao Điểm tính toán - [DescArg1]."
  },
  State_140517_Name = {
    Text = "Cải viết"
  },
  State_140547_Desc = {
    Text = "Hiệu ứng này tối đa tăng Dung Hợp Phôi Thai+ 100, không chịu ảnh hưởng từ hiệu ứng tăng cường Dung Hợp Phôi Thai."
  },
  State_140547_Name = {
    Text = "Nhân đôi Dung Hợp Phôi Thai"
  },
  State_140645_Desc = {
    Text = "Hiệu ứng chờ"
  },
  State_140645_Name = {
    Text = "Hiệu ứng chờ"
  },
  State_140647_Name = {
    Text = "Theo dõi đánh ra Bất hòa nhận thức"
  },
  State_140648_Name = {
    Text = "Đếm số lần người chơi sở hữu Bất hòa nhận thức"
  },
  State_140650_Desc = {
    Text = "3 lần đầu tiên mỗi lượt đánh ra thẻ chỉ lệnh có \"Nhận thức hỗn loạn\" sẽ giúp Saya nhận được [Layer] điểm Cuồng Khí."
  },
  State_140650_Name = {
    Text = "Cải Tạo Nhận Thức"
  },
  State_140651_Desc = {
    Text = "Hiệu ứng chờ"
  },
  State_140651_Name = {
    Text = "Hiệu ứng chờ"
  },
  State_140653_Desc = {
    Text = "Giá trị Điểm tính toán của thẻ bài này có 10% cơ hội -2, 25% cơ hội -1, 30% cơ hội không đổi, 25% cơ hội +1, 10% cơ hội +2. Xóa trạng thái này sau khi chơi hoặc bỏ bài."
  },
  State_140653_Name = {
    Text = "<ExclamationPointColour:Nhận thức bất hòa>"
  },
  State_140654_Desc = {
    Text = "Hiệu ứng chờ"
  },
  State_140654_Name = {
    Text = "Hiệu ứng chờ"
  },
  State_140655_Desc = {
    Text = "Thẻ bài này bị rỗng rỗng che phủ, không thể xem nội dung chữ, Giá trị Điểm tính toán có 10% cơ hội -2, 25% cơ hội -1, 30% cơ hội không đổi, 25% cơ hội +1, 10% cơ hội +2. Xóa trạng thái này sau khi chơi hoặc bỏ bài."
  },
  State_140655_Name = {
    Text = "<ErosionColorInkKeywords:Nhận thức hỗn loạn>"
  },
  State_140656_Desc = {
    Text = "Giá trị Điểm tính toán của thẻ bài này có 10% cơ hội -2, 25% cơ hội -1, 30% cơ hội không đổi, 25% cơ hội +1, 10% cơ hội +2. Xóa trạng thái này sau khi chơi hoặc bỏ bài."
  },
  State_140656_Name = {
    Text = "<ColorInkKeywords:Nhận thức bất hòa>"
  },
  State_140657_Desc = {
    Text = "Thẻ bài này bị rỗng rỗng che phủ, không thể xem nội dung chữ, Giá trị Điểm tính toán có 10% cơ hội -2, 25% cơ hội -1, 30% cơ hội không đổi, 25% cơ hội +1, 10% cơ hội +2. Xóa trạng thái này sau khi chơi hoặc bỏ bài."
  },
  State_140657_Name = {
    Text = "<ExclamationPointColour:Nhận thức hỗn loạn>"
  },
  State_140658_Name = {
    Text = "Người chơi sở hữu theo dõi Bất hòa nhận thức"
  },
  State_140659_Desc = {
    Text = "Hiệu ứng chờ"
  },
  State_140659_Name = {
    Text = "Hiệu ứng chờ"
  },
  State_140662_Desc = {
    Text = "Vào đầu mỗi lượt, sẽ ngẫu nhiên áp dụng \"Nhận Thức Hỗn Loạn\" lên 2 lá bài chỉ lệnh chưa có \"Nhận Thức Hỗn Loạn\"."
  },
  State_140662_Name = {
    Text = "Điều trị tái cấu trúc sức sống"
  },
  State_140672_Desc = {
    Text = "Trước khi kết thúc lượt này, mỗi lần gây sát thương, hồi máu, tạo khiên sẽ ngẫu nhiên giảm 15%~35%, không thể xua tan."
  },
  State_140672_Name = {
    Text = "<PVPCognitiveDissonanceKeyWords:Nhận Thức Hỗn Loạn>"
  },
  State_140673_Desc = {
    Text = "Trước khi kết thúc lượt này, mỗi lần gây sát thương, hồi máu, tạo khiên sẽ ngẫu nhiên giảm 15%~35%, không thể xua tan."
  },
  State_140673_Name = {
    Text = "Nhận Thức Hỗn Loạn"
  },
  State_140683_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>: Khi trang bị nhận được [StateArg1] <MaxHPKeywords:Sinh lực tối đa>, cuối lượt hồi phục <Heal:[Heal:DescArg1]> sinh lực, lượng sinh lực hồi phục tăng lên khi sinh lực của người trang bị giảm, tối đa tăng thêm [StateArg3]%."
  },
  State_140683_Name = {
    Text = "Mộng Du Tiên Cảnh"
  },
  State_140724_Name = {Text = "Ăn"},
  State_140726_Desc = {
    Text = "Hiệu quả cuối cùng của sát thương, sức mạnh, sát thương xúc tu, trúng độc cố định, phản đòn cố định, khiên, hồi phục sinh mệnh, giảm sức mạnh mà thẻ bài này gây ra giảm [DescArg1]%."
  },
  State_140726_Name = {
    Text = "<AdaptKeywords1:Thích ứng [DescArg1]>"
  },
  State_140727_Desc = {
    Text = "Khi Đói đạt 5 lớp, sau khi kết thúc lượt sẽ tiêu thụ toàn bộ Đói, chuyển ý định thành tấn công mạnh và nhận được [DescArg1] điểm sức mạnh."
  },
  State_140727_Name = {Text = "Đói"},
  State_140728_Desc = {
    Text = "Mỗi lượt bắt đầu nhận 1 lớp đói, khi gây thương không bị chặn nhận lá chắn bằng 2% Sinh lực tối đa ([DescArg1]) điểm, số lớp thích ứng tối đa tăng lên 75."
  },
  State_140728_Name = {
    Text = "Giữ Thức Ăn"
  },
  State_140730_Desc = {
    Text = "Sau khi chơi thẻ lệnh, áp dụng 10 lớp <AdaptKeywords:thích ứng> lên các thẻ bài của Thể thức tỉnh thuộc sở hữu ở mọi nơi, các thẻ bài của Thể thức tỉnh khác bị xóa 5 lớp <AdaptKeywords:thích ứng>. Mỗi lớp <AdaptKeywords:thích ứng> làm giảm 1% hiệu ứng cuối cùng của thương, sức mạnh, thương tổn xúc tu, ngộ độc cố định, phản công cố định, lá chắn, hồi sinh lực, sức mạnh giảm xuống mà thẻ bài gây ra, tối đa [DescArg1] lớp."
  },
  State_140730_Name = {
    Text = "Mô phỏng"
  },
  State_140838_Desc = {
    Text = "Thương gây ra trong lượt này giảm [Layer]%."
  },
  State_140838_Name = {
    Text = "Tường ác mộng che khuất mặt trời"
  },
  State_140839_Desc = {
    Text = "Lượt này tất cả Thể thức tỉnh Sát thương cuối cùng tăng lên [Layer]%."
  },
  State_140839_Name = {
    Text = "Đoàn săn đồng hành"
  },
  State_140856_Desc = {
    Text = "Thể thức tỉnh không thể hành động, khi kết thúc lượt xóa 1 lớp ý thức can thiệp, sau khi xóa hết, lần tiếp theo Thể thức tỉnh đó kích hoạt Bùng nổ sẽ được coi là kích hoạt Bùng Phát Vượt Giới, nếu đã kích hoạt Bùng Phát Vượt Giới thì hoàn trả 100% Cuồng khí cơ bản."
  },
  State_140856_Name = {
    Text = "<Yishiganshe:Giao thoa ý thức>"
  },
  State_140860_Desc = {
    Text = "Thể thức tỉnh không thể hành động, khi kết thúc lượt xóa 1 lớp ý thức can thiệp, sau khi xóa hết, lần tiếp theo Thể thức tỉnh đó kích hoạt Bùng nổ sẽ được coi là kích hoạt Bùng Phát Vượt Giới, nếu đã kích hoạt Bùng Phát Vượt Giới thì hoàn trả 100% Cuồng khí cơ bản."
  },
  State_140860_Name = {
    Text = "<Yishiganshe:Giao thoa ý thức>"
  },
  State_140861_Desc = {
    Text = "Lần tiếp theo kích hoạt Bùng nổ sẽ được coi là kích hoạt Bùng Phát Vượt Giới, nếu đã kích hoạt Bùng Phát Vượt Giới thì hoàn trả 100% Cuồng khí cơ bản."
  },
  State_140861_Name = {
    Text = "Mộng Du Tiên Cảnh"
  },
  State_140873_Desc = {
    Text = "Mỗi 1 lớp làm giảm 1% hiệu ứng cuối cùng của thương, sức mạnh, thương tổn xúc tu, ngộ độc cố định, phản công cố định, lá chắn, hồi phục sinh lực, sức mạnh giảm xuống mà thẻ bài này gây ra, tối đa [DescArg1] lớp."
  },
  State_140873_Name = {
    Text = "<AdaptKeywords:Thích ứng>"
  },
  State_140877_Name = {
    Text = "Kích hoạt thêm [DescArg1] lần"
  },
  State_141468_Desc = {
    Text = "Khi Đói đạt 5 lớp, sau khi kết thúc lượt sẽ tiêu thụ toàn bộ Đói, chuyển ý định sang tấn công mạnh và nhận được Sức mạnh."
  },
  State_141468_Name = {
    Text = "<HungerKeywords:Đói>"
  },
  State_141504_Desc = {
    Text = "Tích tối đa 3 tàn dư, khi đạt giới hạn \"Bữa tiệc thịnh soạn của sinh linh\" tiếp theo có thể tiêu thụ chúng và tăng cường hiệu ứng. Tàn dư sẽ thừa kế sang trận chiến tiếp theo."
  },
  State_141504_Name = {
    Text = "Mảnh vỡ"
  },
  State_141950_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>: Khi trang bị và cuối lượt, <PVPDiscoveryKeyWords:Phát hiện> [StateArg1] \"Kỹ năng\" được gắn thêm <PVPVoidKeywords:Hư vô> và đưa vào tay."
  },
  State_141950_Name = {
    Text = "Rơi Lên Trên"
  },
  State_141988_Desc = {
    Text = "Thương, lá chắn, hồi phục do thẻ bài này gây ra, Sức mạnh, Hấp thụ, thương tổn xúc tu, Ngộ độc, phản công, Phán Quyết Mệnh Vận, Ngộ độc cố định, phản công cố định, Phán Quyết Mệnh Vận cố định được áp dụng, hiệu ứng tăng lên [Layer]%."
  },
  State_141988_Name = {
    Text = "Thẻ bài này rực rỡ"
  },
  State_141989_Desc = {
    Text = "Tạo ra các thẻ bài ngẫu nhiên."
  },
  State_141989_Name = {
    Text = "<CardKeyWord:Phát hiện>"
  },
  State_141991_Desc = {
    Text = "Thương, lá chắn, hồi phục do Bùng nổ của Thể thức tỉnh này gây ra, Sức mạnh, Hấp thụ, thương tổn xúc tu, Ngộ độc, phản công, Phán Quyết Mệnh Vận, Ngộ độc cố định, phản công cố định, Phán Quyết Mệnh Vận cố định được áp dụng, hiệu ứng tăng lên [Layer]%."
  },
  State_141991_Name = {
    Text = "Bùng nổ rực rỡ"
  },
  State_141992_Desc = {
    Text = "Thương, lá chắn, hồi phục do thẻ bài của Thể thức tỉnh này gây ra, Sức mạnh, Hấp thụ, thương tổn xúc tu, Ngộ độc, phản công, Phán Quyết Mệnh Vận, Ngộ độc cố định, phản công cố định, Phán Quyết Mệnh Vận cố định được áp dụng, hiệu ứng tăng lên [Layer]%."
  },
  State_141992_Name = {
    Text = "Thẻ bài này rực rỡ"
  },
  State_141993_Desc = {
    Text = "Thương, lá chắn, hồi phục do thẻ lệnh của Thể thức tỉnh này gây ra, Sức mạnh, Hấp thụ, thương tổn xúc tu, Ngộ độc, phản công, Phán Quyết Mệnh Vận, Ngộ độc cố định, phản công cố định, Phán Quyết Mệnh Vận cố định được áp dụng, hiệu ứng tăng lên [Layer]%."
  },
  State_141993_Name = {
    Text = "Thẻ lệnh rực rỡ"
  },
  State_141994_Desc = {
    Text = "Sau khi chơi thẻ bài, sau khi giải phóng Bùng nổ gây thương, nhận lá chắn, hồi máu, áp dụng Sức mạnh, Hấp thụ, thương tổn xúc tu, Ngộ độc, phản công, Phán Quyết Mệnh Vận, Ngộ độc cố định, phản công cố định, Phán Quyết Mệnh Vận cố định."
  },
  State_141994_Name = {
    Text = "Lệnh Kích Hoạt Rực Rỡ"
  },
  State_142018_Desc = {
    Text = "Khi bắt đầu vòng, nhận 1 lớp <Guaiwucanhai: Thân thể tàn dư>"
  },
  State_142018_Name = {
    Text = "Lời mời đến Vương phủ"
  },
  State_142057_Desc = {
    Text = "Sau khi sử dụng Mật lệnh, chuyển đổi ý định của bản thân, sau khi chiến đấu bắt đầu tất cả Thể thức tỉnh Cấp độ nạp năng lượng chìa khóa bạc tăng 25%."
  },
  State_142057_Name = {
    Text = "Khai sáng Nhân quả"
  },
  State_142058_Desc = {
    Text = "Sát thương cơ bản, Ngộ độc, phản công gây ra giảm [DescArg1]%"
  },
  State_142058_Name = {
    Text = "Cánh Ô Uế"
  },
  State_142060_Desc = {
    Text = "Mỗi khi kẻ địch sử dụng thẻ lệnh, bản thân nhận được 1 lớp Tạm thời cuồng nhiệt. Khi Tạm thời cuồng nhiệt đạt 10 lớp, sau khi chơi thẻ lệnh tiếp theo, bản thân lập tức Hành động và xóa toàn bộ Tạm thời cuồng nhiệt."
  },
  State_142060_Name = {
    Text = "Tiếng vọng vực thẳm"
  },
  State_142062_Desc = {
    Text = "Mỗi lần hiệu ứng ban đầu của 0246 ngẫu nhiên"
  },
  State_142062_Name = {
    Text = "Ý định ngẫu nhiên"
  },
  State_142063_Desc = {
    Text = "Trong lượt của bản thân, thương nhận được giảm [DescArg1]%."
  },
  State_142063_Name = {
    Text = "Cánh Thánh Khiết"
  },
  State_142065_Desc = {
    Text = "Xóa vào đầu lượt. Khi đạt 10 lớp, sau khi chơi thẻ lệnh tiếp theo, bản thân lập tức Hành động và xóa toàn bộ Tạm thời cuồng nhiệt."
  },
  State_142065_Name = {
    Text = "Tạm thời cuồng nhiệt"
  },
  State_142066_Desc = {
    Text = "Hiệu ứng <WeaknessIconKeywords:suy nhược>, <FragileIconKeywords:mong manh>, <HeavyInjuryKeywords:thiệt hại nặng> được tăng lên 50%."
  },
  State_142066_Name = {
    Text = "Sáng suốt bản chất"
  },
  State_142067_Desc = {
    Text = "Sức mạnh, phản công, thương tổn xúc tu gây ra giảm [DescArg1]%"
  },
  State_142067_Name = {
    Text = "Cánh Nguyền Rủa"
  },
  State_142072_Desc = {
    Text = "Mỗi lần nhận thương hoặc mất sinh lực, không vượt quá 5% sinh lực tối đa."
  },
  State_142072_Name = {
    Text = "Ngưỡng chịu đau"
  },
  State_142091_Desc = {
    Text = "Đếm Sáu cánh nhân đôi"
  },
  State_142091_Name = {
    Text = "Đếm Sáu cánh nhân đôi"
  },
  State_142092_Desc = {
    Text = "Tất cả Thể thức tỉnh Cấp độ nạp năng lượng chìa khóa bạc tăng 25%."
  },
  State_142092_Name = {
    Text = "Khai sáng Nhân quả"
  },
  State_142093_Desc = {
    Text = "Tiến độ tiêu thụ Sáu cánh nhân đôi: [DescArg1], Giá trị thương tổn hiện tại cần thiết: [DescArg2]."
  },
  State_142093_Name = {
    Text = "Sáu cánh nhân đôi"
  },
  State_142095_Desc = {
    Text = "Nhãn Sáu cánh nhân đôi"
  },
  State_142095_Name = {
    Text = "Nhãn Sáu cánh nhân đôi"
  },
  State_142166_Desc = {
    Text = "Cụ thể hiệu ứng xem logic tấn công chung.__\"Chỉ dùng cho phát triển\""
  },
  State_142213_Name = {
    Text = "Giảm giới hạn sức tính toán"
  },
  State_142215_Desc = {
    Text = "Nếu vào đầu lượt sau nó vẫn còn chết, sẽ được Sự phục sinh và nhận [StateArg1] lá chắn, không thể xua tan."
  },
  State_142215_Name = {
    Text = "Sự Cuồng Nhiệt Vĩnh Hằng"
  },
  State_142228_Desc = {
    Text = "Thẻ bài này được tạo ra bởi vòng mệnh \"Rơi Lên Trên\"."
  },
  State_142228_Name = {
    Text = "Rơi Lên Trên"
  },
  State_142229_Desc = {
    Text = "Đội duy nhất: Sau khi bắt đầu khám phá, thêm 1 lá \"Mộng Du Tiên Cảnh\" vào bộ bài. \"Mộng Du Tiên Cảnh\": Tiêu thụ 2 Điểm tính toán, khiến Người trang bị nhận <WeaponEffect_Num:[StateArg1]> điểm Điên loạn và 3 lớp <Yishiganshe:\"Ý thức can thiệp\">. <RetainIconKeywords:Giữ lại>. <DepleteIconKeywords:Tiêu thụ>."
  },
  State_142229_Name = {
    Text = "Mộng Du Tiên Cảnh"
  },
  State_142229_WeaponDesc = {
    Text = "Sau khi bắt đầu khám phá, thêm 1 lá \"Mộng Du Tiên Cảnh\" vào bộ bài. \"Mộng Du Tiên Cảnh\": Tiêu thụ 2 Điểm tính toán, khiến Người trang bị nhận <WeaponEffect_Num:[StateArg1]> điểm Điên loạn và 3 lớp <Yishiganshe:\"Ý thức can thiệp\">. <RetainIconKeywords:Giữ lại>. <DepleteIconKeywords:Tiêu thụ>."
  },
  State_142452_Desc = {
    Text = "Hiệu ứng sức mạnh giảm xuống nhận được bị giảm 50%."
  },
  State_142452_Name = {
    Text = "Tồn tại bất tử"
  },
  State_142663_Desc = {
    Text = "Khi bắt đầu lượt sau, nhận <DelayKeywords:Trì hoãn>: [Layer] Điên loạn."
  },
  State_142663_Name = {
    Text = "Điên cuồng trễ bị trì hoãn"
  },
  State_142688_Desc = {
    Text = "Vòng mệnh được trang bị của mục tiêu mất hiệu lực, không thể xua tan."
  },
  State_142688_Name = {
    Text = "Vướng víu Siêu cấp"
  },
  State_142692_Desc = {
    Text = "Đang nảy ra những ý tưởng nhỏ mới mẻ."
  },
  State_142692_Name = {
    Text = "Chợt nảy ra ý tưởng"
  },
  State_142715_Desc = {
    Text = "Sát thương của \"kỹ năng\" này tăng [DescArg1]%, mỗi 1 Điểm tính toán mà kỹ năng này cần tiêu thụ tăng thêm [StateArg1]%."
  },
  State_142715_Name = {
    Text = "Cái chết màu hổ phách"
  },
  State_142887_Desc = {
    Text = "Nếu trong lượt này lại bị \"chích điện\", tất cả \"Đánh\" của nó biến thành \"ảo ảnh\", không thể xua tan, kéo dài đến cuối lượt."
  },
  State_142887_Name = {
    Text = "Hơi tê rồi đấy"
  },
  State_142954_Desc = {
    Text = "Giới hạn Điểm tính toán tối thiểu là 0, mỗi lượt bắt đầu nếu nhỏ hơn 10 sẽ tăng 1. Sau khi đạt 10, nếu nhận thêm Giới hạn Điểm tính toán sẽ được chuyển đổi thành rút số thẻ bài tương đương."
  },
  State_142954_Name = {
    Text = "Giới hạn Điểm tính toán"
  },
  State_143002_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>: Chưa cấu hình"
  },
  State_143002_Name = {
    Text = "Sartogua SR (văn bản tạm thời)"
  },
  State_143004_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>: Chưa cấu hình"
  },
  State_143004_Name = {
    Text = "Vũ khí riêng Sát-tô-gia (văn bản tạm thời)"
  },
  State_143005_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>: Chưa cấu hình"
  },
  State_143005_Name = {
    Text = "Lantigos SR (văn bản tạm thời)"
  },
  State_143006_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>: Chưa cấu hình"
  },
  State_143006_Name = {
    Text = "Vũ khí riêng Pharaon Đen (văn bản tạm thời)"
  },
  State_143007_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>: Khi trang bị và khi bắt đầu lượt, áp [StateArg1] <PVPCompassKeywords:La Bàn Hướng Vực Sâu> lên một kẻ địch ngẫu nhiên."
  },
  State_143007_Name = {
    Text = "La bàn chỉ đường lạc lối"
  },
  State_143008_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>: Chưa cấu hình"
  },
  State_143008_Name = {
    Text = "Vũ khí riêng Chim Shatak (văn bản tạm thời)"
  },
  State_143009_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>: Chưa cấu hình"
  },
  State_143009_Name = {
    Text = "Vũ khí riêng Afrugomon (văn bản tạm thời)"
  },
  State_143010_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>: Kích tước tay tối đa+ [StateArg1], khi người trang bị hoặc đồng minh chết, thẻ bài của họ không còn chuyển thành <PVPDerivativeCardKeywords_2:\"ảo ảnh\">, mà chuyển thành <PVPDerivativeCardKeywords_30:\"Săn Lùng-Mộng Quỷ\">."
  },
  State_143010_Name = {
    Text = "Lồng tù sống"
  },
  State_143011_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>: Chưa cấu hình"
  },
  State_143011_Name = {
    Text = "Kền kền SR (tạm thời)"
  },
  State_143012_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>: Chưa cấu hình"
  },
  State_143012_Name = {
    Text = "Chim Shatak SR (văn bản tạm thời)"
  },
  State_143013_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>: Chưa cấu hình"
  },
  State_143013_Name = {
    Text = "Khởi nguyên Ogier SR (Văn bản tạm thời)"
  },
  State_143014_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>: Trước \"Bùng nổ\" mất 25% Sinh lực hiện tại; Sau \"Bùng nổ\" gây [StateArg1] thương cho toàn bộ kẻ địch và Hút Lấy lượng Sinh lực tương đương."
  },
  State_143014_Name = {
    Text = "Lời Ngon Quả Ngọt"
  },
  State_143016_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>: Chưa cấu hình"
  },
  State_143016_Name = {
    Text = "Pharaoh Đen SR (văn bản tạm thời)"
  },
  State_143017_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>: Chưa cấu hình"
  },
  State_143017_Name = {
    Text = "Vũ khí riêng Lantigos (văn bản tạm thời)"
  },
  State_143018_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>: Chưa cấu hình"
  },
  State_143018_Name = {
    Text = "Nguồn gốc tulô SR (văn bản tạm thời)"
  },
  State_143019_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>: Sau \"Bùng nổ\" áp [StateArg1] lớp <PVPBless:phúc lành> lên toàn bộ kẻ địch."
  },
  State_143019_Name = {
    Text = "Sự Thật Dịu Dàng"
  },
  State_143020_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>: Chưa cấu hình"
  },
  State_143020_Name = {
    Text = "Vũ khí riêng Nguồn gốc Orci (văn bản tạm thời)"
  },
  State_143022_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>: Chưa cấu hình"
  },
  State_143022_Name = {
    Text = "Vũ khí riêng Kền kền (văn bản tạm thời)"
  },
  State_143023_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>: Chưa cấu hình"
  },
  State_143023_Name = {
    Text = "Afrugomon SR (bản thử nghiệm)"
  },
  State_143326_Desc = {
    Text = "Sạc năng lượng chìa khóa bạc tăng [DescArg1]."
  },
  State_143326_Name = {
    Text = "Khai sáng Nhân quả"
  },
  State_143331_Desc = {
    Text = "Trước khi vòng tiếp theo kết thúc, chịu thay một nửa thương cho <StatusApplier:>, Trạng thái này Đội duy nhất, khi bất kỳ ai trong hai bên bị ràng buộc chết thì xóa hiệu ứng này, không thể xua đuổi."
  },
  State_143331_Name = {
    Text = "Gánh Thương"
  },
  State_143333_Desc = {
    Text = "Trước khi vòng tiếp theo Bắt đầu, <StatusApplier:> chịu thay một nửa thương, Trạng thái này Đội duy nhất, khi bất kỳ ai trong hai bên bị ràng buộc chết thì xóa hiệu ứng này, không thể xua đuổi."
  },
  State_143333_Name = {
    Text = "Chuyển Dịch Thương"
  },
  State_143336_Desc = {
    Text = "Trao cho \"Giam Mộng Quỷ\" Có hiệu lực thêm 1 lần. Khi chơi \"Giam Mộng Quỷ\" sẽ tiêu thụ 1 lớp, tối đa 9 lớp, không xóa khi kết thúc chiến đấu."
  },
  State_143336_Name = {
    Text = "<BattueKeywords:Săn bắn>"
  },
  State_143340_Desc = {
    Text = "Trao cho \"Giam Mộng Quỷ\" Có hiệu lực thêm 1 lần. Khi chơi \"Giam Mộng Quỷ\" sẽ tiêu thụ 1 lớp, tối đa 9 lớp, không xóa khi kết thúc chiến đấu."
  },
  State_143340_Name = {
    Text = "<BattueKeywords:Săn bắn>"
  },
  State_143386_Desc = {
    Text = "Chịu thay một nửa thương cho <StatusApplier:>, không thể xua đuổi."
  },
  State_143386_Name = {
    Text = "Gánh Thương"
  },
  State_143387_Desc = {
    Text = "<StatusApplier:> chịu thay một nửa thương, không thể xua đuổi."
  },
  State_143387_Name = {
    Text = "Chuyển Dịch Thương"
  },
  State_143406_Name = {
    Text = "Thẻ bài này có hiệu lực thêm [DescArg1] lần"
  },
  State_143408_Desc = {
    Text = "Khi bị Thể thức tỉnh của đối phương tấn công, chuyển đổi thành [Layer] Điên loạn cho kẻ tấn công."
  },
  State_143408_Name = {
    Text = "La bàn chỉ đường lạc lối"
  },
  State_143409_Desc = {
    Text = "Khi bị Thể thức tỉnh của đối phương tấn công, chuyển đổi số lớp tương ứng thành Điên loạn cho kẻ tấn công."
  },
  State_143409_Name = {
    Text = "<CardKeyWord:La bàn chỉ đường lạc lối>"
  },
  State_143419_Desc = {
    Text = "Lá bài này đến từ <PVPDerivativeCardKeywords_31:\"Kho báu của Ô Ryta\">."
  },
  State_143419_Name = {
    Text = "Kho báu của Ô Ryta"
  },
  State_143426_Desc = {
    Text = "Sau khi vòng Bắt đầu, trừ [Layer] Điểm tính toán, không thể xua đuổi."
  },
  State_143426_Name = {
    Text = "Trì Hoãn Trừ Điểm Tính Toán"
  },
  State_143441_Desc = {
    Text = "Thể thức tỉnh được chọn vào lượt thao tác thứ [StateArg1]."
  },
  State_143441_Name = {
    Text = "Dấu hiệu thử nghiệm 1"
  },
  State_143442_Desc = {
    Text = "Thể thức tỉnh được chọn vào lượt thao tác thứ [StateArg1]."
  },
  State_143442_Name = {
    Text = "Dấu hiệu thử nghiệm 2"
  },
  State_143444_Desc = {
    Text = "Thể thức tỉnh được chọn vào lượt thao tác thứ [StateArg1]."
  },
  State_143444_Name = {
    Text = "Dấu hiệu thử nghiệm 4"
  },
  State_143445_Desc = {
    Text = "Thể thức tỉnh được chọn vào lượt thao tác thứ [StateArg1]."
  },
  State_143445_Name = {
    Text = "Dấu hiệu thử nghiệm 3"
  },
  State_143499_Name = {
    Text = "Miễn dịch Sát thương chủ động__\"Chỉ dùng để phát triển\""
  },
  State_143500_Name = {
    Text = "Miễn dịch thương thuần túy__\"Chỉ dùng để phát triển\""
  },
  State_143541_Desc = {
    Text = "Giảm [DescArg1]% thương mà tất cả kẻ thù gây ra trong lượt này, nhận được [DescArg2] điểm Sức mạnh."
  },
  State_143541_Name = {Text = "Vệ sĩ"},
  State_143542_Desc = {
    Text = "Sát thương cuối cùng tạm thời +[DescArg1]%, và gây Xói mòn [DescArg2]% Sinh lực tối đa cho tất cả kẻ thù."
  },
  State_143542_Name = {Text = "Săn mồi"},
  State_143548_Desc = {
    Text = "Gây lá chắn và thêm Trạng thái, quái vật, nhánh 1."
  },
  State_143548_Name = {
    Text = "Chuyển lá chắn quái vật 1"
  },
  State_143549_Desc = {
    Text = "Gây lá chắn và thêm Trạng thái, Thể thức tỉnh, nhánh 2."
  },
  State_143549_Name = {
    Text = "Chuyển lá chắn nhân vật 2"
  },
  State_143550_Desc = {
    Text = "Gây lá chắn và thêm Trạng thái, Thể thức tỉnh, nhánh 1."
  },
  State_143550_Name = {
    Text = "Chuyển lá chắn nhân vật 1"
  },
  State_143551_Desc = {
    Text = "Gây ra lá chắn và thêm Trạng thái, quái vật, nhánh 2."
  },
  State_143551_Name = {
    Text = "Chuyển lá chắn quái vật 2"
  },
  State_143552_Desc = {
    Text = "Gây lá chắn và thêm Trạng thái, người chơi, nhánh 1."
  },
  State_143552_Name = {
    Text = "Chuyển lá chắn người chơi 1"
  },
  State_143553_Desc = {
    Text = "Gây lá chắn và thêm Trạng thái, người chơi, nhánh 2."
  },
  State_143553_Name = {
    Text = "Chuyển lá chắn người chơi 2"
  },
  State_143573_Desc = {
    Text = "Giam Mộng Quỷ là bài tăng cường của Pontos bao gồm \"Truy Kích-Mộng Quỷ\" \"Loạn Náo-Mộng Quỷ\" \"Sát Phạt-Mộng Quỷ\", có tổng cộng 3 loại. Khi tạo \"Giam Mộng Quỷ\" vĩnh viễn, nếu \"Giam Mộng Quỷ\" vượt quá 6 lá, sẽ ngẫu nhiên Nâng cấp một \"Giam Mộng Quỷ\" vĩnh viễn thành \"Song Sinh Mộng Quỷ\" với Giá trị Điểm tính toán +1 nhưng Có hiệu lực thêm 1 lần, \"Song Sinh Mộng Quỷ\" được tính là 2 lá \"Giam Mộng Quỷ\" trong bộ bài. Nếu tất cả \"Giam Mộng Quỷ\" đều đã được Nâng cấp thì đưa 1 lá \"Cảm hứng nâng cao\" có <DestructionKeywords:Hủy hoại> vào tay."
  },
  State_143573_Name = {
    Text = "Giam Mộng Quỷ"
  },
  State_143578_Desc = {
    Text = "Trong lượt này, mỗi khi nhận Sát thương chủ động, đặt [Layer] lá <PVPDerivativeCardKeywords_30:\"Giam Cầm Ác Mộng\"> vào Tay."
  },
  State_143578_Name = {
    Text = "Nghi Lễ Lãnh Chúa"
  },
  State_143595_Desc = {
    Text = "Thẻ bài này được thêm <PrepareKeywords:Chuẩn bị> [StateArg1]."
  },
  State_143595_Name = {
    Text = "Bước nhảy của thiên nga đen"
  },
  State_143597_Desc = {
    Text = "Đội duy nhất: Hiệu ứng sức mạnh giảm xuống do Người trang bị gây ra tăng lên <WeaponEffect_Num:[StateArg1]%>. Khi chuyển sang tư thế \"Sóng Gẩm\", Sát thương bạo kích tạm thời tăng lên, lượng tăng bằng <WeaponEffect_Num:[StateArg1]%> Sát thương chí mạng cơ bản của bản thân, hồi chiêu 3 lượt."
  },
  State_143597_WeaponDesc = {
    Text = "Hiệu ứng sức mạnh giảm xuống do Người trang bị gây ra tăng lên <WeaponEffect_Num:[StateArg1]%>. Sau khi chuyển sang tư thế \"Sóng Gẩm\", Sát thương bạo kích tạm thời tăng lên <WeaponEffect_Num:[DescArg1]%>, hồi chiêu 3 lượt."
  },
  State_143598_Desc = {
    Text = "Đội duy nhất: Hiệu ứng sức mạnh giảm xuống do Người trang bị gây ra tăng lên <WeaponEffect_Num:[StateArg1]%>, mỗi khi Giết 1 kẻ địch sẽ làm tăng 2 điểm Điên loạn hồi phục cố định vào cuối lượt khám phá hiện tại của Người trang bị, tối đa chồng <WeaponEffect_Num:[StateArg2]> lần. Sau khi chuyển sang tư thế \"Sóng Gẩm\", Sát thương bạo kích tạm thời tăng lên, lượng tăng bằng <WeaponEffect_Num:[StateArg1]%> Sát thương chí mạng cơ bản của bản thân, hồi chiêu 3 lượt."
  },
  State_143598_WeaponDesc = {
    Text = "Hiệu ứng sức mạnh giảm xuống do Người trang bị gây ra tăng lên <WeaponEffect_Num:[StateArg1]%>, mỗi khi Giết 1 kẻ địch sẽ làm tăng 2 điểm Điên loạn hồi phục cố định vào cuối lượt khám phá hiện tại của Người trang bị, tối đa chồng <WeaponEffect_Num:[StateArg2]> lần. Sau khi chuyển sang tư thế \"Sóng Gẩm\", Sát thương bạo kích tạm thời tăng lên <WeaponEffect_Num:[DescArg1]%>, hồi chiêu 3 lượt."
  },
  State_143683_Desc = {
    Text = "Thể thức tỉnh này bị Phong ấn không thể sử dụng Truy đuổi, sau [Layer] lượt Phong ấn sẽ được giải trừ."
  },
  State_143683_Name = {
    Text = "<Seal1:Truy đuổi Phong ấn>"
  },
  State_144381_Desc = {
    Text = "Không thể Hành động, Còn Lại [DescArg1] vòng."
  },
  State_144381_Name = {
    Text = "<Yishiganshe:Giao thoa ý thức>"
  },
  State_144441_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>: Khi đồng đội tử vong, bản thân nhận được <Energy:[Energy:StateArg1]> điên cuồng. Khi đồng đội phục sinh, họ nhận được <Energy:[Energy:StateArg2]> điên cuồng. Hiệu ứng nhận điên cuồng chỉ có hiệu lực khi điên cuồng của mục tiêu chưa đầy, còn hiệu lực [Layer] lần, sau khi hết số lần sẽ hủy hoại vòng mệnh này."
  },
  State_144441_Name = {
    Text = "Đồng Bộ Linh Hồn"
  },
  State_144494_Desc = {
    Text = "Có 7 loại hiệu ứng, bao gồm: Rút 8 thẻ, nhận 6 Điểm tính toán, nhận Năng lượng chìa khóa bạc, tất cả Thể thức tỉnh nhận điên cuồng cố định, nhận sức mạnh, tạm thời giảm sức mạnh của tất cả kẻ thù, tạm thời tăng Khuếch đại sát thương."
  },
  State_144494_Name = {
    Text = "<Blessing:Quà Tặng>"
  },
  State_144508_Desc = {
    Text = "\"Cái Giá\" có 3 loại, bao gồm \"Lỡ Thời Cơ\", \"Lời Giả Tạo\", \"Ý Đồ Xấu\".\n\"Lỡ Thời Cơ\": Sau 2 lượt nhận hiệu ứng \"Món Quà\".\n\"Lời Giả Tạo\": Hiệu ứng \"Món Quà\" giảm 50%.\n\"Ý Đồ Xấu\": Áp lên bản thân 1 hiệu ứng ngẫu nhiên khác nhau: Suy nhược 2 lượt, Mong manh 2 lượt, Thiệt hại nặng 2 lượt, Ngộ độc tương đương 1% Sinh lực tối đa của bản thân, 2 lớp Hư vô, áp 1 lớp Trì trệ lên 2 thẻ ngẫu nhiên trong tay, tạo 2 thẻ triệu chứng tạm thời (không kế thừa qua chiến đấu) đặt vào đầu rút bài từ bộ bài."
  },
  State_144508_Name = {
    Text = "<BlessingNegativeEffect:Cái Giá>"
  },
  State_144519_Desc = {
    Text = "Biến số kiểm tra, làm mới sau khi lượt bắt đầu hoặc sau khi chơi thẻ bài. Hiện đang sở hữu [Layer] Giới tinh."
  },
  State_144519_Name = {
    Text = "Giới tinh Hỗn Mang mới"
  },
  State_145228_Name = {
    Text = "<WormGrowth:No Nê>"
  },
  State_145229_Desc = {
    Text = "Bạn cũng là một phần của Phép Màu đấy~. Có thể bị Bùng nổ điên cuồng của Caraboo tiêu thụ để nhận lợi ích, trạng thái này tích lũy tối đa 5 lớp. Không xóa sau khi kết thúc chiến đấu"
  },
  State_145229_Name = {
    Text = "<SacrificialMark:Cúng Tế>"
  },
  State_145436_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>: Sát thương \"Đánh\" tăng lên [DescArg1]%, mỗi lần \"Đánh\" sát thương tăng thêm [StateArg2]%, tối đa tăng đến [StateArg3]%."
  },
  State_145436_Name = {
    Text = "Kiếm Xương Bất Diệt"
  },
  State_145437_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>: Khi trang bị nhận [StateArg2] lớp <EnergyStorageKeywords:Súc tích>, Sát thương tăng lên [StateArg1]% khi \"Đánh\" và chuyển thành <PVPPunctureDamagewords:Sát thương xuyên thấu>."
  },
  State_145437_Name = {
    Text = "Hoàng Hôn Của Ngư Thần"
  },
  State_145456_Desc = {
    Text = "Khi chọn mục tiêu sẽ bỏ qua Chế nhạo, Lén lút, Khóa Định. Nếu nhiều mục tiêu có điều kiện bằng nhau, ưu tiên chọn Thể thức tỉnh ở phía trước."
  },
  State_145456_Name = {
    Text = "Sinh lực và lá chắn thấp nhất"
  },
  State_145457_Desc = {
    Text = "Khi chọn mục tiêu sẽ bỏ qua Chế nhạo, Lén lút, Khóa Định. Nếu nhiều mục tiêu có điều kiện bằng nhau, ưu tiên chọn Thể thức tỉnh ở phía trước."
  },
  State_145457_Name = {
    Text = "Sinh lực và lá chắn cao nhất"
  },
  State_145495_Desc = {
    Text = "Thẻ bài này được chơi bởi Bắn Đôi."
  },
  State_145495_Name = {
    Text = "<CardKeyWord:Bắn Đôi>"
  },
  State_145554_Desc = {
    Text = "Đội duy nhất: Sau khi bắt đầu khám phá, thêm 1 thẻ <Falltospace1[StateArg3]:\"Dấn Thân Nhân Gian\"> vào bộ bài. \"Dấn Thân Nhân Gian\": Tiêu thụ 0 Điểm tính toán. Gây Xói mòn cố định lên tất cả kẻ địch bằng <WeaponEffect_Num:[StateArg1]%> Tấn Công của Người trang bị và <WeaponEffect_Num:[Float:StateArg4]%> Sinh lực tối đa của chúng dưới dạng <Corrosion:Xói mòn> cố định, khiến thẻ lệnh của các Thể thức tỉnh khác ở mọi nơi bị gắn thêm <ErosionColorInkKeywords:Nhận thức hỗn loạn> và Xáo trộn 1 thẻ <Falltospace2[StateArg3]:\"Rơi Lên Trên\"> vào rút bài từ bộ bài. <RetainIconKeywords:Giữ lại>. <DepleteIconKeywords:Tiêu thụ>."
  },
  State_145554_Name = {
    Text = "Rơi Lên Trên"
  },
  State_145554_WeaponDesc = {
    Text = "Sau khi bắt đầu khám phá, thêm 1 thẻ <Falltospace1[StateArg3]:\"Dấn Thân Nhân Gian\"> vào bộ bài. \"Dấn Thân Nhân Gian\": Tiêu thụ 0 Điểm tính toán. Gây Xói mòn cố định lên tất cả kẻ địch bằng <WeaponEffect_Num:[StateArg1]%> Tấn Công của Người trang bị và <WeaponEffect_Num:[Float:StateArg4]%> Sinh lực tối đa của chúng dưới dạng <Corrosion:Xói mòn> cố định, khiến thẻ lệnh của các Thể thức tỉnh khác ở mọi nơi bị gắn thêm <ErosionColorInkKeywords:Nhận thức hỗn loạn> và Xáo trộn 1 thẻ <Falltospace2[StateArg3]:\"Rơi Lên Trên\"> vào rút bài từ bộ bài. <RetainIconKeywords:Giữ lại>. <DepleteIconKeywords:Tiêu thụ>"
  },
  State_145572_Desc = {
    Text = "Mỗi lần bắt đầu lượt, tất cả các Thể thức tỉnh khác gây <Damage:[Damage:Layer]> Sát thương xuyên thấu."
  },
  State_145572_Name = {
    Text = "Cơn Bão Của Ngư Thần"
  },
  State_145590_Desc = {
    Text = "Khi thẻ bài giống nhau cùng thuộc tính được đưa vào tay sẽ kích hoạt hiệu ứng Dung Hợp và tiêu thụ thẻ bài đó."
  },
  State_145590_Name = {
    Text = "<CardKeyWord:Dung Hợp>"
  },
  State_145592_Desc = {
    Text = "Khóa Định một kẻ địch, coi đó là mục tiêu tấn công ưu tiên, khi chọn mục tiêu đơn chỉ có thể chọn mục tiêu bị Khóa Định, bỏ qua Chế nhạo và ẩn nấp."
  },
  State_145592_Name = {
    Text = "<CardKeyWord:Khóa Định>"
  },
  State_145619_Name = {
    Text = "Thiệt hại nặng"
  },
  State_145620_Name = {Text = "Hư vô"},
  State_145621_Desc = {
    Text = "Hiệu ứng \"Quà Tặng\" giảm 50%."
  },
  State_145621_Name = {
    Text = "<Bleesing_Exaggerate:Thổi Phồng Sự Thật>"
  },
  State_145622_Name = {Text = "Trì trệ"},
  State_145623_Desc = {
    Text = "Áp lên bản thân 1 hiệu ứng ngẫu nhiên khác nhau: Suy nhược 2 lượt, Mong manh 2 lượt, Thiệt hại nặng 2 lượt, áp Ngộ độc tương đương 1% Sinh lực tối đa, 2 lớp Hư vô, áp 1 lớp Trì trệ lên 2 thẻ ngẫu nhiên trong tay, tạo 2 thẻ triệu chứng tạm thời (không kế thừa qua chiến đấu) đặt vào đầu rút bài từ bộ bài."
  },
  State_145623_Name = {
    Text = "<Bleesing_Negative:Ý Đồ Xấu>"
  },
  State_145624_Name = {
    Text = "Suy nhược"
  },
  State_145625_Name = {
    Text = "2 \"thẻ triệu chứng\" tạm thời giống nhau"
  },
  State_145626_Name = {Text = "Mong manh"},
  State_145627_Name = {
    Text = "Ngộ độc"
  },
  State_145628_Desc = {
    Text = "Sau 2 lượt nhận hiệu ứng \"Quà Tặng\"."
  },
  State_145628_Name = {
    Text = "<Bleesing_Delay:Lỡ Thời Cơ>"
  },
  State_145631_Desc = {
    Text = "Sát thương \"Đánh\" tăng lên [StateArg1]% và chuyển thành <PVPPunctureDamagewords:Sát thương xuyên thấu>."
  },
  State_145631_Name = {
    Text = "Hoàng Hôn Của Ngư Thần"
  },
  State_145632_Desc = {
    Text = "Thẻ bài này đến từ vòng mệnh \"Thời khắc may mắn\"."
  },
  State_145632_Name = {
    Text = "Thời khắc may mắn"
  },
  State_145638_Desc = {
    Text = "Giá trị Điểm tính toán của thẻ bài này tăng thêm [Layer]."
  },
  State_145638_Name = {
    Text = "Lời chào tàn nhẫn"
  },
  State_145642_Desc = {
    Text = "Sau 2 lượt tất cả Thể thức tỉnh nhận được [StateArg1] điểm điên cuồng [Layer] lần."
  },
  State_145642_Name = {
    Text = "Điên cuồng trễ"
  },
  State_145644_Desc = {
    Text = "Sau 2 lượt nhận được <Posse:[StateArg1]> Năng lượng chìa khóa bạc [Layer] lần."
  },
  State_145644_Name = {
    Text = "Năng lượng chìa khóa bạc Trì hoãn"
  },
  State_145645_Desc = {
    Text = "Sau 2 lượt tạm thời giảm [StateArg1] điểm <ExhaustionIconKeywords:sức mạnh> của tất cả kẻ thù [Layer] lần"
  },
  State_145645_Name = {
    Text = "Suy giảm trễ"
  },
  State_145646_Desc = {
    Text = "Sau 2 lượt nhận được [StateArg1] Điểm tính toán [Layer] lần."
  },
  State_145646_Name = {
    Text = "Điểm tính toán trễ"
  },
  State_145647_Desc = {
    Text = "Sau 2 lượt nhận được [StateArg1] điểm <PowerIconKeywords:sức mạnh> [Layer] lần."
  },
  State_145647_Name = {
    Text = "Sức mạnh Trì hoãn"
  },
  State_145648_Desc = {
    Text = "Sau 2 lượt Rút [StateArg1] thẻ bài [Layer] lần."
  },
  State_145648_Name = {
    Text = "Rút bài bị trì hoãn"
  },
  State_145649_Desc = {
    Text = "Sau 2 lượt Khuếch đại sát thương tạm thời [StateArg1]% [Layer] lần."
  },
  State_145649_Name = {
    Text = "Trì hoãn Khuếch đại sát thương tạm thời"
  },
  State_145652_Desc = {
    Text = "Tiêu hao Số học của Thẻ này -[Layer]。"
  },
  State_145652_Name = {
    Text = "Tự do không thể chịu đựng nổi"
  },
  State_145654_Desc = {
    Text = "Thử nghiệm. Sau khi chơi, hoặc sau khi rời khỏi Tay, Hủy hoại."
  },
  State_145654_Name = {
    Text = "Thử nghiệm. Thoáng qua"
  },
  State_145660_Desc = {
    Text = "Phe ta\n1.<AllyPosAwaker1Name:> [DescArg1]\n2.<AllyPosAwaker2Name:> [DescArg2]\n3.<AllyPosAwaker3Name:> [DescArg3]\n4.<AllyPosAwaker4Name:> [DescArg4]\nPhe địch\n1.<EnemyPosAwaker1Name:> [DescArg5]\n2.<EnemyPosAwaker2Name:> [DescArg6]\n3.<EnemyPosAwaker3Name:> [DescArg7]\n4.<EnemyPosAwaker4Name:> [DescArg8]"
  },
  State_145660_Name = {
    Text = "Thay đổi Sinh lực sau Hồi Truy"
  },
  State_145693_Desc = {
    Text = "Sau khi lượt kết thúc, tiêu thụ sức tính toán -[Layer], hiệu ứng này cũng sẽ được kích hoạt khi bị bỏ đi."
  },
  State_145693_Name = {
    Text = "<PrepareKeypvewordscolour:chuẩn bị[Layer]>"
  },
  State_145693_WeaponDesc = {
    Text = "Thẻ bài sẽ không được đưa vào rác bài trong giai đoạn bỏ bài, mà sẽ được giữ lại trong tay bài."
  },
  State_145694_Name = {
    Text = "Cộng Sinh Cùng Đầm Đen"
  },
  State_145698_Desc = {
    Text = "Ưu tiên tấn công <StatusApplier:> bị Khóa Định, khi chọn mục tiêu đơn chỉ có thể chọn mục tiêu bị khóa, bỏ qua Chế nhạo và ẩn thân."
  },
  State_145698_Name = {
    Text = "Khóa Định"
  },
  State_145699_Desc = {
    Text = "·Ưu tiên tấn công <StatusApplier:> bị Khóa Định, khi chọn mục tiêu đơn chỉ có thể chọn mục tiêu bị khóa, bỏ qua Chế nhạo và ẩn thân.\n·Sau khi bản thân chết, <StatusApplier:> nhận được \"<PVPDerivativeCardKeywords_32:Hãy chiến đấu!>\"."
  },
  State_145699_Name = {
    Text = "Khóa Định"
  },
  State_145709_Desc = {
    Text = "Mỗi lớp tăng giới hạn Sinh lực bằng 10% Thể chất của Caraboo, \"No Nê\" tối đa tích lũy 50 lớp. Khi nhận Trạng thái này nếu đã đạt giới hạn, mỗi lớp vượt quá sẽ chuyển thành hồi phục Sinh lực gấp 3 lần lượng tương đương. Mỗi trận chiến không phải Trận chiến Lãnh đạo tối đa nhận 10 lớp \"No Nê\". Không xóa khi kết thúc chiến đấu."
  },
  State_145709_Name = {
    Text = "<WormGrowth:No Nê>"
  },
  State_145710_Desc = {
    Text = "Bạn cũng là một phần của Phép Màu đấy~. Có thể bị Bùng nổ điên cuồng của Caraboo tiêu thụ để nhận lợi ích, trạng thái này tích lũy tối đa 5 lớp. Không xóa sau khi kết thúc chiến đấu"
  },
  State_145710_Name = {
    Text = "<SacrificialMark:Cúng Tế>"
  },
  State_145901_Desc = {
    Text = [=[
Phe ta
1.<AllyPosAwaker1Name:> [DescArg1]
2.<AllyPosAwaker2Name:> [DescArg2]
3.<AllyPosAwaker3Name:> [DescArg3]
4.<AllyPosAwaker4Name:> [DescArg4]]=]
  },
  State_145901_Name = {
    Text = "Thay đổi Sinh lực sau Hồi Truy"
  },
  State_146041_Desc = {
    Text = "Thể thức tỉnh này cảm thấy thoát khỏi sự ồn ào của trần thế.\n·Trước khi kết thúc lượt không thể thực hiện bất kỳ Hành động nào, giảm 99% thương, nếu mục tiêu không có Sức chống cự thì sẽ khiến mục tiêu nhận Sức chống cự.\n·Khi hiệu ứng kết thúc, gây <Damage:[Layer]> Sát Thương Thuần Túy lên toàn bộ đồng đội.\n·Nếu khi áp dụng mục tiêu đã có Sức chống cự, thì lập tức kết thúc Lừa Phỉnh và thương lên mục tiêu tăng gấp đôi."
  },
  State_146041_Name = {
    Text = "Lừa Phỉnh"
  },
  State_146043_Desc = {
    Text = "Khi bắt đầu lượt tiếp theo, trừ [Layer] Điên loạn."
  },
  State_146043_Name = {
    Text = "Trì hoãn trừ Điên loạn"
  },
  State_146058_Desc = {
    Text = "Biến số kiểm tra, làm mới sau khi lượt bắt đầu hoặc sau khi chơi thẻ bài. Hiện nên có [Layer]% công hiệu."
  },
  State_146058_Name = {
    Text = "Công hiệu Mật lệnh"
  },
  State_146059_Desc = {
    Text = "Biến số kiểm tra, làm mới sau khi lượt bắt đầu hoặc sau khi chơi thẻ bài. Hiện nên có [Layer]% phòng hiệu."
  },
  State_146059_Name = {
    Text = "Phòng hiệu Mật lệnh"
  },
  State_146079_Desc = {
    Text = "Sau khi thẻ bài này rời khỏi tay, nó sẽ quay trở lại tay."
  },
  State_146079_Name = {
    Text = "<Recycle:Trở về tay>"
  },
  State_146085_Desc = {
    Text = "Thay đổi Điểm tính toán thẻ bài trước khi chơi trong lượt này"
  },
  State_146085_Name = {
    Text = "Thay đổi Điểm tính toán thẻ bài trước khi chơi trong lượt này"
  },
  State_146085_WeaponDesc = {
    Text = "Trước khi đánh ra, thay đổi chỉ số thẻ"
  },
  State_146086_Desc = {
    Text = "Thay đổi Điểm tính toán thẻ bài trước khi chơi trong lượt này"
  },
  State_146086_Name = {
    Text = "Thay đổi Điểm tính toán thẻ bài trước khi chơi trong lượt này"
  },
  State_146086_WeaponDesc = {
    Text = "Trước khi đánh ra, thay đổi chỉ số thẻ"
  },
  State_146117_Desc = {
    Text = "Có thể được \"<DerivativeCardKeywords_157:Xương Kiếm>\" tiêu thụ để nhận buff. Trạng thái này tối đa tích lũy 15 lớp."
  },
  State_146117_Name = {
    Text = "<Shimieluotanhuodong2:Sẵn lòng chiến đấu>"
  },
  State_146129_Desc = {
    Text = "Sát thương cuối cùng của tất cả Thể thức tỉnh +[Layer]%."
  },
  State_146129_Name = {
    Text = "Cơn Thịnh Nộ Của Kình Ngư"
  },
  State_146147_Desc = {
    Text = "Có thể được \"<DerivativeCardKeywords_157:Xương Kiếm>\" tiêu thụ để nhận buff. Trạng thái này tối đa tích lũy 15 lớp."
  },
  State_146147_Name = {
    Text = "<Shimieluotanhuodong1:Sẵn lòng chiến đấu>"
  },
  State_146154_Desc = {
    Text = "Khiến Thể thức tỉnh này cảm thấy dễ chịu, \"Kỹ Năng\" của nó sẽ bị biến đổi thành \"phúc lành?\", sau khi biến đổi sẽ tiêu thụ số lớp tương đương."
  },
  State_146154_Name = {
    Text = "<PVPBlessColour:phúc lành>"
  },
  State_146155_Desc = {
    Text = "Thể thức tỉnh này cảm thấy rất tốt.\n·Tiếp theo sẽ có [Layer] thẻ \"Kỹ Năng\" được biến đổi thành \"phúc lành?\", sau khi biến đổi tiêu thụ số lớp tương ứng."
  },
  State_146155_Name = {
    Text = "Ban phước"
  },
  State_146155_WeaponDesc = {Text = "Không"},
  State_146202_Desc = {
    Text = "Khiến Thể thức tỉnh này cảm thấy thoát khỏi sự ồn ào của trần thế.\n·Trước khi kết thúc lượt không thể thực hiện bất kỳ Hành động nào, giảm 99% thương, nếu mục tiêu không có Sức chống cự thì sẽ khiến mục tiêu nhận Sức chống cự.\n·Khi hiệu ứng kết thúc gây Sát Thương Thuần Túy tương đương số lớp cho toàn bộ đồng minh.\n·Nếu khi áp dụng mục tiêu đã có Sức chống cự, thì lập tức kết thúc Lừa Phỉnh và thương gây cho mục tiêu tăng gấp đôi."
  },
  State_146202_Name = {
    Text = "<CardKeyWord:Lừa Phỉnh>"
  },
  State_146352_Desc = {
    Text = "Mỗi lần nhận 1 thương, tích lũy [StateArg1] lớp <Shimieluotanhuodong1:Sẵn lòng chiến đấu>"
  },
  State_146352_Name = {
    Text = "Quyết Chiến"
  },
  State_146363_Desc = {
    Text = "Khi bắt đầu lượt tiếp theo, loại bỏ [Layer] Sinh lực. Khi mất Sinh lực sẽ giảm số lớp Trạng thái này tương đương."
  },
  State_146363_Name = {
    Text = "Đấy Thứ Chẳng Phải Dối"
  },
  State_146383_Desc = {
    Text = "Sau khi thêm trạng thái, sau khi chơi thẻ bài, làm mới và in ra Cấp độ nạp năng lượng chìa khóa bạc của từng Thể thức tỉnh."
  },
  State_146383_Name = {
    Text = "Cổng Hiệu Suất"
  },
  State_146384_Desc = {
    Text = "Giá trị P1 [StateArg1], Giá trị P2 [StateArg2], Giá trị P3 [StateArg3], Giá trị P4 [StateArg4]."
  },
  State_146384_Name = {
    Text = "Giá Trị Hiệu Suất"
  },
  State_146385_Desc = {
    Text = "Sau khi thêm trạng thái, sau khi chơi thẻ bài, làm mới và in ra Cấp độ nạp năng lượng chìa khóa bạc của từng Thể thức tỉnh."
  },
  State_146385_Name = {
    Text = "Cổng Cấp Độ"
  },
  State_146386_Desc = {
    Text = "Giá trị P1 [StateArg1], Giá trị P2 [StateArg2], Giá trị P3 [StateArg3], Giá trị P4 [StateArg4]."
  },
  State_146386_Name = {
    Text = "Giá Trị Cấp Độ"
  },
  State_146446_Desc = {
    Text = "Phòng thủ của Thể thức tỉnh, P1: [StateArg1], P2: [StateArg2], P3: [StateArg3], P4: [StateArg4]."
  },
  State_146446_Name = {
    Text = "Danh sách thuộc tính phòng thủ"
  },
  State_146448_Desc = {
    Text = "Tấn công của Thể thức tỉnh, P1: Lực [StateArg1] cường độ [StateArg2], P2: Lực [StateArg3] cường độ [StateArg4], P3: Lực [StateArg5] cường độ [StateArg6], P4: Lực [StateArg7] cường độ [StateArg8]."
  },
  State_146448_Name = {
    Text = "Danh sách thuộc tính tấn công"
  },
  State_146452_Desc = {
    Text = "Đội duy nhất: Sát thương chí mạng của \"Đánh\" của người trang bị tăng <WeaponEffect_Num:[StateArg1]%>. Khi kết thúc lượt, Sát thương chí mạng của lần Bùng nổ tiếp theo của người trang bị tăng, tỷ lệ phần trăm tăng bằng <WeaponEffect_Num:[StateArg2]%> căn bản điên cuồng của họ, tối đa chồng 5 lần."
  },
  State_146452_WeaponDesc = {
    Text = "Sát thương chí mạng của \"Đánh\" của người trang bị tăng <WeaponEffect_Num:[StateArg1]%>. Khi kết thúc lượt, sát thương chí mạng của lần Bùng nổ tiếp theo của người trang bị tăng <WeaponEffect_Num:[DescArg1]%>, tối đa chồng 5 lần (hiện đang hưởng [DescArg2]%)."
  },
  State_146456_Desc = {
    Text = "Đội duy nhất: Sát thương chí mạng của \"Đánh\" của người trang bị tăng <WeaponEffect_Num:[StateArg1]%>."
  },
  State_146456_WeaponDesc = {
    Text = "Sát thương chí mạng của \"Đánh\" của người trang bị tăng <WeaponEffect_Num:[StateArg1]%>."
  },
  State_146534_Desc = {
    Text = "Sau khi Màn chơi bắt đầu, thêm các vật chứa của từng cơ chế Hỗn Mang Khởi Nguyên cho Người Giữ Gìn."
  },
  State_146534_Name = {
    Text = "Khởi Tạo Hỗn Mang Khởi Nguyên"
  },
  State_146535_Desc = {
    Text = "Vật chứa thuộc tính."
  },
  State_146535_Name = {
    Text = "Nhãn Hỗn Mang Khởi Nguyên"
  },
  State_146536_Desc = {
    Text = "Vùng chứa cơ chế."
  },
  State_146536_Name = {
    Text = "Cơ chế Hỗn Mang Nguyên Sơ"
  },
  State_146644_Desc = {
    Text = "Khai mở linh trí nhận được Chuẩn bị 1, lần đầu tiên chơi trong mỗi lượt sẽ tự động kích hoạt Mật lệnh đang mang."
  },
  State_146644_Name = {
    Text = "Vọng Âm Khởi Nguyên"
  },
  State_146645_Desc = {
    Text = "Cõi Hỗn Mang mới lần đầu tiên chơi Khai mở linh trí trong mỗi lượt sẽ tự động kích hoạt Mật lệnh đang mang. Hiện đang khả dụng."
  },
  State_146645_Name = {
    Text = "Nhãn hiệu khả dụng"
  },
  State_146646_Desc = {
    Text = "Giới hạn Năng lượng chìa khóa bạc cơ bản được đổi thành 2000. Quy tắc nhận Năng lượng chìa khóa bạc được thay thế bằng: Thể thức tỉnh lần đầu tiên chơi thẻ lệnh trong mỗi lượt, nhận được Năng lượng chìa khóa bạc bằng 3 lần Sạc năng lượng chìa khóa bạc + 100."
  },
  State_146646_Name = {
    Text = "Quy tắc Năng lượng chìa khóa Hỗn Mang mới"
  },
  State_146651_Desc = {
    Text = "Tăng thuộc tính Tấn công của Thể thức tỉnh này lên [Layer]%."
  },
  State_146651_Name = {
    Text = "Hỗn Mang·Tấn Công"
  },
  State_146652_Desc = {
    Text = "Chỉ 1 lần sau khi chiến đấu bắt đầu, đổi hiệu suất Sạc năng lượng chìa khóa bạc của mỗi Thể thức tỉnh thành giá trị trung bình của Cấp độ nạp năng lượng chìa khóa bạc."
  },
  State_146652_Name = {
    Text = "Cân Bằng Nguyên Sơ"
  },
  State_146653_Desc = {
    Text = "Tăng thuộc tính Phòng thủ của Thể thức tỉnh này lên [Layer]%."
  },
  State_146653_Name = {
    Text = "Hỗn Mang·Phòng thủ"
  },
  State_146663_Desc = {
    Text = "[Layer] lá Lotan: Ngư Thần tiếp theo, \"Đánh\" có hiệu lực thêm 1 lần."
  },
  State_146663_Name = {
    Text = "Cơn Bão Của Ngư Thần"
  },
  State_147058_Name = {
    Text = "Vòng Phòng Trang Sức 36"
  },
  State_147079_Desc = {
    Text = "Thẻ bài này không thể bỏ đi, không thể thay đổi."
  },
  State_147079_Name = {
    Text = "<RetainIconKeywordsColour:Bắt buộc Giữ lại>"
  },
  State_147545_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>: Chưa cấu hình"
  },
  State_147545_Name = {
    Text = "Mộ Tinh·Tincture SR (Văn bản tạm thời)"
  },
  State_147546_Name = {Text = "Bỏ đi"},
  State_147546_WeaponDesc = {
    Text = "Giọng ngoài thế giới"
  },
  State_147584_Desc = {
    Text = "Hiệu ứng <Blessing:ân huệ> của <DerivativeCardKeywords_152:\"Tiên Nữ Ban Ân\"> tiếp theo được chơi tăng 50%"
  },
  State_147737_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>: Khi trang bị nhận được [StateArg1] <MaxHPKeywords:Sinh lực tối đa>. Khi lượt bắt đầu, gây <Damage:[Damage:StateArg2]> sát thương <PVPBleedingKeywords:Chảy máu> cho toàn bộ kẻ địch,"
  },
  State_147737_Name = {
    Text = "Từ tối đến tối"
  },
  State_147764_Name = {
    Text = "Trạng thái@Đếm số lần chọn sai sự kiện Caraboo"
  },
  State_147765_Desc = {
    Text = "Khi lượt tiếp theo bắt đầu, mất 2 Điểm tính toán và rút ít hơn 2 thẻ bài."
  },
  State_147765_Name = {
    Text = "Sô Cô La Đồng Xu của Quý Cô Marie"
  },
  State_147768_Desc = {
    Text = "Khi lượt tiếp theo bắt đầu, nhận được [DescArg1] Cảm hứng nâng cao."
  },
  State_147768_Name = {
    Text = "Đồng Vàng Đồng Xu của Quý Cô Marie"
  },
  State_147769_Desc = {
    Text = "Trong trận chiến này \"No Nê\" hiện đã chồng [Layer] lớp."
  },
  State_147769_Name = {
    Text = "Giới Hạn Chồng Lớp"
  },
  State_147772_Name = {
    Text = "Trạng thái@Hoạt động Caraboo thêm giới hạn Năng lượng chìa khóa tạm thời"
  },
  State_147773_Name = {
    Text = "Trạng thái@Hoạt động Caraboo thêm giới hạn Năng lượng chìa khóa tạm thời"
  },
  State_147774_Name = {
    Text = "Trạng thái@Hoạt động Caraboo thêm giới hạn Năng lượng chìa khóa tạm thời_Hỗn Mang thường"
  },
  State_147797_Desc = {
    Text = "Có thể nhận hoặc mất điên cuồng, <PowerIconKeywords:sức mạnh>, Sinh lực, Năng lượng chìa khóa bạc và Điểm tính toán cùng việc Rút bài."
  },
  State_147797_Name = {
    Text = "Sô Cô La Đồng Xu của Quý Cô Marie"
  },
  State_147800_Desc = {
    Text = "Khi lượt tiếp theo bắt đầu, mất 2 Điểm tính toán và rút ít hơn 2 thẻ bài."
  },
  State_147800_Name = {
    Text = "Sô Cô La Đồng Xu của Quý Cô Marie"
  },
  State_147869_Name = {
    Text = "Rút [Layer] lá bài"
  },
  State_147870_Name = {
    Text = "Khiến kẻ địch yếu đuối trong [Layer] lượt"
  },
  State_147871_Name = {
    Text = "Nhận được [Energy:DescArg1] điểm điên cuồng"
  },
  State_147872_Name = {
    Text = "Gây yếu điểm sát thương lên tất cả kẻ địch trong [Layer] lượt"
  },
  State_147873_Name = {
    Text = "Nhận được [Layer] sức tính toán"
  },
  State_147874_Name = {
    Text = "Nhận được [Block:DescArg1] giáp bảo vệ"
  },
  State_147962_Desc = {
    Text = "Sau đó khi người chơi chơi \"<DerivativeCardKeywords_158:Gánh Tội>\" chỉ xua tan 50% số lớp <MonsterSinMarkKeywords:Dấu ấn tội lỗi>, và mỗi khi chơi 1 thẻ lệnh \"Con Thánh·Đêm Trắng\" sẽ nhận được 1 lớp <MonsterSinMarkKeywords:Dấu ấn tội lỗi>."
  },
  State_147962_Name = {
    Text = "Con Đường Gột Rửa"
  },
  State_147967_Desc = {
    Text = "「Thánh Tử·Bạch Dạ」gây ra sát thương kèm theo [DescArg1]% <BleedingIconKeywords:Chảy máu>."
  },
  State_147967_Name = {
    Text = "Dấu ấn tội lỗi"
  },
  State_147968_Desc = {
    Text = "Giới hạn 3 lớp, khi chuyển sang ý định tấn công, khiến sát thương của 「Thánh Tử·Bạch Dạ」Tăng Sát Thương 25% và tiêu thụ 1 lớp."
  },
  State_147968_Name = {
    Text = "Cứu rỗi bằng đau khổ"
  },
  State_147969_Desc = {
    Text = "Khi 「Thánh Tử·Bạch Dạ」đang ở ý định \"Thánh Tâm\", mỗi khi chơi 1 thẻ lệnh tích lũy 2 lớp <MonsterPolluxFever:Cuồng nhiệt>."
  },
  State_147969_Name = {
    Text = "Định Thế Đọa Thiên"
  },
  State_147971_Desc = {
    Text = "Thể thức tỉnh này chưa thức tỉnh… khi sắp bị đánh ngã sẽ hồi phục sinh lực và nhận 1 lớp <InvincibleUntilRoused:Lõi Bạc Cứng Hóa>, sau khi thức tỉnh sẽ xóa <InvincibleUntilRoused:Lõi Bạc Cứng Hóa> và bắt đầu chiến đấu ở hình thái thực sự."
  },
  State_147971_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_147972_Desc = {
    Text = "Mỗi lớp khiến sát thương của 「Thánh Tử·Bạch Dạ」kèm theo thêm 1% <BleedingIconKeywords:Chảy máu>."
  },
  State_147972_Name = {
    Text = "<MonsterSinMarkKeywords:Dấu ấn tội lỗi>"
  },
  State_147974_Desc = {
    Text = "Xóa sau khi lượt bắt đầu. Sau khi đạt 10 lớp, lần tiếp theo sau khi chơi thẻ bài sẽ lập tức hành động, xóa Cuồng nhiệt và chuyển ý định sang \"Thánh Tâm\"."
  },
  State_147974_Name = {
    Text = "Tạm thời cuồng nhiệt"
  },
  State_147975_Desc = {
    Text = "Khi chiến đấu bắt đầu, đặt một thẻ \"<DerivativeCardKeywords_158:Gánh Tội>\" vào Tay, sau khi kết thúc lượt, nhận được 5 lớp <MonsterSinMarkKeywords:Dấu ấn tội lỗi>."
  },
  State_147975_Name = {
    Text = "Sứ Giả Minh Quang"
  },
  State_147993_Desc = {
    Text = "Giới hạn 3 lớp, khi chuyển sang ý định tấn công, khiến sát thương của 「Thánh Tử·Bạch Dạ」Tăng Sát Thương 25% và tiêu thụ 1 lớp."
  },
  State_147993_Name = {
    Text = "Cứu rỗi bằng đau khổ"
  },
  State_148020_Desc = {
    Text = "Miễn dịch mọi sát thương và không thể mất sinh lực, bị xóa sau khi thức tỉnh."
  },
  State_148020_Name = {
    Text = "Lõi Bạc Cứng Hóa"
  },
  State_148021_Name = {
    Text = "Trạng thái@Nhãn xóa Miễn dịch trước khi thức tỉnh Sự phục sinh chung của quái vật"
  },
  State_148073_Name = {
    Text = "Rút 1 lá bài"
  },
  State_148074_Desc = {
    Text = "Thẻ bài sẽ không được đưa vào rác bài trong giai đoạn bỏ bài, mà sẽ được giữ lại trong tay bài."
  },
  State_148074_Name = {
    Text = "<RetainIconKeywords:giữ lại>"
  },
  State_148074_WeaponDesc = {
    Text = "Thẻ bài sẽ không được đưa vào rác bài trong giai đoạn bỏ bài, mà sẽ được giữ lại trong tay bài."
  },
  State_148076_Name = {
    Text = "Theo dõi đánh bài Đường thanh tẩy thế giới"
  },
  State_148116_Desc = {
    Text = "Sau 1 lượt rút [StateArg1] lá bài [Layer] lần."
  },
  State_148116_Name = {
    Text = "Rút bài bị trì hoãn 1"
  },
  State_148381_Desc = {
    Text = "Cho đến khi kết thúc lượt, sát thương bản thân gây ra kèm theo 100% <BleedingIconKeywords:Chảy máu>."
  },
  State_148381_Name = {
    Text = "Rancor Bị Xiềng Xích"
  },
  State_148383_Desc = {
    Text = "Giới hạn 3 lớp. Nếu có 3 lớp \"Hận Thù\", lần tiếp theo ý định chuyển sang \"chuỗi máu\", sẽ chuyển ý định thành \"Bóng xích thèm máu\" và xóa \"Hận Thù\"."
  },
  State_148383_Name = {
    Text = "\"Hận Thù\""
  },
  State_148385_Desc = {
    Text = "Mỗi khi kẻ địch chơi thẻ lệnh thì nhận được 2 lớp <MonsterB05EXFever:Tạm thời cuồng nhiệt>."
  },
  State_148385_Name = {
    Text = "hình dạng không đều"
  },
  State_148386_Desc = {
    Text = "Không thể nhận lá chắn cho đến khi kết thúc lượt."
  },
  State_148386_Name = {
    Text = "Ràng Buộc Thân Thể"
  },
  State_148387_Desc = {
    Text = "Thể thức tỉnh này chưa thức tỉnh… khi sắp bị đánh ngã sẽ hồi phục sinh lực và nhận 1 lớp <InvincibleUntilRoused:Lõi Bạc Cứng Hóa>, sau khi thức tỉnh sẽ xóa <InvincibleUntilRoused:Lõi Bạc Cứng Hóa> và bắt đầu chiến đấu ở hình thái thực sự."
  },
  State_148387_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_148391_Desc = {
    Text = "Cho đến khi kết thúc lượt, sát thương bản thân gây ra kèm theo 100% <BleedingIconKeywords:Chảy máu>."
  },
  State_148391_Name = {
    Text = "Ràng Buộc Thân Thể"
  },
  State_148392_Desc = {
    Text = "Xóa sau khi lượt bắt đầu. Sau khi đạt 10 lớp, lần tiếp theo sau khi chơi thẻ bài sẽ lập tức hành động, xóa Cuồng nhiệt và chuyển ý định sang \"chuỗi máu\"."
  },
  State_148392_Name = {
    Text = "Tạm thời cuồng nhiệt"
  },
  State_148394_Desc = {
    Text = "Khi bắt đầu lượt, nhận 1 lớp <ResentChainsKeywords:Dây xích oán hận>. Khi ý định chuyển sang \"Bóng xích thèm máu\", miễn dịch mọi sát thương và hiệu ứng mất Sinh lực cho đến khi kết thúc lượt của kẻ địch."
  },
  State_148394_Name = {
    Text = "Tuyên bố của Người Thu Thập Hồn"
  },
  State_148395_Desc = {
    Text = "Miễn dịch mọi sát thương (bao gồm sát thương xuyên thấu) và không thể mất Sinh lực, bị xóa sau khi kết thúc lượt của kẻ địch."
  },
  State_148395_Name = {
    Text = "Tuyên bố của Người Thu Thập Hồn - Bóng xích thèm máu"
  },
  State_148421_Desc = {
    Text = "Sau 1 lượt tạm thời giảm [StateArg1] điểm <ExhaustionIconKeywords:sức mạnh> của tất cả kẻ thù [Layer] lần"
  },
  State_148421_Name = {
    Text = "Trì hoãn Hấp thụ 1"
  },
  State_148422_Desc = {
    Text = "Sau 1 lượt tạm thời Khuếch đại sát thương [StateArg1]% [Layer] lần."
  },
  State_148422_Name = {
    Text = "Trì hoãn tạm thời Khuếch đại sát thương 1"
  },
  State_148423_Desc = {
    Text = "Sau 1 lượt nhận được <Posse:[StateArg1]> Năng lượng chìa khóa bạc [Layer] lần."
  },
  State_148423_Name = {
    Text = "Trì hoãn Năng lượng chìa khóa bạc 1"
  },
  State_148426_Desc = {
    Text = "Sau 1 lượt nhận được [StateArg1] Điểm tính toán [Layer] lần."
  },
  State_148426_Name = {
    Text = "Trì hoãn Điểm tính toán 1"
  },
  State_148427_Desc = {
    Text = "Sau 1 lượt tất cả Thể thức tỉnh nhận được [StateArg1] điểm điên cuồng [Layer] lần."
  },
  State_148427_Name = {
    Text = "Điên cuồng trễ 1"
  },
  State_148428_Desc = {
    Text = "Sau 1 lượt nhận được [StateArg1] điểm <PowerIconKeywords:sức mạnh> [Layer] lần."
  },
  State_148428_Name = {
    Text = "Trì hoãn sức mạnh 1"
  },
  State_148511_Desc = {
    Text = "Đội duy nhất: Sau khi bắt đầu khám phá, thêm 1 thẻ <Backupbody[StateArg3]:\"Đồng Bộ Linh Hồn\"> vào bộ bài. \"Đồng Bộ Linh Hồn\": Giá trị Điểm tính toán 0, sau khi chơi nhận được 1 điểm Điểm tính toán. <RetainIconKeywords:Giữ lại>: Tích lũy lượng hồi phục sinh lực cố định bằng <WeaponEffect_Num:[StateArg1]%> Thể chất của người trang bị và <WeaponEffect_Num:[StateArg2]> điểm điên cuồng cố định trong thẻ bài này. Nếu thẻ này chưa bị hủy hoại, có thể miễn dịch một lần tử vong và giải phóng toàn bộ lượng hồi phục sinh lực và điên cuồng đã tích lũy, sau đó <DestructionKeywords:hủy hoại> thẻ bài này."
  },
  State_148511_Name = {
    Text = "Đồng Bộ Linh Hồn"
  },
  State_148511_WeaponDesc = {
    Text = "Sau khi bắt đầu khám phá, thêm 1 thẻ <Backupbody[StateArg3]:\"Đồng Bộ Linh Hồn\"> vào bộ bài. \"Đồng Bộ Linh Hồn\": Giá trị Điểm tính toán 0, sau khi chơi nhận được 1 điểm Điểm tính toán. <RetainIconKeywords:Giữ lại>: Tích lũy lượng hồi phục sinh lực cố định bằng <WeaponEffect_Num:[StateArg1]%> Thể chất của người trang bị và <WeaponEffect_Num:[StateArg2]> điểm điên cuồng cố định trong thẻ bài này. Nếu thẻ này chưa bị hủy hoại, có thể miễn dịch một lần tử vong và giải phóng toàn bộ lượng hồi phục sinh lực và điên cuồng đã tích lũy, sau đó <DestructionKeywords:hủy hoại> thẻ bài này."
  },
  State_148513_Desc = {
    Text = "Đối phương sẽ không loại bỏ tay bài khi kết thúc lượt. Khi kết thúc lượt, lần lượt áp dụng 2 lớp <FragileIconKeywords:mỏng manh>, <WeaknessIconKeywords:suy nhược>, <HeavyInjuryKeywords:thiệt hại nặng>, <VulnerabilityIconKeywords:trọng thương> trạng thái."
  },
  State_148513_Name = {
    Text = "Giọng ngoài thế giới"
  },
  State_148520_Desc = {
    Text = "Không thể nhận lá chắn cho đến khi kết thúc lượt."
  },
  State_148520_Name = {
    Text = "Rancor Bị Xiềng Xích"
  },
  State_148522_Desc = {
    Text = "Đội duy nhất: Lá chắn và sức mạnh từ \"Bùng nổ\" của người trang bị tăng <WeaponEffect_Num:[StateArg1]%>."
  },
  State_148524_Desc = {
    Text = "Đội duy nhất: Lá chắn và sức mạnh từ \"Bùng nổ\" của người trang bị tăng <WeaponEffect_Num:[StateArg1]%>. Lá chắn từ \"phòng thủ\" của người trang bị tăng <WeaponEffect_Num:[StateArg2]%>. Sau khi người trang bị chơi \"phòng thủ\", nhận được sức mạnh bằng <WeaponEffect_Num:[StateArg3]%> Tấn công của người trang bị."
  },
  State_148540_Desc = {
    Text = "Trì hoãn[Layer]: Giá trị Điểm tính toán của [StateArg1] thẻ lệnh có Điểm tính toán cao nhất của <AwakerName:[DescArg1]> giảm [StateArg2]."
  },
  State_148540_Name = {
    Text = "Gương Tiên Tri - Trì hoãn[Layer]"
  },
  State_148541_Name = {
    Text = "Xóa hiệu ứng \"Trì trệ\" khỏi thẻ bài Thể thức tỉnh được chọn trong tay"
  },
  State_148544_Desc = {
    Text = "Trì hoãn[Layer]: Trong lần Bùng nổ tiếp theo của <AwakerName:[DescArg1]>, mỗi 1 điểm điên cuồng tiêu thụ sẽ nhận được [StateArg1] điểm Năng lượng chìa khóa bạc."
  },
  State_148544_Name = {
    Text = "Chìa Khóa Ác Quỷ - Trì hoãn[Layer]"
  },
  State_148547_Desc = {
    Text = "Lần Bùng nổ tiếp theo của <AwakerName:[DescArg1]> được coi là bùng nổ siêu giới hạn, nếu đã là bùng nổ siêu giới hạn thì hoàn trả 100% căn bản điên cuồng."
  },
  State_148547_Name = {
    Text = "Vương Miện Vĩnh Hằng"
  },
  State_148548_Desc = {
    Text = "Giữ lại: Tất cả Thể thức tỉnh nhận được 5 điểm điên cuồng."
  },
  State_148548_Name = {
    Text = "Thu Vào Bóng Ngược"
  },
  State_148549_Name = {
    Text = "Kích hoạt tất cả hiệu ứng \"Chuẩn bị\" trong tay"
  },
  State_148553_Desc = {
    Text = "Trì hoãn[Layer]: <AwakerName:[DescArg1]> chơi [Layer] thẻ lệnh tiếp theo nhận lá chắn bằng [StateArg2]% Sinh lực đã mất."
  },
  State_148553_Name = {
    Text = "Quả Cám Dỗ - Trì hoãn[Layer]"
  },
  State_148554_Desc = {
    Text = "Thẻ lệnh của <AwakerName:[DescArg1]> gây sát thương kèm theo [Layer]% Chảy máu."
  },
  State_148554_Name = {
    Text = "Mắt Tất Diệt"
  },
  State_148556_Desc = {
    Text = "Khi ở trong tay, tất cả Thể thức tỉnh khi gây Sát thương chủ động sẽ gây thêm 10% Chảy máu."
  },
  State_148556_Name = {
    Text = "Ác Mộng Đúng Hẹn"
  },
  State_148557_Desc = {
    Text = "<AwakerName:[DescArg1]> chơi [Layer] thẻ lệnh tiếp theo nhận lá chắn bằng [StateArg1]% Sinh lực đã mất."
  },
  State_148557_Name = {
    Text = "Quả Cám Dỗ"
  },
  State_148559_Desc = {
    Text = "Trong lần Bùng nổ tiếp theo của <AwakerName:[DescArg1]>, mỗi 1 điểm điên cuồng tiêu thụ sẽ nhận được [Layer] điểm Năng lượng chìa khóa bạc."
  },
  State_148559_Name = {
    Text = "Chìa Khóa Ác Quỷ"
  },
  State_148561_Desc = {
    Text = "Khi chơi thẻ này, ngẫu nhiên kích hoạt một trong ba hiệu ứng tiêu cực sau: Giảm hiệu ứng 50%/Trì hoãn 2 lượt mới có hiệu lực/Ngẫu nhiên nhận 1 hiệu ứng tiêu cực."
  },
  State_148561_Name = {
    Text = "<ExclamationPointColour:Tâm Nguyện Bị Bóp Méo>"
  },
  State_148562_Name = {
    Text = "Thể thức tỉnh được chọn nhận 10 điểm điên cuồng"
  },
  State_148563_Desc = {
    Text = "Trì hoãn[Layer]: Lá chắn và Tăng Hồi Phục Sinh lực mà <AwakerName:[DescArg1]> nhận được trong lần Bùng nổ tiếp theo tăng [StateArg1]%."
  },
  State_148563_Name = {
    Text = "Lông Vũ Công Lý - Trì hoãn[Layer]"
  },
  State_148566_Desc = {
    Text = "Lần Bùng nổ tiếp theo của <AwakerName:[DescArg1]> gây sát thương kèm theo [Layer]% Phán Quyết Mệnh Vận."
  },
  State_148566_Name = {
    Text = "Sợi Chỉ Số Mệnh"
  },
  State_148569_Desc = {
    Text = "Lá chắn và Tăng Hồi Phục Sinh lực mà <AwakerName:[DescArg1]> nhận được trong lần Bùng nổ tiếp theo tăng [Layer]%."
  },
  State_148569_Name = {
    Text = "Lông Vũ Công Lý"
  },
  State_148571_Desc = {
    Text = "Trì hoãn[Layer] : Thẻ lệnh của <AwakerName:[DescArg1]> gây sát thương kèm theo [StateArg1]% Chảy máu."
  },
  State_148571_Name = {
    Text = "Mắt Tất Diệt - Trì hoãn[Layer]"
  },
  State_148574_Desc = {
    Text = "Trì hoãn[Layer] : Lần Bùng nổ tiếp theo của <AwakerName:[DescArg1]> gây sát thương kèm theo [StateArg1]% Phán Quyết Mệnh Vận."
  },
  State_148574_Name = {
    Text = "Sợi Chỉ Số Mệnh - Trì hoãn[Layer]"
  },
  State_148575_Name = {
    Text = "Thể thức tỉnh được chọn nhận 20 điểm điên cuồng"
  },
  State_149089_Name = {
    Text = "Trạng thái@Nhãn điên cuồng nuốt chửng của Chó Đèn Lồng nhỏ"
  },
  State_149092_Desc = {
    Text = "Đã nuốt <Energy:[Energy:DescArg2]> điểm điên cuồng của \"<AwakerName:[DescArg1]>\", trả lại sau khi chết."
  },
  State_149092_Name = {
    Text = "Nuốt Chửng"
  },
  State_149094_Desc = {
    Text = "Đội duy nhất: Khiên cơ bản từ Bùng nổ của Người trang bị tăng <WeaponEffect_Num:[StateArg1]%>. Sau khi Người trang bị chơi thẻ lệnh gây <WeaknessIconKeywords:Suy nhược>, Khiên cơ bản của thẻ lệnh tiếp theo của Người trang bị tăng <WeaponEffect_Num:[StateArg1]%>. Khi sử dụng \"Lò nung đỏ thẫm\", Rút 1 thẻ kỹ năng có Giá trị Điểm tính toán cao nhất của Người trang bị, <EmbryoFusionIconKeywords:Dung hợp Phôi thai> +<WeaponEffect_Num: [StateArg1]>, hồi chiêu 3 lượt."
  },
  State_149094_WeaponDesc = {
    Text = "Khiên cơ bản từ Bùng nổ của Người trang bị tăng <WeaponEffect_Num:[StateArg1]%>. Sau khi Người trang bị chơi thẻ lệnh gây <WeaknessIconKeywords:Suy nhược>, Khiên cơ bản của thẻ lệnh tiếp theo của Người trang bị tăng <WeaponEffect_Num:[StateArg1]%>. Khi sử dụng \"Lò nung đỏ thẫm\", Rút 1 thẻ kỹ năng có Giá trị Điểm tính toán cao nhất của Người trang bị, <EmbryoFusionIconKeywords:Dung hợp Phôi thai> +<WeaponEffect_Num: [StateArg1]>, hồi chiêu 3 lượt."
  },
  State_149122_Desc = {
    Text = "Sau khi chết lập tức gọi một \"Đàn Hati\" hoặc \"Đàn Skul\" ngẫu nhiên, khiến \"Hiệu ứng tập trung\" của nó giảm 1 lớp."
  },
  State_149122_Name = {
    Text = "Hiệu ứng tập trung"
  },
  State_149123_Desc = {
    Text = "Sát thương nhận từ Bùng nổ giảm 50%."
  },
  State_149123_Name = {
    Text = "Bấc Đèn Hóa·Dung"
  },
  State_149124_Desc = {
    Text = "Sát thương nhận từ thẻ lệnh giảm 50%."
  },
  State_149124_Name = {
    Text = "Bấc Đèn Hóa·Ảnh"
  },
  State_149125_Desc = {
    Text = "Đã Đóng băng thẻ lệnh của \"<AwakerName:[DescArg1]>\", sau khi chết sẽ giải trừ trạng thái đóng băng của Thể thức tỉnh đó."
  },
  State_149125_Name = {
    Text = "Nuốt Chửng"
  },
  State_149126_Desc = {
    Text = "Sau khi chết lập tức gọi một \"Đàn Skul\" ngẫu nhiên, khiến \"Hiệu ứng tập trung\" của nó giảm 1 lớp."
  },
  State_149126_Name = {
    Text = "Hiệu ứng tập trung"
  },
  State_149128_Name = {
    Text = "Trạng thái@Nhãn thẻ bài đóng băng của Chó Đèn Lồng Băng Tuyết nhỏ"
  },
  State_149140_Desc = {
    Text = "Sẽ làm tăng cường kỹ năng của kẻ địch.Mỗi lần bị thương sẽ mất một lớp."
  },
  State_149140_Name = {
    Text = "Sumpah Darah"
  },
  State_149143_Desc = {
    Text = "Sau khi kết thúc giai đoạn rút bài từ bộ bài, cứ mỗi [DescArg1] thẻ lệnh <SlowIconKeywords:Trì trệ> trong tay kẻ địch, bản thân nhận được [DescArg2] lớp <BloodOath_New:Sumpah Darah>. Sau khi bản thân gây sát thương không bị chặn, ngẫu nhiên áp [DescArg4] lớp <SlowIconKeywords:Trì trệ> lên [DescArg3] thẻ lệnh chưa bị <SlowIconKeywords:Trì trệ> trong Tay hoặc rút bài từ bộ bài."
  },
  State_149143_Name = {
    Text = "Huyết Thệ Ngưng Trệ"
  },
  State_149162_Desc = {
    Text = "Khi gây sát thương không bị chặn, xóa kháng cự tử vong"
  },
  State_149162_Name = {
    Text = "Phù Thuật Cực Đông"
  },
  State_149163_Desc = {
    Text = "Sinh lực tối đa giảm số lớp tương ứng, giảm một nửa sau khi kết thúc chiến đấu."
  },
  State_149163_Name = {
    Text = "<BoneHitKeywords:Scathe>"
  },
  State_149164_Desc = {
    Text = "Khi gây sát thương sẽ áp Scathe"
  },
  State_149164_Name = {
    Text = "Sương Giá Buốt Xương"
  },
  State_149167_Desc = {
    Text = "Sinh lực tối đa giảm [Layer], giảm một nửa sau khi kết thúc chiến đấu."
  },
  State_149167_Name = {
    Text = "<BoneHitKeywords:Scathe>"
  },
  State_149169_Desc = {
    Text = "Mỗi lớp tăng giới hạn Sinh lực bằng 15% Thể chất của Caraboo, \"No Nê\" tối đa tích lũy 50 lớp. Khi nhận Trạng thái này nếu đã đạt giới hạn, mỗi lớp vượt quá sẽ chuyển thành hồi phục Sinh lực gấp 3 lần lượng tương đương. Mỗi trận chiến không phải Trận chiến Lãnh đạo tối đa nhận 10 lớp \"No Nê\". Không xóa khi kết thúc chiến đấu."
  },
  State_149169_Name = {
    Text = "<WormGrowth:No Nê>"
  },
  State_149172_Desc = {
    Text = "Đội duy nhất: Sau khi Người trang bị chơi thẻ lệnh gây <WeaknessIconKeywords:Suy nhược>, Khiên cơ bản của thẻ lệnh tiếp theo của Người trang bị tăng <WeaponEffect_Num:[StateArg1]%>."
  },
  State_149172_WeaponDesc = {
    Text = "Sau khi Người trang bị chơi thẻ lệnh gây <WeaknessIconKeywords:Suy nhược>, Khiên cơ bản của thẻ lệnh tiếp theo của Người trang bị tăng <WeaponEffect_Num:[StateArg1]%>."
  },
  State_149187_Desc = {
    Text = "Kiểm tra｜Lắng nghe sau khi nhận sát thương cố định, sau khi sát thương cố định gây ra Giết, và in ra giá trị kích hoạt, đối tượng liên quan."
  },
  State_149187_Name = {
    Text = "Kiểm tra sát thương cố định"
  },
  State_149188_Desc = {
    Text = "Kiểm tra｜Sau khi sát thương cố định gây ra Giết, giá trị kích hoạt 1, sát thương thực tế Giết:[Layer]"
  },
  State_149188_Name = {
    Text = "Kiểm tra giá trị kích hoạt giết cố định 2"
  },
  State_149189_Desc = {
    Text = "Kiểm tra｜Sau khi sát thương cố định gây ra Giết, đối tượng liên quan 2, nguồn gây ra Giết:[Layer]"
  },
  State_149189_Name = {
    Text = "Kiểm tra đối tượng liên quan giết cố định 2"
  },
  State_149190_Desc = {
    Text = "Kiểm tra｜Sau khi sát thương cố định gây ra Giết, giá trị kích hoạt 1, sát thương tràn Giết:[Layer]"
  },
  State_149190_Name = {
    Text = "Kiểm tra giá trị kích hoạt giết cố định 3"
  },
  State_149191_Desc = {
    Text = "Kiểm tra｜Sau khi nhận sát thương cố định, giá trị kích hoạt 1, tổng sát thương:[Layer]"
  },
  State_149191_Name = {
    Text = "Kiểm tra giá trị kích hoạt cố định 1"
  },
  State_149192_Desc = {
    Text = "Kiểm tra｜Sau khi sát thương cố định gây ra Giết, đối tượng liên quan 1, người bị giết:[Layer]"
  },
  State_149192_Name = {
    Text = "Kiểm tra đối tượng liên quan giết cố định 1"
  },
  State_149193_Desc = {
    Text = "Kiểm tra｜Sau khi nhận sát thương cố định, đối tượng liên quan 2, người bị đánh:[Layer]"
  },
  State_149193_Name = {
    Text = "Kiểm tra đối tượng liên quan cố định 2"
  },
  State_149194_Desc = {
    Text = "Kiểm tra｜Sau khi nhận sát thương cố định, giá trị kích hoạt 1, tổng sát thương:[Layer]"
  },
  State_149194_Name = {
    Text = "Kiểm tra giá trị kích hoạt cố định 2"
  },
  State_149195_Desc = {
    Text = "Kiểm tra｜Sau khi sát thương cố định gây ra Giết, giá trị kích hoạt 1, tổng sát thương Giết:[Layer]"
  },
  State_149195_Name = {
    Text = "Kiểm tra giá trị kích hoạt giết cố định 1"
  },
  State_149196_Desc = {
    Text = "Kiểm tra｜Sau khi nhận sát thương cố định, đối tượng liên quan 1, nguồn gây sát thương:[Layer]"
  },
  State_149196_Name = {
    Text = "Kiểm tra đối tượng liên quan cố định 1"
  },
  State_149227_Desc = {
    Text = "Lá chắn sẽ không biến mất khi kết thúc lượt. Khi có lá chắn, Tăng Sát Thương Bùng Phát Cuồng Khí nhận vào 50%, giảm sát thương nhận từ thẻ lệnh 50%."
  },
  State_149227_Name = {
    Text = "Màn Tuyết Ẩn Tung"
  },
  State_149228_Desc = {
    Text = "Khi gây sát thương sẽ áp Chảy máu"
  },
  State_149228_Name = {
    Text = "Xuyên Máu"
  },
  State_149229_Desc = {
    Text = "Khi xuất hiện, mất 25% Sinh lực tối đa, chuyển hóa thành \"Khiên Băng\" bằng [DescArg1]% lượng đã mất."
  },
  State_149229_Name = {
    Text = "Chuyển hóa Khiên Băng"
  },
  State_149230_Desc = {
    Text = "Tăng Sát Thương nhận từ thẻ lệnh 50%, giảm sát thương Bùng nổ nhận vào 50%."
  },
  State_149230_Name = {
    Text = "Trạng thái@Tăng Giảm Sát Thương Áo Khoác Tối Tăm"
  },
  State_149232_Desc = {
    Text = "Lá chắn sẽ không biến mất khi kết thúc lượt. Khi có lá chắn, Tăng Sát Thương nhận từ thẻ lệnh 50%, giảm sát thương Bùng nổ nhận vào 50%."
  },
  State_149232_Name = {
    Text = "Bóng Tối Ẩn Tung"
  },
  State_149233_Desc = {
    Text = "Tăng Sát Thương Bùng Phát Cuồng Khí nhận vào 50%, giảm sát thương nhận từ thẻ lệnh 50%."
  },
  State_149233_Name = {
    Text = "Trạng thái@Tăng Giảm Sát Thương Áo Khoác Màu Tuyết"
  },
  State_149234_Desc = {
    Text = "Khi xuất trận mất 25% Sinh lực tối đa, chuyển hóa thành \"Khiên Nguyền\" bằng [DescArg1]% lượng đã mất."
  },
  State_149234_Name = {
    Text = "Chuyển Hóa Khiên Nguyền"
  },
  State_149235_Desc = {
    Text = "Khi gây sát thương không bị chặn, xóa kháng cự tử vong"
  },
  State_149235_Name = {
    Text = "Phù Thuật Đèn Lồng"
  },
  State_149250_Desc = {
    Text = "Sát thương thẻ lệnh nhận vào +50%"
  },
  State_149250_Name = {
    Text = "Sát thương thẻ lệnh nhận vào +50%"
  },
  State_149251_Desc = {
    Text = "Sát thương thẻ lệnh nhận vào -50%"
  },
  State_149251_Name = {
    Text = "Sát thương thẻ lệnh nhận vào -50%"
  },
  State_149252_Desc = {
    Text = "Sát thương Bùng nổ nhận vào -50%"
  },
  State_149252_Name = {
    Text = "Sát thương Bùng nổ nhận vào -50%"
  },
  State_149253_Desc = {
    Text = "Sát thương Bùng nổ nhận vào +50%"
  },
  State_149253_Name = {
    Text = "Sát thương Bùng nổ nhận vào +50%"
  },
  State_149265_Desc = {
    Text = "Sau khi chết lập tức gọi một \"Wendigo\" ngẫu nhiên, giảm \"Hiệu ứng tập trung\" của nó đi 1 tầng."
  },
  State_149265_Name = {
    Text = "Hiệu ứng tập trung"
  },
  State_149268_Desc = {
    Text = "Khi mất toàn bộ lá chắn, nhận 75 lớp Gia cố tạm thời và xóa 1 lớp \"Chìm Vào Tuyết Gió\", thay thế ý định bằng đòn tấn công mạnh sẽ áp <BoneHitKeywords:Scathe>."
  },
  State_149268_Name = {
    Text = "Chìm Vào Tuyết Gió"
  },
  State_149269_Desc = {
    Text = "Khi mất toàn bộ lá chắn, nhận 75 lớp Gia cố tạm thời và xóa 1 lớp \"Chìm Vào Bóng Tối\", thay thế ý định bằng đòn tấn công mạnh sẽ đoạt điên cuồng."
  },
  State_149269_Name = {
    Text = "Chìm Vào Bóng Tối"
  },
  State_149270_Desc = {
    Text = "Sau khi chết lập tức gọi một \"Wendigo\" ngẫu nhiên, giảm \"Hiệu ứng tập trung\" của nó đi 1 tầng."
  },
  State_149270_Name = {
    Text = "Hiệu ứng tập trung"
  },
  State_149308_Name = {
    Text = "Trạng thái@Ghi lại số lớp Trì trệ của Người Cầu Nguyện Đèn Lồng"
  },
  State_149391_Desc = {
    Text = "Thể thức tỉnh này chưa thức tỉnh… khi sắp bị đánh ngã sẽ hồi phục sinh lực và nhận 1 lớp <InvincibleUntilRoused:Lõi Bạc Cứng Hóa>, sau khi thức tỉnh sẽ xóa <InvincibleUntilRoused:Lõi Bạc Cứng Hóa> và bắt đầu chiến đấu ở hình thái thực sự."
  },
  State_149391_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_149398_Desc = {
    Text = "Khi ý định của \"Tiên Bạch Tuyết\" chuyển sang \"Phấn Tiên Tuyết Thuật\", tiêu thụ 1 lớp, biến đổi ý định thành \"Phép Màu Tiên Nữ\"."
  },
  State_149398_Name = {Text = "No Nê"},
  State_149399_Desc = {
    Text = "Sau khi \"Tiên Bạch Tuyết\" tung ra \"Cổ Tích Kì Ảo Hoàn Hảo\", [DescArg1] ý định tiếp theo đều là \"Phấn Tiên Tuyết Thuật\". Mỗi lượt Xáo trộn [DescArg2] thẻ <SlowIconKeywords:Trì trệ> [DescArg3] lớp ngẫu nhiên <Blessing:Phép Màu> vào bộ bài."
  },
  State_149399_Name = {
    Text = "Quả Ngọt Mê Hoặc"
  },
  State_149418_Desc = {
    Text = "Không thể đòn đánh chí mạng, không được coi là sát thương cơ bản, và không bị ảnh hưởng bởi các hiệu ứng tăng sát thương cuối cùng."
  },
  State_149418_Name = {
    Text = "<RealDamage:thương cố định>"
  },
  State_149419_Name = {
    Text = "<Rune_6:bức tường thép>"
  },
  State_149420_Name = {
    Text = "<Rune_3:điêu luyện>"
  },
  State_149421_Name = {
    Text = "<Rune_15:nổ>"
  },
  State_149422_Name = {
    Text = "<Rune_4:toán>"
  },
  State_149423_Name = {
    Text = "<Rune_11:thống trị>"
  },
  State_149424_Name = {
    Text = "<Rune_12:khát máu>"
  },
  State_149425_Name = {
    Text = "<Rune_1:tăng sát thương>"
  },
  State_149426_Name = {
    Text = "<Rune_14:sức mạnh>"
  },
  State_149427_Name = {
    Text = "<Rune_2:yếu đuối>"
  },
  State_149428_Name = {
    Text = "<Rune_9:gai>"
  },
  State_149429_Name = {
    Text = "<Rune_10:độc tố>"
  },
  State_149430_Name = {
    Text = "<Rune_18:suy_kiệt>"
  },
  State_149576_Desc = {
    Text = "Khi ý định của \"Tiên Bạch Tuyết\" chuyển sang \"Phấn Tiên Tuyết Thuật\", tiêu thụ 1 lớp, biến đổi ý định thành \"Phép Màu Tiên Nữ\"."
  },
  State_149576_Name = {Text = "No Nê"},
  State_149618_Desc = {
    Text = "Sau 2 lượt, kích hoạt các hiệu ứng sau:\nNhận [DescArg1] điểm Điểm tính toán. \nNhận [DescArg2] điểm sức mạnh. \nNhận [DescArg3] điểm Năng lượng chìa khóa bạc. \nNhận [DescArg5] điểm điên cuồng. \nRút [DescArg6] lá bài.\nNhận [DescArg7] điểm Khuếch đại sát thương tạm thời.\nLàm tất cả kẻ thù tạm thời giảm [DescArg4] điểm sức mạnh."
  },
  State_149618_Name = {
    Text = "Lỡ Thời Cơ 2"
  },
  State_149619_Desc = {
    Text = "Sau 1 lượt, kích hoạt các hiệu ứng sau:\nNhận [DescArg1] điểm Điểm tính toán. \nNhận [DescArg2] điểm sức mạnh. \nNhận [DescArg3] điểm Năng lượng chìa khóa bạc. \nNhận [DescArg5] điểm điên cuồng. \nRút [DescArg6] lá bài.\nNhận [DescArg7] điểm Khuếch đại sát thương tạm thời.\nLàm tất cả kẻ thù tạm thời giảm [DescArg4] điểm sức mạnh."
  },
  State_149619_Name = {
    Text = "Lỡ Thời Cơ 1"
  },
  State_149628_Desc = {
    Text = "Nếu trước khi kết thúc lượt, kẻ địch có ít nhất 1000 Năng lượng chìa khóa bạc, Nuốt chửng 1000 Năng lượng chìa khóa bạc."
  },
  State_149628_Name = {
    Text = "Cúng Tế Năng lượng chìa khóa bạc"
  },
  State_149629_Desc = {
    Text = "Nếu trước khi kết thúc lượt, Thể thức tỉnh có điên cuồng cao nhất sở hữu ít nhất 100 điểm điên cuồng, Nuốt chửng 50 điểm điên cuồng của nó."
  },
  State_149629_Name = {
    Text = "Cúng Tế Điên Cuồng"
  },
  State_149630_Desc = {
    Text = "Nếu trước khi kết thúc lượt, kẻ địch có ít nhất 1000 Năng lượng chìa khóa bạc, Nuốt chửng 1000 Năng lượng chìa khóa bạc."
  },
  State_149630_Name = {
    Text = "Cúng Tế Năng lượng chìa khóa bạc"
  },
  State_149631_Desc = {
    Text = "Nếu trước khi kết thúc lượt, kẻ địch có ít nhất 3 Điểm tính toán, Nuốt chửng 3 Điểm tính toán."
  },
  State_149631_Name = {
    Text = "Cúng Tế Điểm tính toán"
  },
  State_149632_Desc = {
    Text = "Nếu trước khi kết thúc lượt, kẻ địch có ít nhất 3 Điểm tính toán, Nuốt chửng 3 Điểm tính toán."
  },
  State_149632_Name = {
    Text = "Cúng Tế Điểm tính toán"
  },
  State_149633_Desc = {
    Text = "Nếu trước giai đoạn bỏ bài, Tay của kẻ địch còn ít nhất 4 thẻ lệnh, Nuốt chửng ngẫu nhiên 2 thẻ lệnh."
  },
  State_149633_Name = {
    Text = "Cúng Tế Thẻ bài"
  },
  State_149634_Desc = {
    Text = "Nếu trước giai đoạn bỏ bài, Tay của kẻ địch còn ít nhất 4 thẻ lệnh, Nuốt chửng ngẫu nhiên 2 thẻ lệnh."
  },
  State_149634_Name = {
    Text = "Cúng Tế Thẻ bài"
  },
  State_149635_Desc = {
    Text = "Nếu trước khi kết thúc lượt, Thể thức tỉnh có điên cuồng cao nhất sở hữu ít nhất 100 điểm điên cuồng, Nuốt chửng 50 điểm điên cuồng của nó."
  },
  State_149635_Name = {
    Text = "Cúng Tế Điên Cuồng"
  },
  State_149652_Desc = {
    Text = "Không thể Đòn đánh chí mạng, không được tính là sát thương gây ra bởi Thể thức tỉnh tương ứng."
  },
  State_149652_Name = {
    Text = "<FixedDamage:Sát Thương Thuần Túy>"
  },
  State_149660_Desc = {
    Text = "Tăng Sát Thương, lá chắn, thay đổi sức mạnh do thẻ bài này gây ra tăng [DescArg2]%, thương tổn xúc tu, hồi phục Sinh lực, ngộ độc cố định, phản công cố định hiệu ứng cuối cùng tăng [DescArg1]%, sau khi chơi sẽ bị xóa bỏ."
  },
  State_149660_Name = {
    Text = "Tăng cường [DescArg1]"
  },
  State_149664_Desc = {
    Text = "Mỗi lớp sở hữu làm Tăng Sát Thương, sức mạnh cố định và thương tổn xúc tu tăng, ngộ độc cố định, phản công cố định hiệu ứng cuối cùng tăng 2%; lá chắn cố định, hồi phục Sinh lực cố định, sức mạnh giảm xuống hiệu ứng cuối cùng tăng 1%, sau khi chơi sẽ bị xóa bỏ."
  },
  State_149664_Name = {
    Text = "tăng cường"
  },
  State_149719_Name = {
    Text = "Miễn dịch Sát Thương Thuần Túy PVP__\"Chỉ dùng để phát triển\""
  },
  State_149736_Desc = {
    Text = "[Layer] thẻ lệnh <AwakerName:[DescArg1]> tiếp theo có Khiên cơ bản tăng [StateArg1]%."
  },
  State_149736_Name = {
    Text = "Lời Ngon Quả Ngọt"
  },
  State_149744_Desc = {
    Text = "[Layer] thẻ Phép Màu được chơi tiếp theo sẽ không kích hoạt hiệu ứng tiêu cực"
  },
  State_149744_Name = {
    Text = "Tiên Nữ Phù Hộ"
  },
  State_149772_Desc = {
    Text = "Mỗi lần nhận sát thương chủ động sẽ khiến tất cả Thể thức tỉnh mất 3 điên cuồng, mỗi lượt tối đa có hiệu lực 5 lần. Sau khi phá vỡ lá chắn sẽ xóa trạng thái \"Khiên Nguyền\"."
  },
  State_149772_Name = {
    Text = "Khiên Nguyền"
  },
  State_149773_Desc = {
    Text = "Mỗi lần nhận sát thương chủ động sẽ gây 1 lớp Trì trệ tạm thời cho thẻ bài ngẫu nhiên trong tay, mỗi lượt tối đa có hiệu lực 5 lần. Sau khi phá vỡ lá chắn sẽ xóa trạng thái \"Khiên Băng\"."
  },
  State_149773_Name = {
    Text = "Khiên băng giá"
  },
  State_149782_Desc = {
    Text = "Tiêu thụ: Sau khi rút bài lượt tiếp theo, Xáo trộn 1 \"Quả Vạn Hóa\" vào rút bài từ bộ bài."
  },
  State_149782_Name = {
    Text = "Quả Vạn Hóa"
  },
  State_149787_Desc = {
    Text = "Mỗi lớp sở hữu, Sát thương cuối cùng của thẻ lệnh của Orci·Thệ Nguyền tăng [DescArg2]%, số lá bài rút khi bắt đầu lượt -1, Sát thương chí mạng tăng [DescArg3]%, giới hạn [DescArg1] lớp, không xóa khi kết thúc chiến đấu."
  },
  State_149787_Name = {
    Text = "<KuangNu:Ám Dũng>"
  },
  State_149788_Desc = {
    Text = "Khi chơi \"Kỹ năng\" của Phụ Thệ·Orci, tiêu thụ 1 lớp để Rút 1 thẻ \"phòng thủ\", nhận Giữ lại trước lần chơi tiếp theo, giới hạn [DescArg1] lớp, không xóa khi kết thúc chiến đấu."
  },
  State_149788_Name = {
    Text = "<ShuZui:Tự Tội>"
  },
  State_149789_Desc = {
    Text = "Mỗi lớp sở hữu, Sát thương cuối cùng của thẻ lệnh của Orci·Thệ Nguyền tăng 33%, số lá bài rút khi bắt đầu lượt -1, giới hạn [DescArg1] lớp, không xóa khi kết thúc chiến đấu."
  },
  State_149789_Name = {
    Text = "<KuangNu:Ám Dũng>"
  },
  State_149790_Desc = {
    Text = "Mỗi lớp sở hữu, Sát thương cuối cùng của thẻ lệnh của Orci·Thệ Nguyền tăng [DescArg2]%, số lá bài rút khi bắt đầu lượt -1, giới hạn [DescArg1] lớp, không xóa khi kết thúc chiến đấu."
  },
  State_149790_Name = {
    Text = "<KuangNu:Ám Dũng>"
  },
  State_149791_Desc = {
    Text = "Khi chơi \"Kỹ năng\" của Phụ Thệ·Orci, tiêu thụ 1 lớp để Rút 1 thẻ \"phòng thủ\", nhận Giữ lại trước lần chơi tiếp theo, giới hạn [DescArg1] lớp, không xóa khi kết thúc chiến đấu."
  },
  State_149791_Name = {
    Text = "<ShuZui:Tự Tội>"
  },
  State_149814_Desc = {
    Text = "Khuếch đại sát thương tạm thời +[Layer]%."
  },
  State_149814_Name = {
    Text = "Khuếch đại sát thương tạm thời"
  },
  State_149819_Desc = {
    Text = "Miễn dịch với mọi sát thương"
  },
  State_149819_Name = {
    Text = "Miễn dịch"
  },
  State_149892_Desc = {
    Text = "[Layer] thẻ lệnh <AwakerName:[DescArg1]> tiếp theo có Khiên cơ bản tăng [StateArg1]%."
  },
  State_149892_Name = {
    Text = "Chân Lý Thanh Yên"
  },
  State_149913_Name = {
    Text = "Trạng thái@Hiệu ứng bảo vật sâu đại thực_tinkerer hư hỏng"
  },
  State_149914_Name = {
    Text = "Trạng thái@Hiệu Ứng Bảo Vật Giun Thực Bào_William Hư Hỏng"
  },
  State_149915_Name = {
    Text = "Trạng thái@Hiệu Ứng Bảo Vật Giun Thực Bào_William"
  },
  State_149916_Name = {
    Text = "Trạng thái@Hiệu Ứng Bảo Vật Giun Thực Bào_Cas-tơ-lơ Hư Hỏng"
  },
  State_149917_Name = {
    Text = "Trạng thái@Hiệu ứng bảo vật sâu đại thực_Dây máu Hiro hư hỏng"
  },
  State_149918_Name = {
    Text = "Trạng thái@Kiểm tra đầu lượt sâu đại thực"
  },
  State_149919_Name = {
    Text = "Trạng thái@Hiệu ứng bảo vật sâu đại thực_tinkerer"
  },
  State_149920_Name = {
    Text = "Trạng thái@Hiệu ứng bảo vật sâu đại thực_Arachne"
  },
  State_149921_Name = {
    Text = "Trạng thái@Hiệu ứng bảo vật sâu đại thực_Arachne hư hỏng"
  },
  State_149922_Name = {
    Text = "Trạng thái@Hiệu Ứng Bảo Vật Giun Thực Bào_Cas-tơ-lơ"
  },
  State_149923_Name = {
    Text = "Trạng thái@Hiệu ứng bảo vật sâu đại thực_Dây máu Hiro"
  },
  State_149930_Desc = {
    Text = "Mỗi lớp sở hữu, Sát thương cuối cùng của thẻ lệnh Phụ Thệ·Orci tăng 50%, số thẻ rút đầu lượt -1, giới hạn [DescArg1] lớp, không xóa khi kết thúc chiến đấu."
  },
  State_149930_Name = {
    Text = "<KuangNu2:Dòng Chảy Ngầm>"
  },
  State_149931_Desc = {
    Text = "Có tất cả 7 loại hiệu ứng, bao gồm: nhận sức mạnh, Rút thẻ bài, nhận Điểm tính toán, nhận Năng lượng chìa khóa bạc, tạm thời tăng Khuếch đại sát thương, tất cả Thể thức tỉnh nhận điên cuồng, tạm thời giảm sức mạnh của tất cả kẻ thù."
  },
  State_149931_Name = {
    Text = "<Blessing:Quà Tặng>"
  },
  State_149933_Name = {
    Text = "Trạng thái@Bong Bóng Lễ Vật Quái Vật Caraboo"
  },
  State_149934_Name = {
    Text = "Trạng thái@Bong Bóng Lễ Vật Quái Vật Caraboo"
  },
  State_149939_Desc = {
    Text = "Không thể nhận lá chắn cho đến khi kết thúc lượt."
  },
  State_149939_Name = {
    Text = "Ràng Buộc Thân Thể"
  },
  State_19507_Desc = {
    Text = "Sát thương từ các đòn tấn công chủ động và số lớp chảy máu phải chịu trước khi bắt đầu lượt tiếp theo tăng 25%, khi áp dụng sẽ bị triệt tiêu khi kết hợp với củng cố."
  },
  State_19507_Name = {
    Text = "<PVPVulnerabilityIconColour:tăng sát thương>"
  },
  State_19508_Desc = {
    Text = "Cuối lượt, loại bỏ lá bài này."
  },
  State_19508_Name = {
    Text = "<PVPVoidKeyColour:Hư vô>"
  },
  State_19509_Desc = {
    Text = "Thay đổi tạm thời sức tính toán của thẻ bài.__\"Chỉ dùng cho phát triển\""
  },
  State_19509_Name = {
    Text = "Thay đổi vĩnh viễn sức tính toán của thẻ bài__\"Chỉ dùng cho phát triển\""
  },
  State_19511_Desc = {
    Text = "Sau khi chết, thay các lá bài trên tay bằng ảo ảnh__\"Chỉ dùng phát triển\""
  },
  State_19511_Name = {
    Text = "Thay thế tay bài chết bằng bộ kích hoạt ảo ảnh__\"Chỉ dùng phát triển\""
  },
  State_19513_Name = {
    Text = "Áp dụng đấu tử thần__\"Chỉ dùng cho phát triển\""
  },
  State_19516_Name = {
    Text = "Thay đổi tạm thời sức tính toán của thẻ bài__\"Chỉ dùng cho phát triển\""
  },
  State_19517_Desc = {
    Text = "Mỗi khi mất 2% sinh lực, nhận được 1 điểm điên cuồng__\"Chỉ dùng phát triển\""
  },
  State_19517_Name = {
    Text = "Nhận được Điên cuồng khi nhận thương__\"Chỉ dùng phát triển\""
  },
  State_19519_Desc = {
    Text = "Sử dụng \"Đánh\" sẽ tiêu thụ tất cả số lớp, mỗi lớp làm tăng 50% sát thương của lần \"Đánh\" này, tối đa có thể tích lũy 5 lớp.(Hiện tại tăng tổng cộng [DescArg1]%)"
  },
  State_19519_Name = {Text = "Súc tích"},
  State_19521_Desc = {
    Text = "Mỗi tầng tăng tất cả sát thương gây ra trong toàn bộ trận chiến này thêm 1 điểm, không thể xóa bỏ."
  },
  State_19521_Name = {
    Text = "<PowerColourKeywords:lực lượng>"
  },
  State_19522_Name = {
    Text = "Thay đổi tạm thời sức tính toán của thẻ bài__\"Chỉ dùng cho phát triển\""
  },
  State_19523_Name = {
    Text = "Thay đổi vĩnh viễn sức tính toán của thẻ bài__\"Chỉ dùng cho phát triển\""
  },
  State_19524_Desc = {
    Text = "Trước khi bắt đầu lượt tiếp theo, mỗi lần bị tấn công sẽ gây [Layer] điểm Sát Thương Thuần Túy cho kẻ tấn công."
  },
  State_19524_Name = {
    Text = "phản công"
  },
  State_19525_Desc = {
    Text = "Loại bỏ lá chắn của thể thức tỉnh trước khi bắt đầu lượt__\"Chỉ dùng cho phát triển\""
  },
  State_19525_Name = {
    Text = "Xóa bỏ khiên nhân vật trước khi lượt bắt đầu__\"Chỉ dùng cho phát triển\""
  },
  State_19527_Desc = {
    Text = "Mỗi lớp làm tăng Giá trị Điểm tính toán của \"kỹ năng\" trong lượt này +1, tối đa 3 lớp, sau khi chơi nếu số lớp lớn hơn 1 thì số lớp -1."
  },
  State_19527_Name = {
    Text = "<SlowColour:chậm trễ>"
  },
  State_19528_Desc = {
    Text = "Thẻ bài với hiệu ứng mạnh mẽ và đáng chú ý."
  },
  State_19528_Name = {
    Text = "<SilverKeyColour:lệnh khóa>"
  },
  State_19529_Desc = {
    Text = "Có thể chơi [Layer] lần, mỗi lần chơi thẻ bài khác sẽ giảm Giá trị Điểm tính toán của lần chơi tiếp theo của thẻ này -1."
  },
  State_19529_Name = {
    Text = "<CardKeyWord:Ảo ảnh [Layer]>"
  },
  State_19530_Desc = {
    Text = "·Bị kẻ thù tấn công ưu tiên, và khi kẻ thù chọn mục tiêu đơn lẻ chỉ có thể chọn người đánh thức khiêu khích.\n·Khi nhận được khiêu khích sẽ gỡ bỏ ẩn nấp của bản thân và khiêu khích của các đồng minh khác, đồng thời xua tan ẩn nấp của kẻ thù."
  },
  State_19530_Name = {
    Text = "<TauntColour:khiêu khích>"
  },
  State_19532_Desc = {
    Text = "Trước khi kết thúc lượt này, thương gây ra giảm [DescArg1]%, áp dụng sẽ triệt tiêu tăng cường."
  },
  State_19532_Name = {
    Text = "Suy nhược"
  },
  State_19533_Desc = {
    Text = "Trước khi lượt này kết thúc, thương sẽ giảm 50%, ngay khi áp dụng sẽ triệt tiêu hiệu ứng tăng cường."
  },
  State_19533_Name = {
    Text = "<WeaknessColour:yếu đuối>"
  },
  State_19534_Desc = {
    Text = "Sát thương nhận từ tấn công chủ động và số lớp chảy máu trước khi bắt đầu lượt tiếp theo tăng [DescArg1]%, được triệt tiêu khi áp dụng cùng với củng cố."
  },
  State_19534_Name = {
    Text = "Trọng thương"
  },
  State_19535_Desc = {
    Text = "·Bị kẻ thù tấn công ưu tiên, và khi kẻ thù chọn mục tiêu đơn lẻ chỉ có thể chọn người đánh thức khiêu khích.\n·Khi nhận được khiêu khích sẽ gỡ bỏ ẩn nấp của bản thân và khiêu khích của các đồng minh khác, đồng thời xua tan ẩn nấp của kẻ thù."
  },
  State_19535_Name = {
    Text = "Chế nhạo"
  },
  State_19536_Desc = {
    Text = "Khi kết thúc lượt nhận được 10 điểm điên cuồng__\"Chỉ dùng cho phát triển\""
  },
  State_19536_Name = {
    Text = "Nhận được bộ kích hoạt điên cuồng khi kết thúc lượt__\"Chỉ dùng cho phát triển\""
  },
  State_19537_Desc = {
    Text = "Tăng [DescArg1]% thương gây ra trước khi kết thúc lượt này, khi áp dụng sẽ triệt tiêu trạng thái yếu đuối."
  },
  State_19537_Name = {
    Text = "tăng cường"
  },
  State_19538_Desc = {
    Text = "·Nhận 1 lớp vào đầu lượt 8 và 9\n·Mỗi lớp Deathmatch sẽ giảm 50% lá chắn và hồi phục sinh lực đồng thời giảm số lớp có thể chồng của rào cản đi 1\n·Deathmatch không thể bị xua tan và cũng có hiệu lực đối với các thể thức tỉnh đã chết."
  },
  State_19538_Name = {Text = "Deathmatch"},
  State_19540_Name = {
    Text = "Giới hạn Điểm tính toán"
  },
  State_19541_Desc = {
    Text = "Không thể thực hiện bất kỳ hành động nào trước khi kết thúc lượt."
  },
  State_19541_Name = {Text = "Hôn mê"},
  State_19544_Desc = {
    Text = "Sử dụng \"Đánh\" sẽ tiêu thụ toàn bộ số lớp, mỗi lớp tiêu thụ làm tăng sát thương gây ra bởi \"Đánh\" lên 50%, tối đa có thể chồng 5 lớp."
  },
  State_19544_Name = {
    Text = "<EnergyStorageColour:tích lực>"
  },
  State_19545_Name = {
    Text = "Thẻ này được coi là \"Đánh\"__\"Chỉ dùng cho phát triển\""
  },
  State_19546_Desc = {
    Text = "Trước khi chơi, thay đổi Điểm tính toán thẻ bài.__\"Chỉ dùng cho phát triển\""
  },
  State_19546_Name = {
    Text = "Trước khi đánh ra, thay đổi chỉ số thẻ__\"Chỉ dùng cho phát triển\""
  },
  State_19547_Desc = {
    Text = "Khi kết thúc lượt, nhận [Layer] điểm Sát Thương Thuần Túy, hiệu ứng vĩnh viễn."
  },
  State_19547_Name = {
    Text = "Ngộ độc"
  },
  State_19549_Desc = {
    Text = "Sát thương từ các cuộc tấn công chủ động phải chịu trước khi bắt đầu lượt tiếp theo giảm 50%, hiệu ứng tăng sát thương bị vô hiệu hóa khi áp dụng."
  },
  State_19549_Name = {
    Text = "<ReinforceColour:củng cố>"
  },
  State_19552_Desc = {
    Text = "Hiện có [Layer] điểm lá chắn, lá chắn không vượt quá máu tối đa, trong 1 lượt."
  },
  State_19552_Name = {Text = "lá chắn"},
  State_19553_Desc = {
    Text = "Sau giai đoạn rút bài, nhận Hậu phát chế nhân__\"Chỉ dùng phát triển\""
  },
  State_19553_Name = {
    Text = "Hậu phát chế nhân kích hoạt__\"Chỉ dùng phát triển\""
  },
  State_19554_Name = {
    Text = "Trạng thái trống__\"Chỉ dùng phát triển\""
  },
  State_19555_Desc = {
    Text = "·Giá trị Điểm tính toán của \"kỹ năng\" trong lượt này +[Layer], tối đa 3 lớp.\n·Sau khi chơi \"kỹ năng\" nếu số lớp lớn hơn 1, số lớp -1."
  },
  State_19555_Name = {Text = "Trì trệ"},
  State_19556_Desc = {
    Text = "Vào cuối lượt, sức tính toán tiêu thụ của lá bài này -[Layer]."
  },
  State_19556_Name = {
    Text = "<PrepareKeywords:Sẵn sàng [Layer] >"
  },
  State_19557_Desc = {
    Text = "Thương từ các cuộc tấn công chủ động phải chịu trước khi bắt đầu lượt tiếp theo giảm [DescArg1]%, áp dụng và loại bỏ tăng sát thương."
  },
  State_19557_Name = {Text = "Gia cố"},
  State_19558_Name = {
    Text = "Bộ gợi ý thêm bài phục sinh__\"Chỉ dùng phát triển\""
  },
  State_19560_Desc = {
    Text = "Không thể sử dụng cơn thịnh nộ bùng phát trước khi lượt kết thúc."
  },
  State_19560_Name = {Text = "Phong ấn"},
  State_19561_Name = {
    Text = "Có thể sử dụng 3 lần"
  },
  State_19990_Desc = {
    Text = "Vào đầu lượt tiếp theo, nhận được [Layer] cuồng nộ."
  },
  State_19990_Name = {
    Text = "Điên cuồng trễ"
  },
  State_19992_Desc = {
    Text = "Không thể thực hiện bất kỳ hành động nào trước khi kết thúc lượt. Khi bị sát thương hôn mê, mục tiêu sẽ nhận được sức chống cự. Khi có sức chống cự, nếu bị sát thương hôn mê lần nữa, hiệu ứng hôn mê sẽ bị vô hiệu hóa và sát thương sẽ tăng gấp đôi. Trạng thái này không thể bị loại bỏ."
  },
  State_19992_Name = {
    Text = "<ComaColour:mất ý thức>"
  },
  State_19995_Desc = {
    Text = "Khi kết thúc lượt, gây Sát Thương Thuần Túy tương đương với số lớp, vĩnh viễn."
  },
  State_19995_Name = {
    Text = "<IntoxicationColour:trúng độc>"
  },
  State_19996_Desc = {
    Text = "Trong lượt này, thương gây ra tăng 25% và hiệu ứng yếu đuối sẽ bị hủy bỏ khi kích hoạt."
  },
  State_19996_Name = {
    Text = "<StrengthenColour:tăng cường>"
  },
  State_19998_Desc = {
    Text = "Trước khi bắt đầu lượt tiếp theo, mỗi lần bị tấn công sẽ gây Sát Thương Thuần Túy tương đương số lớp lên kẻ tấn công."
  },
  State_19998_Name = {
    Text = "<RetaliateColour:phản công>"
  },
  State_20012_Desc = {
    Text = "Mỗi điểm sức tính toán còn lại khiến bạn rút 1 lá bài vào đầu lượt tiếp theo; mỗi lá bài còn lại trong tay khiến bạn nhận được 1 sức tính toán vào đầu lượt tiếp theo."
  },
  State_20012_Name = {
    Text = "Đoạn gãy của tiên phong dị hóa"
  },
  State_20012_WeaponDesc = {
    Text = "Mỗi điểm sức tính toán còn lại khiến bạn rút 1 lá bài vào đầu lượt tiếp theo; mỗi lá bài còn lại trong tay khiến bạn nhận được 1 sức tính toán vào đầu lượt tiếp theo."
  },
  State_20013_Desc = {
    Text = "<ProficientInRealmsIconKeywords:giới vực thông thạo> tăng 100. Đưa lá bài đầu tiên đánh ra mỗi lượt trở lại tay. Khi bắt đầu lượt siêu việt, giới hạn số lá bài trong tay +5 và sao chép các lá bài trong tay."
  },
  State_20013_Name = {
    Text = "Trạng thái @ bàn lắc thời linh kính"
  },
  State_20014_Name = {
    Text = "Linh bài thời gian \"Lạc lối\""
  },
  State_20016_Name = {
    Text = "Găng tay thuật sáng tạo"
  },
  State_20017_Desc = {
    Text = "Lần nhảy vọt tiếp theo chắc chắn sẽ kích hoạt hiệu ứng."
  },
  State_20017_Name = {
    Text = "Bước nhảy"
  },
  State_20021_Desc = {
    Text = "<ProficientInRealmsIconKeywords:giới vực thông thạo> tăng 100. Đưa lá bài đầu tiên đánh ra mỗi lượt trở lại tay. Khi bắt đầu lượt siêu việt, giới hạn số lá bài trong tay +5 và sao chép các lá bài trong tay."
  },
  State_20021_Name = {
    Text = "Trạng thái @ bàn lắc thời linh kính"
  },
  State_20023_Desc = {
    Text = "Sau khi chiến đấu bắt đầu, đưa hai lá bài Điên Cuồng vào bộ bài."
  },
  State_20023_Name = {
    Text = "Hỗn loạn ghép nối"
  },
  State_20023_WeaponDesc = {
    Text = "Sau khi chiến đấu bắt đầu, đưa hai lá bài Điên Cuồng vào bộ bài."
  },
  State_20024_Desc = {
    Text = "Mỗi lần kích hoạt cơn thịnh nộ bùng phát, nhận được một lá có thể gây [Arg1] điểm trúng độc mang tên \"Độc Tính Xâm Nhập\". Cuối lượt, nếu trong tay có đủ 3 lá \"Độc Tính Xâm Nhập\", có thể hợp thành một lá \"Độc Tính Phát Tác\" gây trúng độc."
  },
  State_20024_Name = {
    Text = "Trạng thái @sáng tạo dị chủng bị biến đổi"
  },
  State_20026_Desc = {
    Text = "Thẻ không vào chồng bài bỏ trong giai đoạn bỏ bài mà được giữ lại trong tay và kích hoạt hiệu ứng tiếp theo."
  },
  State_20026_Name = {
    Text = "<RetainIconKeywords:giữ lại>"
  },
  State_20026_WeaponDesc = {
    Text = "Sau khi đánh, thẻ bài sẽ không vào rác bài và không thể sử dụng lại trong cuộc chiến đấu này."
  },
  State_20028_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Thông thạo giới vực> tăng 100. Mỗi lần sử dụng 1 lá bài, phôi hợp tử +10, khi sức sống dưới 25%, tăng lên 20. Mỗi lượt tối đa có hiệu lực 10 lần."
  },
  State_20028_Name = {
    Text = "Trạng thái @ bàn lắc thời linh xâm thực"
  },
  State_20029_Desc = {
    Text = "Mỗi lần kích hoạt cơn thịnh nộ bùng phát, nhận được một lá có thể gây [Arg1] điểm trúng độc mang tên \"Độc Tính Xâm Nhập\". Cuối lượt, nếu trong tay có đủ 3 lá \"Độc Tính Xâm Nhập\", có thể hợp thành một lá \"Độc Tính Phát Tác\" gây trúng độc."
  },
  State_20029_Name = {
    Text = "Trạng thái @sáng tạo dị chủng bị biến đổi"
  },
  State_20035_Name = {
    Text = "Trạng thái @ bàn lắc thời linh thức giấc"
  },
  State_20038_Name = {
    Text = "Symbiote hỗn loạn"
  },
  State_20038_WeaponDesc = {
    Text = "Khi đội hình gồm hỗn loạn và các nghề khác, tất cả thân thể được đánh thức nhận 20 sức mạnh điên cuồng vào đầu lượt."
  },
  State_20039_Desc = {
    Text = "Nếu vẫn còn trên tay trong giai đoạn bỏ bài, thẻ bài sẽ bị tiêu thụ và không xuất hiện lại trong cuộc chiến đấu này."
  },
  State_20039_Name = {
    Text = "<NothingnessIconKeywords: hư vô>"
  },
  State_20039_WeaponDesc = {
    Text = "Sau khi đánh, thẻ bài sẽ không vào rác bài và không thể sử dụng lại trong cuộc chiến đấu này."
  },
  State_20040_Name = {
    Text = "Trạng thái @ bàn lắc thời linh số lần chưa ngủ"
  },
  State_20041_Desc = {
    Text = "Mỗi khi bắt đầu lượt, nhận 1 sức tính toán cho mỗi kẻ địch và rút 1 lá bài. Khi gây sát thương chủ động tiêu diệt kẻ địch, gây chảy máu bằng hai lần lượng thương vượt quá cho các kẻ địch khác."
  },
  State_20041_Name = {
    Text = "Bài ca của những kẻ bị tha hóa trong đám đông"
  },
  State_20042_Desc = {
    Text = "Thương gây ra cho kẻ địch trong trạng thái tiêu cực tăng 25%, sau khi giết kẻ địch, người giết nhận được 20 điên cuồng."
  },
  State_20044_Desc = {
    Text = "Tăng 10% hiệu ứng yếu đuối. Mỗi 3 hiệp, thêm 1 lớp yếu đuối cho tất cả kẻ địch."
  },
  State_20045_Desc = {
    Text = "Vào đầu lượt tiếp theo, tùy ý chọn 3 lá bài từ bộ bài và đưa vào tay."
  },
  State_20045_Name = {
    Text = "bàn lắc thời linh bay"
  },
  State_20306_Name = {
    Text = "Găng tay thuật sáng tạo"
  },
  State_20419_Desc = {
    Text = "Mỗi lần gây 1 điểm thương, sẽ áp dụng [Arg1] lớp trúng độc lên mục tiêu. Nếu số lần kích hoạt trong trận chiến này đạt 25 lần, khiến tất cả kẻ địch trúng độc ngay lập tức."
  },
  State_20425_Desc = {
    Text = "Vào đầu lượt, nhận [Layer] điểm <PowerIconKeywords:lực lượng tạm thời> và lá chắn."
  },
  State_20425_Name = {
    Text = "Quái vật khát máu"
  },
  State_20600_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>: Mỗi lượt, [StateArg2] lá\"kỹ năng\"đầu tiên tiêu tốn sức tính toán - [StateArg1]."
  },
  State_20600_Name = {Text = "Khai sáng"},
  State_20601_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>:\"đánh\" sát thương tăng [StateArg1]%. Mỗi lần bị tấn công, nhận được [StateArg2] lớp <EnergyStorageKeywords:chứa lực>."
  },
  State_20601_Name = {
    Text = "Bạo thực"
  },
  State_20602_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>:\"đánh\" có thể chọn mục tiêu và gây [StateArg1] tầng <PVPSlowKeywords:chậm>. Mỗi lượt, hiệu ứng tăng gấp đôi khi kích hoạt lần đầu trên mục tiêu đầu tiên."
  },
  State_20602_Name = {
    Text = "Tay Quên Lãng"
  },
  State_20603_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>:\"Bùng nổ\" sau đó giúp bản thân nhận được <Energy:[Energy:StateArg1]> điên cuồng."
  },
  State_20603_Name = {
    Text = "Sự phản đòn của cơ thể biến dạng"
  },
  State_20604_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>:\"đánh\" hồi phục bản thân <Heal:[Heal:StateArg1]> sức sống."
  },
  State_20604_Name = {Text = "Hút"},
  State_20605_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>: Khi trang bị <ComaKeywords:hôn mê> bản thân. Trước \"Bùng nổ cuồng khí\" xóa bỏ tất cả trạng thái tiêu cực của đồng minh."
  },
  State_20605_Name = {
    Text = "gậy của bá tước"
  },
  State_20606_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>, \"đánh\" khiến bản thân nhận được <Energy:[Energy:StateArg1]> điên cuồng."
  },
  State_20606_Name = {
    Text = "Điên cuồng"
  },
  State_20607_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>: \"Đánh\" tấn công kẻ địch có <HPAndShieldMax:Sinh lực và lá chắn cao nhất>, và gây thêm <PVPBleedingKeywords:Chảy máu> bằng [StateArg1]% thương."
  },
  State_20607_Name = {
    Text = "Vết cắt và Sẹo"
  },
  State_20608_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>:\"kỹ năng\" và khi kết thúc lượt, bản thân nhận được <Energy:[Energy:StateArg1]> điên cuồng."
  },
  State_20608_Name = {
    Text = "Thì thầm"
  },
  State_20609_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>: Gấp đôi sự điên cuồng do mất sức sống."
  },
  State_20609_Name = {
    Text = "Giấc mơ biển cả"
  },
  State_20610_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>: Sát thương chủ động của \"Đánh\" tăng lên [DescArg1]%, sau \"Bùng nổ\" khiến bản thân <PVPPowerIconKeywords:Sức mạnh> + [StateArg2] và Sát thương chủ động của \"Đánh\" tăng thêm [StateArg3]%, tối đa 100%."
  },
  State_20610_Name = {
    Text = "Thần thú nơi thiên đường"
  },
  State_20611_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>: \"kỹ năng\" và khi kết thúc lượt, hồi phục <Heal:[Heal:StateArg1]> sức sống cho đồng minh bị mất sức sống nhiều nhất."
  },
  State_20611_Name = {Text = "Hy vọng"},
  State_20612_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>:Cuối lượt, tặng đồng minh có điên cuồng thấp nhất <Energy:[Energy:StateArg1]> điên cuồng và hồi phục <Heal:[Heal:StateArg2]> sức sống cho đồng minh bị mất sức sống nhiều nhất."
  },
  State_20612_Name = {
    Text = "Từ bi dưỡng dục"
  },
  State_20613_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>: Cuối lượt, các đồng minh khác nhận được <Block:[Block:StateArg1]> lá chắn."
  },
  State_20613_Name = {
    Text = "Nơi không tồn tại"
  },
  State_20614_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>: khi hết lượt, nhận được tạm thời [StateArg1] <PVPRetaliateIconKeywords:phản công> ."
  },
  State_20614_Name = {
    Text = "Lõi tan vỡ"
  },
  State_20615_Desc = {
    Text = "<PVPWeaponKeywords:Bánh xe định mệnh>: Mỗi lượt \"Tấn công\"đầu tiên gây thêm [StateArg1] sát thương, <PVPMethysisKeywords:Độc dược>."
  },
  State_20615_Name = {
    Text = "Sợi dây nguyền rủa đắng cay"
  },
  State_20616_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>: Khi kết thúc lượt, nhận được <Energy:[Energy:StateArg1]> cuồng khí."
  },
  State_20616_Name = {
    Text = "Mùa xuân ở Acushnet"
  },
  State_20617_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>:Khi lượt kết thúc, nhận được <Block:[Block:StateArg1]> lá chắn."
  },
  State_20617_Name = {Text = "Lưu đày"},
  State_20618_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>: Trước khi \"Bùng nổ\", cả hai bên bỏ hết tất cả bài trên tay và rút số bài bằng số bài đã bỏ +1 lá."
  },
  State_20618_Name = {
    Text = "Buổi diễn ảo thuật vui vẻ"
  },
  State_20619_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>: Khi trang bị nhận được <Energy:[Energy:StateArg1]> điên cuồng. Khi đồng minh Thể thức tỉnh phát động \"Bùng nổ\", bản thân nhận được<DelayKeywords:Trì hoãn>: <Energy:[Energy:StateArg2]> điên cuồng."
  },
  State_20619_Name = {
    Text = "Ngợi ca Thần Vương"
  },
  State_20620_Desc = {
    Text = "<PVPWeaponKeywords:Bánh xe định mệnh>: Giới hạn lá thẻ + [StateArg2]. Cuối lượt, nhận được bản sao ngẫu nhiên của [StateArg1] lá \"Kỹ năng\" trong tay."
  },
  State_20620_Name = {
    Text = "Thời khắc gặp gỡ"
  },
  State_20621_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>: Trước khi \"Bùng nổ\", bản thân nhận được<StrengthenKeywords:tăng cường>và<ReinforceKeywords:Gia cố>."
  },
  State_20621_Name = {
    Text = "Vượt qua nỗi đau"
  },
  State_20622_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>: Khi kết thúc lượt, bản thân nhận được <Energy:[Energy:StateArg1]> điên cuồng, tiêu hao tất cả điểm tính toán còn lại, mỗi 1 điểm tính toán tiêu hao làm điên cuồng nhận được tăng [StateArg3]."
  },
  State_20622_Name = {
    Text = "Chào đời bí mật"
  },
  State_20623_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>:\"Bùng nổ\" rút [StateArg1] lá bài."
  },
  State_20623_Name = {
    Text = "Hiện diện"
  },
  State_20624_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>:「Bùng nổ」sau đó rút [StateArg1] lá「Kỹ năng」, đặt [StateArg2] lá sao chép vào tay."
  },
  State_20624_Name = {
    Text = "Thời khắc may mắn"
  },
  State_20625_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>:\"Bùng nổ\" sau đó<DelayKeywords:trì hoãn>: hồi phục toàn bộ đồng minh <Heal:[Heal:StateArg1]> sinh lực."
  },
  State_20625_Name = {
    Text = "Ngụ ngôn của kẻ tham ăn"
  },
  State_20626_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>:\"đánh\" sát thương tăng [StateArg1]%, và khiến bản thân nhận được <ReinforceKeywords:củng cố>."
  },
  State_20626_Name = {
    Text = "Ý chí bất khuất"
  },
  State_20627_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>: Cuối lượt, hồi phục <Heal:[Heal:StateArg1]> sức sống cho toàn bộ đồng minh."
  },
  State_20627_Name = {
    Text = "Phước lành"
  },
  State_20628_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>:\"Bùng nổ cuồng khí\" sau đó khiến đồng minh khác nhận được <Energy:[Energy:StateArg1]> điên cuồng, hiệu ứng điên cuồng dư thừa sẽ được hoàn lại một nửa cho Người trang bị."
  },
  State_20628_Name = {
    Text = "Trách nhiệm"
  },
  State_20629_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>: Sát thương, chữa trị và hiệu ứng lá chắn do \"Bùng nổ\" gây ra tăng [StateArg1]%."
  },
  State_20629_Name = {
    Text = "Nhân danh đóa hồng"
  },
  State_20630_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>:khi kết thúc lượt, nhận được <Block:[Block:StateArg1]> lá chắn và <Energy:[Energy:StateArg2]> cuồng nộ."
  },
  State_20630_Name = {
    Text = "Hồi ức đêm đông"
  },
  State_20631_Desc = {
    Text = "<PVPWeaponKeywords:Bánh xe định mệnh>:\"Đánh trúng\"<PVPVulnerabilityIconKeywords:Dễ tổn thương> mục tiêu. Khi trang bị và khi kết thúc lượt nhận được [StateArg1] lớp <EnergyStorageKeywords:Sức tích>."
  },
  State_20631_Name = {
    Text = "Điểm quan trọng"
  },
  State_20632_Desc = {
    Text = "<PVPWeaponKeywords: vòng mệnh>:giới hạn thẻ trên tay +[StateArg1]."
  },
  State_20632_Name = {
    Text = "Vòng xoáy ký ức"
  },
  State_20633_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>:Mỗi lượt lần đầu bị tấn công chủ động từ kẻ địch, gây [StateArg1] sát thương cho nó, <PVPEntanglementKeywords:Vướng víu>."
  },
  State_20633_Name = {
    Text = "Hậu duệ người da trắng"
  },
  State_20634_Desc = {
    Text = "<PVPWeaponKeywords:Bánh xe định mệnh>: Sát thương, chữa lành và khiên do “Đánh” “Kỹ năng” “Tôn kính” gây ra tăng [DescArg1]%, <PVPGrowthKeywords:Phát triển> [StateArg2]%."
  },
  State_20634_Name = {
    Text = "Mặt trời lặn"
  },
  State_20635_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>: \"cơn điên cuồng bùng nổ\" trước khi toàn bộ đồng đội nhận được <StrengthenKeywords:tăng cường>."
  },
  State_20635_Name = {
    Text = "sức mạnh thành tâm"
  },
  State_20636_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>: Khi kết thúc lượt, nhận được một lá <PVPDerivativeCardKeywords_2:「ảo ảnh」>. Mỗi khi trong tay có hai lá <PVPDerivativeCardKeywords_2:「ảo ảnh」> sẽ kết hợp chúng thành một lá <PVPDerivativeCardKeywords_12:「ước nguyện nhỏ nhỏ」>."
  },
  State_20636_Name = {Text = "Lão hóa"},
  State_20637_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>:Khi lượt kết thúc, thêm [StateArg1] lá bài <PVPDerivativeCardKeywords_11:「đổi chỗ không công bằng」> vào bộ bài rút."
  },
  State_20637_Name = {
    Text = "Dữ liệu cuộc sống"
  },
  State_20639_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>: Khi kết thúc lượt, Người trang bị gây [StateArg1] thương cho kẻ địch có <HPAndShieldMax:Sinh lực và lá chắn cao nhất>, <PVPMethysisKeywords:Ngộ độc>."
  },
  State_20639_Name = {
    Text = "Món quà suy tàn"
  },
  State_20640_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>:khi trang bị và khi bắt đầu lượt, gây <Damage:[Damage:StateArg1]> <PVPBleedingKeywords:chảy máu> sát thương lên tất cả kẻ địch, với mỗi lá bài trên tay tăng <PVPBleedingKeywords:chảy máu> sát thương +[StateArg2]."
  },
  State_20640_Name = {
    Text = "Yến tiệc đẫm máu"
  },
  State_20641_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>:sau khi chết, cấp cho các đồng minh khác [StateArg1] lớp <PVPProtectiveKeywords:rào cản>."
  },
  State_20641_Name = {
    Text = "Giải phẫu cái chết"
  },
  State_20642_Desc = {
    Text = "<PVPHoldingKeywords:Giữ>: Mỗi khi bạn đánh một thẻ bài, lá bài này sẽ biến thành một \"vòng mệnh\" ngẫu nhiên khác và giảm tiêu thụ sức tính toán của nó -1."
  },
  State_20642_Name = {
    Text = "linh hồn sinh ra"
  },
  State_20643_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>: Sau \"Bùng nổ\" nhận được [StateArg1] Điểm tính toán, <DelayKeywords:Trì hoãn>: Trừ [StateArg2] Điểm tính toán."
  },
  State_20643_Name = {
    Text = "Hội chứng mất trí nhớ"
  },
  State_20644_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>:Khi trang bị gây [StateArg2] sát thương lên bản thân, <PVPEntanglementKeywords:Vướng víu>. Mỗi khi có 1 đồng minh chết, <StrongEffectKeywords:Sự khuếch đại>+[StateArg1]."
  },
  State_20644_Name = {
    Text = "Bộ sưu tập quý giá nhất"
  },
  State_20645_Name = {
    Text = "Ba lô của nhà thàm hiểm"
  },
  State_20646_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>:\"Đánh\" sát thương tăng [StateArg1]%,\"Bùng nổ\" sau đó hồi phục bản thân <Heal:[Heal:StateArg2]> sinh lực."
  },
  State_20646_Name = {
    Text = "Khúc ru thôn phệ"
  },
  State_20647_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>:「Bùng nổ」sau đó đặt [StateArg1] lá<PVPDerivativeCardKeywords_11:「Trao đổi không công bằng」>vào tay."
  },
  State_20647_Name = {
    Text = "Giữa tâm bão"
  },
  State_20648_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>:vào đầu mỗi lượt, nhận được hiệu ứng tích cực <PVPWonderfulEffectKeywords:hiệu ứng kỳ diệu>, mỗi khi địch sử dụng \"lệnh khóa\" lần đầu tiên trong lượt sẽ đặt [StateArg1] lá \"cảnh quan hoa lệ\" vào tay."
  },
  State_20648_Name = {
    Text = "Yến tiệc lặng yên"
  },
  State_20649_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>:\"Bùng nổ cuồng khí\"đặt lá \"kỹ năng\" cuối cùng được chơi trong lượt trước vào tay và giảm tiêu thụ sức tính toán của nó -1, nếu nhiều lần kích hoạt hiệu ứng này sẽ truy hồi về trước."
  },
  State_20649_Name = {
    Text = "Đảo ngược thời gian"
  },
  State_20650_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>: Khi trang bị <ComaKeywords:hôn mê> bản thân.\"Bùng nổ\" trước khi phân tán toàn bộ trạng thái tích cực của địch."
  },
  State_20650_Name = {
    Text = "Hoang tưởng"
  },
  State_20651_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>: Cuối lượt, rút [StateArg1] lá bài."
  },
  State_20651_Name = {Text = "Tham lam"},
  State_20652_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>: Sau khi \"Bùng nổ\" gây ra cho toàn bộ kẻ địch [StateArg1] sát thương, <DisarmKeywords:tê liệt>."
  },
  State_20652_Name = {
    Text = "Kỷ luật"
  },
  State_20653_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>:\"đánh\" có thể chọn mục tiêu và trừ <Energy:[Energy:StateArg1]> điên cuồng của mục tiêu."
  },
  State_20653_Name = {
    Text = "Trôi dạt trong khát vọng"
  },
  State_20654_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>: khi lượt bắt đầu, <PVPSeriousInjuryKeywords:thiệt hại nặng> bản thân và nhận <Damage:[Damage:StateArg1]> lớp <PVPCorrosionKeywords:Dấu ấn tội lỗi>. Khi lượt kết thúc, <ReinforceKeywords:gia cố> bản thân."
  },
  State_20654_Name = {
    Text = "Sắc lệch nữ hoàng"
  },
  State_20655_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>:\"đánh\" sát thương tăng [StateArg1]%, \"đánh\" có thể chọn mục tiêu."
  },
  State_20655_Name = {Text = "Ủng hộ"},
  State_20656_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>:\"kỹ năng\" gây thương, chữa trị và hiệu ứng lá chắn tăng [StateArg1]%. Nếu không có <PVPProtectiveKeywords:rào cản>, sau khi sử dụng \"kỹ năng\" sẽ nhận được 1 tầng."
  },
  State_20656_Name = {
    Text = "Hồi kết của bài thơ"
  },
  State_20657_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>:mỗi lượt đối thủ đánh ra lá thứ [StateArg1] \"kỹ năng\", sẽ đặt một bản sao có chi phí sức tính toán - [StateArg2] tiêu thụ vào tay bạn."
  },
  State_20657_Name = {
    Text = "Sáng suốt"
  },
  State_20658_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>:\"đánh\" mỗi lần tấn công một mục tiêu sẽ nhận được [StateArg1] sức tính toán."
  },
  State_20658_Name = {
    Text = "Bản ballad của sự trói buộc"
  },
  State_20659_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>:Sau khi chết, vào đầu lượt tiếp theo <PVPResurrectionKeywords:phục sinh> bản thân và nhận <Heal:[Heal:StateArg1]> sức sống và <Block:[Block:StateArg2]> lá chắn đồng thời phá hủy \"vòng mệnh\" này."
  },
  State_20659_Name = {
    Text = "Sức sống"
  },
  State_20660_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>: Sau \"Bùng nổ cuồng khí\" giúp toàn bộ đồng đội nhận được <Block:[Block:StateArg1]> lá chắn."
  },
  State_20660_Name = {
    Text = "tường thành của trái tim"
  },
  State_20661_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>: Sau khi \"Bùng nổ\", gây <Damage:[Damage:StateArg1]> <PVPBleedingKeywords:Chảy máu> sát thương cho tất cả kẻ địch."
  },
  State_20661_Name = {
    Text = "Con đường lạc lối"
  },
  State_20662_Desc = {
    Text = "<PVPWeaponKeywords:Bánh xe số mệnh>: Khi kết thúc lượt, mỗi điểm <PVPCapKeywords:giới hạn sức tính toán> gây [StateArg1] <PVPBleedingKeywords:chảy máu> lên kẻ địch có <HPAndShieldMin:sinh mệnh và khiên thấp nhất>, tổng cộng gây <Damage:[Damage:DescArg1]> sát thương <PVPBleedingKeywords:chảy máu>."
  },
  State_20662_Name = {
    Text = "Ẩn mình trong đêm"
  },
  State_20663_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>: Trước khi \"Bùng nổ\", xóa bỏ trạng thái tiêu cực của bản thân, và nhận được [StateArg1] lớp<EnergyStorageKeywords:Súc tích>."
  },
  State_20663_Name = {
    Text = "Phá gỡ xiềng xích"
  },
  State_20664_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>:\"kỹ năng\" khiến bản thân nhận được <ReinforceKeywords:củng cố>."
  },
  State_20664_Name = {
    Text = "Trái tim hiệp sĩ"
  },
  State_20665_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>:khi bản thân xóa bỏ trạng thái tiêu cực, nếu không có trạng thái tiêu cực nào để xóa bỏ thì hồi phục <Heal:[Heal:StateArg1]> sức sống. Cuối lượt, <DelayKeywords:trì hoãn>: xóa bỏ trạng thái tiêu cực của bản thân."
  },
  State_20665_Name = {
    Text = "Cánh buồm bảo hộ"
  },
  State_20666_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>: Sau \"Bùng nổ\" khiến đồng minh có <HPAndShieldMin:Sinh lực và lá chắn thấp nhất> nhận [StateArg1] lớp <PVPProtectiveKeywords:rào cản>."
  },
  State_20666_Name = {
    Text = "Đến người bạn thân yêu"
  },
  State_20667_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>:Mỗi lượt, sát thương của \"kỹ năng\"đầu tiên của người trang bị tăng [StateArg1]%."
  },
  State_20667_Name = {
    Text = "Lưỡi kiếm khổng lồ"
  },
  State_20668_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>: Khi thể thức tỉnh của chúng ta chết, gây <Damage:[Damage:StateArg1]> <PVPBleedingKeywords:chảy máu> thương cho tất cả kẻ địch. Khi người trang bị chết, gây thêm <Damage:[Damage:StateArg2]> <PVPBleedingKeywords:chảy máu> thương."
  },
  State_20668_Name = {
    Text = "Cái chết của thiếu nữ san hô"
  },
  State_20669_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>:Khi trang bị và bắt đầu lượt, nếu bản thân không có<PVPProtectiveKeywords:Hàng rào>nhận [StateArg1] tầng<PVPProtectiveKeywords:Hàng rào>, nếu không thì giảm 1 chi phí sức tính toán của 1 lá\"Kỹ năng\" có chi phí cao nhất trong tay."
  },
  State_20669_Name = {
    Text = "Bảng đá Thánh ngôn"
  },
  State_20670_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>:\"đánh\" gây <PVPSeriousInjuryKeywords:thương nặng>, tăng [StateArg1]% thương, nhưng giảm một nửa sức sống của bản thân."
  },
  State_20670_Name = {
    Text = "Vảy cả đau nhói"
  },
  State_20671_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>:\"bùng nổ cuồng khí\" hồi phục bản thân <Heal:[Heal:StateArg1]> sinh lực."
  },
  State_20671_Name = {
    Text = "Vượt qua cái chết"
  },
  State_20672_Desc = {
    Text = "<PVPWeaponKeywords:Bánh xe định mệnh>：Khi kết thúc lượt, giảm số học tiêu hao của lá bài có số học tiêu hao cao nhất trong tay -[StateArg1]. <PrepareKeywords:Chuẩn bị>。"
  },
  State_20672_Name = {
    Text = "Tập trung tinh thần"
  },
  State_20673_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>:\"Bùng nổ\" sau đó khiến bản thân nhận được <Block:[Block:StateArg1]> lá chắn, các đồng minh khác nhận được <Energy:[Energy:StateArg2]> điên cuồng."
  },
  State_20673_Name = {
    Text = "Nhân tố không xác định"
  },
  State_20696_Name = {
    Text = "Trạng thái@Nỗi sợ người khổng lồ"
  },
  State_20723_Desc = {
    Text = "Sát thương của thẻ đánh tăng [Layer].__\"Chỉ dùng cho phát triển\""
  },
  State_20723_Name = {
    Text = "Tăng sát thương cố định của thẻ đánh__\"Chỉ dùng cho phát triển\""
  },
  State_20724_Desc = {
    Text = "Sát thương từ thẻ đánh giảm [Layer].__\"Chỉ dùng cho phát triển\""
  },
  State_20724_Name = {
    Text = "Giảm sát thương cố định của thẻ đánh__\"Chỉ dùng cho phát triển\""
  },
  State_20749_Desc = {
    Text = "Số lần quay lại thông dụng.__\"Chỉ dùng cho phát triển\""
  },
  State_20758_Desc = {
    Text = "Vào đầu lượt tiếp theo, rút [Layer] lá bài."
  },
  State_20758_Name = {
    Text = "Vẽ thẻ bị trì hoãn"
  },
  State_20766_Desc = {
    Text = "Cụ thể hiệu ứng xem logic tấn công chung.__\"Chỉ dùng cho phát triển\""
  },
  State_20802_Desc = {
    Text = "Thẻ bài này không thể được chơi ra.__\"chỉ dùng cho phát triển\""
  },
  State_20802_Name = {
    Text = "Không thể đánh ra__\"chỉ dùng cho phát triển\""
  },
  State_20803_Desc = {
    Text = "Lá bài này -1 sức tính toán tiêu thụ. Sau khi sử dụng các thẻ bài khác, lá bài này sẽ chuyển hóa thành một vòng mệnh ngẫu nhiên khác."
  },
  State_20803_Name = {
    Text = "<CardKeyWord:linh hồn sinh ra>"
  },
  State_20805_Desc = {
    Text = "Thẻ bài sẽ không được đưa vào rác bài trong giai đoạn bỏ bài, mà sẽ được giữ lại trong tay bài."
  },
  State_20805_Name = {
    Text = "<RetainIconKeywords:giữ lại>"
  },
  State_20806_Desc = {
    Text = "Sẽ không được đưa vào rác bài, mà sẽ được gỡ bỏ khỏi bộ bài."
  },
  State_20806_Name = {
    Text = "<DepleteIconKeywords:tiêu thụ>"
  },
  State_20820_Desc = {
    Text = "Vào đầu lượt tiếp theo, bạn sẽ hồi sinh và nhận thêm [Layer] sức sống cùng [Layer] lá chắn."
  },
  State_20820_Name = {
    Text = "Hồi sinh trì hoãn"
  },
  State_20851_Name = {
    Text = "Đưa thẻ bài"
  },
  State_20981_Desc = {
    Text = "\"Đỏ thẫm\"đã thức tỉnh, thương gây ra sẽ tăng đáng kể."
  },
  State_20981_Name = {
    Text = "Yu U Hahi thức tỉnh!"
  },
  State_20981_WeaponDesc = {
    Text = "Bắt đầu lượt tiếp theo nhận được lá chắn bằng với sức sống đã mất trong lượt trước."
  },
  State_20982_Desc = {
    Text = "Thân thể được đánh thức này chưa thức tỉnh… Khi sắp ngã gục sẽ thức tỉnh, hồi phục sức sống và bắt đầu chiến đấu với hình thái thật sự."
  },
  State_20982_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_20988_Desc = {
    Text = "Khởi đầu điên cuồng +80. Mỗi lượt nhận được 20 điểm điên cuồng."
  },
  State_20988_Name = {
    Text = "Đào Đen Đá·Lần Đầu Gặp Mặt"
  },
  State_20989_Desc = {
    Text = "Sức mạnh điên cuồng ban đầu +80. Mỗi vòng nhận được 2 điểm sức tính toán, 20 điểm điên cuồng."
  },
  State_20989_Name = {
    Text = "tulô · Lần Đầu Gặp Mặt"
  },
  State_21306_Desc = {
    Text = "Mỗi lượt chơi đặt lại combo chain"
  },
  State_21306_Name = {
    Text = "Combo được đặt lại"
  },
  State_21307_Desc = {
    Text = "Mỗi tầng tăng số lần tấn công thêm 1, mất 1 tầng khi nhận thương, tối thiểu là 1 tầng, mất toàn bộ vào cuối lượt."
  },
  State_21307_Name = {Text = "Combo"},
  State_21342_Desc = {
    Text = "Vào đầu lượt tiếp theo, nhận được [Layer] hồi phục."
  },
  State_21342_Name = {
    Text = "Chữa trị chậm"
  },
  State_21345_Desc = {
    Text = "Trước khi bắt đầu Lễ thức thần giáng, sau khi chết sẽ phục sinh, giải trừ trạng thái tiêu cực, miễn dịch với sát thương và hồi phục 30% sinh lực. Sau khi bắt đầu Lễ thức thần giáng, sau khi chết sẽ phục sinh hoàn toàn, giải trừ trạng thái tiêu cực và sự ám ảnh nghi lễ, và gọi hai thành viên clan."
  },
  State_21345_Name = {
    Text = "Sự ám ảnh nghi lễ"
  },
  State_21358_Desc = {
    Text = "Người chơi này không có giới hạn bài trên tay.__\"Chỉ dùng cho phát triển\""
  },
  State_21381_Name = {
    Text = "Số lần phong ấn"
  },
  State_21385_Desc = {
    Text = "Mỗi lần mất 1 điểm sức sống giảm 1 tầng. Khi số tầng giảm xuống 0, sẽ chuyển đổi ý định thành cơn thịnh nộ bùng phát với thương cao và sẽ gỡ bỏ hiệu ứng hóa đá."
  },
  State_21385_Name = {
    Text = "Sự cuồng nộ của máu"
  },
  State_21450_Desc = {
    Text = "Vào đầu vòng tiếp theo, giải trừ trạng thái tiêu cực của bản thân."
  },
  State_21450_Name = {
    Text = "Trì hoãn làm sạch"
  },
  State_21488_Desc = {
    Text = "Cụ thể hiệu ứng xem logic tấn công chung.__\"Chỉ dùng cho phát triển\""
  },
  State_21492_Desc = {
    Text = "Thương tăng 50% khi chí mạng."
  },
  State_21492_Name = {
    Text = "<CardKeyWord:tấn công chí mạng>"
  },
  State_21546_Desc = {
    Text = "Vào đầu lượt tiếp theo, nhận được lá chắn [Layer]."
  },
  State_21546_Name = {
    Text = "Lá chắn trễ"
  },
  State_21547_Desc = {
    Text = "Vào đầu lượt, giữ lại một nửa lá chắn."
  },
  State_21547_Name = {
    Text = "Kiên cường"
  },
  State_21548_Desc = {
    Text = "Vào đầu lượt tiếp theo, nhận được tăng cường sức mạnh."
  },
  State_21548_Name = {
    Text = "Tăng cường hoãn"
  },
  State_21580_Desc = {
    Text = "Săn đầu người đang theo dõi dấu vết của bạn, cứ mỗi lá bài rút ra, nó nhận được [StateArg1] lực lượng tạm thời."
  },
  State_21580_Name = {
    Text = "Dấu vết"
  },
  State_21587_Name = {
    Text = "Bản lượt này đã phát hiện một thân thể được đánh thức ngẫu nhiên mới"
  },
  State_21590_Name = {
    Text = "Số lần thử tìm thân thể được đánh thức mới"
  },
  State_21601_Name = {
    Text = "Đã tìm thấy thân thể được đánh thức mới"
  },
  State_21616_Desc = {
    Text = "Sau khi sử dụng cơn thịnh nộ bùng phát, phong ấn tất cả thân thể được đánh thức một lượt."
  },
  State_21616_Name = {
    Text = "Hài cốt hành trình"
  },
  State_21671_Name = {
    Text = "Gây sát thương phạm vi__\"Chỉ dùng cho phát triển\""
  },
  State_21688_Name = {
    Text = "Có thể sử dụng 1 lần"
  },
  State_21689_Name = {
    Text = "Có thể sử dụng 2 lần"
  },
  State_21720_Desc = {
    Text = "Gây tác động tương tự lên những người đánh thức phía sau mục tiêu, nếu không có người đánh thức nào phía sau, chỉ gây tác động lên mục tiêu."
  },
  State_21720_Name = {
    Text = "<CardKeyWord:xuyên thấu>"
  },
  State_21726_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>: Người sở hữu trang bị này, trong lượt đầu tiên khi sử dụng \"kỹ năng\", sẽ đưa một bản sao của thẻ có sức tính toán tiêu thụ - [StateArg1] vào rút bài từ bộ bài."
  },
  State_21726_Name = {Text = "Fouetté"},
  State_21744_Name = {
    Text = "Số lần thử tìm thân thể được đánh thức mới"
  },
  State_21745_Name = {
    Text = "Đã tìm thấy thân thể được đánh thức mới"
  },
  State_21746_Name = {
    Text = "Bản lượt này đã phát hiện một thân thể được đánh thức ngẫu nhiên mới"
  },
  State_21747_Desc = {
    Text = "Có [Layer] thân thể được đánh thức đang bị săn lùng, mỗi khi thân thể được đánh thức bị săn lùng sử dụng một thẻ bài, \"Săn Đầu Bạo Tẩu\" sẽ tăng 1 lớp dấu săn lùng."
  },
  State_21747_Name = {
    Text = "Lễ hội săn bắn"
  },
  State_21751_Desc = {
    Text = "Rút một nửa số thẻ có dấu săn([DescArg1]), \"Bạo Tẩu Săn Lùng\" tăng 1 lớp dấu săn."
  },
  State_21751_Name = {
    Text = "<CardKeyWord:săn lùng>"
  },
  State_21754_Desc = {
    Text = "Sau khi chết, xóa bỏ tất cả lực lượng tạm thời của \"Bạo tẩu Liệt sọ\" và giảm một nửa số lớp của \"Dấu săn bắn\"."
  },
  State_21754_Name = {
    Text = "Giải thoát ngắn hạn"
  },
  State_21765_Desc = {
    Text = "·có thể trang bị \"vòng mệnh\" cho một đồng minh thân thể được đánh thức, để nó phát huy hiệu ứng của \"vòng mệnh\". \n·khi trang bị lại \"vòng mệnh\" cho một thân thể được đánh thức, \"vòng mệnh\" cũ sẽ bị phá hủy và giữ lại \"vòng mệnh\" mới. \n·khi thân thể được đánh thức chết, \"vòng mệnh\"được trang bị trên nó cũng sẽ bị phá hủy. \n·nếu trang bị \"vòng mệnh\" cho một thân thể được đánh thức đã chết, \"vòng mệnh\"đó sẽ bị phá hủy, và bạn sẽ nhận được một ảo ảnh cùng với việc hoàn lại sức tính toán đã tiêu thụ."
  },
  State_21765_Name = {
    Text = "<PVPWeaponKeywords:vòng mệnh>"
  },
  State_21785_Name = {
    Text = "Lời kêu gọi chiến đấu"
  },
  State_21787_Name = {
    Text = "Thêm lời hét chiến đấu"
  },
  State_21826_Name = {
    Text = "Lời tuyên bố mở đầu của Đại Ca Nhí"
  },
  State_21829_Name = {
    Text = "Hiệu ứng lời nói cuối cùng"
  },
  State_21838_Name = {
    Text = "Giới thiệu mở đầu"
  },
  State_21843_Name = {
    Text = "Thêm trạng thái ở đầu"
  },
  State_21895_Name = {
    Text = "Lời kêu gọi mở đầu"
  },
  State_21905_Desc = {
    Text = "\"đánh\" nhận được 2 điểm sức tính toán, bỏ ngẫu nhiên 1 lá bài; \"phòng thủ\" rút 2 lá bài, mất 1 điểm sức tính toán."
  },
  State_21928_Name = {Text = "Gợi ý"},
  State_22054_Name = {
    Text = "Lời kêu gọi mở đầu"
  },
  State_22055_Desc = {
    Text = "Thân thể được đánh thức này chưa thức tỉnh… Khi sắp ngã gục sẽ thức tỉnh, hồi phục sức sống và bắt đầu chiến đấu với hình thái thật sự."
  },
  State_22055_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_22067_Desc = {
    Text = "Sau khi lượt kết thúc, yêu cầu 1 râu chạm tấn công [Layer] lần."
  },
  State_22067_Name = {
    Text = "Râu chạm tập hợp"
  },
  State_22074_Desc = {
    Text = "Vào lượt thứ bảy, ý định chuyển thành định lực; từ lượt thứ tám trở đi, ý định chuyển thành phỉ báng."
  },
  State_22134_Desc = {
    Text = "Sát thương xuyên thấu sẽ đồng thời gây thương cho Sinh lực, lá chắn và rào cản của mục tiêu."
  },
  State_22134_Name = {
    Text = "<CardKeyWord:Sát thương xuyên thấu>"
  },
  State_22157_Desc = {
    Text = "Khi sức sống dưới 50%([StateArg1]), sẽ phân chia thành \"dòng hải lưu\" và \"thủy triều\" có lượng sức sống bằng nhau."
  },
  State_22157_Name = {Text = "Phân chia"},
  State_22204_Desc = {
    Text = "Sau khi lượt bắt đầu, nhận [Layer]% tỷ lệ chí mạng tạm thời và thương chí mạng tạm thời."
  },
  State_22204_Name = {
    Text = "Âm thanh mềm mại dần dần lớn lên"
  },
  State_22204_WeaponDesc = {
    Text = "Nếu không mất sức sống cho đến lượt tiếp theo, tỷ lệ chí mạng lượt tiếp theo +[StateArg1]%."
  },
  State_22210_Desc = {
    Text = "Tiêu thụ sức tính toán + 100, và không thể tấn công, không thể nhận được điên cuồng."
  },
  State_22210_Name = {
    Text = "Siêu chậm"
  },
  State_22238_Name = {
    Text = "Phe đối đầu giữa người chơi__\"Chỉ dùng phát triển\""
  },
  State_22239_Name = {
    Text = "Áp dụng phe đối đầu giữa người chơi__\"Chỉ dùng cho phát triển\""
  },
  State_22249_Desc = {
    Text = "Sau khi bắt đầu lượt tiếp theo, rút ít hơn [Layer] lá bài."
  },
  State_22249_Name = {
    Text = "Trao đổi không công bằng"
  },
  State_22300_Desc = {
    Text = "Thẻ đánh này không thể chơi thẻ bài.__\"Chỉ dùng cho phát triển\""
  },
  State_22300_Name = {
    Text = "Thẻ Đánh bị tước vũ khí không thể đánh ra__\"Chỉ dùng cho phát triển\""
  },
  State_22303_Desc = {
    Text = "Mỗi lần nhận thương sẽ cho một thẻ ngẫu nhiên trong tay một lớp \"Trì Hoãn\" tạm thời, sau khi phá vỡ lá chắn sẽ loại bỏ trạng thái \"Lá Chắn Sương\"."
  },
  State_22303_Name = {
    Text = "Khiên băng giá"
  },
  State_22324_Desc = {
    Text = "Cứ mỗi lớp, bản vòng này tăng thêm 1 đợt tấn công"
  },
  State_22324_Name = {
    Text = "Cơn sóng dữ vang vọng"
  },
  State_22325_Desc = {
    Text = "Mỗi lần bị tấn công nhận được [StateArg1] điểm lực lượng tạm thời."
  },
  State_22325_Name = {
    Text = "Dòng máu khổng lồ"
  },
  State_22326_Desc = {
    Text = "Bạn đã bị khóa! Sau khi sử dụng, Vệ Binh Đạp Biển nhận 1 tầng Điên Rồ Tạm Thời và loại bỏ Dấu Ấn Sóng Giận trên thẻ lệnh này."
  },
  State_22326_Name = {
    Text = "<CardKeyWord:Dấu Ấn Sóng Giận>"
  },
  State_22328_Desc = {
    Text = "Mỗi lần sử dụng thẻ lệnh có \"Dấu Ấn Sóng Giận\", số lần tấn công trong lượt này +1."
  },
  State_22328_Name = {
    Text = "Cơn sóng dữ vang vọng"
  },
  State_22334_Desc = {
    Text = "Mỗi lần đánh 1 lá \"đánh\" sẽ đặt [StateArg1] lá \"vết thương\" lên trên cùng của rút bài từ bộ bài."
  },
  State_22334_Name = {
    Text = "Thương tổn"
  },
  State_22404_Desc = {
    Text = "Trong bản chiến đấu này, lá chắn tạo ra tăng [Layer] điểm."
  },
  State_22404_Name = {
    Text = "Báo động"
  },
  State_22405_Desc = {
    Text = "Lá chắn được tạo ra trong trận chiến này được nâng cao."
  },
  State_22405_Name = {
    Text = "<PVPAlertKeywords:giữ mình>"
  },
  State_22702_Desc = {
    Text = "Mỗi lượt chơi, 「thẻ bài」 đầu tiên được đánh ra sẽ kích hoạt 「hiệu ứng」 bổ sung."
  },
  State_22702_Name = {
    Text = "<CardKeyWord:đột kích>"
  },
  State_22706_Name = {
    Text = "Dấu hiệu tấn công__\"Chỉ dùng cho phát triển\""
  },
  State_22707_Desc = {
    Text = "Mỗi lượt đánh bài, áp dụng trạng thái phục kích và đánh dấu người chơi__\"Chỉ dùng cho phát triển\""
  },
  State_22707_Name = {
    Text = "Bộ kích hoạt phục kích__\"Chỉ dùng cho phát triển\""
  },
  State_22721_Name = {
    Text = "Linh bài thời gian \"Lạc lối\""
  },
  State_23405_Desc = {
    Text = "Thân thể được đánh thức này chưa thức tỉnh… Khi sắp bị đánh ngã sẽ thức tỉnh, nhận được lực lượng tương đương với số tầng phản công hiện tại, hồi phục sức sống và bắt đầu chiến đấu với hình thái thật sự."
  },
  State_23405_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_23406_Desc = {
    Text = "\"Người chìm sâu\" mỗi cuối lượt đều sẽ nhận được [StateArg1] tầng phản công."
  },
  State_23406_Name = {
    Text = "Kẻ khắc sét thức tỉnh!"
  },
  State_23512_Name = {
    Text = "Cho phép Hình Ảnh Ngàn Mặt"
  },
  State_23514_Name = {
    Text = "Cho phép Hình Ảnh Ngàn Mặt"
  },
  State_23515_Name = {
    Text = "Cho phép Hình Ảnh Ngàn Mặt"
  },
  State_23516_Name = {
    Text = "Cho phép Hình Ảnh Ngàn Mặt"
  },
  State_23517_Name = {
    Text = "Cung cấp cho người chơi tăng cường"
  },
  State_23518_Desc = {
    Text = "Áp dụng tăng sát thương trong 2 lượt / tăng 1 lần tấn công / áp dụng sức mạnh giảm xuống."
  },
  State_23518_Name = {
    Text = "<CardKeyWord:ý định lựa chọn>"
  },
  State_23519_Name = {
    Text = "Ý định 2b"
  },
  State_23520_Name = {
    Text = "Ý định 2c"
  },
  State_23521_Name = {
    Text = "Loại bỏ khi tiêu thụ, trừ tất cả thân thể được đánh thức[StateArg1] điên cuồng, và trộn 5 lá \"triệu chứng\" vào rút bài từ bộ bài của người chơi"
  },
  State_23522_Name = {
    Text = "Loại bỏ khi tiêu thụ, trừ hết tất cả thân thể được thức tỉnh [StateArg1] điên cuồng"
  },
  State_23524_Name = {
    Text = "Ý định3a"
  },
  State_23525_Desc = {
    Text = "Thân thể được đánh thức này chưa thức tỉnh… Khi sắp ngã gục sẽ thức tỉnh, hồi phục sức sống và bắt đầu chiến đấu với hình thái thật sự."
  },
  State_23525_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_23526_Name = {
    Text = "Ý định 2a"
  },
  State_23527_Name = {
    Text = "Ý định3c"
  },
  State_23528_Name = {
    Text = "Ý định3b"
  },
  State_23529_Desc = {
    Text = "Nâng cao sức mạnh / gây thêm sát thương / nhận lá chắn"
  },
  State_23529_Name = {
    Text = "<CardKeyWord:ý định lựa chọn>"
  },
  State_23530_Desc = {
    Text = "Sử dụng \"Hình Ảnh Ngàn Mặt\" cần phải thực hiện hai lần lựa chọn ý định. Nếu bỏ đi, thì tất cả các thân thể được đánh thức sẽ mất 20 điên cuồng, và trộn 5 lá\"triệu chứng\" vào rút bài từ bộ bài của người chơi."
  },
  State_23530_Name = {
    Text = "Đào Đen Đá thức tỉnh!"
  },
  State_23531_Name = {
    Text = "Cho phép Hình Ảnh Ngàn Mặt"
  },
  State_23532_Name = {
    Text = "Cho phép Hình Ảnh Ngàn Mặt"
  },
  State_23533_Desc = {
    Text = "Thêm thẻ triệu chứng vào bộ bài / gây chảy máu / giảm điên cuồng"
  },
  State_23533_Name = {
    Text = "<CardKeyWord:ý định lựa chọn>"
  },
  State_23534_Name = {
    Text = "Ý định1a"
  },
  State_23535_Name = {
    Text = "Ý định 1c"
  },
  State_23536_Name = {
    Text = "Ý định 1b"
  },
  State_23612_Desc = {
    Text = "Mỗi lần mất 1 điểm sức sống giảm 1 tầng. Khi số tầng giảm xuống 0, sẽ chuyển đổi ý định thành cơn thịnh nộ bùng phát với thương cao và sẽ gỡ bỏ hiệu ứng hóa đá."
  },
  State_23612_Name = {
    Text = "Sự cuồng nộ của máu·Kết thúc"
  },
  State_23687_Name = {
    Text = "Linh bài thời gian \"Triều dâng\""
  },
  State_23726_Desc = {
    Text = "Ngăn chặn thân thể được đánh thức chết 1 lần trước khi đến lượt tiếp theo, tối đa 1 cấp."
  },
  State_23726_Name = {
    Text = "kháng cự tử vong"
  },
  State_23732_Desc = {
    Text = "Cho đến trước khi lượt tiếp theo bắt đầu, mỗi lần chịu 1 lần Sát thương chủ động nhận được [Layer] lớp <PainWord:nhẫn nại>."
  },
  State_23732_Name = {
    Text = "Vùng Cấm Đầm Đen"
  },
  State_23736_Name = {
    Text = "Số lá bài rút trong lượt này"
  },
  State_23737_Name = {
    Text = "Bản ghi số lần rút bài"
  },
  State_23741_Name = {
    Text = "Áp dụng bản ghi rút bài"
  },
  State_23744_Desc = {
    Text = "Nếu trên sân không có\"người chết\", vào đầu lượt gọi 1 \"người chết\", mỗi lần gọi sức sống sẽ tăng lên."
  },
  State_23744_Name = {
    Text = "Gọi hồn chết"
  },
  State_23747_Name = {
    Text = "Tăng cường máu"
  },
  State_23748_Name = {
    Text = "Số lần gọi"
  },
  State_23769_Desc = {
    Text = "Thân thể được đánh thức này chưa thức tỉnh… Khi sắp ngã gục sẽ thức tỉnh, hồi phục sức sống và bắt đầu chiến đấu với hình thái thật sự."
  },
  State_23769_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_23771_Desc = {
    Text = "\"Phù thủy\"đã thức tỉnh, cẩn thận với phân thân do \"hình bóng\" tạo ra. Sau khi thức tỉnh, mỗi khi đối phương đánh ra 1 thẻ bài, Kasia sẽ nhận được 1 tầng \"hình bóng\"."
  },
  State_23771_Name = {
    Text = "Kasia thức tỉnh!"
  },
  State_23771_WeaponDesc = {
    Text = "Bắt đầu lượt tiếp theo nhận được lá chắn bằng với sức sống đã mất trong lượt trước."
  },
  State_23782_Desc = {
    Text = "Sau khi đạt 10 lớp 「hình bóng」, xóa số lớp 「hình bóng」 và gọi 1 phân thân ở phía trước, tối đa có thể tồn tại 2 phân thân. Khi được triệu hồi, phân thân sẽ mang theo 3 lớp <ParcloseIconKeywords:rào cản>."
  },
  State_23782_Name = {Text = "Ảo ảnh"},
  State_23786_Name = {
    Text = "Trạng thái @ thân thể được đánh thức Kasia lấy vật từ xa"
  },
  State_23787_Name = {
    Text = "Trạng thái@thân thể được đánh thức Kassia@lấy vật từ xa@giảm số lần rút bài"
  },
  State_23788_Desc = {
    Text = "Vào đầu vòng 3, thêm 1 lá \"Hồi Âm Quá Khứ—Bỏ hết bài trên tay, sức sống hiện tại và lá chắn trở về trạng thái cuối vòng trước. Giữ lại, tiêu thụ.\" vào tay."
  },
  State_23791_Name = {
    Text = "Thông báo mở đầu"
  },
  State_23823_Name = {Text = "Bom số 1"},
  State_23825_Name = {
    Text = "Trạng thái @thức tỉnh thân thể được đánh thức Kasia@ tất cả biến mất"
  },
  State_23827_Desc = {
    Text = "Đánh ra, mất [DescArg1] điểm máu tối đa, Đại Pháp Sư nhận được 1 lớp \"Tự Tin\" trong lượt này."
  },
  State_23827_Name = {
    Text = "<CardCheerKeywords:hoan hô>"
  },
  State_23828_Desc = {
    Text = "Đại ảo thuật gia hiện đang rất tận hưởng buổi biểu diễn của mình. Với mỗi lớp \"dương dương đắc ý\", hiệu ứng kỹ năng của anh ta sẽ bị suy yếu và lực lượng giảm xuống [DescArg1], tối đa có thể đạt 5 lớp."
  },
  State_23828_Name = {Text = "tự mãn"},
  State_23871_Desc = {
    Text = "Khi tăng máu tối đa, máu hiện tại sẽ không tăng cùng lúc. Khi giảm máu tối đa, nếu máu hiện tại vượt mức, sẽ loại bỏ phần dư, máu tối đa ít nhất là 1, sau khi chết không đặt lại."
  },
  State_23871_Name = {
    Text = "<MaxHPColour:máu tối đa>"
  },
  State_23934_Name = {
    Text = "Trạng thái@theo dõi lấy vật từ xa"
  },
  State_23935_Name = {
    Text = "Trạng thái@thân thể được đánh thức Kassia@kỹ năng lấy vật từ xa đã kích hoạt"
  },
  State_2393_Desc = {
    Text = "Thân thể được đánh thức này chưa thức tỉnh… Khi sắp ngã gục sẽ thức tỉnh, hồi phục sức sống và bắt đầu chiến đấu với hình thái thật sự."
  },
  State_2393_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_2394_Name = {
    Text = "Lực lượng đỏ thẫm khởi linh"
  },
  State_2395_Name = {
    Text = "Đồ trang sức của buổi tiệc xa xôi"
  },
  State_2395_WeaponDesc = {
    Text = "\"phòng thủ\" gây tăng lá chắn 30%. Nếu tỷ lệ rớt dấu đen của người trang bị lớn hơn 15%, \"phòng thủ\" gây tăng lá chắn thêm 30%."
  },
  State_2396_Desc = {
    Text = "Thương harming chí mạng tăng 20%. Thương gây ra cho địch có lá chắn chắc chắn sẽ là chí mạng."
  },
  State_2398_Desc = {
    Text = "Khi bị thương, nhận được [Layer] lá chắn, mỗi lần bị thương, lá chắn tăng lên, phục hồi khi kết thúc lượt."
  },
  State_2398_Name = {
    Text = "Rào cản chiều"
  },
  State_2398_WeaponDesc = {
    Text = "Thương chủ động nhận phải tăng [Layer]. Mỗi lần nhận thương, vết loét sẽ rỗng rỗng và mở rộng, hồi phục vào đầu lượt."
  },
  State_2399_Desc = {
    Text = "Sau khi hồi phục sức sống, tất cả thân thể được đánh thức nhận được 3 điểm điên cuồng. Mỗi lần thứ 5 hồi phục sức sống, sát thương bùng nổ điên cuồng trong trận chiến này tăng [Arg1]."
  },
  State_2400_Desc = {
    Text = "Giới hạn râu chạm tăng lên 1. Khi sức sống dưới 50%, sát thương xúc tu tăng [StateArg1] điểm."
  },
  State_2400_Name = {
    Text = "Lễ vật từ quá khứ của sáng tạo"
  },
  State_2400_WeaponDesc = {
    Text = "Giới hạn râu chạm tăng lên 1. Khi sức sống dưới 50%, sát thương xúc tu tăng [StateArg1] điểm."
  },
  State_2401_Desc = {
    Text = "Vào đầu lượt, thêm lá bài trên cùng của rác bài vào tay."
  },
  State_2402_Desc = {
    Text = "Tại đầu lượt, cứ mỗi thẻ bài ở không gian siêu việt sẽ cho bạn [Arg1] điểm lực lượng tạm thời trong lượt này."
  },
  State_2403_Desc = {
    Text = "Trong trận chiến này, lượng lá chắn được tăng lên [Layer] điểm."
  },
  State_2403_Name = {
    Text = "Báo động"
  },
  State_2403_WeaponDesc = {
    Text = "Trong trận chiến này, lượng lá chắn được tăng lên [Layer] điểm."
  },
  State_2404_Desc = {
    Text = "Lấy lên xóa 1 thẻ triệu chứng. Tỷ lệ khắcăng may mắn tăng 50%."
  },
  State_2405_Desc = {
    Text = "Thay đổi tạm thời sức tính toán của thẻ bài"
  },
  State_2405_Name = {
    Text = "Thay đổi tạm thời sức tính toán của thẻ bài"
  },
  State_2405_WeaponDesc = {
    Text = "Thay đổi tạm thời sức tính toán của thẻ bài"
  },
  State_2406_Desc = {
    Text = "Khi dùng hết điểm sức tính toán cuối cùng, nhận được 2 điểm sức tính toán. Mỗi lượt tối đa kích hoạt 2 lần."
  },
  State_2407_Name = {
    Text = "Giá trị quan sát"
  },
  State_2408_Name = {
    Text = "Còi Thủy Thủ"
  },
  State_2409_Desc = {
    Text = "Trong lượt này, mỗi [Đánh] giảm 1 điểm tiêu thụ sức tính toán."
  },
  State_2409_Name = {
    Text = "Lưỡi Kiếm Khiêu Khích"
  },
  State_2409_WeaponDesc = {
    Text = "Trong lượt này, mỗi [Đánh] giảm 1 điểm tiêu thụ sức tính toán."
  },
  State_2410_Desc = {
    Text = "Không thể hành động trong 1 lượt. Đối tượng đã bị hóa đá không thể bị áp dụng hiệu ứng hóa đá lần nữa."
  },
  State_2410_Name = {
    Text = "<PetrifactionIconKeywords: Hoá Đá>"
  },
  State_2410_WeaponDesc = {
    Text = "Làm cho quái vật bị choáng một lượt."
  },
  State_2411_Desc = {
    Text = "Vào cuối lượt, gây [Số lớp] chảy máu cho đội của tôi."
  },
  State_2411_Name = {Text = "Đèn máu"},
  State_2411_WeaponDesc = {
    Text = "Vào cuối lượt, gây [Số lớp] chảy máu cho đội của tôi."
  },
  State_2412_Desc = {
    Text = "Thương gây ra trong lượt tiếp theo sẽ được nhân đôi."
  },
  State_2412_Name = {
    Text = "Sinh tồn trong tuyệt cảnh"
  },
  State_2412_WeaponDesc = {
    Text = "Thương gây ra trong lượt tiếp theo sẽ được nhân đôi."
  },
  State_2413_Desc = {
    Text = "Đánh và phòng thủ thu được giảm điên cuồng [Layer] %."
  },
  State_2413_Name = {Text = "Hư vô"},
  State_2413_WeaponDesc = {
    Text = "Đánh và phòng thủ nhận được [StateArg1]% điên cuồng."
  },
  State_2415_Desc = {
    Text = "Nếu đã bị thương trong lượt trước, bắt đầu lượt với 1 lượt kháng hiệu ứng."
  },
  State_2415_Name = {
    Text = "thích ứng"
  },
  State_2415_WeaponDesc = {
    Text = "Nếu đã bị thương trong lượt trước, bắt đầu lượt với 1 lượt kháng hiệu ứng."
  },
  State_2416_Desc = {
    Text = "Quái vật được triệu hồi có sức sống và sát thương tăng gấp đôi."
  },
  State_2416_Name = {
    Text = "\"thế giới tượng sáp\""
  },
  State_2416_WeaponDesc = {
    Text = "Quái vật được triệu hồi có sức sống và sát thương tăng gấp đôi."
  },
  State_24174_Desc = {
    Text = "Thân thể được đánh thức này sẽ không còn bị giảm sức sống xuống dưới 1 do sát thương."
  },
  State_24174_Name = {
    Text = "Miễn dịch với cái chết"
  },
  State_2418_Desc = {
    Text = "[cơn thịnh nộ bùng phát] làm bản thân nhận được 30 điểm điên cuồng."
  },
  State_2418_Name = {
    Text = "Màn che của vị thần dị hóa"
  },
  State_2418_WeaponDesc = {
    Text = "[cơn thịnh nộ bùng phát] làm bản thân nhận được 30 điểm điên cuồng."
  },
  State_2419_Name = {
    Text = "Sáng tạo gương trắng"
  },
  State_2420_Desc = {
    Text = "Trong lượt này, mỗi lần đánh ra 1 lá [Phòng thủ] sẽ giảm 1 điểm tiêu thụ sức tính toán."
  },
  State_2420_Name = {
    Text = "Lưỡi dao mắt tâm"
  },
  State_2420_WeaponDesc = {
    Text = "Trong lượt này, mỗi lần đánh ra 1 lá [Phòng thủ] sẽ giảm 1 điểm tiêu thụ sức tính toán."
  },
  State_24210_Desc = {
    Text = "Trong lượt này, Thần Vương tấn công toàn bộ kẻ địch bằng râu chạm"
  },
  State_24210_Name = {
    Text = "Cánh tay thần quốc - Lệnh khóa"
  },
  State_24211_Desc = {
    Text = "·Sau khi lượt kết thúc, gây [DescArg4] lần [DescArg2] điểm thương cho kẻ địch hàng đầu, nếu tiêu diệt kẻ địch, thương này tăng thêm [DescArg3] điểm, tối đa tăng 5 lần(hiện tại [DescArg6] lần). \n·Mỗi khi thân thể được thức tỉnh sử dụng cơn điên cuồng bùng phát, trong lượt này sẽ tấn công thêm 1 lần. \n·Sau khi Người Giữ Gìn sử dụng lệnh khóa, mục tiêu của các đòn tấn công trong lượt này trở thành tất cả kẻ địch, nếu khi đối đầu Boss, thương do \"thần quốc\" gây ra còn tăng thêm [DescArg5] điểm."
  },
  State_24211_Name = {
    Text = "Cánh tay thần quốc"
  },
  State_24213_Name = {
    Text = "Nếu lá bài này ở trong tay, vào cuối lượt sẽ nhận được 150 điểm năng lượng chìa khóa bạc"
  },
  State_24214_Desc = {
    Text = "·Sau khi lượt kết thúc, gây [DescArg2] điểm sát thương cho kẻ địch hàng tiền."
  },
  State_24214_Name = {
    Text = "Cánh tay thần quốc"
  },
  State_24215_Desc = {
    Text = "·Sau khi lượt kết thúc, gây [DescArg2] điểm thương cho kẻ địch tiền tuyến, nếu tiêu diệt kẻ địch, thương này tăng [DescArg3] điểm, tối đa tăng 5 lần (hiện tại [DescArg4] lần)."
  },
  State_24215_Name = {
    Text = "Cánh tay thần quốc"
  },
  State_24217_Name = {
    Text = "Xóa trạng thái <VulnerabilityIconKeywords:tăng sát thương>, <WeaknessIconKeywords:yếu đuối> và <FragileIconKeywords:mỏng manh> của bản thân"
  },
  State_24220_Name = {
    Text = "Nhận được [DescArg1]điểm lá chắn"
  },
  State_24222_Desc = {
    Text = "·Sau khi lượt kết thúc, gây [DescArg4] lần [DescArg2] điểm thương cho kẻ địch tiền tuyến, nếu giết kẻ địch, thương này tăng [DescArg3] điểm, tối đa tăng 5 lần (hiện tại [DescArg5] lần).\n·Mỗi khi thể thức tỉnh sử dụng bùng nổ điên cuồng, trong lượt này sẽ thêm 1 lần tấn công. \n·Mỗi khi Người Giữ Gìn sử dụng mật lệnh, mục tiêu của các đòn tấn công trong lượt này sẽ chuyển thành tất cả kẻ địch."
  },
  State_24222_Name = {
    Text = "Cánh tay thần quốc"
  },
  State_24223_Desc = {
    Text = "·Sau khi lượt kết thúc, gây [DescArg2] điểm thương cho kẻ địch tiền tuyến, nếu giết kẻ địch, thương này tăng [DescArg3] điểm, tối đa tăng 5 lần (hiện tại [DescArg4] lần).\n·Mỗi khi Người Giữ Gìn sử dụng Mật lệnh, làm mục tiêu tấn công phát động trong lượt này trở thành tất cả kẻ địch."
  },
  State_24223_Name = {
    Text = "Cánh tay thần quốc"
  },
  State_24224_Desc = {
    Text = "·Sau khi lượt kết thúc, gây [DescArg4] lần [DescArg2] điểm thương cho kẻ địch tiền tuyến, nếu giết kẻ địch, sát thương này tăng [DescArg3] điểm, tối đa tăng 5 lần (hiện tại [DescArg5] lần).\n·Mỗi khi thể thức tỉnh sử dụng bùng nổ điên cuồng, sẽ phát động thêm 1 lần tấn công trong lượt này."
  },
  State_24224_Name = {
    Text = "Cánh tay thần quốc"
  },
  State_24226_Desc = {
    Text = "·Cuối lượt, gây [DescArg4] lần [DescArg2] điểm thương cho kẻ địch tiền tuyến, nếu tiêu diệt kẻ địch, thương này tăng thêm [DescArg3] điểm, tối đa tăng 5 lần (hiện tại [DescArg6] lần). \n·Mỗi khi thân thể được đánh thức sử dụng cơn thịnh nộ bùng phát, lượt này sẽ tấn công thêm 1 lần. \n·Trong trận chiến với thủ lĩnh, mỗi khi Người Giữ Gìn sử dụng lệnh khóa, thương của 「thần quốc」 「cánh tay」 tăng thêm [DescArg5] điểm."
  },
  State_24226_Name = {
    Text = "Cánh tay thần quốc"
  },
  State_24227_Desc = {
    Text = "·Cuối lượt, gây [DescArg2] điểm thương cho kẻ địch hàng đầu, nếu tiêu diệt kẻ địch, thương này tăng [DescArg3] điểm, tối đa tăng 5 lần(hiện tại [DescArg5] lần). \n·Người giữ bí mật sử dụng lệnh khóa sau, mục tiêu của các đợt tấn công trong lượt này sẽ là tất cả kẻ địch, nếu đang trong trận đấu với Boss, thương từ \"thần quốcchân tay\" còn tăng [DescArg4] điểm."
  },
  State_24227_Name = {
    Text = "Cánh tay thần quốc"
  },
  State_2422_Desc = {
    Text = "Sau khi đánh ra, nhận được [StateArg1] điểm lá chắn."
  },
  State_2422_Name = {
    Text = "<Rune_6:bức tường thép>"
  },
  State_24245_Desc = {
    Text = "Khi kết thúc lượt, hồi sinh tất cả \"Hydra\" và tộc thuộc hạ. Mỗi lần có một thuộc hạ chết, giảm 1 tầng; nếu số tầng là 0, \"Hydra\" sẽ chuyển hình thái để tiến hành chiến đấu cuối cùng."
  },
  State_24245_Name = {
    Text = "Thao tác vạn rắn"
  },
  State_24247_Desc = {
    Text = "Sát thương nhận phải giảm 90%. Nếu không có lớp \"Vạn Xà Thao Túng\" vào đầu lượt, loại bỏ trạng thái này."
  },
  State_24247_Name = {
    Text = "Rào chắn hình con rắn"
  },
  State_2425_Desc = {
    Text = "Được tiêu thụ sau khi đánh ra. Nếu là thẻ lệnh, thương và bảo vệ của nó sẽ được tăng gấp 2 lần."
  },
  State_2425_Name = {
    Text = "<CardKeyWord:tan chảy>"
  },
  State_2426_Desc = {
    Text = "Mỗi lượt, thẻ bài đầu tiên bạn chơi sẽ kích hoạt thêm 1 lần, nhưng mỗi lượt chỉ được chơi tối đa 4 thẻ bài."
  },
  State_2427_Name = {
    Text = "Trạng thái @Chìa Khóa Bạc Mộng Ảo: Đếm Blood Abyss Heart"
  },
  State_2428_Desc = {
    Text = "Số lượng <ParcloseIconKeywords:rào cản> của Hoa Ác tăng thêm [Layer] tầng."
  },
  State_2428_Name = {
    Text = "Rào cản oán hận"
  },
  State_2428_WeaponDesc = {
    Text = "Số lượng rào cản của Ác Hoa tăng thêm [Layer] lớp"
  },
  State_24292_Name = {
    Text = "Di chuyển hàng sau lên trước"
  },
  State_24293_Name = {
    Text = "Dòng trước lui lại"
  },
  State_2429_Desc = {
    Text = "Tất cả sát thương gây ra sẽ giảm [Layer] %."
  },
  State_2429_Name = {
    Text = "Giảm thương tạm thời"
  },
  State_2429_WeaponDesc = {
    Text = "Tất cả sát thương gây ra sẽ giảm [Layer] %."
  },
  State_2430_Desc = {
    Text = "Khi trận chiến bắt đầu, tất cả đồng minh nhận được 3 lớp [Giáp Sáp]. Khi lượt kết thúc, gây ra [Arg1] lớp chảy máu cho đội của tôi."
  },
  State_2430_Name = {
    Text = "\"Quý ông sáp\""
  },
  State_2430_WeaponDesc = {
    Text = "Khi trận chiến bắt đầu, tất cả đồng minh nhận được 3 lớp [Giáp Sáp]. Khi lượt kết thúc, gây ra [Arg1] lớp chảy máu cho đội của tôi."
  },
  State_2431_Desc = {
    Text = "Đội duy nhất: Khi trang bị, tăng lượng tạo lá chắn và hồi sức sống của người trang bị dựa trên <WeaponEffect_Num:[StateArg1]%> thể chất của họ. Tăng lượng phản công của người trang bị lên <WeaponEffect_Num:[StateArg3]%>. Khi thực hiện \"phòng thủ\", người trang bị sẽ nhận được <WeaponEffect_Num:[StateArg4]%> khả năng phòng thủ dưới dạng <RetaliateIconKeywords:phản công>. Sau khi chiến đấu bắt đầu, nhận được <WeaponEffect_Num:[StateArg2]%> thể chất của người trang bị dưới dạng <PowerIconKeywords:lực lượng>. Nếu giới vực hiện tại là \"biển sâu\", sẽ nhận thêm lượng thương râu chạm tương đương."
  },
  State_2431_WeaponDesc = {
    Text = "Người trang bị gây ra lá chắn và hồi sức sống tăng lên <WeaponEffect_Num:[DescArg1]> điểm, người trang bị gây ra phản công tăng lên <WeaponEffect_Num:[StateArg3]%>, khi đánh \"phòng thủ\", còn nhận được <WeaponEffect_Num:[Counterattack:DescArg3]> lớp<RetaliateIconKeywords:phản công>. Sau khi chiến đấu bắt đầu, nhận được <WeaponEffect_Num:[Power:DescArg2]> điểm<PowerIconKeywords:lực lượng>. Nếu giới vực hiện tại là \"biển sâu\", còn nhận được lượng thương tổn xúc tu tương đương."
  },
  State_2432_Desc = {
    Text = "Tăng 50% Sát thương chủ động và thương tổn xúc tu phải chịu, khi kết thúc lượt xóa 1 lớp."
  },
  State_2432_Name = {
    Text = "<VulnerabilityIconKeywords:tăng sát thương>"
  },
  State_2432_WeaponDesc = {
    Text = "Mọi sát thương nhận vào tăng 50%."
  },
  State_2433_Desc = {
    Text = "Vào cuối mỗi lượt, nhận được [Layer] điểm lực lượng."
  },
  State_2433_Name = {
    Text = "giận dữ"
  },
  State_2434_Name = {
    Text = "Vòng Phòng Trang Sức 36"
  },
  State_2434_WeaponDesc = {
    Text = "Khi rút được thẻ bài của người sở hữu trang bị, sức tính toán của họ sẽ thay đổi ngẫu nhiên trong khoảng từ 0-3."
  },
  State_2435_Desc = {
    Text = "Sự kiện 19_2"
  },
  State_2435_Name = {
    Text = "Sự kiện 19_2"
  },
  State_2435_WeaponDesc = {
    Text = "Sự kiện 19_2"
  },
  State_2436_Desc = {
    Text = "Lực lượng và lá chắn nhận được giảm 50%, kéo dài [Layer] lượt."
  },
  State_2436_Name = {
    Text = "Tạm thời lời nguyền"
  },
  State_2436_WeaponDesc = {
    Text = "Trước khi kết thúc lượt, không bị ảnh hưởng bởi các hiệu ứng tích cực được áp dụng lên bản thân."
  },
  State_2438_Desc = {
    Text = "Trạng thái @ sáng tạo bạc trắng và bộ đếm chênh lệch"
  },
  State_2438_Name = {
    Text = "Trạng thái @ sáng tạo bạc trắng và bộ đếm chênh lệch"
  },
  State_2438_WeaponDesc = {
    Text = "Trạng thái @ sáng tạo bạc trắng và bộ đếm chênh lệch"
  },
  State_2440_Name = {
    Text = "Rút 1 lá bài"
  },
  State_2441_Name = {
    Text = "Nhận được 1 điểm sức tính toán"
  },
  State_2442_Name = {
    Text = "Áp dụng 1 lớp <VulnerabilityIconKeywords:tăng sát thương> lên tất cả kẻ địch"
  },
  State_2443_Name = {
    Text = "Áp dụng 1 lớp<WeaknessIconKeywords:yếu đuối> lên tất cả kẻ địch"
  },
  State_2444_Name = {
    Text = "Nhận <Energy:[DescArg1]> điểm điên cuồng"
  },
  State_2445_Name = {
    Text = "Các thân thể được đánh thức khác nhận được <Energy:[DescArg1]> điểm điên cuồng"
  },
  State_2446_Name = {
    Text = "Thêm 1 lá bài<DerivativeCardKeywords_4:「cảm hứng」>vào bộ bài để rút"
  },
  State_2447_Desc = {
    Text = "Đội duy nhất: Tỷ lệ chí mạng và thương harming chí mạng của thẻ lệnh trang bị, lá chắn tạo ra bởi thẻ lệnh, hồi sức sống, điên cuồng và lực lượng tăng <WeaponEffect_Num:[StateArg1]%>. Nếu giới vực hiện tại là \"siêu việt\", sau khi sử dụng \"tiêu diệt\", nhận <WeaponEffect_Num:[StateArg2]> điểm năng lượng chìa khóa bạc. Khi vào lượt siêu việt, lệnh khóa tiếp theo trong lượt này được kích hoạt 2 lần."
  },
  State_2447_WeaponDesc = {
    Text = "Trang bị thẻ lệnh tăng tỷ lệ chí mạng và thương chí mạng, tạo lá chắn, hồi sức sống, tăng điên cuồng và lực lượng <WeaponEffect_Num:[StateArg1]%>. Nếu giới vực hiện tại là \"siêu việt\", sau khi sử dụng \"huỷ diệt\", nhận <WeaponEffect_Num:[StateArg2]> điểm năng lượng chìa khóa bạc. Khi vào lượt siêu việt, lệnh khóa kế tiếp trong lượt kích hoạt 2 lần."
  },
  State_2448_Desc = {
    Text = "Thẻ bài sẽ không được đưa vào rác bài trong giai đoạn bỏ bài, mà sẽ được giữ lại trong tay bài."
  },
  State_2448_Name = {
    Text = "<CardKeyWord:bảo lưu>"
  },
  State_2449_Desc = {
    Text = "Sau khi nhận thương thực tế, nhận được [Layer] lá chắn."
  },
  State_2449_Name = {
    Text = "bộ đệm"
  },
  State_2449_WeaponDesc = {
    Text = "Sau khi nhận thương thực tế, nhận được [Layer] lá chắn."
  },
  State_2450_Desc = {
    Text = "\"Đánh\" chắc chắn gây chí mạng. Thương harming chí mạng tăng 50%."
  },
  State_2451_Desc = {
    Text = "Vào cuối lượt, các đồng minh khác nhận được [Layer] sức mạnh."
  },
  State_2451_Name = {
    Text = "\"Lửa Minh Triết\""
  },
  State_2452_Desc = {
    Text = "Sau khi đánh ra, nhận được [StateArg1] điểm lực lượng."
  },
  State_2452_Name = {
    Text = "<Rune_14_High:cường lực cao cấp>"
  },
  State_2453_Name = {
    Text = "Trang sức lễ hội quang hợp"
  },
  State_2453_WeaponDesc = {
    Text = "Sau khi chiến đấu bắt đầu, tất cả các thẻ bài của người trang bị được giữ lại."
  },
  State_2454_Desc = {
    Text = "Sẽ không được đưa vào rác bài, mà sẽ được gỡ bỏ khỏi bộ bài."
  },
  State_2454_Name = {
    Text = "<DepleteIconKeywords:tiêu thụ>"
  },
  State_2454_WeaponDesc = {
    Text = "Sau khi đánh, thẻ bài sẽ không vào rác bài và không thể sử dụng lại trong cuộc chiến đấu này."
  },
  State_24556_Name = {
    Text = "Trạng thái @ Đại ảo thuật gia Houdini @ Khán giả may mắn thêm vỗ tay"
  },
  State_2455_Name = {
    Text = "Trạng thái: Vũ công Hỏa Thanh khởi linh 7"
  },
  State_24560_Desc = {
    Text = "Mỗi khi sử dụng lệnh khóa, tỷ lệ chí mạng tạm thời và sát thương chí mạng tạm thời của Vòng tròn · Ramona tăng thêm 25%."
  },
  State_24560_Name = {
    Text = "Khách du lịch Klein"
  },
  State_24562_Desc = {
    Text = "Sau khi vòng kết thúc, nhận được 1 lớp entropy âm."
  },
  State_24562_Name = {
    Text = "Người đi bộ Penrose"
  },
  State_24564_Desc = {
    Text = "Mỗi khi có 3 lớp entropy âm, khi sử dụng thẻ lệnh Vòng tròn · Ramona sẽ tiêu thụ hết entropy âm. Đồng thời, hiệu ứng phụ của vòng lặp sẽ được kích hoạt. Entropy âm tối đa có thể tích lũy đến 3 lớp."
  },
  State_24564_Name = {Text = "Negentropy"},
  State_2456_Name = {
    Text = "Trạng thái@Hỏa Thanh Vũ Công 15"
  },
  State_2457_Name = {
    Text = "Rút 1 lá bài"
  },
  State_24584_Name = {
    Text = "Trạng thái @N của phân thân @nhảm nhí1 đã đổi sang"
  },
  State_2458_Name = {
    Text = "Trạng thái @ Phụ kiện Scarlet Embrace hiệu ứng đếm"
  },
  State_24593_Desc = {
    Text = "Khi số tầng là 0, sẽ thay đổi ý định thành \"gọi\", sẽ giảm 1 tầng vào cuối lượt, tối đa có thể sở hữu 4 tầng."
  },
  State_24593_Name = {Text = "Hỗn Mang"},
  State_24595_Desc = {
    Text = "Chết ngay lập tức giảm 1 lớp \"hỗn loạn\" của \"N\"."
  },
  State_24595_Name = {Text = "Phân tán"},
  State_24596_Desc = {
    Text = "Gọi \"N\" phân thân, với mỗi tầng \"Tối\" sẽ gọi 1 phân thân."
  },
  State_24596_Name = {Text = "tối"},
  State_2460_Desc = {
    Text = "Đội duy nhất: sát thương cơ bản gây ra bởi người chơi, <IntoxicationIconKeywords:trúng độc> và <RetaliateIconKeywords:phản công> tăng <WeaponEffect_Num:[StateArg1]%>, tỷ lệ và sát thương chí mạng tăng <WeaponEffect_Num:[StateArg2]%>."
  },
  State_2460_WeaponDesc = {
    Text = "Trang bị gây thương cơ bản, <IntoxicationIconKeywords:trúng độc> và <RetaliateIconKeywords:phản công> tăng <WeaponEffect_Num:[StateArg1]%>. Tỷ lệ chí mạng và thương chí mạng tăng <WeaponEffect_Num:[StateArg2]%>."
  },
  State_2461_Desc = {
    Text = "Trong chiến đấu, khi nhận phải thương gây chết, sẽ phục sinh, hồi phục [Layer] điểm sức sống và khiến tất cả thân thể được đánh thức nhận được [StateArg1] điểm điên cuồng, không thể xóa bỏ."
  },
  State_2461_Name = {
    Text = "Chim thiên đường bất tử"
  },
  State_2463_Desc = {
    Text = "Khi trận chiến bắt đầu, phôi hợp tử +20%. Mỗi khi có một thân thể được đánh thức đạt đến mức điên cuồng tối đa, phôi hợp tử tăng thêm +20%."
  },
  State_24640_Desc = {
    Text = "Sau khi chiến đấu bắt đầu, Dung hợp Phôi thai +[Blood:DescArg1], mỗi lần kích hoạt kháng cự tử vong, Dung hợp Phôi thai +[Blood:DescArg1]. Mỗi lần Sorrel gây thương, sát thương bản thân gây ra trong lượt này tăng thêm bằng 4% sức tấn công."
  },
  State_24640_Name = {Text = "minh châu"},
  State_2464_Desc = {
    Text = "Sức mạnh tính toán của thẻ bài tăng lên"
  },
  State_2464_Name = {
    Text = "Tăng cường sức mạnh tính toán thẻ vĩnh viễn"
  },
  State_2464_WeaponDesc = {
    Text = "Sức mạnh tính toán của thẻ bài tăng lên"
  },
  State_24654_Desc = {
    Text = "Sau khi Dafudale tiêu diệt kẻ địch bằng bất kỳ cách nào, tỷ lệ chí mạng của đội sẽ được tăng vĩnh viễn thêm 5% trong lần chơi này, tối đa cộng dồn 5 lần. (Hiện tại cộng dồn [DescArg1] lần)"
  },
  State_24654_Name = {
    Text = "sương xám tham lam"
  },
  State_2466_Desc = {
    Text = "Cho đến khi lượt tiếp theo bắt đầu, mỗi lần chịu 1 lần sát thương tấn công, khiến xúc tu phản công kẻ tấn công 1 lần, Thiệt hại tạm thời của xúc tu +[Layer]."
  },
  State_2466_Name = {
    Text = "〔Đã bỏ〕Máu dị giáo"
  },
  State_24678_Name = {
    Text = "Trạng thái @N của phân thân @Nhẩm2 đã chuyển"
  },
  State_24679_Name = {
    Text = "Trạng thái @N của phân thân 3 @ thì thầm 6 trạng thái chuyển đổi"
  },
  State_2467_Desc = {
    Text = "Trạng thái@Prologue Lý thuyết tấn công"
  },
  State_2467_Name = {
    Text = "Trạng thái@Prologue Lý thuyết tấn công"
  },
  State_2467_WeaponDesc = {
    Text = "Trạng thái@Prologue Lý thuyết tấn công"
  },
  State_24680_Name = {
    Text = "Trạng thái @N phân thân 2 @ thì thầm 1 chuyển đổi trạng thái"
  },
  State_24681_Name = {
    Text = "Trạng thái @N của phân thân @nhăn nhở6 đã chuyển đổi"
  },
  State_24682_Name = {
    Text = "Trạng thái phân thân thứ 3 của @N lẩm bẩm 3 trạng thái chuyển đổi"
  },
  State_24683_Name = {
    Text = "Trạng thái @N của phân thân 2 @thì thầm 2 chuyển đổi trạng thái"
  },
  State_24684_Name = {
    Text = "Trạng thái @N của phân thân @N đã chuyển sang trạng thái thì thầm 4"
  },
  State_24685_Name = {
    Text = "Trạng thái @N của phân thân @nghen thứ 5 chuyển đổi trạng thái"
  },
  State_24686_Name = {
    Text = "Trạng thái @N phân thân 3 @ lẩm bẩm 5 đổi"
  },
  State_24687_Name = {
    Text = "Trạng thái @N của phân thân 3 @thì thầm 2 chuyển trạng thái"
  },
  State_24688_Name = {
    Text = "Trạng thái @N của phân thân 2 @ lẩm bẩm 6 lần chuyển trạng thái"
  },
  State_24689_Name = {
    Text = "Trạng thái @N phân thân 3 @ thì thầm 4 chuyển đổi trạng thái"
  },
  State_24690_Name = {
    Text = "Trạng thái @N của phân thân 3 @ lẩm bẩm 1 chuyển trạng thái"
  },
  State_24691_Name = {
    Text = "Trạng thái @N phân thân 2 @N thì thầm 4 chuyển đổi trạng thái"
  },
  State_24692_Name = {
    Text = "Trạng thái @N của phân thân 2 @ 3 trạng thái chuyển đổi"
  },
  State_24693_Name = {
    Text = "Trạng thái @N của phân thân @thì thầm 3 trạng thái chuyển đổi"
  },
  State_24694_Name = {
    Text = "Trạng thái @N của phân thân 2 @ lẩm bẩm 5 chuyển đổi trạng thái"
  },
  State_2470_Desc = {
    Text = "Khi nhặt, mất vĩnh viễn [Arg1] điểm giữ mình, sát thương chủ động gây ra nhận thêm gấp đôi lực lượng."
  },
  State_24719_Desc = {
    Text = "\"@2\"đã xuất hiện với tư cách được giải phóng, sức sống tăng gấp 3 lần."
  },
  State_24719_Name = {
    Text = "Phục hồi số phận"
  },
  State_24719_WeaponDesc = {
    Text = "Bắt đầu lượt tiếp theo nhận được lá chắn bằng với sức sống đã mất trong lượt trước."
  },
  State_2471_Desc = {
    Text = "Vào đầu lượt, đội ta giảm 1 giữ mình."
  },
  State_2471_Name = {
    Text = "bệnh rỉ sét"
  },
  State_2471_WeaponDesc = {
    Text = "Vào đầu lượt, đội ta giảm 1 giữ mình."
  },
  State_24720_Desc = {
    Text = "Lực lượng tồn tại chưa biết vẫn đang ẩn náu dưới hồ đen, sẽ hồi phục hoàn toàn và bắt đầu chiến đấu với tư thế được giải phóng ngay trước khi bị đánh bại."
  },
  State_24720_Name = {Text = "ẩn náu"},
  State_2472_Desc = {
    Text = "Đồng thời gây thương hại cho cả lá chắn và sức sống, và không thể bị miễn dịch."
  },
  State_2472_Name = {
    Text = "<PunctureDamagewords:thương xuyên>"
  },
  State_2472_WeaponDesc = {
    Text = "Thương tổn xuyên thủng bỏ qua lá chắn, giảm sát thương và cản trở của mục tiêu, gây thương trực tiếp."
  },
  State_24730_Desc = {
    Text = "Thêm không gian siêu việt tạm thời, giới hạn tối đa 10. Lần tiếp theo vào lượt siêu việt, các thẻ bài trong không gian này sẽ được đưa vào tay và không gian siêu việt tạm thời sẽ bị loại bỏ."
  },
  State_24730_Name = {
    Text = "<CardKeyWord:không gian siêu việt tạm thời>"
  },
  State_24737_Desc = {
    Text = "Vào đầu lượt, gây chảy máu cho đối phương, mỗi lớp Số Phận sẽ gây [StateArg1] điểm chảy máu"
  },
  State_24737_Name = {
    Text = "số phận"
  },
  State_24738_Desc = {
    Text = "Mỗi 1 tầng số phận khi có hiệu lực sẽ gây ra [StateArg1] điểm chảy máu, mỗi lần đánh ra 1 thẻ bài sẽ giảm 1 tầng số phận"
  },
  State_24738_Name = {
    Text = "số phận"
  },
  State_24739_Name = {
    Text = "số phận"
  },
  State_2473_Desc = {
    Text = "[Phòng thủ] Mất 1 râu chạm, hồi phục [StateArg1] sức sống. [Đánh] Mất [StateArg2] sức sống, tạo ra 1 râu chạm."
  },
  State_2473_Name = {
    Text = "Thịt máu của sinh vật bất tử sáng tạo"
  },
  State_2473_WeaponDesc = {
    Text = "[Phòng thủ] Mất 1 râu chạm, hồi phục [StateArg1] sức sống. [Đánh] Mất [StateArg2] sức sống, tạo ra 1 râu chạm."
  },
  State_2474_Desc = {
    Text = "Tăng [Layer]% sức tấn công."
  },
  State_2474_Name = {
    Text = "Tăng phần trăm sức tấn công"
  },
  State_2474_WeaponDesc = {
    Text = "Tăng [Layer]% sức tấn công."
  },
  State_2475_Desc = {
    Text = "Đội duy nhất: Sát thương chủ động gây ra bởi người trang bị tăng tương đương với tấn công của người trang bị <WeaponEffect_Num:[StateArg3]%>. Mỗi khi chơi hoặc bỏ 1 thẻ lệnh của người trang bị, sẽ gây <WeaponEffect_Num:[StateArg1]%> <IntoxicationIconKeywords:ngộ độc> cho kẻ địch ngẫu nhiên tương đương với tấn công của người trang bị. Sau khi kết thúc vòng Siêu Chiều, có <WeaponEffect_Num:[StateArg2]%> xác suất kích hoạt 100% ngộ độc cho tất cả kẻ địch."
  },
  State_2475_WeaponDesc = {
    Text = "Người trang bị gây sát thương chủ động tăng <WeaponEffect_Num:[DescArg2]> điểm. Mỗi lần chơi hoặc bỏ đi 1 thẻ lệnh của người trang bị, gây <WeaponEffect_Num:[DescArg1]> lớp<IntoxicationIconKeywords:ngộ độc> cho kẻ địch ngẫu nhiên. Sau khi kết thúc vòng Siêu Chiều, có <WeaponEffect_Num:[StateArg2]%> xác suất kích hoạt [DescArg3]% ngộ độc cho tất cả kẻ địch."
  },
  State_2476_Name = {
    Text = "Trạng thái - nguồn gốc tri thức khởi linh 1"
  },
  State_2478_Desc = {
    Text = "Lá chắn do Nautilus tạo ra được nhân đôi."
  },
  State_2478_Name = {
    Text = "thợ sửa chữa đại tài"
  },
  State_2478_WeaponDesc = {
    Text = "Lá chắn do Nautilus tạo ra được nhân đôi."
  },
  State_2479_Desc = {
    Text = "Lửa Xanh mỗi lần gây sát thương, số tầng +1"
  },
  State_2479_Name = {
    Text = "Số đếm Ngọc Bích Ảnh"
  },
  State_2479_WeaponDesc = {
    Text = "Lửa Xanh mỗi lần gây sát thương, số tầng +1"
  },
  State_2480_Desc = {
    Text = "Khi hồi sức sống, nhận [StateArg1] phản công. Mỗi lần Trầm Uyên Giả đánh ra 1 lá bài, hồi 1 điểm sức sống."
  },
  State_2480_Name = {
    Text = "Thân thể biến đổi"
  },
  State_2481_Desc = {
    Text = "Trạng thái@mở đầu đặt lại bộ bài 0_2_3_1"
  },
  State_2481_Name = {
    Text = "Trạng thái@mở đầu đặt lại bộ bài 0_2_3_1"
  },
  State_2481_WeaponDesc = {
    Text = "Trạng thái@mở đầu đặt lại bộ bài 0_2_3_1"
  },
  State_2482_Desc = {
    Text = "Sinh mệnh dưới 50% gọi ra một tam giác rỗng với lượng sức sống tương đương"
  },
  State_2482_Name = {Text = "gọi"},
  State_2482_WeaponDesc = {
    Text = "Sinh mệnh dưới 50% gọi ra một tam giác rỗng với lượng sức sống tương đương"
  },
  State_2486_Desc = {
    Text = "Mỗi khi bắt đầu lượt, nhận được 1 sức tính toán cho mỗi kẻ địch. Khi tiêu diệt kẻ địch bằng sát thương chủ động, gây chảy máu tương đương với sát thương dư thừa lên các kẻ địch khác."
  },
  State_24879_Desc = {
    Text = "Một nghìn năm trôi qua, mười nghìn năm trôi qua, chúng chờ đợi trong đống đổ nát vĩnh cửu. Sau khi chết, ngay lập tức giảm 1 lớp \"hỗn loạn\" của \"N\" và khiến \"N\" nhận được [DescArg1] điểm lá chắn và [DescArg2] điểm lực lượng."
  },
  State_24879_Name = {
    Text = "Phân Thân Ảo Giả"
  },
  State_2488_Desc = {
    Text = "Mỗi khi bạn sử dụng một \"Thẻ tăng ích\"/ \"Thẻ triệu chứng\"/\"Thẻ trạng thái\", thân thể được đánh thức có lượng điên cuồng thấp nhất sẽ nhận thêm 10 điểm điên cuồng."
  },
  State_2489_Desc = {
    Text = "Tỷ lệ chí mạng tăng 10%. Sau lần chí mạng đầu tiên mỗi lượt, tỷ lệ chí mạng tăng thêm 20%. Sau lần chí mạng thứ 3, thương harming chí mạng tăng thêm 50%."
  },
  State_2490_Desc = {
    Text = "Mỗi tầng tăng thêm 1 lần tấn công, mất một tầng khi nhận thương, mất toàn bộ khi kết thúc lượt."
  },
  State_2490_Name = {
    Text = "cầu nguyện"
  },
  State_2491_Desc = {
    Text = "Khi hồi máu, nhận được lượng lá chắn tương đương."
  },
  State_2491_Name = {
    Text = "Cứng tạm thời"
  },
  State_2492_Desc = {
    Text = "Mỗi lượt miễn nhiễm sát thương chủ động lần đầu."
  },
  State_2492_Name = {
    Text = "Kiên định"
  },
  State_2492_WeaponDesc = {
    Text = "Mỗi lượt miễn nhiễm sát thương chủ động lần đầu."
  },
  State_2493_Desc = {
    Text = "Thương chủ động gây ra giảm [Layer] điểm."
  },
  State_2493_Name = {
    Text = "sức mạnh giảm xuống"
  },
  State_2494_Desc = {
    Text = "Trạng thái@Mở đầu điên cuồng 0_1_4_1"
  },
  State_2494_Name = {
    Text = "Trạng thái@Mở đầu điên cuồng 0_1_4_1"
  },
  State_2494_WeaponDesc = {
    Text = "Trạng thái@Mở đầu điên cuồng 0_1_4_1"
  },
  State_2495_Desc = {
    Text = "Trạng thái@Chương mở đầu điên cuồng 0_1_4_2"
  },
  State_2495_Name = {
    Text = "Trạng thái@Chương mở đầu điên cuồng 0_1_4_2"
  },
  State_2495_WeaponDesc = {
    Text = "Trạng thái@Chương mở đầu điên cuồng 0_1_4_2"
  },
  State_24968_Desc = {
    Text = "Sau khi chiến đấu bắt đầu, Dung hợp Phôi thai +[Blood:DescArg2], mỗi lần kích hoạt kháng cự tử vong, Dung hợp Phôi thai +[Blood:DescArg2]. Mỗi khi Sorrel gây sát thương, sát thương của cô ấy trong lượt này sẽ tăng thêm [DescArg1] điểm."
  },
  State_24968_Name = {Text = "minh châu"},
  State_2496_Desc = {
    Text = "Vào đầu lượt, hồi phục [Arg1] sức sống. Nếu sức sống dưới 50%, hồi phục sức sống tăng lên [Arg2]."
  },
  State_2496_Name = {
    Text = "Huyết Ân Tứ"
  },
  State_24976_Desc = {
    Text = "\"Thiếu nữ Mặt trăng lồi\"đã thức tỉnh, cẩn thận với nguy hiểm từ món ăn đặc biệt!"
  },
  State_24976_Name = {
    Text = "Gia Lân thức tỉnh!"
  },
  State_24976_WeaponDesc = {
    Text = "Bắt đầu lượt tiếp theo nhận được lá chắn bằng với sức sống đã mất trong lượt trước."
  },
  State_24977_Desc = {
    Text = "Thân thể được đánh thức này chưa thức tỉnh… Khi sắp ngã gục sẽ thức tỉnh, hồi phục sức sống và bắt đầu chiến đấu với hình thái thật sự."
  },
  State_24977_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_2497_Desc = {
    Text = "Lily sẽ bắt chước thẻ lệnh được đánh ra đầu tiên của người chơi mỗi lượt. Nếu là thẻ đánh, số lần tấn công của Lily sẽ tăng thêm 1, nếu là thẻ phòng thủ, Lily sẽ nhận được 10% lá chắn sinh lực, nếu là thẻ lệnh khác, Lily cũng không biết chuyện gì sẽ xảy ra và sẽ bỏ một Pustula ở đây."
  },
  State_2497_Name = {
    Text = "Lily thức tỉnh!"
  },
  State_2497_WeaponDesc = {
    Text = "Bắt đầu lượt tiếp theo nhận được lá chắn bằng với sức sống đã mất trong lượt trước."
  },
  State_2498_Name = {
    Text = "Trang bị thỏ nguyền rủa"
  },
  State_2498_WeaponDesc = {
    Text = "Khi trang bị, tăng 6% hiệu quả tạo lá chắn và hồi sức sống. Nếu chỉ số giới vực của người trang bị lớn hơn 50, hiệu quả tạo lá chắn và hồi sức sống sẽ tăng thêm 6%."
  },
  State_2499_Name = {
    Text = "Lời nguyền trì trệ"
  },
  State_2500_Desc = {
    Text = "Mỗi lần gây thương thực tế, thêm trạng thái trúng độc."
  },
  State_2500_Name = {
    Text = "Độc tố"
  },
  State_2501_Desc = {
    Text = "Đội duy nhất: Giới hạn sức sống của đội tăng 10%. Hiệu ứng chữa trị và lá chắn do người trang bị tạo ra tăng <WeaponEffect_Num:[StateArg3]%>. Sau khi thực hiện \"tấn công\" của người trang bị, hồi <WeaponEffect_Num:[StateArg1]%> sức sống đã mất. Sau khi thực hiện \"phòng thủ\" của người trang bị, nhận lá chắn bằng <WeaponEffect_Num:[StateArg2]%> sức sống hiện tại. Hiệu ứng này mỗi lượt chỉ có thể kích hoạt tối đa 1 lần."
  },
  State_2501_Name = {
    Text = "linh hồn sinh ra"
  },
  State_2501_WeaponDesc = {
    Text = "Giới hạn máu của đội hình tăng 10%. Người trang bị gây ra chữa trị và lá chắn tăng <WeaponEffect_Num:[StateArg3]%>. Sau khi đánh ra \"đánh\" của người trang bị, hồi [StateArg1]%(<WeaponEffect_Num:[Heal:DescArg1]>) sức sống đã mất. Sau khi đánh ra \"phòng thủ\" của người trang bị, nhận được [StateArg1]%(<WeaponEffect_Num:[Block:DescArg2]>) lá chắn dựa trên sức sống hiện tại. Hiệu ứng này mỗi lượt tối đa kích hoạt 1 lần."
  },
  State_2502_Desc = {
    Text = "Giảm Sát thương chủ động và thương tổn xúc tu gây ra 50 %."
  },
  State_2502_Name = {
    Text = "Yếu đuối tịch diệt"
  },
  State_2502_WeaponDesc = {
    Text = "Tất cả sát thương gây ra đều giảm 50%."
  },
  State_2503_Desc = {
    Text = "Đội duy nhất: thương gây ra bởi thẻ bài của người trang bị tăng lên <WeaponEffect_Num:[StateArg1]%>. Đầu mỗi lượt, có <WeaponEffect_Num:[StateArg2]%> cơ hội thêm thẻ ngẫu nhiên vào tay bài. Nếu giới vực hiện tại là \"thịt máu\", khi sử dụng \"phôi thai\" cho người trang bị, tăng tỷ lệ chí mạng đòn đánh tiếp theo trong lượt lên <WeaponEffect_Num:+[StateArg3]%>."
  },
  State_2503_WeaponDesc = {
    Text = "Trang bị tăng cường sát thương cơ bản của thẻ bài là <WeaponEffect_Num:[StateArg1]%>. Vào đầu lượt, có <WeaponEffect_Num:[StateArg2]%> xác suất tạo ra một thẻ ngẫu nhiên của trang bị vào bộ bài, kèm theo tiêu thụ. Nếu giới vực hiện tại là \"thịt máu\", khi sử dụng \"phôi thai\" cho trang bị, tăng tỷ lệ chí mạng của đòn đánh tiếp theo trong lượt này của trang bị lên <WeaponEffect_Num:+[StateArg3]%>."
  },
  State_2504_Desc = {
    Text = "\"đánh\" nhận được 2 điểm sức tính toán, bỏ ngẫu nhiên 1 lá bài; \"phòng thủ\" rút 2 lá bài, mất 1 điểm sức tính toán."
  },
  State_25056_Desc = {
    Text = "Mỗi lần tiêu thụ sức tính toán, Gia Lân sẽ nhận được [Layer] điểm sức mạnh tạm thời"
  },
  State_25056_Name = {
    Text = "Đã no và đã uống đủ"
  },
  State_25057_Desc = {
    Text = "Mỗi lần tiêu thụ sức tính toán, Gia Lân sẽ nhận được [StateArg1] điểm lực lượng tạm thời. Xóa 1 tầng vào cuối lượt."
  },
  State_25057_Name = {
    Text = "Đã no và đã uống đủ"
  },
  State_2505_Name = {
    Text = "Phụ kiện Quà tháng Tư"
  },
  State_2505_WeaponDesc = {
    Text = "Sau khi chiến đấu bắt đầu, nếu nghề nghiệp của kẻ sở hữu là siêu việt, sức tấn công tăng 25%."
  },
  State_2507_Desc = {
    Text = "Khi nhặt được, tăng máu tối đa 100%, đầu mỗi lượt, mất [Arg1] điểm sức sống."
  },
  State_2509_Name = {
    Text = "Trạng thái@thành thạo giới vực phổ thông"
  },
  State_2511_Desc = {
    Text = "Trạng thái@Hướng dẫn khóa năng lượng Chương mở đầu"
  },
  State_2511_Name = {
    Text = "Trạng thái@Hướng dẫn khóa năng lượng Chương mở đầu"
  },
  State_2511_WeaponDesc = {
    Text = "Trạng thái@Chương đầu Đặt lại bộ bài0_1_2_2"
  },
  State_2512_Desc = {
    Text = "Khi đánh 1 thẻ bài có tiêu thụ sức tính toán là 3 hoặc cao hơn, rút 1 thẻ bài, nhận 1 điểm sức tính toán."
  },
  State_2514_Desc = {
    Text = "Trong trận chiến này, lá chắn bị giảm [Layer] điểm."
  },
  State_2514_Name = {
    Text = "Giảm cảnh giác"
  },
  State_2514_WeaponDesc = {
    Text = "Trong trận chiến này, lá chắn bị giảm [Layer] điểm."
  },
  State_2515_Desc = {
    Text = "[Đánh] áp dụng [StateArg1] lớp trúng độc lên tất cả kẻ địch."
  },
  State_2515_Name = {
    Text = "Tạo hóa chất độc thần kinh"
  },
  State_25163_Desc = {
    Text = "Ngài như sương mù, khó mà nắm bắt."
  },
  State_25163_Name = {
    Text = "Bóng của quá khứ"
  },
  State_25165_Desc = {
    Text = "Hiệu ứng bổ sung độc đáo của thẻ lệnh Vòng tròn · Ramona, được kích hoạt khi có 3 lớp entropy âm. Hiệu ứng Vòng sẽ được kế thừa sang trận chiến tiếp theo."
  },
  State_25165_Name = {
    Text = "<TimeBeacon:vòng lặp>"
  },
  State_25166_Desc = {
    Text = "Mỗi khi có 3 lớp entropy âm, khi sử dụng thẻ lệnh Vòng tròn · Ramona sẽ tiêu thụ hết entropy âm. Đồng thời, hiệu ứng phụ của vòng lặp sẽ được kích hoạt. Entropy âm tối đa có thể tích lũy đến 3 lớp."
  },
  State_25166_Name = {
    Text = "<TimeBeacon2:entropy âm>"
  },
  State_2516_Desc = {
    Text = "Không thể được chơi ra."
  },
  State_2516_Name = {
    Text = "Không thể đánh ra"
  },
  State_2516_WeaponDesc = {
    Text = "Thẻ bài không thể chơi."
  },
  State_25179_Name = {
    Text = "Sự phán xét điên cuồng"
  },
  State_2517_Desc = {
    Text = "Đội của tôi kích hoạt Điên Cuồng Bùng Phát, bản thân mất sức mạnh trong lượt này. Một lần mỗi lượt."
  },
  State_2517_Name = {
    Text = "Sợ hãi điên cuồng"
  },
  State_25181_Name = {
    Text = "Hiệu ứng bảo tồn luân hồi"
  },
  State_2518_Desc = {
    Text = "Trạng thái@phần mở đầu đặt lại bộ bài 0_1_1_3"
  },
  State_2518_Name = {
    Text = "Trạng thái@phần mở đầu đặt lại bộ bài 0_1_1_3"
  },
  State_2518_WeaponDesc = {
    Text = "Trạng thái@phần mở đầu đặt lại bộ bài 0_1_1_3"
  },
  State_25194_Desc = {
    Text = "Sau khi chết, tăng [DescArg1] điểm lá chắn và [DescArg2] điểm lực lượng vĩnh viễn cho \"N\""
  },
  State_2519_Desc = {
    Text = "Trạng thái@phần mở đầu đặt lại bộ bài 0_1_1_3"
  },
  State_2519_Name = {
    Text = "Trạng thái@phần mở đầu đặt lại bộ bài 0_1_1_3"
  },
  State_2519_WeaponDesc = {
    Text = "Trạng thái@phần mở đầu đặt lại bộ bài 0_1_1_3"
  },
  State_25204_Name = {
    Text = "Trạng thái @N của bản sao số 2 @phán đoán ý định"
  },
  State_25205_Name = {
    Text = "Trạng thái@N của phân thân 3@xác định ý định"
  },
  State_25206_Name = {
    Text = "Trạng thái@N@thêm đánh giá phân thân của N"
  },
  State_25207_Name = {
    Text = "Trạng thái phân thân @N đánh giá ý định"
  },
  State_2520_Desc = {
    Text = "Trạng thái@phần mở đầu đặt lại bộ bài 0_1_1_2"
  },
  State_2520_Name = {
    Text = "Trạng thái@phần mở đầu đặt lại bộ bài 0_1_1_2"
  },
  State_2520_WeaponDesc = {
    Text = "Trạng thái@phần mở đầu đặt lại bộ bài 0_1_1_2"
  },
  State_2522_Desc = {
    Text = "Hiro đã thức tỉnh, cường độ tấn công và khát khao đều sẽ được tăng cường."
  },
  State_2522_Name = {
    Text = "Thức tỉnh của Hiro"
  },
  State_2523_Desc = {
    Text = "Vào đầu các lượt lẻ, nhận [Arg1] lực lượng. Vào đầu các lượt chẵn, nhận [Arg2] điểm giữ mình."
  },
  State_2524_Desc = {
    Text = "Khi trận chiến bắt đầu, nhận được 1 sức mạnh"
  },
  State_2524_Name = {
    Text = "Tên tuổi vang xa"
  },
  State_2525_Desc = {
    Text = "Giảm 1 lần tấn công, nhận được [Layer] điểm lực lượng"
  },
  State_2525_Name = {
    Text = "Dissipation"
  },
  State_2527_Name = {
    Text = "Phần thưởng sức mạnh màu đỏ thẫm"
  },
  State_2528_Desc = {
    Text = "Khi đánh 1 thẻ bài tiêu thụ 3 sức tính toán, rút 1 thẻ bài và nhận 2 sức tính toán"
  },
  State_2529_Desc = {
    Text = "Trong lượt này, sát thương chí mạng tăng [Layer]%."
  },
  State_2529_Name = {
    Text = "Sát thương bạo kích tạm thời"
  },
  State_2529_WeaponDesc = {
    Text = "Trong lượt này, sát thương chí mạng tăng [Layer]%."
  },
  State_2531_Desc = {
    Text = "Lửa xanh mỗi lần gây [Damage:StateArg2] lần thương, sẽ nhận được một lá bài tiêu thụ [Ngọn lửa xanh]."
  },
  State_2531_Name = {
    Text = "Hình ảnh ngọc bích"
  },
  State_2531_WeaponDesc = {
    Text = "Lửa xanh mỗi lần gây [Damage:StateArg2] lần thương, sẽ nhận được một lá bài tiêu thụ [Ngọn lửa xanh]."
  },
  State_2532_Name = {
    Text = "Phụ kiện Dấu Hiệu Đỏ Thẫm"
  },
  State_2534_Desc = {
    Text = "Trạng thái - chương mở đầu đặt lại bộ bài 0_1_3_3"
  },
  State_2534_Name = {
    Text = "Trạng thái - chương mở đầu đặt lại bộ bài 0_1_3_3"
  },
  State_2534_WeaponDesc = {
    Text = "Trạng thái - chương mở đầu đặt lại bộ bài 0_1_3_3"
  },
  State_2535_Desc = {
    Text = "Trạng thái@phần mở đầu đặt lại bộ bài 0_1_3_2"
  },
  State_2535_Name = {
    Text = "Trạng thái@phần mở đầu đặt lại bộ bài 0_1_3_2"
  },
  State_2535_WeaponDesc = {
    Text = "Trạng thái@phần mở đầu đặt lại bộ bài 0_1_3_2"
  },
  State_2536_Name = {
    Text = "Trạng thái @Tăng sát thương chí mạng của thẻ đánh tạm thời"
  },
  State_2537_Desc = {
    Text = "Khi Kiếm Hư Không áp dụng lá chắn, nhận được [StateArg2] điểm phòng thủ tạm thời."
  },
  State_2537_Name = {
    Text = "Nhìn thấu chiến trường"
  },
  State_2537_WeaponDesc = {
    Text = "Khi Kiếm Hư Không áp dụng lá chắn, nhận được [StateArg2] điểm phòng thủ tạm thời."
  },
  State_2538_Desc = {
    Text = "Đánh ra sau đó nhận được [StateArg1] lớp phản công, gây [StateArg2]% <FixedDamage:Sát Thương Thuần Túy> phản công lên tất cả kẻ địch."
  },
  State_2538_Name = {
    Text = "<Rune_9_High:nâng cao gai>"
  },
  State_25391_Desc = {
    Text = "Đội đã chọn một thân thể được đánh thức làm \"khán giả may mắn\", tất cả các thẻ bài của thân thể này có hiệu ứng \"reo hò\"."
  },
  State_25391_Name = {
    Text = "Khán giả may mắn"
  },
  State_25392_Desc = {
    Text = "Sau khi sử dụng, mất 2% máu tối đa, Đại Ma Thuật Sư nhận được 1 tầng \"Tự Tin\" trong lượt này."
  },
  State_25392_Name = {
    Text = "<CardCheerKeywords:hoan hô>"
  },
  State_25401_Desc = {
    Text = "Khi giữ thẻ bài này trong tay, giới hạn bài trong tay sẽ tăng thêm +1."
  },
  State_25401_Name = {
    Text = "Bỏ qua giới hạn bài trên tay"
  },
  State_25403_Desc = {
    Text = "Thương tổn râu chạm giảm 50%, mỗi lần gây thương tổn râu chạm nhận được [Layer] điểm lá chắn."
  },
  State_25403_Name = {
    Text = "Biển Lặng"
  },
  State_25405_Desc = {
    Text = "Thẻ bài này sẽ luôn xuất hiện trong tay của bạn."
  },
  State_25405_Name = {
    Text = "Giữ vĩnh viễn"
  },
  State_25406_Desc = {
    Text = "Không thể chuyển sang dạng râu chạm trong lượt này"
  },
  State_25406_Name = {
    Text = "Điên rồ biển sâu·Hạn chế"
  },
  State_25407_Desc = {
    Text = "Thương tổn xúc tu tăng 25%, số lượng xúc tu giảm 1 khi kết thúc lượt."
  },
  State_25407_Name = {
    Text = "Điên rồ biển sâu"
  },
  State_25415_Desc = {
    Text = "Sau khi giải phóng lệnh khóa, nhận được [Layer] điểm khóa năng."
  },
  State_25415_Name = {
    Text = "Khóa tạm thời hỗn loạn đạt tới mức năng lượng dồi dào"
  },
  State_25417_Name = {Text = "Bom 3"},
  State_25418_Name = {Text = "Bom 2"},
  State_2542_Name = {
    Text = "Số lượng chi phụ của sáng tạo không tên"
  },
  State_2543_Name = {
    Text = "Trạng thái@vòng 2_14 chiến đấu 8 bong bóng 1"
  },
  State_2544_Desc = {
    Text = "Trạng thái @Chương đầu quái vật hiệu ứng trạng thái"
  },
  State_2544_Name = {
    Text = "Trạng thái @Chương đầu quái vật hiệu ứng trạng thái"
  },
  State_2544_WeaponDesc = {
    Text = "Trạng thái @Chương đầu quái vật hiệu ứng trạng thái"
  },
  State_2545_Desc = {
    Text = "Khi trận chiến bắt đầu, phôi hợp tử +20%. Mỗi khi có một thân thể được đánh thức đạt đến mức điên cuồng tối đa, phôi hợp tử tăng thêm +20%."
  },
  State_2547_Desc = {
    Text = "Vào đầu lượt, thêm một lá \"dòng nĩa\" có lực lượng [Arg1] trong lượt này vào tay. Sau khi phát động cơn thịnh nộ bùng phát, tăng lực lượng của tất cả các lá \"dòng nĩa\" trong tay lên [Arg2]."
  },
  State_2548_Desc = {
    Text = "Miễn dịch một lần chết, sau khi kích hoạt sẽ hồi phục 50 sức sống và khiến sáng tạo này mất hiệu lực vĩnh viễn."
  },
  State_2548_Name = {
    Text = "Búp bê sáng tạo"
  },
  State_2548_WeaponDesc = {
    Text = "Miễn dịch một lần chết, sau khi kích hoạt sẽ hồi phục 50 sức sống và khiến sáng tạo này mất hiệu lực vĩnh viễn."
  },
  State_2549_Desc = {
    Text = "Giảm thương chủ động và thương tổn râu chạm."
  },
  State_2549_Name = {
    Text = "<ExhaustionIconKeywords: Giảm sức mạnh>"
  },
  State_2549_WeaponDesc = {
    Text = "Mỗi tầng suy yếu làm giảm 1 điểm thương và thương tổn râu chạm."
  },
  State_2550_Desc = {
    Text = "Khi rút được sẽ làm bản thân yếu đuối 1 lượt. Sau khi sử dụng, sẽ làm tăng sát thương cho tất cả kẻ địch 1 lượt. Không thể bán."
  },
  State_2550_Name = {
    Text = "Trạng thái sự sụp đổ của lời nguyền"
  },
  State_2550_WeaponDesc = {
    Text = "Khi rút được sẽ làm bản thân yếu đuối 1 lượt. Sau khi sử dụng, sẽ làm tăng sát thương cho tất cả kẻ địch 1 lượt. Không thể bán."
  },
  State_2552_Desc = {
    Text = "Thẻ bài sẽ không được đưa vào rác bài trong giai đoạn bỏ bài, mà sẽ được giữ lại trong tay bài."
  },
  State_2552_Name = {
    Text = "<RetainIconKeywords:giữ lại>"
  },
  State_2552_WeaponDesc = {
    Text = "Thẻ bài sẽ không được đưa vào rác bài trong giai đoạn bỏ bài, mà sẽ được giữ lại trong tay bài."
  },
  State_2553_Desc = {
    Text = "Khi lượt bắt đầu, nhận một điểm sức tính toán"
  },
  State_2553_Name = {
    Text = "Sức tính toán sáng tạo Alcana"
  },
  State_2553_WeaponDesc = {
    Text = "Khi lượt bắt đầu, nhận một điểm sức tính toán"
  },
  State_2554_Name = {
    Text = "Nhật báo buổi sáng Putney"
  },
  State_2556_Desc = {
    Text = "Sau khi máu giảm, nhận được lá chắn, tương đương với [Layer] % giá trị đã giảm."
  },
  State_2556_Name = {
    Text = "lá chắn máu"
  },
  State_2556_WeaponDesc = {
    Text = "Sau khi máu giảm, nhận được lá chắn, tương đương với [Layer] % giá trị đã giảm"
  },
  State_2557_Desc = {
    Text = "Khi lượt mới bắt đầu, nhận [Layer] điểm lá chắn."
  },
  State_2557_Name = {
    Text = "Lá chắn đau khổ và hạnh phúc"
  },
  State_2558_Desc = {
    Text = "Khi sức sống dưới 50%([StateArg1]), sẽ phân chia thành 2 \"thân thể bị ăn mòn loại can thiệp\" có lượng sức sống bằng nhau."
  },
  State_2558_Name = {Text = "Phân chia"},
  State_2558_WeaponDesc = {
    Text = "Khi sức sống dưới 50%([StateArg1]), nó sẽ phân chia thành 2 \"thân thể bị ăn mòn loại II\" có lượng sức sống bằng nhau."
  },
  State_2559_Desc = {
    Text = "Mỗi lần sau khi bị tấn công, mất [Layer] điểm lực lượng tạm thời."
  },
  State_2559_Name = {
    Text = "Giá của sự xung động"
  },
  State_2560_Desc = {
    Text = "Sau khi bắt đầu lượt tiếp theo, nhận được [Layer] lá chắn."
  },
  State_2560_Name = {
    Text = "Sáng tạo đóng"
  },
  State_2560_WeaponDesc = {
    Text = "Sau khi bắt đầu lượt tiếp theo, nhận được [Layer] lá chắn."
  },
  State_2561_Desc = {
    Text = "Tài năng u uất"
  },
  State_2561_Name = {
    Text = "Tài năng u uất"
  },
  State_2561_WeaponDesc = {
    Text = "Tài năng u uất"
  },
  State_2562_Name = {
    Text = "Trạng thái@Chương ba_cảm ứng 1_Dấu hiệu"
  },
  State_2563_Desc = {
    Text = "Mỗi khi đánh ra lá bài thứ 10, tăng 2 thương tổn xúc tu, khiến tất cả râu chạm thực hiện một đợt tấn công."
  },
  State_2563_Name = {
    Text = "Dòng nĩa sáng tạo"
  },
  State_2563_WeaponDesc = {
    Text = "Mỗi khi đánh ra lá bài thứ 10, tăng 2 thương tổn xúc tu, khiến tất cả râu chạm thực hiện một đợt tấn công."
  },
  State_2564_Desc = {
    Text = "Tất cả các lá chắn nhận được giảm [DescArg1] %."
  },
  State_2564_Name = {
    Text = "<FragileColour:yếu đuối>"
  },
  State_2564_WeaponDesc = {
    Text = "Tất cả các lá chắn nhận được đều giảm 33%."
  },
  State_2565_Name = {
    Text = "Đồ trang sức Sự Ôm Ấp Đỏ Thẫm"
  },
  State_2565_WeaponDesc = {
    Text = "Khi người dùng gây sát thương, nhận được 20 điểm năng lượng chìa khóa bạc; nếu gây sát thương chí mạng, nhận được 50 điểm năng lượng chìa khóa bạc. Mỗi lượt tối đa kích hoạt 3 lần."
  },
  State_2566_Desc = {
    Text = "Sau khi bị tấn công 3 lần trong một vòng, nhận 1 lớp tạm thời <MadnessColour:điên rồ>."
  },
  State_2566_Name = {
    Text = "\"nỗi đau ngọt ngào\""
  },
  State_2567_Desc = {
    Text = "Đã nhận [Layer] lần thương, sau khi đạt 3 lần \"Quỷ Ngọt Ngào\" nhận 1 lớp <MadnessColour:điên rồ> trong vòng này."
  },
  State_2567_Name = {
    Text = "Số lần Đau Ngọt"
  },
  State_2567_WeaponDesc = {
    Text = "Đã nhận [Layer] lần thương, sau khi đạt 3 lần, \"Ác Quỷ Ngọt Ngào\" sẽ nhận được 1 lớp điên rồ trong lượt này."
  },
  State_2569_Desc = {
    Text = "Tăng cường hiệu ứng đề xuất giới vực lên 50%, khi bắt đầu cấp độ, sự thạo giới vực của bạn tăng 100%."
  },
  State_2569_Name = {
    Text = "Trạng thái @Chìa Khóa Bạc Mộng Ảo: Phân Liệt"
  },
  State_2570_Desc = {
    Text = "Sau khi đánh, rút [StateArg1] lá bài."
  },
  State_2570_Name = {
    Text = "<Rune_3:điêu luyện>"
  },
  State_2571_Desc = {
    Text = "Trong đội hình, cứ có một thân thể được đánh thức thuộc nghề nghiệp [hỗn loạn], toàn đội sẽ tăng 50% máu tối đa (chưa hoàn thành), phòng thủ và tấn công"
  },
  State_2571_Name = {
    Text = "Phụ gia hỗn loạn"
  },
  State_2571_WeaponDesc = {
    Text = "Trong đội hình, cứ có một thân thể được đánh thức thuộc nghề nghiệp [hỗn loạn], toàn đội sẽ tăng 50% máu tối đa (chưa hoàn thành), phòng thủ và tấn công"
  },
  State_2572_Desc = {
    Text = "Sau khi đánh ra, phôi hợp tử +[StateArg1]."
  },
  State_2572_Name = {
    Text = "<Rune_12:khát máu>"
  },
  State_2573_Desc = {
    Text = "Có 5 tầng [Dây dẫn]. Sau khi đánh ra thẻ bài, số tầng giảm đi 1. Khi số tầng giảm về 0, nó sẽ tự nổ và gây sát thương bằng 2.5 lần sức tấn công."
  },
  State_2573_Name = {Text = "Bom nổ"},
  State_2573_WeaponDesc = {
    Text = "Có 5 tầng [Dây dẫn]. Sau khi đánh ra thẻ bài, số tầng giảm đi 1. Khi số tầng giảm về 0, nó sẽ tự nổ và gây sát thương bằng 2.5 lần sức tấn công."
  },
  State_2574_Desc = {
    Text = "Thương chí mạng +50%. Nếu lượt này không tấn công, lượt sau chắc chắn chí mạng."
  },
  State_2574_Name = {
    Text = "Trạng thái @chìa khóa bạc ảo mộng: Luân Vũ"
  },
  State_2575_Desc = {
    Text = "Đội duy nhất: Khi bắt đầu trận đấu, mỗi khi sở hữu một di vật sẽ làm tăng tỷ lệ chí mạng của thẻ lệnh người trang bị thêm [StateArg1]%. Sau khi người trang bị phát động cơn thịnh nộ bùng nổ, họ sẽ ném một viên xúc xắc 4 mặt, nhận được <WeaponEffect_Num:[StateArg2]> lần số điểm xúc xắc thành điên cuồng và sát thương chí mạng tạm thời. Nếu họ ném được 4 điểm trở lên, các thể thức tỉnh khác cũng sẽ nhận được một nửa."
  },
  State_2575_WeaponDesc = {
    Text = "Khi bắt đầu trận chiến, mỗi khi sở hữu một di vật sẽ làm tăng tỉ lệ chí mạng của thẻ lệnh người trang bị thêm [StateArg1]%. Sau khi người trang bị phát động cơn thịnh nộ bùng nổ, họ sẽ ném một viên xúc xắc 4 mặt, nhận được <WeaponEffect_Num:[StateArg2]> lần số điểm xúc xắc của điên cuồng và sát thương chí mạng tạm thời, nếu họ ném được 4 điểm trở lên, các thể thức tỉnh khác cũng sẽ nhận được một nửa."
  },
  State_2576_Desc = {
    Text = "Mỗi khi một thẻ bài vào không gian siêu việt, giảm 1 điểm tiêu thụ sức tính toán của nó."
  },
  State_2579_Desc = {
    Text = "Tăng số lần Sát thương chủ động gây ra trong lượt này thêm [Layer] ."
  },
  State_2579_Name = {
    Text = "<MadnessColour:Tạm thời điên rồ>"
  },
  State_2580_Desc = {
    Text = "Mỗi khi thẻ bài của Sát Thủ Đầu Sọ vào hoặc ra khỏi không gian siêu việt, nhận được 1 sức tính toán."
  },
  State_2580_Name = {
    Text = "Chiếu chiều"
  },
  State_2581_Desc = {
    Text = "Tất cả thân thể được đánh thức sạc chìa khóa bạc tăng 30. Sau khi phát hành lệnh khóa, trộn 3 thẻ <DerivativeCardKeywords_4:「cảm hứng」> vào bộ bài của bạn."
  },
  State_2581_Name = {
    Text = "Trạng thái @ bàn lắc thời linh tất cả"
  },
  State_2582_Desc = {
    Text = "Người trang bị gây sát thương, tạo lá chắn và tăng hiệu ứng chữa trị [StateArg1]%. (tạm thời)"
  },
  State_2582_Name = {
    Text = "Trạng thái@pháo laser thử nghiệm điên cuồng"
  },
  State_2583_Desc = {
    Text = "Mỗi lần bị sát thương chủ động, tăng một lớp cộng dồn cho đội của tôi"
  },
  State_2583_Name = {
    Text = "Trạng thái@lưỡi kiếm trả thù cắt đầu trọng thương"
  },
  State_2583_WeaponDesc = {
    Text = "Mỗi lần bị sát thương chủ động, tăng một lớp cộng dồn cho đội của tôi"
  },
  State_2584_Desc = {
    Text = "Mỗi lần bộ bài được đặt lại, nhận [Arg1] sức mạnh."
  },
  State_2586_Desc = {
    Text = "Tất cả lá chắn nhận được giảm 25 %, xóa bỏ 1 lớp vào cuối lượt."
  },
  State_2586_Name = {
    Text = "<FragileIconKeywords: yếu đuối>"
  },
  State_2586_WeaponDesc = {
    Text = "Tất cả các lá chắn nhận được sẽ giảm 25%."
  },
  State_2587_Desc = {
    Text = "Thương tổn vết thương tăng gấp đôi. Mỗi lần gây sát thương thực tế, sẽ nhận được [Layer] điểm lá chắn."
  },
  State_2587_Name = {
    Text = "\"Răng Sắt Thiên Sát\""
  },
  State_2587_WeaponDesc = {
    Text = "Thương tổn vết thương tăng gấp đôi. Mỗi lần gây sát thương thực tế, sẽ nhận được [Layer] điểm lá chắn."
  },
  State_2588_Desc = {
    Text = "Sau khi kết thúc lượt, nhận [Layer] điểm <FixedDamage:Sát Thương Thuần Túy> và xóa Trạng thái này. Khi Hồi phục sinh lực, xóa số lớp Chảy máu gấp đôi lượng hồi phục."
  },
  State_2588_Name = {
    Text = "Mãi mãi<BleedingColour: chảy máu>"
  },
  State_2588_WeaponDesc = {
    Text = "Sau khi lượt kết thúc, nhận [Layer] điểm thương và loại bỏ trạng thái này, mỗi lần chữa trị giảm một nửa số tầng."
  },
  State_2589_Name = {
    Text = "Trang sức song sinh méo mó đen"
  },
  State_2589_WeaponDesc = {
    Text = "Sau khi bắt đầu lượt lẻ, thêm một 「Đòn đánh」 của người trang bị có thuộc tính 「Hư vô」 và 「Tiêu thụ」 vào tay."
  },
  State_2590_Desc = {
    Text = "Khi di chuyển, nhận 10 dấu đen"
  },
  State_2590_Name = {
    Text = "Túi vô đáy của Sáng tạo"
  },
  State_2590_WeaponDesc = {
    Text = "Khi di chuyển, nhận 10 dấu đen"
  },
  State_2592_Desc = {
    Text = "Mỗi khi mất 1 điểm sức sống sẽ loại bỏ 1 lớp, khi hết lớp sẽ nhận được [DescArg1] lá chắn."
  },
  State_2592_Name = {
    Text = "Rào cản chiều"
  },
  State_2593_Name = {
    Text = "Trạng thái @Bài Ca của Máu Đỏ và Cát"
  },
  State_2594_Desc = {
    Text = "Gây thương thực sự nhận được lá chắn"
  },
  State_2594_Name = {
    Text = "\"Răng Sắt Thiên Sát\""
  },
  State_2594_WeaponDesc = {
    Text = "Gây thương thực sự nhận được lá chắn"
  },
  State_2595_Desc = {
    Text = "Mỗi lần gây sát thương, nhận được [StateArg2] điểm lực lượng tạm thời."
  },
  State_2595_Name = {
    Text = "Kiếm của Nữ hoàng"
  },
  State_2597_Desc = {
    Text = "Sau khi bắt đầu lượt, được cấp [Layer] điểm lá chắn."
  },
  State_2597_Name = {
    Text = "Lá chắn trễ"
  },
  State_2597_WeaponDesc = {
    Text = "Sau khi bắt đầu lượt, được cấp [Layer] điểm lá chắn."
  },
  State_2600_Desc = {
    Text = "Mỗi khi bạn mất sức sống, thân thể được đánh thức có mức điên cuồng thấp nhất nhận 10 điên cuồng. Mỗi khi bạn mất 5 lần sức sống, nhận được 1 lớp rào cản."
  },
  State_2600_Name = {
    Text = "Linh Bài Thời Gian \"Giải Tích\""
  },
  State_2601_Desc = {
    Text = "Số lượt chẵn, giảm 50% sát thương nhận vào, tăng 33% sát thương gây ra."
  },
  State_2601_Name = {
    Text = "Biến đổi"
  },
  State_2601_WeaponDesc = {
    Text = "Số lượt chẵn, giảm 50% sát thương nhận vào, tăng 33% sát thương gây ra."
  },
  State_2602_Desc = {
    Text = "Bạn đã bị khóa! Sau khi đánh ra, Eternal Fanatic nhận được [StateArg1] điểm lực lượng tạm thời và xóa dấu ấn Deep One của lệnh này."
  },
  State_2602_Name = {
    Text = "<CardKeyWord:dấu ấn lặn sâu>"
  },
  State_2602_WeaponDesc = {
    Text = "Sau khi đánh thẻ bài, Tinh Anh Lặn Sâu nhận được [StateArg1] điểm lực lượng tạm thời."
  },
  State_2603_Desc = {
    Text = "Nếu trong bài trên tay có \"phôi thai\", tiêu thụ tất cả \"phôi thai\", mỗi 1 lá phôi thai kích hoạt 1 lần hiệu ứng sau."
  },
  State_2603_Name = {
    Text = "<UnlimitedDevouredIconKeywords:tiêu thụ vô hạn>"
  },
  State_2604_Desc = {
    Text = "Trong vòng này tỷ lệ chí mạng tăng [Layer] %."
  },
  State_2604_Name = {
    Text = "Tỷ lệ chí mạng tạm thời"
  },
  State_2604_WeaponDesc = {
    Text = "Trong vòng này tỷ lệ chí mạng tăng [Layer] %."
  },
  State_2605_Desc = {
    Text = "Khi sức sống dưới 95%([StateArg1]) sẽ phân chia thành 2 con \"thí nghiệm bài tập\" có lượng sức sống bằng nhau."
  },
  State_2605_Name = {Text = "Phân chia"},
  State_2605_WeaponDesc = {
    Text = "Khi sức sống dưới 30%([StateArg1]), sẽ phân chia thành 3 \"thân thể bị ăn mòn bình tượng nến loại II\" có lượng sức sống bằng nhau."
  },
  State_2606_Desc = {
    Text = "Khi sức sống dưới 90%([StateArg1]), sẽ phân chia thành 2 con \"thí nghiệm bài tập\" có lượng sức sống bằng nhau."
  },
  State_2606_Name = {Text = "Phân chia"},
  State_2606_WeaponDesc = {
    Text = "Khi sức sống dưới 30%([StateArg1]), sẽ phân chia thành 3 \"thân thể bị ăn mòn bình tượng nến loại II\" có lượng sức sống bằng nhau."
  },
  State_2607_Desc = {
    Text = "Khi chiến đấu kết thúc, hồi phục 5 sức sống."
  },
  State_2607_Name = {
    Text = "Nữ Thị Nữ Trăng Lồi Khởi Linh 3"
  },
  State_2607_WeaponDesc = {
    Text = "Khi chiến đấu kết thúc, hồi phục 5 sức sống."
  },
  State_2609_Desc = {
    Text = "Khi sức sống dưới 30%([StateArg1]), sẽ phân chia thành 2 \"bài tập thí nghiệm\" có lượng sức sống bằng nhau."
  },
  State_2609_Name = {Text = "Phân chia"},
  State_2609_WeaponDesc = {
    Text = "Khi sức sống dưới 30%([StateArg1]), sẽ phân chia thành 3 \"thân thể bị ăn mòn bình tượng nến loại II\" có lượng sức sống bằng nhau."
  },
  State_2610_Desc = {
    Text = "Khi sức sống dưới 70%([StateArg1]), sẽ phân chia thành 2 con \"thí nghiệm bài tập\" có lượng sức sống bằng nhau."
  },
  State_2610_Name = {Text = "Phân chia"},
  State_2610_WeaponDesc = {
    Text = "Khi sức sống dưới 30%([StateArg1]), sẽ phân chia thành 3 \"thân thể bị ăn mòn bình tượng nến loại II\" có lượng sức sống bằng nhau."
  },
  State_2611_Desc = {
    Text = "Khi sức sống dưới 50%([StateArg1]), sẽ phân chia thành 2 con \"bài tập thí nghiệm\" có lượng sức sống bằng nhau."
  },
  State_2611_Name = {Text = "Phân chia"},
  State_2611_WeaponDesc = {
    Text = "Khi sức sống dưới 30%([StateArg1]), sẽ phân chia thành 3 \"thân thể bị ăn mòn bình tượng nến loại II\" có lượng sức sống bằng nhau."
  },
  State_2612_Desc = {
    Text = "Imitasi Penjelajah Kuno"
  },
  State_2612_Name = {
    Text = "Imitasi Penjelajah Kuno"
  },
  State_2612_WeaponDesc = {
    Text = "Imitasi Penjelajah Kuno"
  },
  State_2614_Desc = {
    Text = "Đội duy nhất: Sau khi đánh thẻ lệnh của người sở hữu trang bị, có <WeaponEffect_Num:[StateArg1]%> khả năng để lấy lại nó từ rác bài về tay. Hiệu ứng này chỉ kích hoạt 1 lần mỗi lượt."
  },
  State_2614_WeaponDesc = {
    Text = "Sau khi người chơi có trang bị sử dụng thẻ lệnh, có xác suất <WeaponEffect_Num:[StateArg1]%> đưa thẻ này từ rác bài vào tay. Hiệu ứng này chỉ có hiệu lực 1 lần trong mỗi lượt."
  },
  State_2617_Desc = {
    Text = "Vào đầu lượt sau, rút thêm [DescArg1] lá bài."
  },
  State_2617_Name = {
    Text = "Triệu chứng: Hưng phấn"
  },
  State_2619_Desc = {
    Text = "Sát thương chủ động trong cuộc chiến đấu này giảm [Layer] điểm."
  },
  State_2619_Name = {
    Text = "sức mạnh giảm xuống"
  },
  State_2619_WeaponDesc = {
    Text = "Thương gây ra trong trận chiến này giảm [Layer] điểm."
  },
  State_2620_Desc = {
    Text = "Sáng tạo dao liễu gỉ sét"
  },
  State_2620_Name = {
    Text = "Lưỡi dao lá liễu rỉ sét"
  },
  State_2623_Desc = {
    Text = "Nhận 1 sức tính toán vào đầu lượt."
  },
  State_2624_Desc = {
    Text = "Đánh ra làm cho tất cả kẻ địch mất [StateArg1] điểm lực lượng tạm thời."
  },
  State_2624_Name = {
    Text = "<Rune_18:suy_kiệt>"
  },
  State_2625_Desc = {
    Text = "Hiệu ứng nhảy vọt của bạn được kích hoạt hai lần. Khi vào lượt siêu việt, tất cả kẻ địch nhận được 5 điểm sức mạnh tạm thời."
  },
  State_2625_Name = {
    Text = "Đèn hồn sáng tạo ác mộng"
  },
  State_2626_Desc = {
    Text = "Giảm 1 râu chạm. Cuối lượt, tất cả râu chạm tấn công thêm 1 lần."
  },
  State_2627_Name = {
    Text = "Nhận được [StateArg1] năng lượng đặc biệt"
  },
  State_2627_WeaponDesc = {
    Text = "Các thẻ bài được chọn tại nút \"Tượng sáp chưa hoàn thành\" nhận khóa năng lượng"
  },
  State_2628_Desc = {
    Text = "Thẻ bài được sao chép tại \"Tượng nến chưa hoàn thiện\" nhận được hiệu ứng khắcăng"
  },
  State_2628_Name = {
    Text = "Trạng thái@Chương 2_cảm ứng 3"
  },
  State_2628_WeaponDesc = {
    Text = "Thẻ bài được sao chép tại nút \"Bình tượng nến chưa hoàn thành\" nhận được hiệu ứng khắcăng"
  },
  State_2629_Desc = {
    Text = "Tại \"Bình tượng nến chưa hoàn thành\", phạm vi thẻ bài có thể sao chép được mở rộng"
  },
  State_2629_Name = {
    Text = "Trạng thái@Chương 2_cảm ứng 2"
  },
  State_2629_WeaponDesc = {
    Text = "Trong nút \"bình tượng nến chưa hoàn thành\", các thẻ bài được sao chép cùng với bản thể của chúng sẽ nhận hiệu ứng \"Cố hữu\""
  },
  State_2630_Desc = {
    Text = "Các thẻ bài được sao chép từ \"tượng nến dở dang\" cùng với bản thể sẽ nhận hiệu ứng \"giữ lại\""
  },
  State_2630_Name = {
    Text = "Trạng thái@Chương 2_cảm ứng 4"
  },
  State_2630_WeaponDesc = {
    Text = "Các thẻ bài được sao chép từ nút “Bình tượng nến chưa hoàn thành” và bản thân chúng nhận được hiệu ứng “Lưu giữ”"
  },
  State_2631_Desc = {
    Text = "Ở \"bình tượng nến chưa hoàn thành\", hãy sao chép thêm một thẻ bài"
  },
  State_2631_Name = {
    Text = "Trạng thái@chương hai_cảm ứng 6"
  },
  State_2631_WeaponDesc = {
    Text = "Sao chép thêm một thẻ bài tại nút \"bình tượng nến chưa hoàn thành\""
  },
  State_2633_Desc = {
    Text = "Mỗi lần chịu 1 lần Sát thương chủ động, đặt 1 thẻ [Lửa Xanh] vào tay và khiến nó nhận \"tiêu hao\", kéo dài [Layer] lượt."
  },
  State_2633_Name = {
    Text = "lửa dụ dỗ"
  },
  State_2633_WeaponDesc = {
    Text = "Trước khi đến lượt tiếp theo, mỗi lần bị tấn công sẽ thêm một lá tiêu thụ [Lục Diễm] vào bộ bài trên tay."
  },
  State_2634_Desc = {
    Text = "Đánh ra thẻ bài sẽ chịu [StateArg1] điểm thương và loại bỏ 1 lớp. Khi hết lớp, ấp nở một \"Sinh Vật Trong Biển\" yếu hơn. Nếu vẫn còn trạng thái bị ký sinh khi kết thúc lượt, ấp nở một \"Sinh Vật Trong Biển\" có sức sống tăng dần theo số lớp."
  },
  State_2634_Name = {
    Text = "Ký sinh trùng"
  },
  State_2635_Desc = {
    Text = "Trạng thái@chương mở đầu lý thuyết tấn công"
  },
  State_2635_Name = {
    Text = "Trạng thái@chương mở đầu lý thuyết tấn công"
  },
  State_2635_WeaponDesc = {
    Text = "Trạng thái@chương mở đầu lý thuyết tấn công"
  },
  State_2636_Name = {
    Text = "Trạng thái@Chương 4 cảm ứng@hiệu lực vào lượt sau, rút 1 lá bài"
  },
  State_2637_Desc = {
    Text = "Khi bắt đầu lượt, nhận được [StateArg1] sức tính toán."
  },
  State_2637_Name = {
    Text = "Bơm tiêm sáng tạo hoạt tính"
  },
  State_2637_WeaponDesc = {
    Text = "Khi bắt đầu lượt, nhận được [StateArg1] sức tính toán."
  },
  State_2639_Desc = {
    Text = "Khi bị thương tổn chí mạng trong chiến đấu, có xác suất giữ lại 1 điểm sức sống. Sau khi kích hoạt, xác suất và kháng cự tử vong đều giảm một nửa trong cuộc điều tra này."
  },
  State_2639_Name = {
    Text = "<DeathResistanceIconKeywords:kháng cự tử vong>"
  },
  State_2640_Name = {
    Text = "Phổ thông lặp lại 1 lần"
  },
  State_2645_Desc = {
    Text = "Trạng thái@chương đầu quái vật bị động 1"
  },
  State_2645_Name = {
    Text = "Trạng thái@chương đầu quái vật bị động 1"
  },
  State_2645_WeaponDesc = {
    Text = "Trạng thái@chương đầu quái vật bị động 1"
  },
  State_2646_Desc = {
    Text = "Trạng thái @Chương mở đầu: quái vật - bị động 2"
  },
  State_2646_Name = {
    Text = "Trạng thái @Chương mở đầu: quái vật - bị động 2"
  },
  State_2646_WeaponDesc = {
    Text = "Trạng thái @Chương mở đầu: quái vật - bị động 2"
  },
  State_2647_Desc = {
    Text = "Trạng thái @ chương quái vật kỹ năng bị động 3"
  },
  State_2647_Name = {
    Text = "Trạng thái @ chương quái vật kỹ năng bị động 3"
  },
  State_2647_WeaponDesc = {
    Text = "Trạng thái @ chương quái vật kỹ năng bị động 3"
  },
  State_2648_Desc = {
    Text = "Trạng thái @Chương quái vật - Bị động 4"
  },
  State_2648_Name = {
    Text = "Trạng thái @Chương quái vật - Bị động 4"
  },
  State_2648_WeaponDesc = {
    Text = "Trạng thái @Chương quái vật - Bị động 4"
  },
  State_2649_Desc = {
    Text = "Trạng thái @ chương mở đầu quái vật thụ động cấp 5"
  },
  State_2649_Name = {
    Text = "Trạng thái @ chương mở đầu quái vật thụ động cấp 5"
  },
  State_2649_WeaponDesc = {
    Text = "Trạng thái @ chương mở đầu quái vật thụ động cấp 5"
  },
  State_2650_Desc = {
    Text = "Trạng thái @Chương đầu quái vật hiệu ứng bị động 6"
  },
  State_2650_Name = {
    Text = "Trạng thái @Chương đầu quái vật hiệu ứng bị động 6"
  },
  State_2650_WeaponDesc = {
    Text = "Trạng thái @Chương đầu quái vật hiệu ứng bị động 6"
  },
  State_2651_Desc = {
    Text = "Trạng thái@chương đầu quái vật thụ động 7"
  },
  State_2651_Name = {
    Text = "Trạng thái@chương đầu quái vật thụ động 7"
  },
  State_2651_WeaponDesc = {
    Text = "Trạng thái@chương đầu quái vật thụ động 7"
  },
  State_2652_Desc = {
    Text = "Trạng thái @chương quái vật nội tại 8"
  },
  State_2652_Name = {
    Text = "Trạng thái @chương quái vật nội tại 8"
  },
  State_2652_WeaponDesc = {
    Text = "Trạng thái @chương quái vật nội tại 8"
  },
  State_2653_Desc = {
    Text = "Trạng thái @ chương mở đầu quái vật kỹ năng bị động 9"
  },
  State_2653_Name = {
    Text = "Trạng thái @ chương mở đầu quái vật kỹ năng bị động 9"
  },
  State_2653_WeaponDesc = {
    Text = "Trạng thái @ chương mở đầu quái vật kỹ năng bị động 9"
  },
  State_2655_Desc = {
    Text = "Khi gây sát thương không bị ngăn chặn, hồi phục lượng sức sống tương đương và loại bỏ hiệu ứng khi gây sát thương."
  },
  State_2655_Name = {
    Text = "Hấp huyết"
  },
  State_2656_Desc = {
    Text = "Bắt đầu lượt sau là chạy ngay!!!!!!!"
  },
  State_2656_Name = {
    Text = "trốn chạy"
  },
  State_2660_Desc = {
    Text = "Khi trận chiến bắt đầu, nhận thêm lực lượng, nhưng mỗi lần chịu thương sẽ tăng thêm 5 điểm."
  },
  State_2660_Name = {
    Text = "Lưng dựa vào nước"
  },
  State_2661_Desc = {
    Text = "Khi trận chiến bắt đầu, tất cả kẻ địch giảm [Arg1] sức mạnh."
  },
  State_2662_Name = {
    Text = "Trạng thái@Chương ba_trạng thái thử nghiệm"
  },
  State_2663_Desc = {
    Text = "Sau khi rút khiến bản thân yếu đuối 1 lượt. Sau khi sử dụng, khiến tất cả kẻ địch yếu đuối 1 lượt. Không thể bán."
  },
  State_2663_Name = {
    Text = "Trạng thái lời nguyền suy yếu"
  },
  State_2663_WeaponDesc = {
    Text = "Sau khi rút khiến bản thân yếu đuối 1 lượt. Sau khi sử dụng, khiến tất cả kẻ địch yếu đuối 1 lượt. Không thể bán."
  },
  State_2666_Name = {
    Text = "Tỷ lệ chí mạng của dao luân hồi"
  },
  State_2667_Desc = {
    Text = "Sát thương từ lá bài tăng [Layer] %."
  },
  State_2667_Name = {
    Text = "Tăng sát thương thẻ đánh"
  },
  State_2667_WeaponDesc = {
    Text = "Sát thương từ lá bài tăng [Layer] %."
  },
  State_2668_Desc = {
    Text = "Tăng [Layer]% sức tấn công."
  },
  State_2668_Name = {
    Text = "Tăng tỷ lệ phần trăm sức tấn công vĩnh viễn chung"
  },
  State_2668_WeaponDesc = {
    Text = "Tăng [Layer]% sức tấn công."
  },
  State_2669_Desc = {
    Text = "Trong trận chiến này, thương harming chí mạng tăng [Layer] %."
  },
  State_2669_Name = {
    Text = "Sát thương chí mạng"
  },
  State_2670_Desc = {
    Text = "Khi bạn gây yếu đuối, nhận [Arg1] điểm lá chắn; khi gây tăng sát thương, nhận [Arg2] điểm lực lượng. Nếu cả hai hiệu ứng này được kích hoạt trong 1 lượt, bạn sẽ nhận thêm [Arg1] điểm lá chắn và [Arg2] điểm lực lượng."
  },
  State_2670_Name = {
    Text = "Khung tranh nặng"
  },
  State_2671_Desc = {
    Text = "Thân thể được đánh thức này chưa thức tỉnh… Khi sắp ngã gục sẽ thức tỉnh, hồi phục sức sống và bắt đầu chiến đấu với hình thái thật sự."
  },
  State_2671_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_2672_Desc = {
    Text = "Mỗi đầu lượt, đặt trạng thái [Hạn chế] lên đội của tôi."
  },
  State_2672_Name = {
    Text = "Hạn chế"
  },
  State_2672_WeaponDesc = {
    Text = "Mỗi đầu lượt, đặt trạng thái [Hạn chế] lên đội của tôi."
  },
  State_2674_Desc = {
    Text = "Trong vòng này tỷ lệ chí mạng tăng [Layer] %."
  },
  State_2674_Name = {
    Text = "Tỷ lệ chí mạng tạm thời"
  },
  State_2676_Name = {
    Text = "Phụ kiện Dấu Hiệu Đỏ Thẫm"
  },
  State_2676_WeaponDesc = {
    Text = "Sau khi kích hoạt lệnh khóa, người trang bị nhận được 15% tỷ lệ chí mạng tạm thời. Nếu thương harming chí mạng hiện tại của người trang bị lớn hơn 80%, họ sẽ nhận thêm 15% tỷ lệ chí mạng tạm thời."
  },
  State_2677_Desc = {
    Text = "Trong mỗi lượt, 3 lần đầu tiên chịu sát thương từ chủ động hoặc râu chạm sẽ giảm 75%."
  },
  State_2677_Name = {
    Text = "\"Thân Xác Bất Diệt\""
  },
  State_2677_WeaponDesc = {
    Text = "Trong mỗi lượt, 3 lần đầu tiên chịu sát thương từ chủ động hoặc râu chạm sẽ giảm 75%."
  },
  State_2679_Name = {
    Text = "Trạng thái@Chương 3_cảm ứng 7_Đánh dấu"
  },
  State_2680_Desc = {
    Text = "Tỷ lệ chí mạng tăng 20%. Vào đầu lượt, nếu sức sống dưới 25%, trong lượt hiện tại chắc chắn chí mạng."
  },
  State_2681_Desc = {
    Text = "Thân thể được đánh thức này chưa thức tỉnh… Khi sắp ngã gục sẽ thức tỉnh, hồi phục sức sống và bắt đầu chiến đấu với hình thái thật sự."
  },
  State_2681_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_2682_Desc = {
    Text = "Lá chắn và chữa trị tăng mạnh mẽ 50%."
  },
  State_2682_Name = {
    Text = "Người Bảo Vệ Vườn Dị Hóa"
  },
  State_2682_WeaponDesc = {
    Text = "Lá chắn và chữa trị tăng mạnh mẽ 50%."
  },
  State_2683_Desc = {
    Text = "Rút thẻ dựa trên số tầng trạng thái."
  },
  State_2683_Name = {Text = "Rút"},
  State_2684_Desc = {
    Text = "Đội duy nhất: \"Đánh\" của người trang bị có <WeaponEffect_Num:[StateArg1]%> xác suất nhận được 1 điểm tính toán và kích hoạt 10% <IntoxicationIconKeywords:ngộ độc> cho tất cả kẻ địch, nếu cõi hiện tại là \"Hải Vực\", khi kích hoạt hiệu ứng này sẽ khiến 1 xúc tu tấn công 1 lần. Hiệu ứng này chỉ có hiệu lực 1 lần trong mỗi lượt."
  },
  State_2684_WeaponDesc = {
    Text = "\"Đánh\" của người trang bị có <WeaponEffect_Num:[StateArg1]%> xác suất nhận được 1 điểm tính toán và kích hoạt [DescArg1]% <IntoxicationIconKeywords:ngộ độc> cho tất cả kẻ địch, nếu cõi hiện tại là \"Hải Vực\", khi kích hoạt hiệu ứng này sẽ khiến 1 xúc tu tấn công 1 lần. Hiệu ứng này có thể kích hoạt tối đa 1 lần trong mỗi lượt."
  },
  State_2685_Desc = {
    Text = "Miễn nhiễm trạng thái yếu đuối, mong manh và tăng sát thương, cuối lượt loại bỏ 1 tầng."
  },
  State_2685_Name = {
    Text = "<BlessingIconKeywords: phước lành>"
  },
  State_2685_WeaponDesc = {
    Text = "Miễn trừ tất cả các trạng thái tiêu cực được áp dụng lên phe ta trong lượt này."
  },
  State_2686_Desc = {
    Text = "Thẻ bài tạm thời nhận được khi chiến đấu."
  },
  State_2686_Name = {
    Text = "<CardKeyWord:thẻ trạng thái>"
  },
  State_2687_Desc = {
    Text = "Trong lượt này, tỷ lệ chí mạng tăng 100%"
  },
  State_2687_Name = {
    Text = "Tạm thời bùng nổ"
  },
  State_2687_WeaponDesc = {
    Text = "Trong lượt này, tỷ lệ chí mạng tăng 100%"
  },
  State_2688_Desc = {
    Text = "Mỗi lượt, sau khi đánh lá bài thứ 3, đặt 1 lá \"cảm hứng\" vào rác bài. Mỗi lượt, sau khi đánh lá bài thứ 6, lấy 1 lá \"cảm hứng\" từ rác bài và thêm vào tay."
  },
  State_2689_Desc = {
    Text = "Vào đầu lượt, rút hai lá bài. Dung lượng khe thẻ siêu việt tăng 2."
  },
  State_2689_Name = {
    Text = "Mũ của Thuật sĩ Quái đản sáng tạo"
  },
  State_2689_WeaponDesc = {
    Text = "Vào đầu lượt, rút hai lá bài. Dung lượng khe thẻ siêu việt tăng 2."
  },
  State_2690_Desc = {
    Text = "Khi Hiệp sĩ Mỹ Đức chơi thẻ bài, họ nhận được [StateArg1] điểm sức mạnh."
  },
  State_2690_Name = {
    Text = "Đam mê hiệp sĩ"
  },
  State_2691_Desc = {
    Text = "Đội duy nhất: Sau khi người trang bị kích hoạt cơn thịnh nộ bùng phát, họ sẽ nhận được <WeaponEffect_Num:[StateArg1]> điểm điên cuồng và <WeaponEffect_Num:[StateArg2]> điểm năng lượng chìa khóa bạc, cứ 4 lá bài trong tay thì lặp lại 1 lần. Nếu giới vực hiện tại là \"siêu việt\", sau khi các thẻ bài của người trang bị vào không gian siêu việt, họ sẽ nhận được lực lượng tạm thời tương đương với <WeaponEffect_Num:[StateArg3]%> sức tấn công của người trang bị, tối đa 2 lần mỗi lượt."
  },
  State_2691_WeaponDesc = {
    Text = "Người trang bị sau khi phát động cơn thịnh nộ bùng phát, nhận được <WeaponEffect_Num:[StateArg1]> điểm điên cuồng và <WeaponEffect_Num:[StateArg2]> điểm năng lượng chìa khóa bạc, mỗi 4 thẻ bài trong tay lặp lại 1 lần. Nếu giới vực hiện tại là \"siêu việt\", sau khi các thẻ bài của người trang bị vào không gian siêu việt, nhận được <WeaponEffect_Num:[Power:DescArg1]> điểm lực lượng tạm thời, mỗi lượt tối đa kích hoạt 2 lần."
  },
  State_2693_Desc = {
    Text = "Trạng thái@Chương mở đầu Điên cuồng 0_1_2 hiệu ứng"
  },
  State_2693_Name = {
    Text = "Trạng thái@Chương mở đầu Điên cuồng 0_1_2 hiệu ứng"
  },
  State_2693_WeaponDesc = {
    Text = "Trạng thái@Chương mở đầu Điên cuồng 0_1_2 hiệu ứng"
  },
  State_2694_Desc = {
    Text = "Mỗi khi tiêu thụ 1 dấu đen, tất cả thân thể được đánh thức sẽ nhận được 1 điên cuồng"
  },
  State_2694_Name = {
    Text = "Trạng thái Hoa Sinh Ngược Sáng Tạo"
  },
  State_2694_WeaponDesc = {
    Text = "Mỗi khi tiêu thụ 1 dấu đen, tất cả thân thể được đánh thức sẽ nhận được 1 điên cuồng"
  },
  State_2695_Desc = {
    Text = "Mỗi khi một thẻ bài thân thể được đánh thức vào không gian siêu việt, thân thể được đánh thức tương ứng tăng thêm 15 điên cuồng."
  },
  State_2696_Desc = {
    Text = "Trạng thái @Chương mở đầu điên cuồng 0_1_2 đã kích hoạt"
  },
  State_2696_Name = {
    Text = "Trạng thái @Chương mở đầu điên cuồng 0_1_2 đã kích hoạt"
  },
  State_2696_WeaponDesc = {
    Text = "Trạng thái @Chương mở đầu điên cuồng 0_1_2 đã kích hoạt"
  },
  State_2698_Name = {
    Text = "Bắt đầu lượt tiếp theo, sức tính toán +1"
  },
  State_2699_Name = {
    Text = "Bắt đầu lượt tiếp theo, sức tính toán +2"
  },
  State_2701_Desc = {
    Text = "Khi Cô gái biển sâu nhận được lá chắn, tăng [StateArg1] thương tổn râu chạm tạm thời."
  },
  State_2701_Name = {
    Text = "sáng tạo"
  },
  State_2701_WeaponDesc = {
    Text = "Khi Cô gái biển sâu nhận được lá chắn, tăng [StateArg1] thương tổn râu chạm tạm thời."
  },
  State_2702_Desc = {
    Text = "Nhặt được sẽ có 100% kháng cự tử vong. Sau khi kích hoạt kháng cự tử vong, mỗi đầu vòng trong trận chiến sẽ hồi [Arg1] điểm sức sống."
  },
  State_2702_Name = {
    Text = "Hô Hấp Nhân Tạo"
  },
  State_2703_Desc = {
    Text = "Mỗi lượt, bản sao tạm thời của thẻ thân thể được đánh thức đầu tiên sẽ đi vào khe hở chiều, chúng có thể được sử dụng để bảo vệ bản thân trong những lúc nguy hiểm!"
  },
  State_2703_Name = {
    Text = "Khe nứt chiều"
  },
  State_2705_Name = {
    Text = "lời tuyên bố trả thù"
  },
  State_2706_Desc = {
    Text = "Kiểm tra đá hóa từ từ"
  },
  State_2706_Name = {
    Text = "Kiểm tra đá hóa từ từ"
  },
  State_2706_WeaponDesc = {
    Text = "Kiểm tra đá hóa từ từ"
  },
  State_2707_Desc = {
    Text = "Trong lượt này, râu chạm tấn công toàn bộ kẻ địch"
  },
  State_2707_Name = {
    Text = "Đòn tấn công toàn bộ râu chạm"
  },
  State_2707_WeaponDesc = {
    Text = "Trong lượt này, râu chạm tấn công toàn bộ kẻ địch"
  },
  State_2708_Desc = {
    Text = "Giới hạn râu chạm tăng lên 1. Khi sức sống dưới 50%, sát thương xúc tu tăng [StateArg1] điểm."
  },
  State_2708_Name = {
    Text = "Quà cống dị hóa"
  },
  State_2708_WeaponDesc = {
    Text = "Giới hạn râu chạm tăng lên 1. Khi sức sống dưới 50%, sát thương xúc tu tăng [StateArg1] điểm."
  },
  State_2709_Desc = {
    Text = "Số lượng lá liễu sáng tạo bị rỉ sét"
  },
  State_2710_Desc = {Text = "Dấu ấn"},
  State_2710_Name = {Text = "Dấu ấn"},
  State_2710_WeaponDesc = {Text = "Dấu ấn"},
  State_2711_Desc = {
    Text = "Thay đổi tạm thời sức tính toán của thẻ bài"
  },
  State_2711_Name = {
    Text = "Thay đổi tạm thời sức tính toán của thẻ bài"
  },
  State_2711_WeaponDesc = {
    Text = "Thay đổi tạm thời sức tính toán của thẻ bài"
  },
  State_2712_Desc = {
    Text = "Tăng cường lá chắn được tạo ra."
  },
  State_2712_Name = {
    Text = "<AlertIconKeywords:giữ mình>"
  },
  State_2712_WeaponDesc = {
    Text = "Lá chắn nhận được được cải thiện."
  },
  State_2713_Desc = {
    Text = "Đao trả thù mỗi lượt sẽ nhận được thêm lực lượng."
  },
  State_2713_Name = {
    Text = "Lưỡi Đao Báo Thù thức tỉnh"
  },
  State_2713_WeaponDesc = {
    Text = "Bắt đầu lượt tiếp theo nhận được lá chắn bằng với sức sống đã mất trong lượt trước."
  },
  State_2715_Desc = {
    Text = "Số điểm lá chắn tăng thêm trong lần thử thách này là [Layer]."
  },
  State_2715_Name = {
    Text = "Sẵn sàng thường trực"
  },
  State_2715_WeaponDesc = {
    Text = "Số điểm lá chắn tăng thêm trong lần thử thách này là [Layer]."
  },
  State_2718_Desc = {
    Text = "Đội duy nhất: Vào cuối lượt, người trang bị nhận được <WeaponEffect_Num:[StateArg1]> điểm điên cuồng, và nhận năng lượng chìa khóa bạc tương đương với mức sạc chìa khóa bạc của người trang bị."
  },
  State_2718_WeaponDesc = {
    Text = "Vào cuối lượt, người trang bị nhận được <WeaponEffect_Num:[StateArg1]> điểm điên cuồng, và nhận năng lượng chìa khóa bạc tương đương với mức sạc chìa khóa bạc của người trang bị."
  },
  State_2720_Desc = {
    Text = "Khi gây thương thực sự, giảm 10 điên cuồng của thân thể được đánh thức có điên cuồng cao nhất."
  },
  State_2720_Name = {Text = "Hư vô"},
  State_2720_WeaponDesc = {
    Text = "Khi gây thương thực sự, giảm 10 điên cuồng của thân thể được đánh thức có điên cuồng cao nhất."
  },
  State_2721_Name = {
    Text = "Trạng thái@quan2_9 chiến đấu5 bong1"
  },
  State_2722_Desc = {
    Text = "Đánh ra sẽ đưa [StateArg1] lá \"cảm hứng\" vào rút bài từ bộ bài. \"cảm hứng\": nhận được 1 sức tính toán, rút 1 lá bài, giữ lại và tiêu thụ."
  },
  State_2722_Name = {
    Text = "<Rune_17_High:cảm hứng nâng cao>"
  },
  State_2723_Desc = {
    Text = "Sau khi đánh ra, tất cả kẻ địch sẽ bị tăng sát thương [StateArg1] lượt."
  },
  State_2723_Name = {
    Text = "<Rune_1_High:tăng sát thương yếu>"
  },
  State_2724_Desc = {
    Text = "Số lần tấn công được tăng thêm 1."
  },
  State_2724_Name = {
    Text = "Hạt nhân ảo mộng phản kích"
  },
  State_2726_Desc = {
    Text = "Sau khi đánh ra, áp dụng [StateArg1] lớp trúng độc lên tất cả kẻ địch, khiến chúng chịu [StateArg2]% trúng độc."
  },
  State_2726_Name = {
    Text = "<Rune_10_High:độc cấp cao>"
  },
  State_2727_Desc = {
    Text = "Khi sắp chết, hồi phục 1 sức sống và loại bỏ trạng thái đó."
  },
  State_2727_Name = {Text = "Racine"},
  State_2727_WeaponDesc = {
    Text = "Khi sắp chết, hồi phục 1 sức sống và loại bỏ trạng thái đó."
  },
  State_2728_Desc = {
    Text = "Vào đầu lượt, với mỗi đồng minh khác, nhận được 1 lớp <ParcloseIconKeywords:rào cản>."
  },
  State_2728_Name = {
    Text = "Rào cản liên kết"
  },
  State_2728_WeaponDesc = {
    Text = "Vào đầu lượt, nhận lá chắn bằng [Layer]% máu tối đa cho mỗi đồng minh khác."
  },
  State_2729_Desc = {
    Text = "Khi kích hoạt, rút một lá bài tương ứng với thân thể được đánh thức."
  },
  State_2729_Name = {
    Text = "Bộ rút bài dị hóa không gian"
  },
  State_2729_WeaponDesc = {
    Text = "Khi kích hoạt, rút một lá bài tương ứng với thân thể được đánh thức."
  },
  State_2730_Desc = {
    Text = "Sau khi chết, Hydra giảm 1 lớp trạng thái \"Vạn Rắn Khống Chế\"."
  },
  State_2730_Name = {Text = "Familier"},
  State_2732_Desc = {
    Text = "Trạng thái@Mở đầu điên cuồng khởi tạo 0_2_3"
  },
  State_2732_Name = {
    Text = "Trạng thái@Mở đầu điên cuồng khởi tạo 0_2_3"
  },
  State_2732_WeaponDesc = {
    Text = "Trạng thái@Mở đầu điên cuồng khởi tạo 0_2_3"
  },
  State_2734_Name = {
    Text = "Vào lượt tiếp theo, rút thêm +1 lá bài"
  },
  State_2735_Desc = {
    Text = "Nếu sau khi đánh lá bài này kích hoạt \"xuyên không chiều\" hoặc hiện tại đang ở lượt siêu chiều, sẽ kích hoạt hiệu ứng tiếp theo."
  },
  State_2735_Name = {
    Text = "<TransitionIconKeywords:nhảy vọt>"
  },
  State_2735_WeaponDesc = {
    Text = "Nếu đang ở vòng siêu việt, hiệu ứng nhảy vọt có thể được kích hoạt."
  },
  State_2737_Desc = {
    Text = "Khi bộ bài của đội ta được đặt lại, nhận được [Layer] điểm sức mạnh."
  },
  State_2737_Name = {
    Text = "Luôn đông cứng"
  },
  State_2738_Name = {
    Text = "Hiệu ứng yếu đuối tăng cường"
  },
  State_2740_Desc = {
    Text = "Tại \"Tượng nến chưa hoàn thiện\", thẻ bài được sao chép cùng bản thể sẽ tiêu thụ ít hơn 1 sức tính toán, đồng thời nhận được một thẻ triệu chứng"
  },
  State_2740_Name = {
    Text = "Trạng thái@Chương hai_cảm ứng 5_2"
  },
  State_2740_WeaponDesc = {
    Text = "Trong nút \"bình tượng nến chưa hoàn thành\", thẻ bài được sao chép cùng với bản gốc sẽ tiêu thụ sức tính toán -1"
  },
  State_2741_Desc = {
    Text = "Tại \"Tượng nến chưa hoàn thiện\", thẻ bài được sao chép cùng bản thể sẽ tiêu thụ ít hơn 1 sức tính toán, đồng thời nhận được một thẻ triệu chứng"
  },
  State_2741_Name = {
    Text = "Trạng thái@Chương 2_cảm ứng5_1"
  },
  State_2741_WeaponDesc = {
    Text = "Trong nút \"bình tượng nến chưa hoàn thành\", thẻ bài được sao chép cùng với bản gốc sẽ tiêu thụ sức tính toán -1"
  },
  State_2742_Desc = {
    Text = "Mỗi lần Dida gây ra thương, nhận được [StateArg2] lực lượng tạm thời, mỗi lần nhận được lá chắn, nhận được [StateArg3] giữ mình tạm thời."
  },
  State_2742_Name = {
    Text = "Điều chỉnh tham số"
  },
  State_2744_Desc = {
    Text = "Mỗi khi một thẻ được đánh thức vào không gian siêu việt, nó nhận được 15 điên cuồng."
  },
  State_2744_Name = {
    Text = "Thiết bị nhảy vọt sáng tạo"
  },
  State_2744_WeaponDesc = {
    Text = "Mỗi khi một thẻ được đánh thức vào không gian siêu việt, nó nhận được 15 điên cuồng."
  },
  State_2746_Desc = {
    Text = "Số lần tấn công +1, mất [Layer] điểm lực lượng"
  },
  State_2746_Name = {Text = "Lo lắng"},
  State_2747_Desc = {
    Text = "Sau khi đánh ra, các thân thể được đánh thức khác nhận được [StateArg1] điên cuồng."
  },
  State_2747_Name = {
    Text = "<Rune_16:kích hoạt>"
  },
  State_2748_Desc = {
    Text = "Trạng thái@nghi lễ thắp đèn"
  },
  State_2748_Name = {
    Text = "Trạng thái@nghi lễ thắp đèn"
  },
  State_2748_WeaponDesc = {
    Text = "Trạng thái@nghi lễ thắp đèn"
  },
  State_2749_Desc = {
    Text = "Trong lượt này, sau khi gây thương tổn xúc tu, mục tiêu sẽ bị trúng độc [Layer] lớp."
  },
  State_2749_Name = {
    Text = "dòng chảy sâu thẳm"
  },
  State_2750_Desc = {
    Text = "Hãy cùng tôi chìm xuống đại dương nhé···"
  },
  State_2750_Name = {
    Text = "Ninh Phi Nga thức tỉnh"
  },
  State_2752_Desc = {
    Text = "Khi sen ngủ gây sát thương, nhận [StateArg2] điểm điên cuồng."
  },
  State_2752_Name = {
    Text = "chìm trong biển khổ"
  },
  State_2752_WeaponDesc = {
    Text = "Khi sen ngủ gây sát thương, nhận [StateArg2] điểm điên cuồng."
  },
  State_2753_Desc = {
    Text = "Khi bắt đầu lượt, nếu sức sống lớn hơn [Arg1], mất [Arg1] điểm sức sống, trong lượt đó nhận [Arg2] điểm lực lượng và [Arg3] điểm cảnh giác."
  },
  State_2754_Name = {
    Text = "Trạng thái: thẻ đánh tạm thời tăng tỷ lệ chí mạng"
  },
  State_2757_Desc = {
    Text = "Vào đầu lượt sau, nhận thêm [DescArg1] điểm sức tính toán."
  },
  State_2757_Name = {
    Text = "Triệu chứng: Đa nghi"
  },
  State_2758_Desc = {
    Text = "Tất cả hiệu ứng hồi sức sống của bạn được tăng [Arg1] điểm, sức sống hồi phục vượt mức sẽ được chuyển đổi thành lá chắn tương đương."
  },
  State_2758_Name = {
    Text = "Mẫu bướm"
  },
  State_2760_Desc = {
    Text = "Mỗi khi một thân thể được đánh thức thực hiện 1 lần nuốt chửng, các thân thể được đánh thức khác nhận được 10 điên cuồng."
  },
  State_2762_Desc = {
    Text = "Sau khi đánh ra, sẽ có hiệu lực thêm [StateArg1] lần, nhận [StateArg2] điểm dấu đen, tiêu thụ, cố hữu."
  },
  State_2762_Name = {
    Text = "<Rune_7_High:Hồi Âm Cao Cấp>"
  },
  State_2762_WeaponDesc = {
    Text = "Sau khi sử dụng, hiệu ứng sẽ kích hoạt thêm [StateArg1] lần, tiêu thụ."
  },
  State_2763_Desc = {
    Text = "Chúa Tể Ngủ Say mỗi khi tiêu thụ 1 sức tính toán, tăng [StateArg1] thương tổn râu chạm."
  },
  State_2763_Name = {
    Text = "Danh dự Bất tử"
  },
  State_2763_WeaponDesc = {
    Text = "Chúa Tể Ngủ Say mỗi khi tiêu thụ 1 sức tính toán, tăng [StateArg1] thương tổn râu chạm."
  },
  State_2764_Desc = {
    Text = "Khi gây sát thương không bị chặn, thêm [StateArg1] lớp chảy máu."
  },
  State_2764_Name = {
    Text = "Sang xuất ác ý"
  },
  State_2765_Name = {
    Text = "Trạng thái@George@khi chết sẽ được chữa trị"
  },
  State_2767_Name = {
    Text = "Trạng thái @ dấu đen cùng hiệu suất sạc chìa khóa bạc"
  },
  State_2769_Desc = {
    Text = "Thân thể được đánh thức này chưa thức tỉnh… Khi sắp ngã gục sẽ thức tỉnh, hồi phục sức sống và bắt đầu chiến đấu với hình thái thật sự."
  },
  State_2769_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_2771_Desc = {
    Text = "Quái vật lực lượng"
  },
  State_2771_Name = {
    Text = "Quái vật lực lượng"
  },
  State_2772_Name = {
    Text = "Trạng thái@màn chơi2_5_chiến đấu3_bong bóng hội thoại1"
  },
  State_2773_Desc = {
    Text = "Khi trận chiến bắt đầu, thêm 1 lá \"Giây Phút Xinh Đẹp - Thay thế tất cả thân thể được đánh thức trong tay thành\"Đánh \", cho đến cuối lượt. Giữ lại, tiêu thụ.\" vào tay."
  },
  State_2775_Desc = {
    Text = "Số lần rút bài khi phục hồi"
  },
  State_2775_Name = {
    Text = "Số lần rút bài trở lại"
  },
  State_2776_Name = {
    Text = "Đá Mắt Ngưng Đọng Lời Nguyền Tăng Cường"
  },
  State_2777_Name = {
    Text = "Trạng thái@Chương_San_Khong_Trang_Thai"
  },
  State_2778_Desc = {
    Text = "Nhận [Arg1] điểm lá chắn khi bắt đầu chiến đấu. Sau khi sử dụng 7 lần \"phòng thủ\" trong trận chiến này, ngay lập tức nhận [Arg2] điểm lá chắn."
  },
  State_2778_Name = {
    Text = "Nhật báo buổi sáng Putney"
  },
  State_2779_Desc = {
    Text = "Khi sức sống dưới 50%([StateArg1]), nó sẽ phân chia thành 3 \"thân thể bị ăn mòn dạng can thiệp\" có lượng sức sống bằng nhau."
  },
  State_2779_Name = {Text = "Phân chia"},
  State_2779_WeaponDesc = {
    Text = "Khi sức sống dưới 50%([StateArg1]), nó sẽ phân chia thành 2 \"thân thể bị ăn mòn loại II\" có lượng sức sống bằng nhau."
  },
  State_2780_Desc = {
    Text = "Sau khi đánh ra, nhận được [StateArg1] điểm sức tính toán."
  },
  State_2780_Name = {
    Text = "<Rune_4:toán>"
  },
  State_2781_Desc = {
    Text = "Mỗi khi đánh ra [Layer] lá bài, nếu bản thân không có rào cản, thêm một lớp <ParcloseIconKeywords:rào cản>."
  },
  State_2781_Name = {
    Text = "Rào cản nạp năng lượng"
  },
  State_2781_WeaponDesc = {
    Text = "Mỗi khi đội của chúng ta đánh ra [Layer] lá bài, quái vật sẽ tạo thêm một lớp rào cản"
  },
  State_2784_Desc = {
    Text = "Ngay cả khi không ở trong vòng chơi siêu việt, mỗi vòng chơi cũng có thể kích hoạt hiệu ứng nhảy vọt một lần. Dung lượng không gian siêu việt tăng 2."
  },
  State_2785_Desc = {
    Text = "Đội duy nhất: Khi người trang bị đánh ra <CardKeyWord:thẻ bài>, người trang bị nhận được 1 điểm <PowerIconKeywords:điên cuồng>. Khi <CardKeyWord:chiến đấu> bắt đầu, nhận được lượng <PowerIconKeywords:lực lượng> tương đương với <WeaponEffect_Num:[StateArg1]%> <CardKeyWord:sức tấn công> của người trang bị, nếu <CardKeyWord:giới vực> hiện tại là \"<CardKeyWord:biển sâu>\", nhận thêm <WeaponEffect_Num:[StateArg2]%> <CardKeyWord:thương tổn xúc tu>. Sau mỗi lượt tiếp theo, nhận được lượng <PowerIconKeywords:lực lượng> tương đương với <WeaponEffect_Num:[StateArg3]%> <CardKeyWord:sức tấn công> của người trang bị, nếu <CardKeyWord:giới vực> hiện tại là \"<CardKeyWord:biển sâu>\", nhận thêm <WeaponEffect_Num:[StateArg4]%> <CardKeyWord:thương tổn xúc tu>."
  },
  State_2785_WeaponDesc = {
    Text = "Người trang bị đánh ra thẻ bài, người trang bị nhận được 1 điểm điên cuồng. Khi chiến đấu bắt đầu, nhận được <WeaponEffect_Num:[Power:DescArg1]> điểm <PowerIconKeywords:lực lượng>. Nếu giới vực hiện tại đang ở \"biển sâu\", nhận thêm <WeaponEffect_Num:[DescArg2]> điểm <CardKeyWord:thương tổn râu chạm>, sau đó mỗi lượt bắt đầu, nhận được <WeaponEffect_Num:[Power:DescArg3]> điểm <PowerIconKeywords:lực lượng>. Nếu giới vực hiện tại đang ở \"biển sâu\", nhận thêm <WeaponEffect_Num:[DescArg4]> điểm <CardKeyWord:thương tổn râu chạm>."
  },
  State_2786_Name = {
    Text = "Đếm đá cuội nhuốm máu của sáng tạo"
  },
  State_2787_Desc = {
    Text = "Phục hồi sinh lực, trộn 1 lá [Hư Vô Kết Thúc] vào rác bài. Hiệu ứng vĩnh viễn, sau đó bị phá hủy."
  },
  State_2787_Name = {
    Text = "<CardKeyWord:sự tìm kiếm chân lý>"
  },
  State_2787_WeaponDesc = {
    Text = "Phục hồi sinh lực, trộn 1 lá [Hư Vô Kết Thúc] vào rác bài. Hiệu ứng vĩnh viễn, sau đó bị phá hủy."
  },
  State_2788_Desc = {
    Text = "Vào đầu lượt, rút [StateArg1] tấm bài."
  },
  State_2788_Name = {
    Text = "Đèn ước Tiên tri Sáng tạo 1"
  },
  State_2788_WeaponDesc = {
    Text = "Vào đầu lượt, rút [StateArg1] tấm bài."
  },
  State_2789_Desc = {
    Text = "Thẻ bài đã bị Jenkin phá hoại! Sau khi chơi sẽ chịu [Layer] điểm <FixedDamage:Sát Thương Thuần Túy>."
  },
  State_2789_Name = {
    Text = "<CardKeyWord:sử dụng sau đó chịu [Layer] điểm thương>"
  },
  State_2789_WeaponDesc = {
    Text = "Sau khi đánh thẻ bài, chịu [StateArg1] điểm thương."
  },
  State_2790_Desc = {
    Text = "Vào cuối lượt, bạn có thể chọn giữ lại [StateArg1] lá bài trong tay."
  },
  State_2790_Name = {
    Text = "Đèn ước nguyện của Tiên tri Sáng tạo 2"
  },
  State_2790_WeaponDesc = {
    Text = "Vào cuối lượt, bạn có thể chọn giữ lại [StateArg1] lá bài trong tay."
  },
  State_2792_Desc = {
    Text = "Khi chiến đấu bắt đầu, tất cả đồng minh nhận được 3 lớp [Giáp Sáp]. Khi lượt bắt đầu, thêm một lá Bài Co Giật vào rút bài từ bộ bài của đội mình."
  },
  State_2792_Name = {
    Text = "\"phu nhân sáp\""
  },
  State_2792_WeaponDesc = {
    Text = "Khi chiến đấu bắt đầu, tất cả đồng minh nhận được 3 lớp [Giáp Sáp]. Khi lượt bắt đầu, thêm một lá Bài Co Giật vào rút bài từ bộ bài của đội mình."
  },
  State_2793_Desc = {
    Text = "Trạng thái@con mắt đá trong cơn hấp hối cuối cùng"
  },
  State_2793_Name = {
    Text = "Trạng thái@con mắt đá trong cơn hấp hối cuối cùng"
  },
  State_2793_WeaponDesc = {
    Text = "Trạng thái@con mắt đá trong cơn hấp hối cuối cùng"
  },
  State_2796_Desc = {
    Text = "Mỗi khi bạn mất sức sống, thêm [Arg1] lớp trúng độc cho tất cả kẻ địch. Mỗi lượt làm tăng giá trị trúng độc [Arg2] điểm"
  },
  State_2797_Desc = {
    Text = "Vào đầu lượt, thêm một lá \"dù\" có [Arg1] Giữ mình vào tay, sau khi đánh ra 6 lá thẻ bài, tăng Giữ mình của tất cả các lá \"dù\" trong tay lên [Arg2]."
  },
  State_2798_Desc = {
    Text = "Khi Thượng tế Nhân ái áp dụng lá chắn, làm cho 1 lá bài ngẫu nhiên trong tay có sức tính toán tiêu thụ -1 đến khi dùng."
  },
  State_2798_Name = {
    Text = "Lòng từ bi của cha"
  },
  State_2798_WeaponDesc = {
    Text = "Khi Thượng tế Nhân ái áp dụng lá chắn, làm cho 1 lá bài ngẫu nhiên trong tay có sức tính toán tiêu thụ -1 đến khi dùng."
  },
  State_2799_Desc = {
    Text = "Khi Mặt trăng biển gây Sát thương chủ động, khiến [StateArg1] xúc tu tấn công mục tiêu đó."
  },
  State_2799_Name = {
    Text = "Tự nhân bản"
  },
  State_2799_WeaponDesc = {
    Text = "Khi Hải Nguyệt gây sát thương, [StateArg1] xúc tu sẽ tấn công mục tiêu đó."
  },
  State_2800_Desc = {
    Text = "Người trang bị gây sát thương, tạo lá chắn và tăng hiệu ứng chữa trị [StateArg1]%. (tạm thời)"
  },
  State_2800_Name = {
    Text = "Trạng thái@phiên bản thử nghiệm dao nhỏ bạo thương"
  },
  State_2801_Desc = {
    Text = "Tăng số lớp Rỗng Rỗng dựa trên sát thương thực sự nhận vào"
  },
  State_2801_Name = {
    Text = "Tăng số lớp rỗng rỗng sâu khi nhận thương"
  },
  State_2801_WeaponDesc = {
    Text = "Tăng số lớp Rỗng Rỗng dựa trên sát thương thực sự nhận vào"
  },
  State_2802_Desc = {
    Text = "Bắt đầu lượt nhận thêm lực lượng tạm thời"
  },
  State_2802_Name = {
    Text = "Tăng sức mạnh tạm thời"
  },
  State_2804_Desc = {
    Text = "Người trang bị gây sát thương, tạo lá chắn và tăng hiệu ứng chữa trị [StateArg1]%. (tạm thời)"
  },
  State_2804_Name = {
    Text = "Trạng thái@thử nghiệm pháo laser sát thương nổ"
  },
  State_2805_Desc = {
    Text = "Vào cuối lượt, các đồng minh khác sẽ nhận thêm lực lượng"
  },
  State_2805_Name = {
    Text = "\"Lửa Minh Triết\""
  },
  State_2807_Desc = {
    Text = "Vào đầu lượt, thêm một lá \"dù\" có [Arg1] Giữ mình vào tay, sau khi đánh ra 6 lá thẻ bài, tăng Giữ mình của tất cả các lá \"dù\" trong tay lên [Arg2]."
  },
  State_2808_Desc = {
    Text = "Khi kết thúc lượt, tạo ra 1 độ phôi hợp tử, nếu có thẻ phôi thai trong tay, hồi phục 15 sức sống."
  },
  State_2808_Name = {
    Text = "Kẹp Huyết Trì Dị Thường"
  },
  State_2808_WeaponDesc = {
    Text = "Khi kết thúc lượt, tạo ra 1 độ phôi hợp tử, nếu có thẻ phôi thai trong tay, hồi phục 15 sức sống."
  },
  State_2809_Desc = {
    Text = "Khi nhặt, mất vĩnh viễn [Arg1] lực lượng. Mỗi khi gây sát thương, hồi [Arg2] điểm sức sống, tối đa 6 lần mỗi lượt."
  },
  State_2809_Name = {
    Text = "Nụ hôn cá mút đá"
  },
  State_2810_Desc = {
    Text = "Khi kết thúc lượt, hồi phục [Layer] % máu tối đa."
  },
  State_2810_Name = {
    Text = "Tự hồi phục"
  },
  State_2810_WeaponDesc = {
    Text = "Quái vật kết thúc lượt, hồi phục [Layer] % sức sống tối đa"
  },
  State_2811_Desc = {
    Text = "Khi rút được thẻ triệu chứng, nhận [Arg1] điểm lực lượng. Mỗi khi bạn có 1 khắcăng nguyền rủa hoặc vật bị nguyền rủa, tỷ lệ chí mạng và thương chí mạng tăng 10%."
  },
  State_2812_Desc = {
    Text = "Thân thể được đánh thức này chưa thức tỉnh… Khi sắp ngã gục sẽ thức tỉnh, hồi phục sức sống và bắt đầu chiến đấu với hình thái thật sự."
  },
  State_2812_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_2813_Desc = {
    Text = "Vào đầu lượt, mất sức tính toán"
  },
  State_2813_Name = {
    Text = "Sai tính toán!"
  },
  State_2814_Desc = {
    Text = "Khi giành chiến thắng trong trận chiến, những khắcăng nhận được sẽ biến thành các khắcăng bị nguyền rủa, vừa mạnh mẽ vừa đáng sợ."
  },
  State_2817_Desc = {
    Text = "Mỗi lớp làm giảm thương nhận được [StateArg1], mỗi lần bị đánh chí mạng sẽ giảm đi 1 lớp."
  },
  State_2817_Name = {Text = "Giáp sáp"},
  State_2817_WeaponDesc = {
    Text = "Miễn dịch trạng thái bất thường, sẽ được loại bỏ sau khi chịu sát thương chí mạng."
  },
  State_2818_Desc = {
    Text = "Chia thành Tam giác nhỏ rỗng và Tam giác nhỏ B."
  },
  State_2818_Name = {Text = "Phân chia"},
  State_2818_WeaponDesc = {
    Text = "Chia thành Tam giác nhỏ rỗng và Tam giác nhỏ B."
  },
  State_2820_Desc = {
    Text = "Đánh ra sau đó nhận được [StateArg1] điểm lực lượng tạm thời, thẻ bài khắc āng này cũng có thể hưởng lợi từ lực lượng tăng cường."
  },
  State_2820_Name = {
    Text = "<Rune_15:nổ>"
  },
  State_2821_Name = {
    Text = "Miễn dịch tạm thời với tăng sát thương"
  },
  State_2823_Desc = {
    Text = "Đội duy nhất: Khi chiến đấu bắt đầu, gây 2 lớp <VulnerabilityIconKeywords:Trọng thương> lên kẻ địch hàng đầu. Khi lượt bắt đầu, kẻ địch đang ở trạng thái Trọng thương mất <WeaponEffect_Num:[StateArg1]%> Tấn công của Người trang bị dưới dạng <PowerIconKeywords:Sức mạnh> tạm thời. Nếu Cõi hiện tại là \"Huyết Nhục\", sau khi Người trang bị tung \"Bùng nổ\", Dung hợp Phôi thai +<WeaponEffect_Num:[Blood:StateArg2]>."
  },
  State_2823_WeaponDesc = {
    Text = "Khi chiến đấu bắt đầu, gây 2 lớp <VulnerabilityIconKeywords:Trọng thương> lên kẻ địch hàng đầu. Khi lượt bắt đầu, kẻ địch đang ở trạng thái Trọng thương mất <WeaponEffect_Num:[Power:DescArg1]> điểm <PowerIconKeywords:Sức mạnh> tạm thời. Nếu Cõi hiện tại là \"Huyết Nhục\", sau khi Người trang bị tung \"Bùng nổ\", Dung hợp Phôi thai +<WeaponEffect_Num:[Blood:StateArg2]>."
  },
  State_2825_Desc = {
    Text = "Giới hạn khe cắm thẻ quái vật siêu việt"
  },
  State_2825_Name = {
    Text = "Giới hạn khe cắm thẻ quái vật siêu việt"
  },
  State_2825_WeaponDesc = {
    Text = "Giới hạn khe cắm thẻ quái vật siêu việt"
  },
  State_2826_Desc = {
    Text = "Khi bạn chơi liên tiếp 2 lá bài, mỗi lá tốn ít sức tính toán hơn lá trước, thân thể được đánh thức với ít điên cuồng nhất sẽ tăng thêm 50 điên cuồng."
  },
  State_2826_Name = {
    Text = "Vật phẩm di sản Alcana của sáng tạo"
  },
  State_2827_Desc = {
    Text = "Số lần gây thương và thương tăng lên."
  },
  State_2827_Name = {
    Text = "<CardKeyWord:nâng cấp>"
  },
  State_2829_Desc = {
    Text = "Khi gây thương thực tế, nhận được [Layer] điểm lực lượng."
  },
  State_2829_Name = {
    Text = "\"tính cách hỗn loạn\""
  },
  State_2830_Desc = {
    Text = "Mỗi khi có một thân thể được đánh thức thuộc nghề nghiệp [biển sâu], toàn đội sẽ tăng máu tối đa (chưa hoàn thành), phòng thủ, và tấn công lên 50%"
  },
  State_2830_Name = {
    Text = "biển sâu Bonus"
  },
  State_2830_WeaponDesc = {
    Text = "Mỗi khi có một thân thể được đánh thức thuộc nghề nghiệp [biển sâu], toàn đội sẽ tăng máu tối đa (chưa hoàn thành), phòng thủ, và tấn công lên 50%"
  },
  State_2832_Desc = {
    Text = "Người trang bị gây sát thương, tạo lá chắn và tăng hiệu ứng chữa trị [StateArg1]%. (tạm thời)"
  },
  State_2832_Name = {
    Text = "Trạng thái@pháo laser thử nghiệm kháng chết"
  },
  State_2833_Desc = {
    Text = "Vào đầu lượt, rút 1 lá bài. Mỗi khi bạn rút được 1 lá bài, ngẫu nhiên thay đổi sức tính toán tiêu thụ của nó (0-4)."
  },
  State_2835_Desc = {
    Text = "Mỗi lần tiêu thụ, đánh cắp [Arg1] lực lượng tạm thời của tất cả kẻ địch."
  },
  State_2836_Name = {
    Text = "Trạng thái @lời nguyền phục tùng mù quáng"
  },
  State_2837_Name = {
    Text = "Trạng thái @lời nguyền phục tùng mù quáng"
  },
  State_2838_Name = {
    Text = "Trạng thái @lời nguyền phục tùng mù quáng"
  },
  State_2840_Desc = {
    Text = "Sau khi kết thúc lượt, nhận [Layer] điểm <FixedDamage:Sát Thương Thuần Túy> và xóa [DescArg1]% số lớp. Khi Hồi phục sinh lực, xóa số lớp Chảy máu gấp đôi lượng hồi phục."
  },
  State_2840_Name = {
    Text = "<BleedingColour: chảy máu>"
  },
  State_2840_WeaponDesc = {
    Text = "Sau khi lượt kết thúc, nhận [Layer] điểm thương và loại bỏ trạng thái này, mỗi lần chữa trị giảm một nửa số tầng."
  },
  State_2842_Desc = {
    Text = "Đánh ra sau đó nhận được [StateArg1] lớp phản công, gây [StateArg2]% <FixedDamage:Sát Thương Thuần Túy> phản công lên tất cả kẻ địch."
  },
  State_2842_Name = {
    Text = "<Rune_9:gai>"
  },
  State_2843_Desc = {
    Text = "Mỗi khi đội của tôi đánh ra 1 lá bài, nhận được [StateArg1] mức lá chắn. Kéo dài 1 lượt."
  },
  State_2843_Name = {
    Text = "Lông vũ bay khắp trời"
  },
  State_2843_WeaponDesc = {
    Text = "Mỗi khi đội của tôi đánh ra 1 lá bài, nhận được [StateArg1] mức lá chắn. Kéo dài 1 lượt."
  },
  State_2844_Desc = {
    Text = "Trong mỗi trận chiến, khi mất sức sống lần đầu tiên, nhận được một rào cản miễn dịch với một lần thương."
  },
  State_2845_Name = {
    Text = "Phụ kiện Lời Thì Thầm Nơi Mộ Địa"
  },
  State_2845_WeaponDesc = {
    Text = "Khi bắt đầu level, sức đề kháng tử vong tăng 25%. Sau khi kích hoạt sức đề kháng tử vong, người trang bị nhận được 50 điểm điên cuồng."
  },
  State_2846_Desc = {
    Text = "Miễn dịch một lần chết, sau khi kích hoạt sẽ hồi phục [Arg1] sức sống và khiến vật sáng tạo này bị vô hiệu hóa vĩnh viễn."
  },
  State_2846_Name = {
    Text = "Búp Bê Thế Thân"
  },
  State_2847_Desc = {
    Text = "Mỗi khi thân thể được đánh thức sử dụng một thẻ bài, cộng dồn thêm 1 lớp Dấu Săn và rút số thẻ bằng nửa số lớp Dấu Săn hiện có."
  },
  State_2847_Name = {
    Text = "Lễ hội săn bắn"
  },
  State_2849_Desc = {
    Text = "Mỗi khi bạn mất sức sống, bạn sẽ nhận được [Arg1] điểm lực lượng, tối đa 10 lần. Khi số tầng đạt tối đa, hồi phục 25% sức sống đã mất."
  },
  State_2849_Name = {
    Text = "Vinh dự tối cao"
  },
  State_2853_Desc = {
    Text = "Số lượng ghế nghỉ thoải mái của sáng tạo"
  },
  State_2854_Desc = {
    Text = "Sau khi chết, không cung cấp điên cuồng cho thân thể được đánh thức."
  },
  State_2854_Name = {Text = "ích kỷ"},
  State_2854_WeaponDesc = {
    Text = "Sau khi chết, không cung cấp điên cuồng cho thân thể được đánh thức."
  },
  State_2855_Desc = {
    Text = "Thương từ thẻ đánh tăng [StateArg1]%, kéo dài [Layer] lượt."
  },
  State_2855_Name = {
    Text = "Sinh tồn trong tuyệt cảnh·Đánh"
  },
  State_2855_WeaponDesc = {
    Text = "Bản lượt này, thương của thẻ đánh của bạn tăng [Layer]%."
  },
  State_2856_Desc = {
    Text = "Đội duy nhất: Trang bị gây tăng lá chắn <WeaponEffect_Num:[StateArg1]％> và khi gây lá chắn, đồng minh toàn đội nhận được <WeaponEffect_Num:[StateArg3]％> tỷ lệ chí mạng tạm thời và <WeaponEffect_Num:[StateArg4]％> năng lượng chìa khóa bạc do trang bị sạc, tối đa 2 lần mỗi lượt. Nếu giới vực hiện tại là \"biển sâu\", mỗi khi có 1 râu chạm tấn công, trang bị nhận được 1 điểm điên cuồng, tối đa <WeaponEffect_Num:[StateArg2]> điểm mỗi lượt."
  },
  State_2856_WeaponDesc = {
    Text = "Người trang bị gây lá chắn tăng <WeaponEffect_Num:[StateArg1]％>, và khi gây lá chắn, tất cả đồng minh nhận được <WeaponEffect_Num:[StateArg3]％> tỷ lệ chí mạng tạm thời và <WeaponEffect_Num:[StateArg4]％> năng lượng chìa khóa bạc từ sạc chìa khóa bạc của người trang bị, tối đa 2 lần mỗi lượt. Nếu giới vực hiện tại là \"biển sâu\", mỗi khi có 1 râu chạm tấn công, người trang bị nhận được 1 điểm điên cuồng, tối đa <WeaponEffect_Num:[StateArg2]> điểm mỗi lượt."
  },
  State_2857_Desc = {
    Text = "Mỗi đầu lượt, tất cả các thân thể được đánh thức nhận được 10 điên cuồng. Giảm 50% máu tối đa."
  },
  State_2858_Name = {
    Text = "Sau khi sử dụng, nhận thêm hai lớp rào cản"
  },
  State_2859_Desc = {
    Text = "Sau khi chiến đấu bắt đầu, lá bài này cố định trong tay."
  },
  State_2859_Name = {
    Text = "<CardKeyWord:cố hữu>"
  },
  State_2860_Desc = {
    Text = "Khi rút, giảm 10% sức sống tối đa của bản thân. Sau khi sử dụng, tăng 100% thương harming chí mạng cho tất cả thân thể được đánh thức trong lượt này. Không thể bán."
  },
  State_2860_Name = {
    Text = "Trạng thái nguyền rủa tan rã"
  },
  State_2860_WeaponDesc = {
    Text = "Khi rút, giảm 10% sức sống tối đa của bản thân. Sau khi sử dụng, tăng 100% thương harming chí mạng cho tất cả thân thể được đánh thức trong lượt này. Không thể bán."
  },
  State_2861_Name = {
    Text = "(còn lại:[Layer])"
  },
  State_2862_Desc = {
    Text = "Khi kết thúc lượt, nhận thêm một lần sát thương trúng độc"
  },
  State_2862_Name = {
    Text = "Suy yếu thể chất"
  },
  State_2863_Desc = {
    Text = "Số tầng tiến hóa"
  },
  State_2863_Name = {
    Text = "Số tầng tiến hóa"
  },
  State_2863_WeaponDesc = {
    Text = "Số tầng tiến hóa"
  },
  State_2864_Desc = {
    Text = "\"24\"đã thức tỉnh, hãy sử dụng \"cứu tôi\" lần cuối để tìm cơ hội!"
  },
  State_2864_Name = {
    Text = "\"24\" thức tỉnh!"
  },
  State_2864_WeaponDesc = {
    Text = "Bắt đầu lượt tiếp theo nhận được lá chắn bằng với sức sống đã mất trong lượt trước."
  },
  State_2866_Desc = {
    Text = "Đội duy nhất: Kích tước tay tối đa +2, vào cuối lượt nhận được năng lượng chìa khóa bạc tương đương với <WeaponEffect_Num:[StateArg1]%> sạc năng lượng chìa khóa bạc của người trang bị. Mỗi lần phát động mật lệnh, tất cả các thể thức tỉnh nhận được <WeaponEffect_Num:[StateArg2]> điểm điên cuồng, nếu cõi hiện tại là\"Huyết Nhục\", còn làm dung hợp phôi thai <WeaponEffect_Num:+[Blood:StateArg3]>."
  },
  State_2866_WeaponDesc = {
    Text = "Kích tước tay tối đa +2, khi kết thúc lượt nhận <WeaponEffect_Num:[DescArg1]> điểm Năng lượng chìa khóa bạc. Mỗi lần kích hoạt Mật lệnh, tất cả Thể thức tỉnh nhận <WeaponEffect_Num:[StateArg2]> điểm Điên loạn, nếu Cõi hiện tại là \"Huyết Nhục\", còn khiến Dung hợp Phôi thai <WeaponEffect_Num:+[Blood:StateArg3]> ."
  },
  State_2868_Desc = {
    Text = "Vào cuối lượt, mỗi thẻ bài chưa sử dụng sẽ khiến tất cả các thân thể được đánh thức nhận được 2 điên cuồng."
  },
  State_2871_Desc = {
    Text = "Khi sức sống dưới 50% ([StateArg1]), gọi ra một tam giác rỗng có sức sống tương đương"
  },
  State_2871_Name = {Text = "gọi"},
  State_2871_WeaponDesc = {
    Text = "Khi sức sống dưới 50% ([StateArg1]), gọi ra một tam giác rỗng có sức sống tương đương"
  },
  State_2874_Desc = {
    Text = "Thân thể được đánh thức khi bị Săn Đầu Lâu chú ý, sử dụng thẻ bài của nó có thể rút thêm 2 thẻ bài."
  },
  State_2875_Desc = {
    Text = "Sau khi đánh ra, phôi hợp tử +[StateArg1]."
  },
  State_2875_Name = {
    Text = "<Rune_12_High:khát máu>"
  },
  State_2875_WeaponDesc = {
    Text = "Sau khi chơi, Dung hợp Phôi thai+ [Blood:StateArg1]."
  },
  State_2876_Desc = {
    Text = "Sau khi chiến đấu kết thúc, thu được thêm 50 dấu đen và 1 thẻ triệu chứng."
  },
  State_2877_Desc = {
    Text = "Bà Đỏ mỗi lần gây thương, sẽ nhận được [StateArg2] điểm lực lượng tạm thời."
  },
  State_2877_Name = {
    Text = "quyền đặc biệt đón khách"
  },
  State_2878_Desc = {
    Text = "Tăng số lần gây thương lên 1, nhưng giảm 25% sát thương."
  },
  State_2878_Name = {
    Text = "Điên cuồng"
  },
  State_2878_WeaponDesc = {
    Text = "Tăng số lần gây thương lên 1, nhưng giảm 25% sát thương."
  },
  State_2879_Name = {
    Text = "Slime Ngọt"
  },
  State_2879_WeaponDesc = {
    Text = "Sau khi sử dụng \"Tiêu diệt\", nếu lượt này đang ở tư thế biển lặng, hiệu ứng khiên và chữa lành của người trang bị trong lượt này tăng 30%."
  },
  State_2880_Name = {
    Text = "Trạng thái@Sứ giả Biển Khởi Linh 7"
  },
  State_2881_Desc = {
    Text = "Mỗi khi chuyển đổi 1 lá \"Thánh lễ\" thành \"Chấp vọng\", thương cơ bản mà Miriam gây ra trong trận chiến này tăng 15%."
  },
  State_2881_Name = {
    Text = "Bong bóng ảo tưởng vỡ tan"
  },
  State_2883_Desc = {
    Text = "Đội duy nhất: Sau khi Người trang bị gây Sát thương chủ động, có <WeaponEffect_Num:[StateArg1]%> xác suất Rút 1 thẻ lệnh của Người trang bị và giảm Giá trị Điểm tính toán của nó xuống 1. hiệu ứng này chỉ có hiệu lực 1 lần trong một lượt."
  },
  State_2883_WeaponDesc = {
    Text = "Sau khi Người trang bị gây Sát thương chủ động, có <WeaponEffect_Num:[StateArg1]%> xác suất Rút 1 thẻ lệnh của Người trang bị và giảm Giá trị Điểm tính toán của nó xuống 1. hiệu ứng này chỉ có hiệu lực 1 lần trong một lượt."
  },
  State_2884_Name = {
    Text = "Gây thương là <PunctureDamagewords:thương xuyên thủng>. Giảm 1 tiêu thụ sức tính toán của 1 lá bài có sức tính toán cao nhất trong tay"
  },
  State_2885_Name = {
    Text = "Trạng thái @ đầu vòng, rút bài +2"
  },
  State_2887_Desc = {
    Text = "Đội duy nhất: Sau khi người trang bị phát động cơn thịnh nộ bùng nổ, sát thương chí mạng trong lượt này tăng <WeaponEffect_Num:[StateArg1]%>, tất cả các thẻ bài của người trang bị trong tay có <WeaponEffect_Num:[StateArg2]%> xác suất giảm 1 điểm tiêu thụ Điểm tính toán trong lượt này."
  },
  State_2887_WeaponDesc = {
    Text = "Người trang bị sau khi phát động cơn thịnh nộ bùng nổ, sát thương chí mạng trong lượt này tăng <WeaponEffect_Num:[StateArg1]%>, tất cả các thẻ bài của người trang bị trong tay có <WeaponEffect_Num:[StateArg2]%> xác suất giảm 1 điểm tiêu thụ Điểm tính toán trong lượt này."
  },
  State_2888_Desc = {
    Text = "Nếu có \"phôi thai\" trong bài tay, tiêu thụ 1 lá và kích hoạt hiệu ứng tiếp theo."
  },
  State_2888_Name = {
    Text = "<DevouredIconKeywords:tiêu thụ>"
  },
  State_2888_WeaponDesc = {
    Text = "Tiêu thụ bài trên tay phôi thai, kích hoạt hiệu ứng nuốt chửng mạnh mẽ."
  },
  State_2889_Name = {
    Text = "Chọn một thân thể được đánh thức để nhận <Energy:[DescArg1]> điểm Điên Cuồng"
  },
  State_2890_Desc = {
    Text = "Khi chiến đấu bắt đầu, gây 1 lớp yếu đuối cho đội của tôi."
  },
  State_2890_Name = {
    Text = "Xuyên giáp"
  },
  State_2890_WeaponDesc = {
    Text = "Khi chiến đấu bắt đầu, gây 1 lớp yếu đuối cho đội của tôi."
  },
  State_2891_Name = {
    Text = "Nâng cao hồi phục mở đầu điên cuồng"
  },
  State_2892_Desc = {
    Text = "Vào cuối lượt, hồi phục [Layer] điểm sức sống."
  },
  State_2892_Name = {
    Text = "Trễ hồi máu"
  },
  State_2892_WeaponDesc = {
    Text = "Đến cuối lượt, mỗi lần gây tiêu diệt, hồi phục [Layer] điểm sức sống."
  },
  State_2897_Desc = {
    Text = "Khi giải phóng nguồn gốc đến, giảm lực lượng nhất thời của kẻ địch."
  },
  State_2897_Name = {
    Text = "Sợ hãi điên cuồng"
  },
  State_2899_Desc = {
    Text = "Nếu số lượng bài trong tay đối phương lớn hơn hoặc bằng 4, khi nhận thương, sẽ nhận được [StateArg1] điểm lá chắn."
  },
  State_2899_Name = {
    Text = "Hình rắn"
  },
  State_2900_Desc = {
    Text = "Sát thương gây ra trong cuộc chiến đấu này được tăng [Layer] điểm."
  },
  State_2900_Name = {
    Text = "lực lượng"
  },
  State_2900_WeaponDesc = {
    Text = "Sát thương gây ra trong cuộc chiến đấu này được tăng [Layer] điểm."
  },
  State_2901_Desc = {
    Text = "[cơn thịnh nộ bùng phát] giúp bản thân nhận 20 điểm điên cuồng."
  },
  State_2901_Name = {
    Text = "Mặt nạ của vị thần sáng tạo vô danh"
  },
  State_2901_WeaponDesc = {
    Text = "[cơn thịnh nộ bùng phát] giúp bản thân nhận 20 điểm điên cuồng."
  },
  State_2902_Desc = {
    Text = "Não trong bình phục hồi gấp đôi sức sống."
  },
  State_2902_Name = {
    Text = "linh hồn và thể xác phân chia"
  },
  State_2902_WeaponDesc = {
    Text = "Não trong bình phục hồi gấp đôi sức sống."
  },
  State_2903_Desc = {
    Text = "Người trang bị gây sát thương, tạo lá chắn và tăng hiệu ứng chữa trị [StateArg1]%. (tạm thời)"
  },
  State_2903_Name = {
    Text = "Trạng thái @Dao Thử Nghiệm Bạo Kích"
  },
  State_2904_Desc = {
    Text = "Sau mỗi lần nhận sát thương thực tế, tăng thêm 10 lá chắn."
  },
  State_2904_Name = {
    Text = "bộ đệm"
  },
  State_2904_WeaponDesc = {
    Text = "Sau mỗi lần nhận sát thương thực tế, tăng thêm 10 lá chắn."
  },
  State_2905_Desc = {
    Text = "Đội duy nhất: Lá chắn tăng cường từ \"Bùng nổ\" của người trang bị tăng <WeaponEffect_Num:[StateArg2]%>. Sau khi người trang bị kích hoạt \"Bùng nổ\", nhận số lớp <WeaponEffect_Num:[StateArg1]%> Phòng thủ của người trang bị dưới dạng <PowerIconKeywords:Sức mạnh> tạm thời. Nếu đội ta đang ở trạng thái <FragileIconKeywords:Mong manh>, hiệu ứng nhân đôi."
  },
  State_2905_WeaponDesc = {
    Text = "Khi người sử dụng kích hoạt \"điên cuồng bùng nổ\", lượng lá chắn tạo ra tăng <WeaponEffect_Num:[StateArg2]%>. Sau khi người sử dụng giải phóng \"điên cuồng bùng nổ\", nhận được [Power:DescArg1] sức mạnh tạm thời <PowerIconKeywords:sức mạnh>. Nếu đội của chúng ta đang ở trạng thái <FragileIconKeywords:mong manh>, hiệu ứng sẽ gấp đôi."
  },
  State_2906_Desc = {
    Text = "Sau khi gây ra thương thực tế, đội tôi tạm thời mất [Layer] điểm lực lượng."
  },
  State_2906_Name = {
    Text = "Chích điện"
  },
  State_2909_Desc = {
    Text = "Có [Layer] điểm điên cuồng. Nếu điên cuồng lớn hơn hoặc bằng 5, ý định trở thành \"Bữa tiệc điên rồ của xác chết biến dạng\", sau khi điên cuồng giảm xuống, ý định sẽ khôi phục."
  },
  State_2909_Name = {
    Text = "Trạng thái @ quái vật 24 Bữa tiệc điên rồ của xác chết biến dạng [số lần]"
  },
  State_2909_WeaponDesc = {
    Text = "Có [Layer] điểm điên cuồng. Nếu điên cuồng lớn hơn hoặc bằng 5, ý định trở thành \"Bữa tiệc điên rồ của xác chết biến dạng\", sau khi điên cuồng giảm xuống, ý định sẽ khôi phục."
  },
  State_2910_Desc = {
    Text = "Đội duy nhất: Khi bắt đầu khám phá, thêm một thẻ \"Cảm Hứng\" và \"Đòn Đánh\" của người trang bị vào bộ bài. \"Đòn Đánh\" của người trang bị tăng sát thương cơ bản <WeaponEffect_Num:[StateArg1]%>, sau khi đánh ra có <WeaponEffect_Num:[StateArg2]%> xác suất rút 1 thẻ. Hiệu ứng này tối đa kích hoạt 1 lần mỗi lượt. Nếu giới vực hiện tại là \"Siêu Việt\" và trong lượt Siêu Việt, \"Đòn Đánh\" sẽ đặt 1 thẻ \"Cảm Hứng\" vào tay, tối đa kích hoạt 1 lần trong lượt đó."
  },
  State_2910_WeaponDesc = {
    Text = "Khi bắt đầu khám phá, thêm một lá \"cảm hứng\" và \"đánh\" của người trang bị vào bộ bài, \"đánh\" của người trang bị có sát thương cơ bản tăng <WeaponEffect_Num:[StateArg1]%>, sau khi đánh ra có <WeaponEffect_Num:[StateArg2]%> xác suất rút 1 lá bài. Hiệu ứng này chỉ có thể kích hoạt tối đa 1 lần mỗi lượt. Nếu giới vực hiện tại là \"siêu việt\" và trong lượt siêu việt, \"đánh\" sẽ đưa 1 lá \"cảm hứng\" vào tay, tối đa kích hoạt 1 lần trong lượt đó."
  },
  State_2911_Desc = {
    Text = "Trạng thái@Thế giới không tưởng thuần trắng đã thay đổi số đếm"
  },
  State_2911_Name = {
    Text = "Trạng thái@đếm số thế giới không tưởng thuần trắng"
  },
  State_2911_WeaponDesc = {
    Text = "Trạng thái@Thế giới không tưởng thuần trắng đã thay đổi số đếm"
  },
  State_2912_Desc = {
    Text = "Bạn đã bị khóa! Sau khi đánh, người dấn thân vào biển nhận được [StateArg1] điểm lực lượng tạm thời, loại bỏ dấu ấn Thâm Tiềm của lệnh này."
  },
  State_2912_Name = {
    Text = "<CardKeyWord:dấu ấn lặn sâu>"
  },
  State_2912_WeaponDesc = {
    Text = "Sau khi đánh thẻ bài, Vệ binh Thợ Lặn Sâu nhận được [StateArg1] điểm lực lượng tạm thời."
  },
  State_2913_Desc = {
    Text = "Khi trận chiến bắt đầu, áp dụng yếu đuối lên bản thân trong 3 lượt."
  },
  State_2913_Name = {
    Text = "Sáng Tạo Quái Dị Móc Câu 2"
  },
  State_2913_WeaponDesc = {
    Text = "Khi trận chiến bắt đầu, áp dụng yếu đuối lên bản thân trong 3 lượt."
  },
  State_2914_Desc = {
    Text = "Khi sức sống dưới 50%, ý định sẽ thay đổi thành gọi một [Tam giác Rỗng rỗng Trung] có sức sống tương đương."
  },
  State_2914_Name = {
    Text = "Phân hạch"
  },
  State_2914_WeaponDesc = {
    Text = "Khi sức sống dưới 50%, ý định sẽ thay đổi thành gọi một [Tam giác Rỗng rỗng Trung] có sức sống tương đương."
  },
  State_2915_Desc = {
    Text = "Tăng số lượt sát thương của \"nỗi hận dài dằng dặc\" thêm [Layer] lần."
  },
  State_2915_Name = {
    Text = "Sự hận thù"
  },
  State_2915_WeaponDesc = {
    Text = "Tăng số lượt sát thương của \"nỗi hận dài dằng dặc\" thêm [Layer] lần."
  },
  State_2917_Desc = {
    Text = "Khi kết thúc lượt, với mỗi lá bài còn lại, nhận 1 điểm sức tính toán ở đầu lượt sau."
  },
  State_2917_Name = {
    Text = "Trạng thái @chìa khóa bạc ảo mộng: Tính toán"
  },
  State_2918_Desc = {
    Text = "Giảm 99% thương nhận phải. Sau khi nhận sát thương chủ động, loại bỏ 1 lớp; đầu mỗi lượt phục hồi về 3 lớp."
  },
  State_2918_Name = {
    Text = "\"Thân Xác Bất Diệt\""
  },
  State_2918_WeaponDesc = {
    Text = "Giảm 99% thương nhận phải. Sau khi nhận sát thương chủ động, loại bỏ 1 lớp; đầu mỗi lượt phục hồi về 3 lớp."
  },
  State_2919_Desc = {
    Text = "Trạng thái @hình ảnh ngọc bích xanh lục sớm"
  },
  State_2919_Name = {
    Text = "Trạng thái @hình ảnh ngọc bích xanh lục sớm"
  },
  State_2919_WeaponDesc = {
    Text = "Trạng thái @hình ảnh ngọc bích xanh lục sớm"
  },
  State_2922_Desc = {
    Text = "Mỗi khi tiêu thụ 1 điểm sức tính toán, khiến thân thể được đánh thức nhận 2 điểm điên cuồng."
  },
  State_2923_Desc = {
    Text = "Vào cuối lượt, lực lượng sẽ tăng lên [Layer]."
  },
  State_2923_Name = {
    Text = "Lễ thức thần giáng"
  },
  State_2923_WeaponDesc = {
    Text = "Vào cuối mỗi lượt, nhận được [Layer] điểm lực lượng."
  },
  State_2925_Desc = {
    Text = "Lửa Xanh mỗi lần gây sát thương, số tầng +1"
  },
  State_2925_Name = {
    Text = "Số đếm Ngọc Bích Ảnh"
  },
  State_2925_WeaponDesc = {
    Text = "Lửa Xanh mỗi lần gây sát thương, số tầng +1"
  },
  State_2927_Name = {
    Text = "Trạng thái @lời nguyền cuồng ngôn thay đổi"
  },
  State_2929_Desc = {
    Text = "Đội duy nhất: Mỗi lần Người trang bị gây 1 lần thương, có <WeaponEffect_Num:[StateArg3]%> xác suất khiến Người trang bị nhận 2% Sát thương bạo kích tạm thời. Sau khi Người trang bị kích hoạt Bùng nổ, gây 3 lần Sát thương chủ động tương đương <WeaponEffect_Num:[StateArg1]%> Tấn Công của Người trang bị lên kẻ thù ngẫu nhiên. Nếu Cõi hiện tại là \"Huyết Nhục\", mỗi lần Người trang bị Nuốt chửng một Phôi thai, khiến Dung hợp Phôi thai +<WeaponEffect_Num:[Blood:StateArg2]> ."
  },
  State_2929_WeaponDesc = {
    Text = "Mỗi lần Người trang bị gây 1 lần thương, có <WeaponEffect_Num:[StateArg3]%> xác suất khiến Người trang bị nhận 2% Sát thương bạo kích tạm thời. Sau khi Người trang bị kích hoạt Bùng nổ, gây 3 lần [DescArg1] điểm Sát thương chủ động lên kẻ thù ngẫu nhiên. Nếu Cõi hiện tại là \"Huyết Nhục\", mỗi lần Người trang bị Nuốt chửng một Phôi thai, khiến Dung hợp Phôi thai +<WeaponEffect_Num:[Blood:StateArg2]> ."
  },
  State_2930_Name = {
    Text = "Trạng thái @George@ khi chết sẽ được tăng lực lượng"
  },
  State_2931_Desc = {
    Text = "Mỗi lần tiến hành 1 lần nuốt chửng, đánh cắp 4 lực lượng tạm thời của tất cả kẻ địch."
  },
  State_2931_Name = {
    Text = "Ngọc mã não tơ dị hóa"
  },
  State_2933_Name = {
    Text = "Trang sức song sinh xoắn trắng"
  },
  State_2933_WeaponDesc = {
    Text = "Khi lượt chẵn bắt đầu, thêm một lá 「Phòng thủ」 được tăng cường bởi 「Hư vô」 và tiêu thụ từ người mang trang bị vào bộ bài trên tay."
  },
  State_2934_Desc = {
    Text = "Tăng Sát Thương chủ động và thương tổn xúc tu nhận vào thêm [DescArg1] %."
  },
  State_2934_Name = {
    Text = "<VulnerabilityColour: tăng sát thương>"
  },
  State_2934_WeaponDesc = {
    Text = "Mọi sát thương nhận vào tăng 50%."
  },
  State_2937_Desc = {
    Text = "Cứ lần thứ 3 nhận được lá chắn, đồng thời nhận được lượng phản công tương đương."
  },
  State_2938_Desc = {
    Text = "Khi bắt đầu lượt, rút 1 lá bài; khi kết thúc lượt, được phép chọn giữ lại 1 lá bài trong tay."
  },
  State_2939_Name = {
    Text = "Miễn dịch yếu đuối"
  },
  State_2940_Desc = {
    Text = "Hiệu ứng khả năng tái tạo được tăng lên."
  },
  State_2940_Name = {
    Text = "Dần chịu ảnh hưởng mạnh mẽ từ máu dị đoan"
  },
  State_2941_Desc = {
    Text = "Sau khi đánh ra, áp dụng [StateArg1] lớp trúng độc lên tất cả kẻ địch, khiến chúng chịu [StateArg2]% trúng độc."
  },
  State_2941_Name = {
    Text = "<Rune_10:độc tố>"
  },
  State_2942_Desc = {
    Text = "Khi kết thúc lượt, hồi phục [Layer] % sức sống cho các đồng minh khác và xóa bỏ thương."
  },
  State_2942_Name = {
    Text = "Cứu hộ chiến trường"
  },
  State_2946_Desc = {
    Text = "Liên kích điên cuồng nhận được lượng lá chắn cực cao."
  },
  State_2946_Name = {
    Text = "\"pháo đài bất động\""
  },
  State_2946_WeaponDesc = {
    Text = "Liên kích điên cuồng nhận được lượng lá chắn cực cao."
  },
  State_2947_Name = {Text = "Hòa tan 2"},
  State_2948_Desc = {
    Text = "Trước khi đánh ra, thay đổi chỉ số thẻ"
  },
  State_2948_Name = {
    Text = "Trước khi đánh ra, thay đổi chỉ số thẻ"
  },
  State_2948_WeaponDesc = {
    Text = "Trước khi đánh ra, thay đổi chỉ số thẻ"
  },
  State_2949_Name = {
    Text = "Trong chiến đấu vòng mệnh, bỏ qua khắcăng"
  },
  State_2951_Desc = {
    Text = "Ghế an lạc của sáng tạo"
  },
  State_2951_Name = {
    Text = "Găng Tay Câm Lặng"
  },
  State_2952_Desc = {
    Text = "Sau khi lượt kết thúc, hồi phục [Layer] điểm sức sống. Mỗi lần mất 5 điểm sức sống thì loại bỏ 1 lớp."
  },
  State_2952_Name = {
    Text = "Lực tái sinh"
  },
  State_2954_Name = {
    Text = "Trạng thái @2-8 quái vật 24@ cứu tôi"
  },
  State_2955_Desc = {
    Text = "Tất cả kẻ địch mất sức sống. Hiệu ứng vĩnh viễn, sau đó tự hủy."
  },
  State_2955_Name = {
    Text = "<CardKeyWord:Kết Thúc Hư Vô>"
  },
  State_2955_WeaponDesc = {
    Text = "Tất cả kẻ địch mất sức sống. Hiệu ứng vĩnh viễn, sau đó tự hủy."
  },
  State_2956_Desc = {
    Text = "Mỗi lần chịu thương, tất cả thân thể được đánh thức nhận được [StateArg1] điểm điên cuồng."
  },
  State_2956_Name = {
    Text = "Tia hào quang"
  },
  State_2956_WeaponDesc = {
    Text = "Mỗi lần chịu thương, tất cả thân thể được đánh thức nhận được [StateArg1] điểm điên cuồng."
  },
  State_2957_Desc = {
    Text = "Sau khi chết, gọi ra một bản sao có 1/3 sức sống tại chỗ [Tam giác Rỗng rỗng]"
  },
  State_2957_Name = {
    Text = "rỗng rỗng"
  },
  State_2957_WeaponDesc = {
    Text = "Sau khi chết, gọi ra một bản sao có 1/3 sức sống tại chỗ [Tam giác Rỗng rỗng]"
  },
  State_2960_Desc = {
    Text = "Trong lượt chẵn, khi sức tính toán của bạn là 0, bạn sẽ nhận được 2 sức tính toán."
  },
  State_2960_Name = {
    Text = "Dị hóa puzzle cũ kỹ"
  },
  State_2960_WeaponDesc = {
    Text = "Trong lượt chẵn, khi sức tính toán của bạn là 0, bạn sẽ nhận được 2 sức tính toán."
  },
  State_2961_Desc = {
    Text = "Đội duy nhất: Người trang bị gây <IntoxicationIconKeywords:ngộ độc> tăng <WeaponEffect_Num:[StateArg1]%>, trước khi người trang bị phát động cơn điên cuồng bùng nổ, trước tiên áp dụng <WeaponEffect_Num:[StateArg2]%> ngộ độc tương đương với sức tấn công của người trang bị lên tất cả kẻ địch. Sau khi sử dụng mật lệnh, người trang bị nhận được <WeaponEffect_Num:[StateArg3]> điểm điên cuồng."
  },
  State_2961_WeaponDesc = {
    Text = "Người trang bị gây <IntoxicationIconKeywords:ngộ độc> tăng <WeaponEffect_Num:[StateArg1]%>, trước khi người trang bị phát động cơn điên cuồng bùng phát, trước tiên áp dụng <WeaponEffect_Num:[Poison:DescArg1]> lớp trúng độc lên tất cả kẻ địch. Sau khi sử dụng mật lệnh, người trang bị nhận được <WeaponEffect_Num:[StateArg3]> điểm điên cuồng."
  },
  State_2962_Desc = {
    Text = "Sau khi đánh ra, tất cả kẻ địch sẽ yếu đuối [StateArg1] lượt."
  },
  State_2962_Name = {
    Text = "<Rune_2:yếu đuối>"
  },
  State_2965_Name = {
    Text = "Trạng thái @Phục Nguyệt Sĩ Nữ khởi linh 7"
  },
  State_2967_Desc = {
    Text = "Khi sử dụng thẻ triệu chứng, trạng thái của Pandya sẽ thay đổi giữa \"Lo lắng\" và \"Dissipation\". Lo lắng: Số lần Sát thương chủ động gây ra +1, giảm sức mạnh. Dissipation: Số lần Sát thương chủ động gây ra -1, tăng sức mạnh."
  },
  State_2967_Name = {
    Text = "Pandia thức tỉnh!"
  },
  State_2967_WeaponDesc = {
    Text = "Bắt đầu lượt tiếp theo nhận được lá chắn bằng với sức sống đã mất trong lượt trước."
  },
  State_2968_Name = {
    Text = "Trạng thái@cấp độ 2_14 chiến đấu 8 bong bóng 4"
  },
  State_2969_Name = {
    Text = "Trạng thái@cấp2_14chiến đấu8bong bóng5"
  },
  State_2970_Desc = {
    Text = "Keturunan Primal"
  },
  State_2970_Name = {
    Text = "Keturunan Primal"
  },
  State_2970_WeaponDesc = {
    Text = "Keturunan Primal"
  },
  State_2971_Desc = {
    Text = "Trạng thái@mất nửa máu ở chương đầu"
  },
  State_2971_Name = {
    Text = "Trạng thái@mất nửa máu ở chương đầu"
  },
  State_2971_WeaponDesc = {
    Text = "Trạng thái@mất nửa máu ở chương đầu"
  },
  State_2972_Name = {
    Text = "Trạng thái@vòng 2_14 chiến đấu 8 bong bóng 2"
  },
  State_2973_Name = {
    Text = "Trạng thái@vòng 2_14 chiến đấu 8 bong bóng 3"
  },
  State_2975_Desc = {
    Text = "Trong mỗi trận chiến, 5 lần nhảy vọt đầu tiên sẽ áp dụng thêm một lần."
  },
  State_2976_Desc = {
    Text = "Khi kết thúc lượt, nếu lá chắn của bạn bằng 0 hoặc bội số của 10, nhận [Arg1] điểm lá chắn. Nếu sức sống của bạn là bội số của 10, nhận [Arg2] điểm lực lượng."
  },
  State_2976_Name = {
    Text = "Tín hiệu cầu cứu"
  },
  State_2977_Desc = {
    Text = "Vào lượt số lẻ, khi số lá bài trong tay bạn là 0, rút 2 lá bài"
  },
  State_2977_Name = {
    Text = "Dị hóa puzzle cũ kỹ"
  },
  State_2977_WeaponDesc = {
    Text = "Vào lượt số lẻ, khi số lá bài trong tay bạn là 0, rút 2 lá bài"
  },
  State_2978_Desc = {
    Text = "Mỗi khi nhận 1 điểm thương, giảm 1 lớp. Khi số lớp đạt đến 0, chuyển sang chế độ phòng thủ."
  },
  State_2978_Name = {
    Text = "Đếm thẻ bài"
  },
  State_2978_WeaponDesc = {
    Text = "Mỗi khi nhận 1 điểm thương, giảm 1 lớp. Khi số lớp đạt đến 0, chuyển sang chế độ phòng thủ."
  },
  State_2979_Desc = {
    Text = "Đội duy nhất: Hiệu ứng trúng độc và lá chắn của người trang bị tăng <WeaponEffect_Num:[StateArg3]%>. Tỷ lệ chí mạng và thương harming chí mạng của đòn tấn công tăng <WeaponEffect_Num:[StateArg1]%>. Người trang bị nhận được lá chắn tương đương <WeaponEffect_Num:[StateArg2]%> máu tối đa. Hiệu ứng lá chắn mỗi lượt chỉ có thể kích hoạt tối đa 1 lần."
  },
  State_2979_Name = {
    Text = "Vượt qua nỗi đau"
  },
  State_2979_WeaponDesc = {
    Text = "Trang bị gây trúng độc và tăng lá chắn <WeaponEffect_Num:[StateArg3]%>. Tỷ lệ chí mạng và sát thương chí mạng của \"đánh\" tăng <WeaponEffect_Num:[StateArg1]%>, và nhận được lá chắn bằng [StateArg2]%([DescArg1]) máu tối đa. Hiệu ứng lá chắn mỗi lượt chỉ có thể phát huy 1 lần."
  },
  State_2983_Desc = {
    Text = "Nếu vẫn còn trên tay trong giai đoạn bỏ bài, thẻ bài sẽ bị tiêu thụ và không xuất hiện lại trong cuộc chiến đấu này."
  },
  State_2983_Name = {
    Text = "<NothingnessIconKeywords: hư vô>"
  },
  State_2983_WeaponDesc = {
    Text = "Nếu vẫn còn trên tay ở giai đoạn bỏ bài, lá bài sẽ không được đưa vào rác bài và không thể sử dụng lại trong cuộc chiến này."
  },
  State_2985_Desc = {
    Text = "Đến cuối lượt, mỗi lần gây thương, hồi [Layer] điểm sức sống vào cuối lượt."
  },
  State_2985_Name = {
    Text = "trứng ngọc"
  },
  State_2985_WeaponDesc = {
    Text = "Đến cuối lượt, mỗi lần gây thương tích, hồi [Layer] điểm sức sống."
  },
  State_2987_Desc = {
    Text = "Sự kiện 19_1"
  },
  State_2987_Name = {
    Text = "Sự kiện 19_1"
  },
  State_2987_WeaponDesc = {
    Text = "Sự kiện 19_1"
  },
  State_2988_Desc = {
    Text = "Khi tiêu thụ phôi thai, từ rác bài trở lại bộ bài, sức tính toán trở thành 0."
  },
  State_2988_Name = {
    Text = "Con ngoài giá thú"
  },
  State_2988_WeaponDesc = {
    Text = "Khi tiêu thụ phôi thai, từ rác bài trở lại bộ bài, sức tính toán trở thành 0."
  },
  State_2989_Desc = {
    Text = "Sau khi sử dụng thẻ bài của thân thể được đánh thức, hãy tạo một bản sao tạm thời với chi phí giảm 1 và đưa nó vào bộ bài."
  },
  State_2990_Desc = {
    Text = "Đánh ra làm cho tất cả kẻ địch mất [StateArg1] điểm lực lượng tạm thời."
  },
  State_2990_Name = {
    Text = "<Rune_18_High:Suy nhược cao cấp>"
  },
  State_2992_Desc = {
    Text = "Sau khi rút được \"Không hư\", trong lượt này, làm giảm 50% điên cuồng mà tất cả các thân thể được đánh thức nhận được."
  },
  State_2992_Name = {Text = "Hư vô"},
  State_2992_WeaponDesc = {
    Text = "Sau khi rút được \"Không hư\", trong lượt này, làm giảm 50% điên cuồng mà tất cả các thân thể được đánh thức nhận được."
  },
  State_2993_Name = {
    Text = "Số lượng vỏ rắn quái dị"
  },
  State_2994_Desc = {
    Text = "Khi râu chạm đầy đủ, thương tổn xúc tu sẽ tăng lên [StateArg1]."
  },
  State_2994_Name = {
    Text = "Lực Phước Bảo Hộ"
  },
  State_2994_WeaponDesc = {
    Text = "Khi râu chạm đầy đủ, thương tổn xúc tu sẽ tăng lên [StateArg1]."
  },
  State_2996_Desc = {
    Text = "Khiến 1 râu chạm tấn công [StateArg1] lần."
  },
  State_2996_Name = {
    Text = "<Rune_11:thống trị>"
  },
  State_2997_Desc = {
    Text = "Mỗi lượt, sau khi gây sát thương lần thứ 3, nhận được [Arg1] điểm lá chắn và sau lần thứ 6, nhận được [Arg2] điểm lực lượng."
  },
  State_2997_Name = {
    Text = "Lối thoát an toàn"
  },
  State_3001_Desc = {
    Text = "Điểm điên cuồng nhận được khi bị tấn công tăng thêm 2 điểm."
  },
  State_3002_Desc = {
    Text = "Người trang bị gây sát thương, tạo lá chắn và tăng hiệu ứng chữa trị [StateArg1]%. (tạm thời)"
  },
  State_3002_Name = {
    Text = "Trạng thái@pháo laser thử nghiệm may mắn"
  },
  State_3003_Desc = {
    Text = "Sẽ không được đưa vào rác bài, mà sẽ được gỡ bỏ khỏi bộ bài."
  },
  State_3003_Name = {
    Text = "<DepleteIconKeywords:tiêu thụ>"
  },
  State_3003_WeaponDesc = {
    Text = "Sau khi đánh, thẻ bài sẽ không vào rác bài và không thể sử dụng lại trong cuộc chiến đấu này."
  },
  State_3004_Desc = {
    Text = "[Layer] Miễn dịch với trạng thái trúng độc được áp đặt trong lượt."
  },
  State_3004_Name = {
    Text = "Miễn dịch trúng độc"
  },
  State_3008_Desc = {
    Text = "Mỗi khi bắt đầu lượt, thêm 1 tầng Chậm chạp vào các lá bài còn lại trong tay đối thủ. Đối với những lá bài có tiêu thụ sức tính toán vượt quá 5, hóa đá chúng."
  },
  State_3008_Name = {
    Text = "Ai Jī Sī thức tỉnh!"
  },
  State_3008_WeaponDesc = {
    Text = "Bắt đầu lượt tiếp theo nhận được lá chắn bằng với sức sống đã mất trong lượt trước."
  },
  State_3011_Desc = {
    Text = "Đội duy nhất: Tỷ lệ chí mạng và thương harming chí mạng của \"điên cuồng bùng phát\" của người trang bị tăng <WeaponEffect_Num:[StateArg2]%>. Sau khi người trang bị sử dụng \"điên cuồng bùng phát\", họ sẽ nhận được <PowerIconKeywords:lực lượng> tương đương với <WeaponEffect_Num:[StateArg1]%> thể chất. Nếu lần điên cuồng bùng phát này kích hoạt hiệu ứng <CardKeyWord:tiêu thụ>, họ sẽ nhận thêm 1 lần <PowerIconKeywords:lực lượng>."
  },
  State_3011_WeaponDesc = {
    Text = "Tỷ lệ chí mạng và thương chí mạng của \"cơn thịnh nộ bùng phát\" tăng <WeaponEffect_Num:[StateArg2]%>. Sau khi người sử dụng giải phóng \"cơn thịnh nộ bùng phát\", nhận được <WeaponEffect_Num:[Power:DescArg1]> điểm lực lượng. Nếu lần bùng phát này kích hoạt hiệu ứng <CardKeyWord:tiêu thụ>, sẽ nhận thêm 1 lần <PowerIconKeywords:lực lượng>."
  },
  State_3012_Desc = {
    Text = "Trạng thái rỗng không hoạt động"
  },
  State_3012_Name = {
    Text = "Trạng thái rỗng không hoạt động"
  },
  State_3012_WeaponDesc = {
    Text = "Trạng thái rỗng không hoạt động"
  },
  State_3013_Desc = {
    Text = "Khi trạng thái Khát máu kích hoạt, phôi hợp tử tăng cường và nhận thêm [StateArg1] điểm lực lượng."
  },
  State_3013_Name = {Text = "khát máu"},
  State_3014_Desc = {
    Text = "Nếu số lượng bài trong tay đối phương lớn hơn hoặc bằng 4, khi nhận thương, sẽ nhận được [StateArg1] điểm lá chắn."
  },
  State_3014_Name = {
    Text = "Hình rắn"
  },
  State_3015_Desc = {
    Text = "Trạng thái @giáp sáp đội ta"
  },
  State_3015_Name = {
    Text = "Trạng thái @giáp sáp đội ta"
  },
  State_3015_WeaponDesc = {
    Text = "Trạng thái @giáp sáp đội ta"
  },
  State_3016_Desc = {
    Text = "Quái vật được triệu hồi có sức sống tăng gấp đôi."
  },
  State_3016_Name = {
    Text = "\"sự xấu hổ tràn ngập\""
  },
  State_3016_WeaponDesc = {
    Text = "Quái vật được triệu hồi có sức sống tăng gấp đôi."
  },
  State_3017_Name = {
    Text = "Trạng thái @ lời nguyền điên cuồng"
  },
  State_3018_Desc = {
    Text = "\"Chó chiều không gian của sự trượt\" cứ mất 1 điểm sức sống thì loại bỏ 1 lớp. Khi số lớp bằng 0, nhận được [StateArg1] lá chắn và tái tạo [StateArg2] lớp rào chắn chiều."
  },
  State_3018_Name = {
    Text = "Rào cản chiều"
  },
  State_3019_Desc = {
    Text = "Cứ mỗi 10 dấu đen tiêu thụ hồi phục 1% sức sống"
  },
  State_3019_Name = {
    Text = "Trạng thái Nghịch Sinh của Gốc Sáng Tạo"
  },
  State_3019_WeaponDesc = {
    Text = "Cứ mỗi 10 dấu đen tiêu thụ hồi phục 1% sức sống"
  },
  State_3020_Desc = {
    Text = "Nếu đã bị thương trong lượt trước, bắt đầu lượt với 1 lượt kháng hiệu ứng."
  },
  State_3020_Name = {
    Text = "thích ứng"
  },
  State_3020_WeaponDesc = {
    Text = "Nếu đã bị thương trong lượt trước, bắt đầu lượt với 1 lượt kháng hiệu ứng."
  },
  State_3021_Desc = {
    Text = "Nhận 1 sức tính toán vào đầu lượt."
  },
  State_3021_Name = {
    Text = "Trạng thái@sức tính toán tối đa-2"
  },
  State_3023_Desc = {
    Text = "Mỗi lần chịu Sát thương chủ động trong lượt này, gây [Layer] điểm <FixedDamage:Sát Thương Thuần Túy> lên nguồn gây sát thương."
  },
  State_3023_Name = {
    Text = "Phản công nhất thời"
  },
  State_3023_WeaponDesc = {
    Text = "Mỗi lần chịu Sát thương chủ động, gây [Layer] điểm <FixedDamage:Sát Thương Thuần Túy> lên kẻ tấn công."
  },
  State_3024_Desc = {
    Text = "Người trang bị gây sát thương, tạo lá chắn và tăng hiệu ứng chữa trị [StateArg1]%. (tạm thời)"
  },
  State_3024_Name = {
    Text = "Trạng thái@Dao Thử Nghiệm - Chống Chết"
  },
  State_3025_Desc = {
    Text = "Mỗi khi đánh ra một lá bài, tăng tỷ lệ chí mạng trong lượt này lên 10%."
  },
  State_3026_Desc = {
    Text = "Sau khi chiến đấu bắt đầu, sẽ trộn [StateArg1] lá bài sao chép tạm thời vào rút bài từ bộ bài, giữ lại cả thẻ gốc lẫn thẻ phản chiếu."
  },
  State_3026_Name = {
    Text = "<Rune_8_High:Phản chiếu cao cấp>"
  },
  State_3026_WeaponDesc = {
    Text = "Sau khi chiến đấu bắt đầu, sẽ trộn [StateArg1] lá bài sao chép tạm thời vào rút bài từ bộ bài."
  },
  State_3027_Desc = {
    Text = "Sau khi chiến đấu kết thúc, thu được thêm 50 dấu đen và 1 thẻ triệu chứng."
  },
  State_3028_Name = {
    Text = "Trạng thái: Đầu vòng, sức tính toán tăng 2"
  },
  State_3029_Desc = {
    Text = "Mỗi khi nhận 1 điểm thương, giảm 1 lớp. Khi số lớp đạt đến 0, chuyển sang chế độ phòng thủ."
  },
  State_3029_Name = {
    Text = "Đếm thẻ bài"
  },
  State_3029_WeaponDesc = {
    Text = "Mỗi khi nhận 1 điểm thương, giảm 1 lớp. Khi số lớp đạt đến 0, chuyển sang chế độ phòng thủ."
  },
  State_3033_Desc = {
    Text = "Mỗi khi đánh ra 10 lá bài, bạn sẽ nhận được 1 lớp rào cản chống lại mọi loại sát thương. Nếu bạn đã có rào cản, sẽ hồi lại [Arg1] điểm sức sống."
  },
  State_3034_Desc = {
    Text = "Hiệu ứng duy nhất trong đội: Mỗi lần đánh ra 1 thẻ bài của người trang bị, nhận được <WeaponEffect_Num:[StateArg1]> năng lượng chìa khóa bạc. Hiệu ứng này tối đa chỉ có thể kích hoạt 3 lần trong một lượt."
  },
  State_3034_WeaponDesc = {
    Text = "Mỗi lần đánh ra 1 thẻ bài của người trang bị, bạn sẽ nhận được <WeaponEffect_Num:[StateArg1]> năng lượng chìa khóa bạc. Hiệu ứng này tối đa 3 lần mỗi lượt."
  },
  State_3035_Desc = {
    Text = "Khiến 1 râu chạm tấn công [StateArg1] lần."
  },
  State_3035_Name = {
    Text = "<Rune_11_High:cao cấp chỉ huy>"
  },
  State_3035_WeaponDesc = {
    Text = "Sau khi đánh ra, khiến 1 râu chạm tấn công mọi kẻ địch [StateArg1] lần."
  },
  State_30364_Desc = {
    Text = "Khi giữ thẻ bài này trong tay, giới hạn bài trong tay sẽ tăng thêm +1."
  },
  State_30364_Name = {
    Text = "Bỏ qua giới hạn bài trên tay"
  },
  State_30369_Desc = {
    Text = "Giới hạn bài trên tay trong lượt này + [Layer]."
  },
  State_30369_Name = {
    Text = "Kích tước tay tối đa"
  },
  State_3036_Desc = {
    Text = "Hiệu ứng suy yếu và yếu đuối tăng từ 33% lên 50%."
  },
  State_3036_Name = {
    Text = "\"dư âm diệt vong\""
  },
  State_3036_WeaponDesc = {
    Text = "Hiệu ứng suy yếu và yếu đuối tăng từ 33% lên 50%."
  },
  State_3038_Desc = {
    Text = "Đội duy nhất: Sau khi giải phóng lệnh khóa, người trang bị nhận được <WeaponEffect_Num:[StateArg1]> sức mạnh điên cuồng."
  },
  State_3038_WeaponDesc = {
    Text = "Sau khi giải phóng lệnh khóa, người trang bị nhận được <WeaponEffect_Num:[StateArg1]> sự điên cuồng."
  },
  State_3040_Desc = {
    Text = "Mỗi đầu lượt, gây [Layer] lớp [hạn chế] cho đội của tôi."
  },
  State_3040_Name = {
    Text = "Hạn chế"
  },
  State_3040_WeaponDesc = {
    Text = "Mỗi đầu lượt, gây [Layer] lớp [hạn chế] cho đội của tôi."
  },
  State_3041_Desc = {
    Text = "Được giữ vĩnh viễn trong bộ bài."
  },
  State_3041_Name = {
    Text = "<CardKeyWord:thẻ triệu chứng>"
  },
  State_3042_Desc = {
    Text = "Mỗi lần gây thương, nhận được [Arg1] sức mạnh trong lượt này, tối đa 3 lần. Khi đạt mức tối đa, hiệu ứng sẽ tăng gấp đôi."
  },
  State_3043_Desc = {
    Text = "Số lượt chẵn, giảm 50% sát thương nhận vào, tăng 33% sát thương gây ra."
  },
  State_3043_Name = {
    Text = "Biến đổi"
  },
  State_3043_WeaponDesc = {
    Text = "Số lượt chẵn, giảm 50% sát thương nhận vào, tăng 33% sát thương gây ra."
  },
  State_3045_Desc = {
    Text = "Sau khi giải phóng cơn thịnh nộ bùng phát, thân thể được đánh thức tương ứng nhận được 20 điểm điên cuồng."
  },
  State_3045_Name = {
    Text = "Màn che của thần vô danh"
  },
  State_3046_Desc = {
    Text = "Đội duy nhất: Mỗi khi một kẻ thù chết sẽ nhận [StateArg1] dấu đen. Khi người trang bị giết chết kẻ thù, sát thương chí mạng của người trang bị trong cấp độ này sẽ tăng vĩnh viễn <WeaponEffect_Num:[StateArg2]%>, tối đa tích lũy 5 lớp. Mỗi lần người trang bị kích hoạt hiệu ứng Bước nhảy, sát thương cuối cùng gây ra bởi người trang bị trong vòng này sẽ tăng <WeaponEffect_Num:[StateArg3]%>, tối đa tích lũy 3 lớp."
  },
  State_3046_WeaponDesc = {
    Text = "Mỗi khi một kẻ thù chết sẽ nhận [StateArg1] dấu đen. Khi người trang bị giết chết kẻ thù, sát thương chí mạng của người trang bị trong màn chơi này sẽ vĩnh viễn tăng <WeaponEffect_Num:[StateArg2]%>, tối đa tích lũy 5 lớp. Mỗi lần người trang bị kích hoạt hiệu ứng bước nhảy, sát thương cuối cùng trong lượt này của người trang bị sẽ tăng <WeaponEffect_Num:[StateArg3]%>, tối đa tích lũy 3 lớp."
  },
  State_3047_Desc = {
    Text = "Vào đầu mỗi lượt, nhận [Arg1] lá chắn, sau mỗi 1 lượt, giá trị lá chắn này tăng [Arg2]."
  },
  State_3047_Name = {
    Text = "Bàn Tay Thủ Hộ"
  },
  State_3048_Desc = {
    Text = "Lơ-tan's chiến ý không bao giờ ngừng nghỉ. Cuối mỗi lượt, Lơ-tan loại bỏ 3 lớp yếu đuối và tăng sát thương."
  },
  State_3048_Name = {
    Text = "lơ-tan thức tỉnh"
  },
  State_3049_Desc = {
    Text = "Tăng số lần sát thương trong đòn tấn công tiếp theo của George lên 1."
  },
  State_3049_Name = {Text = "Oán hận"},
  State_3049_WeaponDesc = {
    Text = "Tăng số lần sát thương trong đòn tấn công tiếp theo của George lên 1."
  },
  State_3050_Desc = {
    Text = "Khi trận đấu bắt đầu, trộn 1 lá [Cơn co giật] vào rút bài từ bộ bài."
  },
  State_3050_Name = {Text = "Sốc"},
  State_3050_WeaponDesc = {
    Text = "Khi trận đấu bắt đầu, trộn 1 lá [Cơn co giật] vào rút bài từ bộ bài."
  },
  State_3051_Desc = {
    Text = "Khi gây thương không bị chặn, sẽ trộn một lá Khóc thét vào rút bài từ bộ bài."
  },
  State_3051_Name = {
    Text = "lòng tham của giọt sáp cháy"
  },
  State_3051_WeaponDesc = {
    Text = "Khi gây thương thực tế, sẽ trộn một lá Khóc thét vào rút bài từ bộ bài."
  },
  State_3054_Name = {
    Text = "Trạng thái@sốc nguyền rủa"
  },
  State_3055_Desc = {
    Text = "Khi chiến đấu bắt đầu, gây 1 lớp yếu đuối cho đội của tôi."
  },
  State_3055_Name = {Text = "Qua thấu"},
  State_3055_WeaponDesc = {
    Text = "Khi chiến đấu bắt đầu, gây 1 lớp yếu đuối cho đội của tôi."
  },
  State_3056_Desc = {
    Text = "Khi kết thúc lượt, loại bỏ 1 lớp yếu đuối và tăng sát thương."
  },
  State_3056_Name = {Text = "Uy áp"},
  State_3058_Desc = {
    Text = "Với mỗi 1 râu chạm, cuối lượt nhận được [Arg1] lá chắn."
  },
  State_3058_Name = {
    Text = "Phụ Chi Vô Danh"
  },
  State_3060_Desc = {
    Text = "Được [Layer] điểm lá chắn vào đầu lượt tiếp theo."
  },
  State_3060_Name = {
    Text = "xây dựng tinh thần"
  },
  State_3060_WeaponDesc = {
    Text = "Đầu lượt tới, rút [Layer] lá bài."
  },
  State_3063_Desc = {
    Text = "Mỗi lần gây thương thực tế, thêm [Layer] trúng độc."
  },
  State_3063_Name = {
    Text = "Độc tố"
  },
  State_3064_Desc = {
    Text = "Chịu số tầng thương tương ứng trước khi đánh ra thẻ bài. Kết thúc lượt, giải trừ."
  },
  State_3064_Name = {
    Text = "Hạn chế"
  },
  State_3064_WeaponDesc = {
    Text = "Chịu số tầng thương tương ứng trước khi đánh ra thẻ bài. Kết thúc lượt, giải trừ."
  },
  State_3065_Name = {
    Text = "Trạng thái@lễ vật của quá khứ 2"
  },
  State_3068_Desc = {
    Text = "Sau khi kết thúc lượt, chịu [Layer] điểm <FixedDamage:Sát Thương Thuần Túy>."
  },
  State_3068_Name = {
    Text = "<IntoxicationColour:trúng độc>"
  },
  State_3068_WeaponDesc = {
    Text = "Sau khi kết thúc lượt, chịu [Layer] điểm <FixedDamage:Sát Thương Thuần Túy>."
  },
  State_3069_Name = {
    Text = "Trang sức Thần Cơ Giới"
  },
  State_3069_WeaponDesc = {
    Text = "Trong mỗi trận chiến, lượt đầu tiên sẽ nhận thêm 1 điểm sức tính toán."
  },
  State_3070_Desc = {
    Text = "Đội duy nhất: \"Đánh\" của người trang bị khiến mục tiêu mất <WeaponEffect_Num:[StateArg1]%> <PowerIconKeywords:lực lượng> tạm thời tương đương với sức tấn công của người trang bị. Hiệu ứng này chỉ có thể kích hoạt tối đa 3 lần trong một lượt."
  },
  State_3070_WeaponDesc = {
    Text = "Kẻ sử dụng \"đánh\" làm giảm tạm thời <WeaponEffect_Num:[Power:DescArg1]> điểm <PowerIconKeywords:lực lượng> của mục tiêu địch. Hiệu ứng này có thể kích hoạt tối đa 3 lần trong một lượt."
  },
  State_3071_Desc = {
    Text = "Đội duy nhất: Sau khi kích hoạt \"phòng thủ\" của người mang trang bị, nhận được <WeaponEffect_Num:[StateArg1]%> sức tấn công của người mang trang bị dưới dạng <PowerIconKeywords:lực lượng> tạm thời."
  },
  State_3071_WeaponDesc = {
    Text = "Sau khi sử dụng phòng thủ của trang bị, tăng thêm <WeaponEffect_Num:[Power:DescArg1]> điểm sức mạnh tạm thời<PowerIconKeywords:lực lượng>."
  },
  State_3072_Desc = {
    Text = "Đội duy nhất: Người trang bị giết kẻ địch sẽ nhận được <WeaponEffect_Num:[StateArg1]> cuồng nộ, tăng 1% thương chí mạng, áp dụng trong toàn bộ cuộc thám hiểm."
  },
  State_3072_WeaponDesc = {
    Text = "Người trang bị sau khi tiêu diệt địch sẽ nhận được <WeaponEffect_Num:[StateArg1]> sức mạnh điên cuồng, tăng thêm 1% sát thương chí mạng, hiệu lực trong suốt cuộc khám phá."
  },
  State_3073_Desc = {
    Text = "Đội duy nhất: Sau khi người trang bị kích hoạt sự bùng nổ điên cuồng, tỷ lệ chí mạng của tất cả đồng minh trong lượt này tăng <WeaponEffect_Num:[StateArg1]%>."
  },
  State_3073_WeaponDesc = {
    Text = "Người trang bị sau khi phát động sự bùng nổ điên cuồng, tỷ lệ chí mạng của toàn bộ đồng minh trong lượt này tăng <WeaponEffect_Num:[StateArg1]%>."
  },
  State_3074_Desc = {
    Text = "Đội duy nhất: Khi chơi một thẻ triệu chứng, người trang bị nhận được <WeaponEffect_Num:[StateArg1]> điểm điên cuồng. Hiệu ứng này có thể kích hoạt tối đa 2 lần trong một lượt. Sau khi người trang bị chơi 1 thẻ lệnh, họ nhận được 1 điểm điên cuồng."
  },
  State_3074_WeaponDesc = {
    Text = "Khi đánh một thẻ triệu chứng, người trang bị nhận được <WeaponEffect_Num:[StateArg1]> điểm điên cuồng. Hiệu ứng này có thể kích hoạt tối đa 2 lần trong một lượt. Sau khi đánh 1 thẻ lệnh, họ nhận được 1 điểm điên cuồng."
  },
  State_3075_Desc = {
    Text = "Đội duy nhất: Sau khi người trang bị kích hoạt điên cuồng bùng phát, nhận được lá chắn tương đương với <WeaponEffect_Num:[StateArg1]%> khả năng phòng thủ."
  },
  State_3075_Name = {
    Text = "tường thành của trái tim"
  },
  State_3075_WeaponDesc = {
    Text = "Người trang bị sau khi phát động điên cuồng bùng phát, nhận được <WeaponEffect_Num:[Block:DescArg1]> điểm lá chắn."
  },
  State_3076_Desc = {
    Text = "Đội duy nhất: Sau khi Người trang bị gây Sát thương chủ động, Tỉ lệ chí mạng của họ tăng <WeaponEffect_Num:[StateArg1]%>, sau khi gây Đòn đánh chí mạng sẽ xóa toàn bộ Tỉ lệ chí mạng đã nhận được từ hiệu ứng này."
  },
  State_3076_WeaponDesc = {
    Text = "Sau khi Người trang bị gây Sát thương chủ động, Tỉ lệ chí mạng của họ tăng <WeaponEffect_Num:[StateArg1]%>, sau khi gây Đòn đánh chí mạng sẽ xóa toàn bộ Tỉ lệ chí mạng đã nhận được từ hiệu ứng này."
  },
  State_3078_Desc = {
    Text = "Trong lượt này, mọi sát thương gây ra chắc chắn sẽ tạo sát thương chí mạng."
  },
  State_3078_Name = {
    Text = "Tạm thời bùng nổ"
  },
  State_3078_WeaponDesc = {
    Text = "Trong lượt này, tỷ lệ chí mạng tăng 100%"
  },
  State_3082_Desc = {
    Text = "Sau khi kích hoạt cơn thịnh nộ bùng phát, một thẻ bài ngẫu nhiên tương ứng với thân thể được đánh thức sẽ được đặt vào tay, thẻ này mang thuộc tính tiêu thụ và hư vô."
  },
  State_3082_Name = {
    Text = "túi xách bác sĩ"
  },
  State_3084_Desc = {
    Text = "Đánh ra sau sẽ thêm [StateArg1] bản sao của thẻ bài vào không gian tạm thời<DimensionalSpaceIconKeywords:siêu việt không gian>."
  },
  State_3084_Name = {
    Text = "<Rune_13_High:cao cấp dịch chuyển>"
  },
  State_3084_WeaponDesc = {
    Text = "Đánh ra sau đó tiêu thụ, nhưng sẽ đưa [StateArg1] lá tạm thời vào không gian siêu việt."
  },
  State_3087_Desc = {
    Text = "Sát thương từ lá bài tăng [Layer] %."
  },
  State_3087_Name = {
    Text = "Thẻ đánh gây thương tăng tạm thời"
  },
  State_3087_WeaponDesc = {
    Text = "Sát thương từ lá bài tăng [Layer] %."
  },
  State_3088_Desc = {
    Text = "Sát thương chủ động nhận phải tăng [Layer]. Mỗi lần chịu sát thương, vùng tổn thương sẽ bị rỗng rỗng và lan rộng, sau đó hồi phục vào đầu lượt."
  },
  State_3088_Name = {
    Text = "Sự tan chảy sâu"
  },
  State_3088_WeaponDesc = {
    Text = "Thương chủ động nhận phải tăng [Layer]. Mỗi lần nhận thương, vết loét sẽ rỗng rỗng và mở rộng, hồi phục vào đầu lượt."
  },
  State_3092_Name = {
    Text = "Nếu là trận chiến với thủ lĩnh, tất cả thức tỉnh giả nhận được 30 điểm điên cuồng và giải trừ trạng thái phong ấn"
  },
  State_3093_Name = {
    Text = "Trạng thái@đếm số lần giả dạng kỳ thuật sư"
  },
  State_3094_Desc = {
    Text = "Khi rút được sẽ làm bản thân yếu đuối 1 lượt. Sau khi sử dụng, sẽ làm tăng sát thương cho tất cả kẻ địch 1 lượt. Không thể bán."
  },
  State_3094_Name = {
    Text = "Trạng thái sự sụp đổ của lời nguyền"
  },
  State_3094_WeaponDesc = {
    Text = "Khi rút được sẽ làm bản thân yếu đuối 1 lượt. Sau khi sử dụng, sẽ làm tăng sát thương cho tất cả kẻ địch 1 lượt. Không thể bán."
  },
  State_3095_Desc = {
    Text = "Thương gây ra trong lần chơi này tăng [Layer] điểm."
  },
  State_3095_Name = {
    Text = "Sức mạnh vĩnh viễn"
  },
  State_3095_WeaponDesc = {
    Text = "Thương gây ra trong lần chơi này tăng [Layer] điểm."
  },
  State_3096_Desc = {
    Text = "Đường để thuyết phục lơ tan còn rất dài."
  },
  State_3096_Name = {
    Text = "lơ-tan thức tỉnh"
  },
  State_3098_Desc = {
    Text = "Nhặt lên và chọn một thẻ bài, giảm tiêu thụ sức tính toán của nó xuống còn 1 vĩnh viễn."
  },
  State_3099_Desc = {
    Text = "Sau khi giải phóng cơn điên cuồng, tăng thêm [Arg1] sức mạnh trong lượt này."
  },
  State_3100_Desc = {
    Text = "Mỗi khi bắt đầu lượt, kháng cự tử vong tăng 10%. Khi kháng cự tử vong vượt quá 100%, nhận thêm 30 điểm chuyên môn giới vực."
  },
  State_3104_Desc = {
    Text = "Trong lượt này, mỗi lần nhận 1 lần thương chủ động, sẽ tăng số lần gây thương của \"Quỷ Ác Ngọt Ngào\" thêm 1."
  },
  State_3104_Name = {
    Text = "Chia sẻ đau đớn"
  },
  State_3104_WeaponDesc = {
    Text = "Trong lượt này, mỗi lần nhận 1 lần thương chủ động, sẽ tăng số lần gây thương của \"Quỷ Ác Ngọt Ngào\" thêm 1."
  },
  State_3106_Desc = {
    Text = "Khi sức sống dưới 50%([StateArg1]), sẽ phân chia thành 2 con \"bài tập thí nghiệm\" có lượng sức sống bằng nhau."
  },
  State_3106_Name = {Text = "Phân chia"},
  State_3106_WeaponDesc = {
    Text = "Khi sức sống dưới 50%([StateArg1]), sẽ phân chia thành 3 \"thân thể bị ăn mòn loại II bình tượng nến\" có lượng sức sống bằng nhau."
  },
  State_3108_Name = {
    Text = "Vật phẩm thơ vòng"
  },
  State_3108_WeaponDesc = {
    Text = "Sau khi bắt đầu lượt chẵn, nhận được 1 điểm năng lực tính toán."
  },
  State_3109_Name = {
    Text = "Trạng thái @ Chương 4 cảm ứng @ sức tính toán giảm 1"
  },
  State_3109_WeaponDesc = {
    Text = "\"Quà đáp lại ngây thơ\" giảm 1 tiêu thụ sức tính toán"
  },
  State_3110_Name = {
    Text = "Trạng thái @ Chương 4 cảm ứng @ sức tính toán giảm 1"
  },
  State_3110_WeaponDesc = {
    Text = "\"Quà đáp lại ngây thơ\" giảm 1 tiêu thụ sức tính toán"
  },
  State_3111_Desc = {
    Text = "Vào đầu lượt tiếp theo, chuyển đổi lá chắn còn lại thành gấp đôi sức sống"
  },
  State_3111_Name = {
    Text = "Bunga Abadi"
  },
  State_3112_Desc = {
    Text = "Đội duy nhất: Ngộ độc gây ra bởi người trang bị tăng <WeaponEffect_Num:[StateArg3]%>. Sau khi người trang bị phát động cơn thịnh nộ bùng phát, hồi phục sức sống tương đương với <WeaponEffect_Num:[StateArg1]%> thể chất của người trang bị, mỗi khi còn lại 1 điểm tính toán sẽ hồi phục thêm <WeaponEffect_Num:[StateArg2]%> sức sống của người trang bị."
  },
  State_3112_Name = {
    Text = "Yến tiệc lặng yên"
  },
  State_3112_WeaponDesc = {
    Text = "Người trang bị gây ra ngộ độc tăng <WeaponEffect_Num:[StateArg3]%>. Sau khi người trang bị phát động bùng nổ, hồi phục <WeaponEffect_Num:[Heal:DescArg1]> điểm sinh lực, mỗi 1 điểm điểm tính toán còn lại sẽ hồi phục thêm <WeaponEffect_Num:[Heal:DescArg2]> điểm sinh lực."
  },
  State_3113_Desc = {
    Text = "Trạng thái@Chương mở đầu điên cuồng 0_1_4"
  },
  State_3113_Name = {
    Text = "Trạng thái@Chương mở đầu điên cuồng 0_1_4"
  },
  State_3113_WeaponDesc = {
    Text = "Trạng thái@Chương mở đầu điên cuồng 0_1_4"
  },
  State_3114_Desc = {
    Text = "Trạng thái@Phần mở đầu điên cuồng 0_1_2"
  },
  State_3114_Name = {
    Text = "Trạng thái@Phần mở đầu điên cuồng 0_1_2"
  },
  State_3114_WeaponDesc = {
    Text = "Trạng thái@Phần mở đầu điên cuồng 0_1_2"
  },
  State_3115_Desc = {
    Text = "Trạng thái@Phần mở đầu điên cuồng 0_1_2"
  },
  State_3115_Name = {
    Text = "Trạng thái@Phần mở đầu điên cuồng 0_1_2"
  },
  State_3115_WeaponDesc = {
    Text = "Trạng thái@Phần mở đầu điên cuồng 0_1_2"
  },
  State_3116_Name = {
    Text = "Trạng thái@Chương mở đầu điên cuồng 0_1_1"
  },
  State_3117_Desc = {
    Text = "Đội duy nhất: Người trang bị có sát thương cơ bản của \"đánh\" và \"cơn thịnh nộ bùng phát\" tăng <WeaponEffect_Num:[StateArg1]%>. Khi người trang bị thực hiện \"đánh\", họ nhận được 5% tỷ lệ chí mạng tạm thời, tối đa 3 lần mỗi lượt. Khi đạt 3 lần, họ nhận được 15% thương harming chí mạng tạm thời."
  },
  State_3117_WeaponDesc = {
    Text = "Người trang bị có sát thương cơ bản của \"đánh\" và \"cơn thịnh nộ bùng phát\"được tăng <WeaponEffect_Num:[StateArg1]%>. Khi người trang bị thực hiện \"đánh\", họ nhận được 5% tỷ lệ chí mạng tạm thời, tối đa 3 lần mỗi lượt. Khi đạt 3 lần, họ nhận thêm 15% sát thương chí mạng tạm thời."
  },
  State_3118_Desc = {
    Text = "Vào đầu lượt, hồi phục [Layer]% máu đã mất."
  },
  State_3118_Name = {
    Text = "Sự che chở của Cánh Buồm Dẫn Lái"
  },
  State_3120_Desc = {
    Text = "[Phòng thủ] nhận được [Arg1] lượt phản công."
  },
  State_3121_Desc = {
    Text = "Nếu ý định của kẻ địch không phải là tấn công, sau khi gây thương tổn chủ động hoặc thương tổn xúc tu, sẽ thêm chảy máu tương đương với một nửa số lớp thương."
  },
  State_3123_Desc = {
    Text = "Đội duy nhất: <RetaliateIconKeywords: Phản công> do người trang bị gây ra tăng <WeaponEffect_Num:[StateArg3]%>. Mỗi khi bị tấn công 1 lần, nhận được <WeaponEffect_Num:[StateArg1]%> <PowerIconKeywords:lực lượng> tạm thời tương đương với sức tấn công của người trang bị. Sau khi người trang bị sử dụng cơn thịnh nộ bùng phát, nhận được <WeaponEffect_Num:[StateArg2]%><RetaliateIconKeywords: phản công> tương đương với sức tấn công của người trang bị."
  },
  State_3123_WeaponDesc = {
    Text = "Người trang bị gây tăng phản công <WeaponEffect_Num:[StateArg3]%>. Mỗi khi bị tấn công 1 lần, nhận được <WeaponEffect_Num:[Power:DescArg1]> điểm <PowerIconKeywords:lực lượng> tạm thời. Sau khi người trang bị sử dụng cơn thịnh nộ bùng phát, nhận được <WeaponEffect_Num:[Counterattack:DescArg2]> điểm phản công."
  },
  State_3124_Desc = {
    Text = "Thám tử may mắn nhận được gấp đôi dấu đen."
  },
  State_3124_Name = {
    Text = "Sự may mắn tuyệt vời"
  },
  State_3124_WeaponDesc = {
    Text = "Thám tử may mắn nhận được gấp đôi dấu đen."
  },
  State_3127_Name = {
    Text = "Trạng thái @ quan2_10 chiến đấu3 bong1"
  },
  State_3128_Desc = {
    Text = "Tất cả hiệu ứng hồi sức sống và tạo lá chắn từ thân thể thức tỉnh được tăng [StateArg1]%."
  },
  State_3128_Name = {Text = "nôi"},
  State_3129_Desc = {
    Text = "Mỗi lần chịu Sát thương chủ động trước khi bắt đầu lượt tiếp theo, kích hoạt thêm [Layer] lần phản công và phản công xúc tu, gây 50% sát thương."
  },
  State_3129_Name = {
    Text = "Vảy ngược bảo hộ"
  },
  State_3130_Desc = {
    Text = "Thương gây ra trong lượt này được tăng [Layer] điểm."
  },
  State_3130_Name = {
    Text = "Sức mạnh tạm thởi"
  },
  State_3130_WeaponDesc = {
    Text = "Thương gây ra trong lượt này được tăng [Layer] điểm."
  },
  State_3135_Desc = {
    Text = "Mỗi khi sở hữu 1 tầng, số lần sát thương chủ động gây ra sẽ +1."
  },
  State_3135_Name = {
    Text = "<MadnessIconKeywords:Điên loạn>"
  },
  State_3136_Name = {
    Text = "điên cuồng"
  },
  State_3137_Desc = {
    Text = "Khi trận chiến bắt đầu, tạo ra 1 râu chạm, thương tổn xúc tu được tăng vĩnh viễn [Arg1]."
  },
  State_3138_Name = {
    Text = "Trang sức nhị luật bối phản"
  },
  State_3138_WeaponDesc = {
    Text = "Người trang bị sau khi sử dụng cơn thịnh nộ bùng phát, bên mình sẽ nhận được <RetaliateIconKeywords:phản công> dựa trên 100% phòng thủ của người trang bị. Đồng thời, tăng 10% <RetaliateIconKeywords:phản công> hiện tại của chính mình."
  },
  State_3139_Desc = {
    Text = "Sau khi vào lượt siêu việt, giải trừ trạng thái suy yếu và yếu đuối cho bản thân, đồng thời khiến tất cả kẻ địch bị suy yếu và tăng sát thương trong 2 lượt."
  },
  State_3140_Desc = {
    Text = "Khi bắt đầu chiến đấu, đặt \"ảo giác\" vào không gian siêu việt, cho đến khi không gian siêu việt của bạn đạt 4 lá."
  },
  State_3143_Desc = {
    Text = "Khi gây thương thực tế, khiến đội của tôi mất [Layer] lực lượng."
  },
  State_3143_Name = {
    Text = "chích điện"
  },
  State_3144_Name = {
    Text = "Đội của chúng tôi giảm một nửa lớp \"trúng độc\" và \"chảy máu\""
  },
  State_3145_Desc = {
    Text = "Trong [Layer] lượt, không thể sử dụng thẻ bài."
  },
  State_3145_Name = {
    Text = "Không thể đánh thẻ bài"
  },
  State_3146_Desc = {
    Text = "Khi Sứ Giả Biển đánh ra 1 lá bài, tạo ra [StateArg1] râu chạm tạm thời, râu chạm này không bị giới hạn bởi số lượng tối đa."
  },
  State_3146_Name = {
    Text = "Quyền năng thay thế"
  },
  State_3146_WeaponDesc = {
    Text = "Khi Sứ Giả Biển đánh ra 1 lá bài, tạo ra [StateArg1] râu chạm tạm thời, râu chạm này không bị giới hạn bởi số lượng tối đa."
  },
  State_3149_Desc = {
    Text = "Khi bắt đầu lượt tiếp theo, Tăng Sát Thương chủ động và thương tổn xúc tu nhận vào thêm 50 %."
  },
  State_3149_Name = {
    Text = "Trễ tăng sát thương"
  },
  State_3149_WeaponDesc = {
    Text = "Mọi sát thương nhận vào tăng 50%."
  },
  State_3150_Desc = {
    Text = "Sau khi bị tấn công 3 lần trong một vòng, nhận 1 lớp tạm thời <MadnessColour:điên rồ>."
  },
  State_3150_Name = {
    Text = "\"nỗi đau ngọt ngào\""
  },
  State_3151_Desc = {
    Text = "Nhặt được sẽ nhận vĩnh viễn [Arg1] điểm lực lượng."
  },
  State_3152_Name = {
    Text = "Trạng thái@phụ kiện tái tiến hóa"
  },
  State_3152_WeaponDesc = {
    Text = "Trang bị nhận được 3 điểm điên cuồng sau khi lượt hành động kết thúc. Nếu trang bị có hồi phục điên cuồng lớn hơn 10, nhận thêm 2 điểm điên cuồng."
  },
  State_3153_Name = {
    Text = "Trạng thái @lời nguyền loạn trí hoàn lại"
  },
  State_3154_Name = {
    Text = "Tỉ lệ chí mạng"
  },
  State_3155_Desc = {
    Text = "Mỗi lượt phục hồi 10% sức sống đã mất."
  },
  State_3155_Name = {Text = "Y tế"},
  State_3155_WeaponDesc = {
    Text = "Mỗi lượt phục hồi 10% sức sống đã mất."
  },
  State_3156_Desc = {
    Text = "Mỗi vòng, đoạn thương đầu tiên nhận phải sẽ tăng lên 5 lần."
  },
  State_3156_Name = {
    Text = "Hoảng loạn"
  },
  State_3160_Desc = {
    Text = "Vào đầu lượt, thêm một lá \"dù\" có [Arg1] Giữ mình vào tay, sau khi đánh ra 6 lá thẻ bài, tăng Giữ mình của tất cả các lá \"dù\" trong tay lên [Arg2]."
  },
  State_3161_Desc = {
    Text = "Số lượng bài rút của đối thủ giảm [Layer], nhưng tất cả các lá bài đều được giữ."
  },
  State_3161_WeaponDesc = {
    Text = "Số lượng rút bài của đội tôi giảm [Layer], tất cả các lá bài được giữ lại"
  },
  State_3163_Desc = {
    Text = "Sau khi kích hoạt kháng cự tử vong, phục hồi [Layer] điểm sức sống."
  },
  State_3163_Name = {
    Text = "Berço của các ngôi sao"
  },
  State_3163_WeaponDesc = {
    Text = "Sau khi kích hoạt kháng cự tử vong, phục hồi [Layer] điểm sức sống."
  },
  State_3164_Name = {
    Text = "Bộ đếm nỗi hận dài dằng dặc"
  },
  State_3165_Name = {
    Text = "Kẻ lẩn trốn Khởi Linh 3"
  },
  State_3166_Name = {
    Text = "Cuộc chiến này đã được kích hoạt"
  },
  State_3168_Desc = {
    Text = "Vào đầu lượt, tăng bộ đếm số lần tấn công cho tất cả quái vật"
  },
  State_3168_Name = {
    Text = "Trạng thái@lưỡi dao khổng lồ trả thù cắt đầu trọng thương"
  },
  State_3168_WeaponDesc = {
    Text = "Vào đầu lượt, tăng bộ đếm số lần tấn công cho tất cả quái vật"
  },
  State_3170_Desc = {
    Text = "Chi phí của việc gây ra xung động"
  },
  State_3170_Name = {
    Text = "Chi phí của việc gây ra xung động"
  },
  State_3170_WeaponDesc = {
    Text = "Chi phí của việc gây ra xung động"
  },
  State_3171_Name = {
    Text = "Trạng thái@vòng 2_1 chiến đấu 3 bong bóng 1"
  },
  State_3172_Desc = {
    Text = "Mỗi lần gây sát thương, nhận được [StateArg1] điểm lực lượng tạm thời, tối đa [StateArg2] lần. Khi số lớp đầy, hiệu ứng tăng gấp đôi."
  },
  State_3172_Name = {
    Text = "Đá cuội ánh máu sáng tạo"
  },
  State_3174_Desc = {
    Text = "Giảm sức sống 30%."
  },
  State_3174_Name = {
    Text = "Lục Phân Nghi Sáng Tạo 2"
  },
  State_3174_WeaponDesc = {
    Text = "Giảm sức sống 30%."
  },
  State_3175_Desc = {
    Text = "Mỗi đầu lượt, tất cả các thân thể thức tỉnh nhận được 10 điểm điên cuồng."
  },
  State_3175_Name = {
    Text = "Sáng tạo Thiết bị lục phân 1"
  },
  State_3175_WeaponDesc = {
    Text = "Mỗi đầu lượt, tất cả các thân thể thức tỉnh nhận được 10 điểm điên cuồng."
  },
  State_3176_Desc = {
    Text = "Chương mở đầu đặt lại bộ bài 0_1_1_1"
  },
  State_3176_Name = {
    Text = "Chương mở đầu đặt lại bộ bài 0_1_1_1_2"
  },
  State_3176_WeaponDesc = {
    Text = "Chương mở đầu đặt lại bộ bài 0_1_1_1"
  },
  State_3177_Desc = {
    Text = "\"Cảnh giác\"đạt 3 lớp thì lùi lại và triệu hồi một \"Thế thân bình tượng nến\". Khi lượt mới bắt đầu, số lớp sẽ được làm trống."
  },
  State_3177_Name = {
    Text = "Cảnh giác"
  },
  State_3177_WeaponDesc = {
    Text = "\"Cảnh giác\"đạt 3 lớp thì lùi lại và triệu hồi một \"Thế thân bình tượng nến\". Khi lượt mới bắt đầu, số lớp sẽ được làm trống."
  },
  State_3178_Desc = {
    Text = "Làm tăng tiêu thụ sức tính toán của thẻ bài."
  },
  State_3178_Name = {
    Text = "<SlowIconKeywords: chậm chạp>"
  },
  State_3178_WeaponDesc = {
    Text = "Mỗi lớp làm chậm khiến tiêu thụ sức tính toán của thẻ bài tăng thêm 1 điểm."
  },
  State_3179_Desc = {
    Text = "Được 20 lá chắn khi bắt đầu chiến đấu. Nếu có lá chắn vào đầu mỗi lượt, trong lượt đó, cường độ của lá chắn và khả năng chữa trị tăng thêm 50%."
  },
  State_3179_Name = {
    Text = "Người Bảo Vệ Vườn Dị Hóa"
  },
  State_3179_WeaponDesc = {
    Text = "Được 20 lá chắn khi bắt đầu chiến đấu. Nếu có lá chắn vào đầu mỗi lượt, trong lượt đó, cường độ của lá chắn và khả năng chữa trị tăng thêm 50%."
  },
  State_3180_Desc = {
    Text = "Tỷ lệ chí mạng tăng 25%. Sau khi hồi sức sống, có xác suất gây thêm 1 lần hồi sức sống, xác suất bằng tỷ lệ chí mạng của người gây hồi sức sống."
  },
  State_3180_Name = {
    Text = "Trạng thái @Chìa Khóa Bạc Mộng Ảo: Chữa trị chí mạng"
  },
  State_3181_Name = {
    Text = "Tỉ lệ chí mạng"
  },
  State_3183_Desc = {
    Text = "Trong lượt này, sát thương chí mạng tăng [Layer]%."
  },
  State_3183_Name = {
    Text = "Sát thương bạo kích tạm thời"
  },
  State_3185_Desc = {
    Text = "Khi di chuyển, áp lực tăng thêm"
  },
  State_3185_Name = {
    Text = "Túi vô đáy của sáng tạo 2"
  },
  State_3185_WeaponDesc = {
    Text = "Khi di chuyển, áp lực tăng thêm"
  },
  State_3189_Name = {
    Text = "Quái vật trì hoãn lực lượng"
  },
  State_3190_Name = {
    Text = "Chìa khóa tạo vật"
  },
  State_3193_Desc = {
    Text = "Sau khi bắt đầu lượt tiếp theo, nhận được [Layer] lá chắn."
  },
  State_3193_Name = {
    Text = "Nghệ thuật bị mất"
  },
  State_3193_WeaponDesc = {
    Text = "Sau khi bắt đầu lượt tiếp theo, nhận được [Layer] lá chắn."
  },
  State_3196_Desc = {
    Text = "Sau khi đánh ra, nhận được [StateArg1] điểm sức tính toán."
  },
  State_3196_Name = {
    Text = "<Rune_4_High:mưu tính cao cấp>"
  },
  State_3196_WeaponDesc = {
    Text = "Sau khi đánh ra, nhận được [StateArg1] điểm sức tính toán."
  },
  State_3197_Desc = {
    Text = "\"đánh\" hồi [Arg1] điểm sức sống, và giảm một nửa số lớp chảy máu và trúng độc của bản thân."
  },
  State_3197_Name = {
    Text = "Kẹp Cầm Máu"
  },
  State_3200_Desc = {
    Text = "Đội duy nhất: Sát thương cơ bản và lá chắn của người trang bị tăng <WeaponEffect_Num:[StateArg1]%>. Khi bắt đầu khám phá, thêm một lá \"đánh\" và \"phòng thủ\" của người trang bị vào bộ bài. Sau khi người trang bị sử dụng \"phòng thủ\", tỷ lệ chí mạng và sát thương chí mạng của \"đánh\" tiếp theo tăng 15%. Sau khi người trang bị sử dụng \"đánh\", lá chắn của \"phòng thủ\" tiếp theo tăng 15%, hiệu ứng có thể cộng dồn tối đa 3 lần."
  },
  State_3200_WeaponDesc = {
    Text = "Trang bị gây sát thương cơ bản và tạo lá chắn tăng <WeaponEffect_Num:[StateArg1]%>. Khi bắt đầu khám phá, thêm một lá \"Đánh\" và \"Phòng thủ\" của trang bị vào bộ bài. Sau khi trang bị sử dụng \"Phòng thủ\", tỷ lệ chí mạng và thương harming chí mạng của lá \"Đánh\" tiếp theo tăng 15%. Sau khi trang bị sử dụng \"Đánh\", lá chắn của lá \"Phòng thủ\" tiếp theo tăng 15%. Hiệu ứng này có thể cộng dồn tối đa 3 lần."
  },
  State_3201_Name = {
    Text = "Xích nô lệ"
  },
  State_3203_Desc = {
    Text = "Đội duy nhất: Lá chắn tăng cường do Người trang bị gây ra tăng <WeaponEffect_Num:[StateArg3]%>. \"Phòng thủ\" của Người trang bị gây <IntoxicationIconKeywords:Ngộ độc> bằng <WeaponEffect_Num:[StateArg1]%> Phòng thủ của Người trang bị lên kẻ địch có Sinh lực cao nhất. Nếu Cõi hiện tại là \"Huyết Nhục\", khi gây <IntoxicationIconKeywords:Ngộ độc>, <EmbryoFusionIconKeywords:Dung hợp Phôi thai> + <WeaponEffect_Num:[Blood:StateArg2]>, hiệu ứng này tối đa kích hoạt 3 lần mỗi lượt."
  },
  State_3203_WeaponDesc = {
    Text = "Lá chắn tăng cường do Người trang bị gây ra tăng <WeaponEffect_Num:[StateArg3]%>. \"Phòng thủ\" của Người trang bị gây <WeaponEffect_Num:[Poison:DescArg1]> lớp <IntoxicationIconKeywords:Ngộ độc> lên kẻ địch có Sinh lực cao nhất. Nếu Cõi hiện tại là \"Huyết Nhục\", khi gây <IntoxicationIconKeywords:Ngộ độc>, <EmbryoFusionIconKeywords:Dung hợp Phôi thai> +<WeaponEffect_Num:[Blood:StateArg2]>, hiệu ứng này tối đa kích hoạt 3 lần mỗi lượt."
  },
  State_3204_Desc = {
    Text = "Khi gây sát thương thực tế, sẽ trộn [StateArg1] lá \"vết thương\" vào rút bài từ bộ bài."
  },
  State_3204_Name = {
    Text = "Viết rách"
  },
  State_3204_WeaponDesc = {
    Text = "Sau khi rút khiến bản thân yếu đuối 1 lượt. Sau khi sử dụng, khiến tất cả kẻ địch yếu đuối 1 lượt. Không thể bán."
  },
  State_3206_Desc = {
    Text = "Mỗi lần đánh ra 1 lá bài, tăng tỷ lệ chí mạng trong lượt này [StateArg1]%, tối đa [StateArg2] lần. Khi số tầng đạt đến giới hạn, hiệu ứng sẽ tăng gấp đôi."
  },
  State_3206_Name = {
    Text = "Gương lễ nghi Memphis của sáng tạo"
  },
  State_3206_WeaponDesc = {
    Text = "Mỗi lần đánh ra 1 lá bài, tăng tỷ lệ chí mạng trong lượt này [StateArg1]%, tối đa [StateArg2] lần. Khi số tầng đạt đến giới hạn, hiệu ứng sẽ tăng gấp đôi."
  },
  State_3207_Desc = {
    Text = "Mỗi khi mất 1 điểm sức sống sẽ loại bỏ 1 lớp, khi hết lớp sẽ nhận được [DescArg1] lá chắn."
  },
  State_3207_Name = {
    Text = "Rào cản chiều"
  },
  State_3208_Desc = {
    Text = "Đá hóa, không thể hành động, sau khi kết thúc lượt sẽ bị gỡ bỏ."
  },
  State_3208_Name = {
    Text = "<PetrifactionColour: Đá hóa>"
  },
  State_3209_Name = {
    Text = "Trang sức sinh lực hút"
  },
  State_3209_WeaponDesc = {
    Text = "Sau khi chiến đấu bắt đầu, nếu nghề của người mang là thịt máu, sức tấn công tăng lên 25%."
  },
  State_3210_Name = {
    Text = "Trạng thái - lưỡi đao trả thù khởi linh 1"
  },
  State_3211_Desc = {
    Text = "Giới hạn số bài trong tay tăng 2, không còn phải bỏ bài khi kết thúc lượt. Mỗi khi mất máu, ngẫu nhiên bỏ 2 bài trong tay."
  },
  State_3212_Desc = {
    Text = "Giảm 25% Sát thương chủ động và thương tổn xúc tu gây ra, khi kết thúc lượt xóa 1 lớp."
  },
  State_3212_Name = {
    Text = "<WeaknessIconKeywords: yếu đuối>"
  },
  State_3212_WeaponDesc = {
    Text = "Thương gây ra giảm 25%."
  },
  State_3213_Desc = {
    Text = "Hiệu ứng của lá chắn và chữa trị tăng lên [Layer] %"
  },
  State_3213_Name = {
    Text = "Lá chắn tạm thời và chữa trị mạnh mẽ"
  },
  State_3213_WeaponDesc = {
    Text = "Hiệu ứng của lá chắn và chữa trị tăng lên [Layer] %"
  },
  State_3215_Name = {
    Text = "Linh bài thời gian \"Ẩn mật\""
  },
  State_3216_Desc = {
    Text = "Sau khi chiến đấu kết thúc, nhận thêm 100 dấu đen, nhưng nhận một thẻ triệu chứng."
  },
  State_3216_Name = {
    Text = "Vòng sáng tạo may mắn"
  },
  State_3216_WeaponDesc = {
    Text = "Sau khi chiến đấu kết thúc, nhận thêm 100 dấu đen, nhưng nhận một thẻ triệu chứng."
  },
  State_3220_Desc = {
    Text = "Sau khi cơn thịnh nộ bùng phát, rút 1 lá bài.Nếu sức sống dưới 25%,rút thêm 1 lá bài."
  },
  State_3223_Desc = {
    Text = "Tăng 10% hiệu ứng yếu đuối. Mỗi 3 hiệp, thêm 1 lớp yếu đuối cho tất cả kẻ địch."
  },
  State_3224_Name = {
    Text = "Sáng tạo Arcana ghi chép sức tính toán"
  },
  State_3225_Name = {
    Text = "đòn tấn công gãy cổ"
  },
  State_3226_Desc = {
    Text = "Sau khi đánh, thẻ bài sẽ không vào rác bài và không thể sử dụng lại trong cuộc chiến đấu này."
  },
  State_3226_Name = {
    Text = "tiêu thụ"
  },
  State_3226_WeaponDesc = {
    Text = "Sau khi đánh, thẻ bài sẽ không vào rác bài và không thể sử dụng lại trong cuộc chiến đấu này."
  },
  State_3227_Desc = {
    Text = "Tất cả giá của các sáng tạo giảm 50%."
  },
  State_3227_Name = {
    Text = "Huân chương Thương mại Sáng tạo"
  },
  State_3227_WeaponDesc = {
    Text = "Tất cả giá của các sáng tạo giảm 50%."
  },
  State_3228_Desc = {
    Text = "Vào đầu lượt, thân thể được đánh thức có ít nhất điên cuồng nhận được 25 điên cuồng"
  },
  State_3228_Name = {
    Text = "Arcana sáng tạo điên cuồng"
  },
  State_3228_WeaponDesc = {
    Text = "Vào đầu lượt, thân thể được đánh thức có ít nhất điên cuồng nhận được 25 điên cuồng"
  },
  State_3229_Desc = {
    Text = "Chương mở đầu đặt lại bộ bài 0_1_1_1"
  },
  State_3229_Name = {
    Text = "Chương mở đầu đặt lại bộ bài 0_1_1_1"
  },
  State_3229_WeaponDesc = {
    Text = "Chương mở đầu đặt lại bộ bài 0_1_1_1"
  },
  State_3230_Name = {
    Text = "Trạng thái@độ trễ trong sức tính toán"
  },
  State_3232_Desc = {
    Text = "Trạng thái@quái vật siêu việt khe cắm bộ kích hoạt"
  },
  State_3232_Name = {
    Text = "Trạng thái@quái vật siêu việt khe cắm bộ kích hoạt"
  },
  State_3232_WeaponDesc = {
    Text = "Trạng thái@quái vật siêu việt khe cắm bộ kích hoạt"
  },
  State_3234_Desc = {
    Text = "Khi bắt đầu chiến đấu, nhận được 3 lực lượng, và nhận thêm 5 sát thương mỗi lần chịu đòn."
  },
  State_3234_Name = {
    Text = "Lưng dựa vào nước"
  },
  State_3235_Desc = {
    Text = "Khi trận chiến bắt đầu, nhận được [Layer] lực lượng, nhưng mỗi lần bị thương sẽ tăng 5."
  },
  State_3235_Name = {
    Text = "Lưng dựa vào nước"
  },
  State_3236_Desc = {
    Text = "Sau khi đánh ra, các thân thể được đánh thức khác nhận được [StateArg1] điên cuồng."
  },
  State_3236_Name = {
    Text = "<Rune_16_High:phản ứng cao cấp>"
  },
  State_3237_Desc = {
    Text = "Mỗi 3 lượt nhận được 3 râu chạm, râu chạm này bỏ qua giới hạn râu chạm và sẽ bị loại bỏ khi kết thúc lượt."
  },
  State_3238_Desc = {
    Text = "Khi trận chiến bắt đầu, tăng tất cả sát thương mà quái vật phải chịu"
  },
  State_3238_Name = {
    Text = "Khi trận chiến bắt đầu, tăng tất cả sát thương mà quái vật phải chịu"
  },
  State_3238_WeaponDesc = {
    Text = "Khi trận chiến bắt đầu, tăng tất cả sát thương mà quái vật phải chịu"
  },
  State_3239_Desc = {
    Text = "Tăng [Layer] điểm sức tấn công."
  },
  State_3239_Name = {
    Text = "Tăng sức tấn công chung"
  },
  State_3239_WeaponDesc = {
    Text = "Tăng [Layer] điểm sức tấn công."
  },
  State_3242_Name = {
    Text = "Đặt 2 lá<DerivativeCardKeywords_4:「cảm hứng」>vào rút bài từ bộ bài"
  },
  State_3243_Desc = {
    Text = "Sức mạnh tính toán của thẻ bài tăng lên"
  },
  State_3243_Name = {
    Text = "Sức mạnh tính toán của thẻ bài tăng lên"
  },
  State_3243_WeaponDesc = {
    Text = "Sức mạnh tính toán của thẻ bài tăng lên"
  },
  State_3244_Desc = {
    Text = "Quái vật được triệu hồi có sức sống tăng gấp đôi."
  },
  State_3244_Name = {
    Text = "\"sự xấu hổ tràn ngập\""
  },
  State_3244_WeaponDesc = {
    Text = "Quái vật được triệu hồi có sức sống tăng gấp đôi."
  },
  State_3245_Desc = {
    Text = "Khi chiến đấu bắt đầu, tỷ lệ chí mạng của đội ta giảm 30%, nhưng thương chí mạng tăng 30%."
  },
  State_3245_Name = {Text = "ức chế"},
  State_3245_WeaponDesc = {
    Text = "Khi chiến đấu bắt đầu, tỷ lệ chí mạng của đội ta giảm 30%, nhưng thương chí mạng tăng 30%."
  },
  State_3246_Desc = {
    Text = "Khi trận chiến bắt đầu, sức sống của kẻ địch thông thường tăng 30%, sau khi chiến thắng, cung cấp thêm 25 dấu đen."
  },
  State_3246_Name = {
    Text = "Sáng tạo cờ chiến tranh"
  },
  State_3246_WeaponDesc = {
    Text = "Khi trận chiến bắt đầu, sức sống của kẻ địch thông thường tăng 30%, sau khi chiến thắng, cung cấp thêm 25 dấu đen."
  },
  State_3247_Desc = {
    Text = "[cơn thịnh nộ bùng phát] làm giảm tiêu thụ sức tính toán của tất cả các lá bài trong tay đi 1."
  },
  State_3247_Name = {
    Text = "Ánh sáng của nền văn minh biến đổi"
  },
  State_3247_WeaponDesc = {
    Text = "[cơn thịnh nộ bùng phát] làm giảm tiêu thụ sức tính toán của tất cả các lá bài trong tay đi 1."
  },
  State_3249_Desc = {
    Text = "Các đồng đội khác nhận 1 lớp <MadnessColour:điên rồ>, giải trừ sau khi bản thân chết."
  },
  State_3249_Name = {
    Text = "Bồn chồn"
  },
  State_3249_WeaponDesc = {
    Text = "Các đồng minh khác nhận được 1 lớp điên rồ, và sẽ được gỡ bỏ sau khi bản thân tử vong."
  },
  State_3250_Desc = {
    Text = "Sau khi chiến đấu kết thúc vẫn được giữ lại trong bộ bài, nhưng sẽ bị xóa vĩnh viễn sau khi chơi hoặc bị tiêu thụ."
  },
  State_3250_Name = {
    Text = "<DestructionKeywords:Xóa bỏ>"
  },
  State_3250_WeaponDesc = {
    Text = "Sau khi sử dụng, hãy loại bỏ nó vĩnh viễn."
  },
  State_3251_Desc = {
    Text = "Khi chịu Sát thương chủ động hoặc thương tổn xúc tu, Miễn dịch với sát thương và giảm 1 lớp, bị xóa khi bắt đầu lượt."
  },
  State_3251_Name = {
    Text = "<ParcloseColour: rào cản tạm thời>"
  },
  State_3252_Desc = {
    Text = "Khi Hoa bùn áp dụng lá chắn, máu tối đa tăng [StateArg2]."
  },
  State_3252_Name = {
    Text = "Dịch chất nhầy"
  },
  State_3252_WeaponDesc = {
    Text = "Khi Hoa bùn áp dụng lá chắn, máu tối đa tăng [StateArg2]."
  },
  State_3253_Desc = {
    Text = "Được [StateArg1] điểm cảnh giác tạm thời."
  },
  State_3253_Name = {
    Text = "<CardKeyWord:Trang Bị Cơ Giới - Khiên>"
  },
  State_3253_WeaponDesc = {
    Text = "Được [StateArg1] điểm tạm thời giữ mình"
  },
  State_3255_Name = {
    Text = "phản công"
  },
  State_3256_Name = {
    Text = "Trạng thái @lời_nguyền_hưng_phấn"
  },
  State_3259_Desc = {
    Text = "Tăng số lần Sát thương chủ động gây ra thêm [Layer] ."
  },
  State_3259_Name = {
    Text = "<MadnessColour:điên rồ>"
  },
  State_3260_Desc = {
    Text = "Khi không gian siêu việt đạt giới hạn, nhận thêm một lượt phụ, lượt này không rút bài mà đặt các thẻ bài từ không gian siêu việt vào tay."
  },
  State_3260_Name = {
    Text = "<DimensionalSpaceIconKeywords:không gian siêu việt>"
  },
  State_3260_WeaponDesc = {
    Text = "Khi siêu việt không gian đạt giới hạn, nhận thêm một lượt chơi siêu việt, đưa tất cả các thẻ bài siêu việt không gian vào bộ bài trên tay."
  },
  State_3261_Desc = {
    Text = "Quái vật được gọi gây sát thương gấp đôi."
  },
  State_3261_Name = {
    Text = "\"bình tượng nến lữ đoàn\""
  },
  State_3261_WeaponDesc = {
    Text = "Quái vật được gọi gây sát thương gấp đôi."
  },
  State_3262_Desc = {
    Text = "Trạng thái @lớp phủ sáp đội ta"
  },
  State_3262_Name = {
    Text = "Trạng thái @lớp phủ sáp đội ta"
  },
  State_3262_WeaponDesc = {
    Text = "Trạng thái @lớp phủ sáp đội ta"
  },
  State_3263_Name = {
    Text = "Trạng thái@vỏ ốc anh vũ trả đòn"
  },
  State_3264_Name = {
    Text = "Phát nổ chắc chắn"
  },
  State_3265_Name = {
    Text = "Bỏ đi và xóa nó"
  },
  State_3266_Desc = {
    Text = "Nhảy vọt được tăng cường tại Thành phố Mộng tử"
  },
  State_3266_Name = {
    Text = "Trạng thái@thành phố của những giấc mơ chết tăng cường nhảy vọt"
  },
  State_3267_Desc = {
    Text = "Khi bắt đầu chiến đấu, nhận được 5 lớp [Giáp sáp]."
  },
  State_3267_Name = {
    Text = "\"Quý ông sáp\""
  },
  State_3267_WeaponDesc = {
    Text = "Khi bắt đầu chiến đấu, nhận được 5 lớp [Giáp sáp]."
  },
  State_3268_Desc = {
    Text = "Vào đầu lượt, rút 1 lá bài. Mỗi khi bạn rút được 1 lá bài, ngẫu nhiên thay đổi sức tính toán tiêu thụ của nó (0-4)."
  },
  State_3268_Name = {
    Text = "Kaleidoscope sáng tạo"
  },
  State_3268_WeaponDesc = {
    Text = "Vào đầu lượt, rút 1 lá bài. Mỗi khi bạn rút được 1 lá bài, ngẫu nhiên thay đổi sức tính toán tiêu thụ của nó (0-4)."
  },
  State_3269_Desc = {
    Text = "Mỗi lượt sau khi nhận lá chắn thứ 2, nhận [Arg1] lớp phản công. Mỗi lượt sau khi nhận lá chắn thứ 4, gây 1 lần thương phản công lên tất cả kẻ địch."
  },
  State_3269_Name = {
    Text = "Nói Hết Không Giấu"
  },
  State_3270_Name = {
    Text = "Trạng thái@Chương hai cảm ứng sao chép"
  },
  State_3271_Desc = {
    Text = "[Đánh] gây [Arg1] lớp nhiễm độc cho tất cả kẻ thù."
  },
  State_3272_Desc = {
    Text = "Khi gây thương không bị chặn, hồi 3 lần giá trị thương thực tế của sức sống, khi gây thương thì loại bỏ."
  },
  State_3272_Name = {
    Text = "Hấp huyết"
  },
  State_3273_Desc = {
    Text = "Đội duy nhất: Sau khi chơi thẻ bài của người trang bị, nhận được lá chắn tương đương với <WeaponEffect_Num:[StateArg1]%> khả năng phòng thủ của người trang bị, mỗi râu chạm sẽ gia tăng lá chắn thêm <WeaponEffect_Num:[StateArg2]>. Hiệu ứng này chỉ có hiệu lực 1 lần trong mỗi lượt."
  },
  State_3273_Name = {
    Text = "Cái chết của thiếu nữ san hô"
  },
  State_3273_WeaponDesc = {
    Text = "Đánh ra thẻ bài của người trang bị, nhận được <WeaponEffect_Num:[Block:DescArg1]> lá chắn, mỗi râu chạm sẽ gia tăng lá chắn thêm <WeaponEffect_Num:[DescArg2]>. Hiệu ứng này chỉ có hiệu lực 1 lần trong mỗi lượt."
  },
  State_3274_Desc = {
    Text = "Mỗi lần bị sát thương chủ động, tăng một lớp cộng dồn cho đội của tôi"
  },
  State_3274_Name = {
    Text = "Trạng thái @ lưỡi dao trả thù cắt đầu trọng thương đội số lần"
  },
  State_3274_WeaponDesc = {
    Text = "Mỗi lần bị sát thương chủ động, tăng một lớp cộng dồn cho đội của tôi"
  },
  State_3277_Desc = {
    Text = "Đánh ra, thân thể được đánh thức có được [StateArg1] điểm điên cuồng."
  },
  State_3277_Name = {
    Text = "<Rune_5:cuồng nộ>"
  },
  State_3280_Name = {
    Text = "Kiếm Định Mệnh"
  },
  State_3281_Desc = {
    Text = "Tăng cường sát thương chủ động."
  },
  State_3281_Name = {
    Text = "<PowerIconKeywords: lực lượng>"
  },
  State_3281_WeaponDesc = {
    Text = "Gây ra tăng lên."
  },
  State_3282_Desc = {
    Text = "Số lần gây thương và thương tăng lên."
  },
  State_3282_Name = {
    Text = "<CardKeyWord:nâng cấp>"
  },
  State_3282_WeaponDesc = {
    Text = "Thêm một lần thương"
  },
  State_3283_Desc = {
    Text = "Mỗi đầu lượt, hồi phục [StateArg1] sức sống. Nếu sức sống dưới 50%, lượng hồi phục sức sống sẽ tăng lên [StateArg2]."
  },
  State_3283_Name = {
    Text = "Chế phẩm sáng tạo nhũ hương"
  },
  State_3283_WeaponDesc = {
    Text = "Mỗi đầu lượt, hồi phục [StateArg1] sức sống. Nếu sức sống dưới 50%, lượng hồi phục sức sống sẽ tăng lên [StateArg2]."
  },
  State_3287_Desc = {
    Text = "Khi bắt đầu chiến đấu, trộn 2 lá \"cảm hứng\" vào bộ bài của bạn. Mỗi lần vượt qua 1 trận chiến sẽ khiến sáng tạo này được nâng cấp, tối đa 3 lần."
  },
  State_3288_Desc = {
    Text = "Trạng thái@trạng thái trống"
  },
  State_3288_Name = {
    Text = "Trạng thái@trạng thái trống"
  },
  State_3288_WeaponDesc = {
    Text = "Trạng thái@trạng thái trống"
  },
  State_3289_Desc = {
    Text = "Mỗi lần nhận 1 điểm thương sẽ giảm 1 tầng. Khi số tầng còn 0, sẽ thay thế ý định thành Hoa Bất Diệt và sử dụng bộ kỹ năng thiên về phòng thủ."
  },
  State_3289_Name = {
    Text = "Bunga Abadi"
  },
  State_3289_WeaponDesc = {
    Text = "Mỗi khi nhận 1 điểm thương, giảm 1 lớp. Khi số lớp đạt đến 0, chuyển sang chế độ phòng thủ."
  },
  State_3290_Desc = {
    Text = "Quái vật từng là \"Miriam\"đã chìm sâu vào sự hoang tưởng và tuyệt vọng, hãy phá vỡ ảo tưởng cuối cùng của cô ta và kết thúc sự điên rồ kéo dài hàng nghìn năm này."
  },
  State_3290_Name = {
    Text = "Ảo tưởng"
  },
  State_3291_Desc = {
    Text = "Khi gây thương thực tế, khiến đội của tôi mất đi 3 điểm lực lượng tạm thời."
  },
  State_3291_Name = {
    Text = "chích điện"
  },
  State_3292_Desc = {
    Text = "Khi kích hoạt cơn thịnh nộ bùng phát, mỗi khi kẻ địch chuẩn bị gây thương, sẽ áp đặt [Arg1] lớp trúng độc lên chúng"
  },
  State_3293_Desc = {
    Text = "Thương gây ra trong lượt này bị giảm [Layer] điểm."
  },
  State_3293_Name = {
    Text = "sức mạnh giảm xuống"
  },
  State_3293_WeaponDesc = {
    Text = "Thương gây ra trong lần chơi này và thương tổn xúc tu giảm [Layer] điểm."
  },
  State_3294_Name = {
    Text = "Trạng thái @lời nguyền nghi ngờ nhiều"
  },
  State_3296_Desc = {
    Text = "Loại bỏ hoặc gỡ bỏ khi sử dụng."
  },
  State_3296_Name = {
    Text = "Khi bỏ hoặc đánh ra, hãy loại bỏ nó"
  },
  State_3296_WeaponDesc = {
    Text = "Sau khi rút khiến bản thân yếu đuối 1 lượt. Sau khi sử dụng, khiến tất cả kẻ địch yếu đuối 1 lượt. Không thể bán."
  },
  State_3297_Desc = {
    Text = "Trạng thái@Nữ hoàng Gai Cây Khai Minh_Hình"
  },
  State_3297_Name = {
    Text = "Trạng thái@Nữ hoàng Gai Cây Khai Minh_Hình"
  },
  State_3297_WeaponDesc = {
    Text = "Trạng thái@Nữ hoàng Gai Cây Khai Minh_Hình"
  },
  State_3298_Desc = {
    Text = "Hiệu ứng nhảy vọt lần tiếp theo trong lượt này chắc chắn kích hoạt."
  },
  State_3298_Name = {
    Text = "Nhảy vọt sẽ luôn được kích hoạt"
  },
  State_3298_WeaponDesc = {
    Text = "Trong vòng này, hiệu ứng nhảy vọt không cần điều kiện."
  },
  State_3301_Name = {
    Text = "Số lượng Rượu của Các Ngôi Sao"
  },
  State_3302_Desc = {
    Text = "Thực hiện sự ngưng tụ vĩnh cửu"
  },
  State_3302_Name = {
    Text = "Thực hiện sự ngưng tụ vĩnh cửu"
  },
  State_3302_WeaponDesc = {
    Text = "Thực hiện sự ngưng tụ vĩnh cửu"
  },
  State_3304_Desc = {
    Text = "Mỗi lượt chơi, đánh ra thẻ lệnh cuối cùng tương ứng với thân thể được đánh thức, nhận được 15 điểm điên cuồng vào cuối lượt. Nếu đồng thời sở hữu \"Tượng mẹ\", các thân thể được đánh thức khác cũng nhận thêm 5 điểm điên cuồng."
  },
  State_3305_Desc = {
    Text = "Đánh ra sẽ đưa [StateArg1] lá \"cảm hứng\" vào rút bài từ bộ bài. \"cảm hứng\": nhận được 1 sức tính toán, rút 1 lá bài, giữ lại và tiêu thụ."
  },
  State_3305_Name = {
    Text = "<Rune_17:cảm hứng>"
  },
  State_3307_Name = {
    Text = "(còn lại:[Layer])"
  },
  State_3308_Desc = {
    Text = "Vào đầu lượt, nếu số lá bài còn lại từ lượt trước vượt quá 2 lá, nhận được 2 sức tính toán."
  },
  State_3309_Desc = {
    Text = "Người trang bị gây sát thương, tạo lá chắn và tăng hiệu ứng chữa trị [StateArg1]%. (tạm thời)"
  },
  State_3309_Name = {
    Text = "Trạng thái@Thử tác trường kiếm kháng chết"
  },
  State_3310_Desc = {
    Text = "Khi Người Di Dân áp dụng lá chắn, họ nhận được [Energy:StateArg2] sức mạnh điên cuồng."
  },
  State_3310_Name = {
    Text = "tự phong tỏa"
  },
  State_3310_WeaponDesc = {
    Text = "Khi Người Di Dân áp dụng lá chắn, họ nhận được [Energy:StateArg2] sức mạnh điên cuồng."
  },
  State_3312_Desc = {
    Text = "Mỗi khi bạn hồi phục máu, nhận được [Arg1] điểm phản công, nếu máu lớn hơn 75%, nhận thêm [Arg2] điểm phản công."
  },
  State_3313_Desc = {
    Text = "Tại đầu lượt, nhận [Arg1] điểm lực lượng trong lượt này. Khi đánh ra mỗi thẻ bài, mất [Arg2] điểm lực lượng trong lượt này."
  },
  State_3314_Desc = {
    Text = "Thân thể được đánh thức này chưa thức tỉnh… Khi sắp ngã gục sẽ thức tỉnh, hồi phục sức sống và bắt đầu chiến đấu với hình thái thật sự."
  },
  State_3314_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_3315_Desc = {
    Text = "Mỗi lượt, sau khi đánh thẻ bài đầu tiên, biến 2 thẻ bài ngẫu nhiên trong tay thành bản sao của phiên bản gốc, khôi phục khi kết thúc lượt."
  },
  State_3315_Name = {
    Text = "Sáng tạo mê hoặc chuông gió"
  },
  State_3316_Desc = {
    Text = "Cuối lượt, lá chắn sẽ được giữ lại."
  },
  State_3316_Name = {
    Text = "Bức Tường Bảo Vệ"
  },
  State_3316_WeaponDesc = {
    Text = "Cuối lượt, lá chắn sẽ được giữ lại."
  },
  State_3317_Desc = {
    Text = "Kết thúc lượt chơi mất hết lá chắn"
  },
  State_3317_Name = {
    Text = "Giai khóa: Cha sinh"
  },
  State_3318_Name = {
    Text = "Trạng thái @ khát máu bàn mèi giả chi ôm tiêu thụ biển hiệu"
  },
  State_3323_Desc = {
    Text = "Người trang bị gây sát thương, tạo lá chắn và tăng hiệu ứng chữa trị [StateArg1]%. (tạm thời)"
  },
  State_3323_Name = {
    Text = "Trạng thái@kiếm mẫu thử dài điên cuồng"
  },
  State_3324_Desc = {
    Text = "Trong lượt này, sát thương chí mạng tăng [Layer]%."
  },
  State_3324_Name = {
    Text = "Sát thương bạo kích tạm thời"
  },
  State_3324_WeaponDesc = {
    Text = "Trong lượt này, sát thương chí mạng tăng [Layer]%."
  },
  State_3325_Desc = {
    Text = "Mỗi lần reset bộ bài, thêm 2 lá \"dòng nĩa\" có được [Arg1] điểm lực lượng trong lượt này và 1 lá \"Dù\" có được [Arg2] điểm giữ mình trong lượt này vào tay."
  },
  State_3326_Desc = {
    Text = "Mỗi lượt miễn nhiễm sát thương chủ động lần đầu."
  },
  State_3326_Name = {
    Text = "Kiên định"
  },
  State_3326_WeaponDesc = {
    Text = "Mỗi lượt miễn nhiễm sát thương chủ động lần đầu."
  },
  State_3327_Desc = {
    Text = "Giá trị sức sống của quái vật trước khi chết."
  },
  State_3327_Name = {
    Text = "HP quái vật trước khi chết"
  },
  State_3327_WeaponDesc = {
    Text = "Giá trị sức sống của quái vật trước khi chết."
  },
  State_3328_Desc = {
    Text = "Trong trận chiến này, khi nhận phải thương gây chết, sẽ hồi sinh một lần, khôi phục [Layer] điểm sức sống, không thể xóa bỏ."
  },
  State_3328_Name = {
    Text = "Chim thiên đường bất tử"
  },
  State_3329_Desc = {
    Text = "Mỗi khi đánh 5 lá bài, nhận được một bản sao của thẻ bài bên trái nhất trong tay bạn, kèm theo hiệu ứng \"hư vô\" và \"tiêu thụ\"."
  },
  State_3330_Desc = {
    Text = "Sức tiêu thụ sức tính toán của thẻ bài tăng thêm [Layer] điểm. Hiệu ứng này sẽ biến mất sau khi đánh thẻ bài."
  },
  State_3330_Name = {
    Text = "<SlowColour:chậm [Layer]>"
  },
  State_3330_WeaponDesc = {
    Text = "Số điểm tiêu thụ sức tính toán của thẻ bài tăng thêm [Layer]."
  },
  State_3332_Desc = {
    Text = "Khi chịu Sát thương chủ động hoặc thương tổn xúc tu, Miễn dịch với sát thương và giảm 1 lớp."
  },
  State_3332_Name = {
    Text = "<ParcloseColour: rào cản>"
  },
  State_3335_Desc = {
    Text = "Khi chiến đấu bắt đầu, gây 1 lớp tăng sát thương cho tất cả kẻ địch. \"Lời Nguyền Tĩnh Chỉ\" tăng thêm 25% hiệu ứng tăng sát thương mà kẻ địch phải chịu."
  },
  State_3335_Name = {
    Text = "Mắt Đá khởi linh 6"
  },
  State_3336_Name = {
    Text = "Trạng thái@George@khi chết sẽ được chữa trị"
  },
  State_3337_Name = {
    Text = "Lễ tế đỏ"
  },
  State_3339_Desc = {
    Text = "Tăng [Layer] điểm sức tấn công."
  },
  State_3339_Name = {
    Text = "Tăng sức tấn công tạm thời"
  },
  State_3339_WeaponDesc = {
    Text = "Tăng [Layer] điểm sức tấn công."
  },
  State_3340_Desc = {
    Text = "Sau khi giải phóng cơn thịnh nộ bùng phát, thương từ cơn thịnh nộ bùng phát trong trận chiến này tăng [Arg1], tối đa cộng dồn 5 lần. Khi cộng dồn đầy, giải phóng cơn thịnh nộ sẽ mang lại 100 điên cuồng cho thân thể được đánh thức."
  },
  State_3341_Desc = {
    Text = "Trạng thái@phần mở đầu đặt lại bộ bài 0_1_2_1"
  },
  State_3341_Name = {
    Text = "Trạng thái@phần mở đầu đặt lại bộ bài 0_1_2_1"
  },
  State_3341_WeaponDesc = {
    Text = "Trạng thái@phần mở đầu đặt lại bộ bài 0_1_2_1"
  },
  State_3342_Desc = {
    Text = "Trạng thái@Chương đầu Đặt lại bộ bài0_1_2_2"
  },
  State_3342_Name = {
    Text = "Trạng thái@Chương đầu Đặt lại bộ bài0_1_2_2"
  },
  State_3342_WeaponDesc = {
    Text = "Trạng thái@Chương đầu Đặt lại bộ bài0_1_2_2"
  },
  State_3343_Desc = {
    Text = "Trạng thái@phần mở đầu đặt lại bộ bài0_1_2_3"
  },
  State_3343_Name = {
    Text = "Trạng thái@phần mở đầu đặt lại bộ bài0_1_2_3"
  },
  State_3343_WeaponDesc = {
    Text = "Trạng thái@phần mở đầu đặt lại bộ bài0_1_2_3"
  },
  State_3344_Desc = {
    Text = "Trạng thái: chương mở đầu đặt lại bộ bài 0_1_2_4"
  },
  State_3344_Name = {
    Text = "Trạng thái: chương mở đầu đặt lại bộ bài 0_1_2_4"
  },
  State_3344_WeaponDesc = {
    Text = "Trạng thái: chương mở đầu đặt lại bộ bài 0_1_2_4"
  },
  State_3345_Desc = {
    Text = "Trạng thái@phần mở đầu reset bộ bài 0_1_2_5"
  },
  State_3345_Name = {
    Text = "Trạng thái@phần mở đầu reset bộ bài 0_1_2_5"
  },
  State_3345_WeaponDesc = {
    Text = "Trạng thái@phần mở đầu reset bộ bài 0_1_2_5"
  },
  State_3346_Desc = {
    Text = "Trạng thái@phần mở đầu reset bộ bài 0_1_2_5"
  },
  State_3346_Name = {
    Text = "Trạng thái@phần mở đầu reset bộ bài 0_1_2_5"
  },
  State_3346_WeaponDesc = {
    Text = "Trạng thái@phần mở đầu đặt lại bộ bài0_1_2_6"
  },
  State_3347_Desc = {
    Text = "Trạng thái@phần mở đầu reset bộ bài 0_1_2_5"
  },
  State_3347_Name = {
    Text = "Trạng thái@phần mở đầu reset bộ bài 0_1_2_5"
  },
  State_3347_WeaponDesc = {
    Text = "Trạng thái@chương mở đầu tái thiết bộ bài0_1_2_7"
  },
  State_3348_Desc = {
    Text = "Sau khi đánh, rút [StateArg1] lá bài."
  },
  State_3348_Name = {
    Text = "<Rune_3_High:Diệu Thủ Cao Cấp>"
  },
  State_3348_WeaponDesc = {
    Text = "Sau khi đánh, rút [StateArg1] lá bài."
  },
  State_3350_Desc = {
    Text = "Sau khi kích hoạt cơn thịnh nộ bùng phát, mất 10% sức sống hiện tại và trong lượt này hút [Arg1] điểm lực lượng từ tất cả kẻ địch."
  },
  State_3351_Name = {
    Text = "Trạng thái sau khi thêm vào bộ bài"
  },
  State_3352_Name = {
    Text = "Sách Bí Mật Sáng Tạo Sao 1"
  },
  State_3354_Name = {
    Text = "Bí Điển Sáng Tạo Thiên Văn Kính 2"
  },
  State_3356_Name = {
    Text = "Kết thúc lượt: Trúng độc ngạt thở"
  },
  State_3357_Desc = {
    Text = "Sau khi bắt đầu lượt tiếp theo, râu chạm thương +[Layer]."
  },
  State_3357_Name = {
    Text = "Thương tổn xúc tu trễ"
  },
  State_3358_Desc = {
    Text = "Vào đầu lượt tiếp theo, nhận được [Layer] điểm lá chắn."
  },
  State_3358_Name = {
    Text = "Nghệ thuật đã mất: Lá chắn"
  },
  State_3359_Desc = {
    Text = "Lá bài thứ 3 bạn đánh ra sẽ có hiệu lực 2 lần."
  },
  State_3359_Name = {
    Text = "Rượu sáng tạo các vì sao"
  },
  State_3359_WeaponDesc = {
    Text = "Lá bài thứ 3 bạn đánh ra sẽ có hiệu lực 2 lần."
  },
  State_3360_Desc = {
    Text = "Trạng thái@Chương mở đầu đặt lại bộ bài 0_1_4_1"
  },
  State_3360_Name = {
    Text = "Trạng thái@Chương mở đầu đặt lại bộ bài 0_1_4_1"
  },
  State_3360_WeaponDesc = {
    Text = "Trạng thái@Chương mở đầu đặt lại bộ bài 0_1_4_1"
  },
  State_3362_Desc = {
    Text = "Trạng thái@Chương mở đầu đặt lại bộ bài 0_1_4_1"
  },
  State_3362_Name = {
    Text = "Trạng thái@Chương mở đầu đặt lại bộ bài 0_1_4_1"
  },
  State_3362_WeaponDesc = {
    Text = "Trạng thái@Chương mở đầu đặt lại bộ bài 0_1_4_1"
  },
  State_3364_Desc = {
    Text = "Khi nhặt, chọn một thẻ bài và áp dụng hai hiệu ứng tăng cường ba lựa chọn lên nó. (Lưu ý: Tương tự như kỹ năng tạo thẻ trong 'Hình Ảnh Ngàn Mặt')"
  },
  State_3365_Desc = {
    Text = "Trạng thái@Chương mở đầu đặt lại bộ bài 0_1_4_1"
  },
  State_3365_Name = {
    Text = "Trạng thái@Chương mở đầu đặt lại bộ bài 0_1_4_1"
  },
  State_3365_WeaponDesc = {
    Text = "Trạng thái@Chương mở đầu đặt lại bộ bài 0_1_4_1"
  },
  State_3366_Desc = {
    Text = "Trạng thái@Chương mở đầu đặt lại bộ bài 0_1_4_1"
  },
  State_3366_Name = {
    Text = "Trạng thái@Chương mở đầu đặt lại bộ bài 0_1_4_1"
  },
  State_3366_WeaponDesc = {
    Text = "Trạng thái@Chương mở đầu đặt lại bộ bài 0_1_4_1"
  },
  State_3368_Desc = {
    Text = "Nếu trước giai đoạn bỏ bài, tiêu thụ sức tính toán lớn hơn 5, biến thành đá."
  },
  State_3368_Name = {Text = "Hóa đá"},
  State_3368_WeaponDesc = {
    Text = "Trước khi vào giai đoạn bỏ bài, biến các lá bài trong tay thành đá"
  },
  State_3369_Desc = {
    Text = "Tất cả hiệu ứng tiêu thụ của bạn đều trở thành tiêu thụ vô hạn."
  },
  State_3369_Name = {
    Text = "Nuốt chửng vô hạn"
  },
  State_3369_WeaponDesc = {
    Text = "Tất cả hiệu ứng tiêu thụ của bạn đều trở thành tiêu thụ vô hạn."
  },
  State_3370_Desc = {
    Text = "Trong lần thử thách này, [Layer] điểm lá chắn sẽ bị giảm."
  },
  State_3370_Name = {
    Text = "Giảm giữ mình vĩnh viễn"
  },
  State_3370_WeaponDesc = {
    Text = "Trong lần thử thách này, [Layer] điểm lá chắn sẽ bị giảm."
  },
  State_3372_Desc = {
    Text = "Thân thể được đánh thức này chưa thức tỉnh… Khi sắp ngã gục sẽ thức tỉnh, hồi phục sức sống và bắt đầu chiến đấu với hình thái thật sự."
  },
  State_3372_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_3373_Desc = {
    Text = "Khi gây sát thương thực tế, sẽ trộn [StateArg1] lá \"vết thương\" vào rút bài từ bộ bài."
  },
  State_3373_Name = {
    Text = "ngạt thở"
  },
  State_3373_WeaponDesc = {
    Text = "Sau khi rút khiến bản thân yếu đuối 1 lượt. Sau khi sử dụng, khiến tất cả kẻ địch yếu đuối 1 lượt. Không thể bán."
  },
  State_3374_Desc = {
    Text = "Sau khi lượt kết thúc, nhận được số tầng lực lượng tương ứng."
  },
  State_3374_Name = {
    Text = "giận dữ"
  },
  State_3376_Desc = {
    Text = "Thương gây ra bởi cơn thịnh nộ bùng phát trong trận chiến này được tăng [Layer] điểm."
  },
  State_3376_Name = {
    Text = "Thiệt hại cơn thịnh nộ bùng phát tăng lên"
  },
  State_3378_Desc = {
    Text = "Sau khi kích hoạt cơn thịnh nộ bùng phát, lá bài tiếp theo đánh ra sẽ có hiệu lực 2 lần."
  },
  State_3378_Name = {
    Text = "Trạng thái @chìa khóa bạc Mộng Ảo: Phát Nổ"
  },
  State_3379_Desc = {
    Text = "Khi sức sống dưới 50%, Kẻ Phá Liên sẽ trở nên cuồng nộ."
  },
  State_3379_Name = {
    Text = "Giờ trả thù"
  },
  State_3379_WeaponDesc = {
    Text = "Khi sức sống dưới 50%, Kẻ Phá Liên sẽ trở nên cuồng nộ."
  },
  State_3380_Desc = {
    Text = "Khi trận chiến bắt đầu, trộn 1 lá [Hỗn Loạn] vào rút bài từ bộ bài."
  },
  State_3380_Name = {Text = "Hypnotise"},
  State_3380_WeaponDesc = {
    Text = "Khi trận chiến bắt đầu, trộn 1 lá [Hỗn Loạn] vào rút bài từ bộ bài."
  },
  State_3381_Name = {
    Text = "Khởi tạo chức nghiệp siêu việt"
  },
  State_3382_Desc = {
    Text = "Nhận được một nhiệm vụ. Hoàn thành nhiệm vụ và nhận được phần thưởng. [Nhiệm vụ sự kiện]"
  },
  State_3383_Name = {
    Text = "Khởi tạo chức nghiệp siêu việt"
  },
  State_3385_Desc = {
    Text = "Giảm 33% sát thương từ tấn công chủ động và râu chạm."
  },
  State_3385_Name = {
    Text = "Khiên Gương"
  },
  State_3385_WeaponDesc = {
    Text = "Giảm 33% sát thương từ tấn công chủ động và râu chạm."
  },
  State_3386_Desc = {
    Text = "Người trang bị gây sát thương, tạo lá chắn và tăng hiệu ứng chữa trị [StateArg1]%. (tạm thời)"
  },
  State_3386_Name = {
    Text = "Trạng thái@kiếm dài nguyên mẫu bạo kích"
  },
  State_3387_Name = {
    Text = "Trạng thái@màn chơi2_3_chiến đấu3_bubble1"
  },
  State_3388_Desc = {
    Text = "Sau khi đánh ra, nhận được [StateArg1] điểm lực lượng."
  },
  State_3388_Name = {
    Text = "<Rune_14:sức mạnh>"
  },
  State_3389_Desc = {
    Text = "Thân thể được đánh thức này chưa thức tỉnh… Khi sắp ngã gục sẽ thức tỉnh, hồi phục sức sống và bắt đầu chiến đấu với hình thái thật sự."
  },
  State_3389_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_3390_Desc = {
    Text = "Khi chiến đấu bắt đầu, tất cả kẻ địch sẽ bị yếu đuối và tăng sát thương trong 1 lượt."
  },
  State_3392_Desc = {
    Text = "Nhận được [Arg1] lực lượng khi nhặt. Mỗi khi có \"phôi thai\" bị hợp nhất, nhận được [Arg2] điểm lực lượng trong lượt này."
  },
  State_3393_Desc = {
    Text = "Vào đầu lượt, phôi hợp tử +30%. Tất cả hiệu ứng tiêu thụ của bạn đều trở thành tiêu thụ vô hạn."
  },
  State_3394_Name = {
    Text = "Đặt 1 lá<DerivativeCardKeywords_4:「cảm hứng」>vào rút bài từ bộ bài"
  },
  State_3395_Desc = {
    Text = "Đội duy nhất: Sát thương cơ bản của \"Đánh\" của người trang bị tăng 25%, Khiên cơ bản của \"Phòng thủ\" tăng 25%. Khi chơi \"Đánh\" của người trang bị, nhận <WeaponEffect_Num:[StateArg1]%> Tấn Công của người trang bị dưới dạng <PowerIconKeywords:Sức mạnh> tạm thời, khi chơi \"Phòng thủ\" của người trang bị, nhận <WeaponEffect_Num:[StateArg2]%> Phòng thủ của người trang bị dưới dạng <AlertIconKeywords:Báo động> tạm thời. Nếu Cõi hiện tại là \"Siêu Chiều\", khi vào Vòng Siêu Chiều sẽ nhận một lần <PowerIconKeywords:Sức mạnh> tạm thời và <AlertIconKeywords:Báo động> tạm thời."
  },
  State_3395_WeaponDesc = {
    Text = "Trang bị của \"đánh\" tăng 25% thương cơ bản, \"phòng thủ\" tăng 25% lá chắn cơ bản. Khi sử dụng \"đánh\" của người trang bị, nhận được <WeaponEffect_Num:[Power:DescArg1]> điểm <PowerIconKeywords:lực lượng> tạm thời; khi sử dụng \"phòng thủ\" của người trang bị, nhận được <WeaponEffect_Num:[DescArg2]> điểm <AlertIconKeywords:giữ mình> tạm thời. Nếu giới vực hiện tại là \"siêu việt\", khi vào lượt siêu việt, nhận được một lần <PowerIconKeywords:lực lượng> tạm thời và <AlertIconKeywords:giữ mình> tạm thời."
  },
  State_3397_Desc = {
    Text = "Mỗi khi đánh lá bài thứ 10, tăng [Arg1] thương tổn xúc tu và khiến tất cả các râu chạm thực hiện tấn công một lần."
  },
  State_3400_Desc = {
    Text = "Giới hạn sức sống của kẻ địch tinh anh và thủ lĩnh giảm 20%."
  },
  State_3401_Desc = {
    Text = "Sau khi đánh ra, sẽ có hiệu lực thêm [StateArg1] lần, nhận [StateArg2] điểm dấu đen, tiêu thụ, cố hữu."
  },
  State_3401_Name = {
    Text = "<Rune_7:tiếng vang>"
  },
  State_3402_Desc = {
    Text = "\"cuốc sắt\" Lục Tần trọng kích thương tăng [Layer] %."
  },
  State_3402_Name = {
    Text = "Thiệt hại từ đòn đánh nặng tăng lên"
  },
  State_3402_WeaponDesc = {
    Text = "Cuốc sắt Lucien tăng cường thương đòn nặng [Layer] %"
  },
  State_3403_Desc = {
    Text = "Thân thể được đánh thức này chưa thức tỉnh… Khi sắp ngã gục sẽ thức tỉnh, hồi phục sức sống và bắt đầu chiến đấu với hình thái thật sự."
  },
  State_3403_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_3405_Name = {
    Text = "Tất cả kẻ địch tạm thời giảm [Power:StateArg1] điểm <PowerIconKeywords:lực lượng>. Trong 1 lượt, giảm 50% lá chắn và <PowerIconKeywords:lực lượng> nhận được"
  },
  State_3406_Name = {
    Text = "Nhận thêm [StateArg1] điểm <PowerIconKeywords:lực lượng>"
  },
  State_3407_Name = {
    Text = "Chọn 1 thẻ bài từ bộ bài và thêm vào tay bài, giảm tiêu thụ sức tính toán của nó đi 1"
  },
  State_3408_Name = {
    Text = "Nhận được <Posse:[DescArg1]> điểm năng lượng chìa khóa bạc. Trong trận chiến này, \"đòn tấn công gãy cổ\" và \"Hình Ảnh Ngàn Mặt\" có sát thương cơ bản tăng 10%"
  },
  State_3409_Name = {
    Text = "Chọn một thân thể được đánh thức để nhận <Energy:[DescArg1]> điểm Điên Cuồng"
  },
  State_3410_Name = {
    Text = "Thẻ bài này tăng 50% tỷ lệ chí mạng và thương harming chí mạng, gây ra sát thương xuyên thấu"
  },
  State_3411_Name = {
    Text = "Tự miễn <FragileIconKeywords:yếu đuối>, <WeaknessIconKeywords:suy nhược>, <VulnerabilityIconKeywords:tăng sát thương> 1 lượt. Nhận được <Block:[Block:StateArg1]> điểm lá chắn"
  },
  State_3412_Desc = {
    Text = "Miễn dịch trạng thái tiêu cực, giảm 1 lớp khi lượt kết thúc hoặc sau khi bị đánh chí mạng."
  },
  State_3412_Name = {
    Text = "lớp phủ sáp"
  },
  State_3412_WeaponDesc = {
    Text = "Mỗi tầng giảm 10% thương nhận phải, mỗi lần bị tấn công chí mạng sẽ giảm 1 tầng."
  },
  State_3415_Desc = {
    Text = "Khi nhặt lên, hãy chọn 1 trong 3 **khắcăng** bị hư hỏng. **Khắcăng** bị hư hỏng mạnh hơn **khắcăng** thông thường, nhưng khi được sử dụng sẽ tiêu tốn thẻ bài."
  },
  State_3415_Name = {
    Text = "Bản khắc ngọc lục bảo sáng tạo"
  },
  State_3415_WeaponDesc = {
    Text = "Khi nhặt lên, hãy chọn 1 trong 3 **khắcăng** bị hư hỏng. **Khắcăng** bị hư hỏng mạnh hơn **khắcăng** thông thường, nhưng khi được sử dụng sẽ tiêu tốn thẻ bài."
  },
  State_3416_Desc = {
    Text = "Đội duy nhất: Sau khi chiến đấu bắt đầu, nhận phản công bằng <WeaponEffect_Num:[StateArg1]%> Phòng thủ của Người trang bị. Sau khi kích hoạt <DeathResistanceIconKeywords: kháng cự tử vong>, nhận tối đa tổng cộng 2 lớp \"Nôi\": Lá chắn và hồi phục Sinh lực mà toàn bộ đồng đội gây ra tăng <WeaponEffect_Num:[StateArg2]%>, cuối lượt xóa 1 lớp, nếu Cõi hiện tại là \"Huyết Nhục\", sau khi kích hoạt <DeathResistanceIconKeywords: kháng cự tử vong>, Dung hợp Phôi thai <WeaponEffect_Num:+[Blood:StateArg3]>."
  },
  State_3416_WeaponDesc = {
    Text = "Sau khi chiến đấu bắt đầu, nhận <WeaponEffect_Num:[Counterattack:DescArg1]> lớp phản công. Sau khi kích hoạt <DeathResistanceIconKeywords: kháng cự tử vong>, nhận tối đa tổng cộng 2 lớp \"Nôi\": Lá chắn và hồi phục Sinh lực mà toàn bộ đồng đội gây ra tăng <WeaponEffect_Num:[StateArg2]%>, cuối lượt xóa 1 lớp, nếu Cõi hiện tại là \"Huyết Nhục\", sau khi kích hoạt <DeathResistanceIconKeywords: kháng cự tử vong>, Dung hợp Phôi thai <WeaponEffect_Num:+[Blood:StateArg3]>."
  },
  State_3418_Desc = {
    Text = "Sau khi lượt kết thúc, mất đi lực lượng tạm thời"
  },
  State_3418_Name = {
    Text = "Suy giảm trễ"
  },
  State_3419_Desc = {
    Text = "Khi nhặt, hiển thị 3 thẻ bài có khắcăng cao cấp hoặc nguyền rủa, chọn một thẻ và gán cho nó khắcăng tương ứng."
  },
  State_3420_Desc = {
    Text = "Mỗi lần hành động gây chảy máu, chữa trị có thể giảm một nửa số lớp trạng thái chảy máu."
  },
  State_3420_Name = {
    Text = "Vết máu bắn"
  },
  State_3420_WeaponDesc = {
    Text = "Mỗi lần hành động gây chảy máu, chữa trị có thể giảm một nửa số lớp trạng thái chảy máu."
  },
  State_3421_Desc = {
    Text = "Vào đầu lượt, thêm một lá \"dòng nĩa\" có lực lượng [Arg1] trong lượt này vào tay. Sau khi phát động cơn thịnh nộ bùng phát, tăng lực lượng của tất cả các lá \"dòng nĩa\" trong tay lên [Arg2]."
  },
  State_3422_Name = {
    Text = "Trạng thái @ Phụ kiện vô nhơ Khải Huyền"
  },
  State_3422_WeaponDesc = {
    Text = "Phóng thích lệnh khóa sau, hồi phục [DescArg1] sức sống. Nếu cấp độ sạc chìa khóa bạc của người trang bị lớn hơn 20, hồi phục thêm [DescArg1] sức sống. Hiệu ứng cùng loại không thể lặp lại."
  },
  State_3423_Desc = {
    Text = "Giới vực thông thạo 100, gây thương và thương tổn xúc tu tạm thời."
  },
  State_3423_Name = {
    Text = "Linh Bài Thời Gian \"Mộng Yểm\""
  },
  State_3424_Desc = {
    Text = "Vào đầu vòng, nếu số lượng thẻ bài đã đánh trong vòng trước vượt quá 3, rút 2 thẻ bài."
  },
  State_3425_Desc = {
    Text = "Khi sức sống dưới 50%([StateArg1]), thay đổi ý định thành \"Sinh tồn trong tuyệt cảnh\": loại bỏ trạng thái yếu đuối(mỏng manh), suy nhược và trúng độc, gây 99 tầng suy nhược và mỏng manh cho đội của tôi"
  },
  State_3425_Name = {
    Text = "Giờ trả thù"
  },
  State_3425_WeaponDesc = {
    Text = "Khi sức sống dưới 50%([StateArg1]), thay đổi ý định thành \"Sinh tồn trong tuyệt cảnh\": loại bỏ trạng thái yếu đuối(mỏng manh), suy nhược và trúng độc, gây 99 tầng suy nhược và mỏng manh cho đội của tôi"
  },
  State_3429_Desc = {
    Text = "Mỗi lần hành động gây chảy máu, chữa trị có thể loại bỏ hiệu ứng này"
  },
  State_3429_Name = {
    Text = "Thương nặng"
  },
  State_3429_WeaponDesc = {
    Text = "Mỗi lần hành động gây chảy máu, chữa trị có thể loại bỏ hiệu ứng này"
  },
  State_3430_Desc = {
    Text = "Sau khi kích hoạt cơn thịnh nộ bùng phát, nhận được [Arg1] điểm phản công. Nếu đây là lần thứ 6 kích hoạt trong trận chiến này, phản công của bạn sẽ tăng gấp đôi."
  },
  State_3431_Name = {
    Text = "Miễn dịch trúng độc"
  },
  State_3432_Desc = {
    Text = "Khi bỏ đi, tiêu thụ nó"
  },
  State_3432_Name = {
    Text = "Chi phí bỏ bài"
  },
  State_3432_WeaponDesc = {
    Text = "Sau khi rút khiến bản thân yếu đuối 1 lượt. Sau khi sử dụng, khiến tất cả kẻ địch yếu đuối 1 lượt. Không thể bán."
  },
  State_3434_Name = {
    Text = "Trạng thái@thông thường gây ra tăng sát thương"
  },
  State_3436_Desc = {
    Text = "Có [Layer] thân thể đã được thức tỉnh đang bị săn đuổi."
  },
  State_3436_Name = {
    Text = "Bị săn đuổi"
  },
  State_3437_Desc = {
    Text = "Trạng thái@quái vật cá voi bay vọt trên hành tinh hình bóng Shoko_quái thú hỗn loạn"
  },
  State_3437_Name = {
    Text = "Trạng thái@quái vật cá voi bay vọt trên hành tinh hình bóng Shoko_quái thú hỗn loạn"
  },
  State_3437_WeaponDesc = {
    Text = "Trạng thái@quái vật cá voi bay vọt trên hành tinh hình bóng Shoko_quái thú hỗn loạn"
  },
  State_3438_Desc = {
    Text = "Nhận được [StateArg1] điểm lực lượng tạm thời."
  },
  State_3438_Name = {
    Text = "<CardKeyWord:trang bị cơ giới - gươm>"
  },
  State_3439_Desc = {
    Text = "Vào cuối lượt, tulô nhận được 5 điểm điên cuồng."
  },
  State_3439_Name = {
    Text = "Sao về vị trí"
  },
  State_3440_Name = {
    Text = "Hướng dẫn viên vàng"
  },
  State_3441_Desc = {
    Text = "Vào lượt lẻ, khi số bài trong tay bạn là 0, rút 2 bài; vào lượt chẵn, khi sức tính toán của bạn là 0, nhận 2 sức tính toán."
  },
  State_3441_Name = {
    Text = "Dị hóa puzzle cũ kỹ"
  },
  State_3441_WeaponDesc = {
    Text = "Vào lượt lẻ, khi số bài trong tay bạn là 0, rút 2 bài; vào lượt chẵn, khi sức tính toán của bạn là 0, nhận 2 sức tính toán."
  },
  State_3442_Desc = {
    Text = "Khi nhặt, mất vĩnh viễn [Arg1] lực lượng. Mỗi khi gây sát thương, hồi [Arg2] điểm sức sống, tối đa 6 lần mỗi lượt."
  },
  State_3442_Name = {
    Text = "Nụ hôn cá mút đá"
  },
  State_3444_Desc = {
    Text = "Vào đầu lượt, rút 1 lá bài."
  },
  State_3445_Desc = {
    Text = "Tăng [Layer]% khả năng phòng thủ."
  },
  State_3445_Name = {
    Text = "Tăng tỷ lệ khả năng phòng thủ chung"
  },
  State_3445_WeaponDesc = {
    Text = "Tăng [Layer]% khả năng phòng thủ."
  },
  State_3446_Desc = {
    Text = "Có 5 tầng [Dây dẫn]. Sau khi đánh ra thẻ bài, số tầng giảm đi 1. Khi số tầng giảm về 0, nó sẽ tự nổ và gây sát thương bằng 2.5 lần sức tấn công."
  },
  State_3446_Name = {Text = "Bom nổ"},
  State_3446_WeaponDesc = {
    Text = "Có 5 tầng [Dây dẫn]. Sau khi đánh ra thẻ bài, số tầng giảm đi 1. Khi số tầng giảm về 0, nó sẽ tự nổ và gây sát thương bằng 2.5 lần sức tấn công."
  },
  State_3447_Desc = {
    Text = "Có 5 tầng [Dây dẫn]. Sau khi đánh ra thẻ bài, số tầng giảm đi 1. Khi số tầng giảm về 0, nó sẽ tự nổ và gây sát thương bằng 2.5 lần sức tấn công."
  },
  State_3447_Name = {Text = "Bom nổ"},
  State_3447_WeaponDesc = {
    Text = "Có 5 tầng [Dây dẫn]. Sau khi đánh ra thẻ bài, số tầng giảm đi 1. Khi số tầng giảm về 0, nó sẽ tự nổ và gây sát thương bằng 2.5 lần sức tấn công."
  },
  State_3448_Desc = {
    Text = "Sau mỗi lượt, kích hoạt tất cả các râu"
  },
  State_3448_Name = {
    Text = "Kích hoạt tự động râu chạm"
  },
  State_3448_WeaponDesc = {
    Text = "Sau mỗi lượt, kích hoạt tất cả các râu"
  },
  State_3449_Desc = {
    Text = "Trạng thái @Chương mở đầu điên cuồng 0_1_1 hiệu lực"
  },
  State_3449_Name = {
    Text = "Trạng thái @Chương mở đầu điên cuồng 0_1_1 hiệu lực"
  },
  State_3449_WeaponDesc = {
    Text = "Trạng thái @Chương mở đầu điên cuồng 0_1_1 hiệu lực"
  },
  State_3450_Desc = {
    Text = "Khi chịu Sát thương chủ động hoặc thương tổn xúc tu, Miễn dịch với sát thương và xóa 1 lớp."
  },
  State_3450_Name = {
    Text = "<ParcloseIconKeywords: rào cản>"
  },
  State_3450_WeaponDesc = {
    Text = "Giảm 99% sát thương phải chịu, sau khi chịu sát thương giảm 1 lớp."
  },
  State_3451_Desc = {
    Text = "Khi chết, tất cả các thân thể được đánh thức nhận được 10 điểm cuồng nộ."
  },
  State_3451_Name = {
    Text = "Vảy bạc hấp hối"
  },
  State_3451_WeaponDesc = {
    Text = "Khi chết, tất cả các thân thể được đánh thức nhận được 10 điểm cuồng nộ."
  },
  State_3452_Desc = {
    Text = "Mỗi lần đánh ra thẻ bài, nhận [StateArg1] thương và loại bỏ 1 lớp. Cuối lượt, nếu vẫn tồn tại, ấp nở một \"Vật Thể Biển Sâu\", mỗi lớp sức sống tăng 10%."
  },
  State_3452_Name = {
    Text = "Xâm thực hố sâu"
  },
  State_3453_Name = {
    Text = "Trạng thái @ hệ số sức mạnh lưỡi đao trả thù"
  },
  State_3455_Desc = {
    Text = "Trạng thái@Khởi tạo điên cuồng - Chương đầu tiên 0_2_3 hiệu ứng"
  },
  State_3455_Name = {
    Text = "Trạng thái@Khởi tạo điên cuồng - Chương đầu tiên 0_2_3 hiệu ứng"
  },
  State_3455_WeaponDesc = {
    Text = "Trạng thái@Khởi tạo điên cuồng - Chương đầu tiên 0_2_3 hiệu ứng"
  },
  State_3456_Desc = {
    Text = "[Phòng thủ] nhận [StateArg1] lớp phản công."
  },
  State_3456_Name = {
    Text = "Áo gai cây tầm ma sáng tạo"
  },
  State_3457_Name = {
    Text = "Miễn dịch tăng sát thương"
  },
  State_3458_Desc = {
    Text = "Đánh ra [Tấn công] và [Phòng thủ] sau đó, thân thể được đánh thức tương ứng nhận 35 điên cuồng. Tuy nhiên, tiêu thụ sức tính toán của chúng +1."
  },
  State_3459_Desc = {
    Text = "Thương gây ra bởi cơn thịnh nộ bùng phát trong trận chiến này được tăng [Layer] điểm."
  },
  State_3459_Name = {
    Text = "Thiệt hại cơn thịnh nộ bùng phát tăng lên"
  },
  State_3461_Desc = {
    Text = "Mỗi lần thứ 5 bạn gây thương, chắc chắn sẽ là đòn chí mạng."
  },
  State_3462_Name = {
    Text = "Trạng thái @ lực lượng của lưỡi đao trả thù tăng gấp 3 lần"
  },
  State_3463_Name = {
    Text = "Trạng thái @ thanh gươm báo thù lực lượng gấp đôi"
  },
  State_3464_Desc = {
    Text = "Giới hạn râu chạm tăng lên 1. Khi sức sống dưới 50%, thương tổn râu chạm tăng [Arg1]."
  },
  State_3465_Desc = {
    Text = "Thẻ bài này sẽ mang ra khỏi chiến đấu và có hiệu lực trong suốt màn chơi."
  },
  State_3465_Name = {
    Text = "<CardKeyWord:vĩnh viễn>"
  },
  State_3465_WeaponDesc = {
    Text = "Thẻ bài này có thể mang ra khỏi chiến đấu và có hiệu lực trong suốt màn chơi."
  },
  State_3466_Desc = {
    Text = "Khi nhặt, chọn một thân thể được đánh thức để thức tỉnh, giảm vĩnh viễn tiêu thụ sức tính toán của thẻ thức tỉnh đi 1."
  },
  State_34671_Desc = {
    Text = "Đánh ra và trả về tay."
  },
  State_34671_Name = {
    Text = "<CardKeyWord:hồi tay>"
  },
  State_34685_Name = {
    Text = "Bom 2-người-chơi"
  },
  State_34689_Desc = {
    Text = "Mỗi khi mất 1 điểm sức sống, nhận được 1 lớp <PainWord:nhẫn nại>, giới hạn là 100% máu tối đa. Nhẫn nại sẽ được kế thừa sang trận chiến tiếp theo."
  },
  State_34689_Name = {
    Text = "<CardKeyWord:nhẫn nại>"
  },
  State_3468_Desc = {
    Text = "Trạng thái @niềm oán niệm của sản phẩm lỗi"
  },
  State_3468_Name = {
    Text = "Trạng thái @niềm oán niệm của sản phẩm lỗi"
  },
  State_3468_WeaponDesc = {
    Text = "Trạng thái @niềm oán niệm của sản phẩm lỗi"
  },
  State_34691_Desc = {
    Text = "Mỗi khi mất 1 điểm sức sống, nhận được 1 lớp <PainWord:nhẫn nại>. Giới hạn là [DescArg1] lớp. Nhẫn nại sẽ thừa kế sang trận chiến tiếp theo."
  },
  State_34691_Name = {
    Text = "<CardKeyWord:nhẫn nại>"
  },
  State_34696_Desc = {
    Text = "Thẻ bài này trong mọi trường hợp sẽ luôn ở trong tay bài và tăng giới hạn tay bài lên +1."
  },
  State_34696_Name = {
    Text = "Giữ vĩnh viễn và bỏ qua giới hạn bài trên tay"
  },
  State_3469_Desc = {
    Text = "Giảm Sát thương chủ động và thương tổn xúc tu gây ra [DescArg1] %."
  },
  State_3469_Name = {
    Text = "<WeaknessColour:yếu đuối>"
  },
  State_3469_WeaponDesc = {
    Text = "Mọi sát thương gây ra bị giảm [DescArg1] %."
  },
  State_3470_Desc = {
    Text = "Thực hiện kiểm tra dần hóa đá"
  },
  State_3470_Name = {
    Text = "Thực hiện kiểm tra dần hóa đá"
  },
  State_3470_WeaponDesc = {
    Text = "Thực hiện kiểm tra dần hóa đá"
  },
  State_3471_Desc = {
    Text = "Lá bài thứ [StateArg1] bạn đánh ra sẽ có hiệu lực 2 lần."
  },
  State_3471_Name = {
    Text = "Số lượng Rượu của Các Ngôi Sao"
  },
  State_3471_WeaponDesc = {
    Text = "Lá bài thứ [StateArg1] bạn đánh ra sẽ có hiệu lực 2 lần."
  },
  State_3473_Desc = {
    Text = "Khi sức sống dưới 50%, \"Thần Đèn Giáo Mục\" sẽ cầu xin \"Thần Giáng\", hấp thụ toàn bộ giáo chúng và rơi vào trạng thái cuồng nộ."
  },
  State_3473_Name = {
    Text = "Dấu ấn của dây dẫn lửa"
  },
  State_3473_WeaponDesc = {
    Text = "Khi sức sống dưới 50%, \"Thần Đèn Giáo Mục\" sẽ cầu xin \"Thần Giáng\", hấp thụ toàn bộ giáo chúng và rơi vào trạng thái cuồng nộ."
  },
  State_3475_Desc = {
    Text = "[Tấn công] và [Phòng thủ] tiêu thụ sức tính toán +1."
  },
  State_3475_Name = {
    Text = "Bia đá nguyền của sáng tạo"
  },
  State_3475_WeaponDesc = {
    Text = "[Tấn công] và [Phòng thủ] tiêu thụ sức tính toán +1."
  },
  State_3476_Desc = {
    Text = "Mỗi khi bạn mất sức sống, phôi hợp tử +10%. Nếu sức sống dưới 50%, hiệu ứng sẽ tăng gấp đôi."
  },
  State_3477_Desc = {
    Text = "Khi bị tấn công, khôi phục [Layer] % máu tối đa. Nếu nhận sát thương vượt quá 15% máu tối đa, sẽ bị choáng và loại bỏ trạng thái này"
  },
  State_3477_Name = {
    Text = "Hỗn loạn đen"
  },
  State_3478_Name = {
    Text = "Trạng thái với phụ kiện chuẩn bí ẩn"
  },
  State_3479_Desc = {
    Text = "Mỗi khi tiêu thụ 1 dấu đen, tất cả thân thể được đánh thức sẽ nhận được 1 điên cuồng"
  },
  State_3479_Name = {
    Text = "Hoa Sinh Tạo Ngược"
  },
  State_3479_WeaponDesc = {
    Text = "Mỗi khi tiêu thụ 1 dấu đen, tất cả thân thể được đánh thức sẽ nhận được 1 điên cuồng"
  },
  State_3480_Desc = {
    Text = "Đến cuối lượt, sức sống sẽ không giảm xuống mức 0."
  },
  State_3480_Name = {
    Text = "Trứng ngọc không chết"
  },
  State_3480_WeaponDesc = {
    Text = "Đến cuối lượt, sức sống sẽ không giảm xuống mức 0."
  },
  State_3481_Desc = {
    Text = "Khi bắt đầu cấp độ, sẽ nhân đôi tỷ lệ kháng cự tử vong và tỷ lệ khắcăng may mắn của bạn."
  },
  State_3481_Name = {
    Text = "Trạng thái @chìa khóa bạc ảo mộng: May mắn gấp đôi"
  },
  State_3482_Desc = {
    Text = "Tăng hiệu ứng tăng sát thương thêm 25%. Cứ sau 3 lượt, áp dụng 1 lớp tăng sát thương lên tất cả kẻ địch."
  },
  State_3483_Desc = {
    Text = "Mỗi lần hành động gây chảy máu, chữa trị có thể loại bỏ hiệu ứng này"
  },
  State_3483_Name = {
    Text = "Thương nặng"
  },
  State_3483_WeaponDesc = {
    Text = "Mỗi lần hành động gây chảy máu, chữa trị có thể loại bỏ hiệu ứng này"
  },
  State_3484_Desc = {
    Text = "Khi gây ra thương thực tế, nhận được lực lượng."
  },
  State_3484_Name = {
    Text = "\"tính cách hỗn loạn\""
  },
  State_3485_Desc = {
    Text = "Trạng thái@lễ thức đèn dầu hiệu lực"
  },
  State_3485_Name = {
    Text = "Trạng thái@lễ thức đèn dầu hiệu lực"
  },
  State_3485_WeaponDesc = {
    Text = "Trạng thái@lễ thức đèn dầu hiệu lực"
  },
  State_3486_Name = {
    Text = "Kiếm Định Mệnh"
  },
  State_3488_Desc = {
    Text = "Đánh ra thẻ bài sẽ chịu [StateArg1] điểm thương và loại bỏ 1 lớp. Khi hết lớp, ấp nở một \"Sinh Vật Trong Biển\" yếu hơn. Nếu vẫn còn trạng thái bị ký sinh khi kết thúc lượt, ấp nở một \"Sinh Vật Trong Biển\" có sức sống tăng dần theo số lớp."
  },
  State_3488_Name = {
    Text = "Bị ký sinh nhiều lần"
  },
  State_3489_Name = {
    Text = "Khi kết thúc lượt, nếu ở trong bài hoặc <DimensionalSpaceIconKeywords:không gian siêu việt>, nâng cấp thành \"lửa xanh thối rữa\""
  },
  State_3489_WeaponDesc = {
    Text = "Khi kết thúc lượt, nếu ở trong bài trên tay hoặc chiều không gian siêu việt, sẽ được tăng cường"
  },
  State_3490_Desc = {
    Text = "Đánh ra thẻ bài sẽ chịu [StateArg1] điểm thương và loại bỏ 1 lớp. Khi hết lớp, ấp nở một \"Sinh Vật Trong Biển\" yếu hơn. Nếu vẫn còn trạng thái bị ký sinh khi kết thúc lượt, ấp nở một \"Sinh Vật Trong Biển\" có sức sống tăng dần theo số lớp."
  },
  State_3490_Name = {
    Text = "Bị ký sinh lại"
  },
  State_3492_Desc = {
    Text = "Mỗi lượt chẵn làm giảm lực lượng của đội tôi [Layer] ."
  },
  State_3492_Name = {
    Text = "Giảm lực"
  },
  State_3495_Desc = {
    Text = "Mỗi lần hành động gây ra [Layer] chảy máu"
  },
  State_3495_Name = {
    Text = "Thương nặng"
  },
  State_3495_WeaponDesc = {
    Text = "Mỗi lần hành động gây thêm [Layer] hiệu ứng chảy máu, chữa trị có thể loại bỏ hiệu ứng chảy máu"
  },
  State_34964_Desc = {
    Text = "Sau khi bắt đầu lượt, nhận thêm 10% máu tối đa <PainWord:kiên nhẫn>."
  },
  State_34964_Name = {
    Text = "không bao giờ quên"
  },
  State_3496_Name = {
    Text = "Khi kết thúc lượt nếu nằm trong bộ bài hoặc <DimensionalSpaceIconKeywords:siêu việt>, nâng cấp thành \"Lục Diệm Diệt Vong\""
  },
  State_3496_WeaponDesc = {
    Text = "Khi kết thúc lượt, nếu ở trong bài trên tay hoặc chiều không gian siêu việt, sẽ được tăng cường"
  },
  State_3497_Desc = {
    Text = "Khi đội hình bao gồm các thân thể được đánh thức thuộc các nghề nghiệp khác nhau, sức sống của đội hình và chỉ số tấn công cùng phòng thủ của tất cả các thân thể được đánh thức tăng 200%"
  },
  State_3497_Name = {
    Text = "Bonus pha trộn"
  },
  State_3497_WeaponDesc = {
    Text = "Khi đội hình bao gồm các thân thể được đánh thức thuộc các nghề nghiệp khác nhau, sức sống của đội hình và chỉ số tấn công cùng phòng thủ của tất cả các thân thể được đánh thức tăng 200%"
  },
  State_3499_Desc = {
    Text = "Đội duy nhất: Sự điên cuồng do người trang bị tạo ra tăng <WeaponEffect_Num:[StateArg1]%>. Sau khi người trang bị giải phóng cơn thịnh nộ bùng phát, họ nhận được <WeaponEffect_Num:[StateArg2]> điểm năng lượng chìa khóa bạc."
  },
  State_3499_WeaponDesc = {
    Text = "Người trang bị tạo ra điên cuồng tăng <WeaponEffect_Num:[StateArg1]%>. Người trang bị sau khi phát động cơn thịnh nộ bùng phát, nhận được <WeaponEffect_Num:[StateArg2]> điểm năng lượng chìa khóa bạc."
  },
  State_3502_Desc = {
    Text = "Người trang bị gây sát thương, tạo lá chắn và tăng hiệu ứng chữa trị [StateArg1]%. (tạm thời)"
  },
  State_3502_Name = {
    Text = "Trạng thái@thử nghiệm dao nhỏ điên cuồng"
  },
  State_3504_Desc = {
    Text = "Mỗi đầu lượt, bốc [StateArg1] lá bài."
  },
  State_3504_Name = {
    Text = "La bàn định hướng sáng tạo"
  },
  State_3504_WeaponDesc = {
    Text = "Mỗi đầu lượt, bốc [StateArg1] lá bài."
  },
  State_3507_Name = {
    Text = "Trang sức dạng sống"
  },
  State_3507_WeaponDesc = {
    Text = "Sau khi người trang bị sử dụng cơn thịnh nộ bùng phát, trong lượt này, hiệu quả của lá chắn và khả năng chữa trị của bản thân sẽ tăng gấp đôi."
  },
  State_3508_Name = {
    Text = "Nhộng của cô gái trang sức"
  },
  State_3508_WeaponDesc = {
    Text = "Sau khi chiến đấu bắt đầu, nếu nghề của người sử dụng là hỗn loạn, sức tấn công tăng 25%."
  },
  State_3510_Desc = {
    Text = "Thân thể được đánh thức gây tăng [Layer] điểm lá chắn."
  },
  State_3510_Name = {
    Text = "<AlertColour:giữ mình>"
  },
  State_3511_Desc = {
    Text = "Người trang bị gây sát thương, tạo lá chắn và tăng hiệu ứng chữa trị [StateArg1]%. (tạm thời)"
  },
  State_3511_Name = {
    Text = "Trạng thái@phiên bản thử nghiệm kiếm dài may mắn"
  },
  State_35120_Desc = {
    Text = "Mỗi lần chịu 1 lần Sát thương chủ động, áp [StateArg1] lớp Ngộ độc lên nguồn gây sát thương, kéo dài [Layer] lượt."
  },
  State_35120_Name = {
    Text = "bông hoa bất diệt trên bùn lầy"
  },
  State_3512_Name = {
    Text = "Sự yếu đuối của miễn dịch tạm thời"
  },
  State_3514_Desc = {
    Text = "Khi kết thúc lượt, chịu <FixedDamage:Sát Thương Thuần Túy> tương đương số lớp và xóa trạng thái này."
  },
  State_3514_Name = {
    Text = "<BleedingIconKeywords: chảy máu>"
  },
  State_3514_WeaponDesc = {
    Text = "Bị thương khi bắt đầu lượt."
  },
  State_35158_Name = {
    Text = "Linh bài thời gian \"Nhập mê\""
  },
  State_3515_Desc = {
    Text = "Thân thể được đánh thức này chưa thức tỉnh… Khi sắp ngã gục sẽ thức tỉnh, hồi phục sức sống và bắt đầu chiến đấu với hình thái thật sự."
  },
  State_3515_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_35161_Name = {
    Text = "Linh bài thời gian \"Tích trữ\""
  },
  State_3516_Name = {
    Text = "Trạng thái @lời nguyền u uất"
  },
  State_3518_Desc = {
    Text = "Phù thủy mỗi lần đánh ra 1 thẻ bài, sẽ nhận được [StateArg2] sức mạnh tạm thời."
  },
  State_3518_Name = {
    Text = "Màn mở đầu buổi diễn"
  },
  State_3519_Desc = {
    Text = "Ngay cả khi không ở trong vòng chơi siêu việt, mỗi vòng chơi cũng có thể kích hoạt hiệu ứng bước nhảy một lần."
  },
  State_3519_Name = {
    Text = "Bẻ cong không gian"
  },
  State_3519_WeaponDesc = {
    Text = "Ngay cả khi không ở trong vòng chơi siêu việt, mỗi vòng chơi cũng có thể kích hoạt hiệu ứng bước nhảy một lần."
  },
  State_3520_Desc = {
    Text = "Khi chiến đấu bắt đầu, chọn một thức tỉnh giả và trao cho họ 50 điên cuồng."
  },
  State_35228_Name = {
    Text = "Linh bài thời gian \"Tích trữ\""
  },
  State_3522_Name = {
    Text = "Số dòng nĩa sáng tạo"
  },
  State_35238_Desc = {
    Text = "Đội duy nhất: Khiên do người trang bị gây ra tăng <WeaponEffect_Num:[StateArg1]%>. Mỗi khi kích hoạt kháng cự tử vong, tất cả thể thức tỉnh nhận được <WeaponEffect_Num:[StateArg2]%> tỷ lệ chí mạng tạm thời và sát thương chí mạng."
  },
  State_35238_WeaponDesc = {
    Text = "Người trang bị tăng cường lá chắn và trúng độc <WeaponEffect_Num:[StateArg1]%>. Mỗi khi kích hoạt kháng cự tử vong, tất cả thân thể tỉnh dậy nhận được <WeaponEffect_Num:[StateArg2]%> tỷ lệ chí mạng và thương chí mạng tạm thời."
  },
  State_3523_Desc = {
    Text = "Sau khi đánh ra, tất cả kẻ địch sẽ yếu đuối [StateArg1] lượt."
  },
  State_3523_Name = {
    Text = "<Rune_1_High:Yếu đuối nâng cao>"
  },
  State_3524_Desc = {
    Text = "Thương phải chịu tăng [Layer] điểm."
  },
  State_3524_Name = {
    Text = "Vết loét rỗng"
  },
  State_3524_WeaponDesc = {
    Text = "Thương phải chịu tăng [Layer] điểm."
  },
  State_3525_Desc = {
    Text = "Mỗi khi đội của tôi đánh ra 1 thẻ bài, sẽ áp đặt 2 lớp [phong tỏa] lên nó."
  },
  State_3525_Name = {
    Text = "\"đông khu đặc biệt\""
  },
  State_3525_WeaponDesc = {
    Text = "Mỗi khi đội của tôi đánh ra 1 thẻ bài, sẽ áp đặt 2 lớp [phong tỏa] lên nó."
  },
  State_35264_Desc = {
    Text = "Trong lượt này, mỗi lần đánh ra 1 lá bài, \"Kỳ Thuật Sư\" sẽ nhận được 1 lớp hình bóng."
  },
  State_35264_Name = {
    Text = "Bản ghi di chuyển hình bóng"
  },
  State_35277_Name = {
    Text = "Phòng thủ phép thuật của Kassia"
  },
  State_3527_Desc = {
    Text = "Mỗi lượt đánh ra thẻ lệnh đầu tiên tương ứng với thân thể được đánh thức, nhận được 15 điên cuồng vào cuối lượt, nếu đồng thời có \"hiến dâng tinh thần\", khiến các thân thể được đánh thức khác cũng nhận được 5 điên cuồng."
  },
  State_3528_Desc = {
    Text = "Người trang bị gây sát thương, tạo lá chắn và tăng hiệu ứng chữa trị [StateArg1]%. (tạm thời)"
  },
  State_3528_Name = {
    Text = "Trạng thái@thử nghiệm pháo laser giới vực"
  },
  State_3529_Desc = {
    Text = "Miễn dịch với mọi loại thương. Loại bỏ sau khi lượt bắt đầu."
  },
  State_3529_Name = {
    Text = "Miễn dịch với sát thương"
  },
  State_3530_Desc = {
    Text = "Trạng thái@may mắn cược bừa bãi 8"
  },
  State_3530_Name = {
    Text = "Trạng thái@may mắn cược bừa bãi 8"
  },
  State_3530_WeaponDesc = {
    Text = "Trạng thái@may mắn cược bừa bãi 8"
  },
  State_3531_Desc = {
    Text = "Đội duy nhất: Khi trận chiến bắt đầu, người trang bị nhận được <WeaponEffect_Num:[StateArg1]> cuồng nộ. Mỗi khi các thân thể được đánh thức khác phát động cơn thịnh nộ bùng phát, người trang bị nhận được <WeaponEffect_Num:[StateArg2]> cuồng nộ. Nếu giới vực hiện tại là \"biển sâu\", sau khi người trang bị phát động cơn thịnh nộ bùng phát, họ sẽ nhận được sát thương râu chạm tương đương với <WeaponEffect_Num:[StateArg3]%> sức tấn công."
  },
  State_3531_WeaponDesc = {
    Text = "Khi trận chiến bắt đầu, người trang bị nhận được <WeaponEffect_Num:[StateArg1]> điên cuồng. Mỗi khi các thân thể được đánh thức khác giải phóng cơn thịnh nộ bùng phát, người trang bị nhận được <WeaponEffect_Num:[StateArg2]> điên cuồng. Nếu giới vực hiện tại là \"biển sâu\", sau khi người trang bị giải phóng cơn thịnh nộ bùng phát, thương râu chạm <WeaponEffect_Num:+[DescArg1]>."
  },
  State_3532_Desc = {
    Text = "Khi bắt đầu lượt, nhận được [StateArg1] sức tính toán."
  },
  State_3532_Name = {
    Text = "Sáng tạo nến đen 1"
  },
  State_3533_Desc = {
    Text = "Chắc chắn xuất hiện trong bài mở đầu."
  },
  State_3533_Name = {
    Text = "<GuyouKeywords:cố hữu>"
  },
  State_3533_WeaponDesc = {
    Text = "Sau khi chiến đấu bắt đầu, lá bài này cố định trong tay."
  },
  State_3535_Desc = {
    Text = "Số điểm tiêu thụ sức tính toán của thẻ bài tăng [Layer] điểm. Hiệu ứng tiêu cực này sẽ bị loại bỏ khi kết thúc lượt hoặc sau khi đánh một thẻ bài."
  },
  State_3535_Name = {
    Text = "<SlowColour:chậm tạm thời [Layer]>"
  },
  State_3535_WeaponDesc = {
    Text = "Số điểm tiêu thụ sức tính toán của thẻ bài tăng thêm [Layer]."
  },
  State_3536_Name = {
    Text = "Trong trận đấu với thủ lĩnh, có thể sử dụng 3 lần"
  },
  State_3537_Desc = {
    Text = "Khi nhận được \"Quà tặng ngây thơ\", có thể thực hiện một lần khắcăng"
  },
  State_3537_Name = {
    Text = "Trạng thái@Chương Một_cảm ứng4"
  },
  State_3537_WeaponDesc = {
    Text = "Khi nhận được \"Quà tặng ngây thơ\", có thể thực hiện một lần khắcăng"
  },
  State_3538_Desc = {
    Text = "Sử dụng \"Quà Trả Ngây Thơ\" để tăng cường điên cuồng"
  },
  State_3538_Name = {
    Text = "Trạng thái@Chương 1_Cảm ứng 1"
  },
  State_3538_WeaponDesc = {
    Text = "Sử dụng \"Quà Trả Ngây Thơ\" để tăng cường điên cuồng"
  },
  State_3539_Desc = {
    Text = "\"Quà đáp lại ngây thơ\" giảm 1 tiêu thụ sức tính toán"
  },
  State_3539_Name = {
    Text = "Trạng thái@Chương 1_cảm ứng3"
  },
  State_3539_WeaponDesc = {
    Text = "\"Quà đáp lại ngây thơ\" giảm 1 tiêu thụ sức tính toán"
  },
  State_3540_Desc = {
    Text = "\"Quà đáp lại ngây thơ\" có thể chỉ định mục tiêu"
  },
  State_3540_Name = {
    Text = "Trạng thái@Chương 1_cảm ứng2"
  },
  State_3540_WeaponDesc = {
    Text = "\"Quà đáp lại ngây thơ\" có thể chỉ định mục tiêu"
  },
  State_3541_Desc = {
    Text = "Kum đã sa vào bẫy mà các bạn đã giăng ra."
  },
  State_3541_Name = {
    Text = "Bị mắc bẫy"
  },
  State_3542_Desc = {
    Text = "Khi trận chiến bắt đầu, mỗi khắcăng trong bộ bài cung cấp [Arg1] điểm lực lượng, đồng thời mỗi sáng tạo giúp hồi [Arg2] điểm sức sống."
  },
  State_3542_Name = {
    Text = "☆Huân chương Thương hội☆"
  },
  State_3545_Name = {
    Text = "Kháng cự Sao không giới hạn"
  },
  State_3545_WeaponDesc = {
    Text = "Mỗi khi đánh ra 1 lá bài, nhận được [StateArg1]% kháng cự tử vong. Khi nhận được kháng cự tử vong, hồi phục [StateArg2] sức sống."
  },
  State_3546_Desc = {
    Text = "Mỗi khi đội của chúng ta đánh ra 1 thẻ bài, sẽ áp dụng [Layer] lớp [ràng buộc]."
  },
  State_3546_Name = {
    Text = "\"đông khu đặc biệt\""
  },
  State_3546_WeaponDesc = {
    Text = "Mỗi khi đội của chúng ta đánh ra 1 thẻ bài, sẽ áp dụng [Layer] lớp [ràng buộc]."
  },
  State_3547_Desc = {
    Text = "Mỗi khi đội của chúng ta đánh ra 1 thẻ bài, sẽ áp dụng [Layer] lớp [ràng buộc]."
  },
  State_3547_Name = {
    Text = "\"đông khu đặc biệt\""
  },
  State_3547_WeaponDesc = {
    Text = "Mỗi khi đội của chúng ta đánh ra 1 thẻ bài, sẽ áp dụng [Layer] lớp [ràng buộc]."
  },
  State_3548_Desc = {
    Text = "Sau khi rút khiến bản thân yếu đuối 1 lượt. Sau khi sử dụng, khiến tất cả kẻ địch yếu đuối 1 lượt. Không thể bán."
  },
  State_3548_Name = {
    Text = "Trạng thái lời nguyền suy yếu"
  },
  State_3548_WeaponDesc = {
    Text = "Sau khi rút khiến bản thân yếu đuối 1 lượt. Sau khi sử dụng, khiến tất cả kẻ địch yếu đuối 1 lượt. Không thể bán."
  },
  State_3549_Name = {
    Text = "Phụ kiện trạng thái sói thảo nguyên"
  },
  State_3549_WeaponDesc = {
    Text = "Trang bị tăng thương cơ bản 10%. Nếu mạnh mẽ của trang bị lớn hơn 20%, thương cơ bản tăng thêm 10%."
  },
  State_35503_Name = {
    Text = "Con Lắc Thời Linh \"Lan Tỏa\""
  },
  State_3551_Desc = {
    Text = "Vào đầu lượt, nếu số lá bài còn lại trong tay từ lượt trước vượt quá [StateArg1] lá, nhận được [StateArg2] điểm sức tính toán."
  },
  State_3551_Name = {
    Text = "Máy Chênh Lêch Bạc Trắng Sáng Tạo"
  },
  State_3551_WeaponDesc = {
    Text = "Vào đầu lượt, nếu số lá bài còn lại trong tay từ lượt trước vượt quá [StateArg1] lá, nhận được [StateArg2] điểm sức tính toán."
  },
  State_35539_Desc = {
    Text = "Thương nhận phải tăng gấp đôi, kéo dài [Layer] lượt."
  },
  State_35539_Name = {
    Text = "Hài cốt hành trình"
  },
  State_3553_Desc = {
    Text = "Tỷ lệ chí mạng tăng 25%. Sau khi hồi sức sống, có xác suất gây thêm 1 lần hồi sức sống, xác suất bằng tỷ lệ chí mạng của người gây hồi sức sống."
  },
  State_3553_Name = {
    Text = "Trạng thái @Chìa Khóa Bạc Mộng Ảo: Chữa trị chí mạng"
  },
  State_3554_Desc = {
    Text = "Hiệu ứng của lá chắn và chữa trị tăng lên [Layer] %"
  },
  State_3554_Name = {
    Text = "Lá chắn và Chữa trị Mạnh mẽ"
  },
  State_3554_WeaponDesc = {
    Text = "Hiệu ứng của lá chắn và chữa trị tăng lên [Layer] %"
  },
  State_3555_Desc = {
    Text = "Nhặt được sẽ có 100% kháng cự tử vong. Sau khi kích hoạt kháng cự tử vong, mỗi đầu vòng trong trận chiến sẽ hồi [Arg1] điểm sức sống."
  },
  State_3555_Name = {
    Text = "Hô Hấp Nhân Tạo"
  },
  State_3556_Desc = {
    Text = "Lấy sáng tạo này và chọn một thẻ bài, thêm một bản sao của nó vào bộ bài."
  },
  State_3558_Desc = {
    Text = "Vào đầu lượt, nếu có hơn 10 dấu đen, tiêu thụ 10 dấu đen và sát thương trong lượt này sẽ tăng gấp đôi."
  },
  State_3559_Desc = {
    Text = "Khi gây sát thương không bị cản, gây 1 lớp yếu đuối."
  },
  State_3559_Name = {Text = "Vuốt"},
  State_3559_WeaponDesc = {
    Text = "Khi gây sát thương thực tế, sẽ trộn [StateArg1] lá \"vết thương\" vào rút bài từ bộ bài."
  },
  State_3561_Name = {
    Text = "Trạng thái @Chìa Khóa Bạc Ảo Mộng: Loạn Trảm đếm"
  },
  State_3562_Desc = {
    Text = "Sau khi chết, lực lượng của các đồng minh khác tăng [Layer]."
  },
  State_3562_Name = {
    Text = "ngôn ngữ chết"
  },
  State_35635_Name = {
    Text = "Trạng thái @ thân thể được đánh thức Kassia có thể kích hoạt kỹ năng lấy vật từ xa"
  },
  State_35636_Name = {
    Text = "Trạng thái @ thân thể được đánh thức Kassia có thể lấy vật từ xa"
  },
  State_3563_Desc = {
    Text = "Khi gây thương mà không bị ngăn cản, sẽ thêm [StateArg1] lá \"thương tích\" vào bộ bài để rút."
  },
  State_3563_Name = {
    Text = "Lưỡi dao sắc"
  },
  State_3563_WeaponDesc = {
    Text = "Khi gây sát thương thực tế, sẽ trộn [StateArg1] lá \"vết thương\" vào rút bài từ bộ bài."
  },
  State_35645_Desc = {
    Text = "Số lượng bài rút trong lượt này giảm [Layer]."
  },
  State_35645_Name = {
    Text = "Rút bài giảm"
  },
  State_35646_Desc = {
    Text = "Số lượng bài rút trong lượt này giảm [Layer]."
  },
  State_35646_Name = {
    Text = "Rút bài giảm"
  },
  State_3564_Desc = {
    Text = "Đánh ra sau đó nhận được [StateArg1] điểm lực lượng tạm thời, thẻ bài khắc āng này cũng có thể hưởng lợi từ lực lượng tăng cường."
  },
  State_3564_Name = {
    Text = "<Rune_15_High:bùng phát mạnh>"
  },
  State_3565_Desc = {
    Text = "Khi người điêu khắc áp dụng lá chắn, tăng [StateArg1] thương tổn râu chạm."
  },
  State_3565_Name = {
    Text = "Trạng thái quên mình"
  },
  State_3565_WeaponDesc = {
    Text = "Khi người điêu khắc áp dụng lá chắn, tăng [StateArg1] thương tổn râu chạm."
  },
  State_3566_Desc = {
    Text = "Vào đầu lượt, nhận 3 lực lượng tạm thời. [Cơn thịnh nộ bùng phát] sẽ gấp đôi lực lượng tạm thời này, tối đa cộng dồn 2 lần."
  },
  State_3566_Name = {
    Text = "Vảy rắn quái vật sáng tạo"
  },
  State_3567_Desc = {
    Text = "Người trang bị gây sát thương, tạo lá chắn và tăng hiệu ứng chữa trị [StateArg1]%. (tạm thời)"
  },
  State_3567_Name = {
    Text = "Trạng thái@thử nghiệm pháo laser chí mạng"
  },
  State_35684_Desc = {
    Text = "Đội của tôi kích hoạt Điên Cuồng Bùng Phát, bản thân mất sức mạnh trong lượt này. Một lần mỗi lượt."
  },
  State_35684_Name = {
    Text = "Sợ hãi điên cuồng"
  },
  State_35685_Desc = {
    Text = "Khi giải phóng nguồn gốc đến, giảm lực lượng nhất thời của kẻ địch."
  },
  State_35685_Name = {
    Text = "Sợ hãi điên cuồng"
  },
  State_3568_Desc = {
    Text = "Khi Ramona gây sát thương, cô nhận được [StateArg1] sức tính toán."
  },
  State_3568_Name = {
    Text = "Triết học đầu tiên"
  },
  State_3568_WeaponDesc = {
    Text = "Khi Ramona gây sát thương, cô nhận được [StateArg1] sức tính toán."
  },
  State_3570_Name = {
    Text = "Khi bắt đầu lượt tiếp theo, số lần rút bài tăng +2"
  },
  State_3571_Name = {
    Text = "Tạm thời miễn dịch với yếu đuối"
  },
  State_3572_Desc = {
    Text = "Quái vật được gọi gây sát thương gấp đôi."
  },
  State_3572_Name = {
    Text = "Lệnh Giả"
  },
  State_3572_WeaponDesc = {
    Text = "Quái vật được gọi gây sát thương gấp đôi."
  },
  State_3573_Desc = {
    Text = "Mỗi lượt, lần đầu chịu thương sẽ gấp 5 lần."
  },
  State_3573_Name = {Text = "Tự hào"},
  State_3573_WeaponDesc = {
    Text = "Mỗi lượt, sát thương lần đầu nhận phải sẽ tăng gấp đôi."
  },
  State_3574_Desc = {
    Text = "Mỗi khi đánh liên tục các lá bài cùng một thức tỉnh thể, thức tỉnh thể đó sẽ nhận được 10 điên cuồng."
  },
  State_35768_Name = {
    Text = "Nhận được 300 đơn vị năng lượng chìa khóa bạc"
  },
  State_35769_Name = {
    Text = "Nhận được 1 điểm sức tính toán"
  },
  State_35770_Name = {
    Text = "Giải trừ các trạng thái: <IntoxicationIconKeywords:trúng độc>, phong ấn, <SlowIconKeywords:chậm>"
  },
  State_35771_Name = {
    Text = "Nhận được [DescArg1]%(<Block:[DescArg2]>) máu tối đa như lá chắn"
  },
  State_35772_Name = {
    Text = "Trận đấu với thủ lĩnh có thể được phép sử dụng thêm [StateArg1] lần"
  },
  State_35774_Desc = {
    Text = "Gọi Hilaster hỗ trợ trước khi chết, khôi phục tất cả sức sống, điên cuồng và năng lượng chìa khóa bạc."
  },
  State_35774_Name = {
    Text = "Màn Utopia"
  },
  State_3577_Name = {
    Text = "Nâng cao hồi phục tự động điên cuồng"
  },
  State_35809_Desc = {
    Text = "Thương gây ra giảm [StateArg1]%, kéo dài [Layer] lượt."
  },
  State_35809_Name = {
    Text = "Kẻ kế thừa hư vọng"
  },
  State_35809_WeaponDesc = {
    Text = "Trạng thái@Cô Gái Biển Sâu Bánh và Trà Đỏ"
  },
  State_3580_Desc = {
    Text = "[Layer] Thương gây ra bởi râu chạm trong lượt là thương xuyên giáp."
  },
  State_3580_Name = {
    Text = "Vòi râu chạm"
  },
  State_35811_Desc = {
    Text = "Khi nhận sát thương chủ động hoặc thương tổn xúc tu, nhận được <SacrificeKeyWord:hiến tế> bằng một nửa sát thương nhận được, kéo dài [Layer] lượt."
  },
  State_35811_Name = {
    Text = "Kẻ kế thừa hư vọng"
  },
  State_35819_Desc = {
    Text = "Vào cuối lượt, Muphí nhận được 5 điểm điên cuồng. Sau khi kích hoạt lệnh khóa, loại bỏ 2% máu tối đa <SacrificeKeyWord:hiến tế>."
  },
  State_35819_Name = {
    Text = "Trà đỏ và bánh ngọt"
  },
  State_3581_Desc = {
    Text = "Trạng thái@Bà Đỏ vũ điệu quyền lực đếm"
  },
  State_3581_Name = {
    Text = "Trạng thái@Bà Đỏ vũ điệu quyền lực đếm"
  },
  State_3582_Desc = {
    Text = "Ngay cả khi không ở trong lượt siêu việt, mỗi lượt vẫn có thể kích hoạt hiệu ứng nhảy vọt một lần. Khi kích hoạt, rút một lá bài tương ứng với thể thức tỉnh."
  },
  State_3582_Name = {
    Text = "Bộ điều hướng không gian dị hóa"
  },
  State_3582_WeaponDesc = {
    Text = "Ngay cả khi không ở trong lượt siêu việt, mỗi lượt vẫn có thể kích hoạt hiệu ứng nhảy vọt một lần. Khi kích hoạt, rút một lá bài tương ứng với thể thức tỉnh."
  },
  State_3584_Desc = {
    Text = "Người trang bị gây sát thương, tạo lá chắn và tăng hiệu ứng chữa trị [StateArg1]%. (tạm thời)"
  },
  State_3584_Name = {
    Text = "Trạng thái @thử-nghiệm-dao-giới-vực"
  },
  State_35858_Desc = {
    Text = "Vào cuối lượt, Muphí nhận được 5 điểm điên cuồng. Sau khi kích hoạt lệnh khóa, gây thương tổn xúc tu bằng 3% sức tấn công của Muphí."
  },
  State_35858_Name = {
    Text = "Trà đỏ và bánh ngọt"
  },
  State_3585_Desc = {
    Text = "Khi sức sống dưới 50%([StateArg1]), \"Đèn Thần Mục Sư\" sẽ cầu nguyện \"Thần Giáng\", hấp thụ tất cả giáo chúng sau đó trở nên cuồng bạo."
  },
  State_3585_Name = {
    Text = "Dấu ấn của dây dẫn lửa"
  },
  State_3585_WeaponDesc = {
    Text = "Khi sức sống dưới 50%([StateArg1]), \"Đèn Thần Mục Sư\" sẽ cầu nguyện \"Thần Giáng\", hấp thụ tất cả giáo chúng sau đó trở nên cuồng bạo."
  },
  State_3588_Name = {
    Text = "Sáng tạo sức tính toán di vật Alchemical"
  },
  State_3589_Desc = {
    Text = "Khi chịu Sát thương chủ động hoặc thương tổn xúc tu, Miễn dịch với sát thương và giảm 1 lớp."
  },
  State_3589_Name = {
    Text = "<ParcloseColour: rào cản>"
  },
  State_3591_Desc = {
    Text = "Đội duy nhất: <RetaliateIconKeywords:phản công> gây ra bởi Người trang bị tăng lên <WeaponEffect_Num:[StateArg1]%>. \"phòng thủ\" nhận được phản công tạm thời bằng <WeaponEffect_Num:[StateArg2]%> Phòng thủ của Người trang bị, trong Trận chiến Lãnh đạo, thay vào đó nhận được phản công tạm thời gấp 3 lần. Sau khi kháng cự tử vong kích hoạt, kích hoạt [StateArg3]% <RetaliateIconKeywords:phản công> lên tất cả kẻ thù."
  },
  State_3591_Name = {
    Text = "Ẩn mình trong đêm"
  },
  State_3591_WeaponDesc = {
    Text = "<RetaliateIconKeywords:phản công> gây ra bởi Người trang bị tăng lên <WeaponEffect_Num:[StateArg1]%>. Sau khi chơi \"phòng thủ\" nhận được <WeaponEffect_Num:[Counterattack:DescArg1]> lớp phản công tạm thời, trong Trận chiến Lãnh đạo, thay vào đó nhận được phản công tạm thời gấp 3 lần. Sau khi kháng cự tử vong kích hoạt, kích hoạt [StateArg3]% <RetaliateIconKeywords:phản công> lên tất cả kẻ thù."
  },
  State_3592_Desc = {
    Text = "Tăng thương từ Xúc Tu"
  },
  State_3592_Name = {
    Text = "<TentacleInjurieIconKeywords:thương tổn xúc tu>"
  },
  State_3592_WeaponDesc = {
    Text = "Tăng sát thương do Xúc Tu gây ra."
  },
  State_3593_Desc = {
    Text = "Đội duy nhất: <IntoxicationIconKeywords:Ngộ độc> gây ra bởi người trang bị tăng <WeaponEffect_Num:[StateArg1]%>. \"Đánh\" gây <WeaponEffect_Num:[StateArg2]%> Tấn Công dưới dạng <IntoxicationIconKeywords:Ngộ độc> lên kẻ thù mục tiêu. Hiệu ứng này tối đa có hiệu lực 3 lần mỗi vòng."
  },
  State_3593_WeaponDesc = {
    Text = "Trang bị gây <IntoxicationIconKeywords:trúng độc> tăng <WeaponEffect_Num:[StateArg1]%>. \"Đòn đánh\" gây <WeaponEffect_Num:[Poison:DescArg1]> tầng <IntoxicationIconKeywords:trúng độc> lên mục tiêu địch. Hiệu ứng này mỗi lượt chỉ có thể kích hoạt tối đa 3 lần."
  },
  State_3596_Name = {
    Text = "Bạc tâm còn lại"
  },
  State_35970_Desc = {
    Text = "Sau khi chết, áp dụng 1 lượt <VulnerabilityIconKeywords:tăng sát thương> cho người chơi."
  },
  State_35970_Name = {
    Text = "Chết yểu"
  },
  State_35971_Desc = {
    Text = "Khi ra trận, nhận được lá chắn tương đương 50% máu tối đa."
  },
  State_35971_Name = {
    Text = "vỏ trứng"
  },
  State_3597_Name = {
    Text = "Bạc tâm còn lại"
  },
  State_3598_Name = {
    Text = "Bạc tâm còn lại"
  },
  State_3599_Desc = {
    Text = "Khi đánh 1 thẻ bài có sức tính toán thực tế tiêu thụ là 4 hoặc cao hơn, tiêu thụ sức tính toán của các thẻ bài khác trong tay giảm 1 điểm"
  },
  State_36006_Desc = {
    Text = "Sau khi chết sẽ tạo ra \"Con của Giấc Mơ\" tại vị trí đó."
  },
  State_36006_Name = {
    Text = "Nhận thịt"
  },
  State_3600_Name = {
    Text = "Bạc tâm còn lại"
  },
  State_36013_Desc = {
    Text = "Trạng thái này cũng được coi là <SacrificeKeyWord:hiến tế>, bắt đầu từ đầu lượt tiếp theo sẽ nhận được [Layer] lớp trạng thái <SacrificeKeyWord:hiến tế>."
  },
  State_36013_Name = {
    Text = "<BlueKeyWord:hiến tế trì hoãn>"
  },
  State_36014_Desc = {
    Text = "Khi kết thúc lượt, nhận [Layer] sát thương đồng thời giảm 50% số tầng <SacrificeKeyWord:hiến tế>."
  },
  State_36014_Name = {
    Text = "<BlueKeyWord:hiến tế>"
  },
  State_3601_Name = {
    Text = "Trạng thái @chìa khóa bạc Mộng Ảo: Đếm vòng múa"
  },
  State_36022_Desc = {
    Text = "Khi nhận thương từ nguồn khác ngoài <SacrificeKeyWord:hiến tế>, nhận được thương 50% dưới dạng <SacrificeKeyWord:hiến tế>."
  },
  State_36022_Name = {
    Text = "Thăm viếng"
  },
  State_36023_Desc = {
    Text = "Sau khi chết, nếu còn đồng minh khác, sẽ tạo ra \"Con Nước\"."
  },
  State_36023_Name = {
    Text = "Nhận thịt"
  },
  State_36024_Desc = {
    Text = "Sau khi chết, nếu còn đồng minh khác, sẽ tạo ra \"Con của Giấc Mơ\"."
  },
  State_36024_Name = {
    Text = "Nhận thịt"
  },
  State_3603_Name = {
    Text = "Trong trận đấu với thủ lĩnh, có thể sử dụng 2 lần và lần đầu tiên sử dụng sẽ đưa về tay người chơi"
  },
  State_3604_Desc = {
    Text = "Khi đội hình bao gồm các thân thể được đánh thức thuộc các nghề nghiệp khác nhau, sức sống của đội hình và chỉ số tấn công cùng phòng thủ của tất cả các thân thể được đánh thức tăng 200%"
  },
  State_3604_Name = {
    Text = "Trạng thái@tăng cường kết hợp"
  },
  State_3604_WeaponDesc = {
    Text = "Khi đội hình bao gồm các thân thể được đánh thức thuộc các nghề nghiệp khác nhau, sức sống của đội hình và chỉ số tấn công cùng phòng thủ của tất cả các thân thể được đánh thức tăng 200%"
  },
  State_3607_Desc = {
    Text = "Đánh ra sau đó làm cho thân thể được đánh thức trong trận chiến này nhận được khả năng đặc biệt được nâng cao. Việc lặp lại Thức tỉnh linh tri thức không cộng dồn hiệu ứng."
  },
  State_3607_Name = {
    Text = "<ExaltIconKeywords:Hoán Tỉnh>"
  },
  State_3607_WeaponDesc = {
    Text = "Thức tỉnh linh tri thức sau khi được đánh ra có thể khiến thân thể được đánh thức nhận được sự gia tăng khả năng đặc biệt trong trận chiến này. Tuy nhiên, Thức tỉnh linh tri thức đánh ra lặp lại không thể cộng dồn hiệu quả."
  },
  State_3608_Name = {
    Text = "Tất cả đồng minh được tăng thêm [StateArg1] điểm điên cuồng"
  },
  State_36092_Desc = {
    Text = "Sau khi chết, nếu còn đồng minh khác, sẽ tạo ra \"Con Nước\" tại vị trí đó."
  },
  State_36092_Name = {
    Text = "Nhận thịt"
  },
  State_36093_Desc = {
    Text = "Mỗi khi mất 1 điểm sức sống, giảm 1 tầng. Khi số tầng bằng 0, sau khi lượt quái vật kết thúc, sẽ gọi 1 \"Con Nước\" và nhận lại [DescArg1] tầng \"Ký Chủ Nước\", tối đa tồn tại 4 \"Con Nước\"."
  },
  State_36093_Name = {
    Text = "Chủ nước"
  },
  State_36094_Desc = {
    Text = "Mỗi khi mất 1 điểm sức sống giảm 1 tầng, khi số tầng bằng 0, gọi 1 \"Linh Giác Tử\", và nhận lại [DescArg1] tầng \"Sơn Hô Ký Chủ\", tối đa tồn tại 4."
  },
  State_36094_Name = {
    Text = "Chủ nhà linh giác"
  },
  State_3609_Name = {
    Text = "Trong trận chiến với thủ lĩnh, có thể sử dụng 2 lần và sau lần sử dụng đầu tiên sẽ trở lại bài trong tay, bài được rút lại trong lượt này sẽ giảm 1 điểm tiêu thụ sức tính toán"
  },
  State_36111_Desc = {
    Text = "Sau khi chết, thêm 1 lá \"Sơn Hô Tăng Sinh\" vào tay người chơi."
  },
  State_36111_Name = {
    Text = "Sanga parasit"
  },
  State_3611_Desc = {
    Text = "Trạng thái @Chương đầu quái vật bị động 12"
  },
  State_3611_Name = {
    Text = "Trạng thái @Chương đầu quái vật bị động 12"
  },
  State_3611_WeaponDesc = {
    Text = "Trạng thái @Chương đầu quái vật bị động 12"
  },
  State_36124_Desc = {
    Text = "Sau khi lượt kết thúc, nhận [Layer] điểm thương và giảm 50% số tầng \"hiến tế\"."
  },
  State_36124_Name = {
    Text = "<BlueKeyWord:hiến tế>"
  },
  State_3612_Desc = {
    Text = "Trạng thái @Chương mở đầu quái vật bị động 13"
  },
  State_3612_Name = {
    Text = "Trạng thái @Chương mở đầu quái vật bị động 13"
  },
  State_3612_WeaponDesc = {
    Text = "Trạng thái @Chương mở đầu quái vật bị động 13"
  },
  State_36136_Name = {
    Text = "Khi ở trong tay, cứ mỗi 1 thẻ bài khác được chơi, nhận [StateArg1] điểm <FixedDamage:Sát Thương Thuần Túy>."
  },
  State_3613_Desc = {
    Text = "Trạng thái @ Chương mở đầu quái vật bị động 10"
  },
  State_3613_Name = {
    Text = "Trạng thái @ Chương mở đầu quái vật bị động 10"
  },
  State_3613_WeaponDesc = {
    Text = "Trạng thái @ Chương mở đầu quái vật bị động 10"
  },
  State_3614_Desc = {
    Text = "Trạng thái @Chương_mở_đầu_Quái_vật_Bị_động_11"
  },
  State_3614_Name = {
    Text = "Trạng thái @Chương_mở_đầu_Quái_vật_Bị_động_11"
  },
  State_3614_WeaponDesc = {
    Text = "Trạng thái @Chương_mở_đầu_Quái_vật_Bị_động_11"
  },
  State_36152_Desc = {
    Text = "Khi kết thúc lượt, nhận lượng thương tương ứng với số tầng. Sau đó, giảm đi một nửa số tầng <SacrificeKeyWord:hiến tế>. Hiến tế sẽ được kế thừa sang trận chiến đấu tiếp theo."
  },
  State_36152_Name = {
    Text = "<SacrificeKeyWord:hiến tế>"
  },
  State_3615_Desc = {
    Text = "Trạng thái @Chương giới thiệu quái vật bị động 16"
  },
  State_3615_Name = {
    Text = "Trạng thái @Chương giới thiệu quái vật bị động 16"
  },
  State_3615_WeaponDesc = {
    Text = "Trạng thái @Chương giới thiệu quái vật bị động 16"
  },
  State_3616_Desc = {
    Text = "Trạng thái @Chương mở đầu quái vật bị động 14"
  },
  State_3616_Name = {
    Text = "Trạng thái @Chương mở đầu quái vật bị động 14"
  },
  State_3616_WeaponDesc = {
    Text = "Trạng thái @Chương mở đầu quái vật bị động 14"
  },
  State_36173_Name = {
    Text = "Trận thủ lĩnh có thể sử dụng [DescArg1] lần"
  },
  State_36174_Name = {
    Text = "（còn lại [Layer] hiệu ứng）"
  },
  State_3617_Desc = {
    Text = "Trạng thái @ Chương mở đầu: Quái vật - Bị động 15"
  },
  State_3617_Name = {
    Text = "Trạng thái @ Chương mở đầu: Quái vật - Bị động 15"
  },
  State_3617_WeaponDesc = {
    Text = "Trạng thái @ Chương mở đầu: Quái vật - Bị động 15"
  },
  State_36182_Name = {
    Text = "Nhận được [DescArg1]%(<Block:[DescArg2]>) sức sống tối đa dưới dạng lá chắn và hồi phục lượng sức sống tương đương, lá chắn tăng theo sức sống đã mất"
  },
  State_3618_Desc = {
    Text = "Nhận được lá chắn khi chịu thương."
  },
  State_3618_Name = {
    Text = "bộ đệm"
  },
  State_3618_WeaponDesc = {
    Text = "Nhận được lá chắn khi chịu thương."
  },
  State_36196_Desc = {
    Text = "Sát thương của \"Đánh\" của lơ-tan tăng 30%."
  },
  State_36196_Name = {
    Text = "gió kiếm bất khuất"
  },
  State_3619_Desc = {
    Text = "Trạng thái @Vũ công Hỏa Thanh hiệu ứng đánh phòng thủ"
  },
  State_3619_Name = {
    Text = "Trạng thái @Vũ công Hỏa Thanh hiệu ứng đánh phòng thủ"
  },
  State_3619_WeaponDesc = {
    Text = "Trạng thái @Vũ công Hỏa Thanh hiệu ứng đánh phòng thủ"
  },
  State_3620_Desc = {
    Text = "Mỗi khi nhận thẻ triệu chứng, tăng máu tối đa [Arg1] điểm."
  },
  State_3621_Desc = {
    Text = "Tín đồ Nguyên Thủy mỗi lần đánh ra 1 lá bài, rút [StateArg1] lá bài và gây 5% trúng độc cho tất cả kẻ địch."
  },
  State_3621_Name = {
    Text = "niềm ám ảnh bị chôn vùi"
  },
  State_3621_WeaponDesc = {
    Text = "Tín đồ Nguyên Thủy mỗi khi đánh 1 lá bài, rút [StateArg1] lá bài"
  },
  State_3622_Desc = {
    Text = "Tăng cường hiệu ứng kỹ năng của \"Thợ Săn Điên Cuồng\" và\"Người Chết\", mỗi đầu lượt nhận được [StateArg1] điểm lực lượng tạm thời, mỗi lớp \"Dấu Ấn Săn Bắn\" lại tăng thêm [StateArg1] điểm."
  },
  State_3622_Name = {
    Text = "Dấu hiệu săn bắn"
  },
  State_36242_Desc = {
    Text = "Sau khi trận chiến bắt đầu, nhận được [StateArg1] điểm lá chắn. Sau khi mất sức sống, \"Đứa Trẻ Thánh\" sẽ kết thúc giấc ngủ say và bắt đầu khóc."
  },
  State_36242_Name = {
    Text = "Giấc ngủ sâu"
  },
  State_3624_Desc = {
    Text = "Trạng thái@người biết lý thuyết tấn công sức mạnh giảm xuống"
  },
  State_3624_Name = {
    Text = "Trạng thái@người biết lý thuyết tấn công sức mạnh giảm xuống"
  },
  State_3625_Desc = {
    Text = "Khi bạn có lá chắn, tăng thương gây ra [Arg1]. Khi lá chắn của bạn cao hơn sức sống hiện tại, thương gây ra tăng thêm [Arg2]."
  },
  State_36263_Desc = {
    Text = "Không còn bị thương, chuẩn bị phát động \"Quả Hạt Sinh Đản\"."
  },
  State_36263_Name = {
    Text = "Miễn dịch"
  },
  State_3628_Name = {
    Text = "Trạng thái @ đánh ra và phá phòng"
  },
  State_3629_Name = {
    Text = "Rút 2 lá bài"
  },
  State_3630_Name = {
    Text = "Gây 2 lớp<VulnerabilityIconKeywords:tăng sát thương> cho tất cả kẻ địch"
  },
  State_36315_Desc = {
    Text = "Cuối lượt, nhận được [Layer] điểm sức mạnh."
  },
  State_36315_Name = {Text = "Monen"},
  State_3631_Name = {
    Text = "Nhận được 2 điểm tính toán"
  },
  State_3632_Name = {
    Text = "Nhận <Energy:[DescArg1]> điểm điên cuồng"
  },
  State_36332_Desc = {
    Text = "Mỗi khi bắt đầu lượt, chọn nhận 1 tầng năng lực Thần Mẫu hoặc dùng năng lực Thần Mẫu để được Muphí hỗ trợ 1 lần."
  },
  State_36332_Name = {
    Text = "Quyền năng của Mẹ Thần"
  },
  State_36334_Desc = {
    Text = "Vào cuối mỗi lượt, nhận được 1 râu chạm."
  },
  State_36334_Name = {
    Text = "Gọi của Lo Aân"
  },
  State_3633_Name = {
    Text = "Áp dụng 2 lớp<WeaknessIconKeywords:yếu đuối> lên tất cả kẻ địch"
  },
  State_36346_Desc = {
    Text = "Khi sức sống giảm xuống còn 0, làm cho sức sống trở thành 1 điểm, ngừng nhận thêm thương, chuẩn bị phát động \"Hạt Giống Sinh Ra\"."
  },
  State_36346_Name = {
    Text = "Hạt giống của Sự ra đời"
  },
  State_3634_Name = {
    Text = "Thêm 2 lá bài<DerivativeCardKeywords_4:「cảm hứng」>vào rút bài từ bộ bài"
  },
  State_3635_Name = {
    Text = "Các thân thể được đánh thức khác nhận được <Energy:[DescArg1]> điểm điên cuồng"
  },
  State_36360_Desc = {
    Text = "Sau khi bắt đầu lượt, có [DescArg1]% xác suất nhận được 1 lớp Tập hợp râu chạm. Nếu vượt quá 100%, có thể nhận được nhiều lớp."
  },
  State_36360_Name = {
    Text = "dòng hải quy"
  },
  State_36361_Desc = {
    Text = "Khi ra trận, các đồng minh khác nhận được [Layer] điểm sức mạnh."
  },
  State_36361_Name = {
    Text = "Phản Kháng Thần Thánh"
  },
  State_3636_Desc = {
    Text = "Trạng thái @sáng tạo hồ phong linh có hiệu lực"
  },
  State_3636_Name = {
    Text = "Trạng thái @sáng tạo hồ phong linh có hiệu lực"
  },
  State_3637_Desc = {
    Text = "Khi sức sống của bạn dưới 25% và chưa chết, lập tức hồi phục [Arg1] điểm sức sống. Kích hoạt 3 lần thì hiệu ứng mất tác dụng vĩnh viễn."
  },
  State_3637_Name = {
    Text = "☆Thực phẩm khẩn cấp☆"
  },
  State_3638_Desc = {
    Text = "Khi chịu Sát thương chủ động hoặc thương tổn xúc tu, Miễn dịch với sát thương và giảm 1 lớp."
  },
  State_3638_Name = {
    Text = "<ParcloseColour: rào cản>"
  },
  State_3638_WeaponDesc = {
    Text = "Giảm 99% sát thương phải chịu, mỗi lần chịu 1 lần sát thương giảm 1 lớp."
  },
  State_3639_Desc = {
    Text = "Khi Ramona gây sát thương, cô nhận được [StateArg1] sức tính toán."
  },
  State_3639_Name = {
    Text = "Triết học thứ ba"
  },
  State_3639_WeaponDesc = {
    Text = "Khi Ramona gây sát thương, cô nhận được [StateArg1] sức tính toán."
  },
  State_3641_Desc = {
    Text = "Tại \"bình tượng nến chưa hoàn thành\", chọn một thẻ để giảm 1 điểm sức tính toán"
  },
  State_3641_Name = {
    Text = "Trạng thái@Chương hai_cảm ứng_hiệu ứng"
  },
  State_3641_WeaponDesc = {
    Text = "Trong nút 『Bình Tượng Nến Chưa Hoàn Thành』 sao chép cấp độ thẻ bài +1"
  },
  State_3642_Desc = {
    Text = "Mỗi khi bạn mất sức sống, nhận [Arg1] lớp phản công. Khi kích hoạt lần thứ 3 trong một lượt, gây thương phản công lên tất cả kẻ địch."
  },
  State_3642_Name = {
    Text = "Đồng Hồ Bỏ Túi Của Người Cũ"
  },
  State_3646_Desc = {
    Text = "Sinh lực không thể giảm xuống dưới 1, khi chịu thương tổn chí mạng, sẽ thay thế ý định thành Sinh tồn trong tuyệt cảnh. [Sinh tồn trong tuyệt cảnh]: hồi phục 100% sinh lực tối đa, lực lượng gấp đôi, tăng cường các kỹ năng tiếp theo."
  },
  State_3646_Name = {
    Text = "Sinh tồn trong tuyệt cảnh"
  },
  State_3647_Name = {
    Text = "Số lượng ghi chép Alacana"
  },
  State_3648_Desc = {
    Text = "Đội duy nhất: Hiệu ứng hồi phục sinh lực của người trang bị tăng <WeaponEffect_Num:[StateArg2]%>. Vào đầu lượt, nhận được <PowerIconKeywords:lực lượng> và lá chắn tạm thời tương đương với <WeaponEffect_Num:[StateArg1]%> sinh lực đã mất trong lượt trước."
  },
  State_3648_WeaponDesc = {
    Text = "Trang bị tăng hiệu ứng hồi sức sống <WeaponEffect_Num:[StateArg2]%>. Vào đầu lượt, nhận được <PowerIconKeywords:lực lượng> và lá chắn tạm thời tương đương với <WeaponEffect_Num:[StateArg1]%> sức sống đã mất trong lượt trước."
  },
  State_3649_Desc = {
    Text = "Mỗi thành viên trong đội hình có nghề nghiệp [siêu việt] thức tỉnh, toàn đội máu tối đa (chưa hoàn thành), phòng thủ, tấn công tăng 50%"
  },
  State_3649_Name = {
    Text = "siêu việt gia tăng"
  },
  State_3649_WeaponDesc = {
    Text = "Mỗi thành viên trong đội hình có nghề nghiệp [siêu việt] thức tỉnh, toàn đội máu tối đa (chưa hoàn thành), phòng thủ, tấn công tăng 50%"
  },
  State_3651_Desc = {
    Text = "Trước khi đánh ra, thay đổi chỉ số thẻ"
  },
  State_3651_Name = {
    Text = "Trước khi đánh ra, thay đổi chỉ số thẻ"
  },
  State_3651_WeaponDesc = {
    Text = "Trước khi đánh ra, thay đổi chỉ số thẻ"
  },
  State_3652_Desc = {
    Text = "Vào đầu lượt, nếu số thẻ bài đánh ra trong lượt trước vượt quá [StateArg1] thẻ, rút [StateArg2] thẻ bài."
  },
  State_3652_Name = {
    Text = "Găng tay thuật sáng tạo"
  },
  State_3652_WeaponDesc = {
    Text = "Vào đầu lượt, nếu số thẻ bài đánh ra trong lượt trước vượt quá [StateArg1] thẻ, rút [StateArg2] thẻ bài."
  },
  State_3653_Name = {
    Text = "Sáng tạo chiến kỳ tàn phá 2"
  },
  State_3654_Desc = {
    Text = "Sau khi lượt bắt đầu, nhận được [Layer]% tỷ lệ chí mạng tạm thời."
  },
  State_3654_Name = {
    Text = "Âm thanh mềm mại dần dần lớn lên"
  },
  State_3654_WeaponDesc = {
    Text = "Nếu không mất sức sống cho đến lượt tiếp theo, tỷ lệ chí mạng lượt tiếp theo +[StateArg1]%."
  },
  State_3656_Desc = {
    Text = "Thân thể được đánh thức này chưa thức tỉnh… Khi sắp ngã gục sẽ thức tỉnh, hồi phục sức sống và bắt đầu chiến đấu với hình thái thật sự."
  },
  State_3656_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_3658_Desc = {
    Text = "Khi đánh lá bài cuối cùng trong tay, rút 2 lá bài. Mỗi vòng tối đa 2 lần."
  },
  State_3659_Name = {
    Text = "Trạng thái @ đánh tỷ lệ chí mạng thương chí mạng tăng"
  },
  State_36613_Name = {
    Text = "Trạng thái@phụ kiện máy móc triệu hồi thần linh kế số"
  },
  State_3661_Desc = {
    Text = "Tăng số lớp Rỗng Rỗng dựa trên sát thương thực sự nhận vào"
  },
  State_3661_Name = {
    Text = "Tăng số lớp rỗng rỗng sâu khi nhận thương"
  },
  State_3661_WeaponDesc = {
    Text = "Tăng số lớp Rỗng Rỗng dựa trên sát thương thực sự nhận vào"
  },
  State_3662_Desc = {
    Text = "Trong trận chiến này, thương harming chí mạng tăng [Layer] %."
  },
  State_3662_Name = {
    Text = "Sát thương chí mạng"
  },
  State_3662_WeaponDesc = {
    Text = "Trong trận chiến này, thương harming chí mạng tăng [Layer] %."
  },
  State_36631_Desc = {
    Text = "Mỗi lần kích hoạt cơn thịnh nộ bùng phát tăng 1 lớp \"Ấp nở\", mỗi lớp Ấp nở nhận được [StateArg1] điểm lực lượng, giới hạn là 5 lớp."
  },
  State_36631_Name = {
    Text = "Chủ thể mang thai giả"
  },
  State_36635_Desc = {
    Text = "Mỗi lần kích hoạt cơn thịnh nộ bùng phát tăng 1 lớp \"Ấp nở\", mỗi lớp Ấp nở nhận được [StateArg1] điểm lực lượng, giới hạn là 5 lớp."
  },
  State_36635_Name = {
    Text = "Sự giáng thần cuối cùng của Lemuria"
  },
  State_36636_Desc = {
    Text = "Khi đạt đến 5 tầng, sẽ giải phóng \"Sự vinh quang của Lemuria!\", gây thương lớn và gọi các tộc thuộc hạ."
  },
  State_36636_Name = {Text = "Mang thai"},
  State_36637_Desc = {
    Text = "Khi đạt đến 5 tầng, sẽ giải phóng \"Vì Lemuria!\", gây sát thương lớn và gọi tộc."
  },
  State_36637_Name = {Text = "Mang thai"},
  State_3663_Desc = {
    Text = "Mỗi lượt, sau khi đánh thẻ bài lần đầu tiên, đặt một thẻ 「「Đánh」」 tương ứng với thân thể được đánh thức vào tay."
  },
  State_3664_Desc = {
    Text = "Sau khi đánh ra, nhận được 5 điểm điên cuồng."
  },
  State_3664_Name = {
    Text = "Kỷ niệm"
  },
  State_3664_WeaponDesc = {
    Text = "Sau khi đánh ra, nhận được 5 điểm điên cuồng."
  },
  State_3665_Desc = {
    Text = "Khi phôi hợp tử đạt đến giới hạn, đặt một lá\"phôi thai\" vào tay."
  },
  State_3665_Name = {
    Text = "<EmbryoFusionIconKeywords:phôi hợp tử>"
  },
  State_3666_Desc = {
    Text = "Tỷ lệ chí mạng tăng [Layer] %."
  },
  State_3666_Name = {
    Text = "Tỉ lệ chí mạng"
  },
  State_3666_WeaponDesc = {
    Text = "Tỷ lệ chí mạng tăng [Layer] %."
  },
  State_36670_Name = {
    Text = "Trạng thái của phụ kiện trong tái diễn hóa đếm"
  },
  State_36670_WeaponDesc = {
    Text = "Trang bị nhận được 3 điểm điên cuồng sau khi lượt hành động kết thúc. Nếu trang bị có hồi phục điên cuồng lớn hơn 10, nhận thêm 2 điểm điên cuồng."
  },
  State_3667_Desc = {
    Text = "Đội duy nhất: Sát thương <RetaliateIconKeywords:phản công> do người trang bị gây ra tăng <WeaponEffect_Num:[StateArg4]%>. Sau khi người trang bị chơi thẻ bài, nhận được <RetaliateIconKeywords:phản công> tương đương với <WeaponEffect_Num:[StateArg1]%> khả năng phòng thủ, tối đa 2 lần mỗi lượt. Nếu họ vào khoảng không gian siêu việt, người trang bị sẽ nhận thêm <WeaponEffect_Num:[StateArg2]> điểm điên cuồng. Sau khi kích hoạt bùng nổ, tất cả kẻ địch mất <WeaponEffect_Num:[StateArg3]%> sức mạnh tạm thời tương đương với khả năng phòng thủ của người trang bị."
  },
  State_3667_WeaponDesc = {
    Text = "Người trang bị gây tăng <RetaliateIconKeywords:phản công> <WeaponEffect_Num:[StateArg4]%>. Sau khi người trang bị chơi thẻ bài, họ nhận được <WeaponEffect_Num:[Counterattack:DescArg1]> điểm <RetaliateIconKeywords:phản công>, mỗi lượt tối đa kích hoạt 2 lần, nếu họ vào khoảng không gian siêu việt, người trang bị còn nhận được <WeaponEffect_Num:[StateArg2]> điểm điên cuồng. Sau khi phát động cơn thịnh nộ bùng nổ, tất cả kẻ thù tạm thời giảm <WeaponEffect_Num:[Power:DescArg2]> điểm lực lượng."
  },
  State_3668_Desc = {
    Text = "Trạng thái: biểu tượng người bảo vệ vườn dị hóa"
  },
  State_3668_Name = {
    Text = "Trạng thái: biểu tượng người bảo vệ vườn dị hóa"
  },
  State_3668_WeaponDesc = {
    Text = "Trạng thái: biểu tượng người bảo vệ vườn dị hóa"
  },
  State_3669_Desc = {
    Text = "Miễn dịch với trạng thái yếu đuối, mong manh và tăng sát thương, kéo dài [Layer] lượt."
  },
  State_3669_Name = {
    Text = "<BlessingColour: phước lành>"
  },
  State_3669_WeaponDesc = {
    Text = "[Layer] Miễn dịch với trạng thái tiêu cực được áp đặt lên trong lượt."
  },
  State_36710_Name = {
    Text = "Vũ điệu của Mặt trăng lồi"
  },
  State_3673_Desc = {
    Text = "Khi nhặt, chọn 2 thẻ bài để xóa, nhận được [StateArg1] sức mạnh."
  },
  State_3673_Name = {
    Text = "Sáng tạo tàn tro sao đen cháy rực"
  },
  State_3674_Desc = {
    Text = "Khi kết thúc lượt, giảm 10 điên cuồng của tất cả các thân thể được đánh thức."
  },
  State_3674_Name = {
    Text = "Tịch diệt"
  },
  State_3674_WeaponDesc = {
    Text = "Khi kết thúc lượt, giảm 10 điên cuồng của tất cả các thân thể được đánh thức."
  },
  State_3675_Name = {
    Text = "Rút số lá bài bị bỏ + 1 lá bài"
  },
  State_3676_Desc = {
    Text = "Trong lượt của đối thủ, giảm sát thương [Layer] %."
  },
  State_3676_Name = {
    Text = "Cảnh giác"
  },
  State_3676_WeaponDesc = {
    Text = "Trong lượt của đội chúng ta, quái vật nhận được [Layer]% giảm sát thương"
  },
  State_3677_Desc = {
    Text = "Tăng [Layer]% khả năng phòng thủ."
  },
  State_3677_Name = {
    Text = "Tăng tỷ lệ khả năng phòng thủ tạm thời"
  },
  State_3677_WeaponDesc = {
    Text = "Tăng [Layer]% khả năng phòng thủ."
  },
  State_36781_Desc = {
    Text = "Khi lực lượng bị giảm, chỉ giảm 50% lớp lực lượng."
  },
  State_36781_Name = {
    Text = "Ý chí khát khao nhận sát thương"
  },
  State_3678_Name = {
    Text = "Trạng thái@sự kiện vật tạo tác 1"
  },
  State_36797_Desc = {
    Text = "Trong lượt này, thương tổn râu chạm giảm [Layer] điểm."
  },
  State_36797_Name = {
    Text = "Thương tổn xúc tu giảm"
  },
  State_3679_Name = {
    Text = "Trạng thái@sự kiện tạo ra 2"
  },
  State_3680_Desc = {
    Text = "Mỗi lần gây 1 điểm thương, sẽ áp dụng [Arg1] lớp trúng độc lên mục tiêu. Nếu số lần kích hoạt trong trận chiến này đạt 25 lần, khiến tất cả kẻ địch trúng độc ngay lập tức."
  },
  State_3681_Desc = {
    Text = "Khi gây sát thương không bị chặn, áp [DescArg1] lớp <BrokenCard:Phá Hoại Ngầm> lên 2 \"thẻ lệnh\" ngẫu nhiên."
  },
  State_3681_Name = {
    Text = "Jenkin thức tỉnh!"
  },
  State_3681_WeaponDesc = {
    Text = "Bắt đầu lượt tiếp theo nhận được lá chắn bằng với sức sống đã mất trong lượt trước."
  },
  State_3682_Desc = {
    Text = "Mỗi khi sức sống giảm 10%, tất cả thân thể được đánh thức nhận được 10 điên cuồng, và tăng thương tổn râu chạm sau khi chết."
  },
  State_3682_Name = {
    Text = "bạc tâm chôn sâu"
  },
  State_3682_WeaponDesc = {
    Text = "Mỗi khi sức sống giảm 10%, tất cả thân thể được đánh thức nhận được 10 điên cuồng, và tăng thương tổn râu chạm sau khi chết."
  },
  State_3683_Desc = {
    Text = "Đội duy nhất: Thẻ lệnh của người trang bị tăng cường chữa trị <WeaponEffect_Num:[StateArg2]%>. Khi người trang bị kích hoạt \"cơn thịnh nộ bùng phát\", các thân thể được đánh thức khác nhận được <WeaponEffect_Num:[StateArg1]> điểm điên cuồng. Nếu đội của chúng ta đang ở trạng thái <VulnerabilityIconKeywords:tăng sát thương>, hiệu ứng sẽ tăng gấp đôi."
  },
  State_3683_WeaponDesc = {
    Text = "Người trang bị thẻ lệnh gây ra sức chữa tăng <WeaponEffect_Num:[StateArg2]%>. Trước khi người trang bị phát động cơn thịnh nộ bùng nổ, các thể thức tỉnh khác nhận được <WeaponEffect_Num:[StateArg1]> điểm điên cuồng. Nếu đội của chúng tôi đang trong trạng thái <VulnerabilityIconKeywords:Trọng thương>, hiệu ứng sẽ gấp đôi."
  },
  State_3684_Desc = {
    Text = "Mỗi lần nhận 1 điểm thương sẽ giảm 1 tầng. Khi số tầng còn 0, sẽ thay thế ý định thành Hoa Bất Diệt và sử dụng bộ kỹ năng thiên về phòng thủ."
  },
  State_3684_Name = {
    Text = "Bunga Abadi"
  },
  State_3684_WeaponDesc = {
    Text = "Mỗi khi nhận 1 điểm thương, giảm 1 lớp. Khi số lớp đạt đến 0, chuyển sang chế độ phòng thủ."
  },
  State_3685_Desc = {
    Text = "Khi rút mất 1 sức tính toán, rút thêm 1 lá bài."
  },
  State_3685_Name = {
    Text = "Hỗn loạn"
  },
  State_3685_WeaponDesc = {
    Text = "Khi rút mất 1 sức tính toán, rút thêm 1 lá bài."
  },
  State_3686_Desc = {
    Text = "Khi rút mất 1 sức tính toán, rút thêm 1 lá bài."
  },
  State_3686_Name = {
    Text = "Niêm phong không gian"
  },
  State_3686_WeaponDesc = {
    Text = "Khi rút mất 1 sức tính toán, rút thêm 1 lá bài."
  },
  State_36884_Desc = {
    Text = "Lời thề cuối cùng của trận chiến này không còn nhận được lá chắn thông qua việc chủ động kích hoạt kháng cự tử vong."
  },
  State_36884_Name = {
    Text = "Lời thề cuối cùng"
  },
  State_3688_Desc = {
    Text = "Khi chơi liên tiếp 2 lá bài có chi phí sức tính toán cao hơn lá trước, nhận được 2 sức tính toán."
  },
  State_3688_Name = {
    Text = "Ký lục sáng tạo 'Alcana'"
  },
  State_3688_WeaponDesc = {
    Text = "Khi chơi liên tiếp 2 lá bài có chi phí sức tính toán cao hơn lá trước, nhận được 2 sức tính toán."
  },
  State_3689_Desc = {
    Text = "Vào đầu lượt, giới vực tinh thông tăng 30. Khi không ở trạng thái tiêu cực, giới vực tinh thông sẽ tăng thành 100."
  },
  State_3692_Desc = {
    Text = "Thẻ bài huyền bí với ngàn dáng vẻ. Hãy chọn lấy thứ bạn cần nhất!"
  },
  State_3692_Name = {
    Text = "<CardKeyWord:Hình Ảnh Ngàn Mặt>"
  },
  State_3692_WeaponDesc = {
    Text = "Thẻ bài huyền bí với ngàn dáng vẻ. Hãy chọn lấy thứ bạn cần nhất!"
  },
  State_3693_Desc = {
    Text = "Tỷ lệ chí mạng tăng 25%. Sau khi hồi sức sống, có xác suất gây thêm 1 lần hồi sức sống, xác suất bằng tỷ lệ chí mạng của người gây hồi sức sống."
  },
  State_3693_Name = {
    Text = "Trạng thái @Chìa Khóa Bạc Mộng Ảo: Chữa trị chí mạng"
  },
  State_3696_Desc = {
    Text = "Mỗi lần gây thương, nhận được [Arg1] điểm giữ mình trong lượt này. Khi bắt đầu lượt, cứ có 3 điểm lá chắn còn lại, nhận được 1 điểm lực lượng trong lượt này."
  },
  State_3696_Name = {
    Text = "Linh bài thời gian \"Ẩn mật\""
  },
  State_3697_Desc = {
    Text = "Vào đầu lượt, rút 1 thẻ bài. Khi đánh liên tiếp 2 lần thẻ bài có sức tính toán giống với thẻ bài trước đó, rút thêm 1 thẻ bài."
  },
  State_3698_Desc = {
    Text = "Đánh ra sau sẽ thêm [StateArg1] bản sao của thẻ bài vào không gian tạm thời<DimensionalSpaceIconKeywords:siêu việt không gian>."
  },
  State_3698_Name = {
    Text = "<Rune_13:truyền tống>"
  },
  State_3699_Name = {
    Text = "Bạc tâm còn lại"
  },
  State_3700_Desc = {
    Text = "Tăng [Layer]% sức tấn công."
  },
  State_3700_Name = {
    Text = "Tăng tạm thời tỷ lệ phần trăm sức tấn công"
  },
  State_3700_WeaponDesc = {
    Text = "Tăng [Layer]% sức tấn công."
  },
  State_3702_Desc = {
    Text = "Trạng thái@thay đổi máu tối đa"
  },
  State_3702_Name = {
    Text = "Trạng thái@thay đổi máu tối đa"
  },
  State_3702_WeaponDesc = {
    Text = "Trạng thái@thay đổi máu tối đa"
  },
  State_3703_Name = {
    Text = "Trạng thái @Chương 4 Cảm ứng @Lượt tiếp theo rút 2 lá bài"
  },
  State_3704_Desc = {
    Text = "Giới vực thông thạo tăng 30. Khi nhặt lên, chọn một sáng tạo và đổi thành sáng tạo khác ngẫu nhiên."
  },
  State_3705_Name = {
    Text = "Khởi Linh Hải Nguyệt 3"
  },
  State_3707_Desc = {
    Text = "Sau khi chiến đấu bắt đầu, sẽ trộn [StateArg1] lá bài sao chép tạm thời vào rút bài từ bộ bài, giữ lại cả thẻ gốc lẫn thẻ phản chiếu."
  },
  State_3707_Name = {
    Text = "<Rune_8:phản chiếu>"
  },
  State_3708_Desc = {
    Text = "Ở cuối lượt chẵn, từng lá bài còn lại trên tay bạn sẽ cho bạn 1 sức tính toán vào đầu lượt tiếp theo."
  },
  State_3708_Name = {
    Text = "Sáng tạo Dự ngôn Chương 2"
  },
  State_3708_WeaponDesc = {
    Text = "Ở cuối lượt chẵn, từng lá bài còn lại trên tay bạn sẽ cho bạn 1 sức tính toán vào đầu lượt tiếp theo."
  },
  State_3709_Desc = {
    Text = "Khi kết thúc lượt lẻ, mỗi điểm sức tính toán còn lại sẽ giúp bạn rút được 1 lá bài vào đầu lượt tiếp theo."
  },
  State_3709_Name = {
    Text = "Sáng tạo Chương Tiên Tri 1"
  },
  State_3709_WeaponDesc = {
    Text = "Khi kết thúc lượt lẻ, mỗi điểm sức tính toán còn lại sẽ giúp bạn rút được 1 lá bài vào đầu lượt tiếp theo."
  },
  State_3711_Desc = {
    Text = "Mỗi khi hành động gây ra [Layer] chảy máu"
  },
  State_3711_Name = {
    Text = "Vết máu bắn"
  },
  State_3711_WeaponDesc = {
    Text = "Mỗi lần hành động gây ra [Layer] chảy máu, chữa trị có thể giảm một nửa chảy máu."
  },
  State_3712_Desc = {
    Text = "Đánh ra thẻ bài sau đó tiêu thụ nó, thẻ lệnh tạo ra 3 lần sát thương và khả năng phòng thủ, kéo dài 1 lượt."
  },
  State_3712_Name = {Text = "dissolusi"},
  State_3714_Desc = {
    Text = "Sau khi đánh ra, nhận được [StateArg1] điểm lá chắn."
  },
  State_3714_Name = {
    Text = "<Rune_6:bức tường thép>"
  },
  State_3716_Desc = {
    Text = "Tỷ lệ chí mạng trong cuộc chiến đấu này tăng [Layer] %."
  },
  State_3716_Name = {
    Text = "Tỉ lệ chí mạng"
  },
  State_3719_Desc = {
    Text = "Khi chịu Sát thương chủ động, khiến nguồn gây sát thương chịu phản công xúc tu, kéo dài [Layer] lượt."
  },
  State_3719_Name = {
    Text = "Máu dị giáo"
  },
  State_3720_Desc = {
    Text = "Tăng [Layer] điểm phòng thủ."
  },
  State_3720_Name = {
    Text = "Khả năng phòng thủ chung tăng lên"
  },
  State_3720_WeaponDesc = {
    Text = "Tăng [Layer] điểm phòng thủ."
  },
  State_3721_Desc = {
    Text = "Sẽ không được đưa vào rác bài, mà sẽ được gỡ bỏ khỏi bộ bài."
  },
  State_3721_Name = {
    Text = "tiêu thụ"
  },
  State_3721_WeaponDesc = {
    Text = "Sau khi đánh, thẻ bài sẽ không vào rác bài và không thể sử dụng lại trong cuộc chiến đấu này."
  },
  State_3722_Desc = {
    Text = "Mỗi lần gây thương tổn, tạm thời tăng thương tổn râu chạm [StateArg1], tối đa 5 lần. Khi số lớp đầy, tạo ra 1 râu chạm."
  },
  State_3722_Name = {
    Text = "Trượng linh mục sáng tạo"
  },
  State_3722_WeaponDesc = {
    Text = "Mỗi lần gây thương tổn, tạm thời tăng thương tổn râu chạm [StateArg1], tối đa 5 lần. Khi số lớp đầy, tạo ra 1 râu chạm."
  },
  State_3723_Name = {
    Text = "Sáng tạo gương đen"
  },
  State_3724_Desc = {
    Text = "Khi nhặt, mất tất cả các sáng tạo khác, nhận ngẫu nhiên 2 đồ tạo tác vàng."
  },
  State_3726_Name = {
    Text = "Bữa tiệc điên rồ của xác chết biến dạng"
  },
  State_3728_Desc = {
    Text = "Khi chiến đấu bắt đầu, nhận được một thẻ [Đánh]."
  },
  State_3728_Name = {
    Text = "1. Khởi Linh Nhảy Voi Biển"
  },
  State_3728_WeaponDesc = {
    Text = "Khi chiến đấu bắt đầu, nhận được một thẻ [Đánh]."
  },
  State_3730_Desc = {
    Text = "Trạng thái @ quái vật ngọt ngào ác quỷ ảo ảnh bi thảm màu mật ong"
  },
  State_3730_Name = {
    Text = "Trạng thái @ quái vật ngọt ngào ác quỷ ảo ảnh bi thảm màu mật ong"
  },
  State_3730_WeaponDesc = {
    Text = "Trạng thái @ quái vật ngọt ngào ác quỷ ảo ảnh bi thảm màu mật ong"
  },
  State_3731_Desc = {
    Text = "Mỗi khi đội của chúng tôi mua sắm tại cửa hàng, trong trận chiến tiếp theo mỗi lượt sẽ rút thêm 1 lá bài và nhận được 1 điểm sức tính toán."
  },
  State_3732_Desc = {
    Text = "Mỗi 3 lượt, nhận được 3 râu chạm tạm thời, râu chạm này không bị giới hạn."
  },
  State_3732_Name = {
    Text = "Sáng tạo không tên chi phụ"
  },
  State_3732_WeaponDesc = {
    Text = "Mỗi 3 lượt, nhận được 3 râu chạm tạm thời, râu chạm này không bị giới hạn."
  },
  State_3733_Desc = {
    Text = "Vào cuối lượt lẻ, chuyển đổi sức tính toán còn lại thành rút bài thêm trong lượt tiếp theo; vào cuối lượt chẵn, chuyển số lá bài còn lại trong tay thành sức tính toán thêm cho lượt sau."
  },
  State_3735_Name = {
    Text = "Đội của chúng tôi \"trúng độc\" giảm một nửa lớp."
  },
  State_3738_Desc = {
    Text = "Khi kết thúc lượt, phôi hợp tử tăng +15%, nếu có \"phôi thai\" trong tay, hồi phục [Arg1] sức sống."
  },
  State_3738_Name = {
    Text = "Phiếu Chẩn Đoán Ôn Dịch"
  },
  State_3739_Name = {
    Text = "Hiệu ứng phụ kiện dạng hữu cơ"
  },
  State_3739_WeaponDesc = {
    Text = "Sau khi người trang bị sử dụng cơn thịnh nộ bùng phát, trong lượt này, hiệu quả của lá chắn và khả năng chữa trị của bản thân sẽ tăng gấp đôi."
  },
  State_3740_Name = {
    Text = "Trạng thái @quỷ ngọt ngào số lần đánh chí mạng"
  },
  State_3741_Desc = {
    Text = "Vào đầu vòng 3, thêm 1 lá \"Hồi Âm Quá Khứ—Bỏ hết bài trên tay, sức sống hiện tại và lá chắn trở về trạng thái cuối vòng trước. Giữ lại, tiêu thụ.\" vào tay."
  },
  State_3742_Desc = {
    Text = "Sau khi đánh ra, tất cả kẻ địch sẽ bị tăng sát thương [StateArg1] lượt."
  },
  State_3742_Name = {
    Text = "<Rune_1:tăng sát thương>"
  },
  State_3743_Desc = {
    Text = "Bạn sẽ kích hoạt 2 lần cho mỗi lá bài thứ 6 bạn đánh ra."
  },
  State_3743_Name = {
    Text = "Rượu sáng tạo các vì sao"
  },
  State_3744_Name = {
    Text = "Sáng tạo nghi thức gương Memphis đếm"
  },
  State_3747_Name = {
    Text = "Chọn một thẻ từ bộ bài rút và thêm vào tay"
  },
  State_3748_Name = {
    Text = "Sát thương gây ra có tỷ lệ chí mạng tăng [DescArg1]%, và thương harming chí mạng tăng [DescArg2]%"
  },
  State_3750_Name = {
    Text = "Tỷ lệ chí mạng tạm thời +[DescArg1]%. Trong trận chiến này, thương cơ bản của \"đòn gãy cổ\" và \"Hình Ảnh Ngàn Mặt\" tăng 5%"
  },
  State_3751_Name = {
    Text = "Nhận thêm [StateArg1] điểm <PowerIconKeywords:lực lượng>"
  },
  State_3752_Name = {
    Text = "Nhận được <Posse:[DescArg1]> điểm năng lượng chìa khóa bạc. nhận được <Block:[Block:StateArg1]> điểm lá chắn"
  },
  State_3753_Desc = {
    Text = "Thẻ bài sẽ không được đưa vào rác bài trong giai đoạn bỏ bài, mà sẽ được giữ lại trong tay bài."
  },
  State_3753_Name = {
    Text = "<RetainIconKeywords:giữ lại>"
  },
  State_3753_WeaponDesc = {
    Text = "Thẻ bài sẽ không được đưa vào rác bài trong giai đoạn bỏ bài, mà sẽ được giữ lại trong tay bài."
  },
  State_3754_Desc = {
    Text = "Khi gây sát thương chủ động, tăng thương tổn râu chạm [Arg1] trong lượt hiện tại, tối đa cộng dồn 3 lần. Khi đạt đủ số lớp, tạo ra 1 râu chạm và sẽ bị loại bỏ sau khi lượt kết thúc."
  },
  State_3755_Desc = {
    Text = "Đội duy nhất: Trang bị gây tăng lá chắn <WeaponEffect_Num:[StateArg1]%>, sức sống hồi phục tăng <WeaponEffect_Num:[StateArg1]%>. Cuối lượt lẻ, tỷ lệ chí mạng của trang bị +<WeaponEffect_Num:[StateArg2]%>, nhận <WeaponEffect_Num:[StateArg3]> điểm điên cuồng; cuối lượt chẵn, thương harming chí mạng của trang bị +<WeaponEffect_Num:[StateArg2]%>, nhận <WeaponEffect_Num:[StateArg4]> năng lượng chìa khóa bạc. Nếu giới vực hiện tại là\"thịt máu\", giới hạn tích trữ của lò luyện kim màu đỏ thẫm tăng <WeaponEffect_Num:[StateArg5]%>."
  },
  State_3755_WeaponDesc = {
    Text = "Trang bị tăng cường lá chắn gây ra <WeaponEffect_Num:[StateArg1]%>, sức sống hồi phục tăng <WeaponEffect_Num:[StateArg1]%>. Vào cuối lượt lẻ, tỷ lệ chí mạng của người trang bị tăng +<WeaponEffect_Num:[StateArg2]%>, nhận <WeaponEffect_Num:[StateArg3]> điểm điên cuồng; vào cuối lượt chẵn, thương harming chí mạng của người trang bị tăng +<WeaponEffect_Num:[StateArg2]%>, nhận <WeaponEffect_Num:[StateArg4]> năng lượng chìa khóa bạc. Nếu giới vực hiện tại là \"thịt máu\", lò luyện kim màu đỏ thẫm tích trữ tối đa tăng lên <WeaponEffect_Num:[StateArg5]%>."
  },
  State_3757_Desc = {
    Text = "Mỗi khi đội của tôi đánh ra 1 lá bài, nhận được [StateArg1] mức lá chắn. Kéo dài 1 lượt."
  },
  State_3757_Name = {
    Text = "Lông vũ bay khắp trời"
  },
  State_3757_WeaponDesc = {
    Text = "Mỗi khi đội của tôi đánh ra 1 lá bài, nhận được [StateArg1] mức lá chắn. Kéo dài 1 lượt."
  },
  State_3759_Name = {
    Text = "Trang bị cơ giới 1"
  },
  State_3760_Desc = {
    Text = "Nếu có ít nhất [StateArg1] dấu đen, [cơn thịnh nộ bùng phát] sẽ mất [StateArg1] dấu đen, đồng thời tăng sát thương và làm yếu đuối tất cả kẻ địch trong 1 lượt."
  },
  State_3760_Name = {
    Text = "Chim lễ hội sáng tạo"
  },
  State_3760_WeaponDesc = {
    Text = "Nếu có ít nhất [StateArg1] dấu đen, [cơn thịnh nộ bùng phát] sẽ mất [StateArg1] dấu đen, đồng thời tăng sát thương và làm yếu đuối tất cả kẻ địch trong 1 lượt."
  },
  State_3761_Desc = {
    Text = "Mỗi khi đội của chúng tôi rút được 1 lá Chầm Chạp, nhận được [Layer] điểm lực lượng."
  },
  State_3761_Name = {
    Text = "Lễ hội đèn lồng"
  },
  State_3761_WeaponDesc = {
    Text = "Mỗi khi đội của chúng tôi rút được 1 lá Chầm Chạp, nhận được [Layer] điểm lực lượng."
  },
  State_3763_Desc = {
    Text = "Mỗi lần Xuyên Hành Giả gây thương, thương harming chí mạng trong lượt này tăng [StateArg3]%."
  },
  State_3763_Name = {
    Text = "đường dẫn gập lại"
  },
  State_3763_WeaponDesc = {
    Text = "Mỗi lần Xuyên Hành Giả gây thương, thương harming chí mạng trong lượt này tăng [StateArg3]%."
  },
  State_3764_Name = {
    Text = "Trang bị cơ giới 2"
  },
  State_3766_Name = {
    Text = "Thêm bội số lực lượng đỏ thẫm"
  },
  State_3767_Desc = {
    Text = "Vào đầu lượt, gây [Arg1] điểm thương cho một kẻ địch ngẫu nhiên. Sau khi đánh 7 lần \"đánh\" trong trận chiến này, sát thương gây ra trở thành [Arg2]."
  },
  State_3767_Name = {
    Text = "Ghép Hình Cũ Kỹ"
  },
  State_3768_Desc = {
    Text = "Thương chủ động nhận được chắc chắn sẽ gây ra critical hit, và hiệu ứng này sẽ tự động biến mất sau khi hết lượt."
  },
  State_3768_Name = {
    Text = "Khuyết điểm"
  },
  State_3768_WeaponDesc = {
    Text = "Thương chủ động nhận được chắc chắn sẽ gây ra critical hit, và hiệu ứng này sẽ tự động biến mất sau khi hết lượt."
  },
  State_3770_Name = {
    Text = "Số lượng di vật Arcana sáng tạo"
  },
  State_3771_Desc = {
    Text = "Khi chiến đấu bắt đầu, nhận được 3 điểm sức mạnh phép thuật."
  },
  State_3772_Desc = {
    Text = "Mỗi lần Đao Trả Thù gây thương, tăng lực lượng tạm thời tương đương với thương tổn râu chạm hiện tại."
  },
  State_3772_Name = {
    Text = "Trả thù chuẩn bị"
  },
  State_3773_Desc = {
    Text = "Khi kết thúc lượt, chịu <FixedDamage:Sát Thương Thuần Túy> tương đương số lớp."
  },
  State_3773_Name = {
    Text = "<IntoxicationIconKeywords:Trúng độc>"
  },
  State_3773_WeaponDesc = {
    Text = "Bị thương khi bắt đầu lượt."
  },
  State_3774_Desc = {
    Text = "Mỗi lần kích hoạt cơn thịnh nộ bùng phát, nhận được một lá có thể gây [Arg1] điểm trúng độc mang tên \"Độc Tính Xâm Nhập\". Cuối lượt, nếu trong tay có đủ 3 lá \"Độc Tính Xâm Nhập\", có thể hợp thành một lá \"Độc Tính Phát Tác\" gây trúng độc."
  },
  State_3776_Desc = {
    Text = "Mỗi lần nhận thương chủ động, tăng một lớp \"Cảnh giác\". Khi \"Cảnh giác\"đạt 3 lớp, tiến hành rút lui."
  },
  State_3776_Name = {
    Text = "Búp bê nhút nhát"
  },
  State_3776_WeaponDesc = {
    Text = "Mỗi lần nhận thương chủ động, tăng một lớp \"Cảnh giác\". Khi \"Cảnh giác\"đạt 3 lớp, tiến hành rút lui."
  },
  State_3777_Desc = {
    Text = "Đánh ra, thân thể được đánh thức có được [StateArg1] điểm điên cuồng."
  },
  State_3777_Name = {
    Text = "<Rune_5_High:cao cấp phẫn nộ>"
  },
  State_3777_WeaponDesc = {
    Text = "Đánh ra, thân thể được đánh thức có được [StateArg1] điểm điên cuồng."
  },
  State_3778_Desc = {
    Text = "Thương gây ra cho kẻ địch trong trạng thái tiêu cực tăng 25%, sau khi giết kẻ địch, người giết nhận được 20 điên cuồng."
  },
  State_3779_Desc = {
    Text = "Giảm giới hạn xúc tu 2 cái. Cuối lượt, làm cho tất cả xúc tu tấn công thêm 1 lần."
  },
  State_3779_Name = {
    Text = "Sáng Tạo Khổ Não Thánh Thủ"
  },
  State_3779_WeaponDesc = {
    Text = "Giảm giới hạn râu chạm đi 2. Cuối lượt, tất cả các râu chạm sẽ tấn công thêm 1 lần."
  },
  State_3781_Desc = {
    Text = "Vào đầu lượt, áp dụng \"Lời nguyền chậm trễ\" lên 2 thẻ bài trên cùng của bộ bài."
  },
  State_3781_Name = {
    Text = "\"mắt nguyền hố sâu\""
  },
  State_3781_WeaponDesc = {
    Text = "Vào đầu lượt, áp dụng \"Lời nguyền chậm trễ\" lên 2 thẻ bài trên cùng của bộ bài."
  },
  State_3782_Desc = {
    Text = "Hiệu ứng độc nhất cho đội: Khi bắt đầu khám phá, thêm một lá bài \"phòng thủ\" từ người trang bị vào bộ bài, và tăng \"phòng thủ\" lá chắn của người trang bị thêm <WeaponEffect_Num:[StateArg1]%>."
  },
  State_3782_WeaponDesc = {
    Text = "Khi bắt đầu khám phá, thêm một lá bài \"phòng thủ\" của người trang bị vào bộ bài. Lá chắn \"phòng thủ\" của người trang bị tăng <WeaponEffect_Num:[StateArg1]%>."
  },
  State_3783_Desc = {
    Text = "Đội duy nhất: Khi người sở hữu trang bị kích hoạt cơn thịnh nộ bùng phát, sát thương cơ bản tăng <WeaponEffect_Num:[StateArg1]%>, hiệu ứng hồi phục lá chắn và sức sống tăng <WeaponEffect_Num:[StateArg2]%>."
  },
  State_3783_WeaponDesc = {
    Text = "Người trang bị kích hoạt cơn thịnh nộ bùng phát, tăng thương cơ bản <WeaponEffect_Num:[StateArg1]%>, tăng hồi sức sống và lá chắn <WeaponEffect_Num:[StateArg2]%>."
  },
  State_3784_Desc = {
    Text = "Đội duy nhất: thương cơ bản của thẻ lệnh trang bị tăng <WeaponEffect_Num:[StateArg1]%>, lá chắn và sức sống được tăng cường <WeaponEffect_Num:[StateArg2]%>."
  },
  State_3784_WeaponDesc = {
    Text = "Trang bị thẻ lệnh cơ bản tăng thương cơ bản <WeaponEffect_Num:[StateArg1]%>, tăng hồi lá chắn và sức sống <WeaponEffect_Num:[StateArg2]%>."
  },
  State_3786_Desc = {
    Text = "Bạn đã bị khóa! Sau khi đánh ra, tất cả quái vật sẽ nhận được [StateArg1] điểm lực lượng tạm thời và loại bỏ dấu ấn lặn sâu của lệnh này."
  },
  State_3786_Name = {
    Text = "<CardKeyWord:dấu ấn lặn sâu>"
  },
  State_3786_WeaponDesc = {
    Text = "Sau khi đánh thẻ bài, Deep One nhận được [StateArg1] điểm lực lượng tạm thời."
  },
  State_3787_Desc = {
    Text = "Đội duy nhất: Sau khi người trang bị phát động cơn thịnh nộ bùng phát, tất cả đồng minh nhận được <WeaponEffect_Num:[StateArg1]> điên cuồng."
  },
  State_3787_WeaponDesc = {
    Text = "Người trang bị sau khi phát động cơn thịnh nộ bùng phát, tất cả đồng minh nhận được <WeaponEffect_Num:[StateArg1]> năng lượng điên cuồng."
  },
  State_3788_Desc = {
    Text = "Đội duy nhất: Khi bắt đầu khám phá, thêm một lá \"Đánh\" của người trang bị vào bộ bài, thương cơ bản của \"Đánh\" của người trang bị tăng <WeaponEffect_Num:[StateArg1]%>."
  },
  State_3788_WeaponDesc = {
    Text = "Khi bắt đầu khám phá, thêm một lá \"Đánh\" của người trang bị vào bộ bài, thương cơ bản của \"Đánh\" tăng <WeaponEffect_Num:[StateArg1]%>."
  },
  State_3790_Desc = {
    Text = "Trạng thái@không định tính chất vật chất"
  },
  State_3790_Name = {
    Text = "Trạng thái@không định tính chất vật chất"
  },
  State_3790_WeaponDesc = {
    Text = "Trạng thái@không định tính chất vật chất"
  },
  State_3791_Desc = {
    Text = "Mỗi khi gây thương hại sẽ nhận được [Arg1] điểm lá chắn, tối đa 5 lần cộng dồn mỗi lượt, khi đạt giới hạn sẽ đưa một \"cảm hứng\" vào tay."
  },
  State_3792_Desc = {
    Text = "Không còn bị ảnh hưởng bởi hoá đá."
  },
  State_3792_Name = {
    Text = "Khả năng kháng đá hóa"
  },
  State_3792_WeaponDesc = {
    Text = "Không còn bị hóa đá, thay vào đó nhận gấp ba lần sát thương"
  },
  State_3793_Desc = {
    Text = "Thương harming chí mạng trong lượt chơi này tăng [Layer] %."
  },
  State_3793_Name = {
    Text = "Thương chí mạng vĩnh viễn"
  },
  State_3793_WeaponDesc = {
    Text = "Thương harming chí mạng trong lượt chơi này tăng [Layer] %."
  },
  State_3794_Desc = {
    Text = "Người trang bị gây sát thương, tạo lá chắn và tăng hiệu ứng chữa trị [StateArg1]%. (tạm thời)"
  },
  State_3794_Name = {
    Text = "Trạng thái@kiếm thử nghiệm dài bạo thương"
  },
  State_3796_Desc = {
    Text = "Mỗi khi sức sống giảm 20%, tất cả thân thể được đánh thức nhận 10 điên cuồng, sau khi chết tăng thương tổn râu chạm"
  },
  State_3796_Name = {
    Text = "Partikel Bạc Tách Ra"
  },
  State_3796_WeaponDesc = {
    Text = "Mỗi khi sức sống giảm 20%, tất cả thân thể được đánh thức nhận 10 điên cuồng, sau khi chết tăng thương tổn râu chạm"
  },
  State_3797_Desc = {
    Text = "Mỗi lần nhận thương sẽ được [StateArg1] điểm lực lượng tạm thời, biến mất vào đầu lượt."
  },
  State_3797_Name = {
    Text = "Sự giận dữ của đàn chuột!"
  },
  State_37980_Desc = {
    Text = "Trong trận chiến này, giới vực tinh thông tăng lên [Layer]."
  },
  State_37980_Name = {
    Text = "Sự thông thạo giới vực"
  },
  State_3798_Desc = {
    Text = "Sau khi gây thương sẽ hồi phục sức sống."
  },
  State_3798_Name = {
    Text = "Lưỡi Hấp Máu"
  },
  State_3798_WeaponDesc = {
    Text = "Sau khi gây thương sẽ hồi phục sức sống."
  },
  State_3799_Desc = {
    Text = "Trong đội hình, cứ có một thân thể được đánh thức thuộc nghề nghiệp [thịt máu], toàn đội sẽ tăng 50% máu tối đa (chưa hoàn thành), phòng thủ và tấn công"
  },
  State_3799_Name = {
    Text = "Bonus thịt máu"
  },
  State_3799_WeaponDesc = {
    Text = "Trong đội hình, cứ có một thân thể được đánh thức thuộc nghề nghiệp [thịt máu], toàn đội sẽ tăng 50% máu tối đa (chưa hoàn thành), phòng thủ và tấn công"
  },
  State_3800_Desc = {
    Text = "Gây thương cho tất cả kẻ địch. <CardKeyWord:lực lượng> có hiệu ứng gấp bội trên sát thương này."
  },
  State_3800_Name = {
    Text = "<CardKeyWord:Sức mạnh của Lưỡi đao khổng lồ>"
  },
  State_3801_Desc = {
    Text = "Khi gây sát thương không bị chặn, thêm [StateArg1] lớp chảy máu."
  },
  State_3801_Name = {
    Text = "Chảy máu"
  },
  State_3802_Desc = {
    Text = "Khi ở trong bộ bài trên tay, mỗi lần sử dụng 1 thẻ lệnh, nó sẽ biến thành bản sao với sức tính toán bằng 0."
  },
  State_3802_Name = {
    Text = "<CardKeyWord:Đứa con thánh thiện>"
  },
  State_3802_WeaponDesc = {
    Text = "Khi ở trong bài trên tay, mỗi lần sử dụng 1 lá bài sẽ biến thành bản sao có sức tính toán là 0."
  },
  State_3803_Desc = {
    Text = "Khi trận chiến bắt đầu, tất cả các thẻ bài có tiêu thụ sức tính toán hiện tại là 1 sẽ được tăng [Arg1] điểm thương, lá chắn và chữa trị trong trận chiến này."
  },
  State_3804_Desc = {
    Text = "Số lượng dòng nĩa dị hóa"
  },
  State_3804_Name = {
    Text = "Số lượng dòng nĩa dị hóa"
  },
  State_3804_WeaponDesc = {
    Text = "Số lượng dòng nĩa dị hóa"
  },
  State_3807_Name = {
    Text = "Giấc mơ về đồ trang sức và dược phẩm"
  },
  State_3807_WeaponDesc = {
    Text = "Sau khi chiến đấu bắt đầu, thêm bộ bài của người trang bị vào bộ bài rút."
  },
  State_3808_Desc = {
    Text = "Trạng thái@điều chỉnh sức sống hiện tại"
  },
  State_3808_Name = {
    Text = "Trạng thái@điều chỉnh sức sống hiện tại"
  },
  State_3808_WeaponDesc = {
    Text = "Trạng thái@điều chỉnh sức sống hiện tại"
  },
  State_3810_Desc = {
    Text = "Sau khi chết, đồng minh còn lại được tăng sức mạnh."
  },
  State_3810_Name = {
    Text = "ngôn ngữ chết"
  },
  State_3811_Desc = {
    Text = "Trạng thái@Chương mở đầu đặt lại bộ bài 0_1_4_1"
  },
  State_3811_Name = {
    Text = "Trạng thái@Chương mở đầu đặt lại bộ bài 0_1_4_1"
  },
  State_3811_WeaponDesc = {
    Text = "Trạng thái@Chương mở đầu đặt lại bộ bài 0_1_4_1"
  },
  State_3813_Name = {
    Text = "Miễn dịch yếu đuối"
  },
  State_3815_Desc = {
    Text = "Khi kết thúc lượt, tất cả thân thể được đánh thức mất [Layer] điểm điên cuồng."
  },
  State_3815_Name = {
    Text = "<EnergyColour:hư không>"
  },
  State_3815_WeaponDesc = {
    Text = "Giảm [Layer]% điên cuồng nhận được."
  },
  State_3817_Desc = {
    Text = "Vào đầu lượt, gây [DescArg1] điểm Suy Kiệt cho đối thủ."
  },
  State_3817_Name = {Text = "Dispersi"},
  State_3817_WeaponDesc = {
    Text = "Vào đầu lượt, đội của tôi nhận được [DescArg1*Layer*0.01] tầng suy yếu"
  },
  State_3818_Name = {
    Text = "Trạng thái@tri thức khởi linh1"
  },
  State_3819_Name = {
    Text = "Phá Liên giả khởi linh 1"
  },
  State_3819_WeaponDesc = {
    Text = "Imitasi Penjelajah Kuno"
  },
  State_3821_Desc = {
    Text = "Vào đầu lượt, nhận lá chắn bằng nửa số sức sống mất đi ở lượt trước."
  },
  State_3821_Name = {
    Text = "Đau đớn và niềm vui"
  },
  State_3821_WeaponDesc = {
    Text = "Bắt đầu lượt tiếp theo nhận được lá chắn bằng với sức sống đã mất trong lượt trước."
  },
  State_3824_Desc = {
    Text = "Đội duy nhất: Sát thương cơ bản của cơn thịnh nộ bùng phát của người trang bị tăng [StateArg1]%. Khi bắt đầu khám phá, người trang bị sẽ vào trạng thái nhân cách học giả. Sau khi người trang bị phát động cơn thịnh nộ bùng phát, họ sẽ chuyển đổi giữa nhân cách học giả và nhân cách kẻ hề. \nNhân cách học giả: Vào cuối lượt, người trang bị nhận được <WeaponEffect_Num:[StateArg2]> điểm điên cuồng. \nNhân cách kẻ hề: Vào cuối lượt, tỉ lệ chí mạng và sát thương chí mạng của người trang bị tăng <WeaponEffect_Num:+[StateArg3] %>."
  },
  State_3824_WeaponDesc = {
    Text = "Sát thương cơ bản của cơn thịnh nộ bùng phát của người trang bị tăng [StateArg1]%. Khi bắt đầu cuộc khám phá, người trang bị chuyển vào trạng thái nhân cách học giả. Sau khi người trang bị phát động cơn thịnh nộ bùng phát, họ sẽ chuyển đổi giữa nhân cách học giả và nhân cách kẻ hề. \n Nhân cách học giả: Cuối lượt, người trang bị nhận được <WeaponEffect_Num:[StateArg2]> điểm điên cuồng. \n Nhân cách kẻ hề: Cuối lượt, tỷ lệ chí mạng và sát thương chí mạng của người trang bị tăng <WeaponEffect_Num:+[StateArg3]%>."
  },
  State_3825_Desc = {
    Text = "Khi chịu Sát thương chủ động, gây <FixedDamage:Sát Thương Thuần Túy> tương đương số lớp lên nguồn gây sát thương."
  },
  State_3825_Name = {
    Text = "<RetaliateIconKeywords: phản công>"
  },
  State_3825_WeaponDesc = {
    Text = "Mỗi lần chịu Sát thương chủ động, gây <FixedDamage:Sát Thương Thuần Túy> lên kẻ tấn công."
  },
  State_3826_Name = {
    Text = "Trạng thái @chìa khóa bạc Mộng Ảo: Số lần bùng nổ"
  },
  State_3827_Desc = {
    Text = "Duy nhất trong đội: Trang bị tăng hồi phục sức sống <WeaponEffect_Num:[StateArg1]%>. Sau khi giải phóng cơn thịnh nộ bùng phát, đầu lượt tiếp theo hồi phục <WeaponEffect_Num:[StateArg2]%> sức sống đã mất."
  },
  State_3827_WeaponDesc = {
    Text = "Trang bị tăng hồi phục sức sống <WeaponEffect_Num:[StateArg1]%>. Sau khi sử dụng cơn thịnh nộ bùng phát, hồi phục <WeaponEffect_Num:[DescArg1]%> sức sống đã mất vào đầu lượt tiếp theo."
  },
  State_3830_Name = {
    Text = "Có hiệu lực thêm 1 lần"
  },
  State_3831_Name = {
    Text = "Rễ Sinh Ngược của Sáng Tạo"
  },
  State_3834_Desc = {
    Text = "Nhện mê cung khiến trúng độc gấp đôi."
  },
  State_3834_Name = {
    Text = "Hành trình lạc lối"
  },
  State_3835_Desc = {
    Text = "Trong lượt này, sát thương chí mạng tăng [Layer]%."
  },
  State_3835_Name = {
    Text = "Sát thương bạo kích tạm thời"
  },
  State_3835_WeaponDesc = {
    Text = "Trong lượt này, sát thương chí mạng tăng [Layer]%."
  },
  State_3836_Desc = {
    Text = "Kiểm thử123"
  },
  State_3836_Name = {
    Text = "Kiểm thử123"
  },
  State_3837_Desc = {
    Text = "Đội duy nhất: điên cuồng gây ra của Người trang bị tăng <WeaponEffect_Num:[StateArg1]%>, Ngộ độc gây ra tăng <WeaponEffect_Num:[StateArg2]%>. Sau khi Người trang bị gây Sát thương chủ động, Sát thương bạo kích tạm thời của tất cả Thể thức tỉnh tăng, giá trị bằng <WeaponEffect_Num:[StateArg3]%> Sát thương chí mạng căn bản của Người trang bị, tối đa 1 lần mỗi lượt. Nếu Cõi hiện tại là \"Hải Vực\", khi bắt đầu chiến đấu, Giới hạn râu chạm và Số lượng xúc tu +1."
  },
  State_3837_WeaponDesc = {
    Text = "điên cuồng gây ra của Người trang bị tăng <WeaponEffect_Num:[StateArg1]%>, Ngộ độc gây ra tăng <WeaponEffect_Num:[StateArg2]%>. Sau khi Người trang bị gây Sát thương chủ động, Sát thương bạo kích tạm thời của tất cả Thể thức tỉnh +<WeaponEffect_Num:[DescArg1]%>, tối đa 1 lần mỗi lượt. Nếu Cõi hiện tại là \"Hải Vực\", khi bắt đầu chiến đấu, Giới hạn râu chạm và Số lượng xúc tu +1."
  },
  State_3839_Desc = {
    Text = "Khi trận chiến bắt đầu, mỗi lá thẻ triệu chứng trong bộ bài của bạn sẽ mang lại [Arg1] sức mạnh. Tất cả các lá thẻ triệu chứng của bạn nhận được hư vô."
  },
  State_3840_Desc = {
    Text = "Mỗi lần điểm sức sống giảm, nhận được [StateArg1] tư thế cảnh giác."
  },
  State_3840_Name = {
    Text = "Cảnh giác"
  },
  State_3842_Desc = {
    Text = "Giảm Sát thương chủ động và thương tổn xúc tu gây ra [DescArg1] %."
  },
  State_3842_Name = {
    Text = "Suy nhược"
  },
  State_3842_WeaponDesc = {
    Text = "Mọi sát thương gây ra bị giảm [DescArg1] %."
  },
  State_3843_Desc = {
    Text = "Mỗi lần hành động gây ra [Layer] chảy máu"
  },
  State_3843_Name = {
    Text = "Thương nặng"
  },
  State_3843_WeaponDesc = {
    Text = "Mỗi lần hành động gây thêm [Layer] hiệu ứng chảy máu, chữa trị có thể loại bỏ hiệu ứng chảy máu"
  },
  State_3844_Desc = {
    Text = "Số lần gây thương của Cá Voi Nhảy tăng thêm 1."
  },
  State_3844_Name = {
    Text = "Khát vọng chiến đấu không thể dập tắt"
  },
  State_3844_WeaponDesc = {
    Text = "Số lần gây thương của Cá Voi Nhảy tăng thêm 1."
  },
  State_3845_Desc = {
    Text = "Sức mạnh tính toán của thẻ bài giảm"
  },
  State_3845_Name = {
    Text = "Sức mạnh tính toán của thẻ bài giảm"
  },
  State_3845_WeaponDesc = {
    Text = "Sức mạnh tính toán của thẻ bài giảm"
  },
  State_3846_Name = {
    Text = "Bản khắc ngọc lục bảo sáng tạo"
  },
  State_3848_Desc = {
    Text = "Trong trận chiến này, cơn điên cuồng của một thực thể được thức tỉnh ngẫu nhiên đã bị niêm phong và không thể kích hoạt."
  },
  State_3848_Name = {Text = "Phong ấn"},
  State_3850_Desc = {
    Text = "Mỗi khi đánh ra lá bài thứ [StateArg1], tăng [StateArg2] thương tổn xúc tu, khiến tất cả xúc tu tấn công một lượt."
  },
  State_3850_Name = {
    Text = "Fishfork bị dị hóa"
  },
  State_3850_WeaponDesc = {
    Text = "Mỗi khi đánh ra lá bài thứ [StateArg1], tăng [StateArg2] thương tổn xúc tu, khiến tất cả xúc tu tấn công một lượt."
  },
  State_3851_Name = {
    Text = "Trang Sức Mèo Nhà Hát"
  },
  State_3851_WeaponDesc = {
    Text = "Tất cả sát thương gây ra được tăng lên, lượng tăng tương đương với 10% máu tối đa của chủ nhân"
  },
  State_3852_Desc = {
    Text = "Số lần gây thương từ cắn xé tăng lên [Layer]."
  },
  State_3852_Name = {
    Text = "Răng nanh tăng cường"
  },
  State_3852_WeaponDesc = {
    Text = "Số lần gây thương từ cắn xé tăng lên [Layer]."
  },
  State_3853_Desc = {
    Text = "Vào đầu lượt, biến dạng ngẫu nhiên thành bản sao của một thẻ lệnh trong rút bài từ bộ bài, với chi phí tiêu thụ sức tính toán cố định là 3, và trở lại hình dạng ban đầu vào cuối lượt."
  },
  State_3853_Name = {
    Text = "<CardKeyWord:ảo giác>"
  },
  State_3853_WeaponDesc = {
    Text = "Thẻ bài sẽ không được đưa vào rác bài trong giai đoạn bỏ bài, mà sẽ được giữ lại trong tay bài."
  },
  State_3854_Desc = {
    Text = "Rút 2 lá bài, đồng thời có thể thu hút sự chú ý của thợ săn đầu lâu."
  },
  State_3854_Name = {
    Text = "<CardKeyWord:săn lùng>"
  },
  State_3855_Name = {
    Text = "lực lượng"
  },
  State_3856_Desc = {
    Text = "Trạng thái@phần mở đầu đặt lại bộ bài 0_1_3_1"
  },
  State_3856_Name = {
    Text = "Trạng thái@phần mở đầu đặt lại bộ bài 0_1_3_1"
  },
  State_3856_WeaponDesc = {
    Text = "Trạng thái@phần mở đầu đặt lại bộ bài 0_1_3_1"
  },
  State_3859_Desc = {
    Text = "Điên cuồng được nhân đôi bởi Làn Sinh Khí Phong Phú."
  },
  State_3859_Name = {
    Text = "mắt thấy mẹ"
  },
  State_3859_WeaponDesc = {
    Text = "Điên cuồng được nhân đôi bởi Làn Sinh Khí Phong Phú."
  },
  State_3860_Desc = {
    Text = "Người trang bị gây sát thương, tạo lá chắn và tăng hiệu ứng chữa trị [StateArg1]%. (tạm thời)"
  },
  State_3860_Name = {
    Text = "Trạng thái: Dao Thử Nghiệm May Mắn"
  },
  State_3862_Name = {
    Text = "Trạng thái@vòng 2_15 chiến đấu 4 bong bóng 1"
  },
  State_3863_Desc = {
    Text = "Sau mỗi 3 lần cơn thịnh nộ bùng phát, tiêu thụ sức tính toán của tất cả các lá bài trên tay giảm 1."
  },
  State_3866_Desc = {
    Text = "Trong lượt này, giới hạn bài trên tay +[Layer]."
  },
  State_3866_Name = {
    Text = "Giới hạn bài trong tay tăng lên"
  },
  State_3867_Name = {
    Text = "Bộ đếm nghề siêu việt"
  },
  State_3868_Desc = {
    Text = "Trong vòng này, lá chắn được tăng lên [Layer] điểm."
  },
  State_3868_Name = {
    Text = "Giữ mình tạm thời"
  },
  State_3868_WeaponDesc = {
    Text = "Trong vòng này, lá chắn được tăng lên [Layer] điểm."
  },
  State_3872_Desc = {
    Text = "Khi bị thương, lực lượng tạm thời sẽ bị loại bỏ."
  },
  State_3872_Name = {
    Text = "Khuyết điểm"
  },
  State_38730_Desc = {
    Text = "Sau khi bắt đầu lượt, có [DescArg1]% xác suất nhận được 1 lớp Tập hợp râu chạm. Nếu vượt quá 100%, có thể nhận được nhiều lớp."
  },
  State_38730_Name = {
    Text = "dòng hải quy"
  },
  State_38735_Desc = {
    Text = "Sát thương chủ động gây ra giảm [StateArg1]%, số lần tấn công tăng gấp đôi, kéo dài [Layer] lượt."
  },
  State_38735_Name = {Text = "Delirium"},
  State_38738_Desc = {
    Text = "Giới hạn là 10 tầng, có thể kế thừa sang chiến đấu tiếp theo."
  },
  State_38738_Name = {
    Text = "Dẫn mộng"
  },
  State_3873_Desc = {
    Text = "Trong trận chiến này, kỹ năng giới vực được tăng [Layer] điểm."
  },
  State_3873_Name = {
    Text = "Sự thông thạo giới vực"
  },
  State_3874_Name = {
    Text = "Trạng thái @thẻ bài Phong Linh phục hồi"
  },
  State_3876_Desc = {
    Text = "Mỗi lượt chẵn làm giảm lực lượng của đội tôi."
  },
  State_3876_Name = {
    Text = "\"lỗ hổng từ cơn ác mộng tử vong\""
  },
  State_3878_Desc = {
    Text = "Mỗi khi mất 2 điểm sức sống, bắt đầu lượt tiếp theo, sẽ nhận được [Layer] điểm lá chắn."
  },
  State_3878_Name = {
    Text = "Đau đớn và niềm vui"
  },
  State_3878_WeaponDesc = {
    Text = "Bắt đầu lượt tiếp theo nhận được lá chắn bằng với sức sống đã mất trong lượt trước."
  },
  State_3879_Desc = {
    Text = "Khi nhặt, tăng máu tối đa [Arg1] điểm. Nếu máu dưới 25% khi nhặt, tăng máu tối đa sẽ trở thành [Arg2] điểm."
  },
  State_3881_Desc = {
    Text = "Trạng thái @ quái vật George (Georges) ăn bình tượng nến nhỏ"
  },
  State_3881_Name = {
    Text = "Trạng thái @ quái vật George (Georges) ăn bình tượng nến nhỏ"
  },
  State_3881_WeaponDesc = {
    Text = "Trạng thái @ quái vật George (Georges) ăn bình tượng nến nhỏ"
  },
  State_3882_Desc = {
    Text = "Thân thể được đánh thức này chưa thức tỉnh… Khi sắp ngã gục sẽ thức tỉnh, hồi phục sức sống và bắt đầu chiến đấu với hình thái thật sự."
  },
  State_3882_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_3883_Desc = {
    Text = "Bản cập nhật này tăng tỷ lệ chí mạng trong [Layer] %."
  },
  State_3883_Name = {
    Text = "Tỷ lệ chí mạng vĩnh viễn"
  },
  State_3883_WeaponDesc = {
    Text = "Bản cập nhật này tăng tỷ lệ chí mạng trong [Layer] %."
  },
  State_3884_Desc = {
    Text = "Mỗi lượt tạo ra thêm 1 độ phôi hợp tử. Tất cả hiệu ứng tiêu thụ của bạn đều trở thành tiêu thụ vô hạn."
  },
  State_3884_Name = {
    Text = "Dây rốn chuyển động không ngừng của sáng tạo"
  },
  State_3884_WeaponDesc = {
    Text = "Mỗi lượt tạo ra thêm 1 độ phôi hợp tử. Tất cả hiệu ứng tiêu thụ của bạn đều trở thành tiêu thụ vô hạn."
  },
  State_3888_Desc = {
    Text = "Không thể kích hoạt cơn thịnh nộ bùng phát, loại bỏ 1 lớp vào cuối lượt."
  },
  State_3888_Name = {
    Text = "<CardKeyWord:phong ấn>"
  },
  State_3888_WeaponDesc = {
    Text = "Tất cả cơn điên cuồng của thân thể được đánh thức không thể sử dụng."
  },
  State_3890_Name = {
    Text = "Rút ra số lá bài bỏ + [DescArg1] lá bài"
  },
  State_3893_Desc = {
    Text = "Khi gây thương, nhận được [Arg1] điểm lá chắn. Khi phục hồi sức sống, nhận được [Arg2] điểm lực lượng tạm thời."
  },
  State_3893_Name = {
    Text = "Nhà của chúng tôi"
  },
  State_3894_Desc = {
    Text = "Trước khi vào giai đoạn bỏ bài, biến các lá bài trong tay thành đá"
  },
  State_3894_Name = {Text = "Hóa đá"},
  State_3894_WeaponDesc = {
    Text = "Trước khi vào giai đoạn bỏ bài, biến các lá bài trong tay thành đá"
  },
  State_3895_Desc = {
    Text = "Trong vòng này tỷ lệ chí mạng tăng [Layer] %."
  },
  State_3895_Name = {
    Text = "Tỷ lệ chí mạng tạm thời"
  },
  State_3895_WeaponDesc = {
    Text = "Trong vòng này tỷ lệ chí mạng tăng [Layer] %."
  },
  State_3898_Desc = {
    Text = "Được [Layer] điểm lá chắn vào đầu lượt tiếp theo."
  },
  State_3898_Name = {
    Text = "Lá chắn đau khổ và hạnh phúc"
  },
  State_3900_Name = {
    Text = "Thẻ bài bị phong ấn, không thể đánh ra, khi bỏ bài thì giải trừ"
  },
  State_3901_Name = {
    Text = "Bộ đếm quyền trượng của linh mục sáng tạo"
  },
  State_3902_Desc = {
    Text = "Sát thương chủ động gây ra trong lượt này giảm [Layer] điểm."
  },
  State_3902_Name = {
    Text = "sức mạnh giảm xuống"
  },
  State_3902_WeaponDesc = {
    Text = "Thương gây ra trong lượt này giảm [Layer] điểm."
  },
  State_3904_Desc = {
    Text = "Mỗi khi mất 1 điểm sức sống, loại bỏ 1 lớp, khi số lớp là 0, nhận được [StateArg1] lá chắn và tái tạo [StateArg2] lớp rào cản máu."
  },
  State_3904_Name = {
    Text = "Thức Tỉnh - Rào Cản Máu"
  },
  State_3905_Desc = {
    Text = "Mỗi lần chịu Sát thương chủ động, gây [Layer] điểm <FixedDamage:Sát Thương Thuần Túy> lên nguồn gây sát thương."
  },
  State_3905_Name = {
    Text = "phản công"
  },
  State_3905_WeaponDesc = {
    Text = "Mỗi lần chịu Sát thương chủ động, gây [Layer] điểm <FixedDamage:Sát Thương Thuần Túy> lên kẻ tấn công."
  },
  State_3906_Name = {
    Text = "Bạc tâm còn lại"
  },
  State_3907_Name = {
    Text = "Bạc tâm còn lại"
  },
  State_3908_Desc = {
    Text = "Khi não trong bình áp dụng hiệu ứng hồi phục, rút [Arg2] lá bài."
  },
  State_3908_Name = {
    Text = "Hai mặt thực tế và ảo ảnh"
  },
  State_3908_WeaponDesc = {
    Text = "Khi não trong bình áp dụng hiệu ứng hồi phục, rút [Arg2] lá bài."
  },
  State_3909_Name = {
    Text = "Bạc tâm còn lại"
  },
  State_3910_Name = {
    Text = "Bạc tâm còn lại"
  },
  State_3911_Name = {
    Text = "Bạc tâm còn lại"
  },
  State_3912_Name = {
    Text = "Bạc tâm còn lại"
  },
  State_3913_Desc = {
    Text = "Đội duy nhất: Khiên do người trang bị gây ra tăng <WeaponEffect_Num:[StateArg1]%>. Vào đầu lượt, giữ lại <WeaponEffect_Num:[StateArg2]%> lá chắn còn lại, lá chắn giữ lại tối đa đạt <WeaponEffect_Num:[StateArg3]%> sinh lực tối đa."
  },
  State_3913_WeaponDesc = {
    Text = "Trang bị tăng cường lá chắn gây ra <WeaponEffect_Num:[StateArg1]%>. Bắt đầu lượt, giữ lại <WeaponEffect_Num:[StateArg2]%> lá chắn còn lại, lá chắn giữ lại tối đa đạt <WeaponEffect_Num:[StateArg3]%> máu tối đa."
  },
  State_3914_Desc = {
    Text = "Mỗi lượt, sau khi bùng nổ điên cuồng lần thứ 2, tất cả thể thức tỉnh nhận được 10 điểm điên cuồng. Mỗi lượt, sau khi bùng nổ điên cuồng lần thứ 3, tất cả thể thức tỉnh sẽ được làm mới thời gian hồi chiêu điên cuồng và nhận thêm 10 điểm điên cuồng."
  },
  State_3915_Name = {
    Text = "Bạc tâm còn lại"
  },
  State_3916_Name = {
    Text = "Bạc tâm còn lại"
  },
  State_3917_Desc = {
    Text = "Tăng lực lượng tạm thời vào lượt tiếp theo"
  },
  State_3917_Name = {Text = "Súc tích"},
  State_3918_Desc = {
    Text = "Vào đầu mỗi lượt, nhận trạng thái nhân đôi sát thương khi nhận đòn đầu tiên"
  },
  State_3918_Name = {Text = "Tự hào"},
  State_3918_WeaponDesc = {
    Text = "Vào đầu mỗi lượt, nhận trạng thái nhân đôi sát thương khi nhận đòn đầu tiên"
  },
  State_3921_Desc = {
    Text = "Trong vòng này, thẻ bài sẽ không được đưa vào rác bài trong giai đoạn bỏ bài, mà vẫn giữ lại trong tay bài."
  },
  State_3921_Name = {
    Text = "<RetainIconKeywords:giữ lại>"
  },
  State_3921_WeaponDesc = {
    Text = "Thẻ bài sẽ không được đưa vào rác bài trong giai đoạn bỏ bài, mà sẽ được giữ lại trong tay bài."
  },
  State_3923_Desc = {
    Text = "Sức mạnh tính toán của thẻ bài giảm"
  },
  State_3923_Name = {
    Text = "Giảm vĩnh viễn sức tính toán của thẻ bài"
  },
  State_3923_WeaponDesc = {
    Text = "Sức mạnh tính toán của thẻ bài giảm"
  },
  State_3925_Name = {
    Text = "Trạng thái@Chương 4 cảm ứng@khi bắt đầu vòng của đội ta có 2 điểm sức tính toán"
  },
  State_3926_Desc = {
    Text = "\"Lễ hội xác chết biến dạng\" tăng [Layer] điểm thương."
  },
  State_3926_Name = {
    Text = "Sự biến dạng"
  },
  State_3926_WeaponDesc = {
    Text = "Tăng \"cuồng bạo\" thương."
  },
  State_3927_Desc = {
    Text = "Sau khi rút được \"trống rỗng\", trong lượt này, làm giảm [Layer]% điên cuồng mà tất cả các thức tỉnh thể nhận được."
  },
  State_3927_Name = {Text = "Hư vô"},
  State_3927_WeaponDesc = {
    Text = "Sau khi rút được \"trống rỗng\", trong lượt này, làm giảm [Layer]% điên cuồng mà tất cả các thức tỉnh thể nhận được."
  },
  State_3928_Desc = {
    Text = "Khi Quỷ ác ngọt ngào gây sát thương, nhận được [StateArg2] phản công."
  },
  State_3928_Name = {
    Text = "Cho và nhận"
  },
  State_3929_Desc = {
    Text = "Lực lượng và lá chắn bị giảm 50%, cuối lượt, loại bỏ 1 lớp."
  },
  State_3929_Name = {
    Text = "<CardKeyWord:nguyền rủa>"
  },
  State_3929_WeaponDesc = {
    Text = "Không bị ảnh hưởng bởi các hiệu ứng tích cực được áp dụng lên bản thân trong lượt này"
  },
  State_3930_Name = {
    Text = "Trạng thái@Chương 4 cảm ứng@Vòng bắt đầu của đội ta tăng 1 điểm sức tính toán"
  },
  State_3931_Name = {
    Text = "Trạng thái @Bài Ca của Máu Đỏ và Cát"
  },
  State_3932_Desc = {
    Text = "Khiến thẻ bài được giữ lại, mỗi lớp nguyền rủa ngưng trệ làm tăng chi phí thẻ bài 1 điểm, sau khi đánh ra sẽ loại bỏ nguyền rủa này."
  },
  State_3932_Name = {
    Text = "Lời nguyền ngưng đọng ([Layer])"
  },
  State_3932_WeaponDesc = {
    Text = "Khiến thẻ bài được giữ lại, mỗi lớp nguyền rủa ngưng trệ làm tăng chi phí thẻ bài 1 điểm, sau khi đánh ra sẽ loại bỏ nguyền rủa này."
  },
  State_3933_Desc = {
    Text = "Tăng [Layer] điểm phòng thủ."
  },
  State_3933_Name = {
    Text = "Khả năng phòng thủ tăng tạm thời"
  },
  State_3933_WeaponDesc = {
    Text = "Tăng [Layer] điểm phòng thủ."
  },
  State_3934_Desc = {
    Text = "Tất cả lá chắn nhận được giảm 50 %."
  },
  State_3934_Name = {
    Text = "Sự yếu ớt của sự tuyệt chủng"
  },
  State_3934_WeaponDesc = {
    Text = "Tất cả lá chắn nhận được giảm 50 %."
  },
  State_3935_Desc = {
    Text = "Mỗi khi đội của tôi sử dụng một lá bài, nhận được một lớp \"quan sát\", khi đạt đến mười lớp thì bản thân bị choáng."
  },
  State_3935_Name = {Text = "quan sát"},
  State_3936_Desc = {
    Text = "Người trang bị gây sát thương, tạo lá chắn và tăng hiệu ứng chữa trị [StateArg1]%. (tạm thời)"
  },
  State_3936_Name = {
    Text = "Trạng thái @ Kiếm dài thử nghiệm giới vực"
  },
  State_3937_Desc = {
    Text = "Khi Nữ hoàng gai gây ra phản công, cô ấy sẽ nhận được lá chắn bằng một nửa lượng phản công."
  },
  State_3937_Name = {
    Text = "Tường thây ma"
  },
  State_3938_Name = {
    Text = "Tạo tượng sáp"
  },
  State_3941_Desc = {
    Text = "Khi tiêu thụ phôi thai, nó sẽ quay lại từ rác bài vào bài tay"
  },
  State_3941_Name = {
    Text = "Luồng xoáy nhợt nhạt"
  },
  State_3941_WeaponDesc = {
    Text = "Khi tiêu thụ phôi thai, nó sẽ quay lại từ rác bài vào bài tay"
  },
  State_3942_Name = {
    Text = "Trang sức dòng hải quy"
  },
  State_3942_WeaponDesc = {
    Text = "Sau khi trận chiến bắt đầu, nếu nghề nghiệp của người trang bị là biển sâu, sức tấn công tăng 25%."
  },
  State_3943_Desc = {
    Text = "Thân thể được đánh thức này chưa thức tỉnh… Khi sắp ngã gục sẽ thức tỉnh, hồi phục sức sống và bắt đầu chiến đấu với hình thái thật sự."
  },
  State_3943_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_3944_Desc = {
    Text = "Sau khi lượt kết thúc, tất cả thân thể được đánh thức nhận được 5 điên cuồng. Với mỗi điểm sức tính toán còn lại, tất cả thân thể được đánh thức nhận thêm 3 điên cuồng."
  },
  State_3945_Desc = {
    Text = "Tất cả giá của các sáng tạo giảm 50%."
  },
  State_39547_Desc = {
    Text = "Sau khi trận chiến kết thúc, nhận thêm 5 dấu đen, hiệu ứng này được tăng cường bởi tỉ lệ rơi dấu đen. Sau khi Vanda chơi thẻ bài, nhận 1 tầng Dẫn mộng, hiệu ứng này mỗi lượt tối đa có thể kích hoạt 2 lần. Hiện tại còn lại [DescArg1] lần."
  },
  State_39547_Name = {
    Text = "da bông và Venus"
  },
  State_40483_Name = {
    Text = "Lance Tenggelam yang Pecah"
  },
  State_40484_Desc = {
    Text = "Khi kỹ năng của Vanda kích hoạt hiệu ứng nhảy vọt, nếu tồn tại 5 lớp, sẽ tiêu thụ 5 lớp và nhận được hiệu ứng bổ sung. Giới hạn tối đa của Mộng Dẫn là 10 lớp, sẽ được kế thừa sang trận chiến tiếp theo."
  },
  State_40484_Name = {
    Text = "<PurpleKeyWord:Dẫn Mộng>"
  },
  State_41337_Desc = {
    Text = "Kết thúc lượt, hồi phục [Layer] điểm sức sống."
  },
  State_41337_Name = {
    Text = "Chiến thắng của hoa hồng-Phục hồi"
  },
  State_41340_Desc = {
    Text = "Đội duy nhất: Trang bị gây tăng lá chắn và phản công <WeaponEffect_Num:[StateArg1]%>. Mỗi khi bị tấn công, có <WeaponEffect_Num:[StateArg2]%> xác suất khiến tất cả thể thức tỉnh nhận thêm 1 điểm điên cuồng."
  },
  State_41340_WeaponDesc = {
    Text = "Trang bị tăng cường lá chắn và phản công <WeaponEffect_Num:[StateArg1]%>. Mỗi khi bị tấn công, có <WeaponEffect_Num:[StateArg2]%> khả năng khiến tất cả thân thể được đánh thức nhận được 1 điểm điên cuồng."
  },
  State_41342_Name = {
    Text = "Hiệu ứng biến đổi__\"Chỉ dùng cho phát triển\""
  },
  State_41344_Name = {
    Text = "Hiệu ứng biến đổi"
  },
  State_41360_Desc = {
    Text = "Tiêu thụ 5 tầng <DreamGuide:mộng dẫn>, Vanda nhận được <Energy:[StateArg1]> điểm điên cuồng và nhận được <RetaliateIconKeywords:phản công> tạm thời, tương đương với [StateArg2]% <RetaliateIconKeywords:phản công> vĩnh viễn."
  },
  State_41360_Name = {
    Text = "Phản công trong giấc ngủ sâu"
  },
  State_41361_Desc = {
    Text = "Tiêu thụ 10 lớp <DreamGuide:Dẫn mộng>, khiến tất cả kẻ thù vào Trạng thái \"Delirium\" 1 lượt: Sát thương chủ động gây ra giảm [StateArg3]%, số lần tấn công tăng gấp đôi."
  },
  State_41361_Name = {
    Text = "Tiếng thì thầm vang lại"
  },
  State_43818_Desc = {
    Text = "Thân thể được đánh thức này chưa thức tỉnh… Khi sắp ngã gục sẽ thức tỉnh, hồi phục sức sống và bắt đầu chiến đấu với hình thái thật sự."
  },
  State_43818_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_44398_Desc = {
    Text = "Mỗi lượt, sau khi đánh thẻ bài lần đầu tiên, đặt một thẻ \"phòng thủ\" tương ứng với thân thể được đánh thức vào tay."
  },
  State_44484_Name = {
    Text = "Có thể sử dụng 3 lần trong các trận đấu với Trưởng nhóm"
  },
  State_44485_Name = {
    Text = "(còn lại:[Layer])"
  },
  State_44491_Name = {
    Text = "Vô hiệu hóa hiệu ứng__\"Chỉ dùng cho phát triển\""
  },
  State_44562_Name = {
    Text = "Vô hiệu hóa hiệu ứng"
  },
  State_44575_Desc = {
    Text = "Lá chắn còn lại trong lượt này sẽ không bị loại bỏ và sẽ được giữ lại cho lượt tiếp theo."
  },
  State_44575_Name = {
    Text = "Lá chắn được giữ nguyên"
  },
  State_44653_Desc = {
    Text = "Mỗi đầu vòng, tất cả các thân thể được đánh thức nhận được 20 cuồng nộ. Khi nhặt, làm giảm một nửa lượng máu tối đa."
  },
  State_44665_Desc = {
    Text = "Bản vòng này \"đánh\" tỷ lệ chí mạng tăng [Layer] %."
  },
  State_44665_Name = {
    Text = "Tỷ lệ chí mạng đánh"
  },
  State_44667_Desc = {
    Text = "\"Đánh\" nhận được [DescArg1] điểm sức tính toán. Nếu tư thế hiện tại là\"Nộ Đào\", thay vì nhận thêm sức tính toán, 1 râu chạm sẽ tấn công [DescArg2] lần."
  },
  State_44667_Name = {
    Text = "Sự bá đạo của người khổng lồ"
  },
  State_44671_Desc = {
    Text = "Mỗi đầu lượt, tất cả các thân thể được đánh thức nhận được 25 điên cuồng. Khi nhặt lên, máu tối đa tăng lên 3 lần."
  },
  State_44672_Name = {
    Text = "Được phù hộ·ý thức bầy đàn"
  },
  State_44711_Desc = {
    Text = "Giới hạn sáng tạo +5, [Dấu vết tan chảy] số lần làm mới +1. Sau khi chiến đấu kết thúc, nhận được 125 dấu đen, khi nhặt có thể chọn xóa tối đa 6 thẻ triệu chứng."
  },
  State_44713_Desc = {
    Text = "Sau khi chiến đấu kết thúc, nhận thêm 100 dấu đen và 2 thẻ triệu chứng."
  },
  State_44730_Desc = {
    Text = "Vào đầu lượt, tích lũy <Heal:[Heal:StateArg1]> điểm hồi lượng lò đỏ."
  },
  State_44730_Name = {
    Text = "cứu chuộc"
  },
  State_44731_Desc = {
    Text = "Lấy khổ tiêu khổ. Tiêu hao toàn bộ lượng hồi phục còn lại của Lò Luyện Đỏ Thẫm, mỗi 1 điểm tiêu hao sẽ tăng sát thương thêm 3 điểm, nếu là trận đấu với thủ lĩnh thì mỗi 1 điểm tiêu hao sẽ tăng sát thương thêm 9 điểm. Mỗi 1% sinh mệnh tối đa của Lò Luyện Đỏ Thẫm tiêu hao sẽ tăng [DescArg1]% sát thương cuối cùng."
  },
  State_44731_Name = {
    Text = "Siêu độ"
  },
  State_44732_Desc = {
    Text = "Dùng máu để cứu chữa. Sau khi gây thương, mất 10% sức sống hiện tại, tích lũy lượng hồi phục của lò luyện kim màu đỏ thẫm tương đương với lượng sức sống đã mất."
  },
  State_44732_Name = {
    Text = "hiến dâng"
  },
  State_44739_Desc = {
    Text = "Khi nhặt, mất vĩnh viễn [Arg1] lực lượng. Mỗi khi gây sát thương, hồi [Arg2] điểm sức sống, tối đa 6 lần mỗi lượt."
  },
  State_44739_Name = {
    Text = "Tội lỗi·Nụ hôn cá mút đá"
  },
  State_44740_Name = {
    Text = "Chúc Phúc·Nụ Hôn của Bảy Mang"
  },
  State_44741_Desc = {
    Text = "Khi nhặt, mất vĩnh viễn [Arg1] lực lượng. Mỗi khi gây sát thương, hồi [Arg2] điểm sức sống, tối đa 6 lần mỗi lượt."
  },
  State_44741_Name = {
    Text = "Tội lỗi·Nụ hôn cá mút đá"
  },
  State_44742_Desc = {
    Text = "Khi nhặt, mất vĩnh viễn [Arg1] lực lượng. Mỗi khi gây sát thương, hồi [Arg2] điểm sức sống, tối đa 6 lần mỗi lượt."
  },
  State_44742_Name = {
    Text = "Chúc Phúc·Nụ Hôn của Bảy Mang"
  },
  State_44743_WeaponDesc = {
    Text = "Khi trận chiến bắt đầu, áp dụng yếu đuối lên bản thân trong 3 lượt."
  },
  State_44744_WeaponDesc = {
    Text = "Khi trận chiến bắt đầu, áp dụng yếu đuối lên bản thân trong 3 lượt."
  },
  State_44750_Desc = {
    Text = "Khi bắt đầu lượt, nhận được [StateArg1] sức tính toán."
  },
  State_44750_Name = {
    Text = "Sáng tạo nến đen 1"
  },
  State_44751_Desc = {
    Text = "Khi bắt đầu lượt, nhận được [StateArg1] sức tính toán."
  },
  State_44751_Name = {
    Text = "Sáng tạo nến đen 1"
  },
  State_44752_Desc = {
    Text = "Mỗi khi \"Sophia\" mất 1 điểm sức sống sẽ giảm 1 tầng, khi số tầng về 0, sẽ thay thế ý định bằng \"trả đũa\" và nhận được [StateArg2] lá chắn. Lần đầu tiên kích hoạt sẽ khôi phục tất cả các tầng."
  },
  State_44752_Name = {
    Text = "Sức mạnh chôn vùi"
  },
  State_44762_Desc = {
    Text = "Khi đánh \"phòng thủ\", đưa 1 lá vết thương vào rút bài từ bộ bài."
  },
  State_44762_Name = {Text = "Xé toạc"},
  State_44763_Desc = {
    Text = "Tất cả sát thương chí mạng của thân thể được đánh thức giảm một nửa."
  },
  State_44763_Name = {
    Text = "<PurpleKeyWord: Mù>"
  },
  State_44764_Desc = {
    Text = "Khi đánh \"đánh kích\", đưa 1 lá vết thương vào rút bài từ bộ bài."
  },
  State_44764_Name = {
    Text = "Thương tổn"
  },
  State_44807_Desc = {
    Text = "Khi lần đầu tiên sắp bị đánh bại, hồi phục sức sống và chuyển đổi ý định thành \"Phán Quyết trong Gương\", tăng cường bản thân. Khi lần thứ hai sắp bị đánh bại, hồi phục sức sống và chuyển đổi ý định thành \"Cắn Xé Điên Cuồng\", gây thương tích cực lớn trong một lần."
  },
  State_44807_Name = {
    Text = "Thảm Sát Bị Chôn Vùi"
  },
  State_44819_Desc = {
    Text = "Nếu không có <ParcloseIconKeywords:rào cản>, thì nhận được 1 lớp <ParcloseIconKeywords:rào cản> tạm thời, ngược lại nhận được 10% tỷ lệ chí mạng và thương chí mạng."
  },
  State_44819_Name = {
    Text = "<CardKeyWord:cha thần bảo hộ>"
  },
  State_44828_Desc = {
    Text = "Đội duy nhất: Khi kết thúc lượt, Người trang bị nhận được [StateArg1] điểm điên cuồng. Khi chịu Sát thương chủ động và thương tổn xúc tu, khi bắt đầu lượt tiếp theo nhận được lá chắn bằng <WeaponEffect_Num:[StateArg2]%> sát thương. Nếu Cõi hiện tại là Huyết Nhục, không còn nhận Lá chắn trễ nữa, mà thay vào đó tích lũy lượng hồi phục bằng <WeaponEffect_Num:[StateArg2]%> sát thương vào Lò nung đỏ thẫm."
  },
  State_44828_WeaponDesc = {
    Text = "Khi kết thúc lượt, Người trang bị nhận <WeaponEffect_Num:[StateArg1]> điểm điên cuồng. Khi chịu Sát thương chủ động hoặc thương tổn xúc tu, đầu lượt tiếp theo nhận lá chắn bằng <WeaponEffect_Num:[Float:StateArg2]%> sát thương nhận vào. Nếu Cõi hiện tại là Huyết Nhục, không còn nhận Lá chắn trễ nữa, mà thay vào đó tích lũy lượng hồi phục bằng <WeaponEffect_Num:[Float:StateArg2]%> sát thương nhận vào vào Lò nung đỏ thẫm."
  },
  State_44889_Name = {
    Text = "Trạng thái@Boss Người Mặt Chó@Gương Kết Thúc"
  },
  State_44890_Name = {
    Text = "Trạng thái@Boss Quỷ Sói Mặt Người@Gương Tận Thế 2"
  },
  State_44891_Name = {
    Text = "Trạng thái@chó mặt người BOSS@gương tận cùng 3"
  },
  State_44903_Desc = {
    Text = "Sau khi chịu Sát thương chủ động hoặc thương tổn xúc tu, sẽ chuyển hóa [StateArg1]% sát thương thành lượng hồi phục cho Lò nung đỏ thẫm, kéo dài [Layer] lượt."
  },
  State_44903_Name = {
    Text = "lời chúc phúc của Chủ tạo"
  },
  State_44909_Name = {
    Text = "Tiêu hao được"
  },
  State_45018_Desc = {
    Text = "Trước khi kết thúc lượt, không thể sử dụng \"đánh\"."
  },
  State_45018_Name = {
    Text = "chích điện"
  },
  State_45025_Desc = {
    Text = "Cụ thể hiệu ứng xem logic tấn công chung.__\"Chỉ dùng cho phát triển\""
  },
  State_45029_Desc = {
    Text = "Cụ thể hiệu ứng xem logic tấn công chung.__\"Chỉ dùng cho phát triển\""
  },
  State_45032_Desc = {
    Text = "Vào cuối lượt tiếp theo, chịu [Layer] sát thương."
  },
  State_45032_Name = {
    Text = "Chảy máu"
  },
  State_45039_Desc = {
    Text = "Cho đến khi lượt tiếp theo bắt đầu, mỗi khi chịu Sát thương chủ động hoặc thương tổn xúc tu, khi lượt tiếp theo bắt đầu sẽ nhận được lá chắn bằng [Layer]% sát thương."
  },
  State_45039_Name = {
    Text = "Dấu hiệu thần thánh xuất hiện"
  },
  State_45040_Desc = {
    Text = "Cho đến khi lượt tiếp theo bắt đầu, mỗi khi chịu Sát thương chủ động hoặc thương tổn xúc tu, tích lũy lượng Trả lời bằng [Layer]% sát thương vào Lò nung đỏ thẫm."
  },
  State_45040_Name = {
    Text = "Dấu hiệu thần thánh xuất hiện"
  },
  State_45049_Desc = {
    Text = "Bù trừ lượng Sinh lực bị mất do đòn tấn công chủ động tiếp theo gây ra, có thể chồng tối đa 3 lớp, mỗi lớp Trận đấu tử thần sẽ làm số lớp có thể chồng của rào cản -1, rào cản đã nhận được sẽ không giảm do số lớp có thể chồng giảm."
  },
  State_45049_Name = {Text = "rào cản"},
  State_45050_Desc = {
    Text = "Bù trừ lượng Sinh lực bị mất do đòn tấn công chủ động tiếp theo gây ra, có thể chồng tối đa 3 lớp, mỗi lớp Trận đấu tử thần sẽ làm số lớp có thể chồng của rào cản -1, rào cản đã nhận được sẽ không giảm do số lớp có thể chồng giảm."
  },
  State_45050_Name = {
    Text = "<ReinforceColour:rào cản>"
  },
  State_45064_Name = {
    Text = "Bảng đếm của yến tiệc lặng yên__\"chỉ dùng cho phát triển\""
  },
  State_45069_Desc = {
    Text = "Cụ thể hiệu ứng xem logic tấn công chung.__\"Chỉ dùng cho phát triển\""
  },
  State_45072_Name = {
    Text = "Số lần thánh hóa"
  },
  State_45073_Desc = {
    Text = "Sức mạnh tính toán của thẻ bài giảm"
  },
  State_45076_Desc = {
    Text = "Khi áp dụng, xóa bỏ lá chắn và chữa trị hoãn trên mục tiêu. Trước khi hết lượt, hiệu ứng chữa trị và lá chắn giảm 50%."
  },
  State_45076_Name = {
    Text = "Thiệt hại nặng"
  },
  State_45137_Desc = {
    Text = "Sau khi sử dụng cơn thịnh nộ bùng phát, phong ấn tất cả thân thể được đánh thức trong một lượt và nhận một lượt tăng sát thương."
  },
  State_45137_Name = {
    Text = "Tội tổ tông · Xương hành đạo"
  },
  State_45139_Desc = {
    Text = "Sau khi sử dụng điên cuồng bùng phát, ngẫu nhiên loại bỏ 1 trạng thái tiêu cực."
  },
  State_45139_Name = {
    Text = "Thân thể được chúc phúc·Hành đạo"
  },
  State_45148_Desc = {
    Text = "Tất cả sát thương chí mạng của thân thể được đánh thức giảm một nửa."
  },
  State_45148_Name = {
    Text = "<PurpleKeyWord: Mù>"
  },
  State_45166_Desc = {
    Text = "Vòng mệnh trang bị trước khi kết thúc lượt sẽ không còn hiệu lực."
  },
  State_45166_Name = {
    Text = "Vướng víu"
  },
  State_45206_Desc = {
    Text = "Dùng tín để cứu thế. Tiêu thụ toàn bộ lượng hồi phục còn lại của Lò nung đỏ thẫm, nhận được lá chắn tương đương 150% lượng tiêu thụ, lá chắn này không bị ảnh hưởng bởi các hiệu ứng tăng cường và giảm bớt lá chắn, nhưng không tính đến giới hạn lá chắn."
  },
  State_45206_Name = {
    Text = "Cứu chuộc"
  },
  State_45248_Name = {
    Text = "Bảng đếm__\"chỉ dùng cho phát triển\""
  },
  State_45328_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>: Sau \"Bùng nổ cuồng khí\" khiến bản thân nhận được <TauntKeywords:Chế nhạo> và <Block:[Block:StateArg1]> lá chắn."
  },
  State_45328_Name = {
    Text = "Ma thuật 35mm"
  },
  State_45329_Desc = {
    Text = "<PVPWeaponKeywords:Bánh xe định mệnh>: “Đánh” có thể chọn mục tiêu, trước khi “Đánh”, <PVPRepelKeywords:Đẩy lùi> tất cả trạng thái tích cực có thể giải tán của mục tiêu về phía sau người đánh thức của nó."
  },
  State_45329_Name = {
    Text = "Gọi của Biển Sâu"
  },
  State_45331_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>: Khi trang bị và sau khi \"đánh\", các \"kỹ năng\" không phái sinh của người trang bị trong tay sẽ lần lượt biến thành các \"kỹ năng\" khác của người trang bị [ShowIfState:, <CardKeyWord:<SkillName3:>>→<CardKeyWord:<SkillName2:>>→<CardKeyWord:<SkillName1:>>→<CardKeyWord:<SkillName3:>>]."
  },
  State_45331_Name = {
    Text = "Hoa và Thơ của Quá Khứ"
  },
  State_45332_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>: Mỗi lần chịu thương chủ động sẽ giúp các đồng minh khác nhận được <Energy:[Energy:StateArg1]> điên nộ."
  },
  State_45332_Name = {
    Text = "Ánh mắt của Isarau"
  },
  State_45333_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>:giới hạn tay tối đa +[StateArg1],\"Bùng nổ\" khiến bản thân nhận được <Energy:[Energy:StateArg2]> điên cuồng."
  },
  State_45333_Name = {
    Text = "Nụ hôn chia ly nóng bỏng"
  },
  State_45334_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>:\"kỹ năng\" làm cho lần \"đánh\" tiếp theo trong lượt này trở thành mục tiêu ngẫu nhiên và tấn công thêm [StateArg1] mục tiêu ngẫu nhiên."
  },
  State_45334_Name = {
    Text = "người trong gương"
  },
  State_45345_Desc = {
    Text = "Dùng để ghi lại số lần sử dụng kỹ năng sinh trưởng giai đoạn 1"
  },
  State_45345_Name = {
    Text = "Dấu hiệu sinh sản 1"
  },
  State_45346_Desc = {
    Text = "Ghi lại số lần đã sử dụng kỹ năng sinh sản giai đoạn 2"
  },
  State_45346_Name = {
    Text = "Dấu hiệu Sinh Sản 2"
  },
  State_45354_Desc = {
    Text = "Thẻ bài này không thể được chơi ra.__\"chỉ dùng cho phát triển\""
  },
  State_45354_Name = {
    Text = "Không thể đánh ra__\"chỉ dùng cho phát triển\""
  },
  State_45356_Desc = {
    Text = "Khi kết thúc lượt, biến thành lá bài \"kỹ năng\" cuối cùng bạn đã đánh ra, giảm 2 điểm tiêu thụ sức tính toán của nó. Sau khi đánh, \"Dung Nhan Tro Tối\" sẽ được trộn vào bộ bài."
  },
  State_45356_Name = {
    Text = "<CardKeyWord:Sương mù xám>"
  },
  State_45364_Desc = {
    Text = "Vào đầu lượt tiếp theo, thân thể được đánh thức này sẽ nhận được [Layer] lá \"đánh\"."
  },
  State_45364_Name = {
    Text = "Áp dụng sát thương sau khi trễ"
  },
  State_45385_Desc = {
    Text = "Tất cả sát thương gây ra trong trận chiến này giảm [Layer] điểm, không thể xóa bỏ, bao gồm [DescArg1] lớp giảm sức mạnh tạm thời, sẽ được loại bỏ sau khi kết thúc lượt."
  },
  State_45385_Name = {
    Text = "sức mạnh giảm xuống"
  },
  State_45387_Desc = {
    Text = "Tất cả sát thương gây ra trong trận chiến này tăng [Layer] điểm, không thể xóa bỏ, trong đó có [DescArg1] lớp sức mạnh tạm thời, sẽ bị loại bỏ sau khi lượt kết thúc."
  },
  State_45387_Name = {
    Text = "lực lượng"
  },
  State_45397_Desc = {
    Text = "Khi bắt đầu lượt, chuyển 1 lớp rào cản thành lực lượng."
  },
  State_45397_Name = {
    Text = "Chiến thắng của hoa hồng"
  },
  State_45403_Desc = {
    Text = "Vào đầu lượt tiếp theo, nhận được [Layer] lớp tích lực."
  },
  State_45403_Name = {
    Text = "Tích lũy chậm"
  },
  State_45407_Desc = {
    Text = "Giảm 50% điên cuồng thu được và loại bỏ ngay lập tức toàn bộ điên cuồng bị trì hoãn."
  },
  State_45407_Name = {Text = "Hư vô"},
  State_45656_Desc = {
    Text = "Cây mẹ phục sinh lần thứ ba, kích hoạt kỹ năng sinh sản 2"
  },
  State_45658_Desc = {
    Text = "Cây mẹ lần đầu tiên phục sinh, bắt đầu sử dụng kỹ năng sinh sản"
  },
  State_45661_Desc = {
    Text = "Khi sức sống giảm xuống 0, giữ sức sống ở mức 1 điểm, không còn nhận thương, chuẩn bị phát động \"Nhiều lần hợp nhất\"."
  },
  State_45661_Name = {
    Text = "Fusion multiple"
  },
  State_45715_Desc = {
    Text = "Nhận sức mạnh tạm thời tương đương với [StateArg1]% thương tổn râu chạm."
  },
  State_45715_Name = {
    Text = "chính biến"
  },
  State_45716_Desc = {
    Text = "Nhận lực lượng tạm thời tương đương với [StateArg1]% thương râu chạm. Goliath nhận được 25% tỷ lệ chí mạng tạm thời."
  },
  State_45716_Name = {
    Text = "chính biến"
  },
  State_45717_Desc = {
    Text = "Khiến \"Sức mạnh của Lưỡi đao khổng lồ\" và \"cắt đầu trọng thương\" có thương cơ bản tăng 25% trong trận chiến này. Goliath nhận được <Energy:[Energy:StateArg2]> điểm điên cuồng."
  },
  State_45717_Name = {Text = "ẩn náu"},
  State_45718_Desc = {
    Text = "Khiến \"Sức mạnh của Lưỡi đao khổng lồ\" và \"cắt đầu trọng thương\" có thương cơ bản tăng 25% trong trận chiến này."
  },
  State_45718_Name = {Text = "ẩn náu"},
  State_46057_Name = {
    Text = "Điểm tính toán"
  },
  State_46079_Desc = {
    Text = "Trong lượt này, mỗi khi mục tiêu chịu thương, hồi phục [Layer] sức sống cho đồng minh mất nhiều sức sống nhất."
  },
  State_46079_Name = {
    Text = "Máu Thánh chỉ dẫn"
  },
  State_46119_Desc = {
    Text = "Lần tới khi bị tấn công, gây hiệu ứng bị cuốn vào cho kẻ tấn công."
  },
  State_46119_Name = {
    Text = "Bẫy mê cung"
  },
  State_46124_Desc = {
    Text = "Không thể thực hiện bất kỳ hành động nào trước khi kết thúc lượt."
  },
  State_46124_Name = {Text = "Hóa đá"},
  State_46138_Desc = {
    Text = "Biến thành \"kỹ năng\" mà đối thủ đã đánh ra lần trước và giảm chi phí của nó đi 1."
  },
  State_46138_Name = {
    Text = "<CardKeyWord:tinh tú giả lập>"
  },
  State_46139_Desc = {
    Text = "Mỗi lần bị tấn công chủ động, bản thân nhận được [Layer] lớp Súc tích và gây [Layer] lớp Trì trệ cho kẻ tấn công."
  },
  State_46139_Name = {
    Text = "Trọng lực bất thường"
  },
  State_46155_Desc = {
    Text = "Sau khi dùng \"kỹ năng\", nhận [StateArg1] lớp chứa lực và giảm 1 lớp. Cuối lượt, tiêu thụ tất cả lớp, mỗi lớp hồi [StateArg2] sức sống."
  },
  State_46155_Name = {
    Text = "Máu dị thường"
  },
  State_46243_Name = {
    Text = "Bảng đếm sáng suốt__\"chỉ dùng cho phát triển\""
  },
  State_46255_Desc = {
    Text = "Cụ thể hiệu ứng xem logic tấn công chung.__\"Chỉ dùng cho phát triển\""
  },
  State_46256_Desc = {
    Text = "Cụ thể hiệu ứng xem logic tấn công chung.__\"Chỉ dùng cho phát triển\""
  },
  State_46322_Desc = {
    Text = "Vào đầu lượt, nhận 30 phôi hợp tử."
  },
  State_46322_Name = {
    Text = "Yu U Hahi Demo"
  },
  State_46323_Desc = {
    Text = "Sau khi bắt đầu lượt chơi siêu việt, nhận được 100 điểm điên cuồng và 7 điểm lực lượng."
  },
  State_46323_Name = {
    Text = "Liz thử chơi"
  },
  State_46324_Desc = {
    Text = "Mỗi lượt nhận được 1 lá \"cảm hứng\"."
  },
  State_46324_Name = {
    Text = "Jenkin thử chơi"
  },
  State_46329_Desc = {
    Text = "Sau khi chiến đấu bắt đầu, nhận được 600 điểm năng lượng chìa khóa bạc, lơ-tan nhận được 50 điểm điên cuồng, sau khi lơ-tan giải phóng cơn thịnh nộ bùng phát, nhận thêm 44 điểm điên cuồng."
  },
  State_46329_Name = {
    Text = "Bonus thử nghiệm"
  },
  State_46330_Desc = {
    Text = "Vào đầu lượt, nhận 30 phôi hợp tử, 10 điểm điên cuồng, [DescArg1] điểm lực lượng, và thêm 3 lá \"Đánh\" vào rút bài từ bộ bài."
  },
  State_46330_Name = {
    Text = "Thử nghiệm Hiro"
  },
  State_46333_Name = {
    Text = "Thử chơi Reia"
  },
  State_46334_Desc = {
    Text = "Sau khi bắt đầu vòng 4, nhận được 100 điểm cuồng nộ."
  },
  State_46334_Name = {
    Text = "Pháp Luân Tư Thử Chơi"
  },
  State_46336_Desc = {
    Text = "Vào đầu lượt, nhận 30 phôi hợp tử và 10 điểm điên cuồng."
  },
  State_46336_Name = {
    Text = "Agrippa Thử nghiệm"
  },
  State_46337_Desc = {
    Text = "Vào đầu lượt, nhận 10 điểm điên cuồng."
  },
  State_46337_Name = {
    Text = "Kẻ khắc sét Demo"
  },
  State_46338_Desc = {
    Text = "Vào đầu lượt, nhận 30 phôi hợp tử và 10 điểm điên cuồng."
  },
  State_46338_Name = {
    Text = "Phiệt Demo"
  },
  State_46427_Desc = {
    Text = "Cụ thể hiệu ứng xem logic tấn công chung.__\"Chỉ dùng cho phát triển\""
  },
  State_46428_Desc = {
    Text = "Cụ thể hiệu ứng xem logic tấn công chung.__\"Chỉ dùng cho phát triển\""
  },
  State_46429_Desc = {
    Text = "Cụ thể hiệu ứng xem logic tấn công chung.__\"Chỉ dùng cho phát triển\""
  },
  State_46441_Desc = {
    Text = "Miễn dịch với mọi sát thương không phải Xuyên thấu. Loại bỏ sau khi lượt bắt đầu."
  },
  State_46441_Name = {
    Text = "Miễn dịch với sát thương"
  },
  State_46442_Name = {
    Text = "Thẻ bài cấm thay đổi loại mục tiêu đánh__\"Chỉ dùng cho phát triển\""
  },
  State_46500_Desc = {
    Text = "Cụ thể hiệu ứng xem logic tấn công chung.__\"Chỉ dùng cho phát triển\""
  },
  State_46505_Desc = {
    Text = "Trong vòng này, mỗi khi nhận Sát thương chủ động, nhận được [Layer] Điên loạn."
  },
  State_46505_Name = {
    Text = "Chuyển đổi đau"
  },
  State_46508_Desc = {
    Text = "Khi bị mất ý thức sẽ nhận được khả năng kháng. Nếu bị mất ý thức lần nữa khi có kháng, hiệu ứng mất ý thức sẽ bị vô hiệu hóa và sát thương tăng gấp đôi. Trạng thái này không thể bị loại bỏ."
  },
  State_46508_Name = {
    Text = "Sức chống cự"
  },
  State_46511_Desc = {
    Text = "Thương của \"Superposisi của nghìn mặt\" của Thể thức tỉnh này tăng [Layer]."
  },
  State_46511_Name = {
    Text = "Superposisi của nghìn mặt"
  },
  State_46512_Desc = {
    Text = "Trước khi kết thúc lượt, thể thức tỉnh này sau khi đánh ra thẻ bài sẽ chịu [Layer] sát thương."
  },
  State_46512_Name = {
    Text = "Thẻ bài bị phong tỏa"
  },
  State_46513_Desc = {
    Text = "Tăng cường bài thơ tiếp theo, khiến nó nhận được hiệu ứng bổ sung, không thể bị giải tán."
  },
  State_46513_Name = {
    Text = "Mực tang thương"
  },
  State_46536_Desc = {
    Text = "Nếu trạng thái tham số 1 là 0 thì bốc thăm, nếu không thì chỉ hiện chữ nổi"
  },
  State_46536_Name = {Text = "Rút"},
  State_46538_Desc = {
    Text = "Khi bắt đầu khám phá, nhận được [StateArg1] điểm cuồng nộ."
  },
  State_46538_Name = {
    Text = "Điềm báo điên loạn"
  },
  State_47072_Desc = {
    Text = "Trong lượt này, tỷ lệ chí mạng của thẻ đánh tăng +[Layer]%."
  },
  State_47072_Name = {
    Text = "Tấn công chí mạng"
  },
  State_47089_Name = {
    Text = "Kiểm tra hiệu ứng__\"Chỉ dùng cho phát triển\""
  },
  State_47096_Desc = {
    Text = "Mỗi lần đánh ra 1 lá \"cảm hứng\" sẽ khiến Đào Đen Đá nhận được [StateArg1] điểm điên cuồng, nhận được [StateArg2] điểm lực lượng, mỗi lượt tối đa kích hoạt 5 lần.(Hiện còn [DescArg1] lần)"
  },
  State_47096_Name = {
    Text = "Đọng lại nguyên chất"
  },
  State_47189_Name = {
    Text = "Chuyển sang Nhân cách cuồng loạn. Huyết Nhục·U uất: <EmbryoFusionIconKeywords:Dung hợp Phôi thai> +[Blood:StateArg5], tích lũy [StateArg6] điểm lượng hồi phục Lò nung đỏ thẫm"
  },
  State_47192_Name = {
    Text = "Nhân cách u uất: Cũng sẽ khiến các thân thể được đánh thức khác nhận được [DescArg1] lần điên cuồng. Nhân cách cuồng loạn: Lượng điên cuồng nhận được tăng lên [DescArg2] lần"
  },
  State_47199_Name = {
    Text = "Chuyển sang nhân cách trầm cảm. Thịt máu·Cường độ: Sát thương nhận [DescArg1] lần <PowerIconKeywords:lực lượng> và gây 200% sát thương <BleedingIconKeywords:chảy máu> lên mục tiêu, nhận [StateArg7] điểm <PowerIconKeywords:lực lượng>"
  },
  State_47204_Name = {
    Text = "Chuyển sang tính cách cuồng loạn. Hỗn loạn · u uất: nhận được <Posse:[StateArg1]> điểm năng lượng chìa khóa bạc, lệnh khóa tiếp theo có hiệu lực 2 lần"
  },
  State_47206_Name = {
    Text = "Chuyển đổi thành nhân cách hưng cảm. Aequor·Trầm cảm: <WeaknessIconKeywords:Điểm yếu> và <VulnerabilityIconKeywords:Dễ tổn thương> mục tiêu 2 lượt, sinh ra 1 xúc tu, <TentacleInjurieIconKeywords:Thiệt hại xúc tu>+ [TentaclePower:StateArg3]"
  },
  State_47209_Name = {
    Text = "Chuyển sang Nhân cách u uất. Siêu Chiều·Hưng cảm: Nhận được <RetaliateIconKeywords:phản công> gây 15% sát thương, sau đó gây <FixedDamage:Sát Thương Thuần Túy> tương đương cho các kẻ thù khác. Mỗi lần chơi 1 thẻ \"Cảm hứng\" trong lượt này, tăng sát thương đó lên [StateArg9] điểm trong lượt này, tối đa tăng [StateArg10] điểm"
  },
  State_47211_Name = {
    Text = "Nhân cách u uất: Giảm 1 điểm tiêu thụ sức tính toán của [DescArg1] thẻ bài có sức tính toán cao nhất trong tay và nhận được tạm thời <RetainIconKeywords:giữ lại>. Nhân cách hưng phấn: Gây thêm [DescArg2] lần thương"
  },
  State_47212_Name = {
    Text = "Khiến \"24\" chuyển đổi giữa tính cách trầm cảm và hưng cảm, và dựa trên giới vực hiện tại cùng tính cách, kích hoạt hiệu ứng bổ sung"
  },
  State_47216_Name = {
    Text = "Chuyển sang nhân cách trầm cảm. Biển sâu · Cuồng loạn: Sát thương này được tăng thêm [StateArg4]% <TentacleInjurieIconKeywords:thương tổn râu chạm> và gây 30% thương từ <IntoxicationIconKeywords:trúng độc>"
  },
  State_47217_Name = {
    Text = "Chuyển sang nhân cách trầm cảm. Hỗn loạn·Hưng cảm: gây ra 3 đợt sát thương, tăng [StateArg2] điểm sát thương của \"24\""
  },
  State_47218_Name = {
    Text = "Chuyển sang tính cách cuồng loạn. Siêu việt · trầm cảm: Thêm 2 lá \"cảm hứng\" vào tay, làm cho mục tiêu tạm thời giảm [Power:StateArg8] điểm <PowerIconKeywords:lực lượng>"
  },
  State_47222_Name = {
    Text = "Nhân cách trầm cảm: Giảm 1 điểm tiêu thụ sức tính toán của [DescArg1] thẻ bài có sức tính toán cao nhất trong tay và nhận được tạm thời <RetainIconKeywords:giữ lại>. <AwakerCard_24Lost:Nhân cách cuồng loạn: gây thêm [DescArg2] lần thương.>"
  },
  State_47224_Name = {
    Text = "Nhân cách u uất: Cũng giúp các thân thể được đánh thức khác nhận [DescArg1] lần số điên cuồng.<AwakerCard_24Lost:Nhân cách cuồng uất: Lượng điên cuồng nhận được tăng lên [DescArg2] lần>"
  },
  State_47228_Name = {
    Text = "<AwakerCard_24Lost:Nhân cách u uất: Cũng sẽ làm cho các thân thể được đánh thức khác nhận được [DescArg1] lần điên cuồng.>Nhân cách cuồng uất: Lượng điên cuồng nhận được tăng gấp [DescArg2] lần"
  },
  State_47229_Name = {
    Text = "<AwakerCard_24Lost:Nhân cách trầm cảm: Giảm 1 điểm tiêu thụ sức tính toán của [DescArg1] thẻ bài có sức tính toán cao nhất trong tay, và được <RetainIconKeywords:giữ lại> tạm thời.> Nhân cách hưng phấn: Gây thêm [DescArg2] lần thương"
  },
  State_47451_Name = {
    Text = "Lắc Mật lệnh vô hiệu hóa hiệu ứng vòng mệnh__\"Chỉ dùng cho phát triển\""
  },
  State_47485_Name = {
    Text = "Nhân cách trầm cảm: Trong số các thẻ bài trên tay, chọn [DescArg1] thẻ có sức tính toán cao nhất. Giảm 2 điểm tiêu thụ sức tính toán của thẻ này và nhận được tạm thời <RetainIconKeywords:giữ lại>. Nhân cách hưng phấn: Gây ra thêm [DescArg2] đợt sát thương"
  },
  State_47486_Name = {
    Text = "Nhân cách trầm cảm: Giảm 2 điểm tiêu thụ sức tính toán của [DescArg1] thẻ bài có sức tính toán cao nhất trong tay và nhận được tạm thời <RetainIconKeywords:giữ lại>. <AwakerCard_24Lost:Nhân cách hưng cảm: gây thêm [DescArg2] lần thương>"
  },
  State_47488_Name = {
    Text = "Nhân cách u uất: Nhận thêm <Energy: [DescArg1]> điểm điên cuồng. Nhân cách hưng cảm: Nhận thêm [DescArg2] lần lá chắn"
  },
  State_47489_Name = {
    Text = "<AwakerCard_24Lost:Bản chất u uất: Giảm 2 điểm tiêu thụ sức tính toán của [DescArg1] thẻ bài có sức tính toán cao nhất trong tay và nhận được tạm <RetainIconKeywords:giữ>.>Bản chất hưng phấn: Gây thêm [DescArg2] lần thương"
  },
  State_47492_Name = {
    Text = "Nhân cách u uất: Nhận thêm <Energy: [DescArg1]> điểm điên cuồng. <AwakerCard_24Lost:Nhân cách cuồng loạn: gây thêm [DescArg2] lần sát thương>"
  },
  State_47493_Name = {
    Text = "Nhân cách trầm cảm: Nhận thêm <Energy: [DescArg1]> điểm điên cuồng. Nhân cách hưng cảm: Gây thêm [DescArg2] lần sát thương"
  },
  State_47494_Name = {
    Text = "Nhân cách u uất: cũng sẽ làm cho các thân thể được đánh thức khác nhận được [DescArg1] lần lượng điên cuồng, <WeaknessIconKeywords:Suy nhược> tất cả kẻ địch trong [DescArg3] lượt. Nhân cách cuồng loạn: lượng điên cuồng nhận được tăng gấp [DescArg2] lần, <VulnerabilityIconKeywords:Trọng thương> tất cả kẻ địch trong [DescArg3] lượt"
  },
  State_47495_Name = {
    Text = "Nhân cách u uất: Cũng sẽ khiến các thể thức tỉnh khác nhận được [DescArg1] lần lượng điên cuồng, <WeaknessIconKeywords:Suy nhược> tất cả kẻ địch trong [DescArg3] lượt. <AwakerCard_24Lost:Nhân cách cuồng loạn: Lượng điên cuồng nhận được tăng lên [DescArg2] lần, trọng thương tất cả kẻ địch trong [DescArg3] lượt>"
  },
  State_47496_Name = {
    Text = "<AwakerCard_24Lost:Nhân cách u uất: cũng sẽ làm cho các thân thể được đánh thức khác nhận được [DescArg1] lần lượng điên cuồng, làm suy nhược tất cả kẻ địch trong [DescArg3] lượt.>Nhân cách cuồng loạn: lượng điên cuồng nhận được tăng gấp [DescArg2] lần, <VulnerabilityIconKeywords:Trọng thương> tất cả kẻ địch trong [DescArg3] lượt"
  },
  State_47498_Name = {
    Text = "<AwakerCard_24Lost:Nhân cách u uất: nhận thêm [DescArg1] điểm điên cuồng.>Nhân cách cuồng loạn: tăng thêm [DescArg2] đòn tấn công gây thương tích"
  },
  State_47499_Name = {
    Text = "<AwakerCard_24Lost:Nhân cách u uất: nhận thêm [DescArg1] điểm điên cuồng.>Nhân cách hưng phấn: nhận thêm [DescArg2] lần lá chắn"
  },
  State_47500_Name = {
    Text = "Nhân cách u uất: Nhận thêm <Energy: [DescArg1] > điểm điên cuồng. <AwakerCard_24Lost:Nhân cách cuồng loạn: Nhận thêm [DescArg2] lần lá chắn>"
  },
  State_47517_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>: Cuối lượt, loại bỏ [StateArg1] thẻ bài từ các thân thể được đánh thức khác, nếu loại bỏ thành công thì rút [StateArg2] lá bài."
  },
  State_47517_Name = {
    Text = "Định mệnh của Bạc Khô"
  },
  State_47518_Name = {
    Text = "Bảng đếm của quyết tâm của Cá Tuyết Bạc__\"chỉ dùng cho phát triển\""
  },
  State_47528_Desc = {
    Text = "Trong lượt này, \"Đánh\"+ [DescArg1]% sát thương <PVPPenetrateKeywords:xuyên thấu>."
  },
  State_47528_Name = {Text = "Dư Uy"},
  State_47530_Desc = {
    Text = "Xem như là \"kỹ năng\"đã được sử dụng lần cuối trong lượt này."
  },
  State_47530_Name = {
    Text = "<CardKeyWord:mô phỏng diễn dịch>"
  },
  State_47557_Desc = {
    Text = "Đội duy nhất: Sau khi bắt đầu khám phá, Người trang bị bước vào Trạng thái nhân cách Cá tuyết bạc. Sau khi Người trang bị kích hoạt Bùng nổ sẽ chuyển đổi giữa nhân cách Cá tuyết bạc và nhân cách Mèo.\nNhân cách Cá tuyết bạc: Sau khi Người trang bị gây Sát thương chủ động, nhận được <WeaponEffect_Num:[StateArg1]> Năng lượng chìa khóa bạc. Nhân cách Mèo: Sau khi Người trang bị gây Sát thương chủ động, Sát thương bạo kích tạm thời của Người trang bị <WeaponEffect_Num:+[StateArg2]%>. Hai hiệu ứng này chia sẻ cơ hội kích hoạt tối đa 5 lần mỗi lượt."
  },
  State_47557_WeaponDesc = {
    Text = "Sau khi bắt đầu khám phá, Người trang bị bước vào Trạng thái nhân cách Cá tuyết bạc. Sau khi Người trang bị kích hoạt Bùng nổ sẽ chuyển đổi giữa nhân cách Cá tuyết bạc và nhân cách Mèo.\nNhân cách Cá tuyết bạc: Sau khi Người trang bị gây Sát thương chủ động, nhận được <WeaponEffect_Num:[StateArg1]> Năng lượng chìa khóa bạc. Nhân cách Mèo: Sau khi Người trang bị gây Sát thương chủ động, Sát thương bạo kích tạm thời của Người trang bị <WeaponEffect_Num:+[StateArg2]%>. Hai hiệu ứng này chia sẻ cơ hội kích hoạt tối đa 5 lần mỗi lượt."
  },
  State_47822_Desc = {
    Text = "Nếu lượt sau lại bị \"chích điện\", tất cả \"Đánh\" của nó biến thành \"ảo ảnh\", không thể xua tan, kéo dài đến cuối lượt sau."
  },
  State_47822_Name = {
    Text = "Hơi tê rồi đấy"
  },
  State_47825_Desc = {
    Text = "Khi bắt đầu lượt sẽ kích hoạt hiệu ứng kỹ năng tương ứng."
  },
  State_47825_Name = {
    Text = "<CardKeyWord:trì hoãn>"
  },
  State_47826_Desc = {
    Text = "·Khi mục tiêu đang ở trạng thái \"chích điện\", sát thương nhân đôi, ngược lại \"Đánh\" của nó không thể sử dụng trong lượt này.\n·Liên tục 2 lượt ở trạng thái \"chích điện\", tất cả \"Đánh\" của nó biến thành \"ảo ảnh\"."
  },
  State_47826_Name = {
    Text = "<WeaknessColour:chích điện>"
  },
  State_47827_Desc = {
    Text = "Mỗi tầng giảm tất cả sát thương gây ra trong toàn bộ trận chiến này 1 điểm, không thể giải trừ."
  },
  State_47827_Name = {
    Text = "<WeaknessColour:lực lượng giảm xuống>"
  },
  State_47828_Desc = {
    Text = "·Khi áp dụng sẽ gây sát thương tương đương, nếu mục tiêu đang ở trạng thái \"Vướng víu\" thì sát thương tăng gấp đôi, nếu không thì vô hiệu hóa vòng mệnh trang bị của mục tiêu cho đến khi kết thúc lượt."
  },
  State_47828_Name = {
    Text = "<WeaknessColour:Quấn Quít>"
  },
  State_47830_Desc = {
    Text = "Khi áp dụng, xóa bỏ lá chắn và chữa trị hoãn trên mục tiêu. Trước khi hết lượt, hiệu ứng chữa trị và lá chắn giảm 50%."
  },
  State_47830_Name = {
    Text = "<PVPVulnerabilityIconColour:thương tích nghiêm trọng>"
  },
  State_47831_Desc = {
    Text = "Không thể thực hiện bất kỳ hành động nào trước khi kết thúc lượt. Khi bị sát thương hôn mê, mục tiêu sẽ nhận được sức chống cự. Khi có sức chống cự, nếu bị sát thương hôn mê lần nữa, hiệu ứng hôn mê sẽ bị vô hiệu hóa và sát thương sẽ tăng gấp đôi. Trạng thái này không thể bị loại bỏ."
  },
  State_47831_Name = {
    Text = "<ComaColour:hóa đá>"
  },
  State_47832_Desc = {
    Text = "Bao gồm chuột bị nhiễm bệnh, chuột mang điện, chuột mất trí."
  },
  State_47832_Name = {
    Text = "<CardKeyWord:thẻ chuột>"
  },
  State_47833_Desc = {
    Text = "Bao gồm khăn tay hình bồ câu, hộp ảo thuật phân tách ngược, micro đọc suy nghĩ."
  },
  State_47833_Name = {
    Text = "<CardKeyWord:kỹ thuật ảo diệu>"
  },
  State_47841_Desc = {
    Text = "Trong trận chiến này, [Layer] lần sử dụng lệnh khóa sẽ áp dụng 2 lần."
  },
  State_47841_Name = {
    Text = "Lệnh Khóa Đôi"
  },
  State_47842_Desc = {
    Text = "Giảm 50% điên cuồng thu được và loại bỏ ngay lập tức toàn bộ điên cuồng bị trì hoãn."
  },
  State_47842_Name = {
    Text = "<PVPEmptinessColour:hư vô>"
  },
  State_47843_Desc = {
    Text = "Giúp thân thể tỉnh dậy và rời khỏi trạng thái tử vong, đồng thời đưa tất cả thẻ bài vào bộ rút bài."
  },
  State_47843_Name = {
    Text = "<PVPResurrectionColour:phục sinh>"
  },
  State_47844_Desc = {
    Text = "Tạo ra một hiệu ứng ngẫu nhiên đầy khó hiểu khiến mọi người phải gãi đầu."
  },
  State_47844_Name = {
    Text = "<PVPWonderfulEffectKeywords:hiệu ứng kỳ diệu>"
  },
  State_47845_Desc = {
    Text = "Thẻ bài sẽ tạo hiệu ứng khi trong tay."
  },
  State_47845_Name = {
    Text = "<CardKeyWord:giữ>"
  },
  State_47873_Desc = {
    Text = "Vào cuối lượt tiếp theo, gây sát thương tương đương với số tầng."
  },
  State_47873_Name = {
    Text = "<PVPVulnerabilityIconColour:chảy máu>"
  },
  State_47887_Name = {
    Text = "Tùy thuộc vào giới vực của đội hình hiện tại, nhận các hiệu ứng khác nhau"
  },
  State_47888_Name = {
    Text = "Huyết Nhục:\"24\" mỗi tiêu thụ 1 điểm Điểm tính toán <EmbryoFusionIconKeywords:Dung hợp Phôi thai> +[Blood:DescArg1], nhận [StateArg3] điểm <PowerIconKeywords:Sức mạnh>, bùng nổ điên cuồng của \"24\"được hưởng thêm 300% tăng cường Sức mạnh"
  },
  State_47889_Name = {
    Text = "Hải Vực: Sát thương do \"24\" gây ra được hưởng [StateArg2]% <TentacleInjurieIconKeywords:thương tổn xúc tu> tăng cường, và gây <IntoxicationIconKeywords:ngộ độc> 10% sát thương. Bùng nổ điên cuồng của \"24\" có thể kích hoạt [StateArg6]% <IntoxicationIconKeywords:ngộ độc> của kẻ địch."
  },
  State_47892_Name = {
    Text = "Hỗn Mang: Tỉ lệ chí mạng và Sát thương chí mạng của \"24\"+[StateArg4]%. Mỗi lần sử dụng Mật lệnh, Sát thương cuối cùng của Bùng nổ điên cuồng của \"24\" tăng thêm [StateArg1]%"
  },
  State_47894_Name = {
    Text = "Siêu việt:\"24\" gây sát thương nhận thêm [StateArg5]% từ <RetaliateIconKeywords:phản công>. Khi kết thúc lượt, trộn 1 lá \"cảm hứng\" vào rác bài. Giới hạn bài trên tay tăng thêm 2"
  },
  State_48009_Desc = {
    Text = "Lần đầu tiên mỗi lượt sẽ có hiệu lực thêm [StateArg1] lần."
  },
  State_48009_Name = {
    Text = "<Rune_19:hợp tấu>"
  },
  State_48010_Desc = {
    Text = "Điểm Tập hợp"
  },
  State_48010_Name = {
    Text = "Điểm Tập hợp"
  },
  State_48011_Desc = {
    Text = "Lần đầu tiên mỗi lượt sẽ có hiệu lực thêm [StateArg1] lần."
  },
  State_48011_Name = {
    Text = "<Rune_19_High:nâng cao hợp tấu>"
  },
  State_48011_WeaponDesc = {
    Text = "Sau khi sử dụng, hiệu ứng sẽ kích hoạt thêm [StateArg1] lần, tiêu thụ."
  },
  State_48012_Desc = {
    Text = "Khiến thẻ bài đã được khắcăng áp dụng hiệu ứng 2 lần khi được chơi lần đầu tiên mỗi lượt."
  },
  State_48012_Name = {
    Text = "<CardKeyWord:khắcăng: hợp tấu>"
  },
  State_48013_Desc = {
    Text = "Khiến thẻ bài khắcăng có hiệu lực 3 lần trong lần đầu mỗi lượt."
  },
  State_48013_Name = {
    Text = "<CardKeyWord:khắcăng: hợp tấu cao cấp>"
  },
  State_48019_Name = {
    Text = "<CardKeyWord:mô phỏng diễn dịch>"
  },
  State_48020_Name = {
    Text = "<CardKeyWord:linh hồn sinh ra>"
  },
  State_48021_Name = {
    Text = "<CardKeyWord:Sương mù xám>"
  },
  State_48078_Name = {
    Text = "<CardKeyWord:tinh tú giả lập>"
  },
  State_48099_Desc = {
    Text = "Khi kết thúc lượt, 「24」 nhận được [DescArg1] điểm điên cuồng, mỗi lần 「24」 giải phóng cơn thịnh nộ bùng phát, hiệu ứng này tăng thêm 1 điểm điên cuồng「.」"
  },
  State_48099_Name = {
    Text = "Nghiên cứu hành vi của Pavlov"
  },
  State_48099_WeaponDesc = {
    Text = "Trang bị nhận được 3 điểm điên cuồng sau khi lượt hành động kết thúc. Nếu trang bị có hồi phục điên cuồng lớn hơn 10, nhận thêm 2 điểm điên cuồng."
  },
  State_48100_Name = {
    Text = "Trạng thái @24 số đếm nghiên cứu hành vi Pavlov"
  },
  State_48100_WeaponDesc = {
    Text = "Trang bị nhận được 3 điểm điên cuồng sau khi lượt hành động kết thúc. Nếu trang bị có hồi phục điên cuồng lớn hơn 10, nhận thêm 2 điểm điên cuồng."
  },
  State_48107_Desc = {
    Text = "Mỗi lượt, lá\"kỹ năng\"đầu tiên của người trang bị được đánh ra sẽ tăng thương [StateArg1]%."
  },
  State_48107_Name = {
    Text = "Lưỡi kiếm khổng lồ"
  },
  State_48108_Desc = {
    Text = "Trang bị mỗi lượt, sau khi đánh \"kỹ năng\" lần đầu tiên, thêm bản sao có sức tính toán giảm [StateArg1] vào rút bài từ bộ bài."
  },
  State_48108_Name = {Text = "Fouetté"},
  State_48110_Desc = {
    Text = "\"kỹ năng\" trong lượt này sẽ thay đổi lần \"đánh\" tiếp theo thành mục tiêu ngẫu nhiên và tấn công thêm [StateArg1] mục tiêu ngẫu nhiên khác."
  },
  State_48110_Name = {
    Text = "người trong gương"
  },
  State_48140_Desc = {
    Text = "Khi bắt đầu khám phá, \"24\" vào trạng thái Nhân cách u uất.\n<School_1:Hỗn Mang·U uất>: Nhận <Posse:[StateArg1]> điểm Năng lượng chìa khóa bạc, lần tiếp theo Mật lệnh có hiệu lực 2 lần.\n<School_1:Hỗn Mang·Cuồng loạn>: Gây thương 3 lần, khiến tất cả sát thương mà \"24\" gây ra tăng lên [StateArg2] điểm.\n<School_2:Hải Vực·U uất>: <WeaknessIconKeywords:Suy nhược> và <VulnerabilityIconKeywords:Trọng thương> mục tiêu 2 lượt, tạo ra 1 Xúc tu, <TentacleInjurieIconKeywords:thương tổn xúc tu>+ [StateArg3].\n<School_2:Hải Vực·Cuồng loạn>: Sát thương này được hưởng [StateArg4]% tăng sát thương <TentacleInjurieIconKeywords:thương tổn xúc tu>, và gây <IntoxicationIconKeywords:Ngộ độc> bằng 30% sát thương gây ra cho tất cả kẻ địch.\n<School_3:Huyết Nhục·U uất>: <EmbryoFusionIconKeywords:Dung hợp Phôi thai> +[Blood:StateArg5], tích lũy [StateArg6] điểm lượng hồi phục Lò nung đỏ thẫm.\n<School_3:Huyết Nhục·Cuồng loạn>: Sát thương được hưởng 6 lần tăng sát thương <PowerIconKeywords:Sức mạnh> và gây <BleedingIconKeywords:Chảy máu> bằng 200% sát thương gây ra lên mục tiêu, nhận [StateArg7] điểm <PowerIconKeywords:Sức mạnh>.\n<School_4:Siêu Chiều·U uất>: Thêm 2 lá \"Cảm hứng\" vào tay, khiến <PowerIconKeywords:Sức mạnh> của mục tiêu tạm thời giảm [StateArg8] điểm.\n<School_4:Siêu Chiều·Cuồng loạn>: Nhận <RetaliateIconKeywords:phản công> bằng 15% sát thương gây ra, sau đó gây <FixedDamage:Sát Thương Thuần Túy> tương đương cho các kẻ địch khác. Mỗi lá \"Cảm hứng\" được chơi trong lượt này, khiến sát thương đó tăng lên [StateArg9] điểm trong lượt này, tối đa tăng [StateArg10] điểm."
  },
  State_48140_Name = {
    Text = "Giới vực và Hiệu ứng Nhân cách"
  },
  State_48141_Desc = {
    Text = "<School_1:Hỗn Mang>: Tỷ lệ chí mạng và sát thương chí mạng của \"24\"+[StateArg4]%. Mỗi lần sử dụng Mật lệnh, tăng sát thương cuối cùng bùng nổ điên cuồng của \"24\" thêm [StateArg1]%.\n<School_2:Hải Vực>: Sát thương do \"24\" gây ra được hưởng [StateArg2]% <TentacleInjurieIconKeywords:thương tổn xúc tu> tăng cường, và gây 10% sát thương của <IntoxicationIconKeywords:Ngộ độc>. Bùng nổ điên cuồng của \"24\" có thể kích hoạt <IntoxicationIconKeywords:Ngộ độc> 50% cho kẻ địch.\n<School_3:Huyết Nhục>: Mỗi khi \"24\" tiêu hao 1 điểm Điểm tính toán <EmbryoFusionIconKeywords:Dung hợp Phôi thai> +[Blood:DescArg1], nhận [StateArg3] điểm <PowerIconKeywords:Sức mạnh>. Bùng nổ điên cuồng của \"24\"được hưởng thêm 300% tăng cường Sức mạnh.\n<School_4:Siêu Chiều>: Sát thương do \"24\" gây ra được hưởng [StateArg5]% tăng sát thương <RetaliateIconKeywords:phản công>, khi kết thúc lượt, xáo trộn 1 lá \"Cảm hứng\" vào rác bài, kích tước tay tối đa +2."
  },
  State_48141_Name = {
    Text = "Hiệu ứng giới vực"
  },
  State_48149_Name = {
    Text = "Không thể sử dụng hiệu ứng đặc biệt của thẻ__\"仅开发用\""
  },
  State_48176_Desc = {
    Text = "Trong lần thử chơi này, mỗi lượt nhận được 1 điểm sức tính toán, \"24\" mỗi khi tiêu thụ 1 điểm sức tính toán, nhận được 30 điểm năng lượng chìa khóa bạc."
  },
  State_48176_Name = {
    Text = "\"24\" thử nghiệm"
  },
  State_48198_Desc = {
    Text = "Trong lần thử nghiệm này, mỗi lượt nhận được 1 lá \"cảm hứng\"."
  },
  State_48198_Name = {
    Text = "\"24\" thử nghiệm"
  },
  State_48199_Desc = {
    Text = "Trong phiên bản thử nghiệm này, mỗi vòng nhận được 1 điểm sức tính toán."
  },
  State_48199_Name = {
    Text = "\"24\" thử nghiệm"
  },
  State_48589_Desc = {
    Text = "Vị thân thể được đánh thức này chưa thức tỉnh… Khi sắp bị đánh ngã sẽ thức tỉnh, hồi phục sức sống và trở thành gấp đôi ban đầu, bắt đầu chiến đấu bằng hình thái thật sự."
  },
  State_48589_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_48607_Name = {
    Text = "Sức tính toán gốc của thẻ bài chung giảm__\"Chỉ dùng cho phát triển\""
  },
  State_48822_Desc = {
    Text = "Khi bắt đầu lượt của cơ chế giới vực thịt máu, tỷ lệ phôi hợp tử tăng thêm 50%."
  },
  State_48822_Name = {
    Text = "Sinh sôi nảy nở"
  },
  State_48923_Desc = {
    Text = "Bóng tối \"24\"đã thức tỉnh, hãy sử dụng \"cứu tôi\" cuối cùng để tìm cơ hội!"
  },
  State_48923_Name = {
    Text = "Ảnh Tử\"24\" thức tỉnh!"
  },
  State_48923_WeaponDesc = {
    Text = "Bắt đầu lượt tiếp theo nhận được lá chắn bằng với sức sống đã mất trong lượt trước."
  },
  State_49063_Desc = {
    Text = "Sát thương của \"Đánh\" của lơ-tan tăng 30%."
  },
  State_49063_Name = {
    Text = "Sức chiến đấu dâng cao"
  },
  State_49109_Desc = {
    Text = "Thẻ bài được giữ lại, khi kết thúc lượt nếu vẫn ở trong tay, bạn sẽ nhận được 1 bản sao gốc của thẻ lệnh này với chi phí tiêu thụ."
  },
  State_49109_Name = {
    Text = "<Rune_20_High:ươm mầm>"
  },
  State_49109_WeaponDesc = {
    Text = "Sau khi sử dụng, hiệu ứng sẽ kích hoạt thêm [StateArg1] lần, tiêu thụ."
  },
  State_49148_Desc = {
    Text = "Sau khi chết, gán 1 thẻ với mức tiêu hao số học không bằng 0 với \"Biến dạng 1\". Biến dạng: Trạng thái của thẻ, vẫn giữ lại sau khi trận chiến kết thúc. Mỗi lớp giảm 1 mức tiêu hao số học, nhưng sau khi tung ra, mỗi lớp sẽ đưa 1 thẻ biến dạng ngẫu nhiên vào tay(bỏ qua giới hạn tay bài), loại bỏ tất cả biến dạng."
  },
  State_49148_Name = {
    Text = "Feto Biến Dạng"
  },
  State_49149_Desc = {
    Text = "Giảm 1 điểm tiêu thụ sức tính toán của thẻ bài cho mỗi lớp. Sau khi đánh ra, với mỗi tầng Dị biến, thêm một thẻ bài Dị biến ngẫu nhiên vào tay. Loại bỏ trạng thái này sau khi sử dụng. Trạng thái này sẽ được giữ lại sau khi chiến đấu kết thúc."
  },
  State_49149_Name = {
    Text = "<ExclamationPointColour:dị biến [Layer]>"
  },
  State_49149_WeaponDesc = {
    Text = "Sau khi sử dụng, hãy loại bỏ nó vĩnh viễn."
  },
  State_49207_Name = {
    Text = "Nhận 100 Năng lượng chìa khóa"
  },
  State_49225_Desc = {
    Text = "Sau khi lượt kết thúc, yêu cầu 1 râu chạm tấn công [Layer] lần."
  },
  State_49225_Name = {
    Text = "<CardKeyWord:tập hợp râu chạm>"
  },
  State_49226_Desc = {
    Text = "Khi kết thúc lượt, với mỗi lá bài trong tay, gây 3% độc cho tất cả kẻ địch và nhận được 3 điểm Aliemus."
  },
  State_49226_Name = {
    Text = "ánh nến yếu ớt"
  },
  State_49260_Desc = {
    Text = "Phục hồi lượng sức sống tương đương 7.5% của thể chất khi kết thúc lượt."
  },
  State_49260_Name = {
    Text = "Đau không được chấp nhận"
  },
  State_49270_Desc = {
    Text = "Sát thương từ lá bài tăng [Layer] %."
  },
  State_49270_Name = {
    Text = "Tăng sát thương thẻ đánh"
  },
  State_49270_WeaponDesc = {
    Text = "Sát thương từ lá bài tăng [Layer] %."
  },
  State_49278_Desc = {
    Text = "Khi kết thúc lượt, hồi phục lượng sức sống tương đương với 5% sức sống đã mất. Nếu sức sống dưới 50%([StateArg1]), còn nhận được [StateArg2] lực lượng."
  },
  State_49278_Name = {
    Text = "Bàn thờ Đỏ thắm"
  },
  State_49430_Desc = {
    Text = "Thương nhận phải giảm, mỗi lớp giảm 1%. Trạng thái này sẽ bị loại bỏ khi đồng minh khác chết."
  },
  State_49430_Name = {
    Text = "<AberrationColour:ẩn nấp>"
  },
  State_49500_Desc = {
    Text = "Mỗi tầng tăng thêm 1 lần tấn công, mất một tầng khi nhận thương, mất toàn bộ khi kết thúc lượt."
  },
  State_49500_Name = {
    Text = "cầu nguyện"
  },
  State_49524_Desc = {
    Text = "Khi kết thúc lượt, hồi phục lượng sức sống tương đương với 5% sức sống đã mất. Mỗi lần người chơi rút được 1 thẻ trạng thái hoặc thẻ triệu chứng, tất cả \"Nubia\" nhận được [StateArg1] điểm lực lượng tạm thời."
  },
  State_49524_Name = {
    Text = "Phúc âm máu"
  },
  State_49526_Desc = {
    Text = "Sau khi chết sẽ ngay lập tức hồi phục đến [StateArg2] điểm sức sống và miễn dịch với thương trong 1 lượt, chuyển ý định thành \"Gieo rắc Ô uế\"."
  },
  State_49526_Name = {
    Text = "Gieo trồng"
  },
  State_49542_Desc = {
    Text = "Đội duy nhất: Sau khi trận chiến bắt đầu, người dùng trang bị nhận được lực lượng tương đương <WeaponEffect_Num:[StateArg1]>% sức tấn công. Nếu giới vực hiện tại là \"biển sâu\", còn tăng thêm <WeaponEffect_Num:[StateArg2]>% thương tổn xúc tu."
  },
  State_49542_WeaponDesc = {
    Text = "Sau khi chiến đấu bắt đầu, nhận được <WeaponEffect_Num:[Power:DescArg1]> điểm lực lượng, nếu giới vực hiện tại là \"biển sâu\", còn sẽ nhận được <WeaponEffect_Num:[DescArg2]> sát thương xúc tu."
  },
  State_49546_Desc = {
    Text = "Luôn xuất hiện cùng với 2 vệ sĩ tinh anh. Sau khi bản thân chết, chúng cũng sẽ chết."
  },
  State_49546_Name = {
    Text = "Đội hình"
  },
  State_49547_Desc = {
    Text = "Sau khi chết, khiến Đội trưởng Vệ binh Aran nhận được [StateArg1] điểm lực lượng, và lá chắn bằng 50% sức sống tối đa."
  },
  State_49547_Name = {
    Text = "trung thành"
  },
  State_49558_Desc = {
    Text = "Mỗi lượt lực lượng tăng <StateArg1> điểm."
  },
  State_49558_Name = {
    Text = "Lời cầu nguyện của cát"
  },
  State_49582_Desc = {
    Text = "Trong trận chiến này, lá chắn còn lại mỗi lượt sẽ không bị loại bỏ và sẽ được duy trì vĩnh viễn."
  },
  State_49582_Name = {
    Text = "Lá chắn được giữ mãi"
  },
  State_49583_Desc = {
    Text = "Vào cuối lượt, nhận được [StateArg1] điểm lá chắn, được tăng bởi trạng thái giữ mình."
  },
  State_49583_Name = {
    Text = "Thuẫn của Aran"
  },
  State_49595_Desc = {
    Text = "Thân thể được đánh thức này chưa thức tỉnh… Khi sắp ngã gục sẽ thức tỉnh, hồi phục sức sống và bắt đầu chiến đấu với hình thái thật sự."
  },
  State_49595_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_49596_Desc = {
    Text = "\"Kiếm Không Tưởng\"đã thức tỉnh, cô sẽ nhận được nhiều lá chắn và lực lượng hơn."
  },
  State_49596_Name = {
    Text = "Elva thức tỉnh!"
  },
  State_49596_WeaponDesc = {
    Text = "Bắt đầu lượt tiếp theo nhận được lá chắn bằng với sức sống đã mất trong lượt trước."
  },
  State_49597_Name = {
    Text = "Đã bị tê liệt trong lượt này__\"仅开发用\""
  },
  State_49600_Desc = {
    Text = "Làm yếu đuối tất cả kẻ địch trong 2 lượt."
  },
  State_49600_Name = {
    Text = "Máu Sợ Hãi"
  },
  State_49601_Desc = {
    Text = "Làm tăng sát thương cho tất cả kẻ địch trong 2 lượt."
  },
  State_49601_Name = {
    Text = "Máu thối rữa"
  },
  State_49602_Desc = {
    Text = "Làm tăng sát thương cho tất cả kẻ địch trong 1 lượt."
  },
  State_49602_Name = {
    Text = "Máu thối rữa"
  },
  State_49603_Desc = {
    Text = "Dung hợp Phôi thai +[Blood:DescArg1]."
  },
  State_49603_Name = {
    Text = "Máu sinh sản"
  },
  State_49604_Desc = {
    Text = "Dung hợp Phôi thai +[Blood:DescArg1]."
  },
  State_49604_Name = {
    Text = "Máu sinh sản"
  },
  State_49605_Desc = {
    Text = "Làm yếu đuối tất cả kẻ địch trong 1 lượt."
  },
  State_49605_Name = {
    Text = "Máu Sợ Hãi"
  },
  State_49623_Desc = {
    Text = "Lượng sức sống hồi phục nhận được giảm [DescArg1]%. Giảm 1 tầng khi kết thúc lượt."
  },
  State_49623_Name = {
    Text = "<BaseDamageColour:tàn phá>"
  },
  State_49623_WeaponDesc = {
    Text = "Mọi sát thương gây ra bị giảm [DescArg1] %."
  },
  State_49627_Desc = {
    Text = "Đầu tiên có 2 lớp <ParcloseIconKeywords:rào cản>. Khi chết, tất cả \"Nubia\" nhận được [StateArg1] điểm lực lượng."
  },
  State_49627_Name = {
    Text = "Máu chảy dồn dập"
  },
  State_49628_Desc = {
    Text = "Khi chết, tất cả \"Nubia\" nhận được [StateArg1] điểm lực lượng."
  },
  State_49628_Name = {
    Text = "Liên kết huyết mạch"
  },
  State_49638_Desc = {
    Text = "Nhận dạng xem có phải là trạng thái của quái vật thuộc dòng Dê Đen hay không"
  },
  State_49833_Desc = {
    Text = "Khi kết thúc lượt, gây trạng thái \"mù lòa\" trong 1 lượt cho tất cả kẻ địch. Nếu lá chắn của bản thân bị phá hủy, thì hủy bỏ trạng thái \"mù lòa\"."
  },
  State_49833_Name = {
    Text = "Vách chắn cát bụi"
  },
  State_49844_Desc = {
    Text = "Đội duy nhất: Vào cuối lượt, nhận được <WeaponEffect_Num:[StateArg1]> điểm năng lượng chìa khóa bạc. Sau khi kích hoạt kháng cự tử vong, nhận được <WeaponEffect_Num:[StateArg2]> điểm năng lượng chìa khóa bạc. Sau khi sử dụng Thân thể Linh tri thức khẩn cấp, giới hạn Điểm tính toán tăng 3, số lượng rút bài mỗi lượt tăng 3."
  },
  State_49844_WeaponDesc = {
    Text = "Sau khi kết thúc lượt, nhận được <WeaponEffect_Num:[StateArg1]> điểm năng lượng chìa khóa bạc. Sau khi kích hoạt kháng cự tử vong, nhận được <WeaponEffect_Num:[StateArg2]> điểm năng lượng chìa khóa bạc. Sau khi sử dụng thân thể Linh tri thức khẩn cấp, giới hạn Điểm tính toán tăng thêm 3, số lượng rút bài mỗi lượt tăng thêm 3."
  },
  State_49877_Desc = {
    Text = "Giảm tiêu thụ sức tính toán của thẻ bài. Sau khi đánh ra, với mỗi tầng Dị biến, thêm một thẻ bài Dị biến ngẫu nhiên vào tay. Loại bỏ trạng thái này sau khi sử dụng. Trạng thái này sẽ được giữ lại sau khi chiến đấu kết thúc."
  },
  State_49877_Name = {
    Text = "<AberrationKeywords:đột biến>"
  },
  State_49877_WeaponDesc = {
    Text = "Mỗi lớp làm chậm khiến tiêu thụ sức tính toán của thẻ bài tăng thêm 1 điểm."
  },
  State_49954_Desc = {
    Text = "Tất cả sát thương chí mạng của thân thể được đánh thức giảm một nửa."
  },
  State_49954_Name = {
    Text = "<BlindingKeywords: mù lòa>"
  },
  State_49954_WeaponDesc = {
    Text = "Mỗi lớp làm chậm khiến tiêu thụ sức tính toán của thẻ bài tăng thêm 1 điểm."
  },
  State_49957_Desc = {
    Text = "Khi chịu Sát thương chủ động, Phong ấn Bùng nổ và tất cả thẻ bài của Thể thức tỉnh tấn công trong 1 lượt, xóa 1 lớp <ResentChainsKeywords:Dây xích oán hận>. Xóa sạch khi kết thúc lượt."
  },
  State_49957_Name = {
    Text = "<ResentChainsKeywords: chuỗi oán hận>"
  },
  State_49957_WeaponDesc = {
    Text = "Mỗi lớp làm chậm khiến tiêu thụ sức tính toán của thẻ bài tăng thêm 1 điểm."
  },
  State_49958_Desc = {
    Text = "Khi chịu Sát thương chủ động và thương tổn xúc tu, Phong ấn Bùng nổ và tất cả thẻ bài của Thể thức tỉnh tấn công trong 1 lượt, xóa 1 lớp <ResentChainsKeywords:Dây xích oán hận>."
  },
  State_49958_Name = {
    Text = "<ResentChainsKeywords1:Dây xích oán hận>"
  },
  State_49959_Desc = {
    Text = "Mỗi đầu lượt, nhận được 1 lớp <ResentChainsKeywords:xiềng xích oán hận>."
  },
  State_49959_Name = {
    Text = "Khóa đa chiều"
  },
  State_50010_Desc = {
    Text = "Lượng hồi sức sống bị giảm 25%. Loại bỏ một tầng hiệu ứng khi kết thúc lượt."
  },
  State_50010_Name = {
    Text = "<HeavyInjuryKeywords:trọng thương>"
  },
  State_50021_Desc = {
    Text = "Đội duy nhất: Sau khi Người trang bị kích hoạt Bùng nổ, nhận <PowerIconKeywords:Sức mạnh> tương đương <WeaponEffect_Num:[StateArg1]%> Tấn Công của Người trang bị. Nếu Cõi hiện tại là \"Huyết Nhục\", sau khi kích hoạt Bùng nổ, Dung hợp Phôi thai <WeaponEffect_Num:+[Blood:StateArg2]> ."
  },
  State_50021_WeaponDesc = {
    Text = "Sau khi Người trang bị kích hoạt Bùng nổ, nhận <WeaponEffect_Num:[Power:DescArg1]> điểm <PowerIconKeywords:Sức mạnh>. Nếu Cõi hiện tại là \"Huyết Nhục\", sau khi kích hoạt Bùng nổ, Dung hợp Phôi thai <WeaponEffect_Num:+[Blood:StateArg2]> ."
  },
  State_50302_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>: Chịu đựng 1 lần sát thương chí mạng và phá hủy \"vòng mệnh\" này, nhận [StateArg1] lớp<PVPProtectiveKeywords:rào cản>, nếu là đồng minh sống sót duy nhất khi có hiệu lực, sẽ nhận [StateArg2] lá ngẫu nhiên \"Mật lệnh\" vào đầu lượt tiếp theo."
  },
  State_50302_Name = {
    Text = "Hoàng hôn và Bình minh"
  },
  State_50323_Desc = {
    Text = "Trước khi vòng tới bắt đầu, nhận [Layer] lệnh khóa ngẫu nhiên."
  },
  State_50323_Name = {
    Text = "Lệnh khóa trễ"
  },
  State_50333_Desc = {
    Text = "Khi kết thúc lượt, tất cả thể thức tỉnh mất điên cuồng."
  },
  State_50333_Name = {
    Text = "<EmptinessKeywords: trống rỗng>"
  },
  State_50333_WeaponDesc = {
    Text = "Mỗi lớp làm chậm khiến tiêu thụ sức tính toán của thẻ bài tăng thêm 1 điểm."
  },
  State_50352_Name = {
    Text = "Thái Di Sơ Demo"
  },
  State_50353_Name = {
    Text = "Thái Di Sơ Demo"
  },
  State_50358_Desc = {
    Text = "Thương nhận phải giảm, mỗi lớp giảm 1%. Trạng thái này sẽ bị loại bỏ khi đồng minh khác chết."
  },
  State_50358_Name = {
    Text = "<ConcealmentKeywords:ẩn nấp>"
  },
  State_50375_Desc = {
    Text = "Các hiệu ứng này bao gồm: bản thân nhận 10 điểm điên cuồng, các đồng minh khác nhận 5 điểm điên cuồng, áp dụng 1 tầng trọng thương cho tất cả kẻ địch, áp dụng 1 tầng suy nhược cho tất cả kẻ địch, rút 1 thẻ bài, nhận 200 điểm năng lượng chìa khóa bạc."
  },
  State_50375_Name = {
    Text = "<MysterybuffKeywords:hiệu ứng tích cực kỳ diệu>"
  },
  State_50389_Desc = {
    Text = "Vào đầu lượt, đặt một \"Xúc xắc may mắn của Lắc\" vào tay."
  },
  State_50389_Name = {
    Text = "Sự hỗ trợ của Lắc"
  },
  State_50390_Desc = {
    Text = "Vào đầu lượt, nhận được [StateArg1] điểm sức mạnh."
  },
  State_50390_Name = {
    Text = "kiến thức chiến trường"
  },
  State_50491_Name = {
    Text = "Con Lắc Thời Linh \"Cân Bằng\""
  },
  State_50735_Desc = {
    Text = "Khi sắp bị đánh bại lần đầu tiên, hồi phục sức sống và thay đổi ý định thành \"xé toạc nỗi đau thương\", gây ra sát thương cực lớn trong một lần."
  },
  State_50735_Name = {
    Text = "Sự kiên cường vô nghĩa"
  },
  State_50854_Desc = {
    Text = "Khi bắt đầu trận chiến, nhận [StateArg1] điểm <RetaliateIconKeywords:phản công>. Sau khi kết thúc lượt, nhận [StateArg2] điểm lá chắn, mỗi lượt lá chắn này tăng lên [StateArg3] điểm."
  },
  State_50854_Name = {
    Text = "Vỏ cây chắc chắn"
  },
  State_50861_Desc = {
    Text = "Không còn chịu thương, chuẩn bị thi triển \"vạn thiên tử tức chi mẫu\"."
  },
  State_50861_Name = {
    Text = "Đạo hàm"
  },
  State_50862_Desc = {
    Text = "Không còn bị thương, chuẩn bị giải phóng \"phồn thực\"."
  },
  State_50862_Name = {Text = "phôi hóa"},
  State_50863_Desc = {
    Text = "Không còn chịu thương, sẵn sàng tung ra \"Dịch Cây Hoang Dã\"."
  },
  State_50863_Name = {
    Text = "Miễn dịch"
  },
  State_50864_Desc = {
    Text = "Không còn chịu thương, chuẩn bị tung ra \"nhựa cây\"."
  },
  State_50864_Name = {
    Text = "Miễn dịch"
  },
  State_50891_Desc = {
    Text = "Không còn bị thương, chuẩn bị thi triển \"đa tầng dung hợp\"."
  },
  State_50891_Name = {
    Text = "tiêu thụ"
  },
  State_51016_Desc = {
    Text = "Hiệu ứng trúng độc được thay đổi thành 1000%."
  },
  State_51016_Name = {
    Text = "Gỗ khô mục"
  },
  State_51017_Desc = {
    Text = "Hiệu ứng trúng độc tăng lên 500%."
  },
  State_51017_Name = {
    Text = "Gỗ khô mục"
  },
  State_51607_Desc = {
    Text = "Miễn dịch với mọi loại thương. Loại bỏ sau khi lượt bắt đầu."
  },
  State_51607_Name = {
    Text = "Miễn dịch với sát thương"
  },
  State_51695_Desc = {
    Text = "Thân thể được đánh thức này chưa thức tỉnh… Khi sắp ngã gục sẽ thức tỉnh, hồi phục sức sống và bắt đầu chiến đấu với hình thái thật sự."
  },
  State_51695_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_51696_Desc = {
    Text = "\"Đệ tử Biển cả\"đã thức tỉnh, cô ấy có khả năng phản chế cơn điên cuồng bùng phát mạnh hơn."
  },
  State_51696_Name = {
    Text = "Miriam Thức tỉnh!"
  },
  State_51696_WeaponDesc = {
    Text = "Bắt đầu lượt tiếp theo nhận được lá chắn bằng với sức sống đã mất trong lượt trước."
  },
  State_51739_Desc = {
    Text = "Khi kết thúc lượt, nhận ngẫu nhiên 1 lá \"thần quốc hình bóng\", không thể xóa bỏ."
  },
  State_51739_Name = {
    Text = "Kết thúc niềm tin"
  },
  State_51740_Desc = {
    Text = "Khi trận chiến bắt đầu, đặt 1 lá \"Chấp Vọng\" vào tay."
  },
  State_51740_Name = {
    Text = "Sự Trung Thành Bất Diệt"
  },
  State_51741_Desc = {
    Text = "Vào đầu lượt, nhận [Layer] điểm lá chắn, không thể xóa bỏ."
  },
  State_51741_Name = {
    Text = "Giữ vững bản thân"
  },
  State_51742_Desc = {
    Text = "Vào đầu lượt, nhận [Layer] điểm thương tổn râu chạm và lực lượng, không thể xóa bỏ."
  },
  State_51742_Name = {
    Text = "Đầu thân vào Lời Khởi Thị"
  },
  State_51743_Desc = {
    Text = "Trong lượt này, mỗi lần tấn công của xúc tu, dựa trên tư thế xúc tu sẽ nhận được các hiệu ứng sau: Thủy Triều: Tất cả thể thức tỉnh nhận được <Energy:[Energy:StateArg1]> điểm điên cuồng; Biển Lặng: Gây [StateArg2] điểm <IntoxicationIconKeywords:Ngộ độc> cho tất cả kẻ địch; Sóng Gẩm: Tạm thời <TentacleInjurieIconKeywords:thương tổn xúc tu> +[StateArg3]."
  },
  State_51743_Name = {
    Text = "Lời cầu nguyện của Mẹ Thần"
  },
  State_51745_Desc = {
    Text = "Khi Sứ Giả Biển đánh ra 1 lá bài, tạo ra [StateArg1] râu chạm tạm thời, râu chạm này không bị giới hạn bởi số lượng tối đa."
  },
  State_51745_Name = {
    Text = "Quyền năng thay thế"
  },
  State_51745_WeaponDesc = {
    Text = "Khi Sứ Giả Biển đánh ra 1 lá bài, tạo ra [StateArg1] râu chạm tạm thời, râu chạm này không bị giới hạn bởi số lượng tối đa."
  },
  State_51811_Name = {
    Text = "Hiệu ứng chữa trị của Bức buồm dẫn đường__\"chỉ dùng cho phát triển\""
  },
  State_51813_Desc = {
    Text = "Sau khi lượt kết thúc, tiêu thụ sức tính toán -[Layer], hiệu ứng này cũng sẽ được kích hoạt khi bị bỏ đi."
  },
  State_51813_Name = {
    Text = "<PrepareKeypvewordscolour:chuẩn bị[Layer]>"
  },
  State_51820_Desc = {
    Text = "\"Nuôi Dưỡng\"được hiệu ứng bổ sung: khi đạt 5 tầng sẽ ngay lập tức gọi 1 \"Con Nước\", tối đa có thể tồn tại 2 \"Con Nước\"."
  },
  State_51820_Name = {
    Text = "Miriam Thức tỉnh"
  },
  State_51822_Desc = {
    Text = "Mỗi lần kích hoạt cơn thịnh nộ bùng phát tăng 1 lớp \"Ấp nở\", mỗi lớp Ấp nở nhận được [StateArg1] điểm lực lượng, giới hạn là 5 lớp."
  },
  State_51822_Name = {
    Text = "Sự giáng thần cuối cùng của Lemuria"
  },
  State_52068_Desc = {
    Text = "Chuyển đổi nhiều nhất 3 lá \"Thánh lễ\" thành \"Chấp vọng\", nhận thêm hiệu ứng đặc biệt ở các giai đoạn khác nhau tùy theo số lượng chuyển đổi."
  },
  State_52068_Name = {
    Text = "<CardKeyWord:lễ nghi>"
  },
  State_52087_Desc = {
    Text = "\"Chim cực lạc bất tử\" phải đợi sau [Layer] vòng mới có thể áp dụng lại trạng thái hồi sinh."
  },
  State_52087_Name = {
    Text = "Thời gian hồi sinh"
  },
  State_52116_Desc = {
    Text = "Trước khi kết thúc lượt, thể thức tỉnh này sau khi sử dụng bùng nổ điên cuồng sẽ chịu [Layer] sát thương."
  },
  State_52116_Name = {Text = "Burst Lock"},
  State_52369_Desc = {
    Text = "Sau khi đánh [DescArg1] thẻ triệu chứng, nhận được thẻ hỗ trợ của tulô \"Quyền vương\": gây thương lớn và làm mục tiêu mất ý thức trong 1 lượt."
  },
  State_52369_Name = {
    Text = "Thần quốc chắc chắn sẽ tái lâm"
  },
  State_53115_Desc = {
    Text = "Bản lượt này, hiệu ứng \"Lễ tế\" tiếp theo của Miriam được tăng 50%."
  },
  State_53115_Name = {
    Text = "Cầu nguyện cho hố sâu"
  },
  State_53144_Desc = {
    Text = "Vào đầu mỗi lượt nhận được <Block:[Block:StateArg1]> điểm lá chắn."
  },
  State_53144_Name = {
    Text = "<CardKeyWord:kiên trì với bản thân>"
  },
  State_53145_Desc = {
    Text = "Mỗi đầu vòng <PowerIconKeywords:lực lượng> và <TentacleInjurieIconKeywords:râu chạm> +[StateArg2]."
  },
  State_53145_Name = {
    Text = "<CardKeyWord:dâng hiến cho sự khai sáng>"
  },
  State_53673_Desc = {
    Text = "Số lượng tuyến thể phân chia có thể đạt tối đa 10 cái."
  },
  State_53673_Name = {
    Text = "Giới hạn phân chia tuyến"
  },
  State_53674_Desc = {
    Text = "Số lượng bài trong tay tối đa +2. Vào đầu lượt, Miriam nhận được 20 điểm cuồng nộ."
  },
  State_53674_Name = {
    Text = "Miriam Playtest"
  },
  State_53755_Desc = {
    Text = "Tất cả <PowerIconKeywords:lực lượng>, <RetaliateIconKeywords:phản công>, <IntoxicationIconKeywords:trúng độc> do thân thể được đánh thức gây ra tăng [DescArg1]%. \"Phân Hoa Chương\"áp dụng <PowerIconKeywords:lực lượng> tăng."
  },
  State_53755_Name = {
    Text = "Trang thơ quái đản·nỗi sợ"
  },
  State_53756_Desc = {
    Text = "Tất cả thân thể được đánh thức gây tăng [DescArg1]% điên cuồng, sức tính toán và thẻ lệnh khi kết thúc lượt có thể giữ lại đến lượt sau. \"Phần Hoa Chương\" cũng gia tăng hiệu ứng điên cuồng."
  },
  State_53756_Name = {
    Text = "Bài thơ ảo mộng·Vui"
  },
  State_53758_Desc = {
    Text = "Tất cả sát thương cuối cùng gây ra bởi các thân thể được đánh thức được tăng [DescArg1]%, \"Phân Hoa Chương\" tăng tỷ lệ chí mạng và thương chí mạng."
  },
  State_53758_Name = {
    Text = "Bài thơ hoang tưởng · Nộ"
  },
  State_53759_Desc = {
    Text = "Tất cả các thân thể được đánh thức tạo ra lá chắn và phục hồi sức sống, hiệu ứng giảm <PowerIconKeywords:lực lượng> được cải thiện [DescArg1]%, \"Phân Hoa Chương\" tăng cường khả năng hồi phục."
  },
  State_53759_Name = {
    Text = "Bi thương thi phẩm · Ai"
  },
  State_53772_Name = {
    Text = "Trang sức nhị luật bối phản"
  },
  State_53772_WeaponDesc = {
    Text = "Người trang bị sau khi sử dụng cơn thịnh nộ bùng phát, đồng minh nhận được <RetaliateIconKeywords:phản công> tương ứng 100% phòng thủ của người trang bị. Và làm tăng 10% <RetaliateIconKeywords:phản công> hiện tại của bản thân."
  },
  State_53870_Name = {
    Text = "Vòng Phòng Trang Sức 36"
  },
  State_53870_WeaponDesc = {
    Text = "Khi rút được thẻ bài của người sở hữu trang bị, sức tính toán của họ sẽ thay đổi ngẫu nhiên trong khoảng từ 0-3."
  },
  State_53981_Name = {
    Text = "Giấc mơ về đồ trang sức và thuốc dấu đen điều chỉnh"
  },
  State_53981_WeaponDesc = {
    Text = "Sau khi chiến đấu bắt đầu, thêm bộ bài của người trang bị vào bộ bài rút."
  },
  State_54002_Name = {
    Text = "Trạng thái @ phụ kiện giấc mơ chế tạo lọc dấu"
  },
  State_54002_WeaponDesc = {
    Text = "Người trang bị sau khi sử dụng cơn thịnh nộ bùng phát, đồng minh nhận được <RetaliateIconKeywords:phản công> dựa trên 100% phòng thủ của người trang bị. Đồng thời tăng 10% <RetaliateIconKeywords:phản công> hiện tại của bản thân."
  },
  State_54011_Name = {
    Text = "Trạng thái@trang sức giấc mơ dược phẩm bản sao 1, có thể dùng"
  },
  State_54011_WeaponDesc = {
    Text = "Người trang bị sau khi sử dụng cơn thịnh nộ bùng phát, phía mình nhận được <RetaliateIconKeywords:phản công> dựa trên 100% phòng thủ của người trang bị. Đồng thời làm tăng 10% <RetaliateIconKeywords:phản công> hiện tại của bản thân."
  },
  State_54012_Name = {
    Text = "Trạng thái@phụ kiện giấc mơ dược liệu bản sao 2 có thể sử dụng"
  },
  State_54012_WeaponDesc = {
    Text = "Người trang bị sau khi sử dụng cơn thịnh nộ bùng phát, phía mình nhận được <RetaliateIconKeywords:phản công> dựa trên 100% phòng thủ của người trang bị. Đồng thời làm tăng <RetaliateIconKeywords:phản công> hiện tại của bản thân lên 10%."
  },
  State_54013_Desc = {
    Text = "Bản vòng này, giới vực tinh thông tăng [Layer] điểm."
  },
  State_54013_Name = {
    Text = "Sự thông thạo giới vực tạm thời"
  },
  State_54014_Desc = {
    Text = "Giới vực thông thạo được tăng thêm [Layer] điểm."
  },
  State_54014_Name = {
    Text = "Sự thông thạo giới vực"
  },
  State_54043_WeaponDesc = {
    Text = "Sau khi người trang bị sử dụng cơn thịnh nộ bùng phát, trong lượt này, hiệu quả của lá chắn và khả năng chữa trị của bản thân sẽ tăng gấp đôi."
  },
  State_54044_Desc = {
    Text = "Gây thương gấp đôi và nhận thêm Năng lượng chìa khóa bạc tương đương 600% Sạc năng lượng chìa khóa bạc của Ramona vòng lặp, nhưng sau khi chơi sẽ <DepleteIconKeywords:tiêu hao>."
  },
  State_54044_Name = {
    Text = "Bài ca tương lai"
  },
  State_54045_Desc = {
    Text = "Nhận được 3 điểm tính toán."
  },
  State_54045_Name = {
    Text = "Vườn Luân Hồi"
  },
  State_54046_Desc = {
    Text = "Vào đầu lượt, phục hồi [StateArg1] điểm sức sống, kéo dài [Layer] lượt."
  },
  State_54046_Name = {
    Text = "Lý tính, Sự thật và Hiện thực"
  },
  State_54071_Desc = {
    Text = "Số lần Sát thương chủ động của Orci gây ra +1, kéo dài [Layer] lượt."
  },
  State_54071_Name = {
    Text = "Bảy Nghệ Thuật, Tám Đức Hảo"
  },
  State_54121_Desc = {
    Text = "Trong trận chiến này, \"Quái thú hỗn loạn\" gây ra sát thương cơ bản tăng [Layer]%."
  },
  State_54121_Name = {
    Text = "quái thú hỗn loạn"
  },
  State_54138_Desc = {
    Text = "Sorrel sử dụng [Layer] thẻ lệnh có hiệu lực 2 lần."
  },
  State_54138_Name = {
    Text = "Vũ điệu quyền lực"
  },
  State_54384_Desc = {
    Text = "Khiến Ninh Phi Nga gây ra <IntoxicationIconKeywords:trúng độc> tăng 50%, kéo dài [Layer] lượt."
  },
  State_54384_Name = {
    Text = "lễ tang bản thân"
  },
  State_54416_Desc = {
    Text = "Lượng điên cuồng tối đa mà thể thức tỉnh có thể tích lũy được nhân đôi. Nếu điên cuồng đạt đến gấp đôi điên cuồng cơ bản có thể giải phóng bùng nổ siêu giới hạn, sau khi giải phóng bùng nổ điên cuồng thì điên cuồng còn lại giảm một nửa."
  },
  State_54416_Name = {
    Text = "<OverLimitUtlSkillKeywords:bùng nổ siêu giới hạn>"
  },
  State_54416_WeaponDesc = {
    Text = "Tiêu thụ bài trên tay phôi thai, kích hoạt hiệu ứng nuốt chửng mạnh mẽ."
  },
  State_54561_Desc = {
    Text = "Đội duy nhất: Giá trị sát thương gây ra bởi người trang bị tăng thêm <WeaponEffect_Num:[StateArg1]%> sức tấn công của họ. Nếu giới vực hiện tại là \"thịt máu\", mỗi khi người trang bị kích hoạt hiệu ứng tiêu thụ, sát thương của họ sẽ tăng thêm 3% sức tấn công."
  },
  State_54561_WeaponDesc = {
    Text = "Người trang bị gây thêm [DescArg1] điểm sát thương. Nếu giới vực hiện tại là\"thịt máu\", mỗi khi người trang bị kích hoạt hiệu ứng tiêu thụ, sát thương gây ra sẽ tăng thêm [DescArg2] điểm."
  },
  State_54568_Name = {
    Text = "cho đến khi hành tinh kết thúc"
  },
  State_54597_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>: Sau khi thể thức tỉnh của đối phương chết, nhận được [StateArg1] <StrongEffectKeywords:sự khuếch đại>, đặt lá \"kỹ năng\" có tiêu thụ sức tính toán cao nhất và kèm theo <PVPVoidKeywords:hư vô> vào tay."
  },
  State_54597_Name = {
    Text = "Triệu ánh nhìn yêu thương"
  },
  State_54704_Desc = {
    Text = "Lệnh thẻ tiếp theo của \"24\"áp dụng 3 lần."
  },
  State_54704_Name = {
    Text = "Bữa tiệc điên rồ của xác chết biến dạng"
  },
  State_54798_Desc = {
    Text = "Tất cả thân thể được đánh thức gây lá chắn, hồi sức sống, hiệu ứng giảm <PowerIconKeywords:lực lượng> tăng [StateArg1]%, hiệu quả hồi phục của chương Phức Hoa được tăng cường."
  },
  State_54798_Name = {Text = "\"ai\""},
  State_54799_Desc = {
    Text = "Tất cả các hiệu ứng <RetaliateIconKeywords:phản công>, <IntoxicationIconKeywords:trúng độc>, nhận <PowerIconKeywords:lực lượng> do thân thể được đánh thức gây ra tăng [StateArg1]%. Lực lượng của Chương Phức Hoa được tăng cường."
  },
  State_54799_Name = {Text = "\"sợ\""},
  State_54800_Desc = {
    Text = "Tất cả thương cuối cùng gây ra bởi thân thể được đánh thức tăng [StateArg1]%. Tỷ lệ chí mạng và thương chí mạng của Chương Phồn Hoa cũng được tăng lên."
  },
  State_54800_Name = {Text = "\"giận\""},
  State_55108_Desc = {
    Text = "Vào đầu lượt, nâng cấp \"Lửa Xanh\" hoặc \"Lửa Xanh Bị Phân Hủy\" trong tay thành \"Lửa Xanh Diệt Vong\", kéo dài [Layer] lượt."
  },
  State_55108_Name = {
    Text = "Dấu hiệu tử thần đến"
  },
  State_55108_WeaponDesc = {
    Text = "Khi bắt đầu lượt, nếu ở bài trên tay hoặc không gian siêu việt sẽ được tăng cường"
  },
  State_55113_Desc = {
    Text = "Sau khi Ôrla chơi bài thơ đầu tiên trong mỗi lượt, nhận được 10 điểm điên cuồng."
  },
  State_55113_Name = {
    Text = "Sự tái ngộ của hoa và thơ"
  },
  State_55465_Name = {
    Text = "Tiêu thụ [Layer] lớp ẩn dụ\"nộ\" và gây thêm [DescArg1] lần thương"
  },
  State_55466_Name = {
    Text = "Tiêu thụ [Layer] lớp ẩn dụ\"buồn\", hồi phục <Heal:[Heal:DescArg1]> điểm sức sống"
  },
  State_55467_Name = {
    Text = "Tiêu thụ [Layer] lớp ẩn dụ\"sợ\", đồng thời nhận thêm [Power:DescArg1] điểm<PowerIconKeywords:lực lượng>"
  },
  State_55469_Name = {
    Text = "Tiêu thụ [Layer] lớp ẩn dụ \"hỷ\", thêm vào đó nhận được <Energy:[Energy:DescArg1]> điểm điên cuồng"
  },
  State_55470_Name = {
    Text = "đòn tấn công gãy cổ"
  },
  State_55485_Desc = {
    Text = "Cassia đánh ra [Layer] lá bài tiếp theo sẽ nhận được lực lượng bằng 10% sức tấn công của bản thân."
  },
  State_55485_Name = {
    Text = "Cười thả ga"
  },
  State_55486_Name = {
    Text = "Thành phố Mộng Tử: Bùng nổ siêu giới hạn, miễn trừ tiêu thụ Mộng Dẫn"
  },
  State_55487_Desc = {
    Text = "Đòn đánh của Erika gây thêm 2 lần thương, và \"phòng thủ\" nhận thêm 2 lớp \"lá chắn\", kéo dài [Layer] lượt."
  },
  State_55487_Name = {
    Text = "Tính toán đa lần"
  },
  State_55489_Name = {
    Text = "Bước nhảy không-thời gian"
  },
  State_55806_Name = {
    Text = "<PoetryKeywords:Thơ dâng>: tạo hiệu ứng xấu lên tất cả kẻ địch <PVPWonderfulEffectKeywords:hiệu ứng kỳ diệu> hoặc cho toàn bộ đồng minh hiệu ứng tích cực <PVPWonderfulEffectKeywords:hiệu ứng kỳ diệu> hoặc rút 1 lá bài, nhận 1 Điểm tính toán. Lần thơ dâng cuối cùng kích hoạt 2 lần"
  },
  State_55807_Name = {
    Text = "Rút 1 lá bài, nhận được 1 sức tính toán"
  },
  State_55808_Name = {
    Text = "<PoetryKeywords:Thơ dâng>: Cung cấp cho tất cả đồng minh hiệu ứng tích cực <PVPWonderfulEffectKeywords:hiệu ứng tuyệt diệu> hoặc rút một lá bài, nhận một sức tính toán. Lần thơ dâng cuối cùng kích hoạt 2 lần"
  },
  State_55809_Name = {
    Text = "Gây hiệu ứng tiêu cực lên tất cả kẻ địch <PVPWonderfulEffectKeywords:hiệu ứng kỳ diệu>"
  },
  State_55811_Desc = {
    Text = "Chọn một mục từ danh sách các lựa chọn áp dụng."
  },
  State_55811_Name = {
    Text = "<ComaColour:quyết định>"
  },
  State_55813_Name = {
    Text = "<PoetryKeywords:Thơ dâng>:tạo hiệu ứng xấu lên tất cả kẻ địch <PVPWonderfulEffectKeywords:hiệu ứng kỳ diệu> hoặc rút 1 lá bài, nhận 1 sức tính toán. Lần thơ dâng cuối cùng kích hoạt 2 lần"
  },
  State_55814_Name = {
    Text = "<PoetryKeywords:Thơ dâng>: cho toàn bộ địch hiệu ứng tiêu cực <PVPWonderfulEffectKeywords:hiệu ứng kỳ diệu> hoặc cho toàn bộ đồng minh hiệu ứng tích cực <PVPWonderfulEffectKeywords:hiệu ứng kỳ diệu>. Lần thơ dâng cuối cùng kích hoạt 2 lần"
  },
  State_55816_Name = {
    Text = "Cho tất cả đồng minh hiệu ứng có lợi <PVPWonderfulEffectKeywords:hiệu ứng kỳ diệu>"
  },
  State_55824_Desc = {
    Text = "Chọn một trong các lựa chọn liệt kê để áp dụng, sau khi chọn sẽ loại bỏ lựa chọn này. Nếu còn lựa chọn khác, thẻ này sẽ được đặt vào tay đối thủ."
  },
  State_55824_Name = {
    Text = "<ComaColour:thơ dâng>"
  },
  State_55836_Desc = {
    Text = "Vào cuối lượt, tiêu thụ sức tính toán của thẻ lệnh Ôrla trong tay giảm 1."
  },
  State_55836_Name = {
    Text = "Mực nhuộm thành thơ"
  },
  State_55839_Desc = {
    Text = "Khi nhặt, mất tất cả các sáng tạo khác, nhận ngẫu nhiên 2 đồ tạo tác vàng."
  },
  State_55866_Desc = {
    Text = "Đội duy nhất: Khi trận chiến bắt đầu, rút ngẫu nhiên 1 thẻ lệnh của người trang bị và có <WeaponEffect_Num:[StateArg1]%> khả năng giảm tiêu thụ sức tính toán đi 1. Mỗi khi kích hoạt kháng cự tử vong, hiệu ứng này sẽ tái kích hoạt 1 lần."
  },
  State_55866_WeaponDesc = {
    Text = "Khi bắt đầu chiến đấu, rút ngẫu nhiên 1 thẻ lệnh của người trang bị và có <WeaponEffect_Num:[StateArg1]%> khả năng giảm tiêu thụ sức tính toán đi 1. Mỗi khi kích hoạt kháng cự tử vong, hiệu ứng này sẽ tái kích hoạt."
  },
  State_55992_Desc = {
    Text = "Khi sức tính toán không đủ, sẽ tạo ra hiệu ứng tiêu thụ và đánh dấu trên thẻ bài."
  },
  State_55992_Name = {Text = "Tàn tro"},
  State_55993_Name = {
    Text = "Dấu vết tro tàn"
  },
  State_56018_Desc = {
    Text = "Trong chiến đấu này, giá trị máu tối đa tăng [Layer]%."
  },
  State_56018_Name = {
    Text = "Sự ưu ái của Muse - Mệnh"
  },
  State_56020_Desc = {
    Text = "Trong trận chiến này, sát thương tăng thêm [Layer]%."
  },
  State_56020_Name = {
    Text = "Sự ưu ái của Muse - Sức mạnh"
  },
  State_56030_Desc = {
    Text = "Trong lượt này, lá chắn và chữa trị từ thân thể được đánh thức tăng [Layer]%."
  },
  State_56030_Name = {Text = "Tuyết"},
  State_56031_Desc = {
    Text = "Mỗi lần gây ra sát thương trong lượt này, tỷ lệ chí mạng tạm thời +[Layer]%."
  },
  State_56031_Name = {Text = "bướm"},
  State_56034_Desc = {
    Text = "Mỗi loại \"ẩn dụ\" tối đa 3 tầng. Các loại \"ẩn dụ\" khác nhau sẽ tăng cường các hiệu ứng khác nhau của thi phẩm: \n<D06CardKeyWordnu:Thiên Cuồng Thi Phẩm>: tiêu thụ tất cả ẩn dụ \"nộ\", mỗi tầng ẩn dụ gây thêm 2 lần thương. \n<D06CardKeyWordai:Thiên Ai Thi Phẩm>: tiêu thụ tất cả ẩn dụ \"ai\", mỗi tầng ẩn dụ hồi phục thêm sức sống. \n<D06CardKeyWordxi:Bài thơ ảo mộng>: tiêu thụ tất cả ẩn dụ \"hỉ\", mỗi tầng ẩn dụ nhận thêm 10 điểm điên cuồng. \n<D06CardKeyWordju:Trang thơ quái đản>: tiêu thụ tất cả ẩn dụ \"kỵ\", mỗi tầng ẩn dụ nhận thêm <PowerIconKeywords:lực lượng>."
  },
  State_56034_Name = {Text = "Ẩn dụ"},
  State_56208_Desc = {
    Text = "Bài ca mưa: Trả lời <Heal:[DescArg1]> điểm Sinh lực.\nBài hát gió: Nhận [DescArg2] điểm <PowerIconKeywords:Sức mạnh>.\nBài ca hoa: Tất cả Thể thức tỉnh nhận [DescArg3] điểm Điên loạn.\nBài ca Mặt Trăng: Tỷ lệ chí mạng tạm thời tăng [DescArg4]%."
  },
  State_56208_Name = {Text = "Trang thơ"},
  State_56330_Desc = {
    Text = "Nhận được [DescArg1] điểm lá chắn. Nếu đã sử dụng 3 lần kỹ năng điên cuồng bùng phát trong lượt này, thẻ này kích hoạt thêm một lần."
  },
  State_56330_Name = {
    Text = "Imageri cao cấp"
  },
  State_56331_Desc = {
    Text = "Chọn 1 thẻ lệnh từ bộ bài rút hoặc rác bài để đưa vào tay, đồng thời giảm 2 điểm tiêu thụ sức tính toán."
  },
  State_56331_Name = {
    Text = "Imageri cao cấp"
  },
  State_56332_Desc = {
    Text = "Nhận được [DescArg1] điểm <PowerIconKeywords:lực lượng> tạm thời. Sau khi sử dụng, mỗi lần gây 1 điểm thương trong lượt này, tỷ lệ chí mạng tạm thời tăng thêm 3%."
  },
  State_56332_Name = {
    Text = "Imageri cao cấp"
  },
  State_56333_Desc = {
    Text = "Phục hồi 10% sức sống đã mất. Nếu sức sống hiện tại thấp hơn 25%, thẻ này kích hoạt thêm một lần nữa."
  },
  State_56333_Name = {
    Text = "Imageri cao cấp"
  },
  State_56334_Desc = {
    Text = "Lệnh khóa tiếp theo sẽ có hiệu lực trong 2 lần."
  },
  State_56334_Name = {
    Text = "Imageri cao cấp"
  },
  State_56335_Desc = {
    Text = "Gây <FixedDamage:Sát Thương Thuần Túy> bằng 150% Sinh lực tối đa của bản thân, sát thương này được hưởng hệ số <PowerIconKeywords:sức mạnh> nhân 10."
  },
  State_56335_Name = {
    Text = "Imageri cao cấp"
  },
  State_56336_Desc = {
    Text = "Rút 5 lá bài."
  },
  State_56336_Name = {
    Text = "Imageri cao cấp"
  },
  State_56337_Desc = {
    Text = "Nhận [DescArg1] điểm <AlertIconKeywords:giữ mình> tạm thời. Sau khi đánh ra, trong lượt này, lượng lá chắn và hồi phục tăng [DescArg2]%."
  },
  State_56337_Name = {
    Text = "Imageri cao cấp"
  },
  State_56338_Desc = {
    Text = "Nhận được 3 điểm tính toán."
  },
  State_56338_Name = {
    Text = "Imageri cao cấp"
  },
  State_56339_Desc = {
    Text = "Giải trừ ngẫu nhiên 1 trạng thái tiêu cực. Thẻ này kích hoạt thêm 3 lần, tiêu thụ."
  },
  State_56339_Name = {
    Text = "Imageri cao cấp"
  },
  State_56340_Desc = {
    Text = "Áp dụng 3 lượt <VulnerabilityIconKeywords:tăng sát thương> cho tất cả kẻ địch. Mỗi khi một kẻ địch chết, đưa thẻ này từ bộ bài vào tay."
  },
  State_56340_Name = {
    Text = "Imageri cao cấp"
  },
  State_56341_Desc = {
    Text = "Sự am hiểu giới vực +25 điểm, Thành thạo giới vực tạm thời +125 điểm."
  },
  State_56341_Name = {
    Text = "Imageri cao cấp"
  },
  State_56342_Desc = {
    Text = "Tất cả các thân thể được đánh thức đều nhận thêm 15 điểm điên cuồng."
  },
  State_56342_Name = {
    Text = "Imageri cao cấp"
  },
  State_56343_Desc = {
    Text = "Áp dụng 3 lượt <WeaknessIconKeywords:yếu đuối> lên tất cả kẻ địch, đặt 1 bản sao của thẻ này vào đống bài bỏ, kèm theo <DepleteIconKeywords:tiêu thụ>, <NothingnessIconKeywords:hư vô>."
  },
  State_56343_Name = {
    Text = "Imageri cao cấp"
  },
  State_56372_Desc = {
    Text = "Khi chết, loại bỏ 1 trạng thái tiêu cực cuối cùng mà người chơi đã nhận được."
  },
  State_56372_Name = {
    Text = "Hoa và Thơ"
  },
  State_56400_Desc = {
    Text = "Sau khi \"đánh\", các \"kỹ năng\" của bản thân trong tay sẽ lần lượt biến thành các \"kỹ năng\" khác theo thứ tự [ShowIfState:, <CardKeyWord:<SkillName3:>>→<CardKeyWord:<SkillName2:>>→<CardKeyWord:<SkillName1:>>→<CardKeyWord:<SkillName3:>>]."
  },
  State_56400_Name = {
    Text = "Hoa và Thơ của Quá Khứ"
  },
  State_56402_Desc = {
    Text = "Sở hữu ẩn dụ <D06CardKeyWordnu:「nộ」> [DescArg2] tầng: 「Bài thơ cuồng tưởng」khi nhảy vọt, gây thêm thương. \n sở hữu ẩn dụ <D06CardKeyWordai:「ai」> [DescArg3] tầng: 「Bài thơ ai động」khi nhảy vọt, hồi phục thêm sức sống. \n sở hữu ẩn dụ <D06CardKeyWordxi:「hỷ」> [DescArg1] tầng: 「Bài thơ ảo mộng」khi nhảy vọt, làm thân thể được đánh thức nhận được điên cuồng. \n sở hữu ẩn dụ <D06CardKeyWordju:「sợ hãi」> [DescArg4] tầng: 「Trang thơ quái đản」khi nhảy vọt, nhận thêm lực lượng."
  },
  State_56402_Name = {Text = "Ẩn dụ"},
  State_57166_Desc = {
    Text = "Sát thương gây ra bởi thân thể được đánh thức tăng 25%."
  },
  State_57170_Desc = {
    Text = "Giới hạn bài trên tay +2, khi kết thúc lượt chọn 1 bài trên tay để giữ lại và giảm 1 điểm tiêu thụ sức tính toán của nó, kéo dài 3 lượt."
  },
  State_57170_Name = {
    Text = "Ánh sáng lạc đường"
  },
  State_57316_Desc = {
    Text = "Mỗi đầu lượt, chuyển đổi 1 lá \"Phôi thai\" thành \"Con của sự thánh thiện\", nếu không có \"Phôi thai\" thì <EmbryoFusionIconKeywords:Dung hợp Phôi thai> +[Blood:DescArg1], không bị ảnh hưởng bởi hiệu ứng tăng Dung hợp Phôi thai. Kéo dài [Layer] lượt."
  },
  State_57316_Name = {
    Text = "Di sản của hài cốt thiêng liêng vĩnh cửu"
  },
  State_57317_Desc = {
    Text = "Khi vòng mệnh này có trong bộ bài, bạn sẽ có thể thấy được những thay đổi sắp xảy ra của kỹ năng trong tay."
  },
  State_57317_Name = {
    Text = "<PVPFlowerKeywords:Hoa và Thơ của Quá Khứ>"
  },
  State_57324_Desc = {
    Text = "Nếu thân thể được đánh thức này kích hoạt \"Hoa và Thơ của Ngày Xưa\", lá bài này sẽ biến thành <CardKeyWord:<SkillName1:>>."
  },
  State_57324_Name = {
    Text = "Hoa và Thơ của Quá Khứ"
  },
  State_57325_Desc = {
    Text = "Nếu thân thể được đánh thức này kích hoạt \"Hoa và Thơ của Quá Khứ\", lá bài này sẽ biến thành <CardKeyWord:<SkillName2:>>."
  },
  State_57325_Name = {
    Text = "Hoa và Thơ của Quá Khứ"
  },
  State_57326_Desc = {
    Text = "Nếu thân thể được đánh thức này kích hoạt \"Hoa và Thơ của Quá Khứ\", lá bài này sẽ biến thành <CardKeyWord:<SkillName3:>>."
  },
  State_57326_Name = {
    Text = "Hoa và Thơ của Quá Khứ"
  },
  State_57335_Name = {
    Text = "Thẻ này gây sát thương tăng thêm [DescArg1] lần sức mạnh"
  },
  State_57356_Name = {
    Text = "Trạng thái@phản công của người chìm sâu tính toán"
  },
  State_57368_Name = {
    Text = "Trạng thái@Bệ phản công từ vực sâu"
  },
  State_57413_Name = {
    Text = "Mỗi điểm lá chắn làm tăng sát thương của thẻ này [DescArg1] điểm"
  },
  State_57417_Desc = {
    Text = "Mỗi lần kích hoạt Kháng Cự Tử Vong, gây ra 100% <FixedDamage:Sát Thương Thuần Túy> phản công. Trong trận chiến này, mỗi lần kích hoạt Kháng Cự Tử Vong sẽ tăng <FixedDamage:Sát Thương Thuần Túy> thêm 25%."
  },
  State_57417_Name = {
    Text = "Cradle of Love"
  },
  State_57566_Name = {
    Text = "Sinh tồn trong tuyệt cảnh"
  },
  State_57587_Desc = {
    Text = "Khi sử dụng \"Phân Chia Tuyến Thể\", rút 1 lá bài, còn lại [Layer] lần."
  },
  State_57587_Name = {
    Text = "Sứa, tập trung!"
  },
  State_57665_Name = {
    Text = "Sự che chở của Thần Mẫu"
  },
  State_57728_Desc = {
    Text = "Số lần thương của Yu U Hahi tăng lên 1."
  },
  State_57728_Name = {
    Text = "Quà tặng của Blood Surge"
  },
  State_57751_Desc = {
    Text = "Đội duy nhất: Trang bị gây tăng lá chắn <WeaponEffect_Num:[StateArg1]%>. Sau khi kích hoạt lệnh khóa, tất cả thân thể được đánh thức nhận được <WeaponEffect_Num:[StateArg2]%> tỷ lệ chí mạng tạm thời và thương harming chí mạng, nhưng hiến tế 3% máu tối đa. Nếu giới vực hiện tại là \"biển sâu\", sau khi kích hoạt lệnh khóa, thương tổn râu chạm sẽ tăng thêm <WeaponEffect_Num:[StateArg3]%> của sức tấn công trang bị."
  },
  State_57751_WeaponDesc = {
    Text = "Trang bị tăng cường lá chắn <WeaponEffect_Num:[StateArg1]%>. Sau khi phát hành lệnh khóa, tất cả thân thể được đánh thức nhận được <WeaponEffect_Num:[StateArg2]%> tỷ lệ chí mạng tạm thời và thương harming chí mạng, nhưng thêm [DescArg1] điểm hiến tế. Nếu giới vực hiện tại là \"biển sâu\", sau khi phát hành lệnh khóa, còn làm tăng thương tổn râu chạm [DescArg2] điểm."
  },
  State_57753_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>: Khi trang bị, nhận được [StateArg1] tầng <PVPSleepKeywords:ngủ tinh tế>."
  },
  State_57753_Name = {
    Text = "Ngủ dưới sông băng"
  },
  State_57766_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>: Sau lần \"Bùng nổ\"đầu tiên mỗi lượt, tạm thời <StrongEffectKeywords:sự khuếch đại> +[StateArg1]."
  },
  State_57766_Name = {
    Text = "Cây gậy của người chăn cừu"
  },
  State_57767_Desc = {
    Text = "<PVPWeaponKeywords:Bánh xe định mệnh>:Khi kết thúc lượt, trừ <Energy:[Energy:StateArg1]> Aliemus để chuyển hóa thành <PVPDerivativeCardKeywords_12:「Ước nguyện Nhỏ」>, nếu chuyển hóa thất bại thì nhận <Energy:[Energy:StateArg2]> Aliemus."
  },
  State_57767_Name = {
    Text = "Buổi biểu diễn không bao giờ ngừng"
  },
  State_57768_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>:\"kỹ năng\" sát thương tăng [StateArg1]%. Sau khi \"Bùng nổ\" hồi phục [StateArg2]% sinh lực đã mất của bản thân."
  },
  State_57768_Name = {
    Text = "Đợi đến khi tuyết sơn tan"
  },
  State_57769_Desc = {
    Text = "<PVPWeaponKeywords:Bánh xe định mệnh>：Sau khi ra thẻ kỹ năng của người trang bị, rút 1 thẻ kỹ năng của người trang bị, mỗi lượt chỉ có hiệu lực 1 lần."
  },
  State_57769_Name = {
    Text = "Cánh cửa Sự thật"
  },
  State_57770_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>: hiệu ứng thương, hồi phục và lá chắn mà \"kỹ năng\" gây ra tăng lên [StateArg1]~[StateArg2]% (hiện tại là [Layer] %), <PhantomKeywords:Ảo ảnh>."
  },
  State_57770_Name = {
    Text = "Roulette Số Phận"
  },
  State_57814_Name = {
    Text = "Khi đánh dấu này tồn tại, nó cho biết đang thay đổi vòng mệnh. Một số logic sẽ cần nhận diện đánh dấu này.__\"Chỉ dùng cho phát triển\""
  },
  State_57817_Desc = {
    Text = "Không thể hành động, khi kết thúc lượt số lớp - 1. Khi số lớp cạn kiệt, <StrongEffectKeywords:cường lực> +5. Không thể bị xóa bỏ, thay đổi vòng mệnh sẽ mất trạng thái ngủ tinh tế."
  },
  State_57817_Name = {
    Text = "Giấc ngủ tinh tế"
  },
  State_57854_Desc = {
    Text = "Vào đầu lượt, nhận [StateArg1] điểm lá chắn và [StateArg2] sát thương xúc tu, tạo ra 2 râu chạm tạm thời, kéo dài [Layer] lượt."
  },
  State_57854_Name = {
    Text = "Lời thề tự do"
  },
  State_57854_WeaponDesc = {
    Text = "Trạng thái@Cô Gái Biển Sâu Bánh và Trà Đỏ"
  },
  State_57864_Name = {
    Text = "Bonus lực lượng được làm mới__\"Chỉ dùng cho phát triển\""
  },
  State_57942_Desc = {
    Text = "Độ hợp nhất hiện tại [Layer]%. Khi độ hợp nhất đạt 100%, quái vật sẽ bắt buộc chuyển sang giai đoạn tiếp theo và sử dụng kỹ năng chuyển giai đoạn mạnh hơn."
  },
  State_57942_Name = {
    Text = "Độ hợp nhất"
  },
  State_57952_Desc = {
    Text = "Khi lực lượng bị giảm, chỉ giảm 50% lớp lực lượng."
  },
  State_57952_Name = {Text = "Lặn sâu"},
  State_57953_Desc = {
    Text = "Khi lượt kết thúc, triệu hồi 1 râu chạm. Sau khi thức tỉnh, loại bỏ trạng thái này."
  },
  State_57953_Name = {Text = "Ngủ"},
  State_57955_Desc = {
    Text = "Thương gây ra bởi Hiro tăng [StateArg1]%, kéo dài [Layer] lượt."
  },
  State_57955_Name = {
    Text = "Sinh tồn trong tuyệt cảnh·Thương"
  },
  State_57968_Desc = {
    Text = "Dưới ảnh hưởng của Yu Li-ét, sau mỗi lượt, độ hợp nhất của Song Sinh tăng 10% và 1 lá \"Quái Dị\"được trộn vào rút bài từ bộ bài."
  },
  State_57968_Name = {
    Text = "\"Khúc ca của Yu Li-ét\""
  },
  State_57970_Name = {
    Text = "Sự che chở của Thần Mẫu"
  },
  State_57976_Desc = {
    Text = "\"Con của Bóng tối\" sau khi thực hiện Fusion ép buộc, gây ra <FixedDamage:Sát Thương Thuần Túy> bằng 3 lần sinh lực hiện tại của bản thân đối với \"Khởi Đầu Của Lãng Quên\"."
  },
  State_57976_Name = {Text = "Hy sinh"},
  State_58051_Desc = {
    Text = "Thương harming chí mạng +[Layer]%."
  },
  State_58051_Name = {
    Text = "Sát thương chí mạng"
  },
  State_58052_Desc = {
    Text = "Mỗi lần tiêu thụ 1 điểm dấu đen trong quá trình khám phá, sẽ làm tăng thương cơ bản của \"Cược điên cuồng\" lên 0.5%.(Đã tăng [DescArg1]%)"
  },
  State_58052_Name = {
    Text = "Không có rủi ro lỗ"
  },
  State_58061_Name = {
    Text = "Trả lại tiền nhặt được"
  },
  State_58063_Desc = {
    Text = "Thiệt hại gây ra từ thân thể được đánh thức tăng 25%, kéo dài [Layer] lượt."
  },
  State_58063_Name = {
    Text = "Một ánh nhìn vượt qua vạn cổ"
  },
  State_58144_Desc = {
    Text = "Bản cập nhật này tăng tỷ lệ chí mạng trong [Layer] %."
  },
  State_58144_Name = {
    Text = "Tỷ lệ chí mạng vĩnh viễn"
  },
  State_58144_WeaponDesc = {
    Text = "Bản cập nhật này tăng tỷ lệ chí mạng trong [Layer] %."
  },
  State_58259_Desc = {
    Text = "Đội duy nhất: Tỉ lệ chí mạng của người trang bị tăng <WeaponEffect_Num:[StateArg1]%. Người trang bị sau khi giết kẻ địch sẽ nhận được <WeaponEffect_Num:[StateArg2]> dấu đen, có thể kích hoạt tối đa 3 lần trong cuộc thám hiểm. Sau khi kích hoạt 3 lần, tỉ lệ chí mạng của người trang bị sẽ vĩnh viễn tăng <WeaponEffect_Num:[StateArg3]%> trong cuộc thám hiểm này."
  },
  State_58259_WeaponDesc = {
    Text = "Tỉ lệ chí mạng của người trang bị tăng <WeaponEffect_Num:[StateArg1]%>. Sau khi người trang bị giết kẻ thù, nhận được <WeaponEffect_Num:[DescArg2]> điểm dấu đen, có thể kích hoạt tối đa 3 lần trong cuộc thám hiểm ([DescArg1]/3). Sau khi kích hoạt 3 lần, tỉ lệ chí mạng của người trang bị sẽ tăng vĩnh viễn <WeaponEffect_Num:[StateArg3]%> trong lần khám phá này."
  },
  State_58297_Desc = {
    Text = "Lắc giết kẻ thù sẽ nhận được [DescArg3] dấu đen, mỗi trận khám phá tối đa có hiệu lực 5 lần.([DescArg1]/5)\nThông qua chiến đấu nhận được 50/125/250 dấu đen, giới hạn sáng tạo sẽ tăng lên 1, vào cuối trận chiến chọn một \"Di sản của Hỗn loạn\"để thêm vào danh sách sáng tạo.(Đã nhận [DescArg2] điểm dấu đen)"
  },
  State_58297_Name = {
    Text = "Người thắng ăn hết"
  },
  State_58447_Desc = {
    Text = "Bao gồm ba sáng tạo sau: \n \"Áo gió may mắn\": Tăng tỷ lệ chí mạng của tất cả các thân thể được đánh thức lên 10%. Kết quả ngẫu nhiên của tất cả các Lắc và xúc xắc không bao giờ là giá trị nhỏ nhất. \n<TentacleInjurieIconKeywords:nâng cấp>: Tăng tỷ lệ chí mạng lên 15%, làm tăng giá trị tối đa của kết quả ngẫu nhiên lên 1. \n \"Xúc xắc bí phương\": Mỗi khi sử dụng lệnh khóa, thêm 1 lá \"<C05_yansheng1:Xúc xắc bí phương>\" vào tay. \n<TentacleInjurieIconKeywords:nâng cấp>: Thay đổi thành thêm 1 lá \"<C05_yansheng2:Xúc xắc bí phương lấp lánh>\" vào tay. \n \"Nút áo miệng lớn\": Khi bắt đầu lượt và khi hiệu ứng ngẫu nhiên của Lắc hoặc xúc xắc được kích hoạt, nhận 50 điểm năng lượng chìa khóa bạc và 2% thương harming chí mạng, tối đa 30% thương harming chí mạng. \n<TentacleInjurieIconKeywords:nâng cấp>: Thay đổi thành nhận 100 điểm năng lượng chìa khóa bạc và 4% thương harming chí mạng, tối đa 50% thương harming chí mạng."
  },
  State_58447_Name = {
    Text = "<CardKeyWord:Di sản của sự hỗn loạn>"
  },
  State_58490_Desc = {
    Text = "Khi tất cả sự buồn ngủ bị loại bỏ, sẽ phong ấn tất cả thân thể được đánh thức và thẻ bài, đồng thời điều chỉnh ý định của \"Chúa Tể Bàn Trái\" thành \"Uy Quyền Vương Giả\"."
  },
  State_58490_Name = {
    Text = "Cảm giác buồn ngủ"
  },
  State_58491_Desc = {
    Text = "Mỗi khi tung ra thẻ, loại bỏ 1 lớp \"Buồn ngủ\". Vào đầu lượt, khôi phục lại 12 lớp \"Buồn ngủ\"."
  },
  State_58491_Name = {
    Text = "Giận dữ"
  },
  State_58492_Desc = {
    Text = "Thân thể được đánh thức này chưa thức tỉnh… Khi sắp ngã gục sẽ thức tỉnh, hồi phục sức sống và bắt đầu chiến đấu với hình thái thật sự."
  },
  State_58492_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_58493_Desc = {
    Text = "Mỗi khi tung ra thẻ, loại bỏ 1 lớp \"Buồn ngủ\". Vào đầu lượt, khôi phục lại 12 lớp \"Buồn ngủ\"."
  },
  State_58493_Name = {
    Text = "Giận dữ"
  },
  State_58947_Desc = {
    Text = "Bản cập nhật này tăng tỷ lệ chí mạng trong [Layer] %."
  },
  State_59078_Name = {
    Text = ", có thể sử dụng 1 lần"
  },
  State_59079_Name = {
    Text = ", có thể sử dụng 2 lần"
  },
  State_59080_Name = {
    Text = ",có thể sử dụng 3 lần"
  },
  State_59117_Desc = {
    Text = "Thương harming chí mạng +[Layer]%."
  },
  State_59117_Name = {
    Text = "Sát thương chí mạng"
  },
  State_59160_Desc = {
    Text = "Tất cả sát thương, chữa lành và hiệu ứng khiên gây ra tăng 10%, không thể xóa."
  },
  State_59160_Name = {
    Text = "<CardKeyWord:mạnh mẽ>"
  },
  State_59161_Desc = {
    Text = "Hiệu ứng sát thương, chữa lành và khiên gây ra tăng [DescArg1] %, không thể xóa."
  },
  State_59161_Name = {
    Text = "Sự khuếch đại"
  },
  State_59169_Desc = {
    Text = "Tiêu thụ sức tính toán cơ bản của thẻ này sẽ không lớn hơn giới hạn điểm tính toán.__\"Chỉ dùng cho phát triển\""
  },
  State_59169_Name = {
    Text = "Cân bằng__\"Chỉ dùng cho phát triển\""
  },
  State_59173_Name = {
    Text = "Khi dấu hiệu này tồn tại, có nghĩa là đang thực hiện nhiều đòn đánh, sẽ không kích hoạt lại nhiều đòn đánh nữa.__\"Chỉ dùng cho phát triển\""
  },
  State_59208_Desc = {
    Text = "Tất cả sát thương, chữa lành và hiệu ứng khiên gây ra giảm 10%, không thể xóa."
  },
  State_59208_Name = {
    Text = "<WeaknessColour:mạnh mẽ giảm>"
  },
  State_59209_Desc = {
    Text = "Hiệu ứng sát thương, chữa lành và khiên gây ra giảm [DescArg1] %, không thể xóa."
  },
  State_59209_Name = {
    Text = "Khuếch đại ▼"
  },
  State_59423_Desc = {
    Text = "Lắc giết kẻ thù sẽ nhận được 5 dấu đen, mỗi 1% dấu đen rơi ra sẽ làm tăng lượng nhận được lên 1%, mỗi trận khám phá tối đa có hiệu lực 5 lần.\n Sau khi chiến đấu nhận được 50/125/250 dấu đen, giới hạn sáng tạo sẽ tăng lên 1, vào cuối trận chiến chọn một \"Di sản của Hỗn loạn\"để thêm vào danh sách sáng tạo."
  },
  State_59423_Name = {
    Text = "Người thắng ăn hết"
  },
  State_59424_Desc = {
    Text = "Mỗi lần tiêu thụ 1 điểm dấu đen trong quá trình khám phá, sẽ làm tăng thương cơ bản của \"cược bừa bãi\" lên 0.5%."
  },
  State_59424_Name = {
    Text = "Không có rủi ro lỗ"
  },
  State_59439_Desc = {
    Text = "Trạng thái này sử dụng trọng thương nhân khu vực, giả vờ là một khu vực nhân độc lập.__\"Chỉ dùng cho phát triển\""
  },
  State_59439_Name = {
    Text = "Nếu có trạng thái nào đó, sát thương nhận phải sẽ gấp đôi__\"Chỉ dùng cho phát triển\""
  },
  State_59519_Name = {
    Text = "Chọn 1 thẻ lệnh từ bộ bài rút hoặc đống bài bỏ, đưa vào tay và giảm tiêu thụ sức tính toán xuống 0"
  },
  State_59520_Desc = {
    Text = "Sau khi đánh ra, rút 2 thẻ bài và giảm sức tính toán của chúng tương đương với sức tính toán thực tế của thẻ bài khắcăng, mỗi trận chiến chỉ có hiệu lực 1 lần."
  },
  State_59520_Name = {
    Text = "<WhiteQuality:lý của tri thức>"
  },
  State_59521_Name = {
    Text = "Mất 10% sinh lực hiện tại([DescArg1])"
  },
  State_59522_Desc = {
    Text = "Sau khi đánh ra, sẽ bỏ đi tất cả các thẻ bài không phải là thân thể được đánh thức này, nhận được 5 thẻ bài ngẫu nhiên không phải thân thể được đánh thức, mỗi trận chiến chỉ có hiệu lực 1 lần."
  },
  State_59522_Name = {
    Text = "<WhiteQuality:Lý thuyết về niềm vui>"
  },
  State_59525_Name = {
    Text = "Thẻ lệnh tương ứng nhận được 50 điểm điên cuồng từ thân thể được đánh thức"
  },
  State_59526_Desc = {
    Text = "Sau khi đánh ra nhận được 3 bản sao gốc có thêm <RetainIconKeywords:bảo lưu> và <DepleteIconKeywords:tiêu thụ>, mỗi trận chiến chỉ có hiệu lực 1 lần."
  },
  State_59526_Name = {
    Text = "<WhiteQuality:nguyên lý nhân giống>"
  },
  State_59534_Name = {
    Text = "Khi dấu hiệu này tồn tại, thẻ này sẽ bị cấm kích hoạt ảo ảnh.__\"Chỉ dùng cho phát triển\""
  },
  State_59560_Name = {
    Text = "Chọn một thẻ bài đã nhận được ba đại chất thể khắcăng để thêm vào tay"
  },
  State_59671_Desc = {
    Text = "Tất cả các thân thể được đánh thức trong lượt này tăng 15% sát thương cuối cùng."
  },
  State_59671_Name = {
    Text = "Đồng hồ siêu dây"
  },
  State_59673_Name = {
    Text = "Hộp Nhạc Nhỏ"
  },
  State_59678_Desc = {
    Text = "Khi nhặt, mất tất cả các sáng tạo khác, nhận ngẫu nhiên 2 đồ tạo tác vàng."
  },
  State_59878_Desc = {
    Text = "Khi kết thúc lượt, giảm thêm 1 lớp \"Hỗn Mang\" và nhận [StateArg1] <PowerIconKeywords:lực lượng>. Máu của phân thân \"N\"được triệu hồi sau đó tăng 200%, sau khi chết sẽ không làm giảm số lớp \"Hỗn Mang\" của \"N\" và không nhận <PowerIconKeywords:lực lượng>."
  },
  State_59878_Name = {
    Text = "hỗn loạn đến"
  },
  State_59991_Name = {
    Text = ",lá bài này khi đánh ra sẽ tiêu thụ tối đa 5 tầng <EnergyStorageKeywords:chứa lực>"
  },
  State_59993_Name = {
    Text = "Phục hồi 10% sức sống đã mất([DescArg1])"
  },
  State_60000_Desc = {
    Text = "Mỗi khi chịu Sát thương chủ động, nhận 1 lớp <MadnessIconKeywords:điên rồ> tạm thời."
  },
  State_60000_Name = {Text = "Tích nộ"},
  State_60028_Desc = {
    Text = "Vào đầu lượt của người chơi, ngẫu nhiên khiến một lá bài trong tay có sức tính toán tiêu thụ thay đổi thành 3 trong lượt này. Sau khi chết, hiệu ứng này sẽ không còn hiệu lực và làm giảm 1 điểm tiêu thụ sức tính toán của tất cả thẻ bài của kẻ giết chết trong lượt này."
  },
  State_60028_Name = {
    Text = "Lồng điên cuồng"
  },
  State_60044_Name = {
    Text = "Dùng [Layer] lần rồi tiêu thụ"
  },
  State_60083_Desc = {
    Text = "Giảm sát thương nhận vào trong lượt này [Layer] %."
  },
  State_60083_Name = {
    Text = "<ReinforceColour:củng cố>"
  },
  State_60083_WeaponDesc = {
    Text = "Mọi sát thương gây ra bị giảm [DescArg1] %."
  },
  State_60085_Desc = {
    Text = "Khi bắt đầu chiến đấu và bắt đầu lượt, người chơi nhận được lớp củng cố tạm thời, số lượng lớp tăng lên theo mức độ sức sống của người chơi, tối đa là 50 lớp."
  },
  State_60085_Name = {
    Text = "Pupation cuối cùng"
  },
  State_60085_WeaponDesc = {
    Text = "Mọi sát thương gây ra bị giảm [DescArg1] %."
  },
  State_60086_Desc = {
    Text = "Khi bắt đầu trận chiến và đầu mỗi lượt, người chơi nhận được lớp củng cố tạm thời, số lượng lớp tăng theo tỷ lệ sức sống, tối đa 25 lớp."
  },
  State_60086_Name = {Text = "Pupation"},
  State_60086_WeaponDesc = {
    Text = "Mọi sát thương gây ra bị giảm [DescArg1] %."
  },
  State_60087_Desc = {
    Text = "Gây hiệu ứng thương tích nặng trở thành giảm [Layer]% hồi sức sống."
  },
  State_60087_Name = {
    Text = "<Rune_14_High:thương tổn nặng thêm>"
  },
  State_60087_WeaponDesc = {
    Text = "Mọi sát thương gây ra bị giảm [DescArg1] %."
  },
  State_60088_Desc = {
    Text = "Mỗi lớp giảm 1% tất cả sát thương phải chịu."
  },
  State_60088_Name = {
    Text = "<ReinforcePVEKeywords:củng cố>"
  },
  State_60088_WeaponDesc = {
    Text = "Tất cả các lá chắn nhận được sẽ giảm 25%."
  },
  State_60089_Desc = {
    Text = "Giảm tất cả sát thương nhận vào [Layer] %."
  },
  State_60089_Name = {
    Text = "<ReinforceColour:củng cố>"
  },
  State_60089_WeaponDesc = {
    Text = "Mọi sát thương gây ra bị giảm [DescArg1] %."
  },
  State_60106_Desc = {
    Text = "Sau khi bắt đầu lượt, một lá bài ngẫu nhiên trong tay sẽ có sức tính toán tiêu thụ thay đổi thành 3, và sẽ được khôi phục vào cuối lượt."
  },
  State_60106_Name = {
    Text = "Lồng điên cuồng"
  },
  State_60112_Desc = {
    Text = "Trong lượt này, mỗi khi đánh ra một thẻ lệnh, tất cả các thân thể được thức tỉnh sẽ nhận được 1 điểm điên cuồng."
  },
  State_60112_Name = {Text = "Konserto"},
  State_60115_Desc = {
    Text = "Sau khi kích hoạt cơn thịnh nộ bùng phát, giảm 3% độ hòa hợp của Song Sinh."
  },
  State_60115_Name = {Text = "Requiem"},
  State_60118_Desc = {
    Text = "Sát thương, trúng độc và phản công gây ra trong lượt này tăng [Layer]%."
  },
  State_60118_Name = {Text = "Rhapsody"},
  State_60128_Desc = {
    Text = "Trước khi đánh ra, thay đổi chỉ số thẻ"
  },
  State_60128_WeaponDesc = {
    Text = "Trước khi đánh ra, thay đổi chỉ số thẻ"
  },
  State_60129_Desc = {
    Text = "Bạn đánh ra [Layer] thẻ lệnh không phải là thẻ lệnh gốc tiếp theo có tiêu thụ sức tính toán giảm 2."
  },
  State_60129_Name = {Text = "Downbeat"},
  State_60130_Desc = {
    Text = "Khi bạn đánh ra [Layer] thẻ lệnh không phải là thẻ phái sinh kế tiếp, tiêu thụ sức tính toán tăng thêm +2 và áp dụng 2 lần."
  },
  State_60130_Name = {
    Text = "Ghi chú lên"
  },
  State_60148_Desc = {
    Text = "Khi kết thúc lượt, nhận được hiệu ứng khác nhau dựa trên trạng thái: Phóng - Nhận 1 lớp <MadnessIconKeywords:điên rồ> tạm thời. Liễm - Nhận 50 lớp <ReinforcePVEKeywords:củng cố> tạm thời."
  },
  State_60148_Name = {
    Text = "Điều chỉnh tham số"
  },
  State_60150_Desc = {
    Text = "Mỗi khi cảm nhận được người chơi sử dụng Mật lệnh, ngay lập tức chuyển đổi giữa hai hình thái bỏ và thu thập. Khi chuyển sang bỏ, ngay lập tức nhận được [StateArg1] điểm sức mạnh tạm thời. Khi chuyển sang thu thập, ngay lập tức nhận được [StateArg2] điểm lá chắn."
  },
  State_60150_Name = {
    Text = "Cảm ứng chức năng"
  },
  State_60151_Desc = {
    Text = "Thân thể được đánh thức này chưa thức tỉnh… Khi sắp ngã gục sẽ thức tỉnh, hồi phục sức sống và bắt đầu chiến đấu với hình thái thật sự."
  },
  State_60151_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_60154_Desc = {
    Text = "Hiện tại là hình thái - Liễm. Vũ trang cơ giới sẽ nhận được lá chắn và sẵn sàng phòng thủ, và ý định sẽ chủ yếu là phòng thủ."
  },
  State_60154_Name = {
    Text = "Vũ khí cơ giới - Thu thập"
  },
  State_60155_Desc = {
    Text = "Hiện tại là dạng - đặt. Vũ trang cơ giới sẽ nhận được lực lượng và ý định sẽ chủ yếu là tấn công."
  },
  State_60155_Name = {
    Text = "Vũ khí cơ giới - Đặt"
  },
  State_60167_Desc = {
    Text = "Trước khi đánh ra, thay đổi chỉ số thẻ"
  },
  State_60167_WeaponDesc = {
    Text = "Trước khi đánh ra, thay đổi chỉ số thẻ"
  },
  State_60184_Desc = {
    Text = "Mỗi khi đánh ra thẻ bài, \"Mâu thuẫn song sinh\"đều sẽ thay đổi ý định."
  },
  State_60184_Name = {
    Text = "mâu thuẫn"
  },
  State_60187_Desc = {
    Text = "Các trạng thái yếu đuối, mỏng manh và tổn thương nặng gây ra cho người chơi đều là 50%."
  },
  State_60187_Name = {
    Text = "Kết thúc là sự bắt đầu"
  },
  State_60201_Name = {
    Text = "Quái vật trì hoãn lực lượng"
  },
  State_60263_Desc = {
    Text = "Hiệu ứng yếu đuối gây ra sẽ giảm [Layer]% lượng lá chắn tạo ra."
  },
  State_60263_Name = {
    Text = "<Rune_14_High:sâu yếu đuối>"
  },
  State_60264_Desc = {
    Text = "Hiệu ứng chảy máu gây ra sẽ chỉ được loại bỏ tự động 50% khi kết thúc lượt."
  },
  State_60264_Name = {
    Text = "<Rune_14_High: hủy huyết>"
  },
  State_60265_Desc = {
    Text = "Hiệu ứng chảy máu chỉ tự động loại bỏ 50% cuối lượt."
  },
  State_60265_Name = {
    Text = "<BleedingColour: huyết tan>"
  },
  State_60279_Name = {
    Text = "Thẻ này sẽ bị tiêu thụ vào cuối lượt"
  },
  State_60284_Desc = {
    Text = "Khi chiến đấu bắt đầu và khi bắt đầu lượt, nhận được củng cố tạm thời, số lớp nhận được tăng lên khi sức sống càng thấp, tối đa là 50 lớp."
  },
  State_60284_Name = {
    Text = "Bất Phá Kiếm Trận"
  },
  State_60284_WeaponDesc = {
    Text = "Mọi sát thương gây ra bị giảm [DescArg1] %."
  },
  State_60297_Desc = {
    Text = "\"@2\" hiện thân với dáng vẻ giải phóng, sức sống trở thành 3 lần so với ban đầu. Và mỗi lượt đều sẽ đặt câu hỏi cho Người Giữ Gìn, đưa một lá \"Trả lời Tà Vy\" vào tay."
  },
  State_60297_Name = {
    Text = "Pertanyaan Kebenaran"
  },
  State_60297_WeaponDesc = {
    Text = "Bắt đầu lượt tiếp theo nhận được lá chắn bằng với sức sống đã mất trong lượt trước."
  },
  State_60298_Desc = {
    Text = "Lực lượng tồn tại chưa biết vẫn đang ẩn náu dưới hồ đen, sẽ hồi phục hoàn toàn và bắt đầu chiến đấu với tư thế được giải phóng ngay trước khi bị đánh bại."
  },
  State_60298_Name = {Text = "ẩn náu"},
  State_60312_Desc = {
    Text = "Mỗi lượt khi chịu thương tích lũy đạt 10% sức sống, nhận được [Layer] lớp \"củng cố\" tạm thời."
  },
  State_60312_Name = {
    Text = "Khiên Sương Rỗng Rỗng"
  },
  State_60315_Desc = {
    Text = "Sau khi kích hoạt cơn thịnh nộ bùng phát trong lượt này, hồi phục 5% sức sống đã mất ([DescArg1])."
  },
  State_60315_Name = {Text = "Requiem"},
  State_60336_Name = {
    Text = "Đánh ra để nhận 1 điểm sức tính toán và rút 1 lá bài, nhưng lá bài này sẽ bị hao phí"
  },
  State_60339_Name = {
    Text = "Vòng này sau khi sử dụng sẽ nhận được 1 điểm sức tính toán và rút 1 thẻ bài, nhưng thẻ bài này sẽ bị tiêu thụ"
  },
  State_60367_Desc = {
    Text = "Vào đầu lượt của người chơi, ngẫu nhiên làm cho một lá bài trong tay có sức tính toán tiêu thụ thay đổi thành 3 trong lượt này. Sau khi chết, hiệu ứng này sẽ không còn hiệu lực, và giảm 1 điểm tiêu thụ sức tính toán của tất cả các thẻ bài của kẻ giết."
  },
  State_60367_Name = {
    Text = "Lồng điên cuồng"
  },
  State_60386_Desc = {
    Text = "Hiệu ứng bao gồm: gây chảy máu với 150% sát thương, gây trúng độc với 75% sát thương, áp dụng 1 tầng yếu đuối, thêm 1 tầng dễ bị tổn thương, và tạm thời giảm [DescArg1] điểm sức mạnh."
  },
  State_60386_Name = {
    Text = "<MysterydebuffKeywords:hiệu ứng tiêu cực kì diệu>"
  },
  State_60404_Desc = {
    Text = "Sau mỗi lần nhận 1 điểm thương, nhận thêm 2 lớp củng cố tạm thời."
  },
  State_60404_Name = {
    Text = "Biến Dạng Cuối Cùng"
  },
  State_60408_Desc = {
    Text = "Mỗi khi sức sống giảm xuống 33%(còn thiếu [DescArg1] điểm), trong lượt này sẽ không còn chịu thương, và sử dụng \"Quỷ Diện Tước Cắn\"."
  },
  State_60408_Name = {
    Text = "Cắn Mặt Ma"
  },
  State_60409_Desc = {
    Text = "Mỗi khi sức sống giảm xuống 66%(còn thiếu [DescArg1] điểm), trong lượt này sẽ miễn nhiễm với mọi sát thương và kích hoạt \"Sự Biến Đổi Cuối Cùng\"."
  },
  State_60409_Name = {
    Text = "Gương Cuối Cùng"
  },
  State_60429_Name = {
    Text = "Trạng thái@thân thể được đánh thức Hamlin@giai điệu nguyên thủy"
  },
  State_60430_Desc = {
    Text = "Đánh ra thẻ bài có tiêu thụ sức tính toán thực tế và ý định hiển thị nhất quán sẽ tiêu tốn nó và khiến tất cả kẻ địch mất [DescArg1] điểm sức mạnh tạm thời."
  },
  State_60430_Name = {
    Text = "Lệnh Nhạc Điệu"
  },
  State_60431_Name = {
    Text = "Trạng thái@thân thể được đánh thức Hamlin@âm điệu đi lên"
  },
  State_60432_Name = {
    Text = "Trạng thái - thân thể được đánh thức Hamlin - lời tựa linh hồn"
  },
  State_60433_Name = {
    Text = "Trạng thái@thân thể được đánh thức Hamlin@âm điệu giảm dần"
  },
  State_60434_Name = {
    Text = "Trạng thái@thân thể được đánh thức Hamlin@Bản Nhạc Hoài Niệm"
  },
  State_60435_Name = {
    Text = "Trạng thái@thân thể được đánh thức Hamlin@đếm số linh hồn"
  },
  State_60436_Desc = {
    Text = "Khi gây thương mà không bị ngăn cản, sẽ thêm [StateArg1] lá \"thương tích\" vào bộ bài để rút."
  },
  State_60436_Name = {
    Text = "Prélude của linh hồn"
  },
  State_60438_Name = {
    Text = "Trạng thái @thân thể được đánh thức Hamlin@lắng nghe âm thanh đi lên"
  },
  State_60439_Name = {
    Text = "Trạng thái@thân thể được đánh thức Hamlin@giám sát âm thanh tầng dưới"
  },
  State_60440_Name = {
    Text = "Trạng thái@thân thể được đánh thức Hamlin@bản nhạc linh hồn"
  },
  State_60441_Name = {
    Text = "Trạng thái@thân thể được đánh thức Hamlin@lắng nghe giai điệu hoài niệm"
  },
  State_60442_Name = {
    Text = "Trạng thái@thân thể được đánh thức Hamelin@theo dõi âm nhạc nguyên thủy"
  },
  State_60486_Desc = {
    Text = "Khi chiến đấu bắt đầu, tất cả các thân thể được đánh thức giảm một nửa độ điên cuồng."
  },
  State_60486_Name = {
    Text = "Mẹ thần hấp thụ"
  },
  State_60487_Desc = {
    Text = "Thân thể được đánh thức này chưa thức tỉnh… Khi sắp bị đánh ngã sẽ thức tỉnh, máu tối đa tăng 200%, hồi phục sức sống và bắt đầu chiến đấu với hình thái thật sự."
  },
  State_60487_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_60490_Desc = {
    Text = "Sau khi chết, tất cả thân thể được đánh thức nhận 30 điểm điên cuồng."
  },
  State_60490_Name = {
    Text = "Khát vọng sống"
  },
  State_60491_Desc = {
    Text = "Tất cả thân thể được đánh thức giảm 50% trạng thái điên cuồng."
  },
  State_60491_Name = {
    Text = "Lễ nghi của Cây Mẹ"
  },
  State_60493_Desc = {
    Text = "Sau mỗi lần sức sống giảm [Layer] điểm, gọi một thể thức tỉnh mô phỏng. Nếu số lượng thể thức tỉnh mô phỏng trên sân đã đạt 2 cái, thì làm cho tất cả thể thức tỉnh mô phỏng tăng cường sức sống tối đa 50%."
  },
  State_60493_Name = {
    Text = "mẹ sinh thành"
  },
  State_60500_Desc = {
    Text = "Nếu có thân thể được đánh thức, nhận về 50 tầng \"ẩn nấp\"."
  },
  State_60500_Name = {
    Text = "Ẩn trong rừng"
  },
  State_60511_Desc = {
    Text = "Chắc chắn xuất hiện trong bài mở đầu."
  },
  State_60511_Name = {
    Text = "<GuyouKeywords:cố hữu>"
  },
  State_60511_WeaponDesc = {
    Text = "Sau khi đánh, thẻ bài sẽ không vào rác bài và không thể sử dụng lại trong cuộc chiến đấu này."
  },
  State_60522_Desc = {
    Text = "Gây ra hiệu ứng yếu đuối và thương tích nặng được tăng lên 50%."
  },
  State_60522_Name = {
    Text = "Phá diệt"
  },
  State_60523_Desc = {
    Text = "Mỗi tầng tăng thêm 1 lần tấn công, mất một tầng khi nhận thương, mất toàn bộ khi kết thúc lượt."
  },
  State_60523_Name = {
    Text = "cầu nguyện"
  },
  State_60524_Desc = {
    Text = "Chiến đấu bắt đầu và khi bắt đầu lượt, nhận được [Layer] lớp củng cố, tối đa 50 lớp."
  },
  State_60524_Name = {
    Text = "Thánh hóa"
  },
  State_60524_WeaponDesc = {
    Text = "Mọi sát thương gây ra bị giảm [DescArg1] %."
  },
  State_60527_Desc = {
    Text = "Sẽ được tiêu thụ sau khi sử dụng, nhưng sẽ làm giảm sức mạnh tức thời của kẻ địch."
  },
  State_60527_Name = {
    Text = "<CardKeyWord:Vương Quốc Giai Điệu>"
  },
  State_60543_Desc = {
    Text = "Khi kết thúc lượt, nhận 10 tầng \"Huyết Thệ\", \"Huyết Thệ\" sẽ bị loại bỏ 1 tầng khi nhận thương."
  },
  State_60543_Name = {
    Text = "Ngọn lửa của tim đèn"
  },
  State_60554_Name = {
    Text = "<HuihuanbKeywords:âm nhạc vòng quay>"
  },
  State_60558_Name = {
    Text = "<HuihuanbKeywords:âm nhạc vòng quay>"
  },
  State_60562_Desc = {
    Text = "Sau khi được đánh ra, hiệu lực sẽ kích hoạt 2 lần và chuyển thành \"âm nhạc tích tụ\""
  },
  State_60562_Name = {
    Text = "<HuihuanaKeywords:nhạc hồi âm>"
  },
  State_60564_Desc = {
    Text = "Khi sắp bị đánh bại lần đầu tiên, hồi phục sức sống và thay đổi ý định thành \"Tiến Hóa Cuối Cùng\", nhận được lực lượng và củng cố. Khi sắp bị đánh bại lần thứ hai, hồi phục sức sống và thay đổi ý định thành \"Cắn Xé Mặt Quỷ\", gây sát thương cực lớn trong một lần."
  },
  State_60564_Name = {
    Text = "Quỷ bóng tối"
  },
  State_60567_Desc = {
    Text = "Sau khi đánh ra, Hamlin nhận được 3 điểm điên cuồng."
  },
  State_60567_Name = {
    Text = "<XushiAKeywords:xứ thế âm nhạc>"
  },
  State_60568_Name = {
    Text = "<XushiAKeywords:xứ thế âm nhạc>"
  },
  State_60569_Name = {
    Text = "<XushiBKeywords:âm nhạc tích lũy sức mạnh>"
  },
  State_60570_Desc = {
    Text = "Sau khi đánh ra, Hamlin nhận được 3 điểm điên cuồng."
  },
  State_60570_Name = {
    Text = "<XushiBKeywords:âm nhạc tích lũy sức mạnh>"
  },
  State_60571_Name = {
    Text = "<HuihuanaKeywords:nhạc hồi âm>"
  },
  State_60576_Desc = {
    Text = "Vào đầu lượt của người chơi, ngẫu nhiên làm cho một lá bài trên tay có sức tính toán tiêu thụ thay đổi thành 3 trong lượt này. Sau khi chết, hiệu ứng này sẽ không còn hiệu lực, và làm giảm 1 điểm tiêu thụ sức tính toán của tất cả thẻ bài của kẻ giết."
  },
  State_60576_Name = {
    Text = "Lồng điên cuồng"
  },
  State_60578_Desc = {
    Text = "Khi bị thương tổn chí mạng sẽ hồi phục 50% sức sống, miễn dịch thương 1 lượt, ý định trở thành \"phá nhộng\"."
  },
  State_60578_Name = {Text = "Phá kén"},
  State_60592_Desc = {
    Text = "Đội duy nhất: Khi bắt đầu khám phá, Xáo trộn 1 thẻ \"Ánh Sáng Bạc Khóa\" vào rút bài từ bộ bài và gắn thêm <DestructionKeywords:Hủy hoại>. Sau khi kích hoạt Mật lệnh, Sát thương chí mạng của Người trang bị tăng <WeaponEffect_Num:[StateArg1]%>. Khi Người trang bị gây Sát thương chủ động, nhận được Năng lượng chìa khóa bạc bằng <WeaponEffect_Num:[StateArg2]%> lượng Sạc năng lượng chìa khóa bạc của Người trang bị và <WeaponEffect_Num:[StateArg3]%> Tỷ lệ chí mạng tạm thời, tối đa 5 lần mỗi lượt."
  },
  State_60592_WeaponDesc = {
    Text = "Khi bắt đầu khám phá, Xáo trộn 1 thẻ \"Ánh Sáng Bạc Khóa\" vào rút bài từ bộ bài và gắn thêm <DestructionKeywords:Hủy hoại>. Sau khi kích hoạt Mật lệnh, Sát thương chí mạng của Người trang bị tăng <WeaponEffect_Num:[StateArg1]%>. Khi Người trang bị gây Sát thương chủ động, nhận được <WeaponEffect_Num:[DescArg1]> điểm Năng lượng chìa khóa bạc và <WeaponEffect_Num:[StateArg3]%> Tỷ lệ chí mạng tạm thời, tối đa 5 lần mỗi lượt."
  },
  State_60594_Desc = {
    Text = "Đội duy nhất: Sau khi lượt hành động kết thúc, người trang bị nhận được 5 điểm điên cuồng. Sau khi người trang bị giải phóng cơn thịnh nộ bùng phát, tỷ lệ chí mạng, sát thương chí mạng, lá chắn và hồi phục sinh lực của thẻ lệnh tiếp theo được đánh ra trong lượt này tăng <WeaponEffect_Num:[StateArg1]%>."
  },
  State_60594_WeaponDesc = {
    Text = "Sau khi lượt hành động kết thúc, người trang bị nhận được 5 điểm điên cuồng. Sau khi người trang bị phát động cơn thịnh nộ bùng nổ, tỷ lệ chí mạng, sát thương chí mạng, lá chắn và hồi phục sinh lực của thẻ lệnh tiếp theo được đánh trong lượt này tăng <WeaponEffect_Num:[StateArg1]%>."
  },
  State_60898_Desc = {
    Text = "Khi chịu Sát thương chủ động và thương tổn xúc tu, Phong ấn Bùng nổ và tất cả thẻ bài của Thể thức tỉnh tấn công trong 1 lượt, xóa 1 lớp <ResentChainsKeywords:Dây xích oán hận>."
  },
  State_60898_Name = {
    Text = "<ResentChainsKeywords1:Dây xích oán hận>"
  },
  State_60925_Desc = {
    Text = "Khi kết thúc lượt, hồi phục 5% máu đã mất. Mỗi khi người chơi rút được 1 thẻ triệu chứng hoặc thẻ trạng thái, tất cả đồng minh nhận [Layer] điểm lực lượng."
  },
  State_60925_Name = {
    Text = "Đèn lồng máu"
  },
  State_60926_Desc = {
    Text = "Khi kết thúc lượt, nếu sức sống hiện tại dưới 50%, sẽ nhận được [Layer] điểm lực lượng và [StateArg1] lớp rào cản."
  },
  State_60926_Name = {
    Text = "Đàn Thánh Đăng"
  },
  State_60953_Desc = {
    Text = "<PVPWeaponKeywords:Bánh xe định mệnh>: Trước khi \"Bùng nổ cuồng khí\", gây ra cho toàn bộ kẻ địch [StateArg1] lớp <PVPSlowKeywords:Chậm lại>."
  },
  State_60953_Name = {
    Text = "Khúc cầu hồn vĩnh cửu"
  },
  State_60962_Desc = {
    Text = "Trong chiến đấu này, giá trị máu tối đa tăng [Layer]%."
  },
  State_60962_Name = {
    Text = "Tăng cường sức sống"
  },
  State_60964_Desc = {
    Text = "Trong trận chiến này, sát thương tăng thêm [Layer]%."
  },
  State_60964_Name = {
    Text = "Sát thương tăng lên"
  },
  State_61038_Name = {
    Text = "Hamlin Demo"
  },
  State_61050_Desc = {
    Text = "Kích hoạt hiệu ứng \"Nhạc âm\" hoặc chơi \"Giao hưởng của sự hòa hợp\" sau đó, Hamlin nhận được 1% tỉ lệ chí mạng và sát thương chí mạng(hiện tại đã nhận được [DescArg1]%). Hiệu ứng này mỗi khi kích hoạt 10 lần, số lần gây thương của \"Prélude của linh hồn\" và\"Nốt nhạc nguyên thủy\" tăng thêm 1, tối đa tăng 3 lần."
  },
  State_61050_Name = {
    Text = "Rêverie dưới trăng"
  },
  State_61051_Desc = {
    Text = "Kích hoạt hiệu ứng \"Nhạc âm\" hoặc chơi \"Giao hưởng của sự hòa hợp\" sau đó, Hamlin nhận được 1% tỉ lệ chí mạng và sát thương chí mạng. Hiệu ứng này mỗi khi kích hoạt 10 lần, số lần gây thương của \"Prélude của linh hồn\" và\"Nốt nhạc nguyên thủy\" tăng 1, tối đa tăng 3 lần."
  },
  State_61051_Name = {
    Text = "Rêverie dưới trăng"
  },
  State_61056_Desc = {
    Text = "Vòng đầu tiên nhận được 100 điểm lực lượng tạm thời."
  },
  State_61056_Name = {Text = "Hung bạo"},
  State_61084_Desc = {
    Text = "Trong lượt này, đã đánh ra [Layer] lá thẻ: Nếu số học tiêu tốn lớn hơn hoặc bằng 3, nhận 2 điểm số học, nếu không, rút 2 lá thẻ."
  },
  State_61084_Name = {
    Text = "Chương thứ tư"
  },
  State_61085_Desc = {
    Text = "Sức tính toán tiêu thụ - 2, có hiệu lực sau khi đánh 2 lần, đổi thành \"âm nhạc tích thế\""
  },
  State_61085_Name = {
    Text = "<HuihuanbKeywords:âm nhạc vòng quay>"
  },
  State_61089_Desc = {
    Text = "Chơi ra thẻ lệnh tiếp theo có hiệu lực 2 lần."
  },
  State_61089_Name = {
    Text = "Đũa chỉ huy dàn nhạc"
  },
  State_61145_Name = {
    Text = "<BleedingColour: chảy máu>"
  },
  State_61174_Desc = {
    Text = "Không thể nhận lá chắn."
  },
  State_61174_Name = {
    Text = "Gửi đám tàn dư đi an táng"
  },
  State_61180_Desc = {
    Text = "Sát thương cơ bản của Chuỗi Máu·Hiro tăng thêm [DescArg1]% trong trận chiến này."
  },
  State_61180_Name = {
    Text = "Lưỡi dao trả thù"
  },
  State_61185_Desc = {
    Text = "Sẽ làm tăng cường kỹ năng của kẻ địch.Mỗi lần bị thương sẽ mất một lớp."
  },
  State_61185_Name = {
    Text = "Sumpah Darah"
  },
  State_62213_Desc = {
    Text = "Hiệu ứng Suy nhược gây ra chuyển thành giảm [Layer]% Sát thương chủ động và thương tổn xúc tu gây ra."
  },
  State_62213_Name = {
    Text = "<Rune_14_High:yếu đuối tăng>"
  },
  State_62309_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>: Khi trang bị nhận được [StateArg1] <StrongEffectKeywords:Mạnh>. Mỗi khi mất sức sống, nếu sức sống hiện tại dưới [StateArg2]%, nhận được <ReinforceKeywords:Gia cố> và <StrengthenKeywords:tăng cường>."
  },
  State_62309_Name = {
    Text = "Chìm trong màu đỏ thẫm"
  },
  State_62317_Desc = {
    Text = "Miễn dịch với mọi loại thương. Loại bỏ sau khi lượt bắt đầu."
  },
  State_62317_Name = {
    Text = "Hoàn toàn miễn dịch sát thương"
  },
  State_62336_Desc = {
    Text = "Mỗi lần đánh ra 3 thẻ bài (còn lại [Layer] thẻ), rút 1 thẻ bài và ngẫu nhiên đóng băng 1 thẻ lệnh trong tay."
  },
  State_62336_Name = {
    Text = "Sự lạnh lẽo của mùa đông"
  },
  State_62337_Desc = {
    Text = "Mỗi khi đánh ra 3 thẻ bài (còn lại [Layer] thẻ), rút 1 thẻ bài và ngẫu nhiên đóng băng 1 thẻ lệnh trong tay."
  },
  State_62337_Name = {
    Text = "Sự lạnh lẽo của mùa đông"
  },
  State_62338_Desc = {
    Text = "Thẻ này không thể đánh ra và sẽ không bị loại bỏ khi kết thúc lượt. Thân thể được đánh thức của bạn nhận thêm 5 điểm điên cuồng. Sau khi giải phóng cơn thịnh nộ bùng phát, trạng thái đóng băng sẽ được gỡ bỏ."
  },
  State_62338_Name = {
    Text = "<CardKeyWord:đóng băng>"
  },
  State_65332_Desc = {
    Text = "Sau khi chết, tất cả thân thể được đánh thức nhận 30 điểm điên cuồng."
  },
  State_65332_Name = {Text = "Tan chảy"},
  State_65342_Desc = {
    Text = "Sau khi bị đánh bại sẽ phục sinh, tăng thêm 100% máu tối đa và sử dụng \"Sương giá thấu xương\"."
  },
  State_65342_Name = {
    Text = "Sự im lặng"
  },
  State_65346_Desc = {
    Text = "Sau khi chết, khóa 2 thẻ lệnh trong bộ bài trên tay."
  },
  State_65346_Name = {
    Text = "Sương giá"
  },
  State_65358_Desc = {
    Text = "Đội duy nhất: thương cơ bản gây ra bởi người trang bị tăng lên <WeaponEffect_Num:[StateArg1]%>. Trước khi người trang bị sử dụng điên cuồng bùng phát, giới hạn bài tay tạm thời +1, rút 1 lá thẻ lệnh của người trang bị. Nếu giới vực hiện tại là \"thịt máu\", khi người trang bị kích hoạt tiêu thụ, thương harming chí mạng tạm thời tăng lên <WeaponEffect_Num:[StateArg1]%>, tối đa 1 lần mỗi lượt."
  },
  State_65358_WeaponDesc = {
    Text = "Trang bị nâng cao sát thương cơ bản <WeaponEffect_Num:[StateArg1]%>. Trước khi trang bị sử dụng Cơn Thịnh Nộ Bùng Phát, tạm thời tăng giới hạn bài tay lên +1 và rút 1 thẻ lệnh từ trang bị. Nếu giới vực hiện tại là \"Thịt Máu\", khi trang bị kích hoạt Thôn Phệ, sát thương chí mạng tạm thời tăng <WeaponEffect_Num:[StateArg1]%>, tối đa 1 lần mỗi lượt."
  },
  State_65360_Desc = {
    Text = "Đội duy nhất: thương cơ bản gây ra bởi người trang bị được tăng lên <WeaponEffect_Num:[StateArg1]%>. Khi chiến đấu bắt đầu, người trang bị nhận được 25 lớp \"Băng Tuyết\", sau khi người trang bị đánh ra thẻ bài, họ nhận được 2 điểm điên cuồng và loại bỏ 1 lớp. Khi \"Băng Tuyết\" bị loại bỏ hoàn toàn, người trang bị nhận được <WeaponEffect_Num:[StateArg2]%> tỷ lệ chí mạng."
  },
  State_65360_WeaponDesc = {
    Text = "Trang bị tăng sát thương cơ bản <WeaponEffect_Num:[StateArg1]%>. Khi chiến đấu bắt đầu, người trang bị nhận được 25 lớp \"Băng Tuyết\", sau khi người trang bị đánh ra thẻ bài, họ nhận được 2 điểm điên cuồng và loại bỏ 1 lớp. Khi \"Băng Tuyết\" bị loại bỏ hoàn toàn, người trang bị nhận được <WeaponEffect_Num:[StateArg2]%> tỷ lệ chí mạng(còn lại [DescArg1] lớp Băng Tuyết)"
  },
  State_65362_Desc = {
    Text = "Mỗi khi tích lũy nhận [StateArg1] lần thương chủ động (còn lại [Layer] lần), ngẫu nhiên đóng băng 1 thẻ lệnh trong tay."
  },
  State_65362_Name = {
    Text = "Sương trở lại"
  },
  State_65463_Name = {
    Text = "Nhận được 5 điểm ấn đen"
  },
  State_65490_Desc = {
    Text = "Khi kết thúc lượt, nhận [StateArg1] lớp lá chắn sương và [StateArg2] điểm lực lượng."
  },
  State_65490_Name = {
    Text = "Điểm không tuyệt đối"
  },
  State_65497_Name = {
    Text = "Máu Liên · Shiro Thử nghiệm"
  },
  State_65553_Desc = {
    Text = "Khi kết thúc lượt, nhận được lực lượng theo số lượng bài còn lại trong tay, mỗi lá bài nhận được [Layer] điểm."
  },
  State_65553_Name = {
    Text = "Lưỡi Đao Băng Giá"
  },
  State_65557_Desc = {
    Text = "Sau khi nhận thương chí mạng, sẽ hồi phục tất cả sức sống, ý định chuyển hóa thành \"Chân·Thâm Không Chú Mục\", nhận 80 tầng củng cố tạm thời và loại bỏ trạng thái tiêu cực của bản thân cùng trạng thái tích cực của người chơi. Khi kết thúc lượt, bản thân sẽ loại bỏ 20 tầng củng cố."
  },
  State_65557_Name = {
    Text = "Hỗn loạn vĩnh cửu"
  },
  State_65558_Desc = {
    Text = "Sau khi nhận phải thương tổn chí mạng, ý định chuyển thành \"Đôi mắt sâu thẳm\" và nhận được 80 lớp củng cố tạm thời, hồi phục tất cả sức sống, có thể kích hoạt [DescArg1] lần. Khi số lần kích hoạt đã dùng hết, sau khi nhận phải thương tổn chí mạng sẽ giữ lại 1 điểm sức sống và ý định biến thành \"Mắt của vạn giới\". Khi kết thúc lượt, bản thân loại bỏ 20 lớp củng cố."
  },
  State_65558_Name = {Text = "Bụi sao"},
  State_65559_Desc = {
    Text = "Sau khi tất cả đã chết, Tovarva sẽ xuất hiện lại."
  },
  State_65559_Name = {
    Text = "Bản vụn cổ xưa"
  },
  State_65564_Name = {
    Text = "\n<D05EX_Relic:Các thành viên của đoàn khảo sát ngày càng nghi ngờ Hiro, bạn phải đưa ra quyết định trước khi kẻ thù đến gần, để ổn định đội ngũ>"
  },
  State_65565_Name = {
    Text = "\n<D05EX_Relic:bỏ qua sự nghi ngờ của đồng đội, tiếp tục tiến lên>"
  },
  State_65566_Name = {
    Text = "\n<D05EX_Relic:giải thích tình hình với thành viên đoàn khảo sát>"
  },
  State_65567_Name = {
    Text = "\n<D05EX_Relic:Kìm hãm Hiro để tiếp tục bảo vệ các thành viên trong nhóm>"
  },
  State_65568_Name = {
    Text = "\n<D05EX_Relic:khống chế Hiro và sử dụng lực lượng của thân thể được đánh thức để bảo vệ thành viên trong nhóm>"
  },
  State_65585_Desc = {
    Text = "Lá bài này sau khi được đánh sẽ quay về tay người chơi, khắc ấn sẽ mất hiệu lực cho đến khi kết thúc lượt."
  },
  State_65585_Name = {
    Text = "<CardKeyWord:hồi hưởng>"
  },
  State_66305_Desc = {
    Text = "Vào cuối lượt, nhận 1 lớp <ResentChainsKeywords:Dây xích oán hận> tạm thời."
  },
  State_66305_Name = {
    Text = "Khóa từ cổ xưa đến nay"
  },
  State_66306_Desc = {
    Text = "Khi chịu Sát thương chủ động và thương tổn xúc tu, Phong ấn Bùng nổ và tất cả thẻ bài của Thể thức tỉnh tấn công trong 1 lượt, xóa 1 lớp <ResentChainsKeywords:Dây xích oán hận>."
  },
  State_66306_Name = {
    Text = "<ResentChainsKeywords1:Dây xích oán hận>"
  },
  State_66308_Desc = {
    Text = "Sau khi nhận thương tổn chí mạng, khóa sức sống ở mức 1."
  },
  State_66308_Name = {
    Text = "Hỗn loạn vĩnh cửu"
  },
  State_66311_Desc = {
    Text = "Ký ức của những thân thể được đánh thức tràn ra từ mép não bạn, bám rễ và phát triển trong đầu bạn. Dù bạn chặt đứt chúng bao nhiêu lần, dù sự ăn mòn phá hủy chúng bao nhiêu lần, chúng chưa bao giờ rời bỏ."
  },
  State_66311_Name = {
    Text = "Ký ức vỡ"
  },
  State_66313_Desc = {
    Text = "Mỗi lần đánh 1 thẻ lệnh, bỏ đi 1 thẻ bài có sức tính toán tiêu thụ thấp nhất của thân thể được đánh thức."
  },
  State_66313_Name = {
    Text = "Áp lực của ý chí vô thượng"
  },
  State_66314_Desc = {
    Text = "Miễn nhiễm mọi sát thương."
  },
  State_66314_Name = {
    Text = "Hoàn toàn miễn dịch sát thương"
  },
  State_66317_Desc = {
    Text = "Ký ức của những thân thể được đánh thức tràn ra từ mép não bạn, bám rễ và phát triển trong đầu bạn. Dù bạn chặt đứt chúng bao nhiêu lần, dù sự rỗng rỗng phá hủy chúng bao nhiêu lần, chúng chưa bao giờ rời bỏ. Vào đầu mỗi lượt, hồi phục 1 điểm giới hạn tính toán và 2 điểm kích thước tay tối đa."
  },
  State_66317_Name = {
    Text = "Phân mảnh ký ức"
  },
  State_66325_Desc = {
    Text = "Ký ức của những thân thể được đánh thức tràn ra từ mép não bạn, bám rễ và phát triển trong đầu bạn. Dù bạn chặt đứt chúng bao nhiêu lần, dù sự ăn mòn phá hủy chúng bao nhiêu lần, chúng chưa bao giờ rời bỏ. Vào đầu mỗi lượt, hồi phục 1 điểm giới hạn sức tính toán và 2 điểm kích thước tay tối đa."
  },
  State_66325_Name = {
    Text = "Phân mảnh ký ức"
  },
  State_66358_Desc = {
    Text = "Khi lần đầu tiên kích hoạt kháng cự tử vong trong quá trình khám phá, sẽ đặt một lá \"<DerivativeCardKeywords_39:tiếng vọng quá khứ>\" vào tay."
  },
  State_66358_Name = {
    Text = "Sự tồn tại không tồn tại"
  },
  State_66359_Desc = {
    Text = "Sinh ngẫu nhiên một số tùy chọn để lựa chọn."
  },
  State_66359_Name = {
    Text = "<FaxianKeywords:phát hiện>"
  },
  State_66360_Desc = {
    Text = "Tỷ lệ chí mạng trong cuộc chiến đấu này tăng [Layer] %."
  },
  State_66360_Name = {
    Text = "Tỉ lệ chí mạng"
  },
  State_66362_Desc = {
    Text = "Trong trận chiến này, thương harming chí mạng tăng [Layer] %."
  },
  State_66362_Name = {
    Text = "Sát thương chí mạng"
  },
  State_66409_Name = {
    Text = "Sự Phán Quyết của Đại Hành Giả"
  },
  State_66410_Desc = {
    Text = "Trong [DescArg1] lá bài lệnh của Tà Vy được kích hoạt 2 lần."
  },
  State_66410_Name = {
    Text = "Vạn vật quy nhất"
  },
  State_66414_Desc = {
    Text = "Khi đang cầm trên tay, nếu lá bài trên cùng của bộ bài rút là thẻ lệnh, sẽ biến thành bản sao của thẻ lệnh đó."
  },
  State_66414_Name = {
    Text = "Thông hiểu lý vạn vật"
  },
  State_66454_Desc = {
    Text = "Giảm tiêu thụ sức tính toán của thẻ kỹ năng theo số lớp \"ẩn nấp\", tối đa có thể chồng lên 5 lớp, sẽ mất đi 1 lớp sau khi nhận thương hoặc sử dụng kỹ năng."
  },
  State_66454_Name = {Text = "Giấu"},
  State_66456_Desc = {
    Text = "Giảm tiêu thụ sức tính toán của thẻ kỹ năng theo số lớp \"ẩn nấp\", tối đa có thể chồng lên 5 lớp, sẽ mất đi 1 lớp sau khi nhận thương hoặc sử dụng kỹ năng."
  },
  State_66456_Name = {
    Text = "<YinniColour:ẩn nấp>"
  },
  State_66465_Desc = {
    Text = "Sau khi sử dụng điên cuồng bùng phát, chịu thương tương ứng với lớp tương ứng."
  },
  State_66465_Name = {
    Text = "<PVPfengsuoColour:Bộc Phát Phong Tỏa>"
  },
  State_66522_Desc = {
    Text = "Khi bạn đánh lá bài thứ 8, hiệu ứng sẽ kích hoạt 2 lần."
  },
  State_66522_Name = {
    Text = "Rượu của các ngôi sao"
  },
  State_66553_Desc = {
    Text = "Sau khi sử dụng \"đánh kích\" và \"phòng thủ\", đối tượng được đánh thức tương ứng nhận được 35 điên cuồng. Tuy nhiên, tiêu thụ sức tính toán của chúng tăng thêm 1."
  },
  State_66553_Name = {
    Text = "Gương mặt khuyết thiếu"
  },
  State_66554_Desc = {
    Text = "Khi nhặt lên, hãy đặt 1 thẻ <DerivativeCardKeywords_1:「Dư Ảnh Hồi Hưởng」> vào tay."
  },
  State_66554_Name = {
    Text = "thiết bị liên lạc"
  },
  State_66555_Desc = {
    Text = "Sức tính toán tối đa tăng 1."
  },
  State_66555_Name = {
    Text = "bơm tiêm hoạt tính"
  },
  State_66556_Desc = {
    Text = "Mỗi khi đánh liên tục các lá bài của cùng một thân thể được đánh thức, thân thể được đánh thức đó nhận được 8 điên cuồng."
  },
  State_66556_Name = {
    Text = "Đồng hồ bấm giờ chính xác"
  },
  State_66557_Desc = {
    Text = "Mỗi khi bạn mất sức sống, bạn sẽ nhận được [DescArg1] điểm <PowerIconKeywords:lực lượng>, mỗi trận chiến tối đa 10 lần. Khi số lớp đầy, hồi phục 25% sức sống đã mất."
  },
  State_66557_Name = {
    Text = "Vinh dự tối cao"
  },
  State_66558_Desc = {
    Text = "Mỗi 3 lượt, thêm 1 lớp <WeaknessIconKeywords:yếu đuối> cho tất cả kẻ địch. Sau khi gây thương lên kẻ địch yếu đuối, nhận [DescArg1] <PowerIconKeywords:lực lượng> tạm thời, mỗi lượt tối đa kích hoạt 3 lần."
  },
  State_66558_Name = {
    Text = "ác đồng"
  },
  State_66559_Desc = {
    Text = "Khi đánh 1 thẻ bài có tiêu thụ sức tính toán là 3 hoặc cao hơn, rút 1 thẻ bài, nhận 1 điểm sức tính toán."
  },
  State_66559_Name = {
    Text = "Vẻ đẹp mất mát"
  },
  State_66560_Desc = {
    Text = "\"Đánh\" nhận được 2 điểm sức tính toán, bỏ ngẫu nhiên 1 lá bài; \"Phòng thủ\" rút 2 lá bài, mất 1 điểm sức tính toán. Mỗi lượt tối đa kích hoạt 3 lần."
  },
  State_66560_Name = {
    Text = "đĩa hát vui vẻ"
  },
  State_66561_Desc = {
    Text = "Mỗi 3 lượt, thêm 1 lớp <VulnerabilityIconKeywords:dễ bị tổn thương> cho tất cả kẻ địch. Sau khi gây thương lên kẻ địch có <VulnerabilityIconKeywords:dễ bị tổn thương>, làm mất [DescArg1] điểm <PowerIconKeywords:lực lượng> tạm thời, tối đa 3 lần mỗi lượt."
  },
  State_66561_Name = {
    Text = "Lễ hội mùa xuân"
  },
  State_66562_Desc = {
    Text = "Mỗi 4 lượt, tất cả kẻ địch nhận gấp đôi sát thương trong lượt đó. Tuy nhiên, sau khi kích hoạt điên cuồng, tất cả thân thể được đánh thức sẽ bị phong ấn trong 1 lượt."
  },
  State_66562_Name = {
    Text = "Hài cốt hành trình"
  },
  State_66563_Desc = {
    Text = "Vào đầu vòng, nếu số lượng thẻ bài đã đánh trong vòng trước vượt quá 3, rút 2 thẻ bài."
  },
  State_66563_Name = {
    Text = "Ví mới tinh"
  },
  State_66564_Desc = {
    Text = "Nhặt để nhận 3 điểm sức tính toán."
  },
  State_66564_Name = {
    Text = "đồng hồ bỏ túi"
  },
  State_66565_Desc = {
    Text = "Khi nhặt, áp dụng 1 lượt <WeaknessIconKeywords:yếu đuối>, <VulnerabilityIconKeywords:tăng sát thương> cho tất cả kẻ địch."
  },
  State_66565_Name = {
    Text = "Quần áo giam giữ đổi màu"
  },
  State_66566_Desc = {
    Text = "Mỗi khi bắt đầu lượt, <DeathResistanceIconKeywords:kháng cự tử vong> tăng 10% (trong cấp độ này, mỗi lần kích hoạt kháng cự tử vong sẽ nhận được kháng cự tử vong giảm một nửa). Khi <DeathResistanceIconKeywords:kháng cự tử vong> vượt quá 100%, <ProficientInRealmsIconKeywords:Sự thông thạo giới vực> tăng 100."
  },
  State_66566_Name = {
    Text = "Nước mắt người cá"
  },
  State_66703_Desc = {
    Text = "Đội duy nhất: Giới hạn tích lũy năng lượng chìa khóa bạc tăng 100%. Kích tước tay tối đa +2, không thể cộng dồn với kích tước tay tối đa do vòng mệnh khác cung cấp. Sạc năng lượng chìa khóa bạc của người trang bị tăng <WeaponEffect_Num:[StateArg1]%>. Sau khi người trang bị chơi thẻ bài, tỷ lệ chí mạng và sát thương chí mạng của thẻ lệnh người trang bị, lá chắn, điên cuồng và hiệu quả nhận lực lượng tăng <WeaponEffect_Num:[StateArg2]%>, tối đa cộng dồn 5 lớp."
  },
  State_66703_WeaponDesc = {
    Text = "Giới hạn tích lũy năng lượng chìa khóa bạc tăng 100%. Kích thước tay tối đa +2, không thể chồng chất với kích thước tay tối đa do vòng mệnh khác cung cấp. Sạc năng lượng chìa khóa bạc của người trang bị tăng <WeaponEffect_Num:[DescArg2]>. Sau khi người trang bị đánh ra thẻ bài, tỉ lệ chí mạng và sát thương chí mạng, lá chắn, điên cuồng và lực lượng trong lượt này của người trang bị tăng <WeaponEffect_Num:[StateArg2]%>, tối đa có thể chồng chất 5 tầng (hiện tại [DescArg1] tầng)."
  },
  State_66722_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>: Khi trang bị và khi bắt đầu lượt, nếu bản thân không có <PVPProtectiveKeywords:rào cản> thì nhận [StateArg1] lớp <PVPProtectiveKeywords:rào cản>, nếu không thì nhận <StrengthenKeywords:tăng cường>."
  },
  State_66722_Name = {
    Text = "Vòng quay vô định"
  },
  State_66872_Desc = {
    Text = "Thương, lá chắn và hồi sức sống tạm thời của Tà Vy tăng [StateArg1]%, kéo dài [Layer] lượt."
  },
  State_66872_Name = {
    Text = "Sáng chói vô tận của tỷ triệu"
  },
  State_66884_Desc = {
    Text = "Khi kết thúc lượt, sức tính toán tiêu thụ giảm, và hiệu ứng này cũng sẽ được kích hoạt khi bị loại bỏ."
  },
  State_66884_Name = {
    Text = "<PrepareKeypvewords:chuẩn bị 1>"
  },
  State_66888_Desc = {
    Text = "Đội duy nhất: Sau khi giải phóng Mật lệnh, nhận được <WeaponEffect_Num:[StateArg1]%> sức tấn công <PowerIconKeywords:lực lượng> và lá chắn <WeaponEffect_Num:[StateArg2]%> phòng thủ. Sau khi sử dụng Thân thể Linh tri thức khẩn cấp, vào cuối lượt, tất cả thể thức tỉnh nhận được <WeaponEffect_Num:[StateArg3]> điểm điên cuồng."
  },
  State_66888_Name = {
    Text = "Trái tim bạc"
  },
  State_66888_WeaponDesc = {
    Text = "Sau khi giải phóng lệnh khóa, nhận được <WeaponEffect_Num:[Power:DescArg1]> điểm <PowerIconKeywords:lực lượng> và <WeaponEffect_Num:[Block:DescArg2]> điểm lá chắn. Sau khi sử dụng thân thể linh tri thức khẩn cấp, vào cuối lượt, tất cả các thể thức tỉnh nhận được <WeaponEffect_Num:[StateArg3]> điểm điên cuồng."
  },
  State_66893_Desc = {
    Text = "Đội duy nhất: Sau khi chiến đấu bắt đầu, nhận được năng lượng chìa khóa bạc tương đương với <WeaponEffect_Num:[StateArg1]%> sạc năng lượng chìa khóa bạc của người trang bị. Trong mỗi trận chiến, sau khi sử dụng lệnh khóa lần đầu tiên, hiệu ứng này sẽ lặp lại một lần."
  },
  State_66893_WeaponDesc = {
    Text = "Sau khi chiến đấu bắt đầu, nhận được <WeaponEffect_Num:[DescArg1]> điểm năng lượng chìa khóa bạc. Trong mỗi trận chiến, sau khi sử dụng lệnh khóa lần đầu tiên, hiệu ứng này sẽ lặp lại một lần."
  },
  State_66896_WeaponDesc = {
    Text = "Trước khi đánh ra, thay đổi chỉ số thẻ"
  },
  State_66900_Desc = {
    Text = "Thẻ bài này tăng thương, chữa trị và lá chắn [StateArg1]%"
  },
  State_66900_Name = {
    Text = "Trái tim bạc"
  },
  State_66901_Desc = {
    Text = "Hiệu ứng sát thương, chữa lành và khiên gây ra tăng [DescArg1] %, kéo dài 1 lượt"
  },
  State_66901_Name = {
    Text = "Hiệu lực tạm thời"
  },
  State_66902_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>: Sau khi thân thể được đánh thức của các đồng minh khác chết, nhận được <Block:[Block:StateArg1]> lá chắn, đặt \"kỹ năng\" có chi phí sức tính toán thấp nhất của nó vào tay bạn."
  },
  State_66902_Name = {
    Text = "Trái tim bạc"
  },
  State_66971_Desc = {
    Text = "Khi sức sống giảm xuống 0, làm cho sức sống trở thành 1 điểm, sẽ không bị thương thêm nữa."
  },
  State_66971_Name = {
    Text = "Thế giới đứt đoạn"
  },
  State_67234_Desc = {
    Text = "Khi kết thúc lượt, gọi một \"phân thân não trong bình\", kéo dài [Layer] lượt."
  },
  State_67234_Name = {Text = "Phân li"},
  State_67235_Desc = {
    Text = "Khi chết hồi phục tất cả sức sống, giới hạn sức sống +100%, phát động \"linh hồndịch bệnh\"."
  },
  State_67235_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_67237_Desc = {
    Text = "Đạt đến tầng 10, ý định thay đổi thành \"Hư Vô Kết Thúc\": Giảm giới hạn sức sống của đối thủ xuống còn 1."
  },
  State_67237_Name = {
    Text = "Cuối cùng"
  },
  State_67238_Desc = {
    Text = "Khi kết thúc lượt, nhận 1 lớp \"Cuối Cùng\". Sau khi chịu sát thương chí mạng, loại bỏ trạng thái này và miễn dịch sát thương trong 1 lượt, hồi 15% sức sống và nhận 10 lớp \"Cuối Cùng\"."
  },
  State_67238_Name = {
    Text = "Dịch hồn"
  },
  State_67240_Desc = {
    Text = "\"Người thông thái\" nhận được 25 tầng tạm thời<ReinforcePVEKeywords:củng cố> và [Power:StateArg1] điểm tạm thời<PowerIconKeywords:lực lượng>, loại bỏ trạng thái này."
  },
  State_67240_Name = {
    Text = "<TuiyanColour:suy luận>"
  },
  State_67241_Desc = {
    Text = "Khi chết hồi phục tất cả sức sống, giới hạn sức sống +100%, phát động \"Hiệp sĩ Nhiệt thành\"."
  },
  State_67241_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_67242_Desc = {
    Text = "Khi chết hồi phục tất cả sức sống, giới hạn sức sống +100%, phát động \"linh nhục@1 phút\"."
  },
  State_67242_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_67243_Desc = {
    Text = "Khi kết thúc lượt, gọi một \"Phân thể Não trong Bình\". Khi Phân thể Não trong Bình kích hoạt \"Tách Rời Linh Trí\", đánh cắp thêm 5% lực lượng của người chơi."
  },
  State_67243_Name = {
    Text = "linh hồn và thịt@1 điểm"
  },
  State_67245_Desc = {
    Text = "Vào cuối lượt, nhận được [StateArg1] điểm <PowerIconKeywords:lực lượng>."
  },
  State_67245_Name = {
    Text = "Đam mê hiệp sĩ"
  },
  State_67246_Desc = {
    Text = "Mỗi lượt, khi bị phá lá chắn lần đầu tiên, mất 25% máu tối đa, nhận được [Power:DescArg1] điểm <PowerIconKeywords:sức mạnh tạm thời> và [Layer] lớp củng cố tạm thời. Vào đầu lượt tiếp theo, tái tạo lại <Block:[Block:DescArg2]> lớp lá chắn, mỗi lần kích hoạt \"Niềm Tin Kỵ Sĩ\" sẽ nhận thêm 1 lớp lá chắn."
  },
  State_67246_Name = {
    Text = "Niềm tin của Hiệp sĩ"
  },
  State_67247_Desc = {
    Text = "Mỗi lượt kết thúc, quân địch sẽ được bổ sung, tối đa 2 quân địch tồn tại cùng lúc. Khi quân địch chết, \"Não Bị Phân Huỷ\" mất 5% máu tối đa."
  },
  State_67247_Name = {
    Text = "Cổng Hố Sâu"
  },
  State_67252_Desc = {
    Text = "Khi bị thương tổn chí mạng, di chuyển đến hàng sau và giữ lại 1 điểm sức sống, sau đó không thể bị thương thêm, <PowerIconKeywords:lực lượng> tăng [DescArg1]. Tự nổ không kích hoạt hiệu ứng này."
  },
  State_67252_Name = {
    Text = "Phân li esen"
  },
  State_67253_Desc = {
    Text = "Đánh ra [Layer] thẻ bài sau, tạo ra 1 \"não trong bình phân thân\"ở phía trước, tối đa có thể tồn tại cùng lúc 3 phân thân."
  },
  State_67253_Name = {
    Text = "não trong bình"
  },
  State_67255_Desc = {
    Text = "Khi chết hồi phục tất cả sức sống, tăng giới hạn sức sống lên 100%, kích hoạt \"Đệ nhất triết học\"."
  },
  State_67255_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_67256_Desc = {
    Text = "Sau giai đoạn rút bài, ngẫu nhiên hiển thị ba thẻ lệnh từ thẻ bài trên tay, chọn một thẻ để trao khắcăng \"Hồi Âm\", bỏ đi các thẻ bài còn lại."
  },
  State_67256_Name = {
    Text = "Triết học đầu tiên"
  },
  State_67257_Desc = {
    Text = "Mỗi lượt, sau khi sử dụng lệnh khóa lần đầu tiên, tất cả các thân thể được đánh thức nhận thêm 10 điên cuồng. Tuy nhiên, tiêu thụ khi sử dụng lệnh khóa sẽ tăng vĩnh viễn thêm 10%."
  },
  State_67257_Name = {
    Text = "Liên kết dần dần bị đứt"
  },
  State_67258_Desc = {
    Text = "Khi chiến đấu bắt đầu, nhận được <Block:[Block:DescArg1]> lớp lá chắn. Khi lượt kết thúc, lá chắn không biến mất."
  },
  State_67258_Name = {
    Text = "Quyết tâm của Hiệp sĩ"
  },
  State_67347_Desc = {
    Text = "Khi ở trong bộ bài trên tay, nếu lá bài trên đỉnh rút bài từ bộ bài là thẻ lệnh, nó sẽ trở thành bản sao với tiêu thụ sức tính toán giảm 1."
  },
  State_67347_Name = {
    Text = "Thông hiểu lý vạn vật"
  },
  State_67353_Desc = {
    Text = "Sau khi chết \"Não Thối Rữa\" mất 5% máu tối đa."
  },
  State_67353_Name = {Text = "Tan chảy"},
  State_67358_Desc = {
    Text = "Mỗi khi người chơi tiêu thụ 1 điểm sức tính toán, ngay lập tức nhận được <Block:[Block:StateArg1]> điểm lá chắn và 3 lớp củng cố tạm thời."
  },
  State_67358_Name = {
    Text = "Rào cản không xác định"
  },
  State_67414_Desc = {
    Text = "Mắt không thể nhìn thẳng. Khí tức vô hình. Những phân mảnh làm nên tất cả cũng chỉ là phân mảnh. Bây giờ, hãy đón nhận kết cục hủy diệt đã định…"
  },
  State_67414_Name = {
    Text = "Đối mặt với muôn vàn nguồn gốc"
  },
  State_67418_Desc = {
    Text = "Sau khi đánh ra, sẽ bỏ đi tất cả các thẻ bài không phải là thân thể được đánh thức này, nhận được 5 thẻ bài ngẫu nhiên không phải thân thể được đánh thức, mỗi trận chiến chỉ có hiệu lực 1 lần."
  },
  State_67418_Name = {
    Text = "<WhiteQuality:Niềm vui cao cấp>"
  },
  State_67419_Desc = {
    Text = "Sau khi đánh ra nhận được 3 bản sao gốc có thêm <RetainIconKeywords:bảo lưu> và <DepleteIconKeywords:tiêu thụ>, chúng có sức tính toán -1, mỗi trận chiến chỉ có hiệu lực 1 lần."
  },
  State_67419_Name = {
    Text = "<WhiteQuality:nguyên lý nhân giống nâng cao>"
  },
  State_67420_Desc = {
    Text = "Sau khi đánh ra, rút 4 thẻ bài và giảm sức tính toán của chúng tương ứng với mức tiêu thụ sức tính toán thực tế của thẻ bài khắcăng, mỗi trận chiến chỉ có hiệu lực 1 lần."
  },
  State_67420_Name = {
    Text = "<WhiteQuality:Cao cấp lý của tri thức>"
  },
  State_67598_Desc = {
    Text = "Sau khi phóng thích cơn thịnh nộ bùng phát, một thẻ bài ngẫu nhiên tương ứng với thân thể được đánh thức sẽ được đặt vào tay, thẻ này mang thuộc tính <DepleteIconKeywords:tiêu thụ> và <NothingnessIconKeywords:hư vô>. Sau khi kết thúc trận đấu, hồi phục [DescArg1] điểm sinh lực."
  },
  State_67598_Name = {
    Text = "túi xách bác sĩ"
  },
  State_67599_Desc = {
    Text = "Thẻ lệnh không phải là \"Đánh\" hoặc \"phòng thủ\" khi chơi sẽ giúp thể thức tỉnh tương ứng nhận được 15 điểm điên cuồng, mỗi lượt tối đa kích hoạt 5 lần. Lần kích hoạt đầu tiên trong mỗi lượt, thẻ bài đã chơi sẽ được đưa trở lại tay."
  },
  State_67599_Name = {
    Text = "bàn lắc thời linh·Đạn bắn"
  },
  State_67600_Desc = {
    Text = "Sức tính toán tối đa tăng 4, mỗi lần đặt lại bộ bài sẽ thêm 4 lá <DerivativeCardKeywords_4:「cảm hứng」> vào rút bài từ bộ bài."
  },
  State_67600_Name = {
    Text = "Được chúc·Nến đen"
  },
  State_67602_Name = {Text = "Bỏ đi"},
  State_67603_Desc = {
    Text = "Thương gây ra cho kẻ địch đang trong trạng thái tiêu cực tăng 20%, sau khi giết kẻ địch, người giết sẽ nhận được 20 điên cuồng."
  },
  State_67603_Name = {
    Text = "Gậy của linh mục"
  },
  State_67604_Desc = {
    Text = "Mỗi khi đánh ra một thẻ lệnh thuộc thân thể được đánh thức khác với thẻ lệnh trước đó, thân thể được đánh thức đó sẽ nhận được 3 điểm điên cuồng và tích lũy 1 lớp \"hoạt tính\". Khi tích lũy đủ 10 lớp, tất cả các lớp \"hoạt tính\" sẽ bị xóa, và mỗi thân thể được đánh thức sẽ đưa vào tay một thẻ lệnh ngẫu nhiên có sức tính toán giảm 1 và mang thuộc tính \"tiêu thụ\". Hiệu ứng này chỉ có thể kích hoạt tối đa 1 lần mỗi lượt."
  },
  State_67604_Name = {
    Text = "bàn lắc thời linh·Diễn hóa"
  },
  State_67605_Desc = {
    Text = "Khi bạn có lá chắn, vật phẩm này cung cấp [DescArg1] điểm <PowerIconKeywords:lực lượng> tạm thời. Khi lá chắn của bạn cao hơn sức sống hiện tại, thêm vào [DescArg2] điểm <PowerIconKeywords:lực lượng> tạm thời."
  },
  State_67605_Name = {
    Text = "Quạt lông bồ câu"
  },
  State_67606_Desc = {
    Text = "Mỗi khi bắt đầu lượt, nhận được 1 sức tính toán cho mỗi kẻ địch. Khi tiêu diệt kẻ địch bằng sát thương chủ động, gây <BleedingIconKeywords:chảy máu> tương đương với sát thương vượt mức cho các kẻ địch khác."
  },
  State_67606_Name = {
    Text = "Bài hát của đám đông"
  },
  State_67607_Desc = {
    Text = "Sau mỗi 5 lần cơn thịnh nộ bùng phát, thân thể được đánh thức sẽ nhận thêm 100 điểm điên cuồng."
  },
  State_67607_Name = {
    Text = "Bé nhỏ trong khăn bọc"
  },
  State_67608_Name = {Text = "Bỏ đi"},
  State_67609_Desc = {
    Text = "Sau khi kích hoạt cơn điên cuồng bùng phát, mất 8% sức sống hiện tại, trộm cắp [DescArg1] điểm <PowerIconKeywords:lực lượng> tạm thời từ tất cả kẻ địch. Nếu chỉ có 1 kẻ địch, đánh cắp thêm [DescArg2] điểm <PowerIconKeywords:lực lượng> tạm thời."
  },
  State_67609_Name = {
    Text = "Chim nghi lễ xui xẻo"
  },
  State_67611_Desc = {
    Text = "Mỗi 2 lượt, tăng gấp đôi sát thương mà tất cả kẻ địch phải chịu. Trong lượt này, mỗi lần kích hoạt cơn thịnh nộ bùng phát, ngẫu nhiên loại bỏ 1 trạng thái tiêu cực."
  },
  State_67611_Name = {
    Text = "Thân thể được chúc phúc·Hành đạo"
  },
  State_67612_Desc = {
    Text = "Tất cả 「tấn công」 gây ra tăng 20% thương harming chí mạng. Khi nhặt, thêm 1 lá <DerivativeCardKeywords_40:「khoảnh khắc đẹp」> vào tay."
  },
  State_67612_Name = {
    Text = "Khoảnh khắc đẹp β"
  },
  State_67614_Desc = {
    Text = "Mỗi khi bắt đầu lượt, tất cả các thân thể được đánh thức nhận được 25 điểm điên cuồng. Sau khi nhặt lên, sức sống tối đa tăng lên 1.5 lần."
  },
  State_67614_Name = {
    Text = "Được ban phước·Biểu tượng Ác mộng β"
  },
  State_67615_Desc = {
    Text = "Mỗi lần đánh ra thẻ lệnh thứ 6 sẽ khiến nó trở lại từ rác bài về tay bạn."
  },
  State_67615_Name = {
    Text = "Trong ánh hoàng hôn"
  },
  State_67616_Name = {Text = "Bỏ đi"},
  State_67618_Desc = {
    Text = "Mỗi đầu lượt, tất cả các thân thể được đánh thức nhận được 25 điên cuồng. Khi nhặt, sức sống tối đa tăng lên 1.5 lần."
  },
  State_67619_Desc = {
    Text = "Giới hạn thẻ bài trên tay tăng 5. Khi nhặt, đưa số thẻ bài lên tối đa. Bắt đầu lượt, rút thêm 1 thẻ; kết thúc lượt, bỏ tất cả các thẻ triệu chứng và thẻ trạng thái trong tay, giữ lại các thẻ khác."
  },
  State_67619_Name = {
    Text = "Được chúc · Ý thức khắc ghi β"
  },
  State_67620_Desc = {
    Text = "Mỗi lượt sau khi đánh lá bài thứ 3, thêm 1 lá <DerivativeCardKeywords_4:「cảm hứng」> vào rác bài. Mỗi lượt sau khi đánh lá bài thứ 6, nhặt 1 lá <DerivativeCardKeywords_4:「cảm hứng」> từ rác bài và thêm vào tay bài."
  },
  State_67620_Name = {
    Text = "Ánh sáng của văn minh"
  },
  State_67621_Desc = {
    Text = "Sau khi kích hoạt cơn thịnh nộ bùng phát, nhận [DescArg1] điểm sức mạnh tạm thời và trộm cắp [DescArg1] điểm <PowerIconKeywords:lực lượng> tạm thời từ tất cả kẻ địch. Nếu chỉ có 1 kẻ địch, đánh cắp thêm [DescArg2] điểm <PowerIconKeywords:lực lượng> tạm thời."
  },
  State_67621_Name = {
    Text = "Chúc phúc·nghi thức chim xui xẻo"
  },
  State_67622_Desc = {
    Text = "Khi dùng hết điểm sức tính toán cuối cùng, nhận được 2 điểm sức tính toán. Mỗi lượt tối đa kích hoạt 2 lần."
  },
  State_67622_Name = {
    Text = "Máy phân biệt bạc trắng"
  },
  State_67623_Desc = {
    Text = "Nhặt được sau sẽ nhận vĩnh viễn [DescArg1] <PowerIconKeywords:lực lượng>. Mỗi khi gây thương, hồi [DescArg2] điểm sức sống, tối đa 6 lần mỗi lượt."
  },
  State_67623_Name = {
    Text = "Chúc Phúc·Nụ Hôn của Bảy Mang"
  },
  State_67624_Name = {Text = "Bỏ đi"},
  State_67625_Desc = {
    Text = "Mỗi lượt, khi lần đầu tiên đánh thẻ lệnh vào rác bài, giảm tạm thời tiêu thụ sức tính toán của thẻ đó đi 1 và thêm một bản sao tạm thời của thẻ này vào rút bài từ bộ bài."
  },
  State_67625_Name = {
    Text = "Máy hát câm"
  },
  State_67626_Desc = {
    Text = "Sức tính toán tối đa tăng 1. Khi đánh liên tiếp 2 thẻ bài có chi phí tiêu thụ cao hơn thẻ bài trước đó, nhận được 1 sức tính toán."
  },
  State_67626_Name = {
    Text = "Bản ghi Alcana"
  },
  State_67628_Name = {Text = "Bỏ đi"},
  State_67630_Name = {Text = "Bỏ đi"},
  State_67631_Desc = {
    Text = "Tăng sức tính toán lên 2. Mỗi lần reset bộ bài, thêm 1 lá <DerivativeCardKeywords_9:「chập chững」> vào nguồn rút bài."
  },
  State_67631_Name = {Text = "nến đen"},
  State_67632_Name = {Text = "Bỏ đi"},
  State_67634_Desc = {
    Text = "Vào cuối lượt, mỗi thẻ bài chưa sử dụng sẽ khiến tất cả các thân thể được đánh thức nhận được 2 điên cuồng."
  },
  State_67634_Name = {
    Text = "Cân Bất Cân Xứng"
  },
  State_67635_Desc = {
    Text = "Khi nhặt, tất cả các thân thể được đánh thức nhận được 50 điểm điên cuồng, trộn 2 lá <DerivativeCardKeywords_1:「Di ảnh hồi vang」> vào rút bài từ bộ bài."
  },
  State_67635_Name = {
    Text = "Thiết bị liên lạc +β"
  },
  State_67636_Desc = {
    Text = "Tăng thương chí mạng 15%. Thương gây ra cho kẻ địch có lá chắn luôn là chí mạng."
  },
  State_67636_Name = {
    Text = "Nguyên tắc thẩm mỹ"
  },
  State_67637_Desc = {
    Text = "Vào đầu lượt, rút 2 lá bài và nhận 2 điểm sức tính toán. Mỗi khi bạn rút được 1 lá thẻ lệnh hoặc Thức tỉnh linh tri thức, ngẫu nhiên thay đổi tiêu thụ sức tính toán. (0-4)"
  },
  State_67637_Name = {
    Text = "mũ lưỡi trai thuật sĩ"
  },
  State_67638_Desc = {
    Text = "Thương gây ra cho địch trong trạng thái tiêu cực tăng 50%, sau khi tiêu diệt địch, người tiêu diệt nhận được 100 điên cuồng."
  },
  State_67638_Name = {
    Text = "Gậy của linh mục+"
  },
  State_67639_Desc = {
    Text = "Tỷ lệ chí mạng tăng 50%, thương harming chí mạng tăng 100%."
  },
  State_67639_Name = {
    Text = "Được ban phước · móc câu kỳ quái"
  },
  State_67640_Desc = {
    Text = "Tỉ lệ chí mạng và sát thương chí mạng tăng 100%. Mỗi lần gây sát thương/thương tổn xúc tu, trong lượt này: tất cả thể thức tỉnh giảm 10% sát thương bạo kích, tối đa giảm 50%. Số lượng ngộ độc và phản công tăng 10%, tối đa tăng 50%."
  },
  State_67640_Name = {
    Text = "bàn lắc thời linh·Shift Surge"
  },
  State_67641_Desc = {
    Text = "Sau khi giải phóng cơn thịnh nộ bùng phát, nhận được tạm thời [DescArg1] điểm <PowerIconKeywords:lực lượng>."
  },
  State_67641_Name = {
    Text = "Khóa nặng"
  },
  State_67643_Desc = {
    Text = "Gây ra sát thương chủ động sẽ nhận được [DescArg1] điểm lá chắn. Khi hồi sức sống, nhận được [DescArg2] điểm <PowerIconKeywords:lực lượng> tạm thời."
  },
  State_67643_Name = {
    Text = "Nhà của chúng tôi"
  },
  State_67645_Desc = {
    Text = "Tỷ lệ chí mạng tăng 10%. Sau lần chí mạng đầu tiên mỗi lượt, tỷ lệ chí mạng tăng thêm 20%. Sau lần chí mạng thứ 3, thương harming chí mạng tăng thêm 50%."
  },
  State_67645_Name = {
    Text = "Lời chúc mừng lễ hội"
  },
  State_67646_Desc = {
    Text = "Khi kết thúc lượt lẻ, nếu còn dư sức tính toán, rút thêm 2 lá bài vào lượt tiếp theo; khi kết thúc lượt chẵn, nếu còn dư bài trong tay, nhận thêm 2 sức tính toán vào lượt tiếp theo."
  },
  State_67646_Name = {
    Text = "Bánh xe Mặt Trời và Mặt Trăng"
  },
  State_67647_Desc = {
    Text = "Mỗi lần bạn đánh ra thẻ lệnh thứ 5, nó sẽ có hiệu lực 2 lần và quay về tay."
  },
  State_67647_Name = {
    Text = "Rượu của Các Vì Sao+"
  },
  State_67649_Desc = {
    Text = "Ẩn ý định quái vật. Mỗi lượt nhận được 1 điểm sức tính toán, rút 1 lá bài."
  },
  State_67649_Name = {
    Text = "Chuông Gió Quỷ Mị"
  },
  State_67650_Desc = {
    Text = "\"Đánh\" và \"Phòng thủ\" nhận thêm 50 điểm năng lượng chìa khóa bạc. Mỗi khi bạn đánh 1 thẻ bài có sức tính toán tiêu thụ là 2 hoặc cao hơn, rút 1 thẻ bài có sức tính toán tiêu thụ là 1 và giảm sức tính toán tiêu thụ của nó xuống 0. Tối đa 3 lần mỗi lượt."
  },
  State_67650_Name = {
    Text = "bàn lắc thời linh·Song sinh"
  },
  State_67651_Desc = {
    Text = "Khi nhặt, sự tinh thông giới vực của đội tăng lên 150% giá trị gốc. Mỗi lượt sau khi dùng thẻ lệnh thứ 5, tất cả thân thể được đánh thức nhận 20 điên cuồng."
  },
  State_67651_Name = {
    Text = "bàn lắc thời linh·Bất tịnh"
  },
  State_67653_Desc = {
    Text = "Mỗi lượt, sau khi có sự bùng nổ điên cuồng 2 lần, tất cả thân thể được đánh thức nhận thêm 8 điểm điên cuồng; sau lần thứ 3, họ lại nhận thêm 8 điểm."
  },
  State_67653_Name = {
    Text = "Máu của những người bị lãng quên"
  },
  State_67654_Name = {
    Text = "Kích hoạt thêm [DescArg1] lần"
  },
  State_67656_Desc = {
    Text = "Tỷ lệ chí mạng tăng 50%, <FragileIconKeywords:mong manh> bản thân 3 lượt."
  },
  State_67656_Name = {
    Text = "Móng vuốt kỳ lạ"
  },
  State_67657_Desc = {
    Text = "Vào đầu lượt, rút 1 thẻ bài. Khi đánh liên tiếp 2 thẻ bài có sức tính toán giống với thẻ bài trước đó, rút thêm 1 thẻ bài, mỗi lượt tối đa có hiệu lực 3 lần."
  },
  State_67657_Name = {
    Text = "Bí Lễ Linh Tri Vạn Tượng"
  },
  State_67658_Desc = {
    Text = "Khi chơi 1 thẻ bài có tiêu thụ sức tính toán thực tế là 3, rút 1 thẻ bài và nhận 2 điểm sức tính toán; Khi chơi 1 thẻ bài có tiêu thụ sức tính toán thực tế là 4 hoặc cao hơn, tiêu thụ sức tính toán của các thẻ bài khác trong tay giảm 1 điểm."
  },
  State_67658_Name = {
    Text = "bàn lắc thời linh·Mắt"
  },
  State_67659_Desc = {
    Text = "Mỗi khi bắt đầu lượt, nhận 2 sức tính toán cho mỗi kẻ địch. Khi tiêu diệt kẻ địch bằng tấn công chủ động, gây <BleedingIconKeywords:chảy máu> với lượng thương vượt quá gấp đôi cho các kẻ địch khác."
  },
  State_67659_Name = {
    Text = "Bài hát của đám đông+"
  },
  State_67660_Desc = {
    Text = "Mỗi lần thứ 3 đánh \"đánh\" sẽ gây [DescArg1] điểm thương cho tất cả địch, và thân thể được thức tỉnh tương ứng nhận được 15 điên cuồng."
  },
  State_67660_Name = {
    Text = "Lưỡi dao lá liễu rỉ sét"
  },
  State_67661_Desc = {
    Text = "Mỗi lần tiêu thụ sức tính toán, rút 1 lá bài, mỗi lượt tối đa 5 lần. Mỗi khi bộ bài được đặt lại, nhận 2 điểm sức tính toán."
  },
  State_67661_Name = {
    Text = "bàn lắc thời linh·Mất ngủ"
  },
  State_67662_Desc = {
    Text = "Mỗi khi bạn đánh một thẻ bài không phải là thân thể được đánh thức, thân thể được đánh thức có lượng điên cuồng thấp nhất sẽ nhận thêm 10 điểm điên cuồng."
  },
  State_67662_Name = {
    Text = "Bìa dán tem lạ"
  },
  State_67665_Desc = {
    Text = "Sức tính toán tối đa tăng 2. Sau khi sử dụng \"Đánh\" hoặc \"Phòng thủ\", thân thể được đánh thức tương ứng nhận được 5 điên cuồng. Sau khi kích hoạt cơn thịnh nộ bùng phát, nhận được 1 thẻ \"Đánh\" từ thân thể được đánh thức kèm tiêu thụ hư vô. Sau khi sử dụng lệnh khóa, ngẫu nhiên nhận được 1 thẻ \"Phòng thủ\" kèm tiêu thụ hư vô."
  },
  State_67665_Name = {
    Text = "bàn lắc thời linh·Cánh"
  },
  State_67666_Desc = {
    Text = "Mỗi lần tạo ra thương, tăng thêm [DescArg1] lượng tạm thời <PowerIconKeywords:lực lượng>, tối đa 3 lần. Khi số lớp đầy, hiệu ứng tăng gấp đôi."
  },
  State_67666_Name = {
    Text = "Agate Filament"
  },
  State_67667_Desc = {
    Text = "Sau khi lượt kết thúc, tất cả thân thể được đánh thức nhận được 5 điên cuồng. Với mỗi điểm sức tính toán còn lại, tất cả thân thể được đánh thức nhận thêm 3 điên cuồng."
  },
  State_67667_Name = {
    Text = "Pin nguyên mẫu"
  },
  State_67668_Desc = {
    Text = "Thương harming chí mạng tăng 15%. \"Đánh\" tỷ lệ chí mạng tăng 40%."
  },
  State_67668_Name = {
    Text = "Mỏ quạ trắng"
  },
  State_67669_Name = {Text = "Bỏ đi"},
  State_67670_Desc = {
    Text = "Sau khi cơn thịnh nộ bùng phát, rút 1 lá bài.Nếu sức sống dưới 25%,rút thêm 1 lá bài."
  },
  State_67670_Name = {
    Text = "Vòng Đọc Sách Tìm Kiến Thức"
  },
  State_67671_Desc = {
    Text = "Mỗi lần gây 1 lần sát thương chủ động, khôi phục [DescArg1] sức sống và gây [DescArg2] lớp <BleedingIconKeywords:chảy máu> lên mục tiêu."
  },
  State_67671_Name = {
    Text = "Được phù hộ·ý thức bầy đàn"
  },
  State_67672_Desc = {
    Text = "Gây hiệu ứng <WeaknessIconKeywords:suy nhược> tăng lên 8%, hiệu ứng <VulnerabilityIconKeywords:trọng thương> tăng lên 25%. Khi áp đặt <WeaknessIconKeywords:suy nhược> hoặc <VulnerabilityIconKeywords:trọng thương>, tạm thời trộm cắp [DescArg1] điểm <PowerIconKeywords:lực lượng> của mục tiêu."
  },
  State_67672_Name = {
    Text = "Ảnh phai màu+"
  },
  State_67673_Desc = {
    Text = "Vào đầu lượt, rút 1 lá bài."
  },
  State_67673_Name = {
    Text = "Kompas định hướng"
  },
  State_67674_Desc = {
    Text = "Mỗi khi chơi 1 thẻ lệnh, nhận được [DescArg2]% <DeathResistanceIconKeywords:kháng cự tử vong> (mỗi lần kích hoạt kháng cự tử vong trong màn chơi này, kháng cự tử vong nhận được sẽ giảm một nửa). Nếu kháng cự tử vong của bạn lớn hơn hoặc bằng 100%, sẽ đổi thành nhận được [DescArg1] điểm tạm thời <PowerIconKeywords:lực lượng>."
  },
  State_67674_Name = {
    Text = "Vảy rắn quái vật"
  },
  State_67675_Desc = {
    Text = "Khi kết thúc lượt, nếu còn dư sức tính toán, lượt tiếp theo sẽ rút thêm 2 lá bài, nếu còn dư bài trong tay, lượt tiếp theo sẽ nhận thêm 2 điểm sức tính toán."
  },
  State_67675_Name = {
    Text = "Bánh xe Mặt Trời và Mặt Trăng+"
  },
  State_67677_Desc = {
    Text = "Khi bạn gây <WeaknessIconKeywords:suy nhược>, nhận được [DescArg1] điểm lá chắn; khi gây <VulnerabilityIconKeywords:trọng thương>, nhận được [DescArg2] điểm tạm thời <PowerIconKeywords:lực lượng>. Nếu cả hai hiệu ứng này được kích hoạt trong 1 lượt, bạn sẽ nhận thêm [DescArg1] điểm lá chắn và [DescArg2] điểm tạm thời <PowerIconKeywords:lực lượng>."
  },
  State_67677_Name = {
    Text = "Khung tranh nặng"
  },
  State_67703_Desc = {
    Text = "Vào đầu lượt, nếu số lá bài còn lại trong tay của lượt trước vượt quá 3 lá, nhận được 2 sức tính toán."
  },
  State_67703_Name = {
    Text = "Huy hiệu Misa"
  },
  State_67704_Desc = {
    Text = "Sau khi giải phóng cuồng khí bùng phát, thân thể được đánh thức tương ứng nhận 10 cuồng khí và [DescArg1] điểm lá chắn."
  },
  State_67704_Name = {
    Text = "Màn che của thần vô danh"
  },
  State_67796_Name = {
    Text = "<TongxiaoKeywords:thông hiểu vạn vật>: Sau khi đánh ra, phục hồi lại trạng thái, nhận được <Energy:[StateArg1]> điểm năng lượng điên cuồng"
  },
  State_67841_WeaponDesc = {
    Text = "Trước khi đánh ra, thay đổi chỉ số thẻ"
  },
  State_67844_Desc = {
    Text = "Phục hồi tất cả sức sống sau khi bị thương tổn chí mạng, có thể kích hoạt một lần duy nhất, hiện đã kích hoạt [DescArg1] lần."
  },
  State_67844_Name = {
    Text = "Hỗn loạn vĩnh cửu"
  },
  State_67866_Name = {
    Text = "<BleedingColour: chảy máu>"
  },
  State_68298_Desc = {
    Text = "Sau khi chịu thương tổn chí mạng, ý định biến đổi thành \"Chú Mục Sâu Thẳm\" và nhận 80 lớp củng cố tạm thời, hồi phục toàn bộ sức sống, có thể kích hoạt [DescArg1] lần. Kết thúc lượt, loại bỏ 20 lớp củng cố."
  },
  State_68298_Name = {Text = "Bụi sao"},
  State_68554_Desc = {
    Text = "Hồi phục toàn bộ sức sống sau thương tổn chí mạng, loại bỏ trạng thái này khi tất cả kẻ địch khác chết. Có thể kích hoạt @1 lần. Hiện đã kích hoạt [DescArg1] lần."
  },
  State_68554_Name = {
    Text = "Phân mảnh hỗn loạn cổ đại"
  },
  State_68621_Desc = {
    Text = "Khi bắt đầu chiến đấu và vào cuối mỗi lượt, nhận 2 lớp <ResentChainsKeywords:Dây xích oán hận> tạm thời."
  },
  State_68621_Name = {
    Text = "Dòng Chảy Kì Quái"
  },
  State_68622_Desc = {
    Text = "Hiệu ứng của thân thể được đánh thức giảm 75%. Mỗi khi mất sức sống, nhận [DescArg1] điểm lá chắn và 1 tầng củng cố tạm thời."
  },
  State_68622_Name = {
    Text = "Dòng chảy của tà tín"
  },
  State_68623_Desc = {
    Text = "Mỗi lần đánh 1 thẻ lệnh, bỏ đi 1 thẻ bài có sức tính toán tiêu thụ thấp nhất của thân thể được đánh thức."
  },
  State_68623_Name = {
    Text = "Dòng Chảy Điên Rồ"
  },
  State_68624_Desc = {
    Text = "Khi kết thúc lượt, hồi phục 10% sức sống đã mất, giải trừ trạng thái tiêu cực của bản thân và trạng thái tích cực của người chơi khác."
  },
  State_68624_Name = {
    Text = "Dòng chảy của Sự xuất hiện"
  },
  State_68626_Desc = {
    Text = "Tất cả các thân thể được đánh thức có điên cuồng cơ bản tăng 50%. Kết thúc mỗi lượt, trừ đi 10 điểm điên cuồng của tất cả các thân thể được đánh thức, khôi phục 3% máu tối đa cho bản thân."
  },
  State_68626_Name = {
    Text = "Dòng chảy của nỗi sợ"
  },
  State_68627_Desc = {
    Text = "Khi bắt đầu chiến đấu, nhận 15 lớp \"rào cản tạm thời\". Khi kết thúc lượt, nhận 15 lớp \"rào cản tạm thời\", và gắn \"tan rã tạm thời\" lên 10 thẻ bài ngẫu nhiên."
  },
  State_68627_Name = {
    Text = "Dòng Chảy Xuyên Xương"
  },
  State_68632_Desc = {
    Text = "Tất cả các thẻ lệnh tăng tiêu thụ sức tính toán 1. Mỗi 3 lượt, khi kết thúc lượt, thêm 1 thẻ \"Dần Dần Hóa Đá\" vào tay."
  },
  State_68632_Name = {
    Text = "Dòng chảy than khóc"
  },
  State_68635_Name = {
    Text = "\"Lõi Bạc Nguyên Chất· Khủng Bố\""
  },
  State_68637_Desc = {
    Text = "Khi mất sức sống, giảm số tầng tương ứng. Khi số tầng là 0, cho người chơi nhận 2 tầng rào cản tạm thời, bản thân nhận [DescArg1] tầng lá chắn và [DescArg2] tầng củng cố tạm thời, và tái tạo [DescArg3] tầng rào cản chiều."
  },
  State_68637_Name = {
    Text = "Rào cản chiều"
  },
  State_68638_Name = {
    Text = "\"Lõi Bạc Nguyên Chất· Tà Tín\""
  },
  State_68646_Desc = {
    Text = "Sát thương cơ bản và giá trị lá chắn tăng 200％, nhưng sau khi sử dụng sẽ bị tiêu thụ."
  },
  State_68646_Name = {
    Text = "<RedQuality1:hòa tan tạm thời>"
  },
  State_68647_Name = {
    Text = "\"Lõi Thuần Âm·Cuồng Loạn\""
  },
  State_68680_Desc = {
    Text = "Xóa bỏ mảnh vỡ cổ xưa"
  },
  State_68680_Name = {
    Text = "Xóa bỏ mảnh vỡ cổ xưa"
  },
  State_68704_Desc = {
    Text = "Còn [DescArg1] lượt nữa để Toghuvabo thực sự hạ cánh…"
  },
  State_68704_Name = {Text = "đến"},
  State_68829_Desc = {
    Text = "Khi chịu Sát thương chủ động hoặc thương tổn xúc tu, Miễn dịch với sát thương và giảm 1 lớp, bị xóa khi bắt đầu lượt."
  },
  State_68829_Name = {
    Text = "<ParcloseColour: rào cản tạm thời>"
  },
  State_68829_WeaponDesc = {
    Text = "Giảm 99% sát thương phải chịu, mỗi lần chịu 1 lần sát thương giảm 1 lớp."
  },
  State_70026_Desc = {
    Text = "Thẻ bài này có \"Bảo lưu\", sau khi đánh ra, tỷ lệ chí mạng tạm thời của tất cả thân thể được đánh thức tăng [StateArg1]% và loại bỏ \"Bất diệt thống trị\". Nếu giới vực là biển sâu, sau khi loại bỏ \"Bất diệt thống trị\", nhận 1 điểm sức tính toán."
  },
  State_70026_Name = {
    Text = "<OrangeQuality:bất diệt chi phối>"
  },
  State_70031_Desc = {
    Text = "Đội duy nhất: Khi chiến đấu bắt đầu, trao cho tất cả các thẻ lệnh có sức tính toán tiêu thụ lớn hơn hoặc bằng 3 trong rút bài từ bộ bài của người được trang bị hiệu ứng \"Bất Diệt Chi Trị\": Thẻ này có \"Bảo Lưu\". Sau khi đánh ra, tỷ lệ chí mạng tạm thời của tất cả các thân thể được đánh thức tăng <WeaponEffect_Num:[StateArg1]%>. Loại bỏ \"Bất Diệt Chi Trị\". Nếu giới vực hiện tại là biển sâu, sau khi \"Bất Diệt Chi Trị\" bị loại bỏ, nhận 1 điểm sức tính toán."
  },
  State_70031_WeaponDesc = {
    Text = "Khi trận chiến bắt đầu, trao cho tất cả các thẻ lệnh có sức tính toán tiêu thụ lớn hơn hoặc bằng 3 trong rút bài từ bộ bài của người được trang bị hiệu ứng \"Bất Diệt Chi Phủ\": Thẻ này có \"Bảo Lưu\", sau khi đánh ra, tỷ lệ chí mạng tạm thời của tất cả thân thể được đánh thức tăng lên <WeaponEffect_Num:[StateArg1] %>, và loại bỏ \"Bất Diệt Chi Phủ\". Nếu giới vực hiện tại là biển sâu, sau khi \"Bất Diệt Chi Phủ\" bị loại bỏ, nhận 1 điểm sức tính toán."
  },
  State_70182_Desc = {
    Text = "Tất cả các lá chắn nhận được giảm [DescArg1] %."
  },
  State_70182_Name = {
    Text = "<FragileColour:yếu đuối>"
  },
  State_70182_WeaponDesc = {
    Text = "Tất cả các lá chắn nhận được đều giảm 33%."
  },
  State_70277_Desc = {
    Text = "Sau khi chịu Sát thương chủ động hoặc thương tổn xúc tu, sẽ chuyển hóa [StateArg1]% sát thương thành lượng hồi phục cho Lò nung đỏ thẫm, kéo dài [Layer] lượt."
  },
  State_70277_Name = {
    Text = "Lễ Tạo Sinh"
  },
  State_70287_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>:Khi kết thúc lượt, sát thương, chữa lành và khiên từ tất cả \"kỹ năng\" của người trang bị trong bài trên tay tăng [StateArg1]%."
  },
  State_70287_Name = {
    Text = "Ngai đá xanh"
  },
  State_70288_Desc = {
    Text = "Thẻ bài này tăng thương, chữa trị và lá chắn [DescArg1]%."
  },
  State_70288_Name = {
    Text = "Ngai đá xanh"
  },
  State_70313_Desc = {
    Text = "Trong trận chiến với boss, khi bắt đầu lượt và sau khi \"Đóa Dung Hủy\" phát động cơn thịnh nộ bùng phát, nhận 1 lớp \"<Zhongmowuqiling:Hồi Kết>\". \"Hồi Kết\" tối đa có thể có 10 lớp, khi đạt 10 lớp, đặt 1 lá \"Kết Thúc Hư Vô\" vào tay."
  },
  State_70313_Name = {
    Text = "Đường diệt vong"
  },
  State_70318_Desc = {
    Text = "Áp [StateArg1] vòng <VulnerabilityIconKeywords:Trọng thương> lên tất cả kẻ thù, nhận 1 vòng Trạng thái \"Hưng phấn\": Khuếch đại sát thương +[StateArg2]%."
  },
  State_70318_Name = {
    Text = "Hưng phấn"
  },
  State_70322_Desc = {
    Text = "Khi có 10 lớp Hủy Diệt, đặt 1 lá \"Hư Vô Chung Cực\" vào tay."
  },
  State_70322_Name = {
    Text = "Cuối cùng"
  },
  State_70330_Desc = {
    Text = "Nhận Trạng thái \"Hưng phấn\" 1 lượt: Khuếch đại sát thương +[Arg2]%."
  },
  State_70330_Name = {
    Text = "Hưng phấn"
  },
  State_70346_Desc = {
    Text = "Đặt trạng thái [StateArg1] vòng <WeaknessIconKeywords:yếu đuối> cho tất cả kẻ địch, và làm giảm [Exhaustion:StateArg3] điểm <PowerIconKeywords:lực lượng> của chúng trong vòng này."
  },
  State_70346_Name = {
    Text = "lời nguyền"
  },
  State_70347_Desc = {
    Text = "Giảm [Exhaustion:StateArg3] điểm <PowerIconKeywords:lực lượng> cho tất cả kẻ địch trong lượt này."
  },
  State_70347_Name = {
    Text = "lời nguyền"
  },
  State_70374_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>: Mỗi lượt, [StateArg1] lần đầu tiên người trang bị bị tấn công, gây <PVPEmptinessKeywords:Hư vô> lên kẻ tấn công."
  },
  State_70374_Name = {
    Text = "Ma-nơ-canh của miền quên lãng"
  },
  State_70379_Desc = {
    Text = "Gây <PVPEmptinessKeywords:Hư vô> cho kẻ tấn công. Xóa trạng thái này sau khi bị tấn công."
  },
  State_70379_Name = {
    Text = "Phản công Hư vô"
  },
  State_70443_Desc = {
    Text = "Khi có 10 lớp Hủy Diệt, đặt 1 lá \"Hư Vô Chung Cực\" vào tay."
  },
  State_70443_Name = {
    Text = "Cuối cùng"
  },
  State_70539_Name = {
    Text = "Dịch hồn"
  },
  State_70589_Desc = {
    Text = "Khi đánh hai lần liên tiếp lá bài có sức tính toán tiêu thụ thấp hơn lá trước đó, gây 40/80 sát thương trúng độc lên tất cả kẻ địch, mỗi lượt tối đa kích hoạt 5 lần."
  },
  State_70590_Desc = {
    Text = "Mỗi lượt, sau khi sử dụng trực tiếp phôi thai lần đầu tiên, sát thương chủ động trong lượt này gây ra 15/30% chảy máu."
  },
  State_70593_Desc = {
    Text = "Sau khi đánh thẻ lệnh không phải là thẻ phái sinh, giảm 2 điểm tiêu thụ sức tính toán của thẻ đó. Thêm 1/2 bản sao tạm thời của thẻ bài này vào bộ bài rút, hồi chiêu sau 3 lượt."
  },
  State_70594_Desc = {
    Text = "Khi kết thúc lượt, nếu đang ở tư thế Dâng Tràn, nhận 32/64 thương tổn râu chạm, hồi chiêu 3 lượt."
  },
  State_70595_Desc = {
    Text = "Khi bắt đầu chiến đấu, gây 1280 trúng độc cho tất cả kẻ địch, hiệu ứng tăng gấp đôi trong trận chiến với thủ lĩnh."
  },
  State_70598_Desc = {
    Text = "Mỗi khi một thẻ bài đi vào không gian siêu việt, nếu chủ sở hữu của thẻ bài này khác với các thẻ bài trong không gian siêu việt khác, hãy đặt 1/2 thẻ cảm hứng vào tay."
  },
  State_70600_Desc = {
    Text = "Khi kết thúc lượt, hồi phục 32 điểm sức sống ."
  },
  State_70600_Name = {
    Text = "Huyết Ân Tứ"
  },
  State_70602_Desc = {
    Text = "Sử dụng Bạc Khóa Tỉnh Thức để thức tỉnh và rút 4 lá bài."
  },
  State_70603_Desc = {
    Text = "Sau khi sử dụng Bạc Khóa Tỉnh Thức, tất cả thân thể đã thức tỉnh nhận được 10 cuồng khí."
  },
  State_70605_Desc = {
    Text = "Sau khi sử dụng Bạc Khóa Tỉnh Thức, bạn sẽ nhận được 32 lực lượng."
  },
  State_70607_Desc = {
    Text = "Khi đánh 2 thẻ bài liên tiếp có sức tính toán tiêu thụ cao hơn lá bài trước đó, nhận được 24/48 phản công, mỗi lượt tối đa kích hoạt 5 lần."
  },
  State_70609_Desc = {
    Text = "Sử dụng Bạc Khóa Tỉnh Thức và nhận được 96 lá chắn."
  },
  State_70609_Name = {
    Text = "Mẫu bướm"
  },
  State_70611_Desc = {
    Text = "Sau khi sử dụng Bạc Khóa Tỉnh Thức, tăng 25%/50% thương cơ bản của tất cả thân thể được đánh thức."
  },
  State_70614_Name = {
    Text = "Hàm Laser+"
  },
  State_70617_Desc = {
    Text = "Trong mỗi lượt, sát thương của 5 lần gây thương đầu tiên tăng lên 15%/30%."
  },
  State_70618_Desc = {
    Text = "Vào đầu lượt, rút 1 lá bài."
  },
  State_70619_Desc = {
    Text = "\"Đánh\" gây ra hiệu ứng trúng độc tương đương với 10%/20% sát thương, mỗi lượt có thể gây ra tối đa 320/640 điểm."
  },
  State_70620_Desc = {
    Text = "Khi bị địch tấn công, khiến chúng chịu 1 lần <FixedDamage:Sát Thương Thuần Túy> bằng 25%/50% Sinh lực tối đa của đồng minh, sát thương này được hưởng 100%/200% Phản công gia tăng, mỗi địch chỉ có thể bị kích hoạt tối đa 1 lần mỗi lượt."
  },
  State_70620_Name = {
    Text = "Dao Tế Lễ Thất Lạc"
  },
  State_70621_Desc = {
    Text = "Sử dụng Bạc Khóa Tỉnh Thức và nhận được 192 lá chắn."
  },
  State_70621_Name = {
    Text = "Mẫu bướm+"
  },
  State_70623_Desc = {
    Text = "Mỗi đầu lượt, tất cả các thân thể thức tỉnh nhận được 10 điểm điên cuồng."
  },
  State_70624_Desc = {
    Text = "Sau khi sử dụng Bạc Khóa Tỉnh Thức, tất cả thân thể được đánh thức nhận được 20 điên cuồng."
  },
  State_70628_Desc = {
    Text = "Vào đầu lượt, rút 2 lá bài."
  },
  State_70629_Desc = {
    Text = "Mỗi lượt khi tiêu thụ lần đầu, các thân thể được đánh thức khác nhận được 10/20 điên cuồng."
  },
  State_70635_Desc = {
    Text = "Sau khi Bạc Khóa Tỉnh Thức, nhận được 416 phản công."
  },
  State_70636_Desc = {
    Text = "Khi mất sức sống, nhận được 10%/20% lượng sức sống mất đi từ lò luyện kim màu đỏ thẫm."
  },
  State_70637_Desc = {
    Text = "Khi trận chiến bắt đầu, tăng giới hạn râu chạm thêm 1/2, nhận được 1/2 râu chạm."
  },
  State_70641_Desc = {
    Text = "Hủy diệt nhận được 160/320 lá chắn, 3 lượt hồi chiêu."
  },
  State_70641_Name = {
    Text = "Đồng hồ siêu dây"
  },
  State_70643_Desc = {
    Text = "Nhận 1 sức tính toán vào đầu lượt."
  },
  State_70644_Desc = {
    Text = "Sau khi phát động cơn thịnh nộ bùng phát, nhận được 16/32 lực lượng tạm thời."
  },
  State_70645_Desc = {
    Text = "Đầu lượt, nhận 2 sức tính toán."
  },
  State_70646_Name = {
    Text = "Dao Tế Lễ Thất Lạc+"
  },
  State_70647_Desc = {
    Text = "Tất cả sát thương gốc của các thân thể được đánh thức tăng thêm 30%."
  },
  State_70648_Desc = {
    Text = "Khi chiến đấu bắt đầu, áp dụng 640 trúng độc cho tất cả kẻ địch, hiệu ứng tăng gấp đôi trong trận chiến với thủ lĩnh."
  },
  State_70656_Desc = {
    Text = "\"Đánh\" gây thêm 1/2 lần sát thương bằng 60% sức tấn công của thân thể được thức tỉnh, mỗi lượt tối đa kích hoạt 3 lần."
  },
  State_70657_Desc = {
    Text = "Khi bắt đầu chiến đấu, nhận được 32 lực lượng."
  },
  State_70660_Desc = {
    Text = "Nhận 64 điểm lực lượng khi bắt đầu chiến đấu."
  },
  State_70661_Desc = {
    Text = "Khi kết thúc lượt, phục hồi 64 điểm sức sống."
  },
  State_70661_Name = {
    Text = "Máu Ân Tứ+"
  },
  State_70662_Desc = {
    Text = "Sau khi Bạc Khóa Tỉnh Thức, nhận được 2 sức tính toán."
  },
  State_70664_Desc = {
    Text = "Sử dụng chìa khóa bạc để thức tỉnh và nhận được 16 lực lượng."
  },
  State_70666_Desc = {
    Text = "Sau khi chiến đấu bắt đầu, nhận được 100/200 giới vực tinh thông. Tất cả thức tỉnh thể gây ra trúng độc gốc và trúng độc từ sáng tạo tăng 10%/20%."
  },
  State_70667_Desc = {
    Text = "Sau khi Bạc Khóa Tỉnh Thức, nhận được 4 sức tính toán."
  },
  State_70670_Desc = {
    Text = "Khi trận chiến bắt đầu, nhận được 320 phản công, hiệu ứng trong trận Boss tăng gấp đôi."
  },
  State_70671_Desc = {
    Text = "Sau khi vào lượt siêu việt, lá thẻ lệnh không phải là thẻ phái sinh được đánh đầu tiên sẽ có hiệu lực thêm một nửa lần."
  },
  State_70678_Desc = {
    Text = "Khi bắt đầu chiến đấu, nhận được 640 phản công, hiệu ứng trong trận chiến với thủ lĩnh tăng gấp đôi."
  },
  State_70681_Desc = {
    Text = "Tất cả thân thể được đánh thức gây thêm 60% thương cơ bản."
  },
  State_70682_Desc = {
    Text = "Khi số lá bài trong tay nhỏ hơn hoặc bằng 2, rút 1 đến 2 lá bài, mỗi lượt tối đa kích hoạt 2 lần."
  },
  State_70683_Desc = {
    Text = "Sứ giả Hủy diệt khiến thân thể được đánh thức có khí điên cuồng thấp nhất nhận được 50/100 khí điên cuồng, hiệu lực sau 3 lượt."
  },
  State_70684_Desc = {
    Text = "Vào đầu lượt, nếu sức sống dưới 25%, nhận 72/144 sức mạnh tạm thời."
  },
  State_70685_Desc = {
    Text = "Sử dụng Chìa Khóa Bạc Thức Tỉnh sẽ gây 416 điểm trúng độc cho tất cả kẻ địch."
  },
  State_70686_Desc = {
    Text = "Sau khi kích hoạt Bùng nổ, khiến tất cả kẻ thù chịu 1 lần <FixedDamage:Sát Thương Thuần Túy> bằng 15%/30% Sinh lực tối đa của ta, và kích hoạt Ngộ độc 10%/20%."
  },
  State_70687_Name = {
    Text = "Đồng hồ bỏ túi siêu hạn+"
  },
  State_70689_Desc = {
    Text = "Sau khi sử dụng Bạc Khóa Tỉnh Thức, áp dụng 832 trúng độc lên tất cả kẻ địch."
  },
  State_70690_Desc = {
    Text = "Sau khi chiến đấu bắt đầu, nhận được 100/200 giới vực tinh thông. Phản công cơ bản từ các đơn vị được thức tỉnh và phản công từ sáng tạo tăng 10%/20%."
  },
  State_70691_Desc = {
    Text = "Mỗi lần gây thương, nhận được 4/8 lực lượng tạm thời, mỗi lượt tối đa kích hoạt 15 lần."
  },
  State_70693_Desc = {
    Text = "Số lượng phôi hợp tử tự động được tăng thêm 100%/200%."
  },
  State_70694_Desc = {
    Text = "Sau khi sử dụng Bạc Khóa Tỉnh Thức, rút 2 lá bài."
  },
  State_70695_Desc = {
    Text = "Mỗi đầu lượt, tất cả các thể thức tỉnh nhận được 5 điên cuồng."
  },
  State_70696_Desc = {
    Text = "Sau khi Bạc Khóa Tỉnh Thức, nhận được 208 phản công."
  },
  State_70698_Desc = {
    Text = "Phòng thủ nhận được 200/400 phản công tạm thời, mỗi vòng tối đa kích hoạt 3 lần."
  },
  State_70804_Name = {
    Text = "Hạn thời sinh tử"
  },
  State_70805_Desc = {
    Text = "Sau khi trận chiến bắt đầu, áp dụng 1/2 lớp yếu đuối lên tất cả kẻ địch, hiệu ứng đối với thủ lĩnh gấp đôi. Tất cả đơn vị đã được đánh thức tăng thêm 15%/30% thương cơ bản."
  },
  State_70806_Name = {
    Text = "Bàn Tay Thủ Hộ+"
  },
  State_70808_Desc = {
    Text = "Sử dụng tư thế Biển Yên để gây 64/128 suy yếu cho tất cả kẻ địch, thời gian hồi chiêu 3 lượt."
  },
  State_70809_Desc = {
    Text = "Vào đầu lượt, nếu máu dưới 25%, nhận 100/200 lá chắn."
  },
  State_70809_Name = {
    Text = "Bàn Tay Thủ Hộ"
  },
  State_70810_Desc = {
    Text = "Sử dụng tư thế Nộ Đào để phát động tất cả râu chạm tấn công kẻ địch 1/2 lần, thời gian hồi chiêu 3 lượt."
  },
  State_70812_Desc = {
    Text = "Sau khi chiến đấu bắt đầu, áp dụng 1/2 lớp dễ bị thương lên tất cả kẻ địch, hiệu ứng đối với trùm gấp đôi. Tất cả thân thể thức tỉnh gây thêm 15%/30% sát thương cơ bản."
  },
  State_70832_Desc = {
    Text = "Đội duy nhất: Khi bắt đầu trận chiến, người trang bị nhận được điên cuồng tương đương với <WeaponEffect_Num:[StateArg1]%> hồi phục điên cuồng của người trang bị. Sau khi người trang bị lần đầu phát động cơn bùng nổ điên cuồng trong mỗi trận chiến, hiệu ứng này sẽ được kích hoạt lại một lần nữa."
  },
  State_70832_WeaponDesc = {
    Text = "Vào lúc bắt đầu trận đấu, người trang bị nhận được điên cuồng tương đương với <WeaponEffect_Num:[StateArg1]%> hồi phục điên cuồng của người trang bị (<WeaponEffect_Num:[DescArg1]>). Sau khi người trang bị lần đầu phát động cơn thịnh nộ bùng phát trong mỗi trận đấu, hiệu ứng này sẽ được lặp lại một lần nữa."
  },
  State_70835_Desc = {
    Text = "Đội duy nhất: Người trang bị gây tăng điên cuồng, trúng độc, hồi sức sống <WeaponEffect_Num:[StateArg1]%>. Sau khi người trang bị kích hoạt cơn điên cuồng, họ sẽ nhận lại <WeaponEffect_Num:[StateArg2]%> lượng điên cuồng đã tiêu thụ."
  },
  State_70835_WeaponDesc = {
    Text = "Người trang bị gây tăng điên cuồng, trúng độc, hồi phục sinh lực <WeaponEffect_Num:[StateArg1]%>. Sau khi người trang bị kích hoạt cơn điên cuồng bùng phát, họ sẽ nhận lại <WeaponEffect_Num:[StateArg2]%> lượng điên cuồng đã tiêu thụ."
  },
  State_70989_Desc = {
    Text = "Sau khi sử dụng 4 lần cơn thịnh nộ bùng phát trong một lượt, nhận được 3/6 sức tính toán, thời gian hồi chiêu 3 lượt."
  },
  State_71001_Desc = {
    Text = "Trong một lượt, sau khi sử dụng 4 thẻ lệnh thuộc về các thân thể được đánh thức khác nhau, tất cả các thân thể được đánh thức sẽ nhận được 20/40 điên cuồng. Hiệu ứng này có thời gian hồi chiêu trong 3 lượt."
  },
  State_71153_Desc = {
    Text = "Vào đầu lượt, Kẻ khắc sét nhận được 15 điên cuồng. Khi Kẻ khắc sét nhận được lá chắn, hồi 50% máu từ lá chắn."
  },
  State_71154_Desc = {
    Text = "Vào đầu lượt, Ai Jī Sī nhận được 15 điên cuồng. Khi Ai Jī Sī gây thương lên kẻ địch bị tăng sát thương, cô ấy sẽ lấy đi 10 điểm lực lượng tạm thời của chúng, tối đa 5 lần mỗi lượt."
  },
  State_71155_Desc = {
    Text = "Vào đầu lượt, Reia nhận được 15 điên cuồng. Mỗi khi mất máu, nhận thêm 8 điểm lực lượng, tối đa cộng dồn 10 lần trong mỗi trận chiến. Khi đạt đủ 10 lần cộng dồn, \"Khổ đau và Hạnh phúc\" sẽ giảm sức tính toán tiêu thụ xuống còn 1 và tăng số lần gây thương thêm 1."
  },
  State_71156_Desc = {
    Text = "Vào đầu lượt, Agrippa nhận được 15 điểm điên cuồng. \"Sự bố thí không kiên nhẫn\" còn làm giảm tiêu thụ sức tính toán của Agrippa trong lượt này là 1, tối đa 1 lần mỗi lượt."
  },
  State_71157_Desc = {
    Text = "Vào đầu lượt, Sơn nhận được 15 điểm điên cuồng. Vào đầu chiến đấu, tất cả các thẻ lệnh của Sơn được gán thuộc tính bảo lưu, tăng cấp 1 và nhận 24 điểm lá chắn."
  },
  State_71157_Name = {
    Text = "Chiều hình ảnh · sơn"
  },
  State_71158_Desc = {
    Text = "Vào đầu lượt, đóa nhận được 15 điên cuồng. Sau khi chiến đấu bắt đầu, sức tính toán của \"trao đổi tương đương\" của đóa trở thành 0, sau khi đánh ra thì lượt tiếp theo rút thêm 2 lá bài."
  },
  State_71159_Desc = {
    Text = "Vào đầu lượt, Pháp Luân Tư nhận được 15 điên cuồng. Mỗi lần gây thương râu chạm, sẽ làm tăng trúng độc do Pháp Luân Tư gây ra trong trận chiến này thêm 1%, tối đa là 100%."
  },
  State_71160_Desc = {
    Text = "Vào đầu lượt, \"24\" nhận được 15 điên cuồng. Vào đầu lượt, nếu \"24\"đang ở trạng thái \"trầm cảm\" sẽ nhận thêm 25 điên cuồng; nếu ở trạng thái \"hưng phấn\", tỷ lệ chí mạng tạm thời và thương harming chí mạng tạm thời của \"24\" tăng 35%."
  },
  State_71161_Desc = {
    Text = "Vào đầu lượt, Phiệt nhận được 15 điên cuồng. Mỗi khi kích hoạt kháng cự tử vong, sẽ làm tăng 20% lá chắn, phản công và hồi phục sức khỏe mà Phiệt gây ra trong cuộc thám hiểm này, lên tới tối đa 5 lần."
  },
  State_71162_Desc = {
    Text = "Vào đầu lượt, Goliath nhận được 15 điên cuồng. Nếu Goliath gây thương 3 lần trong 1 lượt, thương gây ra sẽ nhận thêm 1 lần lực lượng trong trận chiến này. Thời gian hồi là 3 lượt."
  },
  State_71163_Desc = {
    Text = "Vào đầu lượt, Chuỗi Máu · Hiro nhận được 15 điên cuồng. Khi Chuỗi Máu · Hiro gây thương chủ động, thêm 20% chảy máu, sau khi tiêu diệt kẻ địch, gây chảy máu tương đương với sát thương dư thừa cho các kẻ địch khác."
  },
  State_71164_Desc = {
    Text = "Vào đầu lượt, Ô Ryta nhận được 15 điên cuồng. \"Tuyến phân chia\" tăng sát thương thêm 1 lần, sau khi đánh \"Phòng thủ\" của Ô Ryta, đưa 1 lá\"Tuyến phân chia\" vào tay."
  },
  State_71166_Desc = {
    Text = "Vào đầu lượt, Lily nhận được 15 điên cuồng. Giới hạn nhẫn nại của Lily tăng 100%, khi sử dụng \"bông hoa bất diệt trên bùn lầy\" hoặc \"đánh trả thù\", hồi phục 8% sức sống dựa trên số lớp \"nhẫn nại\"."
  },
  State_71167_Desc = {
    Text = "Vào đầu lượt, lơ-tan nhận được 15 điên cuồng. Mỗi lượt, sau khi đánh ra lần đầu tiên \"phòng thủ\" của lơ-tan, đưa 2 lá \"Lưỡi gươm kiêu hãnh\" có thêm tiêu thụ và hư vô vào tay."
  },
  State_71168_Desc = {
    Text = "Vào đầu lượt, Pandia nhận được 15 điên cuồng. Vào đầu lượt, nhận được 64 điểm phản công. Cứ mỗi 4 điểm phản công không tạm thời, thẻ lệnh \"Pandia\" gây thêm 1 điểm thương."
  },
  State_71169_Desc = {
    Text = "Vào đầu lượt, Hiro nhận được 15 điểm điên cuồng. Mỗi khi có 1 lá bài bị bỏ, \"Hiro\" sẽ nhận thêm 5 điểm điên cuồng."
  },
  State_71170_Desc = {
    Text = "Vào đầu lượt, Tà Vy nhận được 15 điên cuồng. Nếu trong một lượt đánh ra 6 thẻ lệnh của Tà Vy, đặt 1 thẻ \"Ánh Bình Minh Chìa Khóa Bạc\" vào tay, thời gian hồi 3 lượt."
  },
  State_71171_Desc = {
    Text = "Vào đầu lượt, Miriam nhận được 15 điểm điên cuồng và thêm 1 lá \"Thánh lễ\" vào tay."
  },
  State_71172_Desc = {
    Text = "Vào đầu lượt, Meltdown Đóa nhận được 15 điểm điên cuồng. Sau khi Meltdown Đóa bùng phát cơn thịnh nộ, mỗi lần tiêu thụ 20 điểm điên cuồng, các thân thể được đánh thức khác sẽ nhận được 1 điểm điên cuồng."
  },
  State_71173_Desc = {
    Text = "Vào đầu lượt, Salvador nhận được 15 điên cuồng. Mỗi lần tích lũy lò luyện kim màu đỏ thẫm, anh ta còn nhận được 5% lực lượng dựa trên lượng tích lũy. Các đòn đánh \"đánh\" và \"đau khổ phải tiêu trừ\" của Salvador còn nhận thêm gấp đôi lực lượng."
  },
  State_71175_Desc = {
    Text = "Vào đầu lượt, Nốtira nhận được 15 điên cuồng. Sau khi sử dụng \"cơn thịnh nộ bùng phát\" của Nốtira, nhận phản công tương đương 50% lá chắn hiện tại, tối đa 1 lần mỗi lượt."
  },
  State_71177_Desc = {
    Text = "Vào đầu lượt, Liz nhận được 15 điên cuồng. \"Vũ điệu báo tử\" kích hoạt thêm 1 lần hiệu ứng của các thẻ bài bị vứt đi, làm mới sau 3 lượt."
  },
  State_71178_Desc = {
    Text = "Vào đầu lượt, Ramona nhận được 15 điên cuồng. Cứ mỗi 3 thẻ lệnh của Ramona được đánh ra, thẻ lệnh ấy sẽ kích hoạt thêm một lần nữa."
  },
  State_71179_Desc = {
    Text = "Vào đầu mỗi lượt, Uvhash nhận được 15 điểm Aliemus. Lượng tiêu hao Aliemus của Uvhash giảm 10 điểm, mỗi lần phát động Aliemus bùng nổ, lượng tiêu hao Aliemus giảm thêm 5 điểm, mỗi lượt có thể phát động 2 lần Aliemus bùng nổ."
  },
  State_71180_Desc = {
    Text = "Vào đầu lượt, Elva nhận được 15 điên cuồng. Nếu trong lượt trước Elva đã đánh 2 lá \"phòng thủ\", đặt một lá \"tâm nhãn lợi nhận\"đã tiêu thụ vào tay; nếu đã đánh 2 lá \"đánh\", đặt 1 lá \"lâm chiến thể thế\"đã tiêu thụ vào tay."
  },
  State_71181_Desc = {
    Text = "Vào đầu lượt, Sorrel nhận được 15 điên cuồng. Mỗi lần Sorrel gây 1 lần sát thương, phôi hợp tử +10, tối đa 10 lần mỗi lượt. Sau khi kích hoạt 10 lần, sát thương chí mạng của Sorrel trong trận chiến này +20%."
  },
  State_71182_Desc = {
    Text = "Vào đầu lượt, Hamlin nhận được 15 điên cuồng. \"Linh hồn\" sức tính toán tiêu thụ giảm 1, số lần thương tăng 1."
  },
  State_71183_Desc = {
    Text = "Vào đầu mỗi lượt, Thais nhận được 15 điểm Aliemus. Thais sau khi đánh ra 2 thẻ lệnh trong 1 lượt, nhận được một \"Con cái thánh thiện\" và 72 điểm Sức mạnh tạm thời, thời gian hồi chiêu 3 lượt."
  },
  State_71187_Desc = {
    Text = "Vào đầu lượt, Hilaster nhận được 15 điên cuồng. Trước khi kết thúc lượt, mỗi thẻ lệnh của Hilaster trong tay kích hoạt 1 râu chạm tấn công kẻ địch và hồi phục 8 điểm sức sống."
  },
  State_71188_Desc = {
    Text = "Vào đầu lượt, Muphí nhận được 15 điểm điên cuồng. \"Đánh\" và \"Phòng thủ\" của Muphí có thể chuyển hóa 25% \"Hiến tế\" thành thương tổn râu chạm tạm thời, nhưng mỗi lượt chỉ có hiệu lực tối đa 1 lần."
  },
  State_71189_Desc = {
    Text = "Vào đầu lượt, Ninh Phi Nga nhận được 15 điên cuồng. Sau khi sử dụng \"đánh\" của Ninh Phi Nga, tăng 20% trúng độc do \"Ninh Phi Nga\" gây ra trong trận chiến này. Sau khi sử dụng \"phòng thủ\" của Ninh Phi Nga, kích hoạt 50% trúng độc cho tất cả kẻ địch. Mỗi lượt chỉ có hiệu lực tối đa 1 lần."
  },
  State_71190_Desc = {
    Text = "Tại thời điểm bắt đầu vòng, Ogier nhận được 15 cơn cuồng nộ. Sau khi đánh ra \"Ngọn giáo xuyên thấu\" hoặc \"Đòn tấn công\" của Ogier lần đầu trong mỗi vòng, sẽ tăng cường khiên và sức mạnh mà Ogier gây ra trong vòng này lên 50%."
  },
  State_71191_Desc = {
    Text = "Vào đầu mỗi lượt, Lắc nhận được 15 điên cuồng. Kết quả xúc xắc đầu tiên trong mỗi lượt luôn là 6."
  },
  State_71192_Desc = {
    Text = "Vào đầu lượt, Vòng tròn · Ramona nhận được 15 điên cuồng. Mỗi lượt khi kích hoạt \"Hồi vòng\" lần đầu tiên, nhận được 500 điểm năng lượng chìa khóa bạc và 1 tầng \"entropy âm\"."
  },
  State_71193_Desc = {
    Text = "Vào đầu lượt, tulô nhận được 15 điên cuồng. Mức tiêu thụ điên cuồng của tulô giảm 10 điểm, sau khi cơn thịnh nộ bùng phát sẽ lập tức tạo ra 2 râu chạm tạm thời."
  },
  State_71194_Desc = {
    Text = "Vào đầu lượt, Gia Lân nhận được 15 điên cuồng. Đánh ra \"Tĩnh Mặc Thủ Vọng\" sẽ hoàn lại gấp đôi tiêu thụ sức tính toán, hồi chiêu trong 3 lượt."
  },
  State_71271_Desc = {
    Text = "Vào đầu mỗi lượt, Horla nhận 15 Aliemus. Khi trận chiến bắt đầu, nhận 1 lớp ẩn dụ cho tất cả các cảm xúc. Hiệu ứng \"ẩn dụ\" tăng cường 50%."
  },
  State_71272_Desc = {
    Text = "Vào đầu lượt, Jenkin nhận được 15 điên cuồng, tăng thương cuối cùng +5%. \"brun xuất động\" gây thêm 200% sát thương cơ bản và tỉ lệ tăng trưởng."
  },
  State_71273_Desc = {
    Text = "Vào đầu lượt, Đào Đen Đá nhận được 15 điên cuồng và 1 lá \"cảm hứng\". Mỗi khi sử dụng \"Dòng triều dị chất\", lực lượng của cô ấy trong cuộc thám hiểm này sẽ tăng vĩnh viễn thêm 25%, tối đa lên đến 300%."
  },
  State_71274_Desc = {
    Text = "Vào đầu lượt, Tinkert nhận được 15 điên cuồng. Khi thẻ lệnh của Tinkert kích hoạt nhảy vọt, nó sẽ được trả lại vào tay, tối đa 3 lần mỗi lượt."
  },
  State_71275_Desc = {
    Text = "Vào đầu lượt, Vanda nhận được 15 điên cuồng và 1 tầng \"Mộng Dẫn\". Nếu đây là lượt siêu việt, thêm 1 lá bài tạm thời \"Gai Nhọn Khóa\" và \"Người Bảo Vệ Lạc Đường\" vào tay."
  },
  State_71276_Desc = {
    Text = "Vào đầu lượt, Erika nhận được 15 điên cuồng. Sau khi Erika đánh 3 thẻ lệnh trong 1 lượt, cô ấy nhận được 1 thẻ \"cảm hứng\" và tăng gấp đôi lực lượng và giữ mình của \"Điện từ bạo phá\" trong trận chiến này."
  },
  State_71277_Desc = {
    Text = "Vào đầu lượt, Kassia nhận được 15 điên cuồng. Cứ mỗi lá bài rút ra, Kassia nhận được 1 điểm điên cuồng. Khi Kassia thi triển cơn thịnh nộ bùng phát, tất cả kẻ địch mất 32 điểm lực lượng."
  },
  State_71278_Desc = {
    Text = "Vào đầu mỗi lượt, Wenkel nhận được 15 điên cuồng. Mỗi khi các thân thể được đánh thức khác kích hoạt cơn thịnh nộ, Wenkel sẽ nhận thêm 5 điểm điên cuồng và giảm 1 điểm tiêu thụ sức tính toán cho \"xây dựng tinh thần\" trong tay."
  },
  State_71279_Desc = {
    Text = "Khuếch đại sát thương +[StateArg1]%, Liên Tục [Layer] vòng."
  },
  State_71279_Name = {
    Text = "Hưng phấn"
  },
  State_71503_Name = {
    Text = "\"Hình thái cuối cùng\": rút thêm 3 lá bài, nhận được 3 điểm sức tính toán, kích hoạt tất cả địch [DescArg1]% <IntoxicationIconKeywords:trúng độc>, \"Nóng chảy · Đóa\" giới hạn điên cuồng tăng 50 điểm, tối đa tăng 3 lần"
  },
  State_71581_Name = {
    Text = "Khả năng thích ứng hình thái linh hồn"
  },
  State_71589_Name = {
    Text = "Kích hoạt 1 râu chạm tấn công kẻ địch và phục hồi 8 điểm."
  },
  State_71605_Name = {
    Text = "Nhận được [StateArg1] điểm lá chắn"
  },
  State_71650_Desc = {
    Text = "Sau khi chết và phục sinh, nó sẽ gọi một số lượng phân thân khác nhau, nhưng sau khi phục sinh, nó không nhận được bất kỳ sự củng cố hay miễn dịch nào. Vẫn còn hiệu lực [Layer] lần."
  },
  State_71650_Name = {
    Text = "Thú của Vô Số Chiều"
  },
  State_71651_Desc = {
    Text = "Mỗi khi mất sức sống sẽ mất [StateArg1] điểm lực lượng tạm thời. Còn hiệu lực [Layer] lần, mỗi lượt sẽ được đặt lại số lần hiệu lực."
  },
  State_71651_Name = {
    Text = "Mũ gentleman"
  },
  State_71707_Desc = {
    Text = "Mỗi lần chịu 1 lần Sát thương chủ động, hồi phục [StateArg1] điểm Sinh lực, kéo dài [Layer] lượt."
  },
  State_71707_Name = {
    Text = "Kẻ khắc sét·Hỗ trợ"
  },
  State_71708_Desc = {
    Text = "Khi kết thúc lượt, với mỗi 1 thẻ bài trong tay, tất cả các thân thể được đánh thức nhận được [DescArg1] điểm điên cuồng."
  },
  State_71708_Name = {
    Text = "Kasia·Hỗ trợ"
  },
  State_71709_Desc = {
    Text = "Khi kết thúc lượt, nhận được 35 điểm điên cuồng, kéo dài [Layer] lượt."
  },
  State_71709_Name = {
    Text = "Wenkel·Hỗ trợ"
  },
  State_71711_Desc = {
    Text = "Thiệt hại gây ra từ thân thể được đánh thức tăng 25%, kéo dài [Layer] lượt."
  },
  State_71711_Name = {
    Text = "Jenkin·Hỗ trợ"
  },
  State_71712_Desc = {
    Text = "Khi gây Sát thương chủ động, khiến 1 xúc tu tấn công 1 lần, kéo dài [Layer] lượt."
  },
  State_71712_Name = {
    Text = "Ô Ryta·Hỗ trợ"
  },
  State_71712_WeaponDesc = {
    Text = "Khi Hải Nguyệt gây sát thương, [StateArg1] xúc tu sẽ tấn công mục tiêu đó."
  },
  State_71713_Desc = {
    Text = "Mỗi lần thực hiện \"tiêu thụ\", sẽ rút 2 lá \"đánh\" và làm giảm tiêu thụ sức tính toán của chúng 1, kéo dài [Layer] lượt."
  },
  State_71713_Name = {
    Text = "Hiro·Hỗ trợ"
  },
  State_71740_Desc = {
    Text = "Được [Layer] điểm lá chắn vào đầu lượt tiếp theo."
  },
  State_71740_Name = {
    Text = "Reya Hỗ trợ Lá chắn"
  },
  State_71741_Desc = {
    Text = "Vào đầu lượt tiếp theo, nhận lá chắn tương đương với sức sống đã mất trong lượt này, kéo dài [Layer] lượt."
  },
  State_71741_Name = {
    Text = "Reia·Hỗ trợ"
  },
  State_71741_WeaponDesc = {
    Text = "Bắt đầu lượt tiếp theo nhận được lá chắn bằng với sức sống đã mất trong lượt trước."
  },
  State_71742_Desc = {
    Text = "Sát thương từ thẻ đánh tăng [Layer]％."
  },
  State_71742_Name = {
    Text = "Hiro·Hỗ trợ"
  },
  State_71742_WeaponDesc = {
    Text = "Bản lượt này, thương của thẻ đánh của bạn tăng [Layer]%."
  },
  State_71837_Desc = {
    Text = "Vào đầu lượt tiếp theo, nhận hiệu ứng tăng sát thương."
  },
  State_71837_Name = {
    Text = "Trễ tăng sát thương"
  },
  State_71839_Desc = {
    Text = "Sử dụng \"Thức tỉnh\" thời, nhận được [Layer] điểm sức tính toán. Nếu giới vực hiện tại là\"biển sâu\", tạo thêm [Layer] râu chạm tạm thời."
  },
  State_71839_Name = {
    Text = "Bảo vệ sao"
  },
  State_71856_Desc = {
    Text = "Mỗi khi mất sức sống sẽ mất [StateArg1] điểm lực lượng tạm thời. Còn hiệu lực [Layer] lần, mỗi lượt sẽ được đặt lại số lần hiệu lực."
  },
  State_71856_Name = {
    Text = "Mũ gentleman"
  },
  State_72016_Name = {
    Text = "Tinh Thông Huyết Nhục"
  },
  State_72018_WeaponDesc = {
    Text = "Mỗi lần nhận 1 điểm thương, tất cả các thân thể được đánh thức tăng 1 điểm cuồng khí."
  },
  State_72033_Name = {Text = "Xúc tu"},
  State_72036_Name = {
    Text = "Khởi tạo lớp nhân vật hỗn loạn"
  },
  State_72079_Name = {
    Text = "Sóng Gẩm"
  },
  State_72102_Desc = {
    Text = "Trải nghiệm chơi \"Đêm trước khi quên\"."
  },
  State_72102_Name = {Text = "Bài Quên"},
  State_72137_Name = {
    Text = "Sức tính toán đầy"
  },
  State_72206_Name = {
    Text = "Nghiên cứu \"[DescArg1] / 15\""
  },
  State_72208_Name = {
    Text = "Tiến độ nghiên cứu \"[DescArg1] / 2\""
  },
  State_72212_Name = {
    Text = "Tiến độ nghiên cứu \"[DescArg1] / 10\""
  },
  State_72213_Name = {
    Text = "Nghiên cứu \"[DescArg1] / 30\""
  },
  State_72220_Name = {
    Text = "Tiến độ nghiên cứu \"[DescArg1] / 5\""
  },
  State_73518_Desc = {
    Text = "Sát thương gây ra tăng 100％, sau khi mất sức sống, trạng thái này sẽ bị loại bỏ, nhưng nhận được lá chắn bằng 50％ máu tối đa."
  },
  State_73518_Name = {
    Text = "\"sát thủ\""
  },
  State_73520_Desc = {
    Text = "Khi chết, giữ lại 1 điểm sức sống và miễn dịch với mọi thương, chuyển ý định thành \"Giải kết\"."
  },
  State_73520_Name = {
    Text = "\"người liên kết\""
  },
  State_73533_Desc = {
    Text = "Khi lượt của người chơi kết thúc sẽ không bỏ bài nữa. Khi trận chiến bắt đầu, sẽ thay đổi giới hạn bài trên tay của người chơi thành 8."
  },
  State_73533_Name = {
    Text = "Cảm ứng tổ ong"
  },
  State_73535_Desc = {
    Text = "Trong lượt bản thân, sát thương nhận được giảm 75%. Khi sức mạnh bị giảm, chỉ giảm 50% số lớp sức mạnh."
  },
  State_73535_Name = {
    Text = "Tự bảo vệ"
  },
  State_73566_Desc = {
    Text = "Mỗi lần đánh ra 1 lá bài không phải là thẻ lệnh, nhận được [Power:StateArg1] điểm <PowerIconKeywords:lực lượng> và <Block:[Block:StateArg2]> điểm lá chắn."
  },
  State_73566_Name = {
    Text = "\"người liên lạc\""
  },
  State_73567_Desc = {
    Text = "Mỗi lần đánh ra 1 lá bài không phải là thẻ lệnh, nhận được [Power:StateArg1] điểm <PowerIconKeywords:lực lượng> và <Block:[Block:StateArg2]> điểm lá chắn."
  },
  State_73567_Name = {
    Text = "\"người liên lạc\""
  },
  State_73570_Desc = {
    Text = "Mỗi lần đánh ra 1 lá bài không phải là thẻ lệnh, nhận được [Power:StateArg1] điểm <PowerIconKeywords:lực lượng> và <Block:[Block:StateArg2]> điểm lá chắn."
  },
  State_73570_Name = {
    Text = "\"người liên lạc\""
  },
  State_73573_Desc = {
    Text = "Mỗi lần đánh ra 1 lá bài không phải là thẻ lệnh, nhận được [Power:StateArg1] điểm <PowerIconKeywords:lực lượng> và <Block:[Block:StateArg2]> điểm lá chắn."
  },
  State_73573_Name = {
    Text = "\"người liên lạc\""
  },
  State_73649_Desc = {
    Text = "Sát thương của đội tăng mạnh mẽ [Layer]％."
  },
  State_73649_Name = {
    Text = "Ma-nơ-canh của miền quên lãng"
  },
  State_73655_Name = {
    Text = "Dấu hiệu dạng hình thái hữu cơ"
  },
  State_73664_Name = {
    Text = "Hiệu ứng phụ kiện dạng hữu cơ"
  },
  State_73664_WeaponDesc = {
    Text = "Sau khi người trang bị sử dụng cơn thịnh nộ bùng phát, trong lượt này, hiệu quả của lá chắn và khả năng chữa trị của bản thân sẽ tăng gấp đôi."
  },
  State_74012_Desc = {
    Text = "Gây <FixedDamage:Sát Thương Thuần Túy> bằng [StateArg1]% Sinh lực tối đa của tất cả kẻ địch (ít nhất là [DescArg1]), sau khi sử dụng, kỹ năng đặc biệt của \"Tan chảy · Đóa\" sẽ thay đổi thành \"Cuối cùng hình thái\"."
  },
  State_74012_Name = {
    Text = "Kết thúc hư vô"
  },
  State_74013_Desc = {
    Text = "Gây <FixedDamage:Sát Thương Thuần Túy> cho tất cả kẻ thù bằng [StateArg1]% Sinh lực tối đa của chúng, sát thương này không thể thấp hơn 500% Sinh lực tối đa của bản thân, sau khi sử dụng kỹ năng đặc biệt của \"Tan chảy · Đóa\" sẽ chuyển thành \"Cuối cùng hình thái\"."
  },
  State_74013_Name = {
    Text = "Kết thúc hư vô"
  },
  State_74014_Desc = {
    Text = "Gây <FixedDamage:Sát Thương Thuần Túy> bằng [StateArg1]% Sinh lực tối đa của tất cả kẻ địch (sát thương này không thấp hơn 500% Sinh lực tối đa của bản thân), hồi phục 30% Mạng đã mất, sau khi sử dụng, kỹ năng đặc biệt của \"Tan chảy · Đóa\" sẽ thay đổi thành \"Cuối cùng hình thái\"."
  },
  State_74014_Name = {
    Text = "Kết thúc hư vô"
  },
  State_74015_Desc = {
    Text = "Gây <FixedDamage:Sát Thương Thuần Túy> bằng [StateArg1]% Sinh lực tối đa của tất cả kẻ địch (ít nhất là [DescArg1]), hồi <Heal:[Heal:DescArg2]> điểm Sinh lực, sau khi sử dụng, kỹ năng đặc biệt của \"Tan chảy · Đóa\" sẽ thay đổi thành \"Cuối cùng hình thái\"."
  },
  State_74015_Name = {
    Text = "Kết thúc hư vô"
  },
  State_74019_Desc = {
    Text = "Tất cả thức tỉnh giả gây ra trúng độc, phản công, tăng [Layer]％ thương cơ bản."
  },
  State_74019_Name = {
    Text = "Nhiễm điên cuồng"
  },
  State_74142_Desc = {
    Text = "Sau khi bắt đầu khám phá, thể chất, tấn công, phòng thủ tăng [StateArg1] %"
  },
  State_74142_Name = {
    Text = "Khả năng thích ứng hình thái linh hồn"
  },
  State_74219_Name = {
    Text = "Đánh ra sau đó trả về tay"
  },
  State_74273_Desc = {
    Text = "Khi Chuỗi Máu · Hiro gây thương chủ động, thêm [StateArg1]% chảy máu, kéo dài [Layer] lượt."
  },
  State_74273_Name = {
    Text = "Ràng Buộc Thân Thể"
  },
  State_74771_Desc = {
    Text = "Giá trị điên cuồng cần để kích hoạt cơn thịnh nộ bùng phát."
  },
  State_74771_Name = {
    Text = "Giới hạn điên cuồng"
  },
  State_74788_Desc = {
    Text = "\n·Có mâu thuẫn: Khi bắt đầu khám phá, 75% kháng cự tử vong được chuyển đổi thành gia tăng sinh lực tối đa, tối đa chuyển đổi 300% kháng cự tử vong, tối đa tăng 10% sinh lực tối đa. Mỗi khi kích hoạt kháng cự tử vong, thêm 1 thẻ\"Ánh sáng tinh tế của chìa khóa bạc\" vào tay.\n·Vết thương vô đáy: Trong trận chiến Lãnh đạo, mỗi khi lượng hồi phục sinh lực của đội ta đạt 100% sinh lực tối đa, sẽ giảm hiệu ứng hồi phục sinh lực tiếp theo 25%, nhưng làm tăng tổng lượng kháng cự tử vong hiện tại 25%, tối đa kích hoạt 3 lần.\n·Thấu kính lăng kính: Vào đầu lượt, nếu phản công vượt quá 750% sinh lực tối đa, sẽ giảm một nửa số lớp vượt quá, và phản công vĩnh viễn tối đa tích lũy 2250% sinh lực tối đa; nếu kẻ địch bị ngộ độc vượt quá 1000% sinh lực tối đa, sẽ giảm một nửa số lớp vượt quá, và ngộ độc tối đa tích lũy đến 3000% sinh lực tối đa. Thể thức tỉnh nhận được lượng tăng sát thương từ phản công giảm 70%, nhưng tất cả ngộ độc và phản công gây ra tăng 10%. Vào đầu lượt của kẻ địch, mỗi khi một linh trí được kích hoạt, nhận 25% phản công tạm thời của phản công vĩnh viễn hiện tại, và kích hoạt 25% ngộ độc cho tất cả kẻ địch.\n·Côn ánh sáng số phận: Số lượt mà quái vật bình thường phát động \"Nhìn chằm chằm\" giảm còn 6 lượt. Tất cả các trận chiến có giới hạn 15 lượt, nhưng khi bắt đầu lượt thứ 15, thêm 1 thẻ\"Giới hạn quang học\" vào tay: nhận năng lượng chìa khóa bạc tối đa của năng lượng chìa khóa bạc, tất cả thể thức tỉnh nhận được giới hạn điên cuồng tối đa của điên cuồng."
  },
  State_74788_Name = {
    Text = "(Tạm thời không sử dụng)"
  },
  State_74791_Desc = {
    Text = "\n·Cân bằng Điểm tính toán: Khi trong một lượt chơi đạt 10 thẻ lệnh, mỗi khi chơi thêm 1 thẻ lệnh sẽ nhận được 1 lớp \"Cân bằng Điểm tính toán\". \"Cân bằng Điểm tính toán\" khiến mỗi lần chơi thẻ lệnh trong lượt này Giá trị Điểm tính toán +1, mỗi điểm tính toán bổ sung tiêu thụ theo cách đó sẽ chuyển đổi thành 100% Năng lượng chìa khóa bạc Sạc năng lượng chìa khóa bạc của Thể thức tỉnh, có thể chồng. Sau khi kích hoạt Khoảng không gian siêu việt, đặt lại hiệu ứng Cân bằng Điểm tính toán.\n·Sức tính toán đầy: Sau khi chơi thẻ bài, xóa hiệu ứng giảm Giá trị Điểm tính toán trong lượt này của nó. Trong chiến đấu khi Điểm tính toán hiện tại vượt quá 12, tự động chuyển đổi mỗi điểm tính toán vượt quá thành 300% Năng lượng chìa khóa bạc Sạc năng lượng chìa khóa bạc trung bình của đội.\n·điên cuồng điều hòa: Hiệu ứng tăng phần trăm điên cuồng gây ra giảm một nửa. Mỗi khi Thể thức tỉnh giải phóng Bùng nổ, căn bản điên cuồng của nó +10. Khi kết thúc lượt, cứ mỗi 1 Thể thức tỉnh không giải phóng Bùng nổ, nhận được 200% Năng lượng chìa khóa bạc Sạc năng lượng chìa khóa bạc trung bình của đội."
  },
  State_74791_Name = {
    Text = "Năng Lượng Khóa Điều Hòa"
  },
  State_74809_Name = {
    Text = "\"Hình thái cuối cùng\": rút thêm 3 lá bài, nhận được 3 điểm sức tính toán, kích hoạt tất cả địch [DescArg1]% <IntoxicationIconKeywords:trúng độc>, \"Nóng chảy · Đóa\" giới hạn điên cuồng tăng 50 điểm, tối đa tăng 3 lần"
  },
  State_74826_Name = {
    Text = "Gây ngẫu nhiên [DescArg1] điểm <FixedDamage:Sát Thương Thuần Túy> [DescArg2] lần (sát thương này nhận hệ số sức mạnh nhân 1)"
  },
  State_74827_Name = {
    Text = "Trong lượt này, tất cả các thân thể được đánh thức tăng [DescArg1]% tỷ lệ chí mạng và thương chí mạng"
  },
  State_74828_Name = {
    Text = "Gây trúng độc [DescArg1] điểm cho tất cả địch"
  },
  State_74829_Name = {
    Text = "Gây <FixedDamage:Sát Thương Thuần Túy> bằng [DescArg1]% Sinh lực đã mất cho toàn bộ kẻ thù"
  },
  State_74830_Name = {
    Text = "Nhận được [DescArg1] điểm sức mạnh"
  },
  State_74831_Name = {
    Text = "Tất cả các thân thể được đánh thức có [DescArg1] điểm điên cuồng"
  },
  State_74847_Desc = {
    Text = "Đội duy nhất: Người trang bị mỗi lượt sử dụng lá thẻ lệnh đầu tiên gây thương cơ bản tăng <WeaponEffect_Num:[StateArg1]%>. Nếu họ vào không gian siêu việt, người trang bị nhận được <WeaponEffect_Num:[StateArg2]> điểm điên cuồng."
  },
  State_74847_WeaponDesc = {
    Text = "Trang bị mỗi lượt sử dụng lá thẻ lệnh đầu tiên gây thương cơ bản tăng <WeaponEffect_Num:[StateArg1]%>. Nếu họ vào không gian siêu việt, trang bị nhận được <WeaponEffect_Num:[StateArg2]> điểm điên cuồng."
  },
  State_74879_Name = {
    Text = "Nhận được [DescArg1] điểm sức tính toán"
  },
  State_74881_Name = {
    Text = "Chọn một thân thể được đánh thức để nhận [DescArg1] điên cuồng"
  },
  State_74882_Name = {
    Text = "Nhận được [DescArg1] điểm giới vực tinh thông"
  },
  State_74883_Name = {
    Text = "Trong [DescArg1] thẻ lệnh tiếp theo được sử dụng, nhận thêm [DescArg2] điểm năng lượng cốt lõi"
  },
  State_74884_Name = {
    Text = "Bản lượt này gây trúng độc, phản công, chảy máu tăng [DescArg1]%"
  },
  State_74885_Name = {
    Text = "Tất cả các thân thể được đánh thức có [DescArg1] điểm điên cuồng"
  },
  State_74887_Name = {
    Text = "Nhận được [DescArg1]điểm lá chắn"
  },
  State_74888_Name = {
    Text = "Được [DescArg1] điểm kháng cự tử vong"
  },
  State_74889_Name = {
    Text = "Nhận được [DescArg1] lượt phản công"
  },
  State_74890_Name = {
    Text = "Đánh cắp [DescArg1] điểm lực lượng tạm thời của tất cả kẻ địch"
  },
  State_74891_Name = {
    Text = "Gây ngẫu nhiên [DescArg1] điểm <FixedDamage:Sát Thương Thuần Túy> [DescArg2] lần (sát thương này nhận hệ số sức mạnh nhân 1)"
  },
  State_74910_Desc = {
    Text = "Đội duy nhất: Nếu Người trang bị là Thể thức tỉnh \"Ramona\", tỷ lệ đồng điều nhận được khi khám phá màn chơi tăng lên <WeaponEffect_Num:[StateArg1]%>."
  },
  State_74910_WeaponDesc = {
    Text = "Nếu người sở hữu trang bị là \"Ramona\"đã được thức tỉnh, tỷ lệ đồng điều nhận được khi hoàn thành màn chơi sẽ tăng lên <WeaponEffect_Num:[StateArg1]%>."
  },
  State_74932_Desc = {
    Text = "Khi đánh thẻ \"Đánh\", thẻ \"Phòng thủ\" và thẻ \"Kỹ năng\", hiệu ứng tương ứng trong \"Giao dịch cấm kỵ\" sẽ được nâng cấp."
  },
  State_74932_Name = {
    Text = "Giao dịch cấm kỵ"
  },
  State_74947_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>: Khi bắt đầu lượt, áp thêm [StateArg1] lớp Hành động bị phong tỏa lên kẻ địch có <HPAndShieldMin:Sinh lực và lá chắn thấp nhất>. Sau khi Người trang bị Giết kẻ địch, lập tức kích hoạt hiệu ứng này một lần."
  },
  State_74947_Name = {
    Text = "Mũ phù thủy rộng vành"
  },
  State_74948_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>: Sau khi \"Bùng nổ\", khiến kẻ thù có điên cuồng cao nhất mất [StateArg1] điên cuồng và nhận được <PVPEmptinessKeywords:hư vô>."
  },
  State_74948_Name = {
    Text = "Con lắc thôi miên"
  },
  State_76236_Desc = {
    Text = "\n·Đánh thức chìa khóa bạc: Khi Năng lượng chìa khóa bạc đầy, có thể chọn thêm \"Đánh thức chìa khóa bạc\" để đưa thẻ Khai mở linh trí của Thể thức tỉnh được chỉ định vào tay và khiến nó nhận \"Giữ lại\", có hiệu lực trong trận chiến này. \"Đánh thức chìa khóa bạc\" chỉ có thể kích hoạt 1 lần mỗi lượt, hồi chiêu độc lập với \"Mật lệnh\".\n·Quá tải năng lượng chìa khóa: Khi sử dụng \"Đánh thức chìa khóa bạc\", mỗi Thể thức tỉnh đã mở khóa Khai mở linh trí sẽ khấu trừ thêm 1000 điểm Năng lượng chìa khóa bạc, hiệu ứng này có thể khiến Năng lượng chìa khóa bạc trở thành số âm.\n·Dấu lưu trữ: Mỗi Mật lệnh mà Người Giữ Gìn sở hữu sẽ tăng \"Độ sâu nghiên cứu vật thể\" và \"Nghiên cứu độ sâu nhận thức\" lên 1%, tối đa tăng 50%. Hiệu ứng của tất cả vòng mệnh R được thay đổi thành tăng 100% khả năng xuất hiện Di vật Hình ảnh chiều của người trang bị."
  },
  State_76236_Name = {
    Text = "Ánh bạc rực rỡ"
  },
  State_76277_Desc = {
    Text = "Đội duy nhất: Sau khi bắt đầu trận chiến với thủ lĩnh, tiêu thụ tối đa 50 dấu đen, mỗi lần tiêu thụ 1 điểm dấu đen nhận được <WeaponEffect_Num:[StateArg1]%> <DeathResistanceIconKeywords: kháng cự tử vong>. Trong chương Sao, hiệu ứng thay đổi thành \"tăng khả năng xuất hiện của sáng tạo hình ảnh chiều không gian của người trang bị lên 100%\"."
  },
  State_76277_WeaponDesc = {
    Text = "Sau khi trận chiến với thủ lĩnh bắt đầu, tiêu thụ tối đa 50 dấu đen, mỗi điểm dấu đen tiêu thụ mang lại <WeaponEffect_Num:[StateArg1]%> <DeathResistanceIconKeywords: kháng cự tử vong>. Trong Chương Ngôi Sao, hiệu ứng thay đổi thành \"tăng 100% khả năng triệu hồi thực thể chiều không gian của người trang bị\"."
  },
  State_76278_Desc = {
    Text = "Đội duy nhất: Mỗi lần đi qua một ô mới, hồi phục <WeaponEffect_Num:[StateArg1]%> máu đã mất. Sau khi sử dụng linh tri thức khẩn cấp, tỷ lệ chí mạng và thương harming chí mạng của tất cả thân thể được đánh thức tăng 100%. Trong chương sao trời, hiệu ứng thay đổi thành \"Tăng khả năng xuất hiện của sáng tạo chiều của người trang bị lên 100%\"."
  },
  State_76278_WeaponDesc = {
    Text = "Mỗi khi đi qua một ô mới, hồi phục [StateArg1]% máu đã mất([DescArg1]). Sau khi sử dụng linh tri thức khẩn cấp, tỷ lệ chí mạng và thương chí mạng của tất cả thân thể được đánh thức tăng 100%. Trong Chương Sao, hiệu ứng thay đổi thành \"tăng khả năng xuất hiện của chiều ảnh sáng tạo của người trang bị lên 100%\"."
  },
  State_76279_Desc = {
    Text = "Đội duy nhất: Giá thân thể được đánh thức trong dấu vết tan chảy giảm <WeaponEffect_Num:[StateArg1]> điểm dấu đen. Thức tỉnh linh tri của người trang bị đạt được cố hữu. Trong thiênsao trời, hiệu ứng thay đổi thành \"Tăng khả năng xuất hiện của sáng tạo chiều của người trang bị lên 100%\"."
  },
  State_76279_WeaponDesc = {
    Text = "Giá của thân thể thức tỉnh trong dấu vết tan chảy giảm <WeaponEffect_Num:[StateArg1]> dấu đen. Người trang bị đạt được Thức tỉnh linh tri cố hữu. Trong phần Sao Chổi, hiệu ứng đổi thành \"Tăng 100% khả năng xuất hiện của sáng tạo chiều không gian của người trang bị\"."
  },
  State_76280_Desc = {
    Text = "Đội duy nhất: Lượng hồi phục tại nơi nghỉ ngơi tăng <WeaponEffect_Num:[StateArg1]%>, sau khi chọn hồi phục sức sống, thêm 2 lá \"cảm hứng\" vào bộ bài. Trong chương Sao, hiệu ứng thay đổi thành \"Tăng khả năng xuất hiện của chiều ảnh sáng tạo của người trang bị lên 100%\"."
  },
  State_76280_WeaponDesc = {
    Text = "Nơi nghỉ ngơi tăng lượng hồi phục <WeaponEffect_Num:[StateArg1]%>, sau khi chọn hồi phục sức sống, thêm 2 lá \"cảm hứng\" vào bộ bài. Trong chương Sao, hiệu ứng được thay đổi thành \"Tăng 100% khả năng xuất hiện của sáng tạo hình ảnh chiều của người trang bị\"."
  },
  State_76281_Desc = {
    Text = "Đội duy nhất: Sau khi chiến đấu kết thúc, thân thể được đánh thức có mức điên cuồng thấp nhất sẽ nhận được <WeaponEffect_Num:[StateArg1]> điểm điên cuồng. Trong phần Sao, hiệu ứng được thay đổi thành \"khả năng xuất hiện của hình ảnh sáng tạo tăng thêm 100%\"."
  },
  State_76281_WeaponDesc = {
    Text = "Sau khi chiến đấu kết thúc, thân thể được đánh thức có mức độ điên cuồng thấp nhất sẽ nhận được <WeaponEffect_Num:[Energy:StateArg1]> điểm điên cuồng. Trong phần Sao Băng, hiệu ứng được thay đổi thành \"tăng khả năng xuất hiện của vật thể sáng tạo trong chiều của người trang bị lên 100%\"."
  },
  State_76282_Desc = {
    Text = "Đội duy nhất: Số lần làm mới dấu vết tan chảy +1, giá làm mới giảm <WeaponEffect_Num:[StateArg1]> điểm dấu đen. Trong chương Sao Sáng, hiệu ứng được thay đổi thành \"Tăng khả năng xuất hiện của sáng tạo hình ảnh chiều của người trang bị lên 100%\"."
  },
  State_76282_WeaponDesc = {
    Text = "Số lần làm mới Dấu vết Tan Chảy +1, giá làm mới giảm <WeaponEffect_Num:[StateArg1]> điểm Dấu Đen. Trong chương Tinh Thần, hiệu ứng được thay đổi thành \"Khả năng xuất hiện của các sáng tạo thuộc chiều không gian người trang bị tăng thêm 100%\"."
  },
  State_76283_Desc = {
    Text = "Đội duy nhất: Dãy dấu vết tan chảy biến thành 3 sáng tạo, trong đó có một là sáng tạo bị nguyền rủa. Sau khi mua sáng tạo bị nguyền rủa, nhận được <WeaponEffect_Num:[StateArg1]> điểm dấu đen. Trong chương Sao, hiệu ứng được thay đổi thành \"Tăng 100% khả năng xuất hiện sáng tạo hình ảnh chiều của người trang bị\"."
  },
  State_76283_WeaponDesc = {
    Text = "Dãy sáng tạo dấu vết tan chảy trở thành 3, trong đó có một là vật bị nguyền rủa. Sau khi mua vật bị nguyền rủa, nhận <WeaponEffect_Num:[StateArg1]> điểm dấu đen. Trong chương Sao Sáng, hiệu ứng được thay đổi thành \"tăng khả năng xuất hiện của sáng tạo hình ảnh chiều không gian của người trang bị lên 100%\"."
  },
  State_76284_Desc = {
    Text = "Đội duy nhất: Khi màn chơi bắt đầu, tất cả các thân thể được đánh thức nhận được <WeaponEffect_Num:[StateArg1]> điểm điên cuồng. Khi trận đấu với thủ lĩnh bắt đầu, rút 2 lá bài. Trong chương Sao, hiệu ứng thay đổi thành \"Tăng khả năng xuất hiện của vật sáng tạo hình ảnh chiều không gian của người trang bị lên 100%\"."
  },
  State_76284_WeaponDesc = {
    Text = "Sau khi bắt đầu màn chơi, tất cả các thân thể được đánh thức nhận được <WeaponEffect_Num:[Energy:StateArg1]> điểm điên cuồng. Sau khi bắt đầu trận chiến với thủ lĩnh, rút 2 lá bài. Trong chương Sao, hiệu ứng được thay đổi thành \"tăng khả năng xuất hiện của sáng tạo hình ảnh chiều của người trang bị lên 100%\"."
  },
  State_76285_Desc = {
    Text = "Đội duy nhất: Sau khi bắt đầu màn chơi, nhận được <WeaponEffect_Num:[StateArg1]> điểm năng lượng chìa khóa bạc. Sau khi bắt đầu trận chiến với boss, nhận được 2 điểm sức tính toán. Trong chương Sao, hiệu ứng được thay đổi thành \"Tăng khả năng xuất hiện của sáng tạo chiều của người trang bị lên 100%\"."
  },
  State_76285_WeaponDesc = {
    Text = "Sau khi bắt đầu level, nhận được <WeaponEffect_Num:[StateArg1]> điểm năng lượng chìa khóa bạc. Sau khi bắt đầu trận chiến với boss, nhận được 2 điểm sức tính toán. Trong chương Sao, hiệu ứng được thay đổi thành \"tăng khả năng xuất hiện của sáng tạo hình ảnh chiều không gian của người trang bị lên 100%\"."
  },
  State_76286_Desc = {
    Text = "Đội duy nhất: Khu nghỉ ngơi cung cấp thêm một tùy chọn: Loại bỏ tối đa 3 triệu chứng, nhận <WeaponEffect_Num:[StateArg1]> điểm dấu đen. Trong chương Sao, hiệu ứng được thay đổi thành \"Tăng 100% khả năng xuất hiện của hình ảnh chiều từ sáng tạo của người trang bị\"."
  },
  State_76286_WeaponDesc = {
    Text = "Địa điểm nghỉ ngơi cung cấp thêm một tùy chọn: loại bỏ tối đa 3 thẻ triệu chứng, nhận <WeaponEffect_Num:[StateArg1]> điểm dấu đen. Trong chương Tinh Vân, hiệu ứng được thay đổi thành \"tăng khả năng xuất hiện của hiện tượng hình chiếu chiều của người trang bị lên 100%\"."
  },
  State_76287_Desc = {
    Text = "Đội duy nhất: Số lượng khắcăng có thể chọn sau trận chiến thông thường trở thành 4, khắcăng của thẻ bài người trang bị có <WeaponEffect_Num:[StateArg1]%> xác suất nâng cấp thành đá khắc cao cấp. Trong chương Sao, hiệu ứng được thay đổi thành \"tăng khả năng xuất hiện của sáng tạo chiều của người trang bị lên 100%\"."
  },
  State_76287_WeaponDesc = {
    Text = "Sau trận chiến thông thường, số lượng khắcăng có thể chọn trở thành 4, khắcăng của thẻ bài người trang bị có xác suất <WeaponEffect_Num:[StateArg1]%> nâng cấp thành đá khắc cao cấp. Trong chương Sao, hiệu ứng được thay đổi thành \"tăng khả năng xuất hiện của hình ảnh chiều không gian của người trang bị lên 100%\"."
  },
  State_76288_Desc = {
    Text = "Đội duy nhất: Sau khi chiến đấu kết thúc, nhận được <WeaponEffect_Num:[StateArg1]> điểm năng lượng chìa khóa bạc. Trong phần Sao, hiệu ứng được thay đổi thành \"Tăng khả năng xuất hiện của sáng tạo hình ảnh chiều của người trang bị lên 100%\"."
  },
  State_76288_WeaponDesc = {
    Text = "Sau khi chiến đấu kết thúc, nhận được <WeaponEffect_Num:[StateArg1]> điểm năng lượng chìa khóa bạc. Trong phần Sao Sáng, hiệu ứng được thay đổi thành \"tăng khả năng xuất hiện của sáng tạo hình ảnh chiều của người trang bị lên 100%\"."
  },
  State_76289_Desc = {
    Text = "Đội duy nhất: Trong quá trình khám phá, tầm nhìn +1, sau khi mở toàn bộ tầm nhìn bản đồ, nhận <WeaponEffect_Num:[StateArg1]> điểm dấu đen. Khi thủ lĩnh xuất hiện trong trận chiến, làm cho tất cả kẻ địch bị <WeaknessIconKeywords:yếu đuối> và <VulnerabilityIconKeywords:tăng sát thương> trong 1 lượt. Trong chương Sao, hiệu ứng thay đổi. Nó tăng khả năng xuất hiện của vật sáng tạo hình ảnh chiều lên 100%."
  },
  State_76289_WeaponDesc = {
    Text = "Khám phá tăng tầm nhìn +1, sau khi mở toàn bộ tầm nhìn bản đồ, nhận được <WeaponEffect_Num:[StateArg1]> điểm dấu đen. Khi trận chiến với thủ lĩnh bắt đầu, làm cho tất cả kẻ địch bị <WeaknessIconKeywords:yếu đuối> và <VulnerabilityIconKeywords:tăng sát thương> trong 1 lượt. Trong chương Sao, hiệu ứng được thay đổi thành \"tăng khả năng xuất hiện của vật sáng tạo hình ảnh chiều không gian của người trang bị lên 100%\"."
  },
  State_76290_Desc = {
    Text = "Đội duy nhất: Sau trận chiến thường, có thể chọn từ bỏ khắcăng, sức sống tối đa tăng lên <WeaponEffect_Num:[StateArg1]%>. Hiệu ứng này tối đa có thể phát huy 2 lần. Trong chương Cửu Thiên, hiệu ứng thay đổi thành \"khả năng xuất hiện của sáng tạo hình ảnh chiều của người trang bị tăng lên 100%\"."
  },
  State_76290_WeaponDesc = {
    Text = "Sau trận chiến thông thường, có thể chọn từ bỏ khắcăng, giới hạn sức sống tăng <WeaponEffect_Num:[DescArg1]>. Hiệu ứng này có thể kích hoạt tối đa 2 lần. Trong chương Sao Sáng, hiệu ứng được thay đổi thành \"tăng 100% khả năng xuất hiện của hình ảnh chiều do người trang bị tạo ra\"."
  },
  State_76291_Desc = {
    Text = "Đội duy nhất: Sau khi màn chơi bắt đầu, nhận được <WeaponEffect_Num:[StateArg1]> điểm dấu đen. Giới hạn sáng tạo +2. Trong chương Sao, hiệu ứng được thay đổi thành \"tăng 100% khả năng xuất hiện của hình ảnh chiều từ người trang bị\"."
  },
  State_76291_WeaponDesc = {
    Text = "Sau khi bắt đầu màn chơi, nhận <WeaponEffect_Num:[StateArg1]> điểm dấu đen. Giới hạn sáng tạo +2. Trong chương Sao, hiệu ứng được thay đổi thành \"Khả năng xuất hiện sáng tạo hình ảnh chiều của người trang bị tăng thêm 100%\"."
  },
  State_76292_Desc = {
    Text = "Đội duy nhất: Tại nơi bán thẻ bài của Dấu vết tan chảy, cho phép bán thẻ triệu chứng. Sau khi bán thẻ triệu chứng, nhận được <WeaponEffect_Num:[StateArg1]> điểm Dấu đen. Trong chương sao, hiệu ứng được thay đổi thành \"Tăng khả năng xuất hiện của Sáng tạo Hình ảnh Chiều của người trang bị lên 100%\"."
  },
  State_76292_WeaponDesc = {
    Text = "Địa điểm bán thẻ bài dấu vết tan chảy cho phép bán thẻ triệu chứng, sau khi bán thẻ triệu chứng sẽ nhận được <WeaponEffect_Num:[StateArg1]> điểm dấu đen. Trong chương Sao Sáng, hiệu ứng được thay đổi thành \"tăng 100% khả năng xuất hiện sáng tạo hình ảnh chiều không gian của người trang bị\"."
  },
  State_76321_Name = {
    Text = "Thấu kính lăng kính"
  },
  State_76323_Name = {
    Text = "điên cuồng điều hòa"
  },
  State_76324_Name = {
    Text = "Cân bằng Điểm tính toán"
  },
  State_76325_Desc = {
    Text = "Sau khi đánh ra [DescArg1] thẻ lệnh, bước vào trạng thái \"Điều Hòa Sức Tính Toán\"."
  },
  State_76325_Name = {
    Text = "Cân bằng Điểm tính toán"
  },
  State_76326_Name = {
    Text = "Có mâu thuẫn"
  },
  State_76328_Name = {
    Text = "Côn ánh sáng số phận"
  },
  State_76337_Name = {
    Text = "Vết thương vô đáy"
  },
  State_76338_Desc = {
    Text = "Lượng chữa trị mà người chơi nhận được giảm đi [Layer]％."
  },
  State_76338_Name = {
    Text = "Vết thương vô đáy"
  },
  State_76430_Name = {
    Text = "Chiều ảnh · Li-li"
  },
  State_76433_Name = {
    Text = "Cân bằng Điểm tính toán"
  },
  State_76434_Desc = {
    Text = "Mỗi khi sử dụng thẻ lệnh, nếu tiêu thụ thêm sức tính toán do điều hòa, sẽ nhận thêm 100% năng lượng chìa khóa bạc từ việc sạc thân thể được đánh thức, có thể cộng dồn."
  },
  State_76434_Name = {
    Text = "Cân bằng Điểm tính toán"
  },
  State_76435_Name = {
    Text = "Thấu kính lăng kính"
  },
  State_76528_Name = {
    Text = "Thẻ này được xem là\"đánh\""
  },
  State_76529_Desc = {
    Text = "Khi nhặt, chọn một thẻ bài 「thức tỉnh」, làm giảm tiêu thụ sức tính toán của nó đi 1, sau khi đánh rút 1 thẻ bài và coi đó là 「đánh」."
  },
  State_76533_Desc = {
    Text = "<PVPWeaponKeywords:Bánh xe định mệnh>：Khi trang bị và kết thúc lượt, đưa [StateArg1] lá bài ngẫu nhiên của đối thủ [StateArg2] lớp <PVPAcheKeywords:đau khổ tiềm ẩn>。"
  },
  State_76533_Name = {
    Text = "Nỗi đau ẩn dấu"
  },
  State_76553_Desc = {
    Text = "Thẻ bài này tiêu thụ sức tính toán -[StateArg1]."
  },
  State_76553_Name = {
    Text = "Triệu ánh nhìn yêu thương"
  },
  State_77686_Name = {
    Text = "Hình thái bán cơ khí"
  },
  State_77688_Desc = {
    Text = "Vào đầu vòng thứ năm hoặc khi sắp chết, miễn nhiễm với cái chết và điều chỉnh ý định thành \"siêu thoát cơ khí\"."
  },
  State_77688_Name = {
    Text = "Thịt yếu"
  },
  State_77690_Desc = {
    Text = "Sau khi chuyển sang 「hình thái Bán Cơ Giới」, mỗi lớp 「Chung Nhị」 sẽ cung cấp thêm 10% máu tối đa. Trong 「hình thái Bán Cơ Giới」, 「Rã Chảy · Đóa」 sẽ phát hành kỹ năng đe dọa hơn khi số lớp 「Chung Nhị」 tăng lên."
  },
  State_77690_Name = {
    Text = "Cuối cùng"
  },
  State_77692_Desc = {
    Text = "Cuối lượt, gọi 2 quái vật Nóng Chảy Rỗng Rỗng, tối đa có thể tồn tại đồng thời 2 con. Sau khi quái vật Rỗng Rỗng chết, \"Nóng Chảy·Đóa\" mất 5% máu tối đa."
  },
  State_77692_Name = {
    Text = "Cổng Hố Sâu"
  },
  State_77693_Desc = {
    Text = "Sau khi chết \"Nóng chảy·đóa\" mất 5% máu tối đa."
  },
  State_77693_Name = {Text = "Tan chảy"},
  State_78102_Desc = {
    Text = "Thương gây ra giảm 15％, thương nhận phải tăng 30％, kéo dài đến cuối chiến đấu."
  },
  State_78102_Name = {
    Text = "Paralysis Overclock"
  },
  State_78694_Desc = {
    Text = "Nhận [Arg1] điểm lực lượng khi bắt đầu chiến đấu. Mỗi khi bắt đầu lượt có [Arg2] điểm sức mạnh vĩnh viễn, nhận được [Arg3] điểm sức mạnh tạm thời, tối đa nhận được [Arg4] điểm sức mạnh tạm thời, và vào cuối lượt mất một nửa lá chắn tương ứng với sức mạnh tạm thời nhận được từ di vật này."
  },
  State_78696_Desc = {
    Text = "Sau khi sử dụng chìa khóa bạc để thức tỉnh, hãy chọn [Arg1] lá \"kỹ năng\" tương ứng của thân thể được đánh thức để tiêu thụ, và trộn [Arg2] lá sao chép tiêu thụ vào bộ bài rút."
  },
  State_78697_Desc = {
    Text = "Vào đầu mỗi lượt, bị áp dụng [Arg2] lớp Độc dược, mỗi vị trí trống trong không gian Ultra sẽ nhận [Arg1] điểm Sức mạnh."
  },
  State_78698_Desc = {
    Text = "Giới hạn sức tính toán -[Arg1]. Mỗi khi đánh ra 1 lá bài có tiêu thụ sức tính toán lớn hơn hoặc bằng [Arg2], sẽ nhận được một điểm sức tính toán. Mỗi lượt tối đa kích hoạt [Arg3] lần."
  },
  State_78699_Desc = {
    Text = "Sau khi rút bài, rút thêm [Arg1] lá bài, nhưng phải chọn [Arg2] lá bài trong tay để bỏ đi."
  },
  State_78700_Desc = {
    Text = "Tất cả các thân thể được đánh thức có thương cơ bản tăng [Arg1]%, mỗi lần đặt lại bộ bài tăng thêm [Arg2]%, nhưng thêm 1 lá \"bước đi chậm chạp\" vào tay, giá trị tăng tối đa là [Arg3]%."
  },
  State_78701_Desc = {
    Text = "Vào đầu lượt, nếu có hơn [Arg1] râu chạm vĩnh viễn, mất [Arg2] râu chạm và nhận [Arg3] râu chạm tạm thời, ngược lại nhận [Arg4] râu chạm tạm thời."
  },
  State_78702_Desc = {
    Text = "Sau khi Bạc Khóa Tỉnh Thức, tiêu thụ thêm [Arg1] điểm năng lượng chìa khóa bạc, khiến sức tính toán của thẻ Thức tỉnh linh tri trở thành 0, sau khi sử dụng, thân thể được đánh thức tương ứng sẽ nhận thêm [Arg2] điểm điên cuồng."
  },
  State_78703_Desc = {
    Text = "Khi chiến đấu bắt đầu, gây [Arg1] điểm trúng độc cho tất cả kẻ địch. Trước khi lượt bắt đầu, loại bỏ [Arg2]% trúng độc của kẻ địch và áp dụng chảy máu [Arg3]% lượng đã loại bỏ."
  },
  State_78710_Desc = {
    Text = "Mỗi lần đánh ra một thẻ lệnh sẽ làm tăng thương cuối cùng của thân thể được đánh thức trong lượt đó [Arg1]%, nhưng sẽ làm mất [Arg2] điểm điên cuồng, mỗi lượt tối đa kích hoạt [Arg3] lần."
  },
  State_78712_Desc = {
    Text = "Vào đầu lượt, mức độ phôi hợp tử + [Arg1], phôi thai của bạn sẽ bị bỏ đi vào cuối lượt."
  },
  State_78713_Desc = {
    Text = "Vào đầu lượt, nhận được [Arg1] điểm phản công. Sau khi giải phóng [Arg2] lần cơn thịnh nộ bùng phát trong một lượt, loại bỏ [Arg3]% phản công vĩnh viễn của bản thân, nhận [Arg4]% phản công tạm thời tương ứng với lượng loại bỏ, làm mới sau [Arg5] lượt."
  },
  State_78781_Desc = {
    Text = "Tạm thời giảm sức mạnh của mục tiêu, nhận được lượng sức mạnh tạm thời tương đương."
  },
  State_78781_Name = {
    Text = "<TouquKeywords: Trộm cắp>"
  },
  State_79405_Desc = {
    Text = "Sau khi đánh ra \"Ký ức rõ ràng\" tăng lên 1, khi đạt 10 sẽ khóa trong 1 vòng và nhận 3 lá\"Cảm hứng\", ở vòng kế tiếp sẽ thiết lập lại về 5."
  },
  State_79405_Name = {
    Text = "Quá khứ thực sự"
  },
  State_79406_Desc = {
    Text = "Sau khi đánh ra \"Ký ức rõ ràng\" giảm xuống 1, khi đạt 0 sẽ khóa trong 1 vòng và khiến tất cả người thức tỉnh nhận 30 điểm điên loạn, ở vòng kế tiếp sẽ thiết lập lại về 5."
  },
  State_79406_Name = {
    Text = "Giấc mơ phù hoa"
  },
  State_80052_Desc = {Text = "Kiểm tra"},
  State_80052_Name = {
    Text = "Kiểm thử123"
  },
  State_80052_WeaponDesc = {Text = "Kiểm tra"},
  State_80161_Desc = {
    Text = "Đội duy nhất: Sát thương cơ bản từ Bùng nổ của người trang bị tăng <WeaponEffect_Num:[StateArg1]%>, Sạc năng lượng chìa khóa bạc tăng <WeaponEffect_Num:[StateArg2]%>. Sau khi vào Vòng Siêu Chiều, tất cả Thể thức tỉnh nhận <WeaponEffect_Num:[StateArg4]> điểm Điên loạn. Sau khi kích hoạt \"Sự diệt vong\", người trang bị nhận <WeaponEffect_Num:[StateArg3]> điểm Điên loạn."
  },
  State_80161_WeaponDesc = {
    Text = "Tăng sát thương cơ bản của tôn kính của trang bị bởi <WeaponEffect_Num:[StateArg1]%>, tăng sạc lại chìa khóa bạc <WeaponEffect_Num:[DescArg1]>. Khi vào lượt Ultra, tất cả thức tỉnh nhận <WeaponEffect_Num:[StateArg4]> điểm Aliemus. Sau khi phát động \"Diệt vong\", người trang bị nhận <WeaponEffect_Num:[StateArg3]> điểm Aliemus."
  },
  State_80174_Desc = {
    Text = "Duy nhất trong đội: Tăng sạc lại chìa khóa bạc của người trang bị <WeaponEffect_Num:[StateArg1]%>. Sau khi trận chiến đầu tiên bắt đầu, áp dụng 1 lớp điểm yếu và dễ tổn thương cho tất cả kẻ địch."
  },
  State_80174_WeaponDesc = {
    Text = "Tăng sạc lại chìa khóa bạc của người trang bị <WeaponEffect_Num:[DescArg1]>. Sau khi trận chiến đầu tiên bắt đầu, áp dụng 1 lớp điểm yếu và dễ tổn thương cho tất cả kẻ địch."
  },
  State_80207_Desc = {
    Text = "Nếu sau khi đánh lá bài này kích hoạt \"xuyên không chiều\" sẽ kích hoạt hiệu ứng tiếp theo. Khi lấy ra từ không gian siêu chiều, tiêu hao sức mạnh tính toán -1."
  },
  State_80207_Name = {
    Text = "<WormholeKeywords:Xuyên chiều>"
  },
  State_80328_Desc = {
    Text = "Tâm trạng, nhận thức và mọi thứ của cô ấy đều liên kết vĩnh viễn với Ý chí tổ. Tối đa chồng chất 15 tầng. \"Cộng cảm\" có thể được chuyển hóa thành hiệu ứng tiêu cực qua Tôn kính \"Điều trị tái cấu trúc cuộc sống\" của Clemantine."
  },
  State_80328_Name = {
    Text = "Cảm thông"
  },
  State_80331_Desc = {
    Text = "Dưới sự Xói mòn của bầy đàn, điểm yếu của ngươi bị phơi bày. Sát thương chủ động và thương tổn xúc tu chịu trong lượt này tăng [DescArg1]%."
  },
  State_80331_Name = {
    Text = "<D13Colour:Chấn thương tinh thần>"
  },
  State_80332_Desc = {
    Text = "Tâm trạng, nhận thức và mọi thứ của cô ấy đều liên kết vĩnh viễn với Ý chí tổ, tối đa chồng chất 10 tầng. \"Cộng cảm\" có thể được chuyển hóa thành hiệu ứng tiêu cực qua Tôn kính \"Điều trị tái cấu trúc cuộc sống\" của Clemantine."
  },
  State_80332_Name = {
    Text = "Cảm thông"
  },
  State_80335_Desc = {
    Text = "Dưới sự Xói mòn của bầy đàn, điểm yếu của ngươi bị phơi bày. Sát thương chủ động và thương tổn xúc tu chịu trong lượt này tăng [DescArg1]%."
  },
  State_80335_Name = {
    Text = "<D13Colour:Chấn thương tinh thần>"
  },
  State_80336_Desc = {
    Text = "Dưới sự Xói mòn của bầy đàn, nỗi Sợ hãi của ngươi không thể che giấu. Sát thương chủ động và thương tổn xúc tu gây ra trong lượt này giảm [DescArg1]%."
  },
  State_80336_Name = {
    Text = "<D13Colour:Sự ám ảnh về sợ hãi>"
  },
  State_80338_Desc = {
    Text = "Dưới sự Xói mòn của bầy đàn, nỗi Sợ hãi của ngươi không thể che giấu. Sát thương chủ động và thương tổn xúc tu gây ra trong lượt này giảm [DescArg1]%."
  },
  State_80338_Name = {
    Text = "<D13Colour:Sự ám ảnh về sợ hãi>"
  },
  State_80575_Desc = {
    Text = "Chịu sát thương chủ động hoặc thiệt hại xúc tu, gỡ bỏ lượng tương đương \"Tro cũ\" và mất 300% lượng gỡ bỏ cuộc sống, khi chịu sát thương khác thì gỡ bỏ một nửa. Số lớp \"Tro cũ\" đặt lại mỗi lượt."
  },
  State_80575_Name = {
    Text = "Tàn tro cũ"
  },
  State_80644_Name = {
    Text = "Trạng thái@Ánh sáng Siêu việt"
  },
  State_80773_Desc = {
    Text = "Khi chịu hiệu ứng sức mạnh giảm xuống, chỉ giảm 50% số lớp sức mạnh. Trong lượt của bản thân, sát thương không phải Sát thương chủ động và thương tổn xúc tu chịu tăng 100%."
  },
  State_80773_Name = {
    Text = "Kháng thể dị chiều"
  },
  State_80774_Desc = {
    Text = "Sau khi chịu sát thương chủ động hoặc thiệt hại xúc tu, loại bỏ một lượng \"Tàn dư của ngày xưa\" tương ứng và mất 300% lượng loại bỏ Máu, khi chịu sát thương khác thì loại bỏ phân nửa. Số tầng của \"Tàn dư của ngày xưa\" sẽ được thiết lập lại mỗi lượt. Sau khi tất cả \"Tàn dư của ngày xưa\" bị loại bỏ, nhận 50 tầng \"Gia cố\"."
  },
  State_80774_Name = {
    Text = "Tàn tro cũ"
  },
  State_80777_Desc = {
    Text = "Khi trận chiến bắt đầu, giảm tỷ lệ chí mạng của tất cả Người đánh thức 10％。Sau khi chết, đồng đội khác nhận được [DescArg1] điểm Sức mạnh và [DescArg2] tầng \"Tro tàn xưa\"."
  },
  State_80777_Name = {
    Text = "Empati của Đàn ong - Di sản"
  },
  State_80778_Desc = {
    Text = "Sau khi chết, các đồng đội khác nhận 1 lớp tạm thời <MadnessIconKeywords:điên rồ>."
  },
  State_80778_Name = {
    Text = "Hive Empathy: Fusion"
  },
  State_80782_Desc = {
    Text = "Trong trận chiến này, tất cả người đánh thức đều giảm tỷ lệ chí mạng [Layer]％."
  },
  State_80782_Name = {
    Text = "Tỷ lệ chí mạng giảm"
  },
  State_80783_Desc = {
    Text = "Khi kết thúc lượt, nhận được 1 lớp <MadnessIconKeywords:Điên rồ>."
  },
  State_80783_Name = {
    Text = "Liên kết đồng tộc"
  },
  State_80784_Desc = {
    Text = "Khi cuộc sống dưới 50%, triệu hồi một \"Người biến hình\" ở phía sau, chỉ kích hoạt 1 lần trong mỗi trận chiến."
  },
  State_80784_Name = {
    Text = "Cảm ứng tổ ong - Phân hạch"
  },
  State_80785_Desc = {
    Text = "Khi Sức mạnh bị giảm, chỉ giảm 50% số lớp Sức mạnh. Mỗi khi người chơi tung ra Bùng nổ, nhận được 1 lớp Tạm thời <MadnessIconKeywords:Điên rồ>."
  },
  State_80785_Name = {
    Text = "Cảm ứng Tổ Ong: Chiều Không Gian"
  },
  State_80788_Desc = {
    Text = "Khi Sức mạnh bị giảm, chỉ giảm 25% số lớp Sức mạnh. Mỗi khi người chơi tung ra Bùng nổ, nhận được 1 lớp Tạm thời <MadnessIconKeywords:Điên rồ>."
  },
  State_80788_Name = {
    Text = "Cảm ứng Tổ Ong: Chiều Không Gian"
  },
  State_80789_Desc = {
    Text = "Sát thương chủ động và thương tổn xúc tu chịu tăng 100%, kéo dài 1 lượt."
  },
  State_80789_Name = {Text = "ẩn náu"},
  State_80790_Desc = {
    Text = "Sau khi lột xác, mỗi tầng hư không u linh sẽ khiến nó trở nên hoàn hảo……"
  },
  State_80790_Name = {
    Text = "Năng lượng vũ trụ"
  },
  State_80792_Desc = {
    Text = "Mỗi khi người chơi kích hoạt Bùng nổ, nhận 1 lớp tạm thời <MadnessIconKeywords:điên rồ>."
  },
  State_80792_Name = {
    Text = "Cảm ứng Tổ Ong: Chiều Không Gian"
  },
  State_80794_Desc = {
    Text = "Thẻ không thể chơi được, và vẫn giữ lại trong tay khi kết thúc lượt."
  },
  State_80794_Name = {
    Text = "<Boundkeywords:Trói buộc>"
  },
  State_80807_Desc = {
    Text = "Khi bắt đầu vòng thứ năm hoặc sắp chết, gỡ bỏ tất cả kẻ thù khác, chuyển đổi ý định thành \"Khoảnh khắc biến hình\"."
  },
  State_80807_Name = {
    Text = "Biến thân chi khắc"
  },
  State_80809_Desc = {
    Text = "Khi kết thúc vòng, nếu còn trong tay, các thẻ bài có ảo giác sẽ bị loại bỏ."
  },
  State_80809_Name = {
    Text = "<PVPVoidKeyColour:Hư vô>"
  },
  State_80810_Desc = {
    Text = "Chịu sát thương chủ động hoặc thiệt hại xúc tu, gỡ bỏ lượng tương đương \"Tro cũ\" và mất 300% lượng gỡ bỏ cuộc sống, khi chịu sát thương khác thì gỡ bỏ một nửa. Số lớp \"Tro cũ\" đặt lại mỗi lượt."
  },
  State_80810_Name = {
    Text = "Tàn tro cũ"
  },
  State_80827_Desc = {
    Text = "Mỗi khi đánh ra 15 thẻ bài, sẽ thay thế dự định hiện tại bằng \"Tổn thương chí mạng\" (hiện còn lại [Layer] thẻ)."
  },
  State_80827_Name = {
    Text = "Trừng phạt giận dữ"
  },
  State_81022_WeaponDesc = {
    Text = "Mỗi lần nhận 1 điểm thương, tất cả các thân thể được đánh thức tăng 1 điểm cuồng khí."
  },
  State_81027_Desc = {
    Text = "Chủ sở hữu của thẻ này là \"Bầy sâu\", tiêu tốn số học -1, sau khi đánh ra sẽ bị \"tiêu hao\"."
  },
  State_81027_Name = {
    Text = "Lễ Sức Sống"
  },
  State_81054_Desc = {
    Text = "Dưới sự Xói mòn của bầy đàn, nỗi Sợ hãi của ngươi không có chỗ ẩn náu. Mỗi lớp giảm 3% Sát thương chủ động và thương tổn xúc tu gây ra trong lượt này, tối đa 15 lớp."
  },
  State_81054_Name = {
    Text = "<D13AFKeyWordQ1:Sự ám ảnh về sợ hãi>"
  },
  State_81055_Desc = {
    Text = "Dưới sự Xói mòn của bầy đàn, nỗi Sợ hãi của ngươi không có chỗ ẩn náu. Mỗi lớp tăng 3% Sát thương chủ động và thương tổn xúc tu phải chịu trong lượt này, tối đa 10 lớp."
  },
  State_81055_Name = {
    Text = "<D13AFKeyWord2:Chấn thương tinh thần>"
  },
  State_81056_Desc = {
    Text = "Dưới sự Xói mòn của bầy đàn, nỗi Sợ hãi của ngươi không có chỗ ẩn náu. Mỗi lớp tăng 3% Sát thương chủ động và thương tổn xúc tu phải chịu trong lượt này, tối đa 15 lớp."
  },
  State_81056_Name = {
    Text = "<D13AFKeyWordQ2:Chấn thương tinh thần>"
  },
  State_81057_Desc = {
    Text = "Dưới sự Xói mòn của bầy đàn, nỗi Sợ hãi của ngươi không có chỗ ẩn náu. Mỗi lớp giảm 3% Sát thương chủ động và thương tổn xúc tu gây ra trong lượt này, tối đa 10 lớp."
  },
  State_81057_Name = {
    Text = "<D13AFKeyWord1:Sự ám ảnh về sợ hãi>"
  },
  State_81058_Desc = {
    Text = "Tâm trạng, nhận thức và mọi thứ của cô ấy đều liên kết vĩnh viễn với Ý chí tổ. \"Cộng cảm\" có thể được chuyển hóa thành hiệu ứng tiêu cực qua Tôn kính \"Điều trị tái cấu trúc cuộc sống\" của Clemantine, tối đa chồng chất 15 tầng."
  },
  State_81058_Name = {
    Text = "<AnalysisKeywords3:Sự đồng cảm>"
  },
  State_81059_Desc = {
    Text = "Tâm trạng, nhận thức và mọi thứ của cô ấy đều liên kết vĩnh viễn với Ý chí tổ. \"Cộng cảm\" có thể được chuyển hóa thành hiệu ứng tiêu cực qua Tôn kính \"Điều trị tái cấu trúc cuộc sống\" của Clemantine, tối đa chồng chất 10 tầng."
  },
  State_81059_Name = {
    Text = "<AnalysisKeywords0:Sự đồng cảm>"
  },
  State_81073_Desc = {
    Text = "Sau khi nhận sát thương chí mạng lập tức hồi phục tất cả cuộc sống và nhận được 80% gia cố tạm thời, triệu hồi một “người biến đổi ban đầu” ở phía sau, có thể kích hoạt 2 lần."
  },
  State_81073_Name = {
    Text = "Cảm ứng tổ ong - Phân hạch"
  },
  State_81278_Desc = {
    Text = "Mỗi lượt, sau khi sử dụng lệnh khóa lần đầu tiên, tất cả các thân thể được đánh thức nhận thêm 10 điên cuồng. Tuy nhiên, tiêu thụ khi sử dụng lệnh khóa sẽ tăng vĩnh viễn thêm 10%."
  },
  State_81278_Name = {
    Text = "Khóa Bạc Ức Chế"
  },
  State_81312_Desc = {
    Text = "Sau khi chịu sát thương chí mạng, hồi phục toàn bộ cuộc sống và nhận được 50 tầng gia cố tạm thời. Còn có thể kích hoạt số lần [Layer]."
  },
  State_81312_Name = {
    Text = "Vũ trụ luân hồi"
  },
  State_81331_Desc = {
    Text = "Khi lượt bắt đầu, hãy chọn 1 người đánh thức, phong ấn tất cả thẻ và sự bùng nổ của aliemus trong 3 lượt。"
  },
  State_81331_Name = {
    Text = "Giữ tù ý thức"
  },
  State_81340_Desc = {
    Text = "Thẻ này bị phong ấn không thể đánh ra, phong ấn sẽ được giải trừ sau [Layer] lượt."
  },
  State_81340_Name = {
    Text = "<Seal1:Phong ấn thẻ bài>"
  },
  State_81341_Desc = {
    Text = "Thể đánh thức này bị phong ấn không thể sử dụng, phong ấn sẽ được giải trừ sau [Layer] lượt."
  },
  State_81341_Name = {
    Text = "<Seal1:Phong ấn điên cuồng>"
  },
  State_81354_Desc = {
    Text = "Sau khi phát ra sẽ nhận [DescArg1] điểm sát thương, nếu không phát ra vào cuối lượt sẽ bị kiệt sức."
  },
  State_81354_Name = {
    Text = "<BurningKeywords:Đốt cháy>"
  },
  State_81356_Desc = {
    Text = "Làm cháy thẻ bài, nhận [DescArg1] điểm sát thương sau khi ra bài, nếu hết vòng vẫn đang trong tay sẽ bị kiệt sức."
  },
  State_81356_Name = {
    Text = "<BurningKeywords:Đốt cháy>"
  },
  State_81356_WeaponDesc = {
    Text = "Mỗi lớp làm chậm khiến tiêu thụ sức tính toán của thẻ bài tăng thêm 1 điểm."
  },
  State_83587_Desc = {
    Text = "Có thể nâng cao hiệu ứng khi chọn \"Ra khơi\", giới hạn 10 tầng."
  },
  State_83587_Name = {
    Text = "\"Căng buồm\""
  },
  State_83589_Desc = {
    Text = "Có thể nâng cao hiệu ứng khi chọn \"Neo bến tạm nghỉ\", giới hạn 10 tầng."
  },
  State_83589_Name = {
    Text = "\"Neo lại\""
  },
  State_83593_Desc = {
    Text = "Thiệt hại cuối cùng do tất cả người đánh thức gây ra được tăng lê"
  },
  State_83593_Name = {
    Text = "Sát thương cuối cùng"
  },
  State_83596_Desc = {
    Text = "Giới hạn bài trên tay +1. Khi bắt đầu vòng, nếu trong bộ bài không có \"Sự lựa chọn của người dẫn đường\", hãy đặt nó vào tay. Mỗi khi lãnh đạo mất 10% máu tối đa, nhận 1 lớp \"Căng buồm\"; mỗi khi bản thân mất 10% máu tối đa, nhận 1 lớp \"Đậu cơ\"."
  },
  State_83596_Name = {
    Text = "Hướng dẫn của Erasmo - \"Giương buồm\""
  },
  State_83607_Desc = {
    Text = "Dấu hiệu mất máu 10% tích lũy của Boss"
  },
  State_83607_Name = {
    Text = "Trạng thái @ lãnh đạo nhãn hiệu mất 10% cuộc sống tích lũy"
  },
  State_83609_Desc = {
    Text = "Nhãn hiệu mất 10% cuộc sống tích lũy của người chơi"
  },
  State_83609_Name = {
    Text = "Trạng thái @ người chơi nhãn hiệu mất 10% cuộc sống tích lũy"
  },
  State_83614_Desc = {
    Text = "Người chơi 10% máu"
  },
  State_83614_Name = {
    Text = "Trạng thái @ người chơi 10% máu"
  },
  State_83615_Desc = {
    Text = "Mất [Layer] điểm sinh mệnh, nhận được 1 lớp \"Du lịch\"."
  },
  State_83615_Name = {
    Text = "\"Giương buồm\" tiến độ"
  },
  State_83616_Desc = {
    Text = "Mất [Layer] điểm sinh mệnh, nhận được 1 lớp \"Đỗ tàu\"."
  },
  State_83616_Name = {
    Text = "\"Đỗ neo\" tiến độ"
  },
  State_83617_Desc = {
    Text = "Boss 10% lượng máu"
  },
  State_83617_Name = {
    Text = "Trạng thái @ lãnh đạo 10% máu"
  },
  State_83618_Desc = {
    Text = "Trong khi kiểm tra, cuộc sống hiện tại là [Layer] điểm."
  },
  State_83618_Name = {
    Text = "Số đếm cuộc sống hiện tại của kẻ thù"
  },
  State_83619_Desc = {
    Text = "Trong khi kiểm tra, máu tối đa là [Layer] điểm."
  },
  State_83619_Name = {
    Text = "Số đếm máu tối đa của kẻ thù"
  },
  State_83620_Desc = {
    Text = "Giá trị của tham số 4 hiện tại nhân 100 là [Layer] điểm."
  },
  State_83620_Name = {
    Text = "tham số in"
  },
  State_83621_Desc = {
    Text = "Giá trị trung bình mất máu 10% của Boss"
  },
  State_83621_Name = {
    Text = "Trạng thái @ lãnh đạo giá trị trung bình mất 10% máu"
  },
  State_83622_Desc = {
    Text = "Giá trị trung bình mất 10% máu của người chơi"
  },
  State_83622_Name = {
    Text = "Trạng thái @ người chơi giá trị trung bình mất 10% máu"
  },
  State_83627_Desc = {
    Text = "Mất [DescArg1] điểm sinh mệnh, nhận được 1 lớp \"Du lịch\""
  },
  State_83627_Name = {
    Text = "\"Giương buồm\" tiến độ"
  },
  State_83805_Name = {Text = "Dư Ba"},
  State_83807_Name = {
    Text = "Chìm trong biển xa"
  },
  State_83808_Desc = {
    Text = "Khi thẻ này bị bỏ đi, kích hoạt hiệu ứng \"Dư ba\"."
  },
  State_83808_Name = {
    Text = "<RippleKeywords:Dư ba>"
  },
  State_83811_Desc = {
    Text = "Chịu thêm [Layer]% thiệt hại xúc tu."
  },
  State_83812_Desc = {
    Text = "Chịu thêm [Layer]% thiệt hại xúc tu."
  },
  State_83814_Desc = {
    Text = "Boss 10% lượng máu"
  },
  State_83814_Name = {
    Text = "Boss mức máu 10%"
  },
  State_84140_Desc = {
    Text = "Trong trận chiến này, đã tiêu tốn [Layer] thẻ \"Phân chia tuyến\" qua \"Biển động\"."
  },
  State_84140_Name = {
    Text = "Biển ồn ào"
  },
  State_84184_Name = {
    Text = "Kỹ năng này được hưởng thêm [Layer]% sức mạnh"
  },
  State_84255_Desc = {
    Text = "Đội duy nhất: Khi bắt đầu trận chiến, nhận được lá chắn tương đương với <WeaponEffect_Num:[StateArg1]%> khả năng phòng thủ của người trang bị. Sau khi kích hoạt kháng cự tử vong, lượt tiếp theo sẽ kích hoạt lại hiệu ứng này."
  },
  State_84255_Name = {
    Text = "Hoa tiêu trên biển"
  },
  State_84255_WeaponDesc = {
    Text = "Khi bắt đầu trận chiến, nhận <WeaponEffect_Num:[Block:DescArg1]> điểm khiên. Sau khi kích hoạt kháng cự, lượt tiếp theo sẽ kích hoạt lại hiệu ứng này."
  },
  State_84257_Desc = {
    Text = "Đội duy nhất: Lá chắn do người trang bị gây ra khi cơn điên cuồng bùng phát tăng <WeaponEffect_Num:[StateArg1]%>, sau khi giải phóng cơn điên cuồng, sát thương chí mạng tạm thời của tất cả thể thức tỉnh tăng <WeaponEffect_Num:[StateArg2]%>, mỗi xúc tu có thêm 1% tăng. Mỗi lần khám phá kích hoạt kháng cự tử vong lần đầu tiên, vào đầu lượt tiếp theo hồi phục <WeaponEffect_Num:[StateArg3]%> sinh lực tối đa."
  },
  State_84257_WeaponDesc = {
    Text = "Người trang bị gây tăng cường lá chắn từ cơn thịnh nộ bùng nổ <WeaponEffect_Num:[StateArg1]%>, sau khi phát động cơn thịnh nộ bùng nổ, sát thương bạo kích tạm thời của tất cả thể thức tỉnh tăng <WeaponEffect_Num:[StateArg2]%, mỗi khi có 1 xúc tu sẽ tăng thêm 1%. Mỗi lần kích hoạt kháng cự tử vong trong cuộc thám hiểm, vào đầu lượt tiếp theo sẽ hồi phục <WeaponEffect_Num:[StateArg3]%> sinh lực tối đa."
  },
  State_84272_Desc = {
    Text = "<PVPWeaponKeywords:Bánh xe định mệnh>: Cuối lượt, hồi phục lượng máu đã mất nhiều nhất của đồng đội <Heal:[Heal:StateArg1]>."
  },
  State_84272_Name = {
    Text = "Hoa tiêu trên biển"
  },
  State_84273_Desc = {
    Text = "<PVPWeaponKeywords:Bánh xe định mệnh>：Khi trang bị và bắt đầu lượt, nếu không có <PVPProtectiveKeywords:Hàng rào> nhận [StateArg1] tích<PVPProtectiveKeywords:Hàng rào>，nếu không nhận <Energy:[Energy:StateArg2]> Aliemus."
  },
  State_84273_Name = {
    Text = "Thánh hỏa dẫn lối"
  },
  State_84364_Desc = {
    Text = "Thương harming chí mạng +[Layer]%."
  },
  State_84364_Name = {
    Text = "Sát thương chí mạng"
  },
  State_84368_Desc = {
    Text = "Còn [Layer] lượt tạm nghỉ lạnh."
  },
  State_84368_Name = {
    Text = "Chìm trong biển xa"
  },
  State_84375_Desc = {
    Text = "Khi bắt đầu lượt, nhận được [Layer] điểm khiên."
  },
  State_84375_Name = {
    Text = "Hoa tiêu trên biển"
  },
  State_84376_Desc = {
    Text = "Khi bắt đầu lượt, chữa lành [Layer] điểm cuộc sống."
  },
  State_84376_Name = {
    Text = "Thánh hỏa dẫn lối"
  },
  State_84399_Desc = {
    Text = "Vào cuối mỗi lượt sẽ chịu sát thương tăng thêm 5%, bản thân nhận 2 lớp hàng rào."
  },
  State_84399_Name = {
    Text = "Chìm trong biển xa"
  },
  State_84400_Desc = {
    Text = "Khi lượt tiếp theo bắt đầu, mỗi lớp hàng rào chuyển đổi thành 1 lớp <ReinforcePVEKeywords:Gia cố>."
  },
  State_84400_Name = {
    Text = "\"Lãnh đạo\""
  },
  State_84402_Desc = {
    Text = "Tất cả sát thương nhận vào tăng [Layer]%."
  },
  State_84402_Name = {
    Text = "Lực vượt mức"
  },
  State_89340_Desc = {
    Text = "Chịu thêm [Layer]% thiệt hại xúc tu."
  },
  State_89340_Name = {
    Text = "Râu chạm tăng sát thương"
  },
  State_89422_Desc = {
    Text = "Tất cả người đánh thức tạo ra điên cuồng tăng 100%, mỗi lượt có thể phát ra 2 lần điên cuồng bùng phát."
  },
  State_89422_Name = {
    Text = "\"Trái tim bất khuất\""
  },
  State_89447_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>: Giới hạn bài trên tay + [StateArg2]. Sau \"Bùng nổ cuồng khí\" nhận được [StateArg1] Điểm tính toán."
  },
  State_89447_Name = {
    Text = "Tự do không thể chịu đựng nổi"
  },
  State_89448_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>: Khi kết thúc lượt, khiến đồng minh có sinh lực và lá chắn thấp nhất nhận được  [StateArg1]  lá <PVPDerivativeCardKeywords_16:「Lông đen」>."
  },
  State_89448_Name = {
    Text = "Lông vũ cô độc"
  },
  State_89554_Name = {
    Text = "Côn ánh sáng số phận"
  },
  State_89555_Desc = {
    Text = "Đội duy nhất: Sau khi Người trang bị giải phóng Bùng nổ, tăng Sát thương cơ bản của Bùng nổ lên <WeaponEffect_Num:[StateArg1]%>, Tăng Khiên và Tăng Hồi Phục sinh lực lên <WeaponEffect_Num:[StateArg2]%>, tối đa chồng 5 lần. tỷ lệ đồng điều nhận được khi Người trang bị khám phá tăng lên <WeaponEffect_Num:[StateArg3]%>."
  },
  State_89555_WeaponDesc = {
    Text = "Người trang bị sau khi phát động cơn thịnh nộ bùng phát, tăng sát thương cơ bản của cơn thịnh nộ <WeaponEffect_Num:[StateArg1]%>, tăng hồi phục lá chắn và sinh lực <WeaponEffect_Num:[StateArg2]%>, tối đa cộng dồn 5 lần. Sau khi hoàn thành khám phá, tỷ lệ đồng điều của người trang bị tăng <WeaponEffect_Num:[StateArg3]%>."
  },
  State_89557_Name = {
    Text = "Thấu kính lăng kính"
  },
  State_89559_Desc = {
    Text = "\n·Có mâu thuẫn: Khi bắt đầu khám phá, 75% kháng cự tử vong được chuyển đổi thành tăng Sinh lực tối đa, tối đa chuyển đổi 300% kháng cự tử vong, tối đa tăng 10% Sinh lực tối đa. Mỗi lần kích hoạt kháng cự tử vong sẽ đặt thêm 1 lá \"Ánh sáng tinh tế của chìa khóa bạc\" vào tay.\n·Vết thương vô đáy: Trong trận chiến Lãnh đạo, mỗi khi lượng Sinh lực hồi phục nhận được đạt 100% giới hạn Sinh lực, hiệu ứng hồi Sinh lực nhận được sau đó giảm 25%, nhưng tổng lượng kháng cự tử vong hiện tại tăng 25%, tối đa kích hoạt 3 lần.\n·Thấu kính lăng kính: Khi bắt đầu lượt, nếu phản công vượt quá 2000% giới hạn Sinh lực, số lớp vượt quá sẽ giảm một nửa, và phản công vĩnh viễn tối đa chồng đến 6000% giới hạn Sinh lực; nếu kẻ địch Ngộ độc vượt quá 3000% giới hạn Sinh lực, số lớp vượt quá sẽ giảm một nửa, và Ngộ độc tối đa chồng đến 9000% giới hạn Sinh lực. Lượng Tăng sát thương mà Thể thức tỉnh nhận được từ phản công giảm 70%, nhưng tất cả Ngộ độc và phản công gây ra tăng 10%. Mỗi khi thức tỉnh một Thể thức tỉnh: Sau khi kết thúc lượt nhận được 25% phản công vĩnh viễn hiện tại dưới dạng phản công tạm thời, khi kết thúc lượt của kẻ địch sẽ kích hoạt thêm 25% Ngộ độc cho tất cả kẻ địch.\n·Côn ánh sáng số phận: Số lượt quái vật thường tung \"Nhìn chằm chằm\" trở thành 6 lượt. Khi bắt đầu lượt 15, đặt 1 lá \"Giới hạn quang học\" vào tay: Nạp đầy Năng lượng chìa khóa bạc và điên cuồng của tất cả Thể thức tỉnh đến giá trị tối đa."
  },
  State_89559_Name = {
    Text = "Xoắn khúc không gian"
  },
  State_89567_Desc = {
    Text = "Thẻ bài này tiêu thụ sức tính toán -[StateArg1]."
  },
  State_89567_Name = {
    Text = "Sinh lại trên đất diệt vong"
  },
  State_89568_Desc = {
    Text = "<PVPWeaponKeywords:Bánh xe định mệnh>: Sau khi trang bị bị chết, đưa tất cả \"Kỹ năng\" tiêu hao số học -[StateArg1] của bản thân vào bộ bốc thăm, chủ nhân sẽ chuyển sang đồng minh có cuộc sống còn lại cao nhất."
  },
  State_89568_Name = {
    Text = "Sinh lại trên đất diệt vong"
  },
  State_89571_Name = {
    Text = "\"Nhà hát đang cháy\""
  },
  State_89572_Desc = {
    Text = "Vào đầu lượt, gắn thêm <BurningKeywords:đốt cháy> cho [DescArg1] thẻ bài ngẫu nhiên trong bộ bài, và nhận được [DescArg2] điểm sức mạnh tạm thời. Sau mỗi 2 lượt, số thẻ bài được gắn thêm đốt cháy sẽ tăng thêm 1, sức mạnh tạm thời nhận được sẽ tăng thêm [DescArg3] điểm."
  },
  State_89572_Name = {
    Text = "\"Nhà hát đang cháy\""
  },
  State_89626_Desc = {
    Text = "Sau khi thực hiện Silver key awaken, hãy đặt 1 lá\"Ánh sáng bạc\" vào tay. Sau khi tất cả người đánh thức tỉnh thức hoàn thành, mỗi khi bắt đầu lượt sẽ phát hiện ngẫu nhiên 1 lá người đánh thức hỗ trợ."
  },
  State_89631_Desc = {
    Text = "Nhảy thêm [Layer] lầ"
  },
  State_89634_Desc = {
    Text = "Đánh thức tri thức 4"
  },
  State_89634_Name = {
    Text = "Đánh thức tri thức 4"
  },
  State_89637_Desc = {
    Text = "Thẻ lệnh đầu tiên của mỗi lượt sẽ có hiệu lực thêm 1 lần. Khi tiêu hủy sẽ sinh ra 1 xúc tu. Sau khi chuyển đổi xúc tu về tư thế \"Thịnh nộ\", hiệu ứng nhảy của 2 thẻ lệnh trong lượt này sẽ nhất định kích hoạt và vào không gian Ultra, thời gian hồi chiêu 3 lượt."
  },
  State_89640_Desc = {
    Text = "Thành thạo cõi tăng 200 điểm. Khi tiêu hao lò nung đỏ thẫm, tăng thiệt hại xúc tu lên 15%. Mỗi lần tấn công xúc tu, tích lũy [Arg3] điểm lò nung đỏ thẫm."
  },
  State_89642_Desc = {
    Text = "Giới hạn thẻ +2, sau khi phát phóng Aliemus kíp nổ, sát thương cuối cùng tạm thời tăng 10%. Thẻ vào không gian Ultra sau đó, 1 phôi thai trong tay chuyển thành 「Thánh tử」. Mỗi khi tạo ra 1 phôi thai, giảm 1 số học tiêu thụ của một thẻ ngẫu nhiên trong không gian Ultra."
  },
  State_89669_Desc = {
    Text = "Silver key awaken 4"
  },
  State_89669_Name = {
    Text = "Silver key awaken 4"
  },
  State_89759_Desc = {
    Text = "Sau khi giải phóng chìa khóa, Ramona nhận được 50% tỷ lệ chí mạng tạm thời."
  },
  State_89759_Name = {
    Text = "Liên kết quý giá"
  },
  State_90023_Name = {
    Text = "Trạng thái dành cho cấu hình bảng hằng số, tạm thời đã bị bỏ."
  },
  State_90059_Desc = {
    Text = "Trong lượt này khi chịu sát thương chủ động hoặc sát thương từ xúc tu, loại bỏ cùng lượng xâm thực và mất [DescArg1]% cuộc sống của lượng đã loại bỏ, khi chịu sát thương khác chỉ loại bỏ 50% lượng sát thương xâm thực."
  },
  State_90059_Name = {Text = "Xói mòn"},
  State_90094_Name = {Text = "Lông đen"},
  State_90218_Desc = {
    Text = "Đội ngũ duy nhất: giới hạn bài tay +2, hiệu ứng cùng loại không thể cộng dồn. Người trang bị gây ra khiên và sát thương cơ bản tăng <WeaponEffect_Num:[StateArg1]%>, vào vòng siêu chiều nhận được <WeaponEffect_Num:[StateArg2]> điểm điên loạn. Sau khi phát động \"Tiêu diệt\", tất cả người đánh thức tạm thời có sát thương chí mạng +<WeaponEffect_Num:[StateArg3]%>, hồi chiêu 3 lượt."
  },
  State_90218_WeaponDesc = {
    Text = "Giới hạn thẻ bài +2, hiệu ứng cùng loại không thể chồng chéo. Sát thương cơ bản và khiên do người trang bị gây ra tăng <WeaponEffect_Num:[StateArg1]%>, sau khi vào lượt Siêu việt sẽ nhận được <WeaponEffect_Num:[StateArg2]> điểm Cuồng khí. Sau khi giải phóng \"Hủy diệt\", tất cả người đánh thức tạm thời gây sát thương chí mạng +<WeaponEffect_Num:[StateArg3]%>, thời gian hồi chiêu 3 lượt."
  },
  State_90221_Desc = {
    Text = "Đội ngũ duy nhất: Khiên do người trang bị gây ra tăng <WeaponEffect_Num:[StateArg1]%>, nhận khiên bằng với <WeaponEffect_Num:[StateArg2]%> lực phòng thủ của người trang bị khi kết thúc lượt, tăng 2% lực phòng thủ mỗi lượt."
  },
  State_90221_Name = {
    Text = "Lông vũ cô độc"
  },
  State_90221_WeaponDesc = {
    Text = "Mức tăng khiên do người sử dụng gây ra tăng <WeaponEffect_Num:[StateArg1]%>, cuối lượt nhận <WeaponEffect_Num:[Block:DescArg1]> điểm khiên."
  },
  State_90294_Desc = {
    Text = "Trong lượt này khi chịu sát thương chủ động hoặc sát thương từ xúc tu, loại bỏ cùng lượng xâm thực và mất [DescArg1]% cuộc sống của lượng đã loại bỏ, khi chịu sát thương khác chỉ loại bỏ 50% lượng sát thương xâm thực."
  },
  State_90294_Name = {
    Text = "<Corrosion:Xói mòn>"
  },
  State_90591_Name = {
    Text = "Đặt [Layer] tấm \"cảm hứng\" vào tay"
  },
  State_90594_Name = {
    Text = "Và [Layer] chuẩn bị tình trạng cảnh giác tạm thời"
  },
  State_90599_Name = {
    Text = "Kích hoạt tất cả người đánh thức nhận được [Layer] điểm điên cuồng"
  },
  State_90600_Name = {
    Text = "Nhận được [Layer] điểm năng lượng S-bạc"
  },
  State_90601_Name = {
    Text = "(Số lần còn lại [DescArg1] lần<harmonyKeyWord:「Điều hòa」>)"
  },
  State_90603_Name = {
    Text = "Nhận được [Layer] điểm sức mạnh tạm thời"
  },
  State_90604_Name = {
    Text = "Hồi phục [Layer] điểm Cuộc sống, tăng theo số Cuộc sống đã mất."
  },
  State_90696_Desc = {
    Text = "Trước khi chơi, phát hiện 1 hương liệu và đặt vào trong đó để kích hoạt hiệu ứng của nó, trong trận chiến với thủ lĩnh tăng thêm 1 lần hòa hợp."
  },
  State_90696_Name = {
    Text = "<harmonyKeyWord:điều hòa>"
  },
  State_91106_Desc = {
    Text = "Mỗi lớp cuồng nhiệt gây ra sát thương chủ động và thiệt hại xúc tu đều đi kèm 10% sát thương tương đương của <BleedingIconKeywords:Chảy máu>."
  },
  State_91106_Name = {
    Text = "Cuồng nhiệt"
  },
  State_91165_Name = {
    Text = "Trứng nhợt nhạt"
  },
  State_91235_Desc = {
    Text = "Khi mất Sinh lực sẽ giảm số lớp tương đương, khi vết thương về 0, tất cả Thể thức tỉnh nhận 10 điên cuồng, đặt lại số lớp vết thương."
  },
  State_91235_Name = {
    Text = "Thương tích"
  },
  State_91236_Name = {
    Text = "Sự kiện Roma áp đặt đếm số sinh mệnh thủ lĩnh"
  },
  State_91329_Desc = {
    Text = "Thẻ bài này tiêu thụ sức tính toán -[StateArg1]."
  },
  State_91329_Name = {Text = "Món ngon"},
  State_91521_Desc = {
    Text = "<PVPWeaponKeywords:Bánh xe định mệnh>: Khi hết lượt, đặt [StateArg1] lá <PVPDerivativeCardKeywords_17:「Cảm hứng」> vào bài trên tay."
  },
  State_91521_Name = {
    Text = "Huấn luyện đồng đội"
  },
  State_91522_Desc = {
    Text = "<PVPWeaponKeywords:Bánh xe định mệnh>: Khi trang bị và khi hết lượt, người trang bị gây <Damage:[Damage:StateArg1]> sát thương cho kẻ thù ở hàng sau."
  },
  State_91522_Name = {
    Text = "Ngày khai giảng"
  },
  State_91676_Desc = {
    Text = "Cụ thể hiệu ứng xem logic tấn công chung.__\"Chỉ dùng cho phát triển\""
  },
  State_91706_Desc = {
    Text = "Vào đầu vòng tiếp theo sẽ nhận được số lượng tầng bằng nhau của số học."
  },
  State_91706_Name = {
    Text = "<CardKeyWord:Bảo lưu số học>"
  },
  State_91717_Desc = {
    Text = "Tích tối đa 3 tàn dư, khi đạt giới hạn \"Bữa tiệc thịnh soạn của sinh linh\" tiếp theo có thể tiêu thụ chúng và tăng cường hiệu ứng. Tàn dư sẽ thừa kế sang trận chiến tiếp theo."
  },
  State_91717_Name = {
    Text = "Mảnh vỡ"
  },
  State_91759_Desc = {
    Text = "Hắc Vũ có thể tăng cường khả năng của \"Thánh Tử·Hắc Vũ\"."
  },
  State_91759_Name = {Text = "Lông đen"},
  State_91761_Desc = {
    Text = "\"Thánh tử·Hắc Vũ\" sẽ giữ lại 50% khiên chưa bị phá hủy cho đến lượt tiếp theo, sau khi kết thúc lượt sẽ nhận được 1 tầng<Guaiwuheiyu:Hắc Vũ>."
  },
  State_91761_Name = {
    Text = "Khát vọng bay cao"
  },
  State_91797_Desc = {
    Text = "Khi Thẻ này được phát ra và khi bị loại bỏ, áp dụng Khiên bằng số lớp tương đương cho kẻ địch ở hàng trước."
  },
  State_91797_Name = {
    Text = "<PVPredKeyword:đau khổ tiềm ẩn>"
  },
  State_91799_Desc = {
    Text = "Khi Thẻ này được phát ra, áp dụng Khiên [Layer] cho kẻ địch ở hàng trước."
  },
  State_91799_Name = {
    Text = "<PVPredKeyword:Đau khổ tiềm ẩn [Layer] >"
  },
  State_91809_Desc = {
    Text = "Tiêu hao Số học của Thẻ này -[Layer]。"
  },
  State_91809_Name = {
    Text = "Tập trung tinh thần"
  },
  State_91819_Desc = {
    Text = "Nhận thay đổi tương ứng dựa theo số lượt hiện tại của trận chiến."
  },
  State_91819_Name = {
    Text = "<CardKeyWord:Phát triển>"
  },
  State_91827_Desc = {
    Text = "\"Công kích\" có thể chọn mục tiêu, trước khi \"Công kích\"đẩy lùi tất cả trạng thái tích cực của mục tiêu về phía sau người đánh thức."
  },
  State_91827_Name = {
    Text = "<CardKeyWord:Tiếng gọi của đại dương>"
  },
  State_94410_Name = {
    Text = "Mỗi lần bắt đầu lượt và kết thúc hành động sẽ cố gắng tái lập bộ bài của người chơi nếu trống, nếu không trống thì sẽ không tái lập.__\"Chỉ dùng cho phát triển\""
  },
  State_94411_Name = {
    Text = "Mỗi lần bắt đầu lượt và kết thúc hành động sẽ cố gắng tái lập bộ bài của người chơi nếu trống, nếu không trống thì sẽ không tái lập.__\"Chỉ dùng cho phát triển\""
  },
  State_94426_Name = {
    Text = "lá chắn bị động__\"Chỉ dùng cho phát triển\""
  },
  State_94540_Desc = {
    Text = "Nếu phía sau mục tiêu không có người đánh thức khác, thì giải tán trạng thái chính diện của mục tiêu."
  },
  State_94540_Name = {
    Text = "<CardKeyWord:Đẩy lùi trạng thái tích cực>"
  },
  State_94600_Desc = {
    Text = "Sau khi nhận sát thương chí mạng, loại bỏ 1 lớp và hồi phục 5% máu tối đa, mỗi lần kích hoạt trong lượt này làm tăng lượng hồi phục thêm 1%."
  },
  State_94600_Name = {
    Text = "kháng cự tử vong"
  },
  State_94603_Name = {
    Text = "Dấu ấn xác sống"
  },
  State_94608_Name = {
    Text = "Số lần kích hoạt kháng cự cái chết"
  },
  State_94623_Desc = {
    Text = "Mỗi lớp cuồng nhiệt gây ra sát thương chủ động và thiệt hại xúc tu đều đi kèm 10% sát thương tương đương của <BleedingIconKeywords:Chảy máu>."
  },
  State_94623_Name = {
    Text = "<Kuangre:Cuồng nhiệt>"
  },
  State_94657_Desc = {
    Text = "Khi tiêu diệt hoặc kích hoạt hiệu ứng hồi sinh của kẻ thù, kích hoạt hiệu ứng tương ứng"
  },
  State_94657_Name = {
    Text = "<KillKeywords:Đánh bại>"
  },
  State_94692_Desc = {
    Text = "Sau khi nhận sát thương chí mạng, loại bỏ 1 lớp và hồi phục 5% máu tối đa, mỗi lần kích hoạt trong lượt này làm tăng lượng hồi phục thêm 1%."
  },
  State_94692_Name = {
    Text = "<Guaiwusiwangdikang: Kháng cự cái chết>"
  },
  State_94693_Desc = {
    Text = "Khi bắt đầu vòng, nếu có đồng minh khác, mất [DescArg1] điểm cuộc sống, tăng 1 lớp <Guaiwusiwangdikang: Kháng cự tử vong> và [DescArg2] điểm <PowerIconKeywords: sức mạnh> cho đồng minh có cuộc sống cao nhất."
  },
  State_94693_Name = {
    Text = "Đồng hoá xác chết"
  },
  State_94708_Desc = {
    Text = "Khi bắt đầu vòng, nếu có đồng minh khác, mất [DescArg1] điểm cuộc sống, tăng 1 lớp <Guaiwusiwangdikang: Kháng cự tử vong> và [DescArg2] điểm <Duren: Độc đao>."
  },
  State_94708_Name = {
    Text = "Sự phân chia của đại dương"
  },
  State_94730_Desc = {
    Text = "Khi gây sát thương chủ động không bị chắn, gây [Layer] điểm<IntoxicationIconKeywords: Độc dược>."
  },
  State_94730_Name = {
    Text = "Người đầu độc"
  },
  State_94993_Desc = {
    Text = "Đặt lại số lần của sóng giận dữ mỗi lượt."
  },
  State_94993_Name = {
    Text = "Đặt lại số lần cơn thịnh nộ chấn động"
  },
  State_94994_Desc = {
    Text = "Mỗi tầng tăng thêm 1 lần tấn công, chịu sát thương chí mạng mất 1 tầng, tối thiểu 1 tầng, sẽ mất hết sau khi kết thúc lượt."
  },
  State_94994_Name = {
    Text = "Số lần cơn thịnh nộ chấn động"
  },
  State_94995_Desc = {
    Text = "Mỗi lần chịu sát thương chí mạng, nhận 3% <Baojidikang:Kháng chí mạng tạm thời>. Mỗi lần gây sát thương sẽ gán cho một thẻ ngẫu nhiên \"Dấu ấn sâu lặn\"."
  },
  State_94995_Name = {
    Text = "Lễ tế biển sâu"
  },
  State_94996_Desc = {
    Text = "Khi bị tấn công, nhận được số lượng tạm thời sức mạnh tương đương."
  },
  State_94996_Name = {Text = "Hung bạo"},
  State_94997_Desc = {
    Text = "Mỗi lần chịu sát thương chí mạng, nhận 5% <Baojidikang:Kháng chí mạng tạm thời>. Mỗi lần gây sát thương sẽ gán cho một thẻ ngẫu nhiên \"Dấu ấn sâu lặn\"."
  },
  State_94997_Name = {
    Text = "Lễ tế biển sâu"
  },
  State_94998_Desc = {
    Text = "Khi kích hoạt <Guaiwusiwangdikang: Kháng cự cái chết>, áp dụng <SlowIconKeywords: Chậm lại> lên một thẻ ngẫu nhiên từ bốc thăm hoặc tay."
  },
  State_94998_Name = {
    Text = "Hóa thân của tuyệt vọng"
  },
  State_94999_Desc = {
    Text = "Đặt lại số lần của sóng nuốt trời mỗi lượt."
  },
  State_94999_Name = {
    Text = "Đặt lại số lần sóng khổng lồ xé trời"
  },
  State_95000_Desc = {
    Text = "Miễn nhiễm trạng thái tiêu cực."
  },
  State_95000_Name = {
    Text = "Miễn dịch trạng thái tiêu cực"
  },
  State_95001_Desc = {
    Text = "Mỗi tầng tăng thêm 1 lần tấn công, chịu sát thương chí mạng mất 1 tầng, tối thiểu 1 tầng, sẽ mất hết sau khi kết thúc lượt."
  },
  State_95001_Name = {
    Text = "Số lần sóng khổng lồ xé trời"
  },
  State_95002_Desc = {
    Text = "Xác suất bị chí mạng trong lượt này giảm [Layer]%."
  },
  State_95002_Name = {
    Text = "Kháng chí mạng tạm thời"
  },
  State_95002_WeaponDesc = {
    Text = "Xác suất bị chí mạng trong lượt này giảm [Layer]%."
  },
  State_95035_Desc = {
    Text = "Khi gây sát thương chủ động không bị chắn, với mỗi 1 tầng, gây 1 điểm<IntoxicationIconKeywords: Độc dược>."
  },
  State_95035_Name = {
    Text = "<Duren: Lưỡi dao độc>"
  },
  State_95038_Desc = {
    Text = "Khi bị tấn công, nhận được số lượng tạm thời sức mạnh tương đương."
  },
  State_95038_Name = {
    Text = "<Kuangbao:Cơn điên>"
  },
  State_95040_Desc = {
    Text = "Đã ghi lại về việc mất cuộc sống"
  },
  State_95040_Name = {
    Text = "Đã ghi lại về việc mất cuộc sống"
  },
  State_95932_Name = {
    Text = "Hấp thụ xác sống chờ đợi"
  },
  State_95937_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>:\"Bùng nổ\" rút [StateArg1] lá bài, ưu tiên rút \"kỹ năng\" của bản thân, và tiêu thụ sức tính toán - [StateArg2]."
  },
  State_95937_Name = {Text = "Món ngon"},
  State_95938_Desc = {
    Text = "Mỗi khi loại bỏ một thẻ, số tầng thỏa mãn +1, giới hạn tối đa 10 tầng"
  },
  State_95938_Name = {Text = "Bão hòa"},
  State_95943_Desc = {
    Text = "Sát thương gây ra tạm thời giảm 30%."
  },
  State_95943_Name = {
    Text = "Giao thoa tích cực"
  },
  State_95944_Desc = {
    Text = "Đội ngũ duy nhất: sát thương cơ bản của người trang bị tăng <WeaponEffect_Num:[StateArg1]%>, mỗi khi gây ra 1 lần tiêu diệt sẽ khiến tỷ lệ chí mạng của người trang bị trong lần khám phá này tăng 2% và sát thương cơ bản của điên loạn tăng <WeaponEffect_Num:[StateArg2]%>, tối đa cộng dồn 10 lần. Nếu cõi hiện tại là\"Máu thịt\", khi sử dụng \"Phôi thai\" trực tiếp lên người trang bị sẽ nhận thêm <WeaponEffect_Num:[StateArg4]> điểm điên loạn, hồi chiêu 3 lượt."
  },
  State_95944_WeaponDesc = {
    Text = "Sát thương cơ bản gây ra bởi người trang bị được tăng <WeaponEffect_Num:[StateArg1] %>, mỗi lần gây ra một cú giết chóc sẽ khiến tỷ lệ chí mạng của người trang bị trong cuộc thám hiểm này tăng 2% và sát thương cơ bản do điên loạn bùng nổ gia tăng <WeaponEffect_Num:[StateArg2] %>, tối đa tích lũy 10 lần. Nếu cõi hiện tại là \"Caro\", khi trực tiếp sử dụng \"phôi thai\" lên người trang bị sẽ nhận thêm <WeaponEffect_Num:[StateArg4]> điên loạn, thời gian hồi 3 lượt."
  },
  State_95948_Name = {
    Text = "Hấp thụ xác sống"
  },
  State_95949_Desc = {
    Text = "Sau khi phát động, Dulecai mất một nửa <Guaiwucanhai: mảnh vỡ>."
  },
  State_95949_Name = {
    Text = "Dự bị phục kích"
  },
  State_95953_Desc = {
    Text = "Hiệu ứng hồi phục sinh mệnh của kháng cự cái chết được tăng lên 5 lần."
  },
  State_95953_Name = {
    Text = "Màn che của giấc mơ mờ ảo"
  },
  State_95954_Name = {
    Text = "Hấp thụ xác sống phiên bản thức tỉnh"
  },
  State_95960_Desc = {
    Text = "Số lượng đống đổ nát sẽ tăng cường hiệu ứng của \"Tiếp nhận đống đổ nát\"."
  },
  State_95960_Name = {
    Text = "Mảnh vỡ"
  },
  State_95962_Name = {
    Text = "Số lần giết__\"chỉ dùng cho phát triển\""
  },
  State_95964_Desc = {
    Text = "Đội ngũ duy nhất: sát thương cơ bản của người trang bị tăng <WeaponEffect_Num:[StateArg1]%>. Nếu cõi hiện tại là\"Máu thịt\", khi người trang bị tiêu diệt kẻ thù sẽ tích lũy sức tấn công của người trang bị <WeaponEffect_Num:[StateArg2]%> của lò nung đỏ thẫm."
  },
  State_95964_WeaponDesc = {
    Text = "Sát thương cơ bản gây ra bởi người trang bị được tăng <WeaponEffect_Num:[StateArg1]%>. Nếu cõi hiện tại là “Caro”, khi người trang bị giết chết kẻ thù sẽ tích lũy <WeaponEffect_Num:[DescArg1]> điểm Bạc."
  },
  State_95966_Desc = {
    Text = "Lúc bắt đầu lượt tiếp theo, rút [Layer] lá bài thể người đánh thức này."
  },
  State_95966_Name = {
    Text = "Lời chào tàn nhẫn"
  },
  State_95967_Desc = {
    Text = "Số lượng đống đổ nát sẽ tăng cường hiệu ứng của \"Tiếp nhận đống đổ nát\"."
  },
  State_95967_Name = {
    Text = "<Guaiwucanhai:Xác thối>"
  },
  State_95968_Desc = {
    Text = "<PVPWeaponKeywords:Bánh xe định mệnh>：Khi trang bị nhận được [StateArg1] <StrongEffectKeywords:Mạnh>. Khi tiêu diệt kẻ địch, sát thương dư sẽ truyền đến người đánh thức phía sau。"
  },
  State_95968_Name = {
    Text = "Nụ hôn yên nghĩ"
  },
  State_96167_Desc = {
    Text = "Không thể giải trừ, sau khi thể thức tỉnh bị giết, các đồng minh khác nhận được [StateArg1] <StrongEffectKeywords:Mạnh>."
  },
  State_96167_Name = {
    Text = "Tàn tro sao đen cháy rực"
  },
  State_96183_Desc = {
    Text = "Khi kết thúc vòng, nếu không có đồng minh khác trên sân, chuyển ý định thành tự phát nổ"
  },
  State_96183_Name = {
    Text = "Ghoul tự hủy diệt"
  },
  State_96193_Name = {
    Text = "Lễ nghi trước bữa ăn"
  },
  State_96330_Desc = {
    Text = "Bản thân mỗi khi mất 1% sức sống, thẻ lệnh của Dursein gây ra sát thương cơ bản, khiên, và điên loạn tăng thêm 1%."
  },
  State_96330_Name = {
    Text = "Lời thì thầm của hồn ma"
  },
  State_96352_Name = {
    Text = "Số lượng xác sống đầu tiên"
  },
  State_96354_Name = {
    Text = "Mức máu tối đa khởi đầu"
  },
  State_96355_Desc = {
    Text = "Giảm khả năng bị chí mạng [Layer]%."
  },
  State_96355_Name = {
    Text = "Kháng chí mạng"
  },
  State_96355_WeaponDesc = {
    Text = "Xác suất bị chí mạng trong trận đấu này giảm [Layer]%."
  },
  State_96356_Desc = {
    Text = "Mỗi khi mất [DescArg1] điểm sức sống, sẽ nhận được [DescArg2] lớp <ReinforcePVEKeywords: gia cố>, tối đa là [DescArg3] lớp. Sau khi kích hoạt \"<Guaiwusiwangdikang: kháng cự cái chết>\", sức sống tối đa của bản thân tăng [DescArg4] %."
  },
  State_96356_Name = {
    Text = "Bảo vệ của Ilaine"
  },
  State_96357_Desc = {
    Text = "Sau khi lượt kết thúc, nhận được số tầng lực lượng tương ứng."
  },
  State_96357_Name = {
    Text = "<Fennu:Cơn giận>"
  },
  State_96358_Desc = {
    Text = "Giảm khả năng bị chí mạng [Layer] %."
  },
  State_96358_Name = {
    Text = "<Baojidikang:Kháng thương>"
  },
  State_96412_Name = {
    Text = "Thượng đế lắng nghe"
  },
  State_96416_Desc = {
    Text = "Giảm khả năng bị chí mạng [Layer]%."
  },
  State_96416_Name = {
    Text = "Kháng chí mạng"
  },
  State_96603_Name = {
    Text = "Nếu lượt này không sử dụng, đầu lượt sau kích hoạt 1 lần \"Điều hòa\" hiệu ứng"
  },
  State_96610_Name = {
    Text = "Kháng cự lần đầu tiên"
  },
  State_96613_Name = {
    Text = "Lắng nghe sóng thần"
  },
  State_96650_Desc = {
    Text = "Mỗi tầng làm tăng tỉ lệ chí mạng của tất cả các thể thức tỉnh lên [DescArg1]%."
  },
  State_96650_Name = {
    Text = "<ExclamationPointColour:Ngọn lửa thâm u>"
  },
  State_96719_Desc = {
    Text = "Trong lượt này, khi đánh ra thẻ bài <BurningKeywords:đốt cháy>, tiêu thụ 1 tầng <Heat:Ngọn lửa thâm u> để nó có hiệu lực 2 lần, và sẽ xóa bỏ <Heat:Ngọn lửa thâm u> khi lượt kết thúc."
  },
  State_96719_Name = {
    Text = "Bùng cháy vô tận"
  },
  State_96731_Desc = {
    Text = "Trong lượt này, khi đánh ra thẻ bài <BurningKeywords:đốt cháy>, tiêu thụ 1 tầng <Heat:Ngọn lửa thâm u> để nó có hiệu lực 2 lần, và sẽ xóa bỏ <Heat:Ngọn lửa thâm u> khi lượt kết thúc."
  },
  State_96731_Name = {
    Text = "<Overload:Bùng cháy vô tận>"
  },
  State_96732_Desc = {
    Text = "Mỗi tầng làm tăng tỉ lệ chí mạng của tất cả các thể thức tỉnh lên [DescArg1]%."
  },
  State_96732_Name = {
    Text = "<Heat:Ngọn lửa thâm u>"
  },
  State_96740_Desc = {
    Text = "Sát thương tấn công chủ động và số tầng chảy máu nhận vào tăng 50%, sẽ bị loại bỏ khi nhận sát thương hoặc khi bắt đầu lượt."
  },
  State_96740_Name = {
    Text = "<CardKeyWord:Điểm yếu>"
  },
  State_96741_Desc = {
    Text = "Sau khi chơi, nếu sức tính toán còn lại lớn hơn [StateArg1], tiêu thụ thêm [StateArg1] điểm tính toán để kích hoạt hiệu ứng tiếp theo.__\"Chỉ dùng cho phát triển\""
  },
  State_96741_Name = {
    Text = "<CardKeyWord:Số học quá tải>__\"Chỉ dùng cho phát triển\""
  },
  State_96742_Name = {
    Text = "Dấu hiệu kích hoạt quá tải số học__\"Chỉ dùng cho phát triển\""
  },
  State_96743_Desc = {
    Text = "Sau khi đánh ra, nếu sức mạnh còn lại lớn hơn sức mạnh cần thiết cho quá tải sức mạnh, tiêu hao sức mạnh sẽ kích hoạt hiệu ứng tiếp theo."
  },
  State_96743_Name = {
    Text = "<CardKeyWord:Số học quá tải>"
  },
  State_96744_Desc = {
    Text = "Sát thương tấn công chủ động và số tầng chảy máu nhận vào tăng 50%, sẽ bị loại bỏ khi nhận sát thương hoặc khi bắt đầu lượt."
  },
  State_96744_Name = {
    Text = "Khuyết điểm"
  },
  State_96774_Desc = {
    Text = "Mỗi lần nhận sát thương chí mạng, nhận thêm 3% kháng chí mạng tạm thời."
  },
  State_96774_Name = {
    Text = "Oán linh Aequor"
  },
  State_96780_Desc = {
    Text = "Thẻ bài được giữ lại, nhưng khi chơi hoặc vứt bỏ sẽ loại bỏ ô nhiễm và triệu hồi 1 \"Thể phân thực biển sâu\", tối đa 2 cái. Nếu không có vị trí để triệu hồi, sẽ ngay lập tức khiến Bù nhìn của dòng chảy thối rữa nhận được [DescArg1] điểm lực lượng và [DescArg2] điểm sinh lực."
  },
  State_96780_Name = {
    Text = "<Kuangluan:Cơn điên của Thủy thủ>"
  },
  State_96783_Desc = {
    Text = "Mỗi lượt, thêm \"<Kuangluan:Ô nhiễm: Thủy thủ điên cuồng>\" cho 2 thẻ."
  },
  State_96783_Name = {
    Text = "Lễ tế người dấn thân vào biển"
  },
  State_96784_Desc = {
    Text = "Có thể giảm bớt cuộc tấn công của Bục điều khiển Tạp mục, tối đa là 5 lớp."
  },
  State_96784_Name = {
    Text = "Hỗn loạn"
  },
  State_96808_Desc = {
    Text = "Mỗi lần mất [DescArg1] cuộc sống, nhận 15 tầng \"<ReinforcePVEKeywords:Gia cố>\"，giới hạn là 75 tầng, sau khi bị phá vỡ sẽ xóa sạch và nhận 1 tầng \"<Chaos:Hỗn loạn>\". Nếu chưa từng triển khai \"Xương thịt tái tổ hợp\"，sau khi nhận sát thương chí mạng sẽ chuyển ý định sang \"Xương thịt tái tổ hợp\" và miễn nhiễm mọi sát thương."
  },
  State_96808_Name = {
    Text = "\"Con rối Hòa hợp\""
  },
  State_96809_Name = {
    Text = "Số đếm Búp Bê Hợp Thể"
  },
  State_96810_Desc = {
    Text = "Giảm 25% sát thương gây ra."
  },
  State_96810_Name = {
    Text = "Màn che của giấc mơ mờ ảo"
  },
  State_96813_Name = {
    Text = "Tái cấu trúc dấu"
  },
  State_97114_Desc = {
    Text = "<PVPWeaponKeywords:vòng mệnh>:\"Tấn công\" nhận được [StateArg1] sức tính toán，\"kỹ năng\" sát thương tăng [StateArg2]%."
  },
  State_97114_Name = {
    Text = "Mặt trời sắp đến"
  },
  State_97118_Name = {
    Text = "Búp Bê Hợp Thể phá vỡ"
  },
  State_97119_Desc = {
    Text = "Thẻ bài được giữ lại, nhưng khi chơi hoặc vứt bỏ sẽ loại bỏ ô nhiễm và triệu hồi 1 \"Thể phân thực biển sâu\", tối đa 2 cái. Nếu không có vị trí để triệu hồi, sẽ ngay lập tức khiến Bù nhìn của dòng chảy thối rữa nhận được [DescArg1] điểm lực lượng và [DescArg2] điểm sinh lực."
  },
  State_97119_Name = {
    Text = "<Kuangluan:Cơn điên của Thủy thủ>"
  },
  State_97120_Desc = {
    Text = "Bị vòng tròn ma thuật bảo vệ, tất cả kẻ thù gây tổn thương giảm đi 25%."
  },
  State_97120_Name = {
    Text = "Màn che của giấc mơ mờ ảo"
  },
  State_97131_Desc = {
    Text = "<PVPWeaponKeywords:Vòng mệnh>: Mỗi 1 Điểm tính toán \"kỹ năng\" cần tiêu thụ thì Sát thương tăng lên [StateArg1]%. Sau khi Giết, thương của \"Bùng nổ\" tăng lên [StateArg2]%, hiện tại tăng [DescArg1]%."
  },
  State_97131_Name = {
    Text = "Cái chết màu hổ phách"
  },
  State_97134_Desc = {
    Text = "Tăng 50% sát thương cuối cùng gây ra."
  },
  State_97134_Name = {
    Text = "Sự tụng niệm của Selene"
  },
  State_97135_Desc = {
    Text = "Tăng 25% sát thương cuối cùng gây ra."
  },
  State_97135_Name = {
    Text = "Lời thì thầm của Selene"
  },
  State_97136_Desc = {
    Text = "Tăng 100% sát thương cuối cùng gây ra."
  },
  State_97136_Name = {
    Text = "Bài ca cao của Selene"
  },
  State_97137_Desc = {
    Text = "Vứt bỏ xong quay lại vào tay."
  },
  State_97137_Name = {
    Text = "Vứt bỏ xong quay lại vào tay"
  },
  State_97137_WeaponDesc = {
    Text = "Sau khi rút khiến bản thân yếu đuối 1 lượt. Sau khi sử dụng, khiến tất cả kẻ địch yếu đuối 1 lượt. Không thể bán."
  },
  State_97219_Desc = {
    Text = "[Layer] lá bài tiếp theo mà Wanda đánh ra sẽ phát huy hiệu lực thêm 1 lần."
  },
  State_97219_Name = {
    Text = "Nữ Hoàng Gai"
  },
  State_97251_Desc = {
    Text = "·Không trở thành mục tiêu tấn công ưu tiên của đối thủ, và khi đối thủ chọn mục tiêu đơn lẻ không thể chọn Thể thức tỉnh ẩn nấp\n·Khi nhận được ẩn nấp sẽ gỡ bỏ khiêu khích của bản thân và ẩn nấp của các đồng minh khác. Nếu không có đồng minh khác hoặc kẻ thù nhận được khiêu khích, sẽ gỡ bỏ ẩn nấp."
  },
  State_97251_Name = {Text = "Lén lút"},
  State_97252_Desc = {
    Text = "·Không trở thành mục tiêu tấn công ưu tiên của đối thủ, và khi đối thủ chọn mục tiêu đơn lẻ không thể chọn Thể thức tỉnh ẩn nấp\n·Khi nhận được ẩn nấp sẽ gỡ bỏ khiêu khích của bản thân và ẩn nấp của các đồng minh khác. Nếu không có đồng minh khác hoặc kẻ thù nhận được khiêu khích, sẽ gỡ bỏ ẩn nấp."
  },
  State_97252_Name = {
    Text = "<PVPSneakKeywords:Ẩn náu>"
  },
  State_97339_Name = {
    Text = "Chiếc cúp vô địch Mythag"
  },
  State_97742_Desc = {
    Text = "Mỗi lần chịu Sát thương chủ động, gây [Layer] điểm <FixedDamage:Sát Thương Thuần Túy> lên nguồn gây sát thương."
  },
  State_97742_Name = {
    Text = "phản công"
  },
  State_97743_Desc = {
    Text = "Thương chủ động gây ra tăng [Layer] điểm."
  },
  State_97743_Name = {
    Text = "<PowerColourKeywords:lực lượng>"
  },
  State_97744_Desc = {
    Text = "Giảm tất cả sát thương nhận vào [Layer] %."
  },
  State_97744_Name = {
    Text = "<ReinforceColour:củng cố>"
  },
  State_97744_WeaponDesc = {
    Text = "Mọi sát thương gây ra bị giảm [DescArg1] %."
  },
  State_97938_Desc = {
    Text = "Sát thương cuối cùng tăng [DescArg1]%."
  },
  State_97938_Name = {
    Text = "Chiếc cúp vô địch Mythag"
  },
  State_97939_Desc = {
    Text = "Tăng 50% sát thương cuối cùng gây ra."
  },
  State_97939_Name = {
    Text = "Chiếc cúp vô địch Mythag"
  },
  State_97941_Desc = {
    Text = "Tăng sát thương cơ bản 100%."
  },
  State_97941_Name = {
    Text = "Chiếc cúp vô địch Mythag"
  },
  State_97942_Desc = {
    Text = "Khi phát động Aliemus bùng nổ, nhận được 35 điểm Aliemus."
  },
  State_97942_Name = {
    Text = "Chiếc cúp vô địch Mythag"
  },
  State_97943_Name = {
    Text = "Giữ lại số học"
  },
  State_98055_Desc = {
    Text = "Khi lượt kết thúc, triệu hồi 1 râu chạm. Sau khi thức tỉnh, loại bỏ trạng thái này."
  },
  State_98055_Name = {Text = "Ngủ"},
  State_98060_Desc = {
    Text = "Thân thể được đánh thức này chưa thức tỉnh… Khi sắp ngã gục sẽ thức tỉnh, hồi phục sức sống và bắt đầu chiến đấu với hình thái thật sự."
  },
  State_98060_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_98068_Desc = {
    Text = "Khi sở hữu 10 lớp \"Nổ lửa\"，nhận 2 điểm số học và nâng cấp tất cả\"Khế ước ánh sáng\" thành \"Khế ước đại diện\"."
  },
  State_98068_Name = {
    Text = "<BaoyanKeywords:Bộc phát>"
  },
  State_98139_Desc = {
    Text = "Sau khi bắt đầu lượt của đối phương, ngẫu nhiên <BurningKeywords:đốt cháy> 1 lá bài trong tay."
  },
  State_98139_Name = {
    Text = "Ngọn lửa nghiệp báo bùng cháy lại"
  },
  State_98140_Desc = {
    Text = "Tích lũy 10 tầng <MonsterExFlameKeywords:Bạo Hỏa> sau đó chuyển đổi ý định thành \"Tia Sáng Rực Rỡ Vô Hạn\" với sát thương cực cao!"
  },
  State_98140_Name = {
    Text = "<BurningColor:ngọn lửa bùng cháy>"
  },
  State_98147_Desc = {
    Text = "Khi kẻ địch đánh ra thẻ bài <BurningKeywords:đốt cháy>, khiến bản thân nhận 1 lớp <MonsterExFlameKeywords:ngọn lửa bùng cháy>, nhưng tạm thời giảm [DescArg1] <PowerIconKeywords:lực lượng>."
  },
  State_98147_Name = {
    Text = "Ngọn Lửa Bất Diệt"
  },
  State_98148_Desc = {
    Text = "Thân thể được đánh thức này chưa thức tỉnh… Khi sắp ngã gục sẽ thức tỉnh, bỏ tất cả bài còn lại và ban cho <BurningKeywords:đốt cháy>, hồi phục sức sống và bắt đầu chiến đấu với hình thái thật sự."
  },
  State_98148_Name = {
    Text = "Chưa Khai mở linh trí"
  },
  State_98302_Desc = {
    Text = "Đội duy nhất: Sát thương cơ bản do người trang bị gây ra tăng <WeaponEffect_Num:[StateArg1]%>, hiệu quả thu được sức mạnh tăng <WeaponEffect_Num:[StateArg2]%>. Sau khi chơi thẻ lệnh của người trang bị, nhận được sức mạnh tạm thời bằng <WeaponEffect_Num:[StateArg3]%> sức mạnh của người trang bị, tối đa kích hoạt 5 lần mỗi lượt."
  },
  State_98302_WeaponDesc = {
    Text = "Thiệt hại cơ bản mà người trang bị gây ra tăng <WeaponEffect_Num:[StateArg1]%>, sức mạnh gây ra tăng <WeaponEffect_Num:[StateArg2]%>. Sau khi tung ra thẻ lệnh của người trang bị, nhận được <WeaponEffect_Num:[Power:DescArg1]> điểm sức mạnh tạm thời, tối đa kích hoạt 5 lần mỗi lượt (hiện tại đã kích hoạt [DescArg2]/5 lần)."
  },
  State_98323_Desc = {
    Text = "Sau khi lá bài bị loại bỏ sẽ quay trở lại tay."
  },
  State_98323_Name = {
    Text = "Trở lại tay sau khi bị bỏ rơi"
  },
  State_98341_Desc = {
    Text = "Có thể hòa trộn với các màu nguyên bản khác, biến thành màu mới."
  },
  State_98341_Name = {
    Text = "<Yellow:Màu gốc·Vàng>"
  },
  State_98344_Desc = {
    Text = "Có thể hòa trộn với các màu nguyên bản khác, biến thành màu mới."
  },
  State_98344_Name = {
    Text = "<Red:Màu gốc·Đỏ>"
  },
  State_98345_Desc = {
    Text = "Có thể hòa trộn với các màu nguyên bản khác, biến thành màu mới."
  },
  State_98345_Name = {
    Text = "<Blue:Nguyên sắc·Xanh>"
  },
  State_98366_Desc = {
    Text = "Khi bắt đầu lượt, nếu năng lượng Chìa khóa bạc lớn hơn [Arg1], tiêu hao [Arg1] điểm năng lượng Chìa khóa bạc để đặt 1 thẻ <DerivativeCardKeywords_115:「Cảm hứng cao cấp」> vào tay bạn."
  },
  State_98435_Desc = {
    Text = "Được điều hòa bởi màu đỏ và màu xanh, mỗi khi gây 1 lần Sát thương chủ động, nhận được <Block: [DescArg1]> điểm Khiên."
  },
  State_98435_Name = {
    Text = "<PurpleKeyWord:Hiện tượng·Tím>"
  },
  State_98436_Desc = {
    Text = "Được điều hòa bởi màu đỏ và màu vàng, sau khi phát động Tôn kính Aliemus, thể Thức tỉnh tương ứng nhận được <Energy:15> điểm Aliemus."
  },
  State_98436_Name = {
    Text = "<ExclamationPointColour:Dị tượng·Cam>"
  },
  State_98437_Desc = {
    Text = "Sát thương cuối cùng gây ra tăng 10%."
  },
  State_98437_Name = {
    Text = "<Red:Màu gốc·Đỏ>"
  },
  State_98438_Desc = {
    Text = "Được điều hòa bởi màu vàng và màu xanh, sau khi thực hiện \"Phòng thủ\", hồi phục <Heal:[DescArg1]> điểm Cuộc sống."
  },
  State_98438_Name = {
    Text = "<GreenWord:Dị tượng·Xanh lá>"
  },
  State_98439_Desc = {
    Text = "Được điều hòa bởi màu vàng và màu xanh, sau khi thực hiện \"Phòng thủ\", hồi phục <Heal:[DescArg1]> điểm Cuộc sống."
  },
  State_98439_Name = {
    Text = "<GreenWord:Dị tượng·Xanh lá>"
  },
  State_98440_Desc = {
    Text = "Được điều hòa bởi màu đỏ và màu xanh, mỗi khi gây 1 lần Sát thương chủ động, nhận được <Block: [DescArg1]> điểm Khiên."
  },
  State_98440_Name = {
    Text = "<PurpleKeyWord:Hiện tượng·Tím>"
  },
  State_98441_Desc = {
    Text = "Được điều hòa bởi màu đỏ và màu vàng, sau khi phát động Tôn kính Aliemus, thể Thức tỉnh tương ứng nhận được <Energy:15> điểm Aliemus."
  },
  State_98441_Name = {
    Text = "<ExclamationPointColour:Dị tượng·Cam>"
  },
  State_98444_Desc = {
    Text = "Đội duy nhất: Sát thương cơ bản do người trang bị gây ra sẽ tăng <WeaponEffect_Num:[StateArg1]%>. Sau khi chơi 5 thẻ lệnh của người trang bị, người trang bị sẽ nhận được <WeaponEffect_Num:[StateArg2]%> tỷ lệ chí mạng tạm thời. Hiệu ứng này chỉ có thể kích hoạt 1 lần mỗi vòng."
  },
  State_98444_WeaponDesc = {
    Text = "Thiệt hại cơ bản do người trang bị gây ra tăng <WeaponEffect_Num:[StateArg1]%>. Sau khi đánh ra 5 thẻ lệnh của người trang bị, người trang bị nhận được <WeaponEffect_Num:[StateArg2]%> tỉ lệ chí mạng tạm thời, hiệu ứng này chỉ có thể kích hoạt 1 lần mỗi lượt (hiện tại đã đánh ra [DescArg1]/5 thẻ)."
  },
  State_98466_Name = {
    Text = "<HuoyanKeywords1:Hỏa diễm1>"
  },
  State_98468_Name = {
    Text = "<HuoyanKeywords3:Hỏa diễm3>"
  },
  State_98470_Name = {
    Text = "<HuoyanKeywords2:Hỏa diễm2>"
  },
  State_98474_Desc = {
    Text = "Có thể pha trộn và tạo ra các màu sắc cơ bản khác, bao gồm màu đỏ, màu vàng và màu xanh."
  },
  State_98474_Name = {
    Text = "Màu nguyên bản"
  },
  State_98484_Name = {
    Text = "chìm trong biển khổ"
  },
  State_98485_Desc = {
    Text = "Hộ thuẫn, Cuồng Khí do lá bài này tạo ra tăng [DescArg2]%, sát thương cuối cùng, Sức Mạnh tăng [DescArg1]%, nhận \"Giữ lại\", sau khi đánh ra sẽ tiêu hao tất cả\"Hoạt Diễm\" và truyền dẫn 1 tầng \"Hoạt Diễm\"đến 1 lá bài chỉ lệnh khác của Katy Gula trong tay."
  },
  State_98485_Name = {
    Text = "<HuoyanKeywords2:Hỏa diễm2>"
  },
  State_98486_Desc = {
    Text = "Hộ thuẫn, Cuồng Khí do lá bài này tạo ra tăng [DescArg2]%, sát thương cuối cùng, Sức Mạnh tăng [DescArg1]%, nhận \"Giữ lại\", sau khi đánh ra sẽ tiêu hao tất cả\"Hoạt Diễm\" và truyền dẫn 1 tầng \"Hoạt Diễm\"đến 1 lá bài chỉ lệnh khác của Katy Gula trong tay."
  },
  State_98486_Name = {
    Text = "<HuoyanKeywords3:Hỏa diễm3>"
  },
  State_98487_Desc = {
    Text = "Hộ thuẫn, Cuồng Khí do lá bài này tạo ra tăng [DescArg2]%, sát thương cuối cùng, Sức Mạnh tăng [DescArg1]%, nhận \"Giữ lại\", sau khi đánh ra sẽ tiêu hao tất cả\"Hoạt Diễm\" và truyền dẫn 1 tầng \"Hoạt Diễm\"đến 1 lá bài chỉ lệnh khác của Katy Gula trong tay."
  },
  State_98487_Name = {
    Text = "<HuoyanKeywords1:Hỏa diễm1>"
  },
  State_98488_Desc = {
    Text = "Mỗi lớp \"Hỏa thể\" làm sát thương cuối cùng mà thẻ gây ra, khiên, điên loạn, sức mạnh tăng 30%, tối đa chồng chất 3 lớp. Thẻ có \"Hỏa thể\" nhận \"Giữ lại\", tiêu hao toàn bộ \"Hỏa thể\" và truyền 1 lớp \"Hỏa thể\" vào 1 thẻ lệnh khác của Katiegura trong tay."
  },
  State_98488_Name = {
    Text = "<HuoyanKeywords:Hỏa diễm>"
  },
  State_98492_Desc = {
    Text = "Sau khi bắt đầu khám phá, thể chất, tấn công, phòng thủ tăng [StateArg1] %"
  },
  State_98492_Name = {
    Text = "Khả năng thích ứng hình thái linh hồn"
  },
  State_98495_Desc = {
    Text = "Sau khi bắt đầu khám phá, thể chất, tấn công, phòng thủ tăng [StateArg1] %"
  },
  State_98495_Name = {
    Text = "Khả năng thích ứng hình thái linh hồn"
  },
  State_98507_Desc = {
    Text = "Sau khi bắt đầu khám phá, thể chất, tấn công, phòng thủ tăng [StateArg1] %"
  },
  State_98507_Name = {
    Text = "Khả năng thích ứng hình thái linh hồn"
  },
  State_98511_Name = {
    Text = "Thu thập thẻ phát sinh"
  },
  State_98551_Desc = {
    Text = "Khi trận chiến bắt đầu, cõi thông thạo +[Arg1]. Bắt đầu lượt lẻ rút 1 thẻ, bắt đầu lượt chẵn nhận 1 điểm số học."
  },
  State_98553_Desc = {
    Text = "Mỗi khi tạo ra 1 \"Phôi thai\", nhận [Arg1] điểm lò nung đỏ thẫm, mỗi lượt tối đa kích hoạt 3 lần."
  },
  State_98555_Desc = {
    Text = "Khi bắt đầu trận chiến, nhận [Arg1]% mạnh. Mỗi lần áp dụng độc dược trong lần đầu mỗi lượt, rút [Arg2] thẻ."
  },
  State_98556_Desc = {
    Text = "Hiệu suất cơ bản của hồi phục cuộc sống và khiên mà người đánh thức gây ra tăng [Arg1]%."
  },
  State_98557_Desc = {
    Text = "Mỗi khi tạo ra 1 \"Phôi thai\", nhận [Arg1] điểm lò nung đỏ thẫm, mỗi lượt tối đa kích hoạt 3 lần."
  },
  State_98559_Desc = {
    Text = "Mỗi khi rút một thẻ hay bỏ một thẻ, nhận [Arg1] sức mạnh tạm thời, tối đa nhận [Arg2] sức mạnh tạm thời."
  },
  State_98560_Desc = {
    Text = "Sát thương cơ bản gây ra bởi tất cả người đánh thức tăng [Arg1]%. Trước khi tôn kính cuồng bộc phát, sát thương cơ bản làm cho người đánh thức bộc phát tôn kính tạm thời tăng [Arg2]%."
  },
  State_98561_Desc = {
    Text = "Khi bắt đầu lượt, nếu cuộc sống dưới 50%, tạm thời sát thương mạnh +[Arg1]%. Nếu cuộc sống dưới 25%, rút thêm [Arg2] thẻ và nhận [Arg2] số học."
  },
  State_98562_Desc = {
    Text = "Sau khi gây sát thương chủ động hoặc xúc tu, tăng sát thương xúc tu mục tiêu nhận trong lượt này [Arg1]%, mỗi lượt tối đa kích hoạt 20 lần."
  },
  State_98563_Desc = {
    Text = "Khi trận chiến bắt đầu, nhận [Arg1] sức mạnh. Mỗi lần đánh ra một thẻ \"tiêu hao\", nhận [Arg2] sức mạnh tạm thời, tối đa kích hoạt [Arg3] lần."
  },
  State_98564_Desc = {
    Text = "\"Tôn kính\" nhận [Arg1] S-energy, tối đa kích hoạt 3 lần mỗi lượt."
  },
  State_98565_Desc = {
    Text = "Mỗi thẻ khi vào không gian ultra, rút [Arg1] thẻ lệnh thuộc thẻ này từ bốc thăm, nếu không thể rút, thì nhận khả năng tính tương tự. Mỗi lượt tối đa kích hoạt 2 lần."
  },
  State_98567_Desc = {
    Text = "Trước khi kết thúc lượt, mỗi thẻ lệnh trên tay sẽ cung cấp [Arg1] điểm Aliemus cho Người đánh thức tương ứng."
  },
  State_98568_Desc = {
    Text = "Khi bắt đầu trận chiến, nhận mạnh sát thương +[Arg1]%. Sau khi gây sát thương chủ động, áp dụng [Arg2] độc dược cho tất cả kẻ địch, mỗi lượt kích hoạt thêm tối đa 5 lần."
  },
  State_98569_Desc = {
    Text = "Sau khi phát động \"Nhóm người\" lần đầu mỗi lượt, áp dụng [Arg1] tầng độc dược cho tất cả kẻ địch, và nhận [Arg2] tầng phản kích."
  },
  State_98571_Desc = {
    Text = "Sau khi sử dụng Silver key awaken, hồi [Arg1] cuộc sống, nhận [Arg2] điểm S-energy."
  },
  State_98571_Name = {
    Text = "Mái che du lịch"
  },
  State_98572_Desc = {
    Text = "Sau khi phát động \"Nhóm người\" lần thứ hai mỗi lượt, nhận [Arg1] điểm chìa khóa bạc năng lượng, tất cả người đánh thức nhận [Arg2] điểm aliemus."
  },
  State_98575_Desc = {
    Text = "Khi bắt đầu trận chiến, nhận mạnh sát thương +[Arg1]%. Sau khi gây sát thương chủ động, áp dụng [Arg2] độc dược cho tất cả kẻ địch, mỗi lượt kích hoạt thêm tối đa 5 lần."
  },
  State_98576_Desc = {
    Text = "Khi trận chiến bắt đầu, gây [Arg1] tầng điểm yếu và dễ tổn thương cho tất cả kẻ địch. Sau \"Hủy diệt\" cũng sẽ kích hoạt hiệu ứng này, nhưng có thời gian hồi là 3 lượt."
  },
  State_98577_Desc = {
    Text = "Sát thương cơ bản gây ra bởi tất cả người đánh thức tăng [Arg1]%. Trước khi tôn kính cuồng bộc phát, sát thương cơ bản làm cho người đánh thức bộc phát tôn kính tạm thời tăng [Arg2]%."
  },
  State_98579_Desc = {
    Text = "Khi bắt đầu lượt, nếu cuộc sống dưới 50%, tạm thời sát thương mạnh +[Arg1]%. Nếu cuộc sống dưới 25%, rút thêm [Arg2] thẻ và nhận [Arg2] số học."
  },
  State_98581_Desc = {
    Text = "Mỗi lần đầu mỗi lượt của người đánh thức, thẻ lệnh nhận [Arg1] điểm chìa khóa bạc năng lượng."
  },
  State_98582_Desc = {
    Text = "Sau mỗi 5 lần kích hoạt \"Cơn thịnh nộ bùng phát\", [Arg1] lá thẻ lệnh không phải là thẻ phái sinh tiếp theo sẽ có hiệu lực thêm 1 lần."
  },
  State_98583_Desc = {
    Text = "Mỗi lần đầu mỗi lượt của người đánh thức, thẻ lệnh nhận [Arg1] điểm chìa khóa bạc năng lượng."
  },
  State_98586_Desc = {
    Text = "Khi bắt đầu lượt, tất cả Người đánh thức không đủ Aliemus để tôn kính nhận [Arg1] điểm Aliemus."
  },
  State_98587_Desc = {
    Text = "Mỗi khi rút một thẻ hay bỏ một thẻ, nhận [Arg1] sức mạnh tạm thời, tối đa nhận [Arg2] sức mạnh tạm thời."
  },
  State_98588_Desc = {
    Text = "Trước khi kết thúc lượt, mỗi thẻ lệnh trên tay sẽ cung cấp [Arg1] điểm Aliemus cho Người đánh thức tương ứng."
  },
  State_98589_Desc = {
    Text = "Khi trận chiến bắt đầu, làm cho tất cả kẻ địch tạm thời mất [Arg1] sức mạnh. Khi sử dụng \"Lò nung đỏ thẫm\" cũng kích hoạt hiệu ứng này, nhưng có thời gian hồi là 3 lượt."
  },
  State_98590_Desc = {
    Text = "Khi bắt đầu trận chiến, nhận [Arg1]% mạnh. Mỗi lần áp dụng độc dược trong lần đầu mỗi lượt, rút [Arg2] thẻ."
  },
  State_98591_Desc = {
    Text = "Sau khi phát động \"Nhóm người\" lần đầu mỗi lượt, áp dụng [Arg1] tầng độc dược cho tất cả kẻ địch, và nhận [Arg2] tầng phản kích."
  },
  State_98596_Desc = {
    Text = "Lần đầu mỗi lượt \"Nhóm người\" hoàn trả [Arg1]% chìa khóa bạc năng lượng tiêu hết."
  },
  State_98597_Desc = {
    Text = "Sau khi sử dụng Silver key awaken, hồi [Arg1] cuộc sống, nhận [Arg2] điểm S-energy."
  },
  State_98597_Name = {
    Text = "Mái che du lịch+"
  },
  State_98598_Desc = {
    Text = "Khi trận chiến bắt đầu, nhận [Arg1] sức mạnh. Mỗi lần đánh ra một thẻ \"tiêu hao\", nhận [Arg2] sức mạnh tạm thời, tối đa kích hoạt [Arg3] lần."
  },
  State_98600_Desc = {
    Text = "Khi trận chiến bắt đầu, làm cho tất cả kẻ địch tạm thời mất [Arg1] sức mạnh. Khi sử dụng \"Lò nung đỏ thẫm\" cũng kích hoạt hiệu ứng này, nhưng có thời gian hồi là 3 lượt."
  },
  State_98602_Desc = {
    Text = "Khi trận chiến bắt đầu, nhận [Arg1]% sát thương mạnh. Mỗi lần đầu tiên nhận quầy mỗi lượt, nhận 1/2 số học."
  },
  State_98603_Desc = {
    Text = "Khi bắt đầu chiến đấu nhận Khuếch đại sát thương +[Arg1]%. Sau khi nhận sát thương chủ động hoặc thương tổn xúc tu nhận [Arg2] phản công, tối đa kích hoạt 3 lần mỗi lượt."
  },
  State_98604_Desc = {
    Text = "Khi bắt đầu chiến đấu nhận Khuếch đại sát thương +[Arg1]%. Sau khi nhận sát thương chủ động hoặc thương tổn xúc tu nhận [Arg2] phản công, tối đa kích hoạt 3 lần mỗi lượt."
  },
  State_98606_Desc = {
    Text = "Mỗi thẻ khi vào không gian ultra, rút [Arg1] thẻ lệnh thuộc thẻ này từ bốc thăm, nếu không thể rút, thì nhận khả năng tính tương tự. Mỗi lượt tối đa kích hoạt 2 lần."
  },
  State_98607_Desc = {
    Text = "Lần đầu mỗi lượt \"Nhóm người\" kích hoạt tất cả xúc tu tấn công [Arg1] lần kẻ thù, gây 50% sát thương."
  },
  State_98608_Desc = {
    Text = "Khi trận chiến bắt đầu, nhận [Arg1]% sát thương mạnh. Mỗi khi đánh ra một thẻ lệnh từ một Người đánh thức khác nhau, nhận thêm 15/30% sát thương mạnh tạm thời."
  },
  State_98610_Desc = {
    Text = "Sau khi sử dụng Silver key awaken, làm cho 2/4 thẻ có số học cao nhất trong tay được giữ lại và chuẩn bị trước khi lần tiếp theo đánh ra, nhận 100/200 điểm S-energy."
  },
  State_98611_Desc = {
    Text = "Khi trận chiến bắt đầu, cõi thông thạo +[Arg1]. Bắt đầu lượt lẻ rút 1 thẻ, bắt đầu lượt chẵn nhận 1 điểm số học."
  },
  State_98612_Desc = {
    Text = "Lần đầu tiên \"Nhóm người\" mỗi lượt khiến mạnh sát thương tạm thời +[Arg1]%, cuộc sống càng thấp hiệu quả càng mạnh."
  },
  State_98613_Desc = {
    Text = "Khi trận chiến bắt đầu, nhận [Arg1]% sát thương mạnh. Mỗi khi đánh ra một thẻ lệnh từ một Người đánh thức khác nhau, nhận thêm 15/30% sát thương mạnh tạm thời."
  },
  State_98614_Desc = {
    Text = "Sau mỗi 5 lần kích hoạt \"Cơn thịnh nộ bùng phát\", [Arg1] lá thẻ lệnh không phải là thẻ phái sinh tiếp theo sẽ có hiệu lực thêm 1 lần."
  },
  State_98615_Desc = {
    Text = "Lần đầu mỗi lượt \"Nhóm người\" hoàn trả [Arg1]% chìa khóa bạc năng lượng tiêu hết."
  },
  State_98616_Desc = {
    Text = "Hiệu suất cơ bản của hồi phục cuộc sống và khiên mà người đánh thức gây ra tăng [Arg1]%."
  },
  State_98617_Desc = {
    Text = "Sau khi gây sát thương chủ động hoặc xúc tu, tăng sát thương xúc tu mục tiêu nhận trong lượt này [Arg1]%, mỗi lượt tối đa kích hoạt 20 lần."
  },
  State_98619_Desc = {
    Text = "Khi kết thúc lượt nếu S-energy đã đầy, tiêu hao [Arg1] điểm S-energy để đặt một thẻ \"Tia sáng nhẹ của chìa khóa bạc\" vào tay."
  },
  State_98621_Desc = {
    Text = "Khi kết thúc lượt nếu S-energy đã đầy, tiêu hao [Arg1] điểm S-energy để đặt một thẻ \"Ánh sáng rực của chìa khóa bạc\" vào tay."
  },
  State_98623_Desc = {
    Text = "Khi bắt đầu lượt, tất cả Người đánh thức không đủ Aliemus để tôn kính nhận [Arg1] điểm Aliemus."
  },
  State_98624_Desc = {
    Text = "Khi trận chiến bắt đầu và sau khi kích hoạt kháng cự, nhận [Arg1] điểm S-energy."
  },
  State_98625_Desc = {
    Text = "Khi trận chiến bắt đầu, gây [Arg1] tầng điểm yếu và dễ tổn thương cho tất cả kẻ địch. Sau \"Hủy diệt\" cũng sẽ kích hoạt hiệu ứng này, nhưng có thời gian hồi là 3 lượt."
  },
  State_98626_Desc = {
    Text = "Lần đầu tiên \"Nhóm người\" mỗi lượt khiến mạnh sát thương tạm thời +[Arg1]%, cuộc sống càng thấp hiệu quả càng mạnh."
  },
  State_98627_Desc = {
    Text = "\"Tôn kính\" nhận [Arg1] S-energy, tối đa kích hoạt 3 lần mỗi lượt."
  },
  State_98628_Desc = {
    Text = "Lần đầu mỗi lượt \"Nhóm người\" kích hoạt tất cả xúc tu tấn công [Arg1] lần kẻ thù, gây 50% sát thương."
  },
  State_98629_Desc = {
    Text = "Sau khi phát động \"Nhóm người\" lần thứ hai mỗi lượt, nhận [Arg1] điểm chìa khóa bạc năng lượng, tất cả người đánh thức nhận [Arg2] điểm aliemus."
  },
  State_98630_Desc = {
    Text = "Khi trận chiến bắt đầu và sau khi kích hoạt kháng cự, nhận [Arg1] điểm S-energy."
  },
  State_98632_Desc = {
    Text = "Khi trận chiến bắt đầu, nhận [Arg1]% sát thương mạnh. Mỗi lần đầu tiên nhận quầy mỗi lượt, nhận 1/2 số học."
  },
  State_98686_Desc = {
    Text = "Làm cho [Layer] thẻ lệnh không phát sinh hiệu ứng thêm một lần."
  },
  State_98686_Name = {
    Text = "Thẻ lệnh không phát sinh phát đôi"
  },
  State_98739_Desc = {
    Text = "Khi ý định chuyển thành Cơn xoáy trắng bệch, tăng số lần sát thương dựa trên số tầng trạng thái, và sau khi kết thúc lượt thì xóa trạng thái. Đạt 3 tầng, lập tức chuyển ý định thành Cơn xoáy trắng bệch."
  },
  State_98739_Name = {
    Text = "Nụ hôn của Người phụ nữ nhện"
  },
  State_98742_Desc = {
    Text = "Độc dược áp dụng tăng 100%, mỗi lần kết thúc lượt, nhận <Block:[Block:DescArg1]> khiên."
  },
  State_98742_Name = {
    Text = "Hành trình lạc lối"
  },
  State_98743_Desc = {
    Text = "Sau khi nhận [DescArg1] điểm sát thương trong lượt, nhận 75 tầng gia cố tạm thời, chuyển đổi ý định thành \"Sự ban cho không nhẫn nại\" và giải phóng hiệu ứng hóa đá, nhận 1 tầng \"Nụ hôn của nữ hoàng nhện\"."
  },
  State_98743_Name = {
    Text = "Người vi phạm"
  },
  State_98752_Desc = {
    Text = "Làm cho thẻ được đốt cháy, sau khi sử dụng thì nhận sát thương bằng 5% máu tối đa, nếu cuối lượt vẫn còn trên tay thì sẽ bị kiệt sức."
  },
  State_98752_Name = {
    Text = "<BurningKeywords2:Đốt cháy>"
  },
  State_98752_WeaponDesc = {
    Text = "Mỗi lớp làm chậm khiến tiêu thụ sức tính toán của thẻ bài tăng thêm 1 điểm."
  },
  State_98887_Name = {
    Text = "Ngọn đèn cứu rỗi"
  },
  State_98889_Desc = {
    Text = "Mỗi lượt đầu tiên chơi thẻ lệnh có<DepleteIconKeywords:kiệt sức> thì đặt nó vào chồng bài bỏ."
  },
  State_98889_Name = {
    Text = "Ngọn đèn cứu rỗi"
  },
  State_98912_Desc = {
    Text = "Mỗi lớp sẽ giảm 10% sinh lực và khiên hồi phục mà tất cả các thể thức tỉnh gây ra."
  },
  State_98912_Name = {
    Text = "<LostWay:Mê lạc>"
  },
  State_98913_Desc = {
    Text = "Mỗi lớp sẽ giảm 10% sinh lực và khiên hồi phục mà tất cả các thể thức tỉnh gây ra."
  },
  State_98913_Name = {
    Text = "Lạc lối"
  },
  State_99007_Desc = {
    Text = "Sẽ không được đưa vào rác bài, mà sẽ được gỡ bỏ khỏi bộ bài."
  },
  State_99007_Name = {
    Text = "<DepleteIconKeywords:tiêu thụ>"
  },
  State_99007_WeaponDesc = {
    Text = "Sau khi đánh, thẻ bài sẽ không vào rác bài và không thể sử dụng lại trong cuộc chiến đấu này."
  },
  State_99053_Desc = {
    Text = "<PVPWeaponKeywords:Bánh xe định mệnh>: Đồng đội khác mỗi lượt lần đầu \"Bùng nổ điên loạn\" rút [StateArg1] quân bài."
  },
  State_99053_Name = {
    Text = "Cây cọ khát khao"
  },
  State_99055_Desc = {
    Text = "<PVPWeaponKeywords:Bánh Xe Mệnh>: Sau\"Bùng Nổ Cuồng Khí\", ngẫu nhiên đưa [StateArg1] lá\"Kỹ năng\"của người trang bị vào tay và giảm tiêu haoĐiểm tính toán về 0."
  },
  State_99055_Name = {
    Text = "Bất thường của Chủ nghĩa Hiện thực"
  },
  State_99056_Desc = {
    Text = "Đội duy nhất: Sau khi giải phóng nhóm người, tỷ lệ chí mạng của người trang bị tạm thời tăng <WeaponEffect_Num:[StateArg1]%> ."
  },
  State_99056_WeaponDesc = {
    Text = "Sau khi giải phóng nhóm người, tỷ lệ chí mạng của người trang bị tạm thời tăng <WeaponEffect_Num:[StateArg1]%> ."
  },
  State_99134_Desc = {
    Text = "\"Người vẽ\" chất nhuộm dùng để vẽ tranh, có thể tăng cường hiệu ứng kỹ năng, giới hạn 10 tầng."
  },
  State_99134_Name = {
    Text = "Màu nhuộm ảo ảnh"
  },
  State_99237_Name = {
    Text = "Trạng thái phụ kiện phi thăng"
  },
  State_99237_WeaponDesc = {
    Text = "Trang bị tăng thương cơ bản 10%. Nếu mạnh mẽ của trang bị lớn hơn 20%, thương cơ bản tăng thêm 10%."
  },
  State_99238_Name = {
    Text = "Trạng thái phụ kiện mùn"
  },
  State_99238_WeaponDesc = {
    Text = "Trang bị tăng thương cơ bản 10%. Nếu mạnh mẽ của trang bị lớn hơn 20%, thương cơ bản tăng thêm 10%."
  },
  State_99239_Name = {
    Text = "Trạng thái phụ kiện Styx"
  },
  State_99239_WeaponDesc = {
    Text = "Trang bị tăng thương cơ bản 10%. Nếu mạnh mẽ của trang bị lớn hơn 20%, thương cơ bản tăng thêm 10%."
  },
  State_99258_Desc = {
    Text = "Duy nhất trong đội: Sau khi giải phóng lần thứ 2 nhóm người mỗi lượt, có <WeaponEffect_Num:[StateArg1]%> cơ hội rút 1 thẻ lệnh của người trang bị. Mỗi lượt chơi lá bài lệnh của người trang bị lần thứ 3, nhận <WeaponEffect_Num:[StateArg2]> điểm năng lượng chìa khóa bạc."
  },
  State_99258_WeaponDesc = {
    Text = "Sau khi giải phóng lần thứ 2 nhóm người mỗi lượt, có <WeaponEffect_Num:[StateArg1]%> cơ hội rút 1 thẻ lệnh của người trang bị. Mỗi lượt chơi lá bài lệnh của người trang bị lần thứ 3, nhận <WeaponEffect_Num:[StateArg2]> điểm năng lượng chìa khóa bạc."
  },
  State_99294_Desc = {
    Text = "Tất cả thân thể được đánh thức tăng [DescArg1]% điên cuồng. Sức tính toán và thẻ lệnh khi kết thúc lượt có thể giữ lại đến lượt sau. Sự điên cuồng của Fenhua Chương được tăng cường."
  },
  State_99294_Name = {Text = "\"vui\""},
  State_99295_Desc = {
    Text = "Tất cả thân thể được đánh thức gây ra tăng [StateArg1]% điên cuồng. Sức tính toán và thẻ lệnh khi kết thúc lượt có thể giữ lại đến lượt sau. Điên cuồng của Fenhua tăng lên."
  },
  State_99295_Name = {Text = "\"vui\""},
  State_99336_Desc = {
    Text = "\"Người vẽ\" chất nhuộm dùng để vẽ tranh, có thể tăng cường hiệu ứng kỹ năng, giới hạn 10 tầng."
  },
  State_99336_Name = {
    Text = "<DecayDye:Nhuộm ảo giới>"
  },
  State_99533_Name = {
    Text = "Nhộng của cô gái trang sức"
  },
  State_99533_WeaponDesc = {
    Text = "Sau khi chiến đấu bắt đầu, nếu nghề của người sử dụng là hỗn loạn, sức tấn công tăng 25%."
  },
  State_99534_Name = {
    Text = "Slime Ngọt"
  },
  State_99534_WeaponDesc = {
    Text = "Khi trang bị, tăng 6% hiệu quả tạo lá chắn và hồi sức sống. Nếu chỉ số giới vực của người trang bị lớn hơn 50, hiệu quả tạo lá chắn và hồi sức sống sẽ tăng thêm 6%."
  },
  State_99640_Desc = {
    Text = "Nếu hiện tại sở hữu 10 lớp Cảm hứng, sau khi Pikman phát burst Aliemus sẽ tiêu hao tất cả Cảm hứng, làm cho tất cả người đánh thức nhận được 15 điểm Aliemus và nhận 1 lớp \"Kính vạn hoa\". Giới hạn của Cảm hứng là 10 lớp, có thể được kế thừa qua trận chiến tiếp theo."
  },
  State_99640_Name = {
    Text = "Ý tưởng"
  },
  State_99723_Desc = {
    Text = "Đội duy nhất: Hiệu quả anhemus và sức mạnh của người trang bị tăng <WeaponEffect_Num:[StateArg1]%>. Sau khi phát động tôn kính, trong phiên hiện tại, sát thương cuối cùng, khiên, hồi phục cuộc sống của lần tôn kính tiếp theo của người đánh thức khác tăng <WeaponEffect_Num:[StateArg2]%>; nếu tôn kính lần này kích hoạt \"nuốt chửng,\" người trang bị nhận số điểm Aliemus <WeaponEffect_Num:[StateArg3]>."
  },
  State_99723_WeaponDesc = {
    Text = "Cường độ và Aliemus của người trang bị tăng <WeaponEffect_Num:[StateArg1]%>. Sau khi Bùng nổ Aliemus, lần Bùng nổ Aliemus tiếp theo của những Người đánh thức khác trong lượt này làm tăng<WeaponEffect_Num:[StateArg2]%> sát thương, khiên và hồi phục cuối cùng, nếu Bùng nổ Aliemus này kích hoạt \"Nuốt chửng\", người trang bị nhận <WeaponEffect_Num:[StateArg3]> điểm Aliemus."
  }
})
return Text_State
