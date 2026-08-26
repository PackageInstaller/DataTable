-- chunkname: @modules/logic/versionactivity3_9/racingcar/logic/feedback/RacingSpecialTrackRecommendationPresentation.lua

module("modules.logic.versionactivity3_9.racingcar.logic.feedback.RacingSpecialTrackRecommendationPresentation", package.seeall)

local WaterfallClimb = require("modules.logic.versionactivity3_9.racingcar.logic.specialtrack.WaterfallClimb")
local RacingSpecialTrackRecommendationPresentation = {}
local DefaultLaneCount = 4
local Epsilon = 0.0001

local function NewPoseCache()
	return {
		center = {},
		tangent = {},
		normal = {},
		position = {}
	}
end

local StraightStartPose = NewPoseCache()
local StraightEndPose = NewPoseCache()
local StraightSamplePose = NewPoseCache()
local PlacementPose = NewPoseCache()
local RecommendationConfig = {
	ShortSegmentLength = 40,
	MaxChordDeviation = 2,
	EntryClearance = 20,
	MaxSegmentCount = 4,
	SearchStep = 5,
	ShortPrefabForwardOffset = 7.08,
	MaxHeadingDeltaDeg = 10,
	SegmentLength = 60,
	SegmentOverlap = 3,
	LookbackDistance = 400,
	PathSampleStep = 5
}
local RouteEntryDefinitions = {
	{
		ListName = "transfers",
		EntryType = "Transfer",
		IdField = "transferId"
	},
	{
		ListName = "waterDrops",
		EntryType = "WaterDrop",
		IdField = "dropId"
	},
	{
		ListName = "glides",
		ExcludeShortcutExit = true,
		EntryType = "Glide",
		IdField = "glideId"
	},
	{
		ListName = "underwaterRoutes",
		EntryType = "Underwater",
		IdField = "underwaterId"
	},
	{
		ListName = "snowSlopeRoutes",
		EntryType = "SnowSlope",
		IdField = "slopeId"
	},
	{
		ListName = "waterfallClimbRoutes",
		IsWaterfall = true,
		EntryType = "WaterfallClimb",
		IdField = "climbId"
	}
}

local function EqualsIgnoreCase(left, right)
	return string.lower(tostring(left or "")) == string.lower(tostring(right or ""))
end

local function IsMainRoute(routeId)
	return routeId == nil or routeId == "" or EqualsIgnoreCase(routeId, "Main")
end

local function ResolveMainLaneCount(trackConfig)
	if trackConfig then
		::label_4_0::

		local var_4_0 = trackConfig.editorAuthoring

		if trackConfig.editorAuthoring then
			local payload = trackConfig.editorAuthoring.payload
			local trackData = payload and payload.trackData
			local settings = trackData and trackData.settings

			return math.max(1, math.floor(((settings or nil) and (settings.laneCount or DefaultLaneCount)) + 0.5))
		end
	end
end

local function ResolveLaneIds(laneIds, fallbackLaneId, laneCount, expandWaterfallLane)
	local safeLaneCount = math.max(1, laneCount or DefaultLaneCount)
	local resolved = {}
	local seen = {}

	for _, rawLaneId in ipairs(laneIds or {}) do
		local laneId = math.max(1, math.min(safeLaneCount, math.floor((rawLaneId or 1) + 0.5)))

		if not seen[laneId] then
			seen[laneId] = true

			table.insert(resolved, laneId)
		end
	end

	if #resolved == 0 then
		local fallback = math.max(1, math.min(safeLaneCount, math.floor((fallbackLaneId or 1) + 0.5)))

		seen[fallback] = true

		table.insert(resolved, fallback)
	end

	if expandWaterfallLane and #resolved == 1 and safeLaneCount > 1 then
		local anchorLaneId = resolved[1]

		if safeLaneCount <= anchorLaneId then
			if not (anchorLaneId - 1) then
				local adjacentLaneId = anchorLaneId + 1

				if not seen[adjacentLaneId] then
					table.insert(resolved, adjacentLaneId)
				end
			end
		end
	end

	table.sort(resolved)

	return resolved
end

local function BuildDeduplicationKey(entryDistance, laneIds)
	local laneParts = {}

	for _, laneId in ipairs(laneIds or {}) do
		table.insert(laneParts, tostring(laneId))
	end

	return string.format("%.4f:%s", entryDistance or 0, table.concat(laneParts, ","))
end

local function AppendEntry(entries, seenEntries, rawEntry, definition, entryIndex, laneCount)
	if not rawEntry or rawEntry.enabled == false or not IsMainRoute(rawEntry.fromRouteId) then
		return
	end

	if definition.ExcludeShortcutExit and EqualsIgnoreCase(rawEntry.entryMode, "ShortcutExit") then
		return
	end

	if definition.IsWaterfall then
		local var_7_0 = WaterfallClimb.ResolveEntryTriggerDistance(rawEntry)

		if not var_7_0 then
			var_7_0 = math.max(0, rawEntry.fromDistance or 0)

			local entryDistance = var_7_0
			local laneIds = ResolveLaneIds(rawEntry.fromLaneIds, rawEntry.fromLaneId, laneCount, definition.IsWaterfall)
			local deduplicationKey = BuildDeduplicationKey(entryDistance, laneIds)

			if seenEntries[deduplicationKey] then
				return
			end

			seenEntries[deduplicationKey] = true

			local var_7_3 = {}

			var_7_3.EntryId = rawEntry[definition.IdField] or string.format("%s:%d", definition.EntryType, entryIndex)
			var_7_3.EntryType = definition.EntryType
			var_7_3.EntryDistance = entryDistance
			var_7_3.LaneIds = laneIds

			table.insert(entries, var_7_3)
		end
	end
end

local function AppendNormalShortcut(entries, seenEntries, shortcut, shortcutIndex, laneCount)
	if not shortcut or shortcut.enabled == false then
		return
	end

	local entryDistance = math.max(0, shortcut.entryMainDistance or 0)
	local laneIds = ResolveLaneIds(shortcut.entryMainLaneIds, shortcut.entryMainLaneId, laneCount, false)
	local deduplicationKey = BuildDeduplicationKey(entryDistance, laneIds)

	if seenEntries[deduplicationKey] then
		return
	end

	seenEntries[deduplicationKey] = true

	local var_8_1 = {
		EntryType = "NormalShortcut"
	}

	var_8_1.EntryId = shortcut.shortcutId or string.format("NormalShortcut:%d", shortcutIndex)
	var_8_1.EntryDistance = entryDistance
	var_8_1.LaneIds = laneIds

	table.insert(entries, var_8_1)
end

function RacingSpecialTrackRecommendationPresentation.GetConfig()
	return RecommendationConfig
end

function RacingSpecialTrackRecommendationPresentation.CollectEntries(trackConfig)
	local entries = {}
	local seenEntries = {}
	local laneCount = ResolveMainLaneCount(trackConfig)

	if trackConfig then
		if not trackConfig.routeNetwork then
			local routeNetwork = {}

			for _, definition in ipairs(RouteEntryDefinitions) do
				for entryIndex, rawEntry in ipairs(routeNetwork[definition.ListName] or {}) do
					AppendEntry(entries, seenEntries, rawEntry, definition, entryIndex, laneCount)
				end
			end

			for shortcutIndex, shortcut in ipairs((trackConfig or nil) and (trackConfig.normalShortcuts or {})) do
				AppendNormalShortcut(entries, seenEntries, shortcut, shortcutIndex, laneCount)
			end

			table.sort(entries, function(left, right)
				if math.abs(left.EntryDistance - right.EntryDistance) > Epsilon then
					return left.EntryDistance < right.EntryDistance
				end

				return tostring(left.EntryId) < tostring(right.EntryId)
			end)

			return entries
		end
	end
end

local function Dot2D(left, right)
	return (left.x or 0) * (right.x or 0) + (left.y or 0) * (right.y or 0)
end

local function PointToChordDistance(point, chordStart, chordEnd)
	local chordX = (chordEnd.x or 0) - (chordStart.x or 0)
	local chordY = (chordEnd.y or 0) - (chordStart.y or 0)
	local chordLength = math.sqrt(chordX * chordX + chordY * chordY)

	if chordLength <= Epsilon then
		local pointX = (point.x or 0) - (chordStart.x or 0)
		local pointY = (point.y or 0) - (chordStart.y or 0)

		return math.sqrt(pointX * pointX + pointY * pointY)
	end

	local relativeX = (point.x or 0) - (chordStart.x or 0)
	local relativeY = (point.y or 0) - (chordStart.y or 0)

	return math.abs(relativeX * chordY - relativeY * chordX) / chordLength
end

local function IsStraightWindow(trackPath, segmentStart, segmentEnd)
	local segmentLength = segmentEnd - segmentStart
	local sampleCount = math.max(1, math.ceil(segmentLength / math.max(Epsilon, RecommendationConfig.PathSampleStep)))

	trackPath:SampleTo(segmentStart, 0, StraightStartPose)
	trackPath:SampleTo(segmentEnd, 0, StraightEndPose)

	local startPose = StraightStartPose
	local endPose = StraightEndPose
	local startTangent = startPose.tangent
	local minimumHeadingDot = math.cos(math.rad(RecommendationConfig.MaxHeadingDeltaDeg))

	for sampleIndex = 0, sampleCount do
		local sampleDistance = segmentStart + segmentLength * sampleIndex / sampleCount

		trackPath:SampleTo(sampleDistance, 0, StraightSamplePose)

		local pose = StraightSamplePose
		local headingDot = math.max(-1, math.min(1, Dot2D(startTangent, pose.tangent)))

		if headingDot < minimumHeadingDot - Epsilon then
			return false
		end

		if PointToChordDistance(pose.center, startPose.center, endPose.center) > RecommendationConfig.MaxChordDeviation + Epsilon then
			return false
		end
	end

	return true
end

local function ExceedsSelectedWindowOverlap(segmentStart, segmentEnd, selectedWindows)
	local allowedOverlap = RecommendationConfig.SegmentOverlap

	for _, selected in ipairs(selectedWindows) do
		local overlap = math.min(segmentEnd, selected.SegmentEndDistance) - math.max(segmentStart, selected.SegmentStartDistance)

		if overlap > allowedOverlap + Epsilon then
			return true
		end
	end

	return false
end

local function TryBuildWindow(segmentEnd, segmentLength, segmentKind, lookbackStart, trackPath, selectedWindows)
	local segmentStart = segmentEnd - segmentLength

	if segmentStart < lookbackStart - Epsilon then
		return nil
	end

	local insidePath = trackPath:getIsLoop() or segmentStart >= trackPath:getStartDistance() - Epsilon and segmentEnd <= trackPath:getEndDistance() + Epsilon

	if not insidePath or ExceedsSelectedWindowOverlap(segmentStart, segmentEnd, selectedWindows) or not IsStraightWindow(trackPath, segmentStart, segmentEnd) then
		return nil
	end

	return {
		SegmentStartDistance = segmentStart,
		SegmentEndDistance = segmentEnd,
		CenterDistance = (segmentStart + segmentEnd) * 0.5,
		SegmentLength = segmentLength,
		SegmentKind = segmentKind
	}
end

local function SelectWindows(entryDistance, trackPath)
	local selectedWindows = {}
	local lookbackStart = entryDistance - RecommendationConfig.LookbackDistance
	local segmentEnd = entryDistance - RecommendationConfig.EntryClearance

	while #selectedWindows < RecommendationConfig.MaxSegmentCount do
		if segmentEnd - RecommendationConfig.ShortSegmentLength < lookbackStart - Epsilon then
			break
		end

		local window = TryBuildWindow(segmentEnd, RecommendationConfig.SegmentLength, "Long", lookbackStart, trackPath, selectedWindows) or TryBuildWindow(segmentEnd, RecommendationConfig.ShortSegmentLength, "Short", lookbackStart, trackPath, selectedWindows)

		if window then
			table.insert(selectedWindows, window)

			segmentEnd = window.SegmentStartDistance + RecommendationConfig.SegmentOverlap
		else
			segmentEnd = segmentEnd - RecommendationConfig.SearchStep
		end
	end

	return selectedWindows
end

local function ValidateRecommendationConfig()
	local positiveFields = {
		"SegmentLength",
		"ShortSegmentLength",
		"SearchStep",
		"PathSampleStep",
		"MaxSegmentCount"
	}

	for _, fieldName in ipairs(positiveFields) do
		local value = RecommendationConfig[fieldName]

		if type(value) ~= "number" or value <= 0 then
			return false, fieldName
		end
	end

	local lookbackDistance = RecommendationConfig.LookbackDistance

	if type(lookbackDistance) ~= "number" or lookbackDistance < RecommendationConfig.SegmentLength then
		return false, "LookbackDistance"
	end

	local nonNegativeFields = {
		"SegmentOverlap",
		"EntryClearance",
		"MaxHeadingDeltaDeg",
		"MaxChordDeviation",
		"ShortPrefabForwardOffset"
	}

	for _, fieldName in ipairs(nonNegativeFields) do
		local value = RecommendationConfig[fieldName]

		if type(value) ~= "number" or value < 0 then
			return false, fieldName
		end
	end

	if RecommendationConfig.SegmentOverlap >= RecommendationConfig.SegmentLength then
		return false, "SegmentOverlap"
	end

	if RecommendationConfig.ShortSegmentLength >= RecommendationConfig.SegmentLength then
		return false, "ShortSegmentLength"
	end

	return true, nil
end

local function BuildPlacement(entry, laneId, laneCount, window, trackPath)
	local lateralOffset = trackPath:LaneToLateralOffset(laneId - 1, laneCount)
	local wrappedStartDistance = trackPath:WrapDistance(window.SegmentStartDistance)
	local wrappedEndDistance = trackPath:WrapDistance(window.SegmentEndDistance)
	local wrappedCenterDistance = trackPath:WrapDistance(window.CenterDistance)

	trackPath:SampleTo(wrappedCenterDistance, lateralOffset, PlacementPose)

	local pose = PlacementPose

	return {
		EntryId = entry.EntryId,
		EntryType = entry.EntryType,
		EntryDistance = entry.EntryDistance,
		LaneId = laneId,
		SegmentLength = window.SegmentLength,
		SegmentKind = window.SegmentKind,
		SegmentStartDistance = window.SegmentStartDistance,
		SegmentEndDistance = window.SegmentEndDistance,
		CenterDistance = window.CenterDistance,
		WrappedStartDistance = wrappedStartDistance,
		WrappedEndDistance = wrappedEndDistance,
		WrappedCenterDistance = wrappedCenterDistance,
		LateralOffset = lateralOffset,
		WorldPosition = {
			y = 0,
			x = pose.position.x,
			z = pose.position.y
		},
		WorldForward = {
			y = 0,
			x = pose.tangent.x,
			z = pose.tangent.y
		}
	}
end

function RacingSpecialTrackRecommendationPresentation.BuildPlacements(trackConfig, trackPath)
	local placements = {}
	local diagnostics = {}
	local configIsValid, invalidField = ValidateRecommendationConfig()

	if not configIsValid then
		table.insert(diagnostics, {
			Reason = "InvalidRecommendationConfig",
			Field = invalidField
		})

		return placements, diagnostics
	end

	local entries = RacingSpecialTrackRecommendationPresentation.CollectEntries(trackConfig)
	local laneCount = ResolveMainLaneCount(trackConfig)

	if not trackPath or not trackPath:getIsValid() then
		for _, entry in ipairs(entries) do
			table.insert(diagnostics, {
				Reason = "InvalidTrackPath",
				EntryId = entry.EntryId,
				EntryType = entry.EntryType
			})
		end

		return placements, diagnostics
	end

	for _, entry in ipairs(entries) do
		local selectedWindows = SelectWindows(entry.EntryDistance, trackPath)

		if #selectedWindows == 0 then
			table.insert(diagnostics, {
				Reason = "NoStraightWindow",
				EntryId = entry.EntryId,
				EntryType = entry.EntryType,
				EntryDistance = entry.EntryDistance
			})
		else
			for _, window in ipairs(selectedWindows) do
				for _, laneId in ipairs(entry.LaneIds) do
					table.insert(placements, BuildPlacement(entry, laneId, laneCount, window, trackPath))
				end
			end
		end
	end

	return placements, diagnostics
end

function RacingSpecialTrackRecommendationPresentation.New()
	return setmetatable({
		_spawnedCount = 0,
		_placements = {},
		_diagnostics = {}
	}, {
		__index = RacingSpecialTrackRecommendationPresentation
	})
end

function RacingSpecialTrackRecommendationPresentation:init(scene, parentGo, trackConfig, trackPath)
	self:dispose()

	self._placements, self._diagnostics = RacingSpecialTrackRecommendationPresentation.BuildPlacements(trackConfig, trackPath)

	if gohelper.isNil(parentGo) or not scene or not scene.preloader or #self._placements == 0 then
		return
	end

	local longPrefab = scene.preloader:getResource(V3a9RacingCarScenePreloader.SpecialTrackRecommendation)
	local shortPrefab = scene.preloader:getResource(V3a9RacingCarScenePreloader.SpecialTrackRecommendationShort)

	if gohelper.isNil(longPrefab) and gohelper.isNil(shortPrefab) then
		return
	end

	local rootGo = gohelper.create3d(parentGo, "SpecialTrackRecommendations")

	if gohelper.isNil(rootGo) then
		return
	end

	self._rootGo = rootGo

	for index, placement in ipairs(self._placements) do
		local prefab = placement.SegmentKind == "Short" and shortPrefab or longPrefab
		local holderGo = not gohelper.isNil(prefab) and gohelper.create3d(rootGo, string.format("Recommendation_%02d", index))

		if not gohelper.isNil(holderGo) and not gohelper.isNil(prefab) then
			local position = placement.WorldPosition
			local forward = placement.WorldForward

			if placement.SegmentKind == "Short" then
				if not RecommendationConfig.ShortPrefabForwardOffset then
					local prefabForwardOffset = 0

					holderGo.transform.position = Vector3(position.x + forward.x * prefabForwardOffset, position.y + forward.y * prefabForwardOffset, position.z + forward.z * prefabForwardOffset)
					holderGo.transform.rotation = UnityEngine.Quaternion.LookRotation(Vector3(forward.x, forward.y, forward.z), Vector3.up)

					if not gohelper.isNil(gohelper.clone(prefab, holderGo)) then
						self._spawnedCount = self._spawnedCount + 1
					end
				end
			end
		end
	end
end

function RacingSpecialTrackRecommendationPresentation:dispose()
	if not gohelper.isNil(self._rootGo) then
		gohelper.destroy(self._rootGo)
	end

	self._rootGo = nil
	self._placements = {}
	self._diagnostics = {}
	self._spawnedCount = 0
end

return RacingSpecialTrackRecommendationPresentation
