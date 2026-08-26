-- chunkname: @modules/logic/fight/model/restart/FightRestartRequestType/FightRestartRequestType128.lua

module("modules.logic.fight.model.restart.FightRestartRequestType.FightRestartRequestType128", package.seeall)

local FightRestartRequestType128 = class("FightRestartRequestType128", FightRestartRequestType1)

function FightRestartRequestType128:requestFight()
	self._fight_work:onDone(true)
	DungeonFightController.instance:restartStage()
end

return FightRestartRequestType128
