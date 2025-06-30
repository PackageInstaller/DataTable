-- chunkname: @IQIGame\\UI\\EquipListSortUI.lua

local EquipListSortUI = Base:Extend("EquipListSortUI", "IQIGame.Onigao.UI.EquipListSortUI", {
	toggles_1 = {},
	toggles_2 = {}
})

function EquipListSortUI:OnInit()
	self:Initialize()
end

function EquipListSortUI:GetPreloadAssetPaths()
	return nil
end

function EquipListSortUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EquipListSortUI:OnOpen(userData)
	if userData ~= nil then
		self.OnConfirmCallback = userData.onConfirm
	end

	self:Refresh(userData)
end

function EquipListSortUI:OnClose(userData)
	self:OnHide()
end

function EquipListSortUI:OnPause()
	return
end

function EquipListSortUI:OnResume()
	return
end

function EquipListSortUI:OnCover()
	return
end

function EquipListSortUI:OnReveal()
	return
end

function EquipListSortUI:OnRefocus(userData)
	return
end

function EquipListSortUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EquipListSortUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EquipListSortUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EquipListSortUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EquipListSortUI:Initialize()
	for i = 1, 5 do
		local go = self.goSort1Parent.transform:Find("Toggle_" .. i).gameObject
		local toggle = go:GetComponent("Toggle")
		local toggleHelper = go:GetComponent("ToggleHelperComponent")

		self.toggles_1[i] = toggle
		toggleHelper.text = EquipListUIApi:GetString("sortViewBtnSortTxt_1", i)
	end

	for i = 1, 2 do
		local go = self.goSort2Parent.transform:Find("Toggle_" .. i).gameObject
		local toggle = go:GetComponent("Toggle")
		local toggleHelper = go:GetComponent("ToggleHelperComponent")

		self.toggles_2[i] = toggle
		toggleHelper.text = EquipListUIApi:GetString("sortViewBtnSortTxt_2", i)
	end

	self.btnClose = self.goBtnClose:GetComponent("Button")
	self.btnSure = self.goBtnSure:GetComponent("Button")
	self.btnCancel = self.goBtnCancel:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.onClickToggleDelegate_1(isOn)
		self:OnClickToggle_1(isOn)
	end

	function self.onClickToggleDelegate_2(isOn)
		self:OnClickToggle_2(isOn)
	end

	function self.onClickBtnSureDelegate()
		self:OnClickBtnSure()
	end

	function self.onClickBtnCancelDelegate()
		self:OnClickBtnCancel()
	end

	self.goTitle:GetComponent("Text").text = EquipListUIApi:GetString("sortViewTitle")
	self.goSortTitle_1:GetComponent("Text").text = EquipListUIApi:GetString("sortViewSortTitle_1")
	self.goSortTitle_2:GetComponent("Text").text = EquipListUIApi:GetString("sortViewSortTitle_2")
	self.goBtnCancel.transform:Find("Text"):GetComponent("Text").text = EquipListUIApi:GetString("sortViewBtnCancelTxt")
	self.goBtnSure.transform:Find("Text"):GetComponent("Text").text = EquipListUIApi:GetString("sortViewBtnSureTxt")
end

function EquipListSortUI:Refresh(userData)
	self.selectedIndex = EquipModule.equipListUISort.selectedIndex

	for i, v in ipairs(EquipModule.equipListUISort.sortState) do
		if i == self.selectedIndex then
			self.sort = v

			break
		end
	end

	self:SetDefaultToggle()
end

function EquipListSortUI:OnHide()
	return
end

function EquipListSortUI:OnDestroy()
	self.toggles_1 = nil
	self.toggles_2 = nil
end

function EquipListSortUI:OnAddListeners()
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
end

function EquipListSortUI:OnRemoveListeners()
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
end

function EquipListSortUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function EquipListSortUI:OnClickToggle_1(isOn)
	local clicked = false

	for i, v in pairs(self.toggles_1) do
		if self.UIController:GetCurrentTarget() == v.gameObject then
			clicked = true

			break
		end
	end

	if clicked == false then
		return
	end

	if isOn then
		for i, v in ipairs(self.toggles_1) do
			if v.isOn then
				self.selectedIndex = i

				break
			end
		end
	end
end

function EquipListSortUI:OnClickToggle_2(isOn)
	local clicked = false

	for i, v in pairs(self.toggles_2) do
		if self.UIController:GetCurrentTarget() == v.gameObject then
			clicked = true

			break
		end
	end

	if clicked == false then
		return
	end

	if isOn then
		for i, v in ipairs(self.toggles_2) do
			if v.isOn then
				self.sort = i == 1

				break
			end
		end
	end
end

function EquipListSortUI:OnClickBtnSure()
	EquipModule.equipListUISort.selectedIndex = self.selectedIndex

	for i, v in ipairs(EquipModule.equipListUISort.sortState) do
		if i == self.selectedIndex then
			EquipModule.equipListUISort.sortState[i] = self.sort
		else
			EquipModule.equipListUISort.sortState[i] = true
		end
	end

	self:OnClickBtnCancel()

	if self.OnConfirmCallback ~= nil then
		self.OnConfirmCallback(self.selectedIndex, self.sort)
	end
end

function EquipListSortUI:OnClickBtnCancel()
	UIModule.Close(Constant.UIControllerName.EquipListSortUI)
	EventDispatcher.Dispatch(EventID.EquipSortRefresh)
end

function EquipListSortUI:SetDefaultToggle()
	for i, v in ipairs(self.toggles_1) do
		v.isOn = self.selectedIndex == i
	end

	self.toggles_2[1].isOn = self.sort
	self.toggles_2[2].isOn = not self.sort
end

return EquipListSortUI
