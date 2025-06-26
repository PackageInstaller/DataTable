-- chunkname: @IQIGame\\UI\\SettlementUI\\settlementRewardView.lua

local settlementRewardView = {}
local rewardItemCellClass = require("IQIGame/UI/SettlementUI/settlementRewardItemCell")

function settlementRewardView.New(go, mainView)
	local o = Clone(settlementRewardView)

	o:Initialize(go, mainView)

	return o
end

function settlementRewardView:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.itemCellList = {}

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function settlementRewardView:InitComponent()
	self.scroll = self.scroll:GetComponent("OptimizedGridRect")

	self.scroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:OnItemScrollRefresh(OptimizedParams, OptimizedViewsHolder)
	end)
end

function settlementRewardView:InitDelegate()
	return
end

function settlementRewardView:AddListener()
	return
end

function settlementRewardView:RemoveListener()
	return
end

function settlementRewardView:OnDestroy()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)

	for _, v in pairs(self.itemCellList) do
		v:OnDestroy()
	end

	self.itemCellList = {}
	self.scroll = nil

	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function settlementRewardView:OnItemScrollRefresh(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.rootGameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex
	local data = self.itemShowDataList[index + 1]

	if not self.itemCellList[instanceID] then
		self.itemCellList[instanceID] = rewardItemCellClass.New(viewGameObject, self)
	end

	self.itemCellList[instanceID]:Refresh(data)
end

function settlementRewardView:Refresh(itemShowList)
	self.itemShowDataList = ItemModule.ExcludeNotShowItem(itemShowList)

	self.scroll:RefreshByItemCount(#self.itemShowDataList)

	for _, v in pairs(self.itemCellList) do
		local layout = v:GetLayout()

		if not LuaUtility.GameObjectIsNullOrEmpty(layout) then
			-- block empty
		end

		if v:GetLayout() and v:GetLayout().ignoreLayout ~= true then
			v:PlayEffectShow()
		end
	end
end

return settlementRewardView
