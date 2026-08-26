-- chunkname: @modules/logic/versionactivity2_8/common/EnterActivityViewOnExitFightSceneHelper2_8.lua

module("modules.logic.versionactivity2_8.common.EnterActivityViewOnExitFightSceneHelper2_8", package.seeall)

local EnterActivityViewOnExitFightSceneHelper = EnterActivityViewOnExitFightSceneHelper

local function _openPermanent_EnterView(viewParam)
	PermanentController.instance:jump2Activity(VersionActivity2_8Enum.ActivityId.EnterView, viewParam)
end

function EnterActivityViewOnExitFightSceneHelper.activate()
	return
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity12810(forceStarting, exitFightGroup)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		local actId = VersionActivity2_8Enum.ActivityId.NuoDiKa

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, RoleActivityEnum.LevelView[actId])
		_openPermanent_EnterView()
		NuoDiKaController.instance:enterLevelView()
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity12811(forceStarting, exitFightGroup)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		local actId = VersionActivity2_8Enum.ActivityId.MoLiDeEr

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, RoleActivityEnum.LevelView[actId])
		_openPermanent_EnterView()
		MoLiDeErController.instance:enterLevelView(actId)
	end)
end

function EnterActivityViewOnExitFightSceneHelper._enterActivityDungeonAterFight12618(tarClass, param)
	local episodeId = param.episodeId

	if not episodeId then
		return
	end

	local context = Season166Model.instance:getBattleContext()

	if not context then
		return false
	end

	local trainId = context.trainId
	local baseId = context.baseId
	local actId = context.actId

	if EnterActivityViewOnExitFightSceneHelper.recordMO then
		local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)
		local episodeType = episodeCo and episodeCo.type
		local jumpId, jumpParam

		if episodeCo then
			if not EnterActivityViewOnExitFightSceneHelper.recordMO or EnterActivityViewOnExitFightSceneHelper.recordMO == -1 or EnterActivityViewOnExitFightSceneHelper.recordMO == 0 then
				if episodeType == DungeonEnum.EpisodeType.Season166Base then
					jumpId = Season166Enum.JumpId.BaseSpotEpisode
					jumpParam = {
						baseId = baseId
					}
				elseif episodeType == DungeonEnum.EpisodeType.Season166Train then
					jumpId = Season166Enum.JumpId.TrainEpisode
					jumpParam = {
						trainId = trainId
					}
				elseif episodeType == DungeonEnum.EpisodeType.Season166Teach then
					jumpId = Season166Enum.JumpId.TeachView
				end
			elseif EnterActivityViewOnExitFightSceneHelper.recordMO == 1 then
				if episodeType == DungeonEnum.EpisodeType.Season166Base then
					jumpId = Season166Enum.JumpId.MainView
				elseif episodeType == DungeonEnum.EpisodeType.Season166Train then
					jumpId = Season166Enum.JumpId.TrainView
				elseif episodeType == DungeonEnum.EpisodeType.Season166Teach then
					jumpId = Season166Enum.JumpId.TeachView
				end
			end
		else
			logError(string.format("找不到对应关卡表,id:%s", episodeId))
		end

		VersionActivity2_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			Season166Controller.instance:openSeasonView({
				actId = actId,
				jumpId = jumpId,
				jumpParam = jumpParam
			})
		end, nil, VersionActivity2_8Enum.ActivityId.Season)
	end
end

return EnterActivityViewOnExitFightSceneHelper
