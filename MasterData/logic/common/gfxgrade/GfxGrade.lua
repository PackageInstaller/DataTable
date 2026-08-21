-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/gfxgrade/GfxGrade.lua

module("logic.common.gfxgrade.GfxGrade", package.seeall)

local GfxGrade = {}
local RESOLUTION_KEY = "RESOLUTION_KEY_SETTINGS"
local MAX_PLAYERS_KEY = "MAX_PLAYERS_KEY_SETTINGS"
local SHOW_SCENE_EFFECTS_KEY = "SHOW_SCENE_EFFECTS_KEY_SETTINGS"
local FRAME_RATE_KEY = "FRAME_RATE_KEY_SETTINGS"

GfxGrade.LOW_QUALITY = 1
GfxGrade.MIDDLE_QUALITY = 2
GfxGrade.HIGH_QUALITY = 3
GfxGrade.LOW_MEMORY = 1
GfxGrade.MIDDLE_MEMORY = 2
GfxGrade.HIGH_MEMORY = 3
GfxGrade.LOW = nil
GfxGrade.MIDDLE = nil
GfxGrade.HIGH = nil
GfxGrade.FRAME_LOW = 30
GfxGrade.FRAME_MID = 30
GfxGrade.FRAME_HIGH = 36
GfxGrade.FRAME_MAX_HIGH = 60

local kResolutionLevel = {
	[0] = 0,
	640,
	720,
	1080
}
local kFrameLevel = {
	GfxGrade.FRAME_LOW,
	GfxGrade.FRAME_HIGH
}

GfxGrade.current = nil
GfxGrade.currentMemory = GfxGrade.HIGH_MEMORY

function GfxGrade.init()
	GfxGrade.current = GfxGradeSetting.New()

	local low = GfxGradeSetting.New()

	low.name = "low"
	low.vSyncCount = 0
	low.resolution = 640
	low.frameRate = GfxGrade.FRAME_LOW
	low.effectQuality = GfxGrade.LOW_QUALITY
	low.quality = GfxGrade.LOW_QUALITY
	GfxGrade.LOW = low

	local middle = GfxGradeSetting.New()

	middle.name = "middle"
	middle.vSyncCount = 0
	middle.resolution = 720
	middle.frameRate = GfxGrade.FRAME_MID
	middle.effectQuality = GfxGrade.MIDDLE_QUALITY
	low.quality = GfxGrade.MIDDLE_QUALITY
	GfxGrade.MIDDLE = middle

	local high = GfxGradeSetting.New()

	high.name = "high"
	high.vSyncCount = 0
	high.resolution = 1080
	high.frameRate = GfxGrade.FRAME_HIGH
	high.effectQuality = GfxGrade.HIGH_QUALITY
	low.quality = GfxGrade.HIGH_QUALITY
	GfxGrade.HIGH = high

	GfxGrade._autoJudge()
	GfxGrade._autoJudgeMemory()
	GfxGrade._addEvent()
end

function GfxGrade._addEvent()
	if not GfxGrade._isAdd then
		GlobalDispatcher:addEventListener(EventType.SETTING_CONTENT_CHANGE, GfxGrade._onSettingContentChanged, GfxGrade)

		GfxGrade._isAdd = true
	end
end

function GfxGrade:_onSettingContentChanged(sender, settingKey, value)
	if settingKey == SettingConst.kResolutionRatioQuality then
		GfxGrade.setQuality(value)
	elseif settingKey == SettingConst.kGameFrame then
		local isHigh = value == GfxGrade.MIDDLE_QUALITY and true or nil

		GfxGrade.setHighFrameRate(isHigh)
	end
end

function GfxGrade.initAndRestoreUserCustomQuality()
	GfxGrade.init()

	if Astral.OSDef.RunOS == "Win32" then
		return
	end

	if GfxGrade.current.resolution > 0 then
		local sheight = UnityEngine.Screen.height
		local percent = GfxGrade.current.resolution / sheight

		SceneResolution.Instance:SetDirectResolution(percent)
	end

	UnityEngine.Application.targetFrameRate = GfxGrade.current.frameRate
end

function GfxGrade.setCurrent(setting)
	GfxGrade.current:clone(setting)
end

function GfxGrade.setQuality(level)
	if level == GfxGrade.LOW_QUALITY then
		GfxGrade.setResolution(GfxGrade.LOW.resolution)
	elseif level == GfxGrade.MIDDLE_QUALITY then
		GfxGrade.setResolution(GfxGrade.MIDDLE.resolution)
	elseif level == GfxGrade.HIGH_QUALITY then
		GfxGrade.setResolution(GfxGrade.HIGH.resolution)
	else
		GfxGrade.setResolution(0)
	end
end

function GfxGrade.getQuality()
	if GfxGrade.getResolution() == 640 then
		return GfxGrade.LOW_QUALITY
	elseif GfxGrade.getResolution() == 720 then
		return GfxGrade.MIDDLE_QUALITY
	else
		return GfxGrade.HIGH_QUALITY
	end
end

function GfxGrade.getRecommendQuality()
	local grade = GfxGrade._getAutoJudge()

	if grade == GfxGrade.LOW then
		return GfxGrade.LOW_QUALITY
	elseif grade == GfxGrade.MIDDLE then
		return GfxGrade.MIDDLE_QUALITY
	else
		return GfxGrade.HIGH_QUALITY
	end
end

function GfxGrade.setHighFrameRate(v)
	if v then
		GfxGrade.setFrameRate(GfxGrade.FRAME_HIGH)
	else
		GfxGrade.setFrameRate(GfxGrade.FRAME_LOW)
	end
end

function GfxGrade.isHighFrameRate()
	return GfxGrade.getFrameRate() > GfxGrade.FRAME_MID
end

function GfxGrade.setFrameRate(v)
	if GfxGrade.current.frameRate ~= v then
		GfxGrade.current.frameRate = v
		UnityEngine.Application.targetFrameRate = v
	end
end

function GfxGrade.getFrameRate()
	return GfxGrade.current.frameRate
end

function GfxGrade.setResolution(resolution)
	if GfxGrade.current.resolution ~= resolution then
		GfxGrade.current.resolution = resolution

		if GfxGrade.current.resolution > 0 then
			local swidth, sheight = SceneResolution.Instance:GetOriginalResolution(0, 0)
			local percent = GfxGrade.current.resolution / sheight

			SceneResolution.Instance:SetDirectResolution(percent, GfxGrade.current.frameRate)
		else
			SceneResolution.Instance:SetDirectResolution(1)
		end
	end
end

function GfxGrade.getResolution()
	return GfxGrade.current.resolution
end

function GfxGrade._autoJudgeMemory()
	local SystemInfo = UnityEngine.SystemInfo
	local systemMemorySize = SystemInfo.systemMemorySize or 0

	if systemMemorySize > 0 and systemMemorySize <= 3600 then
		GfxGrade.currentMemory = GfxGrade.LOW_MEMORY
	else
		GfxGrade.currentMemory = GfxGrade.HIGH_MEMORY
	end

	forcePrint("GfxGrade systemMemorySize is:", systemMemorySize)
end

function GfxGrade._autoJudge()
	local grade = GfxGrade._getAutoJudge()

	GfxGrade.setCurrent(grade)
	GfxGrade._loadUserSettings()
	forcePrint("GfxGrade grade is:", grade.name)
end

function GfxGrade._getAutoJudge()
	local grade = GfxGrade.MIDDLE

	if Astral.OSDef.RunOS == Astral.OSDef.Android then
		grade = GfxGrade._judgeForAndroid()
	elseif Astral.OSDef.RunOS == Astral.OSDef.IOS then
		grade = GfxGrade._judgeForIOS()
	else
		local dpiQuality = PlayerLocalStorageModel.instance:getResolutionRatioQuality()

		if dpiQuality == -1 then
			PlayerLocalStorageModel.instance:setResolutionRatioQuality(GfxGrade.HIGH_QUALITY)
		end
	end

	return grade
end

function GfxGrade._judgeForAndroid()
	local grade = GfxGrade.MIDDLE
	local SystemInfo = UnityEngine.SystemInfo
	local dpiQuality = PlayerLocalStorageModel.instance:getResolutionRatioQuality()
	local resolutionRatioQuality = GfxGrade.MIDDLE_QUALITY

	forcePrint("匹配当前机型分辨率", SystemInfo.graphicsShaderLevel, SystemInfo.systemMemorySize, dpiQuality)

	if SystemInfo.graphicsShaderLevel < 46 then
		grade = GfxGrade.LOW
	elseif SystemInfo.systemMemorySize > 3600 and SystemInfo.graphicsShaderLevel > 50 then
		grade = GfxGrade.HIGH
	end

	if dpiQuality == -1 then
		PlayerLocalStorageModel.instance:setResolutionRatioQuality(grade.quality)
	end

	return grade
end

function GfxGrade._judgeForIOS()
	local grade = GfxGrade.HIGH
	local SystemInfo = UnityEngine.SystemInfo
	local systemMemorySize = SystemInfo.systemMemorySize or 0
	local dpiQuality = PlayerLocalStorageModel.instance:getResolutionRatioQuality()
	local resolutionRatioQuality = GfxGrade.MIDDLE_QUALITY

	forcePrint("匹配当前机型分辨率", systemMemorySize, dpiQuality)

	if systemMemorySize > 0 and systemMemorySize <= 1500 then
		grade = GfxGrade.MIDDLE
	end

	if dpiQuality == -1 then
		PlayerLocalStorageModel.instance:setResolutionRatioQuality(grade.quality)
	end

	return grade
end

function GfxGrade._loadUserSettings()
	local dpiQuality = PlayerLocalStorageModel.instance:getResolutionRatioQuality()
	local resolution = kResolutionLevel[dpiQuality] or kResolutionLevel[1]

	if resolution ~= -1 then
		GfxGrade.current.resolution = resolution
	end

	local gameFrame = PlayerLocalStorageModel.instance:getGameFrame()
	local frameRate = kFrameLevel[gameFrame] or kFrameLevel[1]

	if frameRate ~= -1 then
		GfxGrade.current.frameRate = frameRate
	end
end

return GfxGrade
