-- chunkname: @modules/logic/fight/model/restart/FightRestartRequestType/FightRestartRequestType9.lua

module("modules.logic.fight.model.restart.FightRestartRequestType.FightRestartRequestType9", package.seeall)

local FightRestartRequestType9 = class("FightRestartRequestType9", UserDataDispose)

function FightRestartRequestType9:ctor(fight_work, fightParam, episode_config, chapter_config)
	self:__onInit()

	self._fight_work = fight_work
	self._fightParam = fightParam
	self._episode_config = episode_config
	self._chapter_config = chapter_config
end

function FightRestartRequestType9:requestFight()
	self._fight_work:onDone(true)

	local elementId = WeekWalkModel.instance:getBattleElementId()

	WeekwalkRpc.instance:sendBeforeStartWeekwalkBattleRequest(elementId, nil, self._onReceiveBeforeStartWeekwalkBattleReply, self)
end

function FightRestartRequestType9:_onReceiveBeforeStartWeekwalkBattleReply(cmd, resultCode, msg)
	if resultCode ~= 0 then
		FightGameMgr.restartMgr:restartFightFail()

		return
	end

	DungeonFightController.instance:restartStage()
end

function FightRestartRequestType9:releaseSelf()
	self:__onDispose()
end

return FightRestartRequestType9
