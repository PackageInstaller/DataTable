-- chunkname: @modules/logic/seasonver/act123/controller/Season123Controller.lua

module("modules.logic.seasonver.act123.controller.Season123Controller", package.seeall)

local Season123Controller = class("Season123Controller", BaseController)

function Season123Controller:onInit()
	Season123ControllerCardEffectHandleFunc.activeHandleFuncController()
end

function Season123Controller:reInit()
	return
end

function Season123Controller:addConstEvents()
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, self.handleReceiveActChanged, self)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, self.onUpdateTaskList, self)
	TaskController.instance:registerCallback(TaskEvent.SetTaskList, self.onSetTaskList, self)
end

function Season123Controller:handleReceiveActChanged(actId)
	logNormal("handleReceiveActChanged : " .. tostring(actId))

	local actList = ActivityModel.instance:getOnlineActIdByType(Activity123Enum.ActType)

	if actList then
		Activity123Rpc.instance:sendGet123InfosRequest(actList[1])
	end
end

function Season123Controller:openSeasonEntry(param)
	local actId

	if param and param.actId then
		actId = param.actId
	else
		param = param or {}
		actId = Season123Model.instance:getCurSeasonId()
		param.actId = actId
	end

	if not actId then
		return
	end

	Season123Controller.instance.lastOpenActId = actId

	if not Activity123Enum.SeasonViewPrefix[actId] then
		local prefix = ""
		local viewName = string.format("Season123%s%s", prefix, "EntryView")

		self.enterVersionActivityView(self, ViewName[viewName], actId, function()
			Season123ViewHelper.openView(actId, "EntryView", param)
			Season123Model.instance:setRetailRandomSceneId(param.jumpParam)
		end, self)
	end
end

function Season123Controller.openSeasonEntryByJump(param)
	Season123Controller.instance:openSeasonEntry(param)
end

function Season123Controller:openSeasonOverview(param)
	param = param or {}

	Season123ViewHelper.openView(param.actId, "EntryOverview", param)
end

function Season123Controller:openSeasonRetail(param)
	param = param or {}

	Season123ViewHelper.openView(param.actId, "RetailView", param)
	self:dispatchEvent(Season123Event.EnterRetailView)
end

function Season123Controller:openSeasonEquipView(param)
	param = param or {}

	Season123ViewHelper.openView(param.actId, "EquipView", param)
end

function Season123Controller:onUpdateTaskList(msg)
	local isChange = Season123TaskModel.instance:updateInfo(msg.taskInfo)

	if isChange then
		Season123TaskModel.instance:refreshList()
	end

	Season123Model.instance:updateTaskReward()
	self:dispatchEvent(Season123Event.TaskUpdated)
end

function Season123Controller:onSetTaskList()
	Season123Model.instance:updateTaskReward()
	self:dispatchEvent(Season123Event.TaskUpdated)
end

function Season123Controller:openSeasonStoreView(actId)
	local storeActId = Season123Config.instance:getSeasonConstNum(actId, Activity123Enum.Const.StoreActId)

	if not Activity123Enum.SeasonViewPrefix[actId] then
		local prefix = ""
		local viewName = string.format("Season123%s%s", prefix, "StoreView")

		self.enterVersionActivityView(self, ViewName[viewName], storeActId, self._openSeasonStoreView, self)
	end
end

function Season123Controller:_openSeasonStoreView(viewName, storeActId)
	Activity107Rpc.instance:sendGet107GoodsInfoRequest(storeActId, function()
		ViewMgr.instance:openView(viewName, {
			actId = storeActId
		})
	end)
end

function Season123Controller:openSeasonTaskView(param)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Season123
	}, function()
		Season123TaskModel.instance:resetMapData()
		Season123ViewHelper.openView(param.actId, "TaskView", param)
	end)
end

function Season123Controller:openSeasonEquipBookView(actId)
	Season123EquipBookModel.instance:initDatas(actId)
	Season123ViewHelper.openView(actId, "EquipBookView")
end

function Season123Controller:openSeasonCardPackageView(param)
	Season123CardPackageModel.instance:initData(param.actId)

	if Season123CardPackageModel.instance.packageCount > 0 then
		Season123ViewHelper.openView(param.actId, "CardPackageView")
	else
		GameFacade.showToast(ToastEnum.Season123EmptyCardPackage)
	end
end

function Season123Controller:openFightTipViewName()
	local seasonId = Season123Model.instance:getCurSeasonId()

	if seasonId then
		ViewMgr.instance:openView(self:getFightRuleTipViewName())
	end
end

function Season123Controller:openResetView(param)
	param = param or {}

	Season123ViewHelper.openView(param.actId, "ResetView", param)
end

function Season123Controller:getRecordWindowViewName()
	return Season123ViewHelper.getViewName(nil, "RecordWindow")
end

function Season123Controller:openHeroGroupFightView(param)
	ViewMgr.instance:openView(self:getHeroGroupFightViewName(), param)
end

function Season123Controller:getHeroGroupFightViewName()
	return Season123ViewHelper.getViewName(nil, "HeroGroupFightView")
end

function Season123Controller:getHeroGroupEditViewName()
	return Season123ViewHelper.getViewName(nil, "HeroGroupEditView")
end

function Season123Controller:getEpisodeListViewName()
	return Season123ViewHelper.getViewName(nil, "EpisodeListView")
end

function Season123Controller:getPickHeroEntryViewName()
	return Season123ViewHelper.getViewName(nil, "PickHeroEntryView")
end

function Season123Controller:getStageLoadingViewName()
	return Season123ViewHelper.getViewName(nil, "StageLoadingView")
end

function Season123Controller:getStageFinishViewName()
	return Season123ViewHelper.getViewName(nil, "StageFinishView")
end

function Season123Controller:getEquipHeroViewName()
	return Season123ViewHelper.getViewName(nil, "EquipHeroView")
end

function Season123Controller:getPickAssistViewName()
	return Season123ViewHelper.getViewName(nil, "PickAssistView")
end

function Season123Controller:getPickHeroViewName()
	return Season123ViewHelper.getViewName(nil, "PickHeroView")
end

function Season123Controller:getShowHeroViewName()
	return Season123ViewHelper.getViewName(nil, "ShowHeroView")
end

function Season123Controller:getEpisodeLoadingViewName()
	return Season123ViewHelper.getViewName(nil, "EpisodeLoadingView")
end

function Season123Controller:getEpisodeMarketViewName()
	return Season123ViewHelper.getViewName(nil, "EpisodeDetailView")
end

function Season123Controller:getFightRuleTipViewName()
	return Season123ViewHelper.getViewName(nil, "FightRuleTipView")
end

function Season123Controller:getProgressViewName()
	return Season123ViewHelper.getViewName(nil, "ProgressView")
end

function Season123Controller:openSeasonCardDescView(equipId)
	Season123ViewHelper.openView(nil, "CardDescView", {
		equipId = equipId
	})
end

function Season123Controller:enterVersionActivityView(viewName, actId, callback, callbackObj)
	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId then
			GameFacade.showToast(toastId, toastParam)
		end

		return
	end

	if callback then
		callback(callbackObj, viewName, actId)

		return
	end

	ViewMgr.instance:openView(viewName)
end

function Season123Controller:openMainViewFromFightScene()
	local context = Season123Model.instance:getBattleContext()
	local param = {}

	param.actId = context and context.actId or Season123Model.instance:getCurSeasonId()

	self:openSeasonEntry(param)
end

function Season123Controller.isSeason123EpisodeType(episodeType)
	return episodeType == DungeonEnum.EpisodeType.Season123 or episodeType == DungeonEnum.EpisodeType.Season123Retail or episodeType == DungeonEnum.EpisodeType.Season123Trial
end

function Season123Controller.canUse123EquipEpisodeType(episodeType)
	return episodeType == DungeonEnum.EpisodeType.Season123 or episodeType == DungeonEnum.EpisodeType.Season123Trial
end

function Season123Controller.isSeason123ChapterType(chapterType)
	return chapterType == DungeonEnum.ChapterType.Season123 or chapterType == DungeonEnum.ChapterType.Season123Retail or chapterType == DungeonEnum.ChapterType.Season123Trial
end

function Season123Controller.sendEpisodeUseSeason123Equip()
	local curEpisodeId = DungeonModel.instance.curSendEpisodeId

	if not curEpisodeId or curEpisodeId == 0 then
		return false
	end

	local episodeCo = DungeonConfig.instance:getEpisodeCO(curEpisodeId)

	if Season123Controller.canUse123EquipEpisodeType(episodeCo.type) then
		return true
	end

	return false
end

function Season123Controller:openSeasonCelebrityCardTipView(param)
	param = param or {}

	Season123ViewHelper.openView(nil, "CelebrityCardTipView", param)
end

function Season123Controller:openSeasonCelebrityCardGetView(param)
	param = param or {}

	Season123ViewHelper.openView(nil, "CelebrityCardGetView", param)
end

function Season123Controller:openSeasonStoryView(param)
	param = param or {}

	Season123ViewHelper.openView(param.actId, "StoryView", param)
end

function Season123Controller:checkProcessFightReconnect()
	local fightReason = FightModel.instance:getFightReason()
	local episodeId = fightReason.episodeId
	local co = DungeonConfig.instance:getEpisodeCO(episodeId)

	if co and Season123Controller.isSeason123EpisodeType(co.type) then
		if co.type == DungeonEnum.EpisodeType.Season123 then
			local seasonEpisodeCO = Season123Config.instance:getConfigByEpisodeId(episodeId)

			if seasonEpisodeCO then
				Season123Model.instance:setBattleContext(seasonEpisodeCO.activityId, seasonEpisodeCO.stage, seasonEpisodeCO.layer, episodeId)
			end
		elseif co.type == DungeonEnum.EpisodeType.Season123Retail then
			local retailCO = Season123Config.instance:getRetailCOByEpisodeId(episodeId)

			if retailCO then
				Season123Model.instance:setBattleContext(retailCO.activityId, nil, nil, episodeId)
			end
		elseif co.type == DungeonEnum.EpisodeType.Season123Trail then
			local trailCO = Season123Config.instance:getTrailCOByEpisodeId(episodeId)

			if trailCO then
				Season123Model.instance:setBattleContext(trailCO.activityId, nil, nil, episodeId)
			end
		end

		local isReplay = fightReason.type == FightEnum.FightReason.DungeonRecord
		local multiplication = fightReason.multiplication

		multiplication = multiplication and multiplication > 0 and multiplication or 1

		FightController.instance:setFightParamByEpisodeId(episodeId, isReplay, multiplication, fightReason.battleId)
		HeroGroupModel.instance:setParam(fightReason.battleId, episodeId, false, true)
	end
end

function Season123Controller.isEpisodeFromSeason123(episodeId)
	if not episodeId then
		return false
	end

	local co = DungeonConfig.instance:getEpisodeCO(episodeId)

	if co and Season123Controller.isSeason123EpisodeType(co.type) then
		return true
	end

	return false
end

function Season123Controller:addDontNavigateBtn(dict)
	dict[Season123Controller.instance:getEpisodeLoadingViewName()] = true
	dict[Season123Controller.instance:getStageLoadingViewName()] = true
	dict[Season123Controller.instance:getStageFinishViewName()] = true
end

function Season123Controller:openSeasonFightFailView(param)
	param = param or {}

	Season123ViewHelper.openView(param.actId, "FightFailView", param)
end

function Season123Controller:openSeasonFightSuccView(param)
	param = param or {}

	Season123ViewHelper.openView(param.actId, "FightSuccView", param)
end

function Season123Controller:openSeason123SettlementView(param)
	param = param or {}

	Season123ViewHelper.openView(param.actId, "SettlementView", param)
end

function Season123Controller:openSeasonAdditionRuleTipView(param)
	param = param or {}

	Season123ViewHelper.openView(param.actId, "AdditionRuleTipView", param)
end

function Season123Controller:openSeasonStoryPagePopView(actId, stageId)
	local param = {
		actId = actId,
		stageId = stageId
	}

	Season123ViewHelper.openView(param.actId, "StoryPagePopView", param)
end

function Season123Controller.getSeasonIcon(resName, seasonId)
	local folder = Activity123Enum.SeasonIconFolder[seasonId]

	return string.format("singlebg/%s/%s", folder, resName)
end

function Season123Controller:checkHasReadUnlockStory(actId)
	local needShowRedDot = Season123Model.instance:checkHasUnlockStory(actId) and 1 or 0
	local redDotInfoList = {
		{
			uid = 0,
			id = RedDotEnum.DotNode.Season123Story,
			value = needShowRedDot
		}
	}

	RedDotRpc.instance:clientAddRedDotGroupList(redDotInfoList, true)
end

function Season123Controller:checkAndHandleEffectEquip(param)
	local layer = param.layer
	local actId = param.actId
	local stage = param.stage
	local seasonMO = Season123Model.instance:getActInfo(actId)
	local stageMO = seasonMO:getStageMO(stage)

	if not stageMO then
		return
	end

	if not layer or layer <= 0 then
		for index, episodeMO in pairs(stageMO.episodeMap) do
			param.layer = index

			self:handleEffectEquip(episodeMO, param)
		end
	else
		local episodeMO = stageMO.episodeMap[layer]

		self:handleEffectEquip(episodeMO, param)
	end
end

function Season123Controller:handleEffectEquip(episodeMO, param)
	if not episodeMO.effectMainCelebrityEquipIds then
		for _, equipId in pairs(episodeMO.effectMainCelebrityEquipIds) do
			local equipEffectMap = Season123Config.instance:getCardSpecialEffectMap(equipId) or {}

			for effectId, effectParams in pairs(equipEffectMap) do
				local func = Season123Controller.SpecialEffctHandleFunc[effectId]

				if func then
					func(self, effectParams, param)
				end
			end
		end
	end
end

function Season123Controller:isReduceRound(actId, stage, layer)
	local actId = actId
	local stage = stage
	local seasonMO = Season123Model.instance:getActInfo(actId)
	local stageMO = seasonMO:getStageMO(stage)

	if stageMO.reduceState then
		return stageMO.reduceState[layer]
	end

	return false
end

Season123Controller.instance = Season123Controller.New()

return Season123Controller
