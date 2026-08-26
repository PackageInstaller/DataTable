-- chunkname: @modules/logic/fight/model/restart/FightRestartRequestType/FightRestartRequestType34.lua

module("modules.logic.fight.model.restart.FightRestartRequestType.FightRestartRequestType34", package.seeall)

local FightRestartRequestType34 = class("FightRestartRequestType34", FightRestartRequestType1)

function FightRestartRequestType34:requestFight()
	self._fight_work:onDone(true)
	TowerController.instance:restartStage()
end

return FightRestartRequestType34
