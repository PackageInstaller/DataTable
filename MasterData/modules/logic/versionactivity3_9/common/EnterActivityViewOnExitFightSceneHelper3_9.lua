-- chunkname: @modules/logic/versionactivity3_9/common/EnterActivityViewOnExitFightSceneHelper3_9.lua

module("modules.logic.versionactivity3_9.common.EnterActivityViewOnExitFightSceneHelper3_9", package.seeall)

local EnterActivityViewOnExitFightSceneHelper = EnterActivityViewOnExitFightSceneHelper

function EnterActivityViewOnExitFightSceneHelper.activate()
	return
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity13904(forceStarting, exitFightGroup)
	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity3_9Enum.ActivityId.Hedone, true)
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity13902(forceStarting, exitFightGroup)
	EnterActivityViewOnExitFightSceneHelper.enterVersionActivityDungeonCommon(EnterActivityViewOnExitFightSceneHelper._enterActivity13902, forceStarting, exitFightGroup)
end

function EnterActivityViewOnExitFightSceneHelper._enterActivity13902(cls, param)
	local episodeId = param.episodeId
	local episodeCo = param.episodeCo

	if not episodeCo then
		return
	end

	if EnterActivityViewOnExitFightSceneHelper.sequence then
		EnterActivityViewOnExitFightSceneHelper.sequence:destroy()

		EnterActivityViewOnExitFightSceneHelper.sequence = nil
	end

	local needLoadMapLevel = false
	local mapLevelViewName = VersionActivityFixedHelper.getVersionActivityDungeonMapLevelViewName()
	local mapViewName = VersionActivityFixedHelper.getVersionActivityDungeonMapViewName()
	local enterViewName = VersionActivityFixedHelper.getVersionActivityEnterViewName()

	if DungeonModel.instance.curSendEpisodePass then
		needLoadMapLevel = false

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, mapViewName)
	else
		needLoadMapLevel = true

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, mapLevelViewName)
	end

	local sequence = FlowSequence.New()

	sequence:addWork(OpenViewWork.New({
		openFunction = VersionActivityFixedHelper.getVersionActivityEnterController().exitFightEnterView,
		openFunctionObj = VersionActivityFixedHelper.getVersionActivityEnterController().instance,
		waitOpenViewName = enterViewName
	}))
	sequence:registerDoneListener(function()
		local dungeonController = VersionActivityFixedHelper.getVersionActivityDungeonController()

		if needLoadMapLevel then
			dungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId, function()
				ViewMgr.instance:openView(mapLevelViewName, {
					episodeId = episodeId
				})
			end, nil)
		else
			dungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId)
		end
	end)
	sequence:start()

	EnterActivityViewOnExitFightSceneHelper.sequence = sequence
end

function EnterActivityViewOnExitFightSceneHelper._enterVersionActivityDungeonCommonForRacingCar(callBack, forceStarting, exitFightGroup)
	local chapterId = DungeonModel.instance.curSendChapterId
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local isReplay = false
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)
	local chapterConfig = DungeonConfig.instance:getChapterCO(chapterId)
	local actId = chapterConfig.actId
	local activityState = ActivityHelper.getActivityStatus(actId)

	if ActivityEnum.ActivityStatus.Normal ~= activityState then
		MainController.instance:enterMainScene(forceStarting)

		return
	end

	if not exitFightGroup and isReplay then
		if EnterActivityViewOnExitFightSceneHelper["enterFightAgain" .. actId] then
			if EnterActivityViewOnExitFightSceneHelper["enterFightAgain" .. actId]() then
				return
			end
		else
			EnterActivityViewOnExitFightSceneHelper.enterFightAgain()

			return
		end
	end

	DungeonModel.instance.versionActivityChapterType = nil
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)

	local param = {
		episodeId = episodeId,
		episodeCo = episodeCo,
		exitFightGroup = exitFightGroup
	}

	SceneHelper.instance:waitSceneDone(SceneType.Main, callBack, EnterActivityViewOnExitFightSceneHelper, param)
end

function EnterActivityViewOnExitFightSceneHelper.enterRacingCar(forceStarting, exitFightGroup)
	GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.V3a9RacingCarLoadingView)

	if not ActivityHelper.isOpen(VersionActivity3_9Enum.ActivityId.Dungeon) or not ActivityHelper.isOpen(VersionActivity3_9Enum.ActivityId.Racing) then
		MainController.instance:enterMainScene()

		return
	end

	DungeonModel.instance.curSendChapterId = 39101
	DungeonModel.instance.curSendEpisodeId = 3910101

	EnterActivityViewOnExitFightSceneHelper._enterVersionActivityDungeonCommonForRacingCar(EnterActivityViewOnExitFightSceneHelper._enterRacingCar, forceStarting, exitFightGroup)
end

function EnterActivityViewOnExitFightSceneHelper._enterRacingCar(cls, param)
	local episodeCo = param.episodeCo

	if not episodeCo then
		return
	end

	local enterViewName = VersionActivityFixedHelper.getVersionActivityEnterViewName()

	GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V3a9RacingCarMainView)

	local sequence = FlowSequence.New()

	sequence:addWork(OpenViewWork.New({
		openFunction = VersionActivityFixedHelper.getVersionActivityEnterController().exitFightEnterView,
		openFunctionObj = VersionActivityFixedHelper.getVersionActivityEnterController().instance,
		waitOpenViewName = enterViewName
	}))
	sequence:registerDoneListener(function()
		local dungeonController = VersionActivityFixedHelper.getVersionActivityDungeonController()

		dungeonController.instance:openVersionActivityDungeonMapView(nil, nil, function()
			V3a9RacingCarController.instance:onOpenCarMainView()
		end, nil)
	end)
	sequence:start()
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity13916(forceStarting, exitFightGroup)
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local stage, layer = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(episodeId)

	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V3a2_BossRush_LevelDetailView)
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
			V3a9_BossRushController.instance:openV3a9MainView({
				actId = 13916,
				isOpenLevelDetail = true,
				stage = stage,
				layer = layer
			})
		end, nil, BossRushConfig.instance:getActivityId())
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity13919(forceStarting, exitFightGroup)
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local stage, layer = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(episodeId)

	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V3a9_BossRush_LevelDetailView)
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
			V3a9_BossRushController.instance:openV3a9MainView({
				actId = 13919,
				isOpenLevelDetail = true,
				stage = stage,
				layer = layer
			})
		end, nil, BossRushConfig.instance:getActivityId())
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity13918(forceStarting, exitFightGroup)
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local stage, layer = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(episodeId)

	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity3_9Enum.ActivityId.Naxisuosi)
	end)
end

return EnterActivityViewOnExitFightSceneHelper
