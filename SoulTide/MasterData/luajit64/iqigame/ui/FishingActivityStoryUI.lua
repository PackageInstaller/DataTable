-- chunkname: @IQIGame\\UI\\FishingActivityStoryUI.lua

local FishingActivityStoryUI = {
	currentEventType = 1,
	fishEvents = {},
	fishStoryCellPool = {}
}

FishingActivityStoryUI = Base:Extend("FishingActivityStoryUI", "IQIGame.Onigao.UI.FishingActivityStoryUI", FishingActivityStoryUI)

local FishingActivityStoryCell = require("IQIGame.UI.ExploreHall.FishingActivity.FishingActivityStory.FishingActivityStoryCell")

function FishingActivityStoryUI:OnInit()
	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.DelegateOnToggleMain(isOn)
		self:OnToggleMain(isOn)
	end

	function self.DelegateOnToggleBranch(isOn)
		self:OnToggleBranch(isOn)
	end

	function self.DelegateUpdateEvent()
		self:OnUpdateEvent()
	end

	self.eventScrollList = self.ScrollList:GetComponent("ScrollAreaList")

	function self.eventScrollList.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end
end

function FishingActivityStoryUI:GetPreloadAssetPaths()
	return nil
end

function FishingActivityStoryUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function FishingActivityStoryUI:IsManualShowOnOpen(userData)
	return false
end

function FishingActivityStoryUI:GetBGM(userData)
	return nil
end

function FishingActivityStoryUI:OnOpen(userData)
	self:UpdateView()
end

function FishingActivityStoryUI:OnClose(userData)
	return
end

function FishingActivityStoryUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	self.ToggleMain:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnToggleMain)
	self.ToggleBranch:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnToggleBranch)
	EventDispatcher.AddEventListener(EventID.FishingActivityUpdateEvent, self.DelegateUpdateEvent)
end

function FishingActivityStoryUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	self.ToggleMain:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnToggleMain)
	self.ToggleBranch:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnToggleBranch)
	EventDispatcher.RemoveEventListener(EventID.FishingActivityUpdateEvent, self.DelegateUpdateEvent)
end

function FishingActivityStoryUI:OnPause()
	return
end

function FishingActivityStoryUI:OnResume()
	return
end

function FishingActivityStoryUI:OnCover()
	return
end

function FishingActivityStoryUI:OnReveal()
	return
end

function FishingActivityStoryUI:OnRefocus(userData)
	return
end

function FishingActivityStoryUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function FishingActivityStoryUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function FishingActivityStoryUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function FishingActivityStoryUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function FishingActivityStoryUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.fishStoryCellPool) do
		v:Dispose()
	end

	self.fishEvents = {}
end

function FishingActivityStoryUI:UpdateView()
	self:RefreshList(true)
end

function FishingActivityStoryUI:OnUpdateEvent()
	self:RefreshList(false)
end

function FishingActivityStoryUI:RefreshList(top)
	self.fishEvents = {}

	for i, v in pairs(FishingActivityModule.fishEventDataList) do
		if v:GetCfgData().Type == self.currentEventType then
			table.insert(self.fishEvents, v)
		end
	end

	table.sort(self.fishEvents, function(a, b)
		local aCanGetReward = a:CanGetReward() and 1 or 0
		local bCanGetReward = b:CanGetReward() and 1 or 0
		local aUnlock = a.isUnlock and 1 or 0
		local bUnlock = b.isUnlock and 1 or 0

		if aCanGetReward == bCanGetReward then
			if aUnlock == bUnlock then
				return a.cid < b.cid
			end

			return bUnlock < aUnlock
		end

		return bCanGetReward < aCanGetReward
	end)

	if top then
		self.eventScrollList:Refresh(#self.fishEvents)
	else
		self.eventScrollList:RenderCellsDynamic(#self.fishEvents)
	end
end

function FishingActivityStoryUI:OnRenderGridCell(cell)
	local data = self.fishEvents[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local renderCell = self.fishStoryCellPool[instanceID]

	if renderCell == nil then
		renderCell = FishingActivityStoryCell.New(cell.gameObject)
		self.fishStoryCellPool[instanceID] = renderCell
	end

	renderCell:SetData(data)
end

function FishingActivityStoryUI:OnToggleMain(isOn)
	if isOn then
		self.currentEventType = 1

		self:RefreshList()
	end
end

function FishingActivityStoryUI:OnToggleBranch(isOn)
	if isOn then
		self.currentEventType = 2

		self:RefreshList()
	end
end

function FishingActivityStoryUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

return FishingActivityStoryUI
