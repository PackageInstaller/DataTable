-- chunkname: @IQIGame\\UI\\Mining\\MiningTicketCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateUpdateItem()
		self:UpdateItem()
	end

	function self.DelegateOnClickTipBtn()
		self:OnTipBtn()
	end

	function self.DelegateNumAttrOnChangeValue(key, value)
		self:OnNumAttrChangeValue(key, value)
	end

	self:AddListener()
end

function m:AddListener()
	self.BtnDes:GetComponent("Button").onClick:AddListener(self.DelegateOnClickTipBtn)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateUpdateItem)
	EventDispatcher.AddEventListener(EventID.PlayerNumAttrsChange, self.DelegateNumAttrOnChangeValue)
end

function m:RemoveListener()
	self.BtnDes:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickTipBtn)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateUpdateItem)
	EventDispatcher.RemoveEventListener(EventID.PlayerNumAttrsChange, self.DelegateNumAttrOnChangeValue)
end

function m:RefreshData(cid)
	self.itemID = cid

	local iconPath = MoneyGridApi:GetString("MoneyCellIconPath", self.itemID)

	if iconPath == "" then
		iconPath = UIGlobalApi.GetIconPath(CfgItemTable[self.itemID].Icon)
	end

	AssetUtil.LoadImage(self, iconPath, self.ImgIcon:GetComponent("Image"))
	self:RefreshNum()
end

function m:UpdateItem()
	self:RefreshNum()
end

function m:OnNumAttrChangeValue(key, value)
	if self.itemID == key then
		self:RefreshNum()
	end
end

function m:RefreshNum()
	local count = WarehouseModule.GetItemNumByCfgID(self.itemID)

	UGUIUtil.SetText(self.TextNum, count)
end

function m:OnTipBtn()
	if self.itemID == nil then
		return
	end

	UIModule.Open(Constant.UIControllerName.TextFollowingTipUI, Constant.UILayer.UI, {
		title = CfgItemTable[self.itemID].Name,
		content = CfgItemTable[self.itemID].Describe,
		refTrans = self.View.transform
	})
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
