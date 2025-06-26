-- chunkname: @IQIGame\\UI\\EvilErosionUI.lua

require("IQIGame.UIExternalApi.EvilErosionUIApi")

local EvilErosionLevelGroupController = require("IQIGame.UI.EvilErosion.EvilErosionLevelGroupController")
local EvilErosionRewardItem = require("IQIGame.UI.EvilErosion.EvilErosionRewardItem")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local EvilErosionAffixBuffCell = require("IQIGame.UI.EvilErosion.EvilErosionAffixBuffCell")
local EvilErosionSupplyBuffCell = require("IQIGame.UI.EvilErosion.EvilErosionSupplyBuffCell")
local EvilErosionUI = {
	UpdateTimeElapsedTime = 0,
	ShowRewardMaxNum = 1,
	RewardItems = {},
	AffixBuffCells = {},
	CurrencyControllers = {}
}

EvilErosionUI = Base:Extend("EvilErosionUI", "IQIGame.Onigao.UI.EvilErosionUI", EvilErosionUI)

function EvilErosionUI:OnInit()
	function self.DelegateOnClickEnterBtn()
		self:OnClickEnterBtn()
	end

	function self.DelegateOnClickShopBtn()
		self:OnClickShopBtn()
	end

	function self.DelegateOnClickEquipBtn()
		self:OnClickEquipBtn()
	end

	function self.DelegateOnClickSoulBtn()
		self:OnClickSoulBtn()
	end

	function self.DelegateOnClickReturnToFunctionPanelBtn()
		self:OnClickReturnToFunctionPanelBtn()
	end

	function self.DelegateOnClickSwitchToRewardPanelBtn()
		self:OnClickSwitchToRewardPanelBtn()
	end

	function self.DelegateOnClickDailySupplyBtn()
		self:OnClickDailySupplyBtn()
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnUpdateDailyDupPOD()
		self:OnUpdateDailyDupPOD()
	end

	function self.DelegateOnGotDailySupply()
		self:OnGotDailySupply()
	end

	function self.DelegateOnClickHelpBtn()
		self:OnClickHelpBtn()
	end

	self.LevelGroupController = EvilErosionLevelGroupController.New(self.LevelGroupContainer, self.UIController)

	local scrollAreaList = self.RewardScrollList:GetComponent("ScrollAreaList")

	function scrollAreaList.onRenderCell(cell)
		self:OnRenderRewardItem(cell)
	end

	self.AffixBuffCellParent = self.AffixBuffCellPrefab.transform.parent

	self.AffixBuffCellPrefab:SetActive(false)

	self.AffixBuffCellPool = UIObjectPool.New(3, function()
		self.AffixBuffCellPrefab:SetActive(true)

		local cell = EvilErosionAffixBuffCell.New(UnityEngine.Object.Instantiate(self.AffixBuffCellPrefab))

		self.AffixBuffCellPrefab:SetActive(false)

		return cell
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)
	self.SupplyBuffCell = EvilErosionSupplyBuffCell.New(self.SupplyBuffCellGO)

	self:AddCurrencyCell(Constant.ItemID.EVIL_EROSION_CURRENCY)
	UGUIUtil.SetTextInChildren(self.DailySupplyBtn, EvilErosionUIApi:GetString("DailySupplyBtnText"))
	UGUIUtil.SetTextInChildren(self.SoulBtn, EvilErosionUIApi:GetString("SoulBtnText"))
	UGUIUtil.SetTextInChildren(self.EquipBtn, EvilErosionUIApi:GetString("EquipBtnText"))
	UGUIUtil.SetTextInChildren(self.ShopBtn, EvilErosionUIApi:GetString("ShopBtnText"))
	UGUIUtil.SetTextInChildren(self.SwitchToRewardPanelBtn, EvilErosionUIApi:GetString("SwitchToRewardPanelBtnText"))
	UGUIUtil.SetTextInChildren(self.ReturnToFunctionPanelBtn, EvilErosionUIApi:GetString("ReturnToFunctionPanelBtnText"))
	UGUIUtil.SetTextInChildren(self.EnterBtn, EvilErosionUIApi:GetString("EnterBtnText"))
	UGUIUtil.SetTextInChildren(self.FinishedBtn, EvilErosionUIApi:GetString("FinishedBtnText"))
	UGUIUtil.SetText(self.TitleText, EvilErosionUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.GamePlayLevelLabel, EvilErosionUIApi:GetString("GamePlayLevelLabel"))
	UGUIUtil.SetText(self.RewardLabel, EvilErosionUIApi:GetString("RewardLabel"))
	UGUIUtil.SetText(self.AffixBuffLabel, EvilErosionUIApi:GetString("AffixBuffLabel"))
end

function EvilErosionUI:GetPreloadAssetPaths()
	return {
		AssetPath.Get(GlobalKey.UIPrefabPath, "Common/MoneyGrid_Mould")
	}
end

function EvilErosionUI:GetOpenPreloadAssetPaths(userData)
	local levelIndex = table.indexOf(EvilErosionModule.GetGlobalData().EvilErosionLevel, EvilErosionModule.GetCurrentLevelCid())
	local levelGroupPrefabPath = UIGlobalApi.GetUIPrefab(EvilErosionUIApi:GetString("LevelGroupPrefabPath", levelIndex))

	return {
		levelGroupPrefabPath
	}
end

function EvilErosionUI:IsManualShowOnOpen(userData)
	return false
end

function EvilErosionUI:GetBGM(userData)
	local levelIndex = table.indexOf(EvilErosionModule.GetGlobalData().EvilErosionLevel, EvilErosionModule.GetCurrentLevelCid())

	return EvilErosionUIApi:GetString("LevelGroupBGM", levelIndex)
end

function EvilErosionUI:OnOpen(userData)
	self:UpdateView()
end

function EvilErosionUI:OnClose(userData)
	return
end

function EvilErosionUI:OnAddListeners()
	self.EnterBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickEnterBtn)
	self.ShopBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickShopBtn)
	self.EquipBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickEquipBtn)
	self.SoulBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSoulBtn)
	self.ReturnToFunctionPanelBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickReturnToFunctionPanelBtn)
	self.SwitchToRewardPanelBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSwitchToRewardPanelBtn)
	self.DailySupplyBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickDailySupplyBtn)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.HelpBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickHelpBtn)
	EventDispatcher.AddEventListener(EventID.EvilErosionUpdateDailyDupPOD, self.DelegateOnUpdateDailyDupPOD)
	EventDispatcher.AddEventListener(EventID.EvilErosionGotDailySupply, self.DelegateOnGotDailySupply)
end

function EvilErosionUI:OnRemoveListeners()
	self.EnterBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickEnterBtn)
	self.ShopBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickShopBtn)
	self.EquipBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickEquipBtn)
	self.SoulBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSoulBtn)
	self.ReturnToFunctionPanelBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickReturnToFunctionPanelBtn)
	self.SwitchToRewardPanelBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSwitchToRewardPanelBtn)
	self.DailySupplyBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickDailySupplyBtn)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.HelpBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickHelpBtn)
	EventDispatcher.RemoveEventListener(EventID.EvilErosionUpdateDailyDupPOD, self.DelegateOnUpdateDailyDupPOD)
	EventDispatcher.RemoveEventListener(EventID.EvilErosionGotDailySupply, self.DelegateOnGotDailySupply)
end

function EvilErosionUI:OnPause()
	return
end

function EvilErosionUI:OnResume()
	return
end

function EvilErosionUI:OnCover()
	return
end

function EvilErosionUI:OnReveal()
	return
end

function EvilErosionUI:OnRefocus(userData)
	return
end

function EvilErosionUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.RatingTimeExpireTime ~= nil then
		self.UpdateTimeElapsedTime = self.UpdateTimeElapsedTime + realElapseSeconds

		if self.UpdateTimeElapsedTime > 60 then
			self.UpdateTimeElapsedTime = 0

			self:RefreshRating()
		end
	end
end

function EvilErosionUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EvilErosionUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EvilErosionUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EvilErosionUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.LevelGroupController:Dispose()

	for instanceId, item in pairs(self.RewardItems) do
		item:Dispose()
	end

	self:ClearAffixBuffs()
	self.AffixBuffCellPool:Dispose()
	self.SupplyBuffCell:Dispose()

	for i = 1, #self.CurrencyControllers do
		self.CurrencyControllers[i]:Dispose()
	end
end

function EvilErosionUI:OnClickEnterBtn()
	if EvilErosionModule.IsAllPassed() then
		return
	end

	UIModule.Open(Constant.UIControllerName.EvilErosionLevelDetailUI, Constant.UILayer.UI, {
		levelCid = EvilErosionModule.GetCurrentLevelCid()
	})
end

function EvilErosionUI:OnClickShopBtn()
	UIModule.Open(Constant.UIControllerName.ShopUI, Constant.UILayer.UI, {
		Constant.ShopType.EvilErosion
	})
end

function EvilErosionUI:OnClickEquipBtn()
	UIModule.Open(Constant.UIControllerName.EvilErosionEquipListUI, Constant.UILayer.UI)
end

function EvilErosionUI:OnClickSoulBtn()
	UIModule.Open(Constant.UIControllerName.EvilErosionSoulListUI, Constant.UILayer.UI)
end

function EvilErosionUI:OnClickReturnToFunctionPanelBtn()
	self:SwitchRightPanel(false)
end

function EvilErosionUI:OnClickSwitchToRewardPanelBtn()
	self:SwitchRightPanel(true)
end

function EvilErosionUI:OnClickDailySupplyBtn()
	UIModule.Open(Constant.UIControllerName.EvilErosionDailySupplyUI, Constant.UILayer.UI)
end

function EvilErosionUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function EvilErosionUI:AddCurrencyCell(currencyCid)
	local currencyModule = UnityEngine.Object.Instantiate(self.UIController:GetPreloadedAsset(AssetPath.Get(GlobalKey.UIPrefabPath, "Common/MoneyGrid_Mould")))

	currencyModule.transform:SetParent(self.CurrencyCom.transform, false)
	table.insert(self.CurrencyControllers, CurrencyCell.New(currencyModule, currencyCid))
end

function EvilErosionUI:UpdateView()
	self.LevelGroupController:Refresh()

	local levelCid = EvilErosionModule.GetCurrentLevelCid()
	local cfgEvilErosionLevelData = CfgEvilErosionLevelTable[levelCid]

	UGUIUtil.SetText(self.LevelNameText, cfgEvilErosionLevelData.Name)
	self:RefreshRating()

	local curGamePlayLevel, maxGamePlayLevel = EvilErosionModule.GetGamePlayLevel()

	UGUIUtil.SetText(self.GamePlayLevelText, EvilErosionUIApi:GetString("GamePlayLevelText", curGamePlayLevel, maxGamePlayLevel))
	self:SwitchRightPanel(false)
	self:ClearAffixBuffs()

	local buffs = EvilErosionModule.GetAffixSkillSpeEffects()

	for i = 1, #buffs do
		local cell = self.AffixBuffCellPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.AffixBuffCellParent.transform, false)
		cell:SetData(buffs[i])
		table.insert(self.AffixBuffCells, cell)
	end

	self.SupplyBuffCell:SetData(EvilErosionModule.GetSupplySpeEffect())
	self.DailySupplyBtn:SetActive(#EvilErosionModule.GetDailySupplyPreview() > 0)

	local isUnlock, unlockTime = EvilErosionModule.IsLevelUnlockByTime(levelCid)

	self.LockedBtn:SetActive(not isUnlock)
	UGUIUtil.SetTextInChildren(self.LockedBtn, EvilErosionUIApi:GetString("LockedBtnText", getCustomDateTimeText(unlockTime, "MonthToMinuteFormat")))
	self.EnterBtn:SetActive(not EvilErosionModule.IsAllPassed() and isUnlock)
	self.FinishedBtn:SetActive(EvilErosionModule.IsAllPassed())
end

function EvilErosionUI:RefreshRating()
	local currentLevelCid = EvilErosionModule.GetCurrentLevelCid()
	local rating, cfgEvilErosionRewardData, elapsedTime = EvilErosionModule.GetRatingPreview(currentLevelCid)
	local isAllPassed = EvilErosionModule.IsAllPassed()

	if isAllPassed then
		rating = EvilErosionModule.DailyDupPOD.evilErosionPOD.rating[currentLevelCid]
	end

	AssetUtil.LoadImage(self, EvilErosionUIApi:GetString("RatingImage", rating), self.RatingImage:GetComponent("Image"))

	self.RatingTimeExpireTime = nil

	local leftTimeStr

	if elapsedTime ~= nil and not isAllPassed and cfgEvilErosionRewardData.TimeLimit ~= 0 then
		local leftTime = cfgEvilErosionRewardData.TimeLimit - elapsedTime

		leftTimeStr = getTimeDurationText(leftTime, 3)
		self.RatingTimeExpireTime = PlayerModule.GetServerTime() + leftTime
	end

	UGUIUtil.SetText(self.RatingTimeText, EvilErosionUIApi:GetString("RatingTimeText", leftTimeStr, cfgEvilErosionRewardData.TimeLimit ~= 0, isAllPassed, rating))
end

function EvilErosionUI:SwitchRightPanel(isReward)
	self.FunctionPanel:SetActive(not isReward)
	self.RewardPanel:SetActive(isReward)

	if isReward then
		self.ShowRewardMaxNum = 1
		self.CurLevelRewards = {}

		local cfgEvilErosionLevelData = CfgEvilErosionLevelTable[EvilErosionModule.GetCurrentLevelCid()]

		for id, cfgData in pairsCfg(CfgEvilErosionRewardTable) do
			if cfgData.Group == cfgEvilErosionLevelData.RewardGroup then
				table.insert(self.CurLevelRewards, cfgData)

				self.ShowRewardMaxNum = math.max(self.ShowRewardMaxNum, math.floor(#cfgData.Rewards / 2))
			end
		end

		table.sort(self.CurLevelRewards, function(cfgData1, cfgData2)
			return cfgData1.RewardLevel < cfgData2.RewardLevel
		end)

		local scrollAreaList = self.RewardScrollList:GetComponent("ScrollAreaList")

		scrollAreaList:Refresh(#self.CurLevelRewards)
	end
end

function EvilErosionUI:OnRenderRewardItem(cell)
	local rewardItem = self.RewardItems[cell.gameObject:GetInstanceID()]

	if rewardItem == nil then
		rewardItem = EvilErosionRewardItem.New(cell.gameObject, self.ShowRewardMaxNum)
		self.RewardItems[cell.gameObject:GetInstanceID()] = rewardItem
	end

	rewardItem:SetData(self.CurLevelRewards[cell.index + 1])
end

function EvilErosionUI:ClearAffixBuffs()
	for i = 1, #self.AffixBuffCells do
		local cell = self.AffixBuffCells[i]

		cell.View:SetActive(false)
		cell.View.transform:SetParent(self.UIController.transform, false)
		self.AffixBuffCellPool:Release(cell)
	end

	self.AffixBuffCells = {}
end

function EvilErosionUI:OnUpdateDailyDupPOD()
	self:UpdateView()
end

function EvilErosionUI:OnGotDailySupply()
	self.DailySupplyBtn:SetActive(#EvilErosionModule.GetDailySupplyPreview() > 0)
end

function EvilErosionUI:OnClickHelpBtn()
	local cfgEvilErosionGlobalData = EvilErosionModule.GetGlobalData()

	UIModule.Open(Constant.UIControllerName.DailyActivityTipsUI, Constant.UILayer.UI, cfgEvilErosionGlobalData.Desc)
end

return EvilErosionUI
