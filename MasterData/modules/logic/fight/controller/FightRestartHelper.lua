-- chunkname: @modules/logic/fight/controller/FightRestartHelper.lua

module("modules.logic.fight.controller.FightRestartHelper", package.seeall)

local FightRestartHelper = _M

function FightRestartHelper.tryRestart()
	local fightRecordMO = FightModel.instance:getRecordMO()

	if fightRecordMO and fightRecordMO.fightResult == FightEnum.FightResult.Succ then
		return false
	end

	local episodeCo = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)
	local episodeType = episodeCo and episodeCo.type

	if not episodeType then
		return false
	end

	FightRestartHelper._initHandle()

	local handle = FightRestartHelper.handleDict[episodeType]

	return handle and handle()
end

function FightRestartHelper._initHandle()
	FightRestartHelper.handleDict = FightRestartHelper.handleDict or {
		[DungeonEnum.EpisodeType.Cachot] = FightRestartHelper.tryRestartCachot,
		[DungeonEnum.EpisodeType.Rouge] = FightRestartHelper.tryRestartRouge
	}
end

function FightRestartHelper.tryRestartCachot()
	local status = ActivityHelper.getActivityStatus(V1a6_CachotEnum.ActivityId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		return false
	end

	local topEventMo = V1a6_CachotRoomModel.instance:getNowBattleEventMo()

	if topEventMo then
		local difficulty = V1a6_CachotModel.instance:getRogueInfo().difficulty
		local difficultyCo = lua_rogue_difficulty.configDict[difficulty]
		local count = difficultyCo.retries - topEventMo:getRetries() + 1

		if count > 0 then
			MessageBoxController.instance:showMsgBoxAndSetBtn(MessageBoxIdDefine.V1a6CachotMsgBox05, MsgBoxEnum.BoxType.Yes_No, luaLang("cachot_continue_fight"), "RE CHALLENGE", luaLang("cachot_abort_fight"), "QUIT", FightRestartMgr.fastRestart, FightRestartHelper.onExitCachot, nil, FightGameMgr.restartMgr, nil, nil, count)

			return true
		end
	end

	return false
end

function FightRestartHelper.onExitCachot()
	RogueRpc.instance:sendAbortRogueRequest(V1a6_CachotEnum.ActivityId)
	FightGameMgr.playMgr:_PlayEnd()
end

function FightRestartHelper.tryRestartRouge()
	if (SLFramework.FrameworkSettings.IsEditor or isDebugBuild) and RougeEditorController.instance:isAllowAbortFight() then
		GMRpc.instance:sendGMRequest("rougeSetRetryNum 1 0")

		return false
	end

	if FightModel.instance:isAbort() then
		RougeRpc.instance:sendRougeAbortRequest(RougeModel.instance:getSeason() or 1)

		return false
	end

	if RougeModel.instance:isFinish() then
		return false
	end

	local fightResultMo = RougeModel.instance:getFightResultInfo()

	if not fightResultMo then
		return false
	end

	local maxNum = RougeMapConfig.instance:getFightRetryNum()

	if maxNum < fightResultMo.retryNum then
		return false
	end

	MessageBoxController.instance:showMsgBoxAndSetBtn(MessageBoxIdDefine.RougeFightFailConfirm, MsgBoxEnum.BoxType.Yes_No, luaLang("cachot_continue_fight"), "RE CHALLENGE", luaLang("cachot_abort_fight"), "QUIT", FightRestartMgr.fastRestart, FightRestartHelper.onExitFight, nil, FightGameMgr.restartMgr, nil, nil, maxNum - fightResultMo.retryNum + 1)

	return true
end

function FightRestartHelper.onExitFight()
	RougeRpc.instance:sendRougeAbortRequest(RougeModel.instance:getSeason() or 1)
	FightGameMgr.playMgr:_PlayEnd()
end

return FightRestartHelper
