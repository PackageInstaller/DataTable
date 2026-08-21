-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/gfx/GfxConfig.lua

module("logic.common.gfx.GfxConfig", package.seeall)

local Const = require("logic.common.gfx.GfxConst")
local OSDef = Astral.OSDef
local M = {}

M.QUALITY = {
	low = {
		minRenderScale = -1,
		name = "Low",
		uiRenderScale = 0.8,
		uiPostProcessing = false,
		xinmaoLight = false,
		logicUpdateInternal = 0.05555555555555555,
		level = 1,
		supportHdr = false,
		resolution = Const.Resolution.Low,
		frameRate = Const.FrameCount.Low,
		assetUrl = CommonResPath.URPAssetLow,
		renderQuality = Const.RenderQuality.Low,
		effectQuality = Const.EffectQuality.Low,
		antialiasingMode = Const.AntialiasingMode.SubpixelMorphologicalAntiAliasing,
		antialiasingQuality = Const.AntialiasingQuality.Low,
		massQuality = Const.MsaaQuality.Disabled,
		rtQuality = Const.RTQuality.Low
	},
	middle = {
		minRenderScale = -1,
		name = "Medium",
		uiRenderScale = 1,
		uiPostProcessing = false,
		xinmaoLight = false,
		logicUpdateInternal = 0.041666666666666664,
		level = 2,
		supportHdr = true,
		resolution = Const.Resolution.High,
		frameRate = Const.FrameCount.Low,
		assetUrl = CommonResPath.URPAssetMedium,
		renderQuality = Const.RenderQuality.Middle,
		effectQuality = Const.EffectQuality.Low,
		antialiasingMode = Const.AntialiasingMode.SubpixelMorphologicalAntiAliasing,
		antialiasingQuality = Const.AntialiasingQuality.Low,
		massQuality = Const.MsaaQuality.Disabled,
		rtQuality = Const.RTQuality.Middle
	},
	high = {
		name = "High",
		uiRenderScale = 1,
		uiPostProcessing = false,
		supportHdr = true,
		minRenderScale = -1,
		xinmaoLight = true,
		logicUpdateInternal = 0.03333333333333333,
		level = 3,
		resolution = Const.Resolution.VeryHigh,
		frameRate = Const.FrameCount.Low,
		assetUrl = CommonResPath.URPAssetHigh,
		renderQuality = Const.RenderQuality.High,
		effectQuality = Const.EffectQuality.High,
		antialiasingMode = Const.AntialiasingMode.None,
		massQuality = Const.MsaaQuality._2x,
		rtQuality = Const.RTQuality.High
	},
	max_high = {
		name = "Very High",
		uiRenderScale = 1,
		uiPostProcessing = false,
		supportHdr = true,
		minRenderScale = 0.8,
		xinmaoLight = true,
		logicUpdateInternal = 0.016666666666666666,
		level = 4,
		resolution = Const.Resolution.VeryHigh,
		frameRate = Const.FrameCount.Low,
		assetUrl = CommonResPath.URPAssetMaxHigh,
		renderQuality = Const.RenderQuality.MaxHigh,
		effectQuality = Const.EffectQuality.High,
		antialiasingMode = Const.AntialiasingMode.None,
		massQuality = Const.MsaaQuality._4x,
		rtQuality = Const.RTQuality.High
	}
}
M.REPLACE_SETTING = {
	PC = {
		[M.QUALITY.max_high] = {
			frameRate = Const.FrameCount.High
		}
	},
	MALI = {
		[M.QUALITY.high] = {
			massQuality = Const.MsaaQuality._4x,
			antialiasingMode = Const.AntialiasingMode.None,
			resolution = Const.Resolution.High
		},
		[M.QUALITY.max_high] = {
			massQuality = Const.MsaaQuality._4x,
			antialiasingMode = Const.AntialiasingMode.None
		}
	}
}
M.ALL_LEVEL = {
	M.QUALITY.low,
	M.QUALITY.middle,
	M.QUALITY.high,
	M.QUALITY.max_high
}
M.FRAME_LEVEL = {
	Const.FrameCount.Low,
	Const.FrameCount.Middle,
	Const.FrameCount.High
}
M.RESOLUTION_LEVEL = {
	Const.Resolution.VeryLow,
	Const.Resolution.Low,
	Const.Resolution.Middle,
	Const.Resolution.High,
	Const.Resolution.VeryHigh
}

function M.index2GfxLevel(index)
	return M.ALL_LEVEL[index] or M.QUALITY.middle
end

function M.gfxLevel2Index(gfxLevel)
	return M.ALL_LEVEL[gfxLevel.level] or M.QUALITY.middle
end

function M.index2FrameRate(index)
	return M.FRAME_LEVEL[index] or M.FRAME_LEVEL[1]
end

function M.index2Resolution(index)
	return M.RESOLUTION_LEVEL[index] or M.RESOLUTION_LEVEL[1]
end

function M.frameRate2Index(frameRate)
	for k, v in pairs(M.FRAME_LEVEL) do
		if v == frameRate then
			return k
		end
	end

	return frameRate > Const.FrameCount.Low and 2 or 1
end

function M.resolution2Index(resolution)
	for k, v in pairs(M.RESOLUTION_LEVEL) do
		if v == resolution then
			return k
		end
	end

	return 1
end

function M.getGraphicsSettingInfo(quality)
	local cur = M.ALL_LEVEL[quality]

	if cur then
		local gfxIndex = M.gfxLevel2Index(cur)

		return M.resolution2Index(gfxIndex.resolution), gfxIndex.effectQuality, M.frameRate2Index(cur.frameRate), true, cur.supportHdr
	end
end

function M.syncReplaceSetting()
	if OSDef.RunOS == OSDef.Win32 then
		for k, v in pairs(M.REPLACE_SETTING.PC) do
			for k1, v1 in pairs(v) do
				k[k1] = v1
			end
		end
	end

	if OSDef.RunOS == OSDef.Android and GfxGradeUtil._isAwesomeMaliGPU() then
		for k, v in pairs(M.REPLACE_SETTING.MALI) do
			for k1, v1 in pairs(v) do
				k[k1] = v1
			end
		end
	end
end

return M
