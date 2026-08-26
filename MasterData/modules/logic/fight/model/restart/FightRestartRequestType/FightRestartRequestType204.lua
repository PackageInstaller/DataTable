-- chunkname: @modules/logic/fight/model/restart/FightRestartRequestType/FightRestartRequestType204.lua

module("modules.logic.fight.model.restart.FightRestartRequestType.FightRestartRequestType204", package.seeall)

local FightRestartRequestType204 = class("FightRestartRequestType204", FightRestartRequestType1)

function FightRestartRequestType204:ctor(fight_work, fightParam, episode_config, chapter_config)
	self:__onInit()

	self._fight_work = fight_work
	self._fightParam = fightParam
	self._episode_config = episode_config
	self._chapter_config = chapter_config
end

function FightRestartRequestType204:requestFight()
	local param = {}
	local fightParam = FightModel.instance:getFightParam()

	param.fightParam = fightParam
	param.chapterId = fightParam.chapterId
	param.episodeId = fightParam.episodeId
	param.useRecord = false
	fightParam.isReplay = false
	fightParam.multiplication = 1
	param.multiplication = fightParam.multiplication
	param.activityId = AbyssModel.instance:getCurActId()
	param.stageId = AbyssModel.instance:getCurStageId()

	AbyssController.instance:enterFight(param, self._onReceiveBeforeStartBattleReply, self)
	self._fight_work:onDone(true)
end

function FightRestartRequestType204:_onReceiveBeforeStartBattleReply(cmd, resultCode, msg)
	if resultCode ~= 0 then
		FightGameMgr.restartMgr:restartFightFail()

		return
	end
end

function FightRestartRequestType204:releaseSelf()
	self:__onDispose()
end

return FightRestartRequestType204
