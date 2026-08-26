-- chunkname: @modules/logic/login/model/LoginModel.lua

module("modules.logic.login.model.LoginModel", package.seeall)

local LoginModel = class("LoginModel", BaseModel)
local LoginStatus = {
	DoingLogin = 2,
	DoneLogin = 3,
	NotLogin = 1
}

LoginModel.FailAlertCount = 3

function LoginModel:onInit()
	self.serverIp = nil
	self.serverPort = nil
	self.serverBakIp = nil
	self.serverBakPort = nil
	self.serverName = nil
	self.serverId = nil
	self.userName = nil
	self.sessionId = nil
	self.channelSessionId = nil
	self.channelUserId = nil
	self.channelId = nil
	self.channelGameCode = nil
	self.channelGameId = nil
	self._useBackupUrl = false

	self:notLogin()
end

function LoginModel:reInit()
	self:notLogin()
end

function LoginModel:isNotLogin()
	return self._loginStatus == LoginStatus.NotLogin
end

function LoginModel:isDoingLogin()
	return self._loginStatus == LoginStatus.DoingLogin
end

function LoginModel:isDoneLogin()
	return self._loginStatus == LoginStatus.DoneLogin
end

function LoginModel:notLogin()
	self._loginStatus = LoginStatus.NotLogin
end

function LoginModel:doingLogin()
	self._loginStatus = LoginStatus.DoingLogin
end

function LoginModel:doneLogin()
	self._loginStatus = LoginStatus.DoneLogin
end

function LoginModel:clearDatas()
	self:onInit()
end

function LoginModel:setChannelParam(sessionId, userId, channelId, gameCode, gameId)
	self.channelSessionId = sessionId
	self.channelUserId = userId
	self.channelId = channelId
	self.channelGameCode = gameCode
	self.channelGameId = gameId
end

function LoginModel:getUseBackup()
	if HotUpdateMgr.getUseBackup then
		return HotUpdateMgr.instance:getUseBackup()
	end

	return self._useBackupUrl
end

function LoginModel:inverseUseBackup()
	if HotUpdateMgr.inverseUseBackup then
		HotUpdateMgr.instance:inverseUseBackup()

		return
	end

	self._useBackupUrl = not self._useBackupUrl
end

function LoginModel:getFailCount()
	return self._failCount or 0
end

function LoginModel:resetFailCount()
	self._failCount = 0
	self._failAlertCount = 0
end

function LoginModel:incFailCount()
	if self._failCount then
		self._failCount = self._failCount + 1 or 1
	end

	if self._failAlertCount then
		self._failAlertCount = self._failAlertCount + 1 or 1
	end
end

function LoginModel:getFailAlertCount()
	return self._failAlertCount or 0
end

function LoginModel:resetFailAlertCount()
	self._failAlertCount = 0
end

function LoginModel:isFailNeedAlert()
	return self._failAlertCount >= LoginModel.FailAlertCount
end

function LoginModel:getFailCountBlockStr(count)
	return string.format("CONNECTING...(%d)", count or self:getFailAlertCount())
end

LoginModel.instance = LoginModel.New()

return LoginModel
