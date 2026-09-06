-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passwordlock/model/PasswordLockModel.lua

module("logic.extensions.passwordlock.model.PasswordLockModel", package.seeall)

local PasswordLockModel = class("PasswordLockModel", BaseModel)

function PasswordLockModel:onInit()
	self:onReset()
end

function PasswordLockModel:onReset()
	self._localPassword = 0
	self._localPasswordSalt = 0
	self._servStatus = PasswordLockController.ServerStatus.WITH_PWD
	self._clientStatus = PasswordLockController.ClientLocalStatus.INVALID
	self._todayInputPwdFailCount = 0
	self._reqResetPwdEndTime = 0
	self._pwdType = 0
end

function PasswordLockModel:setLocalPassword(password, salt)
	self._localPassword = password
	self._localPasswordSalt = salt
end

function PasswordLockModel:setPwdInfo(info)
	self._servStatus = info.srvStaus
	self._clientStatus = info.clientLocalStatus
	self._todayInputPwdFailCount = info.todayInputPwdFailCount
	self._reqResetPwdEndTime = math.ceil(checknumber(info.reqResetPwdEndTime) / 1000)

	self:setPwdType(info.pwdType)
end

function PasswordLockModel:checkServPasswordUnlock()
	return self:getServStatus() == PasswordLockController.ServerStatus.NO_PWD
end

function PasswordLockModel:getServStatus()
	return self._servStatus
end

function PasswordLockModel:checkClientPasswordUnlock()
	if self:checkServPasswordUnlock() then
		return true
	end

	if self:getResetPwdEndTime() > 0 and self:getResetPwdEndTime() > ServerTime.now() then
		return false
	end

	return self:getClientStatus() == PasswordLockController.ClientLocalStatus.VALID_PASS
end

function PasswordLockModel:setClientStatus(status)
	self._clientStatus = status
end

function PasswordLockModel:getClientStatus()
	return self._clientStatus
end

function PasswordLockModel:getLocalPasswordSalt()
	return self._localPasswordSalt
end

function PasswordLockModel:getResetPwdEndTime()
	return self._reqResetPwdEndTime
end

function PasswordLockModel:setTodayInputPwdFailCount(count)
	self._todayInputPwdFailCount = count
end

function PasswordLockModel:getTodayInputPwdFailCount()
	return self._todayInputPwdFailCount
end

function PasswordLockModel:setPwdType(pwdType)
	self._pwdType = pwdType
end

function PasswordLockModel:getPwdType()
	return self._pwdType
end

PasswordLockModel.instance = PasswordLockModel.New()

return PasswordLockModel
