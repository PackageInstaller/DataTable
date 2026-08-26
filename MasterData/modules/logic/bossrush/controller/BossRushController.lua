-- chunkname: @modules/logic/bossrush/controller/BossRushController.lua

module("modules.logic.bossrush.controller.BossRushController", package.seeall)

local BossRushController = class("BossRushController", BaseController)

function BossRushController:onInit()
	self._model = BossRushModel.instance
	self._redModel = BossRushRedModel.instance
	self._V3a2model = V3a2_BossRushModel.instance
end

function BossRushController:reInit()
	RedDotController.instance:unregisterCallback(RedDotEvent.RefreshClientCharacterDot, self._refreshClientCharacterDot, self)
	RedDotController.instance:registerCallback(RedDotEvent.RefreshClientCharacterDot, self._refreshClientCharacterDot, self)
end

function BossRushController:addConstEvents()
	FightController.instance:registerCallback(FightEvent.RespBeginFight, self._respBeginFight, self)
	FightController.instance:registerCallback(FightEvent.RespBeginRound, self._respBeginRound, self)
	FightController.instance:registerCallback(FightEvent.OnIndicatorChange, self._onIndicatorChange, self)
	FightController.instance:registerCallback(FightEvent.OnBeginWave, self._refreshCurBossHP, self)
	FightController.instance:registerCallback(FightEvent.OnHpChange, self._onHpChange, self)
	FightController.instance:registerCallback(FightEvent.OnMonsterChange, self._onMonsterChange, self)
	LoginController.instance:registerCallback(LoginEvent.OnGetInfoFinish, self._onGetInfoFinish, self)
	RedDotController.instance:registerCallback(RedDotEvent.RefreshClientCharacterDot, self._refreshClientCharacterDot, self)
	DungeonController.instance:registerCallback(DungeonEvent.OnEndDungeonPush, self._onEndDungeonPush, self)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, self._refreshActivityState, self)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, self._updateRelateDotInfo, self)
end

function BossRushController:enterFightScene(stage, layer, actId)
	self._model:setBattleStageAndLayer(stage, layer, actId)

	local dungeonEpisodeCO = BossRushConfig.instance:getDungeonEpisodeCO(stage, layer, actId)
	local episodeId = dungeonEpisodeCO.id
	local chapterId = dungeonEpisodeCO.chapterId
	local battleId = dungeonEpisodeCO.battleId
	local fightParam = FightController.instance:setFightParamByBattleId(battleId)

	fightParam.chapterId = BossRushConfig.instance:isInfinite(stage, layer) and DungeonEnum.ChapterType.BossRushInfinite or DungeonEnum.ChapterType.BossRushNormal
	fightParam.episodeId = episodeId
	fightParam.chapterId = chapterId
	FightResultModel.instance.episodeId = episodeId

	DungeonModel.instance:SetSendChapterEpisodeId(chapterId, episodeId)
	fightParam:setPreload()
	FightController.instance:enterFightScene()
end

function BossRushController:openMainView(viewParam, isJustOpen)
	if isJustOpen then
		ViewMgr.instance:openView(ViewName.V1a4_BossRushMainView, viewParam)

		return
	end

	if not self._model:isActOnLine() then
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)

		return
	end

	if viewParam then
		local stage = viewParam.stage
		local layer = viewParam.layer

		if stage and not self._model:isBossOnline(stage) then
			GameFacade.showToast(ToastEnum.V1a4_BossRushBossLockTip)

			return
		end

		if layer and not self._model:isBossLayerOpen(stage, layer) then
			GameFacade.showToast(ToastEnum.V1a4_BossRushLayerLockTip)
		end
	end

	BossRushRpc.instance:sendGet128InfosRequest(function()
		ViewMgr.instance:openView(ViewName.V1a4_BossRushMainView, viewParam)
	end)
end

function BossRushController:openLevelDetailView(viewParam, isOpenMain)
	local stage = viewParam.stage
	local layer = viewParam.layer

	if not self._model:isBossOnline(stage) then
		GameFacade.showToast(ToastEnum.V1a4_BossRushBossLockTip)

		return
	end

	if not self._model:isBossOpen(stage) then
		local actName, episode = self._model:getBossUnlockEpisode(stage)

		GameFacade.showToast(ToastEnum.ActivityDungeon, actName, episode)

		return
	end

	viewParam.stageCO = viewParam.stageCO or BossRushConfig.instance:getStageCO(stage)

	if isOpenMain then
		self:openMainView(nil, true)
	end

	if layer then
		viewParam.selectedIndex = self._model:layer2Index(stage, layer)
	end

	ViewMgr.instance:openView(ViewName.V1a4_BossRushLevelDetail, viewParam)
end

function BossRushController:sendGetTaskInfoRequest(callback, callbackObj)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity128
	}, callback, callbackObj)
end

function BossRushController:_refreshClientCharacterDot()
	if not self._redModel:isInitReady() then
		return
	end

	RedDotController.instance:unregisterCallback(RedDotEvent.RefreshClientCharacterDot, self._refreshClientCharacterDot, self)
	self._redModel:refreshClientCharacterDot()
end

function BossRushController:_updateRelateDotInfo(dict)
	self._redModel:updateRelateDotInfo(dict)
end

function BossRushController:_refreshActivityState(actId)
	local activityId = self._model:getActivityId()

	if actId ~= activityId then
		return
	end

	local isOnline = ActivityModel.instance:isActOnLine(actId)

	self._redModel:setIsOpenActivity(isOnline)
end

function BossRushController:_onEndDungeonPush()
	if not FightResultModel.instance.firstPass then
		return
	end

	local episodeId = FightResultModel.instance.episodeId
	local stage, layer = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(episodeId)

	if not stage then
		return
	end

	local nextLayer = BossRushConfig.instance:tryGetStageNextLayer(stage, layer)

	if not nextLayer then
		return
	end

	local isOpen = self._model:isBossLayerOpen(stage, nextLayer)

	if not isOpen then
		return
	end

	self._redModel:setIsNewUnlockStageLayer(stage, nextLayer, true)
end

function BossRushController:openVersionActivityEnterViewIfNotOpened()
	if not ViewMgr.instance:isOpen(ViewName.VersionActivity1_5EnterView) then
		VersionActivity1_5EnterController.instance:directOpenVersionActivityEnterView()
	end
end

function BossRushController:openBonusView(viewParam)
	V1a6_BossRush_BonusModel.instance:setTab(BossRushEnum.BonusViewTab.AchievementTab)

	local function func()
		ViewMgr.instance:openView(ViewName.V1a6_BossRush_BonusView, viewParam)
	end

	BossRushController.instance:sendGetTaskInfoRequest(func, self)
end

function BossRushController:_respBeginFight()
	if not self:isInBossRushFight() then
		return
	end

	local monsterGroupId = FightModel.instance:getCurMonsterGroupId()

	if not monsterGroupId then
		return
	end

	local bossId = BossRushConfig.instance:getMonsterGroupBossId(monsterGroupId)

	self._temp11235 = 0

	self._model:setFightScore(0)
	self._model:clearStageScore()

	if string.nilorempty(bossId) then
		self._model:setBossIdList(nil)
	else
		local bossIds = string.splitToNumber(bossId, "#")

		self._model:setBossIdList(bossIds)
		self._model:setBossBloodCount(self._model:getBossBloodMaxCount())
	end

	self:_refreshCurBossHP()
end

function BossRushController:_respBeginRound()
	return
end

function BossRushController:_onIndicatorChange(id)
	local E = FightEnum.IndicatorId

	if E.V1a4_BossRush_ig_ScoreTips == id then
		local num = FightDataHelper.fieldMgr:getIndicatorNum(id)

		self._temp11235 = (self._temp11235 or 0) + num

		self._model:noticeFightScore(self._temp11235)
		self._model:setFightScore(self._temp11235)
	elseif E.BossInfiniteHPCount == id then
		local num = FightDataHelper.fieldMgr:getIndicatorNum(id)

		self._model:setInfiniteBossDeadSum(num)
	end
end

function BossRushController:_refreshCurBossHP()
	local bossEntityMo = self._model:getBossEntityMO()

	if not bossEntityMo then
		return
	end

	self._model:setBossCurHP(bossEntityMo.currentHp)
end

function BossRushController:_onHpChange(entity)
	if not entity then
		return
	end

	local bossEntityMo = self._model:getBossEntityMO()

	if not bossEntityMo then
		return
	end

	local entityMo = entity:getMO()

	if bossEntityMo.id ~= entityMo.id then
		return
	end

	self._model:setBossCurHP(bossEntityMo.currentHp)
end

function BossRushController:_onMonsterChange(oldEntityMO, newEntityMO)
	self._model:subBossBlood()
end

function BossRushController:_onGetInfoFinish()
	self:_recordBossRushCurrencyNum()
end

function BossRushController:_recordBossRushCurrencyNum()
	local propertyId = PlayerEnum.SimpleProperty.V2a7_BossRushCurrencyNum
	local oldCurrencyNum = PlayerModel.instance:getSimpleProperty(propertyId)

	if not oldCurrencyNum then
		oldCurrencyNum = V1a6_BossRush_StoreModel.instance:getCurrencyCount()

		PlayerModel.instance:forceSetSimpleProperty(propertyId, tostring(oldCurrencyNum))
		PlayerRpc.instance:sendSetSimplePropertyRequest(propertyId, tostring(oldCurrencyNum))
	end
end

function BossRushController:checkBattleChapterType(isNeedCheckScene, eChapterType)
	if isNeedCheckScene and GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight then
		return false
	end

	local chapterId = DungeonModel.instance.curSendChapterId

	if not chapterId then
		return false
	end

	local chapterCO = DungeonConfig.instance:getChapterCO(chapterId)

	if not chapterCO then
		return false
	end

	return chapterCO.type == eChapterType
end

function BossRushController:isInBossRushInfiniteFight(isNeedCheckScene)
	return self:checkBattleChapterType(isNeedCheckScene, DungeonEnum.ChapterType.BossRushInfinite)
end

function BossRushController:isInBossRushNormalFight(isNeedCheckScene)
	return self:checkBattleChapterType(isNeedCheckScene, DungeonEnum.ChapterType.BossRushNormal)
end

function BossRushController:isInV3a2BossRushFight(isNeedCheckScene)
	return self:checkBattleChapterType(isNeedCheckScene, DungeonEnum.ChapterType.V3a2BossRush)
end

function BossRushController:isInBossRushFight(isNeedCheckScene)
	return self:isInBossRushNormalFight(isNeedCheckScene) or self:isInBossRushInfiniteFight(isNeedCheckScene) or self:isInV3a2BossRushFight(isNeedCheckScene)
end

function BossRushController:isInBossRushDungeon()
	local episodeId = DungeonModel.instance.curSendEpisodeId

	if not episodeId then
		return false
	end

	local episodeCO = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeCO then
		return false
	end

	local chapterId = episodeCO.chapterId
	local chapterCO = DungeonConfig.instance:getChapterCO(chapterId)

	if not chapterCO then
		return false
	end

	local e = chapterCO.type
	local E = DungeonEnum.ChapterType

	if e == E.BossRushInfinite or e == E.BossRushNormal or e == E.V3a2BossRush then
		return true
	end

	return false
end

function BossRushController:openBossRushStoreView(actId)
	StoreRpc.instance:sendGetStoreInfosRequest(StoreEnum.BossRushStore, function()
		local viewParam = {
			actId = actId
		}

		ViewMgr.instance:openView(ViewName.V1a6_BossRush_StoreView, viewParam)
	end, self)
end

function BossRushController:openResultPanel(param)
	ViewMgr.instance:openView(ViewName.V3a2_BossRush_ResultPanel, param)
end

function BossRushController:openBossRushOfferRoleView()
	local viewParam = {
		actId = BossRushConfig.instance:getActivityId()
	}

	ViewMgr.instance:openView(ViewName.V2a1_BossRush_OfferRoleView, viewParam)
end

function BossRushController:getGroupFightViewName(episodeId)
	if V2a9BossRushModel.instance:isV2a9BossRush() then
		local bossrushCo = BossRushConfig.instance:getEpisodeCoByEpisodeId(episodeId)

		if bossrushCo and bossrushCo.layer == BossRushEnum.LayerEnum.V2a9 then
			if bossrushCo.stage == BossRushEnum.V2a9StageEnum.First then
				return ViewName.V2a9_BossRushHeroGroupFightView
			else
				return ViewName.OdysseyHeroGroupView
			end
		end
	end
end

function BossRushController:openV2a9BossRushSkillBackpackView(itemType)
	if itemType then
		local moList = V2a9BossRushSkillBackpackListModel.instance:getList()

		if moList then
			for _, mo in ipairs(moList) do
				if mo.itemType == itemType then
					V2a9BossRushModel.instance:selectSpItemId(mo.id)
				end
			end
		end
	end

	self:_reallyOpenV2a9BossRushSkillBackpackView()
end

function BossRushController:_reallyOpenV2a9BossRushSkillBackpackView()
	local list = AssassinBackpackListModel.instance:getList()

	if not list or #list <= 0 then
		GameFacade.showToast(ToastEnum.AssassinStealthNoItem)

		return
	end

	ViewMgr.instance:openView(ViewName.V2a9_BossRushSkillBackpackView)
end

function BossRushController:openV3a2MainView(viewParam, isJustOpen)
	if isJustOpen then
		ViewMgr.instance:openView(ViewName.V3a2_BossRush_MainView, viewParam)

		return
	end

	if not self._model:isActOnLine() then
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)

		return
	end

	if viewParam then
		local stage = viewParam.stage

		if stage and not self._model:isBossOnline(stage) then
			GameFacade.showToast(ToastEnum.V1a4_BossRushBossLockTip)

			return
		end
	end

	BossRushRpc.instance:sendGet128InfosRequest(function()
		ViewMgr.instance:openView(ViewName.V3a2_BossRush_MainView, viewParam)
	end)
end

function BossRushController:openV3a2LevelDetailView(viewParam, isOpenMain)
	local stage = viewParam.stage

	if not self._model:isBossOnline(stage) then
		GameFacade.showToast(ToastEnum.V1a4_BossRushBossLockTip)

		return
	end

	if not self._model:isBossOpen(stage) then
		local actName, episode = self._V3a2model:getBossUnlockEpisode(stage)

		GameFacade.showToast(ToastEnum.ActivityDungeon, actName, episode)

		return
	end

	viewParam.stageCO = viewParam.stageCO or BossRushConfig.instance:getStageCO(stage)

	if isOpenMain then
		self:openV3a2MainView(nil, true)
	end

	ViewMgr.instance:openView(ViewName.V3a2_BossRush_LevelDetailView, viewParam)
end

function BossRushController:openV3a2HankBookView()
	local actId = BossRushConfig.instance:getActivityId()

	BossRushRpc.instance:sendGetGalleryInfosRequest(actId, function()
		ViewMgr.instance:openView(ViewName.V3a2_BossRush_HandBookView)
	end)
end

function BossRushController:openV3a2RankView()
	ViewMgr.instance:openView(ViewName.V3a2_BossRush_RankView)
end

BossRushController.instance = BossRushController.New()

return BossRushController
