-- chunkname: @IQIGame\\UI\\Setting\\UrpSettingView.lua

UrpSettingView = {
	ToggleTable = {}
}

function UrpSettingView.New(go, mianView, CurToggle, CurToggleName)
	local o = Clone(UrpSettingView)

	o:Initialize(go, mianView, CurToggle, CurToggleName)

	return o
end

function UrpSettingView:DeleteFunction()
	function self.OnClick_ToggleClick()
		self:OnClickToggleClick()
	end
end

function UrpSettingView:Initialize(go, mianView, CurToggle, CurToggleName)
	self.mianView = mianView
	self.CurToggle = CurToggle
	self.CurToggleName = CurToggleName

	self:DeleteFunction()

	self.gameObject = go

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.button = self.Btn:GetComponent("Button")

	self:AddEventListener()
	self:RefreshToggle()

	self.urpAsset = UGUIUtil.GetMainUniversalRenderPipelineAsset()
end

function UrpSettingView:OnClickToggleClick()
	self:SetUrpToggleType()
end

function UrpSettingView:TextRenderScale(isSave)
	if self.TextAA == nil then
		self.TextAA = false
	end

	self.TextAA = not self.TextAA

	if isSave then
		self.urpAsset.renderScale = self.TextAA and 0 or 1
	end
end

function UrpSettingView:SetUrpToggleType(isRefresh)
	local Sendtype = 0

	if self.CurToggleName == Constant.PlayerPrefsConst.Opaquedownsampling then
		if SettingModule.UrpToggle.Opaquedownsampling == 1 then
			SettingModule.UrpToggle.Opaquedownsampling = 0
		elseif SettingModule.UrpToggle.Opaquedownsampling == 0 then
			SettingModule.UrpToggle.Opaquedownsampling = 1
		end

		self.CurToggle = SettingModule.UrpToggle.Opaquedownsampling
		self.urpAsset.supportsCameraOpaqueTexture = SettingModule.UrpToggle.Opaquedownsampling == 1

		SettingModule.SetUrpSetting(Constant.PlayerPrefsConst.Opaquedownsampling, SettingModule.UrpToggle.Opaquedownsampling)
	elseif self.CurToggleName == Constant.PlayerPrefsConst.SSAO then
		if SettingModule.UrpToggle.SSAO == 1 then
			SettingModule.UrpToggle.SSAO = 0
		elseif SettingModule.UrpToggle.SSAO == 0 then
			SettingModule.UrpToggle.SSAO = 1
		end

		self.CurToggle = SettingModule.UrpToggle.SSAO

		SettingModule.SetUrpSetting(Constant.PlayerPrefsConst.SSAO, SettingModule.UrpToggle.SSAO)
	elseif self.CurToggleName == Constant.PlayerPrefsConst.WaterEffect then
		if SettingModule.UrpToggle.WaterEffect == 1 then
			SettingModule.UrpToggle.WaterEffect = 0
		elseif SettingModule.UrpToggle.WaterEffect == 0 then
			SettingModule.UrpToggle.WaterEffect = 1
		end

		self.CurToggle = SettingModule.UrpToggle.WaterEffect

		SettingModule.SetUrpSetting(Constant.PlayerPrefsConst.WaterEffect, SettingModule.UrpToggle.WaterEffect)

		Sendtype = 1
	elseif self.CurToggleName == Constant.PlayerPrefsConst.Scattering then
		if SettingModule.UrpToggle.Scattering == 1 then
			SettingModule.UrpToggle.Scattering = 0
		elseif SettingModule.UrpToggle.Scattering == 0 then
			SettingModule.UrpToggle.Scattering = 1
		end

		self.CurToggle = SettingModule.UrpToggle.Scattering

		SettingModule.SetUrpSetting(Constant.PlayerPrefsConst.Scattering, SettingModule.UrpToggle.Scattering)

		Sendtype = 2
	elseif self.CurToggleName == Constant.PlayerPrefsConst.PostProcessing then
		if SettingModule.UrpToggle.PostProcessing == 1 then
			SettingModule.UrpToggle.PostProcessing = 0
		elseif SettingModule.UrpToggle.PostProcessing == 0 then
			SettingModule.UrpToggle.PostProcessing = 1
		end

		self.CurToggle = SettingModule.UrpToggle.PostProcessing

		SettingModule.SetUrpSetting(Constant.PlayerPrefsConst.PostProcessing, SettingModule.UrpToggle.PostProcessing)

		Sendtype = 3
	elseif self.CurToggleName == Constant.PlayerPrefsConst.Bloom then
		if SettingModule.UrpToggle.Bloom == 1 then
			SettingModule.UrpToggle.Bloom = 0
		elseif SettingModule.UrpToggle.Bloom == 0 then
			SettingModule.UrpToggle.Bloom = 1
		end

		self.CurToggle = SettingModule.UrpToggle.Bloom

		SettingModule.SetUrpSetting(Constant.PlayerPrefsConst.Bloom, SettingModule.UrpToggle.Bloom)

		Sendtype = 4
	elseif self.CurToggleName == Constant.PlayerPrefsConst.Depthoffield then
		if SettingModule.UrpToggle.Depthoffield == 1 then
			SettingModule.UrpToggle.Depthoffield = 0
		elseif SettingModule.UrpToggle.Depthoffield == 0 then
			SettingModule.UrpToggle.Depthoffield = 1
		end

		self.CurToggle = SettingModule.UrpToggle.Depthoffield

		SettingModule.SetUrpSetting(Constant.PlayerPrefsConst.Depthoffield, SettingModule.UrpToggle.Depthoffield)

		Sendtype = 5
	elseif self.CurToggleName == Constant.PlayerPrefsConst.RoleInvertedImage then
		if SettingModule.UrpToggle.RoleInvertedImage == 1 then
			SettingModule.UrpToggle.RoleInvertedImage = 0
		elseif SettingModule.UrpToggle.RoleInvertedImage == 0 then
			SettingModule.UrpToggle.RoleInvertedImage = 1
		end

		self.CurToggle = SettingModule.UrpToggle.RoleInvertedImage

		SettingModule.SetUrpSetting(Constant.PlayerPrefsConst.RoleInvertedImage, SettingModule.UrpToggle.RoleInvertedImage)

		Sendtype = 6
	elseif self.CurToggleName == Constant.PlayerPrefsConst.LamplighNum then
		if SettingModule.UrpToggle.LamplighNum == 1 then
			SettingModule.UrpToggle.LamplighNum = 0
		elseif SettingModule.UrpToggle.LamplighNum == 0 then
			SettingModule.UrpToggle.LamplighNum = 1
		end

		self.CurToggle = SettingModule.UrpToggle.LamplighNum

		SettingModule.SetUrpSetting(Constant.PlayerPrefsConst.LamplighNum, SettingModule.UrpToggle.LamplighNum)

		Sendtype = 7
	elseif self.CurToggleName == Constant.PlayerPrefsConst.RoleNum then
		if SettingModule.UrpToggle.RoleNum == 1 then
			SettingModule.UrpToggle.RoleNum = 0
		elseif SettingModule.UrpToggle.RoleNum == 0 then
			SettingModule.UrpToggle.RoleNum = 1
		end

		self.CurToggle = SettingModule.UrpToggle.RoleNum

		SettingModule.SetUrpSetting(Constant.PlayerPrefsConst.RoleNum, SettingModule.UrpToggle.RoleNum)

		Sendtype = 8
	end

	self:RefreshToggle(Sendtype)
end

function UrpSettingView:RefreshToggle(typeSend)
	local ison = self.CurToggle == 1

	self:ToggleFunction(ison)

	if typeSend then
		GameEntry.LuaEvent:FireNow(nil, UrpSettingEventArgs():Fill(typeSend, ison, 0))
	end
end

function UrpSettingView:ToggleFunction(isOn)
	if isOn then
		self.Background:SetActive(true)
		self.Checkmark:SetActive(false)

		self.MarkBg.gameObject.transform.localPosition = Vector3.New(-56)
		self.Btn.gameObject.transform.localPosition = Vector3.New(56)
	else
		self.Background:SetActive(false)
		self.Checkmark:SetActive(true)

		self.MarkBg.gameObject.transform.localPosition = Vector3.New(56)
		self.Btn.gameObject.transform.localPosition = Vector3.New(-56)
	end
end

function UrpSettingView:AddEventListener()
	self.button.onClick:AddListener(self.OnClick_ToggleClick)
end

function UrpSettingView:RemoveEventListener()
	self.button.onClick:RemoveListener(self.OnClick_ToggleClick)
end

function UrpSettingView:OnDestroy()
	self:RemoveEventListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
	self.mainView = nil
end

return UrpSettingView
