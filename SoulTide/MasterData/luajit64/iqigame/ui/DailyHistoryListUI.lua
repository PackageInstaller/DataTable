-- chunkname: @IQIGame\\UI\\DailyHistoryListUI.lua

local DailyHistoryListUI = {
	luckyTurnHistoryItemCellPool = {}
}

DailyHistoryListUI = Base:Extend("DailyHistoryListUI", "IQIGame.Onigao.UI.DailyHistoryListUI", DailyHistoryListUI)

local LuckyTurnHistoryItemCell = require("IQIGame.UI.Activity.LuckyTurnTable.LuckyTurnHistoryItemCell")

function DailyHistoryListUI:OnInit()
	UGUIUtil.SetText(self.TitleText, DailyHistoryListUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.NameLabel, DailyHistoryListUIApi:GetString("NameLabel"))
	UGUIUtil.SetText(self.TimeLabel, DailyHistoryListUIApi:GetString("TimeLabel"))
	UGUIUtil.SetText(self.TextNone, DailyHistoryListUIApi:GetString("TextNone"))
	UGUIUtil.SetText(self.TipText, DailyHistoryListUIApi:GetString("TipText"))

	self.scrollAreaList = self.ScrollAreaList:GetComponent("ScrollAreaList")

	function self.scrollAreaList.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	function self.delegateBtnClose()
		self:OnBtnClose()
	end
end

function DailyHistoryListUI:GetPreloadAssetPaths()
	return nil
end

function DailyHistoryListUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function DailyHistoryListUI:IsManualShowOnOpen(userData)
	return false
end

function DailyHistoryListUI:GetBGM(userData)
	return nil
end

function DailyHistoryListUI:OnOpen(userData)
	self.luckDrawHistory = userData

	self:UpdateView()
end

function DailyHistoryListUI:OnClose(userData)
	return
end

function DailyHistoryListUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.CloseBtn2:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
end

function DailyHistoryListUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.CloseBtn2:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
end

function DailyHistoryListUI:OnPause()
	return
end

function DailyHistoryListUI:OnResume()
	return
end

function DailyHistoryListUI:OnCover()
	return
end

function DailyHistoryListUI:OnReveal()
	return
end

function DailyHistoryListUI:OnRefocus(userData)
	return
end

function DailyHistoryListUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function DailyHistoryListUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function DailyHistoryListUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function DailyHistoryListUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function DailyHistoryListUI:OnDestroy()
	for i, v in pairs(self.luckyTurnHistoryItemCellPool) do
		v:Dispose()
	end
end

function DailyHistoryListUI:UpdateView()
	if self.luckDrawHistory and #self.luckDrawHistory > 0 then
		self.NoRecordView:SetActive(false)
		table.sort(self.luckDrawHistory, function(a, b)
			return a.time > b.time
		end)
		self.scrollAreaList:Refresh(#self.luckDrawHistory)
	else
		self.NoRecordView:SetActive(true)
	end
end

function DailyHistoryListUI:OnRenderCell(cell)
	local LuckDrawHistoryPOD = self.luckDrawHistory[cell.index + 1]

	if LuckDrawHistoryPOD == nil then
		cell.gameObject:SetActive(false)

		return
	end

	local insID = cell.gameObject:GetInstanceID()
	local HistoryItemCell = self.luckyTurnHistoryItemCellPool[insID]

	if HistoryItemCell == nil then
		HistoryItemCell = LuckyTurnHistoryItemCell.New(cell.gameObject)
		self.luckyTurnHistoryItemCellPool[insID] = HistoryItemCell
	end

	HistoryItemCell:SetData(LuckDrawHistoryPOD)
end

function DailyHistoryListUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.DailyHistoryListUI)
end

return DailyHistoryListUI
