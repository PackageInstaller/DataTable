-- chunkname: @IQIGame\\UI\\ExploreHall\\HorizontalRPG\\HorizontalRPGTicketCell.lua

local m = {
	ItemID = Constant.ItemID.HorizontalRPG_Points
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnUpdateTicket()
		self:OnUpdateTicket()
	end

	function self.DelegateOnUpdateDailyDupEvent()
		self:OnUpdateDailyDupEvent()
	end

	function self.DelegateOnUpdateItem()
		self:OnUpdateTicket()
	end

	function self.DelegateBtnTip()
		self:OnBtnTip()
	end

	if self.AddBtn then
		self.AddBtn:SetActive(false)
	end

	self:AddListeners()
	self:Refresh()
end

function m:AddListeners()
	EventDispatcher.AddEventListener(EventID.RpgMazeUpdateTicket, self.DelegateOnUpdateTicket)
	EventDispatcher.AddEventListener(EventID.UpdateDailyDupEvent, self.DelegateOnUpdateDailyDupEvent)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateOnUpdateItem)
	self.TipBtn:GetComponent("Button").onClick:AddListener(self.DelegateBtnTip)
end

function m:RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.RpgMazeUpdateTicket, self.DelegateOnUpdateTicket)
	EventDispatcher.RemoveEventListener(EventID.UpdateDailyDupEvent, self.DelegateOnUpdateDailyDupEvent)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateOnUpdateItem)
	self.TipBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnTip)
end

function m:Refresh(id)
	if id then
		self.ItemID = id
	end

	if not HorizontalRPGModule.IsShow() then
		return
	end

	if self.ItemID == Constant.ItemID.HorizontalRPG_Points then
		UGUIUtil.SetText(self.ValueText, HorizontalRPGModule.dailyDupPOD.horizontalRPGPOD.tickets)
	else
		local num = WarehouseModule.GetItemNumByCfgID(self.ItemID)

		UGUIUtil.SetText(self.ValueText, num)
	end

	local path = UIGlobalApi.GetIconPath(CfgItemTable[self.ItemID].Icon)

	AssetUtil.LoadImage(self, path, self.Icon:GetComponent("Image"))
end

function m:OnUpdateTicket()
	self:Refresh()
end

function m:OnUpdateDailyDupEvent()
	self:Refresh()
end

function m:OnBtnTip()
	UIModule.Open(Constant.UIControllerName.TextFollowingTipUI, Constant.UILayer.UI, {
		title = CfgItemTable[self.ItemID].Name,
		content = CfgItemTable[self.ItemID].Describe,
		refTrans = self.View.transform
	})
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
