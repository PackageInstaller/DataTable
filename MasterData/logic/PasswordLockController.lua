-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passwordlock/controller/PasswordLockController.lua

module("logic.extensions.passwordlock.controller.PasswordLockController", package.seeall)

local PasswordLockController = class("PasswordLockController", BaseController)

PasswordLockController.MIN_FINGER_LENGTH = 2
PasswordLockController.MAX_LENGTH = 9
PasswordLockController.DAILY_MAX_FAIL_COUNT = 9
PasswordLockController.RESET_MILLS = 259200
PasswordLockController.MAX_VALID_TIEMS = 5
PasswordLockController.ClientLocalStatus = {
	INVALID = 0,
	VALID_PASS = 1
}
PasswordLockController.ServerStatus = {
	WITH_PWD = 1,
	NO_PWD = 0,
	REQ_RESET_PWD = 2
}

local playerSecondaryPwdPre = "playersecondarypwd"
local playerSecondaryPwdStrPre = "playersecondarypwdstr"
local playerSecondaryPwdSaltKeyPre = "playersecondarypwdsaltkey"

PasswordLockController.playerSecondaryPwdTypePre = "playersecondarypwdtype"

function PasswordLockController:onInit()
	self:onReset()
	MsgFlowMgr.instance:ignoreAutoShowFloatMsg(26, 27)
end

function PasswordLockController:onReset()
	removetimer(self._resetTick, self)
end

function PasswordLockController:sendGetBaseInfo()
	PlayerAgent.instance:sendPM_GetSecondaryPwdInfoReq()

	local playerSecondaryPwdNum = playerSecondaryPwdPre .. tostring(LoginModel.instance.sessionId)
	local playerSecondaryPwd, playerSecondaryPwdSaltKey, playerSecondaryPwdType = self:_getSaveKeys()
	local passwordStr = Framework.LocalStorage.Instance:GetString(playerSecondaryPwd)
	local pwdType = Framework.LocalStorage.Instance:GetInt(playerSecondaryPwdType)
	local salt = Framework.LocalStorage.Instance:GetInt(playerSecondaryPwdSaltKey)

	if string.nilorempty(passwordStr) then
		local password = Framework.LocalStorage.Instance:GetInt(playerSecondaryPwdNum)

		if password > 0 then
			passwordStr = tostring(password)
			pwdType = 1
		end
	end

	PasswordLockModel.instance:setLocalPassword(password, salt, pwdType)
end

function PasswordLockController:onSetPassword(password, salt)
	password = tostring(password)
	salt = checknumber(salt)

	local playerSecondaryPwd, playerSecondaryPwdSaltKey = self:_getSaveKeys()

	Framework.LocalStorage.Instance:SetString(playerSecondaryPwd, password)
	Framework.LocalStorage.Instance:SetInt(playerSecondaryPwdSaltKey, salt)
	PasswordLockModel.instance:setLocalPassword(password, salt)
end

function PasswordLockController:onMustInputValidSecondaryPwdRes()
	self:_showView()
end

function PasswordLockController:checkNeedOpenVerifyView()
	if PasswordLockModel.instance:getResetPwdEndTime() > 0 or not PasswordLockModel.instance:checkClientPasswordUnlock() then
		self:_showView()

		return true
	end

	return false
end

function PasswordLockController:onSetSecondaryPwdRes(pwdInfo, password, pwdType)
	PasswordLockModel.instance:setPwdInfo(pwdInfo)

	password = tostring(password)

	if password and #password > 0 then
		UIStateManager.instance:push(ViewName.PasswordlockpreView, password, pwdType)
	end
end

function PasswordLockController:onChangeSecondaryPwdRes(pwdInfo, todayInputPwdFailCount, password, pwdType)
	PasswordLockModel.instance:setPwdInfo(pwdInfo)
	PasswordLockModel.instance:setTodayInputPwdFailCount(todayInputPwdFailCount)

	password = tostring(password)

	if password and #password > 0 then
		UIStateManager.instance:push(ViewName.PasswordlockpreView, password, pwdType)
	end
end

function PasswordLockController:_getSaveKeys()
	local pwdKey = playerSecondaryPwdStrPre .. tostring(LoginModel.instance.sessionId)
	local pwdSaltKey = playerSecondaryPwdSaltKeyPre .. tostring(LoginModel.instance.sessionId)
	local pwdType = PasswordLockController.playerSecondaryPwdTypePre .. tostring(LoginModel.instance.sessionId)

	return pwdKey, pwdSaltKey, pwdType
end

function PasswordLockController:tryStartResetTimer(msTime)
	removetimer(self._resetTick, self)

	local time = math.ceil(checknumber(msTime) / 1000)

	self._targetTime = 0

	if time > 0 then
		self._targetTime = ServerTime.now() + time + 2

		settimer(1, self._resetTick, self)
	end
end

function PasswordLockController:_resetTick()
	if ServerTime.now() >= self._targetTime then
		removetimer(self._resetTick, self)
		self:sendGetInfoCheckResetTime()
	end
end

function PasswordLockController:sendGetInfoCheckResetTime()
	local time = PasswordLockModel.instance:getResetPwdEndTime()

	if time > 0 then
		PlayerAgent.instance:sendPM_GetSecondaryPwdInfoReq()
	end
end

function PasswordLockController:_showView()
	if PasswordLockModel.instance:getResetPwdEndTime() > 0 then
		local text = "您的安全锁处于强制解锁状态，无法进行神钻、星神、灵纹、装备、宠物、精灵等系统相关的敏感操作。若强制解锁并非本人申请，可前往设置-安全锁中取消申请，同时建议您修改登录密码并谨慎保管。"

		TipsFacade.instance:openTipWindowNoX("提示", text)
	else
		UIStateManager.instance:push(ViewName.PasswordlockmainView, PasswordlockmainView.State.Verify)
	end
end

function PasswordLockController:savePasswordType(pwdType)
	local playerSecondaryPwd, playerSecondaryPwdSaltKey, playerSecondaryPwdType = self:_getSaveKeys()

	Framework.LocalStorage.Instance:SetInt(playerSecondaryPwdType, pwdType)
end

PasswordLockController.instance = PasswordLockController.New()

return PasswordLockController
