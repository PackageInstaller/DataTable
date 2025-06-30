-- chunkname: @IQIGame\\UI\\DiceGameTaskUI.lua

local DiceGameTaskUI = {}

DiceGameTaskUI = Base:Extend("DiceGameTaskUI", "IQIGame.Onigao.UI.DiceGameTaskUI", DiceGameTaskUI)

local taskItemClass = require("IQIGame/UI/ActivityList/DiceGameActivity/DiceGameTaskUI_taskItem")

function DiceGameTaskUI:OnInit()
	self:InitMembers()
	self:InitDelegate()
	self:InitComponent()
end

function DiceGameTaskUI:InitMembers()
	self.taskScrollCellList = {}
end

function DiceGameTaskUI:InitDelegate()
	function self.delegateOnClickButtonClose()
		UIModule.CloseSelf(self)
	end

	function self.onRefreshFromSeverEvent()
		self:Refresh()
	end

	function self.onNotifyRemoveDiceGameEvent()
		UIModule.CloseSelf(self)
	end
end

function DiceGameTaskUI:InitComponent()
	self.taskScroll = self.taskScroll:GetComponent("OptimizedScrollRect")

	self.taskScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:UpdateTaskScroll(OptimizedParams, OptimizedViewsHolder)
	end)
end

function DiceGameTaskUI:OnAddListeners()
	self.buttonClose:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonClose)
	EventDispatcher.AddEventListener(EventID.DiceGameTaskUIRefreshEvent, self.onRefreshFromSeverEvent)
	EventDispatcher.AddEventListener(EventID.NotifyRemoveRichManEvent, self.onNotifyRemoveDiceGameEvent)
end

function DiceGameTaskUI:OnRemoveListeners()
	self.buttonClose:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonClose)
	EventDispatcher.RemoveEventListener(EventID.DiceGameTaskUIRefreshEvent, self.onRefreshFromSeverEvent)
	EventDispatcher.RemoveEventListener(EventID.NotifyRemoveRichManEvent, self.onNotifyRemoveDiceGameEvent)
end

function DiceGameTaskUI:UpdateTaskScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex
	local data = self.taskScrollDataArray[index + 1]

	if not self.taskScrollCellList[instanceID] then
		self.taskScrollCellList[instanceID] = taskItemClass.New(viewGameObject, self)
	end

	self.taskScrollCellList[instanceID]:Refresh(data)
end

function DiceGameTaskUI:OnOpen(userData)
	self:Refresh()
end

function DiceGameTaskUI:OnClose(userData)
	return
end

function DiceGameTaskUI:GetPreloadAssetPaths()
	return nil
end

function DiceGameTaskUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function DiceGameTaskUI:IsManualShowOnOpen(userData)
	return false
end

function DiceGameTaskUI:GetBGM(userData)
	return nil
end

function DiceGameTaskUI:OnPause()
	return
end

function DiceGameTaskUI:OnResume()
	return
end

function DiceGameTaskUI:OnCover()
	return
end

function DiceGameTaskUI:OnReveal()
	return
end

function DiceGameTaskUI:OnRefocus(userData)
	return
end

function DiceGameTaskUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function DiceGameTaskUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function DiceGameTaskUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function DiceGameTaskUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function DiceGameTaskUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function DiceGameTaskUI:Refresh()
	self:RefreshTaskScroll()
end

function DiceGameTaskUI:RefreshTaskScroll()
	self.taskScrollDataArray = TaskSystemModule.GetSortForTypeDataList(Constant.MainTaskType.Recharge, Constant.ExtendTaskType.DiceGame, TaskSystemModule.sortType.Weight_ID, true, false)

	self.taskScroll:RefreshByItemCount(#self.taskScrollDataArray)
end

return DiceGameTaskUI
