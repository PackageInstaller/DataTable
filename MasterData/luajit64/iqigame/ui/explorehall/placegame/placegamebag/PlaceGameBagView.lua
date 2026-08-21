-- chunkname: @IQIGame\\UI\\ExploreHall\\PlaceGame\\PlaceGameBag\\PlaceGameBagView.lua

local m = {
	isLockMode = false,
	isRecoveryMode = false,
	equipsQuality = {
		2,
		3,
		4,
		5
	}
}
local PlaceGameBagDetailView = require("IQIGame.UI.ExploreHall.PlaceGame.PlaceGameBag.PlaceGameBagDetailView")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateToggleLock(isOn)
		self:OnToggleLock(isOn)
	end

	function self.DelegateToggleRecovery(isOn)
		self:OnToggleRecovery(isOn)
	end

	function self.DelegateBtnRecovery()
		self:OnBtnRecovery()
	end

	function self.DelegateUpdateItem()
		self:OnUpdateItem()
	end

	for i = 1, #self.equipsQuality do
		self["DelegateToggleQuality" .. i] = function(i)
			self:OnToggleQualityChange(i)
		end
	end

	self.placeGameBagDetailView = PlaceGameBagDetailView.New(self.BagDetailView)

	self:AddListener()
end

function m:AddListener()
	self.ToggleLock:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateToggleLock)
	self.ToggleRecovery:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateToggleRecovery)
	self.BtnRecovery:GetComponent("Button").onClick:AddListener(self.DelegateBtnRecovery)

	for i = 1, #self.equipsQuality do
		self["ToggleQuality" .. i]:GetComponent("Toggle").onValueChanged:AddListener(self["DelegateToggleQuality" .. i])
	end

	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateUpdateItem)
end

function m:RemoveListener()
	self.ToggleLock:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateToggleLock)
	self.ToggleRecovery:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateToggleRecovery)
	self.BtnRecovery:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnRecovery)

	for i = 1, #self.equipsQuality do
		self["ToggleQuality" .. i]:GetComponent("Toggle").onValueChanged:RemoveListener(self["DelegateToggleQuality" .. i])
	end

	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateUpdateItem)
end

function m:OnToggleLock(isOn)
	self.isLockMode = isOn

	if isOn then
		self.ToggleRecovery:SetActive(false)
	else
		self:SetDefaultToggles()
	end

	self.placeGameBagDetailView:RefreshBagMode(self.isLockMode, self.isRecoveryMode)
end

function m:OnToggleRecovery(isOn)
	self.isRecoveryMode = isOn

	if isOn then
		self.ToggleLock:SetActive(false)
	else
		self:SetDefaultToggles()
	end

	self.placeGameBagDetailView:RefreshBagMode(self.isLockMode, self.isRecoveryMode)
end

function m:OnToggleQualityChange(index)
	local selectQuality = {}

	for i = 1, #self.equipsQuality do
		local quality = self.equipsQuality[i]

		if self["ToggleQuality" .. i]:GetComponent("Toggle").isOn then
			table.insert(selectQuality, quality)
		end
	end

	self.placeGameBagDetailView:RefreshSelectRecovery(selectQuality)
end

function m:SetDefaultToggles()
	self.isLockMode = false
	self.isRecoveryMode = false

	self.ToggleLock:SetActive(true)
	self.ToggleRecovery:SetActive(true)

	self.ToggleLock:GetComponent("Toggle").isOn = self.isLockMode
	self.ToggleRecovery:GetComponent("Toggle").isOn = self.isRecoveryMode
end

function m:OnUpdateItem()
	self:UpdateView()
end

function m:UpdateView()
	self.placeGameBagDetailView:RefreshBagMode(self.isLockMode, self.isRecoveryMode)
end

function m:OnBtnRecovery()
	local equips = {}
	local top = false

	for i, v in pairs(self.placeGameBagDetailView.itemDataList) do
		if v.placeGameEquipData.selectRecovery then
			table.insert(equips, v.id)

			top = top or v:GetCfg().Quality == 5
		end
	end

	if #equips > 0 then
		if top then
			NoticeModule.ShowNotice(21045096, function()
				PlaceGameModule.EquipmentResolve(equips)
			end, nil)
		else
			PlaceGameModule.EquipmentResolve(equips)
		end
	end
end

function m:Open()
	self.View:SetActive(true)
	self:SetDefaultToggles()
	self:UpdateView()
end

function m:Close()
	self.View:SetActive(false)
end

function m:Dispose()
	self.placeGameBagDetailView:Dispose()

	self.placeGameBagDetailView = nil

	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
