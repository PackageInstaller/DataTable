-- chunkname: @modules/logic/versionactivity1_2/common/EnterActivityViewOnExitFightSceneHelper1_2.lua

module("modules.logic.versionactivity1_2.common.EnterActivityViewOnExitFightSceneHelper1_2", package.seeall)

local EnterActivityViewOnExitFightSceneHelper = EnterActivityViewOnExitFightSceneHelper

function EnterActivityViewOnExitFightSceneHelper.activate()
	return
end

function EnterActivityViewOnExitFightSceneHelper.enterFightAgain11208()
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)
	local isReplay = FightController.instance:isReplayMode(episodeId)

	if isReplay then
		if VersionActivity1_2DungeonModel.instance.newSp and tabletool.len(VersionActivity1_2DungeonModel.instance.newSp) > 0 then
			VersionActivity1_2DungeonModel.instance.newSp = nil

			return false
		else
			EnterActivityViewOnExitFightSceneHelper.enterFightAgain()
		end
	else
		EnterActivityViewOnExitFightSceneHelper.enterFightAgain()
	end

	return true
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity11208(forceStarting, exitFightGroup)
	EnterActivityViewOnExitFightSceneHelper.enterVersionActivityDungeonCommon(EnterActivityViewOnExitFightSceneHelper._enterActivityDungeonAterFight11208, forceStarting, exitFightGroup)
end

function EnterActivityViewOnExitFightSceneHelper._enterActivityDungeonAterFight11208(tarClass, param)
	local episodeId = param.episodeId
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeCo then
		return
	end

	GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_2DungeonView)
	PermanentController.instance:jump2Activity(VersionActivity1_2Enum.ActivityId.EnterView)

	if episodeCo.chapterId == 12701 or episodeCo.chapterId == 12102 then
		VersionActivity1_2DungeonController.instance:openDungeonView()
	else
		VersionActivity1_2DungeonController.instance:openDungeonView(episodeCo.chapterId, episodeId)
	end
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity11203(forceStarting, exitFightGroup)
	DungeonModel.instance.versionActivityChapterType = nil
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.YaXianMapView)
		PermanentController.instance:jump2Activity(VersionActivity1_2Enum.ActivityId.EnterView)
		Activity115Rpc.instance:sendGetAct115InfoRequest(YaXianEnum.ActivityId, function()
			local mapMo = YaXianModel.instance:getCurrentMapInfo()
			local chapterId = mapMo and mapMo.episodeCo.chapterId

			ViewMgr.instance:openView(ViewName.YaXianMapView, {
				chapterId = chapterId
			})
			YaXianDungeonController.instance:openGameAfterFight()
		end)
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity11200(forceStarting, exitFightGroup)
	EnterActivityViewOnExitFightSceneHelper.enterVersionActivityDungeonCommon(EnterActivityViewOnExitFightSceneHelper._enterActivityDungeonAterFight11200, forceStarting, exitFightGroup)
end

function EnterActivityViewOnExitFightSceneHelper.checkFightAfterStory11200(callback, target, param)
	if EnterActivityViewOnExitFightSceneHelper.recordMO then
		if EnterActivityViewOnExitFightSceneHelper.recordMO ~= 1 then
			return
		end

		local episodeId = DungeonModel.instance.curSendEpisodeId

		if not episodeId then
			return
		end

		local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

		if not episodeCo or episodeCo.type ~= DungeonEnum.EpisodeType.Season then
			return
		end

		local layer = Activity104Model.instance:getBattleFinishLayer()
		local actId = Activity104Enum.SeasonType.Season2

		if Activity104Model.instance:isEpisodeAfterStory(actId, layer) then
			return
		end

		local layerCo = SeasonConfig.instance:getSeasonEpisodeCo(actId, layer)

		if not layerCo or layerCo.afterStoryId == 0 then
			return
		end

		StoryController.instance:playStory(layerCo.afterStoryId, nil, callback, target, param)

		return true
	end
end

function EnterActivityViewOnExitFightSceneHelper._enterActivityDungeonAterFight11200(tarClass, param)
	local episodeId = param.episodeId
	local exitFightGroup = param.exitFightGroup

	if not episodeId then
		return
	end

	VersionActivity1_2EnterController.instance:directOpenVersionActivity1_2EnterView()

	local layer = Activity104Model.instance:getBattleFinishLayer()
	local actId = Activity104Enum.SeasonType.Season2

	if EnterActivityViewOnExitFightSceneHelper.recordMO then
		local fightResult = EnterActivityViewOnExitFightSceneHelper.recordMO.fightResult
		local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)
		local episodeType = episodeCo and episodeCo.type
		local levelUpStage = Activity104Model.instance:canPlayStageLevelup(fightResult, episodeType, exitFightGroup, actId, layer)
		local jumpId, jumpParam
		local isFirstPassSeason = Activity104Model.instance:canMarkFightAfterStory(fightResult, episodeType, exitFightGroup, actId, layer)

		if isFirstPassSeason then
			Activity104Rpc.instance:sendMarkEpisodeAfterStoryRequest(actId, layer)
		end

		if episodeCo then
			if not fightResult or fightResult == -1 or fightResult == 0 then
				if episodeType == DungeonEnum.EpisodeType.Season then
					jumpId = Activity104Enum.JumpId.Market
					jumpParam = {
						tarLayer = layer
					}
				elseif episodeType == DungeonEnum.EpisodeType.SeasonRetail then
					jumpId = Activity104Enum.JumpId.Retail
				elseif episodeType == DungeonEnum.EpisodeType.SeasonSpecial then
					jumpId = Activity104Enum.JumpId.Discount
					jumpParam = {
						defaultSelectLayer = layer,
						directOpenLayer = layer
					}
				end
			elseif fightResult == 1 then
				if not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonUTTU) or not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonDiscount) then
					if episodeType == DungeonEnum.EpisodeType.Season then
						if not levelUpStage then
							local curLayer = layer + 1
							local next_config = SeasonConfig.instance:getSeasonEpisodeCo(Activity104Enum.SeasonType.Season2, curLayer)

							if next_config then
								jumpId = Activity104Enum.JumpId.Market
								jumpParam = {
									tarLayer = curLayer
								}
							end
						end
					elseif episodeType == DungeonEnum.EpisodeType.SeasonRetail then
						jumpId = Activity104Enum.JumpId.Retail
					elseif episodeType == DungeonEnum.EpisodeType.SeasonSpecial then
						jumpId = Activity104Enum.JumpId.Discount
						jumpParam = {
							defaultSelectLayer = layer
						}
					end
				end

				if isFirstPassSeason and layer == 2 then
					jumpId = nil
					jumpParam = nil
				end
			elseif episodeType == DungeonEnum.EpisodeType.SeasonSpecial then
				jumpId = Activity104Enum.JumpId.Discount
			end
		else
			logError(string.format("找不到对应关卡表,id:%s", episodeId))
		end

		Activity104Controller.instance:openSeasonMainView({
			levelUpStage = levelUpStage,
			jumpId = jumpId,
			jumpParam = jumpParam
		})
	end
end

function EnterActivityViewOnExitFightSceneHelper.enterFightAgain11200()
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)
	local actId = Activity104Enum.SeasonType.Season2
	local layer = Activity104Model.instance:getBattleFinishLayer()

	if episodeCo.type == DungeonEnum.EpisodeType.SeasonRetail then
		layer = 0

		return false
	end

	Activity104Rpc.instance:sendBeforeStartAct104BattleRequest(actId, layer, episodeId, EnterActivityViewOnExitFightSceneHelper.enterFightAgain11200RpcCallback, nil)

	return true
end

function EnterActivityViewOnExitFightSceneHelper.enterFightAgain11200RpcCallback(cmd, resultCode, msg)
	if resultCode ~= 0 then
		MainController.instance:enterMainScene(true)
	else
		EnterActivityViewOnExitFightSceneHelper.enterFightAgain()
	end
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity11202(forceStarting, exitFightGroup)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.Activity114View)
		PermanentController.instance:jump2Activity(VersionActivity1_2Enum.ActivityId.EnterView)

		local viewParams

		ViewMgr.instance:openView(ViewName.Activity114View, (Activity114Model.instance.serverData.isEnterSchool and Activity114Model.instance.serverData.battleEventId <= 0 or nil) and {
			defaultTabIds = {
				[2] = Activity114Enum.TabIndex.MainView
			}
		})
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity11206(forceStarting, exitFightGroup)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.Activity119View)
		VersionActivity1_2EnterController.instance:directOpenVersionActivity1_2EnterView()
		Activity119Controller.instance:openAct119View()
	end)
end

return EnterActivityViewOnExitFightSceneHelper
