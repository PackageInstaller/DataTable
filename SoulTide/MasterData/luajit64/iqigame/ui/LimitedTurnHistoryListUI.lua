-- chunkname: @IQIGame\\UI\\LimitedTurnHistoryListUI.lua

local LimitedTurnHistoryListUI = {
	limitedTurnHistoryItemCellPool = {}
}

LimitedTurnHistoryListUI = Base:Extend("LimitedTurnHistoryListUI", "IQIGame.Onigao.UI.LimitedTurnHistoryListUI", LimitedTurnHistoryListUI)

require("IQIGame.UIExternalApi.LimitedTurnHistoryListUIApi")

local LimitedTurnHistoryItemCell = require("IQIGame.UI.Activity.LimitedTurn.LimitedTurnHistoryItemCell")

function LimitedTurnHistoryListUI:OnInit()
	UGUIUtil.SetText(self.TitleText, LimitedTurnHistoryListUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.NameLabel, LimitedTurnHistoryListUIApi:GetString("NameLabel"))
	UGUIUtil.SetText(self.TimeLabel, LimitedTurnHistoryListUIApi:GetString("TimeLabel"))
	UGUIUtil.SetText(self.TextNone, LimitedTurnHistoryListUIApi:GetString("TextNone"))
	UGUIUtil.SetText(self.TipText, LimitedTurnHistoryListUIApi:GetString("TipText"))

	self.scrollAreaList = self.ScrollAreaList:GetComponent("ScrollAreaList")

	function self.scrollAreaList.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	function self.delegateBtnClose()
		self:OnBtnClose()
	end
end

function LimitedTurnHistoryListUI:GetPreloadAssetPaths()
	return nil
end

function LimitedTurnHistoryListUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function LimitedTurnHistoryListUI:IsManualShowOnOpen(userData)
	return false
end

function LimitedTurnHistoryListUI:GetBGM(userData)
	return nil
end

function LimitedTurnHistoryListUI:OnOpen(userData)
	self.limitedDrawHistory = userData

	self:UpdateView()
end

function LimitedTurnHistoryListUI:OnClose(userData)
	return
end

function LimitedTurnHistoryListUI:OnAddListeners()
	self.CloseBtn2:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
end

function LimitedTurnHistoryListUI:OnRemoveListeners()
	self.CloseBtn2:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
end

function LimitedTurnHistoryListUI:OnPause()
	return
end

function LimitedTurnHistoryListUI:OnResume()
	return
end

function LimitedTurnHistoryListUI:OnCover()
	return
end

function LimitedTurnHistoryListUI:OnReveal()
	return
end

function LimitedTurnHistoryListUI:OnRefocus(userData)
	return
end

function LimitedTurnHistoryListUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function LimitedTurnHistoryListUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LimitedTurnHistoryListUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LimitedTurnHistoryListUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LimitedTurnHistoryListUI:OnDestroy()
	for i, v in pairs(self.limitedTurnHistoryItemCellPool) do
		v:Dispose()
	end
end

function LimitedTurnHistoryListUI:UpdateView()
	if self.limitedDrawHistory and #self.limitedDrawHistory > 0 then
		self.NoRecordView:SetActive(false)
		table.sort(self.limitedDrawHistory, function(a, b)
			return a.time > b.time
		end)
		self.scrollAreaList:Refresh(#self.limitedDrawHistory)
	else
		self.NoRecordView:SetActive(true)
	end
end

function LimitedTurnHistoryListUI:OnRenderCell(cell)
	local limitTurnTableHistoryPOD = self.limitedDrawHistory[cell.index + 1]

	if limitTurnTableHistoryPOD == nil then
		cell.gameObject:SetActive(false)

		return
	end

	local insID = cell.gameObject:GetInstanceID()
	local HistoryItemCell = self.limitedTurnHistoryItemCellPool[insID]

	if HistoryItemCell == nil then
		HistoryItemCell = LimitedTurnHistoryItemCell.New(cell.gameObject)
		self.limitedTurnHistoryItemCellPool[insID] = HistoryItemCell
	end

	HistoryItemCell:SetData(limitTurnTableHistoryPOD)
end

function LimitedTurnHistoryListUI:OnBtnClose()
	UIModule.CloseSelf(self)
end

return LimitedTurnHistoryListUI
