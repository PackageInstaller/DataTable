-- chunkname: @modules/logic/fight/model/restart/FightRestartRequestType/FightRestartRequestType15.lua

module("modules.logic.fight.model.restart.FightRestartRequestType.FightRestartRequestType15", package.seeall)

local FightRestartRequestType15 = class("FightRestartRequestType15", FightRestartRequestType1)

function FightRestartRequestType15:requestFight()
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)
	local actId = Activity104Model.instance:getCurSeasonId()
	local layer = Activity104Model.instance:getBattleFinishLayer()
	local fightParam = FightModel.instance:getFightParam()
	local param = {
		isRestart = true,
		chapterId = fightParam.chapterId,
		episodeId = episodeId,
		fightParam = fightParam,
		multiplication = fightParam.multiplication
	}

	Activity104Rpc.instance:sendStartAct104BattleRequest(param, actId, (episodeCo.type == DungeonEnum.EpisodeType.SeasonRetail or nil) and 0, episodeId, self.enterFightAgainRpcCallback, self)
end

function FightRestartRequestType15:enterFightAgainRpcCallback(cmd, resultCode, msg)
	if resultCode ~= 0 then
		FightGameMgr.restartMgr:restartFightFail()

		return
	end

	self._fight_work:onDone(true)
end

return FightRestartRequestType15
