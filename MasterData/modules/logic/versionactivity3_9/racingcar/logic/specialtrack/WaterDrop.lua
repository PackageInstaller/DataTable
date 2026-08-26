-- chunkname: @modules/logic/versionactivity3_9/racingcar/logic/specialtrack/WaterDrop.lua

module("modules.logic.versionactivity3_9.racingcar.logic.specialtrack.WaterDrop", package.seeall)

local WaterDrop = {}
local WaterDropFallDurationScale = 0.7
local WaterDropDefaultTapFallProgressScale = 1
local WaterDropTapSpinSpeedMultiplier = 2
local WaterDropMinBaseSpinSpeedDeg = 120
local WaterDropMinMaxSpinSpeedDeg = 1440
local WaterDropFeedbackAttackDegPerSec = 3000
local WaterDropFeedbackReleaseDegPerSec = 240
local WaterDropFeedbackTier2EnterSpeedDeg = 300
local WaterDropFeedbackTier2ExitSpeedDeg = 240
local WaterDropFeedbackTier3EnterSpeedDeg = 1020
local WaterDropFeedbackTier3ExitSpeedDeg = 900

function WaterDrop.ResolveFallDurations(drop)
	if drop then
		local configuredBaseDuration = math.max(0.001, drop.baseFallDurationSec or 5)

		if drop then
			local configuredMinDuration = math.max(0.001, math.min(configuredBaseDuration, drop.minFallDurationSec or configuredBaseDuration))
			local baseDuration = math.max(0.001, configuredBaseDuration * WaterDropFallDurationScale)
			local minDuration = math.max(0.001, math.min(baseDuration, configuredMinDuration * WaterDropFallDurationScale))

			return baseDuration, minDuration
		end
	end
end

function WaterDrop.ResolveTapProgressAdd(drop)
	if drop then
		local configuredProgressAdd = math.max(0, drop.tapFallProgressAdd or 0)
		local progressScale = drop and drop.tapFallProgressScale

		if progressScale == nil then
			progressScale = WaterDropDefaultTapFallProgressScale
		end

		return configuredProgressAdd * math.max(0, progressScale or 0)
	end
end

function WaterDrop.ResolveTapSpinSpeedAdd(drop)
	return math.max(0, (drop or nil) and (drop.tapSpinSpeedAddDeg or 0)) * WaterDropTapSpinSpeedMultiplier
end

function WaterDrop.ResolveFeedbackSpinSpeed(currentFeedbackSpeedDeg, actualSpinSpeedDeg, deltaTime)
	local current = math.max(0, currentFeedbackSpeedDeg or 0)
	local target = math.max(0, actualSpinSpeedDeg or 0)

	if current < target then
		if not WaterDropFeedbackAttackDegPerSec then
			local rate = WaterDropFeedbackReleaseDegPerSec
			local maxDelta = rate * math.max(0, deltaTime or 0)

			if current < target then
				return math.min(target, current + maxDelta)
			end

			return math.max(target, current - maxDelta)
		end
	end
end

function WaterDrop.ResolveFeedbackTier(currentTier, feedbackSpinSpeedDeg)
	local tier = math.max(1, math.min(3, math.floor((currentTier or 1) + 0.5)))
	local speed = math.max(0, feedbackSpinSpeedDeg or 0)

	if tier >= 3 then
		return speed < WaterDropFeedbackTier3ExitSpeedDeg and 2 or 3
	end

	if tier >= 2 then
		if speed >= WaterDropFeedbackTier3EnterSpeedDeg then
			return 3
		end

		return speed < WaterDropFeedbackTier2ExitSpeedDeg and 1 or 2
	end

	if speed >= WaterDropFeedbackTier3EnterSpeedDeg then
		return 3
	end

	return speed >= WaterDropFeedbackTier2EnterSpeedDeg and 2 or 1
end

function WaterDrop.ResolveMaxSpinSpeed(drop)
	return math.max(WaterDropMinMaxSpinSpeedDeg, math.max(0, (drop or nil) and (drop.maxSpinSpeedDeg or 0)))
end

function WaterDrop.ResolveBaseSpinSpeed(drop)
	return math.max(WaterDropMinBaseSpinSpeedDeg, WaterDrop.ResolveTapSpinSpeedAdd(drop) * 0.25)
end

function WaterDrop.ResolveLandingProgressByRemainingDistance(currentPosition, targetPosition, prepareDistance)
	if not currentPosition or not targetPosition then
		return 0
	end

	local deltaX = (targetPosition.x or 0) - (currentPosition.x or 0)
	local deltaZ = (targetPosition.z or 0) - (currentPosition.z or 0)
	local remainingDistance = math.sqrt(deltaX * deltaX + deltaZ * deltaZ)
	local distanceWindow = math.max(0.01, prepareDistance or 0.01)

	return Mathf.Clamp01(1 - remainingDistance / distanceWindow)
end

return WaterDrop
