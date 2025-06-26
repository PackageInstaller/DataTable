-- chunkname: @IQIGame\\UI\\Skin\\SkinUIEquipSkinConfirmPanel.lua

local SkinUIEquipSkinConfirmPanel = {}

function SkinUIEquipSkinConfirmPanel.New(view)
	local obj = Clone(SkinUIEquipSkinConfirmPanel)

	obj:Init(view)

	return obj
end

function SkinUIEquipSkinConfirmPanel:Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self:InitProperties()
	self:AddListeners()
end

function SkinUIEquipSkinConfirmPanel:InitProperties()
	self.EquipAllBtn = self.EquipAllBtnObj:GetComponent("Button")
	self.EquipSingleBtn = self.EquipSingleBtnObj:GetComponent("Button")
	self.confirmEquipSkinModeToggle = self.ToggleObj:GetComponent("Toggle")
	self.confirmEquipSkinModeToggle.isOn = false

	function self.DelegateOnClosePanel()
		self:Hide()
	end

	function self.DelegateOnEquipSkinTogetherSwitchToggleValueChanged(isOn)
		return
	end

	self.DelegateOnEquipAllBtnClick = nil
	self.DelegateOnEquipSingleBtnClick = nil
end

function SkinUIEquipSkinConfirmPanel:DisposeProperties()
	self.EquipAllBtn = nil
	self.EquipSingleBtn = nil
	self.confirmEquipSkinModeToggle = nil
end

function SkinUIEquipSkinConfirmPanel:AddListeners()
	self.EquipAllBtn.onClick:AddListener(self.DelegateOnClosePanel)
	self.EquipSingleBtn.onClick:AddListener(self.DelegateOnClosePanel)
end

function SkinUIEquipSkinConfirmPanel:RemoveListeners()
	self.EquipAllBtn.onClick:RemoveListener(self.DelegateOnClosePanel)
	self.EquipSingleBtn.onClick:RemoveListener(self.DelegateOnClosePanel)
end

function SkinUIEquipSkinConfirmPanel:Dispose()
	self:Hide()
	self:RemoveListeners()
	self:DisposeProperties()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function SkinUIEquipSkinConfirmPanel:SetVisible(isVisible)
	LuaUtility.SetGameObjectShow(self.gameObject, isVisible)
end

function SkinUIEquipSkinConfirmPanel:Show(equipAllBtnClickCallback, equipSingleBtnClickCallback)
	self:CheckToRemoveEquipButtonListener()

	function self.DelegateOnEquipAllBtnClick()
		self:CheckToSetHadConfirmEquipSkinModeSetting()
		equipAllBtnClickCallback()
	end

	function self.DelegateOnEquipSingleBtnClick()
		self:CheckToSetHadConfirmEquipSkinModeSetting()
		equipSingleBtnClickCallback()
	end

	self.EquipAllBtn.onClick:AddListener(self.DelegateOnEquipAllBtnClick)
	self.EquipSingleBtn.onClick:AddListener(self.DelegateOnEquipSingleBtnClick)

	self.confirmEquipSkinModeToggle.isOn = false

	self:SetVisible(true)
end

function SkinUIEquipSkinConfirmPanel:Hide()
	self:CheckToRemoveEquipButtonListener()
	self:SetVisible(false)
end

function SkinUIEquipSkinConfirmPanel:CheckToRemoveEquipButtonListener()
	if self.DelegateOnEquipAllBtnClick ~= nil then
		self.EquipAllBtn.onClick:RemoveListener(self.DelegateOnEquipAllBtnClick)

		self.DelegateOnEquipAllBtnClick = nil
	end

	if self.DelegateOnEquipSingleBtnClick ~= nil then
		self.EquipSingleBtn.onClick:RemoveListener(self.DelegateOnEquipSingleBtnClick)

		self.DelegateOnEquipSingleBtnClick = nil
	end
end

function SkinUIEquipSkinConfirmPanel:OnEquipSkinTogetherSwitchToggleValueChanged(isOn)
	SettingModule.SetEquipSkinTogetherSetting(isOn and 1 or 0)
end

function SkinUIEquipSkinConfirmPanel:CheckToSetHadConfirmEquipSkinModeSetting()
	if self.confirmEquipSkinModeToggle ~= nil and self.confirmEquipSkinModeToggle.isOn then
		SettingModule.SetHadConfirmEquipSkinModeSetting()
		SettingModule.SetEquipSkinTogetherSetting(self.confirmEquipSkinModeToggle.isOn and 1 or 0)
	end
end

return SkinUIEquipSkinConfirmPanel
