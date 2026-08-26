-- chunkname: @modules/logic/fight/model/restart/FightRestartAbandonType/FightRestartAbandonType161.lua

module("modules.logic.fight.model.restart.FightRestartAbandonType.FightRestartAbandonType161", package.seeall)

local FightRestartAbandonType161 = class("FightRestartAbandonType161", FightRestartAbandonType1)

function FightRestartAbandonType161:ctor(fight_work, fightParam, episode_config, chapter_config)
	self:__onInit()

	self._fight_work = fight_work
	self._fightParam = fightParam
	self._episode_config = episode_config
	self._chapter_config = chapter_config
end

function FightRestartAbandonType161:canRestart()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity1_6Enum.ActivityId.Dungeon]

	if not actInfoMo:isOnline() or not actInfoMo:isOpen() or actInfoMo:isExpired() then
		return false
	end

	return FightRestartAbandonType161.super.canRestart(self)
end

return FightRestartAbandonType161
