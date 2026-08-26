-- chunkname: @modules/logic/versionactivity3_9/racingcar/logic/feedback/RacingSpecialTrackAirbornePresentation.lua

module("modules.logic.versionactivity3_9.racingcar.logic.feedback.RacingSpecialTrackAirbornePresentation", package.seeall)

local RacingSpecialTrackAirbornePresentation = class("RacingSpecialTrackAirbornePresentation", LuaCompBase)
local JumpPadApproachRules = require("modules.logic.versionactivity3_9.racingcar.logic.RacingJumpPadApproachRules")
local SharedVisualPivotName = "racing_visual_pivot"
local JumpPadApproachPivotName = "racing_jump_pad_approach_pivot"
local IdleMotionPivotName = "racing_idle_motion_pivot"
local AirborneRollPivotName = "racing_special_track_airborne_pivot"
local AnimatorIdleStateName = "idle"
local AnimatorForwardRollStateName = "rot_z"
local AnimatorTurnLaneStateName = "rot_z"
local AnimatorSampleLayerIndex = 0
local UseAnimatorAirborneRoll = true
local HedoneUltimateId = 4
local LayerSafeRollExitDurationSec = 0.67
local PresentationPriority = {
	Airborne = 3,
	Idle = 1,
	TurnLane = 2,
	Ultimate = 4
}
local PresentationKind = {
	Airborne = "airborne",
	Idle = "idle",
	TurnLane = "turnLane",
	Ultimate = "ultimate"
}
local AirbornePresentationType = {
	Transfer = "transfer",
	Default = "default",
	GlideExit = "glideExit",
	GlideEnter = "glideEnter"
}
local AirborneAnimStateMap = {
	[AirbornePresentationType.Default] = AnimatorForwardRollStateName,
	[AirbornePresentationType.Transfer] = AnimatorForwardRollStateName,
	[AirbornePresentationType.GlideEnter] = AnimatorForwardRollStateName,
	[AirbornePresentationType.GlideExit] = AnimatorForwardRollStateName
}
local TurnLaneMaxRollDeg = 12
local TurnLaneGlideMaxRollDeg = 15
local TurnLaneSnowSlopeMaxRollDeg = 14
local SpecialRoadBankMaxRollDeg = 60
local TurnCurveMaxRollDeg = 10
local TurnCurveFullAngleDeg = 12
local TurnLaneEnterSmoothTime = 0.08
local TurnLaneRecoverSmoothTime = 0.18
local TurnCurveLookAheadDistance = 18
local TailWakeConstId = 1005
local DefaultTailWakeThresholds = {
	95,
	125
}
local MinSpeedForIdleMotion = 0.1
local IdleMotionWeightSmoothTime = 0.25
local IdleMotionTurnLaneWeight = 0.25
local IdleMotionAirborneWeight = 0
local TwoPi = math.pi * 2
local IdleMotionTierConfigs = {
	{
		rollDeg = 2,
		frequency = 0.75,
		yawDeg = 0.7,
		pitchDeg = 1.4
	},
	{
		rollDeg = 2.9,
		frequency = 1.05,
		yawDeg = 1,
		pitchDeg = 2
	},
	{
		rollDeg = 3.7,
		frequency = 1.3,
		yawDeg = 1.3,
		pitchDeg = 2.5
	}
}
local RollRecoverSmoothTime = 0.2

function RacingSpecialTrackAirbornePresentation:init(go)
	self._go = go

	if go then
		self._transform = go.transform or nil
	end

	self._playerVehicle = nil
	self._approachPivotGo = nil
	self._approachPivotTransform = nil
	self._approachTargetHeight = 0
	self._approachAppliedHeight = 0
	self._approachJumpStartHeight = 0
	self._idlePivotGo = nil
	self._idlePivotTransform = nil
	self._rollPivotGo = nil
	self._rollPivotTransform = nil
	self._rollDeg = 0
	self._rollRecoverVelocity = 0
	self._rollRecoverTargetDeg = 0
	self._animator = nil
	self._animatorOriginalSpeed = nil
	self._usingAnimatorRoll = false
	self._layerSafeRollSamplingActive = false
	self._layerSafeRollExitRemainingSec = 0
	self._turnLaneRollDeg = 0
	self._turnLaneRollVelocity = 0
	self._idleMotionWeight = 0
	self._idleMotionWeightVelocity = 0
	self._cachedTailWakeFirst = nil
	self._stateNameHashCache = {}
	self._curveLookAheadPoseCache = {
		center = {},
		tangent = {},
		normal = {},
		position = {}
	}
	self._cachedTailWakeSecond = nil
	self._idleMotionPhaseSeed = 0
	self._ultimatePoseSequence = 0
	self._ultimatePoseRequest = nil
	self._airborneRequestCache = {
		rollDeg = 0,
		kind = PresentationKind.Airborne,
		priority = PresentationPriority.Airborne
	}
	self._turnLaneRequestCache = {
		rollDeg = 0,
		kind = PresentationKind.TurnLane,
		priority = PresentationPriority.TurnLane,
		stateName = AnimatorTurnLaneStateName
	}
	self._appliedPivotPosY = nil
	self._appliedPivotPitch = nil
	self._appliedPivotYaw = nil
	self._appliedPivotRoll = nil
	self._idleRotIdentityApplied = false
end

function RacingSpecialTrackAirbornePresentation:initialize(playerVehicle)
	self._playerVehicle = playerVehicle

	if self._playerVehicle and self._playerVehicle.bindVehiclePresentation then
		self._playerVehicle:bindVehiclePresentation(self)
	end

	self._idleMotionPhaseSeed = UnityEngine.Time.time * 0.37

	self:_cacheIdleMotionSpeedThresholds()
	self:_ensureApproachLiftPivot()
	self:_ensureIdleMotionPivot()
	self:_ensureAirborneRollPivot()
end

function RacingSpecialTrackAirbornePresentation:lateUpdate(deltaTime)
	self:_ensureApproachLiftPivot()
	self:_ensureIdleMotionPivot()
	self:_ensureAirborneRollPivot()

	if gohelper.isNil(self._rollPivotTransform) then
		return
	end

	self:_updateJumpPadApproachLift()
	self:_updateLayerSafeRollSampling(deltaTime)

	local var_3_0 = self._playerVehicle

	if self._playerVehicle then
		var_3_0 = self._playerVehicle.isSpecialTrackAirbornePresentationActive

		if self._playerVehicle.isSpecialTrackAirbornePresentationActive then
			local active = self._playerVehicle:isSpecialTrackAirbornePresentationActive()

			if active then
				self._rollDeg = self:_resolveContinuousActiveRoll(self._playerVehicle:resolveSpecialTrackAirborneRollDegrees(deltaTime))
				self._rollRecoverVelocity = 0
				self._rollRecoverTargetDeg = self:_resolveForwardRecoverTarget(self._rollDeg)
			elseif math.abs(self._rollDeg) > 0.01 then
				if not self._rollRecoverTargetDeg then
					local targetRoll = self:_resolveForwardRecoverTarget(self._rollDeg)
					local nextRoll, velocity = Mathf.SmoothDamp(self._rollDeg, targetRoll, self._rollRecoverVelocity, RollRecoverSmoothTime, math.huge, deltaTime)

					self._rollDeg = nextRoll
					self._rollRecoverVelocity = velocity

					if math.abs(targetRoll - self._rollDeg) <= 0.01 then
						self._rollDeg = 0
						self._rollRecoverVelocity = 0
						self._rollRecoverTargetDeg = 0
					end
				end
			else
				self._rollDeg = 0
				self._rollRecoverVelocity = 0
				self._rollRecoverTargetDeg = 0
			end

			local request = self:_resolvePresentationRequest(active, deltaTime)

			self:_updateIdleMotion(deltaTime, request)
			self:_applyPresentationRequest(request)
		end
	end
end

function RacingSpecialTrackAirbornePresentation:setJumpPadApproachTargetHeight(height)
	self._approachTargetHeight = math.max(0, height or 0)
end

function RacingSpecialTrackAirbornePresentation:beginJumpPadApproachHandoff()
	self._approachJumpStartHeight = math.max(self._approachAppliedHeight or 0, self._approachTargetHeight or 0)
end

function RacingSpecialTrackAirbornePresentation:getVehicleFxAttachGo()
	self:_ensureApproachLiftPivot()

	return self._approachPivotGo or self._go
end

function RacingSpecialTrackAirbornePresentation:_updateJumpPadApproachLift()
	if gohelper.isNil(self._approachPivotTransform) then
		return
	end

	if not self._approachTargetHeight then
		local height = 0
		local vehicle = self._playerVehicle

		if vehicle and vehicle.isShortcutJumping and vehicle:isShortcutJumping() then
			local progress = vehicle.getShortcutJumpProgress and vehicle:getShortcutJumpProgress() or 1

			height = JumpPadApproachRules.ResolveJumpHandoffHeight(self._approachJumpStartHeight, progress)
		elseif vehicle and vehicle.isAerialShortcutExitFlightActive and vehicle:isAerialShortcutExitFlightActive() then
			local progress = vehicle.getAerialShortcutExitFlightProgress and vehicle:getAerialShortcutExitFlightProgress() or 1

			height = JumpPadApproachRules.ResolveJumpHandoffHeight(self._approachJumpStartHeight, progress)
		else
			self._approachJumpStartHeight = 0
		end

		if height ~= self._approachAppliedHeight then
			self._approachAppliedHeight = height

			transformhelper.setLocalPos(self._approachPivotTransform, 0, self:_resolveApproachLocalHeight(height), 0)
		end
	end
end

function RacingSpecialTrackAirbornePresentation:_resolveApproachLocalHeight(worldHeight)
	if gohelper.isNil(self._transform) then
		return worldHeight or 0
	end

	local scaleY = math.abs(self._transform.lossyScale.y)

	if scaleY <= 0.0001 then
		return worldHeight or 0
	end

	return (worldHeight or 0) / scaleY
end

function RacingSpecialTrackAirbornePresentation:_updateLayerSafeRollSampling(deltaTime)
	local request = self._ultimatePoseRequest
	local hedoneUltimateActive = request and request.ultimateId == HedoneUltimateId

	self._layerSafeRollExitRemainingSec = hedoneUltimateActive and LayerSafeRollExitDurationSec or math.max(0, (self._layerSafeRollExitRemainingSec or 0) - math.max(0, deltaTime or 0))
	self._layerSafeRollSamplingActive = hedoneUltimateActive or self._layerSafeRollExitRemainingSec > 0
end

function RacingSpecialTrackAirbornePresentation:_resolveContinuousActiveRoll(rollDeg)
	if not self._rollDeg then
		local continuous = Mathf.Repeat(rollDeg or 0, 360)
		local iterationCount = 0

		while self._rollDeg > continuous + 0.001 do
			iterationCount = iterationCount + 1

			if iterationCount > 128 then
				logError(string.format("RacingSpecialTrackAirbornePresentation:_resolveContinuousActiveRoll exceeded iteration limit, rollDeg=%s current=%s continuous=%s", tostring(rollDeg), tostring(self._rollDeg), tostring(continuous)))

				break
			end

			continuous = continuous + 360
		end

		return continuous
	end
end

function RacingSpecialTrackAirbornePresentation:_resolveForwardRecoverTarget(rollDeg)
	local current = math.max(0, rollDeg or 0)

	if current <= 0.01 then
		return 0
	end

	return math.ceil(current / 360) * 360
end

function RacingSpecialTrackAirbornePresentation:resetForRestart()
	self:releaseUltimatePose()

	self._rollDeg = 0
	self._rollRecoverVelocity = 0
	self._rollRecoverTargetDeg = 0
	self._turnLaneRollDeg = 0
	self._turnLaneRollVelocity = 0
	self._idleMotionWeight = 0
	self._idleMotionWeightVelocity = 0
	self._layerSafeRollSamplingActive = false
	self._layerSafeRollExitRemainingSec = 0
	self._approachTargetHeight = 0
	self._approachAppliedHeight = 0
	self._approachJumpStartHeight = 0

	if not gohelper.isNil(self._approachPivotTransform) then
		transformhelper.setLocalPos(self._approachPivotTransform, 0, 0, 0)
	end

	if not gohelper.isNil(self._idlePivotTransform) then
		transformhelper.setLocalRotation(self._idlePivotTransform, 0, 0, 0)
	end

	if not gohelper.isNil(self._rollPivotTransform) then
		transformhelper.setLocalPos(self._rollPivotTransform, 0, 0, 0)
		transformhelper.setLocalRotation(self._rollPivotTransform, 0, 0, 0)
	end

	self._appliedPivotPosY = nil
	self._appliedPivotPitch = nil
	self._appliedPivotYaw = nil
	self._appliedPivotRoll = nil
	self._idleRotIdentityApplied = false

	self:_stopAnimatorRoll()
end

function RacingSpecialTrackAirbornePresentation:onDestroy()
	self:resetForRestart()

	if self._playerVehicle and self._playerVehicle.clearVehiclePresentation then
		self._playerVehicle:clearVehiclePresentation(self)
	end

	self._playerVehicle = nil
	self._go = nil
	self._transform = nil
end

function RacingSpecialTrackAirbornePresentation:_ensureApproachLiftPivot()
	if not gohelper.isNil(self._approachPivotTransform) or gohelper.isNil(self._go) then
		return self._approachPivotTransform
	end

	local visualParent = self._transform:Find(SharedVisualPivotName)

	if gohelper.isNil(visualParent) then
		visualParent = self._transform
	end

	local existing = visualParent:Find(JumpPadApproachPivotName)

	if not gohelper.isNil(existing) then
		self._approachPivotTransform = existing
		self._approachPivotGo = existing.gameObject

		return self._approachPivotTransform
	end

	local children = {}

	for i = 0, visualParent.childCount - 1 do
		local child = visualParent:GetChild(i)

		if not gohelper.isNil(child) and child.name ~= JumpPadApproachPivotName then
			table.insert(children, child)
		end
	end

	self._approachPivotGo = UnityEngine.GameObject.New(JumpPadApproachPivotName)
	self._approachPivotTransform = self._approachPivotGo.transform

	self._approachPivotTransform:SetParent(visualParent, false)
	transformhelper.setLocalPos(self._approachPivotTransform, 0, 0, 0)
	transformhelper.setLocalRotation(self._approachPivotTransform, 0, 0, 0)
	transformhelper.setLocalScale(self._approachPivotTransform, 1, 1, 1)

	for _, child in ipairs(children) do
		if not gohelper.isNil(child) then
			child:SetParent(self._approachPivotTransform, false)
		end
	end

	return self._approachPivotTransform
end

function RacingSpecialTrackAirbornePresentation:requestUltimatePose(pose)
	if type(pose) ~= "table" then
		return nil
	end

	self._ultimatePoseSequence = (self._ultimatePoseSequence or 0) + 1

	local token = self._ultimatePoseSequence

	self._turnLaneRollDeg = 0
	self._turnLaneRollVelocity = 0

	local var_15_0 = {
		kind = PresentationKind.Ultimate,
		priority = PresentationPriority.Ultimate,
		token = token,
		ultimateId = pose.ultimateId,
		stateName = pose.stateName,
		sampleNormalizedTime = pose.sampleNormalizedTime
	}

	var_15_0.positionYOffset = pose.positionYOffset or 0
	var_15_0.pitchDeg = pose.pitchDeg or 0
	var_15_0.yawDeg = pose.yawDeg or 0
	var_15_0.rollDeg = pose.rollDeg or 0
	self._ultimatePoseRequest = var_15_0

	return token
end

function RacingSpecialTrackAirbornePresentation:updateUltimatePose(token, pose)
	local request = self._ultimatePoseRequest

	if not request or not token or token ~= request.token or type(pose) ~= "table" then
		return false
	end

	request.ultimateId = pose.ultimateId or request.ultimateId
	request.stateName = pose.stateName
	request.sampleNormalizedTime = pose.sampleNormalizedTime
	request.positionYOffset = pose.positionYOffset or 0
	request.pitchDeg = pose.pitchDeg or 0
	request.yawDeg = pose.yawDeg or 0
	request.rollDeg = pose.rollDeg or 0

	return true
end

function RacingSpecialTrackAirbornePresentation:releaseUltimatePose(token)
	if not self._ultimatePoseRequest then
		return false
	end

	if token and token ~= self._ultimatePoseRequest.token then
		return false
	end

	self._ultimatePoseRequest = nil

	return true
end

function RacingSpecialTrackAirbornePresentation:_resolveUltimatePoseRequest()
	return self._ultimatePoseRequest
end

function RacingSpecialTrackAirbornePresentation:_resolvePresentationRequest(airborneActive, deltaTime)
	return self:_resolveAirbornePresentationRequest(airborneActive, deltaTime) or self:_resolveUltimatePoseRequest() or self:_resolveTurnLanePresentationRequest(deltaTime) or self:_resolveIdlePresentationRequest(deltaTime)
end

function RacingSpecialTrackAirbornePresentation:_resolveAirbornePresentationRequest(airborneActive, deltaTime)
	if not airborneActive and math.abs(self._rollDeg) <= 0.01 then
		return nil
	end

	self._turnLaneRollDeg = 0
	self._turnLaneRollVelocity = 0

	local airborneType = self:_resolveAirbornePresentationType()
	local request = self._airborneRequestCache

	request.airborneType = airborneType
	request.stateName = self:_resolveAirborneAnimatorStateName(airborneType)
	request.rollDeg = self._rollDeg

	return request
end

function RacingSpecialTrackAirbornePresentation:_resolveTurnLanePresentationRequest(deltaTime)
	local targetRollDeg = self:_resolveTurnLaneTargetRollDeg()

	if math.abs(targetRollDeg) > math.abs((not self._turnLaneRollDeg or nil) and 0) then
		if not TurnLaneEnterSmoothTime then
			local smoothTime = TurnLaneRecoverSmoothTime

			self._turnLaneRollDeg, self._turnLaneRollVelocity = Mathf.SmoothDamp(self._turnLaneRollDeg or 0, targetRollDeg, self._turnLaneRollVelocity or 0, smoothTime, math.huge, deltaTime)

			if math.abs(targetRollDeg) <= 0.01 then
				if math.abs(self._turnLaneRollDeg or 0) <= 0.01 then
					self._turnLaneRollDeg = 0
					self._turnLaneRollVelocity = 0

					return nil
				end
			end

			local request = self._turnLaneRequestCache

			request.rollDeg = self:_normalizeSignedAnimatorAngle(-self._turnLaneRollDeg)

			return request
		end
	end
end

function RacingSpecialTrackAirbornePresentation:_resolveIdlePresentationRequest(deltaTime)
	return nil
end

function RacingSpecialTrackAirbornePresentation:_updateIdleMotion(deltaTime, request)
	if gohelper.isNil(self._idlePivotTransform) then
		return
	end

	local targetWeight = self:_resolveIdleMotionTargetWeight(request)

	self._idleMotionWeight, self._idleMotionWeightVelocity = Mathf.SmoothDamp(self._idleMotionWeight or 0, targetWeight, self._idleMotionWeightVelocity or 0, IdleMotionWeightSmoothTime, math.huge, deltaTime)

	if not self._idleMotionWeight then
		local weight = 0

		if weight <= 0.001 then
			self._idleMotionWeight = 0
			self._idleMotionWeightVelocity = 0

			if not self._idleRotIdentityApplied then
				transformhelper.setLocalRotation(self._idlePivotTransform, 0, 0, 0)

				self._idleRotIdentityApplied = true
			end

			return
		end

		self._idleRotIdentityApplied = false

		local config = IdleMotionTierConfigs[self:_resolveIdleMotionTier()] or IdleMotionTierConfigs[1]
		local phase = (UnityEngine.Time.time + ((not self._idleMotionPhaseSeed or nil) and 0)) * (config.frequency or 1) * TwoPi
		local pitch = math.sin(phase) * ((not config.pitchDeg or nil) and 0) * weight
		local yaw = math.sin(phase * 0.63 + 1.1) * ((not config.yawDeg or nil) and 0) * weight
		local roll = math.sin(phase * 0.82 + 2.3) * ((not config.rollDeg or nil) and 0) * weight

		transformhelper.setLocalRotation(self._idlePivotTransform, pitch, yaw, roll)
	end
end

function RacingSpecialTrackAirbornePresentation:_resolveIdleMotionTargetWeight(request)
	if request and (request.kind == PresentationKind.Ultimate or request.kind == PresentationKind.Airborne) then
		return IdleMotionAirborneWeight
	end

	local playerVehicle = self._playerVehicle

	if request and request.kind == PresentationKind.TurnLane and playerVehicle and math.abs(self:_resolveLaneSwitchRollDeg(playerVehicle)) > 0.01 then
		return IdleMotionTurnLaneWeight
	end

	return 1
end

function RacingSpecialTrackAirbornePresentation:_resolveIdleMotionTier()
	local speed = self:_resolveForwardSpeed()

	if speed <= MinSpeedForIdleMotion then
		return 1
	end

	local firstThreshold, secondThreshold = self:_resolveTailWakeThresholds()

	if secondThreshold <= speed then
		return 3
	elseif firstThreshold <= speed then
		return 2
	end

	return 1
end

function RacingSpecialTrackAirbornePresentation:_resolveForwardSpeed()
	local playerVehicle = self._playerVehicle

	if not playerVehicle or not playerVehicle.getForwardSpeed then
		return 0
	end

	return playerVehicle:getForwardSpeed() or 0
end

function RacingSpecialTrackAirbornePresentation:_resolveTailWakeThresholds()
	return self._cachedTailWakeFirst or DefaultTailWakeThresholds[1], self._cachedTailWakeSecond or DefaultTailWakeThresholds[2]
end

function RacingSpecialTrackAirbornePresentation:_cacheIdleMotionSpeedThresholds()
	local tailWakeValue = self:_getRacingConstValue2(TailWakeConstId)
	local tailWakeValues = tailWakeValue and string.splitToNumber(tailWakeValue, "#") or nil

	if tailWakeValues then
		self._cachedTailWakeFirst = tailWakeValues[1] or DefaultTailWakeThresholds[1]
	end

	if tailWakeValues then
		self._cachedTailWakeSecond = tailWakeValues[2] or DefaultTailWakeThresholds[2]
	end

	if self._cachedTailWakeFirst > self._cachedTailWakeSecond then
		self._cachedTailWakeFirst, self._cachedTailWakeSecond = self._cachedTailWakeSecond, self._cachedTailWakeFirst
	end
end

function RacingSpecialTrackAirbornePresentation:_getRacingConstValue2(constId)
	local var_29_0 = lua_racing_const

	if lua_racing_const then
		var_29_0 = lua_racing_const.configDict

		if lua_racing_const.configDict then
			local dict = lua_racing_const.configDict[13920]
			local co = dict and dict[constId]

			if not co then
				return nil
			end

			return (co.value2 and co.value2 ~= "" or nil) and (co.value2 or co.value)
		end
	end
end

function RacingSpecialTrackAirbornePresentation:_resolveAirborneAnimatorStateName(airborneType)
	return AirborneAnimStateMap[airborneType] or AirborneAnimStateMap[AirbornePresentationType.Default]
end

function RacingSpecialTrackAirbornePresentation:_resolveAirbornePresentationType()
	local playerVehicle = self._playerVehicle

	if not playerVehicle then
		return AirbornePresentationType.Default
	end

	if (playerVehicle._routeTransferFlightRemainingSec or 0) > 0 then
		return AirbornePresentationType.Transfer
	end

	if (playerVehicle._glideEntryFlightRemainingSec or 0) > 0 then
		return AirbornePresentationType.GlideEnter
	end

	if playerVehicle._activeGlideRoute then
		return AirbornePresentationType.GlideExit
	end

	return AirbornePresentationType.Default
end

function RacingSpecialTrackAirbornePresentation:_resolveTurnLaneTargetRollDeg()
	local playerVehicle = self._playerVehicle

	if not playerVehicle then
		return 0
	end

	local roadBankRoll = self:_resolveSpecialRoadBankRollDeg(playerVehicle)
	local laneRoll = self:_resolveLaneSwitchRollDeg(playerVehicle)

	if math.abs(laneRoll) > 0.01 then
		return Mathf.Clamp(roadBankRoll + laneRoll, -SpecialRoadBankMaxRollDeg, SpecialRoadBankMaxRollDeg)
	end

	return Mathf.Clamp(roadBankRoll + self:_resolveCurveRollDeg(playerVehicle), -SpecialRoadBankMaxRollDeg, SpecialRoadBankMaxRollDeg)
end

function RacingSpecialTrackAirbornePresentation:_resolveSpecialRoadBankRollDeg(playerVehicle)
	if not playerVehicle.resolveCurrentSpecialRoadBankDegrees then
		return 0
	end

	local roadBank = playerVehicle:resolveCurrentSpecialRoadBankDegrees() or 0

	return -Mathf.Clamp(roadBank, -SpecialRoadBankMaxRollDeg, SpecialRoadBankMaxRollDeg)
end

function RacingSpecialTrackAirbornePresentation:_resolveLaneSwitchRollDeg(playerVehicle)
	if playerVehicle._activeGlideRoute then
		local delta = (playerVehicle._glideTargetLateralOffset or 0) - (playerVehicle._glideLateralOffset or 0)

		if math.abs(delta) > 0.01 then
			return Mathf.Clamp(delta / math.max(0.01, playerVehicle._activeGlideRoute.laneWidth or 4), -1, 1) * TurnLaneGlideMaxRollDeg
		end
	end

	if playerVehicle._activeSnowSlopeRoute then
		if not playerVehicle._snowSlopeSlideDirection then
			do
				local direction = 0

				if math.abs(direction) > 0.01 then
					return Mathf.Clamp(direction, -1, 1) * TurnLaneSnowSlopeMaxRollDeg
				end
			end

			if playerVehicle._laneSwitchActive then
				if not playerVehicle._laneSwitchVisualDirection then
					local direction = 0

					if math.abs(direction) <= 0.01 then
						direction = (playerVehicle._lateralVelocity or 0) > 0 and 1 or -1
					end

					return Mathf.Clamp(direction, -1, 1) * TurnLaneMaxRollDeg
				end
			end
		end
	end

	return 0
end

function RacingSpecialTrackAirbornePresentation:_resolveCurveRollDeg(playerVehicle)
	local trackPath = playerVehicle._trackPath

	if not trackPath or not trackPath:getIsValid() then
		return 0
	end

	local currentForward = playerVehicle._stableTrackForward

	if not currentForward then
		return 0
	end

	local cfx, cfy, cfz = currentForward.x, currentForward.y, currentForward.z

	if cfx * cfx + cfy * cfy + cfz * cfz <= 0.001 then
		return 0
	end

	local pose = self._curveLookAheadPoseCache

	trackPath:SampleTo((playerVehicle._trackDistance or 0) + TurnCurveLookAheadDistance, playerVehicle._lateralOffset or 0, pose)

	local tangent = pose.tangent

	if not tangent then
		return 0
	end

	local fx, fz = tangent.x, tangent.y

	if fx * fx + fz * fz <= 0.001 then
		return 0
	end

	local cx, cz = currentForward.x, currentForward.z
	local dot = cx * fx + cz * fz
	local crossY = cz * fx - cx * fz
	local signedAngle = math.atan2(crossY, dot) * Mathf.Rad2Deg
	local roll01 = Mathf.Clamp(signedAngle / TurnCurveFullAngleDeg, -1, 1)

	return roll01 * TurnCurveMaxRollDeg
end

function RacingSpecialTrackAirbornePresentation:_normalizeSignedAnimatorAngle(angleDeg)
	return Mathf.Repeat(angleDeg or 0, 360)
end

function RacingSpecialTrackAirbornePresentation:_applyPresentationRequest(request)
	if request then
		if not request.positionYOffset then
			local posY = 0

			if posY ~= self._appliedPivotPosY then
				self._appliedPivotPosY = posY

				transformhelper.setLocalPos(self._rollPivotTransform, 0, posY, 0)
			end

			local kind = request and request.kind

			if (kind == PresentationKind.Ultimate or kind == PresentationKind.Airborne or kind == PresentationKind.TurnLane) and self:_trySampleAnimatorState(request) then
				self:_applyRollPivotRotation(0, 0, 0)

				return
			end

			self:_stopAnimatorRoll()

			local var_37_1

			if request then
				var_37_1 = request.pitchDeg or 0

				local var_37_2

				if request then
					var_37_2 = request.yawDeg or 0

					local var_37_3

					if request then
						var_37_3 = request.rollDeg or self._rollDeg
					end
				end
			end

			self:_applyRollPivotRotation(var_37_1, var_37_2, var_37_3)
		end
	end
end

function RacingSpecialTrackAirbornePresentation:_applyRollPivotRotation(pitchDeg, yawDeg, rollDeg)
	if pitchDeg == self._appliedPivotPitch and yawDeg == self._appliedPivotYaw and rollDeg == self._appliedPivotRoll then
		return
	end

	self._appliedPivotPitch = pitchDeg
	self._appliedPivotYaw = yawDeg
	self._appliedPivotRoll = rollDeg

	transformhelper.setLocalRotation(self._rollPivotTransform, pitchDeg, yawDeg, rollDeg)
end

function RacingSpecialTrackAirbornePresentation:_trySampleAnimatorState(request)
	if not UseAnimatorAirborneRoll then
		return false
	end

	if self._playerVehicle and self._playerVehicle.isBuffAnimPresentationActive and self._playerVehicle:isBuffAnimPresentationActive() then
		return false
	end

	local stateName = request and request.stateName

	if self._layerSafeRollSamplingActive and stateName == AnimatorForwardRollStateName then
		return false
	end

	local animator = self:_getAirborneRollAnimator()

	if gohelper.isNil(animator) or not self:_hasAnimatorState(animator, stateName) then
		return false
	end

	if not self._usingAnimatorRoll then
		self._animatorOriginalSpeed = animator.speed
		self._usingAnimatorRoll = true
		animator.speed = 0
	end

	animator.enabled = true

	local normalizedTime = request.sampleNormalizedTime

	if normalizedTime == nil then
		normalizedTime = Mathf.Repeat(request.rollDeg or 0, 360) / 360
	end

	local stateHash = self:_getCachedStateHash(stateName)

	animator:Play(stateHash, AnimatorSampleLayerIndex, Mathf.Repeat(normalizedTime, 1))

	return true
end

function RacingSpecialTrackAirbornePresentation:_stopAnimatorRoll()
	if not self._usingAnimatorRoll then
		return
	end

	local animator = self:_getAirborneRollAnimator()

	if not gohelper.isNil(animator) then
		animator.speed = self._animatorOriginalSpeed or 1

		if self:_hasAnimatorState(animator, AnimatorIdleStateName) then
			local idleHash = self:_getCachedStateHash(AnimatorIdleStateName)

			animator:Play(idleHash, AnimatorSampleLayerIndex, 0)
		end
	end

	self._animatorOriginalSpeed = nil
	self._usingAnimatorRoll = false
end

function RacingSpecialTrackAirbornePresentation:_getAirborneRollAnimator()
	if not gohelper.isNil(self._animator) then
		return self._animator
	end

	if gohelper.isNil(self._go) then
		return nil
	end

	self._animator = self._go:GetComponentInChildren(typeof(UnityEngine.Animator))

	return self._animator
end

function RacingSpecialTrackAirbornePresentation:_getCachedStateHash(stateName)
	if not stateName then
		return 0
	end

	local cache = self._stateNameHashCache
	local hash = cache[stateName]

	if not hash then
		hash = UnityEngine.Animator.StringToHash(stateName)
		cache[stateName] = hash
	end

	return hash
end

function RacingSpecialTrackAirbornePresentation:_hasAnimatorState(animator, stateName)
	if gohelper.isNil(animator) or string.nilorempty(stateName) then
		return false
	end

	return animator:HasState(AnimatorSampleLayerIndex, self:_getCachedStateHash(stateName))
end

function RacingSpecialTrackAirbornePresentation:_ensureAirborneRollPivot()
	if not gohelper.isNil(self._rollPivotTransform) or gohelper.isNil(self._go) then
		return
	end

	local visualParent = self:_ensureIdleMotionPivot()

	if gohelper.isNil(visualParent) then
		visualParent = self._transform
	end

	local existing = visualParent:Find(AirborneRollPivotName)

	if not gohelper.isNil(existing) then
		self._rollPivotTransform = existing
		self._rollPivotGo = existing.gameObject

		return
	end

	local children = {}

	for i = 0, visualParent.childCount - 1 do
		local child = visualParent:GetChild(i)

		if not gohelper.isNil(child) and child.name ~= AirborneRollPivotName then
			table.insert(children, child)
		end
	end

	self._rollPivotGo = UnityEngine.GameObject.New(AirborneRollPivotName)
	self._rollPivotTransform = self._rollPivotGo.transform

	self._rollPivotTransform:SetParent(visualParent, false)
	transformhelper.setLocalPos(self._rollPivotTransform, 0, 0, 0)
	transformhelper.setLocalRotation(self._rollPivotTransform, 0, 0, 0)
	transformhelper.setLocalScale(self._rollPivotTransform, 1, 1, 1)

	for _, child in ipairs(children) do
		if not gohelper.isNil(child) then
			child:SetParent(self._rollPivotTransform, false)
		end
	end
end

function RacingSpecialTrackAirbornePresentation:_ensureIdleMotionPivot()
	if not gohelper.isNil(self._idlePivotTransform) or gohelper.isNil(self._go) then
		return self._idlePivotTransform
	end

	local visualParent = self:_ensureApproachLiftPivot()

	if gohelper.isNil(visualParent) then
		visualParent = self._transform
	end

	local existing = visualParent:Find(IdleMotionPivotName)

	if not gohelper.isNil(existing) then
		self._idlePivotTransform = existing
		self._idlePivotGo = existing.gameObject

		return self._idlePivotTransform
	end

	local children = {}

	for i = 0, visualParent.childCount - 1 do
		local child = visualParent:GetChild(i)

		if not gohelper.isNil(child) and child.name ~= IdleMotionPivotName then
			table.insert(children, child)
		end
	end

	self._idlePivotGo = UnityEngine.GameObject.New(IdleMotionPivotName)
	self._idlePivotTransform = self._idlePivotGo.transform

	self._idlePivotTransform:SetParent(visualParent, false)
	transformhelper.setLocalPos(self._idlePivotTransform, 0, 0, 0)
	transformhelper.setLocalRotation(self._idlePivotTransform, 0, 0, 0)
	transformhelper.setLocalScale(self._idlePivotTransform, 1, 1, 1)

	for _, child in ipairs(children) do
		if not gohelper.isNil(child) then
			child:SetParent(self._idlePivotTransform, false)
		end
	end

	return self._idlePivotTransform
end

return RacingSpecialTrackAirbornePresentation
