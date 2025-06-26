-- chunkname: @IQIGame\\Module\\Setting\\SettingModule.lua

SettingModule = {
	currentSoundVolume = 1,
	currentCvVolume = 1,
	targetFrameRate = 60,
	AllAudioVolume = 1,
	currentMusicVolume = 1,
	messageMainSwitch = 0,
	PersonalActive = 0,
	PowerSavingModule = 1,
	ultimateAnimationState = 1,
	pushMessage = {},
	musicGroup = {
		"ENVIRONMENT",
		"UI",
		"FootStep"
	},
	soundGroup = {
		"BGM"
	},
	cvGroup = {
		"CHARACTER",
		"Dub"
	},
	UrpToggle = {
		LamplighNum = 0,
		Bloom = 0,
		Opaquedownsampling = 0,
		SSAO = 0,
		RoleNum = 0,
		PostProcessing = 0,
		GradingModeValue = 0,
		MASS = 0,
		Scattering = 0,
		RoleInvertedImage = 0,
		GradingMode = 0,
		Depthoffield = 0,
		WaterEffect = 0
	},
	FpsEnum = {
		_60FPS = 60,
		UnlimitedFPS = -1,
		_30FPS = 30
	},
	UrpEnum = {
		High = 3,
		Medium = 2,
		Low = 1,
		Fastest = 0
	}
}
SettingModule.SettingReportData = {}

function SettingModule.SetUrpSetting(toggleType, toggleState)
	PlayerPrefsUtil.SetString("", toggleType, tostring(toggleState))
end

function SettingModule.GetUrpSetting()
	local urpAsset = UGUIUtil.GetMainUniversalRenderPipelineAsset()
	local value = tonumber(PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.Opaquedownsampling))

	if value ~= nil then
		SettingModule.UrpToggle.Opaquedownsampling = value
		urpAsset.supportsCameraOpaqueTexture = SettingModule.UrpToggle.Opaquedownsampling == 1
	else
		SettingModule.UrpToggle.Opaquedownsampling = urpAsset.supportsCameraOpaqueTexture == true and 1 or 0
	end

	local value = tonumber(PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.MASS))

	if value ~= nil then
		SettingModule.UrpToggle.MASS = value
		urpAsset.msaaSampleCount = value
	else
		SettingModule.UrpToggle.MASS = urpAsset.msaaSampleCount
	end

	local value = tonumber(PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.GradingMode))

	if value ~= nil then
		SettingModule.UrpToggle.GradingMode = value
		urpAsset.colorGradingMode = value == 0 and ColorGradingMode.LowDynamicRange or ColorGradingMode.HighDynamicRange
	else
		SettingModule.UrpToggle.GradingMode = urpAsset.colorGradingMode == ColorGradingMode.LowDynamicRange and 0 or 1
	end

	local value = tonumber(PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.GradingModeValue))

	if value ~= nil then
		SettingModule.UrpToggle.GradingModeValue = value
		urpAsset.colorGradingLutSize = value
	else
		SettingModule.UrpToggle.GradingModeValue = urpAsset.colorGradingLutSize
	end

	local value = tonumber(PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.SSAO))

	if value ~= nil then
		SettingModule.UrpToggle.SSAO = value
	end

	local value = tonumber(PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.WaterEffect))

	if value ~= nil then
		SettingModule.UrpToggle.WaterEffect = value
		UGUIUtil._SettingData.b_WaterEffect = value == 1 and true or false
	end

	local value = tonumber(PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.Scattering))

	if value ~= nil then
		SettingModule.UrpToggle.Scattering = value
		UGUIUtil._SettingData.b_Scattering = value == 1 and true or false
	end

	local value = tonumber(PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.PostProcessing))

	if value ~= nil then
		SettingModule.UrpToggle.PostProcessing = value
		UGUIUtil._SettingData.b_PostProcessingParentObj = value == 1 and true or false
	end

	local value = tonumber(PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.Bloom))

	if value ~= nil then
		SettingModule.UrpToggle.Bloom = value
		UGUIUtil._SettingData.b_BloomsList = value == 1 and true or false
	end

	local value = tonumber(PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.Depthoffield))

	if value ~= nil then
		SettingModule.UrpToggle.Depthoffield = value
		UGUIUtil._SettingData.b__DepthOfFieldsList = value == 1 and true or false
	end

	local value = tonumber(PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.RoleInvertedImage))

	if value ~= nil then
		SettingModule.UrpToggle.RoleInvertedImage = value
		UGUIUtil._SettingData.b_RoleInvertedImage = value == 1 and true or false
	end
end

function SettingModule.DefaultSetting()
	local cvVolume = tonumber(PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.UserCvVolume, 1))

	if cvVolume ~= nil then
		SettingModule.currentCvVolume = cvVolume
	end

	local musicVolume = tonumber(PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.UserMusicVolume, 1))

	if musicVolume ~= nil then
		SettingModule.currentMusicVolume = musicVolume
	end

	local soundVolume = tonumber(PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.UserSoundVolume, 1))

	if soundVolume ~= nil then
		SettingModule.currentSoundVolume = soundVolume
	end

	local AllAudioVolume = tonumber(PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.UserAllAudioVolume, 1))

	if AllAudioVolume ~= nil then
		SettingModule.AllAudioVolume = AllAudioVolume
	end

	local ultimateAnimationState = PlayerPrefsUtil.GetInt("", Constant.PlayerPrefsConst.UserSettingUltimateAnimationSate)

	if ultimateAnimationState > 0 then
		SettingModule.ultimateAnimationState = ultimateAnimationState
	end

	SettingModule.messageMainSwitch = PlayerPrefsUtil.GetInt("", Constant.PlayerPrefsConst.UserSettingMessageMainSwitch)
	SettingModule.pushMessage = PlayerPrefsUtil.GetLuaTable("", Constant.PlayerPrefsConst.UserSettingMessageChildSwitch)

	if SettingModule.pushMessage == nil then
		SettingModule.pushMessage = {}
	end

	local PowerSavingSateState = PlayerPrefsUtil.GetInt("", Constant.PlayerPrefsConst.PowerSavingSate)

	if PowerSavingSateState then
		SettingModule.PowerSavingModule = PowerSavingSateState
	end

	local PersonalActiveState = PlayerPrefsUtil.GetInt("", Constant.PlayerPrefsConst.PersonalActive)

	if PersonalActiveState then
		SettingModule.PersonalActive = PersonalActiveState
	end

	SettingModule.SetCVGroupValue()
	SettingModule.SetMusicGroupValue()
	SettingModule.SetSoundGroupValue()
	SettingModule.SetAllAudioGroupValue()
	SettingModule.SetFrameRate(SettingModule.LoadTargetFrameRate())
	SettingModule.SetUrpSettingNew(SettingModule.LoadUrpLevel())
end

function SettingModule.SetAllAudioGroupValue()
	SettingModule.SetCVGroupValue()
	SettingModule.SetMusicGroupValue()
	SettingModule.SetSoundGroupValue()
end

function SettingModule.SetCVGroupValue()
	for _, v in pairsCfg(SettingModule.cvGroup) do
		GameEntry.Sound:SetGroupVolume(v, SettingModule.currentCvVolume * SettingModule.AllAudioVolume)
	end

	EventDispatcher.Dispatch(EventID.SoundVolumeChange_CVGroup, SettingModule.currentCvVolume * SettingModule.AllAudioVolume)
end

function SettingModule.SetMusicGroupValue()
	for _, v in pairsCfg(SettingModule.musicGroup) do
		GameEntry.Sound:SetGroupVolume(v, SettingModule.currentMusicVolume * SettingModule.AllAudioVolume)
	end

	EventDispatcher.Dispatch(EventID.SoundVolumeChange_MusicGroup, SettingModule.currentMusicVolume * SettingModule.AllAudioVolume)
end

function SettingModule.SetSoundGroupValue()
	for _, v in pairsCfg(SettingModule.soundGroup) do
		GameEntry.Sound:SetGroupVolume(v, SettingModule.currentSoundVolume * SettingModule.AllAudioVolume)
	end

	EventDispatcher.Dispatch(EventID.SoundVolumeChange_BGMGroup, SettingModule.currentSoundVolume * SettingModule.AllAudioVolume)
end

function SettingModule.SaveCurrentCvVolume(value)
	SettingModule.currentCvVolume = value

	if SettingModule.currentCvVolume < 0 then
		SettingModule.currentCvVolume = 0
	end

	if SettingModule.currentCvVolume > 1 then
		SettingModule.currentCvVolume = 1
	end

	PlayerPrefsUtil.SetString("", Constant.PlayerPrefsConst.UserCvVolume, tostring(SettingModule.currentCvVolume))
	SettingModule.SetCVGroupValue()
end

function SettingModule.SaveCurrentAllAudioVolume(value)
	SettingModule.AllAudioVolume = value

	if SettingModule.AllAudioVolume < 0 then
		SettingModule.AllAudioVolume = 0
	end

	if SettingModule.AllAudioVolume > 1 then
		SettingModule.AllAudioVolume = 1
	end

	PlayerPrefsUtil.SetString("", Constant.PlayerPrefsConst.UserAllAudioVolume, tostring(SettingModule.AllAudioVolume))
	SettingModule.SetAllAudioGroupValue()
end

function SettingModule.SaveCurrentMusicVolume(value)
	SettingModule.currentMusicVolume = value

	if SettingModule.currentMusicVolume < 0 then
		SettingModule.currentMusicVolume = 0
	end

	if SettingModule.currentMusicVolume > 1 then
		SettingModule.currentMusicVolume = 1
	end

	PlayerPrefsUtil.SetString("", Constant.PlayerPrefsConst.UserMusicVolume, tostring(SettingModule.currentMusicVolume))
	SettingModule.SetMusicGroupValue()
end

function SettingModule.SaveCurrentSoundVolume(value)
	SettingModule.currentSoundVolume = value

	if SettingModule.currentSoundVolume < 0 then
		SettingModule.currentSoundVolume = 0
	end

	if SettingModule.currentSoundVolume > 1 then
		SettingModule.currentSoundVolume = 1
	end

	PlayerPrefsUtil.SetString("", Constant.PlayerPrefsConst.UserSoundVolume, tostring(SettingModule.currentSoundVolume))
	SettingModule.SetSoundGroupValue()
end

function SettingModule.SavePowerSavingState(value)
	SettingModule.PowerSavingModule = value

	PlayerPrefsUtil.SetInt("", Constant.PlayerPrefsConst.PowerSavingSate, SettingModule.PowerSavingModule)
end

function SettingModule.SavePersonalActiveState(value)
	SettingModule.PersonalActive = value

	PlayerPrefsUtil.SetInt("", Constant.PlayerPrefsConst.PersonalActive, SettingModule.PersonalActive)
end

function SettingModule.SaveUltimateAnimationState(value)
	SettingModule.ultimateAnimationState = value

	PlayerPrefsUtil.SetInt("", Constant.PlayerPrefsConst.UserSettingUltimateAnimationSate, SettingModule.ultimateAnimationState)
end

function SettingModule.SaveMessageMainSwitch(value)
	SettingModule.messageMainSwitch = value

	PlayerPrefsUtil.SetInt("", Constant.PlayerPrefsConst.UserSettingMessageMainSwitch, SettingModule.messageMainSwitch)
end

function SettingModule.SaveMessageChildSwitch(cid, value)
	SettingModule.pushMessage[tostring(cid)] = value

	PlayerPrefsUtil.SetLuaTable("", Constant.PlayerPrefsConst.UserSettingMessageChildSwitch, SettingModule.pushMessage)

	if SettingModule.messageMainSwitch == 0 then
		-- block empty
	end
end

function SettingModule.GetMessageChildSwitch(cid)
	local value = SettingModule.pushMessage[tostring(cid)]

	if value == nil then
		value = 0
	end

	return value
end

function SettingModule.SortEvent(tb1, tb2)
	local r = false
	local aIsLock = tb1.isLock == true and 1 or 0
	local bIsLock = tb2.isLock == true and 1 or 0

	if aIsLock == bIsLock then
		r = tb1.cfgInfo.Sort < tb2.cfgInfo.Sort
	else
		r = bIsLock < aIsLock
	end

	return r
end

function SettingModule.SendGiftCodeResult(items)
	NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, items)
end

function SettingModule.GetEquipSkinTogetherSetting()
	return PlayerPrefsUtil.GetInt(PlayerModule.GetPlayerPid(), Constant.PlayerPrefsConst.EquipSkinTogetherSwitch, 0)
end

function SettingModule.SetEquipSkinTogetherSetting(state)
	log("皮肤系统 - 设置配套更换皮肤开关状态为 {0}", state == 0 and "关闭" or "开启")
	PlayerPrefsUtil.SetInt(PlayerModule.GetPlayerPid(), Constant.PlayerPrefsConst.EquipSkinTogetherSwitch, state)
end

function SettingModule.GetHadConfirmEquipSkinModeSetting()
	return PlayerPrefsUtil.GetInt(PlayerModule.GetPlayerPid(), Constant.PlayerPrefsConst.HadConfirmEquipSkinMode, 0) == 1
end

function SettingModule.SetHadConfirmEquipSkinModeSetting()
	PlayerPrefsUtil.SetInt(PlayerModule.GetPlayerPid(), Constant.PlayerPrefsConst.HadConfirmEquipSkinMode, 1)
	log("皮肤系统 - 设置 确认装备皮肤方式标记")
end

function SettingModule.LoadBattleSpeedIndex()
	return PlayerPrefsUtil.GetInt(PlayerModule.GetPlayerPid(), Constant.PlayerPrefsConst.BattleSpeed, 1)
end

function SettingModule.SaveBattleSpeedListIndex(index)
	PlayerPrefsUtil.SetInt(PlayerModule.GetPlayerPid(), Constant.PlayerPrefsConst.BattleSpeed, index)
end

function SettingModule.MaintainBattleSpeed()
	return SettingModule.GetMaintainBattleSpeedSetting() == 1
end

function SettingModule.GetMaintainBattleSpeedSetting()
	return PlayerPrefsUtil.GetInt(PlayerModule.GetPlayerPid(), Constant.PlayerPrefsConst.MaintainBattleSpeedSwitch, 1)
end

function SettingModule.SetMaintainBattleSpeedSetting(state)
	log("战斗系统 - 设置维持战斗倍速开关状态为 {0}", state == 0 and "关闭" or "开启")
	PlayerPrefsUtil.SetInt(PlayerModule.GetPlayerPid(), Constant.PlayerPrefsConst.MaintainBattleSpeedSwitch, state)
end

function SettingModule.LoadAutoBattle()
	local autoBattle = PlayerPrefsUtil.GetInt(PlayerModule.GetPlayerPid(), Constant.PlayerPrefsConst.AutoBattle, 0)

	return autoBattle == 1
end

function SettingModule.SaveAutoBattle(isAuto)
	local autoBattle = isAuto == true and 1 or 0

	PlayerPrefsUtil.SetInt(PlayerModule.GetPlayerPid(), Constant.PlayerPrefsConst.AutoBattle, autoBattle)
end

function SettingModule.MaintainAutoBattle()
	return SettingModule.GetMaintainAutoBattleSetting() == 1
end

function SettingModule.GetMaintainAutoBattleSetting()
	return PlayerPrefsUtil.GetInt(PlayerModule.GetPlayerPid(), Constant.PlayerPrefsConst.MaintainAutoBattleSwitch, 1)
end

function SettingModule.SetMaintainAutoBattleSetting(state)
	log("战斗系统 - 设置保留自动战斗开关状态为 {0}", state == 0 and "关闭" or "开启")
	PlayerPrefsUtil.SetInt(PlayerModule.GetPlayerPid(), Constant.PlayerPrefsConst.MaintainAutoBattleSwitch, state)
end

function SettingModule.GetFpsSettingDesc()
	return {
		[SettingModule.FpsEnum.UnlimitedFPS] = "无限制",
		[SettingModule.FpsEnum._30FPS] = "30fps",
		[SettingModule.FpsEnum._60FPS] = "60fps"
	}
end

function SettingModule.LoadTargetFrameRate()
	return PlayerPrefsUtil.GetInt("", Constant.PlayerPrefsConst.TargetFrameRate, UnityEngine.Application.targetFrameRate)
end

function SettingModule.SaveTargetFrameRate(fps)
	log("帧率设置 - 设置帧率设置开关状态为 {0}", SettingModule.GetFpsSettingDesc()[fps])
	PlayerPrefsUtil.SetInt("", Constant.PlayerPrefsConst.TargetFrameRate, fps)
	SettingModule.SetFrameRate(fps)
end

function SettingModule.SetFrameRate(fps)
	UnityEngine.Application.targetFrameRate = fps
	UnityEngine.QualitySettings.vSyncCount = 0
end

SettingModule.UrpLevel2AssetPath = {
	[SettingModule.UrpEnum.Fastest] = "Assets/22_Render/URP/SYZZ URP_Low.asset",
	[SettingModule.UrpEnum.Low] = "Assets/22_Render/URP/SYZZ URP_Low.asset",
	[SettingModule.UrpEnum.Medium] = "Assets/22_Render/URP/SYZZ URP_Good.asset",
	[SettingModule.UrpEnum.High] = "Assets/22_Render/URP/SYZZ URP.asset"
}
SettingModule.UrpLevelDesc = {
	[SettingModule.UrpEnum.Fastest] = "极低",
	[SettingModule.UrpEnum.Low] = "低",
	[SettingModule.UrpEnum.Medium] = "中",
	[SettingModule.UrpEnum.High] = "高"
}

function SettingModule.LoadUrpLevel()
	return PlayerPrefsUtil.GetInt("", Constant.PlayerPrefsConst.UrpLevel, SettingModule.UrpEnum.Medium)
end

function SettingModule.SaveUrpSetting(urpLevel)
	log("URP级别 - 设置开关状态为 {0}", SettingModule.UrpLevelDesc[urpLevel])
	PlayerPrefsUtil.SetInt("", Constant.PlayerPrefsConst.UrpLevel, urpLevel)
	SettingModule.SetUrpSettingNew(urpLevel)
end

function SettingModule.SetUrpSettingNew(urpLevel)
	CoroutineUtility.StartCoroutine(function()
		GameEntry.RenderingComponent:ApplyLOD(urpLevel)
	end)
end

function SettingModule.SaveFormationNewHeroTag(value)
	PlayerPrefsUtil.SetString(PlayerModule.GetPlayerPid(), Constant.PlayerPrefsConst.FormationHeroFirstRecord, value)
	PlayerPrefsUtil.Save()
end

function SettingModule.GetFormationNewHeroTag()
	return PlayerPrefsUtil.GetString(PlayerModule.GetPlayerPid(), Constant.PlayerPrefsConst.FormationHeroFirstRecord)
end

function SettingModule.SaveBattleUnitAITypeRecordData(value)
	PlayerPrefsUtil.SetString(PlayerModule.GetPlayerPid(), Constant.PlayerPrefsConst.BattleUnitAITypeRecord, value)
end

function SettingModule.GetBattleUnitAITypeRecordData()
	return PlayerPrefsUtil.GetString(PlayerModule.GetPlayerPid(), Constant.PlayerPrefsConst.BattleUnitAITypeRecord)
end

function SettingModule.SaveHeroNewTagRecordData(value)
	PlayerPrefsUtil.SetString(PlayerModule.GetPlayerPid(), Constant.PlayerPrefsConst.HeroNewTagRecord, value)
	PlayerPrefsUtil.Save()
end

function SettingModule.GetHeroNewTagRecordData()
	return PlayerPrefsUtil.GetString(PlayerModule.GetPlayerPid(), Constant.PlayerPrefsConst.HeroNewTagRecord)
end

function SettingModule.GetRoleDisplayRandomState()
	local isOn = PlayerPrefsUtil.GetInt(PlayerModule.GetPlayerPid(), Constant.PlayerPrefsConst.RoleDisplayRandomState, 1)

	return isOn == 1
end

function SettingModule.SetRoleDisplayRandomState(isOn)
	PlayerPrefsUtil.SetInt(PlayerModule.GetPlayerPid(), Constant.PlayerPrefsConst.RoleDisplayRandomState, isOn)
	PlayerPrefsUtil.Save()
end

function SettingModule.GetSoundGroupTypeSwitch(groupType)
	local selectIndex = 1

	if groupType == Constant.SoundGroupType.Story then
		selectIndex = PlayerPrefsUtil.GetInt("SoundGroupType", Constant.PlayerPrefsConst.OpenStorySecondSound, 2)
	elseif groupType == Constant.SoundGroupType.Battle then
		selectIndex = PlayerPrefsUtil.GetInt("SoundGroupType", Constant.PlayerPrefsConst.OpenSecondSound, 2)
	end

	return selectIndex
end

function SettingModule.SetSoundGroupTypeSwitch(groupType, selectIndex)
	if groupType == Constant.SoundGroupType.Story then
		PlayerPrefsUtil.SetInt("SoundGroupType", Constant.PlayerPrefsConst.OpenStorySecondSound, selectIndex)
	elseif groupType == Constant.SoundGroupType.Battle then
		PlayerPrefsUtil.SetInt("SoundGroupType", Constant.PlayerPrefsConst.OpenSecondSound, selectIndex)
	end

	EventDispatcher.Dispatch(EventID.NotifySoundGroupTypeChange, groupType)
end
