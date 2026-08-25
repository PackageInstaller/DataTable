__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_FeatureUnlock = readonly({
  FeatureUnlock_100551_LockTip = {
    Text = "Hoàn thành \"điều tra hành động\" 3-10·thường để mở khóa"
  },
  FeatureUnlock_100552_LockTip = {
    Text = "Sau khi hoàn thành nhiệm vụ \"điều tra hành động\" 2-15·thông thường, tính năng sẽ được mở khóa"
  },
  FeatureUnlock_116229_LockTip = {
    Text = "<Posse:hoàn thành nhiệm vụ 「Tái kiến, Vô Vĩnh Quốc Gia」·phổ thông sau khi mở khóa>"
  },
  FeatureUnlock_116599_LockTip = {
    Text = "<Posse:Mở khóa sau khi hoàn thành 「Điều Tra Hành Động」1-2·Phổ Thông>"
  },
  FeatureUnlock_116600_FeatureName = {
    Text = "Hoạt động Pollux"
  },
  FeatureUnlock_119961_FeatureName = {
    Text = "Cửa hàng trao đổi"
  },
  FeatureUnlock_119961_LockTip = {
    Text = "Hoàn thành chương mở đầu để mở khóa"
  },
  FeatureUnlock_120493_FeatureName = {
    Text = "\"Hoạt động điều tra\" Chương 4 bản sao sao trời"
  },
  FeatureUnlock_120493_LockTip = {
    Text = "Hoàn thành chương 3 · Bình thường của \"Hoạt động điều tra\" tiểu thuyết sao"
  },
  FeatureUnlock_120493_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Hoạt động điều tra「Chính vị ngôi sao·Thiên đường」 đã được mở>\n\n<FeatureUnlockDesc:Đuổi theo tin tức của William đã trôi dạt trên biển nhiều tháng, bạn đã đột nhập vào một cơn bão kỳ lạ khó nắm bắt……>"
  },
  FeatureUnlock_120494_FeatureName = {
    Text = "\"Điều tra hoạt động\" Chương 4 Âm tinh · Khó khăn"
  },
  FeatureUnlock_120494_LockTip = {
    Text = "Hoàn thành chương 3 · Khó khăn và chương 4 · Bình thường của \"Hoạt động điều tra\" tiểu thuyết sao"
  },
  FeatureUnlock_120494_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Hoạt động điều tra「Thiên đường」·Độ khó khắc nghiệt đã được mở>"
  },
  FeatureUnlock_120989_LockTip = {
    Text = "Chưa được mở"
  },
  FeatureUnlock_120990_LockTip = {
    Text = "<Posse:Hoàn thành 「Hoạt động điều tra」 chương thứ 4· thường sau khi mở khóa>"
  },
  FeatureUnlock_120991_LockTip = {
    Text = "<Posse:Hoàn thành 「Khúc nhạc vinh quang của các vì sao」·Thường sau khi mở khóa>"
  },
  FeatureUnlock_122563_FeatureName = {
    Text = "Sự kiện Mùa hè"
  },
  FeatureUnlock_122564_LockTip = {
    Text = "<Posse:Mở khóa sau khi hoàn thành 「Điều Tra Hành Động」1-2·Phổ Thông>"
  },
  FeatureUnlock_123278_LockTip = {
    Text = "Hoàn thành \"Lễ rửa tội bằng bạc và máu\"·Bình thường để mở khóa"
  },
  FeatureUnlock_123279_LockTip = {
    Text = "Chưa được mở"
  },
  FeatureUnlock_125344_LockTip = {
    Text = "<Posse:Mở khóa sau khi hoàn thành 「Điều Tra Hành Động」1-2·Phổ Thông>"
  },
  FeatureUnlock_125345_FeatureName = {
    Text = "Hoạt động của Tuần"
  },
  FeatureUnlock_126274_FeatureName = {
    Text = "Sự kiện Arachne"
  },
  FeatureUnlock_126363_FeatureName = {
    Text = "\"điều tra hành động\" Chương 5 Bài sao"
  },
  FeatureUnlock_126363_LockTip = {
    Text = "Hoàn thành \"điều tra hành động\" Bài sao chương 4·Phổ thông sẽ được mở khóa"
  },
  FeatureUnlock_126363_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Hành động điều tra \"Khoảnh Khắc Tinh Thần Chính Vị · Nhà Hát Dệt Mệnh\" đã mở>\n\n<FeatureUnlockDesc:Vượt qua cánh cửa Hắc Nhật, bạn trở về thành phố quen thuộc ấy, nhưng tất cả chỉ là một sân khấu được dựng riêng cho bạn……>"
  },
  FeatureUnlock_126364_FeatureName = {
    Text = "\"Điều tra hành động\" Chương 5 Bài sao ·khó khăn"
  },
  FeatureUnlock_126364_LockTip = {
    Text = "Hoàn thành \"điều tra hành động\" Bài sao chương 4 · khó khăn và chương 5·bình thường để được mở khóa"
  },
  FeatureUnlock_126364_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Hành động điều tra \"Nhà Hát Dệt Mệnh\" · Độ khó Khó đã mở>"
  },
  FeatureUnlock_128099_FeatureName = {
    Text = "Hành Lang Ký Ức"
  },
  FeatureUnlock_128099_LockTip = {
    Text = "Hoàn thành Điều tra Chương 1-9 chế độ Thường để mở khóa"
  },
  FeatureUnlock_129487_FeatureName = {
    Text = "Tàu hỏa hạnh phúc lao nhanh"
  },
  FeatureUnlock_129507_LockTip = {
    Text = "<Posse:Mở khóa sau khi hoàn thành 「Điều Tra Hành Động」1-2·Phổ Thông>"
  },
  FeatureUnlock_129645_LockTip = {
    Text = "Hoàn thành Điều tra Chương 1-9 chế độ Thường để mở khóa"
  },
  FeatureUnlock_130172_LockTip = {
    Text = "<Posse:Mở khóa sau khi hoàn thành 「Điều Tra Hành Động」1-2·Phổ Thông>"
  },
  FeatureUnlock_130173_FeatureName = {
    Text = "Hoạt động Saya"
  },
  FeatureUnlock_130899_LockTip = {
    Text = "<Posse:Mở khóa sau khi hoàn thành 「Điều Tra Hành Động」1-2·Phổ Thông>"
  },
  FeatureUnlock_130900_FeatureName = {
    Text = "Hoạt động Mosk"
  },
  FeatureUnlock_133714_FeatureName = {
    Text = "Lớp Học Mật Cảnh"
  },
  FeatureUnlock_133714_LockTip = {
    Text = "Mở khóa sau khi hoàn thành \"điều tra hành động\" 1-11·thông thường"
  },
  FeatureUnlock_133714_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Lớp Học Mật Cảnh đã mở>\n\n<FeatureUnlockDesc:Để điều tra viên luôn duy trì trạng thái nhạy bén, đây là nội dung huấn luyện cơ bản hàng ngày do Misag đặt ra.>"
  },
  FeatureUnlock_134019_FeatureName = {
    Text = "Thử Luyện Hàng Tuần"
  },
  FeatureUnlock_134019_LockTip = {
    Text = "Mở khóa sau khi hoàn thành \"điều tra hành động\" 1-11·thông thường"
  },
  FeatureUnlock_134020_FeatureName = {
    Text = "Thử Luyện Hàng Ngày"
  },
  FeatureUnlock_134020_LockTip = {
    Text = "Mở khóa sau khi hoàn thành \"điều tra hành động\" 1-11·thông thường"
  },
  FeatureUnlock_140304_LockTip = {
    Text = "Mở khóa sau khi hoàn thành \"Hạt Giống Tình Yêu Bị Lãng Quên\"·Thường"
  },
  FeatureUnlock_140305_LockTip = {
    Text = "Chưa được mở"
  },
  FeatureUnlock_140473_FeatureName = {
    Text = "Cấm Kỵ Thí Luyện"
  },
  FeatureUnlock_140473_LockTip = {
    Text = "Mở khóa sau khi hoàn thành \"điều tra hành động\" 1-11·thông thường"
  },
  FeatureUnlock_141300_FeatureName = {
    Text = "Sự kiện Pontos"
  },
  FeatureUnlock_141301_LockTip = {
    Text = "<Posse:Mở khóa sau khi hoàn thành 「Điều Tra Hành Động」1-2·Phổ Thông>"
  },
  FeatureUnlock_141798_FeatureName = {
    Text = "Sự kiện Caraboo"
  },
  FeatureUnlock_143318_LockTip = {
    Text = "Chưa được mở"
  },
  FeatureUnlock_143319_LockTip = {
    Text = "Hoàn thành \"Epojans Vĩnh Cửu\"·Thường để mở khóa"
  },
  FeatureUnlock_145361_FeatureName = {
    Text = "Sự kiện Lotan: Ngư Thần"
  },
  FeatureUnlock_145362_LockTip = {
    Text = "<Posse:Mở khóa sau khi hoàn thành 「Điều Tra Hành Động」1-2·Phổ Thông>"
  },
  FeatureUnlock_146356_FeatureName = {
    Text = "\"Điều tra hành động\" Bài sao Chương 6"
  },
  FeatureUnlock_146356_LockTip = {
    Text = "Hoàn thành \"Điều tra hành động\" Bài sao Chương 5·Thường sau khi mở khóa"
  },
  FeatureUnlock_146356_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Điều tra hành động \"Khoảnh Khắc Tinh Tú Chính Vị·Đại Tiệc Trên Núi Tuyết\" đã mở>\n\n<FeatureUnlockDesc:Trên chiếc xe ô tô lắc lư, người giữ bí mật đã đến được Đại lục Bắc Tận ở độ cao bốn nghìn mét. Trên đỉnh núi tuyết mây mù bao phủ, một nghi lễ bí ẩn đang chờ đợi những người leo núi đến…>"
  },
  FeatureUnlock_146357_FeatureName = {
    Text = "\"Điều tra hành động\" Bài sao Chương 6 ·Khó"
  },
  FeatureUnlock_146357_LockTip = {
    Text = "Hoàn thành \"Điều tra hành động\" Bài sao Chương 5 · Khó và Chương 6·Thường sau khi mở khóa"
  },
  FeatureUnlock_146357_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Điều tra hành động \"Đại Tiệc Trên Núi Tuyết\"·Độ khó Khó đã mở>"
  },
  FeatureUnlock_147083_LockTip = {
    Text = "Hoàn thành \"Ngũ Nhật Đàm\"·Thường để mở khóa"
  },
  FeatureUnlock_147084_LockTip = {
    Text = "Chưa được mở"
  },
  FeatureUnlock_147085_LockTip = {
    Text = "<Posse:Mở khóa sau khi hoàn thành 「Điều Tra Hành Động」1-2·Phổ Thông>"
  },
  FeatureUnlock_147086_FeatureName = {
    Text = "Hoạt động nguồn gốc Orci"
  },
  FeatureUnlock_147392_LockTip = {
    Text = "<Posse:Mở khóa sau khi hoàn thành 「Điều Tra Hành Động」1-2·Phổ Thông>"
  },
  FeatureUnlock_147393_LockTip = {
    Text = "Chưa được mở"
  },
  FeatureUnlock_147394_LockTip = {
    Text = "Hoàn thành \"văn bản tạm thời\"·bình thường để mở khóa"
  },
  FeatureUnlock_147395_FeatureName = {
    Text = "Hoạt động Mộ Tinh·Tincture"
  },
  FeatureUnlock_147801_FeatureName = {
    Text = "Phân giải nguyên liệu"
  },
  FeatureUnlock_147801_LockTip = {
    Text = "Hoàn thành chương mở đầu để mở khóa"
  },
  FeatureUnlock_148487_FeatureName = {
    Text = "Tự Động Ghi Chép Khế Ước"
  },
  FeatureUnlock_148487_LockTip = {
    Text = "Điều tra cấp độ 45 được mở khóa"
  },
  FeatureUnlock_148488_FeatureName = {
    Text = "Kết hợp mật khế"
  },
  FeatureUnlock_148488_LockTip = {
    Text = "Cấp độ điều tra 60 mở khóa"
  },
  FeatureUnlock_148488_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Kết hợp mật khế đã mở>\n\n<FeatureUnlockDesc:Misaque đã giải mã từ các văn tịch cổ điển thuật thức kết hợp khắc mật khế vào linh nhân, có thể nâng cao đáng kể hiệu quả tăng cường của mật khế. Hãy thử xem nhé.\nKết hợp mật khế với thể thức tỉnh, nhận thêm thuộc tính chính bổ sung.>"
  },
  FeatureUnlock_16955_FeatureName = {
    Text = "Vật liệu tổng hợp"
  },
  FeatureUnlock_16955_LockTip = {
    Text = "Sau khi hoàn thành nhiệm vụ \"điều tra hành động\" 2-15·thông thường, tính năng sẽ được mở khóa"
  },
  FeatureUnlock_16956_LockTip = {
    Text = "Mở khóa sau khi hoàn thành chương mở đầu"
  },
  FeatureUnlock_16957_FeatureName = {
    Text = "Trích xuất nguồn lỏng"
  },
  FeatureUnlock_16957_LockTip = {
    Text = "Hoàn thành Chương mở đầu để mở khóa"
  },
  FeatureUnlock_16958_FeatureName = {
    Text = "\"điều tra hành động\" thứ2chương"
  },
  FeatureUnlock_16958_LockTip = {
    Text = "Sau khi mở khóa, hoàn thành \"điều tra hành động\" Chương 1·Phổ thông"
  },
  FeatureUnlock_16958_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Điều tra hành động 「Với tên sáp tượng」 đã mở>\n\n<FeatureUnlockDesc:Theo manh mối do Jenkin cung cấp, các bạn quyết định đến số 44 phố Southwark để tìm kiếm sự thật đằng sau bình tượng nến…>"
  },
  FeatureUnlock_16959_FeatureName = {
    Text = "\"điều tra hành động\" thứ3 chương"
  },
  FeatureUnlock_16959_LockTip = {
    Text = "Hoàn thành \"điều tra hành động\" Chương 2·Phổ thông sau khi mở khóa"
  },
  FeatureUnlock_16959_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Hoạt động điều tra 「Cẩn thận chó dữ」 đã được mở>\n\n<FeatureUnlockDesc:Theo dấu tin đồn về chó địa ngục 「Cerberus」, các điều tra viên của Misaque đã đến thị trấn Rai ở vùng ngoại ô Lentiennam, để tìm hiểu bí ẩn đằng sau các vụ mất tích…>"
  },
  FeatureUnlock_16960_FeatureName = {
    Text = "Thị trấn hỗn loạn"
  },
  FeatureUnlock_16960_LockTip = {
    Text = "Sau khi hoàn thành \"điều tra hành động\" Chương 3·Bình thường sẽ được mở khóa"
  },
  FeatureUnlock_16961_FeatureName = {
    Text = "Chuyến du siêu việt · Khe hở luân chuyển"
  },
  FeatureUnlock_16961_LockTip = {
    Text = "Hoàn thành siêu việt chiến dịch·khe hở Ⅷ được mở khóa"
  },
  FeatureUnlock_16962_FeatureName = {
    Text = "Chuyến du siêu việt · Khe hở luân chuyển"
  },
  FeatureUnlock_16962_LockTip = {
    Text = "Hoàn thành siêu việt chiến dịch·khe hở Ⅷ được mở khóa"
  },
  FeatureUnlock_16963_FeatureName = {
    Text = "Chuyến du siêu việt · Khe hở luân chuyển"
  },
  FeatureUnlock_16963_LockTip = {
    Text = "Hoàn thành siêu việt chiến dịch·khe hở Ⅷ được mở khóa"
  },
  FeatureUnlock_16964_FeatureName = {
    Text = "Dây xích đen tối"
  },
  FeatureUnlock_16964_LockTip = {
    Text = "Sau khi hoàn thành \"điều tra hành động\" Chương 3·Bình thường sẽ được mở khóa"
  },
  FeatureUnlock_16965_FeatureName = {
    Text = "Bí ẩn giải mã"
  },
  FeatureUnlock_16965_LockTip = {
    Text = "Cấp điều tra 25 mở khóa"
  },
  FeatureUnlock_16966_FeatureName = {
    Text = "Hướng dẫn"
  },
  FeatureUnlock_16966_LockTip = {
    Text = "Hoàn thành chương mở đầu để mở khóa"
  },
  FeatureUnlock_16967_FeatureName = {
    Text = "Phần mở đầu của cốt truyện chính"
  },
  FeatureUnlock_16968_FeatureName = {
    Text = "Cốt truyện chính"
  },
  FeatureUnlock_16969_FeatureName = {
    Text = "Dãy núi Hỗn loạn"
  },
  FeatureUnlock_16969_LockTip = {
    Text = "Sau khi hoàn thành Chương 4·Phổ thông của \"điều tra hành động\""
  },
  FeatureUnlock_16970_FeatureName = {
    Text = "Vùng đất vô ánh sáng"
  },
  FeatureUnlock_16970_LockTip = {
    Text = "Hoàn thành \"điều tra hành động\" 2-4·cơ bản để mở khóa"
  },
  FeatureUnlock_16970_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Vùng đất vô ánh sáng đã mở>\n\n<FeatureUnlockDesc:Trong thế giới đen tối, tìm kiếm sự thật.\nNgười giữ bí mật có thể cử các đội từ các giới vực khác nhau thách đấu, nhận được phần thưởng lớn.>"
  },
  FeatureUnlock_16971_FeatureName = {
    Text = "\"Hành Động Điều Tra\" Chương 5 · điên cuồng"
  },
  FeatureUnlock_16971_LockTip = {
    Text = "Xin hãy mong chờ"
  },
  FeatureUnlock_16971_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Điều tra hành động「Mắt Bão」· Độ khó điên cuồng đã mở khóa>"
  },
  FeatureUnlock_16972_FeatureName = {
    Text = "Giấc mơ thám hiểm"
  },
  FeatureUnlock_16972_LockTip = {
    Text = "Hoàn thành \"điều tra hành động\" 2-12·thông thường để mở khóa"
  },
  FeatureUnlock_16972_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Giấc mơ thám hiểm hiện đã mở>\n\n<FeatureUnlockDesc:Đó là giấc mơ cổ xưa của những tồn tại cao cấp. \nTrong quá trình lặn sâu, Người Giữ Gìn phải vượt qua áp lực cao từ cảm ứng tiêu cực. Mỗi ngày đều có những thử thách khác nhau đang chờ đợi.>"
  },
  FeatureUnlock_16973_FeatureName = {
    Text = "\"điều tra hành động\" Chương 3 điên cuồng"
  },
  FeatureUnlock_16973_LockTip = {
    Text = "Xin hãy mong chờ"
  },
  FeatureUnlock_16973_UnlockDesc = {
    Text = "<FeatureUnlockTitle:điều tra hành động 「Cẩn thận chó dữ」·độ khó điên cuồng đã được kích hoạt>"
  },
  FeatureUnlock_16977_FeatureName = {
    Text = "\"điều tra hành động\" Chương thứ 4"
  },
  FeatureUnlock_16977_LockTip = {
    Text = "Sau khi hoàn thành \"điều tra hành động\" Chương 3·Bình thường sẽ được mở khóa"
  },
  FeatureUnlock_16977_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Điều tra hành động「Tại nơi yên lặng」đã được mở>\n\n<FeatureUnlockDesc:Bệnh viện tinh thần Rai không phải là ngôi nhà hạnh phúc. Để lật tẩy lớp mặt nạ giả dối, điều tra viên buộc phải đi sâu vào đó……>"
  },
  FeatureUnlock_16978_FeatureName = {
    Text = "Bảo tàng sáp điên rồ"
  },
  FeatureUnlock_16978_LockTip = {
    Text = "Hoàn thành \"điều tra hành động\" Chương 2·Phổ thông sau khi mở khóa"
  },
  FeatureUnlock_16979_FeatureName = {
    Text = "\"điều tra hành động\" Chương thứ 5"
  },
  FeatureUnlock_16979_LockTip = {
    Text = "Sau khi hoàn thành Chương 4·Phổ thông của \"điều tra hành động\""
  },
  FeatureUnlock_16979_UnlockDesc = {
    Text = "<FeatureUnlockTitle:điều tra hành động 「Mắt Bão」 đã được mở>\n\n<FeatureUnlockDesc:Con tàu xa lạ, cô gái xa lạ, kẻ địch xa lạ. Trôi dạt giữa biển cả, các điều tra viên sẽ phải đối mặt với cuộc đấu tranh định mệnh……>"
  },
  FeatureUnlock_16980_FeatureName = {
    Text = "Nâng cấp bí ẩn"
  },
  FeatureUnlock_16980_LockTip = {
    Text = "Điều tra cấp 35 được mở"
  },
  FeatureUnlock_16980_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Chức năng nâng cấp Giao ước đã mở>\n\n<FeatureUnlockDesc:Giao ước không bao giờ hiện ra hình dạng thật của nó, bạn cần kiên nhẫn chờ đợi ngày nó hình thành. #nNgười giữ bí mật có thể nâng cấp Giao ước trên giao diện tăng cường Giao ước, từ đó nâng cao thuộc tính chính của Giao ước.>"
  },
  FeatureUnlock_16981_FeatureName = {
    Text = "Sự thông thạo giới vực"
  },
  FeatureUnlock_16981_LockTip = {
    Text = "Mở khóa sau khi hoàn thành \"điều tra hành động\" 1-5·phổ thông"
  },
  FeatureUnlock_16982_FeatureName = {
    Text = "Bí mật tượng nến"
  },
  FeatureUnlock_16982_LockTip = {
    Text = "Hoàn thành \"điều tra hành động\" 3-10·thường để mở khóa"
  },
  FeatureUnlock_16983_LockTip = {
    Text = "<Posse:Mở khóa sau khi hoàn thành 「Điều Tra Hành Động」1-2·Phổ Thông>"
  },
  FeatureUnlock_16984_FeatureName = {
    Text = "\"điều tra hành động\" Chương 6"
  },
  FeatureUnlock_16984_LockTip = {
    Text = "Sau khi hoàn thành \"điều tra hành động\" Chương 5·Phổ thông, sẽ được mở khóa"
  },
  FeatureUnlock_16984_UnlockDesc = {
    Text = "<FeatureUnlockTitle:điều tra hành động「sao sao đảo ngược」đã mở>\n\n<FeatureUnlockDesc:Con tàu Sơnaniel là hòn đảo Crete di động, nó mang theo hy vọng của tất cả mọi người bay tới bờ bên kia và tự do…>"
  },
  FeatureUnlock_16985_FeatureName = {
    Text = "Bản ghi cấm"
  },
  FeatureUnlock_16985_LockTip = {
    Text = "Cấp điều tra 25 mở khóa"
  },
  FeatureUnlock_16985_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Biên soạn cấm kỵ đã mở>\n\n<FeatureUnlockDesc:Trong thời đại tăm tối, những ký hiệu này bị cấm sao chép, chuyển ghi.\nTruy tìm nguồn gốc cấm kỵ, khám phá thêm nhiều bộ trang bị bí ẩn.>"
  },
  FeatureUnlock_16986_FeatureName = {
    Text = "\"điều tra hành động\" Chương 6: điên cuồng"
  },
  FeatureUnlock_16986_LockTip = {
    Text = "Xin hãy mong chờ"
  },
  FeatureUnlock_16986_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Hoạt động điều tra「bầu trời đảo ngược」· Độ khó điên cuồng đã mở>"
  },
  FeatureUnlock_16988_FeatureName = {
    Text = "Sarang Cacing"
  },
  FeatureUnlock_16988_LockTip = {
    Text = "Cấp điều tra 20 mở khóa"
  },
  FeatureUnlock_16989_FeatureName = {
    Text = "\"Điều tra hành động\" Chương 2 Điên cuồng"
  },
  FeatureUnlock_16989_LockTip = {
    Text = "Xin hãy mong chờ"
  },
  FeatureUnlock_16989_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Điều tra hành động 「Nhân danh bình tượng nến」· Độ khó điên cuồng đã mở khóa>"
  },
  FeatureUnlock_16990_FeatureName = {
    Text = "Vùng hỗn loạn · Khe hở vòng xoay"
  },
  FeatureUnlock_16990_LockTip = {
    Text = "Hoàn thành lĩnh vực hỗn loạn·khe hở VIII để mở khóa"
  },
  FeatureUnlock_16991_FeatureName = {
    Text = "Nhạc đệm"
  },
  FeatureUnlock_16991_LockTip = {
    Text = "Hoàn thành Điều tra Chương 1-9 chế độ Thường để mở khóa"
  },
  FeatureUnlock_16991_UnlockDesc = {
    Text = "<FeatureUnlockTitle:màn diễn tập đã mở>\n\n<FeatureUnlockDesc:thảm họa liên tục xảy ra, các người chỉ có thể lặn vào ảo mộng của thời đại cũ để khai thác những kỳ tích trong quá khứ.\nHãy đến quá khứ đã mất để thử thách bản thân và thu thập thêm tài liệu.>"
  },
  FeatureUnlock_16992_FeatureName = {
    Text = "Vùng hỗn loạn · Khe hở vòng xoay"
  },
  FeatureUnlock_16992_LockTip = {
    Text = "Hoàn thành lĩnh vực hỗn loạn·khe hở VIII để mở khóa"
  },
  FeatureUnlock_16993_LockTip = {
    Text = "Chưa được mở"
  },
  FeatureUnlock_16994_FeatureName = {
    Text = "Thành phố Sương Quái Dị"
  },
  FeatureUnlock_16994_LockTip = {
    Text = "Sau khi mở khóa, hoàn thành \"điều tra hành động\" Chương 1·Phổ thông"
  },
  FeatureUnlock_16996_FeatureName = {
    Text = "Grip Kesalehan"
  },
  FeatureUnlock_16996_LockTip = {
    Text = "Sau khi hoàn thành \"điều tra hành động\" Chương 5·Phổ thông, sẽ được mở khóa"
  },
  FeatureUnlock_16998_FeatureName = {
    Text = "Phế tích của Ponape"
  },
  FeatureUnlock_16998_LockTip = {
    Text = "Cấp điều tra 20 mở khóa"
  },
  FeatureUnlock_17000_FeatureName = {
    Text = "Nhật ký trưởng thành"
  },
  FeatureUnlock_17000_LockTip = {
    Text = "Mở khóa sau khi hoàn thành \"điều tra hành động\" 1-5·phổ thông"
  },
  FeatureUnlock_17001_FeatureName = {
    Text = "Đào tạo Bạo thực (Đang phát triển)"
  },
  FeatureUnlock_17001_LockTip = {
    Text = "Xin hãy mong chờ"
  },
  FeatureUnlock_17002_FeatureName = {
    Text = "Đổi Ngân Phiếu"
  },
  FeatureUnlock_17002_LockTip = {
    Text = "Hoàn thành Điều tra Chương 1-9 chế độ Thường để mở khóa"
  },
  FeatureUnlock_17003_FeatureName = {
    Text = "\"Điều tra hành động\" Chương 4 - Khó khăn"
  },
  FeatureUnlock_17003_LockTip = {
    Text = "Hoàn thành \"điều tra hành động\" chương 3·khó khăn và chương 4·bình thường để mở khóa"
  },
  FeatureUnlock_17003_UnlockDesc = {
    Text = "<FeatureUnlockTitle:điều tra hành động「trong im lặng」·khó khăn đã mở>"
  },
  FeatureUnlock_17004_FeatureName = {
    Text = "Họng Schwarzschild"
  },
  FeatureUnlock_17004_LockTip = {
    Text = "Cấp điều tra 20 mở khóa"
  },
  FeatureUnlock_17005_FeatureName = {
    Text = "Màn diễn tập (Đang phát triển)"
  },
  FeatureUnlock_17005_LockTip = {
    Text = "Xin hãy mong chờ"
  },
  FeatureUnlock_17006_FeatureName = {
    Text = "Residu hữu cơ"
  },
  FeatureUnlock_17006_LockTip = {
    Text = "Hoàn thành \"điều tra hành động\" 1-13·thông thường để mở khóa"
  },
  FeatureUnlock_17007_FeatureName = {
    Text = "Dư ảnh chiều"
  },
  FeatureUnlock_17007_LockTip = {
    Text = "Hoàn thành \"điều tra hành động\" 1-13·thông thường để mở khóa"
  },
  FeatureUnlock_17008_FeatureName = {
    Text = "Đề tài học kỳ"
  },
  FeatureUnlock_17008_LockTip = {
    Text = "Mở khóa sau khi hoàn thành \"điều tra hành động\" 1-11·thông thường"
  },
  FeatureUnlock_17008_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Đề tài học kỳ hiện đã mở>\n\n<FeatureUnlockDesc:Không ai có thể thoát khỏi áp lực học tập, Người Giữ Gìn cũng có kỳ thi cuối kỳ.\nHoàn thành thử huấn hàng ngày và hàng tuần tại mật cảnh lớp học, nâng cấp bậc đề tài và mở khóa nhiều phần thưởng đề tài hơn.>"
  },
  FeatureUnlock_17009_FeatureName = {
    Text = "Bùn lầy thịt máu·khe hở"
  },
  FeatureUnlock_17009_LockTip = {
    Text = "Hoàn thành \"điều tra hành động\" 2-4·cơ bản để mở khóa"
  },
  FeatureUnlock_17010_LockTip = {
    Text = "Sau khi hoàn thành \"Bóng ma thị trấn mưa\"·Bình thường sẽ được mở khóa"
  },
  FeatureUnlock_17011_FeatureName = {
    Text = "Bóng dáng bên ngoài giới hạn"
  },
  FeatureUnlock_17011_LockTip = {
    Text = "Sau khi hoàn thành Chương 4·Phổ thông của \"điều tra hành động\""
  },
  FeatureUnlock_17012_FeatureName = {
    Text = "Thư viện Bí điển"
  },
  FeatureUnlock_17012_LockTip = {
    Text = "Mở khóa sau khi hoàn thành chương mở đầu"
  },
  FeatureUnlock_17013_FeatureName = {
    Text = "Đổi đọng lại"
  },
  FeatureUnlock_17013_LockTip = {
    Text = "Hoàn thành chương mở đầu để mở khóa"
  },
  FeatureUnlock_17014_FeatureName = {
    Text = "Bản in lại bí ẩn"
  },
  FeatureUnlock_17014_LockTip = {
    Text = "Xin hãy mong chờ"
  },
  FeatureUnlock_17015_FeatureName = {
    Text = "Hoán tỉnh"
  },
  FeatureUnlock_17015_LockTip = {
    Text = "Hoàn thành chương mở đầu để mở khóa"
  },
  FeatureUnlock_17015_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Lễ thức đánh thức đã mở>\n\n<FeatureUnlockDesc:Có thể sử dụng 「Hạt Nhân Sạch Will」 và 「Hạt Nhân Lưu Minh」 để thu được thân thể được đánh thức và vòng mệnh. \nThông qua lễ thức đánh thức, người chơi còn có thể nhận được 「căn nguyên lắng đọng」, dùng để đổi vật liệu quý hiếm tại cửa hàng Misaq.>"
  },
  FeatureUnlock_17016_FeatureName = {
    Text = "Giả kim thuật"
  },
  FeatureUnlock_17016_LockTip = {
    Text = "Hoàn thành chương mở đầu để mở khóa"
  },
  FeatureUnlock_17017_FeatureName = {
    Text = "Residu Lãnh Cảm"
  },
  FeatureUnlock_17017_LockTip = {
    Text = "Hoàn thành \"điều tra hành động\" 1-13·thông thường để mở khóa"
  },
  FeatureUnlock_17017_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Phế tích Dung Thực: Tài liệu thăng cấp đã mở>\n\n<FeatureUnlockDesc:Hình ảnh còn sót lại của các cõi hiện lên trong Phế tích Dung Thực, hãy ghi lại chúng vào tài liệu trước khi tan biến.>"
  },
  FeatureUnlock_17018_FeatureName = {
    Text = "khởi linh"
  },
  FeatureUnlock_17019_LockTip = {
    Text = "Chưa được mở"
  },
  FeatureUnlock_17020_FeatureName = {
    Text = "duy thức tiềm hành"
  },
  FeatureUnlock_17020_LockTip = {
    Text = "Mở khóa sau khi hoàn thành chương mở đầu"
  },
  FeatureUnlock_17021_LockTip = {
    Text = "Hoàn thành \"Máu và Cát\"·Bình thường để mở khóa sau"
  },
  FeatureUnlock_17022_FeatureName = {
    Text = "Cựu sinh viên"
  },
  FeatureUnlock_17022_LockTip = {
    Text = "Mở khóa sau khi hoàn thành chương mở đầu"
  },
  FeatureUnlock_17023_FeatureName = {
    Text = "Mua bằng bạc tâm"
  },
  FeatureUnlock_17023_LockTip = {
    Text = "Hoàn thành chương mở đầu để mở khóa"
  },
  FeatureUnlock_17024_FeatureName = {
    Text = "Đổi Dung Châu"
  },
  FeatureUnlock_17024_LockTip = {
    Text = "Hoàn thành \"điều tra hành động\" 2-12·thông thường để mở khóa"
  },
  FeatureUnlock_17025_FeatureName = {
    Text = "\"Điều tra hành động\" Chương 2 · Khó"
  },
  FeatureUnlock_17025_LockTip = {
    Text = "Sau khi hoàn thành \"điều tra hành động\" 1-8·khó khăn, sẽ được mở khóa"
  },
  FeatureUnlock_17025_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Điều tra hành động 「Với tên bình tượng nến」· Khó đã được mở khóa>"
  },
  FeatureUnlock_17026_LockTip = {
    Text = "Điều tra cấp 35 được mở"
  },
  FeatureUnlock_17027_LockTip = {
    Text = "Cấp điều tra 25 mở khóa"
  },
  FeatureUnlock_17028_LockTip = {
    Text = "Điều tra cấp độ 45 được mở khóa"
  },
  FeatureUnlock_17029_LockTip = {
    Text = "Điều tra cấp độ 45 được mở khóa"
  },
  FeatureUnlock_17030_LockTip = {
    Text = "Điều tra cấp 35 được mở"
  },
  FeatureUnlock_17031_FeatureName = {
    Text = "Vùng hỗn loạn · Khe hở vòng xoay"
  },
  FeatureUnlock_17031_LockTip = {
    Text = "Hoàn thành lĩnh vực hỗn loạn·khe hở VIII để mở khóa"
  },
  FeatureUnlock_17032_LockTip = {
    Text = "Hoàn thành chương mở đầu để mở khóa"
  },
  FeatureUnlock_17033_FeatureName = {
    Text = "Biển Bão Ngoài"
  },
  FeatureUnlock_17033_LockTip = {
    Text = "Mở khóa sau khi hoàn thành \"điều tra hành động\" Chương 6·Phổ thông"
  },
  FeatureUnlock_17034_FeatureName = {Text = "Hộp thư"},
  FeatureUnlock_17034_LockTip = {
    Text = "Hoàn thành chương mở đầu để mở khóa"
  },
  FeatureUnlock_17035_FeatureName = {
    Text = "Cluster hỗn loạn"
  },
  FeatureUnlock_17035_LockTip = {
    Text = "Cấp điều tra 20 mở khóa"
  },
  FeatureUnlock_17035_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Phế tích Dung Thực·Tố liệu kỹ năng đã mở>\n\n<FeatureUnlockDesc:Chán ngấy với những thử thách tầm thường, lần này bạn sẽ lặn sâu vào tâm thức vượt qua vạn cổ…\nCó thể tận dụng đặc điểm của cõi, dễ dàng thu thập nguyên liệu cần thiết để nâng cấp kỹ năng của thể thức tỉnh.>"
  },
  FeatureUnlock_17036_FeatureName = {
    Text = "Hoạt động"
  },
  FeatureUnlock_17036_LockTip = {
    Text = "Hoàn thành Điều tra Chương 1-9 chế độ Thường để mở khóa"
  },
  FeatureUnlock_17036_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Hoạt động đã mở>\n\nNgười giữ gìn có thể nhận hàng hóa tham gia và hoạt động trò chơi ở đây, hoàn thành nhiệm vụ để nhận phần thưởng hấp dẫn!"
  },
  FeatureUnlock_17037_FeatureName = {
    Text = "Bản ghi đặc nhiệm"
  },
  FeatureUnlock_17037_LockTip = {
    Text = "Mở khóa sau khi hoàn thành chương mở đầu"
  },
  FeatureUnlock_17038_FeatureName = {
    Text = "\"Điều tra hành động\" Chương 5 - Khó khăn"
  },
  FeatureUnlock_17038_LockTip = {
    Text = "Hoàn thành \"điều tra hành động\" Chương 4·khó khăn và Chương 5·bình thường để được mở khóa"
  },
  FeatureUnlock_17038_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Điều tra hành động「Mắt Bão」· Khó khăn đã mở khóa>"
  },
  FeatureUnlock_17039_FeatureName = {
    Text = "Cáo ca của Thánh thai"
  },
  FeatureUnlock_17039_LockTip = {
    Text = "Mở khóa sau khi hoàn thành \"điều tra hành động\" Chương 6·Phổ thông"
  },
  FeatureUnlock_17040_FeatureName = {
    Text = "Hồ sơ học tịch"
  },
  FeatureUnlock_17040_LockTip = {
    Text = "Hoàn thành chương mở đầu để mở khóa"
  },
  FeatureUnlock_17041_FeatureName = {
    Text = "Phế tích Dung Thực"
  },
  FeatureUnlock_17041_LockTip = {
    Text = "Hoàn thành Điều tra Chương 1-9 chế độ Thường để mở khóa"
  },
  FeatureUnlock_17041_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Phân rã di tích: Tiến hành tìm kiếm vé/Chế tác thuốc đã mở>\n\n<FeatureUnlockDesc:Tìm kiếm di vật giữa những tàn tích phân rã, có thể đổi vé hoa hồng vàng hoặc chế tác thuốc tri thức tại văn phòng học vụ Mythag.>"
  },
  FeatureUnlock_17042_FeatureName = {Text = "Xã hội"},
  FeatureUnlock_17042_LockTip = {
    Text = "Xin hãy mong chờ"
  },
  FeatureUnlock_17043_FeatureName = {
    Text = "Chuyển ghi bí ẩn"
  },
  FeatureUnlock_17043_LockTip = {
    Text = "Điều tra cấp độ 45 được mở khóa"
  },
  FeatureUnlock_17043_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Chức năng chuyển ghi Giao ước đã mở>\n\n<FeatureUnlockDesc:Các người sao chép thời trung cổ từng bị xử án vì đã chuyển ghi Giao ước, may mắn thay bạn hiện đang sống trong một thời đại văn minh.\nNgười giữ bí mật có thể chọn loại và giá trị thuộc tính phụ khi chuyển ghi Giao ước trong quá trình tăng cường Giao ước.\nChuyển ghi không ảnh hưởng đến loại và giá trị thuộc tính chính của Giao ước.>"
  },
  FeatureUnlock_17044_FeatureName = {
    Text = "\"Điều tra hành động\" Chương 3 Khó khăn"
  },
  FeatureUnlock_17044_LockTip = {
    Text = "Mở khóa sau khi hoàn thành \"điều tra hành động\" 3-5·phổ thông và Chương 2·khó khăn"
  },
  FeatureUnlock_17044_UnlockDesc = {
    Text = "<FeatureUnlockTitle:điều tra hành động「Cẩn thận chó dữ」·khó khăn đã được mở>"
  },
  FeatureUnlock_17045_FeatureName = {
    Text = "Vòng mệnh phân giải"
  },
  FeatureUnlock_17045_LockTip = {
    Text = "Hoàn thành chương mở đầu để mở khóa"
  },
  FeatureUnlock_17046_FeatureName = {
    Text = "Báo cáo nhiệm vụ"
  },
  FeatureUnlock_17046_LockTip = {
    Text = "Mở khóa sau khi hoàn thành \"điều tra hành động\" 1-5·phổ thông"
  },
  FeatureUnlock_17047_FeatureName = {
    Text = "Dư ảnh đục"
  },
  FeatureUnlock_17047_LockTip = {
    Text = "Hoàn thành \"điều tra hành động\" 1-13·thông thường để mở khóa"
  },
  FeatureUnlock_17048_FeatureName = {
    Text = "Cửa hàng Gói Quà"
  },
  FeatureUnlock_17048_LockTip = {
    Text = "Mở khóa sau khi hoàn thành chương mở đầu"
  },
  FeatureUnlock_17049_FeatureName = {
    Text = "Bãi lầy thịt máu · khe hở luân hồi"
  },
  FeatureUnlock_17049_LockTip = {
    Text = "Thịt máu vũng lầy·khe hở Ⅷ hoàn thành để mở khóa"
  },
  FeatureUnlock_17050_FeatureName = {
    Text = "Bãi lầy thịt máu · khe hở luân hồi"
  },
  FeatureUnlock_17050_LockTip = {
    Text = "Thịt máu vũng lầy·khe hở Ⅷ hoàn thành để mở khóa"
  },
  FeatureUnlock_17051_FeatureName = {
    Text = "Bãi lầy thịt máu · khe hở luân hồi"
  },
  FeatureUnlock_17051_LockTip = {
    Text = "Thịt máu vũng lầy·khe hở Ⅷ hoàn thành để mở khóa"
  },
  FeatureUnlock_17052_LockTip = {
    Text = "<Posse:Mở khóa sau khi hoàn thành 「Điều Tra Hành Động」1-2·Phổ Thông>"
  },
  FeatureUnlock_17053_FeatureName = {
    Text = "Quy đổi Pha"
  },
  FeatureUnlock_17053_LockTip = {
    Text = "Mở khóa sau khi hoàn thành \"điều tra hành động\" 3-2·Phổ thông"
  },
  FeatureUnlock_17054_FeatureName = {
    Text = "đối đầu pha"
  },
  FeatureUnlock_17054_LockTip = {
    Text = "Mở khóa sau khi hoàn thành \"điều tra hành động\" 3-2·Phổ thông"
  },
  FeatureUnlock_17054_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Đối đầu pha hiện đã mở>\n\n<FeatureUnlockDesc:Khi các bạc tâm pha khác nhau bắt đầu tương tác và rối loạn, chúng sẽ quyết định ra người chiến thắng duy nhất.\nChế độ này là chế độ tặng kèm trong trò chơi, nhằm theo đuổi một môi trường trò chơi cân bằng và thú vị hơn, mỗi mùa thẻ bài và cách chơi tổng thể có thể xảy ra biến đổi lớn. Xin hãy cân nhắc kỹ lưỡng khi đầu tư tài nguyên cho chế độ này.>"
  },
  FeatureUnlock_17055_FeatureName = {
    Text = "Đổi nguyên liệu"
  },
  FeatureUnlock_17055_LockTip = {
    Text = "Hoàn thành \"điều tra hành động\" 3-10·thường để mở khóa"
  },
  FeatureUnlock_17056_FeatureName = {
    Text = "\"điều tra hành động\"· điên cuồng"
  },
  FeatureUnlock_17056_LockTip = {
    Text = "Xin hãy mong chờ"
  },
  FeatureUnlock_17056_UnlockDesc = {
    Text = "<FeatureUnlockTitle: 「điều tra hành động」·độ điên cuồng đã mở>"
  },
  FeatureUnlock_17057_LockTip = {
    Text = "Hoàn thành Điều tra Chương 1-9 chế độ Thường để mở khóa"
  },
  FeatureUnlock_17058_FeatureName = {
    Text = "Thành tựu"
  },
  FeatureUnlock_17058_LockTip = {
    Text = "Mở khóa sau khi hoàn thành \"điều tra hành động\" 1-5·phổ thông"
  },
  FeatureUnlock_17059_LockTip = {
    Text = "Hoàn thành Điều tra Chương 1-9 chế độ Thường để mở khóa"
  },
  FeatureUnlock_17060_FeatureName = {
    Text = "Di sản Biển Sâu · Khe hở Xoay chuyển"
  },
  FeatureUnlock_17060_LockTip = {
    Text = "Mở khóa sau khi hoàn thành Biển Sâu Di Tích · Khe Hở Ⅷ"
  },
  FeatureUnlock_17061_FeatureName = {
    Text = "Di sản Biển Sâu · Khe hở Xoay chuyển"
  },
  FeatureUnlock_17061_LockTip = {
    Text = "Mở khóa sau khi hoàn thành Biển Sâu Di Tích · Khe Hở Ⅷ"
  },
  FeatureUnlock_17062_FeatureName = {
    Text = "Di sản Biển Sâu · Khe hở Xoay chuyển"
  },
  FeatureUnlock_17062_LockTip = {
    Text = "Mở khóa sau khi hoàn thành Biển Sâu Di Tích · Khe Hở Ⅷ"
  },
  FeatureUnlock_17063_FeatureName = {
    Text = "Hành trình siêu việt·khe hở"
  },
  FeatureUnlock_17063_LockTip = {
    Text = "Hoàn thành \"điều tra hành động\" 2-4·cơ bản để mở khóa"
  },
  FeatureUnlock_17064_FeatureName = {
    Text = "\"điều tra hành động\" Chương 1"
  },
  FeatureUnlock_17065_FeatureName = {
    Text = "Di sản biển sâu, Khe hở"
  },
  FeatureUnlock_17065_LockTip = {
    Text = "Hoàn thành \"điều tra hành động\" 2-4·cơ bản để mở khóa"
  },
  FeatureUnlock_17066_FeatureName = {
    Text = "\"hành động điều tra\" Chương 4 · điên cuồng"
  },
  FeatureUnlock_17066_LockTip = {
    Text = "Xin hãy mong chờ"
  },
  FeatureUnlock_17066_UnlockDesc = {
    Text = "<FeatureUnlockTitle:điều tra hành động「trong im lặng sâu thẳm」·độ khó điên cuồng đã mở>"
  },
  FeatureUnlock_17067_FeatureName = {
    Text = "Hỗn Loạn · Khe Hở"
  },
  FeatureUnlock_17067_LockTip = {
    Text = "Hoàn thành \"điều tra hành động\" 2-4·cơ bản để mở khóa"
  },
  FeatureUnlock_17068_FeatureName = {
    Text = "\"điều tra hành động\" thứ1 Chương ·khó khăn"
  },
  FeatureUnlock_17068_LockTip = {
    Text = "Hoàn thành \"điều tra hành động\" 3-5·phổ thông để mở khóa"
  },
  FeatureUnlock_17069_FeatureName = {
    Text = "“điều tra hành động”·khó khăn"
  },
  FeatureUnlock_17069_LockTip = {
    Text = "Hoàn thành \"điều tra hành động\" 3-5·phổ thông để mở khóa"
  },
  FeatureUnlock_17069_UnlockDesc = {
    Text = "<FeatureUnlockTitle: 「điều tra hành động」· độ khó đã được mở>"
  },
  FeatureUnlock_17070_FeatureName = {
    Text = "\"điều tra hành động\" Chương 6 · Khó khăn"
  },
  FeatureUnlock_17070_LockTip = {
    Text = "Mở khóa sau khi hoàn thành \"điều tra hành động\" Chương 5·khó khăn và Chương 6·bình thường"
  },
  FeatureUnlock_17070_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Điều tra hành động「Sao sao đảo ngược」· Đã mở khóa độ khó>"
  },
  FeatureUnlock_17071_FeatureName = {
    Text = "Thuyền Biển Tối"
  },
  FeatureUnlock_17071_LockTip = {
    Text = "Sau khi hoàn thành \"điều tra hành động\" Chương 5·Phổ thông, sẽ được mở khóa"
  },
  FeatureUnlock_17072_FeatureName = {
    Text = "Nước mắt búp bê"
  },
  FeatureUnlock_17072_LockTip = {
    Text = "Hoàn thành \"điều tra hành động\" 3-10·thường để mở khóa"
  },
  FeatureUnlock_17073_FeatureName = {
    Text = "\"Điều tra hành động\" Chương 1 · Điên cuồng"
  },
  FeatureUnlock_17073_LockTip = {
    Text = "Xin hãy mong chờ"
  },
  FeatureUnlock_17074_FeatureName = {
    Text = "Vòng mệnh hai"
  },
  FeatureUnlock_17074_LockTip = {
    Text = "Sau khi đạt cấp độ điều tra 15, có thể trang bị vòng mệnh thứ hai"
  },
  FeatureUnlock_17074_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Vòng mệnh thứ hai đã mở>\n\n<FeatureUnlockDesc:Người giữ bí mật có thể trang bị vòng mệnh thứ hai cho thân thể được đánh thức trong giao diện vòng mệnh. Một thân thể được đánh thức tối đa chỉ có thể trang bị 1 vòng mệnh cấp SSR.\nKết hợp hợp lý có thể nâng cao khả năng của thân thể được đánh thức một cách đáng kể.>"
  },
  FeatureUnlock_17075_FeatureName = {Text = "phái đi"},
  FeatureUnlock_17075_LockTip = {
    Text = "Hoàn thành \"điều tra hành động\" 1-8·phổ thông để mở khóa"
  },
  FeatureUnlock_17075_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Nhiệm vụ được phái đi đã mở>\n\n<FeatureUnlockDesc:Nhiệm vụ nhỏ giữa điều tra và học tập.\nPhái thân thể được đánh thức thực hiện nhiệm vụ, nhận được bạc tâm và nhiều loại tài liệu.>"
  },
  FeatureUnlock_20225_LockTip = {
    Text = "Hoàn thành \"Cái chết của điêu khắc\"· Bình thường để mở khóa"
  },
  FeatureUnlock_20226_LockTip = {
    Text = "Chưa được mở"
  },
  FeatureUnlock_20227_LockTip = {
    Text = "<Posse:Mở khóa sau khi hoàn thành 「Điều Tra Hành Động」1-2·Phổ Thông>"
  },
  FeatureUnlock_20455_LockTip = {
    Text = "Sau khi mở khóa, hoàn thành \"mong ước của hiệp sĩ\"·bình thường"
  },
  FeatureUnlock_20456_LockTip = {
    Text = "<Posse:Mở khóa sau khi hoàn thành 「Điều Tra Hành Động」1-2·Phổ Thông>"
  },
  FeatureUnlock_20457_LockTip = {
    Text = "Chưa được mở"
  },
  FeatureUnlock_20458_LockTip = {
    Text = "Hoàn thành \"Lõi Xoắn\"·thường để mở khóa"
  },
  FeatureUnlock_20459_LockTip = {
    Text = "Chưa được mở"
  },
  FeatureUnlock_20460_LockTip = {
    Text = "<Posse:Mở khóa sau khi hoàn thành 「Điều Tra Hành Động」1-2·Phổ Thông>"
  },
  FeatureUnlock_20461_LockTip = {
    Text = "Hoàn thành \"Chúa tể tái nhợt\"·Thường để mở khóa"
  },
  FeatureUnlock_20462_LockTip = {
    Text = "Chưa được mở"
  },
  FeatureUnlock_20463_LockTip = {
    Text = "<Posse:Mở khóa sau khi hoàn thành 「Điều Tra Hành Động」1-2·Phổ Thông>"
  },
  FeatureUnlock_20785_FeatureName = {
    Text = "Điều tra đổi quà"
  },
  FeatureUnlock_20785_LockTip = {
    Text = "Mở khóa sau khi hoàn thành \"điều tra hành động\" 1-2 ·bình thường"
  },
  FeatureUnlock_20786_FeatureName = {
    Text = "Đổi Không Ánh Sáng"
  },
  FeatureUnlock_20786_LockTip = {
    Text = "Mở khóa sau khi hoàn thành \"điều tra hành động\" 2-4 ·phổ thông"
  },
  FeatureUnlock_21402_FeatureName = {
    Text = "Nhiệm vụ thường huấn"
  },
  FeatureUnlock_21452_FeatureName = {
    Text = "Sự tồn tại siêu việt"
  },
  FeatureUnlock_21452_LockTip = {
    Text = "Hoàn thành \"điều tra hành động\" 3-10·thường để mở khóa"
  },
  FeatureUnlock_21452_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Sự tồn tại siêu việt đã mở>\n\n<FeatureUnlockDesc:Chúng là những tồn tại cấm kỵ không tuân theo bất kỳ quy tắc và nhân quả nào.\nTiêu thụ Menophin để thực hiện thách thức, có thể nhận được vật liệu nâng cấp kỹ năng thân thể được đánh thức quý hiếm hơn.>"
  },
  FeatureUnlock_23667_FeatureName = {
    Text = "Chuyến du siêu việt · Khe hở luân chuyển"
  },
  FeatureUnlock_23667_LockTip = {
    Text = "Hoàn thành siêu việt chiến dịch·khe hở Ⅷ được mở khóa"
  },
  FeatureUnlock_23668_FeatureName = {
    Text = "Vùng hỗn loạn · Khe hở vòng xoay"
  },
  FeatureUnlock_23668_LockTip = {
    Text = "Hoàn thành lĩnh vực hỗn loạn·khe hở VIII để mở khóa"
  },
  FeatureUnlock_23669_FeatureName = {
    Text = "Bãi lầy thịt máu · khe hở luân hồi"
  },
  FeatureUnlock_23669_LockTip = {
    Text = "Thịt máu vũng lầy·khe hở Ⅷ hoàn thành để mở khóa"
  },
  FeatureUnlock_23670_FeatureName = {
    Text = "Di sản Biển Sâu · Khe hở Xoay chuyển"
  },
  FeatureUnlock_23670_LockTip = {
    Text = "Mở khóa sau khi hoàn thành Biển Sâu Di Tích · Khe Hở Ⅷ"
  },
  FeatureUnlock_23699_LockTip = {
    Text = "Hoàn thành \"Phép thuật của câu chuyện\"·Thường để mở khóa"
  },
  FeatureUnlock_23700_LockTip = {
    Text = "Chưa được mở"
  },
  FeatureUnlock_23701_LockTip = {
    Text = "<Posse:Mở khóa sau khi hoàn thành 「Điều Tra Hành Động」1-2·Phổ Thông>"
  },
  FeatureUnlock_24502_LockTip = {
    Text = "Hoàn thành \"Lời khen ngợi hoa hồng\"·Thường để mở khóa"
  },
  FeatureUnlock_24503_LockTip = {
    Text = "Chưa được mở"
  },
  FeatureUnlock_24504_LockTip = {
    Text = "<Posse:Mở khóa sau khi hoàn thành 「Điều Tra Hành Động」1-2·Phổ Thông>"
  },
  FeatureUnlock_25070_LockTip = {
    Text = "Hoàn thành \"chỉ một bước nữa\"·bình thường để mở khóa"
  },
  FeatureUnlock_25071_LockTip = {
    Text = "Chưa được mở"
  },
  FeatureUnlock_25072_LockTip = {
    Text = "<Posse:Mở khóa sau khi hoàn thành 「Điều Tra Hành Động」1-2·Phổ Thông>"
  },
  FeatureUnlock_25256_FeatureName = {
    Text = "Vùng cấm hòa hợp với thiên tai"
  },
  FeatureUnlock_25256_LockTip = {
    Text = "Hoàn thành \"điều tra hành động\" 4-3 ·Bình thường để kích hoạt"
  },
  FeatureUnlock_25256_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Vùng cấm hòa hợp với thiên tai đã mở>\n\n<FeatureUnlockDesc:Đi sâu vào khu vực bùng phát hòa hợp với thiên tai, gỡ bỏ cảnh báo khủng hoảng dòng lũ đen. #nNgười giữ bí mật có thể cử nhiều đội tham gia thách đấu, nhận được Nguyên thủy linh hạch, bạc tâm và đóng góp đen cùng nhiều phần thưởng hấp dẫn.>"
  },
  FeatureUnlock_35576_FeatureName = {
    Text = "Cửa hàng cốt truyện phép thuật"
  },
  FeatureUnlock_35576_LockTip = {
    Text = "Sau khi hoàn thành \"điều tra hành động\" 1-10 ·thông thường, sẽ được mở khóa"
  },
  FeatureUnlock_36165_LockTip = {
    Text = "<Posse:Mở khóa sau khi hoàn thành 「Điều Tra Hành Động」1-2·Phổ Thông>"
  },
  FeatureUnlock_36166_LockTip = {
    Text = "Hoàn thành \"Như Thường\"·Bình Thường sau để mở khóa"
  },
  FeatureUnlock_36167_LockTip = {
    Text = "Chưa được mở"
  },
  FeatureUnlock_36628_LockTip = {
    Text = "Chưa được mở"
  },
  FeatureUnlock_36629_LockTip = {
    Text = "Hoàn thành \"buổi tiệc bùng cháy\"·thường để mở khóa"
  },
  FeatureUnlock_36630_LockTip = {
    Text = "<Posse:Mở khóa sau khi hoàn thành 「Điều Tra Hành Động」1-2·Phổ Thông>"
  },
  FeatureUnlock_38850_FeatureName = {
    Text = "hòm báu kỳ diệu của Wanda"
  },
  FeatureUnlock_38850_LockTip = {
    Text = "Sau khi hoàn thành \"điều tra hành động\" 1-10 ·thông thường, sẽ được mở khóa"
  },
  FeatureUnlock_38851_FeatureName = {
    Text = "Thành phố trong hồ"
  },
  FeatureUnlock_43518_LockTip = {
    Text = "Chưa được mở"
  },
  FeatureUnlock_43519_LockTip = {
    Text = "Hoàn thành \"Sự sụp đổ của người khổng lồ\"·Thường để mở khóa"
  },
  FeatureUnlock_43520_LockTip = {
    Text = "<Posse:Mở khóa sau khi hoàn thành 「Điều Tra Hành Động」1-2·Phổ Thông>"
  },
  FeatureUnlock_44550_FeatureName = {Text = "Salvador"},
  FeatureUnlock_44568_LockTip = {
    Text = "Chưa được mở"
  },
  FeatureUnlock_44569_LockTip = {
    Text = "Hoàn thành \"màu của máu\"·bình thường để mở khóa"
  },
  FeatureUnlock_44570_LockTip = {
    Text = "<Posse:Mở khóa sau khi hoàn thành 「Điều Tra Hành Động」1-2·Phổ Thông>"
  },
  FeatureUnlock_44700_LockTip = {
    Text = "Hoàn thành \"Bản ghi đặc nhiệm: Màu máu\" sau khi hoàn thành \"Giết chóc vì ghen tị\"để mở khóa"
  },
  FeatureUnlock_44701_LockTip = {
    Text = "Sau khi hoàn thành \"Bản ghi đặc nhiệm:màu máu\", mở khóa \"Lấp đầy cơn đói\""
  },
  FeatureUnlock_44702_LockTip = {
    Text = "Hoàn thành \"Biểu tượng đẫm máu\" trong \"Bản ghi đặc nhiệm: Màu máu\"để mở khóa"
  },
  FeatureUnlock_44703_LockTip = {
    Text = "Hoàn thành \"Bản ghi đặc nhiệm:màu máu\"để mở khóa \"làm sạch tội lỗi\""
  },
  FeatureUnlock_44704_LockTip = {
    Text = "Trong \"Nhiệm vụ đặc biệt: Màu máu\", hoàn thành \"Hy vọng trắng bừng cháy\"để mở khóa"
  },
  FeatureUnlock_46186_LockTip = {
    Text = "<Posse:Mở khóa sau khi hoàn thành 「Điều Tra Hành Động」1-2·Phổ Thông>"
  },
  FeatureUnlock_46187_LockTip = {
    Text = "Hoàn thành \"Sự chia đôi yên bình\"·Thường để mở khóa"
  },
  FeatureUnlock_46188_LockTip = {
    Text = "Chưa được mở"
  },
  FeatureUnlock_47456_FeatureName = {
    Text = "Chữa lành nhiều lần"
  },
  FeatureUnlock_47457_LockTip = {
    Text = "Hoàn thành \"Nguồn\" trong \"Bản ghi đặc nhiệm: Sự chia đôi yên bình\"để mở khóa"
  },
  FeatureUnlock_47458_LockTip = {
    Text = "Hoàn thành \"Chỉ huy ghi chép: Sự chia đôi yên bình\" trong \"Dừng lại ở đây\" sau khi mở khóa"
  },
  FeatureUnlock_47459_LockTip = {
    Text = "Hoàn thành \"Ghi chép đặc nhiệm: Sự chia đôi của sự tĩnh lặng\" sau khi hoàn thành \"Fugue Vàng\"để mở khóa"
  },
  FeatureUnlock_47460_LockTip = {
    Text = "Hoàn thành \"Nhật ký đặc nhiệm: Sự chia đôi của sự tĩnh lặng\" sau khi hoàn thành \"Rắn mất ngủ\"để mở khóa"
  },
  FeatureUnlock_47461_LockTip = {
    Text = "Hoàn thành \"Đặc nhiệm ghi chép: Sự chia đôi của sự tĩnh lặng\" sau khi hoàn thành \"Bóng tối đồng thoại\"để mở khóa"
  },
  FeatureUnlock_48920_FeatureName = {
    Text = "\"điều tra hành động\" Chương 7"
  },
  FeatureUnlock_48920_LockTip = {
    Text = "Mở khóa sau khi hoàn thành \"điều tra hành động\" Chương 6·Phổ thông"
  },
  FeatureUnlock_48920_UnlockDesc = {
    Text = "<FeatureUnlockTitle:điều tra hành động 「Yù Hé」đã mở>\n\n<FeatureUnlockDesc:Sông thiêng liêng Karage ở phía bắc Lemvahi, nuôi dưỡng dòng chảy quá khứ và tương lai của dân du mục Aran…>"
  },
  FeatureUnlock_48921_FeatureName = {
    Text = "\"Điều tra hành động\" Chương 7·Khó khăn"
  },
  FeatureUnlock_48921_LockTip = {
    Text = "Hoàn thành \"điều tra hành động\" Chương 6(khó khăn) và Chương 7(bình thường) để mở khóa"
  },
  FeatureUnlock_48921_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Điều tra hành động「Dục Hà」· Mức độ khó đã được mở>"
  },
  FeatureUnlock_48922_FeatureName = {
    Text = "\"điều tra hành động\" Chương 7 · điên cuồng"
  },
  FeatureUnlock_48922_LockTip = {
    Text = "Xin hãy mong chờ"
  },
  FeatureUnlock_48922_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Điều tra hành động「Dục Hà」· Độ khó Điên cuồng đã mở khóa>"
  },
  FeatureUnlock_49170_FeatureName = {
    Text = "Di sản sa mạc"
  },
  FeatureUnlock_49170_LockTip = {
    Text = "Hoàn thành \"điều tra hành động\" Chương 7·Phổ thông để mở khóa"
  },
  FeatureUnlock_49171_FeatureName = {
    Text = "Bức tường sa mạc"
  },
  FeatureUnlock_49171_LockTip = {
    Text = "Hoàn thành \"điều tra hành động\" Chương 7·Phổ thông để mở khóa"
  },
  FeatureUnlock_49205_FeatureName = {
    Text = "Thân thể được đánh thức demo"
  },
  FeatureUnlock_49205_LockTip = {
    Text = "Mở khóa sau khi hoàn thành chương mở đầu"
  },
  FeatureUnlock_49296_FeatureName = {
    Text = "vòng mệnh"
  },
  FeatureUnlock_49296_LockTip = {
    Text = "Hiện chưa có bộ sưu tập nào liên quan"
  },
  FeatureUnlock_49298_FeatureName = {
    Text = "Sự kiện"
  },
  FeatureUnlock_49298_LockTip = {
    Text = "Hiện chưa có bộ sưu tập nào liên quan"
  },
  FeatureUnlock_49300_FeatureName = {
    Text = "Cốt truyện CG (hoạt hình máy tính)"
  },
  FeatureUnlock_49300_LockTip = {
    Text = "Hiện chưa có bộ sưu tập nào liên quan"
  },
  FeatureUnlock_49301_FeatureName = {Text = "đĩa than"},
  FeatureUnlock_49301_LockTip = {
    Text = "Hiện chưa có bộ sưu tập nào liên quan"
  },
  FeatureUnlock_49302_FeatureName = {
    Text = "Hình ảnh"
  },
  FeatureUnlock_49302_LockTip = {
    Text = "Hiện chưa có bộ sưu tập nào liên quan"
  },
  FeatureUnlock_49303_FeatureName = {
    Text = "Thế giới bồi tích"
  },
  FeatureUnlock_49303_LockTip = {
    Text = "Hiện chưa có bộ sưu tập nào liên quan"
  },
  FeatureUnlock_49304_FeatureName = {
    Text = "Nhân vật"
  },
  FeatureUnlock_49304_LockTip = {
    Text = "Hiện chưa có bộ sưu tập nào liên quan"
  },
  FeatureUnlock_49305_FeatureName = {
    Text = "Giao ước"
  },
  FeatureUnlock_49305_LockTip = {
    Text = "Hiện chưa có bộ sưu tập nào liên quan"
  },
  FeatureUnlock_49306_FeatureName = {
    Text = "Cấm kinh Hồng Tích"
  },
  FeatureUnlock_49306_LockTip = {
    Text = "Hiện chưa có bộ sưu tập nào liên quan"
  },
  FeatureUnlock_49307_FeatureName = {
    Text = "Tổ chức"
  },
  FeatureUnlock_49307_LockTip = {
    Text = "Hiện chưa có bộ sưu tập nào liên quan"
  },
  FeatureUnlock_49308_FeatureName = {Text = "CG cảnh"},
  FeatureUnlock_49308_LockTip = {
    Text = "Hiện chưa có bộ sưu tập nào liên quan"
  },
  FeatureUnlock_49309_FeatureName = {
    Text = "Biên niên sử"
  },
  FeatureUnlock_49309_LockTip = {
    Text = "Hiện chưa có bộ sưu tập nào liên quan"
  },
  FeatureUnlock_49310_FeatureName = {Text = "Di vật"},
  FeatureUnlock_49310_LockTip = {
    Text = "Hiện chưa có bộ sưu tập nào liên quan"
  },
  FeatureUnlock_49311_LockTip = {
    Text = "Hiện chưa có bộ sưu tập nào liên quan"
  },
  FeatureUnlock_49418_FeatureName = {
    Text = "Loại nhiệm vụ phổ thông"
  },
  FeatureUnlock_49418_LockTip = {
    Text = "Mở khóa sau khi hoàn thành chương mở đầu"
  },
  FeatureUnlock_49567_FeatureName = {
    Text = "Sự cuồng nhiệt sinh sản"
  },
  FeatureUnlock_49567_LockTip = {
    Text = "Sau khi hoàn thành \"điều tra hành động\" 7-3·phổ thông, sẽ mở khóa"
  },
  FeatureUnlock_49567_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Phát triển cuồng nhiệt đã được kích hoạt>\n\n<FeatureUnlockDesc:Bị ảnh hưởng bởi lực lượng huyền bí, các thân thể được đánh thức đã lâm vào trạng thái 「phát triển cuồng nhiệt」… Xin hãy cẩn thận, các Người Giữ Gìn!>"
  },
  FeatureUnlock_50092_FeatureName = {
    Text = "Sóng Dục Vọng"
  },
  FeatureUnlock_51255_FeatureName = {
    Text = "Câu chuyện phép thuật·bản sao ánh sáng"
  },
  FeatureUnlock_51256_LockTip = {
    Text = "Hoàn thành \"Lực lượng của Andy Johnson\" trong \"Bản ghi đặc nhiệm: Ma thuật của câu chuyện\"để mở khóa"
  },
  FeatureUnlock_51257_LockTip = {
    Text = "Hoàn thành \"Tìm kiếm câu chuyện\" trong \"Phái đoàn ghi chép: Phép thuật của câu chuyện\"để mở khóa"
  },
  FeatureUnlock_51258_LockTip = {
    Text = "Hoàn thành \"Bản ghi đặc nhiệm: Phép thuật của câu chuyện\" sau khi hoàn thành \"Sự rộng lượng của thương nhân\"để mở khóa"
  },
  FeatureUnlock_51259_LockTip = {
    Text = "Hoàn thành \"Bản ghi đặc nhiệm: câu chuyện của phép thuật\"để mở khóa \"Người được nhớ nhất\""
  },
  FeatureUnlock_51260_LockTip = {
    Text = "Hoàn thành \"Phái đặc vụ: Ma thuật của câu chuyện\" sau khi hoàn thành \"Bông hoa tốt nhất\"để mở khóa"
  },
  FeatureUnlock_51261_LockTip = {
    Text = "Sau khi hoàn thành \"Bản ghi Đặc vụ: Ma thuật của câu chuyện\" và đạt được \"Kết thúc viên mãn nhất\"để mở khóa"
  },
  FeatureUnlock_51262_LockTip = {
    Text = "Hoàn thành \"Phái đặc nhiệm: Ma thuật của câu chuyện\" sau khi hoàn thành \"Vista huy hoàng nhất\"để mở khóa"
  },
  FeatureUnlock_51263_LockTip = {
    Text = "Sau khi hoàn thành \"Bản ghi Đặc vụ: Ma thuật của câu chuyện\" và đạt được \"Kết thúc viên mãn nhất\"để mở khóa"
  },
  FeatureUnlock_51264_LockTip = {
    Text = "Sau khi hoàn thành \"Bản ghi Đặc vụ: Ma thuật của câu chuyện\" và đạt được \"Kết thúc viên mãn nhất\"để mở khóa"
  },
  FeatureUnlock_51757_FeatureName = {
    Text = "Thế giới Mộng Ảo"
  },
  FeatureUnlock_51757_LockTip = {
    Text = "Mở khóa sau khi hoàn thành chương mở đầu"
  },
  FeatureUnlock_51759_LockTip = {
    Text = "<Posse:Mở khóa sau khi hoàn thành 「Điều Tra Hành Động」1-2·Phổ Thông>"
  },
  FeatureUnlock_54118_FeatureName = {
    Text = "Với cuốn sách hồng"
  },
  FeatureUnlock_55456_FeatureName = {
    Text = "Trước khi khu vườn úa tàn"
  },
  FeatureUnlock_55458_LockTip = {
    Text = "<Posse:Mở khóa sau khi hoàn thành 「Điều Tra Hành Động」1-2·Phổ Thông>"
  },
  FeatureUnlock_55459_LockTip = {
    Text = "Hoàn thành \"Nơi trú ngụ của hoa hồng\"·Thường để mở khóa"
  },
  FeatureUnlock_55460_LockTip = {
    Text = "Chưa được mở"
  },
  FeatureUnlock_57707_LockTip = {
    Text = "Chưa được mở"
  },
  FeatureUnlock_57708_LockTip = {
    Text = "Hoàn thành \"Chúc bạn săn bắn vui vẻ!\"·Bình thường để mở khóa"
  },
  FeatureUnlock_57709_LockTip = {
    Text = "<Posse:Mở khóa sau khi hoàn thành 「Điều Tra Hành Động」1-2·Phổ Thông>"
  },
  FeatureUnlock_57710_LockTip = {
    Text = "Chưa được mở"
  },
  FeatureUnlock_57712_LockTip = {
    Text = "Hoàn thành \"Người trở về của Elworth\"·Thường để mở khóa"
  },
  FeatureUnlock_57714_LockTip = {
    Text = "<Posse:Mở khóa sau khi hoàn thành 「Điều Tra Hành Động」1-2·Phổ Thông>"
  },
  FeatureUnlock_58025_FeatureName = {
    Text = "Hoạt động Muphí"
  },
  FeatureUnlock_58026_FeatureName = {
    Text = "Sự kiện tái hiện Miriam"
  },
  FeatureUnlock_58027_FeatureName = {
    Text = "Hoạt động tái bản Salvador"
  },
  FeatureUnlock_58028_FeatureName = {
    Text = "Hoạt động Bản Nguyên Đóa"
  },
  FeatureUnlock_58029_FeatureName = {
    Text = "Hoạt động nguồn gốc Hiro"
  },
  FeatureUnlock_58030_FeatureName = {
    Text = "Hoạt động Tà Vy"
  },
  FeatureUnlock_58031_FeatureName = {
    Text = "Hoạt động Hamlin"
  },
  FeatureUnlock_58032_FeatureName = {
    Text = "Lắc sự kiện"
  },
  FeatureUnlock_58033_FeatureName = {
    Text = "Sự kiện tái hiện đặc biệt Vanda"
  },
  FeatureUnlock_58034_FeatureName = {
    Text = "24 hoạt động tái bản"
  },
  FeatureUnlock_58907_FeatureName = {
    Text = "\"Điều tra hành động\" thứ8chương"
  },
  FeatureUnlock_58907_LockTip = {
    Text = "Hoàn thành \"điều tra hành động\" Chương 7·Phổ thông để mở khóa"
  },
  FeatureUnlock_58907_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Điều tra hành động 「Bản giao hưởng cuối cùng」 đã mở>\n\n<FeatureUnlockDesc:Bước vào. Ngồi yên. Chờ đợi. Khát khao.\nDải chỉ huy nhẹ nhàng nâng lên. Bạn đã sẵn sàng, lắng nghe bí mật sâu kín nhất của vũ trụ chưa?>"
  },
  FeatureUnlock_58908_FeatureName = {
    Text = "\"điều tra hành động\" Chương cuối cùng"
  },
  FeatureUnlock_58908_LockTip = {
    Text = "Sau khi mở khóa, hoàn thành \"điều tra hành động\" Chương 8·Phổ thông"
  },
  FeatureUnlock_58908_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Điều tra hành động 「Khi giấc mơ dài kết thúc」 đã mở>\n\n<FeatureUnlockDesc:Ngài ấy đã có một giấc mơ dài. \nNgài ấy mơ thấy thần và các vì sao, mơ thấy bụi bặm hóa thành văn minh, văn minh lại hóa thành bụi bặm. \nNgài ấy mơ thấy hận và yêu, mơ thấy vui sướng và sợ hãi. \nNgài ấy tỉnh dậy từ giấc mơ. Mọi thứ trong giấc mơ, chưa từng tồn tại.>"
  },
  FeatureUnlock_58909_FeatureName = {
    Text = "\"Điều tra hành động\" Chương kết · khó khăn"
  },
  FeatureUnlock_58909_LockTip = {
    Text = "Sau khi mở khóa, hoàn thành \"điều tra hành động\" Chương 8·khó khăn và Chương 9·bình thường"
  },
  FeatureUnlock_58909_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Điều tra hành động「Giấc mơ dài kết thúc」· Độ khó khăn đã mở>"
  },
  FeatureUnlock_58911_FeatureName = {
    Text = "\"Điều tra hành động\" Chương 8 · Khó"
  },
  FeatureUnlock_58911_LockTip = {
    Text = "Sau khi hoàn thành \"điều tra hành động\" Chương 7·khó khăn và Chương 8·bình thường sẽ mở khóa"
  },
  FeatureUnlock_58911_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Điều tra hành động「Bản giao hưởng cuối cùng」· Độ khó đã mở>"
  },
  FeatureUnlock_58912_FeatureName = {
    Text = "\"Điều tra hành động\" Chương 8 · Điên cuồng"
  },
  FeatureUnlock_58912_LockTip = {
    Text = "Xin hãy mong chờ"
  },
  FeatureUnlock_58912_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Hoạt động điều tra「Bản giao hưởng cuối cùng」· Độ khó điên cuồng đã mở>"
  },
  FeatureUnlock_58913_FeatureName = {
    Text = "Khe nứt Nguyên thủy"
  },
  FeatureUnlock_58913_LockTip = {
    Text = "Sau khi mở khóa, hoàn thành \"điều tra hành động\" Chương 8·Phổ thông"
  },
  FeatureUnlock_58914_FeatureName = {
    Text = "Dòng thủy hồ đen"
  },
  FeatureUnlock_58914_LockTip = {
    Text = "Sau khi mở khóa, hoàn thành \"điều tra hành động\" Chương 8·Phổ thông"
  },
  FeatureUnlock_58915_FeatureName = {
    Text = "\"Điều Tra Hành Động\" Chương cuối · điên cuồng"
  },
  FeatureUnlock_58915_LockTip = {
    Text = "Xin hãy mong chờ"
  },
  FeatureUnlock_58915_UnlockDesc = {
    Text = "<FeatureUnlockTitle:điều tra hành động「Kết thúc Giấc Mơ Dài」·độ khó điên cuồng đã được mở khóa>"
  },
  FeatureUnlock_60580_FeatureName = {
    Text = "Truyền thông bạc tâm"
  },
  FeatureUnlock_60580_LockTip = {
    Text = "Hoàn thành \"điều tra hành động\" 2-1·bình thường để mở khóa"
  },
  FeatureUnlock_60580_UnlockDesc = {
    Text = "<FeatureUnlockTitle:bạc tâm thông đã mở>\n\n<FeatureUnlockDesc:đồng minh, đồng đội, bạn thân, lắc hộp kỳ diệu để kết nối với họ nhé.>"
  },
  FeatureUnlock_68887_FeatureName = {
    Text = "Hoạt động của Clementine"
  },
  FeatureUnlock_68888_FeatureName = {
    Text = "Sự kiện nguồn gốc tulô"
  },
  FeatureUnlock_68889_FeatureName = {
    Text = "Hoạt động tulô"
  },
  FeatureUnlock_68890_FeatureName = {
    Text = "Hoạt động Muphí nguồn gốc"
  },
  FeatureUnlock_68891_FeatureName = {
    Text = "Hoạt động Đào Đen Đá"
  },
  FeatureUnlock_68892_FeatureName = {
    Text = "Hoạt động Mordiggian"
  },
  FeatureUnlock_68893_FeatureName = {
    Text = "Hoạt động Rulim"
  },
  FeatureUnlock_68894_FeatureName = {
    Text = "Sự kiện Antlak"
  },
  FeatureUnlock_70556_FeatureName = {
    Text = "Hoạt động"
  },
  FeatureUnlock_70556_LockTip = {
    Text = "Hiện chưa có bộ sưu tập nào liên quan"
  },
  FeatureUnlock_71851_LockTip = {
    Text = "<Posse:Mở khóa sau khi hoàn thành 「Điều Tra Hành Động」1-2·Phổ Thông>"
  },
  FeatureUnlock_72031_FeatureName = {
    Text = "\"điều tra hành động\" Chương 1: Vì sao"
  },
  FeatureUnlock_72031_LockTip = {
    Text = "Mở khóa sau khi hoàn thành \"điều tra hành động\" Chương 9·Phổ thông"
  },
  FeatureUnlock_72031_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Điều tra hành động 「Thời khắc chính vị sao · Trở lại sương đô」 đã mở>\n\n<FeatureUnlockDesc:Giữa hơi thở, bụi bặm nổi lên, mặt trời héo úa khó có thể chiếu thấu>"
  },
  FeatureUnlock_72035_FeatureName = {
    Text = "Hoàn thành cốt truyện Chương Quên Lãng"
  },
  FeatureUnlock_72035_LockTip = {
    Text = "Hoàn thành \"điều tra hành động\" Chương 9·Thường sau đó quay lại giao diện chính để phát"
  },
  FeatureUnlock_72076_FeatureName = {
    Text = "\"Điều tra hành động\" Chương 1 Sao Băng ·khó khăn"
  },
  FeatureUnlock_72076_LockTip = {
    Text = "Sau khi hoàn thành \"điều tra hành động\" Chòm sao chương 1·Phổ thông sẽ được mở khóa"
  },
  FeatureUnlock_72076_UnlockDesc = {
    Text = "<FeatureUnlockTitle:điều tra hành động「Trở lại Thành phố Sương」·khó khăn đã mở>"
  },
  FeatureUnlock_73800_FeatureName = {
    Text = "Sự kiện tái hiện Muphí"
  },
  FeatureUnlock_74239_LockTip = {
    Text = "Hoàn thành \"Nhiệt tình quy trần\"·Bình thường để mở khóa"
  },
  FeatureUnlock_74240_LockTip = {
    Text = "Chưa được mở"
  },
  FeatureUnlock_74241_LockTip = {
    Text = "<Posse:Mở khóa sau khi hoàn thành 「Điều Tra Hành Động」1-2·Phổ Thông>"
  },
  FeatureUnlock_74337_FeatureName = {
    Text = "Hoạt động vòng ngược"
  },
  FeatureUnlock_74341_LockTip = {
    Text = "<Posse:Mở khóa sau khi hoàn thành 「Điều Tra Hành Động」1-2·Phổ Thông>"
  },
  FeatureUnlock_74348_FeatureName = {
    Text = "Hoạt động tái bản Salvador"
  },
  FeatureUnlock_74362_FeatureName = {
    Text = "Sự kiện tái bản Lắc"
  },
  FeatureUnlock_75909_FeatureName = {
    Text = "Kịch phát thanh"
  },
  FeatureUnlock_75909_LockTip = {
    Text = "Hiện chưa có bộ sưu tập nào liên quan"
  },
  FeatureUnlock_78650_FeatureName = {
    Text = "24 hoạt động tái bản"
  },
  FeatureUnlock_78734_FeatureName = {
    Text = "Kết nối đa chiều"
  },
  FeatureUnlock_78734_LockTip = {
    Text = "Mở khóa sau khi hoàn thành chương mở đầu"
  },
  FeatureUnlock_78793_FeatureName = {
    Text = "Hoạt động nguồn gốc Hiro"
  },
  FeatureUnlock_79686_FeatureName = {
    Text = "Trang phục của thân thể thức tỉnh"
  },
  FeatureUnlock_79686_LockTip = {
    Text = "Hoàn thành chương mở đầu để mở khóa"
  },
  FeatureUnlock_80156_LockTip = {
    Text = "Hoàn thành \"điều tra hành động\" 1-9·phổ thông để mở khóa"
  },
  FeatureUnlock_80317_FeatureName = {
    Text = "\"Hoạt động điều tra\" Chương 2 của sao ·Khó khăn"
  },
  FeatureUnlock_80317_LockTip = {
    Text = "Hoàn thành chương 1 · Khó khăn và chương 2 · Bình thường của hoạt động \"Điều tra\" tinh tú mới mở khóa"
  },
  FeatureUnlock_80317_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Hành Động Điều Tra「Biến Hình」Độ Khó Cao Đã Mở Khóa>"
  },
  FeatureUnlock_80318_FeatureName = {
    Text = "\"Hoạt động điều tra\" Chương 2 của sao"
  },
  FeatureUnlock_80318_LockTip = {
    Text = "Sau khi hoàn thành \"điều tra hành động\" Chòm sao chương 1·Phổ thông sẽ được mở khóa"
  },
  FeatureUnlock_80318_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Hành Động Điều Tra「Giây Phút Định Vị Chân Trời·Biến Hình」Đã Mở Khóa>\n\n<FeatureUnlockDesc:Theo dấu hình bóng quen thuộc màu vàng, Người giữ gìn đã đến một bệnh viện dưỡng lão không xác định. Nơi đây, ẩn chứa vô số bí mật và linh hồn tan vỡ.>"
  },
  FeatureUnlock_83813_LockTip = {
    Text = "Hoàn thành Điều tra Chương 1-9 chế độ Thường để mở khóa"
  },
  FeatureUnlock_84307_FeatureName = {
    Text = "Cỏ Sanga hoạt động"
  },
  FeatureUnlock_84356_LockTip = {
    Text = "<Posse:Mở khóa sau khi hoàn thành 「Điều Tra Hành Động」1-2·Phổ Thông>"
  },
  FeatureUnlock_88941_LockTip = {
    Text = "<Posse:Mở khóa sau khi hoàn thành 「Điều Tra Hành Động」1-2·Phổ Thông>"
  },
  FeatureUnlock_88942_FeatureName = {
    Text = "Hoạt động của Cas Tor"
  },
  FeatureUnlock_89531_FeatureName = {
    Text = "Cửa hàng thời trang"
  },
  FeatureUnlock_89531_LockTip = {
    Text = "Mở khóa sau khi hoàn thành chương mở đầu"
  },
  FeatureUnlock_90492_LockTip = {
    Text = "Hoàn thành Điều tra Chương 1-9 chế độ Thường để mở khóa"
  },
  FeatureUnlock_91201_FeatureName = {
    Text = "Mã mời bạn bè"
  },
  FeatureUnlock_91201_LockTip = {
    Text = "Hoàn thành chương mở đầu để mở khóa"
  },
  FeatureUnlock_91202_FeatureName = {
    Text = "\"Hoạt động điều tra\" Chương 3 của sao"
  },
  FeatureUnlock_91202_LockTip = {
    Text = "Hoàn thành chương 2 của cuộc hành trình điều tra - Chương tinh tú bình thường thì sẽ mở khóa"
  },
  FeatureUnlock_91202_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Hoạt động điều tra「Thời khắc vị trí sao」đã mở>\n\n<FeatureUnlockDesc:Đi qua sương mù nghĩa trang, thành phố vĩ đại hạ xuống trước mặt bạn.\nVị vua xác sống đang kiên nhẫn chờ đợi, chờ bạn tham gia bữa tiệc của hắn.>"
  },
  FeatureUnlock_91203_FeatureName = {
    Text = "\"Hoạt động điều tra\" Chương 3 của sao · Khó khăn"
  },
  FeatureUnlock_91203_LockTip = {
    Text = "Hoàn thành chương 2 của cuộc hành trình điều tra - Chương tinh tú khó khăn và chương 3 bình thường thì sẽ mở khóa"
  },
  FeatureUnlock_91203_UnlockDesc = {
    Text = "<FeatureUnlockTitle:Hoạt động điều tra「Tiệc đường ngọc」·Đã mở độ khó>"
  },
  FeatureUnlock_91238_LockTip = {
    Text = "<Posse:Mở khóa sau khi hoàn thành 「Điều Tra Hành Động」1-2·Phổ Thông>"
  },
  FeatureUnlock_91239_FeatureName = {
    Text = "Sự kiện Roma"
  },
  FeatureUnlock_94856_FeatureName = {
    Text = "Sự kiện mùa hè đặc biệt·Phần đầu"
  },
  FeatureUnlock_94857_LockTip = {
    Text = "<Posse:Mở khóa sau khi hoàn thành 「Điều Tra Hành Động」1-2·Phổ Thông>"
  },
  FeatureUnlock_95783_FeatureName = {
    Text = "Hoạt động của Dullesain"
  },
  FeatureUnlock_97143_LockTip = {
    Text = "<Posse:Mở khóa sau khi hoàn thành 「Điều Tra Hành Động」1-2·Phổ Thông>"
  },
  FeatureUnlock_97144_LockTip = {
    Text = "<Posse:Mở khóa sau khi hoàn thành 「Điều Tra Hành Động」1-2·Phổ Thông>"
  },
  FeatureUnlock_97145_FeatureName = {
    Text = "Sự kiện Katie Gula"
  },
  FeatureUnlock_97146_FeatureName = {
    Text = "Sự kiện Pikman"
  },
  FeatureUnlock_97671_FeatureName = {
    Text = "Hoạt động Nguồn Gốc Nàng Thơ Biển Sâu"
  },
  FeatureUnlock_97894_LockTip = {
    Text = "<Posse:Mở khóa sau khi hoàn thành 「Điều Tra Hành Động」1-2·Phổ Thông>"
  },
  FeatureUnlock_97895_FeatureName = {
    Text = "Sự kiện mùa hè đặc biệt·Phần dưới"
  },
  FeatureUnlock_97929_LockTip = {
    Text = "<Posse:Hoàn thành 「Tạm Biệt Vĩnh Viễn」·Bình Thường sau khi mở khóa>"
  }
})
return Text_FeatureUnlock
