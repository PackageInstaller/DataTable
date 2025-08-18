-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Helper\\DeviceHelper.lua

local Screen = UnityEngine.Screen
local GameSettingHelper = Framework.Settings.GameSettingHelper
local LuaToolkit = Framework.Tools.LuaToolkit
local LoaderFactory = Framework.Resource.LoaderFactory
local ScreenUtils = Framework.Device.ScreenUtils
local SystemInfo = UnityEngine.SystemInfo
local UIUtils = Framework.UI.UIUtils
local GameSettings = require("Helper/GameSettings")
local DebugHelper = DebugHelper
local DeviceHelper = {}

DeviceHelper.NET_NONE = 0
DeviceHelper.NET_DATA = 1
DeviceHelper.NET_WIFI = 2
DeviceHelper.PLATFORM_IOS = "iOS"
DeviceHelper.PLATFORM_ANDROID = "Android"
DeviceHelper.PLATFORM_WINDOWS = "Windows"
DeviceHelper.PLATFORM_MACOS = "MacOS"
DeviceHelper.runtimePlatform = GameSettingHelper.GetPlatformName()

local origWidth, origHeight = GameSettings.getOrigResolution()

DeviceHelper.screenWidth = origWidth
DeviceHelper.screenHeight = origHeight
DeviceHelper.curWidth = Screen.width
DeviceHelper.curHeight = Screen.height
DeviceHelper.systemMemorySize = SystemInfo.systemMemorySize

function DeviceHelper._isLowMemoryDevice()
	local lowMemorySize = 2050

	if DeviceHelper.runtimePlatform == DeviceHelper.PLATFORM_IOS then
		lowMemorySize = 1025
	end

	return lowMemorySize > DeviceHelper.systemMemorySize
end

DeviceHelper.IsLowMemoryDevice = DeviceHelper._isLowMemoryDevice()
DeviceHelper.deviceModel = SystemInfo.deviceModel
DeviceHelper.isIPad = false

if DeviceHelper.runtimePlatform == DeviceHelper.PLATFORM_IOS then
	DeviceHelper.isIPad = string.match(DeviceHelper.deviceModel, "iPad") ~= nil
end

function DeviceHelper._calsDiagonalInches()
	local dpi = Screen.dpi

	return math.sqrt(math.pow(DeviceHelper.screenWidth / dpi, 2) + math.pow(DeviceHelper.screenHeight / dpi, 2))
end

DeviceHelper.diagonalInches = DeviceHelper._calsDiagonalInches()

function DeviceHelper._isTablet()
	if DeviceHelper.runtimePlatform == DeviceHelper.PLATFORM_IOS then
		return DeviceHelper.isIPad
	elseif DeviceHelper.runtimePlatform == DeviceHelper.PLATFORM_ANDROID then
		return DeviceHelper.diagonalInches > 6.5
	end

	return false
end

DeviceHelper.isTablet = DeviceHelper._isTablet()

function DeviceHelper.setMsaa(msaaSample, quality)
	local needMsaa = msaaSample ~= 1

	ModelStageManager.DEFAULT_ANTI_ALIASING = msaaSample

	DebugHelper.SetQualitySettingAntiAliasing(msaaSample)
	CameraModeManager.setMSAA(msaaSample)
end

DeviceHelper.screenScale = 1

function DeviceHelper._setResolution(w, h)
	w = math.floor(w * DeviceHelper.screenScale)
	h = math.floor(h * DeviceHelper.screenScale)

	GameSettings.setResoluation(w, h)

	DeviceHelper.curWidth = w
	DeviceHelper.curHeight = h
end

function DeviceHelper.setRenderResolution()
	DeviceHelper.setUIMatchHeight()

	local screenWidth = DeviceHelper.screenWidth
	local screenHeight = DeviceHelper.screenHeight
	local resolutionLv = GameSettings.getCustomSetting("ResolutionLv")

	if DeviceHelper.runtimePlatform == DeviceHelper.PLATFORM_IOS then
		local raduceRatio = 1

		if DeviceHelper.isIPad then
			local model = DeviceHelper.deviceModel
			local commaIdx = string.find(model, ",")

			if commaIdx > 0 then
				local ver = tonumber(string.sub(model, 5, commaIdx - 1))

				if ver < 5 and resolutionLv <= 1 then
					raduceRatio = 1.5
				end
			end
		elseif DeviceHelper.deviceModel == "iPhone7,1" then
			raduceRatio = 1.5
		end

		DeviceHelper._setResolution(screenWidth / raduceRatio, screenHeight / raduceRatio)
	elseif DeviceHelper.runtimePlatform == DeviceHelper.PLATFORM_ANDROID then
		local designW, designH = screenWidth, screenHeight

		if resolutionLv <= 2 then
			designW, designH = 1280, 720
		end

		local screenRatio = screenWidth / screenHeight
		local designRatio = designW / designH

		if designRatio < screenRatio then
			designW = screenRatio * designH
		elseif screenRatio < designRatio then
			designH = designW / screenRatio
		end

		if screenWidth < designW then
			designW = screenWidth
			designH = screenHeight
		end

		if resolutionLv == 1 or resolutionLv == 3 then
			DeviceHelper.screenScale = 0.9
		else
			DeviceHelper.screenScale = 1
		end

		local aspect = designW / designH
		local maxAspect = 2.2222222222222223

		if maxAspect < aspect then
			designW = math.floor(designH * maxAspect)
		end

		if designH > 1080 then
			designW = math.floor(designW * (1080 / designH))
			designH = 1080
		end

		DeviceHelper._setResolution(designW, designH)
	end
end

function DeviceHelper.setUIMatchHeight()
	local width = DeviceHelper.curWidth
	local height = DeviceHelper.curHeight

	if width and height then
		if width < height then
			width, height = height, width
		end

		local matchHeight = width / height > 1.7877777777777777

		UIUtils.SetMatchHeight(matchHeight)
	end
end

function DeviceHelper.isIOS()
	return DeviceHelper.runtimePlatform == DeviceHelper.PLATFORM_IOS
end

function DeviceHelper.isAndroid()
	return DeviceHelper.runtimePlatform == DeviceHelper.PLATFORM_ANDROID
end

function DeviceHelper.isWindows()
	return DeviceHelper.runtimePlatform == DeviceHelper.PLATFORM_WINDOWS
end

function DeviceHelper.getDesignScreenRatio(...)
	return GameSettingHelper.GetDesignScreenRatio()
end

function DeviceHelper.getNetworkTypeText(isEng)
	local networkType = LuaToolkit.GetNetworkType()
	local text = isEng and "NO" or Lang.get(3845)

	if networkType == DeviceHelper.NET_DATA then
		text = isEng and "DATA" or Lang.get(29950)
	elseif networkType == DeviceHelper.NET_WIFI then
		text = "WIFI"
	end

	return text
end

function DeviceHelper.loaderDelayDisposeOn(level)
	LoaderFactory.LingerAddCache = level * 5
	LoaderFactory.LingerMaxTime = level * 60
end

function DeviceHelper.loaderDelayDisposeOff()
	LoaderFactory.LingerMaxTime = LoaderFactory.DefaultLingerTime
end

function DeviceHelper.onLowMemory()
	DeviceHelper.loaderDelayDisposeOff()
	DeviceHelper.setUICache(true)
	EffectManager:changePoolCleanCount(30)
end

function DeviceHelper.initLoaderMemoryControl()
	local memoryLv = 1
	local memorySize = DeviceHelper.systemMemorySize

	memoryLv = memorySize < 2050 and 1 or memorySize < 3100 and 2 or 3

	if memoryLv == 1 then
		DeviceHelper.loaderDelayDisposeOn(0)
		DeviceHelper.setUICache(true)
		EffectManager:changePoolCleanCount(10)
	elseif memoryLv == 2 then
		DeviceHelper.loaderDelayDisposeOn(1)
		DeviceHelper.setUICache(true)
		EffectManager:changePoolCleanCount(30)
	else
		DeviceHelper.loaderDelayDisposeOn(2)
		DeviceHelper.setUICache(false)
		EffectManager:changePoolCleanCount(60)
	end

	GameSettingHelper.RegisterLowMemoryCallback(DeviceHelper.onLowMemory)
end

DeviceHelper._shaderWarmUpCalled = false

function DeviceHelper.tryWarmUpShader()
	if DeviceHelper._shaderWarmUpCalled then
		return
	end

	DeviceHelper._shaderWarmUpCalled = true

	if VersionUtils.hasAbilityWarmUpShaderByLua() and (not DeviceHelper.isIOS() or not DeviceHelper.IsLowMemoryDevice) then
		LuaToolkit.WarmUpShader()
	end
end

function DeviceHelper.cleanWarmUpedShader()
	if VersionUtils.hasAbilityWarmUpShaderByLua() and (not DeviceHelper.isIOS() or not DeviceHelper.IsLowMemoryDevice) then
		LuaToolkit.StopWarmUpShader()
		LuaToolkit.UnloadShaderWarmUp()
	end
end

function DeviceHelper.setUICache(inLowMemory)
	if inLowMemory then
		UIConst.CacheDefaultTime = 0
		UIConst.CacheMaxNumber = 0
		UIConst.CacheConfig = {}
	else
		UIConst.CacheDefaultTime = 0
		UIConst.CacheMaxNumber = 3
		UIConst.CacheConfig = {
			mainMenu = 30,
			mainStageDlg = 120,
			battleMainDlg = 30
		}
	end
end

local _isiPhoneWithNotch

DeviceHelper._debugiPhoneWithNotch = nil

function DeviceHelper.isiPhoneWithNotch()
	if DeviceHelper._debugiPhoneWithNotch ~= nil then
		return DeviceHelper._debugiPhoneWithNotch
	end

	if _isiPhoneWithNotch == nil then
		_isiPhoneWithNotch = false

		if DeviceHelper.isIOS() then
			local unityNotch = ScreenUtils.GetUnityNotch()

			if unityNotch > 0.001 then
				_isiPhoneWithNotch = true
			end
		end
	end

	return _isiPhoneWithNotch
end

DeviceHelper.GC_PERIOD = 600

function DeviceHelper._onGCTimer()
	Framework.Tools.LuaToolkit.UnityGC()
end

DeviceHelper._gcTimer = Timer.New(DeviceHelper._onGCTimer, DeviceHelper.GC_PERIOD, -1)

function DeviceHelper.resetGCTimer()
	if VersionUtils.hasAbilityUnityGC() then
		DeviceHelper._gcTimer:Restart()
	end
end

return DeviceHelper
