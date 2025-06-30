-- chunkname: @IQIGame\\UI\\Settlement_BattleUI.lua

local Settlement_BattleUI = {}

Settlement_BattleUI = Base:Extend("Settlement_BattleUI", "IQIGame.Onigao.UI.Settlement_BattleUI", Settlement_BattleUI)

local SettlementLevelViewClass = require("IQIGame/UI/SettlementUI/SettlementLevelView")
local SettlementRewardViewClass = require("IQIGame/UI/SettlementUI/settlementRewardView")
local MultipleFightAwardViewClass = require("IQIGame/UI/SettlementUI/MultipleFightAwardView")
local SettlementFailedInfoViewClass = require("IQIGame/UI/SettlementUI/SettlementFailedInfoView")
local TaskItem = require("IQIGame/UI/SettlementUI/Settlement_BattleUI_TaskItem")
local favorItem = require("IQIGame/UI/SettlementUI/Settlement_BattleUI_FavorItem")
local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local CommonRoleDisplayView = require("IQIGame/UI/Common/CommonRoleDisplayView")
local CommonGlobalBuffView = require("IQIGame/UI/Common/GlobalBuff/CommonGlobalBuffView")
local dataName_win = "win"
local win_stateName_normal = "normal"
local win_stateName_score = "score"

function Settlement_BattleUI:OnInit()
	self:InitComponent()
	self:InitDelegate()
end

function Settlement_BattleUI:InitComponent()
	self.levelView = SettlementLevelViewClass.New(self.settlementLevelView, self)
	self.rewardView = SettlementRewardViewClass.New(self.settlementRewardView, self)
	self.multipleAwardView = MultipleFightAwardViewClass.New(self.multipleFightRewardRoot, self)
	self.failedItemArray = {}

	table.insert(self.failedItemArray, SettlementFailedInfoViewClass.New(self.jumpInfoPrefab, self))

	self.taskItemArray = {}

	table.insert(self.taskItemArray, TaskItem.New(self.taskItem, self))

	self.roleDisplayView = CommonRoleDisplayView.New(self.RoleDisplayViewRoot, Constant.DynamicSkinShowPosition.BattleResultUI)
	self.favorItemPool = UIViewObjectPool.New(self.favorPrefab, self.favorScroll.transform, function(_view)
		return favorItem.New(_view, self)
	end)
	self.buffView = CommonGlobalBuffView.New(self.buffParent)

	self.buffView:SetTipsEnable(false)
end

function Settlement_BattleUI:OnOpen(userData)
	Time.timeScale = 1
	self.settlementData = userData

	LuaCodeInterface.SetGameObjectShow(self.ContinueBtn, false)

	local isWin = self.settlementData.fightOverPOD.fightResult == Constant.FightResult.ATTACKER_WIN

	if self.settlementData.fightOverPOD.type == Constant.ChapterPassType.Type_ChallengeWorldBoss then
		isWin = true
	end

	self.BossTotalDamageRoot.gameObject:SetActive(false)

	local displayHeroCid = 0
	local cvHeroList = {}

	ForPairs(self.settlementData.fightOverPOD.units, function(k, attackUnitPOD)
		if attackUnitPOD.type ~= 1 then
			return
		end

		table.insert(cvHeroList, attackUnitPOD.val)
	end)
	math.randomseed(os.time())

	local randomIndex = math.random(1, #cvHeroList)

	displayHeroCid = cvHeroList[randomIndex]

	if displayHeroCid == nil then
		displayHeroCid = 0
	end

	if isWin then
		self:ShowWinPreview(displayHeroCid)
	else
		self:ShowFailedPreview(displayHeroCid)
	end

	self:RefreshFavorView(userData.fightOverPOD)
	self:RefreshGloableBuffView()

	if displayHeroCid == 0 then
		self.roleDisplayView:Hide()
	else
		local skinCfg = SkinModule.GetHeroCurrentSkinConfig(displayHeroCid)

		if skinCfg == nil then
			self.roleDisplayView:Hide()

			return
		end

		local displayViewData = {}

		displayViewData.disableClick = true

		if self.settlementData.fightOverPOD.fightResult == Constant.FightResult.ATTACKER_WIN then
			displayViewData.displayGroupAction = Constant.DynamicSkinDisplayActionType.BattleWin
		else
			displayViewData.displayGroupAction = Constant.DynamicSkinDisplayActionType.BattleLost
		end

		self.roleDisplayView:Show(skinCfg.Id, displayViewData)
	end
end

function Settlement_BattleUI:OnClose(userData)
	return
end

function Settlement_BattleUI:InitDelegate()
	function self.delegateOnClickButtonStatistics_win()
		UIModule.Open(Constant.UIControllerName.SettlementStatisticsUI, Constant.UILayer.UI, self.settlementData.fightOverPOD.units)
	end

	function self.delegateOnClickButtonStatistics_lose()
		UIModule.Open(Constant.UIControllerName.SettlementStatisticsUI, Constant.UILayer.UI, self.settlementData.fightOverPOD.units)
	end

	function self.delegateOnClickButtonAgain()
		self:OnClickButtonAgain()
	end

	function self.delegateOnClickButtonShowAward()
		self:OnClickButtonShowAward()
	end

	function self.delegateOnClickButtonClose()
		UIModule.CloseSelf(self)

		if self.settlementData.closeCallBack then
			self.settlementData.closeCallBack()

			self.settlementData.closeCallBack = nil
		end
	end

	function self.setStateControllerEvent(dataName, stateName)
		LuaUtility.SetStateController(self.gameObject, dataName, stateName)
	end
end

function Settlement_BattleUI:OnAddListeners()
	self.buttonStatistics_win:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonStatistics_win)
	self.buttonStatistics_lose:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonStatistics_lose)
	self.buttonAgain:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonAgain)
	self.buttonShowAward:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonShowAward)
	self.buttonClose:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonClose)
	EventDispatcher.AddEventListener(EventID.Settlement_BattleUIStateControllerEvent, self.setStateControllerEvent)
	UIEventUtil.AddClickEventListener_Button(self, "ContinueBtn", self.__OnContinueBtnClickEventHandler)
	UIEventUtil.AddClickEventListener_Button(self, "FailedCloseBtn", self.__OnFailedCloseBtnClickHandler)
end

function Settlement_BattleUI:OnRemoveListeners()
	self.buttonStatistics_win:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonStatistics_win)
	self.buttonStatistics_lose:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonStatistics_lose)
	self.buttonAgain:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonAgain)
	self.buttonShowAward:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonShowAward)
	self.buttonClose:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonClose)
	EventDispatcher.RemoveEventListener(EventID.Settlement_BattleUIStateControllerEvent, self.setStateControllerEvent)
	UIEventUtil.ClearEventListener(self)
end

function Settlement_BattleUI:OnClickButtonAgain()
	if GameChapterModule.CurSelectChapterCfg and GameChapterModule.CurSelectChapterCfg.PassCost[2] and GameChapterModule.CurSelectChapterCfg.PassCost[1] then
		local n = WarehouseModule.GetItemNumByCfgID(GameChapterModule.CurSelectChapterCfg.PassCost[1])

		if n < GameChapterModule.CurSelectChapterCfg.PassCost[2] then
			NoticeModule.ShowNotice(51015)

			return
		end
	end

	if not GameChapterModule.lastEnterChapterData then
		return
	end

	local arg = {}

	arg.fightAgainUserData = {}
	arg.fightAgainUserData.ChapterType = GameChapterModule.lastEnterChapterData.ChapterType
	arg.fightAgainUserData.PassId = GameChapterModule.lastEnterChapterData.PassId

	SceneTransferModule.BattleToMainCity(arg)
end

function Settlement_BattleUI:OnClickButtonShowAward()
	self.multipleAwardView:Refresh(self.settlementData.fightOverPOD.everyTimeAwards)
	self.multipleAwardView:Show()
end

function Settlement_BattleUI:GetPreloadAssetPaths()
	return nil
end

function Settlement_BattleUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function Settlement_BattleUI:IsManualShowOnOpen(userData)
	return false
end

function Settlement_BattleUI:GetBGM(userData)
	return nil
end

function Settlement_BattleUI:OnPause()
	return
end

function Settlement_BattleUI:OnResume()
	return
end

function Settlement_BattleUI:OnCover()
	return
end

function Settlement_BattleUI:OnReveal()
	return
end

function Settlement_BattleUI:OnRefocus(userData)
	return
end

function Settlement_BattleUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function Settlement_BattleUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function Settlement_BattleUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function Settlement_BattleUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function Settlement_BattleUI:ShowWinPreview(displayHeroCid)
	self.isMultipleFight = getTableLength(self.settlementData.fightOverPOD.everyTimeAwards) > 1

	LuaUtility.SetGameObjectShow(self.buttonAgain, not self.isMultipleFight)
	LuaUtility.SetGameObjectShow(self.buttonShowAward, self.isMultipleFight)
	LuaUtility.SetGameObjectShow(self.buttonClose, false)

	if self.isMultipleFight then
		LuaUtility.SetGameObjectShow(self.successPreviewRoot, false)
		LuaUtility.SetGameObjectShow(self.failedPreviewRoot, false)
		LuaUtility.SetGameObjectShow(self.successRoot, true)
		LuaUtility.SetGameObjectShow(self.failedRoot, false)
		self:RefreshWin(displayHeroCid)
	else
		LuaUtility.SetGameObjectShow(self.successPreviewRoot, true)
		LuaUtility.SetGameObjectShow(self.failedPreviewRoot, false)
		LuaUtility.SetGameObjectShow(self.successRoot, false)
		LuaUtility.SetGameObjectShow(self.failedRoot, false)
		LuaUtility.SetGameObjectShow(self.taskContent, false)

		if GameChapterModule.lastEnterChapterData and (GameChapterModule.lastEnterChapterData.ChapterType == Constant.ChapterPassType.TYPE_CLIMB_TOWER or GameChapterModule.lastEnterChapterData.ChapterType == Constant.ChapterPassType.TYPE_Challenge or GameChapterModule.lastEnterChapterData.ChapterType == Constant.ChapterPassType.TYPE_SummerActivity or GameChapterModule.lastEnterChapterData.ChapterType == Constant.ChapterPassType.TYPE_Ghost or GameChapterModule.lastEnterChapterData.ChapterType == Constant.ChapterPassType.Type_GhostBoss) then
			LuaUtility.SetGameObjectShow(self.buttonAgain, false)
		end

		if self.settlementData.fightOverPOD.allConditionIds and #self.settlementData.fightOverPOD.allConditionIds > 0 then
			LuaUtility.SetGameObjectShow(self.taskContent, true)

			local finishedSet = {}
			local len = #self.settlementData.fightOverPOD.finishConditionIds

			for i = 1, len do
				finishedSet[self.settlementData.fightOverPOD.finishConditionIds[i]] = self.settlementData.fightOverPOD.finishConditionIds[i]
			end

			len = #self.settlementData.fightOverPOD.allConditionIds

			local index = 1

			for i = 1, len do
				local cell = self:_GetTaskItem(i)

				cell:Refresh(self.settlementData.fightOverPOD.allConditionIds[i])

				if finishedSet[self.settlementData.fightOverPOD.allConditionIds[i]] then
					cell:SetCompleteState()
				end

				cell:Show()

				index = index + 1
			end

			for i = index, #self.taskItemArray do
				self.taskItemArray[i]:Hide()
			end
		end

		self:StopCoWin()

		if self.settlementData.fightOverPOD.type == Constant.ChapterPassType.Type_GhostBoss then
			coroutine.start(function()
				coroutine.wait(1.5)
				LuaUtility.SetGameObjectShow(self.successPreviewRoot, false)
				self:RefreshScore(displayHeroCid)
				LuaUtility.SetGameObjectShow(self.successRoot, true)
			end)
		else
			coroutine.start(function()
				coroutine.wait(1.5)
				LuaUtility.SetGameObjectShow(self.successPreviewRoot, false)
				self:RefreshWin(displayHeroCid)
				LuaUtility.SetGameObjectShow(self.successRoot, true)
			end)
		end
	end
end

function Settlement_BattleUI:ShowFailedPreview(displayHeroCid)
	LuaUtility.SetGameObjectShow(self.failedPreviewRoot, true)
	LuaUtility.SetGameObjectShow(self.successPreviewRoot, false)
	LuaUtility.SetGameObjectShow(self.successRoot, false)
	LuaUtility.SetGameObjectShow(self.failedRoot, false)
	LuaUtility.SetGameObjectShow(self.buttonClose, false)
	self:StopCoFailed()

	if self.settlementData.fightOverPOD.type == Constant.ChapterPassType.Type_GhostBoss then
		coroutine.start(function()
			coroutine.wait(1.5)
			LuaUtility.SetGameObjectShow(self.failedPreviewRoot, false)
			self:RefreshScore(displayHeroCid)
			LuaUtility.SetGameObjectShow(self.successRoot, true)
		end)
	else
		coroutine.start(function()
			coroutine.wait(1.5)
			LuaUtility.SetGameObjectShow(self.failedPreviewRoot, false)
			self:RefreshFailed(displayHeroCid)
			LuaUtility.SetGameObjectShow(self.failedRoot, true)
		end)
	end
end

function Settlement_BattleUI:RefreshWin(displayHeroCid)
	LuaUtility.SetStateController(self.gameObject, dataName_win, win_stateName_normal)
	LuaUtility.SetGameObjectShow(self.buttonClose, true)

	local itemShowList, upExp = ItemModule.ExcludeExpItem_CountExp(self.settlementData.fightOverPOD.awards)

	if self.settlementData.fightOverPOD.type == Constant.ChapterPassType.Type_ChallengeWorldBoss then
		self.settlementLevelView.gameObject:SetActive(false)
		self.BossTotalDamageRoot.gameObject:SetActive(true)

		local stageCfg = CfgWorldBossStageTable[ChallengeWorldBossModule.CacheFightingData.stageCid]

		self.BossNameText:GetComponent("Text").text = BattleUIApi:GetChallengeWorldBossNameText(stageCfg.BossLevel, stageCfg.Describe)
		self.TotalDamageText:GetComponent("Text").text = ChallengeWorldBossModule.CacheFightingData.totalDamage
	else
		self.BossTotalDamageRoot.gameObject:SetActive(false)
		self.settlementLevelView.gameObject:SetActive(true)
		self.levelView:Refresh(upExp)
	end

	itemShowList = ItemModule.ItemShowListSort(itemShowList)

	self.rewardView:Refresh(itemShowList)

	if displayHeroCid == 0 then
		CVModule.PlayFightOverCVWithAttackUnit(Constant.CVActionType.FightSuccess, self.settlementData.fightOverPOD.units)
	else
		CVModule.PlayFightOverCVWithAttackHeroCid(Constant.CVActionType.FightSuccess, displayHeroCid)
	end

	if not GameChapterModule.CurSelectChapterCfg then
		LuaUtility.SetGameObjectShow(self.imageCost, false)

		return
	end

	local dupPOD

	if GameChapterModule.CurSelectChapterType == Constant.ChapterPassType.TYPE_RESOURCES then
		dupPOD = ResourceChapterModule.GetDupPODByID(GameChapterModule.CurSelectChapterCfg.ChapterId)
	elseif GameChapterModule.CurSelectChapterType == Constant.ChapterPassType.TYPE_EQUIP then
		dupPOD = EquipChapterModule.ChapterList[GameChapterModule.CurSelectChapterCfg.ChapterId]
	elseif GameChapterModule.CurSelectChapterType == Constant.ChapterPassType.TYPE_BOSS then
		dupPOD = BossChapterModule.ChapterList[GameChapterModule.CurSelectChapterCfg.ChapterId]
	elseif GameChapterModule.CurSelectChapterType == Constant.ChapterPassType.TYPE_CLIMB_TOWER then
		dupPOD = TowerChapterModule.FinishDupList[GameChapterModule.CurSelectChapterCfg.ChapterId]

		local isAllPass = TowerChapterModule.GetTowerChapterIsAllPass(GameChapterModule.CurSelectChapterCfg.ChapterId)

		LuaCodeInterface.SetGameObjectShow(self.ContinueBtn, not isAllPass)
	end

	local isHasFreeCount = dupPOD and dupPOD.costFree and dupPOD.costFree > 0

	if isHasFreeCount then
		LuaUtility.SetGameObjectShow(self.imageCost, false)

		return
	end

	if not GameChapterModule.CurSelectChapterCfg.PassCost then
		LuaUtility.SetGameObjectShow(self.imageCost, false)

		return
	end

	local returnValue = 0

	if GameChapterModule.CurSelectChapterCfg.PassCost[2] and GameChapterModule.CurSelectChapterCfg.PassCost[1] then
		returnValue = GameChapterModule.CurSelectChapterCfg.PassCost[2]
	else
		LuaUtility.SetGameObjectShow(self.imageCost, false)
	end

	if returnValue <= 0 then
		LuaUtility.SetGameObjectShow(self.imageCost, false)

		return
	end

	LuaUtility.SetText(self.textCost, "-" .. returnValue)

	local cfgItem = CfgUtil.GetItemCfgDataWithID(GameChapterModule.CurSelectChapterCfg.PassCost[1])

	LuaUtility.LoadImage(self, UIGlobalApi.GetIconPath(cfgItem.SmallIcon), self.imageCost:GetComponent("Image"))
end

function Settlement_BattleUI:RefreshFailed(displayHeroCid)
	LuaUtility.SetGameObjectShow(self.buttonClose, true)

	local textData = GameLevelEndUIApi:GetFailedJumpInfoText()
	local jumpData = GameLevelEndUIApi:GetJumpInfoFunctionId()
	local len = #textData
	local index = 1

	for i = 1, len do
		local cell = self:_GetFailedItem(i)

		cell:Refresh(textData[i], jumpData[i])
		cell:Show()

		index = index + 1
	end

	len = #self.failedItemArray

	for i = index, len do
		self.failedItemArray[i]:Hide()
	end

	if displayHeroCid == 0 then
		CVModule.PlayFightOverCVWithAttackUnit(Constant.CVActionType.FightFailed, self.settlementData.fightOverPOD.units)
	else
		CVModule.PlayFightOverCVWithAttackHeroCid(Constant.CVActionType.FightFailed, displayHeroCid)
	end

	local returnExpend = self.settlementData.fightOverPOD.returnExpend

	if not returnExpend or getTableLength(returnExpend) <= 0 then
		LuaUtility.SetGameObjectShow(self.costRoot_phone, false)

		return
	end

	LuaUtility.SetGameObjectShow(self.costRoot_phone, true)

	for i, v in pairs(returnExpend) do
		local cfgItem = CfgUtil.GetItemCfgDataWithID(i)

		if cfgItem then
			LuaUtility.LoadImage(self, UIGlobalApi.GetIconPath(cfgItem.SmallIcon), self.imageCost_phone:GetComponent("Image"))
			LuaUtility.SetText(self.textCost_phone, v)
		end
	end
end

function Settlement_BattleUI:RefreshScore(displayHeroCid)
	LuaUtility.SetStateController(self.gameObject, dataName_win, win_stateName_score)
	LuaUtility.SetGameObjectShow(self.buttonClose, true)
	LuaUtility.SetText(self.textScore, self.settlementData.fightOverPOD.fightIntegral)

	local cfgBossStage = CfgUtil.GetCfgBossStageDataWithID(GameChapterModule.lastEnterChapterData.PassId)

	LuaUtility.SetText(self.textMark, BossChapterModule.GetMarkWithScore(cfgBossStage.ChapterId, self.settlementData.fightOverPOD.fightIntegral))

	local itemShowList, upExp = ItemModule.ExcludeExpItem_CountExp(self.settlementData.fightOverPOD.awards)

	self.levelView:Refresh(upExp)

	if displayHeroCid == 0 then
		CVModule.PlayFightOverCVWithAttackUnit(Constant.CVActionType.FightSuccess, self.settlementData.fightOverPOD.units)
	else
		CVModule.PlayFightOverCVWithAttackHeroCid(Constant.CVActionType.FightSuccess, displayHeroCid)
	end

	if not GameChapterModule.CurSelectChapterCfg then
		LuaUtility.SetGameObjectShow(self.imageCost, false)

		return
	end

	if not GameChapterModule.CurSelectChapterCfg.PassCost then
		LuaUtility.SetGameObjectShow(self.imageCost, false)

		return
	end

	local returnValue = 0

	if GameChapterModule.CurSelectChapterCfg.PassCost[2] and GameChapterModule.CurSelectChapterCfg.PassCost[1] then
		returnValue = GameChapterModule.CurSelectChapterCfg.PassCost[2]
	else
		LuaUtility.SetGameObjectShow(self.imageCost, false)
	end

	if returnValue <= 0 then
		LuaUtility.SetGameObjectShow(self.imageCost, false)

		return
	end

	LuaUtility.SetText(self.textCost, "-" .. returnValue)

	local cfgItem = CfgUtil.GetItemCfgDataWithID(GameChapterModule.CurSelectChapterCfg.PassCost[1])

	LuaUtility.LoadImage(self, UIGlobalApi.GetIconPath(cfgItem.SmallIcon), self.imageCost:GetComponent("Image"))
end

function Settlement_BattleUI:_GetFailedItem(index)
	if not self.failedItemArray[index] then
		local o = GameObject.Instantiate(self.jumpInfoPrefab, self.jumpInfoRoot.transform)

		self.failedItemArray[index] = SettlementFailedInfoViewClass.New(o, self)
	end

	return self.failedItemArray[index]
end

function Settlement_BattleUI:_GetTaskItem(index)
	if not self.taskItemArray[index] then
		local o = GameObject.Instantiate(self.taskItem, self.taskContent.transform)

		self.taskItemArray[index] = TaskItem.New(o, self)
	end

	return self.taskItemArray[index]
end

function Settlement_BattleUI:StopCoWin()
	if self.coWin then
		coroutine.stop(self.coWin)

		self.coWin = nil
	end
end

function Settlement_BattleUI:StopCoFailed()
	if self.coFailed then
		coroutine.stop(self.coFailed)

		self.coFailed = nil
	end
end

function Settlement_BattleUI:RefreshFavorView(fightOverPOD)
	self.favorItemPool:ForItems(function(item)
		item:Hide()
	end)

	local baseAtk = 0
	local baseAtkUUID = ""
	local baseDef = 0
	local baseDefUUID = ""
	local baseAux = 0
	local baseAuxUUID = ""
	local len = #fightOverPOD.units

	if fightOverPOD.type == Constant.ChapterPassType.Type_ChallengeWorldBoss then
		for i = 1, len do
			local unitPod = fightOverPOD.units[i]

			if baseDef > unitPod.injury then
				baseDefUUID = unitPod.UUID
				baseDef = unitPod.injury
			end

			if baseAtk < unitPod.record then
				baseAtkUUID = unitPod.UUID
				baseAtk = unitPod.record
			end

			if baseAux < unitPod.remedy then
				baseAux = unitPod.remedy
				baseAuxUUID = unitPod.UUID
			end
		end
	end

	for i = 1, len do
		local item = self.favorItemPool:GetFree(function(_item)
			return not _item.gameObject.activeSelf
		end)
		local isReady = item:Refresh(fightOverPOD.units[i], baseAtkUUID, baseDefUUID, baseAuxUUID, fightOverPOD.type)

		if isReady then
			item:Show()
		else
			item:Hide()
		end
	end
end

function Settlement_BattleUI:RefreshGloableBuffView()
	if self.settlementData.fightOverPOD.triggerBuffs == nil or table.len(self.settlementData.fightOverPOD.triggerBuffs) == 0 then
		self.buffView:Hide()

		return
	end

	local triggerBuffs = self.settlementData.fightOverPOD.triggerBuffs
	local buffCidList = {}

	ForPairs(triggerBuffs, function(_buffCid, _globalBuffPOD)
		table.insert(buffCidList, _buffCid)
	end)
	self.buffView:Show(buffCidList)
end

function Settlement_BattleUI:OnDestroy()
	self.favorItemPool:Dispose(function(item)
		item:OnDestroy()
	end)
	self.roleDisplayView:Dispose()
	self:StopCoWin()
	self:StopCoFailed()
	self.levelView:OnDestroy()
	self.rewardView:OnDestroy()
	self.multipleAwardView:OnDestroy()

	for _, v in pairs(self.failedItemArray) do
		v:OnDestroy()
	end

	self.buffView:Dispose()
	AssetUtil.UnloadAsset(self)
end

function Settlement_BattleUI:__OnContinueBtnClickEventHandler()
	local nextLevel = TowerChapterModule.GetTheLastCanStart(GameChapterModule.CurSelectChapterCfg.ChapterId)
	local towerStageCfg = TowerChapterModule.GetCfgTowerStageWithLevel(GameChapterModule.CurSelectChapterCfg.ChapterId, nextLevel)
	local enterDupData = GameChapterModule.lastEnterChapterData

	if enterDupData == nil then
		return
	end

	enterDupData.PassId = towerStageCfg.Id
	BattleModule.ContinueBattle = true

	UIModule.Close(Constant.UIControllerName.Settlement_BattleUI)
	GameChapterModule.EnterDupByChapterType(enterDupData)
end

function Settlement_BattleUI:__OnFailedCloseBtnClickHandler()
	if self.delegateOnClickButtonClose == nil then
		return
	end

	self.delegateOnClickButtonClose()
end

return Settlement_BattleUI
