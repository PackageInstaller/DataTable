-- chunkname: @modules/logic/character/view/CharacterLv.lua

module("modules.logic.character.view.CharacterLv", package.seeall)

local CharacterLv = class("CharacterLv", RougeSimpleItemBase)

function CharacterLv:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterLv:addEvents()
	return
end

function CharacterLv:removeEvents()
	return
end

function CharacterLv.s_create(Self, srcGo, baseViewContainer)
	local item = CharacterLv.New({
		parent = Self,
		baseViewContainer = baseViewContainer
	})

	item:init(srcGo)

	return item
end

function CharacterLv.s_createByView(Self, srcGo)
	return (CharacterLv.s_create(Self, srcGo, Self.viewContainer))
end

function CharacterLv.s_createByListScrollCellExtend(Self, srcGo)
	local scrollView = Self._view

	if scrollView then
		return (CharacterLv:s_create(srcGo, scrollView.viewContainer or Self.viewContainer))
	end
end

function CharacterLv:ctor(...)
	CharacterLv.super.ctor(self, ...)
end

function CharacterLv:onDestroyView()
	CharacterLv.super.onDestroyView(self)
end

function CharacterLv:_editableInitView()
	CharacterLv.super._editableInitView(self)

	self._lvltxt = gohelper.findChildText(self.viewGO, "lvltxt")
	self._lv = gohelper.findChildText(self.viewGO, "lv")
end

function CharacterLv:setData(mo)
	CharacterLv.super.setData(self, mo)
	self:setLv(mo.level)

	return self
end

function CharacterLv:setLv(str)
	self._lvltxt.text = str or ""
end

function CharacterLv:setLvColor(hexColor)
	UIColorHelper.set(self._lvltxt, hexColor)

	if self._lv then
		UIColorHelper.set(self._lv, hexColor)
	end
end

return CharacterLv
