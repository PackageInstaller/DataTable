-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mahjongbattle/controller/MahjongBattleController.lua

module("logic.extensions.mahjongbattle.controller.MahjongBattleController", package.seeall)

local MahjongBattleController = class("MahjongBattleController", BaseController)

MahjongBattleController.TEACH_STAGE_ID_KEY_PREFIX = "mahjong_battle_teach_stageid_"

function MahjongBattleController:onInit()
	self:onReset()
end

function MahjongBattleController:onReset()
	self._fmtMo = nil
	self._curStateMap = {}
	self._lastBattleResult = nil
	self._isPlayViedo = false
	self._isTeachMode = false
end

function MahjongBattleController:setIsPlayVideo(isPlay)
	self._isPlayViedo = isPlay
end

function MahjongBattleController:getIsPlayVideo()
	return self._isPlayViedo
end

function MahjongBattleController:playVideo()
	if self._isPlayViedo and self._lastBattleResult then
		UIJumper.instance:saveCurStack()
		BattleFacade.instance:onViewUserFightMonsterBtlResult(self._lastBattleResult)
	end

	self._isPlayViedo = false
end

function MahjongBattleController:showMissionView(activityId)
	self._fmtMo = self._fmtMo or MahjongBattleFmtMo.New()

	self._fmtMo:initParams(activityId)
	CustomFmtController.instance:showMissionView(self._fmtMo)
end

function MahjongBattleController:_onBattleEnd()
	BattleFacade.instance:registerResultHandler(nil, nil)
	UIStateManager.instance:push(ViewName.MahjongBattleResultView)

	return true
end

function MahjongBattleController:gmCoverHand(activityId, mahjongIdList)
	local handMahjongList = MahjongBattleModel.instance:getCurHandMahjongByActId(activityId)

	if not handMahjongList or #handMahjongList == 0 then
		FloatWordMgr.instance:show("当前手牌为空，无法覆盖")

		return
	end

	if #handMahjongList ~= #mahjongIdList then
		FloatWordMgr.instance:show("GM覆盖手牌的数量与当前手牌数量不同，请确认")

		return
	end

	GMAgent.instance:sendPM_MahjongBattleCoverMahjongReq(activityId, mahjongIdList)
end

function MahjongBattleController:handleGmCoverHandRes(msg)
	MahjongBattleModel.instance:onGmCoverHand(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_MahjongBattleGmCoverHandRes)
end

function MahjongBattleController:gmCoverSystemCard(activityId, mahjongIdList)
	local drawnMahjongList = MahjongBattleModel.instance:getCurDrawnMahjongByActId(activityId)

	if not drawnMahjongList or #drawnMahjongList == 0 then
		FloatWordMgr.instance:show("当前系统牌为空，无法覆盖")

		return
	end

	if #drawnMahjongList ~= #mahjongIdList then
		FloatWordMgr.instance:show("GM覆盖系统牌的数量与当前系统牌数量不同，请确认")

		return
	end

	GMAgent.instance:sendPM_MahjongBattleChangeDrawMahjongReq(activityId, mahjongIdList)
end

function MahjongBattleController:handleGmCoverSystemCardRes(msg)
	MahjongBattleModel.instance:onGmCoverSystemCard(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_MahjongBattleGmCoverSystemCardRes)
end

function MahjongBattleController:getInfo(activityId)
	MahjongBattleAgent.instance:sendPM_MahjongBattleInfoReq(activityId)
end

function MahjongBattleController:handleGetInfoRes(msg)
	MahjongBattleModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_MahjongBattleGetInfoRes)
end

function MahjongBattleController:randomCardLuck(activityId)
	MahjongBattleAgent.instance:sendPM_MahjongBattleRandomCarkLuckReq(activityId)
end

function MahjongBattleController:handleRandomCardLuckRes(msg)
	MahjongBattleModel.instance:onRandomCardLuck(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_MahjongBattleRandomCardLuckRes)
end

function MahjongBattleController:giveUp(activityId)
	MahjongBattleAgent.instance:sendPM_MahjongBattleGiveUpReq(activityId)
end

function MahjongBattleController:handleGiveUpRes(msg)
	MahjongBattleModel.instance:onGiveUp(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_MahjongBattleGiveUpRes)
end

function MahjongBattleController:requestRankView(activityId)
	MahjongBattleAgent.instance:sendPM_MahjongBattleRankViewReq(activityId)
end

function MahjongBattleController:handleRankViewRes(msg)
	MahjongBattleModel.instance:onRankView(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_MahjongBattleRankViewRes)
end

function MahjongBattleController:requestFightReport(activityId)
	MahjongBattleAgent.instance:sendPM_MahjongBattleViewBtlReportReq(activityId)
end

function MahjongBattleController:handleFightReportRes(msg)
	MahjongBattleModel.instance:onFightReport(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_MahjongBattleViewBtlReportRes)
end

function MahjongBattleController:drawGenre(activityId)
	MahjongBattleAgent.instance:sendPM_MahjongBattleDrawGenreReq(activityId)
end

function MahjongBattleController:handleDrawGenreRes(msg)
	MahjongBattleModel.instance:onDrawGenre(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_MahjongBattleDrawGenreRes)
end

function MahjongBattleController:selectGenre(activityId, isRandom, genreId)
	MahjongBattleAgent.instance:sendPM_MahjongBattleSelectGenreReq(activityId, isRandom, genreId)
end

function MahjongBattleController:handleSelectGenreRes(msg)
	MahjongBattleModel.instance:onSelectGenre(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_MahjongBattleSelectGenreRes)
end

function MahjongBattleController:drawMahjong(activityId)
	MahjongBattleAgent.instance:sendPM_MahjongDrawMahjongReq(activityId)
end

function MahjongBattleController:handleDrawMahjongRes(msg)
	MahjongBattleModel.instance:onDrawMahjong(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_MahjongBattleDrawMahjongRes)
end

function MahjongBattleController:selectMahjong(activityId, mahjongId)
	MahjongBattleAgent.instance:sendPM_MahjongBattleselectMahjongReq(activityId, mahjongId)
end

function MahjongBattleController:handleSelectMahjongRes(msg)
	MahjongBattleModel.instance:onSelectMahjong(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_MahjongBattleSelectMahjongRes)
end

function MahjongBattleController:dropMahjong(activityId, mahjongId)
	MahjongBattleAgent.instance:sendPM_MahjongBattleDropMahjongReq(activityId, mahjongId)
end

function MahjongBattleController:handleDropMahjongRes(msg)
	MahjongBattleModel.instance:onDropMahjong(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_MahjongBattleDropMahjongRes)
end

function MahjongBattleController:matchOpponent(activityId)
	MahjongBattleAgent.instance:sendPM_MahjongBattleMatchFightReq(activityId)
end

function MahjongBattleController:handleMatchOpponentRes(msg)
	MahjongBattleModel.instance:onMatchOpponent(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_MahjongBattleMatchFightRes)
end

function MahjongBattleController:startFight(activityId, form)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onBattleEnd, self))
	MahjongBattleAgent.instance:sendPM_MahjongBattleFightReq(activityId, form)
end

function MahjongBattleController:handleFightRes(msg)
	return
end

function MahjongBattleController:_onTeachBattleEnd(activityId)
	BattleFacade.instance:registerResultHandler(nil, nil)
	TipsFacade.instance:openTipWindowNoX(lang("提示"), lang("恭喜您完成教学！"), function()
		self:enterNextTeachStage(activityId)
		BattleController.instance:endBattle()
	end, lang("确定"))

	return true
end

function MahjongBattleController:startTeachFight(activityId, form)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onTeachBattleEnd, self, activityId))
	MahjongBattleAgent.instance:sendPM_MahjongBattleTeachFightReq(activityId, form)
end

function MahjongBattleController:handleNotifyTeachFightResult(msg)
	return
end

function MahjongBattleController:requestBtlReport(activityId)
	MahjongBattleAgent.instance:sendPM_MahjongBattleViewBtlReportReq(activityId)
end

function MahjongBattleController:handleBtlReportRes(msg)
	MahjongBattleModel.instance:onViewBtlReport(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_MahjongBattleViewBtlReportRes)
end

function MahjongBattleController:handleNotifyFightResult(msg)
	MahjongBattleModel.instance:onNotifyFightResult(msg)

	self._lastBattleResult = msg.battleResult

	BattleModel.instance:setLeftTeamId(0)
	BattleController.instance:viewUserFightMonsterBtlResult(self._lastBattleResult, false)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onBattleEnd, self))
end

function MahjongBattleController:handleNotifyDrawMahjong(msg)
	MahjongBattleModel.instance:onNotifyDrawMahjong(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_MahjongBattleNotifyDrawMahjong)
end

function MahjongBattleController:selectSummonBuff(activityId, buffId)
	MahjongBattleAgent.instance:sendPM_MahjongBattleSelectSummonBuffReq(activityId, buffId)
end

function MahjongBattleController:handleSelectSummonBuffRes(msg)
	MahjongBattleModel.instance:onSelectSummonBuff(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_MahjongBattleSelectSummonBuffRes)
end

function MahjongBattleController:summon(activityId, summonType, operaMahjongId)
	MahjongBattleAgent.instance:sendPM_MahjongBattleSummonReq(activityId, summonType, operaMahjongId)
end

function MahjongBattleController:handleSummonRes(msg)
	MahjongBattleModel.instance:onSummon(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_MahjongBattleSummonRes)
end

function MahjongBattleController:selectSummonPet(activityId, selectSummonPetId)
	MahjongBattleAgent.instance:sendPM_MahjongBattleSelectSummonPetReq(activityId, selectSummonPetId)
end

function MahjongBattleController:handleSelectSummonPetRes(msg)
	MahjongBattleModel.instance:onSelectSummonPet(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_MahjongBattleSelectSummonPetRes)
end

function MahjongBattleController:dropPet(activityId, dropPetId)
	MahjongBattleAgent.instance:sendPM_MahjongBattleDropPetReq(activityId, dropPetId)
end

function MahjongBattleController:handleDropPetRes(msg)
	MahjongBattleModel.instance:onDropPet(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_MahjongBattleDropPetRes)
end

function MahjongBattleController:startGame(activityId)
	self:drawGenre(activityId)
end

function MahjongBattleController:continueGame(activityId)
	local state = MahjongBattleModel.instance:getCurStateByActId(activityId)

	if state == MahjongBattleModel.PLAYER_STATE.WAITING_SELECT_TEAM then
		UIStateManager.instance:push(ViewName.MahjongBattleSelectTeamView, activityId)
	elseif state == MahjongBattleModel.PLAYER_STATE.WAITING_DRAW_MAHJONG then
		UIStateManager.instance:push(ViewName.MahjongBattleGameView, activityId)
	elseif state == MahjongBattleModel.PLAYER_STATE.WAITING_SELECT_MAHJONG then
		UIStateManager.instance:push(ViewName.MahjongBattleGameView, activityId)
	elseif state == MahjongBattleModel.PLAYER_STATE.WAITING_DROP_MAHJONG then
		UIStateManager.instance:push(ViewName.MahjongBattleGameView, activityId)
	elseif state == MahjongBattleModel.PLAYER_STATE.WAITING_OPERATION then
		UIStateManager.instance:push(ViewName.MahjongBattleGameView, activityId)
	elseif state == MahjongBattleModel.PLAYER_STATE.WAITING_MATCH_OPPONENT then
		UIStateManager.instance:push(ViewName.MahjongBattleMatchView, activityId)
	elseif state == MahjongBattleModel.PLAYER_STATE.WAITING_SELECT_SUMMON_BUFF then
		UIStateManager.instance:push(ViewName.MahjongBattleBuffView, activityId)
	elseif state == MahjongBattleModel.PLAYER_STATE.WAITING_SELECT_SUMMON_PET then
		UIStateManager.instance:popByName(ViewName.MahjongBattleBuffView)
		UIStateManager.instance:popByName(ViewName.MahjongBattleGameView)
		UIStateManager.instance:push(ViewName.MahjongBattleSummonView, activityId)
	elseif state == MahjongBattleModel.PLAYER_STATE.MATCHED_OPPONENT then
		UIStateManager.instance:popByName(ViewName.MahjongBattleSummonView)
		UIStateManager.instance:popByName(ViewName.MahjongBattleGameView)
		self:showMissionView(activityId)
	else
		UIStateManager.instance:push(ViewName.MahjongBattleMainView, activityId)
	end
end

function MahjongBattleController:convertMahjongIdToData(activityId, mahjongId)
	local data
	local mahjongCfg = MahjongBattleConfig.instance:getMahjongCfg(activityId, mahjongId)

	if mahjongCfg then
		data = MahjongData.New()

		data:setTileData(mahjongCfg.type, mahjongCfg.sameTypeMahjongSubId)
		data:setExtraParam("mahjongId", mahjongId)
		data:setExtraParam("showPic", mahjongCfg.showPic or "")
	end

	return data
end

function MahjongBattleController:convertMahjongIdListToDataList(activityId, mahjongIdList)
	local mahjongDataList = {}

	for k, v in ipairs(mahjongIdList) do
		local mahjongData = self:convertMahjongIdToData(activityId, v)

		if mahjongData then
			table.insert(mahjongDataList, mahjongData)
		end
	end

	return mahjongDataList
end

function MahjongBattleController:setTeachMode(isTeachMode)
	self._isTeachMode = isTeachMode
end

function MahjongBattleController:getIsTeachMode()
	return self._isTeachMode
end

function MahjongBattleController:getTeachStageId(activityId)
	local key = self.TEACH_STAGE_ID_KEY_PREFIX .. tostring(activityId)

	return checknumber(GameUtil.getUserData(key))
end

function MahjongBattleController:setTeachStageId(activityId, stageId)
	local lastId = self:getTeachStageId(activityId)

	if lastId ~= stageId then
		if stageId == 0 then
			-- block empty
		else
			local teachFakeDataCfg = MahjongBattleConfig.instance:getTeachFakeDataCfg(activityId, stageId)

			if not teachFakeDataCfg then
				printError("警告：设置麻将乱斗教学阶段Id时，传入了一个无效的阶段Id，activityId：" .. tostring(activityId) .. "，stageId：" .. tostring(stageId))

				return
			end
		end

		local key = self.TEACH_STAGE_ID_KEY_PREFIX .. tostring(activityId)

		GameUtil.saveUserData(key, stageId)
		GlobalDispatcher:dispatch(GlobalNotify.MahjongBattleTeachDataChange)
	end
end

function MahjongBattleController:getCurTeachFakeDataCfg(activityId)
	local stageId = self:getTeachStageId(activityId)

	if stageId and stageId ~= 0 then
		return MahjongBattleConfig.instance:getTeachFakeDataCfg(activityId, stageId)
	end

	return nil
end

function MahjongBattleController:getCurTeachPlayerState(activityId)
	local teachFakeDataCfg = self:getCurTeachFakeDataCfg(activityId)

	if teachFakeDataCfg then
		return teachFakeDataCfg.state
	end

	return MahjongBattleModel.PLAYER_STATE.NONE
end

function MahjongBattleController:enterNextTeachStage(activityId)
	local curStageId = self:getTeachStageId(activityId)
	local nextStageId = curStageId + 1
	local nextTeachFakeDataCfg = MahjongBattleConfig.instance:getTeachFakeDataCfg(activityId, nextStageId)

	if nextTeachFakeDataCfg then
		self:setTeachStageId(activityId, nextStageId)
	else
		self:setTeachStageId(activityId, 0)
		self:setTeachMode(false)
	end
end

MahjongBattleController.instance = MahjongBattleController.New()

return MahjongBattleController
