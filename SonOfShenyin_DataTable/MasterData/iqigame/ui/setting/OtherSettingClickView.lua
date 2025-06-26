-- chunkname: @IQIGame\\UI\\Setting\\OtherSettingClickView.lua

local UrpSettingView = require("IQIGame.UI.Setting.UrpSettingView")

OtherSettingClickView = {}

function OtherSettingClickView.New(go, mianView)
	local o = Clone(OtherSettingClickView)

	o:Initialize(go, mianView)

	return o
end

function OtherSettingClickView:Initialize(go, mianView)
	self.mianView = mianView
	self.gameObject = go

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	LuaCodeInterface.BindOutlet(self.LamplighNum, self)
	LuaCodeInterface.BindOutlet(self.RoleNum, self)
	self:InitDelegation()
	self:InitToggle()

	self.urpAsset = UGUIUtil.GetMainUniversalRenderPipelineAsset()

	self:OnAddListeners()

	self.RoleNum_count = 0
	self.LamplighNum_count = 0
	self.RoleNum_Maxcount = 0
	self.LamplighNum_Maxcount = 0
end

function OtherSettingClickView:OpenRefresh()
	self:RefreshUrp()

	self.RoleNum_Maxcount = UGUIUtil.GetUrpMaxRoleNum()

	if self.RoleNum_Maxcount == nil then
		self.RoleNum_Maxcount = 0
	end

	self.RoleNum_count = self.RoleNum_Maxcount
	self.RoleNum_Text.text = self.RoleNum_Maxcount
	self.LamplighNum_Maxcount = UGUIUtil.GetUrpMaxLamplighNum()

	if self.LamplighNum_Maxcount == nil then
		self.LamplighNum_Maxcount = 0
	end

	self.LamplighNum_count = self.LamplighNum_Maxcount
	self.LamplighNum_Text.text = self.LamplighNum_Maxcount
	self.ScreenNameText.text = UGUIUtil.GetUrpCurScreenName()

	self.MASSTapCount:ToggleEvent(self:GetMSaaDes(SettingModule.UrpToggle.MASS))
	self.GradingModeTapCount:ToggleEvent(SettingModule.UrpToggle.GradingMode == 0 and "Low" or "High")
end

function OtherSettingClickView:InitDelegation()
	function self.OnToggleMass(go, isOn)
		self:OnToggleMassChanged(go, isOn)
	end

	function self.OnToggleGradingMode(go, isOn)
		self:OnToggleGradingModeChanged(go, isOn)
	end

	function self.DelegateGradingModeInput(value)
		self:GradingModeInputFunction(value)
	end

	function self.DelegateRoleNum_AddClick()
		self:RoleNumAddClick()
	end

	function self.DelegateRoleNum_SubClick()
		self:RoleNumSubClick()
	end

	function self.DelegateLamplighNum_AddClick()
		self:LamplighNumAddClick()
	end

	function self.DelegateLamplighNum_SubClick()
		self:LamplighNumSubClick()
	end
end

function OtherSettingClickView:RoleNumSubClick()
	self.RoleNum_count = self.RoleNum_count - 1

	if self.RoleNum_count < 0 then
		self.RoleNum_count = 0
	end

	self.RoleNum_Text.text = self.RoleNum_count

	GameEntry.LuaEvent:FireNow(nil, UrpSettingEventArgs():Fill(8, false, self.RoleNum_count))
	SettingModule.SetUrpSetting(Constant.PlayerPrefsConst.RoleNum, self.RoleNum_count)
end

function OtherSettingClickView:RoleNumAddClick()
	self.RoleNum_count = self.RoleNum_count + 1

	if self.RoleNum_count > self.RoleNum_Maxcount then
		self.RoleNum_count = self.RoleNum_Maxcount
	end

	self.RoleNum_Text.text = self.RoleNum_count

	GameEntry.LuaEvent:FireNow(nil, UrpSettingEventArgs():Fill(8, false, self.RoleNum_count))
	SettingModule.SetUrpSetting(Constant.PlayerPrefsConst.RoleNum, self.RoleNum_count)
end

function OtherSettingClickView:LamplighNumSubClick()
	self.LamplighNum_count = self.LamplighNum_count - 1

	if self.LamplighNum_count < 0 then
		self.LamplighNum_count = 0
	end

	self.LamplighNum_Text.text = self.LamplighNum_count

	GameEntry.LuaEvent:FireNow(nil, UrpSettingEventArgs():Fill(7, false, self.LamplighNum_count))
	SettingModule.SetUrpSetting(Constant.PlayerPrefsConst.LamplighNum, self.LamplighNum_count)
end

function OtherSettingClickView:LamplighNumAddClick()
	self.LamplighNum_count = self.LamplighNum_count + 1

	if self.LamplighNum_count > self.LamplighNum_Maxcount then
		self.LamplighNum_count = self.LamplighNum_Maxcount
	end

	self.LamplighNum_Text.text = self.LamplighNum_count

	GameEntry.LuaEvent:FireNow(nil, UrpSettingEventArgs():Fill(7, false, self.LamplighNum_count))
	SettingModule.SetUrpSetting(Constant.PlayerPrefsConst.LamplighNum, self.LamplighNum_count)
end

function OtherSettingClickView:InitToggle()
	self.OpaquedownsamplingView = UrpSettingView.New(self.Opaquedownsampling.gameObject, self, SettingModule.UrpToggle.Opaquedownsampling, Constant.PlayerPrefsConst.Opaquedownsampling)
	self.MASSTapCount = TapContent:New()

	self.MASSTapCount:Init(self.MassTap.gameObject, self.OnToggleMass)

	self.GradingModeTapCount = TapContent:New()

	self.GradingModeTapCount:Init(self.GradingModeTap.gameObject, self.OnToggleGradingMode)

	self.GradingModeInput = self.GridingInputField:GetComponent("IQIGame.Onigao.Game.UI.InputField")
	self.SSAOView = UrpSettingView.New(self.SSAO.gameObject, self, SettingModule.UrpToggle.SSAO, Constant.PlayerPrefsConst.SSAO)

	if UGUIUtil._SettingData.b_WaterEffect ~= nil then
		SettingModule.UrpToggle.WaterEffect = UGUIUtil._SettingData.b_WaterEffect == true and 1 or 0
	end

	self.WaterEffectView = UrpSettingView.New(self.WaterEffect.gameObject, self, SettingModule.UrpToggle.WaterEffect, Constant.PlayerPrefsConst.WaterEffect)

	if UGUIUtil._SettingData.b_Scattering ~= nil then
		SettingModule.UrpToggle.Scattering = UGUIUtil._SettingData.b_Scattering == true and 1 or 0
	end

	self.ScatteringView = UrpSettingView.New(self.Scattering.gameObject, self, SettingModule.UrpToggle.Scattering, Constant.PlayerPrefsConst.Scattering)

	if UGUIUtil._SettingData.b_PostProcessingParentObj ~= nil then
		SettingModule.UrpToggle.PostProcessing = UGUIUtil._SettingData.b_PostProcessingParentObj == true and 1 or 0
	end

	self.PostProcessingView = UrpSettingView.New(self.PostProcessing.gameObject, self, SettingModule.UrpToggle.PostProcessing, Constant.PlayerPrefsConst.PostProcessing)

	if UGUIUtil._SettingData.b_BloomsList ~= nil then
		SettingModule.UrpToggle.Bloom = UGUIUtil._SettingData.b_BloomsList == true and 1 or 0
	end

	self.BloomView = UrpSettingView.New(self.Bloom.gameObject, self, SettingModule.UrpToggle.Bloom, Constant.PlayerPrefsConst.Bloom)

	if UGUIUtil._SettingData.b__DepthOfFieldsList ~= nil then
		SettingModule.UrpToggle.Depthoffield = UGUIUtil._SettingData.b__DepthOfFieldsList == true and 1 or 0
	end

	self.DepthoffieldView = UrpSettingView.New(self.Depthoffield.gameObject, self, SettingModule.UrpToggle.Depthoffield, Constant.PlayerPrefsConst.Depthoffield)

	if UGUIUtil._SettingData.b_RoleInvertedImage ~= nil then
		SettingModule.UrpToggle.RoleInvertedImage = UGUIUtil._SettingData.b_RoleInvertedImage == true and 1 or 0
	end

	self.RoleInvertedImageView = UrpSettingView.New(self.RoleInvertedImage.gameObject, self, SettingModule.UrpToggle.RoleInvertedImage, Constant.PlayerPrefsConst.RoleInvertedImage)
	self.RoleNum_Text = self.RoleNum_Text:GetComponent("Text")
	self.RoleNum_SubBtn = self.RoleNum_SubBtn:GetComponent("Button")
	self.RoleNum_AddBtn = self.RoleNum_AddBtn:GetComponent("Button")
	self.LamplighNum_Text = self.LamplighNum_Text:GetComponent("Text")
	self.LamplighNum_SubBtn = self.LamplighNum_SubBtn:GetComponent("Button")
	self.LamplighNum_AddBtn = self.LamplighNum_AddBtn:GetComponent("Button")
	self.ScreenNameText = self.ScreenName:GetComponent("Text")
end

function OtherSettingClickView:GetMSaaDes(index)
	if index == 1 then
		return "Diaabled"
	elseif index == 2 then
		return "2x"
	elseif index == 4 then
		return "4x"
	elseif index == 8 then
		return "8x"
	end
end

function OtherSettingClickView:OnToggleMassChanged(go_name)
	log("go_name  " .. go_name)

	local index = 1

	if go_name == "Diaabled" then
		index = 1
	elseif go_name == "2x" then
		index = 2
	elseif go_name == "4x" then
		index = 4
	elseif go_name == "8x" then
		index = 8
	end

	self.urpAsset.msaaSampleCount = index

	SettingModule.SetUrpSetting(Constant.PlayerPrefsConst.MASS, index)
end

function OtherSettingClickView:OnToggleGradingModeChanged(go_name)
	log("go_name  " .. go_name)

	local index = 0

	if go_name == "Low" then
		index = 0
		self.urpAsset.colorGradingMode = ColorGradingMode.LowDynamicRange
	elseif go_name == "High" then
		index = 1
		self.urpAsset.colorGradingMode = ColorGradingMode.HighDynamicRange
	end

	SettingModule.SetUrpSetting(Constant.PlayerPrefsConst.GradingMode, index)
end

function OtherSettingClickView:GradingModeInputFunction(Value)
	self.urpAsset.colorGradingLutSize = Value

	SettingModule.SetUrpSetting(Constant.PlayerPrefsConst.GradingModeValue, Value)
end

function OtherSettingClickView:OnRefresh_Opaquedownsampling()
	self.urpAsset.supportsCameraOpaqueTexture = SettingModule.UrpToggle.Opaquedownsampling == 1
end

function OtherSettingClickView:OnRefresh_GradingMode(init)
	self.urpAsset.colorGradingMode = SettingModule.UrpToggle.GradingMode == 0 and ColorGradingMode.LowDynamicRange or ColorGradingMode.HighDynamicRange
	self.GradingModeInput.text = SettingModule.UrpToggle.GradingModeValue
end

function OtherSettingClickView:OnRefresh_SSAO()
	return
end

function OtherSettingClickView:RefreshUrp(init)
	self:OnRefresh_Opaquedownsampling()
	self:OnRefresh_GradingMode(init)
end

function OtherSettingClickView:Close()
	return
end

function OtherSettingClickView:OnAddListeners()
	self.GradingModeInput.onEndEdit:AddListener(self.DelegateGradingModeInput)
	self.RoleNum_SubBtn.onClick:AddListener(self.DelegateRoleNum_SubClick)
	self.RoleNum_AddBtn.onClick:AddListener(self.DelegateRoleNum_AddClick)
	self.LamplighNum_SubBtn.onClick:AddListener(self.DelegateLamplighNum_SubClick)
	self.LamplighNum_AddBtn.onClick:AddListener(self.DelegateLamplighNum_AddClick)
end

function OtherSettingClickView:OnRemoveListeners()
	self.GradingModeInput.onEndEdit:RemoveListener(self.DelegateGradingModeInput)
	self.RoleNum_SubBtn.onClick:RemoveListener(self.DelegateRoleNum_SubClick)
	self.RoleNum_AddBtn.onClick:RemoveListener(self.DelegateRoleNum_AddClick)
	self.LamplighNum_SubBtn.onClick:RemoveListener(self.DelegateLamplighNum_SubClick)
	self.LamplighNum_AddBtn.onClick:RemoveListener(self.DelegateLamplighNum_AddClick)
end

function OtherSettingClickView:OnDestroy()
	self.OpaquedownsamplingView:OnDestroy()
	self.SSAOView:OnDestroy()
	self.WaterEffectView:OnDestroy()
	self.ScatteringView:OnDestroy()
	self.PostProcessingView:OnDestroy()
	self.BloomView:OnDestroy()
	self.DepthoffieldView:OnDestroy()
	self.RoleInvertedImageView:OnDestroy()
	self:OnRemoveListeners()
	LuaCodeInterface.ClearOutlet(self.RoleNum, self)
	LuaCodeInterface.ClearOutlet(self.LamplighNum, self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
	self.mainView = nil
end

return OtherSettingClickView
