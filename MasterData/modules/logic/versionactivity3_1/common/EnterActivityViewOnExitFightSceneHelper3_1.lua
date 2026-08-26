-- chunkname: @modules/logic/versionactivity3_1/common/EnterActivityViewOnExitFightSceneHelper3_1.lua

module("modules.logic.versionactivity3_1.common.EnterActivityViewOnExitFightSceneHelper3_1", package.seeall)

local EnterActivityViewOnExitFightSceneHelper = EnterActivityViewOnExitFightSceneHelper

local function _openPermanent_EnterView(viewParam)
	PermanentController.instance:jump2Activity(VersionActivity3_1Enum.ActivityId.EnterView, viewParam)
end

function EnterActivityViewOnExitFightSceneHelper.activate()
	return
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity13113(forceStarting, exitFightGroup)
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local stage, layer = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(episodeId)

	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V1a4_BossRushLevelDetail)
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
			BossRushController.instance:openMainView({
				isOpenLevelDetail = true,
				stage = stage,
				layer = layer
			})
		end, nil, BossRushConfig.instance:getActivityId())
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity13105(forceStarting, exitFightGroup)
	local actId = Activity191Controller.instance:getActId()

	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.Act191MainView)
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
			Activity191Controller.instance:openMainView({
				exitFromFight = true
			})
		end, nil, VersionActivity3_1Enum.ActivityId.DouQuQu3)
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity13103(forceStarting, exitFightGroup)
	EnterActivityViewOnExitFightSceneHelper.enterVersionActivityDungeonCommon(EnterActivityViewOnExitFightSceneHelper._enterActivity13103, forceStarting, exitFightGroup)
end

function EnterActivityViewOnExitFightSceneHelper._enterActivity13103(cls, param)
	local episodeId = param.episodeId
	local episodeCo = param.episodeCo

	if not episodeCo then
		return
	end

	if EnterActivityViewOnExitFightSceneHelper.sequence then
		EnterActivityViewOnExitFightSceneHelper.sequence:destroy()

		EnterActivityViewOnExitFightSceneHelper.sequence = nil
	end

	local big, small = 3, 1
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

	PermanentController.instance:jump2Activity(VersionActivity3_1Enum.ActivityId.EnterView)
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

function EnterActivityViewOnExitFightSceneHelper.open3_8ReactivityEnterView()
	local enterController = VersionActivityFixedHelper.getVersionActivityEnterController()

	enterController:directOpenVersionActivityEnterView(VersionActivity3_8Enum.ActivityId.Reactivity)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity13117(forceStarting, exitFightGroup)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId

	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		local actId = VersionActivity3_1Enum.ActivityId.YeShuMei

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, RoleActivityEnum.LevelView[actId])
		_openPermanent_EnterView()
		RoleActivityController.instance:enterActivity(actId)
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity13118(forceStarting, exitFightGroup)
	local actId = 13118

	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId

	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, RoleActivityEnum.LevelView[actId])
		_openPermanent_EnterView()
		RoleActivityController.instance:enterActivity(actId)
	end)
end

return EnterActivityViewOnExitFightSceneHelper
