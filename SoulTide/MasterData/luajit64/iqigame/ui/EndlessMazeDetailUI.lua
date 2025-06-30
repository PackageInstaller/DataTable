-- chunkname: @IQIGame\\UI\\EndlessMazeDetailUI.lua

local EndlessMazeDetailUI = Base:Extend("EndlessMazeDetailUI", "IQIGame.Onigao.UI.EndlessMazeDetailUI", {
	MazeCid = 0,
	MonsterElementCells = {}
})
local FormationPanelController = require("IQIGame.UI.FormationUI.FormationPanelController")
local MazeRewardCell = require("IQIGame.UI.MazeDetail.MazeRewardCell")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MonsterElementCell = require("IQIGame.UI.MazeDetail.MonsterElementCell")

function EndlessMazeDetailUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	function self.DelegateOnPlayerNumAttrsChange(itemCid, value)
		self:OnPlayerNumAttrsChange(itemCid, value)
	end

	self.EnergyCell = EnergyCell.New(self.EnergyCom.transform:GetChild(0).gameObject)
	self.CurrencyControllers = {}

	self:AddCurrencyCell(Constant.ItemID.MONEY)
	self:AddCurrencyCell(Constant.ItemID.TREASURE)

	self.FormationPanelController = FormationPanelController.New(self.FormationNode, function()
		self:OnUpdateFormation()
	end)
	self.MonsterElementPool = UIObjectPool.New(5, function()
		local cell = MonsterElementCell.New(UnityEngine.Object.Instantiate(self.MonsterElementPrefab))

		return cell
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)
	self.RewardCells = {}

	for i = 1, 5 do
		local itemCell = MazeRewardCell.New(UnityEngine.Object.Instantiate(self.RewardPrefab))

		itemCell.View.transform:SetParent(self.RewardGrid.transform, false)
		table.insert(self.RewardCells, itemCell)
	end

	UGUIUtil.SetText(self.TitleText, EndlessMazeDetailUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.RewardLabelText, EndlessMazeDetailUIApi:GetString("RewardLabelText"))
	UGUIUtil.SetTextInChildren(self.ConfirmBtn, EndlessMazeDetailUIApi:GetString("ConfirmBtnText"))
	UGUIUtil.SetText(self.MonsterPanelLabel, EndlessMazeDetailUIApi:GetString("MonsterPanelLabel"))
	UGUIUtil.SetText(self.FreeCountLabel, EndlessMazeDetailUIApi:GetString("FreeCountLabel"))
end

function EndlessMazeDetailUI:GetPreloadAssetPaths()
	local paths = {}

	table.insert(paths, AssetPath.Get(GlobalKey.UIPrefabPath, "Common/MoneyGrid_Mould"))

	return paths
end

function EndlessMazeDetailUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EndlessMazeDetailUI:OnOpen(userData)
	self:UpdateView(userData.mazeCid)
end

function EndlessMazeDetailUI:OnClose(userData)
	return
end

function EndlessMazeDetailUI:OnAddListeners()
	self.FormationPanelController:AddEventListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
	EventDispatcher.AddEventListener(EventID.PlayerNumAttrsChange, self.DelegateOnPlayerNumAttrsChange)
end

function EndlessMazeDetailUI:OnRemoveListeners()
	self.FormationPanelController:RemoveEventListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
	EventDispatcher.RemoveEventListener(EventID.PlayerNumAttrsChange, self.DelegateOnPlayerNumAttrsChange)
end

function EndlessMazeDetailUI:OnPause()
	return
end

function EndlessMazeDetailUI:OnResume()
	return
end

function EndlessMazeDetailUI:OnCover()
	return
end

function EndlessMazeDetailUI:OnReveal()
	return
end

function EndlessMazeDetailUI:OnRefocus(userData)
	return
end

function EndlessMazeDetailUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EndlessMazeDetailUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EndlessMazeDetailUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EndlessMazeDetailUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EndlessMazeDetailUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.EnergyCell:Dispose()

	for i = 1, #self.CurrencyControllers do
		self.CurrencyControllers[i]:Dispose()
	end

	self:ClearMonsterElementCells(true)
	self.MonsterElementPool:Dispose()

	for i = 1, #self.RewardCells do
		local itemCell = self.RewardCells[i]

		itemCell:Dispose()
	end

	self.RewardCells = nil

	self.FormationPanelController:Dispose()
end

function EndlessMazeDetailUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function EndlessMazeDetailUI:OnClickConfirmBtn()
	local validate, noticeCid, formationPOD = self:CheckValidation()

	if validate then
		if noticeCid ~= 0 then
			NoticeModule.ShowNotice(noticeCid, function()
				self:EnterMaze(formationPOD.id)
			end)
		else
			self:EnterMaze(formationPOD.id)
		end
	end
end

function EndlessMazeDetailUI:EnterMaze(formationId)
	MazeModule.SendEnterEndlessMaze(self.MazeCid, formationId)
end

function EndlessMazeDetailUI:CheckValidation()
	local hasCount = WarehouseModule.GetItemNumByCfgID(Constant.ItemID.ABYSS_COUNT)

	if hasCount <= 0 then
		NoticeModule.ShowNotice(70000001)

		return
	end

	local valid, formationPOD = self.FormationPanelController:CheckValidation()

	if not valid then
		return false, 0, nil
	end

	local valid2, noticeCid = MazeModule.CheckCanEnterMaze(self.MazeCid, formationPOD, false)

	return valid2, noticeCid, formationPOD
end

function EndlessMazeDetailUI:UpdateView(mazeCid)
	self.MazeCid = mazeCid

	local cfgMazeInstanceData = CfgMazeInstanceTable[self.MazeCid]

	UGUIUtil.SetText(self.MazeNameText, cfgMazeInstanceData.Name)
	UGUIUtil.SetText(self.MazeDescText, cfgMazeInstanceData.Desc)

	local cfgRecommendPowerData = CfgRecommendPowerTable[cfgMazeInstanceData.RecommendPowerId]

	UGUIUtil.SetText(self.RecommendPowerText, EndlessMazeDetailUIApi:GetString("RecommendPowerText", cfgRecommendPowerData.RecommendPower))
	self:ClearMonsterElementCells(false)

	local elements = MazeModule.GetWeakShowData(cfgMazeInstanceData)

	for i = 1, #elements do
		local cell = self.MonsterElementPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.MonsterElementGrid.transform, false)
		cell:SetData(elements[i], cfgMazeInstanceData.MainWeakType)
		table.insert(self.MonsterElementCells, cell)
	end

	local rewards = MazeModule.GetRewardShowData(cfgMazeInstanceData)

	for i = 1, #self.RewardCells do
		local itemCell = self.RewardCells[i]
		local itemInfo = rewards[i]
		local itemCid = 0
		local itemNum = 0
		local isFirstPassReward = false
		local isUncertain = false

		if itemInfo ~= nil then
			itemCid = itemInfo.cid
			itemNum = itemInfo.number
			isFirstPassReward = itemInfo.isFirstPassReward
			isUncertain = itemInfo.isUncertain
		end

		itemCell:SetData(itemCid, itemNum, isFirstPassReward, isUncertain)
		itemCell:RefreshIsSpecialDrop(itemCid)
	end

	self.FormationPanelController:UpdateView()
	self.MonsterPanel:SetActive(#cfgMazeInstanceData.MonsterHead ~= 0)

	local cfgDiscreteDataData = CfgDiscreteDataTable[6520040]

	UGUIUtil.SetText(self.FreeCountText, EndlessMazeDetailUIApi:GetString("FreeCountText", WarehouseModule.GetItemNumByCfgID(Constant.ItemID.ABYSS_COUNT), cfgDiscreteDataData.Data[1]))
	self:UpdateCost()
end

function EndlessMazeDetailUI:ClearMonsterElementCells(isDestroy)
	for i = 1, #self.MonsterElementCells do
		local cell = self.MonsterElementCells[i]

		cell.View:SetActive(false)

		if not isDestroy then
			cell.View.transform:SetParent(self.UIController.transform, false)
		end

		self.MonsterElementPool:Release(cell)
	end

	self.MonsterElementCells = {}
end

function EndlessMazeDetailUI:OnUpdateFormation()
	local cfgMazeInstanceData = CfgMazeInstanceTable[self.MazeCid]
	local cfgRecommendPowerData = CfgRecommendPowerTable[cfgMazeInstanceData.RecommendPowerId]

	UGUIUtil.SetText(self.FormationPowerText, EndlessMazeDetailUIApi:GetString("FormationPowerText", self.FormationPanelController:GetPower(), cfgRecommendPowerData.RecommendPower))
end

function EndlessMazeDetailUI:AddCurrencyCell(currencyCid)
	local currencyModule = UnityEngine.Object.Instantiate(self.UIController:GetPreloadedAsset(AssetPath.Get(GlobalKey.UIPrefabPath, "Common/MoneyGrid_Mould")))

	currencyModule.transform:SetParent(self.CurrencyCom.transform, false)
	table.insert(self.CurrencyControllers, CurrencyCell.New(currencyModule, currencyCid))
end

function EndlessMazeDetailUI:OnPlayerNumAttrsChange(itemCid, value)
	if itemCid == Constant.ItemID.ENERGY then
		self:UpdateCost()
	end
end

function EndlessMazeDetailUI:UpdateCost()
	local cfgMazeInstanceData = CfgMazeInstanceTable[self.MazeCid]
	local currentEnergy = WarehouseModule.GetItemNumByCfgID(Constant.ItemID.ENERGY)

	UGUIUtil.SetText(self.EnergyCostText, EndlessMazeDetailUIApi:GetString("EnergyCostText", cfgMazeInstanceData.Cost, currentEnergy))
end

return EndlessMazeDetailUI
