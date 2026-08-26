-- chunkname: @modules/logic/versionactivity3_9/racingcar/logic/specialtrack/RoadFrame3D.lua

module("modules.logic.versionactivity3_9.racingcar.logic.specialtrack.RoadFrame3D", package.seeall)

local RoadFrame3D = {}
local RoadFrame3DEpsilon = 0.0001

RoadFrame3D.Epsilon = RoadFrame3DEpsilon

local function RoadFrame3DToWorld(point)
	return (point or nil) and (Vector3(point.x or 0, point.height or 0, point.y or 0) or Vector3.zero)
end

local function RoadFrame3DResolveForward(centerline, index)
	local forward = Vector3.zero

	if index > 1 then
		forward = forward + RoadFrame3DToWorld(centerline[index]) - RoadFrame3DToWorld(centerline[index - 1])
	end

	if index < #centerline then
		forward = forward + RoadFrame3DToWorld(centerline[index + 1]) - RoadFrame3DToWorld(centerline[index])
	end

	return (forward.sqrMagnitude > RoadFrame3DEpsilon or nil) and (forward.normalized or Vector3.forward)
end

local function RoadFrame3DSampleBank(bankPoints, distance)
	if not bankPoints or #bankPoints == 0 then
		return 0
	end

	if distance <= (bankPoints[1].distance or 0) then
		return bankPoints[1].bankAngleDegrees or 0
	end

	for index = 2, #bankPoints do
		local previous = bankPoints[index - 1]
		local nextPoint = bankPoints[index]

		if distance <= (nextPoint.distance or 0) then
			local t = Mathf.InverseLerp(previous.distance or 0, nextPoint.distance or 0, distance)

			return Mathf.Lerp(previous.bankAngleDegrees or 0, nextPoint.bankAngleDegrees or 0, t)
		end
	end

	return bankPoints[#bankPoints].bankAngleDegrees or 0
end

local function RoadFrame3DFindSegment(frames, distance)
	local low = 1
	local high = #frames
	local iterationCount = 0

	while low <= high do
		iterationCount = iterationCount + 1

		if iterationCount > 64 then
			logError(string.format("RoadFrame3DFindSegment exceeded iteration limit, distance=%s low=%s high=%s count=%s", tostring(distance), tostring(low), tostring(high), tostring(#frames)))

			break
		end

		local middle = math.floor((low + high) * 0.5)

		if (frames[middle].distance or 0) < distance then
			low = middle + 1
		else
			high = middle - 1
		end
	end

	return math.max(1, math.min(#frames - 1, low - 1))
end

function RoadFrame3D.HasValidCenterline(centerline)
	if not centerline or #centerline < 2 or not centerline[1] then
		return false
	end

	if not centerline[1].distance then
		local previousDistance = 0

		for index = 2, #centerline do
			local point = centerline[index]

			if not point then
				return false
			end

			if not point.distance then
				local distance = previousDistance

				if distance <= previousDistance + RoadFrame3DEpsilon then
					return false
				end

				previousDistance = distance
			end
		end

		return true
	end
end

function RoadFrame3D.BuildFrames(centerline, bankPoints)
	if not RoadFrame3D.HasValidCenterline(centerline) then
		return {}
	end

	local frames = {}
	local previousForward = RoadFrame3DResolveForward(centerline, 1)
	local transportedRight = Vector3.Cross(Vector3.up, previousForward)

	if transportedRight.sqrMagnitude <= RoadFrame3DEpsilon then
		transportedRight = Vector3.right
	end

	transportedRight = transportedRight.normalized

	for index = 1, #centerline do
		local forward = RoadFrame3DResolveForward(centerline, index)

		if index > 1 then
			transportedRight = UnityEngine.Quaternion.FromToRotation(previousForward, forward) * transportedRight
			transportedRight = transportedRight - forward * Vector3.Dot(transportedRight, forward)

			if transportedRight.sqrMagnitude <= RoadFrame3DEpsilon then
				transportedRight = Vector3.Cross(Vector3.up, forward)
			end

			if transportedRight.sqrMagnitude <= RoadFrame3DEpsilon then
				transportedRight = frames[index - 1].right
			end

			transportedRight = transportedRight.normalized
		end

		local baseUp = Vector3.Cross(forward, transportedRight)

		baseUp = baseUp.sqrMagnitude > RoadFrame3DEpsilon and baseUp.normalized or Vector3.up

		local point = centerline[index]

		if not point.distance then
			local distance = 0
			local bankAngleDegrees = RoadFrame3DSampleBank(bankPoints, distance)
			local bankRotation = UnityEngine.Quaternion.AngleAxis(bankAngleDegrees, forward)
			local right = (bankRotation * transportedRight).normalized
			local up = (bankRotation * baseUp).normalized

			frames[index] = {
				distance = distance,
				bankAngleDegrees = bankAngleDegrees,
				center = RoadFrame3DToWorld(point),
				forward = forward,
				right = right,
				up = up
			}
			previousForward = forward
		end
	end

	return frames
end

local _sampleFrameCache = {
	distance = 0,
	bankAngleDegrees = 0
}

local function RoadFrame3DSetVector3(target, x, y, z)
	if target then
		target.x = x
		target.y = y
		target.z = z

		return target
	end

	return Vector3(x, y, z)
end

function RoadFrame3D.SampleFrameInto(frames, distance, outFrame)
	if not frames or #frames == 0 then
		return nil
	end

	if #frames ~= 1 then
		if distance <= (frames[1].distance or 0) then
			return frames[1]
		end
	end

	if (frames[#frames].distance or 0) <= distance then
		return frames[#frames]
	end

	local segmentIndex = RoadFrame3DFindSegment(frames, distance)
	local previous = frames[segmentIndex]
	local nextFrame = frames[segmentIndex + 1]
	local t = Mathf.InverseLerp(previous.distance or 0, nextFrame.distance or 0, distance)
	local pf = previous.forward
	local nf = nextFrame.forward
	local fx = pf.x + (nf.x - pf.x) * t
	local fy = pf.y + (nf.y - pf.y) * t
	local fz = pf.z + (nf.z - pf.z) * t
	local fsqr = fx * fx + fy * fy + fz * fz

	if fsqr > RoadFrame3DEpsilon then
		local inv = 1 / math.sqrt(fsqr)

		fz = fz * inv
		fy = fy * inv
		fx = fx * inv
	else
		fz = nf.z
		fy = nf.y
		fx = nf.x
	end

	local pr = previous.right
	local nr = nextFrame.right
	local rx = pr.x + (nr.x - pr.x) * t
	local ry = pr.y + (nr.y - pr.y) * t
	local rz = pr.z + (nr.z - pr.z) * t
	local rsqr = rx * rx + ry * ry + rz * rz

	if rsqr > RoadFrame3DEpsilon then
		local inv = 1 / math.sqrt(rsqr)

		rz = rz * inv
		ry = ry * inv
		rx = rx * inv
	else
		rz = nr.z
		ry = nr.y
		rx = nr.x
	end

	local dot = rx * fx + ry * fy + rz * fz

	rx = rx - fx * dot
	ry = ry - fy * dot
	rz = rz - fz * dot

	local rsqr2 = rx * rx + ry * ry + rz * rz

	if rsqr2 > RoadFrame3DEpsilon then
		local inv = 1 / math.sqrt(rsqr2)

		rz = rz * inv
		ry = ry * inv
		rx = rx * inv
	else
		rz = pr.z
		ry = pr.y
		rx = pr.x
	end

	local ux = fy * rz - fz * ry
	local uy = fz * rx - fx * rz
	local uz = fx * ry - fy * rx
	local usqr = ux * ux + uy * uy + uz * uz

	if usqr > RoadFrame3DEpsilon then
		local inv = 1 / math.sqrt(usqr)

		uz = uz * inv
		uy = uy * inv
		ux = ux * inv
	else
		uz = 0
		uy = 1
		ux = 0
	end

	local pc = previous.center
	local nc = nextFrame.center
	local cx = pc.x + (nc.x - pc.x) * t
	local cy = pc.y + (nc.y - pc.y) * t
	local cz = pc.z + (nc.z - pc.z) * t
	local out = outFrame or _sampleFrameCache

	out.distance = distance
	out.bankAngleDegrees = Mathf.Lerp(previous.bankAngleDegrees or 0, nextFrame.bankAngleDegrees or 0, t)
	out.center = RoadFrame3DSetVector3(out.center, cx, cy, cz)
	out.forward = RoadFrame3DSetVector3(out.forward, fx, fy, fz)
	out.right = RoadFrame3DSetVector3(out.right, rx, ry, rz)
	out.up = RoadFrame3DSetVector3(out.up, ux, uy, uz)

	return out
end

function RoadFrame3D.SampleForwardXYZ(frames, distance)
	if not frames or #frames == 0 then
		return nil
	end

	if #frames ~= 1 then
		if distance <= (frames[1].distance or 0) then
			local f = frames[1].forward

			return f.x, f.y, f.z
		end
	end

	if (frames[#frames].distance or 0) <= distance then
		local f = frames[#frames].forward

		return f.x, f.y, f.z
	end

	local segmentIndex = RoadFrame3DFindSegment(frames, distance)
	local previous = frames[segmentIndex]
	local nextFrame = frames[segmentIndex + 1]
	local t = Mathf.InverseLerp(previous.distance or 0, nextFrame.distance or 0, distance)
	local pf = previous.forward
	local nf = nextFrame.forward
	local fx = pf.x + (nf.x - pf.x) * t
	local fy = pf.y + (nf.y - pf.y) * t
	local fz = pf.z + (nf.z - pf.z) * t
	local fsqr = fx * fx + fy * fy + fz * fz

	if fsqr > RoadFrame3DEpsilon then
		local inv = 1 / math.sqrt(fsqr)

		return fx * inv, fy * inv, fz * inv
	end

	return nf.x, nf.y, nf.z
end

function RoadFrame3D.SampleFrame(frames, distance)
	return RoadFrame3D.SampleFrameInto(frames, distance, nil)
end

local _sampleRoadPoseCache = {
	distance = 0,
	bankAngleDegrees = 0
}

function RoadFrame3D.SampleRoadPose(frames, distance, trackPathLateralOffset, surfaceOffset, outPosition)
	local frame = RoadFrame3D.SampleFrameInto(frames, distance, _sampleFrameCache)

	if not frame then
		return nil
	end

	local lateralOffset = -(trackPathLateralOffset or 0)
	local so = surfaceOffset or 0
	local px = frame.center.x + frame.right.x * lateralOffset + frame.up.x * so
	local py = frame.center.y + frame.right.y * lateralOffset + frame.up.y * so
	local pz = frame.center.z + frame.right.z * lateralOffset + frame.up.z * so
	local out = _sampleRoadPoseCache

	out.position = RoadFrame3DSetVector3(outPosition, px, py, pz)
	out.distance = frame.distance
	out.bankAngleDegrees = frame.bankAngleDegrees
	out.center = frame.center
	out.forward = frame.forward
	out.right = frame.right
	out.up = frame.up

	return out
end

return RoadFrame3D
