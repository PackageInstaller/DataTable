-- chunkname: @IQIGame\\UI\\ChallengeDramaBossFormationUI.lua

local ChallengeDramaBossFormationUI = {
	MonsterElementCells = {},
	ItemCells = {}
}

ChallengeDramaBossFormationUI = Base:Extend("ChallengeDramaBossFormationUI", "IQIGame.Onigao.UI.ChallengeDramaBossFormationUI", ChallengeDramaBossFormationUI)

local FormationPanelController = require("IQIGame.UI.FormationUI.FormationPanelController")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MonsterElementCell = require("IQIGame.UI.MazeDetail.MonsterElementCell")
local MazeRewardCell = require("IQIGame.UI.MazeDetail.MazeRewardCell")

function ChallengeDramaBossFormationUI:OnInit()
	UGUIUtil.SetText(self.TitleText, ChallengeDramaBossFormationUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.MonsterPanelLabel, ChallengeDramaBossFormationUIApi:GetString("MonsterPanelLabel"))
	UGUIUtil.SetText(self.RewardLabelText, ChallengeDramaBossFormationUIApi:GetString("RewardLabelText"))
	UGUIUtil.SetTextInChildren(self.ConfirmBtn, ChallengeDramaBossFormationUIApi:GetString("ConfirmBtnText"))

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

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateConfirmBtn()
		self:OnBtnConfirm()
	end
end

function ChallengeDramaBossFormationUI:GetPreloadAssetPaths()
	return nil
end

function ChallengeDramaBossFormationUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ChallengeDramaBossFormationUI:IsManualShowOnOpen(userData)
	return false
end

function ChallengeDramaBossFormationUI:GetBGM(userData)
	return nil
end

function ChallengeDramaBossFormationUI:OnOpen(userData)
	self.cfgCid = userData[1]
	self.state = userData[2]

	self:UpdateView()
end

function ChallengeDramaBossFormationUI:OnClose(userData)
	return
end

function ChallengeDramaBossFormationUI:OnAddListeners()
	self.FormationPanelController:AddEventListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.delegateConfirmBtn)
end

function ChallengeDramaBossFormationUI:OnRemoveListeners()
	self.FormationPanelController:RemoveEventListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.delegateConfirmBtn)
end

function ChallengeDramaBossFormationUI:OnPause()
	return
end

function ChallengeDramaBossFormationUI:OnResume()
	return
end

function ChallengeDramaBossFormationUI:OnCover()
	return
end

function ChallengeDramaBossFormationUI:OnReveal()
	return
end

function ChallengeDramaBossFormationUI:OnRefocus(userData)
	return
end

function ChallengeDramaBossFormationUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ChallengeDramaBossFormationUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ChallengeDramaBossFormationUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ChallengeDramaBossFormationUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ChallengeDramaBossFormationUI:OnDestroy()
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

function ChallengeDramaBossFormationUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.ChallengeDramaBossFormationUI)
end

function ChallengeDramaBossFormationUI:UpdateView()
	self.FormationPanelController:UpdateView()

	local cfg = CfgPlotChallengeActivityTable[self.cfgCid]

	UGUIUtil.SetText(self.MazeOrderText, cfg.TitleNum)

	local show = false

	if #cfg.ChallengeNeed > 1 then
		show = true

		local cfgItemData = CfgItemTable[cfg.ChallengeNeed[1]]

		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgItemData.Icon), self.CostItemIcon:GetComponent("Image"))

		local cost = cfg.ChallengeNeed[2]

		UGUIUtil.SetText(self.CostItemNumText, ChallengeDramaBossFormationUIApi:GetString("CostItemNumText", cost, cost > WarehouseModule.GetItemNumByCfgID(Constant.ItemID.ENERGY)))
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

function ChallengeDramaBossFormationUI:ClearMonsterElementCells(isDestroy)
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

function ChallengeDramaBossFormationUI:OnUpdateFormation()
	local cfg = CfgPlotChallengeActivityTable[self.cfgCid]

	UGUIUtil.SetText(self.RecommendPowerText, ChallengeDramaBossFormationUIApi:GetString("RecommendPowerText", cfg.RecommendPower))
	UGUIUtil.SetText(self.FormationPowerText, ChallengeDramaBossFormationUIApi:GetString("FormationPowerText", self.FormationPanelController:GetPower(), cfg.RecommendPower))
end

function ChallengeDramaBossFormationUI:OnBtnConfirm()
	if #PlayerModule.PlayerInfo.formations == 0 then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, ChallengeDramaBossFormationUIApi:GetString("NoFormations"))

		return
	end

	local valid, formationPOD = self.FormationPanelController:CheckValidation()

	if not formationPOD then
		return
	end

	if not valid then
		return
	end

	local isStrength = WarehouseModule.GetItemNumByCfgID(Constant.ItemID.ENERGY) < CfgPlotChallengeActivityTable[self.cfgCid].ChallengeNeed[2]

	if isStrength then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, ChallengeUIApi:GetString("TextNotice8"))

		return
	end

	PlotChallengeModule.TriggerChallengeFight(self.cfgCid, formationPOD.id)
end

return ChallengeDramaBossFormationUI
