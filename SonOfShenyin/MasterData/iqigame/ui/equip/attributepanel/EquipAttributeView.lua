-- chunkname: @IQIGame\\UI\\Equip\\AttributePanel\\EquipAttributeView.lua

local EquipAttributeView = {
	baseAttributeCellList = {}
}
local EquipBaseAttributeView = require("IQIGame.UI.Equip.AttributePanel.EquipBaseAttributeView")
local EquipSuitGroupView = require("IQIGame.UI.Equip.EquipSuitGroupView")

function EquipAttributeView.New(go)
	local o = Clone(EquipAttributeView)

	o:Initialize(go)

	return o
end

function EquipAttributeView:Initialize(go)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.EquipBaseAttributeView = EquipBaseAttributeView.New(self.EquipBaseAttributePanel)
	self.EquipSuitAttributeView = EquipSuitGroupView.New(self.EquipSuitAttributePanel)

	self:OnInitDelegation()
	self:OnAddListeners()
end

function EquipAttributeView:OnDestroy()
	self:OnRemoveListeners()
	self.EquipBaseAttributeView:OnDestroy()
	self.EquipSuitAttributeView:OnDestroy()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
end

function EquipAttributeView:OnInitDelegation()
	function self.delegateOnEquipChange()
		self:RefreshAttributePanel()
	end

	function self.delegateOnClickButtonQuickEquip()
		self:OnClickButtonQuickEquip()
	end

	function self.delegateOnClickButtonReplace()
		self:OnClickButtonReplace()
	end

	function self.delegateOnClickButtonQuickUnload()
		self:OnClickButtonQuickUnload()
	end
end

function EquipAttributeView:OnAddListeners()
	EventDispatcher.AddEventListener(EventID.WearEquipSucceedNew, self.delegateOnEquipChange)
	EventDispatcher.AddEventListener(EventID.UnloadEquipSucceedNew, self.delegateOnEquipChange)
	EventDispatcher.AddEventListener(EventID.UpgradeEquipSucceedNew, self.delegateOnEquipChange)
	EventDispatcher.AddEventListener(EventID.LockEquipSucceedNew, self.delegateOnEquipChange)
	self.ButtonQuickEquip:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonQuickEquip)
	self.ButtonReplace:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonReplace)
	self.ButtonQuickUnload:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonQuickUnload)
end

function EquipAttributeView:OnRemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.WearEquipSucceedNew, self.delegateOnEquipChange)
	EventDispatcher.RemoveEventListener(EventID.UnloadEquipSucceedNew, self.delegateOnEquipChange)
	EventDispatcher.RemoveEventListener(EventID.UpgradeEquipSucceedNew, self.delegateOnEquipChange)
	EventDispatcher.RemoveEventListener(EventID.LockEquipSucceedNew, self.delegateOnEquipChange)
	self.ButtonQuickEquip:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonQuickEquip)
	self.ButtonReplace:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonReplace)
	self.ButtonQuickUnload:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonQuickUnload)
end

function EquipAttributeView:OnClickButtonQuickEquip()
	return
end

function EquipAttributeView:OnClickButtonReplace()
	UIModule.Open(Constant.UIControllerName.EquipWarehouseUI, Constant.UILayer.UI, Constant.Equip.Part.Tong)
end

function EquipAttributeView:OnClickButtonQuickUnload()
	local EquipDataArr = EquipModule.GetCurrentHeroEquipData()

	for i, v in pairs(EquipDataArr) do
		EquipModule.UnloadEquip(EquipModule.currentHeroCid, v.id)
	end
end

function EquipAttributeView:Show()
	self:RefreshAttributePanel()
	self.gameObject:SetActive(true)
end

function EquipAttributeView:Hide()
	self.gameObject:SetActive(false)
end

function EquipAttributeView:RefreshAttributePanel()
	local currentWarlockData = WarlockModule.WarlockDataDic[EquipModule.currentHeroCid]

	self.EquipBaseAttributeView:RefreshAttributePanel(currentWarlockData)

	local warlockData = EquipModule.GetCurrentHeroData()

	self.EquipSuitAttributeView:Refresh(warlockData)

	local EquipDataArr = EquipModule.GetCurrentHeroEquipData()

	LuaUtility.SetGameObjectShow(self.ButtonQuickUnload, EquipDataArr and #EquipDataArr > 0)
end

return EquipAttributeView
