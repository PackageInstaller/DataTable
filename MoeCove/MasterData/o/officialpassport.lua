
local OfficialPassport = class("OfficialPassport")
local CommonBusiness = require "CommonBusiness"
local cjson = require "cjson"
local md5Lua = require "md5Lua"
local crypt = require "crypt"
local _checkKey = "passportcheck"

local function _checkFunc(content)
    local sha1 = crypt.hmac_sha1(_checkKey, content)
    local encoded = crypt.base64encode(sha1)
    return encoded
end

function OfficialPassport:ctor(urlroot)
    self.urlroot = urlroot
end

-- id:身份证号
-- name:名字
function OfficialPassport:RegisterFormal(loginData, callBack)
    return self:Passport("/1/create/user/@self", "POST",
    {
        uuid = 0,
        account = loginData.account,
        password = md5Lua.sumhexa(loginData.password),
        -- id = loginData.id,
        -- name = loginData.name,
        device = NativeInfoLua.GetDeviceID(),
        bindEmail = loginData.bindEmail,
        phone = loginData.phone,
        phoneReg = loginData.phoneReg,
        verifyCode = loginData.verifyCode,
        check = _checkFunc(loginData.account),
        channel = loginData.channel,
        email = "",
        token = "",
    }, callBack)
end

--修改密码
function OfficialPassport:ChangePassword(loginData, callBack)
    return self:Passport("/1/rePassword/user/@self", "POST",
    {
        uuid = 0,
        account = loginData.account,
        password = md5Lua.sumhexa(loginData.password),
        device = NativeInfoLua.GetDeviceID(),
        bindEmail = loginData.bindEmail,
        phone = loginData.phone,
        phoneReg = loginData.phoneReg,
        verifyCode = loginData.verifyCode,
        check = _checkFunc(loginData.account),
        channel = loginData.channel,
        email = "",
        token = "",
    }, callBack)
end

--function OfficialPassport:Register(account, password, callBack)
--    self:RegisterFormal(account, password, nil, nil, callBack)
--end

function OfficialPassport:FastRegister(callBack)
    return self:Passport("/1/quickCreate/user/@self", "POST",
    {
        uid = NativeInfoLua.GetDeviceID(),
        deviceInfo = NativeInfoLua.GetDeviceDetail(),
    }, callBack)
end

function OfficialPassport:Login(account, password, callBack)
    return self:Passport("/1/get/user/@self", "POST",
    {
        account = account,
        password = md5Lua.sumhexa(password),
    }, callBack)
end

function OfficialPassport:BindAccount(bindData, callBack)
    return self:Passport("/1/bindAccount/user/@self", "POST",
    {
        token = bindData.token,
        newToken = bindData.newToken,
        bindType = bindData.bindType,
    }, callBack)
end

function OfficialPassport:GetVerifyPhoneCode(data, callBack)
    LuaLogger.ds("GetVerifyPhoneCode")
    return self:Passport("/1/phoneCode/user/@self", "POST",
    {
        phone = data.phone,
        check = _checkFunc(data.phone)
    }, callBack)
end

--实名认证
function OfficialPassport:GetVerifyAuthentication(data, callBack)
    
    return self:Passport("/1/authentication/user/@self", "POST",
    {
        account = data.account,
        idCard = data.id_card,
        username = data.name,
        token = data.token,
    }, callBack)
end

function OfficialPassport:Passport(path, HTTP_Verb, data, callBack)
    -- local date = DUtil.FormatRfc822Date()
    --local date = CommonBusiness.GetAuthDate()
    --local authorization = CommonBusiness.GenAuth(HTTP_Verb, date, path)

    local url = self.urlroot .. path
    
    local reqbody = cjson.encode(data)
    --local response_body = {}
    --local http = require"socket/http"
    --local ltn12 = require"ltn12"
    local dict = {}
    --table.insert(dict, "date")
    --table.insert(dict, date)
    --table.insert(dict, "authorization")
    --table.insert(dict, authorization)
    --dict:Add("Content-Length", date)
    local loaderTime = 1
    local loaderId = UIMgr:startLoad(loaderTime)
    local timeout = 20000 --20秒超时时间，由于第三方身份证验证可能比较慢，之前5秒不够
    HttpUtil.HttpRequest(url, reqbody, timeout, dict, function(respcode, responseJson)
        UIMgr:endLoad(loaderId)
        LuaLogger.ds(respcode, responseJson)
        local success = self:dealReturnCode(respcode)
        local response
        if responseJson and success then
            response = cjson.decode(responseJson)
            if response.error then
                success = false
            end
        elseif respcode == 404 then
            response = {error = GE.PassportErrorCode.ServerConnectFailed}
        else
            response = {error = GE.PassportErrorCode.ResponseError}
        end
        
        callBack(success, response)
    end)
end

function OfficialPassport:dealReturnCode(respcode)
    local success = true
    local erroCode = ""
    if respcode == 200 or respcode == 201 or respcode == 204 or respcode == 205 then
        return true
    else
        return false
        --success = false
        --if respcode == 400 then
        --    erroCode = "400 Bad Request"
        --elseif respcode == 401 then
        --    erroCode = "401 Unauthorized"
        --elseif respcode == 403 then
        --    erroCode = "403 Forbidden"
        --elseif respcode == 404 then
        --    erroCode = "404 Not Found"
        --elseif respcode == 405 then
        --    erroCode = "405 Method Not Allowed"
        --elseif respcode == 409 then
        --    erroCode = "409 Conflict"
        --elseif respcode == 500 then
        --    erroCode = "500 Internal Server Error"
        --elseif respcode == 501 then
        --    erroCode = "501 Not Implemented"
        --elseif respcode == 505 then
        --    erroCode = "505 HTTP Version Not Supported"
        --end
    end
    return success, erroCode
end

function OfficialPassport:init()
    self.inited = true
end

return OfficialPassport