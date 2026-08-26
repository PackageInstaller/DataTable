-- chunkname: @modules/logic/dungeon/view/puzzle/DungeonPuzzleChangeColorShowColorItem.lua

module("modules.logic.dungeon.view.puzzle.DungeonPuzzleChangeColorShowColorItem", package.seeall)

local DungeonPuzzleChangeColorShowColorItem = class("DungeonPuzzleChangeColorShowColorItem", LuaCompBase)

function DungeonPuzzleChangeColorShowColorItem:init(go, id)
	self.go = go
	self.id = id
	self._image = go:GetComponent(gohelper.Type_Image)

	self:setItem()
end

function DungeonPuzzleChangeColorShowColorItem:setItem()
	local color = DungeonConfig.instance:getDecryptChangeColorColorCo(self.id).colorvalue

	SLFramework.UGUI.GuiHelper.SetColor(self._image, color)
end

function DungeonPuzzleChangeColorShowColorItem:onDestroy()
	gohelper.destroy(self.go)
end

return DungeonPuzzleChangeColorShowColorItem
