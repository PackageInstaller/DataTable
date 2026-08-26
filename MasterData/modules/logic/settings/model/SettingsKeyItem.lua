-- chunkname: @modules/logic/settings/model/SettingsKeyItem.lua

module("modules.logic.settings.model.SettingsKeyItem", package.seeall)

local SettingsKeyItem = class("SettingsKeyItem", ListScrollCell)

function SettingsKeyItem:init(go)
	self._go = go
	self._txtdec = gohelper.findChildText(self._go, "#txt_dec")
	self._btnshortcuts = gohelper.findChildButtonWithAudio(self._go, "#btn_shortcuts")
	self._txtshortcuts = gohelper.findChildText(self._go, "#btn_shortcuts/#txt_shortcuts")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SettingsKeyItem:onUpdateMO(mo)
	self._mo = mo
	self._txtdec.text = self._mo.value.description
	self._txtshortcuts.text = PCInputController.instance:KeyNameToDescName(self._mo.value.key)

	recthelper.setAnchorY(self._go.transform, 0)
end

function SettingsKeyItem:addEventListeners()
	self._btnshortcuts:AddClickListener(self.OnClick, self)
end

function SettingsKeyItem:removeEventListeners()
	self._btnshortcuts:RemoveClickListener()
end

function SettingsKeyItem:onDestroy()
	return
end

function SettingsKeyItem:OnClick()
	ViewMgr.instance:openView(ViewName.KeyMapAlertView, self._mo)
end

return SettingsKeyItem
