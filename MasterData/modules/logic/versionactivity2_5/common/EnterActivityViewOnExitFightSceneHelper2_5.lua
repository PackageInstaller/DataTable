-- chunkname: @modules/logic/versionactivity2_5/common/EnterActivityViewOnExitFightSceneHelper2_5.lua

module("modules.logic.versionactivity2_5.common.EnterActivityViewOnExitFightSceneHelper2_5", package.seeall)

local EnterActivityViewOnExitFightSceneHelper = EnterActivityViewOnExitFightSceneHelper

local function _openPermanent_EnterView(viewParam)
	PermanentController.instance:jump2Activity(VersionActivity2_5Enum.ActivityId.EnterView, viewParam)
end

function EnterActivityViewOnExitFightSceneHelper.activate()
	return
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity12516(forceStarting, exitFightGroup)
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local stage, layer = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(episodeId)

	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V1a4_BossRushMainView)
		VersionActivity2_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			BossRushController.instance:openMainView({
				isOpenLevelDetail = true,
				stage = stage,
				layer = layer
			})
		end, nil, BossRushConfig.instance:getActivityId())
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity12502(forceStarting, exitFightGroup)
	EnterActivityViewOnExitFightSceneHelper.enterVersionActivityDungeonCommon(EnterActivityViewOnExitFightSceneHelper._enterActivity12502, forceStarting, exitFightGroup)
end

function EnterActivityViewOnExitFightSceneHelper._enterActivity12502(cls, param)
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

	if DungeonModel.instance.curSendEpisodePass then
		needLoadMapLevel = false

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_5DungeonMapView)
	else
		needLoadMapLevel = true

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_5DungeonMapLevelView)
	end

	local sequence = FlowSequence.New()

	PermanentController.instance:jump2Activity(VersionActivity2_5Enum.ActivityId.EnterView)
	sequence:registerDoneListener(function()
		if needLoadMapLevel then
			VersionActivity2_5DungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId, function()
				ViewMgr.instance:openView(ViewName.VersionActivity2_5DungeonMapLevelView, {
					episodeId = episodeId
				})
			end, nil)
		else
			VersionActivity2_5DungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId)
		end
	end)
	sequence:start()

	EnterActivityViewOnExitFightSceneHelper.sequence = sequence
end

function EnterActivityViewOnExitFightSceneHelper.open3_4ReactivityEnterView()
	local enterController = VersionActivityFixedHelper.getVersionActivityEnterController()

	enterController:directOpenVersionActivityEnterView(VersionActivity3_4Enum.ActivityId.Reactivity)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity12505(forceStarting, exitFightGroup)
	local episodeId = DungeonModel.instance.curSendEpisodeId

	DungeonModel.instance.lastSendEpisodeId = episodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.Act183MainView)
		VersionActivity2_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity2_5Enum.ActivityId.Challenge)
		Act183Controller.instance:openAct183MainView(nil, function()
			local episodeCo = Act183Config.instance:getEpisodeCo(episodeId)
			local groupMo = Act183Model.instance:getGroupEpisodeMo(episodeCo.groupId)
			local groupType = groupMo and groupMo:getGroupType()
			local groupId = groupMo and groupMo:getGroupId()
			local viewParam = Act183Helper.generateDungeonViewParams(groupType, groupId)

			Act183Controller.instance:openAct183DungeonView(viewParam)
		end)
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity12512(forceStarting, exitFightGroup)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		local actId = VersionActivity2_5Enum.ActivityId.LiangYue

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, RoleActivityEnum.LevelView[actId])
		_openPermanent_EnterView()
		LiangYueController.instance:enterLevelView(actId)
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity12513(forceStarting, exitFightGroup)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		local actId = VersionActivity2_5Enum.ActivityId.FeiLinShiDuo

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, RoleActivityEnum.LevelView[actId])
		_openPermanent_EnterView()
		FeiLinShiDuoGameController.instance:enterEpisodeLevelView(actId)
	end)
end

return EnterActivityViewOnExitFightSceneHelper
