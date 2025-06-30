-- chunkname: @IQIGame\\UI\\MazeBossUI.lua

local MazeBossUI = {
	MonsterList = {},
	MonsterElementCells = {},
	CurrencyControllers = {},
	monsterHeadCells = {}
}

MazeBossUI = Base:Extend("MazeBossUI", "IQIGame.Onigao.UI.MazeBossUI", MazeBossUI)

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MonsterElementCell = require("IQIGame.UI.MazeDetail.MonsterElementCell")
local FormationPanelController = require("IQIGame.UI.FormationUI.FormationPanelController")
local MonsterHeadCell = require("IQIGame.UI.Common.MonsterHeadCell")

function MazeBossUI:OnInit()
	function self.DelegateOnClickBackBtn()
		self:OnClickBackBtn()
	end

	function self.DelegateOnClickDetailsBtn()
		self:OnClickDetailsBtn()
	end

	function self.DelegateOnClickFightBtn()
		self:OnClickFightBtn()
	end

	function self.DelegateOnClickMonsterElementItem()
		self:OnClickMonsterElementItem()
	end

	self.MonsterElementPool = UIObjectPool.New(5, function()
		local cell = MonsterElementCell.New(UnityEngine.Object.Instantiate(self.MonsterElementItem))

		return cell
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)
	self.monsterHeadCellPool = UIObjectPool.New(10, function()
		return MonsterHeadCell.__New(UnityEngine.Object.Instantiate(self.MonsterItem))
	end, function(cell)
		cell:Dispose()
	end)
	self.FormationPanelController = FormationPanelController.New(self.FormationPanel, function()
		self:OnUpdateFormation()
	end)
	self.EnergyCell = EnergyCell.New(self.EnergyGrid.transform:GetChild(0).gameObject)
	self.CurrencyControllers = {}

	self:AddCurrencyCell(Constant.ItemID.MONEY)
	self:AddCurrencyCell(Constant.ItemID.TREASURE)
end

function MazeBossUI:GetPreloadAssetPaths()
	return nil
end

function MazeBossUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MazeBossUI:IsManualShowOnOpen(userData)
	return false
end

function MazeBossUI:GetBGM(userData)
	return nil
end

function MazeBossUI:OnOpen(userData)
	self:UpdateView(userData.mazeCid)
end

function MazeBossUI:OnClose(userData)
	return
end

function MazeBossUI:OnAddListeners()
	self.FormationPanelController:AddEventListeners()
	self.BackBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBackBtn)
	self.DetailsBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickDetailsBtn)
	self.FightBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickFightBtn)
	self.MonsterElementItem:GetComponent("Button").onClick:AddListener(self.DelegateOnClickMonsterElementItem)
end

function MazeBossUI:OnRemoveListeners()
	self.FormationPanelController:RemoveEventListeners()
	self.BackBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBackBtn)
	self.DetailsBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickDetailsBtn)
	self.FightBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickFightBtn)
	self.MonsterElementItem:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickMonsterElementItem)
end

function MazeBossUI:OnPause()
	return
end

function MazeBossUI:OnResume()
	return
end

function MazeBossUI:OnCover()
	return
end

function MazeBossUI:OnReveal()
	return
end

function MazeBossUI:OnRefocus(userData)
	return
end

function MazeBossUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MazeBossUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MazeBossUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MazeBossUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MazeBossUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.EnergyCell:Dispose()

	for i = 1, #self.CurrencyControllers do
		self.CurrencyControllers[i]:Dispose()
	end

	self.MonsterElementPool:Dispose()

	for i = 1, #self.MonsterElementCells do
		local itemCell = self.MonsterElementCells[i]

		itemCell:Dispose()
	end

	self.MonsterElementCells = nil

	self.FormationPanelController:Dispose()

	for i, v in pairs(self.monsterHeadCells) do
		self.monsterHeadCellPool:Release(v)
	end

	self.monsterHeadCells = {}

	self.monsterHeadCellPool:Dispose()
end

function MazeBossUI:OnClickBackBtn()
	UIModule.Close(Constant.UIControllerName.MazeBossUI)
end

function MazeBossUI:OnClickDetailsBtn()
	return
end

function MazeBossUI:OnClickFightBtn()
	local valid, formationPOD = self.FormationPanelController:CheckValidation()

	if not formationPOD then
		return
	end

	if not valid then
		-- block empty
	end

	self.formationID = formationPOD.id

	MazeModule.QuickChallenge(self.MazeCid, self.formationID)
end

function MazeBossUI:OnClickMonsterElementItem()
	return
end

function MazeBossUI:UpdateView(mazeCid)
	self.MazeCid = mazeCid
	self.MazeInstanceData = CfgMazeInstanceTable[self.MazeCid]
	self.MonsterTeamId = self.MazeInstanceData.QuickChallengeMonsterTeam
	self.ChapterData = CfgChapterTable[self.MazeInstanceData.ChapterId]

	self:Refresh()
end

function MazeBossUI:Refresh()
	UGUIUtil.SetText(self.ChapterOrder, MazeDetailUIApi:GetString("MazeOrderText", self.ChapterData.Order, self.MazeInstanceData.Order))
	UGUIUtil.SetText(self.ChapterOrderName, self.MazeInstanceData.Name)
	UGUIUtil.SetText(self.ChapterOrderDesc, self.MazeInstanceData.Desc)
	self:UpdateCost()
	self:UpdateMonsterCells(self.MonsterTeamId)
	self:ClearMonsterElementCells(false)
	self:ElementListRefresh(self.MazeInstanceData)
	self.FormationPanelController:UpdateView()
	UGUIUtil.SetText(self.RecommendedPower, MazeDetailUIApi:GetString("RecommendPowerText", self.cfgRecommendPowerData.QuickChallengeRecommendPower))
end

function MazeBossUI:UpdateMonsterCells(MonsterTeam)
	for i, v in pairs(self.monsterHeadCells) do
		self.monsterHeadCellPool:Release(v)
		v.goView:SetActive(false)
		v.goView.transform:SetParent(self.UIController.transform, false)
	end

	self.monsterHeadCells = {}

	if MonsterTeam <= 0 then
		return
	end

	local cfgMonsterTeam = CfgMonsterTeamTable[MonsterTeam]

	for i = 1, #cfgMonsterTeam.TeamUnit do
		local monsterID = cfgMonsterTeam.TeamUnit[i]
		local state = 0

		if monsterID > 0 and not CfgMonsterTable[monsterID].NotShowInUI then
			state = i < 6 and 1 or 2

			local monsterHeadCell = self.monsterHeadCellPool:Obtain()

			monsterHeadCell.goView:SetActive(true)
			monsterHeadCell.goView.transform:SetParent(self.MonsterGrid.transform, false)
			monsterHeadCell:SetData(monsterID, state)

			function monsterHeadCell.clickHandler(mId)
				self:OnClickMonsterCell(mId)
			end

			table.insert(self.monsterHeadCells, monsterHeadCell)
		end
	end
end

function MazeBossUI:OnClickMonsterCell(monsterID)
	UIModule.Open(Constant.UIControllerName.BattleMonsterInfoUI, Constant.UILayer.UI, {
		monsterCid = monsterID
	})
end

function MazeBossUI:ElementListRefresh(cfgMazeInstanceData)
	local elements = MazeModule.GetWeakShowData(cfgMazeInstanceData)

	for i = 1, #elements do
		local cell = self.MonsterElementPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.MonsterInfoGrid.transform, false)
		cell:SetData(elements[i], cfgMazeInstanceData.MainWeakType)
		table.insert(self.MonsterElementCells, cell)
	end
end

function MazeBossUI:OnUpdateFormation()
	local cfgRecommendPowerData = CfgRecommendPowerTable[self.MazeInstanceData.RecommendPowerId]

	self.cfgRecommendPowerData = cfgRecommendPowerData

	UGUIUtil.SetText(self.CurrentPower, MazeDetailUIApi:GetString("FormationPowerText", self.FormationPanelController:GetPower(), self.cfgRecommendPowerData.QuickChallengeRecommendPower))
end

function MazeBossUI:AddCurrencyCell(currencyCid)
	local currencyModule = UnityEngine.Object.Instantiate(self.MoneyItem)

	currencyModule.transform:SetParent(self.MoneyGrid.transform, false)
	table.insert(self.CurrencyControllers, CurrencyCell.New(currencyModule, currencyCid))
end

function MazeBossUI:UpdateCost()
	local mazeInfoPOD = PlayerModule.PlayerInfo.mazeInfoPOD[self.MazeCid]
	local cfgItemData = CfgItemTable[Constant.ItemID.ENERGY]

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgItemData.Icon), self.CostItemIcon:GetComponent("Image"), nil, nil, nil, true)

	self.isQuickFinished = table.indexOf(PlayerModule.PlayerInfo.quickChallenge, self.MazeInstanceData.Id) ~= -1

	local isFirst = mazeInfoPOD == nil

	if self.isQuickFinished then
		isFirst = false
	end

	self.FirstEnergyView:SetActive(isFirst and self.MazeInstanceData.FirstCost < self.MazeInstanceData.Cost)

	local cost = self.MazeInstanceData.Cost

	if isFirst then
		cost = self.MazeInstanceData.FirstCost
	end

	UGUIUtil.SetText(self.CostItemNumText, MazeDetailUIApi:GetString("CostItemNumText", cost, cost > WarehouseModule.GetItemNumByCfgID(Constant.ItemID.ENERGY)))
end

function MazeBossUI:ClearMonsterElementCells(isDestroy)
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

return MazeBossUI
