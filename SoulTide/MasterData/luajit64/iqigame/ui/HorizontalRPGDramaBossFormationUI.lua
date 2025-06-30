-- chunkname: @IQIGame\\UI\\HorizontalRPGDramaBossFormationUI.lua

local HorizontalRPGDramaBossFormationUI = {
	MonsterElementCells = {},
	ItemCells = {}
}

HorizontalRPGDramaBossFormationUI = Base:Extend("HorizontalRPGDramaBossFormationUI", "IQIGame.Onigao.UI.HorizontalRPGDramaBossFormationUI", HorizontalRPGDramaBossFormationUI)

require("IQIGame.UIExternalApi.HorizontalRPGDramaBossFormationUIApi")

local FormationPanelController = require("IQIGame.UI.FormationUI.FormationPanelController")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MonsterElementCell = require("IQIGame.UI.MazeDetail.MonsterElementCell")
local MazeRewardCell = require("IQIGame.UI.MazeDetail.MazeRewardCell")

function HorizontalRPGDramaBossFormationUI:OnInit()
	UGUIUtil.SetText(self.TitleText, HorizontalRPGDramaBossFormationUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.MonsterPanelLabel, HorizontalRPGDramaBossFormationUIApi:GetString("MonsterPanelLabel"))
	UGUIUtil.SetText(self.RewardLabelText, HorizontalRPGDramaBossFormationUIApi:GetString("RewardLabelText"))
	UGUIUtil.SetTextInChildren(self.ConfirmBtn, HorizontalRPGDramaBossFormationUIApi:GetString("ConfirmBtnText"))

	self.EnergyCell = EnergyCell.New(self.EnergyCom.transform:GetChild(0).gameObject)
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
	self.ItemCellPool = UIObjectPool.New(10, function()
		return MazeRewardCell.New(UnityEngine.Object.Instantiate(self.RewardPrefab))
	end, function(cell)
		cell:Dispose()
	end)

	function self.DelegateBtnClose()
		self:OnBtnClose()
	end

	function self.DelegateConfirmBtn()
		self:OnBtnConfirm()
	end
end

function HorizontalRPGDramaBossFormationUI:GetPreloadAssetPaths()
	return nil
end

function HorizontalRPGDramaBossFormationUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HorizontalRPGDramaBossFormationUI:IsManualShowOnOpen(userData)
	return false
end

function HorizontalRPGDramaBossFormationUI:GetBGM(userData)
	return nil
end

function HorizontalRPGDramaBossFormationUI:OnOpen(userData)
	self.cfgCid = userData[1]
	self.state = userData[2]

	self:UpdateView()
end

function HorizontalRPGDramaBossFormationUI:OnClose(userData)
	return
end

function HorizontalRPGDramaBossFormationUI:OnAddListeners()
	self.FormationPanelController:AddEventListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateBtnClose)
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateConfirmBtn)
end

function HorizontalRPGDramaBossFormationUI:OnRemoveListeners()
	self.FormationPanelController:RemoveEventListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnClose)
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateConfirmBtn)
end

function HorizontalRPGDramaBossFormationUI:OnPause()
	return
end

function HorizontalRPGDramaBossFormationUI:OnResume()
	return
end

function HorizontalRPGDramaBossFormationUI:OnCover()
	return
end

function HorizontalRPGDramaBossFormationUI:OnReveal()
	return
end

function HorizontalRPGDramaBossFormationUI:OnRefocus(userData)
	return
end

function HorizontalRPGDramaBossFormationUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HorizontalRPGDramaBossFormationUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HorizontalRPGDramaBossFormationUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HorizontalRPGDramaBossFormationUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HorizontalRPGDramaBossFormationUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.EnergyCell:Dispose()
	self.FormationPanelController:Dispose()
	self:ClearMonsterElementCells(true)
	self.MonsterElementPool:Dispose()

	for i, v in pairs(self.ItemCells) do
		self.ItemCellPool:Release(v)
	end

	self.ItemCells = {}

	self.ItemCellPool:Dispose()
end

function HorizontalRPGDramaBossFormationUI:OnBtnClose()
	UIModule.CloseSelf(self)
end

function HorizontalRPGDramaBossFormationUI:UpdateView()
	self.FormationPanelController:UpdateView()

	local cfg = CfgHorizontalRPGListTable[self.cfgCid]

	UGUIUtil.SetText(self.MazeOrderText, cfg.TitleName)

	local show = false

	if #cfg.ChallengeNeed > 1 then
		show = true

		local cfgItemData = CfgItemTable[cfg.ChallengeNeed[1]]

		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgItemData.Icon), self.CostItemIcon:GetComponent("Image"))

		local cost = cfg.ChallengeNeed[2]

		UGUIUtil.SetText(self.CostItemNumText, HorizontalRPGDramaBossFormationUIApi:GetString("CostItemNumText", cost, cost > WarehouseModule.GetItemNumByCfgID(Constant.ItemID.ENERGY)))
	end

	self.CostItemIcon:SetActive(show)
	self.CostItemNumText:SetActive(show)
	UGUIUtil.SetText(self.MazeNameText, cfg.TitleName)
	UGUIUtil.SetText(self.MazeDescText, cfg.TitleDesc)
	self:ClearMonsterElementCells(false)

	local sortTab = PlotChallengeModule.GetMonsterWeakTypes(cfg.Parameter)

	for i = 1, #sortTab do
		local b = sortTab[i]
		local cell = self.MonsterElementPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.MonsterElementGrid.transform, false)
		cell:SetData(b.weakType)
		table.insert(self.MonsterElementCells, cell)
	end

	for i, v in pairs(self.ItemCells) do
		v.View.transform:SetParent(nil, false)
		v.View:SetActive(false)
		self.ItemCellPool:Release(v)
	end

	self.ItemCells = {}

	local tab = cfg.FirstChallengeReward

	if cfg.Type == 2 and self.state == 2 then
		tab = cfg.ChallengeReward
	end

	for i = 1, #tab, 2 do
		local itemId = tab[i]
		local itemNum = tab[i + 1]
		local itemCell = self.ItemCellPool:Obtain()

		itemCell.View:SetActive(true)
		itemCell.View.transform:SetParent(self.RewardGrid.transform, false)
		itemCell:SetData(itemId, itemNum)
		table.insert(self.ItemCells, itemCell)
	end

	if self.state == 2 and not cfg.IsReChallenge then
		self.ConfirmBtn:SetActive(false)
		self.TextComplete:SetActive(true)
	else
		self.ConfirmBtn:SetActive(true)
		self.TextComplete:SetActive(false)
	end
end

function HorizontalRPGDramaBossFormationUI:ClearMonsterElementCells(isDestroy)
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

function HorizontalRPGDramaBossFormationUI:OnUpdateFormation()
	local cfg = CfgHorizontalRPGListTable[self.cfgCid]

	UGUIUtil.SetText(self.RecommendPowerText, HorizontalRPGDramaBossFormationUIApi:GetString("RecommendPowerText", cfg.RecommendPower))
	UGUIUtil.SetText(self.FormationPowerText, HorizontalRPGDramaBossFormationUIApi:GetString("FormationPowerText", self.FormationPanelController:GetPower(), cfg.RecommendPower))
end

function HorizontalRPGDramaBossFormationUI:OnBtnConfirm()
	if #PlayerModule.PlayerInfo.formations == 0 then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, HorizontalRPGDramaBossFormationUIApi:GetString("NoFormations"))

		return
	end

	local valid, formationPOD = self.FormationPanelController:CheckValidation()

	if not formationPOD then
		return
	end

	if not valid then
		return
	end

	local isStrength = WarehouseModule.GetItemNumByCfgID(Constant.ItemID.ENERGY) < CfgHorizontalRPGListTable[self.cfgCid].ChallengeNeed[2]

	if isStrength then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, ChallengeUIApi:GetString("TextNotice8"))

		return
	end

	HorizontalRPGModule.Challenge(self.cfgCid, formationPOD.id)
	self:OnBtnClose()
end

return HorizontalRPGDramaBossFormationUI
