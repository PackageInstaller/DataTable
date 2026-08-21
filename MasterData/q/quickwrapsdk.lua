
local _M = class("QuickWrapSdk")
local cjson = require("cjson")

function _M:_loginSuccessCallback(userInfo)
	local tb = {
		token = userInfo.token,
		uid = userInfo.uid,
		channel_code = quicksdk.QuickSDK.getInstance():channelType(),
	}
	
	if not self.loginCallbackTemp then
		return
	end

	self.loginCallbackTemp(true, {
		uuid = tb.uid,
		token = cjson.encode(tb),
	})
	self.loginCallbackTemp = nil
end

function _M:_loginFailedCallback(errMsg)
	if not self.loginCallbackTemp then
		return
	end

	self.loginCallbackTemp(false, {
		loginType = GE.LoginType.QuickWrap,
		sdkErrorCode = nil,
		sdkErrorMsg = errMsg,
	})
	self.loginCallbackTemp = nil
end

function _M:ctor()
	LuaLogger.ds("QuickWrapSdk ctor")

	local quickSdkHandler = GameMain.Instance.gameObject:GetComponent(typeof(QuickSdkHandler));
	if not quickSdkHandler then
		quickSdkHandler = GameMain.Instance.gameObject:AddComponent(typeof(QuickSdkHandler));
	end
	
	self.quickSdkHandler = quickSdkHandler

	--self:init()
	
	quickSdkHandler.OnLoginSuccess = function (userInfo)
		self:_loginSuccessCallback(userInfo)
	end
	
	quickSdkHandler.OnLoginFailed = function (err)
		self:_loginFailedCallback(err.errMsg)
	end
	
	quickSdkHandler.OnLogoutSuccess = function ()
		if self.logoutCallback then
			self.logoutCallback()
		end

		self.logoutCallback = nil
		if GameFlowFSM:getLastStateId() ~= GameFlowState.LoginState then
			StateMgr:ChangeToState(GameFlowState.LoginState)
		else
			if self.beLogoutCallback then
				self.beLogoutCallback()
			end
		end
	end

	quickSdkHandler.OnExitSuccess = function ()
		quicksdk.QuickSDK.getInstance():exitGame()
	end
	
	--if Application.platform == UnityEngine.RuntimePlatform.Android then
	--	
	--end
	
	LuaLogger.ds("QuickWrapSdk ctor end")
end

function _M:Login(callBack)
	LuaLogger.ws("Set quick Login callback", callBack)
	self.loginCallbackTemp = callBack
	self:checkSDKInit(function(success)
		if success then
			quicksdk.QuickSDK.getInstance():login()
		end
	end)
end

function _M:Logout(callBack)
	self.logoutCallback = callBack
	quicksdk.QuickSDK.getInstance():logout()
end

function _M:setBeLogout(callBack)
	self.beLogoutCallback = callBack
end

function _M:getChannel()
	return quicksdk.QuickSDK.getInstance():channelType() + 100000
end

-- 有初始化成功与否概念的需要加这个函数
function _M:isInited()
	return self.quickSdkHandler.sdkInitSuccess
end

--function _M:init() -- 暂时没有被调用 C#里调用了
--	if self.quickSdkHandler.sdkInitSuccess then
--		return
--	end
--
--	local loaderId = UIMgr:startLoad(1)
--
--	self.quickSdkHandler.OnInitSuccess = function ()
--		self.inited = true
--		LuaLogger.ds("sdk init success")
--		UIMgr:endLoad(loaderId)
--	end
--
--	self.quickSdkHandler.OnInitFailed = function (err)
--		LuaLogger.es(err.errMsg)
--		--UICommonUtils.PopPromptBox("SDK初始化失败")
--		UIMgr:endLoad(loaderId)
--	end
--	
--	quicksdk.QuickSDK.getInstance():reInit();
--end

function _M:checkSDKInit(callBack) -- 暂时没有被调用
	if self:isInited() then
		callBack(true)
		return
	end

	local loaderId = UIMgr:startLoad(1)

	self.quickSdkHandler.OnInitSuccess = function ()
		self.inited = true
		LuaLogger.ds("sdk init success")
		UIMgr:endLoad(loaderId)
		callBack(true)
	end

	self.quickSdkHandler.OnInitFailed = function (err)
		LuaLogger.es(err.errMsg)
		--UICommonUtils.PopPromptBox("SDK初始化失败")
		UIMgr:endLoad(loaderId)
		callBack(false)
	end

	quicksdk.QuickSDK.getInstance():reInit();
end

function _M:genSdkRoleDataFromData(data)
	local gameRoleInfo = quicksdk.GameRoleInfo.New()
	gameRoleInfo.gameRoleBalance = data.gameRoleBalance;
	gameRoleInfo.gameRoleID = data.gameRoleID;
	gameRoleInfo.gameRoleLevel = data.gameRoleLevel;
	gameRoleInfo.gameRoleName = data.gameRoleName;
	gameRoleInfo.partyName = data.partyName;
	gameRoleInfo.serverID = data.serverID;
	gameRoleInfo.serverName = data.serverName;
	gameRoleInfo.vipLevel = data.vipLevel;
	gameRoleInfo.roleCreateTime = data.roleCreateTime; -- UC，当乐与1881渠道必传，值为10位数时间戳
	gameRoleInfo.gameRoleGender = data.gameRoleGender; -- 360渠道参数
	gameRoleInfo.gameRolePower = data.gameRolePower; -- 360渠道参数，设置角色战力，必须为整型字符串
	gameRoleInfo.partyId = data.partyId; -- 360渠道参数，设置帮派id，必须为整型字符串
	gameRoleInfo.professionId = data.professionId; -- 360渠道参数，设置角色职业id，必须为整型字符串
	gameRoleInfo.profession = data.profession; -- 360渠道参数，设置角色职业名称
	gameRoleInfo.partyRoleId = data.partyRoleId; -- 360渠道参数，设置角色在帮派中的id
	gameRoleInfo.partyRoleName = data.partyRoleName;  -- 360渠道参数，设置角色在帮派中的名称
	gameRoleInfo.friendlist = data.friendlist; -- 360渠道参数，设置好友关系列表，格式请参考：http://open.quicksdk.net/help/detail/aid/190
	return gameRoleInfo
end

function _M:createRole(data)
	--LuaLogger.ds("createRole", tablex.dump(data))
	if self.loginType == GE.LoginType.QuickWrap then
		QuickSDK.getInstance ().createRole(self:genSdkRoleDataFromData(data)); -- 创建角色
	end
end

function _M:enterGame(data)
	--LuaLogger.ds("enterGame", tablex.dump(data))
	if self.loginType == GE.LoginType.QuickWrap then
		QuickSDK.getInstance ().enterGame(self:genSdkRoleDataFromData(data)); -- 进入游戏
	end
end

function _M:updateRole(data)
	--LuaLogger.ds("updateRole", tablex.dump(data))
	if self.loginType == GE.LoginType.QuickWrap then
		QuickSDK.getInstance ().updateRole(self:genSdkRoleDataFromData(data)); -- 角色升级
	end
end

return _M
