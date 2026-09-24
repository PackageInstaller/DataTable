-- chunkname: @modules/logic/settings/view/SettingsCurrencyViewItem.lua

module("modules.logic.settings.view.SettingsCurrencyViewItem", package.seeall)

local SettingsCurrencyViewItem = class("SettingsCurrencyViewItem", RougeSimpleItemBase)

function SettingsCurrencyViewItem:onInitView()
	self._txtnum = gohelper.findChildText(self.viewGO, "#txt_num")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SettingsCurrencyViewItem:addEvents()
	return
end

function SettingsCurrencyViewItem:removeEvents()
	return
end

function SettingsCurrencyViewItem:ctor(...)
	SettingsCurrencyViewItem.super.ctor(self, ...)
end

function SettingsCurrencyViewItem:_editableInitView()
	SettingsCurrencyViewItem.super._editableInitView(self)
end

function SettingsCurrencyViewItem:setData(mo)
	SettingsCurrencyViewItem.super.setData(self, mo)
end

function SettingsCurrencyViewItem:setTextNum(numStr)
	self._txtnum.text = numStr
end

function SettingsCurrencyViewItem:onDestroyView()
	SettingsCurrencyViewItem.super.onDestroyView(self)
end

return SettingsCurrencyViewItem
