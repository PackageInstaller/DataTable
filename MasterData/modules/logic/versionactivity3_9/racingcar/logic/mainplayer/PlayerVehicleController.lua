-- chunkname: @modules/logic/versionactivity3_9/racingcar/logic/mainplayer/PlayerVehicleController.lua

module("modules.logic.versionactivity3_9.racingcar.logic.mainplayer.PlayerVehicleController", package.seeall)

local PlayerVehicleController = class("PlayerVehicleController", RacingVehicleControllerBase)
local SteeringHoldRampSec = 0.55
local SteeringHoldMinSpeedScale = 0.5
local PlayerRacerId = "player"
local TrackElementType = RacingTrackElementSpawner.TrackElementType
local InvulnerabilityFlashHz = 10
local VEC3_UP = Vector3(0, 1, 0)
local VEC3_ZERO = Vector3(0, 0, 0)
local _tangentCache = Vector3(0, 0, 1)
local _futureTangentCache = Vector3(0, 0, 1)
local _worldPosCache = Vector3(0, 0, 0)
local _horizVelCache = Vector3(0, 0, 0)
local _forwardCache = Vector3(0, 0, 1)
local _specialRouteForwardResult = Vector3(0, 0, 1)
local _glideFacingResult = Vector3(0, 0, 1)
local _glideVisualForwardResult = Vector3(0, 0, 1)
local _glidePreviewForwardResult = Vector3(0, 0, 1)
local _glideLandingPositionResult = Vector3(0, 0, 0)
local _basePosCache = Vector3(0, 0, 0)
local _waterfallRadialCache = Vector3(0, 0, 1)
local _waterfallPositionResult = Vector3(0, 0, 0)
local _waterfallTangentResult = Vector3(0, 1, 0)
local _waterfallCurveUpResult = Vector3(0, 0, 1)
local _specialRoadPositionResult = Vector3(0, 0, 0)
local _waterfallVisualForwardCache = Vector3(0, 1, 0)
local _waterfallVisualUpCache = Vector3(0, 0, 1)
local _movementVelCache = Vector3(0, 0, 0)
local _position2DCache = {
	x = 0,
	y = 0
}
local _cameraFollowResult = Vector3(0, 0, 0)
local _cameraOffsetResult = Vector3(0, 0, 0)

local function SlerpUnitXZ(ax, az, bx, bz, t)
	local dot = ax * bx + az * bz

	if dot > 1 then
		dot = 1
	elseif dot < -1 then
		dot = -1
	end

	if dot > 0.999999 or dot < -0.999999 then
		local nx, nz = ax + (bx - ax) * t, az + (bz - az) * t
		local sqr = nx * nx + nz * nz

		if sqr > 1e-06 then
			local inv = 1 / math.sqrt(sqr)

			return nx * inv, nz * inv
		end

		return bx, bz
	end

	local theta = math.acos(dot)
	local sinTheta = math.sin(theta)
	local w1 = math.sin((1 - t) * theta) / sinTheta
	local w2 = math.sin(t * theta) / sinTheta

	return ax * w1 + bx * w2, az * w1 + bz * w2
end

local function FlatForwardXYZ(x, z)
	local sqr = x * x + z * z

	if sqr > 0.001 then
		local inv = 1 / math.sqrt(sqr)

		return x * inv, 0, z * inv
	end

	return 0, 0, 1
end

local function CreateFlatForward(x, z)
	local fx, fy, fz = FlatForwardXYZ(x, z)

	return Vector3(fx, fy, fz)
end

local function SetVec3(target, x, y, z)
	target.x, target.y, target.z = x, y, z

	return target
end

local function SlerpUnitVec3(ax, ay, az, bx, by, bz, t)
	local aSqr = ax * ax + ay * ay + az * az

	if aSqr > 1e-06 then
		local inv = 1 / math.sqrt(aSqr)

		az = az * inv
		ay = ay * inv
		ax = ax * inv
	end

	local bSqr = bx * bx + by * by + bz * bz

	if bSqr > 1e-06 then
		local inv = 1 / math.sqrt(bSqr)

		bz = bz * inv
		by = by * inv
		bx = bx * inv
	end

	local dot = ax * bx + ay * by + az * bz

	if dot > 1 then
		dot = 1
	elseif dot < -1 then
		dot = -1
	end

	if dot > 0.999999 or dot < -0.999999 then
		local nx, ny, nz = ax + (bx - ax) * t, ay + (by - ay) * t, az + (bz - az) * t
		local sqr = nx * nx + ny * ny + nz * nz

		if sqr > 1e-06 then
			local inv = 1 / math.sqrt(sqr)

			return nx * inv, ny * inv, nz * inv
		end

		return bx, by, bz
	end

	local theta = math.acos(dot)
	local sinTheta = math.sin(theta)
	local w1 = math.sin((1 - t) * theta) / sinTheta
	local w2 = math.sin(t * theta) / sinTheta

	return ax * w1 + bx * w2, ay * w1 + by * w2, az * w1 + bz * w2
end

local function ResolvePitchYawDeg(x, y, z)
	local sqr = x * x + y * y + z * z

	if sqr > 1e-06 then
		local inv = 1 / math.sqrt(sqr)

		z = z * inv
		y = y * inv
		x = x * inv
	else
		z = 1
		y = 0
		x = 0
	end

	return -math.deg(math.asin(Mathf.Clamp(y, -1, 1))), math.deg(math.atan2(x, z))
end

local function NormalizeQuaternionXYZW(x, y, z, w)
	local sqr = x * x + y * y + z * z + w * w

	if sqr <= 1e-07 then
		return 0, 0, 0, 1
	end

	local inv = 1 / math.sqrt(sqr)

	return x * inv, y * inv, z * inv, w * inv
end

local function MultiplyQuaternionXYZW(ax, ay, az, aw, bx, by, bz, bw)
	return aw * bx + ax * bw + ay * bz - az * by, aw * by - ax * bz + ay * bw + az * bx, aw * bz + ax * by - ay * bx + az * bw, aw * bw - ax * bx - ay * by - az * bz
end

local function SlerpQuaternionXYZW(ax, ay, az, aw, bx, by, bz, bw, t)
	ax, ay, az, aw = NormalizeQuaternionXYZW(ax, ay, az, aw)
	bx, by, bz, bw = NormalizeQuaternionXYZW(bx, by, bz, bw)

	local dot = ax * bx + ay * by + az * bz + aw * bw

	if dot < 0 then
		dot = -dot
		bw = -bw
		bz = -bz
		by = -by
		bx = -bx
	end

	dot = math.max(-1, math.min(1, dot))
	t = Mathf.Clamp01(t or 0)

	local rx, ry, rz, rw

	if dot > 0.9995 then
		rx = ax + (bx - ax) * t
		ry = ay + (by - ay) * t
		rz = az + (bz - az) * t
		rw = aw + (bw - aw) * t
	else
		local theta = math.acos(dot)
		local sinTheta = math.sin(theta)
		local aWeight = math.sin((1 - t) * theta) / sinTheta
		local bWeight = math.sin(t * theta) / sinTheta

		rx = ax * aWeight + bx * bWeight
		ry = ay * aWeight + by * bWeight
		rz = az * aWeight + bz * bWeight
		rw = aw * aWeight + bw * bWeight
	end

	return NormalizeQuaternionXYZW(rx, ry, rz, rw)
end

local function LookRotationQuaternionXYZW(fx, fy, fz, ux, uy, uz)
	local forwardSqr = fx * fx + fy * fy + fz * fz

	if forwardSqr <= 1e-06 then
		forwardSqr = 1
		fz = 1
		fy = 0
		fx = 0
	end

	local forwardInv = 1 / math.sqrt(forwardSqr)

	fz = fz * forwardInv
	fy = fy * forwardInv
	fx = fx * forwardInv

	local rx = uy * fz - uz * fy
	local ry = uz * fx - ux * fz
	local rz = ux * fy - uy * fx
	local rightSqr = rx * rx + ry * ry + rz * rz

	if rightSqr <= 1e-06 then
		local fallbackUx, fallbackUy, fallbackUz = 0, 1, 0

		if math.abs(fy) > 0.999 then
			fallbackUz = 1
			fallbackUy = 0
			fallbackUx = 0
		end

		rx = fallbackUy * fz - fallbackUz * fy
		ry = fallbackUz * fx - fallbackUx * fz
		rz = fallbackUx * fy - fallbackUy * fx
		rightSqr = rx * rx + ry * ry + rz * rz
	end

	local rightInv = 1 / math.sqrt(rightSqr)

	rz = rz * rightInv
	ry = ry * rightInv
	rx = rx * rightInv

	local correctedUpX = fy * rz - fz * ry
	local correctedUpY = fz * rx - fx * rz
	local correctedUpZ = fx * ry - fy * rx
	local m00, m01, m02 = rx, correctedUpX, fx
	local m10, m11, m12 = ry, correctedUpY, fy
	local m20, m21, m22 = rz, correctedUpZ, fz
	local trace = m00 + m11 + m22
	local qx, qy, qz, qw

	if trace > 0 then
		local s = math.sqrt(trace + 1) * 2

		qw = 0.25 * s
		qx = (m21 - m12) / s
		qy = (m02 - m20) / s
		qz = (m10 - m01) / s
	elseif m11 < m00 and m22 < m00 then
		local s = math.sqrt(1 + m00 - m11 - m22) * 2

		qw = (m21 - m12) / s
		qx = 0.25 * s
		qy = (m01 + m10) / s
		qz = (m02 + m20) / s
	elseif m22 < m11 then
		local s = math.sqrt(1 + m11 - m00 - m22) * 2

		qw = (m02 - m20) / s
		qx = (m01 + m10) / s
		qy = 0.25 * s
		qz = (m12 + m21) / s
	else
		local s = math.sqrt(1 + m22 - m00 - m11) * 2

		qw = (m10 - m01) / s
		qx = (m02 + m20) / s
		qy = (m12 + m21) / s
		qz = 0.25 * s
	end

	return NormalizeQuaternionXYZW(qx, qy, qz, qw)
end

local function FromToQuaternionXYZW(ax, ay, az, bx, by, bz)
	local aSqr = ax * ax + ay * ay + az * az
	local bSqr = bx * bx + by * by + bz * bz

	if aSqr <= 1e-06 or bSqr <= 1e-06 then
		return 0, 0, 0, 1
	end

	local aInv = 1 / math.sqrt(aSqr)
	local bInv = 1 / math.sqrt(bSqr)

	az = az * aInv
	ay = ay * aInv
	ax = ax * aInv
	bz = bz * bInv
	by = by * bInv
	bx = bx * bInv

	local dot = math.max(-1, math.min(1, ax * bx + ay * by + az * bz))

	if dot < -0.999999 then
		local qx, qy, qz

		if math.abs(ax) < 0.9 then
			qz = -ay
			qy = az
			qx = 0
		else
			qz = ax
			qy = 0
			qx = -az
		end

		local inv = 1 / math.sqrt(qx * qx + qy * qy + qz * qz)

		return qx * inv, qy * inv, qz * inv, 0
	end

	local qx = ay * bz - az * by
	local qy = az * bx - ax * bz
	local qz = ax * by - ay * bx

	return NormalizeQuaternionXYZW(qx, qy, qz, 1 + dot)
end

local function QuaternionForwardXYZ(x, y, z, w)
	return 2 * (x * z + w * y), 2 * (y * z - w * x), 1 - 2 * (x * x + y * y)
end

local function QuaternionUpXYZ(x, y, z, w)
	return 2 * (x * y - w * z), 1 - 2 * (x * x + z * z), 2 * (y * z + w * x)
end

local function CacheWaterfallEntryRotation(controller, rotation)
	local x, y, z, w = rotation.x, rotation.y, rotation.z, rotation.w

	controller._waterfallClimbEntryStartRotationX = x
	controller._waterfallClimbEntryStartRotationY = y
	controller._waterfallClimbEntryStartRotationZ = z
	controller._waterfallClimbEntryStartRotationW = w
	controller._waterfallClimbOrientationX = x
	controller._waterfallClimbOrientationY = y
	controller._waterfallClimbOrientationZ = z
	controller._waterfallClimbOrientationW = w
end

local function ApplyWaterfallRotation(controller, transform, x, y, z, w)
	x, y, z, w = NormalizeQuaternionXYZW(x, y, z, w)
	controller._waterfallClimbOrientationX = x
	controller._waterfallClimbOrientationY = y
	controller._waterfallClimbOrientationZ = z
	controller._waterfallClimbOrientationW = w

	transformhelper.setRotation(transform, x, y, z, w)
end

local PerfectDodgeInvulnerabilitySec = 0.35
local ObstacleSlowdownBuffType = 1012
local PerfectDodgeEnergyBaseConstId = 1014
local PerfectDodgeEnergyPerComboConstId = 1015
local BuffHeightTakeoffSmoothTime = 0.8
local BuffHeightLandingSmoothTime = 0.8
local BuffHeightFlyingEpsilon = 0.1
local TrackForwardJitterDeadAngleDeg = 2
local TrackForwardJitterDeadDot = math.cos(TrackForwardJitterDeadAngleDeg * math.pi / 180)
local TrackDisplayPositionSmoothTime = 0
local TrackVisualPoseSampleRadius = 4.5
local TrackDisplayPositionSmoothResumeDelaySec = 0.35
local ManualSpaceJumpEnabled = false
local WaterDropTapProgressConsumeRate = 0.75
local WaterDropTapPendingProgressCap = 0.45
local WaterDropLandingBlendDurationSec = 0.4
local WaterDropLandingSinkDepth = 0.5
local WaterDropLandingSinkStart01 = 0.72
local WaterDropExitFlightArcHeight = 3.5
local WaterDropLandingPositionPrepareDistance = 25
local WaterDropLandingPosturePrepareDistance = 12
local WaterfallClimbCameraOutwardOffset = 14
local WaterfallClimbOrientationFollowRate = 12
local WaterfallClimbEntryOrientationBlendSec = 0.35
local WaterfallClimbEntryRadialAlignStart01 = 0.5
local WaterfallClimbEntryReverseDotThreshold = -0.999
local WaterfallClimbExitFlightArcHeight = 8
local GlideEntryFlightDurationSec = 1
local GlideEntryFlightArcHeight = 7
local GlideEntryHandoffStart01 = 0.8
local GlideEntryHandoffAdvanceSec = 0.2
local GlideEntryHandoffMaxProgress = 0.12
local GlideCameraAnchorVehicleWeight = 0.18
local GlideLandingCameraAnchorVehicleWeight = 0.85
local GlideFacingPreviewDistance = 25
local GlideFacingPreviewWeight = 0.75
local GlideFacingMaxVelocityInfluence = 0.9
local GlideFacingMaxFollowRate = 24

local function ResolveGlideFacingPreviewDistance(length, distance)
	return Mathf.Clamp(math.max(0, distance or 0) + GlideFacingPreviewDistance, 0, math.max(0, length or 0))
end

local function ResolveGlideFacingResponse(angleDegrees, baseVelocityInfluence, baseFollowRate)
	local absoluteAngle = math.abs(angleDegrees or 0)
	local angle01 = Mathf.Clamp01((absoluteAngle - 5) / 55)
	local easedAngle = angle01 * angle01 * (3 - 2 * angle01)
	local minimumInfluence = Mathf.Clamp01(baseVelocityInfluence or 0)
	local minimumFollowRate = math.max(0, baseFollowRate or 0)
	local velocityInfluence = Mathf.Lerp(minimumInfluence, math.max(minimumInfluence, GlideFacingMaxVelocityInfluence), easedAngle)
	local reverseGuard = Mathf.Clamp01((180 - absoluteAngle) / 75)

	return velocityInfluence * reverseGuard, Mathf.Lerp(minimumFollowRate, math.max(minimumFollowRate, GlideFacingMaxFollowRate), easedAngle)
end

local GlideRotationFollowRate = 10
local GlideLandingFullRollDegrees = 360
local GlideSpeedLineTierOverride = 1
local GlideTailWakeTierOverride = 2
local SpecialTrackLandingBurstPeakSpeedMultiplier = 1.2
local SpecialTrackLandingBurstSpeedLineTierOverride = 2
local SpecialTrackLandingBurstTailWakeTierOverride = 3
local LRRU = LayeredRouteRuntimeUtility
local AerialShortcut = require("modules.logic.versionactivity3_9.racingcar.logic.specialtrack.AerialShortcut")
local JumpPadApproachRules = require("modules.logic.versionactivity3_9.racingcar.logic.RacingJumpPadApproachRules")
local SnowSlope = require("modules.logic.versionactivity3_9.racingcar.logic.specialtrack.SnowSlope")
local Glide = require("modules.logic.versionactivity3_9.racingcar.logic.specialtrack.Glide")
local WaterDrop = require("modules.logic.versionactivity3_9.racingcar.logic.specialtrack.WaterDrop")
local WaterfallClimb = require("modules.logic.versionactivity3_9.racingcar.logic.specialtrack.WaterfallClimb")
local RouteTransfer = require("modules.logic.versionactivity3_9.racingcar.logic.specialtrack.RouteTransfer")

local function ResolveNearestLoopProjectionDistance(trackPath, currentDistance, projectedDistance)
	if not trackPath or not trackPath:getIsLoop() then
		return projectedDistance
	end

	local trackLength = trackPath:getTrackLength()

	if trackLength <= 0.0001 then
		return projectedDistance
	end

	local nearestDistance = projectedDistance
	local halfTrackLength = trackLength * 0.5

	if halfTrackLength < nearestDistance - currentDistance then
		nearestDistance = nearestDistance - trackLength
	elseif halfTrackLength < currentDistance - nearestDistance then
		nearestDistance = nearestDistance + trackLength
	end

	return math.max(trackPath:getStartDistance(), math.min(trackPath:getEndDistance(), nearestDistance))
end

local function ResolveLandingSinkOffset(progress, depth, start01)
	local sink01 = Mathf.Clamp01((progress - start01) / math.max(0.001, 1 - start01))

	if sink01 <= 0 or sink01 >= 1 then
		return 0
	end

	return -math.max(0, depth or 0) * math.sin(sink01 * math.pi)
end

local ShortcutSideLeft = "Left"

local function NormalShortcutCanEnter(shortcut, mainDistance, laneIndex, laneCount, laneInput)
	if not shortcut or shortcut.enabled == false or laneCount < 1 then
		return false
	end

	local triggerEnd = shortcut.entryMainDistance + math.max(0, shortcut.entryTriggerLength or 0)

	if mainDistance < shortcut.entryMainDistance or triggerEnd < mainDistance then
		return false
	end

	if AerialShortcut.CanAutoEnterLaneFork(shortcut, mainDistance, laneIndex, laneCount) then
		return true
	end

	local isLeft = shortcut.side == ShortcutSideLeft
	local requiredLane = isLeft and 0 or laneCount - 1
	local requiredInput = isLeft and 1 or -1

	return laneIndex == requiredLane and Mathf.Sign(laneInput) == Mathf.Sign(requiredInput)
end

local function NormalShortcutResolveEntryLaneIndex(side, shortcutLaneCount)
	local laneCount = math.max(1, shortcutLaneCount or 1)

	if side == ShortcutSideLeft then
		return 0
	end

	return laneCount - 1
end

local function NormalShortcutMapRaceDistance(shortcut, shortcutLocalDistance)
	if not shortcut or not shortcut.path or not shortcut.path.centerline or #shortcut.path.centerline == 0 then
		return (shortcut or nil) and (shortcut.entryMainDistance or 0)
	end

	local centerline = shortcut.path.centerline
	local length = math.max(0.01, centerline[#centerline].distance)
	local t = Mathf.Clamp01(shortcutLocalDistance / length)

	return shortcut.entryMainDistance + (shortcut.exitMainDistance - shortcut.entryMainDistance) * t
end

local TrackForwardFollowSpeedFactor = 2
local MinTrackForwardOrientationSmoothTime = 0.075
local MaxTrackForwardYawFollowRate = 22
local DefaultAirborneHeadingFollowSharpness = 22

function PlayerVehicleController:init(go)
	PlayerVehicleController.super.init(self, go)

	self._go = go
	self._ultimateSpeedLineTierOverride = 0
	self._ultimateTailWakeTierOverride = 0

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
	self._visualSampleBeforePoseCache = {
		center = {},
		tangent = {},
		normal = {},
		position = {}
	}
	self._visualSampleAfterPoseCache = {
		center = {},
		tangent = {},
		normal = {},
		position = {}
	}
	self._projectionCache = {}
	self._glideLandingPoseCache = {
		center = {},
		tangent = {},
		normal = {},
		position = {}
	}
	self._stableTrackForward = Vector3(0, 0, 1)
	self._cameraTrackForward = Vector3(0, 0, 1)
	self._smoothedVisualForward = Vector3(0, 0, 1)
	self._estimatedHorizontalVelocity = Vector3(0, 0, 0)
	self._lastHorizontalPosition = Vector3(0, 0, 0)
	self._smoothedTrackDisplayPosition = Vector3(0, 0, 0)
	self._trackDisplayPositionDampVelocity = Vector3(0, 0, 0)
	self._airborneHorizontalVelocity = Vector3(0, 0, 0)
	self._airborneForward = Vector3(0, 0, 1)
	self._airborneRight = Vector3(1, 0, 0)
	self._specialRouteSmoothedForward = Vector3(0, 0, 1)
	self._specialRouteForwardDampVelocity = Vector3(0, 0, 0)

	self:_initVehicleBase(PlayerRacerId)

	self._runtimeConfig = nil
	self._vehicleConfig = {}
	self._drivePowerConfig = {}
	self._boostConfig = {}
	self._collisionConfig = {}
	self._controlConfig = {}
	self._trackPath = nil
	self._trackDistance = 0
	self._totalRaceDistance = 0
	self._completedLapDistance = 0
	self._specialRaceDistanceFrozen = false
	self._specialRaceEntryTotalDistance = 0
	self._specialRaceEntryMainDistance = 0
	self._lateralOffset = 0
	self._hasTrackState = false
	self._lastReportedLap = 0
	self._currentEnergy = 0
	self._coinCount = 0
	self._perfectDodgeCombo = 0
	self._steeringInput = 0
	self._smoothedSteeringInput = 0
	self._flashRenderers = nil
	self._renderersVisible = true
	self._invulnerabilityFlashEnabled = false
	self._perfectDodgeInvulnerabilityRemainingSec = 0
	self._hasPlayerFinished = false
	self._postFinishElapsed = -1
	self._boostRemainingSec = 0
	self._boostMultiplier = 0
	self._boostTargetMultiplier = 0
	self._lastBoostTapTime = -math.huge
	self._isUltimateBoostActive = false
	self._isUsingUltimateSkill = false
	self._ultimateBoostTriggerCount = 0
	self._ringRunnerSpeedMultiplier = 1
	self._lateralVelocity = 0
	self._lateralVelocityDampVelocity = 0
	self._steeringHoldDurationSec = 0
	self._steeringHoldDirection = 0
	self._previousLaneSwitchInput = 0
	self._laneSwitchTargetLateral = 0
	self._laneSwitchActive = false
	self._laneSwitchStartLateral = 0
	self._laneSwitchVisualDirection = 0
	self._laneSwitchCooldownRemainingSec = 0
	self._visualForwardDampVelX = 0
	self._visualForwardDampVelY = 0
	self._visualForwardDampVelZ = 0
	self._hasLastHorizontalPosition = false
	self._hasSmoothedTrackDisplayPosition = false
	self._trackDisplaySmoothBlockRemainingSec = TrackDisplayPositionSmoothResumeDelaySec
	self._jumpRemainingSec = 0
	self._jumpCooldownRemainingSec = 0
	self._jumpClearGraceRemainingSec = 0
	self._jumpDurationSec = 1.15
	self._jumpHeight = 3.35
	self._jumpCooldownSec = 2
	self._jumpClearLandingGraceSec = 0.28
	self._airborneMotionActive = false
	self._airborneForwardRollAngleDeg = 0
	self._landingReattachForwardRollActive = false
	self._landingReattachRemainingSec = 0
	self._itemFlightRemainingSec = 0
	self._itemFlightDurationSec = 0
	self._itemFlightHeight = 0
	self._buffHeightOffsets = {}
	self._currentBuffHeightOffset = 0
	self._buffHeightOffsetVelocity = 0
	self._baseRideHeight = 0
	self._hasCollisionShield = false
	self._shieldVisualRemainingSec = 0
	self._heldItem = nil
	self._backupItem = nil
	self._activeNormalShortcut = nil
	self._normalShortcuts = {}
	self._mainTrackPath = nil
	self._routeShortcutReturnPath = nil
	self._aerialShortcutRoadFrames3D = nil
	self._aerialShortcutRoadPose3D = nil
	self._aerialShortcutEntryHeightBase = 0
	self._aerialShortcutExitFlightActive = false
	self._aerialShortcutExitFlightDurationSec = 0
	self._aerialShortcutExitFlightRemainingSec = 0
	self._aerialShortcutExitFlightArcHeight = 0
	self._aerialShortcutExitFlightStartPosition = Vector3(0, 0, 0)
	self._aerialShortcutExitFlightTargetPosition = Vector3(0, 0, 0)
	self._aerialShortcutExitFlightStartForward = Vector3(0, 0, 1)
	self._aerialShortcutExitFlightTargetForward = Vector3(0, 0, 1)
	self._aerialShortcutExitRecoverRoute = nil
	self._aerialShortcutExitRecoverPath = nil
	self._aerialShortcutExitTargetDistance = 0
	self._aerialShortcutExitTargetLaneId = 1
	self._aerialShortcutExitCameraProfileId = 0
	self._aerialShortcutExitMainEquivalent = 0
	self._routeNetwork = nil
	self._layeredRoutes = {}
	self._routeTransfers = {}
	self._waterDrops = {}
	self._glideRoutes = {}
	self._underwaterRoutes = {}
	self._snowSlopeRoutes = {}
	self._waterfallClimbRoutes = {}
	self._activeLayeredRoute = nil
	self._activeRouteShortcut = nil
	self._activeRouteMainBaseDistance = 0
	self._activeRouteLocalBaseDistance = 0
	self._routeTransferFlightRemainingSec = 0
	self._routeTransferFlightDurationSec = 0
	self._routeTransferFlightRollTotalDeg = 0
	self._routeTransferFlightHeight = 0
	self._routeTransferProjectionLockRemainingSec = 0
	self._routeTransferFlightStartPosition = Vector3(0, 0, 0)
	self._routeTransferFlightTargetPosition = Vector3(0, 0, 0)
	self._routeTransferUseAlignedCurve = false
	self._routeTransferFlightStartForward = Vector3(0, 0, 1)
	self._routeTransferFlightTargetForward = Vector3(0, 0, 1)
	self._routeTransferFlightSmoothedForward = Vector3(0, 0, 1)
	self._activeWaterDrop = nil
	self._waterDropRecoverRoute = nil
	self._waterDropRecoverPath = nil
	self._waterDropRemainingSec = 0
	self._waterDropElapsedSec = 0
	self._waterDropProgress = 0
	self._waterDropTapProgressPending = 0
	self._waterDropSpinSpeedDeg = 0
	self._waterDropSpinAngleDeg = 0
	self._waterDropFeedbackSpinSpeedDeg = 0
	self._waterDropFeedbackTier = 1
	self._waterDropStartPosition = Vector3(0, 0, 0)
	self._waterDropTargetPosition = Vector3(0, 0, 0)
	self._waterDropForward = Vector3(0, 0, 1)
	self._waterDropLandingBlendActive = false
	self._waterDropLandingBlendDurationSec = 0
	self._waterDropLandingBlendRemainingSec = 0
	self._waterDropLandingStartPosition = Vector3(0, 0, 0)
	self._waterDropLandingTargetPosition = Vector3(0, 0, 0)
	self._waterDropLandingStartForward = Vector3(0, 0, 1)
	self._waterDropLandingTargetForward = Vector3(0, 0, 1)
	self._waterDropLandingTargetDistance = 0
	self._waterDropLandingTargetLateral = 0
	self._waterDropLandingCameraProfileId = 0
	self._waterDropLandingBaseDistance = 0
	self._waterDropLandingElapsedSec = 0
	self._waterDropLandingResumeForwardSpeed = 0
	self._waterDropLandingRecoverSpeedMultiplier = 1
	self._activeUnderwaterRoute = nil
	self._underwaterRecoverRoute = nil
	self._underwaterRecoverPath = nil
	self._activeSnowSlopeRoute = nil
	self._snowSlopeRecoverRoute = nil
	self._snowSlopeRecoverPath = nil
	self._snowSlopeRoadFrames3D = nil
	self._snowSlopeRoadPose3D = nil
	self._snowSlopeHeightBaseOffset = 0
	self._snowSlopeSlideDirection = 0
	self._snowSlopeSlideVelocity = 0
	self._snowSlopeLandingBlendActive = false
	self._snowSlopeLandingBlendDurationSec = 0
	self._snowSlopeLandingBlendRemainingSec = 0
	self._snowSlopeLandingStartPosition = Vector3(0, 0, 0)
	self._snowSlopeLandingTargetPosition = Vector3(0, 0, 0)
	self._snowSlopeLandingStartForward = Vector3(0, 0, 1)
	self._snowSlopeLandingTargetForward = Vector3(0, 0, 1)
	self._snowSlopeLandingBaseDistance = 0
	self._snowSlopeLandingTargetDistance = 0
	self._snowSlopeLandingTargetLateral = 0
	self._snowSlopeLandingElapsedSec = 0
	self._snowSlopeLandingCameraProfileId = 0
	self._activeWaterfallClimbRoute = nil
	self._waterfallClimbRecoverRoute = nil
	self._waterfallClimbRecoverPath = nil
	self._waterfallClimbProgress = 0
	self._waterfallClimbLaneFloat = 0
	self._waterfallClimbTargetLaneFloat = 0
	self._waterfallClimbCameraAnchorPosition = Vector3(0, 0, 0)
	self._waterfallClimbCameraPositionOffset = Vector3(0, 0, 0)
	self._waterfallClimbCameraLookTargetPosition = Vector3(0, 0, 0)
	self._waterfallClimbEntryCurve = nil
	self._waterfallClimbEntryCurveProgress = 0
	self._waterfallClimbEntryJoinProgress = 0
	self._waterfallClimbEntryMainDistance = 0
	self._waterfallClimbTravelSpeed = 0
	self._waterfallClimbEntryOrientationBlendRemainingSec = 0
	self._waterfallClimbEntryStartRotation = self._transform.rotation

	CacheWaterfallEntryRotation(self, self._waterfallClimbEntryStartRotation)

	self._waterfallClimbExitFlightActive = false
	self._waterfallClimbExitFlightDurationSec = 0
	self._waterfallClimbExitFlightRemainingSec = 0
	self._waterfallClimbExitFlightStartPosition = Vector3(0, 0, 0)
	self._waterfallClimbExitFlightTargetPosition = Vector3(0, 0, 0)
	self._waterfallClimbExitFlightStartForward = Vector3(0, 0, 1)
	self._waterfallClimbExitFlightTargetForward = Vector3(0, 0, 1)
	self._waterfallClimbExitFlightCameraProfileId = 0
	self._waterfallClimbCameraExitBlendDurationSec = 0
	self._waterfallClimbCameraExitBlendRemainingSec = 0
	self._waterfallClimbExitCameraPositionOffset = Vector3(0, 0, 0)
	self._waterfallClimbExitCameraLookOffset = Vector3(0, 0, 0)
	self._waterfallClimbBackFacingExitCameraDelayActive = false
	self._waterfallClimbExitCameraFollowStartPosition = Vector3(0, 0, 0)
	self._activeGlideRoute = nil
	self._glideRecoverRoute = nil
	self._glideRecoverPath = nil
	self._glideEntryFlightRemainingSec = 0
	self._glideEntryFlightDurationSec = 0
	self._glideEntryFlightArcHeight = 0
	self._glideEntryFlightStartPosition = Vector3(0, 0, 0)
	self._glideEntryFlightTargetPosition = Vector3(0, 0, 0)
	self._glideEntryFlightStartForward = Vector3(0, 0, 1)
	self._glideEntryFlightTargetForward = Vector3(0, 0, 1)
	self._glideDistance = 0
	self._glideTravelSpeed = 0
	self._glideProgress = 0
	self._glideLateralOffset = 0
	self._glideTargetLateralOffset = 0
	self._glideAltitudeOffset = 0
	self._glideTargetAltitudeOffset = 0
	self._glideAltitudeBandIndex = 1
	self._glideVisualJitterSeed = 0
	self._glideCameraAnchorPosition = Vector3(0, 0, 0)
	self._glideLandingBlendActive = false
	self._glideLandingBlendRemainingSec = 0
	self._glideLandingBlendDurationSec = 0
	self._glideLandingStartPosition = Vector3(0, 0, 0)
	self._glideLandingTargetPosition = Vector3(0, 0, 0)
	self._glideLandingStartForward = Vector3(0, 0, 1)
	self._glideLandingTargetForward = Vector3(0, 0, 1)
	self._glideLandingCameraProfileId = 0
	self._glideLandingTargetDistance = 0
	self._glideLandingTargetLateral = 0
	self._glideLandingBaseDistance = 0
	self._glideLandingElapsedSec = 0
	self._glideUsesAerialShortcutLaneMapping = false
	self._previousGlideHorizontalInput = 0
	self._previousGlideVerticalInput = 0
	self._glideVerticalInput = 0
	self._initialized = false
	self._perfectDodgeWindowDistance = tonumber(lua_racing_const.configDict[13920][1011].value)
	self._perfectDodgeEffectList = string.splitToNumber(lua_racing_const.configDict[13920][1012].value2, "#")

	local racingConstDict = lua_racing_const.configDict[13920]
	local energyBaseConfig = racingConstDict and racingConstDict[PerfectDodgeEnergyBaseConstId]
	local energyPerComboConfig = racingConstDict and racingConstDict[PerfectDodgeEnergyPerComboConstId]

	self._perfectDodgeEnergyBase = energyBaseConfig and tonumber(energyBaseConfig.value)
	self._perfectDodgeEnergyPerCombo = energyPerComboConfig and tonumber(energyPerComboConfig.value)

	if self._perfectDodgeEnergyBase == nil or self._perfectDodgeEnergyPerCombo == nil then
		logError("PlayerVehicleController missing perfect dodge energy constants", PerfectDodgeEnergyBaseConstId, PerfectDodgeEnergyPerComboConstId)
	end
end

function PlayerVehicleController:addTailEffect(prefab)
	self._tailEffectGo = gohelper.clone(prefab, self:getRacerVisualAttachGo())
end

function PlayerVehicleController:onStart()
	if not self._initialized then
		self:initialize()
	end
end

function PlayerVehicleController:initialize(sharedMainTrackPath)
	if self._initialized then
		return
	end

	local trackConfig = V3a9RacingCarModel.instance:getTrackConfig()

	if not trackConfig then
		logError("PlayerVehicleController:initialize - trackConfig is nil")

		return
	end

	self._runtimeConfig = trackConfig
	self._vehicleConfig = trackConfig.playerVehicle or {}
	self._drivePowerConfig = trackConfig.drivePower or {}
	self._boostConfig = trackConfig.boost or {}
	self._collisionConfig = trackConfig.collision or {}
	self._controlConfig = trackConfig.controls or {}

	if sharedMainTrackPath and sharedMainTrackPath:getIsValid() then
		self._trackPath = sharedMainTrackPath
		self._mainTrackPath = sharedMainTrackPath
	elseif trackConfig.path then
		self._trackPath = TrackPath.FromConfig(trackConfig.path)
		self._mainTrackPath = self._trackPath
	end

	self._normalShortcuts = trackConfig.normalShortcuts or {}
	self._activeNormalShortcut = nil
	self._routeNetwork = trackConfig.routeNetwork

	if trackConfig.routeNetwork then
		self._layeredRoutes = trackConfig.routeNetwork.routes or {}
	end

	if trackConfig.routeNetwork then
		self._routeTransfers = trackConfig.routeNetwork.transfers or {}
	end

	if trackConfig.routeNetwork then
		self._waterDrops = trackConfig.routeNetwork.waterDrops or {}
	end

	if trackConfig.routeNetwork then
		self._glideRoutes = trackConfig.routeNetwork.glides or {}
	end

	if trackConfig.routeNetwork then
		self._underwaterRoutes = trackConfig.routeNetwork.underwaterRoutes or {}
	end

	if trackConfig.routeNetwork then
		self._snowSlopeRoutes = trackConfig.routeNetwork.snowSlopeRoutes or {}
	end

	if trackConfig.routeNetwork then
		self._waterfallClimbRoutes = trackConfig.routeNetwork.waterfallClimbRoutes or {}
	end

	self:_resetRouteNetworkState(false)
	self:_applyControlFeelConfig()

	local maxEnergy = self:getMaxEnergy()

	if not self._vehicleConfig.startingEnergy then
		self._currentEnergy = self._vehicleConfig.startingEnergy < 0 and maxEnergy or Mathf.Clamp(self._vehicleConfig.startingEnergy, 0, maxEnergy)
		self._forwardSpeed = 0
		self._countdownForwardSpeed = self:getBaseSpeed()

		local transform = self._transform
		local _, startY = transformhelper.getPos(transform)

		self._baseRideHeight = startY

		local goForwardX, _, goForwardZ = transformhelper.getForward(transform)

		self._stableTrackForward = CreateFlatForward(goForwardX, goForwardZ)
		self._smoothedVisualForward = CreateFlatForward(goForwardX, goForwardZ)

		if self._trackPath and self._trackPath:getIsValid() then
			self._trackDistance = self._trackPath:getStartDistance()

			local defaultLaneIndex = 0
			local laneCount = self:_resolveLaneSwitchLaneCount()

			self._lateralOffset = self._trackPath:LaneToLateralOffset(defaultLaneIndex, laneCount)
			self._hasTrackState = true

			local startPose = self._trackPath:Sample(self._trackDistance, self._lateralOffset)
			local rideHeight = self._baseRideHeight
			local startX, startZ = startPose.position.x, startPose.position.y

			transformhelper.setPos(transform, startX, rideHeight, startZ)

			self._hasSmoothedTrackDisplayPosition = false

			SetVec3(self._smoothedTrackDisplayPosition, startX, rideHeight, startZ)
			SetVec3(self._trackDisplayPositionDampVelocity, 0, 0, 0)

			self._trackDisplaySmoothBlockRemainingSec = TrackDisplayPositionSmoothResumeDelaySec

			local startTangentX, startTangentZ = startPose.tangent.x, startPose.tangent.y
			local startTangentSqr = startTangentX * startTangentX + startTangentZ * startTangentZ

			if startTangentSqr > 1e-10 then
				local inv = 1 / math.sqrt(startTangentSqr)
				local forwardX, forwardZ = startTangentX * inv, startTangentZ * inv

				transformhelper.setEulerAngles(transform, 0, math.deg(math.atan2(forwardX, forwardZ)), 0)
				SetVec3(self._stableTrackForward, forwardX, 0, forwardZ)
				SetVec3(self._smoothedVisualForward, forwardX, 0, forwardZ)
				SetVec3(self._cameraTrackForward, forwardX, 0, forwardZ)
			end
		end

		self:_registerToSkillManager()

		self._initialized = true
	end
end

function PlayerVehicleController:onUpdate()
	if not self._initialized then
		self:initialize()
	end

	if V3a9RacingCarModel.instance:isGuidePause() then
		local steering = 0

		if UnityEngine.Input.GetKey(UnityEngine.KeyCode.A) then
			steering = steering + 1
		end

		if UnityEngine.Input.GetKey(UnityEngine.KeyCode.D) then
			steering = steering - 1
		end

		self:setSteeringInput(steering)

		return
	end

	if not V3a9RacingCarModel.instance:isRacing() then
		return
	end

	if V3a9RacingCarModel.instance:isRaceFinished() then
		return
	end

	if self._hasPlayerFinished then
		return
	end

	local deltaTime = UnityEngine.Time.deltaTime

	if self._postFinishElapsed >= 0 then
		local elapsed = V3a9RacingCarModel.instance:getRaceTime() - self._postFinishElapsed

		if elapsed >= V3a9RacingCarEnum.PostFinishDelay then
			self._hasPlayerFinished = true

			V3a9RacingCarModel.instance:setRaceFinished(true)

			return
		end

		self:_updateTimers(deltaTime)
		self:updateBuffs(deltaTime)
		self:_updateSpeed(deltaTime)
		self:_moveVehicle(deltaTime)

		return
	end

	self:_updateTimers(deltaTime)
	self:updateBuffs(deltaTime)
	self:_readInput()
	self:_updateSpeed(deltaTime)
	self:_moveVehicle(deltaTime)
	self:_tryCompleteSpecialRaceDistanceFreeze()
	self:_checkRaceCompletion()
end

function PlayerVehicleController:_readInput()
	local steering = 0

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.A) then
		steering = steering + 1
	end

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.D) then
		steering = steering - 1
	end

	if UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.Space) then
		if self._activeWaterDrop and self._waterDropRemainingSec > 0 then
			self:_registerWaterDropTap()
		elseif self:tryUseUltimateSkill() then
			-- block empty
		elseif ManualSpaceJumpEnabled then
			self:tryJump()
		end
	end

	if UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.F) then
		self:tryUseHeldItem()
	end

	if self._changeSteeringInput then
		self._changeSteeringInput = false

		return
	end

	self:setSteeringInput(steering)

	if self:_isAirWaterDropTapPressed() then
		self:_registerWaterDropTap()
	end

	local glideVertical = 0

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.W) or UnityEngine.Input.GetKey(UnityEngine.KeyCode.UpArrow) then
		glideVertical = glideVertical + 1
	end

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.S) or UnityEngine.Input.GetKey(UnityEngine.KeyCode.DownArrow) then
		glideVertical = glideVertical - 1
	end

	self._glideVerticalInput = Mathf.Clamp(glideVertical, -1, 1)
end

function PlayerVehicleController:_isAirWaterDropTapPressed()
	if not self._activeWaterDrop or self._waterDropRemainingSec <= 0 then
		return false
	end

	if UnityEngine.Input.GetMouseButtonDown(0) then
		return true
	end

	local touchCount = UnityEngine.Input.touchCount

	for index = 0, touchCount - 1 do
		local touch = UnityEngine.Input.GetTouch(index)

		if touch.phase == TouchPhase.Began then
			return true
		end
	end

	return false
end

function PlayerVehicleController:setSteeringInput(value)
	if V3a9RacingCarModel.instance:getPauseChangeLane() then
		if value ~= 0 then
			logNormal("PlayerVehicleController:setSteeringInput: pauseChangeLane")
		end

		return
	end

	self._changeSteeringInput = true
	self._steeringInput = Mathf.Clamp(value, -1, 1)

	self:_updateSteeringHold(UnityEngine.Time.deltaTime)

	if value == 0 then
		return
	end

	V3a9RacingCarController.instance:dispatchEvent(V3a9RacingCarEvent.GuideChaneLane, self._steeringInput)
end

function PlayerVehicleController:_updateSteeringHold(deltaTime)
	if math.abs(self._steeringInput) <= 0.01 then
		self._steeringHoldDurationSec = 0
		self._steeringHoldDirection = 0

		return
	end

	local direction = self._steeringInput > 0 and 1 or -1

	if direction ~= self._steeringHoldDirection then
		self._steeringHoldDirection = direction
		self._steeringHoldDurationSec = 0
	end

	local rampSec = self:_resolveSteeringHoldRampSec()

	self._steeringHoldDurationSec = math.min(rampSec, self._steeringHoldDurationSec + math.max(0, deltaTime))
end

function PlayerVehicleController:_updateTimers(deltaTime)
	self._laneSwitchCooldownRemainingSec = math.max(0, self._laneSwitchCooldownRemainingSec - deltaTime)
	self._routeTransferProjectionLockRemainingSec = math.max(0, self._routeTransferProjectionLockRemainingSec - deltaTime)

	if self._jumpCooldownRemainingSec > 0 then
		self._jumpCooldownRemainingSec = math.max(0, self._jumpCooldownRemainingSec - deltaTime)
	end

	if self._jumpRemainingSec > 0 then
		local previousJumpRemainingSec = self._jumpRemainingSec

		self._jumpRemainingSec = math.max(0, self._jumpRemainingSec - deltaTime)

		if previousJumpRemainingSec > 0 and self._jumpRemainingSec <= 0 then
			self._jumpClearGraceRemainingSec = math.max(self._jumpClearGraceRemainingSec, self:_resolveJumpClearLandingGraceSec())

			self:_beginLandingReattach()
		end
	end

	if self._jumpClearGraceRemainingSec > 0 then
		self._jumpClearGraceRemainingSec = math.max(0, self._jumpClearGraceRemainingSec - deltaTime)
	end

	if self._perfectDodgeInvulnerabilityRemainingSec > 0 then
		self._perfectDodgeInvulnerabilityRemainingSec = math.max(0, self._perfectDodgeInvulnerabilityRemainingSec - deltaTime)
	end

	if self._invulnerabilityRemainingSec > 0 then
		self._invulnerabilityRemainingSec = math.max(0, self._invulnerabilityRemainingSec - deltaTime)

		if self._invulnerabilityFlashEnabled then
			self:_updateInvulnerabilityFlash()
		elseif self._renderersVisible == false then
			self:_setInvulnerabilityRenderersVisible(true)
		end
	else
		self._invulnerabilityFlashEnabled = false
		self._perfectDodgeInvulnerabilityRemainingSec = 0

		if self._renderersVisible == false then
			self:_setInvulnerabilityRenderersVisible(true)
		end
	end

	local targetBuffHeightOffset = self:_resolveBuffHeightOffsetTarget()

	if not self._currentBuffHeightOffset then
		local currentBuffHeightOffset = 0

		if currentBuffHeightOffset <= targetBuffHeightOffset then
			if not BuffHeightTakeoffSmoothTime then
				local heightSmoothTime = BuffHeightLandingSmoothTime

				self._currentBuffHeightOffset, self._buffHeightOffsetVelocity = Mathf.SmoothDamp(currentBuffHeightOffset, targetBuffHeightOffset, self._buffHeightOffsetVelocity or 0, heightSmoothTime, math.huge, deltaTime)
			end
		end
	end
end

function PlayerVehicleController:_updateSpeed(deltaTime)
	self:updateSpeed(deltaTime)

	if self._shortcutJumpRemainingSec > 0 then
		self._forwardSpeed = self._forwardSpeed * math.max(1, self._shortcutJumpSpeedMultiplier or 1)
	end

	local envMultiplier = self:_resolveEnvironmentSpeedMultiplier()

	if envMultiplier ~= 1 and envMultiplier > 0 then
		self._forwardSpeed = math.max(0, self._forwardSpeed * envMultiplier)
	end

	if self._activeWaterfallClimbRoute then
		self._forwardSpeed = WaterfallClimb.ResolveEntryForwardSpeed(self._forwardSpeed, self:getBaseSpeed(), self._activeWaterfallClimbRoute)
	end
end

function PlayerVehicleController:updateVisualPose()
	if not self._trackPath or not self._trackPath:getIsValid() then
		return
	end

	local transform = self._transform
	local deltaTime = UnityEngine.Time.deltaTime

	self:_sampleTrackPoseForDisplay(self._trackDistance, self._lateralOffset, self._poseCache)

	local pose = self._poseCache
	local worldX, worldY, worldZ = self:_resolveCurrentTrackWorldPosition(pose, 0)
	local displayX, displayY, displayZ = self:_resolveTrackDisplayPosition(worldX, worldY, worldZ, deltaTime)

	transformhelper.setPos(transform, displayX, displayY, displayZ)

	local tx, tz = pose.tangent.x, pose.tangent.y
	local tSqr = tx * tx + tz * tz

	if tSqr > 0.001 then
		local invLen = 1 / math.sqrt(tSqr)

		_tangentCache.x = tx * invLen
		_tangentCache.y = 0
		_tangentCache.z = tz * invLen
	else
		_tangentCache.x = self._stableTrackForward.x
		_tangentCache.y = 0
		_tangentCache.z = self._stableTrackForward.z
	end

	local tangent = _tangentCache

	self:_sampleTrackPoseForDisplay(self._trackDistance + 25, self._lateralOffset, self._futurePoseCache)

	local ftx, ftz = self._futurePoseCache.tangent.x, self._futurePoseCache.tangent.y
	local ftSqr = ftx * ftx + ftz * ftz

	if ftSqr > 0.001 then
		local invLen = 1 / math.sqrt(ftSqr)

		_futureTangentCache.x = ftx * invLen
		_futureTangentCache.y = 0
		_futureTangentCache.z = ftz * invLen

		local slerpX, slerpZ = SlerpUnitXZ(_tangentCache.x, _tangentCache.z, _futureTangentCache.x, _futureTangentCache.z, 0.75)

		_tangentCache.x, _tangentCache.y, _tangentCache.z = slerpX, 0, slerpZ
		tangent = _tangentCache
	end

	if tangent.x * tangent.x + tangent.y * tangent.y + tangent.z * tangent.z <= 0.001 then
		tangent = self._stableTrackForward
	end

	if self:_resolveActiveAerialShortcut() and self._aerialShortcutRoadFrames3D then
		tangent = self:_resolveAerialShortcutLookAheadForward(tangent)
	end

	self:_updateVehicleOrientation(tangent, VEC3_ZERO, 0, deltaTime)
end

function PlayerVehicleController:_moveVehicle(deltaTime)
	if self._trackPath and self._trackPath:getIsValid() then
		self:_moveVehicleOnTrack(deltaTime)

		return
	end

	local acceleration = math.max(0, self._vehicleConfig.lateralAcceleration or 0)
	local damping = math.max(0, (not self._vehicleConfig.lateralDamping or nil) and 0)
	local steeringSmoothTime = self:_resolveSteeringSmoothTime(damping)
	local maxLateralSpeed = math.max(3, acceleration / math.max(1, damping) * 1.8)
	local lateralSpeedScale = self:_resolveSteeringHoldSpeedScale()

	self._smoothedSteeringInput = self:_moveTowards(self._smoothedSteeringInput, self._steeringInput, self:_resolveSteeringInputRate(damping) * deltaTime)

	local targetLateralVelocity = self._smoothedSteeringInput * maxLateralSpeed * lateralSpeedScale
	local velocitySmoothTime = self:_resolveLateralVelocitySmoothTime(steeringSmoothTime)
	local newLateralVelocity, newDampVelocity = self:_smoothDamp(self._lateralVelocity, targetLateralVelocity, self._lateralVelocityDampVelocity, velocitySmoothTime, math.max(1, acceleration), deltaTime)

	self._lateralVelocity = newLateralVelocity
	self._lateralVelocityDampVelocity = newDampVelocity

	local transform = self._transform
	local forwardX, forwardY, forwardZ = transformhelper.getForward(transform)
	local rightX, rightY, rightZ = transformhelper.getRight(transform)
	local forwardStep = self._forwardSpeed * deltaTime
	local lateralStep = self._lateralVelocity * deltaTime
	local prevX, prevY, prevZ = transformhelper.getPos(transform)
	local nextX = prevX + forwardX * forwardStep + rightX * lateralStep
	local nextY = prevY + forwardY * forwardStep + rightY * lateralStep
	local nextZ = prevZ + forwardZ * forwardStep + rightZ * lateralStep

	transformhelper.setPos(transform, nextX, nextY, nextZ)
	self:_updateEstimatedHorizontalVelocity(prevX, prevZ, nextX, nextZ, deltaTime)

	_tangentCache.x, _tangentCache.y, _tangentCache.z = forwardX, forwardY, forwardZ

	self:_updateVehicleOrientation(_tangentCache, self._estimatedHorizontalVelocity, damping, deltaTime)
end

function PlayerVehicleController:_movePostFinish(deltaTime)
	local distanceDelta = self._forwardSpeed * deltaTime

	self._trackDistance = self._trackDistance + distanceDelta

	local transform = self._transform
	local endDistance = self._trackPath:getEndDistance()
	local isLoop = self._trackPath:getIsLoop()
	local forward
	local prevX, prevY, prevZ = transformhelper.getPos(transform)
	local rideHeight = self:_resolveRideHeight() + self:_resolveItemFlightOffset()

	if isLoop then
		self._trackDistance = self._trackPath:WrapDistance(self._trackDistance)
	end

	if isLoop or endDistance >= self._trackDistance then
		self._trackPath:SampleTo(self._trackDistance, self._lateralOffset, self._poseCache)

		local pose = self._poseCache

		_worldPosCache.x, _worldPosCache.y, _worldPosCache.z = pose.position.x, rideHeight, pose.position.y

		local displayX, displayY, displayZ = self:_resolveTrackDisplayPosition(_worldPosCache.x, _worldPosCache.y, _worldPosCache.z, deltaTime)

		transformhelper.setPos(transform, displayX, displayY, displayZ)

		_tangentCache.x, _tangentCache.y, _tangentCache.z = pose.tangent.x, 0, pose.tangent.y
		forward = _tangentCache
	else
		local overshoot = self._trackDistance - endDistance

		self._trackPath:SampleTo(endDistance, self._lateralOffset, self._poseCache)

		local pose = self._poseCache
		local tx, tz = pose.tangent.x, pose.tangent.y
		local tSqr = tx * tx + tz * tz

		if tSqr > 0.001 then
			local invLen = 1 / math.sqrt(tSqr)

			_tangentCache.x, _tangentCache.y, _tangentCache.z = tx * invLen, 0, tz * invLen
			forward = _tangentCache
		else
			forward = self._postFinishForward or self._stableTrackForward
		end

		_worldPosCache.x = pose.position.x + forward.x * overshoot
		_worldPosCache.y = rideHeight
		_worldPosCache.z = pose.position.y + forward.z * overshoot

		local displayX, displayY, displayZ = self:_resolveTrackDisplayPosition(_worldPosCache.x, _worldPosCache.y, _worldPosCache.z, deltaTime)

		transformhelper.setPos(transform, displayX, displayY, displayZ)
	end

	self:_updateEstimatedHorizontalVelocity(prevX, prevZ, _worldPosCache.x, _worldPosCache.z, deltaTime)

	local damping = math.max(1, self._vehicleConfig.lateralDamping or 1)

	self:_updateVehicleOrientation(forward, self._estimatedHorizontalVelocity, damping, deltaTime)
end

function PlayerVehicleController:_updateWaterfallClimbCameraExitBlend(deltaTime)
	local remaining = math.max(0, (not self._waterfallClimbCameraExitBlendRemainingSec or nil) and 0)

	if remaining <= 0 then
		return
	end

	self._waterfallClimbCameraExitBlendRemainingSec = math.max(0, remaining - math.max(0, deltaTime or 0))

	if self._waterfallClimbCameraExitBlendRemainingSec > 0 then
		return
	end

	self._waterfallClimbCameraExitBlendDurationSec = 0
	self._waterfallClimbExitCameraPositionOffset = Vector3(0, 0, 0)
	self._waterfallClimbExitCameraLookOffset = Vector3(0, 0, 0)
	self._waterfallClimbBackFacingExitCameraDelayActive = false
	self._waterfallClimbExitCameraFollowStartPosition = Vector3(0, 0, 0)
end

function PlayerVehicleController:_moveVehicleOnTrack(deltaTime)
	self:_updateWaterfallClimbCameraExitBlend(deltaTime)

	if not self._trackPath or not self._trackPath:getIsValid() then
		self:_moveVehicle(deltaTime)

		return
	end

	if self._postFinishElapsed >= 0 then
		self:_movePostFinish(deltaTime)

		return
	end

	if self._activeWaterfallClimbRoute then
		self:_moveWaterfallClimb(deltaTime)

		return
	end

	if self._waterfallClimbExitFlightActive then
		self:_moveWaterfallClimbExitFlight(deltaTime, math.max(1, self._vehicleConfig.lateralDamping or 1))

		return
	end

	if self._aerialShortcutExitFlightActive then
		self:_moveAerialShortcutExitFlight(deltaTime, math.max(1, self._vehicleConfig.lateralDamping or 1))

		return
	end

	if self._activeGlideRoute then
		self:_moveGlide(deltaTime)

		return
	end

	if self._glideLandingBlendActive then
		self:_moveGlideLandingBlend(deltaTime, math.max(1, self._vehicleConfig.lateralDamping or 1))

		return
	end

	if self._waterDropLandingBlendActive then
		self:_moveWaterDropLandingBlend(deltaTime, math.max(1, self._vehicleConfig.lateralDamping or 1))

		return
	end

	if self._snowSlopeLandingBlendActive then
		self:_moveSnowSlopeLandingBlend(deltaTime, math.max(1, self._vehicleConfig.lateralDamping or 1))

		return
	end

	local transform = self._transform

	if not self:_shouldSkipTrackProjectionCorrection() then
		local posX, _, posZ = transformhelper.getPos(transform)

		_position2DCache.x = posX
		_position2DCache.y = posZ

		self._trackPath:ProjectToByDistance(_position2DCache, self._projectionCache, self._trackDistance)

		local projection = self._projectionCache

		if not self._hasTrackState then
			self._trackDistance = projection.distance
			self._lateralOffset = self._trackPath:ClampLateral(projection.lateralOffset)
			self._hasTrackState = true
		elseif not self:_isAirborneHandlingActive() and projection.sqrError > 16 then
			local projectedDistance = ResolveNearestLoopProjectionDistance(self._trackPath, self._trackDistance, projection.distance)

			self._trackDistance = math.max(self._trackDistance, projectedDistance)
			self._lateralOffset = self._trackPath:ClampLateral(projection.lateralOffset)

			self:_beginRecenterToNearestLane()
		end
	end

	local acceleration = math.max(1, self._vehicleConfig.lateralAcceleration or 1)
	local damping = math.max(1, (not self._vehicleConfig.lateralDamping or nil) and 1)
	local maxLateralSpeed = math.max(4, self:_resolveLaneSwitchSpeed() * self:_resolveEnvironmentSteeringMultiplier())

	self:_updateLaneSwitchInput()
	self:_tryEnterAutomaticAerialLaneFork()

	if self._airborneMotionActive and self._jumpRemainingSec > 0 then
		self:_moveAirborneOnTrack(deltaTime, acceleration, damping, maxLateralSpeed)

		return
	end

	if self._shortcutJumpRemainingSec > 0 then
		self:_moveShortcutJumpOnTrack(deltaTime, damping)

		return
	end

	if self._routeTransferFlightRemainingSec > 0 then
		self:_moveRouteTransferFlight(deltaTime, damping)

		return
	end

	if self._waterDropRemainingSec > 0 then
		self:_moveAirWaterDrop(deltaTime, damping)

		return
	end

	if self._landingReattachRemainingSec > 0 then
		self:_moveLandingReattachOnTrack(deltaTime, damping)

		return
	end

	local distanceDelta = self._forwardSpeed * deltaTime

	self._trackDistance = self:_advanceTrackDistance(distanceDelta)

	self:_accumulateRaceDistance()
	self:_updateLaneSwitchMotion(deltaTime)

	if self._activeNormalShortcut and self:_tryActivateAerialShortcutExitGlide() then
		return
	end

	if self._activeRouteShortcut and self._trackDistance >= self._trackPath:getEndDistance() - 0.01 then
		self:_completeRouteShortcut()
	elseif self._activeUnderwaterRoute and self._trackDistance >= self._trackPath:getEndDistance() - 0.01 then
		self:_completeUnderwaterRoute()
	elseif self._activeSnowSlopeRoute and self._trackDistance >= self._trackPath:getEndDistance() - 0.01 then
		self:_completeSnowSlopeRoute()

		return
	elseif self._activeNormalShortcut and self._trackDistance >= self._trackPath:getEndDistance() - 0.01 then
		self:_completeNormalShortcut()
	elseif self:_tryActivateLayeredRouteTerminalExit() then
		return
	end

	self:_sampleTrackPoseForDisplay(self._trackDistance, self._lateralOffset, self._poseCache)

	local pose = self._poseCache
	local prevX, prevY, prevZ = transformhelper.getPos(transform)
	local itemFlightOffset = self:_resolveItemFlightOffset()
	local worldX, worldY, worldZ = self:_resolveCurrentTrackWorldPosition(pose, itemFlightOffset)
	local displayX, displayY, displayZ = self:_resolveTrackDisplayPosition(worldX, worldY, worldZ, deltaTime)

	transformhelper.setPos(transform, displayX, displayY, displayZ)

	local tx, tz = pose.tangent.x, pose.tangent.y
	local tSqr = tx * tx + tz * tz

	if tSqr > 0.001 then
		local invLen = 1 / math.sqrt(tSqr)

		_tangentCache.x = tx * invLen
		_tangentCache.y = 0
		_tangentCache.z = tz * invLen
	else
		_tangentCache.x = self._stableTrackForward.x
		_tangentCache.y = 0
		_tangentCache.z = self._stableTrackForward.z
	end

	local tangent = _tangentCache

	self:_sampleTrackPoseForDisplay(self._trackDistance + 25, self._lateralOffset, self._futurePoseCache)

	local futurePose = self._futurePoseCache
	local ftx, ftz = futurePose.tangent.x, futurePose.tangent.y
	local ftSqr = ftx * ftx + ftz * ftz

	if ftSqr > 0.001 then
		local invLen = 1 / math.sqrt(ftSqr)

		_futureTangentCache.x = ftx * invLen
		_futureTangentCache.y = 0
		_futureTangentCache.z = ftz * invLen

		local slerpX, slerpZ = SlerpUnitXZ(_tangentCache.x, _tangentCache.z, _futureTangentCache.x, _futureTangentCache.z, 0.75)

		_tangentCache.x, _tangentCache.y, _tangentCache.z = slerpX, 0, slerpZ
		tangent = _tangentCache
	end

	if tangent.x * tangent.x + tangent.y * tangent.y + tangent.z * tangent.z <= 0.001 then
		tangent = self._stableTrackForward
	end

	if self:_resolveActiveAerialShortcut() and self._aerialShortcutRoadFrames3D then
		tangent = self:_resolveAerialShortcutLookAheadForward(tangent)
	end

	self:_updateEstimatedHorizontalVelocity(prevX, prevZ, displayX, displayZ, deltaTime)
	self:_updateVehicleOrientation(tangent, self._estimatedHorizontalVelocity, damping, deltaTime)
end

function PlayerVehicleController:_resolveTrackDisplayPosition(targetX, targetY, targetZ, deltaTime)
	self:_updateTrackDisplaySmoothBlock(deltaTime)

	local smoothed = self._smoothedTrackDisplayPosition
	local dampVelocity = self._trackDisplayPositionDampVelocity

	if not self:_canSmoothTrackDisplayPosition() then
		self._hasSmoothedTrackDisplayPosition = false
		smoothed.x, smoothed.y, smoothed.z = targetX, targetY, targetZ
		dampVelocity.x, dampVelocity.y, dampVelocity.z = 0, 0, 0

		return targetX, targetY, targetZ
	end

	if not self._hasSmoothedTrackDisplayPosition then
		self._hasSmoothedTrackDisplayPosition = true
		smoothed.x, smoothed.y, smoothed.z = targetX, targetY, targetZ
		dampVelocity.x, dampVelocity.y, dampVelocity.z = 0, 0, 0

		return targetX, targetY, targetZ
	end

	local safeDeltaTime = math.max(0, deltaTime)
	local newX, newVelX = Mathf.SmoothDamp(smoothed.x, targetX, dampVelocity.x, TrackDisplayPositionSmoothTime, math.huge, safeDeltaTime)
	local newY, newVelY = Mathf.SmoothDamp(smoothed.y, targetY, dampVelocity.y, TrackDisplayPositionSmoothTime, math.huge, safeDeltaTime)
	local newZ, newVelZ = Mathf.SmoothDamp(smoothed.z, targetZ, dampVelocity.z, TrackDisplayPositionSmoothTime, math.huge, safeDeltaTime)

	smoothed.x, smoothed.y, smoothed.z = newX, newY, newZ
	dampVelocity.x, dampVelocity.y, dampVelocity.z = newVelX, newVelY, newVelZ

	return newX, newY, newZ
end

function PlayerVehicleController:_sampleTrackPoseForDisplay(distance, lateralOffset, outPose)
	if self._trackPath == self._mainTrackPath and self._trackPath.SampleVisualPoseTo then
		self._trackPath:SampleVisualPoseTo(distance, lateralOffset, TrackVisualPoseSampleRadius, outPose, self._visualSampleBeforePoseCache, self._visualSampleAfterPoseCache)

		return
	end

	self._trackPath:SampleTo(distance, lateralOffset, outPose)
end

function PlayerVehicleController:_tryEnterAutomaticAerialLaneFork()
	if self:_isAirborneHandlingActive() or self._activeNormalShortcut or self._activeRouteShortcut or self._activeUnderwaterRoute or self._activeSnowSlopeRoute or self._laneSwitchActive then
		return false
	end

	local laneCount = self:_resolveLaneSwitchLaneCount()
	local currentLane = self:_resolveNearestLaneIndex(self._lateralOffset)

	if self._activeLayeredRoute then
		return self:_tryEnterRouteShortcut(currentLane, laneCount, 0)
	end

	return self:_tryEnterNormalShortcut(currentLane, laneCount, 0)
end

function PlayerVehicleController:_resolveActiveAerialShortcut()
	if not self._activeRouteShortcut then
		return self._activeRouteShortcut and self._activeRouteShortcut.isAerialShortcut == true and self._activeRouteShortcut or nil
	end
end

function PlayerVehicleController:_beginAerialShortcutRoad3D(shortcut)
	local roadFrames = AerialShortcut.Build3DRoadFrames(shortcut)

	self._aerialShortcutRoadFrames3D = roadFrames
	self._aerialShortcutRoadPose3D = nil
	self._aerialShortcutEntryHeightBase = 0

	if roadFrames then
		local routeSurfaceHeight = 0
		local routeSurfaceHeight

		if self._activeLayeredRoute then
			routeSurfaceHeight = self._activeLayeredRoute.height or 0
		end

		self._aerialShortcutEntryHeightBase = AerialShortcut.ResolveEntryHeightBase(roadFrames, routeSurfaceHeight)
	end
end

function PlayerVehicleController:_clearAerialShortcutRoad3D()
	self._aerialShortcutRoadFrames3D = nil
	self._aerialShortcutRoadPose3D = nil
	self._aerialShortcutEntryHeightBase = 0
end

function PlayerVehicleController:_resolveCurrentTrackWorldPosition(trackPose, itemFlightOffset)
	local aerialShortcut = self:_resolveActiveAerialShortcut()

	if aerialShortcut and self._aerialShortcutRoadFrames3D then
		local surfaceOffset = self._baseRideHeight + self:_resolveEnvironmentHeightOffset() + self:_resolveJumpOffset()
		local roadPose = AerialShortcut.Sample3DRoadPose(aerialShortcut, self._aerialShortcutRoadFrames3D, self._trackDistance, self._lateralOffset, surfaceOffset, self._aerialShortcutEntryHeightBase, itemFlightOffset, _specialRoadPositionResult)

		if roadPose then
			self._aerialShortcutRoadPose3D = roadPose

			local roadPosition = roadPose.position

			return roadPosition.x, roadPosition.y, roadPosition.z
		end
	end

	self._aerialShortcutRoadPose3D = nil

	if self._activeSnowSlopeRoute and self._snowSlopeRoadFrames3D then
		local roadPose = SnowSlope.Sample3DRoadPose(self._activeSnowSlopeRoute, self._snowSlopeRoadFrames3D, self._trackDistance, self._lateralOffset, self._baseRideHeight, itemFlightOffset, _specialRoadPositionResult)

		if roadPose then
			self._snowSlopeRoadPose3D = roadPose

			local roadPosition = roadPose.position

			return roadPosition.x, roadPosition.y, roadPosition.z
		end
	end

	self._snowSlopeRoadPose3D = nil

	return trackPose.position.x, self:_resolveRideHeight() + (itemFlightOffset or 0), trackPose.position.y
end

function PlayerVehicleController:_updateTrackDisplaySmoothBlock(deltaTime)
	if self:_isTrackDisplaySmoothBlockedByState() then
		self._trackDisplaySmoothBlockRemainingSec = TrackDisplayPositionSmoothResumeDelaySec

		return
	end

	self._trackDisplaySmoothBlockRemainingSec = math.max(0, (self._trackDisplaySmoothBlockRemainingSec or 0) - math.max(0, deltaTime or 0))
end

function PlayerVehicleController:_canSmoothTrackDisplayPosition()
	if TrackDisplayPositionSmoothTime > 0 then
		local var_47_1

		if (self._trackDisplaySmoothBlockRemainingSec or 0) <= 0 then
			var_47_1 = not self:_isTrackDisplaySmoothBlockedByState()

			goto label_47_0
		end
	end

	var_47_1 = false and true

	::label_47_0::

	return var_47_1
end

function PlayerVehicleController:_isTrackDisplaySmoothBlockedByState()
	local var_48_0 = self:_isAirborneHandlingActive()

	if not var_48_0 then
		var_48_0 = self._laneSwitchActive

		if not self._laneSwitchActive then
			if (self._laneSwitchCooldownRemainingSec or 0) <= 0 then
				if math.abs(self._steeringInput or 0) <= 0.001 then
					if math.abs(self._smoothedSteeringInput or 0) <= 0.001 then
						if (self._invulnerabilityRemainingSec or 0) <= 0 then
							if (self._perfectDodgeInvulnerabilityRemainingSec or 0) <= 0 and self._activeLayeredRoute == nil and self._activeRouteShortcut == nil and self._activeNormalShortcut == nil and self._activeUnderwaterRoute == nil and self._activeSnowSlopeRoute == nil then
								var_48_0 = false

								goto label_48_0
							end
						end
					end
				end
			end

			var_48_0 = true
		end
	end

	::label_48_0::

	return var_48_0
end

function PlayerVehicleController:_updateVehicleOrientation(trackTangent, horizontalVelocity, damping, deltaTime, forwardAxisRollDeg)
	local transform = self._transform
	local stable = self._stableTrackForward
	local tfx, tfz

	if trackTangent.sqrMagnitude > 0.001 then
		local ttx, ttz = trackTangent.x, trackTangent.z
		local ttSqr = ttx * ttx + ttz * ttz

		if ttSqr > 0.001 then
			local invLen = 1 / math.sqrt(ttSqr)

			tfz = ttz * invLen
			tfx = ttx * invLen
		else
			tfz = 1
			tfx = 0
		end

		local rollActive = forwardAxisRollDeg and math.abs(forwardAxisRollDeg) > 0.001

		if not rollActive and not self:_isAirborneHandlingActive() and stable and stable.sqrMagnitude > 0.001 then
			local sx, sz = stable.x, stable.z
			local sSqr = sx * sx + sz * sz

			if sSqr > 0.001 then
				local sInv = 1 / math.sqrt(sSqr)

				sz = sz * sInv
				sx = sx * sInv

				local dot = Mathf.Clamp(sx * tfx + sz * tfz, -1, 1)

				if dot >= TrackForwardJitterDeadDot then
					tfz = sz
					tfx = sx
				end
			end
		end
	else
		local sx, sz = stable.x, stable.z
		local sSqr = sx * sx + sz * sz

		if sSqr > 0.001 then
			local invLen = 1 / math.sqrt(sSqr)

			tfz = sz * invLen
			tfx = sx * invLen
		else
			tfz = 1
			tfx = 0
		end
	end

	local camForward = self._cameraTrackForward

	if not camForward then
		camForward = Vector3(tfx, 0, tfz)
		self._cameraTrackForward = camForward
	elseif camForward.x ~= tfx or camForward.y ~= 0 or camForward.z ~= tfz then
		SetVec3(camForward, tfx, 0, tfz)
	end

	local laneSwitch01 = 0

	if self._laneSwitchActive then
		local total = math.max(0.001, math.abs(self._laneSwitchTargetLateral - self._laneSwitchStartLateral))

		laneSwitch01 = Mathf.Clamp01(math.abs(self._laneSwitchTargetLateral - self._lateralOffset) / total)
	end

	if self._laneSwitchActive then
		if not (self._laneSwitchVisualDirection * laneSwitch01) then
			local visualSteering = 0
			local steer = Mathf.Clamp(visualSteering * 0.4, -0.5, 0.5)
			local gx = tfx + tfz * steer
			local gz = tfz - tfx * steer
			local gSqr = gx * gx + gz * gz
			local dfx, dfz

			if gSqr > 0.001 then
				local invLen = 1 / math.sqrt(gSqr)

				dfz = gz * invLen
				dfx = gx * invLen
			else
				dfz = 1
				dfx = 0
			end

			local trackForwardSpeedScale = self:_resolveTrackForwardFollowSpeedScale()
			local smoothedVisual = self._smoothedVisualForward

			if smoothedVisual.sqrMagnitude <= 0.001 then
				SetVec3(smoothedVisual, dfx, 0, dfz)

				self._visualForwardDampVelX = 0
				self._visualForwardDampVelY = 0
				self._visualForwardDampVelZ = 0
			else
				local orientationSmoothTime = self._laneSwitchActive and self:_resolveLaneSwitchOrientationSmoothTime() or self:_resolveOrientationSmoothTime(damping)

				orientationSmoothTime = self:_resolveShortcutJumpOrientationSmoothTime(orientationSmoothTime)
				orientationSmoothTime = self:_resolveEffectiveTrackForwardOrientationSmoothTime(orientationSmoothTime, trackForwardSpeedScale)

				local nx, ny, nz

				nx, self._visualForwardDampVelX = Mathf.SmoothDamp(smoothedVisual.x, dfx, self._visualForwardDampVelX or 0, orientationSmoothTime, math.huge, deltaTime)
				ny, self._visualForwardDampVelY = Mathf.SmoothDamp(smoothedVisual.y, 0, self._visualForwardDampVelY or 0, orientationSmoothTime, math.huge, deltaTime)
				nz, self._visualForwardDampVelZ = Mathf.SmoothDamp(smoothedVisual.z, dfz, self._visualForwardDampVelZ or 0, orientationSmoothTime, math.huge, deltaTime)

				if math.abs(nx - dfx) < 0.0001 and math.abs(ny) < 0.0001 and math.abs(nz - dfz) < 0.0001 then
					nz = dfz
					ny = 0
					nx = dfx
					self._visualForwardDampVelX = 0
					self._visualForwardDampVelY = 0
					self._visualForwardDampVelZ = 0
				end

				if nx ~= smoothedVisual.x or ny ~= smoothedVisual.y or nz ~= smoothedVisual.z then
					SetVec3(smoothedVisual, nx, ny, nz)
				end
			end

			local svx, svz = smoothedVisual.x, smoothedVisual.z
			local svSqr = svx * svx + svz * svz
			local stx, stz

			if svSqr > 0.001 then
				local invLen = 1 / math.sqrt(svSqr)

				stz = svz * invLen
				stx = svx * invLen
			else
				stz = 1
				stx = 0
			end

			local stableNow = self._stableTrackForward

			if not stableNow then
				self._stableTrackForward = Vector3(stx, 0, stz)
			elseif stableNow.x ~= stx or stableNow.y ~= 0 or stableNow.z ~= stz then
				SetVec3(stableNow, stx, 0, stz)
			end

			local vfx, vfy, vfz = stx, 0, stz

			if self:_resolveActiveAerialShortcut() and self._aerialShortcutRoadFrames3D then
				local visualForward = self:_resolveAerialShortcutForwardForCurrentRoute(camForward)

				if visualForward then
					vfz = visualForward.z
					vfy = visualForward.y
					vfx = visualForward.x
				end
			elseif self._activeSnowSlopeRoute then
				local visualForward = self:_resolveSnowSlopeForwardForCurrentRoute(camForward, 1)

				if visualForward then
					vfz = visualForward.z
					vfy = visualForward.y
					vfx = visualForward.x
				end
			end

			local vSqr = vfx * vfx + vfy * vfy + vfz * vfz

			if vSqr > 1e-06 then
				local invLen = 1 / math.sqrt(vSqr)

				vfz = vfz * invLen
				vfy = vfy * invLen
				vfx = vfx * invLen
			else
				vfz = 1
				vfy = 0
				vfx = 0
			end

			local pitchDeg = -math.deg(math.asin(Mathf.Clamp(vfy, -1, 1)))
			local yawDeg = math.deg(math.atan2(vfx, vfz))
			local rollDeg = forwardAxisRollDeg and math.abs(forwardAxisRollDeg) > 0.001 and forwardAxisRollDeg or 0
			local yawFollowRate = self._laneSwitchActive and self:_resolveLaneSwitchYawFollowRate() or self:_resolveYawFollowRate(damping)

			yawFollowRate = self:_resolveShortcutJumpYawFollowRate(yawFollowRate)
			yawFollowRate = self:_resolveEffectiveTrackForwardYawFollowRate(yawFollowRate, trackForwardSpeedScale)

			transformhelper.setRotationLerp(transform, pitchDeg, yawDeg, rollDeg, Mathf.Clamp(yawFollowRate * deltaTime, 0, 1))
		end
	end
end

function PlayerVehicleController:tryJump()
	if self._jumpCooldownRemainingSec > 0 or self._jumpRemainingSec > 0 then
		return false
	end

	self._jumpRemainingSec = math.max(0.05, self._jumpDurationSec)
	self._jumpCooldownRemainingSec = math.max(0, self._jumpCooldownSec)

	self:_beginAirborneMotion()

	return true
end

function PlayerVehicleController:tryStartShortcutJump(landingDistanceOffset, landingLane, laneCount, durationSec, height, speedMultiplier)
	if not self._trackPath or not self._trackPath:getIsValid() then
		return false
	end

	if self:_isAirborneHandlingActive() then
		return false
	end

	local startDistance = self._trackDistance
	local targetDistance = self:_resolveShortcutJumpTargetDistance(startDistance, landingDistanceOffset)
	local targetLateral = self:_clampPlayableLateral(self._trackPath:LaneToLateralOffset(landingLane, laneCount))

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
	self._jumpClearGraceRemainingSec = math.max(self._jumpClearGraceRemainingSec, self:_resolveJumpClearLandingGraceSec())
	self._landingReattachRemainingSec = 0
	self._airborneMotionActive = false
	self._hasTrackState = true
	self._laneSwitchActive = false
	self._laneSwitchCooldownRemainingSec = 0

	return true
end

function PlayerVehicleController:_beginAirborneMotion()
	self._airborneMotionActive = true

	SetVec3(self._airborneForward, self._stableTrackForward.x, self._stableTrackForward.y, self._stableTrackForward.z)

	local right = self:_resolveRightFromForward(self._airborneForward)

	SetVec3(self._airborneRight, right.x, right.y, right.z)
	SetVec3(self._airborneHorizontalVelocity, self._estimatedHorizontalVelocity.x, self._estimatedHorizontalVelocity.y, self._estimatedHorizontalVelocity.z)

	self._landingReattachRemainingSec = 0
end

function PlayerVehicleController:_beginLandingReattach()
	self._landingReattachRemainingSec = self:_resolveLandingReattachDurationSec()
end

function PlayerVehicleController:_applyControlFeelConfig()
	local config = self._controlConfig

	if not config then
		return
	end

	if config.jumpCooldownSec > 0 then
		self._jumpCooldownSec = config.jumpCooldownSec or self._jumpCooldownSec
	end

	if config.jumpDurationSec > 0 then
		self._jumpDurationSec = config.jumpDurationSec or self._jumpDurationSec
	end

	if config.jumpHeight > 0 then
		self._jumpHeight = config.jumpHeight or self._jumpHeight
	end

	if config.jumpClearLandingGraceSec >= 0 then
		self._jumpClearLandingGraceSec = config.jumpClearLandingGraceSec or self._jumpClearLandingGraceSec
	end
end

function PlayerVehicleController:getMaxEnergy()
	return math.max(0, self._boostConfig.maxEnergy or 100)
end

function PlayerVehicleController:_resolveSteeringInputRate(damping)
	return math.max(3.5, damping * 0.45)
end

function PlayerVehicleController:_resolveSteeringHoldRampSec()
	return SteeringHoldRampSec
end

function PlayerVehicleController:_resolveSteeringHoldSpeedScale()
	if math.abs(self._steeringInput) <= 0.01 then
		return 0
	end

	local rampSec = self:_resolveSteeringHoldRampSec()
	local hold01 = rampSec <= 0 and 1 or math.min(1, math.max(0, self._steeringHoldDurationSec / rampSec))

	return self:_lerp(SteeringHoldMinSpeedScale, 1, hold01)
end

function PlayerVehicleController:_resolveSteeringSmoothTime(damping)
	return math.min(0.18, math.max(0.08, 1 / math.max(3, damping * 0.65)))
end

function PlayerVehicleController:_resolveLateralVelocitySmoothTime(steeringSmoothTime)
	if math.abs(self._steeringInput) <= 0.01 then
		return steeringSmoothTime * 0.45
	end

	return steeringSmoothTime
end

function PlayerVehicleController:_resolveOrientationSmoothTime(damping)
	return math.min(0.24, math.max(0.12, 1 / math.max(4, damping * 0.45)))
end

function PlayerVehicleController:_resolveYawFollowRate(damping)
	return math.min(16, math.max(9, 2 + damping * 0.18))
end

function PlayerVehicleController:_resolveShortcutJumpOrientationSmoothTime(baseSmoothTime)
	if (self._shortcutJumpRemainingSec or 0) <= 0 then
		return baseSmoothTime
	end

	local sharpness = self:_resolveAirborneHeadingFollowSharpness()
	local airborneSmoothTime = 1 / math.max(8, sharpness * 0.6)

	return math.min(baseSmoothTime, math.max(0.075, airborneSmoothTime))
end

function PlayerVehicleController:_resolveShortcutJumpYawFollowRate(baseYawFollowRate)
	if (self._shortcutJumpRemainingSec or 0) <= 0 then
		return baseYawFollowRate
	end

	return math.max(baseYawFollowRate, self:_resolveAirborneHeadingFollowSharpness())
end

function PlayerVehicleController:_resolveAirborneHeadingFollowSharpness()
	if self._controlConfig then
		return self._controlConfig and self._controlConfig > 0 and self._controlConfig or DefaultAirborneHeadingFollowSharpness
	end
end

function PlayerVehicleController:_resolveTrackForwardFollowSpeedScale()
	if not self:_canTightenTrackForwardFollowBySpeed() then
		return 1
	end

	if not self.getAttrValue or not RacingCarPropEnum or not RacingCarPropEnum.RacingParamId then
		return 1
	end

	local totalBase, totalRatio = self:getAttrValue(RacingCarPropEnum.RacingParamId.SpeedMultiplier, self._lossFactor)
	local speedMultiplier = (1 + (totalBase or 0)) * (1 + (totalRatio or 0))
	local extraSpeedMultiplier = math.max(0, speedMultiplier - 1)

	return 1 + extraSpeedMultiplier * TrackForwardFollowSpeedFactor
end

function PlayerVehicleController:_canTightenTrackForwardFollowBySpeed()
	local isShortcutCruising = self._activeRouteShortcut ~= nil or self._activeNormalShortcut ~= nil

	if not self._laneSwitchActive then
		if (self._laneSwitchCooldownRemainingSec or 0) <= 0 and not self:_isAirborneHandlingActive() then
			if (self._invulnerabilityRemainingSec or 0) <= 0 then
				if (self._perfectDodgeInvulnerabilityRemainingSec or 0) <= 0 then
					if self._activeLayeredRoute == nil or isShortcutCruising then
						local var_67_3

						::label_67_0::

						var_67_3 = not (self._activeUnderwaterRoute ~= nil or self._activeSnowSlopeRoute ~= nil)
					end
				end
			end
		end
	end

	return var_67_3
end

function PlayerVehicleController:_resolveEffectiveTrackForwardOrientationSmoothTime(baseSmoothTime, speedScale)
	if speedScale <= 1 then
		return baseSmoothTime
	end

	return math.max(MinTrackForwardOrientationSmoothTime, baseSmoothTime / speedScale)
end

function PlayerVehicleController:_resolveEffectiveTrackForwardYawFollowRate(baseYawFollowRate, speedScale)
	if speedScale <= 1 then
		return baseYawFollowRate
	end

	return math.min(MaxTrackForwardYawFollowRate, baseYawFollowRate * speedScale)
end

function PlayerVehicleController:_updateEstimatedHorizontalVelocity(previousX, previousZ, currentX, currentZ, deltaTime)
	local estimated = self._estimatedHorizontalVelocity
	local last = self._lastHorizontalPosition

	if deltaTime > 0.0001 then
		local invDelta = 1 / deltaTime

		estimated.x = (currentX - previousX) * invDelta
		estimated.y = 0
		estimated.z = (currentZ - previousZ) * invDelta
	elseif self._hasLastHorizontalPosition then
		estimated.x = currentX - last.x
		estimated.y = 0
		estimated.z = currentZ - last.z
	end

	last.x, last.y, last.z = currentX, 0, currentZ
	self._hasLastHorizontalPosition = true
end

function PlayerVehicleController:_resolveHorizontalVelocity(fromX, fromZ, toX, toZ, deltaTime)
	if deltaTime <= 0.0001 then
		_horizVelCache.x, _horizVelCache.y, _horizVelCache.z = 0, 0, 0

		return _horizVelCache
	end

	local invDelta = 1 / deltaTime

	_horizVelCache.x = (toX - fromX) * invDelta
	_horizVelCache.y = 0
	_horizVelCache.z = (toZ - fromZ) * invDelta

	return _horizVelCache
end

function PlayerVehicleController:_resolveJumpOffset()
	if self._jumpDurationSec <= 0.01 or self._jumpRemainingSec <= 0 then
		return 0
	end

	local normalized = 1 - Mathf.Clamp01(self._jumpRemainingSec / self._jumpDurationSec)

	return math.sin(normalized * math.pi) * math.max(0, self._jumpHeight)
end

function PlayerVehicleController:_resolveItemFlightOffset()
	if not self._currentBuffHeightOffset then
		if self._itemFlightDurationSec <= 0.01 or self._itemFlightRemainingSec <= 0 then
			return self._currentBuffHeightOffset
		end

		local elapsed01 = Mathf.Clamp01(1 - self._itemFlightRemainingSec / self._itemFlightDurationSec)
		local takeoff01 = self:_smoothStep(0, 1, Mathf.Clamp01(elapsed01 / 0.18))
		local landing01 = self:_smoothStep(0, 1, Mathf.Clamp01((1 - elapsed01) / 0.18))

		return self._currentBuffHeightOffset + math.max(0, self._itemFlightHeight) * math.min(takeoff01, landing01)
	end
end

function PlayerVehicleController:addBuffHeightOffset(buffInstanceId, heightOffset)
	self._buffHeightOffsets = self._buffHeightOffsets or {}
	self._buffHeightOffsets[buffInstanceId] = heightOffset or 0
end

function PlayerVehicleController:removeBuffHeightOffset(buffInstanceId)
	if self._buffHeightOffsets then
		self._buffHeightOffsets[buffInstanceId] = nil
	end
end

function PlayerVehicleController:_resolveBuffHeightOffsetTarget()
	local totalHeightOffset = 0

	if self._buffHeightOffsets then
		for _, heightOffset in pairs(self._buffHeightOffsets) do
			totalHeightOffset = totalHeightOffset + (heightOffset or 0)
		end
	end

	return totalHeightOffset
end

function PlayerVehicleController:_resolveRideHeight()
	return self._baseRideHeight + self:_resolveEnvironmentHeightOffset() + (self._activeLayeredRoute and (self._activeLayeredRoute.height or 0) or 0) + self:_resolveJumpOffset()
end

function PlayerVehicleController:_tryTriggerPerfectDodge(currentLane, nextLane)
	if self:_isObstacleDebuffBlockedByItemInvincible() then
		return false
	end

	if self:getIsInvisible() then
		return false
	end

	if self:isItemFlying() then
		return false
	end

	local elements = V3a9RacingCarModel.instance:getGeneratedElements()

	if not elements then
		return false
	end

	local windowDistance = self._perfectDodgeWindowDistance
	local playerDistance = self:_resolveElementCoordinateDistance()

	if not playerDistance then
		return false
	end

	local trackLength = self._trackPath:getEndDistance() - self._trackPath:getStartDistance()
	local playerRouteId = self:getNormalizedRouteId()

	for _, element in ipairs(elements) do
		if element.ElementType == TrackElementType.Obstacle and element.available and currentLane >= element.CoveredLaneStart and currentLane <= element.CoveredLaneEnd then
			if (element.normalizedRouteId or "main") == playerRouteId then
				local forwardDist = element.Distance - playerDistance

				if forwardDist > 0 and forwardDist <= windowDistance then
					self:_setPerfectDodgeInvulnerableFor(PerfectDodgeInvulnerabilitySec)

					for _, effectId in ipairs(self._perfectDodgeEffectList) do
						RacingCarSkillManager.instance:executeEffect(effectId, self, RacingCarPropEnum.TriggerType.ChangeLane, self)
					end

					RacingCarSkillManager.instance:executePassiveSkills(self, RacingCarPropEnum.TriggerType.Dodge, self)
					self:_handlePerfectDodgeSuccess()
					V3a9RacingCarController.instance:dispatchEvent(V3a9RacingCarEvent.OnPerfectDodgeFeedback, Mathf.Sign(nextLane - currentLane))

					return true
				end
			end
		end
	end

	return false
end

function PlayerVehicleController:_handlePerfectDodgeSuccess()
	self._perfectDodgeCombo = (self._perfectDodgeCombo or 0) + 1

	if self._perfectDodgeEnergyBase ~= nil and self._perfectDodgeEnergyPerCombo ~= nil then
		local energyGain = self._perfectDodgeEnergyBase + self._perfectDodgeEnergyPerCombo * self._perfectDodgeCombo

		self:modifyAttribute(RacingCarPropEnum.RacingParamId.UltimateEnergy, energyGain, 0)

		local currentEnergy = self:getCurrentEnergy()
		local maxEnergy = self._ultimateParams.ultimateConfig.energy

		if maxEnergy < currentEnergy then
			self:clearEnergy(maxEnergy)
		end

		V3a9RacingCarController.instance:dispatchEvent(V3a9RacingCarEvent.OnUltimateEnergyChange)
	end

	V3a9RacingCarController.instance:dispatchEvent(V3a9RacingCarEvent.OnPerfectDodgeComboChange, self._perfectDodgeCombo)
end

function PlayerVehicleController:resetPerfectDodgeCombo()
	if (self._perfectDodgeCombo or 0) <= 0 then
		return
	end

	self._perfectDodgeCombo = 0

	V3a9RacingCarController.instance:dispatchEvent(V3a9RacingCarEvent.OnPerfectDodgeComboChange, 0)
end

function PlayerVehicleController:getPerfectDodgeCombo()
	return self._perfectDodgeCombo or 0
end

function PlayerVehicleController:_isObstacleDebuffBlockedByItemInvincible()
	return self.buffManager and self.buffManager.isBuffTypeImmuned and self.buffManager:isBuffTypeImmuned(ObstacleSlowdownBuffType)
end

function PlayerVehicleController:_resolveElementCoordinateDistance()
	if not self._trackPath or not self._trackPath:getIsValid() then
		return nil
	end

	local startDist = self._trackPath:getStartDistance()
	local trackLength = self._trackPath:getEndDistance() - startDist

	if trackLength <= 0 then
		return self._trackDistance
	end

	local mod = self._trackDistance % trackLength

	if mod < 0 then
		mod = mod + trackLength
	end

	return mod + startDist
end

function PlayerVehicleController:_isAirborneHandlingActive()
	local var_84_0

	if self._jumpRemainingSec <= 0 and self._shortcutJumpRemainingSec <= 0 and self._itemFlightRemainingSec <= 0 then
		var_84_0 = self._airborneMotionActive

		if not self._airborneMotionActive then
			if self._landingReattachRemainingSec <= 0 and self._routeTransferFlightRemainingSec <= 0 then
				var_84_0 = self._aerialShortcutExitFlightActive

				if not self._aerialShortcutExitFlightActive then
					if self._activeGlideRoute == nil then
						var_84_0 = self._glideLandingBlendActive

						if not self._glideLandingBlendActive then
							var_84_0 = self._waterDropLandingBlendActive

							if not self._waterDropLandingBlendActive then
								if self._activeWaterfallClimbRoute == nil then
									var_84_0 = self._waterfallClimbExitFlightActive or self._waterDropRemainingSec > 0
								end
							end
						end
					end
				end
			end
		end
	end

	return var_84_0
end

function PlayerVehicleController:_updateLaneSwitchInput()
	if not self._trackPath or not self._trackPath:getIsValid() then
		return
	end

	if self:_isAirborneHandlingActive() then
		return
	end

	local inputThreshold = self:_resolveLaneSwitchInputThreshold()
	local input = inputThreshold <= math.abs(self._steeringInput) and Mathf.Sign(self._steeringInput) or 0

	if math.abs(input) < 0.001 then
		self._previousLaneSwitchInput = 0
		self._smoothedSteeringInput = self:_moveTowards(self._smoothedSteeringInput, 0, 12 * UnityEngine.Time.deltaTime)

		return
	end

	self._smoothedSteeringInput = input

	if self._activeSnowSlopeRoute then
		self._previousLaneSwitchInput = input

		return
	end

	local isNewPress = math.abs(input - self._previousLaneSwitchInput) > 0.001

	self._previousLaneSwitchInput = input

	if not isNewPress then
		return
	end

	if self._laneSwitchActive or self._laneSwitchCooldownRemainingSec > 0 then
		return
	end

	if self._laneSwitchActive then
		if not self._laneSwitchTargetLateral then
			local currentLateral = self._lateralOffset
			local currentLane = self:_resolveNearestLaneIndex(currentLateral)
			local laneCount = self:_resolveLaneSwitchLaneCount()
			local nextLane = Mathf.Clamp(currentLane - Mathf.Round(input), 0, laneCount - 1)

			if nextLane == currentLane then
				if not self._activeGlideRoute and self:_tryEnterGlideShortcutExit(currentLane, laneCount, input) then
					return
				end

				if self._activeLayeredRoute and not self._activeRouteShortcut then
					self:_tryEnterRouteShortcut(currentLane, laneCount, input)
				elseif not self._activeNormalShortcut then
					self:_tryEnterNormalShortcut(currentLane, laneCount, input)
				end

				return
			end

			self:_tryTriggerPerfectDodge(currentLane, nextLane)

			self._laneSwitchStartLateral = self._lateralOffset
			self._laneSwitchVisualDirection = -input
			self._laneSwitchTargetLateral = self:_clampPlayableLateral(self._trackPath:LaneToLateralOffset(nextLane, laneCount))
			self._laneSwitchActive = true

			AudioMgr.instance:trigger(V3a9RacingCarEnum.AudioId.PlaySwitchLane)
		end
	end
end

function PlayerVehicleController:_tryEnterNormalShortcut(currentLane, mainLaneCount, input)
	local localDistance = self._trackPath:WrapDistance(self._trackDistance)

	for _, shortcut in ipairs(self._normalShortcuts) do
		if not NormalShortcutCanEnter(shortcut, localDistance, currentLane, mainLaneCount, input) then
			-- block empty
		else
			local shortcutPath = TrackPath.FromConfig(shortcut.path)

			if not shortcutPath:getIsValid() then
				-- block empty
			else
				self:_beginSpecialRaceDistanceFreeze()
				self:_beginAerialShortcutRoad3D(shortcut)

				self._activeNormalShortcut = shortcut
				self._mainTrackPath = self._trackPath
				self._trackPath = shortcutPath
				self._trackDistance = shortcutPath:getStartDistance()

				local entryLane = NormalShortcutResolveEntryLaneIndex(shortcut.side, shortcut.laneCount)
				local scLaneCount = math.max(1, (not shortcut.laneCount or nil) and 1)

				if shortcut.isAerialShortcut == true then
					local entryMainLaneId = LRRU.LuaIndexToCsLaneId(currentLane, mainLaneCount)
					local shortcutLaneId = AerialShortcut.ResolveEntryShortcutLaneId(shortcut, entryMainLaneId)

					entryLane = LRRU.CsLaneIdToLuaIndex(shortcutLaneId, scLaneCount)
				end

				self._lateralOffset = shortcutPath:LaneToLateralOffset(entryLane, scLaneCount)
				self._laneSwitchTargetLateral = self._lateralOffset
				self._laneSwitchActive = false
				self._lateralVelocity = 0
				self._laneSwitchCooldownRemainingSec = self:_resolveLaneSwitchCooldownSec()
				self._hasTrackState = true

				return true
			end
		end
	end

	return false
end

function PlayerVehicleController:_completeNormalShortcut()
	local completed = self._activeNormalShortcut

	self._activeNormalShortcut = nil

	self:_clearAerialShortcutRoad3D()

	self._trackPath = self._mainTrackPath
	self._trackDistance = Mathf.Clamp(completed.exitMainDistance, self._trackPath:getStartDistance(), self._trackPath:getEndDistance())

	local laneCount = self:_resolveLaneSwitchLaneCount()
	local luaLaneIndex = LRRU.CsLaneIdToLuaIndex(completed.exitMainLaneId, laneCount)

	self._lateralOffset = self._trackPath:LaneToLateralOffset(luaLaneIndex, laneCount)
	self._laneSwitchTargetLateral = self._lateralOffset
	self._laneSwitchActive = false
	self._lateralVelocity = 0
	self._laneSwitchCooldownRemainingSec = self:_resolveLaneSwitchCooldownSec()
	self._hasTrackState = true
end

function PlayerVehicleController:_tryActivateAerialShortcutExitGlide()
	local shortcut = self:_resolveActiveAerialShortcut()

	self:_updateAerialShortcutExitApproach(shortcut)

	local glide = AerialShortcut.FindExitGlide(self._glideRoutes, shortcut, self._trackDistance, self._trackPath and self._trackPath:getEndDistance() or 0)

	if not glide then
		return false
	end

	local laneCount = self:_resolveLaneSwitchLaneCount()
	local currentLaneId = self:_resolveCurrentRouteLaneId()

	return self:_beginAerialShortcutExitFlight(glide, shortcut, currentLaneId, laneCount)
end

function PlayerVehicleController:_updateAerialShortcutExitApproach(shortcut)
	if not shortcut or not self._trackPath or not self._trackPath:getIsValid() then
		self:setJumpPadApproachVisualHeight(0)

		return
	end

	local exitDistance = AerialShortcut.ResolveExitTriggerDistance(shortcut, self._trackPath:getEndDistance())
	local approachStartDistance = exitDistance - JumpPadApproachRules.ApproachCenterLeadDistance
	local height = 0

	if approachStartDistance <= self._trackDistance then
		local approachDistance = math.min(self._trackDistance, exitDistance)

		height = JumpPadApproachRules.ResolveApproachHeight(approachDistance, approachStartDistance, exitDistance)
	end

	self:setJumpPadApproachVisualHeight(height)
end

function PlayerVehicleController:_updateLaneSwitchMotion(deltaTime)
	if self._activeSnowSlopeRoute then
		self:_updateSnowSlopeSlideMotion(deltaTime)

		return
	end

	if not self._laneSwitchActive then
		self._lateralVelocity = 0
		self._lateralVelocityDampVelocity = 0

		return
	end

	local previousLateral = self._lateralOffset

	self._lateralOffset = self:_moveTowards(self._lateralOffset, self._laneSwitchTargetLateral, self:_resolveLaneSwitchSpeed() * math.max(0, deltaTime))

	if deltaTime > 0.0001 then
		self._lateralVelocity = (self._lateralOffset - previousLateral) / deltaTime or 0
	end

	if math.abs(self._lateralOffset - self._laneSwitchTargetLateral) <= 0.01 then
		self._lateralOffset = self._laneSwitchTargetLateral
		self._lateralVelocity = 0
		self._laneSwitchActive = false
		self._laneSwitchVisualDirection = 0
		self._laneSwitchCooldownRemainingSec = self:_resolveLaneSwitchCooldownSec()
	end
end

function PlayerVehicleController:_updateSnowSlopeSlideMotion(deltaTime)
	local slope = self._activeSnowSlopeRoute

	if not slope or not self._trackPath or not self._trackPath:getIsValid() then
		return
	end

	local inputThreshold = self:_resolveLaneSwitchInputThreshold()
	local input = SnowSlope.ResolveSlideInput(slope, -self._steeringInput, inputThreshold)

	if math.abs(input) > 0.001 then
		self._snowSlopeSlideDirection = input
	end

	local previousLateral = self._lateralOffset
	local targetVelocity = SnowSlope.ResolveSlideTargetVelocity(slope, self._snowSlopeSlideDirection)
	local sameDirection = math.abs(self._snowSlopeSlideVelocity) <= 0.001 or math.abs(targetVelocity) <= 0.001 or Mathf.Sign(self._snowSlopeSlideVelocity) == Mathf.Sign(targetVelocity)

	if sameDirection then
		local var_91_0 = slope.slideAcceleration or 60
	else
		var_91_0 = slope.slideDeceleration
	end

	if not slope.slideDeceleration then
		local acceleration = 45

		self._snowSlopeSlideVelocity = self:_moveTowards(self._snowSlopeSlideVelocity, targetVelocity, math.max(0.01, acceleration) * math.max(0, deltaTime))
		self._lateralOffset = self._lateralOffset + self._snowSlopeSlideVelocity * math.max(0, deltaTime)

		local laneCount = self:_resolveLaneSwitchLaneCount()
		local edgeLaneA = self._trackPath:LaneToLateralOffset(0, laneCount)
		local edgeLaneB = self._trackPath:LaneToLateralOffset(laneCount - 1, laneCount)
		local minLateral = math.min(edgeLaneA, edgeLaneB)
		local maxLateral = math.max(edgeLaneA, edgeLaneB)

		if minLateral >= self._lateralOffset or maxLateral <= self._lateralOffset then
			self._lateralOffset = math.max(minLateral, math.min(maxLateral, self._lateralOffset))
			self._snowSlopeSlideVelocity = self._snowSlopeSlideVelocity * Mathf.Clamp01(slope.edgeStopDamping or 0.35)

			if minLateral >= self._lateralOffset and self._snowSlopeSlideDirection < 0 or maxLateral <= self._lateralOffset and self._snowSlopeSlideDirection > 0 then
				self._snowSlopeSlideDirection = 0
				self._snowSlopeSlideVelocity = 0
			end
		end

		if deltaTime > 0.0001 then
			self._lateralVelocity = (self._lateralOffset - previousLateral) / deltaTime or 0
		end

		self._laneSwitchTargetLateral = self._lateralOffset
		self._laneSwitchActive = math.abs(self._lateralVelocity) > 0.01
		self._laneSwitchVisualDirection = self._snowSlopeSlideDirection
	end
end

function PlayerVehicleController:jumpLane(laneOffset)
	if not self._trackPath or not self._trackPath:getIsValid() then
		return
	end

	laneOffset = laneOffset or 0

	if laneOffset == 0 then
		return
	end

	local laneCount = self:_resolveLaneSwitchLaneCount()

	if self._laneSwitchActive then
		if not self._laneSwitchTargetLateral then
			local currentLateral = self._lateralOffset
			local currentLane = self:_resolveNearestLaneIndex(currentLateral)
			local nextLane = Mathf.Clamp(currentLane + laneOffset, 0, laneCount - 1)

			if nextLane == currentLane then
				return
			end

			self._laneSwitchTargetLateral = self:_clampPlayableLateral(self._trackPath:LaneToLateralOffset(nextLane, laneCount))
			self._laneSwitchActive = true
		end
	end
end

function PlayerVehicleController:_moveAirborneOnTrack(deltaTime, acceleration, damping, maxLateralSpeed)
	if not self._airborneMotionActive then
		self:_beginAirborneMotion()
	end

	local distanceDelta = self._forwardSpeed * deltaTime

	self._trackDistance = self._trackDistance + distanceDelta

	if not self._specialRaceDistanceFrozen then
		self._totalRaceDistance = self._totalRaceDistance + distanceDelta
	end

	local desiredVelocity = self._airborneForward * self._forwardSpeed + self._airborneRight * (self._smoothedSteeringInput * maxLateralSpeed * self:_resolveAirborneLateralControl())

	self._airborneHorizontalVelocity = self:_moveTowards(self._airborneHorizontalVelocity, desiredVelocity, math.max(1, acceleration) * self:_resolveAirborneVelocityAdjustMultiplier() * deltaTime)

	local transform = self._transform
	local prevX, prevY, prevZ = transformhelper.getPos(transform)
	local nextX = prevX + self._airborneHorizontalVelocity.x * deltaTime
	local nextZ = prevZ + self._airborneHorizontalVelocity.z * deltaTime
	local rideHeight = self:_resolveRideHeight() + self:_resolveItemFlightOffset()

	transformhelper.setPos(transform, nextX, rideHeight, nextZ)

	_position2DCache.x = nextX
	_position2DCache.y = nextZ

	self._trackPath:ProjectToByDistance(_position2DCache, self._projectionCache, self._trackDistance)

	local airborneProjection = self._projectionCache

	self._lateralOffset = self._trackPath:ClampLateral(airborneProjection.lateralOffset)

	self._trackPath:SampleTo(airborneProjection.distance, self._lateralOffset, self._futurePoseCache)

	local guidePose = self._futurePoseCache
	local gtx, gtz = guidePose.tangent.x, guidePose.tangent.y
	local gtSqr = gtx * gtx + gtz * gtz

	if gtSqr > 1e-06 then
		local invLen = 1 / math.sqrt(gtSqr)

		_tangentCache.x, _tangentCache.y, _tangentCache.z = gtx * invLen, 0, gtz * invLen
	else
		_tangentCache.x, _tangentCache.y, _tangentCache.z = 0, 0, 0
	end

	self:_updateEstimatedHorizontalVelocity(prevX, prevZ, nextX, nextZ, deltaTime)
	self:_updateVehicleOrientation(_tangentCache, self._airborneHorizontalVelocity, damping, deltaTime)
end

function PlayerVehicleController:_moveShortcutJumpOnTrack(deltaTime, damping)
	local previousTrackDistance = self._trackDistance
	local distance, lateral, jumpOffset, finished = self:_advanceShortcutJump(deltaTime)

	self._trackDistance = distance
	self._lateralOffset = self._trackPath:ClampLateral(lateral)

	local distanceDelta = math.abs(self._trackDistance - previousTrackDistance)

	if distanceDelta > 0 and not self._specialRaceDistanceFrozen then
		self._totalRaceDistance = self._totalRaceDistance + distanceDelta
	end

	local transform = self._transform
	local prevX, prevY, prevZ = transformhelper.getPos(transform)
	local finishedLandingPose

	self._trackPath:SampleTo(self._trackDistance, self._lateralOffset, self._poseCache)

	local shortcutPose = self._poseCache
	local finalX = shortcutPose.position.x
	local finalY = self._shortcutJumpTakeoffY + ((finished or nil) and 0)
	local finalZ = shortcutPose.position.y

	if finished then
		self._trackPath:SampleTo(self._trackDistance, self._lateralOffset, self._futurePoseCache)

		finishedLandingPose = self._futurePoseCache
		finalX = self._futurePoseCache.position.x
		finalY = self:_resolveRideHeight() + self:_resolveItemFlightOffset()
		finalZ = self._futurePoseCache.position.y
	end

	transformhelper.setPos(transform, finalX, finalY, finalZ)

	local fx, fz

	if finishedLandingPose then
		fz = finishedLandingPose.tangent.y
		fx = finishedLandingPose.tangent.x

		if fx * fx + fz * fz <= 1e-06 then
			fx = nil
		end
	else
		fz = shortcutPose.tangent.y
		fx = shortcutPose.tangent.x

		if fx * fx + fz * fz <= 1e-06 then
			local fwd = self._shortcutJumpTakeoffForward

			fz = fwd.z
			fx = fwd.x

			if fx * fx + fz * fz <= 1e-06 then
				fx = nil
			end
		end
	end

	local tangent

	if fx then
		local invLen = 1 / math.sqrt(fx * fx + fz * fz)

		_tangentCache.x, _tangentCache.y, _tangentCache.z = fx * invLen, 0, fz * invLen
		tangent = _tangentCache
	else
		tangent = self._stableTrackForward
	end

	self:_updateEstimatedHorizontalVelocity(prevX, prevZ, finalX, finalZ, deltaTime)
	self:_updateVehicleOrientation(tangent, self._estimatedHorizontalVelocity, damping, deltaTime)

	if finished then
		self._laneSwitchActive = false
		self._laneSwitchTargetLateral = self._lateralOffset
		self._lateralVelocity = 0
		self._routeTransferProjectionLockRemainingSec = math.max(self._routeTransferProjectionLockRemainingSec or 0, 0.25)
	end
end

function PlayerVehicleController:_moveLandingReattachOnTrack(deltaTime, damping)
	local remaining = math.max(0.0001, self._landingReattachRemainingSec)
	local blendStep = Mathf.Clamp01(deltaTime / remaining)
	local transform = self._transform
	local prevX, prevY, prevZ = transformhelper.getPos(transform)

	_position2DCache.x = prevX
	_position2DCache.y = prevZ

	self._trackPath:ProjectToByDistance(_position2DCache, self._projectionCache, self._trackDistance)

	local projection = self._projectionCache
	local distanceDelta = self._forwardSpeed * deltaTime

	self._trackDistance = self._trackDistance + distanceDelta

	local targetLateral = self._trackPath:ClampLateral(projection.lateralOffset)

	self._lateralOffset = self:_lerp(self._lateralOffset, targetLateral, blendStep)

	if not self._specialRaceDistanceFrozen then
		self._totalRaceDistance = self._totalRaceDistance + distanceDelta
	end

	self._trackPath:SampleTo(self._trackDistance, self._lateralOffset, self._poseCache)

	local pose = self._poseCache
	local targetX = pose.position.x
	local targetY = self:_resolveRideHeight() + self:_resolveItemFlightOffset()
	local targetZ = pose.position.y
	local newX = prevX + (targetX - prevX) * blendStep
	local newY = prevY + (targetY - prevY) * blendStep
	local newZ = prevZ + (targetZ - prevZ) * blendStep

	transformhelper.setPos(transform, newX, newY, newZ)

	self._landingReattachRemainingSec = math.max(0, self._landingReattachRemainingSec - deltaTime)

	if self._landingReattachRemainingSec <= 0 then
		transformhelper.setPos(transform, targetX, targetY, targetZ)

		newZ = targetZ
		newY = targetY
		newX = targetX
		self._airborneMotionActive = false
		_position2DCache.x = targetX
		_position2DCache.y = targetZ

		self._trackPath:ProjectToByDistance(_position2DCache, self._projectionCache, self._trackDistance)

		local finalProjection = self._projectionCache

		self._lateralOffset = self._trackPath:ClampLateral(finalProjection.lateralOffset)

		self:_beginRecenterToNearestLane()
	end

	local ttx, ttz = pose.tangent.x, pose.tangent.y
	local ttSqr = ttx * ttx + ttz * ttz

	if ttSqr > 1e-06 then
		local invLen = 1 / math.sqrt(ttSqr)

		_tangentCache.x, _tangentCache.y, _tangentCache.z = ttx * invLen, 0, ttz * invLen
	else
		_tangentCache.x, _tangentCache.y, _tangentCache.z = 0, 0, 0
	end

	self:_updateEstimatedHorizontalVelocity(prevX, prevZ, newX, newZ, deltaTime)
	self:_updateVehicleOrientation(_tangentCache, self._estimatedHorizontalVelocity, damping, deltaTime)
end

function PlayerVehicleController:_resolveJumpClearLandingGraceSec()
	local referenceGraceSec = math.max(0, self._jumpClearLandingGraceSec)

	if referenceGraceSec <= 0 then
		return 0
	end

	local referenceSpeed = math.max(1, self._drivePowerConfig.baseHorsepower or 10)
	local currentSpeed = math.max(1, self._forwardSpeed)
	local maxClearDistance = referenceGraceSec * referenceSpeed
	local speedScaledGraceSec = maxClearDistance / currentSpeed
	local lowSpeedGraceCapSec = referenceGraceSec * 1.2

	return Mathf.Clamp(speedScaledGraceSec, referenceGraceSec * 0.45, lowSpeedGraceCapSec)
end

function PlayerVehicleController:_resolveLandingReattachDurationSec()
	return (self._controlConfig.landingReattachDurationSec and self._controlConfig.landingReattachDurationSec >= 0 or nil) and (self._controlConfig.landingReattachDurationSec or 0.24)
end

function PlayerVehicleController:_resolveAirborneLateralControl()
	return (self._controlConfig.airborneLateralControl and self._controlConfig.airborneLateralControl > 0 or nil) and (self._controlConfig.airborneLateralControl or 0.65)
end

function PlayerVehicleController:_resolveAirborneVelocityAdjustMultiplier()
	return (self._controlConfig.airborneVelocityAdjustMultiplier and self._controlConfig.airborneVelocityAdjustMultiplier > 0 or nil) and (self._controlConfig.airborneVelocityAdjustMultiplier or 0.75)
end

function PlayerVehicleController:_resolveLaneSwitchInputThreshold()
	return self._controlConfig.laneSwitchInputThreshold and self._controlConfig.laneSwitchInputThreshold > 0 and Mathf.Clamp01(self._controlConfig.laneSwitchInputThreshold) or 0.5
end

function PlayerVehicleController:_resolveLaneSwitchSpeed()
	return self._laneSwitchSpeed
end

function PlayerVehicleController:_resolveLaneSwitchLaneCount()
	if self._activeUnderwaterRoute then
		return math.max(1, self._activeUnderwaterRoute.laneCount or 1)
	end

	if self._activeSnowSlopeRoute then
		return math.max(1, self._activeSnowSlopeRoute.laneCount or 1)
	end

	if self._activeRouteShortcut then
		return math.max(1, self._activeRouteShortcut.laneCount or 1)
	end

	if self._activeNormalShortcut then
		return math.max(1, self._activeNormalShortcut.laneCount or 1)
	end

	if self._activeLayeredRoute then
		return math.max(1, self._activeLayeredRoute.laneCount or 1)
	end

	return (self._controlConfig.laneSwitchLaneCount and self._controlConfig.laneSwitchLaneCount > 0 or nil) and (self._controlConfig.laneSwitchLaneCount or 4)
end

function PlayerVehicleController:_resolveLaneSwitchCooldownSec()
	return self._laneSwitchInputThreshold
end

function PlayerVehicleController:_resolveLaneSwitchOrientationSmoothTime()
	return (self._controlConfig.laneSwitchOrientationSmoothTime and self._controlConfig.laneSwitchOrientationSmoothTime > 0 or nil) and (self._controlConfig.laneSwitchOrientationSmoothTime or 0.04)
end

function PlayerVehicleController:_resolveLaneSwitchYawFollowRate()
	return (self._controlConfig.laneSwitchYawFollowRate and self._controlConfig.laneSwitchYawFollowRate > 0 or nil) and (self._controlConfig.laneSwitchYawFollowRate or 30)
end

function PlayerVehicleController:_resolveNearestLaneIndex(lateral)
	local bestLane = 0
	local bestDistance = math.huge
	local laneCount = self:_resolveLaneSwitchLaneCount()

	for laneIndex = 0, laneCount - 1 do
		local laneLateral = self._trackPath:LaneToLateralOffset(laneIndex, laneCount)
		local distance = math.abs(laneLateral - lateral)

		if distance < bestDistance then
			bestDistance = distance
			bestLane = laneIndex
		end
	end

	return bestLane
end

function PlayerVehicleController:_beginRecenterToNearestLane()
	if not self._trackPath or not self._trackPath:getIsValid() then
		return
	end

	if self._laneSwitchActive then
		return
	end

	if self._activeSnowSlopeRoute then
		return
	end

	local laneCount = self:_resolveLaneSwitchLaneCount()
	local laneIndex = self:_resolveNearestLaneIndex(self._lateralOffset)
	local laneCenter = self:_clampPlayableLateral(self._trackPath:LaneToLateralOffset(laneIndex, laneCount))

	if math.abs(laneCenter - self._lateralOffset) <= 0.05 then
		return
	end

	self._laneSwitchTargetLateral = laneCenter
	self._laneSwitchActive = true
end

function PlayerVehicleController:_clampPlayableLateral(value)
	local halfWidth = self:_getPlayableHalfWidth()

	return Mathf.Clamp(value, -halfWidth, halfWidth)
end

function PlayerVehicleController:_getPlayableHalfWidth()
	return math.max(0.1, self._trackPath:getHalfRoadWidth() - 0.25)
end

function PlayerVehicleController:_resolveRightFromForward(forward)
	local x, z = forward.x, forward.z
	local sqr = x * x + z * z

	if sqr > 0.001 then
		local inv = 1 / math.sqrt(sqr)

		return SetVec3(_basePosCache, z * inv, 0, -x * inv)
	end

	return SetVec3(_basePosCache, 1, 0, 0)
end

function PlayerVehicleController:_resolveFlatForward(forward)
	return CreateFlatForward(forward.x, forward.z)
end

function PlayerVehicleController:_smoothDamp(current, target, dampVelocity, smoothTime, maxSpeed, deltaTime)
	if smoothTime <= 0 then
		return target, 0
	end

	local omega = 1 / smoothTime
	local x = omega * deltaTime
	local exp = 1 / (1 + x + 0.48 * x * x + 0.235 * x * x * x)
	local change = current - target
	local temp = (dampVelocity + omega * change) * deltaTime
	local newDampVelocity = (dampVelocity - omega * temp) * exp
	local newValue = target + (change + temp) * exp

	if math.abs(newValue - current) > maxSpeed * deltaTime then
		local diff = newValue - current

		newValue = current + (diff > 0 and 1 or -1) * maxSpeed * deltaTime
	end

	return newValue, newDampVelocity
end

function PlayerVehicleController:getVisualSteeringInput()
	return -self._smoothedSteeringInput
end

function PlayerVehicleController:getIsBoosting()
	return self._boostRemainingSec > 0
end

function PlayerVehicleController:getIsUltimateBoosting()
	return self:getIsBoosting() and self._isUltimateBoostActive
end

function PlayerVehicleController:getUltimateBoostTriggerCount()
	return self._ultimateBoostTriggerCount
end

function PlayerVehicleController:getStableForward()
	if self._stableTrackForward and self._stableTrackForward.sqrMagnitude > 0.001 then
		return self._stableTrackForward
	end

	local forwardX, forwardY, forwardZ = transformhelper.getForward(self._transform)

	return Vector3(forwardX, forwardY, forwardZ)
end

function PlayerVehicleController:getBoostCameraPush01()
	if self._boostRemainingSec <= 0 then
		return 0
	end

	local pushIntensity = 0

	pushIntensity = self._isUltimateBoostActive and 1 or 0.6

	if self._isUltimateBoostActive then
		local var_118_0 = self._boostConfig.ultimateBoostDurationSec or 3
	else
		var_118_0 = self._boostConfig.durationSec
	end

	if not self._boostConfig.durationSec then
		local duration = 3

		if duration and duration > 0 then
			local timeRatio = self._boostRemainingSec / duration

			pushIntensity = pushIntensity * Mathf.Clamp01(timeRatio)
		end

		return Mathf.Clamp01(pushIntensity)
	end
end

function PlayerVehicleController:getNormalizedSpeed()
	return 1
end

function PlayerVehicleController:getForwardSpeed()
	if self._activeWaterfallClimbRoute then
		if (self._waterfallClimbTravelSpeed or 0) > 0 then
			return self._waterfallClimbTravelSpeed
		end
	end

	if self._activeGlideRoute then
		if (self._glideEntryFlightRemainingSec or 0) <= 0 then
			return self._glideTravelSpeed
		end
	end

	return self._forwardSpeed
end

function PlayerVehicleController:getCountdownForwardSpeed()
	return self._countdownForwardSpeed or 0
end

function PlayerVehicleController:_isGlidePresentationActive()
	return self._glideEntryFlightRemainingSec and self._glideEntryFlightRemainingSec > 0 or self._activeGlideRoute ~= nil or self._glideLandingBlendActive
end

function PlayerVehicleController:_isGlideLandingBurstActive()
	if self._glideLandingBlendActive then
		return true
	end

	local glide = self._activeGlideRoute

	if not glide then
		return false
	end

	if glide.curveLength and glide.curveLength > 0 then
		local length = math.max(0.01, glide.curveLength or EstimateGlideLength(glide))

		return self:_resolveGlideLandingProgress(glide, length, self._glideDistance or 0) > 0
	end
end

function PlayerVehicleController:_isSpecialTrackLandingBurstPresentationActive()
	return self:_isGlideLandingBurstActive() or self._waterDropLandingBlendActive
end

function PlayerVehicleController:setUltimateVehicleFxTierOverride(speedLineTier, tailWakeTier)
	self._ultimateSpeedLineTierOverride = math.max(0, speedLineTier or 0)
	self._ultimateTailWakeTierOverride = math.max(0, tailWakeTier or 0)
end

function PlayerVehicleController:clearUltimateVehicleFxTierOverride()
	self._ultimateSpeedLineTierOverride = 0
	self._ultimateTailWakeTierOverride = 0
end

function PlayerVehicleController:getPresentationSpeedLineTierOverride()
	local tier = 0

	if self:_isSpecialTrackLandingBurstPresentationActive() then
		tier = SpecialTrackLandingBurstSpeedLineTierOverride
	elseif self._activeWaterDrop then
		tier = self._waterDropFeedbackTier - 1
	elseif self:_isGlidePresentationActive() then
		-- block empty
	end

	return math.max(tier, self._ultimateSpeedLineTierOverride or 0)
end

function PlayerVehicleController:getPresentationTailWakeTierOverride()
	local tier = 0

	if self:_isSpecialTrackLandingBurstPresentationActive() then
		tier = SpecialTrackLandingBurstTailWakeTierOverride
	elseif self._activeWaterDrop then
		tier = self._waterDropFeedbackTier
	elseif self:_isGlidePresentationActive() then
		-- block empty
	end

	return math.max(tier, self._ultimateTailWakeTierOverride or 0)
end

function PlayerVehicleController:getCurrentEnergy()
	return self:getAttrValue(RacingCarPropEnum.RacingParamId.UltimateEnergy, 0)
end

function PlayerVehicleController:clearEnergy(remainEnergy)
	self:resetAttribute(RacingCarPropEnum.RacingParamId.UltimateEnergy)

	if remainEnergy > 0 then
		self:modifyAttribute(RacingCarPropEnum.RacingParamId.UltimateEnergy, remainEnergy, 0)
	end
end

function PlayerVehicleController:tryUseUltimateSkill()
	if self._isUsingUltimateSkill then
		return false
	end

	local racer = V3a9RacingCarModel.instance:getMainPlayerRacer()
	local ultimateId = racer and racer.ultimateId
	local ultimateConfig = ultimateId and lua_racing_ultimate.configDict[ultimateId]

	if not ultimateConfig then
		return false
	end

	if not ultimateConfig.energy then
		local maxEnergy = 0
		local needEnergy = maxEnergy
		local currentEnergy = self:getCurrentEnergy()

		currentEnergy = math.min(currentEnergy, maxEnergy)

		if self._ultimateParams then
			if self._ultimateParams.ultimateType ~= RacingCarPropEnum.UltimateEnergyType.PerSecond then
				needEnergy = self._ultimateParams.ultimateCostEnergy
			else
				needEnergy = 0

				if currentEnergy < maxEnergy then
					return false
				end
			end
		end

		if needEnergy > 0 and currentEnergy < needEnergy then
			return false
		end

		local effectList = string.splitToNumber(ultimateConfig.effect or "", "|")

		for _, effectId in ipairs(effectList) do
			RacingCarSkillManager.instance:executeEffect(effectId, self, RacingCarPropEnum.TriggerType.UseSkill, self)
		end

		self:clearEnergy(currentEnergy - needEnergy)
		V3a9RacingCarController.instance:dispatchEvent(V3a9RacingCarEvent.OnUltimateEnergyChange)
		V3a9RacingCarController.instance:dispatchEvent(V3a9RacingCarEvent.OnUltimateUsed, ultimateId, self, effectList)

		if self._ultimateParams and self._ultimateParams.ultimateType == RacingCarPropEnum.UltimateEnergyType.PerSecond then
			self._isUsingUltimateSkill = true
		end

		return true
	end
end

function PlayerVehicleController:resetUltimateSkillState()
	self._isUsingUltimateSkill = false
end

function PlayerVehicleController:isUsingUltimateSkill()
	return self._isUsingUltimateSkill == true
end

function PlayerVehicleController:getCoinCount()
	return self._coinCount or 0
end

function PlayerVehicleController:getTrackDistance()
	return self._trackDistance
end

function PlayerVehicleController:getDistance()
	return self:_resolveCurrentLapRaceDistance()
end

function PlayerVehicleController:getTotalTrackDistance()
	return self._totalRaceDistance
end

function PlayerVehicleController:getLateralOffset()
	return self._lateralOffset
end

function PlayerVehicleController:getCurrentLaneIndex()
	return self:_resolveNearestLaneIndex(self._lateralOffset)
end

function PlayerVehicleController:getTargetLaneIndex()
	if self._laneSwitchActive then
		if not self._laneSwitchTargetLateral then
			local targetLateral = self._lateralOffset

			return self:_resolveNearestLaneIndex(targetLateral)
		end
	end
end

function PlayerVehicleController:isChangingLane()
	return self._laneSwitchActive == true
end

function PlayerVehicleController:isEligibleForMainLaneOccupancy()
	if not self._hasTrackState or not self._trackPath or not self._trackPath:getIsValid() then
		return false
	end

	return self:getNormalizedRouteId() == "main" and not self:isOnNormalShortcut() and not self:_isAirborneHandlingActive()
end

function PlayerVehicleController:getLaneCount()
	return self:_resolveLaneSwitchLaneCount()
end

function PlayerVehicleController:hasTrackState()
	return self._hasTrackState
end

function PlayerVehicleController:isPostFinish()
	return self._postFinishElapsed >= 0
end

function PlayerVehicleController:isOnNormalShortcut()
	return self._activeNormalShortcut ~= nil
end

function PlayerVehicleController:getTrackPath()
	return self._trackPath
end

function PlayerVehicleController:addCoinEnergy()
	self._coinCount = self._coinCount + 1

	V3a9RacingCarController.instance:dispatchEvent(V3a9RacingCarEvent.OnCoinEnergyGain, self._coinCount)
end

function PlayerVehicleController:canJumpClear(elementType)
	if elementType ~= 4 then
		return false
	end

	if self._jumpClearGraceRemainingSec > 0 or self._jumpRemainingSec > 0 then
		return true
	end

	if ManualSpaceJumpEnabled and self._jumpCooldownRemainingSec <= 0 and UnityEngine.Input.GetKey(UnityEngine.KeyCode.Space) then
		return self:tryJump()
	end

	return false
end

function PlayerVehicleController:isItemFlying()
	local var_150_2

	if (self._itemFlightRemainingSec or 0) <= 0 then
		if (self._currentBuffHeightOffset or 0) <= BuffHeightFlyingEpsilon and self:_resolveBuffHeightOffsetTarget() <= BuffHeightFlyingEpsilon then
			var_150_2 = false

			goto label_150_0
		end
	end

	::label_150_0::

	return true
end

function PlayerVehicleController:isInFlyingState()
	if self:isItemFlying() then
		return true
	end

	if (self._shortcutJumpRemainingSec or 0) > 0 then
		return true
	end

	if self._activeGlideRoute ~= nil then
		return true
	end

	if self._activeWaterfallClimbRoute ~= nil or self._waterfallClimbExitFlightActive or false then
		return true
	end

	if (self._routeTransferFlightRemainingSec or 0) > 0 then
		return true
	end

	if self._aerialShortcutExitFlightActive or false then
		return true
	end

	if (self._waterDropRemainingSec or 0) > 0 then
		return true
	end

	return false
end

function PlayerVehicleController:hasCollisionShield()
	return self._hasCollisionShield
end

function PlayerVehicleController:tryStoreItem(itemConfig)
	if not itemConfig then
		return false
	end

	if not self._heldItem then
		self._heldItem = itemConfig

		V3a9RacingCarController.instance:dispatchEvent(V3a9RacingCarEvent.OnStoreItemChange)
		RacingCarSkillManager.instance:executePassiveSkills(self, RacingCarPropEnum.TriggerType.GetItem, self, itemConfig.id)
		RacingCarSkillManager.instance:executePassiveSkills(self, RacingCarPropEnum.TriggerType.GetItemRand, self)

		return true
	end

	if not self._backupItem then
		self._backupItem = itemConfig

		V3a9RacingCarController.instance:dispatchEvent(V3a9RacingCarEvent.OnStoreItemChange)
		RacingCarSkillManager.instance:executePassiveSkills(self, RacingCarPropEnum.TriggerType.GetItem, self, itemConfig.id, true)
		RacingCarSkillManager.instance:executePassiveSkills(self, RacingCarPropEnum.TriggerType.GetItemRand, self)

		return true
	end

	return false
end

function PlayerVehicleController:tryUseHeldItem()
	if not self._heldItem then
		return false
	end

	if self._heldItem then
		local effectList = string.split(self._heldItem.effect or "", "|")

		for _, effectIdText in ipairs(effectList) do
			local effectId = tonumber(effectIdText)

			if effectId then
				RacingCarSkillManager.instance:executeEffect(effectId, self, RacingCarPropEnum.TriggerType.UseItem, self)
			end
		end
	end

	local used = true

	if used then
		self._heldItem = self._backupItem
		self._backupItem = nil

		V3a9RacingCarController.instance:dispatchEvent(V3a9RacingCarEvent.OnStoreItemChange)
	end

	return used
end

function PlayerVehicleController:hasItem()
	return self._heldItem ~= nil
end

function PlayerVehicleController:hasBackupItem()
	return self._backupItem ~= nil
end

function PlayerVehicleController:getHeldItem()
	return self._heldItem
end

function PlayerVehicleController:getBackupItem()
	return self._backupItem
end

function PlayerVehicleController:convertItems(sourceItemIds, conversionMap, isBackup)
	if not conversionMap then
		return
	end

	local changed = false

	if self._heldItem and not isBackup then
		local newItem = conversionMap[self._heldItem.id]

		if newItem then
			self._heldItem = newItem
			changed = true
		end
	end

	if self._backupItem and isBackup then
		local newItem = conversionMap[self._backupItem.id]

		if newItem then
			self._backupItem = newItem
			changed = true
		end
	end

	if changed then
		V3a9RacingCarController.instance:dispatchEvent(V3a9RacingCarEvent.OnStoreItemChange)
	end
end

function PlayerVehicleController:_resolveTrackBoostTargetSpeedMultiplier()
	return (self._boostConfig.trackBoostTargetSpeedMultiplier and self._boostConfig.trackBoostTargetSpeedMultiplier > 1 or nil) and (self._boostConfig.trackBoostTargetSpeedMultiplier or 1.5)
end

function PlayerVehicleController:_resolveTrackBoostDurationSec()
	return (self._boostConfig.trackBoostDurationSec and self._boostConfig.trackBoostDurationSec > 0 or nil) and (self._boostConfig.trackBoostDurationSec or math.max(0, self._boostConfig.durationSec or 0))
end

function PlayerVehicleController:_resolveTrackBoostInstantSpeedAdd()
	return (self._boostConfig.trackBoostInstantSpeedAdd and self._boostConfig.trackBoostInstantSpeedAdd > 0 or nil) and (self._boostConfig.trackBoostInstantSpeedAdd or self._boostConfig.boostInstantSpeedAdd or 0)
end

function PlayerVehicleController:_resolveUltimateBoostMultiplier()
	return (self._boostConfig.ultimateBoostMultiplier and self._boostConfig.ultimateBoostMultiplier > 0 or nil) and (self._boostConfig.ultimateBoostMultiplier or math.max(0, self._boostConfig.speedMultiplier or 0))
end

function PlayerVehicleController:_resolveUltimateBoostDurationSec()
	return (self._boostConfig.ultimateBoostDurationSec and self._boostConfig.ultimateBoostDurationSec > 0 or nil) and (self._boostConfig.ultimateBoostDurationSec or math.max(0, self._boostConfig.durationSec or 0))
end

function PlayerVehicleController:_resolveUltimateBoostInstantSpeedAdd()
	return (self._boostConfig.ultimateBoostInstantSpeedAdd and self._boostConfig.ultimateBoostInstantSpeedAdd > 0 or nil) and (self._boostConfig.ultimateBoostInstantSpeedAdd or self._boostConfig.boostInstantSpeedAdd or 0)
end

function PlayerVehicleController:_checkRaceCompletion()
	if not self._trackPath or not self._trackPath:getIsValid() then
		return
	end

	if self._hasPlayerFinished then
		return
	end

	if self._postFinishElapsed >= 0 then
		return
	end

	local playerDistance = self:getTotalTrackDistance()

	self:_checkAndReportLapUpdate(playerDistance)

	if not V3a9RacingCarModel.instance:isRaceFinished() then
		local playerFinished = V3a9RacingCarModel.instance:checkRaceCompletion(playerDistance, true, PlayerRacerId)

		if playerFinished then
			self._postFinishElapsed = V3a9RacingCarModel.instance:getRaceTime()

			self._trackPath:SampleTo(self._trackDistance, self._lateralOffset, self._poseCache)

			local tx, tz = self._poseCache.tangent.x, self._poseCache.tangent.y
			local tSqr = tx * tx + tz * tz

			if tSqr > 0.001 then
				local invLen = 1 / math.sqrt(tSqr)

				self._postFinishForward = Vector3(tx * invLen, 0, tz * invLen)
			else
				self._postFinishForward = self._stableTrackForward
			end

			V3a9RacingCarController.instance:dispatchEvent(V3a9RacingCarEvent.OnPlayerReach)
		end
	end
end

function PlayerVehicleController:_checkAndReportLapUpdate(playerDistance)
	local currentLap, totalLaps = V3a9RacingCarModel.instance:getCurrentLap(playerDistance)

	if currentLap ~= self._lastReportedLap then
		self._lastReportedLap = currentLap

		V3a9RacingCarController.instance:dispatchEvent(V3a9RacingCarEvent.OnLapUpdate, currentLap, totalLaps)
	end
end

function PlayerVehicleController:onDestroy()
	self:_setInvulnerabilityRenderersVisible(true)
	self:_disposeVehicleBase()

	self._go = nil
	self._transform = nil
	self._flashRenderers = nil
end

function PlayerVehicleController:resetForRestart()
	self:clearUltimateVehicleFxTierOverride()

	self._trackDistance = 0
	self._totalRaceDistance = 0
	self._completedLapDistance = 0
	self._lateralOffset = 0
	self._hasTrackState = false
	self._hasPlayerFinished = false
	self._postFinishElapsed = -1
	self._postFinishForward = nil
	self._lastReportedLap = 0
	self._forwardSpeed = 0
	self._countdownForwardSpeed = self:getBaseSpeed()
	self._buffHeightOffsets = {}
	self._itemFlightRemainingSec = 0
	self._itemFlightDurationSec = 0
	self._itemFlightHeight = 0
	self._currentBuffHeightOffset = 0
	self._buffHeightOffsetVelocity = 0
	self._jumpRemainingSec = 0
	self._jumpCooldownRemainingSec = 0
	self._airborneMotionActive = false
	self._landingReattachRemainingSec = 0
	self._shortcutJumpRemainingSec = 0

	self:clearBuffs()
	self:_resetVehicleBaseForRestart()

	self._invulnerabilityRemainingSec = 0
	self._invulnerabilityFlashEnabled = false
	self._perfectDodgeInvulnerabilityRemainingSec = 0

	self:_setInvulnerabilityRenderersVisible(true)

	self._currentEnergy = 0
	self._coinCount = 0
	self._perfectDodgeCombo = 0
	self._laneSwitchActive = false
	self._laneSwitchStartLateral = 0
	self._laneSwitchVisualDirection = 0
	self._laneSwitchCooldownRemainingSec = 0
	self._activeNormalShortcut = nil
	self._routeShortcutReturnPath = nil

	self:_clearAerialShortcutRoad3D()

	if self._mainTrackPath then
		self._trackPath = self._mainTrackPath
	end

	self:_resetRouteNetworkState(true)

	self._heldItem = nil
	self._backupItem = nil

	if self._trackPath and self._trackPath:getIsValid() then
		local transform = self._transform

		self._trackDistance = self._trackPath:getStartDistance()

		local defaultLaneIndex = 0
		local laneCount = self:_resolveLaneSwitchLaneCount()

		self._lateralOffset = self._trackPath:LaneToLateralOffset(defaultLaneIndex, laneCount)
		self._hasTrackState = true

		local startPose = self._trackPath:Sample(self._trackDistance, self._lateralOffset)
		local rideHeight = self._baseRideHeight
		local startX, startZ = startPose.position.x, startPose.position.y

		transformhelper.setPos(transform, startX, rideHeight, startZ)

		self._hasSmoothedTrackDisplayPosition = false

		SetVec3(self._smoothedTrackDisplayPosition, startX, rideHeight, startZ)
		SetVec3(self._trackDisplayPositionDampVelocity, 0, 0, 0)

		self._trackDisplaySmoothBlockRemainingSec = TrackDisplayPositionSmoothResumeDelaySec

		local startTangentX, startTangentZ = startPose.tangent.x, startPose.tangent.y
		local startTangentSqr = startTangentX * startTangentX + startTangentZ * startTangentZ
		local forwardX, forwardZ = 0, 0

		if startTangentSqr > 1e-10 then
			local inv = 1 / math.sqrt(startTangentSqr)

			forwardZ = startTangentZ * inv
			forwardX = startTangentX * inv

			transformhelper.setEulerAngles(transform, 0, math.deg(math.atan2(startTangentX * inv, startTangentZ * inv)), 0)
		end

		self._baseRideHeight = rideHeight

		SetVec3(self._stableTrackForward, FlatForwardXYZ(forwardX, forwardZ))
		SetVec3(self._smoothedVisualForward, FlatForwardXYZ(forwardX, forwardZ))
		SetVec3(self._cameraTrackForward, FlatForwardXYZ(forwardX, forwardZ))

		self._visualForwardDampVelX, self._visualForwardDampVelY, self._visualForwardDampVelZ = 0, 0, 0
	else
		local transform = self._transform
		local posX, posY, posZ = transformhelper.getPos(transform)

		self._baseRideHeight = posY

		local goForwardX, _, goForwardZ = transformhelper.getForward(transform)

		SetVec3(self._stableTrackForward, FlatForwardXYZ(goForwardX, goForwardZ))
		SetVec3(self._smoothedVisualForward, FlatForwardXYZ(goForwardX, goForwardZ))

		self._visualForwardDampVelX, self._visualForwardDampVelY, self._visualForwardDampVelZ = 0, 0, 0
		self._hasSmoothedTrackDisplayPosition = false

		SetVec3(self._smoothedTrackDisplayPosition, posX, posY, posZ)
		SetVec3(self._trackDisplayPositionDampVelocity, 0, 0, 0)

		self._trackDisplaySmoothBlockRemainingSec = TrackDisplayPositionSmoothResumeDelaySec
	end

	self._steeringInput = 0
	self._smoothedSteeringInput = 0
	self._steeringHoldDurationSec = 0
	self._steeringHoldDirection = 0
end

local function EqualsIgnoreCase(a, b)
	return a == b
end

local function EvaluateGlidePoint(glide, t)
	local exportedPoint = Glide.EvaluatePoint(glide, t)

	if exportedPoint then
		return exportedPoint
	end

	t = Mathf.Clamp01(t)

	local start = Vector3(glide.startX or 0, glide.startY or 0, glide.startZ or 0)
	local finish = Vector3(glide.endX or 0, glide.endY or 0, glide.endZ or 0)
	local point = Vector3.Lerp(start, finish, t)

	if EqualsIgnoreCase(glide.curveMode, LRRU.DolphinCurveModes.Smooth) then
		if math.abs(glide.arcStrength or 0) > 0.0001 then
			local flat = Vector3(finish.x - start.x, 0, finish.z - start.z)

			if flat.sqrMagnitude > 0.0001 then
				local right = Vector3.Cross(Vector3(0, 1, 0), flat.normalized)

				point = point + right * (math.sin(t * math.pi) * math.max(-1, math.min(1, (not glide.arcStrength or nil) and 0)) * flat.magnitude * 0.25)
			end
		end
	end

	local yT = t
	local descentEase = glide.descentEase

	if EqualsIgnoreCase(descentEase, LRRU.DolphinGlideDescentEases.EaseIn) then
		yT = t * t
	elseif EqualsIgnoreCase(descentEase, LRRU.DolphinGlideDescentEases.EaseOut) then
		yT = 1 - (1 - t) * (1 - t)
	end

	point.y = Mathf.Lerp(start.y, finish.y, yT)

	local landingApproach = Mathf.InverseLerp(0.82, 1, t)

	if landingApproach > 0 and landingApproach < 1 then
		point.y = point.y + math.sin(landingApproach * math.pi) * 1.2
	end

	return point
end

local function EstimateGlideLength(glide)
	if Glide.HasExportedPath(glide) then
		return Glide.ResolveLength(glide)
	end

	local curveLength = glide.curveLength

	if curveLength and curveLength > 0.001 then
		return curveLength
	end

	local samples = 32
	local length = 0
	local previous = EvaluateGlidePoint(glide, 0)

	for index = 1, samples do
		local current = EvaluateGlidePoint(glide, index / samples)

		length = length + Vector3.Distance(previous, current)
		previous = current
	end

	return math.max(0.01, length)
end

function PlayerVehicleController:_resetRouteNetworkState(isRestart)
	self._specialRaceDistanceFrozen = false
	self._specialRaceEntryTotalDistance = 0
	self._specialRaceEntryMainDistance = 0
	self._activeLayeredRoute = nil
	self._activeRouteShortcut = nil
	self._routeShortcutReturnPath = nil

	self:_clearAerialShortcutRoad3D()

	self._aerialShortcutExitFlightActive = false
	self._aerialShortcutExitFlightDurationSec = 0
	self._aerialShortcutExitFlightRemainingSec = 0
	self._aerialShortcutExitFlightArcHeight = 0
	self._aerialShortcutExitRecoverRoute = nil
	self._aerialShortcutExitRecoverPath = nil
	self._aerialShortcutExitCameraProfileId = 0
	self._aerialShortcutExitMainEquivalent = 0
	self._activeRouteMainBaseDistance = 0
	self._activeRouteLocalBaseDistance = 0
	self._routeTransferFlightRemainingSec = 0
	self._routeTransferFlightDurationSec = 0
	self._routeTransferFlightRollTotalDeg = 0
	self._routeTransferFlightHeight = 0
	self._routeTransferProjectionLockRemainingSec = 0
	self._routeTransferFlightStartPosition = Vector3(0, 0, 0)
	self._routeTransferFlightTargetPosition = Vector3(0, 0, 0)
	self._routeTransferUseAlignedCurve = false
	self._routeTransferFlightStartForward = Vector3(0, 0, 1)
	self._routeTransferFlightTargetForward = Vector3(0, 0, 1)
	self._routeTransferFlightSmoothedForward = Vector3(0, 0, 1)
	self._activeWaterDrop = nil
	self._waterDropRecoverRoute = nil
	self._waterDropRecoverPath = nil
	self._waterDropRemainingSec = 0
	self._waterDropElapsedSec = 0
	self._waterDropProgress = 0
	self._waterDropTapProgressPending = 0
	self._waterDropSpinSpeedDeg = 0
	self._waterDropSpinAngleDeg = 0
	self._waterDropFeedbackSpinSpeedDeg = 0
	self._waterDropFeedbackTier = 1
	self._waterDropStartPosition = Vector3(0, 0, 0)
	self._waterDropTargetPosition = Vector3(0, 0, 0)
	self._waterDropForward = Vector3(0, 0, 1)
	self._waterDropLandingBlendActive = false
	self._waterDropLandingBlendDurationSec = 0
	self._waterDropLandingBlendRemainingSec = 0
	self._waterDropLandingStartPosition = Vector3(0, 0, 0)
	self._waterDropLandingTargetPosition = Vector3(0, 0, 0)
	self._waterDropLandingStartForward = Vector3(0, 0, 1)
	self._waterDropLandingTargetForward = Vector3(0, 0, 1)
	self._waterDropLandingTargetDistance = 0
	self._waterDropLandingTargetLateral = 0
	self._waterDropLandingCameraProfileId = 0
	self._waterDropLandingBaseDistance = 0
	self._waterDropLandingElapsedSec = 0
	self._waterDropLandingResumeForwardSpeed = 0
	self._waterDropLandingRecoverSpeedMultiplier = 1
	self._activeUnderwaterRoute = nil
	self._underwaterRecoverRoute = nil
	self._underwaterRecoverPath = nil
	self._activeSnowSlopeRoute = nil
	self._snowSlopeRecoverRoute = nil
	self._snowSlopeRecoverPath = nil
	self._snowSlopeHeightBaseOffset = 0
	self._snowSlopeRoadFrames3D = nil
	self._snowSlopeRoadPose3D = nil
	self._snowSlopeSlideDirection = 0
	self._snowSlopeSlideVelocity = 0
	self._snowSlopeLandingBlendActive = false
	self._snowSlopeLandingBlendDurationSec = 0
	self._snowSlopeLandingBlendRemainingSec = 0
	self._snowSlopeLandingStartPosition = Vector3(0, 0, 0)
	self._snowSlopeLandingTargetPosition = Vector3(0, 0, 0)
	self._snowSlopeLandingStartForward = Vector3(0, 0, 1)
	self._snowSlopeLandingTargetForward = Vector3(0, 0, 1)
	self._snowSlopeLandingBaseDistance = 0
	self._snowSlopeLandingTargetDistance = 0
	self._snowSlopeLandingTargetLateral = 0
	self._snowSlopeLandingElapsedSec = 0
	self._snowSlopeLandingCameraProfileId = 0
	self._activeWaterfallClimbRoute = nil
	self._waterfallClimbRecoverRoute = nil
	self._waterfallClimbRecoverPath = nil
	self._waterfallClimbProgress = 0
	self._waterfallClimbLaneFloat = 0
	self._waterfallClimbTargetLaneFloat = 0
	self._waterfallClimbCameraAnchorPosition = Vector3(0, 0, 0)
	self._waterfallClimbCameraPositionOffset = Vector3(0, 0, 0)
	self._waterfallClimbCameraLookTargetPosition = Vector3(0, 0, 0)
	self._waterfallClimbEntryCurve = nil
	self._waterfallClimbEntryCurveProgress = 0
	self._waterfallClimbEntryJoinProgress = 0
	self._waterfallClimbEntryMainDistance = 0
	self._waterfallClimbTravelSpeed = 0
	self._waterfallClimbEntryOrientationBlendRemainingSec = 0
	self._waterfallClimbEntryStartRotation = self._transform.rotation

	CacheWaterfallEntryRotation(self, self._waterfallClimbEntryStartRotation)

	self._waterfallClimbExitFlightActive = false
	self._waterfallClimbExitFlightDurationSec = 0
	self._waterfallClimbExitFlightRemainingSec = 0
	self._waterfallClimbExitFlightStartPosition = Vector3(0, 0, 0)
	self._waterfallClimbExitFlightTargetPosition = Vector3(0, 0, 0)
	self._waterfallClimbExitFlightStartForward = Vector3(0, 0, 1)
	self._waterfallClimbExitFlightTargetForward = Vector3(0, 0, 1)
	self._waterfallClimbExitFlightCameraProfileId = 0
	self._waterfallClimbCameraExitBlendDurationSec = 0
	self._waterfallClimbCameraExitBlendRemainingSec = 0
	self._waterfallClimbExitCameraPositionOffset = Vector3(0, 0, 0)
	self._waterfallClimbExitCameraLookOffset = Vector3(0, 0, 0)
	self._waterfallClimbBackFacingExitCameraDelayActive = false
	self._waterfallClimbExitCameraFollowStartPosition = Vector3(0, 0, 0)
	self._activeGlideRoute = nil
	self._glideRecoverRoute = nil
	self._glideRecoverPath = nil
	self._glideEntryFlightRemainingSec = 0
	self._glideEntryFlightDurationSec = 0
	self._glideEntryFlightArcHeight = 0
	self._glideEntryFlightStartPosition = Vector3(0, 0, 0)
	self._glideEntryFlightTargetPosition = Vector3(0, 0, 0)
	self._glideEntryFlightStartForward = Vector3(0, 0, 1)
	self._glideEntryFlightTargetForward = Vector3(0, 0, 1)
	self._glideDistance = 0
	self._glideTravelSpeed = 0
	self._glideProgress = 0
	self._glideLateralOffset = 0
	self._glideTargetLateralOffset = 0
	self._glideAltitudeOffset = 0
	self._glideTargetAltitudeOffset = 0
	self._glideAltitudeBandIndex = 1
	self._glideVisualJitterSeed = 0
	self._glideCameraAnchorPosition = Vector3(0, 0, 0)
	self._glideLandingBlendActive = false
	self._glideLandingBlendRemainingSec = 0
	self._glideLandingBlendDurationSec = 0
	self._glideLandingStartPosition = Vector3(0, 0, 0)
	self._glideLandingTargetPosition = Vector3(0, 0, 0)
	self._glideLandingStartForward = Vector3(0, 0, 1)
	self._glideLandingTargetForward = Vector3(0, 0, 1)
	self._glideLandingCameraProfileId = 0
	self._glideLandingTargetDistance = 0
	self._glideLandingTargetLateral = 0
	self._glideLandingBaseDistance = 0
	self._glideLandingElapsedSec = 0
	self._previousGlideHorizontalInput = 0
	self._previousGlideVerticalInput = 0
	self._glideVerticalInput = 0
	self._specialRouteSmoothedForward = Vector3(0, 0, 1)
	self._specialRouteForwardDampVelocity = Vector3(0, 0, 0)

	if isRestart then
		self._trackPath = self._mainTrackPath
	end
end

function PlayerVehicleController:_resolveCurrentRaceDistance()
	return self._totalRaceDistance
end

function PlayerVehicleController:_resolveCurrentLapRaceDistance()
	if self._activeGlideRoute then
		local from = self._activeGlideRoute.fromDistance
		local to = self:_resolveForwardMainDistanceForGlide(from, self._activeGlideRoute.toDistance)

		return Mathf.Lerp(from, to, Mathf.Clamp01(self._glideProgress))
	end

	if self._activeWaterfallClimbRoute then
		local from = self._activeWaterfallClimbRoute.fromDistance
		local to = self:_resolveForwardMainDistanceForGlide(from, self._activeWaterfallClimbRoute.toDistance)

		if self._waterfallClimbEntryCurve then
			return Mathf.Lerp(self._waterfallClimbEntryMainDistance, from, Mathf.Clamp01(self._waterfallClimbEntryCurveProgress))
		end

		local joinProgress = Mathf.Clamp01(self._waterfallClimbEntryJoinProgress or 0)
		local climbProgress = Mathf.InverseLerp(joinProgress, 1, Mathf.Clamp01(self._waterfallClimbProgress))

		return Mathf.Lerp(from, to, climbProgress)
	end

	if self._activeUnderwaterRoute then
		local from = self._activeUnderwaterRoute.fromDistance
		local exit = self:_resolveFallbackUnderwaterExit(self._activeUnderwaterRoute)

		if exit then
			local to = self:_resolveForwardMainDistanceForGlide(from, exit.toDistance or self._activeUnderwaterRoute.toDistance)
			local t = Mathf.InverseLerp(self._trackPath:getStartDistance(), self._trackPath:getEndDistance(), self._trackDistance)

			return Mathf.Lerp(from, to, Mathf.Clamp01(t))
		end
	end

	if self._activeSnowSlopeRoute then
		local from = self._activeSnowSlopeRoute.fromDistance
		local to = self:_resolveForwardMainDistanceForGlide(from, self._activeSnowSlopeRoute.toDistance)
		local t = Mathf.InverseLerp(self._trackPath:getStartDistance(), self._trackPath:getEndDistance(), self._trackDistance)

		return Mathf.Lerp(from, to, Mathf.Clamp01(t))
	end

	if self._activeNormalShortcut then
		return NormalShortcutMapRaceDistance(self._activeNormalShortcut, self._trackDistance)
	end

	if not self._activeLayeredRoute then
		return self._trackDistance
	end

	if self._activeRouteShortcut == nil then
		if not self._trackDistance then
			local routeDistance = NormalShortcutMapRaceDistance(self._activeRouteShortcut, self._trackDistance)

			return LRRU.MapRouteDistance(self._activeLayeredRoute, routeDistance, self._activeRouteMainBaseDistance, self._activeRouteLocalBaseDistance)
		end
	end
end

function PlayerVehicleController:_beginSpecialRaceDistanceFreeze(entryMainDistance)
	if self._specialRaceDistanceFrozen then
		return
	end

	self._specialRaceDistanceFrozen = true
	self._specialRaceEntryTotalDistance = self._totalRaceDistance
	self._specialRaceEntryMainDistance = entryMainDistance or self:_resolveCurrentLapRaceDistance()
end

function PlayerVehicleController:isRaceDistanceFrozen()
	return self._specialRaceDistanceFrozen == true
end

function PlayerVehicleController:_hasActiveSpecialRaceDistanceState()
	local var_178_1

	if self._activeNormalShortcut == nil and self._activeLayeredRoute == nil and self._activeRouteShortcut == nil and self._activeWaterDrop == nil and self._activeUnderwaterRoute == nil and self._activeSnowSlopeRoute == nil and self._activeWaterfallClimbRoute == nil and self._activeGlideRoute == nil and self._aerialShortcutExitFlightActive ~= true and self._waterDropLandingBlendActive ~= true and self._snowSlopeLandingBlendActive ~= true and self._waterfallClimbExitFlightActive ~= true and self._glideLandingBlendActive ~= true then
		if (self._routeTransferFlightRemainingSec or 0) <= 0 then
			var_178_1 = false

			goto label_178_0
		end
	end

	::label_178_0::

	return true
end

function PlayerVehicleController:_tryCompleteSpecialRaceDistanceFreeze()
	if not self._specialRaceDistanceFrozen or self:_hasActiveSpecialRaceDistanceState() or not self._mainTrackPath or not self._mainTrackPath:getIsValid() or self._trackPath ~= self._mainTrackPath then
		return false
	end

	if not self._specialRaceEntryMainDistance then
		local entryMainDistance = self._trackDistance
		local exitMainDistance = self._trackDistance
		local forwardDistance = exitMainDistance - entryMainDistance
		local startDistance = self._mainTrackPath:getStartDistance()
		local endDistance = self._mainTrackPath:getEndDistance()
		local lapLength = endDistance - startDistance

		if forwardDistance < -0.01 and self._mainTrackPath:getIsLoop() and lapLength > 0.01 then
			forwardDistance = forwardDistance + lapLength
		end

		forwardDistance = math.max(0, forwardDistance)
		self._totalRaceDistance = self._specialRaceEntryTotalDistance + forwardDistance
		self._completedLapDistance = math.max(0, self._totalRaceDistance - exitMainDistance)
		self._specialRaceDistanceFrozen = false
		self._specialRaceEntryTotalDistance = 0
		self._specialRaceEntryMainDistance = 0

		return true
	end
end

function PlayerVehicleController:_resolveForwardMainDistanceForGlide(fromDistance, toDistance)
	local actual = toDistance
	local trackLength = self._runtimeConfig.path and self._runtimeConfig.path.centerline and self._mainTrackPath and self._mainTrackPath:getIsValid() and self._mainTrackPath:getEndDistance() or 0

	if trackLength <= 0.001 then
		return actual
	end

	local iterationCount = 0

	while actual < fromDistance do
		iterationCount = iterationCount + 1

		if iterationCount > 64 then
			logError(string.format("PlayerVehicleController:_resolveForwardMainDistanceForGlide exceeded iteration limit, from=%s to=%s trackLength=%s", tostring(fromDistance), tostring(toDistance), tostring(trackLength)))

			break
		end

		actual = actual + trackLength
	end

	return actual
end

function PlayerVehicleController:_canWrapMainTrackDistance()
	if self._activeLayeredRoute == nil and self._activeNormalShortcut == nil and self._activeRouteShortcut == nil and self._activeUnderwaterRoute == nil and self._activeSnowSlopeRoute == nil and self._mainTrackPath ~= nil and self._trackPath == self._mainTrackPath then
		if not self._runtimeConfig.path or not self._runtimeConfig.path.isLoop then
			local var_181_0 = false
		elseif self._runtimeConfig.level ~= nil then
			if (self._runtimeConfig.level.lapCount or 1) <= 1 then
				var_181_0 = false

				goto label_181_0
			end
		end
	end

	::label_181_0::

	return true
end

function PlayerVehicleController:_advanceTrackDistance(deltaDistance)
	if not self._trackPath or not self._trackPath:getIsValid() then
		return self._trackDistance
	end

	local nextDistance = self._trackDistance + deltaDistance

	if not self:_canWrapMainTrackDistance() then
		return Mathf.Clamp(nextDistance, self._trackPath:getStartDistance(), self._trackPath:getEndDistance())
	end

	local startDistance = self._mainTrackPath:getStartDistance()
	local endDistance = self._mainTrackPath:getEndDistance()
	local lapLength = endDistance - startDistance

	if lapLength <= 0.01 then
		return Mathf.Clamp(nextDistance, startDistance, endDistance)
	end

	local iterationCount = 0

	while endDistance <= nextDistance do
		iterationCount = iterationCount + 1

		if iterationCount > 64 then
			logError(string.format("PlayerVehicleController:_advanceTrackDistance exceeded iteration limit, next=%s start=%s end=%s delta=%s", tostring(nextDistance), tostring(startDistance), tostring(endDistance), tostring(deltaDistance)))

			break
		end

		nextDistance = startDistance + (nextDistance - endDistance)
		self._completedLapDistance = self._completedLapDistance + lapLength
	end

	return Mathf.Clamp(nextDistance, startDistance, endDistance)
end

function PlayerVehicleController:_accumulateRaceDistance()
	if not self._trackPath or not self._trackPath:getIsValid() then
		return
	end

	if self._specialRaceDistanceFrozen then
		return
	end

	self._totalRaceDistance = self._completedLapDistance + self._trackDistance
end

function PlayerVehicleController:_resolveCurrentRouteLaneId()
	local laneCount = self:_resolveLaneSwitchLaneCount()

	if self._laneSwitchActive then
		if not self._laneSwitchTargetLateral then
			local sourceLateral = self._lateralOffset
			local luaLaneIndex = self:_resolveNearestLaneIndex(sourceLateral)

			return LRRU.LuaIndexToCsLaneId(luaLaneIndex, laneCount)
		end
	end
end

function PlayerVehicleController:_mapLaneIdByRatio(sourceLaneId, sourceLaneCount, targetLaneCount, fallbackLaneId)
	sourceLaneCount = math.max(1, sourceLaneCount or 1)
	targetLaneCount = math.max(1, targetLaneCount or 1)

	local laneId = sourceLaneId and sourceLaneId > 0 and sourceLaneId or fallbackLaneId or 1
	local clampedSource = math.max(1, math.min(laneId, sourceLaneCount))
	local normalized = (clampedSource - 0.5) / sourceLaneCount

	return math.max(1, math.min(targetLaneCount, math.floor(normalized * targetLaneCount) + 1))
end

function PlayerVehicleController:_resolveEnvironmentSpeedMultiplier()
	if self._activeUnderwaterRoute then
		return math.max(0.01, self._activeUnderwaterRoute.speedMultiplier or 0.5)
	end

	if self._activeSnowSlopeRoute then
		return self:_resolveSnowSlopeSpeedMultiplier()
	end

	if self._activeWaterfallClimbRoute then
		return math.max(0.01, self._activeWaterfallClimbRoute.baseSpeedMultiplier or 0.75) * math.max(0.01, self._activeWaterfallClimbRoute.climbAccelerationMultiplier or 1.15)
	end

	return 1
end

function PlayerVehicleController:_resolveEnvironmentSteeringMultiplier()
	if self._activeUnderwaterRoute then
		return math.max(0.01, self._activeUnderwaterRoute.steeringMultiplier or 0.65)
	end

	return 1
end

function PlayerVehicleController:_resolveEnvironmentHeightOffset()
	if self._activeSnowSlopeRoute then
		return SnowSlope.ResolveRideHeightOffset(self._activeSnowSlopeRoute, self._trackPath, self._trackDistance, self._snowSlopeHeightBaseOffset, self._snowSlopeRoadFrames3D)
	end

	if not self._activeUnderwaterRoute then
		return 0
	end

	local t = self._trackPath and self._trackPath:getIsValid() and Mathf.InverseLerp(self._trackPath:getStartDistance(), self._trackPath:getEndDistance(), self._trackDistance) or 0

	if not self._activeUnderwaterRoute.startY then
		local startY = 0

		if not self._activeUnderwaterRoute.endY then
			local endY = 0

			if math.abs(startY) < 0.001 and math.abs(endY) < 0.001 then
				return self._activeUnderwaterRoute.depthOffset or 0
			end

			return Mathf.Lerp(startY, endY, Mathf.Clamp01(t))
		end
	end
end

function PlayerVehicleController:_resolveSnowSlopeSpeedMultiplier()
	return SnowSlope.ResolveSpeedMultiplier(self._activeSnowSlopeRoute, self._trackPath, self._trackDistance, self._snowSlopeRoadFrames3D)
end

function PlayerVehicleController:_resolveSnowSlopeHeight()
	return SnowSlope.SampleHeight(self._activeSnowSlopeRoute, self._trackPath, self._trackDistance, self._snowSlopeRoadFrames3D)
end

function PlayerVehicleController:_resolveSnowSlopeForwardForCurrentRoute(fallbackForward, pitchMultiplier)
	local fallback = fallbackForward or self:getStableForward()

	if not self._activeSnowSlopeRoute then
		return fallback
	end

	return SnowSlope.ResolveForward(self._activeSnowSlopeRoute, self._trackPath, self._trackDistance, self._lateralOffset, fallback, pitchMultiplier, self._futurePoseCache, self._poseCache, self._snowSlopeRoadFrames3D, _forwardCache)
end

function PlayerVehicleController:_resolveAerialShortcutForwardForCurrentRoute(fallbackForward)
	return AerialShortcut.Resolve3DForward(self._aerialShortcutRoadFrames3D, self._trackDistance, fallbackForward or self:getStableForward())
end

function PlayerVehicleController:_resolveAerialShortcutLookAheadForward(fallbackForward)
	return AerialShortcut.ResolveLookAheadForward(self._aerialShortcutRoadFrames3D, self._trackDistance, 25, 0.75, fallbackForward or self:getStableForward())
end

function PlayerVehicleController:resolveCurrentSpecialRoadBankDegrees()
	local aerialShortcut = self:_resolveActiveAerialShortcut()

	if aerialShortcut and self._aerialShortcutRoadFrames3D then
		return AerialShortcut.Resolve3DBankAngle(self._aerialShortcutRoadFrames3D, self._trackDistance)
	end

	if self._activeSnowSlopeRoute and self._snowSlopeRoadFrames3D then
		return SnowSlope.Resolve3DBankAngle(self._snowSlopeRoadFrames3D, self._trackDistance)
	end

	return 0
end

function PlayerVehicleController:resolveCurrentSnowSlopeBankDegrees()
	if not self._activeSnowSlopeRoute or not self._snowSlopeRoadFrames3D then
		return 0
	end

	return self:resolveCurrentSpecialRoadBankDegrees()
end

function PlayerVehicleController:_resolveCameraForwardForCurrentRoute(fallbackForward)
	if self._runtimeConfig.cameraFeel then
		local pitchMultiplier = Mathf.Clamp(self._runtimeConfig.cameraFeel.snowSlopeCameraPitchMultiplier or 2.4, 0.2, 6)

		return self:_resolveSnowSlopeForwardForCurrentRoute(fallbackForward, pitchMultiplier)
	end
end

function PlayerVehicleController:_shouldSkipTrackProjectionCorrection()
	if self:_isAirborneHandlingActive() then
		return true
	end

	if self._routeTransferProjectionLockRemainingSec > 0 then
		return true
	end

	if self._activeLayeredRoute or self._activeRouteShortcut or self._activeNormalShortcut or self._activeUnderwaterRoute or self._activeSnowSlopeRoute then
		return true
	end

	return false
end

function PlayerVehicleController:_resolveSpecialRouteForward(routeTangent, movementVelocity, deltaTime, velocityInfluenceScale, preserveVertical)
	local stableForward = self:getStableForward()
	local routeX, routeY, routeZ = stableForward.x, stableForward.y, stableForward.z

	if routeTangent and routeTangent.sqrMagnitude > 0.001 then
		if preserveVertical then
			local rx, ry, rz = routeTangent.x, routeTangent.y, routeTangent.z
			local inv = 1 / math.sqrt(rx * rx + ry * ry + rz * rz)

			routeZ = rz * inv
			routeY = ry * inv
			routeX = rx * inv
		else
			routeX, routeY, routeZ = FlatForwardXYZ(routeTangent.x, routeTangent.z)
		end
	end

	local desiredX, desiredY, desiredZ = routeX, routeY, routeZ

	if movementVelocity and movementVelocity.sqrMagnitude > 0.01 then
		local velocityX, velocityY, velocityZ

		if preserveVertical then
			local vx, vy, vz = movementVelocity.x, movementVelocity.y, movementVelocity.z
			local inv = 1 / math.sqrt(vx * vx + vy * vy + vz * vz)

			velocityZ = vz * inv
			velocityY = vy * inv
			velocityX = vx * inv
		else
			velocityX, velocityY, velocityZ = FlatForwardXYZ(movementVelocity.x, movementVelocity.z)
		end

		if routeX * velocityX + routeY * velocityY + routeZ * velocityZ > 0.05 then
			local influence = Mathf.Clamp01(self:_resolveSpecialRouteForwardVelocityInfluence() * math.max(0, velocityInfluenceScale or 1))

			desiredX, desiredY, desiredZ = SlerpUnitVec3(routeX, routeY, routeZ, velocityX, velocityY, velocityZ, influence)
		end
	end

	local smoothed = self._specialRouteSmoothedForward

	if not smoothed or smoothed.sqrMagnitude <= 0.001 then
		local stableTrack = self._stableTrackForward

		if not smoothed then
			smoothed = Vector3(0, 0, 1)
			self._specialRouteSmoothedForward = smoothed
		end

		if stableTrack and stableTrack.sqrMagnitude > 0.001 then
			SetVec3(smoothed, stableTrack.x, stableTrack.y, stableTrack.z)
		else
			SetVec3(smoothed, desiredX, desiredY, desiredZ)
		end
	end

	local smoothTime = self:_resolveSpecialRouteForwardSmoothTime()
	local dampVelocity = self._specialRouteForwardDampVelocity
	local safeDeltaTime = math.max(0, deltaTime)
	local newX, newVelX = Mathf.SmoothDamp(smoothed.x, desiredX, dampVelocity.x, smoothTime, math.huge, safeDeltaTime)
	local newY, newVelY = Mathf.SmoothDamp(smoothed.y, desiredY, dampVelocity.y, smoothTime, math.huge, safeDeltaTime)
	local newZ, newVelZ = Mathf.SmoothDamp(smoothed.z, desiredZ, dampVelocity.z, smoothTime, math.huge, safeDeltaTime)

	SetVec3(smoothed, newX, newY, newZ)
	SetVec3(dampVelocity, newVelX, newVelY, newVelZ)

	if preserveVertical then
		local sqr = newX * newX + newY * newY + newZ * newZ

		if sqr > 0.001 then
			local inv = 1 / math.sqrt(sqr)

			return SetVec3(_specialRouteForwardResult, newX * inv, newY * inv, newZ * inv)
		end
	end

	local flatX, flatY, flatZ = FlatForwardXYZ(newX, newZ)

	return SetVec3(_specialRouteForwardResult, flatX, flatY, flatZ)
end

function PlayerVehicleController:_resolveAirborneForwardAxisRoll(deltaTime)
	if self._controlConfig and self._controlConfig.airborneForwardRollDegreesPerSecond > 0 then
		if not self._controlConfig.airborneForwardRollDegreesPerSecond then
			local rollSpeed = 540

			self._airborneForwardRollAngleDeg = Mathf.Repeat((self._airborneForwardRollAngleDeg or 0) + rollSpeed * math.max(0, deltaTime), 360)

			return self._airborneForwardRollAngleDeg
		end
	end
end

function PlayerVehicleController:isSpecialTrackAirbornePresentationActive()
	if (self._routeTransferFlightRemainingSec or 0) <= 0 then
		local var_200_2

		if (self._shortcutJumpRemainingSec or 0) <= 0 then
			var_200_2 = self._aerialShortcutExitFlightActive or self._waterfallClimbExitFlightActive or self:_isGlideAirborneRollPresentationActive() or self._waterDropLandingBlendActive and (self._waterDropLandingBlendRemainingSec or 0) > 0
		end
	end

	return var_200_2
end

function PlayerVehicleController:_isGlideAirborneRollPresentationActive()
	if (self._glideEntryFlightRemainingSec or 0) > 0 then
		return true
	end

	if self._glideLandingBlendActive then
		return true
	end

	local glide = self._activeGlideRoute

	if not glide then
		return false
	end

	if glide.curveLength and glide.curveLength > 0 then
		local length = math.max(0.01, glide.curveLength or EstimateGlideLength(glide))

		return self:_resolveGlideLandingProgress(glide, length, self._glideDistance or 0) > 0
	end
end

function PlayerVehicleController:resolveSpecialTrackAirborneRollDegrees(deltaTime)
	if not self:isSpecialTrackAirbornePresentationActive() then
		return 0
	end

	if (self._routeTransferFlightRemainingSec or 0) > 0 then
		if (self._routeTransferFlightDurationSec or 0) > 0 then
			if (self._routeTransferFlightRollTotalDeg or 0) > 0 then
				local progress = Mathf.Clamp01(1 - self._routeTransferFlightRemainingSec / self._routeTransferFlightDurationSec)

				self._airborneForwardRollAngleDeg = Mathf.Repeat(self._routeTransferFlightRollTotalDeg * progress, 360)

				return self._airborneForwardRollAngleDeg
			end
		end
	end

	local glide = self._activeGlideRoute

	if glide then
		if glide.curveLength and glide.curveLength > 0 then
			do
				local landingProgress = self:_resolveGlideLandingProgress(glide, math.max(0.01, glide.curveLength or EstimateGlideLength(glide)), self._glideDistance or 0)

				if landingProgress > 0 then
					self._airborneForwardRollAngleDeg = Mathf.Repeat(GlideLandingFullRollDegrees * landingProgress, GlideLandingFullRollDegrees)

					return self._airborneForwardRollAngleDeg
				end
			end

			if self._glideLandingBlendActive then
				self._airborneForwardRollAngleDeg = 0

				return 0
			end
		end
	end

	return self:_resolveAirborneForwardAxisRoll(deltaTime)
end

function PlayerVehicleController:_resolveAirborneFlightProgress(t)
	t = Mathf.Clamp01(t)

	local elasticity = self._controlConfig and Mathf.Clamp01(self._controlConfig.airborneElasticity) or 1

	if elasticity <= 0.001 then
		return Mathf.SmoothStep(0, 1, t)
	end

	if t <= 0 or t >= 1 then
		return t
	end

	local expo = (1 - math.pow(2, -8 * t)) / (1 - math.pow(2, -8))
	local elasticOffset = math.sin(t * math.pi * 3) * math.pow(1 - t, 2) * 0.055

	return Mathf.Clamp01(Mathf.Lerp(Mathf.SmoothStep(0, 1, t), expo + elasticOffset, elasticity))
end

function PlayerVehicleController:_resolveSpecialRouteForwardSmoothTime()
	return Mathf.Clamp((self._runtimeConfig.cameraFeel or nil) and (self._runtimeConfig.cameraFeel.specialRouteForwardSmoothTime or 0.16), 0.04, 0.5)
end

function PlayerVehicleController:_resolveSpecialRouteForwardVelocityInfluence()
	return Mathf.Clamp01((self._runtimeConfig.cameraFeel or nil) and (self._runtimeConfig.cameraFeel.specialRouteForwardVelocityInfluence or 0.35))
end

function PlayerVehicleController:tryActivateAirWaterDrop(triggerElementId)
	if not self._trackPath or not self._trackPath:getIsValid() or self._activeNormalShortcut or self._activeRouteShortcut or self._activeUnderwaterRoute or self._activeSnowSlopeRoute or self:_isAirborneHandlingActive() then
		return false
	end

	if self._activeLayeredRoute then
		if not self._activeLayeredRoute.routeId then
			local fromRouteId = LRRU.DolphinRouteIds.Main
			local currentLaneId = self:_resolveCurrentRouteLaneId()
			local drop = LRRU.FindWaterDrop(self._runtimeConfig, fromRouteId, triggerElementId, self._trackDistance, currentLaneId, math.max(8, self._forwardSpeed * 0.35))

			if not drop then
				return false
			end

			local recoverPath, recoverRoute, targetPosition = self:_tryResolveRouteEndpoint(drop.recoverRouteId, drop.recoverDistance, drop.recoverLaneId)

			if not recoverPath then
				return false
			end

			self:_beginSpecialRaceDistanceFreeze()

			self._activeWaterDrop = drop
			self._waterDropRecoverRoute = recoverRoute
			self._waterDropRecoverPath = recoverPath

			local dropStartX, dropStartY, dropStartZ = transformhelper.getPos(self._transform)

			SetVec3(self._waterDropStartPosition, dropStartX, dropStartY, dropStartZ)
			SetVec3(self._waterDropTargetPosition, targetPosition.x, targetPosition.y, targetPosition.z)

			self._waterDropRemainingSec = WaterDrop.ResolveFallDurations(drop)
			self._waterDropElapsedSec = 0
			self._waterDropProgress = 0
			self._waterDropTapProgressPending = 0
			self._waterDropSpinSpeedDeg = self:_resolveWaterDropBaseSpinSpeed(drop)
			self._waterDropSpinAngleDeg = 0
			self._waterDropFeedbackSpinSpeedDeg = self._waterDropSpinSpeedDeg
			self._waterDropFeedbackTier = 1

			SetVec3(self._waterDropForward, self._waterDropTargetPosition.x - self._waterDropStartPosition.x, 0, self._waterDropTargetPosition.z - self._waterDropStartPosition.z)

			if self._waterDropForward.sqrMagnitude <= 0.001 then
				self._trackPath:SampleTo(self._trackDistance, self._lateralOffset, self._poseCache)

				local pose = self._poseCache

				SetVec3(self._waterDropForward, pose.tangent.x, 0, pose.tangent.y)
			end

			self._laneSwitchActive = false
			self._lateralVelocity = 0
			self._shortcutJumpDurationSec = 0
			self._shortcutJumpRemainingSec = 0
			self._shortcutJumpHeight = 0
			self._routeTransferFlightRemainingSec = 0
			self._jumpClearGraceRemainingSec = math.max(self._jumpClearGraceRemainingSec, self:_resolveJumpClearLandingGraceSec())
			self._landingReattachRemainingSec = 0
			self._waterDropLandingBlendActive = false
			self._waterDropLandingBlendRemainingSec = 0
			self._waterDropLandingCameraProfileId = 0
			self._airborneMotionActive = false
			self._hasTrackState = true

			V3a9RacingCarController.instance:dispatchEvent(V3a9RacingCarEvent.GuideWaterDrop)

			return true
		end
	end
end

function PlayerVehicleController:tryActivateGlide(triggerElementId)
	if not self._trackPath or not self._trackPath:getIsValid() or self._activeRouteShortcut or self._activeUnderwaterRoute or self._activeSnowSlopeRoute or self:_isAirborneHandlingActive() then
		return false
	end

	if self._activeNormalShortcut then
		local var_207_0 = self._activeNormalShortcut.shortcutId

		if not self._activeNormalShortcut.shortcutId then
			if self._activeLayeredRoute then
				var_207_0 = self._activeLayeredRoute.routeId

				if not self._activeLayeredRoute.routeId then
					local fromRouteId = LRRU.DolphinRouteIds.Main
					local currentLaneId = self:_resolveCurrentRouteLaneId()
					local glide = LRRU.FindGlide(self._runtimeConfig, fromRouteId, triggerElementId, self._trackDistance, currentLaneId, math.max(8, self._forwardSpeed * 0.35))

					if not glide then
						return false
					end

					return self:_beginGlide(glide, currentLaneId, self:_resolveLaneSwitchLaneCount())
				end
			end
		end
	end
end

function PlayerVehicleController:tryActivateUnderwaterRoute(triggerElementId)
	if not self._trackPath or not self._trackPath:getIsValid() or self._activeNormalShortcut or self._activeRouteShortcut or self:_isAirborneHandlingActive() or self._activeUnderwaterRoute or self._activeSnowSlopeRoute then
		return false
	end

	if self._activeLayeredRoute then
		if not self._activeLayeredRoute.routeId then
			local fromRouteId = LRRU.DolphinRouteIds.Main
			local currentLaneId = self:_resolveCurrentRouteLaneId()
			local sourceLaneCount = self:_resolveLaneSwitchLaneCount()
			local underwater = LRRU.FindUnderwaterRoute(self._runtimeConfig, fromRouteId, triggerElementId, self._trackDistance, currentLaneId, math.max(8, self._forwardSpeed * 0.35))

			if not underwater then
				return false
			end

			local underwaterPath = TrackPath.FromConfig(underwater.path)

			if not underwaterPath or not underwaterPath:getIsValid() then
				return false
			end

			local fallbackExit = self:_resolveFallbackUnderwaterExit(underwater)

			if not fallbackExit then
				return false
			end

			local recoverPath, recoverRoute = self:_tryResolveRouteEndpoint(fallbackExit.toRouteId, fallbackExit.toDistance, fallbackExit.toLaneId)

			if not recoverPath then
				return false
			end

			self:_beginSpecialRaceDistanceFreeze()

			self._activeUnderwaterRoute = underwater
			self._underwaterRecoverRoute = recoverRoute
			self._underwaterRecoverPath = recoverPath
			self._activeLayeredRoute = nil
			self._activeRouteShortcut = nil
			self._activeRouteMainBaseDistance = 0
			self._activeRouteLocalBaseDistance = 0
			self._trackPath = underwaterPath
			self._trackDistance = underwaterPath:getStartDistance()

			local laneCount = self:_resolveLaneSwitchLaneCount()
			local targetLaneId = self:_mapLaneIdByRatio(currentLaneId, sourceLaneCount, laneCount, underwater.fromLaneId)
			local laneIndex = LRRU.CsLaneIdToLuaIndex(targetLaneId, laneCount)

			self._lateralOffset = self._trackPath:LaneToLateralOffset(laneIndex, laneCount)
			self._laneSwitchTargetLateral = self._lateralOffset
			self._laneSwitchActive = false
			self._lateralVelocity = 0
			self._shortcutJumpDurationSec = 0
			self._shortcutJumpRemainingSec = 0
			self._routeTransferFlightRemainingSec = 0
			self._waterDropRemainingSec = 0
			self._activeWaterDrop = nil
			self._airborneMotionActive = false
			self._landingReattachRemainingSec = 0
			self._hasTrackState = true

			return true
		end
	end
end

function PlayerVehicleController:tryActivateUnderwaterExit(triggerElementId)
	if not self._activeUnderwaterRoute or not triggerElementId or triggerElementId == "" then
		return false
	end

	local exit = self:_resolveTriggeredUnderwaterExit(self._activeUnderwaterRoute, triggerElementId)

	if not exit then
		return false
	end

	self:_completeUnderwaterRoute(exit)

	return true
end

function PlayerVehicleController:tryActivateSnowSlopeRoute(triggerElementId)
	if not self._trackPath or not self._trackPath:getIsValid() or self._activeNormalShortcut or self._activeRouteShortcut or self:_isAirborneHandlingActive() or self._activeUnderwaterRoute or self._activeSnowSlopeRoute then
		return false
	end

	if self._activeLayeredRoute then
		if not self._activeLayeredRoute.routeId then
			local fromRouteId = LRRU.DolphinRouteIds.Main
			local currentLaneId = self:_resolveCurrentRouteLaneId()
			local sourceLaneCount = self:_resolveLaneSwitchLaneCount()
			local slope = LRRU.FindSnowSlopeRoute(self._runtimeConfig, fromRouteId, triggerElementId, self._trackDistance, currentLaneId, math.max(8, self._forwardSpeed * 0.35))

			if not slope then
				return false
			end

			local slopePath = TrackPath.FromConfig(SnowSlope.ResolveTrackPathConfig(slope))

			if not slopePath or not slopePath:getIsValid() then
				return false
			end

			local recoverPath, recoverRoute = self:_tryResolveRouteEndpoint(slope.toRouteId, slope.toDistance, slope.toLaneId)

			if not recoverPath then
				return false
			end

			local snowSlopeRoadFrames3D = SnowSlope.Build3DRoadFrames(slope)
			local snowSlopeEntryHeight = SnowSlope.ResolveEntryHeight(slope, slopePath)
			local snowSlopeHeightBaseOffset = 0

			if self._activeLayeredRoute and not snowSlopeRoadFrames3D then
				snowSlopeHeightBaseOffset = self:_resolveRideHeight() - self._baseRideHeight - snowSlopeEntryHeight
			end

			self:_beginSpecialRaceDistanceFreeze()

			self._activeSnowSlopeRoute = slope
			self._snowSlopeRecoverRoute = recoverRoute
			self._snowSlopeRecoverPath = recoverPath
			self._snowSlopeHeightBaseOffset = snowSlopeHeightBaseOffset
			self._snowSlopeRoadFrames3D = snowSlopeRoadFrames3D
			self._snowSlopeRoadPose3D = nil
			self._snowSlopeSlideDirection = 0
			self._snowSlopeSlideVelocity = 0
			self._activeLayeredRoute = nil
			self._activeRouteShortcut = nil
			self._activeRouteMainBaseDistance = 0
			self._activeRouteLocalBaseDistance = 0
			self._trackPath = slopePath
			self._trackDistance = slopePath:getStartDistance()

			local laneCount = self:_resolveLaneSwitchLaneCount()
			local targetLaneId = self:_mapLaneIdByRatio(currentLaneId, sourceLaneCount, laneCount, slope.fromLaneId)
			local laneIndex = LRRU.CsLaneIdToLuaIndex(targetLaneId, laneCount)

			self._lateralOffset = self._trackPath:LaneToLateralOffset(laneIndex, laneCount)
			self._laneSwitchTargetLateral = self._lateralOffset
			self._laneSwitchActive = false
			self._lateralVelocity = 0
			self._shortcutJumpDurationSec = 0
			self._shortcutJumpRemainingSec = 0
			self._routeTransferFlightRemainingSec = 0
			self._waterDropRemainingSec = 0
			self._activeWaterDrop = nil
			self._airborneMotionActive = false
			self._landingReattachRemainingSec = 0
			self._hasTrackState = true

			V3a9RacingCarController.instance:dispatchEvent(V3a9RacingCarEvent.GuideSnow)

			return true
		end
	end
end

function PlayerVehicleController:tryActivateWaterfallClimbRoute(triggerElementId)
	if not self._trackPath or not self._trackPath:getIsValid() or self._activeNormalShortcut or self._activeRouteShortcut or self:_isAirborneHandlingActive() or self._activeUnderwaterRoute or self._activeSnowSlopeRoute or self._activeWaterfallClimbRoute then
		return false
	end

	if self._activeLayeredRoute then
		if not self._activeLayeredRoute.routeId then
			local fromRouteId = LRRU.DolphinRouteIds.Main
			local currentLaneId = self:_resolveCurrentRouteLaneId()
			local climb = LRRU.FindWaterfallClimbRoute(self._runtimeConfig, fromRouteId, triggerElementId, self._trackDistance, currentLaneId, math.max(8, self._forwardSpeed * 0.35))

			if not climb then
				return false
			end

			local recoverPath, recoverRoute = self:_tryResolveRouteEndpoint(climb.toRouteId, climb.toDistance, climb.toLaneId)

			if not recoverPath then
				return false
			end

			self:_beginSpecialRaceDistanceFreeze()

			self._activeWaterfallClimbRoute = climb
			self._airborneForwardRollAngleDeg = 0
			self._waterfallClimbRecoverRoute = recoverRoute
			self._waterfallClimbRecoverPath = recoverPath

			local entryForward = self:getStableForward()

			self._specialRouteSmoothedForward = entryForward
			self._specialRouteForwardDampVelocity = Vector3(0, 0, 0)
			self._waterfallClimbProgress = 0
			self._waterfallClimbEntryMainDistance = self._trackDistance
			self._waterfallClimbEntryStartRotation = self._transform.rotation

			CacheWaterfallEntryRotation(self, self._waterfallClimbEntryStartRotation)

			self._waterfallClimbLaneFloat = WaterfallClimb.ResolveFixedLaneFloat(climb, entryForward.x, entryForward.z)
			self._waterfallClimbTargetLaneFloat = self._waterfallClimbLaneFloat

			local climbLength = math.max(0.01, climb.climbLength or 0.01)
			local joinDistance = WaterfallClimb.ResolveEntryJoinDistance(climb)

			self._waterfallClimbEntryJoinProgress = Mathf.Clamp01(joinDistance / climbLength)

			local entryTargetPosition, entryTargetTangent = self:_evaluateWaterfallClimbPoint(self._waterfallClimbEntryJoinProgress, self._waterfallClimbLaneFloat)
			local entryTargetRadialX = entryTargetPosition.x - ((not climb.centerX or nil) and 0)
			local entryTargetRadialZ = entryTargetPosition.z - ((not climb.centerZ or nil) and 0)
			local posPosX, posPosY, posPosZ = transformhelper.getPos(self._transform)
			local upX, upY, upZ = transformhelper.getUp(self._transform)

			SetVec3(_basePosCache, entryTargetRadialX, 0, entryTargetRadialZ)

			self._waterfallClimbEntryCurve = WaterfallClimb.BuildEntryCurve(climb, Vector3(posPosX, posPosY, posPosZ), self:getStableForward(), Vector3(upX, upY, upZ), entryTargetPosition, entryTargetTangent, _basePosCache)
			self._waterfallClimbEntryCurveProgress = 0
			self._waterfallClimbEntryOrientationBlendRemainingSec = self._waterfallClimbEntryCurve and 0 or WaterfallClimbEntryOrientationBlendSec
			self._previousGlideHorizontalInput = 0
			self._activeLayeredRoute = nil
			self._activeRouteShortcut = nil
			self._activeRouteMainBaseDistance = 0
			self._activeRouteLocalBaseDistance = 0
			self._shortcutJumpDurationSec = 0
			self._shortcutJumpRemainingSec = 0
			self._routeTransferFlightRemainingSec = 0
			self._waterDropRemainingSec = 0
			self._activeWaterDrop = nil
			self._airborneMotionActive = false
			self._landingReattachRemainingSec = 0
			self._glideLandingBlendActive = false
			self._glideLandingBlendRemainingSec = 0
			self._glideLandingCameraProfileId = 0
			self._waterfallClimbExitFlightActive = false
			self._waterfallClimbExitFlightRemainingSec = 0
			self._waterfallClimbExitFlightCameraProfileId = 0
			self._waterfallClimbCameraExitBlendDurationSec = 0
			self._waterfallClimbCameraExitBlendRemainingSec = 0
			self._waterfallClimbExitCameraPositionOffset = Vector3(0, 0, 0)
			self._waterfallClimbExitCameraLookOffset = Vector3(0, 0, 0)
			self._forwardSpeed = WaterfallClimb.ResolveEntryForwardSpeed(self._forwardSpeed, self:getBaseSpeed(), climb)
			self._waterfallClimbTravelSpeed = self._forwardSpeed
			self._hasTrackState = true

			self:_moveWaterfallClimb(0)

			return true
		end
	end
end

function PlayerVehicleController:_tryResolveRouteEndpoint(routeId, distance, laneId)
	local route
	local endpointPath = self._mainTrackPath

	if routeId and routeId ~= "" and not EqualsIgnoreCase(routeId, LRRU.DolphinRouteIds.Main) then
		route = LRRU.FindRoute(self._runtimeConfig, routeId)

		if not route then
			return nil, nil, nil
		end

		endpointPath = TrackPath.FromConfig(route.path)
	end

	if not endpointPath or not endpointPath:getIsValid() then
		return nil, nil, nil
	end

	local endpointDistance = Mathf.Clamp(distance, endpointPath:getStartDistance(), endpointPath:getEndDistance())

	if route then
		local var_212_1 = math.max(1, route.laneCount or 1)

		if not var_212_1 then
			var_212_1 = self:_resolveLaneSwitchLaneCount()

			local laneCount = var_212_1
			local laneIndex = LRRU.CsLaneIdToLuaIndex(laneId, laneCount)
			local endpointLateral = endpointPath:LaneToLateralOffset(laneIndex, laneCount)
			local pose = endpointPath:Sample(endpointDistance, endpointLateral)
			local height = self._baseRideHeight + ((route or nil) and (route.height or 0)) + self:_resolveItemFlightOffset()
			local targetPosition = Vector3(pose.position.x, height, pose.position.y)

			return endpointPath, route, targetPosition
		end
	end
end

local function GlideLaneToOffset(laneIndex, laneCount, laneWidth)
	laneCount = math.max(1, laneCount or 1)

	local center = (laneCount - 1) * 0.5

	return (laneIndex - center) * (laneWidth or 0)
end

local function ResolveNearestGlideLane(lateralOffset, laneCount, laneWidth)
	laneCount = math.max(1, laneCount or 1)

	local center = (laneCount - 1) * 0.5
	local w = laneWidth or 1

	if w <= 0 then
		w = 1
	end

	return math.max(0, math.min(laneCount - 1, math.floor(lateralOffset / w + center + 0.5)))
end

local function ResolveGlideAltitudeOffset(bandIndex, glide)
	bandIndex = bandIndex or 1

	if bandIndex <= 0 then
		return glide.lowAltitudeOffset or 0
	elseif bandIndex >= 2 then
		return glide.highAltitudeOffset or 0
	end

	return glide.midAltitudeOffset or 0
end

local function BindGlideEndpointToRoute(glide, targetPosition)
	if not glide or not targetPosition then
		return
	end

	local approachY = math.max(targetPosition.y, glide.endY or 0)
	local approachY

	if Glide.BindEndpoint(glide, targetPosition) then
		approachY = glide.curveLength <= 0.001 and 0 or math.max(0, (glide.startY or 0) - (glide.endY or 0)) / glide.curveLength
		glide.descentRate = approachY

		return
	end

	glide.endX = targetPosition.x
	glide.endY = approachY
	glide.endZ = targetPosition.z
	glide.curveLength = EstimateGlideLength(glide)
	glide.descentRate = glide.curveLength <= 0.001 and 0 or math.max(0, (glide.startY or 0) - (glide.endY or 0)) / glide.curveLength
end

local function EvaluateGlideTangent(glide, t)
	local tx, ty, tz = Glide.EvaluateTangentXYZ(glide, t)

	if tx then
		return Vector3(tx, ty, tz)
	end

	local eps = 0.005
	local p0 = EvaluateGlidePoint(glide, math.max(0, t - eps))
	local p1 = EvaluateGlidePoint(glide, math.min(1, t + eps))
	local tangent = p1 - p0

	if tangent.sqrMagnitude <= 0.0001 then
		tangent = Vector3(0, 0, 1)
	end

	return tangent.normalized
end

function PlayerVehicleController:_resolveGlideVisualForward(glide, length, distance)
	length = math.max(0.01, length or 0)

	local sampleRadius = math.min(TrackVisualPoseSampleRadius, length * 0.25)
	local beforeDistance = math.max(0, (distance or 0) - sampleRadius)
	local afterDistance = math.min(length, (distance or 0) + sampleRadius)
	local bx, by, bz = Glide.EvaluatePointXYZ(glide, beforeDistance / length)
	local ax, ay, az = Glide.EvaluatePointXYZ(glide, afterDistance / length)
	local currentX, currentY, currentZ

	if bx then
		local dx, dy, dz = ax - bx, ay - by, az - bz
		local sqr = dx * dx + dy * dy + dz * dz

		if sqr > 0.0001 then
			local inv = 1 / math.sqrt(sqr)

			currentZ = dz * inv
			currentY = dy * inv
			currentX = dx * inv
		end
	end

	if not currentX then
		local beforePoint = EvaluateGlidePoint(glide, beforeDistance / length)
		local afterPoint = EvaluateGlidePoint(glide, afterDistance / length)
		local dx, dy, dz = afterPoint.x - beforePoint.x, afterPoint.y - beforePoint.y, afterPoint.z - beforePoint.z
		local sqr = dx * dx + dy * dy + dz * dz

		if sqr > 0.0001 then
			local inv = 1 / math.sqrt(sqr)

			currentZ = dz * inv
			currentY = dy * inv
			currentX = dx * inv
		else
			local fallbackTangent = EvaluateGlideTangent(glide, Mathf.Clamp01((distance or 0) / length))

			currentZ = fallbackTangent.z
			currentY = fallbackTangent.y
			currentX = fallbackTangent.x
		end
	end

	local previewDistance = ResolveGlideFacingPreviewDistance(length, distance)
	local previewBeforeT = math.max(0, previewDistance - sampleRadius) / length
	local previewAfterT = math.min(length, previewDistance + sampleRadius) / length
	local pbx, pby, pbz = Glide.EvaluatePointXYZ(glide, previewBeforeT)
	local pax, pay, paz = Glide.EvaluatePointXYZ(glide, previewAfterT)
	local previewX, previewY, previewZ

	if pbx then
		local dx, dy, dz = pax - pbx, pay - pby, paz - pbz
		local sqr = dx * dx + dy * dy + dz * dz

		if sqr > 0.0001 then
			local inv = 1 / math.sqrt(sqr)

			previewZ = dz * inv
			previewY = dy * inv
			previewX = dx * inv
		end
	end

	if not previewX then
		local previewBeforePoint = EvaluateGlidePoint(glide, previewBeforeT)
		local previewAfterPoint = EvaluateGlidePoint(glide, previewAfterT)
		local dx, dy, dz = previewAfterPoint.x - previewBeforePoint.x, previewAfterPoint.y - previewBeforePoint.y, previewAfterPoint.z - previewBeforePoint.z
		local sqr = dx * dx + dy * dy + dz * dz

		if sqr > 0.0001 then
			local inv = 1 / math.sqrt(sqr)

			previewZ = dz * inv
			previewY = dy * inv
			previewX = dx * inv
		else
			previewZ = currentZ
			previewY = currentY
			previewX = currentX
		end
	end

	return SetVec3(_glideVisualForwardResult, SlerpUnitVec3(currentX, currentY, currentZ, previewX, previewY, previewZ, GlideFacingPreviewWeight))
end

function PlayerVehicleController:_resolveGlideFacingForward(routeForward, movementVelocity)
	local desiredX, desiredY, desiredZ

	if routeForward and routeForward.sqrMagnitude > 0.0001 then
		local rx, ry, rz = routeForward.x, routeForward.y, routeForward.z
		local inv = 1 / math.sqrt(rx * rx + ry * ry + rz * rz)

		desiredZ = rz * inv
		desiredY = ry * inv
		desiredX = rx * inv
	else
		local camForward = self._cameraTrackForward

		desiredZ = camForward.z
		desiredY = camForward.y
		desiredX = camForward.x
	end

	local followRate = GlideRotationFollowRate

	if not movementVelocity or movementVelocity.sqrMagnitude <= 0.01 then
		return SetVec3(_glideFacingResult, desiredX, desiredY, desiredZ), followRate
	end

	local vx, vy, vz = movementVelocity.x, movementVelocity.y, movementVelocity.z
	local vInv = 1 / math.sqrt(vx * vx + vy * vy + vz * vz)
	local movementX, movementY, movementZ = vx * vInv, vy * vInv, vz * vInv
	local dot = Mathf.Clamp(desiredX * movementX + desiredY * movementY + desiredZ * movementZ, -1, 1)
	local angleDegrees = math.deg(math.acos(dot))
	local velocityInfluence

	velocityInfluence, followRate = ResolveGlideFacingResponse(angleDegrees, self:_resolveSpecialRouteForwardVelocityInfluence(), GlideRotationFollowRate)

	if velocityInfluence > 0.0001 then
		desiredX, desiredY, desiredZ = SlerpUnitVec3(desiredX, desiredY, desiredZ, movementX, movementY, movementZ, velocityInfluence)
	end

	return SetVec3(_glideFacingResult, desiredX, desiredY, desiredZ), followRate
end

function PlayerVehicleController:_tryEnterGlideShortcutExit(currentLane, laneCount, input)
	if self._activeLayeredRoute then
		if not self._activeLayeredRoute.routeId then
			local currentRouteId = LRRU.DolphinRouteIds.Main

			for _, glide in ipairs(self._glideRoutes) do
				local valid = glide and glide.enabled ~= false and EqualsIgnoreCase(glide.entryMode, LRRU.DolphinGlideEntryModes.ShortcutExit) and EqualsIgnoreCase(glide.fromRouteId, currentRouteId)

				if valid then
					local isLeft = EqualsIgnoreCase(glide.entryDirection, ShortcutSideLeft)
					local requiredLane = isLeft and 0 or laneCount - 1
					local inputMatches = isLeft and input > 0 or input < 0

					valid = currentLane == requiredLane and inputMatches
				end

				if valid then
					local halfWindow = math.max(0.01, (not glide.entryTriggerLength or nil) and 0) * 0.5

					valid = halfWindow >= math.abs(self._trackDistance - (glide.fromDistance or 0))
				end

				if valid then
					return self:_beginGlide(glide, LRRU.LuaIndexToCsLaneId(currentLane, laneCount), laneCount)
				end
			end

			return false
		end
	end
end

function PlayerVehicleController:_tryEnterRouteShortcut(currentLane, mainLaneCount, input)
	if not self._activeLayeredRoute then
		return false
	end

	local localDistance = self._trackPath:WrapDistance(self._trackDistance)

	if not self._activeLayeredRoute.normalShortcuts then
		for _, shortcut in ipairs(self._activeLayeredRoute.normalShortcuts) do
			if NormalShortcutCanEnter(shortcut, localDistance, currentLane, mainLaneCount, input) then
				local shortcutPath = TrackPath.FromConfig(shortcut.path)

				if shortcutPath:getIsValid() then
					self:_beginSpecialRaceDistanceFreeze()

					self._routeShortcutReturnPath = self._trackPath

					self:_beginAerialShortcutRoad3D(shortcut)

					self._activeRouteShortcut = shortcut
					self._trackPath = shortcutPath
					self._trackDistance = shortcutPath:getStartDistance()

					local entryLane = NormalShortcutResolveEntryLaneIndex(shortcut.side, shortcut.laneCount)
					local scLaneCount = math.max(1, (not shortcut.laneCount or nil) and 1)

					if shortcut.isAerialShortcut == true then
						local entryMainLaneId = LRRU.LuaIndexToCsLaneId(currentLane, mainLaneCount)
						local shortcutLaneId = AerialShortcut.ResolveEntryShortcutLaneId(shortcut, entryMainLaneId)

						entryLane = LRRU.CsLaneIdToLuaIndex(shortcutLaneId, scLaneCount)
					end

					self._lateralOffset = shortcutPath:LaneToLateralOffset(entryLane, scLaneCount)
					self._laneSwitchTargetLateral = self._lateralOffset
					self._laneSwitchActive = false
					self._lateralVelocity = 0
					self._laneSwitchCooldownRemainingSec = self:_resolveLaneSwitchCooldownSec()
					self._hasTrackState = true

					return true
				end
			end
		end

		return false
	end
end

function PlayerVehicleController:_completeRouteShortcut()
	local completed = self._activeRouteShortcut

	if not completed then
		return
	end

	self._activeRouteShortcut = nil

	self:_clearAerialShortcutRoad3D()

	self._trackPath = self._routeShortcutReturnPath or self._mainTrackPath
	self._routeShortcutReturnPath = nil
	self._trackDistance = Mathf.Clamp(completed.exitMainDistance, self._trackPath:getStartDistance(), self._trackPath:getEndDistance())

	local laneCount = self:_resolveLaneSwitchLaneCount()
	local luaLaneIndex = LRRU.CsLaneIdToLuaIndex(completed.exitMainLaneId or 1, laneCount)

	self._lateralOffset = self._trackPath:LaneToLateralOffset(luaLaneIndex, laneCount)
	self._laneSwitchTargetLateral = self._lateralOffset
	self._laneSwitchActive = false
	self._lateralVelocity = 0
	self._laneSwitchCooldownRemainingSec = self:_resolveLaneSwitchCooldownSec()
	self._hasTrackState = true
end

function PlayerVehicleController:_beginAerialShortcutExitFlight(glide, shortcut, currentLaneId, sourceLaneCount)
	if not glide or not shortcut then
		return false
	end

	local recoverPath, recoverRoute = self:_tryResolveRouteEndpoint(glide.toRouteId, glide.toDistance, glide.toLaneId)

	if not recoverPath then
		return false
	end

	if recoverRoute then
		local var_224_1 = math.max(1, recoverRoute.laneCount or 1)

		if not var_224_1 then
			var_224_1 = math.max(1, (self._controlConfig or nil) and (self._controlConfig.laneSwitchLaneCount or 4))

			local targetLaneCount = var_224_1
			local targetLaneId = AerialShortcut.MapLaneIdOneToOne(currentLaneId, glide.fromLaneId, glide.toLaneId, targetLaneCount)
			local resolvedPath, resolvedRoute, targetPosition = self:_tryResolveRouteEndpoint(glide.toRouteId, glide.toDistance, targetLaneId)

			if not resolvedPath or not targetPosition then
				return false
			end

			local targetDistance = Mathf.Clamp(glide.toDistance or 0, resolvedPath:getStartDistance(), resolvedPath:getEndDistance())
			local targetLaneIndex = LRRU.CsLaneIdToLuaIndex(targetLaneId, targetLaneCount)
			local targetLateral = resolvedPath:LaneToLateralOffset(targetLaneIndex, targetLaneCount)
			local targetPose = resolvedPath:Sample(targetDistance, targetLateral)
			local targetHeight = self._baseRideHeight + ((resolvedRoute or nil) and (resolvedRoute.height or 0)) + self:_resolveItemFlightOffset()

			targetPosition = Vector3(targetPose.position.x, targetHeight, targetPose.position.y)

			local targetForward = Vector3(targetPose.tangent.x, 0, targetPose.tangent.y)

			targetForward = targetForward.sqrMagnitude > 0.001 and targetForward.normalized or self:getStableForward()

			local transform = self._transform
			local flightStartX, flightStartY, flightStartZ = transformhelper.getPos(transform)

			SetVec3(self._aerialShortcutExitFlightStartPosition, flightStartX, flightStartY, flightStartZ)
			SetVec3(self._aerialShortcutExitFlightTargetPosition, targetPosition.x, targetPosition.y, targetPosition.z)

			local exitStableForward = self:getStableForward()

			SetVec3(self._aerialShortcutExitFlightStartForward, exitStableForward.x, exitStableForward.y, exitStableForward.z)
			SetVec3(self._aerialShortcutExitFlightTargetForward, targetForward.x, targetForward.y, targetForward.z)

			self._aerialShortcutExitFlightDurationSec = AerialShortcut.ResolveExitFlightDuration(self._aerialShortcutExitFlightStartPosition, targetPosition)
			self._aerialShortcutExitFlightRemainingSec = self._aerialShortcutExitFlightDurationSec
			self._aerialShortcutExitFlightArcHeight = AerialShortcut.ResolveExitFlightArcHeight(self._aerialShortcutExitFlightStartPosition, targetPosition)
			self._aerialShortcutExitRecoverPath = resolvedPath
			self._aerialShortcutExitRecoverRoute = resolvedRoute
			self._aerialShortcutExitTargetDistance = targetDistance
			self._aerialShortcutExitTargetLaneId = targetLaneId
			self._aerialShortcutExitCameraProfileId = AerialShortcut.ResolveCameraProfileId(shortcut)
			self._aerialShortcutExitMainEquivalent = self:_resolveCurrentLapRaceDistance()
			self._aerialShortcutExitFlightActive = true

			self:beginJumpPadApproachVisualHandoff()

			self._activeNormalShortcut = nil
			self._activeRouteShortcut = nil
			self._routeShortcutReturnPath = nil

			self:_clearAerialShortcutRoad3D()

			self._laneSwitchActive = false
			self._lateralVelocity = 0
			self._airborneForwardRollAngleDeg = 0
			self._jumpClearGraceRemainingSec = math.max(self._jumpClearGraceRemainingSec, self:_resolveJumpClearLandingGraceSec())
			self._landingReattachRemainingSec = 0
			self._hasTrackState = true

			return true
		end
	end
end

function PlayerVehicleController:isAerialShortcutExitFlightActive()
	return self._aerialShortcutExitFlightActive == true
end

function PlayerVehicleController:getAerialShortcutExitFlightProgress()
	local duration = math.max(0.0001, (not self._aerialShortcutExitFlightDurationSec or nil) and 0)

	return Mathf.Clamp01(1 - (self._aerialShortcutExitFlightRemainingSec or 0) / duration)
end

function PlayerVehicleController:_moveAerialShortcutExitFlight(deltaTime, damping)
	if not self._aerialShortcutExitFlightActive then
		return
	end

	local duration = math.max(0.001, self._aerialShortcutExitFlightDurationSec)

	self._aerialShortcutExitFlightRemainingSec = math.max(0, self._aerialShortcutExitFlightRemainingSec - deltaTime)

	local t = Mathf.Clamp01(1 - self._aerialShortcutExitFlightRemainingSec / duration)
	local horizontalProgress = self:_resolveShortcutJumpHorizontalProgress(t)
	local startPosition = self._aerialShortcutExitFlightStartPosition
	local targetPosition = self._aerialShortcutExitFlightTargetPosition
	local arcOffset = math.sin(t * math.pi) * math.max(0, self._aerialShortcutExitFlightArcHeight)
	local nextX = startPosition.x + (targetPosition.x - startPosition.x) * horizontalProgress
	local nextY = startPosition.y + (targetPosition.y - startPosition.y) * horizontalProgress + arcOffset
	local nextZ = startPosition.z + (targetPosition.z - startPosition.z) * horizontalProgress
	local transform = self._transform
	local prevX, prevY, prevZ = transformhelper.getPos(transform)

	transformhelper.setPos(transform, nextX, nextY, nextZ)

	local horizontalVelocity = self:_resolveHorizontalVelocity(prevX, prevZ, nextX, nextZ, deltaTime)

	self:_updateEstimatedHorizontalVelocity(prevX, prevZ, nextX, nextZ, deltaTime)

	local startForward = self._aerialShortcutExitFlightStartForward
	local targetForward = self._aerialShortcutExitFlightTargetForward
	local desiredX, desiredY, desiredZ = SlerpUnitVec3(startForward.x, startForward.y, startForward.z, targetForward.x, targetForward.y, targetForward.z, horizontalProgress)

	self:_updateVehicleOrientation(SetVec3(_forwardCache, desiredX, desiredY, desiredZ), horizontalVelocity, damping, deltaTime)

	if desiredX * desiredX + desiredY * desiredY + desiredZ * desiredZ > 0.001 then
		SetVec3(self._cameraTrackForward, desiredX, desiredY, desiredZ)
	else
		local fallbackForward = self:getStableForward()

		SetVec3(self._cameraTrackForward, fallbackForward.x, fallbackForward.y, fallbackForward.z)
	end

	if self._aerialShortcutExitFlightRemainingSec <= 0 then
		self:_completeAerialShortcutExitFlight()
	end
end

function PlayerVehicleController:_completeAerialShortcutExitFlight()
	local recoverPath = self._aerialShortcutExitRecoverPath

	if not recoverPath or not recoverPath:getIsValid() then
		self._aerialShortcutExitFlightActive = false

		return
	end

	local transform = self._transform

	self._activeLayeredRoute = self._aerialShortcutExitRecoverRoute

	if self._activeLayeredRoute == nil then
		self._activeRouteMainBaseDistance = 0
		self._activeRouteLocalBaseDistance = 0
		self._trackPath = self._mainTrackPath
	else
		self._activeRouteMainBaseDistance = self._aerialShortcutExitMainEquivalent
		self._activeRouteLocalBaseDistance = self._aerialShortcutExitTargetDistance
		self._trackPath = recoverPath
	end

	self._trackDistance = self._aerialShortcutExitTargetDistance

	local laneCount = self:_resolveLaneSwitchLaneCount()
	local laneIndex = LRRU.CsLaneIdToLuaIndex(self._aerialShortcutExitTargetLaneId, laneCount)

	self._lateralOffset = self._trackPath:LaneToLateralOffset(laneIndex, laneCount)
	self._laneSwitchTargetLateral = self._lateralOffset

	local landingPose = self._trackPath:Sample(self._trackDistance, self._lateralOffset)
	local landingTargetY = self:_resolveRideHeight() + self:_resolveItemFlightOffset()

	transformhelper.setPos(transform, landingPose.position.x, landingTargetY, landingPose.position.y)

	self._aerialShortcutExitFlightActive = false
	self._aerialShortcutExitFlightRemainingSec = 0
	self._aerialShortcutExitRecoverRoute = nil
	self._aerialShortcutExitRecoverPath = nil
	self._aerialShortcutExitCameraProfileId = 0
	self._aerialShortcutExitMainEquivalent = 0
	self._routeTransferProjectionLockRemainingSec = 0.25
	self._laneSwitchCooldownRemainingSec = self:_resolveLaneSwitchCooldownSec()
	self._hasTrackState = true
end

function PlayerVehicleController:_beginGlide(glide, currentLaneId, sourceLaneCount)
	local recoverPath, recoverRoute, targetPosition = self:_tryResolveRouteEndpoint(glide.toRouteId, glide.toDistance, glide.toLaneId)

	if not recoverPath then
		return false
	end

	BindGlideEndpointToRoute(glide, targetPosition)

	local sourceAerialShortcut = self:_resolveActiveAerialShortcut()

	self:_beginSpecialRaceDistanceFreeze()

	self._activeGlideRoute = glide
	self._glideRecoverRoute = recoverRoute
	self._glideRecoverPath = recoverPath
	self._glideUsesAerialShortcutLaneMapping = sourceAerialShortcut ~= nil

	local glideLaneCount = math.max(1, glide.laneCount or 1)
	local var_229_0 = self._glideUsesAerialShortcutLaneMapping and AerialShortcut.MapLaneIdOneToOne(currentLaneId, glide.fromLaneId, glide.fromLaneId, glideLaneCount) or self:_mapLaneIdByRatio(currentLaneId, sourceLaneCount, glideLaneCount, glide.fromLaneId)
end

function PlayerVehicleController:_moveGlide(deltaTime)
	local glide = self._activeGlideRoute

	if not glide then
		return
	end

	if self._glideEntryFlightRemainingSec > 0 then
		self:_moveGlideEntryFlight(deltaTime)

		return
	end

	if glide.curveLength and glide.curveLength > 0 then
		local length = math.max(0.01, glide.curveLength or EstimateGlideLength(glide))
		local speedRecover01 = self:_resolveGlideLandingProgress(glide, length, self._glideDistance)
		local effectiveForwardSpeedMultiplier = self:_resolveGlideEffectiveForwardSpeedMultiplier(glide, speedRecover01)

		self._glideTravelSpeed = math.max(0, self._forwardSpeed * effectiveForwardSpeedMultiplier)
		self._glideDistance = math.min(length, self._glideDistance + self._glideTravelSpeed * math.max(0, deltaTime))
		self._glideProgress = Mathf.Clamp01(self._glideDistance / length)

		local laneCount = math.max(1, glide.laneCount or 1)
		local landingLockDistance = Glide.ResolveLandingLockDistance(glide.landingLockDistance)
		local landingLock = landingLockDistance >= length - self._glideDistance

		if not landingLock then
			self:_updateGlideTargets(glide, laneCount)
		else
			self._glideTargetAltitudeOffset = ResolveGlideAltitudeOffset(1, glide)
			self._glideAltitudeBandIndex = 1
		end

		if math.abs(self._glideTargetLateralOffset - self._glideLateralOffset) > 0.001 and math.abs(self._glideTargetAltitudeOffset - self._glideAltitudeOffset) > 0.001 then
			if not math.max(1, glide.diagonalSwitchDurationMultiplier or 1) then
				local diagonalMultiplier = 1
				local lateralStep = math.max(0.01, glide.laneWidth or 4) / math.max(0.01, (glide.lateralSwitchDuration or 1) * diagonalMultiplier) * deltaTime
				local verticalRange = math.max(0.01, math.abs((glide.highAltitudeOffset or 0) - (glide.midAltitudeOffset or 0)))
				local verticalStep = verticalRange / math.max(0.01, ((not glide.verticalSwitchDuration or nil) and 0.9) * diagonalMultiplier) * deltaTime

				self._glideLateralOffset = Mathf.MoveTowards(self._glideLateralOffset, self._glideTargetLateralOffset, lateralStep)
				self._glideAltitudeOffset = Mathf.MoveTowards(self._glideAltitudeOffset, self._glideTargetAltitudeOffset, verticalStep)

				local transform = self._transform
				local prevX, prevY, prevZ = transformhelper.getPos(transform)
				local anchor = EvaluateGlidePoint(glide, self._glideProgress)
				local tangent = self:_resolveGlideVisualForward(glide, length, self._glideDistance)
				local right = self:_resolveRightFromForward(tangent)
				local cameraLaneIndex = math.max(0, math.min(laneCount - 1, (glide.cameraLaneId or 1) - 1))
				local cameraLaneOffset = GlideLaneToOffset(cameraLaneIndex, laneCount, glide.laneWidth)
				local cameraAltitudeOffset = ResolveGlideAltitudeOffset(1, glide)
				local cameraAnchorX = anchor.x + right.x * cameraLaneOffset
				local cameraAnchorY = anchor.y + cameraAltitudeOffset
				local cameraAnchorZ = anchor.z + right.z * cameraLaneOffset
				local nextX = anchor.x + right.x * self._glideLateralOffset
				local nextY = anchor.y + self._glideAltitudeOffset
				local nextZ = anchor.z + right.z * self._glideLateralOffset
				local landing01 = self:_resolveGlideLandingProgress(glide, length, self._glideDistance)
				local landingForwardX, landingForwardY, landingForwardZ = tangent.x, tangent.y, tangent.z

				if landing01 > 0 then
					local landingTargetPosition, targetForward = self:_tryResolveGlideLandingPose(glide, laneCount)

					if landingTargetPosition then
						local easedLanding = self:_smoothStep(0, 1, landing01)
						local arcHeight = math.sin(landing01 * math.pi) * math.max(1.5, math.abs((glide.highAltitudeOffset or 0) - (glide.midAltitudeOffset or 0)) * 0.22)

						nextX = nextX + (landingTargetPosition.x - nextX) * easedLanding
						nextY = nextY + (landingTargetPosition.y - nextY) * easedLanding + arcHeight
						nextZ = nextZ + (landingTargetPosition.z - nextZ) * easedLanding

						local baseX, baseY, baseZ = tangent.x, tangent.y, tangent.z

						if tangent.sqrMagnitude <= 0.0001 then
							local stableTrack = self._stableTrackForward

							baseZ = stableTrack.z
							baseY = stableTrack.y
							baseX = stableTrack.x
						end

						landingForwardX, landingForwardY, landingForwardZ = SlerpUnitVec3(baseX, baseY, baseZ, targetForward.x, targetForward.y, targetForward.z, easedLanding)
					end
				end

				local cameraAnchorVehicleWeight = Mathf.Lerp(GlideCameraAnchorVehicleWeight, GlideLandingCameraAnchorVehicleWeight, self:_smoothStep(0, 1, landing01))

				SetVec3(self._glideCameraAnchorPosition, cameraAnchorX + (nextX - cameraAnchorX) * cameraAnchorVehicleWeight, cameraAnchorY + (nextY - cameraAnchorY) * cameraAnchorVehicleWeight, cameraAnchorZ + (nextZ - cameraAnchorZ) * cameraAnchorVehicleWeight)
				transformhelper.setPos(transform, nextX, nextY, nextZ)

				local movementVelocity

				if deltaTime > 0.0001 then
					local invDelta = 1 / deltaTime

					movementVelocity = SetVec3(_movementVelCache, (nextX - prevX) * invDelta, (nextY - prevY) * invDelta, (nextZ - prevZ) * invDelta)
				else
					movementVelocity = tangent
				end

				self:_updateEstimatedHorizontalVelocity(prevX, prevZ, nextX, nextZ, deltaTime)

				local facingForward, glideFollowRate = self:_resolveGlideFacingForward(SetVec3(_forwardCache, landingForwardX, landingForwardY, landingForwardZ), movementVelocity)
				local jitter = UnityEngine.Mathf.PerlinNoise(UnityEngine.Time.time * math.max(0.01, glide.jitterFrequency or 1), self._glideVisualJitterSeed) - 0.5
				local roll = math.max(-1, math.min(1, -self._glideLateralOffset / math.max(0.01, glide.laneWidth or 4))) * 8 + jitter * math.max(0, glide.jitterRotationAmplitudeDeg or 0)
				local pitchDeg, yawDeg = ResolvePitchYawDeg(facingForward.x, facingForward.y, facingForward.z)

				transformhelper.setRotationLerp(transform, pitchDeg, yawDeg, roll, math.min(1, deltaTime * glideFollowRate))
				SetVec3(self._stableTrackForward, FlatForwardXYZ(facingForward.x, facingForward.z))
				SetVec3(self._cameraTrackForward, facingForward.x, facingForward.y, facingForward.z)

				if self._glideProgress >= 0.999 then
					self:_completeGlide()
				end
			end
		end
	end
end

function PlayerVehicleController:_resolveGlideEntryHandoffPose(glide, tail01)
	if not glide then
		return self._glideEntryFlightTargetPosition, self._glideEntryFlightTargetForward, 0
	end

	if glide.curveLength and glide.curveLength > 0 then
		local length = math.max(0.01, glide.curveLength or EstimateGlideLength(glide))
		local speedMultiplier = math.max(0.01, (not glide.forwardSpeedMultiplier or nil) and 1)
		local maxAdvanceDistance = math.min(length * GlideEntryHandoffMaxProgress, math.max(0, self._forwardSpeed or 0) * speedMultiplier * GlideEntryHandoffAdvanceSec)
		local advanceDistance = maxAdvanceDistance * Mathf.Clamp01(tail01)
		local progress = Mathf.Clamp01(advanceDistance / length)
		local anchor = EvaluateGlidePoint(glide, progress)
		local tangent = EvaluateGlideTangent(glide, progress)
		local right = self:_resolveRightFromForward(tangent)
		local position = Vector3(anchor.x + right.x * self._glideLateralOffset, anchor.y + self._glideAltitudeOffset, anchor.z + right.z * self._glideLateralOffset)

		if tangent.sqrMagnitude > 0.001 then
			if not tangent.normalized then
				local forward = self._glideEntryFlightTargetForward

				return position, forward, advanceDistance
			end
		end
	end
end

function PlayerVehicleController:_moveGlideEntryFlight(deltaTime)
	local duration = math.max(0.001, self._glideEntryFlightDurationSec)
	local t = Mathf.Clamp01(1 - self._glideEntryFlightRemainingSec / duration)
	local eased = self:_resolveShortcutJumpHorizontalProgress(t)
	local start = self._glideEntryFlightStartPosition
	local glide = self._activeGlideRoute
	local tail01 = Mathf.Clamp01((t - GlideEntryHandoffStart01) / math.max(0.001, 1 - GlideEntryHandoffStart01))
	local finish, finishForward = self:_resolveGlideEntryHandoffPose(glide, tail01)
	local arcHeight = math.sin(t * math.pi) * math.max(0, self._glideEntryFlightArcHeight)
	local nextX = start.x + (finish.x - start.x) * eased
	local nextY = start.y + (finish.y - start.y) * eased + arcHeight
	local nextZ = start.z + (finish.z - start.z) * eased
	local transform = self._transform
	local prevX, prevY, prevZ = transformhelper.getPos(transform)

	transformhelper.setPos(transform, nextX, nextY, nextZ)
	SetVec3(self._glideCameraAnchorPosition, nextX, nextY, nextZ)

	local movementVelocity

	if deltaTime > 0.0001 then
		local invDelta = 1 / deltaTime

		movementVelocity = SetVec3(_movementVelCache, (nextX - prevX) * invDelta, (nextY - prevY) * invDelta, (nextZ - prevZ) * invDelta)
	else
		movementVelocity = finishForward
	end

	self:_updateEstimatedHorizontalVelocity(prevX, prevZ, nextX, nextZ, deltaTime)

	local startForward = self._glideEntryFlightStartForward
	local targetX, targetY, targetZ = SlerpUnitVec3(startForward.x, startForward.y, startForward.z, finishForward.x, finishForward.y, finishForward.z, eased)

	if targetX * targetX + targetY * targetY + targetZ * targetZ <= 0.001 then
		targetZ = finishForward.z
		targetY = finishForward.y
		targetX = finishForward.x

		local finishSqr = targetX * targetX + targetY * targetY + targetZ * targetZ

		if finishSqr > 0.001 then
			local inv = 1 / math.sqrt(finishSqr)

			targetZ = targetZ * inv
			targetY = targetY * inv
			targetX = targetX * inv
		else
			local stableForward = self:getStableForward()

			targetZ = stableForward.z
			targetY = stableForward.y
			targetX = stableForward.x
		end
	end

	local forward = self:_resolveSpecialRouteForward(SetVec3(_forwardCache, targetX, targetY, targetZ), movementVelocity, deltaTime, 0.75, true)

	SetVec3(self._stableTrackForward, FlatForwardXYZ(forward.x, forward.z))
	SetVec3(self._cameraTrackForward, forward.x, forward.y, forward.z)

	local pitchDeg, yawDeg = ResolvePitchYawDeg(forward.x, forward.y, forward.z)

	transformhelper.setRotationLerp(transform, pitchDeg, yawDeg, 0, math.min(1, deltaTime * 6))

	self._glideEntryFlightRemainingSec = math.max(0, self._glideEntryFlightRemainingSec - deltaTime)

	if self._glideEntryFlightRemainingSec <= 0 then
		local finalPosition, finalForward, finalAdvanceDistance = self:_resolveGlideEntryHandoffPose(glide, 1)

		transformhelper.setPos(transform, finalPosition.x, finalPosition.y, finalPosition.z)
		SetVec3(self._glideCameraAnchorPosition, finalPosition.x, finalPosition.y, finalPosition.z)

		self._glideDistance = math.max(self._glideDistance or 0, finalAdvanceDistance or 0)

		if glide then
			if glide.curveLength and glide.curveLength > 0 then
				local length = math.max(0.01, glide.curveLength or EstimateGlideLength(glide))

				self._glideProgress = Mathf.Clamp01(self._glideDistance / length)
			end
		end

		SetVec3(self._specialRouteSmoothedForward, finalForward.x, finalForward.y, finalForward.z)
		SetVec3(self._specialRouteForwardDampVelocity, 0, 0, 0)

		self._airborneForwardRollAngleDeg = 0
	end
end

function PlayerVehicleController:_updateGlideTargets(glide, laneCount)
	local threshold = self:_resolveLaneSwitchInputThreshold()
	local horizontalInput = threshold <= math.abs(self._steeringInput) and Mathf.Sign(self._steeringInput) or 0

	if not Mathf.Approximately(horizontalInput, 0) and not Mathf.Approximately(Mathf.Sign(horizontalInput), Mathf.Sign(self._previousGlideHorizontalInput)) then
		local currentLane = ResolveNearestGlideLane(self._glideLateralOffset, laneCount, glide.laneWidth)
		local delta = horizontalInput > 0 and -1 or 1
		local nextLane = math.max(0, math.min(laneCount - 1, currentLane + delta))

		self._glideTargetLateralOffset = GlideLaneToOffset(nextLane, laneCount, glide.laneWidth)
	end

	self._previousGlideHorizontalInput = horizontalInput

	local verticalInput = threshold <= math.abs(self._glideVerticalInput) and Mathf.Sign(self._glideVerticalInput) or 0

	if not Mathf.Approximately(verticalInput, 0) and not Mathf.Approximately(Mathf.Sign(verticalInput), Mathf.Sign(self._previousGlideVerticalInput)) then
		self._glideAltitudeBandIndex = verticalInput > 0 and math.min(2, self._glideAltitudeBandIndex + 1) or math.max(0, self._glideAltitudeBandIndex - 1)
		self._glideTargetAltitudeOffset = ResolveGlideAltitudeOffset(self._glideAltitudeBandIndex, glide)
	end

	self._previousGlideVerticalInput = verticalInput
end

function PlayerVehicleController:_resolveGlideLandingProgress(glide, length, distance)
	if not glide then
		return 0
	end

	local landingDistance = math.max(0.01, Glide.ResolveLandingLockDistance(glide.landingLockDistance))

	if landingDistance <= 0.01 then
		return 0
	end

	local remaining = math.max(0, length - distance)

	return Mathf.Clamp01(1 - remaining / landingDistance)
end

function PlayerVehicleController:_resolveSpecialTrackLandingBurstSpeedMultiplier(baseMultiplier, landing01)
	baseMultiplier = math.max(0.01, baseMultiplier or 1)

	local recover01 = self:_smoothStep(0, 1, landing01 or 0)
	local peakMultiplier = math.max(baseMultiplier, SpecialTrackLandingBurstPeakSpeedMultiplier)

	if recover01 < 0.5 then
		return Mathf.Lerp(baseMultiplier, peakMultiplier, self:_smoothStep(0, 1, recover01 / 0.5))
	end

	return Mathf.Lerp(peakMultiplier, 1, self:_smoothStep(0, 1, (recover01 - 0.5) / 0.5))
end

function PlayerVehicleController:_resolveGlideEffectiveForwardSpeedMultiplier(glide, landing01)
	if glide then
		local baseMultiplier = math.max(0.01, glide.forwardSpeedMultiplier or 1)

		return self:_resolveSpecialTrackLandingBurstSpeedMultiplier(baseMultiplier, landing01)
	end
end

function PlayerVehicleController:_resolveGlideLandingPreviewForward(path, distance, lateralOffset, fallbackForward)
	if not path or not path:getIsValid() then
		return fallbackForward
	end

	local safeDistance = distance or 0
	local currentPose = self._poseCache
	local previewPose = self._futurePoseCache

	if path == self._mainTrackPath and path.SampleVisualPoseTo then
		path:SampleVisualPoseTo(safeDistance, lateralOffset, TrackVisualPoseSampleRadius, currentPose, self._visualSampleBeforePoseCache, self._visualSampleAfterPoseCache)
		path:SampleVisualPoseTo(safeDistance + GlideFacingPreviewDistance, lateralOffset, TrackVisualPoseSampleRadius, previewPose, self._visualSampleBeforePoseCache, self._visualSampleAfterPoseCache)
	else
		path:SampleTo(safeDistance, lateralOffset, currentPose)
		path:SampleTo(safeDistance + GlideFacingPreviewDistance, lateralOffset, previewPose)
	end

	local currentTangentX, currentTangentZ = currentPose.tangent.x, currentPose.tangent.y
	local previewTangentX, previewTangentZ = previewPose.tangent.x, previewPose.tangent.y
	local currentX, currentY, currentZ
	local currentSqr = currentTangentX * currentTangentX + currentTangentZ * currentTangentZ

	if currentSqr > 0.001 then
		local inv = 1 / math.sqrt(currentSqr)

		currentZ = currentTangentZ * inv
		currentY = 0
		currentX = currentTangentX * inv
	else
		currentZ = fallbackForward.z
		currentY = fallbackForward.y
		currentX = fallbackForward.x
	end

	local previewX, previewY, previewZ
	local previewSqr = previewTangentX * previewTangentX + previewTangentZ * previewTangentZ

	if previewSqr > 0.001 then
		local inv = 1 / math.sqrt(previewSqr)

		previewZ = previewTangentZ * inv
		previewY = 0
		previewX = previewTangentX * inv
	else
		previewZ = currentZ
		previewY = currentY
		previewX = currentX
	end

	return SetVec3(_glidePreviewForwardResult, SlerpUnitVec3(currentX, currentY, currentZ, previewX, previewY, previewZ, GlideFacingPreviewWeight))
end

function PlayerVehicleController:_tryResolveGlideLandingPose(glide, sourceLaneCount)
	if self._glideRecoverPath and self._glideRecoverPath:getIsValid() then
		if not self._glideRecoverPath then
			local targetPath

			if not targetPath then
				return nil, nil
			end

			if self._glideRecoverRoute == nil then
				local var_238_1 = math.max(1, self:_resolveLaneSwitchLaneCount())

				if not var_238_1 then
					var_238_1 = math.max(1, self._glideRecoverRoute.laneCount or 1)

					local targetLaneCount = var_238_1
					local sourceLaneId = ResolveNearestGlideLane(self._glideTargetLateralOffset, sourceLaneCount, glide.laneWidth) + 1

					if self._glideUsesAerialShortcutLaneMapping then
						if not AerialShortcut.MapLaneIdOneToOne(sourceLaneId, glide.fromLaneId, glide.toLaneId, targetLaneCount) then
							if glide.lockLandingLane then
								local var_238_4 = math.max(1, math.min(glide.toLaneId or 1, targetLaneCount)) or self:_mapLaneIdByRatio(sourceLaneId, sourceLaneCount, targetLaneCount, glide.toLaneId)
							end
						end
					end
				end
			end
		end
	end
end

function PlayerVehicleController:_completeGlide()
	local glide = self._activeGlideRoute

	if not glide then
		return
	end

	local mainEquivalent = self:_resolveCurrentLapRaceDistance()
	local sourceLaneCount = math.max(1, (not glide.laneCount or nil) and 1)
	local sourceLaneId = ResolveNearestGlideLane(self._glideTargetLateralOffset, sourceLaneCount, glide.laneWidth) + 1
	local transform = self._transform
	local landingStartX, landingStartY, landingStartZ = transformhelper.getPos(transform)
	local goForwardX, goForwardY, goForwardZ = transformhelper.getForward(transform)
	local landingStartForward = goForwardX * goForwardX + goForwardY * goForwardY + goForwardZ * goForwardZ > 0.001 and CreateFlatForward(goForwardX, goForwardZ) or self:getStableForward()

	self._activeGlideRoute = nil
	self._glideProgress = 0
	self._glideDistance = 0
	self._glideTravelSpeed = 0
	self._previousGlideHorizontalInput = 0
	self._previousGlideVerticalInput = 0
	self._activeLayeredRoute = self._glideRecoverRoute
	self._activeRouteShortcut = nil
	self._routeShortcutReturnPath = nil

	if self._activeLayeredRoute == nil then
		self._activeRouteMainBaseDistance = 0
		self._activeRouteLocalBaseDistance = 0
		self._trackPath = self._mainTrackPath
	else
		self._activeRouteMainBaseDistance = mainEquivalent
		self._activeRouteLocalBaseDistance = math.max(0, glide.toDistance or 0)
		self._trackPath = self._glideRecoverPath
	end

	self._trackDistance = Mathf.Clamp(glide.toDistance, self._trackPath:getStartDistance(), self._trackPath:getEndDistance())

	local laneCount = self:_resolveLaneSwitchLaneCount()

	if self._glideUsesAerialShortcutLaneMapping then
		if not AerialShortcut.MapLaneIdOneToOne(sourceLaneId, glide.fromLaneId, glide.toLaneId, laneCount) then
			if glide.lockLandingLane then
				local var_239_2 = math.max(1, math.min(glide.toLaneId or 1, laneCount)) or self:_mapLaneIdByRatio(sourceLaneId, sourceLaneCount, laneCount, glide.toLaneId)
			end
		end
	end
end

function PlayerVehicleController:_moveGlideLandingBlend(deltaTime, damping)
	if not self._glideLandingBlendActive or not self._trackPath or not self._trackPath:getIsValid() then
		self._glideLandingBlendActive = false
		self._glideLandingBlendRemainingSec = 0

		return
	end

	local duration = math.max(0.0001, self._glideLandingBlendDurationSec)
	local remaining = math.max(0, self._glideLandingBlendRemainingSec)
	local eased = Mathf.Clamp01(1 - remaining / duration)

	self._glideLandingElapsedSec = math.min(duration, (self._glideLandingElapsedSec or 0) + math.max(0, deltaTime))

	local movingDistance = Mathf.Clamp((self._glideLandingBaseDistance or self._glideLandingTargetDistance) + math.max(0, self._forwardSpeed or 0) * self._glideLandingElapsedSec, self._trackPath:getStartDistance(), self._trackPath:getEndDistance())
	local movingPose = self._poseCache

	self._trackPath:SampleTo(movingDistance, self._glideLandingTargetLateral, movingPose)

	self._glideLandingTargetDistance = movingDistance

	local landingTargetPosition = self._glideLandingTargetPosition

	SetVec3(landingTargetPosition, movingPose.position.x, self:_resolveRideHeight() + self:_resolveItemFlightOffset(), movingPose.position.y)

	local movingTangentX, movingTangentZ = movingPose.tangent.x, movingPose.tangent.y
	local movingTangentSqr = movingTangentX * movingTangentX + movingTangentZ * movingTangentZ

	if movingTangentSqr > 0.001 then
		local inv = 1 / math.sqrt(movingTangentSqr)

		SetVec3(self._glideLandingTargetForward, movingTangentX * inv, 0, movingTangentZ * inv)
	end

	local landingStartPosition = self._glideLandingStartPosition
	local verticalDrop = math.max(0, landingStartPosition.y - landingTargetPosition.y)
	local arcHeight = math.max(0.75, verticalDrop * 0.18)
	local transform = self._transform
	local prevX, prevY, prevZ = transformhelper.getPos(transform)
	local arcOffset = math.sin(eased * math.pi) * arcHeight
	local nextX = landingStartPosition.x + (landingTargetPosition.x - landingStartPosition.x) * eased
	local nextY = landingStartPosition.y + (landingTargetPosition.y - landingStartPosition.y) * eased + arcOffset
	local nextZ = landingStartPosition.z + (landingTargetPosition.z - landingStartPosition.z) * eased

	transformhelper.setPos(transform, nextX, nextY, nextZ)

	self._trackDistance = Mathf.Lerp(self._glideLandingBaseDistance or self._glideLandingTargetDistance, self._glideLandingTargetDistance, eased)
	self._lateralOffset = Mathf.Lerp(self._lateralOffset, self._glideLandingTargetLateral, eased)
	self._laneSwitchTargetLateral = self._lateralOffset
	self._laneSwitchActive = false
	self._lateralVelocity = 0

	local currentRouteForward = self:_resolveGlideLandingPreviewForward(self._trackPath, self._trackDistance, self._glideLandingTargetLateral, self._glideLandingTargetForward)
	local landingStartForward = self._glideLandingStartForward
	local desiredX, desiredY, desiredZ = SlerpUnitVec3(landingStartForward.x, landingStartForward.y, landingStartForward.z, currentRouteForward.x, currentRouteForward.y, currentRouteForward.z, eased)
	local horizontalVelocity = self:_resolveHorizontalVelocity(prevX, prevZ, nextX, nextZ, deltaTime)

	self:_updateEstimatedHorizontalVelocity(prevX, prevZ, nextX, nextZ, deltaTime)

	local facingForward, landingFollowRate = self:_resolveGlideFacingForward(SetVec3(_forwardCache, desiredX, desiredY, desiredZ), horizontalVelocity)
	local pitchDeg, yawDeg = ResolvePitchYawDeg(facingForward.x, facingForward.y, facingForward.z)

	transformhelper.setRotationLerp(transform, pitchDeg, yawDeg, 0, Mathf.Clamp(landingFollowRate * math.max(0, deltaTime), 0, 1))
	SetVec3(self._stableTrackForward, FlatForwardXYZ(facingForward.x, facingForward.z))
	SetVec3(self._cameraTrackForward, facingForward.x, facingForward.y, facingForward.z)

	self._glideLandingBlendRemainingSec = math.max(0, self._glideLandingBlendRemainingSec - deltaTime)

	if self._glideLandingBlendRemainingSec > 0 then
		return
	end

	self._glideLandingBlendActive = false
	self._glideLandingBlendRemainingSec = 0

	transformhelper.setPos(transform, landingTargetPosition.x, landingTargetPosition.y, landingTargetPosition.z)

	self._trackDistance = self._glideLandingTargetDistance
	self._lateralOffset = self._glideLandingTargetLateral
	self._laneSwitchTargetLateral = self._lateralOffset

	local finalForwardX, finalForwardY, finalForwardZ = transformhelper.getForward(transform)
	local finalFlatX, finalFlatY, finalFlatZ = FlatForwardXYZ(finalForwardX, finalForwardZ)

	SetVec3(self._stableTrackForward, finalFlatX, finalFlatY, finalFlatZ)
	SetVec3(self._cameraTrackForward, finalFlatX, finalFlatY, finalFlatZ)
	SetVec3(self._smoothedVisualForward, finalFlatX, finalFlatY, finalFlatZ)

	self._visualForwardDampVelX, self._visualForwardDampVelY, self._visualForwardDampVelZ = 0, 0, 0

	SetVec3(self._specialRouteSmoothedForward, finalFlatX, finalFlatY, finalFlatZ)
	SetVec3(self._specialRouteForwardDampVelocity, 0, 0, 0)

	self._glideLandingCameraProfileId = 0
	self._hasTrackState = true
end

function PlayerVehicleController:_moveRouteTransferFlight(deltaTime, damping)
	local duration = math.max(0.001, self._routeTransferFlightDurationSec)
	local remaining = math.max(0, self._routeTransferFlightRemainingSec)
	local nextRemaining = math.max(0, remaining - deltaTime)
	local t = Mathf.Clamp01(1 - nextRemaining / duration)

	if not self._routeTransferUseAlignedCurve then
		t = Mathf.Clamp01(1 - remaining / duration)
	end

	local eased = t
	local start = self._routeTransferFlightStartPosition
	local finish = self._routeTransferFlightTargetPosition
	local basePositionX, basePositionY, basePositionZ, desiredX, desiredY, desiredZ

	if self._routeTransferUseAlignedCurve then
		local curveX, curveZ, tangentX, tangentZ = RouteTransfer.EvaluateAlignedHorizontalCurve(start.x, start.z, self._routeTransferFlightStartForward.x, self._routeTransferFlightStartForward.z, finish.x, finish.z, self._routeTransferFlightTargetForward.x, self._routeTransferFlightTargetForward.z, eased)

		basePositionZ = curveZ
		basePositionY = Mathf.Lerp(start.y, finish.y, eased)
		basePositionX = curveX
		desiredZ = tangentZ
		desiredY = 0
		desiredX = tangentX
	else
		basePositionX = start.x + (finish.x - start.x) * eased
		basePositionY = start.y + (finish.y - start.y) * eased
		basePositionZ = start.z + (finish.z - start.z) * eased
		desiredZ = finish.z - start.z
		desiredY = 0
		desiredX = finish.x - start.x
	end

	local jumpOffset = math.sin(t * math.pi) * math.max(0, self._routeTransferFlightHeight)
	local transform = self._transform
	local prevX, prevY, prevZ = transformhelper.getPos(transform)
	local nextX, nextY, nextZ = basePositionX, basePositionY + jumpOffset, basePositionZ

	transformhelper.setPos(transform, nextX, nextY, nextZ)

	if desiredX * desiredX + desiredY * desiredY + desiredZ * desiredZ <= 0.001 then
		local smoothedForward = self._routeTransferFlightSmoothedForward

		desiredZ = smoothedForward.z
		desiredY = smoothedForward.y
		desiredX = smoothedForward.x
	end

	self._trackPath:SampleTo(self._trackDistance, self._lateralOffset, self._futurePoseCache)

	local targetTangentX, targetTangentZ = self._futurePoseCache.tangent.x, self._futurePoseCache.tangent.y

	if not self._routeTransferUseAlignedCurve and desiredX * desiredX + desiredY * desiredY + desiredZ * desiredZ > 0.001 and targetTangentX * targetTangentX + targetTangentZ * targetTangentZ > 0.001 then
		desiredX, desiredY, desiredZ = SlerpUnitVec3(desiredX, desiredY, desiredZ, targetTangentX, 0, targetTangentZ, t)
	end

	self:_updateEstimatedHorizontalVelocity(prevX, prevZ, nextX, nextZ, deltaTime)

	local horizontalVelocity = self:_resolveHorizontalVelocity(prevX, prevZ, nextX, nextZ, deltaTime)
	local forwardX, forwardY, forwardZ

	if self._routeTransferUseAlignedCurve then
		local desiredSqr = desiredX * desiredX + desiredY * desiredY + desiredZ * desiredZ

		if desiredSqr > 1e-10 then
			local inv = 1 / math.sqrt(desiredSqr)

			forwardZ = desiredZ * inv
			forwardY = desiredY * inv
			forwardX = desiredX * inv
		else
			forwardZ = 0
			forwardY = 0
			forwardX = 0
		end

		SetVec3(self._specialRouteSmoothedForward, forwardX, forwardY, forwardZ)
		SetVec3(self._specialRouteForwardDampVelocity, 0, 0, 0)
	else
		local resolvedForward = self:_resolveSpecialRouteForward(SetVec3(_forwardCache, desiredX, desiredY, desiredZ), horizontalVelocity, deltaTime, 0.75)

		forwardZ = resolvedForward.z
		forwardY = resolvedForward.y
		forwardX = resolvedForward.x
	end

	SetVec3(self._routeTransferFlightSmoothedForward, forwardX, forwardY, forwardZ)

	local orientationSpeed = math.max(0, self._forwardSpeed)

	self:_updateVehicleOrientation(SetVec3(_forwardCache, forwardX, forwardY, forwardZ), SetVec3(_movementVelCache, forwardX * orientationSpeed, forwardY * orientationSpeed, forwardZ * orientationSpeed), damping, deltaTime)

	self._routeTransferFlightRemainingSec = nextRemaining

	if self._routeTransferFlightRemainingSec <= 0 then
		self._trackPath:SampleTo(self._trackDistance, self._lateralOffset, self._futurePoseCache)

		local landingPose = self._futurePoseCache
		local landingTangentX, landingTangentZ = landingPose.tangent.x, landingPose.tangent.y
		local landingTangentSqr = landingTangentX * landingTangentX + landingTangentZ * landingTangentZ
		local landingForwardX, landingForwardY, landingForwardZ

		if landingTangentSqr > 1e-10 then
			local inv = 1 / math.sqrt(landingTangentSqr)

			landingForwardZ = landingTangentZ * inv
			landingForwardY = 0
			landingForwardX = landingTangentX * inv
		else
			local stableTrack = self._stableTrackForward

			landingForwardZ = stableTrack.z
			landingForwardY = stableTrack.y
			landingForwardX = stableTrack.x
		end

		transformhelper.setPos(transform, landingPose.position.x, self:_resolveRideHeight() + self:_resolveItemFlightOffset(), landingPose.position.y)
		self:_updateVehicleOrientation(SetVec3(_forwardCache, landingForwardX, landingForwardY, landingForwardZ), SetVec3(_movementVelCache, 0, 0, 0), damping, deltaTime)

		if self._routeTransferUseAlignedCurve then
			SetVec3(self._stableTrackForward, landingForwardX, landingForwardY, landingForwardZ)
			SetVec3(self._cameraTrackForward, landingForwardX, landingForwardY, landingForwardZ)
			SetVec3(self._smoothedVisualForward, landingForwardX, landingForwardY, landingForwardZ)
			SetVec3(self._specialRouteSmoothedForward, landingForwardX, landingForwardY, landingForwardZ)
			SetVec3(self._routeTransferFlightSmoothedForward, landingForwardX, landingForwardY, landingForwardZ)
			SetVec3(self._specialRouteForwardDampVelocity, 0, 0, 0)

			self._visualForwardDampVelX, self._visualForwardDampVelY, self._visualForwardDampVelZ = 0, 0, 0
		end

		self._laneSwitchActive = false
		self._laneSwitchTargetLateral = self._lateralOffset
		self._lateralVelocity = 0
		self._routeTransferProjectionLockRemainingSec = math.max(self._routeTransferProjectionLockRemainingSec or 0, 0.35)
		self._routeTransferUseAlignedCurve = false
	end
end

function PlayerVehicleController:_moveAirWaterDrop(deltaTime, damping)
	local drop = self._activeWaterDrop

	if not drop then
		return
	end

	self._waterDropElapsedSec = self._waterDropElapsedSec + deltaTime

	local baseDuration, minDuration = WaterDrop.ResolveFallDurations(drop)

	self._waterDropRemainingSec = math.max(0, baseDuration - self._waterDropElapsedSec)

	local maxAllowedProgress = Mathf.Clamp01(self._waterDropElapsedSec / minDuration)
	local baseProgress = (self._waterDropProgress or 0) + deltaTime / baseDuration
	local pendingTapProgress = math.max(0, (not self._waterDropTapProgressPending or nil) and 0)
	local tapProgressStep = math.min(pendingTapProgress, math.max(0, WaterDropTapProgressConsumeRate) * math.max(0, deltaTime), math.max(0, maxAllowedProgress - baseProgress))

	self._waterDropProgress = math.min(maxAllowedProgress, baseProgress + tapProgressStep)
	self._waterDropTapProgressPending = math.max(0, pendingTapProgress - tapProgressStep)

	local eased = self._waterDropProgress
	local start = self._waterDropStartPosition
	local finish = self._waterDropTargetPosition
	local basePositionX = start.x + (finish.x - start.x) * eased
	local basePositionY = start.y + (finish.y - start.y) * eased
	local basePositionZ = start.z + (finish.z - start.z) * eased
	local basePosition = SetVec3(_basePosCache, basePositionX, basePositionY, basePositionZ)
	local positionLanding01 = WaterDrop.ResolveLandingProgressByRemainingDistance(basePosition, finish, WaterDropLandingPositionPrepareDistance)
	local positionLandingEased = self:_smoothStep(0, 1, positionLanding01)
	local height = math.sin((1 - self._waterDropProgress) * math.pi * 0.5) * math.max(0, (not drop.fallHeightOffset or nil) and 0) + ResolveLandingSinkOffset(self._waterDropProgress, WaterDropLandingSinkDepth, WaterDropLandingSinkStart01)

	height = height * (1 - positionLandingEased)

	local transform = self._transform
	local prevX, prevY, prevZ = transformhelper.getPos(transform)

	transformhelper.setPos(transform, basePositionX, basePositionY + height, basePositionZ)

	self._waterDropSpinAngleDeg = Mathf.Repeat(self._waterDropSpinAngleDeg + self._waterDropSpinSpeedDeg * math.max(0, deltaTime), 360)
	self._waterDropSpinSpeedDeg = Mathf.MoveTowards(self._waterDropSpinSpeedDeg, self:_resolveWaterDropBaseSpinSpeed(drop), math.max(0, drop.spinDampingDegPerSec or 0) * math.max(0, deltaTime))
	self._waterDropFeedbackSpinSpeedDeg = WaterDrop.ResolveFeedbackSpinSpeed(self._waterDropFeedbackSpinSpeedDeg, self._waterDropSpinSpeedDeg, deltaTime)
	self._waterDropFeedbackTier = WaterDrop.ResolveFeedbackTier(self._waterDropFeedbackTier, self._waterDropFeedbackSpinSpeedDeg)

	local dropForward = self._waterDropForward
	local forwardX, forwardY, forwardZ

	if dropForward and dropForward.sqrMagnitude > 0.001 then
		local dx, dy, dz = dropForward.x, dropForward.y, dropForward.z
		local inv = 1 / math.sqrt(dx * dx + dy * dy + dz * dz)

		forwardZ = dz * inv
		forwardY = dy * inv
		forwardX = dx * inv
	else
		forwardX, forwardY, forwardZ = transformhelper.getForward(transform)
	end

	if forwardX * forwardX + forwardY * forwardY + forwardZ * forwardZ <= 0.001 then
		local stableTrack = self._stableTrackForward

		forwardZ = stableTrack.z
		forwardY = stableTrack.y
		forwardX = stableTrack.x
	end

	local targetForwardX, targetForwardY, targetForwardZ = forwardX, forwardY, forwardZ

	if self._waterDropRecoverPath and self._waterDropRecoverPath:getIsValid() then
		if self._waterDropRecoverRoute then
			local var_242_4 = math.max(1, self._waterDropRecoverRoute.laneCount or 1)

			if not var_242_4 then
				var_242_4 = math.max(1, (self._controlConfig or nil) and (self._controlConfig.laneSwitchLaneCount or 4))

				do
					local targetLaneCount = var_242_4
					local targetLaneIndex = LRRU.CsLaneIdToLuaIndex(drop.recoverLaneId, targetLaneCount)
					local targetLateral = self._waterDropRecoverPath:LaneToLateralOffset(targetLaneIndex, targetLaneCount)

					self._waterDropRecoverPath:SampleTo(drop.recoverDistance, targetLateral, self._futurePoseCache)

					local targetPose = self._futurePoseCache
					local sampledX, sampledZ = targetPose.tangent.x, targetPose.tangent.y
					local sampledSqr = sampledX * sampledX + sampledZ * sampledZ

					if sampledSqr > 0.001 then
						local inv = 1 / math.sqrt(sampledSqr)

						targetForwardZ = sampledZ * inv
						targetForwardY = 0
						targetForwardX = sampledX * inv
					end
				end

				local postureLanding01 = WaterDrop.ResolveLandingProgressByRemainingDistance(basePosition, finish, WaterDropLandingPosturePrepareDistance)
				local postureLandingEased = self:_smoothStep(0, 1, postureLanding01)
				local landingForwardX, landingForwardY, landingForwardZ = SlerpUnitVec3(forwardX, forwardY, forwardZ, targetForwardX, targetForwardY, targetForwardZ, postureLandingEased)

				if landingForwardX * landingForwardX + landingForwardY * landingForwardY + landingForwardZ * landingForwardZ <= 0.001 then
					landingForwardZ = targetForwardZ
					landingForwardY = targetForwardY
					landingForwardX = targetForwardX
				end

				local pitchDeg, yawDeg = ResolvePitchYawDeg(landingForwardX, landingForwardY, landingForwardZ)

				transformhelper.setEulerAngles(transform, pitchDeg + self._waterDropSpinAngleDeg, yawDeg, 0)

				local flatX, flatY, flatZ = FlatForwardXYZ(landingForwardX, landingForwardZ)

				SetVec3(self._stableTrackForward, flatX, flatY, flatZ)
				SetVec3(self._cameraTrackForward, flatX, flatY, flatZ)
				self:_updateEstimatedHorizontalVelocity(prevX, prevZ, basePositionX, basePositionZ, deltaTime)

				if self._waterDropProgress >= 0.999 or self._waterDropRemainingSec <= 0 then
					self:_completeAirWaterDrop()
				end
			end
		end
	end
end

function PlayerVehicleController:_registerWaterDropTap()
	local drop = self._activeWaterDrop

	if not drop or self._waterDropRemainingSec <= 0 or not drop.tapEnabled then
		return
	end

	self._waterDropTapProgressPending = math.min(WaterDropTapPendingProgressCap, math.max(0, self._waterDropTapProgressPending or 0) + WaterDrop.ResolveTapProgressAdd(drop))
	self._waterDropSpinSpeedDeg = math.min(WaterDrop.ResolveMaxSpinSpeed(drop), self._waterDropSpinSpeedDeg + WaterDrop.ResolveTapSpinSpeedAdd(drop))
end

function PlayerVehicleController:_resolveWaterDropBaseSpinSpeed(drop)
	return WaterDrop.ResolveBaseSpinSpeed(drop)
end

function PlayerVehicleController:_completeAirWaterDrop()
	local drop = self._activeWaterDrop

	if not drop then
		return
	end

	local mainEquivalent = self:_resolveCurrentLapRaceDistance()
	local transform = self._transform
	local landingStartX, landingStartY, landingStartZ = transformhelper.getPos(transform)
	local landingStartForward = self._stableTrackForward and self._stableTrackForward.sqrMagnitude > 0.001 and self:_resolveFlatForward(self._stableTrackForward) or self:getStableForward()

	if not drop.cameraId then
		local landingCameraProfileId = 0

		self._activeWaterDrop = nil
		self._waterDropRemainingSec = 0
		self._waterDropElapsedSec = 0
		self._waterDropProgress = 0
		self._waterDropTapProgressPending = 0
		self._airborneForwardRollAngleDeg = self._waterDropSpinAngleDeg
		self._waterDropSpinSpeedDeg = 0
		self._waterDropSpinAngleDeg = 0
		self._waterDropFeedbackSpinSpeedDeg = 0
		self._waterDropFeedbackTier = 1

		local landingStartPitchDeg, landingStartYawDeg = ResolvePitchYawDeg(landingStartForward.x, landingStartForward.y, landingStartForward.z)

		transformhelper.setEulerAngles(transform, landingStartPitchDeg, landingStartYawDeg, 0)

		self._activeLayeredRoute = self._waterDropRecoverRoute
		self._activeRouteShortcut = nil
		self._routeShortcutReturnPath = nil

		if self._activeLayeredRoute == nil then
			self._activeRouteMainBaseDistance = 0
			self._activeRouteLocalBaseDistance = 0
			self._trackPath = self._mainTrackPath
		else
			self._activeRouteMainBaseDistance = mainEquivalent
			self._activeRouteLocalBaseDistance = math.max(0, drop.recoverDistance or 0)
			self._trackPath = self._waterDropRecoverPath
		end

		self._trackDistance = Mathf.Clamp(drop.recoverDistance, self._trackPath:getStartDistance(), self._trackPath:getEndDistance())

		local laneCount = self:_resolveLaneSwitchLaneCount()
		local laneIndex = LRRU.CsLaneIdToLuaIndex(drop.recoverLaneId, laneCount)

		self._lateralOffset = self._trackPath:LaneToLateralOffset(laneIndex, laneCount)
		self._laneSwitchTargetLateral = self._lateralOffset
		self._laneSwitchActive = false
		self._lateralVelocity = 0

		local pose = self._trackPath:Sample(self._trackDistance, self._lateralOffset)
		local landingTargetX = pose.position.x
		local landingTargetY = self:_resolveRideHeight() + self:_resolveItemFlightOffset()
		local landingTargetZ = pose.position.y
		local landingTangentX, landingTangentZ = pose.tangent.x, pose.tangent.y
		local landingTangentSqr = landingTangentX * landingTangentX + landingTangentZ * landingTangentZ
		local landingTargetForwardX, landingTargetForwardY, landingTargetForwardZ

		if landingTangentSqr > 0.001 then
			do
				local inv = 1 / math.sqrt(landingTangentSqr)

				landingTargetForwardZ = landingTangentZ * inv
				landingTargetForwardY = 0
				landingTargetForwardX = landingTangentX * inv
			end
		else
			landingTargetForwardZ = landingStartForward.z
			landingTargetForwardY = landingStartForward.y
			landingTargetForwardX = landingStartForward.x
		end

		local recoverSpeedMultiplier = math.max(0.01, drop.recoverSpeedMultiplier or 0.75)
		local resumeForwardSpeed = math.max(0, (not self._forwardSpeed or nil) and 0)

		self._forwardSpeed = self._forwardSpeed * recoverSpeedMultiplier
		self._laneSwitchCooldownRemainingSec = math.max(self._laneSwitchCooldownRemainingSec, drop.recoverControlLockSec or 0)

		SetVec3(self._waterDropLandingStartPosition, landingStartX, landingStartY, landingStartZ)
		SetVec3(self._waterDropLandingTargetPosition, landingTargetX, landingTargetY, landingTargetZ)
		SetVec3(self._waterDropLandingStartForward, landingStartForward.x, landingStartForward.y, landingStartForward.z)
		SetVec3(self._waterDropLandingTargetForward, landingTargetForwardX, landingTargetForwardY, landingTargetForwardZ)

		self._waterDropLandingTargetDistance = self._trackDistance
		self._waterDropLandingTargetLateral = self._lateralOffset
		self._waterDropLandingCameraProfileId = landingCameraProfileId
		self._waterDropLandingBaseDistance = self._trackDistance
		self._waterDropLandingElapsedSec = 0
		self._waterDropLandingResumeForwardSpeed = resumeForwardSpeed
		self._waterDropLandingRecoverSpeedMultiplier = recoverSpeedMultiplier
		self._waterDropLandingBlendDurationSec = WaterDropLandingBlendDurationSec
		self._waterDropLandingBlendRemainingSec = self._waterDropLandingBlendDurationSec
		self._waterDropLandingBlendActive = true
		self._landingReattachRemainingSec = 0
		self._waterDropRecoverRoute = nil
		self._waterDropRecoverPath = nil
		self._hasTrackState = true
	end
end

function PlayerVehicleController:_moveWaterDropLandingBlend(deltaTime, damping)
	if not self._waterDropLandingBlendActive or not self._trackPath or not self._trackPath:getIsValid() then
		self._waterDropLandingBlendActive = false
		self._waterDropLandingBlendRemainingSec = 0
		self._waterDropLandingCameraProfileId = 0

		return
	end

	local duration = math.max(0.0001, self._waterDropLandingBlendDurationSec)
	local remaining = math.max(0, self._waterDropLandingBlendRemainingSec)
	local t = Mathf.Clamp01(1 - remaining / duration)
	local positionEased = self:_smoothStep(0, 1, t)
	local postureT = Mathf.Clamp01((t - 0.2) / 0.8)
	local postureEased = self:_smoothStep(0, 1, postureT)

	self._waterDropLandingElapsedSec = math.min(duration, (self._waterDropLandingElapsedSec or 0) + math.max(0, deltaTime))

	local burstMultiplier = self:_resolveSpecialTrackLandingBurstSpeedMultiplier(self._waterDropLandingRecoverSpeedMultiplier or 1, t)
	local movingDistance = Mathf.Clamp((self._waterDropLandingTargetDistance or self._waterDropLandingBaseDistance) + math.max(0, self._waterDropLandingResumeForwardSpeed or self._forwardSpeed or 0) * burstMultiplier * math.max(0, deltaTime), self._trackPath:getStartDistance(), self._trackPath:getEndDistance())
	local movingPose = self._poseCache

	self._trackPath:SampleTo(movingDistance, self._waterDropLandingTargetLateral, movingPose)

	self._waterDropLandingTargetDistance = movingDistance

	local landingTargetPosition = self._waterDropLandingTargetPosition

	SetVec3(landingTargetPosition, movingPose.position.x, self:_resolveRideHeight() + self:_resolveItemFlightOffset(), movingPose.position.y)

	local movingTangentX, movingTangentZ = movingPose.tangent.x, movingPose.tangent.y
	local movingTangentSqr = movingTangentX * movingTangentX + movingTangentZ * movingTangentZ

	if movingTangentSqr > 0.001 then
		local inv = 1 / math.sqrt(movingTangentSqr)

		SetVec3(self._waterDropLandingTargetForward, movingTangentX * inv, 0, movingTangentZ * inv)
	end

	local transform = self._transform
	local prevX, prevY, prevZ = transformhelper.getPos(transform)
	local landingStartPosition = self._waterDropLandingStartPosition
	local arcOffset = math.sin(t * math.pi) * WaterDropExitFlightArcHeight
	local nextX = landingStartPosition.x + (landingTargetPosition.x - landingStartPosition.x) * positionEased
	local nextY = landingStartPosition.y + (landingTargetPosition.y - landingStartPosition.y) * positionEased + arcOffset
	local nextZ = landingStartPosition.z + (landingTargetPosition.z - landingStartPosition.z) * positionEased

	transformhelper.setPos(transform, nextX, nextY, nextZ)

	self._trackDistance = self._waterDropLandingTargetDistance
	self._lateralOffset = self._waterDropLandingTargetLateral
	self._laneSwitchTargetLateral = self._lateralOffset
	self._laneSwitchActive = false
	self._lateralVelocity = 0

	local landingStartForward = self._waterDropLandingStartForward
	local landingTargetForward = self._waterDropLandingTargetForward
	local desiredX, desiredY, desiredZ = SlerpUnitVec3(landingStartForward.x, landingStartForward.y, landingStartForward.z, landingTargetForward.x, landingTargetForward.y, landingTargetForward.z, postureEased)
	local horizontalVelocity = self:_resolveHorizontalVelocity(prevX, prevZ, nextX, nextZ, deltaTime)

	self:_updateEstimatedHorizontalVelocity(prevX, prevZ, nextX, nextZ, deltaTime)
	self:_updateVehicleOrientation(SetVec3(_forwardCache, desiredX, desiredY, desiredZ), horizontalVelocity, damping, deltaTime)

	self._waterDropLandingBlendRemainingSec = math.max(0, self._waterDropLandingBlendRemainingSec - deltaTime)

	if self._waterDropLandingBlendRemainingSec > 0 then
		return
	end

	self._waterDropLandingBlendActive = false
	self._waterDropLandingBlendRemainingSec = 0
	self._waterDropLandingCameraProfileId = 0

	transformhelper.setPos(transform, landingTargetPosition.x, landingTargetPosition.y, landingTargetPosition.z)

	self._trackDistance = self._waterDropLandingTargetDistance
	self._lateralOffset = self._waterDropLandingTargetLateral
	self._laneSwitchTargetLateral = self._lateralOffset

	local finalForward = self._waterDropLandingTargetForward

	SetVec3(self._stableTrackForward, finalForward.x, finalForward.y, finalForward.z)
	SetVec3(self._cameraTrackForward, finalForward.x, finalForward.y, finalForward.z)
	SetVec3(self._smoothedVisualForward, finalForward.x, finalForward.y, finalForward.z)

	self._visualForwardDampVelX, self._visualForwardDampVelY, self._visualForwardDampVelZ = 0, 0, 0
	self._forwardSpeed = math.max(self._forwardSpeed or 0, self._waterDropLandingResumeForwardSpeed or 0)
	self._hasTrackState = true
end

function PlayerVehicleController:_resolveFallbackUnderwaterExit(underwater)
	if not underwater then
		return nil
	end

	return {
		exitId = "fallback",
		preserveCurrentLane = false,
		toRouteId = underwater.toRouteId,
		toDistance = underwater.toDistance,
		toLaneId = underwater.toLaneId
	}
end

function PlayerVehicleController:_resolveTriggeredUnderwaterExit(underwater, triggerElementId)
	if not underwater or not triggerElementId then
		return nil
	end

	if not underwater.exits then
		local exits = {}

		for _, exit in ipairs(exits) do
			if exit.triggerElementId and EqualsIgnoreCase(exit.triggerElementId, triggerElementId) then
				return exit
			end
		end

		local tolerance = math.max(0.01, underwater.triggerDistanceTolerance or 8)

		for _, exit in ipairs(exits) do
			if exit.triggerDistance and tolerance >= math.abs(self._trackDistance - exit.triggerDistance) then
				return exit
			end
		end

		if EqualsIgnoreCase(underwater.exitTriggerElementId, triggerElementId) then
			return self:_resolveFallbackUnderwaterExit(underwater)
		end

		return nil
	end
end

function PlayerVehicleController:_completeUnderwaterRoute(exit)
	local underwater = self._activeUnderwaterRoute

	if not underwater then
		return
	end

	exit = exit or self:_resolveFallbackUnderwaterExit(underwater)

	if not exit then
		return
	end

	local mainEquivalent = self:_resolveCurrentLapRaceDistance()
	local sourceLaneId = self:_resolveCurrentRouteLaneId()
	local sourceLaneCount = self:_resolveLaneSwitchLaneCount()
	local recoverPath, recoverRoute = self:_tryResolveRouteEndpoint(exit.toRouteId, exit.toDistance, exit.toLaneId)

	if not recoverPath then
		return
	end

	self._activeUnderwaterRoute = nil
	self._activeLayeredRoute = recoverRoute
	self._activeRouteShortcut = nil
	self._routeShortcutReturnPath = nil

	if self._activeLayeredRoute == nil then
		self._activeRouteMainBaseDistance = 0
		self._activeRouteLocalBaseDistance = 0
		self._trackPath = self._mainTrackPath
	else
		self._activeRouteMainBaseDistance = mainEquivalent
		self._activeRouteLocalBaseDistance = math.max(0, exit.toDistance or 0)
		self._trackPath = recoverPath
	end

	self._trackDistance = Mathf.Clamp(exit.toDistance, self._trackPath:getStartDistance(), self._trackPath:getEndDistance())

	local laneCount = self:_resolveLaneSwitchLaneCount()
	local targetLaneId
	local laneIndex = LRRU.CsLaneIdToLuaIndex(exit.preserveCurrentLane and self:_mapLaneIdByRatio(sourceLaneId, sourceLaneCount, laneCount, exit.toLaneId) or exit.toLaneId, laneCount)

	self._lateralOffset = self._trackPath:LaneToLateralOffset(laneIndex, laneCount)
	self._laneSwitchTargetLateral = self._lateralOffset
	self._laneSwitchActive = false
	self._lateralVelocity = 0

	local transform = self._transform
	local pose = self._trackPath:Sample(self._trackDistance, self._lateralOffset)

	transformhelper.setPos(transform, pose.position.x, self:_resolveRideHeight() + self:_resolveItemFlightOffset(), pose.position.y)
	self:_updateVehicleOrientation(SetVec3(_forwardCache, pose.tangent.x, 0, pose.tangent.y), SetVec3(_movementVelCache, 0, 0, 0), math.max(1, self._vehicleConfig.lateralDamping or 1), UnityEngine.Time.deltaTime)

	self._underwaterRecoverRoute = nil
	self._underwaterRecoverPath = nil
	self._routeTransferProjectionLockRemainingSec = math.max(0, underwater.exitBlendSec or 0.35)
	self._laneSwitchCooldownRemainingSec = self:_resolveLaneSwitchCooldownSec()
	self._hasTrackState = true
end

function PlayerVehicleController:_completeSnowSlopeRoute()
	local slope = self._activeSnowSlopeRoute

	if not slope then
		return
	end

	local mainEquivalent = self:_resolveCurrentLapRaceDistance()
	local sourceLaneId = self:_resolveCurrentRouteLaneId()
	local sourceLaneCount = self:_resolveLaneSwitchLaneCount()
	local transform = self._transform
	local landingStartX, landingStartY, landingStartZ = transformhelper.getPos(transform)
	local stableTrack = self._stableTrackForward
	local landingStartForwardX, landingStartForwardY, landingStartForwardZ

	if stableTrack and stableTrack.sqrMagnitude > 0.001 then
		local sx, sy, sz = stableTrack.x, stableTrack.y, stableTrack.z
		local inv = 1 / math.sqrt(sx * sx + sy * sy + sz * sz)

		landingStartForwardZ = sz * inv
		landingStartForwardY = sy * inv
		landingStartForwardX = sx * inv
	else
		landingStartForwardX, landingStartForwardY, landingStartForwardZ = transformhelper.getForward(transform)
	end

	if not slope.cameraId then
		local landingCameraProfileId = 0

		self._activeSnowSlopeRoute = nil
		self._activeLayeredRoute = self._snowSlopeRecoverRoute
		self._activeRouteShortcut = nil
		self._routeShortcutReturnPath = nil

		if self._activeLayeredRoute == nil then
			self._activeRouteMainBaseDistance = 0
			self._activeRouteLocalBaseDistance = 0
			self._trackPath = self._mainTrackPath
		else
			self._activeRouteMainBaseDistance = mainEquivalent
			self._activeRouteLocalBaseDistance = math.max(0, slope.toDistance or 0)
			self._trackPath = self._snowSlopeRecoverPath
		end

		self._trackDistance = Mathf.Clamp(slope.toDistance, self._trackPath:getStartDistance(), self._trackPath:getEndDistance())

		local laneCount = self:_resolveLaneSwitchLaneCount()
		local snowSlopeTargetLaneId = SnowSlope.ResolveExitTargetLaneId(slope, sourceLaneId, laneCount)
		local targetLaneId = snowSlopeTargetLaneId or self:_mapLaneIdByRatio(sourceLaneId, sourceLaneCount, laneCount, slope.toLaneId)
		local laneIndex = LRRU.CsLaneIdToLuaIndex(targetLaneId, laneCount)

		self._lateralOffset = self._trackPath:LaneToLateralOffset(laneIndex, laneCount)
		self._laneSwitchTargetLateral = self._lateralOffset
		self._laneSwitchActive = false
		self._lateralVelocity = 0

		local pose = self._trackPath:Sample(self._trackDistance, self._lateralOffset)
		local landingTargetX = pose.position.x
		local landingTargetY = self:_resolveRideHeight() + self:_resolveItemFlightOffset()
		local landingTargetZ = pose.position.y
		local landingTangentX, landingTangentZ = pose.tangent.x, pose.tangent.y
		local landingTangentSqr = landingTangentX * landingTangentX + landingTangentZ * landingTangentZ
		local landingTargetForwardX, landingTargetForwardY, landingTargetForwardZ

		if landingTangentSqr > 0.001 then
			local inv = 1 / math.sqrt(landingTangentSqr)

			landingTargetForwardZ = landingTangentZ * inv
			landingTargetForwardY = 0
			landingTargetForwardX = landingTangentX * inv
		else
			landingTargetForwardZ = landingStartForwardZ
			landingTargetForwardY = landingStartForwardY
			landingTargetForwardX = landingStartForwardX
		end

		SetVec3(self._snowSlopeLandingStartPosition, landingStartX, landingStartY, landingStartZ)
		SetVec3(self._snowSlopeLandingTargetPosition, landingTargetX, landingTargetY, landingTargetZ)
		SetVec3(self._snowSlopeLandingStartForward, landingStartForwardX, landingStartForwardY, landingStartForwardZ)
		SetVec3(self._snowSlopeLandingTargetForward, landingTargetForwardX, landingTargetForwardY, landingTargetForwardZ)

		self._snowSlopeLandingBaseDistance = self._trackDistance
		self._snowSlopeLandingTargetDistance = self._trackDistance
		self._snowSlopeLandingTargetLateral = self._lateralOffset
		self._snowSlopeLandingElapsedSec = 0
		self._snowSlopeLandingCameraProfileId = landingCameraProfileId
		self._snowSlopeLandingBlendDurationSec = SnowSlope.ResolveExitBlendDurationSec(slope)
		self._snowSlopeLandingBlendRemainingSec = self._snowSlopeLandingBlendDurationSec
		self._snowSlopeLandingBlendActive = self._snowSlopeLandingBlendDurationSec > 0

		SetVec3(self._stableTrackForward, landingStartForwardX, landingStartForwardY, landingStartForwardZ)
		SetVec3(self._cameraTrackForward, landingStartForwardX, landingStartForwardY, landingStartForwardZ)

		self._snowSlopeRecoverRoute = nil
		self._snowSlopeRecoverPath = nil
		self._snowSlopeHeightBaseOffset = 0
		self._snowSlopeRoadFrames3D = nil
		self._snowSlopeRoadPose3D = nil
		self._snowSlopeSlideDirection = 0
		self._snowSlopeSlideVelocity = 0
		self._routeTransferProjectionLockRemainingSec = 0.25
		self._laneSwitchCooldownRemainingSec = self:_resolveLaneSwitchCooldownSec()
		self._hasTrackState = true
	end
end

function PlayerVehicleController:_moveSnowSlopeLandingBlend(deltaTime, damping)
	if not self._snowSlopeLandingBlendActive or not self._trackPath or not self._trackPath:getIsValid() then
		self._snowSlopeLandingBlendActive = false
		self._snowSlopeLandingBlendRemainingSec = 0
		self._snowSlopeLandingCameraProfileId = 0

		return
	end

	local duration = math.max(0.0001, self._snowSlopeLandingBlendDurationSec)

	self._snowSlopeLandingElapsedSec = math.min(duration, (self._snowSlopeLandingElapsedSec or 0) + math.max(0, deltaTime))

	local eased = SnowSlope.ResolveExitBlendProgress(self._snowSlopeLandingElapsedSec, duration)
	local movingDistance = Mathf.Clamp((self._snowSlopeLandingBaseDistance or self._snowSlopeLandingTargetDistance) + math.max(0, self._forwardSpeed or 0) * self._snowSlopeLandingElapsedSec, self._trackPath:getStartDistance(), self._trackPath:getEndDistance())
	local movingPose = self._poseCache

	self._trackPath:SampleTo(movingDistance, self._snowSlopeLandingTargetLateral, movingPose)

	self._snowSlopeLandingTargetDistance = movingDistance

	local landingTargetPosition = self._snowSlopeLandingTargetPosition

	SetVec3(landingTargetPosition, movingPose.position.x, self:_resolveRideHeight() + self:_resolveItemFlightOffset(), movingPose.position.y)

	local movingTangentX, movingTangentZ = movingPose.tangent.x, movingPose.tangent.y
	local movingTangentSqr = movingTangentX * movingTangentX + movingTangentZ * movingTangentZ

	if movingTangentSqr > 0.001 then
		local inv = 1 / math.sqrt(movingTangentSqr)

		SetVec3(self._snowSlopeLandingTargetForward, movingTangentX * inv, 0, movingTangentZ * inv)
	end

	local transform = self._transform
	local prevX, prevY, prevZ = transformhelper.getPos(transform)
	local landingStartPosition = self._snowSlopeLandingStartPosition
	local nextX = landingStartPosition.x + (landingTargetPosition.x - landingStartPosition.x) * eased
	local nextY = landingStartPosition.y + (landingTargetPosition.y - landingStartPosition.y) * eased
	local nextZ = landingStartPosition.z + (landingTargetPosition.z - landingStartPosition.z) * eased

	transformhelper.setPos(transform, nextX, nextY, nextZ)

	self._trackDistance = Mathf.Lerp(self._snowSlopeLandingBaseDistance, self._snowSlopeLandingTargetDistance, eased)
	self._lateralOffset = self._snowSlopeLandingTargetLateral
	self._laneSwitchTargetLateral = self._lateralOffset
	self._laneSwitchActive = false
	self._lateralVelocity = 0

	local landingStartForward = self._snowSlopeLandingStartForward
	local landingTargetForward = self._snowSlopeLandingTargetForward
	local desiredX, desiredY, desiredZ = SlerpUnitVec3(landingStartForward.x, landingStartForward.y, landingStartForward.z, landingTargetForward.x, landingTargetForward.y, landingTargetForward.z, eased)
	local horizontalVelocity = self:_resolveHorizontalVelocity(prevX, prevZ, nextX, nextZ, deltaTime)

	self:_updateEstimatedHorizontalVelocity(prevX, prevZ, nextX, nextZ, deltaTime)
	self:_updateVehicleOrientation(SetVec3(_forwardCache, desiredX, desiredY, desiredZ), horizontalVelocity, damping, deltaTime)

	if desiredX * desiredX + desiredY * desiredY + desiredZ * desiredZ > 0.001 then
		SetVec3(self._cameraTrackForward, desiredX, desiredY, desiredZ)
	else
		SetVec3(self._cameraTrackForward, landingTargetForward.x, landingTargetForward.y, landingTargetForward.z)
	end

	self._snowSlopeLandingBlendRemainingSec = math.max(0, self._snowSlopeLandingBlendRemainingSec - deltaTime)

	if self._snowSlopeLandingBlendRemainingSec > 0 then
		return
	end

	self._snowSlopeLandingBlendActive = false
	self._snowSlopeLandingBlendRemainingSec = 0

	transformhelper.setPos(transform, landingTargetPosition.x, landingTargetPosition.y, landingTargetPosition.z)

	self._trackDistance = self._snowSlopeLandingTargetDistance
	self._lateralOffset = self._snowSlopeLandingTargetLateral
	self._laneSwitchTargetLateral = self._lateralOffset

	local finalForward = self._snowSlopeLandingTargetForward

	SetVec3(self._stableTrackForward, finalForward.x, finalForward.y, finalForward.z)
	SetVec3(self._cameraTrackForward, finalForward.x, finalForward.y, finalForward.z)
	SetVec3(self._smoothedVisualForward, finalForward.x, finalForward.y, finalForward.z)

	self._visualForwardDampVelX, self._visualForwardDampVelY, self._visualForwardDampVelZ = 0, 0, 0
	self._snowSlopeLandingCameraProfileId = 0
	self._hasTrackState = true
end

function PlayerVehicleController:_evaluateWaterfallClimbPoint(t, laneFloat, outPosition, outTangent)
	local climb = self._activeWaterfallClimbRoute

	if not climb then
		return SetVec3(outPosition or Vector3(0, 0, 0), 0, 0, 0), SetVec3(outTangent or Vector3(0, 1, 0), 0, 1, 0)
	end

	local laneCount = math.max(1, climb.laneCount or 1)
	local laneWidth = math.max(0.01, (not climb.laneWidth or nil) and 8)
	local radius = math.max(0.1, (not climb.radius or nil) and 8)
	local startAngle = math.rad(climb.startAngleDeg or 0)
	local twistAngle = math.rad(climb.twistAngleDeg or 0)
	local centerLane = (laneCount - 1) * 0.5
	local arcOffset = (laneFloat - centerLane) * (laneWidth / radius)
	local angle = startAngle + twistAngle * t + arcOffset
	local x = climb.centerX + math.cos(angle) * radius
	local z = climb.centerZ + math.sin(angle) * radius
	local y = Mathf.Lerp(climb.startY or 0, climb.endY or 0, t)
	local eps = 0.005
	local t2 = math.min(1, t + eps)
	local angle2 = startAngle + twistAngle * t2 + arcOffset
	local x2 = climb.centerX + math.cos(angle2) * radius
	local z2 = climb.centerZ + math.sin(angle2) * radius
	local y2 = Mathf.Lerp(climb.startY or 0, climb.endY or 0, t2)
	local tx, ty, tz = x2 - x, y2 - y, z2 - z
	local tangentSqr = tx * tx + ty * ty + tz * tz

	if tangentSqr <= 0.0001 then
		tz = 0
		ty = 1
		tx = 0
	else
		local inv = 1 / math.sqrt(tangentSqr)

		tz = tz * inv
		ty = ty * inv
		tx = tx * inv
	end

	return SetVec3(outPosition or Vector3(x, y, z), x, y, z), SetVec3(outTangent or Vector3(tx, ty, tz), tx, ty, tz)
end

function PlayerVehicleController:_updateWaterfallClimbOrientation(tangent, radial, deltaTime, usePathTangent, visualUpOverride)
	local transform = self._transform
	local visualForward = SetVec3(_waterfallVisualForwardCache, 0, 1, 0)

	if usePathTangent and tangent then
		local tx, ty, tz = tangent.x, tangent.y, tangent.z
		local sqr = tx * tx + ty * ty + tz * tz

		if sqr > 0.0001 then
			local inv = 1 / math.sqrt(sqr)

			visualForward = SetVec3(_waterfallVisualForwardCache, tx * inv, ty * inv, tz * inv)
		end
	end

	local visualUp = SetVec3(_waterfallVisualUpCache, 0, 0, 1)
	local useRadialFallback = true

	if visualUpOverride then
		local ux, uy, uz = visualUpOverride.x, visualUpOverride.y, visualUpOverride.z
		local sqr = ux * ux + uy * uy + uz * uz

		if sqr > 0.0001 then
			local inv = 1 / math.sqrt(sqr)

			visualUp = SetVec3(_waterfallVisualUpCache, ux * inv, uy * inv, uz * inv)
			useRadialFallback = false
		end
	end

	if useRadialFallback and radial then
		local ux, uy, uz = radial.x, radial.y, radial.z
		local sqr = ux * ux + uy * uy + uz * uz

		if sqr > 0.0001 then
			local inv = 1 / math.sqrt(sqr)

			visualUp = SetVec3(_waterfallVisualUpCache, ux * inv, uy * inv, uz * inv)
		end
	end

	local flatX, flatY, flatZ = FlatForwardXYZ(visualForward.x, visualForward.z)

	SetVec3(self._stableTrackForward, flatX, flatY, flatZ)
	SetVec3(self._smoothedVisualForward, flatX, flatY, flatZ)
	SetVec3(self._cameraTrackForward, visualForward.x, visualForward.y, visualForward.z)

	self._visualForwardDampVelX, self._visualForwardDampVelY, self._visualForwardDampVelZ = 0, 0, 0

	local targetX, targetY, targetZ, targetW = LookRotationQuaternionXYZW(visualForward.x, visualForward.y, visualForward.z, visualUp.x, visualUp.y, visualUp.z)
	local var_253_0 = self._waterfallClimbOrientationX

	if not self._waterfallClimbOrientationX then
		var_253_0 = self._waterfallClimbEntryStartRotationX

		if not self._waterfallClimbEntryStartRotationX then
			local currentX = 0
			local var_253_1 = self._waterfallClimbOrientationY

			if not self._waterfallClimbOrientationY then
				var_253_1 = self._waterfallClimbEntryStartRotationY

				if not self._waterfallClimbEntryStartRotationY then
					local currentY = 0
					local var_253_2 = self._waterfallClimbOrientationZ

					if not self._waterfallClimbOrientationZ then
						var_253_2 = self._waterfallClimbEntryStartRotationZ

						if not self._waterfallClimbEntryStartRotationZ then
							local currentZ = 0
							local var_253_3 = self._waterfallClimbOrientationW

							if not self._waterfallClimbOrientationW then
								var_253_3 = self._waterfallClimbEntryStartRotationW

								if not self._waterfallClimbEntryStartRotationW then
									local currentW = 1

									if self._waterfallClimbEntryCurve and usePathTangent then
										local currentForwardX, currentForwardY, currentForwardZ = transformhelper.getForward(transform)
										local currentForwardSqr = currentForwardX * currentForwardX + currentForwardY * currentForwardY + currentForwardZ * currentForwardZ

										if currentForwardSqr > 0.0001 then
											local inv = 1 / math.sqrt(currentForwardSqr)

											currentForwardZ = currentForwardZ * inv
											currentForwardY = currentForwardY * inv
											currentForwardX = currentForwardX * inv
										else
											currentForwardZ = visualForward.z
											currentForwardY = visualForward.y
											currentForwardX = visualForward.x
										end

										local transportedX, transportedY, transportedZ, transportedW
										local forwardDot = currentForwardX * visualForward.x + currentForwardY * visualForward.y + currentForwardZ * visualForward.z

										if forwardDot <= WaterfallClimbEntryReverseDotThreshold then
											do
												local upX, upY, upZ = QuaternionUpXYZ(currentX, currentY, currentZ, currentW)
												local halfX, halfY, halfZ, halfW = MultiplyQuaternionXYZW(upX, upY, upZ, 0, currentX, currentY, currentZ, currentW)

												halfX, halfY, halfZ, halfW = NormalizeQuaternionXYZW(halfX, halfY, halfZ, halfW)

												local halfForwardX, halfForwardY, halfForwardZ = QuaternionForwardXYZ(halfX, halfY, halfZ, halfW)
												local deltaX, deltaY, deltaZ, deltaW = FromToQuaternionXYZW(halfForwardX, halfForwardY, halfForwardZ, visualForward.x, visualForward.y, visualForward.z)

												transportedX, transportedY, transportedZ, transportedW = MultiplyQuaternionXYZW(deltaX, deltaY, deltaZ, deltaW, halfX, halfY, halfZ, halfW)
											end
										else
											do
												local deltaX, deltaY, deltaZ, deltaW = FromToQuaternionXYZW(currentForwardX, currentForwardY, currentForwardZ, visualForward.x, visualForward.y, visualForward.z)

												transportedX, transportedY, transportedZ, transportedW = MultiplyQuaternionXYZW(deltaX, deltaY, deltaZ, deltaW, currentX, currentY, currentZ, currentW)
											end
										end

										local entryProgress = Mathf.Clamp01(self._waterfallClimbEntryCurveProgress or 0)
										local radialAlign01 = Mathf.Clamp01((entryProgress - WaterfallClimbEntryRadialAlignStart01) / math.max(0.001, 1 - WaterfallClimbEntryRadialAlignStart01))
										local radialAlignWeight = self:_smoothStep(0, 1, radialAlign01)
										local resultX, resultY, resultZ, resultW = SlerpQuaternionXYZW(transportedX, transportedY, transportedZ, transportedW, targetX, targetY, targetZ, targetW, radialAlignWeight)

										ApplyWaterfallRotation(self, transform, resultX, resultY, resultZ, resultW)

										return
									end

									if self._waterfallClimbEntryOrientationBlendRemainingSec > 0 then
										local duration = math.max(0.0001, WaterfallClimbEntryOrientationBlendSec)
										local t = Mathf.Clamp01(1 - self._waterfallClimbEntryOrientationBlendRemainingSec / duration)
										local eased = self:_smoothStep(0, 1, t)
										local resultX, resultY, resultZ, resultW = SlerpQuaternionXYZW(self._waterfallClimbEntryStartRotationX or currentX, self._waterfallClimbEntryStartRotationY or currentY, self._waterfallClimbEntryStartRotationZ or currentZ, self._waterfallClimbEntryStartRotationW or currentW, targetX, targetY, targetZ, targetW, eased)

										ApplyWaterfallRotation(self, transform, resultX, resultY, resultZ, resultW)

										self._waterfallClimbEntryOrientationBlendRemainingSec = math.max(0, self._waterfallClimbEntryOrientationBlendRemainingSec - deltaTime)

										return
									end

									local resultX, resultY, resultZ, resultW = SlerpQuaternionXYZW(currentX, currentY, currentZ, currentW, targetX, targetY, targetZ, targetW, Mathf.Clamp(WaterfallClimbOrientationFollowRate * math.max(0, deltaTime), 0, 1))

									ApplyWaterfallRotation(self, transform, resultX, resultY, resultZ, resultW)
								end
							end
						end
					end
				end
			end
		end
	end
end

function PlayerVehicleController:_applyWaterfallClimbPose(position, tangent, visualUp, deltaTime, usePathTangent)
	local climb = self._activeWaterfallClimbRoute

	if not climb then
		return
	end

	local transform = self._transform
	local prevX, prevY, prevZ = transformhelper.getPos(transform)

	transformhelper.setPos(transform, position.x, position.y, position.z)

	local radial = SetVec3(_waterfallRadialCache, position.x - (climb.centerX or 0), 0, position.z - (climb.centerZ or 0))

	self:_updateWaterfallClimbOrientation(tangent, radial, deltaTime, usePathTangent, visualUp)
	self:_updateEstimatedHorizontalVelocity(prevX, prevZ, position.x, position.z, deltaTime)
	SetVec3(self._waterfallClimbCameraAnchorPosition, position.x, position.y, position.z)

	self._waterfallClimbCameraLookTargetPosition = WaterfallClimb.ResolveCameraLookTarget(climb, position, self._waterfallClimbProgress, self._waterfallClimbEntryCurve ~= nil, self._waterfallClimbCameraLookTargetPosition)

	local cameraEntryBlend = WaterfallClimb.ResolveCameraEntryBlend(self._waterfallClimbEntryCurve ~= nil, self._waterfallClimbEntryCurveProgress)
	local exitCameraPreviewBlend = WaterfallClimb.ResolveExitCameraPreviewBlend(self._waterfallClimbProgress, climb.climbLength, self._waterfallClimbEntryCurve ~= nil)

	if exitCameraPreviewBlend > 0 and radial.sqrMagnitude > 0.0001 then
		local radialInv = 1 / math.sqrt(radial.sqrMagnitude)
		local safeExitForwardX = -radial.x * radialInv
		local safeExitForwardY = -radial.y * radialInv
		local safeExitForwardZ = -radial.z * radialInv
		local camForward = self._cameraTrackForward

		SetVec3(camForward, SlerpUnitVec3(camForward.x, camForward.y, camForward.z, safeExitForwardX, safeExitForwardY, safeExitForwardZ, exitCameraPreviewBlend))
	end

	local cameraOffsetX, cameraOffsetY, cameraOffsetZ = 0, WaterfallClimb.ResolveExitCameraLift(exitCameraPreviewBlend), 0

	if radial.sqrMagnitude > 0.0001 then
		local radialInv = 1 / math.sqrt(radial.sqrMagnitude)
		local outwardScale = math.max(0, (not climb.cameraOutwardOffset or nil) and WaterfallClimbCameraOutwardOffset) * cameraEntryBlend

		cameraOffsetX = cameraOffsetX + radial.x * radialInv * outwardScale
		cameraOffsetY = cameraOffsetY + radial.y * radialInv * outwardScale
		cameraOffsetZ = cameraOffsetZ + radial.z * radialInv * outwardScale
	end

	SetVec3(self._waterfallClimbCameraPositionOffset, cameraOffsetX, cameraOffsetY, cameraOffsetZ)
end

function PlayerVehicleController:_moveWaterfallClimb(deltaTime)
	local climb = self._activeWaterfallClimbRoute

	if not climb then
		return
	end

	local entryCurve = self._waterfallClimbEntryCurve

	if entryCurve then
		local currentProgress = Mathf.Clamp01(self._waterfallClimbEntryCurveProgress or 0)
		local currentTangent = WaterfallClimb.EvaluateEntryCurveTangentInto(entryCurve, currentProgress, _waterfallTangentResult)

		if currentTangent then
			if not currentTangent.y then
				local slopeUpDot = 0
				local speed = WaterfallClimb.ResolveClimbSpeed(climb, self._forwardSpeed, self:getBaseSpeed(), self._waterfallClimbTravelSpeed, slopeUpDot, deltaTime)

				self._waterfallClimbTravelSpeed = speed
				currentProgress = Mathf.Clamp01(currentProgress + speed * deltaTime / math.max(0.01, entryCurve.length or 0.01))
				self._waterfallClimbEntryCurveProgress = currentProgress
				self._waterfallClimbProgress = Mathf.Lerp(0, self._waterfallClimbEntryJoinProgress or 0, currentProgress)

				local position, tangent, visualUp = WaterfallClimb.EvaluateEntryCurveInto(entryCurve, currentProgress, _waterfallPositionResult, _waterfallTangentResult, _waterfallCurveUpResult)

				self:_applyWaterfallClimbPose(position, tangent, visualUp, deltaTime, true)

				if currentProgress >= 1 then
					self._waterfallClimbEntryCurve = nil
					self._waterfallClimbProgress = Mathf.Clamp01(self._waterfallClimbEntryJoinProgress or 0)
				end

				return
			end
		end
	end

	self._waterfallClimbTargetLaneFloat = self._waterfallClimbLaneFloat
	self._previousGlideHorizontalInput = 0

	local _, currentTangent = self:_evaluateWaterfallClimbPoint(self._waterfallClimbProgress, self._waterfallClimbLaneFloat, _waterfallPositionResult, _waterfallTangentResult)

	if currentTangent then
		if not currentTangent.y then
			local slopeUpDot = 1
			local speed = WaterfallClimb.ResolveClimbSpeed(climb, self._forwardSpeed, self:getBaseSpeed(), self._waterfallClimbTravelSpeed, slopeUpDot, deltaTime)

			self._waterfallClimbTravelSpeed = speed

			local length = math.max(0.01, climb.climbLength or 130)

			self._waterfallClimbProgress = Mathf.Clamp01(self._waterfallClimbProgress + speed * deltaTime / length)

			local pos, tangent = self:_evaluateWaterfallClimbPoint(self._waterfallClimbProgress, self._waterfallClimbLaneFloat, _waterfallPositionResult, _waterfallTangentResult)

			self:_applyWaterfallClimbPose(pos, tangent, nil, deltaTime, false)

			if self._waterfallClimbProgress >= 1 then
				self:_completeWaterfallClimbRoute()
			end
		end
	end
end

function PlayerVehicleController:_completeWaterfallClimbRoute()
	local climb = self._activeWaterfallClimbRoute

	if not climb then
		return
	end

	local mainEquivalent = self:_resolveCurrentLapRaceDistance()
	local transform = self._transform
	local exitStartPosX, exitStartPosY, exitStartPosZ = transformhelper.getPos(transform)
	local exitStartForwardX, exitStartForwardY, exitStartForwardZ = 0, 1, 0
	local ctf = self._cameraTrackForward

	if ctf then
		local m2 = ctf.x * ctf.x + ctf.y * ctf.y + ctf.z * ctf.z

		if m2 > 0.001 then
			local inv = 1 / math.sqrt(m2)

			exitStartForwardZ = ctf.z * inv
			exitStartForwardY = ctf.y * inv
			exitStartForwardX = ctf.x * inv
		end
	end

	SetVec3(self._waterfallClimbExitCameraPositionOffset, self._waterfallClimbCameraPositionOffset.x, self._waterfallClimbCameraPositionOffset.y, self._waterfallClimbCameraPositionOffset.z)
	SetVec3(self._waterfallClimbExitCameraLookOffset, self._waterfallClimbCameraLookTargetPosition.x - exitStartPosX, self._waterfallClimbCameraLookTargetPosition.y - exitStartPosY, self._waterfallClimbCameraLookTargetPosition.z - exitStartPosZ)

	self._forwardSpeed = WaterfallClimb.ResolveExitForwardSpeed(self._forwardSpeed, self:getBaseSpeed(), self._waterfallClimbTravelSpeed)
	self._activeWaterfallClimbRoute = nil
	self._activeLayeredRoute = self._waterfallClimbRecoverRoute
	self._activeRouteShortcut = nil
	self._routeShortcutReturnPath = nil

	if self._activeLayeredRoute == nil then
		self._activeRouteMainBaseDistance = 0
		self._activeRouteLocalBaseDistance = 0
		self._trackPath = self._mainTrackPath
	else
		self._activeRouteMainBaseDistance = mainEquivalent
		self._activeRouteLocalBaseDistance = math.max(0, climb.toDistance or 0)
		self._trackPath = self._waterfallClimbRecoverPath
	end

	self._trackDistance = Mathf.Clamp(climb.toDistance, self._trackPath:getStartDistance(), self._trackPath:getEndDistance())

	local laneCount = self:_resolveLaneSwitchLaneCount()
	local targetLaneId = math.max(1, math.min((not climb.toLaneId or nil) and 1, laneCount))
	local laneIndex = LRRU.CsLaneIdToLuaIndex(targetLaneId, laneCount)

	self._lateralOffset = self._trackPath:LaneToLateralOffset(laneIndex, laneCount)
	self._laneSwitchTargetLateral = self._lateralOffset
	self._laneSwitchActive = false
	self._lateralVelocity = 0

	local pose = self._trackPath:Sample(self._trackDistance, self._lateralOffset)
	local exitTargetPosX = pose.position.x
	local exitTargetPosY = self:_resolveRideHeight() + self:_resolveItemFlightOffset()
	local exitTargetPosZ = pose.position.y
	local exitTargetForwardX = pose.tangent.x
	local exitTargetForwardZ = pose.tangent.y
	local etfLen2 = exitTargetForwardX * exitTargetForwardX + exitTargetForwardZ * exitTargetForwardZ

	if etfLen2 > 0.001 then
		local etfInv = 1 / math.sqrt(etfLen2)

		exitTargetForwardZ = exitTargetForwardZ * etfInv
		exitTargetForwardX = exitTargetForwardX * etfInv
	else
		local stable = self:getStableForward()

		exitTargetForwardZ = stable.z
		exitTargetForwardX = stable.x
	end

	self._waterfallClimbBackFacingExitCameraDelayActive = WaterfallClimb.ShouldDelayBackFacingExitCamera(exitStartForwardX, exitStartForwardZ, exitTargetForwardX, exitTargetForwardZ)

	SetVec3(self._waterfallClimbExitCameraFollowStartPosition, exitStartPosX, exitStartPosY, exitStartPosZ)
	SetVec3(self._waterfallClimbExitFlightStartPosition, exitStartPosX, exitStartPosY, exitStartPosZ)
	SetVec3(self._waterfallClimbExitFlightTargetPosition, exitTargetPosX, exitTargetPosY, exitTargetPosZ)
	SetVec3(self._waterfallClimbExitFlightStartForward, exitStartForwardX, exitStartForwardY, exitStartForwardZ)
	SetVec3(self._waterfallClimbExitFlightTargetForward, exitTargetForwardX, 0, exitTargetForwardZ)

	self._waterfallClimbExitFlightDurationSec = WaterfallClimb.ResolveExitFlightDuration()
	self._waterfallClimbExitFlightRemainingSec = self._waterfallClimbExitFlightDurationSec
	self._waterfallClimbCameraExitBlendDurationSec = WaterfallClimb.ResolveCameraExitDuration(self._waterfallClimbExitFlightDurationSec, exitStartForwardX, exitStartForwardZ, exitTargetForwardX, exitTargetForwardZ, climb.exitCameraTurnSpeedDegPerSec)
	self._waterfallClimbCameraExitBlendRemainingSec = self._waterfallClimbCameraExitBlendDurationSec
	self._waterfallClimbExitFlightCameraProfileId = climb.cameraId or 0
	self._waterfallClimbExitFlightActive = true
	self._airborneForwardRollAngleDeg = 0
	self._waterfallClimbRecoverRoute = nil
	self._waterfallClimbRecoverPath = nil
	self._waterfallClimbEntryCurve = nil
	self._waterfallClimbEntryCurveProgress = 0
	self._waterfallClimbEntryJoinProgress = 0
	self._waterfallClimbEntryMainDistance = 0
	self._waterfallClimbTravelSpeed = 0
	self._waterfallClimbProgress = 0
	self._waterfallClimbLaneFloat = 0
	self._waterfallClimbTargetLaneFloat = 0
	self._landingReattachForwardRollActive = false
	self._landingReattachRemainingSec = 0
	self._routeTransferProjectionLockRemainingSec = 0.25
	self._laneSwitchCooldownRemainingSec = self:_resolveLaneSwitchCooldownSec()
	self._hasTrackState = true
end

function PlayerVehicleController:_moveWaterfallClimbExitFlight(deltaTime, damping)
	if not self._waterfallClimbExitFlightActive then
		return
	end

	local duration = math.max(0.0001, self._waterfallClimbExitFlightDurationSec)
	local remaining = math.max(0, self._waterfallClimbExitFlightRemainingSec)
	local t = Mathf.Clamp01(1 - remaining / duration)
	local eased = self:_resolveShortcutJumpHorizontalProgress(t)
	local transform = self._transform
	local prevX, prevY, prevZ = transformhelper.getPos(transform)
	local startX, startY, startZ = self._waterfallClimbExitFlightStartPosition.x, self._waterfallClimbExitFlightStartPosition.y, self._waterfallClimbExitFlightStartPosition.z
	local targetX, targetY, targetZ = self._waterfallClimbExitFlightTargetPosition.x, self._waterfallClimbExitFlightTargetPosition.y, self._waterfallClimbExitFlightTargetPosition.z
	local nextX = startX + (targetX - startX) * eased
	local nextY = startY + (targetY - startY) * eased + math.sin(t * math.pi) * WaterfallClimbExitFlightArcHeight
	local nextZ = startZ + (targetZ - startZ) * eased

	transformhelper.setPos(transform, nextX, nextY, nextZ)

	local flightForwardX = targetX - startX
	local flightForwardY = targetY - startY
	local flightForwardZ = targetZ - startZ

	if flightForwardX * flightForwardX + flightForwardY * flightForwardY + flightForwardZ * flightForwardZ <= 0.001 then
		flightForwardZ = self._waterfallClimbExitFlightTargetForward.z
		flightForwardY = self._waterfallClimbExitFlightTargetForward.y
		flightForwardX = self._waterfallClimbExitFlightTargetForward.x
	end

	local cameraDuration = math.max(duration, self._waterfallClimbCameraExitBlendDurationSec or 0)
	local cameraElapsed = cameraDuration - math.max(0, (not self._waterfallClimbCameraExitBlendRemainingSec or nil) and 0)
	local cameraTurnBlend = WaterfallClimb.ResolveExitCameraTurnBlend(cameraElapsed, cameraDuration)
	local camFX, camFY, camFZ = SlerpUnitVec3(self._waterfallClimbExitFlightStartForward.x, self._waterfallClimbExitFlightStartForward.y, self._waterfallClimbExitFlightStartForward.z, self._waterfallClimbExitFlightTargetForward.x, self._waterfallClimbExitFlightTargetForward.y, self._waterfallClimbExitFlightTargetForward.z, cameraTurnBlend)

	if camFX * camFX + camFY * camFY + camFZ * camFZ <= 0.001 then
		camFZ = self._waterfallClimbExitFlightTargetForward.z
		camFY = self._waterfallClimbExitFlightTargetForward.y
		camFX = self._waterfallClimbExitFlightTargetForward.x
	end

	local horizontalVelocity = self:_resolveHorizontalVelocity(prevX, prevZ, nextX, nextZ, deltaTime)

	self:_updateEstimatedHorizontalVelocity(prevX, prevZ, nextX, nextZ, deltaTime)
	self:_updateVehicleOrientation(_forwardCache, horizontalVelocity, damping, deltaTime)
	SetVec3(self._cameraTrackForward, camFX, camFY, camFZ)

	self._waterfallClimbExitFlightRemainingSec = math.max(0, self._waterfallClimbExitFlightRemainingSec - deltaTime)

	if self._waterfallClimbExitFlightRemainingSec > 0 then
		return
	end

	self._waterfallClimbExitFlightActive = false
	self._waterfallClimbExitFlightRemainingSec = 0
	self._waterfallClimbExitFlightCameraProfileId = 0

	transformhelper.setPos(transform, targetX, targetY, targetZ)
	SetVec3(self._stableTrackForward, self._waterfallClimbExitFlightTargetForward.x, self._waterfallClimbExitFlightTargetForward.y, self._waterfallClimbExitFlightTargetForward.z)
	SetVec3(self._cameraTrackForward, self._stableTrackForward.x, self._stableTrackForward.y, self._stableTrackForward.z)
	SetVec3(self._smoothedVisualForward, self._stableTrackForward.x, self._stableTrackForward.y, self._stableTrackForward.z)

	self._visualForwardDampVelX, self._visualForwardDampVelY, self._visualForwardDampVelZ = 0, 0, 0
	self._hasTrackState = true
end

function PlayerVehicleController:_tryActivateLayeredRouteTerminalExit()
	if not self._activeLayeredRoute or self._activeRouteShortcut or self._activeLayeredRoute.isLoop or not self._trackPath or not self._trackPath:getIsValid() or self._trackDistance < self._trackPath:getEndDistance() - 0.01 then
		return false
	end

	local routeId = self._activeLayeredRoute.routeId
	local routeEnd = self._trackPath:getEndDistance()

	for _, drop in ipairs(self._waterDrops) do
		if self:_isTerminalRouteTrigger(routeId, routeEnd, drop and drop.fromRouteId, drop and drop.fromDistance, drop and drop.triggerDistanceTolerance) and self:tryActivateAirWaterDrop(drop.triggerElementId) then
			return true
		end
	end

	for _, glide in ipairs(self._glideRoutes) do
		if self:_isTerminalRouteTrigger(routeId, routeEnd, glide and glide.fromRouteId, glide and glide.fromDistance, glide and glide.triggerDistanceTolerance) and self:tryActivateGlide(glide.triggerElementId) then
			return true
		end
	end

	for _, underwater in ipairs(self._underwaterRoutes) do
		if self:_isTerminalRouteTrigger(routeId, routeEnd, underwater and underwater.fromRouteId, underwater and underwater.fromDistance, underwater and underwater.triggerDistanceTolerance) and self:tryActivateUnderwaterRoute(underwater.triggerElementId) then
			return true
		end
	end

	for _, slope in ipairs(self._snowSlopeRoutes) do
		if self:_isTerminalRouteTrigger(routeId, routeEnd, slope and slope.fromRouteId, slope and slope.fromDistance, slope and slope.triggerDistanceTolerance) and self:tryActivateSnowSlopeRoute(slope.triggerElementId) then
			return true
		end
	end

	for _, climb in ipairs(self._waterfallClimbRoutes) do
		if self:_isTerminalRouteTrigger(routeId, routeEnd, climb and climb.fromRouteId, climb and climb.fromDistance, climb and climb.triggerDistanceTolerance) and self:tryActivateWaterfallClimbRoute(climb.triggerElementId) then
			return true
		end
	end

	for _, transfer in ipairs(self._routeTransfers) do
		if self:_isTerminalRouteTrigger(routeId, routeEnd, transfer and transfer.fromRouteId, transfer and transfer.fromDistance, transfer and transfer.triggerDistanceTolerance) and self:tryActivateRouteTransfer(transfer.triggerElementId) then
			return true
		end
	end

	return false
end

function PlayerVehicleController:_isTerminalRouteTrigger(routeId, routeEnd, fromRouteId, fromDistance, tolerance)
	return routeId and fromRouteId and EqualsIgnoreCase(routeId, fromRouteId) and math.abs(routeEnd - (fromDistance or 0)) <= math.max(0.01, tolerance or 0)
end

function PlayerVehicleController:_executeRouteTransfer(transfer)
	local transform = self._transform
	local flightStartPosX, flightStartPosY, flightStartPosZ = transformhelper.getPos(transform)
	local entryMainDistance = self:_resolveCurrentLapRaceDistance()

	if EqualsIgnoreCase(transfer.toRouteId, LRRU.DolphinRouteIds.Main) then
		self._activeLayeredRoute = nil
		self._activeRouteShortcut = nil
		self._routeShortcutReturnPath = nil
		self._activeRouteMainBaseDistance = 0
		self._activeRouteLocalBaseDistance = 0
		self._trackPath = self._mainTrackPath
	else
		local targetRoute = LRRU.FindRoute(self._runtimeConfig, transfer.toRouteId)

		if not targetRoute then
			return false
		end

		if self._activeLayeredRoute == nil then
			if not self._trackDistance then
				self._activeLayeredRoute = targetRoute
				self._activeRouteShortcut = nil
				self._routeShortcutReturnPath = nil
				self._activeRouteMainBaseDistance = self:_resolveCurrentLapRaceDistance()
				self._activeRouteLocalBaseDistance = math.max(0, transfer.toDistance or 0)
				self._trackPath = TrackPath.FromConfig(targetRoute.path)

				if not self._trackPath:getIsValid() then
					return false
				end
			end
		end
	end

	self:_beginSpecialRaceDistanceFreeze(entryMainDistance)

	self._trackDistance = Mathf.Clamp(transfer.toDistance, self._trackPath:getStartDistance(), self._trackPath:getEndDistance())

	local laneCount = self:_resolveLaneSwitchLaneCount()
	local laneIndex = LRRU.CsLaneIdToLuaIndex(transfer.toLaneId, laneCount)

	self._lateralOffset = self._trackPath:LaneToLateralOffset(laneIndex, laneCount)
	self._laneSwitchTargetLateral = self._lateralOffset
	self._laneSwitchActive = false
	self._lateralVelocity = 0
	self._laneSwitchCooldownRemainingSec = self:_resolveLaneSwitchCooldownSec()
	self._shortcutJumpDurationSec = 0
	self._shortcutJumpRemainingSec = 0
	self._shortcutJumpHeight = 0
	self._routeTransferFlightHeight = math.max(0, transfer.flightHeightOffset or 4)

	SetVec3(self._routeTransferFlightStartPosition, flightStartPosX, flightStartPosY, flightStartPosZ)
	self._trackPath:SampleTo(self._trackDistance, self._lateralOffset, self._poseCache)

	local landingPose = self._poseCache

	SetVec3(self._routeTransferFlightTargetPosition, landingPose.position.x, self:_resolveRideHeight() + self:_resolveItemFlightOffset(), landingPose.position.y)

	local horizontalChordX = self._routeTransferFlightTargetPosition.x - flightStartPosX
	local horizontalChordZ = self._routeTransferFlightTargetPosition.z - flightStartPosZ
	local hcLen2 = horizontalChordX * horizontalChordX + horizontalChordZ * horizontalChordZ

	if hcLen2 > 0 then
		local hcInv = 1 / math.sqrt(hcLen2)

		horizontalChordZ = horizontalChordZ * hcInv
		horizontalChordX = horizontalChordX * hcInv
	else
		horizontalChordZ = 1
		horizontalChordX = 0
	end

	local startForwardX, startForwardZ

	if self._stableTrackForward and self._stableTrackForward.x * self._stableTrackForward.x + self._stableTrackForward.y * self._stableTrackForward.y + self._stableTrackForward.z * self._stableTrackForward.z > 0.001 then
		local sfLen2 = self._stableTrackForward.x * self._stableTrackForward.x + self._stableTrackForward.z * self._stableTrackForward.z

		if sfLen2 > 0 then
			local sfInv = 1 / math.sqrt(sfLen2)

			startForwardZ = self._stableTrackForward.z * sfInv
			startForwardX = self._stableTrackForward.x * sfInv
		else
			startForwardZ = horizontalChordZ
			startForwardX = horizontalChordX
		end
	else
		startForwardZ = horizontalChordZ
		startForwardX = horizontalChordX
	end

	local targetForwardX = landingPose.tangent.x
	local targetForwardZ = landingPose.tangent.y
	local tfLen2 = targetForwardX * targetForwardX + targetForwardZ * targetForwardZ

	if tfLen2 > 0.001 then
		local tfInv = 1 / math.sqrt(tfLen2)

		targetForwardZ = targetForwardZ * tfInv
		targetForwardX = targetForwardX * tfInv
	else
		targetForwardZ = horizontalChordZ
		targetForwardX = horizontalChordX
	end

	SetVec3(self._routeTransferFlightStartForward, startForwardX, 0, startForwardZ)
	SetVec3(self._routeTransferFlightTargetForward, targetForwardX, 0, targetForwardZ)

	local startApproachDot = Mathf.Clamp(startForwardX * horizontalChordX + startForwardZ * horizontalChordZ, -1, 1)
	local landingApproachDot = Mathf.Clamp(horizontalChordX * targetForwardX + horizontalChordZ * targetForwardZ, -1, 1)

	self._routeTransferUseAlignedCurve = RouteTransfer.ShouldUseAlignedHorizontalCurve(startApproachDot, landingApproachDot)

	if self._routeTransferUseAlignedCurve then
		local is105AlignedCurve = RouteTransfer.Is105Air001ToAir002Transfer(transfer)
		local hdx = self._routeTransferFlightTargetPosition.x - self._routeTransferFlightStartPosition.x
		local hdz = self._routeTransferFlightTargetPosition.z - self._routeTransferFlightStartPosition.z
		local horizontalFlightDistance = math.sqrt(hdx * hdx + hdz * hdz)
		local verticalFlightDistance = self._routeTransferFlightTargetPosition.y - self._routeTransferFlightStartPosition.y

		self._routeTransferFlightHeight = math.max(self._routeTransferFlightHeight, 8, horizontalFlightDistance * 0.08, math.abs(verticalFlightDistance) * 0.25)
		self._routeTransferFlightHeight = RouteTransfer.ResolveGenericAlignedFlightHeight(self._routeTransferUseAlignedCurve, verticalFlightDistance, self._routeTransferFlightHeight)
		self._routeTransferFlightHeight = RouteTransfer.ResolveAlignedFlightHeight(self._routeTransferUseAlignedCurve, self._routeTransferFlightHeight)
		self._routeTransferFlightDurationSec = RouteTransfer.ResolveFlightDuration(transfer.flightDurationSec, horizontalFlightDistance, verticalFlightDistance)
		self._routeTransferFlightRemainingSec = self._routeTransferFlightDurationSec

		if self._controlConfig and self._controlConfig.airborneForwardRollDegreesPerSecond > 0 then
			if not self._controlConfig.airborneForwardRollDegreesPerSecond then
				local authoredRollSpeed = 540

				self._routeTransferFlightRollTotalDeg = RouteTransfer.ResolveForwardRollTotalDegrees(self._routeTransferFlightDurationSec, authoredRollSpeed)
				self._airborneForwardRollAngleDeg = 0

				SetVec3(self._routeTransferFlightSmoothedForward, self._routeTransferFlightStartForward.x, self._routeTransferFlightStartForward.y, self._routeTransferFlightStartForward.z)
				SetVec3(self._specialRouteSmoothedForward, self._routeTransferFlightStartForward.x, self._routeTransferFlightStartForward.y, self._routeTransferFlightStartForward.z)
				SetVec3(self._specialRouteForwardDampVelocity, 0, 0, 0)

				self._jumpClearGraceRemainingSec = math.max(self._jumpClearGraceRemainingSec, self:_resolveJumpClearLandingGraceSec())
				self._landingReattachRemainingSec = 0
				self._airborneMotionActive = false
				self._hasTrackState = true

				return true
			end
		end
	end
end

function PlayerVehicleController:tryActivateRouteTransfer(triggerElementId)
	if not self._trackPath or not self._trackPath:getIsValid() or self._activeNormalShortcut or self._activeRouteShortcut or self._activeUnderwaterRoute or self._activeSnowSlopeRoute or self:_isAirborneHandlingActive() then
		return false
	end

	if self._activeLayeredRoute then
		if not self._activeLayeredRoute.routeId then
			local fromRouteId = LRRU.DolphinRouteIds.Main
			local currentLaneId = self:_resolveCurrentRouteLaneId()
			local transfer = LRRU.FindTransfer(self._runtimeConfig, fromRouteId, triggerElementId, self._trackDistance, currentLaneId, math.max(8, self._forwardSpeed * 0.35))

			if not transfer then
				return false
			end

			return self:_executeRouteTransfer(transfer)
		end
	end
end

function PlayerVehicleController:getCurrentRouteId()
	if self._activeNormalShortcut then
		return self._activeNormalShortcut.shortcutId
	end

	if self._activeRouteShortcut then
		return self._activeRouteShortcut.shortcutId
	end

	if self._activeLayeredRoute then
		return self._activeLayeredRoute.routeId
	end

	if self._activeGlideRoute then
		return self._activeGlideRoute.glideId
	end

	if self._activeUnderwaterRoute then
		return self._activeUnderwaterRoute.underwaterId
	end

	if self._activeSnowSlopeRoute then
		return self._activeSnowSlopeRoute.slopeId
	end

	if self._activeWaterfallClimbRoute then
		return self._activeWaterfallClimbRoute.climbId
	end

	if self._activeWaterDrop then
		return self._activeWaterDrop.dropId
	end

	return LRRU.DolphinRouteIds.Main
end

function PlayerVehicleController:getNormalizedRouteId()
	local routeId = self:getCurrentRouteId()

	if not routeId or routeId == "" or routeId == "Main" then
		return "main"
	end

	return string.lower(routeId)
end

function PlayerVehicleController:getCurrentMainShortcutExitDistance()
	local shortcut = self._activeNormalShortcut

	if shortcut then
		return shortcut.exitMainDistance
	end

	if self._aerialShortcutExitFlightActive and self._aerialShortcutExitRecoverRoute == nil then
		return self._aerialShortcutExitTargetDistance
	end

	return nil
end

function PlayerVehicleController:isOnLayeredRoute()
	return self._activeLayeredRoute ~= nil or self._activeRouteShortcut ~= nil
end

function PlayerVehicleController:isGliding()
	return self._activeGlideRoute ~= nil or self._glideLandingBlendActive
end

function PlayerVehicleController:isWaterfallClimbing()
	return self._activeWaterfallClimbRoute ~= nil
end

function PlayerVehicleController:isWaterfallClimbCameraActive()
	local var_268_1

	if self._activeWaterfallClimbRoute == nil then
		if (self._waterfallClimbCameraExitBlendRemainingSec or 0) <= 0 then
			var_268_1 = false

			goto label_268_0
		end
	end

	::label_268_0::

	return true
end

function PlayerVehicleController:isAirWaterDropping()
	return self._activeWaterDrop ~= nil
end

function PlayerVehicleController:isUnderwater()
	return self._activeUnderwaterRoute ~= nil
end

function PlayerVehicleController:isOnSnowSlope()
	return self._activeSnowSlopeRoute ~= nil
end

function PlayerVehicleController:getCameraFollowPosition()
	if self._activeWaterfallClimbRoute then
		local px, py, pz = transformhelper.getPos(self._transform)

		return SetVec3(_cameraFollowResult, px, py, pz)
	end

	if (self._waterfallClimbCameraExitBlendRemainingSec or 0) > 0 then
		if self._waterfallClimbBackFacingExitCameraDelayActive then
			local elapsed = math.max(0, (self._waterfallClimbCameraExitBlendDurationSec or 0) - (self._waterfallClimbCameraExitBlendRemainingSec or 0))
			local followBlend = WaterfallClimb.ResolveBackFacingExitCameraFollowBlend(elapsed)
			local px, py, pz = transformhelper.getPos(self._transform)
			local fs = self._waterfallClimbExitCameraFollowStartPosition

			return SetVec3(_cameraFollowResult, fs.x + (px - fs.x) * followBlend, fs.y + (py - fs.y) * followBlend, fs.z + (pz - fs.z) * followBlend)
		end

		local px, py, pz = transformhelper.getPos(self._transform)

		return SetVec3(_cameraFollowResult, px, py, pz)
	end

	if self._activeGlideRoute then
		return self._glideCameraAnchorPosition
	end

	return nil
end

function PlayerVehicleController:getCameraPositionOffset()
	if self._activeWaterfallClimbRoute then
		return self._waterfallClimbCameraPositionOffset
	end

	if (self._waterfallClimbCameraExitBlendRemainingSec or 0) > 0 then
		local exitBlend

		if self._waterfallClimbBackFacingExitCameraDelayActive then
			local elapsed = math.max(0, (self._waterfallClimbCameraExitBlendDurationSec or 0) - (self._waterfallClimbCameraExitBlendRemainingSec or 0))

			exitBlend = WaterfallClimb.ResolveBackFacingExitCameraCompositionBlend(elapsed, self._waterfallClimbCameraExitBlendDurationSec)
		else
			exitBlend = WaterfallClimb.ResolveCameraExitBlend(self._waterfallClimbCameraExitBlendRemainingSec, self._waterfallClimbCameraExitBlendDurationSec)
		end

		return SetVec3(_cameraOffsetResult, self._waterfallClimbExitCameraPositionOffset.x * exitBlend, self._waterfallClimbExitCameraPositionOffset.y * exitBlend, self._waterfallClimbExitCameraPositionOffset.z * exitBlend)
	end

	return nil
end

function PlayerVehicleController:getCameraLookTargetPosition()
	if self._activeWaterfallClimbRoute then
		return self._waterfallClimbCameraLookTargetPosition
	end

	if (self._waterfallClimbCameraExitBlendRemainingSec or 0) > 0 then
		local exitBlend

		if self._waterfallClimbBackFacingExitCameraDelayActive then
			local elapsed = math.max(0, (self._waterfallClimbCameraExitBlendDurationSec or 0) - (self._waterfallClimbCameraExitBlendRemainingSec or 0))

			exitBlend = WaterfallClimb.ResolveBackFacingExitCameraCompositionBlend(elapsed, self._waterfallClimbCameraExitBlendDurationSec)
		else
			exitBlend = WaterfallClimb.ResolveCameraExitBlend(self._waterfallClimbCameraExitBlendRemainingSec, self._waterfallClimbCameraExitBlendDurationSec)
		end

		local followPosition = self:getCameraFollowPosition() or (function()
			local px, py, pz = transformhelper.getPos(self._transform)

			return SetVec3(_cameraFollowResult, px, py, pz)
		end)()

		return SetVec3(_basePosCache, followPosition.x + self._waterfallClimbExitCameraLookOffset.x * exitBlend, followPosition.y + self._waterfallClimbExitCameraLookOffset.y * exitBlend, followPosition.z + self._waterfallClimbExitCameraLookOffset.z * exitBlend)
	end

	return nil
end

function PlayerVehicleController:cameraUsesVerticalForward()
	return (self._activeGlideRoute == nil and self._activeSnowSlopeRoute == nil or nil) and (self._snowSlopeLandingBlendActive or self._activeWaterfallClimbRoute == nil and self._waterfallClimbExitFlightActive or true)
end

function PlayerVehicleController:cameraUsesVerticalPositionForward()
	return self._activeWaterfallClimbRoute ~= nil or self._waterfallClimbExitFlightActive
end

function PlayerVehicleController:getActiveCameraProfileId()
	if self._aerialShortcutExitFlightActive then
		return self._aerialShortcutExitCameraProfileId
	end

	if self._glideLandingBlendActive then
		return self._glideLandingCameraProfileId
	end

	if self._waterDropLandingBlendActive then
		return self._waterDropLandingCameraProfileId
	end

	if self._snowSlopeLandingBlendActive then
		return self._snowSlopeLandingCameraProfileId
	end

	if self._waterfallClimbExitFlightActive then
		return self._waterfallClimbExitFlightCameraProfileId
	end

	if self._activeGlideRoute then
		return self._activeGlideRoute.cameraId or 0
	end

	if self._activeWaterfallClimbRoute then
		return self._activeWaterfallClimbRoute.cameraId or 0
	end

	if self._activeSnowSlopeRoute then
		return self._activeSnowSlopeRoute.cameraId or 0
	end

	if self._activeUnderwaterRoute then
		return self._activeUnderwaterRoute.cameraId or 0
	end

	if self._activeWaterDrop then
		return self._activeWaterDrop.cameraId or 0
	end

	local aerialShortcut = self:_resolveActiveAerialShortcut()

	if aerialShortcut then
		return AerialShortcut.ResolveCameraProfileId(aerialShortcut)
	end

	if self._activeLayeredRoute then
		if (self._activeLayeredRoute.cameraId or 0) > 0 then
			return self._activeLayeredRoute.cameraId
		end
	end

	return 0
end

function PlayerVehicleController:getCameraForward()
	local cameraExitRemaining = math.max(0, (not self._waterfallClimbCameraExitBlendRemainingSec or nil) and 0)
	local cameraExitDuration = math.max(0, (not self._waterfallClimbCameraExitBlendDurationSec or nil) and 0)

	if cameraExitRemaining > 0 and cameraExitDuration > 0 then
		local cameraExitElapsed = cameraExitDuration - cameraExitRemaining
		local cameraTurnBlend = WaterfallClimb.ResolveExitCameraTurnBlend(cameraExitElapsed, cameraExitDuration)
		local cex, cey, cez = SlerpUnitVec3(self._waterfallClimbExitFlightStartForward.x, self._waterfallClimbExitFlightStartForward.y, self._waterfallClimbExitFlightStartForward.z, self._waterfallClimbExitFlightTargetForward.x, self._waterfallClimbExitFlightTargetForward.y, self._waterfallClimbExitFlightTargetForward.z, cameraTurnBlend)

		if cex * cex + cey * cey + cez * cez > 0.001 then
			local forward = self:_resolveCameraForwardForCurrentRoute(SetVec3(_forwardCache, cex, cey, cez))

			if forward and forward.x * forward.x + forward.y * forward.y + forward.z * forward.z > 0.001 then
				local flen = math.sqrt(forward.x * forward.x + forward.y * forward.y + forward.z * forward.z)

				return SetVec3(_forwardCache, forward.x / flen, forward.y / flen, forward.z / flen)
			end
		end
	end

	local fallback = self._cameraTrackForward

	if fallback and fallback.x * fallback.x + fallback.y * fallback.y + fallback.z * fallback.z > 0.001 then
		local forward = self:_resolveCameraForwardForCurrentRoute(fallback)

		if forward and forward.x * forward.x + forward.y * forward.y + forward.z * forward.z > 0.001 then
			local flen = math.sqrt(forward.x * forward.x + forward.y * forward.y + forward.z * forward.z)

			return SetVec3(_forwardCache, forward.x / flen, forward.y / flen, forward.z / flen)
		end
	end

	return self:getStableForward()
end

function PlayerVehicleController:_setInvulnerableFor(seconds, enableFlash)
	RacingVehicleControllerBase._setInvulnerableFor(self, seconds)

	self._invulnerabilityFlashEnabled = enableFlash == true

	if self._invulnerabilityRemainingSec > 0 and self._invulnerabilityFlashEnabled then
		self:_resolveFlashRenderers()
		self:_updateInvulnerabilityFlash()
	else
		self:_setInvulnerabilityRenderersVisible(true)
	end
end

function PlayerVehicleController:_setPerfectDodgeInvulnerableFor(seconds)
	local duration = math.max(0, seconds or 0)

	if duration <= 0 then
		return
	end

	self._perfectDodgeInvulnerabilityRemainingSec = math.max(self._perfectDodgeInvulnerabilityRemainingSec or 0, duration)

	RacingVehicleControllerBase._setInvulnerableFor(self, math.max(self._invulnerabilityRemainingSec or 0, self._perfectDodgeInvulnerabilityRemainingSec))

	if not self._invulnerabilityFlashEnabled then
		self:_setInvulnerabilityRenderersVisible(true)
	end
end

function PlayerVehicleController:_resolveFlashRenderers()
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

function PlayerVehicleController:_updateInvulnerabilityFlash()
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

function PlayerVehicleController:_setInvulnerabilityRenderersVisible(visible)
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

return PlayerVehicleController
