-- chunkname: @IQIGame\\UI\\BattleActivityDungeonUI.lua

local BattleActivityDungeonUI = {}

BattleActivityDungeonUI = Base:Extend("BattleActivityDungeonUI", "IQIGame.Onigao.UI.BattleActivityDungeonUI", BattleActivityDungeonUI)

local StageItemClass = require("IQIGame/UI/BattleActivityDungeon/BattleActivityDungeon_StageItem")

function BattleActivityDungeonUI:OnInit()
	self:InitMembers()
	self:InitComponent()
	self:InitDelegate()
end

function BattleActivityDungeonUI:InitMembers()
	self.stageScrollDataList = {}
	self.stageScrollCellList = {}
end

function BattleActivityDungeonUI:InitComponent()
	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)
	self.dungeonScroll = self.dungeonScroll:GetComponent("OptimizedScrollRect")

	self.dungeonScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:UpdateContentScroll(OptimizedParams, OptimizedViewsHolder)
	end)
end

function BattleActivityDungeonUI:InitDelegate()
	function self.onRemoveDupEvent()
		self:Refresh()
	end

	function self.delegateOnClickButtonReward()
		self:OnClickButtonReward()
	end

	function self.onNotifyDupEvent()
		self:Refresh()
	end
end

function BattleActivityDungeonUI:OnOpen(userData)
	self:Refresh()
end

function BattleActivityDungeonUI:OnClose(userData)
	return
end

function BattleActivityDungeonUI:OnAddListeners()
	self.buttonReward:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonReward)
	EventDispatcher.AddEventListener(EventID.NetActivityRemoveDupEvent, self.onRemoveDupEvent)
	EventDispatcher.AddEventListener(EventID.BattleActivityNotifyDupEvent, self.onNotifyDupEvent)
end

function BattleActivityDungeonUI:OnRemoveListeners()
	self.buttonReward:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonReward)
	EventDispatcher.RemoveEventListener(EventID.NetActivityRemoveDupEvent, self.onRemoveDupEvent)
	EventDispatcher.RemoveEventListener(EventID.BattleActivityNotifyDupEvent, self.onNotifyDupEvent)
end

function BattleActivityDungeonUI:GetPreloadAssetPaths()
	return nil
end

function BattleActivityDungeonUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function BattleActivityDungeonUI:IsManualShowOnOpen(userData)
	return false
end

function BattleActivityDungeonUI:GetBGM(userData)
	return nil
end

function BattleActivityDungeonUI:OnPause()
	return
end

function BattleActivityDungeonUI:OnResume()
	return
end

function BattleActivityDungeonUI:OnCover()
	return
end

function BattleActivityDungeonUI:OnReveal()
	return
end

function BattleActivityDungeonUI:OnRefocus(userData)
	return
end

function BattleActivityDungeonUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function BattleActivityDungeonUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function BattleActivityDungeonUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function BattleActivityDungeonUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function BattleActivityDungeonUI:UpdateContentScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex
	local data = self.stageScrollDataList[index + 1]

	if not self.stageScrollCellList[instanceID] then
		self.stageScrollCellList[instanceID] = StageItemClass.New(viewGameObject)
	end

	self.stageScrollCellList[instanceID]:Refresh(data)
end

function BattleActivityDungeonUI:Refresh()
	local dupPod = PlayerModule.GetActivityDup()

	self.stageScrollDataList = {}

	for _, v in pairs(dupPod) do
		table.insert(self.stageScrollDataList, v)
	end

	table.sort(self.stageScrollDataList, function(a, b)
		return a.chapterId < b.chapterId
	end)
	self.dungeonScroll:RefreshByItemCount(#self.stageScrollDataList)
end

function BattleActivityDungeonUI:OnDestroy()
	self.commonReturnBtn:Dispose()

	for _, v in pairs(self.stageScrollCellList) do
		v:OnDestroy()
	end

	self.stageScrollCellList = {}

	AssetUtil.UnloadAsset(self)
end

return BattleActivityDungeonUI
