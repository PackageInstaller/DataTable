-- chunkname: @modules/logic/versionactivity1_5/common/EnterActivityViewOnExitFightSceneHelper1_5.lua

module("modules.logic.versionactivity1_5.common.EnterActivityViewOnExitFightSceneHelper1_5", package.seeall)

local EnterActivityViewOnExitFightSceneHelper = EnterActivityViewOnExitFightSceneHelper

function EnterActivityViewOnExitFightSceneHelper.enterActivity11502(forceStarting, exitFightGroup)
	EnterActivityViewOnExitFightSceneHelper.enterVersionActivityDungeonCommon(EnterActivityViewOnExitFightSceneHelper._enterActivity11502, forceStarting, exitFightGroup)
end

function EnterActivityViewOnExitFightSceneHelper._enterActivity11502(cls, param)
	local episodeId = param.episodeId
	local episodeCo = param.episodeCo

	if EnterActivityViewOnExitFightSceneHelper.sequence then
		EnterActivityViewOnExitFightSceneHelper.sequence:destroy()

		EnterActivityViewOnExitFightSceneHelper.sequence = nil
	end

	local needLoadMapLevel = false

	if episodeCo.chapterId == VersionActivity1_5DungeonEnum.DungeonChapterId.ElementFight then
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_5DungeonMapView)

		DungeonMapModel.instance.lastElementBattleId = episodeId
		episodeId = VersionActivity1_5DungeonController.instance:getLastEpisodeId()

		if episodeId then
			VersionActivity1_5DungeonController.instance:setLastEpisodeId(nil)
		else
			episodeId = DungeonConfig.instance:getActivityElementFightEpisodeToNormalEpisodeId(episodeCo, VersionActivity1_5DungeonEnum.DungeonChapterId.Story)
		end
	elseif DungeonModel.instance.curSendEpisodePass then
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_5DungeonMapView)
	else
		needLoadMapLevel = true

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_5DungeonMapLevelView)
	end

	PermanentController.instance:jump2Activity(VersionActivity1_5Enum.ActivityId.EnterView)

	local sequence = FlowSequence.New()

	sequence:registerDoneListener(function()
		if needLoadMapLevel then
			VersionActivity1_5DungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId, function()
				ViewMgr.instance:openView(ViewName.VersionActivity1_5DungeonMapLevelView, {
					episodeId = episodeId
				})
			end, nil)
		else
			VersionActivity1_5DungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId)
		end
	end)
	sequence:start()

	EnterActivityViewOnExitFightSceneHelper.sequence = sequence
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity11500(forceStarting, exitFightGroup)
	EnterActivityViewOnExitFightSceneHelper.enterVersionActivityDungeonCommon(EnterActivityViewOnExitFightSceneHelper._enterActivityDungeonAterFight11500, forceStarting, exitFightGroup)
end

function EnterActivityViewOnExitFightSceneHelper.checkFightAfterStory11500(callback, target, param)
	if EnterActivityViewOnExitFightSceneHelper.recordMO then
		if EnterActivityViewOnExitFightSceneHelper.recordMO ~= 1 then
			return
		end

		local episodeId = DungeonModel.instance.curSendEpisodeId

		if not episodeId then
			return
		end

		local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

		if not episodeCo or episodeCo.type ~= DungeonEnum.EpisodeType.Season then
			return
		end

		local layer = Activity104Model.instance:getBattleFinishLayer()
		local actId = Activity104Model.instance:getCurSeasonId()

		if Activity104Model.instance:isEpisodeAfterStory(actId, layer) then
			return
		end

		local layerCo = SeasonConfig.instance:getSeasonEpisodeCo(actId, layer)

		if not layerCo or layerCo.afterStoryId == 0 then
			return
		end

		StoryController.instance:playStory(layerCo.afterStoryId, nil, callback, target, param)

		return true
	end
end

function EnterActivityViewOnExitFightSceneHelper._enterActivityDungeonAterFight11500(tarClass, param)
	local episodeId = param.episodeId
	local exitFightGroup = param.exitFightGroup

	if not episodeId then
		return
	end

	VersionActivity1_5EnterController.instance:directOpenVersionActivityEnterView()

	local layer = Activity104Model.instance:getBattleFinishLayer()
	local actId = Activity104Model.instance:getCurSeasonId()

	if EnterActivityViewOnExitFightSceneHelper.recordMO then
		local fightResult = EnterActivityViewOnExitFightSceneHelper.recordMO.fightResult
		local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)
		local episodeType = episodeCo and episodeCo.type
		local levelUpStage = Activity104Model.instance:canPlayStageLevelup(fightResult, episodeType, exitFightGroup, actId, layer)
		local jumpId, jumpParam
		local isFirstPassSeason = Activity104Model.instance:canMarkFightAfterStory(fightResult, episodeType, exitFightGroup, actId, layer)

		if isFirstPassSeason then
			Activity104Rpc.instance:sendMarkEpisodeAfterStoryRequest(actId, layer)
		end

		if episodeCo then
			if not fightResult or fightResult == -1 or fightResult == 0 then
				if episodeType == DungeonEnum.EpisodeType.Season then
					jumpId = Activity104Enum.JumpId.Market
					jumpParam = {
						tarLayer = layer
					}
				elseif episodeType == DungeonEnum.EpisodeType.SeasonRetail then
					jumpId = Activity104Enum.JumpId.Retail
				elseif episodeType == DungeonEnum.EpisodeType.SeasonSpecial then
					jumpId = Activity104Enum.JumpId.Discount
					jumpParam = {
						defaultSelectLayer = layer,
						directOpenLayer = layer
					}
				end
			elseif fightResult == 1 then
				if not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonUTTU) or not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonDiscount) then
					if episodeType == DungeonEnum.EpisodeType.Season then
						if not levelUpStage then
							local curLayer = layer + 1
							local next_config = SeasonConfig.instance:getSeasonEpisodeCo(actId, curLayer)

							if next_config then
								jumpId = Activity104Enum.JumpId.Market
								jumpParam = {
									tarLayer = curLayer
								}
							end
						end
					elseif episodeType == DungeonEnum.EpisodeType.SeasonRetail then
						jumpId = Activity104Enum.JumpId.Retail
					elseif episodeType == DungeonEnum.EpisodeType.SeasonSpecial then
						jumpId = Activity104Enum.JumpId.Discount
						jumpParam = {
							defaultSelectLayer = layer
						}
					end
				end

				if isFirstPassSeason and layer == 2 then
					jumpId = nil
					jumpParam = nil
				end
			elseif episodeType == DungeonEnum.EpisodeType.SeasonSpecial then
				jumpId = Activity104Enum.JumpId.Discount
			end
		else
			logError(string.format("找不到对应关卡表,id:%s", episodeId))
		end

		local openViewName
		local waitViewName = SeasonViewHelper.getViewName(actId, jumpId == Activity104Enum.JumpId.Market and Activity104Enum.ViewName.MarketView or jumpId == Activity104Enum.JumpId.Retail and Activity104Enum.ViewName.RetailView or jumpId == Activity104Enum.JumpId.Discount and Activity104Enum.ViewName.SpecialMarketView or Activity104Enum.ViewName.MainView, true)

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, waitViewName)
		Activity104Controller.instance:openSeasonMainView({
			levelUpStage = levelUpStage,
			jumpId = jumpId,
			jumpParam = jumpParam
		})
	end
end

function EnterActivityViewOnExitFightSceneHelper.enterFightAgain11500()
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)
	local actId = Activity104Model.instance:getCurSeasonId()
	local layer = Activity104Model.instance:getBattleFinishLayer()

	if episodeCo.type == DungeonEnum.EpisodeType.SeasonRetail then
		layer = 0

		return false
	end

	local isReplay = FightController.instance:isReplayMode(episodeId)

	if isReplay and not layer then
		if episodeCo.type == DungeonEnum.EpisodeType.Season then
			local co = SeasonConfig.instance:getSeasonEpisodeCos(actId)

			for _, v in pairs(co) do
				if v.episodeId == episodeId then
					layer = v.layer

					break
				end
			end
		elseif episodeCo.type == DungeonEnum.EpisodeType.SeasonRetail then
			layer = 0
		elseif episodeCo.type == DungeonEnum.EpisodeType.SeasonSpecial then
			local co = SeasonConfig.instance:getSeasonSpecialCos(actId)

			for _, v in pairs(co) do
				if v.episodeId == episodeId then
					layer = v.layer

					break
				end
			end
		end

		Activity104Model.instance:setBattleFinishLayer(layer)
	end

	GameSceneMgr.instance:closeScene(nil, nil, nil, true)
	Activity104Model.instance:enterAct104Battle(episodeId, layer)

	return true
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity11516(forceStarting, exitFightGroup)
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local stage, layer = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(episodeId)

	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V1a4_BossRushMainView)
		BossRushController.instance:openVersionActivityEnterViewIfNotOpened()
		BossRushController.instance:openMainView({
			isOpenLevelDetail = true,
			stage = stage,
			layer = layer
		})
	end)
end

function EnterActivityViewOnExitFightSceneHelper.activate()
	return
end

return EnterActivityViewOnExitFightSceneHelper
