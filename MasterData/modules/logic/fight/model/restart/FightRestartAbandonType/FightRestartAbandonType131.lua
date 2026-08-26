-- chunkname: @modules/logic/fight/model/restart/FightRestartAbandonType/FightRestartAbandonType131.lua

module("modules.logic.fight.model.restart.FightRestartAbandonType.FightRestartAbandonType131", package.seeall)

local FightRestartAbandonType131 = class("FightRestartAbandonType131", FightRestartAbandonType1)

function FightRestartAbandonType131:ctor(fight_work, fightParam, episode_config, chapter_config)
	self:__onInit()

	self._fight_work = fight_work
	self._fightParam = fightParam
	self._episode_config = episode_config
	self._chapter_config = chapter_config
end

function FightRestartAbandonType131:canRestart()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity1_3Enum.ActivityId.Dungeon]

	if not actInfoMo:isOnline() or not actInfoMo:isOpen() or actInfoMo:isExpired() then
		return false
	end

	return FightRestartAbandonType131.super.canRestart(self)
end

return FightRestartAbandonType131
