-- chunkname: @IQIGame\\UI\\GmPanelListUI.lua

local GmPanelListUI = Base:Extend("GmPanelListUI", "IQIGame.Onigao.UI.GmPanelListUI", {
	btnToggles = {}
})

function GmPanelListUI:OnInit()
	self:Initialize()
end

function GmPanelListUI:GetPreloadAssetPaths()
	return nil
end

function GmPanelListUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GmPanelListUI:OnOpen(userData)
	self:Refresh(userData)
end

function GmPanelListUI:OnClose(userData)
	self:OnHide()
end

function GmPanelListUI:OnPause()
	return
end

function GmPanelListUI:OnResume()
	return
end

function GmPanelListUI:OnCover()
	return
end

function GmPanelListUI:OnReveal()
	return
end

function GmPanelListUI:OnRefocus(userData)
	return
end

function GmPanelListUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GmPanelListUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GmPanelListUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GmPanelListUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GmPanelListUI:Initialize()
	self.btnClose = self.goBtnClose:GetComponent("Button")
	self.btnSure = self.goBtnSure:GetComponent("Button")

	function self.onClickBtnSureDelegate()
		self:OnClickBtnSure()
	end

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	local toggles = {}

	for i = 1, self.goToggleBlock.transform.childCount do
		toggles[i] = self.goToggleBlock.transform:Find("Mould_" .. i .. "/Toggle"):GetComponent("Toggle")
	end

	self.btnToggles[GmListModule.Key_OpenAnim] = toggles[1]
	self.btnToggles[GmListModule.Key_Guide] = toggles[2]
	self.btnToggles[GmListModule.Key_GM] = toggles[3]
	self.btnToggles[GmListModule.Key_SkipBattle] = toggles[4]
	self.btnToggles[GmListModule.Key_Debugger] = toggles[5]
	self.btnToggles[GmListModule.Key_Gesture] = toggles[6]
	self.btnToggles[GmListModule.KEY_MAZE_CLOUD_SAVE_DATA] = toggles[7]
	self.btnToggles[GmListModule.Key_InspectorCanvas] = toggles[8]
	self.btnToggles[GmListModule.Key_ErrorLog] = toggles[9]
	self.btnToggles[GmListModule.Key_Simulate_Notch] = toggles[10]
	self.btnToggles[GmListModule.Key_Change_To_Test_Pack] = toggles[11]
	self.btnToggles[GmListModule.Key_Change_To_Spe_Test_Pack] = toggles[12]

	function self.onToggle1Delegate(isOn)
		self:OnToggle1(isOn)
	end

	function self.onToggle2Delegate(isOn)
		self:OnToggle2(isOn)
	end

	function self.onToggle3Delegate(isOn)
		self:OnToggle3(isOn)
	end

	function self.onToggle4Delegate(isOn)
		self:OnToggle4(isOn)
	end

	function self.onToggle5Delegate(isOn)
		self:OnToggle5(isOn)
	end

	function self.onToggle6Delegate(isOn)
		self:OnToggle6(isOn)
	end

	function self.onToggle7Delegate(isOn)
		self:OnToggle7(isOn)
	end

	function self.onToggle8Delegate(isOn)
		self:OnToggle8(isOn)
	end

	function self.onToggle9Delegate(isOn)
		self:OnToggle9(isOn)
	end

	function self.onToggle10Delegate(isOn)
		self:OnToggle10(isOn)
	end

	function self.onToggle11Delegate(isOn)
		self:OnToggle11(isOn)
	end

	function self.onToggle12Delegate(isOn)
		self:OnToggle12(isOn)
	end
end

function GmPanelListUI:Refresh(userData)
	self.config = {}

	for i, v in pairs(GmListModule.config) do
		self.config[i] = v
	end

	for i, v in pairs(self.btnToggles) do
		v.isOn = self.config[i]
	end
end

function GmPanelListUI:OnHide()
	return
end

function GmPanelListUI:OnDestroy()
	return
end

function GmPanelListUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnSure.onClick:AddListener(self.onClickBtnSureDelegate)
	self.btnToggles[GmListModule.Key_OpenAnim].onValueChanged:AddListener(self.onToggle1Delegate)
	self.btnToggles[GmListModule.Key_Guide].onValueChanged:AddListener(self.onToggle2Delegate)
	self.btnToggles[GmListModule.Key_GM].onValueChanged:AddListener(self.onToggle3Delegate)
	self.btnToggles[GmListModule.Key_SkipBattle].onValueChanged:AddListener(self.onToggle4Delegate)
	self.btnToggles[GmListModule.Key_Debugger].onValueChanged:AddListener(self.onToggle5Delegate)
	self.btnToggles[GmListModule.Key_Gesture].onValueChanged:AddListener(self.onToggle6Delegate)
	self.btnToggles[GmListModule.KEY_MAZE_CLOUD_SAVE_DATA].onValueChanged:AddListener(self.onToggle7Delegate)
	self.btnToggles[GmListModule.Key_InspectorCanvas].onValueChanged:AddListener(self.onToggle8Delegate)
	self.btnToggles[GmListModule.Key_ErrorLog].onValueChanged:AddListener(self.onToggle9Delegate)
	self.btnToggles[GmListModule.Key_Simulate_Notch].onValueChanged:AddListener(self.onToggle10Delegate)
	self.btnToggles[GmListModule.Key_Change_To_Test_Pack].onValueChanged:AddListener(self.onToggle11Delegate)
	self.btnToggles[GmListModule.Key_Change_To_Spe_Test_Pack].onValueChanged:AddListener(self.onToggle12Delegate)
end

function GmPanelListUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnSure.onClick:RemoveListener(self.onClickBtnSureDelegate)
	self.btnToggles[GmListModule.Key_OpenAnim].onValueChanged:RemoveListener(self.onToggle1Delegate)
	self.btnToggles[GmListModule.Key_Guide].onValueChanged:RemoveListener(self.onToggle2Delegate)
	self.btnToggles[GmListModule.Key_GM].onValueChanged:RemoveListener(self.onToggle3Delegate)
	self.btnToggles[GmListModule.Key_SkipBattle].onValueChanged:RemoveListener(self.onToggle4Delegate)
	self.btnToggles[GmListModule.Key_Debugger].onValueChanged:RemoveListener(self.onToggle5Delegate)
	self.btnToggles[GmListModule.Key_Gesture].onValueChanged:RemoveListener(self.onToggle6Delegate)
	self.btnToggles[GmListModule.KEY_MAZE_CLOUD_SAVE_DATA].onValueChanged:RemoveListener(self.onToggle7Delegate)
	self.btnToggles[GmListModule.Key_InspectorCanvas].onValueChanged:RemoveListener(self.onToggle8Delegate)
	self.btnToggles[GmListModule.Key_ErrorLog].onValueChanged:RemoveListener(self.onToggle9Delegate)
	self.btnToggles[GmListModule.Key_Simulate_Notch].onValueChanged:RemoveListener(self.onToggle10Delegate)
	self.btnToggles[GmListModule.Key_Change_To_Test_Pack].onValueChanged:RemoveListener(self.onToggle11Delegate)
	self.btnToggles[GmListModule.Key_Change_To_Spe_Test_Pack].onValueChanged:RemoveListener(self.onToggle12Delegate)
end

function GmPanelListUI:OnClickBtnClose()
	self:SaveAndClose()
end

function GmPanelListUI:OnClickBtnSure()
	self:SaveAndClose()
end

function GmPanelListUI:SaveAndClose()
	GmListModule.SaveDebugConfig(self.config)
	GmListModule.SetDebuggerVisible(GmListModule.EnableDebug())
	GmListModule.SetGmEntryVisible(GmListModule.EnableGM())
	GmListModule.SetInspectorCanvasVisible(GmListModule.EnableInspectorCanvas())
	GmListModule.SetErrorLogEnable(GmListModule.EnableErrorLog())
	UIModule.Close(Constant.UIControllerName.GmPanelListUI)
end

function GmPanelListUI:OnToggle1(isOn)
	self.config[GmListModule.Key_OpenAnim] = isOn
end

function GmPanelListUI:OnToggle2(isOn)
	self.config[GmListModule.Key_Guide] = isOn
end

function GmPanelListUI:OnToggle3(isOn)
	self.config[GmListModule.Key_GM] = isOn
end

function GmPanelListUI:OnToggle4(isOn)
	self.config[GmListModule.Key_SkipBattle] = isOn
end

function GmPanelListUI:OnToggle5(isOn)
	self.config[GmListModule.Key_Debugger] = isOn
end

function GmPanelListUI:OnToggle6(isOn)
	self.config[GmListModule.Key_Gesture] = isOn
end

function GmPanelListUI:OnToggle7(isOn)
	self.config[GmListModule.KEY_MAZE_CLOUD_SAVE_DATA] = isOn
end

function GmPanelListUI:OnToggle8(isOn)
	self.config[GmListModule.Key_InspectorCanvas] = isOn
end

function GmPanelListUI:OnToggle9(isOn)
	self.config[GmListModule.Key_ErrorLog] = isOn
end

function GmPanelListUI:OnToggle10(isOn)
	self.config[GmListModule.Key_Simulate_Notch] = isOn

	UnityEngine.GameObject.Find("PhoneFrame").transform:GetChild(0).gameObject:SetActive(isOn)
end

function GmPanelListUI:OnToggle11(isOn)
	self.config[GmListModule.Key_Change_To_Test_Pack] = isOn
end

function GmPanelListUI:OnToggle12(isOn)
	self.config[GmListModule.Key_Change_To_Spe_Test_Pack] = isOn
end

return GmPanelListUI
