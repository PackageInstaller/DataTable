-- chunkname: @modules/logic/versionactivity3_9/racingcar/logic/RacingPerfectDodgeRules.lua

module("modules.logic.versionactivity3_9.racingcar.logic.RacingPerfectDodgeRules", package.seeall)

local RacingPerfectDodgeRules = class("RacingPerfectDodgeRules")

function RacingPerfectDodgeRules.FindCandidate(playerDistance, currentLane, destinationLane, windowDistance, trackLength, isLoop, obstacles)
	local values = obstacles or {}
	local bestIndex = -1
	local bestDistance = math.huge

	for index = 1, #values do
		local obstacle = values[index]

		if obstacle.lane == currentLane then
			local forwardDistance = obstacle.distance - playerDistance

			if isLoop and trackLength > 0 and forwardDistance <= 0 then
				forwardDistance = forwardDistance + trackLength
			end

			if forwardDistance > 0.001 and forwardDistance <= windowDistance then
				local destinationBlocked = false

				for otherIndex = 1, #values do
					local other = values[otherIndex]

					if other.groupId == obstacle.groupId and other.lane == destinationLane then
						destinationBlocked = true

						break
					end
				end

				if not destinationBlocked and forwardDistance < bestDistance then
					bestDistance = forwardDistance
					bestIndex = index
				end
			end
		end
	end

	return bestIndex
end

return RacingPerfectDodgeRules
