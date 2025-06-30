-- chunkname: @IQIGame\\UI\\Common\\CurrencyItemCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickAddBtn()
		self:OnClickAddBtn()
	end

	function self.DelegateUpdataItem()
		self:UpdateView()
	end

	function self.DelegateOnClickIconBtn()
		self:OpenItemTips()
	end

	function self.DelegateResetTalent()
		self:ResetTalent()
	end

	function self.DelegateOnUnlockFunctionUpdateEvent()
		self:UpdateAddBtnState()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.AddBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickAddBtn)
	self.Icon:GetComponent("Button").onClick:AddListener(self.DelegateOnClickIconBtn)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateUpdataItem)
	EventDispatcher.AddEventListener(EventID.ResetTalentSuccess, self.DelegateResetTalent)
	EventDispatcher.AddEventListener(EventID.ActiveTalentSuccess, self.DelegateResetTalent)
	EventDispatcher.AddEventListener(EventID.UnlockFunction, self.DelegateOnUnlockFunctionUpdateEvent)
end

function m:RemoveListeners()
	self.AddBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickAddBtn)
	self.Icon:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickIconBtn)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateUpdataItem)
	EventDispatcher.RemoveEventListener(EventID.ResetTalentSuccess, self.DelegateResetTalent)
	EventDispatcher.RemoveEventListener(EventID.ActiveTalentSuccess, self.DelegateResetTalent)
	EventDispatcher.RemoveEventListener(EventID.UnlockFunction, self.DelegateOnUnlockFunctionUpdateEvent)
end

function m:SetData(itemCid, jumpId)
	self.itemCid = itemCid
	self.jumpId = jumpId

	self:UpdateView()
end

function m:UpdateView()
	self.itemData = WarehouseModule.FindItemForCid(self.itemCid)

	if self.itemData == nil then
		self.itemData = ItemData.CreateByCIDAndNumber(self.itemCid, 0)
	end

	local itemCount = self.itemData.num

	if self.itemCid == Constant.ItemCid.STRENGTH then
		UGUIUtil.SetText(self.Num, itemCount .. "/" .. PlayerModule.GetPlayerEnergy())
	elseif self.itemCid == Constant.ItemCid.HomePower then
		UGUIUtil.SetText(self.Num, itemCount .. "/" .. HomeModule.GetTaskSpotRecoverLimit())
	else
		UGUIUtil.SetText(self.Num, NumToStr(itemCount))
	end

	local iconImgCom = self.Icon:GetComponent("Image")

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(self.itemData:GetCfg().SmallIcon), iconImgCom, function()
		iconImgCom:SetNativeSize()
	end)
	self:UpdateAddBtnState()
end

function m:UpdateAddBtnState()
	LuaUtility.SetGameObjectShow(self.AddBtn, self:CheckAddBtnShow())
end

function m:CheckAddBtnShow()
	local isShow = false

	if self.jumpId == 0 then
		return isShow
	end

	local cfg = CfgUtil.GetCfgFunctionDataWithID(self.jumpId)

	if cfg.FunctionType == Constant.Function.openBuyEnergyUI then
		if ShopModule.GetShopDataWithShopID(Constant.ShopType.Energy) then
			isShow = true
		end
	elseif cfg.FunctionType == Constant.Function.openConvertUI and ShopModule.GetShopDataWithShopID(Constant.ShopType.Diamond) then
		isShow = true
	end

	return isShow
end

function m:OnClickAddBtn()
	JumpModule.Jump(self.jumpId)
end

function m:OpenItemTips()
	ItemModule.OpenItemTipsByItemData(self.itemData, false, false)
end

function m:ResetTalent()
	self:UpdateView()
end

function m:Show()
	self.View:SetActive(true)
end

function m:Hide()
	self.View:SetActive(false)
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
