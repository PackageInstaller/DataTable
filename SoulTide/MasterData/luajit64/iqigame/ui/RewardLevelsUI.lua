-- chunkname: @IQIGame\\UI\\RewardLevelsUI.lua

local RewardLevelsUI = {
	rewardLevelsCellPool = {},
	upgradeBigBattleTab = {}
}

RewardLevelsUI = Base:Extend("RewardLevelsUI", "IQIGame.Onigao.UI.RewardLevelsUI", RewardLevelsUI)

local RewardLevelsCell = require("IQIGame.UI.RewardLevels.RewardLevelsCell")

function RewardLevelsUI:OnInit()
	UGUIUtil.SetText(self.goTitle, RewardLevelsUIApi:GetString("goTitle"))
	UGUIUtil.SetText(self.TextSoul, RewardLevelsUIApi:GetString("TextSoul"))

	self.scrollList = self.ScrollArea:GetComponent("ScrollAreaList")

	function self.scrollList.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegatePlayerInfoChanged()
		self:OnPlayerInfoChanged()
	end

	function self.delegateUpgradeBigBattle()
		self:OnUpgradeBigBattle()
	end
end

function RewardLevelsUI:GetPreloadAssetPaths()
	return nil
end

function RewardLevelsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RewardLevelsUI:IsManualShowOnOpen(userData)
	return false
end

function RewardLevelsUI:GetBGM(userData)
	return nil
end

function RewardLevelsUI:OnOpen(userData)
	ActiveModule.GetLvReachRewardList()
	self:UpdateView()
end

function RewardLevelsUI:OnClose(userData)
	return
end

function RewardLevelsUI:OnAddListeners()
	self.goBtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	EventDispatcher.AddEventListener(EventID.PlayerInfoChanged, self.delegatePlayerInfoChanged)
	EventDispatcher.AddEventListener(EventID.UpdateUpgradeBigBattle, self.delegateUpgradeBigBattle)
end

function RewardLevelsUI:OnRemoveListeners()
	self.goBtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	EventDispatcher.RemoveEventListener(EventID.PlayerInfoChanged, self.delegatePlayerInfoChanged)
	EventDispatcher.RemoveEventListener(EventID.UpdateUpgradeBigBattle, self.delegateUpgradeBigBattle)
end

function RewardLevelsUI:OnPause()
	return
end

function RewardLevelsUI:OnResume()
	return
end

function RewardLevelsUI:OnCover()
	return
end

function RewardLevelsUI:OnReveal()
	return
end

function RewardLevelsUI:OnRefocus(userData)
	return
end

function RewardLevelsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RewardLevelsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RewardLevelsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RewardLevelsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RewardLevelsUI:OnDestroy()
	for i, v in pairs(self.rewardLevelsCellPool) do
		v:Dispose()
	end
end

function RewardLevelsUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.RewardLevelsUI)
end

function RewardLevelsUI:OnPlayerInfoChanged()
	self:UpdateView()
end

function RewardLevelsUI:OnUpgradeBigBattle()
	self:UpdateView()
end

function RewardLevelsUI:UpdateView()
	self.upgradeBigBattleTab = {}

	if ActiveModule.idsList then
		for i, v in pairs(ActiveModule.idsList) do
			local cfgUpgradeBigBattle = CfgUpgradeBigBattleTable[v]

			table.insert(self.upgradeBigBattleTab, cfgUpgradeBigBattle)
		end
	end

	table.sort(self.upgradeBigBattleTab, function(a, b)
		return a.Id < b.Id
	end)
	self.scrollList:Refresh(#self.upgradeBigBattleTab)
	UGUIUtil.SetText(self.TextSoulLv, PlayerModule.PlayerInfo.baseInfo.pLv)
end

function RewardLevelsUI:OnRenderGridCell(cell)
	local data = self.upgradeBigBattleTab[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local renderCell = self.rewardLevelsCellPool[instanceID]

	if renderCell == nil then
		renderCell = RewardLevelsCell.New(cell.gameObject)
		self.rewardLevelsCellPool[instanceID] = renderCell
	end

	renderCell:SetData(data)
end

return RewardLevelsUI
