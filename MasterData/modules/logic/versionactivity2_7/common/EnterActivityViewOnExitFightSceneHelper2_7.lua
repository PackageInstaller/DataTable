-- chunkname: @modules/logic/versionactivity2_7/common/EnterActivityViewOnExitFightSceneHelper2_7.lua

module("modules.logic.versionactivity2_7.common.EnterActivityViewOnExitFightSceneHelper2_7", package.seeall)

local EnterActivityViewOnExitFightSceneHelper = EnterActivityViewOnExitFightSceneHelper

local function _openPermanent_EnterView(viewParam)
	PermanentController.instance:jump2Activity(VersionActivity2_7Enum.ActivityId.EnterView, viewParam)
end

function EnterActivityViewOnExitFightSceneHelper.activate()
	return
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity12701(forceStarting, exitFightGroup)
	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_7EnterView)
		VersionActivityFixedEnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			Activity191Controller.instance:openMainView({
				exitFromFight = true
			})
		end, nil, VersionActivity2_7Enum.ActivityId.Act191, true)
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity12703(forceStarting, exitFightGroup)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		local actId = VersionActivity2_7Enum.ActivityId.CooperGarland

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, RoleActivityEnum.LevelView[actId])
		_openPermanent_EnterView()
		CooperGarlandController.instance:openLevelView()
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity12702(forceStarting, exitFightGroup)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId

	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		local actId = VersionActivity2_7Enum.ActivityId.LengZhou6

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, RoleActivityEnum.LevelView[actId])
		_openPermanent_EnterView()
		LengZhou6Controller.instance:enterLevelView(actId)
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity12706(forceStarting, exitFightGroup)
	EnterActivityViewOnExitFightSceneHelper.enterVersionActivityDungeonCommon(EnterActivityViewOnExitFightSceneHelper._enterActivity12706, forceStarting, exitFightGroup)
end

function EnterActivityViewOnExitFightSceneHelper._enterActivity12706(cls, param)
	local episodeId = param.episodeId
	local episodeCo = param.episodeCo

	if not episodeCo then
		return
	end

	if EnterActivityViewOnExitFightSceneHelper.sequence then
		EnterActivityViewOnExitFightSceneHelper.sequence:destroy()

		EnterActivityViewOnExitFightSceneHelper.sequence = nil
	end

	local big, small = 2, 7
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

	PermanentController.instance:jump2Activity(VersionActivity2_7Enum.ActivityId.EnterView)
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

function EnterActivityViewOnExitFightSceneHelper.open3_5ReactivityEnterView()
	local enterController = VersionActivityFixedHelper.getVersionActivityEnterController()

	enterController:directOpenVersionActivityEnterView(VersionActivity3_5Enum.ActivityId.Reactivity)
end

return EnterActivityViewOnExitFightSceneHelper
