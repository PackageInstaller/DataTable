-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/gfx/GfxGradeUtil.lua

module("logic.common.gfx.GfxGradeUtil", package.seeall)

local M = {}
local Const = GfxConst
local GPU_STANDARD = {
	mali_t = {},
	powervr = {},
	mali_g = {
		58,
		77
	},
	mali_g_3 = {
		510,
		610
	},
	adreno = {
		618,
		640
	},
	apple_a = {
		11,
		13
	},
	apple_m = {
		1,
		1
	}
}
local GPU_LOOKUP_TABLE = {
	adreno = {
		[2] = {
			"540"
		}
	},
	nvidia = {
		[2] = {
			"k1"
		},
		[3] = {
			"x1"
		}
	},
	xclipse = {
		[3] = {
			"920"
		}
	}
}
local OTHER_STANDARD_ANDROID = {
	[2] = {
		frequency = 2100,
		memory = 4
	},
	[3] = {
		frequency = 2500,
		memory = 6
	}
}
local OSDef = Astral.OSDef
local SystemInfo = UnityEngine.SystemInfo

function M.autoJudgeGfxLevel()
	local gfxLevel = GfxConfig.QUALITY.max_high

	if isInEditorMode and Const.EDITOR_USE_MAX_QUALITY then
		PlayerLocalStorageModel.instance:setResolutionRatioQuality(gfxLevel.level)

		return gfxLevel
	end

	local userQualityIndex = PlayerLocalStorageModel.instance:getGraphicsQualityLevel()

	if userQualityIndex > 0 then
		gfxLevel = GfxConfig.ALL_LEVEL[userQualityIndex] or gfxLevel

		return gfxLevel
	end

	if OSDef.RunOS == OSDef.Android then
		gfxLevel = M._judgeForAndroid()
	elseif OSDef.RunOS == OSDef.IOS then
		gfxLevel = M._judgeForIOS()
	end

	return gfxLevel
end

function M.getRecommendLevel()
	local gfxRecommendLevel = GfxConfig.QUALITY.max_high

	if OSDef.RunOS == OSDef.Android then
		gfxRecommendLevel = M._judgeForAndroid()
	elseif OSDef.RunOS == OSDef.IOS then
		gfxRecommendLevel = M._judgeForIOS()
	end

	return gfxRecommendLevel
end

function M._judgeForAndroid()
	local level = GfxConfig.QUALITY.max_high.level

	if not DeviceUtil.isEmulator() then
		level = M._getGPULevel()
		level = M._tryDowngrade(level)

		if enableDebug then
			print("[gfx]judge level is: ", level)
		end
	elseif enableDebug then
		print("[gfx]judge Emulator level is: ", level)
	end

	return GfxConfig.ALL_LEVEL[level] or GfxConfig.QUALITY.high
end

function M._judgeForIOS()
	local level = M._getGPULevel()

	if enableDebug then
		print("[gfx]judge level is: ", level)
	end

	return GfxConfig.ALL_LEVEL[level] or GfxConfig.QUALITY.high
end

function M._getGPULevel()
	local grahpicsDeviceName = SystemInfo.graphicsDeviceName or ""
	local brand, prefix, numberStr = string.match(grahpicsDeviceName, "([%a]+)[%s%p].-(%a*)(%d+)")

	if enableDebug then
		print("[gfx] current device Name is: ", grahpicsDeviceName, brand, prefix, numberStr)
	end

	if brand and prefix and numberStr then
		brand = string.lower(brand)
		prefix = string.lower(prefix)

		local level = M._getGPULevelByMatchName(grahpicsDeviceName, brand, prefix, numberStr)

		if enableDebug then
			print("[gfx] gup level by match: ", level)
		end

		if level == 0 then
			level = M._getGPULevelByCompareNumber(grahpicsDeviceName, brand, prefix, numberStr)

			if enableDebug then
				print("[gfx] gup level by compare: ", level)
			end
		end

		return level
	else
		return GfxConfig.QUALITY.high.level
	end
end

function M._getGPULevelByMatchName(grahpicsDeviceName, brand, prefix, numberStr)
	local brandTbl = GPU_LOOKUP_TABLE[brand]
	local searchName = string.format("%s%s", prefix, numberStr)

	if enableDebug then
		print("[gfx] search name is: ", searchName)
	end

	if brandTbl then
		for level, lookupTbl in pairs(brandTbl) do
			for kIdx = 1, #lookupTbl do
				if lookupTbl[kIdx] == searchName then
					return level
				end
			end
		end
	end

	return 0
end

function M._getGPULevelByCompareNumber(grahpicsDeviceName, brand, prefix, numberStr)
	local level = GfxConfig.QUALITY.high.level
	local standards = M._getGPUStandards(brand, prefix, numberStr)
	local number = tonumber(numberStr)

	if enableDebug then
		print("[gfx] standards: ", standards)
	end

	if standards and number then
		level = 1

		for i = 1, #standards do
			if number >= standards[i] then
				level = level + 1
			else
				break
			end
		end
	end

	return level
end

function M._getGPUStandards(brand, prefix, numberStr)
	local key = brand

	if prefix and string.len(prefix) > 0 then
		key = string.format("%s_%s", brand, prefix)
	end

	local specialKey = string.format("%s_%d", key, string.len(numberStr))

	if GPU_STANDARD[specialKey] then
		key = specialKey
	end

	if enableDebug then
		print("[gfx]standards key is ", key)
	end

	return GPU_STANDARD[key]
end

function M._tryDowngrade(level)
	if level == 1 then
		return level
	end

	local frequency = SystemInfo.processorFrequency
	local totalMemorySize = (SystemInfo.systemMemorySize + SystemInfo.graphicsMemorySize) / 1024
	local standard = OTHER_STANDARD_ANDROID[level]

	if standard then
		if enableDebug then
			print("[gfx]tryDowngrade: ", level, standard.frequency, frequency, standard.memory, totalMemorySize)
		end

		if frequency < standard.frequency or totalMemorySize < standard.memory then
			level = level - 1
		end
	end

	return level
end

function M._isAwesomeMaliGPU()
	local grahpicsDeviceName = SystemInfo.graphicsDeviceName

	if not grahpicsDeviceName then
		return false
	end

	grahpicsDeviceName = string.lower(grahpicsDeviceName)

	if not string.find(grahpicsDeviceName, "mali") then
		return false
	end

	local gpuLevel = M._getGPULevel()

	if enableDebug then
		print("[gfx]find mali gpu level", gpuLevel)
	end

	return gpuLevel >= GfxConfig.QUALITY.high.level
end

return M
