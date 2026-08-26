-- chunkname: @modules/logic/settings/model/SettingsModel.lua

module("modules.logic.settings.model.SettingsModel", package.seeall)

local SettingsModel = class("SettingsModel", BaseModel)

SettingsModel.ResolutionRatioWidthList = {
	15360,
	7680,
	3840,
	2560,
	1920,
	1600,
	1366,
	1280,
	1152,
	1024,
	800
}
SettingsModel.FrameRate = {
	30,
	60,
	120,
	144
}

function SettingsModel:onInit()
	self._curCategoryId = 1
	self._categoryList = {}
	self.showHelper = self.showHelper or SettingsShowHelper.New()

	local defaultValue = 80
	local defaultGlobalAudioVolume = 100
	local isFirstBoot = PlayerPrefsHelper.getNumber(PlayerPrefsKey.FirstBootForBetaTest, 0)

	if isFirstBoot == 1 or not BootNativeUtil.isStandalonePlayer() or SLFramework.FrameworkSettings.IsEditor then
		self._musicValue = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsMusicValue, defaultValue)
		self._voiceValue = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsVoiceValue, defaultValue)
		self._effectValue = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsEffectValue, defaultValue)
		self._globalAudioVolume = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsGlobalAudioVolume, defaultGlobalAudioVolume)
	else
		self._musicValue = defaultValue
		self._voiceValue = defaultValue
		self._effectValue = defaultValue
		self._globalAudioVolume = defaultGlobalAudioVolume
		self._pushStates = {}

		PlayerPrefsHelper.setNumber(PlayerPrefsKey.FirstBootForBetaTest, 1)
	end

	self._musicValue = math.ceil(self._musicValue)
	self._voiceValue = math.ceil(self._voiceValue)
	self._effectValue = math.ceil(self._effectValue)
	self._energyMode = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsEnergyMode, 0)

	local defaultState = BootNativeUtil.isAndroid() and 0 or 1

	self._screenshotSwitch = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsScreenshotSwitch, defaultState)
	self._minRate = 1.3333333333333333
	self._maxRate = 2.4

	if SLFramework.FrameworkSettings.IsEditor then
		self._screenWidth, self._screenHeight = UnityEngine.Screen.width, UnityEngine.Screen.height
	elseif BootNativeUtil.isWindows() then
		self:initRateAndSystemSize()
		self:initWindowsResolution()
		self:initResolutionRationDataList()
	else
		self._screenWidth, self._screenHeight = UnityEngine.Screen.width, UnityEngine.Screen.height
	end

	self.limitedRoleMO = SettingsLimitedRoleMO.New()
	self._primaryCpuAbi = SLFramework.NativeUtil.GetAndroidtPrimaryCpuAbi()

	if SDKMgr.instance:isEmulator() and (self._primaryCpuAbi == "armeabi-v7a" or self._primaryCpuAbi == "arm64-v8a") then
		self._isUseUnityVideo = 1
	end
end

function SettingsModel:reInit()
	self.limitedRoleMO:reInit()
end

function SettingsModel:initRateAndSystemSize()
	self._systemScreenWidth, self._systemScreenHeight = BootNativeUtil.getDisplayResolution()
	self._curRate = self._systemScreenWidth / self._systemScreenHeight

	if self._curRate < self._minRate then
		self._systemScreenHeight = self._systemScreenWidth / self._minRate
		self._curRate = self._minRate
	end

	if self._curRate > self._maxRate then
		self._systemScreenWidth = self._systemScreenHeight * self._maxRate
		self._curRate = self._maxRate
	end
end

function SettingsModel:initResolutionRationDataList()
	self._resolutionRatioDataList = {}

	if SLFramework.FrameworkSettings.IsEditor then
		self:_appendResolutionData(UnityEngine.Screen.width, UnityEngine.Screen.height, false)

		return
	end

	local resolution = UnityEngine.Screen.currentResolution
	local rWidth = resolution.width

	if self._resolutionRatioDataList and #self._resolutionRatioDataList >= 1 then
		local oldMaxWidth = self._resolutionRatioDataList[1]

		if oldMaxWidth == rWidth then
			return
		end
	end

	local fullScreenHeight = math.floor(rWidth / self._curRate)

	self:_appendResolutionData(rWidth, fullScreenHeight, true)

	for _, width in ipairs(SettingsModel.ResolutionRatioWidthList) do
		if width <= self._systemScreenWidth and width <= rWidth then
			local height = math.floor(width / self._curRate)

			self:_appendResolutionData(width, height, false)
		end
	end

	local _, isNotFound = self:getCurrentDropDownIndex()

	if isNotFound then
		local nowW, nowH, isFullScreen = self:getCurrentResolutionWHAndIsFull()

		self:_appendResolutionData(nowW, nowH, isFullScreen)
	end
end

function SettingsModel:initWindowsResolution()
	if SLFramework.FrameworkSettings.IsEditor then
		self._screenWidth, self._screenHeight = UnityEngine.Screen.width, UnityEngine.Screen.height

		self:_setIsFullScreen(false)

		self._resolutionRatio = self:_resolutionStr(self._screenWidth, self._screenHeight)
	else
		self._resolutionRatio = PlayerPrefsHelper.getString(PlayerPrefsKey.ResolutionRatio, nil)

		local fullScreenKey = PlayerPrefsHelper.getNumber(PlayerPrefsKey.FullScreenKey, ModuleEnum.FullScreenState.On)

		self:_setIsFullScreen(fullScreenKey == ModuleEnum.FullScreenState.On)

		if self:isFullScreen() then
			local resolution = UnityEngine.Screen.currentResolution

			self._screenWidth = resolution.width
			self._screenHeight = resolution.height
		else
			local isSavedResolution = not string.nilorempty(self._resolutionRatio) and self._resolutionRatio ~= "nil"
			local resolution = isSavedResolution and string.splitToNumber(self._resolutionRatio, "*") or {
				1920,
				1080
			}
			local currentWidth = UnityEngine.Screen.width

			if isSavedResolution and currentWidth <= resolution[1] then
				self._screenWidth = resolution[1]
				self._screenHeight = resolution[2]
			else
				local height = math.floor(currentWidth / self._curRate)

				self._screenWidth = currentWidth
				self._screenHeight = height
				self._resolutionRatio = self:_resolutionStr(currentWidth, height)
			end
		end
	end

	self:setResolutionRatio()
end

function SettingsModel:getCurCategoryId()
	return self._curCategoryId
end

function SettingsModel:setCurCategoryId(id)
	self._curCategoryId = id
end

function SettingsModel:setSettingsCategoryList(list)
	self._categoryList = list
end

function SettingsModel:getSettingsCategoryList()
	self._categoryList = {}

	for i, v in ipairs(SettingsEnum.CategoryList) do
		local isOpen = self:canShowCategory(v)

		if isOpen then
			table.insert(self._categoryList, v)
		end
	end

	return self._categoryList
end

function SettingsModel:canShowCategory(v)
	local isOpen = #v.openIds == 0 and v.showIds == nil or false

	for n, m in pairs(v.openIds) do
		if OpenModel.instance:isFuncBtnShow(m) then
			isOpen = true

			break
		end
	end

	if not isOpen and v.showIds then
		for _, showId in pairs(v.showIds) do
			if self.showHelper:canShow(showId) then
				isOpen = true

				break
			end
		end
	end

	if v.hideOnGamepadModle and GamepadController.instance:isOpen() then
		isOpen = false
	end

	return isOpen
end

function SettingsModel.isBilibili()
	local channelId = SDKMgr.instance:getChannelId()

	channelId = channelId and tostring(channelId)

	return not string.nilorempty(channelId) and channelId == "101"
end

function SettingsModel.isOfficial()
	local channelId = SDKMgr.instance:getChannelId()

	channelId = channelId and tostring(channelId)

	return not string.nilorempty(channelId) and channelId == "100"
end

function SettingsModel:getScreenshotSwitch()
	return self._screenshotSwitch > 0
end

function SettingsModel:setScreenshotSwitch(screenshotSwitch)
	self._screenshotSwitch = screenshotSwitch and 1 or 0

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsScreenshotSwitch, self._screenshotSwitch)
end

function SettingsModel:changeEnergyMode()
	if self._energyMode == 1 then
		self._energyMode = 0

		GameGlobalMgr.instance:getScreenState():setLocalQuality(self:getModelGraphicsQuality())
		GameGlobalMgr.instance:getScreenState():setTargetFrameRate(self._frameRate)
	else
		self._energyMode = 1

		GameGlobalMgr.instance:getScreenState():setLocalQuality(ModuleEnum.Performance.Low)
		GameGlobalMgr.instance:getScreenState():setTargetFrameRate(ModuleEnum.TargetFrameRate.Low)
	end

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsEnergyMode, self._energyMode)
end

function SettingsModel:getEnergyMode()
	return self._energyMode
end

function SettingsModel:getMusicValue()
	return self._musicValue
end

function SettingsModel:setMusicValue(musicValue)
	self._musicValue = musicValue

	AudioMgr.instance:setRTPCValue(AudioEnum.Volume.Music_Volume, musicValue)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsMusicValue, self._musicValue)
end

function SettingsModel:getVoiceValue()
	return self._voiceValue
end

function SettingsModel:setVoiceValue(voiceValue)
	self._voiceValue = voiceValue

	AudioMgr.instance:setRTPCValue(AudioEnum.Volume.Voc_Volume, voiceValue)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsVoiceValue, self._voiceValue)

	if self._voiceValue > 0 then
		AudioMgr.instance:setState(AudioMgr.instance:getIdFromString("Voc_Volume_M"), AudioMgr.instance:getIdFromString("no"))
	else
		AudioMgr.instance:setState(AudioMgr.instance:getIdFromString("Voc_Volume_M"), AudioMgr.instance:getIdFromString("yes"))
	end
end

function SettingsModel:getEffectValue()
	return self._effectValue
end

function SettingsModel:setEffectValue(effectValue)
	self._effectValue = effectValue

	AudioMgr.instance:setRTPCValue(AudioEnum.Volume.SFX_Volume, effectValue)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsEffectValue, self._effectValue)
end

function SettingsModel:getGlobalAudioVolume()
	return self._globalAudioVolume
end

function SettingsModel:setGlobalAudioVolume(volume)
	self._globalAudioVolume = volume

	AudioMgr.instance:setRTPCValue(AudioEnum.Volume.Global_Volume, volume)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsGlobalAudioVolume, self._globalAudioVolume)
end

function SettingsModel:getRealGraphicsQuality()
	return GameGlobalMgr.instance:getScreenState():getLocalQuality()
end

function SettingsModel:getModelGraphicsQuality()
	self._graphicsQuality = self._graphicsQuality or PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsGraphicsQuality, self:getRecommendQuality())

	return self._graphicsQuality
end

function SettingsModel:setGraphicsQuality(qualityValue)
	self._graphicsQuality = qualityValue

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsGraphicsQuality, self._graphicsQuality)
	GameGlobalMgr.instance:getScreenState():setLocalQuality(qualityValue)
end

function SettingsModel:getRecommendQuality()
	return HardwareUtil.getPerformanceGrade()
end

function SettingsModel:getRealTargetFrameRate()
	return GameGlobalMgr.instance:getScreenState():getTargetFrameRate()
end

function SettingsModel:getModelTargetFrameRate()
	self._frameRate = self._frameRate or GameGlobalMgr.instance:getScreenState():getTargetFrameRate()

	return self._frameRate
end

function SettingsModel:setTargetFrameRate(targetFrameRate)
	self._frameRate = targetFrameRate

	GameGlobalMgr.instance:getScreenState():setTargetFrameRate(targetFrameRate)
end

function SettingsModel:_setIsFullScreen(bool)
	if bool then
		self._isFullScreen = ModuleEnum.FullScreenState.On or ModuleEnum.FullScreenState.Off
	end
end

function SettingsModel:_setScreenWidthAndHeight(resolutionRatioStr)
	if not BootNativeUtil.isWindows() then
		return false
	end

	local resolution = string.splitToNumber(resolutionRatioStr, "*")

	if resolution[1] > self._systemScreenWidth or resolution[2] > self._systemScreenHeight then
		GameFacade.showToast(ToastEnum.SetScreenWidthAndHeightFail)

		return false
	end

	self._screenWidth = resolution[1]
	self._screenHeight = resolution[2]

	self:_setIsFullScreen(false)

	self._resolutionRatio = resolutionRatioStr

	self:setResolutionRatio()

	return true
end

function SettingsModel:getResolutionRatio()
	return self._resolutionRatio
end

function SettingsModel:setResolutionRatio()
	PlayerPrefsHelper.setString(PlayerPrefsKey.ResolutionRatio, self._resolutionRatio)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.FullScreenKey, self._isFullScreen)
	ZProj.GameHelper.SetResolutionRatio(self._screenWidth, self._screenHeight, self:isFullScreen())
	GameGlobalMgr.instance:dispatchEvent(GameStateEvent.OnScreenResize, self._screenWidth, self._screenHeight)
end

function SettingsModel:getCurrentScreenResolutionRatio()
	return self._screenWidth / self._screenHeight
end

function SettingsModel:getCurrentScreenSize()
	return self._screenWidth, self._screenHeight
end

function SettingsModel:isFullScreen()
	return self._isFullScreen == ModuleEnum.FullScreenState.On
end

function SettingsModel:setFullChange(isOn)
	self._isFullScreen = isOn

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.FullScreenKey, isOn)

	if self:isFullScreen() then
		ZProj.GameHelper.SetResolutionRatio(self._systemScreenWidth, self._systemScreenHeight, true)
	else
		ZProj.GameHelper.SetResolutionRatio(self._screenWidth, self._screenHeight, false)
	end
end

function SettingsModel:getScreenSizeMinRate()
	return self._minRate
end

function SettingsModel:getScreenSizeMaxRate()
	return self._maxRate
end

function SettingsModel:checkInitRecordVideo()
	if self._isRecordVideo ~= nil then
		return
	end

	if not OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.SettingsRecordVideo) then
		self._isRecordVideo = 0

		return
	end

	self._isRecordVideo = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsRecordVideo, 0)
end

function SettingsModel:setRecordVideo(isOn)
	self:checkInitRecordVideo()

	self._isRecordVideo = isOn and 1 or 0

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsRecordVideo, self._isRecordVideo)
end

function SettingsModel:getRecordVideo()
	self:checkInitRecordVideo()

	return self._isRecordVideo == 1
end

function SettingsModel:setVideoCompatible(isOn)
	self._isVideoCompatible = isOn and 1 or 0

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsVideoCompatible, self._isVideoCompatible)
end

function SettingsModel:setUseUnityVideo(v)
	self._isUseUnityVideo = v and 1 or 0

	if SDKMgr.instance:isEmulator() and (self._primaryCpuAbi == "armeabi-v7a" or self._primaryCpuAbi == "arm64-v8a") then
		self._isUseUnityVideo = 1
	end

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsUnityVideo, self._isUseUnityVideo)
end

function SettingsModel:getUseUnityVideo()
	if SDKMgr.instance:isEmulator() and (self._primaryCpuAbi == "armeabi-v7a" or self._primaryCpuAbi == "arm64-v8a") then
		self._isUseUnityVideo = 1
	end

	if self._isUseUnityVideo == nil then
		self._isUseUnityVideo = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsUnityVideo, 0)
	end

	return self._isUseUnityVideo == 1
end

function SettingsModel:getVideoCompatible()
	if self._isVideoCompatible == nil then
		self._isVideoCompatible = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsVideoCompatible, 0)
	end

	return self._isVideoCompatible == 1
end

function SettingsModel:setVideoHDMode(isOn)
	self._isVideoHDMode = isOn and 1 or 0

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsVideoHDMode, self._isVideoHDMode)
end

function SettingsModel:getVideoHDMode()
	if not PlayerPrefsHelper.hasKey(PlayerPrefsKey.SettingsVideoHDMode) and (BootNativeUtil.isWindows() or BootNativeUtil.isMuMu()) then
		self:setVideoHDMode(true)
	end

	local packageinfo = SettingsVoicePackageModel.instance:getPackInfo("res-HD")

	if packageinfo and packageinfo:needDownload() then
		self:setVideoHDMode(false)
	end

	if self._isVideoHDMode == nil then
		self._isVideoHDMode = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsVideoHDMode, 0)
	end

	return self._isVideoHDMode == 1
end

function SettingsModel:setPushState(info)
	self._pushStates = {}

	for _, v in ipairs(info) do
		self._pushStates[v.type] = {}
		self._pushStates[v.type].type = v.type
		self._pushStates[v.type].param = v.param
	end
end

function SettingsModel:updatePushState(type, param)
	if not self._pushStates[type] then
		self._pushStates[type] = {}
		self._pushStates[type].type = type
	end

	self._pushStates[type].param = param
end

function SettingsModel:isPushTypeOn(type)
	local sdkEnable = SDKMgr.instance:isNotificationEnable()

	if self._pushStates[type] then
		local typeOn = self._pushStates[type].param == "1"

		return sdkEnable and typeOn
	end
end

function SettingsModel:isTypeOn(type)
	if self._pushStates[type] then
		local typeOn = self._pushStates[type].param == "1"

		return typeOn
	end
end

function SettingsModel:_resolutionStr(width, height)
	return string.format("%s * %s", width, height)
end

function SettingsModel:getResolutionRatioStrList()
	self:initResolutionRationDataList()

	local list = {}

	for _, v in ipairs(self._resolutionRatioDataList) do
		local str = self:_resolutionStr(v.width, v.height)

		table.insert(list, (v.isFullscreen or nil) and luaLang("settings_fullscreen"))
	end

	return list
end

function SettingsModel:_appendResolutionData(width_, height_, isFullScreen_)
	table.insert(self._resolutionRatioDataList, {
		width = width_,
		height = height_,
		isFullscreen = isFullScreen_
	})
end

function SettingsModel:setScreenResolutionByIndex(index)
	if not BootNativeUtil.isWindows() then
		return false
	end

	if not self._resolutionRatioDataList then
		return false
	end

	local resolution = self._resolutionRatioDataList[index]

	if not resolution then
		GameFacade.showToastString("error index:" .. index)

		return false
	end

	self._screenWidth = resolution.width
	self._screenHeight = resolution.height

	self:_setIsFullScreen(resolution.isFullscreen)

	self._resolutionRatio = self:_resolutionStr(self._screenWidth, self._screenHeight)

	self:setResolutionRatio()

	return true
end

function SettingsModel:getCurrentResolutionWHAndIsFull()
	if not self._resolutionRatio then
		self:initWindowsResolution()
	end

	local resolution = string.splitToNumber(self._resolutionRatio, "*")

	if not resolution then
		return 0, 0, false
	end

	local isFullScreen = self:isFullScreen()

	return resolution[1], resolution[2], isFullScreen
end

function SettingsModel:getCurrentDropDownIndex()
	local nowW, nowH, isFullScreen = self:getCurrentResolutionWHAndIsFull()

	if isFullScreen then
		return 0
	end

	for i, v in ipairs(self._resolutionRatioDataList or {}) do
		if not v.isFullscreen and nowW == v.width and nowH == v.height then
			return i - 1
		end
	end

	return 0, true
end

function SettingsModel:getCurrentFrameRateIndex()
	local frameRate = self:getModelTargetFrameRate()

	for i, v in ipairs(SettingsModel.FrameRate) do
		if frameRate == v then
			return i
		end
	end

	return 1
end

function SettingsModel:setModelTargetFrameRate(index)
	local frameRate = SettingsModel.FrameRate[index + 1]

	if frameRate then
		logNormal("设置帧率: ", frameRate)
		self:setTargetFrameRate(frameRate)
	end
end

function SettingsModel:isNatives()
	return not self:isOverseas()
end

function SettingsModel:isOverseas()
	if self.__isOverseas == nil then
		local gameId = SDKMgr.instance:getGameId()

		self.__isOverseas = tostring(gameId) ~= "50001"
	end

	return self.__isOverseas
end

function SettingsModel:getRegion()
	if self:isNatives() then
		return RegionEnum.zh
	else
		return GameConfig:GetCurRegionType()
	end
end

function SettingsModel:isZhRegion()
	return self:getRegion() == RegionEnum.zh
end

function SettingsModel:isJpRegion()
	return self:getRegion() == RegionEnum.jp
end

function SettingsModel:isEnRegion()
	return self:getRegion() == RegionEnum.en
end

function SettingsModel:isTwRegion()
	return self:getRegion() == RegionEnum.tw
end

function SettingsModel:isKrRegion()
	return self:getRegion() == RegionEnum.ko
end

function SettingsModel:getRegionShortcut()
	return RegionEnum.shortcutTab[self:getRegion()] or "en"
end

function SettingsModel:extractByRegion(str)
	if string.nilorempty(str) then
		return str
	end

	local list = GameUtil.splitString2(str, false)
	local curRegion = self:getRegionShortcut()

	for _, v in ipairs(list) do
		local region = v[1]

		if region == curRegion then
			return v[2]
		end
	end

	return str
end

function SettingsModel:extractByRegionEx(str)
	if string.nilorempty(str) then
		return str
	end

	local curRegion = self:getRegionShortcut()

	return string.match(str, curRegion .. "<([^>]+)>") or str
end

function SettingsModel:isAvproVideo()
	if SDKMgr.instance:isEmulator() and (self._primaryCpuAbi == "armeabi-v7a" or self._primaryCpuAbi == "arm64-v8a") then
		return false
	end

	return self:getVideoCompatible() == false and self:getUseUnityVideo() == false
end

function SettingsModel:setFightCardDetail(isOn)
	self.fightCardDetail = isOn

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SettingsFightCardDetail, self.fightCardDetail and 1 or 0)
end

function SettingsModel:getFightCardDetail()
	if self.fightCardDetail == nil then
		self.fightCardDetail = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SettingsFightCardDetail, 0) == 1
	end

	return self.fightCardDetail
end

SettingsModel.instance = SettingsModel.New()

return SettingsModel
