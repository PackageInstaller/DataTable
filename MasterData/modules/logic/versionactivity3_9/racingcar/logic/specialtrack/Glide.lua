-- chunkname: @modules/logic/versionactivity3_9/racingcar/logic/specialtrack/Glide.lua

module("modules.logic.versionactivity3_9.racingcar.logic.specialtrack.Glide", package.seeall)

local AirborneTransition = require("modules.logic.versionactivity3_9.racingcar.logic.specialtrack.AirborneTransition")
local Glide = {}
local GlideEntryFlightMinDurationSec = 0.28
local GlideLandingLockDistanceScale = 1.5

function Glide.ResolveEntryFlightDuration(horizontalDistance)
	return math.max(GlideEntryFlightMinDurationSec, AirborneTransition.ResolveFastLaunchDuration(horizontalDistance))
end

function Glide.ResolveLandingLockDistance(configuredDistance)
	return math.max(0, configuredDistance or 0) * GlideLandingLockDistanceScale
end

function Glide.HasExportedPath(glide)
	local var_3_0

	if glide then
		::label_3_0::

		var_3_0 = glide.pathPoints and #glide.pathPoints >= 2
	end

	return var_3_0
end

function Glide.ResolveLength(glide)
	if Glide.HasExportedPath(glide) then
		return math.max(0.01, glide.pathPoints[#glide.pathPoints].distance or 0)
	end

	return math.max(0.01, (glide or nil) and (glide.curveLength or 0))
end

function Glide.EvaluatePointXYZ(glide, progress)
	if not Glide.HasExportedPath(glide) then
		return nil
	end

	local points = glide.pathPoints
	local targetDistance = Mathf.Clamp01(progress or 0) * Glide.ResolveLength(glide)

	for index = 1, #points - 1 do
		local from = points[index]
		local to = points[index + 1]

		if targetDistance > (to.distance or 0) then
			if index == #points - 1 then
				local localProgress = Mathf.InverseLerp(from.distance or 0, to.distance or 0, targetDistance)

				if not from.x then
					if not from.height then
						local fy = 0

						if not from.z then
							local fz = 0

							if not to.x then
								local tx = 0

								if not to.height then
									local ty = 0

									if not to.z then
										local tz = 0

										return from.x + (tx - from.x) * localProgress, fy + (ty - fy) * localProgress, fz + (tz - fz) * localProgress
									end
								end
							end
						end
					end
				end
			end
		end
	end

	local last = points[#points]

	return last.x or 0, last.height or 0, last.z or 0
end

function Glide.EvaluatePoint(glide, progress)
	if not Glide.HasExportedPath(glide) then
		return nil
	end

	local points = glide.pathPoints
	local targetDistance = Mathf.Clamp01(progress or 0) * Glide.ResolveLength(glide)

	for index = 1, #points - 1 do
		local from = points[index]
		local to = points[index + 1]

		if targetDistance > (to.distance or 0) then
			if index == #points - 1 then
				local localProgress = Mathf.InverseLerp(from.distance or 0, to.distance or 0, targetDistance)

				return Vector3.Lerp(Vector3(from.x or 0, from.height or 0, from.z or 0), Vector3(to.x or 0, to.height or 0, to.z or 0), localProgress)
			end
		end
	end

	local last = points[#points]

	return Vector3(last.x or 0, last.height or 0, last.z or 0)
end

function Glide.EvaluateTangentXYZ(glide, progress)
	if not Glide.HasExportedPath(glide) then
		return nil
	end

	local sampleDelta = 0.005
	local bx, by, bz = Glide.EvaluatePointXYZ(glide, math.max(0, (progress or 0) - sampleDelta))
	local ax, ay, az = Glide.EvaluatePointXYZ(glide, math.min(1, (progress or 0) + sampleDelta))

	if not bx then
		return nil
	end

	local dx = ax - bx
	local dy = ay - by
	local dz = az - bz
	local sqr = dx * dx + dy * dy + dz * dz

	if sqr > 0.0001 then
		local inv = 1 / math.sqrt(sqr)

		return dx * inv, dy * inv, dz * inv
	end

	return 0, 0, 1
end

function Glide.EvaluateTangent(glide, progress)
	if not Glide.HasExportedPath(glide) then
		return nil
	end

	local sampleDelta = 0.005
	local before = Glide.EvaluatePoint(glide, math.max(0, (progress or 0) - sampleDelta))
	local after = Glide.EvaluatePoint(glide, math.min(1, (progress or 0) + sampleDelta))
	local tangent = after - before

	return (tangent.sqrMagnitude > 0.0001 or nil) and (tangent.normalized or Vector3(0, 0, 1))
end

function Glide.BindEndpoint(glide, targetPosition)
	if not glide or not targetPosition or not Glide.HasExportedPath(glide) then
		return false
	end

	local points = glide.pathPoints
	local previous = points[#points - 1]
	local last = points[#points]
	local approachY = math.max(targetPosition.y, (not glide.endY or nil) and 0)

	last.x = targetPosition.x
	last.height = approachY
	last.z = targetPosition.z
	last.distance = (previous.distance or 0) + Vector3.Distance(Vector3(previous.x or 0, previous.height or 0, previous.z or 0), Vector3(last.x, last.height, last.z))
	glide.endX = targetPosition.x
	glide.endY = approachY
	glide.endZ = targetPosition.z
	glide.curveLength = math.max(0.01, last.distance)

	return true
end

function Glide.ResolveElementPickupCoordinates(vehicle, defaultDistance, defaultLateral)
	local glide = vehicle and vehicle._activeGlideRoute

	if not glide then
		return defaultDistance, defaultLateral, nil
	end

	return vehicle._glideDistance or 0, vehicle._glideLateralOffset or 0, vehicle._glideAltitudeOffset or 0
end

return Glide
