-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/gfx/GfxModel.lua

module("logic.common.gfx.GfxModel", package.seeall)

local M = class("GfxModel")
local Const = GfxConst

function M:ctor()
	self.current = {}
	self.customSetting = {}
end

function M:setCurrentGfxLevel(fromGfxLevel)
	local current = self.current

	if enableLog then
		print("copy cur gfx level", fromGfxLevel.level)
	end

	for k, v in pairs(fromGfxLevel) do
		current[k] = v
	end
end

function M:getCurGfx()
	return self.current
end

function M:getIsLow()
	return self.current.level == GfxConfig.QUALITY.low.level
end

function M:getIsMiddle()
	return self.current.level == GfxConfig.QUALITY.middle.level
end

function M:getIsHigh()
	return self.current.level == GfxConfig.QUALITY.high.level
end

function M:getIsMaxHigh()
	return self.current.level == GfxConfig.QUALITY.max_high.level
end

function M:getEffectQualityLabel()
	return self.current.effectQuality == Const.EffectQuality.Low and "l" or "h"
end

function M:isSceneOptimizationEnable()
	return self.current.renderQuality < Const.RenderQuality.Middle
end

function M:getRTQuality()
	return self.current.rtQuality
end

function M:clearLocalFrameStorage()
	PlayerLocalStorageModel.instance:setGraphicsSettingQuality(-1)
	PlayerLocalStorageModel.instance:setResolutionRatioQuality(-1)
	PlayerLocalStorageModel.instance:setGameFrame(-1)
	PlayerLocalStorageModel.instance:setEffectQuality(-1)
end

function M:loadAndInitUserSettings()
	local current = self.current
	local userQualityIndex = PlayerLocalStorageModel.instance:getGraphicsQualityLevel()
	local gfxLevel = GfxConfig.index2GfxLevel(userQualityIndex)

	if userQualityIndex > 0 then
		-- block empty
	else
		local gfxIndex = GfxConfig.gfxLevel2Index(current)

		userQualityIndex = gfxIndex.level

		PlayerLocalStorageModel.instance:setGraphicsQualityLevel(gfxIndex.level)
	end

	local userGraphicsIndex = PlayerLocalStorageModel.instance:getGraphicsSettingQuality()

	if userGraphicsIndex < 0 then
		local co = ConstConfig.instance:getFrameSettingByDpi(userQualityIndex)

		PlayerLocalStorageModel.instance:setGraphicsSettingQuality(co and co.typeLevel or 3)
		PlayerLocalStorageModel.instance:setAntialiasingSwitch(current.massQuality ~= Const.MsaaQuality.Disabled)
		PlayerLocalStorageModel.instance:setOpenHdr(current.supportHdr)
		PlayerLocalStorageModel.instance:setPowerSavingSwitch(userQualityIndex == 1)
	end

	local userEffectQuality = PlayerLocalStorageModel.instance:getEffectQuality()

	if userEffectQuality > 0 then
		current.effectQuality = userEffectQuality
	else
		PlayerLocalStorageModel.instance:setEffectQuality(gfxLevel.effectQuality)
	end

	local userFrameRateIndex = PlayerLocalStorageModel.instance:getGameFrame()

	if userFrameRateIndex > 0 then
		local frameRate = GfxConfig.index2FrameRate(userFrameRateIndex)

		current.frameRate = frameRate
	else
		local frameRateIndex = GfxConfig.frameRate2Index(current.frameRate)

		PlayerLocalStorageModel.instance:setGameFrame(frameRateIndex)
	end

	local userResolutionIndex = PlayerLocalStorageModel.instance:getResolutionRatioQuality()

	if userResolutionIndex > 0 then
		current.resolution = GfxConfig.index2Resolution(userResolutionIndex)
	else
		local gfxIndex = GfxConfig.gfxLevel2Index(current)

		PlayerLocalStorageModel.instance:setResolutionRatioQuality(GfxConfig.resolution2Index(gfxIndex.resolution))
	end
end

function M:setCustomSetting(key, value)
	self._customSetting = self._customSetting or {}
	self._customSetting[key] = value
end

function M:syncCustomSetting()
	local current = self.current
	local customSetting = self._customSetting

	for k, v in pairs(customSetting or {}) do
		current[k] = v
	end
end

M.instance = M.New()

return M
