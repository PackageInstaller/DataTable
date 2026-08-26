-- chunkname: @modules/logic/versionactivity1_8/common/EnterActivityViewOnExitFightSceneHelper1_8.lua

module("modules.logic.versionactivity1_8.common.EnterActivityViewOnExitFightSceneHelper1_8", package.seeall)

local EnterActivityViewOnExitFightSceneHelper = EnterActivityViewOnExitFightSceneHelper

function EnterActivityViewOnExitFightSceneHelper.enterActivity11804(forceStarting, exitFightGroup)
	EnterActivityViewOnExitFightSceneHelper.enterVersionActivityDungeonCommon(EnterActivityViewOnExitFightSceneHelper._enterActivity11804, forceStarting, exitFightGroup)
end

function EnterActivityViewOnExitFightSceneHelper._enterActivity11804(cls, param)
	local episodeId = param.episodeId
	local episodeCo = param.episodeCo

	if EnterActivityViewOnExitFightSceneHelper.sequence then
		EnterActivityViewOnExitFightSceneHelper.sequence:destroy()

		EnterActivityViewOnExitFightSceneHelper.sequence = nil
	end

	local needLoadMapLevel = false

	if episodeCo.chapterId == VersionActivity1_8DungeonEnum.DungeonChapterId.ElementFight then
		DungeonMapModel.instance.lastElementBattleId = episodeId
		episodeId = VersionActivity1_8DungeonModel.instance:getLastEpisodeId()

		if episodeId then
			VersionActivity1_8DungeonModel.instance:setLastEpisodeId(nil)
		else
			episodeId = DungeonConfig.instance:getActivityElementFightEpisodeToNormalEpisodeId(episodeCo, VersionActivity1_8DungeonEnum.DungeonChapterId.Story)
		end

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_8DungeonMapView)
	elseif DungeonModel.instance.curSendEpisodePass then
		needLoadMapLevel = false

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_8DungeonMapView)
	else
		needLoadMapLevel = true

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_8DungeonMapLevelView)
	end

	PermanentController.instance:jump2Activity(VersionActivity1_8Enum.ActivityId.EnterView)

	local sequence = FlowSequence.New()

	sequence:registerDoneListener(function()
		if needLoadMapLevel then
			VersionActivity1_8DungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId, function()
				ViewMgr.instance:openView(ViewName.VersionActivity1_8DungeonMapLevelView, {
					episodeId = episodeId
				})
			end, nil)
		else
			VersionActivity1_8DungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId)
		end
	end)
	sequence:start()

	EnterActivityViewOnExitFightSceneHelper.sequence = sequence
end

function EnterActivityViewOnExitFightSceneHelper.open2_4ReactivityEnterView()
	VersionActivity2_4EnterController.instance:directOpenVersionActivityEnterView(VersionActivity2_4Enum.ActivityId.Reactivity)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity11806(forceStarting, exitFightGroup)
	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		local actCo = ActivityConfig.instance:getActivityCo(VersionActivity1_8Enum.ActivityId.Weila)
		local isRetro = actCo and actCo.isRetroAcitivity == 2

		if isRetro then
			PermanentController.instance:jump2Activity(VersionActivity1_8Enum.ActivityId.EnterView)
			ActWeilaController.instance:openLevelView({
				needShowFight = true
			})
		else
			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_8EnterView)
			VersionActivity1_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
				ActWeilaController.instance:openLevelView({
					needShowFight = true
				})
			end, nil, VersionActivity1_8Enum.ActivityId.Weila)
		end
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity11807(forceStarting, exitFightGroup)
	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		local actCo = ActivityConfig.instance:getActivityCo(VersionActivity1_8Enum.ActivityId.Weila)
		local isRetro = actCo and actCo.isRetroAcitivity == 2

		if isRetro then
			PermanentController.instance:jump2Activity(VersionActivity1_8Enum.ActivityId.EnterView)
			ActWindSongController.instance:openLevelView({
				needShowFight = true
			})
		else
			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_8EnterView)
			VersionActivity1_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
				ActWindSongController.instance:openLevelView({
					needShowFight = true
				})
			end, nil, VersionActivity1_8Enum.ActivityId.WindSong)
		end
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity11812(forceStarting, exitFightGroup)
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local stage, layer = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(episodeId)

	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V1a4_BossRushMainView)
		VersionActivity1_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			BossRushController.instance:openMainView({
				isOpenLevelDetail = true,
				stage = stage,
				layer = layer
			})
		end, nil, BossRushConfig.instance:getActivityId())
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity11811(forceStarting, exitFightGroup)
	EnterActivityViewOnExitFightSceneHelper.enterVersionActivityDungeonCommon(EnterActivityViewOnExitFightSceneHelper._enterActivityDungeonAterFight11811, forceStarting, exitFightGroup)
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

function EnterActivityViewOnExitFightSceneHelper._enterActivityDungeonAterFight11811(tarClass, param)
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

		VersionActivity1_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			Season123Controller.instance:openSeasonEntry({
				actId = actId,
				jumpId = jumpId,
				jumpParam = jumpParam
			})
		end, nil, VersionActivity1_8Enum.ActivityId.Season)
	end
end

function EnterActivityViewOnExitFightSceneHelper.checkFightAfterStory11811(callback, target, param)
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

function EnterActivityViewOnExitFightSceneHelper.enterFightAgain11811()
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

function EnterActivityViewOnExitFightSceneHelper.activate()
	return
end

return EnterActivityViewOnExitFightSceneHelper
