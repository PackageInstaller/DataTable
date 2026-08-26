-- chunkname: @modules/logic/fight/model/restart/FightRestartAbandonType/FightRestartAbandonType9.lua

module("modules.logic.fight.model.restart.FightRestartAbandonType.FightRestartAbandonType9", package.seeall)

local FightRestartAbandonType9 = class("FightRestartAbandonType9", FightRestartAbandonType1)

function FightRestartAbandonType9:ctor(fight_work, fightParam, episode_config, chapter_config)
	self:__onInit()

	self._fight_work = fight_work
	self._fightParam = fightParam
	self._episode_config = episode_config
	self._chapter_config = chapter_config
end

function FightRestartAbandonType9:canRestart()
	return (self:episodeCostIsEnough())
end

return FightRestartAbandonType9
