-- chunkname: @modules/logic/versionactivity1_3/common/EnterActivityViewOnExitFightSceneHelper1_3.lua

module("modules.logic.versionactivity1_3.common.EnterActivityViewOnExitFightSceneHelper1_3", package.seeall)

local EnterActivityViewOnExitFightSceneHelper = EnterActivityViewOnExitFightSceneHelper

function EnterActivityViewOnExitFightSceneHelper.enterActivity11302(forceStarting, exitFightGroup)
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
		if not episodeCo then
			return
		end

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_3DungeonMapLevelView)
		PermanentController.instance:jump2Activity(VersionActivity1_3Enum.ActivityId.EnterView)

		if episodeCo.chapterId == VersionActivity1_3DungeonEnum.DungeonChapterId.ElementFight then
			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_3DungeonMapView)

			DungeonMapModel.instance.lastElementBattleId = episodeId
			episodeId = DungeonConfig.instance:getActivityElementFightEpisodeToNormalEpisodeId(episodeCo, VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei)

			VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId)
		elseif episodeCo.chapterId == VersionActivity1_3DungeonEnum.DungeonChapterId.Daily then
			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_3DungeonMapView)

			local remainNum, _ = Activity126Model.instance:getRemainNum()

			if remainNum > 0 then
				DungeonMapModel.instance.lastElementBattleId = episodeId
			end

			episodeId = VersionActivity1_3DungeonController.instance.dailyFromEpisodeId or VersionActivity1_3DungeonEnum.DailyEpisodeId

			VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId)
		elseif DungeonModel.instance.curSendEpisodePass then
			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_3DungeonMapView)
			VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId)
		else
			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_3DungeonMapLevelView)
			VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView(chapterId, episodeId, function()
				ViewMgr.instance:openView(ViewName.VersionActivity1_3DungeonMapLevelView, {
					episodeId = episodeId
				})
			end, nil, {
				needSelectFocusItem = true
			})
		end
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity11304(forceStarting, exitFightGroup)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.Activity1_3ChessGameView)
		PermanentController.instance:jump2Activity(VersionActivity1_3Enum.ActivityId.EnterView)
		Activity1_3ChessController.instance:openMapView(nil, Va3ChessController.instance.openGameAfterFight, Va3ChessController.instance, exitFightGroup)
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity11306(forceStarting, exitFightGroup)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.JiaLaBoNaGameView)
		PermanentController.instance:jump2Activity(VersionActivity1_3Enum.ActivityId.EnterView)

		local episodeId = Activity120Model.instance:getCurEpisodeId()

		JiaLaBoNaController.instance:openMapView(episodeId, Va3ChessController.instance.openGameAfterFight, Va3ChessController.instance, exitFightGroup)
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity11307(forceStarting, exitFightGroup)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.Activity1_3_119View)
		VersionActivity1_3EnterController.instance:directOpenVersionActivityEnterView()
		Activity1_3_119Controller.instance:openView()
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity11300(forceStarting, exitFightGroup)
	EnterActivityViewOnExitFightSceneHelper.enterVersionActivityDungeonCommon(EnterActivityViewOnExitFightSceneHelper._enterActivityDungeonAterFight11300, forceStarting, exitFightGroup)
end

function EnterActivityViewOnExitFightSceneHelper.checkFightAfterStory11300(callback, target, param)
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
		local actId = Activity104Model.instance:getCurSeasonId()

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

function EnterActivityViewOnExitFightSceneHelper._enterActivityDungeonAterFight11300(tarClass, param)
	local episodeId = param.episodeId
	local exitFightGroup = param.exitFightGroup

	if not episodeId then
		return
	end

	VersionActivity1_3EnterController.instance:directOpenVersionActivityEnterView()

	local layer = Activity104Model.instance:getBattleFinishLayer()
	local actId = Activity104Model.instance:getCurSeasonId()

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
							local next_config = SeasonConfig.instance:getSeasonEpisodeCo(actId, curLayer)

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

function EnterActivityViewOnExitFightSceneHelper.enterFightAgain11300()
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)
	local actId = Activity104Model.instance:getCurSeasonId()
	local layer = Activity104Model.instance:getBattleFinishLayer()

	if episodeCo.type == DungeonEnum.EpisodeType.SeasonRetail then
		layer = 0

		return false
	end

	local isReplay = FightController.instance:isReplayMode(episodeId)

	if isReplay and not layer then
		if episodeCo.type == DungeonEnum.EpisodeType.Season then
			local co = SeasonConfig.instance:getSeasonEpisodeCos(actId)

			for _, v in pairs(co) do
				if v.episodeId == episodeId then
					layer = v.layer

					break
				end
			end
		elseif episodeCo.type == DungeonEnum.EpisodeType.SeasonRetail then
			layer = 0
		elseif episodeCo.type == DungeonEnum.EpisodeType.SeasonSpecial then
			local co = SeasonConfig.instance:getSeasonSpecialCos(actId)

			for _, v in pairs(co) do
				if v.episodeId == episodeId then
					layer = v.layer

					break
				end
			end
		end

		Activity104Model.instance:setBattleFinishLayer(layer)
	end

	Activity104Rpc.instance:sendBeforeStartAct104BattleRequest(actId, layer, episodeId, EnterActivityViewOnExitFightSceneHelper.enterFightAgain11300RpcCallback, nil)

	return true
end

function EnterActivityViewOnExitFightSceneHelper.enterFightAgain11300RpcCallback(cmd, resultCode, msg)
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
