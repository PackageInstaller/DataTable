-- chunkname: @modules/logic/versionactivity2_1/common/EnterActivityViewOnExitFightSceneHelper2_1.lua

module("modules.logic.versionactivity2_1.common.EnterActivityViewOnExitFightSceneHelper2_1", package.seeall)

local EnterActivityViewOnExitFightSceneHelper = EnterActivityViewOnExitFightSceneHelper

local function _openPermanent_EnterView(viewParam)
	PermanentController.instance:jump2Activity(VersionActivity2_1Enum.ActivityId.EnterView, viewParam)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity12113(forceStarting, exitFightGroup)
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local stage, layer = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(episodeId)

	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V1a4_BossRushMainView)
		VersionActivity2_1EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			BossRushController.instance:openMainView({
				isOpenLevelDetail = true,
				stage = stage,
				layer = layer
			})
		end, nil, BossRushConfig.instance:getActivityId())
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity12105(forceStarting, exitFightGroup)
	local actId = 12105
	local isPermanent = true

	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		if isPermanent then
			if EnterActivityViewOnExitFightSceneHelper.sequence then
				EnterActivityViewOnExitFightSceneHelper.sequence:destroy()

				EnterActivityViewOnExitFightSceneHelper.sequence = nil
			end

			if exitFightGroup then
				_openPermanent_EnterView()
				AergusiController.instance:openAergusiLevelView(actId, false)
			else
				local viewParam = {
					roleActNeedReqInfo = false,
					isJumpAergusi = true,
					roleActId = actId
				}

				AergusiController.instance:openAergusiLevelView(actId, true)

				local sequence = FlowSequence.New()

				sequence:addWork(OpenViewWork.New({
					openFunction = _openPermanent_EnterView,
					openFunctionObj = viewParam,
					waitOpenViewName = ViewName.AergusiLevelView
				}))
				sequence:start()

				EnterActivityViewOnExitFightSceneHelper.sequence = sequence
			end
		else
			VersionActivity2_1EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity2_1Enum.ActivityId.Aergusi, true)
		end
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity12114(forceStarting, exitFightGroup)
	local actId = 12114
	local isPermanent = true

	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		if isPermanent then
			if EnterActivityViewOnExitFightSceneHelper.sequence then
				EnterActivityViewOnExitFightSceneHelper.sequence:destroy()

				EnterActivityViewOnExitFightSceneHelper.sequence = nil
			end

			if exitFightGroup then
				_openPermanent_EnterView()
				LanShouPaController.instance:openLanShouPaMapView(actId, false)
			else
				local viewParam = {
					isJumpLanShouPa = true,
					roleActNeedReqInfo = false,
					roleActId = actId
				}

				LanShouPaController.instance:openLanShouPaMapView(actId, true)

				local sequence = FlowSequence.New()

				sequence:addWork(OpenViewWork.New({
					openFunction = _openPermanent_EnterView,
					openFunctionObj = viewParam,
					waitOpenViewName = ViewName.LanShouPaMapView
				}))
				sequence:start()

				EnterActivityViewOnExitFightSceneHelper.sequence = sequence
			end
		else
			VersionActivity2_1EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity2_1Enum.ActivityId.LanShouPa, true)
		end
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity12115(forceStarting, exitFightGroup)
	EnterActivityViewOnExitFightSceneHelper.enterVersionActivityDungeonCommon(EnterActivityViewOnExitFightSceneHelper._enterActivityDungeonAterFight12115, forceStarting, exitFightGroup)
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

function EnterActivityViewOnExitFightSceneHelper._enterActivityDungeonAterFight12115(tarClass, param)
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

		VersionActivity2_1EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			Season123Controller.instance:openSeasonEntry({
				actId = actId,
				jumpId = jumpId,
				jumpParam = jumpParam
			})
		end, nil, VersionActivity2_1Enum.ActivityId.Season)
	end
end

function EnterActivityViewOnExitFightSceneHelper.checkFightAfterStory12115(callback, target, param)
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

function EnterActivityViewOnExitFightSceneHelper.enterFightAgain12115()
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

function EnterActivityViewOnExitFightSceneHelper.enterActivity12102(forceStarting, exitFightGroup)
	EnterActivityViewOnExitFightSceneHelper.enterVersionActivityDungeonCommon(EnterActivityViewOnExitFightSceneHelper._enterActivity12102, forceStarting, exitFightGroup)
end

function EnterActivityViewOnExitFightSceneHelper._enterActivity12102(cls, param)
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

	if episodeCo.chapterId == VersionActivity2_1DungeonEnum.DungeonChapterId.ElementFight then
		DungeonMapModel.instance.lastElementBattleId = episodeId
		episodeId = VersionActivity2_1DungeonModel.instance:getLastEpisodeId()

		if episodeId then
			VersionActivity2_1DungeonModel.instance:setLastEpisodeId(nil)
		else
			episodeId = DungeonConfig.instance:getActivityElementFightEpisodeToNormalEpisodeId(episodeCo, VersionActivity2_1DungeonEnum.DungeonChapterId.Story)
		end

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_1DungeonMapView)
	elseif DungeonModel.instance.curSendEpisodePass then
		needLoadMapLevel = false

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_1DungeonMapView)
	else
		needLoadMapLevel = true

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_1DungeonMapLevelView)
	end

	local sequence = FlowSequence.New()

	if isPermanent then
		sequence:addWork(OpenViewWork.New({
			openFunction = _openPermanent_EnterView,
			waitOpenViewName = ViewName.VersionActivity2_1EnterView
		}))
	else
		sequence:addWork(OpenViewWork.New({
			openFunction = VersionActivity2_1EnterController.directOpenVersionActivityEnterView,
			openFunctionObj = VersionActivity2_1EnterController.instance,
			waitOpenViewName = ViewName.VersionActivity2_1EnterView
		}))
	end

	sequence:registerDoneListener(function()
		if needLoadMapLevel then
			VersionActivity2_1DungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId, function()
				ViewMgr.instance:openView(ViewName.VersionActivity2_1DungeonMapLevelView, {
					episodeId = episodeId
				})
			end, nil)
		else
			VersionActivity2_1DungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId)
		end
	end)
	sequence:start()

	EnterActivityViewOnExitFightSceneHelper.sequence = sequence
end

return EnterActivityViewOnExitFightSceneHelper
