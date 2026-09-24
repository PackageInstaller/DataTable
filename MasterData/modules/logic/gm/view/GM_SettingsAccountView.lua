-- chunkname: @modules/logic/gm/view/GM_SettingsAccountView.lua

module("modules.logic.gm.view.GM_SettingsAccountView", package.seeall)

local GM_SettingsAccountView = class("GM_SettingsAccountView", BaseView)

function GM_SettingsAccountView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "btnClose")
	self._item1Toggle = gohelper.findChildToggle(self.viewGO, "viewport/content/item1/Toggle")
end

function GM_SettingsAccountView:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
	self._item1Toggle:AddOnValueChanged(self._onItem1ToggleValueChanged, self)
end

function GM_SettingsAccountView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._item1Toggle:RemoveOnValueChanged()
end

function GM_SettingsAccountView:onOpen()
	self:_refreshItem1()
end

function GM_SettingsAccountView:onDestroyView()
	return
end

GM_SettingsAccountView.s_ShowNodeAccountInfo = false

function GM_SettingsAccountView:_refreshItem1()
	self._item1Toggle.isOn = GM_SettingsAccountView.s_ShowNodeAccountInfo
end

function GM_SettingsAccountView:_onItem1ToggleValueChanged()
	local isOn = self._item1Toggle.isOn

	GM_SettingsAccountView.s_ShowNodeAccountInfo = isOn

	GMController.instance:dispatchEvent(GMEvent.SettingsAccountView_ShowNodeAccountInfo, isOn)
end

return GM_SettingsAccountView
