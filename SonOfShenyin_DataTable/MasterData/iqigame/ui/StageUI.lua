-- chunkname: @IQIGame\\UI\\StageUI.lua

local StageUI = {
	enableMultipleFight = false,
	equipChapterCell = {},
	resourceChapterCell = {},
	bossChapterCell = {},
	towerChapterCell = {},
	stageCells = {},
	openData = {},
	itemList = {}
}

StageUI = Base:Extend("StageUI", "IQIGame.Onigao.UI.StageUI", StageUI)

local stageCell = require("IQIGame.UI.Dup.StageCell")
local bossRewardItem = require("IQIGame.UI.Chapter.BossChapter.BossRewardItem")
local MultipleFightPopupView = require("IQIGame/UI/Chapter/MultipleFightPopupView")
local multipleParentView = require("IQIGame.UI.Chapter.MultipleParentView")
local buttonDataName = "ButtonState"
local buttonStateName_isFree = "IsFree"
local buttonStateName_NotFree = "NotFree"

function StageUI:OnInit()
	self.equipStageCellList = {}
	self.roleMatStageCellArray = {}

	local len = LuaUtility.GetChildCount(self.roleMatScroll.transform)

	for i = 1, len do
		local trans = LuaUtility.GetChild(self.roleMatScroll.transform, i - 1)

		table.insert(self.roleMatStageCellArray, stageCell.New(trans.gameObject, self))
	end

	self.moneyCell = CurrencyCell.New(self.CurrencyContainer)

	function self.DelegateOnClickStageToggle()
		self:OnClickStageToggle()
	end

	function self.DelegateOnClickstartBtn()
		self:OnClickstartBtn()
	end

	function self.__delegateOnMultipleFightButtonClick()
		self:__OnMultipleFightButtonClick()
	end

	function self.__DelegateOnClickShopBtn()
		self:__OnClickShopBtn()
	end

	function self.__DelegateOnResourceChapterUpdateEvent()
		self:__OnResourceChapterUpdateEvent()
	end

	function self.DelegateOnActivityCloseEvent()
		self:OnActivityCloseEvent()
	end

	function self.delegateOnClickButtonFree()
		self:OnClickButtonFree()
	end

	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)
	self.multipleFightPopupView = MultipleFightPopupView.New(self.multipleFightPopup)

	self.multipleFightPopupView:Hide()

	self.scrollRect = self.diffcultScroll:GetComponent("OptimizedScrollRect")

	self.scrollRect:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:UpdateStageScroll(OptimizedParams, OptimizedViewsHolder)
	end)

	self.equipStageScroll = self.equipStageScroll:GetComponent("OptimizedScrollRect")

	self.equipStageScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:UpdateEquipStageScroll(OptimizedParams, OptimizedViewsHolder)
	end)
	LuaCodeInterface.BindOutlet(self.equipChapterInfo.gameObject, self.equipChapterCell)
	LuaCodeInterface.BindOutlet(self.resourceChapterInfo.gameObject, self.resourceChapterCell)
	LuaCodeInterface.BindOutlet(self.bossChapterInfo.gameObject, self.bossChapterCell)
	LuaCodeInterface.BindOutlet(self.towerChapterInfo.gameObject, self.towerChapterCell)

	self.equipRewardScrollView = self.equipChapterCell.rewardScrollView:GetComponent("ScrollAreaList")

	function self.equipRewardScrollView.onRenderCell(cell)
		self:OnRenderRewardItem(cell)
	end

	self.resourceRewardScrollView = self.resourceChapterCell.rewardScrollView:GetComponent("ScrollAreaList")

	function self.resourceRewardScrollView.onRenderCell(cell)
		self:OnRenderRewardItem(cell)
	end

	self.bossRewardScrollView = self.bossChapterCell.rewardScrollView:GetComponent("ScrollAreaList")

	function self.bossRewardScrollView.onRenderCell(cell)
		self:OnRenderRewardItem(cell)
	end

	self.towerRewardScrollView = self.towerChapterCell.rewardScrollView:GetComponent("ScrollAreaList")

	function self.towerRewardScrollView.onRenderCell(cell)
		self:OnRenderRewardItem(cell)
	end

	self.multipleParentView = multipleParentView.New(self.MultipleParent)
end

function StageUI:GetPreloadAssetPaths()
	return nil
end

function StageUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function StageUI:IsManualShowOnOpen(userData)
	return false
end

function StageUI:GetBGM(userData)
	return nil
end

function StageUI:OnOpen(userData)
	self.openData = userData
	self.stageData = {}
	self.selectedTag = nil
	self.enableMultipleFight = false

	self.multipleStartBtn.gameObject:SetActive(false)
	self.multipleFightPopupView:Hide()

	if self.openData.dupTagCfg.DupType == Constant.ChapterPassType.TYPE_RESOURCES then
		self.enableMultipleFight = true

		self:FilterDup(CfgDailyDupStageTable)

		self.cfgChapter = CfgDailyDupChapterTable[self.openData.data.Id]
	elseif self.openData.dupTagCfg.DupType == Constant.ChapterPassType.TYPE_EQUIP then
		self.enableMultipleFight = true

		self:FilterDup(CfgEquipDupStageTable)

		self.cfgChapter = CfgEquipDupChapterTable[self.openData.data.Id]
	elseif self.openData.dupTagCfg.DupType == Constant.ChapterPassType.TYPE_BOSS then
		self:FilterDup(CfgBossStageTable)

		self.cfgChapter = CfgBossChapterTable[self.openData.data.Id]
	elseif self.openData.dupTagCfg.DupType == Constant.ChapterPassType.TYPE_CLIMB_TOWER then
		self:FilterDup(CfgTowerStageTable)

		self.cfgChapter = CfgTowerChapterTable[self.openData.data.Id]
	end

	table.sort(self.stageData, function(a, b)
		return a.Id < b.Id
	end)

	self.newUnlockId, self.scrollToIndex = self:GetNewUnlockStageID()

	self.resourceChapterInfo.gameObject:SetActive(self.openData.dupTagCfg.DupShow == Constant.ResourceStageUI_DupTagShowType.BaseResource or self.openData.dupTagCfg.DupShow == Constant.ResourceStageUI_DupTagShowType.RoleDevelopment)
	self.bossChapterInfo.gameObject:SetActive(self.openData.dupTagCfg.DupShow == Constant.ResourceStageUI_DupTagShowType.Boss)
	self.equipChapterInfo.gameObject:SetActive(self.openData.dupTagCfg.DupShow == Constant.ResourceStageUI_DupTagShowType.Equip)
	self.towerChapterInfo.gameObject:SetActive(self.openData.dupTagCfg.DupShow == Constant.ResourceStageUI_DupTagShowType.Tower)

	if self.openData.dupTagCfg.DupShow == Constant.ResourceStageUI_DupTagShowType.BaseResource or self.openData.dupTagCfg.DupShow == Constant.ResourceStageUI_DupTagShowType.RoleDevelopment then
		self.dupPod = ResourceChapterModule.GetDupPODByID(self.openData.data.Id)
	elseif self.openData.dupTagCfg.DupShow == Constant.ResourceStageUI_DupTagShowType.Equip then
		self.dupPod = EquipChapterModule.ChapterList[self.openData.data.Id]
	elseif self.openData.dupTagCfg.DupShow == Constant.ResourceStageUI_DupTagShowType.Boss then
		self.dupPod = BossChapterModule.ChapterList[self.openData.data.Id]
	elseif self.openData.dupTagCfg.DupType == Constant.ChapterPassType.TYPE_CLIMB_TOWER then
		self.dupPod = TowerChapterModule.FinishDupList[self.openData.data.Id]
	end

	self:ShowTag()
	self.moneyCell:RefreshItem(Constant.TopMoneyType.GameLevelUI)
end

function StageUI:FilterDup(cfg)
	for k, v in pairs(cfg) do
		if self.openData.data.Id == v.ChapterId then
			table.insert(self.stageData, v)
		end
	end
end

function StageUI:ShowTag()
	LuaUtility.SetGameObjectShow(self.scrollRect.gameObject, false)
	LuaUtility.SetGameObjectShow(self.equipStageScroll.gameObject, false)
	LuaUtility.SetGameObjectShow(self.roleMatScroll, false)

	if self.openData.dupTagCfg.DupShow == Constant.ResourceStageUI_DupTagShowType.BaseResource or self.openData.dupTagCfg.DupShow == Constant.ResourceStageUI_DupTagShowType.Boss or self.openData.dupTagCfg.DupShow == Constant.ResourceStageUI_DupTagShowType.Tower then
		LuaUtility.SetGameObjectShow(self.scrollRect.gameObject, true)
		self.scrollRect:RefreshByItemCount(#self.stageData)

		if #self.stageData > 0 then
			self.scrollRect:ScrollTo(self.scrollToIndex - 1)
		end
	elseif self.openData.dupTagCfg.DupShow == Constant.ResourceStageUI_DupTagShowType.RoleDevelopment then
		LuaUtility.SetGameObjectShow(self.roleMatScroll, true)

		local index = 1

		for i = 1, #self.stageData do
			if i > 6 then
				break
			end

			local cell = self.roleMatStageCellArray[i]

			cell:Refresh(self.stageData[i], true)
			cell:Show()

			index = index + 1
		end

		for i = index, #self.roleMatStageCellArray do
			self.roleMatStageCellArray[i]:Hide()
		end
	elseif self.openData.dupTagCfg.DupShow == Constant.ResourceStageUI_DupTagShowType.Equip then
		LuaUtility.SetGameObjectShow(self.equipStageScroll.gameObject, true)
		self.equipStageScroll:RefreshByItemCount(#self.stageData)

		if #self.stageData > 0 then
			self.equipStageScroll:ScrollTo(self.scrollToIndex - 1)
		end
	end
end

function StageUI:OnClose(userData)
	self.multipleFightPopupView:Hide()
end

function StageUI:OnAddListeners()
	self.StageToggle:GetComponent("Button").onClick:AddListener(self.DelegateOnClickStageToggle)
	self.startBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickstartBtn)
	self.multipleStartBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnMultipleFightButtonClick)
	self.ShopBtn:GetComponent("Button").onClick:AddListener(self.__DelegateOnClickShopBtn)
	self.buttonFree:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonFree)
	EventDispatcher.AddEventListener(EventID.ResourceChapterUpdateEvent, self.__DelegateOnResourceChapterUpdateEvent)
	EventDispatcher.AddEventListener(EventID.ActivityCloseEvent, self.DelegateOnActivityCloseEvent)
end

function StageUI:OnRemoveListeners()
	self.StageToggle:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickStageToggle)
	self.startBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickstartBtn)
	self.multipleStartBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnMultipleFightButtonClick)
	self.ShopBtn:GetComponent("Button").onClick:RemoveListener(self.__DelegateOnClickShopBtn)
	self.buttonFree:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonFree)
	EventDispatcher.RemoveEventListener(EventID.ResourceChapterUpdateEvent, self.__DelegateOnResourceChapterUpdateEvent)
	EventDispatcher.RemoveEventListener(EventID.ActivityCloseEvent, self.DelegateOnActivityCloseEvent)
end

function StageUI:OnPause()
	return
end

function StageUI:OnResume()
	return
end

function StageUI:OnCover()
	return
end

function StageUI:OnReveal()
	return
end

function StageUI:OnRefocus(userData)
	return
end

function StageUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function StageUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function StageUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function StageUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function StageUI:OnDestroy()
	self.multipleFightPopupView:Dispose()
	LuaCodeInterface.ClearOutlet(self.equipChapterInfo.gameObject, self.equipChapterCell)
	LuaCodeInterface.ClearOutlet(self.resourceChapterInfo.gameObject, self.resourceChapterCell)
	LuaCodeInterface.ClearOutlet(self.bossChapterInfo.gameObject, self.bossChapterCell)
	LuaCodeInterface.ClearOutlet(self.towerChapterInfo.gameObject, self.towerChapterCell)
	self.multipleParentView:Dispose()
	AssetUtil.UnloadAsset(self)
	self.commonReturnBtn:Dispose()
	self.moneyCell:Dispose()

	for i, v in pairs(self.stageCells) do
		v:OnDestroy()
	end

	for k, v in pairs(self.itemList) do
		v:Dispose()
	end
end

function StageUI:__OnResourceChapterUpdateEvent()
	return
end

function StageUI:__OnClickShopBtn()
	if UnlockFunctionModule.IsUnlock(Constant.UnlockType.FUNC_STORE) then
		UIModule.Open(Constant.UIControllerName.ShopUI, Constant.UILayer.UI, {
			self.openData.data.Shop[1],
			self.openData.data.Shop[2],
			enterType = Constant.ShopEnterType.Normal
		})
	else
		NoticeModule.ShowNotice(19001)
	end
end

function StageUI:OnClickStageToggle()
	self:RefreshInfo(self.tempStageData)
end

function StageUI:OnClickstartBtn()
	local isHasFreeCount = self.dupPod ~= nil and self.dupPod.costFree ~= nil and self.dupPod.costFree > 0

	if WarehouseModule.GetPlayerStrengthNum() < self.NeedPower and not isHasFreeCount then
		NoticeModule.ShowNotice(20006)

		return
	end

	if self.openData.dupTagCfg.DupType == Constant.ChapterPassType.TYPE_BOSS then
		local useCount = BossChapterModule.ReduceRewardCount()
		local limitcount = CfgDiscreteDataTable[Constant.DiscreteData.BOSS_COUNT].Data[1]
		local stage = BossChapterModule.ChapterList[self.openData.data.Id].passStatus[self.selectedTag.data.Id]

		if limitcount <= useCount and stage and stage.Status > 0 then
			NoticeModule.ShowNotice(100001, function()
				self:openFormationUI()
			end)

			return
		end
	end

	self:openFormationUI()
end

function StageUI:openFormationUI()
	local userData = {}

	userData.OpenType = 2
	userData.ChapterType = self.openData.dupTagCfg.DupType
	userData.StageId = self.selectedTag.data.Id

	UIModule.Open(Constant.UIControllerName.FormationUI, Constant.UILayer.UI, userData)
end

function StageUI:__OnMultipleFightButtonClick()
	if not self.canMultipleFight then
		NoticeModule.ShowNotice(12024)

		return
	end

	if self.enableMultipleFight then
		local playerPower = WarehouseModule.GetPlayerStrengthNum()
		local freeCount = 0

		if self.dupPod and self.dupPod.costFree then
			freeCount = self.dupPod.costFree
		end

		local maxFightCount, _ = math.modf(playerPower / self.NeedPower) + freeCount

		if maxFightCount < 1 then
			NoticeModule.ShowNotice(20006)

			return
		end
	end

	self.multipleFightPopupView:Show(self.openData.dupTagCfg.DupType, self.selectedTag.data, self.dupPod)
end

function StageUI:UpdateStageScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex

	if not self.stageCells[instanceID] then
		self.stageCells[instanceID] = stageCell.New(viewGameObject, self)
	end

	self.stageCells[instanceID]:Refresh(self.stageData[index + 1], index + 1)
end

function StageUI:UpdateEquipStageScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex

	if not self.equipStageCellList[instanceID] then
		self.equipStageCellList[instanceID] = stageCell.New(viewGameObject, self)
	end

	self.equipStageCellList[instanceID]:Refresh(self.stageData[index + 1])
end

function StageUI:RefreshInfo(data)
	self.tempStageData = data

	local dupPOD

	if self.openData.dupTagCfg.DupType == Constant.ChapterPassType.TYPE_RESOURCES then
		dupPOD = ResourceChapterModule.GetDupPODByID(self.openData.data.Id)
	elseif self.openData.dupTagCfg.DupType == Constant.ChapterPassType.TYPE_EQUIP then
		dupPOD = EquipChapterModule.ChapterList[self.openData.data.Id]
	elseif self.openData.dupTagCfg.DupType == Constant.ChapterPassType.TYPE_BOSS then
		dupPOD = BossChapterModule.ChapterList[self.openData.data.Id]
	elseif self.openData.dupTagCfg.DupType == Constant.ChapterPassType.TYPE_CLIMB_TOWER then
		dupPOD = TowerChapterModule.FinishDupList[self.openData.data.Id]
	end

	self.dupPod = dupPOD

	LuaUtility.SetGameObjectShow(self.ShopBtn, self.openData.data.Shop ~= nil and table.len(self.openData.data.Shop) > 0)

	self.rewardItems = {}

	local stage

	if dupPOD then
		stage = dupPOD.passStatus[self.selectedTag.data.Id]
	end

	if data.FirstReward ~= nil and (stage == nil or stage.Status <= 0) then
		for k = 1, #data.FirstReward do
			local dropCfg = CfgDropLibTable[data.FirstReward[k]]

			for i, j in pairs(dropCfg.DropShowItem) do
				local dropTag = Constant.DropItemTag.None

				if table.len(dropCfg.DropItemTag) > 0 then
					dropTag = dropCfg.DropItemTag[i]
				end

				table.insert(self.rewardItems, {
					id = j,
					num = dropCfg.DropShowItemNum[i],
					tag = dropTag
				})
			end
		end
	end

	for k = 1, #data.PassReward do
		local dropCfg = CfgDropLibTable[data.PassReward[k]]

		for i, j in pairs(dropCfg.DropShowItem) do
			local dropTag = Constant.DropItemTag.None

			if table.len(dropCfg.DropItemTag) > 0 then
				dropTag = dropCfg.DropItemTag[i]
			end

			table.insert(self.rewardItems, {
				id = j,
				num = dropCfg.DropShowItemNum[i],
				tag = dropTag
			})
		end
	end

	local stageCost = 0
	local enterCost = 0

	stageCost = data.PassCost ~= nil and data.PassCost[2] or 0
	enterCost = data.EnterCost ~= nil and data.EnterCost[2] or 0

	local itemID = data.EnterCost ~= nil and data.EnterCost[1] or nil

	if itemID then
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[itemID].SmallIcon), self.costItemImg:GetComponent(typeof(UnityEngine.UI.Image)))
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[itemID].SmallIcon), self.FreeCostItemImg:GetComponent(typeof(UnityEngine.UI.Image)))
	end

	if self.openData.dupTagCfg.DupShow == Constant.ResourceStageUI_DupTagShowType.BaseResource or self.openData.dupTagCfg.DupShow == Constant.ResourceStageUI_DupTagShowType.RoleDevelopment then
		UGUIUtil.SetText(self.resourceChapterCell.levelNumText, data.RecommendLevel)
		UGUIUtil.SetText(self.resourceChapterCell.descContentText, data.Desc)
		UGUIUtil.SetText(self.resourceChapterCell.chapterName, data.Name)
		UGUIUtil.SetText(self.resourceChapterCell.englishName, self.openData.data.EnglishName)
		LuaUtility.SetGameObjectShow(self.resourceChapterCell.orderText, false)
		self.resourceRewardScrollView:Refresh(#self.rewardItems)
	elseif self.openData.dupTagCfg.DupShow == Constant.ResourceStageUI_DupTagShowType.Equip then
		UGUIUtil.SetText(self.equipChapterCell.levelNumText, data.RecommendLevel)
		UGUIUtil.SetText(self.equipChapterCell.descContentText, data.Desc)
		UGUIUtil.SetText(self.equipChapterCell.chapterName, data.Name)
		UGUIUtil.SetText(self.equipChapterCell.englishName, self.openData.data.EnglishName)
		LuaUtility.SetGameObjectShow(self.equipChapterCell.orderText, false)
		self.equipRewardScrollView:Refresh(#self.rewardItems)
	elseif self.openData.dupTagCfg.DupShow == Constant.ResourceStageUI_DupTagShowType.Boss then
		local cfgChapter = CfgBossChapterTable[self.openData.data.Id]

		UGUIUtil.SetText(self.bossChapterCell.levelNumText, data.RecommendLevel)
		UGUIUtil.SetText(self.bossChapterCell.descContentText, data.Desc)
		UGUIUtil.SetText(self.bossChapterCell.chapterName, data.Name)
		UGUIUtil.SetText(self.bossChapterCell.englishName, self.openData.data.EnglishName)
		LuaUtility.SetGameObjectShow(self.bossChapterCell.orderText, false)
		LuaUtility.LoadImage(self, UIGlobalApi.GetImagePath(cfgChapter.BigImg), self.bossChapterCell.bossImage1:GetComponent("Image"))
		self.bossRewardScrollView:Refresh(#self.rewardItems)
	elseif self.openData.dupTagCfg.DupType == Constant.ChapterPassType.TYPE_CLIMB_TOWER then
		UGUIUtil.SetText(self.towerChapterCell.levelNumText, data.RecommendLevel)
		UGUIUtil.SetText(self.towerChapterCell.descContentText, data.Desc)
		self.towerRewardScrollView:Refresh(#self.rewardItems)
	end

	self.NeedPower = stageCost + enterCost

	LuaUtility.SetGameObjectShow(self.consumeParent, self.NeedPower > 0)

	if not LuaUtility.StrIsNullOrEmpty(self.openData.data.DaliyChapterBackground) then
		LuaUtility.LoadImage(self, UIGlobalApi.GetImagePath(self.openData.data.DaliyChapterBackground), self.imageBg:GetComponent("Image"))
	else
		logError(string.format("章节 id = %s,没有配置 DaliyChapterBackground ", data.ChapterId))
	end

	local isHasFreeCount = dupPOD ~= nil and dupPOD.costFree ~= nil and dupPOD.costFree > 0

	if isHasFreeCount then
		LuaUtility.SetText(self.textFree, dupPOD.costFree .. "/" .. self.cfgChapter.CostFree)
		LuaUtility.SetStateController(self.gameObject, buttonDataName, buttonStateName_isFree)
		LuaUtility.SetGameObjectShow(self.consumeParent, false)
	else
		LuaUtility.SetStateController(self.gameObject, buttonDataName, buttonStateName_NotFree)
		LuaUtility.SetGameObjectShow(self.consumeParent, self.NeedPower > 0)
		UGUIUtil.SetText(self.costNumText, tostring(-self.NeedPower))
	end

	self.canMultipleFight = false

	if self.enableMultipleFight then
		if data.IsContinuous then
			self.canMultipleFight = ConditionModule.Check(data.ContinuousCondition)
		end

		local grayComponent = self.multipleStartBtn:GetComponent("GrayComponent")

		grayComponent:SetGray(not self.canMultipleFight)
	end

	self.multipleStartBtn.gameObject:SetActive(self.enableMultipleFight)

	self.data = data

	self:RefreshMultipleShow()
end

function StageUI:RefreshMultipleShow()
	local data = self.data
	local fatherCfg, activityType

	if self.openData.dupTagCfg.DupType == Constant.ChapterPassType.TYPE_RESOURCES then
		fatherCfg = CfgDailyDupChapterTable[data.ChapterId]
		activityType = Constant.ActivityType.ActivityType_DupMultiple_12
	elseif self.openData.dupTagCfg.DupType == Constant.ChapterPassType.TYPE_EQUIP then
		fatherCfg = CfgEquipDupChapterTable[data.ChapterId]
		activityType = Constant.ActivityType.ActivityType_DupMultiple_11
	end

	if fatherCfg.ActivityTag ~= nil and fatherCfg.ActivityTag ~= 0 then
		local activityPod = ActivityModule.GetActivityPodByActivityTag(activityType, fatherCfg.ActivityTag)

		if activityPod ~= nil then
			self.multipleParentView:Show()
			self.multipleParentView:SetData(activityPod)

			return
		end
	end

	self.multipleParentView:Hide()
end

function StageUI:OnRenderRewardItem(cell)
	local data = self.rewardItems[cell.index + 1]
	local Obj = self.itemList[cell.gameObject]

	if Obj == nil then
		Obj = bossRewardItem.New(cell.gameObject)
		self.itemList[cell.gameObject] = Obj
	end

	Obj:SetData(data)
end

function StageUI:SetTagState()
	for k, v in pairs(self.stageCells) do
		v:SetSelect(false)
	end
end

function StageUI:GetNewUnlockStageID()
	local scrollToIndex = 1

	for i = #self.stageData, 1, -1 do
		if ConditionModule.CheckMultipleAllIsPass(ConditionModule.CheckMultiple(self.stageData[i].UnlockConditionId)) then
			return self.stageData[i].Id, i
		end
	end

	return self.stageData[1].Id, scrollToIndex
end

function StageUI:OnActivityCloseEvent()
	self:RefreshMultipleShow()
end

function StageUI:OnClickButtonFree()
	local isHasFreeCount = self.dupPod ~= nil and self.dupPod.costFree ~= nil and self.dupPod.costFree > 0

	if WarehouseModule.GetPlayerStrengthNum() < self.NeedPower and not isHasFreeCount then
		NoticeModule.ShowNotice(20006)

		return
	end

	if self.openData.dupTagCfg.DupType == Constant.ChapterPassType.TYPE_BOSS then
		local useCount = BossChapterModule.ReduceRewardCount()
		local limitcount = CfgDiscreteDataTable[Constant.DiscreteData.BOSS_COUNT].Data[1]
		local stage = BossChapterModule.ChapterList[self.openData.data.Id].passStatus[self.selectedTag.data.Id]

		if limitcount <= useCount and stage and stage.Status > 0 then
			NoticeModule.ShowNotice(100001, function()
				self:openFormationUI()
			end)

			return
		end
	end

	self:openFormationUI()
end

return StageUI
