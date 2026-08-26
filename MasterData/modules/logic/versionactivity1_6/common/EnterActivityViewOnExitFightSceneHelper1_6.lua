-- chunkname: @modules/logic/versionactivity1_6/common/EnterActivityViewOnExitFightSceneHelper1_6.lua

module("modules.logic.versionactivity1_6.common.EnterActivityViewOnExitFightSceneHelper1_6", package.seeall)

local EnterActivityViewOnExitFightSceneHelper = EnterActivityViewOnExitFightSceneHelper

function EnterActivityViewOnExitFightSceneHelper.enterActivity11610(forceStarting, exitFightGroup)
	local topEventMo = V1a6_CachotRoomModel.instance:getNowBattleEventMo()

	if not exitFightGroup and topEventMo and not topEventMo:isBattleSuccess() then
		GameSceneMgr.instance:closeScene(nil, nil, nil, true)
		V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.PlayerTriggerInteract, topEventMo)

		return
	end

	DungeonModel.instance.curSendEpisodeId = nil

	V1a6_CachotController.instance:enterMap(true)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity11605(forceStarting, exitFightGroup)
	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(forceStarting)
	GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_6EnterView)
	PermanentController.instance:jump2Activity(VersionActivity1_6Enum.ActivityId.EnterView)
	ActQuNiangController.instance:openLevelView({
		needShowFight = true
	})
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity11606(forceStarting, exitFightGroup)
	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(forceStarting)
	GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_6EnterView)
	PermanentController.instance:jump2Activity(VersionActivity1_6Enum.ActivityId.EnterView)
	ActGeTianController.instance:openLevelView({
		needShowFight = true
	})
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity11602(forceStarting, exitFightGroup)
	EnterActivityViewOnExitFightSceneHelper.enterVersionActivityDungeonCommon(EnterActivityViewOnExitFightSceneHelper._enterActivity11602, forceStarting, exitFightGroup)
end

function EnterActivityViewOnExitFightSceneHelper._enterActivity11602(cls, param)
	local episodeId = param.episodeId

	if EnterActivityViewOnExitFightSceneHelper.sequence then
		EnterActivityViewOnExitFightSceneHelper.sequence:destroy()

		EnterActivityViewOnExitFightSceneHelper.sequence = nil
	end

	local needLoadMapLevel = false

	if DungeonModel.instance.curSendEpisodePass then
		needLoadMapLevel = false

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_6DungeonMapView)
	else
		needLoadMapLevel = true

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_6DungeonMapLevelView)
	end

	local sequence = FlowSequence.New()
	local waitOpenViewName = ViewName.VersionActivity1_6EnterView
	local versionController = VersionActivity1_6EnterController

	sequence:addWork(OpenViewWork.New({
		openFunction = EnterActivityViewOnExitFightSceneHelper._openEnterView,
		openFunctionObj = versionController.instance,
		waitOpenViewName = waitOpenViewName
	}))
	sequence:registerDoneListener(function()
		if needLoadMapLevel then
			VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId, function()
				ViewMgr.instance:openView(ViewName.VersionActivity1_6DungeonMapLevelView, {
					episodeId = episodeId
				})
			end, nil)
		else
			VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId)
		end
	end)
	sequence:start()

	EnterActivityViewOnExitFightSceneHelper.sequence = sequence
end

function EnterActivityViewOnExitFightSceneHelper._openEnterView()
	PermanentController.instance:jump2Activity(VersionActivity1_6Enum.ActivityId.EnterView)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity11609(forceStarting, exitFightGroup)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_6DungeonBossView)
		PermanentController.instance:jump2Activity(VersionActivity1_6Enum.ActivityId.EnterView)
		VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView(nil, VersionActivity1_6DungeonEnum.DungeonBossEpisodeId, function()
			VersionActivity1_6DungeonController.instance:openDungeonBossView(true)
		end, nil)
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity11600(forceStarting, exitFightGroup)
	EnterActivityViewOnExitFightSceneHelper.enterVersionActivityDungeonCommon(EnterActivityViewOnExitFightSceneHelper._enterActivityDungeonAterFight11600, forceStarting, exitFightGroup)
end

function EnterActivityViewOnExitFightSceneHelper.checkFightAfterStory11600(callback, target, param)
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

function EnterActivityViewOnExitFightSceneHelper._enterActivityDungeonAterFight11600(tarClass, param)
	local episodeId = param.episodeId
	local exitFightGroup = param.exitFightGroup

	if not episodeId then
		return
	end

	local layer = Activity104Model.instance:getBattleFinishLayer()
	local actId = Activity104Model.instance:getCurSeasonId()

	VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, actId)

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

function EnterActivityViewOnExitFightSceneHelper.enterFightAgain11600()
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

function EnterActivityViewOnExitFightSceneHelper.enterActivity11604(forceStarting, exitFightGroup)
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local stage, layer = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(episodeId)

	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V1a4_BossRushMainView)
		VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			BossRushController.instance:openMainView({
				isOpenLevelDetail = true,
				stage = stage,
				layer = layer
			})
		end, nil, VersionActivity1_6Enum.ActivityId.BossRush)
	end)
end

function EnterActivityViewOnExitFightSceneHelper.activate()
	return
end

return EnterActivityViewOnExitFightSceneHelper
