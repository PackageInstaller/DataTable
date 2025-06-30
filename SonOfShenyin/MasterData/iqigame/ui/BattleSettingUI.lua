-- chunkname: @IQIGame\\UI\\BattleSettingUI.lua

local VolumeSliderElement = {}

function VolumeSliderElement.New(view, valueChangeEvent)
	local obj = Clone(VolumeSliderElement)

	obj:__Init(view, valueChangeEvent)

	return obj
end

function VolumeSliderElement:__Init(view, valueChangeEvent)
	self.gameObject = view
	self.valueChangeEvent = valueChangeEvent

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.volumeSlider = self.slider:GetComponent("Slider")

	self:__InitDelegateFunc()
	self:OnAddListeners()
end

function VolumeSliderElement:__InitDelegateFunc()
	function self.__delegateOnVolumeStateButtonClick()
		local value = self.volumeSlider.value

		if value >= 0.5 then
			self:__Refresh(value == 1 and 0 or 1, true)
		else
			self:__Refresh(0.5, true, true)
		end
	end

	function self.__delegateOnSliderValueChange(value)
		self:__Refresh(value, false, true)
	end
end

function VolumeSliderElement:OnAddListeners()
	self.volumeSlider.onValueChanged:AddListener(self.__delegateOnSliderValueChange)
	self.iconButton:GetComponent("Button").onClick:AddListener(self.__delegateOnVolumeStateButtonClick)
end

function VolumeSliderElement:OnRemoveListeners()
	self.volumeSlider.onValueChanged:RemoveListener(self.__delegateOnSliderValueChange)
	self.iconButton:GetComponent("Button").onClick:RemoveListener(self.__delegateOnVolumeStateButtonClick)
end

function VolumeSliderElement:OnShow(volume)
	self:__Refresh(volume, true, false)
end

function VolumeSliderElement:__Refresh(volume, updateSlider, valueChanged)
	if updateSlider then
		self.volumeSlider.value = volume
	end

	self.iconMax.gameObject:SetActive(volume > 0.5)
	self.iconMedium.gameObject:SetActive(volume > 0 and volume <= 0.5)
	self.iconMin.gameObject:SetActive(volume == 0)

	self.valueText:GetComponent("Text").text = math.floor(volume * 100)

	if valueChanged then
		self.valueChangeEvent(volume)
	end
end

function VolumeSliderElement:Dispose()
	self:OnRemoveListeners()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local BattleSettingUI = Base:Extend("BattleSettingUI", "IQIGame.Onigao.UI.BattleSettingUI", {})

function BattleSettingUI:OnInit()
	self.soundVolume = VolumeSliderElement.New(self.musucVolumeItem, function(value)
		SettingModule.SaveCurrentSoundVolume(value)
	end)
	self.musicVolume = VolumeSliderElement.New(self.soundeffectVolumeItem, function(value)
		SettingModule.SaveCurrentMusicVolume(value)
	end)
	self.cvVolume = VolumeSliderElement.New(self.cvVolumeItem, function(value)
		SettingModule.SaveCurrentCvVolume(value)
	end)
	self.secondConfirmToggleCom = self.secondConfirmToggle:GetComponent("Toggle")
	self.skillDetailToggleCom = self.skillDetailToggle:GetComponent("Toggle")
	self.cutinToggleToggleCom = self.cutinToggle:GetComponent("Toggle")
	self.fightSpeedToggleCom = self.speedToggle:GetComponent("Toggle")
	self.autoFightToggleCom = self.autoFightToggle:GetComponent("Toggle")

	self:__OnInitDelegateFunc()
end

function BattleSettingUI:GetPreloadAssetPaths()
	return nil
end

function BattleSettingUI:GetBGM(userData)
	return nil
end

function BattleSettingUI:IsManualShowOnOpen(userData)
	return false
end

function BattleSettingUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function BattleSettingUI:OnPause()
	return
end

function BattleSettingUI:OnResume()
	return
end

function BattleSettingUI:OnCover()
	return
end

function BattleSettingUI:OnReveal()
	return
end

function BattleSettingUI:OnRefocus(userData)
	return
end

function BattleSettingUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function BattleSettingUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function BattleSettingUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function BattleSettingUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function BattleSettingUI:OnAddListeners()
	self.secondConfirmToggleCom.onValueChanged:AddListener(self.delegateOnSecondConfirmToggleValueChange)
	self.skillDetailToggleCom.onValueChanged:AddListener(self.delegateOnSkillDetailToggleValueChange)
	self.cutinToggleToggleCom.onValueChanged:AddListener(self.delegateOnCutinToggleValueChange)
	self.fightSpeedToggleCom.onValueChanged:AddListener(self.delegateOnBattleSpeedToggleChange)
	self.autoFightToggleCom.onValueChanged:AddListener(self.delegateOnAutoBattleToggleChange)
	self.renewFightButton:GetComponent("Button").onClick:AddListener(self.delegateOnReFightBtnClick)
	self.continueFightButton:GetComponent("Button").onClick:AddListener(self.delegateOnContinueFightBtnClick)
	self.exitFightButton:GetComponent("Button").onClick:AddListener(self.delegateOnExitFightBtnClick)
end

function BattleSettingUI:OnRemoveListeners()
	self.secondConfirmToggleCom.onValueChanged:RemoveListener(self.delegateOnSecondConfirmToggleValueChange)
	self.skillDetailToggleCom.onValueChanged:RemoveListener(self.delegateOnSkillDetailToggleValueChange)
	self.cutinToggleToggleCom.onValueChanged:RemoveListener(self.delegateOnCutinToggleValueChange)
	self.fightSpeedToggleCom.onValueChanged:RemoveListener(self.delegateOnBattleSpeedToggleChange)
	self.autoFightToggleCom.onValueChanged:RemoveListener(self.delegateOnAutoBattleToggleChange)
	self.renewFightButton:GetComponent("Button").onClick:RemoveListener(self.delegateOnReFightBtnClick)
	self.continueFightButton:GetComponent("Button").onClick:RemoveListener(self.delegateOnContinueFightBtnClick)
	self.exitFightButton:GetComponent("Button").onClick:RemoveListener(self.delegateOnExitFightBtnClick)
end

function BattleSettingUI:OnOpen()
	self.exitFightButton.gameObject:SetActive(BattleModule.canManualExit)

	BattleTeamActionModule.isPaused = true

	self.soundVolume:OnShow(SettingModule.currentSoundVolume)
	self.musicVolume:OnShow(SettingModule.currentMusicVolume)
	self.cvVolume:OnShow(SettingModule.currentCvVolume)

	self.secondConfirmToggleCom.isOn = BattleTeamActionModule.skillNeedConfirm
	self.skillDetailToggleCom.isOn = BattleTeamActionModule.showSkillDetail
	self.cutinToggleToggleCom.isOn = BattleTeamActionModule.isCutinOn
	self.fightSpeedToggleCom.isOn = SettingModule.GetMaintainBattleSpeedSetting() == 1
	self.autoFightToggleCom.isOn = SettingModule.GetMaintainAutoBattleSetting() == 1
end

function BattleSettingUI:OnClose()
	BattleTeamActionModule.isPaused = false
end

function BattleSettingUI:OnDestroy()
	self.secondConfirmToggleCom = nil
	self.skillDetailToggleCom = nil
	self.cutinToggleToggleCom = nil
	self.fightSpeedToggleCom = nil
	self.autoFightToggleCom = nil

	self.soundVolume:Dispose()

	self.soundVolume = nil

	self.musicVolume:Dispose()

	self.musicVolume = nil

	self.cvVolume:Dispose()

	self.cvVolume = nil
end

function BattleSettingUI:__OnInitDelegateFunc()
	function self.delegateOnSecondConfirmToggleValueChange(isOn)
		BattleTeamActionModule.skillNeedConfirm = isOn
	end

	function self.delegateOnSkillDetailToggleValueChange(isOn)
		BattleTeamActionModule.showSkillDetail = isOn
	end

	function self.delegateOnCutinToggleValueChange(isOn)
		BattleTeamActionModule.isCutinOn = isOn
	end

	function self.delegateOnBattleSpeedToggleChange(isOn)
		SettingModule.SetMaintainBattleSpeedSetting(isOn and 1 or 0)
	end

	function self.delegateOnAutoBattleToggleChange(isOn)
		SettingModule.SetMaintainAutoBattleSetting(isOn and 1 or 0)
	end

	function self.delegateOnReFightBtnClick()
		BattleTeamActionModule.is_continue_fight = 3

		BattleModule.RequestRestartBattle()
		UIModule.Close(Constant.UIControllerName.BattleSettingUI)
	end

	function self.delegateOnContinueFightBtnClick()
		BattleTeamActionModule.is_continue_fight = 2

		UIModule.Close(Constant.UIControllerName.BattleSettingUI)
	end

	function self.delegateOnExitFightBtnClick()
		BattleTeamActionModule.is_continue_fight = 1

		UIModule.Close(Constant.UIControllerName.BattleSettingUI)
		NoticeModule.ShowNoticeByType(5, BattleApi:GetCfgText(6050002), function()
			EventDispatcher.Dispatch(EventID.QuitBattle)
		end)
	end
end

return BattleSettingUI
