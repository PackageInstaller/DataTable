-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/DungeonEntranceSecondTabItem.lua

module("logic.extensions.dungeon.view.DungeonEntranceSecondTabItem", package.seeall)

local M = class("DungeonEntranceSecondTabItem", ListBinderCell)

function M:ctor(compContainer)
	M.super.ctor(self, compContainer)
end

function M:_initComponents()
	self:_addComponent("entranceComp", DungeonEntranceCellComponent)
end

function M:onSelect(isSelected)
	if isSelected then
		GlobalDispatcher:dispatchEvent(EventType.Dungeon_Second_Entrance_Click, self._data)
	end
end

return M
