-- chunkname: @IQIGame\\UI\\TowerMonsterInfoTipsUI.lua

local TowerMonsterInfoTipsUI = Base:Extend("TowerMonsterInfoTipsUI", "IQIGame.Onigao.UI.TowerMonsterInfoTipsUI", {
	ItemCells = {},
	MonsterHeadCells = {}
})
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MonsterHeadCell = require("IQIGame.UI.Common.MonsterHeadCell")
local TowerRewardCell = require("IQIGame.UI.ChallengeTower.TowerRewardCell")

function TowerMonsterInfoTipsUI:OnInit()
	UGUIUtil.SetText(self.TitleText2, ChallengeTowerUIApi:GetString("TextMonsterInfoTip2"))
	UGUIUtil.SetText(self.TitleText3, ChallengeTowerUIApi:GetString("TextMonsterInfoTip3"))

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	self.ItemCellPool = UIObjectPool.New(10, function()
		return TowerRewardCell.New(UnityEngine.Object.Instantiate(self.RewardPrefab), UnityEngine.Object.Instantiate(self.UIController:GetPreloadedAsset(UIGlobalApi.GetItemCellAssetPath())))
	end, function(cell)
		cell:Dispose()
	end)
	self.MonsterHeadCellPool = UIObjectPool.New(10, function()
		return MonsterHeadCell.__New(UnityEngine.Object.Instantiate(self.UIController:GetPreloadedAsset(UIGlobalApi.GetMonsterHeadCellAssetPath())))
	end, function(cell)
		cell:Dispose()
	end)
end

function TowerMonsterInfoTipsUI:GetPreloadAssetPaths()
	local paths = {}

	table.insert(paths, UIGlobalApi.GetItemCellAssetPath())
	table.insert(paths, UIGlobalApi.GetMonsterHeadCellAssetPath())

	return paths
end

function TowerMonsterInfoTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function TowerMonsterInfoTipsUI:OnOpen(userData)
	self.cfgTowerFloor = userData

	self:UpdateView()
end

function TowerMonsterInfoTipsUI:OnClose(userData)
	return
end

function TowerMonsterInfoTipsUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.CloseBtn1:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
end

function TowerMonsterInfoTipsUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.CloseBtn1:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
end

function TowerMonsterInfoTipsUI:OnPause()
	return
end

function TowerMonsterInfoTipsUI:OnResume()
	return
end

function TowerMonsterInfoTipsUI:OnCover()
	return
end

function TowerMonsterInfoTipsUI:OnReveal()
	return
end

function TowerMonsterInfoTipsUI:OnRefocus(userData)
	return
end

function TowerMonsterInfoTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function TowerMonsterInfoTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function TowerMonsterInfoTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function TowerMonsterInfoTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function TowerMonsterInfoTipsUI:OnDestroy()
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
end

function TowerMonsterInfoTipsUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.TowerMonsterInfoTipsUI)
end

function TowerMonsterInfoTipsUI:UpdateView()
	if self.cfgTowerFloor then
		UGUIUtil.SetText(self.TitleText1, self.cfgTowerFloor.Name)
		self:UpdateMonsterCells(self.cfgTowerFloor.MonsterTeam)
		self:UpdateReWards(self.cfgTowerFloor.ClearReward)
	end
end

function TowerMonsterInfoTipsUI:UpdateMonsterCells(MonsterTeam)
	for i, v in pairs(self.MonsterHeadCells) do
		v:Dispose()
	end

	self.MonsterHeadCells = {}

	local cfgMonsterTeam = CfgMonsterTeamTable[MonsterTeam]

	for i = 1, #cfgMonsterTeam.TeamUnit do
		local monsterID = cfgMonsterTeam.TeamUnit[i]
		local state = 0

		if monsterID > 0 and not CfgMonsterTable[monsterID].NotShowInUI then
			state = i < 6 and 1 or 2

			local monsterHeadCell = self.MonsterHeadCellPool:Obtain()

			monsterHeadCell.goView:SetActive(true)
			monsterHeadCell.goView.transform:SetParent(self.MonsterList.transform, false)
			monsterHeadCell:SetData(monsterID, state)

			function monsterHeadCell.clickHandler(monsterID)
				self:OnClickMonsterCell(monsterID)
			end

			table.insert(self.MonsterHeadCells, monsterHeadCell)
		end
	end
end

function TowerMonsterInfoTipsUI:OnClickMonsterCell(monsterID)
	UIModule.Open(Constant.UIControllerName.BattleMonsterInfoUI, Constant.UILayer.UI, {
		monsterCid = monsterID
	})
end

function TowerMonsterInfoTipsUI:UpdateReWards(reward)
	for i, v in pairs(self.ItemCells) do
		self.ItemCellPool:Release(v)
		v.View:SetActive(false)
		v.View.transform:SetParent(self.UIController.transform, false)
	end

	self.ItemCells = {}

	for i = 1, #reward, 2 do
		local itemID = reward[i]
		local itemNum = reward[i + 1]

		if CfgItemTable[itemID].IsPanelShow then
			local itemCell = self.ItemCellPool:Obtain()

			itemCell.View:SetActive(true)
			itemCell.View.transform:SetParent(self.RewardList.transform, false)
			itemCell:SetData(itemID, itemNum, false)
			table.insert(self.ItemCells, itemCell)
		end
	end
end

return TowerMonsterInfoTipsUI
