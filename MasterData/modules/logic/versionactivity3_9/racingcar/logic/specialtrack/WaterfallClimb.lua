-- chunkname: @modules/logic/versionactivity3_9/racingcar/logic/specialtrack/WaterfallClimb.lua

module("modules.logic.versionactivity3_9.racingcar.logic.specialtrack.WaterfallClimb", package.seeall)

local WaterfallClimb = {}
local WaterfallClimbMinForwardSpeedBaseScale = 0.3
local WaterfallClimbGameGravityMetersPerSecondSquared = 10
local WaterfallClimbDefaultGravityScale = 6
local WaterfallClimbDefaultCameraCenterLookWeight = 0.5
local WaterfallClimbDefaultCameraCenterLookBlendDistance = 20
local WaterfallClimbExitCameraPreviewDistance = 30
local WaterfallClimbExitCameraLift = 5
local WaterfallClimbExitFlightDurationSec = 0.5
local WaterfallClimbExitCameraTurnHoldSec = 0.22
local WaterfallClimbDefaultExitCameraTurnSpeedDegPerSec = 100
local WaterfallClimbBackFacingExitDotThreshold = -0.5
local WaterfallClimbBackFacingCameraFollowHoldSec = 0.08
local WaterfallClimbCameraExitMinDurationSec = 0.6
local WaterfallClimbEntryCurveSampleCount = 12
local RoadFrame3DEpsilon = 0.0001

local function SetVector3(target, x, y, z)
	if target then
		target.x, target.y, target.z = x, y, z

		return target
	end

	return Vector3(x, y, z)
end

local function SlerpUnitVectorXYZ(ax, ay, az, bx, by, bz, t)
	local aSqr = ax * ax + ay * ay + az * az
	local bSqr = bx * bx + by * by + bz * bz

	if aSqr <= RoadFrame3DEpsilon or bSqr <= RoadFrame3DEpsilon then
		return bx, by, bz
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
	local rx, ry, rz

	if dot > 0.9995 then
		rx = ax + (bx - ax) * t
		ry = ay + (by - ay) * t
		rz = az + (bz - az) * t
	elseif dot < -0.9995 then
		local ox, oy, oz

		if math.abs(ax) < 0.9 then
			oz = -ay
			oy = az
			ox = 0
		else
			oz = ax
			oy = 0
			ox = -az
		end

		local oInv = 1 / math.sqrt(ox * ox + oy * oy + oz * oz)

		oz = oz * oInv
		oy = oy * oInv
		ox = ox * oInv

		local angle = math.pi * t
		local cosAngle, sinAngle = math.cos(angle), math.sin(angle)

		rx = ax * cosAngle + ox * sinAngle
		ry = ay * cosAngle + oy * sinAngle
		rz = az * cosAngle + oz * sinAngle
	else
		local theta = math.acos(dot)
		local sinTheta = math.sin(theta)
		local aWeight = math.sin((1 - t) * theta) / sinTheta
		local bWeight = math.sin(t * theta) / sinTheta

		rx = ax * aWeight + bx * bWeight
		ry = ay * aWeight + by * bWeight
		rz = az * aWeight + bz * bWeight
	end

	local resultSqr = rx * rx + ry * ry + rz * rz

	if resultSqr <= RoadFrame3DEpsilon then
		return bx, by, bz
	end

	local resultInv = 1 / math.sqrt(resultSqr)

	return rx * resultInv, ry * resultInv, rz * resultInv
end

function WaterfallClimb.ResolveEntryForwardSpeed(currentForwardSpeed, baseSpeed, climb)
	if climb then
		if not climb.minClimbForwardSpeed then
			local configuredMinSpeed = 0

			if climb then
				local baseMinSpeed = math.max(0, baseSpeed or 0) * math.max(0, climb.minClimbSpeedBaseScale or WaterfallClimbMinForwardSpeedBaseScale)
				local minSpeed = math.max(0.01, configuredMinSpeed or 0, baseMinSpeed)

				return math.max(currentForwardSpeed or 0, minSpeed)
			end
		end
	end
end

function WaterfallClimb.ResolveCameraLookTarget(climb, vehiclePosition, climbProgress, entryCurveActive, outPosition)
	if not climb or not vehiclePosition then
		return nil
	end

	if not climb.centerX then
		local centerX = vehiclePosition.x
		local centerY = vehiclePosition.y

		if not climb.centerZ then
			local configuredCenterWeight = Mathf.Clamp01(climb.cameraCenterLookWeight or WaterfallClimbDefaultCameraCenterLookWeight)
			local centerBlend = 0

			if not entryCurveActive then
				local climbLength = math.max(0.01, (not climb.climbLength or nil) and 0.01)
				local joinedDistance = WaterfallClimb.ResolveEntryJoinDistance(climb)
				local distanceAfterJoin = math.max(0, Mathf.Clamp01(climbProgress or 0) * climbLength - joinedDistance)
				local blendDistance = math.max(0.01, (not climb.cameraCenterLookBlendDistance or nil) and WaterfallClimbDefaultCameraCenterLookBlendDistance)
				local blendT = Mathf.Clamp01(distanceAfterJoin / blendDistance)

				centerBlend = blendT * blendT * (3 - 2 * blendT)
			end

			local centerWeight = configuredCenterWeight * centerBlend
			local vx = vehiclePosition.x
			local vy = vehiclePosition.y
			local vz = vehiclePosition.z

			return SetVector3(outPosition, vx + (centerX - vx) * centerWeight, vy + (centerY - vy) * centerWeight, vz + (climb.centerZ - vz) * centerWeight)
		end
	end
end

function WaterfallClimb.ResolveCameraEntryBlend(entryCurveActive, entryCurveProgress)
	if not entryCurveActive then
		return 1
	end

	local t = Mathf.Clamp01((entryCurveProgress or 0) / 0.7)

	return t * t * (3 - 2 * t)
end

function WaterfallClimb.ResolveExitCameraPreviewBlend(climbProgress, climbLength, entryCurveActive)
	if entryCurveActive then
		return 0
	end

	local length = math.max(0.01, climbLength or 0.01)
	local remainingDistance = (1 - Mathf.Clamp01(climbProgress or 0)) * length
	local t = Mathf.Clamp01(1 - remainingDistance / WaterfallClimbExitCameraPreviewDistance)

	return t * t * (3 - 2 * t)
end

function WaterfallClimb.ResolveExitCameraLift(previewBlend)
	return Mathf.Clamp01(previewBlend or 0) * WaterfallClimbExitCameraLift
end

function WaterfallClimb.ResolveExitFlightDuration()
	return WaterfallClimbExitFlightDurationSec
end

function WaterfallClimb.ResolveExitCameraTurnBlend(elapsedSec, durationSec)
	local duration = math.max(0.0001, durationSec or 0)
	local turnDuration = math.max(0.0001, duration - WaterfallClimbExitCameraTurnHoldSec)
	local t = Mathf.Clamp01(((elapsedSec or 0) - WaterfallClimbExitCameraTurnHoldSec) / turnDuration)

	return t * t * (3 - 2 * t)
end

function WaterfallClimb.ShouldDelayBackFacingExitCamera(startForwardX, startForwardZ, targetForwardX, targetForwardZ)
	local startLength = math.sqrt((startForwardX or 0) * (startForwardX or 0) + (startForwardZ or 0) * (startForwardZ or 0))
	local targetLength = math.sqrt((targetForwardX or 0) * (targetForwardX or 0) + (targetForwardZ or 0) * (targetForwardZ or 0))

	if startLength <= RoadFrame3DEpsilon or targetLength <= RoadFrame3DEpsilon then
		return false
	end

	local dot = ((startForwardX or 0) * (targetForwardX or 0) + (startForwardZ or 0) * (targetForwardZ or 0)) / (startLength * targetLength)

	return dot <= WaterfallClimbBackFacingExitDotThreshold + RoadFrame3DEpsilon
end

function WaterfallClimb.ResolveBackFacingExitCameraFollowBlend(elapsedSec)
	local catchDuration = math.max(0.0001, WaterfallClimbExitCameraTurnHoldSec - WaterfallClimbBackFacingCameraFollowHoldSec)
	local t = Mathf.Clamp01(((elapsedSec or 0) - WaterfallClimbBackFacingCameraFollowHoldSec) / catchDuration)

	return t * t * (3 - 2 * t)
end

function WaterfallClimb.ResolveBackFacingExitCameraCompositionBlend(elapsedSec, durationSec)
	local duration = math.max(WaterfallClimbExitCameraTurnHoldSec + 0.0001, durationSec or 0)
	local releaseDuration = math.max(0.0001, duration - WaterfallClimbExitCameraTurnHoldSec)
	local t = Mathf.Clamp01(((elapsedSec or 0) - WaterfallClimbExitCameraTurnHoldSec) / releaseDuration)
	local smoothT = t * t * (3 - 2 * t)

	return 1 - smoothT
end

function WaterfallClimb.ResolveCameraExitBlend(remainingSec, durationSec)
	local duration = math.max(0.0001, durationSec or 0)
	local t = Mathf.Clamp01((remainingSec or 0) / duration)

	return t * t * (3 - 2 * t)
end

function WaterfallClimb.ResolveCameraExitDuration(exitFlightDurationSec, startForwardX, startForwardZ, targetForwardX, targetForwardZ, turnSpeedDegPerSec)
	local startLength = math.sqrt((startForwardX or 0) * (startForwardX or 0) + (startForwardZ or 0) * (startForwardZ or 0))
	local targetLength = math.sqrt((targetForwardX or 0) * (targetForwardX or 0) + (targetForwardZ or 0) * (targetForwardZ or 0))
	local angularDuration = 0

	if startLength > RoadFrame3DEpsilon and targetLength > RoadFrame3DEpsilon then
		local dot = ((startForwardX or 0) * (targetForwardX or 0) + (startForwardZ or 0) * (targetForwardZ or 0)) / (startLength * targetLength)
		local angleDeg = math.deg(math.acos(math.max(-1, math.min(1, dot))))
		local turnSpeed = math.max(1, turnSpeedDegPerSec or WaterfallClimbDefaultExitCameraTurnSpeedDegPerSec)

		angularDuration = WaterfallClimbExitCameraTurnHoldSec + angleDeg / turnSpeed
	end

	return math.max(WaterfallClimbCameraExitMinDurationSec, math.max(math.max(0, exitFlightDurationSec or 0), angularDuration))
end

function WaterfallClimb.ResolveFixedLaneFloat(climb, entryForwardX, entryForwardZ)
	if climb then
		local laneCount = math.max(1, math.floor(climb.laneCount or 1))
		local forwardLength = math.sqrt((entryForwardX or 0) * (entryForwardX or 0) + (entryForwardZ or 0) * (entryForwardZ or 0))

		if forwardLength <= RoadFrame3DEpsilon then
			if climb then
				do
					local fallbackLaneId = math.max(1, math.min(laneCount, climb.fromLaneId or math.floor((laneCount + 1) * 0.5)))

					return fallbackLaneId - 1
				end

				local forwardX = (entryForwardX or 0) / forwardLength
				local forwardZ = (entryForwardZ or 0) / forwardLength

				if climb then
					local laneWidth = math.max(0.01, climb.laneWidth or 8)

					if climb then
						local radius = math.max(0.1, climb.radius or 8)
						local centerLane = (laneCount - 1) * 0.5

						if climb then
							local startAngle = math.rad(climb.startAngleDeg or 0)
							local bestLaneFloat = 0
							local bestFacingDot = -math.huge

							for laneIndex = 0, laneCount - 1 do
								local arcOffset = (laneIndex - centerLane) * (laneWidth / radius)
								local faceAngle = startAngle + arcOffset
								local inwardX = -math.cos(faceAngle)
								local inwardZ = -math.sin(faceAngle)
								local facingDot = forwardX * inwardX + forwardZ * inwardZ

								if bestFacingDot < facingDot then
									bestFacingDot = facingDot
									bestLaneFloat = laneIndex
								end
							end

							return bestLaneFloat
						end
					end
				end
			end
		end
	end
end

function WaterfallClimb.ResolveExitForwardSpeed(currentForwardSpeed, baseSpeed, climbTravelSpeed)
	return math.max(0, currentForwardSpeed or 0, baseSpeed or 0, climbTravelSpeed or 0)
end

function WaterfallClimb.ResolveEntryCurveDistance(climb)
	return math.max(0, (climb or nil) and (climb.entryCurveDistance or 0))
end

function WaterfallClimb.ResolveEntryTriggerDistance(climb)
	if climb then
		local formalEntryDistance = math.max(0, climb.fromDistance or 0)

		return math.max(0, formalEntryDistance - WaterfallClimb.ResolveEntryCurveDistance(climb))
	end
end

function WaterfallClimb.ResolveEntryJoinDistance(climb)
	if climb then
		local climbLength = math.max(0.01, climb.climbLength or 0.01)
		local entryCurveDistance = WaterfallClimb.ResolveEntryCurveDistance(climb)

		return math.min(climbLength * 0.1, entryCurveDistance * 0.25)
	end
end

local function EvaluateWaterfallEntryCurvePositionXYZ(curve, progress)
	local t = math.max(0, math.min(1, progress or 0))
	local oneMinusT = 1 - t
	local p0Weight = oneMinusT * oneMinusT * oneMinusT
	local p1Weight = 3 * oneMinusT * oneMinusT * t
	local p2Weight = 3 * oneMinusT * t * t
	local p3Weight = t * t * t

	return curve.p0.x * p0Weight + curve.p1.x * p1Weight + curve.p2.x * p2Weight + curve.p3.x * p3Weight, curve.p0.y * p0Weight + curve.p1.y * p1Weight + curve.p2.y * p2Weight + curve.p3.y * p3Weight, curve.p0.z * p0Weight + curve.p1.z * p1Weight + curve.p2.z * p2Weight + curve.p3.z * p3Weight
end

local function EvaluateWaterfallEntryCurvePosition(curve, progress)
	return Vector3(EvaluateWaterfallEntryCurvePositionXYZ(curve, progress))
end

function WaterfallClimb.BuildEntryCurve(climb, startPosition, startForward, startUp, targetPosition, targetForward, targetUp)
	local entryCurveDistance = WaterfallClimb.ResolveEntryCurveDistance(climb)

	if entryCurveDistance <= 0 or not startPosition or not targetPosition then
		return nil
	end

	if targetForward and targetForward.sqrMagnitude > 0.0001 then
		if not targetForward.normalized then
			local safeTargetForward = Vector3.up

			if startForward and startForward.sqrMagnitude > 0.0001 then
				if not startForward.normalized then
					local safeStartForward = safeTargetForward

					if startUp and startUp.sqrMagnitude > 0.0001 then
						if not startUp.normalized then
							local safeStartUp = Vector3.up

							if targetUp and targetUp.sqrMagnitude > 0.0001 then
								if not targetUp.normalized then
									local safeTargetUp = Vector3.forward
									local joinDistance = WaterfallClimb.ResolveEntryJoinDistance(climb)
									local startControlDistance = entryCurveDistance * 0.45
									local endControlDistance = math.max(0.5, math.min(joinDistance * 0.8, entryCurveDistance * 0.25))
									local curve = {
										length = 0,
										p0 = startPosition,
										p1 = startPosition + safeStartForward * startControlDistance,
										p2 = targetPosition - safeTargetForward * endControlDistance,
										p3 = targetPosition,
										startUp = safeStartUp,
										targetUp = safeTargetUp,
										joinDistance = joinDistance
									}
									local previousPosition = curve.p0

									for sampleIndex = 1, WaterfallClimbEntryCurveSampleCount do
										local samplePosition = EvaluateWaterfallEntryCurvePosition(curve, sampleIndex / WaterfallClimbEntryCurveSampleCount)

										curve.length = curve.length + (samplePosition - previousPosition).magnitude
										previousPosition = samplePosition
									end

									curve.length = math.max(0.01, curve.length)

									return curve
								end
							end
						end
					end
				end
			end
		end
	end
end

function WaterfallClimb.EvaluateEntryCurveTangentInto(curve, progress, outTangent)
	if not curve then
		return nil
	end

	local t = math.max(0, math.min(1, progress or 0))
	local oneMinusT = 1 - t
	local p10Weight = 3 * oneMinusT * oneMinusT
	local p21Weight = 6 * oneMinusT * t
	local p32Weight = 3 * t * t
	local tx = (curve.p1.x - curve.p0.x) * p10Weight + (curve.p2.x - curve.p1.x) * p21Weight + (curve.p3.x - curve.p2.x) * p32Weight
	local ty = (curve.p1.y - curve.p0.y) * p10Weight + (curve.p2.y - curve.p1.y) * p21Weight + (curve.p3.y - curve.p2.y) * p32Weight
	local tz = (curve.p1.z - curve.p0.z) * p10Weight + (curve.p2.z - curve.p1.z) * p21Weight + (curve.p3.z - curve.p2.z) * p32Weight
	local tangentSqr = tx * tx + ty * ty + tz * tz

	if tangentSqr > RoadFrame3DEpsilon then
		local inv = 1 / math.sqrt(tangentSqr)

		tz = tz * inv
		ty = ty * inv
		tx = tx * inv
	else
		tz = 0
		ty = 1
		tx = 0
	end

	return SetVector3(outTangent, tx, ty, tz)
end

function WaterfallClimb.EvaluateEntryCurveInto(curve, progress, outPosition, outTangent, outUp)
	if not curve then
		return nil, nil, nil
	end

	local t = math.max(0, math.min(1, progress or 0))
	local px, py, pz = EvaluateWaterfallEntryCurvePositionXYZ(curve, t)
	local position = SetVector3(outPosition, px, py, pz)
	local tangent = WaterfallClimb.EvaluateEntryCurveTangentInto(curve, t, outTangent)
	local upX, upY, upZ = SlerpUnitVectorXYZ(curve.startUp.x, curve.startUp.y, curve.startUp.z, curve.targetUp.x, curve.targetUp.y, curve.targetUp.z, t)
	local up = SetVector3(outUp, upX, upY, upZ)

	return position, tangent, up
end

function WaterfallClimb.EvaluateEntryCurve(curve, progress)
	return WaterfallClimb.EvaluateEntryCurveInto(curve, progress)
end

function WaterfallClimb.ResolveGravityDeceleration(climb, slopeUpDot)
	local slopeFactor = math.max(0, math.min(1, slopeUpDot or 0))

	if climb then
		local gravityScale = math.max(0, climb.climbGravityScale or WaterfallClimbDefaultGravityScale)

		return WaterfallClimbGameGravityMetersPerSecondSquared * gravityScale * slopeFactor
	end
end

function WaterfallClimb.EvaluatePlacedElementPose(climb, distance, laneIndex)
	if not climb then
		return nil, nil, nil
	end

	local length = math.max(0.01, climb.climbLength or 0.01)
	local progress = Mathf.Clamp01((distance or 0) / length)
	local laneCount = math.max(1, (not climb.laneCount or nil) and 1)
	local safeLaneIndex = math.max(0, math.min(laneCount - 1, laneIndex or 0))
	local laneWidth = math.max(0.01, (not climb.laneWidth or nil) and 8)
	local radius = math.max(0.1, (not climb.radius or nil) and 8)
	local centerLane = (laneCount - 1) * 0.5
	local arcOffset = (safeLaneIndex - centerLane) * (laneWidth / radius)
	local startAngle = math.rad(climb.startAngleDeg or 0)
	local twistAngle = math.rad(climb.twistAngleDeg or 0)
	local angle = startAngle + twistAngle * progress + arcOffset
	local position = Vector3((climb.centerX or 0) + math.cos(angle) * radius, Mathf.Lerp(climb.startY or 0, climb.endY or 0, progress), (climb.centerZ or 0) + math.sin(angle) * radius)
	local radial = Vector3(position.x - ((not climb.centerX or nil) and 0), 0, position.z - (climb.centerZ or 0))
	local nextProgress = math.min(1, progress + 0.005)
	local nextAngle = startAngle + twistAngle * nextProgress + arcOffset
	local nextPosition = Vector3((climb.centerX or 0) + math.cos(nextAngle) * radius, Mathf.Lerp(climb.startY or 0, climb.endY or 0, nextProgress), (climb.centerZ or 0) + math.sin(nextAngle) * radius)
	local tangent = nextPosition - position

	tangent = tangent.sqrMagnitude > 0.0001 and tangent.normalized or Vector3.up
	radial = radial.sqrMagnitude > 0.0001 and radial.normalized or Vector3.forward

	return position, tangent, radial
end

function WaterfallClimb.ResolveElementPickupCoordinates(vehicle, defaultDistance, defaultLateral)
	local climb = vehicle and vehicle._activeWaterfallClimbRoute

	if not climb then
		return defaultDistance, defaultLateral
	end

	local length = math.max(0.01, climb.climbLength or 0.01)
	local progress = Mathf.Clamp01(vehicle._waterfallClimbProgress or 0)
	local laneCount = math.max(1, (not climb.laneCount or nil) and 1)
	local laneWidth = math.max(0.01, (not climb.laneWidth or nil) and 8)
	local centerLane = (laneCount - 1) * 0.5

	if not vehicle._waterfallClimbLaneFloat then
		local laneFloat = 0

		return progress * length, (laneFloat - centerLane) * laneWidth
	end
end

function WaterfallClimb.ResolveClimbSpeed(climb, currentForwardSpeed, baseSpeed, previousClimbSpeed, slopeUpDot, deltaTime)
	local forwardSpeed = WaterfallClimb.ResolveEntryForwardSpeed(currentForwardSpeed, baseSpeed, climb)

	if climb then
		if not climb.minClimbForwardSpeed then
			local configuredMinSpeed = 0

			if climb then
				local baseMinSpeed = math.max(0, baseSpeed or 0) * math.max(0, climb.minClimbSpeedBaseScale or WaterfallClimbMinForwardSpeedBaseScale)
				local minClimbSpeed = math.max(0.01, configuredMinSpeed or 0, baseMinSpeed)
				local liveSpeed = math.max(forwardSpeed, minClimbSpeed)

				if previousClimbSpeed == nil or previousClimbSpeed <= liveSpeed then
					return liveSpeed
				end

				local deceleration = WaterfallClimb.ResolveGravityDeceleration(climb, slopeUpDot)
				local decayedSpeed = previousClimbSpeed - deceleration * math.max(0, deltaTime or 0)

				return math.max(liveSpeed, decayedSpeed)
			end
		end
	end
end

return WaterfallClimb
