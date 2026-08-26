-- chunkname: @modules/logic/versionactivity3_5/common/EnterActivityViewOnExitFightSceneHelper3_5.lua

module("modules.logic.versionactivity3_5.common.EnterActivityViewOnExitFightSceneHelper3_5", package.seeall)

local EnterActivityViewOnExitFightSceneHelper = EnterActivityViewOnExitFightSceneHelper

function EnterActivityViewOnExitFightSceneHelper.activate()
	return
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity13519(forceStarting, exitFightGroup)
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

function EnterActivityViewOnExitFightSceneHelper.enterActivity13502(forceStarting, exitFightGroup)
	EnterActivityViewOnExitFightSceneHelper.enterVersionActivityDungeonCommon(EnterActivityViewOnExitFightSceneHelper._enterActivity13502, forceStarting, exitFightGroup)
end

function EnterActivityViewOnExitFightSceneHelper._enterActivity13502(cls, param)
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

function EnterActivityViewOnExitFightSceneHelper.enterActivity13505(forceStarting, exitFightGroup)
	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity3_5Enum.ActivityId.Lamona, true)
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity13510(forceStarting, exitFightGroup)
	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity3_5Enum.ActivityId.Lorentz, true)
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity13513(forceStarting, exitFightGroup)
	EnterActivityViewOnExitFightSceneHelper.enterVersionActivityDungeonCommon(EnterActivityViewOnExitFightSceneHelper._enterActivityDungeonAterFightSeason123, forceStarting, exitFightGroup)
end

function EnterActivityViewOnExitFightSceneHelper.checkFightAfterStory13513(callback, target, param)
	EnterActivityViewOnExitFightSceneHelper.checkFightAfterStorySeason123(callback, target, param)
end

function EnterActivityViewOnExitFightSceneHelper.enterFightAgain13513()
	EnterActivityViewOnExitFightSceneHelper.enterFightAgainSeason123()
end

local function checkSeason123BattleDatas()
	local episodeId = DungeonModel.instance.curSendEpisodeId

	if not episodeId then
		return
	end

	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeCo then
		return false
	end

	local context = Season123Model.instance:getBattleContext()

	if not context then
		logNormal("Season123 checkSeason123BattleDatas no context found!")

		return false
	end

	return true, episodeId, episodeCo, context
end

function EnterActivityViewOnExitFightSceneHelper._enterActivityDungeonAterFightSeason123(tarClass, param)
	local episodeId = param.episodeId

	if not episodeId then
		return
	end

	local context = Season123Model.instance:getBattleContext()

	if not context then
		logNormal("Season123 checkSeason123BattleDatas no context found!")

		return false
	end

	local layer = context.layer
	local stage = context.stage
	local actId = context.actId

	if EnterActivityViewOnExitFightSceneHelper.recordMO then
		local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)
		local episodeType = episodeCo and episodeCo.type
		local jumpId, jumpParam

		if episodeCo then
			if not EnterActivityViewOnExitFightSceneHelper.recordMO or EnterActivityViewOnExitFightSceneHelper.recordMO == -1 or EnterActivityViewOnExitFightSceneHelper.recordMO == 0 then
				if episodeType == DungeonEnum.EpisodeType.Season123 then
					jumpId = Activity123Enum.JumpId.MarketNoResult
					jumpParam = {
						tarLayer = layer
					}
				elseif episodeType == DungeonEnum.EpisodeType.Season123Retail then
					jumpId = Activity123Enum.JumpId.Retail
				end
			elseif EnterActivityViewOnExitFightSceneHelper.recordMO == 1 and (not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonUTTU) or not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonDiscount)) then
				if episodeType == DungeonEnum.EpisodeType.Season123 then
					local curLayer = layer + 1
					local next_config = Season123Config.instance:getSeasonEpisodeCo(actId, stage, curLayer)

					if next_config then
						jumpId = Activity123Enum.JumpId.Market
						jumpParam = {
							tarLayer = curLayer
						}
					else
						jumpId = Activity123Enum.JumpId.MarketStageFinish
						jumpParam = {
							stage = stage
						}
					end
				elseif episodeType == DungeonEnum.EpisodeType.Season123Retail then
					jumpId = Activity123Enum.JumpId.Retail
					jumpParam = {
						needRandom = true
					}
				end
			end
		else
			logError(string.format("找不到对应关卡表,id:%s", episodeId))
		end

		VersionActivityFixedEnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			Season123Controller.instance:openSeasonEntry({
				actId = actId,
				jumpId = jumpId,
				jumpParam = jumpParam
			})
		end, nil, actId)
	end
end

function EnterActivityViewOnExitFightSceneHelper.checkFightAfterStorySeason123(callback, target, param)
	if EnterActivityViewOnExitFightSceneHelper.recordMO then
		if EnterActivityViewOnExitFightSceneHelper.recordMO ~= 1 then
			return
		end

		local rs, episodeId, episodeCo, context = checkSeason123BattleDatas()

		if not rs or episodeCo.type ~= DungeonEnum.EpisodeType.Season123 then
			return
		end

		local layer = context.layer
		local actId = context.actId
		local stage = context.stage

		if Season123Model.instance:isEpisodeAfterStory(actId, stage, layer) then
			return
		end

		local layerCo = Season123Config.instance:getSeasonEpisodeCo(actId, stage, layer)

		if not layerCo or layerCo.afterStoryId == nil or layerCo.afterStoryId == 0 then
			return
		end

		StoryController.instance:playStory(layerCo.afterStoryId, nil, callback, target, param)

		return true
	end
end

function EnterActivityViewOnExitFightSceneHelper.enterFightAgainSeason123()
	local rs, episodeId, episodeCo, context = checkSeason123BattleDatas()

	if not rs or episodeCo.type == DungeonEnum.EpisodeType.Season123Retail then
		return false
	end

	local layer = context.layer
	local stage = context.stage
	local actId = context.actId
	local isReplay = FightController.instance:isReplayMode(episodeId)

	if isReplay and not layer then
		if episodeCo.type == DungeonEnum.EpisodeType.Season123 then
			local coList = Season123Config.instance:getSeasonEpisodeStageCos(actId, stage)

			if not coList then
				return false
			end

			for _, v in pairs(coList) do
				if v.episodeId == episodeId then
					layer = v.layer

					break
				end
			end
		elseif episodeCo.type == DungeonEnum.EpisodeType.Season123Retail then
			layer = 0
		end
	end

	GameSceneMgr.instance:closeScene(nil, nil, nil, true)
	Season123EpisodeDetailController.instance:startBattle(actId, stage, layer, episodeId)

	return true
end

return EnterActivityViewOnExitFightSceneHelper
