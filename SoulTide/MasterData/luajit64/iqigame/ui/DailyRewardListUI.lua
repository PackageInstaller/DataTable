-- chunkname: @IQIGame\\UI\\DailyRewardListUI.lua

local DailyRewardListUI = {
	showTable = {},
	luckyTurnRewardListCellPool = {}
}

DailyRewardListUI = Base:Extend("DailyRewardListUI", "IQIGame.Onigao.UI.DailyRewardListUI", DailyRewardListUI)

local LuckyTurnRewardListCell = require("IQIGame.UI.Activity.LuckyTurnTable.LuckyTurnRewardListCell")

function DailyRewardListUI:OnInit()
	UGUIUtil.SetText(self.goTitle, DailyRewardListUIApi:GetString("goTitle"))

	self.scrollList = self.goList:GetComponent("ScrollAreaList")

	function self.scrollList.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	function self.delegateBtnClose()
		self:OnBtnClose()
	end
end

function DailyRewardListUI:GetPreloadAssetPaths()
	return nil
end

function DailyRewardListUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function DailyRewardListUI:IsManualShowOnOpen(userData)
	return false
end

function DailyRewardListUI:GetBGM(userData)
	return nil
end

function DailyRewardListUI:OnOpen(userData)
	self.showTable = ActiveLuckyTurnTableModule.GetCfgData()

	self:UpdateView()
end

function DailyRewardListUI:OnClose(userData)
	return
end

function DailyRewardListUI:OnAddListeners()
	self.goBtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.goBtnClose2:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
end

function DailyRewardListUI:OnRemoveListeners()
	self.goBtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.goBtnClose2:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
end

function DailyRewardListUI:OnPause()
	return
end

function DailyRewardListUI:OnResume()
	return
end

function DailyRewardListUI:OnCover()
	return
end

function DailyRewardListUI:OnReveal()
	return
end

function DailyRewardListUI:OnRefocus(userData)
	return
end

function DailyRewardListUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function DailyRewardListUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function DailyRewardListUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function DailyRewardListUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function DailyRewardListUI:OnDestroy()
	return
end

function DailyRewardListUI:UpdateView()
	self.scrollList:Refresh(#self.showTable)
end

function DailyRewardListUI:OnRenderCell(cell)
	local cfgData = self.showTable[cell.index + 1]

	if cfgData == nil then
		cell.gameObject:SetActive(false)

		return
	end

	local insID = cell.gameObject:GetInstanceID()
	local rewardListCell = self.luckyTurnRewardListCellPool[insID]

	if rewardListCell == nil then
		rewardListCell = LuckyTurnRewardListCell.New(cell.gameObject)
		self.luckyTurnRewardListCellPool[insID] = rewardListCell
	end

	rewardListCell:SetData(cfgData)
end

function DailyRewardListUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.DailyRewardListUI)
end

return DailyRewardListUI
