-- chunkname: @IQIGame\\UI\\LimitedTurnRewardListUI.lua

local LimitedTurnRewardListUI = {
	showTable = {},
	LimitedTurnRewardListCellPool = {}
}

LimitedTurnRewardListUI = Base:Extend("LimitedTurnRewardListUI", "IQIGame.Onigao.UI.LimitedTurnRewardListUI", LimitedTurnRewardListUI)

require("IQIGame.UIExternalApi.LimitedTurnRewardListUIApi")

local LimitedTurnRewardListCell = require("IQIGame.UI.Activity.LimitedTurn.LimitedTurnRewardListCell")

function LimitedTurnRewardListUI:OnInit()
	UGUIUtil.SetText(self.goTitle, LimitedTurnRewardListUIApi:GetString("goTitle"))

	self.scrollList = self.goList:GetComponent("ScrollAreaList")

	function self.scrollList.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	function self.delegateBtnClose()
		self:OnBtnClose()
	end
end

function LimitedTurnRewardListUI:GetPreloadAssetPaths()
	return nil
end

function LimitedTurnRewardListUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function LimitedTurnRewardListUI:IsManualShowOnOpen(userData)
	return false
end

function LimitedTurnRewardListUI:GetBGM(userData)
	return nil
end

function LimitedTurnRewardListUI:OnOpen(userData)
	self.operateEventID = userData
	self.showTable = ActiveLimitedTurnModule.GetCfgData(self.operateEventID)

	self:UpdateView()
end

function LimitedTurnRewardListUI:OnClose(userData)
	return
end

function LimitedTurnRewardListUI:OnAddListeners()
	self.goBtnClose2:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.goBtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
end

function LimitedTurnRewardListUI:OnRemoveListeners()
	self.goBtnClose2:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.goBtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
end

function LimitedTurnRewardListUI:OnPause()
	return
end

function LimitedTurnRewardListUI:OnResume()
	return
end

function LimitedTurnRewardListUI:OnCover()
	return
end

function LimitedTurnRewardListUI:OnReveal()
	return
end

function LimitedTurnRewardListUI:OnRefocus(userData)
	return
end

function LimitedTurnRewardListUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function LimitedTurnRewardListUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LimitedTurnRewardListUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LimitedTurnRewardListUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LimitedTurnRewardListUI:OnDestroy()
	return
end

function LimitedTurnRewardListUI:UpdateView()
	self.scrollList:Refresh(#self.showTable)
end

function LimitedTurnRewardListUI:OnRenderCell(cell)
	local cfgData = self.showTable[cell.index + 1]

	if cfgData == nil then
		cell.gameObject:SetActive(false)

		return
	end

	local insID = cell.gameObject:GetInstanceID()
	local rewardListCell = self.LimitedTurnRewardListCellPool[insID]

	if rewardListCell == nil then
		rewardListCell = LimitedTurnRewardListCell.New(cell.gameObject)
		self.LimitedTurnRewardListCellPool[insID] = rewardListCell
	end

	local probability = ActiveLimitedTurnModule.GetProbability(self.operateEventID, cfgData.Id)

	rewardListCell:SetData(cfgData, probability)
end

function LimitedTurnRewardListUI:OnBtnClose()
	UIModule.CloseSelf(self)
end

return LimitedTurnRewardListUI
