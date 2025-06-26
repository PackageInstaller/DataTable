-- chunkname: @IQIGame\\UI\\LotteryHistoryUI.lua

local LotteryHistoryUI = {
	HistoryItems = {}
}

LotteryHistoryUI = Base:Extend("LotteryHistoryUI", "IQIGame.Onigao.UI.LotteryHistoryUI", LotteryHistoryUI)

local LotteryHistoryItem = require("IQIGame.UI.Lottery.LotteryHistoryItem")

function LotteryHistoryUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	local scrollAreaList = self.ScrollAreaList:GetComponent("ScrollAreaList")

	function scrollAreaList.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	UGUIUtil.SetText(self.TitleText, LotteryHistoryUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.TypeLabel, LotteryHistoryUIApi:GetString("TypeLabel"))
	UGUIUtil.SetText(self.NameLabel, LotteryHistoryUIApi:GetString("NameLabel"))
	UGUIUtil.SetText(self.TimeLabel, LotteryHistoryUIApi:GetString("TimeLabel"))
	UGUIUtil.SetText(self.TipText, LotteryHistoryUIApi:GetString("TipText"))
	UGUIUtil.SetTextInChildren(self.NoRecordView, LotteryHistoryUIApi:GetString("NoRecordViewText"))
end

function LotteryHistoryUI:GetPreloadAssetPaths()
	return nil
end

function LotteryHistoryUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function LotteryHistoryUI:IsManualShowOnOpen(userData)
	return false
end

function LotteryHistoryUI:GetBGM(userData)
	return nil
end

function LotteryHistoryUI:OnOpen(userData)
	self:UpdateView(userData.historyList)
end

function LotteryHistoryUI:OnClose(userData)
	return
end

function LotteryHistoryUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn2:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function LotteryHistoryUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn2:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function LotteryHistoryUI:OnPause()
	return
end

function LotteryHistoryUI:OnResume()
	return
end

function LotteryHistoryUI:OnCover()
	return
end

function LotteryHistoryUI:OnReveal()
	return
end

function LotteryHistoryUI:OnRefocus(userData)
	return
end

function LotteryHistoryUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function LotteryHistoryUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LotteryHistoryUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LotteryHistoryUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LotteryHistoryUI:OnDestroy()
	for gameObject, item in pairs(self.HistoryItems) do
		item:Dispose()
	end
end

function LotteryHistoryUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function LotteryHistoryUI:UpdateView(historyList)
	self.HistoryList = historyList

	local scrollAreaList = self.ScrollAreaList:GetComponent("ScrollAreaList")

	scrollAreaList:Refresh(#self.HistoryList)
	self.NoRecordView:SetActive(#self.HistoryList == 0)
end

function LotteryHistoryUI:OnRenderCell(cell)
	local historyItem = self.HistoryItems[cell.gameObject]

	if historyItem == nil then
		historyItem = LotteryHistoryItem.New(cell.gameObject)
		self.HistoryItems[cell.gameObject] = historyItem
	end

	historyItem:SetData(self.HistoryList[cell.index + 1])
end

return LotteryHistoryUI
