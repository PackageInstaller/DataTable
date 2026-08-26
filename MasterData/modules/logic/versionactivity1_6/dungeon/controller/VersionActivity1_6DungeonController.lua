-- chunkname: @modules/logic/versionactivity1_6/dungeon/controller/VersionActivity1_6DungeonController.lua

module("modules.logic.versionactivity1_6.dungeon.controller.VersionActivity1_6DungeonController", package.seeall)

local VersionActivity1_6DungeonController = class("VersionActivity1_6DungeonController", BaseController)

function VersionActivity1_6DungeonController:onInit()
	self._bossModel = VersionActivity1_6DungeonBossModel.instance
end

function VersionActivity1_6DungeonController:reInit()
	self._bossModel = VersionActivity1_6DungeonBossModel.instance

	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenMapViewDone, self)
end

function VersionActivity1_6DungeonController:addConstEvents()
	self.addEventCb(self, FightController.instance, FightEvent.RespBeginFight, self._respBeginFight, self)
	self.addEventCb(self, FightController.instance, FightEvent.RespBeginRound, self._respBeginRound, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnIndicatorChange, self._onIndicatorChange, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
end

function VersionActivity1_6DungeonController:_respBeginFight()
	self._tempScore = 0

	self._bossModel:setFightScore(0)
end

function VersionActivity1_6DungeonController:_respBeginRound()
	local roundData = FightDataHelper.roundMgr:getRoundData()

	if not roundData then
		return
	end

	local fightStepList = roundData.fightStep

	if not fightStepList or not next(fightStepList) then
		return
	end

	local eAddIndicator = FightWorkIndicatorChange.ConfigEffect.AddIndicator
	local eINDICATORCHANGE = FightEnum.EffectType.INDICATORCHANGE
	local BossIndicatorId = FightEnum.IndicatorId.Act1_6DungeonBoss
	local score = 0

	for stepIndex = #fightStepList, 1, -1 do
		local stepData = fightStepList[stepIndex]

		if not stepData.actEffect then
			local actEffect = {}

			for i = #actEffect, 1, -1 do
				local actEffectMO = actEffect[i]
				local effectType = actEffectMO.effectType
				local indicatorId = tonumber(actEffectMO.targetId)
				local configEffect = actEffectMO.configEffect

				if effectType == eINDICATORCHANGE and indicatorId == BossIndicatorId and configEffect == eAddIndicator then
					score = math.max(score, actEffectMO.effectNum)
				end
			end
		end
	end

	if score > 0 then
		self._bossModel:setFightScore(score)
	end
end

function VersionActivity1_6DungeonController:_onIndicatorChange(id)
	if id == FightEnum.IndicatorId.Act1_6DungeonBoss then
		local num = FightDataHelper.fieldMgr:getIndicatorNum(id)

		self._tempScore = math.max(self._tempScore, num)

		self._bossModel:noticeFightScore(self._tempScore)
	end
end

function VersionActivity1_6DungeonController:_onEndDungeonPush(id)
	if not FightResultModel.instance.firstPass then
		return
	end

	local episodeId = FightResultModel.instance.episodeId
	local maxOrderBossMo = self._bossModel:getMaxOrderMo()

	if maxOrderBossMo.cfg.episodeId == episodeId then
		-- block empty
	end
end

function VersionActivity1_6DungeonController:openActivityDungeonMapViewDirectly()
	ViewMgr.instance:openView(ViewName.VersionActivity1_6DungeonMapView, self.openViewParam)
end

function VersionActivity1_6DungeonController:getEpisodeMapConfig(episodeId)
	local episodeCo = self:getStoryEpisodeCo(episodeId)

	return DungeonConfig.instance:getChapterMapCfg(VersionActivity1_6DungeonEnum.DungeonChapterId.Story, episodeCo.preEpisode)
end

function VersionActivity1_6DungeonController:getEpisodeIndex(episodeId)
	local episodeConfig = self:getStoryEpisodeCo(episodeId)

	return DungeonConfig.instance:getChapterEpisodeIndexWithSP(episodeConfig.chapterId, episodeConfig.id)
end

function VersionActivity1_6DungeonController:getStoryEpisodeCo(episodeId)
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if episodeConfig.chapterId == VersionActivity1_6DungeonEnum.DungeonChapterId.Hard then
		episodeId = episodeId - 10000
		episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
	else
		while episodeConfig.chapterId ~= VersionActivity1_6DungeonEnum.DungeonChapterId.Story do
			episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeConfig.preEpisode)
		end
	end

	return episodeConfig
end

function VersionActivity1_6DungeonController:enterBossFightScene(id)
	local dungeonEpisodeCO = Activity149Config.instance:getDungeonEpisodeCfg(id)
	local episodeId = dungeonEpisodeCO.id
	local chapterId = dungeonEpisodeCO.chapterId
	local battleId = dungeonEpisodeCO.battleId
	local fightParam = FightController.instance:setFightParamByBattleId(battleId)

	fightParam.episodeId = episodeId
	fightParam.chapterId = chapterId
	FightResultModel.instance.episodeId = episodeId

	DungeonModel.instance:SetSendChapterEpisodeId(chapterId, episodeId)
	fightParam:setPreload()
	FightController.instance:enterFightScene()
end

function VersionActivity1_6DungeonController:openVersionActivityDungeonMapView(chapterId, episodeId, callback, callbackObj)
	self.openViewParam = {
		chapterId = chapterId,
		episodeId = episodeId
	}
	self.openMapViewCallback = callback
	self.openMapViewCallbackObj = callbackObj
	self.receiveTaskReply = nil
	self.waitAct148InfoReply = true

	VersionActivity1_6DungeonModel.instance:init()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityDungeon
	}, self._onReceiveTaskReply, self)
	Activity113Rpc.instance:sendGetAct113InfoRequest(VersionActivity1_6Enum.ActivityId.Dungeon)

	local isAct148Unlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_60101)

	if isAct148Unlock then
		VersionActivity1_6DungeonRpc.instance:sendGet148InfoRequest(self._onReceiveAct148InfoReply, self)
	else
		self.waitAct148InfoReply = false
	end
end

function VersionActivity1_6DungeonController:_onReceiveTaskReply()
	self.receiveTaskReply = true

	self:_openVersionActivityDungeonMapView()
end

function VersionActivity1_6DungeonController:_onReceiveAct148InfoReply()
	self.waitAct148InfoReply = false

	self:_openVersionActivityDungeonMapView()
end

function VersionActivity1_6DungeonController:_openVersionActivityDungeonMapView()
	if not self.receiveTaskReply or self.waitAct148InfoReply then
		return
	end

	self.receiveTaskReply = nil

	if self.openMapViewCallback then
		self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenMapViewDone, self)
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_6DungeonMapView, self.openViewParam)
end

function VersionActivity1_6DungeonController:_onOpenMapViewDone(viewName)
	if viewName == ViewName.VersionActivity1_6DungeonMapView then
		self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenMapViewDone, self)

		if self.openMapViewCallback then
			-- block empty
		end
	end
end

function VersionActivity1_6DungeonController:openTaskView()
	ViewMgr.instance:openView(ViewName.VersionActivity1_6TaskView)
end

function VersionActivity1_6DungeonController:openSkillView()
	VersionActivity1_6DungeonRpc.instance:sendGet148InfoRequest(self._openSkillViewImpl, self)
end

function VersionActivity1_6DungeonController:_openSkillViewImpl()
	ViewMgr.instance:openView(ViewName.VersionActivity1_6SkillView)
end

function VersionActivity1_6DungeonController:openSkillLvUpView(skillTypeId)
	local viewParam = {
		skillType = skillTypeId
	}

	ViewMgr.instance:openView(ViewName.VersionActivity1_6SkillLvUpView, viewParam)
end

function VersionActivity1_6DungeonController:openResultPanel(skillTypeId)
	ViewMgr.instance:openView(ViewName.VersionActivity1_6BossFightSuccView)
end

function VersionActivity1_6DungeonController:openDungeonBossView(focusToPreEpisode)
	local isAct149Unlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_60102)

	if not isAct149Unlock then
		local toastId, toastParamList = OpenHelper.getToastIdAndParam(OpenEnum.UnlockFunc.Act_60102)

		GameFacade.showToastWithTableParam(toastId, toastParamList)

		return
	end

	self._openBossViewParam = {
		toPreEpisode = focusToPreEpisode
	}

	VersionActivity1_6DungeonRpc.instance:sendGet149InfoRequest(self._onReceiveAct149InfoReply, self)
end

function VersionActivity1_6DungeonController:_onReceiveAct149InfoReply()
	self:_afterDailyBonusOpenDungeonBossView()
end

function VersionActivity1_6DungeonController:_afterDailyBonusOpenDungeonBossView()
	self._openBossViewParam.showDailyBonus = VersionActivity1_6DungeonBossModel.instance:GetOpenBossViewWithDailyBonus()

	ViewMgr.instance:openView(ViewName.VersionActivity1_6DungeonBossView, self._openBossViewParam)
	VersionActivity1_6DungeonBossModel.instance:SetOpenBossViewWithDailyBonus(false)
end

function VersionActivity1_6DungeonController:_onCurrencyChange(changeIds)
	for _, currencyId in pairs(changeIds) do
		if currencyId == CurrencyEnum.CurrencyType.V1a6DungeonSkill then
			-- block empty
		end
	end
end

VersionActivity1_6DungeonController.instance = VersionActivity1_6DungeonController.New()

return VersionActivity1_6DungeonController
