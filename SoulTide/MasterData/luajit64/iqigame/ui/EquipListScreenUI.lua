-- chunkname: @IQIGame\\UI\\EquipListScreenUI.lua

local EquipListScreenUI = {
	toggles_1 = {},
	toggles_2 = {},
	toggles_3 = {},
	toggles_4 = {},
	toggles_5 = {},
	equipListUIScreen = {
		SignQuality = {},
		SignClass = {},
		SignWearState = {},
		SignSkin = {},
		SignStrengthen = {}
	}
}

EquipListScreenUI = Base:Extend("EquipListScreenUI", "IQIGame.Onigao.UI.EquipListScreenUI", EquipListScreenUI)

function EquipListScreenUI:OnInit()
	self:Initialize()
end

function EquipListScreenUI:GetPreloadAssetPaths()
	return nil
end

function EquipListScreenUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EquipListScreenUI:IsManualShowOnOpen(userData)
	return false
end

function EquipListScreenUI:GetBGM(userData)
	return nil
end

function EquipListScreenUI:OnOpen(userData)
	if userData ~= nil then
		self.OnConfirmCallback = userData.onConfirm
	end

	self:Refresh(userData)
end

function EquipListScreenUI:OnClose(userData)
	self:OnHide()
end

function EquipListScreenUI:OnPause()
	return
end

function EquipListScreenUI:OnResume()
	return
end

function EquipListScreenUI:OnCover()
	return
end

function EquipListScreenUI:OnReveal()
	return
end

function EquipListScreenUI:OnRefocus(userData)
	return
end

function EquipListScreenUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EquipListScreenUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EquipListScreenUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EquipListScreenUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EquipListScreenUI:Initialize()
	for i = 1, 5 do
		local go = self.goSort1Parent.transform:Find("Toggle_" .. i).gameObject
		local toggle = go:GetComponent("Toggle")
		local toggleHelper = go:GetComponent("ToggleHelperComponent")

		self.toggles_1[i] = toggle
		toggleHelper.text = EquipListUIApi:GetString("decomposeToggleTxt", i)
	end

	for i = 1, 3 do
		local go = self.goSort2Parent.transform:Find("Toggle_" .. i).gameObject
		local toggle = go:GetComponent("Toggle")
		local toggleHelper = go:GetComponent("ToggleHelperComponent")

		self.toggles_2[i] = toggle
		toggleHelper.text = MiscApi:GetString("equipClassTxt", i)
	end

	for i = 1, 2 do
		local go = self.goSort3Parent.transform:Find("Toggle_" .. i).gameObject
		local toggle = go:GetComponent("Toggle")
		local toggleHelper = go:GetComponent("ToggleHelperComponent")

		self.toggles_3[i] = toggle
		toggleHelper.text = EquipListUIApi:GetString("screenViewEquipStateTxt", i)
	end

	for i = 1, 3 do
		local go = self.goSort4Parent.transform:Find("Toggle_" .. i).gameObject
		local toggle = go:GetComponent("Toggle")

		self.toggles_4[i] = toggle
	end

	for i = 1, 3 do
		local go = self.goSort5Parent.transform:Find("Toggle_" .. i).gameObject
		local toggle = go:GetComponent("Toggle")

		self.toggles_5[i] = toggle
	end

	self.btnClose = self.goBtnClose:GetComponent("Button")
	self.btnSure = self.goBtnSure:GetComponent("Button")
	self.btnCancel = self.goBtnCancel:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.onClickBtnSureDelegate()
		self:OnClickBtnSure()
	end

	function self.onClickBtnCancelDelegate()
		self:OnClickBtnCancel()
	end

	function self.onClickToggleDelegate_1(isOn)
		self:OnClickToggle_1(isOn)
	end

	function self.onClickToggleDelegate_2(isOn)
		self:OnClickToggle_2(isOn)
	end

	function self.onClickToggleDelegate_3(isOn)
		self:OnClickToggle_3(isOn)
	end

	function self.onClickToggleDelegate_4(isOn)
		self:OnClickToggle_4(isOn)
	end

	function self.onClickToggleDelegate_5(isOn)
		self:OnClickToggle_5(isOn)
	end

	self.goTitle:GetComponent("Text").text = EquipListUIApi:GetString("goTitle1")
	self.goSortTitle_1:GetComponent("Text").text = EquipListUIApi:GetString("screenViewSortTitle_1")
	self.goSortTitle_2:GetComponent("Text").text = EquipListUIApi:GetString("screenViewSortTitle_2")
	self.goSortTitle_3:GetComponent("Text").text = EquipListUIApi:GetString("screenViewSortTitle_3")
	self.goBtnCancel.transform:Find("Text"):GetComponent("Text").text = EquipListUIApi:GetString("screenViewBtnCancelTxt")
	self.goBtnSure.transform:Find("Text"):GetComponent("Text").text = EquipListUIApi:GetString("screenViewBtnSureTxt")
end

function EquipListScreenUI:Refresh(userData)
	for i, v in ipairs(EquipModule.equipListUIScreen.SignWearState) do
		self.equipListUIScreen.SignWearState[i] = v
	end

	for i, v in ipairs(EquipModule.equipListUIScreen.SignClass) do
		self.equipListUIScreen.SignClass[i] = v
	end

	for i, v in ipairs(EquipModule.equipListUIScreen.SignQuality) do
		self.equipListUIScreen.SignQuality[i] = v
	end

	for i, v in ipairs(EquipModule.equipListUIScreen.SignSkin) do
		self.equipListUIScreen.SignSkin[i] = v
	end

	for i, v in ipairs(EquipModule.equipListUIScreen.SignStrengthen) do
		self.equipListUIScreen.SignStrengthen[i] = v
	end

	self.hasRefreshed = false

	self:SetDefaultToggle()

	self.hasRefreshed = true
end

function EquipListScreenUI:OnAddListeners()
	self.goBtnClose1:GetComponent("Button").onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnSure.onClick:AddListener(self.onClickBtnSureDelegate)
	self.btnCancel.onClick:AddListener(self.onClickBtnCancelDelegate)

	for i, v in pairs(self.toggles_1) do
		v.onValueChanged:AddListener(self.onClickToggleDelegate_1)
	end

	for i, v in pairs(self.toggles_2) do
		v.onValueChanged:AddListener(self.onClickToggleDelegate_2)
	end

	for i, v in pairs(self.toggles_3) do
		v.onValueChanged:AddListener(self.onClickToggleDelegate_3)
	end

	for i, v in pairs(self.toggles_4) do
		v.onValueChanged:AddListener(self.onClickToggleDelegate_4)
	end

	for i, v in pairs(self.toggles_5) do
		v.onValueChanged:AddListener(self.onClickToggleDelegate_5)
	end
end

function EquipListScreenUI:OnRemoveListeners()
	self.goBtnClose1:GetComponent("Button").onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnSure.onClick:RemoveListener(self.onClickBtnSureDelegate)
	self.btnCancel.onClick:RemoveListener(self.onClickBtnCancelDelegate)

	for i, v in pairs(self.toggles_1) do
		v.onValueChanged:RemoveListener(self.onClickToggleDelegate_1)
	end

	for i, v in pairs(self.toggles_2) do
		v.onValueChanged:RemoveListener(self.onClickToggleDelegate_2)
	end

	for i, v in pairs(self.toggles_3) do
		v.onValueChanged:RemoveListener(self.onClickToggleDelegate_3)
	end

	for i, v in pairs(self.toggles_4) do
		v.onValueChanged:RemoveListener(self.onClickToggleDelegate_4)
	end

	for i, v in pairs(self.toggles_5) do
		v.onValueChanged:RemoveListener(self.onClickToggleDelegate_5)
	end
end

function EquipListScreenUI:OnHide()
	return
end

function EquipListScreenUI:OnDestroy()
	self.toggles_1 = nil
	self.toggles_2 = nil
	self.toggles_3 = nil
	self.toggles_4 = nil
	self.toggles_5 = nil
end

function EquipListScreenUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function EquipListScreenUI:OnClickBtnSure()
	for i, v in ipairs(self.equipListUIScreen.SignWearState) do
		EquipModule.equipListUIScreen.SignWearState[i] = v
	end

	for i, v in ipairs(self.equipListUIScreen.SignClass) do
		EquipModule.equipListUIScreen.SignClass[i] = v
	end

	for i, v in ipairs(self.equipListUIScreen.SignQuality) do
		EquipModule.equipListUIScreen.SignQuality[i] = v
	end

	for i, v in ipairs(self.equipListUIScreen.SignSkin) do
		EquipModule.equipListUIScreen.SignSkin[i] = v
	end

	for i, v in ipairs(self.equipListUIScreen.SignStrengthen) do
		EquipModule.equipListUIScreen.SignStrengthen[i] = v
	end

	EventDispatcher.Dispatch(EventID.EquipSortRefresh)
	UIModule.CloseSelf(self)

	if self.OnConfirmCallback ~= nil then
		local filterPattern = EquipModule.OldDataToFilterPattern()

		self.OnConfirmCallback(filterPattern)
	end
end

function EquipListScreenUI:OnClickBtnCancel()
	EquipModule.ResetEquipListUIScreen()
	self:Refresh()
end

function EquipListScreenUI:OnClickToggle_1(isOn)
	if not self.hasRefreshed then
		return
	end

	for i = 2, 5 do
		self.equipListUIScreen.SignQuality[i - 1] = self.toggles_1[i].isOn
	end
end

function EquipListScreenUI:OnClickToggle_2(isOn)
	if not self.hasRefreshed then
		return
	end

	for i, v in ipairs(self.toggles_2) do
		self.equipListUIScreen.SignClass[i] = v.isOn
	end
end

function EquipListScreenUI:OnClickToggle_3(isOn)
	if not self.hasRefreshed then
		return
	end

	for i, v in ipairs(self.toggles_3) do
		self.equipListUIScreen.SignWearState[i] = v.isOn
	end
end

function EquipListScreenUI:OnClickToggle_4(isOn)
	if not self.hasRefreshed then
		return
	end

	for i, v in ipairs(self.toggles_4) do
		self.equipListUIScreen.SignSkin[i] = v.isOn
	end
end

function EquipListScreenUI:OnClickToggle_5(isOn)
	if not self.hasRefreshed then
		return
	end

	for i, v in ipairs(self.toggles_5) do
		self.equipListUIScreen.SignStrengthen[i] = v.isOn
	end
end

function EquipListScreenUI:SetDefaultToggle()
	for i, v in ipairs(self.toggles_1) do
		if i > 1 then
			v.isOn = self.equipListUIScreen.SignQuality[i - 1]
		end
	end

	for i, v in ipairs(self.toggles_2) do
		v.isOn = self.equipListUIScreen.SignClass[i]
	end

	for i, v in ipairs(self.toggles_3) do
		v.isOn = self.equipListUIScreen.SignWearState[i]
	end

	for i, v in ipairs(self.toggles_4) do
		v.isOn = self.equipListUIScreen.SignSkin[i]
	end

	for i, v in ipairs(self.toggles_5) do
		v.isOn = self.equipListUIScreen.SignStrengthen[i]
	end
end

return EquipListScreenUI
