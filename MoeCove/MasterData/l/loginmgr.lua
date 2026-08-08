---@class LoginMgr
local LoginMgr = class("LoginMgr")
local cjson = require "cjson"

function LoginMgr:ctor()
	---@type LoginMgr
	self._instance = nil
	---@type string
	self.baseUrl = "http://192.168.1.74:81/"
	---@type number
	self.apiVersion = 1
	---@type number
	self.appid = 2
	---@type number
	self.app_server_type = -1
	---@type number
	self.platform = 2
	---@type string
	self.captcha_type_login = "1"
	---@type string
	self.areacode = "+86"
	---@type table
	self.loaderMap = {}
end

---实例化
---@return LoginMgr
function LoginMgr:instance()
	if (self._instance == nil) then
		self._instance = self:new()
	end
	return self._instance
end

function LoginMgr:login(username, password, callback)
	print("LoginMgr:login username",username)
	local url = string.format("%s%d/get/login/@self", self.baseUrl, self.apiVersion)

	if url then
		local reqbody = cjson.encode({
			username = username,
			password = password,
			appid = self.appid,
			app_server_type = self.app_server_type,
			platform = self.platform
		})

		self:httpRequest(url, reqbody, callback)
	end
end

function LoginMgr:sendCaptcha(mobile, callback)
	print("LoginMgr:sendCaptcha mobile",mobile)
	local url = string.format("%s%d/get/mSendCaptcha/@self", self.baseUrl, self.apiVersion)

	if url then
		local reqbody = cjson.encode({
			appid = self.appid,
			type = self.captcha_type_login,
			mobile = mobile,
			areacode = self.areacode
		})

		self:httpRequest(url, reqbody, callback)
	end
end

function LoginMgr:loginByCaptcha(mobile, captcha, callback)
	print("LoginMgr:loginByCaptcha mobile",mobile)
	local url = string.format("%s%d/get/mLogin/@self", self.baseUrl, self.apiVersion)

	if url then
		local reqbody = cjson.encode({
			appid = self.appid,
			mobile = mobile,
			areacode = self.areacode,
			platform = self.platform,
			captcha = captcha
		})

		self:httpRequest(url, reqbody, callback)
	end
end

function LoginMgr:httpRequest(url, reqbody, callback)
	local dict = {}
	local timeout = 20000 --20秒超时时间，由于第三方身份证验证可能比较慢，之前5秒不够
	HttpUtil.HttpRequest(url, reqbody, timeout, dict, function(respcode, responseJson)
		print("respcode",respcode)
		self:ClearLoader()
		local success = respcode == 200
		local response
		if responseJson and success then
			response = cjson.decode(responseJson)
		elseif respcode == 404 then
			response = {error = GE.PassportErrorCode.ServerConnectFailed}
		else
			response = {error = GE.PassportErrorCode.ResponseError}
		end

		if (callback) then
			callback(success, response)
		end
	end)
	local loaderId = UIMgr:startLoad(5)
	table.insert(self.loaderMap, loaderId)
end

function LoginMgr:ClearLoader()
    for k, v in pairs(self.loaderMap) do
        UIMgr:endLoad(v)
    end
    self.loaderMap = {}
end

return LoginMgr