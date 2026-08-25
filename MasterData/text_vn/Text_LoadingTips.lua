__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_LoadingTips = readonly({
  LoadingTips_17465_LoadingTips = {
    Text = "Tỷ lệ đồng điều, tức là mức độ đồng điều tinh thần giữa điều tra viên, Người Giữ Gìn và thức tỉnh thể của họ. \nTỷ lệ đồng điều càng cao, điều tra viên, Người Giữ Gìn và thức tỉnh thể càng hiểu rõ nhau, mối quan hệ càng gắn bó, sự tin tưởng càng vững chắc."
  },
  LoadingTips_17466_LoadingTips = {
    Text = "Trong thâm cảnh, tình cảm, suy nghĩ, tư duy, chấp niệm v.v. đều có thể có hình chiếu có thể quan sát được. Những hình chiếu này thường là vật phẩm hư ảo, đánh lừa giác quan của cá nhân thông qua kích thước tinh thần."
  },
  LoadingTips_17467_LoadingTips = {
    Text = "Máy in linh tri thức là một thiết bị đặc biệt được tích hợp trong vali của điều tra viên và Người Giữ Gìn, có thể chuyển đổi tinh thần thành thẻ bài đa chiều chỉ xem được qua thiết bị quan sát dung hợp: thẻ lệnh."
  },
  LoadingTips_17468_LoadingTips = {
    Text = "Rã nứt một khi được tạo ra, không thể thu nhỏ, không thể chấm dứt. \n Các biện pháp thông thường không thể ảnh hưởng đến rã nứt, nhưng chìa khóa bạc có thể trong một mức độ nhất định áp chế thậm chí \"đóng\" rã nứt."
  },
  LoadingTips_17469_LoadingTips = {
    Text = "Hầu hết các cá thể bị ảnh hưởng bởi hiện tượng \"rỗng rỗng\" cũng sẽ gặp phải sự can thiệp vào tư duy, xuất hiện các rối loạn tinh thần như ám ảnh cưỡng chế, hưng phấn thái quá và suy giảm trí nhớ."
  },
  LoadingTips_17470_LoadingTips = {
    Text = "Rỗng rỗng có thể xảy ra trên các sinh vật hữu cơ như con người, động vật, thực vật, cũng như trên các chất vô cơ như khoáng chất, kim loại. \nHiện chưa phát hiện ra chất có khả năng miễn dịch với hiện tượng ăn mòn."
  },
  LoadingTips_17471_LoadingTips = {
    Text = "Hầu hết con người không thể quan sát hiện tượng rỗng rỗng bằng mắt thường."
  },
  LoadingTips_17472_LoadingTips = {
    Text = "Dựa vào sự biến đổi khác nhau, có thể chia rỗng rỗng thành các loại khác nhau. Phổ biến nhất là rỗng rỗng kiểu hợp tác, kiểu can thiệp và kiểu phức hợp."
  },
  LoadingTips_17473_LoadingTips = {
    Text = "Hiện tượng rỗng rỗng xuất hiện trên vật chất được thể hiện bằng một hoặc nhiều lỗ nhỏ có hình dạng tương tự tam giác ngược. \n Kích thước của các lỗ này khoảng từ 3mm đến 1cm, và dấu rỗng rỗng sẽ mở rộng theo thời gian."
  },
  LoadingTips_17474_LoadingTips = {
    Text = "Rỗng rỗng là hiện tượng phân giải và hòa tan đặc biệt của vật chất, mang tính khu vực rõ rệt."
  },
  LoadingTips_17475_LoadingTips = {
    Text = "Hiện tượng rỗng rỗng phát triển đến một giai đoạn nhất định, có xác suất nhất định sẽ sinh ra các khối phụ từ dấu rỗng rỗng. \nChúng có thể là các chi phụ, xúc tu, cũng có thể là bánh răng, kim loại……"
  },
  LoadingTips_17476_LoadingTips = {
    Text = "Dung dịch rỗng rỗng có tính khinh thủy, không thấm nước và khó hòa tan trong nước, độ nhớt trung bình và có tính đàn hồi nhất định. \n Hàng trăm năm trước, con người từng liều lĩnh sử dụng nó làm nguyên liệu trong công nghiệp và nghệ thuật."
  },
  LoadingTips_17477_LoadingTips = {
    Text = "\"Chào mừng đến với kho lúa — nơi có nhiều tủ lưu trữ nhất và ít tang lễ nhất.\"\nCục Lưu trữ và Ghi chép CMT vì tính chất đồng âm, lại được người của hội nghị thẩm tra gọi đùa là \"kho lúa\"."
  },
  LoadingTips_17478_LoadingTips = {
    Text = "Các thành viên của Hiệp hội Điêu khắc gia đôi khi tự xưng là \"Pygmalion\", và biểu tượng của tổ chức họ cũng là một dụng cụ khắc."
  },
  LoadingTips_17479_LoadingTips = {
    Text = "Rỗng rỗng không được thế gian nhận thức, nhưng trong một số kết xã hội bí mật, người ta tin rằng hiện tượng này không phải là thảm họa, mà là phúc lành từ thần minh."
  },
  LoadingTips_17480_LoadingTips = {
    Text = "Đường kính vượt quá 5 mét và vẫn có khả năng mở rộng, dấu ăn mòn khổng lồ như vậy được gọi là rã nứt. \n Lõi của rã nứt được gọi là \"thảm họa\"."
  },
  LoadingTips_17481_LoadingTips = {
    Text = "Thể linh tri thức khẩn cấp có thể tác động trực tiếp vào tinh thần của thức tỉnh giả, kích thích tiềm năng của họ và ngay lập tức phục hồi trạng thái. Nhược điểm duy nhất là chi phí sản xuất đắt đỏ."
  },
  LoadingTips_17482_LoadingTips = {
    Text = "Nhiệm vụ ngoại vi thay đổi nhanh chóng, có tính không kiểm soát được rất cao. \nĐối với tình huống này, Đại học Misag cung cấp một số thiết bị khẩn cấp cho nhân viên ngoại vi, nhằm đảm bảo an toàn của họ ở mức cao nhất."
  },
  LoadingTips_17483_LoadingTips = {
    Text = "Điều tra viên và Người Giữ Gìn thường không điều tra các sự kiện thực tế bình thường, mà là những sự kiện đặc biệt liên quan đến rỗng rỗng và thân thể bị ăn mòn, có mối liên hệ lớn với kích thước tinh thần."
  },
  LoadingTips_17484_LoadingTips = {
    Text = "Trong khu vực có hiện tượng rỗng rỗng, hình chiếu của kích thước tinh thần rõ ràng hơn, thâm cảnh cũng dễ dàng được quan sát hơn, nhưng cũng trở nên khó đoán và nguy hiểm hơn."
  },
  LoadingTips_17485_LoadingTips = {
    Text = "Tùy thuộc vào các đặc điểm khác nhau, thân thể được đánh thức chủ yếu được chia thành bốn giới vực: biển sâu, thịt máu, siêu không gian và hỗn loạn."
  },
  LoadingTips_17486_LoadingTips = {
    Text = "Sau nghi thức Yếu Trủng, điều tra viên và Người Giữ Gìn cần thực hiện một nhiệm vụ ngoại trường có sự giám sát của giáo viên cùng với thân thể được đánh thức mà họ đã chọn, để đảm bảo khả năng thực hiện nhiệm vụ độc lập trong tương lai."
  },
  LoadingTips_17487_LoadingTips = {
    Text = "Hội nghị thẩm tra Mistia (gọi tắt là CMT) là tổ chức bí mật do con người bình thường tạo nên, được thành lập chung bởi các chính phủ nhưng hoạt động độc lập với chính phủ. \nNó là người phát hiện đầu tiên và phản ứng đầu tiên đối với hiện tượng ăn mòn, \ncũng là chiến tuyến đầu tiên của con người bình thường chống lại hiện tượng ăn mòn."
  },
  LoadingTips_17488_LoadingTips = {
    Text = "Các thân thể được đánh thức khác nhau trong cùng một giới vực có thể phối hợp với nhau tốt hơn, giữa các giới vực khác nhau có thể tồn tại sự bài xích nhất định. \nChỉ có giới vực hỗn độn không có hiện tượng này."
  },
  LoadingTips_17489_LoadingTips = {
    Text = "Bạc tâm thường tồn tại dưới hai dạng trong thế giới thực: dung dịch gốc bạc tâm và lăng trụ lục giác lệch."
  },
  LoadingTips_17490_LoadingTips = {
    Text = "Chỉ số Nos là giá trị đo lường sự ổn định của các phân mảnh tinh thần trong bạc tâm. \nThức tỉnh giả với chỉ số càng cao, khả năng mất kiểm soát càng thấp, và mức độ thương vong có thể gây ra sau khi mất kiểm soát cũng càng ít."
  },
  LoadingTips_17491_LoadingTips = {
    Text = "Một chìa khóa bạc được sinh ra cần trải qua một loạt các quy trình phức tạp, cuối cùng sẽ được khắc số hiệu duy nhất. \nChìa khóa bạc nghiêm cấm giao dịch, nghiêm cấm chuyển tặng, khi không còn chủ sẽ được Misaque thu hồi."
  },
  LoadingTips_17492_LoadingTips = {
    Text = "Cuốn sách cấm kỵ bị khóa ở giá sách cao nhất của thư viện, chỉ những người được cấp phép mới có thể tra cứu."
  },
  LoadingTips_17493_LoadingTips = {
    Text = "Theo các điều khoản trong \"Hiệp định Misidia\", Đại học Misaque sẽ cung cấp hỗ trợ Công nghệ Bạc Tâm cho hội nghị thẩm tra Hiệp định Misidia, nhằm cùng nhau đối phó với rỗng rỗng và ứng phó với khủng hoảng."
  },
  LoadingTips_17494_LoadingTips = {
    Text = "Mỗi cá thể khi bị tiêu biến, lượng bạc tâm có thể tách ra khác nhau. \n Cá thể có sức mạnh tinh thần càng lớn, sau khi bị rỗng rỗng tiêu biến sẽ tách ra được nhiều bạc tâm hơn, ngược lại thì ít hơn."
  },
  LoadingTips_17495_LoadingTips = {
    Text = "Các vật phẩm tiêu biểu của Công nghệ Bạc Tâm bao gồm: thiết bị quan sát đặc biệt, máy thông tin của Đại học Misag, và chìa khóa bạc, v.v. \nTrong số đó, chìa khóa bạc là món đồ đặc biệt nhất và quý giá nhất."
  },
  LoadingTips_17496_LoadingTips = {
    Text = "Trong lễ thức đánh thức, điều tra viên và Người Giữ Gìn sẽ sử dụng chìa khóa bạc để tăng cường liên kết giữa bạc tâm và kích thước tinh thần. \nNhờ liên kết này, họ có thể bắt lấy các phân mảnh tinh thần đang lang thang và cố định chúng vào bạc tâm."
  },
  LoadingTips_17497_LoadingTips = {
    Text = "Thân thể được đánh thức do bạc tâm cưỡng chế từ chiều tinh thần để nắm bắt và cố định các phân mảnh tinh thần, mà những phân mảnh này chịu ảnh hưởng từ chiều tinh thần. Do đó, tất cả thân thể được đánh thức sau khi thức tỉnh đều tự nhiên rơi vào trạng thái điên cuồng, cho đến khi điều tra viên hoặc Người Giữ Gìn thiết lập liên kết với chúng."
  },
  LoadingTips_17498_LoadingTips = {
    Text = "Đại học Misaque, được thành lập vào ngày 16 tháng 10 năm 187 Hồng Tích, là một trường đại học cao cấp chuyên nghiên cứu và đối phó với hiện tượng rỗng."
  },
  LoadingTips_17499_LoadingTips = {
    Text = "Đại học Misaque, tiền thân là Trường học Misaque, được thành lập vào ngày 16 tháng 10 năm Hồng Tích thứ 90 bởi Howard Phillips cùng hai đồng sáng lập khác."
  },
  LoadingTips_17500_LoadingTips = {
    Text = "Điều tra viên và Người Giữ Gìn có chìa khóa bạc có thể đi qua sương mù ngoài trường một cách suôn sẻ. Họ có thể cùng với thân thể được đánh thức đã liên kết vào khuôn viên trường."
  },
  LoadingTips_17501_LoadingTips = {
    Text = "315 năm trước, một thảm họa lớn đã quét khắp toàn cầu. \nNgười ta lấy năm xảy ra thảm họa làm năm nguyên, bắt đầu một kỷ nguyên mới — Hong Ji."
  },
  LoadingTips_17502_LoadingTips = {
    Text = "\"Nguyện chìa khóa bạc dẫn lối phía trước.\"\nLời chúc thường dùng của thành viên Đại học Misaque, chứa đựng niềm tin tiến bước không ngại khó khăn của người Misaque."
  },
  LoadingTips_17503_LoadingTips = {
    Text = "\"Thề sẽ dùng lưỡi kiếm xuyên thủng bóng tối.\"\nLời chúc thường dùng của thành viên Hội đồng xem xét Hiệp định Misidia, chứa đựng quyết tâm kiên định của các thành viên trong cuộc đấu tranh chống lại sự rỗng."
  },
  LoadingTips_17504_LoadingTips = {
    Text = "Những người đặc biệt có nhiều khả năng hơn so với các điều tra viên thông thường, có thể liên kết với nhiều thân thể được đánh thức, sẽ được trao danh hiệu Người Giữ Gìn. \nCho đến nay, số người có thể mang danh Người Giữ Gìn để lang thang trên thế gian vẫn còn rất ít ỏi."
  },
  LoadingTips_17505_LoadingTips = {
    Text = "Thông thường, một điều tra viên chỉ có thể liên kết với một thân thể được đánh thức tại cùng một thời điểm. Nhưng cũng không loại trừ có những trường hợp đặc biệt."
  },
  LoadingTips_17506_LoadingTips = {
    Text = "Khi không có nhiệm vụ ngoại trường, các điều tra viên, Người Giữ Gìn cùng với thân thể được đánh thức của họ sẽ nghỉ ngơi và hồi phục tại Đại học Misag. \nHọ cần đi học, dự thi và làm bài tập dài dòng."
  },
  LoadingTips_17507_LoadingTips = {
    Text = "Tất cả các thân thể được đánh thức đều phải tuân thủ các quy định liên quan của \"Hiệp định Misdia\", sau khi tỉnh dậy cũng cần đăng ký."
  },
  LoadingTips_17508_LoadingTips = {
    Text = "Nghiêm ngặt mà nói, thân thể được đánh thức cũng là một loại Công nghệ Bạc Tâm."
  },
  LoadingTips_36756_LoadingTips = {
    Text = "Tùy theo loại Vết Nứt khác nhau, một Vết Nứt có thể sở hữu một hoặc nhiều lõi được gọi là \"Tai Ách\"."
  },
  LoadingTips_36757_LoadingTips = {
    Text = "Dựa trên lý thuyết \"Cấu trúc tinh thần của Điều tra viên và tiềm năng của họ\", Misaque đã phát triển và hoàn thiện một loạt quy trình sàng lọc, nhằm khai thác tối đa các điều tra viên tiềm năng mà không làm xáo trộn công chúng."
  },
  LoadingTips_36758_LoadingTips = {
    Text = "Tinh thần của mỗi người khác nhau, và khả năng đặc biệt của mỗi Người Giữ Gìn cũng không giống nhau. \n Hiện tại, các khả năng đã biết bao gồm: chia sẻ ký ức, chia sẻ cảm xúc, cảm nhận cảm xúc, v.v."
  },
  LoadingTips_36759_LoadingTips = {
    Text = "315 năm trước, một trận lũ lớn đã quét qua thế giới. Trật tự sụp đổ, thành phố đổ nát, những ngọn núi dưới đáy biển đột nhiên nổi lên, tạo thành đất mới."
  },
  LoadingTips_36760_LoadingTips = {
    Text = "Vương quốc Leo, đơn vị tiền tệ thông dụng là Leo Phường. Trên thị trường còn lưu thông các đồng tiền phụ chủ yếu là Myanmar và phiến gì. 1 Leo Phường tương đương với 10 Myanmar, và 1 Myanmar bằng 10 phiến gì."
  },
  LoadingTips_36761_LoadingTips = {
    Text = "Với sự giúp đỡ của thiết bị và bạc tâm, không gian đặc biệt này tạm thời độc lập, không bị ảnh hưởng bởi các tinh thần khác cũng như chiều thực tại, được gọi là thiên nhiên mật cảnh (Artificial Domain)."
  },
  LoadingTips_36762_LoadingTips = {
    Text = "Thông qua thang máy, có thể đến không gian ngầm Misaque. \n Ngoài hồ đen, khe nứt lớn nhất L-01 tại Lentiennam, nơi đây cũng tồn tại các khu vực hạn chế, phải đạt yêu cầu về mức độ an toàn để được phép vào."
  },
  LoadingTips_36763_LoadingTips = {
    Text = "Do có một mối liên hệ nhất định giữa chìa khóa bạc và kích thước tinh thần, khi tiếp cận các cá thể có sự bất thường về tinh thần, chìa khóa bạc có thể tạo ra phản ứng đặc biệt."
  },
  LoadingTips_36764_LoadingTips = {
    Text = "Bí ẩn là các ký hiệu huyền bí được ghi lại trên vật liệu chứa bạc tâm bằng phương pháp đặc biệt. \n Các bí ẩn khác nhau mang lại sự hỗ trợ khác nhau, và những bí ẩn cùng một loạt sẽ cung cấp nhiều hỗ trợ hơn."
  },
  LoadingTips_36765_LoadingTips = {
    Text = "Dung dịch ăn mòn là một loại chất lỏng màu đen dính chảy ra từ dấu rỗng rỗng. \n Giống như hiện tượng rỗng rỗng, người bình thường không thể quan sát trực tiếp mà cần thiết bị đặc biệt."
  },
  LoadingTips_36766_LoadingTips = {
    Text = "Một số thân thể bị ăn mòn sau khi chết sẽ hóa thành bột đen, được gọi là bột rỗng rỗng."
  },
  LoadingTips_36767_LoadingTips = {
    Text = "Vương quốc Leo nằm ở phía đông Đại Tây Dương, giáp với Liên bang Konstan và Liên minh Bách Thọ. \n Vương quốc có diện tích không lớn, nhưng quốc lực hùng mạnh, là một trong những quốc gia sớm nhất hoàn thành tái thiết sau đại hồng thủy."
  },
  LoadingTips_36768_LoadingTips = {
    Text = "Cộng hòa Agro nằm ở phía tây Đại Tây Dương, bốn bề giáp biển, đất đai rộng lớn. \nCộng hòa Agro có ngành công nghiệp và tài chính phát triển mạnh mẽ, thành phố tài chính Fletcher là nơi phồn hoa mà nhiều người mơ ước."
  },
  LoadingTips_36769_LoadingTips = {
    Text = "Trong thâm cảnh, tình cảm, suy nghĩ, tư duy, chấp niệm v.v. đều có thể có hình chiếu quan sát được. \nNhững hình chiếu này thường không thể chạm vào, hoặc tan biến khi chạm nhẹ, là cách kích thước tinh thần đánh lừa giác quan của cá thể trong chiều thực tại."
  },
  LoadingTips_36770_LoadingTips = {
    Text = "Liên bang Konstan nằm ở lục địa Đông Laurasia, là một liên bang được thành lập từ sự kết hợp của nhiều quốc gia nhỏ. Trong liên bang, nghệ thuật là mục tiêu chung của tất cả mọi người."
  },
  LoadingTips_36771_LoadingTips = {
    Text = "Một số hình chiếu đặc biệt có thể được máy in linh tri thức bắt giữ và gắn lên thẻ lệnh, giúp thân thể được đánh thức nhận thêm lợi ích. Những hình chiếu này được gọi là khắcăng (Orison)."
  },
  LoadingTips_36772_LoadingTips = {
    Text = "Dựa vào kích thước của rã nứt, rã nứt có thể được phân thành khoảng 6 loại chính: C, B, A, S, SS, SSS."
  },
  LoadingTips_36773_LoadingTips = {
    Text = "Hiệp hội Điêu khắc gia, một tổ chức cực đoan chuyên thực hiện các thí nghiệm nhân thể đầy tội lỗi. Được sáng lập bởi Robert Rosenthal, người phản bội của Misaque."
  },
  LoadingTips_36774_LoadingTips = {
    Text = "Người dấn thân vào biển, một tổ chức tôn giáo cổ xưa do Miriam đứng đầu. \nHọ nỗ lực hết mình nhằm hồi sinh vị thần vương duy nhất của họ."
  },
  LoadingTips_36775_LoadingTips = {
    Text = "Các thâm cảnh ở những khu vực khác nhau khi điều tra có thể thu thập được những thứ khác nhau, thậm chí những thứ tương tự cũng có thể khác biệt về bản chất."
  },
  LoadingTips_36776_LoadingTips = {
    Text = "Thâm cảnh (Domain) là một không gian chiều đặc biệt nằm giữa kích thước tinh thần và thực tế, là nơi gần nhất với kích thước tinh thần mà con người có thể bước vào bằng thể xác."
  },
  LoadingTips_36777_LoadingTips = {
    Text = "Đại học Misaque là bên thứ ba trung lập tuyệt đối, mọi vấn đề lớn nhỏ trong trường đều do hiệu trưởng và các nhân viên quản lý cùng nhau thương lượng quyết định, không bị ràng buộc bởi bất kỳ tổ chức nào."
  },
  LoadingTips_36778_LoadingTips = {
    Text = "Sự tồn tại của rã nứt không cần phải dựa vào các vật thể có thực thể, bầu trời, đại dương, đều là nơi rã nứt có thể xuất hiện."
  },
  LoadingTips_36779_LoadingTips = {
    Text = "Hội Giáo đèn lồng, một tổ chức tôn giáo bí ẩn và đáng sợ. Dường như có mối liên hệ sâu sắc với Hiệp hội Điêu khắc gia và người dấn thân vào biển."
  },
  LoadingTips_36780_LoadingTips = {
    Text = "Hội nghị thẩm tra Hiệp định Misidia là một tổ chức cực kỳ lớn. \nNgoài Vương quốc Leo, nó còn có các chi nhánh ở Cộng hòa Agro, Liên bang Konstan và Đế quốc Lemvahi."
  }
})
return Text_LoadingTips
