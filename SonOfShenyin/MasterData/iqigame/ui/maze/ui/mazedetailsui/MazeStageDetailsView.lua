-- chunkname: @IQIGame\\UI\\Maze\\UI\\MazeDetailsUI\\MazeStageDetailsView.lua

local progressRewardItem = {}

function progressRewardItem.New(view)
	local obj = Clone(progressRewardItem)

	obj:Init(view)

	return obj
end

function progressRewardItem:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickGetRewardBtn()
		self:OnClickGetRewardBtn()
	end

	self.commonSlotUI = ItemCell.New(self.CommonSlotUI)
	self.itemRectTransform = self.View:GetComponent("RectTransform")

	self:AddListeners()
end

function progressRewardItem:AddListeners()
	self.GetRewardBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickGetRewardBtn)
end

function progressRewardItem:RemoveListeners()
	self.GetRewardBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickGetRewardBtn)
end

function progressRewardItem:SetData(xPos, progress, itemID, itemNum, stageData)
	self.stageData = stageData
	self.progress = progress

	LuaUtility.SetAnchoredPositionWithRectTransform(self.itemRectTransform, xPos, 0)
	UGUIUtil.SetText(self.ProgressText, progress .. "%")
	self.commonSlotUI:SetItem(ItemData.CreateByCIDAndNumber(itemID, itemNum))

	local isReceived = false

	if stageData == nil then
		isReceived = false
	elseif table.indexOf(stageData.progressIds, progress) ~= -1 then
		isReceived = true
	end

	LuaUtility.SetGameObjectShow(self.GetRewardBtn, not isReceived and self.stageData ~= nil and progress <= self.stageData.progress)
	LuaUtility.SetGameObjectShow(self.ReceivedImg, isReceived)
end

function progressRewardItem:OnClickGetRewardBtn()
	MazeModule.ClaimProgressAward(self.stageData.mazeId, self.progress)
end

function progressRewardItem:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function progressRewardItem:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function progressRewardItem:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

local m = {
	progressRewardList = {},
	rewardItemList = {}
}

m.ProgressRewardItem = progressRewardItem

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnGetProgressAwardSuccessEvent()
		self:OnGetProgressAwardSuccessEvent()
	end

	self.progressSlider = self.ProgressSlider:GetComponent("Slider")
	self.progressRewardParentRectTransform = self.ProgressRewardParent:GetComponent("RectTransform")
	self.warpContent = self.RewardScrollView:GetComponent("ScrollAreaList")

	function self.warpContent.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	self:AddListeners()
end

function m:AddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.AddEventListener(EventID.GetProgressAwardSuccessEvent, self.DelegateOnGetProgressAwardSuccessEvent)
end

function m:RemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.RemoveEventListener(EventID.GetProgressAwardSuccessEvent, self.DelegateOnGetProgressAwardSuccessEvent)
end

function m:SetData(stageId)
	self.stageId = stageId
	self.stageData = MazeModule.GetMazeStageDataByMazeID(self.stageId)
	self.stageCfg = CfgMazeStageTable[self.stageId]
	self.rewardDataList = self.stageCfg.DropReward

	self.warpContent:Refresh(#self.rewardDataList)
	self:RefreshAboutProgressInfo()
end

function m:RefreshAboutProgressInfo()
	if self.stageData == nil then
		self.progressSlider.value = 0
	else
		self.progressSlider.value = self.stageData.progress / 100
	end

	for k, v in pairs(self.progressRewardList) do
		v:Hide()
	end

	local index = 0
	local width = self.progressRewardParentRectTransform.rect.w
	local cfgProgress

	for i = 1, #self.stageCfg.ExploreRateReward, 3 do
		index = index + 1
		cfgProgress = self.stageCfg.ExploreRateReward[i]

		if self.progressRewardList[index] == nil then
			local obj = GameObject.Instantiate(self.ProgressRewardPrefab)

			obj.transform:SetParent(self.ProgressRewardParent.transform, false)

			self.progressRewardList[index] = m.ProgressRewardItem.New(obj)
		end

		self.progressRewardList[index]:SetData(width * (cfgProgress / 100), cfgProgress, self.stageCfg.ExploreRateReward[i + 1], self.stageCfg.ExploreRateReward[i + 2], self.stageData)
		self.progressRewardList[index]:Show()
	end
end

function m:OnRenderCell(cell)
	local rewardData = self.rewardDataList[cell.index + 1]
	local instanceId = cell.gameObject:GetInstanceID()
	local itemcell = self.rewardItemList[instanceId]

	if itemcell == nil then
		itemcell = ItemCell.New(cell.gameObject, true, false)
		self.rewardItemList[instanceId] = itemcell
	end

	itemcell:SetItem(ItemData.CreateByCIDAndNumber(rewardData))
end

function m:OnGetProgressAwardSuccessEvent()
	self:SetData(self.stageId)
end

function m:OnClickCloseBtn()
	self:Hide()
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	for k, v in pairs(self.rewardItemList) do
		v:Dispose()
	end

	self.rewardItemList = nil

	for k, v in pairs(self.progressRewardList) do
		v:Dispose()
	end

	self.progressRewardList = nil
	self.warpContent = nil

	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
