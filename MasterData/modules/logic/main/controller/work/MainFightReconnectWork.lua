-- chunkname: @modules/logic/main/controller/work/MainFightReconnectWork.lua

module("modules.logic.main.controller.work.MainFightReconnectWork", package.seeall)

local MainFightReconnectWork = class("MainFightReconnectWork", BaseWork)

function MainFightReconnectWork:onStart(context)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main or GameSceneMgr.instance:isClosing() then
		FightModel.instance.needFightReconnect = false

		self:onDone(true)

		return
	end

	if FightModel.instance.needFightReconnect then
		if FightDataHelper.fieldMgr:is191DouQuQu() then
			local actId = Activity191Controller.instance:getActId()

			Activity191Rpc.instance:sendGetAct191InfoRequest(actId)
		end

		local fightReason = FightModel.instance:getFightReason()

		if fightReason.type == FightEnum.FightReason.None then
			FightRpc.instance:sendEndFightRequest(false)
			self:onDone(true)
		elseif fightReason.type == FightEnum.FightReason.Dungeon then
			local this = self

			GameFacade.showMessageBox(MessageBoxIdDefine.FightSureToReconnect, MsgBoxEnum.BoxType.Yes_No, function()
				this:_onConfirm()
			end, function()
				this:_onCancel()
			end)
		elseif fightReason.type == FightEnum.FightReason.DungeonRecord then
			GameFacade.showMessageBox(MessageBoxIdDefine.FightSureToReconnect, MsgBoxEnum.BoxType.Yes_No, function()
				self:_onConfirm()
			end, function()
				self:_onCancel()
			end)
		else
			logError("reconnect type not implement: " .. ((not fightReason.type or nil) and "nil"))
			self:_onCancel()

			FightModel.instance.needFightReconnect = false
		end
	else
		self:onDone(true)
	end
end

function MainFightReconnectWork:_onConfirm()
	TaskDispatcher.runDelay(self._onDelayDone, self, 20)
	GameSceneMgr.instance:registerCallback(SceneType.Fight, self._onEnterFightScene, self)

	local fightReason = FightModel.instance:getFightReason()
	local episodeId = fightReason.episodeId

	DungeonModel.instance:SetSendChapterEpisodeId(nil, episodeId)

	local co = DungeonConfig.instance:getEpisodeCO(episodeId)

	if co.type == DungeonEnum.EpisodeType.TowerPermanent then
		local curPermanentMo = TowerModel.instance:getCurPermanentMo()

		if curPermanentMo then
			TowerPermanentModel.instance:setLocalPassLayer(curPermanentMo.passLayerId)
		end
	elseif co.type == DungeonEnum.EpisodeType.TowerLimited then
		local assistBossId = FightModel.instance.last_fightGroup.assistBossId
		local assistBossMO = TowerAssistBossModel.instance:getById(assistBossId)
		local bossLevel = tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BalanceBossLevel))

		if assistBossMO then
			assistBossMO:setTempState(bossLevel > assistBossMO.level)
		end

		TowerAssistBossModel.instance:getTempUnlockTrialBossMO(assistBossId)
	elseif co.type == DungeonEnum.EpisodeType.Assassin2Outside or co.type == DungeonEnum.EpisodeType.Assassin2Stealth then
		AssassinController.instance:getAssassinOutsideInfo()

		if co.type == DungeonEnum.EpisodeType.Assassin2Outside then
			local fightQuestId = AssassinConfig.instance:getFightQuestId(episodeId)

			AssassinOutsideModel.instance:setEnterFightQuest(fightQuestId)
		end
	end

	if DungeonConfig.instance:isLeiMiTeBeiChapterType(co) then
		local isReplay = fightReason.type == FightEnum.FightReason.DungeonRecord

		FightController.instance:setFightParamByEpisodeId(episodeId, isReplay, fightReason.multiplication)
	elseif co.type == DungeonEnum.EpisodeType.WeekWalk then
		WeekWalkModel.instance:setCurMapId(fightReason.layerId)
		WeekWalkModel.instance:setBattleElementId(fightReason.elementId)
		FightController.instance:setFightParamByEpisodeBattleId(episodeId, FightModel.instance:getBattleId())
	elseif co.type == DungeonEnum.EpisodeType.WeekWalk_2 then
		WeekWalk_2Model.instance:setCurMapId(fightReason.layerId)
		WeekWalk_2Model.instance:setBattleElementId(fightReason.elementId)
		FightController.instance:setFightParamByEpisodeBattleId(episodeId, FightModel.instance:getBattleId())
	elseif co.type == DungeonEnum.EpisodeType.Meilanni then
		FightController.instance:setFightParamByEpisodeBattleId(episodeId, FightModel.instance:getBattleId())

		local eventEpisodeId = fightReason.eventEpisodeId
		local episodeConfg = eventEpisodeId and lua_activity108_episode.configDict[eventEpisodeId]
		local mapId = episodeConfg and episodeConfg.mapId

		MeilanniModel.instance:setCurMapId(mapId)
		Activity108Rpc.instance:sendGet108InfosRequest(MeilanniEnum.activityId)
	elseif co.type == DungeonEnum.EpisodeType.Dog then
		FightController.instance:setFightParamByEpisodeBattleId(fightReason.episodeId, fightReason.battleId)
	elseif co.type == DungeonEnum.EpisodeType.YaXian then
		FightController.instance:setFightParamByEpisodeBattleId(YaXianGameEnum.EpisodeId, FightModel.instance:getBattleId())
	elseif co.type == DungeonEnum.EpisodeType.Survival or co.type == DungeonEnum.EpisodeType.Shelter then
		SurvivalController.instance:tryEnterSurvivalFight(self._enterFightScene, self)

		return
	elseif co.type == DungeonEnum.EpisodeType.TowerDeep or co.type == DungeonEnum.EpisodeType.TowerCompose then
		FightController.instance:setFightParamByEpisodeId(episodeId, false, 1, fightReason.battleId)
		HeroGroupModel.instance:setBattleAndEpisodeId(fightReason.battleId, episodeId)
		HeroGroupTrialModel.instance:setTrialByBattleId()
		HeroGroupModel.instance:setParam(fightReason.battleId, episodeId, false, true)
	elseif co.type == DungeonEnum.EpisodeType.AtomicDungeon then
		AtomicRpc.instance:sendAtomicGetInfoRequest()
	else
		local isSeasonType = SeasonHeroGroupHandler.checkIsSeasonTypeByEpisodeId(episodeId)

		if isSeasonType then
			SeasonFightHandler.checkProcessFightReconnect(fightReason)
		else
			local isReplay = fightReason.type == FightEnum.FightReason.DungeonRecord
			local multiplication = fightReason.multiplication

			multiplication = multiplication and multiplication > 0 and multiplication or 1

			FightController.instance:setFightParamByEpisodeId(episodeId, isReplay, multiplication, fightReason.battleId)
			HeroGroupModel.instance:setParam(fightReason.battleId, episodeId, false, true)
		end
	end

	self:_enterFightScene()
end

function MainFightReconnectWork:_enterFightScene()
	FightModel.instance:updateMySide(FightModel.instance.last_fightGroup)
	FightController.instance:enterFightScene()
end

function MainFightReconnectWork:_onCancel()
	DungeonFightController.instance:sendEndFightRequest(true)
	FightModel.instance:clear()
	FightDataHelper.initDataMgr()
	self:onDone(true)
end

function MainFightReconnectWork:_onEnterFightScene()
	self:removeEnterFightListener()
	TaskDispatcher.runRepeat(self._onCheckEnterMainView, self, 0.5)
end

function MainFightReconnectWork:_onCheckEnterMainView()
	local isInMainView = MainController.instance:isInMainView()

	if not isInMainView then
		return
	end

	if GuideModel.instance:isDoingClickGuide() and not GuideController.instance:isForbidGuides() then
		return
	end

	if GuideController.instance:isGuiding() then
		return
	end

	if not ViewMgr.instance:hasOpenFullView() and ViewMgr.instance:isOpen(ViewName.MainView) then
		TaskDispatcher.cancelTask(self._onCheckEnterMainView, self)
		self:onDone(true)
	end
end

function MainFightReconnectWork:_onDelayDone()
	logError("战斗重连超时，打开下一个Popup")
	self:onDone(true)
end

function MainFightReconnectWork:clearWork()
	self:removeEnterFightListener()
	TaskDispatcher.cancelTask(self._onCheckEnterMainView, self)
end

function MainFightReconnectWork:removeEnterFightListener()
	TaskDispatcher.cancelTask(self._onDelayDone, self)
	GameSceneMgr.instance:unregisterCallback(SceneType.Fight, self._onEnterFightScene, self)
end

return MainFightReconnectWork
