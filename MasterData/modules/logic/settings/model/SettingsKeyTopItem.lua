-- chunkname: @modules/logic/settings/model/SettingsKeyTopItem.lua

module("modules.logic.settings.model.SettingsKeyTopItem", package.seeall)

local SettingsKeyTopItem = class("SettingsKeyTopItem", ListScrollCell)

function SettingsKeyTopItem:init(go)
	self._go = go
	self._goUnchoose = gohelper.findChild(self._go, "#go_unchoose")
	self._goChoose = gohelper.findChild(self._go, "#go_choose")
	self._btn = gohelper.findChildButtonWithAudio(self._go, "btn")
	self._txtunchoose = gohelper.findChildText(self._go, "#go_unchoose/#txt_unchoose")
	self._txtchoose = gohelper.findChildText(self._go, "#go_choose/#txt_choose")
end

function SettingsKeyTopItem:onSelect(isSelect)
	self._goUnchoose:SetActive(not isSelect)
	self._goChoose:SetActive(isSelect)
end

function SettingsKeyTopItem:onUpdateMO(mo)
	self._mo = mo
	self._txtunchoose.text = mo.name
	self._txtchoose.text = mo.name
end

function SettingsKeyTopItem:addEventListeners()
	self._btn:AddClickListener(self.OnClick, self)
end

function SettingsKeyTopItem:removeEventListeners()
	self._btn:RemoveClickListener()
end

function SettingsKeyTopItem:onDestroy()
	return
end

function SettingsKeyTopItem:OnClick()
	self._view:selectCell(self._index, true)
	SettingsController.instance:dispatchEvent(SettingsEvent.OnKeyMapChange, self._index)
end

return SettingsKeyTopItem
