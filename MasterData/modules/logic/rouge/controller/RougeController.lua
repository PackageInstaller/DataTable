-- chunkname: @modules/logic/rouge/controller/RougeController.lua

module("modules.logic.rouge.controller.RougeController", package.seeall)

local RougeController = class("RougeController", BaseController)

function RougeController:onInit()
	return
end

function RougeController:reInit()
	return
end

function RougeController:addConstEvents()
	StoryController.instance:registerCallback(StoryEvent.Start, self._onStoryStart, self)
end

function RougeController:_onStoryStart(storyId)
	if RougeFavoriteConfig.instance:inRougeStoryList(storyId) and not RougeOutsideModel.instance:storyIsPass(storyId) then
		RougeOutsideRpc.instance:sendRougeUnlockStoryRequest(RougeOutsideModel.instance:season(), storyId)
	end
end

function RougeController:enterRouge()
	DungeonModel.instance.curSendEpisodeId = nil

	GameSceneMgr.instance:startScene(SceneType.Rouge, 1, 1, true)
end

function RougeController:openRougeMainView(callback, callbackTarget)
	if not RougeOutsideModel.instance:isUnlock() then
		GameFacade.showToast(RougeOutsideModel.instance:openUnlockId())

		return
	end

	local season = RougeOutsideModel.instance:season()

	RougeOutsideRpc.instance:sendGetRougeOutSideInfoRequest(season, function(_, resultCode)
		if resultCode ~= 0 then
			logError("RougeController:openRougeMainView resultCode=" .. tostring(resultCode))

			return
		end

		RougeOutsideRpc.instance:sendRougeGetNewReddotInfoRequest(season)
		RougeRpc.instance:sendGetRougeInfoRequest(season, function(_, resultCode2)
			if resultCode2 ~= 0 then
				logError("RougeController:openRougeMainView resultCode=" .. tostring(resultCode2))

				return
			end

			ViewMgr.instance:openView(ViewName.RougeMainView)

			if callback then
				callback(callbackTarget)
			end
		end)
	end)
end

function RougeController:enterDungeonView()
	DungeonModel.instance:changeCategory(DungeonEnum.ChapterType.Rouge)
	DungeonController.instance:enterDungeonView()
end

function RougeController:openRougeDifficultyView(viewParam, isImmediate)
	ViewMgr.instance:openView(ViewName.RougeDifficultyView, viewParam, isImmediate)
end

function RougeController:openRougeSelectRewardsView(viewParam, isImmediate)
	ViewMgr.instance:openView(ViewName.RougeCollectionGiftView, viewParam, isImmediate)
end

function RougeController:openRougeFactionView(viewParam, isImmediate)
	ViewMgr.instance:openView(ViewName.RougeFactionView, viewParam, isImmediate)
end

function RougeController:createTeamViewParam(heroNum, callback, callbackTarget)
	return {
		heroNum = heroNum,
		callback = callback,
		callbackTarget = callbackTarget
	}
end

function RougeController:openRougeTeamView(param, isImmediate)
	param = param or {}
	param.teamType = RougeEnum.TeamType.View

	ViewMgr.instance:openView(ViewName.RougeTeamView, param, isImmediate)
end

function RougeController:openRougeTeamTreatView(param, isImmediate)
	param = param or {}
	param.teamType = RougeEnum.TeamType.Treat

	ViewMgr.instance:openView(ViewName.RougeTeamView, param, isImmediate)
end

function RougeController:openRougeTeamReviveView(param, isImmediate)
	param = param or {}
	param.teamType = RougeEnum.TeamType.Revive

	ViewMgr.instance:openView(ViewName.RougeTeamView, param, isImmediate)
end

function RougeController:openRougeTeamAssignmentView(param, isImmediate)
	param = param or {}
	param.teamType = RougeEnum.TeamType.Assignment

	ViewMgr.instance:openView(ViewName.RougeTeamView, param, isImmediate)
end

function RougeController:openRougeReviewView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.RougeReviewView, param, isImmediate)
end

function RougeController:openRougeIllustrationListView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.RougeIllustrationListView, param, isImmediate)
end

function RougeController:openRougeIllustrationDetailView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.RougeIllustrationDetailView, param, isImmediate)
end

function RougeController:openRougeFactionIllustrationView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.RougeFactionIllustrationView, param, isImmediate)
end

function RougeController:openRougeFactionIllustrationDetailView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.RougeFactionIllustrationDetailView, param, isImmediate)
end

function RougeController:openRougeFavoriteView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.RougeFavoriteView, param, isImmediate)
end

function RougeController:openRougeFavoriteCollectionView(param, isImmediate)
	local season = RougeOutsideModel.instance:season()

	RougeOutsideRpc.instance:sendRougeGetUnlockCollectionsRequest(season, function(cmd, resultCode)
		ViewMgr.instance:openView(ViewName.RougeFavoriteCollectionView, param, isImmediate)
	end)
end

function RougeController:openRougeTalentView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.RougeTalentView, param, isImmediate)
end

function RougeController:openRougeResultReportView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.RougeResultReportView, param, isImmediate)
end

function RougeController:openRougeTalentTreeTrunkView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.RougeTalentTreeTrunkView, param, isImmediate)
end

function RougeController:openRougeRewardView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.RougeRewardView, param, isImmediate)
end

function RougeController:openRougeInitTeamView(param, isImmediate)
	RougeHeroGroupModel.instance:clear()
	RougeHeroGroupModel.instance:onGetHeroGroupList(RougeModel.instance:getTeamInfo():getGroupInfos())

	local groupMO = RougeHeroGroupMO.New()
	local curGroupId = 1

	groupMO:setMaxHeroCount(RougeEnum.InitTeamHeroNum)
	groupMO:init({
		groupId = curGroupId
	})
	RougeHeroSingleGroupModel.instance:setMaxHeroCount(RougeEnum.InitTeamHeroNum)
	RougeHeroSingleGroupModel.instance:setSingleGroup(groupMO)
	ViewMgr.instance:openView(ViewName.RougeInitTeamView, param, isImmediate)
end

function RougeController:openSelectHero(callback, callbackTarget)
	RougeHeroGroupModel.instance:clear()

	local groupMO = RougeHeroGroupMO.New()
	local curGroupId = 1

	groupMO:setMaxHeroCount(RougeEnum.InitTeamHeroNum)
	groupMO:init({
		groupId = curGroupId
	})
	RougeHeroSingleGroupModel.instance:setMaxHeroCount(RougeEnum.InitTeamHeroNum)
	RougeHeroSingleGroupModel.instance:setSingleGroup(groupMO)

	local selectHeroCapacity = RougeConfig1.instance:getConstValueByID(RougeEnum.Const.SelectHeroCapacity)
	local totalCapacity = tonumber(selectHeroCapacity)
	local id = 1
	local param = {}

	param.singleGroupMOId = id
	param.originalHeroUid = RougeHeroSingleGroupModel.instance:getHeroUid(id)
	param.equips = {
		"0"
	}
	param.heroGroupEditType = RougeEnum.HeroGroupEditType.SelectHero
	param.selectHeroCapacity = 0
	param.curCapacity = 0
	param.totalCapacity = totalCapacity
	param.selectHeroCallback = callback
	param.selectHeroCallbackTarget = callbackTarget

	ViewMgr.instance:openView(ViewName.RougeHeroGroupEditView, param)
end

function RougeController:openRougeCollectionTipView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.RougeCollectionTipView, param, isImmediate)
end

function RougeController:openRougeCollectionEnchantView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.RougeCollectionEnchantView, param, isImmediate)
end

function RougeController:openRougeCollectionOverView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.RougeCollectionOverView, param, isImmediate)
end

function RougeController:openRougeCollectionChessView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.RougeCollectionChessView, param, isImmediate)
end

function RougeController:openRougeCollectionFilterView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.RougeCollectionFilterView, param, isImmediate)
end

function RougeController:openRougeCollectionHandBookView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.RougeCollectionHandBookView, param, isImmediate)
end

function RougeController:openRougeCollectionInitialView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.RougeCollectionInitialView, param, isImmediate)
end

function RougeController:openRougeResultView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.RougeResultView, param, isImmediate)
end

function RougeController:openRougeSettlementView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.RougeSettlementView, param, isImmediate)
end

function RougeController:openRougeResultReView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.RougeResultReView, param, isImmediate)
end

function RougeController:openRougeDLCSelectView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.RougeDLCSelectView, param, isImmediate)
end

function RougeController:getStyleConfig()
	local info = RougeModel.instance:getRougeInfo()

	return info and lua_rouge_style.configDict[info.season][info.style]
end

function RougeController:useHalfCapacity()
	local config = self:getStyleConfig()

	return config and config.halfCost == 1
end

function RougeController:getRoleStyleCapacity(heroMo, isAssit)
	if not heroMo then
		return 0
	end

	if self:useHalfCapacity() and isAssit then
		return RougeConfig1.instance:getRoleHalfCapacity(heroMo.config.rare)
	else
		return RougeConfig1.instance:getRoleCapacity(heroMo.config.rare)
	end
end

function RougeController:setPickAssistViewParams(curCapacity, totalCapacity)
	self.pickAssistViewParams = {
		curCapacity = curCapacity,
		totalCapacity = totalCapacity
	}
end

function RougeController:startEndFlow()
	if RougeModel.instance:isFinish() then
		self:clearFlow()

		self.flow = FlowSequence.New()

		local endId = RougeModel.instance:getEndId()
		local hadEnd = endId and endId ~= 0

		if hadEnd then
			self:addEndStoryFlow(endId)
		end

		self.flow:addWork(WaitFinishViewDoneWork.New(hadEnd))
		self.flow:addWork(WaitEndingThreeViewDoneWork.New(endId))
		self.flow:addWork(OpenViewAndWaitCloseWork.New(ViewName.RougeResultView))
		self.flow:addWork(OpenViewAndWaitCloseWork.New(ViewName.RougeSettlementView))
		self.flow:addWork(WaitOpenRougeReviewWork.New())
		self.flow:addWork(WaitLimiterResultViewDoneWork.New())
		self.flow:registerDoneListener(self.onEndFlowDone, self)
		self.flow:start()
	end
end

function RougeController:addEndStoryFlow(endId)
	local endCo = RougeConfig.instance:getEndingCO(endId)
	local storyId = endCo and endCo.endingStoryId

	if storyId then
		self.flow:addWork(WaitRougeStoryDoneWork.New(storyId))
	end
end

function RougeController:clearFlow()
	if self.flow then
		self.flow:destroy()

		self.flow = nil
	end
end

function RougeController:onEndFlowDone()
	self:clearAllData()
end

function RougeController:clearAllData()
	RougeMapHelper.clearMapData()
	RougeModel.instance:clear()
end

function RougeController:tryShowMessageBox()
	if not RougeModel.instance:inRouge() then
		return false
	end

	if not self:checkNeedContinueFight() then
		return false
	end

	local retryNum = RougeModel.instance:getRougeRetryNum()

	if retryNum == 0 then
		return false
	end

	local maxNum = RougeMapConfig.instance:getFightRetryNum()

	MessageBoxController.instance:showMsgBoxAndSetBtn(MessageBoxIdDefine.RougeFightFailConfirm, MsgBoxEnum.BoxType.Yes_No, luaLang("cachot_continue_fight"), "RE CHALLENGE", luaLang("cachot_abort_fight"), "QUIT", self.continueFight, self.abortRouge, nil, self, self, nil, maxNum - retryNum + 1)

	return true
end

function RougeController:checkNeedContinueFight()
	if (SLFramework.FrameworkSettings.IsEditor or isDebugBuild) and RougeEditorController.instance:isAllowAbortFight() then
		GMRpc.instance:sendGMRequest("rougeSetRetryNum 1 0")

		return false
	end

	if RougeMapModel.instance:isNormalLayer() then
		local curNode = RougeMapModel.instance:getCurNode()

		if not curNode then
			return false
		end

		local eventMo = curNode.eventMo

		if not eventMo or not eventMo.fightFail then
			return false
		end
	elseif RougeMapModel.instance:isMiddle() then
		local curPieceMo = RougeMapModel.instance:getCurPieceMo()

		if not curPieceMo then
			return false
		end

		local triggerStr = curPieceMo.triggerStr

		if not triggerStr then
			return false
		end

		if not triggerStr.fightFail then
			return false
		end
	else
		return false
	end

	return true
end

function RougeController:abortRouge()
	RougeRpc.instance:sendRougeAbortRequest(RougeModel.instance:getSeason(), self.startEndFlow, self)
end

function RougeController:continueFight()
	local chapterId = RougeMapEnum.ChapterId
	local episodeId

	if RougeMapModel.instance:isNormalLayer() then
		local nodeMo = RougeMapModel.instance:getCurNode()
		local eventCo = nodeMo:getEventCo()
		local fightEventCo = RougeMapConfig.instance:getFightEvent(eventCo.id)

		episodeId = fightEventCo.episodeId
	else
		local curPieceMo = RougeMapModel.instance:getCurPieceMo()
		local selectId = curPieceMo.selectId
		local co = lua_rouge_piece_select.configDict[selectId]
		local paramArray = string.splitToNumber(co.triggerParam, "#")

		episodeId = paramArray[1]

		RougeMapModel.instance:setEndId(paramArray[2])
	end

	DungeonFightController.instance:enterFight(chapterId, episodeId)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)
end

function RougeController:onOpenViewFinish(viewName)
	if viewName ~= ViewName.RougeHeroGroupFightView then
		return
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)

	local fightParam = FightModel.instance:getFightParam()

	fightParam.isReplay = false
	fightParam.multiplication = 1

	local result = RougeHeroGroupController.instance:setFightHeroSingleGroup()

	if result then
		DungeonFightController.instance:sendStartDungeonRequest(fightParam.chapterId, fightParam.episodeId, fightParam, 1)
	end
end

function RougeController:getStartViewAllInfo()
	local difficulty = RougeModel.instance:getDifficulty()

	return RougeOutsideModel.instance:getStartViewAllInfo(difficulty)
end

function RougeController:openActivityTaskView(actId)
	Activity186Rpc.instance:sendGetAct186InfoRequest(actId, function()
		ViewMgr.instance:openView(ViewName.RougeActivityTaskView, {
			actId = actId
		})
	end)
end

RougeController.instance = RougeController.New()

return RougeController
