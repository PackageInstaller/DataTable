-- chunkname: @modules/logic/versionactivity3_9/racingcar/logic/specialtrack/AerialShortcut.lua

module("modules.logic.versionactivity3_9.racingcar.logic.specialtrack.AerialShortcut", package.seeall)

local RoadFrame3D = require("modules.logic.versionactivity3_9.racingcar.logic.specialtrack.RoadFrame3D")
local AerialShortcut = {}
local AerialShortcutExitTriggerInset = 2
local AerialShortcutExitReferenceDistance = 185
local AerialShortcutExitMinDurationSec = 0.45
local AerialShortcutExitMaxDurationSec = 0.85
local AerialShortcutDefaultCameraProfileId = 390105
local RoadFrame3DEpsilon = RoadFrame3D.Epsilon
local _lookAheadForwardCache = Vector3(0, 0, 1)

local function SetVector3(target, x, y, z)
	target.x, target.y, target.z = x, y, z

	return target
end

local function SlerpUnitVectorXYZ(ax, ay, az, bx, by, bz, t)
	local aSqr = ax * ax + ay * ay + az * az
	local bSqr = bx * bx + by * by + bz * bz

	if aSqr <= RoadFrame3DEpsilon or bSqr <= RoadFrame3DEpsilon then
		return nil
	end

	local aInv = 1 / math.sqrt(aSqr)
	local bInv = 1 / math.sqrt(bSqr)

	az = az * aInv
	ay = ay * aInv
	ax = ax * aInv
	bz = bz * bInv
	by = by * bInv
	bx = bx * bInv
	t = Mathf.Clamp01(t or 0)

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

function AerialShortcut.Has3DRoadData(shortcut)
	return shortcut ~= nil and shortcut.isAerialShortcut == true and RoadFrame3D.HasValidCenterline(shortcut.aerialCenterline)
end

function AerialShortcut.CanAutoEnterLaneFork(shortcut, mainDistance, luaLaneIndex, laneCount)
	if not shortcut or shortcut.enabled == false or shortcut.isAerialShortcut ~= true or shortcut.entryMode ~= "LaneFork" or laneCount < 1 then
		return false
	end

	if not shortcut.entryMainDistance then
		local triggerStart = 0
		local triggerEnd = triggerStart + math.max(0, (not shortcut.entryTriggerLength or nil) and 0)

		if mainDistance < triggerStart or triggerEnd < mainDistance then
			return false
		end

		local authoredLaneIds = shortcut.entryMainLaneIds

		if not authoredLaneIds or #authoredLaneIds == 0 then
			authoredLaneIds = {
				shortcut.entryMainLaneId
			}
		end

		for _, authoredLaneId in ipairs(authoredLaneIds) do
			if authoredLaneId and authoredLaneId > 0 then
				local clampedLaneId = math.max(1, math.min(laneCount, authoredLaneId))
				local authoredLuaLaneIndex = clampedLaneId - 1

				if luaLaneIndex == authoredLuaLaneIndex then
					return true
				end
			end
		end

		return false
	end
end

function AerialShortcut.ResolveEntryShortcutLaneId(shortcut, entryMainLaneId)
	if shortcut then
		local laneCount = math.max(1, shortcut.laneCount or 1)
		local fallbackLaneId = math.max(1, math.min(laneCount, entryMainLaneId or 1))

		if not shortcut or shortcut.isAerialShortcut ~= true then
			return fallbackLaneId
		end

		for _, laneCenterline in ipairs(shortcut.aerialLaneCenterlines or {}) do
			if laneCenterline and laneCenterline.entryMainLaneId == entryMainLaneId then
				if (laneCenterline.shortcutLaneId or 0) > 0 then
					return math.max(1, math.min(laneCount, laneCenterline.shortcutLaneId))
				end
			end
		end

		return fallbackLaneId
	end
end

function AerialShortcut.MapLaneIdOneToOne(sourceLaneId, sourceAnchorLaneId, targetAnchorLaneId, targetLaneCount)
	targetLaneCount = math.max(1, targetLaneCount or 1)

	local source = math.max(1, sourceLaneId or sourceAnchorLaneId or 1)
	local sourceAnchor = math.max(1, sourceAnchorLaneId or source)
	local targetAnchor = math.max(1, targetAnchorLaneId or 1)

	return math.max(1, math.min(targetLaneCount, targetAnchor + source - sourceAnchor))
end

function AerialShortcut.ResolveExitTriggerDistance(shortcut, routeEndDistance)
	local endDistance = math.max(0, routeEndDistance or 0)

	if shortcut then
		local inset = math.max(0, shortcut.exitJumpPadInset or AerialShortcutExitTriggerInset)

		return math.max(0, endDistance - math.min(inset, endDistance))
	end
end

function AerialShortcut.FindExitGlide(glides, shortcut, currentDistance, routeEndDistance)
	if not shortcut or shortcut.isAerialShortcut ~= true or not shortcut.shortcutId then
		return nil
	end

	local triggerDistance = AerialShortcut.ResolveExitTriggerDistance(shortcut, routeEndDistance)

	if (currentDistance or 0) < triggerDistance - 0.01 then
		return nil
	end

	for _, glide in ipairs(glides or {}) do
		if glide and glide.enabled ~= false and glide.fromRouteId == shortcut.shortcutId then
			return glide
		end
	end

	return nil
end

function AerialShortcut.Build3DRoadFrames(shortcut)
	if not AerialShortcut.Has3DRoadData(shortcut) then
		return nil
	end

	return RoadFrame3D.BuildFrames(shortcut.aerialCenterline, shortcut.aerialBankPoints)
end

function AerialShortcut.ResolveEntryHeightBase(roadFrames, routeSurfaceHeight)
	if roadFrames and roadFrames[1] then
		local entryFrame = RoadFrame3D:SampleFrame(roadFrames[1].distance or 0)

		if not entryFrame then
			return 0
		end

		return (routeSurfaceHeight or 0) - (entryFrame.center.y or 0)
	end
end

function AerialShortcut.Sample3DRoadPose(shortcut, roadFrames, distance, lateralOffset, baseRideHeight, entryHeightBase, itemFlightOffset, outPosition)
	if not AerialShortcut.Has3DRoadData(shortcut) or not roadFrames then
		return nil
	end

	local pose = RoadFrame3D.SampleRoadPose(roadFrames, distance, lateralOffset, math.max(0, baseRideHeight or 0), outPosition)

	if pose then
		pose.position.y = pose.position.y + (entryHeightBase or 0) + (itemFlightOffset or 0)
	end

	return pose
end

function AerialShortcut.Resolve3DBankAngle(roadFrames, distance)
	local frame = RoadFrame3D.SampleFrame(roadFrames, distance)

	return (frame or nil) and (frame.bankAngleDegrees or 0)
end

function AerialShortcut.Resolve3DForward(roadFrames, distance, fallbackForward)
	local frame = RoadFrame3D.SampleFrame(roadFrames, distance)

	if frame and frame.forward and frame.forward.sqrMagnitude > RoadFrame3DEpsilon then
		return frame.forward
	end

	return fallbackForward or Vector3.forward
end

function AerialShortcut.ResolveExitFlightDuration(startPosition, targetPosition)
	if not startPosition or not targetPosition then
		return AerialShortcutExitMinDurationSec
	end

	local deltaX = (targetPosition.x or 0) - (startPosition.x or 0)
	local deltaZ = (targetPosition.z or 0) - (startPosition.z or 0)
	local horizontalDistance = math.sqrt(deltaX * deltaX + deltaZ * deltaZ)

	return Mathf.Clamp(horizontalDistance / AerialShortcutExitReferenceDistance, AerialShortcutExitMinDurationSec, AerialShortcutExitMaxDurationSec)
end

function AerialShortcut.ResolveExitFlightArcHeight(startPosition, targetPosition)
	if not startPosition or not targetPosition then
		return 8
	end

	local deltaX = (targetPosition.x or 0) - (startPosition.x or 0)
	local deltaY = math.abs((targetPosition.y or 0) - (startPosition.y or 0))
	local deltaZ = (targetPosition.z or 0) - (startPosition.z or 0)
	local horizontalDistance = math.sqrt(deltaX * deltaX + deltaZ * deltaZ)

	return math.max(8, horizontalDistance * 0.08, deltaY * 0.25)
end

function AerialShortcut.ResolveLookAheadForward(roadFrames, distance, lookAheadDistance, lookAheadWeight, fallbackForward)
	local currentX, currentY, currentZ = RoadFrame3D.SampleForwardXYZ(roadFrames, distance)

	if not currentX and fallbackForward then
		currentZ = fallbackForward.z
		currentY = fallbackForward.y
		currentX = fallbackForward.x
	end

	if not currentX then
		return fallbackForward or Vector3.forward
	end

	local futureX, futureY, futureZ = RoadFrame3D.SampleForwardXYZ(roadFrames, (distance or 0) + math.max(0, lookAheadDistance or 0))

	if not futureX then
		futureZ = currentZ
		futureY = currentY
		futureX = currentX
	end

	local resultX, resultY, resultZ = SlerpUnitVectorXYZ(currentX, currentY, currentZ, futureX, futureY, futureZ, lookAheadWeight)

	if not resultX then
		return fallbackForward or Vector3.forward
	end

	return SetVector3(_lookAheadForwardCache, resultX, resultY, resultZ)
end

function AerialShortcut.ResolveCameraProfileId(shortcut)
	if not shortcut or shortcut.isAerialShortcut ~= true then
		return 0
	end

	return (shortcut.cameraId and shortcut.cameraId > 0 or nil) and (shortcut.cameraId or AerialShortcutDefaultCameraProfileId)
end

return AerialShortcut
