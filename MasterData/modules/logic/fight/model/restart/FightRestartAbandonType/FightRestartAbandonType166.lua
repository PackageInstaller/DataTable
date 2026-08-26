-- chunkname: @modules/logic/fight/model/restart/FightRestartAbandonType/FightRestartAbandonType166.lua

module("modules.logic.fight.model.restart.FightRestartAbandonType.FightRestartAbandonType166", package.seeall)

local FightRestartAbandonType166 = class("FightRestartAbandonType166", FightRestartAbandonType1)

function FightRestartAbandonType166:ctor(fight_work, fightParam, episode_config, chapter_config)
	self:__onInit()

	self._fight_work = fight_work
	self._fightParam = fightParam
	self._episode_config = episode_config
	self._chapter_config = chapter_config
end

function FightRestartAbandonType166:canRestart()
	local context = Season166Model.instance:getBattleContext()
	local actId = context.actId
	local status = ActivityHelper.getActivityStatusAndToast(actId)
	local isLock = status ~= ActivityEnum.ActivityStatus.Normal
	local season166MO = Season166Model.instance:getActInfo(actId)

	if isLock or not season166MO then
		return false
	end

	return FightRestartAbandonType166.super.canRestart(self)
end

return FightRestartAbandonType166
