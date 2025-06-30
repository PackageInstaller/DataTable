-- chunkname: @IQIGame\\UI\\ActiveRookieUI.lua

local ActiveRookieUI = Base:Extend("ActiveRookieUI", "IQIGame.Onigao.UI.ActiveRookieUI", {
	tabCellPool = {}
})
local RookieTabCell = require("IQIGame.UI.ActiveRookie.RookieTabCell")
local RookieSignInView = require("IQIGame.UI.ActiveRookie.RookieSignIn.RookieSignInView")
local RookieTaskView = require("IQIGame.UI.ActiveRookie.RookieTask.RookieTaskView")

function ActiveRookieUI:OnInit()
	self:Initialize()
end

function ActiveRookieUI:GetPreloadAssetPaths()
	self.tabCount = 0

	for i, v in pairsCfg(CfgMainQuestTable) do
		if v.Type == TaskModule.TaskType.ROOKIE_TASK and v.TypeParam[1] > self.tabCount then
			self.tabCount = v.TypeParam[1]
		end
	end

	local ret = {}

	for i = 1, self.tabCount do
		ret[#ret + 1] = ActiveRookieUIApi:GetString("tabIconPath", i)
	end

	return ret
end

function ActiveRookieUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ActiveRookieUI:OnOpen(userData)
	self:Refresh(userData)
end

function ActiveRookieUI:OnClose(userData)
	self:OnHide()
end

function ActiveRookieUI:OnPause()
	return
end

function ActiveRookieUI:OnResume()
	return
end

function ActiveRookieUI:OnCover()
	return
end

function ActiveRookieUI:OnReveal()
	return
end

function ActiveRookieUI:OnRefocus(userData)
	return
end

function ActiveRookieUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ActiveRookieUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ActiveRookieUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ActiveRookieUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ActiveRookieUI:Initialize()
	self.signInView = RookieSignInView.New(self.goSignInView)
	self.taskView = RookieTaskView.New(self.goTaskView)
	self.tabList = self.goTabList:GetComponent("ScrollAreaList")

	function self.tabList.onRenderCell(cell)
		self:OnRenderTabCell(cell)
	end

	function self.tabList.onSelectedCell(cell)
		self:OnSelectedTab(cell)
	end

	self.btnClose = self.goBtnClose:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.onTaskUpdateDelegate(id)
		self:OnTaskUpdate(id)
	end

	function self.onTaskCommitResponseDelegate(cids, awards)
		self:OnTaskCommitResponse(cids, awards)
	end

	self.goTitle:GetComponent("Text").text = ActiveRookieUIApi:GetString("btnClose")
end

function ActiveRookieUI:Refresh(userData)
	self.defaultIndex = 1
	self.hasRefreshed = false

	if userData ~= nil then
		self.defaultIndex = userData
	end

	self.signInView:Close()
	self.taskView:Close()
	self:RefreshTab()
end

function ActiveRookieUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	EventDispatcher.AddEventListener(EventID.TaskUpdate, self.onTaskUpdateDelegate)
	EventDispatcher.AddEventListener(EventID.TaskCommitResponse, self.onTaskCommitResponseDelegate)
end

function ActiveRookieUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	EventDispatcher.RemoveEventListener(EventID.TaskUpdate, self.onTaskUpdateDelegate)
	EventDispatcher.RemoveEventListener(EventID.TaskCommitResponse, self.onTaskCommitResponseDelegate)
end

function ActiveRookieUI:OnHide()
	for i, v in pairs(self.tabCellPool) do
		v:OnHide()
	end

	self.signInView:OnHide()
	self.taskView:OnHide()
end

function ActiveRookieUI:OnDestroy()
	for i, v in pairs(self.tabCellPool) do
		v:OnDestroy()
	end

	self.signInView:OnDestroy()
	self.taskView:OnDestroy()
end

function ActiveRookieUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.ActiveRookieUI)
end

function ActiveRookieUI:OnTaskUpdate(id)
	for i, v in pairs(self.tabCellPool) do
		v:OnTaskUpdate()
	end

	if self.lastView ~= nil then
		self.lastView:OnTaskUpdate(id)
	end
end

function ActiveRookieUI:OnTaskCommitResponse(cids, rewards)
	if #rewards > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, rewards)
	end
end

function ActiveRookieUI:OnRenderTabCell(cell)
	local luaIndex = cell.index + 1
	local insID = cell.gameObject:GetInstanceID()
	local tabCell = self.tabCellPool[insID]

	if tabCell == nil then
		tabCell = RookieTabCell.New(cell.gameObject)
		self.tabCellPool[insID] = tabCell
	end

	tabCell:Refresh(luaIndex)

	if self.hasRefreshed == false and self.defaultIndex == luaIndex then
		self:OnSelectedTab(cell)

		self.hasRefreshed = true
	end
end

function ActiveRookieUI:OnSelectedTab(cell)
	local luaIndex = cell.index + 1
	local insID = cell.gameObject:GetInstanceID()

	for i, v in pairs(self.tabCellPool) do
		if i ~= insID then
			v:SetLight(false)
		else
			v:SetLight(true)
		end
	end

	self:ShowTab(luaIndex)
end

function ActiveRookieUI:RefreshTab()
	self.tabList.startIndex = self.defaultIndex - 1

	self.tabList:Refresh(self.tabCount)
end

function ActiveRookieUI:ShowTab(index)
	if self.lastView ~= nil then
		self.lastView:Close()
	end

	if index == 1 then
		self.signInView:Open()

		self.lastView = self.signInView
	else
		self.taskView:Open(index)

		self.lastView = self.taskView
	end
end

return ActiveRookieUI
