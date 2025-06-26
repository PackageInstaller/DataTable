-- chunkname: @IQIGame\\UI\\Setting\\SettingMusicView.lua

local SettingMusicView = {}

function SettingMusicView.__New(ui)
	local o = Clone(SettingMusicView)

	o:InitView(ui)

	return o
end

function SettingMusicView:InitView(ui)
	self.rootUI = ui

	self.rootUI:SetActive(false)
	LuaCodeInterface.BindOutlet(self.rootUI, self)

	self.TextTitle1:GetComponent("Text").text = SettingUIApi:GetString("TextTitle7")
	self.TextTitle2:GetComponent("Text").text = SettingUIApi:GetString("TextTitle8")
	self.TextTitle3:GetComponent("Text").text = SettingUIApi:GetString("TextTitle9")

	UGUIUtil.SetText(self.TextMusicTitle, SettingUIApi:GetString("TextMusicTitle"))

	self.processCVComponent = self.ProcessCV:GetComponent("Slider")
	self.processSoundComponent = self.ProcessSound:GetComponent("Slider")
	self.processMusicComponent = self.ProcessMusic:GetComponent("Slider")

	function self.delegateCVSliderValue(value)
		self:OnCVSliderValueChange(value)
	end

	function self.delegateMusicSliderValue(value)
		self:OnMusicSliderValueChange(value)
	end

	function self.delegateSoundSliderValue(value)
		self:OnSoundSliderValueChange(value)
	end

	self:AddEventListener()
	self:UpDateView()
end

function SettingMusicView:OnMainUIOpen()
	return
end

function SettingMusicView:OnMainUIClose()
	self:Close()
end

function SettingMusicView:AddEventListener()
	self.processCVComponent.onValueChanged:AddListener(self.delegateCVSliderValue)
	self.processSoundComponent.onValueChanged:AddListener(self.delegateSoundSliderValue)
	self.processMusicComponent.onValueChanged:AddListener(self.delegateMusicSliderValue)
end

function SettingMusicView:RemoveEventListener()
	self.processCVComponent.onValueChanged:RemoveListener(self.delegateCVSliderValue)
	self.processSoundComponent.onValueChanged:RemoveListener(self.delegateSoundSliderValue)
	self.processMusicComponent.onValueChanged:RemoveListener(self.delegateMusicSliderValue)
end

function SettingMusicView:UpDateView()
	self.processCVComponent.value = SettingModule.currentCvVolume

	UGUIUtil.SetText(self.TextCV, tostring(math.floor(SettingModule.currentCvVolume * 100)))

	self.processMusicComponent.value = SettingModule.currentMusicVolume

	UGUIUtil.SetText(self.TextMusic, tostring(math.floor(SettingModule.currentMusicVolume * 100)))

	self.processSoundComponent.value = SettingModule.currentSoundVolume

	UGUIUtil.SetText(self.TextSound, tostring(math.floor(SettingModule.currentSoundVolume * 100)))
end

function SettingMusicView:OnCVSliderValueChange(value)
	SettingModule.SaveCurrentCvVolume(value)
	UGUIUtil.SetText(self.TextCV, tostring(math.floor(SettingModule.currentCvVolume * 100)))
end

function SettingMusicView:OnMusicSliderValueChange(value)
	SettingModule.SaveCurrentMusicVolume(value)
	UGUIUtil.SetText(self.TextMusic, tostring(math.floor(SettingModule.currentMusicVolume * 100)))
end

function SettingMusicView:OnSoundSliderValueChange(value)
	SettingModule.SaveCurrentSoundVolume(value)
	UGUIUtil.SetText(self.TextSound, tostring(math.floor(SettingModule.currentSoundVolume * 100)))
end

function SettingMusicView:Dispose()
	self:Close()
	self:RemoveEventListener()
	LuaCodeInterface.ClearOutlet(self.rootUI, self)

	self.rootUI = nil
end

function SettingMusicView:Open()
	self.rootUI:SetActive(true)
end

function SettingMusicView:Close()
	self.rootUI:SetActive(false)
end

return SettingMusicView
