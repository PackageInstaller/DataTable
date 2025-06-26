-- chunkname: @IQIGame\\UI\\ActiveWeekendUI.lua

local ActiveWeekendUI = Base:Extend("ActiveWeekendUI", "IQIGame.Onigao.UI.ActiveWeekendUI", {
	tabTopCellPool = {}
})
local TabTopCell = require("IQIGame.UI.ActiveWeekend.TabTopCell")
local GrowUpView = require("IQIGame.UI.ActiveWeekend.NewPlayerGrowUp.GrowUpView")

function ActiveWeekendUI:OnInit()
	self:Initialize()
end

function ActiveWeekendUI:GetPreloadAssetPaths()
	return nil
end

function ActiveWeekendUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ActiveWeekendUI:IsManualShowOnOpen(userData)
	return false
end

function ActiveWeekendUI:GetBGM(userData)
	return nil
end

function ActiveWeekendUI:OnOpen(userData)
	self:Refresh(userData)
end

function ActiveWeekendUI:OnClose(userData)
	self:OnHide(userData)
end

function ActiveWeekendUI:OnPause()
	return
end

function ActiveWeekendUI:OnResume()
	return
end

function ActiveWeekendUI:OnCover()
	return
end

function ActiveWeekendUI:OnReveal()
	return
end

function ActiveWeekendUI:OnRefocus(userData)
	return
end

function ActiveWeekendUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ActiveWeekendUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ActiveWeekendUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ActiveWeekendUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ActiveWeekendUI:Initialize()
	self.moneyCellBuilder = MoneyCellsBuilder.New(self.goMoneyParent)
	self.energyCell = EnergyCell.New(self.EnergyCom.transform:GetChild(0).gameObject)
	self.btnClose = self.goBtnClose:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.onTaskCommitResponseDelegate(cids, awards)
		self:OnTaskCommitResponse(cids, awards)
	end

	function self.onTaskUpdateDelegate(id)
		self:OnTaskUpdate(id)
	end

	self.tabTopCellPool[1] = TabTopCell.New(self.goTabTopCell, self)
	self.goTitle:GetComponent("Text").text = ActiveWeekendUIApi:GetString("title")
end

function ActiveWeekendUI:Refresh(userData)
	self.defaultIndex = userData

	if self.defaultIndex == nil then
		self.defaultIndex = 1
	end

	self:RefreshMisc()
	self:RefreshTabTop()
end

function ActiveWeekendUI:OnHide()
	if self.growUpView ~= nil then
		self.growUpView:OnHide()
	end

	for i, v in pairs(self.tabTopCellPool) do
		v:OnHide()
	end
end

function ActiveWeekendUI:OnDestroy()
	self.moneyCellBuilder:Dispose()
	self.energyCell:Dispose()

	if self.growUpView ~= nil then
		self.growUpView:OnDestroy()
	end

	for i, v in pairs(self.tabTopCellPool) do
		v:OnDestroy()
	end
end

function ActiveWeekendUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	EventDispatcher.AddEventListener(EventID.TaskUpdate, self.onTaskUpdateDelegate)
	EventDispatcher.AddEventListener(EventID.TaskCommitResponse, self.onTaskCommitResponseDelegate)
end

function ActiveWeekendUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	EventDispatcher.RemoveEventListener(EventID.TaskUpdate, self.onTaskUpdateDelegate)
	EventDispatcher.RemoveEventListener(EventID.TaskCommitResponse, self.onTaskCommitResponseDelegate)
end

function ActiveWeekendUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function ActiveWeekendUI:OnClickTabTop(index)
	self.curSelectTabTopIndex = index

	if self.growUpView ~= nil then
		self.growUpView:Close()
	end

	if index == 1 or index == 2 then
		if self.growUpView == nil then
			self.growUpView = GrowUpView.New(self.goGrowUpView)
		end

		self.growUpView:Open(index)
	end
end

function ActiveWeekendUI:OnTaskUpdate(id)
	return
end

function ActiveWeekendUI:OnTaskCommitResponse(cids, rewards)
	if #rewards > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, rewards)
	end

	if self.curSelectTabTopIndex == 1 or self.curSelectTabTopIndex == 2 then
		self.growUpView:OnTaskCommitResponse()
	end

	for i, v in pairs(self.tabTopCellPool) do
		v:RefreshRedPoint()
	end
end

function ActiveWeekendUI:RefreshMisc()
	self.moneyCellBuilder:RefreshView({
		Constant.ItemID.MONEY,
		Constant.ItemID.TREASURE,
		Constant.ItemID.ID_PAYPOINT_SHOW
	})
end

function ActiveWeekendUI:RefreshTabTop()
	for i, v in ipairs(self.tabTopCellPool) do
		v:Close()
	end

	for i = 1, 2 do
		local cell = self.tabTopCellPool[i]

		if cell == nil then
			local go = UnityEngine.Object.Instantiate(self.goTabTopCell)

			go.transform:SetParent(self.goTabTopCell.transform.parent, false)

			cell = TabTopCell.New(go, self)
			self.tabTopCellPool[i] = cell
		end

		cell:Open(i, self.defaultIndex)
	end
end

return ActiveWeekendUI
