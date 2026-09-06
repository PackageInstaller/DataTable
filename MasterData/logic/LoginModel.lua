-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/model/LoginModel.lua

module("logic.extensions.login.model.LoginModel", package.seeall)

local LoginModel = class("LoginModel", BaseListModel)

function LoginModel:ctor()
	LoginModel.super.ctor(self)

	self.disconnectFlag = GameEnum.DisconnectFlag_Net
	self.isLogined = false
	self.isLogout = false
	self.isSceneLoaded = false
	self.isPreLoaded = false
	self.curAreaStatus = nil
	self.gameAccount = nil
	self.wantGoIslandId = nil
end

function LoginModel:onInit()
	LoginModel.super.onInit(self)

	self.account = nil
	self.serverIp = nil
	self.serverPort = nil
	self.reason = nil
	self.userId = nil
	self.userId36 = nil
	self.distributeKey = nil
	self.isReconnect = nil
	self.state = nil
	self.sessionId = nil
	self.platformId = nil
	self.simulatedIp = nil
	self.tempAuthCode = nil
	self.zoneInfo = nil
	self.socketAccount = nil
	self.loginTime = nil
	self.curAreaStatus = nil
	self.gameAccount = nil
	self.socketPassword = nil
	self.wantGoIslandId = nil
	self.antiReason = nil
	self._cochannelId = nil
end

function LoginModel:onReset()
	self.reason = nil
	self.userId = nil
	self.userId36 = nil
	self.distributeKey = nil
	self.isReconnect = nil
	self.state = nil
	self.isSceneLoaded = false
	self.sessionId = nil

	if Framework.OSDef.isEditor then
		self.platformId = nil
	end

	self.zoneInfo = nil
	self.socketAccount = nil
	self.loginTime = nil
	self.isLogined = false
	self.isLogout = false
	self.gameAccount = nil
	self.socketPassword = nil
	self.antiReason = nil
	self._cochannelId = nil
end

function LoginModel:getCoChannelId()
	if self._cochannelId == nil then
		local res = SDKManager.getDevInfo()

		self._cochannelId = checknumber(res.cochannelId)
	end

	return self._cochannelId
end

LoginModel.instance = LoginModel.New()

return LoginModel
