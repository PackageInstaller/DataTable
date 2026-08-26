-- chunkname: @modules/logic/fight/model/restart/FightRestartAbandonType/FightRestartAbandonType204.lua

module("modules.logic.fight.model.restart.FightRestartAbandonType.FightRestartAbandonType204", package.seeall)

local FightRestartAbandonType204 = class("FightRestartAbandonType204", FightRestartAbandonType1)

function FightRestartAbandonType204:ctor(fight_work, fightParam, episode_config, chapter_config)
	self:__onInit()

	self._fight_work = fight_work
	self._fightParam = fightParam
	self._episode_config = episode_config
	self._chapter_config = chapter_config
end

function FightRestartAbandonType204:canRestart()
	local actId = AbyssModel.instance:getCurActId()
	local status = ActivityHelper.getActivityStatusAndToast(actId)
	local isLock = status ~= ActivityEnum.ActivityStatus.Normal
	local abyssInfoMo = AbyssModel.instance:getInfoMo(actId)

	if isLock or not abyssInfoMo then
		return false
	end

	return FightRestartAbandonType204.super.canRestart(self)
end

return FightRestartAbandonType204
