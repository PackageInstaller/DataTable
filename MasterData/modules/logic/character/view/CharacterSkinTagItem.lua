-- chunkname: @modules/logic/character/view/CharacterSkinTagItem.lua

module("modules.logic.character.view.CharacterSkinTagItem", package.seeall)

local CharacterSkinTagItem = class("CharacterSkinTagItem", ListScrollCellExtend)

function CharacterSkinTagItem:onInitView()
	self._color2 = gohelper.findChild(self.viewGO, "color2")
	self._color3 = gohelper.findChild(self.viewGO, "color3")
	self._color4 = gohelper.findChild(self.viewGO, "color4")
	self._color5 = gohelper.findChild(self.viewGO, "color5")
	self._txt = gohelper.findChildText(self.viewGO, "text")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterSkinTagItem:addEvents()
	return
end

function CharacterSkinTagItem:removeEvents()
	return
end

function CharacterSkinTagItem:_editableInitView()
	return
end

function CharacterSkinTagItem:_editableAddEvents()
	return
end

function CharacterSkinTagItem:_editableRemoveEvents()
	return
end

function CharacterSkinTagItem:onUpdateMO(config)
	self._txt.text = config.desc

	gohelper.setActive(self._color2, config.color == 2)
	gohelper.setActive(self._color3, config.color == 3)
	gohelper.setActive(self._color4, config.color == 4)
	gohelper.setActive(self._color5, config.color == 5)
end

return CharacterSkinTagItem
