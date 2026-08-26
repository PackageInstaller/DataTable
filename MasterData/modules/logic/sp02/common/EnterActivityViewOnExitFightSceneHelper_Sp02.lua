-- chunkname: @modules/logic/sp02/common/EnterActivityViewOnExitFightSceneHelper_Sp02.lua

module("modules.logic.sp02.common.EnterActivityViewOnExitFightSceneHelper_Sp02", package.seeall)

local EnterActivityViewOnExitFightSceneHelper = EnterActivityViewOnExitFightSceneHelper

function EnterActivityViewOnExitFightSceneHelper.activate()
	return
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity138507(forceStarting, exitFightGroup)
	EnterActivityViewOnExitFightSceneHelper.enterVersionActivityDungeonCommon(EnterActivityViewOnExitFightSceneHelper.enterActivityDungeonAterFight138507, forceStarting, exitFightGroup)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivityDungeonAterFight138507(tarClass, param)
	if EnterActivityViewOnExitFightSceneHelper.sequence then
		EnterActivityViewOnExitFightSceneHelper.sequence:destroy()

		EnterActivityViewOnExitFightSceneHelper.sequence = nil
	end

	GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.AtomicDungeonMainView)

	local enterViewName = ViewName.VersionActivity3_10EnterView
	local sequence = FlowSequence.New()

	sequence:addWork(OpenViewWork.New({
		openFunction = VersionActivity3_10EnterController.directOpenVersionActivityEnterView,
		openFunctionObj = VersionActivity3_10EnterController.instance,
		waitOpenViewName = enterViewName
	}))
	sequence:registerDoneListener(function()
		AtomicDungeonController.instance:openDungeonView()
	end)
	sequence:start()

	EnterActivityViewOnExitFightSceneHelper.sequence = sequence
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity138502(forceStarting, exitFightGroup)
	EnterActivityViewOnExitFightSceneHelper.enterVersionActivityDungeonCommon(EnterActivityViewOnExitFightSceneHelper._enterActivity138502, forceStarting, exitFightGroup)
end

function EnterActivityViewOnExitFightSceneHelper._enterActivity138502(cls, param)
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
	local mapLevelViewName = ViewName.VersionActivity3_10DungeonMapLevelView
	local mapViewName = ViewName.VersionActivity3_10DungeonMapView
	local enterViewName = ViewName.VersionActivity3_10EnterView

	if DungeonModel.instance.curSendEpisodePass then
		needLoadMapLevel = false

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, mapViewName)
	else
		needLoadMapLevel = true

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, mapLevelViewName)
	end

	local sequence = FlowSequence.New()

	sequence:addWork(OpenViewWork.New({
		openFunction = VersionActivity3_10EnterController.directOpenVersionActivityEnterView,
		openFunctionObj = VersionActivity3_10EnterController.instance,
		waitOpenViewName = enterViewName
	}))
	sequence:registerDoneListener(function()
		if needLoadMapLevel then
			VersionActivity3_10DungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId, function()
				ViewMgr.instance:openView(mapLevelViewName, {
					episodeId = episodeId
				})
			end, nil)
		else
			VersionActivity3_10DungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId)
		end
	end)
	sequence:start()

	EnterActivityViewOnExitFightSceneHelper.sequence = sequence
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity138521(forceStarting, exitFightGroup)
	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.AbyssMainView)
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
			AbyssController.instance:openMainView(nil, true)
		end, nil, VersionActivity3_10Enum.ActivityId.Abyss, true)
	end)
end

return EnterActivityViewOnExitFightSceneHelper
