-- chunkname: @modules/logic/settings/view/SettingsCategoryListItem.lua

module("modules.logic.settings.view.SettingsCategoryListItem", package.seeall)

local SettingsCategoryListItem = class("SettingsCategoryListItem", ListScrollCellExtend)

function SettingsCategoryListItem:onInitView()
	self._gooff = gohelper.findChild(self.viewGO, "#go_off")
	self._txtitemcn1 = gohelper.findChildText(self.viewGO, "#go_off/#txt_itemcn1")
	self._txtitemen1 = gohelper.findChildText(self.viewGO, "#go_off/#txt_itemen1")
	self._goon = gohelper.findChild(self.viewGO, "#go_on")
	self._txtitemcn2 = gohelper.findChildText(self.viewGO, "#go_on/#txt_itemcn2")
	self._txtitemen2 = gohelper.findChildText(self.viewGO, "#go_on/#txt_itemen2")
	self._btnselect = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_select")
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SettingsCategoryListItem:addEvents()
	self._btnselect:AddClickListener(self._btnselectOnClick, self)
	SettingsController.instance:registerCallback(SettingsEvent.PlayCloseCategoryAnim, self._playCloseAnim, self)
	SettingsController.instance:registerCallback(SettingsEvent.OnChangeLangTxt, self._onChangeLangTxt, self)
end

function SettingsCategoryListItem:removeEvents()
	self._btnselect:RemoveClickListener()
	SettingsController.instance:unregisterCallback(SettingsEvent.PlayCloseCategoryAnim, self._playCloseAnim, self)
	SettingsController.instance:unregisterCallback(SettingsEvent.OnChangeLangTxt, self._onChangeLangTxt, self)
end

function SettingsCategoryListItem:_btnselectOnClick()
	SettingsController.instance:dispatchEvent(SettingsEvent.SelectCategory, self._mo.id)
end

function SettingsCategoryListItem:_editableInitView()
	return
end

function SettingsCategoryListItem:_editableAddEvents()
	return
end

function SettingsCategoryListItem:_editableRemoveEvents()
	return
end

function SettingsCategoryListItem:onUpdateMO(mo)
	self._mo = mo

	local target = self:_isSelected()

	gohelper.setActive(self._gooff, not target)
	gohelper.setActive(self._goon, target)

	if target then
		self._txtitemcn2.text = luaLang(mo.name)
		self._txtitemen2.text = mo.subname
	else
		self._txtitemcn1.text = luaLang(mo.name)
		self._txtitemen1.text = mo.subname
	end
end

function SettingsCategoryListItem:_onChangeLangTxt(isSelect)
	local target = self:_isSelected()

	if target then
		self._txtitemcn2.text = luaLang(self._mo.name)
		self._txtitemen2.text = self._mo.subname
	else
		self._txtitemcn1.text = luaLang(self._mo.name)
		self._txtitemen1.text = self._mo.subname
	end
end

function SettingsCategoryListItem:onSelect(isSelect)
	return
end

function SettingsCategoryListItem:onDestroyView()
	return
end

function SettingsCategoryListItem:_isSelected()
	return self._mo.id == SettingsModel.instance:getCurCategoryId()
end

function SettingsCategoryListItem:_playCloseAnim()
	self._anim:Play("settingitem_out", 0, 0)
end

return SettingsCategoryListItem
