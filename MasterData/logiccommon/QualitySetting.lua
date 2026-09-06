-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/hardwarequality/QualitySetting.lua

module("logiccommon.common.hardwarequality.QualitySetting", package.seeall)

local QualitySetting = class("QualitySetting")

function QualitySetting:ctor()
	self.name = nil
	self.qualityLevel = HardwareQuality.QualityLevelType.Custom
	self.resolution = HardwareQuality.ResolutionLevelType.High
	self.vSyncCount = 0
	self.antiAliasing = 0
	self.frameRate = HardwareQuality.FrameRateLevelType.Ultra[2]
	self.characterShadowQuality = HardwareQuality.QualityLevelType.High
	self.characterMaterialQuality = HardwareQuality.QualityLevelType.High
	self.shaderQuality = HardwareQuality.QualityLevelType.High
	self.textureQuality = HardwareQuality.QualityLevelType.High
	self.showPostProcessingEffects = false
	self.maxPlayers = 6
	self.effectQuality = HardwareQuality.QualityLevelType.High
	self.sceneQuality = HardwareQuality.QualityLevelType.High
	self.bloomSwitch = true
	self.outlineSwitch = false
	self.dynamicResolution = false
	self.frameRateType = HardwareQuality.FrameRateLevelType.Ultra[1]
end

function QualitySetting:clone(quality)
	self.name = quality.name
	self.qualityLevel = quality.qualityLevel
	self.resolution = quality.resolution
	self.vSyncCount = quality.vSyncCount
	self.frameRate = quality.frameRate
	self.antiAliasing = quality.antiAliasing
	self.characterShadowQuality = quality.characterShadowQuality
	self.characterMaterialQuality = quality.characterMaterialQuality
	self.shaderQuality = quality.shaderQuality
	self.textureQuality = quality.textureQuality
	self.showPostProcessingEffects = quality.showPostProcessingEffects
	self.maxPlayers = quality.maxPlayers
	self.effectQuality = quality.effectQuality
	self.sceneQuality = quality.sceneQuality
	self.bloomSwitch = quality.bloomSwitch
	self.outlineSwitch = quality.outlineSwitch
	self.dynamicResolution = quality.dynamicResolution
	self.frameRateType = quality.frameRateType
end

function QualitySetting:equal(quality)
	return self.name == quality.name
end

return QualitySetting
