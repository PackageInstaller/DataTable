-- chunkname: @IQIGame\\UI\\MiningChallengeDetailUI.lua

local MiningChallengeDetailUI = {
	enough = false,
	MonsterElementCells = {},
	ItemCells = {},
	MonsterHeadCells = {}
}

MiningChallengeDetailUI = Base:Extend("MiningChallengeDetailUI", "IQIGame.Onigao.UI.MiningChallengeDetailUI", MiningChallengeDetailUI)

require("IQIGame.UIExternalApi.MiningChallengeDetailUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MonsterElementCell = require("IQIGame.UI.MazeDetail.MonsterElementCell")
local MazeRewardCell = require("IQIGame.UI.MazeDetail.MazeRewardCell")
local MonsterHeadCell = require("IQIGame.UI.Common.MonsterHeadCell")
local FormationPanelController = require("IQIGame.UI.FormationUI.FormationPanelController")
local MiningTicketBuilder = require("IQIGame.UI.Mining.MiningTicketBuilder")

function MiningChallengeDetailUI:OnInit()
	UGUIUtil.SetText(self.TitleText, MiningChallengeDetailUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.MonsterPanelLabel, MiningChallengeDetailUIApi:GetString("MonsterPanelLabel"))
	UGUIUtil.SetText(self.RewardLabelText, MiningChallengeDetailUIApi:GetString("RewardLabelText"))
	UGUIUtil.SetTextInChildren(self.ConfirmBtn, MiningChallengeDetailUIApi:GetString("ConfirmBtnText"))
	UGUIUtil.SetText(self.MonsterMessageLabel, MiningChallengeDetailUIApi:GetString("MonsterMessageLabel"))

	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	self.energyCell = EnergyCell.New(self.EnergyCom.transform:GetChild(0).gameObject)
	self.miningTicketBuilder = MiningTicketBuilder.New(self.MoneyBuilder)
	self.moneyCellBuilder = MoneyCellsBuilder.New(self.CurrencyCom)
	self.FormationPanelController = FormationPanelController.New(self.FormationNode, function()
		self:OnUpdateFormation()
	end)
	self.MonsterElementPool = UIObjectPool.New(5, function()
		local cell = MonsterElementCell.New(UnityEngine.Object.Instantiate(self.MonsterElementPrefab))

		return cell
	end, function(cell)
		cell:Dispose()
	end)
	self.ItemCellPool = UIObjectPool.New(10, function()
		return MazeRewardCell.New(UnityEngine.Object.Instantiate(self.RewardPrefab))
	end, function(cell)
		cell:Dispose()
	end)

	self.MonsterHeadMould:SetActive(false)

	self.MonsterHeadCellPool = UIObjectPool.New(10, function()
		return MonsterHeadCell.__New(UnityEngine.Object.Instantiate(self.MonsterHeadMould))
	end, function(cell)
		cell:Dispose()
	end)
end

function MiningChallengeDetailUI:GetPreloadAssetPaths()
	return nil
end

function MiningChallengeDetailUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MiningChallengeDetailUI:IsManualShowOnOpen(userData)
	return false
end

function MiningChallengeDetailUI:GetBGM(userData)
	return nil
end

function MiningChallengeDetailUI:OnOpen(userData)
	self.plantData = userData

	self:UpdateView()
end

function MiningChallengeDetailUI:OnClose(userData)
	return
end

function MiningChallengeDetailUI:OnAddListeners()
	self.FormationPanelController:AddEventListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function MiningChallengeDetailUI:OnRemoveListeners()
	self.FormationPanelController:RemoveEventListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function MiningChallengeDetailUI:OnPause()
	return
end

function MiningChallengeDetailUI:OnResume()
	return
end

function MiningChallengeDetailUI:OnCover()
	return
end

function MiningChallengeDetailUI:OnReveal()
	return
end

function MiningChallengeDetailUI:OnRefocus(userData)
	return
end

function MiningChallengeDetailUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MiningChallengeDetailUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MiningChallengeDetailUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MiningChallengeDetailUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MiningChallengeDetailUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.FormationPanelController:Dispose()

	for i, v in pairs(self.MonsterElementCells) do
		self.MonsterElementPool:Release(v)
	end

	self.MonsterElementCells = {}

	self.MonsterElementPool:Dispose()

	for i, v in pairs(self.ItemCells) do
		self.ItemCellPool:Release(v)
	end

	self.ItemCells = {}

	self.ItemCellPool:Dispose()

	for i, v in pairs(self.MonsterHeadCells) do
		self.MonsterHeadCellPool:Release(v)
	end

	self.MonsterHeadCells = {}

	self.MonsterHeadCellPool:Dispose()
	self.energyCell:Dispose()

	self.energyCell = nil

	self.miningTicketBuilder:Dispose()

	self.miningTicketBuilder = nil

	self.moneyCellBuilder:Dispose()

	self.moneyCellBuilder = nil
end

function MiningChallengeDetailUI:UpdateView()
	self.FormationPanelController:UpdateView()

	for i, v in pairs(self.MonsterElementCells) do
		v.View.transform:SetParent(self.UIController.transform, false)
		v.View:SetActive(false)
		self.MonsterElementPool:Release(v)
	end

	local monsterTeam = self.plantData:GetCfgElementData().Parameter[1]

	self.MonsterElementCells = {}

	local tab = {}
	local cfgMonsterTeam = CfgMonsterTeamTable[monsterTeam]

	for i = 1, #cfgMonsterTeam.TeamUnit do
		local monsterID = cfgMonsterTeam.TeamUnit[i]

		if monsterID > 0 then
			local cfgMonster = CfgMonsterTable[monsterID]

			if #cfgMonster.WeakType > 0 then
				for i = 1, #cfgMonster.WeakType do
					local id = cfgMonster.WeakType[i]

					if tab[id] == nil then
						local t = {}

						t.weakType = id
						t.num = 1
						tab[id] = t
					else
						tab[id].num = tab[id].num + 1
					end
				end
			end
		end
	end

	local sortTab = {}

	for i, v in pairs(tab) do
		table.insert(sortTab, v)
	end

	table.sort(sortTab, function(a, b)
		local res = false

		if a.num == b.num then
			res = a.weakType < b.weakType
		else
			res = a.num > b.num
		end

		return res
	end)

	for i = 1, #sortTab do
		local data = sortTab[i]
		local cell = self.MonsterElementPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.MonsterElementGrid.transform, false)
		cell:SetData(data.weakType)
		table.insert(self.MonsterElementCells, cell)
	end

	for i, v in pairs(self.ItemCells) do
		self.ItemCellPool:Release(v)
		v.View:SetActive(false)
		v.View.transform:SetParent(self.UIController.transform, false)
	end

	self.ItemCells = {}

	for i = 1, #self.plantData:GetCfgElementData().RewardShow, 2 do
		local itemID = self.plantData:GetCfgElementData().RewardShow[i]
		local itemNum = self.plantData:GetCfgElementData().RewardShow[i + 1]
		local itemCell = self.ItemCellPool:Obtain()

		itemCell.View:SetActive(true)
		itemCell.View.transform:SetParent(self.RewardGrid.transform, false)
		itemCell:SetData(itemID, itemNum)
		table.insert(self.ItemCells, itemCell)
	end

	self:UpdateMonsterCells(cfgMonsterTeam)
	self:UpdateCost()
end

function MiningChallengeDetailUI:UpdateMonsterCells(cfgMonsterTeam)
	for i, v in pairs(self.MonsterHeadCells) do
		v:Dispose()
	end

	self.MonsterHeadCells = {}

	for i = 1, #cfgMonsterTeam.TeamUnit do
		local monsterID = cfgMonsterTeam.TeamUnit[i]
		local state = 0

		if monsterID > 0 and not CfgMonsterTable[monsterID].NotShowInUI then
			state = i < 6 and 1 or 2

			local monsterHeadCell = self.MonsterHeadCellPool:Obtain()

			monsterHeadCell.goView:SetActive(true)
			monsterHeadCell.goView.transform:SetParent(self.MonsterGrid.transform, false)
			monsterHeadCell:SetData(monsterID, state)

			function monsterHeadCell.clickHandler(monsterID)
				self:OnClickMonsterCell(monsterID)
			end

			table.insert(self.MonsterHeadCells, monsterHeadCell)
		end
	end
end

function MiningChallengeDetailUI:OnClickMonsterCell(monsterID)
	UIModule.Open(Constant.UIControllerName.BattleMonsterInfoUI, Constant.UILayer.UI, {
		monsterCid = monsterID
	})
end

function MiningChallengeDetailUI:OnUpdateFormation()
	self:ShowPower(self.FormationPanelController:GetPower(), 0)
end

function MiningChallengeDetailUI:ShowPower(power1, power2)
	self.RecommendPowerText:SetActive(false)
	UGUIUtil.SetText(self.RecommendPowerText, MiningChallengeDetailUIApi:GetString("RecommendPowerText", power2))
	UGUIUtil.SetText(self.FormationPowerText, MiningChallengeDetailUIApi:GetString("TextPower", power1, power2))
end

function MiningChallengeDetailUI:UpdateCost()
	self.enough = true

	local itemIds = {}
	local needEnergy = false

	if #self.plantData:GetCfgElementData().Cost > 0 then
		local itemId = self.plantData:GetCfgElementData().Cost[1]

		if itemId == Constant.ItemID.ENERGY then
			needEnergy = true
		else
			table.insert(itemIds, itemId)
		end

		local needNum = self.plantData:GetCfgElementData().Cost[2]
		local haveNum = WarehouseModule.GetItemNumByCfgID(itemId)
		local cfgItemData = CfgItemTable[itemId]

		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgItemData.Icon), self.CostItemIcon:GetComponent("Image"))

		self.enough = needNum <= haveNum

		UGUIUtil.SetText(self.CostItemNumText, MiningChallengeDetailUIApi:GetString("CostItemNumText", needNum, self.enough))
	end

	self.CostTitle:SetActive(needEnergy)
	self.moneyCellBuilder:RefreshView(itemIds)
end

function MiningChallengeDetailUI:OnClickConfirmBtn()
	if #PlayerModule.PlayerInfo.formations == 0 then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, MiningChallengeDetailUIApi:GetString("NoFormations"))

		return
	end

	local valid, formationPOD = self.FormationPanelController:CheckValidation()

	if not formationPOD then
		return
	end

	if not valid then
		return
	end

	if not self.enough then
		return
	end

	MiningModule.Interact(self.plantData.miningGridPOD.id, formationPOD.id)
end

function MiningChallengeDetailUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

return MiningChallengeDetailUI
