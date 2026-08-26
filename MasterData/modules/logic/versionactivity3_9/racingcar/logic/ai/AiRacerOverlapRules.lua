-- chunkname: @modules/logic/versionactivity3_9/racingcar/logic/ai/AiRacerOverlapRules.lua

local AiRacerOverlapRules = {}

local function isFiniteNumber(value)
	return type(value) == "number" and value == value and value ~= math.huge and value ~= -math.huge
end

function AiRacerOverlapRules.ResolveRubberBandConfig(rawValue, defaultStartGap, defaultRampDistance, defaultMaxMultiplier)
	local startText, rampText, maxText

	if type(rawValue) == "string" then
		startText, rampText, maxText = string.match(rawValue, "^%s*([^#]+)%s*#%s*([^#]+)%s*#%s*([^#]+)%s*$")
	end

	local startGap = tonumber(startText)
	local rampDistance = tonumber(rampText)
	local maxMultiplier = tonumber(maxText)
	local isValid = isFiniteNumber(startGap) and isFiniteNumber(rampDistance) and isFiniteNumber(maxMultiplier) and startGap >= 0 and rampDistance > 0 and maxMultiplier >= 1

	if not isValid then
		return defaultStartGap, defaultRampDistance, defaultMaxMultiplier
	end

	return startGap, rampDistance, maxMultiplier
end

function AiRacerOverlapRules.CalculateCatchUpMultiplier(playerGap, startGap, rampDistance, maxMultiplier)
	local var_3_0

	if not tonumber(playerGap) then
		::label_3_0::

		playerGap = 0
		var_3_0 = tonumber(startGap) or 0
	end

	startGap = math.max(0, var_3_0)
	rampDistance = math.max(0.0001, tonumber(rampDistance) or 0)
	maxMultiplier = math.max(1, tonumber(maxMultiplier) or 1)

	if playerGap <= startGap then
		return 1
	end

	local catchUpProgress = math.min(1, math.max(0, (playerGap - startGap) / rampDistance))

	return 1 + (maxMultiplier - 1) * catchUpProgress
end

function AiRacerOverlapRules.NormalizeDistance(distance, startDistance, trackLength, isLoop)
	distance = distance or 0
	startDistance = startDistance or 0
	trackLength = trackLength or 0

	if not isLoop or trackLength <= 0 then
		return distance
	end

	local relative = (distance - startDistance) % trackLength

	if relative < 0 then
		relative = relative + trackLength
	end

	return startDistance + relative
end

function AiRacerOverlapRules.SignedGap(selfDistance, otherDistance, startDistance, trackLength, isLoop)
	if not isLoop or not trackLength or trackLength <= 0 then
		return (otherDistance or 0) - (selfDistance or 0)
	end

	local selfLocal = AiRacerOverlapRules.NormalizeDistance(selfDistance, startDistance, trackLength, true)
	local otherLocal = AiRacerOverlapRules.NormalizeDistance(otherDistance, startDistance, trackLength, true)
	local delta = otherLocal - selfLocal
	local halfLength = trackLength * 0.5

	if halfLength < delta then
		delta = delta - trackLength
	elseif delta < -halfLength then
		delta = delta + trackLength
	end

	return delta
end

function AiRacerOverlapRules.IsLaneOccupied(lane, currentLane, targetLane, isChangingLane)
	if lane == currentLane then
		return true
	end

	return isChangingLane and lane == targetLane
end

function AiRacerOverlapRules.ShouldYieldForRearApproach(signedPlayerGap, playerSpeed, aiSpeed, watchDistance)
	signedPlayerGap = signedPlayerGap or 0
	watchDistance = math.max(0, watchDistance or 0)

	return signedPlayerGap < 0 and watchDistance >= -signedPlayerGap and (playerSpeed or 0) > (aiSpeed or 0)
end

function AiRacerOverlapRules.ClampFollowerSpeed(desiredSpeed, leaderSpeed, forwardGap, safetyDistance, deltaTime, recoveryMultiplier)
	desiredSpeed = math.max(0, desiredSpeed or 0)
	leaderSpeed = math.max(0, leaderSpeed or 0)
	forwardGap = forwardGap or 0
	safetyDistance = math.max(0, safetyDistance or 0)
	deltaTime = math.max(0.0001, deltaTime or 0)
	recoveryMultiplier = math.max(0, recoveryMultiplier or 0)

	if forwardGap <= 0 then
		return desiredSpeed
	end

	if forwardGap < safetyDistance then
		return math.min(desiredSpeed, leaderSpeed * recoveryMultiplier)
	end

	local spareDistance = math.max(0, forwardGap - safetyDistance)
	local maxSafeSpeed = leaderSpeed + spareDistance / deltaTime

	return math.min(desiredSpeed, maxSafeSpeed)
end

function AiRacerOverlapRules.ResolveRecoveryExpectedSpeed(normalExpected, baseMaxSpeed, recoveryMultiplier)
	normalExpected = math.max(0, normalExpected or 0)
	baseMaxSpeed = math.max(0, baseMaxSpeed or 0)
	recoveryMultiplier = math.max(1, recoveryMultiplier or 1)

	local recoveryCandidate = normalExpected * recoveryMultiplier
	local recoveryCap = baseMaxSpeed * recoveryMultiplier

	return math.max(normalExpected, math.min(recoveryCandidate, recoveryCap))
end

function AiRacerOverlapRules.UpdateRecoveryDebt(debt, deltaTime, maxDebt, playerReducedSpeed, recoveryApplied, canUpdate)
	debt = math.max(0, debt or 0)

	if not canUpdate then
		return debt
	end

	deltaTime = math.max(0, deltaTime or 0)

	if playerReducedSpeed then
		return math.min(math.max(0, maxDebt or 0), debt + deltaTime)
	end

	if recoveryApplied then
		return math.max(0, debt - deltaTime)
	end

	return debt
end

function AiRacerOverlapRules.IsMainLaneOccupancyEligible(normalizedRouteId, isNormalShortcut, isAirborne)
	return normalizedRouteId == "main" and not isNormalShortcut and not isAirborne
end

return AiRacerOverlapRules
