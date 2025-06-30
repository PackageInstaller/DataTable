-- chunkname: @IQIGame\\UI\\FormationUI\\FormationJewelryCell.lua

local m = {
	jewelrySpeed = 0,
	formationIndex = 0,
	showJewelry = false
}

function m.New(view, showJewelry)
	local obj = Clone(m)

	obj:Init(view, showJewelry)

	return obj
end

function m:Init(view, showJewelry)
	self.View = view
	self.showJewelry = showJewelry

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickMainBtn()
		self:OnClickMainBtn()
	end

	function self.DelegateOnPrefabUpdate()
		self:OnPrefabUpdate()
	end

	self.ItemCell = ItemCell.New(self.ItemGo, false)

	self:AddListeners()
end

function m:AddListeners()
	self.MainBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickMainBtn)
	EventDispatcher.AddEventListener(EventID.SoulPrefabUpdate, self.DelegateOnPrefabUpdate)
end

function m:RemoveListeners()
	self.MainBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickMainBtn)
	EventDispatcher.RemoveEventListener(EventID.SoulPrefabUpdate, self.DelegateOnPrefabUpdate)
end

function m:SetData(soulData, soulPrefabData, formationIndex)
	self.SoulData = soulData
	self.SoulPrefabData = soulPrefabData
	self.formationIndex = formationIndex

	local isShow = self.showJewelry and (soulData ~= nil or soulPrefabData ~= nil)

	self.View:SetActive(isShow)

	if soulData == nil and soulPrefabData == nil then
		return
	end

	self:RefreshJewelry()
end

function m:RefreshJewelry()
	local result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.JEWELRY)

	self.MainBtn:SetActive(result)

	local itemID, speed = SoulPrefabModule.GetJewelryAndSpeed(self.SoulPrefabData)

	if itemID then
		local itemData = WarehouseModule.GetItemDataById(itemID)

		self.jewelrySpeed = speed

		self.ItemCell:SetItem(itemData)
	end
end

function m:OnClickMainBtn()
	UIModule.Open(Constant.UIControllerName.JewelryEquipUI, Constant.UILayer.UI, {
		SoulPrefab = self.SoulPrefabData,
		FormationIndex = self.formationIndex
	})
end

function m:OnPrefabUpdate()
	self:RefreshJewelry()
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()
	self.ItemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
