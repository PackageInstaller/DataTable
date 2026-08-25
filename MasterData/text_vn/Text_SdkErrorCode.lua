__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_SdkErrorCode = readonly({
  SdkErrorCode_67975_Content = {
    Text = "Lỗi đọc/ghi tệp, vui lòng thử khởi động lại trò chơi hoặc sửa chữa ứng dụng khách"
  },
  SdkErrorCode_67988_Content = {
    Text = "Kết nối mạng bất thường, vui lòng thử khởi động lại trò chơi hoặc kiểm tra mạng"
  },
  SdkErrorCode_67989_Content = {
    Text = "Kết nối mạng bất thường, vui lòng thử khởi động lại trò chơi hoặc kiểm tra mạng"
  },
  SdkErrorCode_67990_Content = {
    Text = "Kết nối mạng bất thường, vui lòng thử khởi động lại trò chơi hoặc kiểm tra mạng"
  },
  SdkErrorCode_67991_Content = {
    Text = "Kết nối mạng bất thường, vui lòng thử khởi động lại trò chơi hoặc kiểm tra mạng"
  },
  SdkErrorCode_67992_Content = {
    Text = "Kết nối mạng bất thường, vui lòng thử khởi động lại trò chơi hoặc kiểm tra mạng"
  },
  SdkErrorCode_67993_Content = {
    Text = "Kết nối mạng bất thường, vui lòng thử khởi động lại trò chơi hoặc kiểm tra mạng"
  },
  SdkErrorCode_67994_Content = {
    Text = "Kết nối mạng bất thường, vui lòng thử khởi động lại trò chơi hoặc kiểm tra mạng"
  },
  SdkErrorCode_68020_Content = {
    Text = "Kết nối mạng bất thường, vui lòng thử khởi động lại trò chơi hoặc kiểm tra mạng"
  },
  SdkErrorCode_68022_Content = {
    Text = "Lỗi tải file, vui lòng kiểm tra dung lượng còn lại trên thiết bị"
  },
  SdkErrorCode_68023_Content = {
    Text = "Mạng không ổn định, vui lòng kiểm tra kết nối mạng và thử lại"
  },
  SdkErrorCode_68024_Content = {
    Text = "Không có kết nối mạng,vui lòng kiểm tra mạng và thử lại"
  },
  SdkErrorCode_68027_Content = {
    Text = "Không có kết nối mạng,vui lòng kiểm tra mạng và thử lại"
  },
  SdkErrorCode_68033_Content = {
    Text = "Lỗi đọc ghi tệp, xin vui lòng thử khởi động lại trò chơi"
  },
  SdkErrorCode_68035_Content = {
    Text = "Lỗi đọc ghi tệp, xin vui lòng thử khởi động lại trò chơi"
  },
  SdkErrorCode_68037_Content = {
    Text = "Trò chơi gọi giao diện acquire nhiều lần trong thời gian ngắn, có khả năng cao nhận được một ejoy_token đã hết hạn (16 token sẽ ghi đè lẫn nhau), dùng để đăng nhập vào máy chủ trò chơi sẽ báo lỗi 401"
  },
  SdkErrorCode_68058_Content = {
    Text = "Lỗi đọc/ghi tệp, xin thử khởi động lại trò chơi hoặc kiểm tra quyền ứng dụng"
  },
  SdkErrorCode_68060_Content = {
    Text = "Kết nối mạng bất thường, vui lòng thử khởi động lại trò chơi hoặc kiểm tra mạng"
  },
  SdkErrorCode_68061_Content = {
    Text = "Kết nối mạng bất thường, vui lòng thử khởi động lại trò chơi hoặc kiểm tra mạng"
  },
  SdkErrorCode_68062_Content = {
    Text = "Kết nối mạng bất thường, vui lòng thử khởi động lại trò chơi hoặc kiểm tra mạng"
  },
  SdkErrorCode_68063_Content = {
    Text = "Kết nối mạng bất thường, vui lòng thử khởi động lại trò chơi hoặc kiểm tra mạng"
  },
  SdkErrorCode_68064_Content = {
    Text = "Kết nối mạng bất thường, vui lòng thử khởi động lại trò chơi hoặc kiểm tra mạng"
  },
  SdkErrorCode_68065_Content = {
    Text = "Kết nối mạng bất thường, vui lòng thử khởi động lại trò chơi hoặc kiểm tra mạng"
  },
  SdkErrorCode_68066_Content = {
    Text = "Kết nối mạng bất thường, vui lòng thử khởi động lại trò chơi hoặc kiểm tra mạng"
  },
  SdkErrorCode_68067_Content = {
    Text = "Kết nối mạng bất thường, vui lòng thử khởi động lại trò chơi hoặc kiểm tra mạng"
  },
  SdkErrorCode_68068_Content = {
    Text = "Kết nối mạng bất thường, vui lòng thử khởi động lại trò chơi hoặc kiểm tra mạng"
  },
  SdkErrorCode_68069_Content = {
    Text = "Kết nối mạng bất thường, vui lòng thử khởi động lại trò chơi hoặc kiểm tra mạng"
  },
  SdkErrorCode_68071_Content = {
    Text = "Kết nối mạng bất thường, vui lòng thử khởi động lại trò chơi hoặc kiểm tra mạng"
  },
  SdkErrorCode_68072_Content = {
    Text = "Kết nối mạng bất thường, vui lòng thử khởi động lại trò chơi hoặc kiểm tra mạng"
  },
  SdkErrorCode_68073_Content = {
    Text = "Lỗi đọc ghi tệp, xin vui lòng thử khởi động lại trò chơi"
  },
  SdkErrorCode_68077_Content = {
    Text = "Lỗi đọc bộ đệm, vui lòng thử khởi động lại trò chơi"
  },
  SdkErrorCode_68078_Content = {
    Text = "Kết nối mạng bất thường, vui lòng thử khởi động lại trò chơi hoặc kiểm tra mạng"
  },
  SdkErrorCode_68082_Content = {
    Text = "Kết nối mạng bất thường, vui lòng thử khởi động lại trò chơi hoặc kiểm tra mạng"
  },
  SdkErrorCode_68100_Content = {
    Text = "Kết nối mạng bất thường, vui lòng thử khởi động lại trò chơi hoặc kiểm tra mạng"
  },
  SdkErrorCode_68109_Content = {
    Text = "Kết nối mạng bất thường, vui lòng thử khởi động lại trò chơi hoặc kiểm tra mạng"
  },
  SdkErrorCode_68110_Content = {
    Text = "Kết nối mạng bất thường, vui lòng thử khởi động lại trò chơi hoặc kiểm tra mạng"
  },
  SdkErrorCode_68111_Content = {
    Text = "Kết nối mạng bất thường, vui lòng thử khởi động lại trò chơi hoặc kiểm tra mạng"
  },
  SdkErrorCode_68112_Content = {
    Text = "Kết nối mạng bất thường, vui lòng thử khởi động lại trò chơi hoặc kiểm tra mạng"
  },
  SdkErrorCode_68113_Content = {
    Text = "Kết nối mạng bất thường, vui lòng thử khởi động lại trò chơi hoặc kiểm tra mạng"
  },
  SdkErrorCode_68114_Content = {
    Text = "Kết nối mạng bất thường, vui lòng thử khởi động lại trò chơi hoặc kiểm tra mạng"
  },
  SdkErrorCode_68115_Content = {
    Text = "Kết nối mạng bất thường, vui lòng thử khởi động lại trò chơi hoặc kiểm tra mạng"
  },
  SdkErrorCode_68116_Content = {
    Text = "Kết nối mạng bất thường, vui lòng thử khởi động lại trò chơi hoặc kiểm tra mạng"
  },
  SdkErrorCode_68118_Content = {
    Text = "Kết nối mạng bất thường, vui lòng thử khởi động lại trò chơi hoặc kiểm tra mạng"
  },
  SdkErrorCode_68119_Content = {
    Text = "Lỗi đọc ghi tệp, xin vui lòng thử khởi động lại trò chơi"
  },
  SdkErrorCode_68120_Content = {
    Text = "Lỗi đọc ghi tệp, xin vui lòng thử khởi động lại trò chơi"
  },
  SdkErrorCode_68121_Content = {
    Text = "Kết nối mạng bất thường, vui lòng thử khởi động lại trò chơi hoặc kiểm tra mạng"
  },
  SdkErrorCode_68133_Content = {
    Text = "Mạng không tốt, vui lòng kiểm tra mạng hay khởi động lại trò chơi và thử lại"
  },
  SdkErrorCode_68153_Content = {
    Text = "Kết nối mạng bất thường, vui lòng thử khởi động lại trò chơi hoặc kiểm tra mạng"
  },
  SdkErrorCode_68158_Content = {
    Text = "Mạng bận, xin vui lòng thử lại sau"
  },
  SdkErrorCode_68159_Content = {
    Text = "Lỗi tải file, vui lòng kiểm tra dung lượng còn lại trên thiết bị"
  },
  SdkErrorCode_68170_Content = {
    Text = "Mạng bận, xin vui lòng thử lại sau"
  },
  SdkErrorCode_68173_Content = {
    Text = "Mạng bận, xin vui lòng thử lại sau"
  },
  SdkErrorCode_68174_Content = {
    Text = "Mạng bận, xin vui lòng thử lại sau"
  },
  SdkErrorCode_68175_Content = {
    Text = "Mạng bận, xin vui lòng thử lại sau"
  },
  SdkErrorCode_68176_Content = {
    Text = "Không có kết nối mạng, vui lòng kiểm tra mạng"
  },
  SdkErrorCode_68189_Content = {
    Text = "Kết nối mạng bất thường, vui lòng thử khởi động lại trò chơi hoặc kiểm tra mạng"
  },
  SdkErrorCode_68190_Content = {
    Text = "Kết nối mạng bất thường, vui lòng thử khởi động lại trò chơi hoặc kiểm tra mạng"
  },
  SdkErrorCode_68199_Content = {
    Text = "Mạng bị ngắt kết nối, xin kiểm tra mạng"
  },
  SdkErrorCode_68201_Content = {
    Text = "Mạng bị ngắt kết nối, xin kiểm tra mạng"
  },
  SdkErrorCode_68202_Content = {
    Text = "Lỗi mạng, kiểm tra kết nối"
  },
  SdkErrorCode_68205_Content = {
    Text = "Mạng bị ngắt kết nối, xin kiểm tra mạng"
  },
  SdkErrorCode_68207_Content = {
    Text = "Kết nối mạng bị ngắt, kiểm tra mạng"
  },
  SdkErrorCode_68210_Content = {
    Text = "Lỗi mạng, kiểm tra kết nối"
  },
  SdkErrorCode_68235_Content = {
    Text = "Mạng không ổn định, vui lòng kiểm tra kết nối mạng và thử lại"
  },
  SdkErrorCode_68236_Content = {
    Text = "Không có kết nối mạng,vui lòng kiểm tra mạng và thử lại"
  },
  SdkErrorCode_68241_Content = {
    Text = "Mạng không ổn định, vui lòng kiểm tra kết nối mạng và thử lại"
  },
  SdkErrorCode_68245_Content = {
    Text = "Kết nối mạng bất thường, vui lòng kiểm tra mạng và thử lại"
  },
  SdkErrorCode_68246_Content = {
    Text = "Mạng không ổn định, vui lòng kiểm tra kết nối mạng và thử lại"
  },
  SdkErrorCode_68248_Content = {
    Text = "Mạng bận, xin vui lòng thử lại sau"
  },
  SdkErrorCode_68250_Content = {
    Text = "Lỗi tải file, vui lòng kiểm tra dung lượng còn lại trên thiết bị"
  },
  SdkErrorCode_68252_Content = {
    Text = "Tệp tải xuống bị lỗi, vui lòng khởi động lại trò chơi hoặc sửa lỗi ứng dụng"
  },
  SdkErrorCode_68261_Content = {
    Text = "Lỗi đọc ghi tệp, xin vui lòng thử khởi động lại trò chơi"
  },
  SdkErrorCode_68268_Content = {
    Text = "Mạng không tốt, vui lòng kiểm tra mạng hay khởi động lại trò chơi và thử lại"
  },
  SdkErrorCode_68269_Content = {
    Text = "Mạng không tốt, vui lòng kiểm tra mạng hay khởi động lại trò chơi và thử lại"
  },
  SdkErrorCode_68278_Content = {
    Text = "Lỗi đọc/ghi tệp, vui lòng thử khởi động lại trò chơi hoặc sửa chữa ứng dụng khách"
  }
})
return Text_SdkErrorCode
