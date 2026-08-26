-- chunkname: @modules/logic/fight/controller/FightController.lua

module("modules.logic.fight.controller.FightController", package.seeall)

local FightController = class("FightController", BaseController)

function FightController:onInit()
	return
end

function FightController:reInit()
	TaskDispatcher.cancelTask(self._delayEnterFightScene, self)

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		FightSystem.instance:dispose()
	end

	self._guideContinueEvent = nil
end

function FightController:addConstEvents()
	FightController.instance:registerCallback(FightEvent.RespBeginFight, self._respBeginFight, self)
	FightController.instance:registerCallback(FightEvent.PushEndFight, self._pushEndFight, self)
	FightController.instance:registerCallback(FightEvent.OnStartSequenceFinish, self._onStartSequenceFinish, self)
	FightController.instance:registerCallback(FightEvent.OnRoundSequenceFinish, self._onRoundSequenceFinish, self)
	FightController.instance:registerCallback(FightEvent.OnClothSkillRoundSequenceFinish, self.onClothSkillRoundSequenceFinish, self)
	FightController.instance:registerCallback(FightEvent.OnEndSequenceFinish, self._onEndSequenceFinish, self)
	GameSceneMgr.instance:registerCallback(SceneType.Fight, self._onFightSceneStart, self)

	self._fightEventExtend = FightEventExtend.New()

	self._fightEventExtend:addConstEvents()
end

function FightController:sendTestFight(fightParam, fightActType)
	logNormal("Enter Test Fight, param = \n" .. cjson.encode(fightParam))
	FightModel.instance:setFightParam(fightParam)

	fightActType = fightActType or FightEnum.FightActType.Normal

	FightRpc.instance:sendTestFightRequest(fightParam, fightParam.monsterGroupIds, fightActType)
end

function FightController:sendTestFightId(fightParam)
	logNormal("Enter Test FightId, param = \n" .. cjson.encode(fightParam))
	FightModel.instance:setFightParam(fightParam)

	fightParam.fightActType = fightParam.fightActType or FightEnum.FightActType.Normal

	FightRpc.instance:sendTestFightIdRequest(fightParam)
end

function FightController:enterFightScene()
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		if GameSceneMgr.instance:isLoading() then
			logNormal("正在进入战斗，无法重复进入战斗")
		else
			logNormal("已经在战斗中，无法重复进入战斗")
		end

		return
	end

	local fightParam = FightModel.instance:getFightParam()

	if fightParam and fightParam.sceneId then
		GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.LoadingBlackView2)
		GameSceneMgr.instance:showLoading(SceneType.Fight)
		TaskDispatcher.runDelay(self._delayEnterFightScene, self, 0.5)
	else
		logError("FightParam.sceneId not exist")
	end
end

function FightController:_delayEnterFightScene()
	local fightParam = FightModel.instance:getFightParam()

	if fightParam and fightParam.sceneId then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnEnterFbFight)
		PlayerModel.instance:getAndResetPlayerLevelUp()
		FightModel.instance:checkEnterUseFreeLimit()
		GameSceneMgr.instance:startScene(SceneType.Fight, fightParam.sceneId, fightParam.levelId)
	else
		GameSceneMgr.instance:hideLoading(SceneType.Fight)
		logError("FightParam.sceneId not exist")
	end
end

function FightController:setBackToHeroGroup(needBack)
	self.needBackToHeroGroup = needBack
end

function FightController:backToCurHeroGroup()
	self:setBackToHeroGroup(nil)

	local preSceneType = GameSceneMgr.instance:getPreSceneType()
	local preSceneId = GameSceneMgr.instance:getPreSceneId()
	local preLevelId = GameSceneMgr.instance:getPreLevelId()
	local episodeId = FightResultModel.instance.episodeId
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

	GameSceneMgr.instance:closeScene(nil, nil, nil, true)
	GameSceneMgr.instance:setPrevScene(preSceneType, preSceneId, preLevelId)
	DungeonFightController.instance:enterFight(episodeCo.chapterId, episodeId, DungeonModel.instance.curSelectTicketId)
end

function FightController:exitFightScene()
	FightAudioMgr.instance:setSwitch(FightEnum.AudioSwitch.Checkpointend)

	if isDebugBuild and self.needBackToHeroGroup then
		self:backToCurHeroGroup()

		return
	end

	if DungeonJumpGameController.instance:checkIsJumpGameBattle() then
		DungeonJumpGameController.instance:returnToJumpGameView()

		return
	end

	if VersionActivity2_8DungeonBossBattleController.instance:checkIsBossBattle() then
		VersionActivity2_8DungeonBossBattleController.instance:enterBossView()

		return
	end

	if ToughBattleController.instance:checkIsToughBattle() then
		ToughBattleController.instance:enterToughBattle()

		return
	end

	if EnterActivityViewOnExitFightSceneHelper.checkCurrentIsActivityFight() then
		EnterActivityViewOnExitFightSceneHelper.enterCurrentActivity()

		return
	end

	local recordFarmItem = JumpModel.instance:getRecordFarmItem()

	if recordFarmItem then
		if recordFarmItem.canBackSource and (recordFarmItem.special or recordFarmItem.openedViewNameList and #recordFarmItem.openedViewNameList > 0) then
			self:handleJump()

			return
		end

		if recordFarmItem.checkFunc and recordFarmItem.checkFunc(recordFarmItem.checkFuncObj) then
			JumpModel.instance:clearRecordFarmItem()
		end
	end

	local episodeId = DungeonModel.instance.curSendEpisodeId
	local episodeCO = DungeonConfig.instance:getEpisodeCO(episodeId)

	if episodeCO then
		if episodeCO.type == DungeonEnum.EpisodeType.Explore then
			ExploreController.instance:enterExploreScene()

			return
		end

		if episodeCO.type == DungeonEnum.EpisodeType.Survival then
			SurvivalMapHelper.instance:tryStartFlow("")

			SurvivalMapModel.instance.isFightEnter = true

			SurvivalController.instance:enterSurvivalMap()

			return
		end

		if episodeCO.type == DungeonEnum.EpisodeType.Sodache then
			SodacheStatHelper.instance:startEnterFight()
			SodacheController.instance:enterScene()

			return
		end

		if episodeCO.type == DungeonEnum.EpisodeType.Shelter then
			SurvivalController.instance:enterShelterMap(true)

			return
		end

		if episodeCO.type == DungeonEnum.EpisodeType.Rouge then
			RougeMapController.instance:onExistFight()

			return
		end

		if episodeCO.type == DungeonEnum.EpisodeType.Rouge2 then
			Rouge2_MapController.instance:onExistFight()

			return
		end

		if episodeCO.type == DungeonEnum.EpisodeType.Rouge2Boss then
			Rouge2_BossBattleController.instance:onExistFight(episodeCO)

			return
		end

		if episodeCO.chapterId == DungeonEnum.ChapterId.BossStory then
			GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.VersionActivity2_8BossStoryLoadingView)
		end

		if episodeCO.type == DungeonEnum.EpisodeType.TowerDeep then
			local canShowResultView, fightResult = TowerPermanentDeepModel.instance:checkCanShowResultView()

			if not canShowResultView and fightResult == TowerDeepEnum.FightResult.NotFinish then
				TowerController.instance:endFightEnterTowerDeepHeroGroup(episodeCO)

				return
			end
		end
	end

	episodeId = FightResultModel.instance.episodeId
	episodeCO = DungeonConfig.instance:getEpisodeCO(FightResultModel.instance.episodeId)

	local isReplay = self:isReplayMode(FightResultModel.instance.episodeId)
	local preSceneType = GameSceneMgr.instance:getPreSceneType()
	local preSceneId = GameSceneMgr.instance:getPreSceneId()
	local preLevelId = GameSceneMgr.instance:getPreLevelId()

	if isReplay then
		GameSceneMgr.instance:closeScene(nil, nil, nil, true)
		GameSceneMgr.instance:setPrevScene(preSceneType, preSceneId, preLevelId)
		DungeonFightController.instance:enterFight(episodeCO.chapterId, episodeId, DungeonModel.instance.curSelectTicketId)
	else
		GameSceneMgr.instance:startScene(preSceneType, preSceneId, preLevelId)

		if TeachNoteModel.instance:isJumpEnter() then
			TeachNoteModel.instance:setJumpEnter(false)
			TeachNoteController.instance:enterTeachNoteView(episodeId, true)
		end
	end
end

function FightController:isReplayMode(episodeId)
	local isReplay = false
	local replayRecord = PlayerPrefsHelper.getString(FightModel.getPrefsKeyFightPassModel(), "")

	if not string.nilorempty(replayRecord) then
		replayRecord = cjson.decode(replayRecord)
		isReplay = replayRecord[tostring(episodeId)]
	end

	return isReplay
end

function FightController:enterVersionActivityDungeon(forceStarting, exitFightGroup)
	local chapterId = DungeonModel.instance.curSendChapterId
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local isReplay = self:isReplayMode(episodeId)
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

	DungeonModel.instance.versionActivityChapterType = nil
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivityDungeonMapLevelView)
		VersionActivityController.instance:directOpenVersionActivityEnterView()

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

function FightController:enterVersionActivityDogView(forceStarting, fromRefuseBattle)
	DungeonModel.instance.versionActivityChapterType = nil
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivityEnterView)
		VersionActivityController.instance:directOpenVersionActivityEnterView()
		Activity109ChessController.instance:openGameAfterFight(fromRefuseBattle)
	end)
end

function FightController:enterVersionActivity1_2YaXianView(forceStarting, refuseBattle)
	return
end

function FightController:handleJump()
	local recordFarmItem = JumpModel.instance:getRecordFarmItem()

	JumpModel.instance:clearRecordFarmItem()

	recordFarmItem.canBackSource = nil
	DungeonModel.instance.curSendEpisodeId = nil

	local sceneType = SceneType.Main

	if recordFarmItem.sceneType == SceneType.Main then
		sceneType = SceneType.Main

		MainController.instance:enterMainScene()
	elseif recordFarmItem.sceneType == SceneType.Room then
		sceneType = SceneType.Room

		RoomController.instance:enterRoom(RoomEnum.GameMode.Ob, nil, nil, nil, nil, true)
	elseif recordFarmItem.sceneType == SceneType.Fight then
		self._fightViewDict = self._fightViewDict or {
			[ViewName.HeroGroupFightView] = true,
			[ViewName.V1a2_HeroGroupFightView] = true,
			[ViewName.V1a3_HeroGroupFightView] = true,
			[ViewName.V1a5_HeroGroupFightView] = true,
			[ViewName.V1a6_HeroGroupFightView] = true,
			[ViewName.HeroGroupFightWeekwalkView] = true,
			[ViewName.HeroGroupFightWeekwalk_2View] = true,
			[ViewName.Season123HeroGroupFightView] = true,
			[ViewName.Season166HeroGroupFightView] = true,
			[ViewName.HeroGroupEditView] = true,
			[ViewName.VersionActivity_1_2_HeroGroupEditView] = true,
			[ViewName.Season123HeroGroupEditView] = true,
			[ViewName.Season166HeroGroupEditView] = true,
			[ViewName.RougeHeroGroupEditView] = true,
			[ViewName.SurvivalHeroGroupFightView] = true,
			[ViewName.ShelterHeroGroupFightView] = true,
			[ViewName.SurvivalHeroGroupEditView] = true,
			[ViewName.OdysseyHeroGroupView] = true,
			[ViewName.OdysseyHeroGroupEditView] = true,
			[ViewName.Rouge2_HeroGroupFightView] = true,
			[ViewName.SodacheHeroGroupFightView] = true
		}

		if recordFarmItem.openedViewNameList then
			for i = #recordFarmItem.openedViewNameList, 1, -1 do
				local openViewTable = recordFarmItem.openedViewNameList[i]

				if self._fightViewDict[openViewTable.viewName] then
					table.remove(recordFarmItem.openedViewNameList, i)
				end
			end
		end

		sceneType = SceneType.Main

		MainController.instance:enterMainScene()
	else
		sceneType = SceneType.Main

		MainController.instance:enterMainScene()
		logWarn("not handle recordFarmItem.sceneType : " .. tostring(recordFarmItem.sceneType))
	end

	SceneHelper.instance:waitSceneDone(sceneType, function()
		if recordFarmItem.jumpId then
			GameFacade.jump(recordFarmItem.jumpId)
		else
			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, recordFarmItem.openedViewNameList[#recordFarmItem.openedViewNameList].viewName)

			local isRoomScene = RoomController.instance:isRoomScene()

			if isRoomScene then
				RoomController.instance:popUpSourceView(recordFarmItem.openedViewNameList)

				for _, openView in ipairs(recordFarmItem.openedViewNameList) do
					if openView.viewName ~= ViewName.RoomInitBuildingView and openView.viewName ~= ViewName.RoomFormulaView then
						ViewMgr.instance:openView(openView.viewName, openView.viewParam)
					end
				end
			else
				for _, openView in ipairs(recordFarmItem.openedViewNameList) do
					if openView.viewName == ViewName.RoomInitBuildingView or openView.viewName == ViewName.RoomFormulaView then
						RoomController.instance:popUpSourceView(recordFarmItem.openedViewNameList)
					elseif openView.viewName == ViewName.BackpackView then
						BackpackController.instance:enterItemBackpack()
					else
						ViewMgr.instance:openView(openView.viewName, openView.viewParam)
					end
				end
			end
		end
	end)
end

function FightController:_respBeginFight()
	self:enterFightScene()
end

function FightController:_pushEndFight()
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight and not GameSceneMgr.instance:isLoading() then
		FightGameMgr.playMgr:playEnd()
	end
end

function FightController:_onFightSceneStart(sceneLevelId, Exit0Enter1)
	if Exit0Enter1 == 1 then
		if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DouQuQu) then
			return
		end

		if FightModel.instance.needFightReconnect then
			FightGameMgr.playMgr:playReconnect()
		else
			FightGameMgr.playMgr:playStart()
		end
	end
end

function FightController:_onStartSequenceFinish()
	self:_recordFreeTicket()
	self:beginWave()

	if FightModel.instance:isFinish() then
		logNormal("回合结束，战斗结束")

		if FightDataHelper.fieldMgr:isDouQuQu() then
			return
		end

		FightRpc.instance:sendEndFightRequest(false)
	end
end

function FightController:beginWave()
	FightController.instance:dispatchEvent(FightEvent.OnBeginWave)
end

function FightController:_onRoundSequenceFinish()
	if FightModel.instance:isFinish() then
		logNormal("回合结束，战斗结束")

		if FightDataHelper.fieldMgr:isDouQuQu() then
			return
		end

		FightRpc.instance:sendEndFightRequest(false)
	end
end

function FightController:onClothSkillRoundSequenceFinish()
	if FightModel.instance:isFinish() then
		logNormal("回合结束，战斗结束")

		if FightDataHelper.fieldMgr:isDouQuQu() then
			return
		end

		FightRpc.instance:sendEndFightRequest(false)
	end
end

function FightController:_onEndSequenceFinish()
	return
end

function FightController:GuideFlowPauseAndContinue(varKey, pauseEvent, continueEvent, callback, callbackObj, p1, p2, p3)
	local guideParam = FightModel.instance:getGuideParam()

	FightController.instance:dispatchEvent(pauseEvent, guideParam, p1, p2, p3)

	if guideParam[varKey] then
		guideParam[varKey] = false

		if self._guideContinueEvent then
			logError("guiding event: " .. self._guideContinueEvent .. ", try to replase with: " .. continueEvent)
			FightController.instance:unregisterCallback(self._guideContinueEvent, self._continueCallback, self)
		end

		self._guideContinueEvent = continueEvent
		self._guideCallback = callback
		self._guideCallbackObj = callbackObj

		FightController.instance:registerCallback(self._guideContinueEvent, self._continueCallback, self)

		return true
	else
		callback(callbackObj)

		if self._guideContinueEvent == pauseEvent then
			FightController.instance:unregisterCallback(self._guideContinueEvent, self._continueCallback, self)

			self._guideContinueEvent = nil
			self._guideCallback = nil
			self._guideCallbackObj = nil
		end
	end

	return false
end

function FightController:_continueCallback()
	if self._guideContinueEvent then
		FightController.instance:unregisterCallback(self._guideContinueEvent, self._continueCallback, self)
	end
end

function FightController:setNewBieFightParamByEpisodeId(episodeId)
	local fightParam = FightParam.New()

	fightParam:setEpisodeId(episodeId)
	FightModel.instance:setFightParam(fightParam)

	return fightParam
end

function FightController:setFightParamByEpisodeAndBattle(episodeId, battleId)
	local fightParam = FightParam.New()

	fightParam:setEpisodeAndBattle(episodeId, battleId)
	FightModel.instance:setFightParam(fightParam)

	return fightParam
end

function FightController:setFightParamByEpisodeId(episodeId, isReplay, multiplication, battleId)
	local fightParam = FightParam.New()

	fightParam:setEpisodeId(episodeId, battleId)

	fightParam.isReplay = isReplay
	fightParam.multiplication = multiplication

	FightModel.instance:setFightParam(fightParam)

	return fightParam
end

function FightController:setFightParamByEpisodeBattleId(episodeId, battleId)
	local fightParam = FightParam.New()

	fightParam:setEpisodeId(episodeId, battleId)
	FightModel.instance:setFightParam(fightParam)

	return fightParam
end

function FightController:setFightParamByBattleId(battleId)
	local fightParam = FightParam.New()

	fightParam:setBattleId(battleId)
	FightModel.instance:setFightParam(fightParam)

	return fightParam
end

function FightController:setFightHeroGroup()
	local fightParam = FightModel.instance:getFightParam()

	if not fightParam then
		return false
	end

	local curGroupMO = HeroGroupModel.instance:getCurGroupMO()

	if not curGroupMO then
		GameFacade.showToast(ToastEnum.FightNoCurGroupMO)

		return false
	end

	local main, mainCount = curGroupMO:getMainList()
	local sub, subCount = curGroupMO:getSubList()

	if (not curGroupMO.aidDict or #curGroupMO.aidDict <= 0) and mainCount + subCount == 0 then
		GameFacade.showToast(ToastEnum.FightNoCurGroupMO)

		return false
	end

	local battleId = fightParam.battleId
	local battleConfig = battleId and lua_battle.configDict[battleId]

	if battleConfig and battleConfig.noClothSkill == 0 then
		if not curGroupMO.clothId then
			local clothId = 0
			local seasonEquips = SeasonFightHandler.getSeasonEquips(curGroupMO, fightParam)

			fightParam:setMySide(clothId, main, curGroupMO:getSubList(), curGroupMO:getAllHeroEquips(), seasonEquips, nil, nil, curGroupMO:getAssistBossId(), curGroupMO:getSaveParams())

			return true
		end
	end
end

function FightController:setFightHeroSingleGroup()
	local fightParam = FightModel.instance:getFightParam()

	if not fightParam then
		return false
	end

	local _, assistMo = HeroGroupModel.instance:getAssistMo()
	local curGroupMO = HeroGroupModel.instance:getCurGroupMO()

	if not curGroupMO then
		GameFacade.showToast(ToastEnum.FightNoCurGroupMO)

		return false
	end

	local main, mainCount = curGroupMO:getMainList()
	local sub, subCount = curGroupMO:getSubList()
	local alreadyList = HeroSingleGroupModel.instance:getList()
	local equips = curGroupMO:getAllHeroEquips()
	local assistBossId = curGroupMO:getAssistBossId()
	local params = curGroupMO:getSaveParams()

	for i = 1, #main do
		if main[i] ~= alreadyList[i].heroUid then
			main[i] = "0"
			mainCount = mainCount - 1

			if equips[i] then
				equips[i].heroUid = "0"
			end
		end
	end

	for i = #main + 1, math.min(#main + #sub, #alreadyList) do
		if sub[i - #main] ~= alreadyList[i].heroUid then
			sub[i - #main] = "0"
			subCount = subCount - 1

			if equips[i] then
				equips[i].heroUid = "0"
			end
		end
	end

	if assistMo then
		for i, info in ipairs(equips) do
			local heroUid = info.heroUid
			local heroMo = HeroModel.instance:getById(heroUid)

			if heroMo and assistMo.assistMo.heroId == heroMo.heroId then
				info.heroUid = assistMo.heroUid

				break
			end
		end

		main[assistMo.id] = assistMo.assistMo.heroUid

		fightParam:setAssistHeroInfo(assistMo.assistMo.heroUid, assistMo.assistMo.userId)

		mainCount = mainCount + 1
	end

	if (not curGroupMO.aidDict or #curGroupMO.aidDict <= 0) and mainCount + subCount == 0 then
		GameFacade.showToast(ToastEnum.FightNoCurGroupMO)

		return false
	end

	local seasonEquips = SeasonFightHandler.getSeasonEquips(curGroupMO, fightParam)
	local battleId = fightParam.battleId
	local battleConfig = battleId and lua_battle.configDict[battleId]

	if battleConfig and battleConfig.noClothSkill == 0 then
		if not curGroupMO.clothId then
			local clothId = 0

			fightParam:setMySide(clothId, main, sub, equips, seasonEquips, nil, nil, assistBossId, params)

			return true
		end
	end
end

function FightController:openRoundView()
	if self:canOpenRoundView() then
		ViewMgr.instance:openView(ViewName.FightRoundView)
	end
end

function FightController:canOpenRoundView()
	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DouQuQu) then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.FightQuitTipView) then
		return false
	end

	local fightParam = FightModel.instance:getFightParam()

	if not fightParam.episodeId then
		return false
	end

	return not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidRoundView)
end

function FightController:getPlayerPrefKeyAuto(episodeId)
	if not episodeId then
		return
	end

	local key = PlayerPrefsKey.FightAutoEpsodeIds .. PlayerModel.instance:getPlayinfo().userId
	local param = PlayerPrefsHelper.getString(key, "")

	if string.nilorempty(param) then
		return false
	end

	local episodeIds = string.splitToNumber(param, "#")

	for i, one in ipairs(episodeIds) do
		if one == episodeId then
			return true
		end
	end

	return false
end

function FightController:setPlayerPrefKeyAuto(episodeId, isAuto)
	if not episodeId then
		return
	end

	local key = PlayerPrefsKey.FightAutoEpsodeIds .. PlayerModel.instance:getPlayinfo().userId
	local param = PlayerPrefsHelper.getString(key, "")

	if string.nilorempty(param) then
		if isAuto then
			param = tostring(episodeId)

			PlayerPrefsHelper.setString(key, param)
		end

		return
	end

	local has = false
	local episodeIds = string.splitToNumber(param, "#")

	for i, one in ipairs(episodeIds) do
		if one == episodeId then
			has = true
		end
	end

	if not has and isAuto then
		param = table.concat({
			param,
			"#",
			tostring(episodeId)
		})

		PlayerPrefsHelper.setString(key, param)

		return
	end

	if has and not isAuto then
		local deletedEpisodeIds = {}

		for i, one in ipairs(episodeIds) do
			if one ~= episodeId then
				table.insert(deletedEpisodeIds, one)
			end
		end

		param = table.concat(deletedEpisodeIds, "#")

		PlayerPrefsHelper.setString(key, param)

		return
	end
end

function FightController:checkFightQuitTipViewClose()
	if ViewMgr.instance:isOpen(ViewName.FightQuitTipView) then
		ViewMgr.instance:closeView(ViewName.FightQuitTipView, nil)
	end

	SeasonFightHandler.closeSeasonFightRuleTipView()
end

function FightController:openFightSpecialTipView(isBefore)
	if not isBefore then
		local fightParam = FightModel.instance:getFightParam()

		if fightParam then
			local episodeId = fightParam.episodeId
			local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
			local episodeType = episodeConfig and episodeConfig.type
			local isSeasonFightRuleTip = SeasonFightHandler.openSeasonFightRuleTipView(episodeType)

			if isSeasonFightRuleTip then
				return
			end
		end
	end

	ViewMgr.instance:openView(ViewName.FightSpecialTipView)
end

function FightController:openFightTechniqueView()
	ViewMgr.instance:openView(ViewName.FightTechniqueView)
end

function FightController:_recordFreeTicket()
	local fightParam = FightModel.instance:getFightParam()
	local episodeId = fightParam and fightParam.episodeId
	local episodeCO = episodeId and lua_episode.configDict[episodeId]

	if not episodeCO then
		return
	end

	local chapterConfig = DungeonConfig.instance:getChapterCO(episodeCO.chapterId)

	self.TEMP_equip_chapter_free_count = nil

	if chapterConfig.type == DungeonEnum.ChapterType.Equip then
		self.TEMP_equip_chapter_free_count = DungeonModel.instance:getChapterRemainingNum(chapterConfig.type)
	end
end

function FightController.onResultViewClose()
	local breakInfo = {}

	FightController.instance:dispatchEvent(FightEvent.OnBreakResultViewClose, breakInfo)

	if breakInfo.isBreak then
		return
	end

	FightController.instance:dispatchEvent(FightEvent.OnResultViewClose)
end

function FightController:errorAndEnterMainScene()
	DungeonModel.instance.curSendEpisodeId = nil

	self:clearFightData()
	MainController.instance:enterMainScene(true)
end

function FightController:clearFightData()
	FightModel.instance.needFightReconnect = false

	FightModel.instance:onEndFight()
	FightSystem.instance:dispose()
	FightModel.instance:clearRecordMO()
end

FightController.instance = FightController.New()

return FightController
