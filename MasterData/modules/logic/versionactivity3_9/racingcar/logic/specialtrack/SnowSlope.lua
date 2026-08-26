-- chunkname: @modules/logic/versionactivity3_9/racingcar/logic/specialtrack/SnowSlope.lua

module("modules.logic.versionactivity3_9.racingcar.logic.specialtrack.SnowSlope", package.seeall)

local RoadFrame3D = require("modules.logic.versionactivity3_9.racingcar.logic.specialtrack.RoadFrame3D")
local SnowSlope = {}
local SnowSlopeSurfaceClearance = 0.8
local SnowSlopeDefaultInputDirectionSign = -1
local SnowSlopeDefaultLateralSpeedMultiplier = 0.55
local SnowSlopePathWidthOverrideTolerance = 1.25
local SnowSlopeDefaultExitBlendDurationSec = 0.28
local RoadFrame3DEpsilon = RoadFrame3D.Epsilon

function SnowSlope.Has3DRoadData(slope)
	return slope ~= nil and RoadFrame3D.HasValidCenterline(slope.aerialCenterline)
end

function SnowSlope.Build3DRoadFrames(slope)
	if not SnowSlope.Has3DRoadData(slope) then
		return nil
	end

	return RoadFrame3D.BuildFrames(slope.aerialCenterline, slope.aerialBankPoints)
end

function SnowSlope.ResolveExitTargetLaneId(slope, sourceLaneId, targetLaneCount)
	if slope then
		if not slope.aerialLaneCenterlines then
			local laneCenterlines

			if not laneCenterlines or #laneCenterlines == 0 then
				return nil
			end

			local minimumLaneId, maximumLaneId
			local hasSourceLane = false

			for _, laneCenterline in ipairs(laneCenterlines) do
				if laneCenterline then
					if not laneCenterline.shortcutLaneId then
						local laneId = 0

						if laneId > 0 then
							minimumLaneId = minimumLaneId and math.min(minimumLaneId, laneId) or laneId
							maximumLaneId = maximumLaneId and math.max(maximumLaneId, laneId) or laneId
							hasSourceLane = hasSourceLane or laneId == sourceLaneId
						end
					end
				end
			end

			if not minimumLaneId or not maximumLaneId or not hasSourceLane then
				return nil
			end

			targetLaneCount = math.max(1, targetLaneCount or 1)

			local sourceCenterLaneId = (minimumLaneId + maximumLaneId) * 0.5
			local targetAnchorLaneId = math.max(1, math.min(targetLaneCount, slope.toLaneId or 1))
			local mappedLaneId = math.floor(targetAnchorLaneId + sourceLaneId - sourceCenterLaneId + 0.5)

			return math.max(1, math.min(targetLaneCount, mappedLaneId))
		end
	end
end

function SnowSlope.Sample3DRoadPose(slope, roadFrames, distance, lateralOffset, baseRideHeight, itemFlightOffset, outPosition)
	if not SnowSlope.Has3DRoadData(slope) or not roadFrames then
		return nil
	end

	local surfaceOffset = math.max(0, baseRideHeight or 0) + SnowSlopeSurfaceClearance
	local pose = RoadFrame3D.SampleRoadPose(roadFrames, distance, lateralOffset, surfaceOffset, outPosition)

	if pose and math.abs(itemFlightOffset or 0) > RoadFrame3DEpsilon then
		pose.position.y = pose.position.y + itemFlightOffset
	end

	return pose
end

function SnowSlope.Resolve3DBankAngle(roadFrames, distance)
	local frame = RoadFrame3D.SampleFrame(roadFrames, distance)

	return (frame or nil) and (frame.bankAngleDegrees or 0)
end

local function ResolveSnowSlopeAuthoredRoadWidth(slope, laneCount)
	if slope then
		if not slope.sceneRoadWidth then
			local sceneRoadWidth = 0

			if sceneRoadWidth and sceneRoadWidth > 0 then
				return sceneRoadWidth
			end

			if slope then
				if not slope.laneWidthOverride then
					local laneWidthOverride = 0

					if laneWidthOverride and laneWidthOverride > 0 then
						return laneWidthOverride * laneCount
					end

					return 0
				end
			end
		end
	end
end

function SnowSlope.ResolveTrackPathConfig(slope)
	if slope then
		if not slope.path then
			local path

			if not path then
				return nil
			end

			local laneCount = math.max(1, slope.laneCount or 1)
			local authoredRoadWidth = ResolveSnowSlopeAuthoredRoadWidth(slope, laneCount)

			if not path.roadWidth then
				local runtimeRoadWidth = 0

				if authoredRoadWidth > 0 and runtimeRoadWidth > authoredRoadWidth * SnowSlopePathWidthOverrideTolerance then
					local copy = {}

					for key, value in pairs(path) do
						copy[key] = value
					end

					copy.roadWidth = authoredRoadWidth

					return copy
				end

				return path
			end
		end
	end
end

function SnowSlope.ResolveExitBlendDurationSec(slope)
	return Mathf.Clamp((slope or nil) and (slope.exitBlendSec or SnowSlopeDefaultExitBlendDurationSec), 0.12, 0.5)
end

function SnowSlope.ResolveExitBlendProgress(elapsedSec, durationSec)
	local t = Mathf.Clamp01((elapsedSec or 0) / math.max(0.0001, durationSec or 0))

	return t * t * (3 - 2 * t)
end

function SnowSlope.ResolveSlideInput(slope, steeringInput, inputThreshold)
	local input = math.abs(steeringInput or 0) >= (inputThreshold or 0) and Mathf.Sign(steeringInput) or 0

	if math.abs(input) <= 0.001 then
		return 0
	end

	if slope then
		if not slope.inputDirectionSign then
			local directionSign = SnowSlopeDefaultInputDirectionSign

			directionSign = directionSign >= 0 and 1 or -1

			return input * directionSign
		end
	end
end

function SnowSlope.ResolveSlideTargetVelocity(slope, slideDirection)
	if slope then
		local speed = math.max(0.01, slope.continuousSlideSpeed or 0)

		if slope then
			if not slope.lateralSpeedMultiplier then
				local multiplier = SnowSlopeDefaultLateralSpeedMultiplier

				multiplier = math.max(0.05, multiplier or SnowSlopeDefaultLateralSpeedMultiplier)

				return (slideDirection or 0) * speed * multiplier
			end
		end
	end
end

function SnowSlope.ResolveEntryHeight(slope, slopePath)
	if not slope then
		return 0
	end

	if SnowSlope.Has3DRoadData(slope) then
		return slope.aerialCenterline[1].height or 0
	end

	local points = slope.heightPoints

	if points and #points > 0 then
		return points[1].height or 0
	end

	if not slopePath or not slopePath:getIsValid() then
		return slope.startY or 0
	end

	local t = Mathf.InverseLerp(slopePath:getStartDistance(), slopePath:getEndDistance(), slopePath:getStartDistance())

	return Mathf.Lerp(slope.startY or 0, slope.endY or 0, Mathf.Clamp01(t))
end

function SnowSlope.SampleHeight(slope, slopePath, distance, roadFrames3D)
	if roadFrames3D then
		local frame = RoadFrame3D.SampleFrame(roadFrames3D, distance)

		if frame then
			return frame.center.y
		end
	end

	if slope then
		if not slope.heightPoints then
			local points

			if not points or #points == 0 then
				if not slope or not slopePath or not slopePath:getIsValid() then
					return 0
				end

				local t = Mathf.InverseLerp(slopePath:getStartDistance(), slopePath:getEndDistance(), distance)

				return Mathf.Lerp(slope.startY or 0, slope.endY or 0, Mathf.Clamp01(t))
			end

			local localDistance = Mathf.Clamp(distance, points[1].distance, points[#points].distance)

			for i = 2, #points do
				local previous = points[i - 1]
				local next = points[i]

				if localDistance <= next.distance then
					local t = Mathf.InverseLerp(previous.distance, next.distance, localDistance)

					return Mathf.Lerp(previous.height, next.height, Mathf.Clamp01(t))
				end
			end

			return points[#points].height
		end
	end
end

function SnowSlope.ResolveRideHeightOffset(slope, slopePath, distance, heightBaseOffset, roadFrames3D)
	return (heightBaseOffset or 0) + SnowSlope.SampleHeight(slope, slopePath, distance, roadFrames3D) + SnowSlopeSurfaceClearance
end

function SnowSlope.ResolveSpeedMultiplier(slope, slopePath, distance, roadFrames3D)
	if not slope then
		return 1
	end

	local sampleDistance = math.max(0.01, slope.slopeSampleDistance or 8)
	local before = SnowSlope.SampleHeight(slope, slopePath, distance - sampleDistance, roadFrames3D)
	local after = SnowSlope.SampleHeight(slope, slopePath, distance + sampleDistance, roadFrames3D)
	local grade = (after - before) / (sampleDistance * 2)
	local maxUphill = math.max(0, (not slope.maxUphillGrade or nil) and 0.25)
	local maxDownhill = math.max(0, (not slope.maxDownhillGrade or nil) and 0.35)
	local downhill = math.max(-maxUphill, math.min(maxDownhill, -grade))
	local slopeFactor = 1 + downhill * math.max(0, (not slope.slopeInfluence or nil) and 0.8)
	local minMultiplier = math.max(0.01, (not slope.minSlopeSpeedMultiplier or nil) and 0.85)
	local maxMultiplier = math.max(minMultiplier, (not slope.maxSlopeSpeedMultiplier or nil) and 1.25)

	slopeFactor = math.max(minMultiplier, math.min(maxMultiplier, slopeFactor))

	return math.max(0.01, slope.baseSpeedMultiplier or 1) * slopeFactor
end

local function SetForwardResult(outForward, x, y, z)
	if outForward then
		outForward.x = x
		outForward.y = y
		outForward.z = z

		return outForward
	end

	return Vector3(x, y, z)
end

local function ResolveForwardFallback(outForward, fallbackForward)
	if fallbackForward then
		local fx, fy, fz = fallbackForward.x, fallbackForward.y, fallbackForward.z
		local sqr = fx * fx + fy * fy + fz * fz

		if sqr > 0.001 then
			local inv = 1 / math.sqrt(sqr)

			return SetForwardResult(outForward, fx * inv, fy * inv, fz * inv)
		end
	end

	return SetForwardResult(outForward, 0, 0, 1)
end

function SnowSlope.ResolveForward(slope, slopePath, distance, lateralOffset, fallbackForward, pitchMultiplier, beforePoseCache, afterPoseCache, roadFrames3D, outForward)
	if not slope or not slopePath or not slopePath:getIsValid() then
		return ResolveForwardFallback(outForward, fallbackForward)
	end

	if roadFrames3D then
		local fx, fy, fz = RoadFrame3D.SampleForwardXYZ(roadFrames3D, distance)

		if fx then
			local sqr = fx * fx + fy * fy + fz * fz

			if sqr > RoadFrame3DEpsilon then
				if pitchMultiplier and math.abs(pitchMultiplier - 1) > RoadFrame3DEpsilon then
					fy = fy * pitchMultiplier

					local inv = 1 / math.sqrt(fx * fx + fy * fy + fz * fz)

					fz = fz * inv
					fy = fy * inv
					fx = fx * inv
				end

				return SetForwardResult(outForward, fx, fy, fz)
			end
		end
	end

	local sampleDistance = math.max(0.5, slope.slopeSampleDistance or 8)
	local beforeDistance = Mathf.Clamp(distance - sampleDistance, slopePath:getStartDistance(), slopePath:getEndDistance())
	local afterDistance = Mathf.Clamp(distance + sampleDistance, slopePath:getStartDistance(), slopePath:getEndDistance())

	if math.abs(afterDistance - beforeDistance) <= 0.001 then
		return ResolveForwardFallback(outForward, fallbackForward)
	end

	slopePath:SampleTo(beforeDistance, lateralOffset, beforePoseCache)
	slopePath:SampleTo(afterDistance, lateralOffset, afterPoseCache)

	local bpx = beforePoseCache.position.x
	local bpz = beforePoseCache.position.y
	local bpy = SnowSlope.SampleHeight(slope, slopePath, beforeDistance)
	local apx = afterPoseCache.position.x
	local apz = afterPoseCache.position.y
	local apy = SnowSlope.SampleHeight(slope, slopePath, afterDistance)
	local sfx = apx - bpx
	local sfy = apy - bpy
	local sfz = apz - bpz

	pitchMultiplier = pitchMultiplier or 1
	sfy = sfy * pitchMultiplier

	local sqr = sfx * sfx + sfy * sfy + sfz * sfz

	if sqr > 0.001 then
		local inv = 1 / math.sqrt(sqr)

		return SetForwardResult(outForward, sfx * inv, sfy * inv, sfz * inv)
	end

	return ResolveForwardFallback(outForward, fallbackForward)
end

return SnowSlope
