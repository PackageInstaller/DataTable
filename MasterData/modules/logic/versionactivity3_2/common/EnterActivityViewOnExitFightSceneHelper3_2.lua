-- chunkname: @modules/logic/versionactivity3_2/common/EnterActivityViewOnExitFightSceneHelper3_2.lua

module("modules.logic.versionactivity3_2.common.EnterActivityViewOnExitFightSceneHelper3_2", package.seeall)

local EnterActivityViewOnExitFightSceneHelper = EnterActivityViewOnExitFightSceneHelper

function EnterActivityViewOnExitFightSceneHelper.activate()
	return
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity13230(forceStarting, exitFightGroup)
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local stage, layer = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(episodeId)

	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V3a2_BossRush_LevelDetailView)
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
			BossRushController.instance:openV3a2MainView({
				isOpenLevelDetail = true,
				stage = stage,
				layer = layer
			})
		end, nil, BossRushConfig.instance:getActivityId())
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity13223(forceStarting, exitFightGroup)
	EnterActivityViewOnExitFightSceneHelper.enterVersionActivityDungeonCommon(EnterActivityViewOnExitFightSceneHelper._enterActivity13223, forceStarting, exitFightGroup)
end

function EnterActivityViewOnExitFightSceneHelper._enterActivity13223(cls, param)
	local episodeId = param.episodeId
	local episodeCo = param.episodeCo

	if not episodeCo then
		return
	end

	if EnterActivityViewOnExitFightSceneHelper.sequence then
		EnterActivityViewOnExitFightSceneHelper.sequence:destroy()

		EnterActivityViewOnExitFightSceneHelper.sequence = nil
	end

	local big, small = 3, 2
	local needLoadMapLevel = false
	local mapLevelViewName = VersionActivityFixedHelper.getVersionActivityDungeonMapLevelViewName(big, small)
	local mapViewName = VersionActivityFixedHelper.getVersionActivityDungeonMapViewName(big, small)
	local enterViewName = VersionActivityFixedHelper.getVersionActivityEnterViewName()

	if DungeonModel.instance.curSendEpisodePass then
		needLoadMapLevel = false

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, mapViewName)
	else
		needLoadMapLevel = true

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, mapLevelViewName)
	end

	local enterController = VersionActivityFixedHelper.getVersionActivityEnterController()
	local sequence = FlowSequence.New()

	sequence:addWork(OpenViewWork.New({
		openFunction = EnterActivityViewOnExitFightSceneHelper.open3_9ReactivityEnterView,
		openFunctionObj = enterController.instance,
		waitOpenViewName = enterViewName
	}))
	sequence:registerDoneListener(function()
		local dungeonController = VersionActivityFixedHelper.getVersionActivityDungeonController(big, small)

		if needLoadMapLevel then
			dungeonController.instance:openVersionActivityReactivityDungeonMapView(big, small, nil, episodeId, function()
				ViewMgr.instance:openView(mapLevelViewName, {
					episodeId = episodeId
				})
			end, nil)
		else
			dungeonController.instance:openVersionActivityReactivityDungeonMapView(big, small, nil, episodeId)
		end
	end)
	sequence:start()

	EnterActivityViewOnExitFightSceneHelper.sequence = sequence
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity13231(forceStarting, exitFightGroup)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId

	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity3_2EnterView)

		local actCo = ActivityConfig.instance:getActivityCo(VersionActivity3_2Enum.ActivityId.BeiLiEr)

		if DungeonModel.instance.lastSendEpisodeId == actCo.tryoutEpisode then
			VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity3_2Enum.ActivityId.BeiLiEr, true)
		else
			local function returnViewAction()
				RoleActivityController.instance:enterActivity(VersionActivity3_2Enum.ActivityId.BeiLiEr)
			end

			VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(returnViewAction, nil, VersionActivity3_2Enum.ActivityId.BeiLiEr, true)
		end
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity13229(forceStarting, exitFightGroup)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId

	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity3_2EnterView)

		local actCo = ActivityConfig.instance:getActivityCo(VersionActivity3_2Enum.ActivityId.HuiDiaoLan)

		if DungeonModel.instance.lastSendEpisodeId == actCo.tryoutEpisode then
			VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity3_2Enum.ActivityId.HuiDiaoLan, true)
		else
			local function returnViewAction()
				RoleActivityController.instance:enterActivity(VersionActivity3_2Enum.ActivityId.HuiDiaoLan)
			end

			VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(returnViewAction, nil, VersionActivity3_2Enum.ActivityId.HuiDiaoLan, true)
		end
	end)
end

function EnterActivityViewOnExitFightSceneHelper.open3_9ReactivityEnterView()
	local enterController = VersionActivityFixedHelper.getVersionActivityEnterController()

	enterController:directOpenVersionActivityEnterView(VersionActivity3_9Enum.ActivityId.Reactivity)
end

return EnterActivityViewOnExitFightSceneHelper
