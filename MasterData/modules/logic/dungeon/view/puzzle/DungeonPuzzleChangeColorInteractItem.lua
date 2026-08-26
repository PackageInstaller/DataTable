-- chunkname: @modules/logic/dungeon/view/puzzle/DungeonPuzzleChangeColorInteractItem.lua

module("modules.logic.dungeon.view.puzzle.DungeonPuzzleChangeColorInteractItem", package.seeall)

local DungeonPuzzleChangeColorInteractItem = class("DungeonPuzzleChangeColorInteractItem", LuaCompBase)

function DungeonPuzzleChangeColorInteractItem:init(go, id)
	self.go = go
	self.id = id
	self._click = gohelper.getClickWithAudio(self.go)

	self._click:AddClickListener(self._onItemClick, self)

	self._txtDesc = gohelper.findChildText(self.go, "desc")

	self:setItem()
end

function DungeonPuzzleChangeColorInteractItem:setItem()
	local interactCo = DungeonConfig.instance:getDecryptChangeColorInteractCo(self.id)

	self._txtDesc.text = interactCo.desc
end

function DungeonPuzzleChangeColorInteractItem:_onItemClick()
	DungeonPuzzleChangeColorController.instance:dispatchEvent(DungeonPuzzleEvent.InteractClick, self.id)
end

function DungeonPuzzleChangeColorInteractItem:onDestroy()
	self._click:RemoveClickListener()
	gohelper.destroy(self.go)
end

return DungeonPuzzleChangeColorInteractItem
