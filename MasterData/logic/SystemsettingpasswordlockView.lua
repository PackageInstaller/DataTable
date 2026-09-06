-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/systemsetting/view/SystemsettingpasswordlockView.lua

module("logic.extensions.systemsetting.view.SystemsettingpasswordlockView", package.seeall)

local SystemsettingpasswordlockView = class("SystemsettingpasswordlockView", ViewComponent)

function SystemsettingpasswordlockView:ctor()
	SystemsettingpasswordlockView.super.ctor(self)
end

function SystemsettingpasswordlockView:unbindEvents()
	SystemsettingpasswordlockView.super.unbindEvents(self)
	self._btnChange:RemoveClickListener()
	self._btnUnlock:RemoveClickListener()
	self._btnLock:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
end

function SystemsettingpasswordlockView:bindEvents()
	SystemsettingpasswordlockView.super.bindEvents(self)
	self._btnChange:AddClickListener(self._onClickbtnChange, self)
	self._btnUnlock:AddClickListener(self._onClickbtnUnlock, self)
	self._btnLock:AddClickListener(self._onClickbtnLock, self)
	self._btnCancel:AddClickListener(self._onClickbtnCancel, self)
end

function SystemsettingpasswordlockView:buildUI()
	SystemsettingpasswordlockView.super.buildUI(self)

	self._btnChange = self:getBtn("normal/btnChange")
	self._btnUnlock = self:getBtn("normal/btnUnlock")
	self._btnLock = self:getBtn("normal/btnLock")
	self._normalGo = self:getGo("normal")
	self._resetGo = self:getGo("reset")
	self._txtTime = self:getTxt("reset/txtTime")
	self._btnCancel = self:getBtn("reset/btnCancel")
end

function SystemsettingpasswordlockView:onExit()
	SystemsettingpasswordlockView.super.onExit(self)
	removetimer(self._tick, self)
end

function SystemsettingpasswordlockView:onEnter()
	SystemsettingpasswordlockView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.SetSecondaryPwdRes, self._onSetSecondaryPwdRes, self)
	self.addGEvent(self, GlobalNotify.ClearSecondaryPwdRes, self._updateUI, self)
	self.addGEvent(self, GlobalNotify.CancelResetSecondaryPwdRes, self._updateUI, self)
	self.addGEvent(self, GlobalNotify.ReqResetSecondaryPwdRes, self._updateUI, self)
	self:_updateUI()
end

function SystemsettingpasswordlockView:_onClickbtnChange()
	UIStateManager.instance:push(ViewName.PasswordlockmainView, PasswordlockmainView.State.ChangePassword)
end

function SystemsettingpasswordlockView:_onClickbtnUnlock()
	UIStateManager.instance:push(ViewName.PasswordlockmainView, PasswordlockmainView.State.UnLock)
end

function SystemsettingpasswordlockView:_onClickbtnLock()
	UIStateManager.instance:push(ViewName.PasswordlockmainView, PasswordlockmainView.State.Lock)
end

function SystemsettingpasswordlockView:_onClickbtnCancel()
	local text = "取消后再次申请时倒计时将重头开始，是否确认取消"

	TipsFacade.instance:openPopupWindow("取消强制解锁", text, function()
		PlayerAgent.instance:sendPM_CancelResetSecondaryPwdReq()
	end)
end

function SystemsettingpasswordlockView:_updateUI()
	self:_initStatus()

	self._isApplyReset = self._servStatus == PasswordLockController.ServerStatus.REQ_RESET_PWD

	removetimer(self._tick, self)
	goutil.setActive(self._resetGo, self._isApplyReset)
	goutil.setActive(self._normalGo, not self._isApplyReset)

	if self._isApplyReset then
		self:_updateResetUI()
	else
		self:_updateNormalUI()
	end
end

function SystemsettingpasswordlockView:_initStatus()
	self._servStatus = PasswordLockModel.instance:getServStatus()
	self._clientStatus = PasswordLockModel.instance:getClientStatus()
end

function SystemsettingpasswordlockView:_updateNormalUI()
	self._isLock = self._servStatus == PasswordLockController.ServerStatus.WITH_PWD
	self._isSetPassword = self._servStatus == PasswordLockController.ServerStatus.WITH_PWD

	goutil.setActive(self._btnChange.gameObject, self._isSetPassword)
	goutil.setActive(self._btnLock.gameObject, not self._isLock)
	goutil.setActive(self._btnUnlock.gameObject, self._isLock)
end

function SystemsettingpasswordlockView:_updateResetUI()
	self._targetTimeStamp = PasswordLockModel.instance:getResetPwdEndTime()

	if self._targetTimeStamp <= 0 then
		removetimer(self._tick, self)
		self:_sendTickUnlock()
	else
		self._targetTimeStamp = self._targetTimeStamp

		goutil.setActive(self._btnCancel.gameObject, self._targetTimeStamp > ServerTime.now())
		settimer(1, self._tick, self, true)
		self:_tick()
	end
end

function SystemsettingpasswordlockView:_tick()
	local leftTime = self._targetTimeStamp - ServerTime.now()

	if leftTime <= 0 then
		goutil.setActive(self._btnCancel.gameObject, false)

		self._txtTime.text = ""

		removetimer(self._tick, self)
		self:_sendTickUnlock()
	else
		local str = GameUtil.FormatTimeWords(leftTime)

		self._txtTime.text = string.format("剩余时间\n<color=#c34850><size=22>%s</size></color>", str)
	end
end

function SystemsettingpasswordlockView:_onSetSecondaryPwdRes()
	self:_updateUI()
end

function SystemsettingpasswordlockView:_sendTickUnlock()
	PasswordLockController.instance:sendGetInfoCheckResetTime()
end

return SystemsettingpasswordlockView
