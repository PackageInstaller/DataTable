-- chunkname: @modules/logic/settings/view/SettingsPushView.lua

module("modules.logic.settings.view.SettingsPushView", package.seeall)

local SettingsPushView = class("SettingsPushView", BaseView)

function SettingsPushView:onInitView()
	self._btnreactivation = gohelper.findChildButtonWithAudio(self.viewGO, "lockScroll/Viewport/Content/reactivation/switch/btn")
	self._goreactivationon = gohelper.findChild(self.viewGO, "lockScroll/Viewport/Content/reactivation/switch/btn/on")
	self._goreactivationoff = gohelper.findChild(self.viewGO, "lockScroll/Viewport/Content/reactivation/switch/btn/off")
	self._btnroomproduceupperlimit = gohelper.findChildButtonWithAudio(self.viewGO, "lockScroll/Viewport/Content/roomproduceupperlimit/switch/btn")
	self._goroomproduceupperlimiton = gohelper.findChild(self.viewGO, "lockScroll/Viewport/Content/roomproduceupperlimit/switch/btn/on")
	self._goroomproduceupperlimitoff = gohelper.findChild(self.viewGO, "lockScroll/Viewport/Content/roomproduceupperlimit/switch/btn/off")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SettingsPushView:addEvents()
	self._btnreactivation:AddClickListener(self._btnreactivationOnClick, self)
	self._btnroomproduceupperlimit:AddClickListener(self._btnroomproduceupperlimitOnClick, self)
end

function SettingsPushView:removeEvents()
	self._btnreactivation:RemoveClickListener()
	self._btnroomproduceupperlimit:RemoveClickListener()
end

function SettingsPushView:_btnreactivationOnClick()
	local notificationEnable = SDKMgr.instance:isNotificationEnable()

	if not notificationEnable then
		GameFacade.showMessageBox(MessageBoxIdDefine.SDKUnlockMessagePush, MsgBoxEnum.BoxType.Yes_No, function()
			SDKMgr.instance:openNotificationSettings()
		end)

		return
	end

	local isOn = SettingsModel.instance:isPushTypeOn(SettingsEnum.PushType.Reactivation)
	local param = isOn and "0" or "1"

	UserSettingRpc.instance:sendUpdateSettingInfoRequest(SettingsEnum.PushType.Reactivation, param)
end

function SettingsPushView:_btnroomproduceupperlimitOnClick()
	local notificationEnable = SDKMgr.instance:isNotificationEnable()

	if not notificationEnable then
		GameFacade.showMessageBox(MessageBoxIdDefine.SDKUnlockMessagePush, MsgBoxEnum.BoxType.Yes_No, function()
			SDKMgr.instance:openNotificationSettings()
		end)

		return
	end

	local isOn = SettingsModel.instance:isPushTypeOn(SettingsEnum.PushType.Room_Produce_Upper_Limit)
	local param = isOn and "0" or "1"

	UserSettingRpc.instance:sendUpdateSettingInfoRequest(SettingsEnum.PushType.Room_Produce_Upper_Limit, param)
end

function SettingsPushView:_editableInitView()
	return
end

function SettingsPushView:onUpdateParam()
	self:_refreshUI()
end

function SettingsPushView:onOpen()
	self:addCustomEvents()
	self:_refreshUI()
end

function SettingsPushView:addCustomEvents()
	self.addEventCb(self, SettingsController.instance, SettingsEvent.OnChangePushType, self._refreshUI, self)
	self.addEventCb(self, GameStateMgr.instance, GameStateEvent.onApplicationPause, self._refreshUI, self)
end

function SettingsPushView:_refreshUI()
	self:_refreshReactivationUI()
	self:_refreshRoomProduceUpperLimitUI()
end

function SettingsPushView:_refreshReactivationUI()
	local isOn = SettingsModel.instance:isPushTypeOn(SettingsEnum.PushType.Reactivation)

	gohelper.setActive(self._goreactivationon, isOn)
	gohelper.setActive(self._goreactivationoff, not isOn)
end

function SettingsPushView:_refreshRoomProduceUpperLimitUI()
	local isOn = SettingsModel.instance:isPushTypeOn(SettingsEnum.PushType.Room_Produce_Upper_Limit)

	gohelper.setActive(self._goroomproduceupperlimiton, isOn)
	gohelper.setActive(self._goroomproduceupperlimitoff, not isOn)
end

function SettingsPushView:onClose()
	self:removeCustomEvents()
end

function SettingsPushView:removeCustomEvents()
	self.removeEventCb(self, SettingsController.instance, SettingsEvent.OnChangePushType, self._refreshUI, self)
	self.removeEventCb(self, GameStateMgr.instance, GameStateEvent.onApplicationPause, self._refreshUI, self)
end

function SettingsPushView:onDestroyView()
	return
end

return SettingsPushView
