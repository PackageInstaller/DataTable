__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Task = readonly({
  Task_100331_Desc = {
    Text = "Đạt được tích lũy 1 trận thắng trong mùa giải này"
  },
  Task_100331_Name = {
    Text = "1 trận thắng"
  },
  Task_100332_Desc = {
    Text = "Đạt được tổng cộng 10 trận thắng trong mùa giải này"
  },
  Task_100332_Name = {Text = "10 thắng"},
  Task_100333_Desc = {
    Text = "Đạt được tổng cộng 6 trận thắng trong mùa giải này"
  },
  Task_100333_Name = {Text = "6 thắng"},
  Task_100334_Desc = {
    Text = "Đạt được 3 trận thắng trong mùa giải này"
  },
  Task_100334_Name = {
    Text = "3 trận thắng"
  },
  Task_100523_Desc = {
    Text = "Hoàn thành ý thức du hành \"Hình vẽ kỳ quái\""
  },
  Task_100523_Name = {
    Text = "Ảo vọng hiện thế"
  },
  Task_100576_Desc = {
    Text = "Mỗi khi trải qua 1 lượt chiến đấu, điểm đánh giá điều tra giảm 20 điểm."
  },
  Task_100576_Name = {
    Text = "Đồng hồ cát thời gian<size=20><color=#747474> mỗi khi trải qua 1 lượt chiến đấu, điểm điều tra giảm 20 điểm </color></size>"
  },
  Task_10143_Desc = {
    Text = "Hoàn thành trong 72 vòng"
  },
  Task_10143_Name = {
    Text = "Hoàn thành trong 72 vòng"
  },
  Task_10144_Desc = {
    Text = "Hoàn thành trong 79 vòng chơi"
  },
  Task_10144_Name = {
    Text = "Hoàn thành trong 79 vòng chơi"
  },
  Task_10145_Desc = {
    Text = "Di chuyển không quá 40 bước để hoàn thành màn chơi"
  },
  Task_10145_Name = {
    Text = "Lập kế hoạch chiến lược"
  },
  Task_10146_Desc = {
    Text = "Hoàn thành khi triệu chứng không nhiều hơn 1 loại"
  },
  Task_10146_Name = {
    Text = "Tinh thần sảng khoái"
  },
  Task_10147_Desc = {
    Text = "Hoàn thành khi triệu chứng không nhiều hơn 1 loại"
  },
  Task_10147_Name = {
    Text = "Tinh thần sảng khoái"
  },
  Task_10148_Desc = {
    Text = "Hoàn thành trong 31 lượt"
  },
  Task_10148_Name = {
    Text = "Hoàn thành trong 31 lượt"
  },
  Task_10149_Desc = {
    Text = "Hoàn thành trong tổng số 40 lượt chơi"
  },
  Task_10149_Name = {
    Text = "Hoàn thành trong tổng số 40 lượt chơi"
  },
  Task_10150_Desc = {
    Text = "Hoàn thành trong 47 vòng"
  },
  Task_10150_Name = {
    Text = "Hoàn thành trong 47 vòng"
  },
  Task_10151_Desc = {
    Text = "Hoàn thành trong tổng số 58 lượt"
  },
  Task_10151_Name = {
    Text = "Hoàn thành trong tổng số 58 lượt"
  },
  Task_10152_Desc = {
    Text = "Hoàn thành thử thách trong 65 lượt chơi"
  },
  Task_10152_Name = {
    Text = "Hoàn thành thử thách trong 65 lượt chơi"
  },
  Task_10153_Desc = {
    Text = "Tiêu diệt quái vật rỗng"
  },
  Task_10153_Name = {
    Text = "Mục tiêu"
  },
  Task_10154_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10154_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10155_Desc = {
    Text = "Di chuyển tối đa 18 bước để hoàn thành"
  },
  Task_10155_Name = {
    Text = "Lập kế hoạch chiến lược"
  },
  Task_10156_Desc = {
    Text = "Hoàn thành khi triệu chứng không vượt quá 3 mục"
  },
  Task_10156_Name = {
    Text = "Tinh thần sảng khoái"
  },
  Task_10157_Desc = {
    Text = "Khi hoàn thành, đạt ít nhất 100 dấu đen"
  },
  Task_10157_Name = {
    Text = "Dùng trong ván sau"
  },
  Task_10158_Desc = {
    Text = "Hoàn thành với ít nhất 2 thân thể hỗn độn"
  },
  Task_10158_Name = {
    Text = "Hỗn loạn là bậc thang"
  },
  Task_10159_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 8 lượt để giành chiến thắng"
  },
  Task_10159_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10160_Desc = {
    Text = "Có ít nhất 2 sáng tạo khi hoàn thành"
  },
  Task_10160_Name = {
    Text = "Sức mạnh sáng tạo"
  },
  Task_10161_Desc = {
    Text = "Hoàn thành với ít nhất 2 thân thể hỗn độn"
  },
  Task_10161_Name = {
    Text = "Hỗn loạn là bậc thang"
  },
  Task_10162_Desc = {
    Text = "Hoàn thành khi thức tỉnh tất cả các thân thể"
  },
  Task_10162_Name = {
    Text = "Sự xuất hiện cuối cùng"
  },
  Task_10163_Desc = {
    Text = "Hoàn thành khi có ít nhất 4 tạo vật"
  },
  Task_10163_Name = {
    Text = "Sức mạnh sáng tạo"
  },
  Task_10164_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10164_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10165_Desc = {
    Text = "Đồng bộ với 8 thân thể được đánh thức đạt cấp 5 tỷ lệ đồng điều"
  },
  Task_10165_Name = {
    Text = "Đối tác ăn ý IV"
  },
  Task_10166_Desc = {
    Text = "Khi đạt tỷ lệ đồng điều cấp độ 3 với 12 thân thể được đánh thức"
  },
  Task_10166_Name = {
    Text = "Cặp đôi ăn ý V"
  },
  Task_10167_Desc = {
    Text = "Di chuyển không quá 45 bước để qua màn"
  },
  Task_10167_Name = {
    Text = "Lập kế hoạch chiến lược"
  },
  Task_10168_Desc = {
    Text = "Hoàn thành trong tổng số 17 lượt"
  },
  Task_10168_Name = {
    Text = "Hoàn thành trong tổng số 17 lượt"
  },
  Task_10169_Desc = {
    Text = "Có 20 thể xác được thức tỉnh"
  },
  Task_10169_Name = {
    Text = "Đánh trận bên nhau II"
  },
  Task_10170_Desc = {
    Text = "Có 30 thân thể được đánh thức"
  },
  Task_10170_Name = {
    Text = "Chiến đấu cùng nhau III"
  },
  Task_10171_Desc = {
    Text = "Tiến hành 300 lần lễ thức đánh thức"
  },
  Task_10171_Name = {
    Text = "Thiên tài Người Giữ Gìn IV"
  },
  Task_10172_Desc = {
    Text = "Có 10 thân thể được thức tỉnh"
  },
  Task_10172_Name = {
    Text = "Chiến đấu cùng nhau"
  },
  Task_10173_Desc = {
    Text = "Đồng điệu với 4 thân thể được đánh thức đạt tỷ lệ đồng điều cấp độ 5"
  },
  Task_10173_Name = {
    Text = "Đối tác ăn ý II"
  },
  Task_10174_Desc = {
    Text = "Tìm lại ví"
  },
  Task_10174_Name = {
    Text = "Mục tiêu"
  },
  Task_10175_Desc = {
    Text = "Có 40 thể xác được thức tỉnh"
  },
  Task_10175_Name = {
    Text = "Đánh trận bên nhau IV"
  },
  Task_10176_Desc = {
    Text = "Đồng bộ với 4 thân thể được đánh thức đạt tỷ lệ đồng điều cấp 3"
  },
  Task_10176_Name = {
    Text = "Bạn đồng hành ăn ý"
  },
  Task_10177_Desc = {
    Text = "Hoàn thành 400 lần Phế tích Ponape"
  },
  Task_10177_Name = {
    Text = "Phúc lành của Pohnpei IV"
  },
  Task_10178_Desc = {
    Text = "Hoàn thành 600 lần tại Bonapecxu"
  },
  Task_10178_Name = {
    Text = "Phúc lành của Pohnpei V"
  },
  Task_10179_Desc = {
    Text = "Hoàn thành 50 lần tại Hang Động Giun"
  },
  Task_10179_Name = {
    Text = "Người nuôi sâu bọ"
  },
  Task_10180_Desc = {
    Text = "Hoàn thành 100 lần Hang Giun"
  },
  Task_10180_Name = {
    Text = "Chúa tể Giun đất II"
  },
  Task_10181_Desc = {
    Text = "Hoàn thành 200 lần tại Động Sâu"
  },
  Task_10181_Name = {
    Text = "Chủ Nhân Giun Đất III"
  },
  Task_10182_Desc = {
    Text = "Hoàn thành 400 tại Động Sâu"
  },
  Task_10182_Name = {
    Text = "Người nuôi giun đất IV"
  },
  Task_10183_Desc = {
    Text = "Hoàn thành 600 lần tại Động Giun"
  },
  Task_10183_Name = {
    Text = "Người nuôi giun đất thứ V"
  },
  Task_10184_Desc = {
    Text = "Hoàn thành 1 lần thực thể siêu việt"
  },
  Task_10184_Name = {
    Text = "Bàn về sự ra đời bí ẩn"
  },
  Task_10185_Desc = {
    Text = "Hoàn thành 10 lần Siêu Nghiệm"
  },
  Task_10185_Name = {
    Text = "Về sự ra đời kín đáo II"
  },
  Task_10186_Desc = {
    Text = "Hoàn thành 25 lần tồn tại siêu việt"
  },
  Task_10186_Name = {
    Text = "Luận về sự ra đời bí ẩn III"
  },
  Task_10187_Desc = {
    Text = "Hoàn thành sự kiện điều tra chương 3 \"Cẩn thận chó dữ\""
  },
  Task_10187_Name = {
    Text = "Hạt mầm sao"
  },
  Task_10188_Desc = {
    Text = "Hoàn thành sau tối đa 6 trận chiến"
  },
  Task_10188_Name = {
    Text = "Đột kích tinh chuẩn"
  },
  Task_10189_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_10189_Name = {
    Text = "An toàn là trên hết"
  },
  Task_10190_Desc = {
    Text = "Hoàn thành khi triệu chứng không nhiều hơn 1 loại"
  },
  Task_10190_Name = {
    Text = "Tinh thần sảng khoái"
  },
  Task_10191_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10191_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10192_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10192_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10193_Desc = {
    Text = "Tìm ra Jenkin"
  },
  Task_10193_Name = {
    Text = "Mục tiêu"
  },
  Task_10194_Desc = {
    Text = "Hoàn thành tinh chế độ I"
  },
  Task_10194_Name = {
    Text = "Nhiệm vụ 3"
  },
  Task_10195_Desc = {
    Text = "Hoàn thành 2 nhiệm vụ được giao"
  },
  Task_10195_Name = {
    Text = "Nhiệm vụ 2"
  },
  Task_10196_Desc = {
    Text = "Tích lũy thức tỉnh 40 lần"
  },
  Task_10196_Name = {
    Text = "Nhiệm vụ 1"
  },
  Task_10197_Desc = {
    Text = "Nâng cấp chương 1 cảm ứng 5 lần"
  },
  Task_10197_Name = {
    Text = "Nhiệm vụ 5"
  },
  Task_10198_Desc = {
    Text = "4 thân thể được đánh thức đạt cấp 10"
  },
  Task_10198_Name = {
    Text = "Nhiệm vụ 4"
  },
  Task_10199_Desc = {
    Text = "Hoàn thành với ít nhất 2 thân thể hỗn độn"
  },
  Task_10199_Name = {
    Text = "Hỗn loạn là bậc thang"
  },
  Task_10200_Desc = {
    Text = "Hoàn thành khi triệu chứng không nhiều hơn 1 loại"
  },
  Task_10200_Name = {
    Text = "Tinh thần sảng khoái"
  },
  Task_10201_Desc = {
    Text = "Rời khỏi phòng động lực"
  },
  Task_10201_Name = {
    Text = "Mục tiêu"
  },
  Task_10202_Desc = {
    Text = "Có ít nhất 8 thẻ bài khắcăng khi hoàn thành"
  },
  Task_10202_Name = {
    Text = "Lực Khắcăng"
  },
  Task_10203_Desc = {
    Text = "Hoàn thành với ít nhất 2 thân thể hỗn độn"
  },
  Task_10203_Name = {
    Text = "Hỗn loạn là bậc thang"
  },
  Task_10204_Desc = {
    Text = "Đi đến địa điểm điều tra"
  },
  Task_10204_Name = {
    Text = "Mục tiêu"
  },
  Task_10205_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 8 lượt để giành chiến thắng"
  },
  Task_10205_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10206_Desc = {
    Text = "Hoàn thành với ít nhất 2 thân thể hỗn độn"
  },
  Task_10206_Name = {
    Text = "Hỗn loạn là bậc thang"
  },
  Task_10207_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_10207_Name = {
    Text = "An toàn là trên hết"
  },
  Task_10208_Desc = {
    Text = "Di chuyển tối đa 35 bước để hoàn thành"
  },
  Task_10208_Name = {
    Text = "Lập kế hoạch chiến lược"
  },
  Task_10209_Desc = {
    Text = "Hoàn thành khi có ít nhất 4 tạo vật"
  },
  Task_10209_Name = {
    Text = "Sức mạnh sáng tạo"
  },
  Task_10210_Desc = {
    Text = "Tiêu thụ 180 linh phì peptide"
  },
  Task_10210_Name = {
    Text = "Tiêu thụ thể lực"
  },
  Task_10211_Desc = {
    Text = "Loại bỏ những đứa trẻ ngăn cản đường đi"
  },
  Task_10211_Name = {
    Text = "Mục tiêu"
  },
  Task_10212_Desc = {
    Text = "Hoàn thành tất cả các nhiệm vụ trong giai đoạn để nhận phần thưởng"
  },
  Task_10212_Name = {
    Text = "Giai đoạn một"
  },
  Task_10213_Desc = {
    Text = "Đi xuyên qua các chiều để theo dấu vết của Đào Đen Đá"
  },
  Task_10213_Name = {
    Text = "Mục tiêu"
  },
  Task_10215_Desc = {
    Text = "Cuộc chiến cuối cùng chiến thắng trong 6 lượt"
  },
  Task_10215_Name = {
    Text = "Cuộc chiến cuối cùng chiến thắng trong 6 lượt"
  },
  Task_10216_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10216_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10217_Desc = {
    Text = "Đánh bại cuộc chiến cuối cùng trong 15 lượt, và áp lực dưới 500"
  },
  Task_10217_Name = {
    Text = "Chiến thắng cuộc chiến cuối cùng trong 15 hiệp, áp lực ≤ 500"
  },
  Task_10218_Desc = {
    Text = "Có 4 thân thể được đánh thức cấp 20"
  },
  Task_10218_Name = {
    Text = "Chủ nhân Thịt máu II"
  },
  Task_10219_Desc = {
    Text = "Đi theo Muphí"
  },
  Task_10219_Name = {
    Text = "Mục tiêu"
  },
  Task_10220_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10220_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10221_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10221_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10222_Desc = {
    Text = "Tổng cộng đã chơi 50 lá bài"
  },
  Task_10223_Desc = {
    Text = "Tìm kiếm manh mối về kẻ săn sọ"
  },
  Task_10223_Name = {
    Text = "Mục tiêu"
  },
  Task_10224_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10224_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10226_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10226_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10228_Desc = {
    Text = "Tìm kiếm thuyền trưởng"
  },
  Task_10228_Name = {
    Text = "Mục tiêu"
  },
  Task_10229_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10229_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10230_Desc = {
    Text = "Đuổi theo \"chó địa ngục\""
  },
  Task_10230_Name = {
    Text = "Mục tiêu"
  },
  Task_10231_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_10231_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10232_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10232_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10233_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10233_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10234_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10234_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10235_Desc = {
    Text = "Điều tra 60 lần hải vực tàn ảnh"
  },
  Task_10235_Name = {
    Text = "Phế tích biển sâu III"
  },
  Task_10236_Desc = {
    Text = "Điều tra 30 lần tàn ảnh của hải vực"
  },
  Task_10236_Name = {
    Text = "Đống phế tích biển sâu II"
  },
  Task_10237_Desc = {
    Text = "Điều tra 120 lần hình ảnh mờ đục"
  },
  Task_10237_Name = {
    Text = "Phế Tích Hỗn Loạn IV"
  },
  Task_10238_Desc = {
    Text = "Điều tra 60 lần bóng dáng mờ ảo"
  },
  Task_10238_Name = {
    Text = "Hỗn Loạn Hư Không III"
  },
  Task_10239_Desc = {
    Text = "Điều tra 15 lần hải vực tàn ảnh"
  },
  Task_10239_Name = {
    Text = "Phế tích biển sâu"
  },
  Task_10240_Desc = {
    Text = "Điều tra 240 lần hình ảnh mờ nhạt"
  },
  Task_10240_Name = {
    Text = "Hỗn Loạn Chi Hư V"
  },
  Task_10241_Desc = {
    Text = "Hoàn thành 600 lần chế biến luyện hóa"
  },
  Task_10241_Name = {
    Text = "Bậc thầy điều chế V"
  },
  Task_10242_Desc = {
    Text = "Hoàn thành 400 lần tinh luyện chế phẩm"
  },
  Task_10242_Name = {
    Text = "Chuyên gia điều chế IV"
  },
  Task_10243_Desc = {
    Text = "Điều tra 30 lần hình ảnh đục"
  },
  Task_10243_Name = {
    Text = "Phế Tích Hỗn Loạn II"
  },
  Task_10244_Desc = {
    Text = "Điều tra 15 lần bóng dáng mờ ảo"
  },
  Task_10244_Name = {
    Text = "Vực thẳm hỗn loạn"
  },
  Task_10245_Desc = {
    Text = "Bảo vệ Jenkin"
  },
  Task_10245_Name = {
    Text = "Mục tiêu"
  },
  Task_10246_Desc = {
    Text = "Chặn đứng kẻ điên bị biến dị"
  },
  Task_10246_Name = {
    Text = "Mục tiêu"
  },
  Task_10247_Desc = {
    Text = "Hoàn thành tất cả các nhiệm vụ trong giai đoạn để nhận phần thưởng"
  },
  Task_10247_Name = {
    Text = "Giai đoạn thứ ba"
  },
  Task_10248_Desc = {
    Text = "Tìm công cụ để mở cửa hầm"
  },
  Task_10248_Name = {
    Text = "Mục tiêu"
  },
  Task_10249_Desc = {
    Text = "Trốn khỏi nguy hiểm"
  },
  Task_10249_Name = {
    Text = "Mục tiêu"
  },
  Task_10250_Desc = {
    Text = "Khi kết thúc level, cần đi qua ít nhất 2 loại nút sự kiện"
  },
  Task_10250_Name = {
    Text = "Lớp kích hoạt điểm nút"
  },
  Task_10251_Desc = {
    Text = "Hoàn thành mà không dùng trại để hồi máu"
  },
  Task_10251_Name = {
    Text = "Thử thách đặc biệt"
  },
  Task_10252_Desc = {
    Text = "Kết thúc cuộc chiến cuối cùng với ít nhất 50% máu còn lại"
  },
  Task_10252_Name = {
    Text = "Yêu cầu máu loại cuộc chiến cuối cùng"
  },
  Task_10253_Desc = {
    Text = "Thẻ triệu chứng ít nhất 2 thẻ để hoàn thành"
  },
  Task_10253_Name = {
    Text = "Loại kế hoạch bộ bài"
  },
  Task_10254_Desc = {
    Text = "Thẻ triệu chứng tối đa chỉ 2 lá để hoàn thành"
  },
  Task_10254_Name = {
    Text = "Loại kế hoạch bộ bài"
  },
  Task_10255_Desc = {
    Text = "Ít nhất 30 bước để hoàn thành"
  },
  Task_10255_Name = {
    Text = "Lớp quy hoạch đường đi"
  },
  Task_10256_Desc = {
    Text = "Hoàn thành trong vòng 25 bước"
  },
  Task_10256_Name = {
    Text = "Lớp quy hoạch đường đi"
  },
  Task_10258_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10258_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10259_Desc = {
    Text = "Số lần trạng thái bị loại bỏ bởi lệnh (ví dụ: xóa bỏ hiệu ứng yếu đuối hai lần)"
  },
  Task_10259_Name = {
    Text = "Hiệu ứng chiến đấu"
  },
  Task_10260_Desc = {
    Text = "Số lần trạng thái được thêm bởi lệnh (ví dụ: thành công khi thêm một lần hiệu ứng yếu đuối)"
  },
  Task_10260_Name = {
    Text = "Hiệu ứng chiến đấu"
  },
  Task_10265_Desc = {
    Text = "Đẩy lùi kẻ săn đầu"
  },
  Task_10265_Name = {
    Text = "Mục tiêu"
  },
  Task_10266_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_10266_Name = {
    Text = "An toàn là trên hết"
  },
  Task_10267_Desc = {
    Text = "Hoàn thành tối đa 3 lần chiến đấu"
  },
  Task_10267_Name = {
    Text = "Đột kích tinh chuẩn"
  },
  Task_10268_Desc = {
    Text = "Có ít nhất 50 dấu đen khi hoàn thành"
  },
  Task_10268_Name = {
    Text = "Dùng trong ván sau"
  },
  Task_10269_Desc = {
    Text = "Hoàn thành khi triệu chứng không nhiều hơn 1 loại"
  },
  Task_10269_Name = {
    Text = "Tinh thần sảng khoái"
  },
  Task_10270_Desc = {
    Text = "Có ít nhất 8 thẻ bài khắcăng khi hoàn thành"
  },
  Task_10270_Name = {
    Text = "Lực Khắcăng"
  },
  Task_10271_Desc = {
    Text = "Hoàn thành trong vòng 28 bước di chuyển"
  },
  Task_10271_Name = {
    Text = "Lập kế hoạch chiến lược"
  },
  Task_10272_Desc = {
    Text = "Hoàn thành tất cả các trận chiến với tối đa 4 lần cơn thịnh nộ bùng phát"
  },
  Task_10272_Name = {
    Text = "Bình tĩnh và tao nhã"
  },
  Task_10273_Desc = {
    Text = "Hoàn thành khi thức tỉnh tất cả các thân thể"
  },
  Task_10273_Name = {
    Text = "Sự xuất hiện cuối cùng"
  },
  Task_10274_Desc = {
    Text = "Hoàn thành khi có ít nhất 4 tạo vật"
  },
  Task_10274_Name = {
    Text = "Sức mạnh sáng tạo"
  },
  Task_10275_Desc = {
    Text = "Hoàn thành trong vòng 73 lượt chơi"
  },
  Task_10275_Name = {
    Text = "Hoàn thành trong vòng 73 lượt chơi"
  },
  Task_10276_Desc = {
    Text = "Đi sâu vào khoang tàu"
  },
  Task_10276_Name = {
    Text = "Mục tiêu"
  },
  Task_10277_CompleteCondDesc = {
    Text = "Phái đi cấp độ tổng>={s1}"
  },
  Task_10277_Desc = {
    Text = "Ngồi yên trong thư viện sẽ không giúp bạn nhận được nhiều thân thể được đánh thức hơn. \nHãy bắt đầu hành trình, dùng đôi chân để khám phá thiên nhiên và tìm kiếm khả năng một phần mười nghìn."
  },
  Task_10277_Name = {
    Text = "Điều tra nhiệm vụ: Dấu vết Bạc Mật"
  },
  Task_10278_Desc = {
    Text = "Hoàn thành khi triệu chứng không nhiều hơn 1 loại"
  },
  Task_10278_Name = {
    Text = "Tinh thần sảng khoái"
  },
  Task_10279_Desc = {
    Text = "Di chuyển không quá 45 bước để qua màn"
  },
  Task_10279_Name = {
    Text = "Lập kế hoạch chiến lược"
  },
  Task_10280_Desc = {
    Text = "Di chuyển không quá 30 bước để vượt qua thử thách"
  },
  Task_10280_Name = {
    Text = "Lập kế hoạch chiến lược"
  },
  Task_10281_Desc = {
    Text = "Thăng cấp 1 thân thể được đánh thức siêu không gian giới vực lên cấp 2"
  },
  Task_10281_Name = {
    Text = "Siêu việt thông thạo II"
  },
  Task_10282_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_10282_Name = {
    Text = "An toàn là trên hết"
  },
  Task_10283_Desc = {
    Text = "Hoàn thành tất cả các nhiệm vụ trong giai đoạn để nhận phần thưởng"
  },
  Task_10283_Name = {
    Text = "Giai đoạn thứ năm"
  },
  Task_10284_Desc = {
    Text = "Cuộc chiến cuối cùng thắng 17 lượt"
  },
  Task_10284_Name = {
    Text = "Cuộc chiến cuối cùng thắng 17 lượt"
  },
  Task_10285_Desc = {
    Text = "Tiêu thụ 10000000 quyền vàng hồng"
  },
  Task_10285_Name = {
    Text = "Chi tiêu hoang phí V"
  },
  Task_10287_Desc = {
    Text = "Tiêu thụ 5000000 quyền vàng hồng"
  },
  Task_10287_Name = {
    Text = "Chi tiêu hoang phí IV"
  },
  Task_10288_Desc = {
    Text = "Thắng trong cuộc chiến cuối cùng trong vòng 15 lượt"
  },
  Task_10288_Name = {
    Text = "Thắng trong cuộc chiến cuối cùng trong vòng 15 lượt"
  },
  Task_10289_Desc = {
    Text = "Hoàn thành tối đa 5 trận chiến"
  },
  Task_10289_Name = {
    Text = "Đột kích tinh chuẩn"
  },
  Task_10290_Desc = {
    Text = "Tìm kiếm tiếng thì thầm trong góc"
  },
  Task_10290_Name = {
    Text = "Mục tiêu"
  },
  Task_10292_Desc = {
    Text = "Đăng nhập liên tiếp 90 ngày"
  },
  Task_10292_Name = {Text = "Kiên trì"},
  Task_10293_Desc = {
    Text = "Đăng nhập liên tiếp 60 ngày"
  },
  Task_10293_Name = {
    Text = "Từ giới khác đến"
  },
  Task_10294_Desc = {
    Text = "Hoàn thành với ít nhất 2 thân thể hỗn độn"
  },
  Task_10294_Name = {
    Text = "Hỗn loạn là bậc thang"
  },
  Task_10295_Desc = {
    Text = "Thoát khỏi sự đeo bám của người phụ nữ bí ẩn"
  },
  Task_10295_Name = {
    Text = "Mục tiêu"
  },
  Task_10297_Desc = {
    Text = "Hoàn thành với ít nhất 2 thân thể hỗn độn"
  },
  Task_10297_Name = {
    Text = "Hỗn loạn là bậc thang"
  },
  Task_10298_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_10298_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10301_Desc = {
    Text = "Hủy diệt Cerberus"
  },
  Task_10301_Name = {
    Text = "Mục tiêu"
  },
  Task_10302_CompleteCondDesc = {
    Text = "Phái đi cấp độ tổng>={s1}"
  },
  Task_10302_Desc = {
    Text = "Hỗn loạn là quy luật tự nhiên, trật tự chỉ là ảo tưởng của loài người."
  },
  Task_10302_Name = {
    Text = "Nhiệm vụ nghiên cứu: Thi phẩm Trắng Tinh Khôi"
  },
  Task_10302_UnlockCondDesc = {
    Text = "Người giữ bí mật cấp 25 được mở"
  },
  Task_10303_Desc = {
    Text = "Người giữ bí mật thăng cấp lên 35"
  },
  Task_10303_Name = {
    Text = "Huấn luyện thử nghiệm Người Giữ Gìn IV"
  },
  Task_10305_Desc = {
    Text = "Đồng điệu với 8 thân thể được đánh thức đạt tỷ lệ đồng điều cấp độ 3"
  },
  Task_10305_Name = {
    Text = "Đối tác ăn ý III"
  },
  Task_10307_Desc = {
    Text = "Hoàn thành Khe Hở trong Vùng Đất Hỗn Loạn I"
  },
  Task_10307_Name = {
    Text = "Nhiệm vụ 5"
  },
  Task_10308_Desc = {
    Text = "Hoàn thành 1 lần bất kỳ thử thách tàn ảnh"
  },
  Task_10308_Name = {
    Text = "Nhiệm vụ 4"
  },
  Task_10309_Desc = {
    Text = "Hoàn thành thẻ vàng điều tra độ khó I"
  },
  Task_10309_Name = {
    Text = "Nhiệm vụ 3"
  },
  Task_10310_Desc = {
    Text = "Nâng cấp 4 thức tỉnh giả lên cấp 20"
  },
  Task_10310_Name = {
    Text = "Nhiệm vụ 2"
  },
  Task_10311_Desc = {
    Text = "Hoàn thành Giấc mơ thám hiểm 1 lần"
  },
  Task_10311_Name = {
    Text = "Nhiệm vụ 1"
  },
  Task_10313_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_10313_Name = {
    Text = "An toàn là trên hết"
  },
  Task_10314_Desc = {
    Text = "Di chuyển không quá 30 bước để vượt qua thử thách"
  },
  Task_10314_Name = {
    Text = "Lập kế hoạch chiến lược"
  },
  Task_10315_Desc = {
    Text = "Hoàn thành khi thức tỉnh tất cả các thân thể"
  },
  Task_10315_Name = {
    Text = "Sự xuất hiện cuối cùng"
  },
  Task_10316_Desc = {
    Text = "Hoàn thành với ít nhất 2 thân thể hỗn độn"
  },
  Task_10316_Name = {
    Text = "Hỗn loạn là bậc thang"
  },
  Task_10317_Desc = {
    Text = "Hoàn thành khi triệu chứng không vượt quá 3 mục"
  },
  Task_10317_Name = {
    Text = "Tinh thần sảng khoái"
  },
  Task_10318_Desc = {
    Text = "Có ít nhất 3 tạo tác khi hoàn thành"
  },
  Task_10318_Name = {
    Text = "Sức mạnh sáng tạo"
  },
  Task_10319_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 8 lượt để giành chiến thắng"
  },
  Task_10319_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10320_CompleteCondDesc = {
    Text = "Phái đi cấp độ tổng>={s1}"
  },
  Task_10320_Desc = {
    Text = "Đồ vật lấp lánh chưa chắc đã là vàng, nhưng chắc chắn có giá trị không nhỏ. \nTheo truyền thuyết, Misaque được thành lập bởi một nhóm nhà luyện kim bị tách khỏi cộng đồng, tham vọng của họ vượt xa việc chỉ đơn giản biến đá thành vàng, chạm tới những bí ẩn sâu thẳm hơn của tạo hóa."
  },
  Task_10320_Name = {
    Text = "Nhiệm vụ nghiên cứu: Bút ký luyện kim"
  },
  Task_10321_Desc = {
    Text = "Di chuyển không quá 33 bước để hoàn thành"
  },
  Task_10321_Name = {
    Text = "Lập kế hoạch chiến lược"
  },
  Task_10322_Desc = {
    Text = "Có ít nhất 5 sáng tạo khi hoàn thành"
  },
  Task_10322_Name = {
    Text = "Sức mạnh sáng tạo"
  },
  Task_10323_CompleteCondDesc = {
    Text = "Phái đi cấp độ tổng>={s1}"
  },
  Task_10323_Desc = {
    Text = "Nói một cách nghiêm ngặt, thân thể được đánh thức cũng là một loại Công nghệ Bạc Tâm. \nBạn cần nỗ lực hết mình để chúng không lỗi thời."
  },
  Task_10323_Name = {
    Text = "Nhiệm vụ nghiên cứu: Điều chế chế phẩm"
  },
  Task_10324_Desc = {
    Text = "Đánh lui quái vật dị hình trong phòng viện trưởng"
  },
  Task_10324_Name = {
    Text = "Mục tiêu"
  },
  Task_10325_Desc = {
    Text = "Có ít nhất 2 sáng tạo khi hoàn thành"
  },
  Task_10325_Name = {
    Text = "Sức mạnh sáng tạo"
  },
  Task_10326_Desc = {
    Text = "Đạt 5 thẻ bài khắcăng ít nhất khi hoàn thành"
  },
  Task_10326_Name = {
    Text = "Lực Khắcăng"
  },
  Task_10327_Desc = {
    Text = "Hoàn thành khi triệu chứng ≤ 2"
  },
  Task_10327_Name = {
    Text = "Tinh thần sảng khoái"
  },
  Task_10328_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10328_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10329_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10329_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10330_Desc = {
    Text = "Di chuyển không quá 30 bước để vượt qua thử thách"
  },
  Task_10330_Name = {
    Text = "Lập kế hoạch chiến lược"
  },
  Task_10331_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10331_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10332_Desc = {
    Text = "Thắng cuộc chiến cuối cùng trong 12 hiệp"
  },
  Task_10332_Name = {
    Text = "Thắng cuộc chiến cuối cùng trong 12 hiệp"
  },
  Task_10333_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10333_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10334_Desc = {
    Text = "Nâng cấp kỹ năng thân thể được đánh thức 3 lần"
  },
  Task_10334_Name = {
    Text = "Người yêu thích đấu trường (tạm khóa)"
  },
  Task_10335_Desc = {
    Text = "Hoàn thành Vùng đất vô ánh sáng VIII(chưa xong)"
  },
  Task_10336_Desc = {
    Text = "Khám phá bí mật của viện tâm thần"
  },
  Task_10336_Name = {
    Text = "Mục tiêu"
  },
  Task_10337_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10337_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10338_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10338_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10339_Desc = {
    Text = "Chiến thắng trong 7 hồi hợp của cuộc chiến cuối cùng"
  },
  Task_10339_Name = {
    Text = "Chiến thắng trong 7 hồi hợp của cuộc chiến cuối cùng"
  },
  Task_10340_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10340_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10341_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10341_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10342_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10342_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10343_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10343_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10344_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10344_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10345_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10345_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10346_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10346_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10347_Desc = {
    Text = "Thăng cấp một thân thể được đánh thức trong siêu không gian giới vực lên cấp 3"
  },
  Task_10347_Name = {
    Text = "Siêu Việt III"
  },
  Task_10348_Desc = {
    Text = "Thăng cấp 1 thân thể được đánh thức từ giới vực thịt và máu lên cấp 3"
  },
  Task_10348_Name = {
    Text = "Chuyên môn về thịt máu III"
  },
  Task_10349_Desc = {
    Text = "Thăng cấp 1 thân thể được đánh thức giới vực biển sâu lên cấp 3"
  },
  Task_10349_Name = {
    Text = "Biển sâu thành thạo III"
  },
  Task_10350_Desc = {
    Text = "Thăng cấp một thân thể được đánh thức từ giới vực hỗn loạn lên cấp 3"
  },
  Task_10350_Name = {
    Text = "Hỗn loạn thành thạo III"
  },
  Task_10351_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10351_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10352_Desc = {
    Text = "Sở hữu 4 thân thể được đánh thức cấp 40 của thịt máu"
  },
  Task_10352_Name = {
    Text = "Bậc thầy của thịt máu IV"
  },
  Task_10353_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10353_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10354_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10354_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10355_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10355_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10356_Desc = {
    Text = "Đuổi theo Ai Ji Si"
  },
  Task_10356_Name = {
    Text = "Mục tiêu"
  },
  Task_10357_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10357_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10358_Desc = {
    Text = "Cuộc chiến cuối cùng thắng trong 3 vòng"
  },
  Task_10358_Name = {
    Text = "Cuộc chiến cuối cùng thắng trong 3 vòng"
  },
  Task_10359_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10359_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10360_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10360_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10361_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10361_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10362_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10362_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10363_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10363_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10364_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10364_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10365_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10365_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10366_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10366_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10367_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10367_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10368_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10368_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10369_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10369_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10370_Desc = {
    Text = "Tìm 10 điểm phân tích chương thứ hai của \"@1@2\""
  },
  Task_10370_Desc2 = {
    Text = "Tìm 10 điểm phân nhánh của chương thứ hai trong câu chuyện chính \"Nhân Danh Bình Tượng Nến\""
  },
  Task_10370_Name2 = {
    Text = "Lời thì thầm ẩn giấu II"
  },
  Task_10371_Desc = {
    Text = "Tìm 9 điểm phân tích của chương ba chính tuyến \"@1@2\""
  },
  Task_10371_Desc2 = {
    Text = "Tìm 9 điểm kích hoạt trong chương ba của tuyến chính \"Cẩn thận chó dữ\""
  },
  Task_10371_Name2 = {
    Text = "Lời thì thầm ẩn III"
  },
  Task_10372_Desc = {
    Text = "Hoàn thành 336 nhiệm vụ điều động"
  },
  Task_10372_Name = {
    Text = "Sứ mệnh đặc biệt V"
  },
  Task_10373_Desc = {
    Text = "Tìm 8 điểm tách biệt trong chương đầu tiên của tuyến chính \"Bí mật khu Đông\""
  },
  Task_10373_Name = {
    Text = "Lời thì thầm tiềm ẩn"
  },
  Task_10374_Desc = {
    Text = "Hoàn thành 84 nhiệm vụ được giao"
  },
  Task_10374_Name = {
    Text = "Nhiệm vụ đặc biệt III"
  },
  Task_10375_Desc = {
    Text = "Hoàn thành 168 nhiệm vụ phái đi"
  },
  Task_10375_Name = {
    Text = "Hoạt động đặc biệt IV"
  },
  Task_10376_Desc = {
    Text = "Hoàn thành 12 nhiệm vụ phái đi"
  },
  Task_10376_Name = {
    Text = "Hoạt động đặc biệt"
  },
  Task_10377_Desc = {
    Text = "Hoàn thành 36 nhiệm vụ được giao"
  },
  Task_10377_Name = {
    Text = "Nhiệm vụ đặc biệt II"
  },
  Task_10378_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10378_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10379_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10379_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10380_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10380_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10381_Desc = {
    Text = "Tìm thấy 12 điểm trích xuất từ chương chính thứ tư \"@1@2\""
  },
  Task_10381_Desc2 = {
    Text = "Tìm 12 điểm tách ra trong chương thứ tư của tuyến chính \"Vào lúc im lặng\""
  },
  Task_10381_Name2 = {
    Text = "Thì thầm tiềm ẩn IV"
  },
  Task_10382_Desc = {
    Text = "Sở hữu 4 thân thể đánh thức sâu thẳm đạt cấp 60"
  },
  Task_10382_Name = {
    Text = "Chúa tể đại dương VI"
  },
  Task_10384_Desc = {
    Text = "Cuộc chiến cuối cùng tích lũy lá chắn trong một lượt duy nhất lớn hơn hoặc bằng 1000"
  },
  Task_10384_Name = {
    Text = "Phòng vệ quá mức"
  },
  Task_10385_Desc = {
    Text = "Đi xuyên qua đường dẫn ý thức, truy đuổi Francis"
  },
  Task_10385_Name = {
    Text = "Mục tiêu"
  },
  Task_10387_Desc = {
    Text = "Xử lý dị biến thể rỗng rỗng"
  },
  Task_10387_Name = {
    Text = "Mục tiêu"
  },
  Task_10388_Desc = {
    Text = "Dẫn Sara xuống hầm"
  },
  Task_10388_Name = {
    Text = "Mục tiêu"
  },
  Task_10390_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_10390_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10391_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_10391_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10392_Desc = {
    Text = "Thoát khỏi không gian chiều và ánh mắt của \"Ngài\""
  },
  Task_10392_Name = {
    Text = "Mục tiêu"
  },
  Task_10394_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_10394_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10395_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_10395_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10396_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_10396_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10397_Desc = {
    Text = "Thức tỉnh Lily đang thất thần"
  },
  Task_10397_Name = {
    Text = "Mục tiêu"
  },
  Task_10404_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_10404_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10405_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_10405_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10406_Desc = {
    Text = "Hoàn thành với ít nhất 2 thân thể hỗn độn"
  },
  Task_10406_Name = {
    Text = "Hỗn loạn là bậc thang"
  },
  Task_10407_Desc = {
    Text = "Đi xuyên qua đường hầm tàu điện ngầm"
  },
  Task_10407_Name = {
    Text = "Mục tiêu"
  },
  Task_10409_Desc = {
    Text = "Trốn khỏi viện tâm thần"
  },
  Task_10409_Name = {
    Text = "Mục tiêu"
  },
  Task_10413_Desc = {
    Text = "Hoàn thành khi có ít nhất 4 tạo vật"
  },
  Task_10413_Name = {
    Text = "Sức mạnh sáng tạo"
  },
  Task_10419_Desc = {
    Text = "Đuổi theo Pandia"
  },
  Task_10419_Name = {
    Text = "Mục tiêu"
  },
  Task_10420_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"Vào nơi yên lặng\"ở mức độ khó khăn"
  },
  Task_10420_Name = {
    Text = "Mẹ, con ổn mà·khó khăn"
  },
  Task_10421_Desc = {
    Text = "Chiến thắng trong cuộc chiến cuối cùng dưới 15 lượt"
  },
  Task_10421_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10422_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 8 lượt để giành chiến thắng"
  },
  Task_10422_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10423_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 8 lượt để giành chiến thắng"
  },
  Task_10423_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10424_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_10424_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10425_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_10425_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10426_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_10426_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10427_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_10427_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10428_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_10428_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10429_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_10429_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10430_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_10430_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10431_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_10431_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10432_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_10432_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10433_Desc = {
    Text = "Hoàn thành sau tối đa 6 trận chiến"
  },
  Task_10433_Name = {
    Text = "Đột kích tinh chuẩn"
  },
  Task_10434_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_10434_Name = {
    Text = "An toàn là trên hết"
  },
  Task_10435_Desc = {
    Text = "Hoàn thành khi triệu chứng không nhiều hơn 1 loại"
  },
  Task_10435_Name = {
    Text = "Tinh thần sảng khoái"
  },
  Task_10436_Desc = {
    Text = "Cản trở nhà nghiên cứu"
  },
  Task_10436_Name = {
    Text = "Mục tiêu"
  },
  Task_10437_Desc = {
    Text = "Vào hầm ngầm"
  },
  Task_10437_Name = {
    Text = "Mục tiêu"
  },
  Task_10438_Desc = {
    Text = "Hoàn thành trong tổng cộng 24 lượt chơi"
  },
  Task_10438_Name = {
    Text = "Hoàn thành trong tổng cộng 24 lượt chơi"
  },
  Task_10439_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_10439_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10440_Desc = {
    Text = "Hoàn thành với ít nhất 2 thân thể hỗn độn"
  },
  Task_10440_Name = {
    Text = "Hỗn loạn là bậc thang"
  },
  Task_10441_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_10441_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10442_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_10442_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10443_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_10443_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10444_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_10444_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10445_Desc = {
    Text = "Tổng cộng đã tiêu thụ 1000 dấu đen"
  },
  Task_10445_Name = {
    Text = "Hắc gọi III"
  },
  Task_10446_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_10446_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10447_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_10447_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10448_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_10448_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10449_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10449_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10450_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10450_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10451_Desc = {
    Text = "Hoàn thành 600 lượt ghi chép cấm kỵ"
  },
  Task_10451_Name = {
    Text = "Kỹ sư khắc ấn bí ẩn V"
  },
  Task_10452_Desc = {
    Text = "Hoàn thành 400 lần biên soạn cấm kỵ"
  },
  Task_10452_Name = {
    Text = "Nhà khắc triện bí ẩn IV"
  },
  Task_10453_Desc = {
    Text = "Hoàn thành 200 lần biên chép cấm kỵ"
  },
  Task_10453_Name = {
    Text = "Nhà khắc ấn bí ẩn III"
  },
  Task_10454_Desc = {
    Text = "Kích hoạt hiệu ứng bộ 6 mảnh bí ẩn (set)"
  },
  Task_10454_Name = {
    Text = "Nhiệm vụ 4"
  },
  Task_10455_Desc = {
    Text = "Hoàn thành 50 lần biên soạn cấm kỵ"
  },
  Task_10455_Name = {
    Text = "Thợ khắc bùa bí ẩn"
  },
  Task_10456_Desc = {
    Text = "Hoàn thành 50 lần Thức Tỉnh Siêu Nhiên"
  },
  Task_10456_Name = {
    Text = "Bàn về sự ra đời bí mật IV"
  },
  Task_10457_Desc = {
    Text = "Gặp lơ-tan"
  },
  Task_10457_Name = {
    Text = "Mục tiêu"
  },
  Task_10458_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10458_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10459_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10459_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10460_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10460_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10461_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10461_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10462_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10462_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10463_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10463_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10464_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10464_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10465_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10465_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10466_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10466_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10467_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10467_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10468_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10468_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10469_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10469_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10470_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10470_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10471_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10471_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10472_Desc = {
    Text = "Hoàn thành chương 2 của câu chuyện chính \"Nhân danh bình tượng nến\""
  },
  Task_10473_CompleteCondDesc = {
    Text = "Phái đi cấp độ tổng>={s1}"
  },
  Task_10473_Desc = {
    Text = "Họ cuộn tròn trong nỗi sợ hãi mà chính họ không hề nhận ra.\nKhông biết, không ánh sáng, không tên."
  },
  Task_10473_Name = {
    Text = "Nhiệm vụ nghiên cứu: Bài thơ Scarlet"
  },
  Task_10473_UnlockCondDesc = {
    Text = "Người giữ bí mật cấp 25 được mở"
  },
  Task_10474_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10474_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10475_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_10475_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10476_Desc = {
    Text = "Hoàn thành 400 lượt tìm kiếm vé vàng"
  },
  Task_10476_Name = {
    Text = "Thợ đào vàng IV"
  },
  Task_10477_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_10477_Name = {
    Text = "An toàn là trên hết"
  },
  Task_10478_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_10478_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10479_Desc = {
    Text = "Thắng trong cuộc chiến cuối cùng trong vòng 10 lượt"
  },
  Task_10479_Name = {
    Text = "Thắng trong cuộc chiến cuối cùng trong vòng 10 lượt"
  },
  Task_10480_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10480_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10481_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_10481_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10482_Desc = {
    Text = "Hoàn thành điều tra chương 4 của câu chuyện chính \"Trong im lặng\""
  },
  Task_10483_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10483_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10484_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10484_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10485_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10485_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10486_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10486_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10487_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10487_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10488_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10488_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10489_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10489_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10490_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10490_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10492_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10492_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10493_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10493_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10494_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10494_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10495_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10495_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10496_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10496_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10497_Desc = {
    Text = "Hoàn thành 30 lần Thám hiểm Giấc mơ"
  },
  Task_10497_Name = {
    Text = "Thợ lặn sâu III"
  },
  Task_10498_Desc = {
    Text = "Hoàn thành 60 lần Thám hiểm Giấc mơ"
  },
  Task_10498_Name = {
    Text = "Người lặn sâu IV"
  },
  Task_10499_Desc = {
    Text = "Hoàn thành 1 lần Giấc mơ lặn sâu"
  },
  Task_10499_Name = {
    Text = "Người lặn sâu"
  },
  Task_10500_Desc = {
    Text = "Hoàn thành 15 lần Thám hiểm Giấc mơ"
  },
  Task_10500_Name = {
    Text = "Người Lặn Sâu II"
  },
  Task_10501_Desc = {
    Text = "Một lần gây thương đến 800"
  },
  Task_10501_Name = {
    Text = "Thương mạnh mẽ III"
  },
  Task_10502_Desc = {
    Text = "Gây ra 1000 sát thương trong một lần"
  },
  Task_10502_Name = {
    Text = "Thương mạnh mẽ IV"
  },
  Task_10503_Desc = {
    Text = "Một lần thương đạt 200"
  },
  Task_10503_Name = {
    Text = "Sát thương mạnh"
  },
  Task_10504_Desc = {
    Text = "Một lần gây sát thương đạt 400"
  },
  Task_10504_Name = {
    Text = "Thương mạnh mẽ II"
  },
  Task_10505_Desc = {
    Text = "Một lần gây ra sát thương đạt 5000"
  },
  Task_10505_Name = {
    Text = "Thương tổn chí mạng V"
  },
  Task_10506_Desc = {
    Text = "Áp đặt 500 lớp trúng độc lên kẻ địch"
  },
  Task_10506_Name = {
    Text = "Chuyên gia độc lý học"
  },
  Task_10507_Desc = {
    Text = "Ngăn chặn Ai Ji Tư"
  },
  Task_10507_Name = {
    Text = "Mục tiêu"
  },
  Task_10510_Desc = {
    Text = "Trong loại chiến đấu X cụ thể, gây lượng thương ≥ 1000 trong một lượt (trận chiến tinh anh X)"
  },
  Task_10510_Name = {
    Text = "Rùng Rợn Carnival"
  },
  Task_10511_Desc = {
    Text = "Trong loại chiến đấu X cụ thể, số lần kích hoạt cơn thịnh nộ bùng phát trong một lượt ≥ 5"
  },
  Task_10511_Name = {
    Text = "Liên hoàn cuồng loạn"
  },
  Task_10512_Desc = {
    Text = "Số lần sử dụng chức năng hồi phục tại trại khi hoàn thành nhỏ hơn hoặc bằng 1"
  },
  Task_10512_Name = {
    Text = "Nhà an toàn"
  },
  Task_10513_Desc = {
    Text = "Khi hoàn thành, độ khám phá bản đồ tại trại phải lớn hơn hoặc bằng 80%"
  },
  Task_10513_Name = {
    Text = "Thấy rõ hơn"
  },
  Task_10514_Desc = {
    Text = "Số lượng thẻ bài loại X khi hoàn thành phải nhỏ hơn hoặc bằng 3"
  },
  Task_10514_Name = {
    Text = "Miễn dịch tiên phong"
  },
  Task_10515_Desc = {
    Text = "Số lượng thẻ bài loại X khi hoàn thành phải lớn hơn hoặc bằng 3"
  },
  Task_10515_Name = {
    Text = "Thông báo bệnh nguy kịch"
  },
  Task_10516_Desc = {
    Text = "Hoàn thành khi số lượng sáng tạo loại X lớn hơn hoặc bằng 3 (X vàng)"
  },
  Task_10516_Name = {
    Text = "Người đào vàng"
  },
  Task_10517_Desc = {
    Text = "Hoàn thành khi nhận được ít nhất 2 loại khắcăng (cảm hứng và cảm hứng cao cấp được coi là tương đương)"
  },
  Task_10517_Name = {
    Text = "Nhà sưu tập khắc dấu"
  },
  Task_10518_Desc = {
    Text = "Khi hoàn thành, thân thể được đánh thức lớn hơn hoặc bằng 2"
  },
  Task_10518_Name = {
    Text = "Thời khắc thức tỉnh"
  },
  Task_10519_Desc = {
    Text = "Hoàn thành với ít nhất 2 thân thể hỗn độn"
  },
  Task_10519_Name = {
    Text = "Hỗn loạn là bậc thang"
  },
  Task_10520_Desc = {
    Text = "Đánh lui đám tín đồ của giáo phái cầm đèn đang tấn công"
  },
  Task_10520_Name = {
    Text = "Mục tiêu"
  },
  Task_10521_Desc = {
    Text = "Tranh thủ thời gian để vẽ pháp trận"
  },
  Task_10521_Name = {
    Text = "Mục tiêu"
  },
  Task_10523_Desc = {
    Text = "Nâng cấp kỹ năng thân thể được đánh thức tùy ý lên cấp 3"
  },
  Task_10523_Name = {
    Text = "Nhiệm vụ 2"
  },
  Task_10524_Desc = {
    Text = "Hoàn thành sự kiện chính tuyến điều tra · khó khăn 1-8"
  },
  Task_10524_Name = {
    Text = "Nhiệm vụ 3"
  },
  Task_10525_Desc = {
    Text = "Nâng cấp 4 thể xác được thức tỉnh lên level 40"
  },
  Task_10525_Name = {
    Text = "Nhiệm vụ 1"
  },
  Task_10526_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_10526_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10527_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_10527_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10528_Desc = {
    Text = "Hoàn thành 100 lần tinh chế"
  },
  Task_10528_Name = {
    Text = "Thiên tài dược sư II"
  },
  Task_10529_Desc = {
    Text = "Hoàn thành vùng hỗn loạn khe hở VI"
  },
  Task_10529_Name = {
    Text = "Nhiệm vụ 5"
  },
  Task_10530_Desc = {
    Text = "Cuộc chiến quyết định Hiro"
  },
  Task_10530_Name = {
    Text = "Mục tiêu"
  },
  Task_10531_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_10531_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10532_Desc = {
    Text = "Hoàn thành 200 lần tìm kiếm phiếu vàng"
  },
  Task_10532_Name = {
    Text = "Thợ đào vàng III"
  },
  Task_10533_Desc = {
    Text = "Hợp tác với đóa để đẩy lùi đám tín đồ cầm đèn"
  },
  Task_10533_Name = {
    Text = "Mục tiêu"
  },
  Task_10534_Desc = {
    Text = "Hoàn thành 50 lần tìm kiếm phiếu vàng"
  },
  Task_10534_Name = {
    Text = "Người đào vàng"
  },
  Task_10535_Desc = {
    Text = "Hoàn thành 100 lần tìm kiếm phiếu vàng"
  },
  Task_10535_Name = {
    Text = "Thợ đào vàng II"
  },
  Task_10536_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10536_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10537_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_10537_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10538_CompleteCondDesc = {
    Text = "Phái đi cấp độ tổng>={s1}"
  },
  Task_10538_Desc = {
    Text = "Đôi khi, sự xung động phá hủy chính là sự xung động sáng tạo. \nHãy nhặt lên cây cọ của bạn, nghệ thuật không cần bất kỳ sự chuẩn bị nào."
  },
  Task_10538_Name = {
    Text = "Điều tra nhiệm vụ: Chủ nghĩa Dada"
  },
  Task_10538_UnlockCondDesc = {
    Text = "Hoàn thành sự kiện điều tra 1-13 được mở khóa"
  },
  Task_10539_Desc = {
    Text = "Hoàn thành tất cả các nhiệm vụ trong giai đoạn để nhận phần thưởng"
  },
  Task_10539_Name = {
    Text = "Giai đoạn thứ hai"
  },
  Task_10540_Desc = {
    Text = "Hoàn thành điều tra chương 1 \"Bí mật khu Đông\" khó"
  },
  Task_10544_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10544_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10545_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10545_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10546_Desc = {
    Text = "Đăng nhập liên tiếp 2 ngày"
  },
  Task_10546_Name = {
    Text = "Xin chào, Người Giữ Gìn"
  },
  Task_10547_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10547_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10548_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10548_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10549_Desc = {
    Text = "Hoàn thành Khe Hở trong Vùng Đất Hỗn Loạn I"
  },
  Task_10550_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10550_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10552_Desc = {
    Text = "Có ít nhất 2 sáng tạo khi hoàn thành"
  },
  Task_10552_Name = {
    Text = "Sức mạnh sáng tạo"
  },
  Task_10553_Desc = {
    Text = "Đạt 5 thẻ bài khắcăng ít nhất khi hoàn thành"
  },
  Task_10553_Name = {
    Text = "Lực Khắcăng"
  },
  Task_10554_Desc = {
    Text = "Hoàn thành khi triệu chứng ≤ 2"
  },
  Task_10554_Name = {
    Text = "Tinh thần sảng khoái"
  },
  Task_10555_Desc = {
    Text = "Hoàn thành tất cả các nhiệm vụ trong chương này sẽ nhận được"
  },
  Task_10555_Name = {
    Text = "Giới vực tinh thông III"
  },
  Task_10556_Desc = {
    Text = "Di chuyển không quá 33 bước để hoàn thành"
  },
  Task_10556_Name = {
    Text = "Lập kế hoạch chiến lược"
  },
  Task_10557_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10557_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10558_Desc = {
    Text = "Hoàn thành tối đa 5 trận chiến"
  },
  Task_10558_Name = {
    Text = "Đột kích tinh chuẩn"
  },
  Task_10565_CompleteCondDesc = {
    Text = "Phái đi cấp độ tổng>={s1}"
  },
  Task_10565_Desc = {
    Text = "Bản năng, lý trí và trái tim của anh ta đều bị nhốt trong một chiếc lọ thủy tinh nhỏ. \nTừ đó, thế giới đã trở nên xa lạ với anh ta."
  },
  Task_10565_Name = {
    Text = "Điều tra nhiệm vụ: Hoạt tính phân ly"
  },
  Task_10565_UnlockCondDesc = {
    Text = "Hoàn thành sự kiện điều tra 1-13 được mở khóa"
  },
  Task_10571_Desc = {
    Text = "Thực hiện 150 lần lễ thức đánh thức"
  },
  Task_10571_Name = {
    Text = "Thiên tài Người Giữ Gìn III"
  },
  Task_10572_Desc = {
    Text = "Thực hiện 100 lần lễ thức đánh thức"
  },
  Task_10572_Name = {
    Text = "Thiên tài Người Giữ Gìn II"
  },
  Task_10575_Desc = {
    Text = "Thăng cấp 1 thân thể được đánh thức từ giới vực thịt máu lên cấp 5"
  },
  Task_10575_Name = {
    Text = "Thịt máu V"
  },
  Task_10576_Desc = {
    Text = "Thăng cấp 1 thân thể được đánh thức vùng giới sâu thẳm lên cấp 5"
  },
  Task_10576_Name = {
    Text = "Tinh Thông Biển Sâu V"
  },
  Task_10577_Desc = {
    Text = "Thực hiện 50 lần lễ thức đánh thức"
  },
  Task_10577_Name = {
    Text = "Người giữ bí mật thiên tài"
  },
  Task_10578_Desc = {
    Text = "Đưa 1 thân thể được thức tỉnh trong giới vực siêu việt lên cấp độ 5"
  },
  Task_10578_Name = {
    Text = "Siêu việt thành thạo V"
  },
  Task_10579_Desc = {
    Text = "Sở hữu 12 món trang bị cấp 9 bí ẩn"
  },
  Task_10579_Name = {
    Text = "Bộ sưu tập Bí ẩn II"
  },
  Task_10580_Desc = {
    Text = "Sở hữu 6 trang bị cấp 6 liên quan đến bí ẩn"
  },
  Task_10580_Name = {
    Text = "Sưu tầm gia bí ẩn"
  },
  Task_10581_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_10581_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10582_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_10582_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10583_Desc = {
    Text = "Theo dõi hành tung còn lại của Francis"
  },
  Task_10583_Name = {
    Text = "Mục tiêu"
  },
  Task_10584_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_10584_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10585_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_10585_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10586_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_10586_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10587_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_10587_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10588_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_10588_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10589_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_10589_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10590_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_10590_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10591_Desc = {
    Text = "Hoàn thành khi triệu chứng không vượt quá 3 mục"
  },
  Task_10591_Name = {
    Text = "Tinh thần sảng khoái"
  },
  Task_10592_Desc = {
    Text = "Lại vào viện tâm thần của Rai"
  },
  Task_10592_Name = {
    Text = "Mục tiêu"
  },
  Task_10593_Desc = {
    Text = "Thắng trong cuộc chiến cuối cùng trong vòng 15 lượt"
  },
  Task_10593_Name = {
    Text = "Thắng trong cuộc chiến cuối cùng trong vòng 15 lượt"
  },
  Task_10595_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10595_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10596_Desc = {
    Text = "Thoát khỏi băng nguyên"
  },
  Task_10596_Name = {
    Text = "Mục tiêu"
  },
  Task_10597_Desc = {
    Text = "Gửi đi 3 lần"
  },
  Task_10597_Name = {
    Text = "Tiến hành giao nhiệm vụ"
  },
  Task_10598_Desc = {
    Text = "Hoàn thành trong tổng số 38 lượt chơi"
  },
  Task_10598_Name = {
    Text = "Hoàn thành trong tổng số 38 lượt chơi"
  },
  Task_10599_Desc = {
    Text = "Tiêu thụ 2500000 quyền vàng hồng"
  },
  Task_10599_Name = {
    Text = "Tiêu tiền như nước III"
  },
  Task_10600_Desc = {
    Text = "Đăng nhập vào trò chơi"
  },
  Task_10600_Name = {
    Text = "Đăng nhập vào trò chơi"
  },
  Task_10601_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10601_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10602_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10602_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10603_Desc = {
    Text = "Hoàn thành khi thức tỉnh tất cả các thân thể"
  },
  Task_10603_Name = {
    Text = "Sự xuất hiện cuối cùng"
  },
  Task_10604_Desc = {
    Text = "Hoàn thành khi có ít nhất 4 tạo vật"
  },
  Task_10604_Name = {
    Text = "Sức mạnh sáng tạo"
  },
  Task_10605_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10605_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10606_Desc = {
    Text = "Hoàn thành khi triệu chứng không nhiều hơn 1 loại"
  },
  Task_10606_Name = {
    Text = "Tinh thần sảng khoái"
  },
  Task_10607_Desc = {
    Text = "Có ít nhất 8 thẻ bài khắcăng khi hoàn thành"
  },
  Task_10607_Name = {
    Text = "Lực Khắcăng"
  },
  Task_10608_Desc = {
    Text = "Người giữ bí mật đạt cấp 25"
  },
  Task_10608_Name = {
    Text = "Huấn luyện thử nghiệm Người giữ bí mật III"
  },
  Task_10609_Desc = {
    Text = "Hoàn thành tất cả các trận chiến với tối đa 4 lần cơn thịnh nộ bùng phát"
  },
  Task_10609_Name = {
    Text = "Bình tĩnh và tao nhã"
  },
  Task_10610_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10610_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10611_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_10611_Name = {
    Text = "An toàn là trên hết"
  },
  Task_10612_Desc = {
    Text = "Hoàn thành tối đa 3 lần chiến đấu"
  },
  Task_10612_Name = {
    Text = "Đột kích tinh chuẩn"
  },
  Task_10613_Desc = {
    Text = "Có ít nhất 50 dấu đen khi hoàn thành"
  },
  Task_10613_Name = {
    Text = "Dùng trong ván sau"
  },
  Task_10614_Desc = {
    Text = "Tỷ lệ đồng điều đạt cấp độ 3 với 16 thân thể được đánh thức"
  },
  Task_10614_Name = {
    Text = "Đối tác ăn ý VII"
  },
  Task_10616_Desc = {
    Text = "Sở hữu 4 thân thể được đánh thức biển sâu lv.40"
  },
  Task_10616_Name = {
    Text = "Chúa tể biển sâu IV"
  },
  Task_10618_Desc = {
    Text = "Hoàn thành trong 48 vòng chơi"
  },
  Task_10618_Name = {
    Text = "Hoàn thành trong 48 vòng chơi"
  },
  Task_10619_Desc = {
    Text = "Hoàn thành trong tổng số 53 lượt chơi"
  },
  Task_10619_Name = {
    Text = "Hoàn thành trong tổng số 53 lượt chơi"
  },
  Task_10620_Desc = {
    Text = "Điều tra 30 lần ảnh chiều"
  },
  Task_10620_Name = {
    Text = "Siêu Việt Trụ II"
  },
  Task_10621_Desc = {
    Text = "Điều tra 60 lần tàn ảnh chiều"
  },
  Task_10621_Name = {
    Text = "Vực Siêu Việt III"
  },
  Task_10622_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10622_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10623_Desc = {
    Text = "Điều tra 15 lần ảnh tàn dư của chiều không gian"
  },
  Task_10623_Name = {
    Text = "Phế tích siêu việt"
  },
  Task_10624_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10624_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10625_Desc = {
    Text = "Thực hiện điều tra 120 lần dư ảnh vật chất"
  },
  Task_10625_Name = {
    Text = "Đống phế tích thịt máu IV"
  },
  Task_10626_Desc = {
    Text = "Điều tra 15 lần tàn ảnh cơ chất"
  },
  Task_10626_Name = {
    Text = "Hoang địa của thịt và máu"
  },
  Task_10627_Desc = {
    Text = "Điều tra 30 lần dư ảnh cơ chất"
  },
  Task_10627_Name = {
    Text = "Đống Thịt Máu II"
  },
  Task_10628_Desc = {
    Text = "Hoàn thành sau tối đa 6 trận chiến"
  },
  Task_10628_Name = {
    Text = "Đột kích tinh chuẩn"
  },
  Task_10629_Desc = {
    Text = "Điều tra 240 lần hải vực tàn ảnh"
  },
  Task_10629_Name = {
    Text = "Phế tích Biển sâu V"
  },
  Task_10630_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10630_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10631_Desc = {
    Text = "Trong chiến đấu X (thông thường), số lượng quái vật bị tiêu diệt trong một lượt lớn hơn hoặc bằng 3"
  },
  Task_10631_Name = {
    Text = "Thời khắc săn giết"
  },
  Task_10632_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10632_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10633_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10633_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10634_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10634_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10635_Desc = {
    Text = "Có ít nhất 5 sáng tạo khi hoàn thành"
  },
  Task_10635_Name = {
    Text = "Sức mạnh sáng tạo"
  },
  Task_10636_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10636_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10637_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10637_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10638_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10638_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10639_Desc = {
    Text = "Hoàn thành tất cả các nhiệm vụ trong giai đoạn để nhận phần thưởng"
  },
  Task_10639_Name = {
    Text = "Giai đoạn thứ tư"
  },
  Task_10640_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10640_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10641_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10641_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10642_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10642_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10643_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10643_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10644_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10644_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10645_Desc = {
    Text = "Thăng cấp một thân thể được đánh thức siêu không gian giới vực lên bậc 1"
  },
  Task_10645_Name = {
    Text = "Siêu việt thành thạo I"
  },
  Task_10646_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10646_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10647_Desc = {
    Text = "Thăng cấp một thân thể được đánh thức từ giới vực hỗn loạn lên bậc 1"
  },
  Task_10647_Name = {
    Text = "Hỗn Loạn Thành Thạo I"
  },
  Task_10648_Desc = {
    Text = "Thăng cấp 1 thân thể được đánh thức từ giới vực thịt máu lên cấp độ 1"
  },
  Task_10648_Name = {
    Text = "Tinh thông thịt máu I"
  },
  Task_10649_Desc = {
    Text = "Nâng cấp một thân thể đánh thức vùng giới sâu thẳm lên cấp 1"
  },
  Task_10649_Name = {
    Text = "Biển sâu thành thạo I"
  },
  Task_10650_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_10650_Name = {
    Text = "An toàn là trên hết"
  },
  Task_10651_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10651_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10652_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"@1@2\""
  },
  Task_10652_Desc2 = {
    Text = "Hoàn thành sự kiện điều tra \"Danh nghĩa tượng sáp\""
  },
  Task_10652_Name2 = {
    Text = "Điều huyền bí trong sáp"
  },
  Task_10653_Desc = {
    Text = "Trong quá trình điều tra sự kiện \"Bí mật khu Đông\", cảm nhận được 3 lần cộng hưởng"
  },
  Task_10653_Name = {
    Text = "Âm vang lòng biết ơn"
  },
  Task_10654_Desc = {
    Text = "Đăng nhập liên tiếp trong 30 ngày"
  },
  Task_10654_Name = {
    Text = "Người tích cực"
  },
  Task_10656_Desc = {
    Text = "Hoàn thành Vùng đất vô ánh sáng VII (Còn dang dở)"
  },
  Task_10656_Name = {
    Text = "Người điêu khắc và xây dựng"
  },
  Task_10658_Desc = {
    Text = "Mỗi trận 30 điểm số"
  },
  Task_10658_Name = {
    Text = "Chiến đấu chiến thắng  <size=20><color=#747474>mỗi trận 30 điểm</color></size>"
  },
  Task_10660_Desc = {Text = "Chít"},
  Task_10660_Name = {
    Text = "Chít chít"
  },
  Task_10661_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10661_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10663_Desc = {
    Text = "Đăng nhập liên tiếp 7 ngày"
  },
  Task_10663_Name = {
    Text = "Chim sớm có sâu ăn"
  },
  Task_10664_Desc = {
    Text = "Di chuyển không quá 50 bước để qua màn"
  },
  Task_10664_Name = {
    Text = "Lập kế hoạch chiến lược"
  },
  Task_10665_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_10665_Name = {
    Text = "An toàn là trên hết"
  },
  Task_10666_Desc = {
    Text = "Hoàn thành sau tối đa 7 trận chiến"
  },
  Task_10666_Name = {
    Text = "Đột kích tinh chuẩn"
  },
  Task_10667_Desc = {
    Text = "Nâng cấp 4 thân thể được đánh thức lên cấp 60"
  },
  Task_10667_Name = {
    Text = "Nhiệm vụ 1"
  },
  Task_10668_Desc = {
    Text = "Hoàn thành 20 lần tấn công/phòng thủ/chiến đấu phối hợp"
  },
  Task_10668_Name = {
    Text = "Sổ tài liệu kỹ năng (tạm khóa)"
  },
  Task_10669_Desc = {
    Text = "Hoàn thành điều tra chính 10 lần"
  },
  Task_10669_Name = {
    Text = "Sách nhiệm vụ chính (chưa kích hoạt)"
  },
  Task_10670_Desc = {
    Text = "Hoàn thành Khe hở Thịt máu I"
  },
  Task_10671_Desc = {
    Text = "Đổi 3 lần trong cửa hàng bằng quyền vàng hồng"
  },
  Task_10671_Name = {
    Text = "Mua bằng tiền vàng"
  },
  Task_10672_Desc = {
    Text = "Thích cựu sinh viên 10 lần"
  },
  Task_10672_Name = {
    Text = "Bạn bè thích"
  },
  Task_10673_Desc = {
    Text = "Hoàn thành hiện diện siêu việt 1 lần"
  },
  Task_10673_Name = {
    Text = "Boss hàng tuần"
  },
  Task_10674_Desc = {
    Text = "Tham gia đối đầu pha 3 lần"
  },
  Task_10674_Name = {
    Text = "PVP chiến đấu"
  },
  Task_10675_Desc = {
    Text = "Hoàn thành thử thách hàng tuần"
  },
  Task_10675_Name = {
    Text = "Thử Thách Tuần"
  },
  Task_10676_Desc = {
    Text = "Sử dụng hỗ trợ 3 lần"
  },
  Task_10676_Name = {
    Text = "Chiến đấu hỗ trợ bạn bè"
  },
  Task_10677_Desc = {
    Text = "Tuần này, đạt 1800 điểm tích lũy trong Giấc mơ thám hiểm"
  },
  Task_10677_Name = {
    Text = "Lao xuống huyễn tưởng"
  },
  Task_10678_Desc = {
    Text = "Khi hoàn thành, mỗi vết đen còn lại được 3 điểm, tối đa 600 điểm"
  },
  Task_10678_Name = {
    Text = "Dấu đen  <size=20><color=#747474>Hoàn thành: mỗi dấu đen còn lại +3 điểm, tối đa 600 điểm</color></size>"
  },
  Task_10679_Desc = {
    Text = "Chiến thắng trong cuộc chiến cuối cùng dưới 15 lượt"
  },
  Task_10679_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10680_CompleteCondDesc = {
    Text = "Phái đi cấp độ tổng>={s1}"
  },
  Task_10680_Desc = {
    Text = "Chiều, không gian, lượng tử…… có thể bạn sẽ mãi không hiểu được ý nghĩa sâu sắc đằng sau những từ này. \ngiống như bạn khó hiểu được phần lớn chuyện trên thế giới này."
  },
  Task_10680_Name = {
    Text = "Nghiên cứu nhiệm vụ: Giáng tử thibài"
  },
  Task_10680_UnlockCondDesc = {
    Text = "Người giữ bí mật cấp 25 được mở"
  },
  Task_10681_Desc = {
    Text = "Khi hoàn thành, mạng sống không được dưới 80%"
  },
  Task_10681_Name = {
    Text = "An toàn là trên hết"
  },
  Task_10682_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong 25 vòng"
  },
  Task_10682_Name = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong 25 vòng"
  },
  Task_10683_Desc = {
    Text = "Thăng cấp 1 thân thể được thức tỉnh từ giới vực hỗn loạn lên cấp 2"
  },
  Task_10683_Name = {
    Text = "Hỗn loạn thành thạo II"
  },
  Task_10684_Desc = {
    Text = "Trong sự kiện điều tra \"@1@2\" cộng hưởng 8 lần"
  },
  Task_10684_Desc2 = {
    Text = "Trong sự kiện \"Cẩn thận chó dữ\" gây cộng hưởng 8 lần"
  },
  Task_10684_Name2 = {
    Text = "Dư âm ẩn nhẫn III"
  },
  Task_10685_Desc = {
    Text = "Hoàn thành với ít nhất 2 thân thể hỗn độn"
  },
  Task_10685_Name = {
    Text = "Hỗn loạn là bậc thang"
  },
  Task_10686_Desc = {
    Text = "Có ít nhất 3 tạo tác khi hoàn thành"
  },
  Task_10686_Name = {
    Text = "Sức mạnh sáng tạo"
  },
  Task_10687_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_10687_Name = {
    Text = "An toàn là trên hết"
  },
  Task_10688_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_10688_Name = {
    Text = "An toàn là trên hết"
  },
  Task_10689_Desc = {
    Text = "Di chuyển không quá 30 bước để vượt qua thử thách"
  },
  Task_10689_Name = {
    Text = "Lập kế hoạch chiến lược"
  },
  Task_10690_Desc = {
    Text = "Hoàn thành khi thức tỉnh tất cả các thân thể"
  },
  Task_10690_Name = {
    Text = "Sự xuất hiện cuối cùng"
  },
  Task_10691_Desc = {
    Text = "Hoàn thành với ít nhất 2 thân thể hỗn độn"
  },
  Task_10691_Name = {
    Text = "Hỗn loạn là bậc thang"
  },
  Task_10692_Desc = {
    Text = "Hoàn thành với ít nhất 2 thân thể hỗn độn"
  },
  Task_10692_Name = {
    Text = "Hỗn loạn là bậc thang"
  },
  Task_10693_Desc = {
    Text = "Tiêu trừ nguồn gốc biến dị"
  },
  Task_10693_Name = {
    Text = "Mục tiêu"
  },
  Task_10694_Desc = {
    Text = "Đánh lui đám tín đồ của giáo phái cầm đèn đang tấn công"
  },
  Task_10694_Name = {
    Text = "Mục tiêu"
  },
  Task_10695_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10695_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10696_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10696_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10698_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10698_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10706_Desc = {
    Text = "Bí ẩn được tăng cường 1 lần (chưa hoàn thành)"
  },
  Task_10706_Name = {
    Text = "Phụ kiện tăng cường (không khả dụng)"
  },
  Task_10707_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_10707_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10708_Desc = {
    Text = "Di chuyển tối đa 35 bước để hoàn thành"
  },
  Task_10708_Name = {
    Text = "Lập kế hoạch chiến lược"
  },
  Task_10710_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_10710_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10713_Desc = {
    Text = "Thăng cấp một thân thể được đánh thức từ giới vực hỗn loạn lên bậc 5"
  },
  Task_10713_Name = {
    Text = "Hỗn loạn thành thạoV"
  },
  Task_10714_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_10714_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10715_Desc = {
    Text = "Phá vỡ bao vây"
  },
  Task_10715_Name = {
    Text = "Mục tiêu"
  },
  Task_10716_Desc = {
    Text = "Người giữ bí mật đạt đến cấp 5"
  },
  Task_10716_Name = {
    Text = "Huấn luyện Người Giữ Gìn I"
  },
  Task_10717_Desc = {
    Text = "Trong cuộc chiến cuối cùng, lá chắn tích lũy trong một lượt lớn hơn hoặc bằng 1500"
  },
  Task_10717_Name = {
    Text = "Phòng vệ quá mức"
  },
  Task_10720_Desc = {
    Text = "Hoàn thành vùng hỗn loạn lớp khe hở VII"
  },
  Task_10720_Name = {
    Text = "Nhiệm vụ 5"
  },
  Task_10721_Desc = {
    Text = "Tùy ý tăng cường 6 bí ẩn lên cấp 12"
  },
  Task_10721_Name = {
    Text = "Nhiệm vụ 4"
  },
  Task_10722_Desc = {
    Text = "Có ít nhất 8 thẻ bài khắcăng khi hoàn thành"
  },
  Task_10722_Name = {
    Text = "Lực Khắcăng"
  },
  Task_10723_Desc = {
    Text = "Hoàn thành tất cả các trận chiến với tối đa 4 lần cơn thịnh nộ bùng phát"
  },
  Task_10723_Name = {
    Text = "Bình tĩnh và tao nhã"
  },
  Task_10724_Desc = {
    Text = "Nâng cấp kỹ năng thân thể được đánh thức bất kỳ lên cấp 4"
  },
  Task_10724_Name = {
    Text = "Nhiệm vụ 1"
  },
  Task_10725_Desc = {
    Text = "Cuộc chiến cuối cùng tích lũy lá chắn trong một lượt ≥ 2000"
  },
  Task_10725_Name = {
    Text = "Phòng vệ quá mức"
  },
  Task_10727_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10727_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10728_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10728_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10729_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10729_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10733_CompleteCondDesc = {
    Text = "Phái đi cấp độ tổng>={s1}"
  },
  Task_10733_Desc = {
    Text = "Đó là ngôn ngữ mà Thượng Đế viết nên vũ trụ. \nKhi bạn lắng nghe nó, bạn đang lắng nghe sự vô tận."
  },
  Task_10733_Name = {
    Text = "Điều tra nhiệm vụ: Cuốn sách cổ"
  },
  Task_10733_UnlockCondDesc = {
    Text = "Hoàn thành sự kiện điều tra 1-13 được mở khóa"
  },
  Task_10734_Desc = {
    Text = "Hoàn thành 600 lần tìm kiếm phiếu vàng"
  },
  Task_10734_Name = {
    Text = "Thợ đào vàng V"
  },
  Task_10735_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_10735_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10736_CompleteCondDesc = {
    Text = "Phái đi cấp độ tổng>={s1}"
  },
  Task_10736_Desc = {
    Text = "Nói một cách nghiêm ngặt, thân thể được đánh thức cũng là một loại Công nghệ Bạc Tâm. \nBạn cần nỗ lực hết mình để chúng không lỗi thời."
  },
  Task_10736_Name = {
    Text = "Nhiệm vụ nghiên cứu: Điều chế chế phẩm"
  },
  Task_10737_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10737_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10738_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_10738_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10739_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10739_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10740_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10740_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10741_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_10741_Name = {
    Text = "An toàn là trên hết"
  },
  Task_10742_Desc = {
    Text = "Có ít nhất 2 sáng tạo khi hoàn thành"
  },
  Task_10742_Name = {
    Text = "Sức mạnh sáng tạo"
  },
  Task_10743_Desc = {
    Text = "Hoàn thành với ít nhất 2 thân thể hỗn độn"
  },
  Task_10743_Name = {
    Text = "Hỗn loạn là bậc thang"
  },
  Task_10744_Desc = {
    Text = "Hoàn thành tối đa 5 trận chiến"
  },
  Task_10744_Name = {
    Text = "Đột kích tinh chuẩn"
  },
  Task_10745_Desc = {
    Text = "Hoàn thành khi triệu chứng không vượt quá 3 mục"
  },
  Task_10745_Name = {
    Text = "Tinh thần sảng khoái"
  },
  Task_10746_Desc = {
    Text = "Khi hoàn thành, đạt ít nhất 100 dấu đen"
  },
  Task_10746_Name = {
    Text = "Dùng trong ván sau"
  },
  Task_10747_Desc = {
    Text = "Hoàn thành với ít nhất 2 thân thể hỗn độn"
  },
  Task_10747_Name = {
    Text = "Hỗn loạn là bậc thang"
  },
  Task_10748_Desc = {
    Text = "Hoàn thành khi thức tỉnh tất cả các thân thể"
  },
  Task_10748_Name = {
    Text = "Sự xuất hiện cuối cùng"
  },
  Task_10749_Desc = {
    Text = "Hoàn thành khi có ít nhất 4 tạo vật"
  },
  Task_10749_Name = {
    Text = "Sức mạnh sáng tạo"
  },
  Task_10750_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10750_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10751_Desc = {
    Text = "Hoàn thành trong tổng số 88 lượt chơi"
  },
  Task_10751_Name = {
    Text = "Hoàn thành trong tổng số 88 lượt chơi"
  },
  Task_10752_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_10752_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10753_Desc = {
    Text = "Trong cuộc điều tra sự kiện \"@1@2\" cảm ứng 3 lần"
  },
  Task_10753_Desc2 = {
    Text = "Trong sự kiện \"Dưới Danh Nghĩa Bình Tượng Nến\", cảm ứng 3 lần"
  },
  Task_10753_Name2 = {
    Text = "Cơn Co Giật Vang Vọng"
  },
  Task_10754_Desc = {
    Text = "Trong cuộc điều tra sự kiện \"@1@2\" gây cộng hưởng 6 lần"
  },
  Task_10754_Desc2 = {
    Text = "Trong sự kiện điều tra \"bình tượng nến\" cảm ứng 6 lần"
  },
  Task_10754_Name2 = {
    Text = "Hồi Âm Kinh Hoàng II"
  },
  Task_10755_Desc = {
    Text = "Trong sự kiện điều tra \"@1@2\" cộng hưởng 8 lần"
  },
  Task_10755_Desc2 = {
    Text = "Trong sự kiện \"Nhân danh bình tượng nến\", cảm ứng 8 lần"
  },
  Task_10755_Name2 = {
    Text = "Hồi Âm Kinh Giật III"
  },
  Task_10756_Desc = {
    Text = "Trong cuộc điều tra sự kiện \"@1@2\" cảm ứng 3 lần"
  },
  Task_10756_Desc2 = {
    Text = "Trong sự kiện \"Cẩn thận chó dữ\", cảm ứng 3 lần"
  },
  Task_10756_Name2 = {
    Text = "Dư âm ẩn nhẫn"
  },
  Task_10757_Desc = {
    Text = "Trong cuộc điều tra sự kiện \"@1@2\" gây cộng hưởng 6 lần"
  },
  Task_10757_Desc2 = {
    Text = "Trong sự kiện \"Cẩn thận chó dữ\" gây cộng hưởng 6 lần"
  },
  Task_10757_Name2 = {
    Text = "Hồi âm nhẫn nhị II"
  },
  Task_10758_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_10758_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10759_Desc = {
    Text = "Trong sự kiện điều tra \"@1@2\" cảm ứng 10 lần"
  },
  Task_10759_Desc2 = {
    Text = "Trong sự kiện \"Cẩn thận chó dữ\"đạt được 10 lần cảm ứng"
  },
  Task_10759_Name2 = {
    Text = "Hồi âm Ẩn Nhẫn IV"
  },
  Task_10760_Desc = {
    Text = "Trong cuộc điều tra sự kiện \"@1@2\" cảm ứng 3 lần"
  },
  Task_10760_Desc2 = {
    Text = "Điều tra sự kiện \"trong im lặng(Dư Vô Thanh Xứ)\" cảm ứng 3 lần"
  },
  Task_10760_Name2 = {
    Text = "Hồi âm đau thương"
  },
  Task_10761_Desc = {
    Text = "Trong cuộc điều tra sự kiện \"@1@2\" gây cộng hưởng 6 lần"
  },
  Task_10761_Desc2 = {
    Text = "Trong sự kiện \"Vào nơi yên lặng\", cảm ứng 6 lần"
  },
  Task_10761_Name2 = {
    Text = "Hồi âm khổ đau II"
  },
  Task_10762_Desc = {
    Text = "Trong sự kiện điều tra \"@1@2\" cộng hưởng 8 lần"
  },
  Task_10762_Desc2 = {
    Text = "Trong sự kiện \"Vào nơi yên lặng\", cảm ứng 8 lần"
  },
  Task_10762_Name2 = {
    Text = "Hồi âm khổ đau III"
  },
  Task_10763_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_10763_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10764_Desc = {
    Text = "Đã hoàn thành 'Di Sản Biển Sâu' 1 lần"
  },
  Task_10764_Name = {
    Text = "Tháp bò biển sâu"
  },
  Task_10765_Desc = {
    Text = "Chiến thắng trong cuộc chiến cuối cùng dưới 15 lượt"
  },
  Task_10765_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10766_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10766_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10767_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10767_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10768_Desc = {
    Text = "Sở hữu 4 thân thể siêu thức tỉnh cấp 10"
  },
  Task_10768_Name = {
    Text = "Chúa tể siêu việt"
  },
  Task_10769_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_10769_Name = {
    Text = "An toàn là trên hết"
  },
  Task_10770_Desc = {
    Text = "Hoàn thành tất cả các nhiệm vụ trong chương này sẽ nhận được"
  },
  Task_10770_Name = {
    Text = "Giới Vực Tinh Thông V"
  },
  Task_10771_Desc = {
    Text = "Hoàn thành 1 lần ở khu vực hỗn loạn"
  },
  Task_10771_Name = {
    Text = "Leo Tháp (Hỗn Loạn)"
  },
  Task_10772_Desc = {
    Text = "Hoàn thành chiến dịch Siêu việt 1 lần"
  },
  Task_10772_Name = {
    Text = "Leo tháp - siêu việt"
  },
  Task_10773_Desc = {
    Text = "Hoàn thành Đầm Lầy Thịt Máu 1 lần"
  },
  Task_10773_Name = {
    Text = "Leo Tháp - Thịt Máu"
  },
  Task_10774_Desc = {
    Text = "Hoàn thành vùng cấm hòa hợp 1 lần (đạt giá trị huấn luyện 30)"
  },
  Task_10774_Name = {
    Text = "Khu vực cấm hòa hợp với thiên tai"
  },
  Task_10775_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10775_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10776_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10776_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10777_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10777_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10778_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10778_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10779_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10779_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10780_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10780_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10781_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10781_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10782_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10782_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10783_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10783_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10784_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10784_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10785_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10785_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10786_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10786_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10787_CompleteCondDesc = {
    Text = "Phái đi cấp độ tổng>={s1}"
  },
  Task_10787_Desc = {
    Text = "Đồ vật lấp lánh chưa chắc đã là vàng, nhưng chắc chắn có giá trị không nhỏ. \nTheo truyền thuyết, Misaque được thành lập bởi một nhóm nhà luyện kim bị tách khỏi cộng đồng, tham vọng của họ vượt xa việc chỉ đơn giản biến đá thành vàng, chạm tới những bí ẩn sâu thẳm hơn của tạo hóa."
  },
  Task_10787_Name = {
    Text = "Nhiệm vụ nghiên cứu: Bút ký luyện kim"
  },
  Task_10789_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10789_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10790_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10790_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10791_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10791_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10792_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10792_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10793_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10793_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10794_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10794_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10795_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10795_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10796_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10796_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10797_Desc = {
    Text = "Hoàn thành với ít nhất 2 thân thể hỗn độn"
  },
  Task_10797_Name = {
    Text = "Hỗn loạn là bậc thang"
  },
  Task_10798_Desc = {
    Text = "Gây 2000 lớp trúng độc cho kẻ địch"
  },
  Task_10798_Name = {
    Text = "Chuyên gia độc lý học III"
  },
  Task_10799_Desc = {
    Text = "Gây 1000 lớp trúng độc lên kẻ địch"
  },
  Task_10799_Name = {
    Text = "Chuyên gia độc lý học II"
  },
  Task_10800_Desc = {
    Text = "Phản công tiêu diệt 4 kẻ địch và giành chiến thắng"
  },
  Task_10800_Name = {
    Text = "Self-defense"
  },
  Task_10801_Desc = {
    Text = "Gây 5000 lớp trúng độc cho kẻ địch"
  },
  Task_10801_Name = {
    Text = "Chuyên gia độc lý học IV"
  },
  Task_10802_Desc = {
    Text = "Khi hoàn thành bản sao, trong bộ bài có 30 lá bài cụ thể"
  },
  Task_10802_Name = {
    Text = "Nhà sưu tập thẻ bài"
  },
  Task_10803_Desc = {
    Text = "Đánh bại 6 kẻ thù bằng thương chí mạng và giành chiến thắng"
  },
  Task_10803_Name = {
    Text = "Áp bức tàn bạo bất ngờ"
  },
  Task_10804_Desc = {
    Text = "Một cuộc chiến đấu đánh rơi 30 lá bài trong tay và giành chiến thắng"
  },
  Task_10804_Name = {
    Text = "Không coi ai ra gì"
  },
  Task_10805_Desc = {
    Text = "Khi hoàn thành bản sao, bộ bài chứa 8 thẻ triệu chứng"
  },
  Task_10805_Name = {
    Text = "Bị tai họa đeo bám"
  },
  Task_10806_Desc = {
    Text = "Một lượt tiêu thụ 10 sức tính toán để giành chiến thắng"
  },
  Task_10806_Name = {
    Text = "Kế hoạch hoàn hảo"
  },
  Task_10807_Desc = {
    Text = "Khi hoàn thành bất kỳ bản sao nào, có 7 vật phẩm"
  },
  Task_10807_Name = {
    Text = "Nhà sưu tập tác phẩm sáng tạo"
  },
  Task_10808_Desc = {
    Text = "Nâng cấp bất kỳ kỹ năng thân thể được đánh thức lên level 5"
  },
  Task_10808_Name = {
    Text = "Nhiệm vụ 2"
  },
  Task_10809_Desc = {
    Text = "Thăng cấp 1 thân thể được đánh thức từ giới vực hỗn loạn lên cấp 4"
  },
  Task_10809_Name = {
    Text = "Hỗn loạn thành thạo IV"
  },
  Task_10810_Desc = {
    Text = "Hoàn thành ghi chép bí ẩn 10 lần"
  },
  Task_10810_Name = {
    Text = "Nhiệm vụ 4"
  },
  Task_10811_Desc = {
    Text = "Hoàn thành Vùng Khe Hở Hỗn Loạn VIII"
  },
  Task_10811_Name = {
    Text = "Nhiệm vụ 5"
  },
  Task_10812_Desc = {
    Text = "Thăng cấp một thân thể được đánh thức trong siêu không gian giới vực lên bậc 4"
  },
  Task_10812_Name = {
    Text = "Siêu Việt Tinh Thông IV"
  },
  Task_10814_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10814_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10815_Desc = {
    Text = "Khi hoàn thành, tối đa có thể sở hữu 6 thẻ bài với khắcăng"
  },
  Task_10815_Name = {
    Text = "Khắcăng ức chế"
  },
  Task_10817_Desc = {
    Text = "Hoàn thành 50 lần tôi luyện chế phẩm"
  },
  Task_10817_Name = {
    Text = "Thiên tài dược sư"
  },
  Task_10818_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10818_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10819_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10819_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10820_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10820_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10821_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10821_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10822_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10822_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10823_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10823_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10824_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10824_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10825_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_10825_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10826_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10826_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10827_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10827_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10828_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_10828_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10830_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10830_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10831_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10831_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10832_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10832_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10833_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10833_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10834_Desc = {
    Text = "Có ít nhất 10 thẻ bài khắcăng khi hoàn thành"
  },
  Task_10834_Name = {
    Text = "Lực Khắcăng"
  },
  Task_10835_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10835_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10836_Desc = {
    Text = "Thắng cuộc chiến cuối cùng trong 20 lượt chơi"
  },
  Task_10836_Name = {
    Text = "Thắng cuộc chiến cuối cùng trong 20 lượt chơi"
  },
  Task_10839_Desc = {
    Text = "Di chuyển không quá 50 bước để qua màn"
  },
  Task_10839_Name = {
    Text = "Lập kế hoạch chiến lược"
  },
  Task_10840_Desc = {
    Text = "Hoàn thành trong tổng cộng 43 lượt chơi"
  },
  Task_10840_Name = {
    Text = "Hoàn thành trong tổng cộng 43 lượt chơi"
  },
  Task_10842_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"Cẩn thận chó dữ\"độ khó khó khăn"
  },
  Task_10842_Name = {
    Text = "Người điêu khắc và xây dựng"
  },
  Task_10844_Desc = {
    Text = "Thăng cấp 1 thân thể được đánh thức vùng giới sâu thẳm lên cấp độ 2"
  },
  Task_10844_Name = {
    Text = "Biển sâu tinh thông II"
  },
  Task_10845_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10845_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10848_Desc = {
    Text = "Hoàn thành trong không quá 24 bước di chuyển"
  },
  Task_10848_Name = {
    Text = "Lập kế hoạch chiến lược"
  },
  Task_10852_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10852_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10853_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10853_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10854_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10854_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10855_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10855_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10857_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10857_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10858_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10858_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10859_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10859_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10860_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10860_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10861_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10861_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10862_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10862_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10863_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10863_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10864_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10864_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10865_Desc = {
    Text = "Đã thực hiện tổng cộng 100 lần lễ thức đánh thức"
  },
  Task_10865_Name = {Text = "Rút thẻ"},
  Task_10866_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10866_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10867_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10867_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10868_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10868_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10869_Desc = {
    Text = "Hoàn thành tất cả các trận chiến với tối đa 4 lần cơn thịnh nộ bùng phát"
  },
  Task_10869_Name = {
    Text = "Bình tĩnh và tao nhã"
  },
  Task_10870_Desc = {
    Text = "Nâng cấp kỹ năng thân thể được đánh thức 100 lần"
  },
  Task_10870_Name = {
    Text = "Nghệ thuật rèn luyện IV"
  },
  Task_10871_Desc = {
    Text = "Nâng cấp kỹ năng thân thể được đánh thức 200 lần"
  },
  Task_10871_Name = {
    Text = "Kỹ thuật tu luyện V"
  },
  Task_10872_Desc = {
    Text = "Sở hữu 4 thân thể siêu thức tỉnh cấp 60"
  },
  Task_10872_Name = {
    Text = "Chúa Tể Siêu Việt VI"
  },
  Task_10873_Desc = {
    Text = "Nâng cấp kỹ năng của thể thức tỉnh 10 lần"
  },
  Task_10873_Name = {
    Text = "Rèn luyện kỹ nghệ"
  },
  Task_10874_Desc = {
    Text = "Nâng cấp kỹ năng thân thể được đánh thức 20 lần"
  },
  Task_10874_Name = {
    Text = "Rèn luyện kỹ năng II"
  },
  Task_10875_Desc = {
    Text = "Nâng cấp kỹ năng thân thể được đánh thức 50 lần"
  },
  Task_10875_Name = {
    Text = "Kỹ năng tu luyện III"
  },
  Task_10876_Desc = {
    Text = "Có 4 thân thể siêu thức tỉnh cấp độ 20"
  },
  Task_10876_Name = {
    Text = "Chúa tể Siêu Việt II"
  },
  Task_10877_Desc = {
    Text = "Sở hữu 4 thân thể siêu thức tỉnh cấp 30"
  },
  Task_10877_Name = {
    Text = "Bậc thầy Siêu việt III"
  },
  Task_10878_Desc = {
    Text = "Có 4 thân thể siêu thức tỉnh cấp 40"
  },
  Task_10878_Name = {
    Text = "Chúa tể Siêu việt IV"
  },
  Task_10879_Desc = {
    Text = "Có 4 thân thể siêu thức tỉnh đạt cấp 50"
  },
  Task_10879_Name = {
    Text = "Chúa Siêu Việt V"
  },
  Task_10880_Desc = {
    Text = "Hoàn thành sự kiện điều tra chính tuyến · khó khăn 2-11"
  },
  Task_10880_Name = {
    Text = "Nhiệm vụ 3"
  },
  Task_10881_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_10881_Name = {
    Text = "An toàn là trên hết"
  },
  Task_10882_Desc = {
    Text = "Di chuyển tối đa 35 bước để hoàn thành"
  },
  Task_10882_Name = {
    Text = "Lập kế hoạch chiến lược"
  },
  Task_10883_Desc = {
    Text = "Hoàn thành tất cả các nhiệm vụ trong chương này sẽ nhận được"
  },
  Task_10883_Name = {
    Text = "Giới vực Thạo Luyện II"
  },
  Task_10884_Desc = {
    Text = "Có ít nhất 8 thẻ bài khắcăng khi hoàn thành"
  },
  Task_10884_Name = {
    Text = "Lực Khắcăng"
  },
  Task_10885_Desc = {
    Text = "Hoàn thành với ít nhất 2 thân thể hỗn độn"
  },
  Task_10885_Name = {
    Text = "Hỗn loạn là bậc thang"
  },
  Task_10886_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_10886_Name = {
    Text = "An toàn là trên hết"
  },
  Task_10887_Desc = {
    Text = "Qua trận chiến đầu tiên, loại bỏ những đứa trẻ đó và lấy lại những thứ thuộc về mình"
  },
  Task_10887_Name = {
    Text = "Vượt qua cuộc chiến đấu đầu tiên"
  },
  Task_10888_Desc = {
    Text = "Di chuyển không quá 40 bước để hoàn thành màn chơi"
  },
  Task_10888_Name = {
    Text = "Lập kế hoạch chiến lược"
  },
  Task_10889_Desc = {
    Text = "Khi hoàn thành, tối đa có thể sở hữu 6 thẻ bài với khắcăng"
  },
  Task_10889_Name = {
    Text = "Khắcăng ức chế"
  },
  Task_10890_Desc = {
    Text = "Có ít nhất 10 thẻ bài khắcăng khi hoàn thành"
  },
  Task_10890_Name = {
    Text = "Lực Khắcăng"
  },
  Task_10892_Desc = {
    Text = "Hoàn thành trong vòng 28 bước di chuyển"
  },
  Task_10892_Name = {
    Text = "Lập kế hoạch chiến lược"
  },
  Task_10893_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10893_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10894_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10894_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10895_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10895_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10896_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10896_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10897_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10897_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10898_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10898_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10899_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10899_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10900_Desc = {
    Text = "Khi hoàn thành, mỗi 1% sức đề kháng tử vong còn lại được 1 điểm, tối đa 600 điểm"
  },
  Task_10900_Name = {
    Text = "Thuần thục  <size=20><color=#747474>Hoàn thành, mỗi 1% kháng cự tử vong được 1 điểm, tối đa 600 điểm</color></size>"
  },
  Task_10901_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10901_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10902_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10902_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10904_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 8 lượt để giành chiến thắng"
  },
  Task_10904_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10905_Desc = {
    Text = "Chiến đấu với tượng nến dưới lòng đất"
  },
  Task_10905_Name = {
    Text = "Mục tiêu"
  },
  Task_10906_Desc = {
    Text = "Hoàn thành khi triệu chứng không vượt quá 3 mục"
  },
  Task_10906_Name = {
    Text = "Tinh thần sảng khoái"
  },
  Task_10907_Desc = {
    Text = "Hoàn thành sau tối đa 7 trận chiến"
  },
  Task_10907_Name = {
    Text = "Đột kích tinh chuẩn"
  },
  Task_10908_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10908_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10909_Desc = {
    Text = "Người giữ bí mật đạt cấp 15"
  },
  Task_10909_Name = {
    Text = "Người Giữ Bí Mật Thử Nghiệm II"
  },
  Task_10910_Desc = {
    Text = "Trong sự kiện \"Bí mật khu Đông\"đạt được 8 lần cảm ứng"
  },
  Task_10910_Name = {
    Text = "Cảm Kích Hồi Âm III"
  },
  Task_10911_Desc = {
    Text = "Trong quá trình điều tra sự kiện \"Khu Đông sương mù\", cảm ứng 6 lần"
  },
  Task_10911_Name = {
    Text = "Âm vang biết ơn II"
  },
  Task_10912_Desc = {
    Text = "Thăng cấp 1 thân thể được đánh thức từ giới vực thịt máu lên cấp 2"
  },
  Task_10912_Name = {
    Text = "Tinh Thông Thịt Máu II"
  },
  Task_10913_Desc = {
    Text = "Chít chít, chít chít……!!"
  },
  Task_10913_Name = {
    Text = "Chít chít"
  },
  Task_10914_Desc = {
    Text = "Đi đến phòng thủ thư trưởng"
  },
  Task_10914_Name = {
    Text = "Mục tiêu"
  },
  Task_10915_Desc = {
    Text = "Đạt tỷ lệ đồng điều cấp độ 5 với 12 thân thể được đánh thức"
  },
  Task_10915_Name = {
    Text = "Cặp đôi ăn ý VI"
  },
  Task_10916_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"Bí mật khu Đông\""
  },
  Task_10916_Name = {
    Text = "Vỏ kẹo vàng"
  },
  Task_10917_Desc = {
    Text = "Đồng bộ cấp 5 với 16 thân thể được đánh thức"
  },
  Task_10917_Name = {
    Text = "Đối tác ăn ý VIII"
  },
  Task_10918_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"@1@2\""
  },
  Task_10918_Desc2 = {
    Text = "Hoàn thành sự kiện điều tra \"Cẩn thận chó dữ\""
  },
  Task_10918_Name2 = {
    Text = "Mắt Siêu Việt Chiều"
  },
  Task_10919_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10919_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10920_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10920_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10921_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10921_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10922_Desc = {
    Text = "Hoàn thành 200 lần Phế tích Bonape"
  },
  Task_10922_Name = {
    Text = "Phúc lành của Pohnpei III"
  },
  Task_10923_Desc = {
    Text = "Hoàn thành 100 lần Bonapechố"
  },
  Task_10923_Name = {
    Text = "Phúc lành của Pohnpei II"
  },
  Task_10924_Desc = {
    Text = "Hoàn thành 400 lần hỗn loạn cụm"
  },
  Task_10924_Name = {
    Text = "Nhóm Học Thuật IV"
  },
  Task_10925_Desc = {
    Text = "Hoàn thành 200 lần thử thách hỗn loạn"
  },
  Task_10925_Name = {
    Text = "Nhà Lý Thuyết Đám Đông III"
  },
  Task_10926_Desc = {
    Text = "Hoàn thành 50 lần Bonape's Ruins"
  },
  Task_10926_Name = {
    Text = "Phúc lành của Pohnpei"
  },
  Task_10927_Desc = {
    Text = "Hoàn thành 600 lần nhóm hỗn loạn"
  },
  Task_10927_Name = {
    Text = "Tín đồ cụm V"
  },
  Task_10928_Desc = {
    Text = "Điều tra 240 lần ảnh chiều tàn"
  },
  Task_10928_Name = {
    Text = "Vực Rộng Siêu Việt V"
  },
  Task_10929_Desc = {
    Text = "Điều tra 120 lần hình bóng chiều"
  },
  Task_10929_Name = {
    Text = "Siêu việt hư không IV"
  },
  Task_10931_Desc = {
    Text = "Hoàn thành 50 lần nhóm hỗn loạn"
  },
  Task_10931_Name = {
    Text = "Người theo thuyết bầy đàn"
  },
  Task_10932_Desc = {
    Text = "Tổng cộng đã tiêu thụ 2500 dấu đen"
  },
  Task_10932_Name = {
    Text = "Triệu hồi Đen Cấp IV"
  },
  Task_10933_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10933_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10934_CompleteCondDesc = {
    Text = "Phái đi cấp độ tổng>={s1}"
  },
  Task_10934_Desc = {
    Text = "Tất cả sức sống cuối cùng đều sẽ trở về đại dương. \nGiống như dòng chảy thời gian không bao giờ ngừng nghỉ, nó là khởi đầu của sự kết thúc."
  },
  Task_10934_Name = {
    Text = "Nhiệm vụ nghiên cứu: Thi phẩm Lam Ngọc"
  },
  Task_10934_UnlockCondDesc = {
    Text = "Người giữ bí mật cấp 25 được mở"
  },
  Task_10935_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10935_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10936_Desc = {
    Text = "Mỗi trận 60 điểm"
  },
  Task_10936_Name = {
    Text = "Đánh bại tinh anh  <size=20><color=#747474>60 điểm mỗi trận</color></size>"
  },
  Task_10938_Desc = {
    Text = "Sở hữu 18 món đồ bí ẩn cấp 12"
  },
  Task_10938_Name = {
    Text = "Bí ẩn nhà sưu tầm III"
  },
  Task_10941_Desc = {
    Text = "Khi hoàn thành, bất kỳ thân thể được đánh thức nào có không quá 1 thẻ, nhận được 100 điểm"
  },
  Task_10941_Name = {
    Text = "Được bỏ qua <size=20><color=#747474>khi hoàn thành, mỗi thân thể được đánh thức chỉ có tối đa 1 thẻ bài</color></size>"
  },
  Task_10944_Desc = {
    Text = "Có 4 thân thể đánh thức sâu thẳm cấp độ 20"
  },
  Task_10944_Name = {
    Text = "Chúa tể đại dương II"
  },
  Task_10946_Desc = {
    Text = "Nâng cấp 4 thân thể được đánh thức lên cấp độ 50"
  },
  Task_10946_Name = {
    Text = "Nhiệm vụ 2"
  },
  Task_10947_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10947_Name = {
    Text = "Mục tiêu 1 sẵn sàng để đóng gói"
  },
  Task_10948_Desc = {
    Text = "Điều tra viện tâm thần"
  },
  Task_10948_Name = {
    Text = "Mục tiêu"
  },
  Task_10949_Desc = {
    Text = "Hoàn thành khi triệu chứng không nhiều hơn 1 loại"
  },
  Task_10949_Name = {
    Text = "Tinh thần sảng khoái"
  },
  Task_10951_Desc = {
    Text = "Khi hoàn thành, mỗi 1% sức sống còn lại cộng thêm 1 điểm, tối đa 100 điểm"
  },
  Task_10951_Name = {
    Text = "Sức sống còn lại  <size=20><color=#747474>khi hoàn thành, mỗi 1% sức sống còn lại được 1 điểm, tối đa 100 điểm</color></size>"
  },
  Task_10953_Desc = {
    Text = "Hoàn thành điều tra chương 2 của câu chuyện chính \"Tên gọi của bình tượng nến\"ở độ khó khó khăn"
  },
  Task_10954_Desc = {
    Text = "\"an ủi\" những đứa trẻ tức giận"
  },
  Task_10954_Name = {
    Text = "Mục tiêu"
  },
  Task_10955_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_10955_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10956_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_10956_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10957_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_10957_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10958_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10958_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10959_Desc = {
    Text = "Hoàn thành Vùng đất vô ánh sáng III (Chưa xong)"
  },
  Task_10962_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10962_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10963_Desc = {
    Text = "Di chuyển tối đa 35 bước để hoàn thành"
  },
  Task_10963_Name = {
    Text = "Lập kế hoạch chiến lược"
  },
  Task_10964_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10964_Name = {
    Text = "Gợi ý mục tiêu tối đa 8 chữ"
  },
  Task_10965_Desc = {
    Text = "Chiến thắng trong cuộc chiến cuối cùng dưới 15 lượt"
  },
  Task_10965_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10966_Desc = {
    Text = "Di chuyển không quá 40 bước để hoàn thành màn chơi"
  },
  Task_10966_Name = {
    Text = "Lập kế hoạch chiến lược"
  },
  Task_10969_Desc = {
    Text = "Khi hoàn thành, mạng sống không được dưới 80%"
  },
  Task_10969_Name = {
    Text = "An toàn là trên hết"
  },
  Task_10970_Desc = {
    Text = "Thăng cấp 1 thân thể được đánh thức từ vùng giới sâu thẳm lên bậc 4"
  },
  Task_10970_Name = {
    Text = "Tinh thông biển sâu IV"
  },
  Task_10971_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 8 lượt để giành chiến thắng"
  },
  Task_10971_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_10972_Desc = {
    Text = "Thăng cấp 1 thân thể được đánh thức từ giới vực thịt máu lên cấp 4"
  },
  Task_10972_Name = {
    Text = "Chuyên môn về thịt máu IV"
  },
  Task_10973_Desc = {
    Text = "Hoàn thành sau tối đa 7 trận chiến"
  },
  Task_10973_Name = {
    Text = "Đột kích tinh chuẩn"
  },
  Task_10974_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10974_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10975_CompleteCondDesc = {
    Text = "Phái đi cấp độ tổng>={s1}"
  },
  Task_10975_Desc = {
    Text = "\"Nó sẽ ghi lại trái tim của bạn.\"\n \"Thật sao? Vậy chắc nó đã chằng chịt vết thương rồi.\""
  },
  Task_10975_Name = {
    Text = "Nhiệm vụ điều tra: Liệu pháp hình ảnh"
  },
  Task_10975_UnlockCondDesc = {
    Text = "Hoàn thành sự kiện điều tra 1-13 được mở khóa"
  },
  Task_10976_Desc = {
    Text = "Hoàn thành sự kiện điều tra chính tuyến · khó khăn 4-12"
  },
  Task_10976_Name = {
    Text = "Nhiệm vụ 3"
  },
  Task_10977_Desc = {
    Text = "Hoàn thành trong 26 vòng"
  },
  Task_10977_Name = {
    Text = "Hoàn thành trong 26 vòng"
  },
  Task_10981_Desc = {
    Text = "Thắng cuộc chiến cuối cùng trong 5 lượt"
  },
  Task_10981_Name = {
    Text = "Thắng cuộc chiến cuối cùng trong 5 lượt"
  },
  Task_10982_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10982_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10983_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10983_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10984_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10984_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10985_Desc = {
    Text = "Điều tra dư ảnh vật chất 60 lần"
  },
  Task_10985_Name = {
    Text = "Phế tích thịt máu III"
  },
  Task_10986_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10986_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10987_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_10987_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_10988_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10988_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10989_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10989_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10991_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10991_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10992_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10992_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10993_Desc = {
    Text = "Cảnh giác với những kẻ thù ẩn nấp trong bóng tối"
  },
  Task_10993_Name = {
    Text = "Mục tiêu"
  },
  Task_10994_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10994_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10995_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10995_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_10997_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_10997_Name = {
    Text = "An toàn là trên hết"
  },
  Task_10998_Desc = {
    Text = "Hoàn thành sau tối đa 7 trận chiến"
  },
  Task_10998_Name = {
    Text = "Đột kích tinh chuẩn"
  },
  Task_10999_Desc = {
    Text = "Thắng trong vòng không quá 7 hiệp"
  },
  Task_10999_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_11003_Desc = {
    Text = "Hoàn thành khi triệu chứng không nhiều hơn 1 loại"
  },
  Task_11003_Name = {
    Text = "Tinh thần sảng khoái"
  },
  Task_11004_Desc = {
    Text = "Hỗ trợ Lơ-tan đuổi đánh kẻ địch"
  },
  Task_11004_Name = {
    Text = "Mục tiêu"
  },
  Task_11005_Desc = {
    Text = "Điều tra 120 lần hải vực tàn ảnh"
  },
  Task_11005_Name = {
    Text = "Phế tích của Biển sâu IV"
  },
  Task_11006_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_11006_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_11007_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"@1@2\""
  },
  Task_11007_Desc2 = {
    Text = "Hoàn thành sự kiện điều tra \"Nơi im lặng lên tiếng\""
  },
  Task_11007_Name2 = {
    Text = "Mẹ ơi, con không sao"
  },
  Task_11008_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_11008_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_11009_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_11009_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_11010_Desc = {
    Text = "Tích lũy tổng cộng tiêu thụ 5000 dấu đen"
  },
  Task_11010_Name = {
    Text = "Triệu Hồi Đen V"
  },
  Task_11011_Desc = {
    Text = "Tỷ lệ máu còn lại sau khi hoàn thành lớn hơn hoặc bằng 80%"
  },
  Task_11011_Name = {
    Text = "Dễ như ăn bánh"
  },
  Task_11012_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_11012_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_11013_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_11013_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_11014_Desc = {
    Text = "Tăng cường bí ẩn ba lần"
  },
  Task_11014_Name = {
    Text = "Thời gian thử nghiệm 2 (tắt)"
  },
  Task_11015_Desc = {
    Text = "Nâng cấp thân thể thức tỉnh 3 lần"
  },
  Task_11015_Name = {
    Text = "Thời gian kiểm tra 1 (chưa kích hoạt)"
  },
  Task_11016_Desc = {
    Text = "Trong trận chiến đặc biệt X (đặc biệt), số lớp trạng thái trúng độc (Y) lớn hơn hoặc bằng 20"
  },
  Task_11016_Name = {
    Text = "Liều lượng nghiện"
  },
  Task_11017_Desc = {
    Text = "Trong cuộc chiến cuối cùng, lá chắn tích lũy trong một lượt lớn hơn hoặc bằng 1500"
  },
  Task_11017_Name = {
    Text = "Phòng vệ quá mức"
  },
  Task_11018_Desc = {
    Text = "Tiêu thụ tích lũy 500 dấu đen"
  },
  Task_11018_Name = {
    Text = "Đen Gọi Hồn II"
  },
  Task_11019_Desc = {
    Text = "Sở hữu 4 thân thể được đánh thức từ biển sâu đạt cấp độ 30"
  },
  Task_11019_Name = {
    Text = "Chúa tể biển sâu III"
  },
  Task_11020_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_11020_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_11021_Desc = {
    Text = "Sở hữu 4 thân thể được đánh thức từ biển sâu cấp 50"
  },
  Task_11021_Name = {
    Text = "Chúa tể đại dương V"
  },
  Task_11022_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_11022_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_11023_Desc = {
    Text = "Có 4 thân thể được đánh thức cấp 50 của thịt máu"
  },
  Task_11023_Name = {
    Text = "Chúa tể thịt máu V"
  },
  Task_11024_Desc = {
    Text = "Tổng cộng tiêu thụ 250 dấu đen"
  },
  Task_11024_Name = {
    Text = "Gọi Hắc"
  },
  Task_11025_Desc = {
    Text = "Sở hữu 4 thân thể đánh thức sâu thẳm đạt cấp độ 10"
  },
  Task_11025_Name = {
    Text = "Lãnh chúa biển sâu"
  },
  Task_11026_Desc = {
    Text = "Có 4 thân thể được đánh thức cấp độ 60 với thuộc tính thịt máu"
  },
  Task_11026_Name = {
    Text = "Chúa tể của thịt máu VI"
  },
  Task_11027_Desc = {
    Text = "Trong loại trận đấu X cụ thể, số lượng thẻ bài đánh ra trong một lượt lớn hơn hoặc bằng 20"
  },
  Task_11027_Name = {
    Text = "Bậc thầy thẻ bài"
  },
  Task_11029_Desc = {
    Text = "Trong sự kiện điều tra \"@1@2\" cảm ứng 10 lần"
  },
  Task_11029_Desc2 = {
    Text = "Điều tra sự kiện \"Vào nơi yên lặng\" với sự cộng hưởng 10 lần"
  },
  Task_11029_Name2 = {
    Text = "Tiếng Vang Đau Khổ IV"
  },
  Task_11030_Desc = {
    Text = "Có ít nhất 8 thẻ bài khắcăng khi hoàn thành"
  },
  Task_11030_Name = {
    Text = "Lực Khắcăng"
  },
  Task_11031_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_11031_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_11032_Desc = {
    Text = "Trong chiến đấu X cụ thể, số lượng thẻ bài được rút thêm trong một lượt lớn hơn hoặc bằng 5"
  },
  Task_11032_Name = {
    Text = "Kết quả bất ngờ từ đôi tay khéo léo"
  },
  Task_11033_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"Dưới danh nghĩa bình tượng nến\"độ khó khó khăn"
  },
  Task_11033_Name = {
    Text = "Bí ẩn trong sáp khó khăn"
  },
  Task_11034_Desc = {
    Text = "Đẩy lùi Đào Đen Đá"
  },
  Task_11034_Name = {
    Text = "Mục tiêu"
  },
  Task_11035_Desc = {
    Text = "Trong chiến đấu đặc biệt X, lá chắn chồng tầng lớn hơn hoặc bằng 200(X chiến đấu tinh anh)"
  },
  Task_11035_Name = {
    Text = "Bất khả xâm phạm"
  },
  Task_11036_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"Bí mật khu Đông\" mức độ khó"
  },
  Task_11036_Name = {
    Text = "Khu Đông sương mù - khó khăn"
  },
  Task_11038_Desc = {
    Text = "Số lần kháng cự tử vong được kích hoạt khi hoàn thành nhỏ hơn hoặc bằng 1"
  },
  Task_11038_Name = {
    Text = "Chẳng kịp đối mặt với cái chết"
  },
  Task_11041_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 8 lượt để giành chiến thắng"
  },
  Task_11041_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_11042_Desc = {
    Text = "Tìm kiếm Hilaster"
  },
  Task_11042_Name = {
    Text = "Mục tiêu"
  },
  Task_11043_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_11043_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_11044_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_11044_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_11045_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_11045_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_11046_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_11046_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_11047_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_11047_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_11048_Desc = {
    Text = "Hoàn thành 100 lần biên soạn cấm kỵ"
  },
  Task_11048_Name = {
    Text = "Nhà khắc dấu bí ẩn II"
  },
  Task_11050_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_11050_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_11052_Desc = {
    Text = "Điều tra 240 lần tàn ảnh"
  },
  Task_11052_Name = {
    Text = "Phế tích Thịt Máu V"
  },
  Task_11053_Desc = {
    Text = "Giành chiến thắng trong 18 hiệp của cuộc chiến cuối cùng"
  },
  Task_11053_Name = {
    Text = "Giành chiến thắng trong 18 hiệp của cuộc chiến cuối cùng"
  },
  Task_11054_Desc = {
    Text = "Thăm căn nhà của Harriet"
  },
  Task_11054_Name = {
    Text = "Mục tiêu"
  },
  Task_11057_Desc = {
    Text = "Di chuyển không quá 40 bước để hoàn thành màn chơi"
  },
  Task_11057_Name = {
    Text = "Lập kế hoạch chiến lược"
  },
  Task_11058_Desc = {
    Text = "Hoàn thành khi triệu chứng không nhiều hơn 1 loại"
  },
  Task_11058_Name = {
    Text = "Tinh thần sảng khoái"
  },
  Task_11059_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_11059_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_11060_Desc = {
    Text = "Hoàn thành 100 lần hỗn loạn tập hợp"
  },
  Task_11060_Name = {
    Text = "Nhà lý thuyết nhóm II"
  },
  Task_11061_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_11061_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_11062_Desc = {
    Text = "Đuổi theo Muphí"
  },
  Task_11062_Name = {
    Text = "Mục tiêu"
  },
  Task_11063_Desc = {
    Text = "Tìm nguồn âm thanh"
  },
  Task_11063_Name = {
    Text = "Mục tiêu"
  },
  Task_11064_Desc = {
    Text = "Cảm ơn bạn"
  },
  Task_11064_Name = {
    Text = "Cảm ơn bạn,"
  },
  Task_11065_Desc = {
    Text = "Đánh lui Harriet"
  },
  Task_11065_Name = {
    Text = "Mục tiêu"
  },
  Task_11066_Desc = {
    Text = "Đừng quên tôi nhé."
  },
  Task_11066_Name = {
    Text = "Đừng quên tôi nhé."
  },
  Task_11067_Desc = {
    Text = "Cảm ơn các bạn…"
  },
  Task_11067_Name = {
    Text = "Cảm ơn các bạn…"
  },
  Task_11068_Desc = {
    Text = "Chiến thắng trong cuộc chiến cuối cùng dưới 15 lượt"
  },
  Task_11068_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_11069_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_11069_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_11070_Desc = {
    Text = "Hoàn thành trong tổng số 16 lượt chơi"
  },
  Task_11070_Name = {
    Text = "Hoàn thành trong tổng số 16 lượt chơi"
  },
  Task_11071_Desc = {
    Text = "Hoàn thành trong tổng số 21 lượt chơi"
  },
  Task_11071_Name = {
    Text = "Hoàn thành trong tổng số 21 lượt chơi"
  },
  Task_11072_Desc = {
    Text = "Hoàn thành trong tổng số 11 lượt chơi"
  },
  Task_11072_Name = {
    Text = "Hoàn thành trong tổng số 11 lượt chơi"
  },
  Task_11073_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_11073_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_11074_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_11074_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_11075_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_11075_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_11076_Desc = {
    Text = "Hoàn thành trong 31 lượt"
  },
  Task_11076_Name = {
    Text = "Hoàn thành trong 31 lượt"
  },
  Task_11077_Desc = {
    Text = "Có 4 thân thể hỗn độn cấp 50"
  },
  Task_11077_Name = {
    Text = "Chúa Tể Hỗn Loạn V"
  },
  Task_11078_Desc = {
    Text = "Có 4 thân thể hỗn loạn được đánh thức cấp 40"
  },
  Task_11078_Name = {
    Text = "Chúa tể Hỗn loạn IV"
  },
  Task_11079_Desc = {
    Text = "Có 4 thân thể được đánh thức cấp 10 của thịt máu"
  },
  Task_11079_Name = {
    Text = "Bậc Thầy Thịt Máu"
  },
  Task_11080_Desc = {
    Text = "Có 4 thân thể hỗn loạn ở cấp độ 60"
  },
  Task_11080_Name = {
    Text = "Chúa Tể Hỗn Loạn VI"
  },
  Task_11081_Desc = {
    Text = "Có 4 thân thể hỗn độn cấp 10 đã được đánh thức"
  },
  Task_11081_Name = {
    Text = "Bậc thầy Hỗn loạn"
  },
  Task_11082_Desc = {
    Text = "Có 4 thân thể hỗn độn cấp 30"
  },
  Task_11082_Name = {
    Text = "Chúa tể Hỗn loạn Thứ ba"
  },
  Task_11083_Desc = {
    Text = "Có 4 thân thể hỗn độn cấp 20 đã được thức tỉnh"
  },
  Task_11083_Name = {
    Text = "Chúa tể hỗn loạn II"
  },
  Task_11084_Desc = {
    Text = "Một cuộc chiến đấu kích hoạt 4 lần kháng cự tử vong và giành chiến thắng trong ván này"
  },
  Task_11084_Name = {
    Text = "Không chết không ngừng"
  },
  Task_11085_Desc = {
    Text = "Trong một lượt, tấn công kẻ địch 15 lần bằng râu chạm để giành chiến thắng"
  },
  Task_11085_Name = {
    Text = "Chúa tể lư ẩn"
  },
  Task_11086_Desc = {
    Text = "Trong vòng chơi siêu việt, kích hoạt 5 lần nhảy vọt để giành chiến thắng"
  },
  Task_11086_Name = {
    Text = "Người Nhảy Vọt Chiều"
  },
  Task_11087_Desc = {
    Text = "Một lượt tiêu thụ 5 phôi thai, và chiến thắng"
  },
  Task_11087_Name = {Text = "Đói meo"},
  Task_11088_Desc = {
    Text = "Một lượt đánh ra 15 lá bài rồi chiến thắng"
  },
  Task_11088_Name = {
    Text = "Lượt của tôi"
  },
  Task_11089_Desc = {
    Text = "Một lượt đánh ra 6 lá bài triệu chứng, và chiến thắng"
  },
  Task_11089_Name = {
    Text = "Bệnh nhân nguy kịch"
  },
  Task_11090_Desc = {
    Text = "Một lượt chơi đánh 10 lá bài \"Tấn Công\" và chiến thắng"
  },
  Task_11090_Name = {
    Text = "Tấn công vô tận"
  },
  Task_11091_Desc = {
    Text = "Chiến thắng trận đấu khi tổng số lá bài trong tay, rác bài và bộ rút bài ít hơn hoặc bằng 8 lá"
  },
  Task_11091_Name = {
    Text = "Túi trống"
  },
  Task_11092_Desc = {
    Text = "Tấn công liên tiếp \"24\""
  },
  Task_11092_Name = {
    Text = "Mục tiêu"
  },
  Task_11094_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"Cẩn thận chó dữ\"độ khó khó khăn"
  },
  Task_11094_Name = {
    Text = "Mắt Siêu Việt Chiều·Khó Khăn"
  },
  Task_11095_Desc = {
    Text = "Tiêu thụ 500000 quyền vàng hồng"
  },
  Task_11095_Name = {
    Text = "Tiêu tiền như nước"
  },
  Task_11096_Desc = {
    Text = "Tiêu thụ 1000000 quyền vàng hồng"
  },
  Task_11096_Name = {
    Text = "Tiêu tiền như rác II"
  },
  Task_11097_Desc = {
    Text = "Trận thủ lĩnh thắng, nhận được 1200 điểm"
  },
  Task_11097_Name = {
    Text = "Thắng trùm  <size=20><color=#747474>chiến thắng trùm, nhận được 1200 điểm</color></size>"
  },
  Task_11098_Desc = {
    Text = "Cuộc chiến cuối cùng thắng trong vòng 9 lượt"
  },
  Task_11098_Name = {
    Text = "Cuộc chiến cuối cùng thắng trong vòng 9 lượt"
  },
  Task_11099_Desc = {
    Text = "Quay lại bên người chủ"
  },
  Task_11099_Name = {
    Text = "Mục tiêu"
  },
  Task_11100_Desc = {
    Text = "Tìm nguồn của âm thanh"
  },
  Task_11100_Name = {
    Text = "Mục tiêu"
  },
  Task_11101_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 8 lượt để giành chiến thắng"
  },
  Task_11101_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_11102_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_11102_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_11103_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_11103_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_11104_Desc = {
    Text = "Chiến thắng trong cuộc chiến cuối cùng dưới 15 lượt"
  },
  Task_11104_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_11105_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_11105_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_11106_Desc = {
    Text = "Có 4 thân thể được đánh thức cấp 30 của thịt máu"
  },
  Task_11106_Name = {
    Text = "Chúa tể thịt máu III"
  },
  Task_11107_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_11107_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_11108_Desc = {
    Text = "Tìm thấy bình tượng nến \"Xuân\""
  },
  Task_11108_Name = {
    Text = "Mục tiêu"
  },
  Task_11109_Desc = {
    Text = "Vượt qua boong tàu"
  },
  Task_11109_Name = {
    Text = "Mục tiêu"
  },
  Task_11111_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_11111_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_11112_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_11112_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_11113_Desc = {
    Text = "Truy đuổi kẻ săn sọ"
  },
  Task_11113_Name = {
    Text = "Mục tiêu"
  },
  Task_11114_Desc = {
    Text = "Cuộc chiến cuối cùng thắng trong 8 lượt"
  },
  Task_11114_Name = {
    Text = "Cuộc chiến cuối cùng thắng trong 8 lượt"
  },
  Task_11115_Desc = {
    Text = "Hoàn thành trong tổng số 58 lượt"
  },
  Task_11115_Name = {
    Text = "Hoàn thành trong tổng số 58 lượt"
  },
  Task_11116_Desc = {
    Text = "Hoàn thành thử thách hằng ngày"
  },
  Task_11116_Name = {
    Text = "Thử thách hàng ngày"
  },
  Task_11117_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_11117_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_11118_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_11118_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_11119_Desc = {
    Text = "Tiêu diệt thân thể bị ăn mòn"
  },
  Task_11119_Name = {
    Text = "Mục tiêu"
  },
  Task_11120_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_11120_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_11121_Desc = {
    Text = "Lên thuyền cứu sinh"
  },
  Task_11121_Name = {
    Text = "Mục tiêu"
  },
  Task_11122_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_11122_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_11123_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_11123_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_11124_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_11124_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_11125_Desc = {
    Text = "Hoàn thành tất cả các nhiệm vụ trong chương này sẽ nhận được"
  },
  Task_11125_Name = {
    Text = "Giới vực Thạo Luyện IV"
  },
  Task_11126_Desc = {
    Text = "Hoàn thành 200 lần tôi luyện chế phẩm"
  },
  Task_11126_Name = {
    Text = "Chuyên gia điều chế III"
  },
  Task_11128_Desc = {
    Text = "Không sử dụng linh tri thức khẩn cấp hoàn thành"
  },
  Task_11128_Name = {
    Text = "Hoàn thành chỉ với một mạng  <size=20><color=#747474>không sử dụng linh tri thức khẩn cấp</color></size>"
  },
  Task_11129_Desc = {
    Text = "Quay lại quầy lễ tân,tìm Pandia"
  },
  Task_11129_Name = {
    Text = "Mục tiêu"
  },
  Task_11130_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_11130_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_11135_Desc = {
    Text = "Thoát khỏi Miriam"
  },
  Task_11135_Name = {
    Text = "Mục tiêu"
  },
  Task_11136_Desc = {
    Text = "Nâng cấp tổng cộng kỹ năng thân thể được đánh thức 6 lần"
  },
  Task_11136_Name = {
    Text = "Nhiệm vụ 4"
  },
  Task_11137_Desc = {
    Text = "Hoàn thành 1 lần Siêu Nghiệm Tồn Tại"
  },
  Task_11137_Name = {
    Text = "Nhiệm vụ 5"
  },
  Task_11138_Desc = {
    Text = "Tiến hành tổng hợp vật liệu một lần trong phòng luyện kim"
  },
  Task_11138_Name = {
    Text = "Nhiệm vụ 1"
  },
  Task_11139_Desc = {
    Text = "Nâng cấp 4 thân thể được đánh thức lên cấp 30"
  },
  Task_11139_Name = {
    Text = "Nhiệm vụ 2"
  },
  Task_11140_Desc = {
    Text = "Hoàn thành khe hở hỗn loạn IV"
  },
  Task_11140_Name = {
    Text = "Nhiệm vụ 3"
  },
  Task_11141_Desc = {
    Text = "Hoàn thành trong 39 lượt chơi"
  },
  Task_11141_Name = {
    Text = "Hoàn thành trong 39 lượt chơi"
  },
  Task_11142_Desc = {
    Text = "Hoàn thành trong vòng 33 vòng"
  },
  Task_11142_Name = {
    Text = "Hoàn thành trong vòng 33 vòng"
  },
  Task_11143_Desc = {
    Text = "Hoàn thành trong 54 vòng"
  },
  Task_11143_Name = {
    Text = "Hoàn thành trong 54 vòng"
  },
  Task_11144_Desc = {
    Text = "Hoàn thành trong 48 vòng chơi"
  },
  Task_11144_Name = {
    Text = "Hoàn thành trong 48 vòng chơi"
  },
  Task_11145_Desc = {
    Text = "Hoàn thành trong tổng số 14 lượt chơi"
  },
  Task_11145_Name = {
    Text = "Hoàn thành trong tổng số 14 lượt chơi"
  },
  Task_11146_Desc = {
    Text = "Di chuyển không quá 50 bước để qua màn"
  },
  Task_11146_Name = {
    Text = "Lập kế hoạch chiến lược"
  },
  Task_11147_Desc = {
    Text = "Hoàn thành trong 26 vòng"
  },
  Task_11147_Name = {
    Text = "Hoàn thành trong 26 vòng"
  },
  Task_11148_Desc = {
    Text = "Hoàn thành trong 20 lượt chơi"
  },
  Task_11148_Name = {
    Text = "Hoàn thành trong 20 lượt chơi"
  },
  Task_11149_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_11149_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_11150_Desc = {
    Text = "Hoàn thành trong tổng số 66 lượt chơi"
  },
  Task_11150_Name = {
    Text = "Hoàn thành trong tổng số 66 lượt chơi"
  },
  Task_11151_Desc = {
    Text = "Hoàn thành trong 60 vòng"
  },
  Task_11151_Name = {
    Text = "Hoàn thành trong 60 vòng"
  },
  Task_11152_Desc = {
    Text = "Hoàn thành tất cả các nhiệm vụ trong giai đoạn để nhận phần thưởng"
  },
  Task_11152_Name = {
    Text = "Giai đoạn thứ sáu"
  },
  Task_11153_Desc = {
    Text = "Hoàn thành tất cả các nhiệm vụ trong chương này sẽ nhận được"
  },
  Task_11153_Name = {
    Text = "Giới Vực Thành Thạo I"
  },
  Task_11154_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_11154_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_11155_Desc = {
    Text = "Hoàn thành khi triệu chứng không vượt quá 3 mục"
  },
  Task_11155_Name = {
    Text = "Tinh thần sảng khoái"
  },
  Task_11156_Desc = {
    Text = "Hoàn thành chương 1 của câu chuyện chính \"Bí mật khu Đông\""
  },
  Task_11157_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_11157_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_116471_Desc = {
    Text = "Sử dụng Người Đánh Thức trong Vùng Biển Sâu để thắng 2 lần trong \"Máu Đau Gộp lại\""
  },
  Task_116472_Desc = {
    Text = "Hoàn thành \"Sự nâng đỡ của gió\"ở mọi độ khó"
  },
  Task_116473_Desc = {
    Text = "Huyết mạch đau khổ đang giao hòa·Thông qua"
  },
  Task_116474_Desc = {
    Text = "Hoàn thành \"Cặp cánh sinh đôi\"độ khó điên loạn"
  },
  Task_116475_Desc = {
    Text = "Hoàn thành \"Câu chuyện cổ tích phiêu lưu\"ở mọi độ khó"
  },
  Task_116476_Desc = {
    Text = "Thông qua thế giới mộng mơ\"Ngoài chân trời·Dưới\""
  },
  Task_116477_Desc = {
    Text = "Sử dụng Người Đánh Thức trong Vùng Siêu Cấp để thắng 1 lần trong \"Máu Đau Gộp lại\""
  },
  Task_116478_Desc = {
    Text = "Hoàn thành \"Độc tố bị lãng quên\"ở mọi độ khó"
  },
  Task_116479_Desc = {
    Text = "Hoàn thành \"Thời đại ngây thơ\"ở mọi độ khó"
  },
  Task_116480_Desc = {
    Text = "Sử dụng Người Đánh Thức trong Vùng Hỗn Loạn để thắng 2 lần trong \"Máu Đau Gộp lại\""
  },
  Task_116481_Desc = {
    Text = "Hoàn thành tất cả thành tựu của \"Máu đắng hòa hợp· Khám phá quý giá\""
  },
  Task_116482_Desc = {
    Text = "Hoàn thành \"Thời đại ngây thơ\"độ khó điên loạn"
  },
  Task_116483_Desc = {
    Text = "Hoàn thành \"Tỉnh thức im lặng\"ở mọi độ khó"
  },
  Task_116484_Desc = {
    Text = "Hoàn thành \"Sổ tay cũ\"ở mọi độ khó"
  },
  Task_116485_Desc = {
    Text = "Hoàn thành \"Sổ tay cũ\"ở mọi độ khó"
  },
  Task_116486_Desc = {
    Text = "Huyết mạch đau khổ đang giao hòa·Điên loạn"
  },
  Task_116487_Desc = {
    Text = "Sử dụng Người Đánh Thức trong Vùng Biển Sâu để thắng 1 lần trong \"Máu Đau Gộp lại\""
  },
  Task_116488_Desc = {
    Text = "Huyết mạch đau khổ đang giao hòa·Cõi"
  },
  Task_116489_Desc = {
    Text = "Hoàn thành \"Cặp cánh sinh đôi\"ở mọi độ khó"
  },
  Task_116490_Desc = {
    Text = "Hoàn thành \"Độc tố bị lãng quên\"ở mọi độ khó"
  },
  Task_116491_Desc = {
    Text = "Hoàn thành \"Câu chuyện cổ tích phiêu lưu\"độ khó điên loạn"
  },
  Task_116492_Desc = {
    Text = "Hoàn thành \"Sổ tay cũ\"độ khó điên loạn"
  },
  Task_116493_Desc = {
    Text = "Hoàn thành \"Sự nâng đỡ của gió\"ở mọi độ khó"
  },
  Task_116494_Desc = {
    Text = "Hoàn thành \"Tỉnh thức im lặng\"độ khó điên loạn"
  },
  Task_116495_Desc = {
    Text = "Hoàn thành \"Câu chuyện cổ tích phiêu lưu\"ở mọi độ khó"
  },
  Task_116496_Desc = {
    Text = "Hoàn thành \"Thời đại ngây thơ\"ở mọi độ khó"
  },
  Task_116497_Desc = {
    Text = "Hoàn thành \"Độc tố bị lãng quên\"độ khó điên loạn"
  },
  Task_116498_Desc = {
    Text = "Sử dụng Người Đánh Thức trong Vùng Thịt Máu để thắng 2 lần trong \"Máu Đau Gộp lại\""
  },
  Task_116499_Desc = {
    Text = "Hoàn thành \"Sự nâng đỡ của gió\"độ khó điên loạn"
  },
  Task_116500_Desc = {
    Text = "Sử dụng Người Đánh Thức trong Vùng Thịt Máu để thắng 1 lần trong \"Máu Đau Gộp lại\""
  },
  Task_116501_Desc = {
    Text = "Hoàn thành \"Cặp cánh sinh đôi\"ở mọi độ khó"
  },
  Task_116502_Desc = {
    Text = "Hoàn thành \"Tỉnh thức im lặng\"ở mọi độ khó"
  },
  Task_116503_Desc = {
    Text = "Sử dụng Người Đánh Thức trong Vùng Siêu Cấp để thắng 2 lần trong \"Máu Đau Gộp lại\""
  },
  Task_116504_Desc = {
    Text = "Sử dụng Người Đánh Thức trong Vùng Hỗn Loạn để thắng 1 lần trong \"Máu Đau Gộp lại\""
  },
  Task_116767_Desc = {
    Text = "Hoàn thành 1 lần thử thách level Polux"
  },
  Task_116768_Desc = {
    Text = "Đăng nhập liên tiếp 1 ngày"
  },
  Task_116769_Desc = {
    Text = "Thực hiện vượt ải tồn tại siêu nghiệm 1 lầ"
  },
  Task_116770_Desc = {
    Text = "Thực hiện vượt ải tồn tại siêu nghiệm 1 lầ"
  },
  Task_116771_Desc = {
    Text = "Hoàn thành 20 nhiệm vụ"
  },
  Task_116772_Desc = {
    Text = "Giá trị luyện tập ở khu vực d-khu vực đạt đến 100"
  },
  Task_116773_Desc = {
    Text = "Hoàn thành 4 lần nhiệm vụ hàng ngày"
  },
  Task_116774_Desc = {
    Text = "Hoàn thành 20 nhiệm vụ"
  },
  Task_116775_Desc = {
    Text = "Đăng nhập liên tiếp 1 ngày"
  },
  Task_116776_Desc = {
    Text = "Hoàn thành 4 lần nhiệm vụ hàng ngày"
  },
  Task_116777_Desc = {
    Text = "Tiêu hao 1500 điểm Menophin"
  },
  Task_116778_Desc = {
    Text = "Tiêu hao 1500 điểm Menophin"
  },
  Task_116779_Desc = {
    Text = "Thức tỉnh 30 lần"
  },
  Task_116780_Desc = {
    Text = "Giá trị luyện tập ở khu vực d-khu vực đạt đến 100"
  },
  Task_116781_Desc = {
    Text = "Thức tỉnh 30 lần"
  },
  Task_116782_Desc = {
    Text = "Hoàn thành 1 lần thử thách level Polux"
  },
  Task_116793_Desc = {
    Text = "Đạt được 3 trận thắng trong mùa giải này"
  },
  Task_116793_Name = {
    Text = "3 trận thắng"
  },
  Task_116794_Desc = {
    Text = "Đạt được tích lũy 1 trận thắng trong mùa giải này"
  },
  Task_116794_Name = {
    Text = "1 trận thắng"
  },
  Task_116795_Desc = {
    Text = "Đạt được tổng cộng 6 trận thắng trong mùa giải này"
  },
  Task_116795_Name = {Text = "6 thắng"},
  Task_116796_Desc = {
    Text = "Đạt được tổng cộng 10 trận thắng trong mùa giải này"
  },
  Task_116796_Name = {Text = "10 thắng"},
  Task_116809_Desc = {
    Text = "Hoàn thành giấc mộng lạ \"Tạm biệt, vùng đất không có"
  },
  Task_116809_Name = {
    Text = "Âm thanh còn lại của giấc mơ đẹp"
  },
  Task_116810_Desc = {
    Text = "Hoàn thành giấc mộng lạ \"Tạm biệt, vùng đất không có\" độ khó khó khă"
  },
  Task_116810_Name = {
    Text = "Âm thanh còn lại của giấc mơ đẹp · Khó khăn"
  },
  Task_116820_Name = {
    Text = "Đánh bại BOSS 3 N lần"
  },
  Task_116821_Name = {
    Text = "Đánh bại BOSS 6N lần"
  },
  Task_116822_Name = {
    Text = "Tiêu diệt tất cả các BOSS"
  },
  Task_116823_Name = {
    Text = "Đánh bại BOSS 5N lần"
  },
  Task_116824_Name = {
    Text = "Đánh bại BOSS 1N lần"
  },
  Task_116825_Name = {
    Text = "Đánh bại BOSS \"4N\" lần"
  },
  Task_116826_Name = {
    Text = "Đánh bại BOSS 7N lần"
  },
  Task_116827_Name = {
    Text = "Đánh bại BOSS 2N lần"
  },
  Task_116884_Desc = {
    Text = "Đăng nhập liên tiếp 11 ngày"
  },
  Task_116885_Desc = {
    Text = "Đăng nhập tích lũy trong 13 ngày"
  },
  Task_116886_Desc = {
    Text = "Đăng nhập liên tiếp 7 ngày"
  },
  Task_116887_Desc = {
    Text = "Đăng nhập liên tiếp trong 9 ngày"
  },
  Task_116888_Desc = {
    Text = "Đăng nhập liên tiếp trong 10 ngày"
  },
  Task_116890_Desc = {
    Text = "Đăng nhập liên tiếp 8 ngày"
  },
  Task_116891_Desc = {
    Text = "Đăng nhập tích lũy 16 ngày liên tiếp"
  },
  Task_116892_Desc = {
    Text = "Tích lũy đăng nhập 15 ngày"
  },
  Task_116894_Desc = {
    Text = "Đăng nhập liên tiếp 4 ngày"
  },
  Task_116895_Desc = {
    Text = "Đăng nhập liên tiếp 5 ngày"
  },
  Task_116896_Desc = {
    Text = "Đăng nhập liên tiếp 3 ngày"
  },
  Task_116897_Desc = {
    Text = "Đăng nhập liên tiếp 6 ngày"
  },
  Task_116899_Desc = {
    Text = "Đăng nhập liên tiếp 1 ngày"
  },
  Task_116900_Desc = {
    Text = "Tích lũy đăng nhập 14 ngày"
  },
  Task_116901_Desc = {
    Text = "Đăng nhập liên tiếp 2 ngày"
  },
  Task_116903_Desc = {
    Text = "Đăng nhập liên tiếp 12 ngày"
  },
  Task_117156_Desc = {
    Text = "Sử dụng thân thể được đánh thức vùng giới biển sâu trong \"Thành Phố Trên Hồ\"để chiến thắng 1 lần"
  },
  Task_117157_Desc = {
    Text = "Sử dụng thân thể được đánh thức của giới vực thịt máu để chiến thắng 1 lần trong \"Thành Phố Trên Hồ\""
  },
  Task_117158_Desc = {
    Text = "Sử dụng thân thể được đánh thức siêu không gian giới vực để chiến thắng 1 lần trong \"Thành Phố Trên Hồ\""
  },
  Task_117159_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong giới vực hỗn loạn để chiến thắng 1 lần tại \"thành phố trên hồ\""
  },
  Task_117304_Desc = {
    Text = "Đạt được tích lũy 1 trận thắng trong mùa giải này"
  },
  Task_117304_Name = {
    Text = "1 trận thắng"
  },
  Task_117305_Desc = {
    Text = "Đạt được tổng cộng 6 trận thắng trong mùa giải này"
  },
  Task_117305_Name = {Text = "6 thắng"},
  Task_117306_Desc = {
    Text = "Đạt được 3 trận thắng trong mùa giải này"
  },
  Task_117306_Name = {
    Text = "3 trận thắng"
  },
  Task_117307_Desc = {
    Text = "Đạt được tổng cộng 10 trận thắng trong mùa giải này"
  },
  Task_117307_Name = {Text = "10 thắng"},
  Task_117487_Desc = {
    Text = "Hoàn thành Thế giới mộng mơ \"Tạm biệt miền đất không bao giờ\" độ khó khó khăn"
  },
  Task_117487_Name = {
    Text = "Không bao giờ khuất phục · Khó khăn"
  },
  Task_117488_Desc = {
    Text = "Hoàn thành Thế giới mộng mơ \"Tạm biệt miền đất không bao giờ\""
  },
  Task_117488_Name = {
    Text = "Không bao giờ khuất phục"
  },
  Task_117489_Desc = {
    Text = "Hoàn thành Thế giới mộng mơ \"Ngoài chân trời·Xuống\""
  },
  Task_117489_Name = {
    Text = "Trên bầu trời xanh"
  },
  Task_118481_Desc = {
    Text = "Mang Murphy đi"
  },
  Task_118481_Name = {
    Text = "Mục tiêu"
  },
  Task_118482_Desc = {
    Text = "Xông vào hiện trường nghi thức cứu Murphy"
  },
  Task_118482_Name = {
    Text = "Mục tiêu"
  },
  Task_118483_Desc = {
    Text = "Quay trở lại thiên đường"
  },
  Task_118483_Name = {
    Text = "Mục tiêu"
  },
  Task_118484_Desc = {
    Text = "Mở ra bức màn mộng"
  },
  Task_118484_Name = {
    Text = "Mục tiêu"
  },
  Task_118485_Desc = {
    Text = "Nghi thức dẫn tàu"
  },
  Task_118485_Name = {
    Text = "Mục tiêu"
  },
  Task_118486_Desc = {
    Text = "Đáp trả những con cá bay trên trời"
  },
  Task_118486_Name = {
    Text = "Mục tiêu"
  },
  Task_118487_Desc = {
    Text = "Đánh bật những thủy thủ đang truy đuổi"
  },
  Task_118487_Name = {
    Text = "Mục tiêu"
  },
  Task_118488_Desc = {
    Text = "Đến cuối con đường"
  },
  Task_118488_Name = {
    Text = "Mục tiêu"
  },
  Task_118489_Desc = {
    Text = "Tiêu diệt \"Bản thân\""
  },
  Task_118489_Name = {
    Text = "Mục tiêu"
  },
  Task_118490_Desc = {
    Text = "Cứu Murphy trong hỗn loạn"
  },
  Task_118490_Name = {
    Text = "Mục tiêu"
  },
  Task_118787_Desc = {
    Text = "Cáo ca của Thánh thai"
  },
  Task_118791_Desc = {
    Text = "Dây xích đen tối"
  },
  Task_118796_Desc = {
    Text = "Di sản sa mạc"
  },
  Task_118799_Desc = {
    Text = "Thuyền Biển Tối"
  },
  Task_118809_Desc = {
    Text = "Bức tường sa mạc"
  },
  Task_118821_Desc = {
    Text = "Bí mật tượng nến"
  },
  Task_118826_Desc = {
    Text = "Dư ảnh đục"
  },
  Task_118835_Desc = {
    Text = "Residu Lãnh Cảm"
  },
  Task_118837_Desc = {
    Text = "Bảo tàng sáp điên rồ"
  },
  Task_118842_Desc = {
    Text = "Tìm kiếm phiếu vàng"
  },
  Task_118845_Desc = {
    Text = "Biển Bão Ngoài"
  },
  Task_118852_Desc = {
    Text = "Residu hữu cơ"
  },
  Task_118856_Desc = {
    Text = "Thị trấn hỗn loạn"
  },
  Task_118860_Desc = {
    Text = "Nước mắt búp bê"
  },
  Task_118871_Desc = {
    Text = "Họng Schwarzschild"
  },
  Task_118873_Desc = {
    Text = "Sarang Cacing"
  },
  Task_118877_Desc = {
    Text = "Chế phẩm luyện kim"
  },
  Task_118879_Desc = {
    Text = "Cluster hỗn loạn"
  },
  Task_118881_Desc = {
    Text = "Khe nứt Nguyên thủy"
  },
  Task_118892_Desc = {
    Text = "Grip Kesalehan"
  },
  Task_118907_Desc = {
    Text = "Phế tích của Ponape"
  },
  Task_118913_Desc = {
    Text = "Bóng dáng bên ngoài giới hạn"
  },
  Task_118915_Desc = {
    Text = "Dòng thủy hồ đen"
  },
  Task_118917_Desc = {
    Text = "Dư ảnh chiều"
  },
  Task_118918_Desc = {
    Text = "Dãy núi Hỗn loạn"
  },
  Task_118922_Desc = {
    Text = "Thành phố Sương Quái Dị"
  },
  Task_118979_Desc = {
    Text = "Cờ gặp cao thủ·Lựa chọn vòng"
  },
  Task_118980_Desc = {
    Text = "Không sử dụng thể thức tỉnh \"<color=#ae6abb>Trí tuệ</color>\"đạt 20 trận thắng"
  },
  Task_118981_Desc = {
    Text = "Trong trận chiến, nhấp vào biểu tượng để gửi biểu hiện \"Xin chào\" hoặc \"Hi\" cho 3 đối thủ"
  },
  Task_118982_Desc = {
    Text = "Trong chế độ tiền nhóm đã đạt được 500 điểm"
  },
  Task_118983_Desc = {
    Text = "Không sử dụng thể thức tỉnh \"<color=#76bf9d>Phước lành</color>\"đạt 20 trận thắng"
  },
  Task_118984_Desc = {
    Text = "Từng đạt 1000 điểm trong chế độ lựa chọn vòng"
  },
  Task_118985_Desc = {
    Text = "Từng đạt 2500 điểm trong chế độ lựa chọn vòng"
  },
  Task_118986_Desc = {
    Text = "Hoàn thành tất cả thành tựu \"Khởi đầu Bẫy\""
  },
  Task_118987_Desc = {
    Text = "Không sử dụng thể thức tỉnh \"<color=#6a97c2>Người bảo vệ</color>\"đạt 20 trận thắng"
  },
  Task_118988_Desc = {
    Text = "Khởi đầu tương phùng"
  },
  Task_118989_Desc = {
    Text = "Tại \"Biểu cảm đối kháng\" mang theo 16 biểu cảm tham gia trận chiến đối kháng không gian một lần"
  },
  Task_118990_Desc = {
    Text = "Sao chép đội hình đối thủ sau khi trận đấu đối kháng kết thúc"
  },
  Task_118991_Desc = {
    Text = "Tham gia 1 lần \"Chế độ luân chọn\""
  },
  Task_118992_Desc = {
    Text = "Trong chế độ tiền nhóm đã đạt được 2000 điểm"
  },
  Task_118993_Desc = {
    Text = "Từng đạt 2000 điểm trong chế độ lựa chọn vòng"
  },
  Task_118994_Desc = {
    Text = "Từng đạt 500 điểm trong chế độ lựa chọn vòng"
  },
  Task_118995_Desc = {
    Text = "Sau khi trận chiến Bẫy kết thúc, với đối thủ\"Chơi lại một ván nữa\""
  },
  Task_118996_Desc = {
    Text = "Trong chế độ tiền nhóm đã đạt được 1000 điểm"
  },
  Task_118997_Desc = {
    Text = "Không sử dụng \"<color=#c26669>Tranh đấu</color>\" thể thức tỉnh để đạt 20 chiến thắng"
  },
  Task_118998_Desc = {
    Text = "Thích bài đánh giá trong \"Sưu tầm\""
  },
  Task_118999_Desc = {
    Text = "Trong「Sưu tầm」chơi thử thức tỉnh thể và đánh bại 1「Mèo đen quen thuộc」"
  },
  Task_119000_Desc = {
    Text = "Trong chế độ tiền nhóm đã đạt được 3000 điểm"
  },
  Task_119001_Desc = {
    Text = "Tham gia 1 lần \"Chế độ chuẩn bị\""
  },
  Task_119002_Desc = {
    Text = "Trong chế độ tiền nhóm đã đạt được 1500 điểm"
  },
  Task_119003_Desc = {
    Text = "Từng đạt 3000 điểm trong chế độ lựa chọn vòng"
  },
  Task_119004_Desc = {
    Text = "Từng đạt 1500 điểm trong chế độ lựa chọn vòng"
  },
  Task_119005_Desc = {
    Text = "Cờ gặp cao thủ·Chuẩn bị trước"
  },
  Task_119006_Desc = {
    Text = "Tại「Hồ sơ người giữ gìn」xem lại bản ghi trận chiến của「Đối kháng không gian」"
  },
  Task_119007_Desc = {
    Text = "Tham gia 1 lần \"Chiến đấu mật mã\""
  },
  Task_119008_Desc = {
    Text = "Trong chế độ tiền nhóm đã đạt được 2500 điểm"
  },
  Task_119009_Desc = {
    Text = "Không sử dụng \"<color=#c3aa64>Hung tinh</color>\" thể thức tỉnh để đạt 20 chiến thắng"
  },
  Task_119010_Desc = {
    Text = "Khai sáng vạn tượng"
  },
  Task_119193_Desc = {
    Text = "Tích lũy trích xuất 68000 nguồn lỏng"
  },
  Task_119201_Desc = {
    Text = "Tích lũy rút 54000 Bạc nguyên thủy"
  },
  Task_119212_Desc = {
    Text = "Tích lũy rút 42000 Bạc nguyên thủy"
  },
  Task_119216_Desc = {
    Text = "Tích lũy rút 48000 Bạc nguyên thủy"
  },
  Task_119217_Desc = {
    Text = "Tích lũy rút 36000 Bạc nguyên thủy"
  },
  Task_119695_Desc = {
    Text = "Đăng nhập liên tiếp 1 ngày"
  },
  Task_119696_Desc = {
    Text = "Hoàn thành chương 4 của phần quên \"Trong im lặng\""
  },
  Task_119697_Desc = {
    Text = "Thông quan chương 4 phần sao phía trên \"Vườn Địa Đàng\""
  },
  Task_119698_Desc = {
    Text = "Tích lũy sử dụng 200 lần mật lệnh"
  },
  Task_119699_Desc = {
    Text = "Hoàn thành chương 7 \"Dục Hà\" của phần Quên Lãng"
  },
  Task_120441_Desc = {
    Text = "Hoàn thành Chương 7 của \"Hoạt động điều tra\""
  },
  Task_120500_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_120501_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_120502_Desc = {
    Text = "Trong sự kiện điều tra \"@1@2\" cộng hưởng 2 lần"
  },
  Task_120502_Desc2 = {
    Text = "Trong điều tra sự kiện \"thiên đường\" cộng hưởng 2 lần"
  },
  Task_120502_Name2 = {
    Text = "Tiếng vọng hư vô"
  },
  Task_120503_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"@1@2\""
  },
  Task_120503_Desc2 = {
    Text = "Hoàn thành sự kiện điều tra \"Thiên đường\""
  },
  Task_120503_Name2 = {
    Text = "Sự sụp đổ của thiên đường"
  },
  Task_120504_Desc = {
    Text = "Thông quan chương 4 phần sao phía trên 4-6"
  },
  Task_120505_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"Thiên đường\" khó khă"
  },
  Task_120505_Name = {
    Text = "Sự sụp đổ của thiên đường · khó khăn"
  },
  Task_120506_Desc = {
    Text = "Trong cuộc điều tra sự kiện \"@1@2\" gây cộng hưởng 6 lần"
  },
  Task_120506_Desc2 = {
    Text = "Trong điều tra sự kiện \"thiên đường\" cộng hưởng 6 lần"
  },
  Task_120506_Name2 = {
    Text = "Tiếng vọng hư vô III"
  },
  Task_120507_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_120508_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_120509_Desc = {
    Text = "Thông quan chương 4 phần sao phía trên độ khó \"Vườn Địa Đàng\""
  },
  Task_120510_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_120511_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_120512_Desc = {
    Text = "Thông quan chương 4 phần sao phía trên 4-6"
  },
  Task_120514_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_120515_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_120516_Desc = {
    Text = "Thông quan chương 4 phần sao phía trên độ khó 4-5"
  },
  Task_120517_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_120518_Desc = {
    Text = "Thông quan chương 4 phần sao phía trên độ khó 4-5"
  },
  Task_120519_Desc = {
    Text = "Thông quan chương 4 phần sao phía trên \"Vườn Địa Đàng\""
  },
  Task_120520_Desc = {
    Text = "Trong sự kiện điều tra \"@1@2\" cảm ứng 7 lần"
  },
  Task_120520_Desc2 = {
    Text = "Trong điều tra sự kiện \"thiên đường\" cộng hưởng 7 lần"
  },
  Task_120520_Name2 = {
    Text = "Tiếng vọng hư vô IV"
  },
  Task_120521_Desc = {
    Text = "Thông quan chương 4 phần sao phía trên độ khó \"Vườn Địa Đàng\""
  },
  Task_120522_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_120523_Desc = {
    Text = "Trong sự kiện điều tra \"@1@2\" cộng hưởng 4 lần"
  },
  Task_120523_Desc2 = {
    Text = "Trong điều tra sự kiện \"thiên đường\" cộng hưởng 4 lần"
  },
  Task_120523_Name2 = {
    Text = "Tiếng vọng hư vô II"
  },
  Task_120524_Desc = {
    Text = "Thông quan chương 4 phần sao phía trên \"Vườn Địa Đàng\""
  },
  Task_120535_Desc = {
    Text = "Hoàn thành chương 4 của phần quên \"Trong im lặng\""
  },
  Task_120536_Desc = {
    Text = "Hoàn thành chương 7 \"Dục Hà\" của phần Quên Lãng"
  },
  Task_120537_Desc = {
    Text = "Đăng nhập liên tiếp 1 ngày"
  },
  Task_120538_Desc = {
    Text = "Thông quan chương 4 phần sao phía trên \"Vườn Địa Đàng\""
  },
  Task_120549_Desc = {
    Text = "Chiến đấu đến 100 trận cuối cùng trong trận chiến không đầu hàng trong bẫy"
  },
  Task_120850_Desc = {
    Text = "Chỉ sử dụng Thức tỉnh cõi huyết nhục vượt qua 1 lần \"Lao xuống huyễn tưởng\""
  },
  Task_120851_Desc = {
    Text = "Thống qua 1 lần \"Lao xuống huyễn tưởng\" bằng thể thức tỉnh hỗn mang và siêu cấp"
  },
  Task_120852_Desc = {
    Text = "Chỉ sử dụng Thức tỉnh cõi hỗn loạn vượt qua 1 lần \"Lao xuống huyễn tưởng\""
  },
  Task_120855_Desc = {
    Text = "\"Lao xuống huyễn tưởng\"điểm cao nhất đạt 1000"
  },
  Task_120856_Desc = {
    Text = "Thống qua 1 lần \"Lao xuống huyễn tưởng\" bằng thể thức tỉnh hỗn mang và huyết nhục"
  },
  Task_120857_Desc = {
    Text = "Chỉ sử dụng thức tỉnh hỗn loạn để hoàn thành 5 lần khó khăn VI trở lên của \"Lao xuống huyễn tưởng\""
  },
  Task_120862_Desc = {
    Text = "Chỉ sử dụng thức tỉnh huyết nhục để hoàn thành 5 lần khó khăn VI trở lên của \"Lao xuống huyễn tưởng\""
  },
  Task_120863_Desc = {
    Text = "Sử dụng thức tỉnh hỗn loạn và thức tỉnh biển sâu để hoàn thành 5 lần khó khăn VI trở lên của \"Lao xuống huyễn tưởng\""
  },
  Task_120864_Desc = {
    Text = "Sử dụng thức tỉnh hỗn loạn và thức tỉnh siêu cấp để hoàn thành 5 lần khó khăn VI trở lên của \"Lao xuống huyễn tưởng\""
  },
  Task_120865_Desc = {
    Text = "Thống qua 1 lần \"Lao xuống huyễn tưởng\" bằng thể thức tỉnh hải vực và siêu cấp"
  },
  Task_120867_Desc = {
    Text = "Sử dụng Thủy quái và Thịt để đánh thức cơ thể hoàn thành 5 lần Thám hiểm Giấc mơ với độ khó VI trở lên"
  },
  Task_120868_Desc = {
    Text = "Dưới cơn ác mộng"
  },
  Task_120869_Desc = {
    Text = "Chỉ sử dụng thức tỉnh siêu cấp để hoàn thành 5 lần khó khăn VI trở lên của \"Lao xuống huyễn tưởng\""
  },
  Task_120870_Desc = {
    Text = "Sử dụng thức tỉnh hỗn loạn và thức tỉnh huyết nhục để hoàn thành 5 lần khó khăn VI trở lên của \"Lao xuống huyễn tưởng\""
  },
  Task_120871_Desc = {
    Text = "\"Lao xuống huyễn tưởng\"điểm cao nhất đạt 7000"
  },
  Task_120872_Desc = {
    Text = "Chỉ sử dụng Thức tỉnh vùng biển sâu vượt qua 1 lần \"Lao xuống huyễn tưởng\""
  },
  Task_120873_Desc = {
    Text = "Chỉ sử dụng thức tỉnh biển sâu để hoàn thành 5 lần khó khăn VI trở lên của \"Lao xuống huyễn tưởng\""
  },
  Task_120876_Desc = {
    Text = "Du lịch cõi biể"
  },
  Task_120878_Desc = {
    Text = "\"Lao xuống huyễn tưởng\"điểm cao nhất đạt 6000"
  },
  Task_120879_Desc = {
    Text = "Sử dụng thức tỉnh biển sâu và thức tỉnh siêu cấp để hoàn thành 5 lần khó khăn VI trở lên của \"Lao xuống huyễn tưởng\""
  },
  Task_120880_Desc = {
    Text = "Tại「Bảng xếp hạng Lao xuống huyễn tưởng」xem lại 1 lần"
  },
  Task_120882_Desc = {
    Text = "Chỉ sử dụng thức tỉnh siêu cấp cõi thông qua 1 lần \"Lao xuống huyễn tưởng\""
  },
  Task_120883_Desc = {
    Text = "Thống qua 1 lần \"Lao xuống huyễn tưởng\" bằng thể thức tỉnh huống mang và hải vực"
  },
  Task_120884_Desc = {
    Text = "Sử dụng thức tỉnh huyết nhục và thức tỉnh siêu cấp để hoàn thành 5 lần khó khăn VI trở lên của \"Lao xuống huyễn tưởng\""
  },
  Task_120885_Desc = {
    Text = "Lần đầu bước vào biển mơ"
  },
  Task_120889_Desc = {
    Text = "\"Lao xuống huyễn tưởng\"điểm cao nhất đạt 5000"
  },
  Task_120890_Desc = {
    Text = "Hoàn thành 1 lần \"Giấc mơ thám hiểm\""
  },
  Task_120891_Desc = {
    Text = "Tại「Bảng xếp hạng Lao xuống huyễn tưởng」sao chép 1 lần đội hình"
  },
  Task_120892_Desc = {
    Text = "\"Lao xuống huyễn tưởng\"điểm cao nhất đạt 2000"
  },
  Task_120894_Desc = {
    Text = "\"Lao xuống huyễn tưởng\"điểm cao nhất đạt 4000"
  },
  Task_120895_Desc = {
    Text = "\"Lao xuống huyễn tưởng\"điểm cao nhất đạt 3000"
  },
  Task_120966_Desc = {
    Text = "Đạt được 3 trận thắng trong mùa giải này"
  },
  Task_120966_Name = {
    Text = "3 trận thắng"
  },
  Task_120967_Desc = {
    Text = "Đạt được tổng cộng 6 trận thắng trong mùa giải này"
  },
  Task_120967_Name = {Text = "6 thắng"},
  Task_120968_Desc = {
    Text = "Đạt được tổng cộng 10 trận thắng trong mùa giải này"
  },
  Task_120968_Name = {Text = "10 thắng"},
  Task_120969_Desc = {
    Text = "Đạt được tích lũy 1 trận thắng trong mùa giải này"
  },
  Task_120969_Name = {
    Text = "1 trận thắng"
  },
  Task_120994_Desc = {
    Text = "Tiêu diệt tất cả các phân thân của \"Tái chiến Nguyên Thủy·Khúc nhạc mất hòa\""
  },
  Task_120994_Name = {
    Text = "Đánh bại BOSS1"
  },
  Task_120995_Desc = {
    Text = "Tiêu diệt tất cả các phân thân của \"Tái chiến Nguyên Thủy·Âm hưởng đảo lộn\""
  },
  Task_120995_Name = {
    Text = "Đánh bại BOSS4 (Trùm 4)"
  },
  Task_120996_Name = {
    Text = "Sự kiện Boss Thế Giới kết thúc"
  },
  Task_120997_Desc = {
    Text = "Tiêu diệt tất cả các phân thân của \"Tái chiến Nguyên Thủy·Giấc ngủ vĩnh cửu\""
  },
  Task_120997_Name = {
    Text = "Đánh bại BOSS7"
  },
  Task_120998_Desc = {
    Text = "Tiêu diệt tất cả các phân thân của \"Tái Chiến Nguyên Thủy · Điệu Nhạc Tĩnh Mịch\""
  },
  Task_120998_Name = {
    Text = "Tiêu diệt BOSS3"
  },
  Task_120999_Desc = {
    Text = "Tiêu diệt tất cả các phân thân của \"Tái chiến Nguyên Thủy·Tà Tín Tấu Âm\""
  },
  Task_120999_Name = {
    Text = "Đánh bại BOSS5"
  },
  Task_121000_Desc = {
    Text = "Tiêu diệt tất cả các phân thân của \"Tái chiến Nguyên Thủy·Chương điên cuồng\""
  },
  Task_121000_Name = {
    Text = "Đánh bại Trùm 6"
  },
  Task_121001_Desc = {
    Text = "Tiêu diệt tất cả các phân thân của \"Tái chiến Nguyên Thủy·Tiền tố hỗn loạn\""
  },
  Task_121001_Name = {
    Text = "Tiêu diệt BOSS2"
  },
  Task_121033_Desc = {
    Text = "Tích lũy thức tỉnh 30 lần"
  },
  Task_121035_Desc = {
    Text = "Hoàn thành 20 nhiệm vụ"
  },
  Task_121040_Desc = {
    Text = "Hoàn thành 4 lần nhiệm vụ hàng ngày"
  },
  Task_121041_Desc = {
    Text = "Hoàn thành 20 nhiệm vụ"
  },
  Task_121042_Desc = {
    Text = "Tiêu hao 1500 điểm Menophin"
  },
  Task_121044_Desc = {
    Text = "Thực hiện vượt ải tồn tại siêu nghiệm 1 lầ"
  },
  Task_121045_Desc = {
    Text = "Đăng nhập liên tiếp 1 ngày"
  },
  Task_121046_Desc = {
    Text = "Hoàn thành 1 lần chơi thử Mộc Hạ"
  },
  Task_121047_Desc = {
    Text = "Tích lũy thức tỉnh 30 lần"
  },
  Task_121050_Desc = {
    Text = "Tiêu hao 1500 điểm Menophin"
  },
  Task_121051_Desc = {
    Text = "Giá trị luyện tập ở khu vực d-khu vực đạt đến 100"
  },
  Task_121053_Desc = {
    Text = "Giá trị luyện tập ở khu vực d-khu vực đạt đến 100"
  },
  Task_121054_Desc = {
    Text = "Hoàn thành 4 lần nhiệm vụ hàng ngày"
  },
  Task_121058_Desc = {
    Text = "Thực hiện vượt ải tồn tại siêu nghiệm 1 lầ"
  },
  Task_121061_Desc = {
    Text = "Đăng nhập liên tiếp 1 ngày"
  },
  Task_121062_Desc = {
    Text = "Hoàn thành 1 lần chơi thử Mộc Hạ"
  },
  Task_121206_Desc = {
    Text = "Tích lũy trích xuất 76000 nguồn lỏng"
  },
  Task_121207_Desc = {
    Text = "Tích lũy trích xuất 84000 nguồn lỏng"
  },
  Task_121208_Desc = {
    Text = "Tích lũy trích xuất 92000 nguồn lỏng"
  },
  Task_121233_Desc = {
    Text = "Trong \"Nắm giữ tâm thành IV\"đạt được xếp hạng ba sao"
  },
  Task_121234_Desc = {
    Text = "Trong \"Bí mật của tượng sáp II\"đạt được xếp hạng ba sao"
  },
  Task_121235_Desc = {
    Text = "Đạt xếp hạng ba sao trong \"Di vật hữu cơ III\""
  },
  Task_121236_Desc = {
    Text = "Trong \"Giọt nước mắt búp bê V\"đạt được xếp hạng ba sao"
  },
  Task_121237_Desc = {
    Text = "Trong \"Bí mật của tượng sáp III\"đạt được xếp hạng ba sao"
  },
  Task_121238_Desc = {
    Text = "Trong \"Cuộc tìm kiếm phiếu vàng I\"đạt được xếp hạng ba sao"
  },
  Task_121239_Desc = {
    Text = "Trong \"Hình bóng ngoài giới IV\"đạt được xếp hạng ba sao"
  },
  Task_121240_Desc = {
    Text = "Đạt được xếp hạng ba sao trong \"Cụm hỗn loạn IV\""
  },
  Task_121241_Desc = {
    Text = "Đạt xếp hạng ba sao trong \"Khúc ca thánh thai II\""
  },
  Task_121242_Desc = {
    Text = "Trong \"Chiếc thuyền đen III\"đạt được xếp hạng ba sao"
  },
  Task_121243_Desc = {
    Text = "Trong \"Chuỗi đen III\"đạt được xếp hạng ba sao"
  },
  Task_121244_Desc = {
    Text = "Trong \"Hình bóng sâu V\"đạt được xếp hạng ba sao"
  },
  Task_121245_Desc = {
    Text = "Trong \"Hình bóng chiều không gian I\"đạt được xếp hạng ba sao"
  },
  Task_121246_Desc = {
    Text = "Đạt xếp hạng ba sao trong \"Núi mất trật tự II\""
  },
  Task_121247_Desc = {
    Text = "Đạt xếp hạng ba sao trong \"Thành phố sương mù II\""
  },
  Task_121248_Desc = {
    Text = "Đạt được xếp hạng ba sao trong \"Phế tích Bonape II\""
  },
  Task_121249_Desc = {
    Text = "Đạt xếp hạng ba sao trong \"Di vật hữu cơ II\""
  },
  Task_121250_Desc = {
    Text = "Đạt xếp hạng ba sao trong \"Núi mất trật tự I\""
  },
  Task_121251_Desc = {
    Text = "Trong \"Hình bóng chiều không gian II\"đạt được xếp hạng ba sao"
  },
  Task_121252_Desc = {
    Text = "Trong \"Hình bóng mờ IV\"đạt được xếp hạng ba sao"
  },
  Task_121253_Desc = {
    Text = "Trong \"Bảo tàng sáp cuồng loạn II\"đạt được xếp hạng ba sao"
  },
  Task_121254_Desc = {
    Text = "Trong \"Nắm giữ tâm thành I\"đạt được xếp hạng ba sao"
  },
  Task_121255_Desc = {
    Text = "Đạt được điểm ba sao trong \"Hỗn loạn cụm I\""
  },
  Task_121256_Desc = {
    Text = "Trong \"Bí mật của tượng sáp IV\"đạt được xếp hạng ba sao"
  },
  Task_121257_Desc = {
    Text = "Đạt được xếp hạng sao ba trong \"Nơi của giun I\""
  },
  Task_121258_Desc = {
    Text = "Trong \"Bức tường cát hoang I\"đạt được xếp hạng ba sao"
  },
  Task_121259_Desc = {
    Text = "Trong \"Giọt nước mắt búp bê II\"đạt được xếp hạng ba sao"
  },
  Task_121260_Desc = {
    Text = "Trong \"Nắm giữ tâm thành III\"đạt được xếp hạng ba sao"
  },
  Task_121261_Desc = {
    Text = "Trong \"Hình bóng ngoài giới III\"đạt được xếp hạng ba sao"
  },
  Task_121262_Desc = {
    Text = "Trong \"Di tích biển cát III\"đạt được xếp hạng ba sao"
  },
  Task_121263_Desc = {
    Text = "Nhận được đánh giá ba sao trong \"Hỗn Loạn Quần Tập II\""
  },
  Task_121264_Desc = {
    Text = "Trong \"Thị trấn hỗn loạnI\"đạt được xếp hạng ba sao"
  },
  Task_121265_Desc = {
    Text = "Trong \"Hình bóng sâu I\"đạt được xếp hạng ba sao"
  },
  Task_121266_Desc = {
    Text = "Trong \"Di tích biển cát I\"đạt được xếp hạng ba sao"
  },
  Task_121267_Desc = {
    Text = "Trong \"Bảo tàng sáp cuồng loạn III\"đạt được xếp hạng ba sao"
  },
  Task_121268_Desc = {
    Text = "Trong \"Hình bóng sâu IV\"đạt được xếp hạng ba sao"
  },
  Task_121269_Desc = {
    Text = "Đạt được xếp hạng ba sao trong \"Họng Schwarzschild IV\""
  },
  Task_121270_Desc = {
    Text = "Trong \"Hình bóng chiều không gian III\"đạt được xếp hạng ba sao"
  },
  Task_121271_Desc = {
    Text = "Trong \"Tìm kiếm voucherIV\"đạt được xếp hạng ba sao"
  },
  Task_121272_Desc = {
    Text = "Trong \"Hình bóng sâu III\"đạt được xếp hạng ba sao"
  },
  Task_121273_Desc = {
    Text = "Đạt xếp hạng ba sao trong \"Tinh chế chế phẩm I\""
  },
  Task_121274_Desc = {
    Text = "Trong \"Bí mật của tượng sáp V\"đạt được xếp hạng ba sao"
  },
  Task_121275_Desc = {
    Text = "Trong \"Di tích biển cát II\"đạt được xếp hạng ba sao"
  },
  Task_121276_Desc = {
    Text = "Trong \"Bảo tàng sáp cuồng loạn I\"đạt được xếp hạng ba sao"
  },
  Task_121277_Desc = {
    Text = "Đạt xếp hạng ba sao trong \"Núi mất trật tự III\""
  },
  Task_121278_Desc = {
    Text = "Đạt xếp hạng ba sao trong \"Tinh chế chế phẩm IV\""
  },
  Task_121279_Desc = {
    Text = "Trong \"Giọt nước mắt búp bê III\"đạt được xếp hạng ba sao"
  },
  Task_121280_Desc = {
    Text = "Đạt xếp hạng ba sao trong \"Di vật hữu cơ V\""
  },
  Task_121281_Desc = {
    Text = "Đạt xếp hạng ba sao trong \"Chiến thuyền biển tối I\""
  },
  Task_121282_Desc = {
    Text = "Trong \"Thủy triều vũng đenII\"đạt được xếp hạng ba sao"
  },
  Task_121283_Desc = {
    Text = "Trong \"Hình bóng mờ III\"đạt được xếp hạng ba sao"
  },
  Task_121284_Desc = {
    Text = "Trong \"Nắm giữ tâm thành II\"đạt được xếp hạng ba sao"
  },
  Task_121285_Desc = {
    Text = "Trong \"Bão ngoài khơiI\"đạt được xếp hạng ba sao"
  },
  Task_121286_Desc = {
    Text = "Trong \"Bí mật của tượng sáp I\"đạt được xếp hạng ba sao"
  },
  Task_121287_Desc = {
    Text = "Đạt được đánh giá ba sao trong \"Di Tích Pohnpei III\""
  },
  Task_121288_Desc = {
    Text = "Đạt xếp hạng ba sao trong \"Khúc ca thánh thai III\""
  },
  Task_121289_Desc = {
    Text = "Đạt xếp hạng ba sao trong \"Di vật hữu cơ IV\""
  },
  Task_121290_Desc = {
    Text = "Đạt xếp hạng ba sao trong \"Di vật hữu cơ I\""
  },
  Task_121291_Desc = {
    Text = "Trong \"Hình bóng ngoài giới II\"đạt được xếp hạng ba sao"
  },
  Task_121292_Desc = {
    Text = "Đạt xếp hạng ba sao trong \"Khúc ca thánh thai I\""
  },
  Task_121293_Desc = {
    Text = "Đạt xếp hạng ba sao trong \"Họng Schwarzschild III\""
  },
  Task_121294_Desc = {
    Text = "Trong \"Hình bóng ngoài giới I\"đạt được xếp hạng ba sao"
  },
  Task_121295_Desc = {
    Text = "Trong \"Cuộc tìm kiếm phiếu vàng II\"đạt được xếp hạng ba sao"
  },
  Task_121296_Desc = {
    Text = "Đạt xếp hạng ba sao trong \"Tinh chế chế phẩm V\""
  },
  Task_121297_Desc = {
    Text = "Trong \"Thị trấn hỗn loạnII\"đạt được xếp hạng ba sao"
  },
  Task_121298_Desc = {
    Text = "Đạt xếp hạng ba sao trong \"Tinh chế chế phẩm II\""
  },
  Task_121299_Desc = {
    Text = "Đạt xếp hạng ba sao trong \"Cổ họng Schwarzschild II\""
  },
  Task_121300_Desc = {
    Text = "Trong \"Tìm kiếm voucherV\"đạt được xếp hạng ba sao"
  },
  Task_121301_Desc = {
    Text = "Đạt xếp hạng ba sao trong \"Thành phố sương mù III\""
  },
  Task_121302_Desc = {
    Text = "Đạt xếp hạng ba sao trong \"Tinh chế chế phẩm III\""
  },
  Task_121303_Desc = {
    Text = "Đạt được xếp hạng ba sao trong \"Phế tích Bonape IV\""
  },
  Task_121304_Desc = {
    Text = "Đạt được xếp hạng ba sao trong \"Nhóm Hỗn Loạn III\""
  },
  Task_121305_Desc = {
    Text = "Đạt xếp hạng ba sao trong \"Thành phố sương mù I\""
  },
  Task_121306_Desc = {
    Text = "Nhận được xếp hạng ba sao trong \"Khu III của giun\""
  },
  Task_121307_Desc = {
    Text = "Trong \"Hình bóng sâu II\"đạt được xếp hạng ba sao"
  },
  Task_121308_Desc = {
    Text = "Nhận xếp hạng ba sao trong \"Nơi của Giun IV\""
  },
  Task_121309_Desc = {
    Text = "Nhận được xếp hạng ba sao trong \"Phế tích Bonape I\""
  },
  Task_121310_Desc = {
    Text = "Trong \"Hình bóng mờ II\"đạt được xếp hạng ba sao"
  },
  Task_121311_Desc = {
    Text = "Trong \"Hình bóng chiều không gian V\"đạt được xếp hạng ba sao"
  },
  Task_121312_Desc = {
    Text = "Nhận xếp hạng ba sao trong \"Nơi của Giun II\""
  },
  Task_121313_Desc = {
    Text = "Trong \"Chuỗi đen II\"đạt được xếp hạng ba sao"
  },
  Task_121314_Desc = {
    Text = "Trong \"Hình bóng chiều không gian IV\"đạt được xếp hạng ba sao"
  },
  Task_121315_Desc = {
    Text = "Trong \"Hình bóng mờ V\"đạt được xếp hạng ba sao"
  },
  Task_121316_Desc = {
    Text = "Trong \"Chuỗi đen IV\"đạt được xếp hạng ba sao"
  },
  Task_121317_Desc = {
    Text = "Trong \"Chuỗi đen I\"đạt được xếp hạng ba sao"
  },
  Task_121318_Desc = {
    Text = "Trong \"Thị trấn hỗn loạnIII\"đạt được xếp hạng ba sao"
  },
  Task_121319_Desc = {
    Text = "Trong \"Giọt nước mắt búp bê I\"đạt được xếp hạng ba sao"
  },
  Task_121320_Desc = {
    Text = "Trong \"Chiếc thuyền đen II\"đạt được xếp hạng ba sao"
  },
  Task_121321_Desc = {
    Text = "Trong \"Cuộc tìm kiếm phiếu vàng III\"đạt được xếp hạng ba sao"
  },
  Task_121322_Desc = {
    Text = "Trong \"Chuỗi đen V\"đạt được xếp hạng ba sao"
  },
  Task_121323_Desc = {
    Text = "Trong \"Giọt nước mắt búp bê IV\"đạt được xếp hạng ba sao"
  },
  Task_121324_Desc = {
    Text = "Trong \"Thủy triều vũng đenI\"đạt được xếp hạng ba sao"
  },
  Task_121325_Desc = {
    Text = "Trong \"Hình bóng mờ I\"đạt được xếp hạng ba sao"
  },
  Task_121326_Desc = {
    Text = "Đạt được xếp hạng ba sao trong \"Họng Schwarzschild I\""
  },
  Task_121327_Desc = {
    Text = "Đạt xếp hạng ba sao trong \"Vết nứt nguyên thủy I\""
  },
  Task_121331_Desc = {
    Text = "Hoàn thành tất cả nhiệm vụ \"Bước vào Biển Mộng\""
  },
  Task_121332_Desc = {
    Text = "Thông qua 1 lần \"Lao xuống huyễn tưởng\" bằng thể thức tỉnh hải vực và huyết nhục"
  },
  Task_121333_Desc = {
    Text = "Thống qua 1 lần \"Lao xuống huyễn tưởng\" bằng thể thức tỉnh huyết nhục và siêu cấp"
  },
  Task_121834_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_121834_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_121835_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_121835_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_121836_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_121836_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_121837_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_121837_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_121838_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_121838_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_121839_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_121839_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_121840_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_121840_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_121841_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_121841_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_121842_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_121842_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_121843_Desc = {
    Text = "Chịu đựng mọi lời nguyền của Thánh Tượng và đánh bại \"Hình ảnh Thiên Đường\" trong vòng 15 lượt."
  },
  Task_121843_Name = {
    Text = "Sự sụp đổ của thiên đường·Ẩn"
  },
  Task_121844_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_121844_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_121897_Desc = {
    Text = "Mỗi lượt còn lại nhận thêm 20 điểm. (Số lượt còn lại hiện tại: {s1})"
  },
  Task_121897_Name = {
    Text = "Đồng hồ cát thời gian<size=20><color=#747474>Vòng đầu tiên là 50, mỗi lượt còn lại sẽ nhận thêm 20 điểm.</color></size>"
  },
  Task_122110_Desc = {
    Text = "Mỗi ngày chơi lần đầu nhận được 500 điểm."
  },
  Task_122110_Name = {
    Text = "Người tiên phong mở rộng ước mơ<size=20><color=#747474>Chơi lần đầu mỗi ngày nhận 500 điểm</color></size>"
  },
  Task_122197_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong giới vực hỗn loạn để chiến thắng 1 lần trong \"Bản Thân Mất Mát\""
  },
  Task_122198_Desc = {
    Text = "Hoàn thành \"Chi phối Tứ Chi\"độ khó Điên cuồng"
  },
  Task_122199_Desc = {
    Text = "Hoàn thành \"Đập vỡ trái tim\"độ khó điên cuồng"
  },
  Task_122200_Desc = {
    Text = "Hoàn thành \"Cắt Ruột Thừa\"ở bất kỳ độ khó nào"
  },
  Task_122201_Desc = {
    Text = "Vượt qua \"Kiểm soát ngôn ngữ\"ở bất kỳ độ khó nào"
  },
  Task_122202_Desc = {
    Text = "Hoàn thành \"Suy nghĩ bản năng\"ở bất kỳ độ khó nào"
  },
  Task_122203_Desc = {
    Text = "Hoàn thành \"Giải Phóng Bản Thân\"độ khó điên cuồng"
  },
  Task_122204_Desc = {
    Text = "Hoàn thành \"Đánh lừa đôi mắt\"độ khó điên cuồng"
  },
  Task_122205_Desc = {
    Text = "Hoàn thành \"Đập vỡ trái tim\" bất kỳ độ khó nào"
  },
  Task_122206_Desc = {
    Text = "Vượt qua \"Kiểm soát ngôn ngữ\"ở bất kỳ độ khó nào"
  },
  Task_122207_Desc = {
    Text = "Hoàn thành \"Cắt bỏ ruột thừa\"độ khó điên cuồng"
  },
  Task_122208_Desc = {
    Text = "Hoàn thành \"Suy nghĩ bản năng\"ở bất kỳ độ khó nào"
  },
  Task_122209_Desc = {
    Text = "Sử dụng thân thể được đánh thức siêu giới vực để giành chiến thắng một lần trong \"Bản thân lạc lối\""
  },
  Task_122210_Desc = {
    Text = "Hoàn thành \"Chi phối tứ chi\"ở bất kỳ độ khó nào"
  },
  Task_122211_Desc = {
    Text = "Hoàn thành \"Giải Phóng Bản Thân\"ở bất kỳ độ khó nào"
  },
  Task_122212_Desc = {
    Text = "Thông qua kết nối đa chiều \"Lễ rửa bạc và máu\""
  },
  Task_122213_Desc = {
    Text = "Hoàn thành tất cả thành tựu của \"Bản thân lạc lối - Thông qua\""
  },
  Task_122214_Desc = {
    Text = "Hoàn thành \"Che Mắt\"ở bất kỳ độ khó nào"
  },
  Task_122215_Desc = {
    Text = "Bản ngã lạc lối · giới vực"
  },
  Task_122216_Desc = {
    Text = "Hoàn thành \"Suy Nghĩ Bản Năng\"độ khó điên cuồng"
  },
  Task_122217_Desc = {
    Text = "Hoàn thành \"Chi phối tứ chi\"ở bất kỳ độ khó nào"
  },
  Task_122218_Desc = {
    Text = "Hoàn thành \"Giải Phóng Bản Thân\"ở bất kỳ độ khó nào"
  },
  Task_122219_Desc = {
    Text = "Bản thân lạc lối·hoàn thành"
  },
  Task_122220_Desc = {
    Text = "Sử dụng thân thể được đánh thức của giới vực thịt máu để giành chiến thắng 2 lần trong \"Bản Ngã Lạc Lối\""
  },
  Task_122221_Desc = {
    Text = "Bản thân lạc lối · điên cuồng"
  },
  Task_122222_Desc = {
    Text = "Hoàn thành \"Che Mắt\"ở bất kỳ độ khó nào"
  },
  Task_122223_Desc = {
    Text = "Hoàn thành \"Kiểm Soát Ngôn Ngữ\"độ khó điên cuồng"
  },
  Task_122224_Desc = {
    Text = "Hoàn thành \"Cắt Ruột Thừa\"ở bất kỳ độ khó nào"
  },
  Task_122225_Desc = {
    Text = "Sử dụng thân thể được đánh thức vùng giới sâu thẳm để giành chiến thắng 1 lần trong \"Bản thân lạc lối\""
  },
  Task_122226_Desc = {
    Text = "Sử dụng thân thể được đánh thức của vùng giới sâu thẳm và giành chiến thắng 2 lần trong \"Bản Thân Lạc Lối\""
  },
  Task_122227_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong giới vực thịt máu để chiến thắng 1 lần trong \"Bản Thân Lạc Lối\""
  },
  Task_122228_Desc = {
    Text = "Hoàn thành \"Đập vỡ trái tim\" bất kỳ độ khó nào"
  },
  Task_122229_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong siêu không gian giới vực để chiến thắng 2 lần trong \"bản thân lạc lối\""
  },
  Task_122230_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong giới vực hỗn loạn để chiến thắng 2 lần trong \"Bản thân lạc lối\""
  },
  Task_122411_Desc = {
    Text = "Khi ra trận với 1/2 Thể thức tỉnh đã tăng cường, nhận được 250 / 500 điểm. (Hiện tại ra trận: {s1})"
  },
  Task_122411_Name = {
    Text = "Vực Thẳm Gọi<size=20><color=#747474>Khi ra trận với 1/2 Thể thức tỉnh đã tăng cường, nhận được 250 / 500 điểm </color></size>"
  },
  Task_122584_Name = {
    Text = "Tiêu diệt tất cả các BOSS"
  },
  Task_122704_Desc = {
    Text = "Mùa Hè tỷ lệ đồng điều đạt cấp 10"
  },
  Task_122808_Desc = {
    Text = "Nhận được Moksha khi khởi linh 6"
  },
  Task_122808_Name = {
    Text = "Nhận được Moksha khi khởi linh 6"
  },
  Task_122808_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà thân thể được đánh thức Mùa Hè khởi linh 2"
  },
  Task_122809_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_122812_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_122816_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_122819_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_122824_Desc = {
    Text = "Nhận được Moksha khi khởi linh 2"
  },
  Task_122824_Name = {
    Text = "Nhận được Moksha khi khởi linh 2"
  },
  Task_122824_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà thân thể được đánh thức Mùa Hè khởi linh 2"
  },
  Task_122828_Desc = {
    Text = "Hoàn thành \"Điều tra hành động - Quên lãng - Chương 3\" chế độ khó"
  },
  Task_122829_Desc = {
    Text = "Hoàn thành \"Điều tra hành động - phần quên - chương 1\" chế độ khó"
  },
  Task_122830_Desc = {
    Text = "Hoàn thành \"Điều tra hành động - Quên lãng - Chương 6\" chế độ khó khăn"
  },
  Task_122831_Desc = {
    Text = "Hoàn thành \"Điều tra hành động - Quên lãngthiên - Chương 7\"độ khó"
  },
  Task_122832_Desc = {
    Text = "Hoàn thành \"Điều tra hành động - Quên lãng - Chương 4\" chế độ khó"
  },
  Task_122833_Desc = {
    Text = "Hoàn thành \"Điều tra hành động - Chương Quên Lãng - Chương 2\" chế độ khó"
  },
  Task_122834_Desc = {
    Text = "Hoàn thành \"Điều tra hành động - Quên lãng - Chương 5\"ở chế độ khó"
  },
  Task_123135_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong giới vực hỗn loạn để giành chiến thắng 2 lần trong \"Cửa hàng phù thủy\""
  },
  Task_123136_Desc = {
    Text = "Sử dụng thể thức đánh thức trong vùng biển sâu để chiến thắng 2 lần tại \"Cửa hàng phù thủy\""
  },
  Task_123137_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong giới vực thịt máu để chiến thắng 1 lần trong \"Cửa Hàng Phù Thủy\""
  },
  Task_123138_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong siêu việt giới vực để giành chiến thắng 1 lần trong \"Cửa hàng phù thủy\""
  },
  Task_123139_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong giới vực hỗn loạn để chiến thắng 1 lần trong \"Cửa Hàng Phù Thủy\""
  },
  Task_123140_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong giới vực thịt máu để chiến thắng 2 lần trong \"Cửa hàng phù thủy\""
  },
  Task_123141_Desc = {
    Text = "Tiệm phù thủy·giới vực"
  },
  Task_123142_Desc = {
    Text = "Sử dụng thân thể được đánh thức từ vùng giới sâu thẳm để giành chiến thắng 1 lần trong \"Cửa hàng phù thủy\""
  },
  Task_123143_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong siêu không gian giới vực để giành chiến thắng 2 lần trong \"Cửa hàng phù thủy\""
  },
  Task_123288_Desc = {
    Text = "Sử dụng thể thức tỉnh trong siêu chiều cõi để chiến thắng 2 lần trong \"Nhìn chằm chằm biển sâu\""
  },
  Task_123289_Desc = {
    Text = "Sử dụng Thể thức tỉnh Hải Vực để chiến thắng 2 lần trong \"Nhìn chằm chằm biển sâu\""
  },
  Task_123290_Desc = {
    Text = "Sử dụng Thể thức tỉnh Cõi thịt máu để giành chiến thắng 2 lần trong \"Nhìn chằm chằm biển sâu\""
  },
  Task_123291_Desc = {
    Text = "Sử dụng Thể thức tỉnh từ cõi hỗn mang để chiến thắng 2 lần trong \"Nhìn chằm chằm biển sâu\""
  },
  Task_123324_Desc = {
    Text = "Hoàn thành 20 nhiệm vụ"
  },
  Task_123325_Desc = {
    Text = "Hoàn thành 20 nhiệm vụ"
  },
  Task_123326_Desc = {
    Text = "Hoàn thành 4 lần nhiệm vụ hàng ngày"
  },
  Task_123327_Desc = {
    Text = "Thực hiện vượt ải tồn tại siêu nghiệm 1 lầ"
  },
  Task_123328_Desc = {
    Text = "Đăng nhập liên tiếp 1 ngày"
  },
  Task_123329_Desc = {
    Text = "Hoàn thành 4 lần nhiệm vụ hàng ngày"
  },
  Task_123330_Desc = {
    Text = "Thông qua 1 lần thử nghiệm Thái Di Sơ"
  },
  Task_123331_Desc = {
    Text = "Tiêu hao 1500 điểm Menophin"
  },
  Task_123332_Desc = {
    Text = "Tích lũy thức tỉnh 30 lần"
  },
  Task_123333_Desc = {
    Text = "Đăng nhập liên tiếp 1 ngày"
  },
  Task_123334_Desc = {
    Text = "Thông qua 1 lần thử nghiệm Thái Di Sơ"
  },
  Task_123335_Desc = {
    Text = "Giá trị luyện tập ở khu vực d-khu vực đạt đến 100"
  },
  Task_123336_Desc = {
    Text = "Giá trị luyện tập ở khu vực d-khu vực đạt đến 100"
  },
  Task_123337_Desc = {
    Text = "Tiêu hao 1500 điểm Menophin"
  },
  Task_123338_Desc = {
    Text = "Thực hiện vượt ải tồn tại siêu nghiệm 1 lầ"
  },
  Task_123339_Desc = {
    Text = "Tích lũy thức tỉnh 30 lần"
  },
  Task_123488_Desc = {
    Text = "Đạt được 3 trận thắng trong mùa giải này"
  },
  Task_123488_Name = {
    Text = "3 trận thắng"
  },
  Task_123489_Desc = {
    Text = "Đạt được tổng cộng 6 trận thắng trong mùa giải này"
  },
  Task_123489_Name = {Text = "6 thắng"},
  Task_123490_Desc = {
    Text = "Đạt được tổng cộng 10 trận thắng trong mùa giải này"
  },
  Task_123490_Name = {Text = "10 thắng"},
  Task_123491_Desc = {
    Text = "Đạt được tích lũy 1 trận thắng trong mùa giải này"
  },
  Task_123491_Name = {
    Text = "1 trận thắng"
  },
  Task_123726_Name = {
    Text = "Chơi lại nhiệm vụ phụ của Mộc Hạ cấp độ thường 6"
  },
  Task_123878_Desc = {
    Text = "Sử dụng Thể thức tỉnh từ cõi hỗn mang giành chiến thắng 2 lần trong \"Sự tham vọng của thú vật\""
  },
  Task_123883_Desc = {
    Text = "Sử dụng Thể thức tỉnh trong siêu chiều cõi giành chiến thắng 2 lần trong \"Sự tham vọng của thú vật\""
  },
  Task_123885_Desc = {
    Text = "Sử dụng Thể thức tỉnh Hải Vực giành chiến thắng 2 lần trong \"Sự tham vọng của thú vật\""
  },
  Task_123887_Desc = {
    Text = "Sử dụng Thể thức tỉnh Cõi thịt máu giành chiến thắng 2 lần trong \"Sự tham vọng của thú vật\""
  },
  Task_124214_Desc = {
    Text = "Đạt được 3 trận thắng trong mùa giải này"
  },
  Task_124214_Name = {
    Text = "3 trận thắng"
  },
  Task_124215_Desc = {
    Text = "Đạt được tổng cộng 10 trận thắng trong mùa giải này"
  },
  Task_124215_Name = {Text = "10 thắng"},
  Task_124216_Desc = {
    Text = "Đạt được tích lũy 1 trận thắng trong mùa giải này"
  },
  Task_124216_Name = {
    Text = "1 trận thắng"
  },
  Task_124217_Desc = {
    Text = "Đạt được tổng cộng 6 trận thắng trong mùa giải này"
  },
  Task_124217_Name = {Text = "6 thắng"},
  Task_124797_Desc = {
    Text = "Hoàn thành kết nối đa chiều \"Đảo ngược vòng\""
  },
  Task_124797_Name = {
    Text = "Vạn tượng đảo ngược"
  },
  Task_124798_Desc = {
    Text = "Hoàn thành kết nối đa chiều \"Lễ rửa bạc và máu\"độ khó cao"
  },
  Task_124798_Name = {
    Text = "Tương lai sẽ đến · Khó khăn"
  },
  Task_124799_Desc = {
    Text = "Hoàn thành kết nối đa chiều \"Lễ rửa bạc và máu\""
  },
  Task_124799_Name = {
    Text = "Tương lai sẽ đến"
  },
  Task_124835_Desc = {
    Text = "Hoàn thành \"Điều tra hành động - phần quên - chương 1\""
  },
  Task_125386_Desc = {
    Text = "Hoàn thành \"Giải Xác\"ở bất kỳ độ khó nào"
  },
  Task_125387_Desc = {
    Text = "Hoàn thành \"bóng sau cửa sổ\"ở bất kỳ độ khó nào"
  },
  Task_125388_Desc = {
    Text = "Hoàn thành \"Hút\" bất kỳ độ khó nào"
  },
  Task_125389_Desc = {
    Text = "Hoàn thành \"Hương thơm\"độ khó điên cuồng"
  },
  Task_125390_Desc = {
    Text = "Hoàn thành \"dân chúng béo phì\"ở bất kỳ độ khó nào"
  },
  Task_125391_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong giới vực thịt máu để chiến thắng 1 lần trong \"Huyền Nữ Vô Hình\""
  },
  Task_125392_Desc = {
    Text = "Hoàn thành duy thức tiềm hành \"Tán dưới quạt đêm\""
  },
  Task_125392_Name = {
    Text = "Trời sợ hãi, đất sợ hãi"
  },
  Task_125393_Desc = {
    Text = "Hoàn thành \"Theo Dấu Hương\"ở bất kỳ độ khó nào"
  },
  Task_125394_Desc = {
    Text = "Hoàn thành \"Vong Tử\"độ khó điên cuồng"
  },
  Task_125395_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_125396_Desc = {
    Text = "Sử dụng thể thức tỉnh từ cõi hỗn mang để giành chiến thắng 2 lần trong \"Huyễn Nữ Vô Hình\""
  },
  Task_125397_Desc = {
    Text = "Hoàn thành \"Ái Oán Tương Sinh\"độ khó điên cuồng"
  },
  Task_125398_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_125399_Desc = {
    Text = "Hoàn thành \"Tử Vong Vô Lý\" bất kỳ độ khó nào"
  },
  Task_125400_Desc = {
    Text = "Sử dụng thể thức tỉnh từ cõi hỗn mang để chiến thắng 1 lần trong \"Huyền Nữ Vô Hình\""
  },
  Task_125401_Desc = {
    Text = "Huyền Nữ Vô Hình·Hoàn thành"
  },
  Task_125402_Desc = {
    Text = "Hoàn thành \"Hút\" bất kỳ độ khó nào"
  },
  Task_125403_Desc = {
    Text = "Hoàn thành \"bóng sau cửa sổ\"ở bất kỳ độ khó nào"
  },
  Task_125404_Desc = {
    Text = "Hoàn thành \"Cực Lạc\"độ khó điên cuồng"
  },
  Task_125406_Desc = {
    Text = "Sử dụng Thể thức tỉnh Hải Vực trong \"Huyền Nữ Vô Hình\"để giành chiến thắng 1 lần"
  },
  Task_125407_Desc = {
    Text = "Hoàn thành \"Cực Lạc\" bất kỳ độ khó nào"
  },
  Task_125409_Desc = {
    Text = "Hoàn thành \"Cực Lạc\" bất kỳ độ khó nào"
  },
  Task_125410_Desc = {
    Text = "Sử dụng thể thức tỉnh Cõi thịt máu để giành chiến thắng 2 lần trong \"Huyền Nữ Vô Hình\""
  },
  Task_125411_Desc = {
    Text = "Sử dụng Thể thức tỉnh Hải Vực để giành chiến thắng 2 lần trong \"Huyễn Nữ Vô Hình\""
  },
  Task_125412_Desc = {
    Text = "Hoàn thành \"Sú\"độ khó điên cuồng"
  },
  Task_125413_Desc = {
    Text = "Hoàn thành \"duy thức tiềm hành: Cuộc trò chuyện dưới ánh đèn\""
  },
  Task_125414_Desc = {
    Text = "Hoàn thành \"Dệt\"ở bất kỳ độ khó nào"
  },
  Task_125415_Desc = {
    Text = "Tuần tỷ lệ đồng điều đạt cấp 10"
  },
  Task_125416_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong siêu chiều cõi để giành chiến thắng 2 lần trong \"Huyễn Nữ Vô Hình\""
  },
  Task_125417_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_125418_Desc = {
    Text = "Nhận Tuần thời khởi linh 2"
  },
  Task_125418_Name = {
    Text = "Nhận Tuần thời khởi linh 2"
  },
  Task_125418_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà khởi linh Thể thức tỉnh Tuần 2 hoạt động"
  },
  Task_125419_Desc = {
    Text = "Hoàn thành \"Ái oán tương sinh\" tất cả các độ khó"
  },
  Task_125420_Desc = {
    Text = "Huyền Nữ Vô Hình·Cõi"
  },
  Task_125421_Desc = {
    Text = "Hoàn thành \"Bóng Sau Cửa Sổ\"độ khó điên cuồng"
  },
  Task_125422_Desc = {
    Text = "Hoàn thành \"Ái oán tương sinh\" tất cả các độ khó"
  },
  Task_125423_Desc = {
    Text = "Sử dụng thể thức tỉnh trong siêu chiều cõi để giành chiến thắng 1 lần trong \"Huyễn Nữ Vô Hình\""
  },
  Task_125424_Desc = {
    Text = "Hoàn thành \"Theo Dấu Hương\"ở bất kỳ độ khó nào"
  },
  Task_125425_Desc = {
    Text = "Hoàn thành \"Dân Chúng Cồng Kềnh\"độ khó điên cuồng"
  },
  Task_125426_Desc = {
    Text = "Nhận được Tuần khi khởi linh 6"
  },
  Task_125426_Name = {
    Text = "Nhận được Tuần khi khởi linh 6"
  },
  Task_125426_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà khởi linh Thể thức tỉnh Tuần 2 hoạt động"
  },
  Task_125427_Desc = {
    Text = "Hoàn thành \"Dệt\"ở bất kỳ độ khó nào"
  },
  Task_125428_Desc = {
    Text = "Hoàn thành tất cả thành tựu của \"Huyền Nữ Vô Hình·Hoàn thành\""
  },
  Task_125429_Desc = {
    Text = "Hoàn thành \"Giải Xác\"ở bất kỳ độ khó nào"
  },
  Task_125430_Desc = {
    Text = "Hoàn thành \"La Chế\"độ khó điên cuồng"
  },
  Task_125431_Desc = {
    Text = "Hoàn thành \"dân chúng béo phì\"ở bất kỳ độ khó nào"
  },
  Task_125432_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_125433_Desc = {
    Text = "Hoàn thành \"Tử Vong Vô Lý\" bất kỳ độ khó nào"
  },
  Task_125434_Desc = {
    Text = "Huyền Nữ Vô Hình · điên rồ"
  },
  Task_125435_Desc = {
    Text = "Hoàn thành \"Thi Giải\"độ khó điên cuồng"
  },
  Task_125500_Desc = {
    Text = "Đạt được tổng cộng 6 trận thắng trong mùa giải này"
  },
  Task_125500_Name = {Text = "6 thắng"},
  Task_125501_Desc = {
    Text = "Đạt được tổng cộng 10 trận thắng trong mùa giải này"
  },
  Task_125501_Name = {Text = "10 thắng"},
  Task_125502_Desc = {
    Text = "Đạt được tích lũy 1 trận thắng trong mùa giải này"
  },
  Task_125502_Name = {
    Text = "1 trận thắng"
  },
  Task_125503_Desc = {
    Text = "Đạt được 3 trận thắng trong mùa giải này"
  },
  Task_125503_Name = {
    Text = "3 trận thắng"
  },
  Task_125686_Desc = {
    Text = "Thoát khỏi sự truy đuổi"
  },
  Task_125686_Name = {
    Text = "Mục tiêu"
  },
  Task_125687_Desc = {
    Text = "Sống sót từ phục kích"
  },
  Task_125687_Name = {
    Text = "Mục tiêu"
  },
  Task_125688_Desc = {
    Text = "Đoạt lại thân thể của Liz"
  },
  Task_125688_Name = {
    Text = "Mục tiêu"
  },
  Task_125689_Desc = {
    Text = "Trốn khỏi bẫy Arachne"
  },
  Task_125689_Name = {
    Text = "Mục tiêu"
  },
  Task_125690_Desc = {
    Text = "Giải phong ấn ba chất thể"
  },
  Task_125690_Name = {
    Text = "Mục tiêu"
  },
  Task_125691_Desc = {
    Text = "Đối kháng kẻ thù trong quán rượu"
  },
  Task_125691_Name = {
    Text = "Mục tiêu"
  },
  Task_125692_Desc = {
    Text = "Tiêu diệt dị biến thể"
  },
  Task_125692_Name = {
    Text = "Mục tiêu"
  },
  Task_125693_Desc = {
    Text = "Cứu lại \"Lương thiện\""
  },
  Task_125693_Name = {
    Text = "Mục tiêu"
  },
  Task_125694_Desc = {
    Text = "Bảo vệ Sorrel"
  },
  Task_125694_Name = {
    Text = "Mục tiêu"
  },
  Task_125695_Desc = {
    Text = "Trả thù cho \"Ký ức\""
  },
  Task_125695_Name = {
    Text = "Mục tiêu"
  },
  Task_125845_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_125845_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_125846_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_125846_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_125847_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_125847_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_125848_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_125848_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_125849_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_125849_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_125850_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_125850_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_125851_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_125851_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_125852_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_125852_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_125853_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_125853_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_125854_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_125854_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_126276_Desc = {
    Text = "Thông quan \"Xin Đừng Spoil\"độ khó Điên Cuồng"
  },
  Task_126277_Desc = {
    Text = "Sân Khấu Rối · Điên Cuồng"
  },
  Task_126279_Desc = {
    Text = "Sử dụng Thức Tỉnh Thể giới vực Thâm Hải giành chiến thắng 1 lần trong \"Sân Khấu Rối\""
  },
  Task_126280_Desc = {
    Text = "Sân Khấu Rối · Thông Quan"
  },
  Task_126281_Desc = {
    Text = "Thông quan \"Thiêu Đốt\" bất kỳ độ khó"
  },
  Task_126282_Desc = {
    Text = "Thông quan \"Xin Đừng Spoil\" bất kỳ độ khó"
  },
  Task_126285_Desc = {
    Text = "Thông quan \"Nhập Trường\" bất kỳ độ khó"
  },
  Task_126286_Desc = {
    Text = "Thông quan \"Đảo Ngược, Đảo Ngược\" bất kỳ độ khó"
  },
  Task_126288_Desc = {
    Text = "Thông quan \"Khẩu Súng Trên Tường\" bất kỳ độ khó"
  },
  Task_126290_Desc = {
    Text = "Thông quan \"Thiêu Đốt\"độ khó Điên Cuồng"
  },
  Task_126292_Desc = {
    Text = "Thông quan \"Khẩu Súng Trên Tường\"độ khó Điên Cuồng"
  },
  Task_126293_Desc = {
    Text = "Thông quan \"Thiêu Đốt\" bất kỳ độ khó"
  },
  Task_126294_Desc = {
    Text = "Hoàn thành tất cả thành tựu \"Sân Khấu Rối · Thông Quan\""
  },
  Task_126295_Desc = {
    Text = "Sử dụng Thức Tỉnh Thể giới vực Siêu Chiều giành chiến thắng 1 lần trong \"Sân Khấu Rối\""
  },
  Task_126296_Desc = {
    Text = "Thông quan \"Đảo Ngược, Đảo Ngược\"độ khó Điên Cuồng"
  },
  Task_126297_Desc = {
    Text = "Thông quan \"Nhập Trường\"độ khó Điên Cuồng"
  },
  Task_126298_Desc = {
    Text = "Sân Khấu Rối · Giới Vực"
  },
  Task_126299_Desc = {
    Text = "Sử dụng Thức Tỉnh Thể giới vực Thâm Hải giành chiến thắng 2 lần trong \"Sân Khấu Rối\""
  },
  Task_126302_Desc = {
    Text = "Sử dụng Thức Tỉnh Thể giới vực Hỗn Loạn giành chiến thắng 2 lần trong \"Sân Khấu Rối\""
  },
  Task_126303_Desc = {
    Text = "Thông quan \"Nhập Trường\" bất kỳ độ khó"
  },
  Task_126304_Desc = {
    Text = "Sử dụng Thức Tỉnh Thể giới vực Huyết Nhục giành chiến thắng 2 lần trong \"Sân Khấu Rối\""
  },
  Task_126305_Desc = {
    Text = "Thông quan \"Xin Đừng Spoil\" bất kỳ độ khó"
  },
  Task_126307_Desc = {
    Text = "Thông quan \"Khẩu Súng Trên Tường\" bất kỳ độ khó"
  },
  Task_126309_Desc = {
    Text = "Sử dụng Thức Tỉnh Thể giới vực Huyết Nhục giành chiến thắng 1 lần trong \"Sân Khấu Rối\""
  },
  Task_126311_Desc = {
    Text = "Sử dụng Thức Tỉnh Thể giới vực Siêu Chiều giành chiến thắng 2 lần trong \"Sân Khấu Rối\""
  },
  Task_126312_Desc = {
    Text = "Sử dụng Thức Tỉnh Thể giới vực Hỗn Loạn giành chiến thắng 1 lần trong \"Sân Khấu Rối\""
  },
  Task_126313_Desc = {
    Text = "Thông quan \"Đảo Ngược, Đảo Ngược\" bất kỳ độ khó"
  },
  Task_126385_Desc = {
    Text = "Thông quan Thiên Tinh Thiên Chương 5 \"Nhà Hát Dệt Mệnh\"Độ khó Khó"
  },
  Task_126386_Desc = {
    Text = "Thông quan Thiên Tinh Thiên Chương 5 \"Nhà Hát Dệt Mệnh\"Độ khó Khó"
  },
  Task_126387_Desc = {
    Text = "Thông quan Thiên Tinh Thiên Chương 5 5-7"
  },
  Task_126388_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_126390_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_126391_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_126392_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_126393_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_126394_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_126395_Desc = {
    Text = "Thông quan Thiên Tinh Thiên Chương 5 \"Nhà Hát Dệt Mệnh\""
  },
  Task_126396_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_126397_Desc = {
    Text = "Thông quan Thiên Tinh Thiên Chương 5 5-6 Độ khó Khó"
  },
  Task_126398_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_126399_Desc = {
    Text = "Thông quan Thiên Tinh Thiên Chương 5 5-6 Độ khó Khó"
  },
  Task_126400_Desc = {
    Text = "Thông quan Thiên Tinh Thiên Chương 5 5-7"
  },
  Task_126401_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_126402_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_126403_Desc = {
    Text = "Thông quan Thiên Tinh Thiên Chương 5 \"Nhà Hát Dệt Mệnh\""
  },
  Task_126493_Desc = {
    Text = "Cổ quốc tạp cẩm VII"
  },
  Task_126494_Desc = {
    Text = "Quốc gia cổ đại · Đặc quyền có thời hạn"
  },
  Task_126495_Desc = {
    Text = "Quốc gia cổ xưa V"
  },
  Task_126496_Desc = {
    Text = "Quốc gia cổ xưa tạp bútI"
  },
  Task_126497_Desc = {
    Text = "Quốc gia cổ xưa Tạp Tử VI"
  },
  Task_126498_Desc = {
    Text = "Quốc gia cổ xưa·III"
  },
  Task_126499_Desc = {
    Text = "Quốc gia cổ xưa tạp tập IV"
  },
  Task_126500_Desc = {
    Text = "Quốc gia cổ xưa·Miễn phí"
  },
  Task_126501_Desc = {
    Text = "Quốc gia cổ·II"
  },
  Task_127071_Desc = {
    Text = "Đạt được tổng cộng 10 trận thắng trong mùa giải này"
  },
  Task_127071_Name = {Text = "10 thắng"},
  Task_127072_Desc = {
    Text = "Đạt được 3 trận thắng trong mùa giải này"
  },
  Task_127072_Name = {
    Text = "3 trận thắng"
  },
  Task_127073_Desc = {
    Text = "Đạt được tổng cộng 6 trận thắng trong mùa giải này"
  },
  Task_127073_Name = {Text = "6 thắng"},
  Task_127074_Desc = {
    Text = "Đạt được tích lũy 1 trận thắng trong mùa giải này"
  },
  Task_127074_Name = {
    Text = "1 trận thắng"
  },
  Task_127094_Desc = {
    Text = "Ô Ryta khởi linh đạt đến cấp độ nhân cách 12"
  },
  Task_127095_Desc = {
    Text = "Nguồn gốc Ramona khởi linh đạt đến cấp độ nhân cách 12"
  },
  Task_127096_Desc = {
    Text = "Ramona khởi linh đạt đến phát triển nhân cách 12"
  },
  Task_127097_Desc = {
    Text = "Ai Jī Sī khởi linh đạt đến phát triển nhân cách 12"
  },
  Task_127098_Desc = {
    Text = "Lơ-tan khởi linh đạt đến phát triển nhân cách 12"
  },
  Task_127099_Desc = {
    Text = "Erika khởi linh đạt đến cấp độ nhân cách 12"
  },
  Task_127100_Desc = {
    Text = "Đóa khởi linh đạt đến phát triển nhân cách 12"
  },
  Task_127101_Desc = {
    Text = "Orci khởi linh đạt được phát triển nhân cách 12"
  },
  Task_129511_Desc = {
    Text = "Sử dụng đội hình gồm 3 Thịt máu và 1 Thân thể siêu thức tỉnh để hoàn thành độ khó khó khăn hoặc độ khó điên cuồng"
  },
  Task_129512_Desc = {
    Text = "Sử dụng đội hình gồm 3 Hỗn Mang và 1 thân thể siêu thức tỉnh để hoàn thành độ khó khó khăn hoặc điên cuồng"
  },
  Task_129513_Desc = {
    Text = "Quỹ đạo tàu hỏa·khó khăn"
  },
  Task_129513_Name = {
    Text = "Quỹ đạo tàu hỏa·khó khăn"
  },
  Task_129514_Desc = {
    Text = "Hoàn thành giai đoạn thứ ba độ khó điên cuồng"
  },
  Task_129515_Desc = {
    Text = "Sử dụng đội hình gồm 1 Thịt máu và 3 Thân thể siêu thức tỉnh để hoàn thành độ khó khó khăn hoặc điên cuồng"
  },
  Task_129516_Desc = {
    Text = "Đánh bại lãnh đạo giai đoạn 3 \"Tan chảy · Đóa\"ở bất kỳ độ khó nào"
  },
  Task_129517_Desc = {
    Text = "Đánh bại lãnh đạo giai đoạn 3 \"Màn che khu vui chơi\"ở bất kỳ độ khó nào"
  },
  Task_129518_Desc = {
    Text = "Hoàn thành tất cả nhiệm vụ\"Đường đua đặc biệt·khó khăn\""
  },
  Task_129519_Desc = {
    Text = "Sử dụng đội hình gồm 4 thân thể siêu thức tỉnh để hoàn thành bất kỳ độ khó nào"
  },
  Task_129520_Desc = {
    Text = "Hoàn thành độ khó bình thường giai đoạn thứ hai"
  },
  Task_129521_Desc = {
    Text = "Đánh bại lãnh đạo giai đoạn thứ hai của bất kỳ độ khó nào \"Hydra\""
  },
  Task_129522_Desc = {
    Text = "Sử dụng đội hình gồm 4 thân thể được đánh thức thịt máu để hoàn thành bất kỳ độ khó nào"
  },
  Task_129523_Desc = {
    Text = "Sử dụng đội hình gồm 2 thịt máu và 2 thân thể siêu thức tỉnh để hoàn thành bất kỳ độ khó nào"
  },
  Task_129524_Desc = {
    Text = "Sử dụng đội hình gồm 3 Hải Vực và 1 Thân thể được đánh thức thịt máu để hoàn thành độ khó khó khăn hoặc điên cuồng"
  },
  Task_129525_Desc = {
    Text = "Hoàn thành giai đoạn một độ khó bình thường"
  },
  Task_129526_Desc = {
    Text = "Sử dụng đội hình gồm 2 Hỗn Mang và 2 Thân thể được đánh thức thịt máu để hoàn thành bất kỳ độ khó nào"
  },
  Task_129527_Desc = {
    Text = "Sử dụng đội hình gồm 3 Hỗn Mang và 1 Thân thể được đánh thức thịt máu để hoàn thành độ khó khó khăn hoặc điên cuồng"
  },
  Task_129528_Desc = {
    Text = "Hoàn thành tất cả nhiệm vụ trong \"Chụp ảnh trên đường·Hạnh phúc hành lang\""
  },
  Task_129529_Desc = {
    Text = "Hoàn thành giai đoạn thứ ba độ khó bình thường"
  },
  Task_129530_Desc = {
    Text = "Sử dụng đội hình gồm 3 Hỗn Mang và 1 thân thể đánh thức sâu thẳm để hoàn thành độ khó khó khăn hoặc điên cuồng"
  },
  Task_129531_Desc = {
    Text = "Đánh bại lãnh đạo giai đoạn một ở bất kỳ độ khó nào \"▼Ah▼▼ya\""
  },
  Task_129532_Desc = {
    Text = "Hoàn thành độ khó khó khăn giai đoạn thứ hai"
  },
  Task_129533_Desc = {
    Text = "Hoàn thành giai đoạn đầu tiên độ khó điên cuồng"
  },
  Task_129534_Desc = {
    Text = "Chụp ảnh trên đường·Ký ức xưa"
  },
  Task_129534_Name = {
    Text = "Chụp ảnh trên đường·Ký ức xưa"
  },
  Task_129535_Desc = {
    Text = "Đánh bại lãnh đạo giai đoạn ba \"Bù nhìn của dòng thủy thối rữa\"ở bất kỳ độ khó nào"
  },
  Task_129536_Desc = {
    Text = "Chụp ảnh trên đường·Hạnh phúc hành lang"
  },
  Task_129536_Name = {
    Text = "Chụp ảnh trên đường·Hạnh phúc hành lang"
  },
  Task_129537_Desc = {
    Text = "Đánh bại lãnh đạo giai đoạn thứ ba ở bất kỳ độ khó nào \"Siêu việt @2 con nhộng\""
  },
  Task_129538_Desc = {
    Text = "Sử dụng đội hình gồm 2 Hải Vực và 2 Thân thể được đánh thức thịt máu để hoàn thành bất kỳ độ khó nào"
  },
  Task_129539_Desc = {
    Text = "Đánh bại lãnh đạo giai đoạn thứ hai \"cây mẹ phong thịnh\"ở bất kỳ độ khó nào"
  },
  Task_129540_Desc = {
    Text = "Đánh bại lãnh đạo giai đoạn một \"Joe khóc nhè▼\"ở mọi độ khó"
  },
  Task_129541_Desc = {
    Text = "Sử dụng đội hình gồm 2 Hỗn Mang và 2 thân thể đánh thức sâu thẳm để hoàn thành bất kỳ độ khó nào"
  },
  Task_129542_Desc = {
    Text = "Hoàn thành độ khó khó khăn giai đoạn thứ ba"
  },
  Task_129543_Desc = {
    Text = "Đánh bại lãnh đạo giai đoạn một ở bất kỳ độ khó nào \"sửa▼▼\""
  },
  Task_129544_Desc = {
    Text = "Sử dụng đội hình gồm 3 Thể thức tỉnh Hải Vực và 1 Thân thể siêu thức tỉnh để hoàn thành độ khó khó khăn hoặc độ khó điên cuồng"
  },
  Task_129545_Desc = {
    Text = "Hoàn thành giai đoạn thứ hai độ khó điên cuồng"
  },
  Task_129546_Desc = {
    Text = "Đánh bại lãnh đạo giai đoạn một \"Chó Di Chuyển Chiều\"ở bất kỳ độ khó nào"
  },
  Task_129547_Desc = {
    Text = "Đánh bại lãnh đạo giai đoạn thứ hai \"Kembaran Paradoks\"ở bất kỳ độ khó nào"
  },
  Task_129548_Desc = {
    Text = "Sử dụng đội hình gồm 1 Hải Vực và 3 Thân thể được đánh thức thịt máu hoàn thành độ khó khó khăn hoặc độ khó điên cuồng"
  },
  Task_129549_Desc = {
    Text = "Sử dụng đội hình gồm 2 Hỗn Mang và 2 thân thể siêu thức tỉnh để hoàn thành bất kỳ độ khó nào"
  },
  Task_129550_Desc = {
    Text = "Hoàn thành độ khó khó khăn giai đoạn thứ nhất"
  },
  Task_129551_Desc = {
    Text = "Hoàn thành tất cả nhiệm vụ của \"Chuyên tuyến quỹ đạo·Bình thường\""
  },
  Task_129552_Desc = {
    Text = "Sử dụng đội hình gồm 2 thân thể Hải Vực và 2 thân thể siêu thức tỉnh để hoàn thành bất kỳ độ khó nào"
  },
  Task_129553_Desc = {
    Text = "Quỹ đạo chuyên tuyến·Bình thường"
  },
  Task_129553_Name = {
    Text = "Quỹ đạo chuyên tuyến·Bình thường"
  },
  Task_129554_Desc = {
    Text = "Sử dụng đội hình gồm 1 Hỗn Mang và 3 Thân thể được đánh thức thịt máu để hoàn thành độ khó khó khăn hoặc điên cuồng"
  },
  Task_129555_Desc = {
    Text = "Sử dụng đội hình gồm 1 Hỗn Mang và 3 Thân thể siêu thức tỉnh để hoàn thành độ khó khó khăn hoặc điên cuồng"
  },
  Task_129556_Desc = {
    Text = "Sử dụng đội hình gồm 4 thân thể đánh thức sâu thẳm để hoàn thành ở bất kỳ độ khó nào"
  },
  Task_129557_Desc = {
    Text = "Sử dụng đội hình gồm 1 Hỗn Mang và 3 thân thể đánh thức sâu thẳm để hoàn thành độ khó khó khăn hoặc điên cuồng"
  },
  Task_129558_Desc = {
    Text = "Sử dụng đội hình gồm 1 Thể thức tỉnh Hải Vực và 3 Thân thể siêu thức tỉnh để hoàn thành độ khó khó khăn hoặc độ khó điên cuồng"
  },
  Task_129559_Desc = {
    Text = "Sử dụng đội hình gồm 4 thân thể hỗn độn để hoàn thành bất kỳ độ khó nào"
  },
  Task_129560_Desc = {
    Text = "Hoàn thành tất cả các nhiệm vụ của \"Chụp ảnh trên đường·Ký ức xưa\""
  },
  Task_129561_Desc = {
    Text = "Đánh bại lãnh đạo giai đoạn thứ hai \"Trẻ Thánh\"ở bất kỳ độ khó nào"
  },
  Task_129895_Desc = {
    Text = "Hoàn thành Bản ghi đặc nhiệm \"Tàu chạy về lễ hội cầu năm\""
  },
  Task_129895_Name = {
    Text = "Âm thanh của pháo nổ đánh dấu một năm mới"
  },
  Task_130180_Desc = {
    Text = "Hoàn thành Kết nối đa chiều \"Mầm Ái Vùi Sâu Trong Quên Lãng\""
  },
  Task_130181_Desc = {
    Text = "Hoàn thành \"Chén rượu cuối cùng\" ở độ khó điên cuồng"
  },
  Task_130182_Desc = {
    Text = "Hoàn thành \"Bàn ăn\" ở bất kỳ độ khó nào"
  },
  Task_130183_Desc = {
    Text = "Sử dụng Thể Thức Tỉnh Giới Vực Thâm Hải giành chiến thắng 2 lần trong \"Tân Sinh Đảo Ngược\""
  },
  Task_130184_Desc = {
    Text = "Sử dụng Thể Thức Tỉnh Giới Vực Huyết Nhục giành chiến thắng 1 lần trong \"Tân Sinh Đảo Ngược\""
  },
  Task_130185_Desc = {
    Text = "Hoàn thành \"Trường học\" ở bất kỳ độ khó nào"
  },
  Task_130186_Desc = {
    Text = "Thông quan \"Bệnh viện\"ở bất kỳ độ khó nào"
  },
  Task_130187_Desc = {
    Text = "Hoàn thành \"Chén rượu cuối cùng\" ở bất kỳ độ khó nào"
  },
  Task_130188_Desc = {
    Text = "Thông quan \"Bệnh Viện\"độ khó Điên Cuồng"
  },
  Task_130189_Desc = {
    Text = "Sử dụng Thể Thức Tỉnh Giới Vực Hỗn Loạn giành chiến thắng 1 lần trong \"Tân Sinh Đảo Ngược\""
  },
  Task_130190_Desc = {
    Text = "Sử dụng Thể Thức Tỉnh Giới Vực Huyết Nhục giành chiến thắng 2 lần trong \"Tân Sinh Đảo Ngược\""
  },
  Task_130191_Desc = {
    Text = "Hoàn thành \"Giếng nước\" ở độ khó điên cuồng"
  },
  Task_130192_Desc = {
    Text = "Sử dụng Thể Thức Tỉnh Giới Vực Siêu Chiều giành chiến thắng 2 lần trong \"Tân Sinh Đảo Ngược\""
  },
  Task_130193_Desc = {
    Text = "Hoàn thành \"Trường học\" ở độ khó điên cuồng"
  },
  Task_130194_Desc = {
    Text = "Hoàn thành \"Bàn ăn\" ở bất kỳ độ khó nào"
  },
  Task_130195_Desc = {
    Text = "Thông quan \"Nhà\"ở bất kỳ độ khó nào"
  },
  Task_130196_Desc = {
    Text = "Hoàn thành \"Chén rượu cuối cùng\" ở bất kỳ độ khó nào"
  },
  Task_130197_Desc = {
    Text = "Hoàn thành \"Tổn thương não\" ở bất kỳ độ khó nào"
  },
  Task_130198_Desc = {
    Text = "Sử dụng Thể Thức Tỉnh Giới Vực Thâm Hải giành chiến thắng 1 lần trong \"Tân Sinh Đảo Ngược\""
  },
  Task_130199_Desc = {
    Text = "Hoàn thành \"Tổn thương não\" ở bất kỳ độ khó nào"
  },
  Task_130200_Desc = {
    Text = "Hoàn thành \"Giếng nước\" ở bất kỳ độ khó nào"
  },
  Task_130201_Desc = {
    Text = "Thông quan \"Nhà\"ở bất kỳ độ khó nào"
  },
  Task_130202_Desc = {
    Text = "Hoàn thành \"Trường học\" ở bất kỳ độ khó nào"
  },
  Task_130203_Desc = {
    Text = "Thông quan \"Bệnh viện\"ở bất kỳ độ khó nào"
  },
  Task_130204_Desc = {
    Text = "Hoàn thành \"Giếng nước\" ở bất kỳ độ khó nào"
  },
  Task_130205_Desc = {
    Text = "Tân sinh đảo ngược·Điên cuồng"
  },
  Task_130206_Desc = {
    Text = "Thông quan \"Nhà\"độ khó Điên Cuồng"
  },
  Task_130207_Desc = {
    Text = "Hoàn thành \"Tổn thương não\" ở độ khó điên cuồng"
  },
  Task_130208_Desc = {
    Text = "Tân sinh đảo ngược·Giới vực"
  },
  Task_130209_Desc = {
    Text = "Hoàn thành tất cả thành tựu \"Tân Sinh Đảo Ngược · Thông Quan\""
  },
  Task_130210_Desc = {
    Text = "Tân sinh đảo ngược·Thông quan"
  },
  Task_130211_Desc = {
    Text = "Sử dụng Thể Thức Tỉnh Giới Vực Siêu Chiều giành chiến thắng 1 lần trong \"Tân Sinh Đảo Ngược\""
  },
  Task_130212_Desc = {
    Text = "Hoàn thành \"Bàn ăn\" ở độ khó điên cuồng"
  },
  Task_130213_Desc = {
    Text = "Sử dụng Thể Thức Tỉnh Giới Vực Hỗn Loạn giành chiến thắng 2 lần trong \"Tân Sinh Đảo Ngược\""
  },
  Task_130412_Desc = {
    Text = "Nhận được nguồn gốc Orci khi khởi linh 2"
  },
  Task_130412_Name = {
    Text = "Nhận được nguồn gốc Orci khi khởi linh 2"
  },
  Task_130412_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà Thể thức tỉnh nguồn gốc Orci khởi linh 2"
  },
  Task_130413_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_130414_Desc = {
    Text = "Nhận được Shaye khi khởi linh 2"
  },
  Task_130414_Name = {
    Text = "Nhận được Shaye khi khởi linh 2"
  },
  Task_130414_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà khởi linh thân thể được đánh thức Sa Ya 2"
  },
  Task_130416_Desc = {
    Text = "Nhận được Shaya khi khởi linh cấp 6"
  },
  Task_130416_Name = {
    Text = "Nhận được Shaya khi khởi linh cấp 6"
  },
  Task_130416_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà khởi linh thân thể được đánh thức Sa Ya 2"
  },
  Task_130417_Desc = {
    Text = "Khi nhận được Sato Guya, khởi linh cấp 2"
  },
  Task_130417_Name = {
    Text = "Khi nhận được Sato Guya, khởi linh cấp 2"
  },
  Task_130417_UnlockCondDesc = {
    Text = "Hoạt động @thân thể được đánh thức Sát Tô Cổ Á khởi linh gói quà 2 hoạt động"
  },
  Task_130418_Desc = {
    Text = "Nhận được Satogua khi khởi linh cấp 6"
  },
  Task_130418_Name = {
    Text = "Nhận được Satogua khi khởi linh cấp 6"
  },
  Task_130418_UnlockCondDesc = {
    Text = "Hoạt động @thân thể được đánh thức Sát Tô Cổ Á khởi linh gói quà 2 hoạt động"
  },
  Task_130420_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_130421_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_130424_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_130425_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_130427_Desc = {
    Text = "Nhận được nguồn gốc Orci khi khởi linh 6"
  },
  Task_130427_Name = {
    Text = "Nhận được nguồn gốc Orci khi khởi linh 6"
  },
  Task_130427_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà Thể thức tỉnh nguồn gốc Orci khởi linh 2"
  },
  Task_130429_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_130440_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_130441_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_130442_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_130446_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_130447_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_130448_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_130459_Desc = {
    Text = "Tỷ lệ đồng điều của nguồn gốc Orci đạt cấp 10"
  },
  Task_130460_Desc = {
    Text = "Satoquya tỷ lệ đồng điều đạt cấp 10"
  },
  Task_130461_Desc = {
    Text = "Tỷ lệ đồng điều của Sa Dã đạt cấp 10"
  },
  Task_130555_Desc = {
    Text = "Đạt được 3 trận thắng trong mùa giải này"
  },
  Task_130555_Name = {
    Text = "3 trận thắng"
  },
  Task_130556_Desc = {
    Text = "Đạt được tổng cộng 10 trận thắng trong mùa giải này"
  },
  Task_130556_Name = {Text = "10 thắng"},
  Task_130557_Desc = {
    Text = "Đạt được tích lũy 1 trận thắng trong mùa giải này"
  },
  Task_130557_Name = {
    Text = "1 trận thắng"
  },
  Task_130558_Desc = {
    Text = "Đạt được tổng cộng 6 trận thắng trong mùa giải này"
  },
  Task_130558_Name = {Text = "6 thắng"},
  Task_130950_Desc = {
    Text = "Hoàn thành \"Đại·Tuyến·Quá\"độ khó điên cuồng"
  },
  Task_130951_Desc = {
    Text = "Hoàn thành \"Ngày Thường\"độ khó điên cuồng"
  },
  Task_130952_Desc = {
    Text = "Hoàn thành \"Tiếng Nổ Sấm Sét\"ở bất kỳ độ khó nào"
  },
  Task_130953_Desc = {
    Text = "Hoàn thành \"Khám Phá Đồng Hành\"độ khó điên cuồng"
  },
  Task_130954_Desc = {
    Text = "Mosk và biển·Cõi"
  },
  Task_130956_Desc = {
    Text = "Hoàn thành tất cả thành tựu của \"Mosk và Biển·Hoàn thành\""
  },
  Task_130957_Desc = {
    Text = "Hoàn thành \"Đại·Tuần·Vortex\" mọi độ khó"
  },
  Task_130958_Desc = {
    Text = "Nhận được Mosk khi khởi linh 6"
  },
  Task_130958_Name = {
    Text = "Nhận được Mosk khi khởi linh 6"
  },
  Task_130958_UnlockCondDesc = {
    Text = "Hoạt động @thức tỉnh thể Mosk khởi linh quà tặng 2"
  },
  Task_130959_Desc = {
    Text = "Hoàn thành \"Đại·Tuần·Vortex\" mọi độ khó"
  },
  Task_130960_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_130961_Desc = {
    Text = "Mosk và biển · Hoàn thành"
  },
  Task_130962_Desc = {
    Text = "Hoàn thành \"Đường trở về\"ở bất kỳ độ khó nào"
  },
  Task_130963_Desc = {
    Text = "Hoàn thành duy thức tiềm hành \"Nghiện\""
  },
  Task_130964_Desc = {
    Text = "Sử dụng thể thức tỉnh từ cõi hỗn mang để giành chiến thắng 2 lần trong \"Mosk và biển\""
  },
  Task_130965_Desc = {
    Text = "Hoàn thành \"Ngày Bình Thường\"ở bất kỳ độ khó nào"
  },
  Task_130966_Desc = {
    Text = "Hoàn thành \"Thời khắc ra khơi\" bất kỳ độ khó nào"
  },
  Task_130967_Desc = {
    Text = "Hoàn thành \"Đường trở về\"ở bất kỳ độ khó nào"
  },
  Task_130968_Desc = {
    Text = "Hoàn thành \"Phát hiện đồng đội\"ở bất kỳ độ khó nào"
  },
  Task_130970_Desc = {
    Text = "Nhận được Mosk khi khởi linh 2"
  },
  Task_130970_Name = {
    Text = "Nhận được Mosk khi khởi linh 2"
  },
  Task_130970_UnlockCondDesc = {
    Text = "Hoạt động @thức tỉnh thể Mosk khởi linh quà tặng 2"
  },
  Task_130971_Desc = {
    Text = "Sử dụng Thể thức tỉnh Cõi thịt máu để giành chiến thắng 1 lần trong \"Mosk và Biển\""
  },
  Task_130972_Desc = {
    Text = "Hoàn thành \"Tiếng Nổ Sấm Sét\"ở bất kỳ độ khó nào"
  },
  Task_130973_Desc = {
    Text = "Hoàn thành \"Kho báu trôi dạt\"độ khó điên cuồng"
  },
  Task_130974_Desc = {
    Text = "Hoàn thành \"Thời khắc ra khơi\"độ khó điên cuồng"
  },
  Task_130975_Desc = {
    Text = "Mosk tỷ lệ đồng điều đạt cấp 10"
  },
  Task_130976_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_130977_Desc = {
    Text = "Hoàn thành \"Phát hiện đồng đội\"ở bất kỳ độ khó nào"
  },
  Task_130978_Desc = {
    Text = "Sử dụng Thể thức tỉnh Hải Vực trong \"Mosk và Biển\"để giành chiến thắng 1 lần"
  },
  Task_130979_Desc = {
    Text = "Hoàn thành \"Sấm Sét Ầm ĩ\"độ khó điên cuồng"
  },
  Task_130980_Desc = {
    Text = "Sử dụng thể thức tỉnh từ cõi hỗn mang để giành chiến thắng 1 lần trong \"Mosk và Biển\""
  },
  Task_130981_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_130982_Desc = {
    Text = "Hoàn thành \"Đường trở về\"độ khó điên cuồng"
  },
  Task_130983_Desc = {
    Text = "Sử dụng thể thức tỉnh trong siêu chiều cõi để giành chiến thắng 2 lần trong \"Mosk và Biển\""
  },
  Task_130984_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_130985_Desc = {
    Text = "Hoàn thành \"Thời khắc ra khơi\" bất kỳ độ khó nào"
  },
  Task_130986_Desc = {
    Text = "Sử dụng Thể thức tỉnh Hải Vực để giành chiến thắng 2 lần trong \"Mosk và Biển\""
  },
  Task_130987_Desc = {
    Text = "Sử dụng thể thức tỉnh Cõi thịt máu để giành chiến thắng 2 lần trong \"Mosk và Biển\""
  },
  Task_130988_Desc = {
    Text = "Hoàn thành \"Kho báu trôi dạt\" bất kỳ độ khó nào"
  },
  Task_130989_Desc = {
    Text = "Sử dụng thể thức tỉnh trong siêu chiều cõi để giành chiến thắng 1 lần trong \"MoskVới biển\""
  },
  Task_130990_Desc = {
    Text = "Hoàn thành \"Ngày Bình Thường\"ở bất kỳ độ khó nào"
  },
  Task_130991_Desc = {
    Text = "Hoàn thành \"Kho báu trôi dạt\" bất kỳ độ khó nào"
  },
  Task_130992_Desc = {
    Text = "Mosk và biển·Điên rồ"
  },
  Task_131106_Desc = {
    Text = "Ngăn chặn Nephreya"
  },
  Task_131106_Name = {
    Text = "Mục tiêu"
  },
  Task_131172_Desc = {
    Text = "Đường mệnh đồng hợp·Đặc quyền có thời hạn"
  },
  Task_131371_Desc = {
    Text = "Giá trị luyện tập ở khu vực d-khu vực đạt đến 100"
  },
  Task_131372_Desc = {
    Text = "Tích lũy thức tỉnh 30 lần"
  },
  Task_131373_Desc = {
    Text = "Tích lũy thức tỉnh 30 lần"
  },
  Task_131374_Desc = {
    Text = "Tiêu hao 1500 điểm Menophin"
  },
  Task_131375_Desc = {
    Text = "Hoàn thành tất cả các nhiệm vụ thử thách hàng tuần trong 1 tuần"
  },
  Task_131376_Desc = {
    Text = "Đăng nhập liên tiếp 1 ngày"
  },
  Task_131377_Desc = {
    Text = "Hoàn thành 20 nhiệm vụ"
  },
  Task_131378_Desc = {
    Text = "Hoàn thành tất cả các nhiệm vụ thử thách hàng tuần trong 1 tuần"
  },
  Task_131379_Desc = {
    Text = "Giá trị luyện tập ở khu vực d-khu vực đạt đến 100"
  },
  Task_131380_Desc = {
    Text = "Hoàn thành 20 nhiệm vụ"
  },
  Task_131381_Desc = {
    Text = "Thực hiện vượt ải tồn tại siêu nghiệm 1 lầ"
  },
  Task_131382_Desc = {
    Text = "Tiêu hao 1500 điểm Menophin"
  },
  Task_131383_Desc = {
    Text = "Thực hiện vượt ải tồn tại siêu nghiệm 1 lầ"
  },
  Task_131384_Desc = {
    Text = "Đăng nhập liên tiếp 1 ngày"
  },
  Task_131385_Desc = {
    Text = "Hoàn thành 1 lần chơi thử Lắc"
  },
  Task_131386_Desc = {
    Text = "Hoàn thành 1 lần chơi thử Lắc"
  },
  Task_131450_Desc = {
    Text = "Đánh bại 60 thể thức tỉnh trong đối đầu pha"
  },
  Task_131451_Desc = {
    Text = "Đánh bại 36 thể thức tỉnh trong chế độ đối đầu pha"
  },
  Task_131452_Desc = {
    Text = "Trong chế độ chuẩn bị, giành được 10 trận thắng"
  },
  Task_131453_Desc = {
    Text = "Chơi bài 740 lần trong chế độ đối đầu pha"
  },
  Task_131454_Desc = {
    Text = "Giải phóng cơn thịnh nộ bùng phát 108 lần trong đối đầu pha"
  },
  Task_131455_Desc = {
    Text = "Trong đối đầu pha phát động điên cuồng bùng nổ 192 lần"
  },
  Task_131456_Desc = {
    Text = "Giải phóng cơn thịnh nộ bùng phát 60 lần trong đối đầu pha"
  },
  Task_131457_Desc = {
    Text = "Đánh bại 111 thể thức tỉnh trong chế độ đối đầu pha"
  },
  Task_131458_Desc = {
    Text = "Đánh bài 300 lần trong chế độ đối đầu pha"
  },
  Task_131459_Desc = {
    Text = "Chơi bài 480 lần trong chế độ đối đầu pha"
  },
  Task_131460_Desc = {
    Text = "Đánh bài 320 lần trong chế độ đối đầu pha"
  },
  Task_131461_Desc = {
    Text = "Đánh bại 6 thể thức tỉnh trong đối đầu pha"
  },
  Task_131462_Desc = {
    Text = "Đánh bại 129 thể thức tỉnh trong đối đầu pha"
  },
  Task_131463_Desc = {
    Text = "Trong đối đầu pha, phát động điên cuồng bùng phát 102 lần"
  },
  Task_131464_Desc = {
    Text = "Đánh bài 100 lần trong chế độ đối đầu pha"
  },
  Task_131465_Desc = {
    Text = "Giải phóng cơn thịnh nộ bùng phát 66 lần trong đối đầu pha"
  },
  Task_131466_Desc = {
    Text = "Đánh bại 12 thể thức tỉnh trong đối đầu pha"
  },
  Task_131467_Desc = {
    Text = "Đạt tổng cộng 45 trận thắng trong đối đầu pha"
  },
  Task_131468_Desc = {
    Text = "Trong đối đầu pha, giải phóng cơn thịnh nộ bùng phát 54 lần"
  },
  Task_131469_Desc = {
    Text = "Giải phóng cơn thịnh nộ bùng phát 240 lần trong chế độ đối đầu pha"
  },
  Task_131470_Desc = {
    Text = "Đánh bại 99 thể thức tỉnh trong chế độ đối đầu pha"
  },
  Task_131471_Desc = {
    Text = "Đánh bại 87 thể thức tỉnh trong đối đầu pha"
  },
  Task_131472_Desc = {
    Text = "Trong chế độ lựa chọn vòng, chơi lại một ván và đánh bại đối thủ 1 lần"
  },
  Task_131473_Desc = {
    Text = "Đánh bại 30 thể thức tỉnh trong đối đầu pha"
  },
  Task_131474_Desc = {
    Text = "Trong chế độ chuẩn bị, chuỗi chiến thắng liên tiếp 2 trận 1 lần"
  },
  Task_131475_Desc = {
    Text = "Trong chế độ lựa chọn vòng, giành được 2 trận thắng"
  },
  Task_131476_Desc = {
    Text = "Giải phóng cơn thịnh nộ 156 lần trong chế độ đối đầu pha"
  },
  Task_131477_Desc = {
    Text = "Trong chế độ lựa chọn vòng, giành được 6 trận thắng"
  },
  Task_131478_Desc = {
    Text = "Đánh bài 160 lần trong chế độ đối đầu pha"
  },
  Task_131479_Desc = {
    Text = "Đánh bại 135 thể thức tỉnh trong chế độ đối đầu pha"
  },
  Task_131480_Desc = {
    Text = "Chơi bài 880 lần trong chế độ đối đầu pha"
  },
  Task_131481_Desc = {
    Text = "Phát động cơn thịnh nộ bùng phát 132 lần trong đối đầu pha"
  },
  Task_131482_Desc = {
    Text = "Giải phóng cơn thịnh nộ bùng phát 204 lần trong đối đầu pha"
  },
  Task_131483_Desc = {
    Text = "Trong chế độ chuẩn bị, giành được 4 trận thắng"
  },
  Task_131484_Desc = {
    Text = "Trong đối đầu pha, phát động điên cuồng bùng nổ 144 lần"
  },
  Task_131485_Desc = {
    Text = "Chơi bài 240 lần trong đối đầu pha"
  },
  Task_131486_Desc = {
    Text = "Chơi 940 lần trong chế độ đối đầu pha"
  },
  Task_131487_Desc = {
    Text = "Giải phóng cơn thịnh nộ bùng phát 210 lần trong đối đầu pha"
  },
  Task_131488_Desc = {
    Text = "Trong đối đầu pha, phát động điên cuồng bùng phát 174 lần"
  },
  Task_131489_Desc = {
    Text = "Đánh bại 54 thể thức tỉnh trong đối đầu pha"
  },
  Task_131490_Desc = {
    Text = "Đánh bại 21 thể thức tỉnh trong chế độ đối đầu pha"
  },
  Task_131491_Desc = {
    Text = "Chơi bài 180 lần trong đối đầu pha"
  },
  Task_131492_Desc = {
    Text = "Thử Thách Vinh Quý"
  },
  Task_131493_Desc = {
    Text = "Đánh bài 400 lần trong chế độ đối đầu pha"
  },
  Task_131494_Desc = {
    Text = "Đánh bại 57 thể thức tỉnh trong đối đầu pha"
  },
  Task_131495_Desc = {
    Text = "Trong chế độ lựa chọn vòng, giành 8 chiến thắng"
  },
  Task_131496_Desc = {
    Text = "Đánh bại 81 thể thức tỉnh trong đối đầu pha"
  },
  Task_131497_Desc = {
    Text = "Đánh bại 93 thể thức tỉnh trong đối đầu pha"
  },
  Task_131498_Desc = {
    Text = "Đánh bại 120 thể thức tỉnh trong đối đầu pha"
  },
  Task_131499_Desc = {
    Text = "Trong đối đầu pha, phát động điên cuồng 30 lần"
  },
  Task_131500_Desc = {
    Text = "Chơi bài 220 lần trong chế độ đối đầu pha"
  },
  Task_131501_Desc = {
    Text = "Giải phóng cơn thịnh nộ bùng phát 264 lần trong đối đầu pha"
  },
  Task_131502_Desc = {
    Text = "Đánh bại 102 thể thức tỉnh trong đối đầu pha"
  },
  Task_131503_Desc = {
    Text = "Chơi 140 lần trong chế độ đối đầu pha"
  },
  Task_131504_Desc = {
    Text = "Trong đối đầu pha phát động điên cuồng bùng phát 96 lần"
  },
  Task_131505_Desc = {
    Text = "Trong chế độ chuẩn bị, chơi lại một ván và đánh bại đối thủ 1 lần"
  },
  Task_131506_Desc = {
    Text = "Trong đối đầu pha, phát động điên cuồng bùng phát 78 lần"
  },
  Task_131507_Desc = {
    Text = "Đánh bài 1000 lần trong chế độ đối đầu pha"
  },
  Task_131508_Desc = {
    Text = "Trong đối đầu pha, giải phóng điên cuồng bùng nổ 90 lần"
  },
  Task_131509_Desc = {
    Text = "Đánh bại 132 thể thức tỉnh trong chế độ đối đầu pha"
  },
  Task_131510_Desc = {
    Text = "Đánh bại 126 thể thức tỉnh trong chế độ đối đầu pha"
  },
  Task_131511_Desc = {
    Text = "Đánh bại 9 Thể thức tỉnh trong đối đầu pha"
  },
  Task_131512_Desc = {
    Text = "Trong đối đầu pha, phát động điên cuồng bùng nổ 168 lần"
  },
  Task_131513_Desc = {
    Text = "Giải phóng điên cuồng bùng phát 162 lần trong đối đầu pha"
  },
  Task_131514_Desc = {
    Text = "Trong chế độ đối đầu pha giải phóng điên cuồng bùng phát 222 lần"
  },
  Task_131515_Desc = {
    Text = "Thử Thách Ngưỡng"
  },
  Task_131516_Desc = {
    Text = "Đánh bài 380 lần trong chế độ đối đầu pha"
  },
  Task_131517_Desc = {
    Text = "Chơi bài 660 lần trong chế độ đối đầu pha"
  },
  Task_131518_Desc = {
    Text = "Trong đối đầu pha phát động điên cuồng bùng phát 114 lần"
  },
  Task_131519_Desc = {
    Text = "Trong đối đầu pha, phát động điên cuồng bùng phát 120 lần"
  },
  Task_131520_Desc = {
    Text = "Đánh bại 144 thể thức tỉnh trong đối đầu pha"
  },
  Task_131521_Desc = {
    Text = "Đánh bại 24 thể thức tỉnh trong chế độ đối đầu pha"
  },
  Task_131522_Desc = {
    Text = "Đánh bại 42 thể thức tỉnh trong chế độ đối đầu pha"
  },
  Task_131523_Desc = {
    Text = "Ra bài 460 lần trong đối đầu pha"
  },
  Task_131524_Desc = {
    Text = "Trong đối đầu pha, giải phóng điên cuồng bùng phát 180 lần"
  },
  Task_131525_Desc = {
    Text = "Chơi bài 520 lần trong chế độ đối đầu pha"
  },
  Task_131526_Desc = {
    Text = "Chơi bài 840 lần trong chế độ đối đầu pha"
  },
  Task_131527_Desc = {
    Text = "Đánh bại 69 thể thức tỉnh trong đối đầu pha"
  },
  Task_131528_Desc = {
    Text = "Chơi bài 720 lần trong chế độ đối đầu pha"
  },
  Task_131529_Desc = {
    Text = "Đánh bại 33 thể thức tỉnh trong đối đầu pha"
  },
  Task_131530_Desc = {
    Text = "Đánh bại 39 thể thức tỉnh trong đối đầu pha"
  },
  Task_131531_Desc = {
    Text = "Đánh bài 860 lần trong chế độ đối đầu pha"
  },
  Task_131532_Desc = {
    Text = "Đánh bài 560 lần trong chế độ đối đầu pha"
  },
  Task_131533_Desc = {
    Text = "Chơi 600 lần trong chế độ đối đầu pha"
  },
  Task_131534_Desc = {
    Text = "Trong đối đầu pha, nhấp vào ảnh đại diện để gửi bất kỳ biểu cảm nào cho 3 đối thủ"
  },
  Task_131535_Desc = {
    Text = "Đánh bại 66 thể thức tỉnh trong đối đầu pha"
  },
  Task_131536_Desc = {
    Text = "Đánh ra thẻ bài 200 lần trong chế độ đối đầu pha"
  },
  Task_131537_Desc = {
    Text = "Trong chế độ lựa chọn vòng, giành được 1 chiến thắng"
  },
  Task_131538_Desc = {
    Text = "Trong đối đầu pha giải phóng điên cuồng bùng nổ 234 lần"
  },
  Task_131539_Desc = {
    Text = "Chơi bài 820 lần trong chế độ đối đầu pha"
  },
  Task_131540_Desc = {
    Text = "Trong đối đầu pha giải phóng cơn thịnh nộ bùng phát 18 lần"
  },
  Task_131541_Desc = {
    Text = "Đánh bại 63 thể thức tỉnh trong đối đầu pha"
  },
  Task_131542_Desc = {
    Text = "Giải phóng cơn thịnh nộ bùng phát 258 lần trong đối đầu pha"
  },
  Task_131543_Desc = {
    Text = "Sau khi kết thúc trận đấu đối đầu pha, thích đối thủ 1 lần"
  },
  Task_131544_Desc = {
    Text = "Đạt được 25 chiến thắng tích lũy trong chế độ đối đầu pha"
  },
  Task_131545_Desc = {
    Text = "Đánh bại 27 thể thức tỉnh trong đối đầu pha"
  },
  Task_131546_Desc = {
    Text = "Đánh bại 18 thể thức tỉnh trong đối đầu pha"
  },
  Task_131547_Desc = {
    Text = "Đánh bại 150 thể thức tỉnh trong chế độ đối đầu pha"
  },
  Task_131548_Desc = {
    Text = "Trong đối đầu pha, giải phóng cơn thịnh nộ bùng phát 48 lần"
  },
  Task_131549_Desc = {
    Text = "Chơi bài 20 lần trong chế độ đối đầu pha"
  },
  Task_131550_Desc = {
    Text = "Trong đối đầu pha, giải phóng cơn thịnh nộ bùng phát 36 lần"
  },
  Task_131551_Desc = {
    Text = "Đánh bại 15 thể thức tỉnh trong chế độ đối đầu pha"
  },
  Task_131552_Desc = {
    Text = "Đánh bại 84 thể thức tỉnh trong đối đầu pha"
  },
  Task_131553_Desc = {
    Text = "Chơi bài 280 lần trong chế độ đối đầu pha"
  },
  Task_131554_Desc = {
    Text = "Trong đối đầu pha, giải phóng điên cuồng bùng phát 72 lần"
  },
  Task_131555_Desc = {
    Text = "Đánh bại 108 thể thức tỉnh trong chế độ đối đầu pha"
  },
  Task_131556_Desc = {
    Text = "Trong đối đầu pha, giải phóng cơn thịnh nộ bùng phát 246 lần"
  },
  Task_131557_Desc = {
    Text = "Chơi bài 700 lần trong chế độ đối đầu pha"
  },
  Task_131558_Desc = {
    Text = "Đạt 35 chiến thắng tích lũy trong chế độ đối đầu pha"
  },
  Task_131559_Desc = {
    Text = "Đạt 50 trận thắng tích lũy trong chế độ đối đầu pha"
  },
  Task_131560_Desc = {
    Text = "Đánh bại 3 thể thức tỉnh trong đối đầu pha"
  },
  Task_131561_Desc = {
    Text = "Đánh bại 75 thể thức tỉnh trong chế độ đối đầu pha"
  },
  Task_131562_Desc = {
    Text = "Đánh bại 51 thể thức tỉnh trong chế độ đối đầu pha"
  },
  Task_131563_Desc = {
    Text = "Chơi 120 lần trong chế độ đối đầu pha"
  },
  Task_131564_Desc = {
    Text = "Đánh bại 78 thể thức tỉnh trong đối đầu pha"
  },
  Task_131565_Desc = {
    Text = "Đánh bại 138 thể thức tỉnh trong chế độ đối đầu pha"
  },
  Task_131566_Desc = {
    Text = "Đánh bại 90 thể thức tỉnh trong đối đầu pha"
  },
  Task_131567_Desc = {
    Text = "Thử Thách Bí Ẩn"
  },
  Task_131568_Desc = {
    Text = "Trong chế độ chuẩn bị, giành được 6 trận thắng"
  },
  Task_131569_Desc = {
    Text = "Trong chế độ chuẩn bị, giành 8 trận thắng"
  },
  Task_131570_Desc = {
    Text = "Đánh bại 117 thể thức tỉnh trong chế độ đối đầu pha"
  },
  Task_131571_Desc = {
    Text = "Đạt được 40 chiến thắng tích lũy trong chế độ đối đầu pha"
  },
  Task_131572_Desc = {
    Text = "Phát động cơn thịnh nộ bùng phát 126 lần trong chế độ đối đầu pha"
  },
  Task_131573_Desc = {
    Text = "Chơi bài 760 lần trong chế độ đối đầu pha"
  },
  Task_131574_Desc = {
    Text = "Trong đối đầu pha giải phóng cơn thịnh nộ bùng phát 270 lần"
  },
  Task_131575_Desc = {
    Text = "Trong chế độ chuẩn bị, giành được 1 trận thắng"
  },
  Task_131576_Desc = {
    Text = "Trong đối đầu pha, phát động điên cuồng bùng nổ 84 lần"
  },
  Task_131577_Desc = {
    Text = "Giải phóng cơn thịnh nộ bùng phát 294 lần trong đối đầu pha"
  },
  Task_131578_Desc = {
    Text = "Đạt được 30 chiến thắng tích lũy trong đối đầu pha"
  },
  Task_131579_Desc = {
    Text = "Chơi 960 lần trong chế độ đối đầu pha"
  },
  Task_131580_Desc = {
    Text = "Đánh bài 260 lần trong chế độ đối đầu pha"
  },
  Task_131581_Desc = {
    Text = "Trong đối đầu pha, giải phóng điên cuồng bùng phát 42 lần"
  },
  Task_131582_Desc = {
    Text = "Đánh bại 96 thể thức tỉnh trong chế độ đối đầu pha"
  },
  Task_131583_Desc = {
    Text = "Giải phóng cơn thịnh nộ bùng phát 228 lần trong đối đầu pha"
  },
  Task_131584_Desc = {
    Text = "Chơi 40 lần trong chế độ đối đầu pha"
  },
  Task_131585_Desc = {
    Text = "Đánh bài 800 lần trong chế độ đối đầu pha"
  },
  Task_131586_Desc = {
    Text = "Đánh bài 580 lần trong chế độ đối đầu pha"
  },
  Task_131587_Desc = {
    Text = "Trong đối đầu pha, phát động điên cuồng bùng phát 150 lần"
  },
  Task_131588_Desc = {
    Text = "Đánh bại 114 thể thức tỉnh trong chế độ đối đầu pha"
  },
  Task_131589_Desc = {
    Text = "Chơi bài 780 lần trong chế độ đối đầu pha"
  },
  Task_131590_Desc = {
    Text = "Giải phóng điên cuồng bùng nổ 24 lần trong đối đầu pha"
  },
  Task_131591_Desc = {
    Text = "Trong đối đầu pha, giải phóng cơn thịnh nộ bùng phát 216 lần"
  },
  Task_131592_Desc = {
    Text = "Giải phóng cơn thịnh nộ bùng phát 276 lần trong đối đầu pha"
  },
  Task_131593_Desc = {
    Text = "Trong chế độ đối đầu pha, đánh ra 500 lần"
  },
  Task_131594_Desc = {
    Text = "Đánh bại 147 thể thức tỉnh trong chế độ đối đầu pha"
  },
  Task_131595_Desc = {
    Text = "Trong chế độ chuẩn bị, giành được 2 trận thắng"
  },
  Task_131596_Desc = {
    Text = "Đánh bại 72 thể thức tỉnh trong đối đầu pha"
  },
  Task_131597_Desc = {
    Text = "Đánh bài 640 lần trong chế độ đối đầu pha"
  },
  Task_131598_Desc = {
    Text = "Đánh bại 105 thể thức tỉnh trong chế độ đối đầu pha"
  },
  Task_131599_Desc = {
    Text = "Giải phóng cơn thịnh nộ bùng phát 300 lần trong chế độ đối đầu pha"
  },
  Task_131600_Desc = {
    Text = "Đánh bại 48 thể thức tỉnh trong đối đầu pha"
  },
  Task_131601_Desc = {
    Text = "Đánh bài 920 lần trong chế độ đối đầu pha"
  },
  Task_131602_Desc = {
    Text = "Chơi 60 lần thẻ bài trong chế độ đối đầu pha"
  },
  Task_131603_Desc = {
    Text = "Chơi bài 360 lần trong chế độ đối đầu pha"
  },
  Task_131604_Desc = {
    Text = "Giải phóng cơn thịnh nộ bùng phát 282 lần trong đối đầu pha"
  },
  Task_131605_Desc = {
    Text = "Chơi bài 440 lần trong chế độ đối đầu pha"
  },
  Task_131606_Desc = {
    Text = "Đánh bại 123 thể thức tỉnh trong chế độ đối đầu pha"
  },
  Task_131607_Desc = {
    Text = "Trong đối đầu pha, phát động điên cuồng bùng nổ 198 lần"
  },
  Task_131608_Desc = {
    Text = "Chơi bài 680 lần trong chế độ đối đầu pha"
  },
  Task_131609_Desc = {
    Text = "Đánh bại 45 thể thức tỉnh trong chế độ đối đầu pha"
  },
  Task_131610_Desc = {
    Text = "Trong chế độ lựa chọn vòng, liên tiếp giành chiến thắng 2 lần"
  },
  Task_131611_Desc = {
    Text = "Trong đối đầu pha, giải phóng điên cuồng bùng nổ 186 lần"
  },
  Task_131612_Desc = {
    Text = "Trong đối đầu pha, giải phóng điên cuồng bùng nổ 6 lần"
  },
  Task_131613_Desc = {
    Text = "Chơi bài 620 lần trong chế độ đối đầu pha"
  },
  Task_131614_Desc = {
    Text = "Trong chế độ lựa chọn vòng, liên tiếp giành chiến thắng 2 trận 1 lần"
  },
  Task_131615_Desc = {
    Text = "Đánh bài 900 lần trong chế độ đối đầu pha"
  },
  Task_131616_Desc = {
    Text = "Trong chế độ đối đầu pha, phát động cơn thịnh nộ bùng phát 252 lần"
  },
  Task_131617_Desc = {
    Text = "Đánh bài 980 lần trong chế độ đối đầu pha"
  },
  Task_131618_Desc = {
    Text = "Đánh bại 141 thể thức tỉnh trong chế độ đối đầu pha"
  },
  Task_131619_Desc = {
    Text = "Trong đối đầu pha, giải phóng cơn thịnh nộ bùng phát 288 lần"
  },
  Task_131620_Desc = {
    Text = "Chơi bài 420 lần trong chế độ đối đầu pha"
  },
  Task_131621_Desc = {
    Text = "Trong chế độ lựa chọn vòng, đạt được 10 trận thắng"
  },
  Task_131622_Desc = {
    Text = "Chơi bài 340 lần trong chế độ đối đầu pha"
  },
  Task_131623_Desc = {
    Text = "Trong chế độ lựa chọn vòng, giành được 4 chiến thắng"
  },
  Task_131624_Desc = {
    Text = "Chơi bài 80 lần trong chế độ đối đầu pha"
  },
  Task_131625_Desc = {
    Text = "Trong chế độ chuẩn bị, chuỗi chiến thắng hai trận 2 lần"
  },
  Task_131626_Desc = {
    Text = "Chơi bài 540 lần trong chế độ đối đầu pha"
  },
  Task_131627_Desc = {
    Text = "Trong đối đầu pha, phát động cơn thịnh nộ bùng phát 138 lần"
  },
  Task_131628_Desc = {
    Text = "Trong đối đầu pha, kích hoạt điên cuồng bùng nổ 12 lần"
  },
  Task_131768_Desc = {
    Text = "Hoàn thành duy thức tiềm hành \"Nghiện\""
  },
  Task_131768_Name = {Text = "Két!"},
  Task_131801_Name = {
    Text = "Hoạt động tái hiện lượt đảo ngược kết thúc"
  },
  Task_131891_Desc = {
    Text = "Ký ức vĩnh hằng·Giới hạn thời gian độc quyền"
  },
  Task_131892_Desc = {
    Text = "Ký ức vĩnh hằng V"
  },
  Task_131893_Desc = {
    Text = "Ký ức vĩnh hằng VII"
  },
  Task_131894_Desc = {
    Text = "Ký ức vĩnh hằng II"
  },
  Task_131895_Desc = {
    Text = "Ký ức vĩnh hằng I"
  },
  Task_131896_Desc = {
    Text = "Ký ức vĩnh hằng·Miễn phí"
  },
  Task_131897_Desc = {
    Text = "Ký ức vĩnh hằng III"
  },
  Task_131898_Desc = {
    Text = "Ký ức vĩnh hằng IV"
  },
  Task_131899_Desc = {
    Text = "Ký ức vĩnh hằng VI"
  },
  Task_132335_Desc = {
    Text = "Hoàn thành duy thức tiềm hành \"Ngày đăng quang\""
  },
  Task_132454_Desc = {
    Text = "Đạt được tổng cộng 10 trận thắng trong mùa giải này"
  },
  Task_132454_Name = {Text = "10 thắng"},
  Task_132455_Desc = {
    Text = "Đạt được 3 trận thắng trong mùa giải này"
  },
  Task_132455_Name = {
    Text = "3 trận thắng"
  },
  Task_132456_Desc = {
    Text = "Đạt được tổng cộng 6 trận thắng trong mùa giải này"
  },
  Task_132456_Name = {Text = "6 thắng"},
  Task_132457_Desc = {
    Text = "Đạt được tích lũy 1 trận thắng trong mùa giải này"
  },
  Task_132457_Name = {
    Text = "1 trận thắng"
  },
  Task_132689_Desc = {
    Text = "Đăng nhập bằng thiết bị PC"
  },
  Task_132690_Desc = {
    Text = "Sử dụng thiết bị di động chiết xuất Nguyên Dịch 1 lần"
  },
  Task_132691_Desc = {
    Text = "Sử dụng thiết bị PC chiết xuất Nguyên Dịch 1 lần"
  },
  Task_132692_Desc = {
    Text = "Sử dụng thiết bị di động để đăng nhập"
  },
  Task_132874_Desc = {
    Text = "Mùa giải này đánh bại thủ lĩnh giai đoạn 3 1 lần"
  },
  Task_132875_Desc = {
    Text = "Mùa giải này chiến thắng 5 lần"
  },
  Task_132876_Desc = {
    Text = "Mùa giải này chiến thắng 5 lần"
  },
  Task_132877_Desc = {
    Text = "Mùa giải này thông quan 3 lần \"Ảo Mộng Thâm Tiềm\""
  },
  Task_132909_Desc = {
    Text = "Thông quan 1 lần màn chơi thử của Arachne"
  },
  Task_132910_Desc = {
    Text = "Hoàn thành 15 lần phái cử"
  },
  Task_132911_Desc = {
    Text = "Hoàn thành bất kỳ một nhiệm vụ mùa giải"
  },
  Task_132912_Desc = {
    Text = "Tích lũy đánh ra 300 lá bài"
  },
  Task_132913_Desc = {
    Text = "Hoàn thành bất kỳ một nhiệm vụ mùa giải"
  },
  Task_132914_Desc = {
    Text = "Thức tỉnh 30 lần"
  },
  Task_132915_Desc = {
    Text = "Giá trị luyện tập ở khu vực d-khu vực đạt đến 100"
  },
  Task_132916_Desc = {
    Text = "Thông quan 1 lần màn chơi thử của Arachne"
  },
  Task_132917_Desc = {
    Text = "Hoàn thành 15 lần phái cử"
  },
  Task_132918_Desc = {
    Text = "Đăng nhập tổng cộng 1 ngày"
  },
  Task_132919_Desc = {
    Text = "Giá trị luyện tập ở khu vực d-khu vực đạt đến 100"
  },
  Task_132920_Desc = {
    Text = "Độ hoạt động tuần đạt 1000"
  },
  Task_132921_Desc = {
    Text = "Độ hoạt động tuần đạt 1000"
  },
  Task_132922_Desc = {
    Text = "Tích lũy đánh ra 300 lá bài"
  },
  Task_132923_Desc = {
    Text = "Đăng nhập tổng cộng 1 ngày"
  },
  Task_132924_Desc = {
    Text = "Thức tỉnh 30 lần"
  },
  Task_132928_Desc = {
    Text = "Hoàn thành tất cả các nhiệm vụ trên"
  },
  Task_132929_Desc = {
    Text = "Tiêu hao Menophin 1800 điểm"
  },
  Task_132930_Desc = {
    Text = "Hoàn thành tất cả nhiệm vụ thử thách hàng tuần trong 1 tuần"
  },
  Task_132931_Desc = {
    Text = "Đăng nhập tích lũy 1 ngày"
  },
  Task_132932_Desc = {
    Text = "Hoàn thành 20 lần phái đi"
  },
  Task_132933_Desc = {
    Text = "Điểm huấn luyện Vùng cấm hòa hợp với thiên tai đạt 100"
  },
  Task_133297_Desc = {
    Text = "Hoàn thành Dị Mộng Thị Giới \"Ký Sự Chinh Phục Bếp\""
  },
  Task_133297_Name = {
    Text = "Cuồng Hỷ! Chấn Nộ! Rơi Lệ!"
  },
  Task_133302_Desc = {
    Text = "\"Ion Hoạt Tính Tinh Túy\"đạt 1000"
  },
  Task_133303_Desc = {
    Text = "Sử dụng hỗ trợ 3 lần"
  },
  Task_133304_Desc = {
    Text = "\"Ion Hoạt Tính Tinh Túy\"đạt 1000"
  },
  Task_133305_Desc = {
    Text = "Tích lũy đánh ra 300 lá bài"
  },
  Task_133306_Desc = {
    Text = "Giá trị luyện tập ở khu vực d-khu vực đạt đến 100"
  },
  Task_133307_Desc = {
    Text = "Giá trị luyện tập ở khu vực d-khu vực đạt đến 100"
  },
  Task_133308_Desc = {
    Text = "Tích lũy đánh ra 300 lá bài"
  },
  Task_133309_Desc = {
    Text = "Thức tỉnh 30 lần"
  },
  Task_133310_Desc = {
    Text = "Đăng nhập tổng cộng 1 ngày"
  },
  Task_133311_Desc = {
    Text = "Hoàn thành nhiệm vụ mùa bất kỳ trong \"Thử Thách Cấm Kỵ\""
  },
  Task_133312_Desc = {
    Text = "Thức tỉnh 30 lần"
  },
  Task_133313_Desc = {
    Text = "Hoàn thành 15 lần phái cử"
  },
  Task_133314_Desc = {
    Text = "Hoàn thành nhiệm vụ mùa bất kỳ trong \"Thử Thách Cấm Kỵ\""
  },
  Task_133315_Desc = {
    Text = "Sử dụng hỗ trợ 3 lần"
  },
  Task_133316_Desc = {
    Text = "Đăng nhập tổng cộng 1 ngày"
  },
  Task_133317_Desc = {
    Text = "Hoàn thành 15 lần phái cử"
  },
  Task_133940_Desc = {
    Text = "Thích bạn cùng trường 1 lần"
  },
  Task_133940_Name = {
    Text = "Bạn bè thích"
  },
  Task_133941_Desc = {
    Text = "Tiêu thụ 180 linh phì peptide"
  },
  Task_133941_Name = {
    Text = "Tiêu thụ thể lực"
  },
  Task_133943_Desc = {
    Text = "Đánh ra 50 lá bài"
  },
  Task_133943_Name = {
    Text = "thử thách hàng ngày"
  },
  Task_133944_Desc = {
    Text = "Gửi đi 3 lần"
  },
  Task_133944_Name = {
    Text = "Tiến hành giao nhiệm vụ"
  },
  Task_133945_Desc = {
    Text = "Hoàn thành Phiên Dịch Mật Ước 50 lần"
  },
  Task_133945_Name = {
    Text = "Chuyển ghi bí ẩn"
  },
  Task_133946_Desc = {
    Text = "Hoàn thành hiện diện siêu việt 1 lần"
  },
  Task_133946_Name = {
    Text = "Boss hàng tuần"
  },
  Task_133947_Desc = {
    Text = "Thực hiện 30 lần Nghi Thức Thức Tỉnh"
  },
  Task_133947_Name = {Text = "Rút thẻ"},
  Task_133948_Desc = {
    Text = "Tiêu hao 1500 Enkephalin"
  },
  Task_133948_Name = {
    Text = "Tiêu thụ thể lực"
  },
  Task_133949_Desc = {
    Text = "Tiêu hao 1.000.000 Phiếu Vàng Tường Vi"
  },
  Task_133949_Name = {
    Text = "Tiêu tiền như nước"
  },
  Task_134074_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"@1@2\""
  },
  Task_134074_Desc2 = {
    Text = "Hoàn thành sự kiện điều tra \"Nhà Hát Dệt Mệnh\""
  },
  Task_134074_Name2 = {
    Text = "Diễn Viên Chính Định Mệnh"
  },
  Task_134075_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"Nhà Hát Dệt Mệnh\"Độ khó Khó"
  },
  Task_134075_Name = {
    Text = "Diễn Viên Chính Định Mệnh · Khó"
  },
  Task_134095_Desc = {
    Text = "Trong cuộc điều tra sự kiện \"@1@2\" cảm ứng 3 lần"
  },
  Task_134095_Desc2 = {
    Text = "Cộng hưởng 3 lần trong sự kiện điều tra \"Nhà Hát Dệt Mệnh\""
  },
  Task_134095_Name2 = {
    Text = "Tiếng Vọng Tuân Phục"
  },
  Task_134096_Desc = {
    Text = "Trong sự kiện điều tra \"@1@2\" cảm ứng 10 lần"
  },
  Task_134096_Desc2 = {
    Text = "Cộng hưởng 10 lần trong sự kiện điều tra \"Nhà Hát Dệt Mệnh\""
  },
  Task_134096_Name2 = {
    Text = "Tiếng Vọng Tuân Phục IV"
  },
  Task_134097_Desc = {
    Text = "Trong cuộc điều tra sự kiện \"@1@2\" cộng hưởng 9 lần"
  },
  Task_134097_Desc2 = {
    Text = "Cộng hưởng 9 lần trong sự kiện điều tra \"Nhà Hát Dệt Mệnh\""
  },
  Task_134097_Name2 = {
    Text = "Tiếng Vọng Tuân Phục III"
  },
  Task_134098_Desc = {
    Text = "Trong cuộc điều tra sự kiện \"@1@2\" gây cộng hưởng 6 lần"
  },
  Task_134098_Desc2 = {
    Text = "Cộng hưởng 6 lần trong sự kiện điều tra \"Nhà Hát Dệt Mệnh\""
  },
  Task_134098_Name2 = {
    Text = "Tiếng Vọng Tuân Phục II"
  },
  Task_134099_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_134099_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_134121_Desc = {
    Text = "Carab đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134122_Desc = {
    Text = "Caecus đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134123_Desc = {
    Text = "Pharos đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134124_Desc = {
    Text = "Mocha đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134125_Desc = {
    Text = "Saya đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134126_Desc = {
    Text = "Tsathoggua đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134127_Desc = {
    Text = "Thais đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134128_Desc = {
    Text = "Bản Nguyên Chúa Tể Say Ngủ đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134129_Desc = {
    Text = "Shilo đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134130_Desc = {
    Text = "Tavi đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134131_Desc = {
    Text = "Pollux đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134132_Desc = {
    Text = "\"24\"đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134134_Desc = {
    Text = "Yuhashi đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134135_Desc = {
    Text = "Đản Vọng · Murphy đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134136_Desc = {
    Text = "Dung Hủy · Dor đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134137_Desc = {
    Text = "Pickman đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134138_Desc = {
    Text = "Pandiya đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134140_Desc = {
    Text = "Orla đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134141_Desc = {
    Text = "Xu đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134142_Desc = {
    Text = "Tincture đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134143_Desc = {
    Text = "Caligula đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134144_Desc = {
    Text = "Rhea đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134145_Desc = {
    Text = "Murphy đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134146_Desc = {
    Text = "Dulcine đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134148_Desc = {
    Text = "Corposant đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134149_Desc = {
    Text = "Lily đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134150_Desc = {
    Text = "Huyết Liên · Shilo đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134151_Desc = {
    Text = "Winkel đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134152_Desc = {
    Text = "Hamelin đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134153_Desc = {
    Text = "Lake đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134154_Desc = {
    Text = "Shan đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134155_Desc = {
    Text = "Cassia đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134156_Desc = {
    Text = "Castor đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134157_Desc = {
    Text = "Moss đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134158_Desc = {
    Text = "Feint đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134159_Desc = {
    Text = "Nodira đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134160_Desc = {
    Text = "Agrippa đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134161_Desc = {
    Text = "Jenkin đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134162_Desc = {
    Text = "Salvador đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134163_Desc = {
    Text = "Arachne đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134164_Desc = {
    Text = "Daffodil đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134165_Desc = {
    Text = "Celeste đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134166_Desc = {
    Text = "Soleil đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134167_Desc = {
    Text = "Goliath đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134168_Desc = {
    Text = "Tulu đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134169_Desc = {
    Text = "Clementine đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134170_Desc = {
    Text = "Galen đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134171_Desc = {
    Text = "Nymphia đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134172_Desc = {
    Text = "Wanda đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134173_Desc = {
    Text = "Liz đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134174_Desc = {
    Text = "Elva đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134175_Desc = {
    Text = "Miriam đạt Thâm Hóa Nhân Cách 12"
  },
  Task_134394_Desc = {
    Text = "Đăng nhập liên tiếp 6 ngày"
  },
  Task_134395_Desc = {
    Text = "Đăng nhập liên tiếp trong 10 ngày"
  },
  Task_134396_Desc = {
    Text = "Đăng nhập tích lũy 16 ngày liên tiếp"
  },
  Task_134397_Desc = {
    Text = "Đăng nhập liên tiếp 7 ngày"
  },
  Task_134398_Desc = {
    Text = "Tích lũy đăng nhập 15 ngày"
  },
  Task_134399_Desc = {
    Text = "Đăng nhập liên tiếp trong 9 ngày"
  },
  Task_134400_Desc = {
    Text = "Đăng nhập liên tiếp 4 ngày"
  },
  Task_134401_Desc = {
    Text = "Tích lũy đăng nhập 14 ngày"
  },
  Task_134402_Desc = {
    Text = "Đăng nhập liên tiếp 5 ngày"
  },
  Task_134403_Desc = {
    Text = "Đăng nhập liên tiếp 11 ngày"
  },
  Task_134404_Desc = {
    Text = "Đăng nhập tích lũy trong 13 ngày"
  },
  Task_134405_Desc = {
    Text = "Đăng nhập liên tiếp 1 ngày"
  },
  Task_134406_Desc = {
    Text = "Đăng nhập liên tiếp 2 ngày"
  },
  Task_134407_Desc = {
    Text = "Đăng nhập liên tiếp 3 ngày"
  },
  Task_134408_Desc = {
    Text = "Đăng nhập liên tiếp 8 ngày"
  },
  Task_134409_Desc = {
    Text = "Đăng nhập liên tiếp 12 ngày"
  },
  Task_135038_Desc = {
    Text = "Đăng nhập vào trò chơi"
  },
  Task_135038_Name = {
    Text = "Đăng nhập vào trò chơi"
  },
  Task_137649_Desc = {
    Text = "Đánh ra 150 lá bài trong mùa này"
  },
  Task_137650_Desc = {
    Text = "Đánh ra 150 lá bài trong mùa này"
  },
  Task_138583_Desc = {
    Text = "Thức tỉnh 30 lần"
  },
  Task_138584_Desc = {
    Text = "Hoàn thành nhiệm vụ mùa bất kỳ trong \"Thử Thách Cấm Kỵ\""
  },
  Task_138585_Desc = {
    Text = "Tích lũy đánh ra 300 lá bài"
  },
  Task_138586_Desc = {
    Text = "Sử dụng hỗ trợ 3 lần"
  },
  Task_138587_Desc = {
    Text = "Giá trị luyện tập ở khu vực d-khu vực đạt đến 100"
  },
  Task_138588_Desc = {
    Text = "Đăng nhập tổng cộng 1 ngày"
  },
  Task_138589_Desc = {
    Text = "Thức tỉnh 30 lần"
  },
  Task_138590_Desc = {
    Text = "Hoàn thành 15 lần phái cử"
  },
  Task_138591_Desc = {
    Text = "Tích lũy đánh ra 300 lá bài"
  },
  Task_138592_Desc = {
    Text = "Sử dụng hỗ trợ 3 lần"
  },
  Task_138593_Desc = {
    Text = "\"Ion Hoạt Tính Tinh Túy\"đạt 1000"
  },
  Task_138594_Desc = {
    Text = "\"Ion Hoạt Tính Tinh Túy\"đạt 1000"
  },
  Task_138595_Desc = {
    Text = "Đăng nhập tổng cộng 1 ngày"
  },
  Task_138596_Desc = {
    Text = "Hoàn thành nhiệm vụ mùa bất kỳ trong \"Thử Thách Cấm Kỵ\""
  },
  Task_138597_Desc = {
    Text = "Hoàn thành 15 lần phái cử"
  },
  Task_138598_Desc = {
    Text = "Giá trị luyện tập ở khu vực d-khu vực đạt đến 100"
  },
  Task_138762_Desc = {
    Text = "Sau khi chịu đựng \"Bi Ca Vượt Trên Số Phận\", đánh bại \"Lưới Phản Bội\" Neferea."
  },
  Task_138762_Name = {
    Text = "Diễn Viên Chính Định Mệnh·Ẩn"
  },
  Task_139118_Desc = {
    Text = "Hoàn thành \"Kết Nối Đa Chiều - Hạt Giống Tình Yêu Bị Lãng Quên\""
  },
  Task_139119_Desc = {
    Text = "Hoàn thành tất cả các nhiệm vụ trên"
  },
  Task_139121_Desc = {
    Text = "Thức tỉnh 1000 lần"
  },
  Task_139123_Desc = {
    Text = "Thức tỉnh 250 lần"
  },
  Task_139124_Desc = {
    Text = "Đăng nhập 1 ngày"
  },
  Task_139125_Desc = {
    Text = "Hoàn thành \"Hành Động Điều Tra - Thiên Lãng Quên - Chương 4\" chế độ Thường"
  },
  Task_139126_Desc = {
    Text = "Thức tỉnh 500 lần"
  },
  Task_139127_Desc = {
    Text = "Thức tỉnh 100 lần"
  },
  Task_139600_Desc = {
    Text = "Tổng cộng bắt giữ 1000000 lần"
  },
  Task_139614_Desc = {
    Text = "Tổng cộng bắt giữ 500000 lần"
  },
  Task_139618_Desc = {
    Text = "Tích lũy bắt giữ 50 lần"
  },
  Task_139619_Desc = {
    Text = "Tổng cộng bắt giữ 1000000 lần"
  },
  Task_139626_Desc = {
    Text = "Tổng cộng bắt giữ 300000 lần"
  },
  Task_139629_Desc = {
    Text = "Tổng cộng bắt giữ 700000 lần"
  },
  Task_139646_Desc = {
    Text = "Hồ sơ bắt giữ trong trường"
  },
  Task_139649_Desc = {
    Text = "Tổng cộng bắt giữ 100000 lần"
  },
  Task_139651_Desc = {
    Text = "Kỷ lục bắt giữ cá nhân"
  },
  Task_139652_Desc = {
    Text = "Tổng cộng bắt giữ 100 lần"
  },
  Task_140087_Desc = {
    Text = "Hoàn thành \"Cự Vật\" 1 lần"
  },
  Task_140088_Desc = {
    Text = "Thông quan \"Triều Hắc Kim\" 1 lần"
  },
  Task_140089_Desc = {
    Text = "Hoàn thành \"Chống Bắt\" 10 lần"
  },
  Task_140090_Desc = {
    Text = "Hoàn thành \"Thu Lưới! Thu Lưới!\" 5 lần"
  },
  Task_140091_Desc = {
    Text = "Hoàn thành \"Đầy Tải Trở Về\" 5 lần"
  },
  Task_140092_Desc = {
    Text = "Hoàn thành \"Chống Bắt\" 1 lần"
  },
  Task_140093_Desc = {
    Text = "Hoàn thành \"Cự Vật\" 10 lần"
  },
  Task_140094_Desc = {
    Text = "Hoàn thành \"Thùng Bạc Đầu Tiên\" 5 lần"
  },
  Task_140095_Desc = {
    Text = "Thông quan \"Triều Hắc Kim\" 5 lần"
  },
  Task_140096_Desc = {
    Text = "Hoàn thành \"Thùng Bạc Đầu Tiên\" 1 lần"
  },
  Task_140097_Desc = {
    Text = "Hoàn thành \"Đầy Tải Trở Về\" 10 lần"
  },
  Task_140098_Desc = {
    Text = "Hoàn thành \"Chống Bắt\" 5 lần"
  },
  Task_140099_Desc = {
    Text = "Hoàn thành \"Cự Vật\" 5 lần"
  },
  Task_140100_Desc = {
    Text = "Hoàn thành \"Đầy Tải Trở Về\" 1 lần"
  },
  Task_140101_Desc = {
    Text = "Hoàn thành \"Thu Lưới! Thu Lưới!\" 10 lần"
  },
  Task_140102_Desc = {
    Text = "Hoàn thành \"Thêm Lần Nữa\" 1 lần"
  },
  Task_140103_Desc = {
    Text = "Hoàn thành \"Thêm Lần Nữa\" 10 lần"
  },
  Task_140104_Desc = {
    Text = "Hoàn thành \"Thùng Bạc Đầu Tiên\" 10 lần"
  },
  Task_140105_Desc = {
    Text = "Hoàn thành \"Thu Lưới! Thu Lưới!\" 1 lần"
  },
  Task_140106_Desc = {
    Text = "Hoàn thành \"Cơn Sốt Vàng Đen\" 10 lần"
  },
  Task_140107_Desc = {
    Text = "Hoàn thành \"Thêm Lần Nữa\" 5 lần"
  },
  Task_140114_Desc = {
    Text = "Hoàn thành \"Kết Nối Đa Chiều - Hạt Giống Tình Yêu Bị Lãng Quên\""
  },
  Task_140115_Desc = {
    Text = "Hoàn thành tất cả các nhiệm vụ trên"
  },
  Task_140116_Desc = {
    Text = "Đăng nhập 1 ngày"
  },
  Task_140117_Desc = {
    Text = "Hoàn thành \"Hành Động Điều Tra - Thiên Lãng Quên - Chương 4\" chế độ Thường"
  },
  Task_140189_Desc = {
    Text = "Tích lũy khai thác 5000 bạc nguyên thủy"
  },
  Task_140190_Desc = {
    Text = "Tích lũy khai thác 20000 bạc nguyên thủy"
  },
  Task_140191_Desc = {
    Text = "Đã chiết xuất 10000 nguồn lỏng"
  },
  Task_140192_Desc = {
    Text = "Đã trích xuất tổng cộng 30000 nguồn lỏng"
  },
  Task_140306_Desc = {
    Text = "Hoàn thành Kết Nối Đa Chiều \"Hạt Giống Tình Yêu Bị Lãng Quên\" ở độ khó Khó"
  },
  Task_140306_Name = {
    Text = "Nơi trở về của kẻ lưu lạc·khó khăn"
  },
  Task_140307_Desc = {
    Text = "Hoàn thành Kết Nối Đa Chiều \"Hạt Giống Tình Yêu Bị Lãng Quên\""
  },
  Task_140307_Name = {
    Text = "Nơi trở về của kẻ lưu lạc"
  },
  Task_140463_Desc = {
    Text = "Tích lũy đánh ra 200 lá bài"
  },
  Task_140464_Desc = {
    Text = "Hoàn thành 20 lần phái đi"
  },
  Task_140465_Desc = {
    Text = "Đăng nhập tích lũy 1 ngày"
  },
  Task_140466_Desc = {
    Text = "\"Ion Hoạt Tính Tinh Túy\"đạt 1000"
  },
  Task_140467_Desc = {
    Text = "Hoàn thành tất cả các nhiệm vụ trên"
  },
  Task_140468_Desc = {
    Text = "Hoàn thành nhiệm vụ mùa bất kỳ trong \"Thử Thách Cấm Kỵ\""
  },
  Task_141311_Desc = {
    Text = "Hoàn thành duy thức tiềm hành \"Epojans Vĩnh Cửu\""
  },
  Task_141312_Desc = {
    Text = "Tỷ lệ đồng điều của Pontos đạt cấp 10"
  },
  Task_141313_Desc = {
    Text = "Sử dụng Thể thức tỉnh trong siêu chiều cõi giành chiến thắng 1 lần trong \"Săn Mồi Từ Trên Cao\""
  },
  Task_141314_Desc = {
    Text = "Hoàn thành \"Luật Rừng\" ở độ khó điên cuồng"
  },
  Task_141315_Desc = {
    Text = "Hoàn thành \"Bia Và Gia Vị\" ở bất kỳ độ khó nào"
  },
  Task_141316_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_141317_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_141318_Desc = {
    Text = "Hoàn thành \"Thú Nhận\" ở bất kỳ độ khó nào"
  },
  Task_141319_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_141320_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_141321_Desc = {
    Text = "Sử dụng Thể thức tỉnh Cõi thịt máu giành chiến thắng 2 lần trong \"Săn Mồi Từ Trên Cao\""
  },
  Task_141322_Desc = {
    Text = "Sử dụng Thể thức tỉnh từ cõi hỗn mang giành chiến thắng 2 lần trong \"Săn Mồi Từ Trên Cao\""
  },
  Task_141323_Desc = {
    Text = "Sử dụng Thể thức tỉnh Hải Vực giành chiến thắng 1 lần trong \"Săn Mồi Từ Trên Cao\""
  },
  Task_141324_Desc = {
    Text = "Săn Mồi Từ Trên Cao·Cõi"
  },
  Task_141325_Desc = {
    Text = "Hoàn thành \"Tiếng Còi\" ở độ khó điên cuồng"
  },
  Task_141326_Desc = {
    Text = "Hoàn thành \"Trò Chơi Đuổi Bắt\" ở bất kỳ độ khó nào"
  },
  Task_141327_Desc = {
    Text = "Hoàn thành \"Bia Và Gia Vị\" ở bất kỳ độ khó nào"
  },
  Task_141328_Desc = {
    Text = "Hoàn thành \"Luật Rừng\" ở bất kỳ độ khó nào"
  },
  Task_141329_Desc = {
    Text = "Săn Mồi Từ Trên Cao·Điên rồ"
  },
  Task_141330_Desc = {
    Text = "Hoàn thành \"Nhị Nguyên Luận\" ở độ khó điên cuồng"
  },
  Task_141331_Desc = {
    Text = "Hoàn thành \"Luật Rừng\" ở bất kỳ độ khó nào"
  },
  Task_141332_Desc = {
    Text = "Hoàn thành \"Bia Và Gia Vị\" ở độ khó điên cuồng"
  },
  Task_141333_Desc = {
    Text = "Hoàn thành \"Thú Nhận\" ở độ khó điên cuồng"
  },
  Task_141335_Desc = {
    Text = "Hoàn thành \"Sụn Sườn\" ở bất kỳ độ khó nào"
  },
  Task_141336_Desc = {
    Text = "Hoàn thành \"Nhị Nguyên Luận\" ở bất kỳ độ khó nào"
  },
  Task_141337_Desc = {
    Text = "Hoàn thành tất cả thành tựu \"Săn Mồi Từ Trên Cao·Hoàn thành\""
  },
  Task_141338_Desc = {
    Text = "Nhận khởi linh 6 khi có Pontos"
  },
  Task_141338_Name = {
    Text = "Nhận khởi linh 6 khi có Pontos"
  },
  Task_141338_UnlockCondDesc = {
    Text = "Sự kiện@Thể thức tỉnh Pontos gói khởi linh 2 sự kiện"
  },
  Task_141339_Desc = {
    Text = "Hoàn thành \"Sụn Sườn\" ở bất kỳ độ khó nào"
  },
  Task_141340_Desc = {
    Text = "Hoàn thành \"Nhị Nguyên Luận\" ở bất kỳ độ khó nào"
  },
  Task_141341_Desc = {
    Text = "Săn Mồi Từ Trên Cao·Hoàn thành"
  },
  Task_141342_Desc = {
    Text = "Sử dụng Thể thức tỉnh Hải Vực giành chiến thắng 2 lần trong \"Săn Mồi Từ Trên Cao\""
  },
  Task_141343_Desc = {
    Text = "Hoàn thành \"Tiếng Còi\" ở bất kỳ độ khó nào"
  },
  Task_141344_Desc = {
    Text = "Hoàn thành \"Thú Nhận\" ở bất kỳ độ khó nào"
  },
  Task_141345_Desc = {
    Text = "Sử dụng Thể thức tỉnh trong siêu chiều cõi giành chiến thắng 2 lần trong \"Săn Mồi Từ Trên Cao\""
  },
  Task_141346_Desc = {
    Text = "Sử dụng Thể thức tỉnh từ cõi hỗn mang giành chiến thắng 1 lần trong \"Săn Mồi Từ Trên Cao\""
  },
  Task_141347_Desc = {
    Text = "Hoàn thành \"Trò Chơi Đuổi Bắt\" ở độ khó điên cuồng"
  },
  Task_141348_Desc = {
    Text = "Hoàn thành \"Tiếng Còi\" ở bất kỳ độ khó nào"
  },
  Task_141349_Desc = {
    Text = "Sử dụng Thể thức tỉnh Cõi thịt máu giành chiến thắng 1 lần trong \"Săn Mồi Từ Trên Cao\""
  },
  Task_141350_Desc = {
    Text = "Pontos đạt Phát triển nhân cách 12"
  },
  Task_141351_Desc = {
    Text = "Nhận khởi linh 2 khi có Pontos"
  },
  Task_141351_Name = {
    Text = "Nhận khởi linh 2 khi có Pontos"
  },
  Task_141351_UnlockCondDesc = {
    Text = "Sự kiện@Thể thức tỉnh Pontos gói khởi linh 2 sự kiện"
  },
  Task_141352_Desc = {
    Text = "Hoàn thành \"Trò Chơi Đuổi Bắt\" ở bất kỳ độ khó nào"
  },
  Task_141353_Desc = {
    Text = "Hoàn thành \"Sụn Sườn\" ở độ khó điên cuồng"
  },
  Task_141511_Desc = {
    Text = "Tích lũy đánh ra 300 lá bài"
  },
  Task_141512_Desc = {
    Text = "Hoàn thành nhiệm vụ mùa bất kỳ trong \"Thử Thách Cấm Kỵ\""
  },
  Task_141513_Desc = {
    Text = "Sử dụng hỗ trợ 3 lần"
  },
  Task_141514_Desc = {
    Text = "Hoàn thành 15 lần phái cử"
  },
  Task_141515_Desc = {
    Text = "Đăng nhập tổng cộng 1 ngày"
  },
  Task_141516_Desc = {
    Text = "Đăng nhập tổng cộng 1 ngày"
  },
  Task_141517_Desc = {
    Text = "Thức tỉnh 30 lần"
  },
  Task_141518_Desc = {
    Text = "Hoàn thành nhiệm vụ mùa bất kỳ trong \"Thử Thách Cấm Kỵ\""
  },
  Task_141519_Desc = {
    Text = "Sử dụng hỗ trợ 3 lần"
  },
  Task_141520_Desc = {
    Text = "\"Ion Hoạt Tính Tinh Túy\"đạt 1000"
  },
  Task_141521_Desc = {
    Text = "Giá trị luyện tập ở khu vực d-khu vực đạt đến 100"
  },
  Task_141522_Desc = {
    Text = "Tích lũy đánh ra 300 lá bài"
  },
  Task_141523_Desc = {
    Text = "Giá trị luyện tập ở khu vực d-khu vực đạt đến 100"
  },
  Task_141524_Desc = {
    Text = "Thức tỉnh 30 lần"
  },
  Task_141525_Desc = {
    Text = "\"Ion Hoạt Tính Tinh Túy\"đạt 1000"
  },
  Task_141526_Desc = {
    Text = "Hoàn thành 15 lần phái cử"
  },
  Task_141799_Desc = {
    Text = "Sử dụng Thể thức tỉnh Hải Vực để giành chiến thắng 2 lần trong \"Bảo Vật của Umapati\""
  },
  Task_141800_Desc = {
    Text = "Sử dụng Thể thức tỉnh trong siêu chiều cõi để giành chiến thắng 2 lần trong \"Bảo Vật của Umapati\""
  },
  Task_141801_Desc = {
    Text = "Hoàn thành \"Sợi Chỉ\" ở bất kỳ độ khó nào"
  },
  Task_141802_Desc = {
    Text = "Sử dụng Thể thức tỉnh Cõi thịt máu để giành chiến thắng 2 lần trong \"Bảo Vật của Umapati\""
  },
  Task_141803_Desc = {
    Text = "Hoàn thành tất cả thành tích \"Bảo Vật của Umapati·Hoàn thành\""
  },
  Task_141804_Desc = {
    Text = "Sử dụng Thể thức tỉnh từ cõi hỗn mang để giành chiến thắng 1 lần trong \"Bảo Vật của Umapati\""
  },
  Task_141805_Desc = {
    Text = "Hoàn thành \"Táo\" ở bất kỳ độ khó nào"
  },
  Task_141806_Desc = {
    Text = "Hoàn thành \"gương\"ở bất kỳ độ khó nào"
  },
  Task_141807_Desc = {
    Text = "Hoàn thành \"Chìa Khóa\" ở bất kỳ độ khó nào"
  },
  Task_141808_Desc = {
    Text = "Hoàn thành \"Gương\"độ khó điên cuồng"
  },
  Task_141809_Desc = {
    Text = "Hoàn thành \"Vương Miện\" ở độ khó điên cuồng"
  },
  Task_141810_Desc = {
    Text = "Hoàn thành \"Lông Vũ\" ở bất kỳ độ khó nào"
  },
  Task_141811_Desc = {
    Text = "Hoàn thành \"Đôi Mắt\" ở bất kỳ độ khó nào"
  },
  Task_141812_Desc = {
    Text = "Hoàn thành \"Sợi Chỉ\" ở độ khó điên cuồng"
  },
  Task_141813_Desc = {
    Text = "Hoàn thành \"Táo\" ở độ khó điên cuồng"
  },
  Task_141814_Desc = {
    Text = "Hoàn thành \"Vương Miện\" ở bất kỳ độ khó nào"
  },
  Task_141815_Desc = {
    Text = "Sử dụng Thể thức tỉnh Cõi thịt máu để giành chiến thắng 1 lần trong \"Bảo Vật của Umapati\""
  },
  Task_141816_Desc = {
    Text = "Hoàn thành \"gương\"ở bất kỳ độ khó nào"
  },
  Task_141817_Desc = {
    Text = "Hoàn thành \"Lông Vũ\" ở độ khó điên cuồng"
  },
  Task_141818_Desc = {
    Text = "Hoàn thành \"Lông Vũ\" ở bất kỳ độ khó nào"
  },
  Task_141819_Desc = {
    Text = "Bảo Vật của Umapati·Điên rồ"
  },
  Task_141820_Desc = {
    Text = "Bảo Vật của Umapati·Cõi"
  },
  Task_141821_Desc = {
    Text = "Hoàn thành \"Đôi Mắt\" ở bất kỳ độ khó nào"
  },
  Task_141822_Desc = {
    Text = "Hoàn thành \"Sợi Chỉ\" ở bất kỳ độ khó nào"
  },
  Task_141823_Desc = {
    Text = "Hoàn thành \"Chìa Khóa\" ở bất kỳ độ khó nào"
  },
  Task_141824_Desc = {
    Text = "Bảo Vật của Umapati·Hoàn thành"
  },
  Task_141825_Desc = {
    Text = "Hoàn thành \"Táo\" ở bất kỳ độ khó nào"
  },
  Task_141826_Desc = {
    Text = "Sử dụng Thể thức tỉnh trong siêu chiều cõi để giành chiến thắng 1 lần trong \"Bảo Vật của Umapati\""
  },
  Task_141827_Desc = {
    Text = "Sử dụng Thể thức tỉnh Hải Vực để giành chiến thắng 1 lần trong \"Bảo Vật của Umapati\""
  },
  Task_141828_Desc = {
    Text = "Hoàn thành \"Đôi Mắt\" ở độ khó điên cuồng"
  },
  Task_141829_Desc = {
    Text = "Sử dụng Thể thức tỉnh từ cõi hỗn mang để giành chiến thắng 2 lần trong \"Bảo Vật của Umapati\""
  },
  Task_141830_Desc = {
    Text = "Hoàn thành \"Chìa Khóa\" ở độ khó điên cuồng"
  },
  Task_141831_Desc = {
    Text = "Hoàn thành \"Vương Miện\" ở bất kỳ độ khó nào"
  },
  Task_141899_Desc = {
    Text = "Liên kết số điện thoại hoặc email trong \"Trung tâm người dùng - Hoàn thiện thông tin\""
  },
  Task_143320_Desc = {
    Text = "Hoàn thành duy thức tiềm hành \"Epojans Vĩnh Cửu\" ở độ khó khăn"
  },
  Task_143320_Name = {
    Text = "Đêm Hè Mát Mẻ·Khó Khăn"
  },
  Task_143321_Desc = {
    Text = "Hoàn thành duy thức tiềm hành \"Epojans Vĩnh Cửu\""
  },
  Task_143321_Name = {
    Text = "Đêm Hè Mát Mẻ"
  },
  Task_143588_Desc = {
    Text = "Epoyanth trong vòng tay anh……"
  },
  Task_143588_Name = {
    Text = "Epoyanth trong vòng tay anh……"
  },
  Task_143589_Desc = {
    Text = "Ở lại……"
  },
  Task_143589_Name = {
    Text = "Ở lại……"
  },
  Task_143590_Desc = {
    Text = "Ở lại Epoyanth"
  },
  Task_143590_Name = {
    Text = "Ở lại Epoyanth"
  },
  Task_144311_Desc = {
    Text = "Khi ra trận với 1/2/3/4 Thể thức tỉnh đã được tăng cường, nhận được 250 / 500 750 / 1000 điểm. (Hiện tại ra trận: {s1})"
  },
  Task_144311_Name = {
    Text = "Vực Thẳm Gọi<size=20><color=#747474>Khi ra trận với 1/2/3/4 Thể thức tỉnh đã tăng cường, nhận được 250 / 500 / 750 / 1000 điểm </color></size>"
  },
  Task_144312_Desc = {
    Text = "Hoàn thành việc lang thang ý thức \"Văn bản Tạm Thời\""
  },
  Task_144313_Desc = {
    Text = "Tân sinh đảo ngược·Thông quan"
  },
  Task_144314_Desc = {
    Text = "Hoàn thành \"Tổn thương não\" ở độ khó điên cuồng"
  },
  Task_144315_Desc = {
    Text = "Sử dụng Thể Thức Tỉnh Giới Vực Thâm Hải giành chiến thắng 1 lần trong \"Tân Sinh Đảo Ngược\""
  },
  Task_144316_Desc = {
    Text = "Hoàn thành \"Chén rượu cuối cùng\" ở độ khó điên cuồng"
  },
  Task_144317_Desc = {
    Text = "Hoàn thành \"Chén rượu cuối cùng\" ở bất kỳ độ khó nào"
  },
  Task_144318_Desc = {
    Text = "Tân sinh đảo ngược·Giới vực"
  },
  Task_144319_Desc = {
    Text = "Thông quan \"Bệnh viện\"ở bất kỳ độ khó nào"
  },
  Task_144320_Desc = {
    Text = "Sử dụng Thể Thức Tỉnh Giới Vực Thâm Hải giành chiến thắng 2 lần trong \"Tân Sinh Đảo Ngược\""
  },
  Task_144321_Desc = {
    Text = "Hoàn thành \"Bàn ăn\" ở bất kỳ độ khó nào"
  },
  Task_144322_Desc = {
    Text = "Hoàn thành \"Bàn ăn\" ở độ khó điên cuồng"
  },
  Task_144323_Desc = {
    Text = "Thông quan \"Nhà\"ở bất kỳ độ khó nào"
  },
  Task_144324_Desc = {
    Text = "Sử dụng Thể Thức Tỉnh Giới Vực Siêu Chiều giành chiến thắng 1 lần trong \"Tân Sinh Đảo Ngược\""
  },
  Task_144325_Desc = {
    Text = "Hoàn thành \"Giếng nước\" ở bất kỳ độ khó nào"
  },
  Task_144326_Desc = {
    Text = "Thông quan \"Nhà\"ở bất kỳ độ khó nào"
  },
  Task_144327_Desc = {
    Text = "Sử dụng Thể Thức Tỉnh Giới Vực Hỗn Loạn giành chiến thắng 2 lần trong \"Tân Sinh Đảo Ngược\""
  },
  Task_144328_Desc = {
    Text = "Thông quan \"Bệnh viện\"ở bất kỳ độ khó nào"
  },
  Task_144329_Desc = {
    Text = "Hoàn thành \"Giếng nước\" ở bất kỳ độ khó nào"
  },
  Task_144330_Desc = {
    Text = "Hoàn thành \"Trường học\" ở bất kỳ độ khó nào"
  },
  Task_144331_Desc = {
    Text = "Hoàn thành \"Tổn thương não\" ở bất kỳ độ khó nào"
  },
  Task_144332_Desc = {
    Text = "Hoàn thành tất cả thành tựu \"Tân Sinh Đảo Ngược · Thông Quan\""
  },
  Task_144333_Desc = {
    Text = "Hoàn thành \"Bàn ăn\" ở bất kỳ độ khó nào"
  },
  Task_144334_Desc = {
    Text = "Hoàn thành \"Trường học\" ở độ khó điên cuồng"
  },
  Task_144335_Desc = {
    Text = "Thông quan \"Nhà\"độ khó Điên Cuồng"
  },
  Task_144336_Desc = {
    Text = "Sử dụng Thể Thức Tỉnh Giới Vực Huyết Nhục giành chiến thắng 1 lần trong \"Tân Sinh Đảo Ngược\""
  },
  Task_144337_Desc = {
    Text = "Hoàn thành \"Tổn thương não\" ở bất kỳ độ khó nào"
  },
  Task_144338_Desc = {
    Text = "Hoàn thành \"Trường học\" ở bất kỳ độ khó nào"
  },
  Task_144339_Desc = {
    Text = "Hoàn thành \"Chén rượu cuối cùng\" ở bất kỳ độ khó nào"
  },
  Task_144340_Desc = {
    Text = "Sử dụng Thể Thức Tỉnh Giới Vực Huyết Nhục giành chiến thắng 2 lần trong \"Tân Sinh Đảo Ngược\""
  },
  Task_144341_Desc = {
    Text = "Sử dụng Thể Thức Tỉnh Giới Vực Hỗn Loạn giành chiến thắng 1 lần trong \"Tân Sinh Đảo Ngược\""
  },
  Task_144342_Desc = {
    Text = "Sử dụng Thể Thức Tỉnh Giới Vực Siêu Chiều giành chiến thắng 2 lần trong \"Tân Sinh Đảo Ngược\""
  },
  Task_144343_Desc = {
    Text = "Tân sinh đảo ngược·Điên cuồng"
  },
  Task_144344_Desc = {
    Text = "Hoàn thành \"Giếng nước\" ở độ khó điên cuồng"
  },
  Task_144345_Desc = {
    Text = "Thông quan \"Bệnh Viện\"độ khó Điên Cuồng"
  },
  Task_144360_Desc = {
    Text = "Tích lũy đánh ra 300 lá bài"
  },
  Task_144361_Desc = {
    Text = "Hoàn thành nhiệm vụ mùa bất kỳ trong \"Thử Thách Cấm Kỵ\""
  },
  Task_144362_Desc = {
    Text = "Giá trị luyện tập ở khu vực d-khu vực đạt đến 100"
  },
  Task_144363_Desc = {
    Text = "Hoàn thành 15 lần phái cử"
  },
  Task_144364_Desc = {
    Text = "\"Ion Hoạt Tính Tinh Túy\"đạt 1000"
  },
  Task_144365_Desc = {
    Text = "Thức tỉnh 30 lần"
  },
  Task_144366_Desc = {
    Text = "Giá trị luyện tập ở khu vực d-khu vực đạt đến 100"
  },
  Task_144367_Desc = {
    Text = "Đăng nhập tổng cộng 1 ngày"
  },
  Task_144368_Desc = {
    Text = "Hoàn thành nhiệm vụ mùa bất kỳ trong \"Thử Thách Cấm Kỵ\""
  },
  Task_144369_Desc = {
    Text = "Hoàn thành 15 lần phái cử"
  },
  Task_144370_Desc = {
    Text = "Tích lũy đánh ra 300 lá bài"
  },
  Task_144371_Desc = {
    Text = "\"Ion Hoạt Tính Tinh Túy\"đạt 1000"
  },
  Task_144372_Desc = {
    Text = "Thức tỉnh 30 lần"
  },
  Task_144373_Desc = {
    Text = "Sử dụng hỗ trợ 3 lần"
  },
  Task_144374_Desc = {
    Text = "Sử dụng hỗ trợ 3 lần"
  },
  Task_144375_Desc = {
    Text = "Đăng nhập tổng cộng 1 ngày"
  },
  Task_145388_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_145389_Desc = {
    Text = "Sử dụng Thể thức tỉnh Hải Vực giành chiến thắng 2 lần trong \"Cuộc Tranh Đấu Tham Tàn\""
  },
  Task_145390_Desc = {
    Text = "Hoàn thành \"Triều Cống\" ở bất kỳ độ khó nào"
  },
  Task_145392_Desc = {
    Text = "Cuộc Tranh Đoạt Tàn Sát·Hoàn thành"
  },
  Task_145393_Desc = {
    Text = "Hoàn thành \"Điện Đường Sát Thương\" ở độ khó điên cuồng"
  },
  Task_145394_Desc = {
    Text = "Hoàn thành \"Vương Miện Quyền Vọng\" ở bất kỳ độ khó nào"
  },
  Task_145395_Desc = {
    Text = "Hoàn thành duy thức tiềm hành \"Cho Đến Khi Kình Thiên Vẫn Lạc\""
  },
  Task_145396_Desc = {
    Text = "Nhận khởi linh 6 khi sở hữu Lotan: Ngư Thần"
  },
  Task_145396_Name = {
    Text = "Nhận khởi linh 6 khi sở hữu Lotan: Ngư Thần"
  },
  Task_145396_UnlockCondDesc = {
    Text = "Sự kiện@Gói khởi linh Thể thức tỉnh Lotan: Ngư Thần 2"
  },
  Task_145397_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_145398_Desc = {
    Text = "Tỷ lệ đồng điều của Lotan: Ngư Thần đạt cấp 10"
  },
  Task_145399_Desc = {
    Text = "Cuộc Tranh Đoạt Tàn Sát·Cõi"
  },
  Task_145400_Desc = {
    Text = "Hoàn thành \"Mãnh Thú Bị Vây\" ở bất kỳ độ khó nào"
  },
  Task_145401_Desc = {
    Text = "Hoàn thành \"Điện Đường Sát Thương\" ở bất kỳ độ khó nào"
  },
  Task_145402_Desc = {
    Text = "Hoàn thành \"Mãnh Thú Bị Vây\" ở bất kỳ độ khó nào"
  },
  Task_145403_Desc = {
    Text = "Hoàn thành \"Mãnh Thú Bị Vây\" ở độ khó điên cuồng"
  },
  Task_145404_Desc = {
    Text = "Sử dụng Thể thức tỉnh trong siêu chiều cõi giành chiến thắng 1 lần trong \"Cuộc Tranh Đấu Tham Tàn\""
  },
  Task_145405_Desc = {
    Text = "Sử dụng Thể thức tỉnh từ cõi hỗn mang giành chiến thắng 2 lần trong \"Cuộc Tranh Đấu Tham Tàn\""
  },
  Task_145406_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_145408_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_145409_Desc = {
    Text = "Hoàn thành \"Vương Miện Quyền Vọng\" ở bất kỳ độ khó nào"
  },
  Task_145410_Desc = {
    Text = "Hoàn thành tất cả Thành Tựu \"Cuộc Tranh Đấu Tham Tàn·Hoàn thành\""
  },
  Task_145411_Desc = {
    Text = "Sử dụng Thể thức tỉnh Cõi thịt máu giành chiến thắng 1 lần trong \"Cuộc Tranh Đấu Tham Tàn\""
  },
  Task_145412_Desc = {
    Text = "Sử dụng Thể thức tỉnh Cõi thịt máu giành chiến thắng 2 lần trong \"Cuộc Tranh Đấu Tham Tàn\""
  },
  Task_145413_Desc = {
    Text = "Hoàn thành \"Triều Cống\" ở bất kỳ độ khó nào"
  },
  Task_145414_Desc = {
    Text = "Nhận khởi linh 2 khi sở hữu Lotan: Ngư Thần"
  },
  Task_145414_Name = {
    Text = "Nhận khởi linh 2 khi sở hữu Lotan: Ngư Thần"
  },
  Task_145414_UnlockCondDesc = {
    Text = "Sự kiện@Gói khởi linh Thể thức tỉnh Lotan: Ngư Thần 2"
  },
  Task_145415_Desc = {
    Text = "Sử dụng Thể thức tỉnh từ cõi hỗn mang giành chiến thắng 1 lần trong \"Cuộc Tranh Đấu Tham Tàn\""
  },
  Task_145416_Desc = {
    Text = "Sử dụng Thể thức tỉnh trong siêu chiều cõi giành chiến thắng 2 lần trong \"Cuộc Tranh Đấu Tham Tàn\""
  },
  Task_145417_Desc = {
    Text = "Hoàn thành \"Triều Cống\" ở độ khó điên cuồng"
  },
  Task_145418_Desc = {
    Text = "Cuộc Tranh Đoạt Tàn Sát·Điên loạn"
  },
  Task_145419_Desc = {
    Text = "Hoàn thành \"Gương Vô Nhân\" ở độ khó điên cuồng"
  },
  Task_145420_Desc = {
    Text = "Hoàn thành \"Gương Vô Nhân\" ở bất kỳ độ khó nào"
  },
  Task_145421_Desc = {
    Text = "Hoàn thành \"Vương Miện Quyền Vọng\" ở độ khó điên cuồng"
  },
  Task_145423_Desc = {
    Text = "Sử dụng Thể thức tỉnh Hải Vực giành chiến thắng 1 lần trong \"Cuộc Tranh Đấu Tham Tàn\""
  },
  Task_145424_Desc = {
    Text = "Hoàn thành \"Gương Vô Nhân\" ở bất kỳ độ khó nào"
  },
  Task_145425_Desc = {
    Text = "Lotan: Ngư Thần đạt Phát triển nhân cách 12"
  },
  Task_145426_Desc = {
    Text = "Hoàn thành \"Điện Đường Sát Thương\" ở bất kỳ độ khó nào"
  },
  Task_145479_Desc = {
    Text = "Hoàn thành duy thức tiềm hành \"Cho Đến Khi Kình Thiên Vẫn Lạc\""
  },
  Task_145479_Name = {
    Text = "Ta Chính Là Bão Tố"
  },
  Task_145576_Desc = {
    Text = "Văn bản Tạm thời · Đặc Quyền Có Thời Hạn"
  },
  Task_145578_Desc = {
    Text = "Vạn Nguyện Mô Phỏng·Độc quyền giới hạn thời gian"
  },
  Task_146542_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_146543_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_146544_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_146545_Desc = {
    Text = "Hoàn thành Bài sao chương 6 6-9"
  },
  Task_146546_Desc = {
    Text = "Hoàn thành Bài sao chương 6 \"Đại Tiệc Trên Núi Tuyết\" độ khó khó khăn"
  },
  Task_146547_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_146548_Desc = {
    Text = "Hoàn thành Bài sao chương 6 \"Đại Tiệc Trên Núi Tuyết\" độ khó khó khăn"
  },
  Task_146549_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_146550_Desc = {
    Text = "Hoàn thành Bài sao chương 6 6-9"
  },
  Task_146552_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_146553_Desc = {
    Text = "Hoàn thành Bài sao chương 6 \"Đại Tiệc Trên Núi Tuyết\""
  },
  Task_146554_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_146555_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_146556_Desc = {
    Text = "Hoàn thành Bài sao Chương 6 6-5 độ khó khăn"
  },
  Task_146557_Desc = {
    Text = "Hoàn thành Bài sao Chương 6 6-5 độ khó khăn"
  },
  Task_146558_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_146559_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_146560_Desc = {
    Text = "Hoàn thành Bài sao chương 6 \"Đại Tiệc Trên Núi Tuyết\""
  },
  Task_146801_Desc = {
    Text = "Sử dụng người đánh thức vùng biển sâu trong \"Văn bản tạm thời\" để thắng 1 lầ"
  },
  Task_146802_Desc = {
    Text = "Hoàn thành \"văn bản tạm thời\" bất kỳ độ khó nào"
  },
  Task_146803_Desc = {
    Text = "Đánh bại độ khó điên loạn \"Văn bản tạm thời\""
  },
  Task_146804_Desc = {
    Text = "Hoàn thành \"văn bản tạm thời\" bất kỳ độ khó nào"
  },
  Task_146805_Desc = {
    Text = "Sử dụng người đánh thức vùng máu thịt trong \"Văn bản tạm thời\" để thắng 2 lầ"
  },
  Task_146806_Desc = {
    Text = "Hoàn thành \"văn bản tạm thời\" bất kỳ độ khó nào"
  },
  Task_146807_Desc = {
    Text = "Hoàn thành \"văn bản tạm thời\" bất kỳ độ khó nào"
  },
  Task_146808_Desc = {
    Text = "Hoàn thành duy thức tiềm hành \"Ngũ Nhật Đàm\""
  },
  Task_146809_Desc = {
    Text = "Hoàn thành \"văn bản tạm thời\" bất kỳ độ khó nào"
  },
  Task_146810_Desc = {
    Text = "Sử dụng người đánh thức vùng biển sâu trong \"Văn bản tạm thời\" để thắng 2 lầ"
  },
  Task_146811_Desc = {
    Text = "Hoàn thành \"văn bản tạm thời\" bất kỳ độ khó nào"
  },
  Task_146812_Desc = {
    Text = "Hoàn thành \"văn bản tạm thời\" bất kỳ độ khó nào"
  },
  Task_146813_Desc = {
    Text = "Hoàn thành \"văn bản tạm thời\" bất kỳ độ khó nào"
  },
  Task_146814_Desc = {
    Text = "Hoàn thành \"văn bản tạm thời\" bất kỳ độ khó nào"
  },
  Task_146815_Desc = {
    Text = "Sử dụng người đánh thức vùng hỗn loạn trong \"Văn bản tạm thời\" để thắng 1 lầ"
  },
  Task_146816_Desc = {
    Text = "Sử dụng người đánh thức vùng siêu cấp trong \"Văn bản tạm thời\" để thắng 1 lầ"
  },
  Task_146817_Desc = {
    Text = "Văn bản tạm·hoàn thành"
  },
  Task_146818_Desc = {
    Text = "Hoàn thành \"văn bản tạm thời\" bất kỳ độ khó nào"
  },
  Task_146819_Desc = {
    Text = "Hoàn thành \"văn bản tạm thời\" bất kỳ độ khó nào"
  },
  Task_146820_Desc = {
    Text = "Hoàn thành \"văn bản tạm thời\" bất kỳ độ khó nào"
  },
  Task_146821_Desc = {
    Text = "Đánh bại độ khó điên loạn \"Văn bản tạm thời\""
  },
  Task_146822_Desc = {
    Text = "Đánh bại độ khó điên loạn \"Văn bản tạm thời\""
  },
  Task_146823_Desc = {
    Text = "Văn bản tạm thời·giới vực"
  },
  Task_146824_Desc = {
    Text = "Đánh bại độ khó điên loạn \"Văn bản tạm thời\""
  },
  Task_146825_Desc = {
    Text = "Đánh bại độ khó điên loạn \"Văn bản tạm thời\""
  },
  Task_146826_Desc = {
    Text = "Hoàn thành \"văn bản tạm thời\" bất kỳ độ khó nào"
  },
  Task_146827_Desc = {
    Text = "Hoàn thành \"văn bản tạm thời\" bất kỳ độ khó nào"
  },
  Task_146828_Desc = {
    Text = "Đánh bại độ khó điên loạn \"Văn bản tạm thời\""
  },
  Task_146829_Desc = {
    Text = "Sử dụng người đánh thức vùng hỗn loạn trong \"Văn bản tạm thời\" để thắng 2 lầ"
  },
  Task_146830_Desc = {
    Text = "Đánh bại độ khó điên loạn \"Văn bản tạm thời\""
  },
  Task_146831_Desc = {
    Text = "Sử dụng người đánh thức vùng siêu cấp trong \"Văn bản tạm thời\" để thắng 2 lầ"
  },
  Task_146832_Desc = {
    Text = "Hoàn thành \"văn bản tạm thời\" bất kỳ độ khó nào"
  },
  Task_146833_Desc = {
    Text = "Sử dụng người đánh thức vùng máu thịt trong \"Văn bản tạm thời\" để thắng 1 lầ"
  },
  Task_146834_Desc = {
    Text = "Hoàn thành \"văn bản tạm thời\" bất kỳ độ khó nào"
  },
  Task_146835_Desc = {
    Text = "Bản nháp·điên cuồng"
  },
  Task_146836_Desc = {
    Text = "Hoàn thành tất cả thành tựu \"Văn bản tạm thời·Thông qua\""
  },
  Task_146837_Desc = {
    Text = "Đánh bại độ khó điên loạn \"Văn bản tạm thời\""
  },
  Task_146838_Desc = {
    Text = "Đánh bại độ khó điên loạn \"Văn bản tạm thời\""
  },
  Task_146839_Desc = {
    Text = "Hoàn thành \"văn bản tạm thời\" bất kỳ độ khó nào"
  },
  Task_146840_Desc = {
    Text = "Hoàn thành \"văn bản tạm thời\" bất kỳ độ khó nào"
  },
  Task_147442_Desc = {
    Text = "Sử dụng người đánh thức vùng máu thịt trong \"Văn bản tạm thời\" để thắng 2 lầ"
  },
  Task_147443_Desc = {
    Text = "Mộ Tinh·Tincture đạt tỷ lệ đồng điều cấp 10"
  },
  Task_147444_Desc = {
    Text = "Sử dụng người đánh thức vùng biển sâu trong \"Văn bản tạm thời\" để thắng 1 lầ"
  },
  Task_147450_Desc = {
    Text = "Hoàn thành việc lang thang ý thức \"Văn bản Tạm Thời\""
  },
  Task_147451_Desc = {
    Text = "Sử dụng người đánh thức vùng siêu cấp trong \"Văn bản tạm thời\" để thắng 1 lầ"
  },
  Task_147452_Desc = {
    Text = "Sử dụng người đánh thức vùng hỗn loạn trong \"Văn bản tạm thời\" để thắng 1 lầ"
  },
  Task_147453_Desc = {
    Text = "Sử dụng người đánh thức vùng biển sâu trong \"Văn bản tạm thời\" để thắng 2 lầ"
  },
  Task_147454_Desc = {
    Text = "Sử dụng người đánh thức vùng máu thịt trong \"Văn bản tạm thời\" để thắng 1 lầ"
  },
  Task_147456_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_147458_Desc = {
    Text = "Khởi linh 2 khi nhận được Mộ Tinh·Tincture"
  },
  Task_147458_Name = {
    Text = "Khởi linh 2 khi nhận được Mộ Tinh·Tincture"
  },
  Task_147458_UnlockCondDesc = {
    Text = "Hoạt động@Gói khởi linh Thể thức tỉnh Mộ Tinh·Tincture 2 hoạt động"
  },
  Task_147461_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_147464_Desc = {
    Text = "Hoàn thành duy thức tiềm hành \"bản văn tạm thời\""
  },
  Task_147464_Name = {
    Text = "Văn bản tạm thời"
  },
  Task_147465_Desc = {
    Text = "Khởi linh 6 khi nhận được Mộ Tinh·Tincture"
  },
  Task_147465_Name = {
    Text = "Khởi linh 6 khi nhận được Mộ Tinh·Tincture"
  },
  Task_147465_UnlockCondDesc = {
    Text = "Hoạt động@Gói khởi linh Thể thức tỉnh Mộ Tinh·Tincture 2 hoạt động"
  },
  Task_147471_Desc = {
    Text = "Mộ Tinh·Tincture đạt nhân cách sâu hóa 12"
  },
  Task_147472_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_147474_Desc = {
    Text = "Sử dụng người đánh thức vùng hỗn loạn trong \"Văn bản tạm thời\" để thắng 2 lầ"
  },
  Task_147475_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_147476_Desc = {
    Text = "Hoàn thành tất cả thành tựu \"Văn bản tạm thời·Thông qua\""
  },
  Task_147478_Desc = {
    Text = "Hoàn thành duy thức tiềm hành \"Văn bản tạm thời\" ở độ khó khó khăn"
  },
  Task_147478_Name = {
    Text = "Nội dung tạm thời·khó khăn"
  },
  Task_147483_Desc = {
    Text = "Sử dụng người đánh thức vùng siêu cấp trong \"Văn bản tạm thời\" để thắng 2 lầ"
  },
  Task_147552_Desc = {
    Text = "Hoàn thành \"văn bản tạm thời\" bất kỳ độ khó nào"
  },
  Task_147553_Desc = {
    Text = "Hoàn thành \"văn bản tạm thời\" bất kỳ độ khó nào"
  },
  Task_147554_Desc = {
    Text = "Hoàn thành \"văn bản tạm thời\" bất kỳ độ khó nào"
  },
  Task_147555_Desc = {
    Text = "Hoàn thành \"văn bản tạm thời\" bất kỳ độ khó nào"
  },
  Task_147556_Desc = {
    Text = "Đánh bại độ khó điên loạn \"Văn bản tạm thời\""
  },
  Task_147557_Desc = {
    Text = "Hoàn thành \"văn bản tạm thời\" bất kỳ độ khó nào"
  },
  Task_147558_Desc = {
    Text = "Hoàn thành \"văn bản tạm thời\" bất kỳ độ khó nào"
  },
  Task_147559_Desc = {
    Text = "Hoàn thành \"văn bản tạm thời\" bất kỳ độ khó nào"
  },
  Task_147560_Desc = {
    Text = "Đánh bại độ khó điên loạn \"Văn bản tạm thời\""
  },
  Task_147561_Desc = {
    Text = "Hoàn thành \"văn bản tạm thời\" bất kỳ độ khó nào"
  },
  Task_147562_Desc = {
    Text = "Đánh bại độ khó điên loạn \"Văn bản tạm thời\""
  },
  Task_147563_Desc = {
    Text = "Bản nháp·điên cuồng"
  },
  Task_147564_Desc = {
    Text = "Hoàn thành \"văn bản tạm thời\" bất kỳ độ khó nào"
  },
  Task_147565_Desc = {
    Text = "Hoàn thành \"văn bản tạm thời\" bất kỳ độ khó nào"
  },
  Task_147566_Desc = {
    Text = "Hoàn thành \"văn bản tạm thời\" bất kỳ độ khó nào"
  },
  Task_147567_Desc = {
    Text = "Đánh bại độ khó điên loạn \"Văn bản tạm thời\""
  },
  Task_147568_Desc = {
    Text = "Đánh bại độ khó điên loạn \"Văn bản tạm thời\""
  },
  Task_147569_Desc = {
    Text = "Văn bản tạm thời·giới vực"
  },
  Task_147570_Desc = {
    Text = "Hoàn thành \"văn bản tạm thời\" bất kỳ độ khó nào"
  },
  Task_147571_Desc = {
    Text = "Hoàn thành \"văn bản tạm thời\" bất kỳ độ khó nào"
  },
  Task_147572_Desc = {
    Text = "Đánh bại độ khó điên loạn \"Văn bản tạm thời\""
  },
  Task_147573_Desc = {
    Text = "Đánh bại độ khó điên loạn \"Văn bản tạm thời\""
  },
  Task_147574_Desc = {
    Text = "Văn bản tạm·hoàn thành"
  },
  Task_147575_Desc = {
    Text = "Hoàn thành \"văn bản tạm thời\" bất kỳ độ khó nào"
  },
  Task_147676_Desc = {
    Text = "Cấp độ người chơi đạt cấp 2"
  },
  Task_147676_Name = {
    Text = "(Chờ đóng gói)"
  },
  Task_147677_Desc = {
    Text = "Sở hữu 1 Thể thức tỉnh cấp 10"
  },
  Task_147677_Name = {
    Text = "(Chờ đóng gói)"
  },
  Task_147678_Desc = {
    Text = "Hoàn thành Điều tra sự kiện \"Ngày Nhập Học\""
  },
  Task_147678_Name = {
    Text = "(Chờ đóng gói)"
  },
  Task_147679_Desc = {
    Text = "Sở hữu 5 Thể thức tỉnh"
  },
  Task_147679_Name = {
    Text = "(Chờ đóng gói)"
  },
  Task_147894_Desc = {
    Text = "Văn bản tạm thời"
  },
  Task_147894_Name = {
    Text = "Mục tiêu"
  },
  Task_147895_Desc = {
    Text = "Hoàn thành điều tra sự kiện \"Đại Tiệc Trên Núi Tuyết\" ở độ khó khó khăn"
  },
  Task_147895_Name = {
    Text = "Giấc Ngủ Ở Độ Cao 8840m·Khó Khăn"
  },
  Task_147896_Desc = {
    Text = "Văn bản tạm thời"
  },
  Task_147896_Name = {
    Text = "Mục tiêu"
  },
  Task_147897_Desc = {
    Text = "Văn bản tạm thời"
  },
  Task_147897_Name = {
    Text = "Mục tiêu"
  },
  Task_147898_Desc = {
    Text = "Văn bản tạm thời"
  },
  Task_147898_Name = {
    Text = "Mục tiêu"
  },
  Task_147899_Desc = {
    Text = "Văn bản tạm thời"
  },
  Task_147899_Name = {
    Text = "Mục tiêu"
  },
  Task_147900_Desc = {
    Text = "Văn bản tạm thời"
  },
  Task_147900_Name = {
    Text = "Mục tiêu"
  },
  Task_147901_Desc = {
    Text = "Văn bản tạm thời"
  },
  Task_147901_Name = {
    Text = "Mục tiêu"
  },
  Task_147902_Desc = {
    Text = "Trong cuộc điều tra sự kiện \"@1@2\" cộng hưởng 9 lần"
  },
  Task_147902_Desc2 = {
    Text = "Cộng hưởng 9 lần trong điều tra sự kiện \"Đại Tiệc Trên Núi Tuyết\""
  },
  Task_147902_Name2 = {
    Text = "Bảy Lễ Bái Của Kẻ Không Dối IV"
  },
  Task_147903_Desc = {
    Text = "Văn bản tạm thời"
  },
  Task_147903_Name = {
    Text = "Mục tiêu"
  },
  Task_147904_Desc = {
    Text = "Văn bản tạm thời"
  },
  Task_147904_Name = {
    Text = "Mục tiêu"
  },
  Task_147905_Desc = {
    Text = "Trong cuộc điều tra sự kiện \"@1@2\" cảm ứng 3 lần"
  },
  Task_147905_Desc2 = {
    Text = "Cộng hưởng 3 lần trong Điều tra sự kiện \"Đại Tiệc Trên Núi Tuyết\""
  },
  Task_147905_Name2 = {
    Text = "Bảy Lễ Bái Của Kẻ Không Dối"
  },
  Task_147906_Desc = {
    Text = "Trong sự kiện điều tra \"@1@2\" cảm ứng 7 lần"
  },
  Task_147906_Desc2 = {
    Text = "Cộng hưởng 7 lần trong Điều tra sự kiện \"Đại Tiệc Trên Núi Tuyết\""
  },
  Task_147906_Name2 = {
    Text = "Bảy Lễ Bái Của Kẻ Không Dối III"
  },
  Task_147907_Desc = {
    Text = "Cộng hưởng 5 lần trong Điều tra sự kiện \"@1@2\""
  },
  Task_147907_Desc2 = {
    Text = "Cộng hưởng 5 lần trong Điều tra sự kiện \"Đại Tiệc Trên Núi Tuyết\""
  },
  Task_147907_Name2 = {
    Text = "Bảy Lễ Bái Của Kẻ Không Dối II"
  },
  Task_147908_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"@1@2\""
  },
  Task_147908_Desc2 = {
    Text = "Hoàn thành điều tra sự kiện \"Đại Tiệc Trên Núi Tuyết\""
  },
  Task_147908_Name2 = {
    Text = "Giấc Ngủ Ở Độ Cao 8840m"
  },
  Task_147909_Desc = {
    Text = "Văn bản tạm thời"
  },
  Task_147909_Name = {
    Text = "Mục tiêu"
  },
  Task_147910_Desc = {
    Text = "Văn bản tạm thời"
  },
  Task_147910_Name = {
    Text = "Mục tiêu"
  },
  Task_148121_Desc = {
    Text = "Hoàn thành 15 lần phái cử"
  },
  Task_148122_Desc = {
    Text = "Giá trị luyện tập ở khu vực d-khu vực đạt đến 100"
  },
  Task_148123_Desc = {
    Text = "Đăng nhập tổng cộng 1 ngày"
  },
  Task_148124_Desc = {
    Text = "Thức tỉnh 30 lần"
  },
  Task_148125_Desc = {
    Text = "Đăng nhập tổng cộng 1 ngày"
  },
  Task_148126_Desc = {
    Text = "Hoàn thành nhiệm vụ mùa bất kỳ trong \"Thử Thách Cấm Kỵ\""
  },
  Task_148127_Desc = {
    Text = "Hoàn thành nhiệm vụ mùa bất kỳ trong \"Thử Thách Cấm Kỵ\""
  },
  Task_148128_Desc = {
    Text = "Giá trị luyện tập ở khu vực d-khu vực đạt đến 100"
  },
  Task_148129_Desc = {
    Text = "Thức tỉnh 30 lần"
  },
  Task_148130_Desc = {
    Text = "Hoàn thành 15 lần phái cử"
  },
  Task_148131_Desc = {
    Text = "Sử dụng hỗ trợ 3 lần"
  },
  Task_148132_Desc = {
    Text = "\"Ion Hoạt Tính Tinh Túy\"đạt 1000"
  },
  Task_148133_Desc = {
    Text = "Sử dụng hỗ trợ 3 lần"
  },
  Task_148134_Desc = {
    Text = "Tích lũy đánh ra 300 lá bài"
  },
  Task_148135_Desc = {
    Text = "\"Ion Hoạt Tính Tinh Túy\"đạt 1000"
  },
  Task_148136_Desc = {
    Text = "Tích lũy đánh ra 300 lá bài"
  },
  Task_148489_Desc = {
    Text = "Hoàn thành duy thức tiềm hành \"Ngũ Nhật Đàm\""
  },
  Task_148489_Name = {
    Text = "Khải Hoàn Của Kẻ Mất Quê Hương"
  },
  Task_148490_Desc = {
    Text = "Hoàn thành duy thức tiềm hành \"Ngũ Nhật Đàm\" độ khó khó khăn"
  },
  Task_148490_Name = {
    Text = "Khải Hoàn Của Kẻ Mất Quê Hương·Khó Khăn"
  },
  Task_149335_Desc = {
    Text = "Giết rồng"
  },
  Task_149335_Name = {
    Text = "Mục tiêu"
  },
  Task_149989_Desc = {
    Text = "Hoàn thành Bài sao Chương 6 6-1"
  },
  Task_149990_Desc = {
    Text = "Nguồn gốc Orci đạt nhân cách sâu hóa 12"
  },
  Task_19734_Desc = {
    Text = "Hoàn thành chiến dịch siêu việt·khe hởVI"
  },
  Task_19735_Desc = {
    Text = "Hoàn thành Đầm lầy Thịt Máu · khe hở VIII"
  },
  Task_19736_Desc = {
    Text = "Hoàn thành hành trình siêu việt · Khe hở IV"
  },
  Task_19737_Desc = {
    Text = "Hoàn thành đầm lầy máu thịt, khe hở II"
  },
  Task_19738_Desc = {
    Text = "Hoàn thành siêu việt chi du khe hở II"
  },
  Task_19739_Desc = {
    Text = "Hoàn thành Vũng Thịt Máu·Khe Hở VI"
  },
  Task_19740_Desc = {
    Text = "Đặt bẫy, thực hiện \"săn bắn\""
  },
  Task_19740_Name = {
    Text = "Mục tiêu"
  },
  Task_19741_Desc = {
    Text = "Hoàn thành Siêu Việt Trình · Khe Hở VIII"
  },
  Task_19742_Desc = {
    Text = "Hoàn thành Di sản Biển sâu · Khe hở II"
  },
  Task_19743_Desc = {
    Text = "Hoàn thành Vực Hỗn Loạn · Khe Hở II"
  },
  Task_19744_Desc = {
    Text = "Hoàn thành Di sản của Biển sâu · Khe hở VI"
  },
  Task_19745_Desc = {
    Text = "Hoàn thành Vực Hỗn Loạn · Khe Hở IV"
  },
  Task_19746_Desc = {
    Text = "Hoàn thành Di sản Biển sâu·Khe hở IV"
  },
  Task_19747_Desc = {
    Text = "Chinh phục Vực Hỗn Loạn · Khe Hở VI"
  },
  Task_19748_Desc = {
    Text = "Hoàn thành Vùng Hỗn Loạn · Khe Hở VIII"
  },
  Task_19749_Desc = {
    Text = "Hoàn thành Di sản Biển sâu · Khe hở VIII"
  },
  Task_19750_Desc = {
    Text = "Đặt bẫy, thực hiện \"săn bắn\""
  },
  Task_19750_Name = {
    Text = "Mục tiêu"
  },
  Task_19751_Desc = {
    Text = "Hỗ trợ Lơ-tan đuổi đánh kẻ địch"
  },
  Task_19751_Name = {
    Text = "Mục tiêu"
  },
  Task_19752_Desc = {
    Text = "Hoàn thành Đầm Lầy Thịt Máu · Khe Hở IV"
  },
  Task_20972_Desc = {
    Text = "Hoàn thành hành trình siêu việt khe hở I"
  },
  Task_20973_Desc = {
    Text = "Hoàn thành khe hở Di sản của Biển sâu I"
  },
  Task_20990_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_20990_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_20991_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_20991_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_20992_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_20992_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_20993_Desc = {
    Text = "Cuộc chiến cuối cùng cơn thịnh nộ bùng phát ít nhất 4 lần trong một lượt"
  },
  Task_20993_Name = {
    Text = "Thuật ảo thuật chết người"
  },
  Task_20994_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_20994_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_20995_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_20995_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_20996_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_20996_Name = {
    Text = "Thanh lịch và chính xác"
  },
  Task_20997_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_20997_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_20998_Desc = {
    Text = "Cuộc chiến cuối cùng, trong một lượt, rút thêm ít nhất 5 lá bài"
  },
  Task_20998_Name = {
    Text = "Vẽ thẻ!"
  },
  Task_20999_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_20999_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21000_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_21000_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21001_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21001_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21002_Desc = {
    Text = "Hoàn thành khi thức tỉnh tất cả các thân thể"
  },
  Task_21002_Name = {
    Text = "Vô tận ôm ấp"
  },
  Task_21003_Desc = {
    Text = "Nhận được ít nhất 4 loại khắc ấn khác nhau"
  },
  Task_21003_Name = {
    Text = "Ấn ký linh hồn"
  },
  Task_21004_Desc = {
    Text = "Gây ít nhất 240 điểm thương trong một lượt"
  },
  Task_21004_Name = {
    Text = "Đòn toàn lực"
  },
  Task_21005_Desc = {
    Text = "Khi hoàn thành, không sử dụng điểm liên lạc để hồi phục sức sống"
  },
  Task_21005_Name = {
    Text = "Người thiếu lửa"
  },
  Task_21006_Desc = {
    Text = "Khi hoàn thành, số lượng thẻ triệu chứng không vượt quá 3"
  },
  Task_21006_Name = {
    Text = "Tiết kiệm năng lượng"
  },
  Task_21007_Desc = {
    Text = "Hoàn thành khi mang theo ít nhất một vật bị nguyền rủa"
  },
  Task_21007_Name = {
    Text = "Kho báu kỳ binh"
  },
  Task_21008_Desc = {
    Text = "Khi hoàn thành, không có quá 1 thẻ triệu chứng"
  },
  Task_21008_Name = {
    Text = "Tiết kiệm năng lượng"
  },
  Task_21009_Desc = {
    Text = "Cuộc chiến cuối cùng, một lượt đánh ra ít nhất 4 thẻ bài"
  },
  Task_21009_Name = {
    Text = "Lượt của tôi"
  },
  Task_21010_Desc = {
    Text = "Độ khám phá đạt 100%"
  },
  Task_21010_Name = {
    Text = "Nhìn xuống vùng sương mù"
  },
  Task_21011_Desc = {
    Text = "Hoàn thành với ít nhất 5 sáng tạo"
  },
  Task_21011_Name = {
    Text = "Kho báu kỳ binh"
  },
  Task_21012_Desc = {
    Text = "Hoàn thành với ít nhất 5 sáng tạo"
  },
  Task_21012_Name = {
    Text = "Kho báu kỳ binh"
  },
  Task_21013_Desc = {
    Text = "Hoàn thành với ít nhất 5 sáng tạo"
  },
  Task_21013_Name = {
    Text = "Kho báu kỳ binh"
  },
  Task_21014_Desc = {
    Text = "Cuộc chiến cuối cùng, trong một lượt tối thiểu tăng thêm lá chắn bằng 50% máu tối đa"
  },
  Task_21014_Name = {
    Text = "Thân hình bằng thép"
  },
  Task_21015_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21015_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21016_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_21016_Name = {
    Text = "Thanh lịch và chính xác"
  },
  Task_21017_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21017_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21018_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_21018_Name = {
    Text = "Thanh lịch và chính xác"
  },
  Task_21019_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_21019_Name = {
    Text = "Thanh lịch và chính xác"
  },
  Task_21020_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21020_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21021_Desc = {
    Text = "Chiến thắng trong cuộc chiến cuối cùng dưới 15 lượt"
  },
  Task_21021_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21022_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21022_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21023_Desc = {
    Text = "Khi hoàn thành, số lượng thẻ triệu chứng không vượt quá 2"
  },
  Task_21023_Name = {
    Text = "Tiết kiệm năng lượng"
  },
  Task_21024_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21024_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21025_Desc = {
    Text = "Cuộc chiến cuối cùng cơn thịnh nộ bùng phát ít nhất 4 lần trong một lượt"
  },
  Task_21025_Name = {
    Text = "Thuật ảo thuật chết người"
  },
  Task_21026_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21026_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21027_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_21027_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21028_Desc = {
    Text = "Chiến thắng trong cuộc chiến cuối cùng dưới 15 lượt"
  },
  Task_21028_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21029_Desc = {
    Text = "Cuộc chiến cuối cùng, trong một lượt, đánh ít nhất 6 thẻ bài"
  },
  Task_21029_Name = {
    Text = "Lượt của tôi"
  },
  Task_21030_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21030_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21032_Desc = {
    Text = "Trong cuộc chiến cuối cùng, gây ra ít nhất 40000 điểm sát thương trong một lượt"
  },
  Task_21032_Name = {
    Text = "Đòn toàn lực"
  },
  Task_21033_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21033_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21034_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21034_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21035_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_21035_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21036_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21036_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21037_Desc = {
    Text = "Khi hoàn thành, không có quá 1 thẻ triệu chứng"
  },
  Task_21037_Name = {
    Text = "Tiết kiệm năng lượng"
  },
  Task_21038_Desc = {
    Text = "Cuộc chiến cuối cùng, một lượt đánh ra ít nhất 4 thẻ bài"
  },
  Task_21038_Name = {
    Text = "Lượt của tôi"
  },
  Task_21039_Desc = {
    Text = "Độ khám phá đạt 100%"
  },
  Task_21039_Name = {
    Text = "Nhìn xuống vùng sương mù"
  },
  Task_21040_Desc = {
    Text = "Hoàn thành với ít nhất 5 sáng tạo"
  },
  Task_21040_Name = {
    Text = "Kho báu kỳ binh"
  },
  Task_21041_Desc = {
    Text = "Hoàn thành với ít nhất 5 sáng tạo"
  },
  Task_21041_Name = {
    Text = "Kho báu kỳ binh"
  },
  Task_21042_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_21042_Name = {
    Text = "Thanh lịch và chính xác"
  },
  Task_21043_Desc = {
    Text = "Cuộc chiến cuối cùng, trong một lượt tối thiểu tăng thêm lá chắn bằng 50% máu tối đa"
  },
  Task_21043_Name = {
    Text = "Thân hình bằng thép"
  },
  Task_21044_Desc = {
    Text = "Nhận được ít nhất 4 loại khắc ấn khác nhau"
  },
  Task_21044_Name = {
    Text = "Ấn ký linh hồn"
  },
  Task_21045_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_21045_Name = {
    Text = "Thanh lịch và chính xác"
  },
  Task_21046_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_21046_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21047_Desc = {
    Text = "Cuộc chiến cuối cùng cơn thịnh nộ bùng phát ít nhất 4 lần trong một lượt"
  },
  Task_21047_Name = {
    Text = "Thuật ảo thuật chết người"
  },
  Task_21048_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21048_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21049_Desc = {
    Text = "Khi hoàn thành, không có quá 1 thẻ triệu chứng"
  },
  Task_21049_Name = {
    Text = "Tiết kiệm năng lượng"
  },
  Task_21050_Desc = {
    Text = "Hoàn thành khi thức tỉnh tất cả các thân thể"
  },
  Task_21050_Name = {
    Text = "Vô tận ôm ấp"
  },
  Task_21051_Desc = {
    Text = "Hoàn thành khi mang theo ít nhất 2 vật phẩm"
  },
  Task_21051_Name = {
    Text = "Kho báu kỳ binh"
  },
  Task_21052_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21052_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21053_Desc = {
    Text = "Nhận được ít nhất 4 loại khắc ấn khác nhau"
  },
  Task_21053_Name = {
    Text = "Ấn ký linh hồn"
  },
  Task_21054_Desc = {
    Text = "Nhận được ít nhất 4 loại khắc ấn khác nhau"
  },
  Task_21054_Name = {
    Text = "Ấn ký linh hồn"
  },
  Task_21055_Desc = {
    Text = "Trong trận chiến tinh anh, tạo ra ít nhất 980 điểm thương trong một lượt"
  },
  Task_21055_Name = {
    Text = "Đòn toàn lực"
  },
  Task_21056_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_21056_Name = {
    Text = "Thanh lịch và chính xác"
  },
  Task_21057_Desc = {
    Text = "Khi hoàn thành, số lượng thẻ triệu chứng không vượt quá 3"
  },
  Task_21057_Name = {
    Text = "Tiết kiệm năng lượng"
  },
  Task_21058_Desc = {
    Text = "Hoàn thành khi mang theo ít nhất một vật bị nguyền rủa"
  },
  Task_21058_Name = {
    Text = "Kho báu kỳ binh"
  },
  Task_21059_Desc = {
    Text = "Độ khám phá đạt 100%"
  },
  Task_21059_Name = {
    Text = "Nhìn xuống vùng sương mù"
  },
  Task_21060_Desc = {
    Text = "Sử dụng ít nhất 3 lần điên cuồng bùng phát trong một lượt trận"
  },
  Task_21060_Name = {
    Text = "Thuật ảo thuật chết người"
  },
  Task_21061_Desc = {
    Text = "Cuộc chiến cuối cùng, trong một lượt, rút thêm ít nhất 5 lá bài"
  },
  Task_21061_Name = {
    Text = "Vẽ thẻ!"
  },
  Task_21062_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_21062_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21063_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21063_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21064_Desc = {
    Text = "Hoàn thành khi mang theo ít nhất 2 vật phẩm"
  },
  Task_21064_Name = {
    Text = "Kho báu kỳ binh"
  },
  Task_21065_Desc = {
    Text = "Khi hoàn thành, số lượng thẻ triệu chứng không vượt quá 2"
  },
  Task_21065_Name = {
    Text = "Tiết kiệm năng lượng"
  },
  Task_21066_Desc = {
    Text = "Nhận được ít nhất ba loại khắcăng"
  },
  Task_21066_Name = {
    Text = "Ấn ký linh hồn"
  },
  Task_21067_Desc = {
    Text = "Khi hoàn thành, thân thể được đánh thức lớn hơn hoặc bằng 2"
  },
  Task_21067_Name = {
    Text = "Vô tận ôm ấp"
  },
  Task_21068_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_21068_Name = {
    Text = "Thanh lịch và chính xác"
  },
  Task_21069_Desc = {
    Text = "Hoàn thành khi mang theo ít nhất một vật bị nguyền rủa"
  },
  Task_21069_Name = {
    Text = "Kho báu kỳ binh"
  },
  Task_21070_Desc = {
    Text = "Cuộc chiến cuối cùng, một lượt đánh ra ít nhất 4 thẻ bài"
  },
  Task_21070_Name = {
    Text = "Lượt của tôi"
  },
  Task_21071_Desc = {
    Text = "Trong lượt chơi cuối cùng, cơn thịnh nộ bùng phát ít nhất 3 lần trong một lượt"
  },
  Task_21071_Name = {
    Text = "Thuật ảo thuật chết người"
  },
  Task_21072_Desc = {
    Text = "Khi hoàn thành, số lượng thẻ triệu chứng không vượt quá 3"
  },
  Task_21072_Name = {
    Text = "Tiết kiệm năng lượng"
  },
  Task_21073_Desc = {
    Text = "Khi hoàn thành, không có quá 1 thẻ triệu chứng"
  },
  Task_21073_Name = {
    Text = "Tiết kiệm năng lượng"
  },
  Task_21074_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21074_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21075_Desc = {
    Text = "Có 4 loại khắcăng khác nhau"
  },
  Task_21075_Name = {
    Text = "Ấn ký linh hồn"
  },
  Task_21076_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_21076_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21077_Desc = {
    Text = "Cuộc chiến cuối cùng, đánh ra ít nhất 5 thẻ trong 1 lượt"
  },
  Task_21077_Name = {
    Text = "Lượt của tôi"
  },
  Task_21078_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21078_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21079_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21079_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21080_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21080_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21081_Desc = {
    Text = "Cuộc chiến cuối cùng trong một lượt gây 350 điểm thương tổn"
  },
  Task_21081_Name = {
    Text = "Đòn toàn lực"
  },
  Task_21082_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_21082_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21083_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_21083_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21084_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21084_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21085_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21085_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21086_Desc = {
    Text = "Khi hoàn thành, số lượng thẻ triệu chứng không vượt quá 2"
  },
  Task_21086_Name = {
    Text = "Tiết kiệm năng lượng"
  },
  Task_21087_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_21087_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21088_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_21088_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21089_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21089_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21090_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_21090_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21091_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_21091_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21092_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_21092_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21093_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_21093_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21094_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_21094_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21095_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_21095_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21096_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_21096_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21097_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_21097_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21098_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_21098_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21099_Desc = {
    Text = "Hoàn thành khi mang theo ít nhất một vật bị nguyền rủa"
  },
  Task_21099_Name = {
    Text = "Kho báu kỳ binh"
  },
  Task_21100_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_21100_Name = {
    Text = "Thanh lịch và chính xác"
  },
  Task_21101_Desc = {
    Text = "Trong bất kỳ cuộc chiến đấu nào, tiêu diệt ít nhất 2 quái vật trong một lượt"
  },
  Task_21101_Name = {
    Text = "Xử lý triệt để"
  },
  Task_21102_Desc = {
    Text = "Hoàn thành khi mang theo ít nhất 8 món đồ"
  },
  Task_21102_Name = {
    Text = "Kho báu kỳ binh"
  },
  Task_21103_Desc = {
    Text = "Khi hoàn thành, không có quá 1 thẻ triệu chứng"
  },
  Task_21103_Name = {
    Text = "Tiết kiệm năng lượng"
  },
  Task_21104_Desc = {
    Text = "Cuộc chiến cuối cùng, đánh ra ít nhất 5 thẻ trong 1 lượt"
  },
  Task_21104_Name = {
    Text = "Lượt của tôi"
  },
  Task_21105_Desc = {
    Text = "Trong cuộc chiến cuối cùng, gây ra ít nhất 300 điểm thương tổn trong một lượt"
  },
  Task_21105_Name = {
    Text = "Đòn toàn lực"
  },
  Task_21106_Desc = {
    Text = "Cuộc chiến cuối cùng, mỗi lượt rút thêm ít nhất 3 lá bài"
  },
  Task_21106_Name = {
    Text = "Vẽ thẻ!"
  },
  Task_21107_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21107_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21108_Desc = {
    Text = "Cuộc chiến cuối cùng, trong một lượt gây ít nhất 96000 điểm sát thương"
  },
  Task_21108_Name = {
    Text = "Đòn toàn lực"
  },
  Task_21110_Desc = {
    Text = "Khi hoàn thành, số lượng thẻ triệu chứng không vượt quá 2"
  },
  Task_21110_Name = {
    Text = "Tiết kiệm năng lượng"
  },
  Task_21111_Desc = {
    Text = "Khi hoàn thành, không có quá 1 thẻ triệu chứng"
  },
  Task_21111_Name = {
    Text = "Tiết kiệm năng lượng"
  },
  Task_21112_Desc = {
    Text = "Trong bất kỳ cuộc chiến đấu nào, tiêu diệt ít nhất 2 con quái vật trong một hiệp"
  },
  Task_21112_Name = {
    Text = "Xử lý triệt để"
  },
  Task_21113_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21113_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21114_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_21114_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21115_Desc = {
    Text = "Khi hoàn thành, số lượng thẻ triệu chứng không vượt quá 2"
  },
  Task_21115_Name = {
    Text = "Tiết kiệm năng lượng"
  },
  Task_21116_Desc = {
    Text = "Khi hoàn thành, mạng sống không được dưới 80%"
  },
  Task_21116_Name = {
    Text = "Thanh lịch và chính xác"
  },
  Task_21117_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21117_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21118_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_21118_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21119_Desc = {
    Text = "Khi hoàn thành, không có quá 1 thẻ triệu chứng"
  },
  Task_21119_Name = {
    Text = "Tiết kiệm năng lượng"
  },
  Task_21120_Desc = {
    Text = "Trong bất kỳ cuộc chiến đấu nào, tiêu diệt ít nhất 2 con quái vật trong một hiệp"
  },
  Task_21120_Name = {
    Text = "Xử lý triệt để"
  },
  Task_21121_Desc = {
    Text = "Khi hoàn thành, số lượng thẻ triệu chứng không vượt quá 2"
  },
  Task_21121_Name = {
    Text = "Tiết kiệm năng lượng"
  },
  Task_21122_Desc = {
    Text = "Gây ra ít nhất 1600 thương tổn chỉ trong một lượt của trận chiến tinh anh"
  },
  Task_21122_Name = {
    Text = "Đòn toàn lực"
  },
  Task_21123_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_21123_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21124_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21124_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21125_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21125_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21126_Desc = {
    Text = "Sử dụng ít nhất 3 lần điên cuồng bùng phát trong một lượt trận"
  },
  Task_21126_Name = {
    Text = "Thuật ảo thuật chết người"
  },
  Task_21127_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_21127_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21128_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21128_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21129_Desc = {
    Text = "Khi hoàn thành, không có quá 1 thẻ triệu chứng"
  },
  Task_21129_Name = {
    Text = "Tiết kiệm năng lượng"
  },
  Task_21130_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21130_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21131_Desc = {
    Text = "Hoàn thành khi thức tỉnh tất cả các thân thể"
  },
  Task_21131_Name = {
    Text = "Vô tận ôm ấp"
  },
  Task_21132_Desc = {
    Text = "Trong cuộc chiến cuối cùng, gây ít nhất 6000 điểm thương trong một lượt"
  },
  Task_21132_Name = {
    Text = "Đòn toàn lực"
  },
  Task_21133_Desc = {
    Text = "Cuộc chiến cuối cùng, trong một lượt, rút thêm ít nhất 5 lá bài"
  },
  Task_21133_Name = {
    Text = "Vẽ thẻ!"
  },
  Task_21134_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21134_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21135_Desc = {
    Text = "Trong cuộc chiến cuối cùng, mỗi lượt chơi rút thêm ít nhất 4 lá bài"
  },
  Task_21135_Name = {
    Text = "Vẽ thẻ!"
  },
  Task_21136_Desc = {
    Text = "Chiến thắng trong cuộc chiến cuối cùng dưới 15 lượt"
  },
  Task_21136_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21137_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_21137_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21138_Desc = {
    Text = "Gây ít nhất 1800 thương trong một lượt của trận chiến tinh anh"
  },
  Task_21138_Name = {
    Text = "Đòn toàn lực"
  },
  Task_21139_Desc = {
    Text = "Hoàn thành khi mang theo ít nhất một vật bị nguyền rủa"
  },
  Task_21139_Name = {
    Text = "Kho báu kỳ binh"
  },
  Task_21140_Desc = {
    Text = "Cuộc chiến cuối cùng, đánh ra ít nhất 5 thẻ trong 1 lượt"
  },
  Task_21140_Name = {
    Text = "Lượt của tôi"
  },
  Task_21141_Desc = {
    Text = "Cuộc chiến cuối cùng, ít nhất cộng dồn lá chắn bằng 65% máu tối đa trong một lượt"
  },
  Task_21141_Name = {
    Text = "Thân hình bằng thép"
  },
  Task_21142_Desc = {
    Text = "Khi hoàn thành, số lượng thẻ triệu chứng không vượt quá 2"
  },
  Task_21142_Name = {
    Text = "Tiết kiệm năng lượng"
  },
  Task_21143_Desc = {
    Text = "Nhận được ít nhất 4 loại khắc ấn khác nhau"
  },
  Task_21143_Name = {
    Text = "Ấn ký linh hồn"
  },
  Task_21144_Desc = {
    Text = "Hoàn thành khi mang theo ít nhất 2 vật phẩm"
  },
  Task_21144_Name = {
    Text = "Kho báu kỳ binh"
  },
  Task_21145_Desc = {
    Text = "Hoàn thành khi dùng điểm liên lạc hồi sức sống không quá 1 lần"
  },
  Task_21145_Name = {
    Text = "Người thiếu lửa"
  },
  Task_21146_Desc = {
    Text = "Hoàn thành khi mang theo ít nhất một vật bị nguyền rủa"
  },
  Task_21146_Name = {
    Text = "Kho báu kỳ binh"
  },
  Task_21147_Desc = {
    Text = "Khi hoàn thành, số lượng thẻ triệu chứng không vượt quá 2"
  },
  Task_21147_Name = {
    Text = "Tiết kiệm năng lượng"
  },
  Task_21148_Desc = {
    Text = "Trong trận chiến tinh anh, gây ít nhất 500 điểm thương trong một lượt"
  },
  Task_21148_Name = {
    Text = "Đòn toàn lực"
  },
  Task_21149_Desc = {
    Text = "Trong bất kỳ cuộc chiến đấu nào, tiêu diệt ít nhất 2 con quái vật trong một hiệp"
  },
  Task_21149_Name = {
    Text = "Xử lý triệt để"
  },
  Task_21150_Desc = {
    Text = "Kích hoạt ít nhất 3 thân thể đã được đánh thức"
  },
  Task_21150_Name = {
    Text = "Vô tận ôm ấp"
  },
  Task_21151_Desc = {
    Text = "Nhận được ít nhất 4 loại khắc ấn khác nhau"
  },
  Task_21151_Name = {
    Text = "Ấn ký linh hồn"
  },
  Task_21152_Desc = {
    Text = "Độ khám phá đạt 100%"
  },
  Task_21152_Name = {
    Text = "Nhìn xuống vùng sương mù"
  },
  Task_21153_Desc = {
    Text = "Cuộc chiến cuối cùng cơn thịnh nộ bùng phát ít nhất 4 lần trong một lượt"
  },
  Task_21153_Name = {
    Text = "Thuật ảo thuật chết người"
  },
  Task_21154_Desc = {
    Text = "Khi hoàn thành, số lượng thẻ triệu chứng không vượt quá 2"
  },
  Task_21154_Name = {
    Text = "Tiết kiệm năng lượng"
  },
  Task_21155_Desc = {
    Text = "Trong một lượt ít nhất cộng dồn lá chắn bằng 60% máu tối đa"
  },
  Task_21155_Name = {
    Text = "Thân hình bằng thép"
  },
  Task_21156_Desc = {
    Text = "Hoàn thành khi mang theo ít nhất 8 món đồ"
  },
  Task_21156_Name = {
    Text = "Kho báu kỳ binh"
  },
  Task_21157_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_21157_Name = {
    Text = "Thanh lịch và chính xác"
  },
  Task_21158_Desc = {
    Text = "Trong cuộc chiến cuối cùng, mỗi lượt chơi rút thêm ít nhất 4 lá bài"
  },
  Task_21158_Name = {
    Text = "Vẽ thẻ!"
  },
  Task_21159_Desc = {
    Text = "Trong cuộc chiến cuối cùng, gây ra ít nhất 5200 điểm thương hại trong một lượt"
  },
  Task_21159_Name = {
    Text = "Đòn toàn lực"
  },
  Task_21160_Desc = {
    Text = "Cuộc chiến cuối cùng, mỗi lượt rút thêm ít nhất 3 lá bài"
  },
  Task_21160_Name = {
    Text = "Vẽ thẻ!"
  },
  Task_21161_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21161_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21162_Desc = {
    Text = "Cuộc chiến cuối cùng, ít nhất cộng dồn lá chắn bằng 65% máu tối đa trong một lượt"
  },
  Task_21162_Name = {
    Text = "Thân hình bằng thép"
  },
  Task_21163_Desc = {
    Text = "Khi hoàn thành, số lượng thẻ triệu chứng không vượt quá 2"
  },
  Task_21163_Name = {
    Text = "Tiết kiệm năng lượng"
  },
  Task_21164_Desc = {
    Text = "Hoàn thành khi mang theo ít nhất một vật bị nguyền rủa"
  },
  Task_21164_Name = {
    Text = "Kho báu kỳ binh"
  },
  Task_21165_Desc = {
    Text = "Cuộc chiến cuối cùng, một lượt đánh ra ít nhất 4 thẻ bài"
  },
  Task_21165_Name = {
    Text = "Lượt của tôi"
  },
  Task_21166_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21166_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21167_Desc = {
    Text = "Có 4 loại khắcăng khác nhau"
  },
  Task_21167_Name = {
    Text = "Ấn ký linh hồn"
  },
  Task_21168_Desc = {
    Text = "Cuộc chiến cuối cùng một lượt gây 120 điểm thương tích"
  },
  Task_21168_Name = {
    Text = "Đòn toàn lực"
  },
  Task_21169_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_21169_Name = {
    Text = "Thanh lịch và chính xác"
  },
  Task_21170_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_21170_Name = {
    Text = "Thanh lịch và chính xác"
  },
  Task_21171_Desc = {
    Text = "Trong bất kỳ cuộc chiến đấu nào, tiêu diệt ít nhất 2 quái vật trong một lượt"
  },
  Task_21171_Name = {
    Text = "Xử lý triệt để"
  },
  Task_21172_Desc = {
    Text = "Cuộc chiến cuối cùng, mỗi lượt rút thêm ít nhất 3 lá bài"
  },
  Task_21172_Name = {
    Text = "Vẽ thẻ!"
  },
  Task_21173_Desc = {
    Text = "Kích hoạt ít nhất 3 thân thể đã được đánh thức"
  },
  Task_21173_Name = {
    Text = "Vô tận ôm ấp"
  },
  Task_21174_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_21174_Name = {
    Text = "Thanh lịch và chính xác"
  },
  Task_21176_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_21176_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21177_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_21177_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21178_Desc = {
    Text = "Khi hoàn thành, số lượng thẻ triệu chứng không vượt quá 2"
  },
  Task_21178_Name = {
    Text = "Tiết kiệm năng lượng"
  },
  Task_21179_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21179_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21180_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21180_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21181_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21181_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21182_Desc = {
    Text = "Khi hoàn thành, không có quá 1 thẻ triệu chứng"
  },
  Task_21182_Name = {
    Text = "Tiết kiệm năng lượng"
  },
  Task_21183_Desc = {
    Text = "Khi hoàn thành, số lượng thẻ triệu chứng không vượt quá 2"
  },
  Task_21183_Name = {
    Text = "Tiết kiệm năng lượng"
  },
  Task_21184_Desc = {
    Text = "Độ khám phá đạt 100%"
  },
  Task_21184_Name = {
    Text = "Nhìn xuống vùng sương mù"
  },
  Task_21185_Desc = {
    Text = "Trong cuộc chiến cuối cùng, gây ra ít nhất 1000 điểm thương tích trong một lượt"
  },
  Task_21185_Name = {
    Text = "Đòn toàn lực"
  },
  Task_21186_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_21186_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21187_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_21187_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21188_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_21188_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21189_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_21189_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21190_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_21190_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21191_Desc = {
    Text = "Khi hoàn thành, không có quá 1 thẻ triệu chứng"
  },
  Task_21191_Name = {
    Text = "Tiết kiệm năng lượng"
  },
  Task_21192_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_21192_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21193_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_21193_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21194_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_21194_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21195_Desc = {
    Text = "Cuộc chiến cuối cùng, trong một lượt gây ít nhất 7300 điểm thương"
  },
  Task_21195_Name = {
    Text = "Đòn toàn lực"
  },
  Task_21196_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_21196_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21197_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_21197_Name = {
    Text = "Thanh lịch và chính xác"
  },
  Task_21198_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_21198_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21199_Desc = {
    Text = "Cuộc chiến cuối cùng, một lượt đánh ra ít nhất 4 thẻ bài"
  },
  Task_21199_Name = {
    Text = "Lượt của tôi"
  },
  Task_21200_Desc = {
    Text = "Khi hoàn thành, số lượng thẻ triệu chứng không vượt quá 3"
  },
  Task_21200_Name = {
    Text = "Tiết kiệm năng lượng"
  },
  Task_21201_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21201_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21202_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21202_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21203_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21203_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21204_Desc = {
    Text = "Hoàn thành khi mang theo ít nhất 2 vật phẩm"
  },
  Task_21204_Name = {
    Text = "Kho báu kỳ binh"
  },
  Task_21205_Desc = {
    Text = "Khi hoàn thành, số lượng thẻ triệu chứng không vượt quá 2"
  },
  Task_21205_Name = {
    Text = "Tiết kiệm năng lượng"
  },
  Task_21206_Desc = {
    Text = "Nhận được ít nhất ba loại khắcăng"
  },
  Task_21206_Name = {
    Text = "Ấn ký linh hồn"
  },
  Task_21207_Desc = {
    Text = "Khi hoàn thành, thân thể được đánh thức lớn hơn hoặc bằng 2"
  },
  Task_21207_Name = {
    Text = "Vô tận ôm ấp"
  },
  Task_21208_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_21208_Name = {
    Text = "Thanh lịch và chính xác"
  },
  Task_21209_Desc = {
    Text = "Hoàn thành khi mang theo ít nhất một vật bị nguyền rủa"
  },
  Task_21209_Name = {
    Text = "Kho báu kỳ binh"
  },
  Task_21210_Desc = {
    Text = "Cuộc chiến cuối cùng, một lượt đánh ra ít nhất 4 thẻ bài"
  },
  Task_21210_Name = {
    Text = "Lượt của tôi"
  },
  Task_21211_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21211_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21212_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_21212_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21213_Desc = {
    Text = "Cuộc chiến cuối cùng, trong một lượt gây ít nhất 2500 điểm sát thương"
  },
  Task_21213_Name = {
    Text = "Đòn toàn lực"
  },
  Task_21214_Desc = {
    Text = "Cuộc chiến cuối cùng, trong một lượt, rút thêm ít nhất 5 lá bài"
  },
  Task_21214_Name = {
    Text = "Vẽ thẻ!"
  },
  Task_21215_Desc = {
    Text = "Cuộc chiến cuối cùng, trong một lượt, đánh ít nhất 6 thẻ bài"
  },
  Task_21215_Name = {
    Text = "Lượt của tôi"
  },
  Task_21216_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_21216_Name = {
    Text = "Thanh lịch và chính xác"
  },
  Task_21217_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_21217_Name = {
    Text = "Thanh lịch và chính xác"
  },
  Task_21218_Desc = {
    Text = "Hoàn thành khi thức tỉnh tất cả các thân thể"
  },
  Task_21218_Name = {
    Text = "Vô tận ôm ấp"
  },
  Task_21219_Desc = {
    Text = "Cuộc chiến cuối cùng, mỗi lượt rút thêm ít nhất 3 lá bài"
  },
  Task_21219_Name = {
    Text = "Vẽ thẻ!"
  },
  Task_21220_Desc = {
    Text = "Kích hoạt ít nhất 3 thân thể đã được đánh thức"
  },
  Task_21220_Name = {
    Text = "Vô tận ôm ấp"
  },
  Task_21221_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_21221_Name = {
    Text = "Thanh lịch và chính xác"
  },
  Task_21222_Desc = {
    Text = "Hoàn thành khi mang theo ít nhất một vật bị nguyền rủa"
  },
  Task_21222_Name = {
    Text = "Kho báu kỳ binh"
  },
  Task_21223_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21223_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21224_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21224_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21225_Desc = {
    Text = "Trong bất kỳ cuộc chiến đấu nào, tiêu diệt ít nhất 2 con quái vật trong một hiệp"
  },
  Task_21225_Name = {
    Text = "Xử lý triệt để"
  },
  Task_21226_Desc = {
    Text = "Hoàn thành khi mang theo ít nhất 2 vật phẩm"
  },
  Task_21226_Name = {
    Text = "Kho báu kỳ binh"
  },
  Task_21227_Desc = {
    Text = "Nhận được ít nhất 4 loại khắc ấn khác nhau"
  },
  Task_21227_Name = {
    Text = "Ấn ký linh hồn"
  },
  Task_21228_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21228_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21229_Desc = {
    Text = "Khi hoàn thành, không sử dụng điểm liên lạc để hồi phục sức sống"
  },
  Task_21229_Name = {
    Text = "Người thiếu lửa"
  },
  Task_21230_Desc = {
    Text = "Độ khám phá đạt 100%"
  },
  Task_21230_Name = {
    Text = "Nhìn xuống vùng sương mù"
  },
  Task_21231_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_21231_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21232_Desc = {
    Text = "Hoàn thành khi dùng điểm liên lạc hồi sức sống không quá 1 lần"
  },
  Task_21232_Name = {
    Text = "Người thiếu lửa"
  },
  Task_21233_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21233_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21234_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21234_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21235_Desc = {
    Text = "Trong cuộc chiến cuối cùng, mỗi lượt chơi rút thêm ít nhất 4 lá bài"
  },
  Task_21235_Name = {
    Text = "Vẽ thẻ!"
  },
  Task_21236_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_21236_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21237_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_21237_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21238_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21238_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21239_Desc = {
    Text = "Trong lượt chơi cuối cùng, cơn thịnh nộ bùng phát ít nhất 3 lần trong một lượt"
  },
  Task_21239_Name = {
    Text = "Thuật ảo thuật chết người"
  },
  Task_21240_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21240_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21241_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21241_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21242_Desc = {
    Text = "Khi hoàn thành, mạng sống không được dưới 80%"
  },
  Task_21242_Name = {
    Text = "Thanh lịch và chính xác"
  },
  Task_21243_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_21243_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21244_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_21244_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21245_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_21245_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21246_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_21246_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21247_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_21247_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21248_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_21248_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21249_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_21249_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21250_Desc = {
    Text = "Chiến thắng trong cuộc chiến cuối cùng dưới 15 lượt"
  },
  Task_21250_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21251_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_21251_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21252_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_21252_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21253_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_21253_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21254_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_21254_Name = {
    Text = "Thanh lịch và chính xác"
  },
  Task_21255_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_21255_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21256_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_21256_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21257_Desc = {
    Text = "Gây ít nhất 6000 điểm thương trong một lượt của trận đánh tinh anh"
  },
  Task_21257_Name = {
    Text = "Đòn toàn lực"
  },
  Task_21258_Desc = {
    Text = "Hoàn thành khi mang theo ít nhất một vật bị nguyền rủa"
  },
  Task_21258_Name = {
    Text = "Kho báu kỳ binh"
  },
  Task_21259_Desc = {
    Text = "Cuộc chiến cuối cùng, đánh ra ít nhất 5 thẻ trong 1 lượt"
  },
  Task_21259_Name = {
    Text = "Lượt của tôi"
  },
  Task_21260_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21260_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21261_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21261_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21262_Desc = {
    Text = "Nhận được ít nhất 4 loại khắc ấn khác nhau"
  },
  Task_21262_Name = {
    Text = "Ấn ký linh hồn"
  },
  Task_21263_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21263_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21264_Desc = {
    Text = "Hoàn thành khi mang theo ít nhất 2 vật phẩm"
  },
  Task_21264_Name = {
    Text = "Kho báu kỳ binh"
  },
  Task_21265_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_21265_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21266_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21266_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21267_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21267_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21268_Desc = {
    Text = "Kích hoạt ít nhất 3 thân thể đã được đánh thức"
  },
  Task_21268_Name = {
    Text = "Vô tận ôm ấp"
  },
  Task_21269_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21269_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21270_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_21270_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21271_Desc = {
    Text = "Hoàn thành với ít nhất 5 sáng tạo"
  },
  Task_21271_Name = {
    Text = "Kho báu kỳ binh"
  },
  Task_21272_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_21272_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21273_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_21273_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21274_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21274_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21275_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_21275_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21276_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21276_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21277_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_21277_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21278_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21278_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21279_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21279_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21280_Desc = {
    Text = "Hoàn thành khi thức tỉnh tất cả các thân thể"
  },
  Task_21280_Name = {
    Text = "Vô tận ôm ấp"
  },
  Task_21281_Desc = {
    Text = "Khi hoàn thành, số lượng thẻ triệu chứng không vượt quá 2"
  },
  Task_21281_Name = {
    Text = "Tiết kiệm năng lượng"
  },
  Task_21282_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21282_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21283_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21283_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21284_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21284_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21285_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21285_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21286_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21286_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21287_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21287_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21288_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21288_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21289_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21289_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21290_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21290_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21291_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21291_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21292_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21292_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21293_Desc = {
    Text = "Chiến thắng trong cuộc chiến cuối cùng dưới 15 lượt"
  },
  Task_21293_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21294_Desc = {
    Text = "Trong một lượt ít nhất cộng dồn lá chắn bằng 60% máu tối đa"
  },
  Task_21294_Name = {
    Text = "Thân hình bằng thép"
  },
  Task_21295_Desc = {
    Text = "Hoàn thành khi thức tỉnh tất cả các thân thể"
  },
  Task_21295_Name = {
    Text = "Vô tận ôm ấp"
  },
  Task_21296_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_21296_Name = {
    Text = "Thanh lịch và chính xác"
  },
  Task_21297_Desc = {
    Text = "Trong cuộc chiến cuối cùng, mỗi lượt chơi rút thêm ít nhất 4 lá bài"
  },
  Task_21297_Name = {
    Text = "Vẽ thẻ!"
  },
  Task_21298_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_21298_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21299_Desc = {
    Text = "Chiến thắng trong cuộc chiến cuối cùng dưới 15 lượt"
  },
  Task_21299_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_21300_Desc = {
    Text = "Chít chít, chít chít……!!"
  },
  Task_21300_Name = {
    Text = "Chít chít"
  },
  Task_21301_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_21301_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_21401_Desc = {
    Text = "Chơi ra 50 thẻ bài"
  },
  Task_21401_Name = {
    Text = "thử thách hàng ngày"
  },
  Task_21794_Desc = {
    Text = "Đăng nhập liên tiếp 3 ngày"
  },
  Task_21795_Desc = {
    Text = "Đăng nhập liên tiếp 7 ngày"
  },
  Task_21821_Desc = {
    Text = "Ban đầu có 40 điểm, sau lượt thứ 3, mỗi lượt tiếp theo sẽ bị trừ 5 điểm"
  },
  Task_21821_Name = {
    Text = "Số vòng đấu tinh anh  <size=20><color=#747474>ban đầu 40 điểm, sau 3 vòng đấu mỗi vòng giảm 5 điểm</color></size>"
  },
  Task_21822_Desc = {
    Text = "Điểm ban đầu là 40, sau khi hoàn thành nếu số bước vượt quá 40 bước thì mỗi bước tiếp theo sẽ trừ 2 điểm"
  },
  Task_21822_Name = {
    Text = "Số bước tích lũy  <size=20><color=#747474>Điểm ban đầu là 40, sau khi hoàn thành nếu vượt quá 40 bước thì mỗi bước sẽ trừ 2 điểm</color></size>"
  },
  Task_21823_Desc = {
    Text = "Điểm ban đầu là 600, sau khi vượt qua 12 lượt chơi mỗi lượt sẽ giảm 60 điểm"
  },
  Task_21823_Name = {
    Text = "Số lượt của cuộc chiến cuối cùng  <size=20><color=#747474>Điểm ban đầu là 600, sau 12 lượt mỗi lượt sẽ giảm 60 điểm</color></size>"
  },
  Task_21824_Desc = {
    Text = "Mỗi trận đấu ban đầu có 30 điểm, sau 2 lượt thì mỗi lượt giảm 3 điểm"
  },
  Task_21824_Name = {
    Text = "Số lượt chiến đấu,  <size=20><color=#747474>Mỗi trận bắt đầu với 30 điểm, sau 2 lượt mỗi lượt giảm 3 điểm</color></size>"
  },
  Task_21907_Desc = {
    Text = "Tích lũy thức tỉnh 50 lần"
  },
  Task_21908_Desc = {
    Text = "Tích lũy thức tỉnh 300 lần"
  },
  Task_21914_Desc = {
    Text = "Đạt cấp điều tra 40"
  },
  Task_21915_Desc = {
    Text = "Hoàn thành \"điều tra hành động\" chương 1"
  },
  Task_21916_Desc = {
    Text = "Đạt cấp độ điều tra 30"
  },
  Task_21917_Desc = {
    Text = "Điều tra cấp độ đạt cấp 20"
  },
  Task_21918_Desc = {
    Text = "Đạt cấp điều tra 50"
  },
  Task_22347_Desc = {
    Text = "Đánh bại Yu U Hahi"
  },
  Task_22347_Name = {
    Text = "Mục tiêu"
  },
  Task_22348_Desc = {
    Text = "Augustus, người kiểm soát sự bốc đồng"
  },
  Task_22348_Name = {
    Text = "Mục tiêu"
  },
  Task_22349_Desc = {
    Text = "Bảo vệ công chúa"
  },
  Task_22349_Name = {
    Text = "Mục tiêu"
  },
  Task_22350_Desc = {
    Text = "Chặn đứng Augustus"
  },
  Task_22350_Name = {
    Text = "Mục tiêu"
  },
  Task_22351_Desc = {
    Text = "Hãy tìm Agrippa"
  },
  Task_22351_Name = {
    Text = "Mục tiêu"
  },
  Task_22352_Desc = {
    Text = "Tránh cơn bão cát"
  },
  Task_22352_Name = {
    Text = "Mục tiêu"
  },
  Task_22353_Desc = {
    Text = "Bảo vệ Erika"
  },
  Task_22353_Name = {
    Text = "Mục tiêu"
  },
  Task_22354_Desc = {
    Text = "Tìm thấy Erika"
  },
  Task_22354_Name = {
    Text = "Mục tiêu"
  },
  Task_22355_Desc = {
    Text = "Đi theo Yu U Hahi"
  },
  Task_22355_Name = {
    Text = "Mục tiêu"
  },
  Task_22356_Desc = {
    Text = "Đánh lui đầy tớ đang giận dữ"
  },
  Task_22356_Name = {
    Text = "Mục tiêu"
  },
  Task_22358_Desc = {
    Text = "Tạo lá chắn bằng 50% máu tối đa"
  },
  Task_22358_Name = {
    Text = "Hộ Mệnh Sức Sống II"
  },
  Task_22359_Desc = {
    Text = "Cộng dồn lá chắn bằng 30% máu tối đa"
  },
  Task_22359_Name = {
    Text = "Hộ Vệ Sức Sống I"
  },
  Task_22380_Desc = {
    Text = "Tìm 10 vị trí phân nhánh của chương 5 chính tuyến \"@1@2\""
  },
  Task_22380_Desc2 = {
    Text = "Tìm thấy 10 địa điểm phân tích trong Chương 5 của tuyến chính \"Mắt Bão\""
  },
  Task_22380_Name2 = {
    Text = "Lời thì thầm ẩn bí V"
  },
  Task_22381_Desc = {
    Text = "Hoàn thành 600 lần cổ họng Schwarzschild"
  },
  Task_22381_Name = {
    Text = "Khúc Xạ Thị Giới V"
  },
  Task_22382_Desc = {
    Text = "Hoàn thành 100 lần \"Schwarzschild throat\""
  },
  Task_22382_Name = {
    Text = "Góc nhìn cong II"
  },
  Task_22383_Desc = {
    Text = "Hoàn thành 50 lần thử thách họng Schwarzschild"
  },
  Task_22383_Name = {
    Text = "Khúc cong của tầm nhìn"
  },
  Task_22384_Desc = {
    Text = "Hoàn thành 400 lần \"Vùng Schwarzschild\""
  },
  Task_22384_Name = {
    Text = "Wan Qu Shi Jie IV"
  },
  Task_22385_Desc = {
    Text = "Hoàn thành 200 lần vùng cổ họng Schwarzschild (vùng hấp dẫn)"
  },
  Task_22385_Name = {
    Text = "Góc nhìn uốn cong III"
  },
  Task_22387_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"@1@2\""
  },
  Task_22387_Desc2 = {
    Text = "Hoàn thành sự kiện điều tra \"Mắt Bão\""
  },
  Task_22387_Name2 = {
    Text = "Tam giác bí ẩn"
  },
  Task_22388_Desc = {
    Text = "Trong cuộc điều tra sự kiện \"@1@2\" cảm ứng 3 lần"
  },
  Task_22388_Desc2 = {
    Text = "Trong sự kiện \"Mắt Bão\", cảm ứng 3 lần"
  },
  Task_22388_Name2 = {
    Text = "Hồi âm vô vọng"
  },
  Task_22389_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"Mắt Bão\"độ khó khó khăn"
  },
  Task_22389_Name = {
    Text = "Tam giác mất tích · khó khăn"
  },
  Task_22390_Desc = {
    Text = "Trong sự kiện điều tra \"@1@2\" cảm ứng 7 lần"
  },
  Task_22390_Desc2 = {
    Text = "Trong sự kiện \"Mắt Bão\", cảm ứng 7 lần"
  },
  Task_22390_Name2 = {
    Text = "Vô vọng hồi âm III"
  },
  Task_22391_Desc = {
    Text = "Trong cuộc điều tra sự kiện \"@1@2\" gây cộng hưởng 6 lần"
  },
  Task_22391_Desc2 = {
    Text = "Trong sự kiện \"Mắt Bão\", cảm ứng 6 lần"
  },
  Task_22391_Name2 = {
    Text = "Vang vọng vô vọng II"
  },
  Task_22392_Desc = {
    Text = "Trong sự kiện điều tra \"@1@2\" cảm ứng 10 lần"
  },
  Task_22392_Desc2 = {
    Text = "Trong sự kiện \"Mắt Bão\", cảm ứng 10 lần"
  },
  Task_22392_Name2 = {
    Text = "Vô vọng hồi âm IV"
  },
  Task_23613_Desc = {
    Text = "Tìm Đào Đen Đá"
  },
  Task_23613_Name = {
    Text = "Mục tiêu"
  },
  Task_23614_Desc = {
    Text = "Đi đến trung tâm thương mại"
  },
  Task_23614_Name = {
    Text = "Mục tiêu"
  },
  Task_23615_Desc = {
    Text = "Hoàn thành ghi hình"
  },
  Task_23615_Name = {
    Text = "Mục tiêu"
  },
  Task_23616_Desc = {
    Text = "Quay lại khu vực sự kiện"
  },
  Task_23616_Name = {
    Text = "Mục tiêu"
  },
  Task_23617_Desc = {
    Text = "Tiến hành chụp ảnh"
  },
  Task_23617_Name = {
    Text = "Mục tiêu"
  },
  Task_23618_Desc = {
    Text = "Ra ngoài lấy tư liệu"
  },
  Task_23618_Name = {
    Text = "Mục tiêu"
  },
  Task_23619_Desc = {
    Text = "Đẩy lùi kẻ địch"
  },
  Task_23619_Name = {
    Text = "Mục tiêu"
  },
  Task_23620_Desc = {
    Text = "Thăm trung tâm dưỡng lão"
  },
  Task_23620_Name = {
    Text = "Mục tiêu"
  },
  Task_23646_Desc = {
    Text = "Đã tích lũy được 1000 lần thức tỉnh"
  },
  Task_23708_Desc = {
    Text = "Trận cuối, rút thêm 5 lá bài và nhận 100 điểm"
  },
  Task_23708_Name = {
    Text = "Lấy thêm liên tục  <size=20><color=#747474>cuộc chiến cuối cùng một lượt thêm 5 lá bài</color></size>"
  },
  Task_23709_Desc = {
    Text = "Nhận được 5 sáng tạo vàng, nhận được 100 điểm"
  },
  Task_23709_Name = {
    Text = "Ánh kim lấp lánh  <size=20><color=#747474>nhận được 5 vật tạo vàng</color></size>"
  },
  Task_23710_Desc = {
    Text = "Được 2 vật bị nguyền rủa, được 100 điểm"
  },
  Task_23710_Name = {
    Text = "Kho báu kỳ binh  <size=20><color=#747474>nhận được 2 vật bị nguyền rủa</color></size>"
  },
  Task_23711_Desc = {
    Text = "Cuộc chiến cuối cùng, trong một lượt đánh ra 7 thẻ bài; nhận được 100 điểm"
  },
  Task_23711_Name = {
    Text = "Lượt của tôi  <size=20><color=#747474>trận chiến cuối cùng đánh ra 7 thẻ bài trong một lượt</color></size>"
  },
  Task_23712_Desc = {
    Text = "Thức tỉnh 4 thân thể, nhận được 100 điểm"
  },
  Task_23712_Name = {
    Text = "Thời khắc thức tỉnh  <size=20><color=#747474>Thức tỉnh 4 danh thân thể được đánh thức</color></size>"
  },
  Task_23713_Desc = {
    Text = "Trong cuộc chiến cuối cùng, nhận thêm 3 sức tính toán và 100 điểm trong một lượt"
  },
  Task_23713_Name = {
    Text = "Mưu lược tài tình  <size=20><color=#747474>cuộc chiến cuối cùng một lượt nhận thêm 3 sức tính toán</color></size>"
  },
  Task_23714_Desc = {
    Text = "Trong cuộc chiến cuối cùng, sử dụng điên cuồng bùng phát ít nhất 3 lần trong một lượt để nhận 100 điểm"
  },
  Task_23714_Name = {
    Text = "Thuật Sĩ Tử Thần  <size=20><color=#747474>Sử dụng ít nhất 3 lần cơn thịnh nộ bùng phát trong một lượt của cuộc chiến cuối cùng</color></size>"
  },
  Task_23715_Desc = {
    Text = "Nhận được 11 khắcăng và 100 điểm"
  },
  Task_23715_Name = {
    Text = "Sức mạnh khắcăng  <size=20><color=#747474>nhận được 11 khắcăng</color></size>"
  },
  Task_23716_Desc = {
    Text = "Cuộc chiến cuối cùng, trong một lượt gây 50% thương của thủ lĩnh, nhận được 100 điểm"
  },
  Task_23716_Name = {
    Text = "Đến ô uế  <size=20><color=#747474>trong cuộc chiến cuối cùng gây hơn 50% máu tối đa của trưởng nhóm trong một lượt</color></size>"
  },
  Task_23717_Desc = {
    Text = "Nhận được 9 loại khắcăng, nhận được 100 điểm"
  },
  Task_23717_Name = {
    Text = "Bộ sưu tập khắcăng  <size=20><color=#747474>nhận được 9 khắcăng khác nhau</color></size>"
  },
  Task_23718_Desc = {
    Text = "Cuộc chiến cuối cùng, trong một lượt nhận được lá chắn bằng 80% máu tối đa và nhận được 100 điểm"
  },
  Task_23718_Name = {
    Text = "Thân Hình Thép  <size=20><color=#747474>cuộc chiến cuối cùng nhận lá chắn bằng 80% máu tối đa trong một lượt</color></size>"
  },
  Task_23719_Desc = {
    Text = "Khi hoàn thành, phải có ít nhất 4 thẻ triệu chứng, nhận 100 điểm"
  },
  Task_23719_Name = {
    Text = "Bệnh vào giai đoạn cuối  <size=20><color=#747474>số lượng thẻ triệu chứng khi hoàn thành không ít hơn 4 thẻ bài</color></size>"
  },
  Task_23720_Desc = {
    Text = "Cuộc chiến cuối cùng mỗi lượt đều sử dụng cơn thịnh nộ bùng phát, đạt được 100 điểm"
  },
  Task_23720_Name = {
    Text = "Biểu diễn kinh dị  <size=20><color=#747474>trong mỗi lượt của cuộc chiến cuối cùng, luôn sử dụng cơn thịnh nộ bùng phát</color></size>"
  },
  Task_23721_Desc = {
    Text = "Nhận được 7 món sáng tạo, nhận được 100 điểm"
  },
  Task_23721_Name = {
    Text = "Trở về với đầy ắp  <size=20><color=#747474>nhận được 7 tạo tác</color></size>"
  },
  Task_23722_Desc = {
    Text = "Trong một lượt chiến đấu, tiêu diệt 4 kẻ địch để nhận 100 điểm"
  },
  Task_23722_Name = {
    Text = "Không thể tha thứ  <size=20><color=#747474>Mỗi lượt trong bất kỳ cuộc chiến đấu nào tiêu diệt 4 kẻ thù</color></size>"
  },
  Task_23789_Desc = {
    Text = "Đăng nhập liên tiếp trong 30 ngày"
  },
  Task_23868_Desc = {
    Text = "Giành được 5 chiến thắng trong đối đầu pha"
  },
  Task_23868_Name = {
    Text = "Thưởng hàng tuần"
  },
  Task_23869_Desc = {
    Text = "Xếp hạng Đối Đầu Pha đạt Cao Cấp I"
  },
  Task_23873_Desc = {
    Text = "Cuộc chiến cuối cùng, gây thương trong một lượt bằng 30% máu tối đa của thủ lĩnh, được cộng 100 điểm"
  },
  Task_23873_Name = {
    Text = "Ô uế giáng lâm  <size=20><color=#747474>cuộc chiến cuối cùng gây hơn 30% máu tối đa của trùm trong một lượt hành động</color></size>"
  },
  Task_23874_Desc = {
    Text = "Nhận được 5 vàng hoặc sáng tạo bị nguyền rủa, nhận 100 điểm"
  },
  Task_23874_Name = {
    Text = "Cả tốt lẫn xấu  <size=20><color=#747474>Nhận 5 vàng hoặc vật bị nguyền rủa và đạt 100 điểm</color></size>"
  },
  Task_23875_Desc = {
    Text = "Nhận được 8 loại khắcăng khác nhau và đạt 100 điểm"
  },
  Task_23875_Name = {
    Text = "Bộ sưu tập Khắc Ấn  <size=20><color=#747474>Nhận được 8 loại Khắc Ấn khác nhau</color></size>"
  },
  Task_23876_Desc = {
    Text = "Nhận được 10 khắcăng và 100 điểm"
  },
  Task_23876_Name = {
    Text = "Sức mạnh khắcăng  <size=20><color=#747474>nhận được 10 khắcăng</color></size>"
  },
  Task_23877_Desc = {
    Text = "Cuộc chiến cuối cùng, trong một lượt sử dụng “cơn thịnh nộ bùng phát” ít nhất 4 lần, nhận được 100 điểm"
  },
  Task_23877_Name = {
    Text = "Thuật Sĩ Tử Thần  <size=20><color=#747474>cuộc chiến cuối cùng một lượt sử dụng ít nhất 4 lần cơn thịnh nộ bùng phát</color></size>"
  },
  Task_23878_Desc = {
    Text = "Trong bất kỳ trận chiến nào, tiêu diệt 3 kẻ địch trong 1 lượt để nhận 100 điểm"
  },
  Task_23878_Name = {
    Text = "Không thể tha thứ được  <size=20><color=#747474>Trong một lượt của bất kỳ cuộc chiến đấu nào, tiêu diệt 3 kẻ địch</color></size>"
  },
  Task_23879_Desc = {
    Text = "Nhận được 8 sáng tạo và 100 điểm"
  },
  Task_23879_Name = {
    Text = "Đầy ắp trở về  <size=20><color=#747474>nhận được 8 sáng tạo</color></size>"
  },
  Task_23885_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"{s1}\""
  },
  Task_23886_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"{s1}\""
  },
  Task_23887_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"{s1}\""
  },
  Task_23888_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"{s1}\""
  },
  Task_23889_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"{s1}\""
  },
  Task_23890_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"{s1}\""
  },
  Task_23891_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"{s1}\""
  },
  Task_23892_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"{s1}\""
  },
  Task_23893_Desc = {
    Text = "Hoàn thành duy thức tiềm hành \"Hậu duệ nhợt nhạt\" chế độ bình thường"
  },
  Task_23893_Name = {
    Text = "Phần thưởng hoàn thành"
  },
  Task_23894_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"{s1}\""
  },
  Task_23895_Desc = {
    Text = "Hoàn thành bản ghi đặc nhiệm \"Bóng ma thị trấn mưa\"ở chế độ bình thường"
  },
  Task_23895_Name = {
    Text = "Phần thưởng hoàn thành"
  },
  Task_23896_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"{s1}\""
  },
  Task_24139_Desc = {
    Text = "Hoàn thành với ít nhất 5 sáng tạo"
  },
  Task_24139_Name = {
    Text = "Kho báu kỳ binh"
  },
  Task_24140_Desc = {
    Text = "Cuộc chiến cuối cùng, trong một lượt, đánh ít nhất 6 thẻ bài"
  },
  Task_24140_Name = {
    Text = "Lượt của tôi"
  },
  Task_24141_Desc = {
    Text = "Hoàn thành với ít nhất 5 sáng tạo"
  },
  Task_24141_Name = {
    Text = "Kho báu kỳ binh"
  },
  Task_24142_Desc = {
    Text = "Cuộc chiến cuối cùng, trong một lượt, đánh ít nhất 6 thẻ bài"
  },
  Task_24142_Name = {
    Text = "Lượt của tôi"
  },
  Task_24177_Desc = {
    Text = "Rời khỏi phòng động lực"
  },
  Task_24177_Name = {
    Text = "Mục tiêu"
  },
  Task_24403_Desc = {
    Text = "Đuổi kịp chiếc xe ngựa khả nghi"
  },
  Task_24403_Name = {
    Text = "Mục tiêu"
  },
  Task_24404_Desc = {
    Text = "Tránh sự chú ý của \"N\""
  },
  Task_24404_Name = {
    Text = "Mục tiêu"
  },
  Task_24405_Desc = {
    Text = "Tìm kiếm thư mời \"tên hoa hồng\""
  },
  Task_24405_Name = {
    Text = "Mục tiêu"
  },
  Task_24406_Desc = {
    Text = "Nhập vào mật cảnh nhân tạo, trở về ngày xảy ra sự kiện"
  },
  Task_24406_Name = {
    Text = "Mục tiêu"
  },
  Task_24407_Desc = {
    Text = "Bắt giữ kẻ tình nghi"
  },
  Task_24407_Name = {
    Text = "Mục tiêu"
  },
  Task_24408_Desc = {
    Text = "Đuổi theo hầu gái Gia Lân"
  },
  Task_24408_Name = {
    Text = "Mục tiêu"
  },
  Task_24409_Desc = {
    Text = "Chống lại cuộc tấn công của bóng tối bí ẩn"
  },
  Task_24409_Name = {
    Text = "Mục tiêu"
  },
  Task_24410_Desc = {
    Text = "Chống lại cuộc tấn công của bóng tối mang mặt nạ"
  },
  Task_24410_Name = {
    Text = "Mục tiêu"
  },
  Task_24411_Desc = {
    Text = "Bắt giữ ông Lambert"
  },
  Task_24411_Name = {
    Text = "Mục tiêu"
  },
  Task_24412_Desc = {
    Text = "Đẩy lùi quái vật bị rỗng hóa"
  },
  Task_24412_Name = {
    Text = "Mục tiêu"
  },
  Task_24457_Desc = {
    Text = "Trong cuộc chiến cuối cùng, sử dụng ít nhất 3/4 lần điên cuồng bùng phát trong một lượt, nhận được 50/100 điểm."
  },
  Task_24457_Name = {
    Text = "Thuật ảo chết người<size=20><color=#747474>Sử dụng cơn thịnh nộ bùng phát ít nhất 3 lần trong một lượt ở cuộc chiến cuối cùng</color></size>"
  },
  Task_24458_Desc = {
    Text = "Với 7/9/11 khắcăng, đạt 30/60/100 điểm."
  },
  Task_24458_Name = {
    Text = "Sức mạnh khắc ấn<size=20><color=#747474>nhận được 7 khắc ấn</color></size>"
  },
  Task_24459_Desc = {
    Text = "Nhận được 4/5/6 vật tạo vàng, nhận được 30/60/100 điểm."
  },
  Task_24459_Name = {
    Text = "Vàng lấp lánh<size=20><color=#747474>nhận được 5 món sáng tạo từ vàng</color></size>"
  },
  Task_24460_Desc = {
    Text = "Nhận được 4/5/6 vật tạo vàng, nhận được 30/60/100 điểm."
  },
  Task_24460_Name = {
    Text = "Kim quang lấp lánh<size=20><color=#747474>nhận được 4 sáng tạo vàng</color></size>"
  },
  Task_24461_Desc = {
    Text = "Nhận được 4/5/6 vật sáng tạo vàng hoặc vật sáng tạo bị nguyền rủa, nhận được 30/60/100 điểm."
  },
  Task_24461_Name = {
    Text = "Tốt xấu đều phải <size=20><color=#747474>nhận được 6 vàng hoặc sáng tạo bị nguyền rủa</color></size>"
  },
  Task_24462_Desc = {
    Text = "Nhận được 4/5/6 vật sáng tạo vàng hoặc vật sáng tạo bị nguyền rủa, nhận được 30/60/100 điểm."
  },
  Task_24462_Name = {
    Text = "Tốt xấu đều phải <size=20><color=#747474>nhận được 4 vàng hoặc vật bị nguyền rủa</color></size>"
  },
  Task_24463_Desc = {
    Text = "Nhận được 4/5/6 vật sáng tạo vàng hoặc vật sáng tạo bị nguyền rủa, nhận được 30/60/100 điểm."
  },
  Task_24463_Name = {
    Text = "Tốt xấu đều phải <size=20><color=#747474>nhận được 5 vàng hoặc sáng tạo bị nguyền rủa</color></size>"
  },
  Task_24464_Desc = {
    Text = "Với 7/9/11 khắcăng, đạt 30/60/100 điểm."
  },
  Task_24464_Name = {
    Text = "Lực Khắc Ấn<size=20><color=#747474>đã nhận 9 khắcăng</color></size>"
  },
  Task_24465_Desc = {
    Text = "Kích hoạt 3/4 thân thể được đánh thức, nhận được 50/100 điểm."
  },
  Task_24465_Name = {
    Text = "Thời khắc thức tỉnh<size=20><color=#747474>thức tỉnh 3 thể xác được đánh thức</color></size>"
  },
  Task_24466_Desc = {
    Text = "Cuộc chiến cuối cùng, mỗi lượt đánh ra 5/7/9 thẻ bài, nhận được 30/60/100 điểm."
  },
  Task_24466_Name = {
    Text = "Lượt của tôi<size=20><color=#747474>cuộc chiến cuối cùng: đánh ra 9 thẻ bài trong một lượt</color></size>"
  },
  Task_24467_Desc = {
    Text = "Kích hoạt 3/4 thân thể được đánh thức, nhận được 50/100 điểm."
  },
  Task_24467_Name = {
    Text = "Thời khắc thức tỉnh<size=20><color=#747474>thức tỉnh 4 thân thể thức tỉnh</color></size>"
  },
  Task_24468_Desc = {
    Text = "Trong cuộc chiến cuối cùng, sử dụng ít nhất 3/4 lần điên cuồng bùng phát trong một lượt, nhận được 50/100 điểm."
  },
  Task_24468_Name = {
    Text = "Thuật Sĩ Tử Thần<size=20><color=#747474>Sử dụng cơn thịnh nộ bùng phát ít nhất 4 lần trong lượt của cuộc chiến cuối cùng</color></size>"
  },
  Task_24469_Desc = {
    Text = "Cuộc chiến cuối cùng mỗi vòng nhận thêm 2/3/4 sức tính toán, nhận 30/60/100 điểm."
  },
  Task_24469_Name = {
    Text = "Thần cơ diệu toán<size=20><color=#747474>cuộc chiến cuối cùng, nhận thêm 2 sức tính toán mỗi lượt</color></size>"
  },
  Task_24470_Desc = {
    Text = "Cuộc chiến cuối cùng mỗi vòng nhận thêm 2/3/4 sức tính toán, nhận 30/60/100 điểm."
  },
  Task_24470_Name = {
    Text = "Thần cơ diệu toán<size=20><color=#747474>trận chiến cuối cùng nhận thêm 3 sức tính toán</color></size>"
  },
  Task_24471_Desc = {
    Text = "Khi hoàn thành, số lượng thẻ triệu chứng không ít hơn 3 đến 4Trương, nhận được 50/100 điểm."
  },
  Task_24471_Name = {
    Text = "Bệnh nặng <size=20><color=#747474>số lượng thẻ bài triệu chứng khi hoàn thành ít nhất 3</color></size>"
  },
  Task_24472_Desc = {
    Text = "Khi hoàn thành, số lượng thẻ triệu chứng không ít hơn 3 đến 4Trương, nhận được 50/100 điểm."
  },
  Task_24472_Name = {
    Text = "Bệnh vào giai đoạn cuối<size=20><color=#747474>số lượng thẻ triệu chứng khi hoàn thành không ít hơn 4 lá</color></size>"
  },
  Task_24473_Desc = {
    Text = "Cuộc chiến cuối cùng mỗi vòng nhận thêm 2/3/4 sức tính toán, nhận 30/60/100 điểm."
  },
  Task_24473_Name = {
    Text = "Thần cơ diệu toán<size=20><color=#747474>cuộc chiến cuối cùng mỗi lượt nhận thêm 4 sức tính toán</color></size>"
  },
  Task_24474_Desc = {
    Text = "Khi hoàn thành, số lượng thẻ của bất kỳ thân thể được đánh thức nào không vượt quá tối đa 2 hoặc 1, nhận được 50/100 điểm."
  },
  Task_24474_Name = {
    Text = "<size=20><color=#747474>bị bỏ qua khi hoàn thành, một thân thể được đánh thức không có nhiều hơn 2 thẻ bài</color></size>"
  },
  Task_24475_Desc = {
    Text = "Trong cuộc chiến cuối cùng, sử dụng cơn thịnh nộ bùng phát liên tiếp trong 3/4/5 lượt để nhận được 30/60/100 điểm."
  },
  Task_24475_Name = {
    Text = "Sự biểu diễn kinh dị<size=20><color=#747474>Trong cuộc chiến cuối cùng, sử dụng điên cuồng bùng phát liên tục trong 5 lượt</color></size>"
  },
  Task_24476_Desc = {
    Text = "Khi hoàn thành, số lượng thẻ của bất kỳ thân thể được đánh thức nào không vượt quá tối đa 2 hoặc 1, nhận được 50/100 điểm."
  },
  Task_24476_Name = {
    Text = "Bị bỏ qua<size=20><color=#747474>sau khi hoàn thành, mỗi thân thể được đánh thức chỉ có tối đa 1 thẻ bài</color></size>"
  },
  Task_24477_Desc = {
    Text = "Trong cuộc chiến cuối cùng, sử dụng cơn thịnh nộ bùng phát liên tiếp trong 3/4/5 lượt để nhận được 30/60/100 điểm."
  },
  Task_24477_Name = {
    Text = "Biểu diễn kinh dị<size=20><color=#747474>cuộc chiến cuối cùng sử dụng điên cuồng bùng phát trong 4 lượt</color></size>"
  },
  Task_24478_Desc = {
    Text = "Nhận được 6/7/8 vật phẩm sáng tạo, nhận được 30/60/100 điểm."
  },
  Task_24478_Name = {
    Text = "Trở về với đầy túi<size=20><color=#747474>nhận được 7 sáng tạo</color></size>"
  },
  Task_24479_Desc = {
    Text = "Nhận được 6/7/8 vật phẩm sáng tạo, nhận được 30/60/100 điểm."
  },
  Task_24479_Name = {
    Text = "Trở về với đầy tay<size=20><color=#747474>nhận được 6 sáng tạo</color></size>"
  },
  Task_24480_Desc = {
    Text = "Cuộc chiến cuối cùng trong một lượt chơi nhận được lá chắn tương đương 25%/50%/75% sức sống tối đa, nhận được 30/60/100 điểm."
  },
  Task_24480_Name = {
    Text = "Thân thép<size=20><color=#747474>cuộc chiến cuối cùng nhận được lá chắn bằng 25% máu tối đa mỗi lượt</color></size>"
  },
  Task_24481_Desc = {
    Text = "Cuộc chiến cuối cùng, trong một lượt gây thương tích bằng 20%/30%/40% máu tối đa của thủ lĩnh, nhận 30/60/100 điểm."
  },
  Task_24481_Name = {
    Text = "Sự ô uế giáng xuống<size=20><color=#747474>gây thương vượt 30% máu tối đa của thủ lĩnh trong một lượt</color></size>"
  },
  Task_24482_Desc = {
    Text = "Nhận được 6/7/8 vật phẩm sáng tạo, nhận được 30/60/100 điểm."
  },
  Task_24482_Name = {
    Text = "Về với đầy tay<size=20><color=#747474>nhận được 8 sáng tạo</color></size>"
  },
  Task_24483_Desc = {
    Text = "Nhận được 5/7/9 loại khắcăng khác nhau và đạt 30/60/100 điểm."
  },
  Task_24483_Name = {
    Text = "Bộ sưu tập Dấu khắc<size=20><color=#747474>Thu thập 9 dấu khắc khác nhau</color></size>"
  },
  Task_24484_Desc = {
    Text = "Nhận được 5/7/9 loại khắcăng khác nhau và đạt 30/60/100 điểm."
  },
  Task_24484_Name = {
    Text = "Khắcăng bộ sưu tập<size=20><color=#747474>nhận được 5 khắcăng khác nhau</color></size>"
  },
  Task_24485_Desc = {
    Text = "Nhận được 5/7/9 loại khắcăng khác nhau và đạt 30/60/100 điểm."
  },
  Task_24485_Name = {
    Text = "Khắcăng bộ sưu tập<size=20><color=#747474>nhận được 7 khắcăng khác nhau</color></size>"
  },
  Task_24486_Desc = {
    Text = "Nhận được 4/5/6 vật tạo vàng, nhận được 30/60/100 điểm."
  },
  Task_24486_Name = {
    Text = "Vàng lấp lánh<size=20><color=#747474>nhận được 6 vật sáng tạo vàng</color></size>"
  },
  Task_24487_Desc = {
    Text = "Trong cuộc chiến cuối cùng, sử dụng cơn thịnh nộ bùng phát liên tiếp trong 3/4/5 lượt để nhận được 30/60/100 điểm."
  },
  Task_24487_Name = {
    Text = "Biểu diễn kinh hoàng<size=20><color=#747474>cuộc chiến cuối cùng trong 3 lượt liên tiếp đều sử dụng cơn thịnh nộ bùng phát</color></size>"
  },
  Task_24488_Desc = {
    Text = "Nhận 2/3 vật bị nguyền rủa và 50/100 điểm."
  },
  Task_24488_Name = {
    Text = "Kỳ binh bí tàng<size=20><color=#747474>nhận được 3 vật sáng tạo bị nguyền rủa</color></size>"
  },
  Task_24489_Desc = {
    Text = "Nhận 2/3 vật bị nguyền rủa và 50/100 điểm."
  },
  Task_24489_Name = {
    Text = "Kho báu binh kỳ đặc biệt<size=20><color=#747474>nhận được 2 vật bị nguyền rủa</color></size>"
  },
  Task_24490_Desc = {
    Text = "Cuộc chiến cuối cùng trong một lượt chơi nhận được lá chắn tương đương 25%/50%/75% sức sống tối đa, nhận được 30/60/100 điểm."
  },
  Task_24490_Name = {
    Text = "Thân thép<size=20><color=#747474>cuộc chiến cuối cùng tạo ra lá chắn bằng 50% máu tối đa mỗi lượt</color></size>"
  },
  Task_24491_Desc = {
    Text = "Cuộc chiến cuối cùng, mỗi lượt đánh ra 5/7/9 thẻ bài, nhận được 30/60/100 điểm."
  },
  Task_24491_Name = {
    Text = "Lượt của tôi<size=20><color=#747474>cuộc chiến cuối cùng đánh ra 7 thẻ bài trong một lượt</color></size>"
  },
  Task_24492_Desc = {
    Text = "Với 7/9/11 khắcăng, đạt 30/60/100 điểm."
  },
  Task_24492_Name = {
    Text = "Lực của khắcăng<size=20><color=#747474>nhận được 11 dấu khắcăng</color></size>"
  },
  Task_24493_Desc = {
    Text = "Cuộc chiến cuối cùng, mỗi lượt đánh ra 5/7/9 thẻ bài, nhận được 30/60/100 điểm."
  },
  Task_24493_Name = {
    Text = "Lượt của tôi<size=20><color=#747474>cuộc chiến cuối cùng đánh ra 5 thẻ bài trong một lượt duy nhất</color></size>"
  },
  Task_24494_Desc = {
    Text = "Cuộc chiến cuối cùng, trong một lượt gây thương tích bằng 20%/30%/40% máu tối đa của thủ lĩnh, nhận 30/60/100 điểm."
  },
  Task_24494_Name = {
    Text = "Đến sự ô uế<size=20><color=#747474>cuộc chiến cuối cùng gây hơn 40% thương của máu tối đa trưởng nhóm</color></size>"
  },
  Task_24495_Desc = {
    Text = "Cuộc chiến cuối cùng trong một lượt chơi nhận được lá chắn tương đương 25%/50%/75% sức sống tối đa, nhận được 30/60/100 điểm."
  },
  Task_24495_Name = {
    Text = "Thân thép<size=20><color=#747474>cuộc chiến cuối cùng cấp lá chắn bằng 75% máu tối đa</color></size>"
  },
  Task_24496_Desc = {
    Text = "Cuộc chiến cuối cùng, trong một lượt gây thương tích bằng 20%/30%/40% máu tối đa của thủ lĩnh, nhận 30/60/100 điểm."
  },
  Task_24496_Name = {
    Text = "Đến của ô uế<size=20><color=#747474>Trong cuộc chiến cuối cùng, gây hơn 20% thương của máu tối đa thủ lĩnh trong một lượt</color></size>"
  },
  Task_24497_Desc = {
    Text = "Trong bất kỳ lượt chiến đấu nào, tiêu diệt 3/4 kẻ địch, nhận được 50/100 điểm."
  },
  Task_24497_Name = {
    Text = "Không thể tha thứ<size=20><color=#747474>trong một lượt chiến đấu tiêu diệt 4 kẻ địch</color></size>"
  },
  Task_24498_Desc = {
    Text = "Trận chiến cuối cùng mỗi lượt rút thêm 4/5/6 lá bài, nhận được 30/60/100 điểm."
  },
  Task_24498_Name = {
    Text = "Lấy thêm nhiều lần<size=20><color=#747474>Trong cuộc chiến cuối cùng, mỗi lượt sẽ được rút thêm 5 lá bài</color></size>"
  },
  Task_24499_Desc = {
    Text = "Trận chiến cuối cùng mỗi lượt rút thêm 4/5/6 lá bài, nhận được 30/60/100 điểm."
  },
  Task_24499_Name = {
    Text = "Rút thêm lần nữa<size=20><color=#747474>cuộc chiến cuối cùng một lượt rút thêm 4 lá bài</color></size>"
  },
  Task_24500_Desc = {
    Text = "Trong bất kỳ lượt chiến đấu nào, tiêu diệt 3/4 kẻ địch, nhận được 50/100 điểm."
  },
  Task_24500_Name = {
    Text = "Không thể tha thứ<size=20><color=#747474>trong bất kỳ chiến đấu nào, tiêu diệt 3 kẻ địch trong một lượt</color></size>"
  },
  Task_24501_Desc = {
    Text = "Trận chiến cuối cùng mỗi lượt rút thêm 4/5/6 lá bài, nhận được 30/60/100 điểm."
  },
  Task_24501_Name = {
    Text = "Lấy thêm liên tục<size=20><color=#747474>cuộc chiến cuối cùng một lượt rút thêm 6 lá bài</color></size>"
  },
  Task_24534_Desc = {
    Text = "Bắt kịp Ramona"
  },
  Task_24534_Name = {
    Text = "Mục tiêu"
  },
  Task_25013_Desc = {
    Text = "Hoàn thành bản ghi đặc nhiệm \"Tụng Ca Hoa Hồng\" chế độ bình thường"
  },
  Task_25013_Name = {
    Text = "Phần thưởng hoàn thành"
  },
  Task_25014_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"{s1}\""
  },
  Task_25015_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"{s1}\""
  },
  Task_25016_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"{s1}\""
  },
  Task_25017_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"{s1}\""
  },
  Task_25018_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"{s1}\""
  },
  Task_25019_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"{s1}\""
  },
  Task_25020_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"{s1}\""
  },
  Task_25021_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"{s1}\""
  },
  Task_25022_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"{s1}\""
  },
  Task_25023_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"{s1}\""
  },
  Task_25024_Desc = {
    Text = "Hoàn thành duy thức tiềm hành \"một bước chiểu xa\" chế độ bình thường"
  },
  Task_25024_Name = {
    Text = "Phần thưởng hoàn thành"
  },
  Task_25164_Desc = {
    Text = "Theo dõi Ramona"
  },
  Task_25164_Name = {
    Text = "Mục tiêu"
  },
  Task_25167_Desc = {
    Text = "Bước vào biệt thự huyền bí"
  },
  Task_25167_Name = {
    Text = "Mục tiêu"
  },
  Task_25168_Desc = {
    Text = "Quay lại buồng riêng của bà Sorrel"
  },
  Task_25168_Name = {
    Text = "Mục tiêu"
  },
  Task_34729_Desc = {
    Text = "Bí ẩn kịch bản · siêu việt"
  },
  Task_34731_Desc = {
    Text = "Bí ẩn kịch bản·hỗn loạn"
  },
  Task_34734_Desc = {
    Text = "Bản ghi đặc nhiệm"
  },
  Task_34737_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"{s1}\""
  },
  Task_34740_Desc = {
    Text = "Bí ẩn kịch bản·biển sâu"
  },
  Task_34741_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"{s1}\""
  },
  Task_34742_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"{s1}\""
  },
  Task_34743_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"{s1}\""
  },
  Task_34744_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"{s1}\""
  },
  Task_34745_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"{s1}\""
  },
  Task_34746_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"{s1}\""
  },
  Task_34748_Desc = {
    Text = "Bí ẩn kịch bản·thịt máu"
  },
  Task_34750_Desc = {
    Text = "Hoàn thành tất cả nhiệm vụ trong \"Đặc vụ Kỷ lục\""
  },
  Task_34942_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong \"bí ẩn kịch bản\" tích lũy sử dụng 25 lần lệnh khóa"
  },
  Task_34943_Desc = {
    Text = "Trong \"bí ẩn kịch bản\", tích lũy nhận được 50 lá \"phôi thai\""
  },
  Task_34944_Desc = {
    Text = "Trong \"bí ẩn kịch bản\", tích lũy số lần vào vòng siêu việt 10 lần"
  },
  Task_34945_Desc = {
    Text = "Trong \"bí ẩn kịch bản\", sử dụng tấn công bằng râu chạm tích lũy 250 lần"
  },
  Task_34946_Desc = {
    Text = "Sử dụng thân thể được đánh thức của giới vực thịt máu để chiến thắng 1 lần trong \"bí ẩn kịch bản\""
  },
  Task_34947_Desc = {
    Text = "Sử dụng thân thể được đánh thức siêu giới vực để giành chiến thắng một lần trong \"bí ẩn kịch bản\""
  },
  Task_34948_Desc = {
    Text = "Trong \"bí ẩn kịch bản\", tích lũy sử dụng râu chạm để tấn công 100 lần"
  },
  Task_34949_Desc = {
    Text = "Trong \"bí ẩn kịch bản\", tích lũy vào vòng siêu việt 5 lần"
  },
  Task_34950_Desc = {
    Text = "Sử dụng thân thể được đánh thức của vùng giới sâu thẳm để giành chiến thắng 1 lần trong \"bí ẩn kịch bản\""
  },
  Task_34951_Desc = {
    Text = "Trong \"bí ẩn kịch bản\", tích lũy nhận được 15 \"phôi thai\""
  },
  Task_34952_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong giới vực hỗn loạn để sử dụng tích lũy 10 lần lệnh khóa trong \"bí ẩn kịch bản\""
  },
  Task_34953_Desc = {
    Text = "Sử dụng thân thể được đánh thức của giới vực hỗn loạn để thắng 1 lần trong \"bí ẩn kịch bản\""
  },
  Task_35262_Desc = {
    Text = "Hoàn thành tất cả nhiệm vụ giới vực trong \"bí ẩn kịch bản\""
  },
  Task_35263_Desc = {
    Text = "Chương cuối"
  },
  Task_35808_Desc = {
    Text = "Lũy kế tiêu thụ 500 triệu quyền vàng hồng"
  },
  Task_35808_Name = {
    Text = "Tiêu tiền như nước"
  },
  Task_36141_Desc = {
    Text = "Trong cuộc điều tra sự kiện \"@1@2\" gây cộng hưởng 6 lần"
  },
  Task_36141_Desc2 = {
    Text = "Trong sự kiện \"sao sao đảo ngược\" cảm ứng 6 lần"
  },
  Task_36141_Name2 = {
    Text = "Khát khao hồi âm II"
  },
  Task_36142_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"@1@2\""
  },
  Task_36142_Desc2 = {
    Text = "Hoàn thành sự kiện điều tra \"các vì sao đảo ngược\""
  },
  Task_36142_Name2 = {
    Text = "Từ chối triệu hồi"
  },
  Task_36143_Desc = {
    Text = "Trong cuộc điều tra sự kiện \"@1@2\" cảm ứng 3 lần"
  },
  Task_36143_Desc2 = {
    Text = "Trong sự kiện \"sao sao đảo ngược\" cảm ứng ba lần"
  },
  Task_36143_Name2 = {
    Text = "Sự khao khát vang vọng"
  },
  Task_36144_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"sao sao đảo ngược\"độ khó cao"
  },
  Task_36144_Name = {
    Text = "Từ chối gọi khó khăn"
  },
  Task_36145_Desc = {
    Text = "Trong sự kiện điều tra \"@1@2\" cộng hưởng 8 lần"
  },
  Task_36145_Desc2 = {
    Text = "Trong sự kiện \"sao sao đảo ngược\", gây cộng hưởng 8 lần"
  },
  Task_36145_Name2 = {
    Text = "Khát vọng hồi âm III"
  },
  Task_36155_Desc = {
    Text = "Hỗ trợ thuyền trưởng lái"
  },
  Task_36155_Name = {
    Text = "Mục tiêu"
  },
  Task_36156_Desc = {
    Text = "Vào phòng động lực"
  },
  Task_36156_Name = {
    Text = "Mục tiêu"
  },
  Task_36157_Desc = {
    Text = "Tìm đồng đội"
  },
  Task_36157_Name = {
    Text = "Mục tiêu"
  },
  Task_36158_Desc = {
    Text = "Chống lại đợt tấn công của kẻ xâm nhập biển cả"
  },
  Task_36158_Name = {
    Text = "Mục tiêu"
  },
  Task_36159_Desc = {
    Text = "Lại gần \"Thánh Nhi\""
  },
  Task_36159_Name = {
    Text = "Mục tiêu"
  },
  Task_36160_Desc = {
    Text = "Chống lại tấn công"
  },
  Task_36160_Name = {
    Text = "Mục tiêu"
  },
  Task_36161_Desc = {
    Text = "Trở lại buồng lái"
  },
  Task_36161_Name = {
    Text = "Mục tiêu"
  },
  Task_36162_Desc = {
    Text = "Đẩy lùi kẻ địch"
  },
  Task_36162_Name = {
    Text = "Mục tiêu"
  },
  Task_36163_Desc = {
    Text = "Đi đến buồng lái"
  },
  Task_36163_Name = {
    Text = "Mục tiêu"
  },
  Task_36164_Desc = {
    Text = "Đi đến phòng động lực"
  },
  Task_36164_Name = {
    Text = "Mục tiêu"
  },
  Task_36169_Desc = {
    Text = "Đi đến quảng trường"
  },
  Task_36169_Name = {
    Text = "Mục tiêu"
  },
  Task_36316_Desc = {
    Text = "Khi hoàn thành, số lượng thẻ triệu chứng không vượt quá 2"
  },
  Task_36316_Name = {
    Text = "Tiết kiệm năng lượng"
  },
  Task_36317_Desc = {
    Text = "Khi hoàn thành, số lượng thẻ triệu chứng không vượt quá 2"
  },
  Task_36317_Name = {
    Text = "Tiết kiệm năng lượng"
  },
  Task_36359_Desc = {
    Text = "Tìm 10 vị trí tách ra của Chương Chính Thứ Sáu \"@1@2\""
  },
  Task_36359_Desc2 = {
    Text = "Tìm 10 điểm phân tích trong chương chính thứ sáu \"sao sao đảo ngược\""
  },
  Task_36359_Name2 = {
    Text = "Lời thì thầm ẩn giấu VI"
  },
  Task_36622_Desc = {
    Text = "Người dân bị ảnh hưởng bởi dị biến"
  },
  Task_36622_Name = {
    Text = "Mục tiêu"
  },
  Task_36623_Desc = {
    Text = "Đi đến cung tẩm của Vanda"
  },
  Task_36623_Name = {
    Text = "Mục tiêu"
  },
  Task_36624_Desc = {
    Text = "Đẩy lùi quái vật dung dịch ăn mòn"
  },
  Task_36624_Name = {
    Text = "Mục tiêu"
  },
  Task_36842_Desc = {
    Text = "Hoàn thành duy thức tiềm hành \"Mọi thứ vẫn như cũ\"ở chế độ thông thường"
  },
  Task_36842_Name = {
    Text = "Phần thưởng hoàn thành"
  },
  Task_36864_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"{s1}\""
  },
  Task_36872_Desc = {
    Text = "Mỗi lần sử dụng thể linh tri thức khẩn cấp, điểm điều tra giảm 30%"
  },
  Task_36872_Name = {
    Text = "Ý niệm thâm hụt  <size=20><color=#747474>Mỗi lần sử dụng linh tri thức khẩn cấp, điểm đánh giá điều tra giảm 30%</color></size>"
  },
  Task_38749_Desc = {
    Text = "Tiêu thụ 180 linh phì peptide"
  },
  Task_38750_Desc = {
    Text = "Sử dụng hỗ trợ 3 lần"
  },
  Task_38751_Desc = {
    Text = "Thích cựu sinh viên 10 lần"
  },
  Task_38752_Desc = {
    Text = "Hoàn thành thử thách hàng tuần"
  },
  Task_38753_Desc = {
    Text = "Gửi đi 3 lần"
  },
  Task_38754_Desc = {
    Text = "Hoàn thành tất cả các nhiệm vụ huấn luyện"
  },
  Task_38755_Desc = {
    Text = "Thắng Giấc mơ thám hiểm 1 lần"
  },
  Task_38814_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong giới vực hỗn loạn để chiến thắng 1 lần tại \"thành phố trên hồ\""
  },
  Task_38815_Desc = {
    Text = "Sử dụng thân thể được đánh thức từ giới vực hỗn loạn để chiến thắng 5 lần trong \"Thành Phố Trên Hồ\""
  },
  Task_38816_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong giới vực hỗn loạn tại \"Thành phố trên hồ\"để giành chiến thắng 3 lần"
  },
  Task_38817_Desc = {
    Text = "Thành phố trên hồ·thịt máu"
  },
  Task_38818_Desc = {
    Text = "Hoàn thành \"Khải Huyền\" bất kỳ ký ức nào"
  },
  Task_38819_Desc = {
    Text = "Hoàn thành \"một đoạn ký ức\" bất kỳ kỷ niệm"
  },
  Task_38820_Desc = {
    Text = "Sử dụng thân thể được đánh thức siêu không gian giới vực để chiến thắng 5 lần trong \"Thành Phố Trên Hồ\""
  },
  Task_38821_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong siêu không gian giới vực để chiến thắng 3 lần trong \"Thành Phố Trên Hồ\""
  },
  Task_38822_Desc = {
    Text = "Sử dụng thân thể được đánh thức siêu không gian giới vực để chiến thắng 1 lần trong \"Thành Phố Trên Hồ\""
  },
  Task_38823_Desc = {
    Text = "Thành phố giữa hồ · biển sâu"
  },
  Task_38824_Desc = {
    Text = "Hoàn thành \"Tiểu Thương Lan\" bất kỳ ký ức nào"
  },
  Task_38825_Desc = {
    Text = "Hoàn thành \"Giếng\" bất kỳ truy niệm"
  },
  Task_38826_Desc = {
    Text = "duy thức tiềm hành"
  },
  Task_38827_Desc = {
    Text = "Sử dụng thân thể được đánh thức vùng giới sâu thẳm để chiến thắng 3 lần trong \"Thành Phố Trên Hồ\""
  },
  Task_38828_Desc = {
    Text = "Sử dụng thân thể được đánh thức vùng giới sâu thẳm để chiến thắng 5 lần trong \"thành phố trên hồ\""
  },
  Task_38829_Desc = {
    Text = "Sử dụng thân thể được đánh thức vùng giới biển sâu trong \"Thành Phố Trên Hồ\"để chiến thắng 1 lần"
  },
  Task_38830_Desc = {
    Text = "Hoàn thành \"Hải Thị Thần Lâu\" bất kỳ truy ức"
  },
  Task_38831_Desc = {
    Text = "Thành phố trong hồ, Hỗn loạn"
  },
  Task_38832_Desc = {
    Text = "Hoàn thành \"chân thực\" bất kỳ ký ức nào"
  },
  Task_38833_Desc = {
    Text = "Thành phố trên hồ · Hoài niệm"
  },
  Task_38834_Desc = {
    Text = "Hoàn thành \"Thành vàng\" bất kỳ truy niệm"
  },
  Task_38835_Desc = {
    Text = "Sử dụng thân thể được đánh thức của giới vực thịt máu để chiến thắng 1 lần trong \"Thành Phố Trên Hồ\""
  },
  Task_38836_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong giới vực thịt máu để chiến thắng 5 lần trong \"Thành Phố Trong Hồ\""
  },
  Task_38837_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong giới vực thịt máu để chiến thắng ở \"Thành Phố Trên Hồ\" 3 lần"
  },
  Task_38838_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"{s1}\""
  },
  Task_38839_Desc = {
    Text = "Thành phố trên hồ·siêu việt"
  },
  Task_38840_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"{s1}\""
  },
  Task_39279_Desc = {
    Text = "Mỗi lần sử dụng 1 Linh Tri Thức Khẩn Cấp, điểm đánh giá điều tra giảm 20% .(Số lần đã sử dụng:{s1})"
  },
  Task_39279_Name = {
    Text = "Cứu viện ảo cảnh<size=20><color=#747474>Mỗi lần sử dụng 1 linh tri thức ứng cấp, điểm đánh giá điều tra giảm 20% </color></size>"
  },
  Task_40465_Desc = {
    Text = "Khi kích hoạt từ 1 đến 3 lần kháng cự tử vong, bạn sẽ nhận được 100/300/500 điểm."
  },
  Task_40465_Name = {
    Text = "Lằn ranh sinh tử<size=20><color=#747474>kích hoạt 1 lần kháng cự tử vong</color></size>"
  },
  Task_40466_Desc = {
    Text = "Khi kích hoạt từ 1 đến 3 lần kháng cự tử vong, bạn sẽ nhận được 100/300/500 điểm."
  },
  Task_40466_Name = {
    Text = "Lằn ranh sinh tử<size=20><color=#747474>kích hoạt 'kháng cự tử vong' từ 3 lần trở lên</color></size>"
  },
  Task_40467_Desc = {
    Text = "Khi kích hoạt từ 1 đến 3 lần kháng cự tử vong, bạn sẽ nhận được 100/300/500 điểm."
  },
  Task_40467_Name = {
    Text = "Lằn ranh sinh tử<size=20><color=#747474>kích hoạt 2 lần kháng cự tử vong</color></size>"
  },
  Task_40468_Desc = {
    Text = "Có 5/6/7/8 vật phẩm, nhận được 250/500/750/1000 điểm."
  },
  Task_40468_Name = {
    Text = "Thực tướng sưu la <size=20><color=#747474>có 5 sáng tạo</color></size>"
  },
  Task_40469_Desc = {
    Text = "Có 5/6/7/8 vật phẩm, nhận được 250/500/750/1000 điểm."
  },
  Task_40469_Name = {
    Text = "Bộ sưu tập Thực Tướng<size=20><color=#747474>có 7 sáng tạo</color></size>"
  },
  Task_40470_Desc = {
    Text = "Có 5/6/7/8 vật phẩm, nhận được 250/500/750/1000 điểm."
  },
  Task_40470_Name = {
    Text = "Thực Tướng Tìm Kiếm<size=20><color=#747474>có 6 sáng tạo</color></size>"
  },
  Task_40471_Desc = {
    Text = "Cuộc chiến cuối cùng 11/10/9/8 lượt, giành được 250/500/750/1000\n/1000 điểm."
  },
  Task_40471_Name = {
    Text = "Chìm Mơ Tật Đi<size=20><color=#747474>đánh bại thủ lĩnh trong vòng 8 lượt</color></size>"
  },
  Task_40472_Desc = {
    Text = "Cuộc chiến cuối cùng 11/10/9/8 lượt, giành được 250/500/750/1000\n/1000 điểm."
  },
  Task_40472_Name = {
    Text = "Chìm Mơ Tật Đi<size=20><color=#747474>đánh bại thủ lĩnh trong vòng 8 lượt</color></size>"
  },
  Task_40473_Desc = {
    Text = "Cuộc chiến cuối cùng 11/10/9/8 lượt, giành được 250/500/750/1000\n/1000 điểm."
  },
  Task_40473_Name = {
    Text = "Đi nhanh trong giấc mơ<size=20><color=#747474>khiến boss thất bại trong vòng 9 lượt</color></size>"
  },
  Task_40474_Desc = {
    Text = "Cuộc chiến cuối cùng 11/10/9/8 lượt, giành được 250/500/750/1000\n/1000 điểm."
  },
  Task_40474_Name = {
    Text = "Đi nhanh trong giấc mơ<size=20><color=#747474>đánh bại trùm trong vòng 10 lượt</color></size>"
  },
  Task_40475_Desc = {
    Text = "Cuộc chiến cuối cùng 11/10/9/8 lượt, giành được 250/500/750/1000\n/1000 điểm."
  },
  Task_40475_Name = {
    Text = "Bước Nhanh Trong Mơ<size=20><color=#747474>đánh bại thủ lĩnh trong vòng 11 lượt</color></size>"
  },
  Task_40476_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng, được 1000 điểm."
  },
  Task_40476_Name = {
    Text = "Đỉnh Mộng Giới Bia<size=20><color=#747474>đánh bại thủ lĩnh</color></size>"
  },
  Task_41334_Desc = {
    Text = "Đẩy lùi Lãnh đạo {s1}"
  },
  Task_41334_Name = {
    Text = "Mục tiêu"
  },
  Task_41367_Desc = {
    Text = "Hoàn thành \"điều tra hành động\" chương 3"
  },
  Task_41368_Desc = {
    Text = "Hoàn thành \"điều tra hành động\" chương 5"
  },
  Task_41369_Desc = {
    Text = "Hoàn thành \"điều tra hành động\" chương 4"
  },
  Task_41370_Desc = {
    Text = "Hoàn thành \"điều tra hành động\" chương 2"
  },
  Task_41371_Desc = {
    Text = "Giá trị đặc huấn đạt mốc lần đầu tiên 325"
  },
  Task_41372_Desc = {
    Text = "Điểm huấn luyện đạt lần đầu 350"
  },
  Task_41373_Desc = {
    Text = "Giá trị đặc huấn đạt lần đầu tiên 225"
  },
  Task_41374_Desc = {
    Text = "Giá trị huấn luyện đạt 300 lần đầu"
  },
  Task_41375_Desc = {
    Text = "Giá trị huấn luyện đạt 100 lần đầu"
  },
  Task_41376_Desc = {
    Text = "Đạt giá trị huấn luyện 150 lần đầu tiên"
  },
  Task_41377_Desc = {
    Text = "Đạt giá trị đặc huấn 50 lần đầu tiên"
  },
  Task_41380_Desc = {
    Text = "Hoàn thành tất cả các nhiệm vụ truy niệm"
  },
  Task_43476_Desc = {
    Text = "Người giữ bí mật đạt level 55"
  },
  Task_43476_Name = {
    Text = "Huấn luyện thử nghiệm Người Giữ Gìn IV"
  },
  Task_43477_Desc = {
    Text = "Bí mật gia đạt cấp 45"
  },
  Task_43477_Name = {
    Text = "Huấn luyện thử nghiệm Người giữ bí mật III"
  },
  Task_43514_Desc = {
    Text = "Đánh lui Grun và những người khác"
  },
  Task_43514_Name = {
    Text = "Mục tiêu"
  },
  Task_43561_Desc = {
    Text = "Hoàn thành chương 6 của cốt truyện điều tra chính \"sao sao đảo ngược\""
  },
  Task_43562_Desc = {
    Text = "Hoàn thành điều tra chương 5 của câu chuyện chính \"Mắt Bão\""
  },
  Task_43563_Desc = {
    Text = "Hoàn thành chương 3 của cốt truyện chính \"Cẩn thận chó dữ\""
  },
  Task_43564_Desc = {
    Text = "Hoàn thành chương 6 của cốt truyện chính \"sao sao đảo ngược\"ở độ khó khó khăn"
  },
  Task_43565_Desc = {
    Text = "Hoàn thành chương 4 của cốt truyện chính \"Trong im lặng\"ở độ khó khó khăn"
  },
  Task_43566_Desc = {
    Text = "Hoàn thành điều tra chương 3 của cốt truyện chính \"Cẩn thận chó dữ\"ở độ khó cao"
  },
  Task_43567_Desc = {
    Text = "Hoàn thành nhiệm vụ điều tra chương 5 của cốt truyện chính \"Mắt Bão\"ở độ khó khó khăn"
  },
  Task_43568_Desc = {
    Text = "Hoàn thành điều tra chương 4 của câu chuyện chính \"Trong im lặng\""
  },
  Task_43822_Desc = {
    Text = "Có 1 thức tỉnh thể cấp 80"
  },
  Task_43822_Name = {
    Text = "\"lực lượng Siêu việt\" I"
  },
  Task_43824_Desc = {
    Text = "Một lần gây thương đạt 250000"
  },
  Task_43824_Name = {
    Text = "Nỗi đau không thể chịu đựng của sức sống IV"
  },
  Task_43825_Desc = {
    Text = "Một đòn tấn công gây ra 500000 sát thương"
  },
  Task_43825_Name = {
    Text = "Nỗi đau không thể chịu đựng của sự sống V"
  },
  Task_43826_Desc = {
    Text = "Gây ra 50000 sát thương trong một lần"
  },
  Task_43826_Name = {
    Text = "Nỗi đau vượt quá sức chịu đựng của sự sống II"
  },
  Task_43827_Desc = {
    Text = "Một lần gây ra 100000 điểm thương"
  },
  Task_43827_Name = {
    Text = "Sức sống không thể chịu đựng được III"
  },
  Task_43828_Desc = {
    Text = "Có 3 thể xác được thức tỉnh ở cấp độ 80"
  },
  Task_43828_Name = {
    Text = "\"Lực lượng Siêu việt\" III"
  },
  Task_43829_Desc = {
    Text = "Có 2 thể thức tỉnh ở cấp độ 80"
  },
  Task_43829_Name = {
    Text = "\"Lực lượng Siêu việt\" II"
  },
  Task_43831_Desc = {
    Text = "Áp đặt 10000 lớp trúng độc lên kẻ địch"
  },
  Task_43831_Name = {
    Text = "Độc tố hiện thực I"
  },
  Task_43832_Desc = {
    Text = "Hoàn thành duy thức tiềm hành \"Nguyện vọng của hiệp sĩ\""
  },
  Task_43832_Name = {
    Text = "Truyện Nghìn Lễ Một Đêm"
  },
  Task_43833_Desc = {
    Text = "Hoàn thành duy thức tiềm hành \"Bữa tiệc bùng cháy\""
  },
  Task_43833_Name = {
    Text = "Dưới ánh trăng, chẳng có điều gì mới mẻ"
  },
  Task_43834_Desc = {
    Text = "Hoàn thành bản ghi đặc nhiệm \"Quỳnh Hồng\"ở độ khó khó khăn"
  },
  Task_43834_Name = {
    Text = "Đóa hồng đỏ không im lặng·khó"
  },
  Task_43835_Desc = {
    Text = "Hoàn thành bản ghi đặc nhiệm \"Phép thuật của câu chuyện\" khó khăn"
  },
  Task_43835_Name = {
    Text = "Thời thơ ấu đơn giản khó khăn"
  },
  Task_43836_Desc = {
    Text = "Hoàn thành bản ghi đặc nhiệm \"Phép thuật của câu chuyện\""
  },
  Task_43836_Name = {
    Text = "Thời thơ ấu đơn giản"
  },
  Task_43837_Desc = {
    Text = "Hoàn thành bản ghi đặc nhiệm \"Bóng ma thị trấn mưa\"độ khó khó khăn"
  },
  Task_43837_Name = {
    Text = "Phù thủy thời đại · khó khăn"
  },
  Task_43838_Desc = {
    Text = "Hoàn thành bản ghi đặc nhiệm \"Bóng ma trong mưa\""
  },
  Task_43838_Name = {
    Text = "Phù thủy của thời đại"
  },
  Task_43839_Desc = {
    Text = "Hoàn thành bản ghi đặc nhiệm \"Quỳnh Hoa Ngợi Ca\""
  },
  Task_43839_Name = {
    Text = "Hoa hồng đỏ sẽ không câm lặng"
  },
  Task_43840_Desc = {
    Text = "Chiến đấu 2000 lần trong chế độ đối đầu pha"
  },
  Task_43840_Name = {
    Text = "Sự chồng pha V"
  },
  Task_43843_Desc = {
    Text = "Phá hủy một vòng mệnh SSR"
  },
  Task_43843_Name = {
    Text = "Vật ngoài thân"
  },
  Task_43844_Desc = {
    Text = "Vòng mệnh xếp chồng 700 lần"
  },
  Task_43844_Name = {
    Text = "Tương lai của rối lượng tử I"
  },
  Task_43845_Desc = {
    Text = "Nâng cấp kỹ năng thân thể được đánh thức 1000 lần"
  },
  Task_43845_Name = {
    Text = "\"Chư Vũ Tinh Thông\" VIII"
  },
  Task_43846_Desc = {
    Text = "Nâng cấp kỹ năng của thân thể được đánh thức 1100 lần"
  },
  Task_43846_Name = {
    Text = "\"Thông Thạo Võ Nghệ\" IX"
  },
  Task_43847_Desc = {
    Text = "Nâng cấp kỹ năng thân thể được đánh thức 1200 lần"
  },
  Task_43847_Name = {
    Text = "\"Thành thục mọi vũ khí\" X"
  },
  Task_43849_Desc = {
    Text = "Phá hủy 100 vòng mệnh"
  },
  Task_43849_Name = {
    Text = "Sự tò mò quý giá"
  },
  Task_43850_Desc = {
    Text = "Phân rã 200 vòng mệnh"
  },
  Task_43850_Name = {
    Text = "Niềm vui khi tháo rời thành từng mảnh nhỏ"
  },
  Task_43851_Desc = {
    Text = "Phá hủy 300 vòng mệnh"
  },
  Task_43851_Name = {
    Text = "Vũ trụ nằm trong vỏ quả"
  },
  Task_43863_Desc = {
    Text = "Trong chế độ đối đầu pha, đấu 1000 lần"
  },
  Task_43863_Name = {
    Text = "Pha chồng lên nhau IV"
  },
  Task_43864_Desc = {
    Text = "Chơi 500 trận trong chế độ đối đầu pha"
  },
  Task_43864_Name = {
    Text = "Pha chồng III"
  },
  Task_43866_Desc = {
    Text = "Hoàn thành 100 lần Thám hiểm Giấc mơ sâu"
  },
  Task_43866_Name = {
    Text = "Phiêu lưu bề mặt"
  },
  Task_43867_Desc = {
    Text = "Chơi 250 lần trong chế độ đối đầu pha"
  },
  Task_43867_Name = {
    Text = "Pha chồng lấn II"
  },
  Task_43868_Desc = {
    Text = "Đấu 100 lần ở chế độ đối đầu pha"
  },
  Task_43868_Name = {
    Text = "Pha chồng chéo I"
  },
  Task_43869_Desc = {
    Text = "Đồng bộ tỷ lệ đồng điều với 40 thân thể được đánh thức lên cấp 10"
  },
  Task_43869_Name = {
    Text = "Mọi người đều là sức mạnh của tôi"
  },
  Task_43873_Desc = {
    Text = "Vòng mệnh xếp chồng lên tới 600 lần"
  },
  Task_43873_Name = {
    Text = "Số phận Đan-xen VI"
  },
  Task_43874_Desc = {
    Text = "Vòng mệnh tầng xếp 500 lần"
  },
  Task_43874_Name = {
    Text = "Số phận đan xen V"
  },
  Task_43875_Desc = {
    Text = "Đã đạt 400 lần xếp lớp của vòng mệnh"
  },
  Task_43875_Name = {
    Text = "Số phận đan xen IV"
  },
  Task_43876_Desc = {
    Text = "Vòng mệnh lặp tầng 300 vòng"
  },
  Task_43876_Name = {
    Text = "Số phận đan xen III"
  },
  Task_43877_Desc = {
    Text = "Vòng mệnh lặp vị trí 200 lần"
  },
  Task_43877_Name = {
    Text = "Số phận đan xen II"
  },
  Task_43878_Desc = {
    Text = "Vòng mệnh được xếp chồng 100 lần"
  },
  Task_43878_Name = {
    Text = "Số phận đan xen I"
  },
  Task_43880_Desc = {
    Text = "Thân thể được đánh thức kích hoạt khởi linh 600 lần"
  },
  Task_43880_Name = {
    Text = "Từ tiếng gọi bí ẩn"
  },
  Task_43881_Desc = {
    Text = "Thân thể được đánh thức kích hoạt khởi linh 500 lần"
  },
  Task_43881_Name = {
    Text = "Sự giao thoa giữa tâm hồn và thể xác IV"
  },
  Task_43882_Desc = {
    Text = "Thân thể được đánh thức kích hoạt khởi linh 400 lần"
  },
  Task_43882_Name = {
    Text = "Sự hòa hợp giữa linh hồn và thể xác III"
  },
  Task_43883_Desc = {
    Text = "Hoàn thành duy thức tiềm hành \"Điêu khắc như bài ca\" khó khăn"
  },
  Task_43883_Name = {
    Text = "Bí mật của Aleph - Khó khăn"
  },
  Task_43884_Desc = {
    Text = "Hoàn thành duy thức tiềm hành \"Máu và Cát\" khó khăn"
  },
  Task_43884_Name = {
    Text = "Thú vật nói như vậy·khó khăn"
  },
  Task_43885_Desc = {
    Text = "Hoàn thành duy thức tiềm hành \"một bước xa\""
  },
  Task_43885_Name = {
    Text = "Sứ giả Vòng lặp"
  },
  Task_43886_Desc = {
    Text = "Hoàn thành duy thức tiềm hành \"Như mọi thứ vẫn thường\""
  },
  Task_43886_Name = {
    Text = "Thành phố không nhìn thấy"
  },
  Task_43887_Desc = {
    Text = "Hoàn thành duy thức tiềm hành \"Ước nguyện của Hiệp sĩ\" khó khăn"
  },
  Task_43887_Name = {
    Text = "Nghìn lẻ một đêm ·khó khăn"
  },
  Task_43888_Desc = {
    Text = "Hoàn thành duy thức tiềm hành \"Bữa tiệc bùng cháy\" khó khăn"
  },
  Task_43888_Name = {
    Text = "Dưới ánh trăng không có chuyện mới·thử thách"
  },
  Task_43889_Desc = {
    Text = "Hoàn thành duy thức tiềm hành \"Như điệu nhạc tinh xảo\""
  },
  Task_43889_Name = {
    Text = "Bí mật của Aleph"
  },
  Task_43890_Desc = {
    Text = "Hoàn thành duy thức tiềm hành \"Máu và Cát\""
  },
  Task_43890_Name = {
    Text = "Loài thú đã nói như thế"
  },
  Task_43891_Desc = {
    Text = "Hoàn thành duy thức tiềm hành \"Xoắn Vặn\""
  },
  Task_43891_Name = {
    Text = "Búp bê cơ khí có mơ không"
  },
  Task_43892_Desc = {
    Text = "Hoàn thành duy thức tiềm hành \"Hậu duệ tái nhợt\""
  },
  Task_43892_Name = {
    Text = "Demian của tôi"
  },
  Task_43893_Desc = {
    Text = "Gây 25000 lớp trúng độc cho kẻ địch"
  },
  Task_43893_Name = {
    Text = "Độc Thực Tại II"
  },
  Task_43896_Desc = {
    Text = "Hoàn thành duy thức tiềm hành \"một bước xa\" khó khăn"
  },
  Task_43896_Name = {
    Text = "Sứ giả Vòng lặp·khó khăn"
  },
  Task_43897_Desc = {
    Text = "Thực hiện lễ thức thức tỉnh 10000 lần"
  },
  Task_43897_Name = {
    Text = "Ca sĩ Linh Tri Thức"
  },
  Task_43898_Desc = {
    Text = "Hoàn thành duy thức tiềm hành \"lõi vặn vẹo\" khó khăn"
  },
  Task_43898_Name = {
    Text = "Cơ giới búp bê có mơ không·khó khăn"
  },
  Task_43899_Desc = {
    Text = "Tích lũy tiêu thụ 100000 dấu đen"
  },
  Task_43899_Name = {
    Text = "Kính chào \"ánh sáng\" IV"
  },
  Task_43900_Desc = {
    Text = "Tích lũy tiêu thụ 50000 dấu đen"
  },
  Task_43900_Name = {
    Text = "Chào mừng \"quang\" III"
  },
  Task_43901_Desc = {
    Text = "Tổng cộng đã tiêu thụ 25000 dấu đen"
  },
  Task_43901_Name = {
    Text = "Chào mừng \"ánh sáng\"đến II"
  },
  Task_43902_Desc = {
    Text = "Tổng cộng đã tiêu thụ 10000 dấu đen"
  },
  Task_43902_Name = {
    Text = "Chào mừng \"ánh sáng\"đến I"
  },
  Task_43903_Desc = {
    Text = "Sở hữu 100 món đồ cấp 12 bí ẩn"
  },
  Task_43903_Name = {
    Text = "Cấm Kỵ Người Bảo Vệ III"
  },
  Task_43904_Desc = {
    Text = "Sở hữu 150 món đồ cấp 12 của huyền bí"
  },
  Task_43904_Name = {
    Text = "Cấm kỵ Người bảo vệ IV"
  },
  Task_43905_Desc = {
    Text = "Có 25 món đồ bí ẩn cấp 12"
  },
  Task_43905_Name = {
    Text = "Cấm kỵ Người bảo vệ I"
  },
  Task_43906_Desc = {
    Text = "Sở hữu 50 món đồ bí ẩn cấp 12"
  },
  Task_43906_Name = {
    Text = "Người Bảo Vệ Cấm Kỵ II"
  },
  Task_43907_Desc = {
    Text = "Thực hiện 2500 lần lễ thức đánh thức"
  },
  Task_43907_Name = {
    Text = "Người tụng linh hồn II"
  },
  Task_43908_Desc = {
    Text = "Tiến hành lễ thức thức tỉnh 5000 lần"
  },
  Task_43908_Name = {
    Text = "Người đọc linh hồn III"
  },
  Task_43909_Desc = {
    Text = "Thực hiện 500 lần lễ thức đánh thức"
  },
  Task_43909_Name = {
    Text = "Thiên tài Người Giữ Gìn V"
  },
  Task_43910_Desc = {
    Text = "Thực hiện 1000 lần lễ thức đánh thức"
  },
  Task_43910_Name = {
    Text = "Người ngâm tụng linh hồn I"
  },
  Task_43911_Desc = {
    Text = "Hoàn thành duy thức tiềm hành \"Hậu duệ nhợt nhạt\" khó khăn"
  },
  Task_43911_Name = {
    Text = "Khó khăn của tôi · Demian"
  },
  Task_43916_Desc = {
    Text = "Trong một ngày, thay đổi ảnh đại diện hơn 3 lần"
  },
  Task_43916_Name = {
    Text = "Kẻ Hề Biến Hình"
  },
  Task_43917_Desc = {
    Text = "Ở trong ký túc xá, đối thoại với thân thể được đánh thức 100 lần"
  },
  Task_43917_Name = {
    Text = "Hôm nay chúng ta dừng ở đây nhé"
  },
  Task_43918_Desc = {
    Text = "Hoàn thành ghi chép bí ẩn 250 lần"
  },
  Task_43918_Name = {
    Text = "Có gì đó không ổn"
  },
  Task_43919_Desc = {
    Text = "Hoàn thành phiên bản bí ẩn 100 lần"
  },
  Task_43919_Name = {
    Text = "Viết rất nhanh và chuẩn xác"
  },
  Task_43921_Desc = {
    Text = "Hoàn thành ghi chép bí ẩn 500 lượt"
  },
  Task_43921_Name = {
    Text = "Làm thêm một phiên bản nữa"
  },
  Task_43923_Desc = {
    Text = "Gây ra 10000 điểm thương trong một lần"
  },
  Task_43923_Name = {
    Text = "Sức sống không thể chịu nổi I"
  },
  Task_43928_Desc = {
    Text = "Đạt tỷ lệ đồng điều cấp độ 10 với 30 thân thể được đánh thức"
  },
  Task_43928_Name = {
    Text = "\"Phân tích yêu\""
  },
  Task_43930_Desc = {
    Text = "Đồng điệu với 16 thân thể được đánh thức đạt tỷ lệ đồng điều cấp độ 10"
  },
  Task_43930_Name = {
    Text = "Trò chuyện giữa tâm và linh"
  },
  Task_43932_Desc = {
    Text = "Đồng điệu với 20 thân thể được đánh thức đạt tỷ lệ đồng điều cấp độ 10"
  },
  Task_43932_Name = {
    Text = "Người đọc của linh hồn"
  },
  Task_43934_Desc = {
    Text = "Mở khóa dạng nguồn gốc của Ramona"
  },
  Task_43934_Name = {
    Text = "Ở bên cạnh thiếu nữ"
  },
  Task_43936_Desc = {
    Text = "Tỷ lệ đồng điều với 12 thân thể được đánh thức đạt mức cấp độ 10"
  },
  Task_43936_Name = {
    Text = "Gõ nhẹ vào tâm hồn chìm trong giấc ngủ sâu"
  },
  Task_43937_Desc = {
    Text = "Đăng nhập liên tiếp 300 ngày"
  },
  Task_43937_Name = {
    Text = "Ý chí kiên định"
  },
  Task_43938_Desc = {
    Text = "Đã đăng nhập liên tiếp 365 ngày"
  },
  Task_43938_Name = {
    Text = "Một đêm đầy sao lấp lánh"
  },
  Task_43943_Desc = {
    Text = "Đã đăng nhập liên tiếp 120 ngày"
  },
  Task_43943_Name = {
    Text = "Một buổi sáng bình thường"
  },
  Task_43944_Desc = {
    Text = "Đã đăng nhập liên tiếp 150 ngày"
  },
  Task_43944_Name = {
    Text = "Một cốc cà phê nhạt nhẽo"
  },
  Task_43945_Desc = {
    Text = "Đã đăng nhập liên tiếp 180 ngày"
  },
  Task_43945_Name = {
    Text = "Một cuộc đối thoại đơn giản"
  },
  Task_43946_Desc = {
    Text = "Đã đăng nhập tổng cộng 240 ngày"
  },
  Task_43946_Name = {
    Text = "Một trái tim rực cháy"
  },
  Task_43948_Desc = {
    Text = "30 vòng mệnh khác nhau"
  },
  Task_43948_Name = {
    Text = "Người nắm giữ sự vô thường"
  },
  Task_43949_Desc = {
    Text = "Nhận được 20 loại vòng mệnh đa dạng"
  },
  Task_43949_Name = {
    Text = "Đệ tử Số phận II"
  },
  Task_43950_Desc = {
    Text = "Nhận được 10 loại vòng mệnh"
  },
  Task_43950_Name = {
    Text = "Học trò của Số phận I"
  },
  Task_43953_Desc = {
    Text = "Nhận được 40 vòng mệnh khác nhau"
  },
  Task_43953_Name = {
    Text = "Người thêu dệt số phận"
  },
  Task_43957_Desc = {
    Text = "Sử dụng 1 lần hỗ trợ"
  },
  Task_43957_Name = {
    Text = "Muốn đi xa, hãy nhờ bạn bè"
  },
  Task_43958_Desc = {
    Text = "Chỉnh sửa lời giới thiệu"
  },
  Task_43958_Name = {
    Text = "Xin chào, thế giới!"
  },
  Task_43959_Desc = {
    Text = "Được yêu thích 1000 lần"
  },
  Task_43959_Name = {
    Text = "Khi những lời khen ngợi gõ cửa"
  },
  Task_43961_Desc = {
    Text = "Thích 100 lần"
  },
  Task_43961_Name = {
    Text = "Bước nhỏ ra khỏi nội tâm"
  },
  Task_43962_Desc = {
    Text = "Thích 50 lần"
  },
  Task_43962_Name = {
    Text = "Một nỗ lực không đáng kể"
  },
  Task_43964_Desc = {
    Text = "Theo dõi 100 cựu sinh viên xuất sắc"
  },
  Task_43964_Name = {
    Text = "Lúc tinh tú sáng rực"
  },
  Task_43965_Desc = {
    Text = "Theo dõi 1 cựu sinh viên"
  },
  Task_43965_Name = {
    Text = "Tên bạn?"
  },
  Task_43966_Desc = {
    Text = "Đăng nhập liên tiếp 500 ngày"
  },
  Task_43966_Name = {
    Text = "Mặt trời của Cát Đá vẫn mọc như thường lệ"
  },
  Task_43967_Desc = {
    Text = "Thân thể được đánh thức kích hoạt khởi linh 60 lần"
  },
  Task_43967_Name = {
    Text = "Hội ngộ của tâm linh và tâm hồn V"
  },
  Task_43968_Desc = {
    Text = "Thân thể được đánh thức kích hoạt khởi linh 100 lần"
  },
  Task_43968_Name = {
    Text = "Đợi trong bóng tối"
  },
  Task_43969_Desc = {
    Text = "Thân thể được đánh thức kích hoạt khởi linh 30 lần"
  },
  Task_43969_Name = {
    Text = "Gặp Gỡ Tâm Linh III"
  },
  Task_43970_Desc = {
    Text = "Thân thể được đánh thức kích hoạt khởi linh 45 lần"
  },
  Task_43970_Name = {
    Text = "Hội ngộ của linh hồn và trái tim IV"
  },
  Task_43972_Desc = {
    Text = "Thân thể được đánh thức kích hoạt khởi linh 15 lần"
  },
  Task_43972_Name = {
    Text = "Hội ngộ linh hồn và tinh thần II"
  },
  Task_43973_Desc = {
    Text = "Sở hữu 4 thân thể được đánh thức cấp 80"
  },
  Task_43973_Name = {
    Text = "\"Lực lượng vượt trội\" IV"
  },
  Task_43975_Desc = {
    Text = "Thân thể được đánh thức đã kích hoạt khởi linh tổng cộng 200 lần"
  },
  Task_43975_Name = {
    Text = "Sự kết hợp giữa linh hồn và thể xác I"
  },
  Task_43976_Desc = {
    Text = "Thân thể được đánh thức kích hoạt khởi linh 300 lần"
  },
  Task_43976_Name = {
    Text = "Sự hòa hợp giữa linh hồn và thể xác II"
  },
  Task_44231_Desc = {
    Text = "Sử dụng thân thể được đánh thức siêu giới vực để chiến thắng 1 lần trong \"con đường đền thánh\""
  },
  Task_44232_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong siêu việt giới vực để chiến thắng 3 lần trên \"đền thánh\""
  },
  Task_44233_Desc = {
    Text = "Sử dụng thân thể được đánh thức siêu không gian giới vực để chiến thắng 2 lần trong \"đường đền thánh\""
  },
  Task_44234_Desc = {
    Text = "Hoàn thành \"tranh đoạt\" bất kỳ độ khó nào"
  },
  Task_44235_Desc = {
    Text = "Hoàn thành \"Hoang Tưởng\"ở bất kỳ độ khó nào"
  },
  Task_44236_Desc = {
    Text = "Sử dụng thân thể được đánh thức vùng giới sâu thẳm để chiến thắng 1 lần trong \"đền thánh\""
  },
  Task_44237_Desc = {
    Text = "Sử dụng thân thể được đánh thức hỗn loạn giới vực để chiến thắng 3 lần trong \"đền thánh đường đi\""
  },
  Task_44238_Desc = {
    Text = "Sử dụng thân thể được đánh thức từ giới vực hỗn loạn để chiến thắng 2 lần trong \"con đường của đền thánh\""
  },
  Task_44239_Desc = {
    Text = "Sử dụng thân thể được đánh thức của giới vực hỗn loạn để giành chiến thắng một lần tại \"đường đền thánh\""
  },
  Task_44240_Desc = {
    Text = "Sử dụng thân thể được đánh thức của vùng giới sâu thẳm để chiến thắng 3 lần trong \"đền thánh đường đi\""
  },
  Task_44241_Desc = {
    Text = "\"Đại John kỳ diệu\" mua 150 lần"
  },
  Task_44242_Desc = {
    Text = "\"Đại John kỳ diệu\" trong mua 200 lần"
  },
  Task_44243_Desc = {
    Text = "\"Bán hàng từ thiện kỳ diệu của John lớn\" trong mua 100 lần"
  },
  Task_44244_Desc = {
    Text = "\"Cửa hàng nhỏ của Bà Grey\" mua 200 lần"
  },
  Task_44245_Desc = {
    Text = "\"Cửa hàng nhỏ của Gray Bà\" mua 150 lần"
  },
  Task_44246_Desc = {
    Text = "Mua 100 lần tại \"Cửa hàng nhỏ của Bà Gray\""
  },
  Task_44247_Desc = {
    Text = "Sử dụng thân thể được đánh thức của giới vực thịt máu để giành chiến thắng 3 lần trong \"đền thánh\""
  },
  Task_44248_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong giới vực thịt máu để chiến thắng 2 lần trong \"đền thánh chi lộ\""
  },
  Task_44249_Desc = {
    Text = "Sử dụng thức tỉnh thân thể của thịt máu giới vực để chiến thắng 1 lần trong \"con đường đền thánh\""
  },
  Task_44250_Desc = {
    Text = "Hoàn thành \"Sám hối\" tất cả các độ khó"
  },
  Task_44251_Desc = {
    Text = "Sân từ thiện tại đền thánh"
  },
  Task_44252_Desc = {
    Text = "\"Smith đặc biệt bán\" mua tổng cộng 100 lần"
  },
  Task_44253_Desc = {
    Text = "\"Smith đặc biệt bán\" mua 200 lần"
  },
  Task_44254_Desc = {
    Text = "\"Smith bán đặc biệt\" mua 150 lần"
  },
  Task_44255_Desc = {
    Text = "Đền thánh đường đi·biển sâu"
  },
  Task_44256_Desc = {
    Text = "Đường đền thánh siêu việt"
  },
  Task_44257_Desc = {
    Text = "Đường đền thánh · hỗn loạn"
  },
  Task_44258_Desc = {
    Text = "Hoàn thành \"Yêu Cầu\" bất kỳ độ khó nào"
  },
  Task_44259_Desc = {
    Text = "Hoàn thành tất cả các cấp độ của \"Đường Thánh\"ở bất kỳ độ khó nào"
  },
  Task_44260_Desc = {
    Text = "Hoàn thành \"tố cáo\" bất kỳ độ khó nào"
  },
  Task_44261_Desc = {
    Text = "Sử dụng vùng giới sâu thẳm đã được đánh thức để chiến thắng 2 lần trong \"con đường đền thánh\""
  },
  Task_44262_Desc = {
    Text = "Đường đền thánh · thịt máu"
  },
  Task_44263_Desc = {
    Text = "Đường đền thánh · Sự phát triển"
  },
  Task_44264_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"{s1}\""
  },
  Task_44567_Desc = {
    Text = "Ngăn chặn Sofia"
  },
  Task_44567_Name = {
    Text = "Mục tiêu"
  },
  Task_45665_Desc = {
    Text = "Hoàn thành duy thức tiềm hành \"Sự sụp đổ của người khổng lồ\" chế độ thông thường"
  },
  Task_45665_Name = {
    Text = "Phần thưởng hoàn thành"
  },
  Task_45666_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"{s1}\""
  },
  Task_46575_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong siêu không gian giới vực để hoàn thành \"Vô Thức Ký\"ở bất kỳ độ khó nào"
  },
  Task_46576_Desc = {
    Text = "Hoàn thành \"gương\"ở bất kỳ độ khó nào"
  },
  Task_46577_Desc = {
    Text = "Sử dụng thân thể được đánh thức giới vực thịt máu để hoàn thành \"Não Côn Trùng\"ở bất kỳ độ khó nào"
  },
  Task_46578_Desc = {
    Text = "Mã hóa ký ức·thịt máu"
  },
  Task_46579_Desc = {
    Text = "Hoàn thành \"Não côn trùng\" bất kỳ độ khó nào"
  },
  Task_46580_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong giới vực thịt máu để hoàn thành \"Ký Ức Vô Thức\"ở bất kỳ độ khó nào"
  },
  Task_46581_Desc = {
    Text = "Mã hóa ký ức biển sâu"
  },
  Task_46582_Desc = {
    Text = "Hoàn thành \"Ghi nhớ vô thức\" bất kỳ độ khó nào"
  },
  Task_46583_Desc = {
    Text = "Sử dụng thân thể được đánh thức của giới vực hỗn loạn để hoàn thành \"đường cong quên lãng\"ở bất kỳ độ khó nào"
  },
  Task_46584_Desc = {
    Text = "Sử dụng thân thể được đánh thức từ giới vực hỗn loạn để hoàn thành \"Gương\"ở bất kỳ độ khó nào"
  },
  Task_46585_Desc = {
    Text = "Sử dụng thân thể được đánh thức của giới vực hỗn loạn để hoàn thành \"Hạnh Nhân Thể\"ở bất kỳ độ khó nào"
  },
  Task_46586_Desc = {
    Text = "Sử dụng thân thể được đánh thức giới vực hỗn loạn để hoàn thành \"Não côn trùng\"ở bất kỳ độ khó nào"
  },
  Task_46587_Desc = {
    Text = "Sử dụng thân thể được đánh thức của giới vực hỗn loạn để hoàn thành \"ghi nhớ vô thức\"ở bất kỳ độ khó nào"
  },
  Task_46588_Desc = {
    Text = "Sử dụng thân thể được đánh thức của vùng giới sâu thẳm để hoàn thành \"Gương\"ở bất kỳ độ khó nào"
  },
  Task_46589_Desc = {
    Text = "Sử dụng thân thể được đánh thức giới vực biển sâu để hoàn thành \"Đường cong Quên lãng\"ở bất kỳ độ khó nào"
  },
  Task_46590_Desc = {
    Text = "Sử dụng thân thể được đánh thức biển sâu để hoàn thành \"Ghi chép Vô thức\"ở bất kỳ độ khó nào"
  },
  Task_46591_Desc = {
    Text = "Sử dụng thân thể được đánh thức của vùng giới sâu thẳm để hoàn thành \"Não Crawler\"ở bất kỳ độ khó nào"
  },
  Task_46592_Desc = {
    Text = "Sử dụng thân thể được đánh thức của giới vực biển sâu để hoàn thành \"Hạnh Nhân Thể\"ở bất kỳ độ khó nào"
  },
  Task_46593_Desc = {
    Text = "Hoàn thành tất cả các level của \"Mã hóa Ký ức\"ở bất kỳ độ khó nào"
  },
  Task_46594_Desc = {
    Text = "Hoàn thành \"Đường cong Quên lãng\"ở mọi độ khó"
  },
  Task_46595_Desc = {
    Text = "Mã hóa ký ức hỗn loạn"
  },
  Task_46596_Desc = {
    Text = "Hoàn thành \"Hạnh Nhân Thể\" bất kỳ độ khó nào"
  },
  Task_46597_Desc = {
    Text = "Sử dụng thân thể được đánh thức giới vực siêu việt để hoàn thành \"Đường cong Quên lãng\"ở bất kỳ độ khó nào"
  },
  Task_46598_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong siêu không gian giới vực để hoàn thành \"Gương\"ở bất kỳ độ khó nào"
  },
  Task_46599_Desc = {
    Text = "Sử dụng thân thể được đánh thức của giới vực huyết nhục để hoàn thành \"Đường cong Quên lãng\"ở bất kỳ độ khó nào"
  },
  Task_46600_Desc = {
    Text = "Sử dụng thân thể được đánh thức từ giới vực thịt máu để hoàn thành \"Gương\"ở bất kỳ độ khó nào"
  },
  Task_46601_Desc = {
    Text = "Sử dụng thân thể được đánh thức của thịt máu giới vực để hoàn thành \"Thể Hạnh Nhân\"ở bất kỳ độ khó nào"
  },
  Task_46602_Desc = {
    Text = "Mã hóa ký ức·phát sinh"
  },
  Task_46603_Desc = {
    Text = "Sử dụng thân thể được đánh thức siêu không gian giới vực để hoàn thành \"thể hạnh nhân\"ở bất kỳ độ khó nào"
  },
  Task_46604_Desc = {
    Text = "Sử dụng thân thể được đánh thức siêu không gian giới vực để hoàn thành \"Não Bọ Cạp\"ở bất kỳ độ khó nào"
  },
  Task_46605_Desc = {
    Text = "Mã hóa ký ức·siêu việt"
  },
  Task_46624_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"{s1}\""
  },
  Task_46798_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_46798_Name = {
    Text = "200 điểm"
  },
  Task_46799_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_46799_Name = {
    Text = "450 điểm"
  },
  Task_46806_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_46806_Name = {Text = "50 điểm"},
  Task_46807_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_46807_Name = {
    Text = "100 điểm"
  },
  Task_46808_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_46808_Name = {
    Text = "150 điểm"
  },
  Task_46809_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_46809_Name = {
    Text = "1500 điểm"
  },
  Task_46810_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_46810_Name = {
    Text = "250 điểm"
  },
  Task_46811_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_46811_Name = {
    Text = "300 điểm"
  },
  Task_46812_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_46812_Name = {
    Text = "350 điểm"
  },
  Task_46821_Desc = {
    Text = "Đạt được tổng cộng 6 trận thắng trong mùa giải này"
  },
  Task_46821_Name = {Text = "6 thắng"},
  Task_46822_Desc = {
    Text = "Đạt được 3 trận thắng trong mùa giải này"
  },
  Task_46822_Name = {
    Text = "3 trận thắng"
  },
  Task_46823_Desc = {
    Text = "Đạt được tích lũy 1 trận thắng trong mùa giải này"
  },
  Task_46823_Name = {
    Text = "1 trận thắng"
  },
  Task_46826_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_46826_Name = {
    Text = "1450 điểm"
  },
  Task_46827_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_46827_Name = {Text = "1400"},
  Task_46828_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_46828_Name = {
    Text = "1350 điểm"
  },
  Task_46829_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_46829_Name = {
    Text = "1300 điểm"
  },
  Task_46830_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_46830_Name = {
    Text = "1250 điểm"
  },
  Task_46831_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_46831_Name = {
    Text = "1200 điểm"
  },
  Task_46832_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_46832_Name = {
    Text = "1150 điểm"
  },
  Task_46833_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_46833_Name = {
    Text = "1100 điểm"
  },
  Task_46834_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_46834_Name = {
    Text = "1050 điểm"
  },
  Task_46835_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_46835_Name = {
    Text = "1000 điểm số"
  },
  Task_46836_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_46836_Name = {
    Text = "600 điểm"
  },
  Task_46837_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_46837_Name = {
    Text = "650 điểm"
  },
  Task_46838_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_46838_Name = {
    Text = "500 điểm"
  },
  Task_46839_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_46839_Name = {
    Text = "550 điểm"
  },
  Task_46840_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_46840_Name = {
    Text = "800 điểm"
  },
  Task_46841_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_46841_Name = {Text = "850"},
  Task_46842_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_46842_Name = {
    Text = "700 điểm"
  },
  Task_46843_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_46843_Name = {
    Text = "750 điểm"
  },
  Task_46844_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_46844_Name = {
    Text = "900 điểm"
  },
  Task_46845_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_46845_Name = {
    Text = "950 điểm"
  },
  Task_46846_Desc = {
    Text = "Đạt được tổng cộng 10 trận thắng trong mùa giải này"
  },
  Task_46846_Name = {Text = "10 thắng"},
  Task_46847_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_46847_Name = {
    Text = "400 điểm"
  },
  Task_46850_Desc = {
    Text = "Đạt được tổng cộng 10 trận thắng trong mùa giải này"
  },
  Task_46850_Name = {Text = "10 thắng"},
  Task_46852_Desc = {
    Text = "Đạt được 3 trận thắng trong mùa giải này"
  },
  Task_46852_Name = {
    Text = "3 trận thắng"
  },
  Task_46853_Desc = {
    Text = "Đạt được tổng cộng 6 trận thắng trong mùa giải này"
  },
  Task_46853_Name = {Text = "6 thắng"},
  Task_46854_Desc = {
    Text = "Đạt được tích lũy 1 trận thắng trong mùa giải này"
  },
  Task_46854_Name = {
    Text = "1 trận thắng"
  },
  Task_47794_Desc = {
    Text = "Hoàn thành tất cả các khe hở giới vực của Vùng đất vô ánh sáng VII"
  },
  Task_47795_Desc = {
    Text = "Hoàn thành tất cả các khe hở giới vực của Vùng đất vô ánh sáng I"
  },
  Task_47796_Desc = {
    Text = "Hoàn thành tất cả các khe hở giới vực trong Vùng đất vô ánh sáng III"
  },
  Task_47797_Desc = {
    Text = "Hoàn thành tất cả khe hở giới vực V của Vùng đất vô ánh sáng"
  },
  Task_47799_Desc = {
    Text = "Hoàn thành tất cả các khe hở Phần IV của Vùng đất vô ánh sáng"
  },
  Task_47800_Desc = {
    Text = "Hoàn thành tất cả khe hở giới vực tại Vùng đất vô ánh sáng VI"
  },
  Task_47801_Desc = {
    Text = "Hoàn thành VIII khe hở giới vực Vùng đất vô ánh sáng"
  },
  Task_47802_Desc = {
    Text = "Hoàn thành tất cả khe hở giới vực Vùng đất vô ánh sáng II"
  },
  Task_48166_Desc = {
    Text = "Đánh lui Rogers và đồng bọn"
  },
  Task_48166_Name = {
    Text = "Mục tiêu"
  },
  Task_48167_Desc = {
    Text = "Thắng bóng tối \"24\""
  },
  Task_48167_Name = {
    Text = "Mục tiêu"
  },
  Task_48733_CompleteCondDesc = {
    Text = "Phái đi cấp độ tổng>={s1}"
  },
  Task_48733_Desc = {
    Text = "Từ những nhà thờ đổ nát và di vật bị phá hủy, bảo tàng có được kho báu của họ, bạn cũng có được kho báu của mình. \nMỗi bên đều đạt được điều mình cần."
  },
  Task_48733_Name = {
    Text = "Nhiệm vụ điều tra: Tín ngưỡng phổ quát"
  },
  Task_48733_UnlockCondDesc = {
    Text = "Người giữ bí mật mở khóa ở cấp 40"
  },
  Task_48734_CompleteCondDesc = {
    Text = "Phái đi cấp độ tổng>={s1}"
  },
  Task_48734_Desc = {
    Text = "Quên đi những nhận thức của bạn, quên đi mục đích của bạn. \n Sự thật là gì, chúng sẽ nói cho bạn biết."
  },
  Task_48734_Name = {
    Text = "Điều tra nhiệm vụ: Thuyết Tiên Nghiệm"
  },
  Task_48734_UnlockCondDesc = {
    Text = "Người giữ bí mật mở khóa ở cấp độ 30"
  },
  Task_48735_CompleteCondDesc = {
    Text = "Phái đi cấp độ tổng>={s1}"
  },
  Task_48735_Desc = {
    Text = "Địa lý là lời nói dối của những người ở vị trí cao.\n\nCẩn thận với những đường đẳng cao."
  },
  Task_48735_Name = {
    Text = "Điều tra nhiệm vụ: Khảo sát đo đạc"
  },
  Task_48735_UnlockCondDesc = {
    Text = "Người giữ bí mật đạt cấp 20"
  },
  Task_48736_CompleteCondDesc = {
    Text = "Phái đi cấp độ tổng>={s1}"
  },
  Task_48736_Desc = {
    Text = "Đón nhận hai lời hứa không thể tin tưởng, và một giấc mơ khó quên."
  },
  Task_48736_Name = {
    Text = "Điều tra nhiệm vụ: Bí cảnh hình bóng"
  },
  Task_48736_UnlockCondDesc = {
    Text = "Người Giữ Bí Mật mở khóa ở cấp 50"
  },
  Task_48775_Desc = {
    Text = "Lily tỷ lệ đồng điều đạt cấp 10"
  },
  Task_48776_Desc = {
    Text = "Ô Ryta tỷ lệ đồng điều đạt cấp 10"
  },
  Task_48777_Desc = {
    Text = "Phiệt tỷ lệ đồng điều đạt cấp 10"
  },
  Task_48778_Desc = {
    Text = "Tỷ lệ đồng điều của Vanda đạt cấp 10"
  },
  Task_48779_Desc = {
    Text = "Tỷ lệ đồng điều của Jenkin đạt cấp 10"
  },
  Task_48780_Desc = {
    Text = "Tỷ lệ đồng điều của Orci ở cấp 10"
  },
  Task_48781_Desc = {
    Text = "Liz đạt cấp 10 tỷ lệ đồng điều"
  },
  Task_48782_Desc = {
    Text = "Tỷ lệ đồng điều của Đào Đen Đá đạt cấp 10"
  },
  Task_48783_Desc = {
    Text = "Tỷ lệ đồng điều của đóa đạt đến cấp độ 10"
  },
  Task_48784_Desc = {
    Text = "Hilaster đã đạt cấp 10 về tỷ lệ đồng điều"
  },
  Task_48785_Desc = {
    Text = "Ai Jī Sī tỷ lệ đồng điều đạt cấp 10"
  },
  Task_48786_Desc = {
    Text = "Tỷ lệ đồng điều của Muphí đạt cấp 10"
  },
  Task_48787_Desc = {
    Text = "Tỷ lệ đồng điều của Sơn đạt cấp 10"
  },
  Task_48788_Desc = {
    Text = "Yu U Hahi đạt tỷ lệ đồng điều cấp 10"
  },
  Task_48789_Desc = {
    Text = "Nốtira tỷ lệ đồng điều đạt cấp 10"
  },
  Task_48790_Desc = {
    Text = "\"24\" tỷ lệ đồng điều đạt cấp 10"
  },
  Task_48791_Desc = {
    Text = "Tỷ lệ đồng điều của Agrippa đã đạt cấp 10"
  },
  Task_48792_Desc = {
    Text = "Pháp Luân Tư tỷ lệ đồng điều đạt đến cấp 10"
  },
  Task_48793_Desc = {
    Text = "Wenkel tỷ lệ đồng điều đạt đến cấp 10"
  },
  Task_48794_Desc = {
    Text = "Tỷ lệ đồng điều của Salvador đạt cấp độ 10"
  },
  Task_48795_Desc = {
    Text = "Hiro đạt cấp 10 đồng điều"
  },
  Task_48796_Desc = {
    Text = "Erika tỷ lệ đồng điều đạt cấp 10"
  },
  Task_48797_Desc = {
    Text = "Ramona đạt tỷ lệ đồng điều cấp 10"
  },
  Task_48798_Desc = {
    Text = "Sorrel tỷ lệ đồng bộ đạt cấp 10"
  },
  Task_48799_Desc = {
    Text = "Thái Di Sơ tỷ lệ đồng điều đạt cấp 10"
  },
  Task_48800_Desc = {
    Text = "Goliath đạt tỷ lệ đồng điều cấp 10"
  },
  Task_48801_Desc = {
    Text = "Reia đã đạt cấp 10 về tỷ lệ đồng điều"
  },
  Task_48802_Desc = {
    Text = "Elva đạt cấp 10 tỷ lệ đồng điều"
  },
  Task_48803_Desc = {
    Text = "Khắc sét tỷ lệ đồng điều đạt cấp 10"
  },
  Task_48804_Desc = {
    Text = "Tỷ lệ đồng điều của Tulô đạt cấp 10"
  },
  Task_48805_Desc = {
    Text = "Kassia tỷ lệ đồng điều đạt đến cấp 10"
  },
  Task_48806_Desc = {
    Text = "Tỷ lệ đồng điều của Gia Lân đã đạt cấp 10"
  },
  Task_48807_Desc = {
    Text = "Pandia tỷ lệ đồng điều đạt cấp 10"
  },
  Task_48808_Desc = {
    Text = "Tỷ lệ đồng điều của tinkerer đạt đến cấp 10"
  },
  Task_48809_Desc = {
    Text = "Ninh Phi Nga tỷ lệ đồng điều đạt cấp 10"
  },
  Task_48810_Desc = {
    Text = "Lơtan tỷ lệ đồng điều đã đạt đến cấp 10"
  },
  Task_48829_Desc = {
    Text = "Đăng nhập liên tiếp 11 ngày"
  },
  Task_48830_Desc = {
    Text = "Tích lũy đăng nhập 14 ngày"
  },
  Task_48831_Desc = {
    Text = "Đăng nhập liên tiếp 1 ngày"
  },
  Task_48832_Desc = {
    Text = "Đăng nhập tích lũy 16 ngày liên tiếp"
  },
  Task_48833_Desc = {
    Text = "Đăng nhập liên tiếp 12 ngày"
  },
  Task_48834_Desc = {
    Text = "Đăng nhập tích lũy trong 13 ngày"
  },
  Task_48835_Desc = {
    Text = "Đăng nhập liên tiếp trong 10 ngày"
  },
  Task_48836_Desc = {
    Text = "Đăng nhập liên tiếp 5 ngày"
  },
  Task_48837_Desc = {
    Text = "Đăng nhập liên tiếp 6 ngày"
  },
  Task_48838_Desc = {
    Text = "Đăng nhập liên tiếp 7 ngày"
  },
  Task_48839_Desc = {
    Text = "Đăng nhập liên tiếp 2 ngày"
  },
  Task_48840_Desc = {
    Text = "Đăng nhập liên tiếp 3 ngày"
  },
  Task_48841_Desc = {
    Text = "Đăng nhập liên tiếp 8 ngày"
  },
  Task_48842_Desc = {
    Text = "Đăng nhập liên tiếp trong 9 ngày"
  },
  Task_48843_Desc = {
    Text = "Tích lũy đăng nhập 15 ngày"
  },
  Task_48844_Desc = {
    Text = "Đăng nhập liên tiếp 4 ngày"
  },
  Task_49241_Desc = {
    Text = "Đạt được tích lũy 1 trận thắng trong mùa giải này"
  },
  Task_49241_Name = {
    Text = "1 trận thắng"
  },
  Task_49242_Desc = {
    Text = "Đạt được 3 trận thắng trong mùa giải này"
  },
  Task_49242_Name = {
    Text = "3 trận thắng"
  },
  Task_49243_Desc = {
    Text = "Đạt được tổng cộng 6 trận thắng trong mùa giải này"
  },
  Task_49243_Name = {Text = "6 thắng"},
  Task_49244_Desc = {
    Text = "Đạt được tổng cộng 10 trận thắng trong mùa giải này"
  },
  Task_49244_Name = {Text = "10 thắng"},
  Task_49245_Desc = {
    Text = "Đạt được tổng cộng 10 trận thắng trong mùa giải này"
  },
  Task_49245_Name = {Text = "10 thắng"},
  Task_49246_Desc = {
    Text = "Đạt được tích lũy 1 trận thắng trong mùa giải này"
  },
  Task_49246_Name = {
    Text = "1 trận thắng"
  },
  Task_49247_Desc = {
    Text = "Đạt được tổng cộng 6 trận thắng trong mùa giải này"
  },
  Task_49247_Name = {Text = "6 thắng"},
  Task_49248_Desc = {
    Text = "Đạt được 3 trận thắng trong mùa giải này"
  },
  Task_49248_Name = {
    Text = "3 trận thắng"
  },
  Task_49262_Desc = {
    Text = "Chiến thắng cuộc chiến cuối cùng trong 30 vòng"
  },
  Task_49262_Name = {
    Text = "Chiến thắng cuộc chiến cuối cùng trong 30 vòng"
  },
  Task_49380_Desc = {
    Text = "Hoàn thành \"Hoa Tái Sinh\"ở bất kỳ mức độ khó nào"
  },
  Task_49381_Desc = {
    Text = "Ham muốn hỗn loạn·tái hiện"
  },
  Task_49382_Desc = {
    Text = "Hoàn thành tất cả nhiệm vụ \"Khao khát hỗn loạn·Thông qua\""
  },
  Task_49383_Desc = {
    Text = "Ham muốn hỗn loạn·hoàn thành"
  },
  Task_49384_Desc = {
    Text = "Hoàn thành \"Sinh sản đa phôi\" bất kỳ độ khó nào"
  },
  Task_49385_Desc = {
    Text = "Hoàn thành \"Quả Rơi\" bất kỳ độ khó nào"
  },
  Task_49386_Desc = {
    Text = "Lặp lại 30 lần trong \"ham muốn hỗn loạn\""
  },
  Task_49387_Desc = {
    Text = "Hoàn thành \"Mật tuyến\" bất kỳ độ khó nào"
  },
  Task_49388_Desc = {
    Text = "Xuất hiện lại 10 lần trong \"ham muốn hỗn loạn\""
  },
  Task_49389_Desc = {
    Text = "Hoàn thành \"Căn Hạt\"ở bất kỳ độ khó nào"
  },
  Task_49390_Desc = {
    Text = "Hoàn thành \"Phát mầm\" bất kỳ độ khó nào"
  },
  Task_49391_Desc = {
    Text = "Trong \"ham muốn hỗn loạn\" tái hiện 20 lần"
  },
  Task_49392_Desc = {
    Text = "Đạt 50 lần tái hiện trong \"ham muốn hỗn loạn\""
  },
  Task_49393_Desc = {
    Text = "Tái hiện 40 lần trong \"ham muốn hỗn loạn\""
  },
  Task_49394_Desc = {
    Text = "Hoàn thành \"Hoa Đài\" bất kỳ độ khó nào"
  },
  Task_49395_Desc = {
    Text = "Hoàn thành \"bào tử\" bất kỳ độ khó nào"
  },
  Task_49396_Desc = {
    Text = "Hoàn thành \"thụ phấn\" bất kỳ độ khó nào"
  },
  Task_49397_Desc = {
    Text = "Hoàn thành \"vòng năm\"ở bất kỳ độ khó nào"
  },
  Task_49769_Desc = {
    Text = "Cuộc chiến cuối cùng, trong một lượt tối thiểu tăng thêm lá chắn bằng 50% máu tối đa"
  },
  Task_49769_Name = {
    Text = "Thân hình bằng thép"
  },
  Task_49770_Desc = {
    Text = "Gây ít nhất 3000 điểm thương trong một lượt của trận tinh anh"
  },
  Task_49770_Name = {
    Text = "Đòn toàn lực"
  },
  Task_49771_Desc = {
    Text = "Trong bất kỳ cuộc chiến đấu nào, tiêu diệt ít nhất 2 con quái vật trong một hiệp"
  },
  Task_49771_Name = {
    Text = "Xử lý triệt để"
  },
  Task_49772_Desc = {
    Text = "Hoàn thành khi mang theo ít nhất một vật bị nguyền rủa"
  },
  Task_49772_Name = {
    Text = "Kho báu kỳ binh"
  },
  Task_49773_Desc = {
    Text = "Nhận được ít nhất 4 loại khắc ấn khác nhau"
  },
  Task_49773_Name = {
    Text = "Ấn ký linh hồn"
  },
  Task_49774_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_49774_Name = {
    Text = "Thanh lịch và chính xác"
  },
  Task_49775_Desc = {
    Text = "Cuộc chiến cuối cùng trong một lượt đánh ra ít nhất 7 thẻ bài"
  },
  Task_49775_Name = {
    Text = "Lượt của tôi"
  },
  Task_49776_Desc = {
    Text = "Hoàn thành khi thức tỉnh tất cả các thân thể"
  },
  Task_49776_Name = {
    Text = "Vô tận ôm ấp"
  },
  Task_49777_Desc = {
    Text = "Khi hoàn thành, số lượng thẻ triệu chứng không vượt quá 2"
  },
  Task_49777_Name = {
    Text = "Tiết kiệm năng lượng"
  },
  Task_49778_Desc = {
    Text = "Trong bất kỳ cuộc chiến đấu nào, tiêu diệt ít nhất 2 con quái vật trong một hiệp"
  },
  Task_49778_Name = {
    Text = "Xử lý triệt để"
  },
  Task_49779_Desc = {
    Text = "Hoàn thành khi mang theo ít nhất một vật bị nguyền rủa"
  },
  Task_49779_Name = {
    Text = "Kho báu kỳ binh"
  },
  Task_49780_Desc = {
    Text = "Nhận được ít nhất 4 loại khắc ấn khác nhau"
  },
  Task_49780_Name = {
    Text = "Ấn ký linh hồn"
  },
  Task_49781_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_49781_Name = {
    Text = "Thanh lịch và chính xác"
  },
  Task_49782_Desc = {
    Text = "Cuộc chiến cuối cùng trong một lượt đánh ra ít nhất 7 thẻ bài"
  },
  Task_49782_Name = {
    Text = "Lượt của tôi"
  },
  Task_49783_Desc = {
    Text = "Hoàn thành khi thức tỉnh tất cả các thân thể"
  },
  Task_49783_Name = {
    Text = "Vô tận ôm ấp"
  },
  Task_49784_Desc = {
    Text = "Khi hoàn thành, số lượng thẻ triệu chứng không vượt quá 2"
  },
  Task_49784_Name = {
    Text = "Tiết kiệm năng lượng"
  },
  Task_49785_Desc = {
    Text = "Cuộc chiến cuối cùng, trong một lượt tối thiểu tăng thêm lá chắn bằng 50% máu tối đa"
  },
  Task_49785_Name = {
    Text = "Thân hình bằng thép"
  },
  Task_49786_Desc = {
    Text = "Trong trận chiến tinh anh, gây ít nhất 4500 điểm sát thương trong một lượt"
  },
  Task_49786_Name = {
    Text = "Đòn toàn lực"
  },
  Task_49787_Desc = {
    Text = "Gây ít nhất 7300 điểm thương trong một lượt của trận đánh tinh anh"
  },
  Task_49787_Name = {
    Text = "Đòn toàn lực"
  },
  Task_49788_Desc = {
    Text = "Nhận được ít nhất 6 loại khắc ấn khác nhau"
  },
  Task_49788_Name = {
    Text = "Ấn ký linh hồn"
  },
  Task_49789_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_49789_Name = {
    Text = "Thanh lịch và chính xác"
  },
  Task_49790_Desc = {
    Text = "Hoàn thành khi mang theo ít nhất 7 tạo vật"
  },
  Task_49790_Name = {
    Text = "Kho báu kỳ binh"
  },
  Task_49791_Desc = {
    Text = "Khi hoàn thành, không sử dụng điểm liên lạc để hồi phục sức sống"
  },
  Task_49791_Name = {
    Text = "Người thiếu lửa"
  },
  Task_49792_Desc = {
    Text = "Gây ít nhất 9000 điểm thương trong một lượt ở trận chiến tinh anh"
  },
  Task_49792_Name = {
    Text = "Đòn toàn lực"
  },
  Task_49793_Desc = {
    Text = "Nhận được ít nhất 6 loại khắc ấn khác nhau"
  },
  Task_49793_Name = {
    Text = "Ấn ký linh hồn"
  },
  Task_49794_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_49794_Name = {
    Text = "Thanh lịch và chính xác"
  },
  Task_49795_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_49795_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_49796_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_49796_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_49797_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_49797_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_49798_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_49798_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_49799_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_49799_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_49800_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_49800_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_49801_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_49801_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_49802_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_49802_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_49803_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_49803_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_49804_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_49804_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_49805_Desc = {
    Text = "Hoàn thành khi mang theo ít nhất 7 tạo vật"
  },
  Task_49805_Name = {
    Text = "Kho báu kỳ binh"
  },
  Task_49806_Desc = {
    Text = "Khi hoàn thành, không sử dụng điểm liên lạc để hồi phục sức sống"
  },
  Task_49806_Name = {
    Text = "Người thiếu lửa"
  },
  Task_49807_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_49807_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_49808_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_49808_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_49809_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_49809_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_49810_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_49810_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_49811_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_49811_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_49812_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_49812_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_49813_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_49813_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_49814_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_49814_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_49815_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_49815_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_49816_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_49816_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_49817_Desc = {
    Text = "Khi hoàn thành, số lượng thẻ triệu chứng không vượt quá 2"
  },
  Task_49817_Name = {
    Text = "Tiết kiệm năng lượng"
  },
  Task_49818_Desc = {
    Text = "Trong cuộc chiến cuối cùng, tiêu diệt ít nhất 4 con quái vật trong một lượt"
  },
  Task_49818_Name = {
    Text = "Xử lý triệt để"
  },
  Task_49819_Desc = {
    Text = "Khi hoàn thành, số lượng thẻ triệu chứng không vượt quá 2"
  },
  Task_49819_Name = {
    Text = "Tiết kiệm năng lượng"
  },
  Task_49820_Desc = {
    Text = "Trong cuộc chiến cuối cùng, tiêu diệt ít nhất 4 con quái vật trong một lượt"
  },
  Task_49820_Name = {
    Text = "Xử lý triệt để"
  },
  Task_49821_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 18 lượt để giành chiến thắng"
  },
  Task_49821_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_49822_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_49822_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_49823_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_49823_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_49824_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_49824_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_49852_Desc = {
    Text = "Dọn dẹp mối đe dọa Nubia"
  },
  Task_49852_Name = {
    Text = "Mục tiêu"
  },
  Task_49853_Desc = {
    Text = "Tiến tới trong Tường Bão"
  },
  Task_49853_Name = {
    Text = "Mục tiêu"
  },
  Task_49854_Desc = {
    Text = "Bắt cóc binh sĩ Aran để hỏi về nơi có xác chết"
  },
  Task_49854_Name = {
    Text = "Mục tiêu"
  },
  Task_49855_Desc = {
    Text = "Tìm nguồn nước"
  },
  Task_49855_Name = {
    Text = "Mục tiêu"
  },
  Task_49856_Desc = {
    Text = "Đánh bại Kassia, đoạt lại di vật"
  },
  Task_49856_Name = {
    Text = "Mục tiêu"
  },
  Task_49857_Desc = {
    Text = "Cùng chiến đấu với Thái Di Sơ"
  },
  Task_49857_Name = {
    Text = "Mục tiêu"
  },
  Task_49858_Desc = {
    Text = "Thoát khỏi móng vuốt của Kassia"
  },
  Task_49858_Name = {
    Text = "Mục tiêu"
  },
  Task_49859_Desc = {
    Text = "Ngăn chặn nghi lễ tái sinh cây mẹ"
  },
  Task_49859_Name = {
    Text = "Mục tiêu"
  },
  Task_49860_Desc = {
    Text = "Đi sâu vào đại dương ý thức của cây mẹ phồn thịnh"
  },
  Task_49860_Name = {
    Text = "Mục tiêu"
  },
  Task_49861_Desc = {
    Text = "Giúp người Aran đuổi Nubia"
  },
  Task_49861_Name = {
    Text = "Mục tiêu"
  },
  Task_49862_Desc = {
    Text = "Tìm kiếm di tích cây mẹ"
  },
  Task_49862_Name = {
    Text = "Mục tiêu"
  },
  Task_49863_Desc = {
    Text = "Đánh bại cây mẹ"
  },
  Task_49863_Name = {
    Text = "Mục tiêu"
  },
  Task_49879_Desc = {
    Text = "Vòng tròn · Ramona tỷ lệ đồng điều ở cấp 10"
  },
  Task_50033_Desc = {
    Text = "Trong cuộc điều tra sự kiện \"@1@2\" gây cộng hưởng 6 lần"
  },
  Task_50033_Desc2 = {
    Text = "Trong sự kiện \"Dục Hà\", cảm ứng 6 lần"
  },
  Task_50033_Name2 = {
    Text = "Hồi Âm Vọng Tưởng II"
  },
  Task_50034_Desc = {
    Text = "Trong cuộc điều tra sự kiện \"@1@2\" cộng hưởng 9 lần"
  },
  Task_50034_Desc2 = {
    Text = "Trong sự kiện \"Dục Hà\", đã điều tra và cảm ứng tổng cộng 9 lần"
  },
  Task_50034_Name2 = {
    Text = "Vọng Niệm Hồi Âm III"
  },
  Task_50035_Desc = {
    Text = "Xác định 12 vị trí phân tích trong chương thứ bảy của tuyến chính \"@1@2\""
  },
  Task_50035_Desc2 = {
    Text = "Tìm 12 điểm tách trong chương bảy tuyến chính \"Dục Hà\""
  },
  Task_50035_Name2 = {
    Text = "Lời thì thầm ẩn chứa VII"
  },
  Task_50036_Desc = {
    Text = "Trong cuộc điều tra sự kiện \"@1@2\" cảm ứng 3 lần"
  },
  Task_50036_Desc2 = {
    Text = "Trong sự kiện \"Dục Hà\" cảm ứng 3 lần"
  },
  Task_50036_Name2 = {
    Text = "Hồi âm ảo niệm"
  },
  Task_50037_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"@1@2\""
  },
  Task_50037_Desc2 = {
    Text = "Hoàn thành sự kiện điều tra \"Yù Hé\""
  },
  Task_50037_Name2 = {
    Text = "Khi cây thánh bị lửa thiêng nuốt chửng"
  },
  Task_50038_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"Dục Hà\" mức độ khó khăn"
  },
  Task_50038_Name = {
    Text = "Khi cây thánh bị thiêu rụi, khó khăn"
  },
  Task_50039_Desc = {
    Text = "Trong cuộc điều tra sự kiện \"@1@2\" cảm ứng 11 lần"
  },
  Task_50039_Desc2 = {
    Text = "Trong sự kiện \"Dục Hà\", cảm ứng 11 lần"
  },
  Task_50039_Name2 = {
    Text = "Ám ảnh hồi âm IV"
  },
  Task_51106_Desc = {
    Text = "Sử dụng thức tỉnh thể vùng giới sâu thẳm để chiến thắng 2 lần trong \"bí ẩn kịch bản\""
  },
  Task_51107_Desc = {
    Text = "Hoàn thành mọi nhiệm vụ của \"bí ẩn kịch bản·hoàn thành\""
  },
  Task_51108_Desc = {
    Text = "Hoàn thành \"tình tiết xoay vòng\" bất kỳ độ khó nào"
  },
  Task_51109_Desc = {
    Text = "Bản ghi đặc nhiệm"
  },
  Task_51109_Name = {
    Text = "[đã bị bỏ hoang]"
  },
  Task_51110_Desc = {
    Text = "Sử dụng thân thể được đánh thức của vùng giới sâu thẳm để giành chiến thắng 1 lần trong \"bí ẩn kịch bản\""
  },
  Task_51111_Desc = {
    Text = "Bí ẩn kịch bản · giới vực"
  },
  Task_51112_Desc = {
    Text = "Sử dụng thân thể được đánh thức của giới vực hỗn loạn để thắng 1 lần trong \"bí ẩn kịch bản\""
  },
  Task_51113_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong siêu không gian để chiến thắng 2 lần ở \"bí ẩn kịch bản\""
  },
  Task_51114_Desc = {
    Text = "Hoàn thành \"catharsis\"ở bất kỳ độ khó nào"
  },
  Task_51115_Desc = {
    Text = "Sử dụng thân thể được đánh thức từ giới vực hỗn loạn để giành chiến thắng 2 lần trong \"bí ẩn kịch bản\""
  },
  Task_51116_Desc = {
    Text = "Hoàn thành \"Kịch Trò Mặt Nạ\"ở bất kỳ độ khó nào"
  },
  Task_51117_Desc = {
    Text = "Hoàn thành \"Ba nguyên tắc\"ở bất kỳ mức độ khó nào"
  },
  Task_51118_Desc = {
    Text = "Sử dụng thân thể được đánh thức siêu giới vực để giành chiến thắng một lần trong \"bí ẩn kịch bản\""
  },
  Task_51119_Desc = {
    Text = "Hoàn thành \"lý thuyết tia điện\"ở bất kỳ độ khó nào"
  },
  Task_51120_Desc = {
    Text = "Hoàn thành \"Kim Tự Tháp Kịch Bản\"ở mọi cấp độ"
  },
  Task_51121_Desc = {
    Text = "Sử dụng thân thể được đánh thức của giới vực thịt máu để chiến thắng 1 lần trong \"bí ẩn kịch bản\""
  },
  Task_51122_Desc = {
    Text = "Hoàn thành \"tường thứ tư trong kịch nghệ\"ở bất kỳ độ khó nào"
  },
  Task_51123_Desc = {
    Text = "Hoàn thành \"Hiệu ứng Lạ Hóa\" bất kỳ độ khó nào"
  },
  Task_51124_Desc = {
    Text = "Bí ẩn kịch bản·hoàn thành"
  },
  Task_51125_Desc = {
    Text = "Sử dụng thân thể được đánh thức của giới vực thịt máu để chiến thắng 2 lần trong \"bí ẩn kịch bản\""
  },
  Task_51126_Desc = {
    Text = "Hoàn thành \"thời khắc yên lặng\"ở bất kỳ độ khó nào"
  },
  Task_51140_Desc = {
    Text = "Hoàn thành đặc vụ hồ sơ\"câu chuyện phép thuật\""
  },
  Task_51141_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"{s1}\""
  },
  Task_51141_Name = {
    Text = "[đã bị bỏ hoang]"
  },
  Task_51142_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"{s1}\""
  },
  Task_51142_Name = {
    Text = "[đã bị bỏ hoang]"
  },
  Task_51143_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"{s1}\""
  },
  Task_51143_Name = {
    Text = "[đã bị bỏ hoang]"
  },
  Task_51144_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"{s1}\""
  },
  Task_51144_Name = {
    Text = "[đã bị bỏ hoang]"
  },
  Task_51145_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"{s1}\""
  },
  Task_51145_Name = {
    Text = "[đã bị bỏ hoang]"
  },
  Task_51146_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"{s1}\""
  },
  Task_51146_Name = {
    Text = "[đã bị bỏ hoang]"
  },
  Task_52280_Desc = {
    Text = "\"đàn tế ngọc lệ\" hiến tế phẩm để nhận 100 lần phần thưởng"
  },
  Task_52281_Desc = {
    Text = "\"đàn tế ngọc lệ\" dâng lễ vật nhận 200 lần phần thưởng"
  },
  Task_52282_Desc = {
    Text = "Sử dụng thân thể được đánh thức từ giới vực hỗn loạn và giành chiến thắng 2 lần tại \"Lễ tế thẳm sâu\""
  },
  Task_52283_Desc = {
    Text = "Lễ tế thẳm sâu·hoàn thành"
  },
  Task_52284_Desc = {
    Text = "Hoàn thành \"chứng kiến\"ở bất kỳ độ khó nào"
  },
  Task_52285_Desc = {
    Text = "Sử dụng thân thể được đánh thức vùng giới sâu thẳm để chiến thắng 1 lần trong \"Lễ tế thẳm sâu\""
  },
  Task_52286_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong giới vực sâu thẳm để chiến thắng 2 lần trong \"Lễ tế thẳm sâu\""
  },
  Task_52287_Desc = {
    Text = "Hoàn thành \"tin tưởng\"ở bất kỳ độ khó nào"
  },
  Task_52288_Desc = {
    Text = "Sử dụng thân thể được đánh thức của giới vực hỗn loạn để chiến thắng 1 lần trong \"Lễ tế thẳm sâu\""
  },
  Task_52289_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong vực giới máu thịt để chiến thắng 1 lần trong \"Lễ tế thẳm sâu\""
  },
  Task_52290_Desc = {
    Text = "Lễ tế thẳm sâu·giới vực"
  },
  Task_52291_Desc = {
    Text = "Hoàn thành Thế giới Mộng Ảo \"Phỉ báng\""
  },
  Task_52292_Desc = {
    Text = "\"bàn tế huyết tinh\" dâng đồ hiến tế để nhận 100 lần thưởng"
  },
  Task_52293_Desc = {
    Text = "\"bàn tế huyết tinh\" hiến tế lễ vật để nhận 200 lần thưởng"
  },
  Task_52294_Desc = {
    Text = "\"đàn tế linh tủy\" hiến tế để nhận 200 phần thưởng"
  },
  Task_52295_Desc = {
    Text = "\"đàn tế linh tủy\" hiến tế để nhận 100 lần thưởng"
  },
  Task_52296_Desc = {
    Text = "Hoàn thành \"thách thức\" bất kỳ độ khó nào"
  },
  Task_52297_Desc = {
    Text = "Hoàn thành \"độnglắc\"ở bất kỳ độ khó nào"
  },
  Task_52298_Desc = {
    Text = "Sử dụng thân thể được đánh thức từ giới vực thịt máu để chiến thắng 2 lần trong \"Lễ tế thẳm sâu\""
  },
  Task_52299_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong siêu giới vực để chiến thắng 1 lần tại \"Lễ tế thẳm sâu\""
  },
  Task_52300_Desc = {
    Text = "Hoàn thành \"đến\"ở mọi cấp độ"
  },
  Task_52301_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong siêu không gian giới vực để giành chiến thắng 2 lần tại \"Lễ tế thẳm sâu\""
  },
  Task_52302_Desc = {
    Text = "Phản hồi của vực thẳm"
  },
  Task_52303_Desc = {
    Text = "Hoàn thành tất cả nhiệm vụ \"Lễ tế thẳm sâu - Hoàn thành\" và \"Hồi đáp của vực sâu\""
  },
  Task_53694_Desc = {
    Text = "\"Ion Hoạt Tính Tinh Túy\"đạt 1000"
  },
  Task_53695_Desc = {
    Text = "Đã tích lũy hoàn thành 20 lần phái đi"
  },
  Task_53696_Desc = {
    Text = "Ngày đầu tiên trở lại trường"
  },
  Task_53697_Desc = {
    Text = "Sử dụng thân thể được đánh thức từ giới vực hỗn loạn để đạt được 3 chiến thắng"
  },
  Task_53698_Desc = {
    Text = "Thích người khác 10 lần trong hội cựu sinh viên"
  },
  Task_53699_Desc = {
    Text = "Ngày 6 trở lại trường học"
  },
  Task_53700_Desc = {
    Text = "Ngày thứ 5 trở lại trường và báo cáo"
  },
  Task_53701_Desc = {
    Text = "Ngày thứ tư"
  },
  Task_53702_Desc = {
    Text = "Ngày thứ hai"
  },
  Task_53703_Desc = {
    Text = "Ngày thứ ba"
  },
  Task_53704_Desc = {
    Text = "Ngày đầu tiên"
  },
  Task_53705_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong siêu không gian giới vực để giành 3 chiến thắng"
  },
  Task_53706_Desc = {
    Text = "Ngày thứ tư đăng ký nhập học"
  },
  Task_53707_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong giới vực thịt máu để giành được 3 chiến thắng"
  },
  Task_53708_Desc = {
    Text = "Đạt được 3 chiến thắng bằng cách sử dụng thân thể được đánh thức từ biển sâu và giới vực"
  },
  Task_53709_Desc = {
    Text = "Ngày 2 trở lại trường học"
  },
  Task_53710_Desc = {
    Text = "Hoàn thành bất kỳ lần nuôi dưỡng thân thức tỉnh nào"
  },
  Task_53711_Desc = {
    Text = "Tích lũy tiêu thụ 50000 quyền vàng hồng"
  },
  Task_53712_Desc = {
    Text = "Tích lũy tiêu hao 1500 điểm Enkephalin"
  },
  Task_53713_Desc = {
    Text = "\"Ion Hoạt Tính Tinh Túy\"đạt 500"
  },
  Task_53714_Desc = {
    Text = "Tích lũy tiêu thụ 5 triệu quyền vàng hồng"
  },
  Task_53715_Desc = {
    Text = "Thực hiện tổng cộng 20 lần lễ thức đánh thức trong bất kỳ hoạt động thức tỉnh nào"
  },
  Task_53716_Desc = {
    Text = "Vượt qua một lần Vùng đất vô ánh sáng hoặc Thực thể siêu việt"
  },
  Task_53717_Desc = {
    Text = "Sử dụng thể xác được thức tỉnh của cựu học sinh để hỗ trợ chiến đấu 10 lần"
  },
  Task_53718_Desc = {
    Text = "Ngày thứ 3 trở lại trường"
  },
  Task_53719_Desc = {
    Text = "Sử dụng sức mạnh đã thức tỉnh của cựu sinh viên để hỗ trợ chiến đấu"
  },
  Task_53720_Desc = {
    Text = "Trong cửa hàng, sử dụng vé vàng để đổi 3 lần"
  },
  Task_53721_Desc = {
    Text = "Tiêu hao 180 điểm Enkephalin"
  },
  Task_53722_Desc = {
    Text = "Gửi đi 3 lần"
  },
  Task_53723_Desc = {
    Text = "Ngày thứ 7 báo cáo trở lại trường học"
  },
  Task_53724_Desc = {
    Text = "\"Ion Hoạt Tính Cơ Bản\"đạt 1000"
  },
  Task_53725_Desc = {
    Text = "Hoàn thành 1 lần chơi thử thân thể được thức tỉnh"
  },
  Task_53726_Desc = {
    Text = "Thực hiện một lần thức tỉnh"
  },
  Task_53982_Desc = {
    Text = "Sử dụng thân thể được đánh thức của giới vực hỗn loạn để chiến thắng 1 lần trong \"Hoa Hồng Ký Sự\""
  },
  Task_53983_Desc = {
    Text = "Hoàn thành \"trò chơi con rối\"ở mọi độ khó"
  },
  Task_53984_Desc = {
    Text = "Hoàn thành \"ánh mắt\"ở bất kỳ độ khó nào"
  },
  Task_53985_Desc = {
    Text = "Sử dụng thân thể được đánh thức giới vực thịt máu để chiến thắng 2 lần trong \"Hoa Hồng Ký Ức\""
  },
  Task_53986_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong giới vực thịt máu để giành chiến thắng tại \"Hồi Ức Hoa Hồng\""
  },
  Task_53987_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong giới vực hỗn loạn để chiến thắng 2 lần ở \"Hồi Ức Hoa Hồng\""
  },
  Task_53988_Desc = {
    Text = "Hồi ức Hoa Hồng · giới vực"
  },
  Task_53989_Desc = {
    Text = "Sử dụng thân thể được đánh thức từ vùng giới sâu thẳm để chiến thắng 1 lần trong \"Hoa hồng nhớ lại\""
  },
  Task_53990_Desc = {
    Text = "Sử dụng thân thể được đánh thức vùng giới sâu thẳm để chiến thắng 2 lần trong \"Hồi Ức Hoa Hồng\""
  },
  Task_53991_Desc = {
    Text = "Hoàn thành tất cả nhiệm vụ \"Quỳnh Hoa Hồi Ức·hoàn thành\""
  },
  Task_53992_Desc = {
    Text = "Hoàn thành \"Kịch Bản Chưa Hoàn Thành\" bất kỳ độ khó nào"
  },
  Task_53993_Desc = {
    Text = "Sử dụng thân thể được đánh thức siêu không gian giới vực để chiến thắng 1 lần trong \"Nhật Ký Hoa Hồng\""
  },
  Task_53994_Desc = {
    Text = "Hoàn thành \"Góc Hoa Hồng\"ở bất kỳ độ khó nào"
  },
  Task_53995_Desc = {
    Text = "Qiáng Vi · Hoàn thành"
  },
  Task_53996_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong siêu không gian giới vực để chiến thắng 2 lần trong \"Hoa Hồng Ký Sự\""
  },
  Task_53997_Desc = {
    Text = "Hoàn thành \"Chú Hai Chân Dài\"ở bất kỳ độ khó nào"
  },
  Task_53998_Desc = {
    Text = "Hoàn thành \"quà tặng\" mọi độ khó"
  },
  Task_53999_Desc = {
    Text = "Hoàn thành \"Khúc cuối\"ở bất kỳ độ khó nào"
  },
  Task_54000_Desc = {
    Text = "Hoàn thành \"đáy nồi Du Ngư\"ở bất kỳ độ khó nào"
  },
  Task_54001_Desc = {
    Text = "Hoàn thành \"mặt\"ở bất kỳ mức độ khó nào"
  },
  Task_54542_Desc = {
    Text = "Đạt được tích lũy 1 trận thắng trong mùa giải này"
  },
  Task_54542_Name = {
    Text = "1 trận thắng"
  },
  Task_54543_Desc = {
    Text = "Đạt được tổng cộng 6 trận thắng trong mùa giải này"
  },
  Task_54543_Name = {Text = "6 thắng"},
  Task_54544_Desc = {
    Text = "Đạt được 3 trận thắng trong mùa giải này"
  },
  Task_54544_Name = {
    Text = "3 trận thắng"
  },
  Task_54545_Desc = {
    Text = "Đạt được tổng cộng 10 trận thắng trong mùa giải này"
  },
  Task_54545_Name = {Text = "10 thắng"},
  Task_54546_Desc = {
    Text = "Đạt được tích lũy 1 trận thắng trong mùa giải này"
  },
  Task_54546_Name = {
    Text = "1 trận thắng"
  },
  Task_54547_Desc = {
    Text = "Đạt được tổng cộng 10 trận thắng trong mùa giải này"
  },
  Task_54547_Name = {Text = "10 thắng"},
  Task_54548_Desc = {
    Text = "Đạt được tổng cộng 10 trận thắng trong mùa giải này"
  },
  Task_54548_Name = {Text = "10 thắng"},
  Task_54549_Desc = {
    Text = "Đạt được tổng cộng 6 trận thắng trong mùa giải này"
  },
  Task_54549_Name = {Text = "6 thắng"},
  Task_54550_Desc = {
    Text = "Đạt được tích lũy 1 trận thắng trong mùa giải này"
  },
  Task_54550_Name = {
    Text = "1 trận thắng"
  },
  Task_54551_Desc = {
    Text = "Đạt được 3 trận thắng trong mùa giải này"
  },
  Task_54551_Name = {
    Text = "3 trận thắng"
  },
  Task_54552_Desc = {
    Text = "Đạt được tổng cộng 6 trận thắng trong mùa giải này"
  },
  Task_54552_Name = {Text = "6 thắng"},
  Task_54553_Desc = {
    Text = "Đạt được 3 trận thắng trong mùa giải này"
  },
  Task_54553_Name = {
    Text = "3 trận thắng"
  },
  Task_54554_Desc = {
    Text = "Đạt được tổng cộng 6 trận thắng trong mùa giải này"
  },
  Task_54554_Name = {Text = "6 thắng"},
  Task_54555_Desc = {
    Text = "Đạt được tích lũy 1 trận thắng trong mùa giải này"
  },
  Task_54555_Name = {
    Text = "1 trận thắng"
  },
  Task_54556_Desc = {
    Text = "Đạt được tổng cộng 10 trận thắng trong mùa giải này"
  },
  Task_54556_Name = {Text = "10 thắng"},
  Task_54557_Desc = {
    Text = "Đạt được 3 trận thắng trong mùa giải này"
  },
  Task_54557_Name = {
    Text = "3 trận thắng"
  },
  Task_54585_Desc = {
    Text = "Tích lũy trích xuất 1 000 nguồn lỏng"
  },
  Task_54586_Desc = {
    Text = "Tổng cộng đã chiết xuất 3000 nguồn lỏng"
  },
  Task_54587_Desc = {
    Text = "Tổng cộng đã trích xuất 6000 nguồn lỏng"
  },
  Task_54588_Desc = {
    Text = "Đã chiết xuất 10000 nguồn lỏng"
  },
  Task_54589_Desc = {
    Text = "Đã trích xuất tổng cộng 30000 nguồn lỏng"
  },
  Task_54590_Desc = {
    Text = "Lũy kế trích xuất 60000 nguồn lỏng"
  },
  Task_54591_Desc = {
    Text = "Lũy kế trích xuất 100000 nguồn lỏng"
  },
  Task_55092_Desc = {
    Text = "Hoàn thành tất cả các nhiệm vụ trong chương này sẽ nhận được"
  },
  Task_55092_Name = {
    Text = "Giới Vực Tinh Thông VII"
  },
  Task_55093_Desc = {
    Text = "Hoàn thành tất cả các nhiệm vụ trong chương này sẽ nhận được"
  },
  Task_55093_Name = {
    Text = "Giới vực tinh thông VI"
  },
  Task_55094_Desc = {
    Text = "Nâng cấp 3 nhân vật thịt máu lên cấp độ 60"
  },
  Task_55094_Name = {
    Text = "Giới Vực Tinh Thông VII"
  },
  Task_55095_Desc = {
    Text = "Nâng 3 nhân vật biển sâu đạt cấp 60"
  },
  Task_55095_Name = {
    Text = "Giới Vực Tinh Thông VII"
  },
  Task_55096_Desc = {
    Text = "Nâng cấp 3 nhân vật thuộc phe hỗn loạn lên level 60"
  },
  Task_55096_Name = {
    Text = "Giới Vực Tinh Thông VII"
  },
  Task_55097_Desc = {
    Text = "Hoàn thành tất cả các nhiệm vụ trong chương này sẽ nhận được"
  },
  Task_55097_Name = {
    Text = "Giới vực tinh thông VIII"
  },
  Task_55098_Desc = {
    Text = "Nâng cấp 3 nhân vật vượt trội lên cấp 60"
  },
  Task_55098_Name = {
    Text = "Giới Vực Tinh Thông VII"
  },
  Task_55099_Desc = {
    Text = "Nâng cấp một nhân vật siêu việt lên cấp 60"
  },
  Task_55099_Name = {
    Text = "Giới vực tinh thông VI"
  },
  Task_55100_Desc = {
    Text = "Nâng cấp 1 nhân vật hỗn loạn lên cấp 60"
  },
  Task_55100_Name = {
    Text = "Giới vực tinh thông VI"
  },
  Task_55101_Desc = {
    Text = "Nâng cấp 1 tướng biển sâu lên cấp 60"
  },
  Task_55101_Name = {
    Text = "Giới vực tinh thông VI"
  },
  Task_55102_Desc = {
    Text = "Nâng cấp 1 nhân vật thịt máu lên cấp độ 60"
  },
  Task_55102_Name = {
    Text = "Giới vực tinh thông VI"
  },
  Task_55103_Desc = {
    Text = "Tăng cấp độ 6 nhân vật siêu việt lên cấp 60"
  },
  Task_55103_Name = {
    Text = "Giới vực tinh thông VIII"
  },
  Task_55104_Desc = {
    Text = "Nâng cấp 6 nhân vật biển sâu lên cấp 60"
  },
  Task_55104_Name = {
    Text = "Giới vực tinh thông VIII"
  },
  Task_55105_Desc = {
    Text = "Nâng cấp 6 nhân vật thịt máu lên cấp độ 60"
  },
  Task_55105_Name = {
    Text = "Giới vực tinh thông VIII"
  },
  Task_55106_Desc = {
    Text = "Nâng cấp 6 nhân vật hỗn loạn lên cấp 60"
  },
  Task_55106_Name = {
    Text = "Giới vực tinh thông VIII"
  },
  Task_55177_Desc = {
    Text = "Hoàn thành tất cả Thành Tựu \"Khu vườn ký ức·Hoàn thành\""
  },
  Task_55178_Desc = {
    Text = "Vườn vãng sự · giới vực"
  },
  Task_55179_Desc = {
    Text = "Nhà hoa của Colette"
  },
  Task_55180_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong giới vực hỗn loạn, chiến thắng 2 lần ở \"Ký Ức Vườn Hoa\""
  },
  Task_55181_Desc = {
    Text = "Hoàn thành \"Vương quốc bé nhỏ\"ở bất kỳ độ khó nào"
  },
  Task_55182_Desc = {
    Text = "Sử dụng thân thể được đánh thức bởi giới vực hỗn loạn và giành chiến thắng 1 lần tại \"Kí Ức Vườn Hoa\""
  },
  Task_55183_Desc = {
    Text = "Khu vườn cũ·Hoàn thành"
  },
  Task_55184_Desc = {
    Text = "Hoàn thành \"Thánh Thi Nở Rộ\"ở bất kỳ độ khó nào"
  },
  Task_55185_Desc = {
    Text = "Trong \"vườn hồng\"đổi chỗ thơ văn nhận được 100 lần phản hồi"
  },
  Task_55186_Desc = {
    Text = "Trong \"vườn hồng\"đổi chỗ thơ văn nhận được 200 lần phản hồi"
  },
  Task_55187_Desc = {
    Text = "Hoàn thành \"Tro tàn\"ở bất kỳ độ khó nào"
  },
  Task_55188_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong giới vực thịt máu để chiến thắng 2 lần trong \"Kỷ Niệm Vườn Hoa\""
  },
  Task_55189_Desc = {
    Text = "Trong \"Vườn Cúc Cánh Buồn(Platycodon Garden)\" trao đổi thơ văn nhận được 200 lần hồi đáp"
  },
  Task_55190_Desc = {
    Text = "Trong \"Vườn Hoa Kikyo\" trao đổi thơ văn để nhận được 100 lần phản hồi"
  },
  Task_55191_Desc = {
    Text = "Sử dụng thân thể được đánh thức của giới vực thịt máu để giành chiến thắng 1 lần trong \"Ký Ức Vườn Hoa\""
  },
  Task_55192_Desc = {
    Text = "Hoàn thành ghi chép đặc nhiệm \"địa điểm cư trú của hoa hồng\""
  },
  Task_55193_Desc = {
    Text = "Hoàn thành \"Chấp Thủ\"ở bất kỳ độ khó nào"
  },
  Task_55194_Desc = {
    Text = "Hoàn thành \"Bông Hồng Đầu Tiên\"ở bất kỳ độ khó nào"
  },
  Task_55195_Desc = {
    Text = "Trong \"vườn diên vĩ\" trao đổi thơ văn nhận được 200 lần phản hồi"
  },
  Task_55196_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong siêu không gian giới vực để giành chiến thắng 1 lần trong \"Kỷ Niệm Vườn Hoa\""
  },
  Task_55197_Desc = {
    Text = "Sử dụng thân thể được đánh thức siêu việt giới vực để chiến thắng 2 lần trong \"Kỷ Niệm Vườn Hoa\""
  },
  Task_55198_Desc = {
    Text = "Sử dụng thân thể được đánh thức của vùng giới sâu thẳm để chiến thắng 2 lần trong \"Vườn Hoa Xưa\""
  },
  Task_55199_Desc = {
    Text = "Sử dụng thân thể được đánh thức vùng giới sâu thẳm để chiến thắng 1 lần trong \"Kí ức Vườn\""
  },
  Task_55200_Desc = {
    Text = "Trong \"vườn diên vĩ\" trao đổi thơ văn nhận được 100 lần hồi đáp"
  },
  Task_55426_Desc = {
    Text = "Đánh bại Colette"
  },
  Task_55426_Name = {
    Text = "Mục tiêu"
  },
  Task_55852_Desc = {
    Text = "Nâng cấp 1 thức tỉnh giả lên cấp 70"
  },
  Task_55852_Name = {
    Text = "Nhiệm vụ 2"
  },
  Task_55853_Desc = {
    Text = "Hoàn thành điều tra hành động · Chế độ Thường Chương 7"
  },
  Task_55853_Name = {
    Text = "Nhiệm vụ 3"
  },
  Task_55854_Desc = {
    Text = "Nâng cấp 4 thể xác được đánh thức lên level 62"
  },
  Task_55854_Name = {
    Text = "Nhiệm vụ 1"
  },
  Task_55855_Desc = {
    Text = "Bất kỳ thân thể được đánh thức nào đạt đến cấp độ nhân cách 4 sau khi khởi linh"
  },
  Task_55855_Name = {
    Text = "Nhiệm vụ 4"
  },
  Task_55856_Desc = {
    Text = "Giá trị rèn luyện hòa hợp với thiên tai đạt 150"
  },
  Task_55856_Name = {
    Text = "Nhiệm vụ 5"
  },
  Task_55857_Desc = {
    Text = "Hoàn thành tất cả các nhiệm vụ trong giai đoạn để nhận phần thưởng"
  },
  Task_55857_Name = {
    Text = "Giai đoạn thứ tám"
  },
  Task_55858_Desc = {
    Text = "Hoàn thành tất cả các nhiệm vụ trong giai đoạn để nhận phần thưởng"
  },
  Task_55858_Name = {
    Text = "Cấp độ bảy"
  },
  Task_55859_Desc = {
    Text = "Nâng cấp 1 thể xác được đánh thức lên cấp 62"
  },
  Task_55859_Name = {
    Text = "Nhiệm vụ 2"
  },
  Task_55860_Desc = {
    Text = "Hoàn thành điều tra hành động · Chế độ thông thường chương 6"
  },
  Task_55860_Name = {
    Text = "Nhiệm vụ 3"
  },
  Task_55861_Desc = {
    Text = "Nâng cấp bất kỳ kỹ năng thân thể được đánh thức lên level 6"
  },
  Task_55861_Name = {
    Text = "Nhiệm vụ 1"
  },
  Task_55862_Desc = {
    Text = "Kích hoạt bất kỳ năng lực được thức tỉnh 1 lần"
  },
  Task_55862_Name = {
    Text = "Nhiệm vụ 4"
  },
  Task_55863_Desc = {
    Text = "Giá trị huấn luyện đặc biệt hòa hợp với thiên tai đạt 50"
  },
  Task_55863_Name = {
    Text = "Nhiệm vụ 5"
  },
  Task_56002_Desc = {
    Text = "Hoàn thành duy thức tiềm hành \"Sự sụp đổ của người khổng lồ\"ở mức khó"
  },
  Task_56002_Name = {
    Text = "Vô địch dũng mãnh·khó khăn"
  },
  Task_56003_Desc = {
    Text = "Hoàn thành duy thức tiềm hành \"Mọi thứ vẫn như thường\" khó khăn"
  },
  Task_56003_Name = {
    Text = "Thành phố không nhìn thấy·khó khăn"
  },
  Task_56004_Desc = {
    Text = "Hoàn thành duy thức tiềm hành \"Sự sụp đổ của người khổng lồ\""
  },
  Task_56004_Name = {
    Text = "Dũng mãnh vô song"
  },
  Task_56005_Desc = {
    Text = "Hoàn thành bản ghi đặc nhiệm \"Chia đôi yên bình\"ở độ khó khó"
  },
  Task_56005_Name = {
    Text = "Trở về nguồn cội của dòng sông·khó khăn"
  },
  Task_56006_Desc = {
    Text = "Hoàn thành bản ghi đặc nhiệm \"Màu máu\" khó khăn"
  },
  Task_56006_Name = {
    Text = "Tình yêu vĩnh cửu · khó khăn"
  },
  Task_56007_Desc = {
    Text = "Hoàn thành bản ghi đặc nhiệm \"Bình yên của sự chia đôi\""
  },
  Task_56007_Name = {
    Text = "Trở về suối nguồn"
  },
  Task_56008_Desc = {
    Text = "Hoàn thành bản ghi đặc nhiệm \"Màu máu\""
  },
  Task_56008_Name = {
    Text = "Tình yêu nhân ái vĩnh cửu"
  },
  Task_56009_Desc = {
    Text = "Hoàn thành Thế giới Mộng Ảo \"Phỉ báng\""
  },
  Task_56009_Name = {
    Text = "Sự cuồng tín bị bóp méo"
  },
  Task_56103_Desc = {
    Text = "Áp đặt 50000 lớp trúng độc lên kẻ địch"
  },
  Task_56103_Name = {
    Text = "Độc Thực Tại III"
  },
  Task_56104_Desc = {
    Text = "Khiến địch tích lũy 100000 tầng trúng độc"
  },
  Task_56104_Name = {
    Text = "Độc chất Hiện Thực IV"
  },
  Task_56106_Desc = {
    Text = "Có 6 thân thể được đánh thức cấp độ 80"
  },
  Task_56106_Name = {
    Text = "\"Lực Vượt Giới Hạn\" V"
  },
  Task_56107_Desc = {
    Text = "Hoàn thành \"Bên kia bầu trời\" trong thế giới mộng mơ"
  },
  Task_56107_Name = {
    Text = "Rơi xuống"
  },
  Task_56108_Desc = {
    Text = "Hoàn thành 200 lần Thám hiểm Giấc mơ"
  },
  Task_56108_Name = {
    Text = "Cuộc Phiêu Lưu Của Mộng Tâm"
  },
  Task_56109_Desc = {
    Text = "Hoàn thành 300 lần Khám phá Giấc mơ"
  },
  Task_56109_Name = {
    Text = "Hành Giả Giấc Mơ"
  },
  Task_56110_Desc = {
    Text = "Hoàn thành 500 lần Thám hiểm Giấc mơ"
  },
  Task_56110_Name = {
    Text = "Người thao túng giấc mơ"
  },
  Task_56111_Desc = {
    Text = "Có 8 thể xác được đánh thức cấp 80"
  },
  Task_56111_Name = {
    Text = "\"Lực lượng vượt trội\" VI"
  },
  Task_56112_Desc = {
    Text = "Sở hữu 10 thân thể được đánh thức cấp 80"
  },
  Task_56112_Name = {
    Text = "\"Lực lượng Siêu việt\" VII"
  },
  Task_56113_Desc = {
    Text = "Đạt tỷ lệ đồng điều cấp độ 10 với 8 thân thể được đánh thức"
  },
  Task_56113_Name = {
    Text = "Gặp gỡ vốn không cần từng quen biết"
  },
  Task_56115_Desc = {
    Text = "Nguyên liệu tổng hợp 11111 lần"
  },
  Task_56115_Name = {
    Text = "Crucible đang vận hành với tốc độ cao vào Misaque"
  },
  Task_56116_Desc = {
    Text = "Sở hữu 200 món đồ bí ẩn cấp 12"
  },
  Task_56116_Name = {
    Text = "Cấm kỵ Người bảo vệ IV"
  },
  Task_56117_Desc = {
    Text = "Đồng điệu với 4 thân thể được đánh thức, tỷ lệ đồng điều đạt cấp độ 10"
  },
  Task_56117_Name = {
    Text = "Đối tác ăn ý IX"
  },
  Task_56118_Desc = {
    Text = "Nâng cấp kỹ năng thể thức tỉnh 400 lần"
  },
  Task_56118_Name = {
    Text = "\"Tinh Thông Các Loại Vũ Khí\" II"
  },
  Task_56120_Desc = {
    Text = "Có 30 thể xác được đánh thức cấp 80"
  },
  Task_56120_Name = {
    Text = "Tuyên chiến với hư vô III"
  },
  Task_56121_Desc = {
    Text = "Sở hữu 25 thân thể thức tỉnh cấp 80"
  },
  Task_56121_Name = {
    Text = "Tuyên chiến với hư vô II"
  },
  Task_56122_Desc = {
    Text = "Có 20 thân thể thức tỉnh cấp 80"
  },
  Task_56122_Name = {
    Text = "Tuyên chiến với hư vô I"
  },
  Task_56123_Desc = {
    Text = "Sở hữu 15 thể thức tỉnh cấp 80"
  },
  Task_56123_Name = {
    Text = "\"Lực Siêu Việt\" VIII"
  },
  Task_56126_Desc = {
    Text = "Sở hữu 40 thân thể được đánh thức cấp 80"
  },
  Task_56126_Name = {
    Text = "Tuyên chiến với hư vô V"
  },
  Task_56127_Desc = {
    Text = "Sở hữu 35 thân thể được đánh thức cấp 80"
  },
  Task_56127_Name = {
    Text = "Lời tuyên chiến chống lại hư vô IV"
  },
  Task_56128_Desc = {
    Text = "Tích lũy dùng 250000 dấu đen"
  },
  Task_56128_Name = {
    Text = "Chào mừng \"ánh sáng\"đến với V"
  },
  Task_56129_Desc = {
    Text = "Tích lũy tiêu thụ 1000000 dấu đen"
  },
  Task_56129_Name = {
    Text = "Chào mừng \"ánh sáng\"đến với VII"
  },
  Task_56130_Desc = {
    Text = "Tích lũy tiêu thụ 500000 dấu đen"
  },
  Task_56130_Name = {
    Text = "Chào mừng \"ánh sáng\"đến VI"
  },
  Task_56131_Desc = {
    Text = "Nâng cấp kỹ năng thân thể được đánh thức 800 lần"
  },
  Task_56131_Name = {
    Text = "\"Thành Thạo Mọi Vũ Khí\" VI"
  },
  Task_56132_Desc = {
    Text = "Nâng cấp kỹ năng thân thể được đánh thức 700 lần"
  },
  Task_56132_Name = {
    Text = "\"Chư Vũ Tinh Thông\" V"
  },
  Task_56133_Desc = {
    Text = "Nâng cấp kỹ năng thân thể được đánh thức 600 lần"
  },
  Task_56133_Name = {
    Text = "\"Thành Thục Mọi Vũ Khí\" IV"
  },
  Task_56134_Desc = {
    Text = "Nâng cấp kỹ năng thân thể được đánh thức 500 lần"
  },
  Task_56134_Name = {
    Text = "\"Thành Thục Mọi Vũ Khí\" III"
  },
  Task_56135_Desc = {
    Text = "Hoàn thành bí ẩn ghi chép 5000 lần"
  },
  Task_56135_Name = {
    Text = "Đen huyền ảo đầy sắc màu"
  },
  Task_56136_Desc = {
    Text = "Hoàn thành ghi chép bí ẩn 2500 lần"
  },
  Task_56136_Name = {
    Text = "Trái tim hay thay đổi"
  },
  Task_56137_Desc = {
    Text = "Hoàn thành bản ghi chép bí ẩn 1000 lần"
  },
  Task_56137_Name = {
    Text = "Dùng lại bản thảo ban đầu!"
  },
  Task_56138_Desc = {
    Text = "Nâng cấp kỹ năng thân thể được đánh thức 900 lần"
  },
  Task_56138_Name = {
    Text = "\"Chuyên Nghiệp Võ Thuật\" VII"
  },
  Task_56140_Desc = {
    Text = "Hoàn thành ghi chép bí ẩn 10000 lần"
  },
  Task_56140_Name = {
    Text = "Quỷ phe A"
  },
  Task_56156_Desc = {
    Text = "Vòng mệnh xếp chồng 800 lần"
  },
  Task_56156_Name = {
    Text = "Tương lai của rối lượng tử II"
  },
  Task_56157_Desc = {
    Text = "Vòng mệnh xếp chồng 900 lần"
  },
  Task_56157_Name = {
    Text = "Tương lai của vướng mắc lượng tử III"
  },
  Task_56161_Desc = {
    Text = "Tỷ lệ đồng điều Ôrla đạt cấp 10"
  },
  Task_56162_Desc = {
    Text = "Miriam tỷ lệ đồng điều đạt mức 10"
  },
  Task_56177_Desc = {
    Text = "Nhận được 80 loại vòng mệnh"
  },
  Task_56177_Name = {
    Text = "Người thêu dệt số phận"
  },
  Task_56178_Desc = {
    Text = "Nhận được 70 kiểu vòng mệnh khác nhau"
  },
  Task_56178_Name = {
    Text = "Người nắm giữ sự vô thường"
  },
  Task_56179_Desc = {
    Text = "Nâng cấp kỹ năng thân thể được đánh thức 300 lần"
  },
  Task_56179_Name = {
    Text = "\"Thành Thục Mọi Vũ Khí\" I"
  },
  Task_56180_Desc = {
    Text = "Vòng mệnh tầng 1100 lần"
  },
  Task_56180_Name = {
    Text = "Tương lai của rối lượng tử phần V"
  },
  Task_56181_Desc = {
    Text = "Vòng mệnh lớp chồng 1200 lần"
  },
  Task_56181_Name = {
    Text = "Tương lai của rối lượng tử VI"
  },
  Task_56182_Desc = {
    Text = "Thích 1000 lần"
  },
  Task_56182_Name = {
    Text = "Người bạo miệng trong giao tiếp"
  },
  Task_56184_Desc = {
    Text = "Thích 250 lần"
  },
  Task_56184_Name = {
    Text = "Một bước tiến lớn ra bên ngoài"
  },
  Task_56185_Desc = {
    Text = "Thích 500 lần"
  },
  Task_56185_Name = {
    Text = "Bước tiến lớn hướng tới thế giới"
  },
  Task_56186_Desc = {
    Text = "Phân giải 2000 vòng mệnh"
  },
  Task_56186_Name = {
    Text = "Chủ nhân của số phận"
  },
  Task_56187_Desc = {
    Text = "Phá hủy 1000 vòng mệnh"
  },
  Task_56187_Name = {
    Text = "Tóm chặt cổ họng của số phận"
  },
  Task_56188_Desc = {
    Text = "Nhận được 60 loại vòng mệnh khác nhau"
  },
  Task_56188_Name = {
    Text = "Đệ tử Số phận II"
  },
  Task_56189_Desc = {
    Text = "Sở hữu 50 loại vòng mệnh khác nhau"
  },
  Task_56189_Name = {
    Text = "Học trò của Số phận I"
  },
  Task_56191_Desc = {
    Text = "Vòng mệnh lặp vị trí 1000 lần"
  },
  Task_56191_Name = {
    Text = "Tương lai của rối lượng tử IV"
  },
  Task_56192_Desc = {
    Text = "Phân rã 500 vòng mệnh"
  },
  Task_56192_Name = {
    Text = "Thách thức số phận"
  },
  Task_56349_Desc = {
    Text = "Đánh lui thủ lĩnh \"Ái Kỷ Tư\""
  },
  Task_56349_Name = {
    Text = "Mục tiêu"
  },
  Task_56350_Desc = {
    Text = "Đẩy lui thủ lĩnh \"Đào Đen Đá\""
  },
  Task_56350_Name = {
    Text = "Mục tiêu"
  },
  Task_56351_Desc = {
    Text = "Đánh lùi thủ lĩnh \"Reia\""
  },
  Task_56351_Name = {
    Text = "Mục tiêu"
  },
  Task_56352_Desc = {
    Text = "Đánh lui thủ lĩnh \"Chí Ôrla\""
  },
  Task_56352_Name = {
    Text = "Mục tiêu"
  },
  Task_56353_Desc = {
    Text = "Đánh lui thủ lĩnh \"24\""
  },
  Task_56353_Name = {
    Text = "Mục tiêu"
  },
  Task_56412_Desc = {
    Text = "Hoàn thành \"Sự đến của Ngài\"ở bất kỳ độ khó nào"
  },
  Task_56413_Desc = {
    Text = "Hoàn thành \"Hành Hình Giả\" bất kỳ độ khó"
  },
  Task_56414_Desc = {
    Text = "Tử Cung Tối · hoàn thành"
  },
  Task_56415_Desc = {
    Text = "Hoàn thành \"Quấn Xác\"ở bất kỳ độ khó nào"
  },
  Task_56416_Desc = {
    Text = "Tử cung tối · giới vực"
  },
  Task_56417_Desc = {
    Text = "Hoàn thành \"ẩn náu\"ở bất kỳ độ khó nào"
  },
  Task_56420_Desc = {
    Text = "Hoàn thành \"Tu Lục Lambs\"ở bất kỳ độ khó nào"
  },
  Task_56421_Desc = {
    Text = "Hoàn thành \"Khe Hở Thời Không\"ở bất kỳ độ khó nào"
  },
  Task_56422_Desc = {
    Text = "Hoàn thành \"sao vàng\"ở bất kỳ độ khó nào"
  },
  Task_57121_Desc = {
    Text = "Hoàn thành \"Cừu Túng Thủ\"ở độ khó điên cuồng"
  },
  Task_57122_Desc = {
    Text = "Hoàn thành \"Hành Hình Giả\"độ khó điên cuồng"
  },
  Task_57123_Desc = {
    Text = "Sử dụng thân thể được đánh thức của vùng giới sâu thẳm trong \"tử cung đen\"để chiến thắng 2 lần"
  },
  Task_57124_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong siêu không gian giới vực để chiến thắng 2 lần trong \"tử cung đen\""
  },
  Task_57125_Desc = {
    Text = "Hoàn thành \"Đến Của Ngài\"độ khó điên cuồng"
  },
  Task_57126_Desc = {
    Text = "Sử dụng thân thể được đánh thức của giới vực biển sâu trong \"tử cung đen\"để thắng 1 lần"
  },
  Task_57127_Desc = {
    Text = "Hoàn thành \"Khe Hở Thời Không\"độ khó điên cuồng"
  },
  Task_57128_Desc = {
    Text = "Hoàn thành \"sao vàng\"độ khó điên cuồng"
  },
  Task_57129_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong giới vực hỗn loạn để chiến thắng 1 lần trong \"Tử Cung Đen\""
  },
  Task_57130_Desc = {
    Text = "Hoàn thành \"trùng phục\"độ khó điên cuồng"
  },
  Task_57131_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong giới vực hỗn loạn để chiến thắng 2 lần trong \"tử cung đen\""
  },
  Task_57132_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong giới vực thịt máu để chiến thắng 1 lần trong \"tử cung đen\""
  },
  Task_57133_Desc = {
    Text = "Hoàn thành tất cả nhiệm vụ trong \"Tử Cung Tối: Hoàn Thành\" và \"Tử Cung Tối: Giới Vực\""
  },
  Task_57134_Desc = {
    Text = "Sử dụng thân thể được đánh thức của giới vực thịt máu để chiến thắng 2 lần trong \"tử cung đen tối\""
  },
  Task_57135_Desc = {
    Text = "Hoàn thành \"quấn xác\"độ khó điên cuồng"
  },
  Task_57136_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong siêu không gian giới vực tại \"tử cung đen\"để chiến thắng 1 lần"
  },
  Task_57137_Desc = {
    Text = "Tử cung tối tăm · điên cuồng"
  },
  Task_57369_Desc = {
    Text = "Hoàn thành \"ngậm cành cây\"ở bất kỳ mức độ khó nào"
  },
  Task_57370_Desc = {
    Text = "Truyện đêm trăng·điên cuồng"
  },
  Task_57371_Desc = {
    Text = "Hoàn thành \"Mê cung phòng kín\"ở bất kỳ độ khó nào"
  },
  Task_57372_Desc = {
    Text = "Truyện đêm trăng·hoàn thành"
  },
  Task_57373_Desc = {
    Text = "Hoàn thành \"Cành cây ngậm\"ở độ khó điên cuồng"
  },
  Task_57374_Desc = {
    Text = "Hoàn thành \"Thây Ma Không Đầu\" bất kỳ độ khó nào"
  },
  Task_57375_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong giới vực hỗn loạn để chiến thắng 2 lần trong \"Truyện đêm trăng\""
  },
  Task_57376_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong giới vực thịt máu để chiến thắng 2 lần trong \"Truyện đêm trăng\""
  },
  Task_57377_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong giới vực huyết nhục để chiến thắng 1 lần trong \"Truyện đêm trăng\""
  },
  Task_57378_Desc = {
    Text = "Hoàn thành \"Không mời mà đến\"ở độ khó điên cuồng"
  },
  Task_57379_Desc = {
    Text = "Hoàn thành \"Vô Đầu Thi\"ở độ khó điên cuồng"
  },
  Task_57380_Desc = {
    Text = "Hoàn thành mọi nhiệm vụ của \"Truyện đêm trăng·hoàn thành\""
  },
  Task_57381_Desc = {
    Text = "Hoàn thành \"Mê Cung Bí Mật\"độ khó điên cuồng"
  },
  Task_57382_Desc = {
    Text = "Dùng thân thể được đánh thức từ giới vực siêu việt để giành chiến thắng 1 lần trong \"Truyện đêm trăng\""
  },
  Task_57383_Desc = {
    Text = "Sử dụng thân thể được đánh thức siêu không gian giới vực trong \"Truyện đêm trăng\"để chiến thắng 2 lần"
  },
  Task_57384_Desc = {
    Text = "Sử dụng thể xác được đánh thức từ vùng biển sâu thẳm để giành chiến thắng một lần trong \"Truyện đêm trăng\""
  },
  Task_57385_Desc = {
    Text = "Sử dụng thể xác được đánh thức từ vùng giới vực sâu thẳm để giành chiến thắng 2 lần trong \"Truyện đêm trăng\""
  },
  Task_57386_Desc = {
    Text = "Hoàn thành \"dân chúng may mắn\"ở bất kỳ độ khó nào"
  },
  Task_57387_Desc = {
    Text = "Hoàn thành \"Lời khai vắng mặt\"độ khó điên cuồng"
  },
  Task_57388_Desc = {
    Text = "Hoàn thành \"Bạn của Thám Tử\"ở bất kỳ độ khó nào"
  },
  Task_57389_Desc = {
    Text = "Hoàn thành \"Khách không mời\"ở bất kỳ độ khó nào"
  },
  Task_57390_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong \"Truyện đêm trăng\"để chiến thắng 1 lần"
  },
  Task_57391_Desc = {
    Text = "Truyện đêm trăng·giới vực"
  },
  Task_57392_Desc = {
    Text = "Hoàn thành \"Bạn Của Thám Tử\"độ khó điên cuồng"
  },
  Task_57393_Desc = {
    Text = "Hoàn thành \"bản khai vắng mặt\"ở mọi độ khó"
  },
  Task_57394_Desc = {
    Text = "Hoàn thành \"dân chúng may mắn\"độ khó điên cuồng"
  },
  Task_57404_Desc = {
    Text = "Hoàn thành \"hậu ký\" bất kỳ độ khó nào"
  },
  Task_57405_Desc = {
    Text = "Hoàn thành \"Lật Đảo Xảo Quyệt\"ở bất kỳ độ khó nào"
  },
  Task_57406_Desc = {
    Text = "Hoàn thành \"hậu ký\"độ khó điên cuồng"
  },
  Task_57407_Desc = {
    Text = "Hoàn thành \"Mưu Kế Phản Chuyển\"độ khó điên cuồng"
  },
  Task_57409_Desc = {
    Text = "Hoàn thành báo cáo đặc vụ \"Săn bắn vui vẻ!\""
  },
  Task_57570_Desc = {
    Text = "Hoàn thành \"Lật Đảo Xảo Quyệt\"ở bất kỳ độ khó nào"
  },
  Task_57571_Desc = {
    Text = "Hoàn thành \"Bạn của Thám Tử\"ở bất kỳ độ khó nào"
  },
  Task_57572_Desc = {
    Text = "Hoàn thành \"Thây Ma Không Đầu\" bất kỳ độ khó nào"
  },
  Task_57573_Desc = {
    Text = "Hoàn thành \"Tu Lục Lambs\"ở bất kỳ độ khó nào"
  },
  Task_57574_Desc = {
    Text = "Hoàn thành \"bản khai vắng mặt\"ở mọi độ khó"
  },
  Task_57575_Desc = {
    Text = "Hoàn thành \"sao vàng\"ở bất kỳ độ khó nào"
  },
  Task_57576_Desc = {
    Text = "Hoàn thành \"Sự đến của Ngài\"ở bất kỳ độ khó nào"
  },
  Task_57577_Desc = {
    Text = "Hoàn thành \"Hành Hình Giả\" bất kỳ độ khó"
  },
  Task_57578_Desc = {
    Text = "Hoàn thành \"hậu ký\" bất kỳ độ khó nào"
  },
  Task_57579_Desc = {
    Text = "Hoàn thành \"Quấn Xác\"ở bất kỳ độ khó nào"
  },
  Task_57580_Desc = {
    Text = "Hoàn thành \"Khách không mời\"ở bất kỳ độ khó nào"
  },
  Task_57581_Desc = {
    Text = "Hoàn thành \"ẩn náu\"ở bất kỳ độ khó nào"
  },
  Task_57582_Desc = {
    Text = "Hoàn thành \"Khe Hở Thời Không\"ở bất kỳ độ khó nào"
  },
  Task_57583_Desc = {
    Text = "Hoàn thành \"ngậm cành cây\"ở bất kỳ mức độ khó nào"
  },
  Task_57584_Desc = {
    Text = "Hoàn thành \"dân chúng may mắn\"ở bất kỳ độ khó nào"
  },
  Task_57585_Desc = {
    Text = "Hoàn thành \"Mê cung phòng kín\"ở bất kỳ độ khó nào"
  },
  Task_58104_Desc = {
    Text = "Hoàn thành \"Sám hối\" tất cả các độ khó"
  },
  Task_58107_Desc = {
    Text = "Hoàn thành \"tố cáo\" bất kỳ độ khó nào"
  },
  Task_58109_Desc = {
    Text = "Hoàn thành độ khó 「Điên cuồng」cấp độ \"Paranoid\""
  },
  Task_58110_Desc = {
    Text = "Hoàn thành \"tranh đoạt\" bất kỳ độ khó nào"
  },
  Task_58111_Desc = {
    Text = "Hoàn thành \"tranh đoạt\" bất kỳ độ khó nào"
  },
  Task_58112_Desc = {
    Text = "Hoàn thành \"Sám hối\" tất cả các độ khó"
  },
  Task_58113_Desc = {
    Text = "Hoàn thành \"Hoang Tưởng\"ở bất kỳ độ khó nào"
  },
  Task_58114_Desc = {
    Text = "Hoàn thành \"Sám hối\"độ khó điên cuồng"
  },
  Task_58115_Desc = {
    Text = "Hoàn thành \"Yêu Cầu\" bất kỳ độ khó nào"
  },
  Task_58118_Desc = {
    Text = "Hoàn thành \"Chỉ Trích\"độ khó điên cuồng"
  },
  Task_58119_Desc = {
    Text = "Hoàn thành \"Sách lược\"ở độ khó điên cuồng"
  },
  Task_58120_Desc = {
    Text = "Hoàn thành tất cả các cấp độ của \"Đường Thánh\"ở bất kỳ độ khó nào"
  },
  Task_58122_Desc = {
    Text = "Hoàn thành \"tố cáo\" bất kỳ độ khó nào"
  },
  Task_58123_Desc = {
    Text = "Sân từ thiện tại đền thánh"
  },
  Task_58124_Desc = {
    Text = "Hoàn thành \"Hoang Tưởng\"ở bất kỳ độ khó nào"
  },
  Task_58126_Desc = {
    Text = "Hoàn thành \"Yêu Cầu\" bất kỳ độ khó nào"
  },
  Task_58128_Desc = {
    Text = "Con đường của đền thánh·điên cuồng"
  },
  Task_58130_Desc = {
    Text = "Đường đền thánh · Sự phát triển"
  },
  Task_58131_Desc = {
    Text = "Hoàn thành \"tranh giành\"độ khó điên cuồng"
  },
  Task_58132_Desc = {
    Text = "\"Bán hàng từ thiện kỳ diệu của John lớn\" trong mua 100 lần"
  },
  Task_58133_Desc = {
    Text = "\"Đại John kỳ diệu\" trong mua 200 lần"
  },
  Task_58134_Desc = {
    Text = "Mua 100 lần tại \"Cửa hàng nhỏ của Bà Gray\""
  },
  Task_58135_Desc = {
    Text = "\"Cửa hàng nhỏ của Bà Grey\" mua 200 lần"
  },
  Task_58136_Desc = {
    Text = "\"Smith đặc biệt bán\" mua 200 lần"
  },
  Task_58137_Desc = {
    Text = "\"Smith đặc biệt bán\" mua tổng cộng 100 lần"
  },
  Task_58138_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"{s1}\""
  },
  Task_58500_Desc = {
    Text = "Âm thanh rền vang·hoàn thành"
  },
  Task_58501_Desc = {
    Text = "Hoàn thành \"Sắp xếp dàn nhạc\"độ khó điên cuồng"
  },
  Task_58502_Desc = {
    Text = "Hoàn thành \"Phần mở đầu\"ở bất kỳ độ khó nào"
  },
  Task_58503_Desc = {
    Text = "Hoàn thành \"Tiểu Bộ Vũ Khúc\"ở bất kỳ độ khó nào"
  },
  Task_58504_Desc = {
    Text = "Hoàn thành \"Dư Âm\"ở bất kỳ độ khó nào"
  },
  Task_58505_Desc = {
    Text = "Hoàn thành \"Khúc cuối\"ở bất kỳ độ khó nào"
  },
  Task_58506_Desc = {
    Text = "Hoàn thành \"chậm rãi\" bất kỳ độ khó nào"
  },
  Task_58507_Desc = {
    Text = "Hoàn thành \"khua nhanh\"độ khó điên cuồng"
  },
  Task_58508_Desc = {
    Text = "Hoàn thành \"Minuet\"độ khó điên cuồng"
  },
  Task_58509_Desc = {
    Text = "Hoàn thành \"Dư Âm\"ở bất kỳ độ khó nào"
  },
  Task_58510_Desc = {
    Text = "Sử dụng thân thể được đánh thức của giới vực hỗn loạn để chiến thắng 1 lần trong \"Âm Thanh Gầm Rú\""
  },
  Task_58511_Desc = {
    Text = "Sử dụng thân thể được đánh thức từ giới vực hỗn loạn để giành chiến thắng 2 lần trong \"âm thanh rền vang\""
  },
  Task_58512_Desc = {
    Text = "Hoàn thành \"Mê Đường Mộng Dẫn\" bất kỳ độ khó nào"
  },
  Task_58513_Desc = {
    Text = "Tiếng gầm vang · giới vực"
  },
  Task_58514_Desc = {
    Text = "Hoàn thành \"Dư Âm\"độ khó điên cuồng"
  },
  Task_58515_Desc = {
    Text = "Hoàn thành \"Tiểu Bộ Vũ Khúc\"ở bất kỳ độ khó nào"
  },
  Task_58516_Desc = {
    Text = "Âm thanh ùng oàng · điên cuồng"
  },
  Task_58517_Desc = {
    Text = "Hoàn thành \"Khoái bản\"ở bất kỳ độ khó nào"
  },
  Task_58518_Desc = {
    Text = "Hoàn thành \"Tự khúc\"độ khó điên cuồng"
  },
  Task_58519_Desc = {
    Text = "Hoàn thành \"Quản Hành Biên Chế\"ở bất kỳ mức độ khó nào"
  },
  Task_58520_Desc = {
    Text = "Hoàn thành \"Adagio\"độ khó điên cuồng"
  },
  Task_58521_Desc = {
    Text = "Hoàn thành \"chậm rãi\" bất kỳ độ khó nào"
  },
  Task_58522_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong vùng giới sâu thẳm \"âm thanh rền vang\" và giành chiến thắng 2 lần"
  },
  Task_58523_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong vùng giới vực sâu thẳm để chiến thắng 1 lần trong \"Tiếng Gầm Vang\""
  },
  Task_58524_Desc = {
    Text = "Hoàn thành \"màn hạ\" bất kỳ độ khó nào"
  },
  Task_58525_Desc = {
    Text = "Hoàn thành \"Chung Khúc\"độ khó điên cuồng"
  },
  Task_58526_Desc = {
    Text = "Hoàn thành \"Mê Đuổi Mộng Dẫn\"ở mức độ điên cuồng"
  },
  Task_58527_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong siêu không gian giới vực tại \"Tiếng Gầm\"để giành chiến thắng 2 lần"
  },
  Task_58528_Desc = {
    Text = "Sử dụng thân thể được đánh thức siêu việt để giành chiến thắng tại \"Âm Vang Sấm Rền\""
  },
  Task_58529_Desc = {
    Text = "Hoàn thành \"Khoái bản\"ở bất kỳ độ khó nào"
  },
  Task_58530_Desc = {
    Text = "Hoàn thành tất cả nhiệm vụ của \"Âm Rền Vang·hoàn thành\""
  },
  Task_58531_Desc = {
    Text = "Hoàn thành \"Phần mở đầu\"ở bất kỳ độ khó nào"
  },
  Task_58532_Desc = {
    Text = "Hoàn thành \"màn hạ\" bất kỳ độ khó nào"
  },
  Task_58533_Desc = {
    Text = "Hoàn thành \"Quản Hành Biên Chế\"ở bất kỳ mức độ khó nào"
  },
  Task_58534_Desc = {
    Text = "Hoàn thành \"Mê Đường Mộng Dẫn\" bất kỳ độ khó nào"
  },
  Task_58535_Desc = {
    Text = "Hoàn thành \"Khúc cuối\"ở bất kỳ độ khó nào"
  },
  Task_58536_Desc = {
    Text = "Hoàn thành \"màn hạ\"ở độ khó điên cuồng"
  },
  Task_58537_Desc = {
    Text = "Sử dụng thân thể được đánh thức của giới vực thịt máu để chiến thắng 1 lần trong \"Âm Thanh Gầm Rú\""
  },
  Task_58538_Desc = {
    Text = "Sử dụng thân thể được đánh thức giới vực thịt máu để chiến thắng 2 lần trong \"Âm thanh gầm rú\""
  },
  Task_58989_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_58989_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_58990_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_58990_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_58991_Desc = {
    Text = "Cuộc chiến cuối cùng, trong một lượt, rút thêm ít nhất 5 lá bài"
  },
  Task_58991_Name = {
    Text = "Vẽ thẻ!"
  },
  Task_58992_Desc = {
    Text = "Khi hoàn thành, số lượng thẻ triệu chứng không vượt quá 2"
  },
  Task_58992_Name = {
    Text = "Tiết kiệm năng lượng"
  },
  Task_58993_Desc = {
    Text = "Nhận được ít nhất 4 loại khắc ấn khác nhau"
  },
  Task_58993_Name = {
    Text = "Ấn ký linh hồn"
  },
  Task_58994_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_58994_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_58995_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_58995_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_58996_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_58996_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_58997_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_58997_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_58998_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_58998_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_58999_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_58999_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_59000_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_59000_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_59001_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_59001_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_59002_Desc = {
    Text = "Khi hoàn thành, số lượng thẻ triệu chứng không vượt quá 3"
  },
  Task_59002_Name = {
    Text = "Tiết kiệm năng lượng"
  },
  Task_59003_Desc = {
    Text = "Khi hoàn thành, số lượng thẻ triệu chứng không vượt quá 2"
  },
  Task_59003_Name = {
    Text = "Tiết kiệm năng lượng"
  },
  Task_59004_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_59004_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_59005_Desc = {
    Text = "Hoàn thành khi mang theo ít nhất 8 món đồ"
  },
  Task_59005_Name = {
    Text = "Kho báu kỳ binh"
  },
  Task_59006_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_59006_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_59007_Desc = {
    Text = "Hoàn thành khi mang theo ít nhất một vật bị nguyền rủa"
  },
  Task_59007_Name = {
    Text = "Kho báu kỳ binh"
  },
  Task_59008_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_59008_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_59009_Desc = {
    Text = "Cuộc chiến cuối cùng, trong một lượt, đánh ít nhất 6 thẻ bài"
  },
  Task_59009_Name = {
    Text = "Lượt của tôi"
  },
  Task_59010_Desc = {
    Text = "Cuộc chiến cuối cùng, ít nhất cộng dồn lá chắn bằng 65% máu tối đa trong một lượt"
  },
  Task_59010_Name = {
    Text = "Thân hình bằng thép"
  },
  Task_59011_Desc = {
    Text = "Cuộc chiến cuối cùng, trong một lượt, đánh ít nhất 6 thẻ bài"
  },
  Task_59011_Name = {
    Text = "Lượt của tôi"
  },
  Task_59012_Desc = {
    Text = "Cuộc chiến cuối cùng, ít nhất cộng dồn lá chắn bằng 65% máu tối đa trong một lượt"
  },
  Task_59012_Name = {
    Text = "Thân hình bằng thép"
  },
  Task_59013_Desc = {
    Text = "Cuộc chiến cuối cùng, trong một lượt, rút thêm ít nhất 5 lá bài"
  },
  Task_59013_Name = {
    Text = "Vẽ thẻ!"
  },
  Task_59014_Desc = {
    Text = "Cuộc chiến cuối cùng, trong một lượt gây ra ít nhất 20000 điểm sát thương"
  },
  Task_59014_Name = {
    Text = "Đòn toàn lực"
  },
  Task_59015_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_59015_Name = {
    Text = "Thanh lịch và chính xác"
  },
  Task_59016_Desc = {
    Text = "Nhận được ít nhất 4 loại khắc ấn khác nhau"
  },
  Task_59016_Name = {
    Text = "Ấn ký linh hồn"
  },
  Task_59017_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_59017_Name = {
    Text = "Thanh lịch và chính xác"
  },
  Task_59018_Desc = {
    Text = "Hoàn thành khi mang theo ít nhất một vật bị nguyền rủa"
  },
  Task_59018_Name = {
    Text = "Kho báu kỳ binh"
  },
  Task_59019_Desc = {
    Text = "Hoàn thành khi thức tỉnh tất cả các thân thể"
  },
  Task_59019_Name = {
    Text = "Vô tận ôm ấp"
  },
  Task_59020_Desc = {
    Text = "Hoàn thành khi mang theo ít nhất 2 vật phẩm"
  },
  Task_59020_Name = {
    Text = "Kho báu kỳ binh"
  },
  Task_59021_Desc = {
    Text = "Hoàn thành khi mang theo ít nhất một vật bị nguyền rủa"
  },
  Task_59021_Name = {
    Text = "Kho báu kỳ binh"
  },
  Task_59022_Desc = {
    Text = "Khi hoàn thành, số lượng thẻ triệu chứng không vượt quá 2"
  },
  Task_59022_Name = {
    Text = "Tiết kiệm năng lượng"
  },
  Task_59023_Desc = {
    Text = "Trong cuộc chiến cuối cùng, mỗi lượt chơi rút thêm ít nhất 4 lá bài"
  },
  Task_59023_Name = {
    Text = "Vẽ thẻ!"
  },
  Task_59024_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_59024_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_59025_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_59025_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_59026_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_59026_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_59027_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_59027_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_59028_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_59028_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_59029_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_59029_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_59030_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_59030_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_59031_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_59031_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_59032_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_59032_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_59033_Desc = {
    Text = "Hoàn thành khi thức tỉnh tất cả các thân thể"
  },
  Task_59033_Name = {
    Text = "Vô tận ôm ấp"
  },
  Task_59034_Desc = {
    Text = "Hoàn thành khi mang theo ít nhất 2 vật phẩm"
  },
  Task_59034_Name = {
    Text = "Kho báu kỳ binh"
  },
  Task_59035_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_59035_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_59036_Desc = {
    Text = "Hoàn thành khi mang theo ít nhất một vật bị nguyền rủa"
  },
  Task_59036_Name = {
    Text = "Kho báu kỳ binh"
  },
  Task_59037_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 18 lượt để giành chiến thắng"
  },
  Task_59037_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_59038_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 12 hiệp để giành chiến thắng"
  },
  Task_59038_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_59039_Desc = {
    Text = "Trong một lượt ít nhất cộng dồn lá chắn bằng 60% máu tối đa"
  },
  Task_59039_Name = {
    Text = "Thân hình bằng thép"
  },
  Task_59040_Desc = {
    Text = "Cuộc chiến cuối cùng, đánh ra ít nhất 5 thẻ trong 1 lượt"
  },
  Task_59040_Name = {
    Text = "Lượt của tôi"
  },
  Task_59041_Desc = {
    Text = "Trong một lượt ít nhất cộng dồn lá chắn bằng 60% máu tối đa"
  },
  Task_59041_Name = {
    Text = "Thân hình bằng thép"
  },
  Task_59042_Desc = {
    Text = "Khi hoàn thành, số lượng thẻ triệu chứng không vượt quá 3"
  },
  Task_59042_Name = {
    Text = "Tiết kiệm năng lượng"
  },
  Task_59043_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_59043_Name = {
    Text = "Thanh lịch và chính xác"
  },
  Task_59044_Desc = {
    Text = "Cuộc chiến cuối cùng không vượt quá 18 lượt để giành chiến thắng"
  },
  Task_59044_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_59045_Desc = {
    Text = "Trong cuộc chiến cuối cùng, mỗi lượt chơi rút thêm ít nhất 4 lá bài"
  },
  Task_59045_Name = {
    Text = "Vẽ thẻ!"
  },
  Task_59046_Desc = {
    Text = "Hoàn thành khi mang theo ít nhất 8 món đồ"
  },
  Task_59046_Name = {
    Text = "Kho báu kỳ binh"
  },
  Task_59047_Desc = {
    Text = "Cuộc chiến cuối cùng, đánh ra ít nhất 5 thẻ trong 1 lượt"
  },
  Task_59047_Name = {
    Text = "Lượt của tôi"
  },
  Task_59048_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_59048_Name = {
    Text = "Thanh lịch và chính xác"
  },
  Task_59438_Desc = {
    Text = "Tỷ lệ đồng điều của Lắc đạt cấp 10"
  },
  Task_60163_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_60163_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_60163_UnlockCondDesc = {
    Text = "Mở khóa sau khi hoàn thành cấp độ 8-9"
  },
  Task_60164_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_60164_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_60164_UnlockCondDesc = {
    Text = "Qua màn 8-11 để mở khóa"
  },
  Task_60165_Desc = {
    Text = "Hoàn thành màn chơi"
  },
  Task_60165_Name = {
    Text = "Hoàn thành màn chơi"
  },
  Task_60165_UnlockCondDesc = {
    Text = "Sau khi hoàn thành cấp độ 8-10 để mở khóa"
  },
  Task_60443_Desc = {
    Text = "Hoàn thành điều tra chương 4 của câu chuyện chính \"Trong im lặng\""
  },
  Task_60444_Desc = {
    Text = "Đạt giá trị huấn luyện 150 lần đầu tiên"
  },
  Task_60445_Desc = {
    Text = "Giá trị đặc huấn đạt mốc lần đầu tiên 325"
  },
  Task_60446_Desc = {
    Text = "Đạt giá trị đặc huấn 50 lần đầu tiên"
  },
  Task_60447_Desc = {
    Text = "Giá trị huấn luyện đạt 100 lần đầu"
  },
  Task_60448_Desc = {
    Text = "Hoàn thành chương 4 của cốt truyện chính \"Trong im lặng\"ở độ khó khó khăn"
  },
  Task_60449_Desc = {
    Text = "Giá trị huấn luyện đạt 300 lần đầu"
  },
  Task_60450_Desc = {
    Text = "Hoàn thành chương 2 của câu chuyện chính \"Nhân danh bình tượng nến\""
  },
  Task_60451_Desc = {
    Text = "Hoàn thành nhiệm vụ điều tra chương 5 của cốt truyện chính \"Mắt Bão\"ở độ khó khó khăn"
  },
  Task_60452_Desc = {
    Text = "Giá trị đặc huấn đạt lần đầu tiên 225"
  },
  Task_60453_Desc = {
    Text = "Hoàn thành chương 1 của câu chuyện chính \"Bí mật khu Đông\""
  },
  Task_60454_Desc = {
    Text = "Hoàn thành chương 6 của cốt truyện chính \"sao sao đảo ngược\"ở độ khó khó khăn"
  },
  Task_60455_Desc = {
    Text = "Hoàn thành điều tra chương 2 của câu chuyện chính \"Tên gọi của bình tượng nến\"ở độ khó khó khăn"
  },
  Task_60456_Desc = {
    Text = "Hoàn thành điều tra chương 5 của câu chuyện chính \"Mắt Bão\""
  },
  Task_60457_Desc = {
    Text = "Hoàn thành điều tra chương 3 của cốt truyện chính \"Cẩn thận chó dữ\"ở độ khó cao"
  },
  Task_60458_Desc = {
    Text = "Hoàn thành điều tra chương 1 \"Bí mật khu Đông\" khó"
  },
  Task_60459_Desc = {
    Text = "Hoàn thành chương 3 của cốt truyện chính \"Cẩn thận chó dữ\""
  },
  Task_60460_Desc = {
    Text = "Hoàn thành chương 6 của cốt truyện điều tra chính \"sao sao đảo ngược\""
  },
  Task_60461_Desc = {
    Text = "Điểm huấn luyện đạt lần đầu 350"
  },
  Task_60601_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60602_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60603_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60604_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60606_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60607_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60608_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60609_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60610_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60611_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60612_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60613_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60614_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60615_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60616_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60617_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60618_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60619_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60620_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60622_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60623_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60624_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60625_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60626_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60627_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60628_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60629_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60630_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60631_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60633_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60634_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60635_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60636_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60637_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60638_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60639_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60640_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60641_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60642_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60643_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60644_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60645_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60646_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60647_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60648_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60649_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60650_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60651_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60653_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60654_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60655_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60656_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60657_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60658_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60659_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60660_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60661_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60663_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60664_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60665_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60666_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60667_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60668_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60669_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60670_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60671_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60672_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60673_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60674_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60675_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60676_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60677_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60678_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60680_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60681_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60682_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60683_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60684_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60685_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60686_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60687_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60688_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60689_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60690_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60691_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60692_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60694_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60696_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60697_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60699_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60742_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60743_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60747_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60748_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60749_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60750_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60751_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60752_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60754_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60755_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60757_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60758_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60759_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60760_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60761_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60763_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60765_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60766_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60768_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60769_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60770_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60772_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60773_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60774_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60777_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60778_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60779_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60780_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60781_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60782_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60783_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60784_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60785_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60787_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60788_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60789_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60790_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60793_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60795_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60796_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60797_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60798_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60799_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60800_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60801_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60803_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60804_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60805_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_60829_Desc = {
    Text = "Hamlin tỷ lệ đồng điều lên cấp 10"
  },
  Task_61103_Desc = {
    Text = "Nhận được nguồn gốc Đóa"
  },
  Task_61103_Name = {
    Text = "Nhận được nguồn gốc Đóa"
  },
  Task_61104_Desc = {
    Text = "Có được nguồn gốc Hiro"
  },
  Task_61104_Name = {
    Text = "Có được nguồn gốc Hiro"
  },
  Task_61105_Desc = {
    Text = "Nhận được Lily"
  },
  Task_61105_Name = {
    Text = "Nhận được Lily"
  },
  Task_61106_Desc = {
    Text = "Thu được Ôrla"
  },
  Task_61106_Name = {
    Text = "Thu được Ôrla"
  },
  Task_61107_Desc = {
    Text = "Nhận được Miriam"
  },
  Task_61107_Name = {
    Text = "Nhận được Miriam"
  },
  Task_61108_Desc = {
    Text = "Nhận được Lắc"
  },
  Task_61108_Name = {
    Text = "Nhận được Lắc"
  },
  Task_61109_Desc = {
    Text = "Thu thập Sorrel"
  },
  Task_61109_Name = {
    Text = "Thu thập Sorrel"
  },
  Task_61110_Desc = {
    Text = "Nhận được Salvador"
  },
  Task_61110_Name = {
    Text = "Nhận được Salvador"
  },
  Task_61111_Desc = {
    Text = "Thu được Vanda"
  },
  Task_61111_Name = {
    Text = "Thu được Vanda"
  },
  Task_61112_Desc = {
    Text = "Nhận tulô"
  },
  Task_61112_Name = {
    Text = "Nhận tulô"
  },
  Task_61113_Desc = {
    Text = "Nhận được \"24\""
  },
  Task_61113_Name = {
    Text = "Nhận được \"24\""
  },
  Task_61114_Desc = {
    Text = "Nhận được Tà Vy"
  },
  Task_61114_Name = {
    Text = "Nhận được Tà Vy"
  },
  Task_61115_Desc = {
    Text = "Thu được Thái Di Sơ"
  },
  Task_61115_Name = {
    Text = "Thu được Thái Di Sơ"
  },
  Task_61116_Desc = {
    Text = "Nhận được Hamlin"
  },
  Task_61116_Name = {
    Text = "Nhận được Hamlin"
  },
  Task_61117_Desc = {
    Text = "Nhận được Đào Đen Đá"
  },
  Task_61117_Name = {
    Text = "Nhận được Đào Đen Đá"
  },
  Task_61118_Desc = {
    Text = "Nhận Muphí"
  },
  Task_61118_Name = {
    Text = "Nhận Muphí"
  },
  Task_61157_Desc = {
    Text = "Hoàn thành điều tra chương 8 của cốt truyện chính \"Bản giao hưởng cuối cùng\"ở mức khó"
  },
  Task_61158_Desc = {
    Text = "Hoàn thành điều tra chương 7 của cốt truyện chính \"Dục Hà\""
  },
  Task_61159_Desc = {
    Text = "Hoàn thành điều tra chương 7 \"Dục Hà\"độ khó khó khăn"
  },
  Task_61160_Desc = {
    Text = "Hoàn thành điều tra chương 8 của cốt truyện chính \"Bản giao hưởng cuối cùng\"ở mức khó"
  },
  Task_61161_Desc = {
    Text = "Hoàn thành chương 8 của cốt truyện chính \"Bản giao hưởng cuối cùng\""
  },
  Task_61162_Desc = {
    Text = "Hoàn thành điều tra chương 7 \"Dục Hà\"độ khó khó khăn"
  },
  Task_61163_Desc = {
    Text = "Hoàn thành điều tra chương 7 của cốt truyện chính \"Dục Hà\""
  },
  Task_61164_Desc = {
    Text = "Hoàn thành chương 8 của cốt truyện chính \"Bản giao hưởng cuối cùng\""
  },
  Task_61186_Desc = {
    Text = "Hoàn thành \"một đoạn ký ức\"ở mọi độ khó"
  },
  Task_61187_Desc = {
    Text = "Hoàn thành \"Thành Phố Vàng\" bất kỳ độ khó nào"
  },
  Task_61188_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong giới vực hỗn loạn để chiến thắng 1 lần tại \"thành phố trên hồ\""
  },
  Task_61189_Desc = {
    Text = "Hoàn thành tất cả nhiệm vụ trong \"Thành phố trong hồ·hoàn thành\""
  },
  Task_61190_Desc = {
    Text = "Hoàn thành \"Khải Huyền\"ở bất kỳ độ khó nào"
  },
  Task_61191_Desc = {
    Text = "Hoàn thành \"thật（thật）\"độ khó điên cuồng"
  },
  Task_61192_Desc = {
    Text = "Hoàn thành \"Thành phố Vàng\"độ khó điên cuồng"
  },
  Task_61193_Desc = {
    Text = "Hoàn thành \"Hải Thị Thân Lâu\" mọi độ khó"
  },
  Task_61194_Desc = {
    Text = "Thành phố trên hồ · hoàn thành"
  },
  Task_61195_Desc = {
    Text = "Hoàn thành \"thật\"ở bất kỳ độ khó nào"
  },
  Task_61196_Desc = {
    Text = "Hoàn thành \"Tiểu Thương Lan\" bất kỳ độ khó nào"
  },
  Task_61197_Desc = {
    Text = "Hoàn thành \"Hải Thị Thân Lâu\" mọi độ khó"
  },
  Task_61198_Desc = {
    Text = "Sử dụng thân thể được đánh thức siêu không gian giới vực để chiến thắng 1 lần trong \"Thành Phố Trên Hồ\""
  },
  Task_61199_Desc = {
    Text = "Sử dụng thân thể được đánh thức vùng giới biển sâu trong \"Thành Phố Trên Hồ\"để chiến thắng 1 lần"
  },
  Task_61200_Desc = {
    Text = "Hoàn thành \"Hải Thị Thần Lâu\"độ khó điên cuồng"
  },
  Task_61201_Desc = {
    Text = "Thành phố trong hồ Giới vực"
  },
  Task_61202_Desc = {
    Text = "Hoàn thành \"Thành Phố Vàng\" bất kỳ độ khó nào"
  },
  Task_61203_Desc = {
    Text = "Hoàn thành \"Khải Huyền\"ở bất kỳ độ khó nào"
  },
  Task_61204_Desc = {
    Text = "Hoàn thành \"giếng\" bất kỳ độ khó nào"
  },
  Task_61205_Desc = {
    Text = "Hoàn thành \"một đoạn ký ức\"ở mọi độ khó"
  },
  Task_61206_Desc = {
    Text = "Sử dụng thân thể được đánh thức của giới vực thịt máu để chiến thắng 1 lần trong \"Thành Phố Trên Hồ\""
  },
  Task_61207_Desc = {
    Text = "Hoàn thành \"Tiểu Thương Lan\"độ khó điên cuồng"
  },
  Task_61208_Desc = {
    Text = "Hoàn thành \"Khải Huyền\"độ khó điên cuồng"
  },
  Task_61209_Desc = {
    Text = "Hoàn thành \"giếng\" bất kỳ độ khó nào"
  },
  Task_61210_Desc = {
    Text = "Hoàn thành \"Tiểu Thương Lan\" bất kỳ độ khó nào"
  },
  Task_61211_Desc = {
    Text = "Thành phố trên hồ · điên cuồng"
  },
  Task_61212_Desc = {
    Text = "Hoàn thành \"thật\"ở bất kỳ độ khó nào"
  },
  Task_61213_Desc = {
    Text = "Hoàn thành \"một đoạn ký ức\"ở độ khó điên cuồng"
  },
  Task_61214_Desc = {
    Text = "Hoàn thành \"giếng\"độ khó cực cao"
  },
  Task_61215_Desc = {
    Text = "Hoàn thành duy thức tiềm hành \"Bữa tiệc rực lửa\""
  },
  Task_61375_Desc = {
    Text = "Đăng nhập liên tiếp 12 ngày"
  },
  Task_61376_Desc = {
    Text = "Đăng nhập liên tiếp 3 ngày"
  },
  Task_61377_Desc = {
    Text = "Đăng nhập liên tiếp trong 9 ngày"
  },
  Task_61378_Desc = {
    Text = "Đăng nhập liên tiếp 11 ngày"
  },
  Task_61379_Desc = {
    Text = "Đăng nhập liên tiếp trong 10 ngày"
  },
  Task_61380_Desc = {
    Text = "Đăng nhập liên tiếp 1 ngày"
  },
  Task_61381_Desc = {
    Text = "Đăng nhập liên tiếp 4 ngày"
  },
  Task_61382_Desc = {
    Text = "Tích lũy đăng nhập 15 ngày"
  },
  Task_61383_Desc = {
    Text = "Tích lũy đăng nhập 14 ngày"
  },
  Task_61384_Desc = {
    Text = "Đăng nhập liên tiếp 5 ngày"
  },
  Task_61385_Desc = {
    Text = "Đăng nhập liên tiếp 8 ngày"
  },
  Task_61386_Desc = {
    Text = "Đăng nhập liên tiếp 2 ngày"
  },
  Task_61387_Desc = {
    Text = "Đăng nhập tích lũy trong 13 ngày"
  },
  Task_61388_Desc = {
    Text = "Đăng nhập liên tiếp 6 ngày"
  },
  Task_61389_Desc = {
    Text = "Đăng nhập tích lũy 16 ngày liên tiếp"
  },
  Task_61390_Desc = {
    Text = "Đăng nhập liên tiếp 7 ngày"
  },
  Task_61394_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61395_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61396_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61397_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61398_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61399_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61400_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61401_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61402_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61403_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61404_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61405_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61407_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61408_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61409_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61410_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61411_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61412_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61413_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61414_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61415_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61416_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61417_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61418_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61419_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61420_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61421_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61422_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61425_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61426_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61427_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61428_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61430_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61431_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61432_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61433_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61434_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61435_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61436_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61438_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61439_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61440_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61441_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61442_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61443_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61444_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61445_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61446_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61447_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61448_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61449_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61450_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61451_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61452_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61453_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61455_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61456_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61457_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61458_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61459_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61460_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61461_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61462_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61463_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61464_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61465_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61466_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61468_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61469_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61470_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61471_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61472_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61473_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61474_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61475_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61476_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61477_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61478_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61479_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61481_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61519_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61520_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61521_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61522_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61523_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61524_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61525_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61526_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61527_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61528_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61616_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61617_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61620_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61621_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61622_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61623_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61626_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61627_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61628_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61629_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61631_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61633_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61634_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61636_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61637_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61639_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61640_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61642_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61643_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61644_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61645_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61648_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61649_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61650_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61652_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61653_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61654_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61655_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61657_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61659_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61660_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61661_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61662_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61665_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61666_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61668_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61669_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61671_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61672_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61673_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61675_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61676_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61678_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61679_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61681_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61682_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61684_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61685_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61687_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61688_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61690_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61691_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61693_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61694_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61696_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61697_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61699_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61700_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61701_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61702_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61704_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61705_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61706_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61707_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61709_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61710_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61712_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61713_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61716_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61717_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61719_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61720_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61722_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61723_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61725_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61726_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61727_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61729_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61731_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61733_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61734_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61735_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61736_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61739_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61740_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61743_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61744_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61748_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61749_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61750_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61751_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61753_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61754_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61756_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61757_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61758_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61759_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61762_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61763_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61765_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61766_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61767_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61769_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61770_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61771_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61772_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61774_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61777_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61778_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61781_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61782_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61783_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61784_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61785_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61788_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61789_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61791_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61792_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61794_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61795_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61796_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61797_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61798_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61801_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61802_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61804_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61805_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61807_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61808_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61810_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61811_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61814_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61815_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61816_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61817_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61819_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61820_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61821_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61824_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_61825_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_62002_Desc = {
    Text = "Hoàn thành \"Thấy Núi\"độ khó điên cuồng"
  },
  Task_62003_Desc = {
    Text = "Hoàn thành \"Phá Thổ\"ở bất kỳ độ khó nào"
  },
  Task_62004_Desc = {
    Text = "Dã tâm Thú · Giới vực"
  },
  Task_62005_Desc = {
    Text = "Hoàn thành \"Đêm Lạnh\"ở bất kỳ độ khó nào"
  },
  Task_62006_Desc = {
    Text = "Trong \"Tham Vọng Nuốt Chửng\"đổi chỗ để nhận hoa nụ và thu về 200 phần thưởng"
  },
  Task_62007_Desc = {
    Text = "Trong \"Tham vọng nuốt chửng\" hoán đổi hoa nụ nhận được 100 phần thưởng"
  },
  Task_62008_Desc = {
    Text = "Hoàn thành \"Đêm lạnh\"độ khó điên cuồng"
  },
  Task_62009_Desc = {
    Text = "Hoàn thành \"Đêm Lạnh\"ở bất kỳ độ khó nào"
  },
  Task_62010_Desc = {
    Text = "Hoàn thành \"thấy núi\" mọi mức độ khó"
  },
  Task_62011_Desc = {
    Text = "Hoàn thành \"Đấu Thú\" mọi độ khó"
  },
  Task_62012_Desc = {
    Text = "Hoàn thành \"thấy núi\" mọi mức độ khó"
  },
  Task_62013_Desc = {
    Text = "Sử dụng thân thể được đánh thức siêu không gian giới vực trong \"Dã Tâm Dã Thú\"để chiến thắng 1 lần"
  },
  Task_62014_Desc = {
    Text = "Hàm Sơn Vĩ Đại"
  },
  Task_62015_Desc = {
    Text = "Hoàn thành \"Phá Thổ\"độ khó điên cuồng"
  },
  Task_62016_Desc = {
    Text = "Thú dữ · Điên Cuồng"
  },
  Task_62017_Desc = {
    Text = "Vượt qua \"trở về\"độ khó điên cuồng"
  },
  Task_62018_Desc = {
    Text = "Tham vọng của thú dữ·hoàn thành"
  },
  Task_62019_Desc = {
    Text = "Sử dụng thân thể được đánh thức từ vùng giới sâu thẳm để giành chiến thắng 1 lần trong \"Dã Tâm Thú Tính\""
  },
  Task_62020_Desc = {
    Text = "Trong \"hy vọng tái sinh\", trao đổi hoa nụ để nhận được 100 phần thưởng"
  },
  Task_62021_Desc = {
    Text = "Trong \"Ý chí báo thù\", nhận được 200 phần thưởng bằng cách đổi chỗ hoa nụ"
  },
  Task_62022_Desc = {
    Text = "Trong \"lòng căm thù chiến đấu\" hoán đổi nụ hoa nhận được 100 lần hồi đáp"
  },
  Task_62023_Desc = {
    Text = "Hoàn thành tất cả nhiệm vụ trong \"Dã tâm mãnh thú·Thông quan\""
  },
  Task_62024_Desc = {
    Text = "Sử dụng thân thể được đánh thức của giới vực hỗn loạn để chiến thắng 1 lần trong \"Dã Tâm Thú Vật\""
  },
  Task_62025_Desc = {
    Text = "Trong \"hy vọng tái sinh\"đổi chỗ hoa nụ nhận được 200 lần hồi đáp"
  },
  Task_62026_Desc = {
    Text = "Hoàn thành \"trở về\"ở bất kỳ độ khó nào"
  },
  Task_62027_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong giới vực thịt máu để chiến thắng 1 lần trong \"Hùng Tâm Dã Thú\""
  },
  Task_62028_Desc = {
    Text = "Hoàn thành \"Đấu Thú\" mọi độ khó"
  },
  Task_62029_Desc = {
    Text = "Hoàn thành \"Đấu Thú\"độ khó điên cuồng"
  },
  Task_62030_Desc = {
    Text = "Hoàn thành \"trở về\"ở bất kỳ độ khó nào"
  },
  Task_62031_Desc = {
    Text = "Hoàn thành \"Phá Thổ\"ở bất kỳ độ khó nào"
  },
  Task_62092_Desc = {
    Text = "Hoàn thành đặc vụ\"người trở về của Elworth\""
  },
  Task_62207_Desc = {
    Text = "Chuỗi Máu · Hiro tỷ lệ đồng điều đạt cấp 10"
  },
  Task_62209_Desc = {
    Text = "Rời khỏi tuyết sơn"
  },
  Task_62209_Name = {
    Text = "Mục tiêu"
  },
  Task_62231_Desc = {
    Text = "Nhận được Lắc khi đạt cấp độ khởi linh 6"
  },
  Task_62231_Name = {
    Text = "Nhận được Lắc khi đạt cấp độ khởi linh 6"
  },
  Task_62231_UnlockCondDesc = {
    Text = "Hoạt động@thân thể được đánh thức Gói quà Lắc khởi linh 2"
  },
  Task_62232_Desc = {
    Text = "Nhận được Jenkin khi khởi linh 2"
  },
  Task_62232_Name = {
    Text = "Nhận được Jenkin khi khởi linh 2"
  },
  Task_62232_UnlockCondDesc = {
    Text = "Hoạt động @ Gói quà khởi linh thân thể thức tỉnh Jenkin 1"
  },
  Task_62233_Desc = {
    Text = "Nhận được Jenkin tại cấp độ khởi linh 6"
  },
  Task_62233_Name = {
    Text = "Nhận được Jenkin tại cấp độ khởi linh 6"
  },
  Task_62233_UnlockCondDesc = {
    Text = "Hoạt động@thân thể được đánh thức Jenkin khởi linh quà tặng 2 hoạt động"
  },
  Task_62234_Desc = {
    Text = "Nhận được Hamlin khi khởi linh hai"
  },
  Task_62234_Name = {
    Text = "Nhận được Hamlin khi khởi linh hai"
  },
  Task_62234_UnlockCondDesc = {
    Text = "Sự kiện - Gói quà Thức Tỉnh Thể Hamlin Khởi Linh"
  },
  Task_62235_Desc = {
    Text = "Nhận được Vanda khi khởi linh cấp 2"
  },
  Task_62235_Name = {
    Text = "Nhận được Vanda khi khởi linh cấp 2"
  },
  Task_62235_UnlockCondDesc = {
    Text = "Hoạt động @Gói quà khởi linh Vanda thân thể được đánh thức 1"
  },
  Task_62236_Desc = {
    Text = "Nhận được Ninh Phi Nga khi đạt cấp độ khởi linh 6"
  },
  Task_62236_Name = {
    Text = "Nhận được Ninh Phi Nga khi đạt cấp độ khởi linh 6"
  },
  Task_62236_UnlockCondDesc = {
    Text = "Hoạt động @ Gói quà Thức Tỉnh Khởi Linh của Ninh Phi Nga 2"
  },
  Task_62237_Desc = {
    Text = "Khi khởi linh 2, nhận được Ôrla"
  },
  Task_62237_Name = {
    Text = "Khi khởi linh 2, nhận được Ôrla"
  },
  Task_62237_UnlockCondDesc = {
    Text = "Hoạt động @ Thân thể được đánh thức Ôrla Khởi linh lễ phẩm 1 sự kiện"
  },
  Task_62238_Desc = {
    Text = "Nhận được Vanda khi khởi linh 6"
  },
  Task_62238_Name = {
    Text = "Nhận được Vanda khi khởi linh 6"
  },
  Task_62238_UnlockCondDesc = {
    Text = "Hoạt động @thân thể thức tỉnh Vanda khởi linh quà tặng 2 hoạt động"
  },
  Task_62239_Desc = {
    Text = "Khi nhận được Kassia, kích hoạt Khởi Linh cấp 2"
  },
  Task_62239_Name = {
    Text = "Khi nhận được Kassia, kích hoạt Khởi Linh cấp 2"
  },
  Task_62239_UnlockCondDesc = {
    Text = "Hoạt động @ Gói quà Khởi Linh Kassia Thức Tỉnh 1"
  },
  Task_62240_Desc = {
    Text = "Nhận được Pháp Luân Tư tại cấp độ khởi linh 2"
  },
  Task_62240_Name = {
    Text = "Nhận được Pháp Luân Tư tại cấp độ khởi linh 2"
  },
  Task_62240_UnlockCondDesc = {
    Text = "Hoạt động @ Gói quà thân thể được đánh thức Pháp Luân Tư khởi linh 1"
  },
  Task_62241_Desc = {
    Text = "Khi nhận Hamlin, kích hoạt khởi linh cấp 6"
  },
  Task_62241_Name = {
    Text = "Khi nhận Hamlin, kích hoạt khởi linh cấp 6"
  },
  Task_62241_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà thân thể được đánh thức Hamlin khởi linh 2"
  },
  Task_62242_Desc = {
    Text = "Nhận được tinkerer khi khởi linh 6"
  },
  Task_62242_Name = {
    Text = "Nhận được tinkerer khi khởi linh 6"
  },
  Task_62242_UnlockCondDesc = {
    Text = "Hoạt động @thân thể được đánh thức tinkerer khởi linh 2 hoạt động"
  },
  Task_62243_Desc = {
    Text = "Nhận được Goliath khi khởi linh cấp 6"
  },
  Task_62243_Name = {
    Text = "Nhận được Goliath khi khởi linh cấp 6"
  },
  Task_62243_UnlockCondDesc = {
    Text = "Sự kiện @ Thân thể được đánh thức Goliath khởi linh 2 sự kiện"
  },
  Task_62244_Desc = {
    Text = "Khi nhận được tinkerer, khởi linh 2"
  },
  Task_62244_Name = {
    Text = "Khi nhận được tinkerer, khởi linh 2"
  },
  Task_62244_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà Khởi Linh Thân Thể Được Đánh Thức Tinkerer Sự kiện"
  },
  Task_62245_Desc = {
    Text = "Khi nhận Reia, kích hoạt khởi linh cấp 6"
  },
  Task_62245_Name = {
    Text = "Khi nhận Reia, kích hoạt khởi linh cấp 6"
  },
  Task_62245_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà khởi linh Thức Tỉnh Reia 2"
  },
  Task_62246_Desc = {
    Text = "Nhận tulô khi đạt cấp độ khởi linh 6"
  },
  Task_62246_Name = {
    Text = "Nhận tulô khi đạt cấp độ khởi linh 6"
  },
  Task_62246_UnlockCondDesc = {
    Text = "Hoạt động @thân thể được đánh thức tulô khởi linh 2 hoạt động"
  },
  Task_62247_Desc = {
    Text = "Nhận Yu U Hahi và kích hoạt Khởi Linh cấp 2"
  },
  Task_62247_Name = {
    Text = "Nhận Yu U Hahi và kích hoạt Khởi Linh cấp 2"
  },
  Task_62247_UnlockCondDesc = {
    Text = "Hoạt động @ Gói quà khởi linh - Thức tỉnh thân thể Yu U Hahi 1"
  },
  Task_62248_Desc = {
    Text = "Nhận được tulô khi khởi linh 2"
  },
  Task_62248_Name = {
    Text = "Nhận được tulô khi khởi linh 2"
  },
  Task_62248_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà thân thể được đánh thức Tulô Khởi linh 1"
  },
  Task_62249_Desc = {
    Text = "Nhận được Lily khi khởi linh cấp 6"
  },
  Task_62249_Name = {
    Text = "Nhận được Lily khi khởi linh cấp 6"
  },
  Task_62249_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà thân thể được đánh thức Lily khởi linh 2"
  },
  Task_62250_Desc = {
    Text = "Nhận Phiệt lúc khởi linh 2"
  },
  Task_62250_Name = {
    Text = "Nhận Phiệt lúc khởi linh 2"
  },
  Task_62250_UnlockCondDesc = {
    Text = "Hoạt động @ Gói quà thân thể được đánh thức Phiệt khởi linh 1"
  },
  Task_62251_Desc = {
    Text = "Khi nhận được Đào Đen Đá và tiến hành khởi linh ở cấp 6"
  },
  Task_62251_Name = {
    Text = "Khi nhận được Đào Đen Đá và tiến hành khởi linh ở cấp 6"
  },
  Task_62251_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà khởi linh thân thể được đánh thức Đào Đen Đá 2 Sự kiện"
  },
  Task_62252_Desc = {
    Text = "Nhận Agrippa khi đạt cấp độ khởi linh 6"
  },
  Task_62252_Name = {
    Text = "Nhận Agrippa khi đạt cấp độ khởi linh 6"
  },
  Task_62252_UnlockCondDesc = {
    Text = "Sự kiện @ thân thể được đánh thức Agrippa khởi linh gói quà 2 Sự kiện"
  },
  Task_62253_Desc = {
    Text = "Khi nhận Pandia, Khởi Linh cấp 2"
  },
  Task_62253_Name = {
    Text = "Khi nhận Pandia, Khởi Linh cấp 2"
  },
  Task_62253_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà khởi linh Pandia thân thể được đánh thức 1"
  },
  Task_62254_Desc = {
    Text = "Nhận được Đào Đen Đá khởi linh 2"
  },
  Task_62254_Name = {
    Text = "Nhận được Đào Đen Đá khởi linh 2"
  },
  Task_62254_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà Thức Tỉnh Đào Đen Đá Khởi Linh 1"
  },
  Task_62255_Desc = {
    Text = "Khi nhận được Sorrel, kích hoạt khởi linh 2"
  },
  Task_62255_Name = {
    Text = "Khi nhận được Sorrel, kích hoạt khởi linh 2"
  },
  Task_62255_UnlockCondDesc = {
    Text = "Hoạt động @ Thức tỉnh thân thể được đánh thức Sorrel Khởi linh lễ phẩm 1"
  },
  Task_62256_Desc = {
    Text = "Nhận Pandia khi Khởi Linh 6"
  },
  Task_62256_Name = {
    Text = "Nhận Pandia khi Khởi Linh 6"
  },
  Task_62256_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà thân thể được đánh thức Pandia khởi linh 2 Sự kiện"
  },
  Task_62257_Desc = {
    Text = "Nhận được \"24\" khi đạt cấp độ khởi linh 6"
  },
  Task_62257_Name = {
    Text = "Nhận được \"24\" khi đạt cấp độ khởi linh 6"
  },
  Task_62257_UnlockCondDesc = {
    Text = "Hoạt động @thân thể được đánh thức \"24\" khởi linh gói quà 2"
  },
  Task_62258_Desc = {
    Text = "Khi nhận được Liz, khởi linh cấp độ 2"
  },
  Task_62258_Name = {
    Text = "Khi nhận được Liz, khởi linh cấp độ 2"
  },
  Task_62258_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà Liz Thức Tỉnh Khởi Linh"
  },
  Task_62259_Desc = {
    Text = "Nhận được \"24\" khi khởi linh 2"
  },
  Task_62259_Name = {
    Text = "Nhận được \"24\" khi khởi linh 2"
  },
  Task_62259_UnlockCondDesc = {
    Text = "Sự kiện @thân thể được đánh thức \"24\" Gói quà khởi linh 1"
  },
  Task_62260_Desc = {
    Text = "Nhận được Liz khi Khởi Linh 6"
  },
  Task_62260_Name = {
    Text = "Nhận được Liz khi Khởi Linh 6"
  },
  Task_62260_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà thân thể được đánh thức Liz khởi linh 2"
  },
  Task_62261_Desc = {
    Text = "Nhận được Hiro khi khởi linh hai"
  },
  Task_62261_Name = {
    Text = "Nhận được Hiro khi khởi linh hai"
  },
  Task_62261_UnlockCondDesc = {
    Text = "Hoạt động @ Gói quà khởi linh thân thể được đánh thức Hiro Hoạt động"
  },
  Task_62262_Desc = {
    Text = "Nhận được Salvador khi khởi linh 2"
  },
  Task_62262_Name = {
    Text = "Nhận được Salvador khi khởi linh 2"
  },
  Task_62262_UnlockCondDesc = {
    Text = "Hoạt động @ Gói quà khởi linh thân thể được đánh thức Salvador"
  },
  Task_62263_Desc = {
    Text = "Nhận được Hiro khi khởi linh6"
  },
  Task_62263_Name = {
    Text = "Nhận được Hiro khi khởi linh6"
  },
  Task_62263_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà Hiro thân thể được đánh thức khởi linh 2"
  },
  Task_62264_Desc = {
    Text = "Khi nhận Salvador, đạt cấp độ Khởi Linh 6"
  },
  Task_62264_Name = {
    Text = "Khi nhận Salvador, đạt cấp độ Khởi Linh 6"
  },
  Task_62264_UnlockCondDesc = {
    Text = "Hoạt động - thức tỉnh thể Salvador khởi linh gói quà 2"
  },
  Task_62265_Desc = {
    Text = "Khi nhận được Ninh Phi Nga, khởi linh cấp 2"
  },
  Task_62265_Name = {
    Text = "Khi nhận được Ninh Phi Nga, khởi linh cấp 2"
  },
  Task_62265_UnlockCondDesc = {
    Text = "Sự kiện @thức tỉnh Ninh Phi Nga khởi linh quà tặng 1"
  },
  Task_62266_Desc = {
    Text = "Nhận được Muphí khi khởi linh cấp 2"
  },
  Task_62266_Name = {
    Text = "Nhận được Muphí khi khởi linh cấp 2"
  },
  Task_62266_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà Muphí khởi linh thân thể được đánh thức 1"
  },
  Task_62267_Desc = {
    Text = "Khi nhận Lắc, kích hoạt khởi linh cấp 2"
  },
  Task_62267_Name = {
    Text = "Khi nhận Lắc, kích hoạt khởi linh cấp 2"
  },
  Task_62267_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà Thức tỉnh thân thể Lắc Khởi linh 1"
  },
  Task_62268_Desc = {
    Text = "Nhận được Tà Vy khi khởi linh 6"
  },
  Task_62268_Name = {
    Text = "Nhận được Tà Vy khi khởi linh 6"
  },
  Task_62268_UnlockCondDesc = {
    Text = "@hoạt động Gói quà khởi linh thân thể được đánh thức Tà Vy 2 hoạt động"
  },
  Task_62269_Desc = {
    Text = "Nhận được Pháp Luân Tư khi khởi linh 6"
  },
  Task_62269_Name = {
    Text = "Nhận được Pháp Luân Tư khi khởi linh 6"
  },
  Task_62269_UnlockCondDesc = {
    Text = "Hoạt động @thức tỉnh Pháp Luân Tư khởi linh quà tặng 2"
  },
  Task_62270_Desc = {
    Text = "Khi nhận được Tà Vy, kích hoạt Khởi Linh cấp 2"
  },
  Task_62270_Name = {
    Text = "Khi nhận được Tà Vy, kích hoạt Khởi Linh cấp 2"
  },
  Task_62270_UnlockCondDesc = {
    Text = "Hoạt động - Gói quà thân thể được đánh thức Tà Vy khởi linh 1"
  },
  Task_62271_Desc = {
    Text = "Nhận được Phiệt sau khi khởi linh cấp 6"
  },
  Task_62271_Name = {
    Text = "Nhận được Phiệt sau khi khởi linh cấp 6"
  },
  Task_62271_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà thân thể được đánh thức Phiệt khởi linh 2"
  },
  Task_62272_Desc = {
    Text = "Nhận được Sorrel với cấp độ khởi linh 6"
  },
  Task_62272_Name = {
    Text = "Nhận được Sorrel với cấp độ khởi linh 6"
  },
  Task_62272_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà khởi linh thân thể được đánh thức Sorrel 2"
  },
  Task_62273_Desc = {
    Text = "Khi nhận được sơn Khởi Linh 2"
  },
  Task_62273_Name = {
    Text = "Khi nhận được sơn Khởi Linh 2"
  },
  Task_62273_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà khởi linh thân thể được đánh thức sơn 1"
  },
  Task_62274_Desc = {
    Text = "Khi nhận được Goliath, kích hoạt khởi linh 2"
  },
  Task_62274_Name = {
    Text = "Khi nhận được Goliath, kích hoạt khởi linh 2"
  },
  Task_62274_UnlockCondDesc = {
    Text = "Sự kiện - Gói quà Goliath Thức Tỉnh Khởi Linh 1 sự kiện"
  },
  Task_62275_Desc = {
    Text = "Nhận được Miriam khi khởi linh 2"
  },
  Task_62275_Name = {
    Text = "Nhận được Miriam khi khởi linh 2"
  },
  Task_62275_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà khởi linh thân thể được đánh thức Miriam 1"
  },
  Task_62276_Desc = {
    Text = "Khi nhận được Wenkel, khởi linh 6"
  },
  Task_62276_Name = {
    Text = "Khi nhận được Wenkel, khởi linh 6"
  },
  Task_62276_UnlockCondDesc = {
    Text = "Hoạt động @ tăng thân nhiệt Wenkel khởi linh quà tặng 2 hoạt động"
  },
  Task_62277_Desc = {
    Text = "Nhận được Kẻ khắc sét khi khởi linh cấp 2"
  },
  Task_62277_Name = {
    Text = "Nhận được Kẻ khắc sét khi khởi linh cấp 2"
  },
  Task_62277_UnlockCondDesc = {
    Text = "Hoạt động @ Gói quà khởi linh thân thể được đánh thức Kẻ khắc sét 1"
  },
  Task_62278_Desc = {
    Text = "Nhận được Miriam khi khởi linh 6"
  },
  Task_62278_Name = {
    Text = "Nhận được Miriam khi khởi linh 6"
  },
  Task_62278_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà thức tỉnh Miriam khởi linh 2"
  },
  Task_62279_Desc = {
    Text = "Khi nhận được Wenkel, khởi linh cấp 2"
  },
  Task_62279_Name = {
    Text = "Khi nhận được Wenkel, khởi linh cấp 2"
  },
  Task_62279_UnlockCondDesc = {
    Text = "Hoạt động @ thân thể được đánh thức Wenkel khởi linh quà tặng 1 hoạt động"
  },
  Task_62280_Desc = {
    Text = "Nhận Kẻ khắc sét khi khởi linh cấp 6"
  },
  Task_62280_Name = {
    Text = "Nhận Kẻ khắc sét khi khởi linh cấp 6"
  },
  Task_62280_UnlockCondDesc = {
    Text = "Hoạt động bao gồm Gói quà khởi linh Kẻ khắc sét thân thể được đánh thức 2"
  },
  Task_62281_Desc = {
    Text = "Thu được Nốtira khi khởi linh 2"
  },
  Task_62281_Name = {
    Text = "Thu được Nốtira khi khởi linh 2"
  },
  Task_62281_UnlockCondDesc = {
    Text = "Hoạt động @Nốtira Thức Tỉnh Khởi Linh Quà Tặng 1 hoạt động"
  },
  Task_62282_Desc = {
    Text = "Nhận được Reia khi khởi linh cấp 2"
  },
  Task_62282_Name = {
    Text = "Nhận được Reia khi khởi linh cấp 2"
  },
  Task_62282_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà khởi linh Thức tỉnh Thể Reia 1"
  },
  Task_62283_Desc = {
    Text = "Nhận được Hilaster khi khởi linh cấp 2"
  },
  Task_62283_Name = {
    Text = "Nhận được Hilaster khi khởi linh cấp 2"
  },
  Task_62283_UnlockCondDesc = {
    Text = "Sự kiện thân thể được đánh thức Hilaster khởi linh 1"
  },
  Task_62284_Desc = {
    Text = "Nhận được Gia Lân khi khởi linh cấp 2"
  },
  Task_62284_Name = {
    Text = "Nhận được Gia Lân khi khởi linh cấp 2"
  },
  Task_62284_UnlockCondDesc = {
    Text = "Sự kiện @Gói quà Thức Tỉnh Thể Gia Lân Khởi Linh 1"
  },
  Task_62285_Desc = {
    Text = "Nhận được Sơn khi Khởi Linh 6"
  },
  Task_62285_Name = {
    Text = "Nhận được Sơn khi Khởi Linh 6"
  },
  Task_62285_UnlockCondDesc = {
    Text = "Sự kiện @Gói quà khởi linh thân thể Sơn được đánh thức 2 sự kiện"
  },
  Task_62286_Desc = {
    Text = "Khi nhận được Hilaster, khởi linh cấp 6"
  },
  Task_62286_Name = {
    Text = "Khi nhận được Hilaster, khởi linh cấp 6"
  },
  Task_62286_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà khởi linh Hilaster thân thể được đánh thức 2"
  },
  Task_62287_Desc = {
    Text = "Khi nhận được Gia Lân, đạt cấp khởi linh 6"
  },
  Task_62287_Name = {
    Text = "Khi nhận được Gia Lân, đạt cấp khởi linh 6"
  },
  Task_62287_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà Gia Lân Thức Tỉnh Khởi Linh 2"
  },
  Task_62288_Desc = {
    Text = "Khi nhận Nốtira, khởi linh 6"
  },
  Task_62288_Name = {
    Text = "Khi nhận Nốtira, khởi linh 6"
  },
  Task_62288_UnlockCondDesc = {
    Text = "Hoạt động @ gói quà khởi linh thân thể được đánh thức Nốtira 2 hoạt động"
  },
  Task_62289_Desc = {
    Text = "Nhận được Muphí khi khởi linh 6"
  },
  Task_62289_Name = {
    Text = "Nhận được Muphí khi khởi linh 6"
  },
  Task_62289_UnlockCondDesc = {
    Text = "Hoạt động @ Gói quà Muphí khởi linh thân thể được đánh thức 2"
  },
  Task_62290_Desc = {
    Text = "Nhận được Ôrla khi đạt cấp độ khởi linh 6"
  },
  Task_62290_Name = {
    Text = "Nhận được Ôrla khi đạt cấp độ khởi linh 6"
  },
  Task_62290_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà thân thể được đánh thức Ôrla khởi linh 2"
  },
  Task_62291_Desc = {
    Text = "Nhận được Thái Di Sơ khi khởi linh 2"
  },
  Task_62291_Name = {
    Text = "Nhận được Thái Di Sơ khi khởi linh 2"
  },
  Task_62291_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà khởi linh Thái Di Sơ của thức tỉnh thân 1"
  },
  Task_62292_Desc = {
    Text = "Khi đạt được Elva, khởi linh cấp 6"
  },
  Task_62292_Name = {
    Text = "Khi đạt được Elva, khởi linh cấp 6"
  },
  Task_62292_UnlockCondDesc = {
    Text = "Hoạt động @ Gói quà thân thể được đánh thức Elva khởi linh 2"
  },
  Task_62293_Desc = {
    Text = "Nhận Agrippa khi đạt cấp độ khởi linh hai"
  },
  Task_62293_Name = {
    Text = "Nhận Agrippa khi đạt cấp độ khởi linh hai"
  },
  Task_62293_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà khởi linh thân thể được đánh thức Agrippa 1"
  },
  Task_62294_Desc = {
    Text = "Nhận được Lily khi khởi linh 2"
  },
  Task_62294_Name = {
    Text = "Nhận được Lily khi khởi linh 2"
  },
  Task_62294_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà thể thức tỉnh Lily khởi linh 1 chương trình"
  },
  Task_62295_Desc = {
    Text = "Sau khi nhận Thái Di Sơ, đạt cấp độ khởi linh 6"
  },
  Task_62295_Name = {
    Text = "Sau khi nhận Thái Di Sơ, đạt cấp độ khởi linh 6"
  },
  Task_62295_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà khởi linh thân thể được đánh thức Thái Di Sơ 2"
  },
  Task_62296_Desc = {
    Text = "Khi khởi linh 2, nhận được Elva"
  },
  Task_62296_Name = {
    Text = "Khi khởi linh 2, nhận được Elva"
  },
  Task_62296_UnlockCondDesc = {
    Text = "Hoạt động @ Gói quà khởi linh Elva thân thể được đánh thức"
  },
  Task_62297_Desc = {
    Text = "Nhận Yu U Hahi sau khi khởi linh cấp 6"
  },
  Task_62297_Name = {
    Text = "Nhận Yu U Hahi sau khi khởi linh cấp 6"
  },
  Task_62297_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà khởi linh thân thể được đánh thức Yu U Hahi 2"
  },
  Task_62298_Desc = {
    Text = "Nhận được nguồn gốc Hiro khi đạt cấp độ khởi linh 2"
  },
  Task_62298_Name = {
    Text = "Nhận được nguồn gốc Hiro khi đạt cấp độ khởi linh 2"
  },
  Task_62298_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà Thức tỉnh Nguồn gốc Hiro Khởi linh 1"
  },
  Task_62299_Desc = {
    Text = "Nhận được nguồn gốc Hiro khi đạt cấp độ khởi linh 6"
  },
  Task_62299_Name = {
    Text = "Nhận được nguồn gốc Hiro khi đạt cấp độ khởi linh 6"
  },
  Task_62299_UnlockCondDesc = {
    Text = "Hoạt động @ nguồn gốc thân thể được đánh thức Hiro khởi linh lễ phẩm 2 hoạt động"
  },
  Task_62300_Desc = {
    Text = "Nhận Kassia và kích hoạt Khởi Linh cấp 6"
  },
  Task_62300_Name = {
    Text = "Nhận Kassia và kích hoạt Khởi Linh cấp 6"
  },
  Task_62300_UnlockCondDesc = {
    Text = "Hoạt động @ thân thể được đánh thức Kasia khởi linh gói quà 2 hoạt động"
  },
  Task_62320_Desc = {
    Text = "Hoàn thành bản ghi đặc nhiệm \"Người trở về của Elworth\" khó khăn"
  },
  Task_62320_Name = {
    Text = "Sức sống, phá núi mà ra·khó khăn"
  },
  Task_62321_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"Bản giao hưởng cuối cùng\"độ khó"
  },
  Task_62321_Name = {
    Text = "Chiến đấu, để ghi nhớ·khó khăn"
  },
  Task_62322_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"@1@2\""
  },
  Task_62322_Desc2 = {
    Text = "Đã hoàn thành sự kiện điều tra \"Bản giao hưởng cuối cùng\""
  },
  Task_62322_Name2 = {
    Text = "Chiến đấu, nhân danh ký ức"
  },
  Task_62323_Desc = {
    Text = "Trong cuộc điều tra sự kiện \"@1@2\" cảm ứng 3 lần"
  },
  Task_62323_Desc2 = {
    Text = "Trong sự kiện \"Bản giao hưởng cuối cùng\", cảm ứng 3 lần"
  },
  Task_62323_Name2 = {
    Text = "Hồi âm bền bỉ"
  },
  Task_62324_Desc = {
    Text = "Hoàn thành bản ghi đặc nhiệm \"Săn bắn vui vẻ!\""
  },
  Task_62324_Name = {
    Text = "Sự mỉa mai của số phận"
  },
  Task_62325_Desc = {
    Text = "Trong cuộc điều tra sự kiện \"@1@2\" cộng hưởng 9 lần"
  },
  Task_62325_Desc2 = {
    Text = "Trong sự kiện \"Bản giao hưởng cuối cùng\", khám phá và kết nối sâu sắc 9 lần"
  },
  Task_62325_Name2 = {
    Text = "Cộng hưởng kiên cường III"
  },
  Task_62326_Desc = {
    Text = "Tìm 10 điểm tách ra của chương chính thứ tám \"@1@2\""
  },
  Task_62326_Desc2 = {
    Text = "Tìm 10 điểm phân tích trong Chương VIII: \"Bản giao hưởng cuối cùng\" của cốt truyện chính"
  },
  Task_62326_Name2 = {
    Text = "Thì Thầm Ẩn Giấu VIII"
  },
  Task_62327_Desc = {
    Text = "Hoàn thành bản ghi đặc nhiệm \"Người trở về của Elworth\""
  },
  Task_62327_Name = {
    Text = "Sức sống, vượt núi mà ra"
  },
  Task_62328_Desc = {
    Text = "Hoàn thành bản ghi đặc nhiệm \"Săn bắn vui vẻ!\"ở độ khó cao"
  },
  Task_62328_Name = {
    Text = "Số phận trêu ngươi·khó khăn"
  },
  Task_62329_Desc = {
    Text = "Hoàn thành bản ghi đặc nhiệm \"Nơi cư trú của hoa hồng\""
  },
  Task_62329_Name = {
    Text = "Hoa và dư âm của thơ"
  },
  Task_62330_Desc = {
    Text = "Trong cuộc điều tra sự kiện \"@1@2\" gây cộng hưởng 6 lần"
  },
  Task_62330_Desc2 = {
    Text = "Trong sự kiện \"Bản giao hưởng cuối cùng\", tạo cộng hưởng 6 lần"
  },
  Task_62330_Name2 = {
    Text = "Hồi âm bền bỉ II"
  },
  Task_62331_Desc = {
    Text = "Trong cuộc điều tra sự kiện \"@1@2\" cộng hưởng 13 lần"
  },
  Task_62331_Desc2 = {
    Text = "Trong sự kiện \"Bản giao hưởng cuối cùng\"đạt 13 lần cảm ứng"
  },
  Task_62331_Name2 = {
    Text = "Dư âm kiên cường IV"
  },
  Task_62332_Desc = {
    Text = "Hoàn thành bản ghi đặc nhiệm \"Nơi cư trú của hoa hồng\"ở độ khó khó khăn"
  },
  Task_62332_Name = {
    Text = "Dư hương của hoa và thơ·khó khăn"
  },
  Task_62346_Desc = {
    Text = "Đánh bại \"Quyền năng Quên lãng Hoàn hảo\" mà không cần sự giúp đỡ của Ramona."
  },
  Task_62346_Name = {
    Text = "Vẻ uy nghi vô song của sự cô đơn"
  },
  Task_62371_Desc = {
    Text = "Với sự hỗ trợ của Ramona, đánh bại \"Khởi Nguyên Bị Lãng Quên\"."
  },
  Task_62371_Name = {
    Text = "Giữ lấy tay tôi, Người Giữ Gìn"
  },
  Task_65510_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_65511_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_65512_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_65513_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_65514_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_65515_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_65516_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_65517_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_65518_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_65519_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_65722_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong giới vực thịt máu để chiến thắng 1 lần trong \"Mã Hóa Ký Ức\""
  },
  Task_65723_Desc = {
    Text = "Hoàn thành \"gương\"ở bất kỳ độ khó nào"
  },
  Task_65724_Desc = {
    Text = "Sử dụng thân thể được đánh thức siêu việt giới vực để giành chiến thắng 1 lần tại \"ký ức mã hóa\""
  },
  Task_65725_Desc = {
    Text = "Mã hóa ký ức - hoàn thành"
  },
  Task_65726_Desc = {
    Text = "Ký ức mã hóa - giới vực"
  },
  Task_65727_Desc = {
    Text = "Hoàn thành \"Hạnh Nhân Thể\"ở độ khó điên cuồng"
  },
  Task_65728_Desc = {
    Text = "Hoàn thành \"Đường cong Quên lãng\"độ khó điên cuồng"
  },
  Task_65729_Desc = {
    Text = "Sử dụng thân thể được đánh thức từ giới vực hỗn loạn để chiến thắng 1 lần trong \"ký ức mã hóa\""
  },
  Task_65730_Desc = {
    Text = "Hoàn thành \"Hạnh Nhân Thể\" bất kỳ độ khó nào"
  },
  Task_65731_Desc = {
    Text = "Hoàn thành \"Hạnh Nhân Thể\" bất kỳ độ khó nào"
  },
  Task_65732_Desc = {
    Text = "Hoàn thành \"gương\"ở bất kỳ độ khó nào"
  },
  Task_65733_Desc = {
    Text = "Hoàn thành \"Đường cong Quên lãng\"ở mọi độ khó"
  },
  Task_65734_Desc = {
    Text = "Hoàn thành \"Não côn trùng\" bất kỳ độ khó nào"
  },
  Task_65735_Desc = {
    Text = "Hoàn thành tất cả nhiệm vụ \"ký ức mã hóa·hoàn thành\""
  },
  Task_65736_Desc = {
    Text = "Hoàn thành \"Đường cong Quên lãng\"ở mọi độ khó"
  },
  Task_65737_Desc = {
    Text = "Hoàn thành \"Ghi nhớ vô thức\" bất kỳ độ khó nào"
  },
  Task_65738_Desc = {
    Text = "Hoàn thành \"Gương\"độ khó điên cuồng"
  },
  Task_65739_Desc = {
    Text = "Ký ức mã hóa - điên cuồng"
  },
  Task_65740_Desc = {
    Text = "Hoàn thành \"Ghi nhớ vô thức\" bất kỳ độ khó nào"
  },
  Task_65741_Desc = {
    Text = "Hoàn thành đặc vụ báo cáo \"Tĩnh lặng chia đôi\""
  },
  Task_65742_Desc = {
    Text = "Hoàn thành \"ghi nhớ vô thức\"độ khó điên cuồng"
  },
  Task_65743_Desc = {
    Text = "Hoàn thành \"Não côn trùng\" bất kỳ độ khó nào"
  },
  Task_65744_Desc = {
    Text = "Hoàn thành \"bộ não bọ cạp\"ở độ khó điên cuồng"
  },
  Task_65745_Desc = {
    Text = "Sử dụng thân thể được đánh thức vùng giới sâu thẳm để chiến thắng 1 lần trong \"ký ức mã hóa\""
  },
  Task_66015_Desc = {
    Text = "Tà Vy tỷ lệ đồng điều đạt cấp 10"
  },
  Task_66213_Desc = {
    Text = "Thần quốc giáng lâm · Điên cuồng"
  },
  Task_66214_Desc = {
    Text = "Sử dụng thân thể được đánh thức siêu việt giới vực để chiến thắng 1 lần trong \"thần quốc đản lâm\""
  },
  Task_66215_Desc = {
    Text = "Hoàn thành \"chứng kiến\"ở bất kỳ độ khó nào"
  },
  Task_66216_Desc = {
    Text = "Hoàn thành \"động lắc\" mức độ khó điên cuồng"
  },
  Task_66217_Desc = {
    Text = "Hoàn thành \"đến\"ở mọi cấp độ"
  },
  Task_66218_Desc = {
    Text = "Hoàn thành \"niềm tin kiên định\"độ khó điên cuồng"
  },
  Task_66219_Desc = {
    Text = "Sử dụng thân thể được đánh thức của Hỗn Loạn Giới Vực để chiến thắng 1 lần trong \"Thần Quốc Đản Lâm\""
  },
  Task_66220_Desc = {
    Text = "Hoàn thành \"tin tưởng\"ở bất kỳ độ khó nào"
  },
  Task_66221_Desc = {
    Text = "Hoàn thành \"chứng kiến\"ở bất kỳ độ khó nào"
  },
  Task_66224_Desc = {
    Text = "Hoàn thành \"thách thức\" bất kỳ độ khó nào"
  },
  Task_66227_Desc = {
    Text = "Hoàn thành Thế giới Mộng Ảo \"Phỉ báng\""
  },
  Task_66228_Desc = {
    Text = "Hoàn thành tất cả nhiệm vụ trong \"Đến từ đất thánh\""
  },
  Task_66229_Desc = {
    Text = "Hoàn thành \"chứng kiến(sự kiện)\"độ khó điên cuồng"
  },
  Task_66230_Desc = {
    Text = "Sử dụng thân thể được đánh thức vùng giới sâu thẳm để chiến thắng 1 lần trong \"thần quốcđản lâm\""
  },
  Task_66231_Desc = {
    Text = "Hoàn thành \"Đại Nạn\"ở độ khó điên cuồng"
  },
  Task_66232_Desc = {
    Text = "Thần quốc giáng lâm · giới vực"
  },
  Task_66233_Desc = {
    Text = "Hoàn thành \"độnglắc\"ở bất kỳ độ khó nào"
  },
  Task_66235_Desc = {
    Text = "Hoàn thành \"Nghi vấn\"độ khó điên cuồng"
  },
  Task_66236_Desc = {
    Text = "Sử dụng thân thể được đánh thức của giới vực thịt máu để chiến thắng 1 lần trong \"thần quốc giáng lâm\""
  },
  Task_66237_Desc = {
    Text = "Hoàn thành \"đến\"ở mọi cấp độ"
  },
  Task_66238_Desc = {
    Text = "Hoàn thành \"độnglắc\"ở bất kỳ độ khó nào"
  },
  Task_66240_Desc = {
    Text = "Thần quốc đản lâm·hoàn thành"
  },
  Task_66241_Desc = {
    Text = "Hoàn thành \"tin tưởng\"ở bất kỳ độ khó nào"
  },
  Task_66242_Desc = {
    Text = "Hoàn thành \"thách thức\" bất kỳ độ khó nào"
  },
  Task_66243_Desc = {
    Text = "Phản hồi của vực thẳm"
  },
  Task_66335_Desc = {
    Text = "Trốn thoát khỏi hội nghị thẩm tra và bị đuổi bắt"
  },
  Task_66335_Name = {
    Text = "Mục tiêu"
  },
  Task_66336_Desc = {
    Text = "Ngăn chặn chú chó có khuôn mặt giống người gửi tin"
  },
  Task_66336_Name = {
    Text = "Mục tiêu"
  },
  Task_66337_Desc = {
    Text = "Vượt qua sự phong tỏa của hội nghị thẩm tra"
  },
  Task_66337_Name = {
    Text = "Mục tiêu"
  },
  Task_66338_Desc = {
    Text = "Đánh bại Thái Di Sơ"
  },
  Task_66338_Name = {
    Text = "Mục tiêu"
  },
  Task_66339_Desc = {
    Text = "Đánh bại mục tiêu N"
  },
  Task_66339_Name = {
    Text = "Mục tiêu"
  },
  Task_66340_Desc = {
    Text = "Chặn đứng cuộc tấn công từ hội nghị thẩm tra"
  },
  Task_66340_Name = {
    Text = "Mục tiêu"
  },
  Task_66341_Desc = {
    Text = "Phá hủy tượng thần hai anh em"
  },
  Task_66341_Name = {
    Text = "Mục tiêu"
  },
  Task_66342_Desc = {
    Text = "Ngăn chặn Hamlin"
  },
  Task_66342_Name = {
    Text = "Mục tiêu"
  },
  Task_66343_Desc = {
    Text = "Tìm Tà Vy"
  },
  Task_66343_Name = {
    Text = "Mục tiêu"
  },
  Task_66344_Desc = {
    Text = "Cản Yu Li-ét"
  },
  Task_66344_Name = {
    Text = "Mục tiêu"
  },
  Task_66422_Name = {
    Text = "Đánh bại BOSS 1N lần"
  },
  Task_66423_Name = {
    Text = "Đánh bại BOSS 2N lần"
  },
  Task_66424_Name = {
    Text = "Đánh bại BOSS 3 N lần"
  },
  Task_66425_Name = {
    Text = "Đánh bại BOSS \"4N\" lần"
  },
  Task_66426_Name = {
    Text = "Đánh bại BOSS 5N lần"
  },
  Task_66428_Name = {
    Text = "Tiêu diệt tất cả các BOSS"
  },
  Task_66580_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_66580_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_66581_Desc = {
    Text = "Hoàn thành khi mang theo ít nhất 8 món đồ"
  },
  Task_66581_Name = {
    Text = "Kho báu kỳ binh"
  },
  Task_66582_Desc = {
    Text = "Thắng trong vòng 25 lượt"
  },
  Task_66582_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_66583_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_66583_Name = {
    Text = "Thanh lịch và chính xác"
  },
  Task_66584_Desc = {
    Text = "Hoàn thành khi mang theo ít nhất 8 món đồ"
  },
  Task_66584_Name = {
    Text = "Kho báu kỳ binh"
  },
  Task_66585_Desc = {
    Text = "Cuộc chiến cuối cùng, trong một lượt gây ít nhất 200000 điểm sát thương"
  },
  Task_66585_Name = {
    Text = "Đòn toàn lực"
  },
  Task_66724_Desc = {
    Text = "Hoàn thành \"Khởi Hành\"độ khó điên cuồng"
  },
  Task_66725_Desc = {
    Text = "Hoàn thành \"Cánh cửa các thế giới\"độ khó điên cuồng"
  },
  Task_66726_Desc = {
    Text = "Hoàn thành \"Cửa Tri Hành\"ở độ khó điên cuồng"
  },
  Task_66727_Desc = {
    Text = "Hoàn thành \"Cửa Cực Hạn\" bất kỳ độ khó nào"
  },
  Task_66728_Desc = {
    Text = "Hoàn thành \"Cửa Đúng Sai\"ở độ khó điên cuồng"
  },
  Task_66729_Desc = {
    Text = "Hoàn thành \"Cổng Quy Nhất\" bất kỳ độ khó nào"
  },
  Task_66730_Desc = {
    Text = "Hoàn thành \"Khởi Hành\" bất kỳ độ khó nào"
  },
  Task_66731_Desc = {
    Text = "Hoàn thành \"Cổng Đúng Sai\"ở bất kỳ độ khó nào"
  },
  Task_66732_Desc = {
    Text = "Hoàn thành \"Bên trong cánh cửa\"ở độ khó điên cuồng"
  },
  Task_66733_Desc = {
    Text = "Sử dụng thân thể được đánh thức vùng giới sâu thẳm để chiến thắng 1 lần trong \"Cuộc Thử Nghiệm Cuối Cùng\""
  },
  Task_66734_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong siêu không gian giới vực để chiến thắng 2 lần trong \"Thử Thách Cuối Cùng\""
  },
  Task_66735_Desc = {
    Text = "Sử dụng thân thể được đánh thức của vùng giới sâu thẳm và giành chiến thắng 2 lần trong \"Kiểm Tra Cuối Cùng\""
  },
  Task_66736_Desc = {
    Text = "Sử dụng thân thể thức tỉnh trong siêu không gian giới vực để chiến thắng 1 lần trong \"Cuộc thử nghiệm cuối cùng\""
  },
  Task_66737_Desc = {
    Text = "Hoàn thành \"Cổng Đúng Sai\"ở bất kỳ độ khó nào"
  },
  Task_66738_Desc = {
    Text = "Hoàn thành \"Cửa Tri Hành\"ở bất kỳ độ khó nào"
  },
  Task_66739_Desc = {
    Text = "Cuối cùng thử nghiệm · điên cuồng"
  },
  Task_66740_Desc = {
    Text = "Hoàn thành \"Cửa Tri Hành\"ở bất kỳ độ khó nào"
  },
  Task_66741_Desc = {
    Text = "Hoàn thành \"Cánh cửa của các thế giới\"ở bất kỳ độ khó nào"
  },
  Task_66742_Desc = {
    Text = "Hoàn thành \"Cửa Cực Hạn\" bất kỳ độ khó nào"
  },
  Task_66743_Desc = {
    Text = "Hoàn thành \"bên trong cánh cửa\"ở bất kỳ độ khó nào"
  },
  Task_66744_Desc = {
    Text = "Kiểm tra cuối cùng·hoàn thành"
  },
  Task_66745_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong giới vực thịt máu để chiến thắng 2 lần trong \"Thử Thách Cuối Cùng\""
  },
  Task_66746_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong lãnh địa huyết nhục để chiến thắng 1 lần trong \"Thử Nghiệm Cuối Cùng\""
  },
  Task_66747_Desc = {
    Text = "Hoàn thành \"Cánh cửa Lý trí\"ở độ khó điên cuồng"
  },
  Task_66748_Desc = {
    Text = "Hoàn thành \"Cánh cửa Hợp nhất\"độ khó điên cuồng"
  },
  Task_66749_Desc = {
    Text = "Hoàn thành \"Khởi Hành\" bất kỳ độ khó nào"
  },
  Task_66750_Desc = {
    Text = "Sử dụng thân thể được đánh thức của hỗn loạn giới vực và giành chiến thắng 2 lần trong \"Cuộc thử nghiệm cuối cùng\""
  },
  Task_66751_Desc = {
    Text = "Sử dụng thân thể được đánh thức của giới vực hỗn loạn để chiến thắng 1 lần trong \"Thử thách Cuối cùng\""
  },
  Task_66752_Desc = {
    Text = "Hoàn thành \"bên trong cánh cửa\"ở bất kỳ độ khó nào"
  },
  Task_66753_Desc = {
    Text = "Hoàn thành \"Cổng Bản Tính\"ở bất kỳ độ khó nào"
  },
  Task_66754_Desc = {
    Text = "Hoàn thành \"Bản tính chi môn\" mức độ điên cuồng"
  },
  Task_66755_Desc = {
    Text = "Hoàn thành \"Cửa Cùng Tận\"ở độ khó điên cuồng"
  },
  Task_66756_Desc = {
    Text = "Thử nghiệm cuối cùng · giới vực"
  },
  Task_66757_Desc = {
    Text = "Hoàn thành tất cả nhiệm vụ \"kiểm tra cuối cùng·hoàn thành\""
  },
  Task_66758_Desc = {
    Text = "Hoàn thành \"Cửa Lý Trí\"ở bất kỳ độ khó nào"
  },
  Task_66759_Desc = {
    Text = "Hoàn thành \"Cổng Bản Tính\"ở bất kỳ độ khó nào"
  },
  Task_66760_Desc = {
    Text = "Hoàn thành \"Cánh cửa của các thế giới\"ở bất kỳ độ khó nào"
  },
  Task_66761_Desc = {
    Text = "Hoàn thành \"Cửa Lý Trí\"ở bất kỳ độ khó nào"
  },
  Task_66762_Desc = {
    Text = "Hoàn thành \"Cổng Quy Nhất\" bất kỳ độ khó nào"
  },
  Task_67066_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_67067_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_67068_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_67069_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_67070_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_67071_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_67072_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_67073_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_67075_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_67076_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_67113_Desc = {
    Text = "Tìm thấy 2 điểm kết thúc chương cuối \"@1@2\""
  },
  Task_67113_Desc2 = {
    Text = "Tìm 2 điểm phân tích chương cuối của tuyến chính \"Thời Điểm Giấc Mơ Dài Kết Thúc\""
  },
  Task_67113_Name2 = {
    Text = "Lời thì thầm tiềm ẩn IX"
  },
  Task_67114_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"Khi giấc mơ dài kết thúc\" khó khăn"
  },
  Task_67114_Name = {
    Text = "Canh gác, đến hơi thở cuối cùng · khó khăn"
  },
  Task_67115_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"@1@2\""
  },
  Task_67115_Desc2 = {
    Text = "Hoàn thành sự kiện điều tra \"Khi Trường Mộng Kết Thúc\""
  },
  Task_67115_Name2 = {
    Text = "Canh gác đến hơi thở cuối cùng"
  },
  Task_67116_Desc = {
    Text = "Trong cuộc điều tra sự kiện \"@1@2\" cảm ứng 3 lần"
  },
  Task_67116_Desc2 = {
    Text = "Trong sự kiện \"Dài Mộng Tận Thời\", cảm ứng 3 lần"
  },
  Task_67116_Name2 = {
    Text = "Vọng âm tột độ"
  },
  Task_67125_Name = {
    Text = "Đánh bại BOSS 6N lần"
  },
  Task_67126_Name = {
    Text = "Đánh bại BOSS 7N lần"
  },
  Task_67408_Desc = {
    Text = "Chặn đứng Toghvab, đóng cánh cửa lại"
  },
  Task_67408_Name = {
    Text = "Mục tiêu"
  },
  Task_67409_Desc = {
    Text = "Tìm ra kẻ nội gián trong nhóm Misaque"
  },
  Task_67409_Name = {
    Text = "Mục tiêu"
  },
  Task_67410_Desc = {
    Text = "Ngăn cản Toghvab"
  },
  Task_67410_Name = {
    Text = "Mục tiêu"
  },
  Task_67411_Desc = {
    Text = "Tạm biệt những thể thức tỉnh"
  },
  Task_67411_Name = {
    Text = "Mục tiêu"
  },
  Task_67827_Desc = {
    Text = "Hãy khuất phục… Hãy khuất phục trước, sự thật vĩnh cửu của hỗn loạn…"
  },
  Task_67827_Name = {
    Text = "Hãy khuất phục… Hãy khuất phục trước, sự thật vĩnh cửu của hỗn loạn…"
  },
  Task_67828_Desc = {
    Text = "Sự điên rồ của Ngài là không thể kháng cự."
  },
  Task_67828_Name = {
    Text = "Sự điên rồ của Ngài là không thể kháng cự."
  },
  Task_67829_Desc = {
    Text = "Vẻ uy nghi của Ngài, không thể nhìn thẳng."
  },
  Task_67829_Name = {
    Text = "Vẻ uy nghi của Ngài, không thể nhìn thẳng."
  },
  Task_67919_Desc = {
    Text = "Tiêu diệt tất cả các phân thân của \"Sonanir·điên rồ\"để mở khóa"
  },
  Task_67919_Name = {
    Text = "Đánh bại Trùm 6"
  },
  Task_67920_Desc = {
    Text = "Tiêu diệt tất cả các phân thân của \"bảo tàng sáp·khủng bố chi thị\"để mở khóa"
  },
  Task_67920_Name = {
    Text = "Tiêu diệt BOSS2"
  },
  Task_67921_Desc = {
    Text = "Tiêu diệt tất cả các phân thân của \"Bệnh viện Điều dưỡng·Nhìn thấy Kì quái\"để mở khóa"
  },
  Task_67921_Name = {
    Text = "Đánh bại BOSS4 (Trùm 4)"
  },
  Task_67922_Desc = {
    Text = "Tiêu diệt \"Brielle Perte·Tà Tín Chi Thị\" và tất cả các phân thân để mở khóa"
  },
  Task_67922_Name = {
    Text = "Đánh bại BOSS5"
  },
  Task_67923_Desc = {
    Text = "Tiêu diệt tất cả các phân thân của \"Từ thiện viện · Ánh nhìn ai oán\"để mở khóa"
  },
  Task_67923_Name = {
    Text = "Đánh bại BOSS1"
  },
  Task_67924_Desc = {
    Text = "Tiêu diệt tất cả các phân thân của \"Lemvahi·Sự ra đời của thị giác\"để mở khóa"
  },
  Task_67924_Name = {
    Text = "Đánh bại BOSS7"
  },
  Task_67925_Desc = {
    Text = "Tiêu diệt tất cả các phân thân của \"Lai Y · Thích Cốt Chi Thị\"để mở khóa"
  },
  Task_67925_Name = {
    Text = "Tiêu diệt BOSS3"
  },
  Task_67926_Name = {
    Text = "Tất cả các phân thân của 5 Nguyên Thủy Thị Giác đã bị đánh bại"
  },
  Task_67927_Name = {
    Text = "2 Nguyên Thủy Thị tất cả phân thân bị tiêu diệt"
  },
  Task_67928_Name = {
    Text = "Tất cả 4 phân thân của Nguyên Thủy Chi Nhãn đã bị tiêu diệt"
  },
  Task_67929_Name = {
    Text = "Tất cả các phân thân của 6 Nguyên Thủy Chi Thị đã bị tiêu diệt"
  },
  Task_67930_Name = {
    Text = "Tất cả các phân thân của Tầm Nhìn Nguyên Sơ đã bị tiêu diệt"
  },
  Task_67931_Name = {
    Text = "7 cái phân thân của Nguyên Thủy Chi Thị đã bị đánh bại"
  },
  Task_67932_Name = {
    Text = "Tất cả phân thân của 3 Nguyên Thủy Thị đã bị tiêu diệt"
  },
  Task_68342_Desc = {
    Text = "Vượt qua tinh tú III"
  },
  Task_68343_Desc = {
    Text = "Vượt qua tinh tú V"
  },
  Task_68344_Desc = {
    Text = "Vượt qua tinh tú VII"
  },
  Task_68345_Desc = {
    Text = "Vượt qua tinh tú II"
  },
  Task_68346_Desc = {
    Text = "Vượt qua tinh tú IV"
  },
  Task_68347_Desc = {
    Text = "Vượt qua tinh tú I"
  },
  Task_68348_Desc = {
    Text = "Vượt qua tinh tú VI"
  },
  Task_68365_Desc = {
    Text = "Vượt qua sao · miễn phí"
  },
  Task_68377_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_68378_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_68379_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_68380_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_68382_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_68383_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_68384_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_68385_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_68386_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_68387_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_68388_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_68389_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_68390_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_68391_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_68392_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_68393_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_68394_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_68395_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_68396_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_68397_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_68418_Name = {
    Text = "Sự kiện Boss Thế Giới kết thúc"
  },
  Task_68492_Desc = {
    Text = "Sử dụng thân thể được đánh thức vùng giới sâu thẳm để chiến thắng 1 lần trong \"biển sâu ngưng thị\""
  },
  Task_68493_Desc = {
    Text = "Hoàn thành \"Mắt Thần\"độ khó điên cuồng"
  },
  Task_68494_Desc = {
    Text = "Sử dụng thân thể được đánh thức siêu không gian giới vực để giành chiến thắng 1 lần trong \"biển sâu ngắm nhìn\""
  },
  Task_68495_Desc = {
    Text = "Hoàn thành \"Mộng Tưởng Tuyệt Vời\" bất kỳ độ khó nào"
  },
  Task_68496_Desc = {
    Text = "Hoàn thành \"mộng tưởng tươi đẹp\"độ khó điên cuồng"
  },
  Task_68497_Desc = {
    Text = "Hoàn thành \"Nhân Tính Sụp Đổ\" bất kỳ độ khó nào"
  },
  Task_68498_Desc = {
    Text = "Hoàn thành \"Sự sụp đổ của nhân tính\"ở độ khó điên cuồng"
  },
  Task_68499_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong giới vực thịt máu để chiến thắng 1 lần trong \"biển sâu ngắm nhìn\""
  },
  Task_68500_Desc = {
    Text = "Hoàn thành \"Mắt Thần\" bất kỳ độ khó nào"
  },
  Task_68501_Desc = {
    Text = "Hoàn thành \"Nhân Tính Sụp Đổ\" bất kỳ độ khó nào"
  },
  Task_68502_Desc = {
    Text = "Hoàn thành \"nỗi nhớ quê\"ở bất kỳ độ khó nào"
  },
  Task_68503_Desc = {
    Text = "Sử dụng thân thể được đánh thức của giới vực hỗn loạn để chiến thắng 1 lần trong \"biển sâu ngắm nhìn\""
  },
  Task_68504_Desc = {
    Text = "Biển sâu·điên cuồng"
  },
  Task_68505_Desc = {
    Text = "Hoàn thành \"Mộng Tưởng Tuyệt Vời\" bất kỳ độ khó nào"
  },
  Task_68506_Desc = {
    Text = "Hoàn thành \"Quốc Độ Suy Thoái\"ở bất kỳ độ khó nào"
  },
  Task_68507_Desc = {
    Text = "Biển sâu ngắm nhìn hoàn thành"
  },
  Task_68508_Desc = {
    Text = "Hoàn thành \"nỗi nhớ quê\"ở bất kỳ độ khó nào"
  },
  Task_68509_Desc = {
    Text = "Hoàn thành \"Nỗi Nhớ Quê Hương\"độ khó cực kỳ điên cuồng"
  },
  Task_68510_Desc = {
    Text = "Hoàn thành \"Quốc Độ Suy Thoái\"ở bất kỳ độ khó nào"
  },
  Task_68511_Desc = {
    Text = "Hoàn thành \"Quốc Độ Suy Thoái\"độ khó điên cuồng"
  },
  Task_68512_Desc = {
    Text = "Biển sâu ngắm nhìn·giới vực"
  },
  Task_68513_Desc = {
    Text = "Hoàn thành \"Nhìn chằm chằm biển sâu·Hoàn thành\" tất cả nhiệm vụ"
  },
  Task_68514_Desc = {
    Text = "Hoàn thành \"Mắt Thần\" bất kỳ độ khó nào"
  },
  Task_68860_Desc = {
    Text = "Đạt được tích lũy 1 trận thắng trong mùa giải này"
  },
  Task_68860_Name = {
    Text = "1 trận thắng"
  },
  Task_68861_Desc = {
    Text = "Đạt được tổng cộng 6 trận thắng trong mùa giải này"
  },
  Task_68861_Name = {Text = "6 thắng"},
  Task_68862_Desc = {
    Text = "Đạt được 3 trận thắng trong mùa giải này"
  },
  Task_68862_Name = {
    Text = "3 trận thắng"
  },
  Task_68863_Desc = {
    Text = "Đạt được tổng cộng 10 trận thắng trong mùa giải này"
  },
  Task_68863_Name = {Text = "10 thắng"},
  Task_68864_Desc = {
    Text = "Đạt được 3 trận thắng trong mùa giải này"
  },
  Task_68864_Name = {
    Text = "3 trận thắng"
  },
  Task_68865_Desc = {
    Text = "Đạt được tổng cộng 6 trận thắng trong mùa giải này"
  },
  Task_68865_Name = {Text = "6 thắng"},
  Task_68866_Desc = {
    Text = "Đạt được tích lũy 1 trận thắng trong mùa giải này"
  },
  Task_68866_Name = {
    Text = "1 trận thắng"
  },
  Task_68867_Desc = {
    Text = "Đạt được tổng cộng 10 trận thắng trong mùa giải này"
  },
  Task_68867_Name = {Text = "10 thắng"},
  Task_69819_Desc = {
    Text = "Chiến thắng trong cuộc chiến cuối cùng trong 35 lượt"
  },
  Task_69819_Name = {
    Text = "Chiến thắng trong cuộc chiến cuối cùng trong 35 lượt"
  },
  Task_70112_Desc = {
    Text = "Sử dụng thân thể được đánh thức vùng giới sâu thẳm và giành chiến thắng một lần trong \"ham muốn hỗn loạn\""
  },
  Task_70113_Desc = {
    Text = "Hoàn thành \"Niên Luân\"độ khó điên cuồng"
  },
  Task_70114_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong vùng giới vực sâu thẳm để thắng 2 lần ở \"ham muốn hỗn loạn\""
  },
  Task_70115_Desc = {
    Text = "Hoàn thành \"Căn Hạt\"ở bất kỳ độ khó nào"
  },
  Task_70116_Desc = {
    Text = "Hoàn thành \"thụ phấn\" bất kỳ độ khó nào"
  },
  Task_70117_Desc = {
    Text = "Hoàn thành \"rễ non\"ở độ khó điên cuồng"
  },
  Task_70118_Desc = {
    Text = "Hoàn thành \"Phát mầm\" bất kỳ độ khó nào"
  },
  Task_70119_Desc = {
    Text = "Sử dụng thân thể được đánh thức siêu việt giới vực để chiến thắng 1 lần trong \"ham muốn hỗn loạn\""
  },
  Task_70120_Desc = {
    Text = "Dùng thân thể được đánh thức ở siêu không gian giới vực, giành 2 chiến thắng trong \"ham muốn hỗn loạn\""
  },
  Task_70121_Desc = {
    Text = "Ham muốn hỗn loạn·điên cuồng"
  },
  Task_70122_Desc = {
    Text = "Hoàn thành \"Quả Rơi\"độ khó điên cuồng"
  },
  Task_70123_Desc = {
    Text = "Ham muốn hỗn loạn, giới vực"
  },
  Task_70124_Desc = {
    Text = "Hoàn thành \"thụ phấn\"độ khó điên cuồng"
  },
  Task_70125_Desc = {
    Text = "Hoàn thành \"đài hoa\"độ khó điên cuồng"
  },
  Task_70126_Desc = {
    Text = "Hoàn thành \"Hoa Tái Sinh\"ở bất kỳ mức độ khó nào"
  },
  Task_70127_Desc = {
    Text = "Hoàn thành \"Hoa Tái Sinh\"ở độ khó điên cuồng"
  },
  Task_70128_Desc = {
    Text = "Hoàn thành \"Phát chồi(phát chồi)\"ở độ khó điên cuồng"
  },
  Task_70129_Desc = {
    Text = "Hoàn thành \"Mật tuyến\" bất kỳ độ khó nào"
  },
  Task_70130_Desc = {
    Text = "Hoàn thành \"vòng năm\"ở bất kỳ độ khó nào"
  },
  Task_70131_Desc = {
    Text = "Hoàn thành \"bào tử\" bất kỳ độ khó nào"
  },
  Task_70132_Desc = {
    Text = "Hoàn thành \"Quả Rơi\" bất kỳ độ khó nào"
  },
  Task_70133_Desc = {
    Text = "Hoàn thành \"Bào Chủng\"độ khó điên cuồng"
  },
  Task_70134_Desc = {
    Text = "Dùng thân thể được đánh thức từ giới vực hỗn loạn, giành chiến thắng 2 lần trong \"dục vọng rối loạn\""
  },
  Task_70135_Desc = {
    Text = "Hoàn thành \"Hoa Đài\" bất kỳ độ khó nào"
  },
  Task_70136_Desc = {
    Text = "Dùng thân thể được đánh thức từ giới vực hỗn loạn để giành chiến thắng một lần tại \"ham muốn hỗn loạn\""
  },
  Task_70137_Desc = {
    Text = "Sử dụng giới vực thịt máu thân thể được đánh thức để giành chiến thắng 2 lần trong \"ham muốn hỗn loạn\""
  },
  Task_70138_Desc = {
    Text = "Hoàn thành \"Sinh sản đa phôi\"độ khó điên cuồng"
  },
  Task_70139_Desc = {
    Text = "Sử dụng thân thể được đánh thức của giới vực thịt máu để giành chiến thắng 1 lần trong \"ham muốn hỗn loạn\""
  },
  Task_70140_Desc = {
    Text = "Hoàn thành \"Sinh sản đa phôi\" bất kỳ độ khó nào"
  },
  Task_70141_Desc = {
    Text = "Hoàn thành \"mật tuyến\"độ khó điên cuồng"
  },
  Task_70307_Desc = {
    Text = "Chiến thắng trong 40 lượt của cuộc chiến cuối cùng"
  },
  Task_70307_Name = {
    Text = "Chiến thắng trong 40 lượt của cuộc chiến cuối cùng"
  },
  Task_70446_Name = {
    Text = "Chơi lại 8-8 để hoàn thành"
  },
  Task_70447_Name = {
    Text = "Chơi lại và hoàn thành 8-4"
  },
  Task_70448_Name = {
    Text = "Chơi lại và hoàn thành chi nhánh Lắc bình thường 12"
  },
  Task_70449_Name = {
    Text = "Hoàn thành nhiệm vụ phụ của Erika cấp độ thường 3"
  },
  Task_70450_Name = {
    Text = "Chơi lại và hoàn thành 3-14"
  },
  Task_70451_Name = {
    Text = "Chơi lại và hoàn thành phụ bản Sơn cấp độ thường 4"
  },
  Task_70452_Name = {
    Text = "Hoàn thành lại nhiệm vụ phụ Ôrla - Mức Thường 9"
  },
  Task_70453_Name = {
    Text = "Chơi lại để hoàn thành phụ bản Orci chế độ thường 4"
  },
  Task_70454_Name = {
    Text = "Chơi lại và hoàn thành 2-16"
  },
  Task_70455_Name = {
    Text = "Chơi lại và hoàn thành 2-15"
  },
  Task_70456_Name = {
    Text = "Hoàn thành lại phụ bản tháp Ô Ryta cấp độ thường 3"
  },
  Task_70457_Name = {
    Text = "Hoàn thành lại \"24\" phụ bản thường 10"
  },
  Task_70458_Name = {
    Text = "Thông qua lại nhiệm vụ phụ Hoa thuỷ tiên cấp độ thường 10"
  },
  Task_70459_Name = {
    Text = "Hoàn thành nhiệm vụ phụ Agrippa thường 5"
  },
  Task_70460_Name = {
    Text = "Chơi lại 6-8"
  },
  Task_70461_Name = {
    Text = "Hoàn thành lại 8-14"
  },
  Task_70462_Name = {
    Text = "Hoàn thành lại nhiệm vụ phụ của Sorrel ở mức độ thường 13"
  },
  Task_70463_Name = {
    Text = "Hoàn thành lại nhiệm vụ phụ của Miriam ở bình thường 15"
  },
  Task_70464_Name = {
    Text = "Hoàn thành lại 8-7"
  },
  Task_70465_Name = {
    Text = "Hoàn thành lại 7-2"
  },
  Task_70466_Name = {
    Text = "Hoàn thành lại 7-3"
  },
  Task_70467_Name = {
    Text = "Hoàn thành lại 7-1"
  },
  Task_70468_Name = {
    Text = "Lặp lại hoàn thành phụ bản nhánh Lily thường 7"
  },
  Task_70469_Name = {
    Text = "Hoàn thành lại bản đồ phụ Ramona nguồn gốc độ khó thường 4"
  },
  Task_70470_Name = {
    Text = "Hoàn thành lại 1-8"
  },
  Task_70471_Name = {
    Text = "Chơi lại nhánh phụ Hiro nguồn gốc cấp Thường 9"
  },
  Task_70472_Name = {
    Text = "Hoàn thành lại 4-16"
  },
  Task_70473_Name = {
    Text = "Hoàn thành lại 1-14"
  },
  Task_70474_Name = {
    Text = "Hoàn thành 4-13"
  },
  Task_70475_Name = {
    Text = "Hoàn thành lại 1-15"
  },
  Task_70476_Name = {
    Text = "Hoàn thành lại 9-13"
  },
  Task_70477_Name = {
    Text = "Chơi lại để hoàn thành 3-2"
  },
  Task_70478_Name = {
    Text = "Hoàn thành lại 3-3"
  },
  Task_70479_Name = {
    Text = "Hoàn thành lại nhánh Yu U Hahi Cấp độ Thường 4"
  },
  Task_70480_Name = {
    Text = "Hoàn thành lại 6-15"
  },
  Task_70481_Name = {
    Text = "Chơi lại để hoàn thành phụ bản Goliath chế độ thường 3"
  },
  Task_70482_Name = {
    Text = "Hoàn thành lại 5-12"
  },
  Task_70483_Name = {
    Text = "Lặp lại hoàn thành 6-10"
  },
  Task_70484_Name = {
    Text = "Hoàn thành lại nhiệm vụ phụ Salvador ở mức độ thường 9"
  },
  Task_70485_Name = {
    Text = "Chơi lại nhiệm vụ phụ của Vanda mức bình thường 4"
  },
  Task_70941_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_70941_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_70942_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_70942_Name = {
    Text = "Thanh lịch và chính xác"
  },
  Task_70943_Desc = {
    Text = "Cuộc chiến cuối cùng, trong một lượt, rút thêm ít nhất 5 lá bài"
  },
  Task_70943_Name = {
    Text = "Vẽ thẻ!"
  },
  Task_70944_Desc = {
    Text = "Khi hoàn thành, số lượng thẻ triệu chứng không vượt quá 2"
  },
  Task_70944_Name = {
    Text = "Tiết kiệm năng lượng"
  },
  Task_70945_Desc = {
    Text = "Nhận được ít nhất 1 loại dấu khắc"
  },
  Task_70945_Name = {
    Text = "Ấn ký linh hồn"
  },
  Task_70946_Desc = {
    Text = "Khi vượt qua, sức sống không được thấp hơn 50%"
  },
  Task_70946_Name = {
    Text = "Thanh lịch và chính xác"
  },
  Task_70947_Desc = {
    Text = "Hoàn thành khi mang theo ít nhất một vật tạo vàng"
  },
  Task_70947_Name = {
    Text = "Kho báu kỳ binh"
  },
  Task_70948_Desc = {
    Text = "Khi hoàn thành, số lượng thẻ triệu chứng không vượt quá 2"
  },
  Task_70948_Name = {
    Text = "Tiết kiệm năng lượng"
  },
  Task_70949_Desc = {
    Text = "Hoàn thành khi mang theo ít nhất 2 vật phẩm"
  },
  Task_70949_Name = {
    Text = "Kho báu kỳ binh"
  },
  Task_70950_Desc = {
    Text = "Hoàn thành khi mang theo ít nhất một vật tạo vàng"
  },
  Task_70950_Name = {
    Text = "Kho báu kỳ binh"
  },
  Task_70951_Desc = {
    Text = "Cuộc chiến cuối cùng, đánh ra ít nhất 5 thẻ trong 1 lượt"
  },
  Task_70951_Name = {
    Text = "Lượt của tôi"
  },
  Task_70952_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_70952_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_70953_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_70953_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_70954_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_70954_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_70955_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_70955_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_70956_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_70956_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_70957_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_70957_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_70958_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_70958_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_70959_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_70959_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_70960_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 10 hiệp"
  },
  Task_70960_Name = {
    Text = "Tốc chiến tốc quyết"
  },
  Task_71343_Desc = {
    Text = "Hoàn thành \"đại họa\"độ khó điên cuồng"
  },
  Task_71344_Desc = {
    Text = "Sử dụng thân thể được đánh thức của hỗn nguyên giới để chiến thắng 1 lần trong \"Cánh Cửa Hư Vô\""
  },
  Task_71345_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong giới vực hỗn loạn để chiến thắng 2 lần trong \"Cánh cửa hư vô\""
  },
  Task_71346_Desc = {
    Text = "Hoàn thành \"Cự Tuyệt Suy Vong\"ở bất kỳ độ khó nào"
  },
  Task_71347_Desc = {
    Text = "Hoàn thành \"Cuồng Tai\"ở bất kỳ độ khó nào"
  },
  Task_71348_Desc = {
    Text = "Hoàn thành \"Dự ngôn hỗn loạn\" mọi độ khó"
  },
  Task_71349_Desc = {
    Text = "Cánh cửa hư vô, Giới vực"
  },
  Task_71350_Desc = {
    Text = "Hoàn thành \"Nhà búp bê\"ở mọi độ khó"
  },
  Task_71351_Desc = {
    Text = "Hoàn thành \"sao\"độ khó điên cuồng"
  },
  Task_71352_Desc = {
    Text = "Hoàn thành \"Cuồng Tai\"ở bất kỳ độ khó nào"
  },
  Task_71353_Desc = {
    Text = "Hoàn thành \"Cự Tuyệt Suy Vong\"ở bất kỳ độ khó nào"
  },
  Task_71354_Desc = {
    Text = "Hoàn thành \"Dạ hội Cuồng hoan\" bất kỳ độ khó nào"
  },
  Task_71355_Desc = {
    Text = "Cánh cửa hư vô · điên cuồng"
  },
  Task_71356_Desc = {
    Text = "Hoàn thành \"dây rối\"ở bất kỳ độ khó nào"
  },
  Task_71357_Desc = {
    Text = "Hoàn thành \"Thuốc độc thực sự\"ở bất kỳ độ khó nào"
  },
  Task_71358_Desc = {
    Text = "Hoàn thành \"Dây rối\"độ khó điên cuồng"
  },
  Task_71359_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong giới vực thịt máu để chiến thắng 2 lần tại \"Cánh Cửa Hư Vô\""
  },
  Task_71360_Desc = {
    Text = "Hoàn thành \"Dự ngôn hỗn loạn\" mọi độ khó"
  },
  Task_71361_Desc = {
    Text = "Hoàn thành \"mời\"độ khó điên cuồng"
  },
  Task_71362_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong siêu không gian giới vực để chiến thắng 2 lần tại \"hư vô chi môn\""
  },
  Task_71363_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong siêu việt giới vực để chiến thắng 1 lần trong \"Cửa Hư Vô\""
  },
  Task_71364_Desc = {
    Text = "Cánh cửa hư vô hoàn thành"
  },
  Task_71365_Desc = {
    Text = "Hoàn thành tất cả thành tựu của \"Cánh cửa hư vô·hoàn thành\""
  },
  Task_71366_Desc = {
    Text = "Hoàn thành \"sự kết thúc rực rỡ\"độ khó điên cuồng"
  },
  Task_71367_Desc = {
    Text = "Hoàn thành \"Độc Dược Chân Thực\"độ khó điên cuồng"
  },
  Task_71368_Desc = {
    Text = "Hoàn thành \"dây rối\"ở bất kỳ độ khó nào"
  },
  Task_71369_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong giới vực thịt máu để chiến thắng 1 lần tại \"Cánh Cửa Hư Vô\""
  },
  Task_71370_Desc = {
    Text = "Hoàn thành \"Nhà búp bê\"độ khó điên cuồng"
  },
  Task_71373_Desc = {
    Text = "Hoàn thành \"ngôi sao\"ở bất kỳ mức độ khó nào"
  },
  Task_71374_Desc = {
    Text = "Sử dụng thân thể được đánh thức của vùng giới biển sâu để chiến thắng 2 lần trong \"Cánh Cửa Hư Vô\""
  },
  Task_71375_Desc = {
    Text = "Sử dụng thân thể được đánh thức của vùng giới sâu thẳm để chiến thắng 1 lần trong \"Hư Vô\""
  },
  Task_71376_Desc = {
    Text = "Hoàn thành \"Dạ hội Cuồng hoan\" bất kỳ độ khó nào"
  },
  Task_71377_Desc = {
    Text = "Hoàn thành \"Nhà búp bê\"ở mọi độ khó"
  },
  Task_71378_Desc = {
    Text = "Hoàn thành \"ngôi sao\"ở bất kỳ mức độ khó nào"
  },
  Task_71379_Desc = {
    Text = "Hoàn thành \"lời mời\" bất kỳ độ khó nào"
  },
  Task_71380_Desc = {
    Text = "Hoàn thành \"hỗn loạn dự ngôn\" độ khó điên cuồng"
  },
  Task_71381_Desc = {
    Text = "Hoàn thành \"Điệu nhảy Cuồng hoan\"độ khó điên loạn"
  },
  Task_71382_Desc = {
    Text = "Hoàn thành \"Thuốc độc thực sự\"ở bất kỳ độ khó nào"
  },
  Task_71385_Desc = {
    Text = "Hoàn thành \"lời mời\" bất kỳ độ khó nào"
  },
  Task_71757_Desc = {
    Text = "Hoàn thành \"Giả Diện Hài Kịch\"độ khó điên cuồng"
  },
  Task_71758_Desc = {
    Text = "Hoàn thành \"tình tiết xoay vòng\" bất kỳ độ khó nào"
  },
  Task_71759_Desc = {
    Text = "Hoàn thành \"Thời khắc tĩnh lặng\"độ khó điên cuồng"
  },
  Task_71760_Desc = {
    Text = "Hoàn thành \"thời khắc yên lặng\"ở bất kỳ độ khó nào"
  },
  Task_71761_Desc = {
    Text = "Hoàn thành \"catharsis\"độ khó điên cuồng"
  },
  Task_71762_Desc = {
    Text = "Hoàn thành \"lý thuyết tia điện\"ở bất kỳ độ khó nào"
  },
  Task_71763_Desc = {
    Text = "Hoàn thành \"luân hồi cốt truyện\"độ khó điên cuồng"
  },
  Task_71764_Desc = {
    Text = "Hoàn thành \"hiệu ứng xa lạ\"ở độ khó điên cuồng"
  },
  Task_71765_Desc = {
    Text = "Hoàn thành \"Ba Nguyên Tắc\"độ khó điên cuồng"
  },
  Task_71766_Desc = {
    Text = "Hoàn thành \"Ba nguyên tắc\"ở bất kỳ mức độ khó nào"
  },
  Task_71767_Desc = {
    Text = "Hoàn thành \"catharsis\"ở bất kỳ độ khó nào"
  },
  Task_71768_Desc = {
    Text = "Hoàn thành \"Kịch Trò Mặt Nạ\"ở bất kỳ độ khó nào"
  },
  Task_71769_Desc = {
    Text = "Hoàn thành \"Bức Tường Thứ Tư Trong Kịch Nghệ\"độ khó điên cuồng"
  },
  Task_71770_Desc = {
    Text = "Hoàn thành \"tường thứ tư trong kịch nghệ\"ở bất kỳ độ khó nào"
  },
  Task_71771_Desc = {
    Text = "Hoàn thành \"Hiệu ứng Lạ Hóa\" bất kỳ độ khó nào"
  },
  Task_71772_Desc = {
    Text = "Hoàn thành \"lý thuyết ánh sáng cong(Lý thuyết Hồng Quang)\"độ khó điên cuồng"
  },
  Task_71773_Desc = {
    Text = "Hoàn thành \"Kim Tự Tháp Sáng Tác\"độ khó điên cuồng"
  },
  Task_71774_Desc = {
    Text = "Hoàn thành \"Kim Tự Tháp Kịch Bản\"ở mọi cấp độ"
  },
  Task_71775_Desc = {
    Text = "Bí ẩn kịch bản điên cuồng"
  },
  Task_71795_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_71795_Name = {
    Text = "2800 điểm số"
  },
  Task_71796_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_71796_Name = {
    Text = "2700 điểm"
  },
  Task_71797_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_71797_Name = {
    Text = "2900 điểm tích lũy"
  },
  Task_71798_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_71798_Name = {
    Text = "2600 điểm"
  },
  Task_71799_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_71799_Name = {
    Text = "2300 điểm"
  },
  Task_71800_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_71800_Name = {
    Text = "2400 điểm"
  },
  Task_71801_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_71801_Name = {
    Text = "2500 điểm"
  },
  Task_71802_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_71802_Name = {
    Text = "1900 điểm số"
  },
  Task_71803_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_71803_Name = {
    Text = "2000 điểm"
  },
  Task_71804_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_71804_Name = {
    Text = "2100 điểm"
  },
  Task_71805_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_71805_Name = {
    Text = "2200 điểm"
  },
  Task_71806_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_71806_Name = {
    Text = "3000 điểm số"
  },
  Task_71807_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_71807_Name = {
    Text = "1600 điểm"
  },
  Task_71808_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_71808_Name = {
    Text = "1700 điểm"
  },
  Task_71809_Desc = {
    Text = "Điểm đấu cờ cao nhất đạt được"
  },
  Task_71809_Name = {
    Text = "1800 điểm"
  },
  Task_71819_Desc = {
    Text = "Hoàn thành \"Khúc cuối\"ở bất kỳ độ khó nào"
  },
  Task_71820_Desc = {
    Text = "Hoàn thành \"mặt\"ở bất kỳ mức độ khó nào"
  },
  Task_71821_Desc = {
    Text = "Hoàn thành \"Chú Hai Chân Dài\"ở bất kỳ độ khó nào"
  },
  Task_71822_Desc = {
    Text = "Hoàn thành \"ánh mắt\"ở bất kỳ độ khó nào"
  },
  Task_71823_Desc = {
    Text = "Hoàn thành \"trò chơi con rối\"ở mọi độ khó"
  },
  Task_71824_Desc = {
    Text = "Hoàn thành \"Kịch Bản Chưa Hoàn Thành\" bất kỳ độ khó nào"
  },
  Task_71825_Desc = {
    Text = "Hoàn thành \"Góc Hoa Hồng\"ở bất kỳ độ khó nào"
  },
  Task_71826_Desc = {
    Text = "Hoàn thành \"đáy nồi Du Ngư\"ở bất kỳ độ khó nào"
  },
  Task_71827_Desc = {
    Text = "Hoàn thành \"quà tặng\" mọi độ khó"
  },
  Task_71867_Desc = {
    Text = "Có 5/6/7/8 vật phẩm, nhận được 250/500/750/1000 điểm."
  },
  Task_71867_Name = {
    Text = "Tìm Kiếm Thực Tướng<size=20><color=#747474>có 8 sáng tạo</color></size>"
  },
  Task_71868_Desc = {
    Text = "Mỗi lần sử dụng 1 lần Ký ức Cơ bắp, điểm đánh giá điều tra giảm 20%."
  },
  Task_71868_Name = {
    Text = "Người đi trong giấc mơ<size=20><color=#747474>Mỗi khi sử dụng trí nhớ cơ bắp, điểm đánh giá điều tra sẽ giảm đi 20% </color></size>"
  },
  Task_71934_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_71935_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_71936_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_71937_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_71939_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_71940_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_71941_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_71942_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_71943_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_71944_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_71945_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_71946_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_71947_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_71948_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_71949_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_71950_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_71952_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_71953_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_71954_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_71955_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_71977_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_71978_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_71980_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_71981_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_72038_Name = {
    Text = "Hoàn thành lại phụ bản tulô thường 4"
  },
  Task_72039_Desc = {
    Text = "Hoàn thành \"Ánh nhìn\"ở độ khó điên cuồng"
  },
  Task_72040_Desc = {
    Text = "Hoàn thành \"Cá Bơi Dưới Đáy Nồi\"độ khó điên loạn"
  },
  Task_72041_Desc = {
    Text = "Hoàn thành \"trò chơi ma quái của những con rối\"độ khó điên cuồng"
  },
  Task_72042_Desc = {
    Text = "Hoàn thành \"quà\"độ khó điên cuồng"
  },
  Task_72043_Desc = {
    Text = "Hoàn thành đặc vụ ghi chép \"Hoa Hồng Ký Ức\""
  },
  Task_72044_Desc = {
    Text = "Hoàn thành \"Chú Bé Chân Dài\"ở độ khó điên cuồng"
  },
  Task_72045_Desc = {
    Text = "Hoàn thành \"Kịch bản chưa hoàn thành\"ở độ khó điên cuồng"
  },
  Task_72046_Desc = {
    Text = "Hoàn thành \"góc hồng phấn\"(Góc Hoa Hồng) độ khó điên cuồng"
  },
  Task_72047_Desc = {
    Text = "Hoàn thành \"khuôn mặt\"độ khó điên cuồng"
  },
  Task_72048_Desc = {
    Text = "Hoàn thành \"Chung Khúc\"độ khó điên cuồng"
  },
  Task_72049_Desc = {
    Text = "Hoa hồng hồi ức · điên cuồng"
  },
  Task_72245_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72245_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_72386_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72386_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_72387_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72387_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_72389_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72389_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_72390_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72390_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_72391_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72391_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_72392_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72392_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_72393_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72393_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_72394_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72394_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_72395_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72395_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_72396_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72396_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_72416_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72416_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_72420_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72420_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_72540_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72540_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_72541_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72541_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_72542_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72542_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_72545_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72545_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_72546_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72546_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_72547_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72547_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_72548_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72548_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_72549_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72549_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_72632_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72632_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_72652_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72652_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Khách từ thế giới khác\" sẽ mở khóa, bạn có muốn đi đến \"Đảo ngược lượt\" không?"
  },
  Task_72677_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72677_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Khách từ thế giới khác\" sẽ mở khóa, bạn có muốn đi đến \"Đảo ngược lượt\" không?"
  },
  Task_72678_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72678_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Khách từ thế giới khác\" sẽ mở khóa, bạn có muốn đi đến \"Đảo ngược lượt\" không?"
  },
  Task_72679_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72679_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Khách từ thế giới khác\" sẽ mở khóa, bạn có muốn đi đến \"Đảo ngược lượt\" không?"
  },
  Task_72681_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72681_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Khách từ thế giới khác\" sẽ mở khóa, bạn có muốn đi đến \"Đảo ngược lượt\" không?"
  },
  Task_72682_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72682_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Khách từ thế giới khác\" sẽ mở khóa, bạn có muốn đi đến \"Đảo ngược lượt\" không?"
  },
  Task_72683_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72683_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Khách từ thế giới khác\" sẽ mở khóa, bạn có muốn đi đến \"Đảo ngược lượt\" không?"
  },
  Task_72684_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72684_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Khách từ thế giới khác\" sẽ mở khóa, bạn có muốn đi đến \"Đảo ngược lượt\" không?"
  },
  Task_72685_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72685_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Khách từ thế giới khác\" sẽ mở khóa, bạn có muốn đi đến \"Đảo ngược lượt\" không?"
  },
  Task_72700_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72700_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_72701_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72701_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_72703_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72703_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_72704_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72704_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_72705_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72705_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_72706_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72706_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_72707_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72707_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_72709_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72709_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_72773_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72773_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_72790_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72790_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_72798_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72798_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_72799_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72799_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_72800_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72800_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_72801_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72801_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_72802_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72802_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_72803_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72803_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_72805_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72805_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_72806_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72806_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_72807_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_72807_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_72957_Desc = {
    Text = "Sử dụng \"vượt qua nỗi đau\"để giành 3 chiến thắng"
  },
  Task_72958_Desc = {
    Text = "Sử dụng \"Hồi Phệ Dị Thể\"đạt được 1 lần chiến thắng"
  },
  Task_72959_Desc = {
    Text = "Sử dụng \"lõi tan chảy\"đạt được 3 lần chiến thắng"
  },
  Task_72961_Desc = {
    Text = "Sử dụng \"35mm phép thuật\"để giành được 1 chiến thắng"
  },
  Task_72963_Desc = {
    Text = "Sử dụng \"Quyền trượng của Nữ hoàng\"để giành được 3 chiến thắng"
  },
  Task_72965_Desc = {
    Text = "Sử dụng \"trăm vạn con mắt của thú cưng\" giành được một chiến thắng"
  },
  Task_72968_Desc = {
    Text = "Sử dụng \"nổi lên\"để giành được 1 chiến thắng"
  },
  Task_72973_Desc = {
    Text = "Sử dụng \"Lily\"để giành được 1 chiến thắng"
  },
  Task_72975_Desc = {
    Text = "Sử dụng \"Gầm Gừ của Máu và Cát\"để đạt được 3 chiến thắng"
  },
  Task_72976_Desc = {
    Text = "Sử dụng \"bộ sưu tập quý giá nhất\"để giành chiến thắng 3 lần"
  },
  Task_72977_Desc = {
    Text = "Sử dụng \"Bánh Xe Ẩn Thế\" thắng 3 lần"
  },
  Task_72978_Desc = {
    Text = "Sử dụng \"Thông tin chính là sự sống\"để giành được 3 chiến thắng"
  },
  Task_72980_Desc = {
    Text = "Sử dụng \"Liz\"để giành được 1 chiến thắng"
  },
  Task_72982_Desc = {
    Text = "Sử dụng \"vượt qua cái chết\"để giành được 3 chiến thắng"
  },
  Task_72983_Desc = {
    Text = "Sử dụng \"hồ nước quay đầu\"đạt được 1 lần chiến thắng"
  },
  Task_72986_Desc = {
    Text = "Sử dụng \"Blade of Giants\"để giành được 1 chiến thắng"
  },
  Task_72989_Desc = {
    Text = "Sử dụng \"Orci\"đạt được 3 chiến thắng"
  },
  Task_72990_Desc = {
    Text = "Sử dụng \"Bài hát ru tiêu thụ\"để giành được 1 chiến thắng"
  },
  Task_72992_Desc = {
    Text = "Sử dụng \"Điểm tới hạn\"để giành được 1 chiến thắng"
  },
  Task_72993_Desc = {
    Text = "Sử dụng \"tới người bạn thân\"để giành được 1 chiến thắng"
  },
  Task_72994_Desc = {
    Text = "Sử dụng \"sự vĩnh cửu ngắn ngủi\"để thắng 1 lần"
  },
  Task_72995_Desc = {
    Text = "Sử dụng \"Cái chết của người phụ nữ san hô\"để đạt được 1 chiến thắng"
  },
  Task_72997_Desc = {
    Text = "Sử dụng \"Ô Ryta\"để giành 3 chiến thắng"
  },
  Task_72999_Desc = {
    Text = "Sử dụng \"Chiến thắng của hoa hồng\"để giành được 3 lần chiến thắng"
  },
  Task_73001_Desc = {
    Text = "Sử dụng \"sủng ái\" giành được một chiến thắng"
  },
  Task_73003_Desc = {
    Text = "Sử dụng \"Ánh mắt của Isarau\"để giành được 3 chiến thắng"
  },
  Task_73004_Desc = {
    Text = "Sử dụng \"gậy của bá tước\"để đạt được 1 chiến thắng"
  },
  Task_73006_Desc = {
    Text = "Sử dụng \"thời gian may mắn\"để giành được 3 chiến thắng"
  },
  Task_73007_Desc = {
    Text = "Sử dụng \"Agrippa\"để đạt được 3 chiến thắng"
  },
  Task_73009_Desc = {
    Text = "Sử dụng \"khi tuyết sơn tan\"để đạt được 1 chiến thắng"
  },
  Task_73011_Desc = {
    Text = "Sử dụng \"tường thành của trái tim\"đạt được 1 chiến thắng"
  },
  Task_73012_Desc = {
    Text = "Sử dụng \"Miriam\"để đạt được 3 chiến thắng"
  },
  Task_73014_Desc = {
    Text = "Dùng \"Hamlin\" giành 1 chiến thắng"
  },
  Task_73015_Desc = {
    Text = "Sử dụng \"Giấc mơ Biển\"để giành được 3 chiến thắng"
  },
  Task_73016_Desc = {
    Text = "Sử dụng \"Điên Loạn\"để đạt được 1 lần chiến thắng"
  },
  Task_73018_Desc = {
    Text = "Sử dụng \"Sự kiện Ma thuật Vui vẻ\"để giành được 1 chiến thắng"
  },
  Task_73019_Desc = {
    Text = "Sử dụng \"chín muồi\"để giành được 1 lần chiến thắng"
  },
  Task_73021_Desc = {
    Text = "Sử dụng \"lòng nhiệt huyết của bạc nguyên chất\"để giành được 1 chiến thắng"
  },
  Task_73022_Desc = {
    Text = "Sử dụng \"đóa\"để giành được 1 chiến thắng"
  },
  Task_73025_Desc = {
    Text = "Sử dụng \"Nhẩm\"để giành được 1 chiến thắng"
  },
  Task_73026_Desc = {
    Text = "Sử dụng \"hoạt tính\"để giành được 1 chiến thắng"
  },
  Task_73028_Desc = {
    Text = "Sử dụng \"Đào Đen Đá\"đạt được 1 chiến thắng"
  },
  Task_73030_Desc = {
    Text = "Sử dụng \"Wenkel\"để giành được 3 chiến thắng"
  },
  Task_73033_Desc = {
    Text = "Sử dụng \"chìm vào màu đỏ thẫm\"để giành 1 chiến thắng"
  },
  Task_73037_Desc = {
    Text = "Sử dụng \"ngày thoát khỏi xiềng xích\"để giành được 3 chiến thắng"
  },
  Task_73039_Desc = {
    Text = "Dùng \"Đêm đông hồi ức\"để đạt được 1 chiến thắng"
  },
  Task_73041_Desc = {
    Text = "Sử dụng \"Sự ra đời bí mật\"để giành được 1 chiến thắng"
  },
  Task_73044_Desc = {
    Text = "Sử dụng \"Lắc\"để đạt được 3 chiến thắng"
  },
  Task_73045_Desc = {
    Text = "Sử dụng \"Dung hủy·đóa\" thắng 1 lần"
  },
  Task_73047_Desc = {
    Text = "Sử dụng \"Phiệt\" và giành 1 chiến thắng"
  },
  Task_73048_Desc = {
    Text = "Sử dụng \"Thái Di Sơ\" và giành 3 chiến thắng"
  },
  Task_73050_Desc = {
    Text = "Sử dụng \"Ai Jī Sī\" giành được 3 lần chiến thắng"
  },
  Task_73051_Desc = {
    Text = "Sử dụng \"Ô Ryta\"đạt được 1 chiến thắng"
  },
  Task_73052_Desc = {
    Text = "Thông qua việc sử dụng \"sơn\", giành được một chiến thắng"
  },
  Task_73053_Desc = {
    Text = "Sử dụng \"Muphí\"để giành được 1 chiến thắng"
  },
  Task_73054_Desc = {
    Text = "Sử dụng \"Tà Vy\" thắng 3 lần"
  },
  Task_73055_Desc = {
    Text = "Sử dụng \"đóa\"đạt được 3 chiến thắng"
  },
  Task_73056_Desc = {
    Text = "Sử dụng \"Salvador\"để đạt được 1 chiến thắng"
  },
  Task_73057_Desc = {
    Text = "Sử dụng \"hạt giống duy nhất\"để giành được 3 chiến thắng"
  },
  Task_73059_Desc = {
    Text = "Sử dụng \"quyết tâm của cá tuyết bạc\"để giành 3 lần chiến thắng"
  },
  Task_73061_Desc = {
    Text = "Sử dụng \"cắt và thương tổn\"để giành được 3 chiến thắng"
  },
  Task_73063_Desc = {
    Text = "Sử dụng \"Nuôi dưỡng từ ái\"đạt được 1 lần chiến thắng"
  },
  Task_73064_Desc = {
    Text = "Sử dụng \"trừng phạt\"đạt được 3 lần chiến thắng"
  },
  Task_73066_Desc = {
    Text = "Sử dụng \"bánh xe số phận\" và giành được 3 chiến thắng"
  },
  Task_73067_Desc = {
    Text = "Sử dụng \"Pandia\" giành được một chiến thắng"
  },
  Task_73068_Desc = {
    Text = "Sử dụng \"toàn bộ cô ấy\"để giành được 1 chiến thắng"
  },
  Task_73070_Desc = {
    Text = "Sử dụng \"Ngạo nghễ của Người Khổng Lồ\"đạt được 3 lần chiến thắng"
  },
  Task_73073_Desc = {
    Text = "Sử dụng \"Ramona\" đạt được 3 chiến thắng"
  },
  Task_73074_Desc = {
    Text = "Dùng \"câu cuối thi thư\" thắng 1 lần"
  },
  Task_73075_Desc = {
    Text = "Sử dụng \"Hậu Duệ Nhợt Nhạt\" thắng 3 lần"
  },
  Task_73077_Desc = {
    Text = "Sử dụng \"Vanda\" giành được một chiến thắng"
  },
  Task_73081_Desc = {
    Text = "Sử dụng \"sức mạnh thành tâm\" thắng 1 lần"
  },
  Task_73082_Desc = {
    Text = "Sử dụng \"Trục xoắn ký ức\"để đạt được 1 chiến thắng"
  },
  Task_73083_Desc = {
    Text = "Sử dụng \"Đồng hồ ngược dòng thời gian\"để đạt được 3 chiến thắng"
  },
  Task_73085_Desc = {
    Text = "Sử dụng \"Ôrla\"để giành được 1 chiến thắng"
  },
  Task_73086_Desc = {
    Text = "Sử dụng \"Thời khắc tụ hội\"để giành được 1 chiến thắng"
  },
  Task_73087_Desc = {
    Text = "Sử dụng \"vô thanh hoan yến\" thắng 3 lần"
  },
  Task_73088_Desc = {
    Text = "Sử dụng \"trong cơn mưa lớn\" thắng 1 lần"
  },
  Task_73089_Desc = {
    Text = "Sử dụng \"lơ-tan\"để giành được 1 chiến thắng"
  },
  Task_73090_Desc = {
    Text = "Sử dụng \"Tiệc máu thịt\" giành được 1 chiến thắng"
  },
  Task_73095_Desc = {
    Text = "Sử dụng \"GiaLân\"để giành được 1 chiến thắng"
  },
  Task_73097_Desc = {
    Text = "Sử dụng \"dục hải phù trầm\"đạt được 1 lần chiến thắng"
  },
  Task_73098_Desc = {
    Text = "Sử dụng \"Kasia\"để giành được 1 chiến thắng"
  },
  Task_73099_Desc = {
    Text = "Sử dụng \"Chiếu Mộng Trung Hạ\"đạt được 1 lần chiến thắng"
  },
  Task_73100_Desc = {
    Text = "Sử dụng \"Sorrel\", đạt được 3 trận thắng"
  },
  Task_73102_Desc = {
    Text = "Sử dụng \"Bài ca ngợi thần vương\"để giành được 1 chiến thắng"
  },
  Task_73105_Desc = {
    Text = "Sử dụng \"đổi chỗ không bình đẳng\"đạt được 3 lần chiến thắng"
  },
  Task_73107_Desc = {
    Text = "Sử dụng \"Trái tim Hiệp sĩ\"đạt được 1 chiến thắng"
  },
  Task_73109_Desc = {
    Text = "Sử dụng \"Khổ Chú Phong\"để giành được 3 lần chiến thắng"
  },
  Task_73110_Desc = {
    Text = "Sử dụng \"Salvador\"để đạt được 3 chiến thắng"
  },
  Task_73111_Desc = {
    Text = "Sử dụng \"Quái thú Thiên hà\"đạt được 3 chiến thắng"
  },
  Task_73117_Desc = {
    Text = "Sử dụng \"Ôm ấp gặm nhấm\"để giành được 1 chiến thắng"
  },
  Task_73118_Desc = {
    Text = "Sử dụng \"Báu vật của Ô Ryta\"để giành được 1 chiến thắng"
  },
  Task_73120_Desc = {
    Text = "Sử dụng \"Tale of the Voracious Beast\" thắng 1 lần"
  },
  Task_73122_Desc = {
    Text = "Sử dụng \"Vòng tròn · Ramona\"để giành 3 chiến thắng"
  },
  Task_73123_Desc = {
    Text = "Sử dụng \"lời thề cuối cùng\"để giành được 1 chiến thắng"
  },
  Task_73124_Desc = {
    Text = "Sử dụng \"phóng trục\" giành được 3 chiến thắng"
  },
  Task_73126_Desc = {
    Text = "Sử dụng \"ân huệ\"để giành được 1 lần chiến thắng"
  },
  Task_73128_Desc = {
    Text = "Sử dụng \"tham lam\"để giành được 3 chiến thắng"
  },
  Task_73129_Desc = {
    Text = "Sử dụng \"Kẻ khắc sét\"để giành được 1 chiến thắng"
  },
  Task_73130_Desc = {
    Text = "Sử dụng \"Cánh cửa Sự thật\"để giành được 3 chiến thắng"
  },
  Task_73131_Desc = {
    Text = "Sử dụng \"Với danh nghĩa hoa hồng\"để giành chiến thắng"
  },
  Task_73134_Desc = {
    Text = "Sử dụng \"Erika\"để đạt được 3 chiến thắng"
  },
  Task_73136_Desc = {
    Text = "Sử dụng \"Phân tích cái chết\"để giành được 3 chiến thắng"
  },
  Task_73138_Desc = {
    Text = "Sử dụng \"tinkerer\"để giành được 3 chiến thắng"
  },
  Task_73139_Desc = {
    Text = "Sử dụng \"sự vĩnh cửu ngắn ngủi\"để giành được 3 chiến thắng"
  },
  Task_73140_Desc = {
    Text = "Sử dụng \"nhiệm vụ của mình\"để đạt được 3 chiến thắng"
  },
  Task_73141_Desc = {
    Text = "Sử dụng \"minh ngộ\"để giành được 1 lần chiến thắng"
  },
  Task_73144_Desc = {
    Text = "Sử dụng \"Giants' Blade\"để đạt được 3 chiến thắng"
  },
  Task_73147_Desc = {
    Text = "Sử dụng \"Biểu diễn không ngừng nghỉ\"đạt được 3 lần chiến thắng"
  },
  Task_73148_Desc = {
    Text = "Sử dụng \"Giấc ngủ dưới băng\"để đạt được 3 chiến thắng"
  },
  Task_73150_Desc = {
    Text = "Sử dụng \"Lily\"đạt được 3 lần chiến thắng"
  },
  Task_73151_Desc = {
    Text = "Sử dụng \"Chiến thắng của hoa hồng\"để giành được 1 chiến thắng"
  },
  Task_73152_Desc = {
    Text = "Sử dụng \"khuôn mặt thật của sương xám\" thắng 3 lần"
  },
  Task_73153_Desc = {
    Text = "Sử dụng \"tulô\"để đạt được 1 chiến thắng"
  },
  Task_73154_Desc = {
    Text = "Sử dụng \"kỳ vọng\"để giành được 1 lần chiến thắng"
  },
  Task_73156_Desc = {
    Text = "Sử dụng \"Reia\"để giành được 3 chiến thắng"
  },
  Task_73157_Desc = {
    Text = "Sử dụng \"yêu thương\"để giành được 3 lần chiến thắng"
  },
  Task_73161_Desc = {
    Text = "Sử dụng \"Ninh Phi Nga\" giành được 3 chiến thắng"
  },
  Task_73162_Desc = {
    Text = "Sử dụng \"Cuồng Loạn\"để giành 3 chiến thắng"
  },
  Task_73165_Desc = {
    Text = "Sử dụng \"nơi không tồn tại\"để giành được 1 chiến thắng"
  },
  Task_73166_Desc = {
    Text = "Sử dụng \"Pháp Luân Tư\"để thắng 3 lần"
  },
  Task_73167_Desc = {
    Text = "Sử dụng \"Hiro\" giành được 1 chiến thắng"
  },
  Task_73170_Desc = {
    Text = "Sử dụng \"tulô\"để thắng 3 lần"
  },
  Task_73172_Desc = {
    Text = "Sử dụng \"hút\"để giành được 3 chiến thắng"
  },
  Task_73173_Desc = {
    Text = "Sử dụng \"Dẫn Lái Chi Phàm\"đạt được 1 lần chiến thắng"
  },
  Task_73174_Desc = {
    Text = "Sử dụng \"Thời khắc tụ hội\"đạt được 3 chiến thắng"
  },
  Task_73176_Desc = {
    Text = "Sử dụng \"Hilaster\" và giành được 1 chiến thắng"
  },
  Task_73177_Desc = {
    Text = "Sử dụng \"sơn\"để giành được 3 trận thắng"
  },
  Task_73178_Desc = {
    Text = "Sử dụng \"Động tất\"để giành được 1 chiến thắng"
  },
  Task_73180_Desc = {
    Text = "Sử dụng \"Bản giao hưởng vĩnh cửu\"để giành được 3 chiến thắng"
  },
  Task_73181_Desc = {
    Text = "Sử dụng \"không thể hoàn thành phép tính\" thắng 3 lần"
  },
  Task_73182_Desc = {
    Text = "Sử dụng \"Agrippa\"để giành được 1 chiến thắng"
  },
  Task_73183_Desc = {
    Text = "Sử dụng \"Bài hát bị trói buộc\"để đạt được 3 chiến thắng"
  },
  Task_73185_Desc = {
    Text = "Hoàn thành 3 chiến thắng bằng cách sử dụng \"Đêm tối và Bình minh\""
  },
  Task_73186_Desc = {
    Text = "Sử dụng \"tinh thần chuyên chú\"đạt được 1 lần chiến thắng"
  },
  Task_73189_Desc = {
    Text = "Sử dụng \"búp bê rơi vào hư vô\" giành được 3 lần chiến thắng"
  },
  Task_73192_Desc = {
    Text = "Sử dụng \"Ẩn mình trong màn đêm\"để giành được 1 lần chiến thắng"
  },
  Task_73193_Desc = {
    Text = "Sử dụng \"hội chứng ký ức\"để giành được 1 chiến thắng"
  },
  Task_73197_Desc = {
    Text = "Sử dụng \"tay quên lãng\"để đạt được 3 chiến thắng"
  },
  Task_73200_Desc = {
    Text = "Sử dụng \"balo phiêu lưu\" nhận được 1 lần chiến thắng"
  },
  Task_73204_Desc = {
    Text = "Sử dụng \"Máu Liên · Shiro\"đạt được 3 lần chiến thắng"
  },
  Task_73206_Desc = {
    Text = "Sử dụng \"Bài hát ru tiêu thụ\"để đạt được 3 chiến thắng"
  },
  Task_73208_Desc = {
    Text = "Sử dụng \"Nóng chảy · đóa\"đạt được 3 chiến thắng"
  },
  Task_73209_Desc = {
    Text = "Sử dụng \"Cái chết của người phụ nữ san hô\" và đạt được 3 lần thắng"
  },
  Task_73210_Desc = {
    Text = "Sử dụng \"Orci\"đạt được 1 lần chiến thắng"
  },
  Task_73212_Desc = {
    Text = "Sử dụng \"lòng từ bi\"đạt được 3 lần chiến thắng"
  },
  Task_73213_Desc = {
    Text = "Sử dụng \"điểm tới hạn\"để giành chiến thắng 3 lần"
  },
  Task_73214_Desc = {
    Text = "Sử dụng \"gửi người bạn thân\"để đạt được 3 lần chiến thắng"
  },
  Task_73216_Desc = {
    Text = "Sử dụng \"chìm vào màu son\"để giành được 3 chiến thắng"
  },
  Task_73217_Desc = {
    Text = "Sử dụng \"Cắt và sát thương\"để giành được 1 chiến thắng"
  },
  Task_73218_Desc = {
    Text = "Sử dụng \"Hồn Sương Xám\"để giành được 1 chiến thắng"
  },
  Task_73219_Desc = {
    Text = "Sử dụng \"âm thanh trong đầu\"để giành được 3 chiến thắng"
  },
  Task_73220_Desc = {
    Text = "Sử dụng \"gậy của bá tước\"để giành được 3 chiến thắng"
  },
  Task_73222_Desc = {
    Text = "Sử dụng \"Tay Quên\"để giành được 1 chiến thắng"
  },
  Task_73223_Desc = {
    Text = "Sử dụng \"Jenkin\"để đạt được 3 chiến thắng"
  },
  Task_73224_Desc = {
    Text = "Sử dụng \"Miriam\" thắng 1 lần"
  },
  Task_73225_Desc = {
    Text = "Sử dụng \"thời gian may mắn\"để giành 1 chiến thắng"
  },
  Task_73227_Desc = {
    Text = "Sử dụng \"Đường đi lạc\"để giành được 1 chiến thắng"
  },
  Task_73228_Desc = {
    Text = "Sử dụng \"Elva\"đạt được 1 chiến thắng"
  },
  Task_73229_Desc = {
    Text = "Sử dụng \"bảng đá thần ngôn\"để giành được 1 chiến thắng"
  },
  Task_73232_Desc = {
    Text = "Sử dụng \"nổi lên\"để giành được 3 chiến thắng"
  },
  Task_73233_Desc = {
    Text = "Sử dụng \"Yu U Hahi\"để đạt được 3 chiến thắng"
  },
  Task_73235_Desc = {
    Text = "Sử dụng \"35mm phép thuật\"để đạt 3 chiến thắng"
  },
  Task_73236_Desc = {
    Text = "Sử dụng \"Quà tặng thối rữa\"để giành được 1 chiến thắng"
  },
  Task_73237_Desc = {
    Text = "Sử dụng \"tham lam\"để giành chiến thắng 1 lần"
  },
  Task_73241_Desc = {
    Text = "Sử dụng \"nơi không tồn tại\"đạt được 3 chiến thắng"
  },
  Task_73243_Desc = {
    Text = "Sử dụng \"Liz\"đạt được 3 lần chiến thắng"
  },
  Task_73246_Desc = {
    Text = "Sử dụng \"Chakra Ẩn Thế\"để giành chiến thắng"
  },
  Task_73249_Desc = {
    Text = "Sử dụng \"tiếng nói trong tâm trí\"để giành được 1 chiến thắng"
  },
  Task_73250_Desc = {
    Text = "Sử dụng \"24\"để giành được 1 chiến thắng"
  },
  Task_73253_Desc = {
    Text = "Sử dụng \"sự kiên cường\" giành được 3 chiến thắng"
  },
  Task_73254_Desc = {
    Text = "Sử dụng \"dị thể hồi thực\"đạt được 3 lần chiến thắng"
  },
  Task_73257_Desc = {
    Text = "Sử dụng \"Thái Di Sơ\"đạt được 1 lần chiến thắng"
  },
  Task_73259_Desc = {
    Text = "Dùng \"Phiệt\"đạt được 3 lần chiến thắng"
  },
  Task_73260_Desc = {
    Text = "Sử dụng \"Tà Vy\" giành được 1 trận thắng"
  },
  Task_73262_Desc = {
    Text = "Sử dụng \"Ai Jī Sī\"để giành được 1 chiến thắng"
  },
  Task_73266_Desc = {
    Text = "Sử dụng \"quyết tâm của cá tuyết bạc\" và đạt được 1 chiến thắng"
  },
  Task_73267_Desc = {
    Text = "Sử dụng \"lơ-tan\" thắng 3 lần"
  },
  Task_73268_Desc = {
    Text = "Sử dụng \"hạt giống duy nhất\"để giành 1 chiến thắng"
  },
  Task_73269_Desc = {
    Text = "Sử dụng \"Chế tài\"để giành 1 chiến thắng"
  },
  Task_73270_Desc = {
    Text = "Sử dụng \"vây đau đớn\"đạt được 1 lần chiến thắng"
  },
  Task_73271_Desc = {
    Text = "Sử dụng \"Giấc mơ giữa mùa hè\"đạt được 3 trận thắng"
  },
  Task_73278_Desc = {
    Text = "Sử dụng \"Bá đạo của khổng lồ\"để có 1 chiến thắng"
  },
  Task_73279_Desc = {
    Text = "Dùng \"Erika\"để giành được 1 chiến thắng"
  },
  Task_73280_Desc = {
    Text = "Dùng \"phóng trục\"để giành lấy 1 chiến thắng"
  },
  Task_73281_Desc = {
    Text = "Sử dụng \"Biển Mộng\"đạt được 1 chiến thắng"
  },
  Task_73282_Desc = {
    Text = "Sử dụng \"đợi đến khi tuyết sơn tan\"đạt được 3 chiến thắng"
  },
  Task_73284_Desc = {
    Text = "Sử dụng \"bánh xe số phận\"để giành được 1 chiến thắng"
  },
  Task_73285_Desc = {
    Text = "Sử dụng \"Cánh cửa Sự thật\"để giành được 1 chiến thắng"
  },
  Task_73286_Desc = {
    Text = "Dùng \"Ramona\"đạt được 1 chiến thắng"
  },
  Task_73287_Desc = {
    Text = "Sử dụng \"Pandia\"đạt được 3 chiến thắng"
  },
  Task_73288_Desc = {
    Text = "Dùng \"tên hoa hồng\"để thắng 3 lần"
  },
  Task_73289_Desc = {
    Text = "Sử dụng \"tất cả những gì thuộc về cô ấy\"để giành được 3 chiến thắng"
  },
  Task_73290_Desc = {
    Text = "Dùng \"Vanda\"để thắng 3 trận"
  },
  Task_73292_Desc = {
    Text = "Sử dụng \"câu cuối thi thư\"để giành được 3 chiến thắng"
  },
  Task_73293_Desc = {
    Text = "Sử dụng \"Hậu duệ tái nhợt\"để giành được 1 chiến thắng"
  },
  Task_73294_Desc = {
    Text = "Sử dụng \"tinkerer\"để giành được 1 chiến thắng"
  },
  Task_73296_Desc = {
    Text = "Sử dụng \"Phân giải lõi\"để giành được 1 chiến thắng"
  },
  Task_73297_Desc = {
    Text = "Sử dụng \"diệu kỳ đến\"để giành được 1 chiến thắng"
  },
  Task_73298_Desc = {
    Text = "Sử dụng \"Tiếng Gầm của Máu và Cát\" giành được 1 chiến thắng"
  },
  Task_73299_Desc = {
    Text = "Sử dụng \"Jenkin\"để giành được 1 chiến thắng"
  },
  Task_73302_Desc = {
    Text = "Sử dụng \"lẩm bẩm\"để giành 3 lần chiến thắng"
  },
  Task_73303_Desc = {
    Text = "Sử dụng \"Luật của Nữ hoàng\"để đạt được 1 chiến thắng"
  },
  Task_73305_Desc = {
    Text = "Sử dụng \"thuần thục\"để giành được 3 chiến thắng"
  },
  Task_73306_Desc = {
    Text = "Sử dụng \"vượt qua đau đớn\"để giành được 1 chiến thắng"
  },
  Task_73309_Desc = {
    Text = "Sử dụng \"tiệc thầm lặng\" thắng 1 lần"
  },
  Task_73311_Desc = {
    Text = "Sử dụng \"đường đi lạc\"để đạt được 3 chiến thắng"
  },
  Task_73312_Desc = {
    Text = "Sử dụng \"Goliath\"để giành được 3 chiến thắng"
  },
  Task_73313_Desc = {
    Text = "Sử dụng \"Thực Dụ Ngôn\"đạt được 3 chiến thắng"
  },
  Task_73314_Desc = {
    Text = "Sử dụng \"Wenkel\"để giành được 1 chiến thắng"
  },
  Task_73315_Desc = {
    Text = "Sử dụng \"trăm vạn con mắt của thú cưng\"đạt được 3 lần chiến thắng"
  },
  Task_73316_Desc = {
    Text = "Sử dụng \"Đào Đen Đá\" nhận được 3 chiến thắng"
  },
  Task_73317_Desc = {
    Text = "Sử dụng \"Thông tin là nguồn sống\"để giành được 1 chiến thắng"
  },
  Task_73318_Desc = {
    Text = "Sử dụng \"Lắc\"để giành được 1 chiến thắng"
  },
  Task_73321_Desc = {
    Text = "Sử dụng \"Ôrla\"đạt được 3 chiến thắng"
  },
  Task_73322_Desc = {
    Text = "Sử dụng \"tập hợp quý giá nhất\"để giành được 1 chiến thắng"
  },
  Task_73323_Desc = {
    Text = "Sử dụng \"Nốtira\"để đạt được 3 chiến thắng"
  },
  Task_73324_Desc = {
    Text = "Sử dụng \"Hồi Thủ Hồ\"để giành được 3 lần chiến thắng"
  },
  Task_73325_Desc = {
    Text = "Sử dụng \"vượt qua cái chết\"để giành được 1 chiến thắng"
  },
  Task_73326_Desc = {
    Text = "Sử dụng \"Đêm đông hồi ức\" giành được 3 lần chiến thắng"
  },
  Task_73327_Desc = {
    Text = "Sử dụng \"hành trang phiêu lưu\"để đạt được 3 chiến thắng"
  },
  Task_73328_Desc = {
    Text = "Sử dụng \"Goliath\"để đạt được 1 chiến thắng"
  },
  Task_73330_Desc = {
    Text = "Sử dụng \"bùa nguyền khổ\" giành được 1 chiến thắng"
  },
  Task_73333_Desc = {
    Text = "Sử dụng \"phép tính không thể giải được\"để giành được 1 chiến thắng"
  },
  Task_73334_Desc = {
    Text = "Sử dụng \"Thú Thiên Sao\"để thắng 1 trận"
  },
  Task_73335_Desc = {
    Text = "Sử dụng \"Dấu hiệu thần thánh xuất hiện\" thắng 3 lần"
  },
  Task_73338_Desc = {
    Text = "Với sự giúp đỡ của \"búp bê rơi vào hư vô\"đạt được 1 lần chiến thắng"
  },
  Task_73341_Desc = {
    Text = "Sử dụng \"Muphí\"để giành được 3 chiến thắng"
  },
  Task_73343_Desc = {
    Text = "Sử dụng \"Đêm tối và Bình minh\" giành được 1 lần chiến thắng"
  },
  Task_73345_Desc = {
    Text = "Sử dụng \"Ánh mắt của Isarau\"để giành được 1 chiến thắng"
  },
  Task_73346_Desc = {
    Text = "Dùng \"tinh thần tập trung\"để thắng 3 lần"
  },
  Task_73349_Desc = {
    Text = "Sử dụng \"Ám ảnh ôm ấp\"để giành 3 chiến thắng"
  },
  Task_73352_Desc = {
    Text = "Sử dụng \"ẩn trong đêm tối\"đạt được 3 trận thắng"
  },
  Task_73353_Desc = {
    Text = "Sử dụng \"ân sủng\"để giành chiến thắng 3 lần"
  },
  Task_73354_Desc = {
    Text = "Dùng \"Nốtira\"đạt được 1 lần chiến thắng"
  },
  Task_73355_Desc = {
    Text = "Sử dụng \"Vòng tròn · Ramona\" giành được 1 chiến thắng"
  },
  Task_73356_Desc = {
    Text = "Sử dụng \"Kho báu của Ô Ryta\"để giành được 3 chiến thắng"
  },
  Task_73357_Desc = {
    Text = "Sử dụng \"lời thề cuối cùng\"để giành được 3 chiến thắng"
  },
  Task_73359_Desc = {
    Text = "Sử dụng \"Kẻkhắcsét\"đạt được 3 chiến thắng"
  },
  Task_73360_Desc = {
    Text = "Sử dụng \"Phân tích cái chết\"để giành được 1 chiến thắng"
  },
  Task_73362_Desc = {
    Text = "Sử dụng \"Buổi Biểu Diễn Ma Thuật Vui Nhộn\" thắng 3 lần"
  },
  Task_73363_Desc = {
    Text = "Sử dụng \"Ninh Phi Nga\" giành được 1 chiến thắng"
  },
  Task_73366_Desc = {
    Text = "Sử dụng \"Đồng hồ ngược dòng thời gian\"để giành được 1 chiến thắng"
  },
  Task_73369_Desc = {
    Text = "Sử dụng \"Delirium\"để đạt được 3 lần chiến thắng"
  },
  Task_73370_Desc = {
    Text = "Sử dụng \"Hamlin\"để giành được 3 chiến thắng"
  },
  Task_73372_Desc = {
    Text = "Sử dụng \"lòng nhiệt thành bạc nguyên chất\"đạt được 3 trận thắng"
  },
  Task_73374_Desc = {
    Text = "Sử dụng \"Gia Lân\" thắng 3 lần"
  },
  Task_73377_Desc = {
    Text = "Sử dụng \"đổi chỗ không công bằng\"để giành được 1 chiến thắng"
  },
  Task_73379_Desc = {
    Text = "Sử dụng \"Sorrel\"để thắng 1 lần"
  },
  Task_73380_Desc = {
    Text = "Sử dụng \"Kassia\"để đạt được 3 chiến thắng"
  },
  Task_73382_Desc = {
    Text = "Bằng cách sử dụng \"ngày thoát khỏi xiềng xích\"đạt được 1 chiến thắng"
  },
  Task_73387_Desc = {
    Text = "Sử dụng \"Sự ra đời bí ẩn\"để đạt được 3 lần chiến thắng"
  },
  Task_73388_Desc = {
    Text = "Sử dụng \"tường thành của trái tim\"để giành được 3 chiến thắng"
  },
  Task_73390_Desc = {
    Text = "Sử dụng \"vây đau đớn\"để đạt được 3 chiến thắng"
  },
  Task_73392_Desc = {
    Text = "Sử dụng \"Yu U Hahi\"đạt được 1 lần chiến thắng"
  },
  Task_73394_Desc = {
    Text = "Sử dụng \"sức mạnh thành tâm\"đạt được 3 chiến thắng"
  },
  Task_73395_Desc = {
    Text = "Sử dụng \"chuỗi máu · Hiro\" thắng 1 lần"
  },
  Task_73396_Desc = {
    Text = "Sử dụng \"bảng đá thần ngôn\"để đạt được 3 chiến thắng"
  },
  Task_73400_Desc = {
    Text = "Sử dụng \"Khúc ca Vĩnh cửu\"để giành 1 chiến thắng"
  },
  Task_73404_Desc = {
    Text = "Sử dụng \"người trong gương\"để đạt 1 chiến thắng"
  },
  Task_73405_Desc = {
    Text = "Sử dụng \"giữa cơn bão dữ\"đạt được 3 chiến thắng"
  },
  Task_73407_Desc = {
    Text = "Sử dụng \"quà tặng thối rữa\" nhận được 3 chiến thắng"
  },
  Task_73409_Desc = {
    Text = "Sử dụng \"Hilaster\" giành được 3 chiến thắng"
  },
  Task_73410_Desc = {
    Text = "Sử dụng \"Động Tích\"để giành được 3 lần chiến thắng"
  },
  Task_73413_Desc = {
    Text = "Sử dụng \"Bài hát bị trói buộc\"để giành được 1 chiến thắng"
  },
  Task_73417_Desc = {
    Text = "Sử dụng \"hội chứng ký ức\" và giành 3 lần chiến thắng"
  },
  Task_73418_Desc = {
    Text = "Sử dụng \"người trong gương\"để giành 3 chiến thắng"
  },
  Task_73422_Desc = {
    Text = "Sử dụng 24 để giành được 3 chiến thắng"
  },
  Task_73425_Desc = {
    Text = "Sử dụng \"sự kiên cường\"để giành được 1 chiến thắng"
  },
  Task_73426_Desc = {
    Text = "Sử dụng \"Elva\"đạt được 3 chiến thắng"
  },
  Task_73427_Desc = {
    Text = "Sử dụng \"điên cuồng\"để chiến thắng 1 lần"
  },
  Task_73430_Desc = {
    Text = "Sử dụng \"hoạt tính\"để đạt được 3 chiến thắng"
  },
  Task_73431_Desc = {
    Text = "Sử dụng \"Buổi biểu diễn không ngừng\"để đạt được 1 chiến thắng"
  },
  Task_73432_Desc = {
    Text = "Sử dụng \"trách nhiệm\"để đạt được 1 chiến thắng"
  },
  Task_73433_Desc = {
    Text = "Sử dụng \"Minh Ngộ\"đạt được 3 lần chiến thắng"
  },
  Task_73435_Desc = {
    Text = "Sử dụng \"ký ức xoắn ốc\"để giành chiến thắng 3 lần"
  },
  Task_73437_Desc = {
    Text = "Sử dụng \"Hy Kì\"đạt được 3 lần chiến thắng"
  },
  Task_73440_Desc = {
    Text = "Sử dụng \"Trầm miên dưới băng\"để giành được 1 chiến thắng"
  },
  Task_73442_Desc = {
    Text = "Sử dụng \"Tiệc máu thịt\" giành được 3 chiến thắng"
  },
  Task_73444_Desc = {
    Text = "Dùng \"dục hải phù trầm\"đạt được 3 chiến thắng"
  },
  Task_73445_Desc = {
    Text = "Sử dụng \"Reia\" thắng 1 lần"
  },
  Task_73451_Desc = {
    Text = "Sử dụng \"Shiro\"đạt được 3 chiến thắng"
  },
  Task_73453_Desc = {
    Text = "Sử dụng \"cánh buồm dẫn đường\"đạt được 3 chiến thắng"
  },
  Task_73456_Desc = {
    Text = "Sử dụng \"Pháp Luân Tư\"để giành được 1 chiến thắng"
  },
  Task_73457_Desc = {
    Text = "Sử dụng \"Trái tim hiệp sĩ\"để thắng 3 lần"
  },
  Task_73459_Desc = {
    Text = "Sử dụng \"Bài ca ngợi thần vương\"để giành được 3 chiến thắng"
  },
  Task_73462_Desc = {
    Text = "Sử dụng \"hút\"để giành được 1 chiến thắng"
  },
  Task_73584_Desc = {
    Text = "Đạt được tổng cộng 10 trận thắng trong mùa giải này"
  },
  Task_73584_Name = {Text = "10 thắng"},
  Task_73585_Desc = {
    Text = "Đạt được tích lũy 1 trận thắng trong mùa giải này"
  },
  Task_73585_Name = {
    Text = "1 trận thắng"
  },
  Task_73586_Desc = {
    Text = "Đạt được tổng cộng 6 trận thắng trong mùa giải này"
  },
  Task_73586_Name = {Text = "6 thắng"},
  Task_73587_Desc = {
    Text = "Đạt được 3 trận thắng trong mùa giải này"
  },
  Task_73587_Name = {
    Text = "3 trận thắng"
  },
  Task_73588_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_73588_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_73589_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_73589_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_73590_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_73590_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_73591_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_73591_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_73592_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_73592_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_73593_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_73593_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_73594_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_73594_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_73595_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_73595_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_73596_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_73596_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_73597_Desc = {
    Text = "Quả sồi phép đã đạt"
  },
  Task_73597_UnlockCondDesc = {
    Text = "Hoàn thành \"Đảo ngược lượt: Thời khắc vạn vật đảo chiều\" sau đó mở khóa. Bạn có muốn tham gia \"Đảo ngược lượt\" không?"
  },
  Task_73672_Desc = {
    Text = "Nhận được nguồn gốc đóa lúc ấy khởi linh 2"
  },
  Task_73672_Name = {
    Text = "Nhận được nguồn gốc đóa lúc ấy khởi linh 2"
  },
  Task_73672_UnlockCondDesc = {
    Text = "Hoạt động @ Thức tỉnh nguồn gốc đóa khởi linh quà tặng 1"
  },
  Task_73673_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_73674_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_73676_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_73677_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_73679_Desc = {
    Text = "Khi khởi linh 6, nhận nguồn gốc đóa"
  },
  Task_73679_Name = {
    Text = "Khi khởi linh 6, nhận nguồn gốc đóa"
  },
  Task_73679_UnlockCondDesc = {
    Text = "Sự kiện Gói quà Đóa khởi linh 2"
  },
  Task_73686_Desc = {
    Text = "Tan chảy·đóa tỷ lệ đồng điều đạt đến cấp 10"
  },
  Task_73880_Desc = {
    Text = "Theo dõi tan vỡ của đóa và xác nhận \"đáp án\""
  },
  Task_73880_Name = {
    Text = "Mục tiêu"
  },
  Task_73881_Desc = {
    Text = "Ép Sara đang bị dị hóa"
  },
  Task_73881_Name = {
    Text = "Mục tiêu"
  },
  Task_73882_Desc = {
    Text = "Đánh bại B-68 Melted·đóa"
  },
  Task_73882_Name = {
    Text = "Mục tiêu"
  },
  Task_73883_Desc = {
    Text = "Khám phá thế giới chiều không gian trước mắt"
  },
  Task_73883_Name = {
    Text = "Mục tiêu"
  },
  Task_73884_Desc = {
    Text = "Làm Jenkin yên lặng"
  },
  Task_73884_Name = {
    Text = "Mục tiêu"
  },
  Task_73885_Desc = {
    Text = "Trói Buộc Hủy Diệt · đóa"
  },
  Task_73885_Name = {
    Text = "Mục tiêu"
  },
  Task_73886_Desc = {
    Text = "Tháp Chuông Canh"
  },
  Task_73886_Name = {
    Text = "Mục tiêu"
  },
  Task_73887_Desc = {
    Text = "Dọn dẹp các dị thể trong hành lang trại tế bần"
  },
  Task_73887_Name = {
    Text = "Mục tiêu"
  },
  Task_73888_Desc = {
    Text = "Giải cứu Salvador từ tay Yu Li-ét và đưa về"
  },
  Task_73888_Name = {
    Text = "Mục tiêu"
  },
  Task_73889_Desc = {
    Text = "Mở đường đến đền thánh Cứu Thế"
  },
  Task_73889_Name = {
    Text = "Mục tiêu"
  },
  Task_74202_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_74203_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_74204_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_74205_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_74206_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_74207_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_74208_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_74210_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_74211_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_74212_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_74222_Desc = {
    Text = "Hoàn thành duy thức tiềm hành \"Ngày đăng quang\""
  },
  Task_74222_Name = {
    Text = "Vương quyền vĩnh cửu"
  },
  Task_74223_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"Trùng lâm sương đô\"ở mức độ khó khăn"
  },
  Task_74223_Name = {
    Text = "Đừng để mất phương hướng trong đêm xám·khó khăn"
  },
  Task_74224_Desc = {
    Text = "Trong sự kiện điều tra \"@1@2\" cảm ứng 10 lần"
  },
  Task_74224_Desc2 = {
    Text = "Điều tra sự kiện \"Trùng lâm sương đô\" và cảm ứng 10 lần"
  },
  Task_74224_Name2 = {
    Text = "Hư không vang vọng IV"
  },
  Task_74225_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"@1@2\""
  },
  Task_74225_Desc2 = {
    Text = "Hoàn thành sự kiện điều tra \"Trùng lâm sương đô\""
  },
  Task_74225_Name2 = {
    Text = "Đừng để lạc lối trong đêm u ám"
  },
  Task_74226_Desc = {
    Text = "Trong cuộc điều tra sự kiện \"@1@2\" cảm ứng 3 lần"
  },
  Task_74226_Desc2 = {
    Text = "Trong sự kiện \"Sương Đô Trùng Lâm\" cảm ứng 3 lần"
  },
  Task_74226_Name2 = {
    Text = "Vô thanh vô ảnh"
  },
  Task_74227_Desc = {
    Text = "Trong cuộc điều tra sự kiện \"@1@2\" gây cộng hưởng 6 lần"
  },
  Task_74227_Desc2 = {
    Text = "Trong sự kiện \"Trùng lâm sương đô\"đạt được 6 lần cảm ứng"
  },
  Task_74227_Name2 = {
    Text = "Hư Không Vang Lại II"
  },
  Task_74228_Desc = {
    Text = "Trong sự kiện điều tra \"@1@2\" cộng hưởng 8 lần"
  },
  Task_74228_Desc2 = {
    Text = "Trong sự kiện \"Trở lại thành phố sương mù\", đạt được 8 lần cảm ứng"
  },
  Task_74228_Name2 = {
    Text = "Không có hồi âm III"
  },
  Task_74235_Desc = {Text = "Tìm Liz"},
  Task_74235_Name = {
    Text = "Mục tiêu"
  },
  Task_74295_Desc = {
    Text = "Hoàn thành duy thức tiềm hành \"Nhiệt tình quy trần\""
  },
  Task_74295_Name = {
    Text = "Lửa xanh vũ điệu xoáy"
  },
  Task_74296_Desc = {
    Text = "Hoàn thành duy thức tiềm hành \"Nhiệt tình quy trần\" khó khăn"
  },
  Task_74296_Name = {
    Text = "Vũ Điệu Ngọn Lửa Xanh·khó khăn"
  },
  Task_74332_Name = {
    Text = "Hoạt động lượt đảo ngược kết thúc"
  },
  Task_74333_Desc = {
    Text = "Hoàn thành chương hai của cốt truyện vòng chơi nghịch đảo"
  },
  Task_74333_UnlockCondDesc = {
    Text = "Mở khóa sau khi nhận \"Phần thưởng kỳ diệu trong lượt: Điểm đạt 1200\""
  },
  Task_74334_Desc = {
    Text = "Hoàn thành cốt truyện vòng đầu tiên của chế độ đảo chiều"
  },
  Task_74335_Desc = {
    Text = "Hoàn thành chương ba của cốt truyện vòng nghịch đảo"
  },
  Task_74335_UnlockCondDesc = {
    Text = "Sau khi nhận \"Phần thưởng lượt chơi: Điểm đạt 2400\" sẽ được mở khóa"
  },
  Task_74342_Desc = {
    Text = "Sử dụng vai trò phòng thủ để đánh 25 thẻ bài"
  },
  Task_74343_Desc = {
    Text = "Sử dụng nhân vật loại Sao Hung (tượng trưng cho những vì sao mang điềm xấu) đánh ra 25 thẻ bài"
  },
  Task_74344_Desc = {
    Text = "Sử dụng nhân vật loại Phước lành để đánh ra 25 thẻ bài"
  },
  Task_74345_Desc = {
    Text = "Sử dụng nhân vật thuộc loại linh trí đánh ra 25 thẻ bài"
  },
  Task_74346_Desc = {
    Text = "Sử dụng nhân vật đấu tranh triển khai 25 thẻ bài"
  },
  Task_74375_Desc = {
    Text = "Sử dụng nhân vật đấu tranh đánh ra 1750 thẻ bài"
  },
  Task_74376_Desc = {
    Text = "Sử dụng nhân vật ban phước đánh ra 400 thẻ bài"
  },
  Task_74377_Desc = {
    Text = "Sử dụng nhân vật thuộc loại Linh Trí để đánh ra 1225 thẻ bài"
  },
  Task_74378_Desc = {
    Text = "Sử dụng nhân vật loại Hung Tinh đánh ra 1125 thẻ bài"
  },
  Task_74379_Desc = {
    Text = "Dùng nhân vật thuộc nhóm sao xấu để đánh ra 775 thẻ bài"
  },
  Task_74380_Desc = {
    Text = "Sử dụng nhân vật ban phước đánh ra 1775 thẻ bài"
  },
  Task_74381_Desc = {
    Text = "Sử dụng nhân vật chiến đấu đánh ra 775 thẻ bài"
  },
  Task_74382_Desc = {
    Text = "Sử dụng nhân vật thuộc loại Linh Trí đánh ra 700 thẻ bài"
  },
  Task_74383_Desc = {
    Text = "Sử dụng nhân vật thuộc lớp Bảo Vệ đánh ra 1875 thẻ bài"
  },
  Task_74384_Desc = {
    Text = "Sử dụng nhân vật ban phước đánh ra 825 thẻ bài"
  },
  Task_74385_Desc = {
    Text = "Sử dụng nhân vật đấu tranh triển khai 1800 thẻ bài"
  },
  Task_74386_Desc = {
    Text = "Sử dụng nhân vật đấu tranh chơi 1200 thẻ bài"
  },
  Task_74387_Desc = {
    Text = "Sử dụng nhân vật Buff đánh ra 775 thẻ bài"
  },
  Task_74388_Desc = {
    Text = "Sử dụng nhân vật thuộc loại Linh Trí để đánh ra 525 thẻ bài"
  },
  Task_74389_Desc = {
    Text = "Sử dụng nhân vật Linh Trí đánh ra 1600 thẻ bài"
  },
  Task_74390_Desc = {
    Text = "Sử dụng nhân vật loại Phép Chúc đánh ra 675 thẻ bài"
  },
  Task_74391_Desc = {
    Text = "Sử dụng nhân vật đấu tranh triển khai 1975 thẻ bài"
  },
  Task_74392_Desc = {
    Text = "Sử dụng nhân vật loại Hộ Vệ chơi ra 1525 thẻ bài"
  },
  Task_74393_Desc = {
    Text = "Sử dụng nhân vật thuộc nhóm Sao Hung đánh ra 1325 thẻ bài"
  },
  Task_74394_Desc = {
    Text = "Sử dụng nhân vật thuộc nhóm Sao Hung đánh ra 1550 thẻ bài"
  },
  Task_74395_Desc = {
    Text = "Sử dụng nhân vật ban phước đánh ra 1125 thẻ bài"
  },
  Task_74396_Desc = {
    Text = "Sử dụng nhân vật loại Sao Hung (Ngôi sao Hung Tinh) đánh ra 125 thẻ bài"
  },
  Task_74397_Desc = {
    Text = "Sử dụng nhân vật thuộc hệ Sao Hung đánh ra 1600 thẻ bài"
  },
  Task_74398_Desc = {
    Text = "Sử dụng nhân vật loại Phước đánh ra 650 thẻ bài"
  },
  Task_74399_Desc = {
    Text = "Sử dụng nhân vật loại Sao Hung đánh ra 325 thẻ bài"
  },
  Task_74400_Desc = {
    Text = "Sử dụng nhân vật loại Gia Tăng đánh ra 1325 thẻ bài"
  },
  Task_74401_Desc = {
    Text = "Sử dụng nhân vật loại chúc phúc để đánh ra 150 thẻ bài"
  },
  Task_74402_Desc = {
    Text = "Sử dụng nhân vật loại hung tinh đánh ra 50 thẻ bài"
  },
  Task_74403_Desc = {
    Text = "Sử dụng nhân vật loại Phước lành đánh ra 2000 thẻ bài"
  },
  Task_74404_Desc = {
    Text = "Sử dụng nhân vật đấu tranh chơi 850 thẻ bài"
  },
  Task_74405_Desc = {
    Text = "Sử dụng nhân vật loại Ban Phước để đánh ra 1150 thẻ bài"
  },
  Task_74406_Desc = {
    Text = "Sử dụng nhân vật loại Sao Hung chơi ra 150 thẻ bài"
  },
  Task_74407_Desc = {
    Text = "Sử dụng nhân vật phòng thủ để đánh ra 550 thẻ bài"
  },
  Task_74408_Desc = {
    Text = "Sử dụng nhân vật loại Hung Tinh đánh ra 800 thẻ bài"
  },
  Task_74409_Desc = {
    Text = "Sử dụng nhân vật chiến đấu đánh ra 100 thẻ bài"
  },
  Task_74410_Desc = {
    Text = "Sử dụng nhân vật dạng Hộ Vệ để đánh ra 1600 thẻ bài"
  },
  Task_74411_Desc = {
    Text = "Sử dụng nhân vật trí tuệ đánh ra 1300 thẻ bài"
  },
  Task_74412_Desc = {
    Text = "Sử dụng nhân vật phước lành đánh ra 1850 thẻ bài"
  },
  Task_74413_Desc = {
    Text = "Sử dụng nhân vật loại Linh Trí đánh ra 1525 thẻ bài"
  },
  Task_74414_Desc = {
    Text = "Sử dụng nhân vật phòng thủ để đánh ra 1425 thẻ bài"
  },
  Task_74415_Desc = {
    Text = "Sử dụng nhân vật phòng thủ để đánh ra 1275 thẻ bài"
  },
  Task_74416_Desc = {
    Text = "Sử dụng nhân vật thuộc loại linh trí đánh ra 925 thẻ bài"
  },
  Task_74417_Desc = {
    Text = "Sử dụng nhân vật thuộc lớp bảo vệ để đánh ra 800 thẻ bài"
  },
  Task_74418_Desc = {
    Text = "Sử dụng nhân vật thuộc nhóm Linh Trí đánh ra 1625 thẻ bài"
  },
  Task_74419_Desc = {
    Text = "Sử dụng nhân vật thuộc loại Linh Trí để đánh ra 1775 thẻ bài"
  },
  Task_74420_Desc = {
    Text = "Sử dụng nhân vật ban phước đánh ra 1100 thẻ bài"
  },
  Task_74421_Desc = {
    Text = "Sử dụng nhân vật loại sao xấu đánh ra 100 thẻ bài"
  },
  Task_74422_Desc = {
    Text = "Sử dụng nhân vật thuộc Loại Linh Trí để đánh ra 1750 thẻ bài"
  },
  Task_74423_Desc = {
    Text = "Sử dụng nhân vật thuộc loại linh trí đánh ra 1125 thẻ bài"
  },
  Task_74424_Desc = {
    Text = "Sử dụng nhân vật thuộc loại Linh Trí để đánh ra 750 thẻ bài"
  },
  Task_74425_Desc = {
    Text = "Sử dụng nhân vật loại Sao Hung đánh ra 1725 thẻ bài"
  },
  Task_74426_Desc = {
    Text = "Sử dụng nhân vật đấu tranh triển khai 1150 thẻ bài"
  },
  Task_74427_Desc = {
    Text = "Sử dụng nhân vật thuộc loại Trí Tuệ để đánh ra 175 thẻ bài"
  },
  Task_74428_Desc = {
    Text = "Sử dụng nhân vật thuộc nhóm Sao Hung đánh ra 1625 thẻ bài"
  },
  Task_74429_Desc = {
    Text = "Sử dụng nhân vật ban phước đánh ra 425 thẻ bài"
  },
  Task_74430_Desc = {
    Text = "Sử dụng nhân vật linh trí đánh ra 1700 thẻ bài"
  },
  Task_74431_Desc = {
    Text = "Sử dụng nhân vật đấu tranh triển khai 1325 thẻ bài"
  },
  Task_74432_Desc = {
    Text = "Sử dụng nhân vật ban phước đánh ra 1225 thẻ bài"
  },
  Task_74433_Desc = {
    Text = "Sử dụng nhân vật loại Sao Hung đánh ra 225 thẻ bài"
  },
  Task_74434_Desc = {
    Text = "Sử dụng nhân vật chiến đấu đánh ra 1875 thẻ bài"
  },
  Task_74435_Desc = {
    Text = "Dùng nhân vật thuộc nhóm Linh Trí để đánh ra 725 thẻ bài"
  },
  Task_74436_Desc = {
    Text = "Sử dụng nhân vật thuộc loại Linh Trí để đánh ra 325 thẻ bài"
  },
  Task_74437_Desc = {
    Text = "Sử dụng nhân vật thuộc loại Linh Trí để đánh ra 1350 thẻ bài"
  },
  Task_74438_Desc = {
    Text = "Sử dụng nhân vật bảo vệ để đánh ra 1725 thẻ bài"
  },
  Task_74439_Desc = {
    Text = "Sử dụng nhân vật đấu tranh triển khai 1375 thẻ bài"
  },
  Task_74440_Desc = {
    Text = "Sử dụng nhân vật lớp Bảo Vệ để đánh ra 925 thẻ bài"
  },
  Task_74441_Desc = {
    Text = "Sử dụng nhân vật thuộc nhóm Sao Hung đánh ra 1950 thẻ bài"
  },
  Task_74442_Desc = {
    Text = "Sử dụng nhân vật đấu tranh để đánh ra 450 thẻ bài"
  },
  Task_74443_Desc = {
    Text = "Sử dụng nhân vật bảo vệ để chơi 175 thẻ bài"
  },
  Task_74444_Desc = {
    Text = "Sử dụng nhân vật thuộc lớp Bảo Vệ để đánh ra 1100 thẻ bài"
  },
  Task_74445_Desc = {
    Text = "Sử dụng nhân vật phòng ngự để đánh ra 450 thẻ bài"
  },
  Task_74446_Desc = {
    Text = "Sử dụng nhân vật đấu tranh triển khai 1225 thẻ bài"
  },
  Task_74447_Desc = {
    Text = "Sử dụng nhân vật linh trí triển khai 1475 thẻ bài"
  },
  Task_74448_Desc = {
    Text = "Sử dụng nhân vật bảo vệ để triển khai 1250 thẻ bài"
  },
  Task_74449_Desc = {
    Text = "Sử dụng nhân vật thuộc loại linh trí đánh ra 100 thẻ bài"
  },
  Task_74450_Desc = {
    Text = "Sử dụng nhân vật đấu tranh triển khai 975 thẻ bài"
  },
  Task_74451_Desc = {
    Text = "Sử dụng nhân vật ban phước đánh ra 800 thẻ bài"
  },
  Task_74452_Desc = {
    Text = "Sử dụng nhân vật thuộc nhóm Sao Hung đánh ra 1875 thẻ bài"
  },
  Task_74453_Desc = {
    Text = "Sử dụng nhân vật đấu tranh chơi 900 thẻ bài"
  },
  Task_74454_Desc = {
    Text = "Sử dụng nhân vật loại Hộ Vệ đánh ra 1950 thẻ bài"
  },
  Task_74455_Desc = {
    Text = "Sử dụng nhân vật bảo vệ để đánh ra 1000 thẻ bài"
  },
  Task_74456_Desc = {
    Text = "Sử dụng nhân vật chiến đấu đánh ra 1925 thẻ bài"
  },
  Task_74457_Desc = {
    Text = "Sử dụng nhân vật thuộc loại Linh Trí để đánh ra 1825 thẻ bài"
  },
  Task_74458_Desc = {
    Text = "Sử dụng nhân vật đấu tranh chơi 1725 thẻ bài"
  },
  Task_74459_Desc = {
    Text = "Sử dụng nhân vật loại Sao Hung đánh ra 1500 thẻ bài"
  },
  Task_74460_Desc = {
    Text = "Sử dụng nhân vật loại Ngôi sao hung ác đánh ra 1375 thẻ bài"
  },
  Task_74461_Desc = {
    Text = "Sử dụng nhân vật bảo vệ để đánh ra 350 thẻ bài"
  },
  Task_74462_Desc = {
    Text = "Sử dụng nhân vật loại Sao Hung đánh ra 1975 thẻ bài"
  },
  Task_74463_Desc = {
    Text = "Sử dụng nhân vật thuộc lớp Hộ Vệ đánh ra 625 thẻ bài"
  },
  Task_74464_Desc = {
    Text = "Sử dụng nhân vật Hộ Vệ đánh ra 500 thẻ bài"
  },
  Task_74465_Desc = {
    Text = "Sử dụng nhân vật Linh Trí để đánh ra 1200 thẻ bài"
  },
  Task_74466_Desc = {
    Text = "Sử dụng nhân vật linh trí đánh ra 775 thẻ bài"
  },
  Task_74467_Desc = {
    Text = "Sử dụng nhân vật linh trí triển khai 975 thẻ bài"
  },
  Task_74468_Desc = {
    Text = "Sử dụng nhân vật linh trí đánh ra 1550 thẻ bài"
  },
  Task_74469_Desc = {
    Text = "Sử dụng nhân vật thuộc loại linh trí đánh ra 2000 thẻ bài"
  },
  Task_74470_Desc = {
    Text = "Sử dụng nhân vật loại Sao Xấu đánh ra 1050 thẻ bài"
  },
  Task_74471_Desc = {
    Text = "Sử dụng nhân vật thuộc lớp Bảo Vệ để đánh 1700 thẻ bài"
  },
  Task_74472_Desc = {
    Text = "Sử dụng nhân vật đấu tranh triển khai 1500 thẻ bài"
  },
  Task_74473_Desc = {
    Text = "Sử dụng nhân vật Ban Phước đánh ra 75 thẻ bài"
  },
  Task_74474_Desc = {
    Text = "Sử dụng nhân vật ban phước đánh ra 550 thẻ bài"
  },
  Task_74475_Desc = {
    Text = "Sử dụng nhân vật thuộc loại Linh Trí để đánh ra 150 thẻ bài"
  },
  Task_74476_Desc = {
    Text = "Sử dụng nhân vật chiến đấu đánh ra 1575 thẻ bài"
  },
  Task_74477_Desc = {
    Text = "Sử dụng nhân vật thuộc hệ linh trí đánh ra 425 thẻ bài"
  },
  Task_74478_Desc = {
    Text = "Sử dụng nhân vật hộ vệ để đánh ra 950 thẻ bài"
  },
  Task_74479_Desc = {
    Text = "Sử dụng nhân vật phòng thủ để đánh ra 700 thẻ bài"
  },
  Task_74480_Desc = {
    Text = "Sử dụng nhân vật chiến đấu đánh ra 1175 thẻ bài"
  },
  Task_74481_Desc = {
    Text = "Sử dụng nhân vật chiến đấu đánh ra 700 thẻ bài"
  },
  Task_74482_Desc = {
    Text = "Sử dụng nhân vật ban phước đánh ra 1275 thẻ bài"
  },
  Task_74483_Desc = {
    Text = "Sử dụng nhân vật thuộc loại Linh Trí đánh ra 625 thẻ bài"
  },
  Task_74484_Desc = {
    Text = "Sử dụng nhân vật loại sao xấu đánh ra 275 thẻ bài"
  },
  Task_74485_Desc = {
    Text = "Sử dụng nhân vật loại bảo vệ để đánh ra 1575 thẻ bài"
  },
  Task_74486_Desc = {
    Text = "Sử dụng vai trò phòng thủ để đánh ra 1400 thẻ bài"
  },
  Task_74487_Desc = {
    Text = "Sử dụng nhân vật đấu tranh triển khai 1675 thẻ bài"
  },
  Task_74488_Desc = {
    Text = "Sử dụng linh trí đánh ra 1075 thẻ bài"
  },
  Task_74489_Desc = {
    Text = "Sử dụng nhân vật bảo vệ để triển khai 325 thẻ bài"
  },
  Task_74490_Desc = {
    Text = "Sử dụng nhân vật loại Chúc phúc đánh ra 1025 thẻ bài"
  },
  Task_74491_Desc = {
    Text = "Sử dụng nhân vật thông minh đánh ra 1025 thẻ bài"
  },
  Task_74492_Desc = {
    Text = "Sử dụng nhân vật thuộc loại Linh Trí để triển khai 1050 thẻ bài"
  },
  Task_74493_Desc = {
    Text = "Sử dụng nhân vật bảo vệ đánh 600 thẻ bài"
  },
  Task_74494_Desc = {
    Text = "Sử dụng nhân vật thuộc loại Linh Trí (linh trí) để đánh ra 1900 thẻ bài"
  },
  Task_74495_Desc = {
    Text = "Sử dụng vai trò phòng thủ để đánh ra 125 thẻ bài"
  },
  Task_74496_Desc = {
    Text = "Sử dụng nhân vật thuộc Loại Linh Trí để đánh ra 200 thẻ bài"
  },
  Task_74497_Desc = {
    Text = "Sử dụng nhân vật ban phước đánh ra 1575 thẻ bài"
  },
  Task_74498_Desc = {
    Text = "Sử dụng nhân vật thuộc nhóm Hung Tinh đánh ra 575 thẻ bài"
  },
  Task_74499_Desc = {
    Text = "Sử dụng nhân vật đấu tranh chơi 800 thẻ bài"
  },
  Task_74500_Desc = {
    Text = "Sử dụng nhân vật thuộc loại Linh Trí đánh ra 1275 thẻ bài"
  },
  Task_74501_Desc = {
    Text = "Sử dụng nhân vật bảo vệ để chơi 1625 thẻ bài"
  },
  Task_74502_Desc = {
    Text = "Sử dụng nhân vật thuộc loại Ban Phước để đánh ra 1900 thẻ bài"
  },
  Task_74503_Desc = {
    Text = "Sử dụng nhân vật đấu tranh chơi 1100 thẻ bài"
  },
  Task_74504_Desc = {
    Text = "Sử dụng nhân vật chiến đấu đánh ra 150 thẻ bài"
  },
  Task_74505_Desc = {
    Text = "Sử dụng nhân vật loại chúc phúc để đánh ra 50 thẻ bài"
  },
  Task_74506_Desc = {
    Text = "Sử dụng nhân vật chiến đấu đánh ra 1025 thẻ bài"
  },
  Task_74507_Desc = {
    Text = "Sử dụng nhân vật đấu tranh triển khai 1900 thẻ bài"
  },
  Task_74508_Desc = {
    Text = "Sử dụng nhân vật đấu tranh triển khai 675 thẻ bài"
  },
  Task_74509_Desc = {
    Text = "Sử dụng nhân vật bảo vệ để chơi 1925 thẻ bài"
  },
  Task_74510_Desc = {
    Text = "Sử dụng nhân vật hệ Linh Trí để đánh ra 1850 thẻ bài"
  },
  Task_74511_Desc = {
    Text = "Sử dụng nhân vật loại Sao Hung triển khai 1250 thẻ bài"
  },
  Task_74512_Desc = {
    Text = "Sử dụng nhân vật đấu tranh triển khai 1950 thẻ bài"
  },
  Task_74513_Desc = {
    Text = "Sử dụng nhân vật đấu tranh đánh ra 550 thẻ bài"
  },
  Task_74514_Desc = {
    Text = "Sử dụng nhân vật đấu tranh triển khai 250 thẻ bài"
  },
  Task_74515_Desc = {
    Text = "Sử dụng nhân vật loại Sao Hung đánh ra 1525 thẻ bài"
  },
  Task_74516_Desc = {
    Text = "Sử dụng nhân vật bảo vệ để triển khai 75 thẻ bài"
  },
  Task_74517_Desc = {
    Text = "Sử dụng nhân vật có trí tuệ linh hoạt đánh ra 1150 thẻ bài"
  },
  Task_74518_Desc = {
    Text = "Sử dụng nhân vật loại sao xấu triển khai 825 thẻ bài"
  },
  Task_74519_Desc = {
    Text = "Sử dụng nhân vật lớp Bảo Vệ để đánh ra 50 thẻ bài"
  },
  Task_74520_Desc = {
    Text = "Sử dụng nhân vật loại Sao Hung đánh ra 1200 thẻ bài"
  },
  Task_74521_Desc = {
    Text = "Sử dụng nhân vật chiến đấu đánh ra 1600 thẻ bài"
  },
  Task_74522_Desc = {
    Text = "Sử dụng nhân vật chiến đấu đánh ra 1125 thẻ bài"
  },
  Task_74523_Desc = {
    Text = "Sử dụng nhân vật loại Sao Xấu đánh ra 1425 thẻ bài"
  },
  Task_74524_Desc = {
    Text = "Sử dụng nhân vật chiến đấu đánh ra 225 thẻ bài"
  },
  Task_74525_Desc = {
    Text = "Sử dụng nhân vật thuộc loại Linh Trí để đánh ra 375 thẻ bài"
  },
  Task_74526_Desc = {
    Text = "Sử dụng nhân vật phòng thủ đánh ra 1475 thẻ bài"
  },
  Task_74527_Desc = {
    Text = "Sử dụng nhân vật Hộ Vệ để đánh ra 100 thẻ bài"
  },
  Task_74528_Desc = {
    Text = "Sử dụng nhân vật chiến đấu đánh ra 375 thẻ bài"
  },
  Task_74529_Desc = {
    Text = "Sử dụng nhân vật phòng thủ đánh ra 1850 thẻ bài"
  },
  Task_74530_Desc = {
    Text = "Sử dụng nhân vật đấu tranh triển khai 350 thẻ bài"
  },
  Task_74531_Desc = {
    Text = "Sử dụng nhân vật ban phước đánh ra 1675 thẻ bài"
  },
  Task_74532_Desc = {
    Text = "Sử dụng nhân vật loại Hung Tinh (sao xấu) đánh ra 675 thẻ bài"
  },
  Task_74533_Desc = {
    Text = "Sử dụng nhân vật thuộc loại Linh Trí để chơi 1650 thẻ bài"
  },
  Task_74534_Desc = {
    Text = "Sử dụng nhân vật Linh Trí đánh ra 75 thẻ bài"
  },
  Task_74535_Desc = {
    Text = "Sử dụng nhân vật chiến đấu triển khai 50 thẻ bài"
  },
  Task_74536_Desc = {
    Text = "Sử dụng nhân vật chiến đấu đánh ra 875 thẻ bài"
  },
  Task_74537_Desc = {
    Text = "Sử dụng nhân vật dạng Hộ Vệ để đánh ra 1650 thẻ bài"
  },
  Task_74538_Desc = {
    Text = "Sử dụng nhân vật loại Blessing đánh ra 250 thẻ bài"
  },
  Task_74539_Desc = {
    Text = "Sử dụng nhân vật mang lại phước lành đánh ra 100 thẻ bài"
  },
  Task_74540_Desc = {
    Text = "Sử dụng nhân vật ban phước đánh ra 1075 thẻ bài"
  },
  Task_74541_Desc = {
    Text = "Sử dụng nhân vật thuộc nhóm Sao Hung đánh ra 1750 thẻ bài"
  },
  Task_74542_Desc = {
    Text = "Sử dụng nhân vật chiến đấu đánh ra 750 thẻ bài"
  },
  Task_74543_Desc = {
    Text = "Sử dụng nhân vật thuộc loại Linh Trí để đánh ra 550 thẻ bài"
  },
  Task_74544_Desc = {
    Text = "Sử dụng nhân vật đấu tranh chơi 1450 thẻ bài"
  },
  Task_74545_Desc = {
    Text = "Sử dụng nhân vật chiến đấu triển khai 725 thẻ bài"
  },
  Task_74546_Desc = {
    Text = "Sử dụng nhân vật Linh Trí để đánh ra 600 thẻ bài"
  },
  Task_74547_Desc = {
    Text = "Sử dụng nhân vật loại Chúc Phúc để đánh ra 700 thẻ bài"
  },
  Task_74548_Desc = {
    Text = "Sử dụng nhân vật phòng thủ đánh ra 1550 thẻ bài"
  },
  Task_74549_Desc = {
    Text = "Sử dụng nhân vật ban phước đánh ra 850 thẻ bài"
  },
  Task_74550_Desc = {
    Text = "Sử dụng nhân vật thuộc nhóm Sao Hung đánh ra 1450 thẻ bài"
  },
  Task_74551_Desc = {
    Text = "Sử dụng nhân vật chiến đấu đánh ra 1625 thẻ bài"
  },
  Task_74552_Desc = {
    Text = "Sử dụng nhân vật đấu tranh đánh ra 200 thẻ bài"
  },
  Task_74553_Desc = {
    Text = "Sử dụng nhân vật ban phước đánh ra 1525 thẻ bài"
  },
  Task_74554_Desc = {
    Text = "Sử dụng nhân vật loại sao xấu đánh ra 525 thẻ bài"
  },
  Task_74555_Desc = {
    Text = "Sử dụng nhân vật chúc phúc đánh ra 325 thẻ bài"
  },
  Task_74556_Desc = {
    Text = "Sử dụng nhân vật chiến đấu triển khai 1525 thẻ bài"
  },
  Task_74557_Desc = {
    Text = "Sử dụng nhân vật loại ngôi sao khắc nghiệt đánh ra 375 thẻ bài"
  },
  Task_74558_Desc = {
    Text = "Sử dụng nhân vật ban phước đánh ra 1375 thẻ bài"
  },
  Task_74559_Desc = {
    Text = "Sử dụng nhân vật phước lành để đánh ra 300 thẻ bài"
  },
  Task_74560_Desc = {
    Text = "Sử dụng nhân vật loại Chúc phúc đánh ra 225 thẻ bài"
  },
  Task_74561_Desc = {
    Text = "Sử dụng nhân vật đấu tranh triển khai 1850 thẻ bài"
  },
  Task_74562_Desc = {
    Text = "Sử dụng nhân vật bảo vệ để triển khai 475 thẻ bài"
  },
  Task_74563_Desc = {
    Text = "Sử dụng nhân vật ban phước đánh ra 600 thẻ bài"
  },
  Task_74564_Desc = {
    Text = "Sử dụng nhân vật bảo vệ đánh ra 1375 thẻ bài"
  },
  Task_74565_Desc = {
    Text = "Sử dụng nhân vật phòng thủ để đánh ra 1450 thẻ bài"
  },
  Task_74566_Desc = {
    Text = "Sử dụng nhân vật hệ Guardian để đánh ra 300 thẻ bài"
  },
  Task_74567_Desc = {
    Text = "Sử dụng nhân vật linh trí đánh ra 950 thẻ bài"
  },
  Task_74568_Desc = {
    Text = "Sử dụng nhân vật Guardian để đánh ra 1200 thẻ bài"
  },
  Task_74569_Desc = {
    Text = "Sử dụng nhân vật loại Sao Hung đánh ra 1025 thẻ bài"
  },
  Task_74570_Desc = {
    Text = "Sử dụng nhân vật loại chúc phúc đánh ra 950 thẻ bài"
  },
  Task_74571_Desc = {
    Text = "Sử dụng nhân vật đấu tranh triển khai 1350 thẻ bài"
  },
  Task_74572_Desc = {
    Text = "Sử dụng nhân vật bảo vệ để đánh ra 525 thẻ bài"
  },
  Task_74573_Desc = {
    Text = "Sử dụng nhân vật chiến đấu triển khai 125 thẻ bài"
  },
  Task_74574_Desc = {
    Text = "Sử dụng nhân vật ban phước đánh ra 475 thẻ bài"
  },
  Task_74575_Desc = {
    Text = "Sử dụng nhân vật có trí tuệ linh hoạt đánh ra 350 thẻ bài"
  },
  Task_74576_Desc = {
    Text = "Sử dụng nhân vật thuộc loại Linh Trí để đánh ra 1175 thẻ bài"
  },
  Task_74577_Desc = {
    Text = "Sử dụng nhân vật có trí tuệ linh hoạt đánh ra 1250 thẻ bài"
  },
  Task_74578_Desc = {
    Text = "Sử dụng nhân vật bảo vệ để đánh ra 775 thẻ bài"
  },
  Task_74579_Desc = {
    Text = "Sử dụng nhân vật Hộ Vệ để đánh ra 400 thẻ bài"
  },
  Task_74580_Desc = {
    Text = "Sử dụng nhân vật chiến đấu đánh ra 825 thẻ bài"
  },
  Task_74581_Desc = {
    Text = "Sử dụng nhân vật thông minh đánh ra 650 thẻ bài"
  },
  Task_74582_Desc = {
    Text = "Sử dụng nhân vật loại sao hung tinh đánh ra 1575 thẻ bài"
  },
  Task_74583_Desc = {
    Text = "Sử dụng nhân vật loại Phúc lành đánh ra 350 thẻ bài"
  },
  Task_74584_Desc = {
    Text = "Sử dụng nhân vật đấu tranh triển khai 1400 thẻ bài"
  },
  Task_74585_Desc = {
    Text = "Sử dụng nhân vật Hộ Vệ đánh ra 275 thẻ bài"
  },
  Task_74586_Desc = {
    Text = "Sử dụng nhân vật ban phước triển khai 1500 thẻ bài"
  },
  Task_74587_Desc = {
    Text = "Sử dụng nhân vật loại Sao Hung đánh ra 500 thẻ bài"
  },
  Task_74588_Desc = {
    Text = "Sử dụng nhân vật đấu tranh triển khai 1075 thẻ bài"
  },
  Task_74589_Desc = {
    Text = "Sử dụng nhân vật ban phước đánh ra 625 thẻ bài"
  },
  Task_74590_Desc = {
    Text = "Sử dụng nhân vật đấu tranh chơi 575 thẻ bài"
  },
  Task_74591_Desc = {
    Text = "Sử dụng nhân vật loại hung tinh đánh ra 850 thẻ bài"
  },
  Task_74592_Desc = {
    Text = "Sử dụng nhân vật bảo vệ để đánh ra 650 thẻ bài"
  },
  Task_74593_Desc = {
    Text = "Sử dụng nhân vật ban phước đánh ra 575 thẻ bài"
  },
  Task_74594_Desc = {
    Text = "Sử dụng nhân vật loại Phước lành đánh ra 375 thẻ bài"
  },
  Task_74595_Desc = {
    Text = "Sử dụng nhân vật bảo vệ và đánh bại 225 thẻ bài"
  },
  Task_74596_Desc = {
    Text = "Sử dụng nhân vật thuộc loại linh trí chơi 1875 thẻ bài"
  },
  Task_74597_Desc = {
    Text = "Sử dụng nhân vật phòng thủ để đánh ra 1075 thẻ bài"
  },
  Task_74598_Desc = {
    Text = "Sử dụng nhân vật đấu tranh triển khai 1825 thẻ bài"
  },
  Task_74599_Desc = {
    Text = "Sử dụng nhân vật thuộc hệ Sao Hung đánh ra 1700 thẻ bài"
  },
  Task_74600_Desc = {
    Text = "Sử dụng nhân vật lớp Guardian để đánh ra 150 thẻ bài"
  },
  Task_74601_Desc = {
    Text = "Sử dụng nhân vật bảo vệ để đánh 1750 thẻ bài"
  },
  Task_74602_Desc = {
    Text = "Sử dụng nhân vật Guardian để đánh ra 1975 thẻ bài"
  },
  Task_74603_Desc = {
    Text = "Sử dụng nhân vật thuộc nhóm Sao Hung đánh ra 750 thẻ bài"
  },
  Task_74604_Desc = {
    Text = "Sử dụng nhân vật mang phép chúc phúc đánh ra 1750 thẻ bài"
  },
  Task_74605_Desc = {
    Text = "Sử dụng nhân vật loại Sao Hung đánh ra 1150 thẻ bài"
  },
  Task_74606_Desc = {
    Text = "Sử dụng nhân vật loại Sao Hung đánh ra 1475 thẻ bài"
  },
  Task_74607_Desc = {
    Text = "Sử dụng nhân vật thuộc lớp bảo vệ để đánh ra 875 thẻ bài"
  },
  Task_74608_Desc = {
    Text = "Sử dụng nhân vật loại Sao Hung triển khai 725 thẻ bài"
  },
  Task_74609_Desc = {
    Text = "Sử dụng nhân vật ban phước đánh ra 1725 thẻ bài"
  },
  Task_74610_Desc = {
    Text = "Sử dụng nhân vật thuộc nhóm Sao Hung đánh ra 1800 thẻ bài"
  },
  Task_74611_Desc = {
    Text = "Sử dụng nhân vật phép ban phước đánh ra 1050 thẻ bài"
  },
  Task_74612_Desc = {
    Text = "Sử dụng nhân vật ban phước đánh ra 1925 thẻ bài"
  },
  Task_74613_Desc = {
    Text = "Sử dụng nhân vật loại sao xấu đánh ra 925 thẻ bài"
  },
  Task_74614_Desc = {
    Text = "Sử dụng nhân vật thuộc nhóm Linh Trí đánh ra 250 thẻ bài"
  },
  Task_74615_Desc = {
    Text = "Sử dụng nhân vật Linh Trí để đánh ra 900 thẻ bài"
  },
  Task_74616_Desc = {
    Text = "Sử dụng nhân vật loại sao xấu triển khai 350 thẻ bài"
  },
  Task_74617_Desc = {
    Text = "Sử dụng nhân vật ban phước đánh ra 1350 thẻ bài"
  },
  Task_74618_Desc = {
    Text = "Sử dụng nhân vật loại chúc phúc đánh ra 125 thẻ bài"
  },
  Task_74619_Desc = {
    Text = "Sử dụng nhân vật loại Sao Hung đánh ra 1775 thẻ bài"
  },
  Task_74620_Desc = {
    Text = "Sử dụng nhân vật loại Sao Ác đánh ra 1925 thẻ bài"
  },
  Task_74621_Desc = {
    Text = "Sử dụng nhân vật thuộc nhóm Sao Hung đánh ra 1900 thẻ bài"
  },
  Task_74622_Desc = {
    Text = "Sử dụng nhân vật thuộc loại Linh Trí đánh ra 875 thẻ bài"
  },
  Task_74623_Desc = {
    Text = "Sử dụng nhân vật bảo vệ để triển khai 250 thẻ bài"
  },
  Task_74624_Desc = {
    Text = "Sử dụng nhân vật bảo vệ để chơi 900 thẻ bài"
  },
  Task_74625_Desc = {
    Text = "Sử dụng nhân vật phòng thủ để đánh ra 675 thẻ bài"
  },
  Task_74626_Desc = {
    Text = "Sử dụng nhân vật bảo vệ triển khai 1350 thẻ bài"
  },
  Task_74627_Desc = {
    Text = "Sử dụng nhân vật loại Linh Trí chơi 1450 thẻ bài"
  },
  Task_74628_Desc = {
    Text = "Sử dụng nhân vật ban phước triển khai 875 thẻ bài"
  },
  Task_74629_Desc = {
    Text = "Sử dụng nhân vật chiến đấu đánh ra 1550 thẻ bài"
  },
  Task_74630_Desc = {
    Text = "Sử dụng nhân vật thuộc loại Linh Trí để đánh 1000 thẻ bài"
  },
  Task_74631_Desc = {
    Text = "Sử dụng nhân vật thuộc nhóm sao xấu triển khai 2000 thẻ bài"
  },
  Task_74632_Desc = {
    Text = "Sử dụng nhân vật thuộc loại Linh Trí đánh ra 675 thẻ bài"
  },
  Task_74633_Desc = {
    Text = "Sử dụng nhân vật bảo vệ triển khai 1025 thẻ bài"
  },
  Task_74634_Desc = {
    Text = "Sử dụng nhân vật loại Sao Hung triển khai 1300 thẻ bài"
  },
  Task_74635_Desc = {
    Text = "Sử dụng nhân vật thuộc loại Linh Trí để đánh ra 1800 thẻ bài"
  },
  Task_74636_Desc = {
    Text = "Sử dụng nhân vật loại Hộ Vệ đánh ra 1825 thẻ bài"
  },
  Task_74637_Desc = {
    Text = "Sử dụng nhân vật chiến đấu đánh ra 1700 thẻ bài"
  },
  Task_74638_Desc = {
    Text = "Sử dụng nhân vật chiến đấu đánh ra 1000 thẻ bài"
  },
  Task_74639_Desc = {
    Text = "Sử dụng nhân vật ban phước đánh ra 275 thẻ bài"
  },
  Task_74640_Desc = {
    Text = "Sử dụng nhân vật thuộc loại Linh Trí để đánh ra 1100 thẻ bài"
  },
  Task_74641_Desc = {
    Text = "Sử dụng nhân vật loại phúc lành đánh ra 1800 thẻ bài"
  },
  Task_74642_Desc = {
    Text = "Sử dụng nhân vật đấu tranh đánh ra 1475 thẻ bài"
  },
  Task_74643_Desc = {
    Text = "Sử dụng nhân vật loại sao xấu đánh ra 1225 thẻ bài"
  },
  Task_74644_Desc = {
    Text = "Sử dụng nhân vật hỗ trợ đánh ra 975 thẻ bài"
  },
  Task_74645_Desc = {
    Text = "Sử dụng nhân vật chiến đấu đánh ra 400 thẻ bài"
  },
  Task_74646_Desc = {
    Text = "Dùng nhân vật linh trí để đánh ra 800 thẻ bài"
  },
  Task_74647_Desc = {
    Text = "Sử dụng nhân vật thuộc loại Linh-Trí để đánh ra 1925 thẻ bài"
  },
  Task_74648_Desc = {
    Text = "Sử dụng nhân vật thuộc loại linh trí đánh ra 1375 thẻ bài"
  },
  Task_74649_Desc = {
    Text = "Sử dụng nhân vật thuộc dòng Linh Trí để đánh ra 400 thẻ bài"
  },
  Task_74650_Desc = {
    Text = "Sử dụng nhân vật loại Chúc Phép để đánh ra 1000 thẻ bài"
  },
  Task_74651_Desc = {
    Text = "Sử dụng, nhân vật loại Sao Hung đánh ra 700 thẻ bài"
  },
  Task_74652_Desc = {
    Text = "Dùng nhân vật ban phước đánh 1700 thẻ bài"
  },
  Task_74653_Desc = {
    Text = "Sử dụng nhân vật thuộc loại Sao Hung đánh ra 1075 thẻ bài"
  },
  Task_74654_Desc = {
    Text = "Sử dụng nhân vật đấu tranh chơi ra 1050 thẻ bài"
  },
  Task_74655_Desc = {
    Text = "Sử dụng nhân vật chiến đấu triển khai 175 thẻ bài"
  },
  Task_74656_Desc = {
    Text = "Dùng nhân vật thuộc loại Linh Trí để đánh ra 300 thẻ bài"
  },
  Task_74657_Desc = {
    Text = "Sử dụng nhân vật loại Sao Xấu đánh ra 1000 thẻ bài"
  },
  Task_74658_Desc = {
    Text = "Dùng nhân vật thuộc nhóm linh trí để đánh ra 825 thẻ bài"
  },
  Task_74659_Desc = {
    Text = "Sử dụng nhân vật chiến đấu đánh ra 600 thẻ bài"
  },
  Task_74660_Desc = {
    Text = "Sử dụng nhân vật Guardian để đánh ra 725 thẻ bài"
  },
  Task_74661_Desc = {
    Text = "Sử dụng nhân vật dạng bảo vệ để đánh ra 750 thẻ bài"
  },
  Task_74662_Desc = {
    Text = "Dùng nhân vật thuộc nhóm Sao Hung để đánh ra 1675 thẻ bài"
  },
  Task_74663_Desc = {
    Text = "Sử dụng nhân vật thuộc loại Trí Tuệ đánh ra 1500 thẻ bài"
  },
  Task_74664_Desc = {
    Text = "Sử dụng nhân vật Hộ Vệ đánh ra 375 thẻ bài"
  },
  Task_74665_Desc = {
    Text = "Sử dụng nhân vật bảo vệ để triển khai 1150 thẻ bài"
  },
  Task_74666_Desc = {
    Text = "Sử dụng nhân vật thuộc loại Linh Trí để đánh ra 275 thẻ bài"
  },
  Task_74667_Desc = {
    Text = "Sử dụng nhân vật ban phước đánh ra 900 thẻ bài"
  },
  Task_74668_Desc = {
    Text = "Sử dụng nhân vật thuộc loại Trí Tuệ để đánh ra 475 thẻ bài"
  },
  Task_74669_Desc = {
    Text = "Sử dụng nhân vật loại sao hung ác đánh ra 75 thẻ bài"
  },
  Task_74670_Desc = {
    Text = "Sử dụng nhân vật ban phước đánh ra 175 thẻ bài"
  },
  Task_74671_Desc = {
    Text = "Sử dụng nhân vật bảo vệ để đánh ra 1775 thẻ bài"
  },
  Task_74672_Desc = {
    Text = "Sử dụng nhân vật linh trí triển khai 575 thẻ bài"
  },
  Task_74673_Desc = {
    Text = "Sử dụng nhân vật đấu tranh triển khai 500 thẻ bài"
  },
  Task_74674_Desc = {
    Text = "Sử dụng nhân vật thuộc loại Linh Trí để triển khai 1725 thẻ bài"
  },
  Task_74675_Desc = {
    Text = "Sử dụng nhân vật chiến đấu đánh ra 950 thẻ bài"
  },
  Task_74676_Desc = {
    Text = "Sử dụng nhân vật Linh Trí để đánh ra 1950 thẻ bài"
  },
  Task_74677_Desc = {
    Text = "Sử dụng nhân vật phòng thủ để đánh ra 1500 thẻ bài"
  },
  Task_74678_Desc = {
    Text = "Sử dụng nhân vật loại chúc phúc đánh ra 1975 thẻ bài"
  },
  Task_74679_Desc = {
    Text = "Sử dụng nhân vật thuộc loại sao xấu để đánh ra tổng cộng 975 thẻ bài"
  },
  Task_74680_Desc = {
    Text = "Sử dụng nhân vật thuộc loại Linh Trí đánh ra 1325 thẻ bài"
  },
  Task_74681_Desc = {
    Text = "Sử dụng nhân vật chiến đấu đánh ra 1775 thẻ bài"
  },
  Task_74682_Desc = {
    Text = "Sử dụng nhân vật linh trí triển khai 125 thẻ bài"
  },
  Task_74683_Desc = {
    Text = "Sử dụng nhân vật phước lành đánh ra 1550 thẻ bài"
  },
  Task_74684_Desc = {
    Text = "Sử dụng nhân vật chiến đấu đánh ra 2000 thẻ bài"
  },
  Task_74685_Desc = {
    Text = "Sử dụng nhân vật thuộc nhóm sao hung tinh đánh ra 1275 thẻ bài"
  },
  Task_74686_Desc = {
    Text = "Sử dụng nhân vật dạng phúc lành đánh ra 525 thẻ bài"
  },
  Task_74687_Desc = {
    Text = "Sử dụng nhân vật loại sao xấu triển khai 550 thẻ bài"
  },
  Task_74688_Desc = {
    Text = "Sử dụng nhân vật đấu tranh triển khai 650 thẻ bài"
  },
  Task_74689_Desc = {
    Text = "Sử dụng nhân vật loại Sao Xấu đánh ra 875 thẻ bài"
  },
  Task_74690_Desc = {
    Text = "Sử dụng nhân vật loại Phước đánh ra 1875 thẻ bài"
  },
  Task_74691_Desc = {
    Text = "Sử dụng nhân vật bảo vệ để triển khai 1300 thẻ bài"
  },
  Task_74692_Desc = {
    Text = "Sử dụng nhân vật loại Sao Hung đánh ra 1100 thẻ bài"
  },
  Task_74693_Desc = {
    Text = "Sử dụng nhân vật phòng thủ để đánh 2000 thẻ bài"
  },
  Task_74694_Desc = {
    Text = "Sử dụng nhân vật loại Sao Xấu đánh ra 1850 thẻ bài"
  },
  Task_74695_Desc = {
    Text = "Sử dụng nhân vật đấu tranh triển khai 75 thẻ bài"
  },
  Task_74696_Desc = {
    Text = "Sử dụng nhân vật đấu tranh triển khai 625 thẻ bài"
  },
  Task_74697_Desc = {
    Text = "Sử dụng nhân vật chiến đấu đánh ra 1425 thẻ bài"
  },
  Task_74698_Desc = {
    Text = "Sử dụng nhân vật hộ vệ để đánh ra 1800 thẻ bài"
  },
  Task_74699_Desc = {
    Text = "Sử dụng nhân vật thuộc loại Linh Trí để đánh ra 225 thẻ bài"
  },
  Task_74700_Desc = {
    Text = "Sử dụng nhân vật loại phước đánh ra 725 thẻ bài"
  },
  Task_74701_Desc = {
    Text = "Sử dụng nhân vật bảo vệ đánh ra 1175 thẻ bài"
  },
  Task_74702_Desc = {
    Text = "Sử dụng nhân vật linh trí chơi 450 thẻ bài"
  },
  Task_74703_Desc = {
    Text = "Sử dụng nhân vật phòng thủ để đánh ra 575 thẻ bài"
  },
  Task_74704_Desc = {
    Text = "Sử dụng nhân vật ban phúc đánh ra 1625 thẻ bài"
  },
  Task_74705_Desc = {
    Text = "Sử dụng nhân vật loại Sao Hung đánh ra 625 thẻ bài"
  },
  Task_74706_Desc = {
    Text = "Sử dụng nhân vật loại Ngôi sao Hung đánh ra 1350 thẻ bài"
  },
  Task_74707_Desc = {
    Text = "Sử dụng nhân vật ban phước đánh ra 1650 thẻ bài"
  },
  Task_74708_Desc = {
    Text = "Sử dụng nhân vật loại Sao Hung Tinh đánh ra 650 thẻ bài"
  },
  Task_74709_Desc = {
    Text = "Sử dụng nhân vật hệ Bảo Vệ để đánh ra 200 thẻ bài"
  },
  Task_74710_Desc = {
    Text = "Sử dụng nhân vật bảo vệ để đánh ra 1125 thẻ bài"
  },
  Task_74711_Desc = {
    Text = "Sử dụng nhân vật thuộc loại Linh Trí để đánh ra 50 thẻ bài"
  },
  Task_74712_Desc = {
    Text = "Sử dụng nhân vật loại Sao Hung đánh ra 450 thẻ bài"
  },
  Task_74713_Desc = {
    Text = "Sử dụng nhân vật Ban Phước để đánh ra 1250 thẻ bài"
  },
  Task_74714_Desc = {
    Text = "Sử dụng nhân vật loại sao xấu đánh ra 250 thẻ bài"
  },
  Task_74715_Desc = {
    Text = "Sử dụng nhân vật ban phước đánh ra 1450 thẻ bài"
  },
  Task_74716_Desc = {
    Text = "Sử dụng nhân vật thuộc loại Linh Trí để đánh 1675 thẻ bài"
  },
  Task_74717_Desc = {
    Text = "Sử dụng nhân vật loại Sao Xấu đánh ra 900 thẻ bài"
  },
  Task_74718_Desc = {
    Text = "Sử dụng nhân vật thông minh đánh ra 500 thẻ bài"
  },
  Task_74719_Desc = {
    Text = "Sử dụng nhân vật phòng thủ đánh ra 1325 thẻ bài"
  },
  Task_74720_Desc = {
    Text = "Sử dụng nhân vật thuộc nhóm sao hung tinh để triển khai 425 thẻ bài"
  },
  Task_74721_Desc = {
    Text = "Sử dụng nhân vật ban phước chơi ra 1425 thẻ bài"
  },
  Task_74722_Desc = {
    Text = "Sử dụng nhân vật đấu tranh chơi 1300 thẻ bài"
  },
  Task_74723_Desc = {
    Text = "Sử dụng nhân vật ban phước đánh ra 925 thẻ bài"
  },
  Task_74724_Desc = {
    Text = "Sử dụng nhân vật loại Phúc đánh ra 1825 thẻ bài"
  },
  Task_74725_Desc = {
    Text = "Sử dụng nhân vật ban phước đánh ra 1175 thẻ bài"
  },
  Task_74726_Desc = {
    Text = "Sử dụng nhân vật loại Sao Hung để chơi 175 thẻ bài"
  },
  Task_74727_Desc = {
    Text = "Sử dụng nhân vật ban phước đánh ra 750 thẻ bài"
  },
  Task_74728_Desc = {
    Text = "Sử dụng nhân vật bảo vệ và đánh ra 850 thẻ bài"
  },
  Task_74729_Desc = {
    Text = "Sử dụng nhân vật chiến đấu đánh ra 1650 thẻ bài"
  },
  Task_74730_Desc = {
    Text = "Sử dụng nhân vật đấu tranh đánh ra 1275 thẻ bài"
  },
  Task_74731_Desc = {
    Text = "Sử dụng nhân vật thuộc nhóm Sao Hung đánh ra 1175 thẻ bài"
  },
  Task_74732_Desc = {
    Text = "Sử dụng nhân vật Linh Trí để đánh ra 1975 thẻ bài"
  },
  Task_74733_Desc = {
    Text = "Sử dụng nhân vật đấu tranh triển khai 275 thẻ bài"
  },
  Task_74734_Desc = {
    Text = "Sử dụng nhân vật linh trí đánh ra 1425 thẻ bài"
  },
  Task_74735_Desc = {
    Text = "Sử dụng nhân vật bảo vệ để triển khai 1900 thẻ bài"
  },
  Task_74736_Desc = {
    Text = "Sử dụng nhân vật ban phước đánh ra 1600 thẻ bài"
  },
  Task_74737_Desc = {
    Text = "Sử dụng nhân vật loại Sao Hung Tinh đánh ra 600 thẻ bài"
  },
  Task_74738_Desc = {
    Text = "Sử dụng nhân vật bảo vệ để triển khai 1050 thẻ bài"
  },
  Task_74739_Desc = {
    Text = "Sử dụng nhân vật loại Sao Hung đánh ra 1400 thẻ bài"
  },
  Task_74740_Desc = {
    Text = "Sử dụng nhân vật loại chúc phúc để triển khai 200 thẻ bài"
  },
  Task_74741_Desc = {
    Text = "Sử dụng nhân vật ban phước để đánh ra 500 thẻ bài"
  },
  Task_74742_Desc = {
    Text = "Sử dụng nhân vật bảo vệ để đánh ra 1225 thẻ bài"
  },
  Task_74743_Desc = {
    Text = "Sử dụng nhân vật đấu tranh triển khai 525 thẻ bài"
  },
  Task_74744_Desc = {
    Text = "Sử dụng nhân vật thuộc loại sao hung đánh ra 400 thẻ bài"
  },
  Task_74745_Desc = {
    Text = "Sử dụng nhân vật ban phước để đánh ra 1400 thẻ bài"
  },
  Task_74746_Desc = {
    Text = "Dùng nhân vật bảo vệ chơi 425 thẻ bài"
  },
  Task_74747_Desc = {
    Text = "Sử dụng nhân vật đấu tranh triển khai 475 thẻ bài"
  },
  Task_74748_Desc = {
    Text = "Sử dụng nhân vật hệ sao hung đánh ra 475 thẻ bài"
  },
  Task_74749_Desc = {
    Text = "Sử dụng nhân vật ban phước triển khai 1475 thẻ bài"
  },
  Task_74750_Desc = {
    Text = "Sử dụng nhân vật chiến đấu đánh ra 300 thẻ bài"
  },
  Task_74751_Desc = {
    Text = "Sử dụng nhân vật linh trí đánh ra 1575 thẻ bài"
  },
  Task_74752_Desc = {
    Text = "Bằng cách sử dụng nhân vật bảo vệ, triển khai 1675 thẻ bài"
  },
  Task_74753_Desc = {
    Text = "Sử dụng nhân vật bảo vệ để triển khai 975 thẻ bài"
  },
  Task_74754_Desc = {
    Text = "Sử dụng nhân vật chiến đấu đánh ra 1250 thẻ bài"
  },
  Task_74755_Desc = {
    Text = "Sử dụng nhân vật thuộc loại Linh Trí để triển khai 850 thẻ bài"
  },
  Task_74756_Desc = {
    Text = "Sử dụng nhân vật tăng phúc đánh ra 1200 thẻ bài"
  },
  Task_74757_Desc = {
    Text = "Sử dụng nhân vật loại Sao Xấu đánh ra 1650 thẻ bài"
  },
  Task_74758_Desc = {
    Text = "Sử dụng nhân vật loại sao xấu đánh ra 200 thẻ bài"
  },
  Task_74759_Desc = {
    Text = "Sử dụng nhân vật ban phước đánh ra 1950 thẻ bài"
  },
  Task_74760_Desc = {
    Text = "Sử dụng nhân vật thuộc loại sao dữ đánh ra 950 thẻ bài"
  },
  Task_74761_Desc = {
    Text = "Sử dụng nhân vật thuộc loại ban phước đánh ra 450 thẻ bài"
  },
  Task_74762_Desc = {
    Text = "Sử dụng nhân vật thuộc loại Trí Tuệ để đánh ra 1400 thẻ bài"
  },
  Task_74763_Desc = {
    Text = "Sử dụng nhân vật đấu tranh triển khai 325 thẻ bài"
  },
  Task_74764_Desc = {
    Text = "Sử dụng nhân vật đấu tranh chơi 925 thẻ bài"
  },
  Task_74765_Desc = {
    Text = "Sử dụng nhân vật loại Sao Ác đánh ra 1825 thẻ bài"
  },
  Task_74766_Desc = {
    Text = "Dùng nhân vật loại sao xấu đánh 300 thẻ bài"
  },
  Task_74767_Desc = {
    Text = "Sử dụng nhân vật ban phước đánh ra 1300 thẻ bài"
  },
  Task_74768_Desc = {
    Text = "Sử dụng nhân vật chiến đấu đánh ra 425 thẻ bài"
  },
  Task_74769_Desc = {
    Text = "Sử dụng nhân vật phòng thủ để đánh ra 825 thẻ bài"
  },
  Task_75738_Desc = {
    Text = "Hoàn thành \"Thây Ma Không Đầu\" bất kỳ độ khó nào"
  },
  Task_75739_Desc = {
    Text = "Hoàn thành \"Trở về Biển Xám\"ở bất kỳ độ khó nào"
  },
  Task_75740_Desc = {
    Text = "Hoàn thành \"quỷ đầm lầy(Quỷ đầm lầy)\" bất kỳ độ khó nào"
  },
  Task_75741_Desc = {
    Text = "Hoàn thành \"Săn đuổi đêm mưa\"ở bất kỳ độ khó nào"
  },
  Task_75742_Desc = {
    Text = "Hoàn thành \"nó và cô ấy\"ở bất kỳ độ khó nào"
  },
  Task_76237_Desc = {
    Text = "Hoàn thành chương 1-5 của phần Tinh Vân ở độ khó Khó Khăn"
  },
  Task_76238_Desc = {
    Text = "Hoàn thành chương cuối \"Dài Mộng Tận Thời\""
  },
  Task_76239_Desc = {
    Text = "Hoàn thành chương 1 của câu chuyện Sao Băng, từ 1 đến 6"
  },
  Task_76240_Desc = {
    Text = "Hoàn thành chương cuối 9-3 độ khó"
  },
  Task_76241_Desc = {
    Text = "Hoàn thành chương cuối cùng \"Khi Mơ Dài Kết Thúc\" khó khăn"
  },
  Task_76242_Desc = {
    Text = "Hoàn thành chương cuối \"Dài Mộng Tận Thời\""
  },
  Task_76243_Desc = {
    Text = "Hoàn thành chương 1 của phần Sao \"Trở lại sương đô\"ở độ khó Khó"
  },
  Task_76244_Desc = {
    Text = "Hoàn thành chương 1 của phần Sao \"Trở lại sương đô\"ở độ khó Khó"
  },
  Task_76245_Desc = {
    Text = "Hoàn thành Chương cuối cùng 9-4"
  },
  Task_76246_Desc = {
    Text = "Hoàn thành chương 1 của câu chuyện Sao Băng, từ 1 đến 6"
  },
  Task_76247_Desc = {
    Text = "Hoàn thành chương 1 \"Trở lại sương đô\""
  },
  Task_76248_Desc = {
    Text = "Hoàn thành chương 1-5 của phần Tinh Vân ở độ khó Khó Khăn"
  },
  Task_76249_Desc = {
    Text = "Hoàn thành chương cuối cùng \"Khi Mơ Dài Kết Thúc\" khó khăn"
  },
  Task_76250_Desc = {
    Text = "Hoàn thành chương cuối 9-3 độ khó"
  },
  Task_76251_Desc = {
    Text = "Hoàn thành Chương cuối cùng 9-4"
  },
  Task_76252_Desc = {
    Text = "Hoàn thành chương 1 \"Trở lại sương đô\""
  },
  Task_76339_Desc = {
    Text = "Hoàn thành \"Trở về Biển Xám\"ở bất kỳ độ khó nào"
  },
  Task_76340_Desc = {
    Text = "Cửa hàng Ma nữ · điên cuồng"
  },
  Task_76341_Desc = {
    Text = "Hoàn thành \"Đuổi săn đêm mưa\"độ khó cực kỳ điên cuồng"
  },
  Task_76342_Desc = {
    Text = "Hoàn thành \"Quỷ đầm lầy\" mức độ điên cuồng"
  },
  Task_76343_Desc = {
    Text = "Hoàn thành \"nó và cô ấy\"ở bất kỳ độ khó nào"
  },
  Task_76344_Desc = {
    Text = "Kho báu của nữ phù thủy bí ẩn"
  },
  Task_76345_Desc = {
    Text = "Trong \"Kho Báu Tuyệt Mỹ\"đổi lấy 300 vật phẩm"
  },
  Task_76346_Desc = {
    Text = "Trong \"Kho Báu Rực Rỡ\"đổi lấy 150 vật phẩm"
  },
  Task_76347_Desc = {
    Text = "Hoàn thành \"Vô Đầu Thi\"ở độ khó điên cuồng"
  },
  Task_76348_Desc = {
    Text = "Hoàn thành \"Săn đuổi đêm mưa\"ở bất kỳ độ khó nào"
  },
  Task_76349_Desc = {
    Text = "Hoàn thành \"Nó và Cô ấy\"ở độ khó điên cuồng"
  },
  Task_76350_Desc = {
    Text = "Hoàn thành \"Quay về Biển Xám\"độ khó điên cuồng"
  },
  Task_76351_Desc = {
    Text = "Trong \"Kho Báu Hiếm Có\"đổi chỗ để nhận được 150 vật phẩm"
  },
  Task_76352_Desc = {
    Text = "Hoàn thành đặc vụ\"Bóng ma trong mưa\""
  },
  Task_76353_Desc = {
    Text = "Hoàn thành tất cả nhiệm vụ của \"Cửa hàng Ma nữ·hoàn thành\""
  },
  Task_76354_Desc = {
    Text = "Trong \"Kho Báu Trân Quý\"đổi chỗ để nhận được 300 vật phẩm"
  },
  Task_76355_Desc = {
    Text = "Hoàn thành \"quỷ đầm lầy(Quỷ đầm lầy)\" bất kỳ độ khó nào"
  },
  Task_76356_Desc = {
    Text = "Trong \"Giải ưu gia phẩm\"đổi lấy 300 vật phẩm"
  },
  Task_76357_Desc = {
    Text = "Trong \"món quà giải sầu\"đổi lấy 150 vật phẩm"
  },
  Task_76358_Desc = {
    Text = "Cửa hàng phù thủy·Hoàn thành"
  },
  Task_76359_Desc = {
    Text = "Hoàn thành \"Thây Ma Không Đầu\" bất kỳ độ khó nào"
  },
  Task_77674_Desc = {
    Text = "Đạt được tổng cộng 10 trận thắng trong mùa giải này"
  },
  Task_77674_Name = {Text = "10 thắng"},
  Task_77675_Desc = {
    Text = "Đạt được tích lũy 1 trận thắng trong mùa giải này"
  },
  Task_77675_Name = {
    Text = "1 trận thắng"
  },
  Task_77676_Desc = {
    Text = "Đạt được 3 trận thắng trong mùa giải này"
  },
  Task_77676_Name = {
    Text = "3 trận thắng"
  },
  Task_77677_Desc = {
    Text = "Đạt được tổng cộng 6 trận thắng trong mùa giải này"
  },
  Task_77677_Name = {Text = "6 thắng"},
  Task_78106_Desc = {
    Text = "Sử dụng \"Vòng tròn · Ramona\" giành được 6 chiến thắng"
  },
  Task_78107_Desc = {
    Text = "Sử dụng \"ánh mắt của Isara U\"để giành 6 chiến thắng"
  },
  Task_78108_Desc = {
    Text = "Dùng \"sự kiên cường\"đạt được 6 chiến thắng"
  },
  Task_78109_Desc = {
    Text = "Sử dụng \"Erika\"để đạt được 10 chiến thắng"
  },
  Task_78112_Desc = {
    Text = "Sử dụng \"Lily\"đạt được 6 chiến thắng"
  },
  Task_78113_Desc = {
    Text = "Sử dụng \"Giấc mơ mùa hè\"để đạt được 6 chiến thắng"
  },
  Task_78114_Desc = {
    Text = "Sử dụng \"tất cả những gì thuộc về cô ấy\" giành được 6 chiến thắng"
  },
  Task_78115_Desc = {
    Text = "Sử dụng \"Máu Liên · Shiro\"đạt được 10 chiến thắng"
  },
  Task_78116_Desc = {
    Text = "Sử dụng \"Lắc\"để giành được 10 chiến thắng"
  },
  Task_78117_Desc = {
    Text = "Sử dụng \"Ramona\"để giành chiến thắng 10 lần"
  },
  Task_78118_Desc = {
    Text = "Sử dụng \"Ninh Phi Nga\"để giành được 6 chiến thắng"
  },
  Task_78119_Desc = {
    Text = "Sử dụng \"Dưới danh nghĩa hoa hồng\"để đạt được 6 chiến thắng"
  },
  Task_78120_Desc = {
    Text = "Sử dụng \"Agrippa\"đạt được 6 trận thắng"
  },
  Task_78122_Desc = {
    Text = "Sử dụng \"Miriam\"đạt được 6 chiến thắng"
  },
  Task_78123_Desc = {
    Text = "Sử dụng \"Liz\"để đạt được 6 chiến thắng"
  },
  Task_78124_Desc = {
    Text = "Sử dụng \"trục xuất\"để giành 6 chiến thắng"
  },
  Task_78125_Desc = {
    Text = "Sử dụng \"sủng ái\" giành được 6 lần chiến thắng"
  },
  Task_78126_Desc = {
    Text = "Sử dụng \"người trong gương\" thắng 6 lần"
  },
  Task_78127_Desc = {
    Text = "Sử dụng \"ngày thoát khỏi xiềng xích\"đạt được 6 trận thắng"
  },
  Task_78128_Desc = {
    Text = "Sử dụng \"Đường đi lạc\"để giành được 6 chiến thắng"
  },
  Task_78129_Desc = {
    Text = "Sử dụng \"tinkerer\"để đạt được 6 chiến thắng"
  },
  Task_78130_Desc = {
    Text = "Sử dụng \"Thời khắc tụ tập\"để giành được 6 chiến thắng"
  },
  Task_78131_Desc = {
    Text = "Sử dụng \"Pandia\"để giành 6 chiến thắng"
  },
  Task_78132_Desc = {
    Text = "Sử dụng \"Salvador\"để đạt được 10 chiến thắng"
  },
  Task_78133_Desc = {
    Text = "Sử dụng \"Giấc mơ Biển\"đạt được 6 chiến thắng"
  },
  Task_78134_Desc = {
    Text = "Sử dụng \"Cánh cửa Sự thật\"để giành được 6 chiến thắng"
  },
  Task_78135_Desc = {
    Text = "Sử dụng \"điên cuồng\" thắng 6 lần"
  },
  Task_78137_Desc = {
    Text = "Sử dụng \"vây đau đớn\"đạt được 6 chiến thắng"
  },
  Task_78138_Desc = {
    Text = "Sử dụng \"Hiro\"để đạt được 10 chiến thắng"
  },
  Task_78139_Desc = {
    Text = "Thể thức tỉnh"
  },
  Task_78140_Desc = {
    Text = "Sử dụng \"24\"để giành 6 chiến thắng"
  },
  Task_78141_Desc = {
    Text = "Sử dụng \"Kassia\"đạt được 6 chiến thắng"
  },
  Task_78142_Desc = {
    Text = "Dùng \"Tà Vy\" giành được 6 chiến thắng"
  },
  Task_78143_Desc = {
    Text = "Sử dụng \"Goliath\"để đạt được 6 chiến thắng"
  },
  Task_78144_Desc = {
    Text = "Sử dụng \"24\"để đạt được 10 lần chiến thắng"
  },
  Task_78145_Desc = {
    Text = "Sử dụng \"bảng đá thần ngôn\"để đạt được 6 chiến thắng"
  },
  Task_78146_Desc = {
    Text = "Sử dụng \"Bản giao hưởng vĩnh hằng\"để đạt được 6 chiến thắng"
  },
  Task_78147_Desc = {
    Text = "Sử dụng \"trừng phạt\"đạt được 6 lần chiến thắng"
  },
  Task_78148_Desc = {
    Text = "Sử dụng \"Dấu hiệu thần thánh xuất hiện\"đạt được 6 lần chiến thắng"
  },
  Task_78149_Desc = {
    Text = "Sử dụng \"câu cuối thi thư\"để đạt được 6 chiến thắng"
  },
  Task_78150_Desc = {
    Text = "Sử dụng \"búp bê lạc trong hư vô\"đạt được 6 lần chiến thắng"
  },
  Task_78151_Desc = {
    Text = "Sử dụng \"tiệc thầm lặng\"đạt được 6 chiến thắng"
  },
  Task_78152_Desc = {
    Text = "Sử dụng \"sức mạnh thành tâm\"để đạt được 6 chiến thắng"
  },
  Task_78153_Desc = {
    Text = "Sử dụng \"tulô\"để đạt được 10 chiến thắng"
  },
  Task_78154_Desc = {
    Text = "Sử dụng \"quyết tâm của cá tuyết bạc\" và giành được 6 chiến thắng"
  },
  Task_78155_Desc = {
    Text = "Sử dụng \"tham lam\"để giành chiến thắng 6 lần"
  },
  Task_78159_Desc = {
    Text = "Sử dụng \"Minh Ngộ\"đạt được 6 lần chiến thắng"
  },
  Task_78160_Desc = {
    Text = "Sử dụng \"diện mạo thật của sương xám\"đạt được 6 lần chiến thắng"
  },
  Task_78161_Desc = {
    Text = "Sử dụng \"Tiệc máu thịt\" thắng 6 lần"
  },
  Task_78162_Desc = {
    Text = "Sử dụng \"Wenkel\"đạt được 6 trận thắng"
  },
  Task_78163_Desc = {
    Text = "Sử dụng \"trăm vạn con mắt của thú cưng\" thắng 6 lần"
  },
  Task_78164_Desc = {
    Text = "Sử dụng \"thì thầm\"để giành 6 chiến thắng"
  },
  Task_78166_Desc = {
    Text = "Sử dụng \"Đóa\"đạt được 6 lần chiến thắng"
  },
  Task_78168_Desc = {
    Text = "Sử dụng \"Agrippa\" giành được 10 chiến thắng"
  },
  Task_78169_Desc = {
    Text = "Sử dụng \"lơ-tan\"để giành được 10 chiến thắng"
  },
  Task_78170_Desc = {
    Text = "Sử dụng \"Goliath\"để đạt được 10 chiến thắng"
  },
  Task_78171_Desc = {
    Text = "Sử dụng \"chìm vào màu đỏ thẫm\" thắng 6 trận liên tiếp"
  },
  Task_78172_Desc = {
    Text = "Sử dụng \"Pandia\"để giành được 10 chiến thắng"
  },
  Task_78173_Desc = {
    Text = "Sử dụng \"Đồ ăn tham lam ngụ ngôn\"để đạt được 6 chiến thắng"
  },
  Task_78174_Desc = {
    Text = "Sử dụng \"bánh xe số phận\"để giành được 6 chiến thắng"
  },
  Task_78175_Desc = {
    Text = "Sử dụng \"cắt và thương tổn\"để giành được 6 chiến thắng"
  },
  Task_78176_Desc = {
    Text = "Sử dụng \"Bài ca ngợi của Thần vương\"để đạt được 6 chiến thắng"
  },
  Task_78177_Desc = {
    Text = "Sử dụng \"tan chảy·đóa\"để đạt được 10 chiến thắng"
  },
  Task_78178_Desc = {
    Text = "Sử dụng \"Reia\" giành được 6 chiến thắng"
  },
  Task_78179_Desc = {
    Text = "vòng mệnh"
  },
  Task_78180_Desc = {
    Text = "Dùng \"Hiro\"để đạt 6 chiến thắng"
  },
  Task_78181_Desc = {
    Text = "Sử dụng \"Đêm đông hồi ức\" giành được 6 trận thắng"
  },
  Task_78182_Desc = {
    Text = "Sử dụng \"Bá Đạo của Kẻ Khổng Lồ\" giành được 6 lần chiến thắng"
  },
  Task_78183_Desc = {
    Text = "Sử dụng \"Đào Đen Đá\"để thắng 10 trận"
  },
  Task_78184_Desc = {
    Text = "Sử dụng \"cánh buồm dẫn đường\"đạt được 6 trận thắng"
  },
  Task_78185_Desc = {
    Text = "Sử dụng \"Lắc\"để đạt được 6 chiến thắng"
  },
  Task_78186_Desc = {
    Text = "Sử dụng \"Phiệt\"đạt được 6 chiến thắng"
  },
  Task_78187_Desc = {
    Text = "Sử dụng \"Tay Quên\"để giành được 6 chiến thắng"
  },
  Task_78188_Desc = {
    Text = "Sử dụng \"Thái Di Sơ\"để đạt được 6 chiến thắng"
  },
  Task_78189_Desc = {
    Text = "Sử dụng \"Ninh Phi Nga\" giành được 10 lần chiến thắng"
  },
  Task_78190_Desc = {
    Text = "Sử dụng \"Vanda\"để đạt được 6 chiến thắng"
  },
  Task_78192_Desc = {
    Text = "Sử dụng \"Nốtira\"để đạt được 6 chiến thắng"
  },
  Task_78193_Desc = {
    Text = "Sử dụng \"Ai Jī Sī\" giành được 6 chiến thắng"
  },
  Task_78194_Desc = {
    Text = "Sử dụng \"không thể hoàn thành phép tính\" thắng 6 lần"
  },
  Task_78196_Desc = {
    Text = "Sử dụng \"luật lệ của nữ hoàng\"để đạt được 6 chiến thắng"
  },
  Task_78197_Desc = {
    Text = "Sử dụng \"Ô Ryta\"đạt được 6 lần chiến thắng"
  },
  Task_78198_Desc = {
    Text = "Sử dụng \"Vòng tròn · Ramona\" giành được 10 chiến thắng"
  },
  Task_78199_Desc = {
    Text = "Sử dụng \"Phục kích trong đêm\"đạt được 6 trận thắng"
  },
  Task_78200_Desc = {
    Text = "Sử dụng \"Máu Liên · Shiro\" thắng 6 trận"
  },
  Task_78201_Desc = {
    Text = "Sử dụng \"vượt qua nỗi đau\"để giành 6 chiến thắng"
  },
  Task_78202_Desc = {
    Text = "Sử dụng \"Kiếm Người Khổng Lồ\"để đạt được 6 chiến thắng"
  },
  Task_78203_Desc = {
    Text = "Sử dụng \"Elva\" giành được 10 trận thắng"
  },
  Task_78204_Desc = {
    Text = "Sử dụng \"điểm giới hạn\"để đạt được 6 chiến thắng"
  },
  Task_78205_Desc = {
    Text = "Sử dụng \"Cái chết của người phụ nữ san hô\"để giành 6 chiến thắng"
  },
  Task_78206_Desc = {
    Text = "Sử dụng \"hạt giống duy nhất\"để giành được 6 chiến thắng"
  },
  Task_78208_Desc = {
    Text = "Sử dụng \"Bài hát ru tiêu thụ\"để giành được 6 chiến thắng"
  },
  Task_78209_Desc = {
    Text = "Sử dụng \"tặng phẩm cho người bạn thân\"để đạt được 6 chiến thắng"
  },
  Task_78210_Desc = {
    Text = "Sử dụng \"tinh thần tập trung cao độ\"đạt được 6 lần chiến thắng"
  },
  Task_78212_Desc = {
    Text = "Sử dụng \"hội chứng ký ức\"để đạt 6 trận thắng"
  },
  Task_78213_Desc = {
    Text = "Sử dụng \"Đào Đen Đá\" và giành được 6 chiến thắng"
  },
  Task_78214_Desc = {
    Text = "Sử dụng \"đợi đến khi tuyết sơn tan\" giành được 6 chiến thắng"
  },
  Task_78216_Desc = {
    Text = "Sử dụng \"hy vọng\"đạt được 6 lần chiến thắng"
  },
  Task_78217_Desc = {
    Text = "Sử dụng \"Đêm tối và Bình minh\"đạt được 6 chiến thắng"
  },
  Task_78218_Desc = {
    Text = "Sử dụng \"Muphí\"để đạt 10 chiến thắng"
  },
  Task_78219_Desc = {
    Text = "Sử dụng \"đổi chỗ không công bằng\" thắng 6 lần"
  },
  Task_78220_Desc = {
    Text = "Sử dụng \"Kho báu của Ô Ryta\"để đạt được 6 chiến thắng"
  },
  Task_78221_Desc = {
    Text = "Dùng \"Ai Jī Sī\"đạt được 10 lần chiến thắng"
  },
  Task_78223_Desc = {
    Text = "Sử dụng \"gậy của bá tước\"để đạt được 6 chiến thắng"
  },
  Task_78224_Desc = {
    Text = "Sử dụng \"dục hải phù trầm\"đạt được 6 chiến thắng"
  },
  Task_78225_Desc = {
    Text = "Sử dụng \"YuUHahi\"đạt được 6 trận thắng"
  },
  Task_78226_Desc = {
    Text = "Sử dụng \"Miriam\"để giành được 10 chiến thắng"
  },
  Task_78227_Desc = {
    Text = "Sử dụng \"Ramona\"đạt được 6 chiến thắng"
  },
  Task_78228_Desc = {
    Text = "Sử dụng \"Trái tim hiệp sĩ\"để giành được 6 chiến thắng"
  },
  Task_78229_Desc = {
    Text = "Sử dụng \"Melt·đóa\"đạt được 6 chiến thắng"
  },
  Task_78230_Desc = {
    Text = "Sử dụng \"đồ sưu tầm quý giá nhất\"để giành 6 chiến thắng"
  },
  Task_78231_Desc = {
    Text = "Sử dụng \"túi hành trình mạo hiểm\"để đạt được 6 chiến thắng"
  },
  Task_78232_Desc = {
    Text = "Sử dụng \"quyện cố\"để đạt được 6 chiến thắng"
  },
  Task_78233_Desc = {
    Text = "Sử dụng Elva để giành được 6 chiến thắng"
  },
  Task_78234_Desc = {
    Text = "Sử dụng \"lời thề cuối cùng\"để đạt được 6 chiến thắng"
  },
  Task_78235_Desc = {
    Text = "Sử dụng \"Ôrla\"để giành được 6 chiến thắng"
  },
  Task_78236_Desc = {
    Text = "Sử dụng \"trong cơn mưa dữ dội\" giành được 6 trận thắng"
  },
  Task_78237_Desc = {
    Text = "Sử dụng \"đóa\"để đạt được 10 chiến thắng"
  },
  Task_78238_Desc = {
    Text = "Sử dụng \"vượt qua cái chết\" giành được 6 chiến thắng"
  },
  Task_78239_Desc = {
    Text = "Sử dụng \"Quái thú Tinh Thiên\"để đạt được 6 chiến thắng"
  },
  Task_78240_Desc = {
    Text = "Sử dụng \"Gầm thét của Máu và Cát\"để giành được 6 chiến thắng"
  },
  Task_78241_Desc = {
    Text = "Sử dụng \"Hồi Mắt Hồ Điền\"để giành được 6 lần chiến thắng"
  },
  Task_78242_Desc = {
    Text = "Sử dụng \"Jenkin\"đạt được 10 chiến thắng"
  },
  Task_78243_Desc = {
    Text = "Mật lệnh"
  },
  Task_78244_Desc = {
    Text = "Sử dụng \"Hậu duệ Nhợt nhạt\"để đạt được 6 chiến thắng"
  },
  Task_78245_Desc = {
    Text = "Sử dụng \"Kẻ khắc sét\"để giành được 6 chiến thắng"
  },
  Task_78246_Desc = {
    Text = "Sử dụng \"Hamlin\"để giành được 6 chiến thắng"
  },
  Task_78247_Desc = {
    Text = "Sử dụng \"Ôrla\" thắng 10 trận"
  },
  Task_78248_Desc = {
    Text = "Sử dụng \"Phân giải lõi\"đạt được 6 lần chiến thắng"
  },
  Task_78249_Desc = {
    Text = "Sử dụng \"thần kinh hoang tưởng\"để giành 6 trận thắng"
  },
  Task_78250_Desc = {
    Text = "Sử dụng \"Sự ra đời bí mật\"để giành được 6 chiến thắng"
  },
  Task_78251_Desc = {
    Text = "Dùng \"Ô Ryta\"đạt được 10 lần chiến thắng"
  },
  Task_78252_Desc = {
    Text = "Sử dụng \"Muphí\"để đạt được 6 chiến thắng"
  },
  Task_78253_Desc = {
    Text = "Sử dụng \"tấm lòng bạc nguyên bản\"để đạt được 6 chiến thắng"
  },
  Task_78254_Desc = {
    Text = "Sử dụng \"tulô\"để giành 6 chiến thắng"
  },
  Task_78255_Desc = {
    Text = "Dùng \"sơn\"đạt được 6 lần chiến thắng"
  },
  Task_78256_Desc = {
    Text = "Sử dụng \"Jenkin\"đạt được 6 trận thắng"
  },
  Task_78257_Desc = {
    Text = "Sử dụng \"Wenkel\" giành được 10 chiến thắng"
  },
  Task_78258_Desc = {
    Text = "Sử dụng \"Vanda\"để đạt được 10 lần chiến thắng"
  },
  Task_78261_Desc = {
    Text = "Sử dụng \"Đồng hồ ngược dòng thời gian\"để đạt được 6 trận thắng"
  },
  Task_78262_Desc = {
    Text = "Sử dụng \"Chiến thắng của hoa hồng\" thắng 6 lần"
  },
  Task_78263_Desc = {
    Text = "Sử dụng \"Orci\"để giành được 10 chiến thắng"
  },
  Task_78264_Desc = {
    Text = "Sử dụng \"Pháp Luân Tư\"để giành được 6 chiến thắng"
  },
  Task_78265_Desc = {
    Text = "Sử dụng \"Phiệt\"để đạt được 10 chiến thắng"
  },
  Task_78266_Desc = {
    Text = "Sử dụng \"Hamlin\"để đạt được 10 chiến thắng"
  },
  Task_78267_Desc = {
    Text = "Sử dụng \"Từ Bi Dưỡng\"để thắng 6 trận"
  },
  Task_78269_Desc = {
    Text = "Sử dụng \"sự phân tích cái chết\"để giành 6 chiến thắng"
  },
  Task_78270_Desc = {
    Text = "Sử dụng \"thành thục\"để giành chiến thắng 6 lần"
  },
  Task_78272_Desc = {
    Text = "Sử dụng \"thông tin chính là sức sống\"để giành được 6 chiến thắng"
  },
  Task_78273_Desc = {
    Text = "Sử dụng \"Ôm ấp ăn mòn xương\"để giành 6 chiến thắng"
  },
  Task_78274_Desc = {
    Text = "Sử dụng \"sơn\"để giành 10 chiến thắng"
  },
  Task_78275_Desc = {
    Text = "Sử dụng \"Giấc ngủ dưới băng\"để đạt được 6 chiến thắng"
  },
  Task_78276_Desc = {
    Text = "Sử dụng \"Erika\"để đạt được 6 chiến thắng"
  },
  Task_78277_Desc = {
    Text = "Sử dụng \"vòng quay ẩn thế\"đạt được 6 lần chiến thắng"
  },
  Task_78278_Desc = {
    Text = "Sử dụng \"35mm ma thuật\"để giành 6 chiến thắng"
  },
  Task_78279_Desc = {
    Text = "Sử dụng \"tiếng nói trong tâm trí\"để giành được 6 chiến thắng"
  },
  Task_78280_Desc = {
    Text = "Sử dụng \"thời gian may mắn\"để giành được 6 chiến thắng"
  },
  Task_78281_Desc = {
    Text = "Sử dụng \"Gia Lân\" đạt được 10 lần chiến thắng"
  },
  Task_78282_Desc = {
    Text = "Sử dụng \"Tà Vy\"để giành chiến thắng 10 lần"
  },
  Task_78283_Desc = {
    Text = "Sử dụng \"Yū U Hahī\"để đạt được 10 chiến thắng"
  },
  Task_78284_Desc = {
    Text = "Sử dụng Liz để đạt được 10 chiến thắng"
  },
  Task_78286_Desc = {
    Text = "Dùng \"tường thành của trái tim\"đạt được 6 trận thắng"
  },
  Task_78287_Desc = {
    Text = "Sử dụng \"Kassia\"đạt được 10 chiến thắng"
  },
  Task_78288_Desc = {
    Text = "Sử dụng \"dị thể hồi thực\"đạt được 6 lần chiến thắng"
  },
  Task_78289_Desc = {
    Text = "Sử dụng \"Buổi biểu diễn bất tận\"đạt được 6 lần chiến thắng"
  },
  Task_78290_Desc = {
    Text = "Sử dụng \"Khổ Chú Phược\"đạt được 6 lần chiến thắng"
  },
  Task_78291_Desc = {
    Text = "Sử dụng \"Hilaster\"để đạt được 10 chiến thắng"
  },
  Task_78292_Desc = {
    Text = "Sử dụng \"không gian không tồn tại\"để đạt được 6 chiến thắng"
  },
  Task_78294_Desc = {
    Text = "Sử dụng \"tinkerer\"để giành được 10 chiến thắng"
  },
  Task_78295_Desc = {
    Text = "Sử dụng \"Pháp Luân Tư\"đạt 10 chiến thắng"
  },
  Task_78296_Desc = {
    Text = "Sử dụng \"Lily\"đạt được 10 lần chiến thắng"
  },
  Task_78297_Desc = {
    Text = "Sử dụng \"sự vĩnh cửu ngắn ngủi\"đạt được 6 lần chiến thắng"
  },
  Task_78298_Desc = {
    Text = "Sử dụng \"hoạt tính\"để giành được 6 chiến thắng"
  },
  Task_78299_Desc = {
    Text = "Dùng \"Nốtira\"để đạt được 10 chiến thắng"
  },
  Task_78301_Desc = {
    Text = "Sử dụng \"Salvador\"để đạt được 6 chiến thắng"
  },
  Task_78303_Desc = {
    Text = "Sử dụng \"hút\"để giành 6 chiến thắng"
  },
  Task_78304_Desc = {
    Text = "Sử dụng \"Kẻ khắc sét\" giành 10 chiến thắng"
  },
  Task_78305_Desc = {
    Text = "Dùng \"Orci\"đạt được 6 lần chiến thắng"
  },
  Task_78306_Desc = {
    Text = "Sử dụng \"nhiệm vụ\"để giành 6 chiến thắng"
  },
  Task_78307_Desc = {
    Text = "Chơi với \"Sorrel\"đạt được 10 lần chiến thắng"
  },
  Task_78308_Desc = {
    Text = "Sử dụng \"Ma thuật Vui vẻ\"đạt được 6 chiến thắng"
  },
  Task_78309_Desc = {
    Text = "Sử dụng \"động sát\"để đạt được 6 chiến thắng"
  },
  Task_78310_Desc = {
    Text = "Sử dụng \"Hilaster\"để đạt được 6 chiến thắng"
  },
  Task_78313_Desc = {
    Text = "Sử dụng \"Emergence\"để đạt được 6 chiến thắng"
  },
  Task_78314_Desc = {
    Text = "Sử dụng \"Reia\"để giành được 10 chiến thắng"
  },
  Task_78315_Desc = {
    Text = "Sử dụng \"bài hát bị trói buộc\"đạt được 6 chiến thắng"
  },
  Task_78316_Desc = {
    Text = "Dùng \"Sorrel\"để giành 6 chiến thắng"
  },
  Task_78317_Desc = {
    Text = "Sử dụng \"Gia Lân\" thắng 6 lần"
  },
  Task_78318_Desc = {
    Text = "Xuất bài"
  },
  Task_78319_Desc = {
    Text = "Sử dụng \"lơ tan\"đạt được 6 chiến thắng"
  },
  Task_78320_Desc = {
    Text = "Sử dụng \"món quà mục nát\" giành được 6 chiến thắng"
  },
  Task_78321_Desc = {
    Text = "Sử dụng \"Thái Di Sơ\" giành được 10 chiến thắng"
  },
  Task_78322_Desc = {
    Text = "Sử dụng \"Memory Spiral\"để giành chiến thắng 6 lần"
  },
  Task_78326_Desc = {
    Text = "Katie Gula tỷ lệ đồng điều ở cấp 10"
  },
  Task_78327_Desc = {
    Text = "Afrugomon tỷ lệ đồng điều đạt cấp độ 10"
  },
  Task_78328_Desc = {
    Text = "Polyx tỷ lệ đồng điều đạt cấp 10"
  },
  Task_78329_Desc = {
    Text = "Tỷ lệ đồng điều của kền kền đạt mức 10"
  },
  Task_78332_Desc = {
    Text = "Lantigos tỷ lệ đồng điều ở cấp độ 10"
  },
  Task_78333_Desc = {
    Text = "Caraboo tỷ lệ đồng điều đạt đến cấp 10"
  },
  Task_78334_Desc = {
    Text = "Cophesont tỷ lệ đồng điều đạt cấp 10"
  },
  Task_78336_Desc = {
    Text = "Tỷ lệ đồng điều của Arachne đạt mức 10"
  },
  Task_78338_Desc = {
    Text = "Pháp vương đen đạt cấp 10 của tỷ lệ đồng điều"
  },
  Task_78339_Desc = {
    Text = "Chim Satake đạt tỷ lệ đồng điều cấp 10"
  },
  Task_78340_Desc = {
    Text = "Tỷ lệ đồng điều Pickman đạt cấp 10"
  },
  Task_78341_Desc = {
    Text = "Clementine đạt tỷ lệ đồng điều cấp 10"
  },
  Task_78342_Desc = {
    Text = "Cas-toe-lơ tỷ lệ đồng điều đạt cấp 10"
  },
  Task_78366_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78367_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78368_Desc = {
    Text = "Khi nhận được chim Shatruk, khởi linh cấp 6"
  },
  Task_78368_Name = {
    Text = "Khi nhận được chim Shatruk, khởi linh cấp 6"
  },
  Task_78368_UnlockCondDesc = {
    Text = "Hoạt động @ Gói quà khởi linh thân thể được đánh thức Chatak mùa hè 2"
  },
  Task_78369_Desc = {
    Text = "Nhận Katie Gula khi Khởi Linh cấp 6"
  },
  Task_78369_Name = {
    Text = "Nhận Katie Gula khi Khởi Linh cấp 6"
  },
  Task_78369_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà khởi linh Katie Gula 2"
  },
  Task_78370_Desc = {
    Text = "Nhận được chim Shatruk sau khi đạt cấp độ khởi linh 2"
  },
  Task_78370_Name = {
    Text = "Nhận được chim Shatruk sau khi đạt cấp độ khởi linh 2"
  },
  Task_78370_UnlockCondDesc = {
    Text = "Hoạt động @ Gói quà khởi linh thân thể được đánh thức Chatak mùa hè 2"
  },
  Task_78371_Desc = {
    Text = "Nhận Katie Gula và khởi linh cấp 2"
  },
  Task_78371_Name = {
    Text = "Nhận Katie Gula và khởi linh cấp 2"
  },
  Task_78371_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà khởi linh Katie Gula 2"
  },
  Task_78372_Desc = {
    Text = "Khi khởi linh 2, nhận được Pollux"
  },
  Task_78372_Name = {
    Text = "Khi khởi linh 2, nhận được Pollux"
  },
  Task_78372_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà khởi linh thân thể được đánh thức Polux 2"
  },
  Task_78373_Desc = {
    Text = "Nhận được Pollux khi đạt đến khởi linh cấp 6"
  },
  Task_78373_Name = {
    Text = "Nhận được Pollux khi đạt đến khởi linh cấp 6"
  },
  Task_78373_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà khởi linh thân thể được đánh thức Polux 2"
  },
  Task_78375_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78379_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78380_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78382_Desc = {
    Text = "Nhận Arachne khi khởi linh 6"
  },
  Task_78382_Name = {
    Text = "Nhận Arachne khi khởi linh 6"
  },
  Task_78382_UnlockCondDesc = {
    Text = "Sự kiện @Gói quà khởi linh thân thể được đánh thức Arachne 2"
  },
  Task_78383_Desc = {
    Text = "Nhận được Arachne khi khởi linh hai"
  },
  Task_78383_Name = {
    Text = "Nhận được Arachne khi khởi linh hai"
  },
  Task_78383_UnlockCondDesc = {
    Text = "Sự kiện @Gói quà khởi linh thân thể được đánh thức Arachne 2"
  },
  Task_78384_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78385_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78390_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78391_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78394_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78395_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78396_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78397_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78400_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78401_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78402_Desc = {
    Text = "Nhận được Pickman khi khởi linh cấp 6"
  },
  Task_78402_Name = {
    Text = "Nhận được Pickman khi khởi linh cấp 6"
  },
  Task_78402_UnlockCondDesc = {
    Text = "Hoạt động @thân thể được đánh thức Pickman khởi linh quà tặng 2"
  },
  Task_78403_Desc = {
    Text = "Nhận được Pickman với khởi linh 2"
  },
  Task_78403_Name = {
    Text = "Nhận được Pickman với khởi linh 2"
  },
  Task_78403_UnlockCondDesc = {
    Text = "Hoạt động @thân thể được đánh thức Pickman khởi linh quà tặng 2"
  },
  Task_78404_Desc = {
    Text = "Khởi linh 2 khi nhận Cas-tơ-lơ"
  },
  Task_78404_Name = {
    Text = "Khởi linh 2 khi nhận Cas-tơ-lơ"
  },
  Task_78404_UnlockCondDesc = {
    Text = "Hoạt động - Gói quà thân thể được đánh thức Cas-tơ-lơ khởi linh"
  },
  Task_78405_Desc = {
    Text = "Nhận Cas-tơ-lơ khi khởi linh cấp 6"
  },
  Task_78405_Name = {
    Text = "Nhận Cas-tơ-lơ khi khởi linh cấp 6"
  },
  Task_78405_UnlockCondDesc = {
    Text = "Hoạt động - Gói quà thân thể được đánh thức Cas-tơ-lơ khởi linh"
  },
  Task_78409_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78415_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78416_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78418_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78419_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78421_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78423_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78424_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78426_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78429_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78430_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78431_Desc = {
    Text = "Nhận được Caraboo khi khởi linh 2"
  },
  Task_78431_Name = {
    Text = "Nhận được Caraboo khi khởi linh 2"
  },
  Task_78431_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà Caraboo thân thể được đánh thức khởi linh 2"
  },
  Task_78432_Desc = {
    Text = "Nhận được Caraboo tại cấp độ khởi linh 6"
  },
  Task_78432_Name = {
    Text = "Nhận được Caraboo tại cấp độ khởi linh 6"
  },
  Task_78432_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà Caraboo thân thể được đánh thức khởi linh 2"
  },
  Task_78435_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78436_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78437_Desc = {
    Text = "Khi khởi linh 2, nhận được Afrugomon"
  },
  Task_78437_Name = {
    Text = "Khi khởi linh 2, nhận được Afrugomon"
  },
  Task_78437_UnlockCondDesc = {
    Text = "Hoạt động bao gồm thân thể được đánh thức Afrugomon khởi linh, quà tặng 2 hoạt động"
  },
  Task_78438_Desc = {
    Text = "Khởi linh cấp 2 khi nhận Clementine"
  },
  Task_78438_Name = {
    Text = "Khởi linh cấp 2 khi nhận Clementine"
  },
  Task_78438_UnlockCondDesc = {
    Text = "Hoạt động Gói quà Clementine thân thể được đánh thức khởi linh 2 hoạt động"
  },
  Task_78440_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78441_Desc = {
    Text = "Khi nhận được Clementine, khởi linh cấp 6"
  },
  Task_78441_Name = {
    Text = "Khi nhận được Clementine, khởi linh cấp 6"
  },
  Task_78441_UnlockCondDesc = {
    Text = "Hoạt động Gói quà Clementine thân thể được đánh thức khởi linh 2 hoạt động"
  },
  Task_78446_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78447_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78449_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78450_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78451_Desc = {
    Text = "Khi nhận được Pharaoh đen, khởi linh 2"
  },
  Task_78451_Name = {
    Text = "Khi nhận được Pharaoh đen, khởi linh 2"
  },
  Task_78451_UnlockCondDesc = {
    Text = "Hoạt động @thân thể được đánh thức Pharaoh đen khởi linh lễ phẩm 2 hoạt động"
  },
  Task_78453_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78458_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78459_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78460_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78466_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78468_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78470_Desc = {
    Text = "Khi khởi linh 6, nhận Pharaoh Đen"
  },
  Task_78470_Name = {
    Text = "Khi khởi linh 6, nhận Pharaoh Đen"
  },
  Task_78470_UnlockCondDesc = {
    Text = "Hoạt động @thân thể được đánh thức Pharaoh đen khởi linh lễ phẩm 2 hoạt động"
  },
  Task_78476_Desc = {
    Text = "Khi nhận được Lantigos, khởi linh cấp 6"
  },
  Task_78476_Name = {
    Text = "Khi nhận được Lantigos, khởi linh cấp 6"
  },
  Task_78476_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà thân thể được đánh thức Lan Đề Cương Khởi Linh 2"
  },
  Task_78477_Desc = {
    Text = "Khi nhận được Lantigos, kích hoạt Khởi Linh 2"
  },
  Task_78477_Name = {
    Text = "Khi nhận được Lantigos, kích hoạt Khởi Linh 2"
  },
  Task_78477_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà thân thể được đánh thức Lan Đề Cương Khởi Linh 2"
  },
  Task_78481_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78483_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78484_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78485_Desc = {
    Text = "Nhận được kền kền và khởi linh 2"
  },
  Task_78485_Name = {
    Text = "Nhận được kền kền và khởi linh 2"
  },
  Task_78485_UnlockCondDesc = {
    Text = "Hoạt động - thân thể được đánh thức kền kền khởi linh quà tặng 2 hoạt động"
  },
  Task_78486_Desc = {
    Text = "Khi nhận được kền kền, kích hoạt khởi linh cấp 6"
  },
  Task_78486_Name = {
    Text = "Khi nhận được kền kền, kích hoạt khởi linh cấp 6"
  },
  Task_78486_UnlockCondDesc = {
    Text = "Hoạt động - thân thể được đánh thức kền kền khởi linh quà tặng 2 hoạt động"
  },
  Task_78487_Desc = {
    Text = "Nhận được Afrugomon khi khởi linh cấp 6"
  },
  Task_78487_Name = {
    Text = "Nhận được Afrugomon khi khởi linh cấp 6"
  },
  Task_78487_UnlockCondDesc = {
    Text = "Hoạt động bao gồm thân thể được đánh thức Afrugomon khởi linh, quà tặng 2 hoạt động"
  },
  Task_78488_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78489_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78492_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78493_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78495_Desc = {
    Text = "Nhận được Keposhante tại cấp độ khởi linh 6"
  },
  Task_78495_Name = {
    Text = "Nhận được Keposhante tại cấp độ khởi linh 6"
  },
  Task_78495_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà khởi linh thân thể được đánh thức Kepshante 2"
  },
  Task_78496_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78497_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78499_Desc = {
    Text = "Nhận được Keposơn khi khởi linh 2"
  },
  Task_78499_Name = {
    Text = "Nhận được Keposơn khi khởi linh 2"
  },
  Task_78499_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà khởi linh thân thể được đánh thức Kepshante 2"
  },
  Task_78573_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78574_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78576_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78577_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78599_Desc = {
    Text = "Thắng cuộc chiến cuối cùng trong 13 lượt"
  },
  Task_78599_Name = {
    Text = "Thắng cuộc chiến cuối cùng trong 13 lượt"
  },
  Task_78600_Desc = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 14 turn"
  },
  Task_78600_Name = {
    Text = "Cuộc chiến cuối cùng giành chiến thắng trong vòng 14 turn"
  },
  Task_78718_Desc = {
    Text = "Sử dụng thân thể được đánh thức của giới vực thịt máu để giành chiến thắng 2 lần tại \"ký ức mã hóa\""
  },
  Task_78719_Desc = {
    Text = "Sử dụng thân thể được đánh thức trong giới vực hỗn loạn để chiến thắng 2 lần trong \"ký ức mã hóa\""
  },
  Task_78720_Desc = {
    Text = "Sử dụng thân thể được đánh thức của vùng giới sâu thẳm để chiến thắng 2 lần trong \"mã ký ức\""
  },
  Task_78721_Desc = {
    Text = "Sử dụng thân thể được đánh thức siêu việt để chiến thắng 2 lần trong \"ký ức mã hóa\""
  },
  Task_78723_Desc = {
    Text = "Tiếng Vo Ve Trong Bóng Tối II"
  },
  Task_78724_Desc = {
    Text = "Sóng và Tiếng Côn Trùng I"
  },
  Task_78725_Desc = {
    Text = "Triều tối vọng âm côn trùng VII"
  },
  Task_78726_Desc = {
    Text = "Triều tối tiếng kêu của côn trùng V"
  },
  Task_78727_Desc = {
    Text = "Âm triều côn minh·miễn phí"
  },
  Task_78728_Desc = {
    Text = "Triều tối tiếng côn trùng kêu trong đêm VI"
  },
  Task_78729_Desc = {
    Text = "Sóng Côn Trùng III"
  },
  Task_78730_Desc = {
    Text = "Sóng Tiếng Côn Trùng IV"
  },
  Task_78740_Desc = {
    Text = "Khi nhận Chúa tể đang ngủ, khởi linh cấp 6"
  },
  Task_78740_Name = {
    Text = "Khi nhận Chúa tể đang ngủ, khởi linh cấp 6"
  },
  Task_78740_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà khởi linh nguồn gốc thân thể được đánh thức"
  },
  Task_78741_Desc = {
    Text = "Nguồn gốc của Chúa tể ngủ say đạt tỷ lệ đồng điều cấp 10"
  },
  Task_78742_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78743_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78745_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78746_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78748_Desc = {
    Text = "Khi nhận được Chủ nguồn gốc đang ngủ say, kích hoạt khởi linh cấp 2"
  },
  Task_78748_Name = {
    Text = "Khi nhận được Chủ nguồn gốc đang ngủ say, kích hoạt khởi linh cấp 2"
  },
  Task_78748_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà khởi linh nguồn gốc thân thể được đánh thức"
  },
  Task_78763_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78764_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78766_Desc = {
    Text = "Nhận được nguồn gốc nàng thơ biển sâu khi khởi linh 2"
  },
  Task_78766_Name = {
    Text = "Nhận được nguồn gốc nàng thơ biển sâu khi khởi linh 2"
  },
  Task_78766_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà khởi linh Nàng tiên cá biển sâu nguồn gốc thân thể được đánh thức 2"
  },
  Task_78767_Desc = {
    Text = "Khi đạt được nguồn gốc biển sâu Thục Nữ, kích hoạt Khởi Linh cấp 6"
  },
  Task_78767_Name = {
    Text = "Khi đạt được nguồn gốc biển sâu Thục Nữ, kích hoạt Khởi Linh cấp 6"
  },
  Task_78767_UnlockCondDesc = {
    Text = "Sự kiện @ Gói quà khởi linh Nàng tiên cá biển sâu nguồn gốc thân thể được đánh thức 2"
  },
  Task_78768_Desc = {
    Text = "Nguồn gốc biển sâu quý cô đạt cấp 10 tỷ lệ đồng điều"
  },
  Task_78769_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_78770_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_79259_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_79259_Name = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_79283_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_79283_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_79284_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_79284_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_79285_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_79285_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_79286_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_79286_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_79287_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_79287_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_79288_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_79288_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_79289_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_79289_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_79290_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_79290_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_79291_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_79291_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_79292_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_79292_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_79304_Desc = {
    Text = "Sử dụng \"gặp gỡ thuần khiết\"để giành chiến thắng 1 lần"
  },
  Task_79305_Desc = {
    Text = "Sử dụng \"Nhật Lạc\" thắng 1 lần"
  },
  Task_79306_Desc = {
    Text = "Sử dụng \"Hư Vô Dịch Bệnh\"để đạt 1 chiến thắng"
  },
  Task_79307_Desc = {
    Text = "Sử dụng \"xoay, xoay\"để giành 6 chiến thắng"
  },
  Task_79308_Desc = {
    Text = "Sử dụng \"Trí thông minh của Chuột Chuột\"để giành được 1 chiến thắng"
  },
  Task_79309_Desc = {
    Text = "Sử dụng \"Gặp gỡ thuần khiết\"để giành chiến thắng 3 lần"
  },
  Task_79310_Desc = {
    Text = "Sử dụng \"nụ hôn cháy bỏng\"để đạt được 6 chiến thắng"
  },
  Task_79311_Desc = {
    Text = "Sử dụng \"Ngày Tàn\"để đạt được 3 chiến thắng"
  },
  Task_79312_Desc = {
    Text = "Sử dụng \"cây gậy của người chăn cừu\"đạt được 3 chiến thắng"
  },
  Task_79313_Desc = {
    Text = "Sử dụng \"lễ tang bất diệt\" giành được một chiến thắng"
  },
  Task_79314_Desc = {
    Text = "Sử dụng \"trí tuệ của chuột chuột\"để giành được 3 chiến thắng"
  },
  Task_79315_Desc = {
    Text = "Sử dụng \"quyết tâm của dãy núi\" giành được 3 trận thắng"
  },
  Task_79316_Desc = {
    Text = "Sử dụng \"ước nguyện nhỏ nhỏ\"để đạt được 3 chiến thắng"
  },
  Task_79317_Desc = {
    Text = "Sử dụng \"linh hồn sinh ra\"để giành được 1 chiến thắng"
  },
  Task_79318_Desc = {
    Text = "Sử dụng \"Lời gọi của biển sâu\"để giành được 6 chiến thắng"
  },
  Task_79319_Desc = {
    Text = "Sử dụng \"Đại tiệc Hư Hoại\" thắng 6 lần"
  },
  Task_79320_Desc = {
    Text = "Sử dụng \"Phước lành của Các ngôi sao\"để đạt được 3 chiến thắng"
  },
  Task_79321_Desc = {
    Text = "Sử dụng \"Bữa tiệc thối rữa\"đạt 3 chiến thắng"
  },
  Task_79322_Desc = {
    Text = "Sử dụng \"câu trả lời của cánh cửa\"để giành được 1 chiến thắng"
  },
  Task_79323_Desc = {
    Text = "Sử dụng \"cây gậy của người chăn cừu\"để đạt được 6 chiến thắng"
  },
  Task_79324_Desc = {
    Text = "Sử dụng \"Lời Gọi của Biển Sâu\"để giành được 1 chiến thắng"
  },
  Task_79325_Desc = {
    Text = "Sử dụng \"Lời gọi từ Biển sâu\"đạt 3 chiến thắng"
  },
  Task_79326_Desc = {
    Text = "Sử dụng \"Dịch bệnh Hư vô\"để giành được 3 chiến thắng"
  },
  Task_79327_Desc = {
    Text = "Sử dụng \"Bài thơ dâng mùa xuân\"để đạt được 6 chiến thắng"
  },
  Task_79328_Desc = {
    Text = "Sử dụng \"một tiếng súng\"để giành được 1 lần chiến thắng"
  },
  Task_79329_Desc = {
    Text = "Sử dụng \"lễ tang bất diệt\" thắng 3 lần"
  },
  Task_79330_Desc = {
    Text = "Sử dụng \"cánh cửa tửu quán\"để giành được 1 chiến thắng"
  },
  Task_79331_Desc = {
    Text = "Sử dụng \"ám ảnh vĩnh cửu\"đạt được 3 lần chiến thắng"
  },
  Task_79332_Desc = {
    Text = "Sử dụng \"ước nguyện nhỏ nhỏ\"để giành chiến thắng 1 lần"
  },
  Task_79333_Desc = {
    Text = "Sử dụng \"câu trả lời của cánh cửa\"để thắng 6 lần"
  },
  Task_79334_Desc = {
    Text = "Sử dụng \"ngai vàng thanh thạch\"để đạt được 6 chiến thắng"
  },
  Task_79335_Desc = {
    Text = "Sử dụng \"Phước lành của các ngôi sao\"để giành được 1 chiến thắng"
  },
  Task_79336_Desc = {
    Text = "Sử dụng \"sự giác ngộ của dãy núi\"đạt được 6 chiến thắng"
  },
  Task_79337_Desc = {
    Text = "Sử dụng \"Ngày Tàn\"để giành 6 chiến thắng"
  },
  Task_79338_Desc = {
    Text = "Sử dụng \"Akutê của mùa xuân\"đạt được 6 chiến thắng"
  },
  Task_79339_Desc = {
    Text = "Sử dụng \"sự khôn ngoan của chuột con\"để đạt được 6 chiến thắng"
  },
  Task_79340_Desc = {
    Text = "Sử dụng \"bạo thực\"đạt được 6 lần chiến thắng"
  },
  Task_79341_Desc = {
    Text = "Sử dụng \"lễ tang bất diệt\" thắng 6 lần"
  },
  Task_79342_Desc = {
    Text = "Sử dụng \"Lễ hội Biển\"để giành được 6 chiến thắng"
  },
  Task_79343_Desc = {
    Text = "Sử dụng \"tiêm chủng bảo vệ\"để thắng 1 lần"
  },
  Task_79344_Desc = {
    Text = "Sử dụng \"tiêm chủng bảo vệ\"đạt được 3 lần chiến thắng"
  },
  Task_79345_Desc = {
    Text = "Sử dụng \"cánh cửa quán rượu\"để đạt được 3 chiến thắng"
  },
  Task_79346_Desc = {
    Text = "Sử dụng \"Hoa và Thơ của Quá Khứ\"để giành 3 chiến thắng"
  },
  Task_79347_Desc = {
    Text = "Sử dụng \"xoay, xoay\"để giành được 1 lần chiến thắng"
  },
  Task_79348_Desc = {
    Text = "Sử dụng \"mũ rộng vành phù thủy\"để giành 6 chiến thắng"
  },
  Task_79349_Desc = {
    Text = "Sử dụng \"cánh cửa vượt qua hồi tưởng\"đạt được 3 chiến thắng"
  },
  Task_79350_Desc = {
    Text = "Sử dụng \"Chương thứ tư\"để giành được 6 chiến thắng"
  },
  Task_79351_Desc = {
    Text = "Sử dụng \"ngai vàng xanh\" thắng 1 lần"
  },
  Task_79352_Desc = {
    Text = "Sử dụng \"Chương thứ tư\"để giành được 1 chiến thắng"
  },
  Task_79353_Desc = {
    Text = "Sử dụng \"cánh cửa tửu quán\"để đạt được 6 chiến thắng"
  },
  Task_79354_Desc = {
    Text = "Sử dụng \"hư vô dịch bệnh\"để giành 6 chiến thắng"
  },
  Task_79355_Desc = {
    Text = "Sử dụng \"một tiếng súng\"để giành được 6 chiến thắng"
  },
  Task_79356_Desc = {
    Text = "Sử dụng \"mũ rộng vành phù thủy\"đạt được 1 chiến thắng"
  },
  Task_79357_Desc = {
    Text = "Sử dụng \"xoay, xoay\"để giành được 3 chiến thắng"
  },
  Task_79358_Desc = {
    Text = "Sử dụng \"bữa tiệc thối rữa\"đạt được 1 lần chiến thắng"
  },
  Task_79359_Desc = {
    Text = "Sử dụng \"ngai vàng đá xanh\"để đạt 3 chiến thắng"
  },
  Task_79360_Desc = {
    Text = "Sử dụng \"nụ hôn cháy bỏng\"đạt được 3 chiến thắng"
  },
  Task_79361_Desc = {
    Text = "Sử dụng \"linh hồn sinh ra\"để giành được 3 chiến thắng"
  },
  Task_79362_Desc = {
    Text = "Sử dụng \"Chấp niệm Vĩnh Cửu\"để giành chiến thắng 1 lần"
  },
  Task_79363_Desc = {
    Text = "Sử dụng \"cánh cửa vượt qua hồi suyệt\"để giành được 1 lần chiến thắng"
  },
  Task_79364_Desc = {
    Text = "Sử dụng \"nụ hôn cháy bỏng\"đạt được 1 lần chiến thắng"
  },
  Task_79365_Desc = {
    Text = "Sử dụng \"hoa và thơ ca của những ngày xưa cũ\"đạt được 6 trận thắng"
  },
  Task_79366_Desc = {
    Text = "Sử dụng \"Bảo Hộ của Các Vì Sao\"đạt được 6 chiến thắng"
  },
  Task_79367_Desc = {
    Text = "Sử dụng \"Bài thơ dâng mùa xuân\"đạt được 1 chiến thắng"
  },
  Task_79368_Desc = {
    Text = "Sử dụng \"ý chí của dãy núi\"đạt được 1 chiến thắng"
  },
  Task_79369_Desc = {
    Text = "Sử dụng \"Akutê xuân\"đạt được 3 chiến thắng"
  },
  Task_79370_Desc = {
    Text = "Sử dụng \"tiêm phòng bảo vệ\"để đạt được 6 chiến thắng"
  },
  Task_79371_Desc = {
    Text = "Sử dụng \"mũ rộng vành phù thủy\"đạt được 3 chiến thắng"
  },
  Task_79372_Desc = {
    Text = "Sử dụng \"Lễ hội Biển\"để đạt được 3 chiến thắng"
  },
  Task_79373_Desc = {
    Text = "Sử dụng \"Khổng Môn Hồi Tố\"để giành 6 trận thắng"
  },
  Task_79374_Desc = {
    Text = "Sử dụng \"gặp gỡ thuần khiết\" và giành được 6 trận thắng"
  },
  Task_79375_Desc = {
    Text = "Sử dụng \"ước nguyện nhỏ nhỏ\"để đạt được 6 chiến thắng"
  },
  Task_79376_Desc = {
    Text = "Sử dụng \"bạo thực\"đạt được 3 lần chiến thắng"
  },
  Task_79377_Desc = {
    Text = "Sử dụng \"Lễ hội Biển\"để giành được 1 chiến thắng"
  },
  Task_79378_Desc = {
    Text = "Sử dụng \"Chương thứ tư\"để giành 3 chiến thắng"
  },
  Task_79379_Desc = {
    Text = "Sử dụng \"bạo thực\" thắng 1 lần"
  },
  Task_79380_Desc = {
    Text = "Sử dụng \"câu trả lời của cánh cửa\"để giành được 3 chiến thắng"
  },
  Task_79381_Desc = {
    Text = "Sử dụng \"hoa và thơ của quá khứ\"để đạt được một chiến thắng"
  },
  Task_79382_Desc = {
    Text = "Sử dụng \"cây gậy của người chăn cừu\"để đạt được 1 chiến thắng"
  },
  Task_79383_Desc = {
    Text = "Sử dụng \"tiếng súng vang lên\"để giành được 3 chiến thắng"
  },
  Task_79384_Desc = {
    Text = "Sử dụng \"sự sinh thành của linh hồn\"để giành được 6 chiến thắng"
  },
  Task_79385_Desc = {
    Text = "Sử dụng \"Akutê Xuân\"đạt được 1 lần chiến thắng"
  },
  Task_79386_Desc = {
    Text = "Sử dụng \"niềm chấp niệm vĩnh cửu\"đạt được 6 trận thắng"
  },
  Task_79387_Desc = {
    Text = "Sử dụng \"Bài thơ dâng mùa xuân\"đạt được 3 lần chiến thắng"
  },
  Task_79483_Desc = {
    Text = "Chữa trị nỗi sợ·Cõi"
  },
  Task_79484_Desc = {
    Text = "Sử dụng Người đánh thức Vùng biển sâu để thắng 2 lần trong \"Chữa lành nỗi sợ hãi\""
  },
  Task_79485_Desc = {
    Text = "Sử dụng Người đánh thức Vùng biển sâu để thắng 1 lần trong \"Chữa lành nỗi sợ hãi\""
  },
  Task_79486_Desc = {
    Text = "Hoàn thành \"Ký ức phòng khám\"ở bất kỳ độ khó nào"
  },
  Task_79487_Desc = {
    Text = "Sử dụng Người đánh thức Vùng siêu cấp để thắng 2 lần trong \"Chữa lành nỗi sợ hãi\""
  },
  Task_79488_Desc = {
    Text = "Sử dụng Người đánh thức Vùng siêu cấp để thắng 1 lần trong \"Chữa lành nỗi sợ hãi\""
  },
  Task_79489_Desc = {
    Text = "Hoàn thành \"Đức tái sinh\"ở độ khó Điên loạ"
  },
  Task_79490_Desc = {
    Text = "Chữa trị nỗi sợ·Hoàn thành"
  },
  Task_79491_Desc = {
    Text = "Hoàn thành \"Con bướm theo lửa\"ở bất kỳ độ khó nào"
  },
  Task_79492_Desc = {
    Text = "Sử dụng Người đánh thức Vùng thịt để thắng 1 lần trong \"Chữa lành nỗi sợ hãi\""
  },
  Task_79493_Desc = {
    Text = "Sử dụng Người đánh thức Vùng thịt để thắng 2 lần trong \"Chữa lành nỗi sợ hãi\""
  },
  Task_79494_Desc = {
    Text = "Hoàn thành \"Đức tái sinh\"ở bất kỳ độ khó nào"
  },
  Task_79495_Desc = {
    Text = "Hoàn thành \"Thế giới đang cháy\"ở độ khó Điên loạ"
  },
  Task_79496_Desc = {
    Text = "Hoàn thành \"Thời điểm xâm nhập giấc mơ\"ở độ khó Điên loạ"
  },
  Task_79497_Desc = {
    Text = "Hoàn thành \"Ký ức phòng khám\"ở bất kỳ độ khó nào"
  },
  Task_79498_Desc = {
    Text = "Hoàn thành \"Con bướm theo lửa\"ở bất kỳ độ khó nào"
  },
  Task_79499_Desc = {
    Text = "Hoàn thành \"Thế giới đang cháy\"ở bất kỳ độ khó nào"
  },
  Task_79500_Desc = {
    Text = "Chữa trị nỗi sợ·Điên loạn"
  },
  Task_79501_Desc = {
    Text = "Hoàn thành \"Thế giới đang cháy\"ở bất kỳ độ khó nào"
  },
  Task_79502_Desc = {
    Text = "Hoàn thành \"Thời điểm xâm nhập giấc mơ\"ở bất kỳ độ khó nào"
  },
  Task_79503_Desc = {
    Text = "Sử dụng Người đánh thức Vùng hỗn loạn để thắng 1 lần trong \"Chữa lành nỗi sợ hãi\""
  },
  Task_79504_Desc = {
    Text = "Sử dụng Người đánh thức Vùng hỗn loạn để thắng 2 lần trong \"Chữa lành nỗi sợ hãi\""
  },
  Task_79505_Desc = {
    Text = "Hoàn thành \"Đức tái sinh\"ở bất kỳ độ khó nào"
  },
  Task_79506_Desc = {
    Text = "Hoàn thành \"Con bướm theo lửa\"ở độ khó Điên loạ"
  },
  Task_79507_Desc = {
    Text = "Hoàn thành tất cả nhiệm vụ trong \"Chữa trị nỗi sợ·Hoàn thành\""
  },
  Task_79508_Desc = {
    Text = "Hoàn thành \"Thời điểm xâm nhập giấc mơ\"ở bất kỳ độ khó nào"
  },
  Task_79509_Desc = {
    Text = "Hoàn thành \"Ký ức phòng khám\"ở độ khó Điên loạ"
  },
  Task_79747_Desc = {
    Text = "Nhận Clementine"
  },
  Task_79747_Name = {
    Text = "Nhận Clementine"
  },
  Task_80218_Desc = {
    Text = "Đánh bại \"cư dân\" chặn đường"
  },
  Task_80218_Name = {
    Text = "Mục tiêu"
  },
  Task_80219_Desc = {
    Text = "Ngăn chặn \"Nghi thức cuộc sống\""
  },
  Task_80219_Name = {
    Text = "Mục tiêu"
  },
  Task_80220_Desc = {
    Text = "Đánh bại dự ngã của vũ trụ @2"
  },
  Task_80220_Name = {
    Text = "Mục tiêu"
  },
  Task_80221_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_80221_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_80222_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_80222_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_80223_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_80223_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_80224_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_80224_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_80225_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_80225_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_80226_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_80226_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_80227_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_80227_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_80228_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_80228_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_80229_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_80229_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_80230_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_80230_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_80231_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_80231_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_80232_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_80232_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_80233_Desc = {
    Text = "Xác nhận \"Ramona\""
  },
  Task_80233_Name = {
    Text = "Mục tiêu"
  },
  Task_80234_Desc = {
    Text = "Tránh bị đội tuần tra bắt giữ"
  },
  Task_80234_Name = {
    Text = "Mục tiêu"
  },
  Task_80235_Desc = {
    Text = "Tung ra khỏi những \"Clementine\""
  },
  Task_80235_Name = {
    Text = "Mục tiêu"
  },
  Task_80236_Desc = {
    Text = "Hướng đến phòng khám của Clementine"
  },
  Task_80236_Name = {
    Text = "Mục tiêu"
  },
  Task_80237_Desc = {Text = "Về nhà"},
  Task_80237_Name = {
    Text = "Mục tiêu"
  },
  Task_80238_Desc = {
    Text = "Ngăn chặn \"Tiếp nhận\" của Herbert"
  },
  Task_80238_Name = {
    Text = "Mục tiêu"
  },
  Task_80239_Desc = {
    Text = "Giải thoát khỏi cuộc truy đuổi của bác sĩ"
  },
  Task_80239_Name = {
    Text = "Mục tiêu"
  },
  Task_80240_Desc = {
    Text = "Ghi nhớ sâu sắc về Albino"
  },
  Task_80240_Name = {
    Text = "Mục tiêu"
  },
  Task_80241_Desc = {
    Text = "Kiềm chế các bệnh nhân điên cuồng"
  },
  Task_80241_Name = {
    Text = "Mục tiêu"
  },
  Task_80286_Desc = {
    Text = "Hoàn thành chương 2-9 phần Hình tinh"
  },
  Task_80287_Desc = {
    Text = "Hoàn thành chương 2-6 độ khó của phần Hình tinh"
  },
  Task_80288_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"@1@2\""
  },
  Task_80288_Desc2 = {
    Text = "Hoàn thành sự kiện điều tra \"Biến hình\""
  },
  Task_80288_Name2 = {
    Text = "Lắng nghe tiếng ong ong của vũ trụ"
  },
  Task_80289_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"Biến hình\" độ khó"
  },
  Task_80289_Name = {
    Text = "Lắng nghe tiếng ong ong của vũ trụ · Khó khăn"
  },
  Task_80290_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_80291_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_80292_Desc = {
    Text = "Hoàn thành chương \"Biến hình\" phần 2"
  },
  Task_80293_Desc = {
    Text = "Hoàn thành chương \"Biến hình\" độ khó khó của phần 2"
  },
  Task_80294_Desc = {
    Text = "Hoàn thành chương 2-6 độ khó của phần Hình tinh"
  },
  Task_80295_Desc = {
    Text = "Trong cuộc điều tra sự kiện \"@1@2\" cộng hưởng 9 lần"
  },
  Task_80295_Desc2 = {
    Text = "Trong sự kiện điều tra \"Biến đổi\" cộng hưởng 9 lần"
  },
  Task_80295_Name2 = {
    Text = "Biến thể hồi âm III"
  },
  Task_80296_Desc = {
    Text = "Trong cuộc điều tra sự kiện \"@1@2\" gây cộng hưởng 6 lần"
  },
  Task_80296_Desc2 = {
    Text = "Trong việc điều tra sự kiện \"Biến hình\" đã cộng hưởng 6 lần"
  },
  Task_80296_Name2 = {
    Text = "Biến thể hồi âm II"
  },
  Task_80297_Desc = {
    Text = "Trong cuộc điều tra sự kiện \"@1@2\" cảm ứng 3 lần"
  },
  Task_80297_Desc2 = {
    Text = "Trong việc điều tra sự kiện \"Biến hình\" đã cộng hưởng 3 lần"
  },
  Task_80297_Name2 = {
    Text = "Biến thể hồi âm"
  },
  Task_80298_Desc = {
    Text = "Hoàn thành chương 2-9 phần Hình tinh"
  },
  Task_80299_Desc = {
    Text = "Trong cuộc điều tra sự kiện \"@1@2\" cảm ứng 11 lần"
  },
  Task_80299_Desc2 = {
    Text = "Trong sự kiện điều tra \"Biến đổi\" cộng hưởng 11 lần"
  },
  Task_80299_Name2 = {
    Text = "Biến thể hồi âm IV"
  },
  Task_80300_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_80301_Desc = {
    Text = "Hoàn thành chương \"Biến hình\" phần 2"
  },
  Task_80302_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_80303_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_80304_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_80305_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_80306_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_80307_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_80309_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_80310_Desc = {
    Text = "Hoàn thành chương \"Biến hình\" độ khó khó của phần 2"
  },
  Task_80419_Name = {
    Text = "Hoàn thành lại phần sao băng 2_18"
  },
  Task_80433_Desc = {
    Text = "Đạt được tổng cộng 10 trận thắng trong mùa giải này"
  },
  Task_80433_Name = {Text = "10 thắng"},
  Task_80434_Desc = {
    Text = "Đạt được tổng cộng 6 trận thắng trong mùa giải này"
  },
  Task_80434_Name = {Text = "6 thắng"},
  Task_80435_Desc = {
    Text = "Đạt được 3 trận thắng trong mùa giải này"
  },
  Task_80435_Name = {
    Text = "3 trận thắng"
  },
  Task_80436_Desc = {
    Text = "Đạt được tích lũy 1 trận thắng trong mùa giải này"
  },
  Task_80436_Name = {
    Text = "1 trận thắng"
  },
  Task_80993_Desc = {
    Text = "Công cụ dọn dẹp đạt đến"
  },
  Task_80994_Desc = {
    Text = "Hoàn thành bất kỳ 3 nhiệm vụ nào"
  },
  Task_80994_Name = {
    Text = "Hôm nay đã hoàn tất công việc quét dọn!"
  },
  Task_80995_Desc = {
    Text = "Phần thưởng sự kiệ"
  },
  Task_80996_Desc = {
    Text = "Công cụ dọn dẹp đạt đến"
  },
  Task_80997_Desc = {
    Text = "Kiệt sức 100000 hoa hồng vàng"
  },
  Task_80997_Name = {
    Text = "Sắp xếp ba lô"
  },
  Task_80998_Desc = {
    Text = "Công cụ dọn dẹp đạt đến"
  },
  Task_80999_Desc = {
    Text = "Công cụ dọn dẹp đạt đến"
  },
  Task_81000_Desc = {
    Text = "Đăng nhập liên tiếp 6 ngày"
  },
  Task_81001_Desc = {
    Text = "Hoàn thành hoạt động điều tra tùy ý 1 lần"
  },
  Task_81001_Name = {
    Text = "Hồi ức loại bỏ bụi"
  },
  Task_81002_Desc = {
    Text = "Đăng nhập liên tiếp 3 ngày"
  },
  Task_81003_Desc = {
    Text = "Công cụ dọn dẹp đạt đến"
  },
  Task_81004_Desc = {
    Text = "Công cụ dọn dẹp đạt đến"
  },
  Task_81005_Desc = {
    Text = "Công cụ dọn dẹp đạt đến"
  },
  Task_81006_Desc = {
    Text = "Nhiệm vụ sự kiệ"
  },
  Task_81007_Desc = {
    Text = "Hoàn thành 1 lần bẫy"
  },
  Task_81007_Name = {
    Text = "Khử trùng chiều không gian"
  },
  Task_81008_Desc = {
    Text = "Đăng nhập liên tiếp 5 ngày"
  },
  Task_81009_Desc = {
    Text = "Đăng nhập liên tiếp 7 ngày"
  },
  Task_81010_Desc = {
    Text = "Công cụ dọn dẹp đạt đến"
  },
  Task_81011_Desc = {
    Text = "Đăng nhập liên tiếp 1 ngày"
  },
  Task_81012_Desc = {
    Text = "Đăng nhập liên tiếp 4 ngày"
  },
  Task_81013_Desc = {
    Text = "Đăng nhập liên tiếp 2 ngày"
  },
  Task_81014_Desc = {
    Text = "Công cụ dọn dẹp đạt đến"
  },
  Task_81015_Desc = {
    Text = "Công cụ dọn dẹp đạt đến"
  },
  Task_81016_Desc = {
    Text = "Tiêu hao 180 menophin trong đống phế tích hòa tan"
  },
  Task_81016_Name = {
    Text = "Xử lý phân rã"
  },
  Task_81017_Desc = {
    Text = "7 ngày đăng nhập"
  },
  Task_81018_Desc = {
    Text = "Hoàn thành cuộc bùng nổ huyễn tưởng 1 lần"
  },
  Task_81018_Name = {
    Text = "Thông gió giấc mơ"
  },
  Task_81083_Desc = {
    Text = "Du Hải Mê Hành·Điên Loạn"
  },
  Task_81084_Desc = {
    Text = "Vượt qua \"Khúc ca cuối cùng\"ở bất kỳ độ khó nào"
  },
  Task_81085_Desc = {
    Text = "Sử dụng người đánh thức chiều không gian sâu để giành chiến thắng 2 lần trong \"Đại dương lạc lối\""
  },
  Task_81086_Desc = {
    Text = "Vượt qua \"La bàn cũ\"ở bất kỳ độ khó nào"
  },
  Task_81087_Desc = {
    Text = "Sử dụng người đánh thức chiều không gian sâu để giành chiến thắng 1 lần trong \"Đại dương lạc lối\""
  },
  Task_81088_Desc = {
    Text = "Vượt qua \"Khúc ca cuối cùng\"ở bất kỳ độ khó nào"
  },
  Task_81089_Desc = {
    Text = "Vượt qua \"Sổ tay hoa tiêu\"độ khó Điên loạn"
  },
  Task_81090_Desc = {
    Text = "Vượt qua \"Ánh sáng dẫn đường\"độ khó Điên loạn"
  },
  Task_81091_Desc = {
    Text = "Sử dụng người đánh thức chiều không gian siêu cấp để giành chiến thắng 2 lần trong \"Đại dương lạc lối\""
  },
  Task_81092_Desc = {
    Text = "Vượt qua \"Thước cũ\"độ khó Điên loạn"
  },
  Task_81093_Desc = {
    Text = "Vượt qua Kẻ lang thang \"Ngọn hải đăng cuối cùng\""
  },
  Task_81094_Desc = {
    Text = "Vượt qua \"La bàn cũ\"độ khó Điên loạn"
  },
  Task_81095_Desc = {
    Text = "Vượt qua \"Ánh sáng dẫn đường\"ở bất kỳ độ khó nào"
  },
  Task_81096_Desc = {
    Text = "Vượt qua \"La bàn cũ\"ở bất kỳ độ khó nào"
  },
  Task_81097_Desc = {
    Text = "Hoàn thành tất cả thành tựu \"Khám Phá Biển Sâu-Qua Cửa\""
  },
  Task_81098_Desc = {
    Text = "Vượt qua \"Ánh sáng dẫn đường\"ở bất kỳ độ khó nào"
  },
  Task_81099_Desc = {
    Text = "Vượt qua \"Quá trình ngôi sao\"độ khó Điên loạn"
  },
  Task_81100_Desc = {
    Text = "Vượt qua \"Quá trình ngôi sao\"ở bất kỳ độ khó nào"
  },
  Task_81101_Desc = {
    Text = "Vượt qua \"Cờ tín hiệu\"ở bất kỳ độ khó nào"
  },
  Task_81102_Desc = {
    Text = "Vượt qua \"Cờ tín hiệu\"ở bất kỳ độ khó nào"
  },
  Task_81103_Desc = {
    Text = "Vượt qua \"Thước cũ\"ở bất kỳ độ khó nào"
  },
  Task_81104_Desc = {
    Text = "Vượt qua \"Hải đồ cổ\"ở bất kỳ độ khó nào"
  },
  Task_81105_Desc = {
    Text = "Vượt qua \"Cờ tín hiệu\"độ khó Điên loạn"
  },
  Task_81106_Desc = {
    Text = "Vượt qua \"Sổ tay hoa tiêu\"ở bất kỳ độ khó nào"
  },
  Task_81107_Desc = {
    Text = "Vượt qua \"Sổ tay hoa tiêu\"ở bất kỳ độ khó nào"
  },
  Task_81108_Desc = {
    Text = "Vượt qua \"Sao mờ\"ở bất kỳ độ khó nào"
  },
  Task_81109_Desc = {
    Text = "Sử dụng người đánh thức chiều không gian máu thịt để giành chiến thắng 1 lần trong \"Đại dương lạc lối\""
  },
  Task_81110_Desc = {
    Text = "Sử dụng người đánh thức chiều không gian siêu cấp để giành chiến thắng 1 lần trong \"Đại dương lạc lối\""
  },
  Task_81111_Desc = {
    Text = "Vượt qua \"Khúc ca cuối cùng\"độ khó Điên loạn"
  },
  Task_81112_Desc = {
    Text = "Du Hải Mê Hành·Thông Qua"
  },
  Task_81113_Desc = {
    Text = "Vượt qua \"Quá trình ngôi sao\"ở bất kỳ độ khó nào"
  },
  Task_81114_Desc = {
    Text = "Vượt qua \"Hải đồ cổ\"ở bất kỳ độ khó nào"
  },
  Task_81115_Desc = {
    Text = "Vượt qua \"Hải đồ cổ\"độ khó Điên loạn"
  },
  Task_81116_Desc = {
    Text = "Vượt qua \"Sao mờ\"độ khó Điên loạn"
  },
  Task_81117_Desc = {
    Text = "Vượt qua \"Thước cũ\"ở bất kỳ độ khó nào"
  },
  Task_81118_Desc = {
    Text = "Vượt qua \"Sao mờ\"ở bất kỳ độ khó nào"
  },
  Task_81119_Desc = {
    Text = "Du Hải Mê Hành·Cõi"
  },
  Task_81120_Desc = {
    Text = "Sử dụng người đánh thức chiều không gian hỗn loạn để giành chiến thắng 2 lần trong \"Đại dương lạc lối\""
  },
  Task_81121_Desc = {
    Text = "Sử dụng người đánh thức chiều không gian máu thịt để giành chiến thắng 2 lần trong \"Đại dương lạc lối\""
  },
  Task_81122_Desc = {
    Text = "Sử dụng người đánh thức chiều không gian hỗn loạn để giành chiến thắng 1 lần trong \"Đại dương lạc lối\""
  },
  Task_81481_Desc = {
    Text = "Đánh bại \"Vũ trụ @2 hình chiếu\" mà không cần sự hỗ trợ của Vòng lặp Ramona."
  },
  Task_81481_Name = {
    Text = "Nghe âm thanh vũ trụ·Ẩn"
  },
  Task_81772_Name = {
    Text = "Đánh bại BOSS 1N lần"
  },
  Task_81773_Name = {
    Text = "Đánh bại BOSS 7N lần"
  },
  Task_81774_Name = {
    Text = "Tiêu diệt tất cả các BOSS"
  },
  Task_81775_Name = {
    Text = "Đánh bại BOSS 3 N lần"
  },
  Task_81776_Name = {
    Text = "Đánh bại BOSS 2N lần"
  },
  Task_81777_Name = {
    Text = "Đánh bại BOSS 6N lần"
  },
  Task_81778_Name = {
    Text = "Đánh bại BOSS \"4N\" lần"
  },
  Task_81779_Name = {
    Text = "Đánh bại BOSS 5N lần"
  },
  Task_84111_Name = {
    Text = "Vượt qua cửa ải tuyến nhiệm vụ của Koperchant bình thường 4"
  },
  Task_84143_Desc = {
    Text = "Đăng nhập liên tiếp 2 ngày"
  },
  Task_84144_Desc = {
    Text = "Đăng nhập tổng cộng 3 ngày"
  },
  Task_84145_Desc = {
    Text = "Đăng nhập liên tiếp 2 ngày"
  },
  Task_84146_Desc = {
    Text = "Đăng nhập tổng cộng 5 ngày"
  },
  Task_84147_Desc = {
    Text = "Đăng nhập tổng cộng 8 ngày"
  },
  Task_84148_Desc = {
    Text = "Đăng nhập liên tiếp 2 ngày"
  },
  Task_84149_Desc = {
    Text = "Đăng nhập tổng cộng 5 ngày"
  },
  Task_84150_Desc = {
    Text = "Đăng nhập tổng cộng 10 ngày"
  },
  Task_84151_Desc = {
    Text = "Đăng nhập tổng cộng 5 ngày"
  },
  Task_84152_Desc = {
    Text = "Đăng nhập tổng cộng 10 ngày"
  },
  Task_84153_Desc = {
    Text = "Đăng nhập tổng cộng 4 ngày"
  },
  Task_84154_Desc = {
    Text = "Đăng nhập tổng cộng 9 ngày"
  },
  Task_84155_Desc = {
    Text = "Đăng nhập tổng cộng 3 ngày"
  },
  Task_84156_Desc = {
    Text = "Đăng nhập tổng cộng 6 ngày"
  },
  Task_84157_Desc = {
    Text = "Đăng nhập liên tiếp 2 ngày"
  },
  Task_84158_Desc = {
    Text = "Đăng nhập tổng cộng 4 ngày"
  },
  Task_84159_Desc = {
    Text = "Đăng nhập tổng cộng 3 ngày"
  },
  Task_84160_Desc = {
    Text = "Đăng nhập tổng cộng 1 ngày"
  },
  Task_84161_Desc = {
    Text = "Đăng nhập liên tiếp 7 ngày"
  },
  Task_84162_Desc = {
    Text = "Đăng nhập tổng cộng 5 ngày"
  },
  Task_84163_Desc = {
    Text = "Đăng nhập tổng cộng 1 ngày"
  },
  Task_84164_Desc = {
    Text = "Đăng nhập tổng cộng 1 ngày"
  },
  Task_84165_Desc = {
    Text = "Đăng nhập tổng cộng 8 ngày"
  },
  Task_84166_Desc = {
    Text = "Đăng nhập liên tiếp 7 ngày"
  },
  Task_84167_Desc = {
    Text = "Đăng nhập tổng cộng 4 ngày"
  },
  Task_84168_Desc = {
    Text = "Đăng nhập tổng cộng 6 ngày"
  },
  Task_84169_Desc = {
    Text = "Đăng nhập tổng cộng 4 ngày"
  },
  Task_84170_Desc = {
    Text = "Đăng nhập tổng cộng 9 ngày"
  },
  Task_84171_Desc = {
    Text = "Đăng nhập tổng cộng 1 ngày"
  },
  Task_84172_Desc = {
    Text = "Đăng nhập tổng cộng 3 ngày"
  },
  Task_84323_Desc = {
    Text = "Đạt được 3 trận thắng trong mùa giải này"
  },
  Task_84323_Name = {
    Text = "3 trận thắng"
  },
  Task_84324_Desc = {
    Text = "Đạt được tổng cộng 6 trận thắng trong mùa giải này"
  },
  Task_84324_Name = {Text = "6 thắng"},
  Task_84325_Desc = {
    Text = "Đạt được tích lũy 1 trận thắng trong mùa giải này"
  },
  Task_84325_Name = {
    Text = "1 trận thắng"
  },
  Task_84326_Desc = {
    Text = "Đạt được tổng cộng 10 trận thắng trong mùa giải này"
  },
  Task_84326_Name = {Text = "10 thắng"},
  Task_84349_Desc = {
    Text = "Hoàn thành cuộc phiêu lưu nhận thức \"Ngọn hải đăng cuối cùng\""
  },
  Task_84349_Name = {
    Text = "Hướng dẫn từ những vì sao và vực thẳm"
  },
  Task_88945_Desc = {
    Text = "Hoàn thành \"Phá Hủy Nhà Tù\" ở bất kỳ độ khó nào"
  },
  Task_88946_Desc = {
    Text = "Vượt ải Thế giới mộng mơ \"Phía bên kia chân trời·Trên\""
  },
  Task_88947_Desc = {
    Text = "Sử dụng Người đánh thức Vùng hỗn loạn chiến thắng 2 lần trong \"Lướt qua bầu trời\""
  },
  Task_88948_Desc = {
    Text = "Hoàn thành \"Hành Trình Cô Đơn\" ở bất kỳ độ khó nào"
  },
  Task_88949_Desc = {
    Text = "Sử dụng Người đánh thức Vùng biển sâu chiến thắng 1 lần trong \"Lướt qua bầu trời\""
  },
  Task_88950_Desc = {
    Text = "Sử dụng Người đánh thức Vùng hỗn loạn chiến thắng 1 lần trong \"Lướt qua bầu trời\""
  },
  Task_88951_Desc = {
    Text = "Hoàn thành \"Ngọn Nến Truyền\" ở bất kỳ độ khó nào"
  },
  Task_88952_Desc = {
    Text = "Hoàn thành \"Phá Hủy Nhà Tù\" ở độ khó điên loạn"
  },
  Task_88953_Desc = {
    Text = "Hoàn thành \"Phá Hủy Nhà Tù\" ở bất kỳ độ khó nào"
  },
  Task_88954_Desc = {
    Text = "Sử dụng Người đánh thức Vương quốc siêu cấp chiến thắng 1 lần trong \"Lướt qua bầu trời\""
  },
  Task_88955_Desc = {
    Text = "Hoàn thành \"Tự Do và Tử Vong\" ở độ khó điên loạn"
  },
  Task_88956_Desc = {
    Text = "Hoàn thành \"Hành Trình Cô Đơn\" ở bất kỳ độ khó nào"
  },
  Task_88957_Desc = {
    Text = "Lướt qua bầu trời·Điên loạn"
  },
  Task_88958_Desc = {
    Text = "Hoàn thành \"Tự Do và Tử Vong\" ở bất kỳ độ khó nào"
  },
  Task_88959_Desc = {
    Text = "Hoàn thành \"Tự Do và Tử Vong\" ở bất kỳ độ khó nào"
  },
  Task_88960_Desc = {
    Text = "Hoàn thành \"Cát Tận Cùng\" ở bất kỳ độ khó nào"
  },
  Task_88961_Desc = {
    Text = "Hoàn thành tất cả thành tựu \"Cất cánh nhìn tận trời xanh.\""
  },
  Task_88962_Desc = {
    Text = "Hoàn thành \"Ngọn Nến Truyền\" ở bất kỳ độ khó nào"
  },
  Task_88963_Desc = {
    Text = "Hoàn thành \"Cát Tận Cùng\" ở độ khó điên loạn"
  },
  Task_88964_Desc = {
    Text = "Hoàn thành \"Kẻ Ngu Muội\" ở độ khó điên loạn"
  },
  Task_88965_Desc = {
    Text = "Hoàn thành \"Giấc Mơ Ngày Qua\" ở độ khó điên loạn"
  },
  Task_88966_Desc = {
    Text = "Hoàn thành \"Hành Trình Cô Đơn\" ở độ khó điên loạn"
  },
  Task_88967_Desc = {
    Text = "Sử dụng Người đánh thức Vùng mô rớp chiến thắng 2 lần trong \"Lướt qua bầu trời\""
  },
  Task_88968_Desc = {
    Text = "Hoàn thành \"Giấc Mơ Ngày Qua\" ở bất kỳ độ khó nào"
  },
  Task_88969_Desc = {
    Text = "Lướt qua bầu trời·Cõi"
  },
  Task_88970_Desc = {
    Text = "Sử dụng Người đánh thức Vùng biển sâu chiến thắng 2 lần trong \"Lướt qua bầu trời\""
  },
  Task_88971_Desc = {
    Text = "Lướt qua bầu trời·Thông qua"
  },
  Task_88972_Desc = {
    Text = "Hoàn thành \"Cát Tận Cùng\" ở bất kỳ độ khó nào"
  },
  Task_88973_Desc = {
    Text = "Sử dụng Người đánh thức Vùng mô rớp chiến thắng 1 lần trong \"Lướt qua bầu trời\""
  },
  Task_88974_Desc = {
    Text = "Hoàn thành \"Kẻ Ngu Muội\" ở bất kỳ độ khó nào"
  },
  Task_88975_Desc = {
    Text = "Hoàn thành \"Ngọn Nến Truyền\" ở độ khó điên loạn"
  },
  Task_88976_Desc = {
    Text = "Sử dụng Người đánh thức Vương quốc siêu cấp chiến thắng 2 lần trong \"Lướt qua bầu trời\""
  },
  Task_88977_Desc = {
    Text = "Hoàn thành \"Giấc Mơ Ngày Qua\" ở bất kỳ độ khó nào"
  },
  Task_88978_Desc = {
    Text = "Hoàn thành \"Kẻ Ngu Muội\" ở bất kỳ độ khó nào"
  },
  Task_89577_Desc = {
    Text = "Đăng nhập liên tiếp 12 ngày"
  },
  Task_89578_Desc = {
    Text = "Tích lũy đăng nhập 15 ngày"
  },
  Task_89579_Desc = {
    Text = "Đăng nhập liên tiếp 2 ngày"
  },
  Task_89580_Desc = {
    Text = "Đăng nhập liên tiếp trong 10 ngày"
  },
  Task_89581_Desc = {
    Text = "Đăng nhập liên tiếp 11 ngày"
  },
  Task_89582_Desc = {
    Text = "Đăng nhập liên tiếp 3 ngày"
  },
  Task_89583_Desc = {
    Text = "Đăng nhập liên tiếp 6 ngày"
  },
  Task_89584_Desc = {
    Text = "Đăng nhập tích lũy 16 ngày liên tiếp"
  },
  Task_89585_Desc = {
    Text = "Đăng nhập liên tiếp 4 ngày"
  },
  Task_89586_Desc = {
    Text = "Đăng nhập liên tiếp 1 ngày"
  },
  Task_89587_Desc = {
    Text = "Đăng nhập liên tiếp 7 ngày"
  },
  Task_89588_Desc = {
    Text = "Tích lũy đăng nhập 14 ngày"
  },
  Task_89589_Desc = {
    Text = "Đăng nhập liên tiếp 8 ngày"
  },
  Task_89590_Desc = {
    Text = "Đăng nhập liên tiếp 5 ngày"
  },
  Task_89591_Desc = {
    Text = "Đăng nhập tích lũy trong 13 ngày"
  },
  Task_89592_Desc = {
    Text = "Đăng nhập liên tiếp trong 9 ngày"
  },
  Task_89844_Desc = {
    Text = "Lần đầu tiên cam kết số phận được đánh thức ({s1}/1)"
  },
  Task_89844_Name = {
    Text = "Hoàn thành nhiệm vụ nhận phiếu hình vẽ trang phục ảo"
  },
  Task_89845_Desc = {
    Text = "Đăng nhập 7 ngày ({s1}/7)"
  },
  Task_89845_Name = {
    Text = "Hoàn thành nhiệm vụ nhận phiếu hình vẽ trang phục ảo"
  },
  Task_89846_Desc = {
    Text = "Đẩy lùi nhóm thủy triều di chuyển ({s1}/30)"
  },
  Task_89846_Name = {
    Text = "Hoàn thành nhiệm vụ nhận phiếu hình vẽ trang phục ảo"
  },
  Task_90036_Desc = {
    Text = "Đạt được tổng cộng 6 trận thắng trong mùa giải này"
  },
  Task_90036_Name = {Text = "6 thắng"},
  Task_90037_Desc = {
    Text = "Đạt được 3 trận thắng trong mùa giải này"
  },
  Task_90037_Name = {
    Text = "3 trận thắng"
  },
  Task_90038_Desc = {
    Text = "Đạt được tổng cộng 10 trận thắng trong mùa giải này"
  },
  Task_90038_Name = {Text = "10 thắng"},
  Task_90039_Desc = {
    Text = "Đạt được tích lũy 1 trận thắng trong mùa giải này"
  },
  Task_90039_Name = {
    Text = "1 trận thắng"
  },
  Task_90495_Desc = {
    Text = "Vượt qua Thực Chiến Hướng Dẫn · Ý Niệm Hỗn Loạn"
  },
  Task_90495_Name = {
    Text = "Ý Niệm Hỗn Loạn"
  },
  Task_90866_Desc = {
    Text = "Hải vực thai động I"
  },
  Task_90867_Desc = {
    Text = "Vạn Nguyện Mô Phỏng I"
  },
  Task_90868_Desc = {
    Text = "Văn bản tạm thời·Miễn phí"
  },
  Task_90869_Desc = {
    Text = "Khúc Ca Mê Cung VII"
  },
  Task_90870_Desc = {
    Text = "Văn bản tạm thờiIV"
  },
  Task_90871_Desc = {
    Text = "Số phận đồng hình III"
  },
  Task_90872_Desc = {
    Text = "Khúc Ca Mê Cung I"
  },
  Task_90873_Desc = {
    Text = "Vạn Nguyện Mô Phỏng V"
  },
  Task_90874_Desc = {
    Text = "Hải vực thai động VI"
  },
  Task_90875_Desc = {
    Text = "Văn bản tạm I"
  },
  Task_90876_Desc = {
    Text = "Hải vực thai động · miễn phí"
  },
  Task_90877_Desc = {
    Text = "Khúc Ca Mê Cung·Miễn Phí"
  },
  Task_90878_Desc = {
    Text = "Khúc Ca Mê Cung VI"
  },
  Task_90879_Desc = {
    Text = "Vạn Nguyện Mô Phỏng IV"
  },
  Task_90880_Desc = {
    Text = "Vạn Nguyện Mô Phỏng·Miễn phí"
  },
  Task_90881_Desc = {
    Text = "Khúc Ca Mê Cung III"
  },
  Task_90882_Desc = {
    Text = "Định mệnh đồng hành II"
  },
  Task_90883_Desc = {
    Text = "Văn bản tạm thờiV"
  },
  Task_90884_Desc = {
    Text = "Khúc Ca Mê Cung V"
  },
  Task_90885_Desc = {
    Text = "Văn bản tạm thờiVI"
  },
  Task_90886_Desc = {
    Text = "Văn bản tạm thờiVII"
  },
  Task_90887_Desc = {
    Text = "Con đường định mệnh liên hợp VI"
  },
  Task_90888_Desc = {
    Text = "Định mệnh đồng nhấtIV"
  },
  Task_90889_Desc = {
    Text = "Khúc Ca Mê Cung IV"
  },
  Task_90890_Desc = {
    Text = "Con đường định mệnh đồng nhất V"
  },
  Task_90891_Desc = {
    Text = "Conjugate Fate I"
  },
  Task_90892_Desc = {
    Text = "Vạn Nguyện Mô Phỏng III"
  },
  Task_90893_Desc = {
    Text = "Hải vực thai động II"
  },
  Task_90894_Desc = {
    Text = "Văn bản tạm thờiIII"
  },
  Task_90895_Desc = {
    Text = "Định mệnh liên hợpVII"
  },
  Task_90896_Desc = {
    Text = "Khúc Ca Mê Cung II"
  },
  Task_90897_Desc = {
    Text = "Hải vực thai động VII"
  },
  Task_90898_Desc = {
    Text = "Hải vực thai động V"
  },
  Task_90899_Desc = {
    Text = "Hải vực thai động IV"
  },
  Task_90900_Desc = {
    Text = "Vạn Nguyện Mô Phỏng VI"
  },
  Task_90901_Desc = {
    Text = "Định mệnh đồng hành·Miễn phí"
  },
  Task_90902_Desc = {
    Text = "Vạn Nguyện Mô Phỏng II"
  },
  Task_90903_Desc = {
    Text = "Hải vực thai động III"
  },
  Task_90904_Desc = {
    Text = "Vạn Nguyện Mô Phỏng VII"
  },
  Task_90905_Desc = {
    Text = "Bản văn tạm II"
  },
  Task_91028_Desc = {
    Text = "Qua \"Vòng nguyệt quế dũng sĩ\" ở mức độ điên loạn"
  },
  Task_91029_Desc = {
    Text = "Sử dụng Người đánh thức Cõi hỗn loạn để giành chiến thắng 1 lần trong \"Săn mồi thiêng liêng\""
  },
  Task_91030_Desc = {
    Text = "Sử dụng Người đánh thức Cõi máu thịt để giành chiến thắng 1 lần trong \"Săn mồi thiêng liêng\""
  },
  Task_91031_Desc = {
    Text = "Sử dụng Người đánh thức Vương quốc siêu cấp để giành chiến thắng 1 lần trong \"Săn mồi thiêng liêng\""
  },
  Task_91032_Desc = {
    Text = "Sử dụng Người đánh thức Cõi máu thịt để giành chiến thắng 2 lần trong \"Săn mồi thiêng liêng\""
  },
  Task_91033_Desc = {
    Text = "Săn mồi thiêng liêng·Thông qua"
  },
  Task_91034_Desc = {
    Text = "Qua \"Thợ săn dữ tợn\" ở bất kỳ mức độ nào"
  },
  Task_91035_Desc = {
    Text = "Săn mồi thiêng liêng·Điên loạn"
  },
  Task_91036_Desc = {
    Text = "Qua \"Kèn lệnh viễn chinh\" ở bất kỳ mức độ nào"
  },
  Task_91037_Desc = {
    Text = "Qua \"Hợp tác trí tuệ\" ở bất kỳ mức độ nào"
  },
  Task_91038_Desc = {
    Text = "Sử dụng Người đánh thức Vùng biển sâu để giành chiến thắng 2 lần trong \"Săn mồi thiêng liêng\""
  },
  Task_91039_Desc = {
    Text = "Sử dụng Người đánh thức Vương quốc siêu cấp để giành chiến thắng 2 lần trong \"Săn mồi thiêng liêng\""
  },
  Task_91040_Desc = {
    Text = "Qua \"Thế giới mộng mơ「Đoán bếp núc」\""
  },
  Task_91041_Desc = {
    Text = "Qua \"Vòng nguyệt quế dũng sĩ\" ở bất kỳ mức độ nào"
  },
  Task_91042_Desc = {
    Text = "Qua \"Vòng nguyệt quế dũng sĩ\" ở bất kỳ mức độ nào"
  },
  Task_91043_Desc = {
    Text = "Sử dụng Người đánh thức Vùng biển sâu để giành chiến thắng 1 lần trong \"Săn mồi thiêng liêng\""
  },
  Task_91044_Desc = {
    Text = "Qua \"Vinh quang khải hoàn\" ở bất kỳ mức độ nào"
  },
  Task_91045_Desc = {
    Text = "Qua \"Thợ săn dữ tợn\" ở bất kỳ mức độ nào"
  },
  Task_91046_Desc = {
    Text = "Qua \"Hợp tác trí tuệ\" ở mức độ điên loạn"
  },
  Task_91047_Desc = {
    Text = "Qua \"Kèn lệnh viễn chinh\" ở bất kỳ mức độ nào"
  },
  Task_91048_Desc = {
    Text = "Qua \"Hợp tác trí tuệ\" ở bất kỳ mức độ nào"
  },
  Task_91049_Desc = {
    Text = "Qua \"Vinh quang khải hoàn\" ở bất kỳ mức độ nào"
  },
  Task_91050_Desc = {
    Text = "Hoàn thành tất cả thành tựu của \"Món ăn thần thánh - Thông qua\""
  },
  Task_91051_Desc = {
    Text = "Qua \"Kèn lệnh viễn chinh\" ở mức độ điên loạn"
  },
  Task_91052_Desc = {
    Text = "Qua \"Vinh quang khải hoàn\" ở mức độ điên loạn"
  },
  Task_91053_Desc = {
    Text = "Săn mồi thiêng liêng·Cõi"
  },
  Task_91054_Desc = {
    Text = "Qua \"Thợ săn dữ tợn\" ở mức độ điên loạn"
  },
  Task_91055_Desc = {
    Text = "Sử dụng Người đánh thức Cõi hỗn loạn để giành chiến thắng 2 lần trong \"Săn mồi thiêng liêng\""
  },
  Task_91129_Desc = {
    Text = "Cấp độ đạt 20"
  },
  Task_91131_Desc = {
    Text = "Cấp độ đạt 5"
  },
  Task_91149_Desc = {
    Text = "Cấp độ đạt 15"
  },
  Task_91154_Desc = {
    Text = "Cấp độ đạt 10"
  },
  Task_91332_Desc = {
    Text = "Đánh bại Dullesain"
  },
  Task_91332_Name = {
    Text = "Mục tiêu"
  },
  Task_91333_Desc = {
    Text = "Đánh bại kẻ xâm lược"
  },
  Task_91333_Name = {
    Text = "Mục tiêu"
  },
  Task_91334_Desc = {
    Text = "Đánh bại \"Bánh răng mục nát\"，bảo vệ thành phố chôn cất"
  },
  Task_91334_Name = {
    Text = "Mục tiêu"
  },
  Task_91335_Desc = {
    Text = "Đánh bại thủy thủ"
  },
  Task_91335_Name = {
    Text = "Mục tiêu"
  },
  Task_91336_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_91336_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_91337_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_91337_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_91338_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_91338_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_91339_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_91339_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_91340_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_91340_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_91341_Desc = {
    Text = "Phá hủy \"bức tranh\" của Pikman"
  },
  Task_91341_Name = {
    Text = "Mục tiêu"
  },
  Task_91342_Desc = {
    Text = "Đánh bại kẻ thù, tiến vào thành phố của xác sống"
  },
  Task_91342_Name = {
    Text = "Mục tiêu"
  },
  Task_91343_Desc = {
    Text = "Thoát khỏi sự truy bắt của xác sống"
  },
  Task_91343_Name = {
    Text = "Mục tiêu"
  },
  Task_91344_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_91344_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_91345_Desc = {
    Text = "Đánh bại cơ thể phân rã"
  },
  Task_91345_Name = {
    Text = "Mục tiêu"
  },
  Task_91346_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_91346_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_91347_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_91347_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_91348_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_91348_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_91349_Desc = {
    Text = "Đánh bại Goliath, phá hủy vòng tròn ma thuật"
  },
  Task_91349_Name = {
    Text = "Mục tiêu"
  },
  Task_91350_Desc = {
    Text = "Không kích hoạt linh tri thức khẩn cấp để hoàn thành thử thách"
  },
  Task_91350_Name = {
    Text = "Vượt qua hoàn hảo"
  },
  Task_91351_Desc = {
    Text = "Đánh bại quản gia Fran"
  },
  Task_91351_Name = {
    Text = "Mục tiêu"
  },
  Task_91357_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_91358_Desc = {
    Text = "Thực hiện vượt ải chương 3-5 phần Bứt phá"
  },
  Task_91359_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"@1@2\""
  },
  Task_91359_Desc2 = {
    Text = "Hoàn thành sự kiện điều tra \"Thỏa mãn\""
  },
  Task_91359_Name2 = {
    Text = "Bữa ăn chung của xương và linh hồn"
  },
  Task_91360_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_91361_Desc = {
    Text = "Thực hiện vượt ải chương 3-5 phần Bứt phá độ khó khó khă"
  },
  Task_91362_Desc = {
    Text = "Thực hiện vượt ải chương \"Thỏa mãn\"độ khó khó khă"
  },
  Task_91363_Desc = {
    Text = "Hoàn thành sự kiện điều tra \"Thỏa thích\"độ khó cao"
  },
  Task_91363_Name = {
    Text = "Bữa ăn giữa xương và linh hồn·Khó khăn"
  },
  Task_91364_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_91365_Desc = {
    Text = "Thực hiện vượt ải chương \"Thoả mãn\" phần Bứt phá"
  },
  Task_91366_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_91367_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_91368_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_91370_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_91371_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_91372_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_91373_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_91379_Desc = {
    Text = "Thực hiện vượt ải chương 2-5 phần Bứt phá độ khó khó khă"
  },
  Task_91380_Desc = {
    Text = "Thực hiện vượt ải chương 2-5 phần Bứt phá"
  },
  Task_91381_Desc = {
    Text = "Thực hiện vượt ải chương \"Thỏa mãn\"độ khó khó khă"
  },
  Task_91382_Desc = {
    Text = "Thực hiện vượt ải chương \"Thoả mãn\" phần Bứt phá"
  },
  Task_91436_Desc = {
    Text = "Đạt được tích lũy 1 trận thắng trong mùa giải này"
  },
  Task_91436_Name = {
    Text = "1 trận thắng"
  },
  Task_91437_Desc = {
    Text = "Đạt được 3 trận thắng trong mùa giải này"
  },
  Task_91437_Name = {
    Text = "3 trận thắng"
  },
  Task_91438_Desc = {
    Text = "Đạt được tổng cộng 6 trận thắng trong mùa giải này"
  },
  Task_91438_Name = {Text = "6 thắng"},
  Task_91439_Desc = {
    Text = "Đạt được tổng cộng 10 trận thắng trong mùa giải này"
  },
  Task_91439_Name = {Text = "10 thắng"},
  Task_91720_Desc = {
    Text = "Đăng nhập 7 ngày ({s1}/7)"
  },
  Task_91720_Name = {
    Text = "Hoàn thành nhiệm vụ nhận phiếu hình vẽ trang phục ảo"
  },
  Task_91721_Desc = {
    Text = "Qua toàn bộ mức độ điên loạn ({s1}/5)"
  },
  Task_91721_Name = {
    Text = "Hoàn thành nhiệm vụ nhận phiếu hình vẽ trang phục ảo"
  },
  Task_91786_Desc = {
    Text = "Sử dụng người đánh thức từ cõi máu thịt để giành chiến thắng 2 lần trong \"Sự Xuất Hiện Của Vùng Đất Thần Thánh\""
  },
  Task_91787_Desc = {
    Text = "Sử dụng người đánh thức từ cõi hỗn loạn để giành chiến thắng 2 lần trong \"Sự Xuất Hiện Của Vùng Đất Thần Thánh\""
  },
  Task_91788_Desc = {
    Text = "Sử dụng người đánh thức từ cõi biển sâu để giành chiến thắng 2 lần trong \"Sự Xuất Hiện Của Vùng Đất Thần Thánh\""
  },
  Task_91789_Desc = {
    Text = "Sử dụng người đánh thức từ cõi siêu cấp để giành chiến thắng 2 lần trong \"Sự Xuất Hiện Của Vùng Đất Thần Thánh\""
  },
  Task_94489_Desc = {
    Text = "Nâng cấp 6 nhân vật Hỗn loạn lên cấp 80"
  },
  Task_94489_Name = {
    Text = "Cõi tinh thông X"
  },
  Task_94490_Desc = {
    Text = "Nâng cấp 6 nhân vật Aequor lên cấp 70"
  },
  Task_94490_Name = {
    Text = "Cõi tinh thông IX"
  },
  Task_94491_Desc = {
    Text = "Nâng cấp 6 nhân vật Ultra lên cấp 70"
  },
  Task_94491_Name = {
    Text = "Cõi tinh thông IX"
  },
  Task_94492_Desc = {
    Text = "Nâng cấp 6 nhân vật Caro lên cấp 80"
  },
  Task_94492_Name = {
    Text = "Cõi tinh thông X"
  },
  Task_94493_Desc = {
    Text = "Nâng cấp 6 nhân vật Aequor lên cấp 80"
  },
  Task_94493_Name = {
    Text = "Cõi tinh thông X"
  },
  Task_94494_Desc = {
    Text = "Nâng cấp 6 nhân vật Caro lên cấp 70"
  },
  Task_94494_Name = {
    Text = "Cõi tinh thông IX"
  },
  Task_94495_Desc = {
    Text = "Nâng cấp 6 nhân vật Hỗn loạn lên cấp 70"
  },
  Task_94495_Name = {
    Text = "Cõi tinh thông IX"
  },
  Task_94496_Desc = {
    Text = "Nâng cấp 6 nhân vật Ultra lên cấp 80"
  },
  Task_94496_Name = {
    Text = "Cõi tinh thông X"
  },
  Task_94497_Desc = {
    Text = "Hoàn thành tất cả các nhiệm vụ trong chương này sẽ nhận được"
  },
  Task_94497_Name = {
    Text = "Cõi tinh thông X"
  },
  Task_94498_Desc = {
    Text = "Hoàn thành tất cả các nhiệm vụ trong chương này sẽ nhận được"
  },
  Task_94498_Name = {
    Text = "Cõi tinh thông IX"
  },
  Task_94613_Desc = {
    Text = "Vượt qua Thực Chiến Hướng Dẫn · Siêu Chiều Không Gian"
  },
  Task_94613_Name = {
    Text = "Siêu Chiều Không Gian"
  },
  Task_94614_Desc = {
    Text = "Vượt qua Thực Chiến Hướng Dẫn · Huyết Nhục Ký Sinh"
  },
  Task_94614_Name = {
    Text = "Huyết Nhục Ký Sinh"
  },
  Task_94615_Desc = {
    Text = "Vượt qua Thực Chiến Hướng Dẫn · Chạm Biển Sâu"
  },
  Task_94615_Name = {
    Text = "Chạm Biển Sâu"
  },
  Task_94699_Desc = {
    Text = "Lời Ai Điếu Của Hộp Sọ · Độc Quyền Hạn Chế"
  },
  Task_94861_Desc = {
    Text = "Tiêu hao 1800 điểm Menophin"
  },
  Task_94863_Desc = {
    Text = "Tích lũy thức tỉnh 100 lần"
  },
  Task_94865_Desc = {
    Text = "Sử dụng hỗ trợ 3 lần"
  },
  Task_94867_Desc = {
    Text = "Giá trị luyện tập ở khu vực d-khu vực đạt đến 100"
  },
  Task_94871_Desc = {
    Text = "Hoàn thành 1 lần cửa chơi thử Cati Glow"
  },
  Task_94874_Desc = {
    Text = "Hoàn thành thách thức hàng tuần trong 2 tuần"
  },
  Task_94876_Desc = {
    Text = "Tiêu hao 1800 điểm Menophin"
  },
  Task_94877_Desc = {
    Text = "Hoàn thành 20 nhiệm vụ"
  },
  Task_94882_Desc = {
    Text = "Đăng nhập liên tiếp 1 ngày"
  },
  Task_94885_Desc = {
    Text = "Hoàn thành thách thức hàng tuần trong 2 tuần"
  },
  Task_94886_Desc = {
    Text = "Hoàn thành 1 lần cửa chơi thử Cati Glow"
  },
  Task_94888_Desc = {
    Text = "Sử dụng hỗ trợ 3 lần"
  },
  Task_94891_Desc = {
    Text = "Đăng nhập liên tiếp 1 ngày"
  },
  Task_94895_Desc = {
    Text = "Giá trị luyện tập ở khu vực d-khu vực đạt đến 100"
  },
  Task_94898_Desc = {
    Text = "Tích lũy thức tỉnh 100 lần"
  },
  Task_94901_Desc = {
    Text = "Hoàn thành 20 nhiệm vụ"
  },
  Task_95192_Desc = {
    Text = "Hoàn thành \"Mặt Trời Trên Mặt Đất\"độ khó Điên loạn"
  },
  Task_95193_Desc = {
    Text = "Sử dụng người đánh thức từ cõi máu thịt để giành chiến thắng 2 lần trong \"Săn Lùng Tàn Lửa\""
  },
  Task_95194_Desc = {
    Text = "Hoàn thành \"Thế Giới Im Lặng\"ở bất kỳ độ khó nào"
  },
  Task_95195_Desc = {
    Text = "Sử dụng người đánh thức từ cõi hỗn loạn để giành chiến thắng 1 lần trong \"Săn Lùng Tàn Lửa\""
  },
  Task_95196_Desc = {
    Text = "Hoàn thành ý thức lang thang \"Ngày Đỉnh Cao Bất Tử\""
  },
  Task_95197_Desc = {
    Text = "Hoàn thành \"Mục Tiêu Hợp Đồng\"ở bất kỳ độ khó nào"
  },
  Task_95198_Desc = {
    Text = "Hoàn thành \"Thế Giới Im Lặng\"độ khó Điên loạn"
  },
  Task_95199_Desc = {
    Text = "Hoàn thành \"Mục Tiêu Hợp Đồng\"ở bất kỳ độ khó nào"
  },
  Task_95200_Desc = {
    Text = "Hoàn thành \"Mặt Trời Trên Mặt Đất\"ở bất kỳ độ khó nào"
  },
  Task_95201_Desc = {
    Text = "Hoàn thành \"Tuyên Cáo Lửa\"ở bất kỳ độ khó nào"
  },
  Task_95202_Desc = {
    Text = "Sử dụng người đánh thức từ cõi biển sâu để giành chiến thắng 1 lần trong \"Săn Lùng Tàn Lửa\""
  },
  Task_95203_Desc = {
    Text = "Hoàn thành \"Lời Nguyền Cổ Xưa\"ở bất kỳ độ khó nào"
  },
  Task_95204_Desc = {
    Text = "Hoàn thành \"Tuyên Cáo Lửa\"ở bất kỳ độ khó nào"
  },
  Task_95205_Desc = {
    Text = "Sử dụng người đánh thức từ cõi siêu cấp để giành chiến thắng 1 lần trong \"Săn Lùng Tàn Lửa\""
  },
  Task_95206_Desc = {
    Text = "Sử dụng người đánh thức từ cõi hỗn loạn để giành chiến thắng 2 lần trong \"Săn Lùng Tàn Lửa\""
  },
  Task_95207_Desc = {
    Text = "Thực hiện vượt ải \"Ánh sáng hủy diệt\"độ khó bất kỳ"
  },
  Task_95208_Desc = {
    Text = "Hoàn thành \"Mặt Trời Trên Mặt Đất\"ở bất kỳ độ khó nào"
  },
  Task_95209_Desc = {
    Text = "Sử dụng người đánh thức từ cõi máu thịt để giành chiến thắng 1 lần trong \"Săn Lùng Tàn Lửa\""
  },
  Task_95210_Desc = {
    Text = "Sử dụng người đánh thức từ cõi siêu cấp để giành chiến thắng 2 lần trong \"Săn Lùng Tàn Lửa\""
  },
  Task_95211_Desc = {
    Text = "Hoàn thành \"Tuyên Cáo Lửa\"độ khó Điên loạn"
  },
  Task_95212_Desc = {
    Text = "Săn đuổi tro tàn · Điên loạ"
  },
  Task_95213_Desc = {
    Text = "Sử dụng người đánh thức từ cõi biển sâu để giành chiến thắng 2 lần trong \"Săn Lùng Tàn Lửa\""
  },
  Task_95214_Desc = {
    Text = "Hoàn thành \"Mục Tiêu Hợp Đồng\"độ khó Điên loạn"
  },
  Task_95215_Desc = {
    Text = "Hoàn thành \"Thế Giới Im Lặng\"ở bất kỳ độ khó nào"
  },
  Task_95216_Desc = {
    Text = "Thực hiện vượt ải \"Ánh sáng hủy diệt\"độ khó bất kỳ"
  },
  Task_95217_Desc = {
    Text = "Săn đuổi tro tàn · Cõi"
  },
  Task_95218_Desc = {
    Text = "Hoàn thành \"Bài Ca Địa Ngục\"ở bất kỳ độ khó nào"
  },
  Task_95219_Desc = {
    Text = "Hoàn thành \"Lời Nguyền Cổ Xưa\"ở bất kỳ độ khó nào"
  },
  Task_95220_Desc = {
    Text = "Hoàn thành \"Lời Nguyền Cổ Xưa\"độ khó Điên loạn"
  },
  Task_95221_Desc = {
    Text = "Thực hiện vượt ải \"Ánh sáng hủy diệt\"độ khó điên loạ"
  },
  Task_95222_Desc = {
    Text = "Hoàn thành \"Bài Ca Địa Ngục\"ở bất kỳ độ khó nào"
  },
  Task_95223_Desc = {
    Text = "Hoàn thành tất cả thành tựu trong \"Săn lùng âm phủ\""
  },
  Task_95224_Desc = {
    Text = "Hoàn thành \"Bài Ca Địa Ngục\"độ khó Điên loạn"
  },
  Task_95225_Desc = {
    Text = "Săn đuổi tro tàn · Thông qua"
  },
  Task_95470_Desc = {Text = "Thắng N"},
  Task_95470_Name = {
    Text = "Mục tiêu"
  },
  Task_95520_Desc = {
    Text = "Tích lũy khai thác 16000 bạc nguyên thủy"
  },
  Task_95521_Desc = {
    Text = "Tích lũy khai thác 25000 bạc nguyên thủy"
  },
  Task_95522_Desc = {
    Text = "Tích lũy khai thác 13000 bạc nguyên thủy"
  },
  Task_95523_Desc = {
    Text = "Tích lũy khai thác 8000 bạc nguyên thủy"
  },
  Task_95524_Desc = {
    Text = "Tích lũy khai thác 2000 bạc nguyên thủy"
  },
  Task_95525_Desc = {
    Text = "Tích lũy khai thác 20000 bạc nguyên thủy"
  },
  Task_95526_Desc = {
    Text = "Tích lũy khai thác 4000 bạc nguyên thủy"
  },
  Task_95527_Desc = {
    Text = "Tích lũy khai thác 5000 bạc nguyên thủy"
  },
  Task_95532_Desc = {
    Text = "Ký ức vườn hoa·Điên loạn"
  },
  Task_95533_Desc = {
    Text = "Hoàn thành \"Tro Tàn\"độ khó Điên loạn"
  },
  Task_95534_Desc = {
    Text = "Hoàn thành \"Vương Quốc Nhỏ Bé\"độ khó Điên loạn"
  },
  Task_95535_Desc = {
    Text = "Thực hiện vượt ải \"Bông hồng thứ nhất\"độ khó điên loạ"
  },
  Task_95536_Desc = {
    Text = "Hoàn thành \"Nắm Tay\"độ khó Điên loạn"
  },
  Task_95537_Desc = {
    Text = "Hoàn thành \"Bài Thơ Nở Rộ\"độ khó Điên loạn"
  },
  Task_95543_Desc = {
    Text = "Hoàn thành \"Bông Hồng Đầu Tiên\"ở bất kỳ độ khó nào"
  },
  Task_95544_Desc = {
    Text = "Hoàn thành \"Chấp Thủ\"ở bất kỳ độ khó nào"
  },
  Task_95545_Desc = {
    Text = "Hoàn thành \"Thánh Thi Nở Rộ\"ở bất kỳ độ khó nào"
  },
  Task_95546_Desc = {
    Text = "Hoàn thành \"Tro tàn\"ở bất kỳ độ khó nào"
  },
  Task_95547_Desc = {
    Text = "Hoàn thành \"Vương quốc bé nhỏ\"ở bất kỳ độ khó nào"
  },
  Task_95830_Desc = {
    Text = "Tiệc Tế Giới - Cõi"
  },
  Task_95831_Desc = {
    Text = "Hoàn thành \"Lửa Địa Ngục\"độ khó Điên loạn"
  },
  Task_95832_Desc = {
    Text = "Thực hiện vượt ải \"Nước hoa phân huỷ\"độ khó bất kỳ"
  },
  Task_95833_Desc = {
    Text = "Thực hiện vượt ải \"Nước hoa phân huỷ\"độ khó điên loạ"
  },
  Task_95834_Desc = {
    Text = "Hoàn thành \"Mở Quan Tài\"ở bất kỳ độ khó nào"
  },
  Task_95835_Desc = {
    Text = "Sử dụng người đánh thức từ cõi máu thịt để giành chiến thắng 2 lần trong \"Bữa Tiệc Thần Hồn\""
  },
  Task_95836_Desc = {
    Text = "Khai ngộ 2 khi nhận được Dule-Sain"
  },
  Task_95836_Name = {
    Text = "Khai ngộ 2 khi nhận được Dule-Sain"
  },
  Task_95836_UnlockCondDesc = {
    Text = "Sự kiện@Người đánh thức Dullesain Khai ngộ gói quà 2 sự kiện"
  },
  Task_95837_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_95838_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_95839_Desc = {
    Text = "Hoàn thành \"Mở Quan Tài\"ở bất kỳ độ khó nào"
  },
  Task_95840_Desc = {
    Text = "Sử dụng người đánh thức từ cõi hỗn loạn để giành chiến thắng 1 lần trong \"Bữa Tiệc Thần Hồn\""
  },
  Task_95841_Desc = {
    Text = "Sử dụng người đánh thức từ cõi máu thịt để giành chiến thắng 1 lần trong \"Bữa Tiệc Thần Hồn\""
  },
  Task_95842_Desc = {
    Text = "Thực hiện vượt ải \"Xương thịt tách rời\"độ khó điên loạ"
  },
  Task_95843_Desc = {
    Text = "Hoàn thành \"Tiệc Linh Cái\"độ khó Điên loạn"
  },
  Task_95844_Desc = {
    Text = "Hoàn thành \"Lửa Địa Ngục\"ở bất kỳ độ khó nào"
  },
  Task_95845_Desc = {
    Text = "Hoàn thành \"Lửa Địa Ngục\"ở bất kỳ độ khó nào"
  },
  Task_95846_Desc = {
    Text = "Sự tương hợp của Đỗ Lê Sa Yên đạt cấp 10"
  },
  Task_95847_Desc = {
    Text = "Tiệc linh hồn · Thông qua"
  },
  Task_95848_Desc = {
    Text = "Hoàn thành tất cả nhiệm vụ trong \"Bữa tiệc nuốt linh hồn\""
  },
  Task_95849_Desc = {
    Text = "Hoàn thành \"Mở Quan Tài\"độ khó Điên loạn"
  },
  Task_95850_Desc = {
    Text = "Khai ngộ 6 khi nhận được Dule-Sain"
  },
  Task_95850_Name = {
    Text = "Khai ngộ 6 khi nhận được Dule-Sain"
  },
  Task_95850_UnlockCondDesc = {
    Text = "Sự kiện@Người đánh thức Dullesain Khai ngộ gói quà 2 sự kiện"
  },
  Task_95853_Desc = {
    Text = "Thực hiện vượt ải \"Xương thịt tách rời\"độ khó bất kỳ"
  },
  Task_95854_Desc = {
    Text = "Tiệc linh hồn · Điên loạn"
  },
  Task_95855_Desc = {
    Text = "Hoàn thành \"Tiệc Linh Cái\"ở bất kỳ độ khó nào"
  },
  Task_95856_Desc = {
    Text = "Sử dụng người đánh thức từ cõi biển sâu để giành chiến thắng 1 lần trong \"Bữa Tiệc Thần Hồn\""
  },
  Task_95857_Desc = {
    Text = "Thực hiện vượt ải \"Nước hoa phân huỷ\"độ khó bất kỳ"
  },
  Task_95858_Desc = {
    Text = "Sử dụng người đánh thức từ cõi siêu cấp để giành chiến thắng 1 lần trong \"Bữa Tiệc Thần Hồn\""
  },
  Task_95860_Desc = {
    Text = "Sử dụng người đánh thức từ cõi siêu cấp để giành chiến thắng 2 lần trong \"Bữa Tiệc Thần Hồn\""
  },
  Task_95861_Desc = {
    Text = "Thực hiện vượt ải \"Xương thịt tách rời\"độ khó bất kỳ"
  },
  Task_95862_Desc = {
    Text = "Sử dụng người đánh thức từ cõi biển sâu để giành chiến thắng 2 lần trong \"Bữa Tiệc Thần Hồn\""
  },
  Task_95863_Desc = {
    Text = "Hoàn thành \"Tiệc Linh Cái\"ở bất kỳ độ khó nào"
  },
  Task_95864_Desc = {
    Text = "Sử dụng người đánh thức từ cõi hỗn loạn để giành chiến thắng 2 lần trong \"Bữa Tiệc Thần Hồn\""
  },
  Task_95865_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_95866_UnlockCondDesc = {
    Text = "Vui lòng nhận gói quà trước đó"
  },
  Task_96333_Desc = {
    Text = "Đạt được tổng cộng 10 trận thắng trong mùa giải này"
  },
  Task_96333_Name = {Text = "10 thắng"},
  Task_96334_Desc = {
    Text = "Đạt được 3 trận thắng trong mùa giải này"
  },
  Task_96334_Name = {
    Text = "3 trận thắng"
  },
  Task_96335_Desc = {
    Text = "Đạt được tổng cộng 6 trận thắng trong mùa giải này"
  },
  Task_96335_Name = {Text = "6 thắng"},
  Task_96336_Desc = {
    Text = "Đạt được tích lũy 1 trận thắng trong mùa giải này"
  },
  Task_96336_Name = {
    Text = "1 trận thắng"
  },
  Task_96618_Desc = {
    Text = "Trong cửa hàng, sử dụng vé vàng để đổi 3 lần"
  },
  Task_96619_Desc = {
    Text = "Hoàn thành 20 nhiệm vụ"
  },
  Task_96620_Desc = {
    Text = "Giá trị luyện tập ở khu vực d-khu vực đạt đến 100"
  },
  Task_96621_Desc = {
    Text = "Hoàn thành 1 lần \"24\" màn chơi hỗn mang thử nghiệm"
  },
  Task_96622_Desc = {
    Text = "Hoàn thành tất cả các nhiệm vụ thử thách hàng tuần trong 2 tuần"
  },
  Task_96623_Desc = {
    Text = "Thực hiện vượt ải tồn tại siêu nghiệm 1 lầ"
  },
  Task_96624_Desc = {
    Text = "Tích lũy đăng nhập 15 ngày"
  },
  Task_96625_Desc = {
    Text = "Hoàn thành 20 nhiệm vụ"
  },
  Task_96626_Desc = {
    Text = "Giá trị luyện tập ở khu vực d-khu vực đạt đến 100"
  },
  Task_96627_Desc = {
    Text = "Thực hiện vượt ải tồn tại siêu nghiệm 1 lầ"
  },
  Task_96628_Desc = {
    Text = "Tiêu hao 1800 điểm Menophin"
  },
  Task_96629_Desc = {
    Text = "Đăng nhập liên tiếp 1 ngày"
  },
  Task_96630_Desc = {
    Text = "Đăng nhập liên tiếp 1 ngày"
  },
  Task_96631_Desc = {
    Text = "Trong cửa hàng, sử dụng vé vàng để đổi 3 lần"
  },
  Task_96632_Desc = {
    Text = "Tiêu hao 1800 điểm Menophin"
  },
  Task_96633_Desc = {
    Text = "Hoàn thành 1 lần \"24\" màn chơi hỗn mang thử nghiệm"
  },
  Task_96840_Desc = {
    Text = "Cuốn tranh dị giới·Thông qua"
  },
  Task_96841_Desc = {
    Text = "Hoàn thành \"Biến Đổi Địa Ngục\" với bất kỳ độ khó nào"
  },
  Task_96842_Desc = {
    Text = "Vượt qua \"Múa điên Kim Ngưu\" bất kỳ độ khó"
  },
  Task_96843_Desc = {
    Text = "Vượt qua \"Tơ hồn hoành hành\" bất kỳ độ khó"
  },
  Task_96844_Desc = {
    Text = "Vượt qua \"Cuồng hoan định cách\" độ khó Điên loạn"
  },
  Task_96845_Desc = {
    Text = "Vượt qua \"Múa điên Kim Ngưu\" độ khó Điên loạn"
  },
  Task_96846_Desc = {
    Text = "Sử dụng người đánh thức trong vương quốc siêu cấp để thắng 2 lần trong \"Bản đồ bên ngoài\""
  },
  Task_96847_Desc = {
    Text = "Vượt qua \"Cảm hứng nhiễm bẩn\" bất kỳ độ khó"
  },
  Task_96848_Desc = {
    Text = "Vượt qua \"Lan tràn máu đỏ\" độ khó Điên loạn"
  },
  Task_96849_Desc = {
    Text = "Vượt qua \"Lan tràn máu đỏ\" bất kỳ độ khó"
  },
  Task_96850_Desc = {
    Text = "Vượt qua \"Múa điên Kim Ngưu\" bất kỳ độ khó"
  },
  Task_96851_Desc = {
    Text = "Vượt qua \"Lan tràn máu đỏ\" bất kỳ độ khó"
  },
  Task_96852_Desc = {
    Text = "Sử dụng người đánh thức trong cõi hỗn loạn để thắng 2 lần trong \"Bản đồ bên ngoài\""
  },
  Task_96853_Desc = {
    Text = "Hoàn thành tất cả thành tựu của \"Bản đồ thế giới khác·Thông qua\""
  },
  Task_96854_Desc = {
    Text = "Vượt qua \"Tơ hồn hoành hành\" bất kỳ độ khó"
  },
  Task_96855_Desc = {
    Text = "Vượt qua \"Cuồng hoan định cách\" bất kỳ độ khó"
  },
  Task_96856_Desc = {
    Text = "Cuốn tranh dị giới·Cõi"
  },
  Task_96857_Desc = {
    Text = "Sử dụng người đánh thức trong vùng biển sâu để thắng 2 lần trong \"Bản đồ bên ngoài\""
  },
  Task_96858_Desc = {
    Text = "Vượt qua \"Tơ hồn hoành hành\" độ khó Điên loạn"
  },
  Task_96859_Desc = {
    Text = "Sử dụng người đánh thức trong cõi máu thịt để thắng 1 lần trong \"Bản đồ bên ngoài\""
  },
  Task_96860_Desc = {
    Text = "Hoàn thành \"Biến Đổi Địa Ngục\" với bất kỳ độ khó nào"
  },
  Task_96861_Desc = {
    Text = "Sử dụng người đánh thức trong cõi hỗn loạn để thắng 1 lần trong \"Bản đồ bên ngoài\""
  },
  Task_96862_Desc = {
    Text = "Thông qua Kẻ lang thang \"Ảo thế họa\""
  },
  Task_96863_Desc = {
    Text = "Vượt qua \"Gò đỉnh ác mộng\" bất kỳ độ khó"
  },
  Task_96864_Desc = {
    Text = "Sử dụng người đánh thức trong vùng biển sâu để thắng 1 lần trong \"Bản đồ bên ngoài\""
  },
  Task_96865_Desc = {
    Text = "Vượt qua \"Cảm hứng nhiễm bẩn\" độ khó Điên loạn"
  },
  Task_96866_Desc = {
    Text = "Vượt qua \"Gò đỉnh ác mộng\" bất kỳ độ khó"
  },
  Task_96867_Desc = {
    Text = "Cuốn tranh dị giới·Điên loạn"
  },
  Task_96868_Desc = {
    Text = "Vượt qua \"Cuồng hoan định cách\" bất kỳ độ khó"
  },
  Task_96869_Desc = {
    Text = "Vượt qua \"Cảm hứng nhiễm bẩn\" bất kỳ độ khó"
  },
  Task_96870_Desc = {
    Text = "Sử dụng người đánh thức trong cõi máu thịt để thắng 2 lần trong \"Bản đồ bên ngoài\""
  },
  Task_96871_Desc = {
    Text = "Vượt qua \"Biến đổi địa ngục\" độ khó Điên loạn"
  },
  Task_96872_Desc = {
    Text = "Vượt qua \"Gò đỉnh ác mộng\" độ khó Điên loạn"
  },
  Task_96873_Desc = {
    Text = "Sử dụng người đánh thức trong vương quốc siêu cấp để thắng 1 lần trong \"Bản đồ bên ngoài\""
  },
  Task_97192_Desc = {
    Text = "Đăng nhập liên tiếp 1 ngày"
  },
  Task_97193_Desc = {
    Text = "Hoàn thành 20 nhiệm vụ"
  },
  Task_97194_Desc = {
    Text = "Đăng nhập liên tiếp 1 ngày"
  },
  Task_97195_Desc = {
    Text = "Vượt qua 1 lần bản chơi thử của Dulcein"
  },
  Task_97196_Desc = {
    Text = "Hoàn thành thách thức hàng tuần trong 2 tuần"
  },
  Task_97197_Desc = {
    Text = "Giá trị luyện tập ở khu vực d-khu vực đạt đến 100"
  },
  Task_97198_Desc = {
    Text = "Tiêu hao 1800 điểm Menophin"
  },
  Task_97199_Desc = {
    Text = "Thực hiện vượt ải tồn tại siêu nghiệm 1 lầ"
  },
  Task_97200_Desc = {
    Text = "Thực hiện vượt ải tồn tại siêu nghiệm 1 lầ"
  },
  Task_97201_Desc = {
    Text = "Tiêu hao 1800 điểm Menophin"
  },
  Task_97202_Desc = {
    Text = "Hoàn thành 3 lần nhiệm vụ hàng ngày"
  },
  Task_97203_Desc = {
    Text = "Vượt qua 1 lần bản chơi thử của Dulcein"
  },
  Task_97243_Desc = {
    Text = "Hoàn thành 20 nhiệm vụ"
  },
  Task_97244_Desc = {
    Text = "Hoàn thành thách thức hàng tuần trong 2 tuần"
  },
  Task_97245_Desc = {
    Text = "Giá trị luyện tập ở khu vực d-khu vực đạt đến 100"
  },
  Task_97246_Desc = {
    Text = "Hoàn thành 3 lần nhiệm vụ hàng ngày"
  },
  Task_97309_Desc = {
    Text = "Trong cuộc điều tra sự kiện \"@1@2\" gây cộng hưởng 6 lần"
  },
  Task_97309_Desc2 = {
    Text = "Cộng hưởng 6 lần trong điều tra sự kiện \"Fiesta\""
  },
  Task_97309_Name2 = {
    Text = "Dư âm phàm ănIII"
  },
  Task_97310_Desc = {
    Text = "Trong cuộc điều tra sự kiện \"@1@2\" cộng hưởng 9 lần"
  },
  Task_97310_Desc2 = {
    Text = "Rung động 9 lần trong điều tra sự kiện \"Thỏa mãn\""
  },
  Task_97310_Name2 = {
    Text = "Dư âm phàm ănIV"
  },
  Task_97311_Desc = {
    Text = "Trong sự kiện điều tra \"@1@2\" cộng hưởng 2 lần"
  },
  Task_97311_Desc2 = {
    Text = "Rung động 2 lần trong điều tra sự kiện \"Thỏa mãn\""
  },
  Task_97311_Name2 = {
    Text = "Dư âm phàm ăn"
  },
  Task_97312_Desc = {
    Text = "Trong sự kiện điều tra \"@1@2\" cộng hưởng 4 lần"
  },
  Task_97312_Desc2 = {
    Text = "Rung động 4 lần trong điều tra sự kiện \"Thỏa mãn\""
  },
  Task_97312_Name2 = {
    Text = "Dư âm phàm ănII"
  },
  Task_97322_Desc = {
    Text = "Khi bảo vệ hoàn hảo tấm rèm mộng tưởng, đánh bại \"Con rối của vẻ thối nát\"."
  },
  Task_97322_Name = {
    Text = "Một Lời hứa, Một sự trông chờ·Ẩn giấu"
  },
  Task_97673_Desc = {
    Text = "Thông quan \"Ngày thứ năm\"độ khó Điên loạ"
  },
  Task_97674_Desc = {
    Text = "Thông quan \"Ngày thứ nhất\"độ khó Điên loạ"
  },
  Task_97675_Desc = {
    Text = "Thông quan \"Ngày thứ hai\" bất kỳ độ khó"
  },
  Task_97676_Desc = {
    Text = "Sáng tạo trong bảy ngày·thông qua"
  },
  Task_97677_Desc = {
    Text = "Thông quan \"Ngày thứ bảy\" bất kỳ độ khó"
  },
  Task_97678_Desc = {
    Text = "Sử dụng thể thức tỉnh hỗn mang để thắng 1 lần trong \"Sáng tạo bảy ngày\""
  },
  Task_97679_Desc = {
    Text = "Hoàn thành tất cả thành tựu của \"Sáng sinh bảy ngày·Thông qua\""
  },
  Task_97680_Desc = {
    Text = "Thông quan \"Ngày thứ hai\"độ khó Điên loạ"
  },
  Task_97681_Desc = {
    Text = "Thông quan \"Ngày thứ bảy\"độ khó Điên loạ"
  },
  Task_97682_Desc = {
    Text = "Thông quan \"Ngày thứ bảy\" bất kỳ độ khó"
  },
  Task_97683_Desc = {
    Text = "Thông quan \"Ngày thứ sáu\" bất kỳ độ khó"
  },
  Task_97684_Desc = {
    Text = "Thông quan \"Ngày thứ nhất\" bất kỳ độ khó"
  },
  Task_97685_Desc = {
    Text = "Thông quan \"Ngày thứ ba\"độ khó Điên loạ"
  },
  Task_97686_Desc = {
    Text = "Sử dụng thể thức tỉnh siêu chiều để thắng 1 lần trong \"Sáng tạo bảy ngày\""
  },
  Task_97687_Desc = {
    Text = "Sử dụng thể thức tỉnh huyết nhục để thắng 1 lần trong \"Sáng tạo bảy ngày\""
  },
  Task_97688_Desc = {
    Text = "Thông quan \"Ngày thứ tư\"độ khó Điên loạ"
  },
  Task_97689_Desc = {
    Text = "Thông quan \"Ngày thứ nhất\" bất kỳ độ khó"
  },
  Task_97690_Desc = {
    Text = "Sử dụng thể thức tỉnh siêu chiều để thắng 2 lần trong \"Sáng tạo bảy ngày\""
  },
  Task_97691_Desc = {
    Text = "Thông quan \"Ngày thứ tư\" bất kỳ độ khó"
  },
  Task_97692_Desc = {
    Text = "Sử dụng thể thức tỉnh vùng biển sâu để thắng 1 lần trong \"Sáng tạo bảy ngày\""
  },
  Task_97693_Desc = {
    Text = "Thông quan \"Ngày thứ ba\" bất kỳ độ khó"
  },
  Task_97694_Desc = {
    Text = "Sử dụng thể thức tỉnh hỗn mang để thắng 2 lần trong \"Sáng tạo bảy ngày\""
  },
  Task_97695_Desc = {
    Text = "Thông quan \"Ngày thứ sáu\" bất kỳ độ khó"
  },
  Task_97696_Desc = {
    Text = "Sử dụng thể thức tỉnh huyết nhục để thắng 2 lần trong \"Sáng tạo bảy ngày\""
  },
  Task_97697_Desc = {
    Text = "Thông quan \"Ngày thứ sáu\"độ khó Điên loạ"
  },
  Task_97698_Desc = {
    Text = "Sáng tạo trong bảy ngày·điên loạn"
  },
  Task_97699_Desc = {
    Text = "Thông quan \"Ngày thứ tư\" bất kỳ độ khó"
  },
  Task_97700_Desc = {
    Text = "Sáng tạo trong bảy ngày·cõi"
  },
  Task_97701_Desc = {
    Text = "Sử dụng thể thức tỉnh vùng biển sâu để thắng 2 lần trong \"Sáng tạo bảy ngày\""
  },
  Task_97702_Desc = {
    Text = "Thông quan \"Ngày thứ hai\" bất kỳ độ khó"
  },
  Task_97703_Desc = {
    Text = "Thông quan \"Ngày thứ ba\" bất kỳ độ khó"
  },
  Task_97704_Desc = {
    Text = "Thông quan \"Ngày thứ năm\" bất kỳ độ khó"
  },
  Task_97705_Desc = {
    Text = "Thông quan \"Ngày thứ năm\" bất kỳ độ khó"
  },
  Task_97855_Desc = {
    Text = "Sử dụng Người Đánh Thức trong Vùng Thịt Máu để thắng 1 lần trong \"Sự mới mẻ dưới ánh nắng mặt trời\""
  },
  Task_97856_Desc = {
    Text = "Đăng nhập liên tiếp 6 ngày"
  },
  Task_97857_Desc = {
    Text = "Đăng nhập liên tiếp 4 ngày"
  },
  Task_97858_Desc = {
    Text = "Hoàn thành \"Vườn hoa thơ mộng\"độ khó điên loạn"
  },
  Task_97859_Desc = {
    Text = "Thông qua thế giới mộng mơ\"Tạm biệt, miền không có\""
  },
  Task_97860_Desc = {
    Text = "Đăng nhập liên tiếp 3 ngày"
  },
  Task_97861_Desc = {
    Text = "Hoàn thành tất cả thành tựu của \"Điều mới trong ánh nắng· Khám phá quý giá\""
  },
  Task_97862_Desc = {
    Text = "Sử dụng Người Đánh Thức trong Vùng Hỗn Loạn để thắng 2 lần trong \"Sự mới mẻ dưới ánh nắng mặt trời\""
  },
  Task_97863_Desc = {
    Text = "Sử dụng Người Đánh Thức trong Vùng Biển Sâu để thắng 1 lần trong \"Sự mới mẻ dưới ánh nắng mặt trời\""
  },
  Task_97864_Desc = {
    Text = "Hoàn thành \"Trở về nơi cũ\"độ khó điên loạn"
  },
  Task_97865_Desc = {
    Text = "Sự việc mới dưới ánh nắng · Thông qua"
  },
  Task_97866_Desc = {
    Text = "Sự việc mới dưới ánh nắng · Cõi"
  },
  Task_97867_Desc = {
    Text = "Hoàn thành \"Câu chuyện hoàn hảo\"độ khó điên loạn"
  },
  Task_97868_Desc = {
    Text = "Hoàn thành \"Vườn hoa thơ mộng\"ở mọi độ khó"
  },
  Task_97869_Desc = {
    Text = "Sử dụng Người Đánh Thức trong Vùng Siêu Cấp để thắng 1 lần trong \"Sự mới mẻ dưới ánh nắng mặt trời\""
  },
  Task_97870_Desc = {
    Text = "Hoàn thành \"Giấc mơ cơ khí\"ở mọi độ khó"
  },
  Task_97871_Desc = {
    Text = "Hoàn thành \"Đối mặt với mặt trời đen\"độ khó điên loạn"
  },
  Task_97872_Desc = {
    Text = "Hoàn thành \"Đối mặt với mặt trời đen\"ở mọi độ khó"
  },
  Task_97873_Desc = {
    Text = "Hoàn thành \"Câu chuyện hoàn hảo\"ở mọi độ khó"
  },
  Task_97874_Desc = {
    Text = "Sử dụng Người Đánh Thức trong Vùng Thịt Máu để thắng 2 lần trong \"Sự mới mẻ dưới ánh nắng mặt trời\""
  },
  Task_97875_Desc = {
    Text = "Đăng nhập liên tiếp 5 ngày"
  },
  Task_97876_Desc = {
    Text = "Hoàn thành \"Trở về nơi cũ\"ở mọi độ khó"
  },
  Task_97877_Desc = {
    Text = "Đăng nhập liên tiếp 7 ngày"
  },
  Task_97878_Desc = {
    Text = "Hoàn thành \"Giấc mơ cơ khí\"độ khó điên loạn"
  },
  Task_97879_Desc = {
    Text = "Hoàn thành \"Đối mặt với mặt trời đen\"ở mọi độ khó"
  },
  Task_97880_Desc = {
    Text = "Đăng nhập liên tiếp 2 ngày"
  },
  Task_97881_Desc = {
    Text = "Hoàn thành \"Câu chuyện hoàn hảo\"ở mọi độ khó"
  },
  Task_97882_Desc = {
    Text = "Hoàn thành \"Giấc mơ cơ khí\"ở mọi độ khó"
  },
  Task_97883_Desc = {
    Text = "Sử dụng Người Đánh Thức trong Vùng Hỗn Loạn để thắng 1 lần trong \"Sự mới mẻ dưới ánh nắng mặt trời\""
  },
  Task_97884_Desc = {
    Text = "Đăng nhập liên tiếp 1 ngày"
  },
  Task_97885_Desc = {
    Text = "Sự việc mới dưới ánh nắng · Điên loạn"
  },
  Task_97886_Desc = {
    Text = "7 ngày đăng nhập"
  },
  Task_97887_Desc = {
    Text = "Sử dụng Người Đánh Thức trong Vùng Siêu Cấp để thắng 2 lần trong \"Sự mới mẻ dưới ánh nắng mặt trời\""
  },
  Task_97888_Desc = {
    Text = "Hoàn thành \"Trở về nơi cũ\"ở mọi độ khó"
  },
  Task_97889_Desc = {
    Text = "Sử dụng Người Đánh Thức trong Vùng Biển Sâu để thắng 2 lần trong \"Sự mới mẻ dưới ánh nắng mặt trời\""
  },
  Task_97890_Desc = {
    Text = "Hoàn thành \"Vườn hoa thơ mộng\"ở mọi độ khó"
  },
  Task_97952_Desc = {
    Text = "Thông qua thế giới mộng mơ\"Tạm biệt, miền không có\""
  },
  Task_97953_Desc = {
    Text = "Hoàn thành 4 lần nhiệm vụ hàng ngày"
  },
  Task_97954_Desc = {
    Text = "Thông qua thế giới mộng mơ\"Tạm biệt, miền không có\""
  },
  Task_97955_Desc = {
    Text = "Đăng nhập liên tiếp 1 ngày"
  },
  Task_97956_Desc = {
    Text = "Thực hiện vượt ải tồn tại siêu nghiệm 1 lầ"
  },
  Task_97957_Desc = {
    Text = "Tiêu hao 1500 điểm Menophin"
  },
  Task_97958_Desc = {
    Text = "Hoàn thành 4 lần nhiệm vụ hàng ngày"
  },
  Task_97959_Desc = {
    Text = "Hoàn thành 20 nhiệm vụ"
  },
  Task_97960_Desc = {
    Text = "Tiêu hao 1500 điểm Menophin"
  },
  Task_97961_Desc = {
    Text = "Tổng tiêu hao 100000 hoa hồng vàng"
  },
  Task_97962_Desc = {
    Text = "Hoàn thành 20 nhiệm vụ"
  },
  Task_97963_Desc = {
    Text = "Giá trị luyện tập ở khu vực d-khu vực đạt đến 100"
  },
  Task_97964_Desc = {
    Text = "Giá trị luyện tập ở khu vực d-khu vực đạt đến 100"
  },
  Task_97965_Desc = {
    Text = "Tổng tiêu hao 100000 hoa hồng vàng"
  },
  Task_97966_Desc = {
    Text = "Thực hiện vượt ải tồn tại siêu nghiệm 1 lầ"
  },
  Task_97967_Desc = {
    Text = "Đăng nhập liên tiếp 1 ngày"
  },
  Task_98151_Desc = {
    Text = "Hải vực thai động · độc quyền có thời hạn"
  },
  Task_98347_Desc = {
    Text = "Đạt được tổng cộng 10 trận thắng trong mùa giải này"
  },
  Task_98347_Name = {Text = "10 thắng"},
  Task_98348_Desc = {
    Text = "Đạt được 3 trận thắng trong mùa giải này"
  },
  Task_98348_Name = {
    Text = "3 trận thắng"
  },
  Task_98349_Desc = {
    Text = "Đạt được tổng cộng 6 trận thắng trong mùa giải này"
  },
  Task_98349_Name = {Text = "6 thắng"},
  Task_98350_Desc = {
    Text = "Đạt được tích lũy 1 trận thắng trong mùa giải này"
  },
  Task_98350_Name = {
    Text = "1 trận thắng"
  },
  Task_98505_Desc = {
    Text = "Hoàn thành hành trình tâm trí\"Không Hồi Tục\""
  },
  Task_98505_Name = {
    Text = "Ngày ngày vỡ vụn của niềm vui"
  },
  Task_98700_Desc = {
    Text = "Tích lũy đăng nhập 15 ngày"
  },
  Task_98701_Desc = {
    Text = "Hoàn thành tất cả các nhiệm vụ thử thách hàng tuần trong 2 tuần"
  }
})
return Text_Task
