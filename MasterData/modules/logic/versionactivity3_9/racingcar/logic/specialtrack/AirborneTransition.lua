-- chunkname: @modules/logic/versionactivity3_9/racingcar/logic/specialtrack/AirborneTransition.lua

module("modules.logic.versionactivity3_9.racingcar.logic.specialtrack.AirborneTransition", package.seeall)

local AirborneTransition = {}
local FastAirborneLaunchReferenceSpeed = 185
local FastAirborneLaunchMinDurationSec = 0.16
local FastAirborneLaunchMaxDurationSec = 1

function AirborneTransition.ResolveFastLaunchDuration(horizontalDistance)
	return Mathf.Clamp(math.max(0, horizontalDistance or 0) / FastAirborneLaunchReferenceSpeed, FastAirborneLaunchMinDurationSec, FastAirborneLaunchMaxDurationSec)
end

return AirborneTransition
