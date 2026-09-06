-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/hardwarequality/HardwareQuality.lua

module(..., package.seeall)

local HardwareQuality = {}

HardwareQuality.isNewVersion = true
HardwareQuality.isSupportFrameRate60 = false
HardwareQuality.HighFrameRate = 90
HardwareQuality.UltraFrameRate = 120
HardwareQuality.QualityLevelType = {
	High = 3,
	Medium = 2,
	Low = 1,
	Custom = 4
}
HardwareQuality.FrameRateLevelType = {
	Low = {
		1,
		30
	},
	Medium = {
		2,
		60
	},
	High = {
		3,
		HardwareQuality.HighFrameRate
	},
	Ultra = {
		4,
		HardwareQuality.UltraFrameRate
	}
}
HardwareQuality.ResolutionLevelType = {
	High = 0,
	Medium = 1080,
	Low = 720
}
HardwareQuality.AntiLevelType = {
	Close = 0,
	Open = 2
}
HardwareQuality.OutlineLevelType = {
	Close = false,
	Open = true
}
HardwareQuality.DynamicResolutionLevelType = {
	Close = false,
	Open = true
}
HardwareQuality.GlowLevelType = {
	Close = false,
	Open = true
}
HardwareQuality.UiMaskLayer = {
	Story = 2,
	UIRoot = 1
}
HardwareQuality.MaxPlayerNum = 25

local RESOLUTION_KEY = "PJAQM_RESOLUTION_KEY_FOR_LOCAL_STORAGE"
local FRAME_RATE_KEY = "PJAQM_FRAME_RATE_KEY_FOR_LOCAL_STORAGE"
local MAX_PLAYERS_KEY = "PJAQM_MAX_PLAYERS_KEY_FOR_LOCAL_STORAGE"
local SHOW_SCENE_EFFECTS_KEY = "PJAQM_SHOW_SCENE_EFFECTS_KEY"
local ANTIALIASING_KEY = "PJAQM_ANTIALIASING_KEY_LOCAL_STORAGE"
local OUTLINE_KEY = "PJAQM_OUTLINE_KEY_LOCAL_STORAGE"
local BLOOM_KEY = "PJAQM_BLOOM_KEY_LOCAL_STORAGE"
local DYNAMICRESOLUTION_KEY = "PJAQM_DYNAMICRESOLUTION_KEY_LOCAL_STORAGE"
local FRAME_RATE_TYPE_KEY = "PJAQM_FRAME_RATE_TYPE_KEY_FOR_LOCAL_STORAGE"
local DEVICE_RECOMMEND_APPLIED_VERSION_KEY = "PJAQM_DEVICE_RECOMMEND_APPLIED_VERSION"
local DEVICE_RECOMMEND_VERSION = 1

HardwareQuality.LOW = nil
HardwareQuality.MEDIUM = nil
HardwareQuality.HIGH = nil
HardwareQuality.CUSTOM = nil
HardwareQuality.currentQuality = nil
HardwareQuality._runtimeQualityStack = nil

function HardwareQuality.init()
	HardwareQuality.LOW = QualitySetting.New()
	HardwareQuality.LOW.name = "low"
	HardwareQuality.LOW.qualityLevel = HardwareQuality.QualityLevelType.Low
	HardwareQuality.LOW.resolution = 720
	HardwareQuality.LOW.vSyncCount = 0
	HardwareQuality.LOW.antiAliasing = 0
	HardwareQuality.LOW.characterShadowQuality = HardwareQuality.QualityLevelType.Low
	HardwareQuality.LOW.characterMaterialQuality = HardwareQuality.QualityLevelType.Low
	HardwareQuality.LOW.shaderQuality = HardwareQuality.QualityLevelType.Low
	HardwareQuality.LOW.textureQuality = HardwareQuality.QualityLevelType.Low
	HardwareQuality.LOW.showPostProcessingEffects = false
	HardwareQuality.LOW.maxPlayers = 5
	HardwareQuality.LOW.effectQuality = HardwareQuality.QualityLevelType.Low
	HardwareQuality.LOW.sceneQuality = HardwareQuality.QualityLevelType.Low
	HardwareQuality.LOW.bloomSwitch = false
	HardwareQuality.LOW.outlineSwitch = false
	HardwareQuality.LOW.frameRateType = HardwareQuality.FrameRateLevelType.Low[1]
	HardwareQuality.LOW.frameRate = HardwareQuality.FrameRateLevelType.Low[2]
	HardwareQuality.LOW.dynamicResolution = false
	HardwareQuality.MEDIUM = QualitySetting.New()
	HardwareQuality.MEDIUM.name = "medium"
	HardwareQuality.MEDIUM.qualityLevel = HardwareQuality.QualityLevelType.Medium
	HardwareQuality.MEDIUM.resolution = 1080
	HardwareQuality.MEDIUM.vSyncCount = 0
	HardwareQuality.MEDIUM.antiAliasing = 0
	HardwareQuality.MEDIUM.characterShadowQuality = HardwareQuality.QualityLevelType.Medium
	HardwareQuality.MEDIUM.characterMaterialQuality = HardwareQuality.QualityLevelType.Medium
	HardwareQuality.MEDIUM.shaderQuality = HardwareQuality.QualityLevelType.Medium
	HardwareQuality.MEDIUM.textureQuality = HardwareQuality.QualityLevelType.Medium
	HardwareQuality.MEDIUM.showPostProcessingEffects = true
	HardwareQuality.MEDIUM.maxPlayers = 12
	HardwareQuality.MEDIUM.effectQuality = HardwareQuality.QualityLevelType.Medium
	HardwareQuality.MEDIUM.sceneQuality = HardwareQuality.QualityLevelType.Medium
	HardwareQuality.MEDIUM.bloomSwitch = false
	HardwareQuality.MEDIUM.outlineSwitch = false
	HardwareQuality.MEDIUM.frameRateType = HardwareQuality.FrameRateLevelType.Medium[1]
	HardwareQuality.MEDIUM.frameRate = HardwareQuality.FrameRateLevelType.Medium[2]
	HardwareQuality.MEDIUM.dynamicResolution = false
	HardwareQuality.HIGH = QualitySetting.New()
	HardwareQuality.HIGH.name = "high"
	HardwareQuality.HIGH.qualityLevel = HardwareQuality.QualityLevelType.High
	HardwareQuality.HIGH.resolution = 0
	HardwareQuality.HIGH.vSyncCount = 0
	HardwareQuality.HIGH.antiAliasing = 0
	HardwareQuality.HIGH.characterShadowQuality = HardwareQuality.QualityLevelType.High
	HardwareQuality.HIGH.characterMaterialQuality = HardwareQuality.QualityLevelType.High
	HardwareQuality.HIGH.shaderQuality = HardwareQuality.QualityLevelType.High
	HardwareQuality.HIGH.textureQuality = HardwareQuality.QualityLevelType.High
	HardwareQuality.HIGH.showPostProcessingEffects = true
	HardwareQuality.HIGH.maxPlayers = 18
	HardwareQuality.HIGH.effectQuality = HardwareQuality.QualityLevelType.High
	HardwareQuality.HIGH.sceneQuality = HardwareQuality.QualityLevelType.High
	HardwareQuality.HIGH.bloomSwitch = false
	HardwareQuality.HIGH.outlineSwitch = false
	HardwareQuality.HIGH.frameRateType = HardwareQuality.FrameRateLevelType.Ultra[1]
	HardwareQuality.HIGH.frameRate = HardwareQuality.FrameRateLevelType.Ultra[2]
	HardwareQuality.HIGH.dynamicResolution = false

	Framework.LodUtil.Instance:SetBloomSwitch(false)

	HardwareQuality.CUSTOM = QualitySetting.New()
	HardwareQuality.CUSTOM.name = "custom"
	HardwareQuality.CUSTOM.qualityLevel = HardwareQuality.QualityLevelType.Custom
	HardwareQuality.CUSTOM.vSyncCount = 0
	HardwareQuality.CUSTOM.antiAliasing = 0
	HardwareQuality.CUSTOM.characterShadowQuality = HardwareQuality.QualityLevelType.High
	HardwareQuality.CUSTOM.characterMaterialQuality = HardwareQuality.QualityLevelType.High
	HardwareQuality.CUSTOM.shaderQuality = HardwareQuality.QualityLevelType.High
	HardwareQuality.CUSTOM.textureQuality = HardwareQuality.QualityLevelType.High
	HardwareQuality.CUSTOM.effectQuality = HardwareQuality.QualityLevelType.High
	HardwareQuality.CUSTOM.showPostProcessingEffects = false
	HardwareQuality.CUSTOM.resolution = HardwareQuality.ResolutionLevelType.High
	HardwareQuality.CUSTOM.sceneQuality = HardwareQuality.QualityLevelType.High
	HardwareQuality.CUSTOM.bloomSwitch = false
	HardwareQuality.CUSTOM.outlineSwitch = false
	HardwareQuality.CUSTOM.frameRateType = HardwareQuality.FrameRateLevelType.Ultra[1]
	HardwareQuality.CUSTOM.frameRate = HardwareQuality.FrameRateLevelType.Ultra[2]
	HardwareQuality.CUSTOM.dynamicResolution = false
	HardwareQuality.CUSTOM.maxPlayers = Framework.LocalStorage.Instance:GetInt(MAX_PLAYERS_KEY, 6)
	HardwareQuality.currentQuality = QualitySetting.New()
	HardwareQuality._runtimeQualityStack = {}

	HardwareQuality._loadUserSettingsToCustom()
	HardwareQuality.setCurrentQuality(HardwareQuality.CUSTOM)
	HardwareQuality._adaptLRSide()
end

function HardwareQuality.initAndRestoreByUserSettings()
	HardwareQuality.init()
	HardwareQuality.applyDeviceRecommendOnce()
	HardwareQuality._applyStartupQualitySettings()
end

function HardwareQuality.setCurrentQuality(quality)
	HardwareQuality.currentQuality:clone(quality)
end

function HardwareQuality._getRuntimeLodLevel()
	local sceneQuality = HardwareQuality.currentQuality.sceneQuality

	if sceneQuality == HardwareQuality.QualityLevelType.Low or sceneQuality == HardwareQuality.QualityLevelType.Medium or sceneQuality == HardwareQuality.QualityLevelType.High then
		return sceneQuality
	end

	return HardwareQuality.QualityLevelType.High
end

function HardwareQuality._applyStartupQualitySettings()
	local resolution = HardwareQuality.currentQuality.resolution

	if resolution > 0 then
		local screenWidth, screenHeight = SceneResolution.Instance:GetOriginalResolution(0, 0)
		local heightScale = resolution / screenHeight

		print("SetDirectResolution:" .. heightScale .. ", screenHeight = " .. screenHeight)

		if Framework.OSDef.RunOS ~= Framework.OSDef.IOS then
			SceneResolution.Instance:SetDirectResolution(heightScale)
		end
	else
		print("SetDirectResolution:" .. 1)

		if Framework.OSDef.RunOS ~= Framework.OSDef.IOS then
			SceneResolution.Instance:SetDirectResolution(1)
		end
	end

	UnityEngine.QualitySettings.vSyncCount = HardwareQuality.currentQuality.vSyncCount

	HardwareQuality.setAntiAliasing(0, false)
	Framework.LodUtil.Instance:SetQualityLevel(HardwareQuality._getRuntimeLodLevel())
	Framework.LodUtil.Instance:SetBloomSwitch(HardwareQuality.currentQuality.bloomSwitch)

	UnityEngine.Application.targetFrameRate = HardwareQuality.currentQuality.frameRate
end

function HardwareQuality.applySceneReadyQualitySettings()
	SceneFacade.instance:setQuality(HardwareQuality.currentQuality.sceneQuality)
	SceneFacade.instance:setMaxPlayers(HardwareQuality.currentQuality.maxPlayers)
	LightMgr.instance:operAllPostSwitch(HardwareQuality.currentQuality.bloomSwitch)
end

function HardwareQuality._applyCurrentQuality()
	Framework.LodUtil.Instance:SetQualityLevel(HardwareQuality._getRuntimeLodLevel())
	HardwareQuality.setResolution(HardwareQuality.currentQuality.resolution, false, true)
	SceneFacade.instance:setQuality(HardwareQuality.currentQuality.sceneQuality)
	Framework.LodUtil.Instance:SetBloomSwitch(HardwareQuality.currentQuality.bloomSwitch)
	LightMgr.instance:operAllPostSwitch(HardwareQuality.currentQuality.bloomSwitch)

	UnityEngine.Application.targetFrameRate = HardwareQuality.currentQuality.frameRate

	SceneFacade.instance:setMaxPlayers(HardwareQuality.currentQuality.maxPlayers)
	HardwareQuality.setAntiAliasing(0, false)

	HardwareQuality.currentQuality.outlineSwitch = false
	HardwareQuality.currentQuality.dynamicResolution = false

	ProfilerToolMgr.instance:removeAvgFpsTimer()
end

function HardwareQuality.setQualityLevelForAutoReduce(qualityLevel)
	HardwareQuality.setQualityLevel(qualityLevel)
end

function HardwareQuality.setQualityLevel(qualityLevel, customQuality)
	print("setQualityLevel:" .. qualityLevel, customQuality, debug.traceback())

	if qualityLevel == HardwareQuality.QualityLevelType.Custom then
		HardwareQuality.restoreUserQualitySettings()
	else
		HardwareQuality.applyRuntimeQualityPreset(qualityLevel)
	end
end

function HardwareQuality.applyRuntimeQualityPreset(qualityLevel)
	local quality

	if qualityLevel == HardwareQuality.QualityLevelType.Low then
		quality = HardwareQuality.LOW
	elseif qualityLevel == HardwareQuality.QualityLevelType.Medium then
		quality = HardwareQuality.MEDIUM
	elseif qualityLevel == HardwareQuality.QualityLevelType.High then
		quality = HardwareQuality.HIGH
	end

	if not quality then
		return
	end

	HardwareQuality.setCurrentQuality(quality)
	HardwareQuality._applyCurrentQuality()
end

function HardwareQuality.pushRuntimeQualityPreset(qualityLevel)
	HardwareQuality._runtimeQualityStack = HardwareQuality._runtimeQualityStack or {}

	local snapshot = QualitySetting.New()

	snapshot:clone(HardwareQuality.currentQuality)
	table.insert(HardwareQuality._runtimeQualityStack, snapshot)
	HardwareQuality.applyRuntimeQualityPreset(qualityLevel)
end

function HardwareQuality.popRuntimeQualityPreset()
	if not HardwareQuality._runtimeQualityStack or #HardwareQuality._runtimeQualityStack == 0 then
		HardwareQuality.restoreUserQualitySettings()

		return
	end

	local quality = table.remove(HardwareQuality._runtimeQualityStack)

	HardwareQuality.setCurrentQuality(quality)
	HardwareQuality._applyCurrentQuality()
end

function HardwareQuality.restoreUserQualitySettings()
	HardwareQuality._loadUserSettings()
	HardwareQuality.setCurrentQuality(HardwareQuality.CUSTOM)
	HardwareQuality._applyCurrentQuality()
end

function HardwareQuality.getQualityLevel()
	return HardwareQuality.currentQuality.qualityLevel or 1
end

function HardwareQuality.getRecommendQualityLevel()
	if HardwareQualityRecommend and HardwareQualityRecommend.instance then
		local tier = HardwareQualityRecommend.instance:getDeviceTier()

		if tier == HardwareQualityRecommend.Tier.Low then
			return HardwareQuality.QualityLevelType.Low
		elseif tier == HardwareQualityRecommend.Tier.Medium then
			return HardwareQuality.QualityLevelType.Medium
		elseif tier == HardwareQualityRecommend.Tier.High or tier == HardwareQualityRecommend.Tier.Ultra then
			return HardwareQuality.QualityLevelType.High
		end
	end

	local autoQuality = HardwareQuality._autoComputeQuality()

	if autoQuality == HardwareQuality.LOW then
		return HardwareQuality.QualityLevelType.Low
	elseif autoQuality == HardwareQuality.MEDIUM then
		return HardwareQuality.QualityLevelType.Medium
	elseif autoQuality == HardwareQuality.HIGH then
		return HardwareQuality.QualityLevelType.High
	else
		return HardwareQuality.QualityLevelType.Custom
	end
end

function HardwareQuality.applyDeviceRecommendOnce()
	local LocalStorage = Framework.LocalStorage.Instance

	if LocalStorage:GetInt(DEVICE_RECOMMEND_APPLIED_VERSION_KEY, 0) >= DEVICE_RECOMMEND_VERSION then
		return
	end

	if not HardwareQualityRecommend or not HardwareQualityRecommend.instance then
		return
	end

	local settingKey = HardwareQualityRecommend.SettingKey
	local recommendation = HardwareQualityRecommend.instance:getRecommendation()

	if not recommendation then
		return
	end

	local frameRateType = checkint(recommendation[settingKey.FrameRateType])

	LocalStorage:SetInt(FRAME_RATE_TYPE_KEY, frameRateType)
	LocalStorage:SetInt(FRAME_RATE_KEY, HardwareQuality._getFrameRateByType(frameRateType))
	LocalStorage:SetInt(RESOLUTION_KEY, checkint(recommendation[settingKey.Resolution]))
	LocalStorage:SetInt(SHOW_SCENE_EFFECTS_KEY, checkint(recommendation[settingKey.SceneQuality]))
	LocalStorage:SetInt(BLOOM_KEY, 0)
	LocalStorage:SetInt(MAX_PLAYERS_KEY, checkint(recommendation[settingKey.MaxPlayers]))
	LocalStorage:SetInt(DEVICE_RECOMMEND_APPLIED_VERSION_KEY, DEVICE_RECOMMEND_VERSION)
	LocalStorage:Save()
	HardwareQuality._loadUserSettingsToCustom()
	HardwareQuality.setCurrentQuality(HardwareQuality.CUSTOM)
end

function HardwareQuality._getFrameRateByType(frameRateType)
	if frameRateType == HardwareQuality.FrameRateLevelType.Low[1] then
		return HardwareQuality.FrameRateLevelType.Low[2]
	elseif frameRateType == HardwareQuality.FrameRateLevelType.Medium[1] then
		return HardwareQuality.FrameRateLevelType.Medium[2]
	elseif frameRateType == HardwareQuality.FrameRateLevelType.High[1] then
		return HardwareQuality.FrameRateLevelType.High[2]
	elseif frameRateType == HardwareQuality.FrameRateLevelType.Ultra[1] then
		return HardwareQuality.FrameRateLevelType.Ultra[2]
	end

	return HardwareQuality.FrameRateLevelType.Medium[2]
end

function HardwareQuality.getQualityByLevel(level)
	local quality = HardwareQuality.MEDIUM

	if level == HardwareQuality.QualityLevelType.Low then
		quality = HardwareQuality.LOW
	elseif level == HardwareQuality.QualityLevelType.Medium then
		quality = HardwareQuality.MEDIUM
	elseif level == HardwareQuality.QualityLevelType.High then
		quality = HardwareQuality.HIGH
	elseif level == HardwareQuality.QualityLevelType.Custom then
		quality = HardwareQuality.CUSTOM
	end

	return quality
end

function HardwareQuality._loadUserSettingsToCustom()
	local LocalStorage = Framework.LocalStorage.Instance
	local resolution = LocalStorage:GetInt(RESOLUTION_KEY, -1)

	if resolution ~= -1 then
		print("usersetting resolution :", resolution)

		HardwareQuality.CUSTOM.resolution = resolution
	end

	local frameRateType = LocalStorage:GetInt(FRAME_RATE_TYPE_KEY, -1)

	if frameRateType ~= -1 then
		print("usersetting frameRateType :", frameRateType)

		HardwareQuality.CUSTOM.frameRateType = frameRateType

		if frameRateType == HardwareQuality.FrameRateLevelType.Low[1] then
			HardwareQuality.CUSTOM.frameRate = HardwareQuality.FrameRateLevelType.Low[2]
		elseif frameRateType == HardwareQuality.FrameRateLevelType.Medium[1] then
			HardwareQuality.CUSTOM.frameRate = HardwareQuality.FrameRateLevelType.Medium[2]
		elseif frameRateType == HardwareQuality.FrameRateLevelType.High[1] then
			HardwareQuality.CUSTOM.frameRate = HardwareQuality.FrameRateLevelType.High[2]
		elseif frameRateType == HardwareQuality.FrameRateLevelType.Ultra[1] then
			HardwareQuality.CUSTOM.frameRate = HardwareQuality.FrameRateLevelType.Ultra[2]
		end
	end

	local maxPlayers = LocalStorage:GetInt(MAX_PLAYERS_KEY, 6)

	if maxPlayers ~= -1 then
		print("usersetting maxPlayers :", maxPlayers)

		maxPlayers = checkint(maxPlayers)

		if maxPlayers < 0 then
			maxPlayers = 0
		elseif maxPlayers > HardwareQuality.MaxPlayerNum then
			maxPlayers = HardwareQuality.MaxPlayerNum
		end

		HardwareQuality.CUSTOM.maxPlayers = maxPlayers
	end

	local sceneQuality = LocalStorage:GetInt(SHOW_SCENE_EFFECTS_KEY, -1)

	if sceneQuality ~= -1 then
		print("usersetting sceneQuality :", sceneQuality)

		HardwareQuality.CUSTOM.sceneQuality = sceneQuality
	end

	local bloomQuality = LocalStorage:GetInt(BLOOM_KEY, -1)

	if bloomQuality ~= -1 then
		print("usersetting bloomQuality :", bloomQuality)

		HardwareQuality.CUSTOM.bloomSwitch = false
	end
end

function HardwareQuality._loadUserSettings()
	HardwareQuality._loadUserSettingsToCustom()
	HardwareQuality._resetDeprecatedUserSettings()
end

function HardwareQuality._changeToCustomSetting(force)
	HardwareQuality.restoreUserQualitySettings()
end

function HardwareQuality._resetDeprecatedUserSettings()
	HardwareQuality.setAntiAliasing(0, false)

	HardwareQuality.currentQuality.outlineSwitch = false
	HardwareQuality.CUSTOM.antiAliasing = 0
	HardwareQuality.CUSTOM.outlineSwitch = false
	HardwareQuality.CUSTOM.dynamicResolution = false

	HardwareQuality.setDynamicResolutionSwitch(false)
	Framework.LocalStorage.Instance:SetInt(ANTIALIASING_KEY, 0)
	Framework.LocalStorage.Instance:SetInt(OUTLINE_KEY, 0)
	Framework.LocalStorage.Instance:SetInt(DYNAMICRESOLUTION_KEY, 0)
	Framework.LocalStorage.Instance:Save()
end

function HardwareQuality.setResolution(resolution, custom, force)
	if HardwareQuality.currentQuality.resolution ~= resolution or force then
		HardwareQuality.currentQuality.resolution = resolution

		if HardwareQuality.currentQuality.resolution > 0 then
			local screenWidth, screenHeight = SceneResolution.Instance:GetOriginalResolution(0, 0)
			local heightScale = HardwareQuality.currentQuality.resolution / screenHeight

			print("SetDirectResolution:" .. heightScale .. ", screenHeight = " .. screenHeight)

			if Framework.OSDef.RunOS ~= Framework.OSDef.IOS then
				SceneResolution.Instance:SetDirectResolution(heightScale)
			end
		else
			print("SetDirectResolution:" .. 1)

			if Framework.OSDef.RunOS ~= Framework.OSDef.IOS then
				SceneResolution.Instance:SetDirectResolution(1)
			end
		end

		if GlobalDispatcher and GlobalDispatcher.dispatch then
			GlobalDispatcher:dispatch(GlobalNotify.HardwareQualityChanged, HardwareQuality.currentQuality.resolution)
			GlobalDispatcher:dispatch(GlobalNotify.SceneResolutionChange)
		end

		if BootstrapAdaptationoverlayview then
			BootstrapAdaptationoverlayview.updatePos()
		end

		UnityEngine.QualitySettings.vSyncCount = HardwareQuality.currentQuality.vSyncCount

		if custom then
			HardwareQuality.CUSTOM.resolution = resolution

			Framework.LocalStorage.Instance:SetInt(RESOLUTION_KEY, resolution)
			Framework.LocalStorage.Instance:Save()
		end
	end
end

function HardwareQuality.getResolution()
	return HardwareQuality.currentQuality.resolution
end

function HardwareQuality.setOutlineSwitch(_switch, custom)
	return
end

function HardwareQuality.getOutlineSwitch()
	return false
end

function HardwareQuality.setBloomSwitch(_switch, custom)
	if HardwareQuality.currentQuality.bloomSwitch ~= false then
		HardwareQuality.currentQuality.bloomSwitch = false

		Framework.LodUtil.Instance:SetBloomSwitch(false)
		LightMgr.instance:operAllPostSwitch(false)
	end

	if custom then
		HardwareQuality.CUSTOM.bloomSwitch = false

		Framework.LocalStorage.Instance:SetInt(BLOOM_KEY, 0)
		Framework.LocalStorage.Instance:Save()
	end
end

function HardwareQuality.getBloomSwitch()
	return HardwareQuality.currentQuality.bloomSwitch
end

function HardwareQuality.setAntiAliasing(_antiLevel, record)
	if record then
		_antiLevel = 0
	end

	if HardwareQuality.currentQuality.antiAliasing ~= _antiLevel then
		HardwareQuality.currentQuality.antiAliasing = _antiLevel
	end

	if UnityEngine.QualitySettings.antiAliasing ~= _antiLevel then
		UnityEngine.QualitySettings.antiAliasing = _antiLevel
	end

	if record then
		HardwareQuality.CUSTOM.antiAliasing = _antiLevel

		Framework.LocalStorage.Instance:SetInt(ANTIALIASING_KEY, _antiLevel)
		Framework.LocalStorage.Instance:Save()
	end
end

function HardwareQuality.setRuntimeAntiAliasing(_antiLevel)
	HardwareQuality.setAntiAliasing(_antiLevel, false)
end

function HardwareQuality.getAntiAliasing()
	return HardwareQuality.currentQuality.antiAliasing
end

function HardwareQuality.setDynamicResolutionSwitch(_switch, custom)
	if HardwareQuality.currentQuality.dynamicResolution ~= false then
		HardwareQuality.currentQuality.dynamicResolution = false
	end

	ProfilerToolMgr.instance:showFps(false)
	ProfilerToolMgr.instance:removeAvgFpsTimer()

	if custom then
		HardwareQuality.CUSTOM.dynamicResolution = false

		Framework.LocalStorage.Instance:SetInt(DYNAMICRESOLUTION_KEY, 0)
		Framework.LocalStorage.Instance:Save()
	end
end

function HardwareQuality.getDynamicResolutionSwitch()
	return HardwareQuality.currentQuality.dynamicResolution
end

function HardwareQuality.startFpsMonitor()
	if HardwareQuality.getDynamicResolutionSwitch() then
		ProfilerToolMgr.instance:monitorAvgFps()
	else
		ProfilerToolMgr.instance:removeAvgFpsTimer()
	end
end

function HardwareQuality.setMaxPlayers(numPlayers, custom, force)
	numPlayers = checkint(numPlayers)

	if numPlayers < 0 then
		numPlayers = 0
	elseif numPlayers > HardwareQuality.MaxPlayerNum then
		numPlayers = HardwareQuality.MaxPlayerNum
	end

	if HardwareQuality.currentQuality.maxPlayers ~= numPlayers or force then
		HardwareQuality.currentQuality.maxPlayers = numPlayers

		SceneFacade.instance:setMaxPlayers(numPlayers)

		if custom then
			HardwareQuality.CUSTOM.maxPlayers = numPlayers

			Framework.LocalStorage.Instance:SetInt(MAX_PLAYERS_KEY, numPlayers)
			Framework.LocalStorage.Instance:Save()
		end
	end
end

function HardwareQuality.getMaxPlayers()
	return HardwareQuality.CUSTOM.maxPlayers
end

function HardwareQuality.setSceneQuality(qualityLevel, custom)
	if HardwareQuality.currentQuality.sceneQuality ~= qualityLevel then
		HardwareQuality.currentQuality.sceneQuality = qualityLevel

		SceneFacade.instance:setQuality(qualityLevel)

		if custom then
			HardwareQuality.CUSTOM.sceneQuality = qualityLevel

			Framework.LocalStorage.Instance:SetInt(SHOW_SCENE_EFFECTS_KEY, qualityLevel)
			Framework.LocalStorage.Instance:Save()
		end
	end
end

function HardwareQuality.getSceneQuality()
	return HardwareQuality.currentQuality.sceneQuality
end

function HardwareQuality.setFrameRateType(frameRateType, custom)
	if HardwareQuality.currentQuality.frameRateType ~= frameRateType then
		HardwareQuality.currentQuality.frameRateType = frameRateType

		print("1044200312 _rateType AAAAAAAAAAA:", HardwareQuality.currentQuality.frameRateType)

		if frameRateType == HardwareQuality.FrameRateLevelType.Low[1] then
			HardwareQuality.setFrameRate(HardwareQuality.FrameRateLevelType.Low[2], custom)
		elseif frameRateType == HardwareQuality.FrameRateLevelType.Medium[1] then
			HardwareQuality.setFrameRate(HardwareQuality.FrameRateLevelType.Medium[2], custom)
		elseif frameRateType == HardwareQuality.FrameRateLevelType.High[1] then
			HardwareQuality.setFrameRate(HardwareQuality.FrameRateLevelType.High[2], custom)
		elseif frameRateType == HardwareQuality.FrameRateLevelType.Ultra[1] then
			HardwareQuality.setFrameRate(HardwareQuality.FrameRateLevelType.Ultra[2], custom)
		end

		if custom then
			HardwareQuality.CUSTOM.frameRateType = frameRateType

			Framework.LocalStorage.Instance:SetInt(FRAME_RATE_TYPE_KEY, frameRateType)
			Framework.LocalStorage.Instance:Save()
		end
	end
end

function HardwareQuality.getFrameRateType()
	return HardwareQuality.currentQuality.frameRateType
end

function HardwareQuality.setFrameRate(frameRate, custom)
	if HardwareQuality.currentQuality.frameRate ~= frameRate then
		HardwareQuality.currentQuality.frameRate = frameRate
		UnityEngine.Application.targetFrameRate = frameRate

		if custom then
			HardwareQuality.CUSTOM.frameRate = frameRate

			Framework.LocalStorage.Instance:SetInt(FRAME_RATE_KEY, frameRate)
			Framework.LocalStorage.Instance:Save()
		end
	end
end

function HardwareQuality.getFrameRate()
	return HardwareQuality.currentQuality.frameRate
end

function HardwareQuality.setHighFrameRate(enable)
	local frameRate = enable and 60 or 36

	HardwareQuality.setFrameRate(frameRate)
end

function HardwareQuality.isHighFrameRate()
	return HardwareQuality.getFrameRate() > 36
end

function HardwareQuality.setLoadAssetBundleThreadCount(count)
	return
end

function HardwareQuality.getLoadAssetBundleThreadCount()
	return HardwareQuality.currentQuality.loadAssetBundleThreadCount
end

function HardwareQuality._autoComputeQuality()
	return Framework.OSDef.RunOS == Framework.OSDef.Android and HardwareQuality._autoComputeQualityForAndroid() or Framework.OSDef.RunOS == Framework.OSDef.IOS and HardwareQuality._autoComputeQualityForIOS() or HardwareQuality._autoComputeQualityForWindows()
end

function HardwareQuality._autoComputeHardwarePerformance()
	local quality = HardwareQuality._autoComputeQuality()

	HardwareQuality.setCurrentQuality(quality)
	forcePrint("Hardware Quality is:", quality.name)
	HardwareQuality._recommendSeniorSetting(quality)
end

function HardwareQuality._recommendSeniorSetting(_quality)
	if not _quality then
		return
	end

	if quality == HardwareQuality.HIGH then
		if Framework.OSDef.RunOS and Framework.OSDef.RunOS == Framework.OSDef.IOS then
			LightMgr.instance:operAllPostSwitch(false)
		else
			LightMgr.instance:operAllPostSwitch(true)
		end
	elseif quality == HardwareQuality.MEDIUM then
		LightMgr.instance:operAllPostSwitch(false)
	elseif quality == HardwareQuality.LOW then
		LightMgr.instance:operAllPostSwitch(false)
	end
end

function HardwareQuality._autoComputeQualityForWindows()
	local quality
	local level = HardwareQuality.getQualityLevel()

	return level == HardwareQuality.QualityLevelType.Low and HardwareQuality.LOW or level == HardwareQuality.QualityLevelType.Medium and HardwareQuality.MEDIUM or level == HardwareQuality.QualityLevelType.High and HardwareQuality.HIGH or HardwareQuality.CUSTOM
end

function HardwareQuality._autoComputeQualityForAndroid()
	local quality
	local SystemInfo = UnityEngine.SystemInfo

	return SystemInfo.processorFrequency > 1800 and SystemInfo.processorCount > 7 and SystemInfo.systemMemorySize > 3000 and (SystemInfo.graphicsShaderLevel > 50 and HardwareQuality.HIGH or HardwareQuality.MEDIUM) or HardwareQuality.LOW
end

function HardwareQuality._autoComputeQualityForIOS()
	forcePrint("HardwareQuality deviceModel Framework.OSDef.RunOS:", Framework.OSDef.RunOS, Framework.OSDef.RunOS == Framework.OSDef.IOS)

	if Framework.OSDef.RunOS and Framework.OSDef.RunOS == Framework.OSDef.IOS then
		local _systemInfo = UnityEngine.SystemInfo

		if _systemInfo then
			local _deviceModel = _systemInfo.deviceModel

			forcePrint("HardwareQuality deviceModel:", _deviceModel)

			if string.find(_deviceModel, "iPhone") then
				local numStr = string.match(_deviceModel, "iPhone(%d+)")

				if checknumber(numStr) >= 12 then
					return HardwareQuality.HIGH
				end
			elseif string.find(_deviceModel, "iPad") then
				local numStr = string.match(_deviceModel, "iPad(%d+)")

				if checknumber(numStr) >= 12 then
					return HardwareQuality.HIGH
				end
			end
		end
	end

	return HardwareQuality.MEDIUM
end

function HardwareQuality._setQualityForIOSDeviceModel()
	forcePrint("HardwareQuality deviceModel Framework.OSDef.RunOS:", Framework.OSDef.RunOS, Framework.OSDef.RunOS == Framework.OSDef.IOS)

	if Framework.OSDef.RunOS and Framework.OSDef.RunOS == Framework.OSDef.IOS then
		local _systemInfo = UnityEngine.SystemInfo

		if _systemInfo then
			local _deviceModel = _systemInfo.deviceModel

			forcePrint("HardwareQuality deviceModel:", _deviceModel)

			local _isIosCheck = false
			local ds, de = string.find(_deviceModel, "iPhone10")

			if ds and de then
				if _deviceModel == "iPhone10,3" or _deviceModel == "iPhone10,6" then
					print("HardwareQuality deviceModel: hight 1 = ", _deviceModel)

					_isIosCheck = true
				end
			else
				local _checkModel = {
					"iPhone11",
					"iPhone12",
					"iPhone13",
					"iPhone14",
					"iPhone15",
					"iPhone16",
					"iPad13"
				}

				for k, v in pairs(_checkModel) do
					local s, e = string.find(_deviceModel, v)

					if s and e then
						print("HardwareQuality deviceModel: hight 2 = ", _deviceModel)

						_isIosCheck = true

						break
					end
				end

				if not _isIosCheck then
					local numStr = string.match(_deviceModel, "iPhone(%d+)")

					if checknumber(numStr) > 15 then
						_isIosCheck = true
					end
				end
			end

			if _isIosCheck then
				forcePrint("HardwareQuality deviceModel: high 1")

				HardwareQuality.isSupportFrameRate60 = true

				HardwareQuality.restoreUserQualitySettings()
			else
				forcePrint("HardwareQuality deviceModel: low 1")
				HardwareQuality.applyRuntimeQualityPreset(HardwareQuality.QualityLevelType.Low)
			end
		else
			forcePrint("HardwareQuality deviceModel: low 2")
			HardwareQuality.applyRuntimeQualityPreset(HardwareQuality.QualityLevelType.Low)
		end
	end
end

function HardwareQuality.banAntiAliasing()
	UnityEngine.QualitySettings.antiAliasing = 0
end

function HardwareQuality.resetAntiAliasing()
	UnityEngine.QualitySettings.antiAliasing = HardwareQuality.currentQuality.antiAliasing
end

function HardwareQuality._adaptLRSide()
	local screenWidth, screenHeight = SceneResolution.Instance:GetOriginalResolution(0, 0)
	local _screenScale = screenWidth / screenHeight
	local UIMASK = goutil.find("UIROOT/UIMASK") or goutil.find("UIROOT/uimask")

	forcePrint("_adaptLRSide screenWidth:", screenWidth, ",screenHeight:", screenHeight, ",_screenScale:", _screenScale, ", UIMASK:", UIMASK and UIMASK.name)

	if not UIMASK then
		if Framework.OSDef.isEditor then
			forcePrint("缺少层级 UIROOT/UIMASK 1")
		end

		LoginController.instance:_createUiMask(function(_asset)
			local uiRoot = goutil.find("UIROOT")
			local _go = goutil.cloneAndSetParent(_asset, uiRoot.transform, "uimask")
			local _black_1 = goutil.findChild(_go, "black_1")
			local _black_2 = goutil.findChild(_go, "black_2")
			local _blackRect1 = _black_1:GetComponent("RectTransform")
			local _blackRect2 = _black_2:GetComponent("RectTransform")
			local _showMask = _screenScale > 2.23

			forcePrint("_adaptLRSide _showMask 1:", _showMask)

			if _showMask then
				local _adaptWidth = _screenScale * 720 - 1600

				_blackRect1.sizeDelta = Vector2.New(_adaptWidth, 720)
				_blackRect2.sizeDelta = Vector2.New(_adaptWidth, 720)
			else
				_blackRect1.sizeDelta = Vector2.New(0, 0)
				_blackRect2.sizeDelta = Vector2.New(0, 0)
			end
		end)
	else
		local _black_1 = goutil.findChild(UIMASK, "black_1")
		local _black_2 = goutil.findChild(UIMASK, "black_2")
		local _blackRect1 = _black_1:GetComponent("RectTransform")
		local _blackRect2 = _black_2:GetComponent("RectTransform")
		local _showMask = _screenScale > 2.23

		forcePrint("_adaptLRSide _showMask 2:", _showMask)

		if _showMask then
			local _adaptWidth = _screenScale * 720 - 1600

			_blackRect1.sizeDelta = Vector2.New(_adaptWidth, 720)
			_blackRect2.sizeDelta = Vector2.New(_adaptWidth, 720)
		else
			_blackRect1.sizeDelta = Vector2.New(0, 0)
			_blackRect2.sizeDelta = Vector2.New(0, 0)
		end
	end
end

function HardwareQuality.tryLoadImage()
	local UIMASK = goutil.find("UIROOT/UIMASK") or goutil.find("UIROOT/uimask")

	if UIMASK then
		local _black_1 = goutil.findChild(UIMASK, "black_1")
		local _black_2 = goutil.findChild(UIMASK, "black_2")
		local image1 = _black_1:GetComponent(ComponentType.RawImage)
		local image2 = _black_2:GetComponent(ComponentType.RawImage)
		local testGo = goutil.findChild(UIMASK, "test")

		if testGo then
			goutil.setActive(testGo, false)

			local versionCode = checknumber(BootstrapUtil.getGameVersionCode())

			if versionCode >= 1102 and versionCode < 1110 then
				goutil.setActive(testGo, true)

				local txtVersion = goutil.findChildTextComponent(testGo, "txtVersion")

				if txtVersion and not Framework.OSDef.isEditor then
					txtVersion.text = string.format("v:%s", BootstrapUtil.getGameVersionCode())
				end
			end
		end

		getres(GameUrl.getBigbgPngUrl("views/login/main_board_0"), function(res)
			res:Retain()

			local texture = res:GetMainAsset()

			image1.texture = texture
			image2.texture = texture
			image1.color = Framework.ColorUtil.ParseColor("#FFFFFFFF")
			image2.color = Framework.ColorUtil.ParseColor("#FFFFFFFF")
		end)
	end
end

function HardwareQuality.getAdaptWidth()
	local screenWidth, screenHeight = SceneResolution.Instance:GetOriginalResolution(0, 0)
	local _screenScale = screenWidth / screenHeight

	if _screenScale and _screenScale > 2.23 then
		return _screenScale * 720 - 1600
	else
		return nil
	end
end

function HardwareQuality._closeAdaptLRSide()
	local screenWidth, screenHeight = SceneResolution.Instance:GetOriginalResolution(0, 0)
	local _screenScale = screenWidth / screenHeight
	local _showMask = _screenScale > 2.23

	if not _showMask then
		return
	end

	local UIMASK = goutil.find("UIROOT/UIMASK") or goutil.find("UIROOT/uimask")

	if not UIMASK then
		if Framework.OSDef.isEditor then
			forcePrint("缺少层级 UIROOT/UIMASK 2")
		end

		return
	end

	local _black_1 = goutil.findChild(UIMASK, "black_1")
	local _black_2 = goutil.findChild(UIMASK, "black_2")
	local _blackRect1 = _black_1:GetComponent("RectTransform")
	local _blackRect2 = _black_2:GetComponent("RectTransform")

	_blackRect1.sizeDelta = Vector2.New(0, 0)
	_blackRect2.sizeDelta = Vector2.New(0, 0)
end

function HardwareQuality._updateUiMaskParent(_type, _mainGo)
	local screenWidth, screenHeight = SceneResolution.Instance:GetOriginalResolution(0, 0)
	local _screenScale = screenWidth / screenHeight
	local _showMask = _screenScale > 2.23

	if not _showMask then
		return
	end

	local UIMASK

	if _type == HardwareQuality.UiMaskLayer.UIRoot and _mainGo then
		UIMASK = goutil.findChild(_mainGo, "UIMASK") or goutil.findChild(_mainGo, "uimask")
	elseif _type == HardwareQuality.UiMaskLayer.Story then
		UIMASK = goutil.find("UIROOT/UIMASK") or goutil.find("UIROOT/uimask")
	end

	forcePrint("_updateUiMaskParent UIMASK:", UIMASK, UIMASK and UIMASK.name, _type, _mainGo)

	if not UIMASK then
		if Framework.OSDef.isEditor then
			forcePrint("缺少层级 UIROOT/UIMASK 3")
		end

		return
	end

	local _parent

	if _type == HardwareQuality.UiMaskLayer.UIRoot then
		_parent = goutil.find("UIROOT")
	elseif _type == HardwareQuality.UiMaskLayer.Story then
		_parent = _mainGo or goutil.find("story_background(Clone)")
	end

	forcePrint("_updateUiMaskParent _parent:", _parent)

	if _parent then
		UIMASK.transform.parent = _parent.transform

		if _type == HardwareQuality.UiMaskLayer.Story then
			local _black_1 = goutil.findChild(UIMASK, "black_1")
			local _black_2 = goutil.findChild(UIMASK, "black_2")
			local _blackRect1 = _black_1:GetComponent("RectTransform")
			local _blackRect2 = _black_2:GetComponent("RectTransform")
			local _adaptWidth = _screenScale * 720 - 1600

			_blackRect1.sizeDelta = Vector2.New(_adaptWidth, 720)
			_blackRect2.sizeDelta = Vector2.New(_adaptWidth, 720)
		end
	end
end

return HardwareQuality
