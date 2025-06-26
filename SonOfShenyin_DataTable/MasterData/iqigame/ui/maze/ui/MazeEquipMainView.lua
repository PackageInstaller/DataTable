-- chunkname: @IQIGame\\UI\\Maze\\UI\\MazeEquipMainView.lua

local mazeEquipItem = require("IQIGame.UI.Maze.UI.MazeEquipItem")
local orbmentUpgradeView = require("IQIGame.UI.Maze.UI.SubUI.OrbmentUpgradeView")
local unlockHoleView = require("IQIGame.UI.Maze.UI.SubUI.UnlockHoleView")
local selectHoleView = require("IQIGame.UI.Maze.UI.SubUI.SelectHoleView")
local gemNoneView = require("IQIGame.UI.Maze.UI.SubUI.GemNoneView")
local activityBuffsView = require("IQIGame.UI.Maze.UI.SubUI.ActivityBuffsView")
local gemOperationView = require("IQIGame.UI.Maze.UI.SubUI.GemOperationView")
local m = {
	MazeEquipList = {},
	SubUIList = {}
}

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

	function self.DelegateSelectHoleEvent(SeatID, isUnLock)
		self:SelectHoleEvent(SeatID, isUnLock)
	end

	function self.DelegateUnlockHoleSuccessEvent(SeatID)
		self:UnlockHoleSuccessEvent(SeatID)
	end

	function self.DelegateUpgradeOrbmentSuccessEvent()
		self:UpgradeOrbmentSuccessEvent()
	end

	function self.DelegateSelectSeatEffectSuccessEvent(SeatID)
		self:SelectSeatEffectSuccessEvent(SeatID)
	end

	function self.DelegateWearGemstoneSuccessEvent(SeatID)
		self:WearGemstoneSuccessEvent(SeatID)
	end

	function self.DelegateRemoveGemstoneSuccessEvent(SeatID)
		self:RemoveGemstoneSuccessEvent(SeatID)
	end

	function self.DelegateOrbmentDataChangeEvent()
		self:OrbmentDataChangeEvent()
	end

	self.OrbmentUpgradeView = orbmentUpgradeView.New(self.OrbmentUpgradePanel)
	self.UnlockHoleView = unlockHoleView.New(self.UnlockHolePanel)
	self.SelectHoleView = selectHoleView.New(self.SelectHolePanel)
	self.GemNoneView = gemNoneView.New(self.GemNonePanel)
	self.ActivityBuffsView = activityBuffsView.New(self.ActivityBuffsPanel)
	self.GemOperationView = gemOperationView.New(self.GemOperationPanel)
	self.SubUIList[MazeModule.SubUIEnum.OrbmentUpgradeView] = self.OrbmentUpgradeView
	self.SubUIList[MazeModule.SubUIEnum.UnlockHoleView] = self.UnlockHoleView
	self.SubUIList[MazeModule.SubUIEnum.SelectHoleView] = self.SelectHoleView
	self.SubUIList[MazeModule.SubUIEnum.GemNoneView] = self.GemNoneView
	self.SubUIList[MazeModule.SubUIEnum.ActivityBuffsView] = self.ActivityBuffsView
	self.SubUIList[MazeModule.SubUIEnum.GemOperationView] = self.GemOperationView

	self:AddListeners()
end

function m:AddListeners()
	self.closeBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.AddEventListener(EventID.SelectHoleEvent, self.DelegateSelectHoleEvent)
	EventDispatcher.AddEventListener(EventID.UnlockHoleSuccessEvent, self.DelegateUnlockHoleSuccessEvent)
	EventDispatcher.AddEventListener(EventID.UpgradeOrbmentSuccessEvent, self.DelegateUpgradeOrbmentSuccessEvent)
	EventDispatcher.AddEventListener(EventID.SelectSeatEffectSuccessEvent, self.DelegateSelectSeatEffectSuccessEvent)
	EventDispatcher.AddEventListener(EventID.WearGemstoneSuccessEvent, self.DelegateWearGemstoneSuccessEvent)
	EventDispatcher.AddEventListener(EventID.RemoveGemstoneSuccessEvent, self.DelegateRemoveGemstoneSuccessEvent)
	EventDispatcher.AddEventListener(EventID.InOrbmentDataChangeEvent, self.DelegateOrbmentDataChangeEvent)
end

function m:RemoveListeners()
	self.closeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.RemoveEventListener(EventID.SelectHoleEvent, self.DelegateSelectHoleEvent)
	EventDispatcher.RemoveEventListener(EventID.UnlockHoleSuccessEvent, self.DelegateUnlockHoleSuccessEvent)
	EventDispatcher.RemoveEventListener(EventID.UpgradeOrbmentSuccessEvent, self.DelegateUpgradeOrbmentSuccessEvent)
	EventDispatcher.RemoveEventListener(EventID.SelectSeatEffectSuccessEvent, self.DelegateSelectSeatEffectSuccessEvent)
	EventDispatcher.RemoveEventListener(EventID.WearGemstoneSuccessEvent, self.DelegateWearGemstoneSuccessEvent)
	EventDispatcher.RemoveEventListener(EventID.RemoveGemstoneSuccessEvent, self.DelegateRemoveGemstoneSuccessEvent)
	EventDispatcher.RemoveEventListener(EventID.InOrbmentDataChangeEvent, self.DelegateOrbmentDataChangeEvent)
end

function m:SetData()
	self:RefreshMainViewInfo()
	self:CreateMazeEquipItem()

	if MazeModule.InTheMaze then
		if MazeModule.GetOrbmentIsEquipedGem() then
			self:ShowSubView(MazeModule.SubUIEnum.ActivityBuffsView)
		else
			self:ShowSubView(MazeModule.SubUIEnum.GemNoneView)
		end
	else
		self:ShowSubView(MazeModule.SubUIEnum.OrbmentUpgradeView)
	end
end

function m:RefreshMainViewInfo()
	UGUIUtil.SetText(self.equipNumText, MazeModule.GetEquipedGemNum())
	UGUIUtil.SetText(self.limitNumText, MazeModule.GetGemstoneLimit())
end

function m:CreateMazeEquipItem()
	local holeItemList = MazeModule.GetHoleItemNumByType()

	for i = 1, #holeItemList do
		if self.MazeEquipList[i] == nil then
			local obj = GameObject.Instantiate(self.EquipItem)

			LuaUtility.SetGameObjectShow(obj, true)
			obj.transform:SetParent(self.equipGrid.transform, false)

			local mazeEquipItemView = mazeEquipItem.New(obj)

			self.MazeEquipList[i] = mazeEquipItemView
		end

		self.MazeEquipList[i]:SetData(holeItemList[i])
	end
end

function m:ShowSubView(index, ...)
	self.SelectSubUIEnum = index

	for k, v in pairs(self.SubUIList) do
		if k == index then
			v:Show()
		else
			v:Hide()
		end
	end

	if index == MazeModule.SubUIEnum.OrbmentUpgradeView then
		self.OrbmentUpgradeView:SetData(...)
	elseif index == MazeModule.SubUIEnum.UnlockHoleView then
		self.UnlockHoleView:SetData(...)
	elseif index == MazeModule.SubUIEnum.SelectHoleView then
		self.SelectHoleView:SetData(...)
	elseif index == MazeModule.SubUIEnum.GemNoneView then
		self.GemNoneView:SetData(...)
	elseif index == MazeModule.SubUIEnum.ActivityBuffsView then
		self.ActivityBuffsView:SetData(...)
	elseif index == MazeModule.SubUIEnum.GemOperationView then
		self.GemOperationView:SetData(...)
	end
end

function m:SelectHoleEvent(SeatID, isUnLock)
	if SeatID == 0 then
		return
	end

	if MazeModule.InTheMaze then
		self:ShowSubView(MazeModule.SubUIEnum.GemOperationView, SeatID)
	elseif isUnLock then
		self:ShowSubView(MazeModule.SubUIEnum.SelectHoleView, SeatID)
	else
		self:ShowSubView(MazeModule.SubUIEnum.UnlockHoleView, SeatID)
	end
end

function m:UnlockHoleSuccessEvent(SeatID)
	self:ShowSubView(MazeModule.SubUIEnum.SelectHoleView, SeatID)
end

function m:UpgradeOrbmentSuccessEvent()
	self:RefreshMainViewInfo()
end

function m:SelectSeatEffectSuccessEvent(SeatID)
	return
end

function m:WearGemstoneSuccessEvent(SeatID)
	self:RefreshMainViewInfo()
	self:ShowSubView(MazeModule.SubUIEnum.ActivityBuffsView)
end

function m:RemoveGemstoneSuccessEvent(SeatID)
	self:RefreshMainViewInfo()

	if MazeModule.GetOrbmentIsEquipedGem() then
		self:ShowSubView(MazeModule.SubUIEnum.ActivityBuffsView)
	else
		self:ShowSubView(MazeModule.SubUIEnum.GemNoneView)
	end
end

function m:OrbmentDataChangeEvent()
	self:RefreshMainViewInfo()
end

function m:OnClickCloseBtn()
	if MazeModule.InTheMaze then
		local targetViewEnum = MazeModule.SubUIEnum.ActivityBuffsView

		if not MazeModule.GetOrbmentIsEquipedGem() then
			targetViewEnum = MazeModule.SubUIEnum.GemNoneView
		end

		if self.SelectSubUIEnum == targetViewEnum then
			return
		end

		self:ShowSubView(targetViewEnum)
	else
		if self.SelectSubUIEnum == MazeModule.SubUIEnum.OrbmentUpgradeView then
			return
		end

		self:ShowSubView(MazeModule.SubUIEnum.OrbmentUpgradeView)
	end

	EventDispatcher.Dispatch(EventID.SelectHoleEvent, 0)
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()

	for k, v in pairs(self.MazeEquipList) do
		v:Dispose()
	end

	self.MazeEquipList = nil

	for k, v in pairs(self.SubUIList) do
		v:Dispose()
	end

	self.SubUIList = nil

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
