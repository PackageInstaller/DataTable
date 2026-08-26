-- chunkname: @modules/common/global/screen/GameScreenState.lua

module("modules.common.global.screen.GameScreenState", package.seeall)

local GameScreenState = class("GameScreenState")

function GameScreenState:ctor()
	if SDKMgr.instance:isEmulator() then
		UnityEngine.QualitySettings.resolutionScalingFixedDPIFactor = 10
	end

	if SLFramework.FrameworkSettings.IsEditor then
		local grade = PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewQuality, ModuleEnum.Performance.High)
		local targetFrameRate = PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewTargetFrameRate, ModuleEnum.TargetFrameRate.High)

		self:setLocalQuality(grade)
		self:setTargetFrameRate(targetFrameRate)
	else
		local performanceGrade = HardwareUtil.getPerformanceGrade()
		local grade = PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewQuality, nil)

		grade = grade or performanceGrade

		local targetFrameRate = PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewTargetFrameRate, nil)

		targetFrameRate = targetFrameRate or performanceGrade == ModuleEnum.Performance.High and ModuleEnum.TargetFrameRate.High or ModuleEnum.TargetFrameRate.Low

		self:setLocalQuality(grade)
		self:setTargetFrameRate(targetFrameRate)
		MainController.instance:registerCallback(MainEvent.OnFirstEnterMain, self._onFirstEnterMain, self)
	end

	self._width, self._height = SettingsModel.instance:getCurrentScreenSize()

	ZProj.ScreenSizeMgr.Instance:SetLuaCallback(self._onResolutionChange, self)
end

function GameScreenState:_onFirstEnterMain()
	if SLFramework.FrameworkSettings.IsEditor then
		return
	end

	MainController.instance:unregisterCallback(MainEvent.OnFirstEnterMain, self._onFirstEnterMain, self)

	local hasCheck = PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMCollectCPUGPU, nil)

	if not hasCheck then
		PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMCollectCPUGPU, 1)

		local cpuName = BootNativeUtil.getCpuName()
		local gpuName = UnityEngine.SystemInfo.graphicsDeviceName
		local cpuLevel = CommonConfig.instance:getCPULevel(cpuName or "")
		local gpuLevel = CommonConfig.instance:getGPULevel(gpuName or "")

		if cpuLevel == ModuleEnum.Performance.Undefine or gpuLevel == ModuleEnum.Performance.Undefine then
			GMRpc.instance:sendGpuCpuLogRequest(cpuName, gpuName)
		end
	end
end

function GameScreenState:getLocalQuality()
	return self.grade
end

function GameScreenState:getTargetFrameRate()
	return self.targetFrameRate
end

function GameScreenState:setLocalQuality(grade, dontSave)
	self.grade = grade

	if not dontSave then
		PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewQuality, grade)
	end

	local qualityLevel = 2
	local renderScale = 1
	local maxLod = 300

	if BootNativeUtil.isWindows() then
		UnityEngine.QualitySettings.vSyncCount = 1
	else
		UnityEngine.QualitySettings.vSyncCount = 0

		local deviceName = UnityEngine.SystemInfo.deviceModel

		if deviceName:find("Huawei Tablet M5") or deviceName:find("bah2-w09") then
			UnityEngine.QualitySettings.vSyncCount = 1
		end
	end

	local fileReadMaxCount = 8

	if grade == ModuleEnum.Performance.Low then
		UnityEngine.Graphics.activeTier = UnityEngine.Rendering.GraphicsTier.Tier1
		maxLod = 100
		fileReadMaxCount = 8
	elseif grade == ModuleEnum.Performance.Middle then
		UnityEngine.Graphics.activeTier = UnityEngine.Rendering.GraphicsTier.Tier2
		maxLod = 150
		fileReadMaxCount = 10
	else
		UnityEngine.Graphics.activeTier = UnityEngine.Rendering.GraphicsTier.Tier3
		maxLod = 300
		fileReadMaxCount = 12
	end

	UnityEngine.QualitySettings.SetQualityLevel(qualityLevel, true)
	PostProcessingMgr.instance:setMainPPLevel(grade)
	CameraMgr.instance:setRenderScale(renderScale)

	UnityEngine.Shader.globalMaximumLOD = maxLod

	GameResMgr:SetMaxFileLoadingCount(fileReadMaxCount)
	GameGlobalMgr.instance:dispatchEvent(GameStateEvent.OnQualityChange)
end

function GameScreenState:resetMaxFileLoadingCount()
	GameResMgr:SetMaxFileLoadingCount(self.grade == ModuleEnum.Performance.Low and 8 or self.grade == ModuleEnum.Performance.Middle and 10 or 12)
end

function GameScreenState:setTargetFrameRate(targetFrameRate, dontSave)
	self.targetFrameRate = targetFrameRate

	if not dontSave then
		PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewTargetFrameRate, targetFrameRate)
	end

	UnityEngine.Application.targetFrameRate = targetFrameRate
end

function GameScreenState:_onResolutionChange(width, height)
	self._width = width
	self._height = height

	TaskDispatcher.cancelTask(self._delayDispatchResizeEvent, self)
	TaskDispatcher.runDelay(self._delayDispatchResizeEvent, self, 0.01)
	self:_setSoftMaskEnable(false)
end

function GameScreenState:_delayDispatchResizeEvent()
	self:_setSoftMaskEnable(true)
	GameGlobalMgr.instance:dispatchEvent(GameStateEvent.OnScreenResize, self._width, self._height)
end

function GameScreenState:_setSoftMaskEnable(enable)
	local uiRoot = ViewMgr.instance:getUIRoot()
	local softMaskList = uiRoot:GetComponentsInChildren(typeof(Coffee.UISoftMask.SoftMask), false)

	for i = 0, softMaskList.Length - 1 do
		local softMask = softMaskList[i]

		softMask.enabled = enable
	end
end

function GameScreenState:getScreenSize()
	return self._width, self._height
end

return GameScreenState
