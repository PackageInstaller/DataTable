-- chunkname: @modules/logic/dungeon/view/puzzle/DungeonPuzzleChangeColorSortItem.lua

module("modules.logic.dungeon.view.puzzle.DungeonPuzzleChangeColorSortItem", package.seeall)

local DungeonPuzzleChangeColorSortItem = class("DungeonPuzzleChangeColorSortItem", LuaCompBase)

function DungeonPuzzleChangeColorSortItem:init(go, id)
	self.go = go
	self.id = id
	self._image = go:GetComponent(gohelper.Type_Image)
	self._txtname = gohelper.findChildText(go, "tiptxt")

	self:setItem()
end

function DungeonPuzzleChangeColorSortItem:setItem()
	local colorCo = DungeonConfig.instance:getDecryptChangeColorColorCo(self.id)

	SLFramework.UGUI.GuiHelper.SetColor(self._image, colorCo.colorvalue)

	self._txtname.text = colorCo.name
end

function DungeonPuzzleChangeColorSortItem:onDestroy()
	gohelper.destroy(self.go)
end

return DungeonPuzzleChangeColorSortItem
