
local _M = class("TapWrapSdk")
local cjson = require("cjson")

function _M:ctor()
	LuaLogger.ds("TapWrapSdk ctor")

	local tapSdkHandler = GameMain.Instance.gameObject:GetComponent(typeof(TapSdkHandler));
	if not tapSdkHandler then
		tapSdkHandler = GameMain.Instance.gameObject:AddComponent(typeof(TapSdkHandler));
	end
	
	self.tapSdkHandler = tapSdkHandler

	self.inited = false

	--if Application.platform == UnityEngine.RuntimePlatform.Android then
	--	
	--end
	
	LuaLogger.ds("TapWrapSdk ctor end")
end

local function _wrapOpenIdKey(openId)
	return openId .. "_antiaddiction"
end

function _M:isAntiAddictionAlready()
	return UnityEngine.PlayerPrefs.GetInt(_wrapOpenIdKey(self.data.openid), 0) == 1
end

function _M:setAntiAddictionAlready()
	UnityEngine.PlayerPrefs.SetInt(_wrapOpenIdKey(self.data.openid), 1)
end

function _M:Login(callBack)
	LuaLogger.ws("Set tap Login callback", callBack)
	self:checkSDKInit(function(success)
		if success then
			self.tapSdkHandler:Login(function (code, data)
				local luaData = {
					kid = data.kid,
					accessToken = data.accessToken,
					tokenType = data.tokenType,
					macKey = data.macKey,
					macAlgorithm = data.macAlgorithm,
					name = data.name,
					avatar = data.avatar,
					openid = data.openid,
					unionid = data.unionid,
					email = data.email,
					emailVerified = data.emailVerified,
				}

				self.data = luaData

				local loginData
				if code == 0 then
					loginData = {
						uuid = luaData.openid,
						token = cjson.encode(luaData),
					}
					callBack(true, loginData)
				else
					loginData = {
						errorCode = data.errorCode,
						errorMsg = data.errorMsg,
					}
					LuaLogger.ws(tablex.dump(loginData))
					callBack(false, loginData)
				end

				--if not self:isAntiAddictionAlready() then
				--	self.tapSdkHandler:StartAntiAddiction()
				--end
			end)
		end
	end)
end

function _M:Logout(callBack)
	self.tapSdkHandler:Logout()
end

function _M:getChannel() -- 目前调不到这
	return GE.Channel.Formal_TapTap
end

-- 有初始化成功与否概念的需要加这个函数
function _M:isInited()
	return self.inited
end

--function _M:init() -- 目前只在checkSDKInit里调用了
--	
--end

function _M:checkSDKInit(callBack) -- 暂时没有被调用
	if self:isInited() then
		callBack(true)
		return
	end

	self.tapSdkHandler:Init(function (code)
		self.inited = code == 0
		callBack(self.inited)
	end, SDKMgr:getTapAntiAddictionCallback())
end

function _M:startAntiAddiction()
	self.tapSdkHandler:StartAntiAddiction()
end

return _M
