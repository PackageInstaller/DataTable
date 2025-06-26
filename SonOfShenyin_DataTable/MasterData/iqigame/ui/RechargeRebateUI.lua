-- chunkname: @IQIGame\\UI\\RechargeRebateUI.lua

local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local RebatItemView = {}

function RebatItemView.New(view)
	local obj = Clone(RebatItemView)

	obj:Init(view)

	return obj
end

function RebatItemView:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.itemSlot = ItemCell.New(self.CommonSlotUI, true, true)
end

function RebatItemView:SetData(itemData)
	self.itemSlot:SetItemByCid(itemData.id)
	self.itemSlot:SetNum(itemData.count)
end

function RebatItemView:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function RebatItemView:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function RebatItemView:Dispose()
	self.itemSlot:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)
	AssetUtil.UnloadAsset(self)
end

local RechargeRebateUI = {}

RechargeRebateUI = Base:Extend("RechargeRebateUI", "IQIGame.Onigao.UI.RechargeRebateUI", RechargeRebateUI)

function RechargeRebateUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.__DelegateOnReceiveRechargeRebateEvenet()
		self:OnReceiveRechargeRebateEvenet()
	end

	function self.DelegateonClickGetBtn()
		self:OnClickGetBtn()
	end

	self.itemPool = UIViewObjectPool.New(self.Grid_Mould, self.ItemContainer.transform, function(_view)
		return RebatItemView.New(_view)
	end)
end

function RechargeRebateUI:GetPreloadAssetPaths()
	return nil
end

function RechargeRebateUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RechargeRebateUI:IsManualShowOnOpen(userData)
	return false
end

function RechargeRebateUI:GetBGM(userData)
	return nil
end

function RechargeRebateUI:OnOpen(userData)
	self:RefreshRebateItems()
end

function RechargeRebateUI:OnClose(userData)
	return
end

function RechargeRebateUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.GetBtn:GetComponent("Button").onClick:AddListener(self.DelegateonClickGetBtn)
	EventDispatcher.AddEventListener(EventID.ReceiveRechargeRebateEvent, self.__DelegateOnReceiveRechargeRebateEvenet)
end

function RechargeRebateUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.GetBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateonClickGetBtn)
	EventDispatcher.RemoveEventListener(EventID.ReceiveRechargeRebateEvent, self.__DelegateOnReceiveRechargeRebateEvenet)
end

function RechargeRebateUI:OnPause()
	return
end

function RechargeRebateUI:OnResume()
	return
end

function RechargeRebateUI:OnCover()
	return
end

function RechargeRebateUI:OnReveal()
	return
end

function RechargeRebateUI:OnRefocus(userData)
	return
end

function RechargeRebateUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RechargeRebateUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RechargeRebateUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RechargeRebateUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RechargeRebateUI:OnDestroy()
	self.itemPool:Dispose(function(_item)
		_item:Dispose()
	end)

	self.itemPool = nil

	AssetUtil.UnloadAsset(self)
end

function RechargeRebateUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function RechargeRebateUI:OnClickGetBtn()
	UserInfoModule.ReceiveReChargeRebate(PlayerModule.PlayerInfo.baseInfo.rebate.id)
end

function RechargeRebateUI:OnReceiveRechargeRebateEvenet()
	UIModule.CloseSelf(self)
end

function RechargeRebateUI:RefreshRebateItems()
	local items = PlayerModule.PlayerInfo.baseInfo.rebate.items

	self.itemDataList = {}

	for k, v in pairs(items) do
		table.insert(self.itemDataList, {
			id = k,
			count = v
		})
	end

	table.sort(self.itemDataList, function(a, b)
		return a.id < b.id
	end)
	self.itemPool:ForItems(function(_item)
		_item:Hide()
	end)

	for i = 1, #self.itemDataList do
		local item = self.itemPool:GetFree(function(_item)
			return not _item.View.activeSelf
		end)

		item:SetData(self.itemDataList[i])
		item:Show()
	end

	UGUIUtil.SetText(self.RebateMoneyText, PlayerModule.PlayerInfo.baseInfo.rebate.rebateMoney)
end

return RechargeRebateUI
