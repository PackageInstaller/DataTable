__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_RelicConfig = readonly({
  RelicConfig_100300_BattleDesc = {
    Text = "Sau khi trận chiến bắt đầu, có được 1 lớp \"<MindWall: tâm linh tường>\"， sau 3 lượt sẽ chuyển đổi thành \"<BarrierCrash: bức tường sụp đổ>\"."
  },
  RelicConfig_100300_Desc = {
    Text = "Sau khi trận chiến bắt đầu, có được 1 lớp \"<MindWall: tâm linh tường>\"， sau 3 lượt sẽ chuyển đổi thành \"<BarrierCrash: bức tường sụp đổ>\"."
  },
  RelicConfig_100300_Name = {
    Text = "Phân tích tâm hồn"
  },
  RelicConfig_100300_StoryDesc = {
    Text = "Hãy nhìn rõ vào trái tim bạn, đừng đưa ra lựa chọn sai lầm."
  },
  RelicConfig_100399_BattleDesc = {
    Text = "Kích hoạt <DevouredIconKeywords:Nuốt chửng> hiệu ứng sau, những Người đánh thức khác nhận [Arg1] điểm Aliemus, chỉ có thể kích hoạt mỗi lượt 1 lần."
  },
  RelicConfig_100399_Desc = {
    Text = "Kích hoạt <DevouredIconKeywords:Nuốt chửng> hiệu ứng sau, những Người đánh thức khác nhận [Arg1] điểm Aliemus, chỉ có thể kích hoạt mỗi lượt 1 lần."
  },
  RelicConfig_100399_Name = {
    Text = "<OrangeQuality:Giấc Mơ Vàng Sáng Tạo+>"
  },
  RelicConfig_100399_StoryDesc = {
    Text = "Ngày chuyển hóa chính là ngày chết của bạn."
  },
  RelicConfig_100400_BattleDesc = {
    Text = "Vào cuối lượt, phục hồi [Heal:Arg1] sức sống."
  },
  RelicConfig_100400_Desc = {
    Text = "Vào cuối lượt, phục hồi [Heal:Arg1] sức sống."
  },
  RelicConfig_100400_Name = {
    Text = "<OrangeQuality:Huyết Ân Sủng Sáng Tạo+>"
  },
  RelicConfig_100400_StoryDesc = {
    Text = "Nó ngọt ngào và đậm đà, toả ra hương thơm của hoa hồng."
  },
  RelicConfig_100401_BattleDesc = {
    Text = "Khi mất sức sống, nhận được [Arg1]% lượng sức sống mất đi dưới dạng lò luyện màu đỏ thẫm."
  },
  RelicConfig_100401_Desc = {
    Text = "Khi mất sức sống, nhận được [Arg1]% lượng sức sống mất đi dưới dạng lò luyện màu đỏ thẫm."
  },
  RelicConfig_100401_Name = {
    Text = "<OrangeQuality:Cưa Thép Gỉ Sét Sáng Tạo+>"
  },
  RelicConfig_100401_StoryDesc = {
    Text = "Bác sĩ giải phẫu suốt đời không nhìn thấy người phụ nữ đẹp. Họ chỉ có một bao xương, dây thần kinh viêm do bệnh tật, cơ bắp và mô."
  },
  RelicConfig_100402_BattleDesc = {
    Text = "Khi nhặt lên, áp dụng [Arg1] lớp <VulnerabilityIconKeywords:Dễ tổn thương> cho tất cả kẻ địch. Tất cả tổn hại cơ bản do người đánh thức gây ra tăng [Arg2]%."
  },
  RelicConfig_100402_Desc = {
    Text = "Khi nhặt lên, áp dụng [Arg1] lớp <VulnerabilityIconKeywords:Dễ tổn thương> cho tất cả kẻ địch. Tất cả tổn hại cơ bản do người đánh thức gây ra tăng [Arg2]%."
  },
  RelicConfig_100402_Name = {
    Text = "<WhiteQuality:Xuân Chi Tế Sáng Tạo>"
  },
  RelicConfig_100402_StoryDesc = {
    Text = "Trong tiếng cười rộn ràng của đêm, hình bóng chiếc thuyền độc mộc lướt nhẹ nhàng trên mặt hồ."
  },
  RelicConfig_100404_BattleDesc = {
    Text = "Sau khi kích hoạt \"cơn thịnh nộ bùng phát\", nhận được [Arg1] <PowerIconKeywords:lực lượng> tạm thời."
  },
  RelicConfig_100404_Desc = {
    Text = "Sau khi kích hoạt \"cơn thịnh nộ bùng phát\", nhận được [Arg1] <PowerIconKeywords:lực lượng> tạm thời."
  },
  RelicConfig_100404_Name = {
    Text = "<WhiteQuality:Trọng Tỏa Sáng Tạo>"
  },
  RelicConfig_100404_StoryDesc = {
    Text = "Khóa dày và chắc chắn, nếu không có chìa khóa, chắc hẳn rất khó để mở. \nTất nhiên, điều này đối với một siêu trộm thì không đáng kể."
  },
  RelicConfig_100405_BattleDesc = {
    Text = "Khi nhặt lên, áp dụng [Arg1] lớp <WeaknessIconKeywords:Điểm yếu> cho tất cả kẻ địch. Tất cả tổn hại cơ bản do người đánh thức gây ra tăng [Arg2]%."
  },
  RelicConfig_100405_Desc = {
    Text = "Khi nhặt lên, áp dụng [Arg1] lớp <WeaknessIconKeywords:Điểm yếu> cho tất cả kẻ địch. Tất cả tổn hại cơ bản do người đánh thức gây ra tăng [Arg2]%."
  },
  RelicConfig_100405_Name = {
    Text = "<WhiteQuality:Ác Đồng Sáng Tạo>"
  },
  RelicConfig_100405_StoryDesc = {
    Text = "Bắt nguồn từ cái ác thuần túy, dù điều đó không phải là ý nguyện của nó."
  },
  RelicConfig_100406_BattleDesc = {
    Text = "Kích hoạt <DevouredIconKeywords:Nuốt chửng> hiệu ứng sau, những Người đánh thức khác nhận [Arg1] điểm Aliemus, chỉ có thể kích hoạt mỗi lượt 1 lần."
  },
  RelicConfig_100406_Desc = {
    Text = "Kích hoạt <DevouredIconKeywords:Nuốt chửng> hiệu ứng sau, những Người đánh thức khác nhận [Arg1] điểm Aliemus, chỉ có thể kích hoạt mỗi lượt 1 lần."
  },
  RelicConfig_100406_Name = {
    Text = "<WhiteQuality:Giấc Mơ Vàng Sáng Tạo>"
  },
  RelicConfig_100406_StoryDesc = {
    Text = "Ngày chuyển hóa chính là ngày chết của bạn."
  },
  RelicConfig_100407_BattleDesc = {
    Text = "Mỗi lần gây thương sẽ nhận được [Arg1] tạm thời <PowerIconKeywords:lực lượng>, mỗi lượt tối đa kích hoạt 15 lần."
  },
  RelicConfig_100407_Desc = {
    Text = "Mỗi lần gây thương sẽ nhận được [Arg1] tạm thời <PowerIconKeywords:lực lượng>, mỗi lượt tối đa kích hoạt 15 lần."
  },
  RelicConfig_100407_Name = {
    Text = "<WhiteQuality:Mã Não Vân Tơ Sáng Tạo>"
  },
  RelicConfig_100407_StoryDesc = {
    Text = "Đó có lẽ chỉ là hoa văn thạch anh thông thường. Chắc vậy."
  },
  RelicConfig_100408_BattleDesc = {
    Text = "Sau khi kích hoạt \"cơn thịnh nộ bùng phát\", nhận được [Arg1] <PowerIconKeywords:lực lượng> tạm thời."
  },
  RelicConfig_100408_Desc = {
    Text = "Sau khi kích hoạt \"cơn thịnh nộ bùng phát\", nhận được [Arg1] <PowerIconKeywords:lực lượng> tạm thời."
  },
  RelicConfig_100408_Name = {
    Text = "<OrangeQuality:Trọng Tỏa Sáng Tạo+>"
  },
  RelicConfig_100408_StoryDesc = {
    Text = "Khóa dày và chắc chắn, nếu không có chìa khóa, chắc hẳn rất khó để mở. \nTất nhiên, điều này đối với một siêu trộm thì không đáng kể."
  },
  RelicConfig_100409_BattleDesc = {
    Text = "Khi nhặt lên, áp dụng [Arg1] lớp <WeaknessIconKeywords:Điểm yếu> cho tất cả kẻ địch. Tất cả tổn hại cơ bản do người đánh thức gây ra tăng [Arg2]%."
  },
  RelicConfig_100409_Desc = {
    Text = "Khi nhặt lên, áp dụng [Arg1] lớp <WeaknessIconKeywords:Điểm yếu> cho tất cả kẻ địch. Tất cả tổn hại cơ bản do người đánh thức gây ra tăng [Arg2]%."
  },
  RelicConfig_100409_Name = {
    Text = "<OrangeQuality:Ác Đồng Sáng Tạo+>"
  },
  RelicConfig_100409_StoryDesc = {
    Text = "Bắt nguồn từ cái ác thuần túy, dù điều đó không phải là ý nguyện của nó."
  },
  RelicConfig_100410_BattleDesc = {
    Text = "Mỗi lần gây thương sẽ nhận được [Arg1] tạm thời <PowerIconKeywords:lực lượng>, mỗi lượt tối đa kích hoạt 15 lần."
  },
  RelicConfig_100410_Desc = {
    Text = "Mỗi lần gây thương sẽ nhận được [Arg1] tạm thời <PowerIconKeywords:lực lượng>, mỗi lượt tối đa kích hoạt 15 lần."
  },
  RelicConfig_100410_Name = {
    Text = "<OrangeQuality:Mã Não Vân Tơ Sáng Tạo+>"
  },
  RelicConfig_100410_StoryDesc = {
    Text = "Đó có lẽ chỉ là hoa văn thạch anh thông thường. Chắc vậy."
  },
  RelicConfig_100411_BattleDesc = {
    Text = "Khi nhặt lên, áp dụng [Arg1] lớp <VulnerabilityIconKeywords:Dễ tổn thương> cho tất cả kẻ địch. Tất cả tổn hại cơ bản do người đánh thức gây ra tăng [Arg2]%."
  },
  RelicConfig_100411_Desc = {
    Text = "Khi nhặt lên, áp dụng [Arg1] lớp <VulnerabilityIconKeywords:Dễ tổn thương> cho tất cả kẻ địch. Tất cả tổn hại cơ bản do người đánh thức gây ra tăng [Arg2]%."
  },
  RelicConfig_100411_Name = {
    Text = "<OrangeQuality:Xuân Chi Tế Sáng Tạo+>"
  },
  RelicConfig_100411_StoryDesc = {
    Text = "Trong tiếng cười rộn ràng của đêm, hình bóng chiếc thuyền độc mộc lướt nhẹ nhàng trên mặt hồ."
  },
  RelicConfig_100412_BattleDesc = {
    Text = "Vào cuối lượt, phục hồi [Heal:Arg1] sức sống."
  },
  RelicConfig_100412_Desc = {
    Text = "Vào cuối lượt, phục hồi [Heal:Arg1] sức sống."
  },
  RelicConfig_100412_Name = {
    Text = "<WhiteQuality:Huyết Ân Sủng Sáng Tạo>"
  },
  RelicConfig_100412_StoryDesc = {
    Text = "Nó ngọt ngào và đậm đà, toả ra hương thơm của hoa hồng."
  },
  RelicConfig_100413_BattleDesc = {
    Text = "Khi mất sức sống, nhận được [Arg1]% lượng sức sống mất đi dưới dạng lò luyện màu đỏ thẫm."
  },
  RelicConfig_100413_Desc = {
    Text = "Khi mất sức sống, nhận được [Arg1]% lượng sức sống mất đi dưới dạng lò luyện màu đỏ thẫm."
  },
  RelicConfig_100413_Name = {
    Text = "<WhiteQuality:Cưa Thép Gỉ Sét Sáng Tạo>"
  },
  RelicConfig_100413_StoryDesc = {
    Text = "Bác sĩ giải phẫu suốt đời không nhìn thấy người phụ nữ đẹp. Họ chỉ có một bao xương, dây thần kinh viêm do bệnh tật, cơ bắp và mô."
  },
  RelicConfig_100539_BattleDesc = {
    Text = "Mỗi lượt, sau khi sử dụng trực tiếp \"phôi thai\" lần đầu tiên, trong lượt này, sát thương chủ động sẽ gây ra [Arg1]% thương tương đương với <BleedingIconKeywords:chảy máu>."
  },
  RelicConfig_100539_Desc = {
    Text = "Mỗi lượt, sau khi sử dụng trực tiếp \"phôi thai\" lần đầu tiên, trong lượt này, sát thương chủ động sẽ gây ra [Arg1]% thương tương đương với <BleedingIconKeywords:chảy máu>."
  },
  RelicConfig_100539_Name = {
    Text = "<WhiteQuality:Cuội Nhuốm Máu Sáng Tạo>"
  },
  RelicConfig_100539_StoryDesc = {
    Text = "Một, hai, ba, bốn, năm."
  },
  RelicConfig_100540_BattleDesc = {
    Text = "Mỗi lượt, sau khi sử dụng trực tiếp \"phôi thai\" lần đầu tiên, trong lượt này, sát thương chủ động sẽ gây ra [Arg1]% thương tương đương với <BleedingIconKeywords:chảy máu>."
  },
  RelicConfig_100540_Desc = {
    Text = "Mỗi lượt, sau khi sử dụng trực tiếp \"phôi thai\" lần đầu tiên, trong lượt này, sát thương chủ động sẽ gây ra [Arg1]% thương tương đương với <BleedingIconKeywords:chảy máu>."
  },
  RelicConfig_100540_Name = {
    Text = "<OrangeQuality:Cuội Nhuốm Máu Sáng Tạo+>"
  },
  RelicConfig_100540_StoryDesc = {
    Text = "Một, hai, ba, bốn, năm."
  },
  RelicConfig_116382_BattleDesc = {
    Text = "Một chuỗi chìa khóa rỉ sét. Có thể sử dụng để mở khóa cửa."
  },
  RelicConfig_116382_Desc = {
    Text = "Một chuỗi chìa khóa rỉ sét. Có thể sử dụng để mở khóa cửa."
  },
  RelicConfig_116382_Name = {
    Text = "chìa khóa rỉ sét"
  },
  RelicConfig_116383_BattleDesc = {
    Text = "Một chuỗi chìa khóa rỉ sét. Có thể sử dụng để mở khóa cửa."
  },
  RelicConfig_116383_Desc = {
    Text = "Một chuỗi chìa khóa rỉ sét. Có thể sử dụng để mở khóa cửa."
  },
  RelicConfig_116383_Name = {
    Text = "chìa khóa rỉ sét"
  },
  RelicConfig_116384_BattleDesc = {
    Text = "Một chuỗi chìa khóa rỉ sét. Có thể sử dụng để mở khóa cửa."
  },
  RelicConfig_116384_Desc = {
    Text = "Một chuỗi chìa khóa rỉ sét. Có thể sử dụng để mở khóa cửa."
  },
  RelicConfig_116384_Name = {
    Text = "chìa khóa rỉ sét"
  },
  RelicConfig_119371_BattleDesc = {
    Text = "Giới hạn tay +1.\nKhi lượt bắt đầu, nếu chưa hoàn thành tất cả các nghi lễ, nhận <SacrificeKeyWord:Hy sinh> 10% sinh lực tối đa. Đặt 1 thẻ\"<DerivativeCardKeywords_119:Kính biếng Thần>\" vào tay, tối đa giữ 1 thẻ."
  },
  RelicConfig_119371_Desc = {
    Text = "Giới hạn tay +1.\nKhi lượt bắt đầu, nếu chưa hoàn thành tất cả các nghi lễ, nhận <SacrificeKeyWord:Hy sinh> 10% sinh lực tối đa. Đặt 1 thẻ\"<DerivativeCardKeywords_119:Kính biếng Thần>\" vào tay, tối đa giữ 1 thẻ."
  },
  RelicConfig_119371_Name = {
    Text = "Lư hương bằng đồng"
  },
  RelicConfig_119371_StoryDesc = {
    Text = "\"Mẫu vật này được chế tạo dựa theo kỹ thuật của Lemuria, mong nó sẽ giúp bạn an giấc mỗi đêm. Miryam lưu lại.\""
  },
  RelicConfig_120372_BattleDesc = {
    Text = "Kích tước tay tối đa +[Arg1]. Vào đầu lượt, sẽ đặt [Arg2] lá \"<PVPDerivativeCardKeywords_11:Trao đổi không công bằng>\" vào tay."
  },
  RelicConfig_120372_Desc = {
    Text = "Kích tước tay tối đa +[Arg1]. Vào đầu lượt, sẽ đặt [Arg2] lá \"<PVPDerivativeCardKeywords_11:Trao đổi không công bằng>\" vào tay."
  },
  RelicConfig_120372_Name = {
    Text = "<OrangeQuality:Kaleidoscope>"
  },
  RelicConfig_120373_BattleDesc = {
    Text = "Khi chơi [Arg1] lá\"<PVPWeaponKeywords:Bánh xe định mệnh>\" trước, giá trị điểm tính toán bị giảm -5/-3/-1/+1, rút 1 lá bài."
  },
  RelicConfig_120373_Desc = {
    Text = "Khi chơi [Arg1] lá\"<PVPWeaponKeywords:Bánh xe định mệnh>\" trước, giá trị điểm tính toán bị giảm -5/-3/-1/+1, rút 1 lá bài."
  },
  RelicConfig_120373_Name = {
    Text = "<OrangeQuality:Biểu tượng mythag>"
  },
  RelicConfig_121214_BattleDesc = {
    Text = "Miễn dịch với sát thương"
  },
  RelicConfig_121214_Desc = {
    Text = "Miễn dịch với sát thương"
  },
  RelicConfig_121214_Name = {
    Text = "Thử nghiệm thành tựu vô địch"
  },
  RelicConfig_121689_BattleDesc = {
    Text = "Tăng 250% sát thương cuối cùng gây ra, mỗi lần gây sát thương giảm 50%, và làm tăng lá chắn gây ra 10%, tối đa kích hoạt 5 lần, được đặt lại sau khi bắt đầu mỗi lượt."
  },
  RelicConfig_121689_Desc = {
    Text = "Tăng 250% sát thương cuối cùng gây ra, mỗi lần gây sát thương giảm 50%, và làm tăng lá chắn gây ra 10%, tối đa kích hoạt 5 lần, được đặt lại sau khi bắt đầu mỗi lượt."
  },
  RelicConfig_121689_Name = {
    Text = "<OrangeQuality:「Con đường trở về của bạc tinh khiết · Xuất hiện」>"
  },
  RelicConfig_121690_BattleDesc = {
    Text = "Bắt đầu chiến đấu, chọn 3 thẻ bài để chúng nhận được \"<RippleKeywords:Sóng dư chấn>:Rút 1 lá bài, nhận [Arg3] điểm tạm thời <PowerIconKeywords:lực lượng>\". Khi bắt đầu lượt, rút 2 thẻ bài kèm theo <RippleKeywords:Sóng dư chấn>, tất cả hiệu ứng <RippleKeywords:Sóng dư chấn> sẽ kích hoạt thêm 1 lần, sau khi kích hoạt 10 lần <RippleKeywords:Sóng dư chấn>, đặt 1 lá <DerivativeCardKeywords_1:Hồi âm di ảnh> vào tay."
  },
  RelicConfig_121690_Desc = {
    Text = "Bắt đầu chiến đấu, chọn 3 thẻ bài để chúng nhận được \"<RippleKeywords:Sóng dư chấn>:Rút 1 lá bài, nhận [Arg3] điểm tạm thời <PowerIconKeywords:lực lượng>\". Khi bắt đầu lượt, rút 2 thẻ bài kèm theo <RippleKeywords:Sóng dư chấn>, tất cả hiệu ứng <RippleKeywords:Sóng dư chấn> sẽ kích hoạt thêm 1 lần, sau khi kích hoạt 10 lần <RippleKeywords:Sóng dư chấn>, đặt 1 lá <DerivativeCardKeywords_1:Hồi âm di ảnh> vào tay."
  },
  RelicConfig_121690_Name = {
    Text = "<OrangeQuality:「Lối về bạc tinh khiết · điên cuồng」>"
  },
  RelicConfig_121691_BattleDesc = {
    Text = "Tất cả thể thức tỉnh sát thương cuối cùng của bùng nổ điên cuồng tăng 100%, mỗi lần thể thức tỉnh sau khi giải phóng bùng nổ điên cuồng, nhận được năng lượng chìa khóa bạc tương đương 500% điên cuồng cơ bản của nó, tất cả thể thức tỉnh điên cuồng cơ bản giảm 20 điểm, tối đa giảm 5 lần."
  },
  RelicConfig_121691_Desc = {
    Text = "Tất cả thể thức tỉnh sát thương cuối cùng của bùng nổ điên cuồng tăng 100%, mỗi lần thể thức tỉnh sau khi giải phóng bùng nổ điên cuồng, nhận được năng lượng chìa khóa bạc tương đương 500% điên cuồng cơ bản của nó, tất cả thể thức tỉnh điên cuồng cơ bản giảm 20 điểm, tối đa giảm 5 lần."
  },
  RelicConfig_121691_Name = {
    Text = "<OrangeQuality:「lối về bạc tinh khiết · Sợ hãi」>"
  },
  RelicConfig_121692_BattleDesc = {
    Text = "Tất cả các thân thể được đánh thức gây ra <RetaliateIconKeywords:phản công>, <IntoxicationIconKeywords:trúng độc>, tăng lá chắn và hồi sức sống 50%. Vào cuối lượt, nhận được <RetaliateIconKeywords:phản công> tạm thời tương đương 500% lá chắn hiện tại."
  },
  RelicConfig_121692_Desc = {
    Text = "Tất cả các thân thể được đánh thức gây ra <RetaliateIconKeywords:phản công>, <IntoxicationIconKeywords:trúng độc>, tăng lá chắn và hồi sức sống 50%. Vào cuối lượt, nhận được <RetaliateIconKeywords:phản công> tạm thời tương đương 500% lá chắn hiện tại."
  },
  RelicConfig_121692_Name = {
    Text = "<OrangeQuality:「Hành trình bạc tinh khiết· Tín ngưỡng xấu」>"
  },
  RelicConfig_121693_BattleDesc = {
    Text = "Giới hạn thẻ bài trên tay +5. Vào đầu lượt, rút 2 thẻ bài, nhận 2 điểm sức tính toán. Mỗi khi đặt lại bộ bài, nhận [Arg3] điểm <PowerIconKeywords:lực lượng> và [Arg4] điểm tạm thời <AlertIconKeywords:Báo động>, tạo ra mỗi loại thẻ lệnh không phải thẻ dẫn xuất cho thân thể thức tỉnh cao nhất 1 lá và đặt vào bộ bài rút, giảm tiêu thụ sức tính toán của chúng xuống 1 điểm."
  },
  RelicConfig_121693_Desc = {
    Text = "Giới hạn thẻ bài trên tay +5. Vào đầu lượt, rút 2 thẻ bài, nhận 2 điểm sức tính toán. Mỗi khi đặt lại bộ bài, nhận [Arg3] điểm <PowerIconKeywords:lực lượng> và [Arg4] điểm tạm thời <AlertIconKeywords:Báo động>, tạo ra mỗi loại thẻ lệnh không phải thẻ dẫn xuất cho thân thể thức tỉnh cao nhất 1 lá và đặt vào bộ bài rút, giảm tiêu thụ sức tính toán của chúng xuống 1 điểm."
  },
  RelicConfig_121693_Name = {
    Text = "<OrangeQuality:「Hành trình bạc tinh khiết· Đau đớn」>"
  },
  RelicConfig_121694_BattleDesc = {
    Text = "Tất cả các thân thể được đánh thức nhận được 25 điểm điên cuồng và đặt 1 lá <DerivativeCardKeywords_4:cảm hứng> vào tay khi sử dụng thẻ lệnh lần đầu tiên trong mỗi lượt. Sau khi giải phóng 4 lần「bùng nổ điên cuồng」, giải trừ trạng thái <Seal:phong ấn> của tất cả các thân thể được đánh thức và khiến tất cả các thân thể được đánh thức nhận được 50 điểm điên cuồng."
  },
  RelicConfig_121694_Desc = {
    Text = "Tất cả các thân thể được đánh thức nhận được 25 điểm điên cuồng và đặt 1 lá <DerivativeCardKeywords_4:cảm hứng> vào tay khi sử dụng thẻ lệnh lần đầu tiên trong mỗi lượt. Sau khi giải phóng 4 lần「bùng nổ điên cuồng」, giải trừ trạng thái <Seal:phong ấn> của tất cả các thân thể được đánh thức và khiến tất cả các thân thể được đánh thức nhận được 50 điểm điên cuồng."
  },
  RelicConfig_121694_Name = {
    Text = "<OrangeQuality:「lõi bạc trở về · kỳ quái」>"
  },
  RelicConfig_121695_BattleDesc = {
    Text = "Khi trận đấu bắt đầu, nhận được [Arg4] điểm <PowerIconKeywords:lực lượng>, giới hạn lưu trữ năng lượng chìa khóa bạc tăng +100%. Mỗi điểm tiêu hao sức tính toán sẽ tăng năng lượng chìa khóa bạc nhận được thêm 100%, sau khi sử dụng Bạc Khóa Tỉnh Thức hoặc kích hoạt lệnh khóa, nhận được <PowerIconKeywords:lực lượng> tạm thời tương đương 20% <PowerIconKeywords:lực lượng> hiện tại và tất cả thân thể được đánh thức nhận được 20 điểm điên cuồng."
  },
  RelicConfig_121695_Desc = {
    Text = "Khi trận đấu bắt đầu, nhận được [Arg4] điểm <PowerIconKeywords:lực lượng>, giới hạn lưu trữ năng lượng chìa khóa bạc tăng +100%. Mỗi điểm tiêu hao sức tính toán sẽ tăng năng lượng chìa khóa bạc nhận được thêm 100%, sau khi sử dụng Bạc Khóa Tỉnh Thức hoặc kích hoạt lệnh khóa, nhận được <PowerIconKeywords:lực lượng> tạm thời tương đương 20% <PowerIconKeywords:lực lượng> hiện tại và tất cả thân thể được đánh thức nhận được 20 điểm điên cuồng."
  },
  RelicConfig_121695_Name = {
    Text = "<OrangeQuality:「lối về bạc tinh khiết · khóc than」>"
  },
  RelicConfig_122625_BattleDesc = {
    Text = "Sau khi bắt đầu trận đấu, đặt [Arg1] lá\"<PVPDerivativeCardKeywords_25:Trà đỏ của Sylvia>\" vào tay."
  },
  RelicConfig_122625_Desc = {
    Text = "Sau khi bắt đầu trận đấu, đặt [Arg1] lá\"<PVPDerivativeCardKeywords_25:Trà đỏ của Sylvia>\" vào tay."
  },
  RelicConfig_122625_Name = {
    Text = "<OrangeQuality:trà đen Ceylon>"
  },
  RelicConfig_122626_BattleDesc = {
    Text = "Trong mỗi lượt, chèn vào bộ bài [Arg1] lá bài \"<PVPDerivativeCardKeywords_14:Thực tế mô phỏng>\" thuộc về thân thể được đánh thức ngẫu nhiên."
  },
  RelicConfig_122626_Desc = {
    Text = "Trong mỗi lượt, chèn vào bộ bài [Arg1] lá bài \"<PVPDerivativeCardKeywords_14:Thực tế mô phỏng>\" thuộc về thân thể được đánh thức ngẫu nhiên."
  },
  RelicConfig_122626_Name = {
    Text = "<OrangeQuality:găng tay ma thuật>"
  },
  RelicConfig_122627_BattleDesc = {
    Text = "Mỗi lượt, sát thương, chữa trị và lá chắn của kỹ năng đầu tiên được đánh ra tăng [Arg1]% ."
  },
  RelicConfig_122627_Desc = {
    Text = "Mỗi lượt, sát thương, chữa trị và lá chắn của kỹ năng đầu tiên được đánh ra tăng [Arg1]% ."
  },
  RelicConfig_122627_Name = {
    Text = "<OrangeQuality:trâm cài hồng ngọc>"
  },
  RelicConfig_122628_BattleDesc = {
    Text = "Sau khi kết thúc lượt, nhận thêm <Energy:[Arg1]> điên cuồng."
  },
  RelicConfig_122628_Desc = {
    Text = "Sau khi kết thúc lượt, nhận thêm <Energy:[Arg1]> điên cuồng."
  },
  RelicConfig_122628_Name = {
    Text = "<OrangeQuality:biểu tượng ác mộng>"
  },
  RelicConfig_122629_BattleDesc = {
    Text = "Trong bộ bài sẽ có gấp đôi thẻ người đánh thức. Sau khi đánh ra thẻ bài, nếu số thẻ bài trong tay lần đầu tiên nhỏ hơn [Arg1] trong lượt này thì rút [Arg2] thẻ."
  },
  RelicConfig_122629_Desc = {
    Text = "Trong bộ bài sẽ có gấp đôi thẻ người đánh thức. Sau khi đánh ra thẻ bài, nếu số thẻ bài trong tay lần đầu tiên nhỏ hơn [Arg1] trong lượt này thì rút [Arg2] thẻ."
  },
  RelicConfig_122629_Name = {
    Text = "<OrangeQuality:đĩa hát vui vẻ>"
  },
  RelicConfig_122630_BattleDesc = {
    Text = "Kích tước tay tối đa +[Arg1]. Trong mỗi lượt, sẽ chèn [Arg2] lá\"<PVPDerivativeCardKeywords_13:lễ tang bất diệt>\" vào rút bài từ bộ bài."
  },
  RelicConfig_122630_Desc = {
    Text = "Kích tước tay tối đa +[Arg1]. Trong mỗi lượt, sẽ chèn [Arg2] lá\"<PVPDerivativeCardKeywords_13:lễ tang bất diệt>\" vào rút bài từ bộ bài."
  },
  RelicConfig_122630_Name = {
    Text = "<OrangeQuality:dao tế bị lãng quên>"
  },
  RelicConfig_122768_BattleDesc = {
    Text = "Khi bắt đầu lượt, rút [Arg1] lá \"Đánh\" có tiêu thụ sức tính toán -1. Sau khi giải phóng bùng nổ điên cuồng, tạo ra [Arg2] lá \"Đánh\" tương ứng của thể thức tỉnh có <DepleteIconKeywords:tiêu thụ>, <PrepareKeypvewords:chuẩn bị 1> và <RetainIconKeywords:giữ lại>. \n Trong 1 lượt, mỗi khi chơi [Arg3] lá \"Đánh\", nhận được [Arg4] điểm tạm thời <PowerIconKeywords:lực lượng>; sau khi chơi [Arg5] lá \"Đánh\", rút [Arg6] lá bài và nhận [Arg7] điểm sức tính toán; sau khi chơi [Arg8] lá \"Đánh\", tất cả thể thức tỉnh nhận được [Arg9] điểm điên cuồng."
  },
  RelicConfig_122768_Desc = {
    Text = "Khi bắt đầu lượt, rút [Arg1] lá \"Đánh\" có tiêu thụ sức tính toán -1. Sau khi giải phóng bùng nổ điên cuồng, tạo ra [Arg2] lá \"Đánh\" tương ứng của thể thức tỉnh có <DepleteIconKeywords:tiêu thụ>, <PrepareKeypvewords:chuẩn bị 1> và <RetainIconKeywords:giữ lại>. \n Trong 1 lượt, mỗi khi chơi [Arg3] lá \"Đánh\", nhận được [Arg4] điểm tạm thời <PowerIconKeywords:lực lượng>; sau khi chơi [Arg5] lá \"Đánh\", rút [Arg6] lá bài và nhận [Arg7] điểm sức tính toán; sau khi chơi [Arg8] lá \"Đánh\", tất cả thể thức tỉnh nhận được [Arg9] điểm điên cuồng."
  },
  RelicConfig_122768_Name = {
    Text = "Tiếng vọng thế giới khác"
  },
  RelicConfig_122768_StoryDesc = {
    Text = "Âm vọng hòa quyện trong sương mù của thế giới khác, dẫn đến sự biến dạng, điên cuồng và thực tại không thể nghi ngờ."
  },
  RelicConfig_123724_BattleDesc = {
    Text = "Vào đầu lượt, Mouchette nhận được [Arg1] điểm điên cuồng, tạo ra 1 lá \"Đánh\" tạm thời có sức tính toán tiêu thụ bằng 0 của Mouchette. Mỗi lần kích hoạt \"Gặp gỡ kịch tính\" sẽ làm tăng hiệu ứng sát thương cơ bản và sát thương đánh của \"Lấp lánh☆Vortex\" trong trận chiến này thêm [Arg2]%."
  },
  RelicConfig_123724_Desc = {
    Text = "Vào đầu lượt, Mouchette nhận được [Arg1] điểm điên cuồng, tạo ra 1 lá \"Đánh\" tạm thời có sức tính toán tiêu thụ bằng 0 của Mouchette. Mỗi lần kích hoạt \"Gặp gỡ kịch tính\" sẽ làm tăng hiệu ứng sát thương cơ bản và sát thương đánh của \"Lấp lánh☆Vortex\" trong trận chiến này thêm [Arg2]%."
  },
  RelicConfig_123724_Name = {
    Text = "<OrangeQuality:hình ảnh chiều không gian·Mùa Hè>"
  },
  RelicConfig_125488_BattleDesc = {
    Text = "Tất cả các thân thể được đánh thức nhận được [Arg1] điểm điên cuồng khi đánh ra thẻ lệnh lần đầu tiên trong mỗi lượt. Sau khi đánh ra 4 thẻ lệnh thuộc về các thân thể được đánh thức khác nhau trong 1 lượt, áp dụng [Arg2]% máu tối đa của chúng ta lên tất cả kẻ thù <IntoxicationIconKeywords:trúng độc>."
  },
  RelicConfig_125488_Desc = {
    Text = "Tất cả các thân thể được đánh thức nhận được [Arg1] điểm điên cuồng khi đánh ra thẻ lệnh lần đầu tiên trong mỗi lượt. Sau khi đánh ra 4 thẻ lệnh thuộc về các thân thể được đánh thức khác nhau trong 1 lượt, áp dụng [Arg2]% máu tối đa của chúng ta lên tất cả kẻ thù <IntoxicationIconKeywords:trúng độc>."
  },
  RelicConfig_125488_Name = {
    Text = "Thái độ của các bà dì"
  },
  RelicConfig_125489_BattleDesc = {
    Text = "Vào đầu lượt, Tuần nhận được [Arg1] điên cuồng và áp dụng 1 lớp <WitherKeywords:cuồng si> lên tất cả kẻ địch. Thẻ lệnh đầu tiên của Tuần được chơi trong mỗi lượt nhất định sẽ kích hoạt hiệu ứng \"cộng hưởng\"."
  },
  RelicConfig_125489_Desc = {
    Text = "Vào đầu lượt, Tuần nhận được [Arg1] điên cuồng và áp dụng 1 lớp <WitherKeywords:cuồng si> lên tất cả kẻ địch. Thẻ lệnh đầu tiên của Tuần được chơi trong mỗi lượt nhất định sẽ kích hoạt hiệu ứng \"cộng hưởng\"."
  },
  RelicConfig_125489_Name = {
    Text = "<OrangeQuality:Hình ảnh chiều·Tuần>"
  },
  RelicConfig_126673_BattleDesc = {
    Text = "Kích tước tay tối đa +3. Ghi lại 3 thẻ lệnh không phái sinh đã chơi trong 3 lượt trước, và vào đầu lượt sau 3 lượt sẽ giảm giá trị Điểm tính toán của chúng -1 và thêm một bản sao có <DepleteIconKeywords:tiêu thụ> vào tay."
  },
  RelicConfig_126673_Desc = {
    Text = "Kích tước tay tối đa +3. Ghi lại 3 thẻ lệnh không phái sinh đã chơi trong 3 lượt trước, và vào đầu lượt sau 3 lượt sẽ giảm giá trị Điểm tính toán của chúng -1 và thêm một bản sao có <DepleteIconKeywords:tiêu thụ> vào tay."
  },
  RelicConfig_126673_Name = {
    Text = "Bánh Xe Vận Mệnh"
  },
  RelicConfig_126673_StoryDesc = {
    Text = "Vận mệnh xoay chuyển, vĩnh hằng không ngừng."
  },
  RelicConfig_129304_BattleDesc = {
    Text = "<OrangeQuality:Vàng hòa hợp>:\"Cân bằng Điểm tính toán\" mang lại hiệu ứng tăng cường sức tính toán tối đa là 1 điểm, mỗi 1% khuếch đại sát thương sẽ làm hiệu ứng nghiên cứu độ sâu nhận thức tăng 1%.\n<OrangeQuality:Quà tặng chiều>:Khi bắt đầu khám phá, ngẫu nhiên nhận được 1 di vật hình ảnh chiều, kích thước tay tối đa tăng 2.\n<OrangeQuality:Lễ nghi được chúc phúc>:Phần thưởng cho việc đánh bại lãnh đạo ở giai đoạn đầu tiên và thứ hai được thay đổi thành 1 trong 3 di vật được chúc phúc ngẫu nhiên.\n<RedQuality:Cảm giác mệt mỏi khi đi đường dài>:Tất cả hiệu ứng hồi phục sinh lực trong trận đấu giảm 50%, khi chọn \"Xương phai màu\" là\"An táng\" thì sẽ hồi phục 25% sinh lực tối đa.\n<RedQuality:Dấu hiệu choáng váng>:Khi bắt đầu trận đấu, tất cả thể thức tỉnh giảm 50% điên cuồng và năng lượng chìa khóa bạc hiện tại.\n<RedQuality:Hành lang đêm vĩnh cửu>:Khi bắt đầu khám phá, cơ sở điên cuồng và năng lượng chìa khóa của tất cả thể thức tỉnh tăng 50%"
  },
  RelicConfig_129304_Desc = {
    Text = "<OrangeQuality:Vàng hòa hợp>:\"Cân bằng Điểm tính toán\" mang lại hiệu ứng tăng cường sức tính toán tối đa là 1 điểm, mỗi 1% khuếch đại sát thương sẽ làm hiệu ứng nghiên cứu độ sâu nhận thức tăng 1%.\n<OrangeQuality:Quà tặng chiều>:Khi bắt đầu khám phá, ngẫu nhiên nhận được 1 di vật hình ảnh chiều, kích thước tay tối đa tăng 2.\n<OrangeQuality:Lễ nghi được chúc phúc>:Phần thưởng cho việc đánh bại lãnh đạo ở giai đoạn đầu tiên và thứ hai được thay đổi thành 1 trong 3 di vật được chúc phúc ngẫu nhiên.\n<RedQuality:Cảm giác mệt mỏi khi đi đường dài>:Tất cả hiệu ứng hồi phục sinh lực trong trận đấu giảm 50%, khi chọn \"Xương phai màu\" là\"An táng\" thì sẽ hồi phục 25% sinh lực tối đa.\n<RedQuality:Dấu hiệu choáng váng>:Khi bắt đầu trận đấu, tất cả thể thức tỉnh giảm 50% điên cuồng và năng lượng chìa khóa bạc hiện tại.\n<RedQuality:Hành lang đêm vĩnh cửu>:Khi bắt đầu khám phá, cơ sở điên cuồng và năng lượng chìa khóa của tất cả thể thức tỉnh tăng 50%"
  },
  RelicConfig_129304_Name = {
    Text = "<OrangeQuality:Camera hỗn loạn nhỏ「N」>"
  },
  RelicConfig_129304_StoryDesc = {
    Text = "Hỏng rồi! Máy ảnh hỏng hoàn toàn! Hả? Sao vẫn còn hoạt động? Chờ đã! Những giới hạn này là gì vậy?!"
  },
  RelicConfig_129305_BattleDesc = {
    Text = "<OrangeQuality:Điều hòa vàng>:\"Cân bằng Điểm tính toán\" mang lại hiệu quả tăng điểm tính toán tối đa là 1 điểm, mỗi 1% Sự khuếch đại sát thương sẽ làm tăng hiệu ứng Nghiên cứu độ sâu nhận thức lên 1%.\n<RedQuality:Cảm giác mệt mỏi khi đi đường dài>:Tất cả hiệu ứng hồi phục sinh lực trong trận đấu giảm 50%, khi chọn \"An táng\" cho \"Xương phai màu\" thì sẽ thay đổi thành hồi phục 25% Sinh lực tối đa."
  },
  RelicConfig_129305_Desc = {
    Text = "<OrangeQuality:Điều hòa vàng>:\"Cân bằng Điểm tính toán\" mang lại hiệu quả tăng điểm tính toán tối đa là 1 điểm, mỗi 1% Sự khuếch đại sát thương sẽ làm tăng hiệu ứng Nghiên cứu độ sâu nhận thức lên 1%.\n<RedQuality:Cảm giác mệt mỏi khi đi đường dài>:Tất cả hiệu ứng hồi phục sinh lực trong trận đấu giảm 50%, khi chọn \"An táng\" cho \"Xương phai màu\" thì sẽ thay đổi thành hồi phục 25% Sinh lực tối đa."
  },
  RelicConfig_129305_Name = {
    Text = "<OrangeQuality:Máy ảnh hoàn chỉnh nhỏ「N」>"
  },
  RelicConfig_129305_StoryDesc = {
    Text = "Đừng nhìn nữa, đây chính là máy ảnh! Mới tinh, không lừa dối ai."
  },
  RelicConfig_129306_BattleDesc = {
    Text = "<OrangeQuality:Vàng hòa hợp>:「Cân bằng Điểm tính toán」mang lại hiệu quả tăng cường sức tính toán tối đa là 1 điểm, mỗi 1% khuếch đại sát thương sẽ làm hiệu quả nghiên cứu độ sâu nhận thức tăng 1%.\n<OrangeQuality:Quà tặng chiều>:Khi bắt đầu khám phá, ngẫu nhiên nhận 1 di vật hình ảnh chiều, kích thước tay tối đa tăng 1.\n<RedQuality:Cảm giác mệt mỏi khi đi đường dài>:Trong chiến đấu, tất cả hiệu ứng hồi phục sinh lực giảm 50%, khi chọn「Xương phai màu」thay đổi thành hồi phục 25% sinh lực tối đa.\n<RedQuality:Dấu hiệu choáng váng>:Khi bắt đầu chiến đấu, tất cả thể thức tỉnh giảm 50% điên cuồng và năng lượng chìa khóa bạc."
  },
  RelicConfig_129306_Desc = {
    Text = "<OrangeQuality:Vàng hòa hợp>:「Cân bằng Điểm tính toán」mang lại hiệu quả tăng cường sức tính toán tối đa là 1 điểm, mỗi 1% khuếch đại sát thương sẽ làm hiệu quả nghiên cứu độ sâu nhận thức tăng 1%.\n<OrangeQuality:Quà tặng chiều>:Khi bắt đầu khám phá, ngẫu nhiên nhận 1 di vật hình ảnh chiều, kích thước tay tối đa tăng 1.\n<RedQuality:Cảm giác mệt mỏi khi đi đường dài>:Trong chiến đấu, tất cả hiệu ứng hồi phục sinh lực giảm 50%, khi chọn「Xương phai màu」thay đổi thành hồi phục 25% sinh lực tối đa.\n<RedQuality:Dấu hiệu choáng váng>:Khi bắt đầu chiến đấu, tất cả thể thức tỉnh giảm 50% điên cuồng và năng lượng chìa khóa bạc."
  },
  RelicConfig_129306_Name = {
    Text = "<OrangeQuality:máy ảnh cũ kỹ nhỏ「N」>"
  },
  RelicConfig_129306_StoryDesc = {
    Text = "Hỏng rồi! Máy ảnh bị hỏng rồi! Để tôi sửa thử xem…… Khởi động lên rồi! Nhưng sao cảm thấy kỳ kỳ……"
  },
  RelicConfig_131079_BattleDesc = {
    Text = "Vào đầu lượt, Mosk nhận được [Arg1] điên cuồng. Mỗi lần chơi \"Súc tích!\" hoặc \"Gắn đầy!\" lần đầu trong mỗi lượt sẽ có hiệu lực 2 lần."
  },
  RelicConfig_131079_Desc = {
    Text = "Vào đầu lượt, Mosk nhận được [Arg1] điên cuồng. Mỗi lần chơi \"Súc tích!\" hoặc \"Gắn đầy!\" lần đầu trong mỗi lượt sẽ có hiệu lực 2 lần."
  },
  RelicConfig_131079_Name = {
    Text = "<OrangeQuality:ảnh chiều·Mosk>"
  },
  RelicConfig_131080_BattleDesc = {
    Text = "Vào đầu 3 lượt đầu tiên, kích hoạt 1 lần \"Khó khăn hải ly\" mỗi lượt. Vào đầu lượt thứ 5, loại bỏ tất cả hiệu ứng tiêu cực của \"Khó khăn hải ly\" và nhận được \"<DerivativeCardKeywords_135:Tác động thế hệ thứ hai!>\"."
  },
  RelicConfig_131080_Desc = {
    Text = "Vào đầu 3 lượt đầu tiên, kích hoạt 1 lần \"Khó khăn hải ly\" mỗi lượt. Vào đầu lượt thứ 5, loại bỏ tất cả hiệu ứng tiêu cực của \"Khó khăn hải ly\" và nhận được \"<DerivativeCardKeywords_135:Tác động thế hệ thứ hai!>\"."
  },
  RelicConfig_131080_Name = {
    Text = "Viên than nhỏ II"
  },
  RelicConfig_131080_StoryDesc = {
    Text = "Bà Mosk kiên quyết nói đây chính là Di vật. \n \"Kẻ xấu, cắn hắn!\""
  },
  RelicConfig_131178_BattleDesc = {
    Text = "Khi bắt đầu chiến đấu, trộn một lá\"<DerivativeCardKeywords_134:Chân Tướng Cấm Kỵ>\" vào bộ bài. Số lá rút mỗi lượt +[Arg1]. Sau khi đánh ra lá bài chỉ lệnh, lần lượt gắn <ErosionColorInkKeywords:Nhận Thức Hỗn Loạn> cho [Arg2] lá bài chỉ lệnh ngẫu nhiên không mang <ErosionColorInkKeywords:Nhận Thức Hỗn Loạn> trong bài trên tay, bộ bài rút và bộ bài bỏ."
  },
  RelicConfig_131178_Desc = {
    Text = "Khi bắt đầu chiến đấu, trộn một lá\"<DerivativeCardKeywords_134:Chân Tướng Cấm Kỵ>\" vào bộ bài. Số lá rút mỗi lượt +[Arg1]. Sau khi đánh ra lá bài chỉ lệnh, lần lượt gắn <ErosionColorInkKeywords:Nhận Thức Hỗn Loạn> cho [Arg2] lá bài chỉ lệnh ngẫu nhiên không mang <ErosionColorInkKeywords:Nhận Thức Hỗn Loạn> trong bài trên tay, bộ bài rút và bộ bài bỏ."
  },
  RelicConfig_131178_Name = {
    Text = "Nhật ký Áo Nha"
  },
  RelicConfig_131178_StoryDesc = {
    Text = "Nội dung ghi lại bao gồm bảy mươi số nguyên tố Mason."
  },
  RelicConfig_132540_BattleDesc = {
    Text = "Miễn dịch với sát thương"
  },
  RelicConfig_132540_Name = {
    Text = "Tạo vật kiểm tra tập hợp"
  },
  RelicConfig_13740_BattleDesc = {
    Text = "Tỷ lệ chí mạng tăng 15%. Vào đầu lượt, nếu sức sống dưới 25%([Arg1]), tỷ lệ chí mạng trong lượt đó tăng thêm 30%."
  },
  RelicConfig_13740_Desc = {
    Text = "Tỷ lệ chí mạng tăng 15%. Tại đầu lượt, nếu sức sống dưới 25%, tỷ lệ chí mạng trong lượt đó tăng thêm 30%."
  },
  RelicConfig_13740_Name = {
    Text = "<OrangeQuality:thiết bị sao bí truyền>"
  },
  RelicConfig_13740_StoryDesc = {
    Text = "Bí ẩn của vũ trụ."
  },
  RelicConfig_13741_BattleDesc = {
    Text = "Tăng thương chí mạng 15%. Thương gây ra cho kẻ địch có lá chắn luôn là chí mạng."
  },
  RelicConfig_13741_Desc = {
    Text = "Tăng thương chí mạng 15%. Thương gây ra cho kẻ địch có lá chắn luôn là chí mạng."
  },
  RelicConfig_13741_Name = {
    Text = "<WhiteQuality:nguyên lý thẩm mỹ>"
  },
  RelicConfig_13741_StoryDesc = {
    Text = "Nghệ nhân bình tượng nến: Người giúp đỡ bác sĩ, khách hàng của nhà tang lễ, người nuôi dưỡng sâu mộ."
  },
  RelicConfig_13742_BattleDesc = {
    Text = "Thương chí mạng +50%. Cứ mỗi 3 lần tấn công, đòn thứ ba chắc chắn chí mạng."
  },
  RelicConfig_13742_Desc = {
    Text = "Thương chí mạng +50%. Cứ mỗi 3 lần tấn công, đòn thứ ba chắc chắn chí mạng."
  },
  RelicConfig_13742_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「thiền định」>"
  },
  RelicConfig_13743_BattleDesc = {
    Text = "Vào đầu lượt, thức tỉnh có ít điên cuồng nhất nhận 15 điên cuồng. Khi đánh liên tiếp 2 thẻ bài có sức tính toán tiêu thụ thấp hơn thẻ trước đó, thức tỉnh có ít điên cuồng nhất nhận thêm 15 điên cuồng."
  },
  RelicConfig_13743_Desc = {
    Text = "Vào đầu lượt, thức tỉnh có ít điên cuồng nhất nhận 15 điên cuồng. Khi đánh liên tiếp 2 thẻ bài có sức tính toán tiêu thụ thấp hơn thẻ trước đó, thức tỉnh có ít điên cuồng nhất nhận thêm 15 điên cuồng."
  },
  RelicConfig_13743_Name = {
    Text = "<OrangeQuality:di vật Arknah>"
  },
  RelicConfig_13743_StoryDesc = {
    Text = "Số phận cuối cùng."
  },
  RelicConfig_13744_BattleDesc = {
    Text = "Sau khi bắt đầu lượt, thân thể được đánh thức có mức điên cuồng thấp nhất nhận được 15 điên cuồng."
  },
  RelicConfig_13744_Desc = {
    Text = "Sau khi bắt đầu lượt, thân thể được đánh thức có mức điên cuồng thấp nhất nhận được 15 điên cuồng."
  },
  RelicConfig_13744_Name = {
    Text = "<WhiteQuality:khuy áo lá quế>"
  },
  RelicConfig_13744_StoryDesc = {
    Text = "Cuffs bạc khắc hoa lá quế. \nTinh xảo và lấp lánh, lưu giữ tình bạn của hai đứa trẻ."
  },
  RelicConfig_13745_BattleDesc = {
    Text = "Hiệu ứng tăng cường đề xuất của giới vực được nâng lên 50%, tỷ lệ khắcăng may mắn của bạn sẽ nhân đôi khi bắt đầu màn chơi."
  },
  RelicConfig_13745_Desc = {
    Text = "Hiệu ứng tăng cường đề xuất của giới vực được nâng lên 50%, tỷ lệ khắcăng may mắn của bạn sẽ nhân đôi khi bắt đầu màn chơi."
  },
  RelicConfig_13745_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh 「ngủ say」>"
  },
  RelicConfig_13747_BattleDesc = {
    Text = "Miễn dịch 1 lần chết, sau khi kích hoạt sẽ lập tức hồi phục 10% máu, kích hoạt 3 lần sau đó sẽ vô hiệu hóa vĩnh viễn."
  },
  RelicConfig_13747_Desc = {
    Text = "Miễn dịch 1 lần chết, sau khi kích hoạt sẽ lập tức hồi phục 10% máu, kích hoạt 3 lần sau đó sẽ vô hiệu hóa vĩnh viễn."
  },
  RelicConfig_13747_Name = {
    Text = "<WhiteQuality:☆thực phẩm khẩn cấp☆>"
  },
  RelicConfig_13747_StoryDesc = {
    Text = "Trong trường hợp bất khả kháng, cũng không nên ăn cái này."
  },
  RelicConfig_13748_BattleDesc = {
    Text = "Khi trận chiến bắt đầu, tất cả các thẻ bài có tiêu thụ sức tính toán là 1 sẽ được tăng [Arg1] thương và [Arg2] lá chắn trong trận chiến này."
  },
  RelicConfig_13748_Desc = {
    Text = "Khi trận chiến bắt đầu, tất cả các thẻ bài có tiêu thụ sức tính toán là 1 sẽ được tăng [Arg1] thương và [Arg2] lá chắn trong trận chiến này."
  },
  RelicConfig_13748_Name = {
    Text = "<OrangeQuality:Mary Thuần Khiết>"
  },
  RelicConfig_13748_StoryDesc = {
    Text = "Lôgic giống như cocktail, tiêu thụ quá nhiều sẽ mất đi lợi ích của nó."
  },
  RelicConfig_13749_BattleDesc = {
    Text = "Mỗi 4 lượt, tất cả kẻ địch nhận gấp đôi sát thương chủ động và xúc tu trong lượt đó, nhưng sau khi kích hoạt điên cuồng trong lượt đó, tất cả thân thể được đánh thức sẽ bị phong ấn trong 1 lượt."
  },
  RelicConfig_13749_Desc = {
    Text = "Mỗi 4 lượt, tất cả kẻ địch nhận gấp đôi sát thương chủ động và xúc tu trong lượt đó, nhưng sau khi kích hoạt điên cuồng trong lượt đó, tất cả thân thể được đánh thức sẽ bị phong ấn trong 1 lượt."
  },
  RelicConfig_13749_Name = {
    Text = "<RedQuality:Xác của Đạo Hành>"
  },
  RelicConfig_13749_StoryDesc = {
    Text = "Một phần thiêng liêng. \nDù có tách khỏi thân thể, dấu chân của nó đã in dấu chân trên khắp mọi miền."
  },
  RelicConfig_13750_BattleDesc = {
    Text = "Khi kết thúc lượt, nếu không có lá chắn, nhận một lớp <ParcloseIconKeywords:rào cản> miễn nhiễm với một lần sát thương. Chỉ hiệu lực 1 lần trong mỗi trận chiến."
  },
  RelicConfig_13750_Desc = {
    Text = "Khi kết thúc lượt, nếu không có lá chắn, nhận một lớp <ParcloseIconKeywords:rào cản> miễn nhiễm với một lần sát thương. Chỉ hiệu lực 1 lần trong mỗi trận chiến."
  },
  RelicConfig_13750_Name = {
    Text = "<WhiteQuality:☆viên thuốc giảm đau☆>"
  },
  RelicConfig_13750_StoryDesc = {
    Text = "Hiệu ứng không phải lúc nào cũng kéo dài mãi mãi."
  },
  RelicConfig_13751_BattleDesc = {
    Text = "Tỷ lệ chí mạng tăng 25%, thương gây ra lần đầu tiên mỗi lượt được nhân đôi."
  },
  RelicConfig_13751_Desc = {
    Text = "Tỷ lệ chí mạng tăng 25%, thương gây ra lần đầu tiên mỗi lượt được nhân đôi."
  },
  RelicConfig_13751_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh 「sâu sắc」>"
  },
  RelicConfig_13752_BattleDesc = {
    Text = "Vào đầu lượt, hồi phục [Arg1] sức sống. Nếu sức sống dưới 50%, hồi phục sức sống tăng lên [Arg2]."
  },
  RelicConfig_13752_Desc = {
    Text = "Vào đầu lượt, hồi phục [Arg1] sức sống. Nếu sức sống dưới 50%, hồi phục sức sống tăng lên [Arg2]."
  },
  RelicConfig_13752_Name = {
    Text = "<WhiteQuality:Máu ban ơn>"
  },
  RelicConfig_13752_StoryDesc = {
    Text = "Nó ngọt ngào và đậm đà, toả ra hương thơm của hoa hồng."
  },
  RelicConfig_13753_BattleDesc = {
    Text = "Đây là một tạo vật nhiệm vụ không có hiệu ứng"
  },
  RelicConfig_13753_Desc = {
    Text = "Đây là một tạo vật nhiệm vụ không có hiệu ứng"
  },
  RelicConfig_13753_Name = {
    Text = "Kiểm tra nhiệm vụ sáng tạo"
  },
  RelicConfig_13753_StoryDesc = {
    Text = "Cần bổ sung sáng tạo"
  },
  RelicConfig_13754_BattleDesc = {
    Text = "Mỗi lần thứ 5 bạn gây thương, chắc chắn sẽ là đòn chí mạng."
  },
  RelicConfig_13754_Desc = {
    Text = "Mỗi lần thứ 5 bạn gây thương, chắc chắn sẽ là đòn chí mạng."
  },
  RelicConfig_13754_Name = {
    Text = "<WhiteQuality:thiết bị chỉnh thị lực>"
  },
  RelicConfig_13754_StoryDesc = {
    Text = "Từng có người nhờ vào nó, tìm thấy sự thật."
  },
  RelicConfig_13755_BattleDesc = {
    Text = "Tại đầu lượt, mỗi thẻ bài trong <DimensionalSpaceIconKeywords:siêu việt không gian> sẽ mang lại [Arg1] điểm lực lượng tạm thời, nếu lượt này là lượt siêu chiều, thì nhận được [Arg2] điểm lực lượng tạm thời."
  },
  RelicConfig_13755_Desc = {
    Text = "Vào đầu lượt, cứ mỗi thẻ bài trong <DimensionalSpaceIconKeywords:siêu việt không gian> sẽ nhận được [Arg1] điểm <PowerIconKeywords:lực lượng> tạm thời, nếu lượt này là lượt siêu chiều, thì sẽ nhận được [Arg2] điểm <PowerIconKeywords:lực lượng> tạm thời."
  },
  RelicConfig_13755_Name = {
    Text = "<WhiteQuality:lăng kính>"
  },
  RelicConfig_13755_StoryDesc = {
    Text = "\"Ánh sáng được tạo thành từ bảy màu sắc.\""
  },
  RelicConfig_13756_BattleDesc = {
    Text = "Khi nhặt, mất tất cả các sáng tạo khác, nhận ngẫu nhiên 2 đồ tạo tác vàng."
  },
  RelicConfig_13756_Desc = {
    Text = "Khi nhặt, mất tất cả các sáng tạo khác, nhận ngẫu nhiên 2 đồ tạo tác vàng."
  },
  RelicConfig_13756_Name = {
    Text = "<RedQuality:☆Ngắm ngược☆>"
  },
  RelicConfig_13756_StoryDesc = {
    Text = "Trong kỷ nguyên kỳ lạ, hoa mới là những người ngắm nhìn đầu tiên của loài người.\nĐừng động đậy, Họ thích những tác phẩm trưng bày yên tĩnh hơn."
  },
  RelicConfig_13757_BattleDesc = {
    Text = "Mỗi lần bạn đánh ra thẻ lệnh thứ 8 sẽ có hiệu lực 2 lần."
  },
  RelicConfig_13757_Desc = {
    Text = "Mỗi lần bạn đánh ra thẻ lệnh thứ 8 sẽ có hiệu lực 2 lần."
  },
  RelicConfig_13757_Name = {
    Text = "<OrangeQuality:Rượu Tinh Vân>"
  },
  RelicConfig_13757_StoryDesc = {
    Text = "Di chuyển giữa các ngôi sao."
  },
  RelicConfig_13758_BattleDesc = {
    Text = "Nhặt được sẽ tăng máu tối đa [Arg1] điểm, và khi bị tấn công, lượng điên cuồng nhận được tăng thêm 2 điểm."
  },
  RelicConfig_13758_Desc = {
    Text = "Nhặt được sẽ tăng máu tối đa [Arg1] điểm, và khi bị tấn công, lượng điên cuồng nhận được tăng thêm 2 điểm."
  },
  RelicConfig_13758_Name = {
    Text = "<WhiteQuality:mực ngọt ngào>"
  },
  RelicConfig_13758_StoryDesc = {
    Text = "Có người nói rằng đây là máu của quỷ, nhưng mà, này, hãy thử xem nào!"
  },
  RelicConfig_13759_BattleDesc = {
    Text = "Khi phát động cơn thịnh nộ bùng phát, mỗi lần kẻ địch sắp gây ra 1 lần thương, áp dụng [Arg1] lớp <IntoxicationIconKeywords:trúng độc>"
  },
  RelicConfig_13759_Desc = {
    Text = "Khi phát động cơn thịnh nộ bùng phát, mỗi lần kẻ địch sắp gây ra 1 lần thương, áp dụng [Arg1] lớp <IntoxicationIconKeywords:trúng độc>"
  },
  RelicConfig_13759_Name = {
    Text = "<WhiteQuality:☆hàm tia laser☆>"
  },
  RelicConfig_13759_StoryDesc = {
    Text = "Xương cốt được trưng bày trong phòng triển lãm tư nhân của một nhà sưu tập. \nNhà sưu tập mê đắm ánh huỳnh quang tuyệt đẹp, ngày đêm chiêm ngưỡng, cuối cùng héo mòn và trở thành đồng loại với nó."
  },
  RelicConfig_13760_BattleDesc = {
    Text = "Sức tính toán tối đa tăng 1. Khi đánh liên tiếp 2 thẻ bài có chi phí tiêu thụ cao hơn thẻ bài trước đó, nhận được 1 sức tính toán."
  },
  RelicConfig_13760_Desc = {
    Text = "Sức tính toán tối đa tăng 1. Khi đánh liên tiếp 2 thẻ bài có chi phí tiêu thụ cao hơn thẻ bài trước đó, nhận được 1 sức tính toán."
  },
  RelicConfig_13760_Name = {
    Text = "<OrangeQuality:Arcana Records>"
  },
  RelicConfig_13760_StoryDesc = {
    Text = "Diễn biến số phận"
  },
  RelicConfig_13761_BattleDesc = {
    Text = "Vào đầu lượt, nếu số lá bài còn lại trong tay của lượt trước vượt quá 3 lá, nhận được 2 sức tính toán."
  },
  RelicConfig_13761_Desc = {
    Text = "Vào đầu lượt, nếu số lá bài còn lại trong tay của lượt trước vượt quá 3 lá, nhận được 2 sức tính toán."
  },
  RelicConfig_13761_Name = {
    Text = "<WhiteQuality:Huy hiệu Misaque>"
  },
  RelicConfig_13761_StoryDesc = {
    Text = "Huy hiệu được Đại học Misaque phân phát cho các điều tra viên. Nó không chỉ tượng trưng cho danh tính của người đeo, mà còn là công cụ hỗ trợ liên lạc từ xa."
  },
  RelicConfig_13762_BattleDesc = {
    Text = "Khi đánh ra \"phòng thủ\", nhận được [Arg1] điểm <RetaliateIconKeywords:phản công>."
  },
  RelicConfig_13762_Desc = {
    Text = "Khi đánh ra \"phòng thủ\", nhận được [Arg1] điểm <RetaliateIconKeywords:phản công>."
  },
  RelicConfig_13762_Name = {
    Text = "Áo giáp ngực dị biến tầm ma"
  },
  RelicConfig_13762_StoryDesc = {
    Text = "Không thể phân biệt chất lỏng lạ."
  },
  RelicConfig_13763_BattleDesc = {
    Text = "Khi bắt đầu chiến đấu, nhận được [Arg1] điểm lá chắn. Khi bắt đầu lượt, nếu có lá chắn, hiệu ứng lá chắn và chữa trị trong lượt đó mạnh mẽ thêm 50%."
  },
  RelicConfig_13763_Desc = {
    Text = "Khi bắt đầu chiến đấu, nhận được [Arg1] điểm lá chắn. Khi bắt đầu lượt, nếu có lá chắn, hiệu ứng lá chắn và chữa trị trong lượt đó mạnh mẽ thêm 50%."
  },
  RelicConfig_13763_Name = {
    Text = "Người Bảo Vệ Vườn Dị Hóa"
  },
  RelicConfig_13764_BattleDesc = {
    Text = "Nhặt được sẽ nhận vĩnh viễn [Arg1] điểm <PowerIconKeywords:sức mạnh>."
  },
  RelicConfig_13764_Desc = {
    Text = "Nhặt được sẽ nhận vĩnh viễn [Arg1] điểm <PowerIconKeywords:sức mạnh>."
  },
  RelicConfig_13764_Name = {
    Text = "<WhiteQuality:trâm cài hồng ngọc>"
  },
  RelicConfig_13764_StoryDesc = {
    Text = "Lờ mờ thấm ra màu đỏ thắm."
  },
  RelicConfig_13766_BattleDesc = {
    Text = "Khi nhặt, chọn một thẻ bài và áp dụng hai hiệu ứng tăng cường ba lựa chọn lên nó. (Lưu ý: Tương tự như kỹ năng tạo thẻ trong 'Hình Ảnh Ngàn Mặt')"
  },
  RelicConfig_13766_Desc = {
    Text = "Khi nhặt, chọn một thẻ bài và áp dụng hai hiệu ứng tăng cường ba lựa chọn lên nó. (Lưu ý: Tương tự như kỹ năng tạo thẻ trong 'Hình Ảnh Ngàn Mặt')"
  },
  RelicConfig_13766_Name = {
    Text = "<OrangeQuality:☆nghệ nhân đánh máy☆>"
  },
  RelicConfig_13766_StoryDesc = {
    Text = "Có lời đồn rằng, thực sự viết ra những kiệt tác lưu danh hậu thế chính là máy đánh chữ."
  },
  RelicConfig_13767_BattleDesc = {
    Text = "Nhận được 3 chọn 1 đá khắc cao cấp ngẫu nhiên khi nhặt, và gán nó cho thẻ bài tương ứng."
  },
  RelicConfig_13767_Desc = {
    Text = "Nhận được 3 chọn 1 đá khắc cao cấp ngẫu nhiên khi nhặt, và gán nó cho thẻ bài tương ứng."
  },
  RelicConfig_13767_Name = {
    Text = "<WhiteQuality:Cuộn giấy Rhind>"
  },
  RelicConfig_13767_StoryDesc = {
    Text = "Câu hỏi như sau: 10 tu sĩ chia 6 ổ bánh mì, mỗi người được bao nhiêu?"
  },
  RelicConfig_13768_BattleDesc = {
    Text = "Sức tính toán tối đa tăng 2. Sau khi sử dụng \"Đánh\" hoặc \"Phòng thủ\", thân thể được đánh thức tương ứng nhận được 5 điên cuồng. Sau khi kích hoạt cơn thịnh nộ bùng phát, nhận được 1 thẻ \"Đánh\" từ thân thể được đánh thức kèm tiêu thụ hư vô. Sau khi sử dụng lệnh khóa, ngẫu nhiên nhận được 1 thẻ \"Phòng thủ\" kèm tiêu thụ hư vô."
  },
  RelicConfig_13768_Desc = {
    Text = "Sức tính toán tối đa tăng 2. Sau khi sử dụng \"Đánh\" hoặc \"Phòng thủ\", thân thể được đánh thức tương ứng nhận được 5 điên cuồng. Sau khi kích hoạt cơn thịnh nộ bùng phát, nhận được 1 thẻ \"Đánh\" từ thân thể được đánh thức kèm tiêu thụ hư vô. Sau khi sử dụng lệnh khóa, ngẫu nhiên nhận được 1 thẻ \"Phòng thủ\" kèm tiêu thụ hư vô."
  },
  RelicConfig_13768_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh 「cánh」>"
  },
  RelicConfig_13769_BattleDesc = {
    Text = "Vào đầu lượt, <EmbryoFusionIconKeywords:phôi thai hợp tử>+30. Tất cả hiệu ứng <DevouredIconKeywords:tiêu thụ> của bạn đều trở thành <UnlimitedDevouredIconKeywords:tiêu thụ vô hạn>."
  },
  RelicConfig_13769_Desc = {
    Text = "Vào đầu lượt, <EmbryoFusionIconKeywords:phôi thai hợp tử>+30. Tất cả hiệu ứng <DevouredIconKeywords:tiêu thụ> của bạn đều trở thành <UnlimitedDevouredIconKeywords:tiêu thụ vô hạn>."
  },
  RelicConfig_13769_Name = {
    Text = "<RedQuality:cuống rốn ngọ nguậy>"
  },
  RelicConfig_13769_StoryDesc = {
    Text = "Cuốn quanh cổ."
  },
  RelicConfig_13770_BattleDesc = {
    Text = "Vào đầu lượt nhận [Arg1] lá chắn, mỗi lượt tiếp theo tăng giá trị lá chắn [Arg2]."
  },
  RelicConfig_13770_Desc = {
    Text = "Vào đầu lượt nhận [Arg1] lá chắn, mỗi lượt tiếp theo tăng giá trị lá chắn [Arg2]."
  },
  RelicConfig_13770_Name = {
    Text = "<WhiteQuality:Bàn Tay Bảo Vệ>"
  },
  RelicConfig_13770_StoryDesc = {
    Text = "Tay cầu phúc, nắm đấm kiên định."
  },
  RelicConfig_13771_BattleDesc = {
    Text = "Tất cả thân thể được đánh thức sạc chìa khóa bạc tăng 30. Sau khi phát hành lệnh khóa, trộn 3 thẻ <DerivativeCardKeywords_4:「cảm hứng」> vào bộ bài của bạn."
  },
  RelicConfig_13771_Desc = {
    Text = "Tất cả thân thể được đánh thức sạc chìa khóa bạc tăng 30. Sau khi phát hành lệnh khóa, trộn 3 thẻ <DerivativeCardKeywords_4:「cảm hứng」> vào bộ bài của bạn."
  },
  RelicConfig_13771_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh 「ngủ nhẹ」>"
  },
  RelicConfig_13772_BattleDesc = {
    Text = "Sau khi chiến đấu kết thúc, nhận thêm 75 dấu đen cùng 1 thẻ triệu chứng."
  },
  RelicConfig_13772_Desc = {
    Text = "Sau khi chiến đấu kết thúc, nhận thêm 75 dấu đen cùng 1 thẻ triệu chứng."
  },
  RelicConfig_13772_Name = {
    Text = "<RedQuality:Ấn Ngọc Lục Bảo>"
  },
  RelicConfig_13772_StoryDesc = {
    Text = "Đây là bản khắc bất diệt qua nghìn năm."
  },
  RelicConfig_13773_BattleDesc = {
    Text = "Mỗi lần gây sát thương chủ động, sẽ áp dụng [Arg1] lớp <BleedingIconKeywords:chảy máu> cho bản thân, và áp dụng [Arg2] lớp <BleedingIconKeywords:chảy máu> cho mục tiêu bị thương. Mỗi khi giết 1 kẻ địch, sẽ giải tán trạng thái <BleedingIconKeywords:chảy máu> của bản thân."
  },
  RelicConfig_13773_Desc = {
    Text = "Mỗi lần gây sát thương chủ động, sẽ áp dụng [Arg1] lớp <BleedingIconKeywords:chảy máu> cho bản thân, và áp dụng [Arg2] lớp <BleedingIconKeywords:chảy máu> cho mục tiêu bị thương. Mỗi khi giết 1 kẻ địch, sẽ giải trừ trạng thái <BleedingIconKeywords:chảy máu> của bản thân."
  },
  RelicConfig_13773_Name = {
    Text = "<RedQuality:ý thức bầy đàn>"
  },
  RelicConfig_13773_StoryDesc = {
    Text = "Bị cuốn vào, sự cộng sinh, sự quần tụ; sợ hãi, điều chưa biết, kiểm soát."
  },
  RelicConfig_13774_BattleDesc = {
    Text = "Khi chơi 1 thẻ bài có tiêu thụ sức tính toán thực tế là 3, rút 1 thẻ bài và nhận 2 điểm sức tính toán; Khi chơi 1 thẻ bài có tiêu thụ sức tính toán thực tế là 4 hoặc cao hơn, tiêu thụ sức tính toán của các thẻ bài khác trong tay giảm 1 điểm."
  },
  RelicConfig_13774_Desc = {
    Text = "Khi chơi 1 thẻ bài có tiêu thụ sức tính toán thực tế là 3, rút 1 thẻ bài và nhận 2 điểm sức tính toán; Khi chơi 1 thẻ bài có tiêu thụ sức tính toán thực tế là 4 hoặc cao hơn, tiêu thụ sức tính toán của các thẻ bài khác trong tay giảm 1 điểm."
  },
  RelicConfig_13774_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh 「mắt」>"
  },
  RelicConfig_13775_BattleDesc = {
    Text = "Khi nhặt, chọn một thẻ lệnh để nó nhận được \"Cố hữu\", \"Bảo lưu\" và \"Rút 1 thẻ sau khi đánh\"."
  },
  RelicConfig_13775_Desc = {
    Text = "Khi nhặt, chọn một thẻ lệnh để nó nhận được \"Cố hữu\", \"Bảo lưu\" và \"Rút 1 thẻ sau khi đánh\"."
  },
  RelicConfig_13775_Name = {
    Text = "<WhiteQuality:thư mục>"
  },
  RelicConfig_13775_StoryDesc = {
    Text = "Suỵt, đây là giao dịch bí mật chỉ thuộc về bạn và tôi."
  },
  RelicConfig_13776_BattleDesc = {
    Text = "Sau khi chiến đấu bắt đầu, nhận được 1 râu."
  },
  RelicConfig_13776_Desc = {
    Text = "Sau khi chiến đấu bắt đầu, nhận được 1 râu."
  },
  RelicConfig_13776_Name = {
    Text = "<WhiteQuality:ốc vàng nhỏ>"
  },
  RelicConfig_13776_StoryDesc = {
    Text = "Con ốc vàng nhỏ này xuất thân cao quý, có nguồn hoàn hảo, không thể chê vào đâu được."
  },
  RelicConfig_13777_BattleDesc = {
    Text = "Khi kết thúc lượt lẻ, nếu còn dư sức tính toán, rút thêm 2 lá bài vào lượt tiếp theo; khi kết thúc lượt chẵn, nếu còn dư bài trong tay, nhận thêm 2 sức tính toán vào lượt tiếp theo."
  },
  RelicConfig_13777_Desc = {
    Text = "Khi kết thúc lượt lẻ, nếu còn dư sức tính toán, rút thêm 2 lá bài vào lượt tiếp theo; khi kết thúc lượt chẵn, nếu còn dư bài trong tay, nhận thêm 2 sức tính toán vào lượt tiếp theo."
  },
  RelicConfig_13777_Name = {
    Text = "<OrangeQuality:đĩa xoay nhật nguyệt>"
  },
  RelicConfig_13777_StoryDesc = {
    Text = "Đoán xem, là đen hay trắng?"
  },
  RelicConfig_13778_BattleDesc = {
    Text = "Giới hạn râu chạm tăng lên 1. Khi sức sống dưới 50%, <TentacleInjurieIconKeywords:thương tổn xúc tu> tăng [Arg1]."
  },
  RelicConfig_13778_Desc = {
    Text = "Giới hạn râu chạm tăng lên 1. Khi sức sống dưới 50%, <TentacleInjurieIconKeywords:thương tổn xúc tu> tăng [Arg1]."
  },
  RelicConfig_13778_Name = {
    Text = "<OrangeQuality:Bài ca của Biển>"
  },
  RelicConfig_13778_StoryDesc = {
    Text = "Nghe nói rằng ốc vân và các động vật không ăn được hấp thụ khoảng 80% dinh dưỡng của đại dương."
  },
  RelicConfig_13779_BattleDesc = {
    Text = "Khi bắt đầu lượt, rút 1 lá bài; khi kết thúc lượt, được phép chọn giữ lại 1 lá bài trong tay."
  },
  RelicConfig_13779_Desc = {
    Text = "Khi bắt đầu lượt, rút 1 lá bài; khi kết thúc lượt, được phép chọn giữ lại 1 lá bài trong tay."
  },
  RelicConfig_13779_Name = {
    Text = "<OrangeQuality:Đèn Ước Nguyện của Tiên Tri>"
  },
  RelicConfig_13779_StoryDesc = {
    Text = "Thực hiện mong muốn của bạn."
  },
  RelicConfig_13780_BattleDesc = {
    Text = "Mỗi lần kích hoạt cơn thịnh nộ bùng phát, nhận được 1 lá <DerivativeCardKeywords_7:「sự xâm nhập độc tính」>, nếu trong tay có 3 lá <DerivativeCardKeywords_7:「sự xâm nhập độc tính」> thì hợp thành một lá <DerivativeCardKeywords_8:「phát tác độc tính」> gây ra <IntoxicationIconKeywords:trúng độc>."
  },
  RelicConfig_13780_Desc = {
    Text = "Mỗi lần kích hoạt cơn thịnh nộ bùng phát, nhận được 1 lá <DerivativeCardKeywords_7:「sự xâm nhập độc tính」>, nếu trong tay có 3 lá <DerivativeCardKeywords_7:「sự xâm nhập độc tính」> thì hợp thành một lá <DerivativeCardKeywords_8:「phát tác độc tính」> gây ra <IntoxicationIconKeywords:trúng độc>."
  },
  RelicConfig_13780_Name = {
    Text = "<OrangeQuality:người phát ngôn dị chủng>"
  },
  RelicConfig_13780_StoryDesc = {
    Text = "Ngài không phải là quỷ, nhưng Ngài thực sự truyền đạt lời thì thầm vượt ngoài thế giới loài người."
  },
  RelicConfig_13781_BattleDesc = {
    Text = "Mỗi khi tiêu thụ 1 dấu đen, tất cả thân thể được đánh thức nhận được 1 điểm khí điên cuồng."
  },
  RelicConfig_13781_Desc = {
    Text = "Mỗi khi tiêu thụ 1 dấu đen, tất cả thân thể được đánh thức nhận được 1 điểm khí điên cuồng."
  },
  RelicConfig_13781_Name = {
    Text = "Hoa nghịch sinh"
  },
  RelicConfig_13782_BattleDesc = {
    Text = "Miễn dịch với sát thương"
  },
  RelicConfig_13782_Desc = {
    Text = "Miễn dịch với sát thương"
  },
  RelicConfig_13782_Name = {
    Text = "Vật thử nghiệm"
  },
  RelicConfig_13783_BattleDesc = {
    Text = "Mỗi lượt sau khi đánh lá bài thứ 3, thêm 1 lá <DerivativeCardKeywords_4:「cảm hứng」> vào rác bài. Mỗi lượt sau khi đánh lá bài thứ 6, nhặt 1 lá <DerivativeCardKeywords_4:「cảm hứng」> từ rác bài và thêm vào tay bài."
  },
  RelicConfig_13783_Desc = {
    Text = "Mỗi lượt sau khi đánh lá bài thứ 3, thêm 1 lá <DerivativeCardKeywords_4:「cảm hứng」> vào rác bài. Mỗi lượt sau khi đánh lá bài thứ 6, nhặt 1 lá <DerivativeCardKeywords_4:「cảm hứng」> từ rác bài và thêm vào tay bài."
  },
  RelicConfig_13783_Name = {
    Text = "<WhiteQuality:ánh sáng văn minh>"
  },
  RelicConfig_13783_StoryDesc = {
    Text = "Sao băng xé tan bóng đêm."
  },
  RelicConfig_13784_BattleDesc = {
    Text = "Mỗi khi bắt đầu lượt, nhận được 1 sức tính toán cho mỗi kẻ địch. Khi tiêu diệt kẻ địch bằng sát thương chủ động, gây <BleedingIconKeywords:chảy máu> tương đương với sát thương vượt mức cho các kẻ địch khác."
  },
  RelicConfig_13784_Desc = {
    Text = "Mỗi khi bắt đầu lượt, nhận được 1 sức tính toán cho mỗi kẻ địch. Khi tiêu diệt kẻ địch bằng sát thương chủ động, gây <BleedingIconKeywords:chảy máu> tương đương với sát thương vượt mức cho các kẻ địch khác."
  },
  RelicConfig_13784_Name = {
    Text = "<OrangeQuality:Bài Ca Quần Chúng>"
  },
  RelicConfig_13784_StoryDesc = {
    Text = "Để hành hạ đôi tai của bạn."
  },
  RelicConfig_13785_BattleDesc = {
    Text = "Cuối lượt <EmbryoFusionIconKeywords:phôi hợp tử> +15, nếu bạn đang giữ thẻ <DerivativeCardKeywords_2:「phôi thai」> trong tay, hồi phục [Arg1] sức sống."
  },
  RelicConfig_13785_Desc = {
    Text = "Cuối lượt <EmbryoFusionIconKeywords:phôi hợp tử> +15, nếu bạn đang giữ thẻ <DerivativeCardKeywords_2:「phôi thai」> trong tay, hồi phục [Arg1] sức sống."
  },
  RelicConfig_13785_Name = {
    Text = "<WhiteQuality:giấy chẩn đoán dịch bệnh>"
  },
  RelicConfig_13785_StoryDesc = {
    Text = "Dịch bệnh —— biểu hiện tình cờ của sự bực bội vô thức của thiên nhiên."
  },
  RelicConfig_13786_BattleDesc = {
    Text = "Sau khi phát động cơn cuồng nộ, nhận được [Arg1] điểm <PowerIconKeywords:lực lượng> tạm thời."
  },
  RelicConfig_13786_Desc = {
    Text = "Sau khi phát động cơn cuồng nộ, nhận được [Arg1] điểm <PowerIconKeywords:lực lượng> tạm thời."
  },
  RelicConfig_13786_Name = {
    Text = "<WhiteQuality:Khóa Nặng>"
  },
  RelicConfig_13786_StoryDesc = {
    Text = "Khóa dày và chắc chắn, nếu không có chìa khóa, chắc hẳn rất khó để mở. \nTất nhiên, điều này đối với một siêu trộm thì không đáng kể."
  },
  RelicConfig_13787_BattleDesc = {
    Text = "Đầu lượt gây [Arg1] điểm <FixedDamage:Sát Thương Thuần Túy> lên một kẻ địch ngẫu nhiên. Sau khi chơi \"Đánh\" 7 lần trong trận chiến này, giá trị sát thương trở thành [Arg2], sau khi chơi \"Đánh\" 21 lần, lập tức gây [Arg3] điểm <FixedDamage:Sát Thương Thuần Túy> lên toàn bộ kẻ địch."
  },
  RelicConfig_13787_Desc = {
    Text = "Đầu lượt gây [Arg1] điểm <FixedDamage:Sát Thương Thuần Túy> lên một kẻ địch ngẫu nhiên. Sau khi chơi \"Đánh\" 7 lần trong trận chiến này, giá trị sát thương trở thành [Arg2], sau khi chơi \"Đánh\" 21 lần, lập tức gây [Arg3] điểm <FixedDamage:Sát Thương Thuần Túy> lên toàn bộ kẻ địch."
  },
  RelicConfig_13787_Name = {
    Text = "<OrangeQuality:mảnh ghép cũ>"
  },
  RelicConfig_13787_StoryDesc = {
    Text = "Tác phẩm nghệ thuật từng được gắn trong khung tranh cồng kềnh, và ngay từ ngày trưng bày đã bị khuyết một phần."
  },
  RelicConfig_13788_BattleDesc = {
    Text = "Giảm giới hạn xúc tu 2 cái. Cuối lượt, làm cho tất cả xúc tu tấn công thêm 1 lần."
  },
  RelicConfig_13788_Desc = {
    Text = "Giảm giới hạn xúc tu 2 cái. Cuối lượt, làm cho tất cả xúc tu tấn công thêm 1 lần."
  },
  RelicConfig_13788_Name = {
    Text = "<RedQuality:Vòng Tay Thánh Khổ Đau>"
  },
  RelicConfig_13788_StoryDesc = {
    Text = "Chịu đựng đau khổ."
  },
  RelicConfig_13789_BattleDesc = {
    Text = "Mỗi lần bộ bài được đặt lại, nhận [Arg1] <PowerIconKeywords:lực lượng>."
  },
  RelicConfig_13789_Desc = {
    Text = "Mỗi lần bộ bài được đặt lại, nhận [Arg1] <PowerIconKeywords:lực lượng>."
  },
  RelicConfig_13789_Name = {
    Text = "<WhiteQuality:Ống điếu Khóc>"
  },
  RelicConfig_13789_StoryDesc = {
    Text = "Đây cuối cùng là kết quả của lòng thù hận, hay hậu quả của sự trả thù?"
  },
  RelicConfig_13790_BattleDesc = {
    Text = "Mỗi lần di chuyển bản đồ sẽ nhận được 10 dấu đen, nhưng áp lực-tinh thần do di chuyển bản đồ sẽ tăng lên 10 điểm."
  },
  RelicConfig_13790_Desc = {
    Text = "Mỗi lần di chuyển bản đồ sẽ nhận được 10 dấu đen, nhưng áp lực-tinh thần do di chuyển bản đồ sẽ tăng lên 10 điểm."
  },
  RelicConfig_13790_Name = {
    Text = "Túi không đáy"
  },
  RelicConfig_13791_BattleDesc = {
    Text = "Khi bạn nhặt sáng tạo này, chọn một thẻ lệnh và thêm một bản sao của nó vào bộ bài."
  },
  RelicConfig_13791_Desc = {
    Text = "Khi bạn nhặt sáng tạo này, chọn một thẻ lệnh và thêm một bản sao của nó vào bộ bài."
  },
  RelicConfig_13791_Name = {
    Text = "<WhiteQuality:ngọn lửa chớp nhoáng>"
  },
  RelicConfig_13791_StoryDesc = {
    Text = "Ánh sáng lung linh, hy vọng yếu ớt."
  },
  RelicConfig_13792_BattleDesc = {
    Text = "Mỗi khi bạn mất sức sống, <EmbryoFusionIconKeywords:phôi hợp tử>+10. Nếu sức sống dưới 50%, hiệu ứng sẽ tăng gấp đôi."
  },
  RelicConfig_13792_Desc = {
    Text = "Mỗi khi bạn mất sức sống, <EmbryoFusionIconKeywords:phôi hợp tử>+10. Nếu sức sống dưới 50%, hiệu ứng sẽ tăng gấp đôi."
  },
  RelicConfig_13792_Name = {
    Text = "<WhiteQuality:cưa thép bị gỉ>"
  },
  RelicConfig_13792_StoryDesc = {
    Text = "Bác sĩ giải phẫu suốt đời không nhìn thấy người phụ nữ đẹp. Họ chỉ có một bao xương, dây thần kinh viêm do bệnh tật, cơ bắp và mô."
  },
  RelicConfig_13793_BattleDesc = {
    Text = "Khi nhặt, tỷ lệ rơi dấu đen của đội tăng lên 150% giá trị gốc. Sau khi hồi phục sinh lực, tất cả thể thức tỉnh nhận được 3 điểm điên cuồng; sau khi mất sinh lực, nhận [Arg1] điểm <PowerIconKeywords:lực lượng> và thương tổn xúc tu, mỗi lượt tối đa có thể kích hoạt 5 lần."
  },
  RelicConfig_13793_Desc = {
    Text = "Khi nhặt, tỷ lệ rơi dấu đen của đội biến thành 150% giá trị gốc. Sau khi hồi phục sinh lực, tất cả thể thức tỉnh nhận được 3 điểm điên cuồng; sau khi mất sinh lực, nhận được [Arg1] điểm <PowerIconKeywords:lực lượng> và thương tổn xúc tu, mỗi lượt tối đa có hiệu lực 5 lần."
  },
  RelicConfig_13793_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「mặt trăng」>"
  },
  RelicConfig_13794_BattleDesc = {
    Text = "Sau khi lượt kết thúc, tất cả thân thể được đánh thức nhận được 5 điên cuồng. Với mỗi điểm sức tính toán còn lại, tất cả thân thể được đánh thức nhận thêm 3 điên cuồng."
  },
  RelicConfig_13794_Desc = {
    Text = "Sau khi lượt kết thúc, tất cả thân thể được đánh thức nhận được 5 điên cuồng. Với mỗi điểm sức tính toán còn lại, tất cả thân thể được đánh thức nhận thêm 3 điên cuồng."
  },
  RelicConfig_13794_Name = {
    Text = "<OrangeQuality:pin nguyên mẫu>"
  },
  RelicConfig_13794_StoryDesc = {
    Text = "Hy vọng bỏ túi."
  },
  RelicConfig_13795_BattleDesc = {
    Text = "Sức tính toán tối đa tăng 1."
  },
  RelicConfig_13795_Desc = {
    Text = "Sức tính toán tối đa tăng 1."
  },
  RelicConfig_13795_Name = {
    Text = "<WhiteQuality:bơm tiêm hoạt tính>"
  },
  RelicConfig_13795_StoryDesc = {
    Text = "Co giật cũng là một dạng năng lượng."
  },
  RelicConfig_13796_BattleDesc = {
    Text = "Khi kết thúc trận chiến, nếu sức sống còn lại dưới 50%, sẽ nâng cấp thành một vật phẩm bạc"
  },
  RelicConfig_13796_Desc = {
    Text = "Khi kết thúc trận chiến, nếu sức sống còn lại dưới 50%, sẽ nâng cấp thành một vật phẩm bạc."
  },
  RelicConfig_13796_Name = {
    Text = "Sổ tay cũ kỹ 2"
  },
  RelicConfig_13796_StoryDesc = {
    Text = "Một cuốn sổ nhật ký cũ, bên trong chứa đầy các trang thêm, thoạt nhìn ít nhất có bản đồ Elworth, ghi chép thí nghiệm, và những tờ giấy có dấu ăn mòn hình tam giác. \nNội dung ở phần đầu của ghi chú có chữ viết ngay ngắn, nhưng sau đó dần dần trở nên lộn xộn."
  },
  RelicConfig_13797_BattleDesc = {
    Text = "Sau khi chơi 3 thẻ Đánh, nâng cấp thành một vật tạo vàng"
  },
  RelicConfig_13797_Desc = {
    Text = "Sau khi chơi 3 thẻ Đánh, nâng cấp thành một vật tạo vàng."
  },
  RelicConfig_13797_Name = {
    Text = "Sổ tay cũ 1"
  },
  RelicConfig_13797_StoryDesc = {
    Text = "Một cuốn sổ nhật ký cũ, bên trong nhét đầy các tờ giấy thêm, nhìn qua ít nhất chứa bản đồ Elworth, ghi chép thí nghiệm, và những bức thư đầy dấu ăn mòn hình tam giác. \n Nội dung phần đầu của ghi chú chữ viết rõ ràng ngay ngắn, nhưng sau đó dần trở nên lộn xộn."
  },
  RelicConfig_13798_BattleDesc = {
    Text = "Khi trận chiến bắt đầu, tất cả các thẻ triệu chứng của bạn nhận được <NothingnessIconKeywords:hư vô>, và cho mỗi thẻ triệu chứng trong bộ bài triệu chứng của bạn, bạn sẽ nhận được [Arg1] <PowerIconKeywords:lực lượng>."
  },
  RelicConfig_13798_Desc = {
    Text = "Khi trận chiến bắt đầu, tất cả các thẻ triệu chứng của bạn nhận được <NothingnessIconKeywords:hư vô>, và cho mỗi thẻ triệu chứng trong bộ bài triệu chứng của bạn, bạn sẽ nhận được [Arg1] <PowerIconKeywords:lực lượng>."
  },
  RelicConfig_13798_Name = {
    Text = "<WhiteQuality:linh dược Hà Phúc>"
  },
  RelicConfig_13798_StoryDesc = {
    Text = "Thuốc có thành phần không rõ. \nNgười ta nói rằng nghệ sĩ violin nổi tiếng Eric rất ưa chuộng."
  },
  RelicConfig_13799_BattleDesc = {
    Text = "Vào đầu lượt chiến đấu đầu tiên, thêm <DerivativeCardKeywords_1:「dư ảnh hồi hưởng」> vào tay; lượt thứ 2 thêm <DerivativeCardKeywords_41:「chìa khóa bạc cảm ứng」> vào tay; lượt thứ 3 thêm <DerivativeCardKeywords_39:「quá khứ hồi thanh」> vào tay."
  },
  RelicConfig_13799_Desc = {
    Text = "Vào đầu lượt chiến đấu đầu tiên, thêm <DerivativeCardKeywords_1:「dư ảnh hồi hưởng」> vào tay; lượt thứ 2 thêm <DerivativeCardKeywords_41:「chìa khóa bạc cảm ứng」> vào tay; lượt thứ 3 thêm <DerivativeCardKeywords_39:「quá khứ hồi thanh」> vào tay."
  },
  RelicConfig_13799_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「Quần Tinh」>"
  },
  RelicConfig_13800_BattleDesc = {
    Text = "Vào đầu lượt, thêm 1 lá <DerivativeCardKeywords_6:「dù」> vào tay, sau khi đánh 6 thẻ bài, tăng [Arg2] cho tất cả các lá <DerivativeCardKeywords_6:「dù」><AlertIconKeywords:giữ mình> trong tay."
  },
  RelicConfig_13800_Desc = {
    Text = "Vào đầu lượt, thêm 1 lá <DerivativeCardKeywords_6:「dù」> vào tay, sau khi đánh 6 thẻ bài, tăng [Arg2] cho tất cả các lá <DerivativeCardKeywords_6:「dù」><AlertIconKeywords:giữ mình> trong tay."
  },
  RelicConfig_13800_Name = {
    Text = "<WhiteQuality:ô dù du hành>"
  },
  RelicConfig_13800_StoryDesc = {
    Text = "Phát triển rực rỡ trong vùng đất không ánh sáng."
  },
  RelicConfig_13801_BattleDesc = {
    Text = "Trong chiến đấu thông thường, sức sống của tất cả kẻ địch tăng 30%, khi giành chiến thắng sẽ nhận thêm 25 dấu đen."
  },
  RelicConfig_13801_Desc = {
    Text = "Trong chiến đấu thông thường, sức sống của tất cả kẻ địch tăng 30%, khi giành chiến thắng sẽ nhận thêm 25 dấu đen."
  },
  RelicConfig_13801_Name = {
    Text = "Cờ chiến đấu bị hư hại"
  },
  RelicConfig_13802_BattleDesc = {
    Text = "Khi nhặt, tăng máu tối đa [Arg1] điểm. Nếu máu dưới 25% khi nhặt, tăng máu tối đa sẽ trở thành [Arg2] điểm."
  },
  RelicConfig_13802_Desc = {
    Text = "Khi nhặt, tăng máu tối đa [Arg1] điểm. Nếu máu dưới 25% khi nhặt, tăng máu tối đa sẽ trở thành [Arg2] điểm."
  },
  RelicConfig_13802_Name = {
    Text = "<WhiteQuality:trà đen Ceylon>"
  },
  RelicConfig_13802_StoryDesc = {
    Text = "Chế độ ăn uống lành mạnh, cần sự chung tay của mỗi người."
  },
  RelicConfig_13803_BattleDesc = {
    Text = "Mỗi 3 lượt nhận được 3 râu chạm nhất thời."
  },
  RelicConfig_13803_Desc = {
    Text = "Mỗi 3 lượt nhận được 3 râu chạm nhất thời."
  },
  RelicConfig_13803_Name = {
    Text = "<WhiteQuality:mũ lặn>"
  },
  RelicConfig_13803_StoryDesc = {
    Text = "Giấc mơ là sao trời và đại dương!"
  },
  RelicConfig_13804_BattleDesc = {
    Text = "Kết thúc lượt, nhận [Arg1] điểm lá chắn. Nếu lá chắn của bạn là 0 hoặc bội số của 3, nhận [Arg2] điểm <PowerIconKeywords:sức mạnh>."
  },
  RelicConfig_13804_Desc = {
    Text = "Kết thúc lượt, nhận [Arg1] điểm lá chắn. Nếu lá chắn của bạn là 0 hoặc bội số của 3, nhận [Arg2] điểm <PowerIconKeywords:sức mạnh>."
  },
  RelicConfig_13804_Name = {
    Text = "<OrangeQuality:tín hiệu cầu cứu>"
  },
  RelicConfig_13804_StoryDesc = {
    Text = "Anh ta không thể đợi đến khi có sự cứu hộ."
  },
  RelicConfig_13806_BattleDesc = {
    Text = "Khi rút được thẻ triệu chứng, nhận [Arg1] điểm <PowerIconKeywords:lực lượng> tạm thời. Cứ mỗi vật bị nguyền rủa mà bạn sở hữu, tỷ lệ chí mạng và sát thương chí mạng sẽ tăng thêm 10%."
  },
  RelicConfig_13806_Desc = {
    Text = "Khi rút được thẻ triệu chứng, nhận [Arg1] điểm <PowerIconKeywords:lực lượng> tạm thời. Cứ mỗi vật bị nguyền rủa mà bạn sở hữu, tỷ lệ chí mạng và sát thương chí mạng sẽ tăng thêm 10%."
  },
  RelicConfig_13806_Name = {
    Text = "<OrangeQuality:hố sâu liên lạc>"
  },
  RelicConfig_13806_StoryDesc = {
    Text = "Vùng ngoại ô hoang vắng, chuông điện thoại trong cabin cô đơn vang lên. \n \"Tối... xì... vô biên... xì xì... bóng tối...\""
  },
  RelicConfig_13807_BattleDesc = {
    Text = "Khi trận chiến bắt đầu <EmbryoFusionIconKeywords:phôi hợp tử> +50. Mỗi thân thể được đánh thức có ít nhất 50 điểm điên cuồng sẽ kích hoạt thêm 1 lần"
  },
  RelicConfig_13807_Desc = {
    Text = "Khi trận chiến bắt đầu <EmbryoFusionIconKeywords:phôi hợp tử> +50. Mỗi thân thể được đánh thức có ít nhất 50 điểm điên cuồng sẽ kích hoạt thêm 1 lần."
  },
  RelicConfig_13807_Name = {
    Text = "<WhiteQuality:đứa bé yêu dấu>"
  },
  RelicConfig_13807_StoryDesc = {
    Text = "Thợ mộc đã làm một con rối giống như thật cho vợ mình, nó sẽ thay thế con trai của họ, nằm yên trong bụng mẹ."
  },
  RelicConfig_13808_BattleDesc = {
    Text = "Sau khi bùng nổ cơn thịnh nộ, một thẻ bài ngẫu nhiên tương ứng với thân thể được đánh thức sẽ được đặt vào tay, thẻ này mang thuộc tính <DepleteIconKeywords:tiêu thụ> và <NothingnessIconKeywords:hư vô>. Sau khi trận đấu kết thúc, hồi phục [Arg1] điểm sinh lực."
  },
  RelicConfig_13808_Desc = {
    Text = "Sau khi phóng thích cơn thịnh nộ bùng phát, một thẻ bài ngẫu nhiên tương ứng với thân thể được đánh thức sẽ được đặt vào tay, thẻ này mang thuộc tính <DepleteIconKeywords:tiêu thụ> và <NothingnessIconKeywords:hư vô>. Sau khi kết thúc trận đấu, hồi phục [Arg1] điểm sinh lực."
  },
  RelicConfig_13808_Name = {
    Text = "<WhiteQuality:vali của bác sĩ>"
  },
  RelicConfig_13808_StoryDesc = {
    Text = "Hộp vali tượng trưng cho thân phận bác sĩ, rất nặng.\nMở nó ra, chưa chắc đã phải là bác sĩ thật sự."
  },
  RelicConfig_13809_BattleDesc = {
    Text = "Giá của tất cả vật phẩm giảm 20%."
  },
  RelicConfig_13809_Desc = {
    Text = "Giá của tất cả vật phẩm giảm 20%."
  },
  RelicConfig_13809_Name = {
    Text = "<WhiteQuality:lời lẽ sắc bén>"
  },
  RelicConfig_13809_StoryDesc = {
    Text = "Không chỉ thương nhân, mà còn có những tín đồ mộ đạo khéo léo trong giao tiếp và tài ăn nói."
  },
  RelicConfig_13811_BattleDesc = {
    Text = "Sau mỗi lần chơi \"Đánh\" thứ 3, gây [Arg1] điểm <FixedDamage:Sát Thương Thuần Túy> lên toàn bộ kẻ địch, Thể thức tỉnh tương ứng nhận được 15 điên cuồng."
  },
  RelicConfig_13811_Desc = {
    Text = "Sau mỗi lần chơi \"Đánh\" thứ 3, gây [Arg1] điểm <FixedDamage:Sát Thương Thuần Túy> lên toàn bộ kẻ địch, Thể thức tỉnh tương ứng nhận được 15 điên cuồng."
  },
  RelicConfig_13811_Name = {
    Text = "<WhiteQuality:dao lá liễu rỉ sét>"
  },
  RelicConfig_13811_StoryDesc = {
    Text = "Không thích hợp để cắt vào cơ thể sống."
  },
  RelicConfig_13812_BattleDesc = {
    Text = "Khi nhặt được, tăng máu tối đa 100%, đầu mỗi lượt, mất [Arg1] điểm sức sống."
  },
  RelicConfig_13812_Desc = {
    Text = "Khi nhặt được, tăng máu tối đa 100%, đầu mỗi lượt, mất [Arg1] điểm sức sống."
  },
  RelicConfig_13812_Name = {
    Text = "<RedQuality:☆thịt máu bất tử☆>"
  },
  RelicConfig_13812_StoryDesc = {
    Text = "\"Động vật biển quen với việc cắt cụt để sống sót.\""
  },
  RelicConfig_13813_BattleDesc = {
    Text = "Sau khi chiến đấu bắt đầu, sức sống hiện tại của kẻ địch tinh anh và thủ lĩnh giảm 20%."
  },
  RelicConfig_13813_Desc = {
    Text = "Sau khi chiến đấu bắt đầu, sức sống hiện tại của kẻ địch tinh anh và thủ lĩnh giảm 20%."
  },
  RelicConfig_13813_Name = {
    Text = "<WhiteQuality:☆neo tàu cũ☆>"
  },
  RelicConfig_13813_StoryDesc = {
    Text = "Hãy về nhà đi, bạn thủy thủ già."
  },
  RelicConfig_13814_BattleDesc = {
    Text = "Vào cuối lượt, mỗi thẻ bài chưa sử dụng sẽ khiến tất cả các thân thể được đánh thức nhận được 2 điên cuồng."
  },
  RelicConfig_13814_Desc = {
    Text = "Vào cuối lượt, mỗi thẻ bài chưa sử dụng sẽ khiến tất cả các thân thể được đánh thức nhận được 2 điên cuồng."
  },
  RelicConfig_13814_Name = {
    Text = "<WhiteQuality:Cân Bằng Mất Thăng Bằng>"
  },
  RelicConfig_13814_StoryDesc = {
    Text = "Không còn tượng trưng cho công bằng."
  },
  RelicConfig_13815_BattleDesc = {
    Text = "Nhặt lên và chọn một thẻ bài, giảm tiêu thụ sức tính toán của nó xuống còn 1 vĩnh viễn."
  },
  RelicConfig_13815_Desc = {
    Text = "Nhặt lên và chọn một thẻ bài, giảm tiêu thụ sức tính toán của nó xuống còn 1 vĩnh viễn."
  },
  RelicConfig_13815_Name = {
    Text = "<WhiteQuality:☆tinh chế nghĩa nhãn☆>"
  },
  RelicConfig_13815_StoryDesc = {
    Text = "Một con mắt không còn tinh khiết."
  },
  RelicConfig_13816_BattleDesc = {
    Text = "Khi trận chiến bắt đầu, tất cả kẻ thù nhận được [Arg1] điểm <RetaliateIconKeywords:phản công>. Mỗi khi gây thương, thân thể được đánh thức có mức điên cuồng thấp nhất nhận được 6 điểm điên cuồng."
  },
  RelicConfig_13816_Desc = {
    Text = "Khi trận chiến bắt đầu, tất cả kẻ thù nhận được [Arg1] điểm <RetaliateIconKeywords:phản công>. Mỗi khi gây thương, thân thể được đánh thức có mức điên cuồng thấp nhất nhận được 6 điểm điên cuồng."
  },
  RelicConfig_13816_Name = {
    Text = "<RedQuality:☆Chuông Than Khóc☆>"
  },
  RelicConfig_13816_StoryDesc = {
    Text = "Đinh leng, đinh leng, đứa trẻ đang khóc; \nđinh leng, đinh leng, đứa trẻ đang hét lên; \nđinh leng, đinh leng, đứa trẻ đang than khóc; \nđinh leng, đinh leng, nó đói rồi, bạn biết mà."
  },
  RelicConfig_13817_BattleDesc = {
    Text = "Sau mỗi 6 lá thẻ lệnh, <TentacleInjurieIconKeywords:thương tổn râu chạm> +[Arg1]."
  },
  RelicConfig_13817_Desc = {
    Text = "Sau mỗi 6 lá thẻ lệnh, <TentacleInjurieIconKeywords:thương tổn râu chạm> +[Arg1]."
  },
  RelicConfig_13817_Name = {
    Text = "<WhiteQuality:giun đũa>"
  },
  RelicConfig_13817_StoryDesc = {
    Text = "Chừng nào não bộ của chúng ta vẫn còn là một bí ẩn, thì việc nó chứa đầy râu tua cũng không có gì đáng ngạc nhiên."
  },
  RelicConfig_13818_BattleDesc = {
    Text = "Tỷ lệ chí mạng tăng 50%, nhưng khi bắt đầu trận chiến <FragileIconKeywords:yếu đuối> tự thân 3 lượt."
  },
  RelicConfig_13818_Desc = {
    Text = "Tỷ lệ chí mạng tăng 50%, nhưng khi bắt đầu trận chiến <FragileIconKeywords:yếu đuối> tự thân 3 lượt."
  },
  RelicConfig_13818_Name = {
    Text = "<RedQuality:thanh câu kỳ quái>"
  },
  RelicConfig_13818_StoryDesc = {
    Text = "Loài khó nhận diện."
  },
  RelicConfig_13819_BattleDesc = {
    Text = "Khi đánh 1 thẻ bài có tiêu thụ sức tính toán là 3 hoặc cao hơn, rút 1 thẻ bài, nhận 1 điểm sức tính toán."
  },
  RelicConfig_13819_Desc = {
    Text = "Khi đánh 1 thẻ bài có tiêu thụ sức tính toán là 3 hoặc cao hơn, rút 1 thẻ bài, nhận 1 điểm sức tính toán."
  },
  RelicConfig_13819_Name = {
    Text = "<OrangeQuality:☆vẻ đẹp hoài niệm☆>"
  },
  RelicConfig_13819_StoryDesc = {
    Text = "Không còn ai nữa nhớ đến vẻ đẹp của cô ấy."
  },
  RelicConfig_13820_BattleDesc = {
    Text = "Mỗi khi nhận thẻ triệu chứng, tăng máu tối đa [Arg1] điểm."
  },
  RelicConfig_13820_Desc = {
    Text = "Mỗi khi nhận thẻ triệu chứng, tăng máu tối đa [Arg1] điểm."
  },
  RelicConfig_13820_Name = {
    Text = "<WhiteQuality:☆nhũ hương dung dịch☆>"
  },
  RelicConfig_13820_StoryDesc = {
    Text = "\"mùi hương ngọt ngào quyến rũ.\""
  },
  RelicConfig_13821_BattleDesc = {
    Text = "Sau khi cơn thịnh nộ bùng phát, rút 1 lá bài.Nếu sức sống dưới 25%,rút thêm 1 lá bài."
  },
  RelicConfig_13821_Desc = {
    Text = "Sau khi cơn thịnh nộ bùng phát, rút 1 lá bài.Nếu sức sống dưới 25%,rút thêm 1 lá bài."
  },
  RelicConfig_13821_Name = {
    Text = "<OrangeQuality:bánh xe tri thức>"
  },
  RelicConfig_13821_StoryDesc = {
    Text = "Lưu ý an toàn khi đọc sách nhé"
  },
  RelicConfig_13822_BattleDesc = {
    Text = "Mỗi lượt gây sát thương chủ động, tăng [Arg1] điểm <TentacleInjurieIconKeywords:thương tổn râu chạm> tạm thời, tối đa 3 lần. Khi số lớp đầy, tạo ra 1 râu chạm tạm thời, vượt giới hạn số lượng."
  },
  RelicConfig_13822_Desc = {
    Text = "Mỗi lượt gây sát thương chủ động, tăng [Arg1] điểm <TentacleInjurieIconKeywords:thương tổn râu chạm> tạm thời, tối đa 3 lần. Khi đạt đủ lớp, tạo ra 1 râu chạm tạm thời không giới hạn."
  },
  RelicConfig_13822_Name = {
    Text = "<OrangeQuality:niềm vui của Luo Yan>"
  },
  RelicConfig_13822_StoryDesc = {
    Text = "Bậc chủ tể giấc ngủ sâu, chờ ngươi vào mộng."
  },
  RelicConfig_13823_BattleDesc = {
    Text = "Bạn mỗi lần đánh ra thẻ lệnh thứ [Arg1] sẽ có hiệu lực 2 lần, sau khi đánh sẽ trở lại trong tay."
  },
  RelicConfig_13823_Desc = {
    Text = "Bạn mỗi lần đánh ra thẻ lệnh thứ [Arg1] sẽ có hiệu lực 2 lần, sau khi đánh sẽ trở lại trong tay."
  },
  RelicConfig_13823_Name = {
    Text = "<OrangeQuality:rượu của các vì sao+>"
  },
  RelicConfig_13823_StoryDesc = {
    Text = "Di chuyển giữa các ngôi sao."
  },
  RelicConfig_13824_BattleDesc = {
    Text = "Mỗi khi bắt đầu lượt, <DeathResistanceIconKeywords:kháng cự tử vong> tăng 10% (mỗi lần kích hoạt kháng cự tử vong trong cấp độ này, kháng cự tử vong nhận được sẽ giảm một nửa). Khi <DeathResistanceIconKeywords:kháng cự tử vong> vượt quá 100%, <ProficientInRealmsIconKeywords:Sự thông thạo giới vực> tăng 100."
  },
  RelicConfig_13824_Desc = {
    Text = "Mỗi khi bắt đầu lượt, <DeathResistanceIconKeywords:kháng cự tử vong> tăng 10% (mỗi lần kích hoạt kháng cự tử vong trong màn chơi này sẽ nhận được kháng cự tử vong giảm một nửa). Khi <DeathResistanceIconKeywords:kháng cự tử vong> vượt quá 100%, <ProficientInRealmsIconKeywords:Sự thông thạo giới vực> tăng 100."
  },
  RelicConfig_13824_Name = {
    Text = "<WhiteQuality:nước mắt người cá>"
  },
  RelicConfig_13824_StoryDesc = {
    Text = "Không để nó vào nước."
  },
  RelicConfig_13825_BattleDesc = {
    Text = "Mỗi khi tiêu thụ 10 dấu đen, phục hồi [Arg1] điểm sức sống."
  },
  RelicConfig_13825_Desc = {
    Text = "Mỗi khi tiêu thụ 10 dấu đen, phục hồi 1% sức sống."
  },
  RelicConfig_13825_Name = {
    Text = "Căn nghịch sinh"
  },
  RelicConfig_13826_BattleDesc = {
    Text = "Mỗi khi bạn sử dụng một \"Thẻ tăng ích\"/ \"Thẻ triệu chứng\"/\"Thẻ trạng thái\", thân thể được đánh thức có lượng điên cuồng thấp nhất sẽ nhận thêm 10 điểm điên cuồng."
  },
  RelicConfig_13826_Desc = {
    Text = "Mỗi khi bạn sử dụng một \"Thẻ tăng ích\"/ \"Thẻ triệu chứng\"/\"Thẻ trạng thái\", thân thể được đánh thức có lượng điên cuồng thấp nhất sẽ nhận thêm 10 điểm điên cuồng."
  },
  RelicConfig_13826_Name = {
    Text = "<WhiteQuality:bộ sưu tập tem thư từ xứ lạ>"
  },
  RelicConfig_13826_StoryDesc = {
    Text = "Niềm nhớ được định lượng."
  },
  RelicConfig_13827_BattleDesc = {
    Text = "Nhặt được 75 dấu đen. Chọn 1 sáng tạo và chuyển đổi thành 1 vật bị nguyền rủa ngẫu nhiên."
  },
  RelicConfig_13827_Desc = {
    Text = "Nhặt được 75 dấu đen. Chọn 1 sáng tạo và chuyển đổi thành 1 vật bị nguyền rủa ngẫu nhiên."
  },
  RelicConfig_13827_Name = {
    Text = "<RedQuality:đá bia nguyền rủa>"
  },
  RelicConfig_13827_StoryDesc = {
    Text = "Khi vuốt ve, tôi nghe thấy tiếng gọi từ biển sâu."
  },
  RelicConfig_13828_BattleDesc = {
    Text = "Mỗi lượt, khi lần đầu tiên đánh thẻ lệnh vào rác bài, giảm tạm thời tiêu thụ sức tính toán của thẻ đó đi 1 và thêm một bản sao tạm thời của thẻ này vào rút bài từ bộ bài."
  },
  RelicConfig_13828_Desc = {
    Text = "Mỗi lượt, khi lần đầu tiên đánh thẻ lệnh vào rác bài, giảm tạm thời tiêu thụ sức tính toán của thẻ đó đi 1 và thêm một bản sao tạm thời của thẻ này vào rút bài từ bộ bài."
  },
  RelicConfig_13828_Name = {
    Text = "<WhiteQuality:máy hát câm>"
  },
  RelicConfig_13828_StoryDesc = {
    Text = "Giọng của anh ấy biến mất trong gió."
  },
  RelicConfig_13829_BattleDesc = {
    Text = "Một chuỗi chìa khóa rỉ sét. Có thể sử dụng để mở khóa cửa."
  },
  RelicConfig_13829_Desc = {
    Text = "Một chuỗi chìa khóa rỉ sét. Có thể sử dụng để mở khóa cửa."
  },
  RelicConfig_13829_Name = {
    Text = "chìa khóa rỉ sét"
  },
  RelicConfig_13830_BattleDesc = {
    Text = "Gây hồi sức sống, cũng sẽ nhận được [Arg1] điểm lá chắn. Kể từ đầu lượt thứ 3, nhận được [Arg2] điểm<AlertIconKeywords:giữ mình>."
  },
  RelicConfig_13830_Desc = {
    Text = "Gây hồi sức sống, cũng sẽ nhận được [Arg1] điểm lá chắn. Kể từ đầu lượt thứ 3, nhận được [Arg2] điểm<AlertIconKeywords:giữ mình>."
  },
  RelicConfig_13830_Name = {
    Text = "<WhiteQuality:bướm tiêu bản>"
  },
  RelicConfig_13830_StoryDesc = {
    Text = "Đến nay, anh ấy vẫn được ai đó thương mến rất nhiều."
  },
  RelicConfig_13831_BattleDesc = {
    Text = "Mỗi khi một thẻ lệnh đi vào <DimensionalSpaceIconKeywords:siêu việt không gian>, thân thể được đánh thức tương ứng sẽ nhận được 15 điểm điên cuồng."
  },
  RelicConfig_13831_Desc = {
    Text = "Mỗi khi một thẻ lệnh đi vào <DimensionalSpaceIconKeywords:siêu việt không gian>, thân thể được đánh thức tương ứng sẽ nhận được 15 điểm điên cuồng."
  },
  RelicConfig_13831_Name = {
    Text = "<WhiteQuality:sâu thời gian>"
  },
  RelicConfig_13831_StoryDesc = {
    Text = "Một chiếc đồng hồ bỏ túi tồn tại đồng thời trong cửa hàng đồng hồ và bảo tàng côn trùng. \n Sau khi kỷ nguyên Hồng Tích bắt đầu, nó được đưa vào bộ sưu tập của trường đại học."
  },
  RelicConfig_13832_BattleDesc = {
    Text = "Sau khi vào lượt siêu việt, giải trừ trạng thái <WeaknessIconKeywords:yếu đuối> và <FragileIconKeywords:mong manh> cho bản thân, đồng thời <WeaknessIconKeywords:yếu đuối> và <VulnerabilityIconKeywords:dễ bị tổn thương> tất cả kẻ địch trong 3 lượt, sát thương cuối cùng của tất cả thể thức tỉnh trong lượt này tăng 15%."
  },
  RelicConfig_13832_Desc = {
    Text = "Sau khi vào lượt siêu việt, giải trừ trạng thái <WeaknessIconKeywords:suy nhược> và <FragileIconKeywords:mong manh> cho bản thân, đồng thời <WeaknessIconKeywords:suy nhược> và <VulnerabilityIconKeywords:dễ bị tổn thương> tất cả kẻ địch trong 3 lượt, sát thương cuối cùng của tất cả thể thức tỉnh trong lượt này tăng 15%."
  },
  RelicConfig_13832_Name = {
    Text = "<WhiteQuality:Đồng hồ siêu huyền>"
  },
  RelicConfig_13832_StoryDesc = {
    Text = "\"Ái chà, đồng hồ bỏ túi đã dừng rồi.\""
  },
  RelicConfig_13833_BattleDesc = {
    Text = "Mỗi lần gây 1 sát thương, sẽ áp dụng [Arg1] lớp <IntoxicationIconKeywords:trúng độc> lên mục tiêu. Nếu tổng số lần kích hoạt trong trận chiến đạt 25 lần, ngay lập tức áp dụng <IntoxicationIconKeywords:trúng độc> cho tất cả kẻ địch."
  },
  RelicConfig_13833_Desc = {
    Text = "Mỗi lần gây 1 sát thương, sẽ áp dụng [Arg1] lớp <IntoxicationIconKeywords:trúng độc> lên mục tiêu. Nếu tổng số lần kích hoạt trong trận chiến đạt 25 lần, ngay lập tức áp dụng <IntoxicationIconKeywords:trúng độc> cho tất cả kẻ địch."
  },
  RelicConfig_13833_Name = {
    Text = "<OrangeQuality:☆máy may bám bụi☆>"
  },
  RelicConfig_13833_StoryDesc = {
    Text = "Một người mẹ hiền từ, hàn gắn những vết thương trong trái tim."
  },
  RelicConfig_13834_BattleDesc = {
    Text = "Mỗi lần thứ 5 nhận được lá chắn, đồng thời nhận được <RetaliateIconKeywords:phản công>, sức mạnh phản công bằng [Arg1]% của lá chắn nhận được."
  },
  RelicConfig_13834_Desc = {
    Text = "Mỗi lần thứ 5 nhận được lá chắn, đồng thời nhận được <RetaliateIconKeywords:phản công>, sức mạnh phản công bằng [Arg1]% của lá chắn nhận được."
  },
  RelicConfig_13834_Name = {
    Text = "<OrangeQuality:Chương Tiên Tri>"
  },
  RelicConfig_13834_StoryDesc = {
    Text = "\"Con người thật ngu ngốc, chỉ vì sự cũ kỹ mà mù quáng tin theo.\""
  },
  RelicConfig_13835_BattleDesc = {
    Text = "Vào đầu lượt, rút 1 lá bài."
  },
  RelicConfig_13835_Desc = {
    Text = "Vào đầu lượt, rút 1 lá bài."
  },
  RelicConfig_13835_Name = {
    Text = "<WhiteQuality:la bàn định hướng>"
  },
  RelicConfig_13835_StoryDesc = {
    Text = "Điều được chỉ ra không phải là hướng, mà chỉ là từ trường."
  },
  RelicConfig_13836_BattleDesc = {
    Text = "Khi trận chiến bắt đầu, ngẫu nhiên đặt <DerivativeCardKeywords_3:「co thắt tâm trí」> và <DerivativeCardKeywords_4:「cảm hứng」> vào <DimensionalSpaceIconKeywords:không gian siêu việt> cho đến khi đạt giới hạn. Sau khi vào lượt không gian siêu việt, nhận được [Arg1] điểm <PowerIconKeywords:lực lượng>."
  },
  RelicConfig_13836_Desc = {
    Text = "Khi trận chiến bắt đầu, ngẫu nhiên đặt <DerivativeCardKeywords_3:「co thắt tâm trí」> và <DerivativeCardKeywords_4:「cảm hứng」> vào <DimensionalSpaceIconKeywords:không gian siêu việt> cho đến khi đạt giới hạn. Sau khi vào lượt không gian siêu việt, nhận được [Arg1] điểm <PowerIconKeywords:lực lượng>."
  },
  RelicConfig_13836_Name = {
    Text = "<RedQuality:Dụng cụ của Alfonso>"
  },
  RelicConfig_13836_StoryDesc = {
    Text = "Khác với số phận vô thường, các vì sao có quy luật vận hành riêng."
  },
  RelicConfig_13837_BattleDesc = {
    Text = "Nhặt được sẽ có 100% <DeathResistanceIconKeywords:kháng cự tử vong> (mỗi lần kích hoạt kháng cự tử vong trong màn chơi này, lượng kháng cự tử vong nhận được sẽ giảm một nửa). Sau khi kích hoạt <DeathResistanceIconKeywords:kháng cự tử vong>, mỗi đầu vòng trong trận chiến sẽ hồi [Arg1] điểm sinh lực."
  },
  RelicConfig_13837_Desc = {
    Text = "Nhặt được sẽ có 100% <DeathResistanceIconKeywords:kháng cự tử vong> (mỗi lần kích hoạt kháng cự tử vong trong màn này sẽ giảm một nửa kháng cự tử vong nhận được). Sau khi kích hoạt <DeathResistanceIconKeywords:kháng cự tử vong>, mỗi đầu vòng trong trận chiến sẽ hồi [Arg1] điểm sinh lực."
  },
  RelicConfig_13837_Name = {
    Text = "<WhiteQuality:hô hấp nhân tạo>"
  },
  RelicConfig_13837_StoryDesc = {
    Text = "Đồ tốt cần thiết cho người khám phá. Nếu lạm dụng nó quá mức, nó sẽ trở thành một phần của bạn."
  },
  RelicConfig_13838_BattleDesc = {
    Text = "Đây là một Tạo Vật Nhiệm Vụ không mang lại hiệu ứng 2"
  },
  RelicConfig_13838_Desc = {
    Text = "Đây là một Tạo Vật Nhiệm Vụ không mang lại hiệu ứng 2"
  },
  RelicConfig_13838_Name = {
    Text = "Nhiệm vụ tạo vật thử nghiệm 2"
  },
  RelicConfig_13838_StoryDesc = {
    Text = "Cần bổ sung sáng tạo"
  },
  RelicConfig_13839_BattleDesc = {
    Text = "Khi đánh lá bài cuối cùng trong tay, rút 2 lá bài. Mỗi vòng tối đa 2 lần."
  },
  RelicConfig_13839_Desc = {
    Text = "Khi đánh lá bài cuối cùng trong tay, rút 2 lá bài. Mỗi vòng tối đa 2 lần."
  },
  RelicConfig_13839_Name = {
    Text = "<WhiteQuality:☆găng tay ảo thuật☆>"
  },
  RelicConfig_13839_StoryDesc = {
    Text = "\"Đừng sợ hãi, đây chỉ là ảo thuật!\""
  },
  RelicConfig_13840_BattleDesc = {
    Text = "Mỗi 3 lượt, thêm 1 lớp <WeaknessIconKeywords:yếu đuối> cho tất cả kẻ địch. Sau khi gây thương cho kẻ địch có <WeaknessIconKeywords:yếu đuối>, nhận [Arg1] điểm <PowerIconKeywords:lực lượng> tạm thời, tối đa 3 lần mỗi lượt."
  },
  RelicConfig_13840_Desc = {
    Text = "Mỗi 3 lượt, thêm 1 lớp <WeaknessIconKeywords:yếu đuối> cho tất cả kẻ địch. Sau khi gây thương cho kẻ địch có <WeaknessIconKeywords:yếu đuối>, nhận [Arg1] điểm <PowerIconKeywords:lực lượng> tạm thời, tối đa 3 lần mỗi lượt."
  },
  RelicConfig_13840_Name = {
    Text = "<WhiteQuality:quỷ sứ nhỏ>"
  },
  RelicConfig_13840_StoryDesc = {
    Text = "Bắt nguồn từ cái ác thuần túy, dù điều đó không phải là ý nguyện của nó."
  },
  RelicConfig_13841_BattleDesc = {
    Text = "Tất cả 「tấn công」 gây ra tăng 20% thương harming chí mạng. Khi chiến đấu bắt đầu, thêm 1 lá <DerivativeCardKeywords_40:「Khoảnh khắc đẹp」> vào tay."
  },
  RelicConfig_13841_Desc = {
    Text = "Tất cả 「tấn công」 gây ra tăng 20% thương harming chí mạng. Khi chiến đấu bắt đầu, thêm 1 lá <DerivativeCardKeywords_40:「Khoảnh khắc đẹp」> vào tay."
  },
  RelicConfig_13841_Name = {
    Text = "<WhiteQuality:khoảnh khắc đẹp>"
  },
  RelicConfig_13841_StoryDesc = {
    Text = "Lưu giữ vẻ đẹp của phút chốc mãi mãi."
  },
  RelicConfig_13842_BattleDesc = {
    Text = "Chống lại một lần thương tổn chí mạng không kích hoạt kháng cự tử vong, hồi phục [Arg1] sức sống và khiến vật phẩm này vĩnh viễn mất hiệu lực."
  },
  RelicConfig_13842_Desc = {
    Text = "Chống lại một lần thương tổn chí mạng không kích hoạt kháng cự tử vong, hồi phục [Arg1] sức sống và khiến vật phẩm này vĩnh viễn mất hiệu lực."
  },
  RelicConfig_13842_Name = {
    Text = "<OrangeQuality:bùa thế thân>"
  },
  RelicConfig_13842_StoryDesc = {
    Text = "Hì hì, hì hì. Là bạn nợ tôi đấy nhé?"
  },
  RelicConfig_13844_BattleDesc = {
    Text = "Khi bạn gây <WeaknessIconKeywords:suy nhược>, nhận được [Arg1] điểm lá chắn; khi gây <VulnerabilityIconKeywords:trọng thương>, nhận được [Arg2] điểm tạm thời <PowerIconKeywords:lực lượng>. Nếu cả hai hiệu ứng này được kích hoạt trong 1 lượt, bạn sẽ nhận thêm [Arg1] điểm lá chắn và [Arg2] điểm tạm thời <PowerIconKeywords:lực lượng>."
  },
  RelicConfig_13844_Desc = {
    Text = "Khi bạn gây <WeaknessIconKeywords:suy nhược>, nhận được [Arg1] điểm lá chắn; khi gây <VulnerabilityIconKeywords:trọng thương>, nhận được [Arg2] điểm tạm thời <PowerIconKeywords:lực lượng>. Nếu cả hai hiệu ứng này được kích hoạt trong 1 lượt, bạn sẽ nhận thêm [Arg1] điểm lá chắn và [Arg2] điểm tạm thời <PowerIconKeywords:lực lượng>."
  },
  RelicConfig_13844_Name = {
    Text = "<OrangeQuality:khung tranh nặng>"
  },
  RelicConfig_13844_StoryDesc = {
    Text = "Tác phẩm cuối cùng của một nghệ sĩ rối loạn tinh thần, người ta nói có thể nhìn thấy khuôn mặt kinh hoàng của ông ấy từ đó."
  },
  RelicConfig_13845_BattleDesc = {
    Text = "Khi dùng hết điểm sức tính toán cuối cùng, nhận được 2 điểm sức tính toán. Mỗi lượt tối đa kích hoạt 2 lần."
  },
  RelicConfig_13845_Desc = {
    Text = "Khi dùng hết điểm sức tính toán cuối cùng, nhận được 2 điểm sức tính toán. Mỗi lượt tối đa kích hoạt 2 lần."
  },
  RelicConfig_13845_Name = {
    Text = "<OrangeQuality:☆bạc trắng phân biệt☆>"
  },
  RelicConfig_13845_StoryDesc = {
    Text = "\"Nó đã thay đổi lịch sử.\""
  },
  RelicConfig_13846_BattleDesc = {
    Text = "Mỗi khi bạn mất sức sống, bạn sẽ nhận được [Arg1] điểm <PowerIconKeywords:lực lượng>, tối đa 10 lần cộng dồn mỗi trận chiến. Khi đạt mức tối đa, phục hồi 25% lượng sức sống đã mất."
  },
  RelicConfig_13846_Desc = {
    Text = "Mỗi khi bạn mất sức sống, bạn sẽ nhận được [Arg1] điểm <PowerIconKeywords:lực lượng>, tối đa 10 lần cộng dồn mỗi trận chiến. Khi đạt mức tối đa, phục hồi 25% lượng sức sống đã mất."
  },
  RelicConfig_13846_Name = {
    Text = "<OrangeQuality:vô thượng vinh sủng>"
  },
  RelicConfig_13846_StoryDesc = {
    Text = "Con mèo lông ngắn màu đen thanh lịch và bí ẩn, được cho là hiện thân của vị thần ở một quốc gia sa mạc xa xôi nào đó. Nhưng cái tên của vị thần đó, hiện nay không ai biết đến. \n Bị thờ phụng, bị ngưỡng mộ, bị lãng quên, có lẽ đó chính là số mệnh của vị thần."
  },
  RelicConfig_13847_BattleDesc = {
    Text = "Thương gây ra cho kẻ địch đang trong trạng thái tiêu cực tăng 20%, sau khi giết kẻ địch, người giết sẽ nhận được 20 điên cuồng."
  },
  RelicConfig_13847_Desc = {
    Text = "Thương gây ra cho kẻ địch đang trong trạng thái tiêu cực tăng 20%, sau khi giết kẻ địch, người giết sẽ nhận được 20 điên cuồng."
  },
  RelicConfig_13847_Name = {
    Text = "<OrangeQuality:quyền trượng của linh mục>"
  },
  RelicConfig_13847_StoryDesc = {
    Text = "Sự sùng kính không được phép"
  },
  RelicConfig_13848_BattleDesc = {
    Text = "Khi nhặt, sự tinh thông giới vực của đội tăng lên 150% giá trị gốc. Mỗi lượt sau khi dùng thẻ lệnh thứ 5, tất cả thân thể được đánh thức nhận 20 điên cuồng."
  },
  RelicConfig_13848_Desc = {
    Text = "Khi nhặt, sự tinh thông giới vực của đội tăng lên 150% giá trị gốc. Mỗi lượt sau khi dùng thẻ lệnh thứ 5, tất cả thân thể được đánh thức nhận 20 điên cuồng."
  },
  RelicConfig_13848_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「ô uế」>"
  },
  RelicConfig_13849_BattleDesc = {
    Text = "Mỗi lượt, sau khi gây thương lần thứ 3, nhận [Arg1] điểm lá chắn. Mỗi lượt, sau khi gây thương lần thứ 6, nhận [Arg2] điểm<PowerIconKeywords:lực lượng>."
  },
  RelicConfig_13849_Desc = {
    Text = "Mỗi lượt, sau khi gây thương lần thứ 3, nhận [Arg1] điểm lá chắn. Mỗi lượt, sau khi gây thương lần thứ 6, nhận [Arg2] điểm<PowerIconKeywords:lực lượng>."
  },
  RelicConfig_13849_Name = {
    Text = "<WhiteQuality:lối thoát hiểm an toàn>"
  },
  RelicConfig_13849_StoryDesc = {
    Text = "Thấy rằng, anh ta cũng không thể thoát ra được."
  },
  RelicConfig_13851_BattleDesc = {
    Text = "Mỗi lần <DevouredIconKeywords:hấp thụ>, tạm thời đánh cắp [Arg1] điểm <PowerIconKeywords:lực lượng> từ tất cả kẻ địch."
  },
  RelicConfig_13851_Desc = {
    Text = "Mỗi lần <DevouredIconKeywords:hấp thụ>, tạm thời đánh cắp [Arg1] điểm <PowerIconKeywords:lực lượng> từ tất cả kẻ địch."
  },
  RelicConfig_13851_Name = {
    Text = "<OrangeQuality:đạo cụ tinh diệu>"
  },
  RelicConfig_13851_StoryDesc = {
    Text = "Công cụ tuyệt vời để giết người, cướp của và gãi chỗ ngứa."
  },
  RelicConfig_13852_BattleDesc = {
    Text = "Khi nhặt, chọn một thân thể được đánh thức để thức tỉnh, giảm vĩnh viễn tiêu thụ sức tính toán của thẻ thức tỉnh đi 1."
  },
  RelicConfig_13852_Desc = {
    Text = "Khi nhặt, chọn một thân thể được đánh thức để thức tỉnh, giảm vĩnh viễn tiêu thụ sức tính toán của thẻ thức tỉnh đi 1."
  },
  RelicConfig_13852_Name = {
    Text = "<WhiteQuality:thời gian nội dung bí mật>"
  },
  RelicConfig_13852_StoryDesc = {
    Text = "Thưởng thức niềm vui, nhưng không được ăn."
  },
  RelicConfig_13853_BattleDesc = {
    Text = "Mỗi khi gây thương sẽ nhận được [Arg1] điểm tạm thời <RetaliateIconKeywords:phản công>, mỗi lượt tối đa kích hoạt 5 lần, lần kích hoạt thứ 5 sẽ đưa một lá <DerivativeCardKeywords_4:「cảm hứng」> vào rút bài từ bộ bài."
  },
  RelicConfig_13853_Desc = {
    Text = "Mỗi khi gây thương sẽ nhận được [Arg1] điểm tạm thời <RetaliateIconKeywords:phản công>, mỗi lượt tối đa kích hoạt 5 lần, lần kích hoạt thứ 5 sẽ đưa một lá <DerivativeCardKeywords_4:「cảm hứng」> vào rút bài từ bộ bài."
  },
  RelicConfig_13853_Name = {
    Text = "<WhiteQuality:dao tế bị lãng quên>"
  },
  RelicConfig_13853_StoryDesc = {
    Text = "Dao có lưỡi cong, thường được sử dụng trong các nghi lễ tế lễ."
  },
  RelicConfig_13854_BattleDesc = {
    Text = "Vào đầu lượt, rút 2 lá bài và nhận 2 điểm sức tính toán. Mỗi khi bạn rút được 1 lá thẻ lệnh hoặc Thức tỉnh linh tri thức, ngẫu nhiên thay đổi tiêu thụ sức tính toán. (0-4)"
  },
  RelicConfig_13854_Desc = {
    Text = "Vào đầu lượt, rút 2 lá bài và nhận 2 điểm sức tính toán. Mỗi khi bạn rút được 1 lá thẻ lệnh hoặc Thức tỉnh linh tri thức, ngẫu nhiên thay đổi tiêu thụ sức tính toán. (0-4)"
  },
  RelicConfig_13854_Name = {
    Text = "<RedQuality:mũ lưỡi trai thuật sĩ>"
  },
  RelicConfig_13854_StoryDesc = {
    Text = "Chào mừng bạn đến với rạp xiếc xứ sở thần tiên của cô Kasia! Hãy cẩn thận, đừng tùy tiện chạm vào đạo cụ ảo thuật nhé. Nếu chẳng may bị cắn, thì sẽ thật tồi tệ. \nDù sao đi nữa, lần trước nó nếm thử vị máu, hậu quả thật kinh dị. \n\nChiếc mũ chớp mắt, như thể sắp sửa thoát ra khỏi kén."
  },
  RelicConfig_13855_BattleDesc = {
    Text = "Đầu lượt và mỗi khi Hồi phục sinh lực trong lượt, nhận được [Arg1] điểm <RetaliateIconKeywords:phản công>, mỗi lượt nhận tối đa 3 lần phản công. Khi đạt giới hạn, kích hoạt <RetaliateIconKeywords:phản công> 100％ lên tất cả kẻ địch."
  },
  RelicConfig_13855_Desc = {
    Text = "Đầu lượt và mỗi khi Hồi phục sinh lực trong lượt, nhận được [Arg1] điểm <RetaliateIconKeywords:phản công>, mỗi lượt nhận tối đa 3 lần phản công. Khi đạt giới hạn, kích hoạt <RetaliateIconKeywords:phản công> 100％ lên tất cả kẻ địch."
  },
  RelicConfig_13855_Name = {
    Text = "<OrangeQuality:hộp nhạc nhỏ>"
  },
  RelicConfig_13855_StoryDesc = {
    Text = "Trong dinh thự của Dexter có nhiều bộ sưu tập, trước khi bị hỏng, Hộp Nhạc Nhỏ từng là món đồ chơi yêu thích nhất của tiểu thư Dexter. \n Thời gian trôi qua, khi tiểu thư Dexter tìm thấy cô ấy lần nữa, bánh răng của cô đã lỏng lẻo, âm nhạc bị biến tấu, nhưng vẫn không ngừng xoay."
  },
  RelicConfig_13856_BattleDesc = {
    Text = "Thương harming chí mạng tăng 15%. \"Đánh\" tỷ lệ chí mạng tăng 40%."
  },
  RelicConfig_13856_Desc = {
    Text = "Thương harming chí mạng tăng 15%. \"Đánh\" tỷ lệ chí mạng tăng 40%."
  },
  RelicConfig_13856_Name = {
    Text = "<WhiteQuality:mỏ quạ trắng>"
  },
  RelicConfig_13856_StoryDesc = {
    Text = "Trước mặt nó không có bí mật gì."
  },
  RelicConfig_13857_BattleDesc = {
    Text = "Sau khi cơn thịnh nộ bùng phát, nhận được [Arg1] điểm <RetaliateIconKeywords:phản công>. Nếu đây là lần thứ 6 kích hoạt trong trận chiến này, <RetaliateIconKeywords:phản công> của bạn sẽ được tăng gấp đôi."
  },
  RelicConfig_13857_Desc = {
    Text = "Sau khi cơn thịnh nộ bùng phát, nhận được [Arg1] điểm <RetaliateIconKeywords:phản công>. Nếu đây là lần thứ 6 kích hoạt trong trận chiến này, <RetaliateIconKeywords:phản công> của bạn sẽ được tăng gấp đôi."
  },
  RelicConfig_13857_Name = {
    Text = "<OrangeQuality:☆Lục Phân Nghi☆>"
  },
  RelicConfig_13857_StoryDesc = {
    Text = "Dẫn lối cho bạn chỉ toàn những ngã rẽ sai lầm."
  },
  RelicConfig_13858_BattleDesc = {
    Text = "Mỗi lượt rút thêm 1 lá bài, nhận được 1 điểm năng lực tính toán."
  },
  RelicConfig_13858_Desc = {
    Text = "Mỗi lượt rút thêm 1 lá bài, nhận được 1 điểm năng lực tính toán."
  },
  RelicConfig_13858_Name = {
    Text = "<OrangeQuality:☆hoài niệm đẹp☆>"
  },
  RelicConfig_13858_StoryDesc = {
    Text = "Có người mãi mãi ở lại mùa hè đó."
  },
  RelicConfig_13859_BattleDesc = {
    Text = "Vào đầu mỗi lượt, rút 1 lá bài. Vào đầu mỗi chiến đấu, trộn 1 lá <DerivativeCardKeywords_4:「cảm hứng」> vào bộ bài của bạn. Mỗi chiến đấu đi qua sẽ tăng sức mạnh của lá <DerivativeCardKeywords_4:「cảm hứng」> được trộn vào 1, tối đa 3 lần."
  },
  RelicConfig_13859_Desc = {
    Text = "Vào đầu mỗi lượt, rút 1 lá bài. Vào đầu mỗi chiến đấu, trộn 1 lá <DerivativeCardKeywords_4:「cảm hứng」> vào bộ bài của bạn. Mỗi chiến đấu đi qua sẽ tăng sức mạnh của lá <DerivativeCardKeywords_4:「cảm hứng」> được trộn vào 1, tối đa 3 lần."
  },
  RelicConfig_13859_Name = {
    Text = "<OrangeQuality:Phrasno Kính>"
  },
  RelicConfig_13859_StoryDesc = {
    Text = "Màn trình diễn của ánh sáng và bóng tối."
  },
  RelicConfig_13860_BattleDesc = {
    Text = "Mỗi khi đánh liên tục các lá bài của cùng một thân thể được đánh thức, thân thể được đánh thức đó nhận được 8 điên cuồng."
  },
  RelicConfig_13860_Desc = {
    Text = "Mỗi khi đánh liên tục các lá bài của cùng một thân thể được đánh thức, thân thể được đánh thức đó nhận được 8 điên cuồng."
  },
  RelicConfig_13860_Name = {
    Text = "<WhiteQuality:đồng hồ chính xác>"
  },
  RelicConfig_13860_StoryDesc = {
    Text = "Một trong những phát minh tàn nhẫn nhất trong lịch sử loài người."
  },
  RelicConfig_13861_BattleDesc = {
    Text = "Khi nhặt, chọn một thẻ bài Thức Tỉnh, giảm 1 điểm tiêu thụ sức tính toán và coi nó là \"Đánh\"."
  },
  RelicConfig_13861_Desc = {
    Text = "Khi nhặt, chọn một thẻ bài Thức Tỉnh, giảm 1 điểm tiêu thụ sức tính toán và coi nó là \"Đánh\"."
  },
  RelicConfig_13861_Name = {
    Text = "<OrangeQuality:Ngẫu nhiên Mâu thuẫn>"
  },
  RelicConfig_13861_StoryDesc = {
    Text = "Cười một cách thoải mái!"
  },
  RelicConfig_13862_BattleDesc = {
    Text = "Sau khi nhặt, mất vĩnh viễn [Arg1] <PowerIconKeywords:lực lượng>. Mỗi khi gây sát thương, hồi [Arg2] điểm sức sống, tối đa 6 lần mỗi lượt."
  },
  RelicConfig_13862_Desc = {
    Text = "Sau khi nhặt, mất vĩnh viễn [Arg1] <PowerIconKeywords:lực lượng>. Mỗi khi gây sát thương, hồi [Arg2] điểm sức sống, tối đa 6 lần mỗi lượt."
  },
  RelicConfig_13862_Name = {
    Text = "<RedQuality:Nụ hôn của cá mút đá>"
  },
  RelicConfig_13862_StoryDesc = {
    Text = "Muốn một nụ hôn sâu đậm không? Loại có thể lấy mạng bạn đấy."
  },
  RelicConfig_13863_BattleDesc = {
    Text = "Trong vòng đầu của mỗi cuộc chiến đấu, nhận 3 điểm sức tính toán."
  },
  RelicConfig_13863_Desc = {
    Text = "Trong vòng đầu của mỗi cuộc chiến đấu, nhận 3 điểm sức tính toán."
  },
  RelicConfig_13863_Name = {
    Text = "<WhiteQuality:đồng hồ bỏ túi>"
  },
  RelicConfig_13863_StoryDesc = {
    Text = "Ký ức ngưng đọng trong quá khứ, chôn vùi trong bóng tối sâu thẳm."
  },
  RelicConfig_13864_BattleDesc = {
    Text = "Mỗi lượt, sau khi đánh thẻ lệnh lần đầu tiên, đặt một thẻ \"Đánh\" tương ứng vào tay, trao cho nó <NothingnessIconKeywords: hư vô> và <DepleteIconKeywords: tiêu thụ>."
  },
  RelicConfig_13864_Desc = {
    Text = "Mỗi lượt, sau khi đánh thẻ lệnh lần đầu tiên, đặt một thẻ \"Đánh\" tương ứng vào tay, trao cho nó <NothingnessIconKeywords: hư vô> và <DepleteIconKeywords: tiêu thụ>."
  },
  RelicConfig_13864_Name = {
    Text = "<WhiteQuality:trục bánh xe kiểu mới>"
  },
  RelicConfig_13864_StoryDesc = {
    Text = "Từ làng quê di chuyển đến thành phố, từ thảm họa tiến tới phục hưng."
  },
  RelicConfig_13865_BattleDesc = {
    Text = "Mỗi lượt, sau khi đánh thẻ lệnh lần đầu tiên, thêm một thẻ \"phòng thủ\" của thân thể được đánh thức vào tay, kèm theo <NothingnessIconKeywords:hư vô> và <DepleteIconKeywords:tiêu thụ>."
  },
  RelicConfig_13865_Desc = {
    Text = "Mỗi lượt, sau khi đánh thẻ lệnh lần đầu tiên, thêm một thẻ \"phòng thủ\" của thân thể được đánh thức vào tay, kèm theo <NothingnessIconKeywords:hư vô> và <DepleteIconKeywords:tiêu thụ>."
  },
  RelicConfig_13865_Name = {
    Text = "<WhiteQuality:Giai Điệu Câm Lặng>"
  },
  RelicConfig_13865_StoryDesc = {
    Text = "Đàn violin của nghệ sĩ violin nổi tiếng Eric Eichstein. \n Hiện nay, nó đã vĩnh viễn lặng im."
  },
  RelicConfig_13866_BattleDesc = {
    Text = "Mỗi 3 lượt, thêm 1 lớp <VulnerabilityIconKeywords:dễ bị tổn thương>. Sau khi gây thương lên kẻ địch có <VulnerabilityIconKeywords:dễ bị tổn thương>, làm mất [Arg1] điểm <PowerIconKeywords:lực lượng> tạm thời, tối đa 3 lần mỗi lượt."
  },
  RelicConfig_13866_Desc = {
    Text = "Mỗi 3 lượt, thêm 1 lớp <VulnerabilityIconKeywords:dễ bị tổn thương>. Sau khi gây thương lên kẻ địch có <VulnerabilityIconKeywords:dễ bị tổn thương>, làm mất [Arg1] điểm <PowerIconKeywords:lực lượng> tạm thời, tối đa 3 lần mỗi lượt."
  },
  RelicConfig_13866_Name = {
    Text = "<WhiteQuality:Lễ hội Mùa xuân>"
  },
  RelicConfig_13866_StoryDesc = {
    Text = "Trong tiếng cười rộn ràng của đêm, hình bóng chiếc thuyền độc mộc lướt nhẹ nhàng trên mặt hồ."
  },
  RelicConfig_13867_BattleDesc = {
    Text = "Giới hạn thẻ bài trên tay tăng 3, nhưng số lượng thẻ bài rút mỗi lượt giảm 1. Cuối lượt, bỏ tất cả các thẻ triệu chứng và thẻ trạng thái trong tay, giữ lại các thẻ khác."
  },
  RelicConfig_13867_Desc = {
    Text = "Giới hạn thẻ bài trên tay tăng 3, nhưng số lượng thẻ bài rút mỗi lượt giảm 1. Cuối lượt, bỏ tất cả các thẻ triệu chứng và thẻ trạng thái trong tay, giữ lại các thẻ khác."
  },
  RelicConfig_13867_Name = {
    Text = "<RedQuality:khắc dấu ý thức>"
  },
  RelicConfig_13867_StoryDesc = {
    Text = "Bộ lạc cổ xưa tin rằng, khắc các ký hiệu đặc biệt trên đầu người chết có thể giữ lại linh hồn của người đó, để có được sự đồng hành mãi mãi."
  },
  RelicConfig_13868_BattleDesc = {
    Text = "Sau mỗi 4 lần kích hoạt điên cuồng bùng phát, tiêu thụ sức tính toán của tất cả các lá bài giảm 1."
  },
  RelicConfig_13868_Desc = {
    Text = "Sau mỗi 4 lần kích hoạt điên cuồng bùng phát, tiêu thụ sức tính toán của tất cả các lá bài giảm 1."
  },
  RelicConfig_13868_Name = {
    Text = "<WhiteQuality:☆bản đồ thoát hiểm☆>"
  },
  RelicConfig_13868_StoryDesc = {
    Text = "\"Sau khi lên tàu, vui lòng tìm lối thoát hiểm gần phòng cabin nhất.\""
  },
  RelicConfig_13869_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:thông thạo giới vực> tăng 100. Mỗi lần gây thương tổn chủ động, thương tổn xúc tu tạm thời + [Arg1], mỗi lần gây thương tổn xúc tu, nhận được [Arg2] điểm lá chắn. Mỗi lượt tối đa có hiệu lực 6 lần."
  },
  RelicConfig_13869_Desc = {
    Text = "<ProficientInRealmsIconKeywords:thông thạo giới vực> tăng 100. Mỗi lần gây thương tổn chủ động, thương tổn xúc tu tạm thời + [Arg1], mỗi lần gây thương tổn xúc tu, nhận được [Arg2] điểm lá chắn. Mỗi lượt tối đa có hiệu lực 6 lần."
  },
  RelicConfig_13869_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「ác mộng」>"
  },
  RelicConfig_13870_BattleDesc = {
    Text = "Mỗi khi tiêu thụ 1 điểm sức tính toán, khiến thân thể được đánh thức nhận 2 điểm điên cuồng."
  },
  RelicConfig_13870_Desc = {
    Text = "Mỗi khi tiêu thụ 1 điểm sức tính toán, khiến thân thể được đánh thức nhận 2 điểm điên cuồng."
  },
  RelicConfig_13870_Name = {
    Text = "<WhiteQuality:đai lụa màu bạc với móc vuông>"
  },
  RelicConfig_13870_StoryDesc = {
    Text = "Dải ruy băng từng xuất hiện tại hiện trường vụ án đã bị lực mạnh tác động làm đứt thành hai đoạn. \nMột trong những đoạn đó đã nhẹ nhàng đáp xuống lòng bàn tay cô gái."
  },
  RelicConfig_13871_BattleDesc = {
    Text = "Mỗi đầu lượt, tất cả các thân thể được đánh thức nhận được 10 điểm điên cuồng. Khi nhặt, máu tối đa giảm 30%."
  },
  RelicConfig_13871_Desc = {
    Text = "Mỗi đầu lượt, tất cả các thân thể được đánh thức nhận được 10 điểm điên cuồng. Khi nhặt, máu tối đa giảm 30%."
  },
  RelicConfig_13871_Name = {
    Text = "<RedQuality:biểu tượng ác mộng>"
  },
  RelicConfig_13871_StoryDesc = {
    Text = "Cẩn thận, giấc ngủ sâu quá đà sẽ nuốt chửng mọi thứ khi bạn không hay biết."
  },
  RelicConfig_13873_BattleDesc = {
    Text = "Đánh ra \"<ExaltIconKeywords:Thức tỉnh linh tri thức>\" sau đó, loại bỏ tất cả lá chắn của kẻ địch."
  },
  RelicConfig_13873_Desc = {
    Text = "Đánh ra \"<ExaltIconKeywords:Thức tỉnh linh tri thức>\" sau đó, loại bỏ tất cả lá chắn của kẻ địch."
  },
  RelicConfig_13873_Name = {
    Text = "Bề mặt gương đen"
  },
  RelicConfig_13874_BattleDesc = {
    Text = "Trong các lượt lẻ, khi số lượng thẻ còn lại trong tay là 0, rút 2 thẻ; trong các lượt chẵn, khi sức tính toán còn lại là 0, nhận 2 điểm sức tính toán."
  },
  RelicConfig_13874_Desc = {
    Text = "Trong các lượt lẻ, khi số lượng thẻ còn lại trong tay là 0, rút 2 thẻ; trong các lượt chẵn, khi sức tính toán còn lại là 0, nhận 2 điểm sức tính toán."
  },
  RelicConfig_13874_Name = {
    Text = "Hướng dẫn Dị Biến Vàng"
  },
  RelicConfig_13875_BattleDesc = {
    Text = "Sau khi sử dụng \"đánh kích\" và \"phòng thủ\", đối tượng được đánh thức tương ứng nhận được 35 điên cuồng. Tuy nhiên, tiêu thụ sức tính toán của chúng tăng thêm 1."
  },
  RelicConfig_13875_Desc = {
    Text = "Sau khi sử dụng \"đánh kích\" và \"phòng thủ\", đối tượng được đánh thức tương ứng nhận được 35 điên cuồng. Tuy nhiên, tiêu thụ sức tính toán của chúng tăng thêm 1."
  },
  RelicConfig_13875_Name = {
    Text = "<RedQuality:khuôn mặt bị hỏng>"
  },
  RelicConfig_13875_StoryDesc = {
    Text = "Khuôn mặt của ai đó, tràn ngập sự kinh hoàng, bị ngưng đọng trong dòng thời gian."
  },
  RelicConfig_13877_BattleDesc = {
    Text = "Sau khi nhận lá chắn lần thứ 2 trong mỗi lượt, nhận được [Arg1] lớp <RetaliateIconKeywords:phản công>. Sau khi nhận lá chắn lần thứ 4 trong mỗi lượt, kích hoạt <RetaliateIconKeywords:phản công> 100％ lên tất cả kẻ địch."
  },
  RelicConfig_13877_Desc = {
    Text = "Sau khi nhận lá chắn lần thứ 2 trong mỗi lượt, nhận được [Arg1] lớp <RetaliateIconKeywords:phản công>. Sau khi nhận lá chắn lần thứ 4 trong mỗi lượt, kích hoạt <RetaliateIconKeywords:phản công> 100％ lên tất cả kẻ địch."
  },
  RelicConfig_13877_Name = {
    Text = "<WhiteQuality:không giấu điều gì>"
  },
  RelicConfig_13877_StoryDesc = {
    Text = "Nó truyền đạt vô số bí mật nói ra một cách chủ động hoặc bị động."
  },
  RelicConfig_13878_BattleDesc = {
    Text = "Mỗi lần đánh ra thẻ lệnh thứ 6 sẽ khiến nó trở lại từ rác bài về tay bạn."
  },
  RelicConfig_13878_Desc = {
    Text = "Mỗi lần đánh ra thẻ lệnh thứ 6 sẽ khiến nó trở lại từ rác bài về tay bạn."
  },
  RelicConfig_13878_Name = {
    Text = "<OrangeQuality:trong ánh hoàng hôn>"
  },
  RelicConfig_13878_StoryDesc = {
    Text = "Hãy cùng chụp ảnh đi! Trải nghiệm cảm giác đau đớn thực sự một lần."
  },
  RelicConfig_13879_BattleDesc = {
    Text = "Sau mỗi 5 lần cơn thịnh nộ bùng phát, thân thể được đánh thức sẽ nhận thêm 100 điểm điên cuồng."
  },
  RelicConfig_13879_Desc = {
    Text = "Sau mỗi 5 lần cơn thịnh nộ bùng phát, thân thể được đánh thức sẽ nhận thêm 100 điểm điên cuồng."
  },
  RelicConfig_13879_Name = {
    Text = "<OrangeQuality:túi bọc bé>"
  },
  RelicConfig_13879_StoryDesc = {
    Text = "Chứa đựng hy vọng, lời chúc và tình yêu."
  },
  RelicConfig_13880_BattleDesc = {
    Text = "Gây ra thương chủ động sẽ nhận được [Arg1] điểm lá chắn. Khi hồi sức sống, nhận được [Arg2] điểm tạm thời<PowerIconKeywords:lực lượng>."
  },
  RelicConfig_13880_Desc = {
    Text = "Gây ra thương chủ động sẽ nhận được [Arg1] điểm lá chắn. Khi hồi sức sống, nhận được [Arg2] điểm tạm thời<PowerIconKeywords:lực lượng>."
  },
  RelicConfig_13880_Name = {
    Text = "<OrangeQuality:nhà của chúng tôi>"
  },
  RelicConfig_13880_StoryDesc = {
    Text = "Họ đã từng ở bên nhau, và sau này cũng sẽ mãi mãi ở bên nhau. Họ là một gia đình hòa thuận và đoàn kết."
  },
  RelicConfig_13881_BattleDesc = {
    Text = "Vào đầu lượt lẻ, nhận được [Arg1] điểm <PowerIconKeywords:lực lượng> tạm thời. Vào đầu lượt chẵn, nhận được [Arg2] điểm <AlertIconKeywords:giữ mình> tạm thời."
  },
  RelicConfig_13881_Desc = {
    Text = "Vào đầu lượt lẻ, nhận được [Arg1] điểm <PowerIconKeywords:lực lượng> tạm thời. Vào đầu lượt chẵn, nhận được [Arg2] điểm <AlertIconKeywords:giữ mình> tạm thời."
  },
  RelicConfig_13881_Name = {
    Text = "<WhiteQuality:búp bê song sinh>"
  },
  RelicConfig_13881_StoryDesc = {
    Text = "Song sinh là món quà từ thời kỳ cũ, là lời ngụ ngôn dành cho tương lai."
  },
  RelicConfig_13882_BattleDesc = {
    Text = "Mỗi lượt chơi, đánh ra thân thể được đánh thức tương ứng với thẻ lệnh đầu tiên, nhận được 20 điên cuồng vào cuối lượt. Nếu đồng thời sở hữu vật sáng tạo \"tinh thần hiến dâng\", khiến các thân thể được đánh thức khác cũng nhận được 5 điên cuồng."
  },
  RelicConfig_13882_Desc = {
    Text = "Mỗi lượt chơi, đánh ra thân thể được đánh thức tương ứng với thẻ lệnh đầu tiên, nhận được 20 điên cuồng vào cuối lượt. Nếu đồng thời sở hữu vật sáng tạo \"tinh thần hiến dâng\", khiến các thân thể được đánh thức khác cũng nhận được 5 điên cuồng."
  },
  RelicConfig_13882_Name = {
    Text = "<WhiteQuality:tượng mẹ>"
  },
  RelicConfig_13882_StoryDesc = {
    Text = "\"Cho bạn, bất cứ thứ gì cũng có thể cho bạn, làm ơn, hãy tha cho anh ấy.\""
  },
  RelicConfig_13883_BattleDesc = {
    Text = "Mỗi khi một thân thể được đánh thức thực hiện 1 lần <DevouredIconKeywords:nuốt chửng>, các thân thể được đánh thức khác nhận được 10 điểm điên cuồng."
  },
  RelicConfig_13883_Desc = {
    Text = "Mỗi khi một thân thể được đánh thức thực hiện 1 lần <DevouredIconKeywords:nuốt chửng>, các thân thể được đánh thức khác nhận được 10 điểm điên cuồng."
  },
  RelicConfig_13883_Name = {
    Text = "<OrangeQuality:thiên đường vàng>"
  },
  RelicConfig_13883_StoryDesc = {
    Text = "Ngày chuyển hóa chính là ngày chết của bạn."
  },
  RelicConfig_13884_BattleDesc = {
    Text = "\"Đánh\"áp dụng lên tất cả kẻ địch [Arg1] cấp độ<IntoxicationIconKeywords:trúng độc>."
  },
  RelicConfig_13884_Desc = {
    Text = "\"Đánh\"áp dụng lên tất cả kẻ địch [Arg1] cấp độ<IntoxicationIconKeywords:trúng độc>."
  },
  RelicConfig_13884_Name = {
    Text = "<WhiteQuality:chất độc thần kinh>"
  },
  RelicConfig_13884_StoryDesc = {
    Text = "Trích xuất và luyện chế"
  },
  RelicConfig_13885_BattleDesc = {
    Text = "Khi chiến đấu bắt đầu, thêm 1 lá <DerivativeCardKeywords_1:「dư ảnh hồi vang」> vào tay, nếu là trận chiến với thủ lĩnh, nhận thêm 1 lá <DerivativeCardKeywords_1:「dư ảnh hồi vang」>."
  },
  RelicConfig_13885_Desc = {
    Text = "Khi chiến đấu bắt đầu, thêm 1 lá <DerivativeCardKeywords_1:「dư ảnh hồi vang」> vào tay, nếu là trận chiến với thủ lĩnh, nhận thêm 1 lá <DerivativeCardKeywords_1:「dư ảnh hồi vang」>."
  },
  RelicConfig_13885_Name = {
    Text = "<WhiteQuality:thiết bị thông tin liên lạc>"
  },
  RelicConfig_13885_StoryDesc = {
    Text = "Ngóng trông hoặc lo lắng khoảnh khắc nó phát ra tiếng chuông trong trẻo."
  },
  RelicConfig_13886_BattleDesc = {
    Text = "Mỗi lần đặt lại bộ bài, thêm 2 lá<DerivativeCardKeywords_5:「dòng nĩa」>và 1 lá<DerivativeCardKeywords_6:「ô dù」>vào tay."
  },
  RelicConfig_13886_Desc = {
    Text = "Mỗi lần đặt lại bộ bài, thêm 2 lá<DerivativeCardKeywords_5:「dòng nĩa」>và 1 lá<DerivativeCardKeywords_6:「ô dù」>vào tay."
  },
  RelicConfig_13886_Name = {
    Text = "<WhiteQuality:☆túi xách thanh lịch☆>"
  },
  RelicConfig_13886_StoryDesc = {
    Text = "Nó vốn nên được chế tác tinh xảo, chứ không phải là cái chết."
  },
  RelicConfig_13887_BattleDesc = {
    Text = "Vào đầu lượt, thêm 1 lá <DerivativeCardKeywords_5:「dòng nĩa」> vào tay. Sau khi giải phóng <PowerIconKeywords:điên cuồng> bùng phát, tăng <PowerIconKeywords:lực lượng> của tất cả các lá <DerivativeCardKeywords_5:「dòng nĩa」> trong tay lên [Arg2]."
  },
  RelicConfig_13887_Desc = {
    Text = "Vào đầu lượt, thêm 1 lá <DerivativeCardKeywords_5:「dòng nĩa」> vào tay. Sau khi giải phóng <PowerIconKeywords:điên cuồng> bùng phát, tăng <PowerIconKeywords:lực lượng> của tất cả các lá <DerivativeCardKeywords_5:「dòng nĩa」> trong tay lên [Arg2]."
  },
  RelicConfig_13887_Name = {
    Text = "<WhiteQuality:dòng nĩa>"
  },
  RelicConfig_13887_StoryDesc = {
    Text = "Dù nhìn từ góc độ nào cũng rất bình thường."
  },
  RelicConfig_13888_BattleDesc = {
    Text = "Nhận [Arg1] điểm lá chắn khi bắt đầu chiến đấu. Sau khi đánh 7 lần \"phòng thủ\" trong trận chiến này, ngay lập tức nhận [Arg2] điểm lá chắn. Sau khi đánh 21 lần \"phòng thủ\" trong trận chiến này, nhận 1 lớp rào cản tạm thời."
  },
  RelicConfig_13888_Desc = {
    Text = "Nhận [Arg1] điểm lá chắn khi bắt đầu chiến đấu. Sau khi đánh 7 lần \"phòng thủ\" trong trận chiến này, ngay lập tức nhận [Arg2] điểm lá chắn. Sau khi đánh 21 lần \"phòng thủ\" trong trận chiến này, nhận 1 lớp rào cản tạm thời."
  },
  RelicConfig_13888_Name = {
    Text = "<WhiteQuality:Tin Tức Sáng Putney>"
  },
  RelicConfig_13888_StoryDesc = {
    Text = "Người bạn đồng hành thân thiết nhất trong nhà vệ sinh của bạn."
  },
  RelicConfig_13889_BattleDesc = {
    Text = "Sau khi vào lượt siêu chiều, nhận được 3 điểm sức tính toán."
  },
  RelicConfig_13889_Desc = {
    Text = "Sau khi vào lượt siêu chiều, nhận được 3 điểm sức tính toán."
  },
  RelicConfig_13889_Name = {
    Text = "<WhiteQuality:ánh sáng đồng hồ cát>"
  },
  RelicConfig_13889_StoryDesc = {
    Text = "Một khoảng thời gian có thể đo lường được."
  },
  RelicConfig_13890_BattleDesc = {
    Text = "Khi bắt đầu trận chiến, áp dụng 1 lượt <WeaknessIconKeywords:yếu đuối> và <VulnerabilityIconKeywords:dễ bị tổn thương> cho tất cả kẻ địch, nếu là trận chiến lãnh đạo, thêm 2 lượt <WeaknessIconKeywords:yếu đuối> và <VulnerabilityIconKeywords:dễ bị tổn thương>."
  },
  RelicConfig_13890_Desc = {
    Text = "Khi bắt đầu chiến đấu, áp dụng 1 lượt <WeaknessIconKeywords:yếu đuối> và <VulnerabilityIconKeywords:tăng sát thương> lên tất cả kẻ địch, nếu là trận chiến lãnh đạo, áp dụng thêm 2 lượt <WeaknessIconKeywords:yếu đuối> và <VulnerabilityIconKeywords:tăng sát thương>."
  },
  RelicConfig_13890_Name = {
    Text = "<WhiteQuality:Áo Ngự Biến Sắc>"
  },
  RelicConfig_13890_StoryDesc = {
    Text = "Không chỉ thời gian mới có thể làm biến đổi màu sắc của vải, mà cả nỗi sợ hãi và đau khổ cũng vậy."
  },
  RelicConfig_13891_BattleDesc = {
    Text = "Mỗi lượt, nếu thẻ lệnh đầu tiên được đánh ra kích hoạt hiệu ứng nhảy vọt, rút 1 thẻ; ngược lại, nhận 1 điểm sức tính toán. Nếu là lượt siêu việt, sẽ có đồng thời cả hai hiệu ứng trên."
  },
  RelicConfig_13891_Desc = {
    Text = "Mỗi lượt, nếu thẻ lệnh đầu tiên được đánh ra kích hoạt hiệu ứng nhảy vọt, rút 1 thẻ; ngược lại, nhận 1 điểm sức tính toán. Nếu là lượt siêu việt, sẽ có đồng thời cả hai hiệu ứng trên."
  },
  RelicConfig_13891_Name = {
    Text = "<OrangeQuality:thiết bị dịch chuyển>"
  },
  RelicConfig_13891_StoryDesc = {
    Text = "Phản chiếu ra những hình bóng méo mó."
  },
  RelicConfig_13892_BattleDesc = {
    Text = "Nhận được một nhiệm vụ. Hoàn thành nhiệm vụ và nhận được phần thưởng. [Nhiệm vụ sự kiện]"
  },
  RelicConfig_13892_Desc = {
    Text = "Nhận được một nhiệm vụ. Hoàn thành nhiệm vụ và nhận được phần thưởng. [Nhiệm vụ sự kiện]"
  },
  RelicConfig_13892_Name = {
    Text = "<WhiteQuality:sổ tay cũ kỹ>"
  },
  RelicConfig_13892_StoryDesc = {
    Text = "Một cuốn nhật ký cũ kỹ, bên trong chứa đầy các tờ giấy thêm vào, nhìn qua ít nhất bao gồm bản đồ Elworth, ghi chép thí nghiệm, và những tờ giấy ghi chú đầy dấu ăn mòn hình tam giác. \n Nội dung ở phần đầu của ghi chú có chữ viết rõ ràng, nhưng sau đó dần trở nên lộn xộn và bừa bộn."
  },
  RelicConfig_13893_BattleDesc = {
    Text = "Mỗi lần thứ 4 nhận được giá trị lá chắn, phục hồi 50% giá trị lá chắn thành sức sống."
  },
  RelicConfig_13893_Desc = {
    Text = "Mỗi lần thứ 4 nhận được giá trị lá chắn, phục hồi 50% giá trị lá chắn thành sức sống."
  },
  RelicConfig_13893_Name = {
    Text = "<WhiteQuality:còi thủy thủ>"
  },
  RelicConfig_13893_StoryDesc = {
    Text = "Ngoài người cá, tiếng còi còn có thể gọi bão, ủng cũ hôi thối và thủy thủ già bẩn thỉu cả trăm ngày chưa tắm."
  },
  RelicConfig_13894_BattleDesc = {
    Text = "Nếu số lượng thẻ bài được đánh ra ở lượt trước nhỏ hơn hoặc bằng 4, thẻ bài đầu tiên được đánh ra trong lượt này sẽ được kích hoạt 2 lần."
  },
  RelicConfig_13894_Desc = {
    Text = "Nếu số lượng thẻ bài được đánh ra ở lượt trước nhỏ hơn hoặc bằng 4, thẻ bài đầu tiên được đánh ra trong lượt này sẽ được kích hoạt 2 lần."
  },
  RelicConfig_13894_Name = {
    Text = "<OrangeQuality:☆đèn hồn ác mộng☆>"
  },
  RelicConfig_13894_StoryDesc = {
    Text = "Đưa vào ảo mộng."
  },
  RelicConfig_13895_BattleDesc = {
    Text = "Mỗi khi bạn mất mạng sống, thân thể được đánh thức có điên cuồng thấp nhất sẽ nhận được 10 điên cuồng. Mỗi khi bạn mất mạng sống 5 lần, phục hồi 20% sức sống đã mất."
  },
  RelicConfig_13895_Desc = {
    Text = "Mỗi khi bạn mất mạng sống, thân thể được đánh thức có điên cuồng thấp nhất sẽ nhận được 10 điên cuồng. Mỗi khi bạn mất mạng sống 5 lần, phục hồi 20% sức sống đã mất."
  },
  RelicConfig_13895_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「phân tích」>"
  },
  RelicConfig_13896_BattleDesc = {
    Text = "Tăng sức tính toán lên 2. Mỗi lần reset bộ bài, thêm 1 lá <DerivativeCardKeywords_9:「chập chững」> vào nguồn rút bài."
  },
  RelicConfig_13896_Desc = {
    Text = "Tăng sức tính toán lên 2. Mỗi lần reset bộ bài, thêm 1 lá <DerivativeCardKeywords_9:「chập chững」> vào nguồn rút bài."
  },
  RelicConfig_13896_Name = {
    Text = "<RedQuality:nến đen>"
  },
  RelicConfig_13896_StoryDesc = {
    Text = "Thiêu đốt sự tỉnh thức, trượt vào hư vọng."
  },
  RelicConfig_13897_BattleDesc = {
    Text = "\"<ExaltIconKeywords:Thức tỉnh linh tri>\"được giữ lại khi kết thúc lượt."
  },
  RelicConfig_13897_Desc = {
    Text = "\"<ExaltIconKeywords:Thức tỉnh linh tri>\"được giữ lại khi kết thúc lượt."
  },
  RelicConfig_13897_Name = {
    Text = "Gương trắng"
  },
  RelicConfig_13898_BattleDesc = {
    Text = "Mỗi khi có 1 thân thể được đánh thức đã thức tỉnh thì <ProficientInRealmsIconKeywords:giới vực tinh thông> tăng 35. Sau khi đánh ra \"<ExaltIconKeywords:Thức tỉnh linh tri thức>\", ngẫu nhiên nhận được 2 lá thẻ lệnh của thân thể được đánh thức đó và gắn thêm \"tiêu thụ\"."
  },
  RelicConfig_13898_Desc = {
    Text = "Mỗi khi có 1 thân thể được đánh thức đã thức tỉnh thì <ProficientInRealmsIconKeywords:giới vực tinh thông> tăng 35. Sau khi đánh ra \"<ExaltIconKeywords:Thức tỉnh linh tri thức>\", ngẫu nhiên nhận được 2 lá thẻ lệnh của thân thể được đánh thức đó và gắn thêm \"tiêu thụ\"."
  },
  RelicConfig_13898_Name = {
    Text = "<OrangeQuality:Lời Thần>"
  },
  RelicConfig_13898_StoryDesc = {
    Text = "Ngài nói, đừng sợ ."
  },
  RelicConfig_13899_BattleDesc = {
    Text = "Vào đầu lượt, <ProficientInRealmsIconKeywords:Giới vực tinh thông> được tăng thêm 50. Khi không ở trạng thái tiêu cực, <ProficientInRealmsIconKeywords:Giới vực tinh thông> được tăng lên thành 150."
  },
  RelicConfig_13899_Desc = {
    Text = "Vào đầu lượt, <ProficientInRealmsIconKeywords:Giới vực tinh thông> được tăng thêm 50. Khi không ở trạng thái tiêu cực, <ProficientInRealmsIconKeywords:Giới vực tinh thông> được tăng lên thành 150."
  },
  RelicConfig_13899_Name = {
    Text = "<WhiteQuality:☆「Vinh danh Tự Do」☆>"
  },
  RelicConfig_13899_StoryDesc = {
    Text = "Một nắm bạc tâm gợi chút hoài niệm."
  },
  RelicConfig_13900_BattleDesc = {
    Text = "Sau khi sử dụng \"điên cuồng bùng phát\", tất cả lá bài trên tay giảm 1 sức tính toán."
  },
  RelicConfig_13900_Desc = {
    Text = "Sau khi sử dụng \"điên cuồng bùng phát\", tiêu thụ sức tính toán của tất cả các lá bài trên tay giảm -1."
  },
  RelicConfig_13900_Name = {
    Text = "Ánh sáng của nền văn minh biến đổi"
  },
  RelicConfig_13901_BattleDesc = {
    Text = "Mỗi khi chơi 1 lá thẻ lệnh, nhận được [Arg2]% <DeathResistanceIconKeywords:kháng cự tử vong> (mỗi lần kích hoạt kháng cự tử vong trong màn chơi này, kháng cự tử vong nhận được sẽ giảm một nửa). Nếu <DeathResistanceIconKeywords:kháng cự tử vong> của bạn lớn hơn hoặc bằng 100%, thay vào đó sẽ nhận được [Arg1] điểm tạm thời <PowerIconKeywords:lực lượng>."
  },
  RelicConfig_13901_Desc = {
    Text = "Mỗi lần chơi 1 thẻ lệnh, nhận được [Arg2]% <DeathResistanceIconKeywords:kháng cự tử vong> (mỗi lần kích hoạt kháng cự tử vong trong màn chơi này, kháng cự tử vong nhận được sẽ giảm một nửa). Nếu <DeathResistanceIconKeywords:kháng cự tử vong> của bạn lớn hơn hoặc bằng 100%, sẽ nhận được [Arg1] điểm <PowerIconKeywords:lực lượng> tạm thời."
  },
  RelicConfig_13901_Name = {
    Text = "<OrangeQuality:rắn quái tàn lột>"
  },
  RelicConfig_13901_StoryDesc = {
    Text = "Hy sinh bản thân để tái sinh từ sự thay đổi."
  },
  RelicConfig_13902_BattleDesc = {
    Text = "Đầu lượt, nhận được [Arg2] điểm lá chắn. Cuối lượt, gây <FixedDamage:Sát Thương Thuần Túy> lên kẻ địch ngẫu nhiên bằng [Arg1]% giá trị lá chắn hiện tại, hiệu ứng sát thương trong Trận chiến Lãnh đạo được nhân đôi."
  },
  RelicConfig_13902_Desc = {
    Text = "Đầu lượt, nhận được [Arg2] điểm lá chắn. Cuối lượt, gây <FixedDamage:Sát Thương Thuần Túy> lên kẻ địch ngẫu nhiên bằng [Arg1]% giá trị lá chắn hiện tại, hiệu ứng sát thương trong Trận chiến Lãnh đạo được nhân đôi."
  },
  RelicConfig_13902_Name = {
    Text = "<WhiteQuality:vàng hướng đạo>"
  },
  RelicConfig_13902_StoryDesc = {
    Text = "Khi bạn mất phương hướng, hãy mở nó ra, nhưng hãy cẩn thận—— vương miện của nó không thể nhìn thấy ánh mặt trời."
  },
  RelicConfig_13904_BattleDesc = {
    Text = "Ẩn ý định quái vật. Mỗi lượt nhận được 1 điểm sức tính toán, rút 1 lá bài."
  },
  RelicConfig_13904_Desc = {
    Text = "Ẩn ý định quái vật. Mỗi lượt nhận được 1 điểm sức tính toán, rút 1 lá bài."
  },
  RelicConfig_13904_Name = {
    Text = "<RedQuality:đèn gió quyến rũ>"
  },
  RelicConfig_13904_StoryDesc = {
    Text = "Ting ting, ting ting."
  },
  RelicConfig_13905_BattleDesc = {
    Text = "Sau khi trận đấu bắt đầu, nhận được [Arg2] lớp<RetaliateIconKeywords:phản công>, đánh ra \"phòng thủ\" nhận được [Arg1] lớp<RetaliateIconKeywords:phản công>."
  },
  RelicConfig_13905_Desc = {
    Text = "Sau khi trận đấu bắt đầu, nhận được [Arg2] lớp<RetaliateIconKeywords:phản công>, đánh ra \"phòng thủ\" nhận được [Arg1] lớp<RetaliateIconKeywords:phản công>."
  },
  RelicConfig_13905_Name = {
    Text = "<WhiteQuality:áo giáp cây gai>"
  },
  RelicConfig_13905_StoryDesc = {
    Text = "Không thể phân biệt chất lỏng lạ."
  },
  RelicConfig_13906_BattleDesc = {
    Text = "Đây là một tạo vật 4 không có hiệu ứng"
  },
  RelicConfig_13906_Desc = {
    Text = "Đây là một tạo vật 4 không có hiệu ứng"
  },
  RelicConfig_13906_Name = {
    Text = "Thử thách hàng ngày hàng tuần thay phiên vật phẩm sáng tạo 4"
  },
  RelicConfig_13907_BattleDesc = {
    Text = "Vào đầu vòng, nếu số lượng thẻ bài đã đánh trong vòng trước vượt quá 3, rút 2 thẻ bài."
  },
  RelicConfig_13907_Desc = {
    Text = "Vào đầu vòng, nếu số lượng thẻ bài đã đánh trong vòng trước vượt quá 3, rút 2 thẻ bài."
  },
  RelicConfig_13907_Name = {
    Text = "<WhiteQuality:ví mới>"
  },
  RelicConfig_13907_StoryDesc = {
    Text = "Ví da được in dấu huy hiệu của Đại học Misag. \nBây giờ bên trong trống rỗng, không có gì cả."
  },
  RelicConfig_13908_BattleDesc = {
    Text = "Sau khi sử dụng \"cơn thịnh nộ bùng phát\", thân thể được đánh thức nhận [Arg1] điểm khí cuồng bạo."
  },
  RelicConfig_13908_Desc = {
    Text = "Sau khi sử dụng \"cơn thịnh nộ bùng phát\", thân thể được đánh thức nhận [Arg1] điểm khí cuồng bạo."
  },
  RelicConfig_13908_Name = {
    Text = "Bức màn của vị thần vô danh bị dị hóa"
  },
  RelicConfig_13909_BattleDesc = {
    Text = "Sau khi kích hoạt cơn điên cuồng, mất 8% sức sống hiện tại, đánh cắp [Arg1] điểm <PowerIconKeywords:lực lượng> tạm thời từ tất cả kẻ địch. Nếu chỉ có 1 kẻ địch, đánh cắp thêm [Arg2] điểm <PowerIconKeywords:lực lượng> tạm thời."
  },
  RelicConfig_13909_Desc = {
    Text = "Sau khi kích hoạt cơn điên cuồng, mất 8% sức sống hiện tại, đánh cắp [Arg1] điểm <PowerIconKeywords:lực lượng> tạm thời từ tất cả kẻ địch. Nếu chỉ có 1 kẻ địch, đánh cắp thêm [Arg2] điểm <PowerIconKeywords:lực lượng> tạm thời."
  },
  RelicConfig_13909_Name = {
    Text = "<RedQuality:chim nghi lễ nguyền rủa>"
  },
  RelicConfig_13909_StoryDesc = {
    Text = "Xác chết khô khan phát ra tiếng kêu thê lương."
  },
  RelicConfig_13910_BattleDesc = {
    Text = "Sau khi bùng nổ cơn thịnh nộ, thân thể được đánh thức tương ứng nhận được 10 điểm điên cuồng và [Arg1] điểm lá chắn."
  },
  RelicConfig_13910_Desc = {
    Text = "Sau khi bùng nổ cơn thịnh nộ, thân thể được đánh thức tương ứng nhận được 10 điểm điên cuồng và [Arg1] điểm lá chắn."
  },
  RelicConfig_13910_Name = {
    Text = "<OrangeQuality:Mặt nạ của Thần Không Tên>"
  },
  RelicConfig_13910_StoryDesc = {
    Text = "Không thể nhìn thẳng vào thần."
  },
  RelicConfig_13911_BattleDesc = {
    Text = "Mỗi lượt, đánh ra thẻ lệnh cuối cùng tương ứng với thân thể được đánh thức, nhận được 20 điên cuồng vào cuối lượt, nếu đồng thời sở hữu sáng tạo \"Tượng Mẹ\", khiến các thân thể được đánh thức khác cũng nhận được 5 điên cuồng."
  },
  RelicConfig_13911_Desc = {
    Text = "Mỗi lượt, đánh ra thẻ lệnh cuối cùng tương ứng với thân thể được đánh thức, nhận được 20 điên cuồng vào cuối lượt, nếu đồng thời sở hữu sáng tạo \"Tượng Mẹ\", khiến các thân thể được đánh thức khác cũng nhận được 5 điên cuồng."
  },
  RelicConfig_13911_Name = {
    Text = "<WhiteQuality:tinh thần hiến dâng>"
  },
  RelicConfig_13911_StoryDesc = {
    Text = "\"Cho bạn, bất cứ thứ gì cũng có thể cho bạn, xin bạn, hãy tha cho tôi.\""
  },
  RelicConfig_13912_BattleDesc = {
    Text = "Khi kết thúc lượt, với mỗi lá bài còn lại, nhận 1 điểm sức tính toán ở đầu lượt sau."
  },
  RelicConfig_13912_Desc = {
    Text = "Khi kết thúc lượt, với mỗi lá bài còn lại, nhận 1 điểm sức tính toán ở đầu lượt sau."
  },
  RelicConfig_13912_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「biểu diễn」>"
  },
  RelicConfig_13913_BattleDesc = {
    Text = "Vào đầu lượt, nếu sức sống lớn hơn [Arg1], mất [Arg1] điểm sức sống, trong lượt đó nhận được [Arg2] điểm <PowerIconKeywords:lực lượng> và [Arg3] điểm <AlertIconKeywords:giữ mình>."
  },
  RelicConfig_13913_Desc = {
    Text = "Vào đầu lượt, nếu sức sống lớn hơn [Arg1], mất [Arg1] điểm sức sống, trong lượt đó nhận được [Arg2] điểm <PowerIconKeywords:lực lượng> và [Arg3] điểm <AlertIconKeywords:giữ mình>."
  },
  RelicConfig_13913_Name = {
    Text = "<RedQuality:tay hỗ trợ>"
  },
  RelicConfig_13913_StoryDesc = {
    Text = "Một phần linh thiêng. \nDù có tách rời khỏi thân thể, vẫn cảm nhận được sự ấm áp dịu dàng trên đó."
  },
  RelicConfig_13914_BattleDesc = {
    Text = "\"Đánh\" nhận được 2 điểm sức tính toán, bỏ ngẫu nhiên 1 lá bài; \"Phòng thủ\" rút 2 lá bài, mất 1 điểm sức tính toán. Mỗi lượt tối đa kích hoạt 3 lần."
  },
  RelicConfig_13914_Desc = {
    Text = "\"Đánh\" nhận được 2 điểm sức tính toán, bỏ ngẫu nhiên 1 lá bài; \"Phòng thủ\" rút 2 lá bài, mất 1 điểm sức tính toán. Mỗi lượt tối đa kích hoạt 3 lần."
  },
  RelicConfig_13914_Name = {
    Text = "<RedQuality:đĩa nhạc vui vẻ>"
  },
  RelicConfig_13914_StoryDesc = {
    Text = "Đĩa hát ghi lại buổi biểu diễn cuối cùng của nghệ sĩ violin nổi tiếng. \nTừ đó trở đi, nó có thể mang lại lửa thiêng."
  },
  RelicConfig_13915_BattleDesc = {
    Text = "Tăng cường hiệu ứng phần thưởng đề xuất lên 50%, khi bắt đầu màn chơi <ProficientInRealmsIconKeywords:giới vực thông thạo> của bạn sẽ được nhân đôi."
  },
  RelicConfig_13915_Desc = {
    Text = "Tăng cường hiệu ứng phần thưởng đề xuất lên 50%, khi bắt đầu màn chơi <ProficientInRealmsIconKeywords:giới vực thông thạo> của bạn sẽ được nhân đôi."
  },
  RelicConfig_13915_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「vào giấc mơ」>"
  },
  RelicConfig_13916_BattleDesc = {
    Text = "Sau khi kích hoạt cơn thịnh nộ bùng phát, lá bài chỉ lệnh tiếp theo đánh ra sẽ có hiệu lực 2 lần."
  },
  RelicConfig_13916_Desc = {
    Text = "Sau khi kích hoạt cơn thịnh nộ bùng phát, lá bài chỉ lệnh tiếp theo đánh ra sẽ có hiệu lực 2 lần."
  },
  RelicConfig_13916_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh 「tiềm du」>"
  },
  RelicConfig_13917_BattleDesc = {
    Text = "Nếu ý định của kẻ địch là tấn công, sau khi gây thương sẽ làm giảm <PowerIconKeywords:lực lượng> tạm thời [Arg1] điểm, nếu không sẽ thêm <BleedingIconKeywords:chảy máu> tương đương 25% thương, mỗi lượt tối đa kích hoạt 6 lần."
  },
  RelicConfig_13917_Desc = {
    Text = "Nếu ý định của kẻ địch là tấn công, sau khi gây thương sẽ làm giảm tạm thời <PowerIconKeywords:lực lượng> [Arg1] điểm, nếu không sẽ thêm <BleedingIconKeywords:chảy máu> tương đương 25% thương, mỗi lượt tối đa kích hoạt 6 lần."
  },
  RelicConfig_13917_Name = {
    Text = "<WhiteQuality:Tâm Dị Hình>"
  },
  RelicConfig_13917_StoryDesc = {
    Text = "Hai \"trái tim\" gắn bó khăng khít."
  },
  RelicConfig_13918_BattleDesc = {
    Text = "Mỗi lần gây thương, nhận được [Arg1] điểm <PowerIconKeywords:lực lượng> tạm thời, tối đa 3 lần. Khi số lớp đạt tối đa, hiệu ứng sẽ tăng gấp đôi."
  },
  RelicConfig_13918_Desc = {
    Text = "Mỗi lần gây thương, nhận được [Arg1] điểm <PowerIconKeywords:lực lượng> tạm thời, tối đa 3 lần. Khi số lớp đạt tối đa, hiệu ứng sẽ tăng gấp đôi."
  },
  RelicConfig_13918_Name = {
    Text = "<WhiteQuality:mã não vân tơ>"
  },
  RelicConfig_13918_StoryDesc = {
    Text = "Đó có lẽ chỉ là hoa văn thạch anh thông thường. Chắc vậy."
  },
  RelicConfig_13919_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:giới vực thông thạo> tăng 50. Khi nhặt, chọn một vật tạo để thay thế bằng vật tạo ngẫu nhiên."
  },
  RelicConfig_13919_Desc = {
    Text = "<ProficientInRealmsIconKeywords:giới vực thông thạo> tăng 50. Khi nhặt, chọn một vật tạo để thay thế bằng vật tạo ngẫu nhiên."
  },
  RelicConfig_13919_Name = {
    Text = "<WhiteQuality:vạn hoa kính>"
  },
  RelicConfig_13919_StoryDesc = {
    Text = "Những suy nghĩ và điều nhìn thấy đều là ảo ảnh."
  },
  RelicConfig_13920_BattleDesc = {
    Text = "Gây hiệu ứng yếu đuối tăng lên 5%. Khi tạo hiệu ứng <WeaknessIconKeywords:yếu đuối>, tạm thời chiếm [Arg1] điểm <PowerIconKeywords:lực lượng> của mục tiêu."
  },
  RelicConfig_13920_Desc = {
    Text = "Gây hiệu ứng yếu đuối tăng lên 5%. Khi tạo hiệu ứng <WeaknessIconKeywords:yếu đuối>, tạm thời chiếm [Arg1] điểm <PowerIconKeywords:lực lượng> của mục tiêu."
  },
  RelicConfig_13920_Name = {
    Text = "<WhiteQuality:hình ảnh mờ nhạt>"
  },
  RelicConfig_13920_StoryDesc = {
    Text = "Hình ảnh mờ ảo chứa đựng ký ức mờ ảo, hay thậm chí — chính sự thiếu hụt của ký ức đã tạo nên sự phai màu của hình ảnh."
  },
  RelicConfig_13921_BattleDesc = {
    Text = "Khi nhặt, chọn 2 thẻ bài lệnh để xóa, nhận được [Arg1] <PowerIconKeywords:lực lượng>."
  },
  RelicConfig_13921_Desc = {
    Text = "Khi nhặt, chọn 2 thẻ bài lệnh để xóa, nhận được [Arg1] <PowerIconKeywords:lực lượng>."
  },
  RelicConfig_13921_Name = {
    Text = "<RedQuality:hắc tinh cháy rụi>"
  },
  RelicConfig_13921_StoryDesc = {
    Text = "Lửa còn chưa tắt."
  },
  RelicConfig_13922_BattleDesc = {
    Text = "Mỗi lượt, sau khi có sự bùng nổ điên cuồng 2 lần, tất cả thân thể được đánh thức nhận thêm 8 điểm điên cuồng; sau lần thứ 3, họ lại nhận thêm 8 điểm."
  },
  RelicConfig_13922_Desc = {
    Text = "Mỗi lượt, sau khi có sự bùng nổ điên cuồng 2 lần, tất cả thân thể được đánh thức nhận thêm 8 điểm điên cuồng; sau lần thứ 3, họ lại nhận thêm 8 điểm."
  },
  RelicConfig_13922_Name = {
    Text = "<OrangeQuality:máu của người bị lãng quên>"
  },
  RelicConfig_13922_StoryDesc = {
    Text = "Ngày càng tan chảy."
  },
  RelicConfig_13923_BattleDesc = {
    Text = "Mỗi lần gây ra 1 điểm thương, tăng [Arg1] điểm lá chắn. Khi bắt đầu lượt, cứ có 3 điểm lá chắn còn lại, nhận được 1 điểm tạm thời <PowerIconKeywords:lực lượng> và thương tổn xúc tu."
  },
  RelicConfig_13923_Desc = {
    Text = "Mỗi lần gây ra 1 điểm thương, tăng [Arg1] điểm lá chắn. Khi bắt đầu lượt, cứ có 3 điểm lá chắn còn lại, nhận được 1 điểm tạm thời <PowerIconKeywords:lực lượng> và thương tổn xúc tu."
  },
  RelicConfig_13923_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「ẩn」>"
  },
  RelicConfig_13924_BattleDesc = {
    Text = "Mỗi khi kích hoạt hiệu ứng <TransitionIconKeywords:nhảy vọt>, đánh cắp [Arg1] điểm <PowerIconKeywords:lực lượng> tạm thời từ tất cả kẻ địch, nếu chỉ có 1 kẻ địch, đánh cắp thêm [Arg2] điểm <PowerIconKeywords:lực lượng> tạm thời."
  },
  RelicConfig_13924_Desc = {
    Text = "Mỗi khi kích hoạt hiệu ứng <TransitionIconKeywords:nhảy vọt>, đánh cắp [Arg1] điểm <PowerIconKeywords:lực lượng> tạm thời từ tất cả kẻ địch, nếu chỉ có 1 kẻ địch, đánh cắp thêm [Arg2] điểm <PowerIconKeywords:lực lượng> tạm thời."
  },
  RelicConfig_13924_Name = {
    Text = "<OrangeQuality:Máy bẻ cong không gian>"
  },
  RelicConfig_13924_StoryDesc = {
    Text = "Nhảy vào hư không."
  },
  RelicConfig_13925_BattleDesc = {
    Text = "Vào đầu lượt, rút 1 thẻ bài. Khi đánh liên tiếp 2 thẻ bài có sức tính toán giống với thẻ bài trước đó, rút thêm 1 thẻ bài, mỗi lượt tối đa có hiệu lực 3 lần."
  },
  RelicConfig_13925_Desc = {
    Text = "Vào đầu lượt, rút 1 thẻ bài. Khi đánh liên tiếp 2 thẻ bài có sức tính toán giống với thẻ bài trước đó, rút thêm 1 thẻ bài, mỗi lượt tối đa có hiệu lực 3 lần."
  },
  RelicConfig_13925_Name = {
    Text = "<OrangeQuality:vạn tượng linh tri thức mật nghi>"
  },
  RelicConfig_13925_StoryDesc = {
    Text = "Toàn tri toàn năng."
  },
  RelicConfig_13926_BattleDesc = {
    Text = "Khi trận chiến bắt đầu, mỗi khi có 1 dấu khắc trong bộ bài, nhận được [Arg1] điểm <PowerIconKeywords:lực lượng>, mỗi khi có 1 sáng tạo, hồi phục [Arg2] điểm sức sống."
  },
  RelicConfig_13926_Desc = {
    Text = "Khi trận chiến bắt đầu, mỗi khi có 1 dấu khắc trong bộ bài, nhận được [Arg1] điểm <PowerIconKeywords:lực lượng>, mỗi khi có 1 sáng tạo, hồi phục [Arg2] điểm sức sống."
  },
  RelicConfig_13926_Name = {
    Text = "<OrangeQuality:☆huy chương buồng thương mại☆>"
  },
  RelicConfig_13926_StoryDesc = {
    Text = "\"Đeo nó lên, bạn sẽ trở thành một thành viên của Hội thương nhân Lentiennam.\""
  },
  RelicConfig_13927_BattleDesc = {
    Text = "Khi nhặt lên, xóa 1 thẻ triệu chứng. Nâng cấp 1 khắcăng ngẫu nhiên lên cao cấp."
  },
  RelicConfig_13927_Desc = {
    Text = "Khi nhặt lên, xóa 1 thẻ triệu chứng. Nâng cấp 1 khắcăng ngẫu nhiên lên cao cấp."
  },
  RelicConfig_13927_Name = {
    Text = "<WhiteQuality:chân thỏ may mắn>"
  },
  RelicConfig_13927_StoryDesc = {
    Text = "Với những chú thỏ, điều này quả thật chẳng may mắn chút nào."
  },
  RelicConfig_13928_BattleDesc = {
    Text = "Tỷ lệ chí mạng tăng 15%. Mỗi lần sử dụng 1 lá bài, tỷ lệ chí mạng tạm thời tăng 5%."
  },
  RelicConfig_13928_Desc = {
    Text = "Tỷ lệ chí mạng tăng 15%. Mỗi lần sử dụng 1 lá bài, tỷ lệ chí mạng tạm thời tăng 5%."
  },
  RelicConfig_13928_Name = {
    Text = "<OrangeQuality:Gương Lễ hội Memphis>"
  },
  RelicConfig_13928_StoryDesc = {
    Text = "\"bạn đã nhìn thấy điều gì?\""
  },
  RelicConfig_13929_BattleDesc = {
    Text = "Mỗi khi bạn mất Sinh lực, nhận được [Arg1] lớp <RetaliateIconKeywords:phản công>. Nếu là lần kích hoạt thứ 3 trong một lượt, kích hoạt <RetaliateIconKeywords:phản công> 100％ lên tất cả kẻ địch."
  },
  RelicConfig_13929_Desc = {
    Text = "Mỗi khi bạn mất Sinh lực, nhận được [Arg1] lớp <RetaliateIconKeywords:phản công>. Nếu là lần kích hoạt thứ 3 trong một lượt, kích hoạt <RetaliateIconKeywords:phản công> 100％ lên tất cả kẻ địch."
  },
  RelicConfig_13929_Name = {
    Text = "<WhiteQuality:chiếc đồng hồ của người đã khuất>"
  },
  RelicConfig_13929_StoryDesc = {
    Text = "Gánh vác nỗi nhớ và cảm thương, tiến về phía trước."
  },
  RelicConfig_13930_BattleDesc = {
    Text = "Khi kết thúc lượt, với mỗi lá bài trên tay, áp dụng [Arg1] lớp <IntoxicationIconKeywords:trúng độc> cho tất cả kẻ địch."
  },
  RelicConfig_13930_Desc = {
    Text = "Khi kết thúc lượt, với mỗi lá bài trên tay, áp dụng [Arg1] lớp <IntoxicationIconKeywords:trúng độc> cho tất cả kẻ địch."
  },
  RelicConfig_13930_Name = {
    Text = "<WhiteQuality:thuốc mỡ đáng ngờ>"
  },
  RelicConfig_13930_StoryDesc = {
    Text = "Một loại thuốc mỡ tự chế để điều trị vết thương, xin đừng sử dụng nếu không có hướng dẫn của bác sĩ."
  },
  RelicConfig_13931_BattleDesc = {
    Text = "Nhặt được [Arg1] <PowerIconKeywords:lực lượng>. Mỗi khi có <DerivativeCardKeywords_2:「phôi thai」> bị hợp nhất, nhận được [Arg2] điểm tạm thời <PowerIconKeywords:lực lượng>."
  },
  RelicConfig_13931_Desc = {
    Text = "Nhặt được [Arg1] <PowerIconKeywords:lực lượng>. Mỗi khi có <DerivativeCardKeywords_2:「phôi thai」> bị hợp nhất, nhận được [Arg2] điểm tạm thời <PowerIconKeywords:lực lượng>."
  },
  RelicConfig_13931_Name = {
    Text = "<WhiteQuality:đá cuội nhuốm máu>"
  },
  RelicConfig_13931_StoryDesc = {
    Text = "Một, hai, ba, bốn, năm."
  },
  RelicConfig_13932_BattleDesc = {
    Text = "Mỗi lần thứ 3 đánh ra \"phòng thủ\", nhận được [Arg1] điểm lá chắn, thân thể được đánh thức tương ứng nhận được 15 điên cuồng."
  },
  RelicConfig_13932_Desc = {
    Text = "Mỗi lần thứ 3 đánh ra \"phòng thủ\", nhận được [Arg1] điểm lá chắn, thân thể được đánh thức tương ứng nhận được 15 điên cuồng."
  },
  RelicConfig_13932_Name = {
    Text = "<WhiteQuality:găng tay im lặng>"
  },
  RelicConfig_13932_StoryDesc = {
    Text = "Chúng từng đẫm đầy máu, nước mắt và nấm mốc."
  },
  RelicConfig_13933_BattleDesc = {
    Text = "Đây là một sáng tạo thay thế hàng tuần 6 không có hiệu ứng"
  },
  RelicConfig_13933_Desc = {
    Text = "Đây là một sáng tạo thay thế hàng tuần 6 không có hiệu ứng"
  },
  RelicConfig_13933_Name = {
    Text = "Sáng tạo thay thế hàng tuần 6"
  },
  RelicConfig_13934_BattleDesc = {
    Text = "Đây là một sáng tạo thay thế hàng tuần số 5, không có hiệu ứng"
  },
  RelicConfig_13934_Desc = {
    Text = "Đây là một sáng tạo thay thế hàng tuần số 5, không có hiệu ứng"
  },
  RelicConfig_13934_Name = {
    Text = "Thử thách hàng ngày tuần tự - sáng tạo 5"
  },
  RelicConfig_13935_BattleDesc = {
    Text = "Tỷ lệ chí mạng tăng 10%. Sau lần chí mạng đầu tiên mỗi lượt, tỷ lệ chí mạng tăng thêm 20%. Sau lần chí mạng thứ 3, thương harming chí mạng tăng thêm 50%."
  },
  RelicConfig_13935_Desc = {
    Text = "Tỷ lệ chí mạng tăng 10%. Sau lần chí mạng đầu tiên mỗi lượt, tỷ lệ chí mạng tăng thêm 20%. Sau lần chí mạng thứ 3, thương harming chí mạng tăng thêm 50%."
  },
  RelicConfig_13935_Name = {
    Text = "<WhiteQuality:lời chúc lễ hội>"
  },
  RelicConfig_13935_StoryDesc = {
    Text = "Nó nên mang lại lời chúc phúc cho những người yêu nhau."
  },
  RelicConfig_13936_BattleDesc = {
    Text = "Đây là sáng tạo thay thế hàng tuần không hiệu ứng 3"
  },
  RelicConfig_13936_Desc = {
    Text = "Đây là sáng tạo thay thế hàng tuần không hiệu ứng 3"
  },
  RelicConfig_13936_Name = {
    Text = "Thử thách hàng ngày: Sáng tạo theo tuần 3"
  },
  RelicConfig_13937_BattleDesc = {
    Text = "Đây là một vật phẩm xoay tua hàng tuần không có hiệu ứng 2"
  },
  RelicConfig_13937_Desc = {
    Text = "Đây là một vật phẩm xoay tua hàng tuần không có hiệu ứng 2"
  },
  RelicConfig_13937_Name = {
    Text = "Thử thách hàng ngày: Sáng tạo thay phiên 2"
  },
  RelicConfig_13938_BattleDesc = {
    Text = "Đây là một sáng tạo không có hiệu ứng 1"
  },
  RelicConfig_13938_Desc = {
    Text = "Đây là một sáng tạo không có hiệu ứng 1"
  },
  RelicConfig_13938_Name = {
    Text = "Thử thách hàng ngày - Hoạt động sáng tạo tuần 1"
  },
  RelicConfig_13939_BattleDesc = {
    Text = "Vào đầu vòng 3, tỷ lệ chí mạng trong trận chiến này tăng 15%, thêm 1 lá bài <DerivativeCardKeywords_39:「tiếng vọng quá khứ」> vào tay."
  },
  RelicConfig_13939_Desc = {
    Text = "Vào đầu vòng 3, tỷ lệ chí mạng trong trận chiến này tăng 15%, thêm 1 lá bài <DerivativeCardKeywords_39:「tiếng vọng quá khứ」> vào tay."
  },
  RelicConfig_13939_Name = {
    Text = "<OrangeQuality:cống phẩm quá khứ>"
  },
  RelicConfig_13939_StoryDesc = {
    Text = "Đồ vật đã từng được dâng lên."
  },
  RelicConfig_13940_BattleDesc = {
    Text = "Khi bạn có lá chắn, sáng tạo này cung cấp [Arg1] điểm lực lượng tạm thời<PowerIconKeywords:lực lượng>. Khi lá chắn của bạn cao hơn sức sống hiện tại, cung cấp thêm [Arg2] điểm lực lượng tạm thời<PowerIconKeywords:lực lượng>."
  },
  RelicConfig_13940_Desc = {
    Text = "Khi bạn có lá chắn, sáng tạo này cung cấp [Arg1] điểm lực lượng tạm thời<PowerIconKeywords:lực lượng>. Khi lá chắn của bạn cao hơn sức sống hiện tại, cung cấp thêm [Arg2] điểm lực lượng tạm thời<PowerIconKeywords:lực lượng>."
  },
  RelicConfig_13940_Name = {
    Text = "<WhiteQuality:cánh quạt bồ câu>"
  },
  RelicConfig_13940_StoryDesc = {
    Text = "Sang trọng, đắt tiền, chỉ là không quá thiết thực."
  },
  RelicConfig_13941_BattleDesc = {
    Text = "\"đánh\" hồi phục [Arg1] điểm sức sống, giảm bớt [Arg1] lớp <IntoxicationIconKeywords:trúng độc>."
  },
  RelicConfig_13941_Desc = {
    Text = "\"đánh\" hồi phục [Arg1] điểm sức sống, giảm bớt [Arg1] lớp <IntoxicationIconKeywords:trúng độc>."
  },
  RelicConfig_13941_Name = {
    Text = "<WhiteQuality:kìm cầm máu>"
  },
  RelicConfig_13941_StoryDesc = {
    Text = "\"Nhanh, nhanh đưa cho tôi!\""
  },
  RelicConfig_13942_BattleDesc = {
    Text = "Mỗi khi có 1 râu chạm, cuối lượt nhận được [Arg1] điểm lá chắn, nếu các râu chạm đang ở trạng thái Biển Yên, hiệu ứng này tăng thêm 50% lá chắn."
  },
  RelicConfig_13942_Desc = {
    Text = "Mỗi khi có 1 râu chạm, cuối lượt nhận được [Arg1] điểm lá chắn, nếu các râu chạm đang ở trạng thái Biển Yên, hiệu ứng này tăng thêm 50% lá chắn."
  },
  RelicConfig_13942_Name = {
    Text = "<WhiteQuality:phụ tùng vô danh>"
  },
  RelicConfig_13942_StoryDesc = {
    Text = "Cẩn thận kẻo bị đâm tay."
  },
  RelicConfig_139929_BattleDesc = {
    Text = "Đầu lượt, Saya nhận được [Arg1] Cuồng Khí. Mỗi 100 điểm Cuồng Khí tiêu hao khi Saya bùng phát cuồng khí sẽ khiến 1 \"Kỹ năng\"được tạo ngẫu nhiên phát động thêm 1 lần."
  },
  RelicConfig_139929_Desc = {
    Text = "Đầu lượt, Saya nhận được [Arg1] Cuồng Khí. Mỗi 100 điểm Cuồng Khí tiêu hao khi Saya bùng phát cuồng khí sẽ khiến 1 \"Kỹ năng\"được tạo ngẫu nhiên phát động thêm 1 lần."
  },
  RelicConfig_139929_Name = {
    Text = "<OrangeQuality:Ảnh Chiều Không Gian·Saya>"
  },
  RelicConfig_140276_BattleDesc = {
    Text = "<OrangeQuality:Tuyệt lộ>:Khi bắt đầu lượt, mỗi 1% sinh mệnh tối đa đã mất, sát thương cuối cùng tạm thời tăng 5%, nếu lượt trước đã kích hoạt kháng tử vong, hiệu ứng này nhân đôi.\n<RedQuality:Chí cao>:Sinh mệnh tối đa của tất cả kẻ địch tăng 300%."
  },
  RelicConfig_140276_Desc = {
    Text = "<OrangeQuality:Tuyệt lộ>:Khi bắt đầu lượt, mỗi 1% sinh mệnh tối đa đã mất, sát thương cuối cùng tạm thời tăng 5%, nếu lượt trước đã kích hoạt kháng tử vong, hiệu ứng này nhân đôi.\n<RedQuality:Chí cao>:Sinh mệnh tối đa của tất cả kẻ địch tăng 300%."
  },
  RelicConfig_140276_Name = {
    Text = "<RedQuality:Con lắc chiều không gian-Tử chiến>"
  },
  RelicConfig_140277_BattleDesc = {
    Text = "<OrangeQuality:Tăng Sinh>: Mỗi lượt, lần đầu tiên mỗi Thức Tỉnh Thể đánh ra \"Kỹ Năng\", tạo 2 bản sao gốc tạm thời của nó. Khi đánh ra thẻ chỉ lệnh có tiêu hao toán lực là 0 hoặc 1, tất cả Thức Tỉnh Thể nhận được 5 điểm Cuồng Khí.\n<RedQuality:Pháo Đài>: Khi đánh ra thẻ bài có tiêu hao toán lực gốc lớn hơn hoặc bằng 3, tất cả kẻ địch nhận được khiên bằng 20% sinh mệnh tối đa."
  },
  RelicConfig_140277_Desc = {
    Text = "<OrangeQuality:Tăng Sinh>: Mỗi lượt, lần đầu tiên mỗi Thức Tỉnh Thể đánh ra \"Kỹ Năng\", tạo 2 bản sao gốc tạm thời của nó. Khi đánh ra thẻ chỉ lệnh có tiêu hao toán lực là 0 hoặc 1, tất cả Thức Tỉnh Thể nhận được 5 điểm Cuồng Khí.\n<RedQuality:Pháo Đài>: Khi đánh ra thẻ bài có tiêu hao toán lực gốc lớn hơn hoặc bằng 3, tất cả kẻ địch nhận được khiên bằng 20% sinh mệnh tối đa."
  },
  RelicConfig_140277_Name = {
    Text = "<RedQuality:Con Lắc Chiều Không Gian - Cảnh Giới>"
  },
  RelicConfig_140278_BattleDesc = {
    Text = "<OrangeQuality:Hồi sinh>:Hiệu quả khiên và hồi phục nhận được tăng 25%. Khi hồi phục sinh mệnh hoặc nhận khiên, mỗi 1% sinh mệnh tối đa được hồi phục hoặc nhận khiên, nhận 10% tăng cường sát thương tạm thời.\n<RedQuality:Thì thầm>:Mỗi lượt nhận hiệu ứng giảm lực lượng bằng 10% sinh mệnh tối đa."
  },
  RelicConfig_140278_Desc = {
    Text = "<OrangeQuality:Hồi sinh>:Hiệu quả khiên và hồi phục nhận được tăng 25%. Khi hồi phục sinh mệnh hoặc nhận khiên, mỗi 1% sinh mệnh tối đa được hồi phục hoặc nhận khiên, nhận 10% tăng cường sát thương tạm thời.\n<RedQuality:Thì thầm>:Mỗi lượt nhận hiệu ứng giảm lực lượng bằng 10% sinh mệnh tối đa."
  },
  RelicConfig_140278_Name = {
    Text = "<RedQuality:Con lắc chiều không gian-Uy hiếp>"
  },
  RelicConfig_140279_BattleDesc = {
    Text = "<OrangeQuality:Bình minh>:Cuồng khí cơ bản của tất cả Giác Tỉnh Thể giảm 30 điểm. Sát thương cuối cùng của Bùng nổ Cuồng khí đầu tiên mỗi lượt tăng 200%, hồi phục khiên và sinh mệnh tăng 100%. Sau mỗi 5 lần phát động Bùng nổ Cuồng khí, chọn 1 Giác Tỉnh Thể để giác tỉnh, đồng thời làm mới hiệu ứng tăng cường Bùng nổ Cuồng khí.\n<RedQuality:Cạn kiệt>:Năng lượng Chìa khóa Bạc cơ bản tăng 200%"
  },
  RelicConfig_140279_Desc = {
    Text = "<OrangeQuality:Bình minh>:Cuồng khí cơ bản của tất cả Giác Tỉnh Thể giảm 30 điểm. Sát thương cuối cùng của Bùng nổ Cuồng khí đầu tiên mỗi lượt tăng 200%, hồi phục khiên và sinh mệnh tăng 100%. Sau mỗi 5 lần phát động Bùng nổ Cuồng khí, chọn 1 Giác Tỉnh Thể để giác tỉnh, đồng thời làm mới hiệu ứng tăng cường Bùng nổ Cuồng khí.\n<RedQuality:Cạn kiệt>:Năng lượng Chìa khóa Bạc cơ bản tăng 200%"
  },
  RelicConfig_140279_Name = {
    Text = "<RedQuality:Con lắc chiều không gian-Quỷ chú>"
  },
  RelicConfig_140280_BattleDesc = {
    Text = "<OrangeQuality:Giác Tỉnh>: Mỗi lượt sau lần đầu tiên kích hoạt Cuồng Khí Bộc Phát, đặt lại thời gian hồi chiêu Cuồng Khí Bộc Phát của Thức Tỉnh Thể đó và cho nó nhận được 50 Cuồng Khí, tạo bản sao tạm thời của tất cả\"Kỹ Năng\" có tiêu hao toán lực là 0 của nó.\n<RedQuality:Phong Ấn>: Mỗi lượt sau lần đầu tiên kích hoạt Cuồng Khí Bộc Phát, phong ấn các Thức Tỉnh Thể khác."
  },
  RelicConfig_140280_Desc = {
    Text = "<OrangeQuality:Giác Tỉnh>: Mỗi lượt sau lần đầu tiên kích hoạt Cuồng Khí Bộc Phát, đặt lại thời gian hồi chiêu Cuồng Khí Bộc Phát của Thức Tỉnh Thể đó và cho nó nhận được 50 Cuồng Khí, tạo bản sao tạm thời của tất cả\"Kỹ Năng\" có tiêu hao toán lực là 0 của nó.\n<RedQuality:Phong Ấn>: Mỗi lượt sau lần đầu tiên kích hoạt Cuồng Khí Bộc Phát, phong ấn các Thức Tỉnh Thể khác."
  },
  RelicConfig_140280_Name = {
    Text = "<RedQuality:Con Lắc Chiều Không Gian - Quyết Đấu>"
  },
  RelicConfig_140281_BattleDesc = {
    Text = "<OrangeQuality:Hồi vang>:Sau khi bắt đầu lượt, rút 3 thẻ chỉ lệnh có toán lực cao nhất trong bộ rút bài, thẻ chỉ lệnh đầu tiên đánh ra mỗi lượt có hiệu lực 2 lần.\n<RedQuality:Choáng váng>:Sau khi đánh ra thẻ chỉ lệnh, bỏ tất cả thẻ chỉ lệnh khác có tiêu hao toán lực không thấp hơn nó."
  },
  RelicConfig_140281_Desc = {
    Text = "<OrangeQuality:Hồi vang>:Sau khi bắt đầu lượt, rút 3 thẻ chỉ lệnh có toán lực cao nhất trong bộ rút bài, thẻ chỉ lệnh đầu tiên đánh ra mỗi lượt có hiệu lực 2 lần.\n<RedQuality:Choáng váng>:Sau khi đánh ra thẻ chỉ lệnh, bỏ tất cả thẻ chỉ lệnh khác có tiêu hao toán lực không thấp hơn nó."
  },
  RelicConfig_140281_Name = {
    Text = "<RedQuality:Con lắc chiều không gian-Hoặc loạn>"
  },
  RelicConfig_140282_BattleDesc = {
    Text = "<OrangeQuality:Vĩ Lực>: <PowerIconKeywords:Lực Lượng> gây ra bởi tất cả Thức Tỉnh Thể tăng 50%, mỗi lần gây sát thương nhận được [Arg2] điểm <PowerIconKeywords:Lực Lượng> tạm thời.\n<RedQuality:Vô Hình>: Khi bắt đầu chiến đấu, tất cả kẻ địch nhận được 50 tầng <ParcloseIconKeywords:Bình Chướng>."
  },
  RelicConfig_140282_Desc = {
    Text = "<OrangeQuality:Vĩ Lực>: <PowerIconKeywords:Lực Lượng> gây ra bởi tất cả Thức Tỉnh Thể tăng 50%, mỗi lần gây sát thương nhận được [Arg2] điểm <PowerIconKeywords:Lực Lượng> tạm thời.\n<RedQuality:Vô Hình>: Khi bắt đầu chiến đấu, tất cả kẻ địch nhận được 50 tầng <ParcloseIconKeywords:Bình Chướng>."
  },
  RelicConfig_140282_Name = {
    Text = "<RedQuality:Con Lắc Chiều Không Gian - Ẩn Nấp>"
  },
  RelicConfig_140840_BattleDesc = {
    Text = "Kích tước tay tối đa +1. Khi bắt đầu chiến đấu tạo ra 1 lá \"<DerivativeCardKeywords_148:驭魇>\" đặt vào tay. Khi chơi \"Đánh cơ bản\" của Thể thức tỉnh, Điểm tính toán của \"<DerivativeCardKeywords_148:驭魇>\" -1, gây [Arg1] điểm Xói mòn cho tất cả kẻ thù. Khi chơi \"Phòng thủ cơ bản\" của Thể thức tỉnh, nhận được [Arg2] điểm Sức mạnh, lần tiếp theo chơi \"<DerivativeCardKeywords_148:驭魇>\" hiệu ứng Sát thương cuối cùng và Sức mạnh tăng [Arg3]%."
  },
  RelicConfig_140840_Desc = {
    Text = "Kích tước tay tối đa +1. Khi bắt đầu chiến đấu tạo ra 1 lá \"<DerivativeCardKeywords_148:驭魇>\" đặt vào tay. Khi chơi \"Đánh cơ bản\" của Thể thức tỉnh, Điểm tính toán của \"<DerivativeCardKeywords_148:驭魇>\" -1, gây [Arg1] điểm Xói mòn cho tất cả kẻ thù. Khi chơi \"Phòng thủ cơ bản\" của Thể thức tỉnh, nhận được [Arg2] điểm Sức mạnh, lần tiếp theo chơi \"<DerivativeCardKeywords_148:驭魇>\" hiệu ứng Sát thương cuối cùng và Sức mạnh tăng [Arg3]%."
  },
  RelicConfig_140840_Name = {
    Text = "Vật Lộn Vô Ích"
  },
  RelicConfig_140840_StoryDesc = {
    Text = "Kẻ vô ích Sợ hãi sự thay đổi, Sợ hãi khi mọi thứ vượt khỏi tầm kiểm soát, ở tầng sâu nhất, hắn hysteria Sợ hãi sự mất mát.\n Hắn lại lại thổi Tiếng Còi, muốn dùng Tiếng Còi để kiểm soát tất cả, nhưng hắn không giữ lại được bất cứ thứ gì."
  },
  RelicConfig_143665_BattleDesc = {
    Text = "Khi bắt đầu lượt, Pontos nhận được [Arg1] điên cuồng. Khi bắt đầu trận chiến tiếp theo sau khi nhặt, tạo ra 3 lá \"Giam Mộng Quỷ\" vĩnh viễn. Khi chơi \"Giam Mộng Quỷ\", Pontos nhận được 3 điểm điên cuồng."
  },
  RelicConfig_143665_Desc = {
    Text = "Khi bắt đầu lượt, Pontos nhận được [Arg1] điên cuồng. Khi bắt đầu trận chiến tiếp theo sau khi nhặt, tạo ra 3 lá \"Giam Mộng Quỷ\" vĩnh viễn. Khi chơi \"Giam Mộng Quỷ\", Pontos nhận được 3 điểm điên cuồng."
  },
  RelicConfig_143665_Name = {
    Text = "<OrangeQuality:Hình Ảnh Chiều·Pontos>"
  },
  RelicConfig_145438_BattleDesc = {
    Text = "Khi bắt đầu lượt, \"Lotan\": Ngư Thần nhận được [Arg1] điểm Điên loạn, \"Ngư Thần Trảm Thế\" khiến đầu lượt tiếp theo kích hoạt Truy đuổi \"Sát Kiếm\": Gây thương cho tất cả kẻ thù bằng 400% Tấn Công của Lotan: Ngư Thần, thương này được hưởng lợi từ tăng Tăng sát thương mà \"Ngư Thần Trảm Thế\" nhận được thông qua \"Đại Kiếm: Kình Lạc\" lần này, được tính là \"Đánh\"."
  },
  RelicConfig_145438_Desc = {
    Text = "Khi bắt đầu lượt, \"Lotan\": Ngư Thần nhận được [Arg1] điểm Điên loạn, \"Ngư Thần Trảm Thế\" khiến đầu lượt tiếp theo kích hoạt Truy đuổi \"Sát Kiếm\": Gây thương cho tất cả kẻ thù bằng 400% Tấn Công của Lotan: Ngư Thần, thương này được hưởng lợi từ tăng Tăng sát thương mà \"Ngư Thần Trảm Thế\" nhận được thông qua \"Đại Kiếm: Kình Lạc\" lần này, được tính là \"Đánh\"."
  },
  RelicConfig_145438_Name = {
    Text = "<OrangeQuality:Hình ảnh chiều·Tử Chiến·Lotan>"
  },
  RelicConfig_146128_BattleDesc = {
    Text = "Kích tước tay tối đa +1. Khi Bắt đầu chiến đấu hoặc sau khi chơi \"<DerivativeCardKeywords_157:Xương Kiếm>\" đặt 1 lá \"<DerivativeCardKeywords_155:Xương Cuồng>\" vào tay, Xáo trộn 1 lá \"<DerivativeCardKeywords_156:Xương Thương>\" vào rút bài từ bộ bài. Nếu trong một lượt chơi đồng thời \"<DerivativeCardKeywords_155:Xương Cuồng>\" và \"<DerivativeCardKeywords_156:Xương Thương>\", hợp nhất hai lá bài đó thành \"<DerivativeCardKeywords_157:Xương Kiếm>\" đặt vào tay."
  },
  RelicConfig_146128_Desc = {
    Text = "Kích tước tay tối đa +1. Khi Bắt đầu chiến đấu hoặc sau khi chơi \"<DerivativeCardKeywords_157:Xương Kiếm>\" đặt 1 lá \"<DerivativeCardKeywords_155:Xương Cuồng>\" vào tay, Xáo trộn 1 lá \"<DerivativeCardKeywords_156:Xương Thương>\" vào rút bài từ bộ bài. Nếu trong một lượt chơi đồng thời \"<DerivativeCardKeywords_155:Xương Cuồng>\" và \"<DerivativeCardKeywords_156:Xương Thương>\", hợp nhất hai lá bài đó thành \"<DerivativeCardKeywords_157:Xương Kiếm>\" đặt vào tay."
  },
  RelicConfig_146128_Name = {
    Text = "Giáp Xương Kình Ngư"
  },
  RelicConfig_146128_StoryDesc = {
    Text = "Xương cốt của Leviathan che chở cho người được Ngài chọn, bách chiến bách thắng, bất tử bất diệt."
  },
  RelicConfig_147547_BattleDesc = {
    Text = "Vào đầu lượt, Kassia nhận được [Arg1] điên cuồng. Mỗi lần rút bài, Kassia nhận thêm [Arg2] điểm điên cuồng. Khi Kassia phát động cơn thịnh nộ, tất cả kẻ địch mất [Arg3] điểm lực lượng."
  },
  RelicConfig_147547_Desc = {
    Text = "Vào đầu lượt, Kassia nhận được [Arg1] điên cuồng. Mỗi lần rút bài, Kassia nhận thêm [Arg2] điểm điên cuồng. Khi Kassia phát động cơn thịnh nộ, tất cả kẻ địch mất [Arg3] điểm lực lượng."
  },
  RelicConfig_147547_Name = {
    Text = "<OrangeQuality:chiều·Kassia>"
  },
  RelicConfig_147665_BattleDesc = {
    Text = "Giới hạn Điểm tính toán và số lượng Rút bài mỗi lượt +1. Khi bắt đầu lượt <FaxianKeywords:phát hiện> 3 \"<Caroboo_Tips:Sô Cô La Đồng Xu của Quý Cô Marie>\" và chọn một. Trong đó chỉ có 1 cái là thật: chọn thật thì nhận hiệu ứng tích cực của nó và xua tan 1 loại trạng thái tiêu cực ngẫu nhiên của bản thân; chọn giả thì chịu hiệu ứng tiêu cực của nó và khiến lần <FaxianKeywords:phát hiện> tiếp theo có thêm +1 lựa chọn thật, hiệu ứng nhân đôi, sau khi chọn thật sẽ đặt lại."
  },
  RelicConfig_147665_Desc = {
    Text = "Giới hạn Điểm tính toán và số lượng Rút bài mỗi lượt +1. Khi bắt đầu lượt <FaxianKeywords:phát hiện> 3 \"<Caroboo_Tips:Sô Cô La Đồng Xu của Quý Cô Marie>\" và chọn một. Trong đó chỉ có 1 cái là thật: chọn thật thì nhận hiệu ứng tích cực của nó và xua tan 1 loại trạng thái tiêu cực ngẫu nhiên của bản thân; chọn giả thì chịu hiệu ứng tiêu cực của nó và khiến lần <FaxianKeywords:phát hiện> tiếp theo có thêm +1 lựa chọn thật, hiệu ứng nhân đôi, sau khi chọn thật sẽ đặt lại."
  },
  RelicConfig_147665_Name = {
    Text = "Sô Cô La Đồng Xu của Quý Cô Marie"
  },
  RelicConfig_147665_StoryDesc = {
    Text = "Ngọt ngào mà quý giá… vậy sao?"
  },
  RelicConfig_148525_BattleDesc = {
    Text = "Đầu lượt, Lời thề·Orci nhận được [Arg1] điểm điên cuồng, \"Ám lưu\" không còn giảm số lượng Rút bài."
  },
  RelicConfig_148525_Desc = {
    Text = "Đầu lượt, Lời thề·Orci nhận được [Arg1] điểm điên cuồng, \"Ám lưu\" không còn giảm số lượng Rút bài."
  },
  RelicConfig_148525_Name = {
    Text = "<OrangeQuality:Hình ảnh chiều·Lời Thề Tối·Orci>"
  },
  RelicConfig_149665_BattleDesc = {
    Text = "Môi trường hiện tại được coi là \"Tuyết Rơi\".\nĐại lục Bắc Tận: Sau giai đoạn Rút bài, áp 1 lớp <SlowIconKeywords:Trì trệ>, <RetainIconKeywords:Giữ lại> lên 2 thẻ lệnh chưa Đóng băng có Điểm tính toán cao nhất trong tay. Khi bất kỳ thẻ lệnh nào có ít nhất 3 lớp <SlowIconKeywords:Trì trệ>, hãy xóa <SlowIconKeywords:Trì trệ> và <RetainIconKeywords:Giữ lại> đã áp trong trận đấu này của nó, \"Đóng băng\" nó và gắn thêm 25 lớp <TempPowerKeywords2:tăng cường>."
  },
  RelicConfig_149665_Desc = {
    Text = "Môi trường hiện tại được coi là \"Tuyết Rơi\".\nĐại lục Bắc Tận: Sau giai đoạn Rút bài, áp 1 lớp <SlowIconKeywords:Trì trệ>, <RetainIconKeywords:Giữ lại> lên 2 thẻ lệnh chưa Đóng băng có Điểm tính toán cao nhất trong tay. Khi bất kỳ thẻ lệnh nào có ít nhất 3 lớp <SlowIconKeywords:Trì trệ>, hãy xóa <SlowIconKeywords:Trì trệ> và <RetainIconKeywords:Giữ lại> đã áp trong trận đấu này của nó, \"Đóng băng\" nó và gắn thêm 25 lớp <TempPowerKeywords2:tăng cường>."
  },
  RelicConfig_149665_Name = {
    Text = "<OrangeQuality:Nhân Tinh Thể Tuyết Rơi>"
  },
  RelicConfig_149665_StoryDesc = {
    Text = "Nó không mang lại cái lạnh.\nNó chỉ nhắc nhở đất đai rằng, mùa đông chưa bao giờ rời đi."
  },
  RelicConfig_20164_BattleDesc = {
    Text = "Mỗi lần gây ra 1 điểm thương, nhận được [Arg1] điểm <PowerIconKeywords:lực lượng> tạm thời, tối đa năm tầng, khi đạt đủ số tầng nhận được [Arg1] điểm <PowerIconKeywords:lực lượng>."
  },
  RelicConfig_20164_Desc = {
    Text = "Mỗi lần gây ra 1 điểm thương, nhận được [Arg1] điểm <PowerIconKeywords:lực lượng> tạm thời, tối đa năm tầng, khi đạt đủ số tầng nhận được [Arg1] điểm <PowerIconKeywords:lực lượng>."
  },
  RelicConfig_20164_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「thức trắng」>"
  },
  RelicConfig_20165_BattleDesc = {
    Text = "Khi nhặt, thức tỉnh tất cả các thân thể được đánh thức. Sau khi đánh <ExaltIconKeywords:Thức tỉnh linh tri thức>, nhận ngẫu nhiên 2 thẻ lệnh liên quan đến thân thể đã được đánh thức và thêm \"tiêu thụ\" và\"hư vô\"."
  },
  RelicConfig_20165_Desc = {
    Text = "Khi nhặt, thức tỉnh tất cả các thân thể được đánh thức. Sau khi đánh <ExaltIconKeywords:Thức tỉnh linh tri thức>, nhận ngẫu nhiên 2 thẻ lệnh liên quan đến thân thể đã được đánh thức và thêm \"tiêu thụ\" và\"hư vô\"."
  },
  RelicConfig_20165_Name = {
    Text = "<OrangeQuality:Thần dụ của Ngài+>"
  },
  RelicConfig_20165_StoryDesc = {
    Text = "Ngài nói, đừng sợ ."
  },
  RelicConfig_20166_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:giới vực thông thạo> tăng 100. Đưa lá bài đầu tiên đánh ra mỗi lượt trở lại tay. Khi bắt đầu lượt siêu việt, giới hạn số lá bài trong tay +5 và sao chép các lá bài trong tay."
  },
  RelicConfig_20166_Desc = {
    Text = "<ProficientInRealmsIconKeywords:giới vực thông thạo> tăng 100. Đưa lá bài đầu tiên đánh ra mỗi lượt từ rác bài trở lại tay. Khi bắt đầu lượt siêu chiều, giới hạn số lá bài trong tay +5 và sao chép các lá bài trong tay, các lá bài sao chép thêm <NothingnessIconKeywords:Hư vô> và <DepleteIconKeywords:tiêu thụ>."
  },
  RelicConfig_20166_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「giấc mơ trộm」>"
  },
  RelicConfig_20167_BattleDesc = {
    Text = "Khi kết thúc lượt, nếu còn dư sức tính toán, lượt tiếp theo sẽ rút thêm 2 lá bài, nếu còn dư bài trong tay, lượt tiếp theo sẽ nhận thêm 2 điểm sức tính toán."
  },
  RelicConfig_20167_Desc = {
    Text = "Khi kết thúc lượt, nếu còn dư sức tính toán, lượt tiếp theo sẽ rút thêm 2 lá bài, nếu còn dư bài trong tay, lượt tiếp theo sẽ nhận thêm 2 điểm sức tính toán."
  },
  RelicConfig_20167_Name = {
    Text = "<OrangeQuality:đĩa quay nhật nguyệt>+"
  },
  RelicConfig_20167_StoryDesc = {
    Text = "Đoán xem, là đen hay trắng?"
  },
  RelicConfig_20168_BattleDesc = {
    Text = "Giới hạn râu chạm +2. Sau khi giải phóng cơn thịnh nộ bùng phát, thương râu chạm +[Arg1]. Nếu trong một lượt đã kích hoạt 3 lần cơn thịnh nộ bùng phát, tất cả râu chạm sẽ được kích hoạt một lần."
  },
  RelicConfig_20168_Desc = {
    Text = "Giới hạn râu chạm +2. Sau khi giải phóng cơn thịnh nộ bùng phát, thương râu chạm +[Arg1]. Nếu trong một lượt đã kích hoạt 3 lần cơn thịnh nộ bùng phát, tất cả râu chạm sẽ được kích hoạt một lần."
  },
  RelicConfig_20168_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh 「ngủ nhẹ」>"
  },
  RelicConfig_20169_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:Giới vực thông thạo> tăng 100. Mỗi khi đánh một lá bài <EmbryoFusionIconKeywords:phôi hợp tử> +10, khi sức sống dưới 25% tăng thành 20. Mỗi lượt tối đa kích hoạt 10 lần."
  },
  RelicConfig_20169_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Giới vực thông thạo> tăng 100. Mỗi khi đánh một lá bài <EmbryoFusionIconKeywords:phôi hợp tử> +10, khi sức sống dưới 25% tăng thành 20. Mỗi lượt tối đa kích hoạt 10 lần."
  },
  RelicConfig_20169_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh 「Sóng Dâng」>"
  },
  RelicConfig_20170_BattleDesc = {
    Text = "Khi trận chiến bắt đầu, tất cả các thân thể được đánh thức nhận được 50 điểm điên cuồng. Đặt 2 lá <DerivativeCardKeywords_1:「dư ảnh hồi vang」> vào tay."
  },
  RelicConfig_20170_Desc = {
    Text = "Khi trận chiến bắt đầu, tất cả các thân thể được đánh thức nhận được 50 điểm điên cuồng. Đặt 2 lá <DerivativeCardKeywords_1:「dư ảnh hồi vang」> vào tay."
  },
  RelicConfig_20170_Name = {
    Text = "<OrangeQuality:thiết bị liên lạc+>"
  },
  RelicConfig_20170_StoryDesc = {
    Text = "Ngóng trông hoặc lo lắng khoảnh khắc nó phát ra tiếng chuông trong trẻo."
  },
  RelicConfig_20171_BattleDesc = {
    Text = "Nhặt được ngẫu nhiên 1 vật tạo bạc, 1 vật tạo vàng, 1 vật bị nguyền rủa."
  },
  RelicConfig_20171_Desc = {
    Text = "Nhặt được ngẫu nhiên 1 vật tạo bạc, 1 vật tạo vàng, 1 vật bị nguyền rủa."
  },
  RelicConfig_20171_Name = {
    Text = "<OrangeQuality:ngược chiều ngắm nhìn+>"
  },
  RelicConfig_20171_StoryDesc = {
    Text = "Trong kỷ nguyên kỳ lạ, hoa mới là những người ngắm nhìn đầu tiên của loài người.\nĐừng động đậy, Họ thích những tác phẩm trưng bày yên tĩnh hơn."
  },
  RelicConfig_20172_BattleDesc = {
    Text = "Mỗi lượt chơi, khi đánh đủ 3 thẻ lệnh, nhận 1 thẻ <DerivativeCardKeywords_4:「cảm hứng」>. Khi đánh đủ 6 thẻ lệnh, nhận thêm 1 thẻ <DerivativeCardKeywords_4:「cảm hứng」>. Khi đánh đủ 10 thẻ lệnh, vào đầu lượt chơi tiếp theo, có thể chọn 2 thẻ từ bộ bài và đưa vào tay bài."
  },
  RelicConfig_20172_Desc = {
    Text = "Mỗi lượt chơi, khi đánh đủ 3 thẻ lệnh, nhận 1 thẻ <DerivativeCardKeywords_4:「cảm hứng」>. Khi đánh đủ 6 thẻ lệnh, nhận thêm 1 thẻ <DerivativeCardKeywords_4:「cảm hứng」>. Khi đánh đủ 10 thẻ lệnh, vào đầu lượt chơi tiếp theo, có thể chọn 2 thẻ từ bộ bài và đưa vào tay bài."
  },
  RelicConfig_20172_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「hiệu ứng」>"
  },
  RelicConfig_20173_BattleDesc = {
    Text = "Thương gây ra cho địch trong trạng thái tiêu cực tăng 50%, sau khi tiêu diệt địch, người tiêu diệt nhận được 100 điên cuồng."
  },
  RelicConfig_20173_Desc = {
    Text = "Thương gây ra cho địch trong trạng thái tiêu cực tăng 50%, sau khi tiêu diệt địch, người tiêu diệt nhận được 100 điên cuồng."
  },
  RelicConfig_20173_Name = {
    Text = "<OrangeQuality:quyền trượng linh mục+>"
  },
  RelicConfig_20173_StoryDesc = {
    Text = "Sự sùng kính không được phép"
  },
  RelicConfig_20174_BattleDesc = {
    Text = "Sau khi nhặt, Khuếch đại sát thương của đội trở thành 150% giá trị gốc. Đầu lượt, gây [Arg1] điểm <FixedDamage:Sát Thương Thuần Túy> lên kẻ địch ngẫu nhiên, mỗi lần sử dụng Mật lệnh trong trận chiến này, sát thương +[Arg2], Tăng Sát Thương này được hưởng bonus Khuếch đại sát thương của đội."
  },
  RelicConfig_20174_Desc = {
    Text = "Sau khi nhặt, Khuếch đại sát thương của đội trở thành 150% giá trị gốc. Đầu lượt, gây [Arg1] điểm <FixedDamage:Sát Thương Thuần Túy> lên kẻ địch ngẫu nhiên, mỗi lần sử dụng Mật lệnh trong trận chiến này, sát thương +[Arg2], Tăng Sát Thương này được hưởng bonus Khuếch đại sát thương của đội."
  },
  RelicConfig_20174_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh 「mất tích」>"
  },
  RelicConfig_20175_BattleDesc = {
    Text = "Gây hiệu ứng <WeaknessIconKeywords:suy nhược> tăng lên 8%, hiệu ứng <VulnerabilityIconKeywords:trọng thương> tăng lên 25%. Khi áp dụng <WeaknessIconKeywords:suy nhược> hoặc <VulnerabilityIconKeywords:trọng thương>, tạm thời trộm cắp [Arg1] điểm <PowerIconKeywords:lực lượng> của mục tiêu."
  },
  RelicConfig_20175_Desc = {
    Text = "Gây hiệu ứng <WeaknessIconKeywords:suy nhược> tăng lên 8%, hiệu ứng <VulnerabilityIconKeywords:trọng thương> tăng lên 25%. Khi áp đặt <WeaknessIconKeywords:suy nhược> hoặc <VulnerabilityIconKeywords:trọng thương>, tạm thời trộm cắp [Arg1] điểm <PowerIconKeywords:lực lượng> của mục tiêu."
  },
  RelicConfig_20175_Name = {
    Text = "<OrangeQuality:ảnh phai màu+>"
  },
  RelicConfig_20175_StoryDesc = {
    Text = "Hình ảnh mờ ảo chứa đựng ký ức mờ ảo, hay thậm chí — chính sự thiếu hụt của ký ức đã tạo nên sự phai màu của hình ảnh."
  },
  RelicConfig_20176_BattleDesc = {
    Text = "Mỗi khi bắt đầu lượt, nhận 2 sức tính toán cho mỗi kẻ địch. Khi tiêu diệt kẻ địch bằng tấn công chủ động, gây <BleedingIconKeywords:chảy máu> với lượng thương vượt quá gấp đôi cho các kẻ địch khác."
  },
  RelicConfig_20176_Desc = {
    Text = "Mỗi khi bắt đầu lượt, nhận 2 sức tính toán cho mỗi kẻ địch. Khi tiêu diệt kẻ địch bằng tấn công chủ động, gây <BleedingIconKeywords:chảy máu> với lượng thương vượt quá gấp đôi cho các kẻ địch khác."
  },
  RelicConfig_20176_Name = {
    Text = "<OrangeQuality:bài hát của bọn du thủ+>"
  },
  RelicConfig_20176_StoryDesc = {
    Text = "Để hành hạ đôi tai của bạn."
  },
  RelicConfig_20177_BattleDesc = {
    Text = "Sau khi nhặt, kháng cự tử vong tăng gấp đôi. Sau khi gây thương, sẽ áp dụng <BleedingIconKeywords:chảy máu> tương đương 50% sát thương lên mục tiêu. Mỗi lần kích hoạt kháng cự tử vong, máu chảy của tất cả kẻ thù sẽ ngay lập tức kích hoạt 1 lần."
  },
  RelicConfig_20177_Desc = {
    Text = "Sau khi nhặt, kháng cự tử vong tăng gấp đôi. Sau khi gây thương, sẽ áp dụng <BleedingIconKeywords:chảy máu> tương đương 50% sát thương lên mục tiêu. Mỗi lần kích hoạt kháng cự tử vong, chảy máu của tất cả kẻ địch sẽ ngay lập tức kích hoạt 1 lần."
  },
  RelicConfig_20177_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「hồi sinh」>"
  },
  RelicConfig_20178_BattleDesc = {
    Text = "Mỗi lần gây 1 sát thương chủ động, nhận 3 điểm điên cuồng và áp dụng [Arg1] lớp <IntoxicationIconKeywords:ngộ độc> lên mục tiêu. Nếu tổng số lần kích hoạt trong trận chiến này đạt 25 lần, ngay lập tức áp dụng <IntoxicationIconKeywords:ngộ độc> cho tất cả kẻ địch."
  },
  RelicConfig_20178_Desc = {
    Text = "Mỗi lần gây 1 sát thương chủ động, nhận 3 điểm điên cuồng và áp dụng [Arg1] lớp <IntoxicationIconKeywords:ngộ độc> lên mục tiêu. Nếu tổng số lần kích hoạt trong trận chiến này đạt 25 lần, ngay lập tức áp dụng <IntoxicationIconKeywords:ngộ độc> cho tất cả kẻ địch."
  },
  RelicConfig_20178_Name = {
    Text = "<OrangeQuality:máy may phủ bụi+>"
  },
  RelicConfig_20178_StoryDesc = {
    Text = "Một người mẹ hiền từ, hàn gắn những vết thương trong trái tim."
  },
  RelicConfig_21906_BattleDesc = {
    Text = "\"tấn công\" nhận được 3 điểm sức tính toán, bỏ ngẫu nhiên 1 lá bài; \"phòng thủ\" rút 3 lá bài, mất 1 điểm sức tính toán."
  },
  RelicConfig_21906_Desc = {
    Text = "\"tấn công\" nhận được 3 điểm sức tính toán, bỏ ngẫu nhiên 1 lá bài; \"phòng thủ\" rút 3 lá bài, mất 1 điểm sức tính toán."
  },
  RelicConfig_21906_Name = {
    Text = "<RedQuality:bản ghi vui vẻ+>"
  },
  RelicConfig_21906_StoryDesc = {
    Text = "Đĩa hát ghi lại buổi biểu diễn cuối cùng của nghệ sĩ violin nổi tiếng. \nTừ đó trở đi, nó có thể mang lại lửa thiêng."
  },
  RelicConfig_23688_BattleDesc = {
    Text = "Mỗi lần kích hoạt tiêu thụ, nhận được 30 điểm <EmbryoFusionIconKeywords: dung hợp phôi thai> và [Arg1] điểm <PowerIconKeywords:lực lượng>. Nếu kích hoạt lần thứ 2 trong 1 lượt, nhận 1 điểm sức tính toán, rút 1 lá bài; nếu kích hoạt lần thứ 3 trong 1 lượt, nhận 2 điểm sức tính toán, rút 2 lá bài."
  },
  RelicConfig_23688_Desc = {
    Text = "Mỗi khi kích hoạt 1 lần tiêu thụ, nhận 30 điểm <EmbryoFusionIconKeywords:Dung hợp Phôi thai> và [Arg1] điểm <PowerIconKeywords:lực lượng>. Nếu kích hoạt lần thứ 2 trong 1 lượt, nhận 1 điểm sức tính toán, rút 1 lá bài; nếu kích hoạt lần thứ 3 trong 1 lượt, nhận 2 điểm sức tính toán, rút 2 lá bài."
  },
  RelicConfig_23688_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「phản phệ」>"
  },
  RelicConfig_23689_BattleDesc = {
    Text = "Sau khi nhặt được, tất cả thể thức tỉnh nhận được 30 điểm điên cuồng. Mỗi lần giải phóng cơn bùng nổ điên cuồng tăng 1 điểm đếm. Sau khi giải phóng mật lệnh, nhận được [Arg1] điểm giữ mình tạm thời, [Arg2] điểm tạm thời <PowerIconKeywords:lực lượng> và tất cả thể thức tỉnh nhận được 6 điểm điên cuồng, tiêu thụ tất cả điểm đếm, mỗi điểm đếm có hiệu lực thêm 1 lần."
  },
  RelicConfig_23689_Desc = {
    Text = "Sau khi nhặt được, tất cả thể thức tỉnh nhận được 30 điểm điên cuồng. Mỗi lần phát động bùng nổ điên cuồng sẽ tăng 1 điểm số. Sau khi giải phóng mật lệnh, nhận được [Arg1] điểm giữ mình tạm thời, [Arg2] điểm tạm thời <PowerIconKeywords:lực lượng> và tất cả thể thức tỉnh nhận được 6 điểm điên cuồng, tiêu thụ tất cả số điểm, mỗi điểm số sẽ có hiệu lực thêm 1 lần."
  },
  RelicConfig_23689_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「chứa lực」>"
  },
  RelicConfig_23690_BattleDesc = {
    Text = "Mỗi lần nhận thêm 1 điểm sức tính toán hoặc rút thêm 1 lá bài, trộm cắp [Arg1] điểm <PowerIconKeywords:lực lượng> từ tất cả kẻ địch, nhận 4% tỷ lệ chí mạng tạm thời, hiệu ứng trong trận chiến Élite hoặc Lãnh đạo sẽ gấp đôi. Sau khi bắt đầu Vòng Siêu Chiều, nhận [Arg2] điểm <PowerIconKeywords:lực lượng>, sát thương chí mạng tăng +15%."
  },
  RelicConfig_23690_Desc = {
    Text = "Mỗi lần nhận thêm 1 điểm sức tính toán hoặc rút thêm 1 lá bài, trộm cắp [Arg1] điểm <PowerIconKeywords:lực lượng> từ tất cả kẻ địch, nhận 4% tỷ lệ chí mạng tạm thời, hiệu ứng trong trận chiến Élite hoặc Lãnh đạo sẽ được nhân đôi. Sau khi bắt đầu vòng Siêu Chiều, nhận [Arg2] điểm <PowerIconKeywords:lực lượng>, sát thương chí mạng tăng +15%."
  },
  RelicConfig_23690_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh 「khe hở」>"
  },
  RelicConfig_23691_BattleDesc = {
    Text = "Cứ mỗi 5 lần gây thương, hồi [Arg1] điểm sức sống. Mỗi lần mất 1 điểm sức sống, thương tổn xúc tu +[Arg2]. Nếu mất sức sống vượt quá [Arg3] điểm, kích hoạt tất cả xúc tu một lần."
  },
  RelicConfig_23691_Desc = {
    Text = "Mỗi 5 lần gây thương, phục hồi [Arg1] máu. Mỗi lần mất 1 điểm sức sống, sát thương xúc tu tăng thêm [Arg2]. Nếu mất hơn 10% máu tối đa, kích hoạt toàn bộ xúc tu một lần."
  },
  RelicConfig_23691_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh 「Dâng Tràn」>"
  },
  RelicConfig_35135_BattleDesc = {
    Text = "Mỗi lần gây ra 1 điểm thương, nhận được [Arg1] điểm <PowerIconKeywords:lực lượng> tạm thời và [Arg2] điểm thiệt hại tạm thời của xúc tu, mỗi lượt tối đa kích hoạt 12 lần. Nếu trong 1 lượt gây ra 4 điểm thương, áp dụng 1 lớp trọng thương cho tất cả kẻ địch và nhận được [Arg3] điểm lá chắn, nếu gây ra 8 điểm thương, áp dụng 1 lớp suy nhược cho tất cả kẻ địch và hồi phục [Arg3] điểm sinh lực."
  },
  RelicConfig_35135_Desc = {
    Text = "Mỗi lần gây ra 1 điểm thương, nhận được [Arg1] điểm tạm thời <PowerIconKeywords:lực lượng> và [Arg2] điểm thiệt hại tạm thời của xúc tu, mỗi lượt tối đa kích hoạt 12 lần. Nếu trong 1 lượt gây ra 4 điểm thương, áp dụng 1 lớp trọng thương cho tất cả kẻ địch và nhận [Arg3] điểm lá chắn, nếu gây ra 8 điểm thương, áp dụng 1 lớp suy nhược cho tất cả kẻ địch và hồi [Arg3] điểm sinh lực."
  },
  RelicConfig_35135_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「mê đắm」>"
  },
  RelicConfig_35136_BattleDesc = {
    Text = "\"Đánh\" gây thương và \"phòng thủ\" tăng lá chắn thêm 30%. Nếu trong 1 lượt sử dụng 4 lá hoặc nhiều hơn \"Đánh\" và \"phòng thủ\", vào đầu lượt tiếp theo, rút 2 lá bài và nhận được 1 điểm sức tính toán."
  },
  RelicConfig_35136_Desc = {
    Text = "\"Đánh\" gây thương và \"phòng thủ\" tăng lá chắn thêm 30%. Nếu trong 1 lượt sử dụng 4 lá hoặc nhiều hơn \"Đánh\" và \"phòng thủ\", vào đầu lượt tiếp theo, rút 2 lá bài và nhận được 1 điểm sức tính toán."
  },
  RelicConfig_35136_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh 「cố chấp」>"
  },
  RelicConfig_35137_BattleDesc = {
    Text = "Mỗi khi chơi 1 thẻ bài, nhận [Arg1] điểm tạm thời <PowerIconKeywords:lực lượng> và hồi phục [Arg2] điểm sinh lực. Sau khi gây sát thương chủ động, loại bỏ [Arg2] điểm <PowerIconKeywords:lực lượng> mà di vật đó nhận được. Thể thức tỉnh mỗi khi giết một kẻ địch, nhận 30 điểm điên cuồng."
  },
  RelicConfig_35137_Desc = {
    Text = "Mỗi khi chơi 1 thẻ bài, nhận [Arg1] điểm tạm thời <PowerIconKeywords:lực lượng> và hồi phục [Arg2] điểm sinh lực, sau khi gây sát thương chủ động sẽ loại bỏ [Arg2] điểm <PowerIconKeywords:lực lượng> mà Di vật đó nhận được. Thể thức tỉnh mỗi khi giết một kẻ địch, nhận 30 điểm điên cuồng."
  },
  RelicConfig_35137_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「dự trữ」>"
  },
  RelicConfig_35138_BattleDesc = {
    Text = "Sau khi phát động cơn điên cuồng bùng nổ, áp dụng [Arg1] điểm ngộ độc lên kẻ địch ngẫu nhiên, mỗi khi chơi 1 thẻ lệnh, nhận [Arg2] điểm phản công tạm thời. Cuối mỗi 4 lượt, gây ra sát thương tương đương tổng số lớp ngộ độc của kẻ địch và số lớp phản công của bản thân lên tất cả kẻ địch."
  },
  RelicConfig_35138_Desc = {
    Text = "Sau khi giải phóng cơn điên cuồng bùng phát, áp dụng [Arg1] điểm ngộ độc lên kẻ thù ngẫu nhiên, mỗi khi chơi 1 thẻ lệnh, nhận được [Arg2] điểm phản công tạm thời. Cuối mỗi 4 lượt, gây sát thương tương đương tổng số lớp trúng độc của kẻ thù và lớp phản công của bản thân lên tất cả kẻ thù."
  },
  RelicConfig_35138_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「lan tràn」>"
  },
  RelicConfig_35139_BattleDesc = {
    Text = "Sau khi nhặt, sát thương của đội tăng mạnh 30%. Mỗi lần gây sát thương thứ 4 chắc chắn chí mạng và thương harming chí mạng tăng 50%, nếu lần gây sát thương này tiêu diệt mục tiêu, nhận được 5 điểm dấu đen."
  },
  RelicConfig_35139_Desc = {
    Text = "Sau khi nhặt, sát thương của đội tăng mạnh 30%. Mỗi lần gây sát thương thứ 4 chắc chắn chí mạng và thương harming chí mạng tăng 50%, nếu lần gây sát thương này tiêu diệt mục tiêu, nhận được 5 điểm dấu đen."
  },
  RelicConfig_35139_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「điểm kết」>"
  },
  RelicConfig_36823_BattleDesc = {
    Text = "Phóng thích bùng nổ điên cuồng sau đó rút 1 thẻ bài. Mỗi lần bỏ 1 thẻ bài, tất cả các thể thức tỉnh nhận được 3 điểm điên cuồng, tối đa 15 điểm mỗi lượt."
  },
  RelicConfig_36823_Desc = {
    Text = "Phóng thích bùng nổ điên cuồng sau đó rút 1 thẻ bài. Mỗi lần bỏ 1 thẻ bài, tất cả các thể thức tỉnh nhận được 3 điểm điên cuồng, tối đa 15 điểm mỗi lượt."
  },
  RelicConfig_36823_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「qua lại」>"
  },
  RelicConfig_36824_BattleDesc = {
    Text = "Mỗi lần tiêu thụ sức tính toán, rút 1 lá bài, mỗi lượt tối đa 5 lần. Mỗi khi bộ bài được đặt lại, nhận 2 điểm sức tính toán."
  },
  RelicConfig_36824_Desc = {
    Text = "Mỗi lần tiêu thụ sức tính toán, rút 1 lá bài, mỗi lượt tối đa 5 lần. Mỗi khi bộ bài được đặt lại, nhận 2 điểm sức tính toán."
  },
  RelicConfig_36824_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「không ngủ」>"
  },
  RelicConfig_39302_BattleDesc = {
    Text = "Mỗi khi gây thương 4 lần, sẽ trộn 1 lá <DerivativeCardKeywords_4:「cảm hứng」> vào rút bài từ bộ bài, mỗi lượt tối đa kích hoạt 3 lần. Sau khi kích hoạt điên cuồng bùng phát, đánh ra và tiêu thụ tất cả các lá <DerivativeCardKeywords_4:「cảm hứng」> trong bộ bài."
  },
  RelicConfig_39302_Desc = {
    Text = "Mỗi khi gây thương 4 lần, sẽ trộn 1 lá <DerivativeCardKeywords_4:「cảm hứng」> vào rút bài từ bộ bài, mỗi lượt tối đa kích hoạt 3 lần. Sau khi kích hoạt điên cuồng bùng phát, đánh ra và tiêu thụ tất cả các lá <DerivativeCardKeywords_4:「cảm hứng」> trong bộ bài."
  },
  RelicConfig_39302_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh 「Mê Mộng」>"
  },
  RelicConfig_39303_BattleDesc = {
    Text = "Khi điểm tính toán hiện tại là số lẻ, coi như có thêm [Arg2] điểm Giữ mình tạm thời. Khi điểm tính toán hiện tại là số chẵn, coi như có thêm [Arg1] điểm <PowerIconKeywords:lực lượng> tạm thời và [Arg3] điểm thiệt hại xúc tu tạm thời. Cứ mỗi vật tạo vàng mà bạn sở hữu, hiệu ứng của vật này tăng 50%, và mỗi vật bị nguyền rủa mà bạn sở hữu, tăng 80%."
  },
  RelicConfig_39303_Desc = {
    Text = "Khi điểm tính toán hiện tại là số lẻ, coi như bạn có thêm [Arg2] điểm Giữ mình tạm thời. Khi điểm tính toán hiện tại là số chẵn, coi như bạn có thêm [Arg1] điểm <PowerIconKeywords:lực lượng> tạm thời và [Arg3] điểm thiệt hại xúc tu tạm thời. Mỗi khi bạn sở hữu 1 vật tạo vàng, hiệu ứng của vật này tăng 50%, mỗi khi sở hữu 1 vật bị nguyền rủa, tăng 80%."
  },
  RelicConfig_39303_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「kinh mộng」>"
  },
  RelicConfig_44192_BattleDesc = {
    Text = "Mỗi đầu vòng, tất cả các thân thể được đánh thức nhận được 20 cuồng nộ. Khi nhặt, làm giảm một nửa lượng máu tối đa."
  },
  RelicConfig_44192_Desc = {
    Text = "Mỗi đầu vòng, tất cả các thân thể được đánh thức nhận được 20 cuồng nộ. Khi nhặt, làm giảm một nửa lượng máu tối đa."
  },
  RelicConfig_44192_Name = {
    Text = "<RedQuality:ác mộng · biểu tượng tội lỗi>"
  },
  RelicConfig_44192_StoryDesc = {
    Text = "Giấc ngủ sâu buông thả chính là dục vọng, sẽ nuốt chửng mọi thứ khi bạn không hay biết."
  },
  RelicConfig_44300_BattleDesc = {
    Text = "Mỗi đầu lượt, tất cả các thân thể được đánh thức nhận được 25 điên cuồng. Khi nhặt lên, máu tối đa tăng lên 3 lần."
  },
  RelicConfig_44300_Desc = {
    Text = "Mỗi đầu lượt, tất cả các thân thể được đánh thức nhận được 25 điên cuồng. Khi nhặt lên, máu tối đa tăng lên 3 lần."
  },
  RelicConfig_44300_Name = {
    Text = "<OrangeQuality:được chúc · biểu hiện ác mộng>"
  },
  RelicConfig_44300_StoryDesc = {
    Text = "Không cần sợ hãi, không cần do dự. Đây chỉ là giấc mơ thoáng qua, ánh sáng của Đấng Tối Cao vẫn chiếu rọi trên ngươi."
  },
  RelicConfig_44592_BattleDesc = {
    Text = "Sau khi trận chiến kết thúc, nhận được 100 dấu đen và 2 thẻ triệu chứng."
  },
  RelicConfig_44592_Desc = {
    Text = "Sau khi trận chiến kết thúc, nhận được 100 dấu đen và 2 thẻ triệu chứng."
  },
  RelicConfig_44592_Name = {
    Text = "<RedQuality:phạm tội·ấn ngọc bích>"
  },
  RelicConfig_44592_StoryDesc = {
    Text = "Tội lỗi từ thời xa xưa đã được khắc sâu tại nơi này."
  },
  RelicConfig_44593_BattleDesc = {
    Text = "Khi nhặt lên, biến hình thành 1 vật sáng tạo Tội lỗi ngẫu nhiên khác bản thân và nhận 75 dấu đen."
  },
  RelicConfig_44593_Desc = {
    Text = "Khi nhặt lên, biến hình thành 1 vật sáng tạo Tội lỗi ngẫu nhiên khác bản thân và nhận 75 dấu đen."
  },
  RelicConfig_44593_Name = {
    Text = "<RedQuality:Tội lỗi·Đá bia nguyền rủa>"
  },
  RelicConfig_44593_StoryDesc = {
    Text = "Nghe này, có ai đó đang gọi từ bên trong!"
  },
  RelicConfig_44594_BattleDesc = {
    Text = "Mỗi 2 lượt, tăng gấp đôi sát thương chủ động và xúc tay mà tất cả kẻ địch phải chịu. Tuy nhiên, trong lượt này, mỗi lần kích hoạt cơn thịnh nộ bùng phát, phong ấn tất cả thân thể được đánh thức trong 1 lượt và tự mình trở nên trọng thương."
  },
  RelicConfig_44594_Desc = {
    Text = "Mỗi 2 lượt, tăng gấp đôi sát thương chủ động và xúc tay mà tất cả kẻ địch phải chịu. Tuy nhiên, trong lượt này, mỗi lần kích hoạt cơn thịnh nộ bùng phát, phong ấn tất cả thân thể được đánh thức trong 1 lượt và tự mình trở nên trọng thương."
  },
  RelicConfig_44594_Name = {
    Text = "<RedQuality:Tội Ác·Hành Đạo Chi Hài>"
  },
  RelicConfig_44594_StoryDesc = {
    Text = "Một phần thiêng liêng. \nSau khi tách khỏi thân thể, nó đã bị tội lỗi ngấm sâu."
  },
  RelicConfig_44597_BattleDesc = {
    Text = "Mỗi lần gây sát thương chủ động, sẽ áp dụng [Arg1] lớp <BleedingIconKeywords:chảy máu> cho bản thân, và áp dụng [Arg2] lớp <BleedingIconKeywords:chảy máu> cho mục tiêu bị thương."
  },
  RelicConfig_44597_Desc = {
    Text = "Mỗi lần gây sát thương chủ động, sẽ áp dụng [Arg1] lớp <BleedingIconKeywords:chảy máu> cho bản thân, và áp dụng [Arg2] lớp <BleedingIconKeywords:chảy máu> cho mục tiêu bị thương."
  },
  RelicConfig_44597_Name = {
    Text = "<RedQuality:tội lỗi·ý thức bầy đàn>"
  },
  RelicConfig_44597_StoryDesc = {
    Text = "Bị cuốn vào, sự cộng sinh, sự quần tụ; sợ hãi, điều chưa biết, kiểm soát."
  },
  RelicConfig_44598_BattleDesc = {
    Text = "Sau khi kích hoạt cơn thịnh nộ bùng phát, mất 12% sức sống hiện tại, trộm cắp [Arg1] điểm <PowerIconKeywords:lực lượng> tạm thời từ tất cả kẻ địch. Nếu chỉ có 1 kẻ địch, trộm cắp thêm [Arg2] điểm <PowerIconKeywords:lực lượng> tạm thời."
  },
  RelicConfig_44598_Desc = {
    Text = "Sau khi kích hoạt cơn thịnh nộ bùng phát, mất 12% sức sống hiện tại, trộm cắp [Arg1] điểm <PowerIconKeywords:lực lượng> tạm thời từ tất cả kẻ địch. Nếu chỉ có 1 kẻ địch, trộm cắp thêm [Arg2] điểm <PowerIconKeywords:lực lượng> tạm thời."
  },
  RelicConfig_44598_Name = {
    Text = "<RedQuality:chim nghi thức tội lỗi·họa>"
  },
  RelicConfig_44598_StoryDesc = {
    Text = "Cái sinh linh đáng thương chết vì tham lam, cất lên những lời cáo buộc sắc lạnh từ lồng ngực héo hon."
  },
  RelicConfig_44603_BattleDesc = {
    Text = "Giới hạn số thẻ bài trong tay tăng lên 5, khi bắt đầu chiến đấu rút 6 thẻ bài. Cuối lượt, bỏ tất cả các thẻ triệu chứng và thẻ trạng thái trong tay, giữ lại các thẻ bài khác, nhưng số thẻ bài rút mỗi lượt giảm đi 2."
  },
  RelicConfig_44603_Desc = {
    Text = "Giới hạn số thẻ bài trong tay tăng lên 5, khi bắt đầu chiến đấu rút 6 thẻ bài. Cuối lượt, bỏ tất cả các thẻ triệu chứng và thẻ trạng thái trong tay, giữ lại các thẻ bài khác, nhưng số thẻ bài rút mỗi lượt giảm đi 2."
  },
  RelicConfig_44603_Name = {
    Text = "<RedQuality:ý thức · khắc tội>"
  },
  RelicConfig_44603_StoryDesc = {
    Text = "Kẻ tham lam xem người khác như công cụ, rút niềm vui của mình từ nỗi thống khổ của họ."
  },
  RelicConfig_44608_BattleDesc = {
    Text = "Sau khi nhặt, mất vĩnh viễn [Arg1] <PowerIconKeywords:lực lượng>. Mỗi khi gây sát thương, hồi [Arg2] điểm sức sống, tối đa 6 lần mỗi lượt."
  },
  RelicConfig_44608_Desc = {
    Text = "Sau khi nhặt, mất vĩnh viễn [Arg1] <PowerIconKeywords:lực lượng>. Mỗi khi gây sát thương, hồi [Arg2] điểm sức sống, tối đa 6 lần mỗi lượt."
  },
  RelicConfig_44608_Name = {
    Text = "<RedQuality:trái tội lỗi · nụ hôn của thất thê lam>"
  },
  RelicConfig_44608_StoryDesc = {
    Text = "Nụ hôn của nó sẽ khiến bạn chìm đắm—— dĩ nhiên, người chìm đắm cũng có thể là chính bạn."
  },
  RelicConfig_44609_BattleDesc = {
    Text = "Tăng tối đa sức tính toán thêm 3. Mỗi lần đặt lại bộ bài, thêm 2 lá <DerivativeCardKeywords_9:「lảo đảo」> vào rút bài từ bộ bài."
  },
  RelicConfig_44609_Desc = {
    Text = "Tăng tối đa sức tính toán thêm 3. Mỗi lần đặt lại bộ bài, thêm 2 lá <DerivativeCardKeywords_9:「lảo đảo」> vào rút bài từ bộ bài."
  },
  RelicConfig_44609_Name = {
    Text = "<RedQuality:trọng tội·nến đen>"
  },
  RelicConfig_44609_StoryDesc = {
    Text = "Thiêu đốt lý trí, sa ngã vào điên cuồng."
  },
  RelicConfig_44610_BattleDesc = {
    Text = "Tỷ lệ chí mạng và thương chí mạng tăng 50%, mỗi khi bắt đầu lượt, <FragileIconKeywords:yếu đuối> bản thân trong 1 lượt."
  },
  RelicConfig_44610_Desc = {
    Text = "Tỷ lệ chí mạng và thương chí mạng tăng 50%, mỗi khi bắt đầu lượt, <FragileIconKeywords:yếu đuối> bản thân trong 1 lượt."
  },
  RelicConfig_44610_Name = {
    Text = "<RedQuality:tội lỗi·móc quái dị>"
  },
  RelicConfig_44610_StoryDesc = {
    Text = "Bàn tay bị dục vọng bóp méo."
  },
  RelicConfig_44654_BattleDesc = {
    Text = "Sức tính toán tối đa tăng 4, mỗi lần đặt lại bộ bài sẽ thêm 4 lá <DerivativeCardKeywords_4:「cảm hứng」> vào rút bài từ bộ bài."
  },
  RelicConfig_44654_Desc = {
    Text = "Sức tính toán tối đa tăng 4, mỗi lần đặt lại bộ bài sẽ thêm 4 lá <DerivativeCardKeywords_4:「cảm hứng」> vào rút bài từ bộ bài."
  },
  RelicConfig_44654_Name = {
    Text = "<OrangeQuality:được chúc·nến đen>"
  },
  RelicConfig_44654_StoryDesc = {
    Text = "Thiêu đốt khát vọng, đạt được sự cứu rỗi."
  },
  RelicConfig_44656_BattleDesc = {
    Text = "Giới hạn sáng tạo +[Arg1], \"dấu vết tan chảy\" số lần làm mới +1. Sau khi chiến đấu kết thúc, nhận được 125 dấu đen, khi nhặt có thể chọn xóa tối đa 6 thẻ triệu chứng."
  },
  RelicConfig_44656_Desc = {
    Text = "Giới hạn sáng tạo +[Arg1], \"dấu vết tan chảy\" số lần làm mới +1. Sau khi chiến đấu kết thúc, nhận được 125 dấu đen, khi nhặt có thể chọn xóa tối đa 6 thẻ triệu chứng."
  },
  RelicConfig_44656_Name = {
    Text = "<OrangeQuality:Thụ Chúc·Ngọc Bích Khắc Ấn>"
  },
  RelicConfig_44656_StoryDesc = {
    Text = "Sự cứu rỗi của Thần Cha đã xóa bỏ nỗi đau."
  },
  RelicConfig_44658_BattleDesc = {
    Text = "Sau khi kích hoạt cơn thịnh nộ bùng phát, nhận [Arg1] điểm lực lượng tạm thời và đánh cắp [Arg1] điểm <PowerIconKeywords:lực lượng> từ tất cả kẻ địch. Nếu chỉ có 1 kẻ địch, đánh cắp thêm [Arg2] điểm <PowerIconKeywords:lực lượng>."
  },
  RelicConfig_44658_Desc = {
    Text = "Sau khi kích hoạt cơn thịnh nộ bùng phát, nhận [Arg1] điểm lực lượng tạm thời và đánh cắp [Arg1] điểm <PowerIconKeywords:lực lượng> từ tất cả kẻ địch. Nếu chỉ có 1 kẻ địch, đánh cắp thêm [Arg2] điểm <PowerIconKeywords:lực lượng>."
  },
  RelicConfig_44658_Name = {
    Text = "<OrangeQuality:Được chúc phúc·Chim nghi lễ tai họa>"
  },
  RelicConfig_44658_StoryDesc = {
    Text = "Ánh sáng của sự tha thứ bao trùm lên vết tích của lòng tham, những con chim chết đã có thể hát bài ca cuối cùng."
  },
  RelicConfig_44659_BattleDesc = {
    Text = "Mỗi lần gây sát thương, hồi [Arg1] sức sống và áp dụng [Arg2] lớp <BleedingIconKeywords:chảy máu> cho mục tiêu bị thương."
  },
  RelicConfig_44659_Desc = {
    Text = "Mỗi lần gây sát thương, hồi [Arg1] sức sống và áp dụng [Arg2] lớp <BleedingIconKeywords:chảy máu> cho mục tiêu bị thương."
  },
  RelicConfig_44659_Name = {
    Text = "<OrangeQuality:được ban phước·ý thức bầy sâu>"
  },
  RelicConfig_44659_StoryDesc = {
    Text = "Bị cuốn vào, cộng sinh, tập hợp; đoàn kết, đồng tồn, che chở."
  },
  RelicConfig_44660_BattleDesc = {
    Text = "Giới hạn thẻ bài trên tay tăng 5, bổ sung thẻ bài lên giới hạn khi bắt đầu chiến đấu. Vào đầu lượt, rút thêm 1 thẻ, và vào cuối lượt, bỏ đi tất cả các thẻ triệu chứng và thẻ trạng thái trong tay, giữ lại các thẻ khác."
  },
  RelicConfig_44660_Desc = {
    Text = "Giới hạn thẻ bài trên tay tăng 5, bổ sung thẻ bài lên giới hạn khi bắt đầu chiến đấu. Vào đầu lượt, rút thêm 1 thẻ, và vào cuối lượt, bỏ đi tất cả các thẻ triệu chứng và thẻ trạng thái trong tay, giữ lại các thẻ khác."
  },
  RelicConfig_44660_Name = {
    Text = "<OrangeQuality:được chúc·ý thức khắc ghi>"
  },
  RelicConfig_44660_StoryDesc = {
    Text = "Người tham lam khắc ghi lỗi lầm của mình trong tâm và cố gắng chuộc tội cho quá khứ của mình."
  },
  RelicConfig_44662_BattleDesc = {
    Text = "Mỗi 2 lượt, tăng gấp đôi sát thương chủ động và xúc tay mà tất cả kẻ địch phải chịu. Trong lượt này, mỗi lần kích hoạt cơn thịnh nộ bùng phát, ngẫu nhiên loại bỏ 1 trạng thái tiêu cực."
  },
  RelicConfig_44662_Desc = {
    Text = "Mỗi 2 lượt, tăng gấp đôi sát thương chủ động và xúc tay mà tất cả kẻ địch phải chịu. Trong lượt này, mỗi lần kích hoạt cơn thịnh nộ bùng phát, ngẫu nhiên loại bỏ 1 trạng thái tiêu cực."
  },
  RelicConfig_44662_Name = {
    Text = "<OrangeQuality:thân cốt được chúc phúc·hành đạo>"
  },
  RelicConfig_44662_StoryDesc = {
    Text = "Một phần thiêng liêng. \nDù có tách khỏi thân thể, dấu chân của nó đã in dấu chân trên khắp mọi miền."
  },
  RelicConfig_44663_BattleDesc = {
    Text = "Tỷ lệ chí mạng tăng 50%, thương harming chí mạng tăng 100%."
  },
  RelicConfig_44663_Desc = {
    Text = "Tỷ lệ chí mạng tăng 50%, thương harming chí mạng tăng 100%."
  },
  RelicConfig_44663_Name = {
    Text = "<OrangeQuality:được chúc · cái móc kỳ quái>"
  },
  RelicConfig_44663_StoryDesc = {
    Text = "Mọi dục vọng đã buông bỏ."
  },
  RelicConfig_44664_BattleDesc = {
    Text = "Nhặt được sẽ nhận vĩnh viễn [Arg1] <PowerIconKeywords:lực lượng>. Mỗi khi gây thương, phục hồi [Arg2] điểm sức sống, mỗi lượt có thể kích hoạt tối đa 6 lần."
  },
  RelicConfig_44664_Desc = {
    Text = "Nhặt được sẽ nhận vĩnh viễn [Arg1] <PowerIconKeywords:lực lượng>. Mỗi khi gây thương, phục hồi [Arg2] điểm sức sống, mỗi lượt có thể kích hoạt tối đa 6 lần."
  },
  RelicConfig_44664_Name = {
    Text = "<OrangeQuality:Chúc Phép·Nụ Hôn Của Đuôi Bảy Mang>"
  },
  RelicConfig_44664_StoryDesc = {
    Text = "Từ chối nụ hôn tụt dốc này đi, vòng tay của Cha Trời ấm áp hơn mọi bóng tối."
  },
  RelicConfig_47444_BattleDesc = {
    Text = "\"Đánh\" và \"Phòng thủ\" nhận thêm 50 điểm năng lượng chìa khóa bạc. Mỗi khi bạn đánh 1 thẻ bài có sức tính toán tiêu thụ là 2 hoặc cao hơn, rút 1 thẻ bài có sức tính toán tiêu thụ là 1 và giảm sức tính toán tiêu thụ của nó xuống 0. Tối đa 3 lần mỗi lượt."
  },
  RelicConfig_47444_Desc = {
    Text = "\"Đánh\" và \"Phòng thủ\" nhận thêm 50 điểm năng lượng chìa khóa bạc. Mỗi khi bạn đánh 1 thẻ bài có sức tính toán tiêu thụ là 2 hoặc cao hơn, rút 1 thẻ bài có sức tính toán tiêu thụ là 1 và giảm sức tính toán tiêu thụ của nó xuống 0. Tối đa 3 lần mỗi lượt."
  },
  RelicConfig_47444_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「Hai Sinh Mệnh」>"
  },
  RelicConfig_50338_BattleDesc = {
    Text = "Khi trận chiến bắt đầu, hãy trộn tất cả các <ExaltIconKeywords:Thức tỉnh linh tri> của thân thể được đánh thức vào bộ bài. Bắt đầu từ lượt thứ 6, Thái Di Sơ sẽ cung cấp hỗ trợ chiến đấu mỗi lượt."
  },
  RelicConfig_50338_Desc = {
    Text = "Khi trận chiến bắt đầu, hãy trộn tất cả các <ExaltIconKeywords:Thức tỉnh linh tri> của thân thể được đánh thức vào bộ bài. Bắt đầu từ lượt thứ 6, Thái Di Sơ sẽ cung cấp hỗ trợ chiến đấu mỗi lượt."
  },
  RelicConfig_50338_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「mê đắm tình」>"
  },
  RelicConfig_50338_StoryDesc = {
    Text = "Ngài nói, đừng sợ ."
  },
  RelicConfig_50385_BattleDesc = {
    Text = "Nhặt lên và chọn một thẻ bài, giảm tiêu thụ sức tính toán của nó xuống còn 1 vĩnh viễn."
  },
  RelicConfig_50385_Desc = {
    Text = "Nhặt lên và chọn một thẻ bài, giảm tiêu thụ sức tính toán của nó xuống còn 1 vĩnh viễn."
  },
  RelicConfig_50385_Name = {
    Text = "<WhiteQuality:☆còng kinh cạn kiệt☆>"
  },
  RelicConfig_50385_StoryDesc = {
    Text = "Mất đi nguồn nước quý giá nhất ở sa mạc, đôi mắt của cô đã cạn kiệt."
  },
  RelicConfig_50487_BattleDesc = {
    Text = "Khi bắt đầu lượt chiến đấu đầu tiên, thêm <DerivativeCardKeywords_46:「Prion」> vào tay; lượt thứ 3, thêm <DerivativeCardKeywords_49:「Đòn tấn công vô độ」> vào tay; sau khi kích hoạt kháng cự tử vong, thêm <DerivativeCardKeywords_52:「Kén phục sinh」> vào tay."
  },
  RelicConfig_50487_Desc = {
    Text = "Khi bắt đầu lượt chiến đấu đầu tiên, thêm <DerivativeCardKeywords_46:「Prion」> vào tay; lượt thứ 3, thêm <DerivativeCardKeywords_49:「Đòn tấn công vô độ」> vào tay; sau khi kích hoạt kháng cự tử vong, thêm <DerivativeCardKeywords_52:「Kén phục sinh」> vào tay."
  },
  RelicConfig_50487_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「phước lành」>"
  },
  RelicConfig_50488_BattleDesc = {
    Text = "Khi kết thúc lượt: Thể thức tỉnh có điên cuồng thấp nhất nhận được 35 điểm điên cuồng. Nếu số máu còn lại ≥ 50%, nhận [Arg1] điểm <PowerIconKeywords:lực lượng>. Nếu số máu còn lại < 50%, hồi phục [Arg2] điểm sinh lực."
  },
  RelicConfig_50488_Desc = {
    Text = "Khi kết thúc lượt: Thân thể thức tỉnh có điên cuồng thấp nhất nhận được 35 điểm điên cuồng. Nếu sinh lực hiện tại không thấp hơn 50%, nhận [Arg1] điểm <PowerIconKeywords:lực lượng>. Nếu sinh lực hiện tại thấp hơn 50%, hồi phục [Arg2] điểm sinh lực."
  },
  RelicConfig_50488_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「cân bằng」>"
  },
  RelicConfig_50489_BattleDesc = {
    Text = "Tỉ lệ chí mạng và thương tổn bạo kích tăng 100%. Mỗi lần gây ra 1 thương, tất cả các thân thể được đánh thức có tỉ lệ chí mạng và thương tổn bạo kích giảm 10%, tối đa giảm 50%. Mỗi lần gây ra 1 thương, ngộ độc và phản công gây ra trong lượt này tăng 10%, tối đa tăng đến 50%."
  },
  RelicConfig_50489_Desc = {
    Text = "Tỉ lệ chí mạng và sát thương chí mạng tăng 100%. Mỗi lần gây sát thương/thương tổn xúc tu, trong lượt này: tất cả thể thức tỉnh sẽ giảm 10% sát thương bạo kích, tối đa giảm 50%. Sát thương gây ra do ngộ độc và phản công tăng 10%, tối đa tăng 50%."
  },
  RelicConfig_50489_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「dịch dũng」>"
  },
  RelicConfig_51686_BattleDesc = {
    Text = "Mỗi khi đánh ra một thẻ lệnh thuộc thân thể được đánh thức khác với thẻ lệnh trước đó, thân thể được đánh thức đó sẽ nhận được 3 điểm điên cuồng và tích lũy 1 lớp \"hoạt tính\". Khi tích lũy đủ 10 lớp, tất cả các lớp \"hoạt tính\" sẽ bị xóa, và mỗi thân thể được đánh thức sẽ đưa vào tay một thẻ lệnh ngẫu nhiên có sức tính toán giảm 1 và mang thuộc tính \"tiêu thụ\". Hiệu ứng này chỉ có thể kích hoạt tối đa 1 lần mỗi lượt."
  },
  RelicConfig_51686_Desc = {
    Text = "Mỗi khi đánh ra một thẻ lệnh thuộc thân thể được đánh thức khác với thẻ lệnh trước đó, thân thể được đánh thức đó sẽ nhận được 3 điểm điên cuồng và tích lũy 1 lớp \"hoạt tính\". Khi tích lũy đủ 10 lớp, tất cả các lớp \"hoạt tính\" sẽ bị xóa, và mỗi thân thể được đánh thức sẽ đưa vào tay một thẻ lệnh ngẫu nhiên có sức tính toán giảm 1 và mang thuộc tính \"tiêu thụ\". Hiệu ứng này chỉ có thể kích hoạt tối đa 1 lần mỗi lượt."
  },
  RelicConfig_51686_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「diễn hóa」>"
  },
  RelicConfig_51687_BattleDesc = {
    Text = "Sau khi sử dụng một thẻ lệnh không phải là \"đánh\" hoặc \"phòng thủ\", nếu thẻ bài này không phải là thẻ dẫn xuất, thân thể được đánh thức tương ứng sẽ nhận được 15 điểm điên cuồng, mỗi lượt tối đa kích hoạt 5 lần. Lần đầu tiên kích hoạt mỗi lượt, thẻ bài đã sử dụng cũng sẽ được chuyển về tay."
  },
  RelicConfig_51687_Desc = {
    Text = "Thẻ lệnh không phải là \"Đánh\" hoặc \"Phòng thủ\" khi được chơi, nếu thẻ bài này không phải là thẻ phái sinh, Thể thức tỉnh tương ứng sẽ nhận được 15 điểm điên cuồng, mỗi lượt tối đa kích hoạt 5 lần. Lần kích hoạt đầu tiên trong mỗi lượt, thẻ bài đã chơi sẽ được trả về tay."
  },
  RelicConfig_51687_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「phép chiếu」>"
  },
  RelicConfig_51688_BattleDesc = {
    Text = "Khi nhặt, thêm \"giữ lại\" vào tất cả các thẻ lệnh. Khi kết thúc lượt, nếu số lượng thẻ trong tay lớn hơn hoặc bằng 5, giảm 1 điểm tiêu thụ sức tính toán của 3 thẻ ngẫu nhiên, ngược lại rút 3 thẻ."
  },
  RelicConfig_51688_Desc = {
    Text = "Khi nhặt, thêm \"giữ lại\" vào tất cả các thẻ lệnh. Khi kết thúc lượt, nếu số lượng thẻ trong tay lớn hơn hoặc bằng 5, giảm 1 điểm tiêu thụ sức tính toán của 3 thẻ ngẫu nhiên, ngược lại rút 3 thẻ."
  },
  RelicConfig_51688_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「giường ấm」>"
  },
  RelicConfig_51689_BattleDesc = {
    Text = "Vào bắt đầu trận đấu, đặt 3 thẻ triệu chứng ngẫu nhiên vào bộ bài. Vào đầu lượt, rút 1 lá bài. Mỗi khi chơi 1 thẻ triệu chứng, nhận 2 điểm sức tính toán. Mỗi khi bỏ 1 thẻ triệu chứng, tất cả thể thức tỉnh nhận được 5 điểm điên cuồng, mỗi lượt tối đa tích lũy kích hoạt 5 lần."
  },
  RelicConfig_51689_Desc = {
    Text = "Vào lúc bắt đầu chiến đấu, đặt 3 thẻ triệu chứng ngẫu nhiên vào bộ bài. Vào đầu lượt, rút 1 lá bài. Mỗi khi chơi 1 thẻ triệu chứng, nhận 2 điểm sức tính toán. Mỗi khi bỏ 1 thẻ triệu chứng, tất cả thể thức tỉnh nhận được 5 điểm điên cuồng, tối đa có thể kích hoạt 5 lần trong mỗi lượt."
  },
  RelicConfig_51689_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「dịch bệnh」>"
  },
  RelicConfig_55847_BattleDesc = {
    Text = "Bộ trang bị chuẩn mực 7 món vật phẩm sáng tạo cho trận mô phỏng"
  },
  RelicConfig_55847_Desc = {
    Text = "Bộ trang bị chuẩn mực 7 món vật phẩm sáng tạo cho trận mô phỏng"
  },
  RelicConfig_55847_Name = {
    Text = "<RedQuality:☆Chiến Trường Giả Lập☆>"
  },
  RelicConfig_55847_StoryDesc = {
    Text = "Trong kỷ nguyên kỳ lạ, hoa mới là những người ngắm nhìn đầu tiên của loài người.\nĐừng động đậy, Họ thích những tác phẩm trưng bày yên tĩnh hơn."
  },
  RelicConfig_55874_BattleDesc = {
    Text = "Sau khi trận chiến kết thúc, nhận được [Arg1] lớp \"Bút Mực\", khi \"Bút Mực\"đạt 2 lớp sẽ tiêu thụ, ngẫu nhiên đặt 1 lá \"Ý Tượng\" vào bộ bài."
  },
  RelicConfig_55874_Desc = {
    Text = "Sau khi trận chiến kết thúc, nhận được [Arg1] lớp \"Bút Mực\", khi \"Bút Mực\"đạt 2 lớp sẽ tiêu thụ, ngẫu nhiên đặt 1 lá \"Ý Tượng\" vào bộ bài."
  },
  RelicConfig_55874_Name = {
    Text = "<OrangeQuality:Bút và mực của Ôrla>"
  },
  RelicConfig_55874_StoryDesc = {
    Text = "Tội lỗi từ thời xa xưa đã được khắc sâu tại nơi này."
  },
  RelicConfig_56355_BattleDesc = {
    Text = "Giới hạn bài trong tay +2, đầu mỗi lượt, rút 1 bài. Sau khi trận đấu kết thúc, nhận [Arg1] lớp \"Bút Mực\", khi \"Bút Mực\"đạt 2 lớp, tiêu thụ và chọn đặt 1 lá \"Ý Tượng\" vào bộ bài."
  },
  RelicConfig_56355_Desc = {
    Text = "Giới hạn bài trong tay +2, đầu mỗi lượt, rút 1 bài. Sau khi trận đấu kết thúc, nhận [Arg1] lớp \"Bút Mực\", khi \"Bút Mực\"đạt 2 lớp, tiêu thụ và chọn đặt 1 lá \"Ý Tượng\" vào bộ bài."
  },
  RelicConfig_56355_Name = {
    Text = "<OrangeQuality:Bút và mực của Ôrla>"
  },
  RelicConfig_56355_StoryDesc = {
    Text = "Tội lỗi từ thời xa xưa đã được khắc sâu tại nơi này."
  },
  RelicConfig_56356_BattleDesc = {
    Text = "Sau khi chiến đấu kết thúc, nhận được [Arg1] lớp \"Bút Mực\", khi \"Bút Mực\"đạt 2 lớp thì tiêu thụ. Chọn để đặt 1 lá \"Ý Tượng\" vào bộ bài."
  },
  RelicConfig_56356_Desc = {
    Text = "Sau khi chiến đấu kết thúc, nhận được [Arg1] lớp \"Bút Mực\", khi \"Bút Mực\"đạt 2 lớp thì tiêu thụ. Chọn để đặt 1 lá \"Ý Tượng\" vào bộ bài."
  },
  RelicConfig_56356_Name = {
    Text = "<OrangeQuality:Bút và mực của Ôrla>"
  },
  RelicConfig_56356_StoryDesc = {
    Text = "Tội lỗi từ thời xa xưa đã được khắc sâu tại nơi này."
  },
  RelicConfig_57667_BattleDesc = {
    Text = "Ban đầu sở hữu 2 lớp Quyền năng của Mẹ Thần, sau lượt thứ ba, mỗi khi bắt đầu lượt có thể chọn tiêu thụ Quyền năng của Mẹ Thần để nhận được hiệu ứng khác nhau hoặc trả lời Quyền năng của Mẹ Thần. Nếu nhận sát thương chí mạng, sẽ hồi sinh và tiêu thụ toàn bộ Quyền năng của Mẹ Thần, mỗi lớp hồi phục 10% sinh lực, chỉ có thể có hiệu lực 1 lần."
  },
  RelicConfig_57667_Desc = {
    Text = "Ban đầu có 2 lớp Quyền năng của Mẹ Thần, sau lượt thứ ba, mỗi khi bắt đầu lượt có thể chọn tiêu thụ Quyền năng của Mẹ Thần để nhận hiệu ứng khác nhau hoặc trả lời Quyền năng của Mẹ Thần. Nếu nhận sát thương chí mạng, sẽ phục sinh và tiêu thụ toàn bộ Quyền năng của Mẹ Thần, mỗi lớp hồi phục 10% sinh lực, chỉ có thể có hiệu lực 1 lần."
  },
  RelicConfig_57667_Name = {
    Text = "<OrangeQuality:sự bảo hộ của Thần Mẫu>"
  },
  RelicConfig_57732_BattleDesc = {
    Text = "Tất cả các thân thể được đánh thức có tỷ lệ chí mạng tăng 15%. Kết quả cuối cùng của hiệu ứng ngẫu nhiên từ Lắc và các con xúc xắc tăng 1."
  },
  RelicConfig_57732_Desc = {
    Text = "Tất cả các thân thể được đánh thức có tỷ lệ chí mạng tăng 15%. Kết quả cuối cùng của hiệu ứng ngẫu nhiên từ Lắc và các con xúc xắc tăng 1."
  },
  RelicConfig_57732_Name = {
    Text = "<OrangeQuality:áo khoác may mắn hạng sang>"
  },
  RelicConfig_57732_StoryDesc = {
    Text = "Nó sẽ dựng lên một bức rào chắn dày, ngăn mưa gió và vận xui ở bên ngoài."
  },
  RelicConfig_57733_BattleDesc = {
    Text = "Vào đầu lượt và khi kích hoạt hiệu ứng ngẫu nhiên của Lắc hoặc xúc xắc, nhận được 100 điểm năng lượng chìa khóa bạc và 4% sát thương chí mạng, tối đa 50% sát thương chí mạng, mất hiệu lực khi kết thúc chiến đấu."
  },
  RelicConfig_57733_Desc = {
    Text = "Vào đầu lượt và khi kích hoạt hiệu ứng ngẫu nhiên của Lắc hoặc xúc xắc, nhận được 100 điểm năng lượng chìa khóa bạc và 4% sát thương chí mạng, tối đa 50% sát thương chí mạng, mất hiệu lực khi kết thúc chiến đấu."
  },
  RelicConfig_57733_Name = {
    Text = "<OrangeQuality:nút miệng lớn tinh xảo>"
  },
  RelicConfig_57733_StoryDesc = {
    Text = "Nút Miệng Lớn yêu thích mọi thứ tròn trĩnh, ví dụ như mặt trăng, xèng và nhãn cầu tươi.\nSẽ phun sương đen vào đêm trăng tròn, nguyên nhân không rõ."
  },
  RelicConfig_57734_BattleDesc = {
    Text = "Mỗi khi sử dụng lệnh khóa, sẽ thêm 1 lá \"xúc xắc chiếu sáng\" vào tay."
  },
  RelicConfig_57734_Desc = {
    Text = "Mỗi khi sử dụng lệnh khóa, sẽ thêm 1 lá \"xúc xắc chiếu sáng\" vào tay."
  },
  RelicConfig_57734_Name = {
    Text = "<OrangeQuality:dice ánh sáng định hướng>"
  },
  RelicConfig_57734_StoryDesc = {
    Text = "Lấp lánh không chỉ là vẻ bề ngoài, mà còn là trái tim kiên cường bất khuất.\nNhìn chằm chằm vào nó quá năm giây, bạn sẽ thu hút @2."
  },
  RelicConfig_57735_BattleDesc = {
    Text = "Vào đầu lượt và khi kích hoạt hiệu ứng ngẫu nhiên của Lắc hoặc xúc xắc, nhận được 50 điểm năng lượng chìa khóa bạc và 2% sát thương chí mạng, tối đa 30% sát thương chí mạng, mất hiệu lực khi kết thúc chiến đấu."
  },
  RelicConfig_57735_Desc = {
    Text = "Vào đầu lượt và khi kích hoạt hiệu ứng ngẫu nhiên của Lắc hoặc xúc xắc, nhận được 50 điểm năng lượng chìa khóa bạc và 2% sát thương chí mạng, tối đa 30% sát thương chí mạng, mất hiệu lực khi kết thúc chiến đấu."
  },
  RelicConfig_57735_Name = {
    Text = "<OrangeQuality:khúc cúc lớn>"
  },
  RelicConfig_57735_StoryDesc = {
    Text = "Nút Miệng Lớn yêu thích mọi thứ tròn trĩnh, ví dụ như mặt trăng, xèng và nhãn cầu tươi.\nSẽ phun sương đen vào đêm trăng tròn, nguyên nhân không rõ."
  },
  RelicConfig_57736_BattleDesc = {
    Text = "Mỗi khi sử dụng lệnh khóa, sẽ đặt 1 lá \"bình phương xúc xắc\" vào tay."
  },
  RelicConfig_57736_Desc = {
    Text = "Mỗi khi sử dụng lệnh khóa, sẽ đặt 1 lá \"bình phương xúc xắc\" vào tay."
  },
  RelicConfig_57736_Name = {
    Text = "<OrangeQuality:xúc xắc thiên vị>"
  },
  RelicConfig_57736_StoryDesc = {
    Text = "Lấp lánh không chỉ là vẻ bề ngoài, mà còn là trái tim kiên cường bất khuất.\nNhìn chằm chằm vào nó quá năm giây, bạn sẽ thu hút @2."
  },
  RelicConfig_57737_BattleDesc = {
    Text = "Tất cả thân thể được đánh thức có tỷ lệ chí mạng tăng 10%. Tất cả các hiệu ứng ngẫu nhiên của Lắc và xúc xắc sẽ không bao giờ đạt giá trị thấp nhất."
  },
  RelicConfig_57737_Desc = {
    Text = "Tất cả thân thể được đánh thức có tỷ lệ chí mạng tăng 10%. Tất cả các hiệu ứng ngẫu nhiên của Lắc và xúc xắc sẽ không bao giờ đạt giá trị thấp nhất."
  },
  RelicConfig_57737_Name = {
    Text = "<OrangeQuality:áo gió may mắn>"
  },
  RelicConfig_57737_StoryDesc = {
    Text = "Nó sẽ dựng lên một bức rào chắn dày, ngăn mưa gió và vận xui ở bên ngoài."
  },
  RelicConfig_57791_BattleDesc = {
    Text = "Giới hạn sáng tạo +1. Trong năm vòng đầu tiên sau khi chiến đấu bắt đầu, mỗi vòng sẽ nhận được một sáng tạo, bao gồm \"Móc Cài Đá Ruby, Đá Mã Não Cuộn, Tín Hiệu Cầu Cứu, Chim Nghi Lễ Xui Xẻo, Bàn Lắc Thời Linh·nhập mê\"."
  },
  RelicConfig_57791_Desc = {
    Text = "Giới hạn sáng tạo +1. Trong năm vòng đầu tiên sau khi chiến đấu bắt đầu, mỗi vòng sẽ nhận được một sáng tạo, bao gồm \"Móc Cài Đá Ruby, Đá Mã Não Cuộn, Tín Hiệu Cầu Cứu, Chim Nghi Lễ Xui Xẻo, Bàn Lắc Thời Linh·nhập mê\"."
  },
  RelicConfig_57791_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「kho báu tàu đắm」>"
  },
  RelicConfig_57791_StoryDesc = {
    Text = "Truyền thuyết cho rằng Lemuria đã sụp đổ trong vùng biển này. Ai có thể kiềm chế không đi khám phá bí mật của kho báu đắm tàu?"
  },
  RelicConfig_57792_BattleDesc = {
    Text = "Giới hạn sáng tạo +1. Trong năm vòng đầu tiên sau khi chiến đấu bắt đầu, mỗi vòng sẽ nhận được một sáng tạo, có \"dòng nĩa, kẹp tem xứ lạ, ghi chép Arcana, khắc dấu ý thức, bàn lắc thời linh·tích lũy\"."
  },
  RelicConfig_57792_Desc = {
    Text = "Giới hạn sáng tạo +1. Trong năm vòng đầu tiên sau khi chiến đấu bắt đầu, mỗi vòng sẽ nhận được một sáng tạo, có \"dòng nĩa, kẹp tem xứ lạ, ghi chép Arcana, khắc dấu ý thức, bàn lắc thời linh·tích lũy\"."
  },
  RelicConfig_57792_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「kho báu tàu đắm」>"
  },
  RelicConfig_57792_StoryDesc = {
    Text = "Truyền thuyết cho rằng Lemuria đã sụp đổ trong vùng biển này. Ai có thể kiềm chế không đi khám phá bí mật của kho báu đắm tàu?"
  },
  RelicConfig_57793_BattleDesc = {
    Text = "Giới hạn sáng tạo +1. Trong năm vòng đầu tiên sau khi chiến đấu bắt đầu, mỗi vòng sẽ nhận được một sáng tạo, có \"Hàm xương tia laser, Kem thuốc đáng ngờ, Máy khâu bụi bẩn, Họng lưỡi dị chủng, Bàn lắc thời linh · Dòng chảy dịch chuyển\"."
  },
  RelicConfig_57793_Desc = {
    Text = "Giới hạn sáng tạo +1. Trong năm vòng đầu tiên sau khi chiến đấu bắt đầu, mỗi vòng sẽ nhận được một sáng tạo, có \"Hàm xương tia laser, Kem thuốc đáng ngờ, Máy khâu bụi bẩn, Họng lưỡi dị chủng, Bàn lắc thời linh · Dòng chảy dịch chuyển\"."
  },
  RelicConfig_57793_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「kho báu tàu đắm」>"
  },
  RelicConfig_57793_StoryDesc = {
    Text = "Truyền thuyết cho rằng Lemuria đã sụp đổ trong vùng biển này. Ai có thể kiềm chế không đi khám phá bí mật của kho báu đắm tàu?"
  },
  RelicConfig_57794_BattleDesc = {
    Text = "Giới hạn sáng tạo +1. Trong năm vòng đầu tiên sau khi chiến đấu bắt đầu, mỗi vòng sẽ nhận được một sáng tạo, có \"Áo giáp gaidây gai, Đồng hồ bỏ túi của ngườingười quen cũ, Đoạn vănTiên tích đoạn chương, Chi cứu tế, Bàn lắc thời linh·Lan rộng\"."
  },
  RelicConfig_57794_Desc = {
    Text = "Giới hạn sáng tạo +1. Trong năm vòng đầu tiên sau khi chiến đấu bắt đầu, mỗi vòng sẽ nhận được một sáng tạo, có \"Áo giáp gaidây gai, Đồng hồ bỏ túi của ngườingười quen cũ, Đoạn vănTiên tích đoạn chương, Chi cứu tế, Bàn lắc thời linh·Lan rộng\"."
  },
  RelicConfig_57794_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「kho báu tàu đắm」>"
  },
  RelicConfig_57794_StoryDesc = {
    Text = "Truyền thuyết cho rằng Lemuria đã sụp đổ trong vùng biển này. Ai có thể kiềm chế không đi khám phá bí mật của kho báu đắm tàu?"
  },
  RelicConfig_57795_BattleDesc = {
    Text = "Giới hạn sáng tạo +1. Trong năm vòng đầu tiên sau khi chiến đấu bắt đầu, mỗi vòng sẽ nhận được một sáng tạo, có \"Rỉ sét Liễu diệp đao, Kềm cầm máu, Cái đố cũ kỹ, Thức tỉnh Bầy ong, Bàn lắc thời linh·Song sinh\"."
  },
  RelicConfig_57795_Desc = {
    Text = "Giới hạn sáng tạo +1. Trong năm vòng đầu tiên sau khi chiến đấu bắt đầu, mỗi vòng sẽ nhận được một sáng tạo, có \"Rỉ sét Liễu diệp đao, Kềm cầm máu, Cái đố cũ kỹ, Thức tỉnh Bầy ong, Bàn lắc thời linh·Song sinh\"."
  },
  RelicConfig_57795_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「kho báu tàu đắm」>"
  },
  RelicConfig_57795_StoryDesc = {
    Text = "Truyền thuyết cho rằng Lemuria đã sụp đổ trong vùng biển này. Ai có thể kiềm chế không đi khám phá bí mật của kho báu đắm tàu?"
  },
  RelicConfig_57796_BattleDesc = {
    Text = "Giới hạn sáng tạo +1. Trong năm vòng đầu tiên sau khi chiến đấu bắt đầu, mỗi vòng sẽ nhận được một sáng tạo, có \"Máy đo thời gian chính xác, Cuff lá quế, Mặt nạ của vị thần vô danh, Biểu tượng ác mộng, Bàn lắc thời linh·Cân bằng\"."
  },
  RelicConfig_57796_Desc = {
    Text = "Giới hạn sáng tạo +1. Trong năm vòng đầu tiên sau khi chiến đấu bắt đầu, mỗi vòng sẽ nhận được một sáng tạo, có \"Máy đo thời gian chính xác, Cuff lá quế, Mặt nạ của vị thần vô danh, Biểu tượng ác mộng, Bàn lắc thời linh·Cân bằng\"."
  },
  RelicConfig_57796_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「kho báu tàu đắm」>"
  },
  RelicConfig_57796_StoryDesc = {
    Text = "Truyền thuyết cho rằng Lemuria đã sụp đổ trong vùng biển này. Ai có thể kiềm chế không đi khám phá bí mật của kho báu đắm tàu?"
  },
  RelicConfig_57797_BattleDesc = {
    Text = "Giới hạn sáng tạo +1. Trong năm vòng đầu tiên sau khi chiến đấu bắt đầu, mỗi vòng sẽ nhận được một sáng tạo, bao gồm \"Ví mới, Huy hiệu Misaque, Rượu của Các ngôi sao, Nụ hôn của Bảy Mang, Bàn lắc thời linh·mắt\"."
  },
  RelicConfig_57797_Desc = {
    Text = "Giới hạn sáng tạo +1. Trong năm vòng đầu tiên sau khi chiến đấu bắt đầu, mỗi vòng sẽ nhận được một sáng tạo, bao gồm \"Ví mới, Huy hiệu Misaque, Rượu của Các ngôi sao, Nụ hôn của Bảy Mang, Bàn lắc thời linh·mắt\"."
  },
  RelicConfig_57797_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「kho báu tàu đắm」>"
  },
  RelicConfig_57797_StoryDesc = {
    Text = "Truyền thuyết cho rằng Lemuria đã sụp đổ trong vùng biển này. Ai có thể kiềm chế không đi khám phá bí mật của kho báu đắm tàu?"
  },
  RelicConfig_58872_BattleDesc = {
    Text = "Khi trận chiến bắt đầu, giới hạn sức tính toán +1, thức tỉnh tất cả các thân thể được đánh thức. Trong 5 lượt tiếp theo, mỗi lượt bắt đầu sẽ nhận được một sáng tạo, bao gồm \"liễu đao gỉ sét, trục bánh xe mới, mái nhà chung, móc câu kỳ quái, bàn lắc thời linh · nhập mê\"."
  },
  RelicConfig_58872_Desc = {
    Text = "Khi trận chiến bắt đầu, giới hạn sức tính toán +1, thức tỉnh tất cả các thân thể được đánh thức. Trong 5 lượt tiếp theo, mỗi lượt bắt đầu sẽ nhận được một sáng tạo, bao gồm \"liễu đao gỉ sét, trục bánh xe mới, mái nhà chung, móc câu kỳ quái, bàn lắc thời linh · nhập mê\"."
  },
  RelicConfig_58872_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh 「bí bảo α」>"
  },
  RelicConfig_58873_BattleDesc = {
    Text = "Khi trận chiến bắt đầu, giới hạn sức tính toán +1, thức tỉnh tất cả thân thể được đánh thức. Trong 5 lượt tiếp theo, mỗi lượt bắt đầu sẽ nhận được một sáng tạo, có \"Mật Ngọt Mặc Thủy, Máy Hát Mất Tiếng, Rượu Của Các Vì Sao, Mũ Phép Thuật, Bàn Lắc Thời Linh · Di Chuyển\"."
  },
  RelicConfig_58873_Desc = {
    Text = "Khi trận chiến bắt đầu, giới hạn sức tính toán +1, thức tỉnh tất cả thân thể được đánh thức. Trong 5 lượt tiếp theo, mỗi lượt bắt đầu sẽ nhận được một sáng tạo, có \"Mật Ngọt Mặc Thủy, Máy Hát Mất Tiếng, Rượu Của Các Vì Sao, Mũ Phép Thuật, Bàn Lắc Thời Linh · Di Chuyển\"."
  },
  RelicConfig_58873_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「bí bảo β」>"
  },
  RelicConfig_59118_BattleDesc = {
    Text = "Sau khi bắt đầu lượt, nhận được 1 lá \"Xúc xắc may mắn của Lắc\" và số điểm xúc xắc +1. Khi bắt đầu lượt và sau mỗi lần ném xúc xắc, tất cả các thân thể được đánh thức nhận thêm 4% thương chí mạng, tối đa 100%."
  },
  RelicConfig_59118_Desc = {
    Text = "Sau khi bắt đầu lượt, nhận được 1 lá \"Xúc xắc may mắn của Lắc\" và số điểm xúc xắc +1. Khi bắt đầu lượt và sau mỗi lần ném xúc xắc, tất cả các thân thể được đánh thức nhận thêm 4% thương chí mạng, tối đa 100%."
  },
  RelicConfig_59118_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh 「hỗn loạn ân tứ」>"
  },
  RelicConfig_59118_StoryDesc = {
    Text = "Tội lỗi từ thời xa xưa đã được khắc sâu tại nơi này."
  },
  RelicConfig_59687_BattleDesc = {
    Text = "Bộ trang bị chuẩn mực 7 món vật phẩm sáng tạo cho trận mô phỏng"
  },
  RelicConfig_59687_Desc = {
    Text = "Bộ trang bị chuẩn mực 7 món vật phẩm sáng tạo cho trận mô phỏng"
  },
  RelicConfig_59687_Name = {
    Text = "<RedQuality:☆Chiến Trường Giả Lập☆>"
  },
  RelicConfig_59687_StoryDesc = {
    Text = "Trong kỷ nguyên kỳ lạ, hoa mới là những người ngắm nhìn đầu tiên của loài người.\nĐừng động đậy, Họ thích những tác phẩm trưng bày yên tĩnh hơn."
  },
  RelicConfig_60723_BattleDesc = {
    Text = "Sức tính toán tối đa tăng 1, vào đầu mỗi lượt rút thêm một lá bài, nhận được 1 lá \"Hiệp nhạc Giao hưởng\". Khi sử dụng 3 lần liên tiếp các thẻ lệnh có sức tính toán giống nhau, tất cả thân thể được đánh thức nhận 20 điểm điên cuồng, sau khi kích hoạt, đặt lại số lần."
  },
  RelicConfig_60723_Desc = {
    Text = "Sức tính toán tối đa tăng 1, vào đầu mỗi lượt rút thêm một lá bài, nhận được 1 lá \"Hiệp nhạc Giao hưởng\". Khi sử dụng 3 lần liên tiếp các thẻ lệnh có sức tính toán giống nhau, tất cả thân thể được đánh thức nhận 20 điểm điên cuồng, sau khi kích hoạt, đặt lại số lần."
  },
  RelicConfig_60723_Name = {
    Text = "<OrangeQuality:đũa chỉ huy dàn nhạc>"
  },
  RelicConfig_60723_StoryDesc = {
    Text = "Cây gậy chỉ huy mảnh mai, nhưng lại có lực lượng lớn hơn cả thanh cậy. \nĐiều khiển nốt nhạc, dẫn dắt linh hồn, định đoạt số phận."
  },
  RelicConfig_60724_BattleDesc = {
    Text = "Khi bắt đầu chiến đấu, sẽ nhận được khắc ấn \"tăng sát thương\" và khắc ấn \"bùng nổ\" cùng với các đá khắc cao cấp của chúng, chọn khắc ấn trên thẻ bài."
  },
  RelicConfig_60724_Desc = {
    Text = "Khi bắt đầu chiến đấu, sẽ nhận được khắc ấn \"tăng sát thương\" và khắc ấn \"bùng nổ\" cùng với các đá khắc cao cấp của chúng, chọn khắc ấn trên thẻ bài."
  },
  RelicConfig_60724_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「lời nhắn của hiệu trưởng」>"
  },
  RelicConfig_60724_StoryDesc = {
    Text = "Lời nhắn của người sáng lập Misaque vang vọng bên tai bạn. \nXin cho chìa khóa bạc dẫn lối, Người Giữ Gìn của Misaque."
  },
  RelicConfig_60725_BattleDesc = {
    Text = "Khi trận chiến bắt đầu, bạn sẽ nhận được \"điên cuồng\" khắcăng và \"xúc tác\" khắcăng cùng với các đá khắc cao cấp của chúng, chọn khắcăng trên thẻ bài."
  },
  RelicConfig_60725_Desc = {
    Text = "Khi trận chiến bắt đầu, bạn sẽ nhận được \"điên cuồng\" khắcăng và \"xúc tác\" khắcăng cùng với các đá khắc cao cấp của chúng, chọn khắcăng trên thẻ bài."
  },
  RelicConfig_60725_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「lời nhắn của hiệu trưởng」>"
  },
  RelicConfig_60725_StoryDesc = {
    Text = "Lời nhắn của người sáng lập Misaque vang vọng bên tai bạn. \nXin cho chìa khóa bạc dẫn lối, Người Giữ Gìn của Misaque."
  },
  RelicConfig_60726_BattleDesc = {
    Text = "Khi chiến đấu bắt đầu, bạn sẽ nhận được khắcăng \"yếu đuối\" và \"tính toán\" cùng với các khắcăng cao cấp của chúng, sau đó chọn khắcăng để áp dụng lên thẻ bài."
  },
  RelicConfig_60726_Desc = {
    Text = "Khi chiến đấu bắt đầu, bạn sẽ nhận được khắcăng \"yếu đuối\" và \"tính toán\" cùng với các khắcăng cao cấp của chúng, sau đó chọn khắcăng để áp dụng lên thẻ bài."
  },
  RelicConfig_60726_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「lời nhắn của hiệu trưởng」>"
  },
  RelicConfig_60726_StoryDesc = {
    Text = "Lời nhắn của người sáng lập Misaque vang vọng bên tai bạn. \nXin cho chìa khóa bạc dẫn lối, Người Giữ Gìn của Misaque."
  },
  RelicConfig_60727_BattleDesc = {
    Text = "Khi trận chiến bắt đầu, người chơi sẽ nhận được khắcăng \"Thiết Tường\" và khắcăng \"Diệu Thủ\" cùng với đá khắc cao cấp của chúng, chọn khắcăng trên thẻ bài."
  },
  RelicConfig_60727_Desc = {
    Text = "Khi trận chiến bắt đầu, người chơi sẽ nhận được khắcăng \"Thiết Tường\" và khắcăng \"Diệu Thủ\" cùng với đá khắc cao cấp của chúng, chọn khắcăng trên thẻ bài."
  },
  RelicConfig_60727_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「lời nhắn của hiệu trưởng」>"
  },
  RelicConfig_60727_StoryDesc = {
    Text = "Lời nhắn của người sáng lập Misaque vang vọng bên tai bạn. \nXin cho chìa khóa bạc dẫn lối, Người Giữ Gìn của Misaque."
  },
  RelicConfig_60728_BattleDesc = {
    Text = "Khi trận chiến bắt đầu, bạn sẽ nhận được khắcăng \"Thai nghén\" và khắcăng \"Hồi âm\" cùng với các đá khắc cao cấp của chúng, chọn khắcăng trên thẻ bài."
  },
  RelicConfig_60728_Desc = {
    Text = "Khi trận chiến bắt đầu, bạn sẽ nhận được khắcăng \"Thai nghén\" và khắcăng \"Hồi âm\" cùng với các đá khắc cao cấp của chúng, chọn khắcăng trên thẻ bài."
  },
  RelicConfig_60728_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「lời nhắn của hiệu trưởng」>"
  },
  RelicConfig_60728_StoryDesc = {
    Text = "Lời nhắn của người sáng lập Misaque vang vọng bên tai bạn. \nXin cho chìa khóa bạc dẫn lối, Người Giữ Gìn của Misaque."
  },
  RelicConfig_60729_BattleDesc = {
    Text = "Khi chiến đấu bắt đầu, sẽ nhận được \"Miệu Thủ\" khắcăng và \"Cảm Hứng\" khắcăng cùng với đá khắc cao cấp của chúng, chọn khắcăng trên thẻ bài."
  },
  RelicConfig_60729_Desc = {
    Text = "Khi chiến đấu bắt đầu, sẽ nhận được \"Miệu Thủ\" khắcăng và \"Cảm Hứng\" khắcăng cùng với đá khắc cao cấp của chúng, chọn khắcăng trên thẻ bài."
  },
  RelicConfig_60729_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「lời nhắn của hiệu trưởng」>"
  },
  RelicConfig_60729_StoryDesc = {
    Text = "Lời nhắn của người sáng lập Misaque vang vọng bên tai bạn. \nXin cho chìa khóa bạc dẫn lối, Người Giữ Gìn của Misaque."
  },
  RelicConfig_60730_BattleDesc = {
    Text = "Khi trận chiến bắt đầu, bạn sẽ nhận được 「khắcăng」 「Man Lực」 và 「khắcăng」 「Suy Kiệt」 cùng với các 「đá khắc cao cấp」 của chúng, chọn 「khắcăng」 trên thẻ bài."
  },
  RelicConfig_60730_Desc = {
    Text = "Khi trận chiến bắt đầu, bạn sẽ nhận được 「khắcăng」 「Man Lực」 và 「khắcăng」 「Suy Kiệt」 cùng với các 「đá khắc cao cấp」 của chúng, chọn 「khắcăng」 trên thẻ bài."
  },
  RelicConfig_60730_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「lời nhắn của hiệu trưởng」>"
  },
  RelicConfig_60730_StoryDesc = {
    Text = "Lời nhắn của người sáng lập Misaque vang vọng bên tai bạn. \nXin cho chìa khóa bạc dẫn lối, Người Giữ Gìn của Misaque."
  },
  RelicConfig_60731_BattleDesc = {
    Text = "Khi trận chiến bắt đầu, bạn sẽ nhận được 2 khắcăng \"Hợp tấu\" cùng với dạng nâng cao của chúng. Sau đó, hãy chọn khắcăng để áp dụng lên thẻ bài."
  },
  RelicConfig_60731_Desc = {
    Text = "Khi trận chiến bắt đầu, bạn sẽ nhận được 2 khắcăng \"Hợp tấu\" cùng với dạng nâng cao của chúng. Sau đó, hãy chọn khắcăng để áp dụng lên thẻ bài."
  },
  RelicConfig_60731_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「lời nhắn của hiệu trưởng」>"
  },
  RelicConfig_60731_StoryDesc = {
    Text = "Lời nhắn của người sáng lập Misaque vang vọng bên tai bạn. \nXin cho chìa khóa bạc dẫn lối, Người Giữ Gìn của Misaque."
  },
  RelicConfig_60732_BattleDesc = {
    Text = "Khi trận chiến bắt đầu, bạn sẽ nhận được khắcăng \"Chu Toán\" và khắcăng \"Kính Tượng\" cùng với đá khắc cao cấp của chúng, chọn các khắcăng để áp dụng lên thẻ bài."
  },
  RelicConfig_60732_Desc = {
    Text = "Khi trận chiến bắt đầu, bạn sẽ nhận được khắcăng \"Chu Toán\" và khắcăng \"Kính Tượng\" cùng với đá khắc cao cấp của chúng, chọn các khắcăng để áp dụng lên thẻ bài."
  },
  RelicConfig_60732_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「lời nhắn của hiệu trưởng」>"
  },
  RelicConfig_60732_StoryDesc = {
    Text = "Lời nhắn của người sáng lập Misaque vang vọng bên tai bạn. \nXin cho chìa khóa bạc dẫn lối, Người Giữ Gìn của Misaque."
  },
  RelicConfig_65376_BattleDesc = {
    Text = "Đầu game có [Arg1] thành viên đoàn thám hiểm. Khi chiến đấu bắt đầu, đặt 5 lá <DerivativeCardKeywords_73:nghi ngờ> vào bộ bài."
  },
  RelicConfig_65376_Desc = {
    Text = "Đầu game có [Arg1] thành viên đoàn thám hiểm. Khi chiến đấu bắt đầu, đặt 5 lá <DerivativeCardKeywords_73:nghi ngờ> vào bộ bài."
  },
  RelicConfig_65376_Name = {
    Text = "<OrangeQuality:đoàn khảo sát khoa học>"
  },
  RelicConfig_65376_StoryDesc = {
    Text = "Lời nhắn của người sáng lập Misaque vang vọng bên tai bạn. \nXin cho chìa khóa bạc dẫn lối, Người Giữ Gìn của Misaque."
  },
  RelicConfig_65406_BattleDesc = {
    Text = "Vào đầu lượt, nhận [Arg1] lá <DerivativeCardKeywords_71:「ánh sáng nhân tính rực rỡ」>. \n<D05EX_Relic: Mọi nỗ lực của bạn đều xứng đáng, bạn gần như đã bảo toàn được đội khảo sát, những người sống sót thực sự biết ơn bạn.>"
  },
  RelicConfig_65406_Desc = {
    Text = "Vào đầu lượt, nhận [Arg1] lá <DerivativeCardKeywords_71:「ánh sáng nhân tính rực rỡ」>. \n<D05EX_Relic: Mọi nỗ lực của bạn đều xứng đáng, bạn gần như đã bảo toàn được đội khảo sát, những người sống sót thực sự biết ơn bạn.>"
  },
  RelicConfig_65406_Name = {
    Text = "<OrangeQuality:huy chương cứu nạn·bạch kim>"
  },
  RelicConfig_65406_StoryDesc = {
    Text = "Mọi nỗ lực của bạn đều xứng đáng. Bạn đã bảo toàn hầu hết đội khảo sát, và những người sống sót chân thành bày tỏ lòng biết ơn với bạn."
  },
  RelicConfig_65407_BattleDesc = {
    Text = "Vào đầu lượt, nhận được [Arg1] lá <DerivativeCardKeywords_72:「Ánh Sáng Nhân Loại Tuyệt Đẹp」>. \n<D05EX_Relic: Bạn đã tạo ra một điều kỳ diệu không thể tin, mọi người đều sống sót sau thảm họa, bạn là anh hùng vĩ đại trong lòng mọi người, truyền thuyết về bạn có thể sẽ lan truyền xung quanh tuyết sơn.>"
  },
  RelicConfig_65407_Desc = {
    Text = "Vào đầu lượt, nhận được [Arg1] lá <DerivativeCardKeywords_72:「Ánh Sáng Nhân Loại Tuyệt Đẹp」>. \n<D05EX_Relic: Bạn đã tạo ra một điều kỳ diệu không thể tin, mọi người đều sống sót sau thảm họa, bạn là anh hùng vĩ đại trong lòng mọi người, truyền thuyết về bạn có thể sẽ lan truyền xung quanh tuyết sơn.>"
  },
  RelicConfig_65407_Name = {
    Text = "<OrangeQuality:huy chương cứu nạn · kim cương>"
  },
  RelicConfig_65407_StoryDesc = {
    Text = "Bạn đã tạo ra một kỳ tích không thể tin được, mọi người đều sống sót sau thảm họa, bạn là anh hùng vĩ đại trong lòng mọi người, truyền thuyết về bạn có thể sẽ được lưu truyền quanh vùng tuyết sơn."
  },
  RelicConfig_65408_BattleDesc = {
    Text = "Vào đầu lượt, nhận được [Arg1] lá <DerivativeCardKeywords_68:「ánh sáng nhân tính mờ nhạt」>. \n<D05EX_Relic:Để thoát khỏi tuyết sơn, bạn đã chọn chiến lược ưu tiên hiệu quả và chứng kiến mọi người chết, ánh mắt của những người sống sót nhìn bạn chứa nhiều nỗi sợ hãi hơn lòng biết ơn.>"
  },
  RelicConfig_65408_Desc = {
    Text = "Vào đầu lượt, nhận được [Arg1] lá <DerivativeCardKeywords_68:「ánh sáng nhân tính mờ nhạt」>. \n<D05EX_Relic:Để thoát khỏi tuyết sơn, bạn đã chọn chiến lược ưu tiên hiệu quả và chứng kiến mọi người chết, ánh mắt của những người sống sót nhìn bạn chứa nhiều nỗi sợ hãi hơn lòng biết ơn.>"
  },
  RelicConfig_65408_Name = {
    Text = "<OrangeQuality:huy chương cứu nạn·đồng>"
  },
  RelicConfig_65408_StoryDesc = {
    Text = "Để thoát khỏi tuyết sơn, bạn chọn chiến lược ưu tiên hiệu quả, chứng kiến mọi người ngã xuống từng người. Những người sống sót nhìn bạn với ánh mắt đầy sợ hãi hơn là lòng biết ơn."
  },
  RelicConfig_65409_BattleDesc = {
    Text = "Vào đầu lượt, nhận [Arg1] lá <DerivativeCardKeywords_69:「Ánh Sáng Nhân Tính Vi Minh」>. \n<D05EX_Relic:Đã có thể bạn đã cố gắng, mặc dù một nửa số người đã chết, bạn ít nhất cũng đã cứu được nửa còn lại, dù sao thì hy sinh luôn là điều không thể tránh khỏi.>"
  },
  RelicConfig_65409_Desc = {
    Text = "Vào đầu lượt, nhận [Arg1] lá <DerivativeCardKeywords_69:「Ánh Sáng Nhân Tính Vi Minh」>. \n<D05EX_Relic:Đã có thể bạn đã cố gắng, mặc dù một nửa số người đã chết, bạn ít nhất cũng đã cứu được nửa còn lại, dù sao thì hy sinh luôn là điều không thể tránh khỏi.>"
  },
  RelicConfig_65409_Name = {
    Text = "<OrangeQuality:huy chương cứu nạn·bạc>"
  },
  RelicConfig_65409_StoryDesc = {
    Text = "Bạn có thể đã cố gắng rồi, dù một nửa số người đã chết, ít nhất bạn cũng cứu được nửa còn lại. Dù sao, hy sinh luôn là điều không tránh khỏi trong những tình huống như vậy."
  },
  RelicConfig_65410_BattleDesc = {
    Text = "Vào đầu lượt, nhận được [Arg1] lá <DerivativeCardKeywords_70:「Ánh Sáng Nhân Tính」>. \n<D05EX_Relic: Bạn đã cứu sống phần lớn mọi người, viết lại số phận bi thảm của họ. Bạn đã làm hết sức mình rồi, phải không?>"
  },
  RelicConfig_65410_Desc = {
    Text = "Vào đầu lượt, nhận được [Arg1] lá <DerivativeCardKeywords_70:「Ánh Sáng Nhân Tính」>. \n<D05EX_Relic: Bạn đã cứu sống phần lớn mọi người, viết lại số phận bi thảm của họ. Bạn đã làm hết sức mình rồi, phải không?>"
  },
  RelicConfig_65410_Name = {
    Text = "<OrangeQuality:huy chương cứu nạn·vàng>"
  },
  RelicConfig_65410_StoryDesc = {
    Text = "Bạn đã cứu sống phần lớn mọi người, viết lại số phận đau thương của họ, bạn đã làm hết sức mình rồi, đúng không?"
  },
  RelicConfig_65456_BattleDesc = {
    Text = "Khi bắt đầu chiến đấu, xáo trộn 3 thẻ triệu chứng ngẫu nhiên, mỗi khi chơi thẻ triệu chứng, nhận được [Arg1] điểm lực lượng. \n <D05EX_Relic: Dưới sự giúp đỡ của bạn, đoàn khảo cổ không ai sống sót, bạn lạnh lùng tìm kiếm lợi ích lớn nhất cho bản thân, nhưng tất cả những điều này có thật sự xứng đáng không?>"
  },
  RelicConfig_65456_Desc = {
    Text = "Khi bắt đầu chiến đấu, xáo trộn 3 thẻ triệu chứng ngẫu nhiên, khi chơi thẻ triệu chứng nhận được [Arg1] điểm lực lượng. \n<D05EX_Relic: Với sự giúp đỡ của bạn, không ai sống sót trong đoàn khảo cổ, bạn lạnh lùng thu lợi ích lớn nhất cho bản thân, nhưng tất cả điều này có thực sự đáng giá không?>"
  },
  RelicConfig_65456_Name = {
    Text = "<OrangeQuality:Huy hiệu của người độc hành>"
  },
  RelicConfig_65456_StoryDesc = {
    Text = "Với sự giúp đỡ của bạn, không ai sống sót trong đoàn thám hiểm, bạn đã đạt được lợi ích lớn nhất cho bản thân, nhưng liệu điều đó có thực sự đáng giá?"
  },
  RelicConfig_65569_BattleDesc = {
    Text = "Khi trận chiến bắt đầu, giới hạn sức tính toán +1 và kích hoạt tất cả thân thể được đánh thức. Trong 5 lượt tiếp theo, mỗi lượt sẽ nhận được một sáng tạo, bao gồm: thiết bị liên lạc, lễ xuân, quyền trượng linh mục, chim nghi thức xui xẻo, bàn lắc thời linh·phóng."
  },
  RelicConfig_65569_Desc = {
    Text = "Khi trận chiến bắt đầu, giới hạn sức tính toán +1 và kích hoạt tất cả thân thể được đánh thức. Trong 5 lượt tiếp theo, mỗi lượt sẽ nhận được một sáng tạo, bao gồm: thiết bị liên lạc, lễ xuân, quyền trượng linh mục, chim nghi thức xui xẻo, bàn lắc thời linh·phóng."
  },
  RelicConfig_65569_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh 「bí bảo δ」>"
  },
  RelicConfig_65570_BattleDesc = {
    Text = "Khi trận chiến bắt đầu, giới hạn sức tính toán +1, thức tỉnh tất cả thân thể được đánh thức. Trong 5 lượt tiếp theo, mỗi lượt bắt đầu sẽ nhận được một sáng tạo, bao gồm \"Huy hiệu Misa, Vali bác sĩ, Pin nguyên mẫu, Khắc ghi ý thức, Bàn lắc thời linh · Diễn hóa\"."
  },
  RelicConfig_65570_Desc = {
    Text = "Khi trận chiến bắt đầu, giới hạn sức tính toán +1, thức tỉnh tất cả thân thể được đánh thức. Trong 5 lượt tiếp theo, mỗi lượt bắt đầu sẽ nhận được một sáng tạo, bao gồm \"Huy hiệu Misa, Vali bác sĩ, Pin nguyên mẫu, Khắc ghi ý thức, Bàn lắc thời linh · Diễn hóa\"."
  },
  RelicConfig_65570_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh 「bí bảo γ」>"
  },
  RelicConfig_66515_BattleDesc = {
    Text = "Khi trận chiến bắt đầu, giới hạn sức tính toán +1 và thức tỉnh tất cả thân thể được đánh thức. Trong 5 lượt tiếp theo, mỗi lượt sẽ nhận được một sáng tạo: 「Tin sớm Putney」, 「Nguyên lý thẩm mỹ」, 「Bài ca của đám đông」, 「Gương mặt khuyết」, 「Bàn lắc thời linh · Lai vãng」."
  },
  RelicConfig_66515_Desc = {
    Text = "Khi trận chiến bắt đầu, giới hạn sức tính toán +1 và thức tỉnh tất cả thân thể được đánh thức. Trong 5 lượt tiếp theo, mỗi lượt sẽ nhận được một sáng tạo: 「Tin sớm Putney」, 「Nguyên lý thẩm mỹ」, 「Bài ca của đám đông」, 「Gương mặt khuyết」, 「Bàn lắc thời linh · Lai vãng」."
  },
  RelicConfig_66515_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh 「bí bảo ε」>"
  },
  RelicConfig_66518_BattleDesc = {
    Text = "Khi chiến đấu bắt đầu, giới hạn sức tính toán +1, thức tỉnh tất cả các thân thể được đánh thức. Vào đầu lượt lẻ, phát hiện một sáng tạo, tổng cộng phát hiện năm lần."
  },
  RelicConfig_66518_Desc = {
    Text = "Khi chiến đấu bắt đầu, giới hạn sức tính toán +1, thức tỉnh tất cả các thân thể được đánh thức. Vào đầu lượt lẻ, phát hiện một sáng tạo, tổng cộng phát hiện năm lần."
  },
  RelicConfig_66518_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh 「Thỉnh Nguyện β」>"
  },
  RelicConfig_66519_BattleDesc = {
    Text = "Khi chiến đấu bắt đầu, giới hạn sức tính toán +1, thức tỉnh tất cả các thân thể được đánh thức. Vào đầu lượt lẻ, phát hiện một sáng tạo, tổng cộng phát hiện năm lần."
  },
  RelicConfig_66519_Desc = {
    Text = "Khi chiến đấu bắt đầu, giới hạn sức tính toán +1, thức tỉnh tất cả các thân thể được đánh thức. Vào đầu lượt lẻ, phát hiện một sáng tạo, tổng cộng phát hiện năm lần."
  },
  RelicConfig_66519_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「lời cầu nguyệnα」>"
  },
  RelicConfig_67690_BattleDesc = {
    Text = "Mỗi đầu lượt, tất cả các thân thể được đánh thức nhận được 25 điên cuồng. Khi nhặt, sức sống tối đa tăng lên 1.5 lần."
  },
  RelicConfig_67690_Desc = {
    Text = "Mỗi đầu lượt, tất cả các thân thể được đánh thức nhận được 25 điên cuồng. Khi nhặt, sức sống tối đa tăng lên 1.5 lần."
  },
  RelicConfig_67690_Name = {
    Text = "<OrangeQuality:được chúc · dị tượng ác mộng β>"
  },
  RelicConfig_67690_StoryDesc = {
    Text = "Không cần sợ hãi, không cần do dự. Đây chỉ là giấc mơ thoáng qua, ánh sáng của Đấng Tối Cao vẫn chiếu rọi trên ngươi."
  },
  RelicConfig_67788_BattleDesc = {
    Text = "Nhặt để nhận 3 điểm sức tính toán."
  },
  RelicConfig_67788_Desc = {
    Text = "Nhặt để nhận 3 điểm sức tính toán."
  },
  RelicConfig_67788_Name = {
    Text = "<WhiteQuality:đồng hồ bỏ túi>"
  },
  RelicConfig_67788_StoryDesc = {
    Text = "Ký ức ngưng đọng trong quá khứ, chôn vùi trong bóng tối sâu thẳm."
  },
  RelicConfig_67789_BattleDesc = {
    Text = "Khi nhặt lên, hãy đặt 1 thẻ <DerivativeCardKeywords_1:「Dư Ảnh Hồi Hưởng」> vào tay."
  },
  RelicConfig_67789_Desc = {
    Text = "Khi nhặt lên, hãy đặt 1 thẻ <DerivativeCardKeywords_1:「Dư Ảnh Hồi Hưởng」> vào tay."
  },
  RelicConfig_67789_Name = {
    Text = "<WhiteQuality:thiết bị thông tin liên lạc>"
  },
  RelicConfig_67789_StoryDesc = {
    Text = "Ngóng trông hoặc lo lắng khoảnh khắc nó phát ra tiếng chuông trong trẻo."
  },
  RelicConfig_67790_BattleDesc = {
    Text = "Tất cả 「tấn công」 gây ra tăng 20% thương harming chí mạng. Khi nhặt, thêm 1 lá <DerivativeCardKeywords_40:「khoảnh khắc đẹp」> vào tay."
  },
  RelicConfig_67790_Desc = {
    Text = "Tất cả 「tấn công」 gây ra tăng 20% thương harming chí mạng. Khi nhặt, thêm 1 lá <DerivativeCardKeywords_40:「khoảnh khắc đẹp」> vào tay."
  },
  RelicConfig_67790_Name = {
    Text = "<WhiteQuality:khoảnh khắc đẹp>"
  },
  RelicConfig_67790_StoryDesc = {
    Text = "Lưu giữ vẻ đẹp của phút chốc mãi mãi."
  },
  RelicConfig_67791_BattleDesc = {
    Text = "Khi nhặt, áp dụng 1 lượt <WeaknessIconKeywords:yếu đuối>, <VulnerabilityIconKeywords:tăng sát thương> cho tất cả kẻ địch."
  },
  RelicConfig_67791_Desc = {
    Text = "Khi nhặt, áp dụng 1 lượt <WeaknessIconKeywords:yếu đuối>, <VulnerabilityIconKeywords:tăng sát thương> cho tất cả kẻ địch."
  },
  RelicConfig_67791_Name = {
    Text = "<WhiteQuality:Áo Ngự Biến Sắc>"
  },
  RelicConfig_67791_StoryDesc = {
    Text = "Không chỉ thời gian mới có thể làm biến đổi màu sắc của vải, mà cả nỗi sợ hãi và đau khổ cũng vậy."
  },
  RelicConfig_67793_BattleDesc = {
    Text = "Khi trận chiến bắt đầu, tất cả các thân thể được đánh thức nhận được 50 điểm điên cuồng. Đặt 2 lá <DerivativeCardKeywords_1:「dư ảnh hồi vang」> vào tay."
  },
  RelicConfig_67793_Desc = {
    Text = "Khi nhặt, tất cả các thân thể được đánh thức nhận được 50 điểm điên cuồng, đưa 2 lá <DerivativeCardKeywords_1:「Dư ảnh hồi hưởng」> vào tay."
  },
  RelicConfig_67793_Name = {
    Text = "<OrangeQuality:thiết bị liên lạc+β>"
  },
  RelicConfig_67793_StoryDesc = {
    Text = "Ngóng trông hoặc lo lắng khoảnh khắc nó phát ra tiếng chuông trong trẻo."
  },
  RelicConfig_67794_BattleDesc = {
    Text = "Giới hạn thẻ bài trên tay tăng 5, bổ sung thẻ bài lên giới hạn khi bắt đầu chiến đấu. Vào đầu lượt, rút thêm 1 thẻ, và vào cuối lượt, bỏ đi tất cả các thẻ triệu chứng và thẻ trạng thái trong tay, giữ lại các thẻ khác."
  },
  RelicConfig_67794_Desc = {
    Text = "Giới hạn thẻ bài trên tay tăng 5, bổ sung thẻ bài lên giới hạn khi bắt đầu chiến đấu. Vào đầu lượt, rút thêm 1 thẻ, và vào cuối lượt, bỏ đi tất cả các thẻ triệu chứng và thẻ trạng thái trong tay, giữ lại các thẻ khác."
  },
  RelicConfig_67794_Name = {
    Text = "<OrangeQuality:được ban phước·dấu ấn ý thức β>"
  },
  RelicConfig_67794_StoryDesc = {
    Text = "Người tham lam khắc ghi lỗi lầm của mình trong tâm và cố gắng chuộc tội cho quá khứ của mình."
  },
  RelicConfig_67818_BattleDesc = {
    Text = "Khi bắt đầu chiến đấu, giới hạn sức tính toán +1, thức tỉnh tất cả thân thể được đánh thức. Khi bắt đầu lượt, ngẫu nhiên phát hiện một \"sáng tạo\" hoặc \"hỗ trợ\", tổng cộng phát hiện năm lần."
  },
  RelicConfig_67818_Desc = {
    Text = "Khi bắt đầu chiến đấu, giới hạn sức tính toán +1, thức tỉnh tất cả thân thể được đánh thức. Khi bắt đầu lượt, ngẫu nhiên phát hiện một \"sáng tạo\" hoặc \"hỗ trợ\", tổng cộng phát hiện năm lần."
  },
  RelicConfig_67818_Name = {
    Text = "<OrangeQuality:「Cánh cửa Vạn Tượng ε」>"
  },
  RelicConfig_67819_BattleDesc = {
    Text = "Khi bắt đầu chiến đấu, giới hạn sức tính toán +1, thức tỉnh tất cả thân thể được đánh thức. Khi bắt đầu lượt, ngẫu nhiên phát hiện một \"sáng tạo\" hoặc \"hỗ trợ\", tổng cộng phát hiện năm lần."
  },
  RelicConfig_67819_Desc = {
    Text = "Khi bắt đầu chiến đấu, giới hạn sức tính toán +1, thức tỉnh tất cả thân thể được đánh thức. Khi bắt đầu lượt, ngẫu nhiên phát hiện một \"sáng tạo\" hoặc \"hỗ trợ\", tổng cộng phát hiện năm lần."
  },
  RelicConfig_67819_Name = {
    Text = "<OrangeQuality:「Cánh Cửa Thiên Tượng ζ」>"
  },
  RelicConfig_67820_BattleDesc = {
    Text = "Khi bắt đầu chiến đấu, giới hạn sức tính toán +1, thức tỉnh tất cả thân thể được đánh thức. Khi bắt đầu lượt, ngẫu nhiên phát hiện một \"sáng tạo\" hoặc \"hỗ trợ\", tổng cộng phát hiện năm lần."
  },
  RelicConfig_67820_Desc = {
    Text = "Khi bắt đầu chiến đấu, giới hạn sức tính toán +1, thức tỉnh tất cả thân thể được đánh thức. Khi bắt đầu lượt, ngẫu nhiên phát hiện một \"sáng tạo\" hoặc \"hỗ trợ\", tổng cộng phát hiện năm lần."
  },
  RelicConfig_67820_Name = {
    Text = "<OrangeQuality:「vạn tượng cánh cửa θ」>"
  },
  RelicConfig_67821_BattleDesc = {
    Text = "Khi bắt đầu chiến đấu, giới hạn sức tính toán +1, thức tỉnh tất cả thân thể được đánh thức. Khi bắt đầu lượt, ngẫu nhiên phát hiện một \"sáng tạo\" hoặc \"hỗ trợ\", tổng cộng phát hiện năm lần."
  },
  RelicConfig_67821_Desc = {
    Text = "Khi bắt đầu chiến đấu, giới hạn sức tính toán +1, thức tỉnh tất cả thân thể được đánh thức. Khi bắt đầu lượt, ngẫu nhiên phát hiện một \"sáng tạo\" hoặc \"hỗ trợ\", tổng cộng phát hiện năm lần."
  },
  RelicConfig_67821_Name = {
    Text = "<OrangeQuality:「Cánh Cửa Vạn Tượng γ」>"
  },
  RelicConfig_67822_BattleDesc = {
    Text = "Khi bắt đầu chiến đấu, giới hạn sức tính toán +1, thức tỉnh tất cả thân thể được đánh thức. Khi bắt đầu lượt, ngẫu nhiên phát hiện một \"sáng tạo\" hoặc \"hỗ trợ\", tổng cộng phát hiện năm lần."
  },
  RelicConfig_67822_Desc = {
    Text = "Khi bắt đầu chiến đấu, giới hạn sức tính toán +1, thức tỉnh tất cả thân thể được đánh thức. Khi bắt đầu lượt, ngẫu nhiên phát hiện một \"sáng tạo\" hoặc \"hỗ trợ\", tổng cộng phát hiện năm lần."
  },
  RelicConfig_67822_Name = {
    Text = "<OrangeQuality:「Cánh cửa Muôn Hình α」>"
  },
  RelicConfig_67823_BattleDesc = {
    Text = "Khi bắt đầu chiến đấu, giới hạn sức tính toán +1, thức tỉnh tất cả thân thể được đánh thức. Khi bắt đầu lượt, ngẫu nhiên phát hiện một \"sáng tạo\" hoặc \"hỗ trợ\", tổng cộng phát hiện năm lần."
  },
  RelicConfig_67823_Desc = {
    Text = "Khi bắt đầu chiến đấu, giới hạn sức tính toán +1, thức tỉnh tất cả thân thể được đánh thức. Khi bắt đầu lượt, ngẫu nhiên phát hiện một \"sáng tạo\" hoặc \"hỗ trợ\", tổng cộng phát hiện năm lần."
  },
  RelicConfig_67823_Name = {
    Text = "<OrangeQuality:「Cánh Cửa Vạn Tượng η」>"
  },
  RelicConfig_67824_BattleDesc = {
    Text = "Khi bắt đầu chiến đấu, giới hạn sức tính toán +1, thức tỉnh tất cả thân thể được đánh thức. Khi bắt đầu lượt, ngẫu nhiên phát hiện một \"sáng tạo\" hoặc \"hỗ trợ\", tổng cộng phát hiện năm lần."
  },
  RelicConfig_67824_Desc = {
    Text = "Khi bắt đầu chiến đấu, giới hạn sức tính toán +1, thức tỉnh tất cả thân thể được đánh thức. Khi bắt đầu lượt, ngẫu nhiên phát hiện một \"sáng tạo\" hoặc \"hỗ trợ\", tổng cộng phát hiện năm lần."
  },
  RelicConfig_67824_Name = {
    Text = "<OrangeQuality:「Cánh cửa Vạn Tượng δ」>"
  },
  RelicConfig_67825_BattleDesc = {
    Text = "Khi bắt đầu chiến đấu, giới hạn sức tính toán +1, thức tỉnh tất cả thân thể được đánh thức. Khi bắt đầu lượt, ngẫu nhiên phát hiện một \"sáng tạo\" hoặc \"hỗ trợ\", tổng cộng phát hiện năm lần."
  },
  RelicConfig_67825_Desc = {
    Text = "Khi bắt đầu chiến đấu, giới hạn sức tính toán +1, thức tỉnh tất cả thân thể được đánh thức. Khi bắt đầu lượt, ngẫu nhiên phát hiện một \"sáng tạo\" hoặc \"hỗ trợ\", tổng cộng phát hiện năm lần."
  },
  RelicConfig_67825_Name = {
    Text = "<OrangeQuality:「Cánh Cửa Đa Trạngβ」>"
  },
  RelicConfig_67826_BattleDesc = {
    Text = "Khi bắt đầu chiến đấu, giới hạn sức tính toán +1, thức tỉnh tất cả thân thể được đánh thức. Khi bắt đầu lượt, ngẫu nhiên phát hiện một \"sáng tạo\" hoặc \"hỗ trợ\", tổng cộng phát hiện năm lần."
  },
  RelicConfig_67826_Desc = {
    Text = "Khi bắt đầu chiến đấu, giới hạn sức tính toán +1, thức tỉnh tất cả thân thể được đánh thức. Khi bắt đầu lượt, ngẫu nhiên phát hiện một \"sáng tạo\" hoặc \"hỗ trợ\", tổng cộng phát hiện năm lần."
  },
  RelicConfig_67826_Name = {
    Text = "<OrangeQuality:「Cửa Vạn Tượng ι」>"
  },
  RelicConfig_68651_BattleDesc = {
    Text = "Khi bắt đầu chiến đấu, thức tỉnh tất cả các thân thể được đánh thức, đặt <DerivativeCardKeywords_84:「Ánh Sáng Ký Ức - Bình Tượng Nến Chưa Hoàn Thiện」> vào tay, sao chép tất cả các thẻ bài trong bộ bài rút. Mỗi lượt rút thêm 5 thẻ bài và nhận 5 điểm sức tính toán. Sau khi sử dụng 「đánh」 hoặc 「phòng thủ」, nhận [Arg1] điểm lá chắn."
  },
  RelicConfig_68651_Desc = {
    Text = "Khi bắt đầu chiến đấu, thức tỉnh tất cả các thân thể được đánh thức, đặt <DerivativeCardKeywords_84:「Ánh Sáng Ký Ức - Bình Tượng Nến Chưa Hoàn Thiện」> vào tay, sao chép tất cả các thẻ bài trong bộ bài rút. Mỗi lượt rút thêm 5 thẻ bài và nhận 5 điểm sức tính toán. Sau khi sử dụng 「đánh」 hoặc 「phòng thủ」, nhận [Arg1] điểm lá chắn."
  },
  RelicConfig_68651_Name = {
    Text = "<OrangeQuality:「lõi bạc tinh khiết · Sợ hãi」>"
  },
  RelicConfig_68652_BattleDesc = {
    Text = "Khi trận chiến bắt đầu, thức tỉnh tất cả các thân thể được đánh thức, đặt <DerivativeCardKeywords_85:「Hào quang Ký ức - Trái tim Biến dị」> vào tay. Khi lượt bắt đầu, có thể chọn bất kỳ số lượng thẻ trong tay để vứt bỏ, rút bấy nhiêu thẻ. Vào lượt lẻ, nhận [Arg1] điểm lực lượng tạm thời, đặt <DerivativeCardKeywords_97:「Ý chí Chiến đấu Bất tận β」> vào tay. Vào lượt chẵn, nhận [Arg2] điểm giữ mình tạm thời, đặt <DerivativeCardKeywords_98:「Trốn tránh β」> vào tay."
  },
  RelicConfig_68652_Desc = {
    Text = "Khi trận chiến bắt đầu, thức tỉnh tất cả các thân thể được đánh thức, đặt <DerivativeCardKeywords_85:「Hào quang Ký ức - Trái tim Biến dị」> vào tay. Khi lượt bắt đầu, có thể chọn bất kỳ số lượng thẻ trong tay để vứt bỏ, rút bấy nhiêu thẻ. Vào lượt lẻ, nhận [Arg1] điểm lực lượng tạm thời, đặt <DerivativeCardKeywords_97:「Ý chí Chiến đấu Bất tận β」> vào tay. Vào lượt chẵn, nhận [Arg2] điểm giữ mình tạm thời, đặt <DerivativeCardKeywords_98:「Trốn tránh β」> vào tay."
  },
  RelicConfig_68652_Name = {
    Text = "<OrangeQuality:「lõi bạc tinh khiết · thấu xương」>"
  },
  RelicConfig_68653_BattleDesc = {
    Text = "Khi bắt đầu chiến đấu, thức tỉnh tất cả các thân thể được đánh thức và đặt <DerivativeCardKeywords_83:「Truy Ức Vi Quang - Món Quà Ngây Thơ」> vào tay. Tất cả các thân thể được đánh thức mỗi lượt có thể phát động thêm 1 lần cơn thịnh nộ bùng phát, sau khi phát động cơn thịnh nộ bùng phát, giảm [Arg2] điểm lực lượng của kẻ địch. Vào đầu lượt, tất cả các thân thể được đánh thức nhận được [Arg1] điểm điên cuồng."
  },
  RelicConfig_68653_Desc = {
    Text = "Khi bắt đầu chiến đấu, thức tỉnh tất cả các thân thể được đánh thức và đặt <DerivativeCardKeywords_83:「Truy Ức Vi Quang - Món Quà Ngây Thơ」> vào tay. Tất cả các thân thể được đánh thức mỗi lượt có thể phát động thêm 1 lần cơn thịnh nộ bùng phát, sau khi phát động cơn thịnh nộ bùng phát, giảm [Arg2] điểm lực lượng của kẻ địch. Vào đầu lượt, tất cả các thân thể được đánh thức nhận được [Arg1] điểm điên cuồng."
  },
  RelicConfig_68653_Name = {
    Text = "<OrangeQuality:「lõi bạc tinh khiết · khóc than」>"
  },
  RelicConfig_68654_BattleDesc = {
    Text = "Khi trận chiến bắt đầu, thức tỉnh tất cả các thân thể được đánh thức, đặt <DerivativeCardKeywords_88:「Hào Quang Kỷ Niệm - Màn Trướng Utopia」> vào tay, giới hạn bài trong tay của đội +2, giới hạn lưu trữ năng lượng chìa khóa bạc +100%. Sau khi phát động lệnh khóa, tỷ lệ chí mạng và thương chí mạng tạm thời của tất cả các thân thể được đánh thức + [Arg1]%, nhận lá chắn bằng 20% máu tối đa, rút bài cho đến khi số bài trong tay đạt giới hạn."
  },
  RelicConfig_68654_Desc = {
    Text = "Khi trận chiến bắt đầu, thức tỉnh tất cả các thân thể được đánh thức, đặt <DerivativeCardKeywords_88:「Hào Quang Kỷ Niệm - Màn Trướng Utopia」> vào tay, giới hạn bài trong tay của đội +2, giới hạn lưu trữ năng lượng chìa khóa bạc +100%. Sau khi phát động lệnh khóa, tỷ lệ chí mạng và thương chí mạng tạm thời của tất cả các thân thể được đánh thức + [Arg1]%, nhận lá chắn bằng 20% máu tối đa, rút bài cho đến khi số bài trong tay đạt giới hạn."
  },
  RelicConfig_68654_Name = {
    Text = "<OrangeQuality:「Lõi bạc thuần · điên rồ」>"
  },
  RelicConfig_68655_BattleDesc = {
    Text = "Khi bắt đầu chiến đấu, thức tỉnh tất cả các thân thể được đánh thức và đặt <DerivativeCardKeywords_89:「Hào quang Truy niệm - Hạt nhân Phong nhưỡng」> vào tay. Khi kết thúc lượt, giữ lại sức tính toán còn lại và không bỏ các lá bài trong tay. Mỗi lần gây ra thương chủ động, nhận được [Arg1] điểm lực lượng tạm thời và [Arg2] điểm lá chắn."
  },
  RelicConfig_68655_Desc = {
    Text = "Khi bắt đầu chiến đấu, thức tỉnh tất cả các thân thể được đánh thức và đặt <DerivativeCardKeywords_89:「Hào quang Truy niệm - Hạt nhân Phong nhưỡng」> vào tay. Khi kết thúc lượt, giữ lại sức tính toán còn lại và không bỏ các lá bài trong tay. Mỗi lần gây ra thương chủ động, nhận được [Arg1] điểm lực lượng tạm thời và [Arg2] điểm lá chắn."
  },
  RelicConfig_68655_Name = {
    Text = "<OrangeQuality:「lõi bạc tinh khiết · Xuất hiện」>"
  },
  RelicConfig_68656_BattleDesc = {
    Text = "Khi bắt đầu chiến đấu, thức tỉnh tất cả các thân thể được đánh thức, đặt <DerivativeCardKeywords_86:「Ký ức ánh sáng nhạt-rượu mật ong」> vào tay, tất cả các thân thể được đánh thức có thương harming chí mạng tăng lên 1.5 lần. Nếu thân thể chưa giải phóng cơn thịnh nộ bùng phát, nhận [Arg1] điểm điên cuồng khi hết lượt. Nếu số thẻ bài đánh ra nhỏ hơn [Arg2], rút 2 thẻ bài ở lượt tiếp theo và nhận 2 điểm sức tính toán."
  },
  RelicConfig_68656_Desc = {
    Text = "Khi bắt đầu chiến đấu, thức tỉnh tất cả các thân thể được đánh thức, đặt <DerivativeCardKeywords_86:「Ký ức ánh sáng nhạt-rượu mật ong」> vào tay, tất cả các thân thể được đánh thức có thương harming chí mạng tăng lên 1.5 lần. Nếu thân thể chưa giải phóng cơn thịnh nộ bùng phát, nhận [Arg1] điểm điên cuồng khi hết lượt. Nếu số thẻ bài đánh ra nhỏ hơn [Arg2], rút 2 thẻ bài ở lượt tiếp theo và nhận 2 điểm sức tính toán."
  },
  RelicConfig_68656_Name = {
    Text = "<OrangeQuality:「lõi bạc thuần khiết · kỳ quái」>"
  },
  RelicConfig_68657_BattleDesc = {
    Text = "Khi bắt đầu chiến đấu, thức tỉnh tất cả Thể thức tỉnh, đưa <DerivativeCardKeywords_87:\"Kỷ niệm - Lệnh của Đại diện\"> vào tay, Khuếch đại sát thương của đội được nhân đôi. Hiệu ứng Suy nhược do người chơi gây ra tăng từ 25% lên 50%, cuối mỗi lượt nhận lá chắn bằng [Arg1]％ Sinh lực tối đa và gây <FixedDamage:Sát Thương Thuần Túy> lên tất cả kẻ địch bằng [Arg2] lần giá trị lá chắn của bản thân."
  },
  RelicConfig_68657_Desc = {
    Text = "Khi bắt đầu chiến đấu, thức tỉnh tất cả Thể thức tỉnh, đưa <DerivativeCardKeywords_87:\"Kỷ niệm - Lệnh của Đại diện\"> vào tay, Khuếch đại sát thương của đội được nhân đôi. Hiệu ứng Suy nhược do người chơi gây ra tăng từ 25% lên 50%, cuối mỗi lượt nhận lá chắn bằng [Arg1]％ Sinh lực tối đa và gây <FixedDamage:Sát Thương Thuần Túy> lên tất cả kẻ địch bằng [Arg2] lần giá trị lá chắn của bản thân."
  },
  RelicConfig_68657_Name = {
    Text = "<OrangeQuality:「lõi bạc thuần · tà tín」>"
  },
  RelicConfig_68886_BattleDesc = {
    Text = "Thương, chữa trị và lá chắn của Tà Vy tăng 50%. Vào lúc bắt đầu chiến đấu, Tà Vy nhận được 120 điểm điên cuồng."
  },
  RelicConfig_68886_Desc = {
    Text = "Tà Vy gây thương, lá chắn và khả năng hồi phục sức sống tăng 50%. Khi bắt đầu chiến đấu, Tà Vy nhận được 120 điểm điên cuồng."
  },
  RelicConfig_68886_Name = {
    Text = "<OrangeQuality:「Mắt Toàn Tri」>"
  },
  RelicConfig_68886_StoryDesc = {
    Text = "Từ cánh cửa bước ra, Đấng đặt chân lên con đường duy nhất đúng đắn."
  },
  RelicConfig_69319_BattleDesc = {
    Text = "Khi chiến đấu bắt đầu, giới hạn sức tính toán +1, thức tỉnh tất cả các thân thể được đánh thức. Vào đầu lượt lẻ, phát hiện một sáng tạo, tổng cộng phát hiện năm lần."
  },
  RelicConfig_69319_Desc = {
    Text = "Khi chiến đấu bắt đầu, giới hạn sức tính toán +1, thức tỉnh tất cả các thân thể được đánh thức. Vào đầu lượt lẻ, phát hiện một sáng tạo, tổng cộng phát hiện năm lần."
  },
  RelicConfig_69319_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh 「khấn nguyện ε」>"
  },
  RelicConfig_69320_BattleDesc = {
    Text = "Khi chiến đấu bắt đầu, giới hạn sức tính toán +1, thức tỉnh tất cả các thân thể được đánh thức. Vào đầu lượt lẻ, phát hiện một sáng tạo, tổng cộng phát hiện năm lần."
  },
  RelicConfig_69320_Desc = {
    Text = "Khi chiến đấu bắt đầu, giới hạn sức tính toán +1, thức tỉnh tất cả các thân thể được đánh thức. Vào đầu lượt lẻ, phát hiện một sáng tạo, tổng cộng phát hiện năm lần."
  },
  RelicConfig_69320_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「lời cầu nguyện γ」>"
  },
  RelicConfig_69321_BattleDesc = {
    Text = "Khi chiến đấu bắt đầu, giới hạn sức tính toán +1, thức tỉnh tất cả các thân thể được đánh thức. Vào đầu lượt lẻ, phát hiện một sáng tạo, tổng cộng phát hiện năm lần."
  },
  RelicConfig_69321_Desc = {
    Text = "Khi chiến đấu bắt đầu, giới hạn sức tính toán +1, thức tỉnh tất cả các thân thể được đánh thức. Vào đầu lượt lẻ, phát hiện một sáng tạo, tổng cộng phát hiện năm lần."
  },
  RelicConfig_69321_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「lời cầu nguyệnδ」>"
  },
  RelicConfig_70042_BattleDesc = {
    Text = "Vào đầu lượt, tích lũy 1 điểm \"hố sâu nguyên năng\", chọn \"trầm miên(giấc ngủ sâu)\" hoặc \"tỉnh giấc(thức tỉnh)\". Trầm miên: Tích lũy thêm 1 điểm \"hố sâu nguyên năng\". Tỉnh giấc: Tiêu thụ 1/5/10 điểm \"hố sâu nguyên năng\", nhận được sự giúp đỡ từ tulô. Số điểm \"hố sâu nguyên năng\" tiêu thụ càng nhiều, hiệu quả hỗ trợ của tulô càng mạnh."
  },
  RelicConfig_70042_Desc = {
    Text = "Vào đầu lượt, tích lũy 1 điểm \"hố sâu nguyên năng\", chọn \"trầm miên(giấc ngủ sâu)\" hoặc \"tỉnh giấc(thức tỉnh)\". Trầm miên: Tích lũy thêm 1 điểm \"hố sâu nguyên năng\". Tỉnh giấc: Tiêu thụ 1/5/10 điểm \"hố sâu nguyên năng\", nhận được sự giúp đỡ từ tulô. Số điểm \"hố sâu nguyên năng\" tiêu thụ càng nhiều, hiệu quả hỗ trợ của tulô càng mạnh."
  },
  RelicConfig_70042_Name = {
    Text = "<OrangeQuality:Quyền năng của Thần vương>"
  },
  RelicConfig_70084_BattleDesc = {
    Text = "Khi chiến đấu bắt đầu, trộn tất cả các \"Thức tỉnh linh tri\" vào bộ bài để rút."
  },
  RelicConfig_70084_Desc = {
    Text = "Khi chiến đấu bắt đầu, trộn tất cả các \"Thức tỉnh linh tri\" vào bộ bài để rút."
  },
  RelicConfig_70084_Name = {
    Text = "<OrangeQuality:Thức tỉnh linh tri thức>"
  },
  RelicConfig_70700_BattleDesc = {
    Text = "Tất cả thân thể được đánh thức gây thêm [Arg1]% thương cơ bản."
  },
  RelicConfig_70700_Desc = {
    Text = "Tất cả thân thể được đánh thức gây thêm [Arg1]% thương cơ bản."
  },
  RelicConfig_70700_Name = {
    Text = "<WhiteQuality:Ống điếu Khóc>"
  },
  RelicConfig_70700_StoryDesc = {
    Text = "Đây cuối cùng là kết quả của lòng thù hận, hay hậu quả của sự trả thù?"
  },
  RelicConfig_70701_BattleDesc = {
    Text = "Vào đầu lượt, tất cả các thân thể được đánh thức nhận được [Arg1] sức mạnh điên cuồng."
  },
  RelicConfig_70701_Desc = {
    Text = "Vào đầu lượt, tất cả các thân thể được đánh thức nhận được [Arg1] sức mạnh điên cuồng."
  },
  RelicConfig_70701_Name = {
    Text = "<WhiteQuality:pin nguyên mẫu>"
  },
  RelicConfig_70701_StoryDesc = {
    Text = "Hy vọng bỏ túi."
  },
  RelicConfig_70702_BattleDesc = {
    Text = "Sau khi kích hoạt \"cơn thịnh nộ bùng phát\", nhận được [Arg1] <PowerIconKeywords:lực lượng> tạm thời."
  },
  RelicConfig_70702_Desc = {
    Text = "Sau khi kích hoạt \"cơn thịnh nộ bùng phát\", nhận được [Arg1] <PowerIconKeywords:lực lượng> tạm thời."
  },
  RelicConfig_70702_Name = {
    Text = "<OrangeQuality:Khóa Nặng+>"
  },
  RelicConfig_70702_StoryDesc = {
    Text = "Khóa dày và chắc chắn, nếu không có chìa khóa, chắc hẳn rất khó để mở. \nTất nhiên, điều này đối với một siêu trộm thì không đáng kể."
  },
  RelicConfig_70703_BattleDesc = {
    Text = "\"đánh\" gây thêm sát thương tương đương với [Arg1]% sức tấn công của thân thể được đánh thức, mỗi lượt tối đa kích hoạt 3 lần."
  },
  RelicConfig_70703_Desc = {
    Text = "\"đánh\" gây thêm sát thương tương đương với [Arg1]% sức tấn công của thân thể được đánh thức, mỗi lượt tối đa kích hoạt 3 lần."
  },
  RelicConfig_70703_Name = {
    Text = "<WhiteQuality:dao lá liễu rỉ sét>"
  },
  RelicConfig_70703_StoryDesc = {
    Text = "Không thích hợp để cắt vào cơ thể sống."
  },
  RelicConfig_70704_BattleDesc = {
    Text = "Sử dụng chìa khóa bạc để thức tỉnh, sau đó gây [Arg1] <IntoxicationIconKeywords:trúng độc> cho tất cả kẻ địch và nhận được [Arg2] năng lượng bạc."
  },
  RelicConfig_70704_Desc = {
    Text = "Sử dụng chìa khóa bạc để thức tỉnh, sau đó gây [Arg1] <IntoxicationIconKeywords:trúng độc> cho tất cả kẻ địch và nhận được [Arg2] năng lượng bạc."
  },
  RelicConfig_70704_Name = {
    Text = "<OrangeQuality:thuốc mỡ đáng ngờ+>"
  },
  RelicConfig_70704_StoryDesc = {
    Text = "Một loại thuốc mỡ tự chế để điều trị vết thương, xin đừng sử dụng nếu không có hướng dẫn của bác sĩ."
  },
  RelicConfig_70705_BattleDesc = {
    Text = "\"đánh\" gây sát thương [Arg1]% <IntoxicationIconKeywords:trúng độc>, mỗi lượt tối đa [Arg2] điểm."
  },
  RelicConfig_70705_Desc = {
    Text = "\"đánh\" gây sát thương [Arg1]% <IntoxicationIconKeywords:trúng độc>, mỗi lượt tối đa [Arg2] điểm."
  },
  RelicConfig_70705_Name = {
    Text = "<OrangeQuality:lưỡi loài khác+>"
  },
  RelicConfig_70705_StoryDesc = {
    Text = "Ngài không phải là quỷ, nhưng Ngài thực sự truyền đạt lời thì thầm vượt ngoài thế giới loài người."
  },
  RelicConfig_70706_BattleDesc = {
    Text = "<EmbryoFusionIconKeywords:sự hợp nhất phôi thai> tự động nhận được lượng tăng [Arg1]%."
  },
  RelicConfig_70706_Desc = {
    Text = "<EmbryoFusionIconKeywords:sự hợp nhất phôi thai> tự động nhận được lượng tăng [Arg1]%."
  },
  RelicConfig_70706_Name = {
    Text = "<WhiteQuality:giấy chẩn đoán dịch bệnh>"
  },
  RelicConfig_70706_StoryDesc = {
    Text = "Dịch bệnh —— biểu hiện tình cờ của sự bực bội vô thức của thiên nhiên."
  },
  RelicConfig_70707_BattleDesc = {
    Text = "Sau khi Bạc Khóa Tỉnh Thức, tất cả thân thể được đánh thức nhận [Arg1] điên cuồng và [Arg2] năng lượng chìa khóa bạc."
  },
  RelicConfig_70707_Desc = {
    Text = "Sau khi Bạc Khóa Tỉnh Thức, tất cả thân thể được đánh thức nhận [Arg1] điên cuồng và [Arg2] năng lượng chìa khóa bạc."
  },
  RelicConfig_70707_Name = {
    Text = "<OrangeQuality:khuy áo lá quế+>"
  },
  RelicConfig_70707_StoryDesc = {
    Text = "Cuffs bạc khắc hoa lá quế. \nTinh xảo và lấp lánh, lưu giữ tình bạn của hai đứa trẻ."
  },
  RelicConfig_70708_BattleDesc = {
    Text = "Sau khi trận chiến bắt đầu, nhận được [Arg1] <ProficientInRealmsIconKeywords:giới vực thông thạo>. Tất cả các thân thể được đánh thức và các sáng tạo gây ra <IntoxicationIconKeywords:trúng độc> tăng [Arg2]%."
  },
  RelicConfig_70708_Desc = {
    Text = "Sau khi trận chiến bắt đầu, nhận được [Arg1] <ProficientInRealmsIconKeywords:giới vực thông thạo>. Tất cả các thân thể được đánh thức và các sáng tạo gây ra <IntoxicationIconKeywords:trúng độc> tăng [Arg2]%."
  },
  RelicConfig_70708_Name = {
    Text = "<OrangeQuality:máy may phủ bụi+>"
  },
  RelicConfig_70708_StoryDesc = {
    Text = "Một người mẹ hiền từ, hàn gắn những vết thương trong trái tim."
  },
  RelicConfig_70709_BattleDesc = {
    Text = "Sau khi vào lượt siêu việt, lá thẻ lệnh không phải dạng phái sinh được đánh ra đầu tiên sẽ có hiệu lực thêm [Arg1] lần."
  },
  RelicConfig_70709_Desc = {
    Text = "Sau khi vào lượt siêu việt, lá thẻ lệnh không phải dạng phái sinh được đánh ra đầu tiên sẽ có hiệu lực thêm [Arg1] lần."
  },
  RelicConfig_70709_Name = {
    Text = "<WhiteQuality:ánh sáng đồng hồ cát>"
  },
  RelicConfig_70709_StoryDesc = {
    Text = "Một khoảng thời gian có thể đo lường được."
  },
  RelicConfig_70711_BattleDesc = {
    Text = "Sau khi Bạc Khóa Tỉnh Thức, nhận được [Arg1] <RetaliateIconKeywords:phản công> và [Arg2] năng lượng chìa khóa bạc."
  },
  RelicConfig_70711_Desc = {
    Text = "Sau khi Bạc Khóa Tỉnh Thức, nhận được [Arg1] <RetaliateIconKeywords:phản công> và [Arg2] năng lượng chìa khóa bạc."
  },
  RelicConfig_70711_Name = {
    Text = "<OrangeQuality:chương đoạn trước đó +>"
  },
  RelicConfig_70711_StoryDesc = {
    Text = "\"Con người thật ngu ngốc, chỉ vì sự cũ kỹ mà mù quáng tin theo.\""
  },
  RelicConfig_70712_BattleDesc = {
    Text = "Sau khi Bạc Khóa Tỉnh Thức, bạn sẽ nhận được [Arg1] <PowerIconKeywords:lực lượng> và [Arg2] năng lượng chìa khóa bạc."
  },
  RelicConfig_70712_Desc = {
    Text = "Sau khi Bạc Khóa Tỉnh Thức, bạn sẽ nhận được [Arg1] <PowerIconKeywords:lực lượng> và [Arg2] năng lượng chìa khóa bạc."
  },
  RelicConfig_70712_Name = {
    Text = "<WhiteQuality:nhà chúng tôi>"
  },
  RelicConfig_70712_StoryDesc = {
    Text = "Họ đã từng ở bên nhau, và sau này cũng sẽ mãi mãi ở bên nhau. Họ là một gia đình hòa thuận và đoàn kết."
  },
  RelicConfig_70713_BattleDesc = {
    Text = "Khi mất sức sống, nhận được [Arg1]% lượng sức sống mất đi dưới dạng lò luyện màu đỏ thẫm."
  },
  RelicConfig_70713_Desc = {
    Text = "Khi mất sức sống, nhận được [Arg1]% lượng sức sống mất đi dưới dạng lò luyện màu đỏ thẫm."
  },
  RelicConfig_70713_Name = {
    Text = "<WhiteQuality:cưa thép bị gỉ>"
  },
  RelicConfig_70713_StoryDesc = {
    Text = "Bác sĩ giải phẫu suốt đời không nhìn thấy người phụ nữ đẹp. Họ chỉ có một bao xương, dây thần kinh viêm do bệnh tật, cơ bắp và mô."
  },
  RelicConfig_70714_BattleDesc = {
    Text = "Sau khi chiến đấu bắt đầu, nhận được [Arg1] <ProficientInRealmsIconKeywords:giới vực thông thạo>. Tất cả các thân thể được đánh thức gây ra <RetaliateIconKeywords:phản công> và các sáng tạo gây ra <RetaliateIconKeywords:phản công> tăng [Arg2]%."
  },
  RelicConfig_70714_Desc = {
    Text = "Sau khi chiến đấu bắt đầu, nhận được [Arg1] <ProficientInRealmsIconKeywords:giới vực thông thạo>. Tất cả các thân thể được đánh thức gây ra <RetaliateIconKeywords:phản công> và các sáng tạo gây ra <RetaliateIconKeywords:phản công> tăng [Arg2]%."
  },
  RelicConfig_70714_Name = {
    Text = "<WhiteQuality:không giấu điều gì>"
  },
  RelicConfig_70714_StoryDesc = {
    Text = "Nó truyền đạt vô số bí mật nói ra một cách chủ động hoặc bị động."
  },
  RelicConfig_70715_BattleDesc = {
    Text = "Sau khi sử dụng Bạc Khóa Tỉnh Thức, rút [Arg1] lá bài và nhận [Arg2] năng lượng chìa khóa bạc."
  },
  RelicConfig_70715_Desc = {
    Text = "Sau khi sử dụng Bạc Khóa Tỉnh Thức, rút [Arg1] lá bài và nhận [Arg2] năng lượng chìa khóa bạc."
  },
  RelicConfig_70715_Name = {
    Text = "<OrangeQuality:ví tiền mới tinh +>"
  },
  RelicConfig_70715_StoryDesc = {
    Text = "Ví da được in dấu huy hiệu của Đại học Misag. \nBây giờ bên trong trống rỗng, không có gì cả."
  },
  RelicConfig_70717_BattleDesc = {
    Text = "Vào đầu lượt, rút [Arg1] quân bài."
  },
  RelicConfig_70717_Desc = {
    Text = "Vào đầu lượt, rút [Arg1] quân bài."
  },
  RelicConfig_70717_Name = {
    Text = "<OrangeQuality:La bàn định hướng+>"
  },
  RelicConfig_70717_StoryDesc = {
    Text = "Điều được chỉ ra không phải là hướng, mà chỉ là từ trường."
  },
  RelicConfig_70718_BattleDesc = {
    Text = "Sau khi sử dụng \"Bùng nổ\", khiến tất cả kẻ địch nhận [Arg1] điểm <FixedDamage:Sát Thương Thuần Túy>, và kích hoạt <IntoxicationIconKeywords:Ngộ độc> [Arg2]%."
  },
  RelicConfig_70718_Desc = {
    Text = "Sau khi sử dụng \"Bùng nổ\", khiến tất cả kẻ địch nhận 1 lần <FixedDamage:Sát Thương Thuần Túy> bằng [Arg2]% Sinh lực tối đa của ta, và kích hoạt <IntoxicationIconKeywords:Ngộ độc> [Arg2]%."
  },
  RelicConfig_70718_Name = {
    Text = "<WhiteQuality:Hàm Xương Laser>"
  },
  RelicConfig_70718_StoryDesc = {
    Text = "Xương cốt được trưng bày trong phòng triển lãm tư nhân của một nhà sưu tập. \nNhà sưu tập mê đắm ánh huỳnh quang tuyệt đẹp, ngày đêm chiêm ngưỡng, cuối cùng héo mòn và trở thành đồng loại với nó."
  },
  RelicConfig_70719_BattleDesc = {
    Text = "Vào đầu lượt, tất cả các thân thể được đánh thức nhận được [Arg1] sức mạnh điên cuồng."
  },
  RelicConfig_70719_Desc = {
    Text = "Vào đầu lượt, tất cả các thân thể được đánh thức nhận được [Arg1] sức mạnh điên cuồng."
  },
  RelicConfig_70719_Name = {
    Text = "<OrangeQuality:pin nguyên mẫu+>"
  },
  RelicConfig_70719_StoryDesc = {
    Text = "Hy vọng bỏ túi."
  },
  RelicConfig_70720_BattleDesc = {
    Text = "Vào đầu lượt, nếu sức sống dưới 25%, nhận [Arg1] tạm thời <PowerIconKeywords:lực lượng> tạm thời."
  },
  RelicConfig_70720_Desc = {
    Text = "Vào đầu lượt, nếu sức sống dưới 25%, nhận [Arg1] tạm thời <PowerIconKeywords:lực lượng> tạm thời."
  },
  RelicConfig_70720_Name = {
    Text = "<WhiteQuality:vinh quang vô song>"
  },
  RelicConfig_70720_StoryDesc = {
    Text = "Con mèo đen lông ngắn thanh lịch, bí ẩn, được cho là hiện thân của một vị thần trong một vùng đất sa mạc xa xôi. Nhưng tên gọi của vị thần đó, hiện nay đã không ai biết đến. \n Bị tôn thờ, bị ngưỡng mộ, bị lãng quên, có lẽ là số mệnh của một vị thần."
  },
  RelicConfig_70721_BattleDesc = {
    Text = "Sau khi sử dụng 4 lần \"điên cuồng bùng phát\" trong một lượt, nhận được [Arg1] sức tính toán, làm mới sau 3 lượt."
  },
  RelicConfig_70721_Desc = {
    Text = "Sau khi sử dụng 4 lần \"điên cuồng bùng phát\" trong một lượt, nhận được [Arg1] sức tính toán, làm mới sau 3 lượt."
  },
  RelicConfig_70721_Name = {
    Text = "<WhiteQuality:máy chênh lệch bạc trắng>"
  },
  RelicConfig_70721_StoryDesc = {
    Text = "\"Nó đã thay đổi lịch sử.\""
  },
  RelicConfig_70722_BattleDesc = {
    Text = "Sau khi Bạc Khóa Tỉnh Thức, bạn sẽ nhận được [Arg1] <PowerIconKeywords:lực lượng> và [Arg2] năng lượng chìa khóa bạc."
  },
  RelicConfig_70722_Desc = {
    Text = "Sau khi Bạc Khóa Tỉnh Thức, bạn sẽ nhận được [Arg1] <PowerIconKeywords:lực lượng> và [Arg2] năng lượng chìa khóa bạc."
  },
  RelicConfig_70722_Name = {
    Text = "<OrangeQuality:nhà của chúng tôi+>"
  },
  RelicConfig_70722_StoryDesc = {
    Text = "Họ đã từng ở bên nhau, và sau này cũng sẽ mãi mãi ở bên nhau. Họ là một gia đình hòa thuận và đoàn kết."
  },
  RelicConfig_70723_BattleDesc = {
    Text = "Khi liên tiếp đánh 2 thẻ bài có sức tính toán tiêu thụ cao hơn lá trước, nhận được [Arg1] <RetaliateIconKeywords:phản công>. Mỗi lượt tối đa kích hoạt 3 lần."
  },
  RelicConfig_70723_Desc = {
    Text = "Khi liên tiếp đánh 2 thẻ bài có sức tính toán tiêu thụ cao hơn lá trước, nhận được [Arg1] <RetaliateIconKeywords:phản công>. Mỗi lượt tối đa kích hoạt 3 lần."
  },
  RelicConfig_70723_Name = {
    Text = "<OrangeQuality:Arcana ký lục+>"
  },
  RelicConfig_70723_StoryDesc = {
    Text = "Diễn biến số phận"
  },
  RelicConfig_70724_BattleDesc = {
    Text = "Khi bắt đầu chiến đấu, nhận được [Arg1] <PowerIconKeywords:lực lượng>."
  },
  RelicConfig_70724_Desc = {
    Text = "Khi bắt đầu chiến đấu, nhận được [Arg1] <PowerIconKeywords:lực lượng>."
  },
  RelicConfig_70724_Name = {
    Text = "<OrangeQuality:móc cài áo hồng ngọc+>"
  },
  RelicConfig_70724_StoryDesc = {
    Text = "Lờ mờ thấm ra màu đỏ thắm."
  },
  RelicConfig_70725_BattleDesc = {
    Text = "Sau khi chiến đấu bắt đầu, áp dụng [Arg1] lớp<WeaknessIconKeywords:yếu đuối> lên tất cả kẻ thù, hiệu ứng tăng gấp đôi trong trận chiến với boss. Tất cả thân thể được đánh thức gây ra thương cơ bản tăng [Arg2]%."
  },
  RelicConfig_70725_Desc = {
    Text = "Sau khi chiến đấu bắt đầu, áp dụng [Arg1] lớp<WeaknessIconKeywords:yếu đuối> lên tất cả kẻ thù, hiệu ứng tăng gấp đôi trong trận chiến với boss. Tất cả thân thể được đánh thức gây ra thương cơ bản tăng [Arg2]%."
  },
  RelicConfig_70725_Name = {
    Text = "<OrangeQuality:ác đồng+>"
  },
  RelicConfig_70725_StoryDesc = {
    Text = "Bắt nguồn từ cái ác thuần túy, dù điều đó không phải là ý nguyện của nó."
  },
  RelicConfig_70726_BattleDesc = {
    Text = "Hủy diệt nhận được [Arg1] lá chắn, 3 lượt thời gian hồi chiêu."
  },
  RelicConfig_70726_Desc = {
    Text = "Hủy diệt nhận được [Arg1] lá chắn, 3 lượt thời gian hồi chiêu."
  },
  RelicConfig_70726_Name = {
    Text = "<WhiteQuality:Đồng hồ siêu huyền>"
  },
  RelicConfig_70726_StoryDesc = {
    Text = "\"Ái chà, đồng hồ bỏ túi đã dừng rồi.\""
  },
  RelicConfig_70727_BattleDesc = {
    Text = "Vào cuối lượt, phục hồi [Heal:Arg1] sức sống."
  },
  RelicConfig_70727_Desc = {
    Text = "Vào cuối lượt, phục hồi [Heal:Arg1] sức sống."
  },
  RelicConfig_70727_Name = {
    Text = "<OrangeQuality:Máu ân huệ+>"
  },
  RelicConfig_70727_StoryDesc = {
    Text = "Nó ngọt ngào và đậm đà, toả ra hương thơm của hoa hồng."
  },
  RelicConfig_70728_BattleDesc = {
    Text = "Sử dụng tư thế Biển Yên khiến tất cả kẻ địch mất [Arg1] điểm <ExhaustionIconKeywords:lực lượng> tạm thời, hồi chiêu trong 3 lượt."
  },
  RelicConfig_70728_Desc = {
    Text = "Sử dụng tư thế Biển Yên khiến tất cả kẻ địch mất [Arg1] điểm <ExhaustionIconKeywords:lực lượng> tạm thời, hồi chiêu trong 3 lượt."
  },
  RelicConfig_70728_Name = {
    Text = "<OrangeQuality:chiếc chân không tên+>"
  },
  RelicConfig_70728_StoryDesc = {
    Text = "Cẩn thận kẻo bị đâm tay."
  },
  RelicConfig_70730_BattleDesc = {
    Text = "Khi bắt đầu chiến đấu, nhận được [Arg1] <PowerIconKeywords:lực lượng>."
  },
  RelicConfig_70730_Desc = {
    Text = "Khi bắt đầu chiến đấu, nhận được [Arg1] <PowerIconKeywords:lực lượng>."
  },
  RelicConfig_70730_Name = {
    Text = "<WhiteQuality:trâm cài hồng ngọc>"
  },
  RelicConfig_70730_StoryDesc = {
    Text = "Lờ mờ thấm ra màu đỏ thắm."
  },
  RelicConfig_70731_BattleDesc = {
    Text = "Khi bị kẻ địch tấn công, khiến chúng nhận [Arg1] điểm <FixedDamage:Sát Thương Thuần Túy>, sát thương này được hưởng bonus <RetaliateIconKeywords:phản công> [Arg2]%, mỗi kẻ địch kích hoạt tối đa 1 lần mỗi lượt."
  },
  RelicConfig_70731_Desc = {
    Text = "Khi bị kẻ địch tấn công, khiến chúng nhận <FixedDamage:Sát Thương Thuần Túy> bằng [Arg3]% Sinh lực tối đa của ta, sát thương này được hưởng bonus <RetaliateIconKeywords:phản công> [Arg2]%, mỗi kẻ địch kích hoạt tối đa 1 lần mỗi lượt."
  },
  RelicConfig_70731_Name = {
    Text = "<OrangeQuality:dao tế lễ bị bỏ quên+>"
  },
  RelicConfig_70731_StoryDesc = {
    Text = "Dao có lưỡi cong, thường được sử dụng trong các nghi lễ tế lễ."
  },
  RelicConfig_70732_BattleDesc = {
    Text = "Sau khi vào lượt siêu việt, lá thẻ lệnh không phải dạng phái sinh được đánh ra đầu tiên sẽ có hiệu lực thêm [Arg1] lần."
  },
  RelicConfig_70732_Desc = {
    Text = "Sau khi vào lượt siêu việt, lá thẻ lệnh không phải dạng phái sinh được đánh ra đầu tiên sẽ có hiệu lực thêm [Arg1] lần."
  },
  RelicConfig_70732_Name = {
    Text = "<OrangeQuality:ánh sáng đồng hồ cát+>"
  },
  RelicConfig_70732_StoryDesc = {
    Text = "Một khoảng thời gian có thể đo lường được."
  },
  RelicConfig_70733_BattleDesc = {
    Text = "<EmbryoFusionIconKeywords:sự hợp nhất phôi thai> tự động nhận được lượng tăng [Arg1]%."
  },
  RelicConfig_70733_Desc = {
    Text = "<EmbryoFusionIconKeywords:sự hợp nhất phôi thai> tự động nhận được lượng tăng [Arg1]%."
  },
  RelicConfig_70733_Name = {
    Text = "<OrangeQuality:giấy chẩn đoán bệnh dịch+>"
  },
  RelicConfig_70733_StoryDesc = {
    Text = "Dịch bệnh —— biểu hiện tình cờ của sự bực bội vô thức của thiên nhiên."
  },
  RelicConfig_70734_BattleDesc = {
    Text = "Sau khi sử dụng Bạc Khóa Tỉnh Thức, tất cả thân thể được đánh thức sẽ tăng [Arg1]% sát thương cơ bản và nhận [Arg2] năng lượng chìa khóa bạc."
  },
  RelicConfig_70734_Desc = {
    Text = "Sau khi sử dụng Bạc Khóa Tỉnh Thức, tất cả thân thể được đánh thức sẽ tăng [Arg1]% sát thương cơ bản và nhận [Arg2] năng lượng chìa khóa bạc."
  },
  RelicConfig_70734_Name = {
    Text = "<WhiteQuality:bí điển tinh tượng nghi thức>"
  },
  RelicConfig_70734_StoryDesc = {
    Text = "Bí ẩn của vũ trụ."
  },
  RelicConfig_70735_BattleDesc = {
    Text = "Khi bạn đánh ra 2 thẻ tiêu tốn sức mạnh tính toán thấp hơn thẻ trước đó, áp dụng [Arg1] <IntoxicationIconKeywords:Độc dược> lên tất cả kẻ thù, tối đa 3 lần mỗi lượt."
  },
  RelicConfig_70735_Desc = {
    Text = "Khi bạn đánh ra 2 thẻ tiêu tốn sức mạnh tính toán thấp hơn thẻ trước đó, áp dụng [Arg1] <IntoxicationIconKeywords:Độc dược> lên tất cả kẻ thù, tối đa 3 lần mỗi lượt."
  },
  RelicConfig_70735_Name = {
    Text = "<OrangeQuality:Di vật Arcana +>"
  },
  RelicConfig_70735_StoryDesc = {
    Text = "Số phận cuối cùng."
  },
  RelicConfig_70736_BattleDesc = {
    Text = "Sử dụng tư thế Biển Yên khiến tất cả kẻ địch mất [Arg1] điểm <ExhaustionIconKeywords:lực lượng> tạm thời, hồi chiêu trong 3 lượt."
  },
  RelicConfig_70736_Desc = {
    Text = "Sử dụng tư thế Biển Yên khiến tất cả kẻ địch mất [Arg1] điểm <ExhaustionIconKeywords:lực lượng> tạm thời, hồi chiêu trong 3 lượt."
  },
  RelicConfig_70736_Name = {
    Text = "<WhiteQuality:phụ tùng vô danh>"
  },
  RelicConfig_70736_StoryDesc = {
    Text = "Cẩn thận kẻo bị đâm tay."
  },
  RelicConfig_70737_BattleDesc = {
    Text = "Đánh ra thẻ bài, nếu số lượng thẻ bài trong tay nhỏ hơn hoặc bằng [Arg1], rút [Arg2] thẻ bài, mỗi lượt có thể kích hoạt tối đa [Arg3] lần."
  },
  RelicConfig_70737_Desc = {
    Text = "Đánh ra thẻ bài, nếu số lượng thẻ bài trong tay nhỏ hơn hoặc bằng [Arg1], rút [Arg2] thẻ bài, mỗi lượt có thể kích hoạt tối đa [Arg3] lần."
  },
  RelicConfig_70737_Name = {
    Text = "<WhiteQuality:găng tay ma thuật>"
  },
  RelicConfig_70737_StoryDesc = {
    Text = "\"Đừng sợ hãi, đây chỉ là ảo thuật!\""
  },
  RelicConfig_70738_BattleDesc = {
    Text = "Vào cuối lượt, phục hồi [Heal:Arg1] sức sống."
  },
  RelicConfig_70738_Desc = {
    Text = "Vào cuối lượt, phục hồi [Heal:Arg1] sức sống."
  },
  RelicConfig_70738_Name = {
    Text = "<WhiteQuality:Máu ban ơn>"
  },
  RelicConfig_70738_StoryDesc = {
    Text = "Nó ngọt ngào và đậm đà, toả ra hương thơm của hoa hồng."
  },
  RelicConfig_70739_BattleDesc = {
    Text = "Sau khi Bạc Khóa Tỉnh Thức, bạn sẽ nhận được [Arg1] lá chắn và [Arg2] năng lượng chìa khóa bạc."
  },
  RelicConfig_70739_Desc = {
    Text = "Sau khi Bạc Khóa Tỉnh Thức, bạn sẽ nhận được [Arg1] lá chắn và [Arg2] năng lượng chìa khóa bạc."
  },
  RelicConfig_70739_Name = {
    Text = "<WhiteQuality:bướm tiêu bản>"
  },
  RelicConfig_70739_StoryDesc = {
    Text = "Đến nay, anh ấy vẫn được ai đó thương mến rất nhiều."
  },
  RelicConfig_70740_BattleDesc = {
    Text = "Sau khi sử dụng Bạc Khóa Tỉnh Thức, tất cả thân thể được đánh thức sẽ tăng [Arg1]% sát thương cơ bản và nhận [Arg2] năng lượng chìa khóa bạc."
  },
  RelicConfig_70740_Desc = {
    Text = "Sau khi sử dụng Bạc Khóa Tỉnh Thức, tất cả thân thể được đánh thức sẽ tăng [Arg1]% sát thương cơ bản và nhận [Arg2] năng lượng chìa khóa bạc."
  },
  RelicConfig_70740_Name = {
    Text = "<OrangeQuality:bí điển tinh tượng nghi>+"
  },
  RelicConfig_70740_StoryDesc = {
    Text = "Bí ẩn của vũ trụ."
  },
  RelicConfig_70741_BattleDesc = {
    Text = "Sức tính toán tối đa tăng [Arg1] ."
  },
  RelicConfig_70741_Desc = {
    Text = "Sức tính toán tối đa tăng [Arg1] ."
  },
  RelicConfig_70741_Name = {
    Text = "<OrangeQuality:bơm tiêm hoạt tính+>"
  },
  RelicConfig_70741_StoryDesc = {
    Text = "Co giật cũng là một dạng năng lượng."
  },
  RelicConfig_70742_BattleDesc = {
    Text = "Khi trận chiến bắt đầu, giới hạn râu chạm tăng thêm [Arg1], nhận được [Arg2] râu chạm."
  },
  RelicConfig_70742_Desc = {
    Text = "Khi trận chiến bắt đầu, giới hạn râu chạm tăng thêm [Arg1], nhận được [Arg2] râu chạm."
  },
  RelicConfig_70742_Name = {
    Text = "<WhiteQuality:Bài ca của Biển>"
  },
  RelicConfig_70742_StoryDesc = {
    Text = "Nghe nói rằng ốc vân và các động vật không ăn được hấp thụ khoảng 80% dinh dưỡng của đại dương."
  },
  RelicConfig_70743_BattleDesc = {
    Text = "Mỗi lượt, khi <DevouredIconKeywords:nuốt chửng> lần đầu, các thân thể được đánh thức khác nhận được [Arg1] điên cuồng."
  },
  RelicConfig_70743_Desc = {
    Text = "Mỗi lượt, khi <DevouredIconKeywords:nuốt chửng> lần đầu, các thân thể được đánh thức khác nhận được [Arg1] điên cuồng."
  },
  RelicConfig_70743_Name = {
    Text = "<WhiteQuality:Giấc Mơ Vàng>"
  },
  RelicConfig_70743_StoryDesc = {
    Text = "Ngày chuyển hóa chính là ngày chết của bạn."
  },
  RelicConfig_70744_BattleDesc = {
    Text = "Sau khi đánh thẻ lệnh không phải là thẻ phái sinh, giảm tiêu thụ sức tính toán của thẻ đó đi 2 và đưa [Arg1] bản sao tạm thời vào rút bài từ bộ bài, làm mới sau 3 lượt."
  },
  RelicConfig_70744_Desc = {
    Text = "Sau khi đánh thẻ lệnh không phải là thẻ phái sinh, giảm tiêu thụ sức tính toán của thẻ đó đi 2 và đưa [Arg1] bản sao tạm thời vào rút bài từ bộ bài, làm mới sau 3 lượt."
  },
  RelicConfig_70744_Name = {
    Text = "<OrangeQuality:máy hát bị mất giọng +>"
  },
  RelicConfig_70744_StoryDesc = {
    Text = "Giọng của anh ấy biến mất trong gió."
  },
  RelicConfig_70745_BattleDesc = {
    Text = "Khi trận chiến bắt đầu, nhận được [Arg1] <RetaliateIconKeywords:phản công>, hiệu ứng trong trận đấu với thủ lĩnh tăng gấp đôi."
  },
  RelicConfig_70745_Desc = {
    Text = "Khi trận chiến bắt đầu, nhận được [Arg1] <RetaliateIconKeywords:phản công>, hiệu ứng trong trận đấu với thủ lĩnh tăng gấp đôi."
  },
  RelicConfig_70745_Name = {
    Text = "<OrangeQuality:áo giáp cây gai+>"
  },
  RelicConfig_70745_StoryDesc = {
    Text = "Không thể phân biệt chất lỏng lạ."
  },
  RelicConfig_70746_BattleDesc = {
    Text = "Vào đầu lượt, nếu sức sống dưới 25%, nhận [Arg1] tạm thời <PowerIconKeywords:lực lượng> tạm thời."
  },
  RelicConfig_70746_Desc = {
    Text = "Vào đầu lượt, nếu sức sống dưới 25%, nhận [Arg1] tạm thời <PowerIconKeywords:lực lượng> tạm thời."
  },
  RelicConfig_70746_Name = {
    Text = "<OrangeQuality:vô thượng vinh sủng+>"
  },
  RelicConfig_70746_StoryDesc = {
    Text = "Con mèo lông ngắn màu đen thanh lịch và bí ẩn, được cho là hiện thân của thần linh ở một vương quốc sa mạc xa xôi nào đó. Nhưng cái tên của vị thần ấy, hiện nay không ai còn biết đến. \nBị tôn thờ, bị ngưỡng mộ, bị lãng quên, có lẽ đó là số mệnh của thần linh."
  },
  RelicConfig_70747_BattleDesc = {
    Text = "Đánh ra thẻ bài, nếu số lượng thẻ bài trong tay nhỏ hơn hoặc bằng [Arg1], rút [Arg2] thẻ bài, mỗi lượt có thể kích hoạt tối đa [Arg3] lần."
  },
  RelicConfig_70747_Desc = {
    Text = "Đánh ra thẻ bài, nếu số lượng thẻ bài trong tay nhỏ hơn hoặc bằng [Arg1], rút [Arg2] thẻ bài, mỗi lượt có thể kích hoạt tối đa [Arg3] lần."
  },
  RelicConfig_70747_Name = {
    Text = "<OrangeQuality:đôi găng tay phù thủy+>"
  },
  RelicConfig_70747_StoryDesc = {
    Text = "\"Đừng sợ hãi, đây chỉ là ảo thuật!\""
  },
  RelicConfig_70748_BattleDesc = {
    Text = "Sau khi Bạc Khóa Tỉnh Thức, bạn sẽ nhận được [Arg1] lá chắn và [Arg2] năng lượng chìa khóa bạc."
  },
  RelicConfig_70748_Desc = {
    Text = "Sau khi Bạc Khóa Tỉnh Thức, bạn sẽ nhận được [Arg1] lá chắn và [Arg2] năng lượng chìa khóa bạc."
  },
  RelicConfig_70748_Name = {
    Text = "<OrangeQuality:bướm tiêu bản+>"
  },
  RelicConfig_70748_StoryDesc = {
    Text = "Đến nay, anh ấy vẫn được ai đó thương mến rất nhiều."
  },
  RelicConfig_70749_BattleDesc = {
    Text = "Mỗi khi một thẻ bài vào không gian siêu việt, nếu thẻ bài này có chủ sở hữu khác với các thẻ bài trong không gian siêu việt khác, thì đặt [Arg1] thẻ <DerivativeCardKeywords_4:「cảm hứng」> vào tay."
  },
  RelicConfig_70749_Desc = {
    Text = "Mỗi khi một thẻ bài vào không gian siêu việt, nếu thẻ bài này có chủ sở hữu khác với các thẻ bài trong không gian siêu việt khác, thì đặt [Arg1] thẻ <DerivativeCardKeywords_4:「cảm hứng」> vào tay."
  },
  RelicConfig_70749_Name = {
    Text = "<OrangeQuality:Vũ khí của Alfonso+>"
  },
  RelicConfig_70749_StoryDesc = {
    Text = "Khác với số phận vô thường, các vì sao có quy luật vận hành riêng."
  },
  RelicConfig_70750_BattleDesc = {
    Text = "Khi liên tiếp đánh 2 thẻ bài có sức tính toán tiêu thụ cao hơn lá trước, nhận được [Arg1] <RetaliateIconKeywords:phản công>. Mỗi lượt tối đa kích hoạt 3 lần."
  },
  RelicConfig_70750_Desc = {
    Text = "Khi liên tiếp đánh 2 thẻ bài có sức tính toán tiêu thụ cao hơn lá trước, nhận được [Arg1] <RetaliateIconKeywords:phản công>. Mỗi lượt tối đa kích hoạt 3 lần."
  },
  RelicConfig_70750_Name = {
    Text = "<WhiteQuality:Arcana Record>"
  },
  RelicConfig_70750_StoryDesc = {
    Text = "Diễn biến số phận"
  },
  RelicConfig_70751_BattleDesc = {
    Text = "Sử dụng Bạc Khóa Tỉnh Thức sẽ nhận được [Arg1] sức tính toán và [Arg2] năng lượng chìa khóa bạc."
  },
  RelicConfig_70751_Desc = {
    Text = "Sử dụng Bạc Khóa Tỉnh Thức sẽ nhận được [Arg1] sức tính toán và [Arg2] năng lượng chìa khóa bạc."
  },
  RelicConfig_70751_Name = {
    Text = "<WhiteQuality:Huy hiệu Misaque>"
  },
  RelicConfig_70751_StoryDesc = {
    Text = "Huy hiệu được Đại học Misaque phân phát cho các điều tra viên. Nó không chỉ tượng trưng cho danh tính của người đeo, mà còn là công cụ hỗ trợ liên lạc từ xa."
  },
  RelicConfig_70752_BattleDesc = {
    Text = "Sau khi Bạc Khóa Tỉnh Thức, nhận được [Arg1] <RetaliateIconKeywords:phản công> và [Arg2] năng lượng chìa khóa bạc."
  },
  RelicConfig_70752_Desc = {
    Text = "Sau khi Bạc Khóa Tỉnh Thức, nhận được [Arg1] <RetaliateIconKeywords:phản công> và [Arg2] năng lượng chìa khóa bạc."
  },
  RelicConfig_70752_Name = {
    Text = "<WhiteQuality:Chương đoạn tiên đoán>"
  },
  RelicConfig_70752_StoryDesc = {
    Text = "\"Con người thật ngu ngốc, chỉ vì sự cũ kỹ mà mù quáng tin theo.\""
  },
  RelicConfig_70753_BattleDesc = {
    Text = "Sau khi chiến đấu bắt đầu, áp dụng [Arg1] lớp <VulnerabilityIconKeywords:Trọng thương> lên tất cả kẻ địch, hiệu ứng trong trận chiến với lãnh đạo gấp đôi. Tất cả thể thức tỉnh gây ra sát thương cơ bản tăng [Arg2]%."
  },
  RelicConfig_70753_Desc = {
    Text = "Sau khi trận chiến bắt đầu, áp dụng [Arg1] lớp <VulnerabilityIconKeywords:Trọng thương> lên tất cả kẻ địch, hiệu ứng trong trận chiến lãnh đạo gấp đôi. Tất cả thể thức tỉnh gây ra sát thương cơ bản tăng [Arg2]%."
  },
  RelicConfig_70753_Name = {
    Text = "<OrangeQuality:Lễ hội Mùa xuân+>"
  },
  RelicConfig_70753_StoryDesc = {
    Text = "Trong tiếng cười rộn ràng của đêm, hình bóng chiếc thuyền độc mộc lướt nhẹ nhàng trên mặt hồ."
  },
  RelicConfig_70754_BattleDesc = {
    Text = "Mỗi lượt, sau khi sử dụng trực tiếp \"phôi thai\" lần đầu tiên, trong lượt này, sát thương chủ động sẽ gây ra [Arg1]% thương tương đương với <BleedingIconKeywords:chảy máu>."
  },
  RelicConfig_70754_Desc = {
    Text = "Mỗi lượt, sau khi sử dụng trực tiếp \"phôi thai\" lần đầu tiên, trong lượt này, sát thương chủ động sẽ gây ra [Arg1]% thương tương đương với <BleedingIconKeywords:chảy máu>."
  },
  RelicConfig_70754_Name = {
    Text = "<WhiteQuality:đá cuội nhuốm máu>"
  },
  RelicConfig_70754_StoryDesc = {
    Text = "Một, hai, ba, bốn, năm."
  },
  RelicConfig_70755_BattleDesc = {
    Text = "Mỗi lần gây thương sẽ nhận được [Arg1] tạm thời <PowerIconKeywords:lực lượng>, mỗi lượt tối đa kích hoạt 15 lần."
  },
  RelicConfig_70755_Desc = {
    Text = "Mỗi lần gây thương sẽ nhận được [Arg1] tạm thời <PowerIconKeywords:lực lượng>, mỗi lượt tối đa kích hoạt 15 lần."
  },
  RelicConfig_70755_Name = {
    Text = "<OrangeQuality:mã não vân tơ+>"
  },
  RelicConfig_70755_StoryDesc = {
    Text = "Đó có lẽ chỉ là hoa văn thạch anh thông thường. Chắc vậy."
  },
  RelicConfig_70756_BattleDesc = {
    Text = "Sử dụng Bạc Khóa Tỉnh Thức sẽ nhận được [Arg1] sức tính toán và [Arg2] năng lượng chìa khóa bạc."
  },
  RelicConfig_70756_Desc = {
    Text = "Sử dụng Bạc Khóa Tỉnh Thức sẽ nhận được [Arg1] sức tính toán và [Arg2] năng lượng chìa khóa bạc."
  },
  RelicConfig_70756_Name = {
    Text = "<OrangeQuality:Huy hiệu Misaque+>"
  },
  RelicConfig_70756_StoryDesc = {
    Text = "Huy hiệu được Đại học Misaque phân phát cho các điều tra viên. Nó không chỉ tượng trưng cho danh tính của người đeo, mà còn là công cụ hỗ trợ liên lạc từ xa."
  },
  RelicConfig_70757_BattleDesc = {
    Text = "Sử dụng tư thế Nộ Đào để kích hoạt tất cả râu chạm tấn công địch [Arg1] lần, 3 lượt hồi chiêu."
  },
  RelicConfig_70757_Desc = {
    Text = "Sử dụng tư thế Nộ Đào để kích hoạt tất cả râu chạm tấn công địch [Arg1] lần, 3 lượt hồi chiêu."
  },
  RelicConfig_70757_Name = {
    Text = "<WhiteQuality:niềm vui của Lo Yen>"
  },
  RelicConfig_70757_StoryDesc = {
    Text = "Bậc chủ tể giấc ngủ sâu, chờ ngươi vào mộng."
  },
  RelicConfig_70758_BattleDesc = {
    Text = "Khi bạn đánh ra 2 thẻ tiêu tốn sức mạnh tính toán thấp hơn thẻ trước đó, áp dụng [Arg1] <IntoxicationIconKeywords:Độc dược> lên tất cả kẻ thù, tối đa 3 lần mỗi lượt."
  },
  RelicConfig_70758_Desc = {
    Text = "Khi bạn đánh ra 2 thẻ tiêu tốn sức mạnh tính toán thấp hơn thẻ trước đó, áp dụng [Arg1] <IntoxicationIconKeywords:Độc dược> lên tất cả kẻ thù, tối đa 3 lần mỗi lượt."
  },
  RelicConfig_70758_Name = {
    Text = "<WhiteQuality:di vật Arkana>"
  },
  RelicConfig_70758_StoryDesc = {
    Text = "Số phận cuối cùng."
  },
  RelicConfig_70759_BattleDesc = {
    Text = "Sau khi chiến đấu bắt đầu, áp dụng [Arg1] lớp<WeaknessIconKeywords:yếu đuối> lên tất cả kẻ thù, hiệu ứng tăng gấp đôi trong trận chiến với boss. Tất cả thân thể được đánh thức gây ra thương cơ bản tăng [Arg2]%."
  },
  RelicConfig_70759_Desc = {
    Text = "Sau khi chiến đấu bắt đầu, áp dụng [Arg1] lớp<WeaknessIconKeywords:yếu đuối> lên tất cả kẻ thù, hiệu ứng tăng gấp đôi trong trận chiến với boss. Tất cả thân thể được đánh thức gây ra thương cơ bản tăng [Arg2]%."
  },
  RelicConfig_70759_Name = {
    Text = "<WhiteQuality:quỷ sứ nhỏ>"
  },
  RelicConfig_70759_StoryDesc = {
    Text = "Bắt nguồn từ cái ác thuần túy, dù điều đó không phải là ý nguyện của nó."
  },
  RelicConfig_70760_BattleDesc = {
    Text = "Khi trận chiến bắt đầu, gây [Arg1] <IntoxicationIconKeywords:trúng độc> cho tất cả kẻ địch, hiệu ứng tăng gấp đôi trong trận boss."
  },
  RelicConfig_70760_Desc = {
    Text = "Khi trận chiến bắt đầu, gây [Arg1] <IntoxicationIconKeywords:trúng độc> cho tất cả kẻ địch, hiệu ứng tăng gấp đôi trong trận boss."
  },
  RelicConfig_70760_Name = {
    Text = "<WhiteQuality:chất độc thần kinh>"
  },
  RelicConfig_70760_StoryDesc = {
    Text = "Trích xuất và luyện chế"
  },
  RelicConfig_70761_BattleDesc = {
    Text = "Sau khi trận chiến bắt đầu, áp dụng [Arg1] lớp <VulnerabilityIconKeywords:Trọng thương> lên tất cả kẻ địch, hiệu ứng trong trận chiến với lãnh đạo gấp đôi. Tất cả thể thức tỉnh gây ra sát thương cơ bản tăng [Arg2]%."
  },
  RelicConfig_70761_Desc = {
    Text = "Sau khi chiến đấu bắt đầu, áp dụng [Arg1] lớp<VulnerabilityIconKeywords:Trọng thương> lên tất cả kẻ thù, hiệu ứng trong trận chiến với lãnh đạo tăng gấp đôi. Tất cả thể thức tỉnh gây ra sát thương cơ bản tăng [Arg2]%."
  },
  RelicConfig_70761_Name = {
    Text = "<WhiteQuality:Lễ hội Mùa xuân>"
  },
  RelicConfig_70761_StoryDesc = {
    Text = "Trong tiếng cười rộn ràng của đêm, hình bóng chiếc thuyền độc mộc lướt nhẹ nhàng trên mặt hồ."
  },
  RelicConfig_70762_BattleDesc = {
    Text = "Sau khi sử dụng 4 lần \"điên cuồng bùng phát\" trong một lượt, nhận được [Arg1] sức tính toán, làm mới sau 3 lượt."
  },
  RelicConfig_70762_Desc = {
    Text = "Sau khi sử dụng 4 lần \"điên cuồng bùng phát\" trong một lượt, nhận được [Arg1] sức tính toán, làm mới sau 3 lượt."
  },
  RelicConfig_70762_Name = {
    Text = "<OrangeQuality:Silver White Differential Machine+>"
  },
  RelicConfig_70762_StoryDesc = {
    Text = "\"Nó đã thay đổi lịch sử.\""
  },
  RelicConfig_70763_BattleDesc = {
    Text = "Sau khi kích hoạt \"cơn thịnh nộ bùng phát\", nhận được [Arg1] <PowerIconKeywords:lực lượng> tạm thời."
  },
  RelicConfig_70763_Desc = {
    Text = "Sau khi kích hoạt \"cơn thịnh nộ bùng phát\", nhận được [Arg1] <PowerIconKeywords:lực lượng> tạm thời."
  },
  RelicConfig_70763_Name = {
    Text = "<WhiteQuality:Khóa Nặng>"
  },
  RelicConfig_70763_StoryDesc = {
    Text = "Khóa dày và chắc chắn, nếu không có chìa khóa, chắc hẳn rất khó để mở. \nTất nhiên, điều này đối với một siêu trộm thì không đáng kể."
  },
  RelicConfig_70764_BattleDesc = {
    Text = "Khi bị kẻ địch tấn công, khiến chúng nhận [Arg1] điểm <FixedDamage:Sát Thương Thuần Túy>, sát thương này được hưởng bonus <RetaliateIconKeywords:phản công> [Arg2]%, mỗi kẻ địch kích hoạt tối đa 1 lần mỗi lượt."
  },
  RelicConfig_70764_Desc = {
    Text = "Khi bị kẻ địch tấn công, khiến chúng nhận <FixedDamage:Sát Thương Thuần Túy> bằng [Arg3]% Sinh lực tối đa của ta, sát thương này được hưởng bonus <RetaliateIconKeywords:phản công> [Arg2]%, mỗi kẻ địch kích hoạt tối đa 1 lần mỗi lượt."
  },
  RelicConfig_70764_Name = {
    Text = "<WhiteQuality:dao tế bị lãng quên>"
  },
  RelicConfig_70764_StoryDesc = {
    Text = "Dao có lưỡi cong, thường được sử dụng trong các nghi lễ tế lễ."
  },
  RelicConfig_70765_BattleDesc = {
    Text = "Mỗi lần gây thương sẽ nhận được [Arg1] tạm thời <PowerIconKeywords:lực lượng>, mỗi lượt tối đa kích hoạt 15 lần."
  },
  RelicConfig_70765_Desc = {
    Text = "Mỗi lần gây thương sẽ nhận được [Arg1] tạm thời <PowerIconKeywords:lực lượng>, mỗi lượt tối đa kích hoạt 15 lần."
  },
  RelicConfig_70765_Name = {
    Text = "<WhiteQuality:mã não vân tơ>"
  },
  RelicConfig_70765_StoryDesc = {
    Text = "Đó có lẽ chỉ là hoa văn thạch anh thông thường. Chắc vậy."
  },
  RelicConfig_70766_BattleDesc = {
    Text = "Vào đầu lượt, nếu sức sống thấp hơn 25%, nhận [Arg1] lá chắn."
  },
  RelicConfig_70766_Desc = {
    Text = "Vào đầu lượt, nếu sức sống thấp hơn 25%, nhận [Arg1] lá chắn."
  },
  RelicConfig_70766_Name = {
    Text = "<WhiteQuality:Bàn Tay Bảo Vệ>"
  },
  RelicConfig_70766_StoryDesc = {
    Text = "Tay cầu phúc, nắm đấm kiên định."
  },
  RelicConfig_70767_BattleDesc = {
    Text = "Sứ giả diệt vong khiến thân thể được đánh thức có mức độ điên loạn thấp nhất nhận thêm [Arg1] điểm điên cuồng, thời gian hồi chiêu 3 lượt."
  },
  RelicConfig_70767_Desc = {
    Text = "Sứ giả diệt vong khiến thân thể được đánh thức có mức độ điên loạn thấp nhất nhận thêm [Arg1] điểm điên cuồng, thời gian hồi chiêu 3 lượt."
  },
  RelicConfig_70767_Name = {
    Text = "<WhiteQuality:sâu thời gian>"
  },
  RelicConfig_70767_StoryDesc = {
    Text = "Một chiếc đồng hồ bỏ túi tồn tại đồng thời trong cửa hàng đồng hồ và bảo tàng côn trùng. \n Sau khi kỷ nguyên Hồng Tích bắt đầu, nó được đưa vào bộ sưu tập của trường đại học."
  },
  RelicConfig_70768_BattleDesc = {
    Text = "Sau khi chiến đấu bắt đầu, nhận được [Arg1] <ProficientInRealmsIconKeywords:giới vực thông thạo>. Tất cả các thân thể được đánh thức gây ra <RetaliateIconKeywords:phản công> và các sáng tạo gây ra <RetaliateIconKeywords:phản công> tăng [Arg2]%."
  },
  RelicConfig_70768_Desc = {
    Text = "Sau khi chiến đấu bắt đầu, nhận được [Arg1] <ProficientInRealmsIconKeywords:giới vực thông thạo>. Tất cả các thân thể được đánh thức gây ra <RetaliateIconKeywords:phản công> và các sáng tạo gây ra <RetaliateIconKeywords:phản công> tăng [Arg2]%."
  },
  RelicConfig_70768_Name = {
    Text = "<OrangeQuality:biết không giấu+>"
  },
  RelicConfig_70768_StoryDesc = {
    Text = "Nó truyền đạt vô số bí mật nói ra một cách chủ động hoặc bị động."
  },
  RelicConfig_70769_BattleDesc = {
    Text = "Mỗi lượt, sau khi sử dụng trực tiếp \"phôi thai\" lần đầu tiên, trong lượt này, sát thương chủ động sẽ gây ra [Arg1]% thương tương đương với <BleedingIconKeywords:chảy máu>."
  },
  RelicConfig_70769_Desc = {
    Text = "Mỗi lượt, sau khi sử dụng trực tiếp \"phôi thai\" lần đầu tiên, trong lượt này, sát thương chủ động sẽ gây ra [Arg1]% thương tương đương với <BleedingIconKeywords:chảy máu>."
  },
  RelicConfig_70769_Name = {
    Text = "<OrangeQuality:đá cuội nhuốm máu+>"
  },
  RelicConfig_70769_StoryDesc = {
    Text = "Một, hai, ba, bốn, năm."
  },
  RelicConfig_70770_BattleDesc = {
    Text = "Vào đầu lượt, rút [Arg1] quân bài."
  },
  RelicConfig_70770_Desc = {
    Text = "Vào đầu lượt, rút [Arg1] quân bài."
  },
  RelicConfig_70770_Name = {
    Text = "<WhiteQuality:la bàn định hướng>"
  },
  RelicConfig_70770_StoryDesc = {
    Text = "Điều được chỉ ra không phải là hướng, mà chỉ là từ trường."
  },
  RelicConfig_70771_BattleDesc = {
    Text = "\"đánh\" gây thêm 2 lần [Arg1]% sức tấn công của thân thể được đánh thức, mỗi lượt tối đa kích hoạt 3 lần."
  },
  RelicConfig_70771_Desc = {
    Text = "\"đánh\" gây thêm 2 lần [Arg1]% sức tấn công của thân thể được đánh thức, mỗi lượt tối đa kích hoạt 3 lần."
  },
  RelicConfig_70771_Name = {
    Text = "<OrangeQuality:Lưỡi Liễu Gỉ Sét+>"
  },
  RelicConfig_70771_StoryDesc = {
    Text = "Không thích hợp để cắt vào cơ thể sống."
  },
  RelicConfig_70772_BattleDesc = {
    Text = "Sau khi sử dụng Bạc Khóa Tỉnh Thức, rút [Arg1] lá bài và nhận [Arg2] năng lượng chìa khóa bạc."
  },
  RelicConfig_70772_Desc = {
    Text = "Sau khi sử dụng Bạc Khóa Tỉnh Thức, rút [Arg1] lá bài và nhận [Arg2] năng lượng chìa khóa bạc."
  },
  RelicConfig_70772_Name = {
    Text = "<WhiteQuality:ví mới>"
  },
  RelicConfig_70772_StoryDesc = {
    Text = "Ví da được in dấu huy hiệu của Đại học Misag. \nBây giờ bên trong trống rỗng, không có gì cả."
  },
  RelicConfig_70774_BattleDesc = {
    Text = "Trong mỗi lượt, sát thương từ 5 lần đầu sẽ tăng thêm [Arg1]%."
  },
  RelicConfig_70774_Desc = {
    Text = "Trong mỗi lượt, sát thương từ 5 lần đầu sẽ tăng thêm [Arg1]%."
  },
  RelicConfig_70774_Name = {
    Text = "<WhiteQuality:thiết bị chỉnh thị lực>"
  },
  RelicConfig_70774_StoryDesc = {
    Text = "Từng có người nhờ vào nó, tìm thấy sự thật."
  },
  RelicConfig_70776_BattleDesc = {
    Text = "Khi trận chiến bắt đầu, nhận được [Arg1] <RetaliateIconKeywords:phản công>, hiệu ứng trong trận đấu với thủ lĩnh tăng gấp đôi."
  },
  RelicConfig_70776_Desc = {
    Text = "Khi trận chiến bắt đầu, nhận được [Arg1] <RetaliateIconKeywords:phản công>, hiệu ứng trong trận đấu với thủ lĩnh tăng gấp đôi."
  },
  RelicConfig_70776_Name = {
    Text = "<WhiteQuality:áo giáp cây gai>"
  },
  RelicConfig_70776_StoryDesc = {
    Text = "Không thể phân biệt chất lỏng lạ."
  },
  RelicConfig_70777_BattleDesc = {
    Text = "Sau khi đánh ra 4 thẻ lệnh thuộc về các thể thức tỉnh khác nhau trong một lượt, tất cả các thể thức tỉnh nhận được [Arg1] cuồng khí, thời gian hồi sau 3 lượt."
  },
  RelicConfig_70777_Desc = {
    Text = "Sau khi đánh ra 4 thẻ lệnh thuộc về các thể thức tỉnh khác nhau trong một lượt, tất cả các thể thức tỉnh nhận được [Arg1] cuồng khí, thời gian hồi sau 3 lượt."
  },
  RelicConfig_70777_Name = {
    Text = "<WhiteQuality:mặt nạ của thần vô danh>"
  },
  RelicConfig_70777_StoryDesc = {
    Text = "Không thể nhìn thẳng vào thần."
  },
  RelicConfig_70778_BattleDesc = {
    Text = "Khi trận chiến bắt đầu, gây [Arg1] <IntoxicationIconKeywords:trúng độc> cho tất cả kẻ địch, hiệu ứng tăng gấp đôi trong trận boss."
  },
  RelicConfig_70778_Desc = {
    Text = "Khi trận chiến bắt đầu, gây [Arg1] <IntoxicationIconKeywords:trúng độc> cho tất cả kẻ địch, hiệu ứng tăng gấp đôi trong trận boss."
  },
  RelicConfig_70778_Name = {
    Text = "<OrangeQuality:chất độc thần kinh+>"
  },
  RelicConfig_70778_StoryDesc = {
    Text = "Trích xuất và luyện chế"
  },
  RelicConfig_70779_BattleDesc = {
    Text = "Sử dụng chìa khóa bạc để thức tỉnh, sau đó gây [Arg1] <IntoxicationIconKeywords:trúng độc> cho tất cả kẻ địch và nhận được [Arg2] năng lượng bạc."
  },
  RelicConfig_70779_Desc = {
    Text = "Sử dụng chìa khóa bạc để thức tỉnh, sau đó gây [Arg1] <IntoxicationIconKeywords:trúng độc> cho tất cả kẻ địch và nhận được [Arg2] năng lượng bạc."
  },
  RelicConfig_70779_Name = {
    Text = "<WhiteQuality:thuốc mỡ đáng ngờ>"
  },
  RelicConfig_70779_StoryDesc = {
    Text = "Một loại thuốc mỡ tự chế để điều trị vết thương, xin đừng sử dụng nếu không có hướng dẫn của bác sĩ."
  },
  RelicConfig_70780_BattleDesc = {
    Text = "\"đánh\" gây sát thương [Arg1]% <IntoxicationIconKeywords:trúng độc>, mỗi lượt tối đa [Arg2] điểm."
  },
  RelicConfig_70780_Desc = {
    Text = "\"đánh\" gây sát thương [Arg1]% <IntoxicationIconKeywords:trúng độc>, mỗi lượt tối đa [Arg2] điểm."
  },
  RelicConfig_70780_Name = {
    Text = "<WhiteQuality:thể loại dị thường>"
  },
  RelicConfig_70780_StoryDesc = {
    Text = "Ngài không phải là quỷ, nhưng Ngài thực sự truyền đạt lời thì thầm vượt ngoài thế giới loài người."
  },
  RelicConfig_70781_BattleDesc = {
    Text = "Vào đầu lượt, nếu sức sống thấp hơn 25%, nhận [Arg1] lá chắn."
  },
  RelicConfig_70781_Desc = {
    Text = "Vào đầu lượt, nếu sức sống thấp hơn 25%, nhận [Arg1] lá chắn."
  },
  RelicConfig_70781_Name = {
    Text = "<OrangeQuality:bàn tay bảo vệ+>"
  },
  RelicConfig_70781_StoryDesc = {
    Text = "Tay cầu phúc, nắm đấm kiên định."
  },
  RelicConfig_70782_BattleDesc = {
    Text = "Khi mất sức sống, nhận được [Arg1]% lượng sức sống mất đi dưới dạng lò luyện màu đỏ thẫm."
  },
  RelicConfig_70782_Desc = {
    Text = "Khi mất sức sống, nhận được [Arg1]% lượng sức sống mất đi dưới dạng lò luyện màu đỏ thẫm."
  },
  RelicConfig_70782_Name = {
    Text = "<OrangeQuality:cưa thép gỉ+>"
  },
  RelicConfig_70782_StoryDesc = {
    Text = "Bác sĩ giải phẫu suốt đời không nhìn thấy người phụ nữ đẹp. Họ chỉ có một bao xương, dây thần kinh viêm do bệnh tật, cơ bắp và mô."
  },
  RelicConfig_70783_BattleDesc = {
    Text = "Trong mỗi lượt, sát thương từ 5 lần đầu sẽ tăng thêm [Arg1]%."
  },
  RelicConfig_70783_Desc = {
    Text = "Trong mỗi lượt, sát thương từ 5 lần đầu sẽ tăng thêm [Arg1]%."
  },
  RelicConfig_70783_Name = {
    Text = "<OrangeQuality:thiết bị điều chỉnh thị lực+>"
  },
  RelicConfig_70783_StoryDesc = {
    Text = "Từng có người nhờ vào nó, tìm thấy sự thật."
  },
  RelicConfig_70784_BattleDesc = {
    Text = "Mỗi khi một thẻ bài vào không gian siêu việt, nếu thẻ bài này có chủ sở hữu khác với các thẻ bài trong không gian siêu việt khác, thì đặt [Arg1] thẻ <DerivativeCardKeywords_4:「cảm hứng」> vào tay."
  },
  RelicConfig_70784_Desc = {
    Text = "Mỗi khi một thẻ bài vào không gian siêu việt, nếu thẻ bài này có chủ sở hữu khác với các thẻ bài trong không gian siêu việt khác, thì đặt [Arg1] thẻ <DerivativeCardKeywords_4:「cảm hứng」> vào tay."
  },
  RelicConfig_70784_Name = {
    Text = "<WhiteQuality:Dụng cụ của Alfonso>"
  },
  RelicConfig_70784_StoryDesc = {
    Text = "Khác với số phận vô thường, các vì sao có quy luật vận hành riêng."
  },
  RelicConfig_70785_BattleDesc = {
    Text = "Sau khi đánh ra 4 thẻ lệnh thuộc về các thể thức tỉnh khác nhau trong một lượt, tất cả các thể thức tỉnh nhận được [Arg1] cuồng khí, thời gian hồi sau 3 lượt."
  },
  RelicConfig_70785_Desc = {
    Text = "Sau khi đánh ra 4 thẻ lệnh thuộc về các thể thức tỉnh khác nhau trong một lượt, tất cả các thể thức tỉnh nhận được [Arg1] cuồng khí, thời gian hồi sau 3 lượt."
  },
  RelicConfig_70785_Name = {
    Text = "<OrangeQuality:Vỏ mặt nạ của vị thần vô danh+>"
  },
  RelicConfig_70785_StoryDesc = {
    Text = "Không thể nhìn thẳng vào thần."
  },
  RelicConfig_70786_BattleDesc = {
    Text = "Khi kết thúc lượt, nếu đang ở tư thế Dâng Tràn, nhận được [Arg1] <TentacleInjurieIconKeywords:thương tổn xúc tu>, thời gian hồi chiêu 3 lượt."
  },
  RelicConfig_70786_Desc = {
    Text = "Khi kết thúc lượt, nếu đang ở tư thế Dâng Tràn, nhận được [Arg1] <TentacleInjurieIconKeywords:thương tổn xúc tu>, thời gian hồi chiêu 3 lượt."
  },
  RelicConfig_70786_Name = {
    Text = "<WhiteQuality:giun đũa>"
  },
  RelicConfig_70786_StoryDesc = {
    Text = "Chừng nào não bộ của chúng ta vẫn còn là một bí ẩn, thì việc nó chứa đầy râu tua cũng không có gì đáng ngạc nhiên."
  },
  RelicConfig_70787_BattleDesc = {
    Text = "Tất cả thân thể được đánh thức gây thêm [Arg1]% thương cơ bản."
  },
  RelicConfig_70787_Desc = {
    Text = "Tất cả thân thể được đánh thức gây thêm [Arg1]% thương cơ bản."
  },
  RelicConfig_70787_Name = {
    Text = "<OrangeQuality:Khóc Đàn+>"
  },
  RelicConfig_70787_StoryDesc = {
    Text = "Đây cuối cùng là kết quả của lòng thù hận, hay hậu quả của sự trả thù?"
  },
  RelicConfig_70788_BattleDesc = {
    Text = "Sau khi Bạc Khóa Tỉnh Thức, tất cả thân thể được đánh thức nhận [Arg1] điên cuồng và [Arg2] năng lượng chìa khóa bạc."
  },
  RelicConfig_70788_Desc = {
    Text = "Sau khi Bạc Khóa Tỉnh Thức, tất cả thân thể được đánh thức nhận [Arg1] điên cuồng và [Arg2] năng lượng chìa khóa bạc."
  },
  RelicConfig_70788_Name = {
    Text = "<WhiteQuality:khuy áo lá quế>"
  },
  RelicConfig_70788_StoryDesc = {
    Text = "Cuffs bạc khắc hoa lá quế. \nTinh xảo và lấp lánh, lưu giữ tình bạn của hai đứa trẻ."
  },
  RelicConfig_70789_BattleDesc = {
    Text = "Sau khi trận chiến bắt đầu, nhận được [Arg1] <ProficientInRealmsIconKeywords:giới vực thông thạo>. Tất cả các thân thể được đánh thức và các sáng tạo gây ra <IntoxicationIconKeywords:trúng độc> tăng [Arg2]%."
  },
  RelicConfig_70789_Desc = {
    Text = "Sau khi trận chiến bắt đầu, nhận được [Arg1] <ProficientInRealmsIconKeywords:giới vực thông thạo>. Tất cả các thân thể được đánh thức và các sáng tạo gây ra <IntoxicationIconKeywords:trúng độc> tăng [Arg2]%."
  },
  RelicConfig_70789_Name = {
    Text = "<WhiteQuality:máy may phủ bụi>"
  },
  RelicConfig_70789_StoryDesc = {
    Text = "Một người mẹ hiền từ, hàn gắn những vết thương trong trái tim."
  },
  RelicConfig_70790_BattleDesc = {
    Text = "Sứ giả diệt vong khiến thân thể được đánh thức có mức độ điên loạn thấp nhất nhận thêm [Arg1] điểm điên cuồng, thời gian hồi chiêu 3 lượt."
  },
  RelicConfig_70790_Desc = {
    Text = "Sứ giả diệt vong khiến thân thể được đánh thức có mức độ điên loạn thấp nhất nhận thêm [Arg1] điểm điên cuồng, thời gian hồi chiêu 3 lượt."
  },
  RelicConfig_70790_Name = {
    Text = "<OrangeQuality:con sâu thời gian+>"
  },
  RelicConfig_70790_StoryDesc = {
    Text = "Một chiếc đồng hồ bỏ túi tồn tại đồng thời trong cửa hàng đồng hồ và bảo tàng côn trùng. \n Sau khi kỷ nguyên Hồng Tích bắt đầu, nó được đưa vào bộ sưu tập của trường đại học."
  },
  RelicConfig_70791_BattleDesc = {
    Text = "Khi trận chiến bắt đầu, giới hạn râu chạm tăng thêm [Arg1], nhận được [Arg2] râu chạm."
  },
  RelicConfig_70791_Desc = {
    Text = "Khi trận chiến bắt đầu, giới hạn râu chạm tăng thêm [Arg1], nhận được [Arg2] râu chạm."
  },
  RelicConfig_70791_Name = {
    Text = "<OrangeQuality:hải ân ca+>"
  },
  RelicConfig_70791_StoryDesc = {
    Text = "Nghe nói rằng ốc vân và các động vật không ăn được hấp thụ khoảng 80% dinh dưỡng của đại dương."
  },
  RelicConfig_70792_BattleDesc = {
    Text = "Khi kết thúc lượt, nếu đang ở tư thế Dâng Tràn, nhận được [Arg1] <TentacleInjurieIconKeywords:thương tổn xúc tu>, thời gian hồi chiêu 3 lượt."
  },
  RelicConfig_70792_Desc = {
    Text = "Khi kết thúc lượt, nếu đang ở tư thế Dâng Tràn, nhận được [Arg1] <TentacleInjurieIconKeywords:thương tổn xúc tu>, thời gian hồi chiêu 3 lượt."
  },
  RelicConfig_70792_Name = {
    Text = "<OrangeQuality:giun sán+>"
  },
  RelicConfig_70792_StoryDesc = {
    Text = "Chừng nào não bộ của chúng ta vẫn còn là một bí ẩn, thì việc nó chứa đầy râu tua cũng không có gì đáng ngạc nhiên."
  },
  RelicConfig_70793_BattleDesc = {
    Text = "Mỗi lượt, khi <DevouredIconKeywords:nuốt chửng> lần đầu, các thân thể được đánh thức khác nhận được [Arg1] điên cuồng."
  },
  RelicConfig_70793_Desc = {
    Text = "Mỗi lượt, khi <DevouredIconKeywords:nuốt chửng> lần đầu, các thân thể được đánh thức khác nhận được [Arg1] điên cuồng."
  },
  RelicConfig_70793_Name = {
    Text = "<OrangeQuality:vườn mơ vàng+>"
  },
  RelicConfig_70793_StoryDesc = {
    Text = "Ngày chuyển hóa chính là ngày chết của bạn."
  },
  RelicConfig_70794_BattleDesc = {
    Text = "Hủy diệt nhận được [Arg1] lá chắn, 3 lượt thời gian hồi chiêu."
  },
  RelicConfig_70794_Desc = {
    Text = "Hủy diệt nhận được [Arg1] lá chắn, 3 lượt thời gian hồi chiêu."
  },
  RelicConfig_70794_Name = {
    Text = "<OrangeQuality:đồng hồ dây đeo siêu dây+>"
  },
  RelicConfig_70794_StoryDesc = {
    Text = "\"Ái chà, đồng hồ bỏ túi đã dừng rồi.\""
  },
  RelicConfig_70795_BattleDesc = {
    Text = "Sau khi đánh thẻ lệnh không phải là thẻ phái sinh, giảm tiêu thụ sức tính toán của thẻ đó đi 2 và đưa [Arg1] bản sao tạm thời vào rút bài từ bộ bài, làm mới sau 3 lượt."
  },
  RelicConfig_70795_Desc = {
    Text = "Sau khi đánh thẻ lệnh không phải là thẻ phái sinh, giảm tiêu thụ sức tính toán của thẻ đó đi 2 và đưa [Arg1] bản sao tạm thời vào rút bài từ bộ bài, làm mới sau 3 lượt."
  },
  RelicConfig_70795_Name = {
    Text = "<WhiteQuality:máy hát câm>"
  },
  RelicConfig_70795_StoryDesc = {
    Text = "Giọng của anh ấy biến mất trong gió."
  },
  RelicConfig_70796_BattleDesc = {
    Text = "Sau khi sử dụng \"Bùng nổ\", khiến tất cả kẻ địch nhận [Arg1] điểm <FixedDamage:Sát Thương Thuần Túy>, và kích hoạt <IntoxicationIconKeywords:Ngộ độc> [Arg2]%."
  },
  RelicConfig_70796_Desc = {
    Text = "Sau khi sử dụng \"Bùng nổ\", khiến tất cả kẻ địch nhận 1 lần <FixedDamage:Sát Thương Thuần Túy> bằng [Arg2]% Sinh lực tối đa của ta, và kích hoạt <IntoxicationIconKeywords:Ngộ độc> [Arg2]%."
  },
  RelicConfig_70796_Name = {
    Text = "<OrangeQuality:hàm quai laser+>"
  },
  RelicConfig_70796_StoryDesc = {
    Text = "Xương cốt được trưng bày trong phòng triển lãm tư nhân của một nhà sưu tập. \nNhà sưu tập mê đắm ánh huỳnh quang tuyệt đẹp, ngày đêm chiêm ngưỡng, cuối cùng héo mòn và trở thành đồng loại với nó."
  },
  RelicConfig_70797_BattleDesc = {
    Text = "Sức tính toán tối đa tăng [Arg1] ."
  },
  RelicConfig_70797_Desc = {
    Text = "Sức tính toán tối đa tăng [Arg1] ."
  },
  RelicConfig_70797_Name = {
    Text = "<WhiteQuality:bơm tiêm hoạt tính>"
  },
  RelicConfig_70797_StoryDesc = {
    Text = "Co giật cũng là một dạng năng lượng."
  },
  RelicConfig_70798_BattleDesc = {
    Text = "Sử dụng tư thế Nộ Đào để kích hoạt tất cả râu chạm tấn công địch [Arg1] lần, 3 lượt hồi chiêu."
  },
  RelicConfig_70798_Desc = {
    Text = "Sử dụng tư thế Nộ Đào để kích hoạt tất cả râu chạm tấn công địch [Arg1] lần, 3 lượt hồi chiêu."
  },
  RelicConfig_70798_Name = {
    Text = "<OrangeQuality:niềm vui của lư ẩn+>"
  },
  RelicConfig_70798_StoryDesc = {
    Text = "Bậc chủ tể giấc ngủ sâu, chờ ngươi vào mộng."
  },
  RelicConfig_70799_BattleDesc = {
    Text = "Phòng thủ nhận được [Arg1] tạm thời<RetaliateIconKeywords:phản công>, mỗi lượt tối đa kích hoạt 3 lần."
  },
  RelicConfig_70799_Desc = {
    Text = "Phòng thủ nhận được [Arg1] tạm thời<RetaliateIconKeywords:phản công>, mỗi lượt tối đa kích hoạt 3 lần."
  },
  RelicConfig_70799_Name = {
    Text = "<OrangeQuality:kỷ vật của người xưa+>"
  },
  RelicConfig_70799_StoryDesc = {
    Text = "Gánh vác nỗi nhớ và cảm thương, tiến về phía trước."
  },
  RelicConfig_70800_BattleDesc = {
    Text = "Phòng thủ nhận được [Arg1] tạm thời<RetaliateIconKeywords:phản công>, mỗi lượt tối đa kích hoạt 3 lần."
  },
  RelicConfig_70800_Desc = {
    Text = "Phòng thủ nhận được [Arg1] tạm thời<RetaliateIconKeywords:phản công>, mỗi lượt tối đa kích hoạt 3 lần."
  },
  RelicConfig_70800_Name = {
    Text = "<WhiteQuality:chiếc đồng hồ của người đã khuất>"
  },
  RelicConfig_70800_StoryDesc = {
    Text = "Gánh vác nỗi nhớ và cảm thương, tiến về phía trước."
  },
  RelicConfig_70986_BattleDesc = {
    Text = "Khi bắt đầu chiến đấu, giới hạn sức tính toán +1, thức tỉnh tất cả thân thể được đánh thức. Vào đầu các lượt lẻ, chọn 1 trong 2 sáng tạo để nhận, áp dụng trong 5 lượt lẻ liên tiếp."
  },
  RelicConfig_70986_Desc = {
    Text = "Khi bắt đầu chiến đấu, giới hạn sức tính toán +1, thức tỉnh tất cả thân thể được đánh thức. Vào đầu các lượt lẻ, chọn 1 trong 2 sáng tạo để nhận, áp dụng trong 5 lượt lẻ liên tiếp."
  },
  RelicConfig_70986_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「lời cầu nguyệnη」>"
  },
  RelicConfig_70987_BattleDesc = {
    Text = "Khi bắt đầu chiến đấu, giới hạn sức tính toán +1, thức tỉnh tất cả thân thể được đánh thức. Vào đầu các lượt lẻ, chọn 1 trong 2 sáng tạo để nhận, áp dụng trong 5 lượt lẻ liên tiếp."
  },
  RelicConfig_70987_Desc = {
    Text = "Khi bắt đầu chiến đấu, giới hạn sức tính toán +1, thức tỉnh tất cả thân thể được đánh thức. Vào đầu các lượt lẻ, chọn 1 trong 2 sáng tạo để nhận, áp dụng trong 5 lượt lẻ liên tiếp."
  },
  RelicConfig_70987_Name = {
    Text = "<OrangeQuality:bàn lắc thời linh「khấn nguyệnζ」>"
  },
  RelicConfig_71195_BattleDesc = {
    Text = "Vào đầu lượt, Vòng tròn · Ramona nhận được [Arg1] điên cuồng. Mỗi lượt khi kích hoạt \"Hồi Hoàn\" lần đầu tiên, nhận được [Arg2] điểm năng lượng chìa khóa bạc và [Arg3] tầng \"entropy âm\"."
  },
  RelicConfig_71195_Desc = {
    Text = "Vào đầu lượt, Vòng tròn · Ramona nhận được [Arg1] điên cuồng. Mỗi lượt khi kích hoạt \"Hồi Hoàn\" lần đầu tiên, nhận được [Arg2] điểm năng lượng chìa khóa bạc và [Arg3] tầng \"entropy âm\"."
  },
  RelicConfig_71195_Name = {
    Text = "<OrangeQuality:chiều ảnh · Vòng tròn · Ramona>"
  },
  RelicConfig_71196_BattleDesc = {
    Text = "Vào đầu lượt, lơ-tan nhận được [Arg1] điên cuồng. Mỗi lượt, khi sử dụng \"phòng thủ\" lần đầu, đặt [Arg2] lá \"lưỡi kiếm kiêu ngạo\" có thêm tiêu thụ và hư vô vào tay."
  },
  RelicConfig_71196_Desc = {
    Text = "Vào đầu lượt, lơ-tan nhận được [Arg1] điên cuồng. Mỗi lượt, khi sử dụng \"phòng thủ\" lần đầu, đặt [Arg2] lá \"lưỡi kiếm kiêu ngạo\" có thêm tiêu thụ và hư vô vào tay."
  },
  RelicConfig_71196_Name = {
    Text = "<OrangeQuality:chiều ảnh · lơ-tan>"
  },
  RelicConfig_71197_BattleDesc = {
    Text = "Vào đầu lượt, Ramona nhận được [Arg1] cuồng nộ. Mỗi lần đánh lá thẻ lệnh thứ [Arg2] của Ramona, lá thẻ lệnh đó sẽ có hiệu lực thêm 1 lần và nhận được [Arg3] điểm năng lượng chìa khóa bạc."
  },
  RelicConfig_71197_Desc = {
    Text = "Vào đầu lượt, Ramona nhận được [Arg1] cuồng nộ. Mỗi lần đánh lá thẻ lệnh thứ [Arg2] của Ramona, lá thẻ lệnh đó sẽ có hiệu lực thêm 1 lần và nhận được [Arg3] điểm năng lượng chìa khóa bạc."
  },
  RelicConfig_71197_Name = {
    Text = "<OrangeQuality:hình ảnh chiều·Ramona>"
  },
  RelicConfig_71230_BattleDesc = {
    Text = "Khi bắt đầu lượt, Reia nhận được [Arg1] Điên loạn. Mỗi khi mất Sinh lực sẽ nhận được [Arg2] điểm Sức mạnh, mỗi trận chiến tối đa cộng dồn [Arg3] lần. Sau khi cộng dồn [Arg3] lần, Giá trị Điểm tính toán cơ bản của \"Đau đớn và niềm vui\" giảm 2, số lần gây thương tăng 1."
  },
  RelicConfig_71230_Desc = {
    Text = "Khi bắt đầu lượt, Reia nhận được [Arg1] Điên loạn. Mỗi khi mất Sinh lực sẽ nhận được [Arg2] điểm Sức mạnh, mỗi trận chiến tối đa cộng dồn [Arg3] lần. Sau khi cộng dồn [Arg3] lần, Giá trị Điểm tính toán cơ bản của \"Đau đớn và niềm vui\" giảm 2, số lần gây thương tăng 1."
  },
  RelicConfig_71230_Name = {
    Text = "<OrangeQuality:hình ảnh chiều · Reia>"
  },
  RelicConfig_71231_BattleDesc = {
    Text = "Vào đầu lượt, Ô Ryta nhận được [Arg1] điên cuồng. Số lần gây thương của \"Tuyến phân liệt\" tăng [Arg2], sau khi Ô Ryta sử dụng \"phòng thủ\", thêm 1 lá \"Tuyến phân liệt\" vào tay."
  },
  RelicConfig_71231_Desc = {
    Text = "Vào đầu lượt, Ô Ryta nhận được [Arg1] điên cuồng. Số lần gây thương của \"Tuyến phân liệt\" tăng [Arg2], sau khi Ô Ryta sử dụng \"phòng thủ\", thêm 1 lá \"Tuyến phân liệt\" vào tay."
  },
  RelicConfig_71231_Name = {
    Text = "<OrangeQuality:Ảnh Chiều·Ô Ryta>"
  },
  RelicConfig_71232_BattleDesc = {
    Text = "Vào đầu lượt, Tinkerer nhận được [Arg1] điên cuồng. Sau khi thẻ lệnh của Tinkerer kích hoạt nhảy vọt, nó sẽ được trả lại vào tay và giảm tiêu thụ sức tính toán khi đánh ra đi -1. Mỗi lượt tối đa có hiệu lực [Arg2] lần."
  },
  RelicConfig_71232_Desc = {
    Text = "Vào đầu lượt, Tinkerer nhận được [Arg1] điên cuồng. Sau khi thẻ lệnh của Tinkerer kích hoạt nhảy vọt, nó sẽ được trả lại vào tay và giảm tiêu thụ sức tính toán khi đánh ra đi -1. Mỗi lượt tối đa có hiệu lực [Arg2] lần."
  },
  RelicConfig_71232_Name = {
    Text = "<OrangeQuality:chiều ảnh·tinkerer>"
  },
  RelicConfig_71233_BattleDesc = {
    Text = "Vào đầu lượt, Nốtira nhận được [Arg1] điên cuồng. Sau khi sử dụng \"cơn thịnh nộ bùng phát\" của Nốtira, nhận [Arg2]% lá chắn hiện tại làm phản công và lá chắn trì hoãn, tối đa 1 lần mỗi lượt."
  },
  RelicConfig_71233_Desc = {
    Text = "Vào đầu lượt, Nốtira nhận được [Arg1] điên cuồng. Sau khi sử dụng \"cơn thịnh nộ bùng phát\" của Nốtira, nhận [Arg2]% lá chắn hiện tại làm phản công và lá chắn trì hoãn, tối đa 1 lần mỗi lượt."
  },
  RelicConfig_71233_Name = {
    Text = "<OrangeQuality:chiều·Nốtira>"
  },
  RelicConfig_71234_BattleDesc = {
    Text = "Vào đầu lượt, đóatan·đóa nhận được [Arg1] điên cuồng. Sau khi đóatan·đóa phát động cơn thịnh nộ bùng phát, mỗi lần tiêu thụ [Arg2] điểm điên cuồng, các thân thể được đánh thức khác sẽ nhận được 1 điểm điên cuồng."
  },
  RelicConfig_71234_Desc = {
    Text = "Vào đầu lượt, đóatan·đóa nhận được [Arg1] điên cuồng. Sau khi đóatan·đóa phát động cơn thịnh nộ bùng phát, mỗi lần tiêu thụ [Arg2] điểm điên cuồng, các thân thể được đánh thức khác sẽ nhận được 1 điểm điên cuồng."
  },
  RelicConfig_71234_Name = {
    Text = "<OrangeQuality:chiều ảnh·tan chảy·đóa>"
  },
  RelicConfig_71235_BattleDesc = {
    Text = "Khi bắt đầu lượt, Hiro nhận được [Arg1] điên cuồng. Mỗi khi có 1 lá bài bị vứt đi, Hiro sẽ nhận thêm [Arg2] điểm điên cuồng."
  },
  RelicConfig_71235_Desc = {
    Text = "Khi bắt đầu lượt, Hiro nhận được [Arg1] điên cuồng. Mỗi khi có 1 lá bài bị vứt đi, Hiro sẽ nhận thêm [Arg2] điểm điên cuồng."
  },
  RelicConfig_71235_Name = {
    Text = "<OrangeQuality:chiều·Hiro>"
  },
  RelicConfig_71236_BattleDesc = {
    Text = "Vào đầu lượt, Đào Đen Đá nhận được [Arg1] điên cuồng và 1 lá \"cảm hứng\". \"Dị chất triều lưu\" nhận thêm lực lượng tăng [Arg2]%, mỗi lần đánh ra trong cuộc khám phá này sẽ tăng thêm vĩnh viễn [Arg3]%, tối đa tăng [Arg4]%."
  },
  RelicConfig_71236_Desc = {
    Text = "Vào đầu lượt, Đào Đen Đá nhận được [Arg1] điên cuồng và 1 lá \"cảm hứng\". \"Dị chất triều lưu\" nhận thêm lực lượng tăng [Arg2]%, mỗi lần đánh ra trong cuộc khám phá này sẽ tăng thêm vĩnh viễn [Arg3]%, tối đa tăng [Arg4]%."
  },
  RelicConfig_71236_Name = {
    Text = "<OrangeQuality:chiều ảnh·Đào Đen Đá>"
  },
  RelicConfig_71237_BattleDesc = {
    Text = "Lúc bắt đầu lượt Wanda nhận [Arg1] Aliemus và nhận [Arg2] tầng \"Dẫn dắt giấc mơ\". Nếu là lượt Ultra hiện tại, sẽ thêm vào tay 1 thẻ tạm thời \"Chuỗi cột sống\" và\"Người bảo hộ lạc lối\", và khiến thẻ lệnh tiếp theo của Wanda có hiệu quả 2 lần."
  },
  RelicConfig_71237_Desc = {
    Text = "Lúc bắt đầu lượt Wanda nhận [Arg1] Aliemus và nhận [Arg2] tầng \"Dẫn dắt giấc mơ\". Nếu là lượt Ultra hiện tại, sẽ thêm vào tay 1 thẻ tạm thời \"Chuỗi cột sống\" và\"Người bảo hộ lạc lối\", và khiến thẻ lệnh tiếp theo của Wanda có hiệu quả 2 lần."
  },
  RelicConfig_71237_Name = {
    Text = "<OrangeQuality:hình ảnh chiều không gian·Vanda>"
  },
  RelicConfig_71238_BattleDesc = {
    Text = "Vào đầu lượt, Agrippa nhận được [Arg1] điên cuồng. Kỹ năng \"Sự ban tặng thiếu kiên nhẫn\" giúp giảm [Arg2] tiêu thụ sức tính toán trong lượt hiện tại, tối đa 1 lần mỗi lượt."
  },
  RelicConfig_71238_Desc = {
    Text = "Vào đầu lượt, Agrippa nhận được [Arg1] điên cuồng. Kỹ năng \"Sự ban tặng thiếu kiên nhẫn\" giúp giảm [Arg2] tiêu thụ sức tính toán trong lượt hiện tại, tối đa 1 lần mỗi lượt."
  },
  RelicConfig_71238_Name = {
    Text = "<OrangeQuality:chiều ảnh·Agrippa>"
  },
  RelicConfig_71239_BattleDesc = {
    Text = "Vào đầu lượt, \"24\" nhận được [Arg1] điên cuồng. Vào đầu lượt, nếu \"24\"đang ở trạng thái \"nhân cách trầm cảm\" thì sẽ nhận thêm [Arg2] điên cuồng; nếu đang ở trạng thái \"nhân cách cuồng loạn\" thì sẽ tăng tỷ lệ chí mạng tạm thời và thương harming chí mạng tạm thời của \"24\" lên [Arg2]%."
  },
  RelicConfig_71239_Desc = {
    Text = "Vào đầu lượt, \"24\" nhận được [Arg1] điên cuồng. Vào đầu lượt, nếu \"24\"đang ở trạng thái \"nhân cách trầm cảm\" thì sẽ nhận thêm [Arg2] điên cuồng; nếu đang ở trạng thái \"nhân cách cuồng loạn\" thì sẽ tăng tỷ lệ chí mạng tạm thời và thương harming chí mạng tạm thời của \"24\" lên [Arg2]%."
  },
  RelicConfig_71239_Name = {
    Text = "<OrangeQuality:chiều hình ảnh·「24」>"
  },
  RelicConfig_71240_BattleDesc = {
    Text = "Vào đầu lượt, Liz nhận được [Arg1] điên cuồng. \"Vũ điệu báo tử\" kích hoạt thêm 1 lần hiệu ứng khi bỏ thẻ bài, thời gian hồi 3 lượt."
  },
  RelicConfig_71240_Desc = {
    Text = "Vào đầu lượt, Liz nhận được [Arg1] điên cuồng. \"Vũ điệu báo tử\" kích hoạt thêm 1 lần hiệu ứng khi bỏ thẻ bài, thời gian hồi 3 lượt."
  },
  RelicConfig_71240_Name = {
    Text = "<OrangeQuality:chiều ảnh · Liz>"
  },
  RelicConfig_71241_BattleDesc = {
    Text = "Vào đầu lượt, Chuỗi Máu · Hiro nhận được [Arg1] điên cuồng. Chuỗi Máu · Hiro gây thêm [Arg2]% chảy máu từ thương chủ động. Sau khi tiêu diệt kẻ địch, gây ra lượng chảy máu tương đương với thương dư thừa cho các kẻ địch khác."
  },
  RelicConfig_71241_Desc = {
    Text = "Vào đầu lượt, Chuỗi Máu · Hiro nhận được [Arg1] điên cuồng. Chuỗi Máu · Hiro gây thêm [Arg2]% chảy máu từ thương chủ động. Sau khi tiêu diệt kẻ địch, gây ra lượng chảy máu tương đương với thương dư thừa cho các kẻ địch khác."
  },
  RelicConfig_71241_Name = {
    Text = "<OrangeQuality:chiều ảnh·Máu Liên · Shiro>"
  },
  RelicConfig_71242_BattleDesc = {
    Text = "Vào đầu lượt, Hilaster nhận được [Arg1] điên cuồng. Trước khi kết thúc lượt, mỗi thẻ lệnh của Hilaster trong tay sẽ kích hoạt 1 râu chạm tấn công kẻ địch và hồi phục [Heal:Arg2] điểm sức sống."
  },
  RelicConfig_71242_Desc = {
    Text = "Vào đầu lượt, Hilaster nhận được [Arg1] điên cuồng. Trước khi kết thúc lượt, mỗi thẻ lệnh của Hilaster trong tay sẽ kích hoạt 1 râu chạm tấn công kẻ địch và hồi phục [Heal:Arg2] điểm sức sống."
  },
  RelicConfig_71242_Name = {
    Text = "<OrangeQuality:hình ảnh chiều·Hilaster>"
  },
  RelicConfig_71243_BattleDesc = {
    Text = "Vào đầu lượt, Kassia nhận được [Arg1] điên cuồng. Mỗi lần rút bài, Kassia nhận thêm [Arg2] điểm điên cuồng. Khi Kassia phát động cơn thịnh nộ, tất cả kẻ địch mất [Arg3] điểm lực lượng."
  },
  RelicConfig_71243_Desc = {
    Text = "Vào đầu lượt, Kassia nhận được [Arg1] điên cuồng. Mỗi lần rút bài, Kassia nhận thêm [Arg2] điểm điên cuồng. Khi Kassia phát động cơn thịnh nộ, tất cả kẻ địch mất [Arg3] điểm lực lượng."
  },
  RelicConfig_71243_Name = {
    Text = "<OrangeQuality:chiều·Kassia>"
  },
  RelicConfig_71244_BattleDesc = {
    Text = "Vào đầu lượt, Sorrel nhận được [Arg1] điên cuồng. Mỗi lần Sorrel gây 1 lần thương, dung hợp phôi thai +[Arg2], tối đa [Arg3] lần mỗi lượt. Sau khi kích hoạt 10 lần, sát thương cuối cùng của Sorrel trong trận chiến này + [Arg4]%."
  },
  RelicConfig_71244_Desc = {
    Text = "Vào đầu lượt, Sorrel nhận được [Arg1] điên cuồng. Mỗi lần Sorrel gây 1 lần thương, dung hợp phôi thai +[Arg2], tối đa [Arg3] lần mỗi lượt. Sau khi kích hoạt 10 lần, sát thương cuối cùng của Sorrel trong trận chiến này + [Arg4]%."
  },
  RelicConfig_71244_Name = {
    Text = "<OrangeQuality:hình ảnh chiều·Sorrel>"
  },
  RelicConfig_71245_BattleDesc = {
    Text = "Tại thời điểm bắt đầu vòng, Ogier nhận được [Arg1] cơn cuồng nộ. Sau khi đánh ra \"Ngọn giáo xuyên thấu\" hoặc \"Đòn tấn công\" của Ogier lần đầu trong mỗi vòng, sẽ tăng cường khiên và sức mạnh mà Ogier gây ra trong vòng này lên [Arg2]%."
  },
  RelicConfig_71245_Desc = {
    Text = "Tại thời điểm bắt đầu vòng, Ogier nhận được [Arg1] cơn cuồng nộ. Sau khi đánh ra \"Ngọn giáo xuyên thấu\" hoặc \"Đòn tấn công\" của Ogier lần đầu trong mỗi vòng, sẽ tăng cường khiên và sức mạnh mà Ogier gây ra trong vòng này lên [Arg2]%."
  },
  RelicConfig_71245_Name = {
    Text = "<OrangeQuality:hình ảnh chiều không gian·Orci>"
  },
  RelicConfig_71246_BattleDesc = {
    Text = "Vào đầu lượt, Elva nhận được [Arg1] điên cuồng. Khi Elva đánh lá thứ [Arg2] \"phòng thủ\" trong 1 lượt, đặt một lá \"tâm nhãn lợi nhận\"đã tiêu thụ vào tay; khi đánh lá thứ [Arg3] \"đánh\", đặt 1 lá \"lâm chiến thể thế\"đã tiêu thụ vào tay."
  },
  RelicConfig_71246_Desc = {
    Text = "Vào đầu lượt, Elva nhận được [Arg1] điên cuồng. Khi Elva đánh lá thứ [Arg2] \"phòng thủ\" trong 1 lượt, đặt một lá \"tâm nhãn lợi nhận\"đã tiêu thụ vào tay; khi đánh lá thứ [Arg3] \"đánh\", đặt 1 lá \"lâm chiến thể thế\"đã tiêu thụ vào tay."
  },
  RelicConfig_71246_Name = {
    Text = "<OrangeQuality:chiều không gian·Elva>"
  },
  RelicConfig_71247_BattleDesc = {
    Text = "Vào đầu lượt, Jenkin nhận được [Arg1] điên cuồng, tăng thương cuối + [Arg2]%. \"Brun ra trận\" có cơ sở thương và sát thương tăng trưởng được cải thiện [Arg3]%."
  },
  RelicConfig_71247_Desc = {
    Text = "Vào đầu lượt, Jenkin nhận được [Arg1] điên cuồng, tăng thương cuối + [Arg2]%. \"Brun ra trận\" có cơ sở thương và sát thương tăng trưởng được cải thiện [Arg3]%."
  },
  RelicConfig_71247_Name = {
    Text = "<OrangeQuality:chiều ảnh·Jenkin>"
  },
  RelicConfig_71248_BattleDesc = {
    Text = "Vào đầu lượt, đóa nhận được [Arg1] điên cuồng. Khi chiến đấu bắt đầu, làm cho chi phí sức tính toán của \"trao đổi tương đương\" của đóa trở thành 0, sau khi đánh ra, lượt kế tiếp rút thêm [Arg2] lá bài."
  },
  RelicConfig_71248_Desc = {
    Text = "Vào đầu lượt, đóa nhận được [Arg1] điên cuồng. Khi chiến đấu bắt đầu, làm cho chi phí sức tính toán của \"trao đổi tương đương\" của đóa trở thành 0, sau khi đánh ra, lượt kế tiếp rút thêm [Arg2] lá bài."
  },
  RelicConfig_71248_Name = {
    Text = "<OrangeQuality:ảnh chiều·đóa>"
  },
  RelicConfig_71249_BattleDesc = {
    Text = "Vào đầu lượt, Lắc nhận được [Arg1] cuồng nộ. Mỗi lượt, kết quả xúc xắc lần đầu tiên luôn là giá trị lớn nhất."
  },
  RelicConfig_71249_Desc = {
    Text = "Vào đầu lượt, Lắc nhận được [Arg1] cuồng nộ. Mỗi lượt, kết quả xúc xắc lần đầu tiên luôn là giá trị lớn nhất."
  },
  RelicConfig_71249_Name = {
    Text = "<OrangeQuality:chiều hình·Lắc>"
  },
  RelicConfig_71250_BattleDesc = {
    Text = "Vào đầu lượt, Miriam nhận được [Arg1] cuồng khí và đặt 1 lá \"Thánh lễ\" vào bộ bài của mình."
  },
  RelicConfig_71250_Desc = {
    Text = "Vào đầu lượt, Miriam nhận được [Arg1] cuồng khí và đặt 1 lá \"Thánh lễ\" vào bộ bài của mình."
  },
  RelicConfig_71250_Name = {
    Text = "<OrangeQuality:hình ảnh chiều không gian·Miriam>"
  },
  RelicConfig_71251_BattleDesc = {
    Text = "Vào đầu lượt, Wenkel nhận được [Arg1] điên cuồng. Mỗi khi các thân thể được đánh thức khác phát động cơn thịnh nộ bộc phát, Wenkel sẽ nhận thêm [Arg2] điểm điên cuồng và giảm tiêu thụ sức tính toán của \"xây dựng tinh thần\" trong tay còn [Arg3]."
  },
  RelicConfig_71251_Desc = {
    Text = "Vào đầu lượt, Wenkel nhận được [Arg1] điên cuồng. Mỗi khi các thân thể được đánh thức khác phát động cơn thịnh nộ bộc phát, Wenkel sẽ nhận thêm [Arg2] điểm điên cuồng và giảm tiêu thụ sức tính toán của \"xây dựng tinh thần\" trong tay còn [Arg3]."
  },
  RelicConfig_71251_Name = {
    Text = "<OrangeQuality:ảnh chiếu chiều·Wenkel>"
  },
  RelicConfig_71252_BattleDesc = {
    Text = "Vào đầu lượt, tulô nhận được [Arg1] điên cuồng. Điên cuồng cơ bản của tulô giảm [Arg2] điểm, sau khi bùng nổ điên cuồng sẽ ngay lập tức tạo ra [Arg3] râu chạm tạm thời."
  },
  RelicConfig_71252_Desc = {
    Text = "Vào đầu lượt, tulô nhận được [Arg1] điên cuồng. Điên cuồng cơ bản của tulô giảm [Arg2] điểm, sau khi bùng nổ điên cuồng sẽ ngay lập tức tạo ra [Arg3] râu chạm tạm thời."
  },
  RelicConfig_71252_Name = {
    Text = "<OrangeQuality:ảnh chiều·tulô>"
  },
  RelicConfig_71253_BattleDesc = {
    Text = "Vào đầu lượt, Phiệt nhận được [Arg1] cuồng nộ. Hiệu ứng lá chắn, phản công và hồi sức sống của Phiệt tăng [Arg2]%, mỗi lần kích hoạt kháng cự tử vong sẽ làm tăng hiệu ứng này trong cuộc thám hiểm lên [Arg3]%, tối đa [Arg4] lần."
  },
  RelicConfig_71253_Desc = {
    Text = "Vào đầu lượt, Phiệt nhận được [Arg1] cuồng nộ. Hiệu ứng lá chắn, phản công và hồi sức sống của Phiệt tăng [Arg2]%, mỗi lần kích hoạt kháng cự tử vong sẽ làm tăng hiệu ứng này trong cuộc thám hiểm lên [Arg3]%, tối đa [Arg4] lần."
  },
  RelicConfig_71253_Name = {
    Text = "<OrangeQuality:chiều hình ảnh·Phiệt>"
  },
  RelicConfig_71254_BattleDesc = {
    Text = "Vào đầu lượt, Tà Vy nhận được [Arg1] điên cuồng. Nếu trong một lượt đã đánh ra [Arg2] lá thẻ lệnh của Tà Vy, sẽ đặt 1 lá <DerivativeCardKeywords_67:「chìa khóa bạc huy hoàng」> vào tay, hồi chiêu [Arg3] lượt."
  },
  RelicConfig_71254_Desc = {
    Text = "Vào đầu lượt, Tà Vy nhận được [Arg1] điên cuồng. Nếu trong một lượt đã đánh ra [Arg2] lá thẻ lệnh của Tà Vy, sẽ đặt 1 lá <DerivativeCardKeywords_67:「chìa khóa bạc huy hoàng」> vào tay, hồi chiêu [Arg3] lượt."
  },
  RelicConfig_71254_Name = {
    Text = "<OrangeQuality:ảnh chiều·Tà Vy>"
  },
  RelicConfig_71255_BattleDesc = {
    Text = "Khi bắt đầu lượt, Hamlin nhận được [Arg1] Điên loạn. Giá trị Điểm tính toán cơ bản của \"Prélude của linh hồn\" giảm [Arg2], số lần sát thương cơ bản tăng [Arg3]."
  },
  RelicConfig_71255_Desc = {
    Text = "Khi bắt đầu lượt, Hamlin nhận được [Arg1] Điên loạn. Giá trị Điểm tính toán cơ bản của \"Prélude của linh hồn\" giảm [Arg2], số lần sát thương cơ bản tăng [Arg3]."
  },
  RelicConfig_71255_Name = {
    Text = "<OrangeQuality:hình ảnh chiều kích·Hamlin>"
  },
  RelicConfig_71256_BattleDesc = {
    Text = "Vào đầu lượt, Ôrla nhận được [Arg1] điên cuồng. Vào đầu chiến đấu, nhận được mỗi 「ẩn dụ」 của tất cả cảm xúc ở cấp độ [Arg2], hiệu ứng 「ẩn dụ」 tăng 50%."
  },
  RelicConfig_71256_Desc = {
    Text = "Vào đầu lượt, Ôrla nhận được [Arg1] điên cuồng. Vào đầu chiến đấu, nhận được mỗi 「ẩn dụ」 của tất cả cảm xúc ở cấp độ [Arg2], hiệu ứng 「ẩn dụ」 tăng 50%."
  },
  RelicConfig_71256_Name = {
    Text = "<OrangeQuality:chiều hình ảnh·Ôrla>"
  },
  RelicConfig_71257_BattleDesc = {
    Text = "Vào đầu lượt, Muphí nhận được [Arg1] điên cuồng. \"Đánh\" và \"Phòng thủ\" của Muphí có thể chuyển [Arg2]% \"Hiến tế\" thành thương tổn xúc tu tạm thời, nhưng chỉ có hiệu lực tối đa 1 lần mỗi lượt."
  },
  RelicConfig_71257_Desc = {
    Text = "Vào đầu lượt, Muphí nhận được [Arg1] điên cuồng. \"Đánh\" và \"Phòng thủ\" của Muphí có thể chuyển [Arg2]% \"Hiến tế\" thành thương tổn xúc tu tạm thời, nhưng chỉ có hiệu lực tối đa 1 lần mỗi lượt."
  },
  RelicConfig_71257_Name = {
    Text = "<OrangeQuality:hình ảnh chiều không gian·Muphí>"
  },
  RelicConfig_71258_BattleDesc = {
    Text = "Vào đầu mỗi lượt, Uvhash nhận được [Arg1] điểm Aliemus. Lượng tiêu hao Aliemus cơ bản của Uvhash giảm [Arg2] điểm, mỗi lần phát động Aliemus bùng nổ giảm thêm 5 điểm, mỗi lượt có thể phát động [Arg3] lần Aliemus bùng nổ."
  },
  RelicConfig_71258_Desc = {
    Text = "Vào đầu mỗi lượt, Uvhash nhận được [Arg1] điểm Aliemus. Lượng tiêu hao Aliemus cơ bản của Uvhash giảm [Arg2] điểm, mỗi lần phát động Aliemus bùng nổ giảm thêm 5 điểm, mỗi lượt có thể phát động [Arg3] lần Aliemus bùng nổ."
  },
  RelicConfig_71258_Name = {
    Text = "<OrangeQuality:chiều ảnh · Yu U Hahi>"
  },
  RelicConfig_71259_BattleDesc = {
    Text = "Vào đầu lượt, Ai Jī Sī nhận được [Arg1] điên cuồng. Khi gây thương lên kẻ địch có tăng sát thương, cô cướp đi [Arg2] điểm lực lượng tạm thời, tối đa [Arg3] lần mỗi lượt."
  },
  RelicConfig_71259_Desc = {
    Text = "Vào đầu lượt, Ai Jī Sī nhận được [Arg1] điên cuồng. Khi gây thương lên kẻ địch có tăng sát thương, cô cướp đi [Arg2] điểm lực lượng tạm thời, tối đa [Arg3] lần mỗi lượt."
  },
  RelicConfig_71259_Name = {
    Text = "<OrangeQuality:chiều hình ảnh·Ai Jī Sī>"
  },
  RelicConfig_71260_BattleDesc = {
    Text = "Vào đầu lượt, Thái Di Sơ nhận được [Arg1] cuồng khí. Nếu Thái Di Sơ đánh ra [Arg2] thẻ lệnh trong 1 lượt, cô sẽ nhận được một \"Thánh Khiết Chi Tử\" và [Arg3] điểm lực lượng tạm thời, [Arg4] lượt làm lạnh."
  },
  RelicConfig_71260_Desc = {
    Text = "Vào đầu lượt, Thái Di Sơ nhận được [Arg1] cuồng khí. Nếu Thái Di Sơ đánh ra [Arg2] thẻ lệnh trong 1 lượt, cô sẽ nhận được một \"Thánh Khiết Chi Tử\" và [Arg3] điểm lực lượng tạm thời, [Arg4] lượt làm lạnh."
  },
  RelicConfig_71260_Name = {
    Text = "<OrangeQuality:ảnh hưởng chiều·Thái Di Sơ>"
  },
  RelicConfig_71261_BattleDesc = {
    Text = "Vào đầu lượt, Pháp Luân Tư nhận được [Arg1] điên cuồng. Mỗi 2 lần gây thương tổn xúc tu, tăng thêm [Arg2]% hiệu ứng trúng độc và lá chắn trong trận chiến hiện tại, tối đa là 50%."
  },
  RelicConfig_71261_Desc = {
    Text = "Vào đầu lượt, Pháp Luân Tư nhận được [Arg1] điên cuồng. Mỗi 2 lần gây thương tổn xúc tu, tăng thêm [Arg2]% hiệu ứng trúng độc và lá chắn trong trận chiến hiện tại, tối đa là 50%."
  },
  RelicConfig_71261_Name = {
    Text = "<OrangeQuality:ảnh chiều·Pháp Lỗ Tư>"
  },
  RelicConfig_71262_BattleDesc = {
    Text = "Vào đầu lượt, Pandia nhận được [Arg1] năng lượng điên cuồng. Sau khi Pandia bùng nổ cơn thịnh nộ, cô ấy nhận được [Arg2]% phản công vĩnh viễn từ phản công tạm thời."
  },
  RelicConfig_71262_Desc = {
    Text = "Vào đầu lượt, Pandia nhận được [Arg1] năng lượng điên cuồng. Sau khi Pandia bùng nổ cơn thịnh nộ, cô ấy nhận được [Arg2]% phản công vĩnh viễn từ phản công tạm thời."
  },
  RelicConfig_71262_Name = {
    Text = "<OrangeQuality:chiều hình ảnh·Pandia>"
  },
  RelicConfig_71263_BattleDesc = {
    Text = "Vào đầu lượt, Lily nhận được [Arg1] điên cuồng. Giới hạn nhẫn nại của Lily tăng 100%, khi sử dụng \"bông hoa bất diệt trên bùn lầy\" hoặc \"đánh trả thù\", hồi phục 8% sức sống dựa trên số lớp \"nhẫn nại\"."
  },
  RelicConfig_71263_Desc = {
    Text = "Vào đầu lượt, Lily nhận được [Arg1] điên cuồng. Giới hạn nhẫn nại của Lily tăng 100%, khi sử dụng \"bông hoa bất diệt trên bùn lầy\" hoặc \"đánh trả thù\", hồi phục 8% sức sống dựa trên số lớp \"nhẫn nại\"."
  },
  RelicConfig_71263_Name = {
    Text = "<OrangeQuality:chiều hình ảnh·Lily>"
  },
  RelicConfig_71264_BattleDesc = {
    Text = "Vào đầu lượt, Gia Lân nhận được [Arg1] điên cuồng. Khi sử dụng \"Tĩnh Mặc Thủ Vọng\", sức tính toán tiêu thụ sẽ được hoàn lại gấp đôi, thời gian hồi [Arg2] lượt."
  },
  RelicConfig_71264_Desc = {
    Text = "Vào đầu lượt, Gia Lân nhận được [Arg1] điên cuồng. Khi sử dụng \"Tĩnh Mặc Thủ Vọng\", sức tính toán tiêu thụ sẽ được hoàn lại gấp đôi, thời gian hồi [Arg2] lượt."
  },
  RelicConfig_71264_Name = {
    Text = "<OrangeQuality:ảnh chiều·Gia Lân>"
  },
  RelicConfig_71265_BattleDesc = {
    Text = "Vào đầu lượt, Salvador nhận được [Arg1] điên cuồng. Mỗi lần tích lũy lò luyện màu đỏ thẫm, anh ta còn nhận được [Arg2]% lực lượng theo lượng tích lũy. Các đòn đánh \"đánh\" và \"đau khổ phải tiêu trừ\" của Salvador được hưởng thêm [Arg3] lần lực lượng."
  },
  RelicConfig_71265_Desc = {
    Text = "Vào đầu lượt, Salvador nhận được [Arg1] điên cuồng. Mỗi lần tích lũy lò luyện màu đỏ thẫm, anh ta còn nhận được [Arg2]% lực lượng theo lượng tích lũy. Các đòn đánh \"đánh\" và \"đau khổ phải tiêu trừ\" của Salvador được hưởng thêm [Arg3] lần lực lượng."
  },
  RelicConfig_71265_Name = {
    Text = "<OrangeQuality:hình ảnh chiều kích·Salvador>"
  },
  RelicConfig_71266_BattleDesc = {
    Text = "Vào đầu lượt, Kẻ khắc sét nhận được [Arg1] cuồng nộ. Khi Kẻ khắc sét nhận được lá chắn, hồi [Arg2]% máu từ lá chắn."
  },
  RelicConfig_71266_Desc = {
    Text = "Vào đầu lượt, Kẻ khắc sét nhận được [Arg1] cuồng nộ. Khi Kẻ khắc sét nhận được lá chắn, hồi [Arg2]% máu từ lá chắn."
  },
  RelicConfig_71266_Name = {
    Text = "<OrangeQuality:Chiều Ảnh·Kẻ khắc sét>"
  },
  RelicConfig_71267_BattleDesc = {
    Text = "Vào đầu lượt, Ninh Phi Nga nhận được [Arg1] cuồng nộ. Sau khi đánh ra \"đánh\" của Ninh Phi Nga, tăng [Arg2]% trúng độc gây ra bởi \"Ninh Phi Nga\" trong trận chiến này. Sau khi đánh ra \"phòng thủ\" của Ninh Phi Nga, gây ra [Arg3]% trúng độc cho tất cả kẻ địch. Mỗi lượt tối đa chỉ có hiệu lực 1 lần."
  },
  RelicConfig_71267_Desc = {
    Text = "Vào đầu lượt, Ninh Phi Nga nhận được [Arg1] cuồng nộ. Sau khi đánh ra \"đánh\" của Ninh Phi Nga, tăng [Arg2]% trúng độc gây ra bởi \"Ninh Phi Nga\" trong trận chiến này. Sau khi đánh ra \"phòng thủ\" của Ninh Phi Nga, gây ra [Arg3]% trúng độc cho tất cả kẻ địch. Mỗi lượt tối đa chỉ có hiệu lực 1 lần."
  },
  RelicConfig_71267_Name = {
    Text = "<OrangeQuality:hình ảnh chiều·Ninh Phi Nga>"
  },
  RelicConfig_71268_BattleDesc = {
    Text = "Vào đầu lượt, Erika nhận được [Arg1] điên cuồng. Khi Erika sử dụng [Arg2] thẻ lệnh trong 1 lượt, cô ấy nhận được 2 điểm sức tính toán và tăng gấp đôi lực lượng và giữ mình của \"Điện Từ Bạo Phá\" trong trận chiến này."
  },
  RelicConfig_71268_Desc = {
    Text = "Vào đầu lượt, Erika nhận được [Arg1] điên cuồng. Khi Erika sử dụng [Arg2] thẻ lệnh trong 1 lượt, cô ấy nhận được 2 điểm sức tính toán và tăng gấp đôi lực lượng và giữ mình của \"Điện Từ Bạo Phá\" trong trận chiến này."
  },
  RelicConfig_71268_Name = {
    Text = "<OrangeQuality:chiều ảnh Erika>"
  },
  RelicConfig_71269_BattleDesc = {
    Text = "Vào đầu lượt, Goliath nhận được [Arg1] cuồng nộ. Nếu Goliath gây [Arg2] lần thương trong 1 lượt, sát thương từ Goliath trong trận chiến này sẽ được tăng gấp đôi, làm mới sau 3 lượt."
  },
  RelicConfig_71269_Desc = {
    Text = "Vào đầu lượt, Goliath nhận được [Arg1] cuồng nộ. Nếu Goliath gây [Arg2] lần thương trong 1 lượt, sát thương từ Goliath trong trận chiến này sẽ được tăng gấp đôi, làm mới sau 3 lượt."
  },
  RelicConfig_71269_Name = {
    Text = "<OrangeQuality:ảnh chiều·Goliath>"
  },
  RelicConfig_71270_BattleDesc = {
    Text = "Tại đầu lượt, sơn nhận được [Arg1] điên cuồng. Tại đầu chiến đấu, tất cả các thẻ lệnh của sơn được áp dụng thuộc tính bảo lưu, chuẩn bị 1, và nhận được [Arg2] điểm lá chắn."
  },
  RelicConfig_71270_Desc = {
    Text = "Tại đầu lượt, sơn nhận được [Arg1] điên cuồng. Tại đầu chiến đấu, tất cả các thẻ lệnh của sơn được áp dụng thuộc tính bảo lưu, chuẩn bị 1, và nhận được [Arg2] điểm lá chắn."
  },
  RelicConfig_71270_Name = {
    Text = "<OrangeQuality:Hình ảnh chiều không gian·Sơn>"
  },
  RelicConfig_71662_BattleDesc = {
    Text = "Vào đầu lượt chẵn, đặt 1 lá <DerivativeCardKeywords_105:「Kho báu Bạc Tâm Vô tận」> vào tay."
  },
  RelicConfig_71662_Desc = {
    Text = "Vào đầu lượt chẵn, đặt 1 lá <DerivativeCardKeywords_105:「Kho báu Bạc Tâm Vô tận」> vào tay."
  },
  RelicConfig_71662_Name = {
    Text = "<OrangeQuality:kho báu của chú mèo>"
  },
  RelicConfig_72226_BattleDesc = {
    Text = "Giới hạn bài trong tay +1. Khi bắt đầu lượt, nếu hiện tại chưa tiến hành nghiên cứu, chọn một nghiên cứu chưa được thực hiện, hoàn thành nghiên cứu đó và nhận kết quả nghiên cứu tương ứng của Meltdown Đóa. Sau khi hoàn thành 3 nghiên cứu, đặt \"Hư Vô Kết Thúc\" vào tay, sáng tạo này mất hiệu lực."
  },
  RelicConfig_72226_Desc = {
    Text = "Giới hạn bài trong tay +1. Khi bắt đầu lượt, nếu hiện tại chưa tiến hành nghiên cứu, chọn một nghiên cứu chưa được thực hiện, hoàn thành nghiên cứu đó và nhận kết quả nghiên cứu tương ứng của Meltdown Đóa. Sau khi hoàn thành 3 nghiên cứu, đặt \"Hư Vô Kết Thúc\" vào tay, sáng tạo này mất hiệu lực."
  },
  RelicConfig_72226_Name = {
    Text = "Bản thảo nghiên cứu hậu tận thế"
  },
  RelicConfig_74832_BattleDesc = {
    Text = "Số lượng bài trong tay +1. Vào đầu mỗi lượt, nhận một lá bài tùy chỉnh \"Giao dịch Cấm kỵ\", sau khi đánh \"Giao dịch Cấm kỵ\", lượt tiếp theo có thể kích hoạt lại. Khi giữ \"Giao dịch Cấm kỵ\" và đánh các loại \"thẻ lệnh\" khác nhau sẽ nâng cấp hiệu ứng tương ứng trong đó."
  },
  RelicConfig_74832_Desc = {
    Text = "Số lượng bài trong tay +1. Vào đầu mỗi lượt, nhận một lá bài tùy chỉnh \"Giao dịch Cấm kỵ\", sau khi đánh \"Giao dịch Cấm kỵ\", lượt tiếp theo có thể kích hoạt lại. Khi giữ \"Giao dịch Cấm kỵ\" và đánh các loại \"thẻ lệnh\" khác nhau sẽ nâng cấp hiệu ứng tương ứng trong đó."
  },
  RelicConfig_74832_Name = {
    Text = "Lời mời của Nghìn Gương Mặt"
  },
  RelicConfig_74832_StoryDesc = {
    Text = "Chữ viết trên bức thư liên tục thay đổi, luôn biến thành một cơn khát không thể từ chối."
  },
  RelicConfig_78664_BattleDesc = {
    Text = "Trong một lượt, sau khi chơi 4 thẻ lệnh thuộc về các thể thức tỉnh khác nhau, tất cả các thể thức tỉnh sẽ làm tăng sát thương cuối cùng gây ra trong lượt đó lên [Arg1]%, và mất [Arg2] điểm điên cuồng, mỗi lượt tối đa chỉ có hiệu lực 1 lần."
  },
  RelicConfig_78664_Desc = {
    Text = "Trong một lượt, sau khi đánh ra 4 thẻ lệnh thuộc về các thể thức tỉnh khác nhau, làm tăng sát thương cuối cùng do tất cả các thể thức tỉnh gây ra trong lượt đó lên [Arg1]%, và mất [Arg2] điểm điên cuồng, mỗi lượt tối đa chỉ có hiệu lực 1 lần."
  },
  RelicConfig_78664_Name = {
    Text = "<RedQuality:thanh câu kỳ quái>"
  },
  RelicConfig_78664_StoryDesc = {
    Text = "Loài khó nhận diện."
  },
  RelicConfig_78665_BattleDesc = {
    Text = "Vào đầu lượt, bớt rút [Arg1] lá bài. Mỗi lần đánh 1 lá bài có thực tế tiêu thụ sức tính toán lớn hơn hoặc bằng [Arg2] sẽ nhận được 1 điểm sức tính toán, mỗi lượt tối đa kích hoạt [Arg3] lần."
  },
  RelicConfig_78665_Desc = {
    Text = "Vào đầu lượt, bớt rút [Arg1] lá bài. Mỗi lần đánh 1 lá bài có thực tế tiêu thụ sức tính toán lớn hơn hoặc bằng [Arg2] sẽ nhận được 1 điểm sức tính toán, mỗi lượt tối đa kích hoạt [Arg3] lần."
  },
  RelicConfig_78665_Name = {
    Text = "<RedQuality:chuông gào thét>"
  },
  RelicConfig_78665_StoryDesc = {
    Text = "Đinh leng, đinh leng, đứa trẻ đang khóc; \nđinh leng, đinh leng, đứa trẻ đang hét lên; \nđinh leng, đinh leng, đứa trẻ đang than khóc; \nđinh leng, đinh leng, nó đói rồi, bạn biết mà."
  },
  RelicConfig_78666_BattleDesc = {
    Text = "Vào đầu lượt nhận được [Arg1] điểm phản công. Sau khi giải phóng [Arg2] lần cơn thịnh nộ trong một lượt, loại bỏ [Arg3]% phản công vĩnh viễn của bản thân, nhận [Arg4]% phản công tạm thời dựa trên lượng loại bỏ, làm mới sau [Arg5] lượt."
  },
  RelicConfig_78666_Desc = {
    Text = "Vào đầu lượt nhận được [Arg1] điểm phản công. Sau khi giải phóng [Arg2] lần cơn thịnh nộ bùng phát trong một lượt, loại bỏ [Arg3]% phản công vĩnh viễn của bản thân, nhận [Arg4]% phản công tạm thời từ lượng bị loại bỏ, làm mới sau [Arg5] lượt."
  },
  RelicConfig_78666_Name = {
    Text = "<RedQuality:Xác của Đạo Hành>"
  },
  RelicConfig_78666_StoryDesc = {
    Text = "Một phần thiêng liêng. \nDù có tách khỏi thân thể, dấu chân của nó đã in dấu chân trên khắp mọi miền."
  },
  RelicConfig_78667_BattleDesc = {
    Text = "Sau giai đoạn rút bài, rút thêm [Arg1] lá bài và chọn [Arg2] lá bài để bỏ."
  },
  RelicConfig_78667_Desc = {
    Text = "Sau giai đoạn rút bài, rút thêm [Arg1] lá bài và chọn [Arg2] lá bài để bỏ."
  },
  RelicConfig_78667_Name = {
    Text = "<RedQuality:mũ lưỡi trai thuật sĩ>"
  },
  RelicConfig_78667_StoryDesc = {
    Text = "Chào mừng bạn đến với rạp xiếc thần tiên của cô Kasia! Hãy cẩn thận, đừng tùy tiện chạm vào đạo cụ ảo thuật nhé. Nếu không may bị cắn, thì sẽ thật tồi tệ. \n Dù sao đi nữa, lần trước nó nếm thử vị máu, hậu quả thật sự rất kinh dị. \n\n Chiếc mũ chớp mắt, như thể sắp sửa thoát ra khỏi kén bất cứ lúc nào."
  },
  RelicConfig_78668_BattleDesc = {
    Text = "Sau khi sử dụng Đánh thức chìa khóa bạc, chọn [Arg1] thẻ lệnh không phái sinh tương ứng với Thể thức tỉnh để tiêu thụ, và đặt [Arg2] Sao chép nguyên bản được tiêu thụ thêm vào rút bài từ bộ bài, Tay và rác bài."
  },
  RelicConfig_78668_Desc = {
    Text = "Sau khi sử dụng Đánh thức chìa khóa bạc, chọn [Arg1] thẻ lệnh không phái sinh tương ứng với Thể thức tỉnh để tiêu thụ, và đặt [Arg2] Sao chép nguyên bản được tiêu thụ thêm vào rút bài từ bộ bài, Tay và rác bài."
  },
  RelicConfig_78668_Name = {
    Text = "<RedQuality:Ấn Ngọc Lục Bảo>"
  },
  RelicConfig_78668_StoryDesc = {
    Text = "Đây là bản khắc bất diệt qua nghìn năm."
  },
  RelicConfig_78669_BattleDesc = {
    Text = "Nhận [Arg1] điểm lực lượng khi bắt đầu chiến đấu. Mỗi khi bắt đầu lượt, cứ có [Arg2] điểm sức mạnh vĩnh viễn, nhận được [Arg3] điểm sức mạnh tạm thời, tối đa nhận [Arg4] điểm sức mạnh tạm thời, và vào cuối lượt sẽ mất một nửa lá chắn do di vật này cung cấp sức mạnh tạm thời."
  },
  RelicConfig_78669_Desc = {
    Text = "Nhận [Arg1] điểm lực lượng khi bắt đầu chiến đấu. Khi bắt đầu lượt, mỗi khi có [Arg2] điểm sức mạnh vĩnh viễn, nhận [Arg3] điểm sức mạnh tạm thời, tối đa nhận [Arg4] điểm sức mạnh tạm thời, và vào cuối lượt, mất một nửa lá chắn do di vật này cung cấp sức mạnh tạm thời."
  },
  RelicConfig_78669_Name = {
    Text = "<RedQuality:chim nghi lễ nguyền rủa>"
  },
  RelicConfig_78669_StoryDesc = {
    Text = "Xác chết khô khan phát ra tiếng kêu thê lương."
  },
  RelicConfig_78670_BattleDesc = {
    Text = "Tất cả các thân thể được đánh thức có thương cơ bản tăng [Arg1]%, mỗi lần đặt lại bộ bài tăng thêm [Arg2]%, nhưng thêm 1 lá \"bước đi chậm chạp\" vào tay, giá trị tăng tối đa là [Arg3]%."
  },
  RelicConfig_78670_Desc = {
    Text = "Tất cả các thân thể được đánh thức có thương cơ bản tăng [Arg1]%, mỗi lần đặt lại bộ bài tăng thêm [Arg2]%, nhưng thêm 1 lá \"bước đi chậm chạp\" vào tay, giá trị tăng tối đa là [Arg3]%."
  },
  RelicConfig_78670_Name = {
    Text = "<RedQuality:nến đen>"
  },
  RelicConfig_78670_StoryDesc = {
    Text = "Thiêu đốt sự tỉnh thức, trượt vào hư vọng."
  },
  RelicConfig_78671_BattleDesc = {
    Text = "Vào đầu lượt, độ phôi hợp tử + [Arg1],\"phôi thai\" của bạn sẽ bị bỏ đi vào cuối lượt."
  },
  RelicConfig_78671_Desc = {
    Text = "Vào đầu lượt, độ phôi hợp tử + [Arg1],\"phôi thai\" của bạn sẽ bị bỏ đi vào cuối lượt."
  },
  RelicConfig_78671_Name = {
    Text = "<RedQuality:cuống rốn ngọ nguậy>"
  },
  RelicConfig_78671_StoryDesc = {
    Text = "Cuốn quanh cổ."
  },
  RelicConfig_78672_BattleDesc = {
    Text = "Vào đầu mỗi lượt, nhận [Arg2] lớp Độc dược, mỗi vị trí trống trong không gian Ultra nhận [Arg1] điểm Sức mạnh."
  },
  RelicConfig_78672_Desc = {
    Text = "Vào đầu mỗi lượt, nhận [Arg2] lớp Độc dược, mỗi vị trí trống trong không gian Ultra nhận [Arg1] điểm Sức mạnh."
  },
  RelicConfig_78672_Name = {
    Text = "<RedQuality:ý thức bầy đàn>"
  },
  RelicConfig_78672_StoryDesc = {
    Text = "Bị cuốn vào, sự cộng sinh, sự quần tụ; sợ hãi, điều chưa biết, kiểm soát."
  },
  RelicConfig_78673_BattleDesc = {
    Text = "Sau khi Bạc Khóa Tỉnh Thức, tiêu thụ thêm [Arg1] điểm năng lượng chìa khóa bạc, khiến sức tính toán của thẻ Thức tỉnh linh tri trở thành 0, sau khi sử dụng, thân thể được đánh thức tương ứng sẽ nhận thêm [Arg2] điểm điên cuồng."
  },
  RelicConfig_78673_Desc = {
    Text = "Sau khi Bạc Khóa Tỉnh Thức, tiêu thụ thêm [Arg1] điểm năng lượng chìa khóa bạc, khiến sức tính toán của thẻ Thức tỉnh linh tri trở thành 0, sau khi sử dụng, thân thể được đánh thức tương ứng sẽ nhận thêm [Arg2] điểm điên cuồng."
  },
  RelicConfig_78673_Name = {
    Text = "<RedQuality:khắc dấu ý thức>"
  },
  RelicConfig_78673_StoryDesc = {
    Text = "Bộ lạc cổ xưa tin rằng, khắc các ký hiệu đặc biệt trên đầu người chết có thể giữ lại linh hồn của người đó, để có được sự đồng hành mãi mãi."
  },
  RelicConfig_78674_BattleDesc = {
    Text = "Khi bắt đầu chiến đấu, gây [Arg1] điểm trúng độc cho tất cả kẻ địch. Khi bắt đầu lượt, loại bỏ [Arg2]% trúng độc từ kẻ địch và gây [Arg3]% chảy máu dựa trên lượng đã loại bỏ."
  },
  RelicConfig_78674_Desc = {
    Text = "Khi bắt đầu chiến đấu, gây [Arg1] điểm trúng độc cho tất cả kẻ địch. Khi bắt đầu lượt, loại bỏ [Arg2]% trúng độc từ kẻ địch và gây [Arg3]% chảy máu dựa trên lượng đã loại bỏ."
  },
  RelicConfig_78674_Name = {
    Text = "<RedQuality:tay hỗ trợ>"
  },
  RelicConfig_78674_StoryDesc = {
    Text = "Một phần linh thiêng. \nDù có tách rời khỏi thân thể, vẫn cảm nhận được sự ấm áp dịu dàng trên đó."
  },
  RelicConfig_78675_BattleDesc = {
    Text = "Khi bắt đầu lượt, nếu có hơn [Arg1] râu chạm vĩnh viễn, hy sinh [Arg2] râu chạm để đổi lấy [Arg3] râu chạm tạm thời, ngược lại nhận [Arg4] râu chạm vĩnh viễn."
  },
  RelicConfig_78675_Desc = {
    Text = "Khi bắt đầu lượt, nếu có hơn [Arg1] râu chạm vĩnh viễn, hy sinh [Arg2] râu chạm để đổi lấy [Arg3] râu chạm tạm thời, ngược lại nhận [Arg4] râu chạm vĩnh viễn."
  },
  RelicConfig_78675_Name = {
    Text = "<RedQuality:Vòng Tay Thánh Khổ Đau>"
  },
  RelicConfig_78675_StoryDesc = {
    Text = "Chịu đựng đau khổ."
  },
  RelicConfig_79408_BattleDesc = {
    Text = "Giới hạn số lượng thẻ +2, số lượng bốc thăm +2. \"Kí ức trong sáng\" bắt đầu ở 5 cấp độ, chơi thẻ có dấu sẽ làm \"Kí ức trong sáng\" thay đổi. Mỗi điểm thấp hơn 5 của \"Kí ức trong sáng\" sát thương cuối cùng +10%, giảm khiên và hồi phục cuộc sống 5%; mỗi điểm cao hơn 5 của \"Kí ức trong sáng\" tăng hồi phục khiên và cuộc sống 5%, giảm sát thương cuối cùng -10%."
  },
  RelicConfig_79408_Desc = {
    Text = "Giới hạn số lượng thẻ +2, số lượng bốc thăm +2. \"Kí ức trong sáng\" bắt đầu ở 5 cấp độ, chơi thẻ có dấu sẽ làm \"Kí ức trong sáng\" thay đổi. Mỗi điểm thấp hơn 5 của \"Kí ức trong sáng\" sát thương cuối cùng +10%, giảm khiên và hồi phục cuộc sống 5%; mỗi điểm cao hơn 5 của \"Kí ức trong sáng\" tăng hồi phục khiên và cuộc sống 5%, giảm sát thương cuối cùng -10%."
  },
  RelicConfig_79408_Name = {
    Text = "\"Ký ức\" và \"Giấc mơ\""
  },
  RelicConfig_79408_StoryDesc = {
    Text = "\"Đến đây, hãy nghe tôi nói.\"\n \"Để tôi biến ký ức và giấc mơ của bạn.\"\n \"Biến chúng thành một món tráng miệng cực kỳ ngon miệng.\""
  },
  RelicConfig_80340_BattleDesc = {
    Text = "Khi bắt đầu vòng, Clementine nhận được [Arg1] Aliemus. Tất cả các thẻ lệnh của Clementine tăng 1 lần hiệu ứng sát thương, khiên, hồi phục cuộc sống, nhận Aliemus, nhận S-energy."
  },
  RelicConfig_80340_Desc = {
    Text = "Khi bắt đầu vòng, Clementine nhận được [Arg1] Aliemus. Tất cả các thẻ lệnh của Clementine tăng 1 lần hiệu ứng sát thương, khiên, hồi phục cuộc sống, nhận Aliemus, nhận S-energy."
  },
  RelicConfig_80340_Name = {
    Text = "<OrangeQuality:Hình Ảnh Chiều Không Gian·Clementine>"
  },
  RelicConfig_83509_BattleDesc = {
    Text = "Khi bắt đầu khám phá, giới hạn tạo vật tăng thêm +1, người đánh thức trong cõi \"sâu biển\" có được \"Hình ảnh chiều không gian\" của nó. Mỗi khi có 1 người đánh thức trong cõi \"sâu biển\" trong đội, giới hạn tạo vật tăng thêm +1."
  },
  RelicConfig_83509_Desc = {
    Text = "Khi bắt đầu khám phá, giới hạn tạo vật tăng thêm +1, người đánh thức trong cõi \"sâu biển\" có được \"Hình ảnh chiều không gian\" của nó. Mỗi khi có 1 người đánh thức trong cõi \"sâu biển\" trong đội, giới hạn tạo vật tăng thêm +1."
  },
  RelicConfig_83509_Name = {
    Text = "<OrangeQuality:\"Chỉ vòng sâu biển\">"
  },
  RelicConfig_83509_StoryDesc = {
    Text = "Những người ngủ trong Biển Abyss, bắt đầu thể hiện quyền lực bị lãng quên với thế giới."
  },
  RelicConfig_83510_BattleDesc = {
    Text = "Khi bắt đầu khám phá, giới hạn tạo vật tăng thêm +1, người đánh thức trong cõi \"máu thịt\" có được \"Hình ảnh chiều không gian\" của nó. Mỗi khi có 1 người đánh thức trong cõi \"máu thịt\" trong đội, giới hạn tạo vật tăng thêm +1."
  },
  RelicConfig_83510_Desc = {
    Text = "Khi bắt đầu khám phá, giới hạn tạo vật tăng thêm +1, người đánh thức trong cõi \"máu thịt\" có được \"Hình ảnh chiều không gian\" của nó. Mỗi khi có 1 người đánh thức trong cõi \"máu thịt\" trong đội, giới hạn tạo vật tăng thêm +1."
  },
  RelicConfig_83510_Name = {
    Text = "<OrangeQuality:\"Chỉ vòng máu thịt\">"
  },
  RelicConfig_83510_StoryDesc = {
    Text = "Từ không còn mong manh, giờ đã bay lên."
  },
  RelicConfig_83511_BattleDesc = {
    Text = "Khi bắt đầu khám phá, giới hạn tạo vật tăng thêm +1, người đánh thức trong cõi \"siêu việt\" có được \"Hình ảnh chiều không gian\" của nó. Mỗi khi có 1 người đánh thức trong cõi \"siêu việt\" trong đội, giới hạn tạo vật tăng thêm +1."
  },
  RelicConfig_83511_Desc = {
    Text = "Khi bắt đầu khám phá, giới hạn tạo vật tăng thêm +1, người đánh thức trong cõi \"siêu việt\" có được \"Hình ảnh chiều không gian\" của nó. Mỗi khi có 1 người đánh thức trong cõi \"siêu việt\" trong đội, giới hạn tạo vật tăng thêm +1."
  },
  RelicConfig_83511_Name = {
    Text = "<OrangeQuality:\"Chỉ vòng siêu duy\">"
  },
  RelicConfig_83511_StoryDesc = {
    Text = "Các chiều không gian vô tận chồng chất lại, lúc này \"tôi\"đã vô hạn hoàn chỉnh."
  },
  RelicConfig_83512_BattleDesc = {
    Text = "Khi bắt đầu khám phá, giới hạn tạo vật tăng thêm +1, người đánh thức trong cõi \"hỗn loạn\" có được \"Hình ảnh chiều không gian\" của nó. Mỗi khi có 1 người đánh thức trong cõi \"hỗn loạn\" trong đội, giới hạn tạo vật tăng thêm +1."
  },
  RelicConfig_83512_Desc = {
    Text = "Khi bắt đầu khám phá, giới hạn tạo vật tăng thêm +1, người đánh thức trong cõi \"hỗn loạn\" có được \"Hình ảnh chiều không gian\" của nó. Mỗi khi có 1 người đánh thức trong cõi \"hỗn loạn\" trong đội, giới hạn tạo vật tăng thêm +1."
  },
  RelicConfig_83512_Name = {
    Text = "<OrangeQuality:\"Chỉ vòng hỗn loạn\">"
  },
  RelicConfig_83512_StoryDesc = {
    Text = "Hỗn mang vô hình, hỗn mang vô chất, hỗn mang đã hòa nhập vào vạn vật."
  },
  RelicConfig_83606_BattleDesc = {
    Text = "Giới hạn số lá trên tay +1. Khi bắt đầu lượt nếu không có \"Lựa Chọn của Người Dẫn Đường\", hãy đặt nó vào tay.\nMỗi khi thủ lĩnh mất 10% máu tối đa ban đầu, nhận 1 lớp \"Giăng Buồm\", tối đa 10 lớp, \"Giăng Buồm\" có thể nâng cao hiệu ứng của \"Khơi Buồm Ra Khơi\".\nMỗi khi bản thân mất 10% máu tối đa ban đầu, nhận 1 lớp \"Cập Bến\", tối đa 10 lớp, \"Cập Bến\" có thể nâng cao hiệu ứng của \"Neo Lại Nghỉ Ngơi\"."
  },
  RelicConfig_83606_Desc = {
    Text = "Giới hạn số lá trên tay +1. Khi bắt đầu lượt nếu không có \"Lựa Chọn của Người Dẫn Đường\", hãy đặt nó vào tay.\nMỗi khi thủ lĩnh mất 10% máu tối đa ban đầu, nhận 1 lớp \"Giăng Buồm\", tối đa 10 lớp, \"Giăng Buồm\" có thể nâng cao hiệu ứng của \"Khơi Buồm Ra Khơi\".\nMỗi khi bản thân mất 10% máu tối đa ban đầu, nhận 1 lớp \"Cập Bến\", tối đa 10 lớp, \"Cập Bến\" có thể nâng cao hiệu ứng của \"Neo Lại Nghỉ Ngơi\"."
  },
  RelicConfig_83606_Name = {
    Text = "Hướng dẫn của Erasmus"
  },
  RelicConfig_83606_StoryDesc = {
    Text = "Ánh sáng chớp lóe sẽ chỉ ra hướng đi."
  },
  RelicConfig_84112_BattleDesc = {
    Text = "Vào đầu lượt, Agrippa nhận được [Arg1] điên cuồng. Kỹ năng \"Sự ban tặng thiếu kiên nhẫn\" giúp giảm [Arg2] tiêu thụ sức tính toán trong lượt hiện tại, tối đa 1 lần mỗi lượt."
  },
  RelicConfig_84112_Desc = {
    Text = "Vào đầu lượt, Agrippa nhận được [Arg1] điên cuồng. Kỹ năng \"Sự ban tặng thiếu kiên nhẫn\" giúp giảm [Arg2] tiêu thụ sức tính toán trong lượt hiện tại, tối đa 1 lần mỗi lượt."
  },
  RelicConfig_84112_Name = {
    Text = "<OrangeQuality:chiều ảnh·Agrippa>"
  },
  RelicConfig_84113_BattleDesc = {
    Text = "Khi bắt đầu lượt, Carabao nhận được [Arg1] điên cuồng. Mỗi lần Carabao <FaxianKeywords:phát hiện> <DerivativeCardKeywords_152:\"phước lành\"> sẽ xuất hiện thêm 1 lựa chọn bổ sung, Bùng nổ gây ra lượng <Corrosion:Xói mòn> tương đương."
  },
  RelicConfig_84113_Desc = {
    Text = "Khi bắt đầu lượt, Carabao nhận được [Arg1] điên cuồng. Mỗi lần Carabao <FaxianKeywords:phát hiện> <DerivativeCardKeywords_152:\"phước lành\"> sẽ xuất hiện thêm 1 lựa chọn bổ sung, Bùng nổ gây ra lượng <Corrosion:Xói mòn> tương đương."
  },
  RelicConfig_84113_Name = {
    Text = "<OrangeQuality:Hình ảnh chiều·Carabao>"
  },
  RelicConfig_84114_BattleDesc = {
    Text = "Vào đầu lượt, Pickman nhận được [Arg1] cuồng khí. Mỗi khi nhận được 1 tầng \"Sáng tạo\", ngẫu nhiên giảm 1 điểm tiêu hao tính toán của 1 thẻ lệnh trong tay lượt này, khi Pickman tiêu hao \"Sáng tạo\" sẽ khiến tất cả thể tỉnh thức nhận thêm [Arg2] điểm cuồng khí."
  },
  RelicConfig_84114_Desc = {
    Text = "Vào đầu lượt, Pickman nhận được [Arg1] cuồng khí. Mỗi khi nhận được 1 tầng \"Sáng tạo\", ngẫu nhiên giảm 1 điểm tiêu hao tính toán của 1 thẻ lệnh trong tay lượt này, khi Pickman tiêu hao \"Sáng tạo\" sẽ khiến tất cả thể tỉnh thức nhận thêm [Arg2] điểm cuồng khí."
  },
  RelicConfig_84114_Name = {
    Text = "<OrangeQuality:Chiều Hình Ảnh · Pickman>"
  },
  RelicConfig_84116_BattleDesc = {
    Text = "Vào đầu lượt, Erika nhận được [Arg1] điên cuồng. Khi Erika sử dụng [Arg2] thẻ lệnh trong 1 lượt, cô ấy nhận được 2 điểm sức tính toán và tăng gấp đôi lực lượng và giữ mình của \"Điện Từ Bạo Phá\" trong trận chiến này."
  },
  RelicConfig_84116_Desc = {
    Text = "Vào đầu lượt, Erika nhận được [Arg1] điên cuồng. Khi Erika sử dụng [Arg2] thẻ lệnh trong 1 lượt, cô ấy nhận được 2 điểm sức tính toán và tăng gấp đôi lực lượng và giữ mình của \"Điện Từ Bạo Phá\" trong trận chiến này."
  },
  RelicConfig_84116_Name = {
    Text = "<OrangeQuality:chiều ảnh Erika>"
  },
  RelicConfig_84117_BattleDesc = {
    Text = "Tại đầu lượt, Đản Vọng · Murphy nhận được [Arg1] cuồng khí. \"Loa Yên Viên Vũ\" mỗi lần phát động thứ 3 sẽ kích hoạt 3 lần."
  },
  RelicConfig_84117_Desc = {
    Text = "Tại đầu lượt, Đản Vọng · Murphy nhận được [Arg1] cuồng khí. \"Loa Yên Viên Vũ\" mỗi lần phát động thứ 3 sẽ kích hoạt 3 lần."
  },
  RelicConfig_84117_Name = {
    Text = "<OrangeQuality:Hình ảnh chiều không gian·Đản Vọng·Mặc Phi>"
  },
  RelicConfig_84118_BattleDesc = {
    Text = "Vào đầu lượt, Kassia nhận được [Arg1] điên cuồng. Mỗi lần rút bài, Kassia nhận thêm [Arg2] điểm điên cuồng. Khi Kassia phát động cơn thịnh nộ, tất cả kẻ địch mất [Arg3] điểm lực lượng."
  },
  RelicConfig_84118_Desc = {
    Text = "Vào đầu lượt, Kassia nhận được [Arg1] điên cuồng. Mỗi lần rút bài, Kassia nhận thêm [Arg2] điểm điên cuồng. Khi Kassia phát động cơn thịnh nộ, tất cả kẻ địch mất [Arg3] điểm lực lượng."
  },
  RelicConfig_84118_Name = {
    Text = "<OrangeQuality:chiều·Kassia>"
  },
  RelicConfig_84119_BattleDesc = {
    Text = "Vào đầu lượt, Muphí nhận được [Arg1] điên cuồng. \"Đánh\" và \"Phòng thủ\" của Muphí có thể chuyển [Arg2]% \"Hiến tế\" thành thương tổn xúc tu tạm thời, nhưng chỉ có hiệu lực tối đa 1 lần mỗi lượt."
  },
  RelicConfig_84119_Desc = {
    Text = "Vào đầu lượt, Muphí nhận được [Arg1] điên cuồng. \"Đánh\" và \"Phòng thủ\" của Muphí có thể chuyển [Arg2]% \"Hiến tế\" thành thương tổn xúc tu tạm thời, nhưng chỉ có hiệu lực tối đa 1 lần mỗi lượt."
  },
  RelicConfig_84119_Name = {
    Text = "<OrangeQuality:hình ảnh chiều không gian·Muphí>"
  },
  RelicConfig_84121_BattleDesc = {
    Text = "Vào đầu lượt, Arachne nhận được [Arg1] điên cuồng. \"Đánh\" và \"Phòng thủ\" ngay lập tức phát động 1 lần truy kích \"Vô Tận Tuyến Lũ\", mỗi lượt tối đa kích hoạt 1 lần mỗi loại."
  },
  RelicConfig_84121_Desc = {
    Text = "Vào đầu lượt, Arachne nhận được [Arg1] điên cuồng. \"Đánh\" và \"Phòng thủ\" ngay lập tức phát động 1 lần truy kích \"Vô Tận Tuyến Lũ\", mỗi lượt tối đa kích hoạt 1 lần mỗi loại."
  },
  RelicConfig_84121_Name = {
    Text = "<OrangeQuality:Chiều Hình Ảnh · Arachne>"
  },
  RelicConfig_84122_BattleDesc = {
    Text = "Vào đầu lượt, tulô nhận được [Arg1] điên cuồng. Mức tiêu thụ điên cuồng của tulô giảm [Arg2], sau khi bùng nổ điên cuồng sẽ ngay lập tức tạo ra [Arg3] râu chạm tạm thời."
  },
  RelicConfig_84122_Desc = {
    Text = "Vào đầu lượt, tulô nhận được [Arg1] điên cuồng. Mức tiêu thụ điên cuồng của tulô giảm [Arg2], sau khi bùng nổ điên cuồng sẽ ngay lập tức tạo ra [Arg3] râu chạm tạm thời."
  },
  RelicConfig_84122_Name = {
    Text = "<OrangeQuality:ảnh chiều·tulô>"
  },
  RelicConfig_84123_BattleDesc = {
    Text = "Vào đầu lượt, Pollux nhận được [Arg1] điên cuồng. Vào đầu chiến đấu, nhận được 1 lá \"Thánh Tâm\", khi \"Thánh Tâm\" bị tiêu hao do đánh ra lần thứ 3, gây dễ thương cho tất cả kẻ địch và gây 2 lần sát thương."
  },
  RelicConfig_84123_Desc = {
    Text = "Vào đầu lượt, Pollux nhận được [Arg1] điên cuồng. Vào đầu chiến đấu, nhận được 1 lá \"Thánh Tâm\", khi \"Thánh Tâm\" bị tiêu hao do đánh ra lần thứ 3, gây dễ thương cho tất cả kẻ địch và gây 2 lần sát thương."
  },
  RelicConfig_84123_Name = {
    Text = "<OrangeQuality:Chiều Hình Ảnh · Pollux>"
  },
  RelicConfig_84124_BattleDesc = {
    Text = "Vào đầu lượt, Hamlin nhận được [Arg1] điên cuồng. \"Soul Overture\" sức tính toán tiêu thụ giảm [Arg2], số lần gây thương tăng [Arg3]."
  },
  RelicConfig_84124_Desc = {
    Text = "Vào đầu lượt, Hamlin nhận được [Arg1] điên cuồng. \"Soul Overture\" sức tính toán tiêu thụ giảm [Arg2], số lần gây thương tăng [Arg3]."
  },
  RelicConfig_84124_Name = {
    Text = "<OrangeQuality:hình ảnh chiều kích·Hamlin>"
  },
  RelicConfig_84125_BattleDesc = {
    Text = "Vào đầu lượt, Kêttigula nhận được [Arg1] điểm điên cuồng. Sau khi tích lũy tiêu thụ 10 lớp \"hoạt diệm\", lập tức rút 1 thẻ lệnh của Kêttigula và phú cho nó 3 lớp \"hoạt diệm\", lượt này không tích lũy lớp nữa."
  },
  RelicConfig_84125_Desc = {
    Text = "Vào đầu lượt, Kêttigula nhận được [Arg1] điểm điên cuồng. Sau khi tích lũy tiêu thụ 10 lớp \"hoạt diệm\", lập tức rút 1 thẻ lệnh của Kêttigula và phú cho nó 3 lớp \"hoạt diệm\", lượt này không tích lũy lớp nữa."
  },
  RelicConfig_84125_Name = {
    Text = "<OrangeQuality:Hình ảnh chiều kích·Kêttigula>"
  },
  RelicConfig_84126_BattleDesc = {
    Text = "Khi bắt đầu lượt, Castor nhận [Arg1] Aliemus. Khi bắt đầu trận chiến, đặt 2 lá \"lông đen\" vào tay, mỗi lần đầu tiên sử dụng \"lông đen\" mỗi lượt sẽ nhận [Arg2] điểm sức mạnh tạm thời."
  },
  RelicConfig_84126_Desc = {
    Text = "Khi bắt đầu lượt, Castor nhận [Arg1] Aliemus. Khi bắt đầu trận chiến, đặt 2 lá \"lông đen\" vào tay, mỗi lần đầu tiên sử dụng \"lông đen\" mỗi lượt sẽ nhận [Arg2] điểm sức mạnh tạm thời."
  },
  RelicConfig_84126_Name = {
    Text = "<OrangeQuality:Hình ảnh chiều không gian·Castor>"
  },
  RelicConfig_84127_BattleDesc = {
    Text = "Khi bắt đầu vòng, Kepersant nhận được [Arg1] Aliemus, nhận được 1 xúc tu tạm thời. Mỗi khi kích hoạt kháng cự chết, Kepersant nhận được [Arg2] điểm Aliemus, đặt 1 bài toán kiệt sức về 0 và thêm tiêu hao vào \"Sét trừng phạt\" vào tay của mình."
  },
  RelicConfig_84127_Desc = {
    Text = "Khi bắt đầu vòng, Kepersant nhận được [Arg1] Aliemus, nhận được 1 xúc tu tạm thời. Mỗi khi kích hoạt kháng cự chết, Kepersant nhận được [Arg2] điểm Aliemus, đặt 1 bài toán kiệt sức về 0 và thêm tiêu hao vào \"Sét trừng phạt\" vào tay của mình."
  },
  RelicConfig_84127_Name = {
    Text = "<OrangeQuality:Hình ảnh chiều không gian·Cooper Sant>"
  },
  RelicConfig_89252_BattleDesc = {
    Text = "Giới hạn Số học tăng 1, mỗi lượt Bốc thăm tăng 1, bắt đầu cuộc chiến nhận được [Arg1] \"Định mệnh lao tù\" đếm số.\nMỗi \"Định mệnh lao tù\" khiến tất cả Người đánh thức tạo ra Aliemus giảm [Arg2]%, mỗi lần phát động Tôn kính, giảm 1 \"Định mệnh lao tù\". Sau khi tất cả \"Định mệnh lao tù\" được loại bỏ, tất cả Người đánh thức nhận được [Arg3] điểm Aliemus, nhận \"Tinh thần bất khuất\": Tất cả Người đánh thức sinh ra Aliemus tăng [Arg4]%, có thể phát động Tôn kính 2 lần mỗi lượt."
  },
  RelicConfig_89252_Desc = {
    Text = "Giới hạn Số học tăng 1, mỗi lượt Bốc thăm tăng 1, bắt đầu cuộc chiến nhận được [Arg1] \"Định mệnh lao tù\" đếm số.\nMỗi \"Định mệnh lao tù\" khiến tất cả Người đánh thức tạo ra Aliemus giảm [Arg2]%, mỗi lần phát động Tôn kính, giảm 1 \"Định mệnh lao tù\". Sau khi tất cả \"Định mệnh lao tù\" được loại bỏ, tất cả Người đánh thức nhận được [Arg3] điểm Aliemus, nhận \"Tinh thần bất khuất\": Tất cả Người đánh thức sinh ra Aliemus tăng [Arg4]%, có thể phát động Tôn kính 2 lần mỗi lượt."
  },
  RelicConfig_89252_Name = {
    Text = "Lông vũ bị nguyền rủa"
  },
  RelicConfig_89252_StoryDesc = {
    Text = "Giờ đây, chiếc lông vũ này không còn có thể bay trên bầu trời nữa."
  },
  RelicConfig_89645_BattleDesc = {
    Text = "Giới hạn thẻ +2, sau khi phát phóng Aliemus kíp nổ, sát thương cuối cùng tạm thời tăng 10%.\nSau khi thẻ vào không gian Ultra, 1 phôi thai trong tay chuyển thành 「Thánh tử」.\nMỗi khi tạo ra 1 phôi thai, giảm 1 số học tiêu thụ của một thẻ ngẫu nhiên trong không gian Ultra."
  },
  RelicConfig_89645_Desc = {
    Text = "Giới hạn thẻ +2, sau khi phát phóng Aliemus kíp nổ, sát thương cuối cùng tạm thời tăng 10%.\nSau khi thẻ vào không gian Ultra, 1 phôi thai trong tay chuyển thành 「Thánh tử」.\nMỗi khi tạo ra 1 phôi thai, giảm 1 số học tiêu thụ của một thẻ ngẫu nhiên trong không gian Ultra."
  },
  RelicConfig_89645_Name = {
    Text = "Tác phẩm huyết thối siêu dây"
  },
  RelicConfig_89646_BattleDesc = {
    Text = "Nhận 250 điểm chìa khóa bạc năng lượng khi bắt đầu vòng.\nSau khi sử dụng chìa khóa bạc tỉnh thức, thêm 1 lá <DerivativeCardKeywords_129:「Chìa Khóa Bạc Vi Quang」> vào tay.\nMỗi khi bắt đầu vòng, khám phá 1 lá bài hỗ trợ của người đánh thức."
  },
  RelicConfig_89646_Desc = {
    Text = "Nhận 250 điểm chìa khóa bạc năng lượng khi bắt đầu vòng.\nSau khi sử dụng chìa khóa bạc tỉnh thức, thêm 1 lá <DerivativeCardKeywords_129:「Chìa Khóa Bạc Vi Quang」> vào tay.\nMỗi khi bắt đầu vòng, khám phá 1 lá bài hỗ trợ của người đánh thức."
  },
  RelicConfig_89646_Name = {
    Text = "Chế phẩm hợp nhất biến hóa"
  },
  RelicConfig_89647_BattleDesc = {
    Text = "Lần đầu tiên mỗi lượt, thẻ lệnh kéo thêm 1 lần hiệu quả.\nKhi sự hủy diệt được tạo ra, sinh ra 1 xúc tu.\nSau khi chuyển tiếp xúc tu thành hình thái \"Cơn thịnh nộ\", trong lượt này lần thẻ lệnh tiếp theo nhất định kích hoạt được hiệu quả nhảy và đặt 2 bản sao gốc vào không gian Ultra, gọi xa 3 lượt."
  },
  RelicConfig_89647_Desc = {
    Text = "Lần đầu tiên mỗi lượt, thẻ lệnh kéo thêm 1 lần hiệu quả.\nKhi sự hủy diệt được tạo ra, sinh ra 1 xúc tu.\nSau khi chuyển tiếp xúc tu thành hình thái \"Cơn thịnh nộ\", trong lượt này lần thẻ lệnh tiếp theo nhất định kích hoạt được hiệu quả nhảy và đặt 2 bản sao gốc vào không gian Ultra, gọi xa 3 lượt."
  },
  RelicConfig_89647_Name = {
    Text = "Tác phẩm siêu dây"
  },
  RelicConfig_89648_BattleDesc = {
    Text = "Tăng 200 điểm thông thạo cõi。\nKhi tiêu thụ Lò nung đỏ thẫm, tăng 15% sát thương xúc tu của mức tiêu thụ。\nMỗi khi xúc tu tấn công, tích lũy [Arg3] điểm Lò nung đỏ thẫm。"
  },
  RelicConfig_89648_Desc = {
    Text = "Tăng 200 điểm thông thạo cõi。\nKhi tiêu thụ Lò nung đỏ thẫm, tăng 15% sát thương xúc tu của mức tiêu thụ。\nMỗi khi xúc tu tấn công, tích lũy [Arg3] điểm Lò nung đỏ thẫm。"
  },
  RelicConfig_89648_Name = {
    Text = "Chế phẩm biển máu hư hại"
  },
  RelicConfig_91096_BattleDesc = {
    Text = "Khi vòng đấu bắt đầu, cả hai bên nhận được một lớp <Kuangre:Cuồng nhiệt>, mỗi lớp <Kuangre:Cuồng nhiệt> gây ra sát thương chủ động và sát thương xúc tu kèm thêm 10% sát thương bằng lượng <BleedingIconKeywords:Chảy máu>.\nMỗi lần gây 20% sát thương vào sinh mệnh của lãnh đạo sẽ làm tất cả người đánh thức nhận được 10 điên loạn.\nKhi trận chiến bắt đầu, rút <DerivativeCardKeywords_108:「Khuyến khích con cái」> và <DerivativeCardKeywords_109:「Bảo vệ con cái」> vào bộ bốc thăm."
  },
  RelicConfig_91096_Desc = {
    Text = "Khi vòng đấu bắt đầu, cả hai bên nhận được một lớp <Kuangre:Cuồng nhiệt>, mỗi lớp <Kuangre:Cuồng nhiệt> gây ra sát thương chủ động và sát thương xúc tu kèm thêm 10% sát thương bằng lượng <BleedingIconKeywords:Chảy máu>.\nMỗi lần gây 20% sát thương vào sinh mệnh của lãnh đạo sẽ làm tất cả người đánh thức nhận được 10 điên loạn.\nKhi trận chiến bắt đầu, rút <DerivativeCardKeywords_108:「Khuyến khích con cái」> và <DerivativeCardKeywords_109:「Bảo vệ con cái」> vào bộ bốc thăm."
  },
  RelicConfig_91096_Name = {
    Text = "Trứng nhợt nhạt"
  },
  RelicConfig_91096_StoryDesc = {
    Text = "Tâm trạng khi con trai bạch tạng sắp ra đời.\nCẩn thận, chúng sắp đến nơi."
  },
  RelicConfig_94695_BattleDesc = {
    Text = "Thể thức tỉnh bị giết sẽ tăng cường [Arg1] <StrongEffectKeywords:cường hiệu> cho các đồng minh khác, hiệu ứng này chỉ có thể kích hoạt một lần cho mỗi thể thức tỉnh."
  },
  RelicConfig_94695_Desc = {
    Text = "Thể thức tỉnh bị giết sẽ tăng cường [Arg1] <StrongEffectKeywords:cường hiệu> cho các đồng minh khác, hiệu ứng này chỉ có thể kích hoạt một lần cho mỗi thể thức tỉnh."
  },
  RelicConfig_94695_Name = {
    Text = "<OrangeQuality:Tàn dư đen bùng cháy>"
  },
  RelicConfig_94696_BattleDesc = {
    Text = "Sau khi trận chiến bắt đầu, đặt [Arg1] lá\"<PVPDerivativeCardKeywords_21:Vòng tay thấu xương>\" vào bài trên tay."
  },
  RelicConfig_94696_Desc = {
    Text = "Sau khi trận chiến bắt đầu, đặt [Arg1] lá\"<PVPDerivativeCardKeywords_21:Vòng tay thấu xương>\" vào bài trên tay."
  },
  RelicConfig_94696_Name = {
    Text = "<OrangeQuality:Ống tiêm hoạt động>"
  },
  RelicConfig_94697_BattleDesc = {
    Text = "Khi kết thúc vòng, bỏ tất cả thẻ trên tay và rút số thẻ tương ứng."
  },
  RelicConfig_94697_Desc = {
    Text = "Khi kết thúc vòng, bỏ tất cả thẻ trên tay và rút số thẻ tương ứng."
  },
  RelicConfig_94697_Name = {
    Text = "<OrangeQuality:Đồng hồ gió ma quái>"
  },
  RelicConfig_94698_BattleDesc = {
    Text = "Sau khi trận chiến bắt đầu, đặt vào chồng rút bài [Arg1] lá\"<PVPDerivativeCardKeywords_22:Hậu phát chế nhân>\" và\"<PVPDerivativeCardKeywords_23:Âm thanh trong não>\"."
  },
  RelicConfig_94698_Desc = {
    Text = "Sau khi trận chiến bắt đầu, đặt vào chồng rút bài [Arg1] lá\"<PVPDerivativeCardKeywords_22:Hậu phát chế nhân>\" và\"<PVPDerivativeCardKeywords_23:Âm thanh trong não>\"."
  },
  RelicConfig_94698_Name = {
    Text = "<OrangeQuality:Thứ của Alfonso>"
  },
  RelicConfig_95975_BattleDesc = {
    Text = "Giới hạn thẻ bài +1.\nVào đầu lượt, nếu không có <DerivativeCardKeywords_111:「Linh hồn Nuốt chửng」> sẽ đặt nó vào tay. Nếu 「Thỏa mãn」 đạt 10 thì sẽ chuyển hóa thành <DerivativeCardKeywords_112:「Ký ức Cộng hưởng」>."
  },
  RelicConfig_95975_Desc = {
    Text = "Giới hạn lá bài +1.\nNếu không có \"Nuốt chửng linh hồn\" vào đầu lượt, hãy đặt nó vào tay. Nếu \"Hài lòng\" đạt 10 thì biến nó thành \"Ký ức cộng hưởng\"."
  },
  RelicConfig_95975_Name = {
    Text = "Cốc Xương"
  },
  RelicConfig_95975_StoryDesc = {
    Text = "\"Trăng máu lên cao, các thây ma hẳn phải nâng ly uống chung.\""
  },
  RelicConfig_95976_BattleDesc = {
    Text = "Vào đầu mỗi lượt, Dullseine nhận [Arg1] Aliemus và [Arg2] điểm Sức mạnh. Khi Dullseine tiêu thụ \"Di vật\", nhận được sức mạnh tạm thời 20% Sức mạnh vĩnh viễn."
  },
  RelicConfig_95976_Desc = {
    Text = "Vào đầu mỗi lượt, Dullseine nhận [Arg1] Aliemus và [Arg2] điểm Sức mạnh. Khi Dullseine tiêu thụ \"Di vật\", nhận được sức mạnh tạm thời 20% Sức mạnh vĩnh viễn."
  },
  RelicConfig_95976_Name = {
    Text = "<OrangeQuality:Hình ảnh không gian · Tulu Saiyin>"
  },
  RelicConfig_96652_BattleDesc = {
    Text = "Vào đầu lượt, khiến 1 thẻ lệnh trong tay nhận được \"<BurningKeywords2:Đốt cháy>\" và tích lũy 1 lớp \"<Heat:Ngọn Lửa Thâm Ám>\". Khi \"<Heat:Ngọn Lửa Thâm Ám>\"đạt 3 lớp, đặt 1 lá \"<Overload:Bạo Viêm Vô Tận>\" vào tay."
  },
  RelicConfig_96652_Desc = {
    Text = "Vào đầu lượt, khiến 1 thẻ lệnh trong tay nhận được \"<BurningKeywords2:Đốt cháy>\" và tích lũy 1 lớp \"<Heat:Ngọn Lửa Thâm Ám>\". Khi \"<Heat:Ngọn Lửa Thâm Ám>\"đạt 3 lớp, đặt 1 lá \"<Overload:Bạo Viêm Vô Tận>\" vào tay."
  },
  RelicConfig_96652_Name = {
    Text = "Ngọn Lửa Tối Tăm"
  },
  RelicConfig_96652_StoryDesc = {
    Text = "Ngọn lửa đen sẽ thực hiện ý chí của cô, thiêu rụi mọi thứ đến tận cùng."
  },
  RelicConfig_97344_BattleDesc = {
    Text = "Khi mất lá bài cuối cùng trong tay, rút 2 lá bài và nhận [Arg1] điểm năng lượng chìa khóa bạc. Mỗi khi khởi động lại bộ bài, thiệt hại xúc tu tăng [Arg2] điểm."
  },
  RelicConfig_97344_Desc = {
    Text = "Khi mất lá bài cuối cùng trong tay, rút 2 lá bài và nhận [Arg1] điểm năng lượng chìa khóa bạc. Mỗi khi khởi động lại bộ bài, thiệt hại xúc tu tăng [Arg2] điểm."
  },
  RelicConfig_97344_Name = {
    Text = "Chiếc cúp vô địch Mythag"
  },
  RelicConfig_97344_StoryDesc = {
    Text = "Hôm nay, chúng ta sẽ quên đi nỗi sợ hãi, quên đi nỗi đau thương, chỉ tận hưởng cuộc cuồng vui."
  },
  RelicConfig_97345_BattleDesc = {
    Text = "Mỗi khi đánh ra 3 thẻ lệnh, nhận 1 điểm số học và rút 1 thẻ. Mỗi lần gây ra sát thương chủ động thì cuối cùng sát thương tạm thời tăng 2%, tối đa 50%."
  },
  RelicConfig_97345_Desc = {
    Text = "Mỗi khi đánh ra 3 thẻ lệnh, nhận 1 điểm số học và rút 1 thẻ. Mỗi lần gây ra sát thương chủ động thì cuối cùng sát thương tạm thời tăng 2%, tối đa 50%."
  },
  RelicConfig_97345_Name = {
    Text = "Chiếc cúp vô địch Mythag"
  },
  RelicConfig_97345_StoryDesc = {
    Text = "Hôm nay, chúng ta sẽ quên đi nỗi sợ hãi, quên đi nỗi đau thương, chỉ tận hưởng cuộc cuồng vui."
  },
  RelicConfig_97346_BattleDesc = {
    Text = "Tỷ lệ chí mạng của tất cả người đánh thức tăng 30%, khi bắt đầu các lượt số lẻ, tất cả kẻ thù mất 25% hiện tại cuộc sống. Khi tỷ lệ cuộc sống bản thân thấp hơn kẻ thù, thiệt hại cuối cùng gây ra tăng 50%; khi tỷ lệ cuộc sống bản thân cao hơn kẻ thù, sau khi phát động Aliemus bùng nổ, nhận được 35 điểm Aliemus."
  },
  RelicConfig_97346_Desc = {
    Text = "Tỷ lệ chí mạng của tất cả người đánh thức tăng 30%, khi bắt đầu các lượt số lẻ, tất cả kẻ thù mất 25% hiện tại cuộc sống. Khi tỷ lệ cuộc sống bản thân thấp hơn kẻ thù, thiệt hại cuối cùng gây ra tăng 50%; khi tỷ lệ cuộc sống bản thân cao hơn kẻ thù, sau khi phát động Aliemus bùng nổ, nhận được 35 điểm Aliemus."
  },
  RelicConfig_97346_Name = {
    Text = "Chiếc cúp vô địch Mythag"
  },
  RelicConfig_97346_StoryDesc = {
    Text = "Hôm nay, chúng ta sẽ quên đi nỗi sợ hãi, quên đi nỗi đau thương, chỉ tận hưởng cuộc cuồng vui."
  },
  RelicConfig_97347_BattleDesc = {
    Text = "Tăng số học tối đa 2 điểm, số học chưa kiệt sức có thể giữ đến lượt tiếp theo，nếu giữ quá 2 điểm số học, khi bắt đầu lượt tiếp theo tất cả người đánh thức nhận được 20 điểm Aliemus; nếu giữ quá 4 điểm số học, thiệt hại cơ bản gây ra trong lượt tiếp theo tăng 100%."
  },
  RelicConfig_97347_Desc = {
    Text = "Tăng số học tối đa 2 điểm, số học chưa kiệt sức có thể giữ đến lượt tiếp theo，nếu giữ quá 2 điểm số học, khi bắt đầu lượt tiếp theo tất cả người đánh thức nhận được 20 điểm Aliemus; nếu giữ quá 4 điểm số học, thiệt hại cơ bản gây ra trong lượt tiếp theo tăng 100%."
  },
  RelicConfig_97347_Name = {
    Text = "Chiếc cúp vô địch Mythag"
  },
  RelicConfig_97347_StoryDesc = {
    Text = "Hôm nay, chúng ta sẽ quên đi nỗi sợ hãi, quên đi nỗi đau thương, chỉ tận hưởng cuộc cuồng vui."
  },
  RelicConfig_98274_BattleDesc = {
    Text = "Giới hạn bài trên tay +1, khi bắt đầu chiến đấu nhận được \"<DerivativeCardKeywords_116:Bảng Pha Màu>\".\nĐầu lượt nhận được 1 \"<PrimaryColor:Nguyên Sắc>\" và ngẫu nhiên khiến 2 lá bài chỉ lệnh nhận được \"<ColorInkKeywords:Nhận Thức Sai Lệch>\", sau khi đánh ra lá bài \"<ColorInkKeywords:Nhận Thức Sai Lệch>\" sẽ nhận được 1 \"<PrimaryColor:Nguyên Sắc>\" theo thứ tự.\n \"<PrimaryColor:Nguyên Sắc>\" sau khi đánh ra sẽ được ghi nhận lên \"<DerivativeCardKeywords_116:Bảng Pha Màu>\", nếu trên \"<DerivativeCardKeywords_116:Bảng Pha Màu>\" tồn tại 2 loại \"<PrimaryColor:Nguyên Sắc>\" khác nhau, sẽ mang lại hiệu ứng tăng cường liên tục.\nNếu trên Bảng Pha Màu tồn tại 3 loại \"<PrimaryColor:Nguyên Sắc>\" khác nhau, lập tức khiến tất cả kẻ địch mất 5% sinh mệnh tối đa, và xóa sạch \"<DerivativeCardKeywords_116:Bảng Pha Màu>\"."
  },
  RelicConfig_98274_Desc = {
    Text = "Giới hạn bài trên tay +1, khi bắt đầu chiến đấu nhận được \"<DerivativeCardKeywords_116:Bảng Pha Màu>\".\nĐầu lượt nhận được 1 \"<PrimaryColor:Nguyên Sắc>\" và ngẫu nhiên khiến 2 lá bài chỉ lệnh nhận được \"<ColorInkKeywords:Nhận Thức Sai Lệch>\", sau khi đánh ra lá bài \"<ColorInkKeywords:Nhận Thức Sai Lệch>\" sẽ nhận được 1 \"<PrimaryColor:Nguyên Sắc>\" theo thứ tự.\n \"<PrimaryColor:Nguyên Sắc>\" sau khi đánh ra sẽ được ghi nhận lên \"<DerivativeCardKeywords_116:Bảng Pha Màu>\", nếu trên \"<DerivativeCardKeywords_116:Bảng Pha Màu>\" tồn tại 2 loại \"<PrimaryColor:Nguyên Sắc>\" khác nhau, sẽ mang lại hiệu ứng tăng cường liên tục.\nNếu trên Bảng Pha Màu tồn tại 3 loại \"<PrimaryColor:Nguyên Sắc>\" khác nhau, lập tức khiến tất cả kẻ địch mất 5% sinh mệnh tối đa, và xóa sạch \"<DerivativeCardKeywords_116:Bảng Pha Màu>\"."
  },
  RelicConfig_98274_Name = {
    Text = "Bảng màu dị thường"
  },
  RelicConfig_98274_StoryDesc = {
    Text = "Trong ảo giác, chúng ta sẽ chứng kiến sự ra đời của \"nghệ thuật\"."
  },
  RelicConfig_98367_BattleDesc = {
    Text = "Hiệu suất cơ bản của hồi phục cuộc sống và khiên mà người đánh thức gây ra tăng [Arg1]%."
  },
  RelicConfig_98367_Desc = {
    Text = "Hiệu suất cơ bản của hồi phục cuộc sống và khiên mà người đánh thức gây ra tăng [Arg1]%."
  },
  RelicConfig_98367_Name = {
    Text = "<WhiteQuality:Da Rắn Kỳ Dị>"
  },
  RelicConfig_98367_StoryDesc = {
    Text = "Hy sinh bản thân để tái sinh từ sự thay đổi."
  },
  RelicConfig_98368_BattleDesc = {
    Text = "Khi bắt đầu trận chiến, nhận được [Arg1]% mạnh sát thương. Mỗi khi chơi một thẻ lệnh từ một người đánh thức khác, nhận thêm [Arg1]% mạnh sát thương tạm thời."
  },
  RelicConfig_98368_Desc = {
    Text = "Khi bắt đầu trận chiến, nhận được [Arg1]% mạnh sát thương. Mỗi khi chơi một thẻ lệnh từ một người đánh thức khác, nhận thêm [Arg1]% mạnh sát thương tạm thời."
  },
  RelicConfig_98368_Name = {
    Text = "<OrangeQuality:Kaleidoscope+>"
  },
  RelicConfig_98368_StoryDesc = {
    Text = "Những suy nghĩ và điều nhìn thấy đều là ảo ảnh."
  },
  RelicConfig_98369_BattleDesc = {
    Text = "Sau khi sử dụng Silver key awaken, làm cho [Arg1] thẻ có số học cao nhất trong tay được giữ lại và chuẩn bị trước khi lần tiếp theo đánh ra, nhận [Arg2] điểm S-energy."
  },
  RelicConfig_98369_Desc = {
    Text = "Sau khi sử dụng Silver key awaken, làm cho [Arg1] thẻ có số học cao nhất trong tay được giữ lại và chuẩn bị trước khi lần tiếp theo đánh ra, nhận [Arg2] điểm S-energy."
  },
  RelicConfig_98369_Name = {
    Text = "<WhiteQuality:bộ sưu tập tem thư từ xứ lạ>"
  },
  RelicConfig_98369_StoryDesc = {
    Text = "Niềm nhớ được định lượng."
  },
  RelicConfig_98370_BattleDesc = {
    Text = "Khi trận chiến bắt đầu, gây [Arg1] tầng điểm yếu và dễ tổn thương cho tất cả kẻ địch. Sau \"Hủy diệt\" cũng sẽ kích hoạt hiệu ứng này, nhưng có thời gian hồi là 3 lượt."
  },
  RelicConfig_98370_Desc = {
    Text = "Khi trận chiến bắt đầu gây ra cho tất cả kẻ thù [Arg1] lớp <WeaknessIconKeywords:suy nhược> và <VulnerabilityIconKeywords:trọng thương>. Kỹ năng \"Hủy diệt\" sẽ kích hoạt hiệu ứng này sau, nhưng có thời gian hồi chiêu 3 vòng."
  },
  RelicConfig_98370_Name = {
    Text = "<WhiteQuality:Thiết bị lệch không gian>"
  },
  RelicConfig_98370_StoryDesc = {
    Text = "Nhảy vào hư không."
  },
  RelicConfig_98371_BattleDesc = {
    Text = "Trước khi kết thúc lượt, mỗi thẻ lệnh trên tay sẽ cung cấp [Arg1] điểm Aliemus cho Người đánh thức tương ứng."
  },
  RelicConfig_98371_Desc = {
    Text = "Trước khi kết thúc lượt, mỗi thẻ lệnh trên tay sẽ cung cấp [Arg1] điểm Aliemus cho Người đánh thức tương ứng."
  },
  RelicConfig_98371_Name = {
    Text = "<WhiteQuality:Cân Bằng Mất Thăng Bằng>"
  },
  RelicConfig_98371_StoryDesc = {
    Text = "Không còn tượng trưng cho công bằng."
  },
  RelicConfig_98372_BattleDesc = {
    Text = "Khi kết thúc lượt, nếu năng lượng chìa khóa bạc đã đầy, tiêu hao [Arg1] điểm năng lượng chìa khóa bạc để đặt một lá <DerivativeCardKeywords_129:「Ánh sáng tinh tế của chìa khóa bạc」> vào tay."
  },
  RelicConfig_98372_Desc = {
    Text = "Khi kết thúc lượt, nếu năng lượng chìa khóa bạc đã đầy, tiêu hao [Arg1] điểm năng lượng chìa khóa bạc để đặt một lá <DerivativeCardKeywords_129:「Ánh sáng tinh tế của chìa khóa bạc」> vào tay."
  },
  RelicConfig_98372_Name = {
    Text = "<WhiteQuality:Trong Ánh Hoàng Hôn>"
  },
  RelicConfig_98372_StoryDesc = {
    Text = "Hãy cùng chụp ảnh đi! Trải nghiệm cảm giác đau đớn thực sự một lần."
  },
  RelicConfig_98373_BattleDesc = {
    Text = "Giải phóng \"bùng nổ điên loạn\" nhận được [Arg1] năng lượng chìa khóa bạc."
  },
  RelicConfig_98373_Desc = {
    Text = "Giải phóng \"bùng nổ điên loạn\" nhận được [Arg1] năng lượng chìa khóa bạc."
  },
  RelicConfig_98373_Name = {
    Text = "<OrangeQuality:Khoảnh khắc tuyệt đẹp+>"
  },
  RelicConfig_98373_StoryDesc = {
    Text = "Lưu giữ vẻ đẹp của phút chốc mãi mãi."
  },
  RelicConfig_98374_BattleDesc = {
    Text = "Sau khi phát động \"Nhóm người\" lần đầu mỗi lượt, áp dụng [Arg1] tầng độc dược cho tất cả kẻ địch, và nhận [Arg2] tầng phản kích."
  },
  RelicConfig_98374_Desc = {
    Text = "Sau khi chơi \"mật lệnh\"đầu tiên trong mỗi lượt áp dụng [Arg1] lớp <IntoxicationIconKeywords:ngộ độc> cho tất cả kẻ thù, và nhận được [Arg2] lớp <RetaliateIconKeywords:quầy>."
  },
  RelicConfig_98374_Name = {
    Text = "<OrangeQuality:Đèn ước nguyện của tiên tri+>"
  },
  RelicConfig_98374_StoryDesc = {
    Text = "Thực hiện mong muốn của bạn."
  },
  RelicConfig_98375_BattleDesc = {
    Text = "Khi kết thúc lượt, nếu năng lượng chìa khóa bạc đã đầy, tiêu hao [Arg1] điểm năng lượng chìa khóa bạc để đặt một lá <DerivativeCardKeywords_67:「Ánh Sáng Bạc Khóa」> vào tay."
  },
  RelicConfig_98375_Desc = {
    Text = "Khi kết thúc lượt, nếu năng lượng chìa khóa bạc đã đầy, tiêu hao [Arg1] điểm năng lượng chìa khóa bạc để đặt một lá <DerivativeCardKeywords_67:「Ánh Sáng Bạc Khóa」> vào tay."
  },
  RelicConfig_98375_Name = {
    Text = "<OrangeQuality:Trong ánh chiều+>"
  },
  RelicConfig_98375_StoryDesc = {
    Text = "Hãy cùng chụp ảnh đi! Trải nghiệm cảm giác đau đớn thực sự một lần."
  },
  RelicConfig_98376_BattleDesc = {
    Text = "Hiệu suất cơ bản của hồi phục cuộc sống và khiên mà người đánh thức gây ra tăng [Arg1]%."
  },
  RelicConfig_98376_Desc = {
    Text = "Hiệu suất cơ bản của hồi phục cuộc sống và khiên mà người đánh thức gây ra tăng [Arg1]%."
  },
  RelicConfig_98376_Name = {
    Text = "<OrangeQuality:Vảy rắn quái+>"
  },
  RelicConfig_98376_StoryDesc = {
    Text = "Hy sinh bản thân để tái sinh từ sự thay đổi."
  },
  RelicConfig_98377_BattleDesc = {
    Text = "Mỗi thẻ khi vào không gian ultra, rút [Arg1] thẻ lệnh thuộc thẻ này từ bốc thăm, nếu không thể rút, thì nhận khả năng tính tương tự. Mỗi lượt tối đa kích hoạt 2 lần."
  },
  RelicConfig_98377_Desc = {
    Text = "Mỗi thẻ khi vào không gian ultra, rút [Arg1] thẻ lệnh thuộc thẻ này từ bốc thăm, nếu không thể rút, thì nhận khả năng tính tương tự. Mỗi lượt tối đa kích hoạt 2 lần."
  },
  RelicConfig_98377_Name = {
    Text = "<WhiteQuality:lăng kính>"
  },
  RelicConfig_98377_StoryDesc = {
    Text = "\"Ánh sáng được tạo thành từ bảy màu sắc.\""
  },
  RelicConfig_98378_BattleDesc = {
    Text = "Khi trận chiến bắt đầu, nhận [Arg1]% sát thương mạnh. Sau khi nhận sát thương, nhận [Arg2] quầy, tối đa kích hoạt 3 lần mỗi lượt."
  },
  RelicConfig_98378_Desc = {
    Text = "Khi trận chiến bắt đầu nhận [Arg1]% khuếch đại sát thương. Sau khi nhận sát thương sẽ nhận được [Arg2] <RetaliateIconKeywords:phản kích>, tối đa kích hoạt 3 lần mỗi vòng."
  },
  RelicConfig_98378_Name = {
    Text = "<OrangeQuality:Lối thoát an toàn+>"
  },
  RelicConfig_98378_StoryDesc = {
    Text = "Thấy rằng, anh ta cũng không thể thoát ra được."
  },
  RelicConfig_98379_BattleDesc = {
    Text = "Sau khi gây sát thương chủ động hoặc xúc tu, tăng sát thương xúc tu mục tiêu nhận trong lượt này [Arg1]%, mỗi lượt tối đa kích hoạt 20 lần."
  },
  RelicConfig_98379_Desc = {
    Text = "Sau khi gây sát thương chủ động hoặc xúc tu, tăng sát thương xúc tu mục tiêu nhận trong lượt này [Arg1]%, mỗi lượt tối đa kích hoạt 20 lần."
  },
  RelicConfig_98379_Name = {
    Text = "<WhiteQuality:mũ lặn>"
  },
  RelicConfig_98379_StoryDesc = {
    Text = "Giấc mơ là sao trời và đại dương!"
  },
  RelicConfig_98380_BattleDesc = {
    Text = "Khi trận chiến bắt đầu và sau khi kích hoạt kháng cự, nhận [Arg1] điểm S-energy."
  },
  RelicConfig_98380_Desc = {
    Text = "Khi trận chiến bắt đầu và sau khi kích hoạt kháng cự, nhận [Arg1] điểm S-energy."
  },
  RelicConfig_98380_Name = {
    Text = "<WhiteQuality:Cống phẩm trong quá khứ>"
  },
  RelicConfig_98380_StoryDesc = {
    Text = "Đồ vật đã từng được dâng lên."
  },
  RelicConfig_98381_BattleDesc = {
    Text = "Sau khi Đánh thức chìa khóa bạc, hồi phục [Heal:Arg1] sinh lực và nhận được [Arg2] năng lượng chìa khóa bạc."
  },
  RelicConfig_98381_Desc = {
    Text = "Sau khi Đánh thức chìa khóa bạc, hồi phục [Heal:Arg1] sinh lực và nhận được [Arg2] năng lượng chìa khóa bạc."
  },
  RelicConfig_98381_Name = {
    Text = "<WhiteQuality:ô dù du hành>"
  },
  RelicConfig_98381_StoryDesc = {
    Text = "Phát triển rực rỡ trong vùng đất không ánh sáng."
  },
  RelicConfig_98382_BattleDesc = {
    Text = "Sau khi trận chiến bắt đầu, nhận được [Arg1] <ProficientInRealmsIconKeywords:giỏi trong cõi>. Vào đầu vòng lẻ, rút [Arg2] thẻ bài, vào đầu vòng chẵn, nhận [Arg2] điểm tính toán."
  },
  RelicConfig_98382_Desc = {
    Text = "Sau khi trận chiến bắt đầu, nhận được [Arg1] <ProficientInRealmsIconKeywords:giỏi trong cõi>. Vào đầu vòng lẻ, rút [Arg2] thẻ bài, vào đầu vòng chẵn, nhận [Arg2] điểm tính toán."
  },
  RelicConfig_98382_Name = {
    Text = "<OrangeQuality:đĩa quay nhật nguyệt>+"
  },
  RelicConfig_98382_StoryDesc = {
    Text = "Đoán xem, là đen hay trắng?"
  },
  RelicConfig_98383_BattleDesc = {
    Text = "Lần đầu mỗi lượt \"Nhóm người\" kích hoạt tất cả xúc tu tấn công [Arg1] lần kẻ thù, gây 50% sát thương."
  },
  RelicConfig_98383_Desc = {
    Text = "Lần đầu mỗi lượt \"Nhóm người\" kích hoạt tất cả xúc tu tấn công [Arg1] lần kẻ thù, gây 50% sát thương."
  },
  RelicConfig_98383_Name = {
    Text = "<OrangeQuality:Ốc vàng nhỏ+>"
  },
  RelicConfig_98383_StoryDesc = {
    Text = "Con ốc vàng nhỏ này xuất thân cao quý, có nguồn hoàn hảo, không thể chê vào đâu được."
  },
  RelicConfig_98384_BattleDesc = {
    Text = "Sát thương cơ bản gây ra bởi tất cả người đánh thức tăng [Arg1]%. Trước khi tôn kính cuồng bộc phát, sát thương cơ bản làm cho người đánh thức bộc phát tôn kính tạm thời tăng [Arg2]%."
  },
  RelicConfig_98384_Desc = {
    Text = "Sát thương cơ bản gây ra bởi tất cả người đánh thức tăng [Arg1]%. Trước khi tôn kính cuồng bộc phát, sát thương cơ bản làm cho người đánh thức bộc phát tôn kính tạm thời tăng [Arg2]%."
  },
  RelicConfig_98384_Name = {
    Text = "<WhiteQuality:Máu của những kẻ bị lãng quên>"
  },
  RelicConfig_98384_StoryDesc = {
    Text = "Ngày càng tan chảy."
  },
  RelicConfig_98385_BattleDesc = {
    Text = "Sau khi phát động \"Nhóm người\" lần đầu mỗi lượt, áp dụng [Arg1] tầng độc dược cho tất cả kẻ địch, và nhận [Arg2] tầng phản kích."
  },
  RelicConfig_98385_Desc = {
    Text = "Sau khi chơi \"mật lệnh\"đầu tiên trong mỗi lượt áp dụng [Arg1] lớp <IntoxicationIconKeywords:ngộ độc> cho tất cả kẻ thù, và nhận được [Arg2] lớp <RetaliateIconKeywords:quầy>."
  },
  RelicConfig_98385_Name = {
    Text = "<WhiteQuality:Đèn Nguyện Ước của Tiên Tri>"
  },
  RelicConfig_98385_StoryDesc = {
    Text = "Thực hiện mong muốn của bạn."
  },
  RelicConfig_98386_BattleDesc = {
    Text = "Vào đầu lượt, nếu sức sống dưới 50%, hiệu ứng tăng sát thương tạm thời +[Arg1]%. Nếu sức sống dưới 25%, rút thêm [Arg2] lá bài và nhận [Arg2] sức tính toán."
  },
  RelicConfig_98386_Desc = {
    Text = "Vào đầu lượt, nếu sức sống dưới 50%, hiệu ứng tăng sát thương tạm thời +[Arg1]%. Nếu sức sống dưới 25%, rút thêm [Arg2] lá bài và nhận [Arg2] sức tính toán."
  },
  RelicConfig_98386_Name = {
    Text = "<WhiteQuality:vali của bác sĩ>"
  },
  RelicConfig_98386_StoryDesc = {
    Text = "Hộp vali tượng trưng cho thân phận bác sĩ, rất nặng.\nMở nó ra, chưa chắc đã phải là bác sĩ thật sự."
  },
  RelicConfig_98387_BattleDesc = {
    Text = "Khi trận chiến bắt đầu, gây [Arg1] tầng điểm yếu và dễ tổn thương cho tất cả kẻ địch. Sau \"Hủy diệt\" cũng sẽ kích hoạt hiệu ứng này, nhưng có thời gian hồi là 3 lượt."
  },
  RelicConfig_98387_Desc = {
    Text = "Khi trận chiến bắt đầu gây ra cho tất cả kẻ thù [Arg1] lớp <WeaknessIconKeywords:suy nhược> và <VulnerabilityIconKeywords:trọng thương>. Kỹ năng \"Hủy diệt\" sẽ kích hoạt hiệu ứng này sau, nhưng có thời gian hồi chiêu 3 vòng."
  },
  RelicConfig_98387_Name = {
    Text = "<OrangeQuality:Thiết bị lệch không gian+>"
  },
  RelicConfig_98387_StoryDesc = {
    Text = "Nhảy vào hư không."
  },
  RelicConfig_98388_BattleDesc = {
    Text = "Khi trận chiến bắt đầu và sau khi kích hoạt kháng cự, nhận [Arg1] điểm S-energy."
  },
  RelicConfig_98388_Desc = {
    Text = "Khi trận chiến bắt đầu và sau khi kích hoạt kháng cự, nhận [Arg1] điểm S-energy."
  },
  RelicConfig_98388_Name = {
    Text = "<OrangeQuality:Quà cống nạp trong quá khứ+>"
  },
  RelicConfig_98388_StoryDesc = {
    Text = "Đồ vật đã từng được dâng lên."
  },
  RelicConfig_98389_BattleDesc = {
    Text = "Sau khi trận chiến bắt đầu, nhận được [Arg1] <ProficientInRealmsIconKeywords:giỏi trong cõi>. Vào đầu vòng lẻ, rút [Arg2] thẻ bài, vào đầu vòng chẵn, nhận [Arg2] điểm tính toán."
  },
  RelicConfig_98389_Desc = {
    Text = "Sau khi trận chiến bắt đầu, nhận được [Arg1] <ProficientInRealmsIconKeywords:giỏi trong cõi>. Vào đầu vòng lẻ, rút [Arg2] thẻ bài, vào đầu vòng chẵn, nhận [Arg2] điểm tính toán."
  },
  RelicConfig_98389_Name = {
    Text = "<WhiteQuality:Bánh Xe Ngày Đêm>"
  },
  RelicConfig_98389_StoryDesc = {
    Text = "Đoán xem, là đen hay trắng?"
  },
  RelicConfig_98390_BattleDesc = {
    Text = "Mỗi khi rút một thẻ hay bỏ một thẻ, nhận [Arg1] sức mạnh tạm thời, mỗi lượt tối đa kích hoạt 15 lần."
  },
  RelicConfig_98390_Desc = {
    Text = "Mỗi lần rút một lá bài hoặc bỏ một lá bài nhận được [Arg1] tạm thời <PowerIconKeywords:sức mạnh>, mỗi lượt tối đa kích hoạt 15 lần."
  },
  RelicConfig_98390_Name = {
    Text = "<WhiteQuality:Giai Điệu Câm Lặng>"
  },
  RelicConfig_98390_StoryDesc = {
    Text = "Đàn violin của nghệ sĩ violin nổi tiếng Eric Eichstein. \n Hiện nay, nó đã vĩnh viễn lặng im."
  },
  RelicConfig_98391_BattleDesc = {
    Text = "Lần đầu tiên \"Nhóm người\" mỗi lượt khiến mạnh sát thương tạm thời +[Arg2]%, cuộc sống càng thấp hiệu quả càng mạnh."
  },
  RelicConfig_98391_Desc = {
    Text = "Lần đầu tiên \"Nhóm người\" mỗi lượt khiến mạnh sát thương tạm thời +[Arg1]%, cuộc sống càng thấp hiệu quả càng mạnh."
  },
  RelicConfig_98391_Name = {
    Text = "<WhiteQuality:linh dược Hà Phúc>"
  },
  RelicConfig_98391_StoryDesc = {
    Text = "Thuốc có thành phần không rõ. \nNgười ta nói rằng nghệ sĩ violin nổi tiếng Eric rất ưa chuộng."
  },
  RelicConfig_98392_BattleDesc = {
    Text = "Lần đầu tiên \"Nhóm người\" mỗi lượt khiến mạnh sát thương tạm thời +[Arg2]%, cuộc sống càng thấp hiệu quả càng mạnh."
  },
  RelicConfig_98392_Desc = {
    Text = "Lần đầu tiên \"Nhóm người\" mỗi lượt khiến mạnh sát thương tạm thời +[Arg1]%, cuộc sống càng thấp hiệu quả càng mạnh."
  },
  RelicConfig_98392_Name = {
    Text = "<OrangeQuality:Thuốc thần Haford+>"
  },
  RelicConfig_98392_StoryDesc = {
    Text = "Thuốc có thành phần không rõ. \nNgười ta nói rằng nghệ sĩ violin nổi tiếng Eric rất ưa chuộng."
  },
  RelicConfig_98393_BattleDesc = {
    Text = "Mỗi lần đầu mỗi lượt của người đánh thức, thẻ lệnh nhận [Arg1] điểm chìa khóa bạc năng lượng."
  },
  RelicConfig_98393_Desc = {
    Text = "Mỗi lần đầu mỗi lượt của người đánh thức, thẻ lệnh nhận [Arg1] điểm chìa khóa bạc năng lượng."
  },
  RelicConfig_98393_Name = {
    Text = "<WhiteQuality:lời lẽ sắc bén>"
  },
  RelicConfig_98393_StoryDesc = {
    Text = "Không chỉ thương nhân, mà còn có những tín đồ mộ đạo khéo léo trong giao tiếp và tài ăn nói."
  },
  RelicConfig_98394_BattleDesc = {
    Text = "Lần đầu mỗi lượt \"Nhóm người\" hoàn trả [Arg1]% chìa khóa bạc năng lượng tiêu hết."
  },
  RelicConfig_98394_Desc = {
    Text = "Lần đầu mỗi lượt \"Nhóm người\" hoàn trả [Arg1]% chìa khóa bạc năng lượng tiêu hết."
  },
  RelicConfig_98394_Name = {
    Text = "<WhiteQuality:chân thỏ may mắn>"
  },
  RelicConfig_98394_StoryDesc = {
    Text = "Với những chú thỏ, điều này quả thật chẳng may mắn chút nào."
  },
  RelicConfig_98395_BattleDesc = {
    Text = "Khi trận chiến bắt đầu, nhận [Arg1]% sát thương mạnh. Gây sát thương chủ động sau đó đối với tất cả kẻ địch gây [Arg2] điểm độc dược, tối đa kích hoạt 5 lần mỗi lượt."
  },
  RelicConfig_98395_Desc = {
    Text = "Khi trận chiến bắt đầu nhận [Arg1]% khuếch đại sát thương. Sau khi gây sát thương chủ động sẽ gây ra <IntoxicationIconKeywords:ngộ độc> cho tất cả kẻ thù [Arg2], tối đa kích hoạt 5 lần mỗi vòng."
  },
  RelicConfig_98395_Name = {
    Text = "<OrangeQuality:quyền trượng linh mục+>"
  },
  RelicConfig_98395_StoryDesc = {
    Text = "Sự sùng kính không được phép"
  },
  RelicConfig_98396_BattleDesc = {
    Text = "Khi bắt đầu trận chiến, nhận được [Arg1]% mạnh sát thương. Mỗi khi chơi một thẻ lệnh từ một người đánh thức khác, nhận thêm [Arg1]% mạnh sát thương tạm thời."
  },
  RelicConfig_98396_Desc = {
    Text = "Khi bắt đầu trận chiến, nhận được [Arg1]% mạnh sát thương. Mỗi khi chơi một thẻ lệnh từ một người đánh thức khác, nhận thêm [Arg1]% mạnh sát thương tạm thời."
  },
  RelicConfig_98396_Name = {
    Text = "<WhiteQuality:vạn hoa kính>"
  },
  RelicConfig_98396_StoryDesc = {
    Text = "Những suy nghĩ và điều nhìn thấy đều là ảo ảnh."
  },
  RelicConfig_98397_BattleDesc = {
    Text = "Sau khi phát động \"Nhóm người\" lần thứ hai mỗi lượt, nhận [Arg1] điểm chìa khóa bạc năng lượng, tất cả người đánh thức nhận [Arg2] điểm aliemus."
  },
  RelicConfig_98397_Desc = {
    Text = "Sau khi phát động \"Nhóm người\" lần thứ hai mỗi lượt, nhận [Arg1] điểm chìa khóa bạc năng lượng, tất cả người đánh thức nhận [Arg2] điểm aliemus."
  },
  RelicConfig_98397_Name = {
    Text = "<OrangeQuality:Đồng hồ chính xác+>"
  },
  RelicConfig_98397_StoryDesc = {
    Text = "Một trong những phát minh tàn nhẫn nhất trong lịch sử loài người."
  },
  RelicConfig_98398_BattleDesc = {
    Text = "Khi trận chiến bắt đầu, khiến tất cả kẻ thù mất [Arg1] tạm thời <ExhaustionIconKeywords:sức mạnh>. Sử dụng \"lò nung đỏ thẫm\" cũng sẽ kích hoạt hiệu ứng này, nhưng có thời gian hồi chiêu 3 vòng."
  },
  RelicConfig_98398_Desc = {
    Text = "Khi trận chiến bắt đầu, khiến tất cả kẻ thù mất [Arg1] tạm thời <ExhaustionIconKeywords:sức mạnh>. Sử dụng \"lò nung đỏ thẫm\" cũng sẽ kích hoạt hiệu ứng này, nhưng có thời gian hồi chiêu 3 vòng."
  },
  RelicConfig_98398_Name = {
    Text = "<OrangeQuality:Kỹ sảo hư không+>"
  },
  RelicConfig_98398_StoryDesc = {
    Text = "Công cụ tuyệt vời để giết người, cướp của và gãi chỗ ngứa."
  },
  RelicConfig_98399_BattleDesc = {
    Text = "Sau khi phát động \"Nhóm người\" lần thứ hai mỗi lượt, nhận [Arg1] điểm chìa khóa bạc năng lượng, tất cả người đánh thức nhận [Arg2] điểm aliemus."
  },
  RelicConfig_98399_Desc = {
    Text = "Sau khi phát động \"Nhóm người\" lần thứ hai mỗi lượt, nhận [Arg1] điểm chìa khóa bạc năng lượng, tất cả người đánh thức nhận [Arg2] điểm aliemus."
  },
  RelicConfig_98399_Name = {
    Text = "<WhiteQuality:đồng hồ chính xác>"
  },
  RelicConfig_98399_StoryDesc = {
    Text = "Một trong những phát minh tàn nhẫn nhất trong lịch sử loài người."
  },
  RelicConfig_98400_BattleDesc = {
    Text = "Mỗi khi rút một thẻ hay bỏ một thẻ, nhận [Arg1] sức mạnh tạm thời, mỗi lượt tối đa kích hoạt 15 lần."
  },
  RelicConfig_98400_Desc = {
    Text = "Mỗi lần rút một lá bài hoặc bỏ một lá bài nhận được [Arg1] tạm thời <PowerIconKeywords:sức mạnh>, mỗi lượt tối đa kích hoạt 15 lần."
  },
  RelicConfig_98400_Name = {
    Text = "<OrangeQuality:Giai điệu âm thầm+>"
  },
  RelicConfig_98400_StoryDesc = {
    Text = "Đàn violin của nghệ sĩ violin nổi tiếng Eric Eichstein. \n Hiện nay, nó đã vĩnh viễn lặng im."
  },
  RelicConfig_98401_BattleDesc = {
    Text = "Khi trận chiến bắt đầu, nhận [Arg1]% sát thương mạnh. Mỗi lần đầu tiên nhận quầy mỗi lượt, nhận [Arg2] số học."
  },
  RelicConfig_98401_Desc = {
    Text = "Khi trận chiến bắt đầu nhận [Arg1]% khuếch đại sát thương, sau lần đầu tiên nhận <RetaliateIconKeywords:phản kích> mỗi vòng, sẽ nhận [Arg2] điểm tính toán."
  },
  RelicConfig_98401_Name = {
    Text = "<OrangeQuality:Báo sáng Putney+>"
  },
  RelicConfig_98401_StoryDesc = {
    Text = "Người bạn đồng hành thân thiết nhất trong nhà vệ sinh của bạn."
  },
  RelicConfig_98402_BattleDesc = {
    Text = "Sau khi gây sát thương chủ động hoặc xúc tu, tăng sát thương xúc tu mục tiêu nhận trong lượt này [Arg1]%, mỗi lượt tối đa kích hoạt 20 lần."
  },
  RelicConfig_98402_Desc = {
    Text = "Sau khi gây sát thương chủ động hoặc xúc tu, tăng sát thương xúc tu mục tiêu nhận trong lượt này [Arg1]%, mỗi lượt tối đa kích hoạt 20 lần."
  },
  RelicConfig_98402_Name = {
    Text = "<OrangeQuality:Mũ lặn+>"
  },
  RelicConfig_98402_StoryDesc = {
    Text = "Giấc mơ là sao trời và đại dương!"
  },
  RelicConfig_98403_BattleDesc = {
    Text = "Khi trận chiến bắt đầu, nhận [Arg1] sức mạnh. Mỗi lần đánh ra một thẻ có \"tiêu hao\", nhận [Arg2] sức mạnh tạm thời, tối đa kích hoạt 10 lần mỗi lượt."
  },
  RelicConfig_98403_Desc = {
    Text = "Khi trận chiến bắt đầu nhận [Arg1] <PowerIconKeywords:sức mạnh>. Mỗi khi đánh ra một thẻ bài có \"kiệt sức\" sẽ nhận được [Arg2] tạm thời <PowerIconKeywords:sức mạnh>, tối đa kích hoạt 10 lần mỗi vòng."
  },
  RelicConfig_98403_Name = {
    Text = "<OrangeQuality:Hộp nhạc nhỏ+>"
  },
  RelicConfig_98403_StoryDesc = {
    Text = "Trong dinh thự của Dexter có nhiều bộ sưu tập, trước khi bị hỏng, Hộp Nhạc Nhỏ từng là món đồ chơi yêu thích nhất của tiểu thư Dexter. \n Thời gian trôi qua, khi tiểu thư Dexter tìm thấy cô ấy lần nữa, bánh răng của cô đã lỏng lẻo, âm nhạc bị biến tấu, nhưng vẫn không ngừng xoay."
  },
  RelicConfig_98404_BattleDesc = {
    Text = "Giải phóng \"bùng nổ điên loạn\" nhận được [Arg1] năng lượng chìa khóa bạc."
  },
  RelicConfig_98404_Desc = {
    Text = "Giải phóng \"bùng nổ điên loạn\" nhận được [Arg1] năng lượng chìa khóa bạc."
  },
  RelicConfig_98404_Name = {
    Text = "<WhiteQuality:khoảnh khắc đẹp>"
  },
  RelicConfig_98404_StoryDesc = {
    Text = "Lưu giữ vẻ đẹp của phút chốc mãi mãi."
  },
  RelicConfig_98405_BattleDesc = {
    Text = "Mỗi lần đầu mỗi lượt của người đánh thức, thẻ lệnh nhận [Arg1] điểm chìa khóa bạc năng lượng."
  },
  RelicConfig_98405_Desc = {
    Text = "Mỗi lần đầu mỗi lượt của người đánh thức, thẻ lệnh nhận [Arg1] điểm chìa khóa bạc năng lượng."
  },
  RelicConfig_98405_Name = {
    Text = "<OrangeQuality:Răng sắc bén+>"
  },
  RelicConfig_98405_StoryDesc = {
    Text = "Không chỉ thương nhân, mà còn có những tín đồ mộ đạo khéo léo trong giao tiếp và tài ăn nói."
  },
  RelicConfig_98406_BattleDesc = {
    Text = "Mỗi khi tạo ra 1 \"Phôi thai\", nhận [Arg1] điểm lò nung đỏ thẫm, mỗi lượt tối đa kích hoạt 3 lần."
  },
  RelicConfig_98406_Desc = {
    Text = "Mỗi khi tạo ra 1 \"Phôi thai\", nhận [Arg1] điểm lò nung đỏ thẫm, mỗi lượt tối đa kích hoạt 3 lần."
  },
  RelicConfig_98406_Name = {
    Text = "<OrangeQuality:Người yêu dấu+>"
  },
  RelicConfig_98406_StoryDesc = {
    Text = "Thợ mộc đã làm một con rối giống như thật cho vợ mình, nó sẽ thay thế con trai của họ, nằm yên trong bụng mẹ."
  },
  RelicConfig_98407_BattleDesc = {
    Text = "Lần đầu mỗi lượt \"Nhóm người\" hoàn trả [Arg1]% chìa khóa bạc năng lượng tiêu hết."
  },
  RelicConfig_98407_Desc = {
    Text = "Lần đầu mỗi lượt \"Nhóm người\" hoàn trả [Arg1]% chìa khóa bạc năng lượng tiêu hết."
  },
  RelicConfig_98407_Name = {
    Text = "<OrangeQuality:Chân thỏ may mắn+>"
  },
  RelicConfig_98407_StoryDesc = {
    Text = "Với những chú thỏ, điều này quả thật chẳng may mắn chút nào."
  },
  RelicConfig_98408_BattleDesc = {
    Text = "Khi bắt đầu lượt, tất cả Người đánh thức không đủ Aliemus để tôn kính nhận [Arg1] điểm Aliemus."
  },
  RelicConfig_98408_Desc = {
    Text = "Khi bắt đầu lượt, tất cả Người đánh thức không đủ Aliemus để tôn kính nhận [Arg1] điểm Aliemus."
  },
  RelicConfig_98408_Name = {
    Text = "<WhiteQuality:thời gian nội dung bí mật>"
  },
  RelicConfig_98408_StoryDesc = {
    Text = "Thưởng thức niềm vui, nhưng không được ăn."
  },
  RelicConfig_98409_BattleDesc = {
    Text = "Khi trận chiến bắt đầu, khiến tất cả kẻ thù mất [Arg1] tạm thời <ExhaustionIconKeywords:sức mạnh>. Sử dụng \"lò nung đỏ thẫm\" cũng sẽ kích hoạt hiệu ứng này, nhưng có thời gian hồi chiêu 3 vòng."
  },
  RelicConfig_98409_Desc = {
    Text = "Khi trận chiến bắt đầu, khiến tất cả kẻ thù mất [Arg1] tạm thời <ExhaustionIconKeywords:sức mạnh>. Sử dụng \"lò nung đỏ thẫm\" cũng sẽ kích hoạt hiệu ứng này, nhưng có thời gian hồi chiêu 3 vòng."
  },
  RelicConfig_98409_Name = {
    Text = "<WhiteQuality:Khả Năng Tuyệt Diệu>"
  },
  RelicConfig_98409_StoryDesc = {
    Text = "Công cụ tuyệt vời để giết người, cướp của và gãi chỗ ngứa."
  },
  RelicConfig_98410_BattleDesc = {
    Text = "Mỗi khi tạo ra 1 \"Phôi thai\", nhận [Arg1] điểm lò nung đỏ thẫm, mỗi lượt tối đa kích hoạt 3 lần."
  },
  RelicConfig_98410_Desc = {
    Text = "Mỗi khi tạo ra 1 \"Phôi thai\", nhận [Arg1] điểm lò nung đỏ thẫm, mỗi lượt tối đa kích hoạt 3 lần."
  },
  RelicConfig_98410_Name = {
    Text = "<WhiteQuality:đứa bé yêu dấu>"
  },
  RelicConfig_98410_StoryDesc = {
    Text = "Thợ mộc đã làm một con rối giống như thật cho vợ mình, nó sẽ thay thế con trai của họ, nằm yên trong bụng mẹ."
  },
  RelicConfig_98411_BattleDesc = {
    Text = "Khi bắt đầu lượt, nếu năng lượng Chìa khóa bạc lớn hơn [Arg1], tiêu hao [Arg1] điểm năng lượng Chìa khóa bạc để đặt 1 thẻ <DerivativeCardKeywords_115:「Cảm hứng cao cấp」> vào tay bạn."
  },
  RelicConfig_98411_Desc = {
    Text = "Khi bắt đầu lượt, nếu năng lượng Chìa khóa bạc lớn hơn [Arg1], tiêu hao [Arg1] điểm năng lượng Chìa khóa bạc để đặt 1 thẻ <DerivativeCardKeywords_115:「Cảm hứng cao cấp」> vào tay bạn."
  },
  RelicConfig_98411_Name = {
    Text = "<RedQuality:biểu tượng ác mộng>"
  },
  RelicConfig_98411_StoryDesc = {
    Text = "Cẩn thận, giấc ngủ sâu quá đà sẽ nuốt chửng mọi thứ khi bạn không hay biết."
  },
  RelicConfig_98412_BattleDesc = {
    Text = "Mỗi khi phát 5 lần \"bùng nổ điên loạn\", dưới [Arg1] thẻ lệnh không phải đạo hàm bổ sung hiệu lực một lần."
  },
  RelicConfig_98412_Desc = {
    Text = "Mỗi khi phát 5 lần \"bùng nổ điên loạn\", dưới [Arg1] thẻ lệnh không phải đạo hàm bổ sung hiệu lực một lần."
  },
  RelicConfig_98412_Name = {
    Text = "<OrangeQuality:rượu của các vì sao+>"
  },
  RelicConfig_98412_StoryDesc = {
    Text = "Di chuyển giữa các ngôi sao."
  },
  RelicConfig_98413_BattleDesc = {
    Text = "Khi trận chiến bắt đầu, nhận [Arg1]% sát thương mạnh. Sau khi nhận sát thương, nhận [Arg2] quầy, tối đa kích hoạt 3 lần mỗi lượt."
  },
  RelicConfig_98413_Desc = {
    Text = "Khi trận chiến bắt đầu nhận [Arg1]% khuếch đại sát thương. Sau khi nhận sát thương sẽ nhận được [Arg2] <RetaliateIconKeywords:phản kích>, tối đa kích hoạt 3 lần mỗi vòng."
  },
  RelicConfig_98413_Name = {
    Text = "<WhiteQuality:lối thoát hiểm an toàn>"
  },
  RelicConfig_98413_StoryDesc = {
    Text = "Thấy rằng, anh ta cũng không thể thoát ra được."
  },
  RelicConfig_98414_BattleDesc = {
    Text = "Sát thương cơ bản gây ra bởi tất cả người đánh thức tăng [Arg1]%. Trước khi tôn kính cuồng bộc phát, sát thương cơ bản làm cho người đánh thức bộc phát tôn kính tạm thời tăng [Arg2]%."
  },
  RelicConfig_98414_Desc = {
    Text = "Sát thương cơ bản gây ra bởi tất cả người đánh thức tăng [Arg1]%. Trước khi tôn kính cuồng bộc phát, sát thương cơ bản làm cho người đánh thức bộc phát tôn kính tạm thời tăng [Arg2]%."
  },
  RelicConfig_98414_Name = {
    Text = "<OrangeQuality:Máu của kẻ bị lãng quên+>"
  },
  RelicConfig_98414_StoryDesc = {
    Text = "Ngày càng tan chảy."
  },
  RelicConfig_98415_BattleDesc = {
    Text = "Sau khi Đánh thức chìa khóa bạc, hồi phục [Heal:Arg1] sinh lực và nhận được [Arg2] năng lượng chìa khóa bạc."
  },
  RelicConfig_98415_Desc = {
    Text = "Sau khi Đánh thức chìa khóa bạc, hồi phục [Heal:Arg1] sinh lực và nhận được [Arg2] năng lượng chìa khóa bạc."
  },
  RelicConfig_98415_Name = {
    Text = "<OrangeQuality:Ô du lịch+>"
  },
  RelicConfig_98415_StoryDesc = {
    Text = "Phát triển rực rỡ trong vùng đất không ánh sáng."
  },
  RelicConfig_98416_BattleDesc = {
    Text = "Khi trận chiến bắt đầu, nhận [Arg1]% sát thương mạnh. Mỗi lần đầu tiên nhận quầy mỗi lượt, nhận [Arg2] số học."
  },
  RelicConfig_98416_Desc = {
    Text = "Khi trận chiến bắt đầu nhận [Arg1]% khuếch đại sát thương, sau lần đầu tiên nhận <RetaliateIconKeywords:phản kích> mỗi vòng, sẽ nhận [Arg2] điểm tính toán."
  },
  RelicConfig_98416_Name = {
    Text = "<WhiteQuality:Tin Tức Sáng Putney>"
  },
  RelicConfig_98416_StoryDesc = {
    Text = "Người bạn đồng hành thân thiết nhất trong nhà vệ sinh của bạn."
  },
  RelicConfig_98417_BattleDesc = {
    Text = "Khi bắt đầu lượt, tất cả Người đánh thức không đủ Aliemus để tôn kính nhận [Arg1] điểm Aliemus."
  },
  RelicConfig_98417_Desc = {
    Text = "Khi bắt đầu lượt, tất cả Người đánh thức không đủ Aliemus để tôn kính nhận [Arg1] điểm Aliemus."
  },
  RelicConfig_98417_Name = {
    Text = "<OrangeQuality:Thời gian trứng màu+>"
  },
  RelicConfig_98417_StoryDesc = {
    Text = "Thưởng thức niềm vui, nhưng không được ăn."
  },
  RelicConfig_98418_BattleDesc = {
    Text = "Khi trận chiến bắt đầu, nhận [Arg1]% sát thương mạnh. Mỗi lần đầu tiên áp dụng độc dược mỗi lượt, rút [Arg2] thẻ."
  },
  RelicConfig_98418_Desc = {
    Text = "Khi trận chiến bắt đầu nhận [Arg1]% khuếch đại sát thương. Sau lần đầu tiên áp dụng <IntoxicationIconKeywords:ngộ độc> mỗi vòng, bạn sẽ rút [Arg2] thẻ bài."
  },
  RelicConfig_98418_Name = {
    Text = "<OrangeQuality:Papyrus của Rhine+>"
  },
  RelicConfig_98418_StoryDesc = {
    Text = "Câu hỏi như sau: 10 tu sĩ chia 6 ổ bánh mì, mỗi người được bao nhiêu?"
  },
  RelicConfig_98419_BattleDesc = {
    Text = "Mỗi khi phát 5 lần \"bùng nổ điên loạn\", dưới [Arg1] thẻ lệnh không phải đạo hàm bổ sung hiệu lực một lần."
  },
  RelicConfig_98419_Desc = {
    Text = "Mỗi khi phát 5 lần \"bùng nổ điên loạn\", dưới [Arg1] thẻ lệnh không phải đạo hàm bổ sung hiệu lực một lần."
  },
  RelicConfig_98419_Name = {
    Text = "<WhiteQuality:Rượu của các vì sao>"
  },
  RelicConfig_98419_StoryDesc = {
    Text = "Di chuyển giữa các ngôi sao."
  },
  RelicConfig_98420_BattleDesc = {
    Text = "Mỗi thẻ khi vào không gian ultra, rút [Arg1] thẻ lệnh thuộc thẻ này từ bốc thăm, nếu không thể rút, thì nhận khả năng tính tương tự. Mỗi lượt tối đa kích hoạt 2 lần."
  },
  RelicConfig_98420_Desc = {
    Text = "Mỗi thẻ khi vào không gian ultra, rút [Arg1] thẻ lệnh thuộc thẻ này từ bốc thăm, nếu không thể rút, thì nhận khả năng tính tương tự. Mỗi lượt tối đa kích hoạt 2 lần."
  },
  RelicConfig_98420_Name = {
    Text = "<OrangeQuality:Prism+>"
  },
  RelicConfig_98420_StoryDesc = {
    Text = "\"Ánh sáng được tạo thành từ bảy màu sắc.\""
  },
  RelicConfig_98421_BattleDesc = {
    Text = "Sau khi sử dụng Silver key awaken, làm cho [Arg1] thẻ có số học cao nhất trong tay được giữ lại và chuẩn bị trước khi lần tiếp theo đánh ra, nhận [Arg2] điểm S-energy."
  },
  RelicConfig_98421_Desc = {
    Text = "Sau khi sử dụng Silver key awaken, làm cho [Arg1] thẻ có số học cao nhất trong tay được giữ lại và chuẩn bị trước khi lần tiếp theo đánh ra, nhận [Arg2] điểm S-energy."
  },
  RelicConfig_98421_Name = {
    Text = "<OrangeQuality:Tập tem lưu niệm xứ lạ+>"
  },
  RelicConfig_98421_StoryDesc = {
    Text = "Niềm nhớ được định lượng."
  },
  RelicConfig_98422_BattleDesc = {
    Text = "Trước khi kết thúc lượt, mỗi thẻ lệnh trên tay sẽ cung cấp [Arg1] điểm Aliemus cho Người đánh thức tương ứng."
  },
  RelicConfig_98422_Desc = {
    Text = "Trước khi kết thúc lượt, mỗi thẻ lệnh trên tay sẽ cung cấp [Arg1] điểm Aliemus cho Người đánh thức tương ứng."
  },
  RelicConfig_98422_Name = {
    Text = "<OrangeQuality:Cân thăng bằng mất cân+>"
  },
  RelicConfig_98422_StoryDesc = {
    Text = "Không còn tượng trưng cho công bằng."
  },
  RelicConfig_98423_BattleDesc = {
    Text = "Khi trận chiến bắt đầu, nhận [Arg1]% sát thương mạnh. Gây sát thương chủ động sau đó đối với tất cả kẻ địch gây [Arg2] điểm độc dược, tối đa kích hoạt 5 lần mỗi lượt."
  },
  RelicConfig_98423_Desc = {
    Text = "Khi trận chiến bắt đầu nhận [Arg1]% khuếch đại sát thương. Sau khi gây sát thương chủ động sẽ gây ra <IntoxicationIconKeywords:ngộ độc> cho tất cả kẻ thù [Arg2], tối đa kích hoạt 5 lần mỗi vòng."
  },
  RelicConfig_98423_Name = {
    Text = "<WhiteQuality:Quyền Trượng của Thầy Tu>"
  },
  RelicConfig_98423_StoryDesc = {
    Text = "Sự sùng kính không được phép"
  },
  RelicConfig_98424_BattleDesc = {
    Text = "Khi trận chiến bắt đầu, nhận [Arg1]% sát thương mạnh. Mỗi lần đầu tiên áp dụng độc dược mỗi lượt, rút [Arg2] thẻ."
  },
  RelicConfig_98424_Desc = {
    Text = "Khi trận chiến bắt đầu nhận [Arg1]% khuếch đại sát thương. Sau lần đầu tiên áp dụng <IntoxicationIconKeywords:ngộ độc> mỗi vòng, bạn sẽ rút [Arg2] thẻ bài."
  },
  RelicConfig_98424_Name = {
    Text = "<WhiteQuality:Cuộn giấy Rhind>"
  },
  RelicConfig_98424_StoryDesc = {
    Text = "Câu hỏi như sau: 10 tu sĩ chia 6 ổ bánh mì, mỗi người được bao nhiêu?"
  },
  RelicConfig_98425_BattleDesc = {
    Text = "Khi trận chiến bắt đầu, nhận [Arg1] sức mạnh. Mỗi lần đánh ra một thẻ có \"tiêu hao\", nhận [Arg2] sức mạnh tạm thời, tối đa kích hoạt 10 lần mỗi lượt."
  },
  RelicConfig_98425_Desc = {
    Text = "Khi trận chiến bắt đầu nhận [Arg1] <PowerIconKeywords:sức mạnh>. Mỗi khi đánh ra một thẻ bài có \"kiệt sức\" sẽ nhận được [Arg2] tạm thời <PowerIconKeywords:sức mạnh>, tối đa kích hoạt 10 lần mỗi vòng."
  },
  RelicConfig_98425_Name = {
    Text = "<WhiteQuality:Hộp Nhạc Nhỏ>"
  },
  RelicConfig_98425_StoryDesc = {
    Text = "Trong dinh thự của Dexter có nhiều bộ sưu tập, trước khi bị hỏng, Hộp Nhạc Nhỏ từng là món đồ chơi yêu thích nhất của tiểu thư Dexter. \n Thời gian trôi qua, khi tiểu thư Dexter tìm thấy cô ấy lần nữa, bánh răng của cô đã lỏng lẻo, âm nhạc bị biến tấu, nhưng vẫn không ngừng xoay."
  },
  RelicConfig_98426_BattleDesc = {
    Text = "Lần đầu mỗi lượt \"Nhóm người\" kích hoạt tất cả xúc tu tấn công [Arg1] lần kẻ thù, gây 50% sát thương."
  },
  RelicConfig_98426_Desc = {
    Text = "Lần đầu mỗi lượt \"Nhóm người\" kích hoạt tất cả xúc tu tấn công [Arg1] lần kẻ thù, gây 50% sát thương."
  },
  RelicConfig_98426_Name = {
    Text = "<WhiteQuality:ốc vàng nhỏ>"
  },
  RelicConfig_98426_StoryDesc = {
    Text = "Con ốc vàng nhỏ này xuất thân cao quý, có nguồn hoàn hảo, không thể chê vào đâu được."
  },
  RelicConfig_98427_BattleDesc = {
    Text = "Vào đầu lượt, nếu sức sống dưới 50%, hiệu ứng tăng sát thương tạm thời +[Arg1]%. Nếu sức sống dưới 25%, rút thêm [Arg2] lá bài và nhận [Arg2] sức tính toán."
  },
  RelicConfig_98427_Desc = {
    Text = "Vào đầu lượt, nếu sức sống dưới 50%, hiệu ứng tăng sát thương tạm thời +[Arg1]%. Nếu sức sống dưới 25%, rút thêm [Arg2] lá bài và nhận [Arg2] sức tính toán."
  },
  RelicConfig_98427_Name = {
    Text = "<OrangeQuality:Hộp cứu thương của bác sĩ+>"
  },
  RelicConfig_98427_StoryDesc = {
    Text = "Hộp vali tượng trưng cho thân phận bác sĩ, rất nặng.\nMở nó ra, chưa chắc đã phải là bác sĩ thật sự."
  },
  RelicConfig_98891_BattleDesc = {
    Text = "Sau khi trận chiến bắt đầu, nhận được 5 lớp \"<LostWay:lạc mất>\", mỗi khi chơi 3 thẻ lệnh thì giảm 1 lớp.\nSau khi tất cả \"<LostWay:lạc mất>\" bị loại bỏ, tất cả thể thức tỉnh nhận được 100 điểm điên loạn, mỗi khi chơi 3 thẻ lệnh thì hồi phục [Arg1] điểm sinh lực, áp đặt 1% sinh lực tối đa của đối phương vào hàng trước <Corrosion:xói mòn>."
  },
  RelicConfig_98891_Desc = {
    Text = "Sau khi trận chiến bắt đầu, nhận được 5 lớp \"<LostWay:lạc mất>\", mỗi khi chơi 3 thẻ lệnh thì giảm 1 lớp.\nSau khi tất cả \"<LostWay:lạc mất>\" bị loại bỏ, tất cả thể thức tỉnh nhận được 100 điểm điên loạn, mỗi khi chơi 3 thẻ lệnh thì hồi phục [Arg1] điểm sinh lực, áp đặt 1% sinh lực tối đa của đối phương vào hàng trước <Corrosion:xói mòn>."
  },
  RelicConfig_98891_Name = {
    Text = "Ngọn đèn cứu rỗi"
  },
  RelicConfig_98891_StoryDesc = {
    Text = "Dù phải trải qua u ám, ngọn đèn cứu rỗi cuối cùng cũng sẽ bừng sáng một lần nữa giữa cái chết."
  }
})
return Text_RelicConfig
