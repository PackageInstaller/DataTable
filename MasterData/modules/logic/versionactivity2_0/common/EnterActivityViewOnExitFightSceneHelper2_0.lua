-- chunkname: @modules/logic/versionactivity2_0/common/EnterActivityViewOnExitFightSceneHelper2_0.lua

module("modules.logic.versionactivity2_0.common.EnterActivityViewOnExitFightSceneHelper2_0", package.seeall)

local EnterActivityViewOnExitFightSceneHelper = EnterActivityViewOnExitFightSceneHelper

local function _openPermanent_EnterView(viewParam)
	PermanentController.instance:jump2Activity(VersionActivity2_0Enum.ActivityId.EnterView, viewParam)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity12003(forceStarting, exitFightGroup)
	EnterActivityViewOnExitFightSceneHelper.enterVersionActivityDungeonCommon(EnterActivityViewOnExitFightSceneHelper._enterActivity12003, forceStarting, exitFightGroup)
end

function EnterActivityViewOnExitFightSceneHelper._enterActivity12003(cls, param)
	local isPermanent = true
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

	if episodeCo.chapterId == VersionActivity2_0DungeonEnum.DungeonChapterId.ElementFight then
		DungeonMapModel.instance.lastElementBattleId = episodeId
		episodeId = VersionActivity2_0DungeonModel.instance:getLastEpisodeId()

		if episodeId then
			VersionActivity2_0DungeonModel.instance:setLastEpisodeId(nil)
		else
			episodeId = DungeonConfig.instance:getActivityElementFightEpisodeToNormalEpisodeId(episodeCo, VersionActivity2_0DungeonEnum.DungeonChapterId.Story)
		end

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_0DungeonMapView)
	elseif DungeonModel.instance.curSendEpisodePass then
		needLoadMapLevel = false

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_0DungeonMapView)
	else
		needLoadMapLevel = true

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_0DungeonMapLevelView)
	end

	local sequence = FlowSequence.New()

	if isPermanent then
		sequence:addWork(OpenViewWork.New({
			openFunction = _openPermanent_EnterView,
			waitOpenViewName = ViewName.VersionActivity2_0EnterView
		}))
	else
		sequence:addWork(OpenViewWork.New({
			openFunction = EnterActivityViewOnExitFightSceneHelper.open2_7ReactivityEnterView,
			openFunctionObj = VersionActivityFixedHelper.getVersionActivityEnterController().instance,
			waitOpenViewName = VersionActivityFixedHelper.getVersionActivityEnterViewName()
		}))
	end

	sequence:registerDoneListener(function()
		if needLoadMapLevel then
			VersionActivity2_0DungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId, function()
				ViewMgr.instance:openView(ViewName.VersionActivity2_0DungeonMapLevelView, {
					episodeId = episodeId
				})
			end, nil)
		else
			VersionActivity2_0DungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId)
		end
	end)
	sequence:start()

	EnterActivityViewOnExitFightSceneHelper.sequence = sequence
end

function EnterActivityViewOnExitFightSceneHelper.open2_7ReactivityEnterView()
	VersionActivityFixedHelper.getVersionActivityEnterController():directOpenVersionActivityEnterView(VersionActivity2_7Enum.ActivityId.Reactivity)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity12009(forceStarting, exitFightGroup)
	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		PermanentController.instance:jump2Activity(VersionActivity2_0Enum.ActivityId.EnterView)
		RoleActivityController.instance:openLevelView({
			needShowFight = true,
			actId = VersionActivity2_0Enum.ActivityId.Mercuria
		})
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity12008(forceStarting, exitFightGroup)
	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		PermanentController.instance:jump2Activity(VersionActivity2_0Enum.ActivityId.EnterView)
		RoleActivityController.instance:openLevelView({
			needShowFight = true,
			actId = VersionActivity2_0Enum.ActivityId.Joe
		})
	end)
end

function EnterActivityViewOnExitFightSceneHelper.activate()
	return
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity12013(forceStarting, exitFightGroup)
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local stage, layer = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(episodeId)

	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V1a4_BossRushMainView)
		VersionActivity2_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			BossRushController.instance:openMainView({
				isOpenLevelDetail = true,
				stage = stage,
				layer = layer
			})
		end, nil, BossRushConfig.instance:getActivityId())
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity12006(forceStarting, exitFightGroup)
	EnterActivityViewOnExitFightSceneHelper.enterVersionActivityDungeonCommon(EnterActivityViewOnExitFightSceneHelper._enterActivityDungeonAterFight12006, forceStarting, exitFightGroup)
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

function EnterActivityViewOnExitFightSceneHelper._enterActivityDungeonAterFight12006(tarClass, param)
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

		VersionActivity2_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			Season123Controller.instance:openSeasonEntry({
				actId = actId,
				jumpId = jumpId,
				jumpParam = jumpParam
			})
		end, nil, VersionActivity2_0Enum.ActivityId.Season)
	end
end

function EnterActivityViewOnExitFightSceneHelper.checkFightAfterStory12006(callback, target, param)
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

function EnterActivityViewOnExitFightSceneHelper.enterFightAgain12006()
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
