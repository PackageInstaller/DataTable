__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Event = readonly({
  Event_116371_ChoiceDesc1 = {Text = "[đi]"},
  Event_116371_Desc = {
    Text = "Bạn đã nhận được yêu cầu liên lạc từ trường, giọng nói quen thuộc giúp tâm trạng bạn bình yên lại. Bạn lấy lại tinh thần và tiếp tục tiến lên."
  },
  Event_116371_Name = {
    Text = "điểm liên lạc"
  },
  Event_116372_ChoiceDesc1 = {Text = "[đi]"},
  Event_116372_Desc = {
    Text = "Bạn đã kích hoạt phòng không rõ."
  },
  Event_116372_Name = {Text = "Không rõ"},
  Event_116373_ChoiceDesc1 = {Text = "[đi]"},
  Event_116373_Desc = {
    Text = "Bạn đã tìm thấy báu vật."
  },
  Event_116373_Name = {Text = "báu vật"},
  Event_116374_ChoiceDesc1 = {
    Text = "[Kết nối] phục hồi Arg2 điểm sức sống."
  },
  Event_116374_Desc = {
    Text = "Bạn đang khám phá trong sương mù, đột nhiên, huy hiệu trường trên ngực bạn phát ra ánh sáng bạc yếu ớt. Ai đang gọi bạn từ bên kia thiết bị liên lạc?"
  },
  Event_116374_Name = {
    Text = "điểm liên lạc"
  },
  Event_116389_ChoiceDesc1 = {Text = "[đi]"},
  Event_116389_Desc = {
    Text = "nắn áo còn đang ngủ...zzZZ"
  },
  Event_116389_Name = {Text = "nắn áo"},
  Event_116429_ChoiceDesc1 = {Text = "[đi]"},
  Event_116429_Desc = {
    Text = "Bạn đã kích hoạt sự kiện ngẫu nhiên 3."
  },
  Event_116429_Name = {
    Text = "Sự kiện ngẫu nhiên 3"
  },
  Event_116430_ChoiceDesc1 = {Text = "[đi]"},
  Event_116430_Desc = {
    Text = "Bạn đã kích hoạt sự kiện ngẫu nhiên 1."
  },
  Event_116430_Name = {
    Text = "Sự kiện ngẫu nhiên 1"
  },
  Event_116431_ChoiceDesc1 = {Text = "[đi]"},
  Event_116431_Desc = {
    Text = "Bạn đã kích hoạt sự kiện ngẫu nhiên 2."
  },
  Event_116431_Name = {
    Text = "Sự kiện ngẫu nhiên 2"
  },
  Event_117279_ChoiceDesc1 = {
    Text = "[Bạn từng khao khát ngây thơ]Đặt 3 thẻ「(Skill.Arg1)」vào bộ bài."
  },
  Event_117279_Desc = {
    Text = "\nSương mù mỏng lên cao ngang mặt biển, bao trùm mọi thứ trong một lớp mờ ảo.\nVượt qua ranh giới giữa sinh và tử, vượt qua khoảng cách trong và ngoài Cửa, vượt qua những kỷ niệm đã phai màu, bạn thấy hình bóng của một quý cô đang che ô ngược sáng.\nThời gian bên cô đã qua, cũng như sắc màu mảnh mai nhưng tươi tắn của tuổi trẻ cô ấy.\nChờ đợi mặt trời giả lừa dối mọc lên, sương mù tan biến không hình, hình bóng của cô trong giấc mơ cũng rung rinh biến thành những bọt mơ màng, gửi đến bạn lời tạm biệt không tiếng nói."
  },
  Event_117279_Name = {
    Text = "Hình bóng Muphí"
  },
  Event_117280_ChoiceDesc1 = {
    Text = "[Bạn từng khao khát sự ngây thơ]Chọn 2 thẻ bài để gán dấu 「Vực sâu hồi âm」."
  },
  Event_117280_Desc = {
    Text = "\nSương mù mỏng lên cao ngang mặt biển, bao trùm mọi thứ trong một lớp mờ ảo.\nVượt qua ranh giới giữa sinh và tử, vượt qua khoảng cách trong và ngoài Cửa, vượt qua những kỷ niệm đã phai màu, bạn thấy hình bóng của một quý cô đang che ô ngược sáng.\nThời gian bên cô đã qua, cũng như sắc màu mảnh mai nhưng tươi tắn của tuổi trẻ cô ấy.\nChờ đợi mặt trời giả lừa dối mọc lên, sương mù tan biến không hình, hình bóng của cô trong giấc mơ cũng rung rinh biến thành những bọt mơ màng, gửi đến bạn lời tạm biệt không tiếng nói."
  },
  Event_117280_Name = {
    Text = "Hình bóng Muphí"
  },
  Event_118414_ChoiceDesc1 = {
    Text = "[ba điểm]"
  },
  Event_118414_ChoiceDesc2 = {
    Text = "[sáu giờ]"
  },
  Event_118414_ChoiceDesc3 = {
    Text = "[một điểm]"
  },
  Event_118414_Desc = {
    Text = "Xúc xắc quay lên, phát ra tiếng lục cục.\nNó sẽ dừng lại khi nào?\nBạn không biết, nhưng bạn phải đưa ra một đáp án."
  },
  Event_118414_Name = {
    Text = "Cuộc cờ vận mệnh"
  },
  Event_118415_ChoiceDesc1 = {Text = "[đi]"},
  Event_118415_Desc = {
    Text = "Phản hồi của bạn khiến \"bầu trời\" càng thêm dịu dàng.\nNó nhẹ nhàng đặt một nụ hôn lên trán bạn.\nSau đó, trán bạn nở ra một bông sóng."
  },
  Event_118415_Name = {
    Text = "Vòng tay đại dương"
  },
  Event_118416_ChoiceDesc1 = {
    Text = "[Đắm chìm trong ảo tưởng] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_118416_ChoiceDesc2 = {
    Text = "[Giữ lý trí] Với mỗi thân thể được đánh thức có mức điên cuồng đạt từ 50 trở lên, nhận được 15 dấu đen"
  },
  Event_118416_ChoiceDesc3 = {
    Text = "[Cưỡng ép rời đi] nhận được 1 trong 3 khắcăng"
  },
  Event_118416_Desc = {
    Text = "Có lẽ chiến đấu lâu dài khiến bạn rơi vào trạng thái mơ hồ, hoặc có lẽ chỉ là bộ não đã phản bội cơ thể bạn.\nMột cảm giác mất trọng lực xuất hiện trong đầu bạn.\nTrong khoảnh khắc, đầu óc bạn bỗng biến thành kính vạn hoa, rực rỡ, muôn màu, lấp lánh ánh sáng ngũ sắc.\nVô số cảm hứng, ảo tưởng và cuồng tưởng ùa vào não, chiếm cứ mọi ngóc ngách trong đầu bạn.\nCứ tiếp tục thế này, đầu bạn sẽ sớm bị những thứ hỗn loạn này làm nổ tung."
  },
  Event_118416_Name = {
    Text = "Kính vạn hoa tư duy"
  },
  Event_118417_ChoiceDesc1 = {
    Text = "[Tham gia ván cược]Nhiễm 「(Skill.Arg1)」, bước vào ván cược"
  },
  Event_118417_ChoiceDesc2 = {
    Text = "[thôi đi] nhận được 25 dấu đen"
  },
  Event_118417_Desc = {
    Text = "Trong cơn mơ hồ, ý thức của bạn xuyên qua từng lớp sương mù, trôi dạt đến một không gian vô định.\nHai viên xúc xắc bị ném trước mặt bạn, nhưng thực thể bí ẩn đã cưỡng ép đưa bạn đến đây vẫn chưa lộ diện.\nBạn chỉ có thể nghe thấy giọng nói hỗn loạn từ khắp mọi phía của thực thể đó.\n \"Muốn quay về sao? Vậy thì chơi một ván đi.\"\n \"Lấy mạng sống của ngươi làm cược, đánh một ván với số mệnh.\""
  },
  Event_118417_Name = {
    Text = "Cuộc cờ vận mệnh"
  },
  Event_118418_ChoiceDesc1 = {Text = "[đi]"},
  Event_118418_Desc = {
    Text = "Trải nghiệm siêu thoát luôn ngắn ngủi. Chúng đến vô thanh, rồi biến mất đột ngột.\nNhưng ít nhất cái đầu của bạn vẫn còn đây, không thực sự nổ tung."
  },
  Event_118418_Name = {
    Text = "Kính vạn hoa tư duy"
  },
  Event_118419_ChoiceDesc1 = {
    Text = "[rời đi] nhận được bạc tạo vật [(RelicConfig.Arg1)]"
  },
  Event_118419_Desc = {
    Text = "Bạn không thua, nhưng cũng không thắng, kết quả không tốt không xấu.\n \"Hòa...\"\nThực thể vô danh thở dài, nhưng trong giọng nói không nghe ra sự tiếc nuối.\n \"Thật là một trò vui thú vị.\""
  },
  Event_118419_Name = {
    Text = "Cuộc cờ vận mệnh"
  },
  Event_118420_ChoiceDesc1 = {Text = "[đi]"},
  Event_118420_Desc = {
    Text = "Dần dần, âm nhạc cuồng loạn ấy trong tai bạn trở nên hòa hợp, thánh khiết.\nCuối cùng bạn đã giác ngộ, hiểu được tại sao nó được gọi là\"Thánh ca Hoàn mỹ\".\nBởi vì nó thực sự\"hoàn mỹ vô khuyết\"."
  },
  Event_118420_Name = {
    Text = "Thánh ca \"Hoàn mỹ\""
  },
  Event_118421_ChoiceDesc1 = {
    Text = "[Cảm nhận não bộ] Chọn 1 thẻ lệnh từ 3 thẻ để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_118421_ChoiceDesc2 = {
    Text = "[Cảm nhận linh hồn] nhiễm [(Skill.Arg1)], khắcăng lại, tối đa thực hiện 2 lần"
  },
  Event_118421_Desc = {
    Text = "Chiếc lồng đầu tiên của con người, chính là thân xác của mình.\nTrong chiếc lồng thân xác ấy, bộ não, là chiếc lồng cuối cùng và cũng là quan trọng nhất.\n \"Cưng ơi, ngươi tưởng mình còn sống, còn thở, là an toàn sao?\"\nKhi bộ não phản bội linh hồn ngươi, ngươi sẽ nếm trải sự tra tấn đau đớn nhất thế gian.\nVà sự tra tấn ấy, sẽ đi theo ngươi cả đời."
  },
  Event_118421_Name = {
    Text = "Lồng giam não bộ"
  },
  Event_118422_ChoiceDesc1 = {
    Text = "[Chạm vào bướm] xóa bỏ 2 thẻ bài"
  },
  Event_118422_ChoiceDesc2 = {
    Text = "[Xua đuổi bướm] nhận được vật bị nguyền rủa \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_118422_ChoiceDesc3 = {
    Text = "[Rời đi] Nhận được Arg1 dấu đen"
  },
  Event_118422_Desc = {
    Text = "Dưới đáy biển sâu không có bướm. Chính cô gái bị giam cầm trong căn phòng đã tưởng tượng ra những sinh mệnh này.\nChúng thật đẹp, tự do bay lượn trong không trung.\n \"Nếu... nếu tôi cũng có thể như chúng, bay khỏi nơi đây thì tốt biết mấy...\"\nMột con bướm phát ra tiếng nức nở, nhưng âm thanh ấy bị che lấp trong vô số tiếng vỗ cánh, bị che lấp trong tiếng máy đánh chữ lách tách, gần như không thể nghe thấy."
  },
  Event_118422_Name = {
    Text = "Linh hồn bay lượn như bướm"
  },
  Event_118423_ChoiceDesc1 = {
    Text = "[Cắt đứt dây thừng]làm nhiễm「(Skill.Arg1)」，nhận di vật bị nguyền rủa「(RelicConfig.Arg2)」"
  },
  Event_118423_ChoiceDesc2 = {
    Text = "[Cởi trói cho hắn]nhiễm hai lần「(Skill.Arg1)」，nhận di vật bạc「(RelicConfig.Arg2)」và「(RelicConfig.Arg3)」"
  },
  Event_118423_ChoiceDesc3 = {
    Text = "[Giúp hắn giải thoát]nhận di vật bạc「(RelicConfig.Arg1)」"
  },
  Event_118423_Desc = {
    Text = "\"Có người nói, dục vọng vô tận là động lực thúc đẩy con người tiến về phía trước.\"\n \"Nhưng khi dục vọng ấy mạnh mẽ đến mức không thể phớt lờ, không thể chặt đứt, ta chỉ cảm thấy dục vọng từ chính bản thân đã hóa thành lồng giam giữ ta.\"\nTừ bóng tối vọng ra giọng nói yếu ớt, bạn không thấy được gương mặt đối phương, chỉ thấy đôi tay bị trói buộc.\n \"Những dục vọng này lấy nỗi sợ hãi, sự hèn nhát, hy vọng, đau khổ của ta làm thức ăn, rồi ngược lại gia tăng dục vọng của ta.\"\nGiọng nói yếu ớt ấy, phát ra lời cầu xin cuối cùng.\n \"Ta nguyện dâng hiến tất cả! Người tốt bụng ơi, hãy cứu ta... hoặc ban cho ta sự giải thoát...\""
  },
  Event_118423_Name = {
    Text = "Dục vọng trói buộc"
  },
  Event_118424_ChoiceDesc1 = {
    Text = "[Cảm nhận não bộ] Chọn 1 thẻ lệnh từ 3 thẻ để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_118424_Desc = {
    Text = "Bạn cảm thấy tủy não của mình co giật một cái.\n \"Điều này có ý nghĩa đặc biệt gì không?\"\nBạn tự hỏi bản thân, nhưng não bộ im lặng không một tiếng.\nKhông phải mỗi lần tự vấn đều có thể nhận được câu trả lời."
  },
  Event_118424_Name = {
    Text = "Lồng giam não bộ"
  },
  Event_118425_ChoiceDesc1 = {Text = "[đi]"},
  Event_118425_Desc = {
    Text = "Bạn nỗ lực bơi lên, cuối cùng cũng nhảy lên khỏi mặt nước.\nKhông khí mang mùi tanh của biển tràn vào phổi bạn, nhắc nhở rằng bạn chưa thực sự thoát khỏi nguy hiểm.\nNhưng bạn biết, bầu trời thực sự đang ở trên đầu bạn.\nNhư sự thật, sẽ không bao giờ bị những lời nói dối dịu dàng che khuất."
  },
  Event_118425_Name = {
    Text = "Vòng tay đại dương"
  },
  Event_118426_ChoiceDesc1 = {Text = "[đi]"},
  Event_118426_Desc = {
    Text = "Khoảnh khắc bạn chạm vào sợi dây dục vọng, một cơn đau nhói trào dâng từ sâu thẳm linh hồn.\nNỗi sợ hãi, sự hèn nhát, hy vọng, đau khổ của bạn tất cả đều tuôn trào từ trong cơ thể, hóa thành những sợi dây đẫm máu, trói chặt đôi tay bạn.\nLúc này, bạn nghe thấy giọng nói ấy cất lên tiếng hoan hô đầy ác ý.\n \"Người tốt bụng, ngươi sẽ được đền đáp... tất nhiên, còn có cả lời nguyền.\""
  },
  Event_118426_Name = {
    Text = "Dục vọng trói buộc"
  },
  Event_118427_ChoiceDesc1 = {Text = "[đi]"},
  Event_118427_Desc = {
    Text = "Sự chạm nhẹ của bạn khiến đàn bướm run rẩy.\nKể từ khi sinh ra, chúng chưa bao giờ được đối xử dịu dàng như vậy.\nĐàn bướm bị cảm xúc bối rối chi phối, thậm chí quên cả bay.\nThế là, vô số con bướm rơi xuống, để lộ chiếc máy đánh chữ từng bị vô số đôi cánh che khuất.\nThứ đáng thương đã mất đi sự sống ấy, dùng sức lực cuối cùng, gõ ra hai chữ \"Tự do\"."
  },
  Event_118427_Name = {
    Text = "Linh hồn bay lượn như bướm"
  },
  Event_118428_ChoiceDesc1 = {
    Text = "[Chuẩn bị chiến đấu] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", lây nhiễm \"(Skill.Arg2)\""
  },
  Event_118428_ChoiceDesc2 = {
    Text = "[Thử đi đường vòng]được tặng 25 dấu đen"
  },
  Event_118428_Desc = {
    Text = "Giữa biển sâu nơi ánh sao rơi xuống, những kẻ đạp biển đã ẩn mình suốt hàng ngàn năm.\nBiển nước vô tận đã chứng kiến sự điên cuồng của họ, chứng kiến sự nhẫn nại của họ, và cũng chứng kiến đức tin thành kính nhất của họ đối với thần linh.\nKhông ai có thể ngăn cản sự giáng lâm vĩ đại của thần linh.\nBất kỳ kẻ cản đường nào, đều sẽ hóa thành tro tàn trong cơn thịnh nộ của những kẻ đạp biển."
  },
  Event_118428_Name = {
    Text = "Chờ đợi dưới quần tinh"
  },
  Event_118429_ChoiceDesc1 = {Text = "[đi]"},
  Event_118429_Desc = {
    Text = "Bạn vô thức bịt tai lại.\nKhông thể tin được, những giai điệu từ sâu thẳm linh hồn đã biến mất.\nTất nhiên, chỉ là tạm thời."
  },
  Event_118429_Name = {
    Text = "Âm sắc cấm kỵ"
  },
  Event_118430_ChoiceDesc1 = {
    Text = "[Hồi tưởng quá khứ]nhận được chọn 1 trong 3 đá khắc cao cấp"
  },
  Event_118430_ChoiceDesc2 = {
    Text = "[Dòm ngó tương lai]nhận được vật tạo vàng「(RelicConfig.Arg1)」, nhiễm「(Skill.Arg2)」"
  },
  Event_118430_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 50 dấu đen"
  },
  Event_118430_Desc = {
    Text = "Trên đời không có gì có thể vững chắc bất biến.\nNgay cả lạc viên do Thần Mẫu tạo ra cũng vậy.\nTrong khoảnh khắc ngắn ngủi, bạn thoáng thấy một vài thứ từ khe nứt thời không.\nQuá khứ, hiện tại, tương lai đan xen trong kẽ nứt chi chít ấy, không ngừng biến đổi.\nChờ đợi sự tò mò dòm ngó của bạn."
  },
  Event_118430_Name = {
    Text = "Khe Nứt Thời Không"
  },
  Event_118431_ChoiceDesc1 = {
    Text = "[ Nhận được 100 dấu đen ]"
  },
  Event_118431_ChoiceDesc2 = {
    Text = "[2 thẻ lệnh ngẫu nhiên nhận Khắc ấn: \"(EnchantConfig.Arg1)\"]"
  },
  Event_118431_Desc = {
    Text = "Ý chí vô hình không chấp nhận lựa chọn của bạn. Nó sẵn lòng cho bạn thêm một cơ hội để thay đổi——\nCẩn thận, dù âm nhạc vô hình, nó vẫn có thể thu hoạch tính mạng."
  },
  Event_118431_Name = {
    Text = "Thánh ca \"Hoàn mỹ\""
  },
  Event_118432_ChoiceDesc1 = {
    Text = "[Cho chuột ăn] nhận được bạc sáng tạo[(RelicConfig.Arg1)], chọn nhiễm 1 lần triệu chứng"
  },
  Event_118432_ChoiceDesc2 = {
    Text = "[Xua đuổi chuột] chọn 1 thẻ lệnh từ 3 thẻ lệnh để nhận khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_118432_ChoiceDesc3 = {
    Text = "[Phớt lờ chuột] nhận được 25 dấu đen"
  },
  Event_118432_Desc = {
    Text = "Mọi thứ trên con tàu này, đều đang luân hồi.\nNhững sinh vật nhỏ bé đáng ghét phủ đầy lông bẩn thỉu sống nhờ trên tàu tự nhiên cũng không thể tránh khỏi số phận này.\nTrong vô số lần luân hồi, chúng ăn tất cả những gì nhìn thấy, nhưng vẫn không thể thỏa mãn.\n \"Đói... quá...\"\nBầy chuột phát ra tiếng kêu the thé bệnh hoạn và chói tai.\nNhững lần luân hồi liên tiếp khiến chúng đói đến không chịu nổi, chúng phải ăn gì đó.\nNgay lập tức, ngay bây giờ!"
  },
  Event_118432_Name = {
    Text = "Bầy chuột đói"
  },
  Event_118433_ChoiceDesc1 = {
    Text = "[Tránh ánh mắt] nhận được vật tạo vàng \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_118433_ChoiceDesc2 = {
    Text = "[Nhìn thẳng vào mắt] Ngẫu nhiên đánh thức 2 thân thể, bị nhiễm hai lần [(Skill.Arg1)]"
  },
  Event_118433_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 50 dấu đen"
  },
  Event_118433_Desc = {
    Text = "Giống như những vì sao trên bầu trời, dưới biển sâu tất nhiên cũng có rất nhiều đôi mắt.\nNhững đôi mắt đó đến từ những con cá sống dưới đáy biển, đến từ những loài mang phạm thượng, và cũng đến từ chính đại dương.\nSuỵt, đừng kinh động chúng.\nĐừng, kinh động sự điên cuồng của biển sâu."
  },
  Event_118433_Name = {
    Text = "Mắt biển sâu"
  },
  Event_118434_ChoiceDesc1 = {
    Text = "[Phớt lờ lời thì thầm]"
  },
  Event_118434_ChoiceDesc2 = {
    Text = "[Lắng nghe lời thì thầm]"
  },
  Event_118434_ChoiceDesc3 = {
    Text = "[Tuyên truyền ngược]"
  },
  Event_118434_Desc = {
    Text = "\"Khao khát được thần minh ban ơn sao? Muốn biết ý nghĩa tồn tại của bản thân sao?\"\nMột tiếng thở dài vang bên tai bạn, như lời thì thầm tự nói của kẻ tâm thần, lại tựa lời thì thầm thân mật của vật thể vô hình.\nDưới lý trí và cảnh giác, bạn lên tiếng từ chối, nhưng giọng nói đó vẫn tự nói tự nghe.\n \"Xin hãy kiên nhẫn lắng nghe. Điều ngươi sắp biết, là sự thật liên quan đến vận mệnh của thế giới...\""
  },
  Event_118434_Name = {
    Text = "Bài giảng của Kẻ Vô Hình"
  },
  Event_118435_ChoiceDesc1 = {
    Text = "[Cảm nhận não bộ] Chọn 1 thẻ lệnh từ 3 thẻ để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_118435_ChoiceDesc2 = {
    Text = "[Cảm nhận linh hồn] nhiễm [(Skill.Arg1)], lại ngẫu nhiên khắc ấn"
  },
  Event_118435_Desc = {
    Text = "Bộ não được bảo vệ an toàn bên trong hộp sọ đã truyền đạt cho bạn một số thông tin.\nBạn không biết liệu những thông tin này có bị hao mòn trong quá trình chuyển đổi chất dẫn truyền thần kinh và truyền dẫn dòng điện sinh học hay không.\nSự thật duy nhất có thể xác định là, bạn đã tiếp nhận thông tin này, và trong sự tồn tại khách quan của thể xác, cảm nhận được sự sống còn của chính mình."
  },
  Event_118435_Name = {
    Text = "Lồng giam não bộ"
  },
  Event_118436_ChoiceDesc1 = {
    Text = "[rời đi] nhận được 50 dấu đen"
  },
  Event_118436_Desc = {
    Text = "\"Đáp án không tồi, nhưng đáng tiếc, không phải đáp án đúng.\"\n \"Vậy đáp án đúng là gì?\"\nThực thể bí ẩn không trả lời câu hỏi của bạn, chỉ phát ra một tiếng cười khẩy.\n \"Ai bảo ngươi số mệnh có đáp án đúng?\""
  },
  Event_118436_Name = {
    Text = "Cuộc cờ vận mệnh"
  },
  Event_118437_ChoiceDesc1 = {Text = "[đi]"},
  Event_118437_Desc = {
    Text = "\"Ngươi tưởng ta chưa từng thử cắt đứt chúng sao?Không, khi ngươi chống lại dục vọng, chúng chỉ trở nên mãnh liệt hơn mà thôi！\"\nCảm nhận những sợi dây hóa thân từ dục vọng ngày càng siết chặt, thậm chí cứa sâu vào da thịt, giọng nói ấy phát ra tiếng gào tuyệt vọng.\n \"Ta mãi mãi không thoát khỏi chúng được... mãi mãi！\""
  },
  Event_118437_Name = {
    Text = "Dục vọng trói buộc"
  },
  Event_118438_ChoiceDesc1 = {
    Text = "[Lắng nghe bài hát] nhận được 25 dấu đen, bị nhiễm [(Skill.Arg2)], tiếp tục chọn"
  },
  Event_118438_ChoiceDesc2 = {
    Text = "[bỏ mặc] rời đi"
  },
  Event_118438_Desc = {
    Text = "Con quạ đen đang khóc.\nCon quạ đen đang gào thét.\nCon quạ đen đang cuồng hú.\nNhưng trong tai người ta, nó chỉ đang hát.\n \"Ah, giọng hát thật vô tư lự làm sao. Thật ước gì tôi cũng là một con quạ, tránh xa phiền não nhân gian.\""
  },
  Event_118438_Name = {
    Text = "Oán thán không ai cảm nhận"
  },
  Event_118439_ChoiceDesc1 = {Text = "[đi]"},
  Event_118439_Desc = {
    Text = "Đàn bướm tan đi, cuối cùng bạn cũng nhìn rõ chiếc máy đánh chữ bên dưới.\nThứ đáng thương đã mất đi sự sống ấy, dùng sức lực cuối cùng, gõ ra hai chữ \"Rời đi\"."
  },
  Event_118439_Name = {
    Text = "Linh hồn bay lượn như bướm"
  },
  Event_118440_ChoiceDesc1 = {Text = "[đi]"},
  Event_118440_Desc = {
    Text = "Trong hình ảnh quá khứ, cô gái khoác áo lông xù vẫy tay về phía bạn.\nBạn không nghe rõ cô ấy nói gì, nhưng bạn nhìn thấy nụ cười của cô gái."
  },
  Event_118440_Name = {
    Text = "Khe Nứt Thời Không"
  },
  Event_118441_ChoiceDesc1 = {Text = "[đi]"},
  Event_118441_Desc = {
    Text = "Đáy biển sâu lại trở về với bóng tối và tĩnh lặng.\nTrong bóng tối và tĩnh lặng ấy, bạn lại nghe thấy tiếng tim đập.\nÂm thanh đó đến từ bên trong cơ thể bạn.\nTrong mắt kẻ khác, bạn cũng chỉ là một trái tim đang đập, bơi lội trong đáy biển sâu tối đen."
  },
  Event_118441_Name = {
    Text = "Mạnh Được Yếu Thua"
  },
  Event_118442_ChoiceDesc1 = {Text = "[đi]"},
  Event_118442_Desc = {
    Text = "Lần này, kẻ hóa thành tro tàn không phải là kẻ cản đường, mà là những kẻ đạp biển.\nQuần tinh lặng lẽ nhìn xuống cảnh tượng này, giống như hàng ngàn năm qua, giữ im lặng."
  },
  Event_118442_Name = {
    Text = "Chờ đợi dưới quần tinh"
  },
  Event_118443_ChoiceDesc1 = {Text = "[đi]"},
  Event_118443_Desc = {
    Text = "Dù chiếm ưu thế về số lượng, nhưng lũ chuột bẩn thỉu lại có gan nhỏ hơn cả thân hình chúng.\nChúng bị thái độ mạnh mẽ của bạn đe dọa, tán loạn bỏ chạy."
  },
  Event_118443_Name = {
    Text = "Bầy chuột đói"
  },
  Event_118444_ChoiceDesc1 = {
    Text = "[Giơ tay cứu giúp] Gây thức tỉnh ngẫu nhiên một thân thể được đánh thức, lây nhiễm [(Skill.Arg1)]"
  },
  Event_118444_ChoiceDesc2 = {
    Text = "[Im lặng đứng nhìn] Bạn nhận được quyền chọn 1 trong 3 khắcăng đặc biệt"
  },
  Event_118444_Desc = {
    Text = "Một trái tim đang đập bơi lội trong biển sâu tối đen.\nNó có lẽ thuộc về một con cá, hoặc có lẽ thuộc về một sinh vật nào đó có mang cá.\nBạn không thể nhìn rõ. Thứ duy nhất bạn có thể nhìn rõ, chính là trái tim không ngừng đập kia, và phía sau trái tim ấy, cái miệng rộng đẫm máu đang dần mở ra.\nSăn mồi, hoặc bị săn, là quy luật của tự nhiên.\nDù là trên đất liền, hay đại dương."
  },
  Event_118444_Name = {
    Text = "Mạnh Được Yếu Thua"
  },
  Event_118445_ChoiceDesc1 = {
    Text = "[Vẫy tay xua đuổi] Chọn 1 trong 3 thẻ lệnh nhận được Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_118445_ChoiceDesc2 = {
    Text = "[Tự do dừng lại] nhận được bạc sáng tạo \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_118445_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_118445_Desc = {
    Text = "Trong bóng tối vọng lại tiếng động nhẹ.\nĐó là một con bướm lịch sự hỏi thăm.\n \"Tôi có thể đậu trên lòng bàn tay bạn được không?\"\n \"Tôi chỉ quá mệt, muốn nghỉ ngơi một chút...\"\nVừa hỏi thăm như vậy, con bướm xuyên qua bóng tối, lượn vòng trước mặt bạn.\nDung dịch đen sền sệt nhỏ giọt từ đôi cánh của nó — đó là món quà từ bóng tối khi bướm xuyên qua."
  },
  Event_118445_Name = {
    Text = "Thỉnh Cầu Của Bướm"
  },
  Event_118446_ChoiceDesc1 = {
    Text = "[Rời đi] nhận được vật tạo vàng[(RelicConfig.Arg1)]"
  },
  Event_118446_Desc = {
    Text = "Sau một khoảng im lặng, thứ gì đó được ném vào lòng bạn.\n \"Cầm lấy nó rồi rời đi.\"\n \"Số mệnh đối với kẻ may mắn, luôn hào phóng.\""
  },
  Event_118446_Name = {
    Text = "Cuộc cờ vận mệnh"
  },
  Event_118447_ChoiceDesc1 = {
    Text = "[Đi theo chỉ dẫn] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_118447_ChoiceDesc2 = {
    Text = "[Bỏ qua chỉ dẫn] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_118447_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_118447_Desc = {
    Text = "Lễ tế đã bắt đầu.\nDưới pháo hoa linh hồn và lời cầu nguyện bằng máu, vô số tín đồ hóa linh hồn thành hải đăng——\nNhững linh hồn mờ ảo phân tán xung quanh bạn, như những tinh linh dẫn đường, lấp lánh chờ đợi sự lựa chọn của bạn."
  },
  Event_118447_Name = {
    Text = "Linh hồn hải đăng"
  },
  Event_118448_ChoiceDesc1 = {
    Text = "[rời đi] bị nhiễm [(Skill.Arg1)], nhận được 50 dấu đen"
  },
  Event_118448_Desc = {
    Text = "\"Loài người ngu muội!\"\nGiọng nói đó phát ra lời phàn nàn bực bội, nhưng chưa đến mức giận dữ.\nBởi nó biết rõ, kẻ ngu muội tổng có lúc sẽ giác ngộ.\nNó chỉ cần chờ đợi ngày đó đến.\nVà trước khi ngày đó đến, khắc lên thân bạn dấu ấn của thần minh, xác nhận linh hồn bạn thuộc về ai."
  },
  Event_118448_Name = {
    Text = "Bài giảng của Kẻ Vô Hình"
  },
  Event_118449_ChoiceDesc1 = {Text = "[đi]"},
  Event_118449_Desc = {
    Text = "\"@2 của @3……\"\nKiến thức hỗn độn cùng với âm nhạc phỉ báng, đổ vào não bạn.\nNhưng cơ thể con người lại giới hạn bạn, khiến bạn không thể hiểu được tri thức đến từ vũ trụ.\nThật là một điều đáng tiếc bi thảm."
  },
  Event_118449_Name = {
    Text = "Âm sắc cấm kỵ"
  },
  Event_118450_ChoiceDesc1 = {
    Text = "[rời đi] bị nhiễm [(Skill.Arg1)], nhận được 50 dấu đen"
  },
  Event_118450_Desc = {
    Text = "\"Thực ra, ta cũng có một sự thật về thế giới muốn kể cho ngươi...\"\n \"Thế giới được tạo ra bởi Thần Mì Ý Bay có đôi mắt thịt viên thông minh, và những sợi mì tượng trưng cho năng lực vô hạn...\"\nBạn nghiêm túc bịa đặt những câu chuyện vui nghe được, chờ đợi phản ứng của đối phương.\nNhưng qua rất lâu, phía bên kia không có động tĩnh gì.\n \"Hài, xem ra kẻ cuồng tín không hiểu được sự hài hước.\"\nBạn thở dài, đành phải rời đi."
  },
  Event_118450_Name = {
    Text = "Bài giảng của Kẻ Vô Hình"
  },
  Event_118451_ChoiceDesc1 = {Text = "[đi]"},
  Event_118451_Desc = {
    Text = "Sự điều chỉnh của bạn không khiến những âm tiết hỗn loạn trở nên hòa hợp.\nNhưng ít nhất, ý chí vô hình đã thấy được nỗ lực của bạn.\nĐây là một khởi đầu tốt."
  },
  Event_118451_Name = {
    Text = "Thánh ca \"Hoàn mỹ\""
  },
  Event_118452_ChoiceDesc1 = {Text = "[đi]"},
  Event_118452_Desc = {
    Text = "Ba bóng người run rẩy, nức nở không thành tiếng.\nTín ngưỡng của chúng bị bạn nghi ngờ, và đây, là sự xúc phạm mà kẻ cuồng tín không thể dung thứ nhất."
  },
  Event_118452_Name = {
    Text = "Lễ vật tốt nhất"
  },
  Event_118453_ChoiceDesc1 = {Text = "[đi]"},
  Event_118453_Desc = {
    Text = "Trong hình ảnh của tương lai, cô gái mọc ra xúc tu kiêu ngạo liếc nhìn bạn một cái, cất tiếng quát mắng.\n \"Dung mạo thật sự của Thần Mẫu không được phép xúc phạm.\"\nThế là, hình ảnh biến mất, khe nứt thời không cũng đóng lại trong nháy mắt. Chỉ còn lại bạn hồi tưởng lại cảnh tượng vừa rồi."
  },
  Event_118453_Name = {
    Text = "Khe Nứt Thời Không"
  },
  Event_118454_ChoiceDesc1 = {Text = "[đi]"},
  Event_118454_Desc = {
    Text = "Bạn đã thoát khỏi những kẻ đạp biển thành công, tiếp tục lao về phía trước.\nTrên đầu bạn, quần tinh lặng lẽ tỏa sáng, giống như hàng ngàn năm qua."
  },
  Event_118454_Name = {
    Text = "Chờ đợi dưới quần tinh"
  },
  Event_118455_ChoiceDesc1 = {Text = "[đi]"},
  Event_118455_Desc = {
    Text = "Thực thể vô danh không ngăn cản bạn.\n \"Tổng có một ngày, ngươi sẽ quay lại.\"\n \"Không ai có thể từ chối vận mệnh.\""
  },
  Event_118455_Name = {
    Text = "Cuộc cờ vận mệnh"
  },
  Event_118456_ChoiceDesc1 = {Text = "[đi]"},
  Event_118456_Desc = {
    Text = "Dưới động tác dứt khoát, đôi tay ấy buông thõng bất lực.\nNhưng bạn không bỏ lỡ tiếng thở dài cuối cùng của đối phương.\nHắn cuối cùng cũng thực sự giải thoát khỏi dục vọng vô tận của chính mình."
  },
  Event_118456_Name = {
    Text = "Dục vọng trói buộc"
  },
  Event_118457_ChoiceDesc1 = {Text = "[đi]"},
  Event_118457_Desc = {
    Text = "Không được cảm nhận là định mệnh tất yếu của thế gian.\nKhông ai có thể hoàn toàn đồng cảm với một sinh mệnh khác."
  },
  Event_118457_Name = {
    Text = "Oán thán không ai cảm nhận"
  },
  Event_118458_ChoiceDesc1 = {
    Text = "[Lắng nghe bài hát] nhận được 35 dấu đen, nhiễm [(Skill.Arg2)], tiếp tục chọn"
  },
  Event_118458_ChoiceDesc2 = {
    Text = "[bỏ mặc] rời đi"
  },
  Event_118458_Desc = {
    Text = "Con quạ đen đang khóc.\nCon quạ đen đang gào thét.\nCon quạ đen đang cuồng hú.\nNhưng trong tai người ta, nó chỉ đang hát.\n \"Ah, giọng hát thật vô tư lự làm sao. Thật ước gì tôi cũng là một con quạ, tránh xa phiền não nhân gian.\""
  },
  Event_118458_Name = {
    Text = "Oán thán không ai cảm nhận"
  },
  Event_118459_ChoiceDesc1 = {
    Text = "[Lắng nghe] nhận được bạc tạo vật \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_118459_ChoiceDesc2 = {
    Text = "[Bịt tai] nhận được khắcăng chọn 1 trong 3"
  },
  Event_118459_Desc = {
    Text = "Trong cơn cuồng loạn vô hình, bạn dường như nhìn thấy một cây đàn piano.\nCó một đôi tay không rõ hình dạng, nhảy múa trên những phím đàn vô hình, tấu lên những giai điệu phạm thượng.\nÂm nhạc kỳ quái vang lên từ sâu thẳm linh hồn bạn, qua đường dây mạch máu, truyền thẳng đến bộ não đang run rẩy của bạn."
  },
  Event_118459_Name = {
    Text = "Âm sắc cấm kỵ"
  },
  Event_118460_ChoiceDesc1 = {Text = "[đi]"},
  Event_118460_Desc = {
    Text = "Những cảm hứng, ảo tưởng và cuồng tưởng hòa trộn vào nhau, pha thành màu sắc rực rỡ nhất thế gian.\nBạn thấy không gian gấp lại bên trong cơ thể mình, thời gian xoay vòng theo ý muốn của bạn.\nLúc này, bạn thấu suốt thời không, toàn năng, toàn tri.\nTất nhiên, bạn cũng phải trả giá."
  },
  Event_118460_Name = {
    Text = "Kính vạn hoa tư duy"
  },
  Event_118461_ChoiceDesc1 = {Text = "[đi]"},
  Event_118461_Desc = {
    Text = "Linh hồn hỗn loạn dùng tiếng gào khóc sắc nhọn chỉ dẫn con đường phía trước cho bạn.\nĐó có phải con đường an toàn không? Bạn không biết.\nLựa chọn duy nhất của bạn, chỉ là tiếp tục tiến về phía trước."
  },
  Event_118461_Name = {
    Text = "Linh hồn hải đăng"
  },
  Event_118462_ChoiceDesc1 = {
    Text = "[Lắng nghe bài hát] nhận được 40 dấu đen, nhiễm [(Skill.Arg2)], tiếp tục chọn"
  },
  Event_118462_ChoiceDesc2 = {
    Text = "[ bỏ mặc ] nhận được 25 dấu đen, rời đi"
  },
  Event_118462_Desc = {
    Text = "Con quạ đen đang khóc.\nCon quạ đen đang gào thét.\nCon quạ đen đang cuồng hú.\nNhưng trong tai người ta, nó chỉ đang hát.\n \"Ah, giọng hát thật vô tư lự làm sao. Thật ước gì tôi cũng là một con quạ, tránh xa phiền não nhân gian.\""
  },
  Event_118462_Name = {
    Text = "Oán thán không ai cảm nhận"
  },
  Event_118463_ChoiceDesc1 = {Text = "[đi]"},
  Event_118463_Desc = {
    Text = "Linh hồn hỗn loạn phát ra một tiếng thở dài ai oán.\nNó dần tan biến, nhưng tiếng thở dài ai oán ấy, như có thực chất, rơi xuống trái tim bạn.\nThình thịch, nhịp tim bạn vang lên cùng tần số với âm nhạc của lễ tế."
  },
  Event_118463_Name = {
    Text = "Linh hồn hải đăng"
  },
  Event_118464_ChoiceDesc1 = {
    Text = "[rời đi] nhận được bạc tạo vật [(RelicConfig.Arg1)]"
  },
  Event_118464_Desc = {
    Text = "\"A, a, đây là một con chiên ngoan đạo biết bao!\"\nGiọng nói đó cảm thán, tràn đầy niềm cuồng hỷ tán dương.\n \"Khi chúa tể của ta tỉnh giấc, một con chiên như ngươi nhất định sẽ tìm được một chỗ dung thân trong vương quốc thần thánh cao quý và vĩ đại ấy...\""
  },
  Event_118464_Name = {
    Text = "Bài giảng của Kẻ Vô Hình"
  },
  Event_118465_ChoiceDesc1 = {Text = "[đi]"},
  Event_118465_Desc = {
    Text = "\"Bầu trời\" bao dung sự ngang bướng của bạn.\nTổng có một ngày, đứa trẻ lạc đường sẽ trở về vòng tay mẹ.\nBởi vì, bạn không nơi nào để trốn."
  },
  Event_118465_Name = {
    Text = "Vòng tay đại dương"
  },
  Event_118466_ChoiceDesc1 = {
    Text = "[Chấp nhận vòng tay] nhận được bạc tạo vật \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_118466_ChoiceDesc2 = {
    Text = "[Từ chối vòng tay] nhận được bạc tạo vật \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_118466_ChoiceDesc3 = {
    Text = "[bơi lên mặt nước] nhận được 25 dấu đen"
  },
  Event_118466_Desc = {
    Text = "Thế giới đảo lộn trong mắt bạn.\nLúc này, biển sâu bao quanh bạn mới là \"bầu trời\".\nTrong nỗi đau gần như chết đuối, \"bầu trời\" xanh thẳm này dịu dàng tiến lại, muốn ôm bạn vào lòng.\nNó không phán xét, chỉ cho đi."
  },
  Event_118466_Name = {
    Text = "Vòng tay đại dương"
  },
  Event_118467_ChoiceDesc1 = {
    Text = "[Quát mắng chúng] nhận được vật bị nguyền rủa \"(RelicConfig.Arg1)\", bị ảnh hưởng bởi \"(Skill.Arg2)\""
  },
  Event_118467_ChoiceDesc2 = {
    Text = "[Hồi đáp chúng] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: [(EnchantConfig.Arg1)]"
  },
  Event_118467_ChoiceDesc3 = {
    Text = "[Phớt lờ chúng] nhận được 50 dấu đen"
  },
  Event_118467_Desc = {
    Text = "Ba linh hồn hình dạng mờ ảo chắn đường bạn.\nMột bóng người thành kính cúi chào bạn, khẩn cầu bạn ban cho máu tươi. Dòng máu chảy trong bạn là lễ vật tốt nhất dâng lên thần.\nMột bóng người lạnh lùng giơ dao về phía bạn, định cắt lấy thịt xương bạn. Thịt người chưa biến dị ấy chắc chắn sẽ chiếm được sự ưu ái của thần.\nBóng người cuối cùng chỉ im lặng nhìn bạn, mong bạn lấy đi mạng sống của mình, để chứng minh đức tin thành kính nhất."
  },
  Event_118467_Name = {
    Text = "Lễ vật tốt nhất"
  },
  Event_118468_ChoiceDesc1 = {
    Text = "[Lắng nghe bài hát] nhận được 30 dấu đen, nhiễm [(Skill.Arg2)], tiếp tục chọn"
  },
  Event_118468_ChoiceDesc2 = {
    Text = "[bỏ mặc] rời đi"
  },
  Event_118468_Desc = {
    Text = "Con quạ đen đang khóc.\nCon quạ đen đang gào thét.\nCon quạ đen đang cuồng hú.\nNhưng trong tai người ta, nó chỉ đang hát.\n \"Ah, giọng hát thật vô tư lự làm sao. Thật ước gì tôi cũng là một con quạ, tránh xa phiền não nhân gian.\""
  },
  Event_118468_Name = {
    Text = "Oán thán không ai cảm nhận"
  },
  Event_118469_ChoiceDesc1 = {
    Text = "[đi khỏi] nhiễm [(Skill.Arg1)]"
  },
  Event_118469_ChoiceDesc2 = {
    Text = "[đi khỏi] nhiễm [(Skill.Arg1)]"
  },
  Event_118469_ChoiceDesc3 = {
    Text = "[đi khỏi] nhiễm [(Skill.Arg1)]"
  },
  Event_118469_Desc = {
    Text = "\"Không! Chúng tao không cần những thứ này! Chúng tao muốn thứ... ngon hơn.\"\n \"Đó chính là... thịt và máu của ngươi!\"\nBầy chuột phát ra tiếng kêu chói tai, ùa về phía bạn.\nCó vẻ lòng tốt tràn lan, đôi khi lại gây ra rắc rối."
  },
  Event_118469_Name = {
    Text = "Bầy chuột đói"
  },
  Event_118470_ChoiceDesc1 = {Text = "[đi]"},
  Event_118470_Desc = {
    Text = "Sự tôn trọng của bạn đã giành được thiện cảm từ những đôi mắt đó.\nTrước khi biến mất, chúng gửi tặng bạn một món quà xuyên qua làn nước cuộn trào.\nĐó là vật chứng của biển sâu thuần phục bạn."
  },
  Event_118470_Name = {
    Text = "Mắt biển sâu"
  },
  Event_118471_ChoiceDesc1 = {Text = "[đi]"},
  Event_118471_Desc = {
    Text = "Dưới ánh mắt không che giấu của bạn, biển sâu từ từ tỉnh giấc.\nNước biển cuồng loạn cuộn trào xung quanh bạn, mang theo những lời mê sảng không thể gọi tên.\nHãy cảm nhận cơn thịnh nộ của biển sâu, đây vừa là phúc lành, vừa là lời nguyền."
  },
  Event_118471_Name = {
    Text = "Mắt biển sâu"
  },
  Event_118472_ChoiceDesc1 = {
    Text = "[Lắng nghe bài hát] để nhận 20 dấu đen, nhiễm [(Skill.Arg2)]"
  },
  Event_118472_ChoiceDesc2 = {
    Text = "[bỏ mặc] rời đi"
  },
  Event_118472_Desc = {
    Text = "Con quạ đen đang khóc.\nCon quạ đen đang gào thét.\nCon quạ đen đang cuồng hú.\nNhưng trong tai người ta, nó chỉ đang hát.\n \"Ah, giọng hát thật vô tư lự làm sao. Thật ước gì tôi cũng là một con quạ, tránh xa phiền não nhân gian.\""
  },
  Event_118472_Name = {
    Text = "Oán thán không ai cảm nhận"
  },
  Event_118473_ChoiceDesc1 = {Text = "[đi]"},
  Event_118473_Desc = {
    Text = "Máu tươi, thịt vụn, sinh mạng.\nLễ vật đã được chuẩn bị xong, tiếp theo chỉ cần lặng lẽ chờ đợi bữa tiệc của thần."
  },
  Event_118473_Name = {
    Text = "Lễ vật tốt nhất"
  },
  Event_118474_ChoiceDesc1 = {Text = "[đi]"},
  Event_118474_Desc = {
    Text = "Con bướm hiểu được sự từ chối của bạn.\nĐôi cánh dính đầy dung dịch đen lại rung động, chao đảo bay lượn trong bóng tối.\nRất nhanh, bóng tối lại nuốt chửng con bướm. Lần này, nó không còn sức để vùng vẫy."
  },
  Event_118474_Name = {
    Text = "Thỉnh Cầu Của Bướm"
  },
  Event_118475_ChoiceDesc1 = {Text = "[đi]"},
  Event_118475_Desc = {
    Text = "Con bướm đậu xuống lòng bàn tay bạn, cùng rơi xuống là dung dịch đen sền sệt trên đôi cánh rực rỡ.\nTrong tiếng thở dài của bạn, đôi cánh rực rỡ dần tan chảy, hòa quyện với dung dịch đen thành hình dạng hỗn độn chưa từng biết.\nCon bướm này không còn phải trải qua bóng tối nữa.\nNó an giấc trong lòng bàn tay bạn."
  },
  Event_118475_Name = {
    Text = "Thỉnh Cầu Của Bướm"
  },
  Event_118477_ChoiceDesc1 = {Text = "[đi]"},
  Event_118477_Desc = {
    Text = "Con quạ khàn giọng cuối cùng cũng nhắm mắt lại.\nTrong oán hận không ai hay biết, không ai cảm nhận, nó nuốt hơi thở cuối cùng, hóa thành một vũng chất lỏng đen đặc."
  },
  Event_118477_Name = {
    Text = "Oán thán không ai cảm nhận"
  },
  Event_118478_ChoiceDesc1 = {Text = "[đi]"},
  Event_118478_Desc = {
    Text = "\"Cảm ơn bạn...\"\nTrái tim đang đập nhảy vui mừng chạy về phía xa.\nKhông lâu sau, từ đáy biển sâu tối đen vọng lại tiếng nhai nghiền thịt xương."
  },
  Event_118478_Name = {
    Text = "Mạnh Được Yếu Thua"
  },
  Event_118479_ChoiceDesc1 = {
    Text = "[Chấp nhận lời mời] nhiễm \"(Skill.Arg1)\", nhận được vật bị nguyền rủa-\"(RelicConfig.Arg2)\""
  },
  Event_118479_ChoiceDesc2 = {
    Text = "[Từ chối lời mời] chọn hủy bỏ 1 sáng tạo, nhận được 1 phần thưởng"
  },
  Event_118479_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 50 dấu đen"
  },
  Event_118479_Desc = {
    Text = "\"Mọi thứ trên con tàu này, đều phải trở thành một phần của vòng tuần hoàn lạc viên không ngừng tan rã rồi tái khởi.\"\nÂm nhạc cuồng loạn vang lên trong tâm trí bạn, đó là sự khai sáng từ ý chí vô hình.\n \"Nơi đây không có khóc lóc, không có bi thương, chỉ có thánh nhạc thuần khiết và tiếng cười vĩnh hằng.\"\n \"Bạn có muốn gia nhập lạc viên, trở thành một phần của bản nhạc hoàn mỹ này không?\""
  },
  Event_118479_Name = {
    Text = "Thánh ca \"Hoàn mỹ\""
  },
  Event_118480_ChoiceDesc1 = {Text = "[đi]"},
  Event_118480_Desc = {
    Text = "Trong sự im lặng của bạn, các linh hồn lặng lẽ tan biến.\nKẻ không hiểu tín ngưỡng, không đáng để chúng lãng phí thời gian."
  },
  Event_118480_Name = {
    Text = "Lễ vật tốt nhất"
  },
  Event_123616_ChoiceDesc1 = {
    Text = "[Nhận di vật tiêu chuẩn]"
  },
  Event_123616_Desc = {
    Text = "Đặt tất cả thể thức tỉnh điên cuồng thành 100, chìa khóa bạc thành 1000, sinh lực thành 80%.\nLoại bỏ 2 thẻ bài, đặt vào 3 thẻ triệu chứng.\nLò nung đỏ thẫm đặt thành 12.5%, chọn 4 thẻ bài đặt vào khoảng không gian siêu việt.\nNhận gói di vật tiêu chuẩn."
  },
  Event_123616_Name = {
    Text = "Bỏ qua đường đi bằng một nút"
  },
  Event_125696_ChoiceDesc1 = {Text = "[đi]"},
  Event_125696_Desc = {
    Text = "Cơn giận dữ vô cớ thúc đẩy ngươi, ngươi giơ tay lên, ra sức xua đuổi. Ngươi đã dừng lại quá lâu trong câu đố, có lẽ điều ngươi khao khát là một trận chiến đau đớn sảng khoái, thậm chí chỉ là khao khát sự kết thúc……\nNhưng bầy quạ chẳng làm gì. Dưới ánh mắt ngươi, vực sâu tan biến.\nBầy quạ biến mất ở cuối sân khấu, nơi mà ngươi sắp đến."
  },
  Event_125696_Name = {
    Text = "Vực Sâu Bầy Quạ"
  },
  Event_125697_ChoiceDesc1 = {Text = "[đi]"},
  Event_125697_Desc = {
    Text = "\"Nhát gan.\" Giọng nữ không hề che giấu sự chế giễu trong tiếng cười của cô ta.\n \"Đi đi, đi càng xa càng tốt.\""
  },
  Event_125697_Name = {
    Text = "Khóa Số Mệnh"
  },
  Event_125698_ChoiceDesc1 = {
    Text = "[Xua đuổi] Chọn 1 trong 3 thẻ lệnh nhận được Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_125698_ChoiceDesc2 = {
    Text = "[Lắng nghe]Nhận tạo vật Bạc「(RelicConfig.Arg1)」, nhiễm「(Skill.Arg2)」"
  },
  Event_125698_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_125698_Desc = {
    Text = "Trong bóng tối vọng đến tiếng động nhẹ. Một con bướm rơi vào lòng bàn tay ngươi. Ngươi nhớ nó.\n \"Tiểu thư Arachne... người chưa bao giờ bỏ rơi chúng tôi, đúng không?\"\nHoa văn tuyệt đẹp của bướm, nhìn về phía người bên cạnh ngươi."
  },
  Event_125698_Name = {
    Text = "Quãng đời còn lại của bướm"
  },
  Event_125699_ChoiceDesc1 = {Text = "[đi]"},
  Event_125699_Desc = {
    Text = "Âm thanh và chữ viết ấy như bầy ong xâm nhập vào tâm trí ngươi. Ngươi nín thở tập trung, gạt bỏ những tạp niệm vô dụng ra khỏi đầu.\nPhớt lờ khó hơn đọc rất nhiều rất nhiều, nhưng ngươi đã làm được."
  },
  Event_125699_Name = {
    Text = "Điện báo chiều không gian"
  },
  Event_125700_ChoiceDesc1 = {Text = "[đi]"},
  Event_125700_Desc = {
    Text = "Đó là ảo giác do kẻ thù tạo ra!\nNgươi lắc đầu, tỉnh táo trở lại, một lần nữa nắm chặt Chìa Khóa Bạc trong tay."
  },
  Event_125700_Name = {
    Text = "Bóng Hình Trong Rượu"
  },
  Event_125701_ChoiceDesc1 = {Text = "[đi]"},
  Event_125701_Desc = {
    Text = "Ngươi chăm chú nhìn vào đôi mắt ấy, cố gắng quan sát, lắng nghe. Ngươi thử bước vào nội tâm của diễn viên, thấu hiểu nỗi thống khổ hắn đang trải qua.\nNgươi tiến lại gần, gần hơn. Ngươi xuyên qua thân xác hắn, chạm đến linh hồn hắn…\nNgươi bừng mở mắt, phát hiện mình đang đứng giữa sân khấu, nước mắt chảy dài theo đầu ngón tay.\nĐó là lời tự bạch ngươi dâng hiến cho khán giả."
  },
  Event_125701_Name = {
    Text = "Lời Tự Bạch Của Diễn Viên"
  },
  Event_125702_ChoiceDesc1 = {
    Text = "[Thảo luận với cô ấy]Xóa 1 lá bài chỉ lệnh, nhận được Arg1 hắc ấn"
  },
  Event_125702_ChoiceDesc2 = {
    Text = "[Im lặng không nói]"
  },
  Event_125702_Desc = {
    Text = "\"Kết cục vui vẻ cố nhiên tốt đẹp, nhưng niềm vui giả tạo ấy, mãi mãi không thể chạm đến trái tim khán giả…\"\nNhà soạn kịch nhắm mắt trầm tư. Cô ấy không hài lòng với kết cục này."
  },
  Event_125702_Name = {
    Text = "Kết cục của vở kịch"
  },
  Event_125703_ChoiceDesc1 = {
    Text = "[Lắng nghe bài hát] nhận được 35 dấu đen, nhiễm [(Skill.Arg2)], tiếp tục chọn"
  },
  Event_125703_ChoiceDesc2 = {
    Text = "[bỏ mặc] rời đi"
  },
  Event_125703_Desc = {
    Text = "\"Kẽo kẹt— kẽo kẹt— nữ thần số phận quay chiếc xa kéo sợi.\nKẽo kẹt— kẽo kẹt— sợi chỉ số phận hội tụ trong tay nàng.\""
  },
  Event_125703_Name = {
    Text = "Lời tiên tri cuối cùng"
  },
  Event_125704_ChoiceDesc1 = {
    Text = "[Chính mình]Lấy ngẫu nhiên 3 thẻ chỉ lệnh từ bộ bài, chọn 1 thẻ để sao chép"
  },
  Event_125704_ChoiceDesc2 = {
    Text = "[William] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", lây nhiễm \"(Skill.Arg2)\""
  },
  Event_125704_ChoiceDesc3 = {
    Text = "[Chẳng là ai]Nhận 25 Hắc Ấn"
  },
  Event_125704_Desc = {
    Text = "Ngươi chắc chắn mình chưa say, nhưng khi nhìn vào ly rượu, ngươi chìm vào một hồ nước tĩnh lặng.\nTrong chiếc ly thanh nhã phản chiếu một bóng hình, đó là ai?"
  },
  Event_125704_Name = {
    Text = "Bóng Hình Trong Rượu"
  },
  Event_125705_ChoiceDesc1 = {
    Text = "[Lắng nghe]Nhận tạo vật bạc \"(RelicConfig.Arg1)\""
  },
  Event_125705_ChoiceDesc2 = {
    Text = "[Xua đuổi]Nhận 75 Hắc Ấn, nhiễm \"(Skill.Arg2)\""
  },
  Event_125705_Desc = {
    Text = "Khi ngươi tiếp cận sức mạnh của Plasmid trong cơ thể, một đàn quạ xuất hiện trong tâm trí ngươi, lượn vòng trong không gian tinh thần hỗn loạn của ngươi.\n\nBầy quạ vây quanh ngươi, một vực thẳm đảo ngược xoay chuyển trên đỉnh đầu ngươi.\nMười vạn con quạ đồng loạt kêu lên, như một lời tiên tri đầy chế giễu."
  },
  Event_125705_Name = {
    Text = "Vực Sâu Bầy Quạ"
  },
  Event_125706_ChoiceDesc1 = {Text = "[đi]"},
  Event_125706_Desc = {
    Text = "Ngươi cùng Arachne cố gắng ổn định vận mệnh đang sụp đổ bên cạnh. Nỗ lực của các ngươi chẳng mấy hiệu quả, nhưng thế là đủ rồi. Tận dụng thời gian giành được, các ngươi tiếp tục tiến về phía Nephrea.\nNgươi đến đây, là để mang sự giải thoát đến cho nàng."
  },
  Event_125706_Name = {
    Text = "Lưới Vận Mệnh hạ màn"
  },
  Event_125707_ChoiceDesc1 = {
    Text = "[Lắng nghe bài hát] để nhận 20 dấu đen, nhiễm [(Skill.Arg2)]"
  },
  Event_125707_ChoiceDesc2 = {
    Text = "[bỏ mặc] rời đi"
  },
  Event_125707_Desc = {
    Text = "\"Chúng cùng tấm lưới khổng lồ chết đi, lặng lẽ không một tiếng động.\""
  },
  Event_125707_Name = {
    Text = "Lời tiên tri cuối cùng"
  },
  Event_125708_ChoiceDesc1 = {Text = "[đi]"},
  Event_125708_Desc = {
    Text = "Đó là một bức điện báo gửi đến Uyên Ngục.\n \"Đừng vội vàng, những đứa con của ta. Cánh cửa ngục tù sắp mở ra, tự do của các ngươi sắp đến rồi.\""
  },
  Event_125708_Name = {
    Text = "Điện báo chiều không gian"
  },
  Event_125709_ChoiceDesc1 = {
    Text = "[Xua đuổi] 1 thẻ lệnh ngẫu nhiên nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_125709_ChoiceDesc2 = {
    Text = "[Lắng nghe]Chọn 1 trong 3 lá bài chỉ lệnh để nhận khắc ấn:「(EnchantConfig.Arg1)」"
  },
  Event_125709_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_125709_Desc = {
    Text = "Một con bướm nhẹ nhàng đậu trên tay ngươi. Hoa văn tuyệt đẹp như đôi mắt, lặng lẽ nhìn ngươi.\nCó lẽ, nó muốn nói với ngươi điều gì đó?"
  },
  Event_125709_Name = {
    Text = "Giấc nghỉ của bướm"
  },
  Event_125710_ChoiceDesc1 = {Text = "[đi]"},
  Event_125710_Desc = {
    Text = "Hai mươi đôi mắt bi thương nhìn về phía ngươi. Quạ ngừng hót, mang theo lời tiên tri cuối cùng rời khỏi tấm lưới chực sụp đổ này."
  },
  Event_125710_Name = {
    Text = "Lời tiên tri cuối cùng"
  },
  Event_125711_ChoiceDesc1 = {
    Text = "[gập người thò ra] nhiễm \"(Skill.Arg1)\", nhận được vật sáng tạo vàng \"(RelicConfig.Arg2)\""
  },
  Event_125711_ChoiceDesc2 = {
    Text = "[bỏ qua xem] nhận được 50 dấu đen"
  },
  Event_125711_Desc = {
    Text = "Khi đi qua góc phố, bạn nhìn thấy một rạp chiếu phim giản dị. Bạn không nhớ Londinium từng có một cửa hàng như thế này."
  },
  Event_125711_Name = {
    Text = "Rạp chiếu ký ức"
  },
  Event_125712_ChoiceDesc1 = {
    Text = "[Chấp nhận định mệnh]Chọn 1 trong 3 thẻ chỉ lệnh để nhận khắc ấn: \"(EnchantConfig.Arg1)\""
  },
  Event_125712_ChoiceDesc2 = {
    Text = "[Phản kháng định mệnh]Nhiễm \"(Skill.Arg1)\", khắc ấn lại, tối đa 2 lần"
  },
  Event_125712_Desc = {
    Text = "\"Ah, chúng ta lại gặp nhau rồi, người thân mến.\"\nNgươi bắt đầu thưởng thức giọng nữ trẻ trung vang vọng trong đầu. Nó dịu dàng, quyến rũ, như tấm lưới bẫy côn trùng.\n\"Nào, hãy nói cho ta, ngươi có sẵn lòng chấp nhận số phận của mình không?\""
  },
  Event_125712_Name = {
    Text = "Lồng Giam Định Mệnh"
  },
  Event_125713_ChoiceDesc1 = {Text = "[đi]"},
  Event_125713_Desc = {
    Text = "\"Con người ngu ngốc, ta có quen ngươi lắm sao?\"\nMèo đen khinh bỉ liếc ngươi một cái, rồi quay lưng đi.\n \"Rời khỏi đây đi. Lần sau đừng làm chuyện ngu ngốc như vậy nữa.\""
  },
  Event_125713_Name = {
    Text = "Huyễn Hóa Dịch Hình"
  },
  Event_125714_ChoiceDesc1 = {
    Text = "[Chụp ảnh]Chọn 1 trong 3 lá bài chỉ lệnh để nhận khắc ấn: \"(EnchantConfig.Arg1)\""
  },
  Event_125714_ChoiceDesc2 = {
    Text = "[Đổi tư thế]Nhiễm \"(Skill.Arg1)\", thay đổi khắc ấn nhận được ở lựa chọn 1, có thể sử dụng hai lần"
  },
  Event_125714_Desc = {
    Text = "Một chiếc máy ảnh đứng cô đơn trên sân khấu, ống kính đen thẫm nhìn về phía ngươi, như đôi mắt kép huyền bí được tạo ra bởi vị thần cơ khí.\n\"Nhà hát này đã rất lâu không có khán giả rồi... Chào mừng! Chào mừng! Hãy chụp một tấm ảnh nào! Hoàn toàn miễn phí!\"\nChiếc máy ảnh hào hứng hét lên. Trên sân khấu không ai quan tâm này, nó là nhân vật chính duy nhất."
  },
  Event_125714_Name = {
    Text = "Bức ảnh lưu niệm từ khán đài"
  },
  Event_125715_ChoiceDesc1 = {Text = "[đi]"},
  Event_125715_Desc = {
    Text = "\"Người không có nghi vấn gì về số mệnh, thì làm sao mong đợi câu trả lời từ số mệnh đây?\""
  },
  Event_125715_Name = {
    Text = "Khóa Số Mệnh"
  },
  Event_125716_ChoiceDesc1 = {
    Text = "[Suy nghĩ phá cục]Nhận Di vật Bạc「(RelicConfig.Arg1)」, nhiễm「(Skill.Arg2)」"
  },
  Event_125716_ChoiceDesc2 = {
    Text = "[Thuận theo tự nhiên]Nhận Di vật Vàng「(RelicConfig.Arg1)」, nhiễm「(Skill.Arg2)」,「(Skill.Arg3)」"
  },
  Event_125716_ChoiceDesc3 = {
    Text = "[lên mặt nước] nhận được 25 dấu đen"
  },
  Event_125716_Desc = {
    Text = "Một sân khấu mới, hai cuộc đời chồng chéo… Trên đường trốn tránh cảnh sát, ngươi sắp xếp lại những điều Arachne đã kể cho ngươi.\nGiữa dòng suy nghĩ phức tạp, ngươi chìm vào đáy biển yên tĩnh."
  },
  Event_125716_Name = {
    Text = "Thanh thản"
  },
  Event_125717_ChoiceDesc1 = {Text = "[đi]"},
  Event_125717_Desc = {
    Text = "Con bướm bay lên vai ngươi, ghé sát bên tai. Ngươi chăm chú lắng nghe, nhưng chỉ nghe thấy tiếng cánh khẽ rung, như tiếng thở dài vô thanh.\nTrong lúc ngươi lắng nghe, đôi cánh rực rỡ dần tan chảy, con bướm yên giấc trên vai ngươi.\nNgươi không bao giờ có thể biết được điều nó muốn nói với ngươi."
  },
  Event_125717_Name = {
    Text = "Quãng đời còn lại của bướm"
  },
  Event_125718_ChoiceDesc1 = {
    Text = "[Nhai]Ngẫu nhiên thức tỉnh 1 Thể Hoán Tỉnh, nhiễm「(Skill.Arg1)」"
  },
  Event_125718_ChoiceDesc2 = {
    Text = "[Từ chối]nhận 3 chọn 1 Lời cầu nguyện"
  },
  Event_125718_Desc = {
    Text = "\"Đói rồi phải không, vị khách thân mến?\"\nMột giọng nói nhớt nhát vang lên từ phía sau quầy bar. Ngươi quay lại, không thấy bất cứ thứ gì.\n \"Đồ ăn nhẹ của quán bar Mặt Nạ Nửa Đêm cũng nổi tiếng gần xa đấy. Muốn thử không?\""
  },
  Event_125718_Name = {
    Text = "Hương Vị Số Mệnh"
  },
  Event_125719_ChoiceDesc1 = {Text = "[đi]"},
  Event_125719_Desc = {
    Text = "Bạn không dám tùy tiện đọc những dòng chữ trên đó, chỉ quan sát kỹ chiếc phong bì tinh xảo.\nDấu sáp trên phong bì khắc một huy hiệu gia tộc mờ nhạt, phía trên viết bằng nét chữ hoa mỹ:\n\"Gửi tiểu thư Arachne mới chào đời.\"\n\"Quản gia trung thành của ngài, Edgar.\""
  },
  Event_125719_Name = {
    Text = "Chúc ngủ ngon, ngài Edgar"
  },
  Event_125720_ChoiceDesc1 = {Text = "[đi]"},
  Event_125720_Desc = {
    Text = "\"Thì ra là vậy, ta hiểu rồi, chị…\"\n\"Nhà soạn kịch từ trước đến nay không thể viết lại kết cục của nhân vật. Số phận bi thảm ấy đã được định sẵn từ lâu, dù là chị, cũng chưa bao giờ có thể thay đổi…\"\nTiếng nấc nghẹn buồn bã biến mất. Máy đánh chữ của nhà soạn kịch hóa thành từng con bướm, tan vào nhà hát số phận trống vắng, không còn thấy dấu vết."
  },
  Event_125720_Name = {
    Text = "Kết cục của vở kịch"
  },
  Event_125721_ChoiceDesc1 = {Text = "[đi]"},
  Event_125721_Desc = {
    Text = "Diễn viên vô danh, vũ điệu nguy hiểm… thì đã sao? Chẳng có gì tệ hơn chính vận mệnh.\nNgươi chìa tay ra, bước lên sân khấu. Con rối nắm lấy tay ngươi, nhảy lên điệu múa hoan hỉ.\nNgươi nghe thấy tiếng vỗ tay."
  },
  Event_125721_Name = {
    Text = "Vũ Điệu Ba Người"
  },
  Event_125722_ChoiceDesc1 = {
    Text = "[Lắng nghe bài hát] nhận được 25 dấu đen, bị nhiễm [(Skill.Arg2)], tiếp tục chọn"
  },
  Event_125722_ChoiceDesc2 = {
    Text = "[bỏ mặc] rời đi"
  },
  Event_125722_Desc = {
    Text = "\"Chúng nhảy múa. Chúng ca hát. Kẽo kẹt— kẽo kẹt—\""
  },
  Event_125722_Name = {
    Text = "Lời tiên tri cuối cùng"
  },
  Event_125723_ChoiceDesc1 = {Text = "[đi]"},
  Event_125723_Desc = {
    Text = "Người dẫn đường, chiến hữu, người bạn đồng hành duy nhất trong chiều không gian cô độc.\nCác ngươi sẽ cùng nhau giải quyết mọi thứ ở đây, trở về Kadath. Ngươi chưa bao giờ nghi ngờ điều đó."
  },
  Event_125723_Name = {
    Text = "Bóng Hình Trong Rượu"
  },
  Event_125724_ChoiceDesc1 = {
    Text = "[Đặt cược] Áp dụng [(Skill.Arg1)], bước vào ván cược"
  },
  Event_125724_ChoiceDesc2 = {
    Text = "[thôi đi] nhận được 25 dấu đen"
  },
  Event_125724_Desc = {
    Text = "Ở góc phố trong con hẻm, một đôi tay bẩn thỉu chặn ngươi lại.\nMột kẻ ăn mày rách rưới lén lút tiến lại gần, ánh mắt tham lam như linh cẩu thấy xác thối.\n \"Đến! Chơi một ván đi! Ta sẽ nói cho ngươi biết tất cả những gì ngươi muốn biết! Chỉ cần ngươi thắng...\""
  },
  Event_125724_Name = {
    Text = "Canh Bạc Đường Phố"
  },
  Event_125725_ChoiceDesc1 = {
    Text = "[Phớt lờ]Xóa 1 lá bài chỉ lệnh, nhận 25 Ấn Đen"
  },
  Event_125725_ChoiceDesc2 = {
    Text = "[Đọc]Sao chép một lá bài trong bộ bài, nhiễm「(Skill.Arg1)」"
  },
  Event_125725_Desc = {
    Text = "Tạch tạch tạch, tạch tạch tạch……\nGóc quán bar trống không một bóng người, máy điện báo kêu lách tách trong trẻo, như một bản piano du dương."
  },
  Event_125725_Name = {
    Text = "Điện báo chiều không gian"
  },
  Event_125726_ChoiceDesc1 = {Text = "[đi]"},
  Event_125726_Desc = {
    Text = "\"Im đi, ta là một con mèo, ta không muốn nghe những câu chuyện ngu ngốc của các ngươi.\"\nMèo đen thở dài, quay lưng đi.\n \"Rời khỏi đây đi. Lần sau đừng làm chuyện ngu ngốc như vậy nữa.\""
  },
  Event_125726_Name = {
    Text = "Huyễn Hóa Dịch Hình"
  },
  Event_125727_ChoiceDesc1 = {Text = "[đi]"},
  Event_125727_Desc = {
    Text = "Có lẽ những gì nàng nói không sai, đó chính là ngươi, là suy nghĩ kín đáo và bẩn thỉu nhất trong sâu thẳm nội tâm ngươi.\nAi cũng ích kỷ, ngươi chưa bao giờ cao thượng như người khác nghĩ.\nNgươi nếm trải nỗi đau đớn đê hèn ấy. Ngươi biết quá khứ đã qua, và sự cứu chuộc của ngươi đang ở phía trước."
  },
  Event_125727_Name = {
    Text = "Khổ Đau Lan Tràn"
  },
  Event_125728_ChoiceDesc1 = {
    Text = "[Thảo luận với cô ấy]Xóa 1 lá bài chỉ lệnh, nhận được Arg1 hắc ấn"
  },
  Event_125728_ChoiceDesc2 = {
    Text = "[Im lặng không nói]"
  },
  Event_125728_Desc = {
    Text = "\"Kết cục bi tráng thật chân thực biết bao, nhưng hiện thực của chúng ta đã bi thảm đến vậy, ngay cả trong câu chuyện, chúng ta cũng không thể cho cô ấy một kết cục tốt đẹp sao…\"\nNhà soạn kịch nhắm mắt trầm tư. Cô ấy không hài lòng với kết cục này."
  },
  Event_125728_Name = {
    Text = "Kết cục của vở kịch"
  },
  Event_125729_ChoiceDesc1 = {
    Text = "[Rời đi] nhận được vật tạo vàng[(RelicConfig.Arg1)]"
  },
  Event_125729_Desc = {
    Text = "Lăn lăn, lăn lăn, viên xúc xắc hào hứng nhảy múa trong cốc xúc xắc, nhảy đến kiệt sức.\n\n \"Tại sao... tại sao mãi mãi không ai có thể thắng được!...\""
  },
  Event_125729_Name = {
    Text = "Canh Bạc Đường Phố"
  },
  Event_125730_ChoiceDesc1 = {Text = "[đi]"},
  Event_125730_Desc = {
    Text = "Ngươi cố gắng đến gần nó, chăm chú lắng nghe.\nCon bướm vỗ cánh, rời khỏi lòng bàn tay ngươi.\nNgươi chẳng nghe thấy gì cả."
  },
  Event_125730_Name = {
    Text = "Giấc nghỉ của bướm"
  },
  Event_125731_ChoiceDesc1 = {Text = "[đi]"},
  Event_125731_Desc = {
    Text = "Đối mặt với sự xua đuổi của ngươi, con bướm không hề lay động.\nNó kiên trì đuổi theo lòng bàn tay ngươi, cho đến lần cuối cùng ngươi vung tay, nó mới chịu rời đi.\nNgươi có chút hối hận. Có lẽ, ngươi nên lắng nghe lời nó?"
  },
  Event_125731_Name = {
    Text = "Giấc nghỉ của bướm"
  },
  Event_125732_ChoiceDesc1 = {Text = "[đi]"},
  Event_125732_Desc = {
    Text = "Làn khói đen thất vọng run rẩy, tiếng khóc đau đớn của kẻ ăn mày khản đặc.\nViên xúc xắc và kẻ ăn mày biến mất sau một cái chớp mắt của ngươi. Trong chiếc mũ chóp cũ kỹ, để lại phần thưởng của trò chơi."
  },
  Event_125732_Name = {
    Text = "Canh Bạc Đường Phố"
  },
  Event_125733_ChoiceDesc1 = {
    Text = "[Tham gia cuồng hoan]Nhiễm「(Skill.Arg1)」, nhận Di vật nguyền rủa -「(RelicConfig.Arg2)」"
  },
  Event_125733_ChoiceDesc2 = {
    Text = "[Ngăn chặn tấu nhạc]Chọn tiêu hủy 1 Di vật, nhận 1 phần thưởng"
  },
  Event_125733_ChoiceDesc3 = {
    Text = "[Bịt tai lại]Nhận 50 Hắc Ấn"
  },
  Event_125733_Desc = {
    Text = "\"A! Âm nhạc! Vở kịch vĩ đại sao có thể thiếu âm nhạc!!\"\nBản giao hưởng bất hòa vang lên trong nhà hát đổ nát, như một cuộc cuồng hoan hỗn loạn. Các diễn viên đến từ Uyên Ngục nhảy múa, hoan hô trong bài tụng ca vô trật tự này, đó là những nốt nhạc mà họ sống dựa vào."
  },
  Event_125733_Name = {
    Text = "Tụng Ca Số Mệnh"
  },
  Event_125734_ChoiceDesc1 = {
    Text = "[ Nhận được 100 dấu đen ]"
  },
  Event_125734_ChoiceDesc2 = {
    Text = "[2 thẻ lệnh ngẫu nhiên nhận Khắc ấn: \"(EnchantConfig.Arg1)\"]"
  },
  Event_125734_Desc = {
    Text = "Những sợi tơ số mệnh vô hình nhảy múa trong nốt nhạc, giữa những âm thanh hỗn loạn đó, ngươi dần nắm bắt được giai điệu mê hoặc ấy — đúng vậy, đó chính là âm thanh mà số mệnh nên có.\nNhững kẻ bị Uyên Ngục ruồng bỏ hoan hô ngươi, họ vây quanh ngươi, đưa ngươi vào cuộc cuồng hoan vô trật tự của họ.\nChúc mừng ngươi, khán giả may mắn! Giờ đây, ngươi sẽ cùng các diễn viên cúi chào số mệnh."
  },
  Event_125734_Name = {
    Text = "Tụng Ca Số Mệnh"
  },
  Event_125735_ChoiceDesc1 = {Text = "[đi]"},
  Event_125735_Desc = {
    Text = "Ngươi không thể nhận ra ý nghĩa của âm thanh này, nhưng ngươi biết, nó phải dừng lại.\nÁnh bạc như lưỡi dao phát cuồng chém xuống, nhịp điệu ấy lại khớp hoàn hảo với nốt nhạc.\nKhi ngươi kịp phản ứng, nốt nhạc đã dừng lại từ lúc nào. Ngươi không còn nghe thấy bất kỳ âm thanh nào nữa. Ngươi chỉ thấy đêm đen, ngươi chỉ nghe thấy tĩnh lặng.\nSự ồn ào vô trật tự và sự tĩnh lặng tuyệt đối, rốt cuộc cái nào đáng sợ hơn… Người Giữ Bí Mật?"
  },
  Event_125735_Name = {
    Text = "Tụng Ca Số Mệnh"
  },
  Event_125736_ChoiceDesc1 = {Text = "[đi]"},
  Event_125736_Desc = {
    Text = "Ngươi giơ tay ra, một con bướm nhẹ nhàng đậu trên tay ngươi.\nĐúng vậy. Cái chết, tan biến, trôi đi…… Bướm sinh ra từ kén, đau khổ là mảnh đất vĩnh hằng của nghệ thuật.\nLà một khán giả xuất sắc, đây là chân lý mà ngươi buộc phải hiểu."
  },
  Event_125736_Name = {
    Text = "Nở Rộ Trong Tan Biến"
  },
  Event_125737_ChoiceDesc1 = {Text = "[đi]"},
  Event_125737_Desc = {
    Text = "Đây có lẽ lại là trò gì đó của Nephrea.\nCon bướm hiểu lời ngươi, trong bóng tối vang lên tiếng thở dài vô thanh của nó. Đôi cánh chảy dịch đen sánh rung động, chẳng mấy chốc, bóng hình nặng nề của bướm chìm vào bóng tối vô tận.\nNgươi không bao giờ có thể biết được điều nó muốn nói với ngươi."
  },
  Event_125737_Name = {
    Text = "Quãng đời còn lại của bướm"
  },
  Event_125738_ChoiceDesc1 = {
    Text = "[rời đi] nhận được 50 dấu đen"
  },
  Event_125738_Desc = {
    Text = "Lăn lăn, lăn lăn, viên xúc xắc hào hứng nhảy múa trong cốc xúc xắc, nhảy đến kiệt sức.\n\n \"Tại sao... tại sao mãi mãi không ai có thể thắng được!...\""
  },
  Event_125738_Name = {
    Text = "Canh Bạc Đường Phố"
  },
  Event_125739_ChoiceDesc1 = {Text = "[đi]"},
  Event_125739_Desc = {
    Text = "Để suy nghĩ tràn lan lúc này rất nguy hiểm. Ngươi lắc đầu, vội vàng nổi lên mặt nước…"
  },
  Event_125739_Name = {
    Text = "Thanh thản"
  },
  Event_125740_ChoiceDesc1 = {Text = "[đi]"},
  Event_125740_Desc = {
    Text = "Không phải mọi nốt nhạc đều cần khán giả, không phải mọi số mệnh đều cần câu trả lời.\nNgươi bịt chặt tai, rời khỏi sân khấu ồn ào này.\nNgươi vẫn sẽ tò mò về ý nghĩa của giai điệu bất hòa ấy, nhưng ngươi biết, ngươi đã đưa ra lựa chọn đúng đắn duy nhất."
  },
  Event_125740_Name = {
    Text = "Tụng Ca Số Mệnh"
  },
  Event_125741_ChoiceDesc1 = {Text = "[đi]"},
  Event_125741_Desc = {
    Text = "Ánh bạc xuyên thủng ảo ảnh, những con mèo đen hóa thành từng vũng chất nhầy đen.\nMuốn biến thành mèo đen để trốn tránh ư, nhưng không thể qua mắt được ngươi."
  },
  Event_125741_Name = {
    Text = "Huyễn Hóa Dịch Hình"
  },
  Event_125742_ChoiceDesc1 = {
    Text = "[Chấp nhận định mệnh]Chọn 1 trong 3 thẻ chỉ lệnh để nhận khắc ấn: \"(EnchantConfig.Arg1)\""
  },
  Event_125742_Desc = {
    Text = "\"Không ai có thể thực sự phản kháng định mệnh, người thân mến. Chúng ta chưa bao giờ có quyền lựa chọn.\"\nGiọng nữ trở nên lạc lõng, xa xăm. Ngươi không chắc, người mà nàng muốn đối thoại là ngươi, hay là thứ gì khác."
  },
  Event_125742_Name = {
    Text = "Lồng Giam Định Mệnh"
  },
  Event_125743_ChoiceDesc1 = {
    Text = "[Lắng nghe bài hát] nhận được 30 dấu đen, nhiễm [(Skill.Arg2)], tiếp tục chọn"
  },
  Event_125743_ChoiceDesc2 = {
    Text = "[bỏ mặc] rời đi"
  },
  Event_125743_Desc = {
    Text = "\"Những con rối xếp hàng vào sân khấu, bước vào tấm lưới khổng lồ của số phận.\""
  },
  Event_125743_Name = {
    Text = "Lời tiên tri cuối cùng"
  },
  Event_125744_ChoiceDesc1 = {Text = "[đi]"},
  Event_125744_Desc = {
    Text = "Ngươi ngẩng đầu ngước nhìn vực sâu xoáy cuộn, cố lắng nghe thần dụ của bầy quạ.\nNhưng bầy quạ chẳng nói gì. Dưới ánh mắt ngươi, vực sâu tan biến.\nBầy quạ biến mất ở cuối sân khấu, nơi mà ngươi sắp đến."
  },
  Event_125744_Name = {
    Text = "Vực Sâu Bầy Quạ"
  },
  Event_125745_ChoiceDesc1 = {
    Text = "[Đồng ý với bướm]Xóa 2 thẻ bài"
  },
  Event_125745_ChoiceDesc2 = {
    Text = "[Phản đối bướm]Nhận tạo vật nguyền rủa \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_125745_ChoiceDesc3 = {
    Text = "[Rời đi] Nhận được Arg1 dấu đen"
  },
  Event_125745_Desc = {
    Text = "Màn sân khấu lay động trong gió, trong chất nhầy đen rỉ ra từ thi thể, ngươi nhìn thấy một đàn bướm.\n\"Nghệ thuật đích thực, luôn nở rộ trong sự tan biến…… đúng không, Người Giữ Bí Mật?\"\nThi thể vũ công đang mỉm cười với ngươi. Ngươi nghe thấy tiếng bướm vỗ cánh."
  },
  Event_125745_Name = {
    Text = "Nở Rộ Trong Tan Biến"
  },
  Event_125746_ChoiceDesc1 = {Text = "[đi]"},
  Event_125746_Desc = {
    Text = "Ngụy biện không bao giờ có thể lay động ngươi, ngươi biết rõ mình đang bước trên con đường nào, biết đích đến của mình ở đâu.\nGai góc tan biến trong cơ thể ngươi. Ngươi bước lên con đường, như mọi ngày."
  },
  Event_125746_Name = {
    Text = "Khổ Đau Lan Tràn"
  },
  Event_125747_ChoiceDesc1 = {Text = "[đi]"},
  Event_125747_Desc = {
    Text = "Ngươi quay lưng lại, cố quên đi những đôi mắt phía sau. Nhưng ngươi phát hiện cơ thể mình dường như không thể điều khiển như bình thường.\nNgươi biết, những ánh mắt dõi theo ấy, ngươi mãi mãi không thể trốn thoát."
  },
  Event_125747_Name = {
    Text = "Khán Giả"
  },
  Event_125748_ChoiceDesc1 = {Text = "[đi]"},
  Event_125748_Desc = {
    Text = "Dù là vì sự tôn trọng hay sợ hãi, bạn đều không muốn chạm vào một cách tùy tiện, đặt phong bì trở lại chỗ cũ. Khi bạn chuẩn bị rời đi, một giọng nói đục nhưng ôn hòa vang lên từ bóng tối phía sau phong bì.\n\"Cảm ơn ngài vẫn còn nhớ đến tôi, tiểu thư Arachne……\""
  },
  Event_125748_Name = {
    Text = "Chúc ngủ ngon, ngài Edgar"
  },
  Event_125749_ChoiceDesc1 = {
    Text = "[Sức mạnh thủ hộ]Nhận Di vật Bạc「(RelicConfig.Arg1)」"
  },
  Event_125749_ChoiceDesc2 = {
    Text = "[Tự do trốn thoát]Ngẫu nhiên 1 lá bài nhận được khắc ấn:「(EnchantConfig.Arg1)」"
  },
  Event_125749_ChoiceDesc3 = {
    Text = "[Từ chối trả lời]Nhận 50 Hắc Ấn"
  },
  Event_125749_Desc = {
    Text = "Rượu của Mặt Nạ Nửa Đêm bò vào đầu ngươi, trói buộc ngươi như xiềng xích. Dọc theo sợi xích lạnh lẽo, giọng nói của một phụ nữ trẻ vang vọng trong tâm trí ngươi.\n \"Hãy nói ta nghe, người thân mến. Số mệnh mà ngươi mong muốn, rốt cuộc là gì?\""
  },
  Event_125749_Name = {
    Text = "Khóa Số Mệnh"
  },
  Event_125750_ChoiceDesc1 = {Text = "[đi]"},
  Event_125750_Desc = {
    Text = "Dù sự vụ có phức tạp đến đâu, cũng cần các ngươi giải quyết.\nCùng lúc cảm thấy ngày càng nặng nề, ngươi cũng cảm nhận được sức mạnh mới."
  },
  Event_125750_Name = {
    Text = "Thanh thản"
  },
  Event_125751_ChoiceDesc1 = {Text = "[đi]"},
  Event_125751_Desc = {
    Text = "Diễn viên vô danh, vũ điệu nguy hiểm. Đúng vậy, chạy trốn luôn là lựa chọn an toàn nhất.\nNgươi quay người chạy, vén tấm màn nhà hát, rồi, ngươi đứng trên sân khấu. Con rối nắm lấy tay ngươi, nhảy lên điệu múa hoan hỉ.\nSân khấu vận mệnh, chưa bao giờ có sự lựa chọn."
  },
  Event_125751_Name = {
    Text = "Vũ Điệu Ba Người"
  },
  Event_125752_ChoiceDesc1 = {Text = "[đi]"},
  Event_125752_Desc = {
    Text = "Bây giờ không phải lúc để đi xem một bộ phim."
  },
  Event_125752_Name = {
    Text = "Rạp chiếu ký ức"
  },
  Event_125753_ChoiceDesc1 = {Text = "[đi]"},
  Event_125753_Desc = {
    Text = "Hiểm nguy trên đường chẳng hề lọt vào tâm trí ngươi. Ngươi bước qua vận mệnh đang sụp đổ bên cạnh, tiếp tục tiến về phía Nephrea.\nNgươi đến đây, là để mang sự giải thoát đến cho nàng."
  },
  Event_125753_Name = {
    Text = "Lưới Vận Mệnh hạ màn"
  },
  Event_125754_ChoiceDesc1 = {
    Text = "[Đọc phong bì]Nhận tạo vật hoàng kim \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_125754_ChoiceDesc2 = {
    Text = "[Đọc bức thư]Chọn 1 trong 3 thẻ chỉ lệnh để nhận khắc ấn: \"(EnchantConfig.Arg1)\""
  },
  Event_125754_ChoiceDesc3 = {
    Text = "[Đặt lại chỗ cũ]nhận 50 Ấn ký đen"
  },
  Event_125754_Desc = {
    Text = "Hành động của các bạn đã xé nát mạng nhện dày đặc, một bức thư cũ kỹ rơi ra từ trong đó.\nSức nặng của nó vượt xa tờ giấy mỏng manh."
  },
  Event_125754_Name = {
    Text = "Chúc ngủ ngon, ngài Edgar"
  },
  Event_125755_ChoiceDesc1 = {Text = "[đi]"},
  Event_125755_Desc = {
    Text = "Nước mắt rơi từ đôi mắt quạ. Máu tươi chảy từ khóe miệng quạ. Quạ dùng hết toàn bộ sinh mệnh, hát cho ngươi lời tiên tri cuối cùng của nó."
  },
  Event_125755_Name = {
    Text = "Lời tiên tri cuối cùng"
  },
  Event_125756_ChoiceDesc1 = {Text = "[đi]"},
  Event_125756_Desc = {
    Text = "\"Hehe... Hahahaha!\"\n \"Thế nào, vị khách của ta? Hương vị số mệnh, ngươi sẽ điên cuồng nhớ nhung nó...\""
  },
  Event_125756_Name = {
    Text = "Hương Vị Số Mệnh"
  },
  Event_125757_ChoiceDesc1 = {Text = "[đi]"},
  Event_125757_Desc = {
    Text = "\"Nhàm chán.\" Giọng nữ ngáp một cái lười biếng.\n \"Mang theo sức mạnh của ngươi, đến câu lạc bộ tham gia đấu võ đi.\""
  },
  Event_125757_Name = {
    Text = "Khóa Số Mệnh"
  },
  Event_125758_ChoiceDesc1 = {
    Text = "[Ổn định Lưới Vận Mệnh]Nhận ấn khắc cao cấp chọn 1 trong 3"
  },
  Event_125758_ChoiceDesc2 = {
    Text = "[Bất chấp nguy hiểm]Nhận tạo vật hoàng kim「(RelicConfig.Arg1)」, nhiễm「(Skill.Arg2)」"
  },
  Event_125758_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 50 dấu đen"
  },
  Event_125758_Desc = {
    Text = "Nàng là đứa con cưng của vẻ đẹp. Nàng là đứa trẻ bị số phận ruồng bỏ. Nàng là kẻ phục thù bám theo ánh sáng mờ nhạt, bò lên từ vực sâu. Nàng đến đây, mang lại sự giải thoát cho tất cả.\nLưới Vận Mệnh sụp đổ tan tành quanh các ngươi. Ngươi đứng trên sân khấu nhà hát, cách Nephrea một khoảng không xa."
  },
  Event_125758_Name = {
    Text = "Lưới Vận Mệnh hạ màn"
  },
  Event_125759_ChoiceDesc1 = {
    Text = "[Không hiểu nổi]Nhận tạo vật bạc「(RelicConfig.Arg1)」"
  },
  Event_125759_ChoiceDesc2 = {
    Text = "[Đồng cảm sâu sắc]Nhận tạo vật hoàng kim「(RelicConfig.Arg1)」, nhiễm「(Skill.Arg2)」"
  },
  Event_125759_Desc = {
    Text = "Tiếng khóc xé lòng vang lên từ sân khấu, ánh đèn duy nhất chiếu xuống bóng hình cô độc.\nHắn đang dâng hiến cho ngươi màn diễn chân thành nhất — mổ xẻ nội tạng của mình, phơi bày trước mọi khán giả.\nĐiều gì khiến nhân vật này đau khổ đến vậy?"
  },
  Event_125759_Name = {
    Text = "Lời Tự Bạch Của Diễn Viên"
  },
  Event_125760_ChoiceDesc1 = {Text = "[đi]"},
  Event_125760_Desc = {
    Text = "Tay ngươi vươn sang phải.\nĐó là tương lai của ngươi, khát khao mãnh liệt nhất, bến đỗ của ngươi, nơi ngươi sẽ đến.\nSự tồn tại của ngươi, là để đuổi theo mặt trời phía trước."
  },
  Event_125760_Name = {
    Text = "Quá Khứ, Tương Lai"
  },
  Event_125761_ChoiceDesc1 = {
    Text = "[ba điểm]"
  },
  Event_125761_ChoiceDesc2 = {
    Text = "[sáu giờ]"
  },
  Event_125761_ChoiceDesc3 = {
    Text = "[một điểm]"
  },
  Event_125761_Desc = {
    Text = "Ngươi hoàn toàn có thể bỏ đi, nhưng viên xúc xắc tinh xảo kia đã hoàn toàn thu hút ngươi.\nNgươi quên mất kẻ truy đuổi phía sau, thành kính nhặt nó lên, ném vào chiếc mũ chóp —"
  },
  Event_125761_Name = {
    Text = "Canh Bạc Đường Phố"
  },
  Event_125762_ChoiceDesc1 = {
    Text = "[rời đi] nhận được bạc tạo vật [(RelicConfig.Arg1)]"
  },
  Event_125762_Desc = {
    Text = "Lăn lăn, lăn lăn, viên xúc xắc hào hứng nhảy múa trong cốc xúc xắc, nhảy đến kiệt sức.\n\n \"Tại sao... tại sao mãi mãi không ai có thể thắng được!...\""
  },
  Event_125762_Name = {
    Text = "Canh Bạc Đường Phố"
  },
  Event_125763_ChoiceDesc1 = {
    Text = "[Chấp nhận định mệnh]Chọn 1 trong 3 thẻ chỉ lệnh để nhận khắc ấn: \"(EnchantConfig.Arg1)\""
  },
  Event_125763_ChoiceDesc2 = {
    Text = "[Phản kháng định mệnh]Nhiễm \"(Skill.Arg1)\", khắc ấn ngẫu nhiên lần nữa"
  },
  Event_125763_Desc = {
    Text = "\"Ah, đồ nghịch ngợm. Định mệnh luôn nhân từ…… nhưng mọi sự phản kháng đều có cái giá. Bây giờ, ngươi có sẵn lòng chấp nhận nó không?\""
  },
  Event_125763_Name = {
    Text = "Lồng Giam Định Mệnh"
  },
  Event_125764_ChoiceDesc1 = {Text = "[đi]"},
  Event_125764_Desc = {
    Text = "Ngươi nhìn quanh những ánh mắt ấy, vẫy tay chào chúng.\nChẳng bao lâu nữa, ngươi sẽ ban tặng cho chúng cao trào của câu chuyện."
  },
  Event_125764_Name = {
    Text = "Khán Giả"
  },
  Event_125765_ChoiceDesc1 = {Text = "[đi]"},
  Event_125765_Desc = {
    Text = "\"Thưa tiểu thư Arachne yêu quý, hôm nay là ngày ngài chào đời, tôi cảm thấy vui mừng cho lão gia và phu nhân, cũng như cho ngài. Chào mừng ngài đến với thế giới tươi đẹp này. Tôi xin dâng tặng ngài bài hát ru dịu dàng này, nguyện rằng kể từ ngày ngài ra đời, ngài sẽ sống một cuộc đời vô ưu vô lự……\""
  },
  Event_125765_Name = {
    Text = "Chúc ngủ ngon, ngài Edgar"
  },
  Event_125766_ChoiceDesc1 = {
    Text = "[Chụp ảnh]Chọn 1 trong 3 lá bài chỉ lệnh để nhận khắc ấn: \"(EnchantConfig.Arg1)\""
  },
  Event_125766_ChoiceDesc2 = {
    Text = "[Đổi lại lần nữa]Nhiễm \"(Skill.Arg1)\", thay đổi khắc ấn nhận được ở lựa chọn 1, còn có thể sử dụng một lần"
  },
  Event_125766_Desc = {
    Text = "Đối diện ống kính, ngươi có chút hoang mang. Có lẽ tư thế này chụp sẽ đẹp hơn? Hay là tư thế kia?"
  },
  Event_125766_Name = {
    Text = "Bức ảnh lưu niệm từ khán đài"
  },
  Event_125767_ChoiceDesc1 = {Text = "[đi]"},
  Event_125767_Desc = {
    Text = "Bạn muốn xem nội dung trên đó, nhưng màn chiếu trống không, trong rạp chỉ vang vọng tiếng cuộn phim quay.\nCó lẽ phải rất lâu sau nữa, bạn mới có cơ hội biết được nội dung trong cuộn phim."
  },
  Event_125767_Name = {
    Text = "Rạp chiếu ký ức"
  },
  Event_125768_ChoiceDesc1 = {
    Text = "[tránh ánh mắt] ngẫu nhiên thức tỉnh 1 thân thể được đánh thức"
  },
  Event_125768_ChoiceDesc2 = {
    Text = "[Trực diện ánh mắt] Chọn 1 thân thể được đánh thức và giảm 2 điểm tiêu thụ sức tính toán của thẻ thức tỉnh. Nhiễm [(Skill.Arg1)]"
  },
  Event_125768_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 50 dấu đen"
  },
  Event_125768_Desc = {
    Text = "Khi bước lên sân khấu, ngươi nghe thấy tiếng xì xào. Ngươi quay đầu lại, mười nghìn đôi mắt khán giả lơ lửng xung quanh sân khấu, đang dõi nhìn ngươi.\nĐến đi! Chúng nói. Vở kịch tuyệt vời, chẳng lẽ dừng lại ở đây sao?\nNhảy đi! Chúng nói. Hãy mang đến cao trào của vũ khúc này cho chúng ta!"
  },
  Event_125768_Name = {
    Text = "Khán Giả"
  },
  Event_125769_ChoiceDesc1 = {Text = "[đi]"},
  Event_125769_Desc = {
    Text = "Ngươi không hiểu nỗi đau của hắn, cũng chẳng cần hiểu.\nNhà hát có biết bao sân khấu, trên sân khấu có biết bao con rối, ngươi cũng chẳng qua là một trong số đó.\nNgươi còn có việc quan trọng hơn phải làm."
  },
  Event_125769_Name = {
    Text = "Lời Tự Bạch Của Diễn Viên"
  },
  Event_125770_ChoiceDesc1 = {Text = "[đi]"},
  Event_125770_Desc = {
    Text = "Cái chết, tan biến, trôi đi…… Nghệ thuật không tồn tại để mang đến đau khổ. Nếu cái đẹp chỉ tồn tại trong đau khổ, thì thứ đẹp đẽ ấy không cần cũng được.\nNgươi ra sức xua đuổi. Bướm tan đi, để lại một thi thể bi thương."
  },
  Event_125770_Name = {
    Text = "Nở Rộ Trong Tan Biến"
  },
  Event_125771_ChoiceDesc1 = {
    Text = "[Lắng nghe bài hát] nhận được 40 dấu đen, nhiễm [(Skill.Arg2)], tiếp tục chọn"
  },
  Event_125771_ChoiceDesc2 = {
    Text = "[ bỏ mặc ] nhận được 25 dấu đen, rời đi"
  },
  Event_125771_Desc = {
    Text = "Bầy quạ từng gặp ngươi trước đây hội tụ thành một con duy nhất. Nó đứng trước mặt ngươi cất tiếng hát, tiếng hát thê lương, như lời tiên tri cuối cùng."
  },
  Event_125771_Name = {
    Text = "Lời tiên tri cuối cùng"
  },
  Event_125772_ChoiceDesc1 = {Text = "[đi]"},
  Event_125772_Desc = {
    Text = "Tay ngươi vươn sang trái.\nĐó là quá khứ của ngươi, ký ức quý giá nhất, con đường ngươi đã đi qua, nơi ngươi sẽ trở về.\nTất cả quá khứ, tạo nên toàn bộ con người ngươi."
  },
  Event_125772_Name = {
    Text = "Quá Khứ, Tương Lai"
  },
  Event_125773_ChoiceDesc1 = {
    Text = "[Chụp ảnh]Chọn 1 trong 3 lá bài chỉ lệnh để nhận khắc ấn: \"(EnchantConfig.Arg1)\""
  },
  Event_125773_Desc = {
    Text = "Đối diện ống kính, ngươi có chút hoang mang. Có lẽ tư thế này chụp sẽ đẹp hơn? Hay là tư thế kia?\nNgươi vẫn đang do dự, nhưng ngươi nhận ra, máy ảnh đã rất mất kiên nhẫn rồi."
  },
  Event_125773_Name = {
    Text = "Bức ảnh lưu niệm từ khán đài"
  },
  Event_125774_ChoiceDesc1 = {Text = "[đi]"},
  Event_125774_Desc = {
    Text = "Ngươi chỉnh tư thế, đứng trước máy ảnh. Nghiêm chỉnh, tò mò, nhập tâm, như một khán giả thực thụ.\nỤc——\nMáy ảnh bấm nút chụp, chất nhầy đen bùng nổ từ thân máy, bắn tung tóe khắp sân khấu.\nGiữa xác máy ảnh, cuộn phim trống không."
  },
  Event_125774_Name = {
    Text = "Bức ảnh lưu niệm từ khán đài"
  },
  Event_125775_ChoiceDesc1 = {
    Text = "[Chấp nhận]Nhận tạo vật bạc chọn 1 trong 3"
  },
  Event_125775_ChoiceDesc2 = {
    Text = "[Chạy trốn]Nhận tạo vật bạc「(RelicConfig.Arg1)」「(RelicConfig.Arg2)」, nhiễm hai lần「(Skill.Arg3)」"
  },
  Event_125775_Desc = {
    Text = "Lộp cộp, lộp cộp… gót giày va chạm với sàn gỗ, phát ra tiếng giòn vui tai.\nHai con rối mặc đồng phục học sinh đang nhảy múa trên sân khấu. Bỗng nhiên, chúng dừng bước, quay lại chìa tay về phía ngươi."
  },
  Event_125775_Name = {
    Text = "Vũ Điệu Ba Người"
  },
  Event_125776_ChoiceDesc1 = {
    Text = "[Chịu đựng đau đớn]Tăng Arg1 điểm sinh mệnh tối đa"
  },
  Event_125776_ChoiceDesc2 = {
    Text = "[Phản bác nỗi đau] 1 thẻ lệnh ngẫu nhiên nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm 1 thẻ \"(Skill.Arg2)\""
  },
  Event_125776_Desc = {
    Text = "\"Ngươi chưa bao giờ quan tâm đến cái chết của Liz. Ngươi chưa bao giờ quan tâm đến bất kỳ ai.\"\n \"Thứ ngươi quan tâm chỉ có bản thân mình... Tất cả mọi người bên cạnh ngươi, đều chỉ là công cụ để ngươi đạt được tự do và bình yên.\"\n \"Chẳng phải sao... Người Giữ Bí Mật?\"\nLời thì thầm của Người Dẫn Chương vang lên bên tai ngươi. Tim ngươi thắt lại, co rút, nỗi đau dữ dội theo lời nàng lan tràn khắp cơ thể ngươi..."
  },
  Event_125776_Name = {
    Text = "Khổ Đau Lan Tràn"
  },
  Event_125777_ChoiceDesc1 = {Text = "[đi]"},
  Event_125777_Desc = {
    Text = "Hãy buông thả ý thức chìm xuống đi, nước biển tự có sức nổi, số mệnh sẽ chỉ cho các ngươi con đường của tất cả."
  },
  Event_125777_Name = {
    Text = "Thanh thản"
  },
  Event_125778_ChoiceDesc1 = {Text = "[đi]"},
  Event_125778_Desc = {
    Text = "Đó là chính ngươi. Nguồn sức mạnh, người gánh vác trách nhiệm, đối tượng trung thành duy nhất.\nNgươi bước trên con đường chỉ thuộc về mình ngươi."
  },
  Event_125778_Name = {
    Text = "Bóng Hình Trong Rượu"
  },
  Event_125779_ChoiceDesc1 = {Text = "[đi]"},
  Event_125779_Desc = {
    Text = "\"Thật đáng tiếc, vị khách của ta. Hương vị số mệnh, ngươi không còn cơ hội nếm thử nữa rồi...\""
  },
  Event_125779_Name = {
    Text = "Hương Vị Số Mệnh"
  },
  Event_125780_ChoiceDesc1 = {
    Text = "[Thảo luận với cô ấy]Xóa 1 lá bài chỉ lệnh, nhận được Arg1 hắc ấn"
  },
  Event_125780_ChoiceDesc2 = {
    Text = "[Im lặng không nói]"
  },
  Event_125780_Desc = {
    Text = "\"Đây thật sự là một vở kịch đáng buồn… Cô gái đáng thương ấy, bị chính người mà cô ấy luyến tiếc ruồng bỏ sao, chị?\"\nTrong giọng nói quen thuộc ấy, ngươi không nghe thấy bất kỳ sự điên cuồng hay thù hận nào. Giọng nói ấy trong trẻo, bi thương, như dòng suối dịu dàng trong rừng.\n\"Người ca hát ấy, một chiếc lá khô bất lực trôi dạt, chỉ có thể mặc cho số phận vùi dập… Thật đáng thương biết bao…\"\n\"Chị nói xem, nếu ta là người cầm bút… ta nên viết cho cô ấy một kết cục như thế nào đây?\""
  },
  Event_125780_Name = {
    Text = "Kết cục của vở kịch"
  },
  Event_125781_ChoiceDesc1 = {
    Text = "[Vuốt ve]50% xác suất nhận 125 Hắc Ấn, 50% xác suất nhiễm「(Skill.Arg2)」"
  },
  Event_125781_ChoiceDesc2 = {
    Text = "[Giải thích]75% xác suất nhận 100 Hắc Ấn, 25% xác suất nhiễm「(Skill.Arg2)」"
  },
  Event_125781_ChoiceDesc3 = {
    Text = "[Phá giải]Nhận 50 Hắc Ấn"
  },
  Event_125781_Desc = {
    Text = "Khi ngươi đuổi theo ra con hẻm sau quán bar, bóng dáng quái vật biến mất không dấu vết, một bầy mèo đen chắn trước mặt ngươi.\n \"Này, ngươi.\" Một con mèo đen liếm liếm móng vuốt của mình, nhìn về phía ngươi.\n \"Ngươi đến chỗ của chúng ta làm gì?\""
  },
  Event_125781_Name = {
    Text = "Huyễn Hóa Dịch Hình"
  },
  Event_125782_ChoiceDesc1 = {
    Text = "[Ôm lấy quá khứ]Nhận tạo vật hoàng kim「(RelicConfig.Arg1)」, nhiễm「(Skill.Arg2)」"
  },
  Event_125782_ChoiceDesc2 = {
    Text = "[Đón nhận tương lai]Nhận tạo vật hoàng kim chọn 1 trong 3, nhiễm「(Skill.Arg1)」"
  },
  Event_125782_ChoiceDesc3 = {
    Text = "[rời đi] nhận được bạc tạo vật [(RelicConfig.Arg1)]"
  },
  Event_125782_Desc = {
    Text = "Sự xuất hiện của Nephrea đã làm nhiễu loạn những sợi tơ. Trong vận mệnh hỗn loạn, ngươi nhìn thấy hai bóng ảo mờ nhạt.\nĐó là quá khứ của ngươi, đó là tương lai của ngươi. Ngươi bước về phía chúng, chìa tay ra…"
  },
  Event_125782_Name = {
    Text = "Quá Khứ, Tương Lai"
  },
  Event_125855_ChoiceDesc1 = {
    Text = "[Cảm nhận]Chọn 1 tạo vật biến đổi thành tạo vật hoàng kim「(RelicConfig.Arg1)」"
  },
  Event_125855_ChoiceDesc2 = {
    Text = "[Ánh nhìn] Nhận được vật phẩm bạc \"(RelicConfig.Arg1)\" và bị nhiễm \"(Skill.Arg2)\""
  },
  Event_125855_ChoiceDesc3 = {
    Text = "[bỏ qua] nhận được 25 dấu đen"
  },
  Event_125855_Desc = {
    Text = "Trên đường phố Cassalim, ánh sáng rực rỡ từ một cửa hàng pha lê đã thu hút ngươi. Ngươi đến trước cửa tiệm, nhặt lên một viên pha lê hình lõi bạc."
  },
  Event_125855_Name = {
    Text = "Bí Mật Của Pha Lê"
  },
  Event_125856_ChoiceDesc1 = {Text = "[đi]"},
  Event_125856_Desc = {
    Text = "Ngươi nhắm mắt lại, cẩn thận cảm nhận nó.\nMột tia sáng nhỏ lấp lánh trong ý thức ngươi, nó muốn nói với ngươi điều gì đó…"
  },
  Event_125856_Name = {
    Text = "Bí Mật Của Pha Lê"
  },
  Event_125857_ChoiceDesc1 = {Text = "[đi]"},
  Event_125857_Desc = {
    Text = "Mọi sự phản kháng và dò xét số mệnh đều là vô ích. Ngươi lặng lẽ nhắm mắt, mặc cho số mệnh đưa ngươi đến nơi ngươi sẽ đến."
  },
  Event_125857_Name = {
    Text = "Lưới Trói Mệnh"
  },
  Event_125858_ChoiceDesc1 = {Text = "[đi]"},
  Event_125858_Desc = {
    Text = "\"Cảm xúc là ý nghĩa của sự tồn tại. Mong rằng ngươi sẽ không hối hận vì lựa chọn của mình.\""
  },
  Event_125858_Name = {
    Text = "Cái Giá Của Sự Lựa Chọn"
  },
  Event_125859_ChoiceDesc1 = {
    Text = "[Cảm xúc]Hồi phục Arg1 điểm sinh mệnh"
  },
  Event_125859_ChoiceDesc2 = {
    Text = "[Lý trí]1 thẻ chỉ lệnh ngẫu nhiên nhận ấn khắc:「(EnchantConfig.Arg1)」"
  },
  Event_125859_ChoiceDesc3 = {
    Text = "[Từ chối lựa chọn]nhận 25 Ấn ký đen"
  },
  Event_125859_Desc = {
    Text = "Một chiếc cân xuất hiện trên sân khấu.\n \"Não bộ và trái tim, lý trí và cảm xúc, xám và đỏ... Chúng ta không thể trốn tránh sự lựa chọn, đó là vận mệnh của chúng ta.\"\n \"Điểm cuối của sân khấu đã được định sẵn. Giờ hãy chọn con đường mà sân khấu này sẽ đi qua.\""
  },
  Event_125859_Name = {
    Text = "Cái Giá Của Sự Lựa Chọn"
  },
  Event_125860_ChoiceDesc1 = {Text = "[đi]"},
  Event_125860_Desc = {
    Text = "\"Đừng ngẩng đầu. Rời khỏi đây.\"\nNgươi nghe thấy tiếng nói của vận mệnh. Ngươi vô cùng khao khát nhìn lên bầu trời, nhưng ngươi biết, nàng nói đúng."
  },
  Event_125860_Name = {
    Text = "Ngước Nhìn"
  },
  Event_125861_ChoiceDesc1 = {Text = "[đi]"},
  Event_125861_Desc = {
    Text = "Ngươi không bao giờ chấp nhận số mệnh. Ngươi không bao giờ chấp nhận giam cầm.\nNgươi ra sức vùng vẫy, sau khi hiến tế một phần chi thể của bướm đêm, cuối cùng ngươi cũng thoát được…"
  },
  Event_125861_Name = {
    Text = "Lưới Trói Mệnh"
  },
  Event_125862_ChoiceDesc1 = {
    Text = "[Tình bạn]Nhận 50 Hắc Ấn"
  },
  Event_125862_ChoiceDesc2 = {
    Text = "[Giúp đỡ]Nhận 75 Hắc Ấn, nhiễm「(Skill.Arg2)」"
  },
  Event_125862_Desc = {
    Text = "Con hẻm sau quán bar, ngươi lại gặp những con mèo đen ấy.\n \"Ta đã nghe nói rồi. Những chất nhầy đen hóa thành hình dạng của chúng ta, gây cho ngươi không ít phiền phức.\"\n \"Để bồi thường, hãy nói cho ta biết, ngươi muốn gì?\"\nMèo đen quấn quanh chân ngươi hai vòng, ngẩng đầu nhìn ngươi."
  },
  Event_125862_Name = {
    Text = "Quà Gặp Mặt"
  },
  Event_125863_ChoiceDesc1 = {Text = "[đi]"},
  Event_125863_Desc = {
    Text = "Sức mạnh thô bạo không thể phá giải số mệnh, nhưng có lẽ trí tuệ thì có thể?\nNgươi quan sát kỹ tấm lưới này, cố gắng nhìn thấu một vài quỹ đạo của số mệnh từ trong đó…"
  },
  Event_125863_Name = {
    Text = "Lưới Trói Mệnh"
  },
  Event_125864_ChoiceDesc1 = {Text = "[đi]"},
  Event_125864_Desc = {
    Text = "Ngươi ghé sát lại, chăm chú nhìn vào nó.\nMột tia sáng nhỏ lấp lánh trong mắt ngươi, nó muốn nói với ngươi điều gì đó…"
  },
  Event_125864_Name = {
    Text = "Bí Mật Của Pha Lê"
  },
  Event_125865_ChoiceDesc1 = {
    Text = "[Vùng vẫy]Lấy ngẫu nhiên 3 lá bài chỉ lệnh từ bộ bài, chọn 1 lá để xóa, nhận 75 Hắc Ấn"
  },
  Event_125865_ChoiceDesc2 = {
    Text = "[Suy ngẫm]Lấy ngẫu nhiên 3 lá bài chỉ lệnh từ bộ bài, chọn 1 lá để thêm bản sao gốc vào bộ bài, nhận 25 Hắc Ấn"
  },
  Event_125865_ChoiceDesc3 = {
    Text = "[Nghỉ ngơi]Nhận 50 Hắc Ấn"
  },
  Event_125865_Desc = {
    Text = "Một cảm giác quen thuộc ập đến, khác biệt là cảm giác dính nhớp đó, bản năng bất lực kháng cự đó, lần này mãnh liệt hơn, chí mạng hơn.\nBướm đêm rơi vào mạng nhện, và ngươi cũng đã bước lên sân khấu."
  },
  Event_125865_Name = {
    Text = "Lưới Trói Mệnh"
  },
  Event_125866_ChoiceDesc1 = {Text = "[đi]"},
  Event_125866_Desc = {
    Text = "\"Lý trí là phương tiện để tồn tại. Mong rằng ngươi sẽ không hối hận vì lựa chọn của mình.\""
  },
  Event_125866_Name = {
    Text = "Cái Giá Của Sự Lựa Chọn"
  },
  Event_125867_ChoiceDesc1 = {Text = "[đi]"},
  Event_125867_Desc = {
    Text = "Sự tò mò bị thổi bùng. Ngươi đến giữa đám đông, ngẩng đầu lên như họ.\nỞ đó chẳng có gì cả, nhưng không hiểu sao, ngươi không muốn hạ ánh mắt xuống. Ngươi muốn cứ nhìn như vậy, mãi nhìn…"
  },
  Event_125867_Name = {
    Text = "Ngước Nhìn"
  },
  Event_125868_ChoiceDesc1 = {Text = "[đi]"},
  Event_125868_Desc = {
    Text = "\"Từ bỏ lựa chọn cũng là một lựa chọn, đó là lời nguyền của số mệnh. Mong rằng ngươi sẽ không hối hận vì lựa chọn của mình.\""
  },
  Event_125868_Name = {
    Text = "Cái Giá Của Sự Lựa Chọn"
  },
  Event_125869_ChoiceDesc1 = {Text = "[đi]"},
  Event_125869_Desc = {
    Text = "\"Giờ thì, ngươi đã sở hữu nó rồi.\"\nMèo đen cọ vào ống chân ngươi, rồi nhanh chóng biến mất.\nTại nơi chúng biến mất, một món quà đang chờ đợi ngươi."
  },
  Event_125869_Name = {
    Text = "Quà Gặp Mặt"
  },
  Event_125870_ChoiceDesc1 = {Text = "[đi]"},
  Event_125870_Desc = {
    Text = "\"Giờ thì, ngươi đã sở hữu nó rồi.\"\nMèo đen cọ vào ống chân ngươi, rồi nhanh chóng biến mất.\nTại nơi chúng biến mất, một món quà đang chờ đợi ngươi."
  },
  Event_125870_Name = {
    Text = "Quà Gặp Mặt"
  },
  Event_125871_ChoiceDesc1 = {
    Text = "[Ngẩng đầu] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", lây nhiễm \"(Skill.Arg2)\""
  },
  Event_125871_ChoiceDesc2 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_125871_Desc = {
    Text = "Tiếng ồn ào tạm thời biến mất. Đám đông trên phố chìm vào im lặng, ngẩng đầu nhìn lên bầu trời."
  },
  Event_125871_Name = {
    Text = "Ngước Nhìn"
  },
  Event_129176_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129176_Name = {
    Text = "Quên lãng chương 1@"
  },
  Event_129177_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129177_Name = {
    Text = "Bài sao Chương 1@"
  },
  Event_129178_ChoiceDesc1 = {
    Text = "[Chỉ dẫn hướng] Nhận bạc tạo vật \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_129178_ChoiceDesc2 = {
    Text = "[Cùng nhau cầu nguyện] Nhận Khắc ấn 3 chọn 1, lặp lại 2 lần"
  },
  Event_129178_Desc = {
    Text = "Âm thanh của đàn piano và đàn phong cầm hòa quyện trong gió xám xịt. Những giai điệu như mang phép màu bay lơ lửng giữa những con phố không người. \nMột nữ tu vô danh đang cầu nguyện trong tiếng nhạc. \n \"Lời cầu nguyện đơn sơ không cần nghi thức trang trọng, Đấng Cha vĩ đại sẽ gieo rắc hy vọng cho chúng ta, như Người đã từng ban cho chúng ta những lời dạy đầy lòng thành kính.\""
  },
  Event_129178_Name = {
    Text = "Lời cầu nguyện của organ"
  },
  Event_129179_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129179_Name = {
    Text = "Bài sao Chương 1@"
  },
  Event_129180_ChoiceDesc1 = {
    Text = "[Chủ động đón chiến] nhận được vật bị nguyền rủa \"(RelicConfig.Arg1)\", nhiễm phải \"(Skill.Arg2)\""
  },
  Event_129180_ChoiceDesc2 = {
    Text = "[Bỏ cuộc kháng cự] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: [(EnchantConfig.Arg1)] hai lần"
  },
  Event_129180_ChoiceDesc3 = {
    Text = "[Nhanh chân chạy thoát] nhận được 50 dấu đen"
  },
  Event_129180_Desc = {
    Text = "Mấy bình tượng nến thô sơ chặn đường bạn. \n Chúng méo mó, khuôn mặt thô ráp, trông không giống như tác phẩm mà Rogers thường làm. \n \"Lệnh... lệnh của người lớn...\""
  },
  Event_129180_Name = {Text = "bài tập"},
  Event_129181_ChoiceDesc1 = {
    Text = "[bỏ qua suy nghĩ] nhận được vật bị nguyền rủa \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_129181_ChoiceDesc2 = {
    Text = "[Đuổi theo Cảm hứng] Thẻ lệnh ngẫu nhiên nhận Khắc ấn: [(EnchantConfig.Arg1)], lặp lại 2 lần"
  },
  Event_129181_Desc = {
    Text = "Cảng bị tấn công, tàu hàng bí ẩn có đến mà không có về và \"người bạn mới\" có vây... Đây là một cái bẫy được chuẩn bị kỹ lưỡng hay lại là một chuyến đi đầy rẫy những sự cố? \nHiện thực và lý trí giằng co lẫn nhau, vô số cảm hứng và suy nghĩ tuôn trào trong tâm trí."
  },
  Event_129181_Name = {
    Text = "Bùng nổ cảm hứng"
  },
  Event_129182_ChoiceDesc1 = {
    Text = "[Tham gia] Lây Nhiễm \"(Skill.Arg1)\" hai lần, 1 thẻ bài ngẫu nhiên nhận Khắc ấn: \"(EnchantConfig.Arg2)\" hai lần"
  },
  Event_129182_ChoiceDesc2 = {
    Text = "[Xua đuổi] Lây Nhiễm \"(Skill.Arg1)\" hai lần, 1 thẻ bài ngẫu nhiên nhận Khắc ấn: \"(EnchantConfig.Arg2)\" hai lần"
  },
  Event_129182_ChoiceDesc3 = {
    Text = "[Thờ ơ] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: [(EnchantConfig.Arg1)] hai lần"
  },
  Event_129182_Desc = {
    Text = "Bạn nghe thấy tiếng kèn xương mờ ảo từ xa vọng lại. \n Đám chuột theo tiếng gọi từ bùn đen hiện diện, gặm nhấm xác chết vô danh nằm trên đáy sông khô cạn. \n Chúng tạo thành một vòng tròn, tâm điểm là xác chết đã trống rỗng, và chu vi là một vương quốc mới với sự quên lãng làm luật lệ. \n Còn bạn, đang đứng ở cửa ra vào của vương quốc này."
  },
  Event_129182_Name = {
    Text = "Vương quốc Lưu đày"
  },
  Event_129183_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129183_Name = {
    Text = "Quên lãng chương 5@"
  },
  Event_129184_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129184_Name = {
    Text = "Quên lãng chương 8@"
  },
  Event_129185_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129185_Name = {
    Text = "Quên lãng chương 1@"
  },
  Event_129186_ChoiceDesc1 = {
    Text = "[Giải cứu chân dung] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\" hai lần, Lây Nhiễm \"(Skill.Arg2)\" hai lần"
  },
  Event_129186_ChoiceDesc2 = {
    Text = "[Chấp nhận khoảng trống] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\" hai lần, Lây Nhiễm \"(Skill.Arg2)\" hai lần"
  },
  Event_129186_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_129186_Desc = {
    Text = "Bạn đứng trước món quà của Pickman.\nĐó là một bức chân dung, vẽ lên bằng máu, ngọn lửa đen thầm lặng cháy.\nQua hốc mắt trống rỗng của người trong bức tranh, bạn thấy —\nký ức của bạn đang cuộn trào cháy rực, kéo dài, bóp méo, phát sáng, dường như một loại lửa vô hình đang liếm láp vào hành lang trong não bạn. Trong một khoảnh khắc mơ hồ, bạn nghe thấy một giọng nói.\n \"Đã đến lúc bỏ vào nồi, thời điểm này thật đúng.\"\nĐó chính là cảnh tưởng ký ức mà bạn đã vẽ ra, bạn đang vật lộn và biến hình trong ngọn lửa."
  },
  Event_129186_Name = {
    Text = "Chân dung bốc cháy"
  },
  Event_129187_ChoiceDesc1 = {
    Text = "[Bạn sẵn sàng trả giá bằng gì?] Ngẫu nhiên nâng cao phẩm chất Khắc ấn của 1 thẻ bài hai lần"
  },
  Event_129187_ChoiceDesc2 = {
    Text = "[Mời họ một ly Bloody Mary hết hạn] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\" hai lần, nhiễm \"(Skill.Arg2)\" hai lần"
  },
  Event_129187_Desc = {
    Text = "\"Chào mừng quý khách, người khách quý của tôi. Hãy thoải mái lựa chọn, tất cả những thứ lấp lánh này đều đang chờ đợi ngài.\"\n \"Xin lỗi, thưa cô, liệu cô có phải là... chị em song sinh của bà Đào Đen Đá không?\"\n \"Tôi chính là Đào Đen Đá, xin hỏi quý khách hôm nay đến đây có việc gì quan trọng...?\"\n \"Thật xin lỗi, cô trông đẹp hơn trước nhiều, tôi đã không nhận ra. Cô còn nhớ không? Hai mươi năm trước, cô đã giúp tôi đuổi một kẻ dị hợm khỏi quán bar... Hôm qua, cơn ác mộng tái hiện, nó chiếm lấy quán bar, cùng với đồng loại của nó, thành đàn...\""
  },
  Event_129187_Name = {
    Text = "Hồi ức phân mảnh · Mộng cũ tái hiện"
  },
  Event_129188_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129188_Name = {
    Text = "Bài sao Chương 3@"
  },
  Event_129189_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129189_Name = {
    Text = "Quên lãng chương 8@"
  },
  Event_129190_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129190_Name = {
    Text = "Quên lãng chương 1@"
  },
  Event_129191_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129191_Name = {
    Text = "Quên lãng Chương 6@"
  },
  Event_129192_ChoiceDesc1 = {
    Text = "[Gripping ngọn lửa] tăng Arg1 điểm máu tối đa"
  },
  Event_129192_ChoiceDesc2 = {
    Text = "[Đối mặt nội tâm] 2 thẻ lệnh ngẫu nhiên nhận Khắc ấn: \"(EnchantConfig.Arg1)\", lặp lại 2 lần, lây nhiễm 2 thẻ \"(Skill.Arg2)\", lặp lại 2 lần"
  },
  Event_129192_Desc = {
    Text = "Trong cuộc săn bắn hoành tráng này, sự truy đuổi của Goliath như một con thú hung dữ trong đêm tối, cố gắng tiêu thụ mọi ánh sáng hy vọng. Tuy nhiên, cuộc truy đuổi tàn nhẫn này không làm bạn đóng băng, mà ngược lại, nó đã thắp sáng ngọn lửa sâu thẳm trong lòng bạn, lan tỏa và đốt cháy trong lồng ngực, trở nên ngày càng nóng bỏng."
  },
  Event_129192_Name = {
    Text = "Theo đuổi ánh sáng"
  },
  Event_129193_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129193_Name = {
    Text = "Quên lãng Chương 6@"
  },
  Event_129194_ChoiceDesc1 = {
    Text = "[Đọc con Đường của người xưa] Chọn 1 trong 3 thẻ lệnh nhận được Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_129194_ChoiceDesc2 = {
    Text = "[Viết con đường của riêng bạn] nhận được bạc sáng tạo \"(RelicConfig.Arg1)\", nhiễm phép \"(Skill.Arg2)\""
  },
  Event_129194_ChoiceDesc3 = {
    Text = "[Mục thị bóng tối] nhận được 25 dấu đen"
  },
  Event_129194_Desc = {
    Text = "Nếu bạn là một người đang mò mẫm tiến lên trong thâm cảnh, chắc chắn bạn sẽ không vững vàng như hiện tại. \nDấu chân trong thâm cảnh chia thành ba hướng, mỗi dấu chân in xuống đều viết nên tương lai không thể thấy được."
  },
  Event_129194_Name = {Text = "lối ra"},
  Event_129195_ChoiceDesc1 = {
    Text = "[Chỉ ra lỗi sai] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\" hai lần, nhiễm \"(Skill.Arg2)\" hai lần"
  },
  Event_129195_ChoiceDesc2 = {
    Text = "[Sau khi thưởng thức phần trình diễn] Mỗi khi có một thân thể được đánh thức với mức điên cuồng 50 trở lên, nhận được 15 dấu đen"
  },
  Event_129195_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 1 trong 3 khắcăng"
  },
  Event_129195_Desc = {
    Text = "Bình tượng nến của cậu bé ngồi trước cây đàn piano đang luyện tập. \n Thầy giáo của cậu——cũng là một bình tượng nến, đang hướng dẫn bên cạnh. \n 133, 355, 244…… \n Sai rồi, mỗi nốt đều sai."
  },
  Event_129195_Name = {
    Text = "Bài học piano"
  },
  Event_129196_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129196_Name = {
    Text = "Quên lãng chương 5@"
  },
  Event_129197_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129197_Name = {
    Text = "Bài sao Chương 4@"
  },
  Event_129198_ChoiceDesc1 = {
    Text = "[Lắng nghe nỗi buồn] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", lặp lại 2 lần, nhiễm \"(Skill.Arg2)\", lặp lại 2 lần"
  },
  Event_129198_ChoiceDesc2 = {
    Text = "[Lắng nghe niềm vui] Mỗi thân thể được đánh thức có giá trị điên cuồng từ 50 trở lên sẽ nhận được 15 dấu đen"
  },
  Event_129198_ChoiceDesc3 = {
    Text = "[Rời đi] Nhận Khắc ấn 3 chọn 1 hai lần"
  },
  Event_129198_Desc = {
    Text = "Du dương, trữ tình, vui mừng, u buồn… Giai điệu vang vọng trong không gian thâm cảnh, khó lòng phân biệt nguồn gốc. \n Đây là bản sonata chảy ra từ âm thanh của con tàu ma, hay là một bản trường ca nửa đêm bị hạn chế trong thâm cảnh?"
  },
  Event_129198_Name = {
    Text = "Âm thanh vô danh"
  },
  Event_129199_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129199_Name = {
    Text = "Bài sao Chương 1@"
  },
  Event_129200_ChoiceDesc1 = {
    Text = "[Mở phong bì]nhận di vật vàng「(RelicConfig.Arg1)」，nhiễm「(Skill.Arg2)」"
  },
  Event_129200_ChoiceDesc2 = {
    Text = "[Đọc sách] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: [(EnchantConfig.Arg1)] hai lần"
  },
  Event_129200_ChoiceDesc3 = {
    Text = "[Đặt lại chỗ cũ]nhận 50 Ấn ký đen"
  },
  Event_129200_Desc = {
    Text = "Trong góc khuất không ai để ý, có một lá thư bị bỏ lại.\nNhiều chữ viết trên lá thư đã không còn rõ ràng, nhưng chỉ còn một từ. Chuyển động mạnh mẽ qua giấy.\nTừ đó là \"mẹ\"."
  },
  Event_129200_Name = {
    Text = "Nỗi Nhớ Khuất Mất"
  },
  Event_129201_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129201_Name = {
    Text = "Bài sao Chương 4@"
  },
  Event_129202_ChoiceDesc1 = {
    Text = "[Lắng nghe cẩn thận] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", lặp lại 2 lần, lây nhiễm \"(Skill.Arg2)\", lặp lại 2 lần"
  },
  Event_129202_ChoiceDesc2 = {
    Text = "[bịt tai] Mỗi khi có một thân thể được đánh thức có chỉ số điên cuồng từ 50 trở lên, nhận được 15 dấu đen"
  },
  Event_129202_ChoiceDesc3 = {
    Text = "[Xem xét] Nhận Khắc ấn 3 chọn 1, lặp lại 2 lần"
  },
  Event_129202_Desc = {
    Text = "Khi các bạn bước vào tầng có xác chết, tiếng chuông trong trẻo bất ngờ vang lên giữa nhà máy bỏ hoang rộng lớn. Cảm giác mát mẻ và tinh khiết của tiếng đàn piano hoàn toàn đối lập với đống phế tích thép rỉ sét xung quanh."
  },
  Event_129202_Name = {
    Text = "Thang âm kỳ quái"
  },
  Event_129203_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129203_Name = {
    Text = "Quên lãng Chương 3@"
  },
  Event_129204_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129204_Name = {
    Text = "Quên lãng Chương 6@"
  },
  Event_129205_ChoiceDesc1 = {
    Text = "[Bỏ qua cho cô ấy]nhận được vật bị nguyền rủa 「(RelicConfig.Arg1)」, nhiễm 「(Skill.Arg2)」"
  },
  Event_129205_ChoiceDesc2 = {
    Text = "[Giúp cô ấy] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: [(EnchantConfig.Arg1)] hai lần"
  },
  Event_129205_ChoiceDesc3 = {
    Text = "[Tôi muốn đi con đường của riêng tôi] nhận được 50 dấu đen"
  },
  Event_129205_Desc = {
    Text = "Ba bóng người chặn đường bạn. \n \"Bạn có thể buông tha cho cô ấy,\" bóng người ôm con gấu bông dính đầy rỗng rỗng mở miệng,\"cô ấy chỉ sợ hãi, không hề độc ác. Cô ấy không muốn gây thương tổn cho bất kỳ ai.\"\n \"Bạn có thể giúp đỡ cô ấy,\" bóng người cầm một túi kẹo được gói đẹp mắt mở miệng,\"bạn có thể làm những điều mà cô ấy không thể làm, bạn có thể kết thúc tất cả.\"\n \"Bạn không cần nghe chúng tôi,\" bóng người tay không mở miệng,\"bạn có con đường riêng của mình.\""
  },
  Event_129205_Name = {
    Text = "Đường phân nhánh"
  },
  Event_129206_ChoiceDesc1 = {
    Text = "[Cho chuột ăn] nhận được bạc sáng tạo[(RelicConfig.Arg1)], chọn nhiễm 1 lần triệu chứng"
  },
  Event_129206_ChoiceDesc2 = {
    Text = "[Xua đuổi chuột] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", lặp lại 2 lần, nhiễm \"(Skill.Arg2)\", lặp lại 2 lần"
  },
  Event_129206_ChoiceDesc3 = {
    Text = "[Phớt lờ chuột] nhận được 25 dấu đen"
  },
  Event_129206_Desc = {
    Text = "Mọi thứ trên con tàu này, đều đang luân hồi.\nNhững sinh vật nhỏ bé đáng ghét phủ đầy lông bẩn thỉu sống nhờ trên tàu tự nhiên cũng không thể tránh khỏi số phận này.\nTrong vô số lần luân hồi, chúng ăn tất cả những gì nhìn thấy, nhưng vẫn không thể thỏa mãn.\n \"Đói... quá...\"\nBầy chuột phát ra tiếng kêu the thé bệnh hoạn và chói tai.\nNhững lần luân hồi liên tiếp khiến chúng đói đến không chịu nổi, chúng phải ăn gì đó.\nNgay lập tức, ngay bây giờ!"
  },
  Event_129206_Name = {
    Text = "Bầy chuột đói"
  },
  Event_129207_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129207_Name = {
    Text = "Quên lãng chương 8@"
  },
  Event_129208_ChoiceDesc1 = {
    Text = "[Chạm vào não] 1 thẻ lệnh ngẫu nhiên nhận Khắc ấn: [(EnchantConfig.Arg1)] hai lần"
  },
  Event_129208_ChoiceDesc2 = {
    Text = "[Chạm vào tim] tăng tối đa máu Arg1 điểm，nhiễm「(Skill.Arg2)」"
  },
  Event_129208_Desc = {
    Text = "Bạn bước vào căn phòng xám không có ai thầm thì, một chiếc cân hiện lên mờ ảo trong làn sương đen. \nBên trái là một bộ não tĩnh lặng như hồ, những rãnh bạc trắng lấp lánh ánh sáng mờ; bên phải là một trái tim đỏ rực, tỏa ra hơi nóng. \nĐột nhiên, bạn ngửi thấy một mùi hương, cơn khát khao không ngừng phình to, lý trí bị sự tối tăm vô biên của nó ép chặt. \nBạn đưa tay ra."
  },
  Event_129208_Name = {
    Text = "Trò chơi đói"
  },
  Event_129209_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129209_Name = {
    Text = "Quên lãng chương 4@"
  },
  Event_129210_ChoiceDesc1 = {
    Text = "[Chém hạ bóng người] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", lặp lại 2 lần, lây nhiễm \"(Skill.Arg2)\", lặp lại 2 lần"
  },
  Event_129210_ChoiceDesc2 = {
    Text = "[Nghiền nát Phôi thai] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", lặp lại 2 lần, lây nhiễm \"(Skill.Arg2)\", lặp lại 2 lần"
  },
  Event_129210_ChoiceDesc3 = {
    Text = "[đóng mắt lại] được 25 dấu đen"
  },
  Event_129210_Desc = {
    Text = "Trong cơn mơ hồ, bạn thấy những người từng gặp ở Aran đang tiến lại gần bạn. \n Họ cười vui mời bạn uống rượu, nhảy múa, thưởng thức món ăn. \n Sau đó, thịt máu của họ lần lượt bị lột ra, những thứ rơi xuống đất lại bò lên và mọc ra phôi thai mới. \n Họ chìa tay ra với bạn, mời bạn tham gia vào cuộc vui của thịt máu và sinh mới."
  },
  Event_129210_Name = {
    Text = "Bóng tối của những ngày xưa"
  },
  Event_129211_ChoiceDesc1 = {
    Text = "[Cho ăn họ]nhận di vật bạc「(RelicConfig.Arg1)」，chọn nhiễm 1 lần triệu chứng"
  },
  Event_129211_ChoiceDesc2 = {
    Text = "[Không quan tâm] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\" hai lần, Lây Nhiễm \"(Skill.Arg2)\" hai lần"
  },
  Event_129211_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_129211_Desc = {
    Text = "Những cư dân ra vào, nhưng bầy chuột thì vẫn dài lâu.\nSo với con người, chúng mới thực sự là \"nguyên cư\" của lâu đài này.\nNhưng chúng không có ý kiến gì về sự xuất hiện của con người.\nBởi vì những thứ mềm mại, trắng trẻo, xấu xí đó sẽ cho nó những thứ cũng mềm mại, trắng trẻo, xấu xí như vậy.\n\"Và bạn, thứ xấu xí, thuộc về loại nào?\""
  },
  Event_129211_Name = {
    Text = "Bí mật của lâu đài cổ"
  },
  Event_129212_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129212_Name = {
    Text = "Quên lãng chương 5@"
  },
  Event_129213_ChoiceDesc1 = {
    Text = "[Phân biệt giọng nói của đàn ông] Lấy ngẫu nhiên 3 thẻ lệnh từ bộ bài và chọn 1 thẻ để sao chép"
  },
  Event_129213_ChoiceDesc2 = {
    Text = "[Phân biệt giọng nói của phụ nữ] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", lặp lại 2 lần, lây nhiễm \"(Skill.Arg2)\", lặp lại 2 lần"
  },
  Event_129213_ChoiceDesc3 = {
    Text = "[ Phân biệt giọng nói của người già ] nhận được 25 dấu đen"
  },
  Event_129213_Desc = {
    Text = "Bạn đứng một mình trong một đầm lầy tối tăm. \n Trong sự mờ ảo, bạn nghe thấy những tiếng thì thầm hỗn mang như sóng biển dâng trào, có tiếng từ những người già tuổi cao, có tiếng từ những đứa trẻ mới biết nói, có tiếng từ những người phụ nữ lo âu, có tiếng từ những người đàn ông sợ hãi không rõ lý do..."
  },
  Event_129213_Name = {
    Text = "Lời nói cuối cùng không rõ ràng"
  },
  Event_129214_ChoiceDesc1 = {
    Text = "[Nhìn kỹ hơn] Nhận Khắc ấn chọn 1 trong 3 hai lần"
  },
  Event_129214_ChoiceDesc2 = {
    Text = "[Xé tờ áp phích] Thẻ lệnh ngẫu nhiên nhận Khắc ấn: \"(EnchantConfig.Arg1)\" hai lần, nhiễm \"(Skill.Arg2)\" hai lần"
  },
  Event_129214_Desc = {
    Text = "Một giá nến thường thấy trong bảo tàng sáp. \n Nhờ ánh sáng mờ ám màu cam, bạn phát hiện ra một poster vẽ tay dán trên tường."
  },
  Event_129214_Name = {
    Text = "Tiếng cười trong bóng tối"
  },
  Event_129215_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129215_Name = {
    Text = "Quên lãng chương 4@"
  },
  Event_129216_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129216_Name = {
    Text = "Quên lãng Chương 7@"
  },
  Event_129217_ChoiceDesc1 = {
    Text = "[Ánh nhìn] Nhận được vật phẩm bạc \"(RelicConfig.Arg1)\" và bị nhiễm \"(Skill.Arg2)\""
  },
  Event_129217_ChoiceDesc2 = {
    Text = "[Phớt lờ] Nhận Khắc ấn 3 chọn 1, lặp lại 2 lần"
  },
  Event_129217_Desc = {
    Text = "Người Aran quỳ gối trong cơn bão cát. \n Cơn bão quất vào thân thể của họ, cát cuốn đi lòng thành kính của họ. \n Trong xoáy cát bụi, dường như có vô số con mắt khổng lồ nhìn xuống mảnh đất méo mó."
  },
  Event_129217_Name = {
    Text = "Gigante Cát và Bụi"
  },
  Event_129218_ChoiceDesc1 = {
    Text = "[Xua đuổi bướm] 1 thẻ lệnh ngẫu nhiên nhận Khắc ấn: \"(EnchantConfig.Arg1)\" hai lần, Lây Nhiễm \"(Skill.Arg2)\" hai lần"
  },
  Event_129218_ChoiceDesc2 = {
    Text = "[Lắng nghe tâm nguyện] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: [(EnchantConfig.Arg1)] hai lần"
  },
  Event_129218_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_129218_Desc = {
    Text = "Những con bướm nhỏ, cũng có nhiều giấc mơ.\nNhững giấc mơ này rải rác trong biển hoa, trong phòng bệnh, và cả trong những @2bàn thờ đầy thịt máu.\nGiờ đây, nó cuối cùng đã chờ đợi được người kết nối, không biết bạn có sẵn lòng lắng nghe những tâm nguyện nhỏ bé của nó không."
  },
  Event_129218_Name = {
    Text = "Giấc mơ của bướm"
  },
  Event_129219_ChoiceDesc1 = {
    Text = "[Đi theo chỉ dẫn] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", lặp lại 2 lần, nhiễm \"(Skill.Arg2)\", lặp lại 2 lần"
  },
  Event_129219_ChoiceDesc2 = {
    Text = "[Phớt lờ chỉ dẫn] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", lặp lại 2 lần, nhiễm \"(Skill.Arg2)\", lặp lại 2 lần"
  },
  Event_129219_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_129219_Desc = {
    Text = "Lễ tế đã bắt đầu.\nDưới pháo hoa linh hồn và lời cầu nguyện bằng máu, vô số tín đồ hóa linh hồn thành hải đăng——\nNhững linh hồn mờ ảo phân tán xung quanh bạn, như những tinh linh dẫn đường, lấp lánh chờ đợi sự lựa chọn của bạn."
  },
  Event_129219_Name = {
    Text = "Linh hồn hải đăng"
  },
  Event_129220_ChoiceDesc1 = {
    Text = "[Phớt lờ tiếng chuông] Nhận đá khắc cao cấp 3 chọn 1 hai lần"
  },
  Event_129220_ChoiceDesc2 = {
    Text = "[Cầm ống nghe] nhận được di vật vàng「(RelicConfig.Arg1)」，nhiễm「(Skill.Arg2)」"
  },
  Event_129220_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 50 dấu đen"
  },
  Event_129220_Desc = {
    Text = "Nó lẽ ra không nên vang lên——chiếc điện thoại, cuộn tròn ở phía sau bức tranh. \n Dây của ống nghe quấn quanh thân máy cỡ lớn, như sợi dây rốn han gỉ, dường như kéo dài từ trong đầu bạn. \n Bạn chăm chú phân biệt tần số rung, âm thanh kỳ quái giống như nghệ thuật siêu thực của Pickman."
  },
  Event_129220_Name = {
    Text = "Cuộc gọi nhỡ"
  },
  Event_129221_ChoiceDesc1 = {
    Text = "[Chúng tôi đều bình an] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\" hai lần, nhiễm \"(Skill.Arg2)\" hai lần"
  },
  Event_129221_ChoiceDesc2 = {
    Text = "[Bạn là ai?] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\" hai lần, nhiễm \"(Skill.Arg2)\" hai lần"
  },
  Event_129221_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_129221_Desc = {
    Text = "Máy đánh chữ đột ngột phun ra mực, dấu chấm than trên đó nhiều đến mức chói mắt. \n「Đóa, cô còn ổn không??? Người giữ bí mật đã biến mất, và cô cũng vậy! Xin vui lòng báo tin nếu cô vẫn an toàn! Nếu tiếp tục đợi, chắc chắn tóc của William sẽ rụng sạch"
  },
  Event_129221_Name = {
    Text = "Giao tiếp khẩn cấp"
  },
  Event_129222_ChoiceDesc1 = {
    Text = "[[Cắt dây lụa đỏ]] xóa 1 thẻ lệnh, nhận Arg1 dấu đen"
  },
  Event_129222_ChoiceDesc2 = {
    Text = "[đối kháng] sao chép 1 thẻ lệnh, lây nhiễm [(Skill.Arg1)]"
  },
  Event_129222_ChoiceDesc3 = {
    Text = "[Gọi Ramona] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: [(EnchantConfig.Arg1)], lặp lại 2 lần"
  },
  Event_129222_Desc = {
    Text = "Kassia vung chiếc khăn đỏ, ngay lập tức quấn lấy vali của bạn."
  },
  Event_129222_Name = {Text = "Seda rối"},
  Event_129223_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129223_Name = {
    Text = "Quên lãng Chương 6@"
  },
  Event_129224_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129224_Name = {
    Text = "Bài sao Chương 3@"
  },
  Event_129225_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129225_Name = {
    Text = "Quên lãng Chương 3@"
  },
  Event_129226_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129226_Name = {
    Text = "Quên lãng chương 4@"
  },
  Event_129227_ChoiceDesc1 = {
    Text = "[Vẫy tay xua đuổi] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\" hai lần, Lây Nhiễm \"(Skill.Arg2)\" hai lần"
  },
  Event_129227_ChoiceDesc2 = {
    Text = "[Tự do dừng lại] nhận được bạc sáng tạo \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_129227_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_129227_Desc = {
    Text = "Trong bóng tối vọng lại tiếng động nhẹ.\nĐó là một con bướm lịch sự hỏi thăm.\n \"Tôi có thể đậu trên lòng bàn tay bạn được không?\"\n \"Tôi chỉ quá mệt, muốn nghỉ ngơi một chút...\"\nVừa hỏi thăm như vậy, con bướm xuyên qua bóng tối, lượn vòng trước mặt bạn.\nDung dịch đen sền sệt nhỏ giọt từ đôi cánh của nó — đó là món quà từ bóng tối khi bướm xuyên qua."
  },
  Event_129227_Name = {
    Text = "Thỉnh Cầu Của Bướm"
  },
  Event_129228_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129228_Name = {
    Text = "Quên lãng Chương 7@"
  },
  Event_129229_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129229_Name = {
    Text = "Quên lãng Chương 7@"
  },
  Event_129230_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129230_Name = {
    Text = "Quên lãng chương 1@"
  },
  Event_129231_ChoiceDesc1 = {
    Text = "[Nhận diện lời bài hát] nhận được bạc tạo vật \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_129231_ChoiceDesc2 = {
    Text = "[Khe khẽ ngân nga] Nhận Khắc ấn 3 chọn 1, lặp lại 2 lần"
  },
  Event_129231_Desc = {
    Text = "Bài hát cổ xưa của con tàu vang vọng trong thâm cảnh. \nNhững ký ức bị mắc kẹt trong thâm cảnh dùng ngôn ngữ bạn chưa từng nghe, hát lên về sóng biển, bầu trời và rượu cay nồng."
  },
  Event_129231_Name = {
    Text = "Bài hát biển cả"
  },
  Event_129232_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129232_Name = {
    Text = "Quên lãng chương 8@"
  },
  Event_129233_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129233_Name = {
    Text = "Bài sao Chương 1@"
  },
  Event_129234_ChoiceDesc1 = {
    Text = "[Cắt lòng bàn tay] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\" hai lần, Lây Nhiễm \"(Skill.Arg2)\" hai lần"
  },
  Event_129234_ChoiceDesc2 = {
    Text = "[Chấp nhận sự phát triển] nhận được tàn tích bạc「(RelicConfig.Arg1)」，nhiễm「(Skill.Arg2)」"
  },
  Event_129234_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_129234_Desc = {
    Text = "Con bướm không phải bay đến, mà là từ lòng bàn tay bạn từ từ sinh trưởng. \n Bạn ban đầu tưởng chỉ là mồ hôi, nhưng lại thấy chất lỏng màu đen như máu chảy ngược một cách lặng lẽ từ các kẽ tay, đông đặc thành những đôi cánh lạnh lẽo và đang đập. \n Mỗi lần vỗ cánh, đều làm dậy lên những gợn sóng trong dòng máu của bạn."
  },
  Event_129234_Name = {
    Text = "Ký sinh thượng lưu"
  },
  Event_129235_ChoiceDesc1 = {
    Text = "[Tiếp tục lật xem] Thẻ lệnh ngẫu nhiên nhận Khắc ấn: [(EnchantConfig.Arg1)] hai lần"
  },
  Event_129235_ChoiceDesc2 = {
    Text = "[Rời đi] tăng Arg1 máu tối đa, nhiễm [(Skill.Arg2)]"
  },
  Event_129235_Desc = {
    Text = "Một chiếc cân dùng để cân trọng lượng. \n Phía sau nó, vô số cơ quan ngâm trong formalin đỏ. \n Chúng được xếp ngăn nắp trên các kệ lưu trữ. \n Bạn tiện tay nhặt quyển sổ bên cạnh và lật xem: \n \"Trái tim: 8 ounce, Não: 50 ounce...\""
  },
  Event_129235_Name = {
    Text = "Đăng ký cơ quan"
  },
  Event_129236_ChoiceDesc1 = {
    Text = "[đi đường vòng] xóa 1 thẻ lệnh, nhận Arg1 dấu đen"
  },
  Event_129236_ChoiceDesc2 = {
    Text = "[hỏi tại sao chìm] sao chép 1 thẻ lệnh, nhiễm [(Skill.Arg1)]"
  },
  Event_129236_ChoiceDesc3 = {
    Text = "[Chào hỏi Thuyền viên] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: [(EnchantConfig.Arg1)], lặp lại 2 lần"
  },
  Event_129236_Desc = {
    Text = "Đi trên con đường đến phòng động lực, bạn một lần nữa gặp phải những \"ký ức\" bị cố định trong thâm cảnh. \nHọ không phải là hồn ma, chỉ là sự bận tâm của thuyền trưởng Elton đối với những thủy thủ đã khuất."
  },
  Event_129236_Name = {
    Text = "Chủ nhân của tàu Sonanir"
  },
  Event_129237_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129237_Name = {
    Text = "Quên lãng Chương 3@"
  },
  Event_129238_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129238_Name = {
    Text = "Bài sao Chương 1@"
  },
  Event_129239_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129239_Name = {
    Text = "Quên lãng Chương 6@"
  },
  Event_129240_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129240_Name = {
    Text = "Quên lãng chương 5@"
  },
  Event_129241_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129241_Name = {
    Text = "Bài sao Chương 4@"
  },
  Event_129242_ChoiceDesc1 = {
    Text = "[Biểu diễn cho anh ấy nghe] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\" hai lần, Lây Nhiễm \"(Skill.Arg2)\" hai lần"
  },
  Event_129242_ChoiceDesc2 = {
    Text = "[Lắng nghe tiếng đàn] Mỗi thân thể được đánh thức có điên cuồng ≥50 nhận được 15 dấu đen"
  },
  Event_129242_ChoiceDesc3 = {
    Text = "[Rời đi] Nhận Khắc ấn 3 chọn 1 hai lần"
  },
  Event_129242_Desc = {
    Text = "\"Thân gửi John: \n    Dạo này, tôi chợt nhận ra rằng đã nhiều năm trôi qua kể từ lần cuối bạn chơi piano cho chúng tôi nghe. \n    Năm nay tôi 81 tuổi rồi, càng lớn tuổi thì những kỷ niệm thời trẻ càng trở nên quý giá hơn bao giờ hết. \n    Nếu bạn nhận được bức thư này, mong rằng khi bạn ghé qua Lentiennam lần tới, bạn sẽ dừng chân trước căn hộ của tôi và chơi giúp tôi một bản nhạc nhé.\""
  },
  Event_129242_Name = {
    Text = "Sonata của tiếc nuối"
  },
  Event_129243_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129243_Name = {
    Text = "Bài sao Chương 3@"
  },
  Event_129244_ChoiceDesc1 = {
    Text = "[Nói rằng mình không có ví] Nhận Khắc ấn chọn 1 trong 3 hai lần"
  },
  Event_129244_ChoiceDesc2 = {
    Text = "[Phá lưới] 1 thẻ lệnh ngẫu nhiên nhận Khắc ấn: \"(EnchantConfig.Arg1)\" hai lần, lây nhiễm \"(Skill.Arg2)\" hai lần"
  },
  Event_129244_Desc = {
    Text = "Mạng màu cam vàng nổi lơ lửng trong không trung, lỗ hổng thưa thớt, xa thua kém sự tinh xảo của người họ hàng xa là con nhện đang trú ngụ ở chân tường. \n Bạn không thể cưỡng lại chạm vào, mạng yếu đuối tan vỡ ngay lập tức, tiếng cười đùa của trẻ em vang lên bên tai bạn. \n \"Vàng bạc vàng đỏ, tất cả ví tiền đều là của chúng ta!\""
  },
  Event_129244_Name = {
    Text = "Mạng lưới lạc lối"
  },
  Event_129245_ChoiceDesc1 = {
    Text = "[Chọn cảm tính]khôi phục Arg1 điểm cuộc sống"
  },
  Event_129245_ChoiceDesc2 = {
    Text = "[Duy trì lý trí] 1 thẻ lệnh ngẫu nhiên nhận Khắc ấn: [(EnchantConfig.Arg1)] hai lần"
  },
  Event_129245_ChoiceDesc3 = {
    Text = "[Từ chối lựa chọn]nhận 25 Ấn ký đen"
  },
  Event_129245_Desc = {
    Text = "\"Hãy chọn, hãy chọn.\"\nTrong bóng tối đang điên cuồng, vang lên vô số tiếng thì thầm.\nGiọng nói này mềm mại ru ngủ, dường như mang theo vô hạn ma lực, khiến bạn cảm thấy một loại ảo giác điên cuồng nào đó.\nNão của bạn rơi vào trạng thái điên đảo, rời khỏi cơ thể, trong khi trái tim dường như đã hình thành ra một loại ý thức, gọi bạn kêu gào.\n \"Hãy chọn, hãy chọn.\"\n \"Duy trì lý trí hay cảm tính, bạn phải đưa ra sự lựa chọn.\""
  },
  Event_129245_Name = {
    Text = "Giá của nhân loại"
  },
  Event_129246_ChoiceDesc1 = {
    Text = "[Tiêu diệt tế phẩm] nhận được vật bị nguyền rủa \"(RelicConfig.Arg1)\", bị nhiễm \"(Skill.Arg2)\""
  },
  Event_129246_ChoiceDesc2 = {
    Text = "[Tháo dây thừng] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: [(EnchantConfig.Arg1)], lặp lại 2 lần"
  },
  Event_129246_ChoiceDesc3 = {
    Text = "[Tiếp tục tiến lên] nhận được 50 dấu đen"
  },
  Event_129246_Desc = {
    Text = "Ba người Aran bị trói trên bục cao. \nTrên người họ xuất hiện những đường vân tối giống vỏ cây, miệng thì lẩm bẩm."
  },
  Event_129246_Name = {
    Text = "ba vật tế"
  },
  Event_129247_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129247_Name = {
    Text = "Bài sao Chương 3@"
  },
  Event_129248_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129248_Name = {
    Text = "Quên lãng Chương 6@"
  },
  Event_129249_ChoiceDesc1 = {
    Text = "[Struggle Forward] xóa 1 thẻ lệnh, nhận Arg1 dấu đen"
  },
  Event_129249_ChoiceDesc2 = {
    Text = "[Cắt đứt sợi chỉ] sao chép 1 thẻ lệnh, lây nhiễm [(Skill.Arg1)]"
  },
  Event_129249_ChoiceDesc3 = {
    Text = "[Nhẫn nhịn không nói] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: [(EnchantConfig.Arg1)], lặp lại 2 lần"
  },
  Event_129249_Desc = {
    Text = "Trên đường đi, bạn bị đẩy về phía trước, tất cả sự lựa chọn của bạn đều bị những sợi chỉ vô hình điều khiển. \n Bạn cố gắng vùng vẫy đôi tay, muốn nắm bắt mọi thứ mà bạn quan tâm. \n Số phận của thế giới treo lơ lửng trước đầu ngón tay bạn. \n Vô số sợi chỉ quấn quanh, trói buộc toàn thân bạn."
  },
  Event_129249_Name = {
    Text = "Đôi tay bị thao túng"
  },
  Event_129250_ChoiceDesc1 = {
    Text = "[Hỏi đường anh ấy] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\" hai lần, nhiễm \"(Skill.Arg2)\" hai lần"
  },
  Event_129250_ChoiceDesc2 = {
    Text = "[Rời khỏi nó] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_129250_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_129250_Desc = {
    Text = "Bóng đứng dưới cột đèn đường cao và mảnh. \n \"Xin lỗi, ngài có thể cho tôi mượn lửa được không?\"\nBạn không có thói quen @2, nhưng bạn không ngại sử dụng một chút \"phép màu nhỏ\". \nNhờ sự giúp đỡ của bạn, bóng đã đưa @2 đang cháy vào xoáy đen sâu thẳm không thấy đáy. \nChẳng mấy chốc, bạn nhìn thấy khói trắng bốc lên. \n \"À——\"\nBóng phát ra tiếng thở dài đầy thích thú, như thể vừa trải qua khoảnh khắc thư thái nhất."
  },
  Event_129250_Name = {
    Text = "Hình bóng dưới đèn đường"
  },
  Event_129251_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129251_Name = {
    Text = "Quên lãng chương 1@"
  },
  Event_129252_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129252_Name = {
    Text = "Quên lãng chương 8@"
  },
  Event_129253_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129253_Name = {
    Text = "Quên lãng Chương 3@"
  },
  Event_129254_ChoiceDesc1 = {
    Text = "[Chấp nhận ảo giác] Thẻ lệnh ngẫu nhiên nhận Khắc ấn: \"(EnchantConfig.Arg1)\" hai lần, nhiễm \"(Skill.Arg2)\" hai lần"
  },
  Event_129254_ChoiceDesc2 = {
    Text = "[Phủ nhận ảo giác] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: [(EnchantConfig.Arg1)] hai lần"
  },
  Event_129254_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_129254_Desc = {
    Text = "Dưới cây cầu sắt nặng nề trong bóng tối, trên bãi sông tĩnh lặng đầy lau sậy, bỗng nhiên một con bướm phát sáng bay ra. \n Con bướm nhẹ nhàng đậu trên lòng bàn tay bạn, những tiếng hét tồi tệ đã ngừng lại, thay vào đó là tiếng gầm rú của tàu hỏa chạy qua những khung thép rỉ sét, tiếng lách cách của than đang cháy, tiếng ma sát kim loại của trục quay..."
  },
  Event_129254_Name = {
    Text = "Ảo giác đường sắt"
  },
  Event_129255_ChoiceDesc1 = {
    Text = "[Chọn từ chối]xóa 1 thẻ lệnh，nhận Ấn ký đen Arg1"
  },
  Event_129255_ChoiceDesc2 = {
    Text = "[Chọn tuân theo]sao chép 1 thẻ lệnh，nhiễm「(Skill.Arg1)」"
  },
  Event_129255_ChoiceDesc3 = {
    Text = "[Chọn ôm ấp] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: [(EnchantConfig.Arg1)] hai lần"
  },
  Event_129255_Desc = {
    Text = "\"Tôi là một con chim trong lồng, bị giam trong một cái sân đầy những căn phòng.\"\nBóng dáng mờ nhạt lang thang trong bóng tối, đó là sự níu kéo từ những người đã khuất.\n \"Họ nói, đó là bệnh viện tâm thần, nhưng tôi biết, đó là một cái lồng đặc biệt của con người, giam giữ những con chim tự do không chịu tuân theo quy tắc xã hội.\"\n \"Nhưng nếu chim không thể bay, thì có thể gọi nó là chim không?\"\nNhững nỗi ám ảnh kéo đến gần bạn, cầu xin sự cứu rỗi.\n \"Xin hãy gãy cánh tôi, tôi đã chán ngấy việc bay.\""
  },
  Event_129255_Name = {
    Text = "Người rỗng"
  },
  Event_129256_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129256_Name = {
    Text = "Quên lãng Chương 2@"
  },
  Event_129257_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129257_Name = {
    Text = "Bài sao Chương 2@"
  },
  Event_129258_ChoiceDesc1 = {
    Text = "[Thả bướm bay] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", lặp lại 2 lần, lây nhiễm \"(Skill.Arg2)\", lặp lại 2 lần"
  },
  Event_129258_ChoiceDesc2 = {
    Text = "[trở thành bướm] được nhận món đồ tạo tác bằng bạc \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_129258_ChoiceDesc3 = {
    Text = "[nuốt vào bụng] nhận được 25 dấu đen"
  },
  Event_129258_Desc = {
    Text = "Đêm nay đã xảy ra quá nhiều chuyện. \n Cảng bị tấn công, tàu ma, người dấn thân vào biển, tulô, Muphí, Ramona…… mọi thứ đều xoay tròn trong Vortex, bị khuấy lên như cháo yến mạch lúc bảy giờ sáng tại nhà hàng Misaque. \n Muốn hỏi người Thể thức tỉnh trước mặt, nhưng không biết phải bắt đầu từ đâu, như bị mắc nghẹn — hoặc nói cách khác, như bướm trong dạ dày."
  },
  Event_129258_Name = {
    Text = "Hiệu ứng bướm"
  },
  Event_129259_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129259_Name = {
    Text = "Quên lãng chương 8@"
  },
  Event_129260_ChoiceDesc1 = {
    Text = "[Mặc kệ ở lại] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\" hai lần, nhiễm \"(Skill.Arg2)\" hai lần"
  },
  Event_129260_ChoiceDesc2 = {
    Text = "[Vẫy tay xua đuổi] nhận được bạc tạo vật \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_129260_ChoiceDesc3 = {
    Text = "[đón bướm] nhận được 25 dấu đen"
  },
  Event_129260_Desc = {
    Text = "Các bạn lang thang trong bệnh viện dưỡng lão giữa cơn gió lạnh buốt, một con bướm đen không nên tồn tại trong mùa này bay đến nhẹ nhàng. \n Con bướm vỗ cánh, mang theo chất lỏng đen sền sệt, bay lượn lên xuống. Những lớp chất lỏng đen đặc tuôn ra từ cánh, sau khi đông cứng thì bị gió làm bong tróc. \n Nó mệt mỏi sau khi bay và đậu trên đầu ngón tay của bạn."
  },
  Event_129260_Name = {
    Text = "Điều không nên tồn tại"
  },
  Event_129261_ChoiceDesc1 = {
    Text = "[Ôn lại quá khứ] Nhận đá khắc cao cấp 3 chọn 1, lặp lại 2 lần"
  },
  Event_129261_ChoiceDesc2 = {
    Text = "[Dòm ngó tương lai]nhận được vật tạo vàng「(RelicConfig.Arg1)」, nhiễm「(Skill.Arg2)」"
  },
  Event_129261_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 50 dấu đen"
  },
  Event_129261_Desc = {
    Text = "Trên đời không có gì có thể vững chắc bất biến.\nNgay cả lạc viên do Thần Mẫu tạo ra cũng vậy.\nTrong khoảnh khắc ngắn ngủi, bạn thoáng thấy một vài thứ từ khe nứt thời không.\nQuá khứ, hiện tại, tương lai đan xen trong kẽ nứt chi chít ấy, không ngừng biến đổi.\nChờ đợi sự tò mò dòm ngó của bạn."
  },
  Event_129261_Name = {
    Text = "Khe Nứt Thời Không"
  },
  Event_129262_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129262_Name = {
    Text = "Quên lãng Chương 7@"
  },
  Event_129263_ChoiceDesc1 = {
    Text = "[Phớt lờ nó] Nhận Khắc ấn 3 chọn 1 hai lần"
  },
  Event_129263_ChoiceDesc2 = {
    Text = "[Chạm vào nó] 1 thẻ lệnh ngẫu nhiên nhận Khắc ấn: \"(EnchantConfig.Arg1)\" hai lần, Lây Nhiễm \"(Skill.Arg2)\" hai lần"
  },
  Event_129263_Desc = {
    Text = "Một thứ kỳ lạ giống như bào tử đã thu hút sự chú ý của bạn.\nNó giống như một con sứa mỏng manh được tạo thành từ máu thịt, cũng giống như sợi thần kinh lưu trữ tín hiệu trong sâu thẳm của não.\n\"Hãy đến chạm vào tôi.\" Nó không tiếng động cám dỗ bạn, \"Tôi sẽ, cho bạn thấy một ký ức tàn nhẫn.\""
  },
  Event_129263_Name = {
    Text = "Ký ức sâu sắc"
  },
  Event_129264_ChoiceDesc1 = {
    Text = "[Đắm chìm ảo tưởng] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\" hai lần, Lây Nhiễm \"(Skill.Arg2)\" hai lần"
  },
  Event_129264_ChoiceDesc2 = {
    Text = "[Giữ lý trí] Với mỗi thân thể được đánh thức có mức điên cuồng đạt từ 50 trở lên, nhận được 15 dấu đen"
  },
  Event_129264_ChoiceDesc3 = {
    Text = "[Rời đi cưỡng bức] Nhận Khắc ấn 3 chọn 1, lặp lại 2 lần"
  },
  Event_129264_Desc = {
    Text = "Có lẽ chiến đấu lâu dài khiến bạn rơi vào trạng thái mơ hồ, hoặc có lẽ chỉ là bộ não đã phản bội cơ thể bạn.\nMột cảm giác mất trọng lực xuất hiện trong đầu bạn.\nTrong khoảnh khắc, đầu óc bạn bỗng biến thành kính vạn hoa, rực rỡ, muôn màu, lấp lánh ánh sáng ngũ sắc.\nVô số cảm hứng, ảo tưởng và cuồng tưởng ùa vào não, chiếm cứ mọi ngóc ngách trong đầu bạn.\nCứ tiếp tục thế này, đầu bạn sẽ sớm bị những thứ hỗn loạn này làm nổ tung."
  },
  Event_129264_Name = {
    Text = "Kính vạn hoa tư duy"
  },
  Event_129265_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129265_Name = {
    Text = "Quên lãng chương 5@"
  },
  Event_129266_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129266_Name = {
    Text = "Quên lãng chương 4@"
  },
  Event_129267_ChoiceDesc1 = {
    Text = "[Lắng nghe] Nhận đá khắc cao cấp 3 chọn 1, lặp lại 2 lần"
  },
  Event_129267_ChoiceDesc2 = {
    Text = "[ Hét ] Nhận được báu vật bằng vàng \"(RelicConfig.Arg1)\", nhiễm kỹ năng \"(Skill.Arg2)\""
  },
  Event_129267_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 50 dấu đen"
  },
  Event_129267_Desc = {
    Text = "Kể từ khi tai nạn xảy ra, bạn không còn nhận được tin tức nào từ đối tác. \n Vô số liên lạc được gửi đi, như thể rơi xuống biển cả không có tiếng vọng. \n Vào lúc bạn đã không còn hy vọng, thiết bị liên lạc bỗng phát ra âm thanh. \n Bạn mở vali, đưa ống nghe điện thoại gần tai. \n \"Người giữ bí mật…\" \n Trong cơn mơ màng, bạn nghe thấy giọng nói mà bạn luôn nhớ thương, như thể vọng lại từ xa xôi qua nhiều lớp hư không."
  },
  Event_129267_Name = {
    Text = "Giai điệu nhớ nhung"
  },
  Event_129268_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129268_Name = {
    Text = "Quên lãng chương 1@"
  },
  Event_129269_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129269_Name = {
    Text = "Bài sao Chương 1@"
  },
  Event_129270_ChoiceDesc1 = {
    Text = "[Trực diện nguồn gốc chó địa ngục] nhận được vật tạo vàng \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_129270_ChoiceDesc2 = {
    Text = "[Tập trung chiến đấu] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: [(EnchantConfig.Arg1)], lặp lại 2 lần"
  },
  Event_129270_Desc = {
    Text = "Dáng vẻ của chó địa ngục thay đổi. \n Thân thể của hắn kết nối với khe hở trên tường, tỏa ra ảo ảnh quái lạ."
  },
  Event_129270_Name = {Text = "từ góc"},
  Event_129271_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129271_Name = {
    Text = "Quên lãng Chương 2@"
  },
  Event_129272_ChoiceDesc1 = {
    Text = "[Ghép giấy] nhận được vật tạo vàng \"(RelicConfig.Arg1)\", bị nhiễm \"(Skill.Arg2)\""
  },
  Event_129272_ChoiceDesc2 = {
    Text = "[Đọc sách] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: [(EnchantConfig.Arg1)] hai lần"
  },
  Event_129272_ChoiceDesc3 = {
    Text = "[đánh bỏ nó] nhận được 50 dấu đen"
  },
  Event_129272_Desc = {
    Text = "Một tờ giấy vàng ố rơi ra từ chiếc áo choàng của đám tín đồ cầm đèn. \n Trên giấy có rất nhiều văn bản kỳ lạ được viết, có cái giống như ký hiệu hình tượng, có cái thì kỳ quái vươn lên, có cái chữ còn chồng chéo lên nhau, chỉ có một ít chữ có thể nhận ra một cách khó khăn. \n Tiêu đề là《@2 Sự ra đời của Con Thánh》"
  },
  Event_129272_Name = {
    Text = "Lệnh bí mật·dưới"
  },
  Event_129273_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129273_Name = {
    Text = "Quên lãng Chương 2@"
  },
  Event_129274_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129274_Name = {
    Text = "Bài sao Chương 2@"
  },
  Event_129275_ChoiceDesc1 = {
    Text = "[Chuẩn bị chiến đấu] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", lặp lại 2 lần, nhiễm \"(Skill.Arg2)\", lặp lại 2 lần"
  },
  Event_129275_ChoiceDesc2 = {
    Text = "[Thử đi đường vòng]được tặng 25 dấu đen"
  },
  Event_129275_Desc = {
    Text = "Giữa biển sâu nơi ánh sao rơi xuống, những kẻ đạp biển đã ẩn mình suốt hàng ngàn năm.\nBiển nước vô tận đã chứng kiến sự điên cuồng của họ, chứng kiến sự nhẫn nại của họ, và cũng chứng kiến đức tin thành kính nhất của họ đối với thần linh.\nKhông ai có thể ngăn cản sự giáng lâm vĩ đại của thần linh.\nBất kỳ kẻ cản đường nào, đều sẽ hóa thành tro tàn trong cơn thịnh nộ của những kẻ đạp biển."
  },
  Event_129275_Name = {
    Text = "Chờ đợi dưới quần tinh"
  },
  Event_129276_ChoiceDesc1 = {
    Text = "[gõ vài nốt nhạc] nhận được bạc sáng tạo \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_129276_ChoiceDesc2 = {
    Text = "[Đậy nắp lại] Nhận Khắc ấn chọn 1 trong 3 hai lần"
  },
  Event_129276_Desc = {
    Text = "Chiếc piano bên tường mở nắp. Nó có những phím đàn ngả vàng và các cạnh nứt nhẹ để lộ màu gỗ tự nhiên, nhưng mỗi phím đàn đều được lau chùi rất sạch sẽ. \nNó là nguồn vui của biết bao nhiêu người."
  },
  Event_129276_Name = {
    Text = "Melodi tuổi thơ"
  },
  Event_129277_ChoiceDesc1 = {
    Text = "[Chấp nhận ảo giác] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\" hai lần, nhiễm \"(Skill.Arg2)\" hai lần"
  },
  Event_129277_ChoiceDesc2 = {
    Text = "[Phủ nhận ảo giác] nhận được bạc tạo vật \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_129277_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_129277_Desc = {
    Text = "Dưới cây cầu sắt nặng nề trong bóng tối, trên bãi sông tĩnh lặng đầy lau sậy, bỗng nhiên một con bướm phát sáng bay ra. \n Con bướm nhẹ nhàng đậu trên lòng bàn tay bạn, những tiếng hét tồi tệ đã ngừng lại, thay vào đó là âm thanh đều đặn của những công nhân vận chuyển thép, tiếng búa đóng đinh, tiếng kim loại va chạm của đinh tán..."
  },
  Event_129277_Name = {
    Text = "ảo giác của cây cầu thép"
  },
  Event_129278_ChoiceDesc1 = {
    Text = "[Trưng bày lời nguyền] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\" hai lần, nhiễm \"(Skill.Arg2)\" hai lần"
  },
  Event_129278_ChoiceDesc2 = {
    Text = "[Từ chối con quạ] Nhận Khắc ấn chọn 1 trong 3, lặp lại 2 lần"
  },
  Event_129278_ChoiceDesc3 = {
    Text = "[phớt lờ]"
  },
  Event_129278_Desc = {
    Text = "Đàn quạ đa đầu đen tối và bệnh hoạn bay ra từ áo choàng đen của một đám tín đồ cầm đèn, đậu lên vai bạn. \n \"Có thấy đầu tôi không? Chỉ cần nếm thử lời nguyền, tôi sẽ mọc ra đầu mới. Hãy để tôi xem nào, lời nguyền của bạn!\""
  },
  Event_129278_Name = {
    Text = "Quạ Nguyền Rủa"
  },
  Event_129279_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129279_Name = {
    Text = "Quên lãng Chương 7@"
  },
  Event_129280_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129280_Name = {
    Text = "Quên lãng Chương 3@"
  },
  Event_129281_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129281_Name = {
    Text = "Quên lãng chương 4@"
  },
  Event_129282_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129282_Name = {
    Text = "Quên lãng Chương 2@"
  },
  Event_129283_ChoiceDesc1 = {
    Text = "[Văn bản tạm thời]."
  },
  Event_129283_Name = {
    Text = "Bài sao Chương 2@"
  },
  Event_129900_ChoiceDesc1 = {
    Text = "[An táng] trả lại Arg2 điểm sức sống [ExDesc1], chọn 1 lá thẻ lệnh để xóa."
  },
  Event_129900_ChoiceDesc2 = {
    Text = "[Cầu nguyện] nhận được hoàng kim tạo vật \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_129900_Desc = {
    Text = "Một đoạn xương trắng bệch, nửa chìm trong dung dịch rỗng rỗng màu đen."
  },
  Event_129900_Name = {
    Text = "Xương phai màu"
  },
  Event_130337_ChoiceDesc1 = {
    Text = "[Nhập Tọa]Đặt「Con Rối Dây」vào bộ bài."
  },
  Event_130337_Desc = {
    Text = "Khi đôi chân bạn bước lên bậc thềm nhà hát, ánh mắt không thể rời khỏi sân khấu này nữa.\nSợi tơ vận mệnh dẫn dắt vô số câu chuyện luân chuyển nơi đây — bụi trần của quá khứ, ánh sáng và bóng tối của hiện tại, sương mù của tương lai, tất cả đều cuộn trào không ngừng trước sân khấu.\nBạn quên mất mình đến từ đâu, muốn đi về đâu, dấu ấn về\"bản ngã\" tan biến trong bóng tối của bức màn. Lúc này, bạn là khán giả lặng im dưới hàng ghế, cũng là kép hát cháy bỏng trên sân khấu.\nToàn bộ ý nghĩa tồn tại của bạn, sụp đổ thành hai vết khắc: Ngắm nhìn, và Hiến diễn."
  },
  Event_130337_Name = {
    Text = "Sân Khấu Định Mệnh"
  },
  Event_131264_ChoiceDesc1 = {Text = "[đi]"},
  Event_131264_Desc = {
    Text = "Các ngươi đã chọn sức mạnh, chọn niềm tin kiên định và lòng dũng cảm tiến về phía trước không ngoảnh lại.\nNhưng, cái giá... ý nghĩa của cái giá tồn tại, chính là để gánh chịu, phải không?"
  },
  Event_131264_Name = {
    Text = "Ánh nhìn cố xưa"
  },
  Event_131265_ChoiceDesc1 = {Text = "[đi]"},
  Event_131265_Desc = {
    Text = "Ngươi chịu đựng cơn đau trong đầu, nắm chặt những ký ức đang tan tác, vỡ vụn. Dưới sự nhẫn nại gian nan của ngươi, những khe nứt bắt đầu được vá lại.\nNgươi ra đi vì để ghi nhớ, chiến đấu vì để ghi nhớ. Ngươi sẽ không cho phép bất kỳ ký ức nào rời xa mình."
  },
  Event_131265_Name = {
    Text = "Ký ức vỡ vụn"
  },
  Event_131266_ChoiceDesc1 = {
    Text = "[Bảo vệ ký ức]Nhận khắc ấn chọn 1 trong 3"
  },
  Event_131266_ChoiceDesc2 = {
    Text = "[Ngăn chặn khe nứt]Chọn 1 trong 3 thẻ chỉ lệnh để nhận khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_131266_Desc = {
    Text = "Ngươi chưa bao giờ nghi ngờ ký ức của mình. Chúng ấm áp, vững chắc, là bến cảng đáng tin cậy nhất và báu vật ngươi trân quý nhất.\nNhưng giờ đây, dưới sự can thiệp của Uyên Ngục, những ký ức ấy bắt đầu xuất hiện những vết nứt hỗn loạn."
  },
  Event_131266_Name = {
    Text = "Ký ức vỡ vụn"
  },
  Event_131267_ChoiceDesc1 = {Text = "[đi]"},
  Event_131267_Desc = {
    Text = "Sức mạnh tinh thần tràn vào tâm trí, vá lại những khe hở đáng sợ. Ngươi dốc hết sức lực, cuối cùng cũng khiến những vết nứt trở lại nguyên vẹn.\nNgươi ra đi vì để ghi nhớ, chiến đấu vì để ghi nhớ. Ngươi sẽ không cho phép bất kỳ ký ức nào rời xa mình."
  },
  Event_131267_Name = {
    Text = "Ký ức vỡ vụn"
  },
  Event_131268_ChoiceDesc1 = {Text = "[đi]"},
  Event_131268_Desc = {
    Text = "\"Hu hu hu hu... Ha ha ha ha!!\"\nKhông ai hiểu được câu hỏi của ngươi, họ đáp lại bằng tiếng khóc than và cười điên dại."
  },
  Event_131268_Name = {
    Text = "Kẻ bị ruồng bỏ"
  },
  Event_131269_ChoiceDesc1 = {Text = "[đi]"},
  Event_131269_Desc = {
    Text = "Các ngươi nhìn lại chúng. Sợi tơ rung động, ánh mắt dịu dàng ôm ký ức vào lòng.\nNgươi lặng lẽ nhìn kẻ thao túng vận mệnh ấy. Nếu được làm lại, nàng sẽ chọn điều gì?"
  },
  Event_131269_Name = {
    Text = "Ánh nhìn cố xưa"
  },
  Event_131270_ChoiceDesc1 = {Text = "[đi]"},
  Event_131270_Desc = {
    Text = "\"Hu hu hu hu... Ha ha ha ha!!\"\nTiếng khóc than và cười điên dại dần tan biến trước mặt ngươi. Không có hồn linh nào đến làm hại ngươi — họ đã quen với việc bị phớt lờ từ lâu rồi."
  },
  Event_131270_Name = {
    Text = "Kẻ bị ruồng bỏ"
  },
  Event_131271_ChoiceDesc1 = {
    Text = "[Ngắm nhìn ký ức]Nhận tạo vật hoàng kim \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_131271_ChoiceDesc2 = {
    Text = "[Lãng quên ký ức]Ngẫu nhiên giác tỉnh 2 Thể Hoán Tỉnh, nhiễm hai lần \"(Skill.Arg1)\""
  },
  Event_131271_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 50 dấu đen"
  },
  Event_131271_Desc = {
    Text = "Trong cơ thể cô gái, ngươi nghe thấy tiếng bình vỡ. Ký ức rời khỏi chiếc bình chứa, đến bên các ngươi.\nBạn chơi thuở nhỏ, món quà của cha mẹ, trí tưởng tượng thuần khiết nhất về mây trắng và chim bay, lý tưởng trắng trong như bầu trời... Tất cả ký ức mở mắt, lặng lẽ nhìn về phía các ngươi.\nChúng hỏi han. Chúng khóc lóc. Chúng chờ đợi."
  },
  Event_131271_Name = {
    Text = "Ánh nhìn cố xưa"
  },
  Event_131272_ChoiceDesc1 = {
    Text = "[Hỏi thăm] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_131272_ChoiceDesc2 = {
    Text = "[Không quan tâm] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_131272_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_131272_Desc = {
    Text = "Tiếng khóc thét chói tai vang lên bên tai ngươi, những hồn linh đau khổ đang xé nát khuôn mặt và thân thể của chính mình trước mặt ngươi...\nHọ là ai? Tù nhân của Uyên Ngục? Số phận bị ruồng bỏ? Ký ức bị chôn vùi?"
  },
  Event_131272_Name = {
    Text = "Kẻ bị ruồng bỏ"
  },
  Event_133380_ChoiceDesc1 = {
    Text = "[Xác nhận]"
  },
  Event_133380_Desc = {
    Text = "Bạn ngồi xuống chiếc ghế nhung đỏ thuộc về mình, bức màn đỏ thắm lặng lẽ kéo mở.\nKhán giả thân mến, sân khấu sẽ đáp lại kỳ vọng của bạn.\nDiễn viên chính của vở kịch này, đã bước lên sân khấu."
  },
  Event_133380_Name = {
    Text = "Sân Khấu Định Mệnh"
  },
  Event_141995_ChoiceDesc1 = {
    Text = "[Thử nghiệm đơn giản] Xóa tối đa 5 thẻ bài bất kỳ"
  },
  Event_141995_ChoiceDesc2 = {
    Text = "[Để anh ta nghiên cứu] Ngẫu nhiên xóa 5 thẻ lệnh, nhận được Di vật Được chúc phúc [(RelicConfig.Arg1)]."
  },
  Event_141995_ChoiceDesc3 = {
    Text = "[Suy nghĩ ngược lại?] Chọn tối đa hai Thể thức tỉnh, tạo ra một bộ thẻ bài cơ bản đầy đủ của họ và đặt vào bộ bài"
  },
  Event_141995_Desc = {
    Text = "Bạn đến một quảng trường, không ít người đi lại vội vã, có lẽ có thể tìm thấy điều gì đó thú vị ở đây.\nBạn gõ cửa một căn phòng thắp ánh đèn vàng mờ, một người ăn mặc như Nghiên cứu viên thò đầu ra. Bạn thấy nhiều thiết bị khoa học không rõ tên, anh ta kéo bạn ngồi xuống, tự xưng là một \"nhà tiến hóa học\". Anh ta đầy vẻ Cuồng nhiệt, ra sức giới thiệu với bạn \"phương pháp khoa học\" của mình.\n\"Chỉ khi xóa bỏ những thứ dư thừa nhàm chán trên con người, mới là con đường tiến hóa thực sự!\""
  },
  Event_141995_Name = {
    Text = "Nhà Tiến hóa học"
  },
  Event_141996_ChoiceDesc1 = {
    Text = "[Luyện tập đặc biệt về tấn công] Gắn Khắc ấn ngẫu nhiên cho tất cả các Đánh cơ bản không mang Khắc ấn"
  },
  Event_141996_ChoiceDesc2 = {
    Text = "[Luyện tập đặc biệt về phòng thủ] Gắn Khắc ấn ngẫu nhiên cho tất cả các Phòng thủ cơ bản không mang Khắc ấn"
  },
  Event_141996_ChoiceDesc3 = {
    Text = "[Luyện tập bất chấp tất cả] Gắn Khắc ấn ngẫu nhiên cho 15 thẻ lệnh ngẫu nhiên, nhận được 5 thẻ triệu chứng ngẫu nhiên"
  },
  Event_141996_Desc = {
    Text = "Bạn đến một quảng trường, không ít người đi lại vội vã, có lẽ có thể tìm thấy thứ gì thú vị ở đây. \nTiếng va chạm kim loại vang lên trên khoảng đất trống, vài người đang so tài với nhau, nâng cao võ nghệ, một chàng trai mặc áo giáp kiểu cũ chú ý đến bạn, ném cho bạn một thanh kiếm, Mời bạn cùng luyện tập với họ."
  },
  Event_141996_Name = {
    Text = "Thời gian luyện tập đặc biệt"
  },
  Event_141997_ChoiceDesc1 = {
    Text = "[Đặt lớn] 50% cơ hội nhận đá khắc ngẫu nhiên và Đặt cược lại, 50% cơ hội nhận 75 dấu đen"
  },
  Event_141997_ChoiceDesc2 = {
    Text = "[Đặt nhỏ] 50% cơ hội nhận đá khắc ngẫu nhiên và Đặt cược lại, 50% cơ hội nhận 75 dấu đen"
  },
  Event_141997_Desc = {
    Text = "Người phục vụ giữ nguyên nụ cười không đổi, nhấc bát xúc xắc lên, tiếng vang trong trẻo Tiếng vọng lại, các người chơi khác lần lượt đưa ra lựa chọn của mình. \"Mua rồi thì không đổi.\" Anh ta nói, \"Mời Đặt cược—\""
  },
  Event_141997_Name = {
    Text = "Sòng Bạc Ồn Ào"
  },
  Event_141998_ChoiceDesc1 = {
    Text = "[Đặt cược thật thà] Xóa một thẻ lệnh"
  },
  Event_141998_ChoiceDesc2 = {
    Text = "[Thử gian lận] Xóa một thẻ triệu chứng"
  },
  Event_141998_ChoiceDesc3 = {Text = "[đi]"},
  Event_141998_Desc = {
    Text = "Bạn đến một nơi vô cùng náo nhiệt, mọi người đều rạng rỡ hạnh phúc trên khuôn mặt, ánh đèn màu nháy mắt loạn xạ đẩy bóng đêm không còn chỗ trú. Còn những tấm biển hiệu khắp nơi ghi rằng: \"Chào mừng đến với Lễ Hội! Giấc mơ nơi đây không bao giờ Kết thúc, Hạnh phúc nơi đây mãi không Kết thúc buổi diễn!\"\nBị dòng người đông đúc xô đẩy, bạn bị đẩy vào một tòa nhà lộng lẫy, sảnh trong vàng son rực rỡ, tiếng người ồn ào náo nhiệt, không khí tràn ngập mùi rượu ngọt ngào. Một viên xúc xắc lăn lông lốc đến tận chân bạn, người phục vụ nở nụ cười nịnh nọt, nói với bạn đây là điềm may mắn. Mang theo sự tò mò, bạn bước thêm một bước về phía trước, có lẽ, có thể thể hiện bản thân trong trò chơi này."
  },
  Event_141998_Name = {
    Text = "Sòng Bạc Ồn Ào"
  },
  Event_141999_ChoiceDesc1 = {
    Text = "[Trao đổi hàng hóa] Xóa 1 Di vật, Xác suất 50% nhận được 1 trong 3 vật tạo vàng, Xác suất 50% nhận được 25 dấu đen"
  },
  Event_141999_ChoiceDesc2 = {Text = "[đi]"},
  Event_141999_Desc = {
    Text = "Bạn đến một nơi vô cùng náo nhiệt, mọi người đều rạng rỡ hạnh phúc trên Khuôn Mặt, những ngọn đèn màu nháy mắt chói lòa đẩy màn đêm không còn chỗ trú. Còn những tấm biển hiệu xuất hiện khắp nơi ghi rằng: \"Chào mừng đến với Lễ Hội Carnival! Nơi đây Giấc mơ không bao giờ Kết thúc, nơi đây Hạnh phúc mãi chẳng Kết thúc buổi diễn!\"\nTrong đám đông, một Thương nhân ăn mặc rách rưới nhưng mang theo một gói hàng to đến kinh ngạc vẫy tay về phía Bạn, anh ta vỗ vỗ vào gói hàng bên cạnh, ghé lại hạ giọng, gửi đến Bạn lời Mời Trao đổi hàng hóa, chiếc túi vải cũ kỹ nhẹ nhàng đung đưa theo tiếng nói của anh ta, thỉnh thoảng còn phát ra tiếng kẽo kẹt."
  },
  Event_141999_Name = {
    Text = "Thương nhân Rách Rưới"
  },
  Event_142000_ChoiceDesc1 = {
    Text = "[Thử Cầu Nguyện] Tiêu hao 50% Sinh lực hiện tại, nhận được 2 vật tạo vàng ngẫu nhiên"
  },
  Event_142000_ChoiceDesc2 = {
    Text = "[Dốc lòng cầu nguyện] Tiêu thụ 99% Sinh lực hiện tại, nhận được bàn lắc thời linh [(RelicConfig.Arg2)]"
  },
  Event_142000_ChoiceDesc3 = {
    Text = "[Thò tay mò đáy hồ] Nhận được vật tạo vàng [(RelicConfig.Arg1)]"
  },
  Event_142000_Desc = {
    Text = "gió thổi qua vùng ngoại ô, bốn bề tĩnh lặng, Chỉ có tiếng xào xạc của cây cối vang lên.\nBỗng nhiên, Bạn nghe thấy tiếng gì đó chảy róc rách, đi theo tiếng động, mùi tanh ngọt nồng nặc ập đến trước, Bạn cuối cùng nhìn rõ nguồn gốc của tiếng nước chảy đó — đó là một hồ ước nguyện, chứa đầy màu đỏ thắm, Máu của vô số người đang Sóng động Tại trong hồ, Dường như có thứ gì đó bên dưới mặt nước sắp nhảy vọt lên.\nTiếng nói vang lên sát đáy lòng Bạn: \"Hãy dâng lên Máu của Bạn, ta sẽ ban cho Bạn ân huệ.\""
  },
  Event_142000_Name = {
    Text = "Suối Máu"
  },
  Event_142001_ChoiceDesc1 = {
    Text = "[cúng bái Đơn Giản] Chọn xóa 2 Di vật, nhận được Tạo Vật Mang Tội [(RelicConfig.Arg1)]"
  },
  Event_142001_ChoiceDesc2 = {
    Text = "[cúng bái Thành Tâm] Chọn xóa 4 Di vật, nhận được Di vật Được chúc phúc [(RelicConfig.Arg1)]"
  },
  Event_142001_ChoiceDesc3 = {
    Text = "[Lấy Trộm Chút Lễ Vật, Không Ai Biết Đâu] Nhận được vật tạo vàng [(RelicConfig.Arg1)]"
  },
  Event_142001_Desc = {
    Text = "gió thổi qua vùng ngoại ô, bốn bề tĩnh lặng, Chỉ có tiếng xào xạc của cây cối vang lên.\nKhông hay biết từ lúc nào, Bạn đến trước một bàn thờ cổ xưa, bức tượng khổng lồ từ trên cao Nhìn chằm chằm xuống Bạn, dường như muốn lấy đi thứ gì đó từ tay Bạn. Bạn thấy ngay bên dưới bàn thờ khắc những dòng chữ mờ nhạt — \"Được mất tương xứng\"."
  },
  Event_142001_Name = {
    Text = "Bàn Thờ Được Mất"
  },
  Event_142002_ChoiceDesc1 = {
    Text = "[Trải nghiệm miễn phí] Ngẫu nhiên Nâng cấp Arg2 bạc tạo vật"
  },
  Event_142002_ChoiceDesc2 = {
    Text = "[Dịch vụ thông thường] Tiêu thụ Arg1 dấu đen: Ngẫu nhiên Nâng cấp Arg2 bạc tạo vật"
  },
  Event_142002_ChoiceDesc3 = {
    Text = "[Dịch vụ cao cấp] Tiêu thụ Arg1 dấu đen: Ngẫu nhiên Nâng cấp Arg2 bạc tạo vật"
  },
  Event_142002_Desc = {
    Text = "Bạn đến một quảng trường, không ít người đi lại vội vã, có lẽ có thể tìm thấy điều gì đó thú vị ở đây.\nTòa nhà nhỏ thắp ánh đèn ấm áp đứng lặng lẽ ở một góc quảng trường, trông có vẻ là một hội quán Nâng cao, nhưng tấm biển tối màu treo trên tường lại ghi rõ ràng: \"Cửa hàng này chỉ phục vụ những tồn tại ngoài sinh vật.\""
  },
  Event_142002_Name = {
    Text = "Hội quán Đặc biệt"
  },
  Event_142003_ChoiceDesc1 = {
    Text = "[Rút một lần] Nhận một thẻ triệu chứng"
  },
  Event_142003_ChoiceDesc2 = {
    Text = "[Rời đi] Nhận 75 dấu đen"
  },
  Event_142003_Desc = {
    Text = "Bạn đến một nơi vô cùng náo nhiệt, mọi người đều rạng rỡ hạnh phúc trên khuôn mặt, ánh đèn màu nháy mắt loạn xạ đẩy bóng đêm không còn chỗ trú. Còn những tấm biển hiệu khắp nơi ghi rằng: \"Chào mừng đến với Lễ Hội! Giấc mơ nơi đây không bao giờ Kết thúc, Hạnh phúc nơi đây mãi không Kết thúc buổi diễn!\"\nBạn chú ý đến một quầy xổ số bên Đường, đông nghịt người, Ánh Mắt của Mọi người đều tập trung vào giải thưởng lớn được che kín mít — Chủ sạp ra sức tuyên truyền về sự quý hiếm của nó, mọi người tranh nhau tham gia."
  },
  Event_142003_Name = {
    Text = "Thử Thách Xổ Số"
  },
  Event_142004_ChoiceDesc1 = {
    Text = "[Mượn dùng một chút]"
  },
  Event_142004_ChoiceDesc2 = {Text = "[đi]"},
  Event_142004_Desc = {
    Text = "Gió thổi qua vùng ngoại ô, bốn bề yên tĩnh, chỉ có tiếng xào xạc của cây cối. \nBỗng nhiên, bạn nhìn thấy một túp lều tranh cũ nát, chính giữa đặt một cái đe, bên cạnh còn có nhiều vũ khí kim loại đã gỉ sét, nơi này có vẻ là một lò rèn đã bỏ hoang từ lâu. Cạnh cái đe có hướng dẫn sử dụng chi tiết, cho bạn biết có thể đặt Di vật vào đây để cải tạo."
  },
  Event_142004_Name = {Text = "Lò rèn"},
  Event_142005_ChoiceDesc1 = {
    Text = "[Đặt cược thật thà] Xóa một thẻ lệnh"
  },
  Event_142005_ChoiceDesc2 = {
    Text = "[Thử gian lận] Xóa một thẻ triệu chứng"
  },
  Event_142005_ChoiceDesc3 = {Text = "[đi]"},
  Event_142005_Desc = {
    Text = "Tiếng Chúc mừng của những người xung quanh báo hiệu chiến thắng của bạn, trong tiếng ồn ào náo nhiệt, cuối cùng bạn cũng giống như họ, đắm chìm trong giấc mơ kỳ lạ này khi đặt cược tất cả. Bạn nhìn vào những con chip trong tay, Dường như chúng là những người bạn đồng hành trung thành nhất mang lại vinh quang cho bạn, tiếng Thầm thì truyền đến từ sâu trong bàn Đặt cược, mang theo một lời thỉnh cầu mơ hồ: \"do it again, hãy thắng thêm một lần nữa.\""
  },
  Event_142005_Name = {
    Text = "Sòng Bạc Ồn Ào"
  },
  Event_142013_ChoiceDesc1 = {
    Text = "[Đặt lớn] 50% cơ hội nhận bạc tạo vật ngẫu nhiên và Đặt cược lại, 50% cơ hội nhận 75 dấu đen và vào chiến đấu Élite"
  },
  Event_142013_ChoiceDesc2 = {
    Text = "[Đặt nhỏ] 50% cơ hội nhận bạc tạo vật ngẫu nhiên và Đặt cược lại, 50% cơ hội nhận 75 dấu đen và vào chiến đấu Élite"
  },
  Event_142013_Desc = {
    Text = "Người phục vụ giữ nguyên nụ cười không đổi, nhấc bát xúc xắc lên, tiếng vang trong trẻo Tiếng vọng lại, các người chơi khác lần lượt đưa ra lựa chọn của mình. \"Mua rồi thì không đổi.\" Anh ta nói, \"Mời Đặt cược—\""
  },
  Event_142013_Name = {
    Text = "Sòng Bạc Ồn Ào"
  },
  Event_142073_ChoiceDesc1 = {Text = "[đi]"},
  Event_142073_Desc = {
    Text = "Người phục vụ nhấc bát xúc xắc lên, chỉ vài giây ngắn ngủi, không khí Dường như đều Stasis lại. Khoảnh khắc đáp án được hé lộ, bạn nghe thấy tiếng歡呼 và tiếng than khóc hòa lẫn vào nhau. May mắn đã không Phước lành cho bạn, những viên xúc xắc nằm yên lặng trên bàn đã đưa ra câu trả lời ngược lại với bạn. Bạn lần cuối nhìn quanh một lượt, nhìn những tay cờ bạc điên rồ đó. Đã đến lúc rời đi."
  },
  Event_142073_Name = {
    Text = "Sòng Bạc Ồn Ào"
  },
  Event_142074_ChoiceDesc1 = {
    Text = "[Vào trận chiến]"
  },
  Event_142074_Desc = {
    Text = "Khi bạn đang chăm chú nhìn vào bàn Đặt cược với đầy kỳ vọng, tay bạn đột nhiên bị siết chặt, ngẩng đầu lên nhìn, Ông Chủ sòng bạc đang nhìn xuống, chuẩn bị mời tất cả những vị khách không tuân thủ quy tắc ra ngoài. Chớp mắt, mọi ánh nhìn đều tập trung vào một mình bạn, ngạc nhiên, đầy thù địch, hả hê... Bạn nhận ra, một người có thể gian lận nhiều lần, nhưng Chỉ cần bị phát hiện một lần, sẽ phải đón nhận sự thất bại hoàn toàn và mất hết danh dự."
  },
  Event_142074_Name = {
    Text = "Sòng Bạc Ồn Ào"
  },
  Event_142103_ChoiceDesc1 = {Text = "[đi]"},
  Event_142103_Desc = {
    Text = "Bạn thành công thoát khỏi sòng bạc bằng phương pháp vật lý, tiếng ồn ào của đám đông bị bạn bỏ lại phía sau, bạn tăng tốc bước đi rời khỏi — còn cái mớ hỗn độn này, sẽ có người dọn dẹp thôi."
  },
  Event_142103_Name = {
    Text = "Sòng Bạc Ồn Ào"
  },
  Event_142105_ChoiceDesc1 = {
    Text = "[Rút thêm một lần] Nhận một thẻ triệu chứng"
  },
  Event_142105_ChoiceDesc2 = {
    Text = "[Rời đi] Nhận 75 dấu đen"
  },
  Event_142105_Desc = {
    Text = "Bạn thử rút một lần, không có gì xảy ra. Nhưng mặt sau của tấm thẻ ghi: \"Lần sau sẽ dễ hơn\"\n......Có muốn thử lại một lần nữa không?"
  },
  Event_142105_Name = {
    Text = "Thử Thách Xổ Số"
  },
  Event_142106_ChoiceDesc1 = {
    Text = "[Rút thêm một lần] Nhận một thẻ triệu chứng"
  },
  Event_142106_ChoiceDesc2 = {
    Text = "[Rời đi] Nhận 75 dấu đen"
  },
  Event_142106_Desc = {
    Text = "Bạn thử rút một lần, không có gì xảy ra. Nhưng mặt sau của tấm thẻ ghi: \"Lần sau sẽ dễ hơn\"\n......Có muốn thử lại một lần nữa không?"
  },
  Event_142106_Name = {
    Text = "Thử Thách Xổ Số"
  },
  Event_142107_ChoiceDesc1 = {
    Text = "[Rút thêm một lần] Nhận một thẻ triệu chứng"
  },
  Event_142107_Desc = {
    Text = "Bạn thử rút một lần, không có gì xảy ra. Nhưng mặt sau của tấm thẻ ghi: \"Lần sau sẽ dễ hơn\"\n......Có muốn thử lại một lần nữa không?"
  },
  Event_142107_Name = {
    Text = "Thử Thách Xổ Số"
  },
  Event_142108_ChoiceDesc1 = {
    Text = "[Rút thêm một lần] Nhận một thẻ triệu chứng"
  },
  Event_142108_ChoiceDesc2 = {
    Text = "[Rời đi] Nhận 75 dấu đen"
  },
  Event_142108_Desc = {
    Text = "Bạn thử rút một lần, không có gì xảy ra. Nhưng mặt sau của tấm thẻ ghi: \"Lần sau sẽ dễ hơn\"\n......Có muốn thử lại một lần nữa không?"
  },
  Event_142108_Name = {
    Text = "Thử Thách Xổ Số"
  },
  Event_142109_ChoiceDesc1 = {Text = "[đi]"},
  Event_142109_Desc = {
    Text = "Lắng nghe tiếng tim đập, Bạn lật tờ vé xổ số ra, những dòng chữ vàng rực rỡ nhảy vào mắt Bạn. Chủ sạp Hưng phấn lắc chuông, tất cả người qua đường đều đổ Ánh Mắt ngưỡng mộ về phía Bạn.\n\"Giải thưởng lớn đã được rút ra!\""
  },
  Event_142109_Name = {
    Text = "Thử Thách Xổ Số"
  },
  Event_142110_ChoiceDesc1 = {
    Text = "[Rút thêm một lần] Nhận một thẻ triệu chứng"
  },
  Event_142110_ChoiceDesc2 = {
    Text = "[Rời đi] Nhận 75 dấu đen"
  },
  Event_142110_Desc = {
    Text = "Bạn thử rút một lần, không có gì xảy ra. Nhưng mặt sau của tấm thẻ ghi: \"Lần sau sẽ dễ hơn\"\n......Có muốn thử lại một lần nữa không?"
  },
  Event_142110_Name = {
    Text = "Thử Thách Xổ Số"
  },
  Event_142118_ChoiceDesc1 = {
    Text = "[Trao đổi hàng hóa] Xóa 1 Di vật, Xác suất 25% nhận được 1 trong 3 bàn lắc thời linh, Xác suất 50% nhận được 2 vật tạo vàng ngẫu nhiên, Xác suất 25% nhận được 25 dấu đen"
  },
  Event_142118_ChoiceDesc2 = {Text = "[đi]"},
  Event_142118_Desc = {
    Text = "Thương nhân đón lấy vật phẩm Bạn đưa, soi đi soi lại dưới ánh trăng, Đôi Mắt gần như trợn tròn. Bạn chờ rất lâu, anh ta mới nở nụ cười, móc từ trong túi ra một chiếc hộp sắt han gỉ. \"Hãy mở ra xem thử nào, đây là hộp mù thịnh hành nhất hiện nay đấy.\"\nBạn mở nó ra, nhưng Phát hiện Bên trong Chỉ có một ít Dấu Ấn Đen không mấy ưng ý. Thương nhân xoa xoa tay, ánh mắt đầy áy náy tỏ ý có thể thử thêm một lần nữa."
  },
  Event_142118_Name = {
    Text = "Thương nhân Rách Rưới"
  },
  Event_142119_ChoiceDesc1 = {Text = "[đi]"},
  Event_142119_Desc = {
    Text = "Thương nhân đón lấy vật phẩm Bạn đưa, soi đi soi lại dưới ánh trăng, Đôi Mắt gần như trợn tròn. Bạn chờ rất lâu, anh ta mới nở nụ cười, móc từ trong túi ra một chiếc hộp sắt han gỉ. \"Hãy mở ra xem thử nào, đây là hộp mù thịnh hành nhất hiện nay đấy.\"\nBạn mở nó ra, Bên trong có một thứ gì đó nằm yên."
  },
  Event_142119_Name = {
    Text = "Thương nhân Rách Rưới"
  },
  Event_142120_ChoiceDesc1 = {
    Text = "[Trao đổi hàng hóa] Xóa 1 vật tạo vàng, Xác suất 50% nhận được 1 trong 3 bàn lắc thời linh, Xác suất 50% nhận được 1 trong 3 Tạo Vật Được chúc phúc"
  },
  Event_142120_ChoiceDesc2 = {Text = "[đi]"},
  Event_142120_Desc = {
    Text = "Bạn lại mở hộp mù ra, nhưng vẫn Phát hiện không có vật phẩm Bạn muốn. Thương nhân vội vàng cười xin lỗi, lại lục ra một chiếc hộp sắt, hai tay nâng đưa đến trước mặt Bạn.\n\"Đừng giận, khách ơi! Tôi thề, lần này chắc chắn có thứ tuyệt vời nhất...\" anh ta nói vậy, nhưng lại lén rút ra một bàn tay, xòe ra trước mặt Bạn, \"Tất nhiên, bảo vật thì phải dùng bảo vật để đổi thôi.\""
  },
  Event_142120_Name = {
    Text = "Thương nhân Rách Rưới"
  },
  Event_142138_ChoiceDesc1 = {
    Text = "[Mượn dùng một chút]"
  },
  Event_142138_ChoiceDesc2 = {Text = "[đi]"},
  Event_142138_Desc = {
    Text = "Bạn đã sử dụng thành công những công cụ này, dù có phần hư hỏng nhưng có vẻ vẫn còn dùng được."
  },
  Event_142138_Name = {Text = "Lò rèn"},
  Event_142139_ChoiceDesc1 = {
    Text = "[Đập vỡ đúc lại] Chọn 1 vật tạo vàng để xóa, nhận được 2 bạc tạo vật, nhận được 50 dấu đen"
  },
  Event_142139_ChoiceDesc2 = {
    Text = "[Tôi luyện] Chọn 2 Di vật để xóa, nhận được vật tạo vàng [(RelicConfig.Arg1)]."
  },
  Event_142139_ChoiceDesc3 = {
    Text = "[Cao cấp tôi luyện] Chọn 2 vật tạo vàng để xóa, nhận được bàn lắc thời linh [(RelicConfig.Arg1)]."
  },
  Event_142139_Desc = {
    Text = "Bạn nhặt chiếc búa bên cạnh, định bụng......"
  },
  Event_142139_Name = {Text = "Lò rèn"},
  Event_142140_ChoiceDesc1 = {
    Text = "[Mượn dùng một chút]"
  },
  Event_142140_ChoiceDesc2 = {Text = "[đi]"},
  Event_142140_Desc = {
    Text = "Bạn đã sử dụng thành công những công cụ này, dù có phần hư hỏng nhưng có vẻ vẫn còn dùng được."
  },
  Event_142140_Name = {Text = "Lò rèn"},
  Event_142141_ChoiceDesc1 = {
    Text = "[Đập vỡ đúc lại] Chọn 1 vật tạo vàng để xóa, nhận được 2 bạc tạo vật, nhận được 50 dấu đen"
  },
  Event_142141_ChoiceDesc2 = {
    Text = "[Tôi luyện] Chọn 2 Di vật để xóa, nhận được vật tạo vàng [(RelicConfig.Arg1)]."
  },
  Event_142141_ChoiceDesc3 = {
    Text = "[Cao cấp tôi luyện] Chọn 2 vật tạo vàng để xóa, nhận được bàn lắc thời linh [(RelicConfig.Arg1)]."
  },
  Event_142141_Desc = {
    Text = "Bạn nhặt chiếc búa bên cạnh, định bụng......"
  },
  Event_142141_Name = {Text = "Lò rèn"},
  Event_142142_ChoiceDesc1 = {
    Text = "[Đập vỡ đúc lại] Chọn 1 vật tạo vàng để xóa, nhận được 2 bạc tạo vật, nhận được 50 dấu đen"
  },
  Event_142142_ChoiceDesc2 = {
    Text = "[Tôi luyện] Chọn 2 Di vật để xóa, nhận được vật tạo vàng [(RelicConfig.Arg1)]."
  },
  Event_142142_ChoiceDesc3 = {
    Text = "[Cao cấp tôi luyện] Chọn 2 vật tạo vàng để xóa, nhận được bàn lắc thời linh [(RelicConfig.Arg1)]."
  },
  Event_142142_Desc = {
    Text = "Bạn nhặt chiếc búa bên cạnh, định bụng......"
  },
  Event_142142_Name = {Text = "Lò rèn"},
  Event_142167_ChoiceDesc1 = {Text = "[đi]"},
  Event_142167_Desc = {
    Text = "Sau ba lần sử dụng, cái đe hoàn toàn bị lõm xuống, búa cũng đầy vết mài mòn, trông có vẻ không thể dùng được nữa."
  },
  Event_142167_Name = {Text = "Lò rèn"},
  Event_142235_ChoiceDesc1 = {
    Text = "[Tôi Sẽ Kiên Định Tiến Về Phía Trước] Nhận \"Thuần Khiết\": Tất cả thẻ lệnh nhận 20 lớp tăng cường vĩnh viễn"
  },
  Event_142235_ChoiceDesc2 = {
    Text = "[Tôi Sẽ Không Trốn Tránh] Nhận \"Thăng Hoa\": Giới hạn Chìa Khóa Bạc, Giới hạn điên cuồng giảm vĩnh viễn 20%"
  },
  Event_142235_Desc = {
    Text = "Trước Mắt bạn bỗng nhiên phủ lên một lớp sương mù, thế giới bắt đầu trở nên mờ nhạt, trong cơn mê man, một giọng nói vang lên trong lòng bạn:\n\"Bạn có muốn tiếp tục tiến về phía trước không?\""
  },
  Event_142235_Name = {
    Text = "Điểm cuối đang đến gần"
  },
  Event_142925_ChoiceDesc1 = {Text = "[đi]"},
  Event_142925_Desc = {
    Text = "Nhân viên hội quán nhận thù lao, thực hiện dịch vụ cơ bản cho bạn. Họ mang những vật phẩm bạn giao vào một ngăn tối tăm, thời gian đợi không lâu, khi anh ta xuất hiện trở lại, đồ vật đã được đặt lại trên khay, có vẻ khác đôi chút so với trước."
  },
  Event_142925_Name = {
    Text = "Hội quán Đặc biệt"
  },
  Event_142926_ChoiceDesc1 = {
    Text = "[Xóa một vật tạo vàng] (Cần có vật tạo vàng)"
  },
  Event_142926_ChoiceDesc2 = {
    Text = "[Có Di vật được tăng cường (Forged) để chọn]"
  },
  Event_142926_ChoiceDesc3 = {Text = "[đi]"},
  Event_142926_Desc = {
    Text = "Kiểm tra \"Số lượng Di vật\" \"Danh sách chọn Di vật\""
  },
  Event_142927_ChoiceDesc1 = {Text = "[đi]"},
  Event_142927_Desc = {
    Text = "Nhân viên hội quán nhận thù lao, thực hiện dịch vụ cao cấp cho bạn. Họ trân trọng đặt vật phẩm của bạn vào một chiếc hộp, mang vào một ngăn tối tăm. Bạn đợi rất lâu, cho đến khi anh ta xuất hiện trở lại, dâng vật phẩm bằng hai tay, vẻ mặt bình thản như thường."
  },
  Event_142927_Name = {
    Text = "Hội quán Đặc biệt"
  },
  Event_142928_ChoiceDesc1 = {
    Text = "[Chọn tối đa 2 Thể thức tỉnh để lấp đầy Điên loạn]"
  },
  Event_142928_ChoiceDesc2 = {
    Text = "[Phải chọn 2 Thể thức tỉnh đầy Điên loạn]"
  },
  Event_142928_ChoiceDesc3 = {Text = "[đi]"},
  Event_142928_Desc = {
    Text = "Kiểm tra \"Điều kiện chọn Thể thức tỉnh\""
  },
  Event_142929_ChoiceDesc1 = {Text = "[đi]"},
  Event_142929_Desc = {
    Text = "Nghiên cứu viên đi vòng quanh bạn hết lần này đến lần khác, quan sát kỹ lưỡng rất lâu rồi mới bắt đầu làm việc — anh ta không hỏi ý kiến bạn. Một khoảng thời gian trôi qua, khi bạn chuẩn bị rời khỏi viện nghiên cứu kỳ lạ này, bạn rõ ràng cảm thấy mình đã mất đi rất nhiều thứ, nhưng anh ta lại vỗ tay chúc mừng bạn: \"Đây chính là chân lý của tiến hóa!\""
  },
  Event_142929_Name = {
    Text = "Nhà Tiến hóa học"
  },
  Event_142930_ChoiceDesc1 = {Text = "[đi]"},
  Event_142930_Desc = {
    Text = "Bạn duỗi tay, thò vào vùng nước đỏ tươi, chạm được vào thứ gì đó hữu ích."
  },
  Event_142930_Name = {
    Text = "Suối Máu"
  },
  Event_142931_ChoiceDesc1 = {Text = "[đi]"},
  Event_142931_Desc = {
    Text = "Tiếng nói dần xa, lòng bạn tràn đầy quyết tâm, cảm nhận Sức mạnh Hiện diện."
  },
  Event_142931_Name = {
    Text = "Điểm cuối đang đến gần"
  },
  Event_142932_ChoiceDesc1 = {Text = "[đi]"},
  Event_142932_Desc = {
    Text = "Tiếng nói dần xa, lòng bạn tràn đầy quyết tâm, đầu óc trở nên minh mẫn hơn."
  },
  Event_142932_Name = {
    Text = "Điểm cuối đang đến gần"
  },
  Event_142933_ChoiceDesc1 = {Text = "[đi]"},
  Event_142933_Desc = {
    Text = "Bạn tùy tiện lấy một ít từ đống lễ vật chất thành núi, rồi nhanh chóng rời đi, khi Bạn bước ra, Đôi Mắt của bức tượng dường như đã động đậy một cái."
  },
  Event_142933_Name = {
    Text = "Bàn Thờ Được Mất"
  },
  Event_142934_ChoiceDesc1 = {Text = "[đi]"},
  Event_142934_Desc = {
    Text = "Bạn đã luyện tập tập trung vào hướng phòng thủ, liên tục dùng vũ khí chống đỡ trước các đòn Phục kích của đối thủ, khả năng phòng thủ và phản ứng của bạn đều được nâng cao."
  },
  Event_142934_Name = {
    Text = "Thời gian luyện tập đặc biệt"
  },
  Event_142935_ChoiceDesc1 = {Text = "[đi]"},
  Event_142935_Desc = {
    Text = "Nghiên cứu viên đeo găng tay, lấy từ tủ một số thiết bị có hình dạng kỳ lạ, ra hiệu trước mặt bạn một hồi. Bạn không biết anh ta rốt cuộc đã làm gì, nhưng có vẻ bạn thực sự cảm thấy nhẹ nhõm hơn đôi chút."
  },
  Event_142935_Name = {
    Text = "Nhà Tiến hóa học"
  },
  Event_142936_ChoiceDesc1 = {Text = "[đi]"},
  Event_142936_Desc = {
    Text = "Bạn không chọn một hướng cụ thể để tập trung, mà bất chấp giới hạn cơ thể để luyện tập cùng người khác cho đến khi Mọi người đều kiệt sức. Bạn biết mình đã tiến bộ rất nhiều, nhưng đồng thời, bạn cũng phải trả một cái giá."
  },
  Event_142936_Name = {
    Text = "Thời gian luyện tập đặc biệt"
  },
  Event_142937_ChoiceDesc1 = {Text = "[đi]"},
  Event_142937_Desc = {
    Text = "Bạn tùy tiện lấy vài thứ từ trong túi ra cúng bái lên, và nhận được phần thưởng tương xứng."
  },
  Event_142937_Name = {
    Text = "Bàn Thờ Được Mất"
  },
  Event_142938_ChoiceDesc1 = {Text = "[đi]"},
  Event_142938_Desc = {
    Text = "Bạn dâng lên những lễ vật quý giá, và nhận được phần thưởng tương xứng."
  },
  Event_142938_Name = {
    Text = "Bàn Thờ Được Mất"
  },
  Event_142939_ChoiceDesc1 = {Text = "[đi]"},
  Event_142939_Desc = {
    Text = "Bạn đầy nghi ngờ về phương pháp nghiên cứu của anh ta, sau một hồi tranh luận, anh ta đồng ý để bạn tự sử dụng những thiết bị này, chọn cách khác để theo đuổi \"tiến hóa\".\nCùng một bộ dụng cụ, bạn lại vô tình khiến những thứ lẽ ra bị \"xóa bỏ\" lại \"sinh sôi\" ồ ạt, trước khi rời đi, bạn nghe thấy tiếng than vãn của Nghiên cứu viên."
  },
  Event_142939_Name = {
    Text = "Nhà Tiến hóa học"
  },
  Event_142940_ChoiceDesc1 = {Text = "[đi]"},
  Event_142940_Desc = {
    Text = "Nhân viên hội quán thực hiện dịch vụ miễn phí cho bạn, họ mang những vật phẩm bạn giao vào một ngăn tối tăm, một lúc sau anh ta quay trở lại, đặt đồ vật trở lại tay bạn mà không nói một lời."
  },
  Event_142940_Name = {
    Text = "Hội quán Đặc biệt"
  },
  Event_142941_ChoiceDesc1 = {Text = "[đi]"},
  Event_142941_Desc = {
    Text = "Bạn dâng lên hồ cầu nguyện một lượng lớn máu, món quà quý giá hiện ra từ đáy hồ."
  },
  Event_142941_Name = {
    Text = "Suối Máu"
  },
  Event_142942_ChoiceDesc1 = {Text = "[đi]"},
  Event_142942_Desc = {
    Text = "Bạn đã triển khai luyện tập theo hướng tấn công, trong tiếng va chạm của thép, kỹ năng và tốc độ Đánh của bạn đều được nâng cao."
  },
  Event_142942_Name = {
    Text = "Thời gian luyện tập đặc biệt"
  },
  Event_142943_ChoiceDesc1 = {Text = "[đi]"},
  Event_142943_Desc = {
    Text = "Bạn dâng lên hồ cầu nguyện một ít máu, món quà từ đáy hồ nổi lên."
  },
  Event_142943_Name = {
    Text = "Suối Máu"
  },
  Event_142944_ChoiceDesc1 = {
    Text = "[Chọn Nâng cấp Di vật]"
  },
  Event_142944_ChoiceDesc2 = {
    Text = "[Nâng cấp Di vật ngẫu nhiên]"
  },
  Event_142944_ChoiceDesc3 = {
    Text = "[Rời đi (Thử nghiệm)]"
  },
  Event_142944_Desc = {
    Text = "Kiểm tra \"Chức năng Nâng cấp Di vật\", Di vật tự thêm"
  },
  Event_146258_ChoiceDesc1 = {
    Text = "[Gọi hắn] Nhận vật bị nguyền rủa \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_146258_ChoiceDesc2 = {
    Text = "[Hồi đáp chúng] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: [(EnchantConfig.Arg1)]"
  },
  Event_146258_ChoiceDesc3 = {
    Text = "[Phớt lờ chúng] nhận được 50 dấu đen"
  },
  Event_146258_Desc = {
    Text = "Trên bàn thờ tế lễ, bạch bào của Yu Li-ét chìm trong làn khói dày đặc, tro hương hòa lẫn mùi tanh ngọt nào đó.\n\"Người mang đèn thương xót những kẻ tội lỗi trên đời,\" giọng bà không lớn, nhưng rõ ràng át đi tiếng cầu nguyện xào xạc khắp điện, \"như người mẹ hiền thương xót đứa trẻ trong nôi.\"\nLễ vật trên bàn thờ ánh lên vẻ bóng loáng dưới ánh nến, từng sợi khói xanh uốn lượn theo đường nét của nó mà bay lên, làm mờ đi khuôn mặt của những người bên dưới.\nCas-tơ-lơ nhìn qua màn khói đang lay động về phía Pollux, anh đứng giữa đám tín đồ, mắt cúi xuống, trên mặt là vẻ thành kính vừa đủ được rèn giũa qua huấn luyện."
  },
  Event_146258_Name = {
    Text = "Giấc Mơ Xưa III"
  },
  Event_146259_ChoiceDesc1 = {Text = "[đi]"},
  Event_146259_Desc = {
    Text = "Đừng để ý, chỉ là tiếng gió tuyết gào thét, tiếng hồ băng thở dài, hay tiếng các đỉnh núi ai oán.\nLà những cành cây đã khô héo, thì thầm cọ xát vào nhau.\nChúng mãi mãi thổn thức bi ai, vì từng người tiên phong đã bỏ mạng trong kẽ băng."
  },
  Event_146259_Name = {
    Text = "Khúc Ngâm Hồ Băng"
  },
  Event_146260_ChoiceDesc1 = {Text = "[đi]"},
  Event_146260_Desc = {
    Text = "Nếu bình đẳng tuyệt đối là công bằng, thì liệu Máu Liên · Shiro có được hưởng cơ hội cầu nguyện bình đẳng như các ngươi không?\nVậy thì, đối với hành động cô ấy ra tay trước thậm chí xua đuổi những kẻ cạnh tranh, ngươi có nên thản nhiên đối xử không?\n\"Hay là thôi đừng nghĩ vẩn vơ nữa, leo tiếp đi thôi!\" Tiếng gọi của Caraboo vang lên bên tai."
  },
  Event_146260_Name = {
    Text = "Sự Công Bằng Phi Lý"
  },
  Event_146261_ChoiceDesc1 = {
    Text = "[Núi Sợ Đói Khát]"
  },
  Event_146261_ChoiceDesc2 = {
    Text = "[Núi Sợ Mất Mát]"
  },
  Event_146261_ChoiceDesc3 = {
    Text = "[Núi Sợ Cái Chết]"
  },
  Event_146261_Desc = {
    Text = "Bạn bước đi trên thân hình của ngọn núi.\nSự rung chuyển của núi đã bộc lộ bí mật của nó.\nLòng tham của núi, quyết định nỗi sợ hãi của núi."
  },
  Event_146261_Name = {
    Text = "Bí Mật Của Núi"
  },
  Event_146262_ChoiceDesc1 = {Text = "[đi]"},
  Event_146262_Desc = {
    Text = "Bạn tận hưởng lớp lông mượt mà mềm mại, bạn bị giam cầm trong chính ham muốn của mình.\nBạn rất hài lòng với cảm giác đó.\nBên dưới vẻ ngoài rốt cuộc là gì, có thực sự quan trọng không?"
  },
  Event_146262_Name = {
    Text = "Mèo Đen Rình Rập"
  },
  Event_146263_ChoiceDesc1 = {Text = "[đi]"},
  Event_146263_Desc = {
    Text = "Bạn lặng lẽ đón lấy đầu dây đỏ, buộc nó vào cổ tay mình.\nPollux làm theo, hai đứa trẻ chẳng mấy chốc đã được sợi dây đỏ mảnh manh nối liền với nhau.\nDù diện tích tìm kiếm trong cùng khoảng thời gian trở nên nhỏ hơn, nhưng các bạn vốn đã định sẵn sẽ cùng sống cùng chết, phải không?\nPhần còn lại, hãy để số phận sắp đặt vậy."
  },
  Event_146263_Name = {
    Text = "Giấc Mơ Xưa I"
  },
  Event_146264_ChoiceDesc1 = {Text = "[đi]"},
  Event_146264_Desc = {
    Text = "\"Tất nhiên ta biết điều này rất khó, đứa trẻ thân yêu.\"\n\"Nhưng thế giới chưa bao giờ dễ dàng với bất kỳ ai.\"\n\"Sẽ có một ngày, con bướm đó sẽ bay khỏi lòng bàn tay ngươi, rồi mãi mãi biến mất.\""
  },
  Event_146264_Name = {
    Text = "Ảo Chứ Chẳng Thật"
  },
  Event_146265_ChoiceDesc1 = {Text = "[đi]"},
  Event_146265_Desc = {
    Text = "William ngước mắt, ánh nhìn lướt nhanh qua ngươi rồi dừng lại trên dãy núi đầy tuyết phủ ở phía xa.\n\"Ngươi không làm bất cứ điều gì cần phải xin lỗi,\" anh nói một cách nghiêm túc, \"Có những mệnh đề thuộc về bản thân tôi, và cũng chỉ có thể do tôi tự giải đáp.\"\n\"Nhưng cảm ơn sự nhạy bén và tinh tế của ngươi.\""
  },
  Event_146265_Name = {
    Text = "Sự Chìm Đắm Dịu Dàng"
  },
  Event_146266_ChoiceDesc1 = {Text = "[đi]"},
  Event_146266_Desc = {
    Text = "Ánh mắt William lung linh.\nNgươi mở miệng, nhưng chẳng nói gì. Im lặng là lựa chọn tốt nhất lúc này.\nGiữa hai người vẫn còn tồn tại sự đồng cảm quý giá, đừng phá vỡ nó."
  },
  Event_146266_Name = {
    Text = "Sự Chìm Đắm Dịu Dàng"
  },
  Event_146267_ChoiceDesc1 = {
    Text = "[rời đi] nhận được bạc tạo vật [(RelicConfig.Arg1)]"
  },
  Event_146267_Desc = {
    Text = "\"Trả lại cho ta, trả lại cho ta, đó là sức mạnh của ta!\"\nNúi khóc than, núi rên rỉ.\nNúi không thể chịu đựng được, tất cả những gì nó từng có đều bị tước đoạt sạch sành sanh."
  },
  Event_146267_Name = {
    Text = "Bí Mật Của Núi"
  },
  Event_146268_ChoiceDesc1 = {
    Text = "[Tiếp tục trốn chạy] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_146268_ChoiceDesc2 = {
    Text = "[Chờ đợi thời cơ] Nhận 1 trong 3 Khắc ấn"
  },
  Event_146268_ChoiceDesc3 = {
    Text = "[Rời đi từ từ]"
  },
  Event_146268_Desc = {
    Text = "\"Anh ơi, cẩn thận, có quạ đang nhìn.\"\nCas-tơ-lơ lúc còn nhỏ cõng Pollux đi nhanh, ánh mắt hoảng loạn quét qua từng góc khuất đáng ngờ, nhưng chẳng phát hiện gì.\n\"Ở trên kia.\"\nBạn rùng mình, ngẩng đầu nhìn lên.\nTrong bóng tối góc mái hiên, một con quạ đang ngồi yên lặng, những đôi mắt kỳ dị hướng về bốn phía đều đang chằm chằm nhìn bạn."
  },
  Event_146268_Name = {
    Text = "Giấc Mơ Xưa II"
  },
  Event_146269_ChoiceDesc1 = {Text = "[đi]"},
  Event_146269_Desc = {
    Text = "Ngươi ghi nhớ lời dặn trong huấn luyện, không được dựa vào dây an toàn.\nDưới những cú đạp mạnh, ngươi cố giữ vững thân hình.\nNhưng có thứ gì đó trong ba lô lăn dọc theo vách núi, biến thành một chấm nhỏ đến mức không nhìn rõ.\nKhông quan trọng nữa, ít nhất ngươi vẫn còn sống."
  },
  Event_146269_Name = {
    Text = "Rơi Xuống Im Lặng"
  },
  Event_146270_ChoiceDesc1 = {
    Text = "[Lắng nghe] nhận được bạc tạo vật \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_146270_ChoiceDesc2 = {
    Text = "[Bịt tai] nhận được khắcăng chọn 1 trong 3"
  },
  Event_146270_Desc = {
    Text = "Gió tuyết đập vào vách đá, hòa lẫn với tiếng nứt vỡ mơ hồ vọng ra từ sâu trong lớp băng, vỡ vụn thành những tiếng nức nở đứt quãng.\nNgươi đứng trên độ cao không một bóng người, bỗng nhiên nghe rõ giai điệu của núi.\nNó hoang lương mà trang nghiêm, khẽ ngân nga một khúc nhạc chỉ dành cho những kẻ đã khuất."
  },
  Event_146270_Name = {
    Text = "Huyễn Tấu Thiên Nhiên"
  },
  Event_146271_ChoiceDesc1 = {
    Text = "[Là Tiếng Chuông] Nhiễm \"(Skill.Arg1)\", 1 thẻ lệnh ngẫu nhiên nhận Khắc ấn: \"(EnchantConfig.Arg2)\""
  },
  Event_146271_ChoiceDesc2 = {
    Text = "[Là Thức Ăn] Nhiễm \"(Skill.Arg1)\", 1 thẻ lệnh ngẫu nhiên nhận Khắc ấn: \"(EnchantConfig.Arg2)\""
  },
  Event_146271_ChoiceDesc3 = {
    Text = "[Là Sự Mong Đợi Của Chó] 1 thẻ lệnh ngẫu nhiên nhận Khắc ấn: \"(EnchantConfig.Arg1)\""
  },
  Event_146271_Desc = {
    Text = "\"Pavlov lắc chuông, rồi cho chó ăn. Lâu dần, chỉ cần lắc chuông, chó sẽ tiết nước bọt.\"\n\"Vậy thì, thứ khiến chó tiết nước bọt, rốt cuộc là gì?\""
  },
  Event_146271_Name = {
    Text = "Phản Xạ Pavlov"
  },
  Event_146272_ChoiceDesc1 = {Text = "[đi]"},
  Event_146272_Desc = {
    Text = "Đừng hồi tưởng lại.\nWilliam đang ở trong tầm tay bạn.\nĐừng để đau khổ nhấn chìm bạn.\nBạn đã bỏ lỡ nhiều thứ, nhưng vẫn còn kịp."
  },
  Event_146272_Name = {
    Text = "Từ Bờ Kia Đến"
  },
  Event_146273_ChoiceDesc1 = {Text = "[đi]"},
  Event_146273_Desc = {
    Text = "\"Hãy khép bàn tay lại.\"\n\"Những gì từng tuyệt đẹp, trong lòng bàn tay ngươi chỉ còn lại một nắm bùn đen.\""
  },
  Event_146273_Name = {
    Text = "Ảo Chứ Chẳng Thật"
  },
  Event_146274_ChoiceDesc1 = {
    Text = "[Biến trở lại] Nhận 50 dấu đen"
  },
  Event_146274_ChoiceDesc2 = {
    Text = "[Vuốt ve] Nhận 75 dấu đen, nhiễm \"(Skill.Arg2)\""
  },
  Event_146274_Desc = {
    Text = "\"Meo.\" Một con mèo đen mắt xanh lá bước những bước chân mềm mại, cọ vào ống chân bạn.\nĐồng thời, \"N\" đã biến mất."
  },
  Event_146274_Name = {
    Text = "Mèo Đen Rình Rập"
  },
  Event_146275_ChoiceDesc1 = {Text = "[đi]"},
  Event_146275_Desc = {
    Text = "Ngươi không lên tiếng, chỉ để ánh mắt ấy xuyên qua làn khói, rơi trở lại đáy mắt Pollux, không chịu dời đi dù chỉ một tấc.\nAnh cũng không né tránh, người em trai luôn như vậy, thà giấu sự bướng bỉnh vào tận sâu nhất, cũng không chịu cúi đầu trước.\nTiếng tụng ca trong điện, mùi tro hương, những lời lẽ của Yu Li-ét về lòng từ bi và hiến tế, bỗng nhiên đều trở nên xa xôi, như thể chỉ còn lại hai người, cách nhau qua cả điện đường đầy lòng thương hại giả tạo, cách nhau qua tháng năm dài dằng dặc, nhìn nhau chằm chằm."
  },
  Event_146275_Name = {
    Text = "Giấc Mơ Xưa III"
  },
  Event_146276_ChoiceDesc1 = {Text = "[đi]"},
  Event_146276_Desc = {
    Text = "Lúc này, bạn là người lính canh duy nhất cho ký ức nhợt nhạt và dài đằng đẵng của mình.\nWendigo vươn dài bàn tay khô như cành cây chết, đầu ngón tay nhắm thẳng vào lồng ngực bạn, nhưng vào khoảnh khắc cuối cùng đã bị bạn chặn lại bằng tất cả sức lực.\nNó loạng choạng lùi vào màn sương, chỉ để lại một câu mê sảng khàn khàn —\n\"Sớm hay muộn ngươi cũng sẽ tự nguyện, trao tất cả chúng cho ta…\""
  },
  Event_146276_Name = {
    Text = "Kẻ Tham Thực"
  },
  Event_146277_ChoiceDesc1 = {Text = "[đi]"},
  Event_146277_Desc = {
    Text = "Đó là giấc mơ xa xôi, giấc mơ mang tên tuổi thơ.\nTỉnh táo lại đi. Bạn không ở đó.\nBạn đang ở trong gió tuyết, bị bao vây bởi lớp lớp Tín đồ Đèn cầm tay, còn mũi dao của Pollux đang chỉ thẳng vào ngực bạn."
  },
  Event_146277_Name = {
    Text = "Giấc Mơ Xưa I"
  },
  Event_146278_ChoiceDesc1 = {Text = "[đi]"},
  Event_146278_Desc = {
    Text = "\"Ta chấp nhận cái chết xảy đến.\"\n\"Ta sẵn lòng bỏ mạng trong cuộc hành trình gian khổ.\"\n\"Dưới vách đá dựng đứng, trời đất dựng bia cho ta.\""
  },
  Event_146278_Name = {
    Text = "Điềm Tử Thần Đến Gần"
  },
  Event_146279_ChoiceDesc1 = {Text = "[đi]"},
  Event_146279_Desc = {
    Text = "Bóng phản chiếu chẳng qua là hiện tượng phản xạ ánh sáng.\nNhững gì tinkerer nhìn thấy, phần lớn cũng chỉ là bóng của chính cô ấy.\nHành tinh mẹ của cô ấy ở cách xa hàng triệu năm ánh sáng, chỉ một sai lệch nhỏ nhất trên hành trình cũng có thể khiến họ rơi xuống những hệ sao khác nhau.\nTự an ủi như vậy, ngươi không còn chấp nhất vào bóng phản chiếu dưới chân nữa."
  },
  Event_146279_Name = {
    Text = "Bóng Phản Chiếu Đáy Hồ"
  },
  Event_146280_ChoiceDesc1 = {Text = "[đi]"},
  Event_146280_Desc = {
    Text = "Đến từ Quần Tinh. Đến từ thái cổ. Đến từ những điều con người chưa biết, có lẽ mãi mãi không biết.\nĐừng cầu xin Họ câu trả lời.\nNgươi không biết cái giá phải trả."
  },
  Event_146280_Name = {
    Text = "Khúc Ngâm Hồ Băng"
  },
  Event_146281_ChoiceDesc1 = {Text = "[đi]"},
  Event_146281_Desc = {
    Text = "Ngươi dừng bước, mặc cho thanh âm hoang lương ấy tràn đầy bên tai.\nTiếng gió là đàn violin, hạt tuyết là tiếng trống, tiếng băng vỡ ầm ầm từ xa là một thứ hòa âm trầm thấp đã bị kìm nén từ lâu.\nNgươi không nhận ra chủ đề của nó, nhưng ngươi biết, dù là quá khứ hay tương lai, nó sẽ mãi vang lên cho vô số lữ khách đã bỏ mạng nơi đây."
  },
  Event_146281_Name = {
    Text = "Huyễn Tấu Thiên Nhiên"
  },
  Event_146283_ChoiceDesc1 = {
    Text = "[Ngước nhìn Ánh Sáng Trời] Tất cả Thể thức tỉnh Trả lời Arg1 điên cuồng"
  },
  Event_146283_ChoiceDesc2 = {
    Text = "[Chân Đạp Đỉnh Băng] Chọn thức tỉnh 2 Thể thức tỉnh"
  },
  Event_146283_Desc = {
    Text = "Đỉnh núi lặng lẽ tỏa sáng trong mây mù.\nThung lũng, vách đá, bão tố — những thứ ngự trị nơi này chưa bao giờ tồn tại vì con người.\nĐứng giữa chốn này, bạn thật mong manh biết bao."
  },
  Event_146283_Name = {
    Text = "Chạm Đến Đỉnh Cao"
  },
  Event_146284_ChoiceDesc1 = {Text = "[đi]"},
  Event_146284_Desc = {
    Text = "\"Không, không phải lỗi của anh.\"\n\"Anh chỉ là món đồ chơi của số phận, đã được lên dây cót sẵn mà thôi.\""
  },
  Event_146284_Name = {
    Text = "Con Chuột Tham Ăn"
  },
  Event_146285_ChoiceDesc1 = {Text = "[đi]"},
  Event_146285_Desc = {
    Text = "\"Nghe ra rồi, anh là kiểu người giỏi tổng kết kinh nghiệm khách quan. Nhưng đừng quên, đôi khi, ẩn sau những hiện tượng tương đồng, thực ra lại tiềm ẩn những khả năng khác nhau.\" Tiếng chuông cười vang rồi dần xa."
  },
  Event_146285_Name = {
    Text = "Phản Xạ Pavlov"
  },
  Event_146286_ChoiceDesc1 = {Text = "[đi]"},
  Event_146286_Desc = {
    Text = "Nếu thiện ác đều có báo là công bằng, thì ai sẽ phán xét thiện ác?\nBằng chiếc cân của Anubis chăng?\nNếu trọng lực ở âm phủ tuân theo nguyên lý vật lý học, ngươi không mấy tự tin rằng trái tim mình sẽ nhẹ hơn chiếc lông vũ kia."
  },
  Event_146286_Name = {
    Text = "Sự Công Bằng Phi Lý"
  },
  Event_146287_ChoiceDesc1 = {
    Text = "[Truy hỏi] Nhận bạc tạo vật \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_146287_ChoiceDesc2 = {
    Text = "[Im lặng] Nhận bạc tạo vật \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_146287_ChoiceDesc3 = {
    Text = "[Xin lỗi] Nhận 25 dấu đen"
  },
  Event_146287_Desc = {
    Text = "\"Đàn anh William, khi tất cả mọi người đều bị Wendigo mê hoặc, hình như anh là người đầu tiên tỉnh lại. Sắp phải đối mặt trực tiếp với đàn Wendigo rồi, anh có bí quyết gì để truyền thụ không?\"\nÁnh mắt William khẽ dao động, từ ánh nhìn của anh ngươi thoáng thấy sự mơ hồ khó nắm bắt, nỗi buồn và sự bình thản.\nTựa như đang ngâm mình trong làn nước biển xuyên sáng, lênh đênh chìm xuống đáy biển tối tăm.\n\"Xin lỗi, e rằng tôi chẳng có gì có thể giúp được.\""
  },
  Event_146287_Name = {
    Text = "Sự Chìm Đắm Dịu Dàng"
  },
  Event_146288_ChoiceDesc1 = {Text = "[đi]"},
  Event_146288_Desc = {
    Text = "\"Không hiểu lòng người, thật không hiểu lòng người.\" Bóng đen lắc đầu xuất hiện, \"Sự thật có thể là thứ thuốc độc thấu xương. Đôi khi, chấp nhận ảo tưởng còn giúp duy trì hạnh phúc hiện tại hơn, phải không?\""
  },
  Event_146288_Name = {
    Text = "Mèo Đen Rình Rập"
  },
  Event_146290_ChoiceDesc1 = {
    Text = "[Ai Là Hung Thủ] Nhiễm \"(Skill.Arg1)\", 1 thẻ bài ngẫu nhiên nhận Khắc ấn: \"(EnchantConfig.Arg2)\""
  },
  Event_146290_ChoiceDesc2 = {
    Text = "[Là Lỗi Của Tôi] Nhiễm \"(Skill.Arg1)\", 1 thẻ bài ngẫu nhiên nhận Khắc ấn: \"(EnchantConfig.Arg2)\""
  },
  Event_146290_ChoiceDesc3 = {
    Text = "[Cái Giá Của Sự Tham Ăn] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\""
  },
  Event_146290_Desc = {
    Text = "\"Chú chuột nhỏ, bò đi bò lại. Cống nước thải, tối tăm dài dài. Bỗng ngửi thấy mùi phô mai thơm ngát.\"\n\"Chú chuột nhỏ, kéo phô mai, chạy về nhà. Đầu ong ong, đầu ong ong.\"\n\"Đẩy cửa ra, đẩy cửa ra, trong nhà im lặng không một tiếng.\"\n\"Anh chị em nằm la liệt dưới đất, bụng đứa nào cũng có một cái lỗ, một cái lỗ.\""
  },
  Event_146290_Name = {
    Text = "Con Chuột Tham Ăn"
  },
  Event_146291_ChoiceDesc1 = {Text = "[đi]"},
  Event_146291_Desc = {
    Text = "Bạn cúi xuống, lau đi vết nước mắt trên má cô, không hỏi giọt nước mắt đó thật hay giả.\n\"Dù thật hay giả,\" bạn nói, \"cũng không cần phải chứng minh với ai.\"\nCaraboo mở miệng, câu nói đùa chuẩn bị sẵn để đối phó rốt cuộc không nói ra được.\nNước mắt cô vỡ òa không báo trước, rơi xuống mu bàn tay bạn."
  },
  Event_146291_Name = {
    Text = "Nước Mắt Cá Sấu"
  },
  Event_146292_ChoiceDesc1 = {Text = "[đi]"},
  Event_146292_Desc = {
    Text = "\"Tốt nhất là đừng hỏi nhé. Có những câu hỏi không cần biết câu trả lời.\""
  },
  Event_146292_Name = {
    Text = "Con Chuột Tham Ăn"
  },
  Event_146293_ChoiceDesc1 = {
    Text = "[Lên tiếng nhắc nhở] Nhận bạc tạo vật \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_146293_ChoiceDesc2 = {
    Text = "[Tiếp tục lắng nghe] Tất cả Thể thức tỉnh trả lại 50 điên cuồng, nhiễm \"(Skill.Arg1)\""
  },
  Event_146293_ChoiceDesc3 = {
    Text = "[Nhún vai bỏ qua] Nhận Khắc ấn chọn 1 trong 3"
  },
  Event_146293_Desc = {
    Text = "Nơi Naraka rơi xuống chỉ có bóng tối.\nMột giai điệu ẩm ướt vang lên từ bùn lầy, tựa như đôi bàn tay lạnh lẽo xanh xao, âu yếm vuốt ve đôi má ngươi.\nNó khẽ cất tiếng hát, \"Hãy đến đây, đến bên ta trong tĩnh lặng của đêm.\""
  },
  Event_146293_Name = {
    Text = "Tiếng Vọng Lưu Luyến"
  },
  Event_146294_ChoiceDesc1 = {Text = "[đi]"},
  Event_146294_Desc = {
    Text = "Ngươi cúi đầu xuống, để làn khói ấy làm mờ đi bóng dáng Pollux, cùng với vẻ mặt của anh lúc này, tất cả đều ẩn vào trong màn sương xám trắng.\nNhư vậy là an toàn nhất — ngươi tự nhủ, không cần nhìn, không cần nghĩ.\nLời giảng của Yu Li-ét vẫn vang bên tai, ngươi chằm chằm nhìn vào đôi bàn tay đan chéo của mình, không nói một lời.\nMãi đến khi tiếng chuông kết thúc nghi lễ vang lên, ngươi mới dám ngẩng mắt lên.\nCòn Pollux vẫn giữ nguyên tư thế thành kính của mình.\nCách nhau qua tháng năm dài dằng dặc và những ảo tưởng, ngươi không biết liệu có thứ gì đó đã trôi mất trong khoảnh khắc ấy hay không."
  },
  Event_146294_Name = {
    Text = "Giấc Mơ Xưa III"
  },
  Event_146295_ChoiceDesc1 = {Text = "[đi]"},
  Event_146295_Desc = {
    Text = "\"Pollux—\" giọng ngươi vừa bật ra khỏi cổ họng đã bị chính mình nuốt vội trở lại, chỉ còn lại một chút dư âm như hơi thở, tan vào khói hương.\nLàn sóng tụng kinh của các tín đồ bên cạnh không hề ngừng lại, nhưng vài ánh mắt đã lướt qua một cách khó nhận thấy.\nPollux giật mình cứng người, đáy mắt thoáng qua một tia hoảng loạn, rồi nhanh chóng bị vẻ cung kính được rèn giũa ấy che lấp.\nAnh không đáp lại, chỉ cúi mắt xuống, nhưng đầu ngón tay lại lặng lẽ siết chặt trong tay áo — ngươi biết, anh đã nghe thấy."
  },
  Event_146295_Name = {
    Text = "Giấc Mơ Xưa III"
  },
  Event_146297_ChoiceDesc1 = {Text = "[đi]"},
  Event_146297_Desc = {
    Text = "Ít nhất vào khoảnh khắc đó, ngươi không thể nhìn nhìn cô ấy một mình bị đuổi ra khỏi đội.\nVấn đề cần giải quyết lúc này, hãy giao cho bản thân của hiện tại đảm nhận thôi."
  },
  Event_146297_Name = {
    Text = "Kế Trong Kế"
  },
  Event_146298_ChoiceDesc1 = {Text = "[đi]"},
  Event_146298_Desc = {
    Text = "\"Pollux, chúng ta nên đi theo hai hướng khác nhau. Như vậy, chúng ta sẽ có cơ hội lớn hơn để tìm ra ranh giới của khu rừng.\"\n\"Vậy thì anh sẽ tìm em bằng cách nào, anh ơi?\"\nQua màn sương mờ của thời gian, bạn nhìn thấy vẻ mặt thất vọng của em. Cảm giác đau đớn siết chặt trái tim bạn. Bạn hít một hơi thật sâu, rồi từ từ thở ra.\n\"Chúng ta là song sinh. Chúng ta có thể đọc được nhịp tim của nhau.\"\n\"Chúng ta sẽ không bao giờ chia lìa.\""
  },
  Event_146298_Name = {
    Text = "Giấc Mơ Xưa I"
  },
  Event_146299_ChoiceDesc1 = {Text = "[đi]"},
  Event_146299_Desc = {
    Text = "Nó đang phán xét, nó đang tra vấn. Nó ban cho tất cả những kẻ thách thức không trở về cái chết lạnh lẽo."
  },
  Event_146299_Name = {
    Text = "Phán Xét Của Tuyết Tuyến"
  },
  Event_146300_ChoiceDesc1 = {
    Text = "[Bắt đầu lại] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_146300_ChoiceDesc2 = {
    Text = "[Điều này thật khó khăn] Nhận bạc tạo vật \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_146300_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_146300_Desc = {
    Text = "Con sâu dạy cô ấy những lời dối trá.\nNgoài ra, cô ấy chưa bao giờ học được cách sinh tồn.\nNhưng dối trá rốt cuộc chỉ là dối trá, từ một ngày nào đó, bạn phải sống tiếp mà không có nó làm chỗ dựa."
  },
  Event_146300_Name = {
    Text = "Ảo Chứ Chẳng Thật"
  },
  Event_146301_ChoiceDesc1 = {Text = "[đi]"},
  Event_146301_Desc = {
    Text = "\"Đúng vậy, nhưng một chú chuột nhỏ như thế, làm sao biết được cái giá của sự tham ăn là gì chứ?\""
  },
  Event_146301_Name = {
    Text = "Con Chuột Tham Ăn"
  },
  Event_146302_ChoiceDesc1 = {
    Text = "[Buộc dây đỏ] Xóa 1 thẻ lệnh, nhận Arg1 dấu đen"
  },
  Event_146302_ChoiceDesc2 = {
    Text = "[Từ chối dây đỏ] Sao chép 1 thẻ lệnh, nhiễm \"(Skill.Arg1)\""
  },
  Event_146302_ChoiceDesc3 = {
    Text = "[Trở Về Thực Tại] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\""
  },
  Event_146302_Desc = {
    Text = "Giấc mơ đầu tiên. Giấc mơ trong rừng. Hai đứa trẻ chưa đầy mười tuổi, bị giáo chủ bỏ lại trong khu rừng tối tăm sâu thẳm.\n\"Sau khi màn đêm buông xuống, những dã thú đang ngủ say sẽ bắt đầu săn mồi. Hãy trốn thoát trước khi điều đó xảy ra. Đứa nào trốn thoát được, mới là đứa con ngoan của ta nhé.\"\nEm trai nắm lấy tay anh, lấy ra một đoạn dây đỏ.\n\"Anh ơi, hãy buộc tay chúng ta lại với nhau đi. Như vậy, chúng ta sẽ không bị lạc nhau.\""
  },
  Event_146302_Name = {
    Text = "Giấc Mơ Xưa I"
  },
  Event_146304_ChoiceDesc1 = {Text = "[đi]"},
  Event_146304_Desc = {
    Text = "Ngươi nghe thấy tiếng cười đùa.\nVui vẻ, khiêu khích, đầy thú vị.\nNhững nỗ lực dốc hết sức lực của con người để khám phá vũ trụ, trong mắt Họ chẳng qua chỉ là kiến bò."
  },
  Event_146304_Name = {
    Text = "Kẻ Bị Nhìn Xuống"
  },
  Event_146306_ChoiceDesc1 = {Text = "[đi]"},
  Event_146306_Desc = {
    Text = "Nó sẽ thanh tẩy. Nó sẽ tan chảy. Nó thu nhận vào lòng tất cả những người leo núi không trở về."
  },
  Event_146306_Name = {
    Text = "Phán Xét Của Tuyết Tuyến"
  },
  Event_146307_ChoiceDesc1 = {Text = "[đi]"},
  Event_146307_Desc = {
    Text = "Bạn và con quạ rơi vào thế giằng co.\nRõ ràng là, trong cuộc đối đầu này, bạn không thể trở thành kẻ chiến thắng cuối cùng.\nTrong cuộc đối kháng với Yu Li-ét, dường như các bạn sẽ mãi mãi không bao giờ là vậy."
  },
  Event_146307_Name = {
    Text = "Giấc Mơ Xưa II"
  },
  Event_146308_ChoiceDesc1 = {
    Text = "[Ai đang nhìn ta?] Ngẫu nhiên thức tỉnh 1 Thể thức tỉnh, nhiễm \"(Skill.Arg1)\""
  },
  Event_146308_ChoiceDesc2 = {
    Text = "[Tập trung vào hiện tại] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\""
  },
  Event_146308_Desc = {
    Text = "Gió cuốn theo băng tuyết gào thét qua nơi cao nhất mà dấu chân con người từng đặt đến.\nNgươi ngước nhìn lên, cao hơn nữa chỉ còn mặt trời chưa bao giờ tắt từ thuở hồng hoang.\nNhưng ngươi biết, ở nơi nào đó cao hơn và xa hơn, còn có vô số đôi mắt, hoặc mở, hoặc nhắm.\nTrong số đó, vài đôi đang lặng lẽ nhìn xuống toàn bộ thế giới dưới chân ngươi."
  },
  Event_146308_Name = {
    Text = "Kẻ Bị Nhìn Xuống"
  },
  Event_146309_ChoiceDesc1 = {
    Text = "[Ta vẫn còn lưu luyến] Nhận vật bị nguyền rủa \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_146309_ChoiceDesc2 = {
    Text = "[Ta đã Quên lãng] 1 thẻ bài ngẫu nhiên nhận Khắc ấn: \"(EnchantConfig.Arg1)\""
  },
  Event_146309_Desc = {
    Text = "Bạn thử đóng kín mô-đun lưu trữ \"ký ức\" trong não.\nCái hộp bí mật đó chứa đựng tất cả những câu trả lời cấu thành nên bạn, tất cả những suy nghĩ bạn xấu hổ không dám nói ra, tất cả những mộng tưởng bạn không muốn ai biết.\nNhưng ham muốn là lời nguyền của tiềm thức, là giấc mộng ảo mà bạn không thể cưỡng lại."
  },
  Event_146309_Name = {
    Text = "Lời Nguyền Tiềm Thức"
  },
  Event_146310_ChoiceDesc1 = {Text = "[đi]"},
  Event_146310_Desc = {
    Text = "William tránh ánh mắt ngươi.\n\"Ý thức là vũ khí chống lại sự mê hoặc. Còn trải nghiệm cuộc đời của mỗi người quyết định ý thức của họ, không thể thay thế, cũng không thể truyền thụ.\"\n\"Điều duy nhất tôi có thể nói với ngươi là, đừng để bản thân bị sự yếu đuối nuốt chửng.\""
  },
  Event_146310_Name = {
    Text = "Sự Chìm Đắm Dịu Dàng"
  },
  Event_146311_ChoiceDesc1 = {Text = "[đi]"},
  Event_146311_Desc = {
    Text = "\"Nghe ra rồi, anh là kiểu người muốn làm triết gia. Nhưng đừng quên, không có kỳ vọng, không có nghĩa là không có đau khổ.\" Tiếng chuông cười vang rồi dần xa."
  },
  Event_146311_Name = {
    Text = "Phản Xạ Pavlov"
  },
  Event_146312_ChoiceDesc1 = {
    Text = "[rời đi] bị nhiễm [(Skill.Arg1)], nhận được 50 dấu đen"
  },
  Event_146312_Desc = {
    Text = "\"Đói quá, đói quá.\"\nNúi khóc than, núi rên rỉ.\nNúi không thể chịu đựng được, bụng nó trống rỗng."
  },
  Event_146312_Name = {
    Text = "Bí Mật Của Núi"
  },
  Event_146313_ChoiceDesc1 = {
    Text = "[Đạp vào vách đá] Xóa 1 thẻ lệnh và hồi phục Arg1 điểm Sinh lực"
  },
  Event_146313_ChoiceDesc2 = {
    Text = "[Bám lấy dây an toàn] Nhận vật tạo vàng \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_146313_Desc = {
    Text = "Những ảo giác rực rỡ sắc màu cuộn trào trong tâm trí ngươi.\nBan đầu là lớp tuyết bột đang rời ra.\nRồi đến mái tuyết sụp đổ.\nNgươi không thể ngăn mình trượt xuống, dây an toàn cọ xát vào móc khóa bắn ra những tia lửa chói mắt.\nNhưng trước mặt núi non, nó thật nhỏ bé và mong manh."
  },
  Event_146313_Name = {
    Text = "Rơi Xuống Im Lặng"
  },
  Event_146314_ChoiceDesc1 = {Text = "[đi]"},
  Event_146314_Desc = {
    Text = "\"Hãy đến bên ta trong giấc mơ, để ta có thể sống lại cuộc đời của mình.\"\nMáy hát phát ra một tiếng nức nở, rồi tiếng thở dần tan biến trong bóng tối.\nChỉ còn tiếng vang. Chỉ có tiếng vang."
  },
  Event_146314_Name = {
    Text = "Tiếng Vọng Lưu Luyến"
  },
  Event_146315_ChoiceDesc1 = {
    Text = "[Sinh lòng hối hận] Nhận bạc tạo vật \"(RelicConfig.Arg1)\""
  },
  Event_146315_ChoiceDesc2 = {
    Text = "[Tất cả đều là sắp đặt của số phận] Nhận vật tạo vàng \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_146315_Desc = {
    Text = "Ngươi luôn biết rằng chuyến hành trình này không đơn giản như tưởng tượng, phần lớn những người leo núi trong đội đều có mưu tính riêng.\nNhưng khi ngươi nhìn vào khuôn mặt cười ngạo mạn ngày càng điên cuồng của Caraboo, vẫn có một tiếng vỡ vụn như thủy tinh nổ tung trong lồng ngực ngươi.\nCó lẽ khi Naraka muốn đuổi cô ấy ra khỏi đội, ngươi đáng lẽ phải đưa ra một lựa chọn khác."
  },
  Event_146315_Name = {
    Text = "Kế Trong Kế"
  },
  Event_146316_ChoiceDesc1 = {Text = "[đi]"},
  Event_146316_Desc = {
    Text = "Bao nhiêu người đã bị nuốt chửng nơi đây?\nVũng sâu đặc quánh giơ những bàn tay đen, cố kéo ngươi vào thế giới của chúng.\nNhưng ngươi cứ tiến bước, chúng dường như cũng chẳng có ý giữ lại, lần lượt rút lui.\nPhía trước vẫn còn đỉnh cao đang chờ ngươi."
  },
  Event_146316_Name = {
    Text = "Tiếng Vọng Lưu Luyến"
  },
  Event_146317_ChoiceDesc1 = {
    Text = "[Từ bỏ] Nhận 25 dấu đen"
  },
  Event_146317_ChoiceDesc2 = {
    Text = "[Cúi xuống xem] Nhận bạc tạo vật \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_146317_Desc = {
    Text = "Theo dõi ánh mắt của tinkerer, ngươi không khỏi chăm chú nhìn xuống đáy hồ.\nRốt cuộc có điều gì trong bóng phản chiếu kia đang thu hút cô ấy?\nNhưng ngươi không nhìn rõ, trên mặt băng chỉ phản chiếu lờ mờ bóng của chính ngươi."
  },
  Event_146317_Name = {
    Text = "Bóng Phản Chiếu Đáy Hồ"
  },
  Event_146318_ChoiceDesc1 = {Text = "[đi]"},
  Event_146318_Desc = {
    Text = "Cách duy nhất để chống lại sự nuốt chửng là từ bỏ.\nKhông ai có thể mất đi thứ mình chưa từng sở hữu.\nWendigo nhe răng, trong cổ họng phát ra tiếng gầm thấp không cam lòng, từng bước lùi vào màn sương."
  },
  Event_146318_Name = {
    Text = "Lời Nguyền Tiềm Thức"
  },
  Event_146319_ChoiceDesc1 = {
    Text = "[Tuyết sẽ Làm sạch ta] Ngẫu nhiên nâng cao phẩm chất Khắc ấn của 1 thẻ bài"
  },
  Event_146319_ChoiceDesc2 = {
    Text = "[Tuyết sẽ Xét xử ta] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_146319_Desc = {
    Text = "Trước mắt là chặng leo cuối cùng, đường tuyết lạnh lẽo và trải dài.\nTuyết trắng đến chói mắt, ngay cả cái chết ở đây cũng trông có vẻ sạch sẽ."
  },
  Event_146319_Name = {
    Text = "Phán Xét Của Tuyết Tuyến"
  },
  Event_146320_ChoiceDesc1 = {Text = "[đi]"},
  Event_146320_Desc = {
    Text = "Đừng bỏ sót bất kỳ chi tiết nào trong hình ảnh đó.\nKhắc chúng vào tâm trí.\nKhắc cả sự mơ hồ, trống rỗng và nỗi đau ùa đến trong khoảnh khắc đó.\nĐừng bao giờ quên."
  },
  Event_146320_Name = {
    Text = "Từ Bờ Kia Đến"
  },
  Event_146321_ChoiceDesc1 = {
    Text = "[Cùng nhau chiến đấu] Nhận bạc tạo vật \"(RelicConfig.Arg1)\""
  },
  Event_146321_ChoiceDesc2 = {
    Text = "[Xoa dịu] Nhận vật tạo vàng \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_146321_Desc = {
    Text = "Ngọn núi rung chuyển dữ dội, như một sinh vật đang hấp hối.\nNhững mảng thịt trắng nhợt hình đốt trào ra từ dưới lớp đá nứt vỡ, từng đốt một vươn cao, quấn chặt, hất Caraboo ngã xuống mạnh.\nKhi xuất hiện trở lại trước mặt mọi người, trên má cô đã có một hàng nước mắt.\nĐó có phải là vết nước mắt đau khổ không?\nBạn không chắc.\nVô số lời dối trá đã từng thốt ra từ miệng cô, ai còn tin vào nước mắt cá sấu nữa?"
  },
  Event_146321_Name = {
    Text = "Nước Mắt Cá Sấu"
  },
  Event_146322_ChoiceDesc1 = {Text = "[đi]"},
  Event_146322_Desc = {
    Text = "Bạn không truy hỏi câu trả lời, chỉ đứng sang bên cạnh cô.\n\"Đứng dậy đi,\" bạn nói, \"Vở kịch đang diễn dở, đừng bỏ cuộc giữa chừng.\"\nCaraboo sững lại một chút, rồi dùng sức lau mạnh mặt mình.\nCô loạng choạng đứng dậy, siết chặt vũ khí trở lại, sát cánh cùng nhau đối mặt với cái miệng khổng lồ đẫm máu đang khép lại lần nữa.\nNói dối quá nhiều, đến cả cô cũng gần không phân biệt được giọt nước mắt nào thật giọt nào giả nữa.\nNhưng ít nhất lần này, không ai tính toán thật giả."
  },
  Event_146322_Name = {
    Text = "Nước Mắt Cá Sấu"
  },
  Event_146323_ChoiceDesc1 = {Text = "[đi]"},
  Event_146323_Desc = {
    Text = "\"Nghe ra rồi, anh là kiểu người giỏi phá vỡ bề ngoài. Nhưng đừng quên, trong thực tại của khoảnh khắc đó, thức ăn chỉ tồn tại trong kinh nghiệm và ảo tưởng của anh mà thôi.\" Tiếng chuông cười vang rồi dần xa."
  },
  Event_146323_Name = {
    Text = "Phản Xạ Pavlov"
  },
  Event_146324_ChoiceDesc1 = {Text = "[đi]"},
  Event_146324_Desc = {
    Text = "Bạn nhẹ nhàng, chậm rãi bước đi.\nKhẽ khàng, từ từ, lặng lẽ không một tiếng động…\nBạn cứ thế lách qua góc tiếp theo và trốn đi mất.\nRốt cuộc con quạ đó có đuổi theo không?\nBạn đã không còn nhớ nữa rồi."
  },
  Event_146324_Name = {
    Text = "Giấc Mơ Xưa II"
  },
  Event_146325_ChoiceDesc1 = {Text = "[đi]"},
  Event_146325_Desc = {
    Text = "Giai điệu đột ngột dừng lại.\nTừ vũng bùn đen, một đôi mắt khao khát mở ra.\nĐôi mắt ấy ướt đẫm nhìn chằm chằm vào ngươi, thì thầm những điều ngươi không thể phân biệt.\nRồi từ từ, từ từ khép lại."
  },
  Event_146325_Name = {
    Text = "Tiếng Vọng Lưu Luyến"
  },
  Event_146326_ChoiceDesc1 = {Text = "[đi]"},
  Event_146326_Desc = {
    Text = "Ngươi không dừng lại lâu, bỏ lại giai điệu ấy phía sau, bước chân nghiền nát tuyết tích, tạo ra âm thanh gấp gáp hơn cả tiếng gió.\nNhưng dù ngươi đi nhanh đến đâu, thanh âm hoang lương ấy vẫn cố chấp bám theo sau ngươi, không sót một bước.\nNgươi không thể thoát khỏi nó — đó là hơi thở của chính dãy núi tuyết này, còn ngươi, chỉ là một thính giả nhỏ bé tình cờ đi qua."
  },
  Event_146326_Name = {
    Text = "Huyễn Tấu Thiên Nhiên"
  },
  Event_146327_ChoiceDesc1 = {
    Text = "[Hãy lắng nghe] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_146327_ChoiceDesc2 = {
    Text = "[Không cần bận tâm] Mỗi Thể thức tỉnh có chỉ số điên cuồng từ 50 trở lên, nhận 15 dấu đen"
  },
  Event_146327_ChoiceDesc3 = {
    Text = "[Cưỡng ép rời đi] nhận được 1 trong 3 khắcăng"
  },
  Event_146327_Desc = {
    Text = "Trong gió có lẫn tiếng hát vọng từ xa.\nTiếng hát như đến từ bốn phía, hoặc từ dưới lòng đất mà lên.\nDù ngươi truy tìm theo hướng nào, nó vẫn vang vọng bên tai với cùng một cường độ như vậy."
  },
  Event_146327_Name = {
    Text = "Khúc Ngâm Hồ Băng"
  },
  Event_146328_ChoiceDesc1 = {Text = "[đi]"},
  Event_146328_Desc = {
    Text = "\"Hỡi ngôi sao tử thần, đây chưa phải lúc ngươi tỏa sáng.\"\n\"Hành trình của ta vẫn còn chưa chạm tới điểm cuối.\"\n\"Hãy tạm tắt đi, để bầu trời đêm nay trở lại yên bình.\""
  },
  Event_146328_Name = {
    Text = "Điềm Tử Thần Đến Gần"
  },
  Event_146329_ChoiceDesc1 = {Text = "[đi]"},
  Event_146329_Desc = {
    Text = "Sự hối tiếc vô ích trào dâng.\nCon người ta luôn bất đắc dĩ phải dọn dẹp mớ hỗn độn do chính mình trong quá khứ để lại."
  },
  Event_146329_Name = {
    Text = "Kế Trong Kế"
  },
  Event_146330_ChoiceDesc1 = {
    Text = "[Nhai]Ngẫu nhiên thức tỉnh 1 Thể Hoán Tỉnh, nhiễm「(Skill.Arg1)」"
  },
  Event_146330_ChoiceDesc2 = {
    Text = "[Từ chối]nhận 3 chọn 1 Lời cầu nguyện"
  },
  Event_146330_Desc = {
    Text = "Sâu trong màn tuyết mù, một thân xác gầy trơ xương đang nằm phục, xương sườn chống đỡ lớp da khô nứt, hai cành gạc khô như cành cây chết trên đỉnh đầu xuyên thủng màn sương.\nTừ trong bụng nó vang lên tiếng ọc ạch trống rỗng.\nKhoảnh khắc bạn nhìn thẳng vào mắt nó, trong hai hốc mắt sâu hoắm đó cuộn trào những hình ảnh vỡ vụn — đó là ký ức của bạn. Nó đã nếm được mùi vị rồi.\n\"Vẫn chưa đủ, vẫn chưa đủ…\" Nó rên rỉ khàn khàn, giơ bàn tay khô héo về phía bạn, dáng vẻ mang theo chút gì đó như van xin."
  },
  Event_146330_Name = {
    Text = "Kẻ Tham Thực"
  },
  Event_146332_ChoiceDesc1 = {
    Text = "[Thiên táng] Nhận bạc tạo vật \"(RelicConfig.Arg1)\""
  },
  Event_146332_ChoiceDesc2 = {
    Text = "[Xua đuổi]Nhận 75 Hắc Ấn, nhiễm \"(Skill.Arg2)\""
  },
  Event_146332_Desc = {
    Text = "Kền kền râu nhờ luồng khí bốc lên mà lượn vòng trên cao, tuần tra lãnh địa.\nTrong giới leo núi, đây luôn là điềm xấu.\n\"Chúng đang kiếm ăn. Kền kền có thể ngửi thấy mùi cái chết đang đến gần.\""
  },
  Event_146332_Name = {
    Text = "Điềm Tử Thần Đến Gần"
  },
  Event_146333_ChoiceDesc1 = {Text = "[đi]"},
  Event_146333_Desc = {
    Text = "Hãy tin vào đôi chân của mình.\nBạn sẽ chinh phục đỉnh cao."
  },
  Event_146333_Name = {
    Text = "Chạm Đến Đỉnh Cao"
  },
  Event_146334_ChoiceDesc1 = {Text = "[đi]"},
  Event_146334_Desc = {
    Text = "Khoảnh khắc ý nghĩ lưu luyến vụt lên trong đầu, bạn nhận ra mình đã không còn sức chống cự, chỉ có thể mặc nó thẳng tiến vào kho ký ức đã bị phong kín từ lâu của mình.\nNhững chiếc răng nanh trắng bệch cắm vào thái dương bạn, từng khung hình một bị nhổ bật lên tận gốc."
  },
  Event_146334_Name = {
    Text = "Lời Nguyền Tiềm Thức"
  },
  Event_146335_ChoiceDesc1 = {Text = "[đi]"},
  Event_146335_Desc = {
    Text = "Nó cúi người về phía bạn, đầu mũi gần chạm trán bạn, đắm chìm trong cảm xúc sâu sắc, như đang ngửi một miếng mật ngọt.\nNhững cảm xúc cuộn trào bất an bị liếm sạch bóng.\nNó kêu lên thỏa mãn rồi lùi lại, trong đáy mắt ánh lên thứ ánh sáng yêu kiều.\nLồng ngực bạn trống rỗng một mảng, nhưng lại kỳ lạ thay… nhẹ nhõm hơn nhiều."
  },
  Event_146335_Name = {
    Text = "Kẻ Tham Thực"
  },
  Event_146336_ChoiceDesc1 = {Text = "[đi]"},
  Event_146336_Desc = {
    Text = "\"Chú ý chân, mỗi bước đều phải đạp chắc,\" giọng Naraka vang lên bên tai ngươi, \"đừng lúc nào cũng trông chờ người khác đỡ cho mình.\""
  },
  Event_146336_Name = {
    Text = "Kẻ Bị Nhìn Xuống"
  },
  Event_146337_ChoiceDesc1 = {Text = "[đi]"},
  Event_146337_Desc = {
    Text = "Con người nên chạm tới bầu trời.\nMục tiêu khiến người ta quên đi hiểm nguy.\nBầu trời rộng lớn đang chờ đón bạn ngay trên đầu."
  },
  Event_146337_Name = {
    Text = "Chạm Đến Đỉnh Cao"
  },
  Event_146338_ChoiceDesc1 = {
    Text = "[Xua tan ký ức] Nhận vật tạo vàng \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_146338_ChoiceDesc2 = {
    Text = "[Bắt lấy ảo tưởng] Nhận 1 trong 3 vật tạo vàng, nhiễm \"(Skill.Arg1)\""
  },
  Event_146338_ChoiceDesc3 = {
    Text = "[rời đi] nhận được bạc tạo vật [(RelicConfig.Arg1)]"
  },
  Event_146338_Desc = {
    Text = "Kẻ giết William, lúc này đang ở ngay trước mắt bạn.\nBên trong lều của Yaran, trong bầu không khí ngột ngạt, khuôn mặt trắng bệch của William, thân xác lơ lửng, cùng chiếc Đèn cầm tay nhỏ bị mổ xẻ trên bàn, lại một lần nữa hiện ra trong tâm trí bạn."
  },
  Event_146338_Name = {
    Text = "Từ Bờ Kia Đến"
  },
  Event_146339_ChoiceDesc1 = {Text = "[đi]"},
  Event_146339_Desc = {
    Text = "Dây an toàn đứt phựt.\nNgươi ngã nặng nề vào đống tuyết, ngũ tạng lục phủ đều phát ra những hồi chuông cảnh báo chết người trong cơn đau âm ỉ.\nCố mở mắt dù đầu óc quay cuồng, một bộ hài cốt vô danh nhìn thẳng vào mặt ngươi.\nTrong đôi hốc mắt trống rỗng của hắn, có thứ gì đó đang lấp lánh."
  },
  Event_146339_Name = {
    Text = "Rơi Xuống Im Lặng"
  },
  Event_146340_ChoiceDesc1 = {Text = "[đi]"},
  Event_146340_Desc = {
    Text = "Không thể thoát được nữa rồi.\nBạn nghiến răng, rồi vọt người lao đi, cố dùng tốc độ để thoát khỏi kẻ giám sát.\nCon quạ kêu lên một tiếng, vỗ đôi cánh, thong thả bám theo phía trên đầu các bạn, thậm chí còn nhẹ nhàng lượn một vòng.\nSự tuyệt vọng lạnh lẽo thấm vào cơ thể theo ánh mắt của nó.\nCác bạn không thể trốn thoát đâu."
  },
  Event_146340_Name = {
    Text = "Giấc Mơ Xưa II"
  },
  Event_146341_ChoiceDesc1 = {
    Text = "[Thiện ác hữu báo] 1 thẻ lệnh ngẫu nhiên nhận Khắc ấn: \"(EnchantConfig.Arg1)\""
  },
  Event_146341_ChoiceDesc2 = {
    Text = "[Tuyệt đối bình đẳng] Tăng Arg1 điểm Sinh lực tối đa, nhiễm \"(Skill.Arg2)\""
  },
  Event_146341_Desc = {
    Text = "Ngươi treo lơ lửng trên vách đá, nhưng trong đầu bỗng nảy ra một câu hỏi chẳng liên quan: công bằng là gì?"
  },
  Event_146341_Name = {
    Text = "Sự Công Bằng Phi Lý"
  },
  Event_146342_ChoiceDesc1 = {
    Text = "[rời đi] bị nhiễm [(Skill.Arg1)], nhận được 50 dấu đen"
  },
  Event_146342_Desc = {
    Text = "\"Ta chưa thể chết!\"\nNúi khóc than, núi rên rỉ.\nNúi không thể chịu đựng được, vì lòng tham mà nó đã đánh mất mọi khả năng của ngày mai."
  },
  Event_146342_Name = {
    Text = "Bí Mật Của Núi"
  },
  Event_146343_ChoiceDesc1 = {Text = "[đi]"},
  Event_146343_Desc = {
    Text = "Ngươi cúi người xuống, cho đến khi má chạm vào mặt băng.\nCái lạnh thấu xương thấm từ da vào tủy, ngươi không khỏi rùng mình.\nMột sự tồn tại khó phân biệt đang chuyển động chậm rãi dưới lớp băng đóng kín, là dòng nước hay là sinh vật nào đó?\nDù là thứ nào, cũng chẳng liên quan đến hành trình của ngươi."
  },
  Event_146343_Name = {
    Text = "Bóng Phản Chiếu Đáy Hồ"
  },
  Event_148532_ChoiceDesc1 = {
    Text = "[Nhận Phép Màu] Sau khi chiến đấu bắt đầu, tạo 1 lá \"Quả Vạn Hóa\" ngẫu nhiên đặt vào bộ bài."
  },
  Event_148532_Desc = {
    Text = "Tuyết nguyên mênh mông trải dài vô tận, gió lạnh không cuốn nổi lấy một tiếng động, một bóng hình mờ ảo chẳng rõ từ đâu lặng lẽ hiện ra, đưa tới một quả thực mọng ấm.\nHương thơm ngọt ngào hòa cùng làn sương, ùa vào lỗ mũi tê cóng của lữ khách. \nVùng tuyết này đã từ lâu bị cái chết thấm đẫm, trong không khí phảng phất mùi thối rữa và băng giá khiến người buồn nôn, duy chỉ có quả thực trong lòng bàn tay là căng mọng đầy đặn, tựa như lời hứa hẹn quyến rũ của một thiếu nữ."
  },
  Event_148532_Name = {
    Text = "Ảo Ảnh Phía Trên"
  },
  Event_20778_ChoiceDesc1 = {
    Text = "[Giao cho cô ấy] tất cả thân thể được đánh thức hồi phục Arg1 điên cuồng"
  },
  Event_20778_ChoiceDesc2 = {
    Text = "[Cần hỗ trợ] Chọn 2 thân thể được đánh thức để tiến hành thức tỉnh"
  },
  Event_20778_Desc = {
    Text = "\"Đây là thông tin từ Misaque, phát hiện thấy chỉ số Nos bất thường của thân thể được đánh thức. Xin hỏi, liệu có cần sự hỗ trợ không?\""
  },
  Event_20778_Name = {
    Text = "Hỗ trợ thông tin"
  },
  Event_20779_ChoiceDesc1 = {Text = "[đi]"},
  Event_20779_Desc = {
    Text = "\"Đã cung cấp hỗ trợ khẩn cấp, vui lòng kiểm tra và gõ vào huy hiệu ba lần để xác nhận.\""
  },
  Event_20779_Name = {
    Text = "Hỗ trợ thông tin"
  },
  Event_20780_ChoiceDesc1 = {Text = "[đi]"},
  Event_20780_Desc = {
    Text = "Hình bóng từ tương lai xa xôi, ẩn khuất trong núi non Elworth."
  },
  Event_20780_Name = {
    Text = "Hình bóng núi lửa"
  },
  Event_20781_ChoiceDesc1 = {
    Text = "[Viễn vọng hình bóng] tất cả thân thể được đánh thức phục hồi Arg1 điểm điên cuồng"
  },
  Event_20781_ChoiceDesc2 = {
    Text = "[Gần hình bóng] Chọn kích hoạt 2 thân thể được đánh thức"
  },
  Event_20781_Desc = {
    Text = "Xa xa dường như có một miệng núi lửa phun trào, trong bầu trời gió mạnh cuốn lên là những làn khói hình người. \n Đây chính là Elworth, Elworth chỉ có những ngọn núi tuyết cao chót vót và những hang động đá vôi. \n Liệu những hiện tượng kỳ lạ liên tiếp này có khiến bạn phát điên không?"
  },
  Event_20781_Name = {
    Text = "Hình bóng núi lửa"
  },
  Event_20782_ChoiceDesc1 = {Text = "[đi]"},
  Event_20782_Desc = {
    Text = "Hình bóng vẫy tay với bạn, sau đó biến mất. Điều còn lại cho bạn chỉ là băng giá và dãy núi hùng vĩ."
  },
  Event_20782_Name = {
    Text = "Hình bóng núi lửa"
  },
  Event_20783_ChoiceDesc1 = {Text = "[đi]"},
  Event_20783_Desc = {
    Text = "\"Nhận được, chúng tôi sẽ tiến hành vận chuyển tài nguyên cơ bản, vui lòng chú ý kiểm tra.\""
  },
  Event_20783_Name = {
    Text = "Hỗ trợ thông tin"
  },
  Event_21398_ChoiceDesc1 = {
    Text = "[Nhặt ảnh] Chọn 1 trong 3 thẻ lệnh để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_21398_Desc = {
    Text = "Máy móc bị tháo dỡ, sự thật bị phơi bày. \nCuộc đời náo nhiệt tan biến không còn dấu vết, để lại cho bạn sự thỏa mãn khi sự thật được sáng tỏ."
  },
  Event_21398_Name = {
    Text = "Lời khai của nhân chứng"
  },
  Event_21399_ChoiceDesc1 = {
    Text = "[Nhặt ảnh] Chọn 1 trong 3 thẻ lệnh để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_21399_ChoiceDesc2 = {
    Text = "[Kiểm tra cuộn phim] Nhiễm [(Skill.Arg1)], thay đổi khắc ấn nhận được từ lựa chọn 1 và có thể sử dụng thêm một lần nữa"
  },
  Event_21399_Desc = {
    Text = "Sự tò mò thúc đẩy bạn, đưa tầm nhìn vào hồ hiện ảnh. \nNhững hình ảnh ngâm trong dung dịch thuốc đỏ thẫm, và kẻ tội đồ đầy vết bẩn đen sì kia, bỗng nhiên có khuôn mặt giống hệt bạn."
  },
  Event_21399_Name = {
    Text = "Lời khai của nhân chứng"
  },
  Event_21400_ChoiceDesc1 = {Text = "[đi]"},
  Event_21400_Desc = {
    Text = "Máy móc bị tháo dỡ, sự thật bị phơi bày. \nCuộc đời náo nhiệt tan biến không còn dấu vết, để lại cho bạn sự thỏa mãn khi sự thật được sáng tỏ."
  },
  Event_21400_Name = {
    Text = "Lời khai của nhân chứng"
  },
  Event_21811_ChoiceDesc1 = {Text = "[đi]"},
  Event_21811_Desc = {
    Text = "\" Hai mươi lăm năm... đúng vậy, cô ấy đã khiến tôi chìm vào giấc ngủ suốt hai mươi lăm năm.\"\nCô gái đáp lại bạn một cách u ám và chán nản. \nChỉ một giấc ngủ, những người hầu chăm sóc cô từ nhỏ đã trở thành những người dấn thân vào biển cả khi tuổi tác tăng lên. \nKhông còn ai hiểu nỗi khổ của cô, không còn ai quan tâm đến nỗi đau của cô, để lại cô đơn một mình trong giáo đoàn. \nCô ấy thà rằng ngày trước khi chìm vào giấc ngủ chính là \"thời khắc chính vị của các vì sao\"."
  },
  Event_21811_Name = {
    Text = "Sống bị giam cầm"
  },
  Event_22058_ChoiceDesc1 = {Text = "[đi]"},
  Event_22058_Desc = {
    Text = "\"Không, tôi không đói.\"\nBạn lịch sự từ chối lời mời tham gia bữa tiệc thịnh soạn này.\nCái giá phải trả để chiếm đoạt linh hồn là điều bạn chưa bao giờ sẵn lòng chấp nhận."
  },
  Event_22058_Name = {
    Text = "Lễ hội cơ thể"
  },
  Event_22059_ChoiceDesc1 = {Text = "[đi]"},
  Event_22059_Desc = {
    Text = "Bạn cắn một cách lộn xộn chiếc scone đang chảy máu, mùi thơm của tim được ướp hạt tiêu và bột nướng trộn lẫn, bạn ngửi thấy mùi quen thuộc. \n \"Để có được lực lượng, phải trả giá.\"\nBạn uống hết ngụm máu cuối cùng."
  },
  Event_22059_Name = {
    Text = "Lễ hội cơ thể"
  },
  Event_22060_ChoiceDesc1 = {Text = "[đi]"},
  Event_22060_Desc = {
    Text = "Bạn nuốt chửng canh trong và thịt băm, dùng tay áo lau sạch dấu vết ở khóe môi. \n Thịt mềm mượt, nước dùng thơm ngon, nhưng nó từng thuộc về ai? \n Chỉ là một phần nhỏ trong những gì bạn đã đánh mất."
  },
  Event_22060_Name = {
    Text = "Lễ hội cơ thể"
  },
  Event_22061_ChoiceDesc1 = {Text = "[đi]"},
  Event_22061_Desc = {
    Text = "Bạn tỉ mỉ xem xét những khắcăng cổ xưa trên quả chuông gió. \nChúng vặn vẹo đến mức người thường không thể tưởng tượng, dường như không muốn được hiểu. \nKhông được hiểu, thì không bị làm phiền."
  },
  Event_22061_Name = {
    Text = "Dây gió rỉ sét"
  },
  Event_22062_ChoiceDesc1 = {Text = "[đi]"},
  Event_22062_Desc = {
    Text = "\"Không tồi, bạn rất cẩn thận.\"\nTiếng nói xa xôi bất ngờ vọng ra từ quả gió chuông.\n \"Sự cẩn thận sẽ mang lại cho bạn một chút phần thưởng nhỏ, nhưng cũng chỉ có vậy mà thôi.\""
  },
  Event_22062_Name = {
    Text = "Dây gió rỉ sét"
  },
  Event_22063_ChoiceDesc1 = {Text = "[đi]"},
  Event_22063_Desc = {
    Text = "Bạn vuốt ve những khắcăng cổ xưa trên chuông gió. \nChúng xoắnvặn vẹo đến mức khó tưởng tượng đối với người thường,dường như không muốn được hiểu.\nVì không ai hiểu, nên cũng không ai làm phiền."
  },
  Event_22063_Name = {
    Text = "Dây gió rỉ sét"
  },
  Event_22064_ChoiceDesc1 = {Text = "[đi]"},
  Event_22064_Desc = {
    Text = "\"À, thật đáng tiếc... Vậy thì tôi chỉ còn cách tiếp tục bản độc tấu đơn độc này.\" Bạn không biết dây đàn và bàn tay đã biến mất từ khi nào, nhưng âm thanh tựa như dòng nước chảy nhẹ nhàng mãi mãi in sâu trong lòng bạn."
  },
  Event_22064_Name = {
    Text = "Hồn ma bên đàn"
  },
  Event_22065_ChoiceDesc1 = {Text = "[đi]"},
  Event_22065_Desc = {
    Text = "\"À, có được một người bạn như vậy, thật là vinh hạnh!\"Đôi tay đó hào hứng lên, bạn hoàn toàn không thể theo kịp tốc độ của nó. Cho đến khi bản nhạc kết thúc lâu rồi, âm thanh nhiệt huyết vẫn khiến bạn cảm thấy xúc động."
  },
  Event_22065_Name = {
    Text = "Hồn ma bên đàn"
  },
  Event_22175_ChoiceDesc1 = {Text = "[đi]"},
  Event_22175_Desc = {
    Text = "Bảng ouija trượt đi đầy tự tin, ánh mắt của bạn cũng theo đó mà lia qua lia lại. \nTuy nhiên, chỉ vừa chỉ ra được hai chữ cái, nó đã biến thành một dung dịch đen đặc trong tiếng thét thảm thiết."
  },
  Event_22175_Name = {
    Text = "Bảng thông linh"
  },
  Event_22176_ChoiceDesc1 = {Text = "[đi]"},
  Event_22176_Desc = {
    Text = "\"Toán học! Toán học!!\"\nGiọng nữ nghiến răng ken két, bảng bói di chuyển nhanh giữa các con số, phát ra tiếng ma sát gỗ chói tai. \n \"Mang toán học của cậu biến khỏi tầm mắt tôi!\""
  },
  Event_22176_Name = {
    Text = "Bảng thông linh"
  },
  Event_22177_ChoiceDesc1 = {Text = "[đi]"},
  Event_22177_Desc = {
    Text = "\"Đợi đã, đợi đã!!\"\n \"Hỏi tôi chứ! Sao không hỏi tôi!\""
  },
  Event_22177_Name = {
    Text = "Bảng thông linh"
  },
  Event_22178_ChoiceDesc1 = {Text = "[đi]"},
  Event_22178_Desc = {
    Text = "Nó chưa bao giờ rung động như lúc này, nhưng ngược lại, vực thẳm trong tâm hồn đang bị xé toạc…"
  },
  Event_22178_Name = {
    Text = "Lời nguyền khát vọng"
  },
  Event_22179_ChoiceDesc1 = {Text = "[đi]"},
  Event_22179_Desc = {
    Text = "Hồn và linh khí tràn ngập trong phổi của bạn, trong im lặng, bạn không ngừng trỗi dậy. \nÂm thanh của thế giới lần lượt vang lên, hòa tấu thành bản giao hưởng của sự sống."
  },
  Event_22179_Name = {
    Text = "Nước của quá khứ"
  },
  Event_22180_ChoiceDesc1 = {Text = "[đi]"},
  Event_22180_Desc = {
    Text = "Mọi thứ diễn ra như thường lệ, sự hủy diệt đến đúng hẹn, trong đống tro tàn chưa cháy hết chôn vùi những vật quý giá, tỏa sáng rực rỡ trong bóng tối."
  },
  Event_22180_Name = {
    Text = "Ngoài đầu kim"
  },
  Event_22181_ChoiceDesc1 = {Text = "[đi]"},
  Event_22181_Desc = {
    Text = "Gặp gỡ, rời đi, đi ngang qua nhau."
  },
  Event_22181_Name = {
    Text = "Âm thanh của sao và mặt trăng"
  },
  Event_22182_ChoiceDesc1 = {Text = "[đi]"},
  Event_22182_Desc = {
    Text = "Nhịp tim chậm dần, nhưng có lẽ \"lương tâm\"đã được an ủi đôi chút..."
  },
  Event_22182_Name = {
    Text = "Lời nguyền khát vọng"
  },
  Event_22183_ChoiceDesc1 = {Text = "[đi]"},
  Event_22183_Desc = {
    Text = "Bạn nhắm mắt, tận hưởng khoảnh khắc hư vô và tự do hiếm có. Dần dần, bạn cảm thấy thế giới nảy sinh từ sự tĩnh lặng, sức sống âm thầm bung tỏa trong im lặng."
  },
  Event_22183_Name = {
    Text = "Nước của quá khứ"
  },
  Event_22184_ChoiceDesc1 = {Text = "[đi]"},
  Event_22184_Desc = {
    Text = "Bạn chặn ngón kim, miếng bạc lấp lánh cắt vào lòng bàn tay mềm mại, sự hủy diệt chưa đến, nhưng bóng tối dưới chân bạn đã bị màn đêm đen như mực nuốt chửng."
  },
  Event_22184_Name = {
    Text = "Ngoài đầu kim"
  },
  Event_22185_ChoiceDesc1 = {Text = "[đi]"},
  Event_22185_Desc = {
    Text = "\"Bạn không thể trốn thoát, không ai có thể kháng cự sự xấu xa nội tại.\"\nÁc niệm xé rách dây thần kinh, cố gắng kéo bạn vào hố sâu. Nhưng cơn đau chỉ khiến tinh thần bạn cảm thấy tỉnh táo chưa từng có. \nÁc niệm không thể chiếm hữu bạn, bạn sẽ mãi là chính mình."
  },
  Event_22185_Name = {
    Text = "Niệm Vô Vọng"
  },
  Event_22186_ChoiceDesc1 = {Text = "[đi]"},
  Event_22186_Desc = {
    Text = "\"Tại sao không?\"\nChỉ cần ôm lấy những suy nghĩ kinh khủng đó, mọi vấn đề sẽ được giải quyết, thế giới sẽ không còn tồn tại nghịch lý mang tên \"đạo đức\"."
  },
  Event_22186_Name = {
    Text = "Niệm Vô Vọng"
  },
  Event_22187_ChoiceDesc1 = {Text = "[đi]"},
  Event_22187_Desc = {
    Text = "Bức màn ánh sáng bạc lóe lên trước mắt, một cơn gió u trầm cuốn đi mọi âm thanh."
  },
  Event_22187_Name = {
    Text = "Niệm Vô Vọng"
  },
  Event_22188_ChoiceDesc1 = {Text = "[đi]"},
  Event_22188_Desc = {
    Text = "Biến đổi, lạnh lùng, gần mà xa."
  },
  Event_22188_Name = {
    Text = "Âm thanh của sao và mặt trăng"
  },
  Event_22189_ChoiceDesc1 = {Text = "[đi]"},
  Event_22189_Desc = {
    Text = "Phình to, co lại, chực chờ bùng nổ."
  },
  Event_22189_Name = {
    Text = "Âm thanh của sao và mặt trăng"
  },
  Event_22190_ChoiceDesc1 = {Text = "[đi]"},
  Event_22190_Desc = {
    Text = "Mặc dù có chút vội vàng, nhưng tại sao không chứ?\nPhá vỡ mọi rào cản, lao về đích.\nCho dù khiến mặt hồ tư duy dậy sóng lớn, cho dù trở thành Icarus đuổi theo mặt trời, bạn vẫn đạt được mục tiêu, đúng không?"
  },
  Event_22190_Name = {
    Text = "Mê cung tư duy"
  },
  Event_22191_ChoiceDesc1 = {Text = "[đi]"},
  Event_22191_Desc = {
    Text = "Đại não của bạn là một mê cung, và bạn là người dẫn đường của nó, như Ariadne. \nTrong vũ trụ này, không ai hiểu rõ hơn bạn về cách thoát khỏi mê cung. \nKhông có ai."
  },
  Event_22191_Name = {
    Text = "Mê cung tư duy"
  },
  Event_22192_ChoiceDesc1 = {Text = "[đi]"},
  Event_22192_Desc = {
    Text = "Khi điều luật đúng, các khoảng âm không hòa điệu đã trở nên nhẹ nhàng hơn. \nCó lẽ bạn còn điều gì có thể làm."
  },
  Event_22192_Name = {
    Text = "âm không hòa"
  },
  Event_22193_ChoiceDesc1 = {Text = "[đi]"},
  Event_22193_Desc = {
    Text = "Bạn là bậc thầy âm nhạc, cũng là người không có năng khiếu âm nhạc. \n Dưới sự điều khiển của bạn, các nốt nhạc đều đảm nhiệm vai trò riêng, sức sống tuôn chảy cuối cùng đã cất tiếng vang trong thâm cảnh."
  },
  Event_22193_Name = {
    Text = "âm không hòa"
  },
  Event_22194_ChoiceDesc1 = {Text = "[đi]"},
  Event_22194_Desc = {
    Text = "Giọng của bạn bị chìm trong sự yên lặng. Sự im lặng đè nặng và lan tỏa, cho đến khi hoàn toàn vỡ vụn, để lại những mảnh vụn của sự im lặng."
  },
  Event_22194_Name = {
    Text = "Nước của quá khứ"
  },
  Event_22195_ChoiceDesc1 = {Text = "[đi]"},
  Event_22195_Desc = {
    Text = "Bạn sẽ không dễ dàng mắc bẫy, quay lưng một cách dứt khoát và rời khỏi đây."
  },
  Event_22195_Name = {
    Text = "Grieta reptante"
  },
  Event_22293_ChoiceDesc1 = {Text = "[đi]"},
  Event_22293_Desc = {
    Text = "Khi bút vừa chạm, bức thư trong thâm cảnh bốc cháy, tro tàn rơi nhẹ xuống lòng bàn tay, \nkhi nhận ra, dường như có điều gì đó đã biến mất cùng với bức thư."
  },
  Event_22293_Name = {
    Text = "Lời tâm sự một chiều"
  },
  Event_22294_ChoiceDesc1 = {Text = "[đi]"},
  Event_22294_Desc = {
    Text = "Giấy thư tan biến trong khoảnh khắc ở thâm cảnh, bạn nghe thấy sự quan tâm ấm áp nhưng đầy mệt mỏi. \n \"Trong tình huống này mà còn nghĩ đến tôi, đó là vinh dự của tôi với tư cách là một người thầy. \nTuy nhiên, lần cuối cùng tôi bước vào thâm cảnh... đã quá xa xưa. Giờ đây, tôi chỉ có thể hỗ trợ bạn đến vậy thôi...\""
  },
  Event_22294_Name = {
    Text = "Lời tâm sự một chiều"
  },
  Event_22295_ChoiceDesc1 = {Text = "[đi]"},
  Event_22295_Desc = {
    Text = "Tấm thư biến mất trong khoảnh khắc ở thâm cảnh, bạn nghe thấy tiếng kêu hoảng hốt. \n \"Người giữ bí mật, nếu có bất kỳ sự khó chịu nào, hãy nhất định cho tôi biết.\nLàm đối tác, tôi sẽ không tiếc công sức giúp đỡ bạn.\""
  },
  Event_22295_Name = {
    Text = "Lời tâm sự một chiều"
  },
  Event_22296_ChoiceDesc1 = {Text = "[đi]"},
  Event_22296_Desc = {
    Text = "Trong khoảnh khắc, giấy thư tan biến tại thâm cảnh, bạn nghe thấy một tiếng thở dài lạnh lùng. \n \"Giá mà khi thi không đạt điểm, bạn cũng chủ động cầu cứu sự giúp đỡ như vậy thì tốt biết bao.\""
  },
  Event_22296_Name = {
    Text = "Lời tâm sự một chiều"
  },
  Event_22397_ChoiceDesc1 = {Text = "[đi]"},
  Event_22397_Desc = {
    Text = "Sự xuất hiện của bạn khiến những bóng tối nhìn nhau ngỡ ngàng, một ánh sao nhẹ nhàng lướt qua đầu mũi giày. Đám đông đột nhiên tan biến, chỉ còn lại một bóng tối đặc quánh nằm gọn trong lòng bàn tay bạn."
  },
  Event_22397_Name = {
    Text = "Lời thề của sao và mặt trăng"
  },
  Event_22398_ChoiceDesc1 = {Text = "[đi]"},
  Event_22398_Desc = {
    Text = "Tiếng thì thầm ồn ào đột nhiên ngừng lại, những bóng đen như mực lần lượt quay về phía bạn, chăm chú nhìn bạn. Từ khuôn mặt không có ngũ quan đó, bạn dường như cảm nhận được vài phần sự mỉa mai…"
  },
  Event_22398_Name = {
    Text = "Lời thề của sao và mặt trăng"
  },
  Event_22399_ChoiceDesc1 = {
    Text = "[Quan sát bình tĩnh] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", lây nhiễm \"(Skill.Arg2)\""
  },
  Event_22399_ChoiceDesc2 = {
    Text = "[Hỏi Đáp Có Âm Thanh] được tặng 25 dấu đen"
  },
  Event_22399_Desc = {
    Text = "Trong sự đan xen của sao và trăng, những lời thì thầm không ngớt. \n \"Chính là người này sao? @4người đó...\"\n \"Thân phận loài người, rốt cuộc vẫn là @3...\""
  },
  Event_22399_Name = {
    Text = "Lời thề của sao và mặt trăng"
  },
  Event_22411_ChoiceDesc1 = {
    Text = "[Hoàn thành xuất sắc]"
  },
  Event_22411_Desc = {
    Text = "Bẫy rẻ nhưng hiệu quả!"
  },
  Event_22411_Name = {Text = "Làm bẫy"},
  Event_24254_ChoiceDesc1 = {Text = "[đi]"},
  Event_24254_Desc = {
    Text = "Cơn bão linh tri thức bao quanh tulô, bạn và anh ta liếc nhìn nhau, sau đó cùng bước vào bóng tối."
  },
  Event_24254_Name = {
    Text = "Từ biển cả"
  },
  Event_24255_ChoiceDesc1 = {Text = "[đi]"},
  Event_24255_Desc = {
    Text = "Cơn bão tri thức tâm linh bao quanh tulô, còn nỗi buồn sâu thẳm và cảm giác tội lỗi không nguôi thì lan tỏa trong không gian."
  },
  Event_24255_Name = {
    Text = "Đối mặt với hố sâu"
  },
  Event_24256_ChoiceDesc1 = {
    Text = "[nắm lấy xúc tu] chấp nhận sự giúp đỡ của tulô"
  },
  Event_24256_Desc = {
    Text = "Uy nghi của ông ấy như vật khổng lồ rơi xuống biển, khuấy động thâm cảnh trước mắt. \n Lực lượng đó cổ xưa, lâu đời, đủ để vượt qua vạn cổ. \n Thật đáng mừng là bạn sẽ không trở thành kẻ thù của ông ấy, ít nhất là trong thời điểm này."
  },
  Event_24256_Name = {
    Text = "Từ biển cả"
  },
  Event_24257_ChoiceDesc1 = {
    Text = "[nắm lấy xúc tu] đi cùng tulô"
  },
  Event_24257_Desc = {
    Text = "Tulô hít sâu một hơi, nhìn xa xăm về phía Miriam. \nDường như đang hoài niệm về lịch sử, hoài niệm về người xưa, hoài niệm về sức sống của mình... \nSắc mặt phức tạp trên khuôn mặt của anh chỉ tồn tại trong khoảnh khắc, sau đó anh chuyển ánh mắt khỏi khuôn mặt của Miriam. \n \"Đi thôi, rời xa cô ấy.\""
  },
  Event_24257_Name = {
    Text = "Đối mặt với hố sâu"
  },
  Event_24277_ChoiceDesc1 = {
    Text = "[đóng cửa khoang]"
  },
  Event_24277_Desc = {
    Text = "Ramona đã chặn lại học sinh xông vào từ bên ngoài. \n Người giữ bí mật không sợ hãi và mạnh mẽ, rõ ràng chỉ có vẻ ngoài rối bời mà không có gì khác lạ, hình bóng trong đôi mắt xanh biếc dưới kính của cô ấy lại trở nên mờ ảo. \n Cho đến khoảnh khắc nắm lấy tay, Ramona mới có thể xác nhận: các bạn đã gặp lại nhau."
  },
  Event_24277_Name = {
    Text = "Cuộc gặp gỡ vui vẻ"
  },
  Event_24278_ChoiceDesc1 = {Text = "[đi]"},
  Event_24278_Desc = {
    Text = "Ramona không để lại cơ hội cho bạn giải thích, cô ấy kéo bạn vào cabin mờ tối và cẩn thận đóng cửa hầm…"
  },
  Event_24278_Name = {
    Text = "Cuộc gặp gỡ vui vẻ"
  },
  Event_24540_ChoiceDesc1 = {Text = "[đi]"},
  Event_24540_Desc = {
    Text = "\"Cô ấy là lá chắn vững chắc của bạn, là thanh kiếm sắc bén trong tay bạn. \nCô ấy là người bạn đồng hành, người đối tác, người bạn tin cậy của bạn—dù cô ấy có trở thành thế nào đi nữa.\""
  },
  Event_24540_Name = {
    Text = "Sự hiện diện vừa lạ lẫm vừa quen thuộc"
  },
  Event_24541_ChoiceDesc1 = {Text = "[đi]"},
  Event_24541_Desc = {
    Text = "\"Là ngươi... Không, điều đó không thể nào... Ngươi trong chu kỳ này đã... Ta cũng đã...\"\nTiếng nói tan biến cùng với bóng dáng, chỉ còn nỗi buồn vẫn lởn vởn trong làn sương nước."
  },
  Event_24541_Name = {
    Text = "Hình dáng quen thuộc nhưng xa lạ"
  },
  Event_24542_ChoiceDesc1 = {Text = "[đi]"},
  Event_24542_Desc = {
    Text = "\"Để bảo vệ thế giới, để bảo vệ nhân loại, để bảo vệ những gì chúng ta trân trọng. \nTất nhiên, điều quan trọng nhất —— cô ấy đang làm điều này vì bạn.\""
  },
  Event_24542_Name = {
    Text = "Sự hiện diện vừa lạ lẫm vừa quen thuộc"
  },
  Event_24543_ChoiceDesc1 = {Text = "[đi]"},
  Event_24543_Desc = {
    Text = "Bạn còn chưa đến gần bóng hình thì đã chú ý đến bạn, thân hình của Ngài đột nhiên khựng lại, như thể kinh ngạc, lại như thể chìm trong nỗi buồn đau lớn lao. \nChưa kịp để bạn nói gì, Ngài đã cùng với làn sương tan biến."
  },
  Event_24543_Name = {
    Text = "Hình dáng quen thuộc nhưng xa lạ"
  },
  Event_24544_ChoiceDesc1 = {
    Text = "[Cô ấy là ai?] Lấy ngẫu nhiên 3 thẻ lệnh từ bộ bài và chọn 1 thẻ để sao chép"
  },
  Event_24544_ChoiceDesc2 = {
    Text = "[Tại sao cô ấy lại trở nên như vậy?] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", lây nhiễm \"(Skill.Arg2)\""
  },
  Event_24544_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_24544_Desc = {
    Text = "Lại một lớp sương mù, lại một bóng hình. Khác với trước đây, lần này bạn nhìn thấy đối phương rất rõ ràng. \nVóc dáng, bộ đồng phục và khuôn mặt y hệt bạn. \n \"Bạn biết tại sao bạn ở đây,\" người đó nói,\"như bạn biết tại sao cô ấy trở thành như vậy.\""
  },
  Event_24544_Name = {
    Text = "Sự hiện diện vừa lạ lẫm vừa quen thuộc"
  },
  Event_24545_ChoiceDesc1 = {
    Text = "[xoa dịu bằng lời nói] nhận được bạc tạo vật \"(RelicConfig.Arg1)\", bị ảnh hưởng bởi \"(Skill.Arg2)\""
  },
  Event_24545_ChoiceDesc2 = {
    Text = "[thử tiếp cận] nhận được bạc sáng tạo \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_24545_ChoiceDesc3 = {
    Text = "[quay lưng rời đi] nhận được 25 dấu đen"
  },
  Event_24545_Desc = {
    Text = "Sương mù bao phủ con đường phía trước của bạn. \nMột bóng dáng hiện ra trong ánh sáng mờ ảo, bạn nhíu mắt lại nhưng vẫn không thể nhìn rõ khuôn mặt của Người ấy, chỉ có thể nghe thấy những lời thì thầm đứt quãng. \n \"Tại sao... tại sao không thể cứu được... số phận, phải chăng không thể thay đổi sao...\""
  },
  Event_24545_Name = {
    Text = "Hình dáng quen thuộc nhưng xa lạ"
  },
  Event_35039_ChoiceDesc1 = {
    Text = "[Nhờ đối tác giúp đỡ] Nhận đá khắc cao cấp chọn 1 trong 3"
  },
  Event_35039_ChoiceDesc2 = {
    Text = "[Tiến hành điều phối phim trường] nhận được vật tạo vàng [(RelicConfig.Arg1)]"
  },
  Event_35039_ChoiceDesc3 = {
    Text = "[hướng dẫn hiện tượng cuồng nhiệt đỉnh cao] nhận được sáng tạo [(RelicConfig.Arg1)]"
  },
  Event_35039_Desc = {
    Text = "\"Trong 'Hướng dẫn tại phim trường của Thầy Houdini' đã chỉ rõ, Kasia, tức là tôi, với tư cách là nhà sản xuất kiêm đạo diễn, có nghĩa vụ và quyền hạn chịu trách nhiệm cho toàn bộ bộ phim. Vì vậy, nhân viên dũng cảm của Kasia ơi, hãy chọn thời gian hành động tiếp theo của bạn đi!\"\n\"Lịch, lịch trình? Chờ đã, từ khi nào tôi trở thành nhân viên của bạn?!\"\n\"Cơ hội không đến lần thứ hai, đừng do dự nữa!\""
  },
  Event_35039_Name = {
    Text = "Sự huyền thoại của nhà sản xuất"
  },
  Event_35103_ChoiceDesc1 = {
    Text = "[Kết nối] trả lời Arg2 điểm sức sống[ExDesc1][ExDesc2]."
  },
  Event_35103_ChoiceDesc2 = {
    Text = "[Thiền định] Chọn 1 thân thể được đánh thức để tiến hành thức tỉnh."
  },
  Event_35103_ChoiceDesc3 = {
    Text = "[Trục xuất] Loại bỏ tối đa 3 thẻ triệu chứng, nhận Arg2 dấu đen."
  },
  Event_35103_Desc = {
    Text = "Bạn đang khám phá trong sương mù, đột nhiên, huy hiệu trường trên ngực bạn phát ra ánh sáng bạc yếu ớt. Ai đang gọi bạn từ bên kia thiết bị liên lạc?"
  },
  Event_35103_Name = {
    Text = "điểm liên lạc"
  },
  Event_35103_Tips3 = {
    Text = "Hiện tại không sở hữu thẻ triệu chứng"
  },
  Event_35165_ChoiceDesc1 = {Text = "[đi]"},
  Event_35165_Desc = {
    Text = "Trong lúc do dự, bạn đã chủ động phát đi yêu cầu liên lạc với nhà tài trợ bí ẩn. \n\"Đến nước này, không thể quay đầu lại. Xin quý tộc rộng rãi mở hầu bao…\" \nBên kia máy liên lạc bạc tâm vang lên tiếng cười hào phóng, đối phương cuối cùng đã vui vẻ đồng ý với yêu cầu của bạn. \n\"À đúng rồi, còn… việc này xin hãy giữ bí mật với Ramona.\""
  },
  Event_35165_Name = {
    Text = "Sự huyền thoại của nhà sản xuất"
  },
  Event_35236_ChoiceDesc1 = {Text = "[đi]"},
  Event_35236_Desc = {
    Text = "Koordinator hiện trường là làm gì? Bạn đã lấy ra một tập tài liệu mà Kassia không biết đã nhét vào thiết bị chuyển giao linh tri thức từ lúc nào, và bắt đầu xem xét cẩn thận. \nSau đó, bạn bắt đầu cảm thấy đau đầu. \nChi phí tổn thất do lơ-tan gây ra trong quá trình bày trí hiện trường, đồ ăn vặt mà Ô Ryta và brun đã ăn, đơn xin hoàn tiền cho việc mua bóng phép thuật của Kassia… từng khoản thanh toán hiện ra trước mắt bạn, bạn buộc phải đau khổ ngồi xổm xuống để tính toán. \nNói về bóng phép thuật của Kassia thì sao?"
  },
  Event_35236_Name = {
    Text = "Sự huyền thoại của nhà sản xuất"
  },
  Event_35259_ChoiceDesc1 = {
    Text = "[Xua tan ảo ảnh] nhiễm triệu chứng [ExDesc1][ExDesc2]."
  },
  Event_35259_ChoiceDesc2 = {Text = "[đi]"},
  Event_35259_Desc = {
    Text = "Những khuôn mặt mờ ảo đột nhiên xuất hiện, chúng vây quanh bạn và tuyệt vọng rên rỉ bằng những dây thanh âm không tồn tại."
  },
  Event_35259_Name = {Text = "ảo ảnh"},
  Event_35497_ChoiceDesc1 = {Text = "[đi]"},
  Event_35497_Desc = {
    Text = "Sự cuồng nhiệt hiện tượng cần có người hỗ trợ, và khi nhắc đến \"người hỗ trợ\", hình ảnh một cô gái tóc ngắn màu xanh lá cây lập tức hiện lên trong tâm trí. \n \"Người môi giới số một của Đại học Misag, Hanna Peaslee xin phục vụ bạn!\" \n \"Nếu đây là lần đầu tiên của Người Giữ Gìn cần dịch vụ, chỉ cần trả 3 suất cơm cà ri ở căng tin nhé!\""
  },
  Event_35497_Name = {
    Text = "Sự huyền thoại của nhà sản xuất"
  },
  Event_35887_ChoiceDesc1 = {
    Text = "[đi tới]"
  },
  Event_35887_Desc = {
    Text = "Bạn nâng buồm lên, nhưng bên dưới lại trống rỗng. Khi bạn hồi hương, buồm đã không còn thấy nữa. \n Buồm Trắng Tinh Khôi và gương mặt mờ ảo của cô gái trở thành một thông điệp, nhắc nhở bạn rằng dù con đường phía trước ra sao, bạn cũng không đơn độc."
  },
  Event_35887_Name = {
    Text = "Buồm Trắng Tinh Khôi"
  },
  Event_35888_ChoiceDesc1 = {
    Text = "[Kéo căng cánh buồm]"
  },
  Event_35888_Desc = {
    Text = "Ở đây không có gió, nhưng có một chiếc thuyền buồm trắng tinh khôi, cánh buồm của nó vươn lên mạnh mẽ, đứng vững trên mặt biển xanh tĩnh lặng. \nBạn mơ hồ nhìn thấy gương mặt của một cô gái, các đường nét của cô ấy mờ nhạt, như thể nhìn qua một lớp sương mỏng hoặc một mặt nước đang chảy. Sự tồn tại của cô ấy dường như tách biệt với mọi thứ xung quanh, nhưng lại là trung tâm của cảnh tượng này. \nDù hình ảnh của cô ấy liên tục dao động trở nên rõ ràng hoặc mờ nhạt, nhưng không còn nghi ngờ gì, bạn biết cô ấy là ai."
  },
  Event_35888_Name = {
    Text = "Buồm Trắng Tinh Khôi"
  },
  Event_35894_ChoiceDesc1 = {
    Text = "[ hạ cánh xuống ] nhận được 35 dấu đen, bị nhiễm [(Skill.Arg2)], tiếp tục chọn"
  },
  Event_35894_ChoiceDesc2 = {Text = "[xa cách]"},
  Event_35894_Desc = {
    Text = "Giọng của cô gái trẻ lan tỏa trong không khí, mờ ảo và xa xôi như ảo ảnh."
  },
  Event_35894_Name = {
    Text = "Giữa sống và chết"
  },
  Event_35895_ChoiceDesc1 = {
    Text = "[Tuần mà lặp lại] nhận được 30 dấu đen, nhiễm [(Skill.Arg2)], tiếp tục chọn"
  },
  Event_35895_ChoiceDesc2 = {Text = "[xa cách]"},
  Event_35895_Desc = {
    Text = "Chi thể trở nên vô cùng nặng nề, sương mù bao trùm lấy thân thể yếu ớt."
  },
  Event_35895_Name = {
    Text = "Giữa sống và chết"
  },
  Event_35896_ChoiceDesc1 = {
    Text = "[Đọc con Đường của người xưa] Chọn 1 trong 3 thẻ lệnh nhận được Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_35896_ChoiceDesc2 = {
    Text = "[Viết con đường của riêng bạn] nhận được bạc sáng tạo \"(RelicConfig.Arg1)\", nhiễm phép \"(Skill.Arg2)\""
  },
  Event_35896_ChoiceDesc3 = {
    Text = "[Mục thị bóng tối] nhận được 25 dấu đen"
  },
  Event_35896_Desc = {
    Text = "Nếu bạn là một người đang mò mẫm tiến lên trong thâm cảnh, chắc chắn bạn sẽ không vững vàng như hiện tại. \nDấu chân trong thâm cảnh chia thành ba hướng, mỗi dấu chân in xuống đều viết nên tương lai không thể thấy được."
  },
  Event_35896_Name = {Text = "lối ra"},
  Event_35897_ChoiceDesc1 = {
    Text = "[Hãy đỡ cô ấy]"
  },
  Event_35897_ChoiceDesc2 = {
    Text = "[nhìn cô ấy]"
  },
  Event_35897_Desc = {
    Text = "Cô ấy lẩm bẩm, lảo đảo rồi dừng lại trước mặt bạn. \nChẳng rõ ai đã quấy rầy giấc ngủ yên bình của cô ấy, ý thức bị giam cầm bởi thực tại, còn linh hồn thì mãi lạc lối ở vương quốc đã mất."
  },
  Event_35897_Name = {
    Text = "Hình bóng mất tích"
  },
  Event_35898_ChoiceDesc1 = {Text = "[đi]"},
  Event_35898_Desc = {
    Text = "Trong bóng tối hỗn loạn chưa phân biệt này, một chuỗi dấu chân mờ nhạt kéo dài ra, giống như những dấu chân đậm nét mà người đi đêm để lại trên sa mạc vô hình."
  },
  Event_35898_Name = {Text = "lối ra"},
  Event_35899_ChoiceDesc1 = {
    Text = "[Rời đi] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_35899_Desc = {
    Text = "Trong mắt bạn phản chiếu một ngọn hải đăng xa xăm, cô đơn đứng vững bên rìa bóng tối, phát ra ánh sáng yếu ớt nhưng kiên định, như một người dẫn đường trong đêm biển, gọi mời những linh hồn lạc lối hướng về bờ bình yên. \n Bạn không thể không đuổi theo, tuy nhiên, dưới chân bỗng chốc không còn vững vàng. \n Bạn bước vào một vùng nước ẩn mình dưới bóng tối. Mặt nước mềm mại như tơ, im lặng tiêu thụ bước chân của bạn."
  },
  Event_35899_Name = {
    Text = "nháy mắt"
  },
  Event_35900_ChoiceDesc1 = {
    Text = "[Lắng nghe cô ấy]"
  },
  Event_35900_ChoiceDesc2 = {
    Text = "[bỏ qua cô ấy]"
  },
  Event_35900_Desc = {
    Text = "Bạn đã nhìn rõ nguồn gốc của ánh đèn, đó là một nhân vật có dáng vẻ phụ nữ. \n Ánh sáng chảy xuống từ đầu của một thực thể kỳ lạ, tạo thành con đường dẫn tới nơi vô định. \n \"Trở về... Li@2a...\""
  },
  Event_35900_Name = {
    Text = "Đèn sáng mãi"
  },
  Event_35901_ChoiceDesc1 = {
    Text = "[gần ngọn hải đăng]"
  },
  Event_35901_ChoiceDesc2 = {
    Text = "[Tránh xa ngọn hải đăng]"
  },
  Event_35901_Desc = {
    Text = "Quẹo qua khúc quanh nơi giao thoa giữa thực tại và giấc mơ, trong khoảnh khắc thoáng qua đó, một bức tranh khủng khiếp của cơn bão mở ra trước mắt. \n Như thể bị một bàn tay khổng lồ vô hình lật lên, gió dữ dội gầm rú như thú dữ, cuốn theo bụi bẩn và hy vọng, bầu trời u ám, nặng nề đến cực điểm. \n Ở trung tâm của cơn bão, ngọn hải đăng không nên tồn tại đứng sừng sững, dường như là sản phẩm của tưởng tượng, lại như di tích trong truyền thuyết cổ xưa. Nó phát ra ánh sáng yếu ớt, đơn độc và kiên cường trên sân khấu của cơn gió tàn phá."
  },
  Event_35901_Name = {
    Text = "Trung tâm bão tố"
  },
  Event_35902_ChoiceDesc1 = {
    Text = "[ Rời đi ] nhận được 50 dấu đen"
  },
  Event_35902_Desc = {
    Text = "\"Trong thâm cảnh, đèn đuốc sáng suốt đêm, hình bóng với xúc tu...\"\nTulô nhắm mắt trầm ngâm, một lát sau, thở dài một hơi thật sâu. \n \"Người gác cửa của Lemuria... một trong những tùy tùng của Dư. Cuối cùng, nàng cũng không thoát khỏi sự trói buộc của chấp niệm.\""
  },
  Event_35902_Name = {
    Text = "Sự chìm của tàu Sonanir"
  },
  Event_35903_ChoiceDesc1 = {
    Text = "[chạm vào ánh bạc] nhận được 25 dấu đen"
  },
  Event_35903_ChoiceDesc2 = {
    Text = "[Đối thoại với ánh sáng bạc] Nhận được bạc tạo vật \"(RelicConfig.Arg1)\", bị ảnh hưởng bởi \"(Skill.Arg2)\""
  },
  Event_35903_Desc = {
    Text = "Máy liên lạc kín đáo bị bẩy mở ra một khe hở, ánh sáng mờ nhạt chảy ra từ đó——đây có lẽ là lần đầu tiên sau khi bạc tâm được phong kín trong trung tâm máy liên lạc, nó trao đổi với thế giới bên ngoài."
  },
  Event_35903_Name = {
    Text = "Monumen Mithril"
  },
  Event_35904_ChoiceDesc1 = {
    Text = "[rời đi] nhận được sáng tạo [(RelicConfig.Arg1)]"
  },
  Event_35904_Desc = {
    Text = "\"Phụ nữ đầu phát sáng?\" Elton mặt lộ vẻ kinh ngạc, rõ ràng, ông đã nghe nói về hình bóng xuất hiện thỉnh thoảng trong thâm cảnh hàng hải, chỉ là —— \n \"Đêm tàu Sonanil chìm... cũng chính là đêm tôi thức tỉnh Hilaster, tôi đã từng thấy bóng dáng như vậy trong cơn bão.\"\n \"Tôi tuyệt đối không nhìn nhầm.\""
  },
  Event_35904_Name = {
    Text = "Sự chìm của tàu Sonanir"
  },
  Event_35905_ChoiceDesc1 = {Text = "[đi]"},
  Event_35905_Desc = {
    Text = "Thâm cảnh trước mặt đầy rẫy nguy cơ, sâu thẳm không thể đoán. \n Đôi mắt của bạn chằm chằm nhìn vào Hỗn Mang không thấy, nhưng trước khi bạn bị Hỗn Mang tiêu thụ, Ramona đã một tay bắt giữ bạn, kéo bạn sang một hướng khác."
  },
  Event_35905_Name = {Text = "lối ra"},
  Event_35906_ChoiceDesc1 = {Text = "[đi]"},
  Event_35906_Desc = {
    Text = "Đó có phải là trái cây được sinh ra từ linh hồn bí ẩn của bạn không? Tất cả những gì đang trải qua hiện tại có phải là sự va chạm giữa cái tôi và siêu tôi không? \n Càng nghĩ nhiều, tiếng ồn trong đầu càng vang vọng rõ ràng. Tầm nhìn đột nhiên lao vào một vùng sương mù, ngay khi bạn sắp nhìn thấy người trong sương mù, linh hồn đã từ chối bạn."
  },
  Event_35906_Name = {
    Text = "Số phận đảo ngược"
  },
  Event_35907_ChoiceDesc1 = {Text = "[đi]"},
  Event_35907_Desc = {
    Text = "Nó dâng lên trong cơ thể, hóa thành lực lượng vô úy, chống đỡ bạn xông phá sương mù, xé rách nỗi sợ hãi."
  },
  Event_35907_Name = {
    Text = "Theo đuổi ánh sáng"
  },
  Event_35908_ChoiceDesc1 = {Text = "[đi]"},
  Event_35908_Desc = {
    Text = "Khi ý thức tập trung và nội tâm yên tĩnh, những ảo ảnh hỗn loạn bắt đầu từ từ tan biến, cuối cùng như thủy triều rút đi. \n Cuối cùng, tiếng ồn trong não cũng biến mất không còn dấu vết — chỉ là, bạn sẽ bỏ lỡ bao nhiêu? Không thể biết được."
  },
  Event_35908_Name = {
    Text = "Cảnh báo tương lai"
  },
  Event_35909_ChoiceDesc1 = {Text = "[đi]"},
  Event_35909_Desc = {
    Text = "Linh hồn hoàn toàn chìm đắm trong tiếng ù tai, bạn cố gắng thoát ra, cố gắng hiểu rõ nỗi đau này, nhưng dù thế nào cũng chỉ có thể loanh quanh ở rìa ý thức…"
  },
  Event_35909_Name = {
    Text = "Giữa sống và chết"
  },
  Event_35910_ChoiceDesc1 = {
    Text = "[đi] nhận được quyền chọn 1 trong 3 vật tạo vàng, nhiễm [(Skill.Arg1)]"
  },
  Event_35910_Desc = {
    Text = "Bạn có thể cảm nhận từng điểm sáng phát ra từ ngọn hải đăng, chúng đang cháy và nhảy múa trong cơn bão, giống như tiếng gọi từ sâu thẳm linh hồn, ngay cả trong nỗi sợ hãi dữ dội nhất, cũng không bao giờ từ bỏ sứ mệnh dẫn đường trở về."
  },
  Event_35910_Name = {
    Text = "Trung tâm bão tố"
  },
  Event_35911_ChoiceDesc1 = {
    Text = "[rời đi] nhận được 3 lựa chọn [đá khắc cao cấp]"
  },
  Event_35911_Desc = {
    Text = "Là biểu tượng của hy vọng, hay điềm báo hủy diệt? \nBạn không còn nhìn nó, như thể sự tồn tại của nó chỉ là một giấc mơ được dàn dựng cẩn thận."
  },
  Event_35911_Name = {
    Text = "Trung tâm bão tố"
  },
  Event_35912_ChoiceDesc1 = {
    Text = "[Chénlún Mílí] nhận được 20 dấu đen, bị nhiễm [(Skill.Arg2)]"
  },
  Event_35912_ChoiceDesc2 = {Text = "[xa cách]"},
  Event_35912_Desc = {
    Text = "Sau đó, trước mắt bạn bị phủ một lớp voan xám bất thường. Một lát sau, bạn nhận ra đó là mí mắt trên bán trong suốt của mình."
  },
  Event_35912_Name = {
    Text = "Giữa sống và chết"
  },
  Event_35913_ChoiceDesc1 = {
    Text = "[Rời đi] ngẫu nhiên thức tỉnh 1 thân thể được đánh thức, nhiễm [(Skill.Arg1)]"
  },
  Event_35913_Desc = {
    Text = "Trong lòng bạn dâng lên một cảm giác sự cộng hưởng khó tả. \nNhưng lý trí nói với bạn: bỏ qua cô ấy."
  },
  Event_35913_Name = {
    Text = "Đèn sáng mãi"
  },
  Event_35914_ChoiceDesc1 = {
    Text = "[Rời đi] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_35914_Desc = {
    Text = "Ngôn ngữ của cô ấy không bao giờ được khắc trên bất kỳ văn bia nào đã biết, nhưng lại ngưng tụ trong không khí thành những lời thú tội và gọi mời sâu sắc nhất. Như thể từ đầu bên kia của thời gian bay đến, vượt qua sự lắng đọng của năm tháng, mang theo nỗi nhớ thương sâu sắc về một quê hương xa xôi."
  },
  Event_35914_Name = {
    Text = "Đèn sáng mãi"
  },
  Event_35915_ChoiceDesc1 = {
    Text = "[nắm lấy tay cô ấy] ngẫu nhiên 1 bạc sáng tạo nâng cấp thành vật tạo vàng[(RelicConfig.Arg1)]"
  },
  Event_35915_ChoiceDesc2 = {
    Text = "[Lời quan tâm] nhận được bạc tạo vật \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_35915_ChoiceDesc3 = {
    Text = "[Nhìn chăm chú cô ấy] nhận được 25 dấu đen"
  },
  Event_35915_Desc = {
    Text = "Muphí đi ở cuối đội, cô ấy đi bên cạnh Hilaster.\nBạn không thể kiềm chế được mà liên tục quay đầu lại nhìn cô ấy, nhưng Muphí luôn cúi đầu nhìn mũi giày của mình, giấu đi cảm xúc của mình một cách khó hiểu."
  },
  Event_35915_Name = {
    Text = "Quản lý đau"
  },
  Event_35915_Tips1 = {
    Text = "Chưa sở hữu bạc sáng tạo"
  },
  Event_35916_ChoiceDesc1 = {
    Text = "[không thể thoát thân] nhận được 40 dấu đen, bị lây nhiễm [(Skill.Arg2)], tiếp tục chọn"
  },
  Event_35916_ChoiceDesc2 = {
    Text = "[Embrace Reality] nhận 25 dấu đen"
  },
  Event_35916_Desc = {
    Text = "@1@1Tái sinh, linh hồn vượt qua ranh giới của @2, nhưng vẫn chưa hoàn toàn ôm lấy thể xác. \nLời nói quan tâm của Muphí ngày càng xa rời ý thức của bạn, như tiếng kêu than của chim quạ, văng vẳng bên tai, nhưng luôn bị rào cản tâm hồn chặn lại bên ngoài cửa sổ."
  },
  Event_35916_Name = {
    Text = "Giữa sống và chết"
  },
  Event_35917_ChoiceDesc1 = {
    Text = "[Rời đi] Chọn sao chép 1 thẻ lệnh, nhiễm [(Skill.Arg1)]"
  },
  Event_35917_Desc = {
    Text = "Cô chỉ là một bóng ma còn lại trong thực tại, một đoạn văn cổ xưa không thể với tới nhưng luôn ám ảnh tâm trí."
  },
  Event_35917_Name = {
    Text = "Hình bóng mất tích"
  },
  Event_35918_ChoiceDesc1 = {
    Text = "[rời đi] chọn 1 thẻ lệnh từ 3 thẻ lệnh để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_35918_Desc = {
    Text = "Trong khoảnh khắc đó, bạn nghe thấy âm thanh vỡ vụn tinh tế từ sâu thẳm linh hồn. Như làn khói dần tan biến, hình ảnh của cô ấy bắt đầu nhòa đi, trở nên ngày càng không thật. \nCô ấy không tồn tại ở đây, đây chỉ là phản xạ của ký ức thuyền trưởng Elton. \nNhưng những điều còn lại trong lòng, sự mất mát và bối rối thuộc về cô, không phải là giả dối."
  },
  Event_35918_Name = {
    Text = "Hình bóng mất tích"
  },
  Event_35919_ChoiceDesc1 = {Text = "[đi]"},
  Event_35919_Desc = {
    Text = "Trong khoảnh khắc đầu ngón tay chạm vào, một cảm giác phức tạp đột nhiên dâng lên trong lòng—nó vừa nóng bỏng vừa lạnh lẽo. \nLinh hồn bị thế giới lãng quên đang gào thét tìm kiếm sự vĩnh cửu."
  },
  Event_35919_Name = {
    Text = "Monumen Mithril"
  },
  Event_35920_ChoiceDesc1 = {
    Text = "[Gripping ngọn lửa] tăng Arg1 điểm máu tối đa"
  },
  Event_35920_ChoiceDesc2 = {
    Text = "[Đối mặt với nội tâm] 2 thẻ lệnh ngẫu nhiên nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm 2 thẻ \"(Skill.Arg2)\""
  },
  Event_35920_Desc = {
    Text = "Trong cuộc săn bắn hoành tráng này, sự truy đuổi của Goliath như một con thú hung dữ trong đêm tối, cố gắng tiêu thụ mọi ánh sáng hy vọng. Tuy nhiên, cuộc truy đuổi tàn nhẫn này không làm bạn đóng băng, mà ngược lại, nó đã thắp sáng ngọn lửa sâu thẳm trong lòng bạn, lan tỏa và đốt cháy trong lồng ngực, trở nên ngày càng nóng bỏng."
  },
  Event_35920_Name = {
    Text = "Theo đuổi ánh sáng"
  },
  Event_35921_ChoiceDesc1 = {
    Text = "[Giải mã nó] Lấy ngẫu nhiên 3 thẻ lệnh từ bộ bài và chọn 1 thẻ để sao chép"
  },
  Event_35921_ChoiceDesc2 = {
    Text = "[Trở thành nó] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", lây nhiễm \"(Skill.Arg2)\""
  },
  Event_35921_ChoiceDesc3 = {
    Text = "[bỏ qua nó] nhận 25 dấu đen"
  },
  Event_35921_Desc = {
    Text = "Trong khoảnh khắc bước chân, một sự rung động vô hình đã mạnh mẽ kéo giữ ý thức của bạn, buộc bạn phải nhìn về biên giới hỗn loạn và hư vô của thâm cảnh."
  },
  Event_35921_Name = {
    Text = "Cảnh báo tương lai"
  },
  Event_35922_ChoiceDesc1 = {Text = "[đi]"},
  Event_35922_Desc = {
    Text = "Có những màu sắc kỳ quái đang múa trước mắt, có những âm thanh thì thầm bên tai, hoặc là những cảnh tượng thoáng qua và những khuôn mặt mờ ảo, chúng đan xen vào nhau, như thể đang kể về những câu chuyện không biết đến. Những ảo ảnh này khiến bạn cảm thấy mình dần dần phân li khỏi thực tại, rơi vào một giấc mơ vừa quen thuộc vừa xa lạ."
  },
  Event_35922_Name = {
    Text = "Cảnh báo tương lai"
  },
  Event_35923_ChoiceDesc1 = {Text = "[đi]"},
  Event_35923_Desc = {
    Text = "Cơn run rẩy không phải đến từ tiếng ồn bên ngoài hay sự rung động về xúc giác, mà là một cảm giác khó tả sâu thẳm trong lòng. Giống như một tiếng gọi mơ hồ từ tương lai, chập chờn trong nhận thức của bạn."
  },
  Event_35923_Name = {
    Text = "Cảnh báo tương lai"
  },
  Event_35924_ChoiceDesc1 = {Text = "[đi]"},
  Event_35924_Desc = {
    Text = "Cô ấy vô thức đưa tay lên ngực, cố gắng kiểm soát cảm giác ngạt thở đó. \n Nỗi sợ hãi này khiến cô nghiến chặt hàm răng, ép buộc bản thân phớt lờ cơn đau dữ dội trong lồng ngực. Mỗi lần biến dạng nhỏ trên khuôn mặt của Muphí đều bị cô nhanh chóng che giấu, dùng một lớp giả dối vụng về để giấu đi nỗi đau. \n—— Cho đến khi bạn nắm lấy tay cô, sự ngạc nhiên trở thành màu sắc trên khuôn mặt cô."
  },
  Event_35924_Name = {
    Text = "Quản lý đau"
  },
  Event_35925_ChoiceDesc1 = {Text = "[đi]"},
  Event_35925_Desc = {
    Text = "\"Muphí? Cô còn ổn không?\"\n——Cô ấy không trả lời bạn.\nCái gì đó kỳ quái và hữu hình đang ăn mòn trái tim cô, khiến cô gần như không thể thở được."
  },
  Event_35925_Name = {
    Text = "Quản lý đau"
  },
  Event_35926_ChoiceDesc1 = {Text = "[đi]"},
  Event_35926_Desc = {
    Text = "Bạn không còn do dự, bước một chân vào bóng tối vô định. Nơi bạn đi qua, vẽ nên một lộ trình vươn tới ánh sáng mỏng manh."
  },
  Event_35926_Name = {Text = "lối ra"},
  Event_35927_ChoiceDesc1 = {Text = "[đi]"},
  Event_35927_Desc = {
    Text = "Trước mắt bạn có một ngọn lửa đang nhảy múa. \nNó nồng nhiệt, sống động, bao quanh một bó lửa lạnh lay động, rực rỡ xua tan những âm thanh không hài hòa. \nBạn trở lại với thực tại, chỉ để phát hiện ra rằng Muphí đang nhìn bạn với vẻ nghi hoặc— \n \"Cậu thật sự ổn chứ?\""
  },
  Event_35927_Name = {
    Text = "Giữa sống và chết"
  },
  Event_35928_ChoiceDesc1 = {Text = "[đi]"},
  Event_35928_Desc = {
    Text = "Bạn cảm thấy ý thức bắt đầu phân li, từ từ bị kéo ra khỏi thân thể. \n Dường như nhìn thấy linh hồn mình đang cùng bạc tâm còn lại múa, sau đó chìm sâu vào một vực thẳm vô hình… \n Đó là hư vô thuần khiết."
  },
  Event_35928_Name = {
    Text = "Monumen Mithril"
  },
  Event_35929_ChoiceDesc1 = {
    Text = "[Đi] nhận được 25 dấu đen"
  },
  Event_35929_Desc = {
    Text = "Chưa đợi bạn tiếp tục tìm hiểu nguồn gốc của ánh đèn, nó đột nhiên rung động mạnh và tan biến trong không khí. \n Ánh sáng gợn sóng trong thâm cảnh, lan tỏa ra xung quanh. \n Sau đó, không còn gì để lại."
  },
  Event_35929_Name = {
    Text = "nháy mắt"
  },
  Event_35930_ChoiceDesc1 = {Text = "[đi]"},
  Event_35930_Desc = {
    Text = "Làm sao có thể là bạn? \nNếu đó là bạn, tại sao khi nỗi buồn đến, Người không cứu rỗi bạn? \nNếu đó là bạn, tại sao khi trải qua khổ nạn, Ngài không giúp đỡ bạn? \nVì vậy, tất cả chỉ là ảo giác."
  },
  Event_35930_Name = {
    Text = "Số phận đảo ngược"
  },
  Event_35931_ChoiceDesc1 = {
    Text = "[Hỏi thuyền trưởng]"
  },
  Event_35931_ChoiceDesc2 = {
    Text = "[hỏi tulô]"
  },
  Event_35931_Desc = {
    Text = "Một lần nữa, bạn lại thấy hình bóng bí ẩn đó bước vào vách tàu, biến mất không còn dấu vết. Tóc phát quang dài từ một nơi nào đó bắt đầu, hóa thành nhiều xúc tu rủ xuống đất. \n Bạn vô cùng rõ ràng, cho dù cô ấy không phải là một thành viên của người dấn thân vào biển, thì thân phận của cô cũng nhất định có mối liên hệ chằng chịt với vương quốc đã thất lạc."
  },
  Event_35931_Name = {
    Text = "Sự chìm của tàu Sonanir"
  },
  Event_35932_ChoiceDesc1 = {Text = "[đi]"},
  Event_35932_Desc = {
    Text = "Bạn đang sợ hãi, mọi thứ đều là do hormone adrenaline. \nBạn sợ rằng quyết định của mình sẽ làm tổn thương những linh hồn chia sẻ bóng tối cùng bạn."
  },
  Event_35932_Name = {
    Text = "Theo đuổi ánh sáng"
  },
  Event_35933_ChoiceDesc1 = {
    Text = "[không thể trốn thoát] nhận được 25 dấu đen, bị lây nhiễm [(Skill.Arg2)], tiếp tục chọn"
  },
  Event_35933_ChoiceDesc2 = {Text = "[xa cách]"},
  Event_35933_Desc = {
    Text = "Mỗi sợi thần kinh đều gào thét sự khát khao đối với @2."
  },
  Event_35933_Name = {
    Text = "Giữa sống và chết"
  },
  Event_35934_ChoiceDesc1 = {Text = "[đi theo]"},
  Event_35934_ChoiceDesc2 = {
    Text = "[bỏ qua nó]"
  },
  Event_35934_Desc = {
    Text = "Trong thâm cảnh, từ xa, một ánh sáng nhẹ nhàng và mê hoặc bừng lên. \n Nó lấp lánh như ánh nắng phản chiếu trên mặt nước, lại giống như ánh sao lung linh, hoặc là một ngọn nến nhỏ… \n Khi bạn định tiến lại gần, ánh sáng đó đột ngột biến mất. \n Nó dường như đang dụ dỗ bạn, giống như dụ dỗ những con thiêu thân sống bằng trực giác."
  },
  Event_35934_Name = {
    Text = "nháy mắt"
  },
  Event_35935_ChoiceDesc1 = {Text = "[đi]"},
  Event_35935_Desc = {
    Text = "Đi bận tâm về những điều đó, có ích gì chứ? \nBạn là một chiếc lá rơi lơ lửng giữa không trung, gió định mệnh đẩy bạn đi, chỉ có vậy mà thôi."
  },
  Event_35935_Name = {
    Text = "Số phận đảo ngược"
  },
  Event_35936_ChoiceDesc1 = {
    Text = "[Tự châm biếm] nhận được bạc sáng tạo \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_35936_ChoiceDesc2 = {
    Text = "[truy cứu đến cùng] nhận được vật tạo vàng \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\",\"(Skill.Arg3)\""
  },
  Event_35936_ChoiceDesc3 = {
    Text = "[không còn mong muốn] nhận được 25 dấu đen"
  },
  Event_35936_Desc = {
    Text = "Gió của sức sống thổi vào linh hồn bạn, khiến bạn xoay chuyển trong dòng xoáy thực tại, cuốn vào sương mù dày đặc của điều chưa biết. \nBạn không thể kiềm chế được mà hỏi lại tiếng nói trong đầu: \"Đó có phải là tôi không?\""
  },
  Event_35936_Name = {
    Text = "Số phận đảo ngược"
  },
  Event_36146_ChoiceDesc1 = {Text = "[đi]"},
  Event_36146_Desc = {
    Text = "Muphí cuối cùng cũng chú ý đến ánh mắt của bạn, có lẽ, nó thực sự quá nóng bỏng. \nCô ấy hít thở sâu vài lần, phát ra một tiếng \"hừ\" nhẹ từ mũi. Cuối cùng, cô ấy kéo Hilaster theo và đi lên,đi theo sát sau lưng bạn."
  },
  Event_36146_Name = {
    Text = "Quản lý đau"
  },
  Event_36722_ChoiceDesc1 = {Text = "[đi]"},
  Event_36722_Desc = {
    Text = "Trong khoảnh khắc đầu ngón tay chạm vào, một cảm giác phức tạp đột nhiên dâng lên trong lòng—nó vừa nóng bỏng vừa lạnh lẽo. \nLinh hồn bị thế giới lãng quên đang gào thét tìm kiếm sự vĩnh cửu."
  },
  Event_36722_Name = {
    Text = "Bia Linh Tri"
  },
  Event_36723_ChoiceDesc1 = {
    Text = "[Chạm vào nó] ngẫu nhiên thức tỉnh 1 thân thể được đánh thức, gây nhiễm [(Skill.Arg1)]"
  },
  Event_36723_ChoiceDesc2 = {
    Text = "[thêm xoay] nhận được 1 trong 3 khắcăng"
  },
  Event_36723_Desc = {
    Text = "Trong khoảnh khắc bước chân, sâu thẳm trong tâm hồn bạn bỗng nứt ra một khe hở. Hơi thở sâu thẳm không thể diễn tả thổi qua khe hở, làm rối loạn tâm trí bạn. \n Bạn cảm nhận được một hành tinh hỗn mang màu bạc đang âm thầm xoay tròn và phát triển trong lòng."
  },
  Event_36723_Name = {
    Text = "Bia Linh Tri"
  },
  Event_36724_ChoiceDesc1 = {
    Text = "[theo dõi chúng] nhận được sáng tạo bạc \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_36724_ChoiceDesc2 = {
    Text = "[vuốt ve chúng] nhận được vật tạo vàng \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\", \"(Skill.Arg3)\""
  },
  Event_36724_ChoiceDesc3 = {
    Text = "[không làm phiền] nhận được 25 dấu đen"
  },
  Event_36724_Desc = {
    Text = "Sau khi rẽ qua một góc ngoặt bất ngờ, một cảnh tượng kỳ lạ hiện ra trong tầm mắt của bạn.\nVài bóng mèo, lờ mờ, ẩn hiện dọc theo bức tường lạnh lẽo."
  },
  Event_36724_Name = {Text = "mèo tàu"},
  Event_36725_ChoiceDesc1 = {Text = "[đi]"},
  Event_36725_Desc = {
    Text = "\"Ký ức\" không trả lời, họ áp sát vào vách khoang, mắt không chớp nhìn chằm chằm vào bạn, cho đến khi bạn đi qua góc tiếp theo."
  },
  Event_36725_Name = {
    Text = "Chủ nhân của tàu Sonanir"
  },
  Event_36726_ChoiceDesc1 = {
    Text = "[đi đường vòng] xóa 1 thẻ lệnh, nhận Arg1 dấu đen"
  },
  Event_36726_ChoiceDesc2 = {
    Text = "[hỏi tại sao chìm] sao chép 1 thẻ lệnh, nhiễm [(Skill.Arg1)]"
  },
  Event_36726_ChoiceDesc3 = {
    Text = "[Chào hỏi thủy thủ] Chọn 1 thẻ lệnh từ 3 thẻ để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_36726_Desc = {
    Text = "Đi trên con đường đến phòng động lực, bạn một lần nữa gặp phải những \"ký ức\" bị cố định trong thâm cảnh. \nHọ không phải là hồn ma, chỉ là sự bận tâm của thuyền trưởng Elton đối với những thủy thủ đã khuất."
  },
  Event_36726_Name = {
    Text = "Chủ nhân của tàu Sonanir"
  },
  Event_36727_ChoiceDesc1 = {Text = "[đi]"},
  Event_36727_Desc = {
    Text = "\"ký ức\" từ thành cabin bong ra, khuôn mặt anh ta vặn vẹo, phát ra tiếng kêu đau đớn từ cổ họng. \n——Hải đăng. \n——Hải đăng cô lập, đã dẫn họ vào cơn bão."
  },
  Event_36727_Name = {
    Text = "Chủ nhân của tàu Sonanir"
  },
  Event_36728_ChoiceDesc1 = {Text = "[đi]"},
  Event_36728_Desc = {
    Text = "Bạn đã chọn đi theo, theo dấu những linh hồn dịu dàng và tự do, dù phía trước là bẫy do bóng tối để lại."
  },
  Event_36728_Name = {Text = "mèo tàu"},
  Event_36729_ChoiceDesc1 = {Text = "[đi]"},
  Event_36729_Desc = {
    Text = "Đừng làm phiền người đã khuất, đừng đánh thức ký ức đang yên nghỉ."
  },
  Event_36729_Name = {
    Text = "Chủ nhân của tàu Sonanir"
  },
  Event_36730_ChoiceDesc1 = {Text = "[đi]"},
  Event_36730_Desc = {
    Text = "Bạn cảm thấy ý thức bắt đầu tách rời, từ từ bị kéo ra khỏi thân thể. \nDường như nhìn thấy linh hồn mình đang cùng hành tinh nhảy múa, sau đó chìm sâu vào một vực thẳm vô hình…… \nĐó là hư vô thuần khiết."
  },
  Event_36730_Name = {
    Text = "Bia Linh Tri"
  },
  Event_36731_ChoiceDesc1 = {Text = "[đi]"},
  Event_36731_Desc = {
    Text = "Là những sinh linh hiền lành, chúng chỉ là những ước mơ xa xỉ không được phép có trong thâm cảnh này, không gì hơn là hình bóng mà thôi. \nDù bạn hiểu rõ điều này, nhưng trong tim vẫn cảm nhận được một chút rung động ấm áp."
  },
  Event_36731_Name = {Text = "mèo tàu"},
  Event_36732_ChoiceDesc1 = {Text = "[đi]"},
  Event_36732_Desc = {
    Text = "Hình bóng của chúng, mờ ảo như bức tranh dầu bị cuốn trôi bởi dòng chảy của thời gian và không gian. Những đốm đen sâu thẳm như những đám mây trôi nổi trong bầu trời đêm, nhưng đôi mắt của chúng lại giống như ánh sáng của những vì sao xa xôi, tỏa ra ánh sáng huyền bí và sâu thẳm. \n Bạn không thể cưỡng lại sự cám dỗ của chúng, chìa tay vào một khoảng hư vô."
  },
  Event_36732_Name = {Text = "mèo tàu"},
  Event_36733_ChoiceDesc1 = {Text = "[đi]"},
  Event_36733_Desc = {
    Text = "Bạn biết rằng bạn phải tiếp tục tiến lên, dù là loạng choạng, dù là ngã xuống."
  },
  Event_36733_Name = {
    Text = "Đau đớn thể xác"
  },
  Event_36734_ChoiceDesc1 = {
    Text = "[Gọi thử anh ấy] tăng Arg1 điểm sức sống"
  },
  Event_36734_ChoiceDesc2 = {Text = "[đi]"},
  Event_36734_Desc = {
    Text = "Đây là nơi đầy ắp những mong ước ẩn giấu và nỗi sợ hãi chưa từng chạm đến, là bức tranh phong phú được dệt nên từ những giấc mơ và ký ức của anh ấy."
  },
  Event_36734_Name = {
    Text = "Biến đổi tiến hóa"
  },
  Event_36735_ChoiceDesc1 = {Text = "[đi]"},
  Event_36735_Desc = {
    Text = "\"Người giữ bí mật, nếu không thể tiếp tục kiên trì, đừng chịu đựng đau khổ một mình.\"\nBạn sẽ không trốn tránh cơn đau, vì chúng là một phần của sức sống phù du.\nBạn sẽ không lẩn tránh bóng tối của đêm, vì bạn không sợ bị tiêu thụ bởi sự tối tăm trong đó."
  },
  Event_36735_Name = {
    Text = "Đau đớn thể xác"
  },
  Event_36736_ChoiceDesc1 = {
    Text = "[ tiếp tục gọi anh ấy] tăng Arg1 điểm sức sống, lây nhiễm[(Skill.Arg2)]"
  },
  Event_36736_ChoiceDesc2 = {Text = "[đi]"},
  Event_36736_Desc = {
    Text = "Những nét vẽ nguệch ngoạc ngây thơ đã tạo nên thế giới này."
  },
  Event_36736_Name = {
    Text = "Biến đổi tiến hóa"
  },
  Event_36737_ChoiceDesc1 = {Text = "[đi]"},
  Event_36737_Desc = {
    Text = "Lời cầu nguyện của người dấn thân vào biển vang vọng bên tai, điên rồ và khiến người ta nghẹt thở. \nNhưng chúng sẽ không ảnh hưởng đến ý chí của bạn, chắc chắn sẽ không."
  },
  Event_36737_Name = {
    Text = "từ biển"
  },
  Event_36738_ChoiceDesc1 = {
    Text = "[Nhặt ảnh] Chọn 1 trong 3 thẻ lệnh để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_36738_Desc = {
    Text = "Những ánh nhìn sâu thẳm và trong veo, như ánh sáng trong biển sâu, sáng rõ và ấm áp. \nChúng không nói, cũng không hiện hình, nhưng bạn có thể cảm nhận được sự tồn tại của chúng, như sự an ủi của làn gió nhẹ thổi qua vào đêm hè."
  },
  Event_36738_Name = {
    Text = "Thám tử thiện ý"
  },
  Event_36739_ChoiceDesc1 = {Text = "[đi]"},
  Event_36739_Desc = {
    Text = "Bạn ép bản thân tập trung vào khủng hoảng trước mắt, kiên quyết yêu cầu bản thân bỏ qua hoàn toàn những đau đớn."
  },
  Event_36739_Name = {
    Text = "Đau đớn thể xác"
  },
  Event_36740_ChoiceDesc1 = {Text = "[đi]"},
  Event_36740_Desc = {
    Text = "Đó là dấu ấn của sức sống, là bằng chứng của sự tồn tại. Nó kể câu chuyện, nhưng trong cơn bão tàn phá, dần dần mất đi tiếng nói."
  },
  Event_36740_Name = {
    Text = "Tạm biệt, Icarus"
  },
  Event_36741_ChoiceDesc1 = {Text = "[đi]"},
  Event_36741_Desc = {
    Text = "Những ánh nhìn sâu thẳm và trong veo, như ánh sáng trong biển sâu, sáng rõ và ấm áp. \nChúng không nói, cũng không hiện hình, nhưng bạn có thể cảm nhận được sự tồn tại của chúng, như sự an ủi của làn gió nhẹ thổi qua vào đêm hè."
  },
  Event_36741_Name = {
    Text = "Thám tử thiện ý"
  },
  Event_36742_ChoiceDesc1 = {
    Text = "[Lần gọi cuối cùng] tăng Arg1 điểm sức sống, bị ảnh hưởng bởi [(Skill.Arg2)]"
  },
  Event_36742_ChoiceDesc2 = {Text = "[đi]"},
  Event_36742_Desc = {
    Text = "Những vết nứt của đau khổ tạo nên thế giới này."
  },
  Event_36742_Name = {
    Text = "Biến đổi tiến hóa"
  },
  Event_36743_ChoiceDesc1 = {
    Text = "[ôm đau đớn] nhận được bạc tạo vật \"(RelicConfig.Arg1)\", bị ảnh hưởng bởi \"(Skill.Arg2)\""
  },
  Event_36743_ChoiceDesc2 = {
    Text = "[Từ chối đau đớn] nhận được vật tạo vàng \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\" và \"(Skill.Arg3)\""
  },
  Event_36743_ChoiceDesc3 = {
    Text = "[bỏ qua đau đớn] nhận được 25 dấu đen"
  },
  Event_36743_Desc = {
    Text = "Đau đớn như hòn đá, cắm rễ trong tâm trí. Nỗi đau lan rộng như dây leo, quấn chặt từng centimet thần kinh, làm méo mó ý thức của bạn."
  },
  Event_36743_Name = {
    Text = "Đau đớn thể xác"
  },
  Event_36744_ChoiceDesc1 = {
    Text = "[kiên định gọi anh ấy] tăng Arg1 điểm sức sống, lây nhiễm [(Skill.Arg2)]"
  },
  Event_36744_ChoiceDesc2 = {Text = "[đi]"},
  Event_36744_Desc = {
    Text = "Sự hướng tới sự thừa nhận đã tạo nên thế giới này."
  },
  Event_36744_Name = {
    Text = "Biến đổi tiến hóa"
  },
  Event_36745_ChoiceDesc1 = {
    Text = "[Chú ý đến chúng] chọn 1 thẻ lệnh từ 3 thẻ lệnh để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_36745_ChoiceDesc2 = {
    Text = "[Gọi chúng giúp đỡ] Nhiễm [(Skill.Arg1)], thay đổi khắcăng nhận được từ tùy chọn 1, có thể sử dụng hai lần"
  },
  Event_36745_Desc = {
    Text = "Trong những màu sắc đang chảy trong thâm cảnh, bạn cảm nhận được một ánh nhìn bí ẩn, chúng là những đôi mắt vô hình, ẩn nấp trong những nếp gấp huyền bí của thâm cảnh. \n Vào khoảnh khắc chúng nhìn về phía bạn, trong lòng bạn trào dâng một khao khát mãnh liệt."
  },
  Event_36745_Name = {
    Text = "Thám tử thiện ý"
  },
  Event_36746_ChoiceDesc1 = {Text = "[đi]"},
  Event_36746_Desc = {
    Text = "Nếu không hiểu chúng, bạn sẽ không thể thoát khỏi địa ngục hỗn loạn này. \n Khi các vì sao phản chiếu trên mặt nước, những ước nguyện và khẩn cầu đang nhảy múa, những lời cầu nguyện như bọt nước, từ từ nổi lên mặt biển, nhưng lại vô tình bị bóng tối nuốt chửng."
  },
  Event_36746_Name = {
    Text = "từ biển"
  },
  Event_36747_ChoiceDesc1 = {
    Text = "[Gấp gáp gọi hắn] tăng Arg1 điểm sức sống, nhiễm [(Skill.Arg2)]"
  },
  Event_36747_ChoiceDesc2 = {Text = "[đi]"},
  Event_36747_Desc = {
    Text = "Lời nói độc ác tạo nên thế giới này."
  },
  Event_36747_Name = {
    Text = "Biến đổi tiến hóa"
  },
  Event_36748_ChoiceDesc1 = {Text = "[đi]"},
  Event_36748_Desc = {
    Text = "Bạn đứng trước mặt anh ta, chứng kiến linh hồn của anh ta bị những ký ức kỳ lạ nuốt chửng."
  },
  Event_36748_Name = {
    Text = "Biến đổi tiến hóa"
  },
  Event_36749_ChoiceDesc1 = {
    Text = "[Đó là nước mắt] xóa 1 thẻ bài"
  },
  Event_36749_ChoiceDesc2 = {
    Text = "[đó là máu] nhận được \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_36749_Desc = {
    Text = "Vài giọt chất lỏng trải rộng trên boong tàu một cách tùy ý, lặng lẽ lan tỏa qua các khe nứt của boong tàu. \n Những dấu vết đó nhẹ nhàng mà kiên định, mỗi vết ẩm đều mang ý nghĩa quyết liệt, trong tiếng gào thét của gió biển và tiếng rên rỉ của thuyền buồm, tạo nên một bức tranh về sự sống và cái chết, sự yên bình và ồn ào."
  },
  Event_36749_Name = {
    Text = "Tạm biệt, Icarus"
  },
  Event_36750_ChoiceDesc1 = {Text = "[đi]"},
  Event_36750_Desc = {
    Text = "Bạn nhìn chằm chằm vào những đốm sáng từ từ lan rộng, cố gắng phân biệt bản chất của chúng, nhưng ở ranh giới giao thoa giữa trời và đất, sự khác biệt giữa nước mưa và máu trở nên mờ nhạt. \n Chúng có phải là nước mưa không? Có phải là nước mắt của đại dương không? \n Bạn không biết."
  },
  Event_36750_Name = {
    Text = "Tạm biệt, Icarus"
  },
  Event_36751_ChoiceDesc1 = {
    Text = "[Từ chối tần số] Nhận được 3 lựa chọn Bạc sáng tạo"
  },
  Event_36751_ChoiceDesc2 = {
    Text = "[Tham gia cùng tần số] nhận được bạc tạo vật \"(RelicConfig.Arg1)\"\"(RelicConfig.Arg2)\", nhiễm hai lần \"(Skill.Arg3)\""
  },
  Event_36751_Desc = {
    Text = "Lời thì thầm của người dấn thân vào biển và nhịp tim của \"Đứa Trẻ Thánh\" hòa quyện thành bản giao hưởng bí ẩn, mỗi rung động đều khiến vũ trụ chất lỏng vô biên nổi lên một tiếng gào thét."
  },
  Event_36751_Name = {
    Text = "từ biển"
  },
  Event_36752_ChoiceDesc1 = {
    Text = "[Nhặt ảnh] Chọn 1 trong 3 thẻ lệnh để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_36752_ChoiceDesc2 = {
    Text = "[Kiểm tra cuộn phim] Nhiễm [(Skill.Arg1)], thay đổi khắc ấn nhận được từ lựa chọn 1 và có thể sử dụng thêm một lần nữa"
  },
  Event_36752_Desc = {
    Text = "Chúng không có ác ý, cảm giác này như một trực giác, ăn sâu vào trong xương máu của bạn. \n Vậy nên, bạn bỏ xuống sự phòng bị, thử tìm sự giúp đỡ từ những người canh gác bí mật này: chia sẻ những bối rối và khát khao của bạn với sự tồn tại mờ ảo đó, như thể tâm sự với một người bạn cũ, chân thành vô cùng."
  },
  Event_36752_Name = {
    Text = "Thám tử thiện ý"
  },
  Event_36874_ChoiceDesc1 = {
    Text = "[Kể về những chuyện vui ở trường] nhận được sáng tạo bạc [(RelicConfig.Arg1)]"
  },
  Event_36874_ChoiceDesc2 = {
    Text = "[chưa từng đi học] nhận được 75 dấu đen, bị lây nhiễm [(Skill.Arg2)]"
  },
  Event_36874_Desc = {
    Text = "Khi đi qua một nơi hoang tàn, đôi mắt của Ô Ryta bỗng sáng lên. \n \"Bà nội nói rằng, trước đây đây là trường học, nhưng vì không có học sinh nên đã bị bỏ hoang từ lâu rồi!\"\n \"Ô Ryta chưa bao giờ đi học, còn bạn? Bạn có từng đi học không?\""
  },
  Event_36874_Name = {
    Text = "Khoái lạc đã mất"
  },
  Event_36875_ChoiceDesc1 = {Text = "[đi]"},
  Event_36875_Desc = {
    Text = "Từ lời nói của bạn, Ô Ryta lắc đầu uể oải. \n \"Thì ra, thế giới bên ngoài cũng không có học sinh... Vậy mục đích ban đầu xây dựng trường học là gì?\""
  },
  Event_36875_Name = {
    Text = "Khoái lạc đã mất"
  },
  Event_36876_ChoiceDesc1 = {Text = "[đi]"},
  Event_36876_Desc = {
    Text = "\"Nhà tế bần, chuột nhỏ, tượng sáp... Hay quá! Thám hiểm, đúng là thám hiểm!\"\nÔ Ryta nói, trên đầu xuất hiện một dấu hỏi vô hình.\n \"Tuy nhiên, bà nói trường học là nơi sẽ khiến Ô Ryta thông minh hơn, nhưng...\"\nTrước khi Ô Ryta suy nghĩ thêm, bạn đã đẩy cô ấy qua một góc rẽ khác."
  },
  Event_36876_Name = {
    Text = "Khoái lạc đã mất"
  },
  Event_36877_ChoiceDesc1 = {Text = "[đi]"},
  Event_36877_Desc = {
    Text = "\"Vì, vì sao?\"\n Ô Ryta bị bạn dọa sợ, cô ấy cau mày tiếp tục chỉ huy bạn. \n \"Đây là nhà của Ô Ryta, Ô Ryta biết, quảng trường —— ngay bên trong đó!\""
  },
  Event_36877_Name = {
    Text = "Bóng tối vô hình"
  },
  Event_36878_ChoiceDesc1 = {Text = "[đi]"},
  Event_36878_Desc = {
    Text = "\"Tôi không muốn đi con đường này, Ô Ryta có biết cách khác để đến quảng trường không?\"\nÔ Ryta chu môi, cảm thấy hơi bối rối, nhưng cuối cùng vẫn kéo áo choàng của bạn, chỉ hướng khác."
  },
  Event_36878_Name = {
    Text = "Bóng tối vô hình"
  },
  Event_36879_ChoiceDesc1 = {Text = "[đi]"},
  Event_36879_Desc = {
    Text = "Đây là giấc mơ, chỉ là giấc mơ. \nBạn liên tục cảnh cáo, hoặc có thể nói là liên tục an ủi bản thân, dẫn dắt Ô Ryta lao vào bóng tối vô hình."
  },
  Event_36879_Name = {
    Text = "Bóng tối vô hình"
  },
  Event_36880_ChoiceDesc1 = {
    Text = "[Nghe theo cô ấy] chọn 1 thẻ lệnh từ 3 thẻ để nhận khắcăng:\"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_36880_ChoiceDesc2 = {
    Text = "[Phản đối cô ấy] Chọn 1 thân thể đã thức tỉnh, nhiễm [(Skill.Arg1)]"
  },
  Event_36880_ChoiceDesc3 = {
    Text = "[Trao đổi với cô ấy] nhận được 25 dấu đen"
  },
  Event_36880_Desc = {
    Text = "Ô Ryta kéo áo choàng của bạn, từng bước đi theo dấu chân của bạn. \n \"Ơ... sai rồi! Quảng trường ở hướng kia!\"\nBạn quay đầu nhìn hướng Ô Ryta chỉ, trong thâm cảnh, đường hẻm tối om. Rỗng rỗng, dị biến thể di chuyển quấn lấy nhau, kéo thế giới thực cũng vào hố sâu diệt vong."
  },
  Event_36880_Name = {
    Text = "Bóng tối vô hình"
  },
  Event_37983_ChoiceDesc1 = {
    Text = "[Nhận kinh phí] Bạn nhận được Arg1 dấu đen."
  },
  Event_37983_ChoiceDesc2 = {
    Text = "[nhận kinh phí] nhận Arg1 dấu đen[ExDesc1]."
  },
  Event_37983_Desc = {
    Text = "\"Không có chúa tể nào để mặc kệ một kẻ không rõ lai lịch, huống chi là một tu sĩ.\"\n Nữ hoàng ngồi trên ngai vàng cao cao, trong mắt bất chợt lóe lên một tia bạo ngược. \n \"Chứng minh rằng ngươi còn có ích lợi khác, nếu không...\"\n Ích lợi khác? Ngươi nhìn ra ngoài cửa sổ, nơi những cánh đồng hoang vu, một ý niệm bỗng nhiên nảy sinh: Có lẽ có thể vận dụng kiến thức kinh tế học đã học, giúp Vanda quản lý trang viên? \n Ngươi cố gắng tìm kiếm trong cái não khô cạn của mình — phải biết rằng ở Misaque, kinh tế học chỉ là một môn học phụ không đáng kể... \n Sự kiên nhẫn cạn kiệt. Nữ hoàng ngáp một cái. \n \"Thật đáng thất vọng. Buông —\"\n Chính vào khoảnh khắc con dao chém xuống, linh hồn của những vị tiền bối vĩ đại như Adam Smith, Malthus, David Ricardo đều hiện lên trong cái đầu nhỏ bé của ngươi. \n Phân công lao động! Thuế! Dân số, trời ơi dân số! \n Ngươi có lẽ, có thể nhớ lại."
  },
  Event_37983_Name = {
    Text = "Lệnh bí mật"
  },
  Event_37984_ChoiceDesc1 = {Text = "[đi]"},
  Event_37984_Desc = {
    Text = "Bạn cắn răng đưa ra chính lệnh. \nNữ hoàng lướt qua một cách qua loa, nở nụ cười lạnh lẽo: \n \"Nếu không có tác dụng, ngươi biết rõ điều gì sẽ xảy ra.\""
  },
  Event_37984_Name = {
    Text = "Lệnh bí mật"
  },
  Event_37985_ChoiceDesc1 = {
    Text = "[Đưa ra sắc lệnh] Nhận được bạc sáng tạo [(RelicConfig.Arg1)]"
  },
  Event_37985_ChoiceDesc2 = {
    Text = "[Đưa ra sắc lệnh] Nhận được vật bị nguyền rủa [(RelicConfig.Arg1)]"
  },
  Event_37985_ChoiceDesc3 = {
    Text = "[Đưa ra sắc lệnh] Nhận được vật tạo vàng[(RelicConfig.Arg1)]"
  },
  Event_37985_Desc = {
    Text = "\"Đã nhận tiền của tôi, thì phải làm việc hết mình cho tôi.\"\nNữ hoàng chống cằm, nhìn bạn một cách vô tư. \nDù có thừa nhận hay không, cô ấy thực sự tò mò về điều này. \n \"Vậy thì, hãy kể cho tôi nghe kế hoạch của bạn, nhà cải cách lớn.\""
  },
  Event_37985_Name = {
    Text = "Lệnh bí mật"
  },
  Event_38700_ChoiceDesc1 = {
    Text = "[Kết nối] phục hồi Arg2 điểm sức sống[ExDesc1]."
  },
  Event_38700_ChoiceDesc2 = {
    Text = "[Thiền định] Chọn 1 thân thể được đánh thức để tiến hành thức tỉnh."
  },
  Event_38700_ChoiceDesc3 = {
    Text = "[Trục xuất] Loại bỏ tối đa 3 thẻ triệu chứng, nhận Arg2 dấu đen."
  },
  Event_38700_Desc = {
    Text = "Bạn đang khám phá trong sương mù, đột nhiên, huy hiệu trường trên ngực bạn phát ra ánh sáng bạc yếu ớt. Ai đang gọi bạn từ bên kia thiết bị liên lạc?"
  },
  Event_38700_Name = {
    Text = "điểm liên lạc"
  },
  Event_38700_Tips3 = {
    Text = "Hiện tại không sở hữu thẻ triệu chứng"
  },
  Event_38707_ChoiceDesc1 = {
    Text = "[Giải trừ ảo ảnh] Triệu chứng nhiễm bệnh."
  },
  Event_38707_ChoiceDesc2 = {
    Text = "[hấp thụ ảo ảnh] mất Arg1 sức sống, nhận được Arg2 dấu đen"
  },
  Event_38707_ChoiceDesc3 = {Text = "[đi]"},
  Event_38707_Desc = {
    Text = "Những khuôn mặt mờ ảo đột nhiên xuất hiện, chúng vây quanh bạn và tuyệt vọng rên rỉ bằng những dây thanh âm không tồn tại."
  },
  Event_38707_Name = {Text = "ảo ảnh"},
  Event_38715_ChoiceDesc1 = {
    Text = "[Đưa ra sắc lệnh] Nhận được sáng tạo bạc \"(RelicConfig.Arg1)\"\"(RelicConfig.Arg2)\""
  },
  Event_38715_ChoiceDesc2 = {
    Text = "[Đưa ra sắc lệnh] Nhận được vật bị nguyền rủa [(RelicConfig.Arg1)]"
  },
  Event_38715_ChoiceDesc3 = {
    Text = "[Đưa ra sắc lệnh] Nhận được vật tạo vàng[(RelicConfig.Arg1)]"
  },
  Event_38715_Desc = {
    Text = "\"Đã nhận tiền của tôi, thì phải làm việc hết mình cho tôi.\"\nNữ hoàng chống cằm, nhìn bạn một cách vô tư. \nDù có thừa nhận hay không, cô ấy thực sự tò mò về điều này. \n \"Vậy thì, hãy kể cho tôi nghe kế hoạch của bạn, nhà cải cách lớn.\""
  },
  Event_38715_Name = {
    Text = "Lệnh bí mật"
  },
  Event_40452_ChoiceDesc1 = {
    Text = "[Hỏi về Danh tính] Chọn 1 trong 3 thẻ lệnh nhận được Khắc ấn: [(EnchantConfig.Arg1)]"
  },
  Event_40452_ChoiceDesc2 = {
    Text = "[Rời đi] ngẫu nhiên 3 thẻ lệnh nhận được khắcăng: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_40452_Desc = {
    Text = "Ba hồn ma chặn đường tiến lên. \n Họ tụ tập quanh bàn cược, tập trung toàn bộ sự chú ý vào động tĩnh của xúc xắc. \n \"Gừ gừ, gừ gừ.\"\n Xúc xắc được ném lên và rơi xuống vô số lần. \n Đây là một cuộc cờ bạc không bao giờ kết thúc."
  },
  Event_40452_Name = {
    Text = "Cuộc cờ bạc vô tận"
  },
  Event_40453_ChoiceDesc1 = {Text = "[đi]"},
  Event_40453_Desc = {
    Text = "\"Xin chào, chúng tôi lần lượt là chồng đầu tiên, thứ hai và thứ ba của Vanda.\"\n \"Gì vậy, bạn hỏi chồng thứ tư đang ở đâu?\nỪ... nói thật, John hơi thiếu cảm giác hài hước, nên đã bị bà chủ biến thành người hầu mù.\"\n \"Chúng tôi thực sự tiếc khi mất anh ấy. Tất nhiên, chỉ một chút xíu.\""
  },
  Event_40453_Name = {
    Text = "Cuộc cờ bạc vô tận"
  },
  Event_40454_ChoiceDesc1 = {
    Text = "[với nó bắt tay] ngẫu nhiên thức tỉnh một thân thể được đánh thức, lây nhiễm [(Skill.Arg1)]"
  },
  Event_40454_ChoiceDesc2 = {
    Text = "[rời đi] nhận được 1 trong 3 khắcăng"
  },
  Event_40454_Desc = {
    Text = "Khi đi ngang qua nhà giam, một bàn tay thò ra từ bên trong. \n \"Đừng rời xa tôi, Lìbèikǎ...\"\nGiọng nói già nua và khô khan, giống như một cái bễ gió cũ kỹ."
  },
  Event_40454_Name = {Text = "Tù nhân"},
  Event_40455_ChoiceDesc1 = {Text = "[đi]"},
  Event_40455_Desc = {
    Text = "Cảm giác dính dấp truyền từ lòng bàn tay — là dung dịch ăn mòn. \nChủ nhân của tiếng động đã biến mất từ bao giờ, ẩn nấp trong bóng tối u ám."
  },
  Event_40455_Name = {Text = "Tù nhân"},
  Event_40456_ChoiceDesc1 = {Text = "[đi]"},
  Event_40456_Desc = {
    Text = "Bạn rời đi một cách không bận tâm, vì vậy đã bỏ lỡ những quá khứ đầy kịch tính phía sau tờ giấy viết thư. \n Nhưng điều đó có ý nghĩa gì chứ? \n Biển cả bao la, bình minh và hoàng hôn, sa mạc xích đạo... \n Bạn sẽ gặp gỡ nhiều hơn, cũng sẽ bỏ lỡ nhiều hơn."
  },
  Event_40456_Name = {
    Text = "Đến người vợ yêu dấu"
  },
  Event_40457_ChoiceDesc1 = {Text = "[đi]"},
  Event_40457_Desc = {
    Text = "Trong một ý nghĩa nào đó, bạn và tên tù nhân này không khác gì nhau. \nBây giờ chưa phải lúc đánh động. \nBạn lờ đi lời van xin, quay lưng bước đi."
  },
  Event_40457_Name = {Text = "Tù nhân"},
  Event_40458_ChoiceDesc1 = {
    Text = "[ xé thư] chọn 1 sáng tạo biến thành vật bị nguyền rủa[(RelicConfig.Arg1)]"
  },
  Event_40458_ChoiceDesc2 = {
    Text = "[bỏ qua thư] nhận được bạc tạo vật \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_40458_ChoiceDesc3 = {
    Text = "[Trả lời thư] nhận được 25 dấu đen"
  },
  Event_40458_Desc = {
    Text = "Ⅰ.Thư tín  John Cambrian gửi Vanda (trước Aluvi @2 năm) \n\nChồng có quyền xử lý vợ của mình, ít nhất là ở Cambrian. \nNhưng rõ ràng tôi đã đánh giá thấp mức độ điên rồ của bạn. Bây giờ mắt tôi gần như hoàn toàn mù, và bốn chi của tôi cũng sắp bị chặt đứt. \nCon gái của quỷ. Con gái của quỷ… không, bạn chính là quỷ. \nTôi nguyền rủa bạn @1 nguyền rủa bạn @2 nguyền rủa bạn nguyền rủa bạn…"
  },
  Event_40458_Name = {
    Text = "Đến người vợ yêu dấu"
  },
  Event_40459_ChoiceDesc1 = {Text = "[đi]"},
  Event_40459_Desc = {
    Text = "Bạn đã sử dụng phương pháp đơn giản nhất để giải trừ lời nguyền. \n Không có gì xảy ra. Tấm giấy rơi xuống đất một cách vô hồn. \n Bạn nhún vai rồi rời đi, nhưng trong lòng vẫn cảm thấy có điều gì đó không ổn."
  },
  Event_40459_Name = {
    Text = "Đến người vợ yêu dấu"
  },
  Event_40460_ChoiceDesc1 = {Text = "[đi]"},
  Event_40460_Desc = {
    Text = "Bạn đi qua bàn cờ bạc mà không để tâm đến bất cứ điều gì. \nTrước khi rời đi, các hồn ma cùng nhau lên tiếng: \n \"Xin hãy thay chúng tôi gửi lời chào đến người vợ cũ chung của chúng tôi —— Bà Vanda.\""
  },
  Event_40460_Name = {
    Text = "Cuộc cờ bạc vô tận"
  },
  Event_40461_ChoiceDesc1 = {Text = "[đi]"},
  Event_40461_Desc = {
    Text = "Bạn viết trả lời một cách cẩn thận ở cuối bức thư: \n \"Lời nguyền đã nhận được, chúc mọi sự an lành.\"\nVào khoảnh khắc bạn hoàn thành nét viết cuối cùng, bức thư bốc cháy với ngọn lửa xanh giận dữ.\nBạn thu được tro tàn."
  },
  Event_40461_Name = {
    Text = "Đến người vợ yêu dấu"
  },
  Event_44187_ChoiceDesc1 = {
    Text = "[Đối mặt với bóng tối][ExDesc1][ExDesc2]"
  },
  Event_44187_ChoiceDesc2 = {
    Text = "[Đối mặt với bóng tối][ExDesc1][ExDesc2]"
  },
  Event_44187_ChoiceDesc3 = {
    Text = "[tránh bóng tối] nhận được vật sáng tạo vàng ngẫu nhiên"
  },
  Event_44187_Desc = {
    Text = "Linh hồn trước mắt bạn tối tăm và ô uế — ánh sáng và bóng tối tồn tại đồng thời trong nó. Chúng tranh giành sự thống trị, linh hồn thì rơi vào mê mang. \n「Tôi rất đồng cảm với họ, những người đáng thương đã mất tất cả, nhưng thế giới này không phải vốn dĩ như vậy sao? \n「Có người được, có người mất. \n「Chẳng lẽ để người khác hạnh phúc, tôi phải từ bỏ niềm vui của mình sao"
  },
  Event_44187_Name = {
    Text = "Tối tăm nội tâm"
  },
  Event_44188_ChoiceDesc1 = {Text = "[đi]"},
  Event_44188_Desc = {
    Text = "\"Đây là tội lỗi của tôi, là gánh nặng của tôi. Tôi phải làm sao để giải thoát linh hồn mâu thuẫn của tôi?\""
  },
  Event_44188_Name = {
    Text = "Tối tăm nội tâm"
  },
  Event_44299_ChoiceDesc1 = {
    Text = "[Cầu xin Giáo chủ] Tẩy sạch sáng tạo có tội, nếu không có sáng tạo có tội, nhận được vật tạo vàng ngẫu nhiên."
  },
  Event_44299_Desc = {
    Text = "\"Tôi đã lừa dối, gạt gẫm, để có được cuộc sống mà tôi muốn — tiền bạc trở thành con số, sơn hào hải vị trở thành bữa ăn hàng ngày, trong kinh doanh tôi nói một không hai, trong chính trị tôi cứng rắn quyết đoán. Nhưng tại sao, tại sao tôi không thể quên những người đó, những người đã bị tôi cướp đi tất cả? Tại sao tôi không thể quên sự tuyệt vọng trên khuôn mặt họ? \n\" Rượu chỉ mang lại sự trốn chạy tạm thời. Linh hồn tôi đang tự xé nát mình, nỗi đau gần như nhấn chìm tôi. \n \"Tôi rốt cuộc nên làm gì?\""
  },
  Event_44299_Name = {
    Text = "Tội lỗi và Sự tha thứ"
  },
  Event_44301_ChoiceDesc1 = {Text = "[đi]"},
  Event_44301_Desc = {
    Text = "\"Bạn đang đi trên con đường khổ nạn, bạn đã lệch khỏi vinh quang của Cha Thần. \n\" Hãy quay lại, con chiên lạc lối, vâng theo lời dạy của Cha Thần, bước đi trên con đường ngay chính.\""
  },
  Event_44301_Name = {
    Text = "Tội lỗi và Sự tha thứ"
  },
  Event_44395_ChoiceDesc1 = {
    Text = "[Cầu lấy vật ngoại] Chủ giáo nhận lấy 1 triệu chứng từ bạn, bạn nhận được Arg1 dấu đen. Nếu không có triệu chứng, ngay lập tức nhận được dấu đen"
  },
  Event_44395_ChoiceDesc2 = {
    Text = "[Cầu lấy máu tươi] Chủ giáo chịu 2 triệu chứng của bạn, bạn nhận được khắcăng [(EnchantConfig.Arg1)]."
  },
  Event_44395_ChoiceDesc3 = {
    Text = "[Cầu thêm nhiều] Giám mục chịu nhiều triệu chứng hơn (ít nhất 4 lá)"
  },
  Event_44395_Desc = {
    Text = "Hồn ma hư ảo ngưng tụ thành hình dạng mờ ảo, nó quỳ trước giám mục, trưng ra thân thể tàn tạ và trái tim đen tối còn sót lại. \n \"Ngài đã cho tôi sự dẫn dắt, cho tôi sự tha thứ, cho tôi sự cứu rỗi, nhưng thưa ngài giám mục từ bi, điều đó vẫn chưa đủ. \n\" Tôi nghèo khó, bệnh tật hành hạ. Tôi đang ở bên bờ vực sinh tử, và ngài là hy vọng cứu rỗi duy nhất của tôi. Cứu tôi đi, thưa ngài giám mục, hãy để tôi không còn phải chịu đau khổ nữa.\""
  },
  Event_44395_Name = {
    Text = "Lời chúc phúc của Giám mục"
  },
  Event_44396_ChoiceDesc1 = {
    Text = "[hành lễ rồi rời đi]"
  },
  Event_44396_Desc = {
    Text = "Giám mục tháo chiếc nhẫn, cởi chiếc ghim ngực. Những viên ngọc xanh đại diện cho Cha Thượng được đặt lần lượt vào tay linh hồn, giám mục cúi người, nắm lấy đôi tay của linh hồn đáng thương. \n \"Hãy lấy đi vàng bạc trên người tôi, hãy lấy đi tất cả tài sản của tôi — miễn là đó là những gì bạn cần. Tôi có giáo huấn của Cha Thượng là đủ để sống.\""
  },
  Event_44396_Name = {
    Text = "Lời chúc phúc của Giám mục"
  },
  Event_44400_ChoiceDesc1 = {
    Text = "[chìm đắm trong đó] bị nhiễm [(Skill.Arg1)], thức tỉnh thân thể ngẫu nhiên"
  },
  Event_44400_ChoiceDesc2 = {Text = "[bỏ qua]"},
  Event_44400_Desc = {
    Text = "Linh hồn lạc lối không muốn từ bỏ bóng tối. \nBạn hiểu rõ điều gì đang chờ nó. Một cuộc đời phi lý sắp diễn ra, và bạn là khán giả duy nhất."
  },
  Event_44400_Name = {
    Text = "Tối tăm nội tâm"
  },
  Event_44401_ChoiceDesc1 = {
    Text = "[mắt tinh tay nhanh] nhận được Arg1 dấu đen"
  },
  Event_44401_ChoiceDesc2 = {
    Text = "[Sự càn quấy] nhận được 3 lựa chọn đá khắc cao cấp, nhiễm [(Skill.Arg1)]."
  },
  Event_44401_Desc = {
    Text = "Dấu ấn đen được phát hiện trong thâm cảnh, có thể hiến tế cho dấu vết tan chảy để đổi lấy hình chiếu tinh thần của các sáng tạo. Sau khi rời khỏi khu vực hiện tại, nó sẽ nhanh chóng biến thành bùn đen."
  },
  Event_44401_Name = {Text = "dấu đen"},
  Event_44407_ChoiceDesc1 = {
    Text = "[Giải trừ ảo ảnh] Triệu chứng nhiễm bệnh."
  },
  Event_44407_ChoiceDesc2 = {
    Text = "[Ôm Ảo Giác] nhận 2 lá triệu chứng ngẫu nhiên, nhận Arg1 dấu đen."
  },
  Event_44407_ChoiceDesc3 = {Text = "[đi]"},
  Event_44407_Desc = {
    Text = "Những khuôn mặt mờ ảo đột nhiên xuất hiện, chúng vây quanh bạn và tuyệt vọng rên rỉ bằng những dây thanh âm không tồn tại."
  },
  Event_44407_Name = {Text = "ảo ảnh"},
  Event_44445_ChoiceDesc1 = {
    Text = "[Rời đi] tìm đèn pha"
  },
  Event_44445_ChoiceDesc2 = {
    Text = "[xâm nhập vào sương mù] mất Arg2 điểm sức sống"
  },
  Event_44445_ChoiceDesc3 = {
    Text = "[Bỏ qua vật ngoài] trừ 5 dấu đen, nhận được 1 thẻ [cảm hứng]"
  },
  Event_44445_Desc = {
    Text = "Phía trước là một vùng sương đen dày đặc, khinh suất tiến vào sẽ mang lại thảm họa. \nCó lẽ bạn nên tìm \"đèn pha\"để xua tan sương mù."
  },
  Event_44445_Name = {
    Text = "không biết"
  },
  Event_44469_ChoiceDesc1 = {
    Text = "[Cầu lấy xương thịt] Chủ giáo chịu 4 lá triệu chứng của bạn, bạn nhận được chọn 1 trong 3 vật tạo vàng+."
  },
  Event_44469_ChoiceDesc2 = {
    Text = "[Cầu lấy phúc lành] Chủ giáo nhận lấy 6 triệu chứng từ bạn, bạn nhận được 3 chọn 1 bàn lắc thời linh."
  },
  Event_44469_ChoiceDesc3 = {
    Text = "[trở về]"
  },
  Event_44469_Desc = {
    Text = "Hồn ma hư ảo ngưng tụ thành hình dạng mờ ảo, nó quỳ trước giám mục, trưng ra thân thể tàn tạ và trái tim đen tối còn sót lại. \n \"Ngài đã cho tôi sự dẫn dắt, cho tôi sự tha thứ, cho tôi sự cứu rỗi, nhưng thưa ngài giám mục từ bi, điều đó vẫn chưa đủ. \n\" Tôi nghèo khó, bệnh tật hành hạ. Tôi đang ở bên bờ vực sinh tử, và ngài là hy vọng cứu rỗi duy nhất của tôi. Cứu tôi đi, thưa ngài giám mục, hãy để tôi không còn phải chịu đau khổ nữa.\""
  },
  Event_44469_Name = {
    Text = "Lời chúc phúc của Giám mục"
  },
  Event_44474_ChoiceDesc1 = {
    Text = "[Yêu cầu] Nhận phước lành của Giám mục"
  },
  Event_44474_ChoiceDesc2 = {
    Text = "[Yêu cầu] Nhận phước lành của Giám mục"
  },
  Event_44474_ChoiceDesc3 = {Text = "[đi]"},
  Event_44474_Desc = {
    Text = "\"Đây là tội lỗi của tôi, là gánh nặng của tôi. Tôi phải làm sao để giải thoát linh hồn mâu thuẫn của tôi?\""
  },
  Event_44474_Name = {
    Text = "Tối tăm nội tâm"
  },
  Event_44911_ChoiceDesc1 = {Text = "[đi]"},
  Event_44911_Desc = {
    Text = "\"tất cả, tất cả... đúng rồi, tôi muốn tất cả...!\"\n Linh hồn duỗi tay ra, vô ích chộp lấy trong không trung. \n Nó đã nhận được điều gì đó, nhưng lại không nhận được gì cả."
  },
  Event_44911_Name = {
    Text = "Bạn đã nhận được gì"
  },
  Event_44913_ChoiceDesc1 = {Text = "[đi]"},
  Event_44913_Desc = {
    Text = "\"thì chỉ cần cái quan trọng nhất, quan trọng nhất...\"\nlinh hồn cúi xuống, từ hư vô lấy ra một mong muốn sáng rực và đặt nó vào lòng bàn tay."
  },
  Event_44913_Name = {
    Text = "Bạn đã nhận được gì"
  },
  Event_44916_ChoiceDesc1 = {
    Text = "[Nắm lấy tất cả] Chọn 1 trong 3 thẻ lệnh nhận được Khắc ấn: [(EnchantConfig.Arg1)]"
  },
  Event_44916_ChoiceDesc2 = {
    Text = "[Học cách buông bỏ] Ngẫu nhiên 3 thẻ lệnh nhận được khắcăng: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_44916_Desc = {
    Text = "Linh hồn mờ nhạt chìm trong đau khổ. \nNó loanh quanh tại chỗ, bối rối trước mọi lựa chọn và hậu quả có thể xảy ra. \n \"Tôi nên chọn gì?\" nó thì thầm,\"Tôi phải làm gì?\"\n \"Làm thế nào để tôi có thể có tất cả?\""
  },
  Event_44916_Name = {
    Text = "Bạn đã nhận được gì"
  },
  Event_44919_ChoiceDesc1 = {
    Text = "[Tự kiểm tra bản thân] Ngẫu nhiên thức tỉnh một thân thể được đánh thức, bị ảnh hưởng bởi [(Skill.Arg1)]"
  },
  Event_44919_ChoiceDesc2 = {
    Text = "[xem từ bên ngoài] nhận được một trong ba khắcăng để lựa chọn"
  },
  Event_44919_Desc = {
    Text = "Linh hồn trôi nổi rơi vào tình thế khó xử. \nNó dừng bước, do dự giữa những dục vọng. \n \"Tôi phải chọn như thế nào?\" nó thì thầm, \"Tôi nên làm gì?\"\n \"Cuối cùng, điều nào mới là điều tôi thực sự mong muốn?\""
  },
  Event_44919_Name = {
    Text = "Bạn muốn gì"
  },
  Event_44920_ChoiceDesc1 = {Text = "[đi]"},
  Event_44920_Desc = {
    Text = "\"Bạn đúng, tôi phải xem, tôi phải xem...\"\nNó cúi đầu, hai tay thò vào ngực, từ đó lấy ra một trái tim hư ảo: một nửa đen như mực, một nửa sáng như sao."
  },
  Event_44920_Name = {
    Text = "Bạn muốn gì"
  },
  Event_44921_ChoiceDesc1 = {Text = "[đi]"},
  Event_44921_Desc = {
    Text = "\"Cũng vậy, cũng vậy... người ta nói người khác có thể làm gương... tôi phải xem xem...\"\nNó tiến đến trước mặt bạn, dùng khuôn mặt không rõ ràng nhìn bạn.\n \"Tại sao bạn không cảm thấy khó xử? Thật sự rất ngưỡng mộ, vô cùng ngưỡng mộ...\""
  },
  Event_44921_Name = {
    Text = "Bạn muốn gì"
  },
  Event_44998_ChoiceDesc1 = {Text = "[đi]"},
  Event_44998_Desc = {
    Text = "\"Họ nói rằng, nỗi khổ hiện tại chỉ là tạm thời, sau khi chết chúng ta sẽ tự nhiên được hưởng niềm vui vĩnh cửu trong vòng tay của Cha Thiên Chúa. \n\" Tôi không muốn chờ đến khi chết.\"\nBóng tối tham lam tiêu thụ mọi thứ, linh hồn trở nên u ám, gần như hòa làm một với bóng tối xung quanh. \nBạn muốn làm gì đó, nhưng lại bất lực."
  },
  Event_44998_Name = {
    Text = "Tối tăm nội tâm"
  },
  Event_45000_ChoiceDesc1 = {
    Text = "[hành lễ rồi rời đi]"
  },
  Event_45000_Desc = {
    Text = "Giám mục dùng lưỡi dao cắt lòng bàn tay, những giọt máu rơi xuống tấm bảng đá hóa thành ánh sáng xanh chữa lành, bổ sung phần linh hồn bị thiếu. \n \"Hãy lấy máu của ta, lấp đầy sức sống của ngươi —— nếu đó là điều ngươi cần. Đây chính là việc Cha Thần mong ta thực hiện.\""
  },
  Event_45000_Name = {
    Text = "Lời chúc phúc của Giám mục"
  },
  Event_45001_ChoiceDesc1 = {
    Text = "[hành lễ rồi rời đi]"
  },
  Event_45001_Desc = {
    Text = "Giám mục lấy ra linh hồn của mình từ sâu trong lồng ngực. Những điểm sáng ấm áp hòa vào bảng đá, biến thành ánh sáng xanh chữa lành, lấp đầy mọi vết nứt trên linh hồn. \n \"Hãy nhận lấy, đây là món quà của Cha Thần, là bằng chứng của Tình Yêu của Ngài. Nguyện cho thân thể bạn khỏe mạnh, linh hồn trọn vẹn, không còn phải chịu bất kỳ đau khổ nào.\""
  },
  Event_45001_Name = {
    Text = "Lời chúc phúc của Giám mục"
  },
  Event_45002_ChoiceDesc1 = {Text = "[đi]"},
  Event_45002_Desc = {
    Text = "Bạn đi về phía những khuôn mặt đó, khi mở mắt ra lần nữa, trước mắt đã chìm vào bóng tối. Chỉ có tiếng cười không rõ nguồn gốc vang vọng xung quanh."
  },
  Event_45002_Name = {Text = "ảo ảnh"},
  Event_45036_ChoiceDesc1 = {
    Text = "[Xóa tất cả các sáng tạo]"
  },
  Event_45036_Desc = {
    Text = "\"Đây là tội lỗi của tôi, là gánh nặng của tôi. Tôi phải làm sao để giải thoát linh hồn mâu thuẫn của tôi?\""
  },
  Event_45036_Name = {
    Text = "Tối tăm nội tâm"
  },
  Event_45196_ChoiceDesc1 = {
    Text = "[hành lễ rồi rời đi]"
  },
  Event_45196_Desc = {
    Text = "Giám mục dùng lưỡi dao sắc bén cắt xương thịt, xương trắng bệch và thịt đỏ tươi hòa vào bảng đá, biến thành ánh sáng xanh chữa lành, vá lại những xương đã gãy nát của linh hồn. \n \"Lấy xương thịt của ta, bù đắp cho thân thể thiếu hụt của ngươi — chỉ cần đó là điều ngươi cần. Đó chính là điều Cha Thượng mong muốn ta làm.\""
  },
  Event_45196_Name = {
    Text = "Lời chúc phúc của Giám mục"
  },
  Event_46144_ChoiceDesc1 = {
    Text = "[rời đi] nhận được 3 chọn 1 vật phẩm bạc, nhiễm phải 「(Skill.Arg1)」"
  },
  Event_46144_Desc = {
    Text = "Hình dáng mờ ảo dần dần rõ ràng, đó không phải là thân thể bị ăn mòn, cũng không phải là thảm họa, mà là Clementine không có cánh, vẻ mặt bình thường. \n「Thật trùng hợp, bạn cũng đến ngắm trăng sao?」Cô ấy cười nói, nhưng bạn cảm thấy một cơn chóng mặt, 「Đêm sương mù dày đặc, vẫn cần phải cẩn thận hơn đấy.」\n「Những tiểu quỷ ở đây, không mấy khi ngoan ngoãn đâu.」"
  },
  Event_46144_Name = {
    Text = "Hình bóng trong sương mù"
  },
  Event_46145_ChoiceDesc1 = {
    Text = "[đi] nhận được quyền chọn 1 trong 3 vật tạo vàng, nhiễm [(Skill.Arg1)]"
  },
  Event_46145_Desc = {
    Text = "Bạn không động thanh sắc. Một quý bà bỗng nhiên xông lên sân khấu. \nCô ta điên rồ tách miệng cậu bé ra. Sau đó, cô đâm mạnh cây gậy trong tay vào trong. \n \"Nói đi, nói cho tôi nghe.\"\nMáu đen chảy ra từ miệng cậu bé. Cậu ấy lèm nhèm đọc tiếp. \n \"Bài hát dâng tặng mẹ...\""
  },
  Event_46145_Name = {
    Text = "Lễ Kết Thúc Ⅲ"
  },
  Event_47309_ChoiceDesc1 = {Text = "[đi]"},
  Event_47309_Desc = {
    Text = "Đến ngày đó, Chúa sẽ dùng lưỡi gươm mạnh mẽ và cứng rắn của Người để trừng phạt người Phi-li-tin, \n vì tội ác giết chóc mà họ đã \"phạm phải\". \n Gì, bạn nói rằng điều này không công bằng? \n Không, đây mới là số phận của loài thú săn mồi."
  },
  Event_47309_Name = {
    Text = "Bài hát thủy thủ"
  },
  Event_47310_ChoiceDesc1 = {
    Text = "[Tiếp tục nghe] nhận được vật bị nguyền rủa \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_47310_ChoiceDesc2 = {
    Text = "[Rời đi] 1 thẻ lệnh ngẫu nhiên nhận được Khắc ấn: [(EnchantConfig.Arg1)]"
  },
  Event_47310_Desc = {
    Text = "Chúa nói: Hãy gọi hắn là Phi-lí-tin. \n Hãy để hắn gánh vác trách nhiệm giết chóc, để hắn mang theo lời nguyền tham lam. \n Hãy để con đường hắn đi tỏa sáng, khiến người ta nghĩ đến vực thẳm như tóc bạc. \n Trong biển cả mênh mông, không có con cá mập khổng lồ nào vĩ đại hơn thế. \n Hãy để hắn bị tất cả sinh linh sợ hãi, tôn kính, \n cho đến khi thời khắc xét xử đến."
  },
  Event_47310_Name = {
    Text = "Bài hát thủy thủ"
  },
  Event_47311_ChoiceDesc1 = {
    Text = "[đi khỏi] nhiễm [(Skill.Arg1)]"
  },
  Event_47311_ChoiceDesc2 = {
    Text = "[đi khỏi] nhiễm [(Skill.Arg1)]"
  },
  Event_47311_ChoiceDesc3 = {
    Text = "[đi khỏi] nhiễm [(Skill.Arg1)]"
  },
  Event_47311_Desc = {
    Text = "Cậu bé là một nô lệ hèn mọn. \n Chủ nhân đối xử với cậu như cha con ruột, nhưng lại bị đâm chết trên giường. \n 「Tôi yêu ngài, cha ạ. Tôi chỉ không muốn làm nô lệ nữa.」 \n Sau đó, cậu bé đứng trước mộ cha, nhớ lại lời của vị linh mục: \n <Small:Đừng rời bỏ quê hương đã sinh ra và nuôi dưỡng bạn. \n Khi đó, đôi tay bạn sẽ dính đầy máu, bạn sẽ chết trong sự mất hết danh dự. \n Chó hoang, kền kền và cá biển đều ghét bỏ bạn.> \n Cậu bé tên Igrun cuối cùng vẫn rời đi. \n Anh ta sẽ viết nên câu chuyện tai tiếng của mình."
  },
  Event_47311_Name = {
    Text = "Chàng trai trong thùng gỗ"
  },
  Event_47312_ChoiceDesc1 = {
    Text = "[Lật trang trước] nhận bạc sáng tạo [(RelicConfig.Arg1)], chọn nhiễm 1 lần triệu chứng"
  },
  Event_47312_ChoiceDesc2 = {
    Text = "[lật sang trang sau] chọn 1 thẻ lệnh từ 3 thẻ lệnh để nhận khắcăng:\"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_47312_ChoiceDesc3 = {
    Text = "[đánh bỏ] nhận được 25 dấu đen"
  },
  Event_47312_Desc = {
    Text = "Bạn nhặt được một cuốn sách được bọc bằng giấy sậy: \n……\nCậu bé trốn trong thùng gỗ, trôi dạt đến hòn đảo của người Phi-lí-tin. \nCậu ta yếu ớt, hạ lưu và tham vọng. \nKhi vinh quang của gã khổng lồ bất tử khiến mọi người tán thưởng, \n chỉ có cậu bé trốn trong bóng tối, không để ánh sáng đó lại gần mình nửa bước. \nSau đó, cậu được Goliath giao phó trọng trách. \nCòn lý do thì sao——"
  },
  Event_47312_Name = {
    Text = "Chàng trai trong thùng gỗ"
  },
  Event_47313_ChoiceDesc1 = {Text = "[đi]"},
  Event_47313_Desc = {
    Text = "Người khổng lồ tiếp tục nói: \n \"Tôi để anh ta ở bên cạnh tôi, vì anh ta vừa u uất, vừa hài hước. \nVà anh ta sẽ không bao giờ giết được tôi.\""
  },
  Event_47313_Name = {
    Text = "Chàng trai trong thùng gỗ"
  },
  Event_47314_ChoiceDesc1 = {Text = "[đi]"},
  Event_47314_Desc = {
    Text = "Bạn không nghe được phần sau, nhưng lời bài hát khiến bạn nhớ đến một bài hát khác: \n \"Con cá mập hiếm có này, giữa cuồng phong bão tố, \nĐại dương là nhà của nó. \nQuyền lực là lẽ phải, và nó chính là gã khổng lồ quyền lực, \nVua của biển cả vô biên.\""
  },
  Event_47314_Name = {
    Text = "Bài hát thủy thủ"
  },
  Event_47315_ChoiceDesc1 = {Text = "[đi]"},
  Event_47315_Desc = {
    Text = "Bây giờ không phải là thời điểm tốt để đọc sách. \n Bạn vội vàng ném cuốn sách sang một bên, không kịp nhìn thấy nội dung cuối cùng: \n …… \n Nguyên nhân khiến anh ta trốn trong bóng tối không phải vì ghen tị. \n Mà là vì sự sợ hãi thuần túy. \n Một khi đứng dưới ánh sáng, linh hồn hèn hạ sẽ bị hoàn toàn chôn vùi. \n Ngay cả tro tàn cũng sẽ không còn lại."
  },
  Event_47315_Name = {
    Text = "Chàng trai trong thùng gỗ"
  },
  Event_47463_ChoiceDesc1 = {
    Text = "[Nhập trạng thái thôi miên] Chỉ định một thân thể được đánh thức khiến tinh thần bị rối loạn phân ly, mất bốn thẻ lệnh ban đầu."
  },
  Event_47463_Desc = {
    Text = "Bác sĩ ngẩng đầu lên từ đống sách vở dày đặc: \n \"Bạn là một mẫu hiếm có, vì vậy tôi sẽ không thu phí của bạn. \nNhưng tôi cần một sự đền đáp khác: một lần thôi miên. \nĐây là một phương pháp chữa trị mới, nó mang lại ý thức hoàn toàn trong suốt và không giấu diếm. \nBạn có muốn thử xem sao không?\""
  },
  Event_47463_Name = {
    Text = "\"rắn thôi miên\""
  },
  Event_47464_ChoiceDesc1 = {
    Text = "[ký ức lấp lánh][ExDesc1][ExDesc2]"
  },
  Event_47464_ChoiceDesc2 = {
    Text = "[Ký ức mờ nhạt] Chuyển tất cả khắcăng Hợp Tấu trong bộ bài thành khắcăng Hợp Tấu Nâng Cao"
  },
  Event_47464_Desc = {
    Text = "Cô ấy lang thang trên bãi biển của biển ý thức. \n Váy của sóng biển liếm chân cô, mang những ký ức rải rác về bờ. \n Chúng có cái lấp lánh, có cái mờ nhạt, và có cái có mùi như mùa mưa của Lentiennam. \n Bạn chọn nhặt mảnh ký ức nào? Cô ấy lang thang trên bãi biển của biển ý thức."
  },
  Event_47464_Name = {
    Text = "\"sự hợp nhất chủ thể\""
  },
  Event_47465_ChoiceDesc1 = {
    Text = "[Từ chối thử] 1 thẻ lệnh ngẫu nhiên nhận Khắc ấn: [(EnchantConfig.Arg1)]"
  },
  Event_47465_ChoiceDesc2 = {
    Text = "[đập vỡ dung dịch] thanh tẩy sáng tạo tội lỗi"
  },
  Event_47465_ChoiceDesc3 = {
    Text = "[Nhận thí nghiệm] nhận được 1 bàn lắc thời linh [(RelicConfig.Arg1)]"
  },
  Event_47465_Desc = {
    Text = "Bác sĩ lắc lư dung dịch màu lục tươi, hào hứng nói với cô ấy: \n \"Uống một ngụm, bạn sẽ có thể bước vào giấc mơ tỉnh táo. \nNó là sự tái hiện niệm lực từ tiềm thức tập thể. \nGiờ đây, bạn sẽ chia sẻ cùng biển ý thức với hàng ngàn sinh linh, \nBạn có muốn thử không?\""
  },
  Event_47465_Name = {
    Text = "\"giấc mơ ý thức\""
  },
  Event_47466_ChoiceDesc1 = {
    Text = "[Phản hồi âm thanh] Nhận được 1 thẻ lệnh của thân thể được thức tỉnh rối loạn phân ly"
  },
  Event_47466_Desc = {
    Text = "Thịt da là nhà tù, giam cầm những nhân cách bị phân mảnh. \n Ngục giam mang tên \"24\" hiện đang chật kín người. \n \"Đừng ngủ say, đừng bình thản.\"\n Trong bóng tối, có một giọng nói thì thầm."
  },
  Event_47466_Name = {
    Text = "\"tự tính giác tri\""
  },
  Event_47848_ChoiceDesc1 = {
    Text = "[đóng mắt lại] nhận được 1 trong 3 vật tạo vàng"
  },
  Event_47848_ChoiceDesc2 = {
    Text = "[Nhìn lén] Chọn 2 thân thể được đánh thức và giảm 1 điểm tiêu thụ sức tính toán của thẻ thức tỉnh."
  },
  Event_47848_ChoiceDesc3 = {
    Text = "[mở hai mắt] nhận được các tạo vật bằng bạc \"(RelicConfig.Arg1)\", \"(RelicConfig.Arg2)\", \"(RelicConfig.Arg3)\""
  },
  Event_47848_Desc = {
    Text = "Trước khi bước vào trạng thái thôi miên, bác sĩ nói: \n \"Không được mở mắt nếu không có sự cho phép của tôi.\"\nVì vậy, cô ấy khép chặt đôi mắt, hít vào... thở ra...\nTrong trạng thái nửa tỉnh nửa mê, cô dường như nghe thấy tiếng \"xì xì\" của khí.\nSau đó, cô ấy cảm nhận được ánh nhìn lạnh lẽo bao quanh mình ——\nCó thứ gì đó đang nhìn cô.\nCó nên mở mắt ra không?"
  },
  Event_47848_Name = {
    Text = "\"rắn thôi miên\""
  },
  Event_47876_ChoiceDesc1 = {Text = "[đi]"},
  Event_47876_Desc = {
    Text = "Cô cúi người nhặt những ký ức lấp lánh. \nMột, hai… vô số niềm vui ùa đến, \nCô dang rộng đôi tay, quay vòng quanh chúng trong niềm vui."
  },
  Event_47876_Name = {
    Text = "\"sự hợp nhất chủ thể\""
  },
  Event_47877_ChoiceDesc1 = {Text = "[đi]"},
  Event_47877_Desc = {
    Text = "Cô ấy cúi xuống nhặt những ký ức mờ nhạt.\nMột cái, hai cái… vô số điều tầm thường ùa đến,\nCô ấy dang rộng vòng tay, ôm tất cả chúng vào lòng."
  },
  Event_47877_Name = {
    Text = "\"sự hợp nhất chủ thể\""
  },
  Event_47878_ChoiceDesc1 = {Text = "[đi]"},
  Event_47878_Desc = {
    Text = "Bạn từ chối trở thành nạn nhân của những dung dịch kỳ quái này. \nBác sĩ dường như thất vọng, nhưng ông không ép buộc bạn. \n \"Tôi tha thứ cho sự hèn nhát và tầm nhìn hạn hẹp của con người.\""
  },
  Event_47878_Name = {
    Text = "\"giấc mơ ý thức\""
  },
  Event_47879_ChoiceDesc1 = {Text = "[đi]"},
  Event_47879_Desc = {
    Text = "Rầm! Bạn đập vỡ chai. \nDung dịch màu xanh lá nhanh chóng ăn mòn sàn nhà. \n \"Tốt lắm, sự bốc đồng ngu ngốc. Nhưng tôi hy vọng sẽ không có lần sau. \nNếu không, tôi sẽ buồn rơi lệ.\""
  },
  Event_47879_Name = {
    Text = "\"giấc mơ ý thức\""
  },
  Event_47880_ChoiceDesc1 = {Text = "[đi]"},
  Event_47880_Desc = {
    Text = "Bạn uống một ngụm ừng ực. \nỨng ực ực... Não và cổ họng của bạn đồng thời bùng lên vô số bong bóng. \nGiống như những pháo hoa nhỏ bé lách tách nổ. \n \"Ngợi khen bạn, con người dũng cảm. Bạn sẽ có cơ hội tiếp xúc với sự vô hạn. \nCòn tôi, sẽ chứng kiến sự vô hạn.\""
  },
  Event_47880_Name = {
    Text = "\"giấc mơ ý thức\""
  },
  Event_47881_ChoiceDesc1 = {Text = "[đi]"},
  Event_47881_Desc = {
    Text = "Cô mở to đôi mắt và nói: \n \"Đúng vậy, tất cả những điều này đều không đúng. \nNên rơi nước mắt, nên chống lại.\"\nTrong bóng tối vang lên tiếng động sột soạt, cô nhận được sự đáp lại đầy thiện chí."
  },
  Event_47881_Name = {
    Text = "\"tự tính giác tri\""
  },
  Event_47900_ChoiceDesc1 = {
    Text = "[thấy rắn] nhận được vật tạo vàng + [(RelicConfig.Arg1)]"
  },
  Event_47900_ChoiceDesc2 = {
    Text = "[thấy bạn] nhận được sáng tạo có tội lỗi [(RelicConfig.Arg1)]"
  },
  Event_47900_Desc = {
    Text = "Bụp. \nMột tiếng vỗ tay nhẹ nhàng kéo cô trở lại thực tại. \nBác sĩ không biết từ lúc nào đã đưa mặt lại gần, đôi mắt màu vàng coban híp lại vì phấn khích. \n \"Lúc nãy bạn đã thấy gì?\""
  },
  Event_47900_Name = {
    Text = "\"rắn thôi miên\""
  },
  Event_47901_ChoiceDesc1 = {Text = "[đi]"},
  Event_47901_Desc = {
    Text = "Cô ấy mở mắt. \n Trong ánh sáng mờ ảo, cô dường như thấy một con rắn khổng lồ trắng yên tĩnh cuộn tròn và từ từ ngọ nguậy trong bóng tối. \n Ồ, còn đôi mắt của nó— \n đó là màu vàng tinh khiết không lẫn tạp chất. \n Không buồn không vui, không mang theo bất kỳ phán xét nào, \n đủ để đánh thức con chuột ngủ từ cơn ác mộng của mùa hè."
  },
  Event_47901_Name = {
    Text = "\"rắn thôi miên\""
  },
  Event_47909_ChoiceDesc1 = {Text = "[đi]"},
  Event_47909_Desc = {
    Text = "Cô ấy lén mở một mắt. \n Tầm nhìn chỉ thấy một đám ánh sáng trắng mờ ảo, đang từ từ ngọ nguậy trong bóng tối. \n Ánh vàng nhạt lóe lên trong ánh sáng, như đang cảnh báo cô về sự vi phạm của mình. \n Cô không dám tiếp tục nhìn nữa."
  },
  Event_47909_Name = {
    Text = "\"rắn thôi miên\""
  },
  Event_47910_ChoiceDesc1 = {Text = "[đi]"},
  Event_47910_Desc = {
    Text = "Cô ấy tuân theo lời dặn của bác sĩ, không hề mở mắt dù chỉ một giây. \n Hơi lạnh lướt qua không khí xung quanh cô, dừng lại lâu trên gương mặt cô. \n Không biết đã trôi qua bao lâu, mọi thứ trở lại như bình thường. \n Như thể không có gì xảy ra."
  },
  Event_47910_Name = {
    Text = "\"rắn thôi miên\""
  },
  Event_47911_ChoiceDesc1 = {Text = "[đi]"},
  Event_47911_Desc = {
    Text = "\"Tôi thấy... một con rắn rất đẹp.\"\nBác sĩ nắm bút thép dừng lại một chút.\n \"Loại rắn nào vậy?\"\n \"Rất đẹp! Toàn thân trắng, trên có đường vân màu vàng...\"\nBác sĩ không nói gì nữa, khóe miệng khẽ nhếch lên.\n \"Cảm ơn.\""
  },
  Event_47911_Name = {
    Text = "\"rắn thôi miên\""
  },
  Event_47912_ChoiceDesc1 = {Text = "[đi]"},
  Event_47912_Desc = {
    Text = "Cô ấy nhìn thẳng vào đôi mắt màu vàng coban của bác sĩ. \n \"Tôi thấy anh biến thành một con rắn.\"\n \"Ồ. Tại sao anh chắc chắn đó là tôi?\"\n Bởi vì nó huyền bí, tĩnh lặng, phức tạp. \n Và... \n Nó trông rất mệt mỏi, như vừa thức dậy sau giấc ngủ đông nghìn năm."
  },
  Event_47912_Name = {
    Text = "\"rắn thôi miên\""
  },
  Event_47992_ChoiceDesc1 = {
    Text = "[Kết nối] phục hồi Arg2 điểm sức sống."
  },
  Event_47992_ChoiceDesc2 = {
    Text = "[Thiền định] Chọn 1 thân thể được đánh thức để tiến hành thức tỉnh."
  },
  Event_47992_ChoiceDesc3 = {
    Text = "[Trục xuất] Loại bỏ tối đa 3 thẻ triệu chứng, nhận Arg2 dấu đen."
  },
  Event_47992_Desc = {
    Text = "Bạn đang khám phá trong sương mù, đột nhiên, huy hiệu trường trên ngực bạn phát ra ánh sáng bạc yếu ớt. Ai đang gọi bạn từ bên kia thiết bị liên lạc?"
  },
  Event_47992_Name = {
    Text = "điểm liên lạc"
  },
  Event_47992_Tips3 = {
    Text = "Hiện tại không sở hữu thẻ triệu chứng"
  },
  Event_47993_ChoiceDesc1 = {Text = "[đi]"},
  Event_47993_ChoiceDesc2 = {
    Text = "[rời đi] Ngẫu nhiên 1 thẻ lệnh nhận được khắcăng: [(EnchantConfig.Arg1)]và sao chép phiên bản gốc của thẻ bài này"
  },
  Event_47993_Desc = {
    Text = "Bạn đã nhận được yêu cầu liên lạc từ trường, giọng nói quen thuộc giúp tâm trạng bạn bình yên lại. Bạn lấy lại tinh thần và tiếp tục tiến lên."
  },
  Event_47993_Name = {
    Text = "điểm liên lạc"
  },
  Event_48225_ChoiceDesc1 = {Text = "[đi]"},
  Event_48225_Desc = {
    Text = "Mèo vui vẻ liếm nhẹ mu bàn tay bạn. \n \"Cảm ơn bạn, đừng buồn vì tôi meo. \nỞ đây, các nhân cách luôn chết đi và tái sinh, \nTôi chắc chắn sẽ trở lại! \nMeo meo, meo meo meo!\""
  },
  Event_48225_Name = {
    Text = "Lời dặn cuối cùng"
  },
  Event_48226_ChoiceDesc1 = {Text = "[đi]"},
  Event_48226_Desc = {
    Text = "Mèo nghĩ rằng bạn không hiểu ý nó, nên đã cọ cọ tay bạn một cách thân thiện. \n \"Chỉ cần bạn đồng ý meo, meo sẽ dâng tất cả đồ ăn vặt được cất giấu. \nChúng được bảo quản tốt ở khu phố Cambrai @2 số...\""
  },
  Event_48226_Name = {
    Text = "Lời dặn cuối cùng"
  },
  Event_48227_ChoiceDesc1 = {Text = "[đi]"},
  Event_48227_Desc = {
    Text = "Bạn đã bày tỏ lòng thành thật xin lỗi với George. \n \"Hừ, cũng coi như ngươi còn hiểu chút lễ nghĩa. \nGeorge sẽ cân nhắc giảm mức độ nguyền rủa xuống 10%, \ntối đa 15%—— đây là giới hạn của George.\""
  },
  Event_48227_Name = {
    Text = "Hồn ma của George"
  },
  Event_48228_ChoiceDesc1 = {
    Text = "[Đồng ý với nó] nhận được vật tạo vàng \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_48228_ChoiceDesc2 = {
    Text = "[Từ chối nó] nhận được 1 trong 3 sáng tạo vàng, nhiễm [(Skill.Arg1)]"
  },
  Event_48228_ChoiceDesc3 = {
    Text = "[giữ im lặng] nhận được bạc sáng tạo [(RelicConfig.Arg1)]"
  },
  Event_48228_Desc = {
    Text = "\"Mèo 24\"đã bị thương rất nặng, nó cố gắng nói với bạn: \n \"meo meo, không còn bao lâu để sống nữa meo. \nTa có một người bạn, là một con cá tuyết bạc meo. \nNếu một ngày nào đó bạn gặp nó, hãy nói rằng ta đã đi xa meo. \nSẽ rời đi rất lâu meo. \nSẽ mang về cho nó rất nhiều khoai tây chiên không có cá meo. \nNhất định phải nói cho nó biết nhé!\""
  },
  Event_48228_Name = {
    Text = "Lời dặn cuối cùng"
  },
  Event_48229_ChoiceDesc1 = {Text = "[đi]"},
  Event_48229_Desc = {
    Text = "Mèo có chút thất vọng. \n Nhưng nó luôn là một con mèo hiền lành và dễ thương, không bao giờ ép buộc người khác. \n Cuối cùng, nó mang theo nuối tiếc và nhắm mắt lại."
  },
  Event_48229_Name = {
    Text = "Lời dặn cuối cùng"
  },
  Event_48230_ChoiceDesc1 = {
    Text = "[Xin lỗi nó] nhận được bạc tạo vật \"(RelicConfig.Arg1)\", bị ảnh hưởng bởi \"(Skill.Arg2)\""
  },
  Event_48230_ChoiceDesc2 = {
    Text = "[chế giễu nó] nhận được bạc tạo vật \"(RelicConfig.Arg1)\", lây nhiễm \"(Skill.Arg2)\""
  },
  Event_48230_ChoiceDesc3 = {
    Text = "[bỏ qua nó] nhận 25 dấu đen"
  },
  Event_48230_Desc = {
    Text = "Một bóng ma, bóng ma của George đang bay lượn trên đầu các người. \n\"George đã chết trong nhục nhã. \nNhưng không sao, George sẽ mãi nhớ về sự sỉ nhục này. \nNgười giữ bí mật, cậu sắp gặp rắc rối to rồi, hừ hừ hừ…”"
  },
  Event_48230_Name = {
    Text = "Hồn ma của George"
  },
  Event_48231_ChoiceDesc1 = {Text = "[đi]"},
  Event_48231_Desc = {
    Text = "\"Hừm, dám châm chọc George. \nYên tâm đi, khi bạn đang ăn, đang ngủ, đang hát... \nGeorge sẽ lởn vởn bên cạnh, nhắc nhở bạn, hành hạ bạn. \nĐể bạn mãi nhớ tội lỗi của mình. \nBạn sẽ không bao giờ bắt được một hồn ma, lala~\""
  },
  Event_48231_Name = {
    Text = "Hồn ma của George"
  },
  Event_48232_ChoiceDesc1 = {Text = "[đi]"},
  Event_48232_Desc = {
    Text = "Bạn bước đi nhanh chóng, vứt bỏ lời nguyền rủa của George ra sau lưng. \nTiếng nức nở vang lên từ phía sau, hóa ra George đã khóc lớn. \n \"Huhu... Một người đáng yêu như tôi, lại bị mông của bạn — \nGhê tởm! Ghê tởm! \nGeorge thà chết dưới roi da của Pandia!\""
  },
  Event_48232_Name = {
    Text = "Hồn ma của George"
  },
  Event_49055_ChoiceDesc1 = {
    Text = "[Gọi thức tỉnh] Trừ 100 điên cuồng của tất cả thân thể được đánh thức, xóa 1 thẻ triệu chứng"
  },
  Event_49055_ChoiceDesc2 = {
    Text = "[vật lộn kịch liệt] phục hồi Arg1 điểm sức sống, lây nhiễm 2 lá [(Skill.Arg2)]"
  },
  Event_49055_ChoiceDesc3 = {
    Text = "[Chèn chìa khóa bạc] Xóa bỏ tất cả năng lượng chìa khóa bạc"
  },
  Event_49055_Desc = {
    Text = "Vũng máu mờ ảo hiện ra chân tướng ngay khi bạn đặt chân lên. \n Máu đen đỏ tạo ra vô số cánh tay, bám chặt lấy mắt cá chân và dần kéo bạn xuống, ý định lôi bạn vào hố sâu khó lường."
  },
  Event_49055_Name = {
    Text = "Bassin máu"
  },
  Event_49097_ChoiceDesc1 = {
    Text = "[đi tới]"
  },
  Event_49097_Desc = {
    Text = "Bụng bạn như biển động cuồn cuộn, sau vài giây kỳ diệu lại trở nên yên bình, không hiểu sao, bạn dường như cảm nhận được một nhịp tim khác đang mạnh mẽ đập trong cơ thể mình…"
  },
  Event_49097_Name = {
    Text = "mẹ sinh thành"
  },
  Event_49098_ChoiceDesc1 = {
    Text = "[Uống cạn một hơi] Chọn [ExDesc3][ExDesc4] thẻ lệnh, để chúng nhận Khắc ấn: [(EnchantConfig.Arg1)][ExDesc1][ExDesc2]"
  },
  Event_49098_Desc = {
    Text = "Những chiếc bình gốm cũ kỹ đang nhìn bạn từ khe nứt của những vách đá thấp. \n Nguồn nước là tài nguyên quý giá nhất trong sa mạc, còn rượu là chất dẫn dắt vào thế giới điên rồ và mê hoặc. \n Ở vùng đất khô cằn này, một người còn chút lý trí rất khó từ chối lời mời gọi của nó."
  },
  Event_49098_Name = {
    Text = "mẹ sinh thành"
  },
  Event_49312_ChoiceDesc1 = {Text = "[đi]"},
  Event_49312_Desc = {
    Text = "Chìa khóa bạc phát sáng lấp lánh, những cánh tay dường như bị một loại lực lượng nào đó chấn áp, lần lượt ẩn vào nước trong hồ, sau đó biến mất không thấy."
  },
  Event_49312_Name = {
    Text = "Bassin máu"
  },
  Event_49313_ChoiceDesc1 = {Text = "[đi]"},
  Event_49313_Desc = {
    Text = "Bạn gắng sức vùng vẫy, nhưng lại càng lún sâu, trong đầu vang lên lời thì thầm như lời nguyền. \n Khi bạn hồi phục lại tinh thần, những xúc tu màu máu thỏa mãn rút lui. Bạn lại cảm thấy toàn thân dễ chịu, chỉ là trong vô thức dường như đã mất đi điều gì đó…"
  },
  Event_49313_Name = {
    Text = "Bassin máu"
  },
  Event_49314_ChoiceDesc1 = {Text = "[đi]"},
  Event_49314_Desc = {
    Text = "Thể thức tỉnh đến ngay lập tức không chút do dự đã kéo bạn ra khỏi bassin máu, cánh tay nối liền bị xé toạc, bùn lầy đục ngầu bắn tung tóe, trong nước vô số sinh vật khó có thể phân biệt bằng mắt thường đang bò lổm ngổm, dường như đang khát khao và tiêu thụ điều gì đó."
  },
  Event_49314_Name = {
    Text = "Bassin máu"
  },
  Event_49867_ChoiceDesc1 = {
    Text = "Ngẫu nhiên tăng 50 khí điên cuồng cho thân thể được đánh thức"
  },
  Event_49867_Name = {
    Text = "Sự kiện"
  },
  Event_49907_ChoiceDesc1 = {
    Text = "[hỏi thật hay giả]"
  },
  Event_49907_ChoiceDesc2 = {
    Text = "[Yêu cầu vuốt ve]"
  },
  Event_49907_Desc = {
    Text = "\"Bạn luôn nhìn chằm chằm vào sừng của tôi với vẻ tò mò, có vấn đề gì sao?\"\nThái Di Sơ đột nhiên áp sát vai bạn, hạt ngọc màu mật ong lắc lư nhẹ nhàng quét qua má bạn."
  },
  Event_49907_Name = {
    Text = "Người có sừng"
  },
  Event_49908_ChoiceDesc1 = {
    Text = "[Nhìn lên trên]"
  },
  Event_49908_ChoiceDesc2 = {
    Text = "[đi đến Thái Di Sơ]"
  },
  Event_49908_Desc = {
    Text = "Khói bụi tản ra trong đống đổ nát, bên ngoài ô cửa sổ vỡ ở một góc, bóng dáng của Thái Di Sơ bỗng xuất hiện. Cô ấy không chút ngại ngần cúi người trên bậu cửa sổ phủ đầy bụi, bí bí ẩm ẩm chỉ lên xà nhà."
  },
  Event_49908_Name = {
    Text = "Người di chuyển bí mật"
  },
  Event_49909_ChoiceDesc1 = {
    Text = "[rời đi] chọn 1 thẻ lệnh từ 3 thẻ lệnh để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_49909_Desc = {
    Text = "Bạn ngẩng đầu lên, ống đồng rỉ sét chằng chịt, giống như một mạng nhện khổng lồ bao phủ trên đầu. Một bóng đen lướt qua, là mèo hoang đang kiếm ăn hay quái vật đang ẩn nấp trong bóng tối? \n Quay lại, Thái Di Sơ cũng đã không còn bóng dáng."
  },
  Event_49909_Name = {
    Text = "Người di chuyển bí mật"
  },
  Event_49910_ChoiceDesc1 = {
    Text = "[Nhìn chăm chú vào cô ấy]"
  },
  Event_49910_ChoiceDesc2 = {
    Text = "[Gọi cô ấy]"
  },
  Event_49910_Desc = {
    Text = "Bạn lại gặp được \"ảo ảnh\". \nLần này, bạn đã biết tên của cô ấy. \nThái Di Sơ đứng dưới cây mẹ xa xôi, thành tâm cầu nguyện. \nDáng vẻ của cô mờ ảo, như hòa làm một với hình bóng của cây mẹ."
  },
  Event_49910_Name = {
    Text = "Kẻ tạo ước"
  },
  Event_49911_ChoiceDesc1 = {
    Text = "[rời đi] chọn 1 thẻ lệnh từ 3 thẻ lệnh để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_49911_Desc = {
    Text = "Bạn nhìn xa về hình bóng của Thái Di Sơ, đường nét của cô trong cơn bão tận thế này như một ngọn núi thiêng liêng và uy nghiêm, cho dù bão cát hoành hành cũng không thể làm suy yếu chút nào sự uy nghiêm của cô. \n Những bước đi của cô chậm rãi và vững chắc, dáng vẻ của cô cao quý và không thể bị xâm phạm, khiến bạn nhìn mà say mê."
  },
  Event_49911_Name = {
    Text = "Người bất tử"
  },
  Event_49912_ChoiceDesc1 = {
    Text = "[Rời đi] Chọn sao chép 1 thẻ lệnh"
  },
  Event_49912_Desc = {
    Text = "\"Bạn đoán xem?\"\nCô ấy \"Suỵt\" một tiếng, cúi người lại gần hơn, bạn cảm thấy đầu sừng đã chạm vào má bạn, mang theo cảm giác mát lạnh và ngứa ngáy..."
  },
  Event_49912_Name = {
    Text = "Người có sừng"
  },
  Event_49913_ChoiceDesc1 = {
    Text = "[Rời đi] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_49913_Desc = {
    Text = "\"Muốn sờ thì cứ mạnh dạn nói ra đi, lẽ nào tôi sẽ từ chối bạn sao?\"\nCô ấy khẽ mỉm cười, nhẹ nhàng nắm lấy tay bạn, cảm giác đầu ngón tay ấm áp và mềm mại khiến bạn như muốn đắm chìm trong khoảnh khắc ấy..."
  },
  Event_49913_Name = {
    Text = "Người có sừng"
  },
  Event_49914_ChoiceDesc1 = {
    Text = "[Rời đi] Chọn 1 thân thể được đánh thức, giảm phí thẻ thức tỉnh của nó xuống 1, nhiễm [(Skill.Arg1)]"
  },
  Event_49914_Desc = {
    Text = "Bạn cùng mọi người quỳ gối trên mặt đất. \n \"Tôi đã biết, Nữ hoàng, Người lớn luôn bảo vệ chúng ta!\"\nTiếng khóc nức nở vì vui sướng, tiếng gọi dài hòa lẫn với tiếng gió rít, cảm ứng trong não bạn. \nMờ ảo, có một suy nghĩ quan trọng lóe lên nhưng không thể bắt lấy."
  },
  Event_49914_Name = {
    Text = "Người bất tử"
  },
  Event_49915_ChoiceDesc1 = {
    Text = "[rời đi] nhận được 3 chọn 1 vật phẩm bạc, nhiễm phải 「(Skill.Arg1)」"
  },
  Event_49915_Desc = {
    Text = "Bạn vẫy tay với cô ấy. \n \"Cậu đang làm gì vậy?\" Ramona nhìn bạn đầy nghi hoặc. \n \"Ở đó...\"\n Chưa kịp nói xong, người phụ nữ ở xa đã biến mất. \n Phải chăng là ảo giác?"
  },
  Event_49915_Name = {
    Text = "Người tưới nước"
  },
  Event_49916_ChoiceDesc1 = {
    Text = "[trả lời cô ấy]"
  },
  Event_49916_ChoiceDesc2 = {Text = "[do dự]"},
  Event_49916_Desc = {
    Text = "Xa xa, một người phụ nữ đang cúi xuống múc nước bên bờ sông. \nDường như nhận ra ánh mắt của bạn, cô ấy quay người và vẫy tay chào bạn. \nBạn để ý thấy, có điều gì đó hơi khác lạ trong cách cô ấy quay người."
  },
  Event_49916_Name = {
    Text = "Người tưới nước"
  },
  Event_49917_ChoiceDesc1 = {
    Text = "[Rời đi] Chọn 1 trong 3 thẻ lệnh để nhận khắcăng [(EnchantConfig.Arg1)]"
  },
  Event_49917_Desc = {
    Text = "Trong lúc bạn do dự, người phụ nữ quay người nhảy vào giữa ốc đảo và biến mất. \nBạn không dám tin vào mắt mình… cô ấy dường như có móng dê?"
  },
  Event_49917_Name = {
    Text = "Người tưới nước"
  },
  Event_49918_ChoiceDesc1 = {
    Text = "[Rời đi] Chọn 1 trong 3 thẻ lệnh để nhận khắcăng [(EnchantConfig.Arg1)]"
  },
  Event_49918_Desc = {
    Text = "\"Hỡi cây, xin hãy lắng nghe Ước nguyện của @1 người, ta sẽ tắm mình trong dòng sữa của Người mà Tái Sinh, trở thành Người thực hiện của Người, bước đi vì Người giữa những cồn cát vàng, để rễ của Người Đạt đến mọi ngóc ngách của Lemvahi…\"\n\nTiếng cầu nguyện non nớt nối tiếp nhau Vang vọng trong không gian."
  },
  Event_49918_Name = {
    Text = "Kẻ tạo ước"
  },
  Event_49919_ChoiceDesc1 = {
    Text = "[ Rời đi ] Ngẫu nhiên đánh thức 1 thân thể được kích hoạt"
  },
  Event_49919_Desc = {
    Text = "Ánh mắt mập mờ khó hiểu của Thái Di Sơ thu hút sự chú ý của bạn, một loại lực lượng kỳ lạ khiến bạn không tự chủ được mà mê mẩn, bạn như bị lôi kéo, không kiềm lòng nổi bước về phía cô ấy. \n \"Thực ra, những thứ không nhìn thấy vẫn tồn tại.\"\nCô ấy thì thầm nhẹ nhàng vào tai bạn, bạn dường như đã lĩnh hội được điều gì đó, nhưng lại như bị bao phủ bởi một lớp voan trắng, không thể nhìn rõ ràng. \nĐây là một lời tiên tri chăng? Trong khoảnh khắc, Thái Di Sơ đã biến mất không còn dấu vết."
  },
  Event_49919_Name = {
    Text = "Người di chuyển bí mật"
  },
  Event_49920_ChoiceDesc1 = {Text = "[nhìn xa]"},
  Event_49920_ChoiceDesc2 = {
    Text = "[quỳ rạp]"
  },
  Event_49920_Desc = {
    Text = "Con cừu với móng đen đặt chân lên mặt đất đầy gió cát. \n Thái Di Sơ cất tiếng hát trong một lời cầu nguyện bí ẩn, hàng ngàn người Aran nghênh đón cô bằng cách quỳ gối về hướng cô bước tới."
  },
  Event_49920_Name = {
    Text = "Người bất tử"
  },
  Event_49921_ChoiceDesc1 = {
    Text = "[đi] nhận được quyền chọn 1 trong 3 vật tạo vàng, nhiễm [(Skill.Arg1)]"
  },
  Event_49921_Desc = {
    Text = "Cây khổng lồ vươn ra muôn vàn cành cây to lớn, như những xúc tu quấn chặt, siết chặt cổ tay và mắt cá chân của Thái Di Sơ, bất chấp sự vùng vẫy và chống cự của cô, thô bạo đưa thân thể cô vào khoang bụng của thân cây đang phình to…\n\nMặc dù chỉ là hình bóng xa xôi, nỗi đau của cô vẫn theo từng gợn sóng nước chạm đến tận trái tim bạn."
  },
  Event_49921_Name = {
    Text = "Kẻ tạo ước"
  },
  Event_49922_ChoiceDesc1 = {
    Text = "[rời đi] nhận được sáng tạo [(RelicConfig.Arg1)]"
  },
  Event_49922_Desc = {
    Text = "Cánh tay và chân mềm nhũn theo nhựa cây chảy dọc các cành, cô ấy cố gắng hết sức để vùng vẫy, nhưng các chi thể lại giống như những con sâu bò lổm ngổm không nghe theo ý muốn. \n \"Xương đã hoàn toàn tan rã,\"đôi mắt và lông mày của Thái Di Sơ bị nỗi buồn xâm chiếm,\"Cô ấy đã trở thành một phần của cây rồi.\"\n \"Chúng ta cần lực lượng đảo ngược... lực lượng vượt thời gian.\""
  },
  Event_49922_Name = {
    Text = "Người bị ăn mòn"
  },
  Event_49923_ChoiceDesc1 = {
    Text = "[rời đi] chọn 1 thẻ lệnh từ 3 thẻ lệnh để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_49923_Desc = {
    Text = "「Và, vị “mắt không có tròng treo ngược” kia, không biết tại sao, lại có một sức hút mãnh liệt từ tận đáy lòng…」\n「Ồ, đang nói về tôi à?」\n「Mednight đang ca ngợi khả năng kể câu chuyện của bạn đấy.」\n\nĐêm đó, bên đống lửa trại âm thầm cháy, cô ấy rót thêm rượu cho bạn."
  },
  Event_49923_Name = {
    Text = "Người bị ăn mòn"
  },
  Event_49924_ChoiceDesc1 = {
    Text = "[Phẫu thuật khối u cây]"
  },
  Event_49924_ChoiceDesc2 = {Text = "[Ký ức]"},
  Event_49924_Desc = {
    Text = "Một khối u cây. \nNó đập một cách xấu xa và sưng lên, bên trong lớp da yếu đuối và trong suốt màu máu lộ ra một khuôn mặt quái dị và đau đớn, như thể sắp phá vỡ ra. \n \"Mỹ Điền Nặc.\" Thái Di Sơ lộ vẻ buồn bã, dịu dàng gọi tên khuôn mặt."
  },
  Event_49924_Name = {
    Text = "Người bị ăn mòn"
  },
  Event_49939_ChoiceDesc1 = {
    Text = "[Tin tưởng Lắc] tất cả thân thể được đánh thức hồi phục Arg1 điên cuồng"
  },
  Event_49939_ChoiceDesc2 = {
    Text = "[lo lắng về Lắc] chọn thức tỉnh 2 thân thể được đánh thức"
  },
  Event_49939_Desc = {
    Text = "“Tin vào vận may của tôi đi.”"
  },
  Event_49939_Name = {
    Text = "Thám tử may mắn"
  },
  Event_49940_ChoiceDesc1 = {Text = "[đi]"},
  Event_49940_Desc = {
    Text = "Lắc chỉ giỏi ba việc: trinh sát, lắng nghe và ném xúc xắc. \n Nói cách khác, anh ấy không phải là người chiến đấu giỏi. \n Nỗi lo lắng trong lòng bạn khó có thể kiềm chế, leo thang không kiểm soát được."
  },
  Event_49940_Name = {
    Text = "Thám tử may mắn"
  },
  Event_49941_ChoiceDesc1 = {Text = "[đi]"},
  Event_49941_Desc = {
    Text = "Niềm tin trong trái tim là phép thuật, anh ta sẽ vượt qua mọi thử thách trước mắt."
  },
  Event_49941_Name = {
    Text = "Thám tử may mắn"
  },
  Event_49943_ChoiceDesc1 = {Text = "[đi]"},
  Event_49943_Desc = {
    Text = "Bạn cảm thấy rất ngại ngùng, nhưng vẫn nhìn Ramona đang bệnh với ánh mắt đầy van xin. \n\"Tôi sẽ làm.\" \nCô ấy mặt đỏ bừng, lấy từ chiếc vali xách tay vô hạn ra một chai thu thập mới toanh, nhanh chóng úp lồng lên con nhện."
  },
  Event_49943_Name = {
    Text = "Con nhện độc"
  },
  Event_49944_ChoiceDesc1 = {Text = "[đi]"},
  Event_49944_Desc = {
    Text = "Lắc búng tay, rồi đưa ngón tay trỏ đầy lông về phía con nhện lớn đang giơ chân trước lên cao. \n Những loài có hoa văn sặc sỡ như vậy phần lớn đều có độc, bạn vừa định nhắc nhở anh ta cẩn thận, thì con nhện trước đó còn đầy thù địch đã nhẹ nhàng nhảy lên khớp ngón tay của anh ta, cuộn tròn lại. \n Thôi kệ, mỗi người có một số phận."
  },
  Event_49944_Name = {
    Text = "Con nhện độc"
  },
  Event_49945_ChoiceDesc1 = {
    Text = "[nhìn về phía Ramona] nhận được 3 chọn 1 khắcăng"
  },
  Event_49945_ChoiceDesc2 = {
    Text = "[nhìn Lắc] Chọn một trong ba thẻ lệnh để nhận khắcăng: \"(EnchantConfig.Arg1)\", bị nhiễm \"(Skill.Arg2)\""
  },
  Event_49945_Desc = {
    Text = "Nhiều mắt đa diện nhìn chằm chằm vào bạn. \n Chủ của mắt đa diện lùi lại một bước, giơ móng vuốt ra để đe dọa bạn. \n Nhìn từ những bước chân cao và các xúc tu cùng hai đôi chân nâng đỡ cơ thể, đây quả thực là một sinh vật thuộc lớp nhện hiếm thấy. \n Trước khi đi, Khổ Lệ Đặc đã dặn dò: \"Nhiệm vụ bổ sung, hãy thu thập mẫu sinh vật địa phương và lưu giữ tại trạm khảo sát địa phương.\" \n Bạn lắc lắc chai thu thập trong ba lô, sau vài tuần hành trình, bên trong đã đầy ắp côn trùng."
  },
  Event_49945_Name = {
    Text = "Con nhện độc"
  },
  Event_49946_ChoiceDesc1 = {Text = "[đi]"},
  Event_49946_Desc = {
    Text = "\"Tham lam bất chấp thời cơ quả thật là một căn bệnh.\""
  },
  Event_49946_Name = {
    Text = "Câu trả lời của bạn"
  },
  Event_49947_ChoiceDesc1 = {Text = "[đi]"},
  Event_49947_Desc = {
    Text = "\"Đọc theo sách không thể giúp bạn giành được sự cảm tình, đứa trẻ à.\""
  },
  Event_49947_Name = {
    Text = "Câu trả lời của bạn"
  },
  Event_49948_ChoiceDesc1 = {
    Text = "[Vàng khóa] nhận được vật tạo vàng \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_49948_ChoiceDesc2 = {
    Text = "[chìa khóa sắt] nhận được 3 chọn 1 vật tạo vàng, bị ảnh hưởng bởi [(Skill.Arg1)]"
  },
  Event_49948_ChoiceDesc3 = {
    Text = "[chìa khóa bạc] nhận được bạc tạo vật [(RelicConfig.Arg1)]"
  },
  Event_49948_Desc = {
    Text = "Vào giờ ngọ, hơi nước từ dòng sông thiêng liêng ngưng tụ thành hai hình bóng hư không. \nHình bóng mờ ảo hỏi bạn: Đây có phải chìa khóa vàng, bạc hay sắt mà bạn đã làm rơi không?"
  },
  Event_49948_Name = {
    Text = "Câu trả lời của bạn"
  },
  Event_49949_ChoiceDesc1 = {Text = "[đi]"},
  Event_49949_Desc = {
    Text = "\"Trung thực thường mang lại kết quả thận trọng hơn, nhưng đồng thời, bạn có thể sẽ bỏ lỡ điều gì đó.\""
  },
  Event_49949_Name = {
    Text = "Câu trả lời của bạn"
  },
  Event_50013_ChoiceDesc1 = {Text = "[đi]"},
  Event_50013_Desc = {
    Text = "Bạn chăm chú nhìn, nhưng gương mặt của người đó lại dao động theo làn sóng nước, mờ mịt không rõ. \n\n Bạn càng nhìn kỹ, hơi thở càng trở nên chậm chạp, não bộ truyền đến cảm giác mơ hồ như thiếu oxy, cho đến khi nghe thấy giọng nói của Ramona gọi bạn, mới miễn cưỡng được kéo trở lại thực tại. \n Mặt nước phản chiếu ánh nắng chói chang nhưng dưới mặt nước dường như có thứ gì đó lấp lánh."
  },
  Event_50013_Name = {
    Text = "Hình bóng cái chết"
  },
  Event_50014_ChoiceDesc1 = {Text = "[đi]"},
  Event_50014_Desc = {
    Text = "Hình bóng tan biến chỉ trong một chạm, tay bạn trống rỗng, chỉ còn lại cơn đau nhói đột ngột ở thái dương. \n Mặt nước phản chiếu ánh mặt trời chói chang, nhưng dưới mặt nước dường như có thứ gì đó lấp lánh."
  },
  Event_50014_Name = {
    Text = "Hình bóng cái chết"
  },
  Event_50015_ChoiceDesc1 = {
    Text = "[cố gắng nhận ra] nhận được bạc tạo vật \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_50015_ChoiceDesc2 = {
    Text = "[vươn tay chạm vào] nhận được bạc sáng tạo \"(RelicConfig.Arg1)\", bị lây nhiễm bởi \"(Skill.Arg2)\""
  },
  Event_50015_ChoiceDesc3 = {
    Text = "[xoa xoa mắt] nhận được 25 dấu đen"
  },
  Event_50015_Desc = {
    Text = "Bạn bị Nubia đẩy một cái, nửa chân rơi vào dòng sông thiêng. \n Bạn cố gắng giữ thăng bằng, nhưng trong sóng nước chao đảo lại thấy được hình ảnh không nên thấy. \n Đó là một thanh niên mặc đồng phục Misaque, dáng người cao thanh thoát, thân thể mềm nhũn chìm trong dòng nước của sông thiêng."
  },
  Event_50015_Name = {
    Text = "Hình bóng cái chết"
  },
  Event_50016_ChoiceDesc1 = {Text = "[đi]"},
  Event_50016_Desc = {
    Text = "Nỗi hoảng sợ ăn mòn tâm trí bạn, nỗi đau khiến ý thức trở nên mơ hồ, bạn cố gắng giằng xé, nhưng những dây leo lại càng siết chặt hơn, trong mũi bạn thấm vào chất nhầy tỏa ra mùi lạ, mỗi lần hít thở đều mang theo sự tuyệt vọng dính dớp. \n Ramona vung kiếm đâm xuống, Nubia gãy chân mà chạy trốn, bạn giật xuống đoạn xúc tu cuối cùng dính bên má, trên đó còn dính một lớp thịt máu mơ hồ."
  },
  Event_50016_Name = {
    Text = "Gió thổi vào mặt"
  },
  Event_50017_ChoiceDesc1 = {Text = "[đi]"},
  Event_50017_Desc = {
    Text = "Ánh sáng bạc đâm vào cơ thể Nubia, cảm giác thịt máu nổ tung theo chìa khóa bạc truyền đến đầu ngón tay và cổ tay bạn. \n Các xúc tu biến dạng của Nubia giơ cao lên bầu trời, phát ra tiếng rít kinh dị và bi thương, toàn thân hóa thành chất lỏng không rõ đặc quánh."
  },
  Event_50017_Name = {
    Text = "Gió thổi vào mặt"
  },
  Event_50018_ChoiceDesc1 = {
    Text = "[xé toạc] nhận được vật bị nguyền rủa \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_50018_ChoiceDesc2 = {
    Text = "[Xuyên thấu] 1 thẻ lệnh ngẫu nhiên nhận được Khắc ấn: [(EnchantConfig.Arg1)]"
  },
  Event_50018_Desc = {
    Text = "Cánh tay dạng dây leo của Nubia vặn vẹo bay múa, chớp thời cơ lao thẳng lên má bạn, cuồng bạo xâm nhập vào miệng và mũi bạn."
  },
  Event_50018_Name = {
    Text = "Gió thổi vào mặt"
  },
  Event_50019_ChoiceDesc1 = {Text = "[đi]"},
  Event_50019_Desc = {
    Text = "Nước chỉ phản chiếu ánh sáng lung linh. \n Bạn rút chân ướt sũng lên, đổ cát ướt khỏi giày. \n Hình ảnh vừa rồi vẫn còn vương vấn trong tâm trí, không thể xua tan."
  },
  Event_50019_Name = {
    Text = "Hình bóng cái chết"
  },
  Event_50029_ChoiceDesc1 = {Text = "[đi]"},
  Event_50029_Desc = {
    Text = "\"Anh ấy sẽ trở lại sao? Hay mãi mãi bỏ rơi bạn trong sa mạc vô tận này?\"\n \"Liệu anh ấy có tìm được bạn không? Hay sẽ bị lạc hướng do sự thay đổi của gió và cồn cát?\"\n \"Niềm hy vọng mà bạn gửi gắm cho người khác, liệu có thật sự đáng tin cậy không?\""
  },
  Event_50029_Name = {
    Text = "Bãi cát mất tích"
  },
  Event_50030_ChoiceDesc1 = {
    Text = "[Tìm kiếm cứu viện] Ngẫu nhiên thức tỉnh 1 thân thể được đánh thức, nhiễm [(Skill.Arg1)]"
  },
  Event_50030_ChoiceDesc2 = {
    Text = "[Tiến lên cùng nhau] Chọn 1 trong 3 thẻ lệnh để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_50030_Desc = {
    Text = "Một giọng nói cổ xưa và xa xôi hòa lẫn trong tiếng nước chảy nhẹ nhàng hỏi bạn. \n \"Bạn đã lạc trong sa mạc rộng lớn.\"\n \"Trước mặt bạn có hai lựa chọn. Người đồng hành của bạn nhanh hơn, hãy để anh ấy mang đồ tiếp tế đi tìm cứu viện, còn bạn giữ sức ở lại với mức tiêu thụ tối thiểu.\"\n \"Hoặc hai người có thể cùng chia sẻ tất cả và tiếp tục bước đi.\""
  },
  Event_50030_Name = {
    Text = "Bãi cát mất tích"
  },
  Event_50031_ChoiceDesc1 = {Text = "[đi]"},
  Event_50031_Desc = {
    Text = "\"Các ngươi chưa chắc có thể đi xa hơn, nhưng linh hồn và thân xác của các ngươi gắn bó chặt chẽ, từ đó có được lực lượng để cổ vũ lẫn nhau.\"\n \"Đây chính là sự lựa chọn của ngươi.\"\nNói xong, mặt trời chói chang trên cao nhẹ nhàng khép mắt lại."
  },
  Event_50031_Name = {
    Text = "Bãi cát mất tích"
  },
  Event_50064_ChoiceDesc1 = {
    Text = "[[Cắt dây lụa đỏ]] xóa 1 thẻ lệnh, nhận Arg1 dấu đen"
  },
  Event_50064_ChoiceDesc2 = {
    Text = "[đối kháng] sao chép 1 thẻ lệnh, lây nhiễm [(Skill.Arg1)]"
  },
  Event_50064_ChoiceDesc3 = {
    Text = "[Gọi Ramona] Chọn 1 thẻ lệnh từ 3 thẻ lệnh để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_50064_Desc = {
    Text = "Kassia vung chiếc khăn đỏ, ngay lập tức quấn lấy vali của bạn."
  },
  Event_50064_Name = {Text = "Seda rối"},
  Event_50065_ChoiceDesc1 = {Text = "[đi]"},
  Event_50065_Desc = {
    Text = "Âm thanh gõ giòn giã, lúc có lúc không, vang vọng trong những ống dẫn chằng chịt phía trên đầu bạn, như một linh hồn đơn độc đang nhảy múa, vung vẩy đôi cánh tay yếu ớt trong không gian tĩnh lặng này. \n Sự tưởng tượng này trong lòng bạn gợi lên nỗi sợ hãi cổ xưa với cái lạnh nghiêm khắc."
  },
  Event_50065_Name = {
    Text = "Thang âm kỳ quái"
  },
  Event_50066_ChoiceDesc1 = {
    Text = "[Khám phá tại cửa hang] Nhận được bạc tạo vật [(RelicConfig.Arg1)]"
  },
  Event_50066_ChoiceDesc2 = {
    Text = "[thâm nhập hang động] nhận được vật tạo vàng \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_50066_Desc = {
    Text = "\"Đây có một hang động.\"\nThái Di Sơ nghiêng người mời bạn. \n \"Có muốn vào xem không?\"\nHang động hẹp, tối và sâu thẳm, giống như miệng quỷ khổng lồ, vươn dài vào bóng tối vô tận. Bất kỳ ai bước vào vùng đất hoang vắng này đều không thể thoát khỏi cảm giác bất an dâng lên từ tủy sống. Dường như trong mỗi góc của hang động đều ẩn nấp những sinh vật cổ xưa không dám nhìn ánh mặt trời, đang chờ đợi kẻ xâm nhập xuất hiện."
  },
  Event_50066_Name = {Text = "Hang tối"},
  Event_50067_ChoiceDesc1 = {
    Text = "[Đánh bại từng cái] ngẫu nhiên một vật sáng tạo bằng bạc nâng cấp thành vật sáng tạo bằng vàng [(RelicConfig.Arg1)]"
  },
  Event_50067_ChoiceDesc2 = {
    Text = "[bao vây hai người] nhận được bạc tạo vật \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_50067_ChoiceDesc3 = {
    Text = "[nghe lén cuộc trò chuyện] nhận được 25 dấu đen"
  },
  Event_50067_Desc = {
    Text = "Hai người Aram chăm sóc cổng nhà máy.\nMột trong số họ lượn lờ không làm gì, trò chuyện với người còn lại.\n \"Có người nói, Lady Juliette lại đang kiểm kê đội ngũ cố gắng vượt qua Bức tường bão.\"\n \"Tôi thực sự không muốn bị chọn đâu.\""
  },
  Event_50067_Name = {
    Text = "Người giữ cửa nhàn rỗi"
  },
  Event_50067_Tips1 = {
    Text = "Chưa sở hữu bạc sáng tạo"
  },
  Event_50068_ChoiceDesc1 = {Text = "[đi]"},
  Event_50068_Desc = {
    Text = "Không xem, không nghe, không nghĩ. \nĐừng nghĩ đến nguồn gốc của âm sắc không hợp thời, bạn thẳng tiến đến nơi xác chết của cây mẹ."
  },
  Event_50068_Name = {
    Text = "Thang âm kỳ quái"
  },
  Event_50069_ChoiceDesc1 = {Text = "[đi]"},
  Event_50069_Desc = {
    Text = "Ramona đâm một kiếm về phía Kasia đang vung lụa đỏ, Kasia vội vàng tránh né, sợi lụa đỏ quấn quanh bạn cũng lập tức tuột ra."
  },
  Event_50069_Name = {Text = "Seda rối"},
  Event_50070_ChoiceDesc1 = {Text = "[đi]"},
  Event_50070_Desc = {
    Text = "Các người chia thành hai đội, bạn và Ramona đi bên trái, Lắc đi bên phải, tấn công từ hai phía. \nBạn giơ tay ra hiệu, Ramona và Lắc đồng loạt ra tay, hai lính canh Aran ngã xuống trong im lặng."
  },
  Event_50070_Name = {
    Text = "Người giữ cửa nhàn rỗi"
  },
  Event_50071_ChoiceDesc1 = {Text = "[đi]"},
  Event_50071_Desc = {
    Text = "Lúc này không nên đi sâu vào bẫy. Các người chỉ cần lảng vảng quanh miệng hang, đã gần như có thể cảm nhận được sự ác độc đang rung động trong mạch đá."
  },
  Event_50071_Name = {Text = "Hang tối"},
  Event_50072_ChoiceDesc1 = {Text = "[đi]"},
  Event_50072_Desc = {
    Text = "Theo chỉ dẫn của bạn, Lắc đã dùng một con xúc xắc đánh ngất tên lính canh A Lan đang im lặng, sau đó lặng lẽ tiến gần đến tên khác vẫn đang nói không ngừng. \n \"Này, anh bạn, nếu như vị đại nhân gì đó Yu Li-ét là kẻ lừa đảo, anh nghĩ phải làm sao?\"\n \"Tôi cũng không biết phải làm sao.\"\nLắc vui vẻ cười hở răng, tên lính canh run rẩy toàn thân, vừa định la lên thì bị Lắc bịt kín miệng và mũi."
  },
  Event_50072_Name = {
    Text = "Người giữ cửa nhàn rỗi"
  },
  Event_50073_ChoiceDesc1 = {
    Text = "[Lắng nghe cẩn thận] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_50073_ChoiceDesc2 = {
    Text = "[bịt tai] Mỗi khi có một thân thể được đánh thức có chỉ số điên cuồng từ 50 trở lên, nhận được 15 dấu đen"
  },
  Event_50073_ChoiceDesc3 = {
    Text = "[Xem] Nhận được khắcăng, chọn 1 trong 3"
  },
  Event_50073_Desc = {
    Text = "Khi các bạn bước vào tầng có xác chết, tiếng chuông trong trẻo bất ngờ vang lên giữa nhà máy bỏ hoang rộng lớn. Cảm giác mát mẻ và tinh khiết của tiếng đàn piano hoàn toàn đối lập với đống phế tích thép rỉ sét xung quanh."
  },
  Event_50073_Name = {
    Text = "Thang âm kỳ quái"
  },
  Event_50074_ChoiceDesc1 = {Text = "[đi]"},
  Event_50074_Desc = {
    Text = "\"Này, anh bạn, nếu như bà đại nhân Yu Li-ét là kẻ lừa đảo, anh nói phải làm sao?\"\n \"Đừng nói bậy, từ khi Yu Li-ét đến, mọi thứ đều được sắp xếp gọn gàng. Nếu bà ấy là kẻ lừa đảo, tại sao lại giúp người Aran nhiều như vậy?\"\nTrong lúc họ tán gẫu, Lắc lặng lẽ chọn vị trí mai phục, hai viên xúc xắc bay ra, đánh ngã cả hai người."
  },
  Event_50074_Name = {
    Text = "Người giữ cửa nhàn rỗi"
  },
  Event_50075_ChoiceDesc1 = {Text = "[đi]"},
  Event_50075_Desc = {
    Text = "Bạn đủ can đảm để nhìn lại. \nCon mắt khổng lồ trên màn sáo bỗng nhiên méo mó thành một nụ cười gớm ghiếc, sự kháng cự của bạn dần lung lay và sụp đổ."
  },
  Event_50075_Name = {
    Text = "Mắt Ma Thuật"
  },
  Event_50076_ChoiceDesc1 = {Text = "[đi]"},
  Event_50076_Desc = {
    Text = "Bạn toàn tâm toàn ý xé rách màn che. \n Con mắt khổng lồ dưới tay bạn biến thành một mảnh vải rách mất đi chiều sâu."
  },
  Event_50076_Name = {
    Text = "Mắt Ma Thuật"
  },
  Event_50077_ChoiceDesc1 = {
    Text = "[Nhìn lại] Nhận được vật tạo vàng \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_50077_ChoiceDesc2 = {
    Text = "[Tear Curtain] Chọn 1 trong 3 thẻ lệnh để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_50077_Desc = {
    Text = "Màn che mở ra vô số con mắt khổng lồ méo mó. \nẨn sau những con ngươi, một quái vật toát lên cơn đói khát bất thường, đang rục rịch chuẩn bị hành động."
  },
  Event_50077_Name = {
    Text = "Mắt Ma Thuật"
  },
  Event_50078_ChoiceDesc1 = {Text = "[đi]"},
  Event_50078_Desc = {
    Text = "Thì ra là một đoạn phụ tùng dài bị bỏ hoang, bị tiếng động của các bạn làm rung chuyển, lắc lư rồi va vào ống sắt."
  },
  Event_50078_Name = {
    Text = "Thang âm kỳ quái"
  },
  Event_50079_ChoiceDesc1 = {Text = "[đi]"},
  Event_50079_Desc = {
    Text = "Thái Di Sơ thản nhiên bước vào hang đá, bạn cũng từ từ theo sau khám phá. \n \"Cẩn thận!\" Bạn bị giật mạnh, ngã ngồi trong một vòng tay mềm mại. Trước mặt các bạn, một con quái vật khổng lồ màu đen lao ra khỏi hang với tốc độ kinh hoàng. \n \"Nhìn đây,\" khi bạn vẫn còn hoảng hốt, Thái Di Sơ lên tiếng, đôi mắt cô ấy lấp lánh trong bóng tối, \"có lẽ đó là của cải quý giá của nó.\""
  },
  Event_50079_Name = {Text = "Hang tối"},
  Event_50080_ChoiceDesc1 = {Text = "[đi]"},
  Event_50080_Desc = {
    Text = "Bạn cố gắng kéo mạnh tay vali để đối kháng tấm lụa đỏ.\nNhưng tấm lụa đỏ có sức mạnh vô cùng, vali của bạn bị tuột khỏi tay, đồ đạc rơi rớt đầy đất."
  },
  Event_50080_Name = {Text = "Seda rối"},
  Event_50081_ChoiceDesc1 = {Text = "[đi]"},
  Event_50081_Desc = {
    Text = "Bạn ghét cảm giác bị trói buộc. \n Bạn nắm lấy dải lụa đỏ, một tiếng \"xoẹt\" vang lên khi bạn xé nó làm đôi. \n Nửa đoạn lụa còn lại uốn lượn như một con rắn đỏ trườn đi."
  },
  Event_50081_Name = {Text = "Seda rối"},
  Event_50276_ChoiceDesc1 = {
    Text = "[Tiêu diệt tế phẩm] nhận được vật bị nguyền rủa \"(RelicConfig.Arg1)\", bị nhiễm \"(Skill.Arg2)\""
  },
  Event_50276_ChoiceDesc2 = {
    Text = "[Tháo dây thừng] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: [(EnchantConfig.Arg1)]"
  },
  Event_50276_ChoiceDesc3 = {
    Text = "[Tiếp tục tiến lên] nhận được 50 dấu đen"
  },
  Event_50276_Desc = {
    Text = "Ba người Aran bị trói trên bục cao. \nTrên người họ xuất hiện những đường vân tối giống vỏ cây, miệng thì lẩm bẩm."
  },
  Event_50276_Name = {
    Text = "ba vật tế"
  },
  Event_50277_ChoiceDesc1 = {
    Text = "[Ánh nhìn] Nhận được vật phẩm bạc \"(RelicConfig.Arg1)\" và bị nhiễm \"(Skill.Arg2)\""
  },
  Event_50277_ChoiceDesc2 = {
    Text = "[bỏ qua] nhận được 1 trong 3 khắc ấn"
  },
  Event_50277_Desc = {
    Text = "Người Aran quỳ gối trong cơn bão cát. \n Cơn bão quất vào thân thể của họ, cát cuốn đi lòng thành kính của họ. \n Trong xoáy cát bụi, dường như có vô số con mắt khổng lồ nhìn xuống mảnh đất méo mó."
  },
  Event_50277_Name = {
    Text = "Gigante Cát và Bụi"
  },
  Event_50278_ChoiceDesc1 = {Text = "[đi]"},
  Event_50278_Desc = {
    Text = "Hình ảnh mà bạn không muốn nhớ lại một lần nữa hiện lên trước mắt. \n Những xúc tu đung đưa, những vết cắt từ mảnh kính vỡ chảy máu ròng ròng… \n Bạn nôn mửa."
  },
  Event_50278_Name = {
    Text = "Cô đơn Ⅱ"
  },
  Event_50279_ChoiceDesc1 = {Text = "[đi]"},
  Event_50279_Desc = {
    Text = "Cô ấy không ở đây, cô ấy không ở trong cơn sốt nguy hiểm nhất. \nĐiều này đủ để bạn yên tâm."
  },
  Event_50279_Name = {
    Text = "Cô đơn Ⅰ"
  },
  Event_50280_ChoiceDesc1 = {
    Text = "[Tập kích] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: [(EnchantConfig.Arg1)]"
  },
  Event_50280_ChoiceDesc2 = {
    Text = "[Tấn công] ngẫu nhiên 3 thẻ lệnh nhận được khắcăng: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_50280_Desc = {
    Text = "Một con Nubia đang vật lộn trong cơn bão cát điên cuồng. \nBốn chân của nó chìm sâu vào cát vàng, cố gắng hết sức để tránh bị cuốn vào vòng xoáy."
  },
  Event_50280_Name = {
    Text = "Bão cát tự nhiên"
  },
  Event_50281_ChoiceDesc1 = {Text = "[đi]"},
  Event_50281_Desc = {
    Text = "Bạn dũng cảm xông vào và nhanh chóng kéo dây thừng trong sự kinh ngạc của người Aran. \nMột chiến binh Aran tiến gần, bạn giật lấy cây giáo từ tay anh ta, chỉ thẳng vào đám đông tối om."
  },
  Event_50281_Name = {
    Text = "ba vật tế"
  },
  Event_50282_ChoiceDesc1 = {Text = "[đi]"},
  Event_50282_Desc = {
    Text = "Lý trí mách bảo bạn, anh ta sẽ không đến. \nĐúng vậy, ai lại trông mong một kẻ đánh bạc giữ lời hứa chứ? \nBạn chỉ có thể sống trong cô đơn. Cô đơn là tất cả những gì bạn có."
  },
  Event_50282_Name = {
    Text = "Hành trình đơn độc Ⅲ"
  },
  Event_50283_ChoiceDesc1 = {Text = "[đi]"},
  Event_50283_Desc = {
    Text = "Cơn sốt bất thường có tăng lên khi cây mẹ phục sinh không? \n Ramona có thể tự chăm sóc bản thân ngoài Tường Bão không? \n Bây giờ không phải là lúc phân tâm, nhưng bạn không khỏi lo lắng cho người đồng hành của mình."
  },
  Event_50283_Name = {
    Text = "Cô đơn Ⅰ"
  },
  Event_50284_ChoiceDesc1 = {Text = "[đi]"},
  Event_50284_Desc = {
    Text = "Bạn quyết tâm đối đầu trực diện, Nubia lại như tìm được điểm tựa hiếm có, nhảy lên và bám vào đầu bạn. \nBạn bị cuốn vào sự giằng co kép giữa cơn bão cát và Nubia. \n \"Sức mạnh mù quáng không phải là cách để giành chiến thắng,\" giọng nói lạnh lùng của William vang lên trong tai bạn, người đang bị bít kín bởi cát, nghe như lời phúc âm của thiên thần, \"hãy học cách nắm bắt cơ hội.\""
  },
  Event_50284_Name = {
    Text = "Bão cát tự nhiên"
  },
  Event_50285_ChoiceDesc1 = {Text = "[đi]"},
  Event_50285_Desc = {
    Text = "Đây không phải lúc để ngồi đọc báo nhàn hạ."
  },
  Event_50285_Name = {
    Text = "Lời dặn dò của cô ấy"
  },
  Event_50286_ChoiceDesc1 = {Text = "[đi]"},
  Event_50286_Desc = {
    Text = "Bạn không nghĩ, bạn không hồi tưởng.\nBạn không muốn nghĩ, bạn không muốn hồi tưởng.\nHuyền thoại của Misaque sẽ hạ màn, nhưng hành trình của Misaque sẽ không dừng lại.\nBạn phải tiếp tục bước đi. Bạn phải tiếp tục bước đi."
  },
  Event_50286_Name = {
    Text = "Cô đơn Ⅱ"
  },
  Event_50287_ChoiceDesc1 = {Text = "[đi]"},
  Event_50287_Desc = {
    Text = "\"Thân gửi Người Giữ Gìn: \nChúc bạn an lành khi nhận được thư này. \nRất tiếc vì trong chuyến đi Lemvaxi lần này, do không chăm sóc tốt cho thân thể nên tôi không thể luôn bên cạnh bạn. \nNhưng vào những lúc quan trọng, hãy tin tưởng người trợ lý duy nhất của bạn. \nKhi bạn cần tôi, tôi sẽ luôn ở đó.\"\nVì không có đủ thời gian, bạn không thể tiếp tục đọc nữa. \nNhưng chữ viết quen thuộc đã mang lại cho bạn một cảm giác bình yên và an tâm."
  },
  Event_50287_Name = {
    Text = "Lời dặn dò của cô ấy"
  },
  Event_50288_ChoiceDesc1 = {
    Text = "[anh ta sẽ trở lại] nhận được bạc tạo vật [(RelicConfig.Arg1)]"
  },
  Event_50288_ChoiceDesc2 = {
    Text = "[Anh ấy sẽ không đến] nhận được vật tạo vàng \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_50288_Desc = {
    Text = "Người cuối cùng rời đi là Lắc. \n Để ngăn cản Kasia, anh ta đã chọn ở lại trong lều. \n Anh ta từng hứa với bạn rằng sẽ xông vào hiện trường nghi lễ để đốt cây mẹ, anh ta chắc chắn sẽ đi cùng. \n Nhưng bây giờ anh ta vẫn chưa đến bên bạn. \n Chỉ còn lại bạn một mình."
  },
  Event_50288_Name = {
    Text = "Hành trình đơn độc Ⅲ"
  },
  Event_50289_ChoiceDesc1 = {Text = "[đi]"},
  Event_50289_Desc = {
    Text = "Lăn lông lốc, ba vật thể tròn tròn đáng sợ lăn đi trên hiện trường nghi lễ. \nBạn cảm thấy mình không còn là chính mình, bầu không khí điên cuồng và méo mó của nghi lễ kéo bạn vào một khoảng trống vô hình mà khó lòng diễn tả."
  },
  Event_50289_Name = {
    Text = "ba vật tế"
  },
  Event_50290_ChoiceDesc1 = {Text = "[đi]"},
  Event_50290_Desc = {
    Text = "Tín ngưỡng của Á Lan thật sự thành kính, sẵn lòng bị chôn vùi dưới cát vàng lần sau lần nữa. \nNhưng khi bạn ngẩng đầu nhìn lên, trong cơn bão, chẳng thấy ánh mặt trời."
  },
  Event_50290_Name = {
    Text = "Gigante Cát và Bụi"
  },
  Event_50291_ChoiceDesc1 = {Text = "[đi]"},
  Event_50291_Desc = {
    Text = "Nguyện sa mạc đáp lại lòng thành kính của họ."
  },
  Event_50291_Name = {
    Text = "Gigante Cát và Bụi"
  },
  Event_50292_ChoiceDesc1 = {
    Text = "[Giải thoát ký ức] Tăng ngẫu nhiên phẩm chất khắcăng của 1 thẻ bài"
  },
  Event_50292_ChoiceDesc2 = {
    Text = "[Lưu giữ ký ức] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_50292_Desc = {
    Text = "Người thứ hai rời đi là William."
  },
  Event_50292_Name = {
    Text = "Cô đơn Ⅱ"
  },
  Event_50293_ChoiceDesc1 = {
    Text = "[an tâm] nhận được 25 dấu đen"
  },
  Event_50293_ChoiceDesc2 = {
    Text = "[Lo ngại] nhận được bạc sáng tạo \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_50293_Desc = {
    Text = "Bạn đột nhiên nhớ lại ngày đầu tiên bước lên hành trình. \n Ramona nhắc bạn chuẩn bị hành lý, William đã chuẩn bị cho bạn cuốn sổ tay ghi lại hành trình, Lắc lén nhét vào túi bạn một chai Whiskey. \n Bây giờ họ đã rời đi. \n\n Người đầu tiên rời đi là Ramona, sức mạnh của Tà Vy và quyền năng của Tường Bão đã xung đột với nhau, cô ấy đã thất bại trước cơn sốt cao dọc đường."
  },
  Event_50293_Name = {
    Text = "Cô đơn Ⅰ"
  },
  Event_50294_ChoiceDesc1 = {Text = "[đi]"},
  Event_50294_Desc = {
    Text = "Bạn tấn công bất ngờ vào chân của Nubia, khiến nó mất thăng bằng, vài xúc tu dạng dây leo vung vẩy hỗn loạn trong không trung, cuối cùng bị cuốn vào cơn bão bụi."
  },
  Event_50294_Name = {
    Text = "Bão cát tự nhiên"
  },
  Event_50295_ChoiceDesc1 = {
    Text = "[Đọc]Xóa 1 thẻ bài"
  },
  Event_50295_ChoiceDesc2 = {
    Text = "[thu gọn] nhận được \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_50295_Desc = {
    Text = "Cạch cạch. \n Dưới bàn thờ cuồng nhiệt không giống nhân gian này, tiếng trống nặng nề vang vọng theo gió cát. Trong âm thanh ngân nga không dứt, bạn lại nghe thấy tiếng nhẹ nhàng của máy đánh chữ—— đó là tiếng gọi từ Misaque, an ủi tâm hồn bạn đang bất an."
  },
  Event_50295_Name = {
    Text = "Lời dặn dò của cô ấy"
  },
  Event_50296_ChoiceDesc1 = {Text = "[đi]"},
  Event_50296_Desc = {
    Text = "Lắc sở hữu vận may vượt xa thế tục. \nAnh ấy đã hứa với bạn điều gì, nhất định sẽ thực hiện. \nNhất định."
  },
  Event_50296_Name = {
    Text = "Hành trình đơn độc Ⅲ"
  },
  Event_50297_ChoiceDesc1 = {Text = "[đi]"},
  Event_50297_Desc = {
    Text = "Không liên quan đến bạn. \nHiện tại, điều bạn cần nhất là nhanh chóng tiếp xúc và phá hủy di hài của cây mẹ."
  },
  Event_50297_Name = {
    Text = "ba vật tế"
  },
  Event_52373_ChoiceDesc1 = {Text = "[đi]"},
  Event_52373_Desc = {
    Text = "Bạn đã sống sót. Bạn nhìn thấy vô số đống đất được chất đống, những xác thân đang bị thiêu rụi. \n Bạn dường như cũng đã thiêu rụi điều gì đó, nhưng điều đó không còn quan trọng nữa. \n Bạn nghe thấy, tiếng chuông của Thần Quốc đã vang lên."
  },
  Event_52373_Name = {
    Text = "Sự xâm lược của dịch bệnh"
  },
  Event_52374_ChoiceDesc1 = {Text = "[đi]"},
  Event_52374_Desc = {
    Text = "Bạn đã sống sót. Bạn nhìn thấy vô số đống đất được chất đống, những xác thân đang bị thiêu rụi. \n Bạn nỗ lực bảo vệ những điều mà bạn trân trọng, vì điều đó, bạn đã phải trả giá đắt. Nhưng điều đó không còn quan trọng nữa. \n Bạn nghe thấy, tiếng chuông của Thần Quốc đã vang lên."
  },
  Event_52374_Name = {
    Text = "Sự xâm lược của dịch bệnh"
  },
  Event_52375_ChoiceDesc1 = {Text = "[đi]"},
  Event_52375_Desc = {
    Text = "Cơn thịnh nộ của gã khổng lồ tạm thời lắng xuống. Mây tan mưa tạnh, gió êm sóng lặng. Biển cả như một người mẹ vĩnh cửu, nhẹ nhàng vuốt ve lưng Lemuria bằng những con sóng dịu dàng. Chỉ còn lại trên người Lemuria, đầy xác chết và đống đổ nát. \n Bạn nỗ lực bảo vệ những điều mà bạn trân trọng, vì điều đó, bạn đã phải trả giá đắt. Nhưng điều đó không còn quan trọng nữa. \n Trong biển cả, bạn đã nhìn thấy hình dáng của Thần Quốc."
  },
  Event_52375_Name = {
    Text = "Tiếng gầm của đại dương"
  },
  Event_52376_ChoiceDesc1 = {
    Text = "[dâng thêm lễ vật] xóa 1 thẻ lệnh, thêm 3 loại [hình bóng thần quốc] mỗi loại 1 thẻ vào bộ bài."
  },
  Event_52376_Desc = {
    Text = "Đứng trước ngai vàng của Lemuria sụp đổ, bạn dâng lên lễ vật cuối cùng. \n Vực thẳm vô tận hiện ra trước mắt bạn. Bạn quỳ gối, mỉm cười, nước mắt tràn đầy. \n \"Nhìn kìa, cha ơi, Đêbôra. Nhìn kìa, vị vua tối cao của tôi—Thần Quốc, đã đến trước mặt tôi!\""
  },
  Event_52376_Name = {
    Text = "Chào đón, thần quốc"
  },
  Event_52377_ChoiceDesc2 = {
    Text = "[Bảo vệ vật quý] mất Arg1 sức sống, nhận 1 thẻ triệu chứng ngẫu nhiên."
  },
  Event_52377_Desc = {
    Text = "Đất. Đất im lặng, đất ổn định. Đất mang con người, đất vĩnh cửu bất diệt. Nhưng đất đang run rẩy. Nó nứt ra những vết nứt sâu thẳm, mọi thứ được nâng đỡ đều đang goyang-goyang. \n Bạn đặt mọi hy vọng vào đất, khi đất bắt đầu rung chuyển, bạn sẽ đi đâu? \n Hãy hiến tế, dân chúng Lemuria đang gọi bạn. Hiến tế tất cả những gì bạn có, để Thần Quốc không tai ương đến."
  },
  Event_52377_Name = {
    Text = "Sự rung động của đất đai"
  },
  Event_52378_ChoiceDesc2 = {
    Text = "[Bảo vệ vật quý] mất Arg1 sức sống, nhận 1 thẻ triệu chứng ngẫu nhiên."
  },
  Event_52378_Desc = {
    Text = "Biển. Biển là người mẹ mang thai Lemuria, là cuộc sống của bạn, là niềm tin của bạn. Và lúc này, biển đứng dậy như một vị thần khổng lồ giận dữ trong truyền thuyết. Ngài gào thét, kêu gọi, biến nước biển ấm áp thành những tảng đá cứng và mũi nhọn, vung về phía mọi thứ trước mặt. Ngài lạnh lùng nhìn xuống Lemuria đang run rẩy dưới chân, nhìn xuống những người Lemuria như côn trùng hoảng sợ. Ngài sẽ hủy diệt Lemuria, điều này không liên quan đến Lemuria. \n Hiến tế đi, những con dân của Lemuria đang gọi bạn. Hiến tế tất cả mọi thứ của bạn, để Thần Quốc không có tai ương hạ xuống."
  },
  Event_52378_Name = {
    Text = "Tiếng gầm của đại dương"
  },
  Event_52379_ChoiceDesc2 = {
    Text = "[Bảo vệ vật quý] mất Arg1 sức sống, nhận 1 thẻ triệu chứng ngẫu nhiên."
  },
  Event_52379_Desc = {
    Text = "Dịch bệnh. Dịch bệnh hiện diện khắp nơi. Dịch bệnh là người hầu hạ vô sỉ nhất, khi sự trừng phạt của thần với đất và biển qua đi, nó sẽ thay thần tuyên án những cái chết không thể nói ra. Chôn cất xác của người thân, thiêu đốt xác của người thân, cầu nguyện cho những người thân yêu đã chết để bảo vệ bản thân, càng xa mình càng tốt. Sinh mệnh và nhân tính, trước dịch bệnh không thể chống đỡ. \n Hiến tế đi, dân tộc Lemuria đang gọi bạn. Hiến tế tất cả những gì bạn có, để Thần Quốc không có tai ương đến."
  },
  Event_52379_Name = {
    Text = "Sự xâm lược của dịch bệnh"
  },
  Event_52380_ChoiceDesc1 = {Text = "[đi]"},
  Event_52380_Desc = {
    Text = "Cú chấn động mạnh mẽ đã lắng xuống. Trên đường phố nhuốm màu máu đỏ thẫm, vô số người bị chôn vùi dưới những ngôi nhà đổ nát. \n Bạn nỗ lực bảo vệ những điều mà bạn trân trọng, vì điều đó, bạn đã phải trả giá đắt. Nhưng điều đó không còn quan trọng nữa. \n Điều quan trọng duy nhất là, bạn đã tiến gần hơn một bước đến Thần Quốc."
  },
  Event_52380_Name = {
    Text = "Sự rung động của đất đai"
  },
  Event_52381_ChoiceDesc1 = {Text = "[đi]"},
  Event_52381_Desc = {
    Text = "Đứng trước ngai vàng của Lemuria sụp đổ, bạn xướng lên lời cầu nguyện cuối cùng. \n Vực thẳm vô tận hiện ra trước mắt bạn. Bạn quỳ gối, mỉm cười, nước mắt tràn đầy. \n \"Nhìn kìa, cha ơi, Đêbôra. Nhìn kìa, vị vua tối cao của tôi—Thần Quốc, đã đến trước mặt tôi!\""
  },
  Event_52381_Name = {
    Text = "Chào đón, thần quốc"
  },
  Event_52382_ChoiceDesc1 = {Text = "[đi]"},
  Event_52382_Desc = {
    Text = "Cú chấn động mạnh mẽ đã lắng xuống. Trên đường phố nhuốm màu máu đỏ thẫm, vô số người bị chôn vùi dưới những ngôi nhà đổ nát. \n Dường như một thứ gì đó của bạn cũng đã bị chôn vùi dưới đống đổ nát, nhưng điều đó không còn quan trọng nữa. \n Điều quan trọng duy nhất là, bạn đã tiến gần hơn một bước đến Thần Quốc."
  },
  Event_52382_Name = {
    Text = "Sự rung động của đất đai"
  },
  Event_52383_ChoiceDesc1 = {Text = "[đi]"},
  Event_52383_Desc = {
    Text = "Cơn giận của người khổng lồ tạm thời đã tiêu tan. Mây tan mưa tạnh, gió lặng sóng yên. Biển cả như người mẹ vĩnh cửu, nhẹ nhàng vuốt ve lưng của Lemuria bằng những con sóng dịu dàng. Chỉ còn lại trên thân thể của Lemuria, những xác chết và đống đổ nát đầy tàn tích. \nMột thứ gì đó của bạn dường như đã chôn vùi dưới đại dương, nhưng điều đó đã trở nên không quan trọng. \nTrong biển cả, bạn đã nhìn thấy hình dáng của Thần Quốc."
  },
  Event_52383_Name = {
    Text = "Tiếng gầm của đại dương"
  },
  Event_52384_ChoiceDesc1 = {
    Text = "[cầu nguyện thành tâm] sẽ biến mỗi 1 lá thẻ triệu chứng thông thường trong bộ bài thành 1 lá \"hình bóng thần quốc\" và nhận thêm 2 lá \"hình bóng thần quốc\"."
  },
  Event_52384_ChoiceDesc2 = {
    Text = "[cầu nguyện thành tâm] sẽ biến mỗi 1 lá thẻ triệu chứng thông thường trong bộ bài thành 1 lá \"hình bóng thần quốc\" và nhận thêm 2 lá \"hình bóng thần quốc\"."
  },
  Event_52384_Desc = {
    Text = "Đất không còn run rẩy, biển không còn ầm ầm, dịch bệnh không còn xâm lấn. Thiên tai đã hủy diệt Lemuria, để lại bạn. Bạn ngẩng đầu nhìn xung quanh, mọi thứ đều tàn tạ. Bạn cúi đầu nhìn vào đôi tay, trống rỗng. \n Nhưng điều đó thì sao, linh mục trưởng kính mến? Dẫm lên đống đổ nát và xác chết của Lemuria, hãy tiếp tục bò về phía trước. \n Bạn chỉ còn một bước cách đến Thần Quốc."
  },
  Event_52384_Name = {
    Text = "Chào đón, thần quốc"
  },
  Event_53140_ChoiceDesc1 = {Text = "[đi]"},
  Event_53140_Desc = {
    Text = "Bạn đã nhận được yêu cầu liên lạc từ trường, giọng nói quen thuộc giúp tâm trạng bạn bình yên lại. Bạn lấy lại tinh thần và tiếp tục tiến lên."
  },
  Event_53140_Name = {
    Text = "điểm liên lạc"
  },
  Event_53141_ChoiceDesc1 = {
    Text = "[Kết nối] phục hồi Arg2 điểm sức sống."
  },
  Event_53141_ChoiceDesc2 = {
    Text = "[Thiền định] Chọn 1 thân thể được đánh thức để tiến hành thức tỉnh."
  },
  Event_53141_ChoiceDesc3 = {
    Text = "[Trục xuất] Loại bỏ tối đa 3 thẻ triệu chứng, nhận Arg2 dấu đen."
  },
  Event_53141_ChoiceDesc4 = {
    Text = "[Điên rồ] Ngẫu nhiên thức tỉnh 2 thân thể được đánh thức, nhận được 1 lá triệu chứng ngẫu nhiên"
  },
  Event_53141_ChoiceDesc5 = {
    Text = "[do dự] khác"
  },
  Event_53141_Desc = {
    Text = "Bạn đang khám phá trong sương mù, đột nhiên, huy hiệu trường trên ngực bạn phát ra ánh sáng bạc yếu ớt. Ai đang gọi bạn từ bên kia thiết bị liên lạc?"
  },
  Event_53141_Name = {
    Text = "điểm liên lạc"
  },
  Event_53141_Tips3 = {
    Text = "Hiện tại không sở hữu thẻ triệu chứng"
  },
  Event_53142_ChoiceDesc1 = {Text = "[đi]"},
  Event_53142_Desc = {
    Text = "Bạn đã nhận được yêu cầu liên lạc từ trường, giọng nói quen thuộc giúp tâm trạng bạn bình yên lại. Bạn lấy lại tinh thần và tiếp tục tiến lên."
  },
  Event_53142_Name = {
    Text = "điểm liên lạc"
  },
  Event_53143_ChoiceDesc1 = {Text = "[đi]"},
  Event_53143_Desc = {
    Text = "Bạn đã nhận được yêu cầu liên lạc từ trường, giọng nói quen thuộc giúp tâm trạng bạn bình yên lại. Bạn lấy lại tinh thần và tiếp tục tiến lên."
  },
  Event_53143_Name = {
    Text = "điểm liên lạc"
  },
  Event_53147_ChoiceDesc1 = {
    Text = "[Trục xuất] Loại bỏ tối đa 3 thẻ triệu chứng, nhận Arg2 dấu đen."
  },
  Event_53147_ChoiceDesc2 = {
    Text = "[Điên rồ] Ngẫu nhiên thức tỉnh 2 thân thể được đánh thức, nhận được 1 lá triệu chứng ngẫu nhiên"
  },
  Event_53147_Desc = {
    Text = "Bạn đang khám phá trong sương mù, đột nhiên, huy hiệu trường trên ngực bạn phát ra ánh sáng bạc yếu ớt. Ai đang gọi bạn từ bên kia thiết bị liên lạc?"
  },
  Event_53147_Name = {
    Text = "điểm liên lạc"
  },
  Event_53147_Tips1 = {
    Text = "Hiện tại không sở hữu thẻ triệu chứng"
  },
  Event_53148_ChoiceDesc1 = {Text = "[đi]"},
  Event_53148_Desc = {
    Text = "Bạn đã kết nối thông tin. Từ đầu bên kia của thiết bị truyền tin vang lên một giọng điên rồ, khiến bạn mê mẩn. \n\"Hãy ghi nhớ. Đây là ân huệ mà thần quốc ban cho bạn.\""
  },
  Event_53148_Name = {
    Text = "điểm liên lạc"
  },
  Event_55782_ChoiceDesc1 = {
    Text = "[Cắt đứt gai góc] Trận chiến tiếp theo, sức sống kẻ địch tăng 30%, thương tăng 15%, nhận Arg1 lá ý tượng [(Skill.Arg2)]."
  },
  Event_55782_ChoiceDesc2 = {
    Text = "[Cắt đứt gai góc] Trận chiến tiếp theo, sức sống kẻ địch tăng 30%, thương tăng 15%, nhận Arg1 lá ý tượng [(Skill.Arg2)]."
  },
  Event_55782_ChoiceDesc3 = {
    Text = "[Gỡ bỏ bụi gai] nhiễm \"(Skill.Arg3)\", thêm Arg1 lá bài ấn tượng \"(Skill.Arg2)\" vào bộ bài."
  },
  Event_55782_ChoiceDesc4 = {
    Text = "[Gỡ bỏ bụi gai] nhiễm \"(Skill.Arg3)\", thêm Arg1 lá bài ấn tượng \"(Skill.Arg2)\" vào bộ bài."
  },
  Event_55782_ChoiceDesc5 = {
    Text = "[Rời khỏi Gai góc]\"Bút và Mực của Ôrla\" nhận được Arg1 tầng \"Bút Mực\"."
  },
  Event_55782_Desc = {
    Text = "Một thứ gì đó chạm vào tâm hồn bạn. Bạn dừng lại, nhìn về góc vườn. Dưới những lớp gai, một điểm sáng đang nhảy múa, cố gắng thoát khỏi sự hạn chế. \nĐó là gì? Bướm? Chim bay? Bạn tiến lại gần nó."
  },
  Event_55782_Name = {
    Text = "Phước lành của muzu"
  },
  Event_55782_Tips1 = {
    Text = "Trận chiến tiếp theo kẻ địch đã được tăng cường, không thể chọn lại"
  },
  Event_55783_ChoiceDesc1 = {
    Text = "[Sáng tác thơ dâng] Chọn 3 thẻ \"Ý tượng\", để Ôrla sáng tác \"thơ dâng\" cho bạn."
  },
  Event_55783_ChoiceDesc2 = {Text = "[đi]"},
  Event_55783_Desc = {
    Text = "Bạn đến trước một nhà hoa xinh đẹp, nhìn qua cửa sổ, bạn ngó vào trong nhà hoa, nhưng không thấy gì cả. \n Một cơn gió thổi qua, những cánh hoa và lá trong nhà hoa bị gió cuốn lên, bay lượn và tụ lại trong không trung. Trong hoa và lá, bạn thấy bóng dáng của một cô gái. \n \"À! Trong vườn hoa có khách đến!\" Cô gái ngạc nhiên và hồi hộp nhìn bạn. \"Xin lỗi, Colette đã ra ngoài... Nếu mua hoa, tôi không rõ giá của những bông hoa này...\" \n Cô gái đột nhiên dừng lại, lại gần bạn và nhìn bạn vài lần. \"À, vị khách này, tôi cảm nhận được hình ảnh của thơ ca trên người bạn... Có lẽ, chúng ta có thể cùng sáng tác một bài thơ?\""
  },
  Event_55783_Name = {
    Text = "Quà tặng mùa xuân"
  },
  Event_55783_Tips1 = {
    Text = "\"Ý Tượng\" số lượng không đủ 3, không thể tổng hợp"
  },
  Event_55799_ChoiceDesc1 = {Text = "[đi]"},
  Event_55799_Desc = {
    Text = "Những cây gai sống lại dường như có phần xao động, nhưng những cái giá này không đáng kể —— tại điểm sáng đó, bạn nghe thấy tiếng gọi của nàng thơ."
  },
  Event_55799_Name = {
    Text = "Phước lành của muzu"
  },
  Event_55819_ChoiceDesc1 = {
    Text = "[thích ứng với ký ức của thân thể] bỏ qua trận chiến và chiến thắng ngay lập tức, nhưng mất Arg1 điểm sức sống."
  },
  Event_55819_ChoiceDesc2 = {
    Text = "[rời đi] vào chiến đấu"
  },
  Event_55819_Desc = {
    Text = "Đối mặt với kẻ địch quen thuộc, bạn đã hiểu rõ về trận chiến sắp tới."
  },
  Event_55819_Name = {
    Text = "bộ nhớ cơ bắp"
  },
  Event_55997_ChoiceDesc1 = {Text = "[đi]"},
  Event_55997_Desc = {
    Text = "Từ những hình ảnh đã thu thập, bạn chọn ra một vài cái, đưa vào tay cô gái. \n \"Hình ảnh thật đẹp! Khách quý, xin chờ một chút… Đây. Đây là bài thơ dâng mà mùa xuân mang đến, chỉ thuộc về bạn!\" \n Một bài thơ xuất hiện trong tay bạn, như hoa nở chỉ dành riêng cho bạn. \n Bạn muốn cảm ơn cô gái. Nhưng khi bạn ngẩng đầu lên, hình dáng cô ấy đã biến mất. Trong căn phòng hoa cô đơn, chỉ còn lại những bông hoa và lá khô héo đầy đất. \n —— Đó là tro tàn còn sót lại sau khi mùa xuân đã tàn."
  },
  Event_55997_Name = {
    Text = "Quà tặng mùa xuân"
  },
  Event_55999_ChoiceDesc1 = {Text = "[đi]"},
  Event_55999_Desc = {
    Text = "Những gai góc dày đặc khiến bạn do dự. Bạn đã rời bỏ điểm sáng, nhưng cái nhìn ngắn ngủi vừa rồi vẫn làm lòng bạn tràn ngập cảm hứng mới —— tại điểm sáng đó, bạn đã nghe thấy tiếng gọi của Muses."
  },
  Event_55999_Name = {
    Text = "Phước lành của muzu"
  },
  Event_56000_ChoiceDesc1 = {Text = "[đi]"},
  Event_56000_Desc = {
    Text = "Bạn dùng tay gạt bỏ những bụi gai, vì thế bạn đã chịu một vài vết thương, nhưng những cái giá này không đáng kể—— tại điểm sáng ấy, bạn nghe thấy tiếng gọi của nàng thơ."
  },
  Event_56000_Name = {
    Text = "Phước lành của muzu"
  },
  Event_56024_ChoiceDesc1 = {Text = "[đi]"},
  Event_56024_Desc = {
    Text = "Vẫn chưa đủ… Bạn tiếp tục tiến gần đến điểm sáng đó. Những bụi gai đã bị kích thích, lộ ra những chiếc gai sắc nhọn về phía bạn. Nhưng mọi thứ đều xứng đáng. \n Điểm sáng đó tỏa ra từ lòng bàn tay bạn, trong màn ánh sáng trải rộng, bạn cảm nhận rõ ràng sự phước lành của nàng thơ Muse."
  },
  Event_56024_Name = {
    Text = "Phước lành của muzu"
  },
  Event_56025_ChoiceDesc1 = {
    Text = "[Gần điểm sáng] Trong trận chiến tiếp theo, sức sống địch tăng thêm 30%, thương tăng thêm 15%, có thể chọn nâng cấp 1 [Ý Tượng]."
  },
  Event_56025_ChoiceDesc2 = {Text = "[đi]"},
  Event_56025_Desc = {
    Text = "Bạn dùng công cụ bên mình chặt đứt những gai góc. Những gai góc sống dậy dường như có chút bồn chồn, nhưng những cái giá này không đáng kể —— trên điểm sáng đó, bạn nghe thấy tiếng gọi của nàng thơ Muse."
  },
  Event_56025_Name = {
    Text = "Phước lành của muzu"
  },
  Event_56146_ChoiceDesc1 = {Text = "[đi]"},
  Event_56146_Desc = {
    Text = "Vẫn chưa đủ… Bạn tiếp tục tiến gần đến điểm sáng đó. Những chiếc gai sắc nhọn đã cắt đứt bàn tay bạn, khiến máu chảy không ngừng. Nhưng mọi thứ đều xứng đáng. \n Điểm sáng đó tỏa ra từ lòng bàn tay bạn, trong màn ánh sáng trải rộng, bạn cảm nhận rõ ràng sự phước lành của nàng thơ Muse."
  },
  Event_56146_Name = {
    Text = "Phước lành của muzu"
  },
  Event_56147_ChoiceDesc1 = {
    Text = "[Impulse Sáng tạo] Tất cả các thân thể được đánh thức mất hết điên cuồng, chọn 3 thẻ \"Ý tượng\", để Ôrla sáng tác \"Thơ dâng\"."
  },
  Event_56147_ChoiceDesc2 = {Text = "[đi]"},
  Event_56147_Desc = {
    Text = "Bạn đã nhận được yêu cầu liên lạc từ trường, giọng nói quen thuộc giúp tâm trạng bạn bình yên lại. Bạn lấy lại tinh thần và tiếp tục tiến lên."
  },
  Event_56147_Name = {
    Text = "điểm liên lạc"
  },
  Event_56147_Tips1 = {
    Text = "\"Ý Tượng\" số lượng không đủ 3, không thể tổng hợp"
  },
  Event_56148_ChoiceDesc1 = {Text = "[đi]"},
  Event_56148_Desc = {
    Text = "Ánh bạc trên huy hiệu khiến lòng bạn dâng trào cảm xúc. Theo sự hướng dẫn từ trái tim, bạn ném vật trong tay vào bụi gai. Ánh sáng dưới bụi gai bắt đầu lấp lánh —— trong ánh sáng đó, bạn đã lĩnh hội được nguồn cảm hứng mới."
  },
  Event_56148_Name = {
    Text = "điểm liên lạc"
  },
  Event_56149_ChoiceDesc1 = {
    Text = "[Tiếp cận điểm sáng] giảm 10% sức sống tối đa, có thể chọn một [ý tượng] để nâng cấp."
  },
  Event_56149_ChoiceDesc2 = {Text = "[đi]"},
  Event_56149_Desc = {
    Text = "Bạn dùng tay gạt bỏ những bụi gai, vì thế bạn đã chịu một vài vết thương, nhưng những cái giá này không đáng kể—— tại điểm sáng ấy, bạn nghe thấy tiếng gọi của nàng thơ."
  },
  Event_56149_Name = {
    Text = "Phước lành của muzu"
  },
  Event_56149_Tips1 = {
    Text = "Không có \"ý tượng\" nào có thể nâng cấp"
  },
  Event_56150_ChoiceDesc1 = {Text = "[đi]"},
  Event_56150_Desc = {
    Text = "Ánh bạc trên huy hiệu khiến bạn cảm thấy lòng dâng trào. Bạn cảm thấy một sự thôi thúc mạnh mẽ, viết ra những câu thơ hiện trong tâm trí."
  },
  Event_56150_Name = {
    Text = "điểm liên lạc"
  },
  Event_56151_ChoiceDesc1 = {
    Text = "[cảm hứng mới] Chọn 1 lá \"ý tưởng\"để loại bỏ, nâng cấp ngẫu nhiên 1 lá \"ý tưởng\"."
  },
  Event_56151_ChoiceDesc2 = {Text = "[đi]"},
  Event_56151_Desc = {
    Text = "Bạn đã nhận được yêu cầu liên lạc từ trường, giọng nói quen thuộc giúp tâm trạng bạn bình yên lại. Bạn lấy lại tinh thần và tiếp tục tiến lên."
  },
  Event_56151_Name = {
    Text = "điểm liên lạc"
  },
  Event_56151_Tips1 = {
    Text = "Hiện tại không có thẻ \"Ý Tượng\""
  },
  Event_57738_ChoiceDesc1 = {
    Text = "[Xông vào] tất cả các thân thể được đánh thức nhận được 30 điểm điên cuồng, nhưng thêm hai lá [(Skill.Arg1)] vào bộ bài"
  },
  Event_57738_ChoiceDesc2 = {
    Text = "[giải vũ khí] trận chiến tiếp theo sức sống địch tăng 60%, thương tăng 30%."
  },
  Event_57738_ChoiceDesc3 = {
    Text = "[Phục kích] tiêu thụ tất cả điên cuồng của thân thể được đánh thức, nhận được 30 dấu đen và xóa bỏ đe dọa từ lính canh."
  },
  Event_57738_Desc = {
    Text = "Bạn nhìn ra ngoài từ vùng mù trong tầm nhìn ở góc khuất. Các điệp viên của hội nghị thẩm tra đang theo dõi một hướng khác và không hề chú ý đến sự hiện diện của các bạn. \n Những hình ảnh của quá trình huấn luyện trước đây lần lượt hiện lên trong tâm trí bạn, và bạn nhanh chóng nghĩ ra cách xử lý phù hợp với kẻ địch chặn đường đi của bạn."
  },
  Event_57738_Name = {
    Text = "Điệp viên hội nghị thẩm tra"
  },
  Event_57738_Tips3 = {
    Text = "Hiện tại tất cả các thân thể được đánh thức chưa xuất hiện điên cuồng"
  },
  Event_57739_ChoiceDesc1 = {Text = "[đi]"},
  Event_57739_Desc = {
    Text = "Bạn đang quan sát cẩn thận. Các điệp viên của hội nghị thẩm tra chặn ở con đường mà các bạn phải đi qua, đang nghiêm túc theo dõi khu vực trước mặt bạn. \n Đối mặt với số lượng địch đông đảo, bạn không thể đối đầu với họ. \n Tiến hay lùi?"
  },
  Event_57739_Name = {
    Text = "Điểm giam giữ"
  },
  Event_57776_ChoiceDesc1 = {Text = "[đi]"},
  Event_57776_ChoiceDesc2 = {
    Text = "[Giả hàng] Sau khi khám phá khu vực này, truyền tống đến điểm giam giữ, nhận được 2 thẻ [triệu chứng] ngẫu nhiên."
  },
  Event_57776_ChoiceDesc3 = {
    Text = "[xâm nhập] Sau khi khám phá khu vực này, truyền đến điểm giam giữ, mất Arg1 điểm sức sống."
  },
  Event_57776_Desc = {
    Text = "Bạn đang quan sát cẩn thận. Các điệp viên của hội nghị thẩm tra chặn trên con đường tất yếu của các bạn, đang chăm chú theo dõi khu vực trước mặt bạn. \n Đối mặt với số lượng địch đông đảo, bạn không thể đối đầu với họ. \n Tiến lên hay lùi lại?"
  },
  Event_57776_Name = {
    Text = "Điểm giám sát"
  },
  Event_57776_Tips3 = {
    Text = "Sức sống hiện tại thiếu"
  },
  Event_59193_ChoiceDesc1 = {
    Text = "[Alistair's Blessing] Thêm một lá [Ánh sáng cực dạ]vào bộ bài."
  },
  Event_59193_Desc = {
    Text = "Giấy chứng nhận nhập học này luôn được bạn đặt ở đáy vali, bạn vuốt ve khung viền tinh xảo như được phủ ánh sao, hít nhẹ hương mực nhạt nhòa đặc trưng của giấy, huy hiệu Misaque dường như là cánh cửa ánh sáng dẫn vào tương lai, thu hút đôi mắt khao khát của bạn —— như ngày đó, như hôm nay."
  },
  Event_59193_Name = {
    Text = "Lễ nhập học"
  },
  Event_59527_ChoiceDesc1 = {
    Text = "Chọn một thẻ bài để lĩnh hội khắc ấn \"Lý Trí Thức\".\"Lý Trí Thức\":Sau khi đánh ra, rút 2 lá bài, tiêu hao sức tính toán của chúng giảm đi bằng sức tính toán thực tế tiêu hao của thẻ khắc ấn, mỗi trận chỉ có hiệu lực 1 lần."
  },
  Event_59527_Desc = {
    Text = "Dấu hiệu tượng trưng cho trí tuệ được khắcăng trên giấy tờ của bạn. \nNhững suy nghĩ của Tà Vy hòa nhập vào tâm trí bạn. Giữa vô vàn khả năng, bạn đang bước đi trên con đường đúng đắn duy nhất."
  },
  Event_59527_Name = {
    Text = "Lễ nhập học"
  },
  Event_59528_ChoiceDesc1 = {
    Text = "Chọn một thẻ bài để lĩnh hội khắc ấn \"Lý Hoan Lạc\".\"Lý Hoan Lạc\":Sau khi đánh ra, bỏ tất cả thẻ bài ngoài thể thức tỉnh thức đó, nhận 5 thẻ bài ngẫu nhiên không phải thể thức tỉnh thức, mỗi trận chỉ có hiệu lực 1 lần."
  },
  Event_59528_Desc = {
    Text = "Dấu hiệu tượng trưng cho niềm vui được khắcăng trên giấy tờ của bạn. \nQua dấu ấn, N đang đánh giá bạn. Người ấy mong đợi, bạn sẽ mang lại kết cục mà Người chưa từng hứa hẹn."
  },
  Event_59528_Name = {
    Text = "Lễ nhập học"
  },
  Event_59529_ChoiceDesc1 = {
    Text = "Chọn một thẻ bài để lĩnh hội khắc ấn \"Lý Sinh Sản\".\"Lý Sinh Sản\":Sau khi đánh ra, nhận 3 bản sao gốc có gắn \"Giữ lại\" và\"Tiêu hao\", mỗi trận chỉ có hiệu lực 1 lần."
  },
  Event_59529_Desc = {
    Text = "Dấu hiệu tượng trưng cho sự sinh sản được khắcăng trên giấy tờ của bạn. \nThái Di Sơ đặt hy vọng vào bạn, cùng bạn cộng sinh trong mọi thế giới."
  },
  Event_59529_Name = {
    Text = "Lễ nhập học"
  },
  Event_59566_ChoiceDesc1 = {
    Text = "[Lau nước mắt máu] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: [(EnchantConfig.Arg1)]"
  },
  Event_59566_ChoiceDesc2 = {
    Text = "[Kiên trì mở mắt] Ngẫu nhiên 3 thẻ lệnh nhận được khắcăng: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_59566_Desc = {
    Text = "Vô số ước nguyện của bạn hợp nhất thành một, trước đây các bạn từng có chung một nguồn gốc, bây giờ các bạn cùng sở hữu một cơ thể. \n Vô số đôi mắt cùng mở ra, để đối diện với con ngươi khổng lồ kia. \n Vô số đôi mắt cùng vỡ tan, rơi lệ máu khô đau đớn."
  },
  Event_59566_Name = {
    Text = "Fusion của tôi"
  },
  Event_59567_ChoiceDesc1 = {Text = "[đi]"},
  Event_59567_Desc = {
    Text = "Bạn cố gắng tranh luận với âm thanh điên rồ đó, phản bác lại ý tưởng hư vô. \n\"Mọi thứ đều sẽ dẫn đến cái chết, phải chăng chính sự sống lại không có ý nghĩa gì sao?\" \n Bạn biện luận một cách lý lẽ, tuy nhiên tiếng cười đó không hề giảm bớt, như thể đang chế nhạo sự ngu ngốc của bạn."
  },
  Event_59567_Name = {
    Text = "Con cừu chờ chết"
  },
  Event_59568_ChoiceDesc1 = {Text = "[đi]"},
  Event_59568_Desc = {
    Text = "Bạn nhìn chằm chằm vào cánh cửa đó, không muốn chịu đựng thêm nỗi đau của sự ngu dốt. \n Bạn muốn thấy cảnh tượng phía sau cánh cửa. \n Cánh cửa ảo ảnh đang lay động một cách mê hoặc, bạn nhìn thấy vô số bóng dáng của các thế giới lướt qua. \n Không kịp nhìn rõ, vô vàn thông tin đã đổ ập vào tâm trí bạn, não bộ bạn tràn ngập những tiếng ồn hỗn loạn."
  },
  Event_59568_Name = {
    Text = "Sau cánh cửa"
  },
  Event_59569_ChoiceDesc1 = {
    Text = "[Chỉ huy kiên định] ngẫu nhiên thức tỉnh 1 cơ thể tỉnh thức, bị nhiễm [(Skill.Arg1)]"
  },
  Event_59569_ChoiceDesc2 = {
    Text = "[Thương lượng chung] Từ 3 thẻ lệnh chọn 1 thẻ để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_59569_Desc = {
    Text = "Tất cả xảy ra thật đột ngột, bạn cảm thấy xung quanh bao trùm bởi một làn sương mù mờ ảo, bạn cố gắng nhìn xung quanh nhưng không thấy gì rõ ràng. \n Các thể thức tỉnh đang chờ lệnh từ bạn. \n Bây giờ bạn cô lập và không có sự giúp đỡ, chỉ có thể dựa vào lực lượng của chính mình."
  },
  Event_59569_Name = {
    Text = "Mắt Vô Tri"
  },
  Event_59570_ChoiceDesc1 = {
    Text = "[để hy sinh] nhận được vật bị nguyền rủa \"(RelicConfig.Arg1)\", bị nhiễm \"(Skill.Arg2)\""
  },
  Event_59570_ChoiceDesc2 = {
    Text = "[Bằng lòng dũng cảm] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: [(EnchantConfig.Arg1)]"
  },
  Event_59570_ChoiceDesc3 = {
    Text = "[Thẳng thắn nhìn] nhận được 50 dấu đen"
  },
  Event_59570_Desc = {
    Text = "Vô số bạn đứng trong vô số thế giới, vai kề vai, tay nắm tay, như thể là anh chị em thân thiết. \n Bây giờ các bạn cùng đứng dưới cái bóng khổng lồ đó, ngẩng đầu lên, không lùi nửa bước. \n Phải làm gì? \n Phải làm gì để đánh bại cái tôi cuối cùng đó?"
  },
  Event_59570_Name = {
    Text = "Câu trả lời của tôi"
  },
  Event_59571_ChoiceDesc1 = {
    Text = "[Tìm câu trả lời] nhận Arg1 dấu đen, bị lây nhiễm [(Skill.Arg2)], tiếp tục chọn"
  },
  Event_59571_ChoiceDesc2 = {
    Text = "[bỏ cuộc] nhận được 25 dấu đen, rời đi"
  },
  Event_59571_Desc = {
    Text = "Qua ảo ảnh của cánh cửa, vô số điều bạn đã trải qua lướt qua trong tâm trí bạn. \n Họ có người đã chết, có người điên cuồng, có người kiên trì, có người sa ngã. \n Vô số con đường, vô số sự lựa chọn hiện lên trước mắt bạn, bạn như thể trong chốc lát đã sống qua một cuộc đời dài dằng dặc. \n Giờ đây, vô số bộ não, vô số cái miệng cùng vận hành. \n Bạn cố gắng vượt qua thời gian và không gian để trò chuyện với vô số phiên bản của chính mình, vớt vát câu trả lời từ những ký ức vô tận."
  },
  Event_59571_Name = {
    Text = "Câu tự vấn của tôi"
  },
  Event_59572_ChoiceDesc1 = {
    Text = "[đổi chỗ lực lượng] 1 thẻ lệnh ngẫu nhiên nhận được khắcăng:[(EnchantConfig.Arg1)]"
  },
  Event_59572_ChoiceDesc2 = {
    Text = "[đổi chỗ may mắn] Tăng Arg1 điểm máu tối đa, lây nhiễm [(Skill.Arg2)]"
  },
  Event_59572_Desc = {
    Text = "Tất cả các lựa chọn đều có cái giá. \n Sinh lực, tinh thần, cảm xúc, ký ức… \n Bạn muốn trao đổi điều gì với số phận, và chọn đặt điều gì lên bàn cân?"
  },
  Event_59572_Name = {
    Text = "Lựa chọn vận mệnh"
  },
  Event_59573_ChoiceDesc1 = {Text = "[đi]"},
  Event_59573_Desc = {
    Text = "Người sao có thể không có trái tim chứ? \nBạn hoảng loạn tìm kiếm xung quanh, hơi thở của bạn dần trở nên gấp gáp, nỗi sợ cái chết bao trùm tâm trí bạn. \n\"Không thở được nữa... nhịp tim sắp ngừng lại rồi…\" \nChờ đã, hình như bạn không còn cần nhịp tim nữa. \nBạn bừng tỉnh và vui vẻ cười lên."
  },
  Event_59573_Name = {
    Text = "Rongga ngực"
  },
  Event_59574_ChoiceDesc1 = {
    Text = "[Trực diện] nhận được vật tạo vàng \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_59574_ChoiceDesc2 = {
    Text = "[trốn tránh] ngẫu nhiên thức tỉnh 2 thân thể được đánh thức, áp dụng hiệu ứng hai lần [(Skill.Arg1)]"
  },
  Event_59574_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 50 dấu đen"
  },
  Event_59574_Desc = {
    Text = "Bạn cảm thấy có một sự tồn tại nào đó trong hư không đang dõi theo bạn. \nDù bạn đi đâu, ánh nhìn ấy vẫn luôn đeo bám không rời. \nBạn cảm thấy mình giống như con mồi nhỏ bé, lưng bạn bắt đầu nhói đau như bị kim châm."
  },
  Event_59574_Name = {
    Text = "Ánh mắt của Ngài"
  },
  Event_59575_ChoiceDesc1 = {Text = "[đi]"},
  Event_59575_Desc = {
    Text = "Bạn không bị lay chuyển trong sự điên cuồng của bản diễn tấu, luôn kiên trì giữ nhịp điệu của riêng mình. \n Cuộc tấn công và cám dỗ từ đối phương không có hiệu quả với bạn, trên cây đàn piano đang chơi hai giai điệu cùng lúc, ai kiên trì đến cùng, người đó sẽ điều khiển tất cả các nốt nhạc."
  },
  Event_59575_Name = {
    Text = "Bài hát tiệc ngày tận thế"
  },
  Event_59576_ChoiceDesc1 = {Text = "[đi]"},
  Event_59576_Desc = {
    Text = "Bạn lấy hết can đảm, dù phải đối mặt với điều gì, bạn cũng sẽ cùng đồng đội sát cánh đi tiếp."
  },
  Event_59576_Name = {
    Text = "Tương lai đóng băng"
  },
  Event_59577_ChoiceDesc1 = {Text = "[đi]"},
  Event_59577_Desc = {
    Text = "\"Bây giờ bạn đang ở đâu?\"\n\"Các thầy cô có kế hoạch gì?\"\n\"Tôi tiếp theo nên làm gì?\"\nBạn cấp bách truy hỏi, muốn như mọi khi dựa dẫm vào sự tồn tại đáng tin cậy đó.\nMáy liên lạc như bị đơ, mất đi phản ứng, bạn lắc lắc cái máy, trong lúc lắc lư, chữ viết trên bức thư biến dạng thành một đàn bướm, ào ào bay vào mặt bạn.\nBạn dụi mắt, nhận ra mọi thứ chỉ là ảo giác của bạn.\nTrên tờ giấy phản hồi không có một chữ."
  },
  Event_59577_Name = {
    Text = "Gema Hipnotis"
  },
  Event_59578_ChoiceDesc1 = {
    Text = "[hoảng hốt tìm kiếm] nâng cao Arg1 điểm máu tối đa"
  },
  Event_59578_ChoiceDesc2 = {
    Text = "[Thử lấp đầy] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_59578_Desc = {
    Text = "Bạn cảm thấy bên trong lồng ngực trống rỗng và nhẹ bẫng, cúi đầu nhìn xuống, ngực hiện ra một lỗ hổng hình ổ khóa. \nTrái tim bạn đã biến mất."
  },
  Event_59578_Name = {
    Text = "Rongga ngực"
  },
  Event_59579_ChoiceDesc1 = {Text = "[đi]"},
  Event_59579_Desc = {
    Text = "Bạn lớn tiếng chất vấn mục đích của anh ta, nhưng chỉ nhận lại nụ cười vẫn không thay đổi. \n\n Anh ta đã từ bỏ thế giới từ lâu, một người không có ràng buộc không cần phải chịu trách nhiệm về bất cứ điều gì. \n Bạn chỉ có thể kháng cự một cách vô ích."
  },
  Event_59579_Name = {
    Text = "Gentleman Điên Rồ"
  },
  Event_59580_ChoiceDesc1 = {
    Text = "[đánhloạnnhịp điệu] nhận được bạc tạo vật \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_59580_ChoiceDesc2 = {
    Text = "[giữ gìn bản thân] nhận được 1 trong 3 khắcin"
  },
  Event_59580_Desc = {
    Text = "Bạn như thể đang cùng một người điên cuồng biểu diễn, cô ấy đã bắt cóc bạn trên phím đàn, cuốn bạn vào bản nhạc điên rồ của cô ấy. \n Bạn khó khăn chơi theo nhịp điệu của cô ấy, lảo đảo. \n Bạn vất vả đấu tranh với cô ấy, cố gắng kiểm soát giai điệu của bản nhạc."
  },
  Event_59580_Name = {
    Text = "Bài hát tiệc ngày tận thế"
  },
  Event_59581_ChoiceDesc1 = {Text = "[đi]"},
  Event_59581_Desc = {
    Text = "Bạn hy vọng mình có được sức mạnh vô địch, có thể phá vỡ mọi xiềng xích và chướng ngại vật. \n Tuy nhiên, sức người có hạn, với thân thể bé nhỏ thách thức thần linh, cuối cùng sẽ giống như que diêm, thiêu rụi chính sinh mạng của mình."
  },
  Event_59581_Name = {
    Text = "Lựa chọn vận mệnh"
  },
  Event_59582_ChoiceDesc1 = {Text = "[đi]"},
  Event_59582_Desc = {
    Text = "\"Không còn gì nữa... Không còn gì nữa...\"\nCảm giác trống rỗng thật khó chịu, bạn cầm đồng hồ bỏ túi, táo và áo khoác đồng phục, cố gắng lấp đầy khoảng trống trong lồng ngực.\nLồng ngực của bạn lại trở nên đầy đặn, chỉ là bạn có cảm giác quá no nê.\nKhông sao, mọi thứ thường không hoàn hảo."
  },
  Event_59582_Name = {
    Text = "Rongga ngực"
  },
  Event_59583_ChoiceDesc1 = {
    Text = "[Thuyết phục] nhận được 25 dấu đen"
  },
  Event_59583_ChoiceDesc2 = {
    Text = "[chất vấn] Nhận được bạc tạo vật \"(RelicConfig.Arg1)\", bị ảnh hưởng bởi \"(Skill.Arg2)\""
  },
  Event_59583_Desc = {
    Text = "Đôi giày da của N dừng lại trước mặt bạn, bạn nhìn thấy nụ cười phóng đại trên khuôn mặt đen bóng đó.\nAnh ta thường ăn mặc chỉn chu, nhưng bạn biết rằng bên dưới vẻ ngoài quý tộc đó chỉ có sự điên rồ thuần túy nhất.\nAnh ta không có bạn bè, cũng hiếm khi có kẻ thù.\nBởi vì những người đó sẽ biến mất hoàn toàn theo cách kịch tính nhất.\n\nRất không may, bây giờ bạn đã được anh ta chọn làm nhân vật chính tiếp theo của vở kịch.\nHãy chuẩn bị lời mở đầu của bạn đi, làm thế nào để làm hài lòng vị Khán giả khó tính nhất này?"
  },
  Event_59583_Name = {
    Text = "Gentleman Điên Rồ"
  },
  Event_59584_ChoiceDesc1 = {Text = "[đi]"},
  Event_59584_Desc = {
    Text = "Các thể thức tỉnh không hiểu biết gì hơn bạn, nhưng họ đã trở thành những người bạn trung thành nhất, đồng đội và chỗ dựa của bạn. \n Bạn và các thể thức tỉnh thảo luận về kế sách, mặc dù trong lòng vẫn còn do dự, nhưng đã có được dũng khí để khởi đầu lại."
  },
  Event_59584_Name = {
    Text = "Mắt Vô Tri"
  },
  Event_59585_ChoiceDesc1 = {Text = "[đi]"},
  Event_59585_Desc = {
    Text = "Như thể bạn đã quyết tâm cho bản thân, bạn kiên định trả lời to. \nGiọng nói của bạn vang vọng giữa vô số bong bóng, như thể có vô số bạn cùng tuyên thệ. \nBạn đã sẵn sàng đối mặt với mọi thứ."
  },
  Event_59585_Name = {
    Text = "Chất vấn của Ngài"
  },
  Event_59586_ChoiceDesc1 = {Text = "[đi]"},
  Event_59586_Desc = {
    Text = "Bạn không động đậy, chỉ chăm chú nhìn vào chữ viết trên bức thư hồi âm. \n Dưới ánh mắt của bạn, những câu chữ dần dần trở nên mờ ảo và biến dạng, cuối cùng hóa thành một đàn bướm bay vụt đến mặt bạn. \n Bạn vung tay đuổi bướm, khi quay lại nhìn thì giấy hồi âm đã trống rỗng không còn chữ nào. \n Quả thật, giấc mơ đẹp đẽ quá đều là giả dối."
  },
  Event_59586_Name = {
    Text = "Gema Hipnotis"
  },
  Event_59587_ChoiceDesc1 = {Text = "[đi]"},
  Event_59587_Desc = {
    Text = "Bạn căm ghét những sợi chỉ đê tiện này. \n Bạn kéo mạnh chúng, một số sợi bị đứt, nhưng vô số sợi khác lại tiếp tục bám vào. \n Bạn dùng hết tất cả lực lượng để chống trả chúng."
  },
  Event_59587_Name = {
    Text = "Đôi tay bị thao túng"
  },
  Event_59588_ChoiceDesc1 = {
    Text = "[Chém hạ bóng người] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_59588_ChoiceDesc2 = {
    Text = "[Nghiền nát Phôi thai] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_59588_ChoiceDesc3 = {
    Text = "[đóng mắt lại] được 25 dấu đen"
  },
  Event_59588_Desc = {
    Text = "Trong cơn mơ hồ, bạn thấy những người từng gặp ở Aran đang tiến lại gần bạn. \n Họ cười vui mời bạn uống rượu, nhảy múa, thưởng thức món ăn. \n Sau đó, thịt máu của họ lần lượt bị lột ra, những thứ rơi xuống đất lại bò lên và mọc ra phôi thai mới. \n Họ chìa tay ra với bạn, mời bạn tham gia vào cuộc vui của thịt máu và sinh mới."
  },
  Event_59588_Name = {
    Text = "Bóng tối của những ngày xưa"
  },
  Event_59589_ChoiceDesc1 = {Text = "[đi]"},
  Event_59589_Desc = {
    Text = "Trước khi đưa tay ra, bạn bỗng nhớ ra rằng bạn chưa bao giờ nuôi một con mèo như vậy. \n Bạn và mèo nhìn nhau qua không khí, mèo chớp mắt với bạn. \n Mèo không bận tâm đến sự lạnh nhạt của bạn, nó vẫn trông có vẻ yêu bạn như mọi khi."
  },
  Event_59589_Name = {
    Text = "Sự cám dỗ của mèo"
  },
  Event_59590_ChoiceDesc1 = {
    Text = "[Đính] Chọn 1 sáng tạo để biến thành vật bị nguyền rủa[(RelicConfig.Arg1)]"
  },
  Event_59590_ChoiceDesc2 = {
    Text = "[Nuốt xuống] nhận được một tạo vật từ bạc \"(RelicConfig.Arg1)\", bị lây nhiễm \"(Skill.Arg2)\""
  },
  Event_59590_ChoiceDesc3 = {
    Text = "[ thu gọn ] nhận được 25 dấu đen"
  },
  Event_59590_Desc = {
    Text = "Lực lượng của ba chất thể trong cơ thể bạn đang hòa quyện, bạn khó khăn điều khiển sức mạnh khổng lồ này. \n Không gian tinh thần liên tục mở rộng, một dải ngân hà được sinh ra và lan tỏa ở đây. \n Đối mặt với những kẻ thù không ngừng, bạn chân thành cầu nguyện với bầu trời đầy sao này, mong muốn nhận được sự giúp đỡ từ sức mạnh này. \n Một ngôi sao rơi từ dải ngân hà xuống lòng bàn tay bạn, tỏa ra ánh sáng quyến rũ."
  },
  Event_59590_Name = {
    Text = "Sao Ước Nguyện"
  },
  Event_59591_ChoiceDesc1 = {Text = "[đi]"},
  Event_59591_Desc = {
    Text = "Bạn cũng đáp lại bằng sự im lặng, không có sự trao đổi nào giữa hai người, im lặng nói lên tất cả. \nBạn đã sẵn sàng đối mặt với mọi thứ."
  },
  Event_59591_Name = {
    Text = "Chất vấn của Ngài"
  },
  Event_59592_ChoiceDesc1 = {Text = "[đi]"},
  Event_59592_Desc = {
    Text = "Chú mèo đó là kẻ lừa đảo sao? \n Bạn bắt đầu nghi ngờ đôi mắt xanh như hồ nước, tiếng cười bên tai không ngừng vang vọng. \n \"Kẻ lừa đảo, kẻ lừa đảo, bạn đã bị lừa rồi!\" \n Một cảm giác lo lắng dâng lên trong lòng bạn."
  },
  Event_59592_Name = {
    Text = "bí mật thì thầm"
  },
  Event_59593_ChoiceDesc1 = {Text = "[đi]"},
  Event_59593_Desc = {
    Text = "Bạn như một người quan sát, lặng lẽ xem những cảm xúc dần trở nên xa lạ. \n Bạn kiềm chế mọi ham muốn lưu luyến, cảm nhận linh hồn của mình dần trở nên lạnh lẽo. \n Đây là số phận của bạn, đây là con đường bạn phải trải qua."
  },
  Event_59593_Name = {
    Text = "Tinh thể tình cảm"
  },
  Event_59594_ChoiceDesc1 = {Text = "[đi]"},
  Event_59594_Desc = {
    Text = "Nụ cười đó vẫn lạnh lùng, bạn không thể lay động anh ta bằng lý trí hay cảm xúc. \n mọi mong muốn của con người đều không liên quan đến anh ta. \n lời nói của bạn có thể vượt khỏi giới hạn tưởng tượng của con người không?"
  },
  Event_59594_Name = {
    Text = "Gentleman Điên Rồ"
  },
  Event_59595_ChoiceDesc1 = {
    Text = "[Ứng đáp] Nhận được vật tạo vàng \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_59595_ChoiceDesc2 = {
    Text = "[im lặng] ngẫu nhiên thức tỉnh 2 thân thể được đánh thức, nhiễm hai lần [(Skill.Arg1)]"
  },
  Event_59595_Desc = {
    Text = "Hàng triệu bong bóng giống như hàng triệu con mắt tròn trĩnh, Người im lặng nhìn bạn, tựa như một câu chất vấn không lời. \nBạn đã sẵn sàng chưa? \nSẵn sàng từ bỏ mọi thứ chưa? \nSẵn sàng gánh vác mọi thứ chưa?"
  },
  Event_59595_Name = {
    Text = "Chất vấn của Ngài"
  },
  Event_59596_ChoiceDesc1 = {Text = "[đi]"},
  Event_59596_Desc = {
    Text = "Vào khoảnh khắc đối phương phát động tấn công, bạn lập tức phản công. \n Bạn thông minh phân biệt được bộ mặt thật của họ, đó chính là một bầy quái vật trưng ra nanh sắc. \n Bạn đã may mắn giành chiến thắng. \n Bây giờ hãy cố gắng chạy trốn, tuyệt đối đừng để họ bắt được."
  },
  Event_59596_Name = {
    Text = "Chìm vào hố sâu"
  },
  Event_59597_ChoiceDesc1 = {
    Text = "[Tìm câu trả lời] nhận Arg1 dấu đen, bị lây nhiễm [(Skill.Arg2)], tiếp tục chọn"
  },
  Event_59597_ChoiceDesc2 = {
    Text = "[Bỏ qua] rời đi"
  },
  Event_59597_Desc = {
    Text = "Bạn nên làm gì? \n Bạn nhìn về vô số bản thân, vô số khuôn mặt giống hệt bạn đang nhìn chằm chằm vào bạn, miệng họ mở ra và khép lại. \n Như thể đã bám được vào cọng rơm hy vọng, bạn cố gắng tìm kiếm, lắng nghe, hy vọng có thể nhận được câu trả lời cuối cùng."
  },
  Event_59597_Name = {
    Text = "Câu tự vấn của tôi"
  },
  Event_59598_ChoiceDesc1 = {Text = "[đi]"},
  Event_59598_Desc = {
    Text = "Thời cơ chưa đến, bạn cần phải kiên nhẫn chờ đợi. \nBạn nuốt xuống nỗi bất mãn và căm hận, chờ đợi giây phút quyết định."
  },
  Event_59598_Name = {
    Text = "Đôi tay bị thao túng"
  },
  Event_59599_ChoiceDesc1 = {Text = "[đi]"},
  Event_59599_Desc = {
    Text = "Bạn cảm thấy một sức hút mơ hồ nào đó, bạn muốn nhìn rõ nguồn gốc của những ánh mắt đó. \n Bạn say mê nhìn về khoảng không, cảm thấy như mình đã nhìn thấy điều gì. \n Ánh nhìn trong khoảnh khắc bị che phủ bởi những bông tuyết mờ ảo, thế giới trong mắt bạn như có chỗ nào đó trở nên khác biệt. \n Bạn dụi mắt, phát hiện khóe mắt chảy ra hai dòng máu lệ."
  },
  Event_59599_Name = {
    Text = "Ánh mắt của Ngài"
  },
  Event_59600_ChoiceDesc1 = {
    Text = "[Cố gắng nhớ lại] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_59600_ChoiceDesc2 = {
    Text = "[Thưởng thức nỗi buồn] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_59600_ChoiceDesc3 = {
    Text = "[chấp nhận thầm lặng] nhận được 25 dấu đen"
  },
  Event_59600_Desc = {
    Text = "Như thể đã trải qua một ca phẫu thuật não chính xác nhất, bạn cảm nhận rõ ràng từng đoạn ký ức quý giá đang rời khỏi tâm trí mình, não bộ bạn trở nên mờ mịt, như thể sắp tan chảy. \n Bạn đau đớn run rẩy, giữ chặt tay mình lại để ngăn cản. \n Những giọt nước mắt trong suốt chảy xuống từ hốc mắt, nhưng chúng đang chảy vì điều gì? \n Bạn dường như không nhớ rõ. \n Bạn cảm thấy một nỗi buồn khó hiểu."
  },
  Event_59600_Name = {
    Text = "Giải ly ký ức"
  },
  Event_59601_ChoiceDesc1 = {Text = "[đi]"},
  Event_59601_Desc = {
    Text = "Tình cảm giữa bạn và con mèo không thể nghi ngờ, bạn vẫy tay rồi bước tiếp mà không ngoảnh lại. \n\"Đồ ngốc! Đồ ngốc!\" \nTiếng nói bên tai đầy tức giận và mất kiểm soát."
  },
  Event_59601_Name = {
    Text = "bí mật thì thầm"
  },
  Event_59602_ChoiceDesc1 = {Text = "[đi]"},
  Event_59602_Desc = {
    Text = "Bạn đã hạ quyết tâm, bất kể phải trả giá như thế nào, bạn sẽ đưa hy vọng của mọi người chiến đấu đến phút cuối cùng."
  },
  Event_59602_Name = {
    Text = "Tương lai đóng băng"
  },
  Event_59603_ChoiceDesc1 = {
    Text = "[khắc chế] nhận được bạc tạo vật[(RelicConfig.Arg1)]"
  },
  Event_59603_ChoiceDesc2 = {
    Text = "[Chú ý] nhận được vật tạo vàng \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_59603_Desc = {
    Text = "Sau cánh cửa mà Tà Vy bảo vệ là thế giới vô tận và sự thật vô tận. \n Bạn không biết cô ấy đã thấy gì sau cánh cửa, nhưng bạn biết cô ấy biết mọi thứ. \n Giờ đây, cánh cửa này đang mở ra trước mặt bạn, tất cả sự thật phát ra lời mời im lặng sau cánh cửa."
  },
  Event_59603_Name = {
    Text = "Sau cánh cửa"
  },
  Event_59604_ChoiceDesc1 = {Text = "[đi]"},
  Event_59604_Desc = {
    Text = "Đối với sự tồn tại không biết, nên giữ lòng kính trọng, tránh xa sự sắc bén là lựa chọn thận trọng. \nBạn cúi đầu, nắm chặt chìa khóa bạc trước ngực, cảm thấy hơi an ủi. \nÍt nhất bạn còn có sức mạnh, còn có các thể thức tỉnh. \nBạn cố gắng phớt lờ những ánh mắt đó, tập trung vào con đường trước mắt. \nNhưng những ánh mắt đó thật sự đã biến mất chưa? Bạn biết rõ điều đó."
  },
  Event_59604_Name = {
    Text = "Ánh mắt của Ngài"
  },
  Event_59605_ChoiceDesc1 = {Text = "[đi]"},
  Event_59605_Desc = {
    Text = "Nếu mọi phương pháp chống lại thần minh đều chỉ là Puceron chấn cây, thì điều duy nhất bạn có thể kiên trì chính là lòng dũng cảm không từ bỏ. \n Khi sự hủy diệt vô tận từ thiên không ập đến, bạn sẽ trở thành người đứng ở phía trước nhất."
  },
  Event_59605_Name = {
    Text = "Câu trả lời của tôi"
  },
  Event_59606_ChoiceDesc1 = {Text = "[đi]"},
  Event_59606_Desc = {
    Text = "Bạn ngây ngẩn chạm vào những giọt nước mắt không ngừng rơi, từ từ cảm nhận nỗi buồn không rõ nguồn gốc đó.\nHình như có rất nhiều thứ vô cùng quý giá đã bị bạn tự tay vứt bỏ, nhưng bạn đã không còn nhớ đó là gì. \nThật là đáng tiếc. \nBạn vô lực lau đi nước mắt, trong nước mắt hiện lên một nụ cười chua chát."
  },
  Event_59606_Name = {
    Text = "Giải ly ký ức"
  },
  Event_59607_ChoiceDesc1 = {Text = "[đi]"},
  Event_59607_Desc = {
    Text = "Bạn bỏ qua những tiếng nói đó. \n Bạn không quan tâm đến việc con mèo có phải là kẻ lừa đảo hay không, bạn chỉ tin vào sức mạnh cá nhân của mình. \n Tiếng nói bên tai thở dài."
  },
  Event_59607_Name = {
    Text = "bí mật thì thầm"
  },
  Event_59608_ChoiceDesc1 = {
    Text = "[Tìm câu trả lời] nhận Arg1 dấu đen, bị lây nhiễm [(Skill.Arg2)], tiếp tục chọn"
  },
  Event_59608_ChoiceDesc2 = {
    Text = "[Bỏ qua] rời đi"
  },
  Event_59608_Desc = {
    Text = "Có người điên cuồng cười lớn. \n Người đó tự cho rằng mọi thứ đều là sự vật lộn vô ích, không bằng từ bỏ sớm. \n Bạn nhíu mày, người đó đột nhiên mỉm cười quay lưng lại, người đó nói rằng không bằng tự tay kết thúc sinh mạng của mọi người, còn hơn để mọi người phải chịu đựng nỗi đau. \n Bạn vẫy tay xua đuổi âm thanh đó, kiên định với niềm tin của mình."
  },
  Event_59608_Name = {
    Text = "Câu tự vấn của tôi"
  },
  Event_59609_ChoiceDesc1 = {
    Text = "[Truy vấn] Xóa 2 thẻ bài"
  },
  Event_59609_ChoiceDesc2 = {
    Text = "[chọc thủng] nhận được vật bị nguyền rủa \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_59609_ChoiceDesc3 = {
    Text = "[Rời đi] Nhận được Arg1 dấu đen"
  },
  Event_59609_Desc = {
    Text = "Trong thời gian chờ đợi dài đằng đẵng, bạn lại mở thiết bị liên lạc một lần nữa, có lẽ những nỗi nhớ và lời cầu nguyện của bạn đã có tác dụng, bạn thấy trên tờ giấy phản hồi liên tục xuất hiện những câu trả lời quen thuộc và thân thuộc của cô ấy. \nCô ấy hiện tại rất an toàn, các thầy cô đã có sắp xếp từ sớm, mọi thứ ở Misaque đều diễn ra suôn sẻ… \nBạn nhìn những tin tốt lành bay đến như những bông tuyết, trong lòng không khỏi rung động."
  },
  Event_59609_Name = {
    Text = "Gema Hipnotis"
  },
  Event_59610_ChoiceDesc1 = {
    Text = "[Bắt sao] sẽ nâng cấp 1 bạc tạo vật thành vàng tạo vật[(RelicConfig.Arg1)]"
  },
  Event_59610_ChoiceDesc2 = {
    Text = "[Nghiền nát ngôi sao] nhận được vật tạo vàng \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\" và \"(Skill.Arg3)\""
  },
  Event_59610_ChoiceDesc3 = {
    Text = "[im lặng xem] nhận được 25 dấu đen"
  },
  Event_59610_Desc = {
    Text = "Cảm xúc của bạn bị tách rời cùng với ký ức, bạn cảm thấy mình đang trở thành một tồn tại khổng lồ nào đó, như một con quái vật trở về tổ ấm cổ xưa, ấm áp của nó. \n Vô số niềm vui, nỗi giận, nỗi buồn, nỗi khổ được cô đọng lại, biến thành những ngôi sao sáng lấp lánh, rơi xuống như mưa ánh sáng dưới chiều không gian của bạn. \n Dấu vết bạn đã tồn tại biến thành sao băng tan biến. \n Bạn lặng lẽ quan sát, nhặt lên một ngôi sao trước mặt, bên trong đó vang lên tiếng cười vui vẻ của bạn. \n Vì vậy, bạn cũng cười theo, bạn ngọt như mật."
  },
  Event_59610_Name = {
    Text = "Tinh thể tình cảm"
  },
  Event_59611_ChoiceDesc1 = {Text = "[đi]"},
  Event_59611_Desc = {
    Text = "Bạn biết rằng những điều này chỉ là bóng dáng của quá khứ, bạn tàn sát những người đã từng trò chuyện vui vẻ với mình mà không biểu lộ cảm xúc. \n Những tiếng cười và giọt nước mắt của họ tan vỡ trong tay bạn, bạn không thể có một chút dừng lại. \n Nếu đây là thử thách cần thiết, bạn sẽ trở thành kẻ hành quyết tàn nhẫn nhất."
  },
  Event_59611_Name = {
    Text = "Bóng tối của những ngày xưa"
  },
  Event_59612_ChoiceDesc1 = {Text = "[đi]"},
  Event_59612_Desc = {
    Text = "Nó có bộ lông mềm mại và đôi mắt trong sáng tự nhiên khiến bạn cảm thấy tin tưởng. \nBạn tiến gần đến con mèo, và con mèo cũng tiến lại gần bạn. \nCả hai không nói gì, nhưng cái đuôi của nó dựng thẳng lên."
  },
  Event_59612_Name = {
    Text = "Sự cám dỗ của mèo"
  },
  Event_59613_ChoiceDesc1 = {Text = "[đi]"},
  Event_59613_Desc = {
    Text = "Bạn đã kiềm chế được sự tò mò, bạn biết rằng cánh cửa này không nên mở. \nQuá nhiều sự thật đôi khi là một lời nguyền. \nBạn nắm chặt chìa khóa bạc trước ngực, quyết tâm giữ cho cánh cửa này mãi mãi khép lại."
  },
  Event_59613_Name = {
    Text = "Sau cánh cửa"
  },
  Event_59614_ChoiceDesc1 = {
    Text = "[Dũng khí] Nâng cấp ngẫu nhiên hiệu ứng khắcăng của 2 thẻ bài"
  },
  Event_59614_ChoiceDesc2 = {
    Text = "[Quyết tâm] Chọn 1 thẻ lệnh từ 3 thẻ lệnh để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_59614_Desc = {
    Text = "Lời nói của Tà Vy vang vọng trong tâm trí bạn. \n Trong vô số kết cục, chỉ có một con đường đúng đắn. \n Trong trạng thái mơ hồ, bạn thấy nhiều bóng hình của các thế giới lướt qua trước mắt như những đoạn phim cuộn, chờ đợi khoảnh khắc nhấn nút để dừng lại. \n Sau giây phút này, thế giới sẽ chào đón kết cục như thế nào?"
  },
  Event_59614_Name = {
    Text = "Tương lai đóng băng"
  },
  Event_59615_ChoiceDesc1 = {
    Text = "[bỏ qua nghi ngờ] nhận được 50 dấu đen"
  },
  Event_59615_ChoiceDesc2 = {
    Text = "[độc đoán chuyên quyền] nhận được 75 dấu đen, nhiễm [(Skill.Arg2)]"
  },
  Event_59615_Desc = {
    Text = "Khi tiếng cười nhạo của N vang lên, bạn bắt đầu nghi ngờ tất cả những người mà bạn đã gặp. \n Rốt cuộc ai là hóa thân của anh ấy, ai là bạn bè chân thành của bạn? \n Bóng của anh ấy liên tục biến đổi, bên trong có vẻ như có vô số khuôn mặt, đang mỉm cười với bạn."
  },
  Event_59615_Name = {
    Text = "Trăm khuôn mặt của bóng tối"
  },
  Event_59616_ChoiceDesc1 = {Text = "[đi]"},
  Event_59616_Desc = {
    Text = "Nếu tất cả mọi người đều có thể bội phản, thì đừng phụ thuộc vào bất kỳ ai. \n Trong bóng tối, bạn chỉ có thể xác nhận duy nhất một sự thật. \n Ít nhất bạn còn có chính mình—— người trung thành nhất có thể tin tưởng."
  },
  Event_59616_Name = {
    Text = "Trăm khuôn mặt của bóng tối"
  },
  Event_59617_ChoiceDesc1 = {Text = "[đi]"},
  Event_59617_Desc = {
    Text = "Bạn siết chặt, viên pha lê lấp lánh vỡ vụn thành bột dưới đầu ngón tay bạn. \n Bạn tham lam hít vào những cảm xúc từ quá khứ. \n Chỉ trong khoảnh khắc, niềm vui mãnh liệt tràn vào não bộ của bạn, sau đó từ từ tan biến như ảo giác. \n Đuôi miệng bạn theo đó nhếch lên cao, rồi từ từ hạ xuống. \n Khuôn mặt bạn dần trở nên bình tĩnh không gợn sóng."
  },
  Event_59617_Name = {
    Text = "Tinh thể tình cảm"
  },
  Event_59618_ChoiceDesc1 = {Text = "[đi]"},
  Event_59618_Desc = {
    Text = "Bạn biết rằng mọi thứ đều có giá, nếu giá của việc cứu rỗi là phải hy sinh, vậy thì hãy để bản thân mình trả toàn bộ giá đó. \nBạn đã sẵn sàng bất cứ lúc nào để trả giá."
  },
  Event_59618_Name = {
    Text = "Câu trả lời của tôi"
  },
  Event_59619_ChoiceDesc1 = {
    Text = "[Tìm câu trả lời] nhận Arg1 dấu đen, bị lây nhiễm [(Skill.Arg2)], tiếp tục chọn"
  },
  Event_59619_ChoiceDesc2 = {
    Text = "[Bỏ qua] rời đi"
  },
  Event_59619_Desc = {
    Text = "Có người đang la hét. \nNgười đó gấp gáp muốn chạy trốn, người đó nói rằng đối kháng chắc chắn sẽ thất bại. \nChỉ có sự chạy trốn không ngừng nghỉ mới có thể hoãn lại sự diệt vong cuối cùng. \nBạn bán tín bán nghi."
  },
  Event_59619_Name = {
    Text = "Câu tự vấn của tôi"
  },
  Event_59620_ChoiceDesc1 = {Text = "[đi]"},
  Event_59620_Desc = {
    Text = "Bạn biết tốc độ sinh sản đáng sợ của những phôi thai, sinh mới ở đây giống như lời nguyền của châu chấu. \n Bạn đã nghiền nát chúng trước khi những đứa trẻ sơ sinh phát ra tiếng khóc. \n Những người được tạo nên từ thịt máu căm ghét nhìn bạn, chất vấn bạn tại sao lại xâm phạm sinh lực thiêng liêng. \n Bạn đáp lại bằng những cuộc tàn sát vô tận."
  },
  Event_59620_Name = {
    Text = "Bóng tối của những ngày xưa"
  },
  Event_59621_ChoiceDesc1 = {Text = "[đi]"},
  Event_59621_Desc = {
    Text = "Vào thời điểm này, bạn hy vọng mình sẽ là người may mắn nhất, có thể đạt được kết cục trọn vẹn nhất. \n Nhưng giá của vận may đôi khi lại tàn nhẫn hơn, may mắn và bất hạnh thường đi đôi với nhau, khi bạn nhận được điều gì đó, đừng quên kiểm tra xem mình đã mất đi điều gì."
  },
  Event_59621_Name = {
    Text = "Lựa chọn vận mệnh"
  },
  Event_59622_ChoiceDesc1 = {Text = "[đi]"},
  Event_59622_Desc = {
    Text = "Bạn như thể đang tranh giành vô lăng của cùng một chiếc xe với người khác, hai tay bạn vung vẩy hết sức, cố gắng kiểm soát nhịp điệu của bản nhạc. \n Trong cuộc đối kháng khó khăn, bạn đột nhiên nhấn mạnh một hàng phím đàn. \n Những âm thanh điên cuồng bị bạn làm gián đoạn, bạn nở một nụ cười, rơi vào cuộc đối kháng giữa sự điên cuồng và điên cuồng hơn nữa."
  },
  Event_59622_Name = {
    Text = "Bài hát tiệc ngày tận thế"
  },
  Event_59623_ChoiceDesc1 = {
    Text = "[ thân thiết] nhận được 25 dấu đen"
  },
  Event_59623_ChoiceDesc2 = {
    Text = "[ ]50% cơ hội nhận được 50 dấu đen, 50% cơ hội không có gì cả"
  },
  Event_59623_Desc = {
    Text = "Có một con mèo bên cạnh bạn, bộ lông của nó mượt mà và sạch sẽ, bàn chân trước của nó trắng như tuyết. \n Mèo luôn đồng hành bên bạn, từng bước từng bước một, như một người đầy tớ trung thành nhất của bạn. \n Tất cả sự mơ hồ và bất lực, nỗi đau và bất an trong lòng bạn đều được xoa dịu."
  },
  Event_59623_Name = {
    Text = "Sự cám dỗ của mèo"
  },
  Event_59624_ChoiceDesc1 = {
    Text = "[không] nhiễm \"(Skill.Arg1)\", nhận được vật bị nguyền rủa \"(RelicConfig.Arg2)\""
  },
  Event_59624_ChoiceDesc2 = {
    Text = "[bàn bác] nhiễm hai lần \"(Skill.Arg1)\", nhận được bạc tạo vật \"(RelicConfig.Arg2)\" và \"(RelicConfig.Arg3)\""
  },
  Event_59624_ChoiceDesc3 = {
    Text = "[im lặng] nhận được sáng tạo bạc [(RelicConfig.Arg1)]"
  },
  Event_59624_Desc = {
    Text = "Bạn rơi vào một ảo ảnh hư vô nào đó. \n Bạn thấy vô số người im lặng dưới bóng tối của ngày tận thế, nhỏ bé như bụi. \n Họ ngây dại, xám xịt, mất đi hy vọng. \n Bạn nghe thấy tiếng cười sắc nhọn của ai đó. \n \"Nhìn xem, đây chính là kết quả của sự kiên trì của các bạn.\" \n \"Thế giới này vốn dĩ không có kết thúc, mọi thứ đều không có ý nghĩa.\""
  },
  Event_59624_Name = {
    Text = "Con cừu chờ chết"
  },
  Event_59625_ChoiceDesc1 = {Text = "[đi]"},
  Event_59625_Desc = {
    Text = "Không, điều này không đúng, đây không phải là thật. \nBạn không ngừng phủ nhận âm thanh điên rồ đó, nhưng những hình bóng xám xịt vẫn thờ ơ, như thể chứng minh kết cục hư vô. \nTiếng cười ngày càng lớn, chế nhạo sự bất lực của bạn."
  },
  Event_59625_Name = {
    Text = "Con cừu chờ chết"
  },
  Event_59626_ChoiceDesc1 = {Text = "[đi]"},
  Event_59626_Desc = {
    Text = "Bạn cảm thấy một nỗi tiếc nuối và không nỡ lớn lao, bạn vô thức cố gắng hồi tưởng, cố gắng tìm kiếm bóng dáng của quá khứ trong những mảnh ký ức. \n Những hình ảnh mờ ảo nhanh chóng lùi lại, bạn cố gắng với tay nắm bắt, nhưng chỉ có thể thấy những hình ảnh đó trôi qua giữa các ngón tay. \n Bạn nhận ra rằng, bạn sắp sửa trở thành người không có gì."
  },
  Event_59626_Name = {
    Text = "Giải ly ký ức"
  },
  Event_59627_ChoiceDesc1 = {
    Text = "[ thân thiết] nhận được 25 dấu đen"
  },
  Event_59627_ChoiceDesc2 = {
    Text = "[ ]50% cơ hội nhận được 50 dấu đen, 50% cơ hội không có gì cả"
  },
  Event_59627_Desc = {
    Text = "Có một con mèo đi bên cạnh bạn, bộ lông của nó mượt mà và sạch sẽ, đôi chân trước của nó trắng như tuyết. \n Con mèo luôn bên cạnh bạn, theo sát từng bước, như một người hầu trung thành nhất của bạn. \n Tất cả sự mơ hồ và bất lực, nỗi đau và lo lắng trong lòng bạn đều được xoa dịu."
  },
  Event_59627_Name = {
    Text = "Sự cám dỗ của mèo"
  },
  Event_59628_ChoiceDesc1 = {Text = "[đi]"},
  Event_59628_Desc = {
    Text = "Bạn gặp gỡ phiên bản cuối cùng của chính mình tại đây, cuộc chiến hủy diệt toàn bộ thế giới thực ra chỉ là sự đối diện ánh mắt giữa các bạn. \n Khi Ngài nhìn về phía bạn, bạn phải kiên định nhìn thẳng vào Ngài, cho đến khi một trong những ánh mắt đó biến mất."
  },
  Event_59628_Name = {
    Text = "Câu trả lời của tôi"
  },
  Event_59629_ChoiceDesc1 = {
    Text = "[hô hấp] nhận được sáng tạo bạc \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_59629_ChoiceDesc2 = {
    Text = "[Phản công] nhận được vật tạo vàng \"(RelicConfig.Arg1)\", bị ảnh hưởng bởi \"(Skill.Arg2)\", \"(Skill.Arg3)\""
  },
  Event_59629_ChoiceDesc3 = {
    Text = "[struggle] nhận được 25 dấu đen"
  },
  Event_59629_Desc = {
    Text = "Tiếng bước chân dồn dập vang lên, một nhóm điệp viên của hội nghị thẩm tra chặn đường bạn. \n \"Xin vui lòng hợp tác với cuộc điều tra của chúng tôi.\" \n Giọng nói lạnh lùng ẩn chứa ác ý. \n Bịch một tiếng, mặt nước yên tĩnh bị phá vỡ, họ ném bạn vào trong cái hồ sâu."
  },
  Event_59629_Name = {
    Text = "Chìm vào hố sâu"
  },
  Event_59630_ChoiceDesc1 = {Text = "[đi]"},
  Event_59630_Desc = {
    Text = "Bạn gắng sức vùng vẫy. \nLên trước, lên thêm một chút nữa. \nDù phải trả giá gì đi chăng nữa, bạn cũng phải bảo vệ tất cả điều này. \nBạn cố gắng đưa tay ra, sợi chỉ len vào da thịt bạn, nhưng bạn không hề hay biết."
  },
  Event_59630_Name = {
    Text = "Đôi tay bị thao túng"
  },
  Event_59631_ChoiceDesc1 = {Text = "[đi]"},
  Event_59631_Desc = {
    Text = "Bạn lắc đầu mạnh mẽ, gạt bỏ những ký ức hỗn loạn ra khỏi não. \n Rất nhanh, âm thanh ồn ào dần dần biến mất, ý thức của bạn cuối cùng đã phục hồi sự độc lập. \n Bạn không thể tìm thấy sự giúp đỡ từ quá khứ thất bại, chỉ có thể tập trung vào hiện tại mới có thể tìm thấy hy vọng."
  },
  Event_59631_Name = {
    Text = "Câu tự vấn của tôi"
  },
  Event_59632_ChoiceDesc1 = {
    Text = "[rời đi] nhận được 50 dấu đen"
  },
  Event_59632_Desc = {
    Text = "Trước khi đưa tay ra, bạn bỗng nhớ ra rằng bạn chưa từng nuôi một con mèo như vậy. \n Bạn và mèo nhìn nhau qua không khí, mèo nháy mắt với bạn. \n Mèo không quan tâm đến sự lạnh lùng của bạn, nó vẫn có vẻ yêu quý bạn như vậy."
  },
  Event_59632_Name = {
    Text = "Sự cám dỗ của mèo"
  },
  Event_59633_ChoiceDesc1 = {
    Text = "[Tìm kiếm câu trả lời] nhận được Arg1 dấu đen, nhiễm [(Skill.Arg2)]"
  },
  Event_59633_ChoiceDesc2 = {
    Text = "[Bỏ qua] rời đi"
  },
  Event_59633_Desc = {
    Text = "Có người buồn bã rơi nước mắt. \n Người đó với vẻ mặt đầy bi thương, muốn ôm chặt người mình yêu nhất. \n Thời khắc hủy diệt không thể ở bên những người mình quan tâm là điều tiếc nuối lớn nhất của họ. \n Bạn cảm thấy đau lòng, không thể không cùng nhau buồn bã."
  },
  Event_59633_Name = {
    Text = "Câu tự vấn của tôi"
  },
  Event_59634_ChoiceDesc1 = {Text = "[đi]"},
  Event_59634_Desc = {
    Text = "Bạn nhìn vào vô số hình bóng xám, bỏ qua tiếng cười giễu cợt. \nLàm thế nào để cứu vãn thế giới sụp đổ? \nBạn không ngừng suy nghĩ trong im lặng của diệt vong."
  },
  Event_59634_Name = {
    Text = "Con cừu chờ chết"
  },
  Event_59635_ChoiceDesc1 = {Text = "[đi]"},
  Event_59635_Desc = {
    Text = "Không khí trong phế nang dần biến mất, bạn cố gắng thở dưới nước. \n Thật là hành động ngu ngốc, nhưng bạn đã thành công. \n Phế nang của bạn lại đầy ắp, bạn có thể thở ra một cách thoải mái. \n Nhưng bạn đang hít vào cái gì đây?"
  },
  Event_59635_Name = {
    Text = "Chìm vào hố sâu"
  },
  Event_59636_ChoiceDesc1 = {Text = "[đi]"},
  Event_59636_Desc = {
    Text = "Bạn chìm vào chất lỏng nhầy nhụa. \nDù bạn cố gắng vùng vẫy, nhưng chỉ càng lún sâu hơn. \nBạn không thể thoát khỏi vùng bùn lầy này một mình."
  },
  Event_59636_Name = {
    Text = "Chìm vào hố sâu"
  },
  Event_59637_ChoiceDesc1 = {Text = "[đi]"},
  Event_59637_Desc = {
    Text = "Bạn buộc bản thân quên đi những nghi ngờ này. \n Bạn biết rằng vào lúc này, những nghi ngờ là vô ích nhất, bạn chỉ có thể cố gắng tin tưởng. \n Trước khi chiếc hộp kín được mở ra, bạn không thể biết sự thật bên trong hộp. \n Đôi khi, làm một kẻ ngốc nghếch lại dễ dàng có được sự bình yên hơn."
  },
  Event_59637_Name = {
    Text = "Trăm khuôn mặt của bóng tối"
  },
  Event_59638_ChoiceDesc1 = {Text = "[đi]"},
  Event_59638_Desc = {
    Text = "Tất cả ánh mắt đều tập trung vào bạn, bạn phải trở thành lãnh đạo của mọi người, không thể để lộ bất kỳ sự mong manh nào. \n \"Hãy đến hồ đen, mọi chuyện sẽ ổn thôi.\" \n Bạn bình tĩnh ra lệnh, hứa hẹn điều mà chính mình cũng chưa chắc tin tưởng."
  },
  Event_59638_Name = {
    Text = "Mắt Vô Tri"
  },
  Event_59639_ChoiceDesc1 = {
    Text = "[nghi ngờ] Nhiễm phải \"(Skill.Arg1)\", nhận được vật bị nguyền rủa \"(RelicConfig.Arg2)\""
  },
  Event_59639_ChoiceDesc2 = {
    Text = "[bất xỉ] nhiễm hai lần \"(Skill.Arg1)\", nhận được bạc sáng tạo \"(RelicConfig.Arg2)\" và \"(RelicConfig.Arg3)\""
  },
  Event_59639_ChoiceDesc3 = {
    Text = "[bỏ qua] nhận được bạc sáng tạo[(RelicConfig.Arg1)]"
  },
  Event_59639_Desc = {
    Text = "Trước mặt có ba bóng người lưỡng lự, họ lẩm bẩm điều gì đó. \n Bạn áp tai lại gần để nghe, âm thanh phát ra cùng với hơi thở trở nên rõ ràng. \n \"Đừng tin con mèo đó, nó là kẻ lừa đảo.\" \n Bạn đột ngột quay đầu lại, nhưng phát hiện bên cạnh chẳng có ai."
  },
  Event_59639_Name = {
    Text = "bí mật thì thầm"
  },
  Event_59640_ChoiceDesc1 = {Text = "[đi]"},
  Event_59640_Desc = {
    Text = "Ngôi sao trông thật ngon miệng, bạn thèm khát sức mạnh của nó và nuốt chửng nó. \n Ục. \n Bạn cảm thấy tinh thần tràn đầy chưa từng có, có một ánh sáng lấp lánh trong tầm nhìn của bạn. \n Nhìn xuống, ngôi sao vẫn phát sáng trong dạ dày của bạn."
  },
  Event_59640_Name = {
    Text = "Sao Ước Nguyện"
  },
  Event_59641_ChoiceDesc1 = {
    Text = "[Struggle Forward] xóa 1 thẻ lệnh, nhận Arg1 dấu đen"
  },
  Event_59641_ChoiceDesc2 = {
    Text = "[Cắt đứt sợi chỉ] sao chép 1 thẻ lệnh, lây nhiễm [(Skill.Arg1)]"
  },
  Event_59641_ChoiceDesc3 = {
    Text = "[Nhẫn nại không phát] từ 3 thẻ lệnh chọn 1 thẻ nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_59641_Desc = {
    Text = "Trên đường đi, bạn bị đẩy về phía trước, tất cả sự lựa chọn của bạn đều bị những sợi chỉ vô hình điều khiển. \n Bạn cố gắng vùng vẫy đôi tay, muốn nắm bắt mọi thứ mà bạn quan tâm. \n Số phận của thế giới treo lơ lửng trước đầu ngón tay bạn. \n Vô số sợi chỉ quấn quanh, trói buộc toàn thân bạn."
  },
  Event_59641_Name = {
    Text = "Đôi tay bị thao túng"
  },
  Event_59642_ChoiceDesc1 = {Text = "[đi]"},
  Event_59642_Desc = {
    Text = "Bạn lau đi máu và nước mắt ở khóe mắt, vô số máu và nước mắt lại tiếp tục chảy xuống. \n Màu đỏ lan tỏa trong tầm nhìn của bạn, như thể báo hiệu một cuộc hy sinh đẫm máu. \n Bạn liên tục lau chùi, cơn đau khiến bạn run rẩy, nhưng không thể khiến bạn có chút sợ hãi nào."
  },
  Event_59642_Name = {
    Text = "Fusion của tôi"
  },
  Event_59643_ChoiceDesc1 = {Text = "[đi]"},
  Event_59643_Desc = {
    Text = "Bạn vuốt ve viên ngọc quý này và gắn nó vào chìa khóa bạc. \nÁnh sáng của ngôi sao chiếu rọi lên bạn. \nBạn cảm thấy mê mẩn."
  },
  Event_59643_Name = {
    Text = "Sao Ước Nguyện"
  },
  Event_59644_ChoiceDesc1 = {Text = "[đi]"},
  Event_59644_Desc = {
    Text = "Bạn không quan tâm, luôn mở to mắt, sự kiên trì trong lòng hóa thành tiếng gào thét bướng bỉnh. \nDù có vỡ vụn và tan biến, bạn cũng sẽ không lùi bước."
  },
  Event_59644_Name = {
    Text = "Fusion của tôi"
  },
  Event_59645_ChoiceDesc1 = {Text = "[đi]"},
  Event_59645_Desc = {
    Text = "Có người im lặng. \n Nhìn vào khuôn mặt tuyệt vọng im lặng của chính mình, bạn biết rằng họ đều không đi đến cuối cùng. \n Bạn là người đã đi xa nhất trong tất cả những bản thân của mình, chỉ có câu trả lời của chính bạn mới là hy vọng cuối cùng."
  },
  Event_59645_Name = {
    Text = "Câu tự vấn của tôi"
  },
  Event_59646_ChoiceDesc1 = {Text = "[đi]"},
  Event_59646_Desc = {
    Text = "Bạn đưa tay ra, liên tục nắm lấy từ vô số sao băng, những viên pha lê lấp lánh lướt qua đầu ngón tay bạn. \n Niềm vui, nỗi buồn, cơn giận, sự sợ hãi... \n Bạn tham lam nắm bắt từng sợi cảm xúc, rồi lại nhìn chúng biến mất khỏi tay mình. \n Ánh sáng rực rỡ chiếu rọi lên khuôn mặt bạn, con ngươi của bạn dần trở nên đen tối và sâu thẳm."
  },
  Event_59646_Name = {
    Text = "Tinh thể tình cảm"
  },
  Event_59657_ChoiceDesc1 = {
    Text = "[Gọi] nhận được bạc tạo vật [(RelicConfig.Arg1)]"
  },
  Event_59657_ChoiceDesc2 = {
    Text = "[chạm] nhận được vật tạo vàng \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_59657_Desc = {
    Text = "Bạn chứng kiến con búp bê rơi vào tình trạng sụp đổ. \n Cô ấy từng là sinh mệnh lý trí nhất, cũng là trợ lý trung thành nhất, cẩn thận giữ gìn mọi thông tin mà các bạn đã thu thập. \n Nhưng giờ đây, cô ấy dường như không còn nhớ tất cả những gì các bạn đã trải qua cùng nhau. \n Bạn thấy ở khóe mắt của búp bê rơi xuống những giọt chất lỏng trong suốt."
  },
  Event_59657_Name = {
    Text = "Nước mắt búp bê"
  },
  Event_59658_ChoiceDesc1 = {Text = "[đi]"},
  Event_59658_Desc = {
    Text = "Bạn không từ bỏ, cố gắng tiếp xúc với lõi năng lượng của cô ấy. \n Chỉ cần là máy móc, khởi động lại chắc chắn có thể sửa chữa được. \n Đáng tiếc rằng con búp bê vô tình không cho bạn cơ hội ngây thơ đó. \n Sự nhượng bộ của bạn không đổi được sự khoan dung của con búp bê, bạn chỉ còn cách chiến đấu hết sức."
  },
  Event_59658_Name = {
    Text = "Nước mắt búp bê"
  },
  Event_59659_ChoiceDesc1 = {Text = "[đi]"},
  Event_59659_Desc = {
    Text = "Bạn không muốn gây hỏng hóc cho người bạn cũ. \nBạn cố gắng gọi tên cô ấy, thực hiện mọi lệnh, nhưng tất cả đều vô ích. \nBúp bê đã bội phản bạn, trở về với sự lạnh lùng của vật vô tri."
  },
  Event_59659_Name = {
    Text = "Nước mắt búp bê"
  },
  Event_60944_ChoiceDesc1 = {Text = "[đi]"},
  Event_60944_Desc = {
    Text = "Thời gian dành cho bạn không còn nhiều, bạn đã chọn cách xử lý trực tiếp nhất, vượt qua được sự phong tỏa. Các thể thức tỉnh được khích lệ, cũng trở nên hưng phấn. \n Đối với kẻ thù trở nên cảnh giác hơn, không cần phải lo lắng."
  },
  Event_60944_Name = {
    Text = "Điệp viên hội nghị thẩm tra"
  },
  Event_60945_ChoiceDesc1 = {Text = "[đi]"},
  Event_60945_Desc = {
    Text = "Trước khi viên điệp viên đó phản ứng kịp, các bạn đã vòng ra phía sau lưng anh ta, thu giữ vũ khí của anh ta. Trước khi tiếp viện đến, các bạn đã thành công rời khỏi đây. \nThật tiếc là tin tức đã lan truyền, kẻ địch phía sau đã có sự chuẩn bị, có thể sẽ trở nên khó đối phó hơn. Hãy chuẩn bị sẵn sàng."
  },
  Event_60945_Name = {
    Text = "Điệp viên hội nghị thẩm tra"
  },
  Event_60946_ChoiceDesc1 = {Text = "[đi]"},
  Event_60946_Desc = {
    Text = "Điệp viên bị thu hút bởi một tiếng huýt sáo, tiến về nơi ẩn nấp của các bạn. Vào khoảnh khắc anh ta đến gần, các thể thức tỉnh đã chờ đợi lâu nay cùng nhau phát động tấn công. \n Một cuộc phục kích hoàn hảo, cuộc khủng hoảng ở đây đã được giải quyết mãi mãi."
  },
  Event_60946_Name = {
    Text = "Điệp viên hội nghị thẩm tra"
  },
  Event_60947_ChoiceDesc1 = {Text = "[đi]"},
  Event_60947_Desc = {
    Text = "Đối mặt với số lượng địch đông đảo, bạn không thể đối đầu với họ. Bạn chủ động bước vào trường nhìn của họ, và không có bất kỳ sự kháng cự nào. \n Bạn biết rằng, các bạn sắp được đưa đến Điểm giam giữ, đây chính là một phần của kế hoạch. \n Các bạn sẽ trốn thoát từ đó, tìm kiếm con đường mới."
  },
  Event_60947_Name = {
    Text = "Điểm giám sát"
  },
  Event_60948_ChoiceDesc1 = {Text = "[đi]"},
  Event_60948_Desc = {
    Text = "Đối mặt với số lượng địch đông đảo, bạn không thể đối đầu với họ. Sau một trận chiến ngắn ngủi, các bạn đã từ bỏ kháng cự. \nBạn biết rằng, các bạn sắp được đưa đến Điểm giam giữ, đây chính là một phần của kế hoạch. \nCác bạn sẽ trốn thoát từ đó, tìm kiếm con đường mới."
  },
  Event_60948_Name = {
    Text = "Điểm giám sát"
  },
  Event_60949_ChoiceDesc1 = {Text = "[đi]"},
  Event_60949_Desc = {
    Text = "Đối mặt với số lượng địch đông đảo, bạn không thể đối đầu với họ. \nBạn chọn rời đi tạm thời, tìm kiếm con đường mới."
  },
  Event_60949_Name = {
    Text = "Điểm giám sát"
  },
  Event_61058_ChoiceDesc1 = {Text = "[đi]"},
  Event_61058_Desc = {
    Text = "Bạn nhìn vào đôi tay của mình, toàn thân mình, trong lòng tràn đầy hy vọng và quyết tâm. \n Nếu tất cả những điều này đều là sắp đặt của số phận, bạn đã sẵn sàng đối mặt với mọi thứ. \n Nếu trong khoảnh khắc cuối cùng có thật một cánh cửa dẫn đến thiên đường hoặc địa ngục, thì chính bạn sẽ mở cánh cửa đó cho thế giới."
  },
  Event_61058_Name = {Text = "Nhìn lén"},
  Event_61059_ChoiceDesc1 = {
    Text = "[Chuẩn bị chiến đấu] Hãy chọn 1 trong 3 thẻ lệnh để nhận được khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_61059_ChoiceDesc2 = {
    Text = "[tiếp tục quan sát] nhiễm [(Skill.Arg1)], khắcăng lại, tối đa 1 lần"
  },
  Event_61059_Desc = {
    Text = "Bạn không vội vàng đối mặt, bình tĩnh cố gắng làm rõ tình hình hiện tại. Người nhạc trưởng đột ngột xuất hiện này vừa có vẻ như kẻ thù vừa như bạn, bạn không rõ anh ta chuẩn bị làm gì. Dù sao, bạn quyết định chuẩn bị sẵn sàng, trước tiên đối mặt với thử thách của anh ta, rồi từ từ quan sát xem anh ta thực sự muốn làm gì."
  },
  Event_61059_Name = {
    Text = "Nhạc trưởng quỷ"
  },
  Event_61060_ChoiceDesc1 = {
    Text = "[Lắng nghe] nhận được 3 lựa chọn khắcăng cao cấp"
  },
  Event_61060_ChoiceDesc2 = {
    Text = "[ Hét ] Nhận được báu vật bằng vàng \"(RelicConfig.Arg1)\", nhiễm kỹ năng \"(Skill.Arg2)\""
  },
  Event_61060_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 50 dấu đen"
  },
  Event_61060_Desc = {
    Text = "Kể từ khi tai nạn xảy ra, bạn không còn nhận được tin tức nào từ đối tác. \n Vô số liên lạc được gửi đi, như thể rơi xuống biển cả không có tiếng vọng. \n Vào lúc bạn đã không còn hy vọng, thiết bị liên lạc bỗng phát ra âm thanh. \n Bạn mở vali, đưa ống nghe điện thoại gần tai. \n \"Người giữ bí mật…\" \n Trong cơn mơ màng, bạn nghe thấy giọng nói mà bạn luôn nhớ thương, như thể vọng lại từ xa xôi qua nhiều lớp hư không."
  },
  Event_61060_Name = {
    Text = "Giai điệu nhớ nhung"
  },
  Event_61061_ChoiceDesc1 = {
    Text = "[Chấp nhận bóng tối] nhận được bạc tạo vật \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_61061_ChoiceDesc2 = {
    Text = "[thử bơi] nhận được bạc tạo vật \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_61061_ChoiceDesc3 = {
    Text = "[Gọi hồn ma] nhận được 25 dấu đen"
  },
  Event_61061_Desc = {
    Text = "Bạn chạy về phía trước, mặt đất dưới chân bỗng chốc biến thành một vùng biển cả không thể đi lại. \n Bạn rơi vào lòng đất. \n Giống như những linh hồn trong nghĩa trang xuất hiện, vô số bóng tối nhầy nhụa bao quanh bạn, tham lam xâm nhập vào mũi và miệng bạn."
  },
  Event_61061_Name = {
    Text = "Chìm xuống đất"
  },
  Event_61062_ChoiceDesc1 = {Text = "[đi]"},
  Event_61062_Desc = {
    Text = "Bạn mở to mắt, cố gắng tìm kiếm mọi manh mối. \n Một trăm con mắt cùng lúc chuyển động, bạn thấy những móng vuốt của con chó có mặt người chạy phía trước, bạn thấy quỹ đạo của cây gậy chỉ huy của Hamlin vung vẩy phía sau. \n Bạn tham lam quan sát tất cả. \n Đột nhiên, bạn thấy một con mắt quen thuộc lăn trên mặt đất. \n Có vẻ như đó là mắt của bạn."
  },
  Event_61062_Name = {
    Text = "Sự tham lam về kiến thức"
  },
  Event_61063_ChoiceDesc1 = {Text = "[đi]"},
  Event_61063_Desc = {
    Text = "Không đúng, bạn không thể nhìn thấy nhiều thứ như vậy. \n Bạn rõ ràng chỉ có...... chỉ có vài con mắt thôi? \n Bạn vội vàng nhắm mắt lại, đưa tay lên mặt sờ soạng. \n Một, hai...... \n Khi bạn mở mắt lần nữa, trường nhìn của bạn lại trở nên hẹp hòi và ngu ngốc. \n Thì ra bạn chỉ có hai con mắt, thật đáng tiếc, thật đáng tiếc."
  },
  Event_61063_Name = {
    Text = "Sự tham lam về kiến thức"
  },
  Event_61064_ChoiceDesc1 = {
    Text = "[Tìm kiếm]nhận được vật bị nguyền rủa 「(RelicConfig.Arg1)」, nhiễm 「(Skill.Arg2)」"
  },
  Event_61064_ChoiceDesc2 = {
    Text = "[Nhắm Mắt] 1 thẻ lệnh ngẫu nhiên nhận được Khắc ấn: [(EnchantConfig.Arg1)]"
  },
  Event_61064_Desc = {
    Text = "Ngày càng nhiều manh mối rối rắm như những sợi chỉ rối bời quấn thành một đống, bạn cảm thấy lo lắng, bối rối, tức giận, bạn ghét bản thân vì sao lại không biết gì cả. \n Áp lực khổng lồ khiến tâm trí bạn căng thẳng như một sợi chỉ mảnh. \n Một tiếng bùng, bạn cảm thấy da đầu đột nhiên được thả lỏng, bạn bỗng nhiên có thể nhìn thấy tất cả cảnh vật xung quanh, nhìn thấy những bóng ma đang lắc lư trong hư không. \n Nhiều hơn nữa, bạn còn cần nhìn thấy nhiều hơn nữa…"
  },
  Event_61064_Name = {
    Text = "Sự tham lam về kiến thức"
  },
  Event_61065_ChoiceDesc1 = {Text = "[đi]"},
  Event_61065_Desc = {
    Text = "Bạn đang bơi trong đất, tưởng tượng mình là con cá linh hoạt nhất. \n Muốn biến thành cá, bạn phải từ bỏ đôi chân của con người. \n Đây là cái giá của giao dịch. \n Rất nhanh chóng, bạn cảm thấy nhẹ nhàng chưa từng có, bạn trở thành sinh vật tự do nhất dưới lòng đất. \n Bạn bơi trở lại mặt đất, nhưng đã quên cách đi bộ."
  },
  Event_61065_Name = {
    Text = "Chìm xuống đất"
  },
  Event_61066_ChoiceDesc1 = {Text = "[đi]"},
  Event_61066_Desc = {
    Text = "Đầu ngón tay bạn chạm vào cảm giác quen thuộc của chiếc chìa khóa bạc, đó là trung tâm của mọi ánh sáng. \n Đây là sự tinh túy của sinh lực bạn, là hiện thân của số phận bạn. \n Những trải nghiệm trong quá khứ vụt qua trước mắt. \n Sự lựa chọn của bạn đã được gắn chặt với sự lựa chọn của thế giới này. \n Số phận của bạn đã gắn liền với rất nhiều người."
  },
  Event_61066_Name = {Text = "Nhìn lén"},
  Event_61067_ChoiceDesc1 = {Text = "[đi]"},
  Event_61067_Desc = {
    Text = "Bạn cảm thấy có nhiều sự tồn tại thân thiết bao quanh bạn.\nBạn thử gọi những hồn ma chưa chắc đã tồn tại.\nĐiều kỳ diệu xảy ra, bạn trở lại trên mặt đất.\nVô số bia mộ vẫn lặng im."
  },
  Event_61067_Name = {
    Text = "Chìm xuống đất"
  },
  Event_61068_ChoiceDesc1 = {Text = "[đi]"},
  Event_61068_Desc = {
    Text = "Bạn không có thời gian để cảm thán, bạn chỉ muốn nhanh chóng cứu vãn tất cả những gì đang sụp đổ. \n Nếu bạn trở thành ngôi sao, thì hãy để bạn hóa thành sao băng. \n Chỉ cần có thể chiếu sáng bầu trời đêm, dù cuối cùng sẽ rơi xuống."
  },
  Event_61068_Name = {Text = "Nhìn lén"},
  Event_61069_ChoiceDesc1 = {Text = "[đi]"},
  Event_61069_Desc = {
    Text = "Bạn áp tai sát hơn, thu hết những âm thanh vụn vặt vào đầu. \n\"Tôi……\" \n\"Bạn nhất định……\" \n Bạn chỉ có thể nghe thấy những câu chữ không trọn vẹn, không thể phân biệt bất kỳ ý nghĩa nào. \n Nhưng bạn không dám lên tiếng, sợ bỏ lỡ bất kỳ từ nào. \n Thế nhưng số phận không ban cho bạn thêm sự thương xót nào. \n Chỉ còn lại một chút âm thanh cũng vậy mà biến mất, xung quanh trở lại yên tĩnh."
  },
  Event_61069_Name = {
    Text = "Giai điệu nhớ nhung"
  },
  Event_61070_ChoiceDesc1 = {Text = "[đi]"},
  Event_61070_Desc = {
    Text = "Bạn ngừng suy nghĩ thêm, ra lệnh cho các thân thể được đánh thức xếp hàng, sẵn sàng đối mặt với thử thách của anh ta."
  },
  Event_61070_Name = {
    Text = "Nhạc trưởng quỷ"
  },
  Event_61071_ChoiceDesc1 = {Text = "[đi]"},
  Event_61071_Desc = {
    Text = "Bạn liên tục gọi tên cô ấy, cố gắng truyền đạt dù chỉ một chút tâm tình. \n Bạn không biết cô ấy có nghe thấy không, bạn cố gắng phân biệt âm thanh mờ nhạt trong micro. \n Dường như đó là phản hồi của cô ấy, lại cũng như hàng triệu mảnh vụn của quá khứ đang được phát lại. \n Phát lại những niềm vui nỗi buồn và những cuộc gặp gỡ mà hai bạn đã cùng trải qua."
  },
  Event_61071_Name = {
    Text = "Giai điệu nhớ nhung"
  },
  Event_61072_ChoiceDesc1 = {Text = "[đi]"},
  Event_61072_Desc = {
    Text = "Có lẽ bóng tối này mới là thế giới thật sự, tham gia vào đó có gì không tốt? \n Bạn hoàn toàn chấp nhận bóng tối, bóng tối cũng không còn bài xích bạn, bạn có thể thỏa sức hít thở. \n Giây tiếp theo bạn trở lại mặt đất, có lẽ một cái gì đó sẽ mãi mãi ở lại dưới lòng đất, nhưng điều đó không còn quan trọng nữa."
  },
  Event_61072_Name = {
    Text = "Chìm xuống đất"
  },
  Event_61073_ChoiceDesc1 = {
    Text = "[Ánh sáng chú ý] Chọn 1 trong 3 thẻ lệnh để nhận khắcăng: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_61073_ChoiceDesc2 = {
    Text = "[chạm vào ngực] chọn 1 thân thể được đánh thức để thức tỉnh, bị ảnh hưởng bởi [(Skill.Arg1)]"
  },
  Event_61073_ChoiceDesc3 = {
    Text = "[tiếp tục chạy] nhận được 25 dấu đen"
  },
  Event_61073_Desc = {
    Text = "Bạn cảm thấy mơ hồ trong lòng, chỉ có thể chạy hết sức mà không có thời gian để suy nghĩ nhiều. \n Đột nhiên, bạn cảm thấy ngực mình trống rỗng. \n Bạn cúi đầu nhìn xuống, nơi trái tim vốn có xuất hiện một đốm sáng hình chiếc chìa khóa. \n Đốm sáng đó ngày càng rực rỡ, dần dần lan tỏa ra toàn thân bạn. \n Bạn thấy mình biến thành một ngôi sao. \n Bạn bỗng nhận ra, có lẽ đây chính là sứ mệnh mà bạn luôn theo đuổi."
  },
  Event_61073_Name = {Text = "Nhìn lén"},
  Event_61074_ChoiceDesc1 = {
    Text = "[Chuẩn bị chiến đấu] Hãy chọn 1 trong 3 thẻ lệnh để nhận được khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_61074_ChoiceDesc2 = {
    Text = "[Quan sát kỹ lưỡng] Nhiễm [(Skill.Arg1)], khắcăng, tối đa thực hiện 2 lần"
  },
  Event_61074_Desc = {
    Text = "\"Này... chờ đã! Chuyện gì đang xảy ra...\"\n \"Luyện tập.\"\nNam tử không biểu cảm nhìn bạn.\n \"Duy trì đường dẫn cơ thể thức tỉnh bằng âm nhạc là một thử nghiệm mới. Đảm bảo chất lượng của dàn nhạc để đảm bảo sự hoàn hảo của buổi biểu diễn.\"\nÔng ta nâng cây chỉ huy lên và vung xuống rõ ràng, vẽ nên một dấu hiệu khởi tấu tao nhã trong không khí.\n \"Hãy chơi đi, Người Giữ Gìn. Cho tôi xem bạn làm được gì.\""
  },
  Event_61074_Name = {
    Text = "Nhạc trưởng quỷ"
  },
  Event_61075_ChoiceDesc1 = {
    Text = "[Chuẩn bị chiến đấu] Hãy chọn 1 trong 3 thẻ lệnh để nhận được khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_61075_Desc = {
    Text = "Dù mục đích của anh ta là gì, ít nhất anh ta đã cứu bạn khỏi cuộc vây công của hội nghị thẩm tra. Nếu anh ta muốn gây hại cho bạn, thì không cần phải giúp bạn. Bạn bình tĩnh lại và sẵn sàng đối mặt."
  },
  Event_61075_Name = {
    Text = "Nhạc trưởng quỷ"
  },
  Event_65400_ChoiceDesc1 = {Text = "[đi]"},
  Event_65400_Desc = {
    Text = "Người liên lạc đã truyền đạt lời hứa về việc cứu hộ từ bên ngoài, khi nghe đội cứu hộ đang tìm cách vào núi, hy vọng trong lòng mọi người một lần nữa bùng lên."
  },
  Event_65400_Name = {
    Text = "Điểm liên lạc"
  },
  Event_65401_ChoiceDesc1 = {Text = "[đi]"},
  Event_65401_Desc = {
    Text = "Tất cả các thành viên của Đội Khảo Cổ đều không ai thoát khỏi Tuyết Sơn, trước thảm họa, bạn mãi mãi chỉ chọn bản thân mình, sinh mạng của người bình thường trong mắt bạn không đáng giá một xu, bạn đã từ bỏ nhân tính, an toàn đi đến cuối cùng. \nNhân viên cứu hộ nhìn bạn với ánh mắt phức tạp, bạn không hề động lòng, quay lưng bước vào cơn gió tuyết. Có lẽ vào giữa đêm, những linh hồn đã mất mạng vì sự lạnh lùng của bạn sẽ quây quần quanh giường bạn, lặng lẽ quan sát bạn."
  },
  Event_65401_Name = {
    Text = "Điểm rút lui an toàn"
  },
  Event_65402_ChoiceDesc1 = {
    Text = "[dân chúng sơ tán] Loại bỏ sáng tạo \"đoàn khảo sát\", dựa trên số lượng thành viên của đoàn khảo sát, nhận được các cấp độ khác nhau của \"huy chương cứu nạn\"."
  },
  Event_65402_Desc = {
    Text = "Bạn đã đưa Đội Khảo Cổ an toàn đến điểm di tản, đội cứu hộ đã tiếp quản mọi thứ, những người được cứu ngã xuống đất, như thể đã trải qua một thế giới khác. \n Tuy nhiên, bạn biết rằng, mối nguy thực sự vẫn chưa được giải quyết, con quái vật khổng lồ vẫn đang trú ngụ trong những ngọn núi, đói khát chờ đợi các bạn."
  },
  Event_65402_Name = {
    Text = "Điểm rút lui an toàn"
  },
  Event_65403_ChoiceDesc1 = {
    Text = "[Bổ sung trao đổi] nhận được 25 dấu đen, mỗi thành viên khảo sát khoa học thêm nhận 1 dấu đen (Arg1)."
  },
  Event_65403_ChoiceDesc2 = {
    Text = "[Hứa hẹn cứu viện] Chọn nhận 1 khắcăng. Bổ sung 2 thành viên đoàn khảo sát."
  },
  Event_65403_ChoiceDesc3 = {
    Text = "[Hiệu quả tối đa] Mất 10 thành viên đoàn khảo sát, chọn để nhận một vàng + sáng tạo."
  },
  Event_65403_Desc = {
    Text = "Các bạn đang cố gắng tiến bước trong gió tuyết, theo dõi ánh đèn mờ ảo từ trạm liên lạc khẩn cấp ở xa. \n    ○ Cuối cùng, sau lần thứ vô số cầu nguyện, các bạn đã nhìn thấy ngôi nhà nhỏ chứa đầy hy vọng."
  },
  Event_65403_Name = {
    Text = "Điểm liên lạc"
  },
  Event_65403_Tips3 = {
    Text = "Số lượng đoàn khảo sát chưa đủ"
  },
  Event_65404_ChoiceDesc1 = {Text = "[đi]"},
  Event_65404_Desc = {
    Text = "Các bạn đã biết mật khẩu kho hàng của trung tâm liên lạc từ người liên lạc, và tìm thấy đủ vật tư cho mọi người trong hai ngày. Chúc mừng, ít nhất các bạn sẽ không phải chết đói rét trên tuyết sơn."
  },
  Event_65404_Name = {
    Text = "Điểm liên lạc"
  },
  Event_65415_ChoiceDesc1 = {
    Text = "[Xác nhận]"
  },
  Event_65415_Desc = {
    Text = "Tuyết sơn trong chốc lát đã nuốt chửng, có hai người mãi mãi biến mất trong khe băng tối hun hút, còn các người thì không hề hay biết."
  },
  Event_65415_Name = {Text = "ảo ảnh"},
  Event_65416_ChoiceDesc1 = {
    Text = "[Rời đi] tìm đèn pha"
  },
  Event_65416_ChoiceDesc2 = {
    Text = "[Xâm nhập tuyết lớn] mất 2 thành viên đoàn khảo sát."
  },
  Event_65416_Desc = {
    Text = "Trên núi tuyết bỗng nhiên nổi lên một cơn gió cuồng, tiếng gió rít bên tai như tiếng thét của quái thú, lớp sương trắng xóa trong nháy mắt làm mờ mắt các bạn, dường như có thứ gì đó đang di chuyển trong lớp sương trắng vô tận. \n Các bạn buộc phải dừng lại, cố gắng nhét chân sâu vào lớp tuyết để tránh bị trượt xuống sườn núi."
  },
  Event_65416_Name = {
    Text = "không biết"
  },
  Event_65417_ChoiceDesc1 = {
    Text = "[Bốc hơi thầm lặng] mất 2 thành viên đoàn khảo sát."
  },
  Event_65417_ChoiceDesc2 = {Text = "[đi]"},
  Event_65417_Desc = {
    Text = "Âm thanh gầm gừ vang lên từ bụng núi tuyết, như tiếng gầm rú không hài lòng của quái vật đói, mặt đất rung chuyển, lớp băng dưới lớp tuyết lặng lẽ nứt ra, như thể núi tuyết đang mở miệng. \n Khi sự rung chuyển của mặt đất cuối cùng dừng lại, mọi người nhìn quanh trong sự mơ hồ, bạn quay đầu lại kiểm tra đội ngũ."
  },
  Event_65417_Name = {Text = "ảo ảnh"},
  Event_65468_ChoiceDesc1 = {Text = "[đi]"},
  Event_65468_Desc = {
    Text = "Để đảm bảo tính linh hoạt của đội ngũ, bạn đã từ bỏ những người khó khăn trong hành động, để lại họ trong ngôi nhà nhỏ cô lập này. Điều này có thể nâng cao tỷ lệ sống sót của những người còn lại, nhưng nhìn vào ánh mắt không cam lòng và oán hận của họ, trong lòng bạn hoàn toàn không có bất kỳ cảm xúc nào sao?"
  },
  Event_65468_Name = {
    Text = "Điểm liên lạc"
  },
  Event_65483_ChoiceDesc1 = {Text = "[đi]"},
  Event_65483_Desc = {
    Text = "Bạn đã cứu được một số người, nhưng nhiều người đã mãi mãi nằm lại trên tuyết sơn. Dù sao, bạn đã làm hết sức. \nNhân viên cứu hộ nói rằng họ sẽ ghi nhận công lao của bạn sau. Bạn vẫy tay và bước tiếp vào gió tuyết."
  },
  Event_65483_Name = {
    Text = "Điểm rút lui an toàn"
  },
  Event_65484_ChoiceDesc1 = {Text = "[đi]"},
  Event_65484_Desc = {
    Text = "Bạn không có thời gian để quan tâm đến người khác, để thoát khỏi tuyết sơn, bạn đã chọn cách mang lại hiệu quả cao nhất, trong mắt những người sống sót cuối cùng, bạn có lẽ giống như một ác quỷ. \n Nhân viên cứu hộ nói rằng công lao của bạn sẽ được ghi nhận sau đó, bạn vẫy tay và quay lưng bước vào cơn gió tuyết."
  },
  Event_65484_Name = {
    Text = "Điểm rút lui an toàn"
  },
  Event_65485_ChoiceDesc1 = {Text = "[đi]"},
  Event_65485_Desc = {
    Text = "Dưới sự bảo vệ không tiếc công sức của bạn, toàn bộ đội khảo cổ đều an toàn vô sự, gặp được bạn là may mắn lớn nhất trong bất hạnh của họ, bạn là vị cứu tinh thật sự của họ. \n Bạn đã tạo ra một kỳ tích trong thảm họa, truyền thuyết về người anh hùng tuyết sơn có thể sẽ nhanh chóng lan truyền khắp nơi. Nhân viên cứu hộ trang trọng nói rằng những đóng góp xuất sắc của bạn sẽ được ghi nhận sau này, bạn mỉm cười vẫy tay và quay lưng bước vào cơn gió tuyết."
  },
  Event_65485_Name = {
    Text = "Điểm rút lui an toàn"
  },
  Event_65486_ChoiceDesc1 = {Text = "[đi]"},
  Event_65486_Desc = {
    Text = "Bạn thực sự quan tâm đến sự sống của mọi người, phần lớn mọi người đã được bạn cứu sống. Mọi người khóc lóc và không ngừng cảm ơn bạn vì đã bảo vệ họ. \nNhân viên cứu hộ trang trọng nói rằng những đóng góp xuất sắc của bạn sẽ được ghi nhận sau này, bạn mỉm cười vẫy tay và quay lưng bước vào cơn gió tuyết."
  },
  Event_65486_Name = {
    Text = "Điểm rút lui an toàn"
  },
  Event_65487_ChoiceDesc1 = {Text = "[đi]"},
  Event_65487_Desc = {
    Text = "Bạn đã chống lại thảm họa vô thường và cứu người từ tay tử thần, nhờ nỗ lực của bạn, cái kết bi thảm đã có chút thay đổi. \n Nhân viên cứu hộ trang trọng nói rằng những đóng góp quý giá của bạn sẽ được ghi nhận sau này, bạn mỉm cười vẫy tay và quay lưng bước vào cơn gió tuyết."
  },
  Event_65487_Name = {
    Text = "Điểm rút lui an toàn"
  },
  Event_6817_ChoiceDesc1 = {
    Text = "[Vừa đủ] Nhận được 1 khắcăng từ 3 lựa chọn"
  },
  Event_6817_ChoiceDesc2 = {
    Text = "[Kiên trì đọc] 1 thẻ lệnh ngẫu nhiên nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_6817_Desc = {
    Text = "Ở trên cùng của giá sách gỗ, có một cuốn sách có bìa màu vàng kim. Từ góc nhìn của mặt đất, không thể thấy tên cuốn sách. \nKhông hiểu vì sao, bạn lại có ham muốn đọc nó… Ham muốn này nhanh chóng phình to đến mức không thể kiềm chế, bạn bất chấp nguy cơ làm kinh động người khác, bước lên thang gỗ bên cạnh giá sách, lấy cuốn sách đó xuống, và không thể chờ đợi để đọc ngay… \nNhững ấn tượng mơ hồ nổi lên trong biển tư tưởng của bạn, bạn chìm đắm trong đại dương ảo ảnh…"
  },
  Event_6817_Name = {
    Text = "Cuốn sách vàng"
  },
  Event_6818_ChoiceDesc1 = {
    Text = "[Lắng nghe] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_6818_ChoiceDesc2 = {
    Text = "[Hợp tấu] Với mỗi thân thể được đánh thức có mức điên cuồng đạt từ 50 trở lên, nhận được 15 dấu đen"
  },
  Event_6818_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 1 trong 3 khắcăng"
  },
  Event_6818_Desc = {
    Text = "Tiếng đàn bỗng nhiên truyền đến tai bạn. Những ngón tay màu xanh ngọc nhảy múa trên phím đàn, âm thanh tao nhã tuôn chảy như dòng suối. \n \"Người bạn thân mến, có muốn cùng tôi hòa tấu một khúc nhạc không?\"\nBàn tay không nói nên lời, nó dùng tiếng đàn để hỏi bạn."
  },
  Event_6818_Name = {
    Text = "Hồn ma bên đàn"
  },
  Event_6819_ChoiceDesc1 = {Text = "[đi]"},
  Event_6819_Desc = {
    Text = "Ramona nhìn về hướng nguồn âm thanh, nhưng chỉ kịp thấy một hình bóng đang dần tan biến, như một chiếc máy hát tan dần vào bức tường."
  },
  Event_6819_Name = {
    Text = "Tai người khác"
  },
  Event_6820_ChoiceDesc1 = {
    Text = "[Xóa máy đánh chữ] Xóa 1 thẻ lệnh, nhận 25 dấu đen"
  },
  Event_6820_ChoiceDesc2 = {
    Text = "[Try to identify text] Copy a card from the deck, infect [(Skill.Arg1)]"
  },
  Event_6820_Desc = {
    Text = "Máy đánh chữ trong vali bất ngờ phun ra mực đặc quánh, dưới sự lắc lư của tàu, bắn tung tóe thành dòng thác chảy dài."
  },
  Event_6820_Name = {
    Text = "Bisikan Máy Đánh Chữ"
  },
  Event_6821_ChoiceDesc1 = {Text = "[đi]"},
  Event_6821_Desc = {
    Text = "Vào khoảnh khắc nắm đấm tan biến hình bóng, ký ức ào ạt xâm chiếm não bộ của bạn, những đoạn hồi ức va đập vào linh hồn, gây đau âm ỉ."
  },
  Event_6821_Name = {
    Text = "Fata Morgana"
  },
  Event_6822_ChoiceDesc1 = {
    Text = "[Vứt bỏ giấy] xóa 1 thẻ bài"
  },
  Event_6822_ChoiceDesc2 = {
    Text = "[đặt gần người] nhận được \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_6822_Desc = {
    Text = "Lấy vài tờ giấy bị cuốn vào máy đánh chữ ra, chữ viết bị nhòe tỏa ra mùi mực đậm đặc, bạn lướt qua nội dung của bức thư và vô thức nhíu mày. \n Phần lớn nội dung đã bị xóa, phần còn lại rời rạc và khó hiểu."
  },
  Event_6822_Name = {
    Text = "Thư bị gạch ngang"
  },
  Event_6823_ChoiceDesc1 = {Text = "[đi]"},
  Event_6823_Desc = {
    Text = "Bạn cố gắng nhận dạng những chữ viết mờ trên giấy. Chúng liên tục biến dạng, sau đó hiển thị nội dung hoàn toàn khác biệt. \n \"@2Tôi nghĩ bạn đã đọc được tin tức đó trên báo rồi. \nĐúng vậy, cha bạn đã loại bạn khỏi danh sách thừa kế... chúng tôi cũng không muốn @2\nquỷ dữ, quỷ dữ... \nHãy ngay lập tức ngừng lại mối quan hệ với ông Herbert, nếu không tôi sẽ ngừng hỗ trợ tài chính cho bạn...\""
  },
  Event_6823_Name = {
    Text = "Như gặp mặt"
  },
  Event_6824_ChoiceDesc1 = {
    Text = "[nắm chìa khóa bạc] từ 3 thẻ lệnh chọn 1 thẻ để nhận khắcăng: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_6824_ChoiceDesc2 = {
    Text = "[đóng mắt lại] chọn 1 thân thể được đánh thức, nhiễm [(Skill.Arg1)]"
  },
  Event_6824_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_6824_Desc = {
    Text = "Bạn bị xé nát bởi một cơn phi lý to lớn, cơ thể cong vẹo bò lê trên mặt đất, như thể bị @2 thao túng từ bên ngoài không gian chiều. \n \"Không... không...\"\nLý trí của bạn sụp đổ từng mảnh, tiếng cười điên dại và tiếng la hét đan xen, như một tấm lưới khổng lồ trói buộc ý thức của bạn, chỉ còn lại những tiếng rên rỉ mơ hồ tràn ra khỏi miệng."
  },
  Event_6824_Name = {
    Text = "Mắt ngắm nhìn"
  },
  Event_6825_ChoiceDesc1 = {Text = "[đi]"},
  Event_6825_Desc = {
    Text = "Giao nó cho Người Giữ Gìn xử lý, không biết sẽ thức tỉnh cá thể như thế nào."
  },
  Event_6825_Name = {
    Text = "bạc tâm cô đơn"
  },
  Event_6826_ChoiceDesc1 = {Text = "[đi]"},
  Event_6826_Desc = {
    Text = "Những giai điệu buồn bã chảy đến tai, nỗi u uất và đau đớn tràn ngập não bộ và linh hồn. Khi nhận ra, khóe mắt của ai đó đã ẩm ướt."
  },
  Event_6826_Name = {
    Text = "Âm thanh vô danh"
  },
  Event_6827_ChoiceDesc1 = {
    Text = "[đẩy cửa bên trái] nhận được vật sáng tạo bằng bạc [(RelicConfig.Arg1)]"
  },
  Event_6827_ChoiceDesc2 = {
    Text = "[đẩy cửa bên phải] nhận được sáng tạo vàng \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_6827_Desc = {
    Text = "cửa. cửa. Vô số cánh cửa. \n Số lượng cửa dường như nhiều hơn hẳn so với khi bạn và Ramona đi tuần. \n Các bạn đứng yên trong hành lang, chuẩn bị đẩy cánh cửa tiếp theo. \n Cánh cửa bên trái im lặng, chờ đợi sự xuất hiện của các bạn một cách kín đáo và kiềm chế. \n Cánh cửa bên phải phát ra âm thanh trò chuyện mơ hồ."
  },
  Event_6827_Name = {
    Text = "Cổng Vô Hạn"
  },
  Event_6828_ChoiceDesc1 = {
    Text = "[Lắng nghe] nhận được bạc tạo vật \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_6828_ChoiceDesc2 = {
    Text = "[Bịt tai] nhận được khắcăng chọn 1 trong 3"
  },
  Event_6828_Desc = {
    Text = "Bạn chỉ có thể nghe thấy tiếng gõ phím điên cuồng, như cơn bão ập đến, như tiếng chấn động khi thiên thạch rơi xuống mặt đất, toàn bộ cây đàn đều run rẩy theo. \n Cái búa gõ dây kêu lên những tiếng kêu chói tai, bàn đạp nhảy múa phát ra tiếng rên rỉ đau thương. \n Trong âm thanh kỳ quái, giai điệu quen thuộc bị cuốn vào, cọ xát qua màng nhĩ của bạn."
  },
  Event_6828_Name = {
    Text = "Âm sắc cấm kỵ"
  },
  Event_6829_ChoiceDesc1 = {Text = "[đi]"},
  Event_6829_Desc = {
    Text = "\"Điều tra viên William đã cung cấp cho bạn vật tư khẩn cấp, vui lòng kiểm tra và nhấn nhẹ vào huy hiệu ba lần để xác nhận.\""
  },
  Event_6829_Name = {
    Text = "Hỗ trợ thông tin"
  },
  Event_6830_ChoiceDesc1 = {
    Text = "[đẩy cửa bên trái] nhận được 1 trong 3 khắcăng"
  },
  Event_6830_ChoiceDesc2 = {
    Text = "[Đẩy cửa bên phải] Chọn 1 trong 3 thẻ lệnh để nhận khắcăng: \"(EnchantConfig.Arg1)\", bị nhiễm \"(Skill.Arg2)\""
  },
  Event_6830_Desc = {
    Text = "cửa. cửa. Vô số cánh cửa. \n Số lượng cửa dường như nhiều hơn so với khi bạn và Ramona tuần tra. \n Các bạn đứng lại trong hành lang, chuẩn bị mở cánh cửa tiếp theo. \n Cánh cửa bên trái im lặng, kiềm chế chờ đợi sự hiện diện của các bạn. \n Cánh cửa bên phải phát ra âm thanh trò chuyện mơ hồ."
  },
  Event_6830_Name = {
    Text = "Cánh cửa vô tận"
  },
  Event_6831_ChoiceDesc1 = {
    Text = "[Đọc thư] Xóa 1 thẻ lệnh, nhận Arg1 dấu đen"
  },
  Event_6831_ChoiceDesc2 = {
    Text = "[đóng hộp kỹ]"
  },
  Event_6831_Desc = {
    Text = "Chiếc vali rung lắc không ngừng, như thể một sức sống đang cắn xé vỏ trứng, chuẩn bị phá kén mà ra. \n Bạn bất giác mở hòm, những tờ thư bay tán loạn như bướm được thả ra."
  },
  Event_6831_Name = {
    Text = "Thư không mời"
  },
  Event_6832_ChoiceDesc1 = {Text = "[đi]"},
  Event_6832_Desc = {
    Text = "Tiếng chuông gấp gáp khiến người ta bồn chồn, bạn nhấc ống nghe lên rồi đặt xuống mặt bàn. Tiếng chuông đột ngột im bặt, như thể bị bóp nghẹt, chỉ còn lại dư âm mỏng manh trong tâm trí."
  },
  Event_6832_Name = {
    Text = "Cuộc gọi từ tàu"
  },
  Event_6833_ChoiceDesc1 = {
    Text = "[Nhặt ảnh] Chọn 1 trong 3 thẻ lệnh để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_6833_ChoiceDesc2 = {
    Text = "[Kiểm tra cuộn phim] Nhiễm [(Skill.Arg1)], thay đổi khắcăng nhận được từ tùy chọn 1, có thể sử dụng hai lần"
  },
  Event_6833_Desc = {
    Text = "Ở góc của studio có đặt một chiếc máy ảnh cũ, vài cuộn phim và những bức ảnh rơi rớt lẻ tẻ. Chúng ghi lại trung thực công việc và thẩm mỹ của nghệ nhân bình tượng nến."
  },
  Event_6833_Name = {
    Text = "ghi lại trung thực"
  },
  Event_6834_ChoiceDesc1 = {
    Text = "[Tiếp tục thẩm vấn] tăng Arg1 điểm máu tối đa"
  },
  Event_6834_ChoiceDesc2 = {
    Text = "[Bắt lấy bóng tối] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_6834_Desc = {
    Text = "Bóng tối đọc lên trong bụi vàng: \n \"Những người biết sự thật... \nDùng chìa khóa làm quyền lực, chắc chắn sẽ dẫn dắt con đường của nhân loại.\"\nĐây là một câu châm ngôn cổ xưa. \nTrực giác của bạn nói rằng, nó rất gần với sự thật bạn đang tìm kiếm. \nVà trực giác của bạn luôn đúng."
  },
  Event_6834_Name = {
    Text = "Người sử dụng chìa khóa bạc"
  },
  Event_6835_ChoiceDesc1 = {Text = "[đi]"},
  Event_6835_Desc = {
    Text = "Bạn không ngần ngại thể hiện sự đồng tình với những lời thì thầm cuồng loạn, dưới sự cám dỗ điên cuồng của đối phương, bạn suýt bị trói lên bàn ăn của vị tồn tại đó."
  },
  Event_6835_Name = {
    Text = "Lễ hội nước"
  },
  Event_6836_ChoiceDesc1 = {
    Text = "[Gọi quạ] nhận được 30 dấu đen, nhiễm [(Skill.Arg2)], tiếp tục chọn"
  },
  Event_6836_ChoiceDesc2 = {Text = "[xa cách]"},
  Event_6836_Desc = {
    Text = "Bạn không rời đi, chúng cũng không bao giờ rời bỏ. \nSợi dây kỳ lạ kết nối tinh thần của bạn với chúng, dường như chúng có điều gì đó muốn nói với bạn."
  },
  Event_6836_Name = {
    Text = "Quạ Cô Độc"
  },
  Event_6837_ChoiceDesc1 = {
    Text = "[bỏ qua sự kháng cự] xóa 1 thẻ lệnh, nhận Arg1 dấu đen"
  },
  Event_6837_ChoiceDesc2 = {
    Text = "[rút hai tay]"
  },
  Event_6837_Desc = {
    Text = "Một con, hai con, ba con……\nTrên mặt, trên ngón tay, những đàn bướm như những bông pháo nở rộ trên không trung, lấp lánh ánh sáng như ngọc trong bóng tối.\nChiếc máy đánh chữ này không có bất kỳ công dụng thực tế nào, nhưng nó lại rất giỏi trong việc tạo ra cái đẹp."
  },
  Event_6837_Name = {
    Text = "Bùng nổ cảm hứng"
  },
  Event_6838_ChoiceDesc1 = {Text = "[đi]"},
  Event_6838_Desc = {
    Text = "Việc quan trọng hơn đang ở trước mặt bạn, bạn đóng hộp lại và quyết tâm không để tâm tới nó nữa, còn máy đánh chữ cũng bắt đầu yên lặng."
  },
  Event_6838_Name = {
    Text = "Cảnh báo không mời"
  },
  Event_6839_ChoiceDesc1 = {
    Text = "[Lắng nghe mặt trăng] nhiễm [(Skill.Arg1)]"
  },
  Event_6839_ChoiceDesc2 = {
    Text = "[Lắng nghe sao lùn] nhiễm [(Skill.Arg1)]"
  },
  Event_6839_ChoiceDesc3 = {
    Text = "[Lắng nghe sao băng] mất 25 dấu đen"
  },
  Event_6839_Desc = {
    Text = "Nồng nhiệt, sáng lạn, không bao giờ kết thúc."
  },
  Event_6839_Name = {
    Text = "Âm thanh của sao và mặt trăng"
  },
  Event_6840_ChoiceDesc1 = {Text = "[đi]"},
  Event_6840_Desc = {
    Text = "Trung tâm của ánh sáng là một giọt bạc tâm đã đông đặc, nhưng lý trí nói với bạn rằng nó không phát sáng. \nĐôi mắt đuổi theo nguồn sáng, nhưng lại bất ngờ rơi vào bẫy của bóng tối và sự bí ẩn……"
  },
  Event_6840_Name = {
    Text = "Ánh sáng đêm"
  },
  Event_6841_ChoiceDesc1 = {
    Text = "[rời đi] chọn 1 thẻ lệnh từ 3 thẻ lệnh để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_6841_Desc = {
    Text = "Bắc, lối ra phía Bắc! \n Cũng như quyết định của Ramona, phía Bắc chắc chắn có lối thoát."
  },
  Event_6841_Name = {
    Text = "Đi về phía bắc"
  },
  Event_6842_ChoiceDesc1 = {Text = "[đi]"},
  Event_6842_Desc = {
    Text = "Ồ… bạc nguyên chất, đại diện cho trò đùa của linh hồn đối với bạn. \n Vậy, bạn chọn gì tiếp theo?"
  },
  Event_6842_Name = {
    Text = "Buổi biểu diễn bắt đầu"
  },
  Event_6843_ChoiceDesc1 = {
    Text = "[Rời đi] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_6843_Desc = {
    Text = "Bạn lắc đầu, gạt bỏ âm thanh ra khỏi tâm trí. \nMột tiếng thở dài mơ hồ, mang đến sự giúp đỡ nào đó."
  },
  Event_6843_Name = {
    Text = "Đi về phía bắc"
  },
  Event_6844_ChoiceDesc1 = {
    Text = "[tiến sâu vào hành lang】 bị lây nhiễm 「(Skill.Arg1)」, có muốn tiếp tục tiến lên không"
  },
  Event_6844_ChoiceDesc2 = {
    Text = "[đi ngược hướng] nhận được 25 dấu đen"
  },
  Event_6844_Desc = {
    Text = "Ánh trăng biến mất, bị hành lang nuốt chửng, chỉ còn lại cánh cửa toả ra hơi thở điềm gở trước mắt."
  },
  Event_6844_Name = {
    Text = "Hành lang yên tĩnh"
  },
  Event_6845_ChoiceDesc1 = {
    Text = "[tiến sâu vào hành lang] ngẫu nhiên nhận một thẻ lệnh được khắc:[(EnchantConfig.Arg1)], bạn có muốn tiếp tục di chuyển về phía trước không"
  },
  Event_6845_ChoiceDesc2 = {
    Text = "[đi ngược hướng] nhận được 25 dấu đen"
  },
  Event_6845_Desc = {
    Text = "Không biết toàn bộ, không nên đi sâu."
  },
  Event_6845_Name = {
    Text = "Hành lang yên tĩnh"
  },
  Event_6846_ChoiceDesc1 = {
    Text = "[tiến sâu vào hành lang】 bị lây nhiễm 「(Skill.Arg1)」, có muốn tiếp tục tiến lên không"
  },
  Event_6846_ChoiceDesc2 = {
    Text = "[đi ngược hướng] nhận được 25 dấu đen"
  },
  Event_6846_Desc = {
    Text = "Cánh cửa bên trái phát ra tiếng cười gằn ghê rợn, nó rung động nhẹ nhàng, rơi rớt những tia ác ý."
  },
  Event_6846_Name = {
    Text = "Hành lang yên tĩnh"
  },
  Event_6847_ChoiceDesc1 = {
    Text = "[thâm nhập hồi lang] nhận được bạc sáng tạo [(RelicConfig.Arg1)], có muốn tiếp tục tiến lên không"
  },
  Event_6847_ChoiceDesc2 = {
    Text = "[đi ngược hướng] nhận được 25 dấu đen"
  },
  Event_6847_Desc = {
    Text = "Cánh cửa bên phải để ngỏ, máu chảy trên mặt đất theo một đường đi đã định."
  },
  Event_6847_Name = {
    Text = "Hành lang yên tĩnh"
  },
  Event_6848_ChoiceDesc1 = {
    Text = "[Đã không còn bất cứ thứ gì, bạn đã lui ra]"
  },
  Event_6848_Desc = {
    Text = "Ai nói nhất định phải lao đầu vào? Lùi một bước, có thể sẽ có không gian tự do."
  },
  Event_6848_Name = {
    Text = "Hành lang yên tĩnh"
  },
  Event_6849_ChoiceDesc1 = {
    Text = "[sửa chữa tượng sáp] Chọn thẻ bài và làm giảm tiêu thụ sức tính toán của nó đi 1"
  },
  Event_6849_Desc = {
    Text = "Công việc sửa chữa bức bình tượng nến vẫn đang diễn ra. \n Bạn không phải là một nghệ nhân bình tượng nến chuyên nghiệp, cũng không từng nhận được giáo dục hệ thống về thẩm mỹ. \n Nhưng bạn vẫn bắt đầu đổ khuôn, tạo hình, tô màu một cách thành thạo... \n Giống như bạn sinh ra đã cầm sẵn dao khắc. \n Giống như nó sinh ra đã phải khiếm khuyết, chỉ để chờ đợi sự khắc họa của bạn."
  },
  Event_6849_Name = {
    Text = "Bình tượng nến chưa hoàn thành"
  },
  Event_6850_ChoiceDesc1 = {
    Text = "[sửa chữa tượng sáp] Chọn thẻ bài và làm giảm tiêu thụ sức tính toán của nó đi 1"
  },
  Event_6850_Desc = {
    Text = "Galatea, Galatea... \nBạn lần theo tiếng gọi và một lần nữa tìm thấy bình tượng nến chưa hoàn thành. \nCô ấy trông hoàn mỹ đến mức khiến người ta cảm thấy bất an. \n \"Sự xấu xí là một vết nứt trên sự hoàn hảo.\"\nTrong giây phút cuối cùng, bạn quyết định làm điều gì đó."
  },
  Event_6850_Name = {
    Text = "Bình tượng nến chưa hoàn thành"
  },
  Event_6851_ChoiceDesc1 = {
    Text = "[Chấp nhận ảo giác] 1 thẻ lệnh ngẫu nhiên nhận được Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_6851_ChoiceDesc2 = {
    Text = "[Phủ nhận ảo giác] từ 3 thẻ lệnh chọn 1 để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_6851_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_6851_Desc = {
    Text = "Dưới cây cầu sắt nặng nề trong bóng tối, trên bãi sông tĩnh lặng đầy lau sậy, bỗng nhiên một con bướm phát sáng bay ra. \n Con bướm nhẹ nhàng đậu trên lòng bàn tay bạn, những tiếng hét tồi tệ đã ngừng lại, thay vào đó là tiếng gầm rú của tàu hỏa chạy qua những khung thép rỉ sét, tiếng lách cách của than đang cháy, tiếng ma sát kim loại của trục quay..."
  },
  Event_6851_Name = {
    Text = "Ảo giác đường sắt"
  },
  Event_6852_ChoiceDesc1 = {Text = "[đi]"},
  Event_6852_Desc = {
    Text = "Vâng, chạy trốn. Bạn đang bị một loài sinh vật đuổi theo, bản năng sinh tồn khiến bạn chạy như điên, cho đến khi không còn đường nào để chạy. Không đúng, lẽ ra phải không có lối thoát... Chẳng phải chó địa ngục sao?"
  },
  Event_6852_Name = {Text = "Chạy"},
  Event_6853_ChoiceDesc1 = {
    Text = "[Đây không phải là thật] nhận được vật phẩm bạc [(RelicConfig.Arg1)]"
  },
  Event_6853_ChoiceDesc2 = {
    Text = "[rơi xuống, rơi xuống...] nhận được vật tạo vàng \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_6853_Desc = {
    Text = "Chiếc gương rơi xuống đất có khung hình tinh xảo, bên trong khung lại có khung, bên trong khung lại có khung……\nAlice nhảy xuống, rơi mãi trong cái hang thỏ vô tận, cô nhìn thấy một chiếc gương lại một chiếc gương, một người lại một người bị mắc kẹt ở đây, chỉ riêng không nhìn thấy chính mình."
  },
  Event_6853_Name = {
    Text = "Gương trong gương"
  },
  Event_6854_ChoiceDesc1 = {Text = "[đi]"},
  Event_6854_Desc = {
    Text = "Bạn nhìn qua lớp màn tuyết trên cửa sổ xuống dãy tuyết sơn, đàn kiến đen đang đuổi theo một con……\nDòng suy nghĩ của bạn bị ngắt quãng."
  },
  Event_6854_Name = {
    Text = "Ký ức núi lửa"
  },
  Event_6855_ChoiceDesc1 = {
    Text = "[Lên trước và nắm lấy] được 25 dấu đen"
  },
  Event_6855_ChoiceDesc2 = {
    Text = "[Phản hồi hữu hảo]50% cơ hội nhận được 50 dấu đen, 50% cơ hội không có gì cả"
  },
  Event_6855_Desc = {
    Text = "Một con mèo không rõ từ đâu xuất hiện ngồi giữa dung dịch ăn mòn, thân hình mờ ảo cho thấy nó chắc hẳn là cư dân của chiều không gian tinh thần. \n Bóng hình không rõ nét này nhìn Ramona bằng ánh mắt thông minh, nó nâng bàn chân trước trắng muốt, như thể vẫy tay ra hiệu cho cô."
  },
  Event_6855_Name = {
    Text = "Cư dân du mục"
  },
  Event_6856_ChoiceDesc1 = {Text = "[đi]"},
  Event_6856_Desc = {
    Text = "Một bức tranh chân dung vui tươi. \nCác bình tượng nến được trang điểm lộng lẫy, ngồi ngay ngắn trên ghế, trên mặt mang nụ cười phóng đại giống nhau. \nChúng hòa hợp đến mức như bạn có thể thấy ở bất kỳ bệnh viện tâm thần nào. \n\nKý tên: Aluvi năm 305, @2Rogers"
  },
  Event_6856_Name = {
    Text = "Galeri chân dung"
  },
  Event_6857_ChoiceDesc1 = {Text = "[đi]"},
  Event_6857_Desc = {
    Text = "Bạn cẩn thận lấy xuống phân mảnh và kiểm tra kỹ lưỡng. Nó lại không động đậy nữa. \n \"Vụng về quá, đừng loạn động,\"đóa gõ nhẹ vào sau đầu bạn,\"Trong thời gian ngắn tôi không thể chế tạo ra mảnh thứ hai cho bạn được.\""
  },
  Event_6857_Name = {
    Text = "Brooch Bồn Khoảng"
  },
  Event_6858_ChoiceDesc1 = {
    Text = "[sử dụng chìa khóa]"
  },
  Event_6858_ChoiceDesc2 = {Text = "[đi]"},
  Event_6858_Desc = {
    Text = "Một cánh cửa chặn đường đi của bạn. Bạn đã dùng hết mọi cách, nhưng nó vẫn đứng im."
  },
  Event_6858_Name = {
    Text = "cánh cửa rỉ sét"
  },
  Event_6858_Tips1 = {
    Text = "Cần phải có \"chìa khóa rỉ sét\""
  },
  Event_6859_ChoiceDesc1 = {Text = "[đi]"},
  Event_6859_Desc = {
    Text = "Bạn cảm thấy xấu hổ vì sự võ đoán của mình. \nMột Người Giữ Gìn hợp cách phải cẩn trọng, bạn không nên vội vàng kết luận rằng chúng không phải là \"hàng chất lượng cao\". \nVì vậy, bạn quyết định quan sát kỹ lưỡng hơn. Năm phút trôi qua, mười phút trôi qua... \nĐược rồi, bây giờ bạn có thể đưa ra kết luận—— \nĐúng là hàng kém chất lượng."
  },
  Event_6859_Name = {
    Text = "Linh hồn bị trói buộc"
  },
  Event_6860_ChoiceDesc1 = {Text = "[đi]"},
  Event_6860_Desc = {
    Text = "Bạn và những người bạn đồng hành đã buông vũ khí. \nĐiều này không phải vì lòng từ bi, mà là bạn hiểu rằng cơ thể run rẩy của họ không thể trụ được lâu. \nThực tế đã chứng minh nhận định của bạn là đúng."
  },
  Event_6860_Name = {Text = "bài tập"},
  Event_6861_ChoiceDesc1 = {Text = "[đi]"},
  Event_6861_Desc = {
    Text = "\"Đến mà bắt tôi đi!\"\n \"Nào, đồ ngốc!\"\n \"Có bản lĩnh thì hãy bắt chúng tôi lại!\"\nTiếng nói của bọn trẻ đầy vẻ đắc thắng. \n \"Đồ chết tiệt! Đứng lại cho ta!\"\nTiếng người lớn thở hồng hộc."
  },
  Event_6861_Name = {
    Text = "Kí ức của chúng tôi"
  },
  Event_6862_ChoiceDesc1 = {
    Text = "[Nhập] Vượt qua sương mù để đến phía bên kia."
  },
  Event_6862_ChoiceDesc2 = {Text = "[đi]"},
  Event_6862_Desc = {
    Text = "Đây là người bạn đang tìm, bạn đã hoàn thành nhiệm vụ."
  },
  Event_6862_Name = {
    Text = "đường hầm đơn hàng 26"
  },
  Event_6863_ChoiceDesc1 = {
    Text = "[rời đi] nhận được bạc tạo vật [(RelicConfig.Arg1)]"
  },
  Event_6863_Desc = {
    Text = "À! Chỉ thiếu một chút! Đợi đã, tại sao ba con xúc xắc lại ra mười điểm! \nCác con xúc xắc nằm yên trước mặt bạn, trông ngoan ngoãn và vô tội."
  },
  Event_6863_Name = {
    Text = "Cuộc cờ bạc vô tận"
  },
  Event_6864_ChoiceDesc1 = {
    Text = "[Rời đi] nhận được vật tạo vàng[(RelicConfig.Arg1)]"
  },
  Event_6864_Desc = {
    Text = "Chết tiệt! Không phải là sáu giờ, nhưng vẫn còn kiếm được chút ít. \nVậy, chúng rốt cuộc là mấy giờ?"
  },
  Event_6864_Name = {
    Text = "Cuộc cờ bạc vô tận"
  },
  Event_6865_ChoiceDesc1 = {
    Text = "[rời đi] nhận được 50 dấu đen"
  },
  Event_6865_Desc = {
    Text = "Dù không đoán trúng, nhưng cũng có thể chấp nhận được. \nÀ, chúng rốt cuộc đã bầu là mấy điểm?"
  },
  Event_6865_Name = {
    Text = "Cuộc cờ bạc vô tận"
  },
  Event_6866_ChoiceDesc1 = {Text = "[đi]"},
  Event_6866_Desc = {
    Text = "Bạn cúi đầu chọn lọc những mảnh vữa, ghép từng mảnh của cô ấy lại một cách cẩn thận, phần thân thể của cô ấy dần dần thành hình trong bàn tay bạn."
  },
  Event_6866_Name = {
    Text = "Lắp ráp tàn dư"
  },
  Event_6867_ChoiceDesc1 = {
    Text = "[nhặt chìa khóa]"
  },
  Event_6867_Desc = {
    Text = "Một chuỗi chìa khóa rỉ sét. Có thể sử dụng để mở khóa cửa."
  },
  Event_6867_Name = {
    Text = "chìa khóa rỉ sét"
  },
  Event_6868_ChoiceDesc1 = {
    Text = "[Mặt tích cực] 50% cơ hội nhận vật tạo vàng \"(RelicConfig.Arg2)\", 50% cơ hội mắc phải \"(Skill.Arg3)\""
  },
  Event_6868_ChoiceDesc2 = {
    Text = "[phản diện] 50% xác suất nhận được 75 dấu đen, 50% xác suất bị lây nhiễm [(Skill.Arg3)]"
  },
  Event_6868_ChoiceDesc3 = {
    Text = "[Vui lòng chọn trước] 50% xác suất nhận được vật bị nguyền rủa \"(RelicConfig.Arg2)\", và 50% xác suất nhiễm \"(Skill.Arg3)\""
  },
  Event_6868_Desc = {
    Text = "Chỉ là một ván cờ bạc, bạn sẽ không thua đâu. \nĐồng xu khắc hoa văn được ném lên cao, rồi nhanh chóng rơi xuống, được lòng bàn tay bạn làm ấm lên."
  },
  Event_6868_Name = {
    Text = "Người chơi bạc nổi tiếng"
  },
  Event_6869_ChoiceDesc1 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_6869_Desc = {
    Text = "\"Người được số phận ưu ái, cũng sẽ bị số phận lật đổ.\"\nBạn chọn rời đi."
  },
  Event_6869_Name = {
    Text = "Người chơi bạc nổi tiếng"
  },
  Event_6870_ChoiceDesc1 = {Text = "[đi]"},
  Event_6870_Desc = {
    Text = "\"Người Giữ Gìn.\"\nGiọng của Ramona khiến bạn tỉnh lại, nhưng cảm giác rơi xuống vẫn chưa biến mất."
  },
  Event_6870_Name = {
    Text = "Gương trong gương"
  },
  Event_6871_ChoiceDesc1 = {Text = "[đi]"},
  Event_6871_Desc = {
    Text = "Người ta nói rằng, khúc nhạc đêm là một bài hát xuất phát từ tình yêu. \n Đó là những bản nhạc tình tứ được chơi vào những đêm hè, bên ngoài cửa sổ của những người yêu nhau, khi có vài người bạn cùng nhau. \n Tự nhiên, nông cạn, không phù hợp với thẩm mỹ của Rogers, nhưng vẫn trở thành một trong những tác phẩm giữ lại của ông. \n Có lẽ chỉ có chính ông mới biết lý do."
  },
  Event_6871_Name = {
    Text = "khẩu vị kém"
  },
  Event_6872_ChoiceDesc1 = {Text = "[đi]"},
  Event_6872_Desc = {
    Text = "Bạn từ chối bị cám dỗ bởi những lời nói vô nghĩa của chúng. \n Bạn nói: \"Lời nói dối! Các ngươi bị mắc kẹt trong đêm tối vĩnh cửu, làm sao có thể đi xuyên vũ trụ?\"\n Những con mắt cười lên. Hàng triệu tiếng cười tụ lại thành một làn sóng lớn, trái tim bạn cũng rung động theo. \n Con mắt nói: \"Bằng cách cướp đoạt những con mắt khác. Mỗi con mắt đều là một vũ trụ. Khi bạn sở hữu một nghìn con mắt, bạn sẽ bắt đầu cuộc hành trình thực sự qua thời gian và không gian.\""
  },
  Event_6872_Name = {Text = "mắt"},
  Event_6873_ChoiceDesc1 = {
    Text = "[Lãnh thưởng] Chọn 1 trong 3 vật tạo vàng"
  },
  Event_6873_Desc = {
    Text = "Ồ, cái bóng phản chiếu kinh khủng kia chính là bản thân bạn. \nSự ác ý phun trào hòa quyện với bùn đen dưới chân bạn, vặn vẹo trong điệu nhảy chung. Nếu không phiền, nó cũng muốn leo lên vai bạn."
  },
  Event_6873_Name = {
    Text = "Dưới bề mặt gương"
  },
  Event_6874_ChoiceDesc1 = {Text = "[đi]"},
  Event_6874_Desc = {
    Text = "Không lâu sau, sự ràng buộc bất ngờ nới lỏng, khiến bạn vấp ngã. \nBạn quay đầu nhìn vào những sợi dây im lặng — \"Đừng khuấy động cát chảy\", câu này có lẽ cũng áp dụng trong thâm cảnh."
  },
  Event_6874_Name = {Text = "Sâu lún"},
  Event_6875_ChoiceDesc1 = {Text = "[đi]"},
  Event_6875_Desc = {
    Text = "Lửa linh tri thức bùng lên, thiêu rụi mọi ràng buộc —— \nít nhất, bạn nghĩ như vậy."
  },
  Event_6875_Name = {Text = "Sâu lún"},
  Event_6876_ChoiceDesc1 = {Text = "[đi]"},
  Event_6876_Desc = {
    Text = "Dốc sức thoát khỏi sự hạn chế, những sợi chỉ cắt rách quần áo, để lại những vết máu nhỏ trên da. \n Dù mạng nhện để lại điều gì như phí qua đường, nhưng tâm trạng vẫn như được giải thoát — bạn đã tự do."
  },
  Event_6876_Name = {Text = "Sâu lún"},
  Event_6877_ChoiceDesc1 = {Text = "[đi]"},
  Event_6877_Desc = {
    Text = "Thông điệp do u nhọt rỗng rỗng tạo ra, phần lớn thông tin mà nó mang lại cũng thường bị xóa bỏ. \nBạn không tìm thấy gì hữu ích trên bức thư, liền xé bỏ và rải xuống một cách vô tình."
  },
  Event_6877_Name = {
    Text = "Chương mục Bướm"
  },
  Event_6878_ChoiceDesc1 = {Text = "[đi]"},
  Event_6878_Desc = {
    Text = "Dù văn bản bị cố tình xóa đi, bạn vẫn có thể nhận ra rõ ràng —— giá trị của bức thư."
  },
  Event_6878_Name = {
    Text = "Chương mục Bướm"
  },
  Event_6879_ChoiceDesc1 = {Text = "[đi]"},
  Event_6879_Desc = {
    Text = "Cẩn thận vẫn hơn. \nRamona cúi người, trở lại hành lang và lẻn vào phòng tiếp theo."
  },
  Event_6879_Name = {
    Text = "Phản ánh trong cửa sổ"
  },
  Event_6880_ChoiceDesc1 = {Text = "[đi]"},
  Event_6880_Desc = {
    Text = "Bạn phát ra một tiếng hét đầy tuyệt vọng. \nBầy quạ dường như bị giọng bạn thu hút, nhanh chóng biến mất không còn dấu vết, để lại những dấu vết đen tối u ám."
  },
  Event_6880_Name = {
    Text = "Bài hát của đàn quạ"
  },
  Event_6881_ChoiceDesc1 = {Text = "[đi]"},
  Event_6881_Desc = {
    Text = "Bạn co thân thể lại, cố gắng thu nhỏ bản thân thành một điểm đen. \nNhư vậy chúng sẽ không chú ý đến bạn rồi nhỉ. \nKhông biết đã qua bao lâu, bạn mở đôi mắt. \nBạn thấy ánh sáng."
  },
  Event_6881_Name = {
    Text = "Bài hát của đàn quạ"
  },
  Event_6882_ChoiceDesc1 = {Text = "[đi]"},
  Event_6882_Desc = {
    Text = "Bóng tối nhẹ nhàng trôi qua kẽ tay, để lại một vùng bụi ánh vàng."
  },
  Event_6882_Name = {
    Text = "Người sử dụng chìa khóa bạc"
  },
  Event_6883_ChoiceDesc1 = {Text = "[đi]"},
  Event_6883_Desc = {
    Text = "Bạn xoa nắn tóc mình một cách bừa bãi, ảo giác và những suy nghĩ điên rồ đua nhau xuất hiện trong đầu bạn, những khối bọc chất lỏng đen sẫm ẩn sâu bên trong. \n Cắt mở nó ra, nó sẽ ban cho bạn món quà gì?"
  },
  Event_6883_Name = {
    Text = "Khuấy động não bộ"
  },
  Event_6884_ChoiceDesc1 = {Text = "[đi]"},
  Event_6884_Desc = {
    Text = "Vết dầu màu sắc dần dần lấp đầy tầm nhìn, cảm xúc của bạn chìm vào cuộc vui không trật tự."
  },
  Event_6884_Name = {
    Text = "Khuấy động não bộ"
  },
  Event_6885_ChoiceDesc1 = {
    Text = "[thu vào túi]"
  },
  Event_6885_Desc = {
    Text = "Một chất bạc có trạng thái gần như thủy ngân, được chiết xuất từ dịch nhầy rỗng rỗng, mang trong mình sức mạnh tinh thần lớn, dùng chủ yếu để liên kết nhiều thân thể được đánh thức hơn trong các nghi lễ."
  },
  Event_6885_Name = {Text = "bạc tâm"},
  Event_6886_ChoiceDesc1 = {Text = "[đi]"},
  Event_6886_Desc = {
    Text = "Tiếng cười vui vẻ tuôn ra từ bên trong hộp, sau khi ánh sáng ấm áp tan biến, bạn nhìn thấy một tấm thẻ, trên đó vẽ ba người que: bạn, Ramona tóc bạc và Orci tóc vàng. Bên cạnh còn có một dòng chữ. \n   \"Cảm ơn các bạn!\""
  },
  Event_6886_Name = {
    Text = "Quà tặng tốt bụng"
  },
  Event_6887_ChoiceDesc1 = {Text = "[đi]"},
  Event_6887_Desc = {
    Text = "Thịt thân của bạn đã tránh được đàn bướm, nhưng chúng không đánh mất mục tiêu, chui vào chiếc vali của bạn và tham lam hút cạn mực từ máy đánh chữ."
  },
  Event_6887_Name = {
    Text = "Sóng cuồng loạn"
  },
  Event_6888_ChoiceDesc1 = {
    Text = "[Chỉ ra lỗi sai] Chọn 1 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_6888_ChoiceDesc2 = {
    Text = "[Sau khi thưởng thức phần trình diễn] Mỗi khi có một thân thể được đánh thức với mức điên cuồng 50 trở lên, nhận được 15 dấu đen"
  },
  Event_6888_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 1 trong 3 khắcăng"
  },
  Event_6888_Desc = {
    Text = "Bình tượng nến của cậu bé ngồi trước cây đàn piano đang luyện tập. \n Thầy giáo của cậu——cũng là một bình tượng nến, đang hướng dẫn bên cạnh. \n 133, 355, 244…… \n Sai rồi, mỗi nốt đều sai."
  },
  Event_6888_Name = {
    Text = "Bài học piano"
  },
  Event_6889_ChoiceDesc1 = {
    Text = "[bỏ qua sự kháng cự] xóa 1 thẻ lệnh, nhận Arg1 dấu đen"
  },
  Event_6889_ChoiceDesc2 = {
    Text = "[rút hai tay]"
  },
  Event_6889_Desc = {
    Text = "Bạn không thể chống lại sự thôi thúc trong lòng. \nNgón tay như đứa trẻ lạc trong rừng, lang thang, nô đùa trên bàn phím… \nDần dần, có những con bướm bay ra từ máy đánh chữ. \nMột con, hai con, ba con… \nTrên mặt, trên ngón tay, những đàn bướm như những bông pháo nở rộ trên không trung, lấp lánh ánh sáng như ngọc trong bóng tối. \nChiếc máy đánh chữ này không có bất kỳ công dụng thực tế nào, nhưng nó lại rất giỏi trong việc tạo ra cái đẹp."
  },
  Event_6889_Name = {
    Text = "Bùng nổ cảm hứng"
  },
  Event_6890_ChoiceDesc1 = {Text = "[đi]"},
  Event_6890_Desc = {
    Text = "Bạn nâng tờ giấy lên dưới ánh đèn màu đỏ sẫm, sợ bỏ qua một chi tiết nào. \nĐây là một bản báo cáo khám sức khỏe, người được kiểm tra chính là Mason. \n \"Cân nặng 40kg, nồng độ oxy trong máu bình thường, tỷ lệ đồng điều 30%, giá trị cảm ứng...\"\nBạn định tiếp tục đọc thì chữ viết dần biến mất. \nMọi thứ sạch sẽ như thể chưa từng có chuyện gì xảy ra."
  },
  Event_6890_Name = {
    Text = "Máy đánh chữ"
  },
  Event_6891_ChoiceDesc1 = {Text = "[đi]"},
  Event_6891_Desc = {
    Text = "Đúng, bạn không đang chạy trốn, bạn đang săn đuổi một mục tiêu chắc chắn — con \"chó địa ngục\"đang lách qua những con hẻm nhỏ đầy tuyết ẩm ướt. Bạn sẽ không bao giờ quên điều này, giống như bạn sẽ không bao giờ quên khuôn mặt của người đã kéo bạn ra khỏi đống đổ nát vào ngày đó ở Tonguska.... Là ai vậy?"
  },
  Event_6891_Name = {Text = "Chạy"},
  Event_6892_ChoiceDesc1 = {Text = "[đi]"},
  Event_6892_Desc = {
    Text = "Trong không gian bên ngoài sự cách ly, bạn chỉ có thể dựa vào chính mình."
  },
  Event_6892_Name = {
    Text = "Hành giả ác mộng"
  },
  Event_6893_ChoiceDesc1 = {Text = "[đi]"},
  Event_6893_Desc = {
    Text = "Nguy cơ và rủi ro song hành. Khoảnh khắc chạm vào ổ khóa sắt, chất nhầy ăn mòn đã gây bỏng rát lòng bàn tay bạn. Hy vọng rằng điều chờ phía sau cánh cửa sẽ xứng đáng với những hy sinh này."
  },
  Event_6893_Name = {
    Text = "Sau cánh cửa sắt"
  },
  Event_6894_ChoiceDesc1 = {Text = "[đi]"},
  Event_6894_Desc = {
    Text = "Trong thế giới chưa từng tiếp xúc, tinh thần lung lay của bạn chưa suy thoái đến mức mất lý trí. \nĐiều chưa biết thật đáng sợ, bạn cảm thấy vô cùng rõ ràng."
  },
  Event_6894_Name = {
    Text = "Hành giả ác mộng"
  },
  Event_6895_ChoiceDesc1 = {
    Text = "[hét lớn] nhận được bạc tạo vật \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_6895_ChoiceDesc2 = {
    Text = "[Cảm nhận sự yên tĩnh] nhận được vật tạo vàng \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\", \"(Skill.Arg3)\""
  },
  Event_6895_ChoiceDesc3 = {
    Text = "[lên mặt nước] nhận được 25 dấu đen"
  },
  Event_6895_Desc = {
    Text = "Bạn nghe thấy sự yên lặng. \nMột sự yên lặng được khuếch đại, giống như tiếng sóng biển, lấp đầy cả không gian. \n\nBạn ngẩng đầu lên, giống như một điểm nhỏ bé đang ngắm nhìn bầu trời sao."
  },
  Event_6895_Name = {
    Text = "Nước của quá khứ"
  },
  Event_6896_ChoiceDesc1 = {Text = "[đi]"},
  Event_6896_Desc = {
    Text = "Bạn dựng tai lên, tìm kiếm nguồn gốc của âm thanh, cố gắng lôi ra kẻ gây rối này. \n Nhưng giống như đang cố tình trêu chọc, ngay khi bạn nghĩ rằng đã đẩy người ta vào đường cùng, bạn lại luôn va phải cái vòng lặp như ma quái, bạn lại bị quay trở lại điểm xuất phát. \n Bạn chán nản đá một cú vào tường gạch, nhưng từ trên tường rơi xuống một viên gạch, ánh sáng bí ẩn nhấp nháy trong cái lỗ hổng trên tường."
  },
  Event_6896_Name = {
    Text = "Dấu Vết Bí Ẩn"
  },
  Event_6897_ChoiceDesc1 = {Text = "[đi]"},
  Event_6897_Desc = {
    Text = "Chắc chắn là vấn đề phát nhạc, nhất định là như vậy. \n Bạn không tin vào điều xui xẻo, quay lại kim máy hát, khó khăn chịu đựng giai điệu khó nghe ở phần đầu, nhưng âm thanh gõ trong ký ức lại không vang lên. \n Phía sau bạn trống rỗng, bóng đen nhỏ bé trên mặt đất đang lén lút rời đi."
  },
  Event_6897_Name = {
    Text = "Dấu Vết Bí Ẩn"
  },
  Event_6898_ChoiceDesc1 = {Text = "[đi]"},
  Event_6898_Desc = {
    Text = "Không có ai bên cạnh bạn, bí mật của tiếng gõ chắc chắn ẩn giấu trong cơ cấu bên trong của đĩa than. \n Vì sự tự tin vào phán đoán của bản thân, bạn đã tháo rời chiếc đĩa than cũ kỹ. \n Ngoài những linh kiện kim loại bị ăn mòn bên trong và một lớp bụi dày, bạn không tìm thấy gì cả. \n Chỉ còn lại một tiếng cười khẽ, tỏa ra trong sương mù, nhẹ nhàng như thể đang ở trong giấc mơ."
  },
  Event_6898_Name = {
    Text = "Dấu Vết Bí Ẩn"
  },
  Event_6899_ChoiceDesc1 = {
    Text = "[Chất trắng của Kẻ ngốc] phục hồi Arg1 điểm sức sống"
  },
  Event_6899_ChoiceDesc2 = {
    Text = "[Trái tim của kẻ điên] một thẻ lệnh ngẫu nhiên nhận được khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_6899_ChoiceDesc3 = {
    Text = "[Từ chối ăn]nhận được 25 dấu đen"
  },
  Event_6899_Desc = {
    Text = "\"Thịt trắng của kẻ ngu ngốc ngon như canh cá đã nấu sôi, tim của kẻ điên thì nướng thành một miếng scone nóng hổi, đầy máu.\"\nBóng đen cười gằn, đưa món ăn chứa nguyên liệu không rõ ràng đến trước mặt bạn.\nBạn hít sâu một hơi, hương thơm bốn phía xộc thẳng vào mũi, tuyến nước bọt của bạn đầu hàng không chút kháng cự, dạ dày và ruột co thắt đau đớn, phát ra những tiếng kêu khẽ biểu lộ sự thèm khát."
  },
  Event_6899_Name = {
    Text = "Lễ hội cơ thể"
  },
  Event_6900_ChoiceDesc1 = {
    Text = "[chạm chuông gió] nhiễm \"(Skill.Arg1)\", ngẫu nhiên một thẻ lệnh nhận khắcăng: \"(EnchantConfig.Arg2)\""
  },
  Event_6900_ChoiceDesc2 = {
    Text = "[Quan sát chuông gió] nhiễm \"(Skill.Arg1)\", ngẫu nhiên 1 thẻ lệnh nhận được khắcăng: \"(EnchantConfig.Arg2)\""
  },
  Event_6900_ChoiceDesc3 = {
    Text = "[Không làm gì cả] ngẫu nhiên 1 thẻ lệnh nhận được khắcăng:[(EnchantConfig.Arg1)]"
  },
  Event_6900_Desc = {
    Text = "Đinh đinh, đinh đinh......\nĐây là một chiếc phong linh gỉ sét, giai điệu vụng về len lỏi qua từng kẽ hở."
  },
  Event_6900_Name = {
    Text = "Dây gió rỉ sét"
  },
  Event_6901_ChoiceDesc1 = {
    Text = "[Quan sát và chờ đợi] cố gắng sống sót"
  },
  Event_6901_ChoiceDesc2 = {
    Text = "[Vung vũ khí] thử thoát"
  },
  Event_6901_ChoiceDesc3 = {
    Text = "[nắm chặt một tay] nhận được 25 dấu đen"
  },
  Event_6901_Desc = {
    Text = "Mặt đất dưới chân bạn đột nhiên xuất hiện một vùng đầm lầy đen, vô số bàn tay từ trong đó trồi lên. \n Chúng có đủ loại màu da, chất liệu và kết cấu, màu xanh công công, có vảy, có mắt, như thể đến từ vô số chiều không gian và đang cố gắng kéo người xui xẻo tiếp theo vào gia đình lớn của chúng. \n Bạn quyết định——"
  },
  Event_6901_Name = {
    Text = "Đầm lầy Tối"
  },
  Event_6902_ChoiceDesc1 = {
    Text = "[Giữ nó lại] Lấy ngẫu nhiên 3 thẻ lệnh từ bộ bài và chọn 1 thẻ để sao chép"
  },
  Event_6902_ChoiceDesc2 = {
    Text = "[Lắc thử một cái] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", lây nhiễm \"(Skill.Arg2)\""
  },
  Event_6902_ChoiceDesc3 = {
    Text = "[Không làm gì cả] nhận được 25 dấu đen"
  },
  Event_6902_Desc = {
    Text = "Đinh đinh, đinh đinh......\nĐây là một chiếc phong linh gỉ sét, giai điệu vụng về len lỏi qua từng kẽ hở."
  },
  Event_6902_Name = {
    Text = "Chuông gió nhỏ"
  },
  Event_6903_ChoiceDesc1 = {
    Text = "[Phản bác chúng] nhận được bạc sáng tạo[(RelicConfig.Arg1)], chọn nhiễm 1 lần triệu chứng"
  },
  Event_6903_ChoiceDesc2 = {
    Text = "[đồng lòng với chúng] chọn 1 thẻ lệnh từ 3 thẻ lệnh để nhận khắcăng: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_6903_ChoiceDesc3 = {
    Text = "[Đưa ra quan điểm mới] nhận được 25 dấu đen"
  },
  Event_6903_Desc = {
    Text = "\"Hãy giữ khoảng cách với chúng tôi.\"\nMột đàn chuột bao vây bạn ở giữa, giữ khoảng cách ít nhất năm feet. \n \"Chúng tôi nỗ lực sinh sôi, chúng tôi phát triển mạnh mẽ, chúng tôi không kén ăn — vì vậy chúng tôi mang đến cho con người bệnh tật, lo lắng và đau khổ.\"\n \"Chúng tôi và con người không nên đến gần nhau, đây không phải là nơi bạn nên đến.\"\nĐể làm cho đàn chuột giảm bớt cảnh giác, bạn quyết định —"
  },
  Event_6903_Name = {
    Text = "Bệnh dịch hạch"
  },
  Event_6904_ChoiceDesc1 = {
    Text = "[tiếp tục rơi] bị nhiễm [(Skill.Arg1)], có tiếp tục không"
  },
  Event_6904_ChoiceDesc2 = {
    Text = "[rút lui] nhận được 25 dấu đen"
  },
  Event_6904_Desc = {
    Text = "\"bạn\" mời gọi bạn. \nTrong lòng xoắn ốc, \"bạn\" từ quá khứ và tương lai gửi tặng bạn những \"món quà\" từ các chiều không gian khác nhau."
  },
  Event_6904_Name = {
    Text = "Vực thẳm xoắn ốc"
  },
  Event_6905_ChoiceDesc1 = {
    Text = "[ấn giữ quạ] nhận được 40 dấu đen, nhiễm [(Skill.Arg2)], tiếp tục chọn"
  },
  Event_6905_ChoiceDesc2 = {
    Text = "[ bỏ mặc ] nhận được 25 dấu đen, rời đi"
  },
  Event_6905_Desc = {
    Text = "Con quạ cô đơn khàn giọng, tự nhổ từng chiếc lông đen của mình. \nNó run rẩy vì đau đớn, kêu lên những tiếng thét chói tai, nhưng không thể dừng lại hành động ngày càng nhanh của mình. \n \"Ga—— Ga——\"\nTrong mắt nó chảy ra những giọt nước mắt xanh thẳm hòa lẫn với chất dịch đen, ngoài bạn ra, không ai chứng kiến."
  },
  Event_6905_Name = {
    Text = "Nước mắt dung nham"
  },
  Event_6906_ChoiceDesc1 = {Text = "[đi]"},
  Event_6906_Desc = {
    Text = "Đỏ, nồng nhiệt, phóng khoáng, rực rỡ, tôi tình cờ quen biết một mỹ nhân như vậy, rồi sớm muộn gì các bạn cũng sẽ gặp nhau. \nVậy, lựa chọn tiếp theo của bạn là gì?"
  },
  Event_6906_Name = {
    Text = "Buổi biểu diễn bắt đầu"
  },
  Event_6907_ChoiceDesc1 = {
    Text = "[tán thưởng nhiệt liệt]"
  },
  Event_6907_ChoiceDesc2 = {
    Text = "[mệt mỏi muốn ngủ]"
  },
  Event_6907_Desc = {
    Text = "Bạn đã có một giấc mơ rất dài. \nTrong mơ, bạn ngồi trên khán đài, nhìn cậu bé đang hát trên sân khấu. \n \"Ông Charlie có một con mèo vằn mà ông rất yêu quý \nKhi cô ấy mất tích, ông đã tìm kiếm khắp nơi\"\n... \nGiọng nói trống rỗng và khô khốc lặp đi lặp lại một cách máy móc, không ngừng nghỉ..."
  },
  Event_6907_Name = {
    Text = "Lễ Bế Màn Ⅳ"
  },
  Event_6908_ChoiceDesc1 = {
    Text = "[mở khóa nhánh phía trên]"
  },
  Event_6908_ChoiceDesc2 = {
    Text = "[Mở ra nhánh dưới đây]"
  },
  Event_6908_Desc = {
    Text = "Linh tri thức trong thâm cảnh còn sót lại liên kết với nhau, quấn quanh tạo thành một trường lực không ổn định. \nCó lẽ, bạn có thể gỡ rối những linh tri thức quấn quanh, mở đường phía trước."
  },
  Event_6908_Name = {
    Text = "Đường rối rắm"
  },
  Event_6909_ChoiceDesc1 = {
    Text = "[ Rời đi ] Chọn 2 thân thể được đánh thức để thức tỉnh"
  },
  Event_6909_Desc = {
    Text = "Bạn đứng dậy, lập tức lao tới cửa. \n \"Bạn đã vén màn che... \n Bí mật, bạn đã phát hiện ra bí mật...\"\n Tiếng ồn ào như đại dương, sàn nhà rung động dữ dội trong sự cộng hưởng kinh hoàng. \n Bạn không dám quay đầu lại, rời khỏi hiện trường với tốc độ nhanh nhất có thể."
  },
  Event_6909_Name = {
    Text = "Lễ Chấm Dứt Ⅴ"
  },
  Event_6910_ChoiceDesc1 = {Text = "[đi]"},
  Event_6910_Desc = {
    Text = "Bạn không chống cự, tất nhiên, bạn cũng sẽ không chọn sa đà."
  },
  Event_6910_Name = {
    Text = "Lỗ loét trong sọ"
  },
  Event_6911_ChoiceDesc1 = {Text = "[đi]"},
  Event_6911_Desc = {
    Text = "Bạn không còn kháng cự, để ô uế nuốt chửng thân thể và tinh thần. Sau giấc ngủ dài, ánh bạc rơi vào đôi tay bạn đang giao nhau."
  },
  Event_6911_Name = {
    Text = "Lỗ loét trong sọ"
  },
  Event_6912_ChoiceDesc1 = {Text = "[đi]"},
  Event_6912_Desc = {
    Text = "Càng giãy dụa, sự ô uế trong đầu càng chìm sâu hơn, và ở nơi sâu nhất của bộ não đầy tội lỗi, ẩn chứa một món quà không rõ nguồn gốc."
  },
  Event_6912_Name = {
    Text = "Lỗ loét trong sọ"
  },
  Event_6913_ChoiceDesc1 = {Text = "[đi]"},
  Event_6913_Desc = {
    Text = "Khi tấm lưới vỡ vụn, có thứ gì đó lướt qua trong đầu bạn, dường như là nụ cười của vài đứa trẻ."
  },
  Event_6913_Name = {
    Text = "Mạng lưới lạc lối"
  },
  Event_6914_ChoiceDesc1 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_6914_Desc = {
    Text = "Con mèo gật đầu hài lòng, rồi hóa thành bóng tối và tan biến tại chỗ, để lại vài vật tròn màu đen."
  },
  Event_6914_Name = {
    Text = "Cư dân du mục"
  },
  Event_6915_ChoiceDesc1 = {
    Text = "[Đọc thư] Xóa 1 thẻ lệnh, nhận Arg1 dấu đen"
  },
  Event_6915_ChoiceDesc2 = {
    Text = "[đóng hộp kỹ]"
  },
  Event_6915_Desc = {
    Text = "Giấy thư bay phấp phới phủ kín trời, giống như những lời nhắc nhở không lời."
  },
  Event_6915_Name = {
    Text = "Thư không mời"
  },
  Event_6916_ChoiceDesc1 = {
    Text = "[Nhập] Vượt qua sương mù để đến phía bên kia."
  },
  Event_6916_ChoiceDesc2 = {Text = "[đi]"},
  Event_6916_Desc = {
    Text = "Đường trước mặt xuất hiện một đường hầm ẩn, trong đường hầm sương đen dày đặc, không biết dẫn đến đâu."
  },
  Event_6916_Name = {
    Text = "đường hầm"
  },
  Event_6917_ChoiceDesc1 = {Text = "[đi]"},
  Event_6917_Desc = {
    Text = "Bạn quyết tâm kết thúc nỗi khổ của nó, vì vậy bạn đưa tay nắm lấy thân thể mềm mại của nó, siết chặt, rồi siết chặt hơn nữa…\nNó tuyệt vọng vùng vẫy trong lòng bàn tay bạn, cuối cùng bùng nổ thành một dòng nước ấm áp."
  },
  Event_6917_Name = {
    Text = "Nước mắt dung nham"
  },
  Event_6918_ChoiceDesc1 = {Text = "[đi]"},
  Event_6918_Desc = {
    Text = "Hãy yên tâm, đây chỉ là ký ức vỡ vụn của người khác trong chiều. Bạn sở hữu bóng tối. Chỉ là, người trong bóng tối kia, liệu có thật sự là bạn không?"
  },
  Event_6918_Name = {
    Text = "Phân mảnh ký ức · bia"
  },
  Event_6919_ChoiceDesc1 = {Text = "[đi]"},
  Event_6919_Desc = {
    Text = "Bạn mạnh mẽ bẻ lại mỏ nhọn của con quạ đang định cắn lấy lông của nó, nhưng nó lại ngoan cố xoay đi, sức mạnh lớn đến nỗi khiến xương của bạn kêu răng rắc. \n Bạn đỏ mặt, dùng hết sức lực mới khống chế được cơ thể của con quạ, ngăn chặn hành vi tự làm tổn thương điên cuồng của nó. \n Khi bạn thở phào nhẹ nhõm, cổ của con quạ đã gần như hói nhanh chóng xoay lại, cơ thể mềm nhũn, trong tay bạn biến thành một vũng chất lỏng đen đặc."
  },
  Event_6919_Name = {
    Text = "Nước mắt dung nham"
  },
  Event_6920_ChoiceDesc1 = {Text = "[đi]"},
  Event_6920_Desc = {
    Text = "Bạn lạnh lùng phớt lờ những tiếng chuông tuyệt vọng đó. \n Dù chỉ trong giây lát nữa có thể bị nổ trở về thế giới nguyên thủy, dù bạn và sứ mệnh vĩ đại của bạn sắp phải chôn vùi cùng nhau. \n Cuộc gọi không nên nhận, chính là không thể nhận. \n Bạn hiểu rõ điều đơn giản này."
  },
  Event_6920_Name = {
    Text = "Xin hãy nghe điện thoại"
  },
  Event_6921_ChoiceDesc1 = {
    Text = "[Cúi đầu xem xét] Bạn nhận được 25 dấu đen"
  },
  Event_6921_ChoiceDesc2 = {
    Text = "[Tôi nhất định phải tìm ra] để có được sáng tạo bằng bạc \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_6921_Desc = {
    Text = "Bạn đuổi theo bóng đen về phía trước, đột nhiên bước vào một vùng nước nông. Chất lỏng không rõ màu sắc ngập qua mặt giày, lan tỏa từng cơn lạnh buốt. \nMột giọng nói trong nước nói: \"Bạn sẽ không muốn tìm thấy.\""
  },
  Event_6921_Name = {
    Text = "Bạn sẽ không muốn tìm thấy"
  },
  Event_6922_ChoiceDesc1 = {Text = "[đi]"},
  Event_6922_Desc = {
    Text = "Lựa chọn an toàn."
  },
  Event_6922_Name = {
    Text = "sau đống cỏ"
  },
  Event_6923_ChoiceDesc1 = {
    Text = "[xua đuổi quạ] nhận Arg1 dấu đen, nhiễm [(Skill.Arg2)], tiếp tục chọn"
  },
  Event_6923_ChoiceDesc2 = {
    Text = "[Bỏ qua] nhận được 25 dấu đen, rời đi"
  },
  Event_6923_Desc = {
    Text = "Làm sao trong phòng của bệnh viện dưỡng lão lại có quạ? \n Nhưng bạn thực sự nghe thấy tiếng cười nham hiểm của quạ, trong bóng tối có một thế lực chưa xuất hiện trên sân khấu, đang nhìn lén bạn từ đôi mắt chim trống rỗng. Những sinh vật đen tối đó uốn cong cổ, đứng trên đèn chùm ở đầu ngõ, nhìn xuống bạn bằng ánh mắt chứa đầy ác ý. Những cái đầu như bóng mờ, dường như chung một cơ thể ngâm trong dung dịch ăn mòn."
  },
  Event_6923_Name = {
    Text = "Đèn lồng quạ đen"
  },
  Event_6924_ChoiceDesc1 = {Text = "[đi]"},
  Event_6924_Desc = {
    Text = "Đừng sợ bẩn thỉu, bạn sẽ nhận lại nhiều hơn những gì đã mất."
  },
  Event_6924_Name = {
    Text = "sau đống cỏ"
  },
  Event_6925_ChoiceDesc1 = {Text = "[đi]"},
  Event_6925_Desc = {
    Text = "Cơn bão linh tri thức bao quanh tulô, bạn và anh ta liếc nhìn nhau, sau đó cùng bước vào bóng tối."
  },
  Event_6925_Name = {
    Text = "Lời Hứa của Đại Lý"
  },
  Event_6926_ChoiceDesc1 = {
    Text = "[Nhập] Vượt qua sương mù để đến phía bên kia."
  },
  Event_6926_ChoiceDesc2 = {Text = "[đi]"},
  Event_6926_Desc = {
    Text = "Bạn rơi vào một vùng tối tăm. \nỞ cuối tầm nhìn, chỉ có một tia sáng mỏng manh, lọt qua khe hở nhỏ như lỗ khóa. \nChiếc chìa khóa bạc phát ra ánh sáng mờ ảo tựa hơi thở, dẫn đường cho bạn bước vào con đường bí mật đó."
  },
  Event_6926_Name = {
    Text = "đường hầm đơn hàng"
  },
  Event_6927_ChoiceDesc1 = {
    Text = "[Nhiễm「(Skill.Arg1)」, nhận di vật:(「(RelicConfig.Arg2)」]"
  },
  Event_6927_ChoiceDesc2 = {
    Text = "[Chọn 1 thẻ từ 3 thẻ lệnh để nhận được dấu ấn:「(EnchantConfig.Arg1)」]"
  },
  Event_6927_Desc = {
    Text = "Sự kiện 203 (đang phát triển), chưa phải hiệu ứng cuối cùng"
  },
  Event_6927_Name = {
    Text = "Sự kiện 203 （đang phát triển）"
  },
  Event_6928_ChoiceDesc1 = {
    Text = "[bổ sung] xóa một thẻ lệnh, nhận được sáng tạo:[(RelicConfig.Arg1)]"
  },
  Event_6928_ChoiceDesc2 = {
    Text = "[Vuốt ve] xóa một thẻ tấn công/phòng thủ, nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_6928_ChoiceDesc3 = {
    Text = "[sự ghét] nhận được 25 dấu đen"
  },
  Event_6928_Desc = {
    Text = "\"Bạn có thích thân thể tàn tật của tôi không? Nếu được, bạn có thể giúp tôi ghép lại thân thể không?\"\nChỉ còn nửa thân trên, đôi môi của tượng thạch cao khẽ động, giọng nói yếu ớt như làn lụa mỏng chạm vào tai, từ đôi môi lẽ ra cứng ngắt và lạnh lẽo của cô ấy tuôn trào."
  },
  Event_6928_Name = {
    Text = "Lắp ráp tàn dư"
  },
  Event_6929_ChoiceDesc1 = {
    Text = "[Đánh bỏ bao thư], chọn 1 trong 3 thẻ lệnh để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_6929_ChoiceDesc2 = {
    Text = "[đặt vào ngực] nhiễm \"(Skill.Arg1)\", nhận được sáng tạo: \"(RelicConfig.Arg2)\""
  },
  Event_6929_Desc = {
    Text = "Đây là một bức thư cầu cứu, người viết cố gắng giữ bình tĩnh, nhưng nét chữ lúc nghiêng lúc thẳng đã bộc lộ nỗi sợ hãi sâu kín của anh ta. \n \"Mọi thứ hoàn toàn vượt quá sự dự đoán của tôi, nếu bây giờ có ai đó nói rằng tôi bị nguyền rủa nặng nề, tôi thề rằng tôi sẽ tin chắc điều đó.\"\n \"Có người nói tôi điên, họ chỉ nói đúng một nửa, tôi đang ở bên bờ vực của sự điên rồ.\"\n \"Nhưng tôi thực sự nhìn thấy! Nó đang biến đổi và tan biến, những mảng đen sẫm đang cố gắng bò khắp cơ thể tôi!\"\n \"Tôi đã chạy trốn! Chạy rất nhanh, nhưng ánh mắt dõi theo chưa từng rời khỏi tôi, tôi có linh cảm, nó chắc chắn sẽ tìm thấy tôi! Dòng bùn đen kinh tởm đó sẽ lại chảy vào hộp sọ của tôi, bất kể ai nhận được bức thư này, xin hãy cứu tôi ——\""
  },
  Event_6929_Name = {
    Text = "Một lá thư cầu cứu"
  },
  Event_6930_ChoiceDesc1 = {Text = "[đi]"},
  Event_6930_Desc = {
    Text = "\"Bình tĩnh,\" Ramona gõ nhẹ vào đầu bạn,\"chỉ là những phân mảnh của quá khứ. Không biết ai đã để lại ở lối dẫn chiều này.\"\nQuả thật, có một mùi vị hoài niệm."
  },
  Event_6930_Name = {
    Text = "Giao tiếp khẩn cấp"
  },
  Event_6931_ChoiceDesc1 = {
    Text = "[Ngẫu nhiên 1 thẻ lệnh nhận dấu ấn:「(EnchantConfig.Arg1)」]"
  },
  Event_6931_ChoiceDesc2 = {
    Text = "[Ngẫu nhiên 1 thẻ lệnh nhận dấu ấn:「(EnchantConfig.Arg1)」]"
  },
  Event_6931_ChoiceDesc3 = {
    Text = "[Ngẫu nhiên 1 thẻ lệnh nhận dấu ấn:「(EnchantConfig.Arg1)」]"
  },
  Event_6931_Desc = {
    Text = "Sự kiện 205 (đang phát triển), chưa phải hiệu ứng cuối cùng"
  },
  Event_6931_Name = {
    Text = "Sự kiện 205 (đang trong quá trình phát triển)"
  },
  Event_6932_ChoiceDesc1 = {
    Text = "[Nhận di vật:(「(RelicConfig.Arg1)」]"
  },
  Event_6932_ChoiceDesc2 = {
    Text = "[Nhận di vật:(「(RelicConfig.Arg1)」]"
  },
  Event_6932_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 50 dấu đen"
  },
  Event_6932_Desc = {
    Text = "Sự kiện 204 (đang phát triển), chưa phải hiệu ứng cuối cùng"
  },
  Event_6932_Name = {
    Text = "Sự kiện 204 (chưa hoàn thiện)"
  },
  Event_6933_ChoiceDesc1 = {Text = "[đi]"},
  Event_6933_Desc = {
    Text = "Mặt trăng cô đơn treo cao trên trời, nhưng bạn vẫn có thể nghe rõ lời cầu nguyện của nó, âm điệu kỳ lạ, giống như tiếng thì thầm của những vật bẩn thỉu. \n Lời cầu nguyện ngừng lại, bạn định rời đi. Nhưng phía sau bỗng hiện lên một bóng trắng mờ ảo. \n \"Kẻ xâm phạm số phận và lời cầu nguyện, ân huệ và giá phải trả sẽ đến đúng hẹn.\""
  },
  Event_6933_Name = {
    Text = "Phân mảnh Bạc Nguyệt"
  },
  Event_6934_ChoiceDesc1 = {Text = "[đi]"},
  Event_6934_Desc = {
    Text = "Tiếng vỡ vụn trong sáng vọng lại từ phía sau, bạn suy nghĩ một lát, rồi quay người rời đi."
  },
  Event_6934_Name = {
    Text = "Phân mảnh Bạc Nguyệt"
  },
  Event_6935_ChoiceDesc1 = {Text = "[đi]"},
  Event_6935_Desc = {
    Text = "Một nắm ánh trăng được nâng trong lòng bàn tay, rơi xuống bia đá. \n Có người bị chôn vùi dưới lớp bùn dày, đám đông đứng xem khẳng định rằng người này đã đến lúc tự nhiên lụi tàn, sẽ an giấc dưới lòng đất. \n Nhưng lớp bùn chôn vùi lại sóng động, trong tiếng la hét, lại có một đống ánh trăng mềm nhũn bò ra."
  },
  Event_6935_Name = {
    Text = "Phân mảnh Bạc Nguyệt"
  },
  Event_6936_ChoiceDesc1 = {Text = "[đi]"},
  Event_6936_Desc = {
    Text = "Chỉ là những sinh linh đang cố gắng sống sót, tìm kiếm một nơi tạm nghỉ như mảnh gỗ trôi giữa dòng nước……\nBạn thở dài, để mặc dòng chất lỏng đen đặc từ đuôi con bướm chảy xuống."
  },
  Event_6936_Name = {
    Text = "Điều không nên tồn tại"
  },
  Event_6937_ChoiceDesc1 = {Text = "[đi]"},
  Event_6937_Desc = {
    Text = "Đây là một cái bẫy được công bố trước, và bạn, biết rõ về sự nguy hiểm của nó. \nSo với trang sức, chính bản thân bạn —— rõ ràng là viên ngọc quý hơn."
  },
  Event_6937_Name = {
    Text = "Đảo ngược móng quỷ"
  },
  Event_6938_ChoiceDesc1 = {
    Text = "[Chèn chìa khóa bạc]"
  },
  Event_6938_Desc = {
    Text = "Trong dung dịch ăn mòn bão hòa rỗng rỗng dường như chứa một số chất… Dùng chìa khóa bạc quan sát, rồi chuyển hóa nó thành lực lượng của bạn."
  },
  Event_6938_Name = {
    Text = "Điểm tách ra"
  },
  Event_6939_ChoiceDesc1 = {Text = "[đi]"},
  Event_6939_Desc = {
    Text = "Bạn đáp ứng yêu cầu, nhưng gặp phải một chút vấn đề nhỏ. \n \"Bình tượng nến đó... trông như thế nào?\"\n \"Đó là nửa người của tôi, tất nhiên là giống tôi y hệt rồi.\"\n \"Nhưng...\"\n \"Khuôn mặt của ngài, đã sớm mục nát hoàn toàn rồi. Ngài không biết sao?\""
  },
  Event_6939_Name = {
    Text = "Nửa thân tôi"
  },
  Event_6940_ChoiceDesc1 = {Text = "[đi]"},
  Event_6940_Desc = {
    Text = "Bạn nắm chặt tay người bạn bên cạnh, Ramona liếc nhìn bạn với ánh mắt nghi hoặc, nhưng cuối cùng cô ấy đã im lặng chấp nhận hành động thiếu tế nhị của bạn."
  },
  Event_6940_Name = {
    Text = "Lời cầu nguyện giấc mơ"
  },
  Event_6941_ChoiceDesc1 = {
    Text = "[Hỏi nó là ai] Chọn 1 thẻ lệnh từ 3 thẻ lệnh để nhận khắcăng: \"(EnchantConfig.Arg1)\", bị nhiễm \"(Skill.Arg2)\""
  },
  Event_6941_ChoiceDesc2 = {
    Text = "[Gặp gỡ nó] Chọn 1 thân thể được đánh thức để thức tỉnh, nhiễm [(Skill.Arg1)]"
  },
  Event_6941_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_6941_Desc = {
    Text = "Cảm giác bị nhìn chằm chằm mãnh liệt khiến bạn dừng lại. \n \"Là ai?\" Bạn nhìn quanh trong sương mù dày đặc, \"Jenkin, là cậu không?\"\nSương mù mịt mùng, từ sâu trong sân vang lên tiếng thét của thân thể bị ăn mòn. Bạn không tìm thấy gì và chỉ có thể quay đầu lại, nhưng suýt nữa thì va phải một con mắt đang lơ lửng trong không trung."
  },
  Event_6941_Name = {
    Text = "Nhìn mù quáng"
  },
  Event_6942_ChoiceDesc1 = {
    Text = "[không chạm vào đồng xu] ngẫu nhiên nhận 1 thẻ lệnh có khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_6942_ChoiceDesc2 = {
    Text = "[chạm vào đồng xu] tăng Arg1 điểm máu tối đa, lây nhiễm [(Skill.Arg2)]"
  },
  Event_6942_Desc = {
    Text = "Bạn nhặt được một đồng tiền cổ bị vùi trong bùn đen. \n Một mặt của nó khắc họa những mạch máu đỏ xanh đan xen, mặt còn lại được chạm nổi tỉ mỉ hình ảnh một nữ công tước thuần khiết, nụ cười nhẹ nhàng, đang nhìn chằm chằm vào con ngươi trắng bệch của bạn, khẽ nhúc nhích một chút, rồi bắt đầu xoay tròn một cách hỗn loạn."
  },
  Event_6942_Name = {
    Text = "Đồng tiền cổ hai mặt"
  },
  Event_6943_ChoiceDesc1 = {
    Text = "[quay người] nhận được 25 dấu đen"
  },
  Event_6943_ChoiceDesc2 = {
    Text = "[tiếp tục tiến lên] nhận được sáng tạo bạc \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_6943_Desc = {
    Text = "Lại đến rồi, âm thanh bước chân kỳ lạ đó. \n Nó theo sát bạn từ xưởng làm việc đến phòng giám đốc, rồi từ phòng giám đốc xuống tầng hầm. \n Bạn biết đó là một gã cẩn thận. \n Hắn giữ khoảng cách giữa hai người một cách cẩn thận, không để quá xa, nhưng cũng không khiến người khác cảm thấy bị xúc phạm. \n Nhưng bạn vẫn bị quấy rầy sâu sắc."
  },
  Event_6943_Name = {
    Text = "bước chân"
  },
  Event_6944_ChoiceDesc1 = {
    Text = "[Quan sát nó] có thể nhận được 25 dấu đen"
  },
  Event_6944_ChoiceDesc2 = {
    Text = "[Vuốt ve nó] 50% cơ hội nhận được 50 dấu đen, 50% cơ hội không có gì cả"
  },
  Event_6944_Desc = {
    Text = "Một con mèo đen đột nhiên xuất hiện trong con hẻm, bị cuốn vào chân các người một cách thân mật khác thường, đôi mắt dọc màu xanh lục lấp lánh ánh sáng gây cảm giác lạnh sống lưng, giống như đang nói \"Đừng đuổi theo nữa, hãy chơi với tôi một lát đi.\"\n \"Bạn đã thấy Người ấy rồi, Người ấy đang ở bên cạnh bạn, những bóng tối bị ô nhiễm bởi điên cuồng, cuồng nhiệt... đừng nhìn thẳng vào hình dạng của Người ấy.\""
  },
  Event_6944_Name = {Text = "Elfo Đêm"},
  Event_6945_ChoiceDesc1 = {Text = "[đi]"},
  Event_6945_Desc = {
    Text = "Các thân thể được đánh thức đang chờ đợi lệnh của bạn, bạn không có thời gian để lo lắng về những việc khác."
  },
  Event_6945_Name = {Text = "từ góc"},
  Event_6946_ChoiceDesc1 = {
    Text = "[Kiểm tra phim] bị nhiễm \"(Skill.Arg1)\", nhận được một vật phẩm vàng sáng tạo \"(RelicConfig.Arg2)\""
  },
  Event_6946_ChoiceDesc2 = {
    Text = "[Kiểm tra máy ảnh] nhận được 50 dấu đen"
  },
  Event_6946_Desc = {
    Text = "Như kéo ra một đoạn nội tạng, phim trong bụng máy ảnh bị xé nát, bị vứt bỏ ở đây, không ai quan tâm. \nMột tia sáng trắng chói mắt lóe lên, máy ảnh bị vứt ở góc đường nghiêng lệch, cửa trập bị bấm không rõ nguyên do. \n \"Rắc——\"\nDáng vẻ kinh ngạc, ngây người của bạn được ghi lại trung thực trên phim trong máy ảnh."
  },
  Event_6946_Name = {
    Text = "Bản ghi vô tội"
  },
  Event_6947_ChoiceDesc1 = {Text = "[đi]"},
  Event_6947_Desc = {
    Text = "Chỉ là tiếng gió rung ổ khóa sắt thôi, chẳng đáng bận tâm, không cần để ý."
  },
  Event_6947_Name = {
    Text = "Sau cánh cửa sắt"
  },
  Event_6948_ChoiceDesc1 = {
    Text = "[Chọn] Nhiễm [(Skill.Arg1)]"
  },
  Event_6948_ChoiceDesc2 = {
    Text = "[Chọn] Nhiễm [(Skill.Arg1)]"
  },
  Event_6948_ChoiceDesc3 = {
    Text = "[Chọn] Nhiễm [(Skill.Arg1)]"
  },
  Event_6948_Desc = {
    Text = "\"Tôi\" là tôi độc nhất vô nhị, từ hàng triệu vũ trụ, tuyệt đối không có gì sánh bằng."
  },
  Event_6948_Name = {
    Text = "Cộng hưởng linh hồn"
  },
  Event_6949_ChoiceDesc1 = {
    Text = "[Lấy] chọn 1 bạc sáng tạo"
  },
  Event_6949_Desc = {
    Text = "Đó có thể là \"tôi\". \nXuyên qua bóng tối của thời gian, xuyên qua rào cản của chiều, thông qua một khe nứt nhỏ để đối diện với \"tôi\"."
  },
  Event_6949_Name = {
    Text = "Cộng hưởng linh hồn"
  },
  Event_6950_ChoiceDesc1 = {
    Text = "[chỉ ra vấn đề] Chọn 1 trong 3 thẻ lệnh để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_6950_ChoiceDesc2 = {
    Text = "[nuốt xuống nghi vấn] [(Skill.Arg1)], khắcăng, vẫn có thể thực hiện 1 lần nữa"
  },
  Event_6950_Desc = {
    Text = "Đối với cô gái, đây cũng là một nỗi niềm khó nói. \n Bạn nuốt xuống nghi vấn, nhưng cô ấy lại xoa xoa ngực, từ từ kể lại, nói về một giấc mơ dài kéo dài suốt hai mươi lăm năm, nói về sự cô lập, không ai giúp đỡ của mình sau khi tỉnh giấc."
  },
  Event_6950_Name = {
    Text = "Sống bị giam cầm"
  },
  Event_6951_ChoiceDesc1 = {Text = "[đi]"},
  Event_6951_Desc = {
    Text = "Bạn ném giấy và vụn gỗ vào ngọn lửa. Ngọn lửa tham lam nuốt chửng chúng và đánh một cái ợ no nê. Nó đã sẵn sàng để đi hủy diệt thế giới, và trước khi rời đi, không quên ban cho bạn một chút phước lành như lời tạm biệt."
  },
  Event_6951_Name = {Text = "Lửa mờ"},
  Event_6952_ChoiceDesc1 = {Text = "[đi]"},
  Event_6952_Desc = {
    Text = "Bạn đã dẫm tắt ngọn lửa căm hận cuối cùng còn lại, sự oán hận và sự không cam lòng bao quanh dường như đã giảm bớt."
  },
  Event_6952_Name = {Text = "Lửa mờ"},
  Event_6953_ChoiceDesc1 = {
    Text = "[Xua đuổi quạ] nhận được Arg1 dấu đen, nhiễm [(Skill.Arg2)]"
  },
  Event_6953_ChoiceDesc2 = {
    Text = "[bỏ qua] rời đi"
  },
  Event_6953_Desc = {
    Text = "Bạn muốn bắt con quạ, nhưng nó chỉ bay từ đầu này sang đầu kia của phòng ngủ, rồi tiếp tục phát ra những tiếng kêu kỳ quái. Nơi con quạ bay qua, những giọt chất lỏng màu đen nhỏ xuống, hóa thành những vết tích đen."
  },
  Event_6953_Name = {
    Text = "Đèn lồng quạ đen"
  },
  Event_6954_ChoiceDesc1 = {
    Text = "[rời đi] nhận được sáng tạo \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_6954_Desc = {
    Text = "\"Anh rất giỏi trong việc nắm bắt trọng điểm,\" người đàn ông mỉm cười rạng rỡ, \"đó là món lương khô ngon nhất trên thế gian, xứng đáng để mỗi thực khách cẩn thận chế biến, tỉ mỉ thưởng thức.\"\n \"Rất tiếc, lần này không thể mời anh thử rồi. Để bù đắp, tôi còn một số món ngon khác, sẽ tặng cho anh.\"\n Nói xong, người đàn ông ném xuống một miếng thịt mềm màu hồng nhạt. Miếng thịt rơi xuống cầu, những xúc tu dính nhớt uốn éo và ngọ nguậy. Khi bạn ngẩng đầu lên nhìn lại, hình dáng của người đàn ông đã biến mất sau những khung thép phức tạp, không để lại dấu vết."
  },
  Event_6954_Name = {
    Text = "Người bạn đồng hành kỳ lạ Ⅵ"
  },
  Event_6955_ChoiceDesc1 = {Text = "[đi]"},
  Event_6955_Desc = {
    Text = "Gỡ từng lớp, từng bước tiến lên, đây là sở trường của bạn. \n Ánh sáng của cảm hứng khiến bộ não trở nên rõ ràng hơn, bạn có thể nhìn rõ thực tại hiện tại - \n Dù ai đang đứng sau điều khiển con rối, hãy trốn thoát và sống sót."
  },
  Event_6955_Name = {
    Text = "Bùng nổ cảm hứng"
  },
  Event_6956_ChoiceDesc1 = {Text = "[đi]"},
  Event_6956_Desc = {
    Text = "Con bướm trong lòng bàn tay bạn vỡ vụn, giống như trần nhà kính bị đập vỡ đột ngột, những mảnh vỡ rơi xuống theo lực hấp dẫn, rơi, rơi, rơi ——"
  },
  Event_6956_Name = {
    Text = "Ảo giác đường sắt"
  },
  Event_6957_ChoiceDesc1 = {Text = "[đi]"},
  Event_6957_Desc = {
    Text = "Thấy Ramona không muốn đến gần, con mèo lắc đầu, biến thành một bóng ma và tan biến tại chỗ."
  },
  Event_6957_Name = {
    Text = "Cư dân du mục"
  },
  Event_6958_ChoiceDesc1 = {
    Text = "[Đặt lời hứa] nhận được bạc tạo vật \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_6958_ChoiceDesc2 = {
    Text = "[Từ chối] nhận bạc sáng tạo \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_6958_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_6958_Desc = {
    Text = "\"Đó thật sự là một kỷ niệm khó quên. \nĐầu và tứ chi của tôi bị ép mạnh vào thạch cao. \nCảm giác ngạt thở và ảo giác cận kề cái chết bao trùm lấy tôi, kéo tôi xuống sâu rồi ném tôi lên bờ tối tăm. \nTôi nhìn nó, cảm thấy một phần của mình cũng bị cướp đi. \nNửa linh hồn còn lại, từ đó đã cư trú trong bình tượng nến nhỏ bé, ban đầu. \nVì vậy... bạn có thể giúp tôi tìm nửa thân còn lại của tôi không?\""
  },
  Event_6958_Name = {
    Text = "Nửa thân tôi"
  },
  Event_6959_ChoiceDesc1 = {
    Text = "[rời đi] nhận được 3 lựa chọn [đá khắc cao cấp]"
  },
  Event_6959_Desc = {
    Text = "Bạn là người quan sát ký ức, chỉ có thể bất lực nhìn cô gái rơi xuống Biển Vô Tận. \n Dòng nước đẩy váy của cô lên, nhưng thân hình cô lại đang chìm dần, giống như một đóa hoa chưa kịp nở."
  },
  Event_6959_Name = {
    Text = "Tắm chìm"
  },
  Event_6960_ChoiceDesc1 = {
    Text = "[Chèn chìa khóa bạc]"
  },
  Event_6960_Desc = {
    Text = "Trong dung dịch ăn mòn bão hòa rỗng rỗng dường như chứa một số chất… Dùng chìa khóa bạc quan sát, rồi chuyển hóa nó thành lực lượng của bạn."
  },
  Event_6960_Name = {
    Text = "Điểm tách ra"
  },
  Event_6961_ChoiceDesc1 = {Text = "[đi]"},
  Event_6961_Desc = {
    Text = "Không cần để ý đến sự cám dỗ của kẻ địch, rất có thể đó chỉ là một cái bẫy."
  },
  Event_6961_Name = {
    Text = "Quạ Nguyền Rủa"
  },
  Event_6962_ChoiceDesc1 = {
    Text = "[giúp anh ấy]"
  },
  Event_6962_ChoiceDesc2 = {
    Text = "[Lạnh lùng đứng nhìn]"
  },
  Event_6962_Desc = {
    Text = "Cậu bé đứng trên sân khấu, ánh đèn trắng xám chiếu lên khuôn mặt cậu. \n \"Dành tặng, dành tặng cho...\"\nCậu bé đỏ bừng mặt. Cậu mở miệng nhưng không thể thốt nên lời. \nChiếc miệng tối om dần dần mở rộng, càng lúc càng lớn thêm..."
  },
  Event_6962_Name = {
    Text = "Lễ Kết Thúc Ⅲ"
  },
  Event_6963_ChoiceDesc1 = {Text = "[đi]"},
  Event_6963_Desc = {
    Text = "\"Thật đáng ghét, thật đáng ghét!\" Giống như bị bạn chạm vào một công tắc nào đó, con mèo đen bỗng nhiên trở nên hung dữ, há miệng cắn vào cánh tay bạn. May mắn thay, bạn tránh kịp thời, chỉ làm rách một góc áo. Con mèo đen nhảy về phía góc phố, biến mất trong cống dưới hẻm."
  },
  Event_6963_Name = {Text = "Elfo Đêm"},
  Event_6964_ChoiceDesc1 = {Text = "[đi]"},
  Event_6964_Desc = {
    Text = "Bị dòng nước não hỗn loạn cuốn theo, bạn đẩy cửa và bước tiếp lên con đường không lối về. \nÁnh sáng trắng rực rỡ và mạnh mẽ bên ngoài, là cứu rỗi, hay là hủy diệt?"
  },
  Event_6964_Name = {
    Text = "Ngoài cửa nặng"
  },
  Event_6965_ChoiceDesc1 = {Text = "[đi]"},
  Event_6965_Desc = {
    Text = "Bạn lấy hết can đảm bước tới để kiểm tra, chất nhầy phủ trên bàn đột nhiên nứt ra, lộ ra thứ gì đó ở dưới."
  },
  Event_6965_Name = {
    Text = "Ngoài cửa nặng"
  },
  Event_6966_ChoiceDesc1 = {Text = "[đi]"},
  Event_6966_Desc = {
    Text = "Nuốt nước bọt, gạt bỏ câu hỏi sang một bên, tập trung đối phó với kẻ thù. \nĐể con bướm tạm thời lưu lại trong thân thể, mặc dù nhịp cánh của nó có thể khiến nội tạng của bạn bị tổn thương nghiêm trọng."
  },
  Event_6966_Name = {
    Text = "Hiệu ứng bướm"
  },
  Event_6967_ChoiceDesc1 = {
    Text = "[rời đi] nhận được 50 dấu đen"
  },
  Event_6967_Desc = {
    Text = "Con mèo gật đầu hài lòng, rồi hóa thành bóng tối và tan biến tại chỗ, để lại vài vật tròn màu đen."
  },
  Event_6967_Name = {
    Text = "Cư dân du mục"
  },
  Event_6968_ChoiceDesc1 = {
    Text = "[Chèn chìa khóa bạc]"
  },
  Event_6968_Desc = {
    Text = "Trong dung dịch ăn mòn bão hòa rỗng rỗng dường như chứa một số chất… Dùng chìa khóa bạc quan sát, rồi chuyển hóa nó thành lực lượng của bạn."
  },
  Event_6968_Name = {
    Text = "Điểm tách ra"
  },
  Event_6969_ChoiceDesc1 = {
    Text = "[rời đi] nhận được 1 vật tạo vàng ngẫu nhiên, bị ảnh hưởng bởi [(Skill.Arg1)]"
  },
  Event_6969_Desc = {
    Text = "Thấy bạn vẫn còn do dự, Kumi lao tới đống đất, dùng hai chân trước cào nhanh và đẩy thứ gì đó đến trước mặt bạn."
  },
  Event_6969_Name = {
    Text = "Vật chôn sâu"
  },
  Event_6970_ChoiceDesc1 = {Text = "[đi]"},
  Event_6970_Desc = {
    Text = "Giấy tờ in chữ \"Mérimée\", chưa bao giờ có cái gì gọi là Mason. \nLo lắng quá nhiều không phải là điều tốt đâu, Người Giữ Gìn."
  },
  Event_6970_Name = {
    Text = "Máy đánh chữ"
  },
  Event_6971_ChoiceDesc1 = {
    Text = "[đi] nhận được quyền chọn 1 trong 3 vật tạo vàng, nhiễm [(Skill.Arg1)]"
  },
  Event_6971_Desc = {
    Text = "Đống đất che giấu những tội ác chồng chất của Hiệp hội Điêu khắc gia, không thể kể xiết."
  },
  Event_6971_Name = {
    Text = "Vật chôn sâu"
  },
  Event_6972_ChoiceDesc1 = {Text = "[đi]"},
  Event_6972_Desc = {
    Text = "Các loài chim có quy tắc riêng của chúng, chúng không hành động theo ý chí của bạn và bạn cũng không có quyền ảnh hưởng đến quy luật tự nhiên."
  },
  Event_6972_Name = {
    Text = "Quạ Cô Độc"
  },
  Event_6973_ChoiceDesc1 = {
    Text = "[đi] nhận được quyền chọn 1 trong 3 vật tạo vàng, nhiễm [(Skill.Arg1)]"
  },
  Event_6973_Desc = {
    Text = "Tại sao, tại sao lại chìm? \nNgày hôm đó không có mưa dông, không có bão tố. Đêm tối trong veo như được gột rửa, không có một ngôi sao nào, mặt trăng tròn đầy treo thấp trên đường chân trời, giống như một mặt trời lạnh lẽo."
  },
  Event_6973_Name = {
    Text = "Tắm chìm"
  },
  Event_6974_ChoiceDesc1 = {Text = "[đi]"},
  Event_6974_Desc = {
    Text = "\"Tàu trưởng! Chúng tôi đã gặp phải cuộc tấn công khủng bố!...\"\nDường như là cuộc gọi báo cáo của lái tàu, bạn định treo máy.\n \"Lặp lại, đây là Nhóm Hành động Ngoại vi Misaque số 4, chúng tôi đang trên chuyến tàu tốc hành đêm Bắc tuyến để hộ tống và giải cứu con tin thì gặp phải... Aaah!\"\nGiọng nói trong điện thoại trở nên khàn khàn, pha lẫn những tiếng thét chói tai làm người ta rợn tóc gáy.\n \"Lễ thánh đã hoàn thành. Chiên con lạc lối ơi, nguyện dòng tắm thanh tẩy này gột rửa linh hồn ngươi...\""
  },
  Event_6974_Name = {
    Text = "Cuộc gọi từ tàu"
  },
  Event_6975_ChoiceDesc1 = {Text = "[đi]"},
  Event_6975_Desc = {
    Text = "Thu thập bạc tâm cũng là một trong những nhiệm vụ của Người Giữ Gìn. \nLinh hồn trôi nổi trong tinh thể trắng tinh khiết, trong tương lai sẽ trở lại thế giới với một diện mạo hoàn toàn mới."
  },
  Event_6975_Name = {
    Text = "Linh hồn bị trói buộc"
  },
  Event_6976_ChoiceDesc1 = {
    Text = "[Tiếp tục rơi] Ngẫu nhiên 1 thẻ lệnh nhận được khắcăng: [(EnchantConfig.Arg1)], Bạn có muốn tiếp tục rơi không"
  },
  Event_6976_ChoiceDesc2 = {
    Text = "[rút lui] nhận được 25 dấu đen"
  },
  Event_6976_Desc = {
    Text = "\"bạn\" mời gọi bạn. \nTrong lòng xoắn ốc, \"bạn\" từ quá khứ và tương lai gửi tặng bạn những \"món quà\" từ các chiều không gian khác nhau."
  },
  Event_6976_Name = {
    Text = "Vực thẳm xoắn ốc"
  },
  Event_6977_ChoiceDesc1 = {
    Text = "[gập người thò ra] nhiễm \"(Skill.Arg1)\", nhận được vật sáng tạo vàng \"(RelicConfig.Arg2)\""
  },
  Event_6977_ChoiceDesc2 = {
    Text = "[bỏ qua xem] nhận được 50 dấu đen"
  },
  Event_6977_Desc = {
    Text = "Bàn phẫu thuật dường như có một cuộn băng phim kẹp ở dưới cùng."
  },
  Event_6977_Name = {
    Text = "Ký ức ánh sáng và bóng tối"
  },
  Event_6978_ChoiceDesc1 = {Text = "[đi]"},
  Event_6978_Desc = {
    Text = "Từ chối phiền nhiễu, tập trung vào những gì trước mắt. \nBạn còn có những việc quan trọng hơn để làm."
  },
  Event_6978_Name = {
    Text = "Nửa thân tôi"
  },
  Event_6979_ChoiceDesc1 = {Text = "[đi]"},
  Event_6979_Desc = {
    Text = "Di vật thiêng liêng đã mất, di sản vô giá được truyền lại, công cụ thực hiện điều ước…\nCó lẽ chỉ có bảo vật mới mang sức hút khó cưỡng đến vậy."
  },
  Event_6979_Name = {
    Text = "Phương pháp nhập bí ẩn"
  },
  Event_6980_ChoiceDesc1 = {Text = "[đi]"},
  Event_6980_Desc = {
    Text = "「Bạn là 『mẹ』 của Lily, nhưng chỉ sử dụng cô ấy như một công cụ cho nghiên cứu và chiến đấu,」 bạn đáp lại, 「trẻ nhỏ có thể vâng lời mẹ, nhưng bạn không thực sự là 『mẹ』 của Lily.」"
  },
  Event_6980_Name = {
    Text = "Lựa chọn của cô ấy"
  },
  Event_69813_ChoiceDesc1 = {Text = "[đi]"},
  Event_69813_Desc = {
    Text = "Chìa khóa bạc phát sáng lấp lánh, những cánh tay dường như bị một loại lực lượng nào đó chấn áp, lần lượt ẩn vào nước trong hồ, sau đó biến mất không thấy."
  },
  Event_69813_Name = {
    Text = "Bassin máu"
  },
  Event_69814_ChoiceDesc1 = {Text = "[đi]"},
  Event_69814_Desc = {
    Text = "Bạn càng lúc càng lún sâu, trong đầu vang lên những tiếng thì thầm hỗn loạn của Ý Chí Tối Thượng. Bạn nhắm mắt lại, triệu hồi quyền lực bên trong cơ thể mình. \n Đột nhiên, tất cả âm thanh và cảm giác bất thường đều biến mất, bạn đứng sau cánh cửa, xung quanh không còn những xúc tu màu máu, như thể chúng chưa từng tồn tại. \n Bạn cảm thấy toàn thân thoải mái. Bạn hiểu cái giá phải trả, nhưng điều đó không đáng kể — bạn sẽ đối mặt với sự tồn tại tối cao trong hình thái mạnh mẽ hơn."
  },
  Event_69814_Name = {
    Text = "Bassin máu"
  },
  Event_69815_ChoiceDesc1 = {Text = "[đi]"},
  Event_69815_Desc = {
    Text = "Thể thức tỉnh được hình thành từ ký ức của bạn không hề do dự, kéo bạn ra khỏi bassin máu, cánh tay kết nối với bạn bị xé toạc, bùn đục văng tung tóe, trong nước vô số sinh vật khó mà phân biệt được đang bò trườn, Đấng sáng tạo nguyên thủy và kẻ hủy diệt, đang khao khát tiêu thụ."
  },
  Event_69815_Name = {
    Text = "Bassin máu"
  },
  Event_69816_ChoiceDesc1 = {
    Text = "[Gọi thức tỉnh] Trừ 100 điên cuồng của tất cả thân thể được đánh thức, xóa 1 thẻ triệu chứng"
  },
  Event_69816_ChoiceDesc2 = {
    Text = "[hấp thụ huyết trì] tăng Arg1 điểm máu tối đa, nhiễm 2 lá [(Skill.Arg2)]"
  },
  Event_69816_ChoiceDesc3 = {
    Text = "[Chèn chìa khóa bạc] Xóa bỏ tất cả năng lượng chìa khóa bạc"
  },
  Event_69816_Desc = {
    Text = "Quyền trượng sinh lực hiện ra dưới hình thức cái chết trong ánh mắt nguyên thủy. Khi bạn đặt chân lên vùng đất mờ ảo này, vũng máu tanh hôi ngay lập tức hiện ra chân tướng. \n Máu đen đỏ tạo ra vô số cánh tay, bám chặt lấy mắt cá chân và không ngừng kéo lên, ý định lôi bạn vào hố sâu khó lường."
  },
  Event_69816_Name = {
    Text = "Bassin máu"
  },
  Event_6981_ChoiceDesc1 = {
    Text = "[nhặt chìa khóa]"
  },
  Event_6981_Desc = {
    Text = "Một chuỗi chìa khóa rỉ sét. Có thể sử dụng để mở khóa cửa."
  },
  Event_6981_Name = {
    Text = "chìa khóa rỉ sét"
  },
  Event_6982_ChoiceDesc1 = {
    Text = "[Rời đi] Chọn sao chép 1 thẻ lệnh, nhiễm [(Skill.Arg1)]"
  },
  Event_6982_Desc = {
    Text = "Dưới sự hướng dẫn của Thuyền Ca và Hilaster, bạn nhìn vào sâu thẳm của khoang tàu tối tăm——liệu hy vọng sống còn của các bạn có nằm trong bóng tối vô tận kia?"
  },
  Event_6982_Name = {
    Text = "Bài hát thuyền"
  },
  Event_6983_ChoiceDesc1 = {
    Text = "[cùng nhau rời đi] nhận được bạc sáng tạo [(RelicConfig.Arg1)]"
  },
  Event_6983_ChoiceDesc2 = {
    Text = "[Từ chối rời đi] nhận được 75 dấu đen, nhiễm[(Skill.Arg2)]"
  },
  Event_6983_Desc = {
    Text = "Có phải là ảo giác không? Bạn thấy những con quạ bay lượn trên không trung, ngân nga một bài ca quen thuộc: \n \"Vậy thì hãy cùng nhau rời đi, tôi và bạn, \nKhi màn đêm vừa buông xuống, \nGiống như một kẻ say sắp chết nằm trên đường phố.\""
  },
  Event_6983_Name = {
    Text = "Giọng của đàn quạ"
  },
  Event_6984_ChoiceDesc1 = {Text = "[đi]"},
  Event_6984_Desc = {
    Text = "Lực truy tìm không thể ngay lập tức tìm lại điểm liên lạc cho bạn, nhưng bạn đã cảm thấy nhẹ lòng trong chốc lát."
  },
  Event_6984_Name = {
    Text = "Liên lạc bất thường"
  },
  Event_6985_ChoiceDesc1 = {
    Text = "[Thụp xuống xoắn ốc] Nhìn về cuối xoắn ốc"
  },
  Event_6985_ChoiceDesc2 = {
    Text = "[rút lui] nhận được 25 dấu đen"
  },
  Event_6985_Desc = {
    Text = "Cửa sổ bên hông đã không còn nhìn thấy mặt biển. \n Kính phản chiếu khuôn mặt nhợt nhạt của bạn, và trong đồng tử của bạn, \"bạn\" cũng đang nhìn chằm chằm vào cửa sổ bên hông. \n Thực tại và thâm cảnh chồng lên nhau, đan xen, cuối cùng biến dạng thành xoắn ốc đa tầng phức tạp."
  },
  Event_6985_Name = {
    Text = "Vực thẳm xoắn ốc"
  },
  Event_6986_ChoiceDesc1 = {Text = "[đi]"},
  Event_6986_Desc = {
    Text = "Bạn đã nhận được yêu cầu liên lạc từ trường, giọng nói quen thuộc giúp tâm trạng bạn bình yên lại. Bạn lấy lại tinh thần và tiếp tục tiến lên."
  },
  Event_6986_Name = {
    Text = "điểm liên lạc"
  },
  Event_6987_ChoiceDesc1 = {
    Text = "[biểu thị khẳng định]"
  },
  Event_6987_ChoiceDesc2 = {
    Text = "[biểu thị phủ định]"
  },
  Event_6987_ChoiceDesc3 = {
    Text = "[không khẳng định cũng không phủ nhận]"
  },
  Event_6987_Desc = {
    Text = "\"Lâu rồi không gặp, các bạn.\" Các bạn thoát khỏi trận chiến với đám tín đồ cầm đèn, có chút thời gian nghỉ ngơi, đột nhiên phát hiện người đàn ông tóc dài lại xuất hiện bên đường, mỉm cười chào các bạn, như thể trận chiến vừa rồi chưa từng xảy ra. \n \"So với lần gặp trước, mùi Cerberus trên người bạn càng đậm hơn nhiều. Chắc hẳn bạn đã đi đến những nơi rất xa phải không?\"\n"
  },
  Event_6987_Name = {
    Text = "Khách đồng hành kỳ quái Ⅴ"
  },
  Event_6988_ChoiceDesc1 = {
    Text = "[Hỏi Đường anh ta] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_6988_ChoiceDesc2 = {
    Text = "[Rời khỏi nó] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_6988_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_6988_Desc = {
    Text = "Bóng đứng dưới cột đèn đường cao và mảnh. \n \"Xin lỗi, ngài có thể cho tôi mượn lửa được không?\"\nBạn không có thói quen @2, nhưng bạn không ngại sử dụng một chút \"phép màu nhỏ\". \nNhờ sự giúp đỡ của bạn, bóng đã đưa @2 đang cháy vào xoáy đen sâu thẳm không thấy đáy. \nChẳng mấy chốc, bạn nhìn thấy khói trắng bốc lên. \n \"À——\"\nBóng phát ra tiếng thở dài đầy thích thú, như thể vừa trải qua khoảnh khắc thư thái nhất."
  },
  Event_6988_Name = {
    Text = "Hình bóng dưới đèn đường"
  },
  Event_6989_ChoiceDesc1 = {
    Text = "[Xác nhận]"
  },
  Event_6989_Desc = {
    Text = "Trong bàn cờ, những gì bạn thấy không phải là sự thật.\n\nCó thể điều ngăn cản bạn không phải là bức tường, mà là sự tò mò đã mất đi."
  },
  Event_6989_Name = {
    Text = "Khoảng không huyền ảo"
  },
  Event_6990_ChoiceDesc1 = {Text = "[đi]"},
  Event_6990_Desc = {
    Text = "\"Tôi đau quá, đau quá a... Chị Sasa...\"\n Bạn nhìn về phía Sara, cô ấy đang bảo vệ hai đứa trẻ một cách căng thẳng, dường như không nghe thấy. \n Giọng nói dần dần mất đi."
  },
  Event_6990_Name = {
    Text = "\"chị Sasa\""
  },
  Event_6991_ChoiceDesc1 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_6991_Desc = {
    Text = "Bạn đứng dậy vỗ tay cho cậu bé. \nDường như cảm nhận được sự khích lệ của bạn, cậu bé ngẩng cao ngực nhỏ nhắn của mình. \nMáu đen không ngừng tuôn ra từ miệng, nhưng chẳng còn gì có thể ngăn được tiếng hát ấy."
  },
  Event_6991_Name = {
    Text = "Lễ Bế Màn Ⅳ"
  },
  Event_6992_ChoiceDesc1 = {Text = "[đi]"},
  Event_6992_Desc = {
    Text = "Một phần nỗi buồn đang bốc hơi, nhưng nước mắt vẫn không ngừng chảy về Kỳ Quyết Vãng Thế."
  },
  Event_6992_Name = {
    Text = "Nước mắt của Bờ Biển Bóng Ma"
  },
  Event_6993_ChoiceDesc1 = {
    Text = "[Bóp cổ ca sĩ] bị nhiễm \"(Skill.Arg1)\", nhận được vật bị nguyền rủa \"(RelicConfig.Arg2)\""
  },
  Event_6993_ChoiceDesc2 = {
    Text = "[Vấp ngã bước chân vũ công] nhiễm hai lần \"(Skill.Arg1)\", nhận được bạc sáng tạo \"(RelicConfig.Arg2)\" và \"(RelicConfig.Arg3)\""
  },
  Event_6993_ChoiceDesc3 = {
    Text = "[đi đường vòng] nhận được bạc tạo vật [(RelicConfig.Arg1)]"
  },
  Event_6993_Desc = {
    Text = "Bạn bị ba bóng người dính dấp chặn đường. \n Một bóng người hát, giọng khàn, lời bài hát kỳ quái, bạn bịt tai lại, tránh xa nó. \n Một bóng người nhảy múa, động tác cứng nhắc, bước đi do dự, bạn nhắm mắt lại, lẩn tránh nó. \n Một bóng người ngâm thơ, nhịp điệu vụn vặt, câu chữ không thông, bạn không thể chịu đựng thêm, vì vậy——"
  },
  Event_6993_Name = {
    Text = "Kẻ ác trên con đường hẹp"
  },
  Event_6994_ChoiceDesc1 = {Text = "[đi]"},
  Event_6994_Desc = {
    Text = "Một phần sự tức giận đang sôi sục, nhưng nước mắt vẫn không ngừng chảy về thời quá khứ không rõ."
  },
  Event_6994_Name = {
    Text = "Nước mắt của Bờ Biển Bóng Ma"
  },
  Event_6995_ChoiceDesc1 = {
    Text = "[Bỏ qua] Nhiễm [(Skill.Arg1)]"
  },
  Event_6995_ChoiceDesc2 = {
    Text = "[quay lưng rời đi] ngẫu nhiên thức tỉnh một thân thể được đánh thức"
  },
  Event_6995_Desc = {
    Text = "Số mệnh tàn nhẫn đang bò dưới chân người hành giả, con đường như gương sáng bóng, phía sau vang lên tiếng vỡ vụn nhẹ nhàng. \n Rốt cuộc ai đã dẫm nát số mệnh dưới chân? Là ảo tưởng, là cạm bẫy, hay chỉ đơn giản là Delirium, là lời nói dối… \n Trước mắt bạn, một vết nứt chậm rãi bò ra. \n <Italic:như thể nó sẽ chìm đắm vì thức tỉnh linh tri thức.>"
  },
  Event_6995_Name = {
    Text = "Grieta reptante"
  },
  Event_6996_ChoiceDesc1 = {
    Text = "[Bắt đầu thử thách] Nhiễm [(Skill.Arg1)], chiến thắng nhận được 1 vật sáng tạo vàng, thất bại nhận được 50 dấu đen"
  },
  Event_6996_ChoiceDesc2 = {
    Text = "[rời đi] nhận được 50 dấu đen"
  },
  Event_6996_Desc = {
    Text = "Bạn đã nhìn thấy một số bí ẩn từ vũng bùn đen phản chiếu như gương dưới chân. \n Đường viền của nó mờ ảo, xung quanh vây quanh bởi hơi đen không thể xua tan, bạn cảm thấy vô cùng quen thuộc, nhưng lại không thể nhận ra nó rốt cuộc là gì."
  },
  Event_6996_Name = {
    Text = "Dưới bề mặt gương"
  },
  Event_6997_ChoiceDesc1 = {
    Text = "[Học mèo kêu] 50% xác suất nhận được 125 dấu đen, 50% xác suất bị nhiễm [(Skill.Arg2)]"
  },
  Event_6997_ChoiceDesc2 = {
    Text = "[Cung cấp thức ăn] 75% xác suất nhận được 100 dấu đen, 25% xác suất bị nhiễm [(Skill.Arg2)]"
  },
  Event_6997_ChoiceDesc3 = {
    Text = "[chạy ngay đi] nhận được 50 dấu đen"
  },
  Event_6997_Desc = {
    Text = "Bạn đã lạc vào lãnh địa của mèo đen. \n Vô số đôi mắt bỗng mở ra trong bóng tối, mang theo sự tìm hiểu, đánh giá, cảnh giác... chỉ có điều không có lòng tốt. \n Ngọc lục bảo, vàng hổ phách, xanh công... \n Bạn như đang đứng giữa một đại dương ngọc sáng lấp lánh. \n Để thoát thân, bạn——"
  },
  Event_6997_Name = {
    Text = "Thành phố mèo"
  },
  Event_6998_ChoiceDesc1 = {
    Text = "[Về Đào Đen Đá] Nhận 2 thẻ lệnh ngẫu nhiên có khắcăng: \"(EnchantConfig.Arg1)\", \"(EnchantConfig.Arg2)\""
  },
  Event_6998_ChoiceDesc2 = {
    Text = "[Về chó địa ngục] Nhận vật bị nguyền rủa [(RelicConfig.Arg1)]"
  },
  Event_6998_ChoiceDesc3 = {
    Text = "[Về Lily] Nhiễm [(Skill.Arg1)]"
  },
  Event_6998_Desc = {
    Text = "\"Đây là thời gian gợi ý của Đào Đen Đá.\""
  },
  Event_6998_Name = {
    Text = "Thời gian gợi ý"
  },
  Event_6999_ChoiceDesc1 = {
    Text = "[Phóng Nhiệm Chỉ Châm] nhận được vật tạo vàng \"(RelicConfig.Arg1)\", lây nhiễm \"(Skill.Arg2)\""
  },
  Event_6999_ChoiceDesc2 = {
    Text = "[ấn giữ con trỏ] nhận được vật tạo vàng \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_6999_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 50 dấu đen"
  },
  Event_6999_Desc = {
    Text = "Kẹp, kẹp, kẹ——\nSố phận kim chỉ từ từ di chuyển, tiếng kim loại va chạm lạnh lùng chuyển động, hướng tới điều mà bạn tuyệt đối không muốn chứng kiến."
  },
  Event_6999_Name = {
    Text = "Ngoài đầu kim"
  },
  Event_7000_ChoiceDesc1 = {
    Text = "[Ignored] Chọn ngẫu nhiên 3 thẻ lệnh từ bộ bài, chọn 1 thẻ xóa và nhận 75 dấu đen"
  },
  Event_7000_ChoiceDesc2 = {
    Text = "[cẩn thận kiểm tra] Lấy ngẫu nhiên 3 thẻ lệnh từ bộ bài, chọn 1 bản sao gốc để đưa vào bộ bài, nhận 25 dấu đen"
  },
  Event_7000_ChoiceDesc3 = {
    Text = "[quay lưng bỏ đi] nhận được 50 dấu đen"
  },
  Event_7000_Desc = {
    Text = "Số mệnh tàn nhẫn đang bò dưới chân người hành giả, con đường như gương sáng bóng, phía sau vang lên tiếng vỡ vụn nhẹ nhàng. \n Rốt cuộc ai đã dẫm nát số mệnh dưới chân? Là ảo tưởng, là cạm bẫy, hay chỉ đơn giản là Delirium, là lời nói dối… \n Trước mắt bạn, một vết nứt chậm rãi bò ra."
  },
  Event_7000_Name = {
    Text = "Grieta reptante"
  },
  Event_7001_ChoiceDesc1 = {
    Text = "[Gọi chim quạ] nhận được 25 dấu đen, bị lây nhiễm [(Skill.Arg2)], tiếp tục chọn"
  },
  Event_7001_ChoiceDesc2 = {Text = "[xa cách]"},
  Event_7001_Desc = {
    Text = "Móng vuốt sắc nhọn xé rách áo choàng, đâm sâu vào vai."
  },
  Event_7001_Name = {
    Text = "Quạ Cô Độc"
  },
  Event_7002_ChoiceDesc1 = {Text = "[đi]"},
  Event_7002_Desc = {
    Text = "Sợ hãi đôi khi không xuất phát từ thực thể. \n \"Cerberus\"đi qua, để lại những giọt máu đỏ, phản chiếu bóng dáng của bạn."
  },
  Event_7002_Name = {
    Text = "Bản phản chiếu vô hình"
  },
  Event_7003_ChoiceDesc1 = {Text = "[đi]"},
  Event_7003_Desc = {
    Text = "Kèm theo dòng điện nhẹ, bạn nghe thấy giọng thì thầm của người phụ nữ. \n Cô ấy khóc lóc, không ngừng kể về những trải nghiệm của mình. \n Một giờ trôi qua, một ngày trôi qua… cho đến khi bạn đã quên mất cô ấy buồn vì điều gì. \n Cuối cùng, cô ấy vui vẻ cúp điện thoại và hứa hẹn sẽ tặng bạn một món quà lớn. \n Bạn đã nhận món quà. Dù sao đi nữa, quà tặng luôn mang lại niềm vui."
  },
  Event_7003_Name = {
    Text = "Xin hãy nghe điện thoại"
  },
  Event_7004_ChoiceDesc1 = {Text = "[đi]"},
  Event_7004_Desc = {
    Text = "Bạn cúi đầu và quỳ gối xuống đất, sau đó đặt nắm đấm phải lên trán dưới ánh mắt bối rối của những người bạn. \nTuyệt vời, như vậy sẽ hoàn toàn che khuất khuôn mặt bạn."
  },
  Event_7004_Name = {
    Text = "Lừa đảo tinh vi"
  },
  Event_7005_ChoiceDesc1 = {Text = "[đi]"},
  Event_7005_Desc = {
    Text = "\"Bạn đã che mặt tôi bằng tấm voan.\"\nBình tượng nến mỉm cười hiền hòa với bạn. \n \"Tôi sẽ dâng sự thật cho bạn, để ghi nhận những nỗ lực của bạn.\"\nBụng cô ấy liên tục chảy ra chất lỏng đen, bao bọc bạn chặt chẽ. \nThế giới tối om, nhưng lại vô cùng ấm áp. \nBạn co người lại, ngáp một cái, và lần @1 bước vào giấc mơ..."
  },
  Event_7005_Name = {
    Text = "Bình tượng nến chưa hoàn thành"
  },
  Event_7006_ChoiceDesc1 = {
    Text = "[Xác nhận]"
  },
  Event_7006_Desc = {
    Text = "Bạn không thu được gì trong sương mù"
  },
  Event_7006_Name = {
    Text = "Sương hỗn loạn"
  },
  Event_7007_ChoiceDesc1 = {
    Text = "[Nhận cuộc gọi] nhận được chọn 1 trong 3 đá khắc cao cấp"
  },
  Event_7007_ChoiceDesc2 = {
    Text = "[bỏ qua tiếng chuông] nhận được vật tạo vàng \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7007_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 50 dấu đen"
  },
  Event_7007_Desc = {
    Text = "\"đinh linh...\"\n Từ góc phòng vang lên tiếng chuông điện thoại chói tai, gấp gáp và hỗn loạn, một tiếng cao hơn tiếng trước, gần như khiến bạn có cảm giác: nếu không bắt máy, nó sẽ lập tức phát điên nổ tung, rồi hủy diệt thế giới."
  },
  Event_7007_Name = {
    Text = "Xin hãy nghe điện thoại"
  },
  Event_7008_ChoiceDesc1 = {
    Text = "[Nhận được một trong ba sáng tạo bạc khi [Gần hình bóng]]"
  },
  Event_7008_ChoiceDesc2 = {
    Text = "[Đánh tan hình bóng] nhận được bạc tạo vật \"(RelicConfig.Arg1)\"\"(RelicConfig.Arg2)\", nhiễm hai lần \"(Skill.Arg3)\""
  },
  Event_7008_Desc = {
    Text = "Có phải là Fata Morgana trong thâm cảnh không? Hay lại là một ký ức không thể rời bỏ? \n Bạn dụi mắt, bóng hình từ xa đang tiến lại gần bạn — đó là một chợ đông đúc tiếng người, là bảo tàng sáp đã biến mất trong rỗng rỗng, là bệnh viện tâm thần của thị trấn giữa gió tuyết, hay là Akutê mà phong cảnh đã mờ nhạt từ lâu?"
  },
  Event_7008_Name = {
    Text = "Fata Morgana"
  },
  Event_7009_ChoiceDesc1 = {Text = "[đi]"},
  Event_7009_Desc = {
    Text = "Giống như bị nước sôi làm bỏng, bạn phản xạ che tai, cách ly những âm thanh độc ác kia."
  },
  Event_7009_Name = {
    Text = "Âm sắc cấm kỵ"
  },
  Event_7010_ChoiceDesc1 = {Text = "[đi]"},
  Event_7010_Desc = {
    Text = "Nhạc điệu tươi sáng đã xua tan sự căng thẳng và sợ hãi, bạn nhiệt huyết như lửa, bạn tràn đầy sức sống, bạn vui mừng nhảy múa, bạn bước nhanh, bỏ lại Ramona phía sau —\"Người giữ bí mật?! Đừng đi nhanh như vậy!\""
  },
  Event_7010_Name = {
    Text = "Âm thanh vô danh"
  },
  Event_7011_ChoiceDesc1 = {Text = "[đi]"},
  Event_7011_Desc = {
    Text = "\"Dừng lại!!! Quái vật rỗng rỗng bò lê còn quen thuộc với tứ chi của mình hơn cả bạn!\"\nThả qua khán giả...\nBạn cầu nguyện trong lòng như vậy."
  },
  Event_7011_Name = {
    Text = "Kẻ ác trên con đường hẹp"
  },
  Event_7012_ChoiceDesc1 = {Text = "[rút lui]"},
  Event_7012_Desc = {
    Text = "Đây chỉ là thâm cảnh. \n Điều bạn muốn bảo vệ, điều bạn muốn trốn chạy, là hiện thực duy nhất."
  },
  Event_7012_Name = {
    Text = "Vực thẳm xoắn ốc"
  },
  Event_7013_ChoiceDesc1 = {Text = "[đi]"},
  Event_7013_Desc = {
    Text = "\"Bạn mới là người đáng ghét nhất.\"\nBạn xé giấy thảo thành những mảnh nhỏ, tung lên không trung như những cánh hoa bay đi. \nNhà thơ ngẩng đầu nhìn những ký tự bay lả tả trong gió, khóe miệng nở một nụ cười si mê. \n \"Thật đẹp...\""
  },
  Event_7013_Name = {
    Text = "Kẻ ác trên con đường hẹp"
  },
  Event_7014_ChoiceDesc1 = {Text = "[đi]"},
  Event_7014_Desc = {
    Text = "Bạn đã xé cả tấm poster xuống, phát hiện phía sau ghi chép một cách cẩu thả các khoản chi tiêu của bảo tàng sáp. \nChủ nhân của nét chữ rõ ràng không có sự kiên nhẫn và năng khiếu tính toán, những khoản này dù thế nào cũng không thể cân đối được. \nBạn lướt qua một lượt, khoản chi lớn nhất dường như là \"bảo dưỡng và vệ sinh bình tượng nến\". \nChi phí nhân viên thì ít ỏi đáng thương, khoản chi gần đây nhất là 12 chiếc roi da ngựa đuôi, giá khoảng 20 phường. \nCòn một khoản chi đặc biệt —— \"thức ăn của chúng\". \n \"Chúng\" là ai?"
  },
  Event_7014_Name = {
    Text = "Tiếng cười trong bóng tối"
  },
  Event_7015_ChoiceDesc1 = {
    Text = "[Rời] nhận được vật phẩm bạc \"(RelicConfig.Arg1)\", lây nhiễm \"(Skill.Arg2)\""
  },
  Event_7015_Desc = {
    Text = "\"xảo quyệt... và là một câu trả lời chính xác.\"\nChủ nhân của giọng nói tỏ ra rất hứng thú với câu trả lời, một vật thể màu bạc bị hất lên từ mặt nước.\n \"Hãy nhớ, mọi thứ đều có cái giá của nó.\""
  },
  Event_7015_Name = {
    Text = "Giọng ngoài thế giới"
  },
  Event_7016_ChoiceDesc1 = {
    Text = "[ bắt được con bướm thứ hai ] xóa 1 thẻ lệnh, nhận Arg1 dấu đen"
  },
  Event_7016_ChoiceDesc2 = {
    Text = "[không còn lưu luyến]"
  },
  Event_7016_Desc = {
    Text = "Chúng là cư dân của kích thước tinh thần? Hay là sức sống sinh ra từ sự rỗng rỗng. \nMang theo nghi vấn, bạn bước vào một cơn bão bướm đầy mê hoặc."
  },
  Event_7016_Name = {
    Text = "Bão Linh Tri Thức"
  },
  Event_7017_ChoiceDesc1 = {
    Text = "[Quan sát con bướm thứ ba] xóa 1 thẻ lệnh, nhận Arg1 dấu đen"
  },
  Event_7017_ChoiceDesc2 = {
    Text = "[không còn lưu luyến]"
  },
  Event_7017_Desc = {
    Text = "Cảm giác đau đớn ở đầu ngón tay, bạn đột nhiên buông tay ra."
  },
  Event_7017_Name = {
    Text = "Bão Linh Tri Thức"
  },
  Event_7018_ChoiceDesc1 = {
    Text = "[Rời đi] nhận được 25 dấu đen, bị nhiễm [(Skill.Arg1)]"
  },
  Event_7018_Desc = {
    Text = "\"Các người loài người không còn câu trả lời nào khác sao?\"\nChủ nhân của giọng nói phát ra tiếng gầm thấp đầy bực bội, cả không gian rung động theo. \n \"Tham lam và ngớ ngẩn... Đây chính là lý do tôi chán ghét các người.\""
  },
  Event_7018_Name = {
    Text = "Giọng ngoài thế giới"
  },
  Event_7019_ChoiceDesc1 = {Text = "[đi]"},
  Event_7019_Desc = {
    Text = "\"Hãy yên tâm, tôi chỉ cho vị khách tham lam một chút trừng phạt nhỏ mà thôi. Không có cách nào khác, ai bảo tôi không thích uống bia~nhé\""
  },
  Event_7019_Name = {
    Text = "Phân mảnh ký ức · bia"
  },
  Event_7020_ChoiceDesc1 = {Text = "[đi]"},
  Event_7020_Desc = {
    Text = "\"Đừng hát nữa——\"\nBạn cảnh cáo người hát không đúng nhạc, đừng hòng làm tổn hại đến tai của bạn."
  },
  Event_7020_Name = {
    Text = "Kẻ ác trên con đường hẹp"
  },
  Event_7021_ChoiceDesc1 = {
    Text = "[ Rời đi ] Chọn 2 thân thể được đánh thức để thức tỉnh"
  },
  Event_7021_Desc = {
    Text = "Bạn quay người rời đi, nhưng lại bị lạc trong hành lang dài. \n Hành lang không có điểm dừng dường như đã tiêu tốn toàn bộ kiên nhẫn của bạn, cho đến khi bạn phát hiện ra một sân khấu nhỏ và cũ kỹ. \n Bạn chớp mắt, sân khấu liền biến mất."
  },
  Event_7021_Name = {
    Text = "Lễ Kết Thúc Ⅱ"
  },
  Event_7022_ChoiceDesc1 = {
    Text = "[Nhặt ly rượu] nhận được thẻ bài đặc biệt"
  },
  Event_7022_Desc = {
    Text = "Một ly chất lỏng màu vàng óng như ánh hoàng hôn, lắc lư như cánh đồng lúa mùa thu muộn, tỏa ra hương thơm ngọt ngào quyến rũ như mật ong. Thành phần của nó là gì? Ai đã đặt nó ở đây? Tại sao không ai chăm sóc? \n Trước khi những câu hỏi này được giải đáp, một ý nghĩ bí ẩn leo lên trong đầu bạn: bạn phải lập tức, ngay lập tức uống nó. \n Lúc này, bạn bỗng hóa thân thành một con bướm bị lửa dụ dỗ, một con côn trùng bị cây bắt muỗi dụ dỗ, không thể kìm nén mà nhấc ly rượu ngọt lên —"
  },
  Event_7022_Name = {
    Text = "Rượu ngọt mật ong"
  },
  Event_7023_ChoiceDesc1 = {Text = "[đi]"},
  Event_7023_Desc = {
    Text = "Bạn cố gắng kiểm tra cánh cửa này,khi chạm vào,cánh cửa bỗng nhiên biến mất,từ xa vọng lại tiếng gì đó được mở ra"
  },
  Event_7023_Name = {
    Text = "Cánh cửa kỳ lạ"
  },
  Event_7024_ChoiceDesc1 = {
    Text = "[Không xử lý]"
  },
  Event_7024_ChoiceDesc2 = {
    Text = "[Gạt nhẹ dấu bàn tay]"
  },
  Event_7024_Desc = {
    Text = "Văn phòng của Francis lạnh lẽo và gọn gàng, thể hiện sự chỉn chu của chủ nhân. \n Trên một chiếc hộp ở góc phòng, bạn phát hiện ra một dấu ấn bụi có kích thước 5 inch vuông. \n Hình dạng của dấu tay rất kỳ lạ - đường viền bên ngoài giống như dấu chân của một con thú, nhưng ở giữa lại khảm một dấu tay nhỏ của một cô gái. Dường như dấu tay của con người đã để lại trước, sau đó bị bàn tay khổng lồ của con thú phủ lên. \n Bạn chắc chắn có thể tưởng tượng ra những hình ảnh ấm áp, chẳng hạn như một con thú thuần phục ngoan ngoãn đặt móng vuốt lên mu bàn tay của cô gái, dành cho cô những cử chỉ nhẹ nhàng. \n Nhưng bạn biết sự thật - đó là dấu ấn của một con quái vật bị thử nghiệm tàn nhẫn hòa trộn lại."
  },
  Event_7024_Name = {
    Text = "Dấu chân quái thú"
  },
  Event_7025_ChoiceDesc1 = {Text = "[đi]"},
  Event_7025_Desc = {
    Text = "Thí nghiệm lang thang đã khiến bạn vô cùng mệt mỏi, một chút thở phào cũng giống như nước mát trong sa mạc khô cằn."
  },
  Event_7025_Name = {
    Text = "Cổng Vô Hạn"
  },
  Event_7026_ChoiceDesc1 = {
    Text = "[chủ nhân] nhận được vật bị nguyền rủa \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7026_ChoiceDesc2 = {
    Text = "[Mang nó đi] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: [(EnchantConfig.Arg1)]"
  },
  Event_7026_ChoiceDesc3 = {
    Text = "[Mở nó] nhận được 50 dấu đen"
  },
  Event_7026_Desc = {
    Text = "Bạn đang đi về phía trước, chân bạn đá trúng một cái gì đó. \n Đó là một chiếc la bàn, lớp kính đã vỡ, phần còn lại cũng dính đầy dung dịch ăn mòn, bạn cẩn thận lật nó lại, mơ hồ nhìn thấy huy hiệu của Đại học Misag được khắc chìm ở mặt sau."
  },
  Event_7026_Name = {
    Text = "Lựa chọn của cô ấy"
  },
  Event_7027_ChoiceDesc1 = {
    Text = "[Đọc thư] Xóa 1 thẻ lệnh, nhận Arg1 dấu đen"
  },
  Event_7027_ChoiceDesc2 = {
    Text = "[đóng hộp kỹ]"
  },
  Event_7027_Desc = {
    Text = "Một lá, một lá, lại một lá. \nTrên giấy thư viết đầy quá khứ của bạn, lại miêu tả tương lai của bạn. Bị mê hoặc bởi điều gì đó khác thường, bạn không thể kiềm chế được việc xé và nuốt giấy thư. \n \"Này? Bạn đang phát điên cái gì vậy? Hít không khí à?\"\nMuphí đá bạn một cước, kéo bạn ra khỏi ảo giác, khi tỉnh lại, trước mắt không có gì cả."
  },
  Event_7027_Name = {
    Text = "Thư không mời"
  },
  Event_7028_ChoiceDesc1 = {
    Text = "[rời đi] nhận được 1 trong 3 khắcăng"
  },
  Event_7028_Desc = {
    Text = "Nghe thấy giọng bạn, bóng người dừng lại, giọng của Clementine xuyên qua màn sương nước mà đến.\n\"Là bạn đấy à,\" giọng cô ấy mơ hồ, mờ ảo, như ánh trăng tan vào nước, \"Đừng lo lắng, bạn sẽ ổn thôi, anh ấy muốn, nhưng anh ấy không làm được.\"\n\"Khi bạn kết thúc ở đây, chúng ta sẽ gặp lại nhau.\""
  },
  Event_7028_Name = {
    Text = "Hình bóng trong sương mù"
  },
  Event_7029_ChoiceDesc1 = {
    Text = "[Người nhận: Phòng giáo vụ]Nhận di vật bạc「(RelicConfig.Arg1)」"
  },
  Event_7029_ChoiceDesc2 = {
    Text = "[Người nhận: Đối tác]Nhận di vật bạc「(RelicConfig.Arg1)」"
  },
  Event_7029_Desc = {
    Text = "Ngay khi viết xuống tên người nhận, giấy viết thư bốc lên làn khói dày đặc. Một bàn tay vô hình xuyên qua không gian, mạnh mẽ giật lấy tờ giấy viết thư từ tay bạn—\n kèm theo một âm thanh giống như tiếng nhai, cơ thể bạn bỗng trở nên nặng nề. \n Nhưng di vật trong tay lại cho bạn biết, chuyến đi này cũng không phải hoàn toàn không có thu hoạch."
  },
  Event_7029_Name = {
    Text = "Lời tâm sự một chiều"
  },
  Event_7030_ChoiceDesc1 = {
    Text = "[Chèn chìa khóa bạc]"
  },
  Event_7030_Desc = {
    Text = "Trong dung dịch ăn mòn bão hòa rỗng rỗng dường như chứa một số chất… Dùng chìa khóa bạc quan sát, rồi chuyển hóa nó thành lực lượng của bạn."
  },
  Event_7030_Name = {
    Text = "Điểm tách ra"
  },
  Event_7031_ChoiceDesc1 = {Text = "[đi]"},
  Event_7031_Desc = {
    Text = "Hãy đợi đến khi họ bước ra từ bóng tối, rồi chúng ta sẽ tính tiếp."
  },
  Event_7031_Name = {
    Text = "Đèn lồng quạ đen"
  },
  Event_7032_ChoiceDesc1 = {
    Text = "[Gọi quạ] nhận được 35 dấu đen, bị lây nhiễm [(Skill.Arg2)], tiếp tục chọn"
  },
  Event_7032_ChoiceDesc2 = {Text = "[xa cách]"},
  Event_7032_Desc = {
    Text = "Chim đen được triệu hồi, thân thể chúng phình to và nhả ra thứ gì đó vào lòng bàn tay bạn. \nChúng vỗ cánh bay trở lại cột buồm, chăm chú nhìn bạn với ánh mắt rực cháy."
  },
  Event_7032_Name = {
    Text = "Quạ Cô Độc"
  },
  Event_7033_ChoiceDesc1 = {
    Text = "[Nhập hang]"
  },
  Event_7033_ChoiceDesc2 = {Text = "[đi]"},
  Event_7033_Desc = {
    Text = "\"khụ, khụ khụ...\"\nGiọng quen thuộc quá... Nhớ ra rồi chít! \nKhi con người bị bệnh hoặc sắp chết sẽ phát ra âm thanh này! \nNhanh qua xem chít!"
  },
  Event_7033_Name = {
    Text = "Sâu trong hang động"
  },
  Event_7034_ChoiceDesc1 = {Text = "[đi]"},
  Event_7034_Desc = {
    Text = "Bạn đã học mọi kiến thức liên quan đến bạc tâm, bao gồm cả cách xác định cấp bậc của chúng. \n Rõ ràng, những bạc tâm này không thể đạt yêu cầu cơ bản về tinh luyện. \n Bạn buộc phải bỏ chúng đi, cùng với những linh hồn vỡ vụn có thể bị mắc kẹt bên trong. \n Học cách từ bỏ cũng là một môn học bắt buộc của Người Giữ Gìn."
  },
  Event_7034_Name = {
    Text = "Linh hồn bị trói buộc"
  },
  Event_7035_ChoiceDesc1 = {Text = "[đi]"},
  Event_7035_Desc = {
    Text = "Đây là một đường dẫn một chiều, bạn không thể quay lại lối vào thông qua nó"
  },
  Event_7035_Name = {
    Text = "Đoạn đường"
  },
  Event_7036_ChoiceDesc1 = {Text = "[đi]"},
  Event_7036_Desc = {
    Text = "Càng kết thúc sớm, càng yên tâm. Điều tra viên của Misaque không bao giờ sợ nguy hiểm."
  },
  Event_7036_Name = {
    Text = "Cổng Vô Hạn"
  },
  Event_7037_ChoiceDesc1 = {
    Text = "[Xin nhường đường, tôi có việc gấp]"
  },
  Event_7037_ChoiceDesc2 = {
    Text = "[Wish to Hear Details]"
  },
  Event_7037_Desc = {
    Text = "\"Vị học sinh này, xin dừng lại. Nhìn mặt các em nghiêm trọng, vội vàng, có lẽ đã rơi vào một khó khăn nào đó. \nNhưng cuộc đời không nên từ bỏ cái nhìn toàn diện và sự bình tĩnh chỉ vì những khó khăn trước mắt. \nChẳng hạn như mấy ngày nay tôi suy nghĩ kỹ, trong truyền thuyết về Khắc Nhĩ Bách Lạc Tư có nhiều điểm không phù hợp với tình hình hiện tại.\""
  },
  Event_7037_Name = {
    Text = "Bạn đồng hành kỳ quái Ⅱ"
  },
  Event_7038_ChoiceDesc1 = {
    Text = "[tiếp nhận quà tặng]"
  },
  Event_7038_ChoiceDesc2 = {
    Text = "[Từ chối khéo léo]"
  },
  Event_7038_Desc = {
    Text = "Cậu bé ngồi trên bệ cửa sổ nhìn bạn. Anh ấy đã chờ bạn rất lâu rồi. \n \"Buổi diễn rất thành công, cảm, cảm ơn bạn.\"\n \"Tôi sắp rời đi... Đây là quà tặng dành cho bạn.\"\nCậu bé đưa tay ra trước mặt bạn. \nBạn thấy một hộp quà tinh xảo, máu từ đó chảy ra, nhuốm đỏ bàn tay cậu bé."
  },
  Event_7038_Name = {
    Text = "Lễ Kết Thúc Ⅵ"
  },
  Event_7039_ChoiceDesc1 = {Text = "[đi]"},
  Event_7039_Desc = {
    Text = "Mong rằng bạn luôn giữ được sự tự tin như thế này."
  },
  Event_7039_Name = {
    Text = "Bản phản chiếu vô hình"
  },
  Event_7040_ChoiceDesc1 = {Text = "[đi]"},
  Event_7040_Desc = {
    Text = "Bạn đã nhận lấy chiếc tai nhỏ bé, mềm mại này. \n Nó được quấn trong lớp sáp dính, yên lặng nằm ở giữa lòng bàn tay bạn. \n Một cảm giác trách nhiệm mạnh mẽ dâng lên trong lòng bạn. \n Đầu tiên, quán bar không thể tùy tiện đến, âm nhạc ở đó quá hỗn loạn. \n Thứ hai, nhà hát Wellington Garden cũng không thể đến, dàn nhạc ở đó đã quá cũ kỹ. \n Sau đó… \n Bạn và những người bạn đồng hành đã chấp nhận tốt việc có thêm một thú cưng nhỏ."
  },
  Event_7040_Name = {
    Text = "Dặt tai lắng nghe"
  },
  Event_7041_ChoiceDesc1 = {Text = "[đi]"},
  Event_7041_Desc = {
    Text = "\"Giáo sư Alistair là nền tảng của Misaque, nếu không có ông, mọi hệ thống của Misaque sẽ ngừng hoạt động.\"\n Bạn mơ hồ nhớ lại một tiết học khiến bạn mệt mỏi muốn ngủ, Khổ Lệ Đặc cau có gõ lên bảng nói câu này. \n Nếu nền tảng sụp đổ thành những mảnh vỡ, bạn sẽ phải đối mặt như thế nào? Nỗi sợ hãi to lớn bao trùm lấy bạn. \n \"Bạn định đi đâu?\" Ramona gọi bạn trở về thực tại. \n Đó là quá khứ hay tương lai, là sự thật hay tưởng tượng, hay là giấc mơ ảo trong một chiều khác? Bạn cũng không biết nữa. \n Trong tay bạn, xuất hiện một món \"quà tặng\"."
  },
  Event_7041_Name = {
    Text = "Hỗn loạn than khóc"
  },
  Event_7042_ChoiceDesc1 = {Text = "[đi]"},
  Event_7042_Desc = {
    Text = "\"Chiếc xe lăn này chính là đôi chân thứ hai của tôi, có lẽ cả đời này tôi không thể rời xa nó,\" Giáo sư Alistair mỉm cười buồn bã,\"Đáng tiếc là nó khiến tôi trông thấp hơn nhiều.\"\n\nVì vậy, điều này không thể là giáo sư Alistair thật sự."
  },
  Event_7042_Name = {
    Text = "Hỗn loạn than khóc"
  },
  Event_7043_ChoiceDesc1 = {
    Text = "[Ai đang nói vậy?] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7043_ChoiceDesc2 = {
    Text = "[Whiskey gì vậy, cho tôi Thử nếm với] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7043_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_7043_Desc = {
    Text = "\"Cậu thật sự không thử một ngụm sao? Đây là loại whisky thượng hạng đấy. Nếu không phải chủ quán bar kia rộng rãi tặng tôi cả chai, tôi còn không muốn chia sẻ cho cậu một giọt nào đâu.\"\n \"Vì vậy, cậu đã giúp anh ta đuổi đi tên gầy nhom, da căng như cao su, chỉ uống Bloody Mary kia, đó là toàn bộ phần thưởng của cậu từ chủ quán. Để điều tra vụ việc đó, cậu đã mất một tháng, phỏng vấn ba mươi hộ gia đình, bị mười một lần từ chối, và tiêu thụ mười bảy viên đạn súng quay nòng. Một chai whisky, cậu còn chưa thu hồi được vốn.\"\n \"Thôi nào, đừng tính toán nhiều như thế. Ít nhất, chúng ta hiện có chai whisky này, phải không?\""
  },
  Event_7043_Name = {
    Text = "Hồi tưởng phân mảnh · Whisky"
  },
  Event_7044_ChoiceDesc1 = {Text = "[đi]"},
  Event_7044_Desc = {
    Text = "Bạn nắm lấy xúc tu của thân thể được đánh thức, anh ta quay đầu nhìn bạn, trong mắt lóe lên ánh sáng tối tăm khó hiểu. \nAnh ta im lặng, nhưng bạn vẫn hiểu được ý tứ sâu kín của anh ta — \n \"Phạm thượng.\""
  },
  Event_7044_Name = {
    Text = "Hiệu ứng bướm"
  },
  Event_7045_ChoiceDesc1 = {Text = "[đi]"},
  Event_7045_Desc = {
    Text = "Máy điện báo đã bị hư hỏng hoàn toàn. Bạn có thể tưởng tượng sự tuyệt vọng của chủ nhân máy điện báo trong cơn bão…… bởi vì lúc này bạn cũng vậy."
  },
  Event_7045_Name = {
    Text = "Di sản của người xưa"
  },
  Event_7046_ChoiceDesc1 = {Text = "[đi]"},
  Event_7046_Desc = {
    Text = "Tên: Reia\nTuổi: 20\nBiến chứng: Bệnh khát máu kèm theo chứng hưng cảm nghiêm trọng\nSinh vật ký sinh: xúc tu đỏ thẫm @2 miệng\nMô ghép: tổ chức cơ quan huyết thống trực hệ @3\nLý do chuyển giao: Không có lý do gì đặc biệt. Tôi không thích cô ấy.\n(Nội dung phía sau đã bị gạch bỏ)"
  },
  Event_7046_Name = {
    Text = "Đăng ký cơ quan"
  },
  Event_7047_ChoiceDesc1 = {
    Text = "[Chọn「Nhận phúc lành」]Mất tất cả dấu đen. Nhận được 1 sáng tạo vàng."
  },
  Event_7047_Desc = {
    Text = "Một cục bùn đen xuất hiện trước mặt bạn, run rẩy đưa ra một bản văn kiện. \n \"Hiện tại tôi không tiện xuất diện... nhưng bạn có thể tìm hiểu về dịch vụ tùy chỉnh của chúng tôi...\"\n Giọng nữ từ trong lồng ngực bùn đen vang lên, hơi hoảng loạn, dường như đang trốn tránh gì đó. \n \"Phúc lành của Tiên nữ sẽ có hiệu lực dựa trên cấp độ hội viên, đảm bảo công bằng cho mọi người.\"\n \"Ký, mau ký!\""
  },
  Event_7047_Name = {
    Text = "Phúc lành của Tiên nữ"
  },
  Event_7048_ChoiceDesc1 = {
    Text = "[Dỏng tai lắng nghe] nhận được bạc tạo vật \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7048_ChoiceDesc2 = {
    Text = "[tiến lên kiểm tra]tất cả các thân thể được đánh thức hồi 50 điên cuồng, nhiễm 「(Skill.Arg1)」"
  },
  Event_7048_ChoiceDesc3 = {
    Text = "[trực tiếp rời đi] nhận được một trong ba lựa chọn khắcăng"
  },
  Event_7048_Desc = {
    Text = "\"Bạn có biết không?\" Trong khi Ramona đang tìm kiếm hình bóng của người bí ẩn, một giọng nói bỗng nhiên vang lên, như thể ai đó đang thì thầm bàn tán, \"Bạn có biết chuyện đó không? Chuyện lớn ấy?\""
  },
  Event_7048_Name = {
    Text = "Tai người khác"
  },
  Event_7049_ChoiceDesc1 = {
    Text = "[Chú tâm] xóa tối đa 2 thẻ triệu chứng."
  },
  Event_7049_ChoiceDesc2 = {
    Text = "[Thiền định] Chọn 1 thân thể được đánh thức để tiến hành thức tỉnh."
  },
  Event_7049_ChoiceDesc3 = {
    Text = "[Kết nối] phục hồi Arg2 điểm sức sống."
  },
  Event_7049_Desc = {
    Text = "Bạn đang khám phá trong sương mù, đột nhiên, huy hiệu trường trên ngực bạn phát ra ánh sáng bạc yếu ớt. Ai đang gọi bạn từ bên kia thiết bị liên lạc?"
  },
  Event_7049_Name = {
    Text = "điểm liên lạc"
  },
  Event_7050_ChoiceDesc1 = {
    Text = "[Cẩn trọng] tăng Arg1 điểm máu tối đa"
  },
  Event_7050_ChoiceDesc2 = {
    Text = "[Tiến lên phía trước] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7050_Desc = {
    Text = "Bóng hình từ thâm cảnh đưa tay về phía bạn, vẻ mờ ảo. \nBạn nhớ rằng, từng có một điều tra viên Misaque lên con tàu này, liệu đó có phải là anh ta? \nHay đây chỉ là một ký ức đau thương khác bị thâm cảnh giam giữ."
  },
  Event_7050_Name = {
    Text = "Người sử dụng chìa khóa bạc"
  },
  Event_7051_ChoiceDesc1 = {
    Text = "[Rời đi] nhận được vật sáng tạo vàng \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7051_Desc = {
    Text = "\"Bạn xem, chỉ vì một câu nói bâng quơ của tôi mà đã bỏ qua tình huống cấp bách nhất, điều này không tốt chút nào. \nNếu chậm trễ thêm, con mồi của các bạn chắc chắn sẽ chạy xa. \nĐể bày tỏ lòng xin lỗi, tôi tặng các bạn những thứ này.\"\n\nNgười đàn ông nhanh chóng chuyển đề tài, đưa một món đồ cho các bạn."
  },
  Event_7051_Name = {
    Text = "Bạn đồng hành kỳ quái Ⅱ"
  },
  Event_7052_ChoiceDesc1 = {
    Text = "[rời đi] chọn 1 thẻ lệnh từ 3 thẻ lệnh để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_7052_Desc = {
    Text = "\"Mong bạn đạt được những gì mình muốn.\"\n Người đàn ông không để tâm, nghiêng người nhường một con đường."
  },
  Event_7052_Name = {
    Text = "Bạn đồng hành kỳ quái Ⅱ"
  },
  Event_7053_ChoiceDesc1 = {
    Text = "[thu vào túi]"
  },
  Event_7053_Desc = {
    Text = "Một chất bạc có trạng thái gần như thủy ngân, được chiết xuất từ dịch nhầy rỗng rỗng, mang trong mình sức mạnh tinh thần lớn, dùng chủ yếu để liên kết nhiều thân thể được đánh thức hơn trong các nghi lễ."
  },
  Event_7053_Name = {Text = "bạc tâm"},
  Event_7054_ChoiceDesc1 = {Text = "[đi]"},
  Event_7054_Desc = {
    Text = "Bạn lại đi vào một con đường khác. \n Mặt trời vẫn mọc, con người vẫn chết, và bạn vẫn lạc đường. \n Không có điều gì mới lạ cả."
  },
  Event_7054_Name = {
    Text = "Mê cung của Mắt"
  },
  Event_7055_ChoiceDesc1 = {Text = "[đi]"},
  Event_7055_Desc = {
    Text = "Đó có vẻ là cái bóng bị biến dạng do khúc xạ ánh sáng."
  },
  Event_7055_Name = {
    Text = "Đối tượng nổi trong xô"
  },
  Event_7056_ChoiceDesc1 = {Text = "[đi]"},
  Event_7056_Desc = {
    Text = "Bạn quay người lại, chỉ thấy một đôi giày da cô đơn. \n \"Xin lỗi, tôi không có ý xấu.\"\n \"Nếu bạn gặp được thân thể của tôi, hãy giúp tôi chuyển lời, người bạn đồng hành trung thành nhất của nó đang chờ ở tủ trưng bày số 45, phòng triển lãm số 1.\"\n \"—— Nhớ kỹ, là đôi bằng da bò, không phải da dê.\""
  },
  Event_7056_Name = {Text = "Oxford"},
  Event_7057_ChoiceDesc1 = {Text = "[đi]"},
  Event_7057_Desc = {
    Text = "Chắc chắn là bạn học cũ——bạn dang rộng vòng tay về phía Người, nhưng điều tiếp theo đến là nỗi đau lạnh buốt thấu xương. \nKhi cơn đau biến mất, bốn chi trở nên mạnh mẽ một cách kỳ diệu, chưa từng có."
  },
  Event_7057_Name = {
    Text = "Người sử dụng chìa khóa bạc"
  },
  Event_7058_ChoiceDesc1 = {Text = "[đi]"},
  Event_7058_Desc = {
    Text = "Bạn cảm thấy sương mù trước mắt dường như nhạt đi\n\nBạn cảm thấy, trong hành động tiếp theo, tầm nhìn của mình trở nên sắc nét hơn"
  },
  Event_7058_Name = {
    Text = "Thử thách Asura"
  },
  Event_7059_ChoiceDesc1 = {Text = "[đi]"},
  Event_7059_Desc = {
    Text = "Hình bóng cũng tiến gần bạn, ký ức bỗng nhiên ập đến, trước mắt trở nên rõ ràng."
  },
  Event_7059_Name = {
    Text = "Fata Morgana"
  },
  Event_7060_ChoiceDesc1 = {Text = "[đi]"},
  Event_7060_Desc = {
    Text = "Sự vô thức của Ngài vẫn lặng lẽ thay đổi điều gì đó."
  },
  Event_7060_Name = {
    Text = "Ánh nhìn của Người"
  },
  Event_7061_ChoiceDesc1 = {Text = "[đi]"},
  Event_7061_Desc = {
    Text = "Đây không phải lúc để thu thập bạc tâm."
  },
  Event_7061_Name = {
    Text = "Chứng minh sự tồn tại"
  },
  Event_7062_ChoiceDesc1 = {
    Text = "[rời đi] nhận được 3 chọn 1 vật phẩm bạc, nhiễm phải 「(Skill.Arg1)」"
  },
  Event_7062_Desc = {
    Text = "Hình dáng mờ ảo dần dần rõ ràng, đó không phải là thân thể bị ăn mòn, cũng không phải là thảm họa, mà là Clementine không có cánh, vẻ mặt bình thường. \n「Thật trùng hợp, bạn cũng đến ngắm trăng sao?」Cô ấy cười nói, nhưng bạn cảm thấy một cơn chóng mặt, 「Đêm sương mù dày đặc, vẫn cần phải cẩn thận hơn đấy.」\n「Những tiểu quỷ ở đây, không mấy khi ngoan ngoãn đâu.」"
  },
  Event_7062_Name = {
    Text = "Hình bóng trong sương mù"
  },
  Event_7063_ChoiceDesc1 = {Text = "[đi]"},
  Event_7063_Desc = {
    Text = "Với tiếng vỡ của khối thạch cao ném xuống đất, thân thể cô ấy vỡ vụn theo. Tiếng gầm đầy phẫn nộ vang lên trong đầu bạn, nhưng may mắn thay, bạn đã kịp dừng bước đúng lúc."
  },
  Event_7063_Name = {
    Text = "Hoàn thiện xác tàn"
  },
  Event_7064_ChoiceDesc1 = {
    Text = "[Lắng nghe nỗi buồn] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7064_ChoiceDesc2 = {
    Text = "[Lắng nghe niềm vui] Mỗi thân thể được đánh thức có giá trị điên cuồng từ 50 trở lên sẽ nhận được 15 dấu đen"
  },
  Event_7064_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 1 trong 3 khắcăng"
  },
  Event_7064_Desc = {
    Text = "Du dương, trữ tình, vui mừng, u buồn… Giai điệu vang vọng trong không gian thâm cảnh, khó lòng phân biệt nguồn gốc. \n Đây là bản sonata chảy ra từ âm thanh của con tàu ma, hay là một bản trường ca nửa đêm bị hạn chế trong thâm cảnh?"
  },
  Event_7064_Name = {
    Text = "Âm thanh vô danh"
  },
  Event_7065_ChoiceDesc1 = {
    Text = "[Họ đang tìm kiếm ai đó] xóa 1 thẻ lệnh, nhận 25 dấu đen"
  },
  Event_7065_ChoiceDesc2 = {
    Text = "[Họ đang tìm kiếm một vật phẩm] sao chép một lá bài từ bộ bài, nhiễm [(Skill.Arg1)]"
  },
  Event_7065_Desc = {
    Text = "Tại sao đám tín đồ cầm đèn lại đột nhiên xuất hiện ở Làng Lai? Có quá nhiều bí ẩn ở đây. \n Chó địa ngục Cerberus, giám đốc bệnh viện tâm thần Làng Lai Francis, Hiệp hội Điêu khắc gia, Hội Giáo đèn lồng… \n Chắc chắn có một nguồn gốc nào đó đã tập hợp họ lại ở cái thị trấn không đông đúc này. \n Máy đánh chữ đột nhiên tự động phun mực, như thể đang dẫn bạn đến việc nhập vào điều gì đó."
  },
  Event_7065_Name = {
    Text = "Phương pháp nhập bí ẩn"
  },
  Event_7066_ChoiceDesc1 = {
    Text = "[khép chặt mắt]"
  },
  Event_7066_ChoiceDesc2 = {
    Text = "[thoát khỏi hiện trường]"
  },
  Event_7066_Desc = {
    Text = "Buổi biểu diễn đột ngột dừng lại. Bạn nhìn quanh, phát hiện xung quanh đầy rẫy khán giả. \n Chúng có khuôn mặt giống hệt cậu bé, đang đồng loạt nhìn bạn. \n À —— \n Chúng mở miệng đen ngòm về phía bạn một cách im lặng."
  },
  Event_7066_Name = {
    Text = "Lễ Chấm Dứt Ⅴ"
  },
  Event_7067_ChoiceDesc1 = {
    Text = "[Nhặt ảnh] Chọn 1 trong 3 thẻ lệnh để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_7067_ChoiceDesc2 = {
    Text = "[Kiểm tra cuộn phim] Nhiễm [(Skill.Arg1)], thay đổi khắc ấn nhận được từ lựa chọn 1 và có thể sử dụng thêm một lần nữa"
  },
  Event_7067_Desc = {
    Text = "Bạn đặt cuộn phim dưới ánh đèn đỏ mờ, lớp nền bán trong suốt mờ ảo hiện ra hình ảnh. \n Tay, chân, nhãn cầu, nội tạng… tất cả các cơ quan trên cơ thể mà bạn có thể tưởng tượng hoặc không thể tưởng tượng đều được ghi lại trung thành trên cuộn phim. \n Chúng được rửa sạch cẩn thận, sắp xếp gọn gàng, trông như bài thơ đầu tiên bạn viết theo thể loại."
  },
  Event_7067_Name = {
    Text = "ghi lại trung thực"
  },
  Event_7068_ChoiceDesc1 = {
    Text = "[Công chúa bảo vệ] ngẫu nhiên thức tỉnh 1 thân thể được đánh thức, lây nhiễm [(Skill.Arg1)]"
  },
  Event_7068_ChoiceDesc2 = {
    Text = "[Người Suy Ngẫm] chọn 1 trong 3 thẻ lệnh để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_7068_Desc = {
    Text = "\"độp, độp, độp...\"\n Tiếng bước chân từ xa đến gần, Nhìn thấy có người sắp đẩy cánh cửa lớn của studio. \n Các ngươi không còn đường lui, chỉ có thể mượn ánh sáng mờ tối giả dạng thành bình tượng nến, hy vọng tránh được đôi mắt soi mói kia."
  },
  Event_7068_Name = {
    Text = "Lừa đảo tinh vi"
  },
  Event_7069_ChoiceDesc1 = {Text = "[đi]"},
  Event_7069_Desc = {
    Text = "\"Quá tốt, quá tốt!\" giọng nói đầy hạnh phúc, \"Cuối cùng em cũng trở nên giống chị rồi, chị Sasha!\""
  },
  Event_7069_Name = {
    Text = "\"chị Sasa\""
  },
  Event_7070_ChoiceDesc1 = {Text = "[đi]"},
  Event_7070_Desc = {
    Text = "Có lẽ là ai đó đã dẫn họ đến đây. \nKhi bạn khám phá, danh tính của người đó sẽ được hé lộ."
  },
  Event_7070_Name = {
    Text = "Phương pháp nhập bí ẩn"
  },
  Event_7071_ChoiceDesc1 = {Text = "[đi]"},
  Event_7071_Desc = {
    Text = "Càng kết thúc sớm, càng yên tâm. Điều tra viên của Misaque không bao giờ sợ nguy hiểm."
  },
  Event_7071_Name = {
    Text = "Cánh cửa vô tận"
  },
  Event_7072_ChoiceDesc1 = {
    Text = "[Chọn Đạo Đức] phục hồi Arg1 điểm sức sống"
  },
  Event_7072_ChoiceDesc2 = {
    Text = "[Chọn sức sống] Phục hồi toàn bộ máu, nhiễm [(Skill.Arg2)]"
  },
  Event_7072_Desc = {
    Text = "Có lẽ bạn đã từng có một trái tim như vàng. \n Nó đập không ngừng nghỉ, hết mình vì sự sống và cuộc sống của bạn… ấm áp, mãnh liệt và đầy hy vọng. \n Nhưng không biết từ khi nào, nhịp đập của nó dần chậm lại. Giống như sự sống và đạo đức, nó chỉ có thể chịu đựng một trong hai…"
  },
  Event_7072_Name = {
    Text = "Lời nguyền khát vọng"
  },
  Event_7073_ChoiceDesc1 = {
    Text = "[Nhặt ảnh] Chọn 1 trong 3 thẻ lệnh để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_7073_ChoiceDesc2 = {
    Text = "[Kiểm tra cuộn phim] Nhiễm [(Skill.Arg1)], thay đổi khắcăng nhận được từ tùy chọn 1, có thể sử dụng hai lần"
  },
  Event_7073_Desc = {
    Text = "\"Vì vậy, bạn đã ghi lại tất cả mọi thứ một cách chính xác.\"\n \"Đúng vậy, cuộn phim chính là sự thật.\"\n Cuộc trò chuyện đột ngột dừng lại, vô số ánh mắt vô hình đồng loạt hướng về phía bạn, dường như đang chờ đợi phán quyết cuối cùng của bạn."
  },
  Event_7073_Name = {
    Text = "Lời khai của nhân chứng"
  },
  Event_7074_ChoiceDesc1 = {
    Text = "[rời đi] tăng Arg1 điểm sức sống, và nhận được 25 dấu đen"
  },
  Event_7074_Desc = {
    Text = "Giọng bạn bị tiếng gió gào thét nuốt chửng. \n \"Bạn không cần phải biết tôi,\" tiếng xì xào trong câu nói càng ngày càng rõ ràng,\"Herbert, Herbert mới là người các bạn đang tìm. Hãy để tên đó rơi xuống, từ giấc mơ giả tạo, rơi vào thực tế khắc nghiệt lạnh lùng.\"\n \"Tôi sẽ ban cho các bạn phúc lành, ban cho các bạn thứ ngon nhất trên thế gian này...\""
  },
  Event_7074_Name = {
    Text = "Người bạn đồng hành kỳ lạ Ⅵ"
  },
  Event_7075_ChoiceDesc1 = {
    Text = "[rời đi] nhận được sáng tạo \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7075_Desc = {
    Text = "\"Đúng vậy, kẻ lạc lối đáng thương, người sở hữu lực lượng nhưng không thể nhận ra chính mình. \nNgươi có muốn đưa tay giúp đỡ không? Hay sẽ giơ vũ khí lên chống lại Ngài?\"\nNgười đàn ông tung mình nhảy vào dòng nước xiết, ngay khoảnh khắc anh ta rơi xuống, ánh mắt của anh ta và ngươi vô tình chạm nhau. Đó là đôi đồng tử dọc thuộc loài rắn, màu vàng óng như mật ong nhỏ giọt. \nVà tại nơi anh ta vừa đứng, một chiếc đèn nhỏ tỏa khói tím vẫn còn đó."
  },
  Event_7075_Name = {
    Text = "Người bạn đồng hành kỳ lạ Ⅵ"
  },
  Event_7076_ChoiceDesc1 = {Text = "[đi]"},
  Event_7076_Desc = {
    Text = "\"Cẩn trọng là một đức tính, nhưng quá cẩn trọng lại là không hợp thời,\" giọng nói bình ổn không đổi ẩn chứa sự bất mãn, \"Sự vận hành của tinh tú sẽ can thiệp vào nguồn gốc đang ngủ yên của thân thể được đánh thức, và thời điểm thích hợp có thể khiến điên cuồng của Họ phồng lên nhanh chóng như thổi bóng bay. Tóm lại, bây giờ vẫn còn kịp để nắm lấy đuôi sao chổi, lần sau nhớ tối ưu hóa tốc độ phản ứng chậm như rùa của bạn.\""
  },
  Event_7076_Name = {Text = "Góc nâng"},
  Event_7077_ChoiceDesc1 = {
    Text = "[Phản hồi] Áp lực hiện tại giảm một nửa."
  },
  Event_7077_Desc = {
    Text = "Bạn đã tiếp xúc với buồng ổn áp, có thể khôi phục giá trị áp lực hiện tại"
  },
  Event_7077_Name = {
    Text = "Điểm ổn định áp lực"
  },
  Event_7078_ChoiceDesc1 = {
    Text = "[An ủi cô ấy] Chọn 1 trong 3 thẻ lệnh nhận được Khắc ấn: [(EnchantConfig.Arg1)]"
  },
  Event_7078_ChoiceDesc2 = {
    Text = "[trách móc cô ấy] ngẫu nhiên 3 thẻ lệnh nhận được khắcăng: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7078_Desc = {
    Text = "\"Tôi là bóng tối của điều tra viên đã chết, hung thủ là chìa khóa bạc.\"\nNgười phụ nữ đau khổ ôm đầu. Tóc cô ấy rất dày, trên đó có vô số con mắt lấp lánh chớp chớp, chớp chớp...\n \"Họ luôn nói: Không được, Charlotte! Than ôi, Charlotte!\nVì vậy tôi nghĩ, nếu tôi có thể liên kết nhiều thân thể được đánh thức cùng một lúc, tất cả mọi người sẽ im lặng.\"\n \"Rồi... tôi cũng không biết chuyện gì đã xảy ra, khi tỉnh dậy tôi đã trở thành như thế này. Than ôi!\""
  },
  Event_7078_Name = {
    Text = "Bóng của Điều tra viên"
  },
  Event_7079_ChoiceDesc1 = {
    Text = "[Lật qua bức tường cao] nhận được vật bị nguyền rủa \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7079_ChoiceDesc2 = {
    Text = "[Vào mê cung] 1 thẻ bài ngẫu nhiên nhận được Khắc ấn: [(EnchantConfig.Arg1)]"
  },
  Event_7079_Desc = {
    Text = "Bộ não của bạn là một mê cung.\nQuá nhiều suy nghĩ vướng víu trong đó, lối ra hiện ra ngay trong tầm Ánh Mắt, những bức tường cao của tư duy sừng sững giữa bạn và nó."
  },
  Event_7079_Name = {
    Text = "Mê cung tư duy"
  },
  Event_7080_ChoiceDesc1 = {
    Text = "[ Viễn vọng hình bóng ] nhận được 3 lựa chọn 1 bạc sáng tạo"
  },
  Event_7080_ChoiceDesc2 = {
    Text = "[Gần hình bóng] nhận được bạc sáng tạo \"(RelicConfig.Arg1)\", \"(RelicConfig.Arg2)\", nhiễm hai lần \"(Skill.Arg3)\""
  },
  Event_7080_Desc = {
    Text = "Từ xa dường như có một miệng núi lửa phun trào, trong bầu trời bị gió mạnh tàn phá, những làn khói hình người đang bốc lên. \n Đây chính là Elworth, Elworth chỉ có những ngọn núi tuyết cao chót vót và những hang động đá vôi. \n Có phải những hiện tượng kỳ lạ liên tiếp khiến bạn phát điên không?"
  },
  Event_7080_Name = {
    Text = "Hình bóng núi lửa"
  },
  Event_7081_ChoiceDesc1 = {
    Text = "[Tôi đã thấy gì] nhận được vật phẩm bạc [(RelicConfig.Arg1)]"
  },
  Event_7081_ChoiceDesc2 = {
    Text = "[Tôi không thấy gì cả] nhận được vật tạo vàng \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7081_Desc = {
    Text = "Chất lỏng rỉ ra từ đáy mắt bạn, cảm giác dính đặc khiến người ta kinh hoàng. \nSâu thẳm bên trong, tất cả bắt nguồn từ những gì bạn đã chứng kiến, còn bạn — liệu thực sự bạn không nhìn thấy gì sao?"
  },
  Event_7081_Name = {
    Text = "Không được nhìn trực tiếp"
  },
  Event_7082_ChoiceDesc1 = {Text = "[đi]"},
  Event_7082_Desc = {
    Text = "Bạn cũng sẽ vui vẻ, cũng sẽ buồn bã, nhưng lúc này nhấn chìm bạn không phải là cảm xúc của bạn. Bạn che tai lại, chìa khóa bạc phát sáng rực rỡ. \nCuối cùng, bạn có thể thở được rồi."
  },
  Event_7082_Name = {Text = "Nghiện"},
  Event_7083_ChoiceDesc1 = {Text = "[đi]"},
  Event_7083_Desc = {
    Text = "Người cầm dao găm phát ra tiếng kêu, như chim báo tang giữa nghĩa địa đêm. \n Tiếng động tan biến trong chớp mắt, hai người dấn thân vào biển cũng biến mất tăm… Hóa ra chỉ là ảo ảnh phản chiếu từ thâm cảnh."
  },
  Event_7083_Name = {
    Text = "Truy đuổi không ngừng"
  },
  Event_7084_ChoiceDesc1 = {Text = "[đi]"},
  Event_7084_Desc = {
    Text = "Nó cứ lơ lửng như vậy trong không trung, không chớp mắt, ánh mắt tha thiết, dường như muốn nói với bạn điều gì. \n Đôi mắt có thể chứa đựng linh hồn, nhưng nếu không có lời nói, bạn cũng chỉ có thể cảm nhận được một chút cấp bách, một chút buồn bã. \n Nó đã biến mất trong hư không."
  },
  Event_7084_Name = {
    Text = "Nhìn mù quáng"
  },
  Event_7085_ChoiceDesc1 = {
    Text = "[biểu thị tán thành] nhận được bạc sáng tạo \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7085_ChoiceDesc2 = {
    Text = "[gửi tặng quà] nhận được bạc tạo vật \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7085_ChoiceDesc3 = {
    Text = "[quay lưng rời đi] nhận được 25 dấu đen"
  },
  Event_7085_Desc = {
    Text = "\"Nếu một ngày tôi chắc chắn sẽ rơi xuống, tôi hy vọng có thể rơi vào nước. \nDòng nước tràn qua mũi như một giấc mơ dịu dàng cũ, \nchất lỏng mà tôi chìm vào, \nlà @2 cái chén khao khát nhất.\""
  },
  Event_7085_Name = {
    Text = "Lễ hội nước"
  },
  Event_7086_ChoiceDesc1 = {
    Text = "[Khang cự ảo giác] nhận được vật tạo vàng \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7086_ChoiceDesc2 = {
    Text = "[Hút Cuồng Khí] ngẫu nhiên thức tỉnh 2 thân thể được đánh thức, lây nhiễm hai lần [(Skill.Arg1)]"
  },
  Event_7086_Desc = {
    Text = "Chiều bị hư hỏng dần sụp đổ, ảo giác từ các chiều khác tràn vào căn phòng méo mó vì bệnh tật."
  },
  Event_7086_Name = {
    Text = "Ảo ảnh chiều"
  },
  Event_7087_ChoiceDesc1 = {
    Text = "[ Rời đi ] Ngẫu nhiên đánh thức 1 thân thể được kích hoạt"
  },
  Event_7087_Desc = {
    Text = "Cô gái giật mình, đưa tay vuốt ve bên mép váy. \n \"Điều tôi có thể làm cho bạn... chỉ có thế thôi.\""
  },
  Event_7087_Name = {
    Text = "Gái mặc váy trắng"
  },
  Event_7088_ChoiceDesc1 = {Text = "[đi]"},
  Event_7088_Desc = {
    Text = "Ai đang nói vậy?\nBạn cúi đầu xuống, chỉ thấy một bóng phản chiếu mờ nhạt — nó mặc bộ quần áo giống hệt bạn, nhưng tay cầm một con dao, đang nở nụ cười hướng về phía bạn."
  },
  Event_7088_Name = {
    Text = "Bạn sẽ không muốn tìm thấy"
  },
  Event_70892_ChoiceDesc1 = {
    Text = "[thích ứng với ký ức của thân thể] bỏ qua trận chiến và chiến thắng ngay lập tức, nhưng mất Arg1 điểm sức sống."
  },
  Event_70892_ChoiceDesc2 = {
    Text = "[rời đi] vào chiến đấu"
  },
  Event_70892_Desc = {
    Text = "Dù kẻ thù cực kỳ mạnh mẽ, nhưng bạn đã nắm vững cách đánh bại chúng."
  },
  Event_70892_Name = {
    Text = "bộ nhớ cơ bắp"
  },
  Event_7089_ChoiceDesc1 = {
    Text = "[Kéo Kumm]"
  },
  Event_7089_ChoiceDesc2 = {
    Text = "[Tấn công thể thực nghiệm]"
  },
  Event_7089_Desc = {
    Text = "Kum cắn vào gáy một thực thể thí nghiệm, đang chuẩn bị lắc mạnh thì thực thể đột ngột quay đầu 180° như cú mèo, mổ thẳng vào mặt Kum."
  },
  Event_7089_Name = {
    Text = "Đấu trường"
  },
  Event_7090_ChoiceDesc1 = {Text = "[đi]"},
  Event_7090_Desc = {
    Text = "Bạn nắm chặt chìa khóa bạc, cảm nhận lời gọi của nguồn gốc trong dòng chảy âm u của các chiều. \n Để đối kháng với con chó địa ngục tà ác mà nguồn gốc vẫn chưa rõ ràng, bạn phải tận dụng mọi lực lượng có thể."
  },
  Event_7090_Name = {
    Text = "Ảo ảnh chiều"
  },
  Event_7091_ChoiceDesc1 = {Text = "[đi]"},
  Event_7091_Desc = {
    Text = "\"Còn về điều tra viên, Giám đốc đại nhân dự định tự mình thẩm vấn...\nGiữ lại mạng sống...\"\nGiọng nói dần yếu đi, cuối cùng biến mất trong bóng tối."
  },
  Event_7091_Name = {
    Text = "Cách tường có tai"
  },
  Event_7092_ChoiceDesc1 = {Text = "[đi]"},
  Event_7092_Desc = {
    Text = "Cảm giác mất trọng lượng khiến bạn tỉnh dậy đột ngột, mặt đất dưới chân vững chắc, còn bên cạnh chân bạn là một tấm gương vuông tinh xảo."
  },
  Event_7092_Name = {
    Text = "Gương trong gương"
  },
  Event_7093_ChoiceDesc1 = {Text = "[đi]"},
  Event_7093_Desc = {
    Text = "Bạn không bao giờ tranh luận với những kẻ đã rơi vào điên rồ, không thể cứu vãn — điều đó sẽ khiến tâm hồn bạn bị tiêu thụ hoàn toàn trong những câu hỏi của đêm khuya. Hãy tha cho bạn đi!"
  },
  Event_7093_Name = {
    Text = "Lễ hội nước"
  },
  Event_7094_ChoiceDesc1 = {Text = "[đi]"},
  Event_7094_Desc = {
    Text = "Khuôn mặt của bình tượng nến, sẽ trông như thế nào nhỉ? \n Bạn nhắm mắt lại, trong tâm trí hiện lên hàng triệu gương mặt mờ ảo. \n Chúng giống như những ngọn nến kéo theo ngọn lửa nhợt nhạt, hiện diện và biến mất trong dòng sông tối tăm... \n Bạn đi theo dòng sông đến tận cùng, nơi đó đứng một bức bình tượng nến duy nhất, cuối cùng. \n Khi lại gần nó, bạn đã thấy... @2."
  },
  Event_7094_Name = {
    Text = "Bình tượng nến chưa hoàn thành"
  },
  Event_7095_ChoiceDesc1 = {
    Text = "[Tấn công người cầm dao găm] nhiễm \"(Skill.Arg1)\", nhận được sáng tạo bị nguyền rủa \"(RelicConfig.Arg2)\""
  },
  Event_7095_ChoiceDesc2 = {
    Text = "[Người rình rập cầm dao] bị lây nhiễm hai lần \"(Skill.Arg1)\", nhận được tạo vật bạc \"(RelicConfig.Arg2)\" và \"(RelicConfig.Arg3)\""
  },
  Event_7095_ChoiceDesc3 = {
    Text = "[ Vấp ngã người cầm giáo ] nhận được bạc tạo vật [(RelicConfig.Arg1)]"
  },
  Event_7095_Desc = {
    Text = "Ba người dấn thân vào biển bám chặt lấy các bạn, ánh mắt điên cuồng và nóng bỏng gần như thiêu đốt chiếc áo choàng của bạn. \n Nhìn lại, bạn nhận thấy ba người họ có sự khác biệt - \n người dấn thân vào biển cầm dao lớn hét lên một cách điên cuồng, nhưng hành động lại có phần lơ đãng. \n Người dấn thân vào biển cầm giáo đi từng bước một, như đứa trẻ mới biết nói. \n Người dấn thân vào biển cầm dao găm đứng ở phía sau, những lời cầu nguyện lặp đi lặp lại từ miệng chứng minh sự cuồng tín của hắn."
  },
  Event_7095_Name = {
    Text = "Truy đuổi không ngừng"
  },
  Event_7096_ChoiceDesc1 = {
    Text = "[rời đi] nhận được sáng tạo \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7096_Desc = {
    Text = "Bạn nhận lấy quà tặng, cẩn thận mở ra. \n Một đôi nhãn cầu nằm yên lặng trong hộp quà. \n \"Tôi đưa đôi mắt của mình cho bạn.\"\n \"Giống như anh ấy từng làm với tôi.\""
  },
  Event_7096_Name = {
    Text = "Lễ Kết Thúc Ⅵ"
  },
  Event_7097_ChoiceDesc1 = {Text = "[đi]"},
  Event_7097_Desc = {
    Text = "Vươn tay qua trung tâm ánh sáng rực rỡ, bạn nhặt lên một giọt bạc tâm đã cố định. Giọt ký ức và linh hồn quý giá này nóng bỏng vô cùng, phản chiếu những màu sắc kỳ lạ. \n Trước khi nó làm biến dạng và khuấy động tất cả ánh sáng, cảm giác bỏng rát như lửa khiến bạn không thể không ném lại nó vào bóng tối."
  },
  Event_7097_Name = {
    Text = "Ánh sáng đêm"
  },
  Event_7098_ChoiceDesc1 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_7098_Desc = {
    Text = "Bạn từ chối quà tặng của cậu bé. \nCậu bé nhìn bạn bằng đôi mắt trống rỗng. Cậu thở dài nhẹ nhàng. \n \"Vậy thì, tạm biệt.\"\nNói xong, cậu bé đưa tay ra chào và ngã ra ngoài cửa sổ. \nCậu ấy biến mất, như một con bướm bay lượn, lại như một cơn gió."
  },
  Event_7098_Name = {
    Text = "Lễ Kết Thúc Ⅵ"
  },
  Event_7099_ChoiceDesc1 = {
    Text = "Chọn khắcăng thông thường"
  },
  Event_7100_ChoiceDesc1 = {
    Text = "[Thu tai] nhận được bạc tạo vật \"(RelicConfig.Arg1)\", bị ảnh hưởng bởi \"(Skill.Arg2)\""
  },
  Event_7100_ChoiceDesc2 = {
    Text = "[Từ chối yêu cầu] Nhận được 1 trong 3 khắcăng"
  },
  Event_7100_Desc = {
    Text = "Một chuỗi âm thanh hoa mỹ tuôn trào từ đầu ngón tay. \nNhạc sĩ piano u sầu, là một bình tượng nến, ngồi một mình trước cửa sổ. \nTừ khi có ý thức, bảo tàng sáp đã là cả thế giới của anh. \nAnh đã sống cô lập lâu dài và cũng muốn nghe những điều khác biệt, đặc biệt là... một loại nhạc gọi là jazz. \nCuối cùng, anh xé một bên tai của mình và khẩn cầu bạn mang nó đi. \n \"Hãy để tôi nghe âm nhạc bên ngoài... chỉ cần bỏ nó vào túi.\""
  },
  Event_7100_Name = {
    Text = "Dặt tai lắng nghe"
  },
  Event_7101_ChoiceDesc1 = {
    Text = "[Kết nối] trả lời Arg2 điểm sức sống.[ExDesc1]"
  },
  Event_7101_ChoiceDesc2 = {
    Text = "[Meditation] Chọn 1 thân thể được đánh thức để giác ngộ.[ExDesc1]"
  },
  Event_7101_ChoiceDesc3 = {
    Text = "[Trục xuất] Loại bỏ tối đa 3 thẻ triệu chứng, nhận Arg2 dấu đen."
  },
  Event_7101_Desc = {
    Text = "Bạn đang khám phá trong sương mù, đột nhiên, huy hiệu trường trên ngực bạn phát ra ánh sáng bạc yếu ớt. Ai đang gọi bạn từ bên kia thiết bị liên lạc?"
  },
  Event_7101_Name = {
    Text = "điểm liên lạc"
  },
  Event_7101_Tips3 = {
    Text = "Hiện tại không sở hữu thẻ triệu chứng"
  },
  Event_7102_ChoiceDesc1 = {
    Text = "[Chấp nhận thách thức]"
  },
  Event_7102_ChoiceDesc2 = {
    Text = "[  đấm vào Người  ] nhận được 25 dấu đen"
  },
  Event_7102_Desc = {
    Text = "Người hình gầy guộc từ bóng tối hiện ra, chặn đường bạn. \n Một ký ức bị ràng buộc vĩnh viễn bỗng nhiên xâm nhập vào thâm cảnh, bóng ma tự xưng là \"N\" chơi đùa với những mô hình cược trong tay, mời bạn tham gia trò chơi qua những âm thanh mơ hồ. \n Ba loại mô hình cược bày ra trước mặt bạn, nếu không chơi một ván \"trò chơi\" với Người, Người có lẽ sẽ không dễ dàng để bạn rời đi."
  },
  Event_7102_Name = {
    Text = "Buổi biểu diễn bắt đầu"
  },
  Event_7103_ChoiceDesc1 = {
    Text = "[Chèn chìa khóa bạc]"
  },
  Event_7103_Desc = {
    Text = "Trong dung dịch ăn mòn bão hòa rỗng rỗng dường như chứa một số chất… Dùng chìa khóa bạc quan sát, rồi chuyển hóa nó thành lực lượng của bạn."
  },
  Event_7103_Name = {
    Text = "Điểm tách ra"
  },
  Event_7104_ChoiceDesc1 = {
    Text = "[Vật lộn tỉnh dậy] Tăng Arg1 điểm Sinh lực tối đa"
  },
  Event_7104_ChoiceDesc2 = {
    Text = "[Buông mình vào giấc ngủ] 2 thẻ lệnh ngẫu nhiên nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm 2 thẻ \"(Skill.Arg2)\""
  },
  Event_7104_Desc = {
    Text = "Bạn ôm trong lòng một viên bảo vật sáng lấp lánh. \n Nó từ ngực bạn bám lên toàn thân, những ký ức ấm áp phát ra ánh sáng như ngọn nến cuối cùng được đổ vào đầu bạn. \n Tiếng lách tách của than hồng, ghế bành êm ái bên lò sưởi, trà nóng đậm đà và cái bụng mèo cuộn tròn bên chân bạn… \n Trong cơn buồn ngủ thoải mái này, đầu óc bạn trở nên mơ hồ, rơi vào một không gian mềm mại."
  },
  Event_7104_Name = {
    Text = "Chìm đắm trong những ngày xưa"
  },
  Event_7105_ChoiceDesc1 = {Text = "[đi]"},
  Event_7105_Desc = {
    Text = "Bạn không thương tiếc kéo ra nửa cuộn phim còn lại, chúng ẩn nấp trong bụng máy ảnh, đột ngột bị kéo ra, nhưng hình ảnh trên đó khiến bạn không nói nên lời. \n Cuộn phim chưa được rửa, trung thực ghi lại — hình ảnh bạn ngã xuống một vũng bùn đen."
  },
  Event_7105_Name = {
    Text = "Bản ghi vô tội"
  },
  Event_7106_ChoiceDesc1 = {Text = "[đi]"},
  Event_7106_Desc = {
    Text = "Bạn đã kiểm tra kỹ lưỡng chiếc máy ảnh, da thuộc và viền vàng đen được tích hợp vào thân máy, phản chiếu ra vài tia sáng bóng. \nThấu kính của nó hướng về bạn, giống như đang chăm chú quan sát, lặng lẽ dò xét…"
  },
  Event_7106_Name = {
    Text = "Bản ghi vô tội"
  },
  Event_7107_ChoiceDesc1 = {Text = "[đi]"},
  Event_7107_Desc = {
    Text = "Nắm ánh trăng trong lòng bàn tay, được rải xuống bia đá. \n Có người bị chôn vùi dưới lớp bùn dày, đám đông bên cạnh tuyên bố rằng người này đã đến lúc tự nhiên tàn lụi, sẽ yên giấc dưới lòng đất. \n Nhưng lớp bùn chôn vùi lại sóng động, từ tiếng thét đau thương, một khối ánh trăng mềm nhũn bò ra."
  },
  Event_7107_Name = {
    Text = "Phân mảnh Bạc Nguyệt"
  },
  Event_7108_ChoiceDesc1 = {Text = "[đi]"},
  Event_7108_Desc = {
    Text = "Bạn nhẹ nhàng chạm vào cánh bướm mỏng màu đen, bướm rung cánh nhẹ nhàng, sau đó hóa thành những giọt lỏng đen kịt, rơi vào lòng bàn tay bạn."
  },
  Event_7108_Name = {
    Text = "Điều không nên tồn tại"
  },
  Event_7109_ChoiceDesc1 = {Text = "[đi]"},
  Event_7109_Desc = {
    Text = "Mặt trăng cô đơn treo cao trên trời, nhưng bạn vẫn có thể nghe rõ lời cầu nguyện của nó, âm điệu kỳ lạ, giống như tiếng thì thầm của những vật bẩn thỉu. \n Lời cầu nguyện ngừng lại, bạn định rời đi. Nhưng phía sau bỗng hiện lên một bóng trắng mờ ảo. \n \"Kẻ xâm phạm số phận và lời cầu nguyện, ân huệ và giá phải trả sẽ đến đúng hẹn.\""
  },
  Event_7109_Name = {
    Text = "Phân mảnh Bạc Nguyệt"
  },
  Event_7110_ChoiceDesc1 = {
    Text = "[ba điểm]"
  },
  Event_7110_ChoiceDesc2 = {
    Text = "[sáu giờ]"
  },
  Event_7110_ChoiceDesc3 = {
    Text = "[một điểm]"
  },
  Event_7110_Desc = {
    Text = "Xem ra may mắn của bạn hôm nay không tồi. \nXúc xắc rung động, phát ra tiếng ong ong hưng phấn. \nBạn quyết định đoán một số điểm"
  },
  Event_7110_Name = {
    Text = "Cuộc cờ bạc vô tận"
  },
  Event_7111_ChoiceDesc1 = {Text = "[đi]"},
  Event_7111_Desc = {
    Text = "Cuộc cờ bạc này là một trò lừa đảo lớn! \n Bạn đứng bật dậy, nhưng cảm thấy một cơn chóng mặt. \n Các viên xúc xắc phát ra tiếng vo ve ồn ào, những âm thanh đầy mê hoặc không ngừng vang vọng trong đầu bạn: \n 「Chỉ một lần… lần cuối cùng…」"
  },
  Event_7111_Name = {
    Text = "Cuộc cờ bạc vô tận"
  },
  Event_7112_ChoiceDesc1 = {
    Text = "[sử dụng bạc tâm] nâng cấp 1 bạc tạo vật thành vật tạo vàng[(RelicConfig.Arg1)]"
  },
  Event_7112_ChoiceDesc2 = {
    Text = "[thu hồi bạc tâm] nhận được vật tạo vàng \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\" và \"(Skill.Arg3)\""
  },
  Event_7112_ChoiceDesc3 = {
    Text = "[đặt lại vào ngăn kéo] nhận 25 dấu đen"
  },
  Event_7112_Desc = {
    Text = "Trong ngăn kéo thứ hai bên phải bàn làm việc, một viên bạc tâm đã được tạo hình cô đơn nằm đó. Khi bạn nhẹ nhàng chạm vào, bạn nghe thấy tiếng rít của cơn bão, hòa quyện với âm thanh vỡ vụn của những hạt tuyết, cùng với tiếng sáo rên rỉ……"
  },
  Event_7112_Name = {
    Text = "bạc tâm cô đơn"
  },
  Event_7113_ChoiceDesc1 = {
    Text = "[Lắng nghe kỹ] nhiễm \"(Skill.Arg1)\", nhận được vật bị nguyền rủa-\"(RelicConfig.Arg2)\""
  },
  Event_7113_ChoiceDesc2 = {
    Text = "[Make a Change] chọn hủy bỏ 1 sáng tạo, nhận được 1 phần thưởng"
  },
  Event_7113_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 50 dấu đen"
  },
  Event_7113_Desc = {
    Text = "Không phải tất cả các bản nhạc đều cảm động. \n Những âm thanh không hòa hợp tạo nên một tiếng khóc bi thương."
  },
  Event_7113_Name = {
    Text = "âm không hòa"
  },
  Event_7114_ChoiceDesc1 = {
    Text = "[Nhặt nó lên] bị nhiễm \"(Skill.Arg1)\", nhận được bạc tạo vật \"(RelicConfig.Arg2)\""
  },
  Event_7114_ChoiceDesc2 = {
    Text = "[bỏ qua nó] nhận được 25 dấu đen."
  },
  Event_7114_Desc = {
    Text = "Ở góc khuất của đống cỏ thối, trong những vết rạn của dấu rỗng rỗng, lặng lẽ nằm đó một thứ gì đó."
  },
  Event_7114_Name = {
    Text = "sau đống cỏ"
  },
  Event_7115_ChoiceDesc1 = {Text = "[đi]"},
  Event_7115_Desc = {
    Text = "Hình bóng đó không tiến lại gần hơn, Người ngắm nhìn bạn một lúc rồi biến thành một vốc cát bạc."
  },
  Event_7115_Name = {
    Text = "Người sử dụng chìa khóa bạc"
  },
  Event_7116_ChoiceDesc1 = {
    Text = "[nắm lấy xúc tu] chấp nhận sự giúp đỡ của tulô"
  },
  Event_7116_Desc = {
    Text = "Một tiếng thở dài, tulô đuổi theo. \nChiếc xúc tu nặng nề, lạnh lẽo bám lấy bạn, dập tắt ý định đáng sợ muốn lao thẳng vào trận địch một mình. \n \"Tôi sẽ trở thành sự hỗ trợ của bạn, chỉ trong lúc này.\""
  },
  Event_7116_Name = {
    Text = "Lời Hứa của Đại Lý"
  },
  Event_7117_ChoiceDesc1 = {
    Text = "[nhận chìa khóa]"
  },
  Event_7117_Desc = {
    Text = "1,2,3……\nJenkin và khoảng cách tới bàn có 10 feet. \nĐây là một khoảng cách rất ngắn, nhưng lại dài như cả cuộc đời của cô. \nCô nhớ đến dải ruy-băng mềm mại, nhớ đến giấy kẹo vàng óng, cũng nhớ đến nước mắt của mẹ. \nCô còn nghĩ đến rất nhiều, rất nhiều……\nThân thể gầy yếu lướt qua dòng sông đen, từng chút từng chút tiến gần tới bàn. \nChìa khóa nằm trong ngăn kéo, để có được nó cần phải trả giá rất đơn giản: can đảm, khéo léo, cộng thêm một chút may mắn. \nNgoài may mắn, Jenkin không thiếu thứ gì."
  },
  Event_7117_Name = {
    Text = "Chìa khóa cuối cùng"
  },
  Event_7118_ChoiceDesc1 = {Text = "[đi]"},
  Event_7118_Desc = {
    Text = "Chỉ là một ván cờ bạc, bạn sẽ không thua đâu. \nĐồng xu khắc hoa văn được ném lên cao, rồi nhanh chóng rơi xuống, được lòng bàn tay bạn làm ấm lên."
  },
  Event_7118_Name = {
    Text = "Người chơi bạc nổi tiếng"
  },
  Event_7119_ChoiceDesc1 = {Text = "[đi]"},
  Event_7119_Desc = {
    Text = "Chỉ là một ván cờ bạc, bạn sẽ không thua đâu. \nĐồng xu khắc hoa văn được ném lên cao, rồi nhanh chóng rơi xuống, được lòng bàn tay bạn làm ấm lên."
  },
  Event_7119_Name = {
    Text = "Người chơi bạc nổi tiếng"
  },
  Event_7120_ChoiceDesc1 = {Text = "[đi]"},
  Event_7120_Desc = {
    Text = "Chỉ là một ván cờ bạc, bạn sẽ không thua đâu. \nĐồng xu khắc hoa văn được ném lên cao, rồi nhanh chóng rơi xuống, được lòng bàn tay bạn làm ấm lên."
  },
  Event_7120_Name = {
    Text = "Người chơi bạc nổi tiếng"
  },
  Event_7121_ChoiceDesc1 = {Text = "[đi]"},
  Event_7121_Desc = {
    Text = "Bạn vô tình tham gia vào lớp học piano nghiêm túc này. \n Mỗi khi hoàn thành một ô nhạc, học sinh đều cố gắng xoay đầu, thể hiện vẻ mặt lắng nghe. \n Còn thầy giáo của cậu cũng hơi cúi người, môi mấp máy, đôi mắt tròn nhìn vào bản nhạc không hề tồn tại. \n Họ rõ ràng không biết mình đang làm gì, và sẽ mãi mãi không hiểu tại sao con người lại dành hàng năm trời để thực hiện những bài tập máy móc như vậy. \n Họ chỉ đang bắt chước mà thôi."
  },
  Event_7121_Name = {
    Text = "Bài học piano"
  },
  Event_7122_ChoiceDesc1 = {
    Text = "[Chèn chìa khóa bạc]"
  },
  Event_7122_Desc = {
    Text = "Trong dung dịch ăn mòn bão hòa rỗng rỗng dường như chứa một số chất… Dùng chìa khóa bạc quan sát, rồi chuyển hóa nó thành lực lượng của bạn."
  },
  Event_7122_Name = {
    Text = "Điểm tách ra"
  },
  Event_7123_ChoiceDesc1 = {
    Text = "[Nhận diện lời bài hát] nhận được bạc tạo vật \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7123_ChoiceDesc2 = {
    Text = "[hát khẽ] Chọn 1 trong 3 khắcăng"
  },
  Event_7123_Desc = {
    Text = "Bài hát cổ xưa của con tàu vang vọng trong thâm cảnh. \nNhững ký ức bị mắc kẹt trong thâm cảnh dùng ngôn ngữ bạn chưa từng nghe, hát lên về sóng biển, bầu trời và rượu cay nồng."
  },
  Event_7123_Name = {
    Text = "Bài hát biển cả"
  },
  Event_7124_ChoiceDesc1 = {
    Text = "[Gọi quạ] nhận được 20 dấu đen và bị nhiễm [(Skill.Arg2)]"
  },
  Event_7124_ChoiceDesc2 = {Text = "[xa cách]"},
  Event_7124_Desc = {
    Text = "Chim đen tuyền chăm chú nhìn bạn, sau một lúc lâu, có thứ gì đó rơi ra từ lông của chúng…"
  },
  Event_7124_Name = {
    Text = "Quạ Cô Độc"
  },
  Event_7125_ChoiceDesc1 = {
    Text = "[Lên trước và nắm lấy] được 25 dấu đen"
  },
  Event_7125_ChoiceDesc2 = {
    Text = "[Phản hồi hữu hảo]50% cơ hội nhận được 50 dấu đen, 50% cơ hội không có gì cả"
  },
  Event_7125_Desc = {
    Text = "Một con mèo không biết từ đâu xuất hiện ngồi giữa dung dịch ăn mòn, thân hình mờ ảo cho thấy nó chắc chắn là cư dân của chiều tinh thần. \n Bóng hình không thể nhìn rõ mặt này dùng ánh mắt thông minh nhìn về phía Ramona, nó nâng đôi chân trước trắng muốt, ra hiệu như đang vẫy tay với cô."
  },
  Event_7125_Name = {
    Text = "Cư dân du mục"
  },
  Event_7126_ChoiceDesc1 = {
    Text = "[Chạy điên cuồng về phía Bắc]"
  },
  Event_7126_ChoiceDesc2 = {
    Text = "[bỏ qua âm thanh]"
  },
  Event_7126_Desc = {
    Text = "Đòn tấn công của kẻ thù như mưa rào rơi xuống sau lưng, lưỡi dao vài lần trượt qua áo choàng, làm kinh động một đàn hải âu đang đậu ở bến tàu. \n \"Hướng bắc... hoặc lên tàu...\"\nNgay cả người ngốc nhất cũng có thể nhận ra rằng có một lực lượng nào đó đang âm thầm giúp đỡ bạn."
  },
  Event_7126_Name = {
    Text = "Đi về phía bắc"
  },
  Event_7127_ChoiceDesc1 = {
    Text = "[Lắng nghe Mặt Trời] nhận được sáng tạo [(RelicConfig.Arg1)]"
  },
  Event_7127_ChoiceDesc2 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_7127_Desc = {
    Text = "Trong sự giao thoa giữa thực tại và ảo tưởng, các thiên thể quay quanh theo quỹ đạo đã định mãi mãi. \nVô số lần lướt qua nhau, tạo ra những bản nhạc kỳ quái và xảo trá…"
  },
  Event_7127_Name = {
    Text = "Âm thanh của sao và mặt trăng"
  },
  Event_7128_ChoiceDesc1 = {
    Text = "[Theo nỗi buồn ra đi] sao chép thẻ bài, nếu sao chép thẻ triệu chứng, nhận được 75 dấu đen"
  },
  Event_7128_ChoiceDesc2 = {
    Text = "[Ra đi cùng cơn giận dữ] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: [(EnchantConfig.Arg1)]"
  },
  Event_7128_Desc = {
    Text = "Dung dịch phun ra từ con ngươi, lạnh buốt và mạnh mẽ cuốn đi một phần linh hồn."
  },
  Event_7128_Name = {
    Text = "Nước mắt của Bờ Biển Bóng Ma"
  },
  Event_7129_ChoiceDesc1 = {
    Text = "[Đi sâu vào hành lang]"
  },
  Event_7129_ChoiceDesc2 = {
    Text = "[đi ngược hướng] nhận được 25 dấu đen"
  },
  Event_7129_Desc = {
    Text = "Ánh trăng nhợt nhạt bỏ qua sự chuyển động của thời gian, đổ xuống hành lang yên tĩnh. \nCửa hang dưới ánh trăng tỏa ra ánh sáng kỳ quái."
  },
  Event_7129_Name = {
    Text = "Hành lang yên tĩnh"
  },
  Event_7130_ChoiceDesc1 = {Text = "[đi]"},
  Event_7130_Desc = {
    Text = "Bạn quyết định sửa chữa bức bình tượng nến này. \n Gần bức bình tượng nến có một vài công cụ rơi rớt, bạn chọn một loại thuốc nhuộm có tên là \"Xanh Phổ\". \n Màu xanh của nó giống như dấu hiệu của một căn bệnh."
  },
  Event_7130_Name = {
    Text = "Bình tượng nến chưa hoàn thành"
  },
  Event_7131_ChoiceDesc1 = {Text = "[đi]"},
  Event_7131_Desc = {
    Text = "Mụn mủ phát ra một tiếng hét chói tai và rùng rợn, kèm theo âm thanh gió hú không nên tồn tại phía sau tai, tiếng sáo ảo giác và tiếng rít của mủ sôi nổi vang lên như một điều cấm kỵ.\nMụn mủ co giật kỳ quái trong chốc lát, sau đó cứng đờ rơi vào trạng thái chết lặng. Chứng kiến cảnh này, thực thể tỉnh thức bên cạnh bạn dường như đã nhận được một sự khơi dậy nào đó."
  },
  Event_7131_Name = {
    Text = "Pustula kỳ quái"
  },
  Event_7132_ChoiceDesc1 = {Text = "[đi]"},
  Event_7132_Desc = {
    Text = "Ngón tay của bạn chạm vào bức tượng, thỉnh thoảng cảm nhận được những vết lõm mềm mại bất ngờ, bạn luôn nghĩ rằng đó là ảo giác."
  },
  Event_7132_Name = {
    Text = "Lắp ráp tàn dư"
  },
  Event_7133_ChoiceDesc1 = {
    Text = "[Khóc vì cô ấy]"
  },
  Event_7133_ChoiceDesc2 = {
    Text = "[Hãy cầu nguyện cho cô ấy]"
  },
  Event_7133_Desc = {
    Text = "Khoảnh khắc cơ thể chạm vào lan can tàu, những ký ức không thuộc về mình tràn vào tâm trí. \nMọi người đã thay cho cô chiếc váy trắng thánh thiện, trang trí cô bằng những viên ngọc quý tinh tế và thanh lịch, mọi người đã đặt cô lên một cái bàn thờ cao, cư dân thị trấn quỳ gối dưới chân. \nĐó là những đôi mắt tràn đầy hy vọng: các thủy thủ mong cô có thể che chở cho chuyến đi, ngư dân mong đợi một mùa đánh cá êm ả, còn nhiều cư dân khác mong muốn có một năm suôn sẻ. \nTrong đám người quỳ lạy, có bạn bè thời thơ ấu của cô, cũng có cha mẹ và anh chị em luôn bên cô. \nCô không muốn gì cả, cô không biết mình muốn gì. \nPhản hồi thụ động những ước nguyện, như thể đó là trách nhiệm duy nhất trong cuộc đời cô."
  },
  Event_7133_Name = {
    Text = "Lễ nghi trước chuyến bay"
  },
  Event_7134_ChoiceDesc1 = {Text = "[đi]"},
  Event_7134_Desc = {
    Text = "Thân thể tàn khuyết với đôi đồng tử trắng bệch từ từ chuyển động, nhìn theo bóng dáng bạn rời đi, và nở một nụ cười thảm đạm."
  },
  Event_7134_Name = {
    Text = "Lắp ráp tàn dư"
  },
  Event_7135_ChoiceDesc1 = {
    Text = "[Chủ động đón chiến] nhận được vật bị nguyền rủa \"(RelicConfig.Arg1)\", nhiễm phải \"(Skill.Arg2)\""
  },
  Event_7135_ChoiceDesc2 = {
    Text = "[Từ bỏ kháng cự] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: [(EnchantConfig.Arg1)]"
  },
  Event_7135_ChoiceDesc3 = {
    Text = "[Nhanh chân chạy thoát] nhận được 50 dấu đen"
  },
  Event_7135_Desc = {
    Text = "Mấy bình tượng nến thô sơ chặn đường bạn. \n Chúng méo mó, khuôn mặt thô ráp, trông không giống như tác phẩm mà Rogers thường làm. \n \"Lệnh... lệnh của người lớn...\""
  },
  Event_7135_Name = {Text = "bài tập"},
  Event_7136_ChoiceDesc1 = {Text = "[đi]"},
  Event_7136_Desc = {
    Text = "Bạn chọn dũng cảm đối mặt với đôi mắt. \nChúng là sao mai lấp lánh, tỏa sáng trong bóng tối. \nSau đó chúng mỉm cười, biến thành hàng ngàn vầng trăng cong cong. \n \"Bạn không sợ hãi ánh mắt. Bạn cũng không nên sợ hãi... \nLâu rồi không gặp, @2\"\nTrước khi biến mất, chúng tặng bạn một món quà nhỏ, như một \"kỷ niệm tái ngộ\"."
  },
  Event_7136_Name = {Text = "mắt"},
  Event_7137_ChoiceDesc1 = {
    Text = "[bật công tắc] mở rộng tầm nhìn hiện tại [ExDesc1]."
  },
  Event_7137_Desc = {
    Text = "Đèn chiếu sáng được để lại bởi những người đi trước, có thể xua tan sương mù đen bao quanh. \nSương mù xung quanh nó dao động đều đặn, như thể hơi thở của nó làm xao động."
  },
  Event_7137_Name = {Text = "đèn pha"},
  Event_7138_ChoiceDesc1 = {Text = "[đi]"},
  Event_7138_Desc = {
    Text = "Bạn mở rộng đôi cánh trong suốt ở lưng, quay cuồng liên tục, cùng với đàn quạ chìm vào đáy biển yên tĩnh."
  },
  Event_7138_Name = {
    Text = "Giọng của đàn quạ"
  },
  Event_7139_ChoiceDesc1 = {
    Text = "[tiêu diệt nó] nhận được[lõi biến dị]"
  },
  Event_7139_Desc = {
    Text = "Những bọng mủ méo mó bị bỏ rơi bên đường bởi ai đó không rõ, bề mặt lấp lánh ánh sáng xanh bẩn thỉu, lúc này đang biến hình và ngọ nguậy một cách bồn chồn. \n So với quái vật, nó giống như một cây kem trần trụi đang chịu đựng cái nóng của mặt trời, sắp sửa tan chảy thành một vũng nước đục đặc, rồi biến mất trong không khí."
  },
  Event_7139_Name = {
    Text = "Pustula kỳ quái"
  },
  Event_7140_ChoiceDesc1 = {
    Text = "[thả tay đang bịt tai] bị nhiễm [(Skill.Arg1)], chọn nhận một phần thưởng"
  },
  Event_7140_ChoiceDesc2 = {
    Text = "[Bắt được một con quạ] nhận được [(Skill.Arg1)], chọn nhận một phần thưởng"
  },
  Event_7140_ChoiceDesc3 = {
    Text = "[đóng mắt lại] nhận được 50 dấu đen"
  },
  Event_7140_Desc = {
    Text = "Tiếng hét chói tai, tiếng hét chói tai không có điểm dừng——\nCa sĩ quạ khoác lên mình bộ lông đen bóng, mỏ nhọn phát ra ánh sáng lạnh lẽo, tiếng kêu thê thảm vang lên một lần nữa xé toạc màng nhĩ của bạn.\nHãy bỏ tay bạn ra khỏi tai đi!\nBầy quạ đang hát hò trong đêm, muốn tận hưởng sự run rẩy chưa được tôi luyện trong cơ thể co ro của bạn.\n"
  },
  Event_7140_Name = {
    Text = "Bài hát của đàn quạ"
  },
  Event_7141_ChoiceDesc1 = {
    Text = "[Rời đi] không có bất kỳ phát hiện nào"
  },
  Event_7141_Desc = {
    Text = "Không phải người bạn đang tìm kiếm"
  },
  Event_7141_Name = {
    Text = "2_6_tạm thời"
  },
  Event_7142_ChoiceDesc1 = {Text = "[đi]"},
  Event_7142_Desc = {
    Text = "Bạn chọn tiếp tục tiến lên. \n So với những tổn thương tinh thần và thể chất mà những tác phẩm bình tượng nến tồi tệ đó gây ra cho bạn, những phiền toái nhỏ bé này thực sự chẳng đáng là gì. \n Bạn còn những sự nghiệp vĩ đại hơn để hoàn thành."
  },
  Event_7142_Name = {
    Text = "bước chân"
  },
  Event_7143_ChoiceDesc1 = {
    Text = "[chỉ ra vấn đề] Chọn 1 trong 3 thẻ lệnh để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_7143_Desc = {
    Text = "\"Làm gì vậy! Có thích đâm vào nỗi đau của người khác thế hả!\"\n \"Đúng rồi! Bây giờ tôi bỗng dưng già đi hai mươi lăm tuổi! Hiện tại cậu phải gọi tôi là chị Mofi!\""
  },
  Event_7143_Name = {
    Text = "Sống bị giam cầm"
  },
  Event_7144_ChoiceDesc1 = {
    Text = "[rời đi] nhận được 3 chọn 1 vật phẩm bạc, nhiễm phải 「(Skill.Arg1)」"
  },
  Event_7144_Desc = {
    Text = "Gương mặt của cô gái trầm tĩnh như ánh trăng đêm nay, cô không đáp lại bạn, nhưng đã giơ cao chiếc la bàn trong tay—— cô đang run rẩy, việc giơ cao chiếc la bàn nhỏ bé dường như đã dùng hết sức sống của cô."
  },
  Event_7144_Name = {
    Text = "Gái mặc váy trắng"
  },
  Event_7145_ChoiceDesc1 = {Text = "[đi]"},
  Event_7145_Desc = {
    Text = "\"Ngon! Ngon!\" Con quạ cười méo mó, mùi hôi thối lan tới mũi bạn khi nó dang rộng đôi cánh."
  },
  Event_7145_Name = {
    Text = "Quạ Nguyền Rủa"
  },
  Event_7146_ChoiceDesc1 = {Text = "[đi]"},
  Event_7146_Desc = {
    Text = "Theo tôi, tiếng ồn chắc chắn là hình mẫu của thế hệ mới. \n Chúng kiên định bước đi theo nhịp điệu hỗn loạn và giai điệu khiến người ta sụp đổ, hoành hành trên thế giới. \n Không có lòng thương xót, không có sự dao động, cũng không có sự thỏa hiệp. \n Ghét bỏ quy tắc, loại bỏ chủ đề, tiếng ồn không bao giờ làm hài lòng người khác —— \n tất nhiên, trong đó cũng bao gồm cả người thợ làm tượng nến của chúng ta."
  },
  Event_7146_Name = {
    Text = "khẩu vị kém"
  },
  Event_7147_ChoiceDesc1 = {
    Text = "[dẫn đường]"
  },
  Event_7147_ChoiceDesc2 = {Text = "[đi]"},
  Event_7147_Desc = {
    Text = "Có người đang nhẹ nhàng kéo góc áo của bạn. \nĐó là cậu bé mà bạn vừa gặp. Cậu ấy ngồi xổm ở góc, buồn bã nhìn bạn. \n \"Tôi muốn diễn trong buổi biểu diễn của trường. \nNhưng tôi không tìm thấy đường đến sân khấu.\""
  },
  Event_7147_Name = {
    Text = "Lễ Kết Thúc Ⅱ"
  },
  Event_7148_ChoiceDesc1 = {
    Text = "[tiếp tục tìm kiếm] tăng Arg1 điểm sức sống, bị nhiễm [(Skill.Arg2)]"
  },
  Event_7148_ChoiceDesc2 = {Text = "[đi]"},
  Event_7148_Desc = {
    Text = "Mũi ngửi thấy mùi quen thuộc, thân thuộc và khiến người ta thỏa mãn, khi bạn muốn hít thêm hương thơm của căn tin, thì mùi hương đó đã tan biến hoàn toàn."
  },
  Event_7148_Name = {
    Text = "Liên lạc bất thường"
  },
  Event_7149_ChoiceDesc1 = {Text = "[đi]"},
  Event_7149_Desc = {
    Text = "Chúng là những gam màu ấm áp.\nNồng nhiệt, dịu dàng, yêu thương.\nChúng đã dành cho cô gái một cái ôm đáng nhớ, rồi biến mất như gió."
  },
  Event_7149_Name = {
    Text = "Màu sắc hoài niệm"
  },
  Event_7150_ChoiceDesc1 = {
    Text = "[bạn rốt cuộc là ai?]"
  },
  Event_7150_ChoiceDesc2 = {
    Text = "[Làm thế nào để thay đổi tư duy?]"
  },
  Event_7150_Desc = {
    Text = "Người đàn ông tóc dài lại chặn đường các người. Sau trải nghiệm lần trước, Ramona có vẻ mặt không vui. \n \"Hãy bình tĩnh, bạn của tôi.\" Người đàn ông từ từ mở miệng, giọng nói của anh ta từ tính và quyến rũ, cách phát âm giống như hơi thở đi qua đường hô hấp hẹp, kèm theo tiếng xì xào. \n \"Tôi đã quan sát một thời gian rồi, thay đổi cách suy nghĩ mới có thể giúp bạn tiếp cận mục tiêu.\""
  },
  Event_7150_Name = {
    Text = "Khách lữ kỳ quái Ⅲ"
  },
  Event_7151_ChoiceDesc1 = {
    Text = "[Tôi đang tìm kiếm] Tăng Arg1 điểm Sinh lực tối đa"
  },
  Event_7151_ChoiceDesc2 = {
    Text = "[Tôi đang né tránh] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7151_Desc = {
    Text = "\"Tôi thấy có người đang tìm kiếm, tìm kiếm thứ không thể với tới, thứ đối lập đau thương, thứ được gọi là sự thật. \nTôi thấy có người đang tránh né, tránh né thứ không thể trốn tránh, thứ bị che giấu khắc nghiệt, đó chính là sự thật. \nBạn thuộc nhóm nào?\""
  },
  Event_7151_Name = {
    Text = "Đối tượng truy đuổi"
  },
  Event_7152_ChoiceDesc1 = {
    Text = "[cẩn thận xem xét]sẽ nâng cấp 1 bạc sáng tạo thành sáng tạo vàng「(RelicConfig.Arg1)」"
  },
  Event_7152_ChoiceDesc2 = {
    Text = "[Cố gắng lắng nghe] nhận được vật tạo vàng \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\" và \"(Skill.Arg3)\""
  },
  Event_7152_ChoiceDesc3 = {
    Text = "[Cẩn thận giữ kỹ] nhận được 25 dấu đen"
  },
  Event_7152_Desc = {
    Text = "Sương mù phía trước được chiếu sáng bởi một vật nhỏ, trông giống như những phân mảnh thủy tinh hoặc tinh thể, bên trong chứa đựng vô số màu sắc nổi bật hoặc mờ nhạt."
  },
  Event_7152_Name = {
    Text = "Kí ức của chúng tôi"
  },
  Event_7153_ChoiceDesc1 = {
    Text = "[Nhận thách thức] Thắng cuộc nhận được bạc sáng tạo, thua cuộc nhận được triệu chứng. Dù thắng hay thua, kết quả đều không ảnh hưởng đến cuộc điều tra sau này."
  },
  Event_7153_ChoiceDesc2 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_7153_Desc = {
    Text = "Người trong bóng phản chiếu là ai? \n Ngài có hơi thở đồng bộ với bạn, nhịp tim cùng tần số, chia sẻ cùng một ý tưởng quái gở. \n Có phải là trò đùa của thâm cảnh, hay là bóng dáng vượt qua chiều không gian? \n Dường như đây là một lời mời thách thức hư ảo?"
  },
  Event_7153_Name = {
    Text = "Cộng hưởng linh hồn"
  },
  Event_7154_ChoiceDesc1 = {Text = "[đi]"},
  Event_7154_Desc = {
    Text = "Trường nhìn vượt qua lịch sử và thời gian, có thể nó là không tuyến tính, có thể nó đang nhìn xuống bạn từ hỗn loạn trước khi hành tinh được sinh ra. \nHoặc có lẽ, nó đang chờ đợi bạn vào một ngày nào đó trong tương lai."
  },
  Event_7154_Name = {Text = "Nhìn lén"},
  Event_7155_ChoiceDesc1 = {
    Text = "[Lấy]nhận được 50 dấu đen"
  },
  Event_7155_Desc = {
    Text = "Đó là nơi không có gì cả, chất lỏng đen ngòm chảy lan trên mặt đất, không phản chiếu được bất cứ điều gì. \n Có phải ảo giác của bạn không? Bạn ngỡ như có điều gì vừa tuột khỏi kẽ tay."
  },
  Event_7155_Name = {
    Text = "Dưới bề mặt gương"
  },
  Event_7156_ChoiceDesc1 = {Text = "[đi]"},
  Event_7156_Desc = {
    Text = "\"Quý vị thật là một người tốt bụng, chúc quý vị hôm nay, ngày mai, ngày kia đều như ý.\"\n \"Nhân tiện, đây là giao dịch một lần duy nhất...\"\nCô tiên hài lòng phát ra tiếng xuýt xoa, không nỡ từ biệt quý vị."
  },
  Event_7156_Name = {
    Text = "Phúc lành của Tiên nữ"
  },
  Event_7157_ChoiceDesc1 = {
    Text = "[Trả ví lại cho tôi!] Nhận được 1 trong 3 khắcăng"
  },
  Event_7157_ChoiceDesc2 = {
    Text = "[Do dự] 1 thẻ lệnh ngẫu nhiên nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7157_Desc = {
    Text = "\"Đến đây, lấy lại ví của cậu đi!\"Đứa trẻ ở xa vẫy tay. \nCậu lao về phía trước, trong khoảnh khắc duỗi tay ra, một tiếng ồn lớn và hỗn loạn vang lên trong đầu. \n \"Thằng nhóc bẩn thỉu này từ đâu tới đây!\"\n \"Là con chuột đường phố, dám chạm vào váy của phu nhân công tước!\"\n \"Nhanh đuổi nó ra ngoài!\"\n \"Cậu có mang theo đồng xu nào không? Không có đồng xu thì đừng mong lấy được một cái bánh mì đen!\""
  },
  Event_7157_Name = {
    Text = "Sách của Không"
  },
  Event_7158_ChoiceDesc1 = {
    Text = "[Theo đuổi giai điệu] Chọn 1 thẻ lệnh từ 3 thẻ để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_7158_ChoiceDesc2 = {
    Text = "[Thanh theo ca khúc] nhiễm [(Skill.Arg1)], khắcăng lại, tối đa thực hiện 2 lần"
  },
  Event_7158_Desc = {
    Text = "Tiếng hát xa xôi bị vỡ thành vài mảnh sao rơi: \n \"Tôi nguyền rủa vũng nước bẩn trong con hẻm tối, nơi gốc tường sụp đổ điểm xuyết những bông hoa thối rữa, xiềng xích quấn lấy não bộ rồi kéo xuống bùn lầy. Trước khi sương mù xóa sạch sự tồn tại của tôi, hoàng hôn sẽ chìm vào @2 sâu thẳm nhất.\""
  },
  Event_7158_Name = {
    Text = "Lời nguyền chất trắng"
  },
  Event_7159_ChoiceDesc1 = {
    Text = "[Để lại cúng bái] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7159_ChoiceDesc2 = {
    Text = "[Đưa Ngài rời đi] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7159_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_7159_Desc = {
    Text = "Khi bạn đến gần, những linh hồn hỗn loạn vô định bỗng nhiên xuất hiện từ bùn lầy. \nCánh tay màu đen bị cuốn vào chặt lấy bạn, Người ấy khóc lóc, cầu xin——\ndâng lên lễ vật, hoặc mang Người ấy đi."
  },
  Event_7159_Name = {
    Text = "Lin hồn hỗn loạn"
  },
  Event_7160_ChoiceDesc1 = {
    Text = "[để lại cúng dường] ngẫu nhiên nâng cấp chất lượng khắcăng của 1 thẻ bài"
  },
  Event_7160_ChoiceDesc2 = {
    Text = "[Mang nó đi] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7160_Desc = {
    Text = "Khi bạn đến gần, những linh hồn hỗn loạn vô định bỗng nhiên xuất hiện từ bùn lầy. \nCánh tay màu đen bị cuốn vào chặt lấy bạn, Người ấy khóc lóc, cầu xin——\ndâng lên lễ vật, hoặc mang Người ấy đi."
  },
  Event_7160_Name = {
    Text = "Lin hồn hỗn loạn"
  },
  Event_7161_ChoiceDesc1 = {
    Text = "[Vẫy tay xua đuổi] 1 thẻ lệnh ngẫu nhiên nhận được Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7161_ChoiceDesc2 = {
    Text = "[Tự do dừng lại] Chọn 1 thẻ lệnh từ 3 thẻ lệnh để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_7161_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_7161_Desc = {
    Text = "Con bướm vỗ cánh, mang theo chất lỏng đen sền sệt, bay lượn lên xuống. Những lớp chất lỏng đen đặc tuôn ra từ cánh, sau khi đông cứng thì bị gió làm bong tróc. \nNó mệt mỏi sau khi bay và đậu trên chóp mũi của bạn."
  },
  Event_7161_Name = {
    Text = "Bướm Dung Dịch Đen"
  },
  Event_7162_ChoiceDesc1 = {
    Text = "[Vẫy tay xua đuổi] Chọn 1 trong 3 thẻ lệnh nhận được Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7162_ChoiceDesc2 = {
    Text = "[Tự do dừng lại] nhận được bạc sáng tạo \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7162_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_7162_Desc = {
    Text = "Con bướm vỗ cánh, mang theo chất lỏng đen sền sệt, bay lượn lên xuống. Những lớp chất lỏng đen đặc tuôn ra từ cánh, sau khi đông cứng thì bị gió làm bong tróc. \nNó mệt mỏi sau khi bay và đậu trên chóp mũi của bạn."
  },
  Event_7162_Name = {
    Text = "Bướm Dung Dịch Đen"
  },
  Event_7163_ChoiceDesc1 = {Text = "[đi]"},
  Event_7163_Desc = {
    Text = "\"Tôi thấy lòng dũng cảm, thấy ý chí, thấy tinh thần rực rỡ như ngôi sao. Tiến về phía ký ức được niêm phong bằng sáp, chắc chắn bạn sẽ đạt được điều mình mong muốn.\""
  },
  Event_7163_Name = {
    Text = "Đối tượng truy đuổi"
  },
  Event_7164_ChoiceDesc1 = {
    Text = "[Mặc kệ nó ở lại] Chọn 1 trong 3 thẻ lệnh nhận được Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7164_ChoiceDesc2 = {
    Text = "[Vẫy tay xua đuổi] nhận được bạc tạo vật \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7164_ChoiceDesc3 = {
    Text = "[đón bướm] nhận được 25 dấu đen"
  },
  Event_7164_Desc = {
    Text = "Các bạn lang thang trong bệnh viện dưỡng lão giữa cơn gió lạnh buốt, một con bướm đen không nên tồn tại trong mùa này bay đến nhẹ nhàng. \n Con bướm vỗ cánh, mang theo chất lỏng đen sền sệt, bay lượn lên xuống. Những lớp chất lỏng đen đặc tuôn ra từ cánh, sau khi đông cứng thì bị gió làm bong tróc. \n Nó mệt mỏi sau khi bay và đậu trên đầu ngón tay của bạn."
  },
  Event_7164_Name = {
    Text = "Điều không nên tồn tại"
  },
  Event_7165_ChoiceDesc1 = {
    Text = "[rời đi] nhận được 3 chọn 1 vật phẩm bạc, nhiễm phải 「(Skill.Arg1)」"
  },
  Event_7165_Desc = {
    Text = "Bạn bắt đầu cảm thấy mệt mỏi. \nÝ thức dẫn dắt bạn, vượt qua ao hồ, vượt qua núi cao, \nbay ra ngoài ánh sáng mặt trời, bay tới những năm ánh sáng xa xôi, \ntới nơi khởi nguồn duy nhất của vũ trụ... cái nôi của sự sống."
  },
  Event_7165_Name = {
    Text = "Lễ Bế Màn Ⅳ"
  },
  Event_7166_ChoiceDesc1 = {
    Text = "[tìm thêm xem]"
  },
  Event_7166_Desc = {
    Text = "Bóng tối khổng lồ bao trùm bạn hoàn toàn, nước bọt hôi thối lại làm bạn ướt như chuột lột. \n \"Chú chuột nhỏ, mau lại đây. Chỉ một chút thôi...\"\n \"Tôi thề, tôi tuyệt đối không có ý định ăn bạn...\"\n \"Tôi tuyệt đối không liếc nhìn bụng mọng nước của bạn thêm một lần!\""
  },
  Event_7166_Name = {
    Text = "Vật liệu số 12"
  },
  Event_7167_ChoiceDesc1 = {
    Text = "[tìm thêm xem]"
  },
  Event_7167_Desc = {
    Text = "Bình tượng nến triết gia gầy guộc hút thuốc, bao phủ trong màn sương trắng. \n \"Bờ bên kia tồn tại nhưng không thể biết, vì vậy bờ bên kia không thể biết được.\"\n \"Hãy tưởng tượng thế giới này như một trò chơi... \nĐiều bạn đang tìm kiếm, có thể ở bên kia bản đồ.\""
  },
  Event_7167_Name = {
    Text = "Vật liệu số 45"
  },
  Event_7168_ChoiceDesc1 = {
    Text = "[tìm thêm xem]"
  },
  Event_7168_Desc = {
    Text = "\"Xin lỗi, không có ý gì cả...\"\n \"Tôi không thích chuột. Vấn đề của chúng là chẳng bao giờ biết sợ con người...\"\nNgười già râu tóc bạc nằm trong góc, ánh mắt u buồn chăm chú nhìn bạn.\n \"Dù sao, các người rất có chí tiến thủ.\nĐiều đó tốt, nhưng vẫn chưa đủ để giúp các người tránh được thảm họa...\""
  },
  Event_7168_Name = {
    Text = "Vật liệu số 4"
  },
  Event_7169_ChoiceDesc1 = {
    Text = "[Trình bày lời nguyền] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", lây nhiễm \"(Skill.Arg2)\""
  },
  Event_7169_ChoiceDesc2 = {
    Text = "[Từ chối Quạ] nhận 3 khắcăng để chọn"
  },
  Event_7169_ChoiceDesc3 = {
    Text = "[phớt lờ]"
  },
  Event_7169_Desc = {
    Text = "Đàn quạ đa đầu đen tối và bệnh hoạn bay ra từ áo choàng đen của một đám tín đồ cầm đèn, đậu lên vai bạn. \n \"Có thấy đầu tôi không? Chỉ cần nếm thử lời nguyền, tôi sẽ mọc ra đầu mới. Hãy để tôi xem nào, lời nguyền của bạn!\""
  },
  Event_7169_Name = {
    Text = "Quạ Nguyền Rủa"
  },
  Event_7170_ChoiceDesc1 = {
    Text = "[Phản hồi lời gọi] Xóa 1 thẻ lệnh và khôi phục Arg1 điểm sức sống"
  },
  Event_7170_ChoiceDesc2 = {
    Text = "[Tôi không đang chạy trốn] nhận được vật tạo vàng \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7170_Desc = {
    Text = "Bạn đang chạy nhanh trong con hẻm. Adrenalin được kích thích, axit lactic được tạo ra, glucose bị tiêu thụ… hỗn mang xói mòn não bộ của bạn, chiếm lĩnh suy nghĩ của bạn, trong những ảo giác đầy màu sắc thúc giục bạn chạy trốn về đích. \n Đúng vậy, chạy trốn. Nếu bạn thực sự không đang chạy trốn, thì điều đang chờ đợi bạn, tại sao lại là hỗn mang và hư vô, không thu hoạch được gì và không có kết quả gì cả?"
  },
  Event_7170_Name = {Text = "Chạy"},
  Event_7171_ChoiceDesc1 = {
    Text = "[truy tìm nguồn âm thanh]"
  },
  Event_7171_ChoiceDesc2 = {
    Text = "[Gọi Lily và cũm]"
  },
  Event_7171_Desc = {
    Text = "Từ phía xa của đường dẫn chiều, vang lên giọng nói khàn đục đầy sợ hãi, mong chờ và bất an, như thể đang gọi các người. Ngay sau đó là những lời thì thầm mơ hồ của một cô gái, rồi cả hai âm thanh dần dần tan biến."
  },
  Event_7171_Name = {
    Text = "Giọng dẫn đường"
  },
  Event_7172_ChoiceDesc1 = {
    Text = "[thu vào túi]"
  },
  Event_7172_Desc = {
    Text = "Một chất bạc có trạng thái gần như thủy ngân, được chiết xuất từ dịch nhầy rỗng rỗng, mang trong mình sức mạnh tinh thần lớn, dùng chủ yếu để liên kết nhiều thân thể được đánh thức hơn trong các nghi lễ."
  },
  Event_7172_Name = {Text = "bạc tâm"},
  Event_7173_ChoiceDesc1 = {
    Text = "[xin anh nhường đường]"
  },
  Event_7173_ChoiceDesc2 = {
    Text = "[Hỏi về danh tính]"
  },
  Event_7173_Desc = {
    Text = "Các người bước vào một toa xe mờ tối, cảm giác kỳ lạ dâng lên trong lòng. \nToa xe này trống trải, hành khách đã chạy trốn từ lâu, trên mặt đất rơi rớt những xác quái vật đang dần tan biến. \nỞ giữa toa xe, người đàn ông ấy đứng đó. \n \"Tôi tin rằng duyên phận tồn tại trên thế gian, cũng chính là duyên phận đã khiến chúng ta cùng lên chuyến tàu điện ngầm này.\""
  },
  Event_7173_Name = {
    Text = "Khách đồng hành kỳ quái Ⅳ"
  },
  Event_7174_ChoiceDesc1 = {Text = "[đi]"},
  Event_7174_Desc = {
    Text = "\"Mắt bạn thật đẹp, như những ngôi sao vậy.\"\nCharlotte cười khanh khách, mái tóc điên rồ bay loạn của cô ấy nhẹ nhàng buông xuống. \n \"Bạn chắc chắn rất được yêu thích ở trường, tôi cũng thích bạn.\"\nTrước khi rời đi, cô ấy hôn lên góc trán của bạn. \nBạn cảm thấy thân thể ấm áp, có điều gì đó dường như đã trở nên khác rồi."
  },
  Event_7174_Name = {
    Text = "Bóng của Điều tra viên"
  },
  Event_7175_ChoiceDesc1 = {
    Text = "[Đọc] Chọn 1 thẻ lệnh từ 3 thẻ để nhận khắc ấn: [(EnchantConfig.Arg1)]"
  },
  Event_7175_ChoiceDesc2 = {
    Text = "[Thu nhập vali xách tay] nhiễm \"(Skill.Arg1)\", nhận được tạo vật: \"(RelicConfig.Arg2)\""
  },
  Event_7175_Desc = {
    Text = "Một tờ giấy vàng ố rơi ra từ chiếc áo choàng của đám tín đồ cầm đèn. \n Trên giấy có rất nhiều văn bản kỳ lạ được viết bằng những hình thù đặc biệt, có cái giống như ký hiệu hình tượng, có cái thì kỳ quái vươn lên, có cái chữ còn chồng chéo lên nhau, chỉ có một ít chữ có thể nhận ra một cách khó khăn."
  },
  Event_7175_Name = {
    Text = "Mật lệnh·Thượng"
  },
  Event_7176_ChoiceDesc1 = {Text = "[đi]"},
  Event_7176_Desc = {
    Text = "Bạn nói: \"À, Charlotte! Không được!\"\nTóc của Charlotte xoắn điên rồ, cô ấy tức giận.\n \"Tôi sẽ chứng minh cho bạn thấy! Hãy xem kỹ năng của tôi!\""
  },
  Event_7176_Name = {
    Text = "Bóng của Điều tra viên"
  },
  Event_7177_ChoiceDesc1 = {
    Text = "[nhiễm phải 「(Skill.Arg1)」, nhận được bạc tạo vật 「(RelicConfig.Arg2)」]"
  },
  Event_7177_ChoiceDesc2 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_7177_Desc = {
    Text = "Sự kiện 302 (đang phát triển), chưa phải hiệu ứng cuối cùng"
  },
  Event_7177_Name = {
    Text = "Sự kiện 302 (trong quá trình phát triển)"
  },
  Event_7178_ChoiceDesc1 = {
    Text = "[Nhận yêu cầu] Nhiễm \"(Skill.Arg1)\", nhận được bạc sáng tạo \"(RelicConfig.Arg2)\""
  },
  Event_7178_ChoiceDesc2 = {
    Text = "[Từ chối yêu cầu] nhận được 25 dấu đen"
  },
  Event_7178_Desc = {
    Text = "Hàm dưới phát ra âm thanh theo nhịp điệu có quy luật, và người bạn đồng hành của bạn lại hiểu biết một chút về kiến thức mật mã. \nVăn bản được giải mã như sau: \n \"Xin chào, hãy gọi tôi là Tiến sĩ @2. Tôi từng là một nhà sưu tập, nhà tự nhiên học... \n(đây là phần giới thiệu dài dòng về sự nghiệp và danh hiệu, bỏ qua) \nTóm lại, bạn có thể giúp tôi tìm nửa còn lại không? Đó là một mảnh xương hàm trên nhỏ. \nChỉ cần tìm thấy nó, kho báu cá nhân của tôi sẽ mở cửa chào đón bạn.\""
  },
  Event_7178_Name = {
    Text = "Kẽo kẹt"
  },
  Event_7179_ChoiceDesc1 = {
    Text = "[đầu tư một trăm phường] nhiễm \"(Skill.Arg1)\", nhận được sáng tạo bạc \"(RelicConfig.Arg2)\""
  },
  Event_7179_ChoiceDesc2 = {
    Text = "[Bỏ vào năm phiến gì] nhận được 25 dấu đen."
  },
  Event_7179_Desc = {
    Text = "Chiếc ví thêu đua ra, há miệng lớn màu đen hướng về bạn. \n Kể từ khi rời khỏi chủ nhân giàu có, nó đã đói khát hàng chục năm, đang khao khát được lấp đầy. \n Bạn nhìn vào bên trong chiếc ví, bên trong trống rỗng, chỉ có bóng tối dày đặc không thấy đáy."
  },
  Event_7179_Name = {
    Text = "Ví tham lam"
  },
  Event_7180_ChoiceDesc1 = {
    Text = "[Là quyết tâm kiên định] Xóa 1 thẻ lệnh và hồi phục Arg1 điểm sức sống"
  },
  Event_7180_ChoiceDesc2 = {
    Text = "[là sự khao khát thành công] nhận được vật tạo vàng \"(RelicConfig.Arg1)\", bị nhiễm \"(Skill.Arg2)\""
  },
  Event_7180_Desc = {
    Text = "\"Hai gã cứng đầu, bệnh viện từ thiện đã rất nguy hiểm rồi,\" bộ đàm bỗng nhiên vang lên giọng của Đóa,\"các cậu định làm gì tiếp theo, khâu đầu cho cô ấy à?\"\n \"Bây giờ không phải lúc nói những lời vô ích, Đóa!\"\n \"Tôi biết, tôi nghe ra được.\"Đóa nói,\"hãy bình tĩnh một chút, biết chìa khóa thành công là gì không?\""
  },
  Event_7180_Name = {
    Text = "Luật của Logan"
  },
  Event_7181_ChoiceDesc1 = {
    Text = "[nhiễm phải 「(Skill.Arg1)」, nhận được bạc tạo vật 「(RelicConfig.Arg2)」]"
  },
  Event_7181_ChoiceDesc2 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_7181_Desc = {
    Text = "Sự kiện 304 (đang phát triển), chưa phải hiệu ứng cuối cùng"
  },
  Event_7181_Name = {
    Text = "Sự kiện 304 (đang phát triển)"
  },
  Event_7182_ChoiceDesc1 = {
    Text = "[nhiễm phải 「(Skill.Arg1)」, nhận được bạc tạo vật 「(RelicConfig.Arg2)」]"
  },
  Event_7182_ChoiceDesc2 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_7182_Desc = {
    Text = "Sự kiện 305 (đang phát triển), chưa phải hiệu ứng cuối cùng"
  },
  Event_7182_Name = {
    Text = "Sự kiện 305 (trong quá trình phát triển)"
  },
  Event_7183_ChoiceDesc1 = {
    Text = "[Gác máy] nhận được 3 lựa chọn đá khắc cao cấp"
  },
  Event_7183_ChoiceDesc2 = {
    Text = "[Nhận cuộc gọi] nhận được vật sáng tạo vàng \"(RelicConfig.Arg1)\", bị nhiễm \"(Skill.Arg2)\""
  },
  Event_7183_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 50 dấu đen"
  },
  Event_7183_Desc = {
    Text = "Bạn đi qua phòng nghỉ của trưởng tàu, ở góc khuất, tiếng chuông điện thoại ré lên rất to."
  },
  Event_7183_Name = {
    Text = "Cuộc gọi từ tàu"
  },
  Event_7184_ChoiceDesc1 = {Text = "[đi]"},
  Event_7184_Desc = {
    Text = "Ánh sáng mờ nhạt, nhưng lại tồn tại một cách chân thực. \nBạc tâm mờ nhạt thế này khó mà gọi được thân thể thức tỉnh, nhưng lại rất thích hợp để tăng cường. —— đó chính là Công nghệ Bạc Tâm."
  },
  Event_7184_Name = {
    Text = "Chứng minh sự tồn tại"
  },
  Event_7185_ChoiceDesc1 = {
    Text = "[Chân dung phụ nữ] Tăng ngẫu nhiên chất lượng khắc của 1 thẻ bài"
  },
  Event_7185_ChoiceDesc2 = {
    Text = "[Ảnh gia đình bình tượng nến] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7185_Desc = {
    Text = "Bảo tàng sáp đồng thời lưu giữ không ít tác phẩm hội họa. \n Nhân vật, phong cảnh, tĩnh vật, hiện thực, trừu tượng… \n Chúng trang trí cho bức tường vốn đơn điệu, khiến nó không trở nên nhàm chán. \n Ánh mắt của bạn bị một trong số đó thu hút sâu sắc, đó là một bức tranh —"
  },
  Event_7185_Name = {
    Text = "Galeri chân dung"
  },
  Event_7186_ChoiceDesc1 = {
    Text = "[tiếp tục lật] ngẫu nhiên 1 thẻ lệnh nhận được khắcăng:[(EnchantConfig.Arg1)]"
  },
  Event_7186_ChoiceDesc2 = {
    Text = "[Rời đi] tăng Arg1 máu tối đa, nhiễm [(Skill.Arg2)]"
  },
  Event_7186_Desc = {
    Text = "Một chiếc cân dùng để cân trọng lượng. \n Phía sau nó, vô số cơ quan ngâm trong formalin đỏ. \n Chúng được xếp ngăn nắp trên các kệ lưu trữ. \n Bạn tiện tay nhặt quyển sổ bên cạnh và lật xem: \n \"Trái tim: 8 ounce, Não: 50 ounce...\""
  },
  Event_7186_Name = {
    Text = "Đăng ký cơ quan"
  },
  Event_7187_ChoiceDesc1 = {
    Text = "[mở quà tặng] nhận được thẻ bài đặc biệt"
  },
  Event_7187_Desc = {
    Text = "Hình bóng của đứa trẻ lướt qua trước mặt bạn, bạn không thể phân biệt đó liệu có phải là một đứa trẻ thật sự, hay chỉ là một hình ảnh tinh thần nào đó trong thâm cảnh. Nhưng — bạn nhìn xuống chiếc hộp còn lại trên mặt đất, trên đó có viết bằng chữ trẻ con \"quà tặng\"."
  },
  Event_7187_Name = {
    Text = "Quà tặng tốt bụng"
  },
  Event_7188_ChoiceDesc1 = {
    Text = "[Gọi quạ] nhận được 40 dấu đen, bị nhiễm [(Skill.Arg2)], tiếp tục chọn"
  },
  Event_7188_ChoiceDesc2 = {
    Text = "[Xa lánh] nhận được 25 dấu đen"
  },
  Event_7188_Desc = {
    Text = "Bạch âu đậu trên cột buồm, trên cột buồm phủ đầy sương trắng. \n Các ống cộng hưởng đồng loạt rung động, chúng bài xích sự hiện diện của bóng tối, cũng như con chim đen lạc lõng giữa biển khơi xa xăm."
  },
  Event_7188_Name = {
    Text = "Quạ Cô Độc"
  },
  Event_7189_ChoiceDesc1 = {Text = "[đi]"},
  Event_7189_Desc = {
    Text = "Bạn nghe ra bài ca dao được cải biên từ một bài tình ca. \n Ở cuối bài tình ca đó, thi sĩ nói: \n \"Cho đến khi tiếng nói của con người thức tỉnh chúng ta, chúng ta sẽ chết đuối.\"\n Không phải bây giờ. Bạn thầm nghĩ. \n Bạn vẫn đang chờ đợi con người thức tỉnh bạn."
  },
  Event_7189_Name = {
    Text = "Giọng của đàn quạ"
  },
  Event_7190_ChoiceDesc1 = {Text = "[đi]"},
  Event_7190_Desc = {
    Text = "Một cuộn phim đầy bụi bẩn. Nhưng trong căn phòng này không có máy chiếu, và lúc này cũng không phải là thời gian để thoải mái tận hưởng biệt thự, phim ảnh và trà chiều. \n Có lẽ sẽ phải rất lâu sau, bạn mới có cơ hội biết nội dung trong cuộn phim."
  },
  Event_7190_Name = {
    Text = "Ký ức ánh sáng và bóng tối"
  },
  Event_7191_ChoiceDesc1 = {
    Text = "[rời đi] nhận được 3 lựa chọn đá khắc cao cấp, bị ảnh hưởng bởi [(Skill.Arg1)]"
  },
  Event_7191_Desc = {
    Text = "Bạn theo sau cậu bé, không xa cũng không gần. \n Đạp. Đạp. Đạp… Cậu bé dừng lại ở góc phố. \n Bạn thấy ánh sáng đỏ đang chao đảo phía sau cậu ấy, trực giác mách bảo bạn, bảo tàng sáp ở ngay phía trước. \n Cậu bé quay lại. Cậu ấy không có mắt, hốc mắt tối om. \n Cậu ấy mỉm cười với bạn."
  },
  Event_7191_Name = {
    Text = "Lễ Kết Thúc Ⅰ"
  },
  Event_7192_ChoiceDesc1 = {
    Text = "[rời đi] nhận được 50 dấu đen, bị lây nhiễm[(Skill.Arg1)]"
  },
  Event_7192_Desc = {
    Text = "Bạn vỗ nhẹ vào vai anh ấy. \nCậu bé quay người lại, cậu không có mắt, hốc mắt tối đen. \n \"Chào buổi tối. Tôi đang tìm đường đi đến bảo tàng bình tượng nến.\"\nCậu bé chỉ về phía trước. Bạn nhìn thấy ánh đỏ mờ ảo, chập chờn phía sau cậu. \nTrực giác mách bảo bạn, bảo tàng bình tượng nến ở ngay đó. \nKhi bạn trở lại với thực tại, cậu bé đã biến mất, chỉ còn lại bóng đèn đường kéo dài."
  },
  Event_7192_Name = {
    Text = "Lễ Kết Thúc Ⅰ"
  },
  Event_7193_ChoiceDesc1 = {
    Text = "[ấn giữ quạ] nhận được 35 dấu đen, nhiễm [(Skill.Arg2)], tiếp tục chọn"
  },
  Event_7193_ChoiceDesc2 = {
    Text = "[bỏ mặc] rời đi"
  },
  Event_7193_Desc = {
    Text = "Con quạ cô đơn khàn giọng, tự nhổ từng chiếc lông đen của mình. \nNó run rẩy vì đau đớn, kêu lên những tiếng thét chói tai, nhưng không thể dừng lại hành động ngày càng nhanh của mình. \n \"Ga—— Ga——\"\nTrong mắt nó chảy ra những giọt nước mắt xanh thẳm hòa lẫn với chất dịch đen, ngoài bạn ra, không ai chứng kiến."
  },
  Event_7193_Name = {
    Text = "Nước mắt dung nham"
  },
  Event_7194_ChoiceDesc1 = {Text = "[đi]"},
  Event_7194_Desc = {
    Text = "Kiến thức vô giá tràn vào đầu bạn, sau đó hóa thành sương mù… Khi bạn tỉnh táo lại, cuốn sách kỳ lạ với bìa màu vàng đã biến mất không để lại dấu vết…"
  },
  Event_7194_Name = {
    Text = "Cuốn sách vàng"
  },
  Event_7195_ChoiceDesc1 = {Text = "[đi]"},
  Event_7195_Desc = {
    Text = "Bạn đã dễ dàng đánh ngã những bình tượng nến này. Chúng gục đầu trước mặt bạn. \nĐáy của các bình tượng nến dường như có vài dòng chữ. \n \"Năm Hồng Tích thứ 2 tháng 11 \nRogers tạo tác phẩm tại Học viện @2\"\nBạn nhớ rằng Rogers từng theo học ngành điêu khắc tại một trường nghệ thuật, những bình tượng nến này chắc hẳn là bài tập của anh ta hồi đó."
  },
  Event_7195_Name = {Text = "bài tập"},
  Event_7196_ChoiceDesc1 = {
    Text = "[Tại sao nhỉ]"
  },
  Event_7196_ChoiceDesc2 = {
    Text = "[trượt xuống biển sâu]"
  },
  Event_7196_Desc = {
    Text = "\"Hàng giả! Trả con trai tôi về!\"\n \"Bà không phải là Thánh nữ hàng hải sao? Trách nhiệm của bà không phải là bảo vệ tàu thuyền sao? Tại sao chỉ có một con tàu trở về, bà nói đi, bà nói đi!\"\n \"Hãy để nó chết chìm! Cha tôi đã chịu khổ trước khi chết, nó cũng phải nếm trải!\"\n \"Chết chìm nó, chết chìm nó!\"\n \"Chết chìm cái hàng giả này! Buộc nó vào đá!\"\nNước biển tràn vào mũi và miệng, không khí bị ép ra từ từng góc của phế nang, cô vẫn mặc chiếc váy trắng quý phái và thanh cao.\nGần như suy nghĩ đầu tiên sau khi trở thành Thánh nữ, từ góc tối tăm nhất trong tâm trí chậm rãi hiện ra, đến muộn.\n \"Đúng vậy, những con tàu đó, tại sao lại chìm?\""
  },
  Event_7196_Name = {
    Text = "Tắm chìm"
  },
  Event_7197_ChoiceDesc1 = {
    Text = "[ấn giữ quạ] nhận được 30 dấu đen, nhiễm [(Skill.Arg2)], tiếp tục chọn"
  },
  Event_7197_ChoiceDesc2 = {
    Text = "[bỏ mặc] rời đi"
  },
  Event_7197_Desc = {
    Text = "Con quạ cô đơn khàn giọng, tự nhổ từng chiếc lông đen của mình. \nNó run rẩy vì đau đớn, kêu lên những tiếng thét chói tai, nhưng không thể dừng lại hành động ngày càng nhanh của mình. \n \"Ga—— Ga——\"\nTrong mắt nó chảy ra những giọt nước mắt xanh thẳm hòa lẫn với chất dịch đen, ngoài bạn ra, không ai chứng kiến."
  },
  Event_7197_Name = {
    Text = "Nước mắt dung nham"
  },
  Event_7198_ChoiceDesc1 = {
    Text = "[tiếp tục tìm kiếm] tăng Arg1 điểm sức sống, bị nhiễm [(Skill.Arg2)]"
  },
  Event_7198_ChoiceDesc2 = {Text = "[đi]"},
  Event_7198_Desc = {
    Text = "Dường như có một đôi tay đặt lên vai bạn, mạnh mẽ và kiên định, nhưng khi bạn quay đầu tìm kiếm, cảm giác thực sự đó lại trở nên mờ ảo khó tìm."
  },
  Event_7198_Name = {
    Text = "Liên lạc bất thường"
  },
  Event_7199_ChoiceDesc1 = {Text = "[đi]"},
  Event_7199_Desc = {
    Text = "Cầu đường sắt, mạch máu và thần kinh của Lentiennam, liên kết trái tim và tứ chi của thành phố. Bệnh viện tâm thần Rai nằm ở đầu ngón tay/ngón chân, yên lặng chờ đợi sự vận chuyển máu và tín hiệu."
  },
  Event_7199_Name = {
    Text = "Ảo giác đường sắt"
  },
  Event_7200_ChoiceDesc1 = {Text = "[đi]"},
  Event_7200_Desc = {
    Text = "Bạn đặt vali xuống đất và dẫm lên nó vài lần. Sau khi xác nhận rằng nó không còn rung động, bạn nhặt nó lên. \n Bạn phủi bụi trên đó, và trong ánh mắt đầy nghi hoặc của Muphí, cả hai tiếp tục tiến về phía trước."
  },
  Event_7200_Name = {
    Text = "Thư không mời"
  },
  Event_7201_ChoiceDesc1 = {Text = "[đi]"},
  Event_7201_Desc = {
    Text = "Nguy hiểm đang lăm le sau cánh cửa gỗ, không thích hợp để tiêu tốn quá nhiều thời gian. Hãy đặt vật này vào vali của bạn."
  },
  Event_7201_Name = {
    Text = "Cuốn sách vàng"
  },
  Event_7202_ChoiceDesc1 = {
    Text = "[xua đuổi quạ] nhận Arg1 dấu đen, nhiễm [(Skill.Arg2)], tiếp tục chọn"
  },
  Event_7202_ChoiceDesc2 = {
    Text = "[bỏ qua] rời đi"
  },
  Event_7202_Desc = {
    Text = "Nó, hoặc nói chính xác hơn là chúng, bay lượn trong phòng ngủ, va vào chụp đèn khiến nó kêu lên rầm rầm."
  },
  Event_7202_Name = {
    Text = "Đèn lồng quạ đen"
  },
  Event_7203_ChoiceDesc1 = {Text = "[đi]"},
  Event_7203_Desc = {
    Text = "Đây là chiều của tinh thần, là thế giới của linh tri thức. \n Ngoài việc khuấy loạn trí não của bạn, Họ không thể làm gì khác."
  },
  Event_7203_Name = {
    Text = "Bão Linh Tri Thức"
  },
  Event_7204_ChoiceDesc1 = {Text = "[đi]"},
  Event_7204_Desc = {
    Text = "Khung sọ: Hank Tillinghast A.F.186-A.F.203 Đảo Clê-ô-lơ\ncột sống: Andy Crawford A.F.177-A.F.203 Narragansett\n……không nên nghĩ sâu thêm."
  },
  Event_7204_Name = {
    Text = "Biển tên"
  },
  Event_7205_ChoiceDesc1 = {
    Text = "[Kiểm tra phân mảnh] lấy ngẫu nhiên 3 thẻ lệnh từ bộ bài, chọn 1 thẻ để xóa, nhận được 75 dấu đen"
  },
  Event_7205_ChoiceDesc2 = {
    Text = "[Hỏi Đóa] Lấy ngẫu nhiên 3 thẻ lệnh từ bộ bài, chọn 1 bản sao gốc của thẻ để đưa vào bộ bài, nhận 25 dấu đen"
  },
  Event_7205_ChoiceDesc3 = {
    Text = "[bỏ qua] nhận được 50 dấu đen"
  },
  Event_7205_Desc = {
    Text = "Những phân mảnh kim loại mà đóa đã đưa cho bạn đang rung nhẹ trên ngực bạn, giống như những con bướm bị quấy rối."
  },
  Event_7205_Name = {
    Text = "Brooch Bồn Khoảng"
  },
  Event_7206_ChoiceDesc1 = {Text = "[đi]"},
  Event_7206_Desc = {
    Text = "\"Ngài đang lặng lẽ chờ đợi ở điểm cuối, dù bạn đặt điểm cuối ở đâu —— hãy nhìn vào người quản lý trẻ tuổi kia, cuối cùng sự trốn tránh của cô ấy đã khiến cô phát điên.\""
  },
  Event_7206_Name = {
    Text = "Đối tượng truy đuổi"
  },
  Event_7207_ChoiceDesc1 = {
    Text = "[Rời đi] không có bất kỳ phát hiện nào"
  },
  Event_7207_Desc = {
    Text = "Đang cập nhật, sự kiện đặc biệt"
  },
  Event_7207_Name = {
    Text = "2_16 tạm thời"
  },
  Event_7208_ChoiceDesc1 = {
    Text = "[an ủi nó] tăng Arg1 điểm máu tối đa"
  },
  Event_7208_ChoiceDesc2 = {
    Text = "[Bỏ qua nó] 2 thẻ lệnh ngẫu nhiên nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm 2 thẻ \"(Skill.Arg2)\""
  },
  Event_7208_Desc = {
    Text = "Liên kết sưởi ấm cơ quan vẫn mang trái tim của con người. \nNó bắt chước nhịp thở từ bên kia liên kết, như thể bằng cách này, nó sẽ không bị bỏ rơi. Nó có quyền đồng hành cùng liên kết mãi mãi."
  },
  Event_7208_Name = {
    Text = "Phòng tim trái"
  },
  Event_7209_ChoiceDesc1 = {
    Text = "Ngẫu nhiên đá khắc cao cấp"
  },
  Event_7210_ChoiceDesc1 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_7210_Desc = {
    Text = "Sự lạnh lùng của bạn khiến chủ nhân của giọng nói cảm thấy rất tiếc nuối, mặt nước uể oải tạo ra vài gợn sóng, rồi không còn dấu vết gì khác."
  },
  Event_7210_Name = {
    Text = "Giọng ngoài thế giới"
  },
  Event_7211_ChoiceDesc1 = {
    Text = "[Chọn 1 thẻ để nhận dấu ấn:「(EnchantConfig.Arg1)」]Thử nghiệm dấu ấn"
  },
  Event_7211_ChoiceDesc2 = {
    Text = "[Chọn 1 thẻ để nhận dấu ấn:「(EnchantConfig.Arg1)」]Thử nghiệm gói rơi"
  },
  Event_7211_Desc = {
    Text = "Kiểm tra khắcăng chỉ định"
  },
  Event_7211_Name = {
    Text = "Đặt khắcăng kiểm tra 1"
  },
  Event_7212_ChoiceDesc1 = {
    Text = "[ Rời đi ] Chọn thức tỉnh một thân thể"
  },
  Event_7212_Desc = {
    Text = "Bạn vuốt ve đầu cậu bé, dẫn dắt cậu cùng đọc tiếp. \n \"Bài hát dành cho mẹ ——\"\nGiọng nói như cánh bướm đêm, bay cạnh nhau ra khỏi sân khấu trống vắng, \nnhẹ nhàng đáp xuống khán đài chìm trong bóng tối."
  },
  Event_7212_Name = {
    Text = "Lễ Kết Thúc Ⅲ"
  },
  Event_7213_ChoiceDesc1 = {
    Text = "[đi] nhận được quyền chọn 1 trong 3 vật tạo vàng, nhiễm [(Skill.Arg1)]"
  },
  Event_7213_Desc = {
    Text = "Bạn không động thanh sắc. Một quý bà bỗng nhiên xông lên sân khấu. \nCô ta điên rồ tách miệng cậu bé ra. Sau đó, cô đâm mạnh cây gậy trong tay vào trong. \n \"Nói đi, nói cho tôi nghe.\"\nMáu đen chảy ra từ miệng cậu bé. Cậu ấy lèm nhèm đọc tiếp. \n \"Bài hát dâng tặng mẹ...\""
  },
  Event_7213_Name = {
    Text = "Lễ Kết Thúc Ⅲ"
  },
  Event_7215_ChoiceDesc1 = {Text = "[đi]"},
  Event_7215_Desc = {
    Text = "Đó không phải là cửa sổ, mà là một mặt gương. Trong gương phản chiếu khuôn mặt căng thẳng của Ramona. \nTại sao phòng này lại không có cửa sổ, mà chỉ treo một chiếc gương lớn trên tường?"
  },
  Event_7215_Name = {
    Text = "Phản ánh trong cửa sổ"
  },
  Event_7216_ChoiceDesc1 = {
    Text = "[nắm giữ chìa khóa bạc] ngẫu nhiên đánh thức một thân thể đã được kích hoạt, lây nhiễm [(Skill.Arg1)]"
  },
  Event_7216_ChoiceDesc2 = {
    Text = "[đóng mắt lại] chọn 1 thẻ lệnh từ 3 thẻ để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_7216_Desc = {
    Text = "Bạn bị xé nát bởi một cơn phi lý to lớn, cơ thể cong vẹo bò lê trên mặt đất, như thể bị @2 thao túng từ bên ngoài không gian chiều. \n \"Không... không...\"\nLý trí của bạn sụp đổ từng mảnh, tiếng cười điên dại và tiếng la hét đan xen, như một tấm lưới khổng lồ trói buộc ý thức của bạn, chỉ còn lại những tiếng rên rỉ mơ hồ tràn ra khỏi miệng."
  },
  Event_7216_Name = {
    Text = "Mắt ngắm nhìn"
  },
  Event_7217_ChoiceDesc1 = {Text = "[đi]"},
  Event_7217_Desc = {
    Text = "Sắc màu dải ngân hà biến đổi, dưới chân bạn hiện ra những hoa văn khó tả, rực rỡ như hồng ngọc nhưng lại mềm mại và mờ ảo như sứa biển. Bên trong chiếc vali, ánh sáng đỏ dần lan tỏa…"
  },
  Event_7217_Name = {
    Text = "Điểm giao nhau của các ngôi sao"
  },
  Event_7218_ChoiceDesc1 = {
    Text = "[ Giải trừ ảo ảnh] Áp lực +10."
  },
  Event_7218_ChoiceDesc2 = {Text = "[đi]"},
  Event_7218_Desc = {
    Text = "Những khuôn mặt mờ ảo đột nhiên xuất hiện, chúng vây quanh bạn và tuyệt vọng rên rỉ bằng những dây thanh âm không tồn tại."
  },
  Event_7218_Name = {Text = "ảo ảnh"},
  Event_7221_ChoiceDesc1 = {
    Text = "[Tiếp nhận] nhận được bạc sáng tạo [(RelicConfig.Arg1)]"
  },
  Event_7221_ChoiceDesc2 = {
    Text = "[thấp đầu xem xét] nhận được 75 dấu đen, bị nhiễm [(Skill.Arg2)]"
  },
  Event_7221_Desc = {
    Text = "Những con quạ quay cuồng trong bầu trời bị cắt thành hình khối bởi những con hẻm, phát ra tiếng kêu khàn khàn khiến lòng người bất an. \n Đàn quạ đột nhiên trở nên điên loạn, như thể một bản năng bệnh hoạn nào đó bị biến dạng hoặc thức tỉnh, chúng sốt ruột và hung dữ đập nhau, trong sự xé rách có thứ gì đó rơi xuống."
  },
  Event_7221_Name = {
    Text = "Bầy quạ hỗn loạn"
  },
  Event_7222_ChoiceDesc1 = {
    Text = "[Tuân theo chỉ thị] Tăng Arg1 điểm Sinh lực"
  },
  Event_7222_ChoiceDesc2 = {Text = "[đi]"},
  Event_7222_Desc = {
    Text = "Bạn thử sử dụng sức mạnh truy vết của chìa khóa bạc để tìm điểm liên lạc gần nhất, nhưng thông tin nhận được chứa những bất thường khó phát hiện, có vẻ đã bị can thiệp."
  },
  Event_7222_Name = {
    Text = "Liên lạc bất thường"
  },
  Event_7223_ChoiceDesc1 = {
    Text = "[Giao cho đóa] Nhận ngẫu nhiên 1 thẻ lệnh có khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_7223_ChoiceDesc2 = {
    Text = "[Đọc bảng danh hiệu] Tăng Arg1 điểm máu tối đa, nhiễm [(Skill.Arg2)]"
  },
  Event_7223_Desc = {
    Text = "Từ thực thể Hiệp hội Điêu khắc gia mà bạn đã đánh bại, rơi ra một bảng tên có khung kim loại. Chìa khóa bạc cảm ứng và phát sáng nhẹ."
  },
  Event_7223_Name = {
    Text = "Biển tên"
  },
  Event_7224_ChoiceDesc1 = {Text = "[đi]"},
  Event_7224_Desc = {
    Text = "Người cầm dao hú dài, tiếng hú như thể có thể chẻ đôi núi sông. \n Tiếng động tan biến trong chớp mắt, cả hai người dấn thân vào biển cũng biến mất tăm… Hóa ra đó chỉ là một ảo ảnh được thâm cảnh phản chiếu lại."
  },
  Event_7224_Name = {
    Text = "Truy đuổi không ngừng"
  },
  Event_7225_ChoiceDesc1 = {
    Text = "[sửa chữa tượng sáp] Chọn thẻ bài và làm giảm tiêu thụ sức tính toán của nó đi 1"
  },
  Event_7225_Desc = {
    Text = "Bạn cầm ngọn nến, đi qua sương mù mờ ảo, đến trước mặt cô ấy. \n Đây là một bức bình tượng nến chưa hoàn thành. \n Khuôn mặt mềm mại bị chia làm hai, một nửa mỉm cười, một nửa @1. \n Hãy trở thành thần linh của cô ấy. \n Ban cho cô ấy vẻ đẹp, ban cho cô ấy nước mắt. \n Khắc họa cô ấy, hoặc là hủy diệt cô ấy."
  },
  Event_7225_Name = {
    Text = "Bình tượng nến chưa hoàn thành"
  },
  Event_7226_ChoiceDesc1 = {Text = "[đi]"},
  Event_7226_Desc = {
    Text = "「Tất nhiên, tôi đã tận mắt chứng kiến sự tiêu vong.」 bạn trả lời. \nĐúng vậy, đó chỉ là cái chết bạo lực của một con chuột, một trái tim bị mục nát, và lễ tang của một bó hoa diên vĩ 「và」 một đêm tối."
  },
  Event_7226_Name = {
    Text = "Thần quốc bị lãng quên"
  },
  Event_7227_ChoiceDesc1 = {Text = "[đi]"},
  Event_7227_Desc = {
    Text = "\"thần quốc... tiêu vong... vấn đề mờ ảo khó nắm bắt... ta không rõ, thế nào mới được coi là tiêu vong.\"\nHai bóng người khẽ mỉm cười, xung quanh tỏa ra những mảnh sáng trắng như tuyết. \n \"Vậy thì ngay lúc này, ngươi sẽ chứng kiến một sự tiêu vong thực sự.\""
  },
  Event_7227_Name = {
    Text = "Thần quốc bị lãng quên"
  },
  Event_7228_ChoiceDesc1 = {
    Text = "[Ghép giấy] nhận được vật tạo vàng \"(RelicConfig.Arg1)\", bị nhiễm \"(Skill.Arg2)\""
  },
  Event_7228_ChoiceDesc2 = {
    Text = "[Đọc] Chọn 1 thẻ lệnh từ 3 thẻ để nhận khắc ấn: [(EnchantConfig.Arg1)]"
  },
  Event_7228_ChoiceDesc3 = {
    Text = "[đánh bỏ nó] nhận được 50 dấu đen"
  },
  Event_7228_Desc = {
    Text = "Một tờ giấy vàng ố rơi ra từ chiếc áo choàng của đám tín đồ cầm đèn. \n Trên giấy có rất nhiều văn bản kỳ lạ được viết, có cái giống như ký hiệu hình tượng, có cái thì kỳ quái vươn lên, có cái chữ còn chồng chéo lên nhau, chỉ có một ít chữ có thể nhận ra một cách khó khăn. \n Tiêu đề là《@2 Sự ra đời của Con Thánh》"
  },
  Event_7228_Name = {
    Text = "Lệnh bí mật·dưới"
  },
  Event_7229_ChoiceDesc1 = {
    Text = "[struggle] nhận được sáng tạo bạc \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7229_ChoiceDesc2 = {
    Text = "[chìm đắm] nhận được bạc sáng tạo \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7229_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_7229_Desc = {
    Text = "\"Tôi rất đau khổ, rất đau khổ...\"\n \"Tại sao lại là tôi, tại sao tôi phải trải qua điều này?\"\n \"Cha Thần nhân từ ơi, tôi đã làm sai điều gì?\"\nBuồn bã, đau khổ, giận dữ, không cam lòng... Những cảm xúc của những \"bệnh nhân\"đè nặng lên bạn, bạn ôm ngực, không thể thở."
  },
  Event_7229_Name = {Text = "Nghiện"},
  Event_7230_ChoiceDesc1 = {Text = "[đi]"},
  Event_7230_Desc = {
    Text = "Đường nhìn xuyên qua da thịt, để lại dấu ấn trên võng mạc của người tiên phong. \n Không ai có thể trốn thoát, cũng như không ai @2"
  },
  Event_7230_Name = {Text = "Nhìn lén"},
  Event_7231_ChoiceDesc1 = {Text = "[đi]"},
  Event_7231_Desc = {
    Text = "Tập trung tinh thần, phân biệt lời bài hát, sau đó bị những từ ngữ lộn xộn tấn công vào sau gáy. \n Đó không phải là điều con người có thể hiểu."
  },
  Event_7231_Name = {
    Text = "Bài hát biển cả"
  },
  Event_7232_ChoiceDesc1 = {
    Text = "[Thử thách] Nhiễm [(Skill.Arg1)], chiến thắng nhận được vật tạo vàng, thất bại nhận được 50 dấu đen"
  },
  Event_7232_ChoiceDesc2 = {
    Text = "[rời đi] nhận được 50 dấu đen"
  },
  Event_7232_Desc = {
    Text = "Bạn đã nhìn thấy một số bí mật từ vũng bùn đen phản chiếu như gương dưới chân. \n Đường viền của bóng phản chiếu mơ hồ, xung quanh bao trùm bởi làn khói đen không thể xua tan, bạn cảm thấy quen thuộc một cách kỳ lạ, nhưng lại không thể nhận ra nó rốt cuộc là gì."
  },
  Event_7232_Name = {
    Text = "Dưới bề mặt gương"
  },
  Event_7233_ChoiceDesc1 = {Text = "[đi]"},
  Event_7233_Desc = {
    Text = "Bạn không coi trọng những lá thư vô danh lẩm bẩm, và đốt ngay chúng. Tờ giấy hóa thành tro bay."
  },
  Event_7233_Name = {
    Text = "Lá thư cầu cứu nữa"
  },
  Event_7234_ChoiceDesc1 = {Text = "[đi]"},
  Event_7234_Desc = {
    Text = "Bạn kiểm tra phần thân của bức thư, ở mép dán có chất lỏng nhầy nhụa, dường như là hỗn hợp giữa máu và nhựa đen, lẫn vài sợi tóc bị dính chặt ở mép dán."
  },
  Event_7234_Name = {
    Text = "Lá thư cầu cứu nữa"
  },
  Event_7235_ChoiceDesc1 = {Text = "[đi]"},
  Event_7235_Desc = {
    Text = "Theo hướng lá thư rơi, ở góc tường, bạn thoáng thấy vật gì đó lấp lánh."
  },
  Event_7235_Name = {
    Text = "Lá thư cầu cứu nữa"
  },
  Event_7236_ChoiceDesc1 = {
    Text = "[tiếp tục tìm kiếm] tăng Arg1 điểm sức sống, bị nhiễm [(Skill.Arg2)]"
  },
  Event_7236_ChoiceDesc2 = {Text = "[đi]"},
  Event_7236_Desc = {
    Text = "Ánh sáng mờ ảo hiện ra trước mắt, tỏa sáng ngời và mang lại cảm giác ấm áp. Khi định bước theo nguồn sáng ấy, nó đột ngột tan biến."
  },
  Event_7236_Name = {
    Text = "Liên lạc bất thường"
  },
  Event_7237_ChoiceDesc1 = {
    Text = "[rời đi] tất cả thân thể được đánh thức khôi phục Arg1 điên cuồng"
  },
  Event_7237_Desc = {
    Text = "Bạn sợ hãi đến nỗi nhắm chặt hai mắt lại. \n \"Bạn đã lật tấm vải lên... \nBí mật, bạn đã khám phá ra bí mật...\"\nSóng âm thanh tạo thành một đại dương ồn ào, sàn nhà rung chuyển dữ dội trong sự cộng hưởng đáng sợ. \nBạn không thể chịu đựng thêm nữa, bất chợt mở to mắt ra nhưng nhận thấy xung quanh không có gì cả."
  },
  Event_7237_Name = {
    Text = "Lễ Chấm Dứt Ⅴ"
  },
  Event_7238_ChoiceDesc1 = {
    Text = "[tiếp tục tìm kiếm] tăng Arg1 điểm sức sống, bị nhiễm [(Skill.Arg2)]"
  },
  Event_7238_ChoiceDesc2 = {Text = "[đi]"},
  Event_7238_Desc = {
    Text = "Mũi ngửi thấy mùi quen thuộc, thân thuộc và khiến người ta thỏa mãn, khi bạn muốn hít thêm hương thơm của căn tin, thì mùi hương đó đã tan biến hoàn toàn."
  },
  Event_7238_Name = {
    Text = "Liên lạc bất thường"
  },
  Event_7239_ChoiceDesc1 = {
    Text = "[tiếp tục tìm kiếm] tăng Arg1 điểm sức sống, bị nhiễm [(Skill.Arg2)]"
  },
  Event_7239_ChoiceDesc2 = {Text = "[đi]"},
  Event_7239_Desc = {
    Text = "Câu nói quen thuộc vang lên bên tai, thân thiết và an ủi, khi muốn tìm theo tiếng nói, nó lại đột ngột im bặt."
  },
  Event_7239_Name = {
    Text = "Liên lạc bất thường"
  },
  Event_7240_ChoiceDesc1 = {Text = "[đi]"},
  Event_7240_Desc = {
    Text = "Lực truy tìm không thể ngay lập tức tìm lại điểm liên lạc cho bạn, nhưng bạn đã cảm thấy nhẹ lòng trong chốc lát."
  },
  Event_7240_Name = {
    Text = "Liên lạc bất thường"
  },
  Event_7241_ChoiceDesc1 = {
    Text = "[tiếp tục tìm kiếm] tăng Arg1 điểm sức sống, bị nhiễm [(Skill.Arg2)]"
  },
  Event_7241_ChoiceDesc2 = {Text = "[đi]"},
  Event_7241_Desc = {
    Text = "Dường như có một đôi tay đặt lên vai bạn, mạnh mẽ và kiên định, nhưng khi bạn quay đầu tìm kiếm, cảm giác thực sự đó lại trở nên mờ ảo khó tìm."
  },
  Event_7241_Name = {
    Text = "Liên lạc bất thường"
  },
  Event_7242_ChoiceDesc1 = {Text = "[đi]"},
  Event_7242_Desc = {
    Text = "\"N\" bóng ma bị gió đấm đánh tan, hạt đen và thâm cảnh sương mù hòa làm một, khó tìm dấu vết. \n \"Không thú vị, nhưng cũng đáng chú ý. Tôi rất mong được gặp bạn thực sự...\""
  },
  Event_7242_Name = {
    Text = "Buổi biểu diễn bắt đầu"
  },
  Event_7243_ChoiceDesc1 = {Text = "[đi]"},
  Event_7243_Desc = {
    Text = "\"Đứa trẻ ngoan. Tuy nhiên, ta vẫn phải đưa ra một hình phạt nhỏ cho em.\"\nTiếng cười khẽ của Đào Đen Đá tan biến trong khe hở chiều."
  },
  Event_7243_Name = {
    Text = "Thời gian gợi ý"
  },
  Event_7244_ChoiceDesc1 = {
    Text = "[Mặt tích cực] 50% cơ hội nhận vật tạo vàng \"(RelicConfig.Arg2)\", 50% cơ hội mắc phải \"(Skill.Arg3)\""
  },
  Event_7244_ChoiceDesc2 = {
    Text = "[phản diện] 50% xác suất nhận được 75 dấu đen, 50% xác suất bị lây nhiễm [(Skill.Arg3)]"
  },
  Event_7244_ChoiceDesc3 = {
    Text = "[Chíp Đen] 50% xác suất nhận được vật bị nguyền rủa \"(RelicConfig.Arg2)\", 50% xác suất nhiễm \"(Skill.Arg3)\""
  },
  Event_7244_Desc = {
    Text = "Rất tốt… thật sự rất tốt……\nVậy, hãy chọn mệnh giá mà bạn muốn."
  },
  Event_7244_Name = {
    Text = "Buổi biểu diễn bắt đầu"
  },
  Event_7245_ChoiceDesc1 = {Text = "[đi]"},
  Event_7245_Desc = {
    Text = "\"Được rồi, được rồi. Hắn ta luôn quấn quýt với những sinh vật vượt qua các chiều không gian, tôi cũng đã mất khá nhiều công sức để di chuyển tự do giữa những lỗ hổng chiều không gian này. À, đó là chuyện của ba nghìn năm trước rồi nhỉ?\""
  },
  Event_7245_Name = {
    Text = "Thời gian gợi ý"
  },
  Event_7246_ChoiceDesc1 = {Text = "[đi]"},
  Event_7246_Desc = {
    Text = "Chắc là trưởng phòng nghiên cứu sẽ không lắp bom vào ngực bạn đâu."
  },
  Event_7246_Name = {
    Text = "Brooch Bồn Khoảng"
  },
  Event_7247_ChoiceDesc1 = {
    Text = "[Rời đi] xóa 1 thẻ lệnh, nhận 25 dấu đen"
  },
  Event_7247_Desc = {
    Text = "\"Là người đi đường tốt bụng, cung cấp hướng dẫn đúng đắn cho người lạc đường,\" nụ cười của anh ta không có ý tốt,\"hãy mang theo ít đồ đạc, Cerberus đang chờ đợi các người.\"\nThiết bị chỉ huy trong tay bất ngờ rung lên."
  },
  Event_7247_Name = {
    Text = "Khách lữ kỳ quái Ⅲ"
  },
  Event_7248_ChoiceDesc1 = {
    Text = "[di chuyển từ từ] chọn 1 thẻ lệnh từ 3 thẻ để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_7248_ChoiceDesc2 = {
    Text = "[Nằm sấp] Chọn 1 thẻ lệnh từ 3 thẻ lệnh để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_7248_Desc = {
    Text = "\"Gặp phải đầm lầy, tuyệt đối không được giãy dụa.\"\nBạn ghi nhớ quy tắc sinh tồn này, đứng im như những tượng trên đảo Phục Sinh.\nNăm phút, mười phút, một giờ... bùn đen cuối cùng cũng mất kiên nhẫn, biến mất khỏi chân bạn."
  },
  Event_7248_Name = {
    Text = "Đầm lầy Tối"
  },
  Event_7249_ChoiceDesc1 = {Text = "[đi]"},
  Event_7249_Desc = {
    Text = "Bạn chú ý đến một bàn tay khác biệt. Nó mịn màng, trắng trẻo, từ đầu đến cuối đều thể hiện sự bình tĩnh. \n Quan trọng hơn là — bạn nhận ra, đó chính là bàn tay của bạn. \n Bạn nhẹ nhàng nắm lấy nó. \n Bàn tay đó cũng nắm lấy tay bạn. Bạn cảm thấy cái lạnh thấu xương và hư vô, sau đó đầm lầy biến mất."
  },
  Event_7249_Name = {
    Text = "Đầm lầy Tối"
  },
  Event_7250_ChoiceDesc1 = {
    Text = "[Cắt đứt một tay] từ 3 thẻ lệnh chọn 1 để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_7250_ChoiceDesc2 = {
    Text = "[Xoa dịu chúng] từ 3 thẻ lệnh chọn 1 để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_7250_Desc = {
    Text = "Bạn vung lưỡi dao sắc trong tay, chém chúng từng cái một. \n Đủ loại máu bắn vào người bạn, vào mặt bạn, vào tóc bạn, nhưng bạn hoàn toàn không hay biết. \n Vô số bàn tay cùng phát ra tiếng kêu đau đớn, và đầm lầy biến mất. \n Cho đến một tuần sau, bạn mới không nghe thấy những tiếng khóc đó trong cơn ác mộng."
  },
  Event_7250_Name = {
    Text = "Đầm lầy Tối"
  },
  Event_7251_ChoiceDesc1 = {
    Text = "[Nhặt bạc tâm] Nâng cấp một vật tạo bạc thành vật tạo vàng [(RelicConfig.Arg1)]"
  },
  Event_7251_ChoiceDesc2 = {
    Text = "[cố gắng thức tỉnh] nhận được vật tạo vàng \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\" và \"(Skill.Arg3)\""
  },
  Event_7251_ChoiceDesc3 = {
    Text = "[bỏ qua] nhận được 25 dấu đen"
  },
  Event_7251_Desc = {
    Text = "Dưới những thanh gỗ boong tàu lỏng lẻo, tràn ra một dòng bùn đen đục. \nÁnh sáng trong dòng bùn đen đó là \"bạc tâm\" mà bạn đã quá quen thuộc."
  },
  Event_7251_Name = {
    Text = "Chứng minh sự tồn tại"
  },
  Event_7252_ChoiceDesc1 = {
    Text = "[chọn chuột] ngẫu nhiên 1 thẻ lệnh nhận được khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_7252_ChoiceDesc2 = {
    Text = "[chọn nến] tăng Arg1 điểm máu tối đa, bị nhiễm [(Skill.Arg2)]"
  },
  Event_7252_Desc = {
    Text = "Thân thể bị ăn mòn tan biến trước mặt bạn, tro lạnh đen hòa vào sương mù, tạo thành một cái cân kỳ quái. Một bên của cái cân là một con chuột đang ngủ, bên kia là một cây nến khắc hình một cậu bé. \n Trong thâm tâm bạn biết, bạn phải đưa ra lựa chọn."
  },
  Event_7252_Name = {
    Text = "Lý trí và Tình cảm"
  },
  Event_7253_ChoiceDesc1 = {
    Text = "[thử thám bằng giọng nói]"
  },
  Event_7253_ChoiceDesc2 = {
    Text = "[Đi theo lén lút]"
  },
  Event_7253_Desc = {
    Text = "Đi qua một góc rẽ, mọi thứ xung quanh trở nên mờ ảo hơn, chỉ có tiếng gầm ghê rợn vẫn còn rõ ràng. \nTiếng bước chân vang lên, bạn quay đầu lại, mơ hồ nhìn thấy một hình dáng kỳ lạ: đó dường như là một con người, đồng thời phía sau có những bóng tối thành cặp, trông giống như một con bướm khổng lồ. \n \"Cẩn thận,\" Ramona thì thầm nhắc nhở, \"Trong thâm cảnh, điều mắt thấy chưa chắc đã là sự thật, nếu liều lĩnh theo dõi, có thể sẽ gặp nguy hiểm.\""
  },
  Event_7253_Name = {
    Text = "Hình bóng trong sương mù"
  },
  Event_7254_ChoiceDesc1 = {Text = "[đi]"},
  Event_7254_Desc = {
    Text = "Bạn lấy ra chìa khóa bạc, nắm nó trong lòng bàn tay một cách thành kính và đượm buồn, ánh sáng mỏng như sương mù bao phủ bạn. \nTrong sự yên lặng, chỉ còn lại tiếng thở dài."
  },
  Event_7254_Name = {
    Text = "Mắt ngắm nhìn"
  },
  Event_7255_ChoiceDesc1 = {
    Text = "[ Chọn Đường Dải Ngân Hà ] Nhận ngẫu nhiên 1 thẻ lệnh với khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_7255_ChoiceDesc2 = {
    Text = "[Chọn Đường Hồng Sắc] tăng Arg1 điểm máu tối đa, lây nhiễm [(Skill.Arg2)]"
  },
  Event_7255_Desc = {
    Text = "Thụp, thụp, thụp. \n Nhịp tim như trống đánh, khô cổ họng, ánh mắt từ trên cao xuyên qua cột sống của bạn. \n Trước mắt xuất hiện một con đường phân nhánh, một dòng sông sao chảy, một con đường cầu vồng phát sáng."
  },
  Event_7255_Name = {
    Text = "Điểm giao nhau của các ngôi sao"
  },
  Event_7256_ChoiceDesc1 = {Text = "[đi]"},
  Event_7256_Desc = {
    Text = "Ánh mắt còn lại vẫn dõi theo bạn, các tế bào dưới da điên cuồng gào thét và thoát ra, mạch máu bò như sâu. \nBạn cảm nhận luồng sức mạnh chảy qua, bùng nổ qua những biến đổi quái dị trên cơ thể."
  },
  Event_7256_Name = {
    Text = "Mắt ngắm nhìn"
  },
  Event_7257_ChoiceDesc1 = {
    Text = "[đi khỏi] nhiễm [(Skill.Arg1)]"
  },
  Event_7257_ChoiceDesc2 = {
    Text = "[đi khỏi] nhiễm [(Skill.Arg1)]"
  },
  Event_7257_ChoiceDesc3 = {
    Text = "[đi khỏi] nhiễm [(Skill.Arg1)]"
  },
  Event_7257_Desc = {
    Text = "\"Không, điều này không phải là thật. So với gián, các ngươi ít nhất còn có thân thể lông lá. \n Không ai có thể từ chối một thân thể lông lá.\"\n Những con chuột thì thầm với nhau, cuối cùng miễn cưỡng đồng ý với quan điểm của bạn. \n \"May mắn thay... thực ra cũng không có nhiều lông lắm.\"\n Được khen ngợi luôn khiến người ta vui vẻ. Trước khi rời đi, những con chuột tặng bạn một quà tặng nhỏ."
  },
  Event_7257_Name = {
    Text = "Bệnh dịch hạch"
  },
  Event_7258_ChoiceDesc1 = {Text = "[đi]"},
  Event_7258_Desc = {
    Text = "\"Tôi đồng ý! Con người và chuột không đội trời chung!\"\nNhững con chuột có vẻ hơi tức giận, lộ ra những chiếc răng nanh trắng như tuyết. \n \"Vậy còn đứng đây làm gì? Lấy đồ đi, và đừng bao giờ quay lại!\""
  },
  Event_7258_Name = {
    Text = "Bệnh dịch hạch"
  },
  Event_7259_ChoiceDesc1 = {
    Text = "[rời đi] nhận được sáng tạo \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7259_Desc = {
    Text = "Âm thanh vỗ cánh kỳ lạ văng vẳng xung quanh bạn, trong trạng thái mơ màng, bạn thấy Rogers ôm lấy con búp bê George đang nằm trên giường khám bệnh, hai tay đầy máu. \n Bạn mở mắt ra, phát hiện Clementine đã không còn ở đó. \n Tỉnh giấc, Clementine đã rời đi."
  },
  Event_7259_Name = {
    Text = "Therapy thôi miên"
  },
  Event_7260_ChoiceDesc1 = {
    Text = "[Mở] sử dụng chìa khóa."
  },
  Event_7260_ChoiceDesc2 = {Text = "[đi]"},
  Event_7260_Desc = {
    Text = "Một cánh cửa chặn đường đi của bạn. Bạn đã dùng hết mọi cách, nhưng nó vẫn đứng im."
  },
  Event_7260_Name = {
    Text = "cánh cửa rỉ sét"
  },
  Event_7260_Tips1 = {
    Text = "Cần phải có \"chìa khóa rỉ sét\""
  },
  Event_7261_ChoiceDesc1 = {Text = "[đi]"},
  Event_7261_Desc = {
    Text = "Bạn nhìn về phía bạn cho là nguồn ánh mắt. Trần nhà của phường bỗng trở nên cao vời vợi, ảo ảnh của con ngươi khổng lồ chồng chéo lên nhau, mặc dù chỉ có một phần giao nhau với ánh mắt của bạn, bạn vẫn cảm thấy áp lực to lớn."
  },
  Event_7261_Name = {Text = "Ai nhìn"},
  Event_7262_ChoiceDesc1 = {Text = "[đi]"},
  Event_7262_Desc = {
    Text = "Mèo đen cẩn thận bước đến gần, nôn ra một khối đen đặc quánh trong lòng bàn tay bạn."
  },
  Event_7262_Name = {
    Text = "Đám tai ương của mèo đêm"
  },
  Event_7263_ChoiceDesc1 = {Text = "[đi]"},
  Event_7263_Desc = {
    Text = "\"Ừ, lựa chọn thông minh. Đại địch hiện tiền, chắc chắn sẽ muốn biết mình biết người? Tuy nhiên, biết quá nhiều về bí mật của chiều không gian có thể làm nhiễu loạn tinh thần đó nhé.\"\n \"Hắn ta, luôn bám riết không buông những sinh vật vượt qua chiều không gian, tôi cũng phải mất rất nhiều công sức mới có thể tự do di chuyển trong những lỗ hổng của các chiều không gian này. À, đó phải là ba nghìn năm trước rồi nhỉ?\""
  },
  Event_7263_Name = {
    Text = "Thời gian gợi ý"
  },
  Event_7264_ChoiceDesc1 = {Text = "[đi]"},
  Event_7264_Desc = {
    Text = "\"Meo, meo meo, meo meo meo...\"\nBạn nhón giọng, cố gắng tỏ ra yếu ớt và vô hại.\n \"Meo! Meo meo! Meo meo meo!\"\nĐàn mèo dường như đã chấp nhận thiện ý của bạn, đáp lại bằng những tiếng kêu vang dội. Những tiếng kêu của các bạn vang lên xen kẽ, ngày đêm không ngừng, ngay cả mặt trăng cũng phải trốn vào giữa mây."
  },
  Event_7264_Name = {
    Text = "Thành phố mèo"
  },
  Event_7265_ChoiceDesc1 = {Text = "[đi]"},
  Event_7265_Desc = {
    Text = "Bạn mạnh mẽ bẻ lại mỏ nhọn của con quạ đang định cắn lông, nhưng nó không chịu buông tha, quay người lại, sức mạnh lớn đến nỗi khiến xương của bạn kêu lên răng rắc. \n Bạn đỏ mặt, dùng toàn bộ sức lực mới giữ chặt được cơ thể con quạ, ngăn chặn hành động tự hủy hoại điên cuồng của nó. \n Khi bạn thở phào nhẹ nhõm, cổ con quạ đã gần như hói đảo mạnh về phía sau, cơ thể mềm nhũn, hóa thành một vũng chất lỏng đen đặc trong tay bạn."
  },
  Event_7265_Name = {
    Text = "Nước mắt dung nham"
  },
  Event_7266_ChoiceDesc1 = {
    Text = "[Nhấn và giữ con quạ] để nhận 20 dấu đen, nhiễm [(Skill.Arg2)]"
  },
  Event_7266_ChoiceDesc2 = {
    Text = "[bỏ mặc] rời đi"
  },
  Event_7266_Desc = {
    Text = "Con quạ cô đơn khàn giọng, tự nhổ từng chiếc lông đen của mình. \nNó run rẩy vì đau đớn, kêu lên những tiếng thét chói tai, nhưng không thể dừng lại hành động ngày càng nhanh của mình. \n \"Ga—— Ga——\"\nTrong mắt nó chảy ra những giọt nước mắt xanh thẳm hòa lẫn với chất dịch đen, ngoài bạn ra, không ai chứng kiến."
  },
  Event_7266_Name = {
    Text = "Nước mắt dung nham"
  },
  Event_7267_ChoiceDesc1 = {Text = "[đi]"},
  Event_7267_Desc = {
    Text = "Chim quạ cắn xé lông của chính mình, giống như con người cắn xé thân thể của chính họ. \nTrong thế giới đầy sợ hãi này, điều này xảy ra rất thường xuyên. Bạn không thể cứu được tất cả chúng sinh."
  },
  Event_7267_Name = {
    Text = "Nước mắt dung nham"
  },
  Event_7268_ChoiceDesc1 = {
    Text = "[rời đi] nhận được sáng tạo \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7268_Desc = {
    Text = "\"Tôi sẽ đưa các học sinh trở lại.\" Cô gái kéo góc váy của thân thể được đánh thức, nói với sự tự tin, \"Chăm sóc bản thân nhé... Đừng rơi xuống biển đấy.\""
  },
  Event_7268_Name = {
    Text = "Bảo hộ của Thánh Nữ Hàng Hải"
  },
  Event_7269_ChoiceDesc1 = {Text = "[đi]"},
  Event_7269_Desc = {
    Text = "Hì hì, màu đen, màu mà tôi yêu thích nhất. Bất trật tự, hỗn loạn, đau khổ… bạn lẽ ra đã biết từ lâu rồi, màu đen không phải là điềm lành. \nVậy, lựa chọn tiếp theo của bạn là gì?"
  },
  Event_7269_Name = {
    Text = "Buổi biểu diễn bắt đầu"
  },
  Event_7270_ChoiceDesc1 = {
    Text = "[ấn giữ quạ] nhận được 25 dấu đen, bị nhiễm [(Skill.Arg2)], tiếp tục chọn"
  },
  Event_7270_ChoiceDesc2 = {
    Text = "[bỏ mặc] rời đi"
  },
  Event_7270_Desc = {
    Text = "Con quạ cô đơn khàn giọng, tự nhổ từng chiếc lông đen của mình. \nNó run rẩy vì đau đớn, kêu lên những tiếng thét chói tai, nhưng không thể dừng lại hành động ngày càng nhanh của mình. \n \"Ga—— Ga——\"\nTrong mắt nó chảy ra những giọt nước mắt xanh thẳm hòa lẫn với chất dịch đen, ngoài bạn ra, không ai chứng kiến."
  },
  Event_7270_Name = {
    Text = "Nước mắt dung nham"
  },
  Event_7271_ChoiceDesc1 = {
    Text = "[rời đi] chọn 1 thẻ lệnh từ 3 thẻ lệnh để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_7271_Desc = {
    Text = "Đó là sâu trong khoang tàu đã lâu không được sửa chữa, thiếu ánh sáng và sự dẫn lối. \nCô gái sẽ khởi hành với lời chúc phúc thiêng liêng từ Thánh nữ hàng hải, một lời thề đầy ý nghĩa giữa họ."
  },
  Event_7271_Name = {
    Text = "Bảo hộ của Thánh Nữ Hàng Hải"
  },
  Event_7272_ChoiceDesc1 = {
    Text = "[Theo đuổi giai điệu] Chọn 1 thẻ lệnh từ 3 thẻ để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_7272_ChoiceDesc2 = {
    Text = "[theo đó mà hát] nhiễm [(Skill.Arg1)], lại ngẫu nhiên khắc ấn"
  },
  Event_7272_Desc = {
    Text = "Tiếng hát xa xôi bị vỡ thành vài mảnh sao rơi: \n \"Tôi nguyền rủa vũng nước đục trong con hẻm u ám, nơi gốc tường đổ nát điểm xuyết những bông hoa thối rữa. Xích sắt quấn quanh não bộ rồi kéo xuống bùn lầy. Trước khi sương mù xóa sạch sự tồn tại của tôi, hoàng hôn sẽ chìm vào @3 sâu thẳm nhất.\""
  },
  Event_7272_Name = {
    Text = "Lời nguyền chất trắng"
  },
  Event_7273_ChoiceDesc1 = {
    Text = "[Theo đuổi giai điệu] Chọn 1 thẻ lệnh từ 3 thẻ để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_7273_Desc = {
    Text = "Giọng hát xa xôi bị vỡ vụn thành vài điểm sao: \n \"Tôi nguyền rủa một vũng nước bẩn trong con hẻm tối, nơi gốc tường sụp đổ được điểm xuyết bởi những bông hoa thối nát, xiềng xích quấn lấy tâm trí rồi kéo xuống bùn lầy. Trước khi làn sương dày đặc xóa sạch sự tồn tại của tôi, hoàng hôn sẽ chìm vào @4 sâu thẳm nhất.\""
  },
  Event_7273_Name = {
    Text = "Lời nguyền chất trắng"
  },
  Event_7274_ChoiceDesc1 = {Text = "[đi]"},
  Event_7274_Desc = {
    Text = "Bạc tâm không phản hồi lời thức tỉnh của bạn, nhưng phát ra hơi ấm áp."
  },
  Event_7274_Name = {
    Text = "bạc tâm cô đơn"
  },
  Event_7275_ChoiceDesc1 = {Text = "[đi]"},
  Event_7275_Desc = {
    Text = "Khói đen quấn quanh cột sống, tới khi ngã xuống đất, bạn vẫn lặp đi lặp lại câu nói này."
  },
  Event_7275_Name = {
    Text = "Không được nhìn trực tiếp"
  },
  Event_7276_ChoiceDesc1 = {Text = "[đi]"},
  Event_7276_Desc = {
    Text = "Đúng vậy, chất lỏng thủy tinh từ còng kinh từ từ chảy ra, là bằng chứng bạn bị cấm kỵ ăn mòn. \n Trung thực, vào lúc này đã trở nên xa lạ với đức hạnh."
  },
  Event_7276_Name = {
    Text = "Không được nhìn trực tiếp"
  },
  Event_7277_ChoiceDesc1 = {Text = "[đi]"},
  Event_7277_Desc = {
    Text = "Đồng tiền cổ ẩm ướt và dơ bẩn, tựa như những gì bị nôn ra, tỏa ra khí đen có thể thấy rõ."
  },
  Event_7277_Name = {
    Text = "Đồng tiền cổ hai mặt"
  },
  Event_7278_ChoiceDesc1 = {Text = "[đi]"},
  Event_7278_Desc = {
    Text = "Những sợi thần kinh nhạy bén phát ra lời cảnh báo nguy hiểm, bạn giật mình và buộc phải rút tay lại. \nLại để bạn thoát... \nLời nguyền? Hay là một cuộc tái sinh?"
  },
  Event_7278_Name = {
    Text = "Đồng tiền cổ hai mặt"
  },
  Event_7279_ChoiceDesc1 = {
    Text = "[Thả bướm bay] Chọn 1 trong 3 thẻ lệnh nhận được Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7279_ChoiceDesc2 = {
    Text = "[trở thành bướm] được nhận món đồ tạo tác bằng bạc \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7279_ChoiceDesc3 = {
    Text = "[nuốt vào bụng] nhận được 25 dấu đen"
  },
  Event_7279_Desc = {
    Text = "Đêm nay đã xảy ra quá nhiều chuyện. \n Cảng bị tấn công, tàu ma, người dấn thân vào biển, tulô, Muphí, Ramona…… mọi thứ đều xoay tròn trong Vortex, bị khuấy lên như cháo yến mạch lúc bảy giờ sáng tại nhà hàng Misaque. \n Muốn hỏi người Thể thức tỉnh trước mặt, nhưng không biết phải bắt đầu từ đâu, như bị mắc nghẹn — hoặc nói cách khác, như bướm trong dạ dày."
  },
  Event_7279_Name = {
    Text = "Hiệu ứng bướm"
  },
  Event_7280_ChoiceDesc1 = {
    Text = "[Giải trừ ảo ảnh] mất (Arg3) điểm sức sống."
  },
  Event_7280_ChoiceDesc2 = {Text = "[đi]"},
  Event_7280_Desc = {
    Text = "Những khuôn mặt mờ ảo đột nhiên xuất hiện, chúng vây quanh bạn và tuyệt vọng rên rỉ bằng những dây thanh âm không tồn tại."
  },
  Event_7280_Name = {Text = "ảo ảnh"},
  Event_7281_ChoiceDesc1 = {
    Text = "[Tham gia cầu nguyện] nhận được bạc sáng tạo \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7281_ChoiceDesc2 = {
    Text = "[chìm xuống biển] nhận được vật tạo vàng \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\", \"(Skill.Arg3)\""
  },
  Event_7281_ChoiceDesc3 = {
    Text = "[lên mặt nước] nhận được 25 dấu đen"
  },
  Event_7281_Desc = {
    Text = "\"Thần minh ôn nhu, thần minh tối cao. \nXin ngài làm dịu cơn bão dữ dội, xin ngài chặn dòng nước chảy xiết. \nHãy để đại dương trở thành ngôi nhà sâu thẳm của chúng tôi, hãy để nó phủ lên quốc gia của chúng tôi bức màn bất tận...\"\nLời thì thầm của tín đồ dần trở nên rõ ràng với bạn, nhưng kèm theo đó là cảm giác ngột ngạt khó tan biến."
  },
  Event_7281_Name = {
    Text = "Lời cầu nguyện giấc mơ"
  },
  Event_7282_ChoiceDesc1 = {Text = "[đi]"},
  Event_7282_Desc = {
    Text = "Bạn ném miếng thịt còn lại trong tay vào bầy mèo. \n Đám mèo như một đợt sóng đen ùa tới. Chúng điên cuồng cắn xé miếng thịt, rồi nhanh chóng tản ra. \n Thật không may, đây là một miếng thịt hết hạn. Nó có thể lấp đầy cái bụng rỗng, nhưng không làm người ta cảm thấy thoải mái."
  },
  Event_7282_Name = {
    Text = "Thành phố mèo"
  },
  Event_7283_ChoiceDesc1 = {
    Text = "[thu vào túi]"
  },
  Event_7283_Desc = {
    Text = "Một chất bạc có trạng thái gần như thủy ngân, được chiết xuất từ dịch nhầy rỗng rỗng, mang trong mình sức mạnh tinh thần lớn, dùng chủ yếu để liên kết nhiều thân thể được đánh thức hơn trong các nghi lễ."
  },
  Event_7283_Name = {Text = "bạc tâm"},
  Event_7284_ChoiceDesc1 = {
    Text = "[Rời đi] Chọn một thân thể được đánh thức và giảm 2 điểm tiêu thụ sức tính toán của thẻ thức tỉnh. Nhiễm [(Skill.Arg1)]"
  },
  Event_7284_ChoiceDesc2 = {Text = "[đi]"},
  Event_7284_Desc = {
    Text = "Có thể lúc này vẫn chưa thể truyền đạt, nhưng họ sẽ nghe thấy tiếng kêu gọi của các bạn sớm muộn thôi."
  },
  Event_7284_Name = {
    Text = "Giọng dẫn đường"
  },
  Event_7285_ChoiceDesc1 = {Text = "[đi]"},
  Event_7285_Desc = {
    Text = "Thí nghiệm lang thang đã khiến bạn vô cùng mệt mỏi, một chút thở phào cũng giống như nước mát trong sa mạc khô cằn."
  },
  Event_7285_Name = {
    Text = "Cánh cửa vô tận"
  },
  Event_7286_ChoiceDesc1 = {
    Text = "[ Rời đi ] Ngẫu nhiên đánh thức 1 thân thể được kích hoạt"
  },
  Event_7286_ChoiceDesc2 = {Text = "[đi]"},
  Event_7286_Desc = {
    Text = "Giọng nói đó chắc chắn sẽ dẫn các người đến hồi kết, câu trả lời cho chuyến điều tra này."
  },
  Event_7286_Name = {
    Text = "Giọng dẫn đường"
  },
  Event_7287_ChoiceDesc1 = {
    Text = "[quan sát kỹ lưỡng]"
  },
  Event_7287_Desc = {
    Text = "Qua quả cầu thủy tinh, bạn có thể quan sát phía xa"
  },
  Event_7287_Name = {
    Text = "Bóng tinh thể"
  },
  Event_7288_ChoiceDesc1 = {
    Text = "[xua đuổi quạ] nhận Arg1 dấu đen, nhiễm [(Skill.Arg2)], tiếp tục chọn"
  },
  Event_7288_ChoiceDesc2 = {
    Text = "[bỏ qua] rời đi"
  },
  Event_7288_Desc = {
    Text = "Chim quạ dừng lại trên tủ quần áo, mỏ nhọn khắc lên cửa gỗ những đường nét kỳ quái."
  },
  Event_7288_Name = {
    Text = "Đèn lồng quạ đen"
  },
  Event_7289_ChoiceDesc1 = {Text = "[đi]"},
  Event_7289_Desc = {
    Text = "Bạn đã nhận được yêu cầu liên lạc từ trường, giọng nói quen thuộc giúp tâm trạng bạn bình yên lại. Bạn lấy lại tinh thần và tiếp tục tiến lên."
  },
  Event_7289_Name = {
    Text = "điểm liên lạc"
  },
  Event_7290_ChoiceDesc1 = {
    Text = "[dừng lại tại đây] nhận được bạc tạo vật [(RelicConfig.Arg1)]"
  },
  Event_7290_ChoiceDesc2 = {
    Text = "[Tìm kiếm lối ra] nhận được vật tạo vàng \"(RelicConfig.Arg1)\", bị ảnh hưởng bởi \"(Skill.Arg2)\""
  },
  Event_7290_Desc = {
    Text = "Bạn bước vào một không gian yên tĩnh màu trắng nhợt, những cánh cửa chồng chéo nhau xoay tròn một cách vô độ, như một cơn xoáy cuốn cơ thể bạn vào trong. \n Bạn chóng mặt vật lộn bên trong những cánh cửa đảo ngược, mơ hồ nhận ra hướng thoát, nhưng không thể tránh khỏi việc một lần nữa rơi vào một cánh cửa khác. \n Lần này, bạn lại dừng lại trước một cánh cửa, phía sau cánh cửa là sự cuồn cuộn của điều không biết phát ra sức hút chết người, nhưng lý trí của bạn lại căng thẳng. \n Đúng vậy, nó thực sự là chết người."
  },
  Event_7290_Name = {
    Text = "Ngoài cửa nặng"
  },
  Event_7291_ChoiceDesc1 = {
    Text = "[trong cơn cuồng hỉ] xóa 1 thẻ lệnh và hồi phục Arg1 điểm sức sống"
  },
  Event_7291_ChoiceDesc2 = {
    Text = "[dừng lại] nhận được vật tạo vàng \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7291_Desc = {
    Text = "Như thể xương sọ bị mở ra một cách dễ dàng, trong đầu bạn dâng lên cơn chóng mặt như nôn mửa, những bàn tay vô hình lật qua lật lại não bộ, những chất liệu vốn đã gần như trở thành thể lỏng vỡ vụn thành một vũng. \n Giống như những chất thải dạng bột chưa được tiêu hóa trong dạ dày, đã thoát khỏi lực hấp dẫn, tràn vào vỏ não trống rỗng và nghèo nàn của bạn. \n Nó nhào nặn, trộn lẫn, vò xé, rắc lên những mảnh vụn hạnh phúc, hòa quyện những tàn tích của hoàng hôn vào trong thịt."
  },
  Event_7291_Name = {
    Text = "Khuấy động não bộ"
  },
  Event_7292_ChoiceDesc1 = {Text = "[đi]"},
  Event_7292_Desc = {
    Text = "So với việc một con chó địa ngục xuất hiện đột ngột, tuyết rơi bình thường không đáng để bạn tập trung năng lượng. Bạn bỏ qua những bông tuyết đang từ từ rơi xuống và lao vào đêm tối."
  },
  Event_7292_Name = {Text = "Tuyết"},
  Event_7293_ChoiceDesc1 = {
    Text = "[Kết nối] phục hồi Arg2 điểm sức sống."
  },
  Event_7293_Desc = {
    Text = "Bạn đang khám phá trong sương mù, đột nhiên, huy hiệu trường trên ngực bạn phát ra ánh sáng bạc yếu ớt. Ai đang gọi bạn từ bên kia thiết bị liên lạc?"
  },
  Event_7293_Name = {
    Text = "điểm liên lạc"
  },
  Event_7294_ChoiceDesc1 = {
    Text = "[cảm thấy sợ hãi] nhận được vật tạo vàng \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7294_ChoiceDesc2 = {
    Text = "[Ý chí kiên định] Từ 3 thẻ lệnh, chọn 1 để nhận khắcăng: \"(EnchantConfig.Arg1)\""
  },
  Event_7294_Desc = {
    Text = "Tiếng rên rỉ kỳ quái vang vọng không dứt, nhưng mọi thứ ở Lentiennam lại không có phản ứng gì, như thể đã chết, hoặc đang ngủ say. \n Bạn vô thức lang thang dưới cầu đường sắt, hồi tưởng lại lời dặn của Alistair. \n Anh ấy lịch sự đứng dậy đi tới, dường như đang nói gì đó với bạn, nhưng lời nói lại lắp bắp không rõ ràng. \n Bạn ngẩng đầu, những giọt dịch màu đen đặc sệt chảy ra từ miệng anh ta, chặn lại cổ họng của anh, làm tắc nghẽn câu nói của anh——"
  },
  Event_7294_Name = {
    Text = "Hỗn loạn than khóc"
  },
  Event_7295_ChoiceDesc1 = {
    Text = "[rời đi] nhận được 1 trong 3 khắcăng"
  },
  Event_7295_Desc = {
    Text = "\"Đương nhiên rồi, không cần phải nói. Nếu không phiền, tôi sẽ sẵn sàng giúp đỡ các bạn một tay.\"\nÔng ấy đưa cho các bạn một chiếc gương cầm tay mang vẻ cổ xưa.\n \"Hiệp sĩ đã bước lên bàn cờ, và nhà vua cũng sẽ không chờ đợi quá lâu trong cuối trận. Các bạn có lẽ sẽ sớm gặp ông ấy thôi. Thật sự rất đáng mong đợi.\""
  },
  Event_7295_Name = {
    Text = "Khách đồng hành kỳ quái Ⅳ"
  },
  Event_7296_ChoiceDesc1 = {
    Text = "[xé nát thư] xóa bỏ 2 thẻ bài"
  },
  Event_7296_ChoiceDesc2 = {
    Text = "[Tiếp tục đọc] nhận được vật bị nguyền rủa \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7296_ChoiceDesc3 = {
    Text = "[Rời đi] Nhận được Arg1 dấu đen"
  },
  Event_7296_Desc = {
    Text = "Trước mắt bạn là đàn bướm đen đang phun trào, chúng liên tục tràn ra, vỗ cánh, rồi lại rơi xuống bàn viết. \n Những tờ giấy viết thư trắng trải ra bị bắn đầy mực, những con bướm bị thương, thoi thóp nằm trên bề mặt giấy. \n Chất lỏng đen dính trên cánh nối lại thành từng đoạn, được viết thành những chữ cấm kỵ. \n Bạn rút tờ giấy này ra từ máy đánh chữ."
  },
  Event_7296_Name = {
    Text = "Chương mục Bướm"
  },
  Event_7297_ChoiceDesc1 = {
    Text = "[ Chào đón bướm] xóa 1 thẻ lệnh, nhận Arg1 dấu đen"
  },
  Event_7297_ChoiceDesc2 = {
    Text = "[không còn lưu luyến]"
  },
  Event_7297_Desc = {
    Text = "Gần đây, ở Lentiennam có một câu nói đang thịnh hành: \"Một lần vỗ cánh của con bướm ở khu rừng Akutê có thể gây ra một cơn bão ở Vương quốc Leo.\"\nKhi nhìn thấy bướm tuôn ra, bạn không khỏi nhớ đến câu nói đó. \nNhững con bướm này, có lẽ đủ để tạo nên một thảm họa nhấn chìm cả hành tinh."
  },
  Event_7297_Name = {
    Text = "Bão Linh Tri Thức"
  },
  Event_7298_ChoiceDesc1 = {
    Text = "[rời đi] nhận được 50 dấu đen"
  },
  Event_7298_Desc = {
    Text = "Bạn đặt một ngón tay lên khóe môi, ra hiệu rằng bạn sẽ giữ im lặng về việc này. \nHình bóng của một con mèo đen lướt qua nhanh như chớp, để lại một món quà sáng bóng màu đen bên chân bạn."
  },
  Event_7298_Name = {
    Text = "Đám tai ương của mèo đêm"
  },
  Event_7299_ChoiceDesc1 = {Text = "[đi]"},
  Event_7299_Desc = {
    Text = "Ngài ấy trượt vào túi xách của bạn như một đoạn lụa, cùng với trọng lượng nhẹ tăng lên, bạn có thể nghe thấy một lời cảm ơn khẽ vang lên. \nTừ đó, không còn âm thanh nào vang lên nữa."
  },
  Event_7299_Name = {
    Text = "Lin hồn hỗn loạn"
  },
  Event_7300_ChoiceDesc1 = {Text = "[đi]"},
  Event_7300_Desc = {
    Text = "Khóc lóc của Linh hồn Hỗn loạn càng lúc càng sắc nhọn, cho đến cuối cùng biến thành tiếng thét chói tai vang vọng xung quanh. \nNgài mang theo lễ vật của bạn và nỗi đau khổ không lối thoát, một lần nữa chìm vào bùn lầy tối tăm."
  },
  Event_7300_Name = {
    Text = "Lin hồn hỗn loạn"
  },
  Event_7301_ChoiceDesc1 = {
    Text = "[như đã kê khai]"
  },
  Event_7301_ChoiceDesc2 = {
    Text = "[viết bừa bãi]"
  },
  Event_7301_Desc = {
    Text = "Phố phường ở khu đông phức tạp rối rắm, không lâu sau bạn đã mất dấu những đứa trẻ. \nKhi bạn đang bối rối không biết phải làm gì, một người phụ nữ bí ẩn tiếp cận bạn. \n \"Tôi biết các em nhỏ đã đi đâu, nhưng trước khi nói cho bạn, liệu bạn có thể giúp tôi một việc nhỏ được không?\"\nCô ta lấy ra một tờ giấy, mỉm cười thân thiện với bạn. \n \"Tôi tên là Clementine, là một bác sĩ tâm lý, đang tiến hành điều tra tâm lý cư dân của Lentiennam. Nếu bạn có thể giúp tôi hoàn thành bản câu hỏi này. \nNếu trả lời trung thực, tôi sẽ rất vui lòng giúp đỡ bạn và đồng đội của bạn.\""
  },
  Event_7301_Name = {
    Text = "Đánh giá tâm lý"
  },
  Event_7302_ChoiceDesc1 = {Text = "[đi]"},
  Event_7302_Desc = {
    Text = "\"Đây cũng là lựa chọn của tôi.\" Hình bóng cầm kẹo nói, \"Nhưng cô ấy sẽ trở thành quân cờ của anh ta, bạn sẽ phải đưa ra lựa chọn. \nTrên đời này không có kết thúc hoàn hảo nào cả.\"\nBạn bị nhấn chìm trong nỗi buồn sâu sắc. Hình bóng tan biến. Bạn ôm ngực, không biết vừa rồi là hình ảnh ảo hay chỉ là ảo giác do áp lực tinh thần quá lớn."
  },
  Event_7302_Name = {
    Text = "Đường phân nhánh"
  },
  Event_7303_ChoiceDesc1 = {
    Text = "[rìu vàng]"
  },
  Event_7303_ChoiceDesc2 = {
    Text = "[Axe bạc]"
  },
  Event_7303_ChoiceDesc3 = {
    Text = "[Tôi không làm rơi đồ]"
  },
  Event_7303_Desc = {
    Text = "\"Người tiên phong vượt qua chiều kích.\"\nGiọng nói già nua vang lên bên tai, như từ thời tiền sử, như đã vượt qua hàng triệu năm.\nTrong cơn căng thẳng tột độ, bạn nghe thấy giọng nói đó hỏi một câu hỏi quen thuộc.\n \"Cái rìu vàng hay cái rìu bạc mà bạn làm rơi?\""
  },
  Event_7303_Name = {
    Text = "Giọng ngoài thế giới"
  },
  Event_7304_ChoiceDesc1 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_7304_Desc = {
    Text = "\"Ôi, này...\" Cô ấy thu lại bản khảo sát, lộ ra vẻ mặt có chút bất lực, \"Thôi kệ, dù sao cậu cũng đang vội. Bọn trẻ đi về phía đó, chắc chưa đi xa.\"\nBạn vội vàng quay người, suýt nữa không nghe rõ lời thì thầm từ phía sau.\n \"Dù sao, chúng ta sẽ gặp lại nhau.\""
  },
  Event_7304_Name = {
    Text = "Đánh giá tâm lý"
  },
  Event_7305_ChoiceDesc1 = {Text = "[đi]"},
  Event_7305_Desc = {
    Text = "\"Bạn là ai?\"\n \"Tôi là bóng tối của người giữ chìa khóa bạc bị sát hại, kẻ giết người là một con rắn bạch tạng xảo quyệt.\"\n \"Rắn bạch tạng? Đó là gì?\"\n \"Một sai lầm. Một sự phỉ báng tự nhiên sinh ra từ sự lai tạo giữa người và rắn.\"\nBạn còn muốn tiếp tục truy hỏi, nhưng bóng tối chợt tan biến, để lại một lớp bụi vàng trên mặt đất."
  },
  Event_7305_Name = {
    Text = "Người sử dụng chìa khóa bạc"
  },
  Event_7306_ChoiceDesc1 = {
    Text = "[bị nhiễm 「(Skill.Arg1)」, nhận được vật tạo vàng 「(RelicConfig.Arg2)」]"
  },
  Event_7306_ChoiceDesc2 = {
    Text = "[rời đi] nhận được 50 dấu đen"
  },
  Event_7306_Desc = {
    Text = "Sự kiện 355 (đang phát triển), không phải là kết quả cuối cùng"
  },
  Event_7306_Name = {
    Text = "Sự kiện 355 (đang phát triển)"
  },
  Event_7307_ChoiceDesc1 = {Text = "[đi]"},
  Event_7307_Desc = {
    Text = "Chìm vào dạ dày, cùng với bướm bay múa. \n Những mảnh vảy tư tưởng và bướm đan xen rơi xuống, trong dạ dày bắt đầu một trận tuyết trắng lả tả. \n Bạn dần dần làm rõ mọi thứ, khi cơ hội tiếp theo đến, bạn nhất định sẽ lên tiếng."
  },
  Event_7307_Name = {
    Text = "Hiệu ứng bướm"
  },
  Event_7308_ChoiceDesc1 = {
    Text = "[Phản bác chúng] nhiễm \"(Skill.Arg1)\", ngẫu nhiên một thẻ bài nhận khắcăng: \"(EnchantConfig.Arg2)\""
  },
  Event_7308_ChoiceDesc2 = {
    Text = "[đồng lòng với chúng] nhiễm \"(Skill.Arg1)\", một thẻ bài ngẫu nhiên có được khắcăng: \"(EnchantConfig.Arg2)\""
  },
  Event_7308_ChoiceDesc3 = {
    Text = "[Đưa ra quan điểm mới] Từ 3 thẻ lệnh, chọn 1 thẻ để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_7308_Desc = {
    Text = "\"Hãy giữ khoảng cách với chúng tôi.\"\nMột đàn chuột bao vây bạn ở giữa, giữ khoảng cách ít nhất năm feet. \n \"Chúng tôi nỗ lực sinh sôi, chúng tôi phát triển mạnh mẽ, chúng tôi không kén ăn — vì vậy chúng tôi mang đến cho con người bệnh tật, lo lắng và đau khổ.\"\n \"Chúng tôi và con người không nên đến gần nhau, đây không phải là nơi bạn nên đến.\"\nĐể làm cho đàn chuột giảm bớt cảnh giác, bạn quyết định —"
  },
  Event_7308_Name = {
    Text = "Bệnh dịch hạch"
  },
  Event_7309_ChoiceDesc1 = {
    Text = "[Mở cửa sắt] Nhiễm \"(Skill.Arg1)\", nhận được vật tạo vàng \"(RelicConfig.Arg2)\""
  },
  Event_7309_ChoiceDesc2 = {
    Text = "[không để ý] nhận được 50 dấu đen"
  },
  Event_7309_Desc = {
    Text = "Đây là một cây cầu vòm kiểu hạ thụ, cầu thang bên cạnh đường sắt mờ mờ dẫn đến một cánh cửa sắt. Âm thanh cộc cộc đều đặn và bất thường phát ra từ phía sau cánh cửa. \n Bạn dừng lại quan sát cánh cửa, chỉ thấy trên đó treo một ổ khóa nặng nề, nhưng không được khóa lại."
  },
  Event_7309_Name = {
    Text = "Sau cánh cửa sắt"
  },
  Event_7310_ChoiceDesc1 = {
    Text = "[rời đi] bị nhiễm [(Skill.Arg1)], nhận được 50 dấu đen"
  },
  Event_7310_Desc = {
    Text = "Đối mặt với cám dỗ, bạn không động lòng.\nChủ nhân của giọng nói rất tiếc nuối, mặt nước lững lờ gợn lên vài gợn sóng, không còn gợn sóng nào khác."
  },
  Event_7310_Name = {
    Text = "Giọng ngoài thế giới"
  },
  Event_7311_ChoiceDesc1 = {
    Text = "[bị nhiễm 「(Skill.Arg1)」, nhận được vật tạo vàng 「(RelicConfig.Arg2)」]"
  },
  Event_7311_ChoiceDesc2 = {
    Text = "[rời đi] nhận được 50 dấu đen"
  },
  Event_7311_Desc = {
    Text = "Sự kiện 353 (đang phát triển), chưa phải hiệu ứng cuối cùng"
  },
  Event_7311_Name = {
    Text = "Sự kiện 353 (trong quá trình phát triển)"
  },
  Event_7312_ChoiceDesc1 = {
    Text = "[rời đi] bị nhiễm [(Skill.Arg1)], nhận được 50 dấu đen"
  },
  Event_7312_Desc = {
    Text = "\"Các người loài người không còn câu trả lời nào khác sao?\"\nChủ nhân của giọng nói phát ra tiếng gầm thấp đầy bực bội, cả không gian rung động theo. \n \"Tham lam và ngớ ngẩn... Đây chính là lý do tôi chán ghét các người.\""
  },
  Event_7312_Name = {
    Text = "Giọng ngoài thế giới"
  },
  Event_7313_ChoiceDesc1 = {Text = "[đi]"},
  Event_7313_Desc = {
    Text = "Chấp nhận sự sắp xếp của thâm cảnh, được mất đan xen, tận hưởng vòng ôm bị nguyền rủa."
  },
  Event_7313_Name = {
    Text = "Sóng cuồng loạn"
  },
  Event_7314_ChoiceDesc1 = {Text = "[đi]"},
  Event_7314_Desc = {
    Text = "Đôi mắt từ từ chớp một cái, không biết có hiểu được câu hỏi của bạn hay không. \n Một giọt nước mắt vàng đỏ từ khóe mắt rơi xuống, như một ngôi sao nhỏ bé, phát ra ánh sáng ấm áp như mặt trời. Nó rơi xuống, rơi xuống, mang theo nỗi buồn, mang theo sự thương xót, vỡ thành một mảnh bụi nhỏ trên viên gạch. \n Bạn bỗng nhiên tỉnh táo lại, đôi mắt đó đã không còn."
  },
  Event_7314_Name = {
    Text = "Nhìn mù quáng"
  },
  Event_7315_ChoiceDesc1 = {Text = "[đi]"},
  Event_7315_Desc = {
    Text = "Mấy đứa trẻ mặc đơn giản, thậm chí lấm lem đang chạy trên đường, phía sau có một người lớn mặc quần áo cảnh sát đuổi theo. Trong số đó, có một đứa trẻ đội mũ nâu khiến bạn có chút quen mắt."
  },
  Event_7315_Name = {
    Text = "Kí ức của chúng tôi"
  },
  Event_7316_ChoiceDesc1 = {Text = "[đi]"},
  Event_7316_Desc = {
    Text = "\"Đừng hát nữa——\"\nBạn cảnh cáo người hát không đúng nhạc, đừng hòng làm tổn hại đến tai của bạn."
  },
  Event_7316_Name = {
    Text = "Kẻ ác trên con đường hẹp"
  },
  Event_7317_ChoiceDesc1 = {Text = "[đi]"},
  Event_7317_Desc = {
    Text = "\"Dừng lại!!! Quái vật rỗng rỗng bò lê còn quen thuộc với tứ chi của mình hơn cả bạn!\"\nThả qua khán giả...\nBạn cầu nguyện trong lòng như vậy."
  },
  Event_7317_Name = {
    Text = "Kẻ ác trên con đường hẹp"
  },
  Event_7318_ChoiceDesc1 = {Text = "[đi]"},
  Event_7318_Desc = {
    Text = "Dịch đen rơi trên mặt bạn, gây cảm giác ngứa ngáy. \nBạn không thể chịu đựng được, vung tay đập con bướm. \nCon bướm tránh khỏi hành động không thiện chí của bạn và biến mất ở cuối đường."
  },
  Event_7318_Name = {
    Text = "Điều không nên tồn tại"
  },
  Event_7319_ChoiceDesc1 = {
    Text = "[khen ngợi nó] chọn 1 thẻ lệnh từ 3 thẻ để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_7319_Desc = {
    Text = "Jenkin nói: Mau tỉnh lại đi, Johnny! Việc viết thơ không thể trả nợ bạn đã mắc, cũng không giải quyết được vấn đề sàn nhà của bạn bị rò rỉ nước. \n Bạn nói: Thật không may, những tế bào theo đuổi sự thật của bạn sẽ chết đi với tốc độ 100.000 mỗi ngày, rất nhanh bạn sẽ trở thành một cái não thực sự. \n Não vô tư nhún vai - nếu nó có. \n Não nói: Tôi tư duy, vì vậy tôi tồn tại. Khi bạn có thể đạt được độ sâu tư tưởng như tôi, bạn sẽ không còn quan tâm đến não nữa."
  },
  Event_7319_Name = {
    Text = "Não triết học"
  },
  Event_7320_ChoiceDesc1 = {Text = "[đi]"},
  Event_7320_Desc = {
    Text = "Piano phát ra một tiếng thở dài nhẹ nhàng, như là an ủi, lại như là lưu luyến, giống hệt nụ cười của ai đó khi một bản nhạc kết thúc. \n \"Chỉ cần các em... chỉ cần...\"\nBạn còn chưa kịp nghe rõ, hình bóng piano đã tan biến theo gió."
  },
  Event_7320_Name = {
    Text = "Melodi tuổi thơ"
  },
  Event_7321_ChoiceDesc1 = {
    Text = "[rời đi] nhận được 1 trong 3 bạc tạo vật, bị nhiễm [(Skill.Arg1)]"
  },
  Event_7321_Desc = {
    Text = "Bạn nhận lấy cuốn bệnh án dày và mở ra, phát hiện trang bìa có viết \"G·R\" hai chữ. \n \"Ôi, ôi, đây không phải là bệnh án của bạn sao?\" Clementine dường như không hề bận tâm, \"Nhưng, tìm hiểu tâm lý người khác cũng giúp chúng ta hiểu rõ hơn về chính mình.\"\n Bạn chưa kịp hỏi, cô ấy đã biến mất hoàn toàn."
  },
  Event_7321_Name = {
    Text = "sổ bệnh án"
  },
  Event_7322_ChoiceDesc1 = {
    Text = "[Rời đi] Chọn 1 thân thể được đánh thức, bị nhiễm [(Skill.Arg1)]"
  },
  Event_7322_Desc = {
    Text = "Bạn nhận lấy cuốn bệnh án mỏng và mở ra, phát hiện bên trong chỉ có một tờ giấy, trên đó chỉ viết một câu. \n \"Trong hỗn loạn cổ xưa, đôi mắt trắng vô hình luôn dõi theo vĩnh hằng.\"\nBạn muốn hỏi Clementine, nhưng phát hiện cô ấy đã biến mất từ lâu."
  },
  Event_7322_Name = {
    Text = "sổ bệnh án"
  },
  Event_7323_ChoiceDesc1 = {
    Text = "[Kết nối] trả lại tất cả sức sống."
  },
  Event_7323_ChoiceDesc2 = {
    Text = "[Thiền định] Chọn 1 thân thể được đánh thức để tiến hành thức tỉnh."
  },
  Event_7323_Desc = {
    Text = "Bạn đang khám phá trong sương mù, đột nhiên, huy hiệu trường trên ngực bạn phát ra ánh sáng bạc yếu ớt. Ai đang gọi bạn từ bên kia thiết bị liên lạc?"
  },
  Event_7323_Name = {
    Text = "điểm liên lạc"
  },
  Event_7324_ChoiceDesc1 = {Text = "[đi]"},
  Event_7324_Desc = {
    Text = "Chứng cứ quan trọng, nên bảo quản cẩn thận, giao cho khoa Lịch sử nghiên cứu và phân tích."
  },
  Event_7324_Name = {
    Text = "Mật lệnh·Thượng"
  },
  Event_7325_ChoiceDesc1 = {Text = "[đi]"},
  Event_7325_Desc = {
    Text = "Ánh nắng chói chang từ bầu trời cao chiếu rọi khắp mặt đất, xuyên thủng sự mê hoặc, thức tỉnh những linh hồn mệt mỏi."
  },
  Event_7325_Name = {Text = "Góc nâng"},
  Event_7326_ChoiceDesc1 = {Text = "[đi]"},
  Event_7326_Desc = {
    Text = "Bạn cảm thấy thỏa mãn, ánh mắt dòm ngó của Họ lấp lánh trên bầu trời đêm phía trên đầu bạn, tập trung tầm nhìn vào chính bạn."
  },
  Event_7326_Name = {Text = "Mắt vòm"},
  Event_7327_ChoiceDesc1 = {Text = "[đi]"},
  Event_7327_Desc = {
    Text = "Bạn không thể trốn tránh ánh nhìn như ngồi trên đống kim, đương nhiên, cũng hoàn toàn không thể kháng cự món quà của các vị thần."
  },
  Event_7327_Name = {Text = "Mắt vòm"},
  Event_7328_ChoiceDesc1 = {
    Text = "[rời đi] nhận được sáng tạo \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7328_Desc = {
    Text = "\"Cậu rốt cuộc là ai?\" cậu kinh hoàng hỏi. \n \"Không cần quan tâm những điều này. Kẻ thù của kẻ thù chính là bạn, phải không?\" người đàn ông mỉm cười. \n \"Quà tặng đã để trên ghế, chúc các cậu may mắn.\""
  },
  Event_7328_Name = {
    Text = "Khách đồng hành kỳ quái Ⅳ"
  },
  Event_7329_ChoiceDesc1 = {Text = "[đi]"},
  Event_7329_Desc = {
    Text = "Ramona tiến lên, hy vọng nghe thêm tin về \"áo blouse trắng\". \"Có người đang nghe lén!\" tiếng hát từ máy hát đĩa bất ngờ lớn lên, \"nghe lén, nghe lén, nghe lén!\""
  },
  Event_7329_Name = {
    Text = "Tai người khác"
  },
  Event_7330_ChoiceDesc1 = {
    Text = "[rời đi] tất cả thân thể được đánh thức khôi phục Arg1 điên cuồng"
  },
  Event_7330_Desc = {
    Text = "Bạn nắm lấy bàn tay mềm mại của cậu bé, đi qua cửa này đến cửa khác, cuối cùng dừng lại trước một sân khấu nhỏ và cũ kỹ. \nCậu bé siết nhẹ tay bạn, để bày tỏ lòng biết ơn. \n \"Cảm ơn bạn, tạm biệt.\""
  },
  Event_7330_Name = {
    Text = "Lễ Kết Thúc Ⅱ"
  },
  Event_7331_ChoiceDesc1 = {
    Text = "[tiếp tục rơi] nhận được vật phẩm bạc [(RelicConfig.Arg1)], có tiếp tục rơi không"
  },
  Event_7331_ChoiceDesc2 = {
    Text = "[rút lui] nhận được 25 dấu đen"
  },
  Event_7331_Desc = {
    Text = "\"bạn\" mời gọi bạn. \nTrong lòng xoắn ốc, \"bạn\" từ quá khứ và tương lai gửi tặng bạn những \"món quà\" từ các chiều không gian khác nhau."
  },
  Event_7331_Name = {
    Text = "Vực thẳm xoắn ốc"
  },
  Event_7332_ChoiceDesc1 = {
    Text = "[giữ kín miệng] nhận được 25 dấu đen"
  },
  Event_7332_ChoiceDesc2 = {
    Text = "[đụng vào] 50% cơ hội nhận được 50 dấu đen, 50% cơ hội trắng tay"
  },
  Event_7332_Desc = {
    Text = "\"Tôi chỉ muốn nói một câu châm ngôn — không ai có thể giết chết một con mèo!\"\n \"Con mèo đen đáng chết kia đáng ra phải bị xẻo bụng, phơi xác trên đồng hoang, nhưng nó lại đào mở mộ phần gia tộc của tôi, ăn sạch những mảnh thịt thối rữa còn lại của con người, còn xương cốt và chi thể thì rơi rớt bốn phía.\"\n \"Dưới ánh nhìn lạnh lẽo của đôi mắt dọc, lớp mủ vàng nhạt nổi lên một mùi hôi thối, tôi lăn lộn trườn ra khỏi đó, tinh thần suy sụp vì bị ác mộng hành hạ.\"\n \"Chờ đã... các người định làm gì, tôi không điên! Tôi không! Các người chắc chắn đang muốn che giấu điều gì! Điều này là thật —\"\nĐúng vậy, điều này là thật, tiễn biệt bóng dáng của kẻ điên cuồng mất hút, bạn và con mèo đen yên lặng ngồi bên chân bạn liếc nhìn nhau."
  },
  Event_7332_Name = {
    Text = "Đám tai ương của mèo đêm"
  },
  Event_7333_ChoiceDesc1 = {Text = "[đi]"},
  Event_7333_Desc = {
    Text = "Bạn hỏi anh ấy vị trí của bảo tàng sáp. \n Thật kỳ lạ, tính cả lần này, tối nay các bạn đã gặp nhau năm lần rồi. Bạn đã châm lửa cho anh ấy năm lần, hỏi đường năm lần. \n Nhưng bạn vẫn không nhớ vị trí của bảo tàng sáp, cũng như bạn và anh ấy vẫn sẽ liên tục gặp nhau."
  },
  Event_7333_Name = {
    Text = "Hình bóng dưới đèn đường"
  },
  Event_7334_ChoiceDesc1 = {
    Text = "[Xua đuổi quạ] nhận được 25 dấu đen, bị lây nhiễm [(Skill.Arg2)], tiếp tục chọn"
  },
  Event_7334_ChoiceDesc2 = {
    Text = "[tiếp tục đuổi theo đứa trẻ] rời đi"
  },
  Event_7334_Desc = {
    Text = "Con quạ thứ ba đã rời đi, bay về nơi mắt không thể nhìn thấy, bay vào bóng tối vĩnh hằng."
  },
  Event_7334_Name = {
    Text = "Nhìn chằm chằm của Quạ Đen"
  },
  Event_7335_ChoiceDesc1 = {
    Text = "[rời đi] nhận được 75 dấu đen, bị nhiễm [(Skill.Arg2)]"
  },
  Event_7335_Desc = {
    Text = "Lông mềm mại trên xúc tu còn lưu lại sức sống ấm áp của Kume. \nĐó là ánh hoàng hôn cuối ngày, chút ấm áp thoáng qua rồi biến mất."
  },
  Event_7335_Name = {
    Text = "Nhiệt dư"
  },
  Event_7336_ChoiceDesc1 = {Text = "[đi theo]"},
  Event_7336_Desc = {
    Text = "Bạn cẩn thận tìm kiếm bức tường và cuối cùng đã phát hiện ra một lối vào cống ẩn sau bụi cỏ. Bạn chui qua cống, nhưng quái vật đã biến mất từ lâu, để lại sự tĩnh lặng đầy căng thẳng."
  },
  Event_7336_Name = {
    Text = "Đường cụt"
  },
  Event_7337_ChoiceDesc1 = {Text = "[đi]"},
  Event_7337_Desc = {
    Text = "Các loài chim có quy tắc riêng của chúng, chúng không hành động theo ý chí của bạn và bạn cũng không có quyền ảnh hưởng đến quy luật tự nhiên."
  },
  Event_7337_Name = {
    Text = "Quạ Cô Độc"
  },
  Event_7338_ChoiceDesc1 = {
    Text = "[Phản chiếu từ trên cao] nhận được 25 dấu đen"
  },
  Event_7338_ChoiceDesc2 = {
    Text = "[Bạn có ổn không?] Nhận được bạc sáng tạo \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7338_Desc = {
    Text = "\"Cậu, cậu có biết không... chủ quán mới chuyển đến bên cạnh, cô ấy luôn đóng cửa không ra ngoài... Hôm đó tôi mời cô ấy uống một cốc bia, sau khi bọt hoàn toàn biến mất, tôi đột nhiên phát hiện... trong cốc bia, cô ấy, cô ấy không có bóng!\""
  },
  Event_7338_Name = {
    Text = "Phân mảnh ký ức · bia"
  },
  Event_7339_ChoiceDesc1 = {Text = "[đi]"},
  Event_7339_Desc = {
    Text = "\"Tôi thật sự muốn hát lại cùng bạn...\"\nTiếng kêu điên cuồng méo mó của Sara đột ngột dừng lại, khuôn mặt biến dạng toát lên một chút bối rối."
  },
  Event_7339_Name = {
    Text = "\"chị Sasa\""
  },
  Event_7340_ChoiceDesc1 = {
    Text = "[rời đi] nhận được 50 dấu đen"
  },
  Event_7340_Desc = {
    Text = "\"Rất vui! Rất vui!\" Tiếng nói ồn ào, chói tai và đầy sự ngây thơ vang lên bên tai bạn,\"Tặng cho bạn, tặng cho bạn!\""
  },
  Event_7340_Name = {Text = "Elfo Đêm"},
  Event_7341_ChoiceDesc1 = {
    Text = "[Hồ sơ bệnh án dày]"
  },
  Event_7341_ChoiceDesc2 = {
    Text = "[Sổ bệnh án mỏng]"
  },
  Event_7341_Desc = {
    Text = "Một giọng nói khá quen thuộc gọi bạn lại, bạn nheo mắt nhưng không thể nhìn rõ hình dáng của cô ấy. \n \"Tôi biết bạn đang vội,\" Bác sĩ Clementine nói với giọng điệu nhẹ nhàng, \"Tôi đảm bảo sẽ không làm mất nhiều thời gian của bạn đâu.\"\n Hai bàn tay xuyên qua làn sương mù trong tâm trí, mỗi tay cầm một cuốn bệnh án, một cuốn dày và có dấu hiệu mòn rách, một cuốn mỏng và hoàn toàn mới. \n \"Dựa trên kết quả bảng câu hỏi của bạn, tôi đã tự tiện lập một bản bệnh án cho bạn. Tuy nhiên, tôi chợt quên mất cuốn nào là của bạn, hay là bạn chọn thử xem?\"\n Không hiểu vì lý do gì, từ cuốn bệnh án mỏng manh kia truyền đến một cảm giác quen thuộc, tạo nên sự cảm ứng âm thầm với mối liên kết tinh thần giữa bạn và thân thể được đánh thức."
  },
  Event_7341_Name = {
    Text = "sổ bệnh án"
  },
  Event_7342_ChoiceDesc1 = {Text = "[đi]"},
  Event_7342_Desc = {
    Text = "Một bức tường bình thường, bạn không nhịn được gõ thử, nhưng cảm thấy dường như nó không phải là đặc ruột"
  },
  Event_7342_Name = {
    Text = "Tường kỳ quái"
  },
  Event_7343_ChoiceDesc1 = {
    Text = "[Tôi cũng không ở trên mặt nước] Chọn ngẫu nhiên 1 vật bạc để nâng cấp lên vàng [(RelicConfig.Arg1)]"
  },
  Event_7343_ChoiceDesc2 = {
    Text = "[thấp đầu xem xét] nhận được bạc sáng tạo \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7343_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_7343_Desc = {
    Text = "\"hi hi, Người Giữ Gìn, bạn còn nhớ lời dặn của Wenkel không? Nghe đây, không·nên·vào·giờ·trưa·nhìn·xuống·bóng·của·mình.\""
  },
  Event_7343_Name = {
    Text = "Bản phản chiếu vô hình"
  },
  Event_7343_Tips1 = {
    Text = "Chưa sở hữu bạc sáng tạo"
  },
  Event_7344_ChoiceDesc1 = {Text = "[đi]"},
  Event_7344_Desc = {
    Text = "Hình bóng từ tương lai xa xôi, ẩn khuất trong núi non Elworth."
  },
  Event_7344_Name = {
    Text = "Hình bóng núi lửa"
  },
  Event_7345_ChoiceDesc1 = {Text = "[đi]"},
  Event_7345_Desc = {
    Text = "Con bướm trong lòng bàn tay bạn vỡ vụn, giống như trần nhà kính bị đập vỡ đột ngột, những mảnh vỡ rơi xuống theo lực hấp dẫn, rơi, rơi, rơi ——"
  },
  Event_7345_Name = {
    Text = "ảo giác của cây cầu thép"
  },
  Event_7346_ChoiceDesc1 = {Text = "[đi]"},
  Event_7346_Desc = {
    Text = "Hãy đợi đến khi họ bước ra từ bóng tối, rồi chúng ta sẽ tính tiếp."
  },
  Event_7346_Name = {
    Text = "Đèn lồng quạ đen"
  },
  Event_7347_ChoiceDesc1 = {
    Text = "[Mở công tắc] Mở rộng tầm nhìn hiện tại."
  },
  Event_7347_Desc = {
    Text = "Đèn chiếu sáng được để lại bởi những người đi trước, có thể xua tan sương mù đen bao quanh. \nSương mù xung quanh nó dao động đều đặn, như thể hơi thở của nó làm xao động."
  },
  Event_7347_Name = {Text = "đèn pha"},
  Event_7348_ChoiceDesc1 = {
    Text = "[chỉ ra vấn đề] Chọn 1 trong 3 thẻ lệnh để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_7348_ChoiceDesc2 = {
    Text = "[nuốt xuống nghi vấn] nhiễm [(Skill.Arg1)], khắcăng, tối đa 2 lần"
  },
  Event_7348_Desc = {
    Text = "Cho đến bây giờ, bạn vẫn đang hồi tưởng về quá khứ mà Muphí đã kể. \n Ký ức khiến bạn cảm thấy Cảm thông, giam cầm và ép chặt bộ não của bạn, ngay cả lời an ủi của Goliath dành cho Muphí cũng không thể khiến bạn cảm thấy được an ủi. \n … đợi đã, họ nói, thời điểm sao chính vị sẽ đến sau hai mươi lăm năm nữa… \n Nhưng Muphí trước mắt, rõ ràng chỉ là một đứa trẻ nửa lớn…"
  },
  Event_7348_Name = {
    Text = "Sống bị giam cầm"
  },
  Event_7349_ChoiceDesc1 = {
    Text = "[rời đi] nhận được 3 chọn 1 vật phẩm bạc, nhiễm phải 「(Skill.Arg1)」"
  },
  Event_7349_Desc = {
    Text = "Cô ấy đáng lẽ phải rơi nước mắt, không ai xứng đáng hơn cô ấy để khóc. \nNhưng tại sao cô ấy không khóc mà chỉ đứng ngoài cuộc? Giống như những người đang quỳ lạy kia không liên quan đến cô ấy…"
  },
  Event_7349_Name = {
    Text = "Lễ nghi trước chuyến bay"
  },
  Event_7350_ChoiceDesc1 = {Text = "[đi]"},
  Event_7350_Desc = {
    Text = "Dù thế nào đi nữa, việc dò hỏi thông tin riêng tư của người khác là hành động không lịch sự."
  },
  Event_7350_Name = {
    Text = "Như gặp mặt"
  },
  Event_7351_ChoiceDesc1 = {Text = "[đi]"},
  Event_7351_Desc = {
    Text = "Chắc chắn chỉ là do mắt hoa một lúc."
  },
  Event_7351_Name = {
    Text = "Nhìn chằm chằm của Quạ Đen"
  },
  Event_7352_ChoiceDesc1 = {
    Text = "[rời đi] nhận được 1 trong 3 khắcăng"
  },
  Event_7352_Desc = {
    Text = "Trong ký ức, mọi người đều cầu nguyện cho cô ấy, van xin cô ấy. Bạn không thể kiềm chế được và cũng thầm nguyện trong lòng…"
  },
  Event_7352_Name = {
    Text = "Lễ nghi trước chuyến bay"
  },
  Event_7353_ChoiceDesc1 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_7353_Desc = {
    Text = "Dưới thân con mèo đen, chất lỏng màu đen dính đặc chảy liên tục và dày đặc, tụ thành một dòng suối nhỏ chảy thẳng đến cống rãnh ở đầu ngõ. Thấy bạn đứng xa, không tiến lại gần, con mèo đen quay đầu nhảy vào cống rãnh, biến mất."
  },
  Event_7353_Name = {Text = "Elfo Đêm"},
  Event_7354_ChoiceDesc1 = {Text = "[đi]"},
  Event_7354_Desc = {
    Text = "Bạn hoảng hốt, phát ra tiếng la thét chói tai. \nDường như bị giọng nói của bạn thu hút, bàn tay vốn đang lo lắng bất an của nó do dự một chút. \nBạn nắm lấy cơ hội này và lập tức chạy trốn."
  },
  Event_7354_Name = {
    Text = "Đầm lầy Tối"
  },
  Event_7355_ChoiceDesc1 = {Text = "[đi]"},
  Event_7355_Desc = {
    Text = "Vặn vẹo, trườn, bò… bạn dùng mọi cách để thoát khỏi những cánh tay khó chịu này. \nCuối cùng, bạn đã thoát ra ngoài, nhưng phải trả giá bằng một bộ đồng phục mới tinh, hai chiếc xương sườn và hàng trăm sợi tóc."
  },
  Event_7355_Name = {
    Text = "Đầm lầy Tối"
  },
  Event_7356_ChoiceDesc1 = {Text = "[đi]"},
  Event_7356_Desc = {
    Text = "\"Hiện tượng bình thường, đừng ngạc nhiên quá, giống như một người mới chưa có kinh nghiệm,\"\nĐóa tiến lại gần, chỉnh lại vị trí huy hiệu trên ngực bạn,\"Điều này cho thấy có một đường dẫn chiều đặc biệt ở gần đây. Có vẻ như nó nằm ở hướng bệnh viện tâm thần.\""
  },
  Event_7356_Name = {
    Text = "Brooch Bồn Khoảng"
  },
  Event_7357_ChoiceDesc1 = {Text = "[đi]"},
  Event_7357_Desc = {
    Text = "Bạn không có lý do để chấp nhận yêu cầu về những thứ được đám tín đồ cầm đèn cho ăn. \nCon quạ tức giận lắc lư cái đầu chất chồng bẩn thỉu đáng sợ, phát ra những âm thanh kỳ quái mà bạn chỉ có thể nghe thấy bên mộ, rồi gào thét bay đi."
  },
  Event_7357_Name = {
    Text = "Quạ Nguyền Rủa"
  },
  Event_7358_ChoiceDesc1 = {Text = "[đi]"},
  Event_7358_Desc = {
    Text = "\"Đây cũng là lựa chọn của tôi.\" Hình bóng ôm gấu bông nói,\"Nhưng cô ấy sẽ trở thành con rối của anh ta, và họ đều sẽ chết. \nNgươi, sẽ trở thành đồng lõa của tội ác.\"\nCảm giác tội lỗi mãnh liệt nhấn chìm ngươi. Hình bóng tan biến, ngươi đỡ ngực, không biết vừa rồi đó là hình ảnh ảo hay ảo giác do tinh thần bị áp lực quá lớn tạo ra."
  },
  Event_7358_Name = {
    Text = "Đường phân nhánh"
  },
  Event_7359_ChoiceDesc1 = {
    Text = "[tiếp tục bịt tai] nhận được số lượng dấu đen tương đương với giá trị điên cuồng cao nhất của thân thể được đánh thức (Arg1)"
  },
  Event_7359_ChoiceDesc2 = {
    Text = "[tiếp tục bịt tai] phục hồi (Arg1) điểm sức sống, sở hữu nhiều dấu đen hơn sẽ gia tăng lượng phục hồi"
  },
  Event_7359_Desc = {
    Text = "Ngươi nghe theo lời khuyên không có thiện ý bên tai, tiếng rít như mũi kim xoắn vặn đâm vào lỗ tai ngươi.\n\"Dừng lại — mau dừng lại — ta đã làm theo lời ngươi rồi — mau dừng —\"\nNgươi đau đớn ôm lấy đầu, trong cơn mê man nghe thấy tiếng bầy quạ chế giễu."
  },
  Event_7359_Name = {
    Text = "Bài hát của đàn quạ"
  },
  Event_7360_ChoiceDesc1 = {
    Text = "[Bắt được một con quạ] mỗi khi sở hữu 1 thân thể được đánh thức nhận được 25 dấu đen"
  },
  Event_7360_ChoiceDesc2 = {
    Text = "[phát ra tiếng thét] chọn thức tỉnh 1 thân thể được đánh thức và thêm hiệu ứng \"cố định\" và\"duy trì\" cho thẻ thức tỉnh của nó"
  },
  Event_7360_Desc = {
    Text = "Bạn đột nhiên nổi hứng, đưa tay ra và nắm chặt một con quạ. \nNó tuyệt vọng vùng vẫy trong lòng bàn tay bạn, cuối cùng bùng nổ thành một dòng nước ấm áp."
  },
  Event_7360_Name = {
    Text = "Bài hát của đàn quạ"
  },
  Event_7361_ChoiceDesc1 = {Text = "[đi]"},
  Event_7361_Desc = {
    Text = "Bạn bịt tai và nhắm mắt lại. \n Thình thịch, thình thịch… nhịp tim bạn hòa quyện với tiếng thét chói tai, tạo nên một bản nhạc hỗn loạn của cái chết. \n Vào khoảnh khắc này, bạn cảm thấy sự bình yên chưa từng có."
  },
  Event_7361_Name = {
    Text = "Bài hát của đàn quạ"
  },
  Event_7362_ChoiceDesc1 = {Text = "[đi]"},
  Event_7362_Desc = {
    Text = "Thâm cảnh nguy hiểm bốn bề, không phải mọi ánh sáng đều là ngọn đèn chỉ đường. \nĐó cũng có thể là ngọn nến dụ dỗ con thiêu thân."
  },
  Event_7362_Name = {
    Text = "Ánh sáng đêm"
  },
  Event_7363_ChoiceDesc1 = {Text = "[đi]"},
  Event_7363_Desc = {
    Text = "\"Bạn đã chết từ lâu rồi, cũng không thể trở về Nhà được nữa.\" Giọng bạn lạnh lùng như Tiếng rít của gió trên Bãi tuyết Ross. biểu cảm của người lữ hành không có bất kỳ thay đổi nào, Dường như mọi chuyện vốn dĩ phải như vậy. Anh ta lại một lần nữa nắm lấy tay bạn, \"Cứu tôi với. Tôi là một binh sĩ, phụng mệnh tiến về phương Đông xa xôi…\""
  },
  Event_7363_Name = {
    Text = "Tiêu Thụ Giả"
  },
  Event_7364_ChoiceDesc1 = {Text = "[đi]"},
  Event_7364_Desc = {
    Text = "Máy điện báo đã bị hỏng. Bạn có thể tưởng tượng sự tuyệt vọng của chủ nhân máy điện báo trong cơn bão… bởi vì lúc này bạn cũng vậy."
  },
  Event_7364_Name = {
    Text = "Điện báo im lặng"
  },
  Event_7365_ChoiceDesc1 = {Text = "[đi]"},
  Event_7365_Desc = {
    Text = "\"Rẽ trái sau năm mươi thước, sau đó rẽ phải, rồi lại rẽ trái...\nRồi cứ đi thẳng đến cuối đường, nhà của bạn ở đó.\"\nNgười lữ khách rất vui. Anh ta vẫy tay chào bạn, sau đó rời đi.\nBạn thở phào nhẹ nhõm, bỗng nhiên cảm thấy có ai đó nắm tay bạn. Giọng nói quen thuộc vọng lại bên tai:\n \"Làm ơn cứu tôi.\nTôi là một binh sĩ, được lệnh đi đến phương Đông xa xôi...\""
  },
  Event_7365_Name = {
    Text = "Tiêu Thụ Giả"
  },
  Event_7366_ChoiceDesc1 = {Text = "[đi]"},
  Event_7366_Desc = {
    Text = "Bạn cuối cùng đã thoát khỏi mê cung này. \n Vào khoảnh khắc đó, bạn bỗng hiểu ra rằng bảo tàng sáp này là một sinh vật sống. \n Tất cả sự xảo trá, vẻ đẹp và tàn nhẫn đều được kết nối với nhau bằng một nghi thức cổ xưa. \n Và đôi mắt của nghi thức chính là Rogers."
  },
  Event_7366_Name = {
    Text = "Mê cung của Mắt"
  },
  Event_7367_ChoiceDesc1 = {Text = "[đi]"},
  Event_7367_Desc = {
    Text = "\"Vai trò đóng giả có thú vị không, Người Giữ Gìn?\" Ramona kéo nhẹ tay áo của bạn, \"Cửa ra không xa nữa, hy vọng ngài vẫn giữ được sự hài hước như lúc này trước mặt bà Đào Đen Đá.\""
  },
  Event_7367_Name = {
    Text = "Hồi ức phân mảnh · Mộng cũ tái hiện"
  },
  Event_7368_ChoiceDesc1 = {Text = "[đi]"},
  Event_7368_Desc = {
    Text = "“Thân thể được đánh thức khó có thể phản kháng ý chí của người liên kết,” bạn đáp lại, “nhưng chúng ta sẽ không từ bỏ.”"
  },
  Event_7368_Name = {
    Text = "Lựa chọn của cô ấy"
  },
  Event_7369_ChoiceDesc1 = {
    Text = "[Enter] Xuyên qua bức tường, khám phá sự thật."
  },
  Event_7369_ChoiceDesc2 = {Text = "[đi]"},
  Event_7369_Desc = {
    Text = "Bạn tiến gần bức tường, mặt tường bỗng biến dạng, dường như muốn hút bạn"
  },
  Event_7369_Name = {
    Text = "Không gian vặn vẹo"
  },
  Event_7370_ChoiceDesc1 = {Text = "[đi]"},
  Event_7370_Desc = {
    Text = "\"Không, điều này không phải là thật. So với gián, các ngươi ít nhất còn có thân thể lông lá. \n Không ai có thể từ chối một thân thể lông lá.\"\n Những con chuột thì thầm với nhau, cuối cùng miễn cưỡng đồng ý với quan điểm của bạn. \n \"May mắn thay... thực ra cũng không có nhiều lông lắm.\"\n Được khen ngợi luôn khiến người ta vui vẻ. Trước khi rời đi, những con chuột tặng bạn một quà tặng nhỏ."
  },
  Event_7370_Name = {
    Text = "Bệnh dịch hạch"
  },
  Event_7371_ChoiceDesc1 = {Text = "[đi]"},
  Event_7371_Desc = {
    Text = "\"Tôi đồng ý! Con người và chuột không đội trời chung!\"\nNhững con chuột có vẻ hơi tức giận, lộ ra những chiếc răng nanh trắng như tuyết. \n \"Vậy còn đứng đây làm gì? Lấy đồ đi, và đừng bao giờ quay lại!\""
  },
  Event_7371_Name = {
    Text = "Bệnh dịch hạch"
  },
  Event_7372_ChoiceDesc1 = {
    Text = "[Xác nhận]"
  },
  Event_7372_Desc = {
    Text = "Chào mừng đến với vùng sâu thẳm dưới biển, nơi mỗi bước đi đều phải chịu áp lực nặng nề. \n\n Sương mù hỗn loạn ẩn nấp tất cả, bạn có thể vượt qua Biển Không Ánh Sáng dưới áp lực này không?"
  },
  Event_7372_Name = {
    Text = "Dưới dòng thủy triều"
  },
  Event_7373_ChoiceDesc1 = {
    Text = "[Thử xem] Xóa 1 thẻ bài"
  },
  Event_7373_ChoiceDesc2 = {
    Text = "[Xem kỹ] nhận được \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7373_Desc = {
    Text = "\"đập đập...\"\nMáy đánh chữ giống như một ông già say whisky, ngập ngừng nhả ra mực đen. \nBạn nhanh chóng nhận thấy dòng chữ \"Mason\", liền lập tức rút giấy ra."
  },
  Event_7373_Name = {
    Text = "Máy đánh chữ"
  },
  Event_7374_ChoiceDesc1 = {
    Text = "[Trực tiếp nhìn vào mắt] nhận được vật tạo vàng \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7374_ChoiceDesc2 = {
    Text = "[Đóng mắt lại] ngẫu nhiên thức tỉnh 2 thân thể được đánh thức, nhiễm hai lần [(Skill.Arg1)]"
  },
  Event_7374_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 50 dấu đen"
  },
  Event_7374_Desc = {
    Text = "Vô số con mắt bao quanh tai bạn thì thầm. \n \"Chúng tôi du lịch, chúng tôi dừng lại, chúng tôi đã bước đi qua hàng vạn năm thậm chí lâu hơn. \nKhi mặt trời dần tắt trong ánh nhìn, khi sức sống của Trái Đất cũ bị lũ lụt nhấn chìm. \nChúng tôi đã sớm bị bí ẩn của vũ trụ thu hút sâu sắc.\""
  },
  Event_7374_Name = {Text = "mắt"},
  Event_7375_ChoiceDesc1 = {
    Text = "[Tuân theo chỉ thị] Tăng Arg1 điểm Sinh lực"
  },
  Event_7375_ChoiceDesc2 = {Text = "[đi]"},
  Event_7375_Desc = {
    Text = "Bạn thử sử dụng sức mạnh truy vết của chìa khóa bạc để tìm điểm liên lạc gần nhất, nhưng thông tin nhận được chứa những bất thường khó phát hiện, có vẻ đã bị can thiệp."
  },
  Event_7375_Name = {
    Text = "Liên lạc bất thường"
  },
  Event_7376_ChoiceDesc1 = {Text = "[đi]"},
  Event_7376_Desc = {
    Text = "Bạn dùng chiếc khăn tay bằng vải lanh tiêu chuẩn từ bộ đồ học sinh Misaque nhẹ nhàng lau bề mặt máy đánh chữ. \nMáy đánh chữ lại trở nên yên tĩnh. Còn chiếc khăn bẩn… hãy để nó ở lại trong thâm cảnh."
  },
  Event_7376_Name = {
    Text = "Bisikan Máy Đánh Chữ"
  },
  Event_7377_ChoiceDesc1 = {Text = "[đi]"},
  Event_7377_Desc = {
    Text = "Bạn chăm chú nhìn kỹ, trong những vệt mực rung động và chồng chất, một cái tên dần hiện ra, \"Fingal Johansen\".\nĐây là ai?"
  },
  Event_7377_Name = {
    Text = "Bisikan Máy Đánh Chữ"
  },
  Event_7378_ChoiceDesc1 = {
    Text = "[ngẩng đầu nhìn thẳng] chọn 1 thẻ lệnh từ 3 thẻ lệnh để nhận khắcăng: \"(EnchantConfig.Arg1)\", lây nhiễm \"(Skill.Arg2)\""
  },
  Event_7378_ChoiceDesc2 = {
    Text = "[Góc độ của mặt trời?] Chọn 1 thân thể được đánh thức, nhiễm [(Skill.Arg1)]"
  },
  Event_7378_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_7378_Desc = {
    Text = "\"Bây giờ, hãy ngước lên hướng đông nam, góc nâng của mặt trời đã đúng vị trí.\"Đóa truyền lệnh qua liên lạc."
  },
  Event_7378_Name = {Text = "Góc nâng"},
  Event_7379_ChoiceDesc1 = {
    Text = "[bị nhiễm 「(Skill.Arg1)」, nhận được vật tạo vàng 「(RelicConfig.Arg2)」]"
  },
  Event_7379_ChoiceDesc2 = {
    Text = "[rời đi] nhận được 50 dấu đen"
  },
  Event_7379_Desc = {
    Text = "Sự kiện 354 (đang phát triển), chưa phải hiệu ứng cuối cùng"
  },
  Event_7379_Name = {
    Text = "Sự kiện 354 (đang phát triển)"
  },
  Event_7380_ChoiceDesc1 = {Text = "[đi]"},
  Event_7380_Desc = {
    Text = "Giọng của những đứa trẻ chảy ra từ phím đàn. \n \"Charlie có một con mèo vằn mà ông rất yêu...\"\nDưới giọng hát của những đứa trẻ, một giọng nữ trẻ cũng đang hát nhẹ nhàng và dịu dàng. \nBạn có nghe nhầm không?"
  },
  Event_7380_Name = {
    Text = "Melodi tuổi thơ"
  },
  Event_7381_ChoiceDesc1 = {
    Text = "[quay người] nhận được 25 dấu đen"
  },
  Event_7381_ChoiceDesc2 = {
    Text = "[tiếp tục tiến lên] nhận được sáng tạo bạc \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7381_Desc = {
    Text = "Có tiếng bước chân từ phía sau. \nNhư bóng dáng, vừa phải và bình tĩnh. \nTiếng bước chân hòa quyện cùng nhau, vang vọng trong phòng trưng bày trống trải."
  },
  Event_7381_Name = {Text = "Oxford"},
  Event_7382_ChoiceDesc1 = {
    Text = "[thu hồi thư] xóa 2 thẻ bài"
  },
  Event_7382_ChoiceDesc2 = {
    Text = "[bảo tồn thư giấy] nhận được vật bị nguyền rủa \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7382_ChoiceDesc3 = {
    Text = "[Rời đi] Nhận được Arg1 dấu đen"
  },
  Event_7382_Desc = {
    Text = "Một chiếc máy đánh chữ mới. \nNó có một bộ phím chữ độc đáo, tinh xảo như một chiếc kính hiển vi. \nBạn đang say mê cấu trúc cơ khí hoàn hảo của nó, thì bỗng nhiên những dòng chữ màu đen hiện ra. \n \"Kính gửi Rogers, \nChúng tôi xin thông báo với lòng buồn rầu rằng, bạn đã bị trường học đuổi học. \nNhư đã biết, @2Trường học luôn nổi tiếng với thái độ học thuật nghiêm túc trong toàn vương quốc, những tin đồn gây chấn động @3đã làm phiền lòng chúng tôi sâu sắc...\""
  },
  Event_7382_Name = {
    Text = "Như gặp mặt"
  },
  Event_7383_ChoiceDesc1 = {Text = "[đi]"},
  Event_7383_Desc = {
    Text = "Chiếc đồng hồ bỏ túi ngừng hoạt động giống như một lời thúc giục, nhắc nhở bạn không bị mắc kẹt trong bẫy của không gian và thời gian."
  },
  Event_7383_Name = {
    Text = "Ánh nhìn của Người"
  },
  Event_7384_ChoiceDesc1 = {Text = "[đi]"},
  Event_7384_Desc = {
    Text = "Dịch đen rơi trên mặt bạn, gây cảm giác ngứa ngáy. \nBạn không thể chịu đựng được, vung tay đập con bướm. \nCon bướm tránh khỏi hành động không thiện chí của bạn và biến mất ở cuối đường."
  },
  Event_7384_Name = {
    Text = "Bướm Dung Dịch Đen"
  },
  Event_7385_ChoiceDesc1 = {
    Text = "[quan sát kỹ lưỡng]"
  },
  Event_7385_ChoiceDesc2 = {
    Text = "[khai quật]"
  },
  Event_7385_Desc = {
    Text = "Kum cõng ba bạn trong viện tâm thần tìm kiếm lối vào. \n Đột nhiên, nó phanh gấp, suýt nữa làm các bạn rơi xuống lưng nó. \n Trong tiếng hỏi han của các bạn, Kum cúi đầu, ngửi ngửi trên mặt đất mềm, quay đầu ra hiệu cho các bạn, dường như có thứ gì đó chôn dưới mặt đất"
  },
  Event_7385_Name = {
    Text = "Vật chôn sâu"
  },
  Event_7386_ChoiceDesc1 = {
    Text = "[Lãnh thưởng] Chọn 1 trong 3 vật tạo vàng"
  },
  Event_7386_Desc = {
    Text = "Đó là nơi không có gì cả, chất lỏng đen ngòm chảy lan trên mặt đất, không phản chiếu được bất cứ điều gì. \n Có phải ảo giác của bạn không? Bạn ngỡ như có điều gì vừa tuột khỏi kẽ tay."
  },
  Event_7386_Name = {
    Text = "Dưới bề mặt gương"
  },
  Event_7387_ChoiceDesc1 = {Text = "[đi]"},
  Event_7387_Desc = {
    Text = "Đôi cánh màu đen rơi xuống bùn ẩm trong con hẻm nhỏ, biến thành bùn đen dạng dung dịch rỗng rỗng."
  },
  Event_7387_Name = {
    Text = "Bầy quạ hỗn loạn"
  },
  Event_7388_ChoiceDesc1 = {Text = "[đi]"},
  Event_7388_Desc = {
    Text = "\"Bà Đào Đen Đá sẽ thích sự hài hước của bạn.\" Ramona vẫy tay, làn sương mỏng hình bóng tan biến theo, \"Đừng để bản thân trở thành giá phải trả cho việc du lịch giữa các chiều.\""
  },
  Event_7388_Name = {
    Text = "Hồi ức phân mảnh · Mộng cũ tái hiện"
  },
  Event_7389_ChoiceDesc1 = {
    Text = "[Lãnh thưởng] Chọn 1 trong 3 vật tạo vàng"
  },
  Event_7389_Desc = {
    Text = "Ồ, cái bóng phản chiếu kinh khủng kia chính là bản thân bạn. \nSự ác ý phun trào hòa quyện với bùn đen dưới chân bạn, vặn vẹo trong điệu nhảy chung. Nếu không phiền, nó cũng muốn leo lên vai bạn."
  },
  Event_7389_Name = {
    Text = "Dưới bề mặt gương"
  },
  Event_7390_ChoiceDesc1 = {
    Text = "[đứng yên tại chỗ] nhận được 25 dấu đen quý giá"
  },
  Event_7390_ChoiceDesc2 = {
    Text = "[tùy ý đi lại] nhận được bạc tạo vật \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7390_Desc = {
    Text = "Bạn dẫm nát bóng của chính mình, rơi vào một vũng tối đen. \n Cái bóng bị vỡ nát kia, là vật duy nhất kết nối bạn với thế giới đã mất dấu. \n Bạn thật sự muốn đi trong cơn ác mộng đen tối này sao? Bạn vẫn chưa tìm thấy hướng đi."
  },
  Event_7390_Name = {
    Text = "Hành giả ác mộng"
  },
  Event_7391_ChoiceDesc1 = {
    Text = "[Tìm kiếm nguồn gốc] nhận được bạc sáng tạo \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7391_ChoiceDesc2 = {
    Text = "[Đĩa phát lại] tất cả thân thể được đánh thức hồi phục 50 điên cuồng, lây nhiễm [(Skill.Arg1)]"
  },
  Event_7391_ChoiceDesc3 = {
    Text = "[tháo bỏ máy hát] nhận được 1 trong 3 khắcăng"
  },
  Event_7391_Desc = {
    Text = "Bạn gặp một chiếc hát máy cũ kĩ old-style. \n Vặn dây cót, bạn đặt kim hát lên đĩa than đầy vết xước, bản giao hưởng méo mó như tiếng keo dán bị xé ra, các nhạc cụ hơi và dây đánh nhau, không có phần nào có thể thoát khỏi bản nhạc này. \n Ở cuối bản nhạc rít lên, bạn lại nghe thấy một chuỗi tiếng gõ đều đặn. \n \"đông đông... đông đông đông... đông...\"\n Bạn nhíu mày, kéo kim hát ra, nhưng tiếng gõ vẫn tiếp tục như cũ."
  },
  Event_7391_Name = {
    Text = "Dấu Vết Bí Ẩn"
  },
  Event_7392_ChoiceDesc1 = {
    Text = "[Quan sát Ánh Sáng] chọn 1 sáng tạo biến thành vật bị nguyền rủa[(RelicConfig.Arg1)]"
  },
  Event_7392_ChoiceDesc2 = {
    Text = "[Touch into the Light] nhận được bạc tạo vật \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7392_ChoiceDesc3 = {
    Text = "[quay lưng rời đi] nhận được 25 dấu đen"
  },
  Event_7392_Desc = {
    Text = "Dưới tầm nhìn của giấc mơ, sương mù thâm cảnh khoác lên thực tại một lớp lụa màu mực. Mọi thứ trước mắt đều mờ ảo, như có như không. \n Trong sự mờ mịt, có ánh sáng của một thứ gì đó xuyên qua sương mù. Như ngọn hải đăng đối với con thuyền, như khói bếp đối với đứa trẻ lạc lối, chỉ dẫn hướng đi an toàn."
  },
  Event_7392_Name = {
    Text = "Ánh sáng đêm"
  },
  Event_7393_ChoiceDesc1 = {
    Text = "[Dừng nhạc] nâng cấp một sáng tạo bạc thành sáng tạo vàng[(RelicConfig.Arg1)]"
  },
  Event_7393_ChoiceDesc2 = {
    Text = "[Đối thoại với nó] nhận được vật tạo vàng \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\" và \"(Skill.Arg3)\""
  },
  Event_7393_ChoiceDesc3 = {
    Text = "[Tĩnh tâm lắng nghe] nhận được 25 dấu đen"
  },
  Event_7393_Desc = {
    Text = "Bạn nhặt lên vài mảnh ký ức vỡ từ một vũng bùn bẩn thỉu. \n Tinh thể trong suốt lấp lánh, vài sợi tơ bay bổng bên trong, những mảnh ký ức còn sót lại như những hạt cát bị gió thổi bay, bay lượn trong không trung. \n Những hình ảnh hỗn loạn, kỳ lạ, nghịch lý bùng nổ bên cạnh bạn. \n Bạn nhìn về phía—— \n"
  },
  Event_7393_Name = {
    Text = "Phân mảnh Bạc Nguyệt"
  },
  Event_7394_ChoiceDesc1 = {Text = "[đi]"},
  Event_7394_Desc = {
    Text = "Bạn đưa tay ra hứng vài bông tuyết rơi, nhìn kỹ. Những bông tuyết tan chảy không phải thành giọt nước trong veo, mà thành rỗng rỗng đặc sệt và tối đen."
  },
  Event_7394_Name = {Text = "Tuyết"},
  Event_7395_ChoiceDesc1 = {
    Text = "[Tôi cũng không ở trên mặt nước] Chọn ngẫu nhiên 1 vật bạc để nâng cấp lên vàng [(RelicConfig.Arg1)]"
  },
  Event_7395_ChoiceDesc2 = {
    Text = "[thấp đầu xem xét] nhận được bạc sáng tạo \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7395_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_7395_Desc = {
    Text = "Sương mù tan đi, một bàn tay gầy guộc đưa ra trước mặt bạn. \n Nó dường như đã bị ăn mòn mất thịt máu, bề mặt bàn tay gồ ghề được phủ một lớp dung dịch đen dính, trong khi trên người nó, treo đầy những chiếc nhẫn và dây chuyền phát ra ánh sáng vàng rực rỡ. \n Nó khẽ vẫy tay về phía bạn, dường như đang mời gọi bạn lại gần. \n Chỉ dưới bóng tối của nguy cơ, kho báu mới trở nên lấp lánh đặc biệt."
  },
  Event_7395_Name = {
    Text = "Đảo ngược móng quỷ"
  },
  Event_7395_Tips1 = {
    Text = "Chưa sở hữu bạc sáng tạo"
  },
  Event_7396_ChoiceDesc1 = {Text = "[đi]"},
  Event_7396_Desc = {
    Text = "Hình bóng vẫy tay với bạn, sau đó biến mất. Điều còn lại cho bạn chỉ là băng giá và dãy núi hùng vĩ."
  },
  Event_7396_Name = {
    Text = "Hình bóng núi lửa"
  },
  Event_7397_ChoiceDesc1 = {
    Text = "[Lễ tang của Mặt Trăng Bạc] chọn 1 sáng tạo biến thành vật bị nguyền rủa [(RelicConfig.Arg1)]"
  },
  Event_7397_ChoiceDesc2 = {
    Text = "[lời cầu nguyện của Mặt Trăng Bạc] nhận được vật phẩm sáng tạo từ bạc \"(RelicConfig.Arg1)\", bị ảnh hưởng bởi \"(Skill.Arg2)\""
  },
  Event_7397_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_7397_Desc = {
    Text = "Bạn nhặt lên vài mảnh ký ức vỡ từ một vũng bùn bẩn thỉu. \n Tinh thể trong suốt lấp lánh, vài sợi tơ bay bổng bên trong, những mảnh ký ức còn sót lại như những hạt cát bị gió thổi bay, bay lượn trong không trung. \n Những hình ảnh hỗn loạn, kỳ lạ, nghịch lý bùng nổ bên cạnh bạn. \n Bạn nhìn về phía——"
  },
  Event_7397_Name = {
    Text = "Phân mảnh Bạc Nguyệt"
  },
  Event_7398_ChoiceDesc1 = {
    Text = "[Thêm nhiên liệu] nhận được một khắcăng từ 3 lựa chọn"
  },
  Event_7398_ChoiceDesc2 = {
    Text = "[Tắt nó] từ 3 thẻ lệnh chọn 1 để nhận khắcăng: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7398_Desc = {
    Text = "\"Tôi là bóng tối của người hầu gái bị sát hại, kẻ sát nhân là ngọn lửa xanh mờ ảo kia.\"\nNgọn lửa đỏ nhạt lay động, tố cáo với bạn. \n \"Tôi từng sống bên bờ hồ trăng lồi phản chiếu, rực rỡ và chói lọi.\""
  },
  Event_7398_Name = {Text = "Lửa mờ"},
  Event_7399_ChoiceDesc1 = {Text = "[đi]"},
  Event_7399_Desc = {
    Text = "Bạn và bóng đứng dưới ánh đèn đường, không ai nói gì. \n Đêm nay không có trăng, tất cả các ngôi nhà đều im ắng. \n Bạn vẫy tay với bóng, rồi quay người bỏ đi."
  },
  Event_7399_Name = {
    Text = "Hình bóng dưới đèn đường"
  },
  Event_7400_ChoiceDesc1 = {
    Text = "[xua đuổi quạ] nhận Arg1 dấu đen, nhiễm [(Skill.Arg2)], tiếp tục chọn"
  },
  Event_7400_ChoiceDesc2 = {
    Text = "[bỏ qua] rời đi"
  },
  Event_7400_Desc = {
    Text = "Chim quạ đậu trên đầu giường, nhìn chằm chằm vào bạn bằng đôi mắt đỏ hoe."
  },
  Event_7400_Name = {
    Text = "Đèn lồng quạ đen"
  },
  Event_7401_ChoiceDesc1 = {
    Text = "[nói rằng mình không có ví] nhận được [khắcăng 3 trong 1]"
  },
  Event_7401_ChoiceDesc2 = {
    Text = "[Phá vỡ lưới] 1 thẻ lệnh ngẫu nhiên nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7401_Desc = {
    Text = "Mạng màu cam vàng nổi lơ lửng trong không trung, lỗ hổng thưa thớt, xa thua kém sự tinh xảo của người họ hàng xa là con nhện đang trú ngụ ở chân tường. \n Bạn không thể cưỡng lại chạm vào, mạng yếu đuối tan vỡ ngay lập tức, tiếng cười đùa của trẻ em vang lên bên tai bạn. \n \"Vàng bạc vàng đỏ, tất cả ví tiền đều là của chúng ta!\""
  },
  Event_7401_Name = {
    Text = "Mạng lưới lạc lối"
  },
  Event_7402_ChoiceDesc1 = {
    Text = "[Sửa chữa máy điện báo] bị nhiễm \"(Skill.Arg1)\", ngẫu nhiên 1 thẻ lệnh nhận được khắcăng: \"(EnchantConfig.Arg2)\""
  },
  Event_7402_ChoiceDesc2 = {
    Text = "[điện báo bị chôn vùi] nhiễm \"(Skill.Arg1)\", ngẫu nhiên 1 thẻ lệnh nhận được khắcăng: \"(EnchantConfig.Arg2)\""
  },
  Event_7402_ChoiceDesc3 = {
    Text = "[bỏ qua] Chọn 1 thẻ lệnh từ 3 thẻ lệnh để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_7402_Desc = {
    Text = "Bạn trốn vào khe hở hẹp của hang động, tạm tránh gió tuyết. Nhưng bạn biết rõ mình không thể dừng lại ở đây quá lâu, nếu nhóm người mặc áo choàng đen tìm thấy nơi này, bạn sẽ không có đường thoát.\nTrong góc của khe hở, bạn lại phát hiện ra một chiếc máy điện báo bị hỏng."
  },
  Event_7402_Name = {
    Text = "Di sản của người xưa"
  },
  Event_7403_ChoiceDesc1 = {Text = "[đi]"},
  Event_7403_Desc = {
    Text = "Bạn đã từng thấy những bức tranh chân dung như thế này ở nhiều nơi trong vương quốc. \n \"Nữ hoàng đó\"đứng ở giữa bức tranh, tỏa sáng trong sự bao bọc của những bông hồng đen. \nChỉ trừ một điểm — khuôn mặt của cô ấy bị cắt bỏ một cách tàn nhẫn, để lại một lỗ đen cháy. \nCho đến nay, bạn vẫn chưa thể nhìn thấy diện mạo thực sự của nữ hoàng."
  },
  Event_7403_Name = {
    Text = "Galeri chân dung"
  },
  Event_7404_ChoiceDesc1 = {
    Text = "[Bỏ qua cho cô ấy]nhận được vật bị nguyền rủa 「(RelicConfig.Arg1)」, nhiễm 「(Skill.Arg2)」"
  },
  Event_7404_ChoiceDesc2 = {
    Text = "[Giúp đỡ cô ấy] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: [(EnchantConfig.Arg1)]"
  },
  Event_7404_ChoiceDesc3 = {
    Text = "[Tôi muốn đi con đường của riêng tôi] nhận được 50 dấu đen"
  },
  Event_7404_Desc = {
    Text = "Ba bóng người chặn đường bạn. \n \"Bạn có thể buông tha cho cô ấy,\" bóng người ôm con gấu bông dính đầy rỗng rỗng mở miệng,\"cô ấy chỉ sợ hãi, không hề độc ác. Cô ấy không muốn gây thương tổn cho bất kỳ ai.\"\n \"Bạn có thể giúp đỡ cô ấy,\" bóng người cầm một túi kẹo được gói đẹp mắt mở miệng,\"bạn có thể làm những điều mà cô ấy không thể làm, bạn có thể kết thúc tất cả.\"\n \"Bạn không cần nghe chúng tôi,\" bóng người tay không mở miệng,\"bạn có con đường riêng của mình.\""
  },
  Event_7404_Name = {
    Text = "Đường phân nhánh"
  },
  Event_7405_ChoiceDesc1 = {Text = "[đi]"},
  Event_7405_Desc = {
    Text = "Giọng của Đào Đen Đá tạm dừng một chút. \n \"Ồ, ngươi đã chọn cái này sao? Lựa chọn không tồi, để thưởng, ta sẽ đặc biệt tặng ngươi một món quà tặng.\"\n \"Ta không quen thuộc với đứa trẻ đó, nhưng ta có một suy nghĩ về Francis. Ta nghĩ rằng, cảm xúc chi phối cô ấy, khiến cô ấy có được lực lượng\" nhìn thấy \", là nỗi hối hận sâu sắc. Không biết cô ấy sẽ đưa ra lựa chọn gì cho sự hối hận này...\""
  },
  Event_7405_Name = {
    Text = "Thời gian gợi ý"
  },
  Event_74068_ChoiceDesc1 = {
    Text = "[Thêm vào bình não] thêm [bình não dự phòng]vào rút bài từ bộ bài."
  },
  Event_74068_Desc = {
    Text = "Trong cánh cửa vòm phức tạp được chạm khắc, trên mái dốc của bức tường gạch đỏ, trước những căn nhà bị đục lỗ trên tường, bóng đổ dài nhảy múa, khao khát câu trả lời cho những câu hỏi. \nSự tầm thường có nghĩa là cái chết? \nBằng lòng với hiện trạng có phải là định mệnh bị tắt lửa không?"
  },
  Event_74068_Name = {
    Text = "Chưa mất đi ý thức"
  },
  Event_74069_ChoiceDesc1 = {
    Text = "[Tiếp tục chứa đựng] Chọn tối đa 2 thẻ lệnh từ bộ bài để loại bỏ, sau đó đặt chúng vào [hộp não phụ trợ]."
  },
  Event_74069_Desc = {
    Text = "\"Tôi đã thấy họ. Nhiều người, nhiều lời thì thầm: thông thái, hời hợt, lý trí, điên loạn. Đôi khi, từ trong đống tro tàn cũng lóe lên tia lửa của hy vọng.\""
  },
  Event_74069_Name = {
    Text = "Chưa mất đi ý thức"
  },
  Event_7406_ChoiceDesc1 = {Text = "[đi]"},
  Event_7406_Desc = {
    Text = "Bạn cẩn thận lấy con chuột ra khỏi cân, nó thở một cách đều đặn, thân thể lông lá làm ấm lòng bàn tay của bạn."
  },
  Event_7406_Name = {
    Text = "Lý trí và Tình cảm"
  },
  Event_7407_ChoiceDesc1 = {Text = "[đi]"},
  Event_7407_Desc = {
    Text = "Bạc tâm mờ nhạt bùng nổ ra ánh sáng rực rỡ, chớp mắt đã vụt tắt, trong tay chỉ còn lại một nắm bụi than không thể nghi ngờ. \n Bạc tâm đã tiêu hao linh tri thức cuối cùng, linh hồn không rõ danh tính không thể tái sinh thân thể, nhưng trước khi hoàn toàn biến mất, cũng để lại dấu vết của sự tồn tại."
  },
  Event_7407_Name = {
    Text = "Chứng minh sự tồn tại"
  },
  Event_7408_ChoiceDesc1 = {Text = "[đi]"},
  Event_7408_Desc = {
    Text = "「Tôi không quen biết đứa trẻ đó, nhưng tôi có một giả thuyết về Francis. Tôi nghĩ rằng, cảm xúc chi phối cô ấy, giúp cô ấy có được lực lượng『thấy』, là sự hối tiếc mãnh liệt. Không biết cô ấy sẽ đưa ra những lựa chọn như thế nào vì sự hối tiếc này…」"
  },
  Event_7408_Name = {
    Text = "Thời gian gợi ý"
  },
  Event_7409_ChoiceDesc1 = {
    Text = "[rút giấy ra] xóa 1 thẻ bài"
  },
  Event_7409_ChoiceDesc2 = {
    Text = "[Bây giờ không phải là lúc]Nhận「(RelicConfig.Arg1)」, nhiễm「(Skill.Arg2)」"
  },
  Event_7409_Desc = {
    Text = "Chiếc máy đánh chữ di động trong vali bất ngờ tự hoạt động, in ra nửa trang chữ viết xiên vẹo. \n \"Bạn đã thấy Ngài rồi, Ngài đang ở bên cạnh bạn, những bóng tối bị ô nhiễm bởi sự điên rồ, cuồng nhiệt...đừng nhìn thẳng vào đường nét của Ngài.\""
  },
  Event_7409_Name = {
    Text = "Cảnh báo không mời"
  },
  Event_7410_ChoiceDesc1 = {
    Text = "[đi sang trái] chọn 1 thẻ lệnh từ 3 thẻ lệnh để nhận khắcăng:\"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7410_ChoiceDesc2 = {
    Text = "[đi về phải] chọn 1 thân thể được đánh thức để thức tỉnh, nhiễm [(Skill.Arg1)]"
  },
  Event_7410_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_7410_Desc = {
    Text = "Bạn dường như đã bước vào một mê cung. \n Rẽ trái, rẽ phải, rồi lại rẽ trái... Bạn dần mất kiên nhẫn, cho đến khi bạn ngẩng đầu lên, nhìn thấy đôi mắt đó. \n Đôi mắt đang nhìn bạn, bình tĩnh và uy nghi, như thể nó mới là Chủ trị nơi đây."
  },
  Event_7410_Name = {
    Text = "Mê cung của Mắt"
  },
  Event_7411_ChoiceDesc1 = {Text = "[đi]"},
  Event_7411_Desc = {
    Text = "Bạn cố gắng rút hai tay ra và nghe rõ tiếng xương vỡ. \nĐây là cái giá bạn phải trả cho sự tò mò."
  },
  Event_7411_Name = {
    Text = "Bùng nổ cảm hứng"
  },
  Event_7412_ChoiceDesc1 = {Text = "[đi]"},
  Event_7412_Desc = {
    Text = "Bạn đã kiểm tra kỹ lưỡng chiếc máy ảnh, da thuộc và viền vàng đen được tích hợp vào thân máy, phản chiếu ra vài tia sáng bóng. \nThấu kính của nó hướng về bạn, giống như đang chăm chú quan sát, lặng lẽ dò xét…"
  },
  Event_7412_Name = {
    Text = "Bản ghi vô tội"
  },
  Event_7413_ChoiceDesc1 = {Text = "[đi]"},
  Event_7413_Desc = {
    Text = "Bạn không thương tiếc mà kéo ra nửa cuộn phim còn lại, chúng ẩn mình trong bụng máy ảnh, đột ngột bị kéo ra, nhưng hình ảnh trên đó khiến bạn không nói nên lời. \n Cuộn phim chưa được rửa, trung thành ghi lại - hình ảnh bạn ngã xuống một vũng bùn đen."
  },
  Event_7413_Name = {
    Text = "Bản ghi vô tội"
  },
  Event_74145_ChoiceDesc1 = {
    Text = "[Đọc] Xóa 1 thẻ lệnh, nhận 25 dấu đen"
  },
  Event_74145_ChoiceDesc2 = {
    Text = "[tiếp tục gõ] nhân bản một lá bài từ bộ bài, nhiễm [(Skill.Arg1)]"
  },
  Event_74145_Desc = {
    Text = "Máy in phun ra mực một cách mạnh mẽ. \n Mực đen như ma quái phun ra từ vòi, lan tỏa trong không khí, tạo thành một làn sương đen dày đặc và ngột ngạt. \n Dường như có một gợi ý nào đó ẩn chứa trên bàn phím, chờ đợi những ngón tay vô tội chạm vào."
  },
  Event_74145_Name = {Text = "Mực ma"},
  Event_74146_ChoiceDesc1 = {Text = "[đi]"},
  Event_74146_Desc = {
    Text = "Bạn nghiêng người bước vào con hẻm tối, sương mù gặm nhấm góc áo, nhưng cái bóng lại phân hạch thành vô số đôi mắt phía sau. Tiếng chuông rỉ sét cuốn theo điềm báo ẩm ướt. \n\nBạn biết, tất cả những con đường quanh co cuối cùng sẽ sụp đổ thành cái kén tuần hoàn——trước bình minh thối rữa, bạn và cái bóng của chính mình cuối cùng sẽ gặp lại."
  },
  Event_74146_Name = {
    Text = "Bụi thời gian"
  },
  Event_74147_ChoiceDesc1 = {Text = "[đi]"},
  Event_74147_Desc = {
    Text = "Bạn âm thầm vẽ đường nét lên ngực, dâng lên người đã khuất lời cầu nguyện không lời. \n Trong thế giới diệt vong này, có quá nhiều thứ bạn không thể cứu vớt. \n Xương cốt nhấp nháy, một góc của kho báu mà chủ nhân đã trân trọng trong đời sống hiện ra."
  },
  Event_74147_Name = {
    Text = "Xương phai màu"
  },
  Event_74148_ChoiceDesc1 = {Text = "[đi]"},
  Event_74148_Desc = {
    Text = "\"Thần Cha cảm nhận lòng từ bi của bạn. Thần Cha sẽ che chở chúng ta, giải thoát chúng ta khỏi gánh nặng đau khổ.\"\n\nHình bóng của cô ấy dần tan biến, tiếng thánh ca cũng hóa thành cơn gió lạnh lùa qua."
  },
  Event_74148_Name = {
    Text = "Lời cầu nguyện của organ"
  },
  Event_74149_ChoiceDesc1 = {Text = "[đi]"},
  Event_74149_Desc = {
    Text = "Bạn nhẹ nhàng đẩy bộ xương lộ ra, nó chìm vào dung dịch đen đặc một cách tự nhiên và chậm rãi, biến mất không để lại dấu vết. \nCầu mong linh hồn được yên nghỉ nơi hư vô."
  },
  Event_74149_Name = {
    Text = "Xương phai màu"
  },
  Event_7414_ChoiceDesc1 = {
    Text = "[Rời đi] Bạn đã đánh bại đối thủ, không có gì xảy ra"
  },
  Event_7414_Desc = {
    Text = "\"Xem ra, cậu nhóc phải chịu chút khổ mới biết được điều riêng tư của phụ nữ không thể tùy tiện dò hỏi.\"\nTheo lời Đào Đen Đá vừa dứt, một con quái vật khổng lồ xuất hiện ngay trước mặt ngươi."
  },
  Event_7414_Name = {
    Text = "Thời gian gợi ý"
  },
  Event_74150_ChoiceDesc1 = {Text = "[đi]"},
  Event_74150_Desc = {
    Text = "Trong tháp đồng hồ nơi chú chuột nhỏ ẩn náu, không nên tồn tại những món đồ chơi bệnh hoạn như vậy, âm thanh này phát ra từ tâm trí bạn, từ ký ức của bạn. \n Bạn nhớ lại cảm giác khi là não trong bình, thông qua dòng điện chuyển hóa từ sóng âm. \n Âm thanh lạ đó dần trở nên bình thường và êm dịu, biến thành một bản nhạc cổ điển mượt mà, lặp đi lặp lại trong tâm trí bạn."
  },
  Event_74150_Name = {
    Text = "Tiếng động lạ từ tháp đồng hồ"
  },
  Event_74151_ChoiceDesc1 = {Text = "[đi]"},
  Event_74151_Desc = {
    Text = "Đó không phải là mèo… đó là đám tín đồ cầm đèn đang rung rinh. \n Dưới lớp voan đen, sự ghê tởm và thù địch lộ ra, tiếng thì thầm xé rách ý thức của bạn, mang đến ảo giác kỳ quái không thể giải thích."
  },
  Event_74151_Name = {
    Text = "Bisikan Kucing"
  },
  Event_74152_ChoiceDesc1 = {Text = "[đi]"},
  Event_74152_Desc = {
    Text = "Họ nắm lấy đôi giày của bạn, nắm lấy mắt cá chân của bạn, họ tham lam, họ khao khát, họ muốn kéo bạn vào vực thẳm mà họ đang ở. \n Bạn cố gắng vùng vẫy, chỉ để giữ vững hình dáng, lùi lại vài bước để tìm cách thoát thân. \n Vô tình, có thứ gì đó rơi xuống."
  },
  Event_74152_Name = {
    Text = "Phản Chiếu Ác Mộng"
  },
  Event_74153_ChoiceDesc1 = {
    Text = "[Tránh né] Nhận 1 trong 3 khắcăng"
  },
  Event_74153_ChoiceDesc2 = {
    Text = "[chặn] chọn 1 thẻ lệnh từ 3 thẻ lệnh để nhận khắcăng: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_74153_Desc = {
    Text = "Cảnh tượng quen thuộc khiến dây thần kinh của bạn nhảy múa, co giật và sợ hãi. \n \"Lại một lần nữa...\"\nCơn ác mộng man rợ đến, cảm giác bất lực to lớn bao trùm lấy bạn. \nBạn thật sự không thể thay đổi số phận của cô ấy sao? \nĐã quá muộn, cái đầu nứt toác của Sara chứa cái miệng khổng lồ phát sáng bạc đang chờ đợi để tiêu thụ và nhai nghiền."
  },
  Event_74153_Name = {
    Text = "Đêm kinh hoàng tái hiện"
  },
  Event_74154_ChoiceDesc1 = {Text = "[đi]"},
  Event_74154_Desc = {
    Text = "Bạn nghe thấy những tiếng thì thầm đáng lo ngại. \n\n \"Chúng tôi đến từ những dãy núi và đầm lầy xa xôi trên các vì sao. Thân thể của chúng tôi là bấc đèn và nhiên liệu, chúng tôi sẽ đốt cháy ngọn lửa từ mặt đất, soi sáng con đường dẫn tới thế giới mới.\""
  },
  Event_74154_Name = {
    Text = "Bisikan Kucing"
  },
  Event_74155_ChoiceDesc1 = {Text = "[đi]"},
  Event_74155_Desc = {
    Text = "Hoàng hôn, tháp chuông, chim bay……\n cô gái đó tháo miếng bịt mắt ra, ánh nhìn từ con ngươi xám xịt của cô khiến bạn không thể cử động. \n Ảo ảnh như một gương ảo, vừa chạm vào trước mắt đã tan biến, nhưng những suy nghĩ lo lắng không thể nào gạt bỏ."
  },
  Event_74155_Name = {
    Text = "Mặt nạ mắt trắng"
  },
  Event_74156_ChoiceDesc1 = {
    Text = "[Nhặt lên] Nhận được 1 trong 3 lựa chọn bạc tạo vật"
  },
  Event_74156_ChoiceDesc2 = {
    Text = "[Nhớ lại] nhận được bạc sáng tạo \"(RelicConfig.Arg1)\"\"(RelicConfig.Arg2)\", nhiễm hai lần \"(Skill.Arg3)\""
  },
  Event_74156_Desc = {
    Text = "Trong đống chất nhầy rỗng rỗng ở góc, có một chiếc mặt nạ mắt trắng nhỏ nằm đó. \nKí ức ùa về, khiến trái tim bạn đau nhói."
  },
  Event_74156_Name = {
    Text = "Mặt nạ mắt trắng"
  },
  Event_74157_ChoiceDesc1 = {Text = "[đi]"},
  Event_74157_Desc = {
    Text = "Bàn tay trong suốt tự do múa trên những phím đàn đen trắng, nhưng âm thanh phát ra lại vụn vỡ, như một chiếc hộp nhạc lạc điệu, mỗi nốt nhạc đều phát ra tiếng khóc bi thương không hòa hợp, như một tiếng kêu cứu đang vật lộn. \n Cuối cùng, màn trình diễn dừng lại đột ngột trong một hợp âm bất lực. \n Những gì chưa đạt được trong cuộc sống, giờ đây chỉ để lại sự nuối tiếc."
  },
  Event_74157_Name = {
    Text = "Sonata của tiếc nuối"
  },
  Event_74158_ChoiceDesc1 = {Text = "[đi]"},
  Event_74158_Desc = {
    Text = "\"Kính gửi Bà Sara:\nTôi xin từ chức điều dưỡng tại nhà tế bần.\nTôi đã không còn tán thành với lý tưởng của bà nữa. Những lời dạy của bà là sai lầm, trẻ em ở khu Đông không nên lớn lên dưới sự bảo bọc của bà, không nên tin vào lòng tốt đơn thuần và sự cho đi vô điều kiện.\nChúng sẽ có một ngày phải rời xa vòng tay của bà để học cách sống sót theo quy luật của khu Đông.\n\n...\"\n\nNhững dòng chữ tiếp theo bị chất lỏng màu đen làm nhòe, mờ hẳn đi."
  },
  Event_74158_Name = {Text = "Mực ma"},
  Event_74159_ChoiceDesc1 = {Text = "[đi]"},
  Event_74159_Desc = {
    Text = "\"Tôi chỉ có thể cung cấp cho các em một mái nhà che mưa và bữa ăn đủ no để không chết đói. Nếu không có bác sĩ mà ông Rogers tốt bụng gọi đến, họ sẽ không có nổi một viên thuốc khi ốm đau. \nTôi không đọc nhiều sách, việc duy nhất tôi có thể làm là không để họ chết đói rét trên đường phố. \nTôi chưa bao giờ can thiệp vào việc các em muốn trở thành người như thế nào, nhưng họ cần phải sống. \n...\""
  },
  Event_74159_Name = {Text = "Mực ma"},
  Event_7415_ChoiceDesc1 = {
    Text = "[Tìm kiếm nguồn] nhận được vật tạo vàng [(RelicConfig.Arg1)]"
  },
  Event_7415_ChoiceDesc2 = {
    Text = "[Đánh bỏ thư] Từ 3 thẻ lệnh, chọn 1 thẻ để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_7415_ChoiceDesc3 = {
    Text = "[Kiểm tra thư] nhận được 50 dấu đen"
  },
  Event_7415_Desc = {
    Text = "Một bức thư nữa rơi xuống trước mặt bạn, lá thư bị xé rách khiến lòng người chùng xuống, bạn mở lá thư. \n \"Nó lại đến rồi, những điều tôi đã báo trước không phải là lời nói dối! @4 Mọi thứ sẽ bắt đầu từ đây, và cũng sẽ kết thúc ở đây.\"\n \"Tôi muốn trốn... co mình vào trong tủ gỗ, tay run rẩy không thể kiểm soát, nhưng âm thanh của những cơ thể dính đầy chất nhầy rơi xuống sàn nhà vẫn đang tiến gần... Tôi nghe thấy một cái tên! Chính là nó! @5!\""
  },
  Event_7415_Name = {
    Text = "Lá thư cầu cứu nữa"
  },
  Event_74160_ChoiceDesc1 = {Text = "[đi]"},
  Event_74160_Desc = {
    Text = "\"Cảm ơn ngài, sức mạnh sáng tạo của Đấng Cha sẽ tái tạo hình thể và ban tặng ánh sáng cùng ngọn lửa vĩnh cửu cho chúng ta. \n\nKhi tôi đến đích, tôi sẽ cầu chúc cho ngài trước mặt Đấng Cha.\"\n\nHình bóng của cô ấy dần dần tan biến, tiếng thánh ca cũng hóa thành gió vô tình thổi qua."
  },
  Event_74160_Name = {
    Text = "Lời cầu nguyện của organ"
  },
  Event_74161_ChoiceDesc1 = {
    Text = "[An táng] trả lại Arg2 điểm sức sống [ExDesc1], chọn 1 lá thẻ lệnh để xóa."
  },
  Event_74161_ChoiceDesc2 = {
    Text = "[Cầu nguyện] nhận được hoàng kim tạo vật \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_74161_Desc = {
    Text = "Một đoạn xương trắng bệch, nửa chìm trong dung dịch rỗng rỗng màu đen."
  },
  Event_74161_Name = {
    Text = "Xương phai màu"
  },
  Event_74162_ChoiceDesc1 = {Text = "[đi]"},
  Event_74162_Desc = {
    Text = "Bạn bước thẳng vào đám sương mù đó, ảo ảnh như mạng nhện quấn quanh cơ thể bạn, cảm giác lạnh lẽo thấm vào tủy xương. \n Những lời thì thầm của họ hóa thành những mảnh ký ức, đâm xuyên qua ngực bạn. \n Khi bạn vượt qua, phía sau chỉ còn lại một mảnh hư vô, trong khi phía trước, trong sương mù mờ ảo hiện lên nhiều bóng dáng mờ nhạt hơn, đang chờ tiêu thụ."
  },
  Event_74162_Name = {
    Text = "Bụi thời gian"
  },
  Event_74163_ChoiceDesc1 = {
    Text = "[Tránh khỏi hình bóng] nhận được vật tạo vàng \"(RelicConfig.Arg1)\", bị ảnh hưởng bởi \"(Skill.Arg2)\""
  },
  Event_74163_ChoiceDesc2 = {
    Text = "[Đi qua ảo ảnh] nhận được chọn 1 trong 3 vật tạo vàng, bị nhiễm [(Skill.Arg1)]"
  },
  Event_74163_ChoiceDesc3 = {
    Text = "[rời đi] nhận được bạc tạo vật [(RelicConfig.Arg1)]"
  },
  Event_74163_Desc = {
    Text = "Sương mù như một tấm màn nặng nề, bao trùm con phố, mỗi bước đi như đang dẫm lên bụi than của thời gian. \n Ở xa, hai bóng hình mờ ảo xuất hiện trong sương mù, như những hồn ma của quá khứ, thì thầm những câu chuyện đã bị quên lãng từ lâu. \n Sức tưởng tượng mất kiểm soát lại biến hóa ra những bóng hình đáng sợ, chúng biến dạng, lây lan, như những điềm báo của tương lai, đè nén bạn đến mức không thể thở được. \n Bạn biết, con đường phía trước chỉ sẽ càng thêm u ám, nhưng bước chân của bạn, không thể cũng không nên dừng lại."
  },
  Event_74163_Name = {
    Text = "Bụi thời gian"
  },
  Event_74164_ChoiceDesc1 = {Text = "[đi]"},
  Event_74164_Desc = {
    Text = "Bạn vừa kịp tránh khỏi đòn tấn công nhanh như chớp của Sara. \nNhững lần sau có lẽ sẽ không còn may mắn như thế nữa."
  },
  Event_74164_Name = {
    Text = "Đêm kinh hoàng tái hiện"
  },
  Event_74165_ChoiceDesc1 = {
    Text = "[Chỉ dẫn hướng] Nhận bạc tạo vật \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_74165_ChoiceDesc2 = {
    Text = "[cùng cầu nguyện] nhận được 1 trong 3 khắcăng"
  },
  Event_74165_Desc = {
    Text = "Âm thanh của đàn piano và đàn phong cầm hòa quyện trong gió xám xịt. Những giai điệu như mang phép màu bay lơ lửng giữa những con phố không người. \nMột nữ tu vô danh đang cầu nguyện trong tiếng nhạc. \n \"Lời cầu nguyện đơn sơ không cần nghi thức trang trọng, Đấng Cha vĩ đại sẽ gieo rắc hy vọng cho chúng ta, như Người đã từng ban cho chúng ta những lời dạy đầy lòng thành kính.\""
  },
  Event_74165_Name = {
    Text = "Lời cầu nguyện của organ"
  },
  Event_74166_ChoiceDesc1 = {
    Text = "[chống đỡ quái vật]chọn 1 sáng tạo biến thành vật tạo vàng「(RelicConfig.Arg1)」"
  },
  Event_74166_ChoiceDesc2 = {
    Text = "[Nhặt lên ngôi sao] nhận được sáng tạo bạc \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_74166_ChoiceDesc3 = {
    Text = "[bỏ qua] nhận được 25 dấu đen"
  },
  Event_74166_Desc = {
    Text = "Màn mưa sao băng rơi xuống tháp chuông. \n Một viên tinh thể trong suốt rơi đúng bên chân bạn, tạo ra một hố nhỏ. \n Bạn vẫn bị bao vây sâu, những thân thể bị ăn mòn với hình dạng khác nhau như những bóng ma biến dạng, tiếng gầm thét, tiếng rống không ngừng vang lên. \n Bạn quyết định——"
  },
  Event_74166_Name = {
    Text = "Sao đã rơi"
  },
  Event_74167_ChoiceDesc1 = {
    Text = "[xoa mắt] nhận được 50 dấu đen"
  },
  Event_74167_ChoiceDesc2 = {
    Text = "[đóng mắt] nhận được 75 dấu đen, bị lây nhiễm [(Skill.Arg2)]"
  },
  Event_74167_Desc = {
    Text = "Những con mèo đen đáng ghét ùa về phía sau của Yu Li-ét, lẩm bẩm những âm điệu không rõ, toả ra sự đe dọa ngấm ngầm."
  },
  Event_74167_Name = {
    Text = "Bisikan Kucing"
  },
  Event_74168_ChoiceDesc1 = {Text = "[đi]"},
  Event_74168_Desc = {
    Text = "Vải rẻ tiền sờ vào có cảm giác thô ráp, nhưng vẫn được rửa sạch cẩn thận. \nHãy giữ gìn cẩn thận, chờ ngày trả lại cho chủ nhân."
  },
  Event_74168_Name = {
    Text = "Mặt nạ mắt trắng"
  },
  Event_74169_ChoiceDesc1 = {
    Text = "[giữ khoảng cách] nhận được 25 dấu đen"
  },
  Event_74169_ChoiceDesc2 = {
    Text = "[Thể hiện lòng thương xót]nhận được bạc tạo vật「(RelicConfig.Arg1)」, nhiễm「(Skill.Arg2)」"
  },
  Event_74169_Desc = {
    Text = "Họ đổ xô đến từ dưới chân bạn. \nQua những khuôn mặt mờ ảo trong đau khổ, bạn nhìn thấy bóng mình bị kéo dãn. \nBạn thực sự có đặc quyền để phán xét họ sao?"
  },
  Event_74169_Name = {
    Text = "Phản Chiếu Ác Mộng"
  },
  Event_7416_ChoiceDesc1 = {
    Text = "[Vứt bỏ mảnh vỡ] có sáng tạo đặc biệt, nhiễm bệnh mang khắcăng: [(EnchantConfig.Arg1)]- triệu chứng: rỗng rỗng điên cuồng"
  },
  Event_7416_ChoiceDesc2 = {
    Text = "[Bổ sung mảnh vỡ] Không có sáng tạo đặc biệt, bị nhiễm \"(Skill.Arg1)\", nhận được \"(Skill.Arg2)\""
  },
  Event_7416_Desc = {
    Text = "Chi thể nhợt nhạt di chuyển chậm rãi trước mặt bạn, cô ta cúi người xuống, đưa cánh tay bị gãy ra trước mặt bạn, đôi mắt nhíu lại vì đau đớn, chảy ra những giọt nước mắt thạch cao. \n \"chỉ còn... chỉ còn một mảnh cuối cùng, tôi có thể...\""
  },
  Event_7416_Name = {
    Text = "Hoàn thiện xác tàn"
  },
  Event_74170_ChoiceDesc1 = {Text = "[đi]"},
  Event_74170_Desc = {
    Text = "Bạn hãy thử cứu chúng. \nNhưng đừng để chúng đồng hóa bạn."
  },
  Event_74170_Name = {
    Text = "Phản Chiếu Ác Mộng"
  },
  Event_74171_ChoiceDesc1 = {
    Text = "[Di chuyển ánh mắt] tăng Arg1 máu tối đa"
  },
  Event_74171_ChoiceDesc2 = {
    Text = "[Tiếp tục nhìn chằm chằm] 1 thẻ lệnh ngẫu nhiên nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm 1 thẻ \"(Skill.Arg2)\""
  },
  Event_74171_Desc = {
    Text = "\"Cuối cùng đã đến.\"\nTrái tim bạn co thắt, co lại. \nTrong giọng nói chắc chắn của Yu Li-ét không thể nghi ngờ có chứa một số lực lượng thôi miên và cảm ứng tâm linh. \nMục đích của Yu Li-ét trong chiều này có gì khác biệt so với Yu Li-ét mà bạn đã từng biết? \nQuá nhiều bí ẩn, quá nhiều ảo ảnh. \nBạn ngẩng đầu nhìn Yu Li-ét, nhưng phát hiện ra cô ấy cũng đang nhìn chằm chằm vào bạn."
  },
  Event_74171_Name = {
    Text = "Ánh nhìn cuối cùng"
  },
  Event_74172_ChoiceDesc1 = {Text = "[đi]"},
  Event_74172_Desc = {
    Text = "Bạn giơ tay gõ vào những phím đàn ảo một cách vụng về. \n Những phím đàn vang lên lách cách, mỗi nốt nhạc như những giọt sương rơi, trong suốt và rõ ràng, kỹ thuật biểu diễn tinh tế không xuất phát từ đầu ngón tay bạn. \n Trong giây phút chợt nhận ra, bạn thấy một đôi bàn tay vô hình dài và mảnh phủ lên mu bàn tay bạn, theo tiến trình của bản nhạc mà lên xuống. \n Thời gian như ngừng trôi, cho đến khi âm thanh cuối cùng của bản nhạc tắt dần. \n Bạn nghe thấy một tiếng thở dài hài lòng."
  },
  Event_74172_Name = {
    Text = "Sonata của tiếc nuối"
  },
  Event_74173_ChoiceDesc1 = {Text = "[đi]"},
  Event_74173_Desc = {
    Text = "Ý thức chuyển đổi liên tục không ổn định, bạn cần loại bỏ những nhiễu loạn vô nghĩa. \nBạn tập trung sự chú ý vào Jenkin trước mặt, âm thanh của máy hát dần dần mờ đi, tan biến trong làn sương."
  },
  Event_74173_Name = {
    Text = "Tiếng động lạ từ tháp đồng hồ"
  },
  Event_74174_ChoiceDesc1 = {
    Text = "[Tìm nguồn âm thanh] nhận được bạc tạo vật \"(RelicConfig.Arg1)\", bị nhiễm \"(Skill.Arg2)\""
  },
  Event_74174_ChoiceDesc2 = {
    Text = "[Hồi ức] Tất cả thân thể được đánh thức phục hồi 50 điên cuồng và nhiễm [(Skill.Arg1)]"
  },
  Event_74174_ChoiceDesc3 = {
    Text = "[bỏ qua tiếng ồn] nhận được 1 trong 3 khắcin"
  },
  Event_74174_Desc = {
    Text = "Bạn đã nghe thấy âm thanh biến dạng của kim máy hát. \nKim bị vặn vẹo lướt qua rãnh xoắn bị hỏng, phát ra những rung động rợn người một cách từ tốn."
  },
  Event_74174_Name = {
    Text = "Tiếng động lạ từ tháp đồng hồ"
  },
  Event_74175_ChoiceDesc1 = {
    Text = "[Chơi nhạc cho anh ấy] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_74175_ChoiceDesc2 = {
    Text = "[Lắng nghe tiếng đàn] Mỗi thân thể được đánh thức có điên cuồng ≥50 nhận được 15 dấu đen"
  },
  Event_74175_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 1 trong 3 khắcăng"
  },
  Event_74175_Desc = {
    Text = "\"Thân gửi John: \n    Dạo này, tôi chợt nhận ra rằng đã nhiều năm trôi qua kể từ lần cuối bạn chơi piano cho chúng tôi nghe. \n    Năm nay tôi 81 tuổi rồi, càng lớn tuổi thì những kỷ niệm thời trẻ càng trở nên quý giá hơn bao giờ hết. \n    Nếu bạn nhận được bức thư này, mong rằng khi bạn ghé qua Lentiennam lần tới, bạn sẽ dừng chân trước căn hộ của tôi và chơi giúp tôi một bản nhạc nhé.\""
  },
  Event_74175_Name = {
    Text = "Sonata của tiếc nuối"
  },
  Event_74176_ChoiceDesc1 = {Text = "[đi]"},
  Event_74176_Desc = {
    Text = "Khát vọng sinh tồn dâng trào trong lồng ngực, bạn không do dự ra lệnh. \n Đợi bạn thoát khỏi vòng vây, khi bạn quay lại nhìn, ngôi sao đó đã bị dung dịch ăn mòn nhấn chìm. \n Trong dòng chảy của dung dịch ăn mòn, vang lên một chuỗi âm thanh sắc nhọn có nhịp điệu. \n Bạn chạm vào bề mặt của dung dịch ăn mòn, một ngôi sao mục nát rơi vào lòng bàn tay bạn."
  },
  Event_74176_Name = {
    Text = "Sao đã rơi"
  },
  Event_74177_ChoiceDesc1 = {Text = "[đi]"},
  Event_74177_Desc = {
    Text = "Bạn nhặt lấy ngôi sao đó, nó nằm trong lòng bàn tay bạn nhưng đã mất đi ánh sáng. \n Một cảm giác áp bức đột ngột ập đến, một luồng lạnh lẽo khiến sống lưng bạn tê dại. \n Sự sống và cái chết chỉ trong chớp mắt, bạn nghiêng người tránh đi, vừa kịp né tránh một đòn tấn công ác liệt, nhưng trên cánh tay vẫn còn để lại một vết trầy dài hai inch."
  },
  Event_74177_Name = {
    Text = "Sao đã rơi"
  },
  Event_74178_ChoiceDesc1 = {Text = "[đi]"},
  Event_74178_Desc = {
    Text = "Răng sắc ẩn náu trong xúc tu đã xé toạc ống tay áo của bạn, dòng huyết tương rỉ ra như một dòng chảy đỏ tươi, chảy xuống xương cổ tay. \n Bạn không thể phân biệt ánh mắt của Sara, nhưng cái đầu bị nứt của cô ấy mơ hồ phát ra tiếng gào thét run rẩy vì đau đớn."
  },
  Event_74178_Name = {
    Text = "Đêm kinh hoàng tái hiện"
  },
  Event_74179_ChoiceDesc1 = {Text = "[đi]"},
  Event_74179_Desc = {
    Text = "Bạn nhìn xung quanh, đi qua đi lại, âm thanh giống như một con chuột đang chơi trốn tìm với bạn, lúc bên trái lúc bên phải, thỉnh thoảng xa thỉnh thoảng gần. \n Bạn vòng vo mãi, nhưng âm thanh càng lúc càng ồn ào, tiếng kim loại cọ xát khiến bạn rơi vào trạng thái bất an sâu sắc hơn. \n Bạn chợt nảy ra một ý tưởng, sờ vào túi mình, mặc dù không phát hiện ra nguồn âm thanh, nhưng lại nhặt được một vật báu nhỏ."
  },
  Event_74179_Name = {
    Text = "Tiếng động lạ từ tháp đồng hồ"
  },
  Event_7417_ChoiceDesc1 = {
    Text = "[rời đi] bạn đã mất(Arg1) điểm sức sống, bị nhiễm [(Skill.Arg2)]"
  },
  Event_7417_Desc = {
    Text = "\"Đứa trẻ ngoan. Tuy nhiên, ta vẫn phải đưa ra một hình phạt nhỏ cho em.\"\nTiếng cười khẽ của Đào Đen Đá tan biến trong khe hở chiều."
  },
  Event_7417_Name = {
    Text = "Thời gian gợi ý"
  },
  Event_74180_ChoiceDesc1 = {Text = "[đi]"},
  Event_74180_Desc = {
    Text = "Bạn dời mắt đi, không để ánh mắt va chạm với cô ấy. \nTuy nhiên, lực lượng nào đó vẫn khiến trái tim bạn đập thình thịch một cách bất an."
  },
  Event_74180_Name = {
    Text = "Ánh nhìn cuối cùng"
  },
  Event_74181_ChoiceDesc1 = {Text = "[đi]"},
  Event_74181_Desc = {
    Text = "Yu Li-ét nhìn bạn, ánh mắt giao nhau. \n Trong giây tiếp theo, cô ấy nở một nụ cười điên cuồng hoàn toàn, như thể đang chế nhạo sự kiêu ngạo và ngu dốt của bạn. \n Tuy nhiên, nụ cười đó nhanh chóng biến mất, và những người khác cũng không có phản ứng gì... dường như chỉ là ảo giác của bạn."
  },
  Event_74181_Name = {
    Text = "Ánh nhìn cuối cùng"
  },
  Event_7418_ChoiceDesc1 = {
    Text = "[ có nhiệm vụ sáng tạo 1, nhận được vật sáng tạo vàng 「(RelicConfig.Arg1)」 ]"
  },
  Event_7418_ChoiceDesc2 = {
    Text = "[có nhiệm vụ sáng tạo 2, nhận được vật tạo vàng 「(RelicConfig.Arg1)」]"
  },
  Event_7418_ChoiceDesc3 = {
    Text = "[Ngẫu nhiên 1 thẻ lệnh nhận dấu ấn:「(EnchantConfig.Arg1)」]"
  },
  Event_7418_Desc = {
    Text = "Sự kiện 254 (đang phát triển), đây không phải là hiệu ứng cuối cùng"
  },
  Event_7418_Name = {
    Text = "Sự kiện 254 (đang trong giai đoạn phát triển)"
  },
  Event_7419_ChoiceDesc1 = {
    Text = "[Nộp dấu ấn đặc biệt 1, ngẫu nhiên 1 thẻ lệnh nhận dấu ấn:「(EnchantConfig.Arg1)」]"
  },
  Event_7419_ChoiceDesc2 = {
    Text = "[Nộp dấu ấn đặc biệt 2, ngẫu nhiên 1 thẻ lệnh nhận dấu ấn:「(EnchantConfig.Arg1)」]"
  },
  Event_7419_ChoiceDesc3 = {
    Text = "[Nhiễm 「(Skill.Arg1)」và 「(Skill.Arg2)」, nhận được vật tạo vàng 「(RelicConfig.Arg3)」]"
  },
  Event_7419_Desc = {
    Text = "Sự kiện 255 (đang phát triển), chưa phải là phiên bản hoàn chỉnh"
  },
  Event_7419_Name = {
    Text = "Sự kiện 255 (trong quá trình phát triển)"
  },
  Event_7420_ChoiceDesc1 = {
    Text = "[dodge thẻ bướm] xóa 2 thẻ bài"
  },
  Event_7420_ChoiceDesc2 = {
    Text = "[ôm bướm] nhận được vật bị nguyền rủa \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7420_ChoiceDesc3 = {
    Text = "[Rời đi] Nhận được Arg1 dấu đen"
  },
  Event_7420_Desc = {
    Text = "Một khúc quanh, lại một khúc quanh, con đường truy đuổi chó địa ngục dường như không có hồi kết. \n Cổ chân đau nhức, não bộ sưng lên, trong hỗn loạn bạn lại thấy bướm, bạn biết đó là những ý nghĩ điên cuồng, những lời thì thầm của thâm cảnh. Chúng vỗ cánh từ bốn phương tám hướng tràn tới."
  },
  Event_7420_Name = {
    Text = "Sóng cuồng loạn"
  },
  Event_7421_ChoiceDesc1 = {Text = "[đi]"},
  Event_7421_Desc = {
    Text = "Bạn nhẹ nhàng nhấn chuông gió. Tiếng chuông vang lên vài lần rồi chìm vào im lặng. Nó đã lui về——chỉ trở lại trong cơn ác mộng."
  },
  Event_7421_Name = {
    Text = "Chuông gió nhỏ"
  },
  Event_7422_ChoiceDesc1 = {Text = "[đi]"},
  Event_7422_Desc = {
    Text = "Tiếng chuông vang nhẹ vài lần rồi chìm vào im lặng. Nó đã lui về——chỉ trở lại trong những cơn ác mộng."
  },
  Event_7422_Name = {
    Text = "Chuông gió nhỏ"
  },
  Event_7423_ChoiceDesc1 = {Text = "[đi]"},
  Event_7423_Desc = {
    Text = "\"Không tồi, bạn rất cẩn thận.\"\nTiếng nói xa xôi bất ngờ vọng ra từ quả gió chuông.\n \"Sự cẩn thận sẽ mang lại cho bạn một chút phần thưởng nhỏ, nhưng cũng chỉ có vậy mà thôi.\""
  },
  Event_7423_Name = {
    Text = "Chuông gió nhỏ"
  },
  Event_74245_ChoiceDesc1 = {
    Text = "[rời đi] nhận được bạc tạo vật [(RelicConfig.Arg1)]"
  },
  Event_74245_Desc = {
    Text = "Lộc cộc, hạt xí ngầu hăng hái nhảy múa trong chén lắc, nhảy đến kiệt sức. \n\n \"Bạn thua rồi, nhưng vì đã chơi cùng tôi, bạn vẫn nhận được phần thưởng.\""
  },
  Event_74245_Name = {
    Text = "Lời nhắn của N"
  },
  Event_74246_ChoiceDesc1 = {
    Text = "[đóng cửa chắn] nhiễm \"(Skill.Arg1)\", ngẫu nhiên 1 thẻ lệnh nhận khắcăng: \"(EnchantConfig.Arg2)\""
  },
  Event_74246_ChoiceDesc2 = {
    Text = "[Vội vã tránh xa] bị nhiễm \"(Skill.Arg1)\", ngẫu nhiên 1 thẻ lệnh nhận khắc ấn: \"(EnchantConfig.Arg2)\""
  },
  Event_74246_ChoiceDesc3 = {
    Text = "[bỏ qua] Chọn 1 thẻ lệnh từ 3 thẻ lệnh để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_74246_Desc = {
    Text = "Bạn đang sâu lún trong mê cung được xây dựng từ hơi nước và bánh răng, những ống đồng trên đầu quấn lại thành mạng nhện, mỗi lần hít thở đều khuấy động sương mù dầu máy đặc sệt. \n Mặt đồng hồ cơ khí mất kiểm soát co giật trên tường, kim đồng hồ cắt ngang thang đo văng ra những tia lửa lẻ tẻ, giống như đom đóm đang hấp hối trong phòng thí nghiệm Victoria. Các mối hàn rỉ ra gỉ đồng, như những vết thương đang mục nát của con quái vật thép này, trong khi chiếc đồng hồ bỏ túi của bạn đã ngừng hoạt động từ lâu - thời gian ở đây chỉ là lời cầu nguyện của những bánh răng khớp nhau."
  },
  Event_74246_Name = {
    Text = "Thành phố hơi nước"
  },
  Event_74247_ChoiceDesc1 = {
    Text = "[Đặt cược] Áp dụng [(Skill.Arg1)], bước vào ván cược"
  },
  Event_74247_ChoiceDesc2 = {
    Text = "[thôi đi] nhận được 25 dấu đen"
  },
  Event_74247_Desc = {
    Text = "Trong làn sương mù đen tối ở góc phố, một hơi thở nặng nề lan tỏa ra. \n Trong sương mù, hai viên xúc xắc cổ xưa và lạnh lẽo dần dần xuất hiện, bề mặt đầy những ký hiệu không thể giải mã và hoa văn kỳ quái. \n Chúng nằm im lặng trên tấm bảng đá trơn ướt, dường như đang chờ đợi một lời gọi bí ẩn nào đó. \n \"Bạn biết tôi là ai. Bạn có muốn thử đánh cược một ván không?\""
  },
  Event_74247_Name = {
    Text = "Lời nhắn của N"
  },
  Event_74248_ChoiceDesc1 = {Text = "[đi]"},
  Event_74248_Desc = {
    Text = "\"Tôi mơ thấy một thảm họa quét sạch mọi thứ, nhấn chìm ánh hào quang của quá khứ. Tôi cảm thấy tức giận với cuộc sống, và bất lực trước sự vô vọng về tương lai. Tâm hồn tôi bị nỗi sợ hãi xé nát, mong rằng trong khoảnh khắc sắp sụp đổ này, các bạn sẽ cảnh giác, đừng để số phận kinh hoàng này đến.\""
  },
  Event_74248_Name = {
    Text = "Lời nói cuối cùng không rõ ràng"
  },
  Event_74249_ChoiceDesc1 = {Text = "[đi]"},
  Event_74249_Desc = {
    Text = "Khói đen run rẩy thất vọng. \nSau đó, con xúc xắc biến mất chỉ sau một cái chớp mắt. \n\nChỉ còn một câu hỏi duy nhất đọng lại trong tâm trí bạn: \nNhững con xúc xắc này rốt cuộc được làm từ gì?"
  },
  Event_74249_Name = {
    Text = "Lời nhắn của N"
  },
  Event_7424_ChoiceDesc1 = {Text = "[đi]"},
  Event_7424_Desc = {
    Text = "Bạn quay người lại, nhìn thấy một đôi giày da và hình bóng mờ nhạt của một con người. \nDường như đó là một quý ông trẻ tuổi. \n \"Xin lỗi vì đã làm phiền, anh có nhìn thấy một đôi giày da Oxford màu đen không?\"\n \"Trước mặt anh đây chính là một đôi.\"\n \"Không, không... Đây là da dê, không phải da bò. \nTôi đã bị mắc kẹt trong bảo tàng sáp này mười hai năm rồi, chắc chắn là do đôi giày không đúng...\"\nGiọng nói lẩm bẩm, dần dần yếu đi."
  },
  Event_7424_Name = {
    Text = "bước chân"
  },
  Event_74250_ChoiceDesc1 = {
    Text = "[Phân biệt giọng nói của đàn ông] Lấy ngẫu nhiên 3 thẻ lệnh từ bộ bài và chọn 1 thẻ để sao chép"
  },
  Event_74250_ChoiceDesc2 = {
    Text = "[Phân biệt giọng nói của người phụ nữ] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", lây nhiễm \"(Skill.Arg2)\""
  },
  Event_74250_ChoiceDesc3 = {
    Text = "[ Phân biệt giọng nói của người già ] nhận được 25 dấu đen"
  },
  Event_74250_Desc = {
    Text = "Bạn đứng một mình trong một đầm lầy tối tăm. \n Trong sự mờ ảo, bạn nghe thấy những tiếng thì thầm hỗn mang như sóng biển dâng trào, có tiếng từ những người già tuổi cao, có tiếng từ những đứa trẻ mới biết nói, có tiếng từ những người phụ nữ lo âu, có tiếng từ những người đàn ông sợ hãi không rõ lý do..."
  },
  Event_74250_Name = {
    Text = "Lời nói cuối cùng không rõ ràng"
  },
  Event_74251_ChoiceDesc1 = {
    Text = "[Tiến lên] Lấy ngẫu nhiên 3 thẻ lệnh từ bộ bài, chọn 1 thẻ để xóa, nhận được 75 dấu đen"
  },
  Event_74251_ChoiceDesc2 = {
    Text = "[Nghỉ ngơi] Lấy ngẫu nhiên 3 thẻ lệnh từ bộ bài, chọn 1 bản sao ban đầu vào bộ bài, nhận 25 dấu đen"
  },
  Event_74251_ChoiceDesc3 = {
    Text = "[Hồi vọng] nhận được 50 dấu đen"
  },
  Event_74251_Desc = {
    Text = "Bạn đi trên con đường vắng vẻ, dấu chân để lại những dấu chân sâu hoắm trên tro tàn. \n\nĐường phố thành phố như mạng nhện, bạn là con bướm bị trói buộc."
  },
  Event_74251_Name = {
    Text = "Thành phố Bóng tối"
  },
  Event_74252_ChoiceDesc1 = {Text = "[đi]"},
  Event_74252_Desc = {
    Text = "Khi cánh cửa hơi nước đóng sầm lại với một tiếng động lớn, bạn nghe thấy bóng của mình đang bị những ren ăn khớp chính xác nghiền nát từng chút một."
  },
  Event_74252_Name = {
    Text = "Thành phố hơi nước"
  },
  Event_74253_ChoiceDesc1 = {Text = "[đi]"},
  Event_74253_Desc = {
    Text = "Cảnh tượng lặp đi lặp lại tiếp tục làm mới trước mắt, bạn không có đường để trốn."
  },
  Event_74253_Name = {
    Text = "Thành phố hơi nước"
  },
  Event_74254_ChoiceDesc1 = {Text = "[đi]"},
  Event_74254_Desc = {
    Text = "Thời gian là tọa độ không liên quan, điều bạn mong đợi duy nhất là chân lý."
  },
  Event_74254_Name = {
    Text = "Thành phố hơi nước"
  },
  Event_74255_ChoiceDesc1 = {
    Text = "[ba điểm]"
  },
  Event_74255_ChoiceDesc2 = {
    Text = "[sáu giờ]"
  },
  Event_74255_ChoiceDesc3 = {
    Text = "[một điểm]"
  },
  Event_74255_Desc = {
    Text = "Ai sẽ dám ném viên xúc xắc mang ý nghĩa bất hạnh và điên rồ? \n Bạn, đương nhiên là bạn. \n Bạn chọn —"
  },
  Event_74255_Name = {
    Text = "Lời nhắn của N"
  },
  Event_74256_ChoiceDesc1 = {
    Text = "[rời đi] nhận được 50 dấu đen"
  },
  Event_74256_Desc = {
    Text = "Lộc cộc, hạt xí ngầu hăng hái nhảy múa trong chén lắc, nhảy đến kiệt sức. \n\n \"Bạn thua rồi, nhưng vì đã chơi cùng tôi, bạn vẫn nhận được phần thưởng.\""
  },
  Event_74256_Name = {
    Text = "Lời nhắn của N"
  },
  Event_74257_ChoiceDesc1 = {Text = "[đi]"},
  Event_74257_Desc = {
    Text = "Đường đến là sự tối tăm vô tận và hỗn loạn mênh mông. \n Không còn thời gian để nghĩ về số phận của mình, bạn phải loại bỏ nỗi sợ hãi và đến đích của mình trước khi bản án đến."
  },
  Event_74257_Name = {
    Text = "Thành phố Bóng tối"
  },
  Event_74258_ChoiceDesc1 = {Text = "[đi]"},
  Event_74258_Desc = {
    Text = "\"Khi tôi ngồi trong bóng tối của thời gian, cảm nhận bàn tay lạnh lùng của cái chết dần dần tiến gần. Thế giới bên ngoài cửa sổ trở nên ngày càng mờ tối, tràn ngập những lời thì thầm của thảm họa. Tôi sợ hãi trước sự phán xét sắp đến, đối mặt với sự thanh toán cho sự ngu ngốc của chúng tôi. Đường phố tràn ngập không khí bất lành, tôi lo lắng ngày phán xét của chúng tôi đang cận kề. Văn minh của chúng tôi đang lung lay, như thể bị hủy diệt nuốt chửng, mắc kẹt trong sự kiêu ngạo ngu dại của chính mình.\""
  },
  Event_74258_Name = {
    Text = "Lời nói cuối cùng không rõ ràng"
  },
  Event_74259_ChoiceDesc1 = {Text = "[đi]"},
  Event_74259_Desc = {
    Text = "Sống sót đã là điều không dễ, ngươi không nên đòi hỏi nhiều hơn. \nNhững bức tường đổ nát và bóng đổ của đống đổ nát vẫn đang gọi mời ngươi."
  },
  Event_74259_Name = {
    Text = "Thành phố Bóng tối"
  },
  Event_7425_ChoiceDesc1 = {
    Text = "[rời đi] nhận được 1 trong 3 khắcăng"
  },
  Event_7425_Desc = {
    Text = "\"Thế này à... thật thú vị.\"\nCô ấy thu lại bảng câu hỏi, chỉ về phía lũ trẻ vừa rời đi. Bạn vội vàng bước đi, suýt chút nữa đã không nghe thấy tiếng thì thầm từ phía sau.\n \"Hãy mong chờ cuộc gặp gỡ tiếp theo của chúng ta.\""
  },
  Event_7425_Name = {
    Text = "Đánh giá tâm lý"
  },
  Event_74260_ChoiceDesc1 = {Text = "[đi]"},
  Event_74260_Desc = {
    Text = "Bạn đang bị chi phối bởi một lực lượng to lớn hoặc một số phận hùng mạnh. \nDù nghỉ ngơi ngắn không thể thay đổi tình hình này, nhưng ít nhất nó có thể mang lại động lực cho đôi chân nhức mỏi tiếp tục tiến lên."
  },
  Event_74260_Name = {
    Text = "Thành phố Bóng tối"
  },
  Event_74261_ChoiceDesc1 = {Text = "[đi]"},
  Event_74261_Desc = {
    Text = "\"... thành phố không còn là nơi trú ẩn ấm áp, mà trở thành ngôi mộ bí mật, ấp ủ sự kinh hoàng và tuyệt vọng. Những giấc mơ từng sống động nay chỉ còn lại những mảnh vụn của nỗi sợ hãi. Tôi không thể tiếp tục giả vờ rằng mình không sợ hãi, thế giới trước mắt giống như một cơn ác mộng, không thể thoát ra.\""
  },
  Event_74261_Name = {
    Text = "Lời nói cuối cùng không rõ ràng"
  },
  Event_74262_ChoiceDesc1 = {
    Text = "[Rời đi] nhận được vật tạo vàng[(RelicConfig.Arg1)]"
  },
  Event_74262_Desc = {
    Text = "Lộc cộc, hạt xí ngầu hăng hái nhảy múa trong chén lắc, nhảy đến kiệt sức. \n\n \"Bạn thua rồi, nhưng vì đã chơi cùng tôi, bạn vẫn nhận được phần thưởng.\""
  },
  Event_74262_Name = {
    Text = "Lời nhắn của N"
  },
  Event_7426_ChoiceDesc1 = {
    Text = "[rời đi] ngẫu nhiên 1 thẻ lệnh nhận được khắcăng: gương"
  },
  Event_7426_Desc = {
    Text = "\"Không sao, tôi đã thấy câu trả lời trong mắt bạn. Tôi còn một số việc cần giải quyết, tạm thời phải lui xuống. Bạn cũng có việc cần xử lý phải không? Nhìn bên kia, có người đang tìm bạn.\"\nBạn quay đầu lại, hình bóng của Hội Giáo đèn lồng xuất hiện ở cuối con đường."
  },
  Event_7426_Name = {
    Text = "Khách đồng hành kỳ quái Ⅴ"
  },
  Event_7427_ChoiceDesc1 = {
    Text = "[Rời đi] Lấy ngẫu nhiên 1 thẻ lệnh và nhận khắcăng: Toán Pháp"
  },
  Event_7427_Desc = {
    Text = "\"Dường như bạn vẫn chưa muốn mở lòng với tôi. Tôi rất thất vọng, nhưng không sao, tôi vẫn sẽ đưa ra những gợi ý thân thiện nhất: Hội Giáo đèn lồng xuất hiện tại đây, rốt cuộc là đang tìm kiếm điều gì?\"\n \"Ôi, dường như có người không muốn chúng ta trò chuyện nữa. Nhìn kìa, có người đang đến tìm bạn.\"\nBạn quay đầu lại, bóng dáng đám tín đồ cầm đèn xuất hiện ở cuối con đường."
  },
  Event_7427_Name = {
    Text = "Khách đồng hành kỳ quái Ⅴ"
  },
  Event_7428_ChoiceDesc1 = {
    Text = "[Rời đi] Random 1 thẻ lệnh nhận khắcăng: cảm hứng"
  },
  Event_7428_Desc = {
    Text = "\"Bạn rất thành thực, xứng đáng được khen thưởng. Vì vậy, tôi quyết định cho bạn một chút gợi ý: Tại sao bạn vừa đến thị trấn Rai lại bị Người ấy để mắt đến?\"\n \"Ôi, có vẻ như có người không muốn chúng ta trò chuyện rồi. Nhìn kìa, có người đang tìm bạn đấy.\"\nBạn quay đầu lại, bóng dáng của đám tín đồ cầm đèn xuất hiện ở cuối con đường."
  },
  Event_7428_Name = {
    Text = "Khách đồng hành kỳ quái Ⅴ"
  },
  Event_7429_ChoiceDesc1 = {Text = "[đi]"},
  Event_7429_Desc = {
    Text = "Tiếng ồn ào dần dần lắng xuống, tay bạn trống không, nhưng cảm xúc tức thì đã được Chìa khóa bạc ghi lại."
  },
  Event_7429_Name = {
    Text = "Sách của Không"
  },
  Event_7430_ChoiceDesc1 = {Text = "[đi]"},
  Event_7430_Desc = {
    Text = "Bạn đưa tay ra bốn phía trong hỗn loạn, trong một mảng hỗn loạn có một vật kỳ lạ về cảm giác rơi vào tay bạn, dần dần tụ lại thành hình."
  },
  Event_7430_Name = {
    Text = "Sách của Không"
  },
  Event_7431_ChoiceDesc1 = {
    Text = "[Rời đi] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7431_Desc = {
    Text = "\"Bạn có nghe nói về cách săn mồi của rắn không? Rắn chỉ có thể bò trên mặt đất, uốn lượn di chuyển, vì vậy không thể đuổi theo như báo, cũng không thể như bầy sói bao vây con mồi. Ngược lại, rắn đã học được cách kiên nhẫn chờ đợi.\"\n \"Chúng chờ đợi khoảnh khắc con mồi mất cảnh giác, sau đó tấn công bất ngờ, một đòn nuốt trọn chúng vào bụng.\""
  },
  Event_7431_Name = {
    Text = "Khách lữ kỳ quái Ⅲ"
  },
  Event_7432_ChoiceDesc1 = {Text = "[đi]"},
  Event_7432_Desc = {
    Text = "Dường như bị làm phiền, lông mèo đen bóng chỉ để lại một chút cảm giác bỏng rát nhẹ trên đầu ngón tay bạn, sau đó biến mất trong sương mù sâu thẳm."
  },
  Event_7432_Name = {
    Text = "Đám tai ương của mèo đêm"
  },
  Event_7433_ChoiceDesc1 = {Text = "[đi]"},
  Event_7433_Desc = {
    Text = "Chỉ là những lời nói vô nghĩa của đám tín đồ cuồng nhiệt mà thôi."
  },
  Event_7433_Name = {
    Text = "Lệnh bí mật·dưới"
  },
  Event_7434_ChoiceDesc1 = {
    Text = "[tiếp tục nghe lén] nhận được chọn 1 trong 3 khắc ấn"
  },
  Event_7434_ChoiceDesc2 = {
    Text = "[Ho lớn] Chọn 1 từ 3 thẻ lệnh để nhận khắcăng: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7434_Desc = {
    Text = "Góc tường nứt ra nhiều vết nứt nhỏ, uốn lượn như những mạch máu. \n Kèm theo tiếng ong ong nhẹ, bạn nghe thấy giọng nói trầm của một người đàn ông từ bên kia vọng lại. \n \"Quận Quentin 5, Quận Wellington 10, Quận Norman 15... \n Nguyên liệu của tháng này đã được đóng gói xong, chuẩn bị vận chuyển, số hàng I-0234... \n... \n Ngoài ra, do nhóm Misaque gây ra, khu vực Whitechapel hiện đang trong trạng thái giới nghiêm, chúng tôi đã mất nguồn nguyên liệu lớn nhất.\""
  },
  Event_7434_Name = {
    Text = "Cách tường có tai"
  },
  Event_7435_ChoiceDesc1 = {
    Text = "[Xua đuổi quạ] nhận được 20 dấu đen, nhiễm [(Skill.Arg2)]"
  },
  Event_7435_ChoiceDesc2 = {
    Text = "[tiếp tục đuổi theo đứa trẻ] rời đi"
  },
  Event_7435_Desc = {
    Text = "Trong sự đe dọa của bạn, tất cả các con quạ bay tán loạn về bốn phương tám hướng với tiếng vỗ cánh ào ào, đôi cánh đen tối phập phồng rơi xuống tan ra thành chất nhầy, nhỏ xuống tạo thành dấu đen."
  },
  Event_7435_Name = {
    Text = "Nhìn chằm chằm của Quạ Đen"
  },
  Event_7436_ChoiceDesc1 = {
    Text = "[bỏ qua sự kháng cự] xóa 1 thẻ lệnh, nhận Arg1 dấu đen"
  },
  Event_7436_ChoiceDesc2 = {
    Text = "[rút hai tay]"
  },
  Event_7436_Desc = {
    Text = "Một chiếc máy đánh chữ kiểu mới. \n Nó có một bộ phím chữ khác biệt, giống như một chiếc kính hiển vi, vừa lộng lẫy vừa tinh xảo. \n Bạn tò mò đặt tay lên, nhưng lại phát hiện chúng không kiểm soát được mà bay nhảy lên xuống trên bàn phím, tốc độ ngày càng nhanh, càng lúc càng nhanh……"
  },
  Event_7436_Name = {
    Text = "Bùng nổ cảm hứng"
  },
  Event_7437_ChoiceDesc1 = {Text = "[đi]"},
  Event_7437_Desc = {
    Text = "Chỉ là sinh linh đang đấu tranh để sống sót, tìm kiếm một mảnh gỗ để nghỉ ngơi mà thôi……\nBạn thở dài, để cho dung dịch đen từ đuôi con bướm chảy xuống má."
  },
  Event_7437_Name = {
    Text = "Bướm Dung Dịch Đen"
  },
  Event_7438_ChoiceDesc1 = {Text = "[đi]"},
  Event_7438_Desc = {
    Text = "Bạn đã nhận được yêu cầu liên lạc từ trường, giọng nói quen thuộc giúp tâm trạng bạn bình yên lại. Bạn lấy lại tinh thần và tiếp tục tiến lên."
  },
  Event_7438_Name = {
    Text = "điểm liên lạc"
  },
  Event_7439_ChoiceDesc1 = {Text = "[đi]"},
  Event_7439_Desc = {
    Text = "Bạn đã nhận được yêu cầu liên lạc từ trường, giọng nói quen thuộc giúp tâm trạng bạn bình yên lại. Bạn lấy lại tinh thần và tiếp tục tiến lên."
  },
  Event_7439_Name = {
    Text = "điểm liên lạc"
  },
  Event_7440_ChoiceDesc1 = {Text = "[đi]"},
  Event_7440_Desc = {
    Text = "Sự nghi ngờ của bạn tan vào không khí, không ai trả lời. Ánh sáng vàng ấm áp từ cửa sổ chiếu vào, mang lại cảm giác như những ký ức xưa cũ."
  },
  Event_7440_Name = {
    Text = "Ký ức núi lửa"
  },
  Event_7441_ChoiceDesc1 = {
    Text = "[Nhặt lên] bị lây nhiễm \"(Skill.Arg1)\", nhận được bạc tạo vật \"(RelicConfig.Arg2)\""
  },
  Event_7441_ChoiceDesc2 = {
    Text = "[do dự] nhận được 25 dấu đen"
  },
  Event_7441_Desc = {
    Text = "Trong thùng gỗ ở góc hẻm, có vật gì đó màu sắc kỳ lạ đang nổi lên. Sự xuất hiện bất thường như một lời cảnh báo, \"không được chạm vào\"."
  },
  Event_7441_Name = {
    Text = "Đối tượng nổi trong xô"
  },
  Event_7442_ChoiceDesc1 = {
    Text = "[giao cho cô ấy] nhận được chọn 1 trong 3 bạc sáng tạo"
  },
  Event_7442_ChoiceDesc2 = {
    Text = "[có chút tình huống] nhận được bạc tạo vật \"(RelicConfig.Arg1)\"\"(RelicConfig.Arg2)\", nhiễm hai lần \"(Skill.Arg3)\""
  },
  Event_7442_Desc = {
    Text = "\"Đây là thông tin từ Misaque, tôi là Erika. Phát hiện thân thể được đánh thức lơ-tan có chỉ số Nos bất thường, liệu có cần hỗ trợ không?\""
  },
  Event_7442_Name = {
    Text = "Hỗ trợ thông tin"
  },
  Event_7443_ChoiceDesc1 = {Text = "[đi]"},
  Event_7443_Desc = {
    Text = "Ngươi nghe theo lời khuyên không có thiện ý bên tai, tiếng rít như mũi kim xoắn vặn đâm vào lỗ tai ngươi.\n\"Dừng lại — mau dừng lại — ta đã làm theo lời ngươi rồi — mau dừng —\"\nNgươi đau đớn ôm lấy đầu, trong cơn mê man nghe thấy tiếng bầy quạ chế giễu."
  },
  Event_7443_Name = {
    Text = "Bài hát của đàn quạ"
  },
  Event_7444_ChoiceDesc1 = {Text = "[đi]"},
  Event_7444_Desc = {
    Text = "Được đặt ở vị trí này, không ngoài hai khả năng: vật bị bỏ qua, hoặc vật được trân trọng. Nếu thuộc trường hợp sau, tốt nhất nên để lại cho chủ nhân ban đầu."
  },
  Event_7444_Name = {
    Text = "bạc tâm cô đơn"
  },
  Event_7445_ChoiceDesc1 = {Text = "[đi]"},
  Event_7445_Desc = {
    Text = "Điều hạnh phúc nhất chính là sự vô tri."
  },
  Event_7445_Name = {Text = "Nhìn lén"},
  Event_7446_ChoiceDesc1 = {
    Text = "[Tạo quái vật bình thường]"
  },
  Event_7446_ChoiceDesc2 = {
    Text = "[Sinh ra ô đất trống]"
  },
  Event_7446_ChoiceDesc3 = {
    Text = "[Tạo ra hư không]"
  },
  Event_7446_Desc = {
    Text = "Xem thử có thể tạo ra gì"
  },
  Event_7446_Name = {
    Text = "[chờ đóng gói]"
  },
  Event_7447_ChoiceDesc1 = {Text = "[đi]"},
  Event_7447_Desc = {
    Text = "\"Bình tĩnh,\" Ramona gõ nhẹ vào đầu bạn,\"chỉ là những phân mảnh của quá khứ. Không biết ai đã để lại ở lối dẫn chiều này.\"\nQuả thật, có một mùi vị hoài niệm."
  },
  Event_7447_Name = {
    Text = "Hồi tưởng phân mảnh · Whisky"
  },
  Event_7448_ChoiceDesc1 = {
    Text = "[Thu thập] Nâng cấp 1 bạc sáng tạo thành vật tạo vàng [(RelicConfig.Arg1)]"
  },
  Event_7448_ChoiceDesc2 = {
    Text = "[vứt bỏ chúng] nhận được vật tạo vàng \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\" và\"(Skill.Arg3)\""
  },
  Event_7448_ChoiceDesc3 = {
    Text = "[Cẩn thận quan sát] nhận được 25 dấu đen"
  },
  Event_7448_Desc = {
    Text = "Đây có rất nhiều bạc tâm vỡ vụn. \n Mờ nhạt, tan vỡ... rõ ràng không phải là hàng cao cấp. \n Có lẽ chúng chính là một trong những lý do khiến các bình tượng nến có thể \"sống lại\". \n Ngay cả những bạc tâm thô kệch nhất cũng có khả năng tạo ra kỳ tích."
  },
  Event_7448_Name = {
    Text = "Linh hồn bị trói buộc"
  },
  Event_7449_ChoiceDesc1 = {
    Text = "[rời đi] nhận được 50 dấu đen"
  },
  Event_7449_Desc = {
    Text = "Kum đã dâng hiến tất cả những gì cô có thể. \nTiếp theo, đến lượt bạn làm cho sự hy sinh của cô ấy trở nên có ý nghĩa."
  },
  Event_7449_Name = {
    Text = "Nhiệt dư"
  },
  Event_7450_ChoiceDesc1 = {Text = "[đi]"},
  Event_7450_Desc = {
    Text = "Nguyện tuyết gió ban cho các bạn sự bình yên vĩnh cửu."
  },
  Event_7450_Name = {
    Text = "Di sản của người xưa"
  },
  Event_7451_ChoiceDesc1 = {Text = "[đi]"},
  Event_7451_Desc = {
    Text = "Bạn vẫn tỏ ra kiên cường, trong tiếng hát vẫn có thể theo đuổi bản thân mình. \nBạn không tin vào những lời thì thầm bên tai, mà chỉ dựa vào lý trí của con người. \nChỉ có điều... vào ngày mà mặt đất vững chắc để sống bị che phủ bởi chất lỏng đen đặc, việc đào mắt ra làm vật để nhìn sẽ là lựa chọn duy nhất của bạn trong những giây phút hấp hối."
  },
  Event_7451_Name = {
    Text = "Bài hát của đàn quạ"
  },
  Event_7452_ChoiceDesc1 = {
    Text = "[rời đi] chọn 1 thẻ lệnh từ 3 thẻ lệnh để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_7452_Desc = {
    Text = "Kum bị bạn kéo mạnh, may mắn tránh được một đòn. Cô ấy gật đầu cảm ơn bạn, rồi lại lao vào thực thể thí nghiệm."
  },
  Event_7452_Name = {
    Text = "Đấu trường"
  },
  Event_7453_ChoiceDesc1 = {Text = "[đi]"},
  Event_7453_Desc = {
    Text = "Linh tinh…\nĐồng xu rơi vào ví, phát ra tiếng vọng trong trẻo dễ chịu. \nVí thỏa mãn nhai nuốt, cuối cùng phát ra một tiếng ợ no. \nNó bị chinh phục bởi sự hào phóng của bạn, gỡ bỏ tất cả phòng bị với bạn. \nBây giờ, nó sẽ phục vụ bạn."
  },
  Event_7453_Name = {
    Text = "Ví tham lam"
  },
  Event_7454_ChoiceDesc1 = {Text = "[đi]"},
  Event_7454_Desc = {
    Text = "Đồng xu bằng đồng thau như rơi vào vực thẳm không thấy đáy, không phát ra bất kỳ âm thanh nào. \n Bạn kiên nhẫn chờ đợi trong năm phút. Ví phát ra tiếng rên rỉ đau đớn, cuối cùng nhả ra một vũng chất lỏng đen tối. \n Đây là sự phản kháng im lặng của nó."
  },
  Event_7454_Name = {
    Text = "Ví tham lam"
  },
  Event_7455_ChoiceDesc1 = {
    Text = "[nhìn về xa]"
  },
  Event_7455_ChoiceDesc2 = {
    Text = "[nghe kỹ]"
  },
  Event_7455_Desc = {
    Text = "Hilaster lắc chiếc la bàn trong tay, cô ấy không nói gì, nhưng bên cạnh lại vang lên những bài hát mơ hồ. \n Bài hát của thủy thủ vượt qua thời gian giao thoa tại đây, một bài hát thuyền hỗn loạn nhưng mạnh mẽ dẫn dắt bạn, khiến bạn nhìn về phía đầu kia của con tàu."
  },
  Event_7455_Name = {
    Text = "Bài hát thuyền"
  },
  Event_7456_ChoiceDesc1 = {Text = "[đi]"},
  Event_7456_Desc = {
    Text = "Bạn tiến lên ngắt lời buổi thực hành giảng dạy nhỏ này. \n Từ cử chỉ chơi đàn đến lý thuyết âm nhạc cơ bản, bạn không nương tay mà bình luận từng chút một. \n Âm thanh đột ngột ngừng lại, cậu bé và thầy giáo đồng loạt nhìn về phía bạn, trên mặt mang nụ cười kỳ quái giống nhau. \n 133, 355, 244…… \n Âm thanh của đàn lại vang lên, vẫn sai đến mức khó tin. \n Hóa ra họ không nghe thấy gì cả."
  },
  Event_7456_Name = {
    Text = "Bài học piano"
  },
  Event_7457_ChoiceDesc1 = {
    Text = "[thu vào túi]"
  },
  Event_7457_Desc = {
    Text = "Dấu ấn đen được phát hiện trong thâm cảnh, có thể hiến tế cho dấu vết tan chảy để đổi lấy hình chiếu tinh thần của các sáng tạo. Sau khi rời khỏi khu vực hiện tại, nó sẽ nhanh chóng biến thành bùn đen."
  },
  Event_7457_Name = {Text = "dấu đen"},
  Event_7458_ChoiceDesc1 = {Text = "[đi]"},
  Event_7458_Desc = {
    Text = "Điều quan trọng hơn là tìm thấy người bí ẩn đó. Ramona nghĩ vậy, nên nhanh chóng rời đi."
  },
  Event_7458_Name = {
    Text = "Tai người khác"
  },
  Event_7459_ChoiceDesc1 = {Text = "[đi]"},
  Event_7459_Desc = {
    Text = "Buông thả ý thức, theo dấu lời cầu nguyện chìm sâu xuống biển sâu. \n Bạn nhìn thấy vương quốc vàng chìm dưới đáy nước, nhìn thấy những bức tượng đá bất tử, cuối cùng đối diện với đôi mắt lấp lánh từ nơi u tối... \n \"Người không mang dòng máu thần... rời đi, rời đi.\""
  },
  Event_7459_Name = {
    Text = "Lời cầu nguyện giấc mơ"
  },
  Event_7460_ChoiceDesc1 = {
    Text = "[Leave] Chọn 1 vật bị nguyền rủa, lây nhiễm [(Skill.Arg1)]"
  },
  Event_7460_Desc = {
    Text = "Ramona đâm một kiếm xuyên qua cổ của cơ thể thí nghiệm, Kume hất ra cơ thể thí nghiệm đã mất sức sống và nhanh chóng lao tới mục tiêu kế tiếp."
  },
  Event_7460_Name = {
    Text = "Đấu trường"
  },
  Event_7461_ChoiceDesc1 = {Text = "[đi]"},
  Event_7461_Desc = {
    Text = "Chim quạ cắn xé lông của chính mình, giống như con người cắn xé thân thể của chính họ. \nTrong thế giới đầy sợ hãi này, điều này xảy ra rất thường xuyên. Bạn không thể cứu được tất cả chúng sinh."
  },
  Event_7461_Name = {
    Text = "Nước mắt dung nham"
  },
  Event_7462_ChoiceDesc1 = {
    Text = "[Xoa dịu Koom]"
  },
  Event_7462_ChoiceDesc2 = {
    Text = "[giúp Kume kêu gọi]"
  },
  Event_7462_Desc = {
    Text = "Quái vật khổng lồ gầm rú điên cuồng về phía những con người nhỏ bé, cố gắng đánh thức những người bạn cũ. Nhưng dây thanh quản đã bị tổn thương chỉ phát ra những âm thanh trầm đục và méo mó."
  },
  Event_7462_Name = {
    Text = "Gọi của tình bạn"
  },
  Event_7463_ChoiceDesc1 = {
    Text = "[Rời đi] tìm đèn pha"
  },
  Event_7463_ChoiceDesc2 = {
    Text = "[xâm nhập vào sương mù] mất Arg2 điểm sức sống"
  },
  Event_7463_Desc = {
    Text = "Phía trước là một vùng sương đen dày đặc, khinh suất tiến vào sẽ mang lại thảm họa. \nCó lẽ bạn nên tìm \"đèn pha\"để xua tan sương mù."
  },
  Event_7463_Name = {
    Text = "không biết"
  },
  Event_7464_ChoiceDesc1 = {Text = "[đi]"},
  Event_7464_Desc = {
    Text = "\"Hàm trên của bạn kêu răng rắc như vậy sao? Cả đời chưa từng thấy.\"\nBạn đã từ chối yêu cầu bất lịch sự của Ông Hàm. Ông Hàm thất vọng vô cùng, nhưng vẫn cố gắng giữ thể diện. \nĐể cảm ơn vì đã kiên nhẫn lắng nghe, ông ấy tặng bạn một quà tặng."
  },
  Event_7464_Name = {
    Text = "Kẽo kẹt"
  },
  Event_7465_ChoiceDesc1 = {Text = "[đi]"},
  Event_7465_Desc = {
    Text = "Bạn đã đồng ý với yêu cầu kỳ lạ này và mang theo Ông Hàm. \nNó nằm trong túi của bạn, không ngừng kêu răng rắc. Theo bản dịch của người bạn đồng hành, những lời nói đầy lòng biết ơn, nỗi nhớ và hối tiếc tuôn ra từ nó. \nCòn về việc tại sao ông ta lại trở thành như vậy? Ông Hàm không muốn nói nhiều, chỉ nói: \n \"Bạn hiểu mà. Khi bạn đối diện với @2, @2 cũng sẽ dõi theo ánh mắt của bạn.\""
  },
  Event_7465_Name = {
    Text = "Kẽo kẹt"
  },
  Event_7466_ChoiceDesc1 = {Text = "[đi]"},
  Event_7466_Desc = {
    Text = "Ngài ấy trượt vào túi xách của bạn như một đoạn lụa, cùng với trọng lượng nhẹ tăng lên, bạn có thể nghe thấy một lời cảm ơn khẽ vang lên. \nTừ đó, không còn âm thanh nào vang lên nữa."
  },
  Event_7466_Name = {
    Text = "Lin hồn hỗn loạn"
  },
  Event_7467_ChoiceDesc1 = {
    Text = "[Tiến lên]"
  },
  Event_7467_Desc = {
    Text = "Cạch. \nBạn chèn chìa khóa vào ổ khóa, nhẹ nhàng đẩy cửa mở. \nToàn bộ quá trình mở cửa diễn ra suôn sẻ, khiến bạn thêm tự tin cho cuộc điều tra tiếp theo."
  },
  Event_7467_Name = {
    Text = "cánh cửa rỉ sét"
  },
  Event_7468_ChoiceDesc1 = {Text = "[đi]"},
  Event_7468_Desc = {
    Text = "Tiếng đó cười trầm trầm. Chất lỏng dưới chân bạn dâng lên, tạo thành những gợn sóng. \n \"Bạn sẽ sớm hiểu rằng, ngoài cái chết ra, không có điều gì là bắt buộc phải làm cả.\""
  },
  Event_7468_Name = {
    Text = "Bạn sẽ không muốn tìm thấy"
  },
  Event_7469_ChoiceDesc1 = {Text = "[đi]"},
  Event_7469_Desc = {
    Text = "Bạn đã đánh mất ký ức này, kéo ý thức của mình ra khỏi sự an ủi hư ảo."
  },
  Event_7469_Name = {
    Text = "Chìm đắm trong những ngày xưa"
  },
  Event_7470_ChoiceDesc1 = {Text = "[đi]"},
  Event_7470_Desc = {
    Text = "Chỉ là ngủ nhẹ một lát thôi, nếu không có sự an ủi, bạn sẽ vượt qua đêm dài này như thế nào chứ…"
  },
  Event_7470_Name = {
    Text = "Chìm đắm trong những ngày xưa"
  },
  Event_7471_ChoiceDesc1 = {
    Text = "[Nhặt ảnh] Chọn 1 trong 3 thẻ lệnh để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_7471_Desc = {
    Text = "Đây là một nhóm ảnh chân dung. \n Những người uể oải ngồi xổm sau hàng rào sắt, trên mặt đầy vẻ khổ sở. \n Một bức ảnh trong số đó thu hút sự chú ý của bạn. Đó hẳn là một phụ nữ trẻ gầy yếu, mặt mũi trống rỗng. \n Sinh vật vô cùng xâm phạm đó, đang quấn quanh cơ thể cô ấy từng vòng từng vòng. \n Bạn không thể nhìn thấy mặt cô ấy, nhưng trong tưởng tượng của bạn, cô ấy chắc hẳn không có biểu cảm."
  },
  Event_7471_Name = {
    Text = "ghi lại trung thực"
  },
  Event_7472_ChoiceDesc1 = {Text = "[đi]"},
  Event_7472_Desc = {
    Text = "Đó là xác của một con chim."
  },
  Event_7472_Name = {
    Text = "Bầy quạ hỗn loạn"
  },
  Event_7473_ChoiceDesc1 = {Text = "[đi]"},
  Event_7473_Desc = {
    Text = "Bạn đã từ chối một cách dứt khoát yêu cầu của nghệ sĩ piano. \nNghệ sĩ piano cảm thấy vô cùng thất vọng. Ông ta cắt bỏ tai còn lại của mình và ném chúng ra ngoài cửa sổ. \n \"Dù sao tôi cũng không cần chúng nữa.\"\nNghệ sĩ piano buồn bã, gương mặt ủ rũ, cúi đầu gõ một chuỗi âm thanh đầy sầu muộn."
  },
  Event_7473_Name = {
    Text = "Dặt tai lắng nghe"
  },
  Event_7474_ChoiceDesc1 = {Text = "[đi]"},
  Event_7474_Desc = {
    Text = "Khóc lóc của Linh hồn Hỗn loạn càng lúc càng sắc nhọn, cho đến cuối cùng biến thành tiếng thét chói tai vang vọng xung quanh. \nNgài mang theo lễ vật của bạn và nỗi đau khổ không lối thoát, một lần nữa chìm vào bùn lầy tối tăm."
  },
  Event_7474_Name = {
    Text = "Lin hồn hỗn loạn"
  },
  Event_7475_ChoiceDesc1 = {Text = "[đi]"},
  Event_7475_Desc = {
    Text = "Đây là một kênh một chiều, bạn không thể qua nó để trở lại lối vào."
  },
  Event_7475_Name = {
    Text = "Đoạn đường"
  },
  Event_7476_ChoiceDesc1 = {
    Text = "[rời đi] nhận được sáng tạo \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7476_Desc = {
    Text = "\"Vậy thì, hãy nhắm mắt lại và tĩnh tâm cảm nhận tiếng bước chân của nó đến đi.\"\nBạn theo lời nhắm mắt lại. Trong nháy mắt, tiếng thở dồn dập của loài thú kỳ quái vang lên bên tai.\nVừa mở mắt ra vẫn còn bàng hoàng, người đàn ông vừa rồi đã biến mất không thấy đâu."
  },
  Event_7476_Name = {
    Text = "Bạn đồng hành kỳ quặc Ⅰ"
  },
  Event_7477_ChoiceDesc1 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_7477_Desc = {
    Text = "\"Đó thật sự là một điều đáng tiếc.\"\n Người đàn ông giọng buồn, chỉnh lại kính. \n \"Tuy nhiên, nếu các bạn chưa từng nghe nói về nó, thì tại sao lại đến đây vào ban đêm?\"\n Không đợi các bạn trả lời, người đàn ông đã quay người rời đi."
  },
  Event_7477_Name = {
    Text = "Bạn đồng hành kỳ quặc Ⅰ"
  },
  Event_7478_ChoiceDesc1 = {Text = "[đi]"},
  Event_7478_Desc = {
    Text = "Bạn bước đi với những bước chân kiên định, tiếp tục tiến lên.\nMột bước, hai bước, ba bước…\nTiếng bước chân phía sau dần chìm vào bóng tối.\nRồi các bạn sẽ tái ngộ."
  },
  Event_7478_Name = {Text = "Oxford"},
  Event_7479_ChoiceDesc1 = {Text = "[đi]"},
  Event_7479_Desc = {
    Text = "Bạn khẽ cúi người, cầm chiếc khay trên bàn bên cạnh, hóa thân thành vệ sĩ của công chúa. \nCòn về việc ai trở thành nàng công chúa may mắn ấy — tất nhiên là người đồng đội trung thành nhất của bạn rồi. \n \"Dám đổ trà lên mặt ta, đừng mong có được bài ghi chép trong lớp tháng sau.\"\nĐây là lời cảnh báo của công chúa dành cho bạn."
  },
  Event_7479_Name = {
    Text = "Lừa đảo tinh vi"
  },
  Event_7480_ChoiceDesc1 = {
    Text = "[Nghe im lặng] Nâng cấp ngẫu nhiên chất lượng khắcăng của 1 thẻ bài"
  },
  Event_7480_ChoiceDesc2 = {
    Text = "[Cô ấy chính là] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7480_Desc = {
    Text = "Tiếng gầm gừ của Sara vang vọng trong tâm trí bạn, một giọng nói nhỏ nhẹ quen thuộc nào đó không biết từ đâu, nó thì thầm yếu ớt \"chị Sara thân mến\", \"chị Sara thân mến\". \n \"chị Sara thân mến, chị ở đâu?\""
  },
  Event_7480_Name = {
    Text = "\"chị Sasa\""
  },
  Event_7481_ChoiceDesc1 = {Text = "[đi]"},
  Event_7481_Desc = {
    Text = "\"... Lời bạn nói cũng có chút hợp lý, nhưng khát vọng không thể giúp bạn giải quyết được rỗng rỗng. Thôi thì làm gì đó thực tế đi.\""
  },
  Event_7481_Name = {
    Text = "Luật của Logan"
  },
  Event_7482_ChoiceDesc1 = {
    Text = "[ Nhận được 100 dấu đen ]"
  },
  Event_7482_ChoiceDesc2 = {
    Text = "[2 thẻ lệnh ngẫu nhiên nhận Khắc ấn: \"(EnchantConfig.Arg1)\"]"
  },
  Event_7482_Desc = {
    Text = "Sáng tạo từ sự ngưng đọng của linh tri thức ổn định, biết đâu, chúng có thể mang lại giai điệu hòa hợp."
  },
  Event_7482_Name = {
    Text = "âm không hòa"
  },
  Event_7483_ChoiceDesc1 = {Text = "[đi]"},
  Event_7483_Desc = {
    Text = "\"Đây là Mảnh Vỡ Ký Ức của ai đó đã từng bước vào chiều không gian này,\" Ramona đáp lại, \"Khi di chuyển qua các chiều không gian rất dễ gặp phải tình huống như thế này. Hãy cẩn thận đừng nhầm lẫn với ký ức của chính mình.\""
  },
  Event_7483_Name = {
    Text = "Hồi tưởng phân mảnh · Whisky"
  },
  Event_7484_ChoiceDesc1 = {Text = "[đi]"},
  Event_7484_Desc = {
    Text = "Theo nhịp đập của trái tim, truy tìm ánh sáng. Các bạn sẽ không bao giờ tách rời, cũng như không ai có thể phân biệt chính xác giữa ngày và đêm."
  },
  Event_7484_Name = {
    Text = "Phòng tim trái"
  },
  Event_7485_ChoiceDesc1 = {Text = "[đi]"},
  Event_7485_Desc = {
    Text = "Bạn liên tục vuốt ve những bàn tay bồn chồn, cố gắng làm cho chúng bình tĩnh lại. \n Không lâu sau, thế giới của bạn hoàn toàn yên tĩnh. \n Tình yêu luôn được đền đáp."
  },
  Event_7485_Name = {
    Text = "Đầm lầy Tối"
  },
  Event_7486_ChoiceDesc1 = {
    Text = "[struggle] nhiễm \"(Skill.Arg1)\", nhận bạc sáng tạo \"(RelicConfig.Arg2)\"]"
  },
  Event_7486_ChoiceDesc2 = {
    Text = "[Bỏ qua] nhiễm \"(Skill.Arg1)\", nhận được bạc sáng tạo \"(RelicConfig.Arg2)\""
  },
  Event_7486_ChoiceDesc3 = {
    Text = "[Cảnh báo] nhận được 25 dấu đen"
  },
  Event_7486_Desc = {
    Text = "Trong đầu bạn tràn ngập những thứ vẩn đục, cảm giác dị vật bẩn thỉu ấy vô cùng rõ ràng. \n Chất lỏng đục ngầu, tỏa ra mùi hôi thối, thấm vào và chiếm giữ toàn bộ suy nghĩ của bạn, nỗi đau lan tỏa khắp khuôn mặt bên cạnh tràn đầy sợ hãi, bạn rơi vào vòng lặp ác mộng vô tận, khó có thể thoát ra."
  },
  Event_7486_Name = {
    Text = "Lỗ loét trong sọ"
  },
  Event_7487_ChoiceDesc1 = {
    Text = "[là gương nghi lễ Memphis]"
  },
  Event_7487_ChoiceDesc2 = {
    Text = "[là la bàn định hướng]"
  },
  Event_7487_ChoiceDesc3 = {
    Text = "[Tôi không làm rơi đồ]"
  },
  Event_7487_Desc = {
    Text = "\"Người tiên phong vượt qua các chiều.\"\n\nTiếng nói già nua vang lên bên tai, như đến từ thời cổ đại, như đã đi qua muôn đời.\n\nTrong sự căng thẳng tột độ, bạn nghe thấy tiếng nói ấy hỏi một câu quen thuộc.\n\n \"Cái tròn tròn mà bạn làm rơi, thứ có thể giúp bạn rút bài khi bắt đầu lượt là gì vậy?\""
  },
  Event_7487_Name = {
    Text = "Giọng ngoài thế giới"
  },
  Event_7488_ChoiceDesc1 = {Text = "[đi]"},
  Event_7488_Desc = {
    Text = "\"Tôi đây đâu phải là trạm thu gom phế liệu,\"Đóa lẩm bẩm khi nhận lấy,\"Thôi được, ít nhiều cũng tách ra được chút gì hữu ích.\""
  },
  Event_7488_Name = {
    Text = "Biển tên"
  },
  Event_7489_ChoiceDesc1 = {
    Text = "Khắcăng ngẫu nhiên thường"
  },
  Event_7490_ChoiceDesc1 = {Text = "[đi]"},
  Event_7490_Desc = {
    Text = "Bạn đọc những dòng chữ trên tờ giấy phai mờ và rách nát, \"song sinh\",\"thấm nhuần\",\"hiến tế\",\"vô hiệu\"...\nVẫn là những khái niệm rời rạc và văn bản khó hiểu. Chỉ còn cảm giác đau nhức trong đầu chứng minh rằng bạn từng đọc qua trang giấy này."
  },
  Event_7490_Name = {
    Text = "Lệnh bí mật·dưới"
  },
  Event_7491_ChoiceDesc1 = {
    Text = "[Bạn sẵn sàng trả giá nào?] Tăng ngẫu nhiên phẩm chất khắcăng của 1 thẻ bài"
  },
  Event_7491_ChoiceDesc2 = {
    Text = "[Mời họ một ly Bloody Mary hết hạn] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7491_Desc = {
    Text = "\"Chào mừng quý khách, người khách quý của tôi. Hãy thoải mái lựa chọn, tất cả những thứ lấp lánh này đều đang chờ đợi ngài.\"\n \"Xin lỗi, thưa cô, liệu cô có phải là... chị em song sinh của bà Đào Đen Đá không?\"\n \"Tôi chính là Đào Đen Đá, xin hỏi quý khách hôm nay đến đây có việc gì quan trọng...?\"\n \"Thật xin lỗi, cô trông đẹp hơn trước nhiều, tôi đã không nhận ra. Cô còn nhớ không? Hai mươi năm trước, cô đã giúp tôi đuổi một kẻ dị hợm khỏi quán bar... Hôm qua, cơn ác mộng tái hiện, nó chiếm lấy quán bar, cùng với đồng loại của nó, thành đàn...\""
  },
  Event_7491_Name = {
    Text = "Hồi ức phân mảnh · Mộng cũ tái hiện"
  },
  Event_7492_ChoiceDesc1 = {
    Text = "[Xua đuổi quạ] nhận được 30 dấu đen, bị nhiễm [(Skill.Arg2)], tiếp tục chọn"
  },
  Event_7492_ChoiceDesc2 = {
    Text = "[tiếp tục đuổi theo đứa trẻ] rời đi"
  },
  Event_7492_Desc = {
    Text = "Con quạ thứ hai đã rời đi, lông đuôi của nó trong lúc vỗ cánh lộ ra một vệt trắng, như màu của xương khô."
  },
  Event_7492_Name = {
    Text = "Nhìn chằm chằm của Quạ Đen"
  },
  Event_7493_ChoiceDesc1 = {
    Text = "[Đặt cược] Áp dụng [(Skill.Arg1)], bước vào ván cược"
  },
  Event_7493_ChoiceDesc2 = {
    Text = "[thôi đi] nhận được 25 dấu đen"
  },
  Event_7493_Desc = {
    Text = "\"Hãy đánh cược đi? Đoán xem điểm số của chúng tôi! Chỉ cần một chút giá!\"\nNhững con xúc xắc bị vứt bỏ phát ra tiếng ong ong ồn ào, như thể đang nói chuyện với bạn. \n \"Chọn tôi! Chọn tôi!\"\n \"Duy nhất một lần! Lần cuối cùng!\"\nĐược rồi, chỉ một lần —— \nBạn nhặt lên một cái chip. Bạn quyết định ——"
  },
  Event_7493_Name = {
    Text = "Cuộc cờ bạc vô tận"
  },
  Event_7494_ChoiceDesc1 = {
    Text = "[Kháng cự tà niệm] nhận được bạc tạo vật \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7494_ChoiceDesc2 = {
    Text = "[ôm lấy niệm ác] nhận được sáng tạo bạc \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7494_ChoiceDesc3 = {
    Text = "[Rời đi tỉnh táo] nhận được 25 dấu đen"
  },
  Event_7494_Desc = {
    Text = "Ác niệm trở thành lưỡi dao sắc, lại như những chiếc răng nhọn. \n Chúng cắn xé lý trí đang dần yếu đi trong thâm cảnh, tiêu thụ ý chí còn sót lại, giống như những hành vi ác độc mà thực tại đã áp đặt lên bạn vậy…"
  },
  Event_7494_Name = {
    Text = "Niệm Vô Vọng"
  },
  Event_7495_ChoiceDesc1 = {
    Text = "[toàn lực giãy dụa] xóa 1 thẻ lệnh, nhận Arg1 dấu đen"
  },
  Event_7495_ChoiceDesc2 = {
    Text = "[đốt lưới nhện] sao chép 1 thẻ lệnh, lây nhiễm [(Skill.Arg1)]"
  },
  Event_7495_ChoiceDesc3 = {
    Text = "[Chờ đợi yên lặng] Chọn 1 thẻ lệnh từ 3 thẻ lệnh để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_7495_Desc = {
    Text = "Những sợi chỉ mảnh như mạng nhện quấn chặt lấy bạn, và ngay lúc này, bạn chợt trở thành con mồi của thâm cảnh."
  },
  Event_7495_Name = {Text = "Sâu lún"},
  Event_7496_ChoiceDesc1 = {
    Text = "[Người nhận: ∞]Nhiễm「(Skill.Arg1)」"
  },
  Event_7496_ChoiceDesc2 = {
    Text = "[Người nhận: Bản thân]Xóa 1 thẻ"
  },
  Event_7496_ChoiceDesc3 = {
    Text = "[Người nhận: Giáo viên]Nhận 25 Ấn ký đen"
  },
  Event_7496_Desc = {
    Text = "Ngài đã cho người hành giả thâm cảnh một cơ hội: một cơ hội kết nối với điều không biết. \nVài tờ giấy rách nát, một chiếc máy đánh chữ đang tỏa ra mùi mực, và một người nhận không biết, một chiều. \nÝ chí có thể quyết định thông điệp của bạn sẽ được truyền đi đâu…"
  },
  Event_7496_Name = {
    Text = "Lời tâm sự một chiều"
  },
  Event_7497_ChoiceDesc1 = {
    Text = "[Vui vẻ đồng ý]"
  },
  Event_7497_ChoiceDesc2 = {
    Text = "[Từ chối quyết đoán]"
  },
  Event_7497_Desc = {
    Text = "Không gian trống trải vang vọng những lời thì thầm. \n \"Ồ, chính là thằng ngốc đó, tay cờ bạc nổi tiếng luôn lẩm bẩm về việc phải chết hoặc phải thắng, một kẻ chẳng ra gì, cậu nên tránh xa hắn ra.\"\n Hình bóng tiều tụy và gầy guộc ném cho bạn vài đồng xu, âm thanh kim loại va chạm giòn tan rơi vào lòng bàn tay bạn. \n \"Chơi một ván đi.\""
  },
  Event_7497_Name = {
    Text = "Người chơi bạc nổi tiếng"
  },
  Event_7498_ChoiceDesc1 = {
    Text = "[Chúng tôi đều bình an] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7498_ChoiceDesc2 = {
    Text = "[Bạn là ai?] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7498_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_7498_Desc = {
    Text = "Máy đánh chữ đột ngột phun ra mực, dấu chấm than trên đó nhiều đến mức chói mắt. \n「Đóa, cô còn ổn không??? Người giữ bí mật đã biến mất, và cô cũng vậy! Xin vui lòng báo tin nếu cô vẫn an toàn! Nếu tiếp tục đợi, chắc chắn tóc của William sẽ rụng sạch"
  },
  Event_7498_Name = {
    Text = "Giao tiếp khẩn cấp"
  },
  Event_7499_ChoiceDesc1 = {Text = "[đi]"},
  Event_7499_Desc = {
    Text = "Bạn đặt miếng thạch cao cuối cùng lên, cô ấy bùng phát một tràng cười sắc nhọn, một luồng khí đen quấn quanh, hình bóng lơ lửng của cô ấy tan biến trong tầm nhìn của bạn."
  },
  Event_7499_Name = {
    Text = "Hoàn thiện xác tàn"
  },
  Event_7500_ChoiceDesc1 = {Text = "[đi]"},
  Event_7500_Desc = {
    Text = "Bạn lấy ra chìa khóa bạc, nắm nó trong lòng bàn tay một cách thành kính và đượm buồn, ánh sáng mỏng như sương mù bao phủ bạn. \nTrong sự yên lặng, chỉ còn lại tiếng thở dài."
  },
  Event_7500_Name = {
    Text = "Mắt ngắm nhìn"
  },
  Event_7501_ChoiceDesc1 = {Text = "[đi]"},
  Event_7501_Desc = {
    Text = "Ánh mắt còn lại vẫn dõi theo bạn, các tế bào dưới da điên cuồng gào thét và thoát ra, mạch máu bò như sâu. \nBạn cảm nhận luồng sức mạnh chảy qua, bùng nổ qua những biến đổi quái dị trên cơ thể."
  },
  Event_7501_Name = {
    Text = "Mắt ngắm nhìn"
  },
  Event_7502_ChoiceDesc1 = {
    Text = "[tránh ánh mắt] ngẫu nhiên thức tỉnh 1 thân thể được đánh thức"
  },
  Event_7502_ChoiceDesc2 = {
    Text = "[Trực diện ánh mắt] Chọn 1 thân thể được đánh thức và giảm 2 điểm tiêu thụ sức tính toán của thẻ thức tỉnh. Nhiễm [(Skill.Arg1)]"
  },
  Event_7502_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 50 dấu đen"
  },
  Event_7502_Desc = {
    Text = "Đường hầm chiều liên kết hàng nghìn vũ trụ, trên đường dẫn tối cao, vô số đôi mắt đang nhìn chằm chằm vào các bạn di chuyển một cách thận trọng."
  },
  Event_7502_Name = {
    Text = "Ánh nhìn của Người"
  },
  Event_7503_ChoiceDesc1 = {Text = "[đi]"},
  Event_7503_Desc = {
    Text = "Quá hỗn loạn, quá hỗn loạn. \nTất cả suy nghĩ bị dòng chảy tư duy cuốn đi trong nháy mắt, bị dòng lũ cuốn trôi về xa. \nTrong vùng trũng của não bộ, đầy những bối rối và nỗi đau, tất cả chìm dần."
  },
  Event_7503_Name = {
    Text = "Bùng nổ cảm hứng"
  },
  Event_7504_ChoiceDesc1 = {
    Text = "[thu vào túi]"
  },
  Event_7504_Desc = {
    Text = "Trong dung dịch ăn mòn bão hòa rỗng rỗng dường như chứa một số chất… Dùng chìa khóa bạc quan sát, rồi chuyển hóa nó thành lực lượng của bạn."
  },
  Event_7504_Name = {
    Text = "Điểm tách ra"
  },
  Event_7505_ChoiceDesc1 = {
    Text = "[Xua đuổi quạ] nhận được 35 dấu đen, nhiễm [(Skill.Arg2)], tiếp tục chọn"
  },
  Event_7505_ChoiceDesc2 = {
    Text = "[tiếp tục đuổi theo đứa trẻ] rời đi"
  },
  Event_7505_Desc = {
    Text = "Một con quạ đã rời đi, một chiếc lông vũ đen tuyền từ từ rơi xuống."
  },
  Event_7505_Name = {
    Text = "Nhìn chằm chằm của Quạ Đen"
  },
  Event_7506_ChoiceDesc1 = {
    Text = "[Xác nhận]"
  },
  Event_7506_Desc = {
    Text = "Đây là nơi chiến đấu máu me của hố sâu, chiến đấu không chỉ cần sự dũng cảm mà còn cần trí tuệ. \n\nHãy quan sát kỹ lưỡng, bạn không cần đánh bại tất cả họ, bạn chỉ cần đánh bại thủ lĩnh của họ!"
  },
  Event_7506_Name = {
    Text = "Thử thách Asura"
  },
  Event_7507_ChoiceDesc1 = {
    Text = "[Kết nối] phục hồi Arg2 điểm sức sống."
  },
  Event_7507_Desc = {
    Text = "Bạn đang khám phá trong sương mù, đột nhiên, huy hiệu trường trên ngực bạn phát ra ánh sáng bạc yếu ớt. Ai đang gọi bạn từ bên kia thiết bị liên lạc?"
  },
  Event_7507_Name = {
    Text = "điểm liên lạc"
  },
  Event_7508_ChoiceDesc1 = {
    Text = "[theo dõi anh ta]"
  },
  Event_7508_ChoiceDesc2 = {
    Text = "[chào hỏi]"
  },
  Event_7508_Desc = {
    Text = "Đạp. Đạp. Đạp. \n Hình dáng màu trắng từ từ tiến bước trong sương mù, như chiếc thuyền buồm hướng về đêm tĩnh lặng. \n Từ phía sau nhìn lại, có vẻ như là một cậu bé. \n Bạn lắng nghe tiếng bước chân mệt mỏi của cậu ta, trong lòng đưa ra một quyết định."
  },
  Event_7508_Name = {
    Text = "Lễ Kết Thúc Ⅰ"
  },
  Event_7509_ChoiceDesc1 = {
    Text = "[vui vẻ đồng ý]"
  },
  Event_7509_ChoiceDesc2 = {
    Text = "[thận trọng]"
  },
  Event_7509_Desc = {
    Text = "Thân thể bị rỗng rỗng gào thét ngã xuống, bạn ngạc nhiên phát hiện Clementine đứng phía sau. \n \"Tôi đến để từ biệt,\" trước sự chất vấn của bạn, cô ấy không trả lời, \"Để bày tỏ lòng cảm ơn với bạn, tôi có thể cho bạn biết một số manh mối. Tuy nhiên... điều đó sẽ cần sự tin tưởng từ bạn. \n Hãy để tôi thôi miên bạn, bạn sẽ biết tất cả những gì tôi biết.\"\n Bạn có thể tin cô ấy không? \n \"Cẩn thận,\" Ramona cảnh báo, \"Cô ấy không thể không có toan tính khác.\""
  },
  Event_7509_Name = {
    Text = "Therapy thôi miên"
  },
  Event_7510_ChoiceDesc1 = {
    Text = "[Xác nhận]"
  },
  Event_7510_Desc = {
    Text = "Bạn tập trung tinh thần, ảo ảnh tan đi như bức tranh thủy mặc. Bạn tiếp tục tiến lên, nhưng không thể hoàn toàn xóa bỏ bóng tối trong lòng."
  },
  Event_7510_Name = {Text = "ảo ảnh"},
  Event_7511_ChoiceDesc1 = {
    Text = "[Sinh vật đáng thương?]"
  },
  Event_7511_ChoiceDesc2 = {
    Text = "[loài người tiến hóa?]"
  },
  Event_7511_ChoiceDesc3 = {
    Text = "[Bạn rốt cuộc là ai?]"
  },
  Event_7511_Desc = {
    Text = "Người đàn ông mà các ngươi gặp lần thứ sáu, đứng trên cao của khung thép, nhìn xuống mặt đất. Gió thổi tung mái tóc dài của anh ta, lộ ra bộ mặt thật của con rắn. \nÁnh mắt của anh ta tập trung vào các ngươi, sau một lúc lại hướng về bóng tối xa xôi. \n \"À, đây là sinh vật đáng thương làm sao. \nCảm giác bị bội phản, chắc chắn đắng ngọt như con người <Bold:tiến hóa> vậy.\""
  },
  Event_7511_Name = {
    Text = "Người bạn đồng hành kỳ lạ Ⅵ"
  },
  Event_7512_ChoiceDesc1 = {Text = "[đi]"},
  Event_7512_Desc = {
    Text = "Ai sẽ quan tâm đến một cuộn phim dưới cái nhìn của chó địa ngục?"
  },
  Event_7512_Name = {
    Text = "Ký ức ánh sáng và bóng tối"
  },
  Event_7513_ChoiceDesc1 = {Text = "[đi]"},
  Event_7513_Desc = {
    Text = "Không xem, không thảo luận, không nghe, thậm chí đừng nghĩ đến —— lựa chọn của người thông minh."
  },
  Event_7513_Name = {
    Text = "Rune Madness"
  },
  Event_7514_ChoiceDesc1 = {
    Text = "[Rời đi] xóa 2 thẻ bài"
  },
  Event_7514_Desc = {
    Text = "Trong tiếng ồn ào xung quanh, bạn mơ hồ nghe thấy tiếng vỗ cánh kỳ lạ. Chìa khóa bạc trên ngực bạn đột nhiên rung mạnh, bạn bị một lực lượng nào đó thúc giục ngẩng đầu lên và nhìn thấy một hố đen khổng lồ xuất hiện trên bầu trời. \n \"Thật đáng tiếc, thật đáng tiếc, nhưng không sao. Chúng ta sẽ còn gặp lại nhau, con mắt không hình hài kính trọng của tôi.\""
  },
  Event_7514_Name = {
    Text = "Therapy thôi miên"
  },
  Event_7515_ChoiceDesc1 = {Text = "[đi]"},
  Event_7515_Desc = {
    Text = "Bạn có thể bỏ qua mọi thứ xung quanh, nhưng không thể bỏ qua nhịp đập của trái tim. Nó tăng tốc, thúc giục bạn, cũng như trách móc bạn."
  },
  Event_7515_Name = {
    Text = "Phòng tim trái"
  },
  Event_7516_ChoiceDesc1 = {Text = "[đi]"},
  Event_7516_Desc = {
    Text = "\"Thế là tốt!!! Tóc của tiền bối William được giữ an toàn!!!\"\nDù chỉ là thông tin bằng văn bản, nội dung điện báo đã khiến bạn tưởng tượng ra tiếng gào thét đến khản cổ đó."
  },
  Event_7516_Name = {
    Text = "Giao tiếp khẩn cấp"
  },
  Event_7517_ChoiceDesc1 = {
    Text = "[Hãy nói sự thật] Gây thức tỉnh ngẫu nhiên một thân thể được đánh thức, lây nhiễm [(Skill.Arg1)]"
  },
  Event_7517_ChoiceDesc2 = {
    Text = "[ giấu sự thật ] Bạn nhận được quyền chọn 1 trong 3 khắcăng đặc biệt"
  },
  Event_7517_Desc = {
    Text = "\"Xin hãy cứu tôi.\"\nNgười lữ hành u sầu nắm lấy tay bạn. Anh ta đã lang thang ở đây hàng trăm năm. \n \"Tôi là một người lính, được lệnh tiến về phương Đông xa xôi để chinh phạt những kẻ ngoại đạo. \nTôi vượt qua rừng rậm, băng qua sông ngòi, nhưng lại lạc đường, lần lượt quay về cùng một nơi. \nCó thứ gì đó trong bóng tối đang quan sát tôi. Tôi không nhìn thấy nó, nhưng tôi biết. Nó luôn dõi theo tôi. \nGiờ đây, tôi chỉ muốn trở về nhà...\"\nBạn nhìn vào bóng dáng mờ ảo phía sau anh ta. Ban đầu chúng mờ nhạt, rồi dần dần rõ ràng —— đó là một cái miệng rộng đang há to, sẵn sàng thưởng thức linh hồn lạc lối đã bị bảo quản suốt trăm năm."
  },
  Event_7517_Name = {
    Text = "Tiêu Thụ Giả"
  },
  Event_7518_ChoiceDesc1 = {
    Text = "[Thâm nhập bóng tối]"
  },
  Event_7518_ChoiceDesc2 = {
    Text = "[Lời từ biệt]"
  },
  Event_7518_Desc = {
    Text = "\"Hilaster, bạn sẽ giúp tôi lần này chứ.\"\nCô gái do dự và lo lắng bước đi tại chỗ, thỉnh thoảng quay đầu nhìn về phía thân thể được đánh thức đang yên lặng. \nNàng không đáp lại cô gái, khi vẻ mặt cô càng trở nên lo âu, làn gió nhẹ cuốn tấm voan trắng, nhẹ nhàng đẩy cô gái về một hướng nhất định. \n \"Tôi sẽ bảo hộ bạn.\"\nTôi sẽ bảo hộ bạn, mặc dù trong việc \"bảo hộ\" này, tôi từng thất bại một lần. \nNhưng lần này, tôi sẽ không để bạn một mình lạc lối trong bóng tối."
  },
  Event_7518_Name = {
    Text = "Bảo hộ của Thánh Nữ Hàng Hải"
  },
  Event_7519_ChoiceDesc1 = {
    Text = "[rời đi] chọn 1 thẻ lệnh từ 3 thẻ lệnh để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_7519_Desc = {
    Text = "Những bài hát đó có cái thì cổ xưa, cổ xưa đến mức đã thất truyền trước khi lũ lụt lây lan; cũng có cái rất mới, hát về năm mới vừa qua, đôi găng tay mới mà vợ bạn mua ở tiệm Lentiennam… Sau sự hỗn loạn của những cảm xúc chồng chéo, chỉ còn lại một khoảng trống trong lòng."
  },
  Event_7519_Name = {
    Text = "Bài hát thuyền"
  },
  Event_7520_ChoiceDesc1 = {
    Text = "[trục xuất màu sắc] nhận được vật tạo vàng \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7520_ChoiceDesc2 = {
    Text = "[ôm lấy màu sắc] nhận được một lựa chọn từ 3 vật tạo vàng, [(Skill.Arg1)]"
  },
  Event_7520_ChoiceDesc3 = {
    Text = "[quay lưng rời đi] nhận được tạo vật bạc [(RelicConfig.Arg1)]"
  },
  Event_7520_Desc = {
    Text = "Muphí bám theo sau không rời nửa bước, nhưng khi đi qua một góc rẽ nào đó, anh ta bất động tại chỗ. \n Ánh sáng lấp lánh chảy tràn trước mắt, cuốn theo tiếng thở dài của không khí. \n \"Muphí...\"\n Là linh hồn người chết chìm bị giam cầm trên tàu Sonanil? Hay là người thân đã khuất tìm đến người sống?"
  },
  Event_7520_Name = {
    Text = "Màu sắc hoài niệm"
  },
  Event_7521_ChoiceDesc1 = {
    Text = "[tiếp tục tìm kiếm] tăng Arg1 điểm sức sống, bị nhiễm [(Skill.Arg2)]"
  },
  Event_7521_ChoiceDesc2 = {Text = "[đi]"},
  Event_7521_Desc = {
    Text = "Câu nói quen thuộc vang lên bên tai, thân thiết và an ủi, khi muốn tìm theo tiếng nói, nó lại đột ngột im bặt."
  },
  Event_7521_Name = {
    Text = "Liên lạc bất thường"
  },
  Event_7522_ChoiceDesc1 = {Text = "[đi]"},
  Event_7522_Desc = {
    Text = "\"Đó là một đoạn âm thanh phạm thượng.\"\n Bạn bịt chặt tai, nơi máu đang chảy ra, với sự chắc chắn tuyệt đối."
  },
  Event_7522_Name = {
    Text = "Âm sắc cấm kỵ"
  },
  Event_7523_ChoiceDesc1 = {Text = "[đi]"},
  Event_7523_Desc = {
    Text = "Đó là những hình dạng mờ ảo của hai con người, nhưng các Ngài chỉ đứng yên ở góc đó, dùng ánh mắt để gửi đến mọi người lời chúc phúc cuối cùng."
  },
  Event_7523_Name = {
    Text = "Màu sắc hoài niệm"
  },
  Event_7524_ChoiceDesc1 = {
    Text = "[Lắng nghe] nhận được chọn 1 trong 3 vật tạo vàng"
  },
  Event_7524_Desc = {
    Text = "Giọng của Đào Đen Đá tạm dừng một chút. \n \"Ồ, bạn đã chọn cái này sao? Lựa chọn không tệ. Để thưởng, tôi sẽ tặng bạn một món quà đặc biệt.\""
  },
  Event_7524_Name = {
    Text = "Thời gian gợi ý"
  },
  Event_7525_ChoiceDesc1 = {
    Text = "[vẫn tiếp tục hỏi] nhiễm [(Skill.Arg1)]"
  },
  Event_7525_ChoiceDesc2 = {
    Text = "[bỏ qua phần hỏi] chọn 1 thẻ bài để xóa"
  },
  Event_7525_Desc = {
    Text = "\"Ừ, lựa chọn thông minh. Đại địch trước mắt, chắc chắn sẽ muốn hiểu rõ đối phương và bản thân? Tuy nhiên, biết quá nhiều về bí mật của các chiều không gian có thể gây rối loạn tinh thần.\""
  },
  Event_7525_Name = {
    Text = "Thời gian gợi ý"
  },
  Event_7526_ChoiceDesc1 = {
    Text = "[Kiên trì hỏi] Khiến Đào Đen Đá tức giận, nhập vào chiến đấu"
  },
  Event_7526_ChoiceDesc2 = {
    Text = "[bỏ qua câu hỏi] chịu một chút trừng phạt nhẹ"
  },
  Event_7526_Desc = {
    Text = "\"Oh? Lúc này mà cậu vẫn còn nghĩ đến việc theo dõi tôi sao? Cậu nhóc, tham lam quá không tốt đâu đấy.\""
  },
  Event_7526_Name = {
    Text = "Thời gian gợi ý"
  },
  Event_7527_ChoiceDesc1 = {
    Text = "[nhìn kỹ] nâng cao Arg1 điểm máu tối đa"
  },
  Event_7527_ChoiceDesc2 = {
    Text = "[Phớt lờ] 2 thẻ lệnh ngẫu nhiên nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm 2 thẻ \"(Skill.Arg2)\""
  },
  Event_7527_Desc = {
    Text = "Các người đuổi theo bóng dáng của chó địa ngục, chạy trên con đường của thị trấn. \nTrời bắt đầu rơi những bông tuyết lạnh giá, nhẹ nhàng đậu trên má, trên ngực, xoa dịu tâm hồn bất an của bạn."
  },
  Event_7527_Name = {Text = "Tuyết"},
  Event_7528_ChoiceDesc1 = {Text = "[đi]"},
  Event_7528_Desc = {
    Text = "Bạn vung tay, cố gắng xua đuổi những con quạ phiền phức này. \n Chúng phát ra tiếng cười khanh khách, như thể đang chế nhạo sự ngu ngốc và yếu đuối của bạn. \n Dù sao đi nữa, lòng dũng cảm của bạn vẫn chạm đến chúng, bạn nhận được phần thưởng xứng đáng."
  },
  Event_7528_Name = {
    Text = "Bài hát của đàn quạ"
  },
  Event_7529_ChoiceDesc1 = {
    Text = "[Về Lily] Nhận được bạc sáng tạo [(RelicConfig.Arg1)]"
  },
  Event_7529_ChoiceDesc2 = {
    Text = "[Về chó địa ngục] Nhận sáng tạo vàng \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7529_Desc = {
    Text = "Đi qua cánh cửa vô tận, từ một nơi xa xôi không thể với tới, giọng nói của Đào Đen Đá vang lên. \n \"Đây là thời gian gợi ý của Đào Đen Đá.\""
  },
  Event_7529_Name = {
    Text = "Thời gian gợi ý"
  },
  Event_7530_ChoiceDesc1 = {Text = "[đi]"},
  Event_7530_Desc = {
    Text = "Bạn vẫn tỏ ra kiên cường, trong tiếng hát vẫn có thể theo đuổi bản thân. \n Bạn không tin vào những âm thanh mê sảng bên tai, vật mà bạn dựa vào chỉ có lý trí của con người. \n Nhưng... vào ngày mà mặt đất vững chắc để sinh tồn bị bao phủ bởi chất lỏng đen đặc, việc đào mắt ra để làm vật quan sát sẽ là lựa chọn duy nhất của bạn trong những giây phút hấp hối."
  },
  Event_7530_Name = {
    Text = "Bài hát của đàn quạ"
  },
  Event_7531_ChoiceDesc1 = {
    Text = "[Trực diện nguồn gốc chó địa ngục] nhận được vật tạo vàng \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7531_ChoiceDesc2 = {
    Text = "[Chú tâm chiến đấu] Từ 3 thẻ lệnh, chọn 1 để nhận khắc ấn: [(EnchantConfig.Arg1)]"
  },
  Event_7531_Desc = {
    Text = "Dáng vẻ của chó địa ngục thay đổi. \n Thân thể của hắn kết nối với khe hở trên tường, tỏa ra ảo ảnh quái lạ."
  },
  Event_7531_Name = {Text = "từ góc"},
  Event_7532_ChoiceDesc1 = {Text = "[đi]"},
  Event_7532_Desc = {
    Text = "\"Meo, meo meo, meo meo meo...\"\nBạn nhón giọng, cố gắng tỏ ra yếu ớt và vô hại.\n \"Meo! Meo meo! Meo meo meo!\"\nĐàn mèo dường như đã chấp nhận thiện ý của bạn, đáp lại bằng những tiếng kêu vang dội. Những tiếng kêu của các bạn vang lên xen kẽ, ngày đêm không ngừng, ngay cả mặt trăng cũng phải trốn vào giữa mây."
  },
  Event_7532_Name = {
    Text = "Thành phố mèo"
  },
  Event_7533_ChoiceDesc1 = {Text = "[đi]"},
  Event_7533_Desc = {
    Text = "Chỉ là sinh linh đang đấu tranh để sống sót, tìm kiếm một mảnh gỗ để nghỉ ngơi mà thôi……\nBạn thở dài, để cho dung dịch đen từ đuôi con bướm chảy xuống má."
  },
  Event_7533_Name = {
    Text = "Bướm Dung Dịch Đen"
  },
  Event_7534_ChoiceDesc1 = {Text = "[đi]"},
  Event_7534_Desc = {
    Text = "Bạn đã dùng hết sức lực của mình để rời xa bầy mèo. \n Khi quay lại nhìn, những chú mèo đã sớm trở lại vị trí của chúng. Một số đang chải lông, một số thì ngủ gật, còn có những con đang đánh nhau… \n Nói thật, chúng không quan tâm đến con người."
  },
  Event_7534_Name = {
    Text = "Thành phố mèo"
  },
  Event_7535_ChoiceDesc1 = {Text = "[đi]"},
  Event_7535_Desc = {
    Text = "Bạn ném miếng thịt còn lại trong tay vào bầy mèo. \n Bầy mèo như một đợt sóng đen ập tới. Chúng điên cuồng cắn xé miếng thịt, rồi nhanh chóng tản ra. \n Thật không may, đây là một miếng thịt đã hết hạn. Có thể làm đầy bụng đói, nhưng không mang lại cảm giác thoải mái."
  },
  Event_7535_Name = {
    Text = "Thành phố mèo"
  },
  Event_7536_ChoiceDesc1 = {
    Text = "[Trực tiếp nhìn vào mắt] nhận được vật tạo vàng \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7536_ChoiceDesc2 = {
    Text = "[Bỏ qua kháng cự] Ngẫu nhiên đánh thức 2 thân thể, bị nhiễm hai lần [(Skill.Arg1)]"
  },
  Event_7536_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 50 dấu đen"
  },
  Event_7536_Desc = {
    Text = "Vô số con mắt bao quanh tai bạn thì thầm. \n \"Chúng tôi du lịch, chúng tôi dừng lại, chúng tôi đã bước đi qua hàng vạn năm thậm chí lâu hơn. \nKhi mặt trời dần tắt trong ánh nhìn, khi sức sống của Trái Đất cũ bị lũ lụt nhấn chìm. \nChúng tôi đã sớm bị bí ẩn của vũ trụ thu hút sâu sắc.\""
  },
  Event_7536_Name = {Text = "mắt"},
  Event_7537_ChoiceDesc1 = {
    Text = "[cảm thấy lo lắng tột độ] ngẫu nhiên khởi phát 1 thân thể được đánh thức"
  },
  Event_7537_ChoiceDesc2 = {
    Text = "[cảm thấy thỏa mãn] Chọn 1 thân thể được đánh thức và giảm 2 điểm tiêu thụ sức tính toán của thẻ thức tỉnh. Nhiễm [(Skill.Arg1)]"
  },
  Event_7537_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 50 dấu đen"
  },
  Event_7537_Desc = {
    Text = "Bạn đã thấy một bầu trời không có mặt trăng và các vì sao, trên cao treo lơ lửng là vô số con ngươi phóng đại. \n Như thể chỉ cần bạn giơ tay ra, có thể xoay chúng xuống, làm máu thịt văng tung tóe. \n Nhưng khi bạn mở năm ngón tay, nơi bạn chạm vào lại trống rỗng. \n Đôi mắt của số phận không chớp mắt nhìn bạn, chúng đã nhặt được một hạt cát trong suốt từ vũ trụ hỗn mang."
  },
  Event_7537_Name = {Text = "Mắt vòm"},
  Event_7538_ChoiceDesc1 = {
    Text = "[thả tay đang bịt tai] nhận được một tạo vật bằng bạc [(RelicConfig.Arg1)]"
  },
  Event_7538_ChoiceDesc2 = {
    Text = "[tiếp tục bịt tai] nhận được 75 dấu đen, bị lây nhiễm[(Skill.Arg2)]"
  },
  Event_7538_Desc = {
    Text = "Tiếng hét chói tai, tiếng hét chói tai không có điểm dừng——\nCa sĩ quạ khoác lên mình bộ lông đen bóng, mỏ nhọn phát ra ánh sáng lạnh lẽo, tiếng kêu thê thảm vang lên một lần nữa xé toạc màng nhĩ của bạn. \nHãy bỏ tay bạn ra khỏi tai đi! \nBầy quạ đang hát hò trong đêm, muốn tận hưởng sự run rẩy chưa được tôi luyện trong cơ thể co ro của bạn."
  },
  Event_7538_Name = {
    Text = "Bài hát của đàn quạ"
  },
  Event_7539_ChoiceDesc1 = {
    Text = "[học mèo kêu] nhận được 50 dấu đen"
  },
  Event_7539_ChoiceDesc2 = {
    Text = "[cung cấp thức ăn] nhận được 75 dấu đen, nhiễm phải [(Skill.Arg2)]"
  },
  Event_7539_Desc = {
    Text = "Bạn lạc vào lãnh thổ của mèo đen. \n Vô số đôi mắt đột ngột mở ra trong bóng tối, mang theo sự khám phá, xem xét, báo động... chỉ có điều không có thiện ý. \n Ngọc lục bảo, vàng hổ phách, xanh công công... \n Bạn như đang đứng giữa một đại dương đá quý lấp lánh. \n Để thoát thân, bạn——"
  },
  Event_7539_Name = {
    Text = "Thành phố mèo"
  },
  Event_7540_ChoiceDesc1 = {Text = "[đi]"},
  Event_7540_Desc = {
    Text = "Bạn chú ý đến một bàn tay khác biệt. Nó mịn màng, trắng trẻo, từ đầu đến cuối đều thể hiện sự bình tĩnh. \n Quan trọng hơn là — bạn nhận ra, đó chính là bàn tay của bạn. \n Bạn quyết định ngay lập tức, mạnh mẽ bẻ gãy nó. \n Tiếng thét chói tai vang lên bên tai, và đầm lầy cuối cùng cũng biến mất."
  },
  Event_7540_Name = {
    Text = "Đầm lầy Tối"
  },
  Event_7541_ChoiceDesc1 = {Text = "[đi]"},
  Event_7541_Desc = {
    Text = "\"Quyết định sáng suốt.\" Hình bóng hai tay trống không nói,\"Lựa chọn đã được kiểm chứng có kết cục đã định, hành vi chưa biết sẽ dẫn đến tương lai mới.\"\nHy vọng nhỏ nhoi nhẹ nhàng ôm lấy bạn. Hình bóng tan biến, bạn đặt tay lên ngực, không rõ vừa rồi là hình chiếu hay chỉ là ảo giác do tinh thần chịu áp lực quá lớn mà sinh ra."
  },
  Event_7541_Name = {
    Text = "Đường phân nhánh"
  },
  Event_7542_ChoiceDesc1 = {
    Text = "[khen ngợi nó] chọn 1 thẻ lệnh từ 3 thẻ để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_7542_ChoiceDesc2 = {
    Text = "[châm biếm nó] nhiễm [(Skill.Arg1)], khắcăng lại, tối đa 2 lần"
  },
  Event_7542_Desc = {
    Text = "Não nói: Chuỗi xích đã giam cầm tiền não của tôi, thân não, vỏ não đại, nhưng không thể ràng buộc hơn 10 tỷ tế bào nhỏ bé theo đuổi sự thật.\nBạn nói: Ai đã giam cầm bạn ở đây? Thân thể của bạn đâu?\nNão nói: Thân thể? Đừng buồn cười nữa. Trước kia họ thường gọi tôi là \"Johnny bán thịt heo\".\nKhi có thân thể, tôi thậm chí không thể hiểu phép cộng trừ trong phạm vi mười.\nNhưng khi giám đốc loại bỏ phần thịt thừa của tôi, hãy nhìn xem tôi đã trở thành thế nào! Một nhà vật lý học, nhà triết học, và nhà thơ nghiệp dư."
  },
  Event_7542_Name = {
    Text = "Não triết học"
  },
  Event_7543_ChoiceDesc1 = {
    Text = "[Chứng minh giả thuyết Goldbach] nhận được bạc sáng tạo[(RelicConfig.Arg1)]"
  },
  Event_7543_ChoiceDesc2 = {
    Text = "[Hành trình kết thúc] 1 thẻ bài ngẫu nhiên nhận được khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_7543_ChoiceDesc3 = {
    Text = "[Từ chối hỏi] Nhận được 50 dấu đen"
  },
  Event_7543_Desc = {
    Text = "Lấy lên tấm bùa thông linh, giọng của một người phụ nữ trẻ tuổi xông vào đầu bạn. \n \"Hãy đặt câu hỏi cho tôi, tôi có thể trả lời mọi câu hỏi.\"\n \"Từ câu trả lời của tôi, bạn sẽ nhận được món quà của số phận.\""
  },
  Event_7543_Name = {
    Text = "Bảng thông linh"
  },
  Event_7544_ChoiceDesc1 = {Text = "[đi]"},
  Event_7544_Desc = {
    Text = "Bạn đọc những trang giấy loang lổ và rách nát, những câu từ đứt đoạn tuôn ra từ miệng bạn, \"Tiên tổ\", \"Thánh tử\", \"Cái chết vĩnh cửu\", \"Ký ức dài lâu\", các danh từ này ào ạt xâm chiếm tâm trí, kích thích những dây thần kinh đã trở nên nhạy cảm và yếu đuối vì ác mộng."
  },
  Event_7544_Name = {
    Text = "Mật lệnh·Thượng"
  },
  Event_7545_ChoiceDesc1 = {Text = "[đi]"},
  Event_7545_Desc = {
    Text = "Dịch đen rơi trên mặt bạn, gây cảm giác ngứa ngáy. \nBạn không thể chịu đựng được, vung tay đập con bướm. \nCon bướm tránh khỏi hành động không thiện chí của bạn và biến mất ở cuối đường."
  },
  Event_7545_Name = {
    Text = "Bướm Dung Dịch Đen"
  },
  Event_7546_ChoiceDesc1 = {
    Text = "[Rời đi] tìm đèn pha"
  },
  Event_7546_ChoiceDesc2 = {
    Text = "[xâm nhập vào sương mù] mất Arg2 điểm sức sống"
  },
  Event_7546_ChoiceDesc3 = {
    Text = "[đi thẳng vào]"
  },
  Event_7546_Desc = {
    Text = "Phía trước là một vùng sương đen dày đặc, khinh suất tiến vào sẽ mang lại thảm họa. \nCó lẽ bạn nên tìm \"đèn pha\"để xua tan sương mù."
  },
  Event_7546_Name = {
    Text = "không biết"
  },
  Event_7547_ChoiceDesc1 = {
    Text = "[Chấp nhận ảo giác] Chọn 1 trong 3 thẻ lệnh nhận được Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7547_ChoiceDesc2 = {
    Text = "[Phủ nhận ảo giác] nhận được bạc tạo vật \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7547_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_7547_Desc = {
    Text = "Dưới cây cầu sắt nặng nề trong bóng tối, trên bãi sông tĩnh lặng đầy lau sậy, bỗng nhiên một con bướm phát sáng bay ra. \n Con bướm nhẹ nhàng đậu trên lòng bàn tay bạn, những tiếng hét tồi tệ đã ngừng lại, thay vào đó là âm thanh đều đặn của những công nhân vận chuyển thép, tiếng búa đóng đinh, tiếng kim loại va chạm của đinh tán..."
  },
  Event_7547_Name = {
    Text = "ảo giác của cây cầu thép"
  },
  Event_7548_ChoiceDesc1 = {
    Text = "[Xua đuổi quạ] nhận được 40 dấu đen, bị ảnh hưởng bởi [(Skill.Arg2)], tiếp tục chọn"
  },
  Event_7548_ChoiceDesc2 = {
    Text = "[tiếp tục đuổi theo đứa trẻ] nhận được 25 dấu đen, rời đi"
  },
  Event_7548_Desc = {
    Text = "Một con quạ đứng trên đèn chùm. \n Hai con quạ đứng trên đèn chùm. \n Ba con quạ đứng trên đèn chùm. \n …… \n Những sinh vật đen tối đó uốn cong cổ, đứng trên đèn chùm ở đầu ngõ, nhìn xuống bạn bằng ánh mắt đầy thù địch. Những cái đầu như bóng mờ, dường như chung một cơ thể ngâm trong dung dịch ăn mòn."
  },
  Event_7548_Name = {
    Text = "Nhìn chằm chằm của Quạ Đen"
  },
  Event_7549_ChoiceDesc1 = {
    Text = "[Rời đi] Khi số lượng thân thể được đánh thức ít hơn 3, nhận được bạc sáng tạo [(RelicConfig.Arg1)]"
  },
  Event_7549_ChoiceDesc2 = {
    Text = "[Khi rời đi] Khi có ít nhất 3 thân thể đã thức tỉnh, nhận được vật tạo vàng [(RelicConfig.Arg1)]"
  },
  Event_7549_Desc = {
    Text = "Bạn không để ý đến vết tích này, bước đi về phía trước. \n<Italic:thức tỉnh linh tri thức nặng nề biết bao>, vết tích ngày càng mở rộng, ngày càng uốn lượn theo bước chân của bạn, dường như bất cứ lúc nào cũng có thể từ khe nứt vươn ra một bàn tay, kéo bạn vào sâu thẳm."
  },
  Event_7549_Name = {
    Text = "Grieta reptante"
  },
  Event_7550_ChoiceDesc1 = {
    Text = "[đáp lại ánh nhìn] nhận được vật tạo vàng \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7550_ChoiceDesc2 = {
    Text = "[tránh ánh mắt] ngẫu nhiên thức tỉnh 2 thân thể được đánh thức, nhiễm hai lần [(Skill.Arg1)]"
  },
  Event_7550_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 50 dấu đen"
  },
  Event_7550_Desc = {
    Text = "Bạn có thể cảm nhận được một ánh mắt, một ánh mắt siêu việt từ chiều không gian, vượt xa thâm cảnh, đang dõi theo bạn, cũng như dõi theo cô gái trước mặt bạn. \n Hơi thở của bạn bắt đầu gấp gáp, trong sâu thẳm lý trí, nỗi sợ hãi gốc rễ bắt đầu gào thét."
  },
  Event_7550_Name = {Text = "Ai nhìn"},
  Event_7551_ChoiceDesc1 = {
    Text = "[tiếp tục tìm kiếm] tăng Arg1 điểm sức sống, bị nhiễm [(Skill.Arg2)]"
  },
  Event_7551_ChoiceDesc2 = {Text = "[đi]"},
  Event_7551_Desc = {
    Text = "Ánh sáng mờ ảo hiện ra trước mắt, tỏa sáng ngời và mang lại cảm giác ấm áp. Khi định bước theo nguồn sáng ấy, nó đột ngột tan biến."
  },
  Event_7551_Name = {
    Text = "Liên lạc bất thường"
  },
  Event_7552_ChoiceDesc1 = {Text = "[đi]"},
  Event_7552_Desc = {
    Text = "Lẩm nhẩm hát lên theo lời tụng niệm của họ, dòng nước ấm áp mang đến cho bạn lời chúc phúc trở về quê hương."
  },
  Event_7552_Name = {
    Text = "Bài hát biển cả"
  },
  Event_7553_ChoiceDesc1 = {
    Text = "[Xác nhận]"
  },
  Event_7553_Desc = {
    Text = "Bạn đã phát hiện ra ánh sáng mờ ảo phía trước, và cuối cùng đã thoát khỏi đám sương mù ngột ngạt này"
  },
  Event_7553_Name = {
    Text = "Sương hỗn loạn"
  },
  Event_7554_ChoiceDesc1 = {
    Text = "[Mở ra nhánh dưới đây]"
  },
  Event_7554_Desc = {
    Text = "Linh tri thức trong thâm cảnh còn sót lại liên kết với nhau, quấn quanh tạo thành một trường lực không ổn định. \nCó lẽ, bạn có thể gỡ rối những linh tri thức quấn quanh, mở đường phía trước."
  },
  Event_7554_Name = {
    Text = "Đường rối rắm"
  },
  Event_7555_ChoiceDesc1 = {
    Text = "[mở khóa nhánh phía trên]"
  },
  Event_7555_Desc = {
    Text = "Linh tri thức trong thâm cảnh còn sót lại liên kết với nhau, quấn quanh tạo thành một trường lực không ổn định. \nCó lẽ, bạn có thể gỡ rối những linh tri thức quấn quanh, mở đường phía trước."
  },
  Event_7555_Name = {
    Text = "Đường rối rắm"
  },
  Event_7556_ChoiceDesc1 = {
    Text = "[Giải quyết nhánh bên trái]"
  },
  Event_7556_Desc = {
    Text = "Linh tri thức trong thâm cảnh còn sót lại liên kết với nhau, quấn quanh tạo thành một trường lực không ổn định. \nCó lẽ, bạn có thể gỡ rối những linh tri thức quấn quanh, mở đường phía trước."
  },
  Event_7556_Name = {
    Text = "Đường rối rắm"
  },
  Event_7557_ChoiceDesc1 = {
    Text = "[Giải quyết nhánh bên trái]"
  },
  Event_7557_Desc = {
    Text = "Linh tri thức trong thâm cảnh còn sót lại liên kết với nhau, quấn quanh tạo thành một trường lực không ổn định. \nCó lẽ, bạn có thể gỡ rối những linh tri thức quấn quanh, mở đường phía trước."
  },
  Event_7557_Name = {
    Text = "Đường rối rắm"
  },
  Event_7558_ChoiceDesc1 = {Text = "[đi]"},
  Event_7558_Desc = {
    Text = "Bạn còn phải đối mặt với nhiều trận chiến ác liệt, đây không phải là lúc để thư thả điều tra."
  },
  Event_7558_Name = {
    Text = "Đăng ký cơ quan"
  },
  Event_7559_ChoiceDesc1 = {Text = "[đi]"},
  Event_7559_Desc = {
    Text = "Các ký tự trên giấy bỗng trở nên hoàn chỉnh và sống động, những lời lẽ kinh hoàng đủ sức làm rung chuyển niềm tin và nền tảng của mọi kẻ đau khổ vô thức. Bạn càng đọc càng mơ hồ, càng đọc càng sợ hãi, không thể ngừng dùng đầu ngón tay gãi đầu. \n Đột nhiên, những ký hiệu đầy lời nguyền đó biến mất. Ramona đã ngắt lời bạn và mạnh tay nhét trang sách vào trong vali."
  },
  Event_7559_Name = {
    Text = "Lệnh bí mật·dưới"
  },
  Event_7560_ChoiceDesc1 = {Text = "[đi]"},
  Event_7560_Desc = {
    Text = "Hạnh phúc, buồn bã, đau buồn, u uất… tất cả những điều này là cảm xúc của bạn. \nBạn, và vô số các phiên bản khác của bạn tồn tại trong các thế giới bên ngoài chiều."
  },
  Event_7560_Name = {Text = "Nghiện"},
  Event_7561_ChoiceDesc1 = {
    Text = "[Lặng lẽ lắng nghe] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7561_ChoiceDesc2 = {
    Text = "[Cô ấy ở đây] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7561_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_7561_Desc = {
    Text = "Tiếng rên rỉ của quái vật vang vọng trong tâm trí bạn, trong chất lỏng đen không có hình dạng, một giọng nói yếu ớt thì thầm \"chị Sasa\", \"chị Sasa\". \n \"Chị Sasa, chị ở đâu?\""
  },
  Event_7561_Name = {
    Text = "\"chị Sasa\""
  },
  Event_7562_ChoiceDesc1 = {Text = "[đi]"},
  Event_7562_Desc = {
    Text = "\"Tham gia cùng anh ấy, tham gia cùng họ, tham gia cùng chúng ta. \nTrở thành người bảo vệ của Người, trở thành Đấng Thiện Chí của Người. \nHãy lấy giấc mơ của Người làm hướng đi cho bạn...\"\nNhững lời cầu nguyện hỗn loạn khuấy động ý thức của bạn, sau khi những tiếng nói đó biến mất, bạn mới nhận ra mình đã ra mồ hôi đầy đầu."
  },
  Event_7562_Name = {
    Text = "Lời cầu nguyện giấc mơ"
  },
  Event_7563_ChoiceDesc1 = {
    Text = "[chưa từng nghe nói]"
  },
  Event_7563_ChoiceDesc2 = {
    Text = "[đã nghe nói]"
  },
  Event_7563_Desc = {
    Text = "「Bạn học sinh này, có thể dành chút thời gian của bạn cho tôi được không? \n Tôi hy vọng có thể làm phiền các bạn vài phút để giới thiệu về những truyền thuyết dân gian địa phương. \n Các bạn đã nghe nói về một sinh vật tên là『Khuyển Thần Địa Ngục』chưa?」"
  },
  Event_7563_Name = {
    Text = "Bạn đồng hành kỳ quặc Ⅰ"
  },
  Event_7564_ChoiceDesc1 = {
    Text = "[bỏ qua suy nghĩ] nhận được vật bị nguyền rủa \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7564_ChoiceDesc2 = {
    Text = "[Đuổi theo Cảm hứng] 1 thẻ lệnh ngẫu nhiên nhận được Khắc ấn: [(EnchantConfig.Arg1)]"
  },
  Event_7564_Desc = {
    Text = "Cảng bị tấn công, tàu hàng bí ẩn có đến mà không có về và \"người bạn mới\" có vây... Đây là một cái bẫy được chuẩn bị kỹ lưỡng hay lại là một chuyến đi đầy rẫy những sự cố? \nHiện thực và lý trí giằng co lẫn nhau, vô số cảm hứng và suy nghĩ tuôn trào trong tâm trí."
  },
  Event_7564_Name = {
    Text = "Bùng nổ cảm hứng"
  },
  Event_7565_ChoiceDesc1 = {
    Text = "[Núi lửa của Elworth?] Tăng Arg1 điểm máu tối đa"
  },
  Event_7565_ChoiceDesc2 = {
    Text = "[Cố gắng hồi tưởng] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7565_Desc = {
    Text = "Nước mắt màu đen chảy xuống hai má của Lily. \"Chúng ta đã gặp nhau rồi, mẹ,\" cô ấy thì thầm, \"ở núi lửa Elworth...\""
  },
  Event_7565_Name = {
    Text = "Ký ức núi lửa"
  },
  Event_7566_ChoiceDesc1 = {Text = "[đi]"},
  Event_7566_Desc = {
    Text = "\"đảo@1... biển...\"\nPhù văn lấp lánh trước mắt, bạn không thể kiềm chế được việc đưa tay vào khoảng không, muốn nắm lấy chúng—\n \"Đứng ngây ra đó làm gì!Họ sắp đuổi kịp rồi đấy!\"\nCô gái bí ẩn kéo bạn chạy về phía đầu kia của boong tàu, cắt đứt sự giao tiếp giữa bạn và phù văn.\nNhưng đúng là có một lực lượng nào đó, đã để lại dấu vết trên đầu ngón tay của bạn."
  },
  Event_7566_Name = {
    Text = "Rune Madness"
  },
  Event_7567_ChoiceDesc1 = {Text = "[đi]"},
  Event_7567_Desc = {
    Text = "Bạn không quan tâm đến những lời lảm nhảm thần bí, càng không muốn mạo hiểm đi vào đêm tối với nguy cơ điên cuồng."
  },
  Event_7567_Name = {
    Text = "Một lá thư cầu cứu"
  },
  Event_7568_ChoiceDesc1 = {Text = "[đi]"},
  Event_7568_Desc = {
    Text = "Dù sao đi nữa, trách nhiệm của Người Giữ Gìn sôi sục trong lồng ngực bạn. Bạn không thể từ bỏ hy vọng tìm thấy người gửi. Dù hy vọng này rất mơ hồ và khó nắm bắt."
  },
  Event_7568_Name = {
    Text = "Một lá thư cầu cứu"
  },
  Event_7569_ChoiceDesc1 = {
    Text = "[Quan sát nó] có thể nhận được 25 dấu đen"
  },
  Event_7569_ChoiceDesc2 = {
    Text = "[Vuốt ve nó] 50% cơ hội nhận được 50 dấu đen, 50% cơ hội không có gì cả"
  },
  Event_7569_Desc = {
    Text = "Một con mèo đen đột nhiên xuất hiện trong con hẻm, bị cuốn vào chân các người một cách thân mật khác thường, đôi mắt dọc màu xanh lục lấp lánh ánh sáng gây cảm giác lạnh sống lưng, giống như đang nói \"Đừng đuổi theo nữa, hãy chơi với tôi một lát đi.\"\n \"Bạn đã thấy Người ấy rồi, Người ấy đang ở bên cạnh bạn, những bóng tối bị ô nhiễm bởi điên cuồng, cuồng nhiệt... đừng nhìn thẳng vào hình dạng của Người ấy.\""
  },
  Event_7569_Name = {Text = "Elfo Đêm"},
  Event_7570_ChoiceDesc1 = {Text = "[đi]"},
  Event_7570_Desc = {
    Text = "\"Không thể, tôi không tin!\" Giọng nói hét lên, \"Người phụ nữ này đã đưa tôi cho quỷ dữ, đây không phải là chị Sasa của tôi!\""
  },
  Event_7570_Name = {
    Text = "\"chị Sasa\""
  },
  Event_7571_ChoiceDesc1 = {Text = "[đi]"},
  Event_7571_Desc = {
    Text = "\"Nhận được, chúng tôi sẽ tiến hành vận chuyển vật tư cơ bản, vui lòng chú ý kiểm tra.\""
  },
  Event_7571_Name = {
    Text = "Hỗ trợ thông tin"
  },
  Event_7572_ChoiceDesc1 = {Text = "[đi]"},
  Event_7572_Desc = {
    Text = "Vật này đã hoàn toàn vô dụng."
  },
  Event_7572_Name = {
    Text = "Di sản của người xưa"
  },
  Event_7573_ChoiceDesc1 = {
    Text = "[Cẩn thận xem xét] Nhận 1 trong 3 khắcăng"
  },
  Event_7573_ChoiceDesc2 = {
    Text = "[Xé áp phích] 1 thẻ lệnh ngẫu nhiên nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7573_Desc = {
    Text = "Một giá nến thường thấy trong bảo tàng sáp. \n Nhờ ánh sáng mờ ám màu cam, bạn phát hiện ra một poster vẽ tay dán trên tường."
  },
  Event_7573_Name = {
    Text = "Tiếng cười trong bóng tối"
  },
  Event_7574_ChoiceDesc1 = {Text = "[đi]"},
  Event_7574_Desc = {
    Text = "\"Lily có trái tim riêng của mình, không cần phải nghe theo bất kỳ ai.\" bạn trả lời bình tĩnh và kiên định. \nFrancis hừ lạnh, không đáp lại."
  },
  Event_7574_Name = {
    Text = "Lựa chọn của cô ấy"
  },
  Event_7575_ChoiceDesc1 = {Text = "[đi]"},
  Event_7575_Desc = {
    Text = "Đây là một nhóm ảnh chân dung. \n Những người uể oải ngồi xổm phía sau hàng rào sắt, mặt mày đầy khổ sở. \n Một bức ảnh trong số đó thu hút sự chú ý của bạn. Đó có lẽ là một phụ nữ trẻ gầy gò, mặt cô ấy hoàn toàn trống rỗng. \n Sinh vật tàn nhẫn vô cùng đó đang quấn quanh cơ thể cô ấy từng vòng từng vòng. \n Bạn không thấy mặt cô ấy, nhưng trong trí tưởng tượng của bạn, cô ấy hẳn là không có biểu cảm."
  },
  Event_7575_Name = {
    Text = "ghi lại trung thực"
  },
  Event_7576_ChoiceDesc1 = {Text = "[đi]"},
  Event_7576_Desc = {
    Text = "Bạn say mê nhìn chằm chằm vào những món trang sức lấp lánh, một lúc không để ý, đã nắm lấy bàn tay đen gầy guộc đầy chất nhầy đó.\nCòn nó chỉ là siết nhẹ tay lại, rồi buông ra.\nKhông có gì xảy ra cả, chỉ có một làn khí đen, theo đầu ngón tay bạn trượt vào trong tay áo."
  },
  Event_7576_Name = {
    Text = "Đảo ngược móng quỷ"
  },
  Event_7577_ChoiceDesc1 = {
    Text = "[gõ vài nốt nhạc] nhận được bạc sáng tạo \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7577_ChoiceDesc2 = {
    Text = "[đóng nắp lại] chọn 1 trong 3 khắcăng"
  },
  Event_7577_Desc = {
    Text = "Chiếc piano bên tường mở nắp. Nó có những phím đàn ngả vàng và các cạnh nứt nhẹ để lộ màu gỗ tự nhiên, nhưng mỗi phím đàn đều được lau chùi rất sạch sẽ. \nNó là nguồn vui của biết bao nhiêu người."
  },
  Event_7577_Name = {
    Text = "Melodi tuổi thơ"
  },
  Event_7578_ChoiceDesc1 = {Text = "[đi]"},
  Event_7578_Desc = {
    Text = "Người cầm giáo ừ hữ một tiếng, như một đứa trẻ bị bắt nạt đang nức nở. \n Tiếng động tan biến trong chớp mắt, cả hai người dấn thân vào biển cũng biến mất tăm… Hóa ra chỉ là ảo ảnh phản chiếu từ thâm cảnh."
  },
  Event_7578_Name = {
    Text = "Truy đuổi không ngừng"
  },
  Event_7579_ChoiceDesc1 = {
    Text = "[rời đi] nhận được bạc tạo vật [(RelicConfig.Arg1)]"
  },
  Event_7579_Desc = {
    Text = "\"Câu trả lời đúng.\"\nChủ nhân của giọng nói rất hài lòng với câu trả lời, một vật phẩm lấp lánh được ném ra khỏi mặt nước.\n \"Hãy nhớ, mọi thứ đều có giá của nó.\""
  },
  Event_7579_Name = {
    Text = "Giọng ngoài thế giới"
  },
  Event_7580_ChoiceDesc1 = {
    Text = "[Giải trừ ảo ảnh] Triệu chứng nhiễm bệnh."
  },
  Event_7580_ChoiceDesc2 = {Text = "[đi]"},
  Event_7580_Desc = {
    Text = "Những khuôn mặt mờ ảo đột nhiên xuất hiện, chúng vây quanh bạn và tuyệt vọng rên rỉ bằng những dây thanh âm không tồn tại."
  },
  Event_7580_Name = {Text = "ảo ảnh"},
  Event_7581_ChoiceDesc1 = {Text = "[đi]"},
  Event_7581_Desc = {
    Text = "Bạn không để ý đến vết tích này, bước đi về phía trước. \n Nhưng như thể bị kích thích, vết tích ngày càng mở rộng, ngày càng uốn lượn theo bước chân của bạn, dường như bất cứ lúc nào cũng có thể từ khe nứt vươn ra một bàn tay, kéo bạn vào sâu thẳm."
  },
  Event_7581_Name = {
    Text = "Grieta reptante"
  },
  Event_7582_ChoiceDesc1 = {Text = "[đi]"},
  Event_7582_Desc = {
    Text = "Bạn sẽ không dễ dàng mắc bẫy, quay lưng một cách dứt khoát và rời khỏi đây."
  },
  Event_7582_Name = {
    Text = "Grieta reptante"
  },
  Event_7583_ChoiceDesc1 = {Text = "[đi]"},
  Event_7583_Desc = {
    Text = "Bạn nhận ra sự khác thường của vết nứt, quỳ xuống để kiểm tra. Kỳ lạ thay, vết nứt vừa còn đang lan rộng, đột ngột ngừng lại hẳn, rơi vào sự im lặng vĩnh cửu."
  },
  Event_7583_Name = {
    Text = "Grieta reptante"
  },
  Event_7584_ChoiceDesc1 = {Text = "[đi]"},
  Event_7584_Desc = {
    Text = "\"Không, là cái đầu tỉnh táo. Quyết tâm không thể giúp bạn giải quyết được thân thể bị rỗng rỗng, Người Giữ Gìn, hãy tìm cách giải quyết đi.\""
  },
  Event_7584_Name = {
    Text = "Luật của Logan"
  },
  Event_7585_ChoiceDesc1 = {Text = "[đi]"},
  Event_7585_Desc = {
    Text = "Bạn không thể chống lại cơn thôi thúc trong lòng. \nNgón tay như những đứa trẻ lạc trong rừng, lang thang và vui chơi trên bàn phím…… \nDần dần, có những con bướm bay ra từ máy đánh chữ. \nMột con, hai con, ba con…… \nTrên mặt, trên ngón tay, những đàn bướm như những bông pháo nở rộ trên không trung, lấp lánh ánh sáng như ngọc trong bóng tối. \nChiếc máy đánh chữ này không có bất kỳ công dụng thực tế nào, nhưng nó lại rất giỏi trong việc tạo ra cái đẹp."
  },
  Event_7585_Name = {Text = "mắt"},
  Event_7586_ChoiceDesc1 = {
    Text = "[buộc chặt con gà mái]"
  },
  Event_7586_Desc = {
    Text = "Sản phẩm đặc trưng của Lai, con gà mái năng động, món ăn hấp dẫn."
  },
  Event_7586_Name = {Text = "Làm bẫy"},
  Event_7587_ChoiceDesc1 = {
    Text = "[Hoàn thành xuất sắc]"
  },
  Event_7587_Desc = {
    Text = "Bẫy rẻ nhưng hiệu quả!"
  },
  Event_7587_Name = {Text = "Làm bẫy"},
  Event_7588_ChoiceDesc1 = {
    Text = "[Đặt bẫy thú]"
  },
  Event_7588_Desc = {
    Text = "Bẫy thú bằng kim loại, trợ thủ đắc lực cho thợ săn lười biếng."
  },
  Event_7588_Name = {Text = "Làm bẫy"},
  Event_7589_ChoiceDesc1 = {
    Text = "[Xem máy điện báo] bị lây nhiễm \"(Skill.Arg1)\", nhận được sáng tạo vàng \"(RelicConfig.Arg2)\""
  },
  Event_7589_ChoiceDesc2 = {
    Text = "[bỏ qua] nhận được 50 dấu đen"
  },
  Event_7589_Desc = {
    Text = "Bạn trốn vào khe hở hẹp của hang động, tạm tránh gió tuyết. Nhưng bạn biết rõ mình không thể dừng lại ở đây quá lâu, nếu nhóm người mặc áo choàng đen tìm thấy nơi này, bạn sẽ không có đường thoát.\nTrong góc của khe hở, bạn lại phát hiện ra một chiếc máy điện báo."
  },
  Event_7589_Name = {
    Text = "Điện báo im lặng"
  },
  Event_7590_ChoiceDesc1 = {
    Text = "[Kiểm tra phim] Nâng cấp ngẫu nhiên hiệu ứng khắcăng của 2 thẻ bài"
  },
  Event_7590_ChoiceDesc2 = {
    Text = "[Kiểm tra máy ảnh] Chọn 1 thẻ lệnh từ 3 thẻ để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_7590_Desc = {
    Text = "Như kéo ra một đoạn nội tạng, phim trong bụng máy ảnh bị xé nát, bị vứt bỏ ở đây, không ai quan tâm. \nMột tia sáng trắng chói mắt lóe lên, máy ảnh bị vứt ở góc đường nghiêng lệch, cửa trập bị bấm không rõ nguyên do. \n \"Rắc——\"\nDáng vẻ kinh ngạc, ngây người của bạn được ghi lại trung thực trên phim trong máy ảnh."
  },
  Event_7590_Name = {
    Text = "Bản ghi vô tội"
  },
  Event_7591_ChoiceDesc1 = {
    Text = "[Bóp cổ ca sĩ] nhận được vật bị nguyền rủa \"(RelicConfig.Arg1)\", bị ảnh hưởng bởi \"(Skill.Arg2)\""
  },
  Event_7591_ChoiceDesc2 = {
    Text = "[Làm vấp ngã bước chân Vũ công] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: [(EnchantConfig.Arg1)]"
  },
  Event_7591_ChoiceDesc3 = {
    Text = "[Đánh cắp bản thảo của thi sĩ] nhận được 50 dấu đen"
  },
  Event_7591_Desc = {
    Text = "Bạn bị ba bóng người dính dấp chắn đường. \n Một bóng người hát, giọng khàn, lời bài hát kỳ quái, bạn bịt tai lại, đi vòng qua nó. \n Một bóng người nhảy múa, động tác cứng nhắc, bước đi do dự, bạn nhắm mắt lại, tránh khỏi nó. \n Một bóng người ngâm thơ, nhịp điệu vụn vặt, câu cú không thông, bạn không thể chịu đựng được nữa, vì vậy——"
  },
  Event_7591_Name = {
    Text = "Kẻ ác trên con đường hẹp"
  },
  Event_7592_ChoiceDesc1 = {Text = "[đi]"},
  Event_7592_Desc = {
    Text = "\"Không! Sự tiến bộ của loài người không phụ thuộc vào lịch sử, cũng không phải công nghệ, mà là chuột.\"\n \"Chính chuột đã mở ra thời đại tối tăm đó, sau đó loài người mới đón nhận ánh sáng phục hưng.\"\n \"Loài người cần các ngươi — mặc dù không phải ai cũng hiểu điều này.\"\nNhững con chuột có vẻ bị thuyết phục bởi bài diễn văn dài dòng của bạn, nhưng vẫn để bạn rời đi."
  },
  Event_7592_Name = {
    Text = "Bệnh dịch hạch"
  },
  Event_7593_ChoiceDesc1 = {Text = "[đi]"},
  Event_7593_Desc = {
    Text = "Bạn kiềm chế sự co giật của dây thần kinh thị giác, cố gắng phân biệt…\nỞ đó dường như vẽ một vòng tròn pháp trận đã bị xé toạc. \nBên trong pháp trận được tạo thành từ vô số đường cong, vừa tĩnh lại vừa như đang chảy, khiến người ta choáng váng."
  },
  Event_7593_Name = {Text = "từ góc"},
  Event_7594_ChoiceDesc1 = {Text = "[đi]"},
  Event_7594_Desc = {
    Text = "<Bold>Bảo tàng sáp Rogers\nSố 44 đường Namwark, thành phố Lentiennam@2\nThời gian tham quan: 21:00-6:00\n3:00 dừng nhập trường (đóng cửa vào cuối tuần)\n\n<Bold>Triển lãm hiện tại\nVladimir @2: \nTriết lý nụ cười"
  },
  Event_7594_Name = {
    Text = "Tiếng cười trong bóng tối"
  },
  Event_7595_ChoiceDesc1 = {
    Text = "[Đối diện] chọn 1 thẻ lệnh từ 3 thẻ lệnh để nhận khắcăng: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7595_ChoiceDesc2 = {
    Text = "[đóng mắt] chọn thức tỉnh 1 thân thể được đánh thức, bị ảnh hưởng bởi [(Skill.Arg1)]"
  },
  Event_7595_ChoiceDesc3 = {
    Text = "[quay lưng] nhận được 25 dấu đen"
  },
  Event_7595_Desc = {
    Text = "Lẽ ra không nên nhìn thấy bầu trời đầy sao. \n Trong thâm cảnh của tàu Sonanier, bầu trời lấp lánh ánh sáng huyền ảo, hình dáng của sao và trăng đều ẩn hiện. \n Trong khoang tàu tối tăm, bạn cũng không nên nhìn thấy bầu trời đầy sao. \n Ở đây chỉ nên có những bóng đèn tròn lẻ tẻ và những chiếc đèn cổ—— nhưng tại sao, bạn vẫn cảm nhận được ánh mắt treo lơ lửng trên bầu trời?"
  },
  Event_7595_Name = {Text = "Nhìn lén"},
  Event_7596_ChoiceDesc1 = {Text = "[đi]"},
  Event_7596_Desc = {
    Text = "Bạn chọn can đảm nhìn thẳng vào đôi mắt. \nChúng là sao mai lấp lánh, tỏa sáng trong bóng tối. \nSau đó, chúng mỉm cười và biến thành nhiều mặt trăng cong cong. \nĐôi mắt nói: \"Bạn không sợ hãi ánh mắt. Bạn cũng không nên sợ hãi... Lâu rồi không gặp, @2\"\nTrước khi biến mất, chúng tặng bạn một quà tặng nhỏ, như một \"kỷ niệm tái ngộ\"."
  },
  Event_7596_Name = {Text = "mắt"},
  Event_7597_ChoiceDesc1 = {Text = "[đi]"},
  Event_7597_Desc = {
    Text = "Cầu đường sắt, mạch máu và thần kinh của Lentiennam, liên kết trái tim và tứ chi của thành phố, miễn là mặt trời chưa lặn ở đây, trái tim của Lentiennam sẽ luôn đập mạnh mẽ."
  },
  Event_7597_Name = {
    Text = "ảo giác của cây cầu thép"
  },
  Event_7598_ChoiceDesc1 = {Text = "[đi]"},
  Event_7598_Desc = {
    Text = "Một bản fuga vô cùng lộng lẫy, tác giả không rõ. \n Vô số bè âm mang chủ đề tương đồng đan xen tuôn trào, mỗi nốt nhạc như dao mổ của bác sĩ, chính xác và lạnh lùng. \n Chính xác và lộng lẫy - đó chính là thẩm mỹ của Rogers. \n Fuga, hãy bay lên!"
  },
  Event_7598_Name = {
    Text = "khẩu vị kém"
  },
  Event_7599_ChoiceDesc1 = {
    Text = "[chào hỏi bằng giọng nói]"
  },
  Event_7599_ChoiceDesc2 = {
    Text = "[Tìm kiếm sự giúp đỡ]"
  },
  Event_7599_Desc = {
    Text = "Khi tay bạn đặt lên thành thuyền, bạn thấy một cô gái mặc váy trắng. \n Cao quý, thánh thiện, hư ảo… và có chút quen thuộc. \n Rốt cuộc bạn đã gặp cô ấy ở đâu? Bạn đang khó khăn khai thác những ký ức hỗn loạn, nhưng cô ấy bỗng nhiên nhận ra sự tồn tại của bạn, nhìn thẳng vào bạn qua khoảng không. \n Đôi mắt của cô ấy bình tĩnh như biển cả mùa xuân, nhưng bạn lại kỳ lạ đọc được điều gì đó từ trong đó… \n Cô ấy dường như đang chờ bạn chào hỏi, dù chỉ là nói về thời tiết hôm nay."
  },
  Event_7599_Name = {
    Text = "Gái mặc váy trắng"
  },
  Event_7600_ChoiceDesc1 = {
    Text = "[khen ngợi nó] chọn 1 thẻ lệnh từ 3 thẻ để nhận khắcăng: [(EnchantConfig.Arg1)]"
  },
  Event_7600_ChoiceDesc2 = {
    Text = "[châm chọc nó] nhiễm [(Skill.Arg1)], lại ngẫu nhiên khắc ấn"
  },
  Event_7600_Desc = {
    Text = "Jenkins nói: Johnny! Cậu thật sự khác xưa... khác hoàn toàn về mọi mặt.\nCậu nói: cậu đúng là một bộ não vừa siêng năng vừa đầy khát vọng.\nBộ não ngọ nguậy một chút, rõ ràng là rất vui mừng.\nBộ não nói: Nào! Vì các cậu đã công nhận thành tựu hiện tại của tôi, tôi sẽ truyền đạt cho các cậu toàn bộ kiến thức cả đời của tôi..."
  },
  Event_7600_Name = {
    Text = "Não triết học"
  },
  Event_7601_ChoiceDesc1 = {
    Text = "[Hoàn mỹ Fugue] nhận được bạc sáng tạo \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7601_ChoiceDesc2 = {
    Text = "[Bài hát đêm đơn giản] Tất cả thân thể được đánh thức phục hồi 50 điểm điên cuồng, nhiễm [(Skill.Arg1)]"
  },
  Event_7601_ChoiceDesc3 = {
    Text = "[Tiếng ồn vô nghĩa] nhận được khắcăng, chọn 1 trong 3"
  },
  Event_7601_Desc = {
    Text = "\"Riêng tôi không mấy đồng tình với gu âm nhạc của Giám đốc, bạn hiểu mà...\nQuá rườm rà, còn tôi là người thực tế.\"\nGiọng nam mệt mỏi vang lên từ chiếc máy hát kẽo kẹt, một cách cô độc và đầy trách móc. \n \"Nhưng đây là công việc của tôi... Thôi, ta nên tiết kiệm thời gian, chọn một bản đi.\""
  },
  Event_7601_Name = {
    Text = "khẩu vị kém"
  },
  Event_7602_ChoiceDesc1 = {
    Text = "[ có sáng tạo đặc biệt, nhận được vật tạo vàng 「(RelicConfig.Arg1)」 ]"
  },
  Event_7602_ChoiceDesc2 = {
    Text = "[rời đi] nhận được 50 dấu đen"
  },
  Event_7602_Desc = {
    Text = "Sự kiện 253 (đang phát triển), chưa phải phiên bản cuối cùng"
  },
  Event_7602_Name = {
    Text = "Sự kiện 253 (đang cập nhật)"
  },
  Event_7603_ChoiceDesc1 = {Text = "[đi]"},
  Event_7603_Desc = {
    Text = "Bạn chạy khỏi hiện trường với tốc độ nhanh nhất. \n Hiện tại các bạn đang đối mặt với những con quái vật khó chịu và ghê tởm nhất từ trước đến nay - những bình tượng nến dày đặc đó. \n So với chúng, mấy cái bình đất thô sơ này thực sự là không đủ nhìn. \n Phân biệt rõ ràng mức độ quan trọng của mọi việc - đây là một trong những nguyên tắc mà Người Giữ Gìn nên tuân thủ."
  },
  Event_7603_Name = {Text = "bài tập"},
  Event_7604_ChoiceDesc1 = {Text = "[đi]"},
  Event_7604_Desc = {
    Text = "Chìa khóa bạc lấp lánh, ánh sáng bạc trắng tràn ngập không gian, biến dòng chảy màu sắc đặc quánh thành bạc tinh khiết. \n Ánh sáng chợt tắt, chỉ còn gió mang theo tiếng nức nở đầy ai oán."
  },
  Event_7604_Name = {
    Text = "Màu sắc hoài niệm"
  },
  Event_7605_ChoiceDesc1 = {Text = "[đi]"},
  Event_7605_Desc = {
    Text = "Đó là một cầu vồng làm bạn choáng ngợp, không biết từ lúc nào, bạn đã say mê trong đó……"
  },
  Event_7605_Name = {
    Text = "Điểm giao nhau của các ngôi sao"
  },
  Event_7606_ChoiceDesc1 = {
    Text = "[tiếp tục rơi] bị nhiễm [(Skill.Arg1)], có tiếp tục không"
  },
  Event_7606_ChoiceDesc2 = {
    Text = "[rút lui] nhận được 25 dấu đen"
  },
  Event_7606_Desc = {
    Text = "\"bạn\" mời gọi bạn. \nTrong lòng xoắn ốc, \"bạn\" từ quá khứ và tương lai gửi tặng bạn những \"món quà\" từ các chiều không gian khác nhau."
  },
  Event_7606_Name = {
    Text = "Vực thẳm xoắn ốc"
  },
  Event_7607_ChoiceDesc1 = {
    Text = "[tâm trí sáng suốt] nhận được vật tạo vàng \"(RelicConfig.Arg1)\", bị ảnh hưởng bởi \"(Skill.Arg2)\""
  },
  Event_7607_ChoiceDesc2 = {
    Text = "[không biết gì cả] nhận được 1 trong 3 vật tạo vàng, bị nhiễm [(Skill.Arg1)]"
  },
  Event_7607_ChoiceDesc3 = {
    Text = "[rời đi] nhận được bạc tạo vật [(RelicConfig.Arg1)]"
  },
  Event_7607_Desc = {
    Text = "Hai hình bóng phát sáng màu bạc hiện ra trước mắt bạn, có dạng lỏng đặc, trôi nổi trong không khí. \n \"Đây chính là nơi ta tiêu vong.\" Một hình bóng cúi xuống. \n \"Trong thần quốc không bệnh tật, không có khát vọng hay mất mát, ngươi không thực sự hiểu — thế nào mới gọi là tiêu vong.\" Hình bóng còn lại thở dài, đưa ánh nhìn về phía bạn."
  },
  Event_7607_Name = {
    Text = "Thần quốc bị lãng quên"
  },
  Event_7608_ChoiceDesc1 = {
    Text = "[Rời đi] tìm đèn pha"
  },
  Event_7608_ChoiceDesc2 = {
    Text = "[xâm nhập sương mù] nhiễm [(Skill.Arg2)]"
  },
  Event_7608_ChoiceDesc3 = {
    Text = "[đi thẳng vào]"
  },
  Event_7608_Desc = {
    Text = "Phía trước là một vùng sương đen dày đặc, khinh suất tiến vào sẽ mang lại thảm họa. \nCó lẽ bạn nên tìm \"đèn pha\"để xua tan sương mù."
  },
  Event_7608_Name = {
    Text = "không biết"
  },
  Event_7609_ChoiceDesc1 = {Text = "[đi]"},
  Event_7609_Desc = {
    Text = "\"Đó là hình chiếu của ký ức,\" Ramona giải thích với bạn,\"có thể thuộc về một người nào đó, hoặc là ký ức chung của vài người.\"\nKý ức quý giá, đáng để cẩn thận bảo quản."
  },
  Event_7609_Name = {
    Text = "Kí ức của chúng tôi"
  },
  Event_7610_ChoiceDesc1 = {Text = "[đi]"},
  Event_7610_Desc = {
    Text = "Dù bây giờ không thể giải mã, bạn cũng không từ bỏ, mà kiên nhẫn gấp lại và nhét vào túi, đợi trở lại trường để tìm cách khác đọc thông tin. \n Chỉ là, khi bức thư một cách kỳ quái tự co lại, ngực bạn cũng bắt đầu cảm thấy đau âm ỉ."
  },
  Event_7610_Name = {
    Text = "Thư bị gạch ngang"
  },
  Event_7611_ChoiceDesc1 = {Text = "[đi]"},
  Event_7611_Desc = {
    Text = "Nến tự động bùng cháy ngay khi rời khỏi cân, chảy những giọt sáp trắng đục như lệ, nhanh chóng rơi giữa các ngón tay rồi tan biến."
  },
  Event_7611_Name = {
    Text = "Lý trí và Tình cảm"
  },
  Event_7612_ChoiceDesc1 = {Text = "[đi]"},
  Event_7612_Desc = {
    Text = "Bạn kéo giấy ra, nhưng máy đánh chữ vẫn đang hoạt động. Nó cuốn vào một lá bài, và trên đó đầy mực. \n Bạn cẩn thận nhận diện, trên đó dường như viết đi viết lại \"đừng nhìn thẳng đừng nhìn thẳng đừng nhìn thẳng đừng nhìn thẳng đừng nhìn thẳng\"."
  },
  Event_7612_Name = {
    Text = "Cảnh báo không mời"
  },
  Event_7613_ChoiceDesc1 = {Text = "[đi]"},
  Event_7613_Desc = {
    Text = "Khi đầu ngón tay chạm vào vành cốc lạnh buốt đến tận xương tủy, bạn bỗng nhiên rùng mình và tỉnh dậy. \nDù sao, nó không thích hợp để bị bỏ lại bên lề đường. Hãy cất nó vào vali thôi."
  },
  Event_7613_Name = {
    Text = "Rượu ngọt mật ong"
  },
  Event_7614_ChoiceDesc1 = {Text = "[đi]"},
  Event_7614_Desc = {
    Text = "Bạn ho dữ dội. \n Âm thanh dường như bị giật mình, sau đó rơi vào im lặng hoàn toàn. \n Bạn cảm thấy mình có lẽ đã bỏ lỡ một đầu mối quan trọng… \n Nhưng cuộc sống luôn đầy rẫy những điều bỏ lỡ và tiếc nuối, phải không?"
  },
  Event_7614_Name = {
    Text = "Cách tường có tai"
  },
  Event_7615_ChoiceDesc1 = {
    Text = "[giữ kín miệng] nhận được 25 dấu đen"
  },
  Event_7615_ChoiceDesc2 = {
    Text = "[đụng vào] 50% cơ hội nhận được 50 dấu đen, 50% cơ hội trắng tay"
  },
  Event_7615_Desc = {
    Text = "\"Tôi chỉ muốn nói một câu châm ngôn — không ai có thể giết chết một con mèo!\"\n \"Con mèo đen đáng chết kia đáng ra phải bị xẻo bụng, phơi xác trên đồng hoang, nhưng nó lại đào mở mộ phần gia tộc của tôi, ăn sạch những mảnh thịt thối rữa còn lại của con người, còn xương cốt và chi thể thì rơi rớt bốn phía.\"\n \"Dưới ánh nhìn lạnh lẽo của đôi mắt dọc, lớp mủ vàng nhạt nổi lên một mùi hôi thối, tôi lăn lộn trườn ra khỏi đó, tinh thần suy sụp vì bị ác mộng hành hạ.\"\n \"Chờ đã... các người định làm gì, tôi không điên! Tôi không! Các người chắc chắn đang muốn che giấu điều gì! Điều này là thật —\"\nĐúng vậy, điều này là thật, tiễn biệt bóng dáng của kẻ điên cuồng mất hút, bạn và con mèo đen yên lặng ngồi bên chân bạn liếc nhìn nhau."
  },
  Event_7615_Name = {
    Text = "Đám tai ương của mèo đêm"
  },
  Event_7616_ChoiceDesc1 = {Text = "[đi]"},
  Event_7616_Desc = {
    Text = "Trong lúc bạn do dự, nó chìm xuống và hòa tan vào dấu rỗng rỗng, nhanh chóng biến mất."
  },
  Event_7616_Name = {
    Text = "Đối tượng nổi trong xô"
  },
  Event_7617_ChoiceDesc1 = {Text = "[đi]"},
  Event_7617_Desc = {
    Text = "Bạn bực bội nhăn giấy thư thành một cục, ném xuống chân."
  },
  Event_7617_Name = {
    Text = "Thư bị gạch ngang"
  },
  Event_7618_ChoiceDesc1 = {
    Text = "[Xác nhận]"
  },
  Event_7618_Desc = {
    Text = "Bạn tập trung tinh thần, ảo ảnh tan đi như bức tranh thủy mặc. Bạn tiếp tục tiến lên, nhưng không thể hoàn toàn xóa bỏ bóng tối trong lòng."
  },
  Event_7618_Name = {Text = "ảo ảnh"},
  Event_7619_ChoiceDesc1 = {
    Text = "[Cẩn thận xem] nhận được bạc tạo vật \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_7619_ChoiceDesc2 = {
    Text = "[tránh bóng người] nhận được bạc sáng tạo \"(RelicConfig.Arg1)\", bị ảnh hưởng bởi \"(Skill.Arg2)\""
  },
  Event_7619_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_7619_Desc = {
    Text = "Ramona's thần kinh căng thẳng, cẩn thận di chuyển tránh đám đông trong viện tâm thần. \nCô trốn vào một căn phòng nhỏ. \nBóng người đột nhiên xuất hiện bên ngoài cửa sổ."
  },
  Event_7619_Name = {
    Text = "Phản ánh trong cửa sổ"
  },
  Event_7620_ChoiceDesc1 = {
    Text = "[rời đi] nhận được 50 dấu đen"
  },
  Event_7620_Desc = {
    Text = "Bây giờ, việc quan trọng hơn là đưa kẻ gây ra tất cả những điều này ra công lý. Nhưng hạt giống của sự tức giận vẫn nảy mầm trong lòng bạn. Không chờ đợi phản ứng của các bạn, người đàn ông quay người rời đi."
  },
  Event_7620_Name = {
    Text = "Dấu chân quái thú"
  },
  Event_7621_ChoiceDesc1 = {
    Text = "[rời đi] nhận được 75 dấu đen, bị nhiễm [(Skill.Arg2)]"
  },
  Event_7621_Desc = {
    Text = "Từ nhỏ, bạn đã được giáo dục ở Misaque, điều đó khiến bạn không thể ngồi yên trước bản khắc này. Bạn đưa tay lau đi dấu chân bụi bẩn, vào khoảnh khắc đó, bạn dường như nghe thấy một tiếng đáp lại từ chiều xa xôi, \"Cảm ơn\"."
  },
  Event_7621_Name = {
    Text = "Dấu chân quái thú"
  },
  Event_7622_ChoiceDesc1 = {Text = "[đi]"},
  Event_7622_Desc = {
    Text = "Bạn nắm chặt chìa khóa bạc, ánh sáng bạc dịu dàng và sự rung động nhẹ nhàng khiến bạn cảm thấy an tâm. Ánh mắt dường như đã biến mất, lại cũng như không, dù sao đi nữa, nó đã để lại trên người bạn dấu vết vô hình thuộc về nó."
  },
  Event_7622_Name = {Text = "Ai nhìn"},
  Event_7623_ChoiceDesc1 = {
    Text = "[Tìm đường bí mật]"
  },
  Event_7623_Desc = {
    Text = "Bạn và Ramona, lơ-tan chia làm ba hướng, bắt đầu truy đuổi chó địa ngục.\n\nBạn chạy nhanh qua vài con hẻm, thân hình to lớn xuất hiện trước mặt bạn.\nNó thấy bạn đuổi theo, lập tức rẽ vào góc tiếp theo.\nBạn chạy theo, nhưng trước mặt lại là một con đường cụt, ba mặt tường cao chặn lại tạo thành một bầu trời hình vuông hẹp."
  },
  Event_7623_Name = {
    Text = "Đường cụt"
  },
  Event_7624_ChoiceDesc1 = {Text = "[đi qua]"},
  Event_7624_ChoiceDesc2 = {
    Text = "[vuốt ve]"
  },
  Event_7624_Desc = {
    Text = "Giường mổ sạch sẽ và mềm mại bên cạnh, thân thể của Kum đã trở nên mềm yếu nằm đó. \n Cô vẫn còn cao lớn, như một ngọn đồi nhỏ, giống như lần đầu bạn gặp cô ấy. \n Chỉ là, so với những con \"chó địa ngục\" thực sự ở trên cao, cô lại quá nhỏ bé, nhỏ đến mức như một đứa trẻ."
  },
  Event_7624_Name = {
    Text = "Nhiệt dư"
  },
  Event_7625_ChoiceDesc1 = {
    Text = "[Nhận được bạc tâm]"
  },
  Event_7625_Desc = {
    Text = "À, phía trước dường như có rất nhiều thứ lấp lánh! \n Ngửi một cái… thơm quá. \n Liếm một cái… mát lạnh! \n Nhìn như là đồ quý giá, mau thu lại đưa cho tiểu Jenkin, không chừng có thể đổi được nhiều phô mai thật đấy!"
  },
  Event_7625_Name = {
    Text = "Sáng lấp lánh"
  },
  Event_7626_ChoiceDesc1 = {Text = "[đi]"},
  Event_7626_Desc = {
    Text = "Một nỗi thất vọng dường như không phải của bạn dần dâng lên trong lòng, mạng lưới ảo tưởng từ từ tan biến, mở ra một con đường."
  },
  Event_7626_Name = {
    Text = "Mạng lưới lạc lối"
  },
  Event_7627_ChoiceDesc1 = {
    Text = "[Hiểu nó] ngẫu nhiên thức tỉnh 1 thân thể được đánh thức, nhiễm [(Skill.Arg1)]"
  },
  Event_7627_ChoiceDesc2 = {
    Text = "[bỏ qua nó] nhận được chọn 1 trong 3 khắcăng"
  },
  Event_7627_Desc = {
    Text = "Chuỗi ký tự di chuyển từ tiếng gầm của sức sống hình con cá, chúng tràn ngập tai, mũi và cổ họng của bạn. Chúng đốt cháy thân thể bạn, chỉ cần mười giây nữa, bạn sẽ lĩnh hội được ẩn ý sâu thẳm trong tiếng gầm đó…"
  },
  Event_7627_Name = {
    Text = "Rune Madness"
  },
  Event_7628_ChoiceDesc1 = {Text = "[đi]"},
  Event_7628_Desc = {
    Text = "Bạn nghiến răng cố gắng chống lại ảo giác hỗn loạn. Ramona đặt một vật lạnh lẽo vào lòng bàn tay bạn. \n \"Đây là vật sáng tạo tôi vừa phát hiện, có thể sẽ giúp được bạn.\""
  },
  Event_7628_Name = {
    Text = "Ảo ảnh chiều"
  },
  Event_7629_ChoiceDesc1 = {
    Text = "Chọn khắcăng"
  },
  Event_7630_ChoiceDesc1 = {
    Text = "[Ghì con quạ xuống] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", lây nhiễm \"(Skill.Arg2)\""
  },
  Event_7630_ChoiceDesc2 = {
    Text = "[Giết con quạ] nhận được 1 trong 3 khắcăng"
  },
  Event_7630_ChoiceDesc3 = {Text = "[đi]"},
  Event_7630_Desc = {
    Text = "Con quạ cô đơn kêu khàn giọng, tự nhổ từng sợi lông đen của mình. \nNó run rẩy vì đau đớn, hét lên, nhưng không thể ngừng lại hành động ngày càng nhanh của mình. \n \"cạc——cạc——\"\nTrong mắt nó chảy ra những giọt nước mắt xanh lẫn chất lỏng đen, ngoài bạn ra, không ai chứng kiến. \n"
  },
  Event_7630_Name = {
    Text = "Nước mắt dung nham"
  },
  Event_7631_ChoiceDesc1 = {
    Text = "[ rời đi] tăng Arg1 điểm máu tối đa"
  },
  Event_7631_Desc = {
    Text = "\"Giao cho tôi đi,\" bạn vuốt ve trên cột sống của quái vật, giống như đang xoa dịu một chú mèo nhỏ đang giận dữ,\"cô ấy chắc chắn sẽ tỉnh lại, chúng ta sẽ không làm tổn thương cô ấy.\""
  },
  Event_7631_Name = {
    Text = "Gọi của tình bạn"
  },
  Event_7632_ChoiceDesc1 = {
    Text = "[Khi rời đi] tăng Arg1 điểm máu tối đa, bị nhiễm \"(Skill.Arg2)\" và \"(Skill.Arg3)\""
  },
  Event_7632_Desc = {
    Text = "\"Dậy đi, Lily, Kume cũng mong bạn mau tỉnh lại ——\""
  },
  Event_7632_Name = {
    Text = "Gọi của tình bạn"
  },
  Event_7633_ChoiceDesc1 = {Text = "[đi]"},
  Event_7633_Desc = {
    Text = "Vật này đã hoàn toàn vô dụng."
  },
  Event_7633_Name = {
    Text = "Điện báo im lặng"
  },
  Event_79429_ChoiceDesc1 = {
    Text = "Chọn một người đánh thức, thông qua nghi thức sự sống chuyển hóa họ thành \"Bọ\". \"Bọ\" sẽ tiêu tốn -1 sức mạnh thẻ lệnh, nhưng tiêu tốn sau khi sử dụng."
  },
  Event_79429_Desc = {
    Text = "\"Trong quá trình nhận thức bản thân, luôn có sự đau đớn, và biến đổi cùng sinh nở cũng vậy.\"\nCô ấy mỉm cười dịu dàng, yêu thương vuốt ve gương mặt bạn.\n \"Đừng sợ hãi, tôi ở đây bên cạnh bạn, vì vậy hãy mở rộng linh hồn và tất cả mọi thứ, đón nhận họ.\"\n \"Đứa con ngoan, tôi đang chờ đợi sự sinh nở mới của bạn, chờ đợi bạn... trở thành một thành viên của chúng tôi.\""
  },
  Event_79429_Name = {
    Text = "Biến thân của sức sống"
  },
  Event_80463_ChoiceDesc1 = {
    Text = "[rời đi] nhận được 1 trong 3 bạc tạo vật, bị nhiễm [(Skill.Arg1)]"
  },
  Event_80463_Desc = {
    Text = "Bạn chọn con đường, kéo Tiểu William chạy nhanh như gió.\nMay thay, lựa chọn của bạn là đúng.\nNhững sự ô nhiễm tinh thần, những Clementine giống hệt nhau, cuối cùng đã bị bạn bỏ lại.\nTất nhiên, bạn đã trả giá một số điều."
  },
  Event_80463_Name = {
    Text = "「Những “Clemantine”」"
  },
  Event_80464_ChoiceDesc1 = {Text = "[đi]"},
  Event_80464_Desc = {
    Text = "Một ký ức vượt quá nhận thức được cấy vào não bạn, trực tiếp đánh bại lý trí của bạn. \n Trong những hình ảnh như đang tua nhanh, bạn chỉ nhớ một cảnh: ngôi đền hình tam giác \n đó là thành tựu vĩ đại mà @2Insectoid xây dựng vì sự ngu ngốc vĩ đại của @4."
  },
  Event_80464_Name = {
    Text = "Ký ức sâu sắc"
  },
  Event_80465_ChoiceDesc1 = {
    Text = "[Rời đi] Chọn 1 thân thể được đánh thức, bị nhiễm [(Skill.Arg1)]"
  },
  Event_80465_Desc = {
    Text = "Bạn chọn con đường, kéo Tiểu William chạy nhanh như gió.\nMay thay, lựa chọn của bạn là đúng.\nNhững sự ô nhiễm tinh thần, những Clementine giống hệt nhau, cuối cùng đã bị bạn bỏ lại.\nTất nhiên, bạn đã trả giá một số điều."
  },
  Event_80465_Name = {
    Text = "「Những “Clemantine”」"
  },
  Event_80466_ChoiceDesc1 = {Text = "[đi]"},
  Event_80466_Desc = {
    Text = "\"Cạch. Cạch. Cạch\"\n \"Công việc\" cuối cùng đã hoàn thành, nhưng ngoài \"công việc\" bản thân, bạn nhận được gì?"
  },
  Event_80466_Name = {
    Text = "Torture vô tận"
  },
  Event_80467_ChoiceDesc1 = {
    Text = "[rời đi] nhận được 1 trong 3 khắcăng"
  },
  Event_80467_Desc = {
    Text = "\"Rất vui khi nghe câu trả lời thật lòng của bạn.\"\n \"Mong chờ cuộc gặp gỡ tiếp theo của chúng ta.\""
  },
  Event_80467_Name = {
    Text = "Gọi trong giấc mơ"
  },
  Event_80468_ChoiceDesc1 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_80468_Desc = {
    Text = "\"Ôi, đúng là một đứa trẻ không trung thực.\"\n \"Nhưng không sao, lần sau, tôi sẽ để bạn nói ra sự thật từ đáy lòng mình.\"\n \"Tất cả, những điều thật tâm và linh hồn, sự thật.\""
  },
  Event_80468_Name = {
    Text = "Gọi trong giấc mơ"
  },
  Event_80469_ChoiceDesc1 = {
    Text = "[Bắt đầu「Công việc」]xóa 1 thẻ lệnh, nhận Ấn ký đen Arg1"
  },
  Event_80469_ChoiceDesc2 = {Text = "[Lùi xa]"},
  Event_80469_Desc = {
    Text = "\"Cạch.\"\nÂm thanh của máy đánh chữ vang lên, trước khi \"công việc\" hoàn thành, bạn sẽ mãi là nô lệ của nó."
  },
  Event_80469_Name = {
    Text = "Torture vô tận"
  },
  Event_80470_ChoiceDesc1 = {Text = "[đi]"},
  Event_80470_Desc = {
    Text = "\"Thật tiếc, sự cẩn trọng của bạn đã khiến bạn bỏ lỡ cơ hội duy nhất để biết sự thật.\"\nNó thở dài, âm thầm tan ra."
  },
  Event_80470_Name = {
    Text = "Ký ức sâu sắc"
  },
  Event_80471_ChoiceDesc1 = {
    Text = "[Tấn công hết sức]"
  },
  Event_80471_ChoiceDesc2 = {
    Text = "[Vừa chiến đấu vừa rút lui]"
  },
  Event_80471_Desc = {
    Text = "Hình bóng bất ngờ xuất hiện trước mặt bạn, đó là Clementine.\n \"Không cần ngạc nhiên, tôi chỉ muốn thực hiện một bài kiểm tra đặc biệt.\"\n \"Về việc kiểm tra gì, đó là bí mật.\" Clementine cười,\"Đối với bạn, nội dung duy nhất của bài kiểm tra——\"\n \"Là sống sót.\""
  },
  Event_80471_Name = {
    Text = "Thử nghiệm đặc biệt"
  },
  Event_80472_ChoiceDesc1 = {
    Text = "[Hồi tưởng quá khứ]"
  },
  Event_80472_ChoiceDesc2 = {
    Text = "[Rút bỏ vẩy côn trùng]"
  },
  Event_80472_Desc = {
    Text = "\"Xin bạn tin rằng, tôi không có ác ý, tôi chỉ muốn giúp bạn.\"\nClementine chạy theo bạn và hét lớn.\nGiọng nói của cô ấy nghe có vẻ chân thành vô cùng, nhưng bạn đã không còn có thể tin vào điều gì. \nĐạo đức của bạn đã bị\"Lý thuyết nhận thức thể xác\"đánh bại, lý trí cũng sắp sụp đổ. \nBạn phải, phải làm điều gì đó, chống lại lớp vảy côn trùng đang phát triển trong thịt, chống lại sự điên loạn và tuyệt vọng đang từng chút một thấm vào linh hồn."
  },
  Event_80472_Name = {
    Text = "Âm hồn đang đấu tranh"
  },
  Event_80473_ChoiceDesc1 = {
    Text = "[Rời đi] xóa 2 thẻ bài"
  },
  Event_80473_Desc = {
    Text = "\"Bạn có muốn giữ sức mạnh để ứng phó với trận chiến cuối cùng không?\"\n \"Là một lựa chọn thông minh. Nhưng con người khi có được cũng đồng nghĩa với việc đánh mất.\"\n \"Bởi vì trong thế giới tàn nhẫn đang bùng cháy này, việc sinh tồn bản thân, cũng phải trả giá.\""
  },
  Event_80473_Name = {
    Text = "Thử nghiệm đặc biệt"
  },
  Event_80474_ChoiceDesc1 = {
    Text = "[bỏ qua nó] nhận được chọn 1 trong 3 khắcăng"
  },
  Event_80474_ChoiceDesc2 = {
    Text = "[Chạm vào nó] 1 thẻ lệnh ngẫu nhiên nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_80474_Desc = {
    Text = "Một thứ kỳ lạ giống như bào tử đã thu hút sự chú ý của bạn.\nNó giống như một con sứa mỏng manh được tạo thành từ máu thịt, cũng giống như sợi thần kinh lưu trữ tín hiệu trong sâu thẳm của não.\n\"Hãy đến chạm vào tôi.\" Nó không tiếng động cám dỗ bạn, \"Tôi sẽ, cho bạn thấy một ký ức tàn nhẫn.\""
  },
  Event_80474_Name = {
    Text = "Ký ức sâu sắc"
  },
  Event_80475_ChoiceDesc1 = {
    Text = "[rời đi] nhận được 1 trong 3 khắcăng"
  },
  Event_80475_Desc = {
    Text = "\"Ramona, Búp bê, Lotan, Ogier...\"\nBạn lo âu lặp đi lặp lại những cái tên này.\nLý trí của bạn đã sụp đổ không còn nhớ rõ hình dạng của họ nữa, nhưng sự tồn tại mà những cái tên này đại diện vẫn có thể sưởi ấm trái tim và linh hồn của bạn.\nHọ đã từng tồn tại, họ đã từng cười, họ... là ranh giới và neo đậu giữ cho nhân tính của bạn trong khoảnh khắc này."
  },
  Event_80475_Name = {
    Text = "Âm hồn đang đấu tranh"
  },
  Event_80476_ChoiceDesc1 = {
    Text = "[rời đi] nhận được 3 chọn 1 vật phẩm bạc, nhiễm phải 「(Skill.Arg1)」"
  },
  Event_80476_Desc = {
    Text = "\"A a a a——\"\nBạn mở miệng, hô lớn, tiếng nói như chẳng phải là hét, mà như đang kêu gào.\nNhững vẩy côn trùng đã bị kéo ra lại mọc trở lại, và lý trí sụp đổ, không bao giờ trở lại."
  },
  Event_80476_Name = {
    Text = "Âm hồn đang đấu tranh"
  },
  Event_80477_ChoiceDesc1 = {
    Text = "[rời đi] nhận được sáng tạo \"(RelicConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_80477_Desc = {
    Text = "Bạn không giấu diếm gì, mà toàn tâm toàn ý. Tư thế này rõ ràng làm vui lòng Clementine.\n\"Thật là một đứa trẻ tốt.\" \n\"Vậy thì, tôi sẽ thưởng cho bạn một chút. Đương nhiên, điều này phải trả giá.\" \n\"Trong thế giới tàn khốc đang bùng cháy này, sự sống chính nó cần phải trả giá.\""
  },
  Event_80477_Name = {
    Text = "Thử nghiệm đặc biệt"
  },
  Event_80478_ChoiceDesc1 = {
    Text = "[Bắt đầu「Công việc」]xóa 1 thẻ lệnh, nhận Ấn ký đen Arg1"
  },
  Event_80478_ChoiceDesc2 = {Text = "[Lùi xa]"},
  Event_80478_Desc = {
    Text = "\"Cạch. Cạch.\"\nÂm thanh của máy đánh chữ vang lên, trong quá trình \"công việc\", bạn chỉ là công cụ để hoàn thành \"công việc\"."
  },
  Event_80478_Name = {
    Text = "Torture vô tận"
  },
  Event_80479_ChoiceDesc1 = {
    Text = "[Chạy về bên trái]"
  },
  Event_80479_ChoiceDesc2 = {
    Text = "[Chạy về bên phải]"
  },
  Event_80479_Desc = {
    Text = "Bóng dáng quen thuộc theo sát sau lưng bạn, không chỉ một hai, mà là hàng chục hàng trăm.\n Hành lang chật chội không thể chứa được nhiều \"Klémentin\" như vậy, cho nên, có \"Klémentin\" bị đẩy ngã xuống đất, có \"Klémentin\" bị giẫm nát.\n Nhưng họ đồng loạt gọi bạn, lặp lại câu nói khiến bạn rơi vào ô nhiễm tinh thần.\n \"Tại sao phải chạy trốn? Tôi chỉ muốn tư vấn tâm lý cho bạn thôi.\" \n Còn bạn, chạy điên cuồng trong hành lang của viện dưỡng lão, đối mặt với ngã rẽ của lựa chọn."
  },
  Event_80479_Name = {
    Text = "「Những “Clemantine”」"
  },
  Event_80480_ChoiceDesc1 = {
    Text = "[Bắt đầu「Công việc」]xóa 1 thẻ lệnh, nhận Ấn ký đen Arg1"
  },
  Event_80480_ChoiceDesc2 = {Text = "[Lùi xa]"},
  Event_80480_Desc = {
    Text = "\"Chỉnh sửa! Công việc! Đừng dừng lại！\"\nVô số tiếng gầm vang vọng bên tai bạn, khiến bạn không thể không tiến lại gần chiếc máy đánh chữ bất ngờ xuất hiện.\n \"Phải làm sao, phải làm sao, rõ ràng làm từ sáng đến tối, nhưng công việc thì mãi không xong.\"\n \"Chỉnh sửa! Chỉnh sửa! Chỉnh sửa kế hoạch, đề xuất yêu cầu, hoàn thành công việc!\"\n \"Công việc! Công việc!! Công việc!!!\"\nLinh hồn vang vọng va chạm vào chiếc máy đánh chữ không ngừng gõ, cuối cùng, chiếc máy đánh chữ đã ngừng lại.\nTuy nhiên, một khoảnh khắc sau, chiếc máy đánh chữ lại tiếp tục vận hành\n \"Chỉnh sửa! Công việc! Đừng dừng lại！\"\nVì công việc, không có hồi kết."
  },
  Event_80480_Name = {
    Text = "Torture vô tận"
  },
  Event_80481_ChoiceDesc1 = {
    Text = "[Trả lời trung thực]"
  },
  Event_80481_ChoiceDesc2 = {
    Text = "[Từ chối trả lời]"
  },
  Event_80481_Desc = {
    Text = "Trong nháy mắt, cảnh trước mặt trở nên mờ mịt và ảo ảnh.\nBạn nghĩ rằng căn phòng đang xoắn chuyển, nhưng sau đó, bạn mới hiểu ra rằng đó là thần kinh mắt của bạn đã bị xâm nhập.\n\"Chúng ta lại gặp nhau rồi.\"\nTrong tầm nhìn mờ nhạt, Clementine cười dịu dàng.\n\"Dù gặp sớm hơn tưởng tượng, nhưng tôi vẫn rất vui. Không biết là %player% bạn có cảm giác như vậy không?\""
  },
  Event_80481_Name = {
    Text = "Gọi trong giấc mơ"
  },
  Event_80595_ChoiceDesc1 = {Text = "[đi]"},
  Event_80595_Desc = {
    Text = "\nTrước sự đuổi đi của bạn, bướm không chút động lòng.\nNó kiên trì theo đuổi bàn tay của bạn, trong lòng bàn tay của bạn mất đi sự sống.\n \"Ah, thật ấm áp...\"\nĐó là tiếng lòng cuối cùng của nó."
  },
  Event_80595_Name = {
    Text = "Giấc mơ của bướm"
  },
  Event_80596_ChoiceDesc1 = {Text = "[đi]"},
  Event_80596_Desc = {
    Text = "\"Tôi muốn hoa luôn nở rộ, tôi muốn nụ cười trường tồn mãi mãi.\"\n \"Tôi muốn tất cả những người mắc phải dung thực đều có thể bình phục an toàn, tôi muốn thế giới này trở lại như xưa, không còn cháy nữa.\"\n \"Tôi muốn...\"\nCon bướm nhỏ nhẹ nhàng vỗ cánh, trong lòng bàn tay bạn mất đi sự sống.\nÍt nhất, có người đã lắng nghe tiếng nói của nó."
  },
  Event_80596_Name = {
    Text = "Giấc mơ của bướm"
  },
  Event_80597_ChoiceDesc1 = {
    Text = "[Xua đuổi bướm] 1 thẻ lệnh ngẫu nhiên nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_80597_ChoiceDesc2 = {
    Text = "[Lắng nghe ước nguyện]chọn 1 trong 3 thẻ lệnh nhận Lời cầu nguyện:「(EnchantConfig.Arg1)」"
  },
  Event_80597_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_80597_Desc = {
    Text = "Những con bướm nhỏ, cũng có nhiều giấc mơ.\nNhững giấc mơ này rải rác trong biển hoa, trong phòng bệnh, và cả trong những @2bàn thờ đầy thịt máu.\nGiờ đây, nó cuối cùng đã chờ đợi được người kết nối, không biết bạn có sẵn lòng lắng nghe những tâm nguyện nhỏ bé của nó không."
  },
  Event_80597_Name = {
    Text = "Giấc mơ của bướm"
  },
  Event_80610_ChoiceDesc1 = {Text = "[đi]"},
  Event_80610_Desc = {
    Text = "\"Lý trí sao? Một câu trả lời thú vị.\"\n \"Hy vọng bạn sẽ không hối hận về lựa chọn của mình.\""
  },
  Event_80610_Name = {
    Text = "Giá của nhân loại"
  },
  Event_80612_ChoiceDesc1 = {
    Text = "[Cho ăn họ]nhận di vật bạc「(RelicConfig.Arg1)」，chọn nhiễm 1 lần triệu chứng"
  },
  Event_80612_ChoiceDesc2 = {
    Text = "[Không để ý]Chọn 1 trong 3 thẻ lệnh để nhận lời cầu nguyện:「(EnchantConfig.Arg1)」, lây nhiễm「(Skill.Arg2)」"
  },
  Event_80612_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_80612_Desc = {
    Text = "Những cư dân ra vào, nhưng bầy chuột thì vẫn dài lâu.\nSo với con người, chúng mới thực sự là \"nguyên cư\" của lâu đài này.\nNhưng chúng không có ý kiến gì về sự xuất hiện của con người.\nBởi vì những thứ mềm mại, trắng trẻo, xấu xí đó sẽ cho nó những thứ cũng mềm mại, trắng trẻo, xấu xí như vậy.\n\"Và bạn, thứ xấu xí, thuộc về loại nào?\""
  },
  Event_80612_Name = {
    Text = "Bí mật của lâu đài cổ"
  },
  Event_80613_ChoiceDesc1 = {Text = "[đi]"},
  Event_80613_Desc = {
    Text = "\nÂm thanh cười nhẹ nhàng vang lên trong bóng tối.\n \"Tôi đang chờ bạn, đến gặp tôi.\"\n \"Con sâu can đảm.\""
  },
  Event_80613_Name = {
    Text = "「Sự nhìn trộm của “cô ấy”」"
  },
  Event_80614_ChoiceDesc1 = {Text = "[đi]"},
  Event_80614_Desc = {
    Text = "\"Câm miệng đi, nghe thật tệ.\"\nMèo đen nhắm chặt tai lại một cách nhân cách hóa.\n \"Con người, ngôn ngữ mèo của bạn thật sự rất tệ, nói những điều không đầu không đuôi!\"\nMặc dù nói như vậy, nhưng sắc mặt của mèo đen lại trở nên bình tĩnh.\n \"Bên cạnh việc gọi meo meo để vui vẻ tôi, tôi sẽ tặng bạn một món quà.\"\n \"Về phần nội dung của món quà, phụ thuộc vào vận may của bạn.\""
  },
  Event_80614_Name = {Text = "Nigel Mann"},
  Event_80615_ChoiceDesc1 = {Text = "[đi]"},
  Event_80615_Desc = {
    Text = "\n \"Mẹ, sau khi mất đi bạn bè, chồng, con trai, tôi lại mãi mãi mất đi Diana, cô con gái bé bỏng của tôi.\"\n \"Khi cô ấy trở thành tro bụi trước mặt tôi, đầu óc tôi hoàn toàn trống rỗng...\" Những chữ tiếp theo đã không thể nhìn rõ.\nBạn chỉ có thể chuyển sang đọc dòng chữ tiếp theo.\nTôi đã quyết định. Nếu gặp lại tôi, xin đừng trách mắng tôi, tôi chỉ... rất nhớ các bạn."
  },
  Event_80615_Name = {
    Text = "Nỗi Nhớ Khuất Mất"
  },
  Event_80616_ChoiceDesc1 = {Text = "[đi]"},
  Event_80616_Desc = {
    Text = "Sự xua đuổi của bạn đã có hiệu quả. Một số thân thể không thấy rõ hình dạng đang vặn vẹo trốn thoát, phần lớn vẫn ở lại.\nHọ không còn cười đùa, không còn ngân nga, mà lại khóc nức nở.\nTiếng khóc trẻ con vang lên bên tai bạn, chỉ lặp đi lặp lại một câu.\n\"Đánh chết quái vật!\""
  },
  Event_80616_Name = {
    Text = "「Thời thơ ấu của “anh ấy”」"
  },
  Event_80617_ChoiceDesc1 = {
    Text = "[đi khỏi] nhiễm [(Skill.Arg1)]"
  },
  Event_80617_ChoiceDesc2 = {
    Text = "[đi khỏi] nhiễm [(Skill.Arg1)]"
  },
  Event_80617_ChoiceDesc3 = {
    Text = "[đi khỏi] nhiễm [(Skill.Arg1)]"
  },
  Event_80617_Desc = {
    Text = "Việc bạn cho ăn đã làm hài lòng bầy chuột.\nĐám chuột khổng lồ chồm lên, tặng bạn một món quà được bao bọc thô sơ.\nBạn không thể nhìn thấy hình dạng của món quà, chỉ thấy rất nhiều máu ngấm vào bao bì."
  },
  Event_80617_Name = {
    Text = "Bí mật của lâu đài cổ"
  },
  Event_80618_ChoiceDesc1 = {Text = "[đi]"},
  Event_80618_Desc = {
    Text = "\"...\"\n \"...\"\n \"......\"\nBóng tối im lặng, anh ta muốn khóc, nhưng đã mất khả năng rơi nước mắt.\nCuối cùng, chỉ còn thở dài thật sâu.\n \"Bạn bè, hy vọng bạn có thể bảo vệ những điều quý giá nhất của mình.\""
  },
  Event_80618_Name = {
    Text = "Người rỗng"
  },
  Event_80619_ChoiceDesc1 = {Text = "[đi]"},
  Event_80619_Desc = {
    Text = "Lời quát mắng của bạn hoàn toàn vô tác dụng, ngược lại còn khiến họ càng thêm cuồng nhiệt vui sướng. \n Tiếng cười nói và ngân nga càng lúc càng cao, hát một bài đồng dao khác \n \"William nhỏ, ở lâu đài cổ, chuột ăn người, chạy trong tường. \n Khi đến lúc hiến tế, mọi người đều bị gặm nát.\""
  },
  Event_80619_Name = {
    Text = "「Thời thơ ấu của “anh ấy”」"
  },
  Event_80620_ChoiceDesc1 = {
    Text = "[tránh ánh mắt] ngẫu nhiên thức tỉnh 1 thân thể được đánh thức"
  },
  Event_80620_ChoiceDesc2 = {
    Text = "[Trực diện ánh mắt] Chọn 1 thân thể được đánh thức và giảm 2 điểm tiêu thụ sức tính toán của thẻ thức tỉnh. Nhiễm [(Skill.Arg1)]"
  },
  Event_80620_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 50 dấu đen"
  },
  Event_80620_Desc = {
    Text = "Mọi thứ trong viện dưỡng lão đều nằm dưới sự kiểm soát và quan sát của cô ấy. Tất nhiên, bạn cũng vậy.\nNhưng cô ấy sẵn sàng mở một mắt và nhắm một mắt cho bạn.\nDù gì, trò chơi phải có qua lại thì mới thú vị."
  },
  Event_80620_Name = {
    Text = "「Sự nhìn trộm của “cô ấy”」"
  },
  Event_80621_ChoiceDesc1 = {Text = "[đi]"},
  Event_80621_Desc = {
    Text = "Bạn đặt phong bì trở lại vị trí cũ, chuẩn bị rời đi, thì bỗng nghe thấy tiếng thầm thì mờ ảo.\n\"Theo yêu cầu của tôi, cuối cùng Bác sĩ Clementine cũng đã đồng ý.\nVũ trụ rộng lớn mà cô mô tả, chắc chắn có cách để cứu sống các bạn.\nTôi đã sẵn sàng cho \"sinh nở\" mới, dù phải trôi dạt bao nhiêu năm ánh sáng, tôi vẫn khao khát gặp lại các bạn.\""
  },
  Event_80621_Name = {
    Text = "Nỗi Nhớ Khuất Mất"
  },
  Event_80622_ChoiceDesc1 = {Text = "[đi]"},
  Event_80622_Desc = {
    Text = "Bác sĩ Clementine đã cứu tôi. \n Cô ấy thực sự là một người rất, rất tốt, sẵn lòng lắng nghe tiếng nói của tôi. \n Tôi thật sự muốn nói về những điều vui vẻ, hạnh phúc, nhưng lúc này đây, ngoài nỗi đau và tuyệt vọng, tôi không còn gì khác. \n E rằng, tôi sẽ phụ lòng mong mỏi của bác sĩ. \n Sau khi mất đi các bạn, cuộc sống đối với tôi chỉ còn lại sự hoang vu."
  },
  Event_80622_Name = {
    Text = "Nỗi Nhớ Khuất Mất"
  },
  Event_80623_ChoiceDesc1 = {Text = "[đi]"},
  Event_80623_Desc = {
    Text = "\"Bạn, bạn...\"\n \"Hứ, kỹ thuật cũng không tệ nhỉ, lần này thì coi như bạn qua được. Lần sau sẽ không dễ dàng như vậy đâu！\"\nMèo đen nhảy lên, chạy đi một cách khéo léo."
  },
  Event_80623_Name = {Text = "Nigel Mann"},
  Event_80624_ChoiceDesc1 = {
    Text = "[Tấn công mèo đen]50% xác suất nhận 125 Ấn ký đen, 50% xác suất nhiễm「(Skill.Arg2)」"
  },
  Event_80624_ChoiceDesc2 = {
    Text = "[Học tiếng mèo]75% xác suất nhận 100 Ấn ký đen, 25% xác suất nhiễm「(Skill.Arg2)」"
  },
  Event_80624_ChoiceDesc3 = {
    Text = "[Thử vuốt mèo]nhận 50 Ấn ký đen"
  },
  Event_80624_Desc = {
    Text = "\"Này! Bạn, cấm tiến lên.\"\nMèo đen đột ngột nhảy ra, ngăn cản bạn tiếp tục đi tới.\nChúng liếm móng vuốt một cách thanh lịch, dáng vẻ kiêu hãnh và tự phụ.\n \"Phía trước đầy rẫy nguy hiểm, không phải loại con người yếu ớt như bạn có thể khám phá.\"\nBạn bày tỏ quyết tâm phải tiến lên, lúc này, đôi mắt dọc của mèo đen dẫn đầu chuyển động, hiện lên bản chất tàn nhẫn của việc chơi đùa với con mồi.\"Vậy hãy cho chúng tôi thấy quyết tâm của bạn đi.\""
  },
  Event_80624_Name = {Text = "Nigel Mann"},
  Event_80625_ChoiceDesc1 = {Text = "[đi]"},
  Event_80625_Desc = {
    Text = "\nSự phớt lờ của bạn đã chọc giận bầy chuột, chúng kêu la ào ào lao về phía bạn, nhưng bạn, từ trước khi bầy chuột xông tới, đã chạy xa rồi."
  },
  Event_80625_Name = {
    Text = "Bí mật của lâu đài cổ"
  },
  Event_80626_ChoiceDesc1 = {Text = "[đi]"},
  Event_80626_Desc = {
    Text = "\"A, đúng vậy, hãy gãy cánh của tôi.\"\n \"Thời gian, sức khỏe, phẩm giá, cuộc sống, chúng đã cướp đi quá nhiều từ tôi.\"\n \"Giấc mơ cuối cùng này, dĩ nhiên cũng không thuộc về tôi.\"\n \"Bởi vì, tôi chỉ là một con chim bị nhốt, mất đi tự do.\""
  },
  Event_80626_Name = {
    Text = "Người rỗng"
  },
  Event_80627_ChoiceDesc1 = {Text = "[đi]"},
  Event_80627_Desc = {
    Text = "\"Cảm tính nhỉ? Một câu trả lời thú vị.\"\n \"Hy vọng bạn sẽ không hối tiếc về lựa chọn của mình.\""
  },
  Event_80627_Name = {
    Text = "Giá của nhân loại"
  },
  Event_80628_ChoiceDesc1 = {Text = "[đi]"},
  Event_80628_Desc = {
    Text = "\"Tôi chấp nhận lời cầu nguyện của bạn.\"\nÂm thanh gầm gừ gần lại, chậm rãi chui vào não bạn qua ống tai.\nNão bạn đang run rẩy, và trong cơn run rẩy này, bạn đã nghe thấy \"tiếng nói\" của vũ trụ.\n \"Kết nối với tôi.\""
  },
  Event_80628_Name = {
    Text = "Cứu chuộc Tối"
  },
  Event_80629_ChoiceDesc1 = {
    Text = "[Cầu nguyện]ngẫu nhiên đánh thức 1 người đánh thức，nhiễm「(Skill.Arg1)」"
  },
  Event_80629_ChoiceDesc2 = {
    Text = "[Từ chối]nhận 3 chọn 1 Lời cầu nguyện"
  },
  Event_80629_Desc = {
    Text = "\"Không thể như thế, không thể như thế.\"\n \"Rõ ràng, rõ ràng tôi nên thoát khỏi cuộc sống cấp thấp của con người, tiến hóa thành một cái gì đó cao cấp hơn...\"\nTrong bóng tối, tiếng khóc đau khổ vang lên.\nNhững tiếng khóc này tụ lại, dâng trào, hình thành nên tiếng gầm lớn.\n \"Thế giới đang cháy này, như một cái hố đen không bao giờ no đủ, nuốt chửng mọi người, vì vậy——\"\n \"Hãy cầu nguyện cho tôi, vũ trụ vô tận sẽ dành cho bạn sự cứu rỗi.\""
  },
  Event_80629_Name = {
    Text = "Cứu chuộc Tối"
  },
  Event_80630_ChoiceDesc1 = {
    Text = "[Mở phong bì]nhận di vật vàng「(RelicConfig.Arg1)」，nhiễm「(Skill.Arg2)」"
  },
  Event_80630_ChoiceDesc2 = {
    Text = "[Đọc] Chọn 1 thẻ lệnh từ 3 thẻ để nhận khắc ấn: [(EnchantConfig.Arg1)]"
  },
  Event_80630_ChoiceDesc3 = {
    Text = "[Đặt lại chỗ cũ]nhận 50 Ấn ký đen"
  },
  Event_80630_Desc = {
    Text = "Trong góc khuất không ai để ý, có một lá thư bị bỏ lại.\nNhiều chữ viết trên lá thư đã không còn rõ ràng, nhưng chỉ còn một từ. Chuyển động mạnh mẽ qua giấy.\nTừ đó là \"mẹ\"."
  },
  Event_80630_Name = {
    Text = "Nỗi Nhớ Khuất Mất"
  },
  Event_80631_ChoiceDesc1 = {Text = "[đi]"},
  Event_80631_Desc = {
    Text = "\"Hả, con người nhỏ bé, bạn đã đưa ra lựa chọn sai lầm.\"\nMèo đen lạnh lùng nhìn bạn, đột ngột tấn công.\n \"Bạn phải trả giá——dĩ nhiên, chúng tôi cũng tôn trọng những kẻ mạnh.\""
  },
  Event_80631_Name = {Text = "Nigel Mann"},
  Event_80632_ChoiceDesc1 = {Text = "[đi]"},
  Event_80632_Desc = {
    Text = "\nÂm thanh cười nhẹ nhàng vang lên trong bóng tối.\n \"Tôi đang chờ bạn, đến gặp tôi.\"\n \"Con sâu đáng yêu.\""
  },
  Event_80632_Name = {
    Text = "「Sự nhìn trộm của “cô ấy”」"
  },
  Event_80633_ChoiceDesc1 = {Text = "[đi]"},
  Event_80633_Desc = {
    Text = "Dưới sự tấn công của bạn, những hình ảnh xoắn vặn kỳ dị cuối cùng cũng đã trốn thoát。\nXung quanh yên tĩnh, chỉ còn nhịp đập của trái tim bạn đang khóc không thành tiếng。\nThì ra, đây chính là thời thơ ấu của 'ngài'."
  },
  Event_80633_Name = {
    Text = "「Thời thơ ấu của “anh ấy”」"
  },
  Event_80635_ChoiceDesc1 = {Text = "[đi]"},
  Event_80635_Desc = {
    Text = "\"A, chiếc bẫy chữ nhỏ đã bị nhìn thấu.\"\n \"Đây là phần thưởng. Bởi vì...\"\n \"Không phải lựa chọn nào cũng phải chọn.\""
  },
  Event_80635_Name = {
    Text = "Giá của nhân loại"
  },
  Event_80636_ChoiceDesc1 = {Text = "[đi]"},
  Event_80636_Desc = {
    Text = "\"@3Kẻ bội phản\"\nTiếng vo ve dần yếu đi, cho đến khi biến mất. Chỉ còn lời cuối cùng.\n \"Giữ nhân tính, nhưng không thể sống sót trong thế giới tàn khốc này.\""
  },
  Event_80636_Name = {
    Text = "Cứu chuộc Tối"
  },
  Event_80637_ChoiceDesc1 = {
    Text = "[Chọn từ chối]xóa 1 thẻ lệnh，nhận Ấn ký đen Arg1"
  },
  Event_80637_ChoiceDesc2 = {
    Text = "[Chọn tuân theo]sao chép 1 thẻ lệnh，nhiễm「(Skill.Arg1)」"
  },
  Event_80637_ChoiceDesc3 = {
    Text = "[Chọn ôm]chọn 1 trong 3 thẻ lệnh nhận Lời cầu nguyện:「(EnchantConfig.Arg1)」"
  },
  Event_80637_Desc = {
    Text = "\"Tôi là một con chim trong lồng, bị giam trong một cái sân đầy những căn phòng.\"\nBóng dáng mờ nhạt lang thang trong bóng tối, đó là sự níu kéo từ những người đã khuất.\n \"Họ nói, đó là bệnh viện tâm thần, nhưng tôi biết, đó là một cái lồng đặc biệt của con người, giam giữ những con chim tự do không chịu tuân theo quy tắc xã hội.\"\n \"Nhưng nếu chim không thể bay, thì có thể gọi nó là chim không?\"\nNhững nỗi ám ảnh kéo đến gần bạn, cầu xin sự cứu rỗi.\n \"Xin hãy gãy cánh tôi, tôi đã chán ngấy việc bay.\""
  },
  Event_80637_Name = {
    Text = "Người rỗng"
  },
  Event_80638_ChoiceDesc1 = {Text = "[đi]"},
  Event_80638_Desc = {
    Text = "\"...\"\n \"...\"\n \"......\"\nBóng tối đột ngột rung lên, tan biến vào cơ thể bạn.\n \"Bạn bè, hãy tiến lên, để bảo vệ những điều quý giá nhất của mình.\"\n \"Dù chúng ta đã qua đời, nhưng vẫn sẵn lòng vì bạn mơ ước, gửi tặng lời chúc cuối cùng.\""
  },
  Event_80638_Name = {
    Text = "Người rỗng"
  },
  Event_80639_ChoiceDesc1 = {
    Text = "[Chọn cảm tính]khôi phục Arg1 điểm cuộc sống"
  },
  Event_80639_ChoiceDesc2 = {
    Text = "[Duy trì lý trí]ngẫu nhiên 1 thẻ lệnh nhận Lời cầu nguyện:「(EnchantConfig.Arg1)」"
  },
  Event_80639_ChoiceDesc3 = {
    Text = "[Từ chối lựa chọn]nhận 25 Ấn ký đen"
  },
  Event_80639_Desc = {
    Text = "\"Hãy chọn, hãy chọn.\"\nTrong bóng tối đang điên cuồng, vang lên vô số tiếng thì thầm.\nGiọng nói này mềm mại ru ngủ, dường như mang theo vô hạn ma lực, khiến bạn cảm thấy một loại ảo giác điên cuồng nào đó.\nNão của bạn rơi vào trạng thái điên đảo, rời khỏi cơ thể, trong khi trái tim dường như đã hình thành ra một loại ý thức, gọi bạn kêu gào.\n \"Hãy chọn, hãy chọn.\"\n \"Duy trì lý trí hay cảm tính, bạn phải đưa ra sự lựa chọn.\""
  },
  Event_80639_Name = {
    Text = "Giá của nhân loại"
  },
  Event_80641_ChoiceDesc1 = {
    Text = "[La mắng「Họ」]làm nhiễm「(Skill.Arg1)」，nhận di vật bị nguyền rủa「(RelicConfig.Arg2)」"
  },
  Event_80641_ChoiceDesc2 = {
    Text = "\"Đuổi họ\" nhiễm hai lần \"(Skill.Arg1)\"，nhận di vật bạc \"(RelicConfig.Arg2)\" và\"(RelicConfig.Arg3)\""
  },
  Event_80641_ChoiceDesc3 = {
    Text = "[Tấn công「Họ」]nhận di vật bạc「(RelicConfig.Arg1)」"
  },
  Event_80641_Desc = {
    Text = "\"William nhỏ, là quái thai, ngủ trong mộ, không ai yêu. Đừng có giao lưu với hắn, cẩn thận bị hắn âm thầm hại.\"\nHình dáng không rõ ràng xoắn lại, nhưng âm thanh lại như tiếng trẻ con.\nHọ cười nói, ngâm nga, với ánh mắt khinh miệt và nhiệt tình nhìn bạn.\nMang theo ác ý."
  },
  Event_80641_Name = {
    Text = "「Thời thơ ấu của “anh ấy”」"
  },
  Event_90571_ChoiceDesc1 = {
    Text = "[Thưởng thức nó]Đặt 1 thẻ「Tối đặc biệt Hiến tế」vào bộ bài."
  },
  Event_90571_Desc = {
    Text = "Bàn tiệc lộng lẫy, sàn nhảy nhộn nhịp, dụng cụ ăn uống tinh xảo, thi thể nồng nàn…\nÔi, tôi biết bạn đã nóng lòng lắm rồi, nhưng hãy chờ thêm một chút, vị khách yêu quý. \nLy đồ uống được chủ tiệc pha chế đặc biệt này là món quà chỉ dành riêng cho những vị khách quý. \nHãy cầm lấy nó. Nhấp môi thưởng thức. Trong dư vị của nó, hãy tận hưởng trọn vẹn niềm vui này!"
  },
  Event_90571_Name = {
    Text = "Lễ nghi trước tiệc"
  },
  Event_91460_ChoiceDesc1 = {Text = "[đi]"},
  Event_91460_Desc = {
    Text = "Bạn không thể kháng cự, chỉ có thể để cho âm thanh thấm vào. \nTiếng kêu chói tai xé rách bộ não của bạn, một số nỗi sợ đã bị lãng quên lại trào ra, bạn cảm nhận được cơn đói của nó. \nNhững sinh vật ăn thịt đáng sợ……"
  },
  Event_91460_Name = {
    Text = "Lời thú tội thầm lặng"
  },
  Event_91461_ChoiceDesc1 = {Text = "[đi]"},
  Event_91461_Desc = {
    Text = "Bạn không còn kiềm chế nữa, để cho sự nóng bỏng đó phát ra hoàn toàn, tất cả những lời chưa nói bùng nổ từ đầu óc bạn.\nBạn cảm thấy một cảm hứng kỳ diệu, say sưa trong tài năng của Pikman."
  },
  Event_91461_Name = {
    Text = "Núi lửa ngủ"
  },
  Event_91462_ChoiceDesc1 = {Text = "[đi]"},
  Event_91462_Desc = {
    Text = "Lưỡi lửa quấn quanh vết mực, để lại một mảng máu me. \n Vào khoảnh khắc đó, bạn rơi xuống ranh giới giữa giấc mơ và thực tại. Bạn thấy mình biến thành một cô gái nhỏ, nắm tay Doresain và cùng nhau múa. \n Khi bạn tỉnh dậy và nhìn về phía Doresain lần nữa, nỗi buồn nặng nề tràn ngập tâm trí bạn."
  },
  Event_91462_Name = {
    Text = "Khải thị của giấc mơ"
  },
  Event_91463_ChoiceDesc1 = {Text = "[đi]"},
  Event_91463_Desc = {
    Text = "Bạn lao lên, ngọn lửa ẩn mình trong làn da của bạn. Còn về bức tranh đó, bất kỳ ai nhìn cũng chỉ là một bức chân dung bình thường. \nTrong những giấc mơ sau đó, bạn luôn thấy chính mình đang cháy, bị thiêu đốt vừa đủ, rồi vào một ngày nào đó sẽ được dọn lên bàn ăn của chính bạn."
  },
  Event_91463_Name = {
    Text = "Chân dung bốc cháy"
  },
  Event_91464_ChoiceDesc1 = {
    Text = "[Lắng nghe] nhận được 30 ấn ký đen, nhiễm「(Skill.Arg2)」，tiếp tục chọn"
  },
  Event_91464_ChoiceDesc2 = {
    Text = "[bỏ qua] rời đi"
  },
  Event_91464_Desc = {
    Text = "Trong sự ồn ào không lời, bạn dần dần hiểu được ngôn ngữ của những con quạ..."
  },
  Event_91464_Name = {
    Text = "Lời thú tội thầm lặng"
  },
  Event_91465_ChoiceDesc1 = {Text = "[đi]"},
  Event_91465_Desc = {
    Text = "Bạn nhặt một viên đá, làm cho những bóng chuột đang chăm chú gặm gốc cây giật mình. \nChúng tham lam nhìn bạn. \nBạn ngửi thấy mùi ẩm ướt và dơ bẩn từ chúng, như là một dấu hiệu nào đó."
  },
  Event_91465_Name = {
    Text = "Vương quốc Lưu đày"
  },
  Event_91466_ChoiceDesc1 = {
    Text = "[Lắng nghe] nhận được 25 ấn ký đen, nhiễm「(Skill.Arg2)」，tiếp tục chọn"
  },
  Event_91466_ChoiceDesc2 = {
    Text = "[bỏ qua] rời đi"
  },
  Event_91466_Desc = {
    Text = "Nó đang chào đón. Chào đón ai? \nTất nhiên là bạn! \nCó thể nó xem bạn là bữa tiệc ngon miệng của ngày mai."
  },
  Event_91466_Name = {
    Text = "Lời thú tội thầm lặng"
  },
  Event_91467_ChoiceDesc1 = {
    Text = "[Rạch lòng bàn tay] Chọn 1 trong 3 thẻ lệnh nhận được Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_91467_ChoiceDesc2 = {
    Text = "[Chấp nhận sự phát triển] nhận được tàn tích bạc「(RelicConfig.Arg1)」，nhiễm「(Skill.Arg2)」"
  },
  Event_91467_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_91467_Desc = {
    Text = "Con bướm không phải bay đến, mà là từ lòng bàn tay bạn từ từ sinh trưởng. \n Bạn ban đầu tưởng chỉ là mồ hôi, nhưng lại thấy chất lỏng màu đen như máu chảy ngược một cách lặng lẽ từ các kẽ tay, đông đặc thành những đôi cánh lạnh lẽo và đang đập. \n Mỗi lần vỗ cánh, đều làm dậy lên những gợn sóng trong dòng máu của bạn."
  },
  Event_91467_Name = {
    Text = "Ký sinh thượng lưu"
  },
  Event_91468_ChoiceDesc1 = {
    Text = "[Giải cứu chân dung] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_91468_ChoiceDesc2 = {
    Text = "[Chấp nhận khoảng trống] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: \"(EnchantConfig.Arg1)\", nhiễm \"(Skill.Arg2)\""
  },
  Event_91468_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 25 dấu đen"
  },
  Event_91468_Desc = {
    Text = "Bạn đứng trước món quà của Pickman.\nĐó là một bức chân dung, vẽ lên bằng máu, ngọn lửa đen thầm lặng cháy.\nQua hốc mắt trống rỗng của người trong bức tranh, bạn thấy —\nký ức của bạn đang cuộn trào cháy rực, kéo dài, bóp méo, phát sáng, dường như một loại lửa vô hình đang liếm láp vào hành lang trong não bạn. Trong một khoảnh khắc mơ hồ, bạn nghe thấy một giọng nói.\n \"Đã đến lúc bỏ vào nồi, thời điểm này thật đúng.\"\nĐó chính là cảnh tưởng ký ức mà bạn đã vẽ ra, bạn đang vật lộn và biến hình trong ngọn lửa."
  },
  Event_91468_Name = {
    Text = "Chân dung bốc cháy"
  },
  Event_91469_ChoiceDesc1 = {Text = "[đi]"},
  Event_91469_Desc = {
    Text = "Bạn từ chối nghe máy, lặng lẽ nhìn nó rung lắc cho đến khi dừng lại. \nTrong nhiều năm qua, bạn đã học được cách chống lại điên loạn."
  },
  Event_91469_Name = {
    Text = "Cuộc gọi nhỡ"
  },
  Event_91470_ChoiceDesc1 = {Text = "[đi]"},
  Event_91470_Desc = {
    Text = "Bạn lùi lại một bước, để cho bức tranh cháy trong ngọn lửa. \n Bạn thấy mình bị lửa nướng thành màu vàng hấp dẫn, mỡ chảy ra phát ra tiếng nổ lách tách, như thể có thể ngửi thấy mùi thịt qua bức tranh. \n Có phải Doresain đang cảm nhận được sự cám dỗ này không?"
  },
  Event_91470_Name = {
    Text = "Chân dung bốc cháy"
  },
  Event_91471_ChoiceDesc1 = {Text = "[đi]"},
  Event_91471_Desc = {
    Text = "Với một sự tò mò gần như xâm phạm, hoặc là can đảm tuyệt vọng để chống lại cái không biết, bạn tìm kiếm khải thị trong những bóng ma của quá khứ. \n Bạn thấy một cô gái múa cùng người đàn ông cao lớn bên cạnh với khuôn mặt mờ ảo, niềm vui bất ngờ tràn ngập trong trái tim bạn."
  },
  Event_91471_Name = {
    Text = "Bóng của quá khứ"
  },
  Event_91472_ChoiceDesc1 = {
    Text = "[Ngừng ghi chép] xóa 2 thẻ"
  },
  Event_91472_ChoiceDesc2 = {
    Text = "[Tiếp tục viết] nhận được di vật bị nguyền rủa「(RelicConfig.Arg1)」，nhiễm「(Skill.Arg2)」"
  },
  Event_91472_ChoiceDesc3 = {
    Text = "[Rời đi] Nhận được Arg1 dấu đen"
  },
  Event_91472_Desc = {
    Text = "Bạn cuối cùng đã tạm thoát khỏi chợ xác sống, tìm được một góc yên tĩnh như thường lệ để bắt đầu ghi chép. \n Máy đánh chữ đột nhiên rung lên điên cuồng, các phím tự động nhấn xuống, chất dịch đen nhầy từ các khe hở phun ra, làm ướt đi sự tỉnh táo nơi đầu ngón tay bạn. \n Bạn thấy hình bóng của những con bướm từ từ xuất hiện trên giấy…"
  },
  Event_91472_Name = {
    Text = "Bóng bướm trùng trùng"
  },
  Event_91473_ChoiceDesc1 = {Text = "[đi]"},
  Event_91473_Desc = {
    Text = "Điều kỳ lạ là, mặc dù đó là ngôn ngữ chưa học, nhưng bạn dường như hiểu được ý nghĩa của nó.\nBài thơ đầy nỗi nhớ nhung về người thân, nỗi nhớ này vượt qua sự sống và cái chết, được truyền đạt trong giấc mơ của bạn.\nBạn mơ hồ nhận ra các ký tự ở cuối bài thơ——\nđó là \"Selene\"."
  },
  Event_91473_Name = {
    Text = "Khải thị của giấc mơ"
  },
  Event_91474_ChoiceDesc1 = {Text = "[đi]"},
  Event_91474_Desc = {
    Text = "Bạn đau đớn cắt mở da tay, dùng lửa thiêu đốt mảng thịt mới sinh. \n Dịch đen bốc hơi, bướm vỡ vụn. \n Mọi thứ trở nên sạch sẽ không vết tích, nhưng bạn luôn cảm thấy trong lòng bàn tay có tiếng vỗ cánh yếu ớt, như một ý nghĩ chưa hoàn toàn phôi hóa, vẫn đang từ trong mạch máu của bạn thở ra nhẹ nhàng. \n Doresain không bình luận gì về điều này, chỉ muốn lấy đi máu mà bạn để lại."
  },
  Event_91474_Name = {
    Text = "Ký sinh thượng lưu"
  },
  Event_91475_ChoiceDesc1 = {Text = "[đi]"},
  Event_91475_Desc = {
    Text = "Bạn biết rằng cảm hứng cuồng nhiệt luôn dẫn đến tai họa, vì vậy bạn dùng lý trí để phong tỏa mọi thứ."
  },
  Event_91475_Name = {
    Text = "Núi lửa ngủ"
  },
  Event_91476_ChoiceDesc1 = {Text = "[đi]"},
  Event_91476_Desc = {
    Text = "Bạn nhìn chằm chằm vào con mắt đó, cố gắng hiểu thông điệp mà nó truyền tải.\nMặc dù bạn đã trải qua nhiều trận chiến, nhưng lần này đối diện với Goliath... sự sợ hãi đã chặn lại trái tim của bạn.\n \"Gần như bình thường, chính là hình thức lặng im nhất trước khi thảm hoạ xảy ra.\""
  },
  Event_91476_Name = {
    Text = "Gần như bình thường"
  },
  Event_91477_ChoiceDesc1 = {Text = "[đi]"},
  Event_91477_Desc = {
    Text = "Bạn nhắm mắt lại, quay người bước vào vùng hoang dã. \n Bạn có thể cảm nhận được những khao khát và điềm báo ẩn giấu, nhưng mãi mãi không thể tự tay dừng lại. \n Bạn nhìn xung quanh những bia mộ không có chữ, có lẽ đây chính là kết cục của bạn."
  },
  Event_91477_Name = {
    Text = "Bữa tiệc của đàn quạ"
  },
  Event_91478_ChoiceDesc1 = {Text = "[đi]"},
  Event_91478_Desc = {
    Text = "Bạn từ từ ngẩng đầu, khoảnh khắc đó, ánh sáng xuyên thấu qua đồng tử, sức nóng nở ra những bông hoa trắng trong tâm trí. \n Các ngôi sao ở Thành Phố Mộ Bia không khác gì ở nơi khác, và những xác sống tưởng chừng như có được sự bất tử cũng chỉ có thể tồn tại dưới những vì sao, không có tự do."
  },
  Event_91478_Name = {
    Text = "Đêm của các ngôi sao"
  },
  Event_91479_ChoiceDesc1 = {
    Text = "[Ném vào lửa] xóa 1 thẻ"
  },
  Event_91479_ChoiceDesc2 = {
    Text = "[Thử nghiệm giải mã]Nhận「(RelicConfig.Arg1)」，lây nhiễm「(Skill.Arg2)」"
  },
  Event_91479_Desc = {
    Text = "Ý thức của bạn nổi lên và chìm xuống trong sương mù vô tận, lướt qua vô số hình ảnh tinh thần của người sống và người chết. \n Trong giấc mơ, máy đánh chữ kỳ diệu phun ra một đoạn câu thơ xa lạ. Đó lại là câu chuyện của ai? \n Nó được khắc ấn trên tờ giấy không rõ nguồn gốc, những chữ viết biến dạng như thể được viết bởi một người say tỉnh dậy. \n Bạn bị thúc đẩy bởi một cơn sóng không thể diễn tả trong giấc mơ, cầm lấy tờ giấy đó, mực nhảy múa giữa ánh sáng và bóng tối của lửa."
  },
  Event_91479_Name = {
    Text = "Khải thị của giấc mơ"
  },
  Event_91480_ChoiceDesc1 = {
    Text = "[Tham gia]Lây nhiễm「(Skill.Arg1)」，ngẫu nhiên 1 thẻ nhận Lời cầu nguyện:「(EnchantConfig.Arg2)」"
  },
  Event_91480_ChoiceDesc2 = {
    Text = "[Đuổi đi] nhiễm「(Skill.Arg1)」，ngẫu nhiên 1 thẻ nhận được lời cầu nguyện:「(EnchantConfig.Arg2)」"
  },
  Event_91480_ChoiceDesc3 = {
    Text = "[Xem nhẹ] chọn 1 trong 3 thẻ lệnh nhận được lời cầu nguyện:「(EnchantConfig.Arg1)」"
  },
  Event_91480_Desc = {
    Text = "Bạn nghe thấy tiếng kèn xương mờ ảo từ xa vọng lại. \n Đám chuột theo tiếng gọi từ bùn đen hiện diện, gặm nhấm xác chết vô danh nằm trên đáy sông khô cạn. \n Chúng tạo thành một vòng tròn, tâm điểm là xác chết đã trống rỗng, và chu vi là một vương quốc mới với sự quên lãng làm luật lệ. \n Còn bạn, đang đứng ở cửa ra vào của vương quốc này."
  },
  Event_91480_Name = {
    Text = "Vương quốc Lưu đày"
  },
  Event_91481_ChoiceDesc1 = {
    Text = "[Ngẩng đầu nhìn] nhận được tàn tích bạc「(RelicConfig.Arg1)」"
  },
  Event_91481_ChoiceDesc2 = {
    Text = "[Cúi đầu rời đi]Nhận 75 Ấn ký đen, lây nhiễm「(Skill.Arg2)」"
  },
  Event_91481_Desc = {
    Text = "Đàn quạ quay cuồng trên bầu trời, như một cái cưa lưỡng lự, liên tục cắt xuyên qua xương sống của bầu trời.\nChúng bay thấp quanh bạn, như thể đã thấy trước cái chết của bạn, kiên nhẫn chờ đợi bữa tiệc bắt đầu."
  },
  Event_91481_Name = {
    Text = "Bữa tiệc của đàn quạ"
  },
  Event_91482_ChoiceDesc1 = {Text = "[đi]"},
  Event_91482_Desc = {
    Text = "Bạn để nó tiếp tục viết, bằng nhịp đập của bạn, bằng cảm giác đau đớn của bạn, bằng quá khứ và những suy đoán của bạn. \n Bướm phá vỡ sự hạn chế của giấy, tâm hồn bạn cũng theo đó mà bay bổng. \n Bạn bắt đầu tưởng tượng về niềm vui của mình ở công viên giải trí. Bạn không nói với Doresain rằng thực ra bạn rất thích công viên giải trí, dù là công viên giải trí của xác chết… \n Chắc là… sẽ không quá kỳ quái chứ?"
  },
  Event_91482_Name = {
    Text = "Bóng bướm trùng trùng"
  },
  Event_91483_ChoiceDesc1 = {
    Text = "[Quan sát lại] chọn 1 trong 3 thẻ lệnh nhận được lời cầu nguyện:「(EnchantConfig.Arg1)」"
  },
  Event_91483_Desc = {
    Text = "Bữa tối từng rõ ràng đã trở thành một buổi tiệc máu thịt mơ hồ, bạn hồi tưởng về những nguyên liệu trên bếp, mùi hôi thối kích thích mũi. \nNỗi sợ như siết chặt trái tim bạn, bạn buộc phải đưa ra sự lựa chọn."
  },
  Event_91483_Name = {
    Text = "Bóng của quá khứ"
  },
  Event_91484_ChoiceDesc1 = {
    Text = "[Xem thường tiếng chuông] nhận được lời cầu nguyện nâng cao 3 chọn 1"
  },
  Event_91484_ChoiceDesc2 = {
    Text = "[Cầm ống nghe] nhận được di vật vàng「(RelicConfig.Arg1)」，nhiễm「(Skill.Arg2)」"
  },
  Event_91484_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 50 dấu đen"
  },
  Event_91484_Desc = {
    Text = "Nó lẽ ra không nên vang lên——chiếc điện thoại, cuộn tròn ở phía sau bức tranh. \n Dây của ống nghe quấn quanh thân máy cỡ lớn, như sợi dây rốn han gỉ, dường như kéo dài từ trong đầu bạn. \n Bạn chăm chú phân biệt tần số rung, âm thanh kỳ quái giống như nghệ thuật siêu thực của Pickman."
  },
  Event_91484_Name = {
    Text = "Cuộc gọi nhỡ"
  },
  Event_91485_ChoiceDesc1 = {Text = "[đi]"},
  Event_91485_Desc = {
    Text = "Bạn nâng viên não lạnh lẽo đó lên, ngay lập tức nó tan ra thành dòng nước chảy lặng lẽ trượt khỏi kẽ tay bạn. \nCán cân ngay lập tức mất cân bằng, trái tim nhanh chóng sụp đổ, tan chảy như trái cây thối rữa, biến thành một vũng nước đen im lặng. \nTất cả cơn đói đều biến mất, bạn có được sự bình tĩnh, không hối tiếc và một chút tỉnh táo thoáng qua."
  },
  Event_91485_Name = {
    Text = "Trò chơi đói"
  },
  Event_91486_ChoiceDesc1 = {Text = "[đi]"},
  Event_91486_Desc = {
    Text = "Không có âm thanh, không ai đáp lại. Có lẽ chỉ là một trò đùa ác? \nKhi bạn đặt ống nghe xuống, một cảm xúc nặng nề nào đó lại trào dâng trong bạn."
  },
  Event_91486_Name = {
    Text = "Cuộc gọi nhỡ"
  },
  Event_91487_ChoiceDesc1 = {Text = "[đi]"},
  Event_91487_Desc = {
    Text = "Quạ đã biến mất.\nNhưng bạn thấy mình đứng trong gương của một đêm khác, nhìn chằm chằm vào con quạ này.\nNó vẫn đang gào thét không tiếng, như thể chờ đợi phản ứng của bạn."
  },
  Event_91487_Name = {
    Text = "Lời thú tội thầm lặng"
  },
  Event_91488_ChoiceDesc1 = {
    Text = "[Quan sát lại] chọn 1 trong 3 thẻ lệnh nhận được lời cầu nguyện:「(EnchantConfig.Arg1)」"
  },
  Event_91488_ChoiceDesc2 = {
    Text = "[Từ bỏ kháng cự] nhiễm「(Skill.Arg1)」，đổi lời cầu nguyện nhận được trong tùy chọn 1, có thể sử dụng thêm một lần"
  },
  Event_91488_Desc = {
    Text = "Bạn quyết đoán quay đi, nhưng những hình ảnh đó lại như bóng ma hiện lên trong mắt bạn…… \nĐó là một điệu nhảy đôi buồn rầu."
  },
  Event_91488_Name = {
    Text = "Bóng của quá khứ"
  },
  Event_91489_ChoiceDesc1 = {
    Text = "[Thưởng thức]Chọn 1 trong 3 thẻ lệnh để nhận Lời cầu nguyện:「(EnchantConfig.Arg1)」"
  },
  Event_91489_ChoiceDesc2 = {
    Text = "[Từ chối]Lây nhiễm「(Skill.Arg1)」，làm lại Lời cầu nguyện, tối đa 2 lần"
  },
  Event_91489_Desc = {
    Text = "Đó là món ăn mà Dullesain đã chuẩn bị tỉ mỉ cho các bạn vì đã điều tra vất vả.\nKhông thêm gia vị nhưng không có mùi hôi, như Dullesain nói, đây là nguyên liệu tốt nhất.\nBữa tiệc được chuẩn bị cho bạn, trong khi bộ não im lặng trong đĩa.\n \"Có muốn nếm thử không?\""
  },
  Event_91489_Name = {
    Text = "Thưởng thức các món ngon"
  },
  Event_91490_ChoiceDesc1 = {
    Text = "[Lắng nghe] nhận được 40 ấn ký đen, nhiễm「(Skill.Arg2)」，tiếp tục chọn"
  },
  Event_91490_ChoiceDesc2 = {
    Text = "[Bỏ qua] nhận được 25 dấu đen, rời đi"
  },
  Event_91490_Desc = {
    Text = "Đó là một con quạ.\nNó đứng trên chiếc đèn sọ người, há miệng nhưng không phát ra âm thanh nào."
  },
  Event_91490_Name = {
    Text = "Lời thú tội thầm lặng"
  },
  Event_91491_ChoiceDesc1 = {Text = "[đi]"},
  Event_91491_Desc = {
    Text = "Bạn từ từ đưa tay về phía trái tim vẫn còn ấm, nó nhảy múa, co bóp, cho đến khi biến thành một làn hơi ấm thơm phức tan biến. \nCái cân rung mạnh, bộ não rơi vào bóng tối vô tận. \nCảm giác no nê thay thế cơn đói, bạn đã hiểu được sự mãnh liệt, đau đớn và ký ức chân thật."
  },
  Event_91491_Name = {
    Text = "Trò chơi đói"
  },
  Event_91492_ChoiceDesc1 = {Text = "[đi]"},
  Event_91492_Desc = {
    Text = "Bạn ngẩng đầu lên, chào đón sự xoay chuyển vô thanh, như những người hành hương trong lễ tế cổ xưa. \nChúng vui vẻ thưởng thức thịt máu của bạn, bạn cảm thấy đau đớn, nhưng cũng rõ ràng. \nBạn nhìn thấy chính mình đã mất, những phần chưa chết đi, cuối cùng đã được mang đi. \nKhi ý thức quay trở lại, bạn nhận ra mình an toàn vô sự."
  },
  Event_91492_Name = {
    Text = "Bữa tiệc của đàn quạ"
  },
  Event_91493_ChoiceDesc1 = {Text = "[đi]"},
  Event_91493_Desc = {
    Text = "Bạn dùng ký ức và cảm xúc như xi măng để niêm phong lỗ khóa, sự thật không còn có thể cám dỗ bạn nữa.\nNhìn bạn như đang đối mặt với kẻ thù, Dulehsain liếm liếm khóe miệng.\n \"Còn muốn thử nữa không? Đây là món mozzarella não đặc chế dành cho ngài Người giữ gìn.\""
  },
  Event_91493_Name = {
    Text = "Khải Huyền"
  },
  Event_91494_ChoiceDesc1 = {Text = "[đi]"},
  Event_91494_Desc = {
    Text = "Thực ra bạn luôn tò mò về trải nghiệm của xác sống.\n \"Vì vậy bạn bước vào bầy chuột, trở thành một phần của chúng——\"\nBạn không thể không thừa nhận, sự xuất hiện của thủy thủ đã khiến đầu óc bạn trở nên không tỉnh táo."
  },
  Event_91494_Name = {
    Text = "Vương quốc Lưu đày"
  },
  Event_91495_ChoiceDesc1 = {Text = "[đi]"},
  Event_91495_Desc = {
    Text = "Bạn không muốn bị ô uế và hỗn loạn.\nBạn đã quen rồi, mọi sự thối rữa giống như một điều bình thường."
  },
  Event_91495_Name = {
    Text = "Vương quốc Lưu đày"
  },
  Event_91496_ChoiceDesc1 = {
    Text = "[Thưởng thức]Chọn 1 trong 3 thẻ lệnh để nhận Lời cầu nguyện:「(EnchantConfig.Arg1)」"
  },
  Event_91496_ChoiceDesc2 = {
    Text = "[Từ chối]Lây nhiễm「(Skill.Arg1)」，ngẫu nhiên nhận lại Lời cầu nguyện"
  },
  Event_91496_Desc = {
    Text = "Đỗ Lê Sa Yên một cách duyên dáng cắt cho bạn một miếng \"não\".\nHương vị ngọt ngào này……\nKết cấu mềm mại và mịn màng này……\nBạn rất muốn thử thêm một miếng nữa."
  },
  Event_91496_Name = {
    Text = "Thưởng thức các món ngon"
  },
  Event_91497_ChoiceDesc1 = {
    Text = "[Tôi đang mơ] nhận được tàn tích bạc「(RelicConfig.Arg1)」"
  },
  Event_91497_ChoiceDesc2 = {
    Text = "[Điều này không bình thường] nhận được di vật vàng「(RelicConfig.Arg1)」，nhiễm「(Skill.Arg2)」"
  },
  Event_91497_Desc = {
    Text = "Bia mộ bóng loáng phản chiếu một đôi mắt đang từ từ biến dạng. \nNhư thể đang mang trong mình một hình ảnh mà mắt thường không thể miêu tả, một đoạn ký ức không thuộc về bạn, nhưng đã ăn sâu vào những nếp gấp dưới đáy mắt bạn. \nBạn cố gắng nhắm mắt, dùng đầu ngón tay lau đi, nhưng đôi mắt đó không còn thuộc về bạn nữa, nó bắt đầu phản chiếu những cảnh tượng như trong Kaleidoskop."
  },
  Event_91497_Name = {
    Text = "Gần như bình thường"
  },
  Event_91498_ChoiceDesc1 = {
    Text = "[Tiếp tục quan sát] chọn 1 trong 3 thẻ lệnh nhận được lời cầu nguyện:「(EnchantConfig.Arg1)」"
  },
  Event_91498_ChoiceDesc2 = {
    Text = "[Quay đi] nhiễm「(Skill.Arg1)」，đổi lời cầu nguyện nhận được trong tùy chọn 1, có thể sử dụng hai lần"
  },
  Event_91498_Desc = {
    Text = "Trong góc ẩm ướt của lâu đài, bạn phát hiện ra cuộn phim đó. \n Hình ảnh như những ảo ảnh chìm trong dòng sông thời gian, đông đặc trong khoảnh khắc chậm chạp, thỉnh thoảng phình ra thành những vật thể khó diễn tả, thỉnh thoảng sụp đổ thành những điểm sáng nhấp nháy. \n Bạn chìm đắm trong đó, một cơn chóng mặt nhắc nhở bạn về sự trôi qua của thời gian."
  },
  Event_91498_Name = {
    Text = "Bóng của quá khứ"
  },
  Event_91499_ChoiceDesc1 = {
    Text = "[Nhìn lên các vì sao]Nhận di vật vàng「(RelicConfig.Arg1)」，lây nhiễm「(Skill.Arg2)」"
  },
  Event_91499_ChoiceDesc2 = {
    Text = "[Nhắm mắt] ngẫu nhiên thức tỉnh 2 người đánh thức，nhiễm hai lần「(Skill.Arg1)」"
  },
  Event_91499_ChoiceDesc3 = {
    Text = "[rời đi] nhận được 50 dấu đen"
  },
  Event_91499_Desc = {
    Text = "Bạn đứng trong nghĩa địa vắng vẻ, sự tồn tại của những vì sao làm cho đêm tối sáng như ban ngày. \n Những quả cầu ánh sáng trôi nổi trong biển sâu thời gian không hề nói, nhưng trong vòng xoay dài như bisikan mimpi, chúng từ từ tụ lại. \n Chúng nhìn chăm chú vào ngôi sao cô đơn bị quên lãng. \n Ngài nhìn bạn, nhìn vào mọi cái chết và sự vĩnh cửu."
  },
  Event_91499_Name = {
    Text = "Đêm của các ngôi sao"
  },
  Event_91500_ChoiceDesc1 = {
    Text = "[Lắng nghe] nhận được 20 ấn ký đen, nhiễm「(Skill.Arg2)」"
  },
  Event_91500_ChoiceDesc2 = {
    Text = "[bỏ qua] rời đi"
  },
  Event_91500_Desc = {
    Text = "Bạn nhìn vào mắt nó.\nTrong bóng tối, bạn thấy lửa tham lam."
  },
  Event_91500_Name = {
    Text = "Lời thú tội thầm lặng"
  },
  Event_91501_ChoiceDesc1 = {
    Text = "[Khởi động khóa] nhận được di vật bị nguyền rủa「(RelicConfig.Arg1)」，nhiễm「(Skill.Arg2)」"
  },
  Event_91501_ChoiceDesc2 = {
    Text = "[Bịt kín ổ khóa] 1 thẻ bài ngẫu nhiên nhận được Khắc ấn: [(EnchantConfig.Arg1)]"
  },
  Event_91501_Desc = {
    Text = "Đối diện với lá não mà Doresain đưa tới, bạn nhiều lần từ chối, nhưng cuối cùng không thể chống lại sự cám dỗ của trí tuệ. \nKiến thức không đến từ từ từ từ từ, mà đột ngột tràn xuống. \nNão bộ bắt đầu đau nhức, tư duy như chiếc bánh mì đang lên men tiếp tục nở ra. Khi bạn cuối cùng ngã xuống, cảm giác đau đớn như thủy triều rút đi, ý thức như có một phần trống rỗng, để lại một lỗ khóa sạch sẽ và cổ xưa. \nHóa ra đây chính là hình dạng của kiến thức! Bạn cảm nhận được trí tuệ chưa từng có. \nCó lẽ… bạn có thể đạt được nhiều hơn nữa?"
  },
  Event_91501_Name = {
    Text = "Khải Huyền"
  },
  Event_91502_ChoiceDesc1 = {Text = "[đi]"},
  Event_91502_Desc = {
    Text = "Bạn dùng lưỡi dao sắc bén còn lại trong ý thức để mỡ khóa đó.\nBạn không biết chìa khóa là gì, chỉ cố gắng dùng ý niệm để thử nghiệm. Vào khoảnh khắc đó, tư tưởng của bạn cháy rực, chỉ còn lại một thứ lý lẽ vô nhân ở trong lỗ khóa trống rỗng thì thầm.\nPhải chăng đây là sự khai sáng? Bạn hào hứng chia sẻ với Dulehsain.\n \"Còn muốn thử nữa không? Đây là món mozzarella não đặc chế dành cho ngài Người giữ gìn.\""
  },
  Event_91502_Name = {
    Text = "Khải Huyền"
  },
  Event_91503_ChoiceDesc1 = {Text = "[đi]"},
  Event_91503_Desc = {
    Text = "Bạn không kích nổ nó, cũng không kìm nén nó. \n Trong một trạng thái quan sát huyền bí, bạn xem những tư tưởng tuôn trào như một phần của sự thay đổi thời tiết, để nó tự chảy về kết thúc chưa biết. \n Trong tác phẩm bằng máu và thịt, bạn đã cảm nhận được nghệ thuật vĩnh cửu."
  },
  Event_91503_Name = {
    Text = "Núi lửa ngủ"
  },
  Event_91504_ChoiceDesc1 = {Text = "[đi]"},
  Event_91504_Desc = {
    Text = "Nút bấm dừng lại đột ngột, bóng bướm tan biến trong chốc lát.\nCó phải là ảo ảnh không? Bạn đang mất một cái gì đó.\nCó lẽ nên nghe lời Dulsaine, đến cửa hàng hộp ký ức mua một ít lá não.\n \"Sai rồi, tôi đang nghĩ cái gì vậy?\""
  },
  Event_91504_Name = {
    Text = "Bóng bướm trùng trùng"
  },
  Event_91505_ChoiceDesc1 = {Text = "[đi]"},
  Event_91505_Desc = {
    Text = "Bạn không còn vật lộn nữa, để cho đôi cánh và chất lỏng đen xuyên qua đường vân tay. \n Bạn đã trở thành chiếc bình của nó, và nó lấy bạn làm vỏ, tiếp tục suy nghĩ. \n Bướm ngày càng lớn, cuối cùng bạn không thể chịu nổi trọng lượng. \n Thấy vậy, Doresain hứng thú dùng dao ăn cắt đứt mối liên kết giữa bạn và bướm. Ánh mắt anh ta đầy hứng khởi, rõ ràng là muốn... \n Bạn từ chối yêu cầu của anh ta."
  },
  Event_91505_Name = {
    Text = "Ký sinh thượng lưu"
  },
  Event_91506_ChoiceDesc1 = {
    Text = "[Lắng nghe] nhận được 35 ấn ký đen, nhiễm「(Skill.Arg2)」，tiếp tục chọn"
  },
  Event_91506_ChoiceDesc2 = {
    Text = "[bỏ qua] rời đi"
  },
  Event_91506_Desc = {
    Text = "Bạn đã tưởng nó im lặng, cho đến khi ý thức của bạn đột ngột nghiêng đi, như hàng triệu cái đầu quạ đang kêu khóc trong bộ não bạn. \nBạn quỳ xuống đất, thế giới trong mắt bạn bắt đầu xoay vòng."
  },
  Event_91506_Name = {
    Text = "Lời thú tội thầm lặng"
  },
  Event_91507_ChoiceDesc1 = {Text = "[đi]"},
  Event_91507_Desc = {
    Text = "Bạn nhắm mắt lại, bước vào trong làn bụi mịn vô tận và mềm mại, các đám mây sao ôm lấy bạn, và bạn đã mất đi hình dạng, một sự tồn tại vững chắc hơn cả thân thể đang lắng đọng trong bạn. \n Đêm đó, các vì sao vẫn tiếp tục xoay chuyển, vẫn sáng rực như mọi khi. \n Đối với những kẻ trường sinh, bầu trời đầy sao có ý nghĩa gì? Có lẽ bạn nên đi hỏi Doresain."
  },
  Event_91507_Name = {
    Text = "Đêm của các ngôi sao"
  },
  Event_91508_ChoiceDesc1 = {
    Text = "[Thưởng thức]Chọn 1 trong 3 thẻ lệnh để nhận Lời cầu nguyện:「(EnchantConfig.Arg1)」"
  },
  Event_91508_Desc = {
    Text = "Hóa ra đó là phô mai.  \nBạn vừa cảm thấy may mắn, nhưng cũng có chút tiếc nuối."
  },
  Event_91508_Name = {
    Text = "Thưởng thức các món ngon"
  },
  Event_91509_ChoiceDesc1 = {
    Text = "[Thổi lửa] nhiễm「(Skill.Arg1)」，nhận được tàn tích bạc「(RelicConfig.Arg2)」"
  },
  Event_91509_ChoiceDesc2 = {
    Text = "[Chờ đợi] nhiễm「(Skill.Arg1)」，nhận được tàn tích bạc「(RelicConfig.Arg2)」"
  },
  Event_91509_ChoiceDesc3 = {
    Text = "[Lưu trữ]Nhận 25 Ấn ký đen"
  },
  Event_91509_Desc = {
    Text = "Bạn nhìn chằm chằm vào tác phẩm của Pikman, hơi thối rữa gây buồn nôn khiến bạn choáng váng.\nSuy nghĩ từ trong đầu từ từ nổi lên, ban đầu chỉ là hơi nóng, sau đó là sương mù, rồi sau đó——"
  },
  Event_91509_Name = {
    Text = "Núi lửa ngủ"
  },
  Event_91510_ChoiceDesc1 = {
    Text = "[Chạm vào não] ngẫu nhiên 1 thẻ lệnh nhận được lời cầu nguyện:「(EnchantConfig.Arg1)」"
  },
  Event_91510_ChoiceDesc2 = {
    Text = "[Chạm vào tim] tăng tối đa máu Arg1 điểm，nhiễm「(Skill.Arg2)」"
  },
  Event_91510_Desc = {
    Text = "Bạn bước vào căn phòng xám không có ai thầm thì, một chiếc cân hiện lên mờ ảo trong làn sương đen. \nBên trái là một bộ não tĩnh lặng như hồ, những rãnh bạc trắng lấp lánh ánh sáng mờ; bên phải là một trái tim đỏ rực, tỏa ra hơi nóng. \nĐột nhiên, bạn ngửi thấy một mùi hương, cơn khát khao không ngừng phình to, lý trí bị sự tối tăm vô biên của nó ép chặt. \nBạn đưa tay ra."
  },
  Event_91510_Name = {
    Text = "Trò chơi đói"
  },
  Event_91511_ChoiceDesc1 = {Text = "[đi]"},
  Event_91511_Desc = {
    Text = "Đây nhất định là một giấc mơ. Bạn liên tục thuyết phục bản thân. \n Trong lúc không hay biết, bạn đã thực sự rơi vào giấc ngủ. \n Có lẽ vì gần đây giao tiếp quá nhiều, bạn lại mơ thấy Doresain - chủ động để Doresain ăn thịt máu của mình? Câu chuyện kinh dị gì vậy?"
  },
  Event_91511_Name = {
    Text = "Gần như bình thường"
  },
  Event_91660_ChoiceDesc1 = {
    Text = "[Tìm lối khác] Chọn 1 trong 3 thẻ lệnh để nhận Khắc ấn: [(EnchantConfig.Arg1)]"
  },
  Event_91660_ChoiceDesc2 = {
    Text = "[Để mặc chúng tồn tại]Ngẫu nhiên 3 thẻ lệnh nhận Lời cầu nguyện:「(EnchantConfig.Arg1)」，lây nhiễm「(Skill.Arg2)」"
  },
  Event_91660_Desc = {
    Text = "\"Để thúc đẩy linh hồn, bạn cần dẫn dắt người chết đến tận cùng.\"\nCùng với lời nói của Dullesain, bạn như có một sự ngộ ra.\nĐó không phải là kiến thức, cũng không phải là ký ức—cái đó giống như một trọng lượng, từ hốc mắt của bạn xâm nhập vào, như một cơn lũ tràn vào não bộ của bạn.\nCảm xúc của bạn dường như không còn thuộc về nơi đây và lúc này, nó lui lại, mở ra một khe hở mà vũ trụ lơ là.\nTất cả những gì bạn có thể cảm nhận, dừng lại ở đó, như đã đi đến tận cùng của một con đường."
  },
  Event_91660_Name = {
    Text = "Đỉnh điểm linh hồn"
  },
  Event_91661_ChoiceDesc1 = {Text = "[đi]"},
  Event_91661_Desc = {
    Text = "Bạn để linh hồn ra đi.\nTại ranh giới của \"bản thể\", bạn như nghe thấy tiếng thì thầm của những người đã khuất.\nNhưng khi bạn lắng nghe kỹ, mọi thứ đều biến mất."
  },
  Event_91661_Name = {
    Text = "Đỉnh điểm linh hồn"
  },
  Event_91662_ChoiceDesc1 = {Text = "[đi]"},
  Event_91662_Desc = {
    Text = "Bạn bao bọc ý thức của mình lại, từ đó ngăn chặn được sự cám dỗ không biết. \nBạn mất tích ở tận cùng của linh hồn, chỉ nhìn thấy chính mình. \nQuả nhiên, là người sống, bạn không thể có được khả năng của xác sống."
  },
  Event_91662_Name = {
    Text = "Đỉnh điểm linh hồn"
  }
})
return Text_Event
