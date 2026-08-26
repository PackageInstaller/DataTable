-- chunkname: @modules/logic/versionactivity3_9/racingcar/logic/ai/AiRacerController.lua

module("modules.logic.versionactivity3_9.racingcar.logic.ai.AiRacerController", package.seeall)

local AiRacerController = class("AiRacerController", RacingVehicleControllerBase)
local AiRacerOverlapRules = require("modules.logic.versionactivity3_9.racingcar.logic.ai.AiRacerOverlapRules")
local LaneCount = 4
local TrackEdgeBuffer = 0.25
local InvulnerabilityFlashHz = 10
local FinishKeepLaneDistance = 160
local DefaultAirborneForwardRollDegreesPerSecond = 540
local LaneDecisionIntervalSec = 1
local LaneDecisionMaxTravelDistance = 40
local LaneLookAheadDistance = 170
local LaneEmergencyDistance = 58
local LaneChangeCost = 5

local function SetVec3(target, x, y, z)
	target.x, target.y, target.z = x, y, z

	return target
end

local RacerSafetyDistanceM = 10
local ForcedYieldSpeedMultiplier = 0.7
local ForcedYieldDurationSec = 0.5
local PlayerBlockRecoveryDebtMaxSec = 1
local TrafficWatchDistanceM = RacerSafetyDistanceM * 3
local TrafficCongestionPenalty = LaneChangeCost + 2
local SpeedComparisonEpsilon = 0.0001
local RacingRubberBandConstId = 1013
local DefaultCatchUpStartGap = 40
local DefaultCatchUpRampDistance = 130
local DefaultCatchUpMaxMultiplier = 1.2
local LeadSlowStartGap = 54
local LeadSlowMaxRatio = 0.25
local LeadSlowRampDistance = 80
local ACTION_STAY = 0
local ACTION_LEFT = 1
local ACTION_RIGHT = 2
local TrackElementType = RacingTrackElementSpawner.TrackElementType
local LaneElementScores = {
	[TrackElementType.Obstacle] = -76,
	[TrackElementType.DangerZone] = -56,
	[TrackElementType.TidalHammer] = -82,
	[TrackElementType.WaterJet] = -52,
	[TrackElementType.MovingBuoyWall] = -68,
	[TrackElementType.ItemPickup] = 38,
	[TrackElementType.BoostPad] = 32,
	[TrackElementType.CoinString] = 13
}

function AiRacerController:init(go)
	AiRacerController.super.init(self, go)

	self._go = go

	if go then
		self._transform = go.transform or nil
	end

	self._poseCache = {
		center = {},
		tangent = {},
		normal = {},
		position = {}
	}
	self._futurePoseCache = {
		center = {},
		tangent = {},
		normal = {},
		position = {}
	}

	self:_initVehicleBase(nil)

	self._runtimeConfig = nil
	self._aiConfig = {}
	self._heldItem = nil
	self._trackPath = nil
	self._trackStartDistance = 0
	self._trackLength = 0
	self._trackIsLoop = false
	self._trackPathIsValid = false
	self._generatedElements = {}
	self._itemTargets = {}
	self._currentLane = 1
	self._targetLane = 1
	self._lateralOffset = 0
	self._targetLateralOffset = 0
	self._trackDistance = 0
	self._stableTrackForward = nil
	self._lateralVelocity = 0
	self._laneSwitchActive = false
	self._laneSwitchVisualDirection = 0
	self._decisionCooldownSec = 0
	self._lastLaneDecisionRaceDistance = 0
	self._itemDecisionCooldownSec = 0
	self._decisionRandom = nil

	self:_resetOverlapAvoidanceState()

	self._actionPool = {
		{
			actionType = 0,
			score = 0,
			lane = 0
		},
		{
			actionType = 0,
			score = 0,
			lane = 0
		},
		{
			actionType = 0,
			score = 0,
			lane = 0
		}
	}
	self._actionCount = 0
	self._nearbyElements = {}
	self._nearbyElementGaps = {}
	self._nearbyElementsFrame = -1
	self._nearbyElementsRaceDistance = nil
	self._raceDistance = 0
	self._totalRaceDistance = 0
	self._currentSpeed = 0
	self._hasFinished = false
	self._postFinishElapsed = -1
	self._postFinishForward = Vector3(0, 0, 1)
	self._racerName = "AI"
	self._difficultyTier = 1
	self._mistakeRate = 0.12
	self._leadDifficultyFactor = 1
	self._catchUpStartGap = DefaultCatchUpStartGap
	self._catchUpRampDistance = DefaultCatchUpRampDistance
	self._catchUpMaxMultiplier = DefaultCatchUpMaxMultiplier
	self._flashRenderers = nil
	self._renderersVisible = true
	self._invulnerabilityFlashEnabled = false
	self._shortcutJumpVisualHeight = 0
	self._airborneForwardRollAngleDeg = 0
	self._initialized = false
end

function AiRacerController:onStart()
	return
end

function AiRacerController:initialize(runtimeConfig, aiConfig, trackPath, generatedElements, itemTargets, startLane)
	self._runtimeConfig = runtimeConfig or {}
	self._aiConfig = aiConfig or {}

	self:_initializeRubberBandConfig()

	self._racerId = "ai_" .. tostring(self._aiConfig.racerId or 0)

	local displayName = self._aiConfig.displayName

	if not displayName or displayName == "" then
		displayName = "AI " .. tostring((not self._aiConfig.racerId or nil) and 0)
	end

	self._racerName = displayName
	self._go.name = self._racerId
	self._trackPath = trackPath
	self._trackStartDistance = trackPath and trackPath:getStartDistance() or 0
	self._trackLength = trackPath and trackPath:getTrackLength() or 0
	self._trackIsLoop = trackPath and trackPath:getIsLoop() == true or false
	self._trackPathIsValid = trackPath and trackPath:getIsValid() == true or false
	self._generatedElements = generatedElements or {}
	self._itemTargets = itemTargets or {}
	self._startLane = startLane or 0
	self._raceDistance = self._trackStartDistance
	self._lastLaneDecisionRaceDistance = self._raceDistance
	self._currentLane = self._startLane
	self._targetLane = self._currentLane
	self._lateralOffset = self._trackPath:LaneToLateralOffset(self._currentLane, LaneCount)
	self._targetLateralOffset = self._lateralOffset

	self:_resetOverlapAvoidanceState()

	self._itemDecisionCooldownSec = 0
	self._invulnerabilityRemainingSec = 0

	self:_initializePersonality()

	self._forwardSpeed = 0
	self._currentSpeed = self._forwardSpeed
	self._decisionCooldownSec = self:_resolveDecisionStaggerSec()

	self:_resolveFlashRenderers()
	self:_setInvulnerabilityRenderersVisible(true)
	self:_setTrackPose()
	self:_registerToSkillManager()

	self._initialized = true
end

function AiRacerController:onUpdate()
	if not self._initialized then
		return
	end

	if not V3a9RacingCarModel.instance:isRacing() then
		return
	end

	if self._hasFinished then
		return
	end

	local deltaTime = UnityEngine.Time.deltaTime

	if self._postFinishElapsed >= 0 then
		local elapsed = V3a9RacingCarModel.instance:getRaceTime() - self._postFinishElapsed

		if elapsed >= V3a9RacingCarEnum.PostFinishDelay then
			self._hasFinished = true

			return
		end

		self:_updateTimers(deltaTime)
		self:_updateMovement(deltaTime)

		return
	end

	self:_updateTimers(deltaTime)

	if self:_shouldUpdateLaneTraffic() then
		self:_tryEmergencyPlayerAvoidance()
		self:_updateDecision(deltaTime)
	end

	self:_updateMovement(deltaTime)
	self:_maybeUseHeldItem()
	self:_checkRaceCompletion()
end

function AiRacerController:_updateTimers(deltaTime)
	self:updateBuffs(deltaTime)

	if self._itemDecisionCooldownSec > 0 then
		self._itemDecisionCooldownSec = self._itemDecisionCooldownSec - deltaTime
	end

	self:_updateForcedYieldTimer(deltaTime)

	if self._invulnerabilityRemainingSec > 0 then
		self._invulnerabilityRemainingSec = math.max(0, self._invulnerabilityRemainingSec - deltaTime)

		if self._invulnerabilityFlashEnabled then
			self:_updateInvulnerabilityFlash()
		elseif self._renderersVisible == false then
			self:_setInvulnerabilityRenderersVisible(true)
		end
	else
		self._invulnerabilityFlashEnabled = false

		if self._renderersVisible == false then
			self:_setInvulnerabilityRenderersVisible(true)
		end
	end
end

function AiRacerController:_updateDecision(deltaTime)
	self._decisionCooldownSec = self._decisionCooldownSec - deltaTime

	local distanceSinceLastDecision = math.abs(self._raceDistance - (self._lastLaneDecisionRaceDistance or self._raceDistance))

	if self._decisionCooldownSec > 0 and distanceSinceLastDecision < LaneDecisionMaxTravelDistance then
		return
	end

	self._decisionCooldownSec = LaneDecisionIntervalSec
	self._lastLaneDecisionRaceDistance = self._raceDistance

	if self._currentLane ~= self._targetLane and not self:_isLaneEmergencyBlocked(self._targetLane) then
		return
	end

	local lane = self:_chooseLane()

	self._targetLane = lane
	self._targetLateralOffset = self._trackPath:LaneToLateralOffset(lane, LaneCount)
end

function AiRacerController:_resolveDecisionStaggerSec()
	local lane = Mathf.Clamp(self._startLane or 0, 0, LaneCount - 1)

	return LaneDecisionIntervalSec * (lane + 1) / (LaneCount + 1)
end

function AiRacerController:_refreshNearbyElementWindow()
	local frame = UnityEngine.Time.frameCount
	local queryDistance = self._raceDistance

	if self._trackPath then
		local isLoop = self._trackPath:getIsLoop()

		if isLoop then
			queryDistance = self._trackPath:WrapDistance(queryDistance)
		end

		if self._nearbyElementsFrame == frame and self._nearbyElementsRaceDistance == queryDistance then
			return
		end

		self._nearbyElementsFrame = frame
		self._nearbyElementsRaceDistance = queryDistance

		local nearbyElements = self._nearbyElements
		local nearbyGaps = self._nearbyElementGaps

		tabletool.clear(nearbyElements)
		tabletool.clear(nearbyGaps)

		local elements = self._generatedElements
		local elementCount = #elements

		if elementCount == 0 then
			return
		end

		local low = 1
		local high = elementCount

		while low <= high do
			local middle = math.floor((low + high) * 0.5)

			if queryDistance >= elements[middle].Distance then
				low = middle + 1
			else
				high = middle - 1
			end
		end

		for i = low, elementCount do
			local element = elements[i]
			local gap = element.Distance - queryDistance

			if gap > LaneLookAheadDistance then
				break
			end

			local nearbyIndex = #nearbyElements + 1

			nearbyElements[nearbyIndex] = element
			nearbyGaps[nearbyIndex] = gap
		end

		local startDistance = isLoop and self._trackPath:getStartDistance() or 0
		local endDistance = isLoop and self._trackPath:getEndDistance() or 0
		local distanceToEnd = endDistance - queryDistance

		if isLoop and distanceToEnd <= LaneLookAheadDistance and low > 1 then
			for i = 1, low - 1 do
				local element = elements[i]
				local gap = distanceToEnd + (element.Distance - startDistance)

				if gap > LaneLookAheadDistance then
					break
				end

				local nearbyIndex = #nearbyElements + 1

				nearbyElements[nearbyIndex] = element
				nearbyGaps[nearbyIndex] = gap
			end
		end
	end
end

function AiRacerController:_updateMovement(deltaTime)
	if self:isShortcutJumping() then
		self:_moveShortcutJump(deltaTime)

		return
	end

	if self._postFinishElapsed >= 0 then
		self:updateSpeed(deltaTime)

		if self._racerConfig then
			if not self._racerConfig.baseSpeed then
				local baseSpeed = 0

				self._forwardSpeed = math.max(self._forwardSpeed, baseSpeed)
				self._currentSpeed = self._forwardSpeed

				local distanceDelta = self._currentSpeed * deltaTime

				self._raceDistance = self._raceDistance + distanceDelta
				self._totalRaceDistance = self._totalRaceDistance + distanceDelta

				if self._trackPath and self._trackPath:getIsLoop() then
					self._raceDistance = self._trackPath:WrapDistance(self._raceDistance)
				end

				self._laneSwitchActive = false
				self._laneSwitchVisualDirection = 0
				self._lateralVelocity = 0

				self:_setTrackPose()

				return
			end
		end
	end

	self:updateSpeed(deltaTime)

	local rubberBandMul = self:_calcRubberBandMultiplier()

	if self._racerConfig then
		if not self._racerConfig.maxSpeed then
			local baseMaxSpeed = 999

			if rubberBandMul ~= 1 then
				local allowedMax = baseMaxSpeed * rubberBandMul

				self._forwardSpeed = math.min(self._forwardSpeed * rubberBandMul, allowedMax)
			end

			if not self._forwardSpeed then
				local normalExpected = 0
				local leaderGap, leaderSpeed, leaderIsPlayer = self:_findNearestLeader(nil, nil)
				local playerEligible = self:_isPlayerEligibleForRecovery()
				local recoveredExpected = normalExpected

				if self:_canApplyPlayerBlockRecovery(leaderGap, rubberBandMul, playerEligible) then
					recoveredExpected = AiRacerOverlapRules.ResolveRecoveryExpectedSpeed(normalExpected, baseMaxSpeed, self._catchUpMaxMultiplier)
				end

				local safeExpected = self:_applyTrafficSpeedLimit(recoveredExpected, deltaTime, leaderGap, leaderSpeed)
				local actualMovementSpeed = self:_resolveActualMovementSpeed(safeExpected)
				local playerTrafficReduced = leaderIsPlayer and safeExpected < recoveredExpected - SpeedComparisonEpsilon
				local forcedYieldReduced = actualMovementSpeed < safeExpected - SpeedComparisonEpsilon
				local playerActuallyReducedSpeed = playerTrafficReduced or forcedYieldReduced
				local recoveryActuallyApplied = safeExpected > normalExpected + SpeedComparisonEpsilon
				local canUpdateRecoveryDebt = playerEligible and not self._hasFinished and self:_shouldUpdateLaneTraffic()

				self:_updatePlayerBlockRecoveryDebt(deltaTime, playerActuallyReducedSpeed, recoveryActuallyApplied, canUpdateRecoveryDebt)

				self._forwardSpeed = math.min(normalExpected, safeExpected)
				self._currentSpeed = actualMovementSpeed

				local distanceDelta = self._currentSpeed * deltaTime

				self._raceDistance = self._raceDistance + distanceDelta
				self._totalRaceDistance = self._totalRaceDistance + distanceDelta

				local laneChangeSpeed = self._laneSwitchSpeed
				local previousLateralOffset = self._lateralOffset
				local targetDelta = self._targetLateralOffset - previousLateralOffset

				self._laneSwitchActive = math.abs(targetDelta) > 0.01
				self._laneSwitchVisualDirection = targetDelta > 0.01 and 1 or targetDelta < -0.01 and -1 or 0
				self._lateralOffset = self:_moveTowards(self._lateralOffset, self._targetLateralOffset, laneChangeSpeed * deltaTime)

				if deltaTime > 0 then
					self._lateralVelocity = (self._lateralOffset - previousLateralOffset) / deltaTime or 0
				end

				self:_applyTrackBoundaryClamp()

				if math.abs(self._lateralOffset - self._targetLateralOffset) < 0.01 then
					self._currentLane = self._targetLane
					self._laneSwitchActive = false
					self._laneSwitchVisualDirection = 0
					self._lateralVelocity = 0
				end

				self:_setTrackPose()
			end
		end
	end
end

function AiRacerController:tryStartShortcutJump(landingDistanceOffset, landingLane, laneCount, durationSec, height, speedMultiplier)
	if not self._trackPath or not self._trackPath:getIsValid() then
		return false
	end

	if self:isShortcutJumping() then
		return false
	end

	local startDistance = self._raceDistance
	local targetDistance = self:_resolveShortcutJumpTargetDistance(startDistance, landingDistanceOffset)
	local targetLane = Mathf.Clamp(landingLane or self._targetLane, 0, LaneCount - 1)
	local targetLateral = self._trackPath:LaneToLateralOffset(targetLane, LaneCount)

	self._trackPath:SampleTo(startDistance, self._lateralOffset, self._poseCache)

	local takeoffPose = self._poseCache
	local takeoffXZ = {
		x = takeoffPose.position.x,
		z = takeoffPose.position.y
	}

	self._trackPath:SampleTo(targetDistance, targetLateral, self._futurePoseCache)

	local landingPose = self._futurePoseCache
	local landingXZ = {
		x = landingPose.position.x,
		z = landingPose.position.y
	}
	local _, takeoffY = transformhelper.getPos(self._transform)

	self:_beginShortcutJump(startDistance, targetDistance, self._lateralOffset, targetLateral, durationSec, height, speedMultiplier, takeoffY, {
		takeoffXZ = takeoffXZ,
		landingXZ = landingXZ
	})

	self._airborneForwardRollAngleDeg = 0
	self._targetLane = targetLane
	self._currentLane = targetLane
	self._targetLateralOffset = targetLateral

	return true
end

function AiRacerController:isSpecialTrackAirbornePresentationActive()
	return (self._shortcutJumpRemainingSec or 0) > 0
end

function AiRacerController:_resolveAirborneForwardAxisRoll(deltaTime)
	if self._runtimeConfig then
		local rollSpeed = self._runtimeConfig and tonumber(self._runtimeConfig.airborneForwardRollDegreesPerSecond) or nil

		if not rollSpeed or rollSpeed <= 0 or rollSpeed ~= rollSpeed then
			rollSpeed = DefaultAirborneForwardRollDegreesPerSecond
		end

		self._airborneForwardRollAngleDeg = Mathf.Repeat((self._airborneForwardRollAngleDeg or 0) + rollSpeed * math.max(0, deltaTime or 0), 360)

		return self._airborneForwardRollAngleDeg
	end
end

function AiRacerController:resolveSpecialTrackAirborneRollDegrees(deltaTime)
	if not self:isSpecialTrackAirbornePresentationActive() then
		return 0
	end

	return self:_resolveAirborneForwardAxisRoll(deltaTime)
end

function AiRacerController:_moveShortcutJump(deltaTime)
	self:updateSpeed(deltaTime)

	self._currentSpeed = self._forwardSpeed * math.max(1, self._shortcutJumpSpeedMultiplier or 1)

	local previousDistance = self._raceDistance
	local distance, lateral, heightOffset = self:_advanceShortcutJump(deltaTime)

	self._raceDistance = distance
	self._lateralOffset = lateral

	local distanceDelta = math.abs(self._raceDistance - previousDistance)

	if distanceDelta > 0 then
		self._totalRaceDistance = self._totalRaceDistance + distanceDelta
	end

	self:_setTrackPose(heightOffset)
end

function AiRacerController:_resetOverlapAvoidanceState()
	self._forcedYieldRemainingSec = 0
	self._handledPlayerLaneSwitch = false
	self._playerBlockRecoveryDebtSec = 0
end

function AiRacerController:_shouldUpdateLaneTraffic()
	return not self:isShortcutJumping()
end

function AiRacerController:_updateForcedYieldTimer(deltaTime)
	if self:_shouldUpdateLaneTraffic() and self._forcedYieldRemainingSec > 0 then
		self._forcedYieldRemainingSec = math.max(0, self._forcedYieldRemainingSec - deltaTime)
	end
end

function AiRacerController:_resolveActualMovementSpeed(expectedSpeed)
	local speed = expectedSpeed

	if speed == nil then
		speed = self._forwardSpeed or 0
	end

	if self._forcedYieldRemainingSec > 0 then
		speed = speed * ForcedYieldSpeedMultiplier
	end

	return speed
end

function AiRacerController:_isPlayerEligibleForRecovery()
	local model = V3a9RacingCarModel.instance
	local player = model and model:getPlayerVehicleController()

	if not self:_isTrafficParticipantEligible(player, true) then
		return false
	end

	return not player.hasFinished or not player:hasFinished()
end

function AiRacerController:_canApplyPlayerBlockRecovery(leaderGap, rubberBandMul, playerEligible)
	if playerEligible and not self._hasFinished and self:_shouldUpdateLaneTraffic() then
		if (self._playerBlockRecoveryDebtSec or 0) <= 0 or self._forcedYieldRemainingSec > 0 or (rubberBandMul or 1) < 1 then
			return false
		end
	end

	return not leaderGap or leaderGap > TrafficWatchDistanceM
end

function AiRacerController:_updatePlayerBlockRecoveryDebt(deltaTime, playerActuallyReducedSpeed, recoveryActuallyApplied, canUpdate)
	self._playerBlockRecoveryDebtSec = AiRacerOverlapRules.UpdateRecoveryDebt(self._playerBlockRecoveryDebtSec, deltaTime, PlayerBlockRecoveryDebtMaxSec, playerActuallyReducedSpeed, recoveryActuallyApplied, canUpdate)
end

function AiRacerController:_tryStartForcedYieldForPlayerSwitch()
	if self._handledPlayerLaneSwitch then
		return false
	end

	self._handledPlayerLaneSwitch = true
	self._forcedYieldRemainingSec = ForcedYieldDurationSec

	return true
end

function AiRacerController:_participantOccupiesLane(participant, lane)
	if not participant or not participant.getCurrentLaneIndex then
		return false
	end

	local currentLane = participant:getCurrentLaneIndex()
	local targetLane = participant.getTargetLaneIndex and participant:getTargetLaneIndex() or currentLane
	local isChangingLane = participant.isChangingLane and participant:isChangingLane() or false

	return AiRacerOverlapRules.IsLaneOccupied(lane, currentLane, targetLane, isChangingLane)
end

function AiRacerController:_isTrafficParticipantEligible(participant, isPlayer)
	if not participant or participant == self then
		return false
	end

	if isPlayer then
		return participant.isEligibleForMainLaneOccupancy and participant:isEligibleForMainLaneOccupancy()
	end

	if participant.hasFinished and participant:hasFinished() then
		return false
	end

	if participant.isShortcutJumping and participant:isShortcutJumping() then
		return false
	end

	return not participant.hasTrackState or participant:hasTrackState()
end

function AiRacerController:_getParticipantSpeed(participant)
	if participant and participant.getForwardSpeed then
		return participant:getForwardSpeed()
	end

	if participant and participant.getCurrentSpeed then
		return participant:getCurrentSpeed()
	end

	return 0
end

function AiRacerController:_signedGapToParticipant(participant)
	if not participant or not participant.getTrackDistance then
		return nil
	end

	local otherDistance = participant:getTrackDistance()

	if otherDistance == nil then
		return nil
	end

	return AiRacerOverlapRules.SignedGap(self._raceDistance, otherDistance, self._trackStartDistance, self._trackLength, self._trackIsLoop)
end

function AiRacerController:_sharesOccupiedLaneWith(participant)
	if not participant or not participant.getCurrentLaneIndex then
		return false
	end

	local selfCurrentLane = self._currentLane
	local selfTargetLane = self._targetLane
	local selfChangingLane = selfCurrentLane ~= selfTargetLane or self._laneSwitchActive == true
	local otherCurrentLane = participant:getCurrentLaneIndex()
	local otherTargetLane = participant.getTargetLaneIndex and participant:getTargetLaneIndex() or otherCurrentLane
	local otherChangingLane = participant.isChangingLane and participant:isChangingLane() or false
	local sharedCurrentLane = selfCurrentLane == otherCurrentLane and selfCurrentLane ~= nil and selfCurrentLane >= 0 and selfCurrentLane < LaneCount
	local selfTargetHitsOtherCurrent = selfChangingLane and selfTargetLane == otherCurrentLane and selfTargetLane ~= nil and selfTargetLane >= 0 and selfTargetLane < LaneCount
	local otherTargetHitsSelfCurrent = otherChangingLane and selfCurrentLane == otherTargetLane and selfCurrentLane ~= nil and selfCurrentLane >= 0 and selfCurrentLane < LaneCount
	local sharedTargetLane = selfChangingLane and otherChangingLane and selfTargetLane == otherTargetLane and selfTargetLane ~= nil and selfTargetLane >= 0 and selfTargetLane < LaneCount

	return sharedCurrentLane or selfTargetHitsOtherCurrent or otherTargetHitsSelfCurrent or sharedTargetLane
end

function AiRacerController:_isLaneSafeForTraffic(lane)
	local model = V3a9RacingCarModel.instance
	local player = model:getPlayerVehicleController()

	if self:_isTrafficParticipantEligible(player, true) and self:_participantOccupiesLane(player, lane) then
		local playerGap = self:_signedGapToParticipant(player)

		if playerGap and math.abs(playerGap) < RacerSafetyDistanceM then
			return false
		end

		if playerGap then
			if AiRacerOverlapRules:ShouldYieldForRearApproach(self:_getParticipantSpeed(player), (not self._forwardSpeed or nil) and 0, TrafficWatchDistanceM) then
				return false
			end
		end
	end

	local aiRacers = model:getAIRacers()

	for _, participant in ipairs(aiRacers) do
		if self:_isTrafficParticipantEligible(participant, false) and self:_participantOccupiesLane(participant, lane) then
			local gap = self:_signedGapToParticipant(participant)

			if gap and math.abs(gap) < RacerSafetyDistanceM then
				return false
			end
		end
	end

	return true
end

function AiRacerController:_leaderCandidate(participant, isPlayer, lane, maxDistance)
	if not self:_isTrafficParticipantEligible(participant, isPlayer) then
		return nil, nil
	end

	local sharesLane

	if not (lane ~= nil and self:_participantOccupiesLane(participant, lane) or self:_sharesOccupiedLaneWith(participant)) then
		return nil, nil
	end

	local gap = self:_signedGapToParticipant(participant)

	if not gap or gap <= 0 or maxDistance and maxDistance < gap then
		return nil, nil
	end

	return gap, self:_getParticipantSpeed(participant)
end

function AiRacerController:_findNearestLeader(lane, maxDistance)
	local model = V3a9RacingCarModel.instance
	local bestGap
	local bestSpeed = 0
	local bestIsPlayer = false
	local player = model:getPlayerVehicleController()
	local gap, speed = self:_leaderCandidate(player, true, lane, maxDistance)

	if gap then
		bestGap = gap
		bestSpeed = speed
		bestIsPlayer = true
	end

	local aiRacers = model:getAIRacers()

	for _, participant in ipairs(aiRacers) do
		gap, speed = self:_leaderCandidate(participant, false, lane, maxDistance)

		if gap and (not bestGap or gap < bestGap) then
			bestGap = gap
			bestSpeed = speed
			bestIsPlayer = false
		end
	end

	return bestGap, bestSpeed, bestIsPlayer
end

function AiRacerController:_calcTrafficScore(lane)
	local leaderGap = self:_findNearestLeader(lane, TrafficWatchDistanceM)

	return (leaderGap or nil) and (-TrafficCongestionPenalty or 0)
end

function AiRacerController:_chooseEmergencyAvoidanceLane()
	local bestLane, bestScore
	local leftLane = self._currentLane - 1
	local rightLane = self._currentLane + 1

	if leftLane >= 0 and not self:_isLaneEmergencyBlocked(leftLane) and self:_isLaneSafeForTraffic(leftLane) then
		bestLane = leftLane
		bestScore = self:_calcElementScore(leftLane) + self:_calcTrafficScore(leftLane)
	end

	if rightLane < LaneCount and not self:_isLaneEmergencyBlocked(rightLane) and self:_isLaneSafeForTraffic(rightLane) then
		local rightScore = self:_calcElementScore(rightLane) + self:_calcTrafficScore(rightLane)

		if not bestScore or bestScore < rightScore then
			bestLane = rightLane
			bestScore = rightScore
		end
	end

	return bestLane
end

function AiRacerController:_tryEmergencyPlayerAvoidance()
	local player = V3a9RacingCarModel.instance:getPlayerVehicleController()
	local playerChangingLane = player and player.isChangingLane and player:isChangingLane() or false

	if not playerChangingLane then
		self._handledPlayerLaneSwitch = false
	end

	if not self:_isTrafficParticipantEligible(player, true) then
		self._handledPlayerLaneSwitch = false
		self._forcedYieldRemainingSec = 0

		return false
	end

	local playerGap = self:_signedGapToParticipant(player)

	if not playerGap then
		return false
	end

	local playerCurrentLane = player:getCurrentLaneIndex()
	local playerTargetLane = player:getTargetLaneIndex()
	local selfChangingLane = self:isChangingLane()
	local playerCuttingIntoSelf = playerChangingLane and playerCurrentLane ~= playerTargetLane and AiRacerOverlapRules.IsLaneOccupied(playerTargetLane, self._currentLane, self._targetLane, selfChangingLane) and math.abs(playerGap) < RacerSafetyDistanceM
	local playerWillUseSelfLane = playerChangingLane and self._participantOccupiesLane(self, self, playerTargetLane) or not playerChangingLane and self:_sharesOccupiedLaneWith(player)

	if playerWillUseSelfLane then
		local rearApproach = AiRacerOverlapRules:ShouldYieldForRearApproach(self:_getParticipantSpeed(player), (not self._forwardSpeed or nil) and 0, TrafficWatchDistanceM)

		if not playerCuttingIntoSelf and not rearApproach then
			return false
		end

		if selfChangingLane then
			if playerCuttingIntoSelf and playerGap >= 0 then
				self:_tryStartForcedYieldForPlayerSwitch()
			end

			return false
		end

		local avoidanceLane = self:_chooseEmergencyAvoidanceLane()

		if avoidanceLane ~= nil then
			self._targetLane = avoidanceLane
			self._targetLateralOffset = self._trackPath:LaneToLateralOffset(avoidanceLane, LaneCount)

			return true
		end

		if playerCuttingIntoSelf and playerGap >= 0 then
			self:_tryStartForcedYieldForPlayerSwitch()
		end

		return false
	end
end

function AiRacerController:_applyTrafficSpeedLimit(candidateSpeed, deltaTime, leaderGap, leaderSpeed)
	if not leaderGap then
		return candidateSpeed
	end

	return AiRacerOverlapRules.ClampFollowerSpeed(candidateSpeed, leaderSpeed, leaderGap, RacerSafetyDistanceM, deltaTime, ForcedYieldSpeedMultiplier)
end

function AiRacerController:_chooseLane()
	local pool = self._actionPool
	local count = 0

	if not self:_isLaneEmergencyBlocked(self._currentLane) then
		count = count + 1

		local a = pool[count]

		a.actionType = ACTION_STAY
		a.lane = self._currentLane
		a.score = 0
	end

	local leftLane = self._currentLane - 1

	if leftLane >= 0 and not self:_isLaneEmergencyBlocked(leftLane) and self:_isLaneSafeForTraffic(leftLane) then
		count = count + 1

		local a = pool[count]

		a.actionType = ACTION_LEFT
		a.lane = leftLane
		a.score = 0
	end

	local rightLane = self._currentLane + 1

	if rightLane < LaneCount and not self:_isLaneEmergencyBlocked(rightLane) and self:_isLaneSafeForTraffic(rightLane) then
		count = count + 1

		local a = pool[count]

		a.actionType = ACTION_RIGHT
		a.lane = rightLane
		a.score = 0
	end

	if count == 0 then
		return self._currentLane
	end

	self._actionCount = count

	for i = 1, count do
		local act = pool[i]
		local laneDistance = act.actionType == ACTION_STAY and 0 or 1

		act.score = -laneDistance * LaneChangeCost + self:_calcElementScore(act.lane) + self:_calcTrafficScore(act.lane)
	end

	local bestIdx = 1
	local bestScore = pool[1].score

	for i = 2, count do
		if bestScore < pool[i].score then
			bestIdx = i
			bestScore = pool[i].score
		end
	end

	local tiedCount = 0

	for i = 1, count do
		if pool[i].score == bestScore then
			tiedCount = tiedCount + 1
		end
	end

	if tiedCount > 1 then
		for i = 1, count do
			if pool[i].score == bestScore and pool[i].actionType == ACTION_STAY then
				bestIdx = i
				tiedCount = 1

				break
			end
		end

		if tiedCount > 1 then
			local closestDist = math.abs(pool[bestIdx].lane - self._currentLane)

			for i = 1, count do
				if pool[i].score == bestScore then
					local d = math.abs(pool[i].lane - self._currentLane)

					if d < closestDist then
						bestIdx = i
						closestDist = d
					end
				end
			end
		end
	end

	if self:_next01() < self._mistakeRate then
		return self:_applyMistake(bestIdx, count)
	end

	return pool[bestIdx].lane
end

function AiRacerController:_applyMistake(bestIdx, count)
	local pool = self._actionPool
	local idealType = pool[bestIdx].actionType

	if idealType == ACTION_LEFT then
		for i = 1, count do
			if pool[i].actionType == ACTION_RIGHT then
				return pool[i].lane
			end
		end

		return self._currentLane
	elseif idealType == ACTION_RIGHT then
		for i = 1, count do
			if pool[i].actionType == ACTION_LEFT then
				return pool[i].lane
			end
		end

		return self._currentLane
	else
		local adjCount = 0
		local adj1, adj2

		for i = 1, count do
			if pool[i].actionType ~= ACTION_STAY then
				adjCount = adjCount + 1

				if adjCount == 1 then
					adj1 = i
				else
					adj2 = i
				end
			end
		end

		if adjCount == 0 then
			return pool[bestIdx].lane
		elseif adjCount == 1 then
			return pool[adj1].lane
		else
			return pool[math.random() < 0.5 and adj1 or adj2].lane
		end
	end
end

function AiRacerController:_calcElementScore(lane)
	local score = 0

	self:_refreshNearbyElementWindow()

	local elements = self._nearbyElements
	local gaps = self._nearbyElementGaps
	local heldItem = self._heldItem

	for i = 1, #elements do
		local element = elements[i]
		local gap = gaps[i]

		if self:_elementCoversLane(element, lane) then
			local baseScore = LaneElementScores[element.ElementType]

			if baseScore and (element.ElementType ~= TrackElementType.ItemPickup or not heldItem) then
				local proximity = 1 - gap / LaneLookAheadDistance

				score = score + baseScore * proximity
			end
		end
	end

	return score
end

function AiRacerController:tryStoreItem(itemConfig)
	if not itemConfig then
		return false
	end

	if self._heldItem then
		return false
	end

	self._heldItem = itemConfig

	RacingCarSkillManager.instance:executePassiveSkills(self, RacingCarPropEnum.TriggerType.GetItem, self, itemConfig.id)
	RacingCarSkillManager.instance:executePassiveSkills(self, RacingCarPropEnum.TriggerType.GetItemRand, self)

	return true
end

function AiRacerController:tryUseHeldItem()
	if not self._heldItem then
		return false
	end

	local effectList = string.split(self._heldItem.effect or "", "|")

	for _, effectIdText in ipairs(effectList) do
		local effectId = tonumber(effectIdText)

		if effectId then
			RacingCarSkillManager.instance:executeEffect(effectId, self, RacingCarPropEnum.TriggerType.UseItem, self)
		end
	end

	self._heldItem = nil

	return true
end

function AiRacerController:hasItem()
	return self._heldItem ~= nil
end

function AiRacerController:getHeldItem()
	return self._heldItem
end

function AiRacerController:convertItems(sourceItemIds, conversionMap)
	if not conversionMap or not self._heldItem then
		return
	end

	local newItem = conversionMap[self._heldItem.id]

	if newItem then
		self._heldItem = newItem
	end
end

function AiRacerController:_maybeUseHeldItem()
	if not self._heldItem then
		return
	end

	if self._itemDecisionCooldownSec > 0 then
		return
	end

	self._itemDecisionCooldownSec = self:_nextItemDecisionInterval()

	local shouldUse = false
	local tier01 = Mathf.InverseLerp(1, 3, self._difficultyTier)
	local playerClose = self:_isPlayerClose()
	local nearFinish = self:_isNearFinish()

	shouldUse = nearFinish and self:_next01() < self:_lerp(0.5, 0.9, tier01) or playerClose and self:_next01() < self:_lerp(0.35, 0.75, tier01) or self:_next01() < self:_lerp(0.08, 0.25, tier01)

	if shouldUse then
		self:tryUseHeldItem()
	end
end

function AiRacerController:_nextItemDecisionInterval()
	local tier01 = Mathf.InverseLerp(1, 3, self._difficultyTier)

	return self:_lerp(1.8, 0.6, tier01) + self:_nextRange(0, 0.3)
end

function AiRacerController:_isLaneEmergencyBlocked(lane)
	self:_refreshNearbyElementWindow()

	local elements = self._nearbyElements
	local gaps = self._nearbyElementGaps

	for i = 1, #elements do
		local gap = gaps[i]

		if gap > LaneEmergencyDistance then
			break
		end

		local element = elements[i]

		if self:_elementCoversLane(element, lane) and self:_isTrackHazardElement(element.ElementType) then
			return true
		end
	end

	return false
end

function AiRacerController:_calcRubberBandMultiplier()
	if self._hasFinished then
		return 1
	end

	if not V3a9RacingCarModel.instance:isRacing() then
		return 1
	end

	local playerController = V3a9RacingCarModel.instance:getPlayerVehicleController()

	if not playerController then
		return 1
	end

	if playerController.hasFinished and playerController:hasFinished() then
		return 1
	end

	local playerGap = playerController:getTotalTrackDistance() - self._totalRaceDistance

	if playerGap > self._catchUpStartGap then
		return AiRacerOverlapRules.CalculateCatchUpMultiplier(playerGap, self._catchUpStartGap, self._catchUpRampDistance, self._catchUpMaxMultiplier)
	end

	local leadGap = -playerGap

	if leadGap > LeadSlowStartGap then
		local leadT = Mathf.Clamp01((leadGap - LeadSlowStartGap) / LeadSlowRampDistance)
		local slowRatio = LeadSlowMaxRatio * self._leadDifficultyFactor * leadT

		return 1 - slowRatio
	end

	return 1
end

function AiRacerController:_isNearFinish()
	if self._runtimeConfig.level then
		if not self._runtimeConfig.level.finishDistance then
			local finishDistance = 1000

			return finishDistance - self._raceDistance <= FinishKeepLaneDistance
		end
	end
end

function AiRacerController:_isPlayerClose()
	local player = self:_findPlayerTarget()

	return player and math.abs(player.RaceDistance - self._raceDistance) < 60
end

function AiRacerController:_findPlayerTarget()
	if not self._itemTargets or #self._itemTargets == 0 then
		return nil
	end

	for _, target in ipairs(self._itemTargets) do
		if target and target.IsPlayerTarget then
			return target
		end
	end

	return nil
end

function AiRacerController:_initializePersonality()
	local seed = ((self._aiConfig.racerId or 0) * 73856093)^(self._racerConfig.difficult * 19349663)^math.floor(((self._aiConfig.preferredOffset or 0) + 1000) * 97)

	if seed == 0 then
		seed = 39
	end

	math.randomseed(seed)

	self._decisionRandom = true
	self._difficultyTier = self._racerConfig.difficult
	self._mistakeRate = Mathf.Clamp(self._racerConfig.wrongPercent or 0.12, 0, 1)
	self._leadDifficultyFactor = self._difficultyTier >= 3 and 0 or self._difficultyTier == 2 and 0.5 or 1
end

function AiRacerController:_elementCoversLane(element, lane)
	local var_52_2

	if lane >= math.max(0, element.CoveredLaneStart or 0) then
		if lane > math.min(LaneCount - 1, element.CoveredLaneEnd or 0) then
			var_52_2 = false

			goto label_52_0
		end
	end

	::label_52_0::

	return true
end

function AiRacerController:_isTrackHazardElement(elementType)
	return elementType == TrackElementType.Obstacle or elementType == TrackElementType.DangerZone or elementType == TrackElementType.TidalHammer or elementType == TrackElementType.WaterJet or elementType == TrackElementType.MovingBuoyWall
end

function AiRacerController:_applyTrackBoundaryClamp()
	if not self._trackPath or not self._trackPath:getIsValid() then
		return
	end

	local maxLateral = math.max(0.1, self._trackPath:getHalfRoadWidth() - TrackEdgeBuffer)
	local clampedLateral = Mathf.Clamp(self._lateralOffset, -maxLateral, maxLateral)

	if math.abs(clampedLateral - self._lateralOffset) < 0.001 then
		return
	end

	self._lateralOffset = clampedLateral
	self._targetLateralOffset = Mathf.Clamp(self._targetLateralOffset, -maxLateral, maxLateral)

	if not self._runtimeConfig.collision then
		self:ApplyInterferenceSlowdown(self._runtimeConfig.collision.slowdownMultiplier or 0.5, self._runtimeConfig.collision.recoverySec or 1)
	end
end

function AiRacerController:_resolveFlashRenderers()
	if self._flashRenderers ~= nil or gohelper.isNil(self._go) then
		return
	end

	self._flashRenderers = {}

	local renderers = self._go:GetComponentsInChildren(typeof(UnityEngine.Renderer), true)

	if not renderers then
		return
	end

	for i = 0, renderers.Length - 1 do
		local renderer = renderers[i]

		if not gohelper.isNil(renderer) then
			table.insert(self._flashRenderers, renderer)
		end
	end
end

function AiRacerController:_initializeRubberBandConfig()
	local var_56_0 = lua_racing_const

	if lua_racing_const then
		var_56_0 = lua_racing_const.configDict

		if lua_racing_const.configDict then
			local activityConfig = lua_racing_const.configDict[13920]
			local rubberBandConfig = activityConfig and activityConfig[RacingRubberBandConstId]
			local rawValue = rubberBandConfig and rubberBandConfig.value2

			self._catchUpStartGap, self._catchUpRampDistance, self._catchUpMaxMultiplier = AiRacerOverlapRules.ResolveRubberBandConfig(rawValue, DefaultCatchUpStartGap, DefaultCatchUpRampDistance, DefaultCatchUpMaxMultiplier)
		end
	end
end

function AiRacerController:_updateInvulnerabilityFlash()
	self:_resolveFlashRenderers()

	if not self._flashRenderers or #self._flashRenderers == 0 then
		return
	end

	local pulse = Mathf.PingPong(UnityEngine.Time.time * InvulnerabilityFlashHz, 1)
	local visible = pulse > 0.35

	if visible ~= self._renderersVisible then
		self:_setInvulnerabilityRenderersVisible(visible)
	end
end

function AiRacerController:_setInvulnerabilityRenderersVisible(visible)
	self._renderersVisible = visible

	if not self._flashRenderers then
		return
	end

	for _, renderer in ipairs(self._flashRenderers) do
		if not gohelper.isNil(renderer) then
			renderer.enabled = visible
		end
	end
end

function AiRacerController:_setTrackPose(heightOffset)
	if not self._trackPath or not self._trackPath:getIsValid() then
		return
	end

	local transform = self._transform

	self._trackDistance = self._raceDistance

	if self:isShortcutJumping() and heightOffset then
		local duration = math.max(0.0001, self._shortcutJumpDurationSec)
		local t = Mathf.Clamp01(1 - self._shortcutJumpRemainingSec / duration)
		local txz = self._shortcutJumpTakeoffXZ
		local lxz = self._shortcutJumpLandingXZ
		local flyX = txz.x + (lxz.x - txz.x) * t
		local flyZ = txz.z + (lxz.z - txz.z) * t
		local flyY = self._shortcutJumpTakeoffY + heightOffset

		self._shortcutJumpVisualHeight = heightOffset

		transformhelper.setPos(transform, flyX, flyY, flyZ)

		local fwd = self._shortcutJumpTakeoffForward

		self:_applyFlatTrackForward(transform, fwd.x, fwd.z)
	elseif self._postFinishElapsed >= 0 then
		local endDistance = self._trackPath:getEndDistance()
		local isLoop = self._trackPath:getIsLoop()
		local fwdX, fwdZ

		self._shortcutJumpVisualHeight = 0

		if isLoop or endDistance >= self._raceDistance then
			self._trackPath:SampleTo(self._raceDistance, self._lateralOffset, self._poseCache)

			local pose = self._poseCache

			transformhelper.setPos(transform, pose.position.x, 0, pose.position.y)

			fwdZ = pose.tangent.y
			fwdX = pose.tangent.x
		else
			local overshoot = self._raceDistance - endDistance

			self._trackPath:SampleTo(endDistance, self._lateralOffset, self._poseCache)

			local pose = self._poseCache
			local tx, tz = pose.tangent.x, pose.tangent.y
			local tSqr = tx * tx + tz * tz

			if tSqr > 0.001 then
				local invLen = 1 / math.sqrt(tSqr)

				fwdZ = tz * invLen
				fwdX = tx * invLen
			elseif self._postFinishElapsed >= 0 then
				fwdZ = self._postFinishForward.z
				fwdX = self._postFinishForward.x
			else
				fwdZ = 1
				fwdX = 0
			end

			transformhelper.setPos(transform, pose.position.x + fwdX * overshoot, 0, pose.position.y + fwdZ * overshoot)
		end

		self:_applyFlatTrackForward(transform, fwdX, fwdZ)
	else
		self._trackPath:SampleTo(self._raceDistance, self._lateralOffset, self._poseCache)

		local pose = self._poseCache

		self._shortcutJumpVisualHeight = 0

		transformhelper.setPos(transform, pose.position.x, 0, pose.position.y)
		self:_applyFlatTrackForward(transform, pose.tangent.x, pose.tangent.y)
	end
end

function AiRacerController:_applyFlatTrackForward(transform, fx, fz)
	local fSqr = fx * fx + fz * fz

	if fSqr <= 0.0001 then
		return false
	end

	local invLen = 1 / math.sqrt(fSqr)
	local nx, nz = fx * invLen, fz * invLen
	local yawDeg = math.deg(math.atan2(nx, nz))
	local lastYawDeg = self._lastAppliedTrackYawDeg

	if lastYawDeg then
		if not ((yawDeg - lastYawDeg + 180) % 360 - 180) then
			local yawDelta = math.huge

			if math.abs(yawDelta) > 0.001 then
				transformhelper.setEulerAngles(transform, 0, yawDeg, 0)

				self._lastAppliedTrackYawDeg = yawDeg
			end

			return true
		end
	end
end

function AiRacerController:_next01()
	return math.random()
end

function AiRacerController:_nextRange(min, max)
	return min + (max - min) * self:_next01()
end

function AiRacerController:getRacerName()
	return self._racerName
end

function AiRacerController:getIsPlayer()
	return false
end

function AiRacerController:getTrackDistance()
	return self._raceDistance
end

function AiRacerController:getTotalTrackDistance()
	return self._totalRaceDistance
end

function AiRacerController:hasFinished()
	return self._hasFinished or false
end

function AiRacerController:isPostFinish()
	return self._postFinishElapsed >= 0
end

function AiRacerController:_checkRaceCompletion()
	if not self._trackPath or not self._trackPath:getIsValid() then
		return
	end

	if self._hasFinished then
		return
	end

	if self._postFinishElapsed >= 0 then
		return
	end

	local aiDistance = self:getTotalTrackDistance()
	local aiFinished = V3a9RacingCarModel.instance:checkRaceCompletion(aiDistance, false, self._racerId)

	if aiFinished then
		self._postFinishElapsed = V3a9RacingCarModel.instance:getRaceTime()
		self._lateralOffset = self._trackPath:LaneToLateralOffset(self._targetLane, LaneCount)
		self._currentLane = self._targetLane

		self._trackPath:SampleTo(self._raceDistance, self._lateralOffset, self._poseCache)

		local tx, tz = self._poseCache.tangent.x, self._poseCache.tangent.y
		local tSqr = tx * tx + tz * tz

		if tSqr > 0.001 then
			local invLen = 1 / math.sqrt(tSqr)

			SetVec3(self._postFinishForward, tx * invLen, 0, tz * invLen)
		else
			SetVec3(self._postFinishForward, 0, 0, 1)
		end
	end
end

function AiRacerController:getLateralOffset()
	return self._lateralOffset
end

function AiRacerController:getCurrentLaneIndex()
	return self._currentLane
end

function AiRacerController:getTargetLaneIndex()
	return self._targetLane
end

function AiRacerController:isChangingLane()
	return self._currentLane ~= self._targetLane or self._laneSwitchActive == true
end

function AiRacerController:getLaneCount()
	return LaneCount
end

function AiRacerController:hasTrackState()
	return self._initialized and self._trackPathIsValid
end

function AiRacerController:getCurrentSpeed()
	return self._currentSpeed
end

function AiRacerController:getForwardSpeed()
	return self._currentSpeed or self._forwardSpeed or 0
end

function AiRacerController:_getCurrentMaxSpeed()
	return self:getBaseSpeed()
end

function AiRacerController:getTargetName()
	return self._racerName
end

function AiRacerController:getIsPlayerTarget()
	return false
end

function AiRacerController:ApplyInterferenceSlowdown(multiplier, durationSec)
	return false
end

function AiRacerController:_setInvulnerableFor(seconds, enableFlash)
	RacingVehicleControllerBase._setInvulnerableFor(self, seconds)

	self._invulnerabilityFlashEnabled = enableFlash == true

	if self._invulnerabilityRemainingSec > 0 and self._invulnerabilityFlashEnabled then
		self:_resolveFlashRenderers()
		self:_updateInvulnerabilityFlash()
	else
		self:_setInvulnerabilityRenderersVisible(true)
	end
end

function AiRacerController:setInvisible(isInvisible)
	self._isInvisible = not not isInvisible

	self:_setInvulnerabilityRenderersVisible(not self._isInvisible)
end

function AiRacerController:jumpLane(laneOffset)
	if not self._trackPath or not self._trackPath:getIsValid() then
		return
	end

	laneOffset = laneOffset or 0

	if laneOffset == 0 then
		return
	end

	local nextLane = Mathf.Clamp(self._targetLane + laneOffset, 0, LaneCount - 1)

	if nextLane == self._targetLane then
		return
	end

	if not self:_isLaneSafeForTraffic(nextLane) then
		return
	end

	self._targetLane = nextLane
	self._targetLateralOffset = self._trackPath:LaneToLateralOffset(self._targetLane, LaneCount)
end

function AiRacerController:onDestroy()
	self:_setInvulnerabilityRenderersVisible(true)
	self:_disposeVehicleBase()

	self._go = nil
	self._transform = nil
	self._trackPath = nil
	self._generatedElements = nil
	self._itemTargets = nil
	self._nearbyElements = nil
	self._nearbyElementGaps = nil
	self._flashRenderers = nil
	self._heldItem = nil
end

function AiRacerController:resetForRestart()
	self._raceDistance = 0
	self._totalRaceDistance = 0
	self._forwardSpeed = 0
	self._currentSpeed = 0
	self._hasFinished = false
	self._postFinishElapsed = -1

	SetVec3(self._postFinishForward, 0, 0, 1)

	self._currentLane = self._startLane or 0
	self._targetLane = self._currentLane
	self._lateralOffset = 0
	self._targetLateralOffset = 0
	self._trackDistance = 0
	self._stableTrackForward = nil
	self._lateralVelocity = 0
	self._laneSwitchActive = false
	self._laneSwitchVisualDirection = 0

	self:_resetOverlapAvoidanceState()

	self._heldItem = nil
	self._invulnerabilityRemainingSec = 0
	self._invulnerabilityFlashEnabled = false

	self:_initShortcutJumpState()

	self._shortcutJumpVisualHeight = 0
	self._airborneForwardRollAngleDeg = 0

	self:clearBuffs()
	self:_resetVehicleBaseForRestart()

	self._forwardSpeed = 0
	self._currentSpeed = self._forwardSpeed

	self:_setInvulnerabilityRenderersVisible(true)

	self._decisionCooldownSec = self:_resolveDecisionStaggerSec()
	self._lastLaneDecisionRaceDistance = self._raceDistance
	self._itemDecisionCooldownSec = 0
	self._nearbyElementsFrame = -1
	self._nearbyElementsRaceDistance = nil

	tabletool.clear(self._nearbyElements)
	tabletool.clear(self._nearbyElementGaps)

	if self._trackPath and self._trackPath:getIsValid() then
		local transform = self._transform

		self._lateralOffset = self._trackPath:LaneToLateralOffset(self._currentLane, LaneCount)
		self._targetLateralOffset = self._lateralOffset

		local startPose = self._trackPath:Sample(self._trackPath:getStartDistance(), self._lateralOffset)
		local rideHeight = select(2, transformhelper.getPos(transform))

		transformhelper.setPos(transform, startPose.position.x, rideHeight, startPose.position.y)

		local fx, fz = startPose.tangent.x, startPose.tangent.y
		local fLen2 = fx * fx + fz * fz

		if fLen2 > 0.001 then
			local invLen = 1 / math.sqrt(fLen2)

			fz = fz * invLen
			fx = fx * invLen

			transformhelper.setEulerAngles(transform, 0, math.deg(math.atan2(fx, fz)), 0)
		end
	end
end

return AiRacerController
