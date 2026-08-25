__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_SdkErrorCode = readonly({
  SdkErrorCode_67975_Content = {
    Text = "파일 읽기/쓰기 오류. 게임을 재시작해 주세요."
  },
  SdkErrorCode_67988_Content = {
    Text = "네트워크 연결이 불안정합니다. 게임을 재시작하거나 네트워크를 확인해 주세요"
  },
  SdkErrorCode_67989_Content = {
    Text = "네트워크 연결이 불안정합니다. 게임을 재시작하거나 네트워크를 확인해 주세요"
  },
  SdkErrorCode_67990_Content = {
    Text = "네트워크 연결이 불안정합니다. 게임을 재시작하거나 네트워크를 확인해 주세요"
  },
  SdkErrorCode_67991_Content = {
    Text = "네트워크 연결이 불안정합니다. 게임을 재시작하거나 네트워크를 확인해 주세요"
  },
  SdkErrorCode_67992_Content = {
    Text = "네트워크 연결이 불안정합니다. 게임을 재시작하거나 네트워크를 확인해 주세요"
  },
  SdkErrorCode_67993_Content = {
    Text = "네트워크 연결이 불안정합니다. 게임을 재시작하거나 네트워크를 확인해 주세요"
  },
  SdkErrorCode_67994_Content = {
    Text = "네트워크 연결이 불안정합니다. 게임을 재시작하거나 네트워크를 확인해 주세요"
  },
  SdkErrorCode_68020_Content = {
    Text = "네트워크 연결이 불안정합니다. 게임을 재시작하거나 네트워크를 확인해 주세요"
  },
  SdkErrorCode_68022_Content = {
    Text = "파일 다운로드 오류. 기기의 남은 저장 공간을 확인해 주세요."
  },
  SdkErrorCode_68023_Content = {
    Text = "네트워크 상태가 좋지 않습니다. 네트워크 확인 후 다시 시도해 주세요."
  },
  SdkErrorCode_68024_Content = {
    Text = "네트워크 연결이 없습니다. 네트워크 확인 후 다시 시도해 주세요."
  },
  SdkErrorCode_68027_Content = {
    Text = "네트워크 연결이 없습니다. 네트워크 확인 후 다시 시도해 주세요."
  },
  SdkErrorCode_68033_Content = {
    Text = "파일 읽기/쓰기 오류. 게임을 재시작해 주세요."
  },
  SdkErrorCode_68035_Content = {
    Text = "파일 읽기/쓰기 오류. 게임을 재시작해 주세요."
  },
  SdkErrorCode_68037_Content = {
    Text = "게임이 짧은 시간 내에 acquire 인터페이스를 여러 번 호출할 경우, 일정 확률로 만료된 ejoy_token(16개의 토큰이 서로 중첩됨)을 획득할 수 있으며, 해당 토큰을 게임 서버 로그인에 사용할 시 401 오류가 발생합니다."
  },
  SdkErrorCode_68058_Content = {
    Text = "파일 읽기/쓰기 오류. 게임을 재시작해 주세요."
  },
  SdkErrorCode_68060_Content = {
    Text = "네트워크 연결이 불안정합니다. 게임을 재시작하거나 네트워크를 확인해 주세요"
  },
  SdkErrorCode_68061_Content = {
    Text = "네트워크 연결이 불안정합니다. 게임을 재시작하거나 네트워크를 확인해 주세요"
  },
  SdkErrorCode_68062_Content = {
    Text = "네트워크 연결이 불안정합니다. 게임을 재시작하거나 네트워크를 확인해 주세요"
  },
  SdkErrorCode_68063_Content = {
    Text = "네트워크 연결이 불안정합니다. 게임을 재시작하거나 네트워크를 확인해 주세요"
  },
  SdkErrorCode_68064_Content = {
    Text = "네트워크 연결이 불안정합니다. 게임을 재시작하거나 네트워크를 확인해 주세요"
  },
  SdkErrorCode_68065_Content = {
    Text = "네트워크 연결이 불안정합니다. 게임을 재시작하거나 네트워크를 확인해 주세요"
  },
  SdkErrorCode_68066_Content = {
    Text = "네트워크 연결이 불안정합니다. 게임을 재시작하거나 네트워크를 확인해 주세요"
  },
  SdkErrorCode_68067_Content = {
    Text = "네트워크 연결이 불안정합니다. 게임을 재시작하거나 네트워크를 확인해 주세요"
  },
  SdkErrorCode_68068_Content = {
    Text = "네트워크 연결이 불안정합니다. 게임을 재시작하거나 네트워크를 확인해 주세요"
  },
  SdkErrorCode_68069_Content = {
    Text = "네트워크 연결이 불안정합니다. 게임을 재시작하거나 네트워크를 확인해 주세요"
  },
  SdkErrorCode_68071_Content = {
    Text = "네트워크 연결이 불안정합니다. 게임을 재시작하거나 네트워크를 확인해 주세요"
  },
  SdkErrorCode_68072_Content = {
    Text = "네트워크 연결이 불안정합니다. 게임을 재시작하거나 네트워크를 확인해 주세요"
  },
  SdkErrorCode_68073_Content = {
    Text = "파일 읽기/쓰기 오류. 게임을 재시작해 주세요."
  },
  SdkErrorCode_68077_Content = {
    Text = "캐시 읽기 오류. 게임을 재시작해 주세요."
  },
  SdkErrorCode_68078_Content = {
    Text = "네트워크 연결이 불안정합니다. 게임을 재시작하거나 네트워크를 확인해 주세요"
  },
  SdkErrorCode_68082_Content = {
    Text = "네트워크 연결이 불안정합니다. 게임을 재시작하거나 네트워크를 확인해 주세요"
  },
  SdkErrorCode_68100_Content = {
    Text = "네트워크 연결이 불안정합니다. 게임을 재시작하거나 네트워크를 확인해 주세요"
  },
  SdkErrorCode_68109_Content = {
    Text = "네트워크 연결이 불안정합니다. 게임을 재시작하거나 네트워크를 확인해 주세요"
  },
  SdkErrorCode_68110_Content = {
    Text = "네트워크 연결이 불안정합니다. 게임을 재시작하거나 네트워크를 확인해 주세요"
  },
  SdkErrorCode_68111_Content = {
    Text = "네트워크 연결이 불안정합니다. 게임을 재시작하거나 네트워크를 확인해 주세요"
  },
  SdkErrorCode_68112_Content = {
    Text = "네트워크 연결이 불안정합니다. 게임을 재시작하거나 네트워크를 확인해 주세요"
  },
  SdkErrorCode_68113_Content = {
    Text = "네트워크 연결이 불안정합니다. 게임을 재시작하거나 네트워크를 확인해 주세요"
  },
  SdkErrorCode_68114_Content = {
    Text = "네트워크 연결이 불안정합니다. 게임을 재시작하거나 네트워크를 확인해 주세요"
  },
  SdkErrorCode_68115_Content = {
    Text = "네트워크 연결이 불안정합니다. 게임을 재시작하거나 네트워크를 확인해 주세요"
  },
  SdkErrorCode_68116_Content = {
    Text = "네트워크 연결이 불안정합니다. 게임을 재시작하거나 네트워크를 확인해 주세요"
  },
  SdkErrorCode_68118_Content = {
    Text = "네트워크 연결이 불안정합니다. 게임을 재시작하거나 네트워크를 확인해 주세요"
  },
  SdkErrorCode_68119_Content = {
    Text = "파일 읽기/쓰기 오류. 게임을 재시작해 주세요."
  },
  SdkErrorCode_68120_Content = {
    Text = "파일 읽기/쓰기 오류. 게임을 재시작해 주세요."
  },
  SdkErrorCode_68121_Content = {
    Text = "네트워크 연결이 불안정합니다. 게임을 재시작하거나 네트워크를 확인해 주세요"
  },
  SdkErrorCode_68133_Content = {
    Text = "네트워크 상태가 좋지 않습니다. 네트워크를 확인하거나 게임을 재시작한 후 다시 시도해 주세요."
  },
  SdkErrorCode_68153_Content = {
    Text = "네트워크 연결이 불안정합니다. 게임을 재시작하거나 네트워크를 확인해 주세요"
  },
  SdkErrorCode_68158_Content = {
    Text = "네트워크가 혼잡합니다. 잠시 후 다시 시도해 주세요."
  },
  SdkErrorCode_68159_Content = {
    Text = "파일 다운로드 오류. 기기의 남은 저장 공간을 확인해 주세요."
  },
  SdkErrorCode_68170_Content = {
    Text = "네트워크가 혼잡합니다. 잠시 후 다시 시도해 주세요."
  },
  SdkErrorCode_68173_Content = {
    Text = "네트워크가 혼잡합니다. 잠시 후 다시 시도해 주세요."
  },
  SdkErrorCode_68174_Content = {
    Text = "네트워크가 혼잡합니다. 잠시 후 다시 시도해 주세요."
  },
  SdkErrorCode_68175_Content = {
    Text = "네트워크가 혼잡합니다. 잠시 후 다시 시도해 주세요."
  },
  SdkErrorCode_68176_Content = {
    Text = "네트워크 연결이 없습니다. 네트워크를 확인해 주세요."
  },
  SdkErrorCode_68189_Content = {
    Text = "네트워크 연결이 불안정합니다. 게임을 재시작하거나 네트워크를 확인해 주세요"
  },
  SdkErrorCode_68190_Content = {
    Text = "네트워크 연결이 불안정합니다. 게임을 재시작하거나 네트워크를 확인해 주세요"
  },
  SdkErrorCode_68199_Content = {
    Text = "네트워크 연결이 끊어졌습니다. 네트워크를 확인해 주세요."
  },
  SdkErrorCode_68201_Content = {
    Text = "네트워크 연결이 끊어졌습니다. 네트워크를 확인해 주세요."
  },
  SdkErrorCode_68202_Content = {
    Text = "네트워크 연결 오류, 네트워크를 확인해 주세요."
  },
  SdkErrorCode_68205_Content = {
    Text = "네트워크 연결이 끊어졌습니다. 네트워크를 확인해 주세요."
  },
  SdkErrorCode_68207_Content = {
    Text = "네트워크 연결 오류, 네트워크를 확인해 주세요."
  },
  SdkErrorCode_68210_Content = {
    Text = "네트워크 연결 오류, 네트워크를 확인해 주세요."
  },
  SdkErrorCode_68235_Content = {
    Text = "네트워크 상태가 좋지 않습니다. 네트워크 확인 후 다시 시도해 주세요."
  },
  SdkErrorCode_68236_Content = {
    Text = "네트워크 연결이 없습니다. 네트워크 확인 후 다시 시도해 주세요."
  },
  SdkErrorCode_68241_Content = {
    Text = "네트워크 상태가 좋지 않습니다. 네트워크 확인 후 다시 시도해 주세요."
  },
  SdkErrorCode_68245_Content = {
    Text = "네트워크 연결, 네트워크 확인 후 다시 시도해 주세요."
  },
  SdkErrorCode_68246_Content = {
    Text = "네트워크 상태가 좋지 않습니다. 네트워크 확인 후 다시 시도해 주세요."
  },
  SdkErrorCode_68248_Content = {
    Text = "네트워크가 혼잡합니다. 잠시 후 다시 시도해 주세요."
  },
  SdkErrorCode_68250_Content = {
    Text = "파일 다운로드 오류. 기기의 남은 저장 공간을 확인해 주세요."
  },
  SdkErrorCode_68252_Content = {
    Text = "파일 다운로드 오류. 기기의 남은 저장 공간을 확인해 주세요."
  },
  SdkErrorCode_68261_Content = {
    Text = "파일 읽기/쓰기 오류. 게임을 재시작해 주세요."
  },
  SdkErrorCode_68268_Content = {
    Text = "네트워크 상태가 좋지 않습니다. 네트워크를 확인하거나 게임을 재시작한 후 다시 시도해 주세요."
  },
  SdkErrorCode_68269_Content = {
    Text = "네트워크 상태가 좋지 않습니다. 네트워크를 확인하거나 게임을 재시작한 후 다시 시도해 주세요."
  },
  SdkErrorCode_68278_Content = {
    Text = "파일 읽기/쓰기 오류. 게임을 재시작해 주세요."
  }
})
return Text_SdkErrorCode
