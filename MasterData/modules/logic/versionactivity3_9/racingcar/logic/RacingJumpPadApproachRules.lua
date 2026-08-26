-- chunkname: @modules/logic/versionactivity3_9/racingcar/logic/RacingJumpPadApproachRules.lua

module("modules.logic.versionactivity3_9.racingcar.logic.RacingJumpPadApproachRules", package.seeall)

local RacingJumpPadApproachRules = {
	ApproachLiftHeight = 3,
	JumpHandoffProgress = 0.08,
	ApproachCenterLeadDistance = 18
}

local function SmoothStep01(value)
	local t = math.max(0, math.min(1, value or 0))

	return t * t * (3 - 2 * t)
end

function RacingJumpPadApproachRules.ResolveApproachHeight(distance, approachStartDistance, triggerStartDistance)
	local range = math.max(0.0001, (triggerStartDistance or 0) - (approachStartDistance or 0))
	local progress = ((distance or 0) - (approachStartDistance or 0)) / range

	return RacingJumpPadApproachRules.ApproachLiftHeight * SmoothStep01(progress)
end

function RacingJumpPadApproachRules.ResolveJumpHandoffHeight(startHeight, jumpProgress)
	local handoff = math.max(0.0001, RacingJumpPadApproachRules.JumpHandoffProgress)
	local progress = (jumpProgress or 0) / handoff

	return math.max(0, startHeight or 0) * (1 - SmoothStep01(progress))
end

return RacingJumpPadApproachRules
