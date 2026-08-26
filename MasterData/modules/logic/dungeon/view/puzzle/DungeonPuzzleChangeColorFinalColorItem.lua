-- chunkname: @modules/logic/dungeon/view/puzzle/DungeonPuzzleChangeColorFinalColorItem.lua

module("modules.logic.dungeon.view.puzzle.DungeonPuzzleChangeColorFinalColorItem", package.seeall)

local DungeonPuzzleChangeColorFinalColorItem = class("DungeonPuzzleChangeColorFinalColorItem", LuaCompBase)

function DungeonPuzzleChangeColorFinalColorItem:init(go, id)
	self.go = go
	self.id = id
	self._image = go:GetComponent(gohelper.Type_Image)

	self:setItem()
end

function DungeonPuzzleChangeColorFinalColorItem:setItem()
	local color = DungeonConfig.instance:getDecryptChangeColorColorCo(self.id).colorvalue

	SLFramework.UGUI.GuiHelper.SetColor(self._image, color)
end

function DungeonPuzzleChangeColorFinalColorItem:onDestroy()
	gohelper.destroy(self.go)
end

return DungeonPuzzleChangeColorFinalColorItem
