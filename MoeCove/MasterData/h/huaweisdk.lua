
local _M = class("HuaweiSdk")
local cjson = require("cjson")

function _M:_loginSuccessCallback(authAccount)
	--LuaLogger.ds(authAccount:ToString(), self.loginCallbackTemp)
	
	local tb = {
		authCode = authAccount.AuthorizationCode,
		accessToken = authAccount.AccessToken,
		idToken = authAccount.IdToken,
		openId = authAccount.OpenId,
	}
	
	if not self.loginCallbackTemp then
		return
	end

	self.loginCallbackTemp(true, {
		uuid = tb.openId,
		token = cjson.encode(tb),
	})
	self.loginCallbackTemp = nil
end

function _M:_loginFailedCallback(errorCode, msg)
	LuaLogger.es(errorCode, msg, self.loginCallbackTemp)

	if not self.loginCallbackTemp then
		return
	end

	self.loginCallbackTemp(false, {
		loginType = GE.LoginType.Huawei,
		sdkErrorCode = errorCode,
		sdkErrorMsg = msg,
	})
	self.loginCallbackTemp = nil
end

function _M:ctor()
	LuaLogger.ds("HuaweiSdk ctor")
	--local resCfg = ResMgr:ResourceLoadText("Origin/agconnect-services") -- 临时方案，要改为从StreamingAssets里读，这里多拷贝了一份到Resources下
	if Application.platform == UnityEngine.RuntimePlatform.Android then
		HuaweiSdkWrapper.Init(function (authAccount)
			self:_loginSuccessCallback(authAccount)
		end, function (errorCode, msg)
			self:_loginFailedCallback(errorCode, msg)
		end)
	end
	LuaLogger.ds("HuaweiSdk ctor end")
end

function _M:Login(callBack)
	LuaLogger.ws("Login callback", callBack)
	self.loginCallbackTemp = callBack
	HuaweiSdkWrapper.SignIn()
end

function _M:Logout(callBack)
	HuaweiSdkWrapper.SignOut()
end

function _M:init()
	self.inited = true
end

return _M
