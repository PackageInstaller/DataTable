-- chunkname: @modules/logic/fight/model/restart/FightRestartAbandonType/FightRestartAbandonType111.lua

module("modules.logic.fight.model.restart.FightRestartAbandonType.FightRestartAbandonType111", package.seeall)

local FightRestartAbandonType111 = class("FightRestartAbandonType111", FightRestartAbandonType1)

function FightRestartAbandonType111:ctor(fight_work, fightParam, episode_config, chapter_config)
	self:__onInit()

	self._fight_work = fight_work
	self._fightParam = fightParam
	self._episode_config = episode_config
	self._chapter_config = chapter_config
end

function FightRestartAbandonType111:canRestart()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivityEnum.ActivityId.Act113]

	if not actInfoMo:isOnline() or not actInfoMo:isOpen() or actInfoMo:isExpired() then
		return false
	end

	return FightRestartAbandonType111.super.canRestart(self)
end

return FightRestartAbandonType111
