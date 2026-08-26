-- chunkname: @modules/logic/settings/view/SettingsOtherView.lua

module("modules.logic.settings.view.SettingsOtherView", package.seeall)

local SettingsOtherView = class("SettingsOtherView", BaseView)

function SettingsOtherView:onInitView()
	self._goscreenshot = gohelper.findChild(self.viewGO, "#go_screenshot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SettingsOtherView:addEvents()
	return
end

function SettingsOtherView:removeEvents()
	return
end

function SettingsOtherView:_editableInitView()
	self._itemTableDict = {}

	self:_initItem(self._goscreenshot, "screenshot")
end

function SettingsOtherView:_initItem(go, name)
	local itemTable = self:getUserDataTb_()

	itemTable.btn = gohelper.findChildButtonWithAudio(go, "switch/btn")
	itemTable.off = gohelper.findChild(go, "switch/btn/off")
	itemTable.on = gohelper.findChild(go, "switch/btn/on")

	itemTable.btn:AddClickListener(self._onSwitchClick, self, name)

	self._itemTableDict[name] = itemTable
end

function SettingsOtherView:_onSwitchClick(name)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if name == "screenshot" then
		local screenshotSwitch = not SettingsModel.instance:getScreenshotSwitch()

		SettingsModel.instance:setScreenshotSwitch(screenshotSwitch)
	end

	self:_refreshSwitchUI(name)
end

function SettingsOtherView:_refreshSwitchUI(name)
	local itemTable = self._itemTableDict[name]

	if not itemTable then
		return
	end

	local switch = false

	if name == "screenshot" then
		switch = SettingsModel.instance:getScreenshotSwitch()
	end

	gohelper.setActive(itemTable.on, switch)
	gohelper.setActive(itemTable.off, not switch)
end

function SettingsOtherView:onUpdateParam()
	self:_refreshUI()
end

function SettingsOtherView:onOpen()
	self:_refreshUI()
end

function SettingsOtherView:_refreshUI()
	self:_refreshSwitchUI("screenshot")
end

function SettingsOtherView:onClose()
	return
end

function SettingsOtherView:onDestroyView()
	for name, itemTable in pairs(self._itemTableDict) do
		itemTable.btn:RemoveClickListener()
	end
end

return SettingsOtherView
