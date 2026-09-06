-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/hardwarequality/HardwareQualityRecommend.lua

module("logiccommon.common.hardwarequality.HardwareQualityRecommend", package.seeall)

local HardwareQualityRecommend = class("HardwareQualityRecommend")

HardwareQualityRecommend.Tier = {
	High = "High",
	Medium = "Medium",
	Low = "Low",
	Ultra = "Ultra"
}
HardwareQualityRecommend.SettingKey = {
	MaxPlayers = "maxPlayers",
	Resolution = "resolution",
	SceneQuality = "sceneQuality",
	FrameRateType = "frameRateType",
	BloomSwitch = "bloomSwitch"
}

function HardwareQualityRecommend:ctor()
	self._recommendation = nil
	self._deviceProfile = nil
	self._deviceTier = nil
end

function HardwareQualityRecommend:_getSystemInfoNumber(systemInfo, key)
	if not systemInfo then
		return 0
	end

	if key == "systemMemorySize" then
		return checknumber(systemInfo.systemMemorySize)
	elseif key == "processorCount" then
		return checknumber(systemInfo.processorCount)
	elseif key == "processorFrequency" then
		return checknumber(systemInfo.processorFrequency)
	elseif key == "graphicsShaderLevel" then
		return checknumber(systemInfo.graphicsShaderLevel)
	elseif key == "graphicsMemorySize" then
		return checknumber(systemInfo.graphicsMemorySize)
	end

	return 0
end

function HardwareQualityRecommend:getDeviceProfile()
	if self._deviceProfile then
		return self._deviceProfile
	end

	if UnityEngine then
		if not UnityEngine.SystemInfo then
			local systemInfo
			local screenWidth = 0
			local screenHeight = 0

			if SceneResolution and SceneResolution.Instance then
				screenWidth, screenHeight = SceneResolution.Instance:GetOriginalResolution(0, 0)
			end

			local var_3_1 = {
				platform = Framework.OSDef.RunOS
			}

			if systemInfo then
				var_3_1.deviceModel = systemInfo.deviceModel or ""
			end

			var_3_1.systemMemorySize = self:_getSystemInfoNumber(systemInfo, "systemMemorySize")
			var_3_1.processorCount = self:_getSystemInfoNumber(systemInfo, "processorCount")
			var_3_1.processorFrequency = self:_getSystemInfoNumber(systemInfo, "processorFrequency")
			var_3_1.graphicsShaderLevel = self:_getSystemInfoNumber(systemInfo, "graphicsShaderLevel")
			var_3_1.graphicsMemorySize = self:_getSystemInfoNumber(systemInfo, "graphicsMemorySize")
			var_3_1.screenWidth = checknumber(screenWidth)
			var_3_1.screenHeight = checknumber(screenHeight)
			self._deviceProfile = var_3_1

			return self._deviceProfile
		end
	end
end

function HardwareQualityRecommend:getDeviceTier()
	if self._deviceTier then
		return self._deviceTier
	end

	local profile = self:getDeviceProfile()

	self._deviceTier = profile.platform == Framework.OSDef.Android and self:_getAndroidTier(profile) or profile.platform == Framework.OSDef.IOS and self:_getIOSTier(profile) or self:_getPCTier(profile)

	return self._deviceTier
end

function HardwareQualityRecommend:getRecommendation()
	if self._recommendation then
		return self._recommendation
	end

	local profile = self:getDeviceProfile()
	local tier = self:getDeviceTier()

	self._recommendation = self:_buildRecommendationByTier(tier, profile.platform)

	return self._recommendation
end

function HardwareQualityRecommend:getRecommendedValue(settingKey)
	local recommendation = self:getRecommendation()

	return (recommendation or nil) and (recommendation[settingKey] or nil)
end

function HardwareQualityRecommend:isRecommended(settingKey, value)
	return self:getRecommendedValue(settingKey) == value
end

function HardwareQualityRecommend:_getAndroidTier(profile)
	local score = self:_getMemoryScore(profile.systemMemorySize) + self:_getCPUScore(profile.processorCount, profile.processorFrequency) + self:_getShaderScore(profile.graphicsShaderLevel) + self:_getGraphicsMemoryScore(profile.graphicsMemorySize)

	if profile.systemMemorySize > 0 and profile.systemMemorySize < 3000 then
		return HardwareQualityRecommend.Tier.Low
	end

	if profile.graphicsShaderLevel > 0 and profile.graphicsShaderLevel < 35 then
		return HardwareQualityRecommend.Tier.Low
	end

	return self:_getTierByScore(score)
end

function HardwareQualityRecommend:_getIOSTier(profile)
	if not profile.deviceModel then
		local modelNum = checknumber(string.match(profile.deviceModel, "iPhone(%d+)") or string.match(profile.deviceModel, "iPad(%d+)"))

		if string.find(profile.deviceModel, "iPhone") then
			if modelNum >= 15 then
				return HardwareQualityRecommend.Tier.Ultra
			elseif modelNum >= 12 then
				return HardwareQualityRecommend.Tier.High
			elseif modelNum >= 10 then
				return HardwareQualityRecommend.Tier.Medium
			else
				return HardwareQualityRecommend.Tier.Low
			end
		elseif string.find(profile.deviceModel, "iPad") then
			if modelNum >= 13 then
				return HardwareQualityRecommend.Tier.Ultra
			elseif modelNum >= 12 then
				return HardwareQualityRecommend.Tier.High
			elseif modelNum >= 8 then
				return HardwareQualityRecommend.Tier.Medium
			else
				return HardwareQualityRecommend.Tier.Low
			end
		end

		if profile.systemMemorySize > 0 and profile.systemMemorySize < 2000 then
			return HardwareQualityRecommend.Tier.Low
		elseif profile.systemMemorySize >= 4000 then
			return HardwareQualityRecommend.Tier.High
		end

		return HardwareQualityRecommend.Tier.Medium
	end
end

function HardwareQualityRecommend:_getPCTier(profile)
	local score = self:_getMemoryScore(profile.systemMemorySize) + self:_getCPUScore(profile.processorCount, profile.processorFrequency) + self:_getShaderScore(profile.graphicsShaderLevel) + self:_getGraphicsMemoryScore(profile.graphicsMemorySize)

	if profile.systemMemorySize > 0 and profile.systemMemorySize < 4000 then
		return HardwareQualityRecommend.Tier.Low
	end

	return self:_getTierByScore(score)
end

function HardwareQualityRecommend:_getMemoryScore(memorySize)
	if memorySize >= 8000 then
		return 30
	elseif memorySize >= 6000 then
		return 24
	elseif memorySize >= 4000 then
		return 18
	elseif memorySize >= 3000 then
		return 12
	elseif memorySize > 0 then
		return 6
	end

	return 12
end

function HardwareQualityRecommend:_getCPUScore(processorCount, processorFrequency)
	if processorCount >= 8 and processorFrequency >= 2200 then
		return 25
	elseif processorCount >= 8 and processorFrequency >= 1800 then
		return 20
	elseif processorCount >= 6 then
		return 14
	elseif processorCount > 0 then
		return 8
	end

	return 10
end

function HardwareQualityRecommend:_getShaderScore(shaderLevel)
	if shaderLevel >= 50 then
		return 25
	elseif shaderLevel >= 45 then
		return 18
	elseif shaderLevel >= 35 then
		return 10
	elseif shaderLevel > 0 then
		return 4
	end

	return 10
end

function HardwareQualityRecommend:_getGraphicsMemoryScore(graphicsMemorySize)
	if graphicsMemorySize >= 4000 then
		return 20
	elseif graphicsMemorySize >= 2000 then
		return 14
	elseif graphicsMemorySize >= 1000 then
		return 8
	elseif graphicsMemorySize > 0 then
		return 5
	end

	return 10
end

function HardwareQualityRecommend:_getTierByScore(score)
	if score >= 85 then
		return HardwareQualityRecommend.Tier.Ultra
	elseif score >= 70 then
		return HardwareQualityRecommend.Tier.High
	elseif score >= 45 then
		return HardwareQualityRecommend.Tier.Medium
	end

	return HardwareQualityRecommend.Tier.Low
end

function HardwareQualityRecommend:_buildRecommendationByTier(tier, platform)
	if tier == HardwareQualityRecommend.Tier.Low then
		return self:_buildRecommendation(HardwareQuality.FrameRateLevelType.Low[1], HardwareQuality.ResolutionLevelType.Low, HardwareQuality.QualityLevelType.Low, HardwareQuality.GlowLevelType.Close, 5)
	elseif tier == HardwareQualityRecommend.Tier.Medium then
		return self:_buildRecommendation(HardwareQuality.FrameRateLevelType.Medium[1], HardwareQuality.ResolutionLevelType.Medium, HardwareQuality.QualityLevelType.Medium, HardwareQuality.GlowLevelType.Close, 12)
	elseif tier == HardwareQualityRecommend.Tier.High then
		return self:_buildRecommendation(HardwareQuality.FrameRateLevelType.High[1], HardwareQuality.ResolutionLevelType.High, HardwareQuality.QualityLevelType.High, HardwareQuality.GlowLevelType.Open, 18)
	end

	return self:_buildRecommendation(HardwareQuality.FrameRateLevelType.Ultra[1], HardwareQuality.ResolutionLevelType.High, HardwareQuality.QualityLevelType.High, HardwareQuality.GlowLevelType.Open, HardwareQuality.MaxPlayerNum)
end

function HardwareQualityRecommend:_buildRecommendation(frameRateType, resolution, sceneQuality, bloomSwitch, maxPlayers)
	return {
		[HardwareQualityRecommend.SettingKey.FrameRateType] = frameRateType,
		[HardwareQualityRecommend.SettingKey.Resolution] = resolution,
		[HardwareQualityRecommend.SettingKey.SceneQuality] = sceneQuality,
		[HardwareQualityRecommend.SettingKey.BloomSwitch] = bloomSwitch,
		[HardwareQualityRecommend.SettingKey.MaxPlayers] = maxPlayers
	}
end

HardwareQualityRecommend.instance = HardwareQualityRecommend.New()

return HardwareQualityRecommend
