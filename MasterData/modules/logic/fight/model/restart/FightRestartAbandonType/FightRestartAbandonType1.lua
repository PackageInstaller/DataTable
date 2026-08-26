-- chunkname: @modules/logic/fight/model/restart/FightRestartAbandonType/FightRestartAbandonType1.lua

module("modules.logic.fight.model.restart.FightRestartAbandonType.FightRestartAbandonType1", package.seeall)

local FightRestartAbandonType1 = class("FightRestartAbandonType1", FightRestartAbandonTypeBase)

function FightRestartAbandonType1:ctor(fight_work, fightParam, episode_config, chapter_config)
	self:__onInit()

	self._fight_work = fight_work
	self._fightParam = fightParam
	self._episode_config = episode_config
	self._chapter_config = chapter_config
end

function FightRestartAbandonType1:canRestart()
	return (self:episodeCostIsEnough())
end

function FightRestartAbandonType1:startAbandon()
	DungeonFightController.instance:registerCallback(DungeonEvent.OnEndDungeonReply, self._startRequestFight, self)
	DungeonFightController.instance:sendEndFightRequest(true, DungeonEnum.EndType.Restart)
end

function FightRestartAbandonType1:_startRequestFight(resultCode)
	DungeonFightController.instance:unregisterCallback(DungeonEvent.OnEndDungeonReply, self._startRequestFight, self)

	if resultCode ~= 0 then
		FightGameMgr.restartMgr:restartFightFail()

		return
	end

	self._fight_work:onDone(true)
end

function FightRestartAbandonType1:releaseSelf()
	DungeonFightController.instance:unregisterCallback(DungeonEvent.OnEndDungeonReply, self._startRequestFight, self)
	self:__onDispose()
end

return FightRestartAbandonType1
