-- chunkname: @modules/logic/login/controller/work/LoginPreInfoWork.lua

module("modules.logic.login.controller.work.LoginPreInfoWork", package.seeall)

local LoginPreInfoWork = class("LoginPreInfoWork", BaseWork)

function LoginPreInfoWork:ctor()
	return
end

function LoginPreInfoWork:onStart(context)
	CurrencyController.instance:registerCallback(CurrencyEvent.GetCurrencyInfoSuccess, self._onGetCurrencyInfoSuccess, self)
	OpenController.instance:registerCallback(OpenEvent.GetOpenInfoSuccess, self._onGetPlayerInfoSuccess, self)
	GuideController.instance:registerCallback(GuideEvent.GetGuideInfoSuccess, self._onGetGuideInfoSuccess, self)
	self:_getPlayerInfoBeforeLoading()
end

function LoginPreInfoWork:clearWork()
	CurrencyController.instance:unregisterCallback(CurrencyEvent.GetCurrencyInfoSuccess, self._onGetCurrencyInfoSuccess, self)
	OpenController.instance:unregisterCallback(OpenEvent.GetOpenInfoSuccess, self._onGetPlayerInfoSuccess, self)
	GuideController.instance:unregisterCallback(GuideEvent.GetGuideInfoSuccess, self._onGetGuideInfoSuccess, self)
	TaskDispatcher.cancelTask(self._getInfoTimeout, self)
end

function LoginPreInfoWork:_getPlayerInfoBeforeLoading()
	self._getPlayerInfo = nil
	self._getCurrencyInfo = nil
	self._getGuideInfo = nil

	TaskDispatcher.runDelay(self._getInfoTimeout, self, 60)
	CommonRpc.instance:sendGetServerTimeRequest()
	PlayerRpc.instance:sendGetPlayerInfoRequest()
	CurrencyRpc.instance:sendGetAllCurrency()
	GuideRpc.instance:sendGetGuideInfoRequest()
end

function LoginPreInfoWork:_sendPlayerBaseProperties()
	StatController.instance:onLogin()
end

function LoginPreInfoWork:_getInfoTimeout()
	if not self._getPlayerInfo or not self._getCurrencyInfo or not self._getGuideInfo then
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.LoginLostConnect1, MsgBoxEnum.BoxType.Yes, function()
			LoginController.instance:logout()
		end, nil)
	end
end

function LoginPreInfoWork:_checkPreInfo()
	if self._getPlayerInfo and self._getCurrencyInfo and self._getGuideInfo then
		TaskDispatcher.cancelTask(self._getInfoTimeout, self)
		self:_sendPlayerBaseProperties()

		if SDKDataTrackMgr then
			StatController.instance:track(StatEnum.EventName.GameLoading, {
				[StatEnum.EventProperties.IsEnterGame] = true
			})
		end

		self:onDone(true)
	end
end

function LoginPreInfoWork:_onGetPlayerInfoSuccess()
	OpenController.instance:unregisterCallback(OpenEvent.GetOpenInfoSuccess, self._onGetPlayerInfoSuccess, self)

	self._getPlayerInfo = true

	self:_checkPreInfo()
end

function LoginPreInfoWork:_onGetCurrencyInfoSuccess()
	CurrencyController.instance:unregisterCallback(CurrencyEvent.GetCurrencyInfoSuccess, self._onGetCurrencyInfoSuccess, self)

	self._getCurrencyInfo = true

	self:_checkPreInfo()
end

function LoginPreInfoWork:_onGetGuideInfoSuccess()
	GuideController.instance:unregisterCallback(GuideEvent.GetGuideInfoSuccess, self._onGetGuideInfoSuccess, self)

	self._getGuideInfo = true

	self:_checkPreInfo()
end

return LoginPreInfoWork
