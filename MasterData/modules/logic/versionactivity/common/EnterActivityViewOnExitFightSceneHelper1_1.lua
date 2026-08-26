-- chunkname: @modules/logic/versionactivity/common/EnterActivityViewOnExitFightSceneHelper1_1.lua

module("modules.logic.versionactivity.common.EnterActivityViewOnExitFightSceneHelper1_1", package.seeall)

local EnterActivityViewOnExitFightSceneHelper = EnterActivityViewOnExitFightSceneHelper

function EnterActivityViewOnExitFightSceneHelper.enterActivity11104(forceStarting, exitFightGroup)
	local chapterId = DungeonModel.instance.curSendChapterId
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local isReplay = FightController.instance:isReplayMode(episodeId)
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not exitFightGroup and isReplay then
		local recordFarmItem = JumpModel.instance:getRecordFarmItem()
		local farm = FightSuccView.checkRecordFarmItem(episodeId, recordFarmItem)

		if farm then
			local quantity = ItemModel.instance:getItemQuantity(recordFarmItem.type, recordFarmItem.id)
			local enough = quantity >= recordFarmItem.quantity

			if not enough then
				GameSceneMgr.instance:closeScene(nil, nil, nil, true)
				DungeonFightController.instance:enterFight(episodeCo.chapterId, episodeId, DungeonModel.instance.curSelectTicketId)

				return
			end
		else
			GameSceneMgr.instance:closeScene(nil, nil, nil, true)
			DungeonFightController.instance:enterFight(episodeCo.chapterId, episodeId, DungeonModel.instance.curSelectTicketId)

			return
		end
	end

	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivityDungeonMapLevelView)
		PermanentController.instance:jump2Activity(VersionActivityEnum.ActivityId.Act105)

		if episodeCo.chapterId == VersionActivityEnum.DungeonChapterId.ElementFight then
			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivityDungeonMapView)

			DungeonMapModel.instance.lastElementBattleId = episodeId
			episodeId = DungeonConfig.instance:getElementFightEpisodeToNormalEpisodeId(episodeCo)

			VersionActivityDungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId)
		elseif DungeonModel.instance.curSendEpisodePass then
			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivityDungeonMapView)
			VersionActivityDungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId)
		else
			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivityDungeonMapLevelView)
			VersionActivityDungeonController.instance:openVersionActivityDungeonMapView(chapterId, episodeId, function()
				ViewMgr.instance:openView(ViewName.VersionActivityDungeonMapLevelView, {
					episodeId = episodeId
				})
			end)
		end
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity11103(forceStarting, exitFightGroup)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivityEnterView)
		VersionActivityController.instance:directOpenVersionActivityEnterView()
		Activity109ChessController.instance:openGameAfterFight(exitFightGroup)
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity11100(forceStarting, exitFightGroup)
	EnterActivityViewOnExitFightSceneHelper.enterVersionActivityDungeonCommon(EnterActivityViewOnExitFightSceneHelper._enterActivityDungeonAterFight11100, forceStarting, exitFightGroup)
end

function EnterActivityViewOnExitFightSceneHelper.checkFightAfterStory11100(callback, target, param)
	if EnterActivityViewOnExitFightSceneHelper.recordMO then
		if EnterActivityViewOnExitFightSceneHelper.recordMO ~= 1 then
			return
		end

		local episodeId = DungeonModel.instance.curSendEpisodeId
		local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

		if not episodeCo or episodeCo.type ~= DungeonEnum.EpisodeType.Season then
			return
		end

		local layer = Activity104Model.instance.battleFinishLayer

		if Activity104Model.instance:isEpisodeAfterStory(Activity104Enum.SeasonType.Season1, layer) then
			return
		end

		local layerCo = SeasonConfig.instance:getSeasonEpisodeCo(Activity104Enum.SeasonType.Season1, layer)

		if not layerCo or layerCo.afterStoryId == 0 then
			return
		end

		StoryController.instance:playStory(layerCo.afterStoryId, nil, callback, target, param)

		return true
	end
end

function EnterActivityViewOnExitFightSceneHelper._enterActivityDungeonAterFight11100(tarClass, param)
	VersionActivityController.instance:directOpenVersionActivityEnterView()

	local layer = Activity104Model.instance.battleFinishLayer
	local actId = Activity104Enum.SeasonType.Season1

	if EnterActivityViewOnExitFightSceneHelper.recordMO then
		local fightResult = EnterActivityViewOnExitFightSceneHelper.recordMO.fightResult
		local episodeId = param.episodeId
		local exitFightGroup = param.exitFightGroup
		local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)
		local episodeType = episodeCo and episodeCo.type
		local levelUpStage = Activity104Model.instance:canPlayStageLevelup(fightResult, episodeType, exitFightGroup, actId, layer)

		Activity104Controller.instance:openSeasonMainView({
			levelUpStage = levelUpStage
		})

		if Activity104Model.instance:canMarkFightAfterStory(fightResult, episodeType, exitFightGroup, actId, layer) then
			Activity104Rpc.instance:sendMarkEpisodeAfterStoryRequest(actId, layer)
		end

		if not episodeCo then
			logError("找不到对应关卡表,id:" .. episodeId)

			return
		end

		if not fightResult or fightResult == -1 or fightResult == 0 then
			if episodeType == DungeonEnum.EpisodeType.Season then
				Activity104Controller.instance:openSeasonMarketView({
					tarLayer = layer
				})

				return
			elseif episodeType == DungeonEnum.EpisodeType.SeasonRetail then
				Activity104Controller.instance:openSeasonRetailView({})

				return
			elseif episodeType == DungeonEnum.EpisodeType.SeasonSpecial then
				Activity104Controller.instance:openSeasonSpecialMarketView({
					defaultSelectLayer = layer,
					directOpenLayer = layer
				})

				return
			end
		end

		if fightResult == 1 then
			if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonUTTU) then
				return
			end

			if episodeType == DungeonEnum.EpisodeType.Season then
				if levelUpStage then
					return
				end

				local curLayer = layer + 1
				local next_config = SeasonConfig.instance:getSeasonEpisodeCo(Activity104Enum.SeasonType.Season1, curLayer)

				if not next_config then
					return
				end

				Activity104Controller.instance:openSeasonMarketView({
					tarLayer = curLayer
				})

				return
			end

			if episodeType == DungeonEnum.EpisodeType.SeasonRetail then
				Activity104Controller.instance:openSeasonRetailView({})

				return
			end

			if episodeType == DungeonEnum.EpisodeType.SeasonSpecial then
				Activity104Controller.instance:openSeasonSpecialMarketView({
					defaultSelectLayer = layer
				})

				return
			end
		end

		if episodeType == DungeonEnum.EpisodeType.SeasonSpecial then
			Activity104Controller.instance:openSeasonSpecialMarketView()
		end
	end
end

function EnterActivityViewOnExitFightSceneHelper.enterFightAgain11100()
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)
	local actId = Activity104Enum.SeasonType.Season1
	local layer = Activity104Model.instance.battleFinishLayer

	if episodeCo.type == DungeonEnum.EpisodeType.SeasonRetail then
		layer = 0

		return false
	end

	Activity104Rpc.instance:sendBeforeStartAct104BattleRequest(actId, layer, episodeId, EnterActivityViewOnExitFightSceneHelper.enterFightAgain11100RpcCallback, nil)

	return true
end

function EnterActivityViewOnExitFightSceneHelper.enterFightAgain11100RpcCallback(cmd, resultCode, msg)
	if resultCode ~= 0 then
		MainController.instance:enterMainScene(true)
	else
		EnterActivityViewOnExitFightSceneHelper.enterFightAgain()
	end
end

function EnterActivityViewOnExitFightSceneHelper.activate()
	return
end

return EnterActivityViewOnExitFightSceneHelper
