

GE.PassportErrorCode = {
    GetLoginInfoFailed = 5, -- 获取登录信息失败
    PassportServerException = 8, -- 服务器异常
    Maintaining = 9, -- 维护中

    VeryError = 10, -- 

    BodyError = 15, -- 请求信息不合法
    ResponseError = 16, -- 服务器返回信息错误
    ServerConnectFailed = 19, -- 网络连接失败请稍后再试

    AccountPatternInvalid = 20, -- 账号格式不正确 
    AccountAlreadyExist = 21, -- 账号已存在
    NotQuickAccount = 22, -- 不是游客账号
    NotTestAccount = 23, -- 没有测试名额

    AccountNotExist = 30, -- 账号不存在 
    PasswordNotCorrect = 32, -- 密码不正确
    PasswordNewMatchesOld = 33, -- 新密码与旧密码一致
    LackDeviceId = 34, -- 缺乏设备标识(快速注册没有设备id)
    MinorNotAllowedLogin = 35, -- 未满16岁不能进入游戏

    TokenNotCorrect = 38, -- token不正确

    AccountBindFailed1 = 42, -- 账号绑定失败1 
    AccountBindFailed2 = 43, -- 账号绑定失败2
    BindAccountAlreadyInUse = 46, -- 要绑定的账号已经被使用 

    IDNameNotMatch = 50, -- 姓名与身份证号码不匹配
    idCardError = 51,                  --身份证号码错误
    UserNameError = 52,                --姓名错误
    AuthFailed = 53,                --实名认证失败

    PhonePatternInvalid = 60, -- 手机号不正确 
    ServerNoVerifyCode = 61, -- 服务端没有验证码
    VerifyCodeExpired = 62, -- 验证码已过期
    VerifyCodeFetchFailed = 63, -- 验证码获取失败
    VerifyCodeIncorrect = 64, -- 验证码不正确

    RequestInvalid = 99, -- 请求不合法

    RegisterFailed1 = 100, -- 账号注册失败1
    RegisterFailed2 = 101, -- 账号注册失败2
    RegisterNumLimit = 102, -- 账号注册数量限制

    RegisterFailedSameDeviceLimit2 = 110, -- 每个设备一天最多只能注册2个账号

    SameDeviceVerifyIDFrequently = 120, -- 同一设备验证过于频繁
    SamePhoneNumberVerifyIDFrequently = 121, -- 同一手机号验证过于频繁

    RedisAddLockFaild = 130,           --redis加锁失败
    RedisLockWait = 131,                --redis等待稍后处理

}

GE.LoginErrorCode = {
    NormalFailed = 1,   -- 普通过程失败
    BanAccount   = 2,   -- 被封账号
    BanDevice    = 3,   -- 被封设备
    BanIp        = 4,   -- 被封ip
    authing      = 5,   -- 授权登录中，请稍等
    addLockFaild = 6,   -- 加锁失败
    realNameAuth = 7,   -- 请先实名认证
}

local _guestPreStr = "Guestrdm_"
function GF.IsQuickAccount(account)
    return account and #account == 41 and account:startswith(_guestPreStr)
end

function GF.IsFormalAccountValid(account)
    if GV.GlobalConfig.LocalServerTest then
        return true
    end

    return account and stringx.isAlphaNum(account) and #account >= 5 and #account <= 16
end

function GF.IsFormalPasswordValid(password)
    return #password >= 6 and #password <= 16
end