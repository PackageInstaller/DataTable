-- chunkname: @modules/logic/fight/model/FightEnemySideModel.lua

module("modules.logic.fight.model.FightEnemySideModel", package.seeall)

local FightEnemySideModel = class("FightEnemySideModel", BaseModel)

function FightEnemySideModel:getList()
	table.sort(self._list, FightHelper.sortAssembledMonsterFunc)

	return self._list
end

return FightEnemySideModel
