-- chunkname: @modules/logic/dungeon/view/DungeonEquipEntryViewSelectItem.lua

module("modules.logic.dungeon.view.DungeonEquipEntryViewSelectItem", package.seeall)

local DungeonEquipEntryViewSelectItem = class("DungeonEquipEntryViewSelectItem", LuaCompBase)

function DungeonEquipEntryViewSelectItem:ctor(propObj)
	return
end

function DungeonEquipEntryViewSelectItem:init(param)
	self._go = param.go
	self._pageIndex = param.index
	self._config = param.config
	self._selectGos = self:getUserDataTb_()

	for i = 1, 2 do
		local go = gohelper.findChild(self._go, "item" .. tostring(i))

		table.insert(self._selectGos, go)
	end

	transformhelper.setLocalPos(self._go.transform, param.pos, 0, 0)
end

function DungeonEquipEntryViewSelectItem:updateItem(targetPageIndex)
	local isTarget = self._pageIndex == targetPageIndex

	gohelper.setActive(self._selectGos[1], isTarget)
	gohelper.setActive(self._selectGos[2], not isTarget)
end

function DungeonEquipEntryViewSelectItem:addEventListeners()
	return
end

function DungeonEquipEntryViewSelectItem:removeEventListeners()
	return
end

function DungeonEquipEntryViewSelectItem:destroy()
	return
end

return DungeonEquipEntryViewSelectItem
