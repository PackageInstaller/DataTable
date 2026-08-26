-- chunkname: @modules/logic/fight/model/restart/FightRestartRequestType/FightRestartRequestType166.lua

module("modules.logic.fight.model.restart.FightRestartRequestType.FightRestartRequestType166", package.seeall)

local FightRestartRequestType166 = class("FightRestartRequestType166", FightRestartRequestType1)

function FightRestartRequestType166:ctor(fight_work, fightParam, episode_config, chapter_config)
	self:__onInit()

	self._fight_work = fight_work
	self._fightParam = fightParam
	self._episode_config = episode_config
	self._chapter_config = chapter_config
end

function FightRestartRequestType166:requestFight()
	local fightParam = FightModel.instance:getFightParam()
	local context = Season166Model.instance:getBattleContext()
	local actId = context.actId
	local episodeId = fightParam.episodeId
	local episodeType = context.episodeType
	local configId = Season166HeroGroupModel.instance:getEpisodeConfigId(fightParam.episodeId)
	local talentId = context.talentId
	local chapterId = fightParam.chapterId

	Activity166Rpc.instance:sendStartAct166BattleRequest(actId, episodeType, configId, talentId, chapterId, episodeId, fightParam, 1, nil, nil, true, self._onReceiveBeforeStartBattleReply, self)
	self._fight_work:onDone(true)
end

function FightRestartRequestType166:_onReceiveBeforeStartBattleReply(cmd, resultCode, msg)
	if resultCode ~= 0 then
		FightGameMgr.restartMgr:restartFightFail()

		return
	end
end

function FightRestartRequestType166:releaseSelf()
	self:__onDispose()
end

return FightRestartRequestType166
