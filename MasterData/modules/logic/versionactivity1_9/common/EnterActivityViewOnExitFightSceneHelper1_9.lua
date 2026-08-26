-- chunkname: @modules/logic/versionactivity1_9/common/EnterActivityViewOnExitFightSceneHelper1_9.lua

module("modules.logic.versionactivity1_9.common.EnterActivityViewOnExitFightSceneHelper1_9", package.seeall)

local EnterActivityViewOnExitFightSceneHelper = EnterActivityViewOnExitFightSceneHelper

function EnterActivityViewOnExitFightSceneHelper.activate()
	return
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity11906(forceStarting, exitFightGroup)
	EnterActivityViewOnExitFightSceneHelper.enterVersionActivityDungeonCommon(EnterActivityViewOnExitFightSceneHelper._enterActivityDungeonAterFight11906, forceStarting, exitFightGroup)
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

function EnterActivityViewOnExitFightSceneHelper._enterActivityDungeonAterFight11906(tarClass, param)
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

		VersionActivity1_9EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			Season123Controller.instance:openSeasonEntry({
				actId = actId,
				jumpId = jumpId,
				jumpParam = jumpParam
			})
		end, nil, VersionActivity1_9Enum.ActivityId.Season)
	end
end

function EnterActivityViewOnExitFightSceneHelper.checkFightAfterStory11906(callback, target, param)
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

function EnterActivityViewOnExitFightSceneHelper.enterFightAgain11906()
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

function EnterActivityViewOnExitFightSceneHelper.enterActivity11908(forceStarting, exitFightGroup)
	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		PermanentController.instance:jump2Activity(VersionActivity1_9Enum.ActivityId.EnterView)
		RoleActivityController.instance:openLevelView({
			needShowFight = true,
			actId = VersionActivity1_9Enum.ActivityId.Lucy
		})
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity11909(forceStarting, exitFightGroup)
	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		PermanentController.instance:jump2Activity(VersionActivity1_9Enum.ActivityId.EnterView)
		RoleActivityController.instance:openLevelView({
			needShowFight = true,
			actId = VersionActivity1_9Enum.ActivityId.KaKaNia
		})
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity11910(forceStarting, exitFightGroup)
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local stage, layer = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(episodeId)

	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V1a4_BossRushMainView)
		VersionActivity1_9EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			BossRushController.instance:openMainView({
				isOpenLevelDetail = true,
				stage = stage,
				layer = layer
			})
		end, nil, BossRushConfig.instance:getActivityId())
	end)
end

return EnterActivityViewOnExitFightSceneHelper
