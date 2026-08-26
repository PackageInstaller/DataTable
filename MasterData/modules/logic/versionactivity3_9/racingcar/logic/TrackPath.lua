-- chunkname: @modules/logic/versionactivity3_9/racingcar/logic/TrackPath.lua

module("modules.logic.versionactivity3_9.racingcar.logic.TrackPath", package.seeall)

local TrackPath = class("TrackPath")
local SmoothSampleSpacing = 12
local MinimumSmoothSubdivisions = 4
local MaximumSmoothSubdivisions = 24
local Epsilon = 0.0001
local VisualPoseSharpTurnStartDot = math.cos(20 * math.pi / 180)
local VisualPoseSharpTurnFullDot = math.cos(60 * math.pi / 180)
local VisualPoseSharpTurnMaxRadiusMultiplier = 2.5
local ProjectLocalSearchRange = 80
local ProjectLocalMinSegments = 6
local ProjectLocalMaxSegments = 40
local ProjectLocalFallbackSqrError = 900
local math_max = math.max
local math_min = math.min
local math_sqrt = math.sqrt
local math_ceil = math.ceil
local math_huge = math.huge
local math_floor = math.floor
local table_sort = table.sort

function TrackPath:ctor(roadWidth, centerline, isLoop)
	self._roadWidth = math_max(0.01, roadWidth or 1)
	self._centerline = centerline or {}
	self._halfRoadWidth = self._roadWidth * 0.5
	self._isValid = #self._centerline > 0

	if self._isValid then
		self._startDistance = self._centerline[1].distance or 0
	end

	if self._isValid then
		self._endDistance = self._centerline[#self._centerline].distance or 0
	end

	self._isLoop = isLoop or false
	self._trackLength = self._endDistance - self._startDistance
end

function TrackPath.FromConfig(pathConfig)
	if not pathConfig then
		return TrackPath.New(1, {}, false)
	end

	if not pathConfig.centerline then
		local points = {}

		table_sort(points, function(a, b)
			return a.distance < b.distance
		end)

		local smoothCenterline = TrackPath._BuildSmoothCenterline(points)

		return TrackPath.New(pathConfig.roadWidth or 16, smoothCenterline, pathConfig.isLoop or false)
	end
end

function TrackPath:WrapDistance(distance)
	if self._isLoop and self._trackLength > Epsilon then
		local relative = (distance - self._startDistance) % self._trackLength

		if relative < 0 then
			relative = relative + self._trackLength
		end

		return self._startDistance + relative
	end

	if distance < self._startDistance then
		return self._startDistance
	end

	if distance > self._endDistance then
		return self._endDistance
	end

	return distance
end

function TrackPath:Sample(distance, lateralOffset)
	local result = {
		center = {},
		tangent = {},
		normal = {},
		position = {}
	}

	self:SampleTo(distance, lateralOffset, result)

	return result
end

function TrackPath:SampleTo(distance, lateralOffset, outPose)
	lateralOffset = lateralOffset or 0
	distance = self:WrapDistance(distance)

	local centerline = self._centerline
	local count = #centerline

	outPose.distance = distance
	outPose.lateralOffset = lateralOffset

	if count == 0 then
		outPose.center = outPose.center or {}
		outPose.center.x = 0
		outPose.center.y = distance
		outPose.tangent = outPose.tangent or {}
		outPose.tangent.x = 0
		outPose.tangent.y = 1
		outPose.normal = outPose.normal or {}
		outPose.normal.x = -1
		outPose.normal.y = 0
		outPose.position = outPose.position or {}
		outPose.position.x = -lateralOffset
		outPose.position.y = distance

		return
	end

	if count == 1 then
		local point = centerline[1]

		outPose.distance = point.distance
		outPose.center = outPose.center or {}
		outPose.center.x = point.x
		outPose.center.y = point.y
		outPose.tangent = outPose.tangent or {}
		outPose.tangent.x = 0
		outPose.tangent.y = 1
		outPose.normal = outPose.normal or {}
		outPose.normal.x = -1
		outPose.normal.y = 0
		outPose.position = outPose.position or {}
		outPose.position.x = point.x - lateralOffset
		outPose.position.y = point.y

		return
	end

	local segmentIndex = self:_FindSegmentIndex(distance)
	local from = centerline[segmentIndex]
	local to = centerline[segmentIndex + 1]
	local dx = to.x - from.x
	local dy = to.y - from.y
	local segmentLength = to.distance - from.distance

	if segmentLength < Epsilon then
		segmentLength = Epsilon
	end

	local t = distance - from.distance

	t = t <= 0 and 0 or segmentLength <= t and 1 or t / segmentLength

	local cx = from.x + dx * t
	local cy = from.y + dy * t
	local tangentLenSq = dx * dx + dy * dy
	local tx, ty

	if tangentLenSq > Epsilon * Epsilon then
		local tangentLen = math_sqrt(tangentLenSq)
		local invLen = 1 / tangentLen

		tx = dx * invLen
		ty = dy * invLen
	else
		tx = 0
		ty = 1
	end

	local nx = -ty
	local ny = tx
	local clampedLateral = self:ClampLateral(lateralOffset)

	outPose.lateralOffset = clampedLateral
	outPose.center = outPose.center or {}
	outPose.center.x = cx
	outPose.center.y = cy
	outPose.tangent = outPose.tangent or {}
	outPose.tangent.x = tx
	outPose.tangent.y = ty
	outPose.normal = outPose.normal or {}
	outPose.normal.x = nx
	outPose.normal.y = ny
	outPose.position = outPose.position or {}
	outPose.position.x = cx + nx * clampedLateral
	outPose.position.y = cy + ny * clampedLateral
end

function TrackPath:SampleVisualPoseTo(distance, lateralOffset, sampleRadius, outPose, beforePose, afterPose)
	sampleRadius = math_max(0.01, sampleRadius or 0.01)

	self:SampleTo(distance, 0, outPose)
	self:SampleTo(distance - sampleRadius, 0, beforePose)
	self:SampleTo(distance + sampleRadius, 0, afterPose)

	local turnDot = math_max(-1, math_min(1, beforePose.tangent.x * afterPose.tangent.x + beforePose.tangent.y * afterPose.tangent.y))

	if turnDot < VisualPoseSharpTurnStartDot then
		local sharpTurn01 = math_max(0, math_min(1, (VisualPoseSharpTurnStartDot - turnDot) / math_max(Epsilon, VisualPoseSharpTurnStartDot - VisualPoseSharpTurnFullDot)))
		local expandedRadius = sampleRadius * (1 + (VisualPoseSharpTurnMaxRadiusMultiplier - 1) * sharpTurn01)

		self:SampleTo(distance - expandedRadius, 0, beforePose)
		self:SampleTo(distance + expandedRadius, 0, afterPose)
	end

	local dx = afterPose.center.x - beforePose.center.x
	local dy = afterPose.center.y - beforePose.center.y
	local tangentLenSq = dx * dx + dy * dy
	local tx = outPose.tangent.x
	local ty = outPose.tangent.y

	if tangentLenSq > Epsilon * Epsilon then
		local invLen = 1 / math_sqrt(tangentLenSq)

		tx = dx * invLen
		ty = dy * invLen
	end

	local nx = -ty
	local ny = tx
	local clampedLateral = self:ClampLateral(lateralOffset or 0)

	outPose.lateralOffset = clampedLateral
	outPose.tangent.x = tx
	outPose.tangent.y = ty
	outPose.normal.x = nx
	outPose.normal.y = ny
	outPose.position.x = outPose.center.x + nx * clampedLateral
	outPose.position.y = outPose.center.y + ny * clampedLateral
end

function TrackPath:Project(worldPoint)
	local result = {}

	self:ProjectTo(worldPoint, result)

	return result
end

function TrackPath:ProjectTo(worldPoint, outProjection)
	local centerline = self._centerline
	local count = #centerline

	if count == 0 then
		outProjection.distance = 0
		outProjection.lateralOffset = 0
		outProjection.sqrError = math_huge

		return
	end

	if count == 1 then
		local point = centerline[1]
		local dx = worldPoint.x - point.x
		local dy = worldPoint.y - point.y

		outProjection.distance = point.distance
		outProjection.lateralOffset = 0
		outProjection.sqrError = dx * dx + dy * dy

		return
	end

	local bestDistance = 0
	local bestLateral = 0
	local bestSqrError = math_huge
	local wx = worldPoint.x
	local wy = worldPoint.y

	for i = 1, count - 1 do
		local a = centerline[i]
		local b = centerline[i + 1]
		local sx = a.x
		local sy = a.y
		local segX = b.x - sx
		local segY = b.y - sy
		local relX = wx - sx
		local relY = wy - sy
		local segmentSqr = segX * segX + segY * segY

		if segmentSqr < Epsilon then
			segmentSqr = Epsilon
		end

		local dot = relX * segX + relY * segY
		local t = dot <= 0 and 0 or segmentSqr <= dot and 1 or dot / segmentSqr
		local cx = sx + segX * t
		local cy = sy + segY * t
		local deltaX = wx - cx
		local deltaY = wy - cy
		local sqrError = deltaX * deltaX + deltaY * deltaY

		if sqrError < bestSqrError then
			local segLen = math_sqrt(segmentSqr)
			local nx, ny

			if segLen > Epsilon then
				local invLen = 1 / segLen

				nx = -segY * invLen
				ny = segX * invLen
			else
				nx = -1
				ny = 0
			end

			bestDistance = a.distance + (b.distance - a.distance) * t
			bestLateral = deltaX * nx + deltaY * ny
			bestSqrError = sqrError
		end
	end

	outProjection.distance = bestDistance
	outProjection.lateralOffset = bestLateral
	outProjection.sqrError = bestSqrError
end

function TrackPath:ProjectToByDistance(worldPoint, outProjection, hintDistance)
	local centerline = self._centerline
	local count = #centerline

	if count == 0 then
		outProjection.distance = 0
		outProjection.lateralOffset = 0
		outProjection.sqrError = math_huge

		return
	end

	if count == 1 then
		local point = centerline[1]
		local dx = worldPoint.x - point.x
		local dy = worldPoint.y - point.y

		outProjection.distance = point.distance
		outProjection.lateralOffset = 0
		outProjection.sqrError = dx * dx + dy * dy

		return
	end

	hintDistance = self:WrapDistance(hintDistance or self._startDistance)

	local avgSpacing = self._trackLength / (count - 1)

	if avgSpacing < Epsilon then
		avgSpacing = SmoothSampleSpacing
	end

	local halfSegments = math_floor(ProjectLocalSearchRange * 0.5 / avgSpacing)

	halfSegments = math_max(ProjectLocalMinSegments, math_min(ProjectLocalMaxSegments, halfSegments))

	local centerIndex = self:_FindSegmentIndex(hintDistance)
	local startIndex = math_max(1, centerIndex - halfSegments)
	local endIndex = math_min(count - 1, centerIndex + halfSegments)
	local bestDistance = 0
	local bestLateral = 0
	local bestSqrError = math_huge
	local wx = worldPoint.x
	local wy = worldPoint.y

	for i = startIndex, endIndex do
		local a = centerline[i]
		local b = centerline[i + 1]
		local sx = a.x
		local sy = a.y
		local segX = b.x - sx
		local segY = b.y - sy
		local relX = wx - sx
		local relY = wy - sy
		local segmentSqr = segX * segX + segY * segY

		if segmentSqr < Epsilon then
			segmentSqr = Epsilon
		end

		local dot = relX * segX + relY * segY
		local t = dot <= 0 and 0 or segmentSqr <= dot and 1 or dot / segmentSqr
		local cx = sx + segX * t
		local cy = sy + segY * t
		local deltaX = wx - cx
		local deltaY = wy - cy
		local sqrError = deltaX * deltaX + deltaY * deltaY

		if sqrError < bestSqrError then
			local segLen = math_sqrt(segmentSqr)
			local nx, ny

			if segLen > Epsilon then
				local invLen = 1 / segLen

				nx = -segY * invLen
				ny = segX * invLen
			else
				nx = -1
				ny = 0
			end

			bestDistance = a.distance + (b.distance - a.distance) * t
			bestLateral = deltaX * nx + deltaY * ny
			bestSqrError = sqrError
		end
	end

	if bestSqrError > ProjectLocalFallbackSqrError then
		self:ProjectTo(worldPoint, outProjection)

		return
	end

	outProjection.distance = bestDistance
	outProjection.lateralOffset = bestLateral
	outProjection.sqrError = bestSqrError
end

function TrackPath:ClampLateral(lateralOffset)
	if lateralOffset < -self._halfRoadWidth then
		return -self._halfRoadWidth
	end

	if lateralOffset > self._halfRoadWidth then
		return self._halfRoadWidth
	end

	return lateralOffset
end

function TrackPath:LaneToLateralOffset(laneIndex, laneCount)
	if laneCount <= 1 then
		return 0
	end

	local lane = laneIndex

	if lane < 0 then
		lane = 0
	elseif lane > laneCount - 1 then
		lane = laneCount - 1
	end

	local laneWidth = self._roadWidth / laneCount

	return self._halfRoadWidth - laneWidth * 0.5 - lane * laneWidth
end

function TrackPath:_FindSegmentIndex(distance)
	local centerline = self._centerline
	local count = #centerline

	if distance <= centerline[1].distance then
		return 1
	end

	if distance >= centerline[count].distance then
		return count - 1
	end

	local lo = 1
	local hi = count
	local iterationCount = 0

	while lo < hi do
		iterationCount = iterationCount + 1

		if iterationCount > 64 then
			logError(string.format("TrackPath:_FindSegmentIndex exceeded iteration limit, distance=%s lo=%s hi=%s count=%s", tostring(distance), tostring(lo), tostring(hi), tostring(count)))

			break
		end

		local mid = math_floor((lo + hi) * 0.5)

		if distance > centerline[mid].distance then
			lo = mid + 1
		else
			hi = mid
		end
	end

	if lo > 1 then
		return lo - 1
	end

	return 1
end

function TrackPath._BuildSmoothCenterline(rawPoints)
	if rawPoints then
		if not #rawPoints then
			local rawCount = 0

			if rawCount < 3 then
				return rawPoints or {}
			end

			local estimatedCount = 1

			for i = 1, rawCount - 1 do
				estimatedCount = estimatedCount + TrackPath._ResolveSubdivisions(rawPoints[i], rawPoints[i + 1])
			end

			local smoothed = {}
			local writeIndex = 1

			for segmentIndex = 1, rawCount - 1 do
				local p0 = rawPoints[math_max(1, segmentIndex - 1)]
				local p1 = rawPoints[segmentIndex]
				local p2 = rawPoints[segmentIndex + 1]
				local p3 = rawPoints[math_min(rawCount, segmentIndex + 2)]
				local subdivisions = TrackPath._ResolveSubdivisions(p1, p2)
				local startStep = segmentIndex == 1 and 0 or 1

				for step = startStep, subdivisions do
					local t = step / subdivisions

					smoothed[writeIndex] = {
						distance = TrackPath._Lerp(p1.distance, p2.distance, t),
						x = TrackPath._CatmullRom(p0.x, p1.x, p2.x, p3.x, t),
						y = TrackPath._CatmullRom(p0.y, p1.y, p2.y, p3.y, t)
					}
					writeIndex = writeIndex + 1
				end
			end

			return smoothed
		end
	end
end

function TrackPath._ResolveSubdivisions(from, to)
	local distanceSpan = to.distance - from.distance

	if distanceSpan < Epsilon then
		distanceSpan = Epsilon
	end

	local byDistance = math_ceil(distanceSpan / SmoothSampleSpacing)

	return math_max(MinimumSmoothSubdivisions, math_min(MaximumSmoothSubdivisions, byDistance))
end

function TrackPath._CatmullRom(p0, p1, p2, p3, t)
	local t2 = t * t
	local t3 = t2 * t

	return 0.5 * (2 * p1 + (p2 - p0) * t + (2 * p0 - 5 * p1 + 4 * p2 - p3) * t2 + (-p0 + 3 * p1 - 3 * p2 + p3) * t3)
end

function TrackPath._Lerp(a, b, t)
	return a + (b - a) * t
end

function TrackPath:getRoadWidth()
	return self._roadWidth
end

function TrackPath:getHalfRoadWidth()
	return self._halfRoadWidth
end

function TrackPath:getIsValid()
	return self._isValid
end

function TrackPath:getStartDistance()
	return self._startDistance
end

function TrackPath:getEndDistance()
	return self._endDistance
end

function TrackPath:getIsLoop()
	return self._isLoop
end

function TrackPath:getTrackLength()
	return self._trackLength
end

return TrackPath
