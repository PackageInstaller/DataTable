-- chunkname: @modules/logic/dungeon/model/DungeonMonsterListModel.lua

module("modules.logic.dungeon.model.DungeonMonsterListModel", package.seeall)

local DungeonMonsterListModel = class("DungeonMonsterListModel", ListScrollModel)

function DungeonMonsterListModel:setMonsterList(monsterDisplayList)
	local list = DungeonModel.instance:getMonsterDisplayList(monsterDisplayList)

	for i, v in ipairs(list) do
		list[i] = {
			config = v
		}
	end

	self:setList(list)

	self.initSelectMO = list[1]
end

DungeonMonsterListModel.instance = DungeonMonsterListModel.New()

return DungeonMonsterListModel
