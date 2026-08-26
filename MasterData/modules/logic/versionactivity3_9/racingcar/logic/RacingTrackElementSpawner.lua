-- chunkname: @modules/logic/versionactivity3_9/racingcar/logic/RacingTrackElementSpawner.lua

module("modules.logic.versionactivity3_9.racingcar.logic.RacingTrackElementSpawner", package.seeall)

local RacingTrackElementSpawner = class("RacingTrackElementSpawner")

RacingTrackElementSpawner.TrackElementType = {
	ShortcutJumpPad = 9,
	CoinString = 2,
	BoostPad = 1,
	WaterJet = 7,
	TidalHammer = 6,
	Unknown = 0,
	Obstacle = 4,
	ItemPickup = 3,
	MovingBuoyWall = 8,
	DangerZone = 5
}
RacingTrackElementSpawner.TrackElementRes = {
	[RacingTrackElementSpawner.TrackElementType.BoostPad] = V3a9RacingCarScenePreloader.BoostPad,
	[RacingTrackElementSpawner.TrackElementType.CoinString] = V3a9RacingCarScenePreloader.Coin,
	[RacingTrackElementSpawner.TrackElementType.Obstacle] = V3a9RacingCarScenePreloader.Obstacle,
	[RacingTrackElementSpawner.TrackElementType.ItemPickup] = V3a9RacingCarScenePreloader.ItemPickup,
	[RacingTrackElementSpawner.TrackElementType.ShortcutJumpPad] = V3a9RacingCarScenePreloader.ShortcutJumpPad,
	[RacingTrackElementSpawner.TrackElementType.WaterJet] = V3a9RacingCarScenePreloader.WaterJet
}
RacingTrackElementSpawner.TrackElementResByConfigId = {
	[13905] = V3a9RacingCarScenePreloader.StartLine,
	[13906] = V3a9RacingCarScenePreloader.FinishLine
}

local TrackElementType = RacingTrackElementSpawner.TrackElementType
local DefaultHalfLength = 1.5
local LaneHalfWidthFactor = 0.45
local RouteIdMain = "Main"
local GlideEntryModeShortcutExit = "ShortcutExit"
local DefaultLaneCount = 4
local WaterfallVisualElementId = "13907"
local GlideAirGuardLaneCount = 3
local GlideAirGuardSegmentLength = 95
local GlideAirGuardStableSlopeThreshold = 0.05
local GlideAirGuardStableWindowTolerance = 5
local LRRU = LayeredRouteRuntimeUtility
local AerialShortcut = require("modules.logic.versionactivity3_9.racingcar.logic.specialtrack.AerialShortcut")
local SnowSlope = require("modules.logic.versionactivity3_9.racingcar.logic.specialtrack.SnowSlope")
local Glide = require("modules.logic.versionactivity3_9.racingcar.logic.specialtrack.Glide")
local WaterfallClimb = require("modules.logic.versionactivity3_9.racingcar.logic.specialtrack.WaterfallClimb")
local RacingSpecialTrackRecommendationPresentation = require("modules.logic.versionactivity3_9.racingcar.logic.feedback.RacingSpecialTrackRecommendationPresentation")

local function EqualsIgnoreCase(a, b)
	if a == nil or b == nil then
		return false
	end

	return string.lower(tostring(a)) == string.lower(tostring(b))
end

function RacingTrackElementSpawner:ctor()
	self._trackPath = nil
	self._parentGo = nil
	self._rootGo = nil
	self._specialTrackRecommendationPresentation = nil
	self._generatedElements = {}
	self._scene = GameSceneMgr.instance:getCurScene()
	self._trackConfig = nil
	self._elementTypes = nil
	self._trackData = nil
	self._mainLaneCount = DefaultLaneCount
	self._mainRoadWidth = 16
	self._routePathCache = nil
end

function RacingTrackElementSpawner:generate(trackConfig, trackPath, parentGo)
	self:_disposeGeneratedRoots()

	self._trackPath = trackPath
	self._parentGo = parentGo
	self._generatedElements = {}

	if not trackConfig then
		logError("RacingTrackElementSpawner:generate - trackConfig is nil")

		return self._generatedElements
	end

	if not trackPath then
		logError("RacingTrackElementSpawner:generate - trackPath is nil")

		return self._generatedElements
	end

	if trackConfig.editorAuthoring then
		local payload = trackConfig.editorAuthoring.payload
		local trackData = payload and payload.trackData

		if not trackData then
			logError("RacingTrackElementSpawner:generate - trackData is nil")

			return self._generatedElements
		end

		if not gohelper.isNil(parentGo) then
			self._rootGo = gohelper.create3d(parentGo, "TrackElements")
		end

		self._specialTrackRecommendationPresentation = RacingSpecialTrackRecommendationPresentation.New()

		self._specialTrackRecommendationPresentation:init(self._scene, parentGo, trackConfig, trackPath)

		local elementTypes = self:_buildElementTypeMap(payload.elementDefinitions)

		if not trackData.settings then
			local laneCount = math.max(1, (not trackData.settings.laneCount or nil) and DefaultLaneCount)
			local roadWidth = math.max(0.01, trackPath:getRoadWidth())
			local laneWidth = roadWidth / laneCount

			self._trackConfig = trackConfig
			self._elementTypes = elementTypes
			self._trackData = trackData
			self._mainLaneCount = laneCount
			self._mainRoadWidth = roadWidth
			self._routePathCache = {}

			self:_addConfiguredElements(trackData.placedElements, elementTypes, laneCount, laneWidth, roadWidth)

			if not trackConfig.routeNetwork then
				local routeNetwork = {}

				if not trackData.routeNetwork then
					local authoredRouteNetwork = {}

					self:_addLayeredRouteElements(routeNetwork.routes, authoredRouteNetwork.routes, elementTypes)
					self:_addNormalShortcutElements(trackConfig.normalShortcuts, trackData.normalShortcuts, 0, elementTypes)
					self:_addGlideElements(routeNetwork.glides, authoredRouteNetwork.glides, elementTypes)
					self:_spawnGlideAirGuardVisuals(routeNetwork.glides)
					self:_addSnowSlopeElements(routeNetwork.snowSlopeRoutes, authoredRouteNetwork.snowSlopeRoutes, elementTypes)
					self:_addMissingWaterfallClimbVisuals(routeNetwork.waterfallClimbRoutes)
					self:_spawnAerialShortcutJumpPadVisuals(routeNetwork)
					self:_addWaterfallClimbElements(routeNetwork.waterfallClimbRoutes, authoredRouteNetwork.waterfallClimbRoutes, elementTypes)
					self:_addCoinStrings(trackData.coinStrings, elementTypes, trackData.settings, laneCount, laneWidth, roadWidth)
					self:_spawnConfiguredRouteEntryTriggers()
					table.sort(self._generatedElements, function(left, right)
						return left.Distance < right.Distance
					end)

					return self._generatedElements
				end
			end
		end
	end
end

function RacingTrackElementSpawner:_buildElementTypeMap(elementDefinitions)
	local map = {}

	if not elementDefinitions then
		return map
	end

	for _, definition in ipairs(elementDefinitions) do
		if definition and definition.elementId and definition.elementId ~= "" then
			map[definition.elementId] = definition
		end
	end

	return map
end

function RacingTrackElementSpawner:_addConfiguredElements(placedElements, elementTypes, laneCount, laneWidth, roadWidth)
	if not placedElements then
		return
	end

	for _, placed in ipairs(placedElements) do
		if placed and placed.enabled then
			local elementInfo = elementTypes[placed.elementId or ""]

			if elementInfo then
				if not placed.laneId then
					local laneId = 1

					if EqualsIgnoreCase(placed.elementId, WaterfallVisualElementId) then
						laneId = self:_resolveAuthoredWaterfallVisualLaneId(placed, laneCount)
					end

					self:_addElement(elementInfo.runtimeElementType, placed.distance or 0, placed.laneId, laneCount, laneWidth, roadWidth, placed.lengthOverride or 0, placed.instanceId or "", elementInfo)
				end
			end
		end
	end
end

function RacingTrackElementSpawner:_addLayeredRouteElements(routes, authoredRoutes, elementTypes)
	for _, route in ipairs(routes or {}) do
		if route and route.enabled ~= false then
			local authoredRoute = self:_findRouteById(authoredRoutes, "routeId", route.routeId)
			local path, laneCount, routeHeight = self:_tryResolveRoutePath(route.routeId)

			if authoredRoute and path then
				self:_addTrackPathRouteContent(path, route.routeId, laneCount, routeHeight, authoredRoute, elementTypes)
			end

			self:_addNormalShortcutElements(route.normalShortcuts, authoredRoute and authoredRoute.normalShortcuts, route.height or 0, elementTypes)
		end
	end
end

function RacingTrackElementSpawner:_findRouteById(routes, idField, routeId)
	for _, candidate in ipairs(routes or {}) do
		if candidate and EqualsIgnoreCase(candidate[idField], routeId) then
			return candidate
		end
	end

	return nil
end

function RacingTrackElementSpawner:_addTrackPathRouteContent(path, routeId, laneCount, routeHeight, authoredContent, elementTypes, worldPoseResolver, placedElementFilter)
	if not authoredContent or not path or not path:getIsValid() then
		return
	end

	local safeLaneCount = math.max(1, laneCount or 1)
	local laneWidth = math.max(0.01, path:getRoadWidth() / safeLaneCount)

	for _, placed in ipairs(authoredContent.placedElements or {}) do
		if placed and placed.enabled ~= false and (not placedElementFilter or placedElementFilter(placed)) then
			local elementInfo = elementTypes[placed.elementId or ""]

			if elementInfo then
				if not placed.distance then
					local distance = 0

					if not placed.laneId then
						local laneId = 1
						local worldPose = worldPoseResolver and worldPoseResolver(distance, laneId) or nil

						self:_buildAndAddRouteEntryElement(path, elementInfo.runtimeElementType, placed.elementId, routeId, distance, laneId, safeLaneCount, routeHeight, placed.lengthOverride or 0, placed.instanceId or "", false, worldPose)
					end
				end
			end
		end
	end

	for _, coinString in ipairs(authoredContent.coinStrings or {}) do
		if coinString and coinString.enabled then
			if not coinString.elementId then
				local elementId = ""
				local elementInfo = elementTypes[elementId]

				if elementInfo then
					local points = self:_buildCoinStringPoints(coinString, {
						laneWidth = laneWidth
					})

					for _, point in ipairs(points) do
						local laneId = point.lane
						local worldPose = worldPoseResolver and worldPoseResolver(point.distance, laneId) or nil

						self:_buildAndAddRouteEntryElement(path, TrackElementType.CoinString, elementId, routeId, point.distance, laneId, safeLaneCount, routeHeight, 0, coinString.coinStringId or "", false, worldPose)
					end
				end
			end
		end
	end
end

function RacingTrackElementSpawner:_addNormalShortcutElements(shortcuts, authoredShortcuts, sourceRouteHeight, elementTypes)
	for _, shortcut in ipairs(shortcuts or {}) do
		if shortcut and shortcut.enabled ~= false then
			local authoredShortcut = self:_findRouteById(authoredShortcuts, "shortcutId", shortcut.shortcutId)
			local path, laneCount, routeHeight = self:_tryResolveRoutePath(shortcut.shortcutId)

			if authoredShortcut and path then
				local frames = AerialShortcut.Build3DRoadFrames(shortcut)
				local entryHeightBase = AerialShortcut.ResolveEntryHeightBase(frames, sourceRouteHeight or routeHeight or 0)
				local worldPoseResolver

				self:_addTrackPathRouteContent(path, shortcut.shortcutId, laneCount, routeHeight, authoredShortcut, elementTypes, (frames or nil) and function(distance, laneId)
					local laneIndex = LRRU and LRRU.CsLaneIdToLuaIndex(laneId, laneCount) or math.max(0, math.min(laneCount - 1, laneId - 1))
					local lateral = path:LaneToLateralOffset(laneIndex, laneCount)

					return AerialShortcut.Sample3DRoadPose(shortcut, frames, distance, lateral, 0, entryHeightBase, 0)
				end, function(placed)
					return shortcut.isAerialShortcut ~= true or not EqualsIgnoreCase(placed.elementId, "13909")
				end)
			end
		end
	end
end

function RacingTrackElementSpawner:_addGlideElements(glides, authoredGlides, elementTypes)
	for _, glide in ipairs(glides or {}) do
		if glide and glide.enabled ~= false and Glide.HasExportedPath(glide) then
			local authoredGlide

			for _, candidate in ipairs(authoredGlides or {}) do
				if candidate and EqualsIgnoreCase(candidate.glideId, glide.glideId) then
					authoredGlide = candidate

					break
				end
			end

			if authoredGlide then
				for _, placed in ipairs(authoredGlide.placedElements or {}) do
					if placed and placed.enabled ~= false then
						local elementInfo = elementTypes[placed.elementId or ""]

						if elementInfo then
							self:_addGlideElement(glide, placed, elementInfo)
						end
					end
				end

				for _, coinString in ipairs(authoredGlide.coinStrings or {}) do
					if coinString and coinString.enabled then
						local elementInfo = elementTypes[coinString.elementId or ""]

						if elementInfo then
							local var_13_3 = {}

							var_13_3.laneWidth = glide.laneWidth or 1

							local points = self:_buildCoinStringPoints(coinString, var_13_3)

							for _, point in ipairs(points) do
								self:_addGlideElement(glide, {
									distance = point.distance,
									laneId = point.lane,
									altitudeBand = coinString.altitudeBand,
									instanceId = coinString.coinStringId
								}, elementInfo, TrackElementType.CoinString)
							end
						end
					end
				end
			end
		end
	end
end

function RacingTrackElementSpawner:_isOrdinaryThreeLaneGlideForAirGuard(glide)
	if glide then
		::label_14_0::

		if glide.enabled ~= false then
			local var_14_1

			if math.max(1, glide.laneCount or 1) == GlideAirGuardLaneCount and not EqualsIgnoreCase(glide.entryMode, GlideEntryModeShortcutExit) and not self:_findAerialShortcut(glide.fromRouteId) then
				var_14_1 = Glide.HasExportedPath(glide)

				goto label_14_1
			end
		end

		var_14_1 = false
	else
		var_14_1 = true
	end

	::label_14_1::

	return var_14_1
end

function RacingTrackElementSpawner:_resolveGlideAirGuardStableWindow(glide, length)
	local pathPoints = glide and glide.pathPoints

	if type(pathPoints) ~= "table" or #pathPoints < 2 then
		return nil, nil
	end

	local bestStartDistance, bestEndDistance, currentStartDistance, currentEndDistance

	local function finishCurrentRun()
		if currentStartDistance and currentEndDistance and (not bestStartDistance or currentEndDistance - currentStartDistance > bestEndDistance - bestStartDistance) then
			bestStartDistance = currentStartDistance
			bestEndDistance = currentEndDistance
		end

		currentStartDistance = nil
		currentEndDistance = nil
	end

	for pointIndex = 1, #pathPoints - 1 do
		local fromPoint = pathPoints[pointIndex]
		local toPoint = pathPoints[pointIndex + 1]
		local fromDistance = tonumber(fromPoint and fromPoint.distance) or 0
		local toDistance = tonumber(toPoint and toPoint.distance) or fromDistance
		local distanceDelta = toDistance - fromDistance
		local fromHeight = tonumber(fromPoint and fromPoint.height) or 0
		local toHeight = tonumber(toPoint and toPoint.height) or fromHeight
		local isStable = distanceDelta > 0.001 and math.abs(toHeight - fromHeight) / distanceDelta <= GlideAirGuardStableSlopeThreshold

		if isStable then
			currentStartDistance = currentStartDistance or fromDistance
			currentEndDistance = toDistance
		else
			finishCurrentRun()
		end
	end

	finishCurrentRun()

	if not bestStartDistance or not bestEndDistance then
		return nil, nil
	end

	return math.max(0, bestStartDistance), math.min(length, bestEndDistance)
end

function RacingTrackElementSpawner:_buildGlideAirGuardPlacements(glides)
	local placements = {}

	for _, glide in ipairs(glides or {}) do
		if self:_isOrdinaryThreeLaneGlideForAirGuard(glide) then
			local length = Glide.ResolveLength(glide)
			local landingLockDistance = Glide.ResolveLandingLockDistance(glide.landingLockDistance)
			local visualLength = math.max(0, length - landingLockDistance)
			local stableStartDistance, stableEndDistance = self:_resolveGlideAirGuardStableWindow(glide, length)

			if length >= GlideAirGuardSegmentLength then
				local segmentCount = math.max(1, math.ceil(length / GlideAirGuardSegmentLength))
				local segmentLength = length / segmentCount
				local halfSegmentLength = GlideAirGuardSegmentLength * 0.5
				local laneCount = math.max(1, (not glide.laneCount or nil) and 1)
				local laneWidth = math.max(0.01, (not glide.laneWidth or nil) and 1)

				for segmentIndex = 1, segmentCount do
					local startDistance = (segmentIndex - 1) * segmentLength
					local endDistance = segmentIndex * segmentLength
					local centerDistance = (startDistance + endDistance) * 0.5
					local visualStartDistance = centerDistance - halfSegmentLength
					local visualEndDistance = centerDistance + halfSegmentLength

					if visualLength < visualEndDistance then
						break
					end

					local isWithinStableWindow = stableStartDistance and stableEndDistance and visualStartDistance >= stableStartDistance - GlideAirGuardStableWindowTolerance and visualEndDistance <= stableEndDistance + GlideAirGuardStableWindowTolerance

					if isWithinStableWindow then
						local startPoint = Glide.EvaluatePoint(glide, startDistance / length)
						local endPoint = Glide.EvaluatePoint(glide, endDistance / length)
						local anchor = Glide.EvaluatePoint(glide, centerDistance / length)

						if startPoint and endPoint and anchor then
							local forward = Vector3(endPoint.x - startPoint.x, 0, endPoint.z - startPoint.z)

							if forward.sqrMagnitude <= 0.0001 then
								local tangent = Glide.EvaluateTangent(glide, centerDistance / length)

								if tangent then
									forward = Vector3(tangent.x, 0, tangent.z)
								end
							end

							forward = forward.sqrMagnitude > 0.0001 and forward.normalized or Vector3.forward

							local up = Vector3.up
							local right = Vector3.Cross(up, forward)

							right = right.sqrMagnitude > 0.0001 and right.normalized or Vector3(1, 0, 0)

							for laneIndex = 0, laneCount - 1 do
								local lateralOffset = (laneIndex - (laneCount - 1) * 0.5) * laneWidth

								table.insert(placements, {
									RouteId = glide.glideId,
									SegmentIndex = segmentIndex,
									LaneIndex = laneIndex,
									Distance = centerDistance,
									SegmentLength = GlideAirGuardSegmentLength,
									LateralOffset = lateralOffset,
									WorldPosition = anchor + right * lateralOffset,
									WorldForward = forward,
									WorldUp = up
								})
							end
						end
					end
				end
			end
		end
	end

	return placements
end

function RacingTrackElementSpawner:_spawnGlideAirGuardVisuals(glides)
	if gohelper.isNil(self._rootGo) or not self._scene or not self._scene.preloader then
		return
	end

	local placements = self:_buildGlideAirGuardPlacements(glides)

	if #placements <= 0 then
		return
	end

	local prefab = self._scene.preloader:getResource(V3a9RacingCarScenePreloader.GlideAirGuard)

	if not prefab then
		return
	end

	local visualRoot = gohelper.create3d(self._rootGo, "GlideAirGuards")

	if gohelper.isNil(visualRoot) then
		return
	end

	for _, placement in ipairs(placements) do
		local name = string.format("GlideAirGuard_%s_%03d_Lane%d", tostring(placement.RouteId), placement.SegmentIndex, placement.LaneIndex + 1)
		local holder = gohelper.create3d(visualRoot, name)

		if not gohelper.isNil(holder) then
			holder.transform.position = placement.WorldPosition
			holder.transform.rotation = UnityEngine.Quaternion.LookRotation(placement.WorldUp, placement.WorldForward)

			gohelper.clone(prefab, holder)
		end
	end
end

local function ResolveGlideAltitudeBand(altitudeBand)
	local normalized = string.lower(tostring(altitudeBand or "Mid"))

	if normalized == "low" then
		return 0
	elseif normalized == "high" then
		return 2
	end

	return 1
end

local function ResolveGlideAltitudeOffset(glide, altitudeBandIndex)
	if altitudeBandIndex <= 0 then
		return glide.lowAltitudeOffset or 0
	elseif altitudeBandIndex >= 2 then
		return glide.highAltitudeOffset or 0
	end

	return glide.midAltitudeOffset or 0
end

function RacingTrackElementSpawner:_addGlideElement(glide, placed, elementInfo, elementTypeOverride)
	local elementType = elementTypeOverride or elementInfo.runtimeElementType
	local laneCount = math.max(1, (not glide.laneCount or nil) and 1)
	local laneIndex, coveredLaneIndex = self:_resolveLaneIndices(placed.laneId, laneCount)
	local laneWidth = math.max(0.01, (not glide.laneWidth or nil) and 1)
	local lateral = (laneIndex - (laneCount - 1) * 0.5) * laneWidth
	local altitudeBandIndex = ResolveGlideAltitudeBand(placed.altitudeBand)
	local altitudeOffset = ResolveGlideAltitudeOffset(glide, altitudeBandIndex)
	local length = Glide.ResolveLength(glide)
	local distance = math.max(0, math.min(length, placed.distance or 0))
	local progress = Mathf.Clamp01(distance / math.max(0.01, length))
	local anchor = Glide.EvaluatePoint(glide, progress)
	local tangent = Glide.EvaluateTangent(glide, progress)

	if not anchor or not tangent then
		return nil
	end

	tangent = tangent.sqrMagnitude > 0.0001 and tangent.normalized or Vector3.forward

	local up = Vector3.up
	local right = Vector3.Cross(up, tangent)

	right = right.sqrMagnitude > 0.0001 and right.normalized or Vector3(1, 0, 0)

	local worldPosition = anchor + right * lateral + up * altitudeOffset
	local halfWidth = laneWidth * LaneHalfWidthFactor

	if (placed.lengthOverride or 0) > 0 then
		if not ((placed.lengthOverride or 0) * 0.5) then
			local halfLength = DefaultHalfLength
			local var_21_6 = {
				available = true,
				respawnSec = 0,
				respawnRemainingSec = 0,
				ElementInfo = elementInfo,
				ElementType = elementType,
				Distance = distance,
				StartDistance = distance - halfLength,
				EndDistance = distance + halfLength,
				LateralMin = lateral - halfWidth,
				LateralMax = lateral + halfWidth,
				LateralCenter = lateral,
				Pose = {
					position = {
						x = anchor.x,
						y = anchor.z
					},
					tangent = {
						x = tangent.x,
						y = tangent.z
					}
				},
				WorldPosition = worldPosition,
				WorldForward = tangent,
				WorldUp = up,
				CoveredLaneStart = coveredLaneIndex,
				CoveredLaneEnd = coveredLaneIndex,
				BlocksEntireRoad = laneCount == 1,
				SourceElementType = elementType
			}

			if placed.instanceId and placed.instanceId ~= "" then
				var_21_6.SourceId = placed.instanceId or string.format("%s:%s", tostring(glide.glideId), tostring(placed.elementId))
			end

			var_21_6.RouteId = glide.glideId
			var_21_6.normalizedRouteId = string.lower(tostring(glide.glideId or ""))
			var_21_6.LaneCount = laneCount
			var_21_6.AltitudeBand = placed.altitudeBand or "Mid"
			var_21_6.AltitudeBandIndex = altitudeBandIndex
			var_21_6.AltitudeOffset = altitudeOffset

			local element = var_21_6
			local elementConfig = V3a9RacingCarConfig.instance:getRacingElementConfig(tonumber(elementInfo.configId))

			if elementConfig then
				element.respawnSec = elementConfig.refreshTime
			end

			element.go = self:_createElementGameObject(element)

			table.insert(self._generatedElements, element)

			return element
		end
	end
end

function RacingTrackElementSpawner:_addSnowSlopeElements(slopes, authoredSlopes, elementTypes)
	for _, slope in ipairs(slopes or {}) do
		if slope and slope.enabled ~= false then
			local authoredSlope = self:_findRouteById(authoredSlopes, "slopeId", slope.slopeId)
			local pathConfig = SnowSlope.ResolveTrackPathConfig(slope)
			local path = pathConfig and TrackPath.FromConfig(pathConfig) or nil

			if authoredSlope and path and path:getIsValid() then
				local laneCount = math.max(1, (not slope.laneCount or nil) and 1)
				local frames = SnowSlope.Build3DRoadFrames(slope)
				local _, _, sourceRouteHeight = self:_tryResolveRoutePath(slope.fromRouteId)
				local heightBaseOffset = 0

				if not frames and (sourceRouteHeight or 0) > 0.01 then
					heightBaseOffset = sourceRouteHeight - SnowSlope.ResolveEntryHeight(slope, path)
				end

				local function resolveWorldPose(distance, laneId)
					local laneIndex = LRRU and LRRU.CsLaneIdToLuaIndex(laneId, laneCount) or math.max(0, math.min(laneCount - 1, laneId - 1))
					local lateral = path:LaneToLateralOffset(laneIndex, laneCount)
					local roadPose = SnowSlope.Sample3DRoadPose(slope, frames, distance, lateral, 0, 0)

					if roadPose then
						return roadPose
					end

					local flatPose = path:Sample(distance, lateral)
					local beforePose = {
						center = {},
						tangent = {},
						normal = {},
						position = {}
					}
					local afterPose = {
						center = {},
						tangent = {},
						normal = {},
						position = {}
					}
					local flatForward = Vector3(flatPose.tangent.x or 0, 0, flatPose.tangent.y or 0)

					return {
						position = Vector3(flatPose.position.x, heightBaseOffset + SnowSlope.SampleHeight(slope, path, distance, nil), flatPose.position.y),
						forward = SnowSlope.ResolveForward(slope, path, distance, lateral, flatForward, 1, beforePose, afterPose, nil),
						up = Vector3.up
					}
				end

				self:_addTrackPathRouteContent(path, slope.slopeId, laneCount, 0, authoredSlope, elementTypes, resolveWorldPose)
			end
		end
	end
end

function RacingTrackElementSpawner:_addWaterfallClimbElements(climbs, authoredClimbs, elementTypes)
	for _, climb in ipairs(climbs or {}) do
		if climb and climb.enabled ~= false then
			local authoredClimb = self:_findRouteById(authoredClimbs, "climbId", climb.climbId)
			local content = authoredClimb or climb

			for _, placed in ipairs((not content.placedElements or nil) and {}) do
				if placed and placed.enabled ~= false then
					local elementInfo = elementTypes[placed.elementId or ""]

					if elementInfo then
						self:_addWaterfallClimbElement(climb, placed, elementInfo)
					end
				end
			end

			for _, coinString in ipairs(content.coinStrings or {}) do
				if coinString and coinString.enabled then
					local elementInfo = elementTypes[coinString.elementId or ""]

					if elementInfo then
						local var_24_3 = {}

						var_24_3.laneWidth = climb.laneWidth or 1

						local points = self:_buildCoinStringPoints(coinString, var_24_3)

						for _, point in ipairs(points) do
							self:_addWaterfallClimbElement(climb, {
								distance = point.distance,
								laneId = point.lane,
								instanceId = coinString.coinStringId
							}, elementInfo, TrackElementType.CoinString)
						end
					end
				end
			end
		end
	end
end

function RacingTrackElementSpawner:_addWaterfallClimbElement(climb, placed, elementInfo, elementTypeOverride)
	local elementType = elementTypeOverride or elementInfo.runtimeElementType
	local laneCount = math.max(1, (not climb.laneCount or nil) and 1)
	local laneIndex, coveredLaneIndex = self:_resolveLaneIndices(placed.laneId, laneCount)
	local laneWidth = math.max(0.01, (not climb.laneWidth or nil) and 8)
	local lateral = (laneIndex - (laneCount - 1) * 0.5) * laneWidth
	local halfWidth = laneWidth * LaneHalfWidthFactor

	if (placed.lengthOverride or 0) > 0 then
		if not ((placed.lengthOverride or 0) * 0.5) then
			local halfLength = DefaultHalfLength
			local distance = math.max(0, math.min(math.max(0.01, (not climb.climbLength or nil) and 0.01), placed.distance or 0))
			local worldPosition, worldForward, worldUp = WaterfallClimb.EvaluatePlacedElementPose(climb, distance, laneIndex)

			if not worldPosition then
				return nil
			end

			local var_25_7 = {
				available = true,
				respawnSec = 0,
				respawnRemainingSec = 0,
				ElementInfo = elementInfo,
				ElementType = elementType,
				Distance = distance,
				StartDistance = distance - halfLength,
				EndDistance = distance + halfLength,
				LateralMin = lateral - halfWidth,
				LateralMax = lateral + halfWidth,
				LateralCenter = lateral,
				CoveredLaneStart = coveredLaneIndex,
				CoveredLaneEnd = coveredLaneIndex,
				BlocksEntireRoad = laneCount == 1,
				SourceElementType = elementType
			}

			var_25_7.SourceId = placed.instanceId or ""
			var_25_7.RouteId = climb.climbId
			var_25_7.normalizedRouteId = string.lower(climb.climbId or "")
			var_25_7.WorldPosition = worldPosition
			var_25_7.WorldForward = worldForward
			var_25_7.WorldUp = worldUp
			var_25_7.RouteHeight = worldPosition.y

			local element = var_25_7
			local configId = elementInfo and elementInfo.configId
			local elementConfig = V3a9RacingCarConfig.instance:getRacingElementConfig(tonumber(configId))

			if elementConfig then
				element.respawnSec = elementConfig.refreshTime
			end

			element.go = self:_createElementGameObject(element)

			table.insert(self._generatedElements, element)

			return element
		end
	end
end

function RacingTrackElementSpawner:_addCoinStrings(coinStrings, elementTypes, settings, laneCount, laneWidth, roadWidth)
	if not coinStrings then
		return
	end

	for _, coinString in ipairs(coinStrings) do
		if coinString and coinString.enabled then
			local elementInfo = elementTypes[coinString.elementId or ""]
			local points = self:_buildCoinStringPoints(coinString, settings)

			for _, point in ipairs(points) do
				self:_addElement(TrackElementType.CoinString, point.distance, point.lane, laneCount, laneWidth, roadWidth, 0, coinString.coinStringId or "", elementInfo)
			end
		end
	end
end

function RacingTrackElementSpawner:_addElement(elementType, distance, oneBasedLane, laneCount, laneWidth, roadWidth, lengthOverride, sourceId, elementInfo)
	local laneIndex, coveredLaneIndex = self:_resolveLaneIndices(oneBasedLane, laneCount)
	local lateral = roadWidth * 0.5 - (laneIndex + 0.5) * laneWidth
	local halfWidth = laneWidth * LaneHalfWidthFactor

	if lengthOverride > 0 then
		if not (lengthOverride * 0.5) then
			local halfLength = DefaultHalfLength
			local pose = self._trackPath:Sample(distance, lateral)
			local element = {
				respawnSec = 0,
				respawnRemainingSec = 0,
				normalizedRouteId = "main",
				available = true,
				ElementInfo = elementInfo,
				ElementType = elementType,
				Distance = distance,
				StartDistance = distance - halfLength,
				EndDistance = distance + halfLength,
				LateralMin = lateral - halfWidth,
				LateralMax = lateral + halfWidth,
				LateralCenter = lateral,
				Pose = pose,
				CoveredLaneStart = coveredLaneIndex,
				CoveredLaneEnd = coveredLaneIndex,
				BlocksEntireRoad = laneCount == 1,
				SourceElementType = elementType,
				SourceId = sourceId,
				RouteId = RouteIdMain
			}
			local configId = elementInfo and elementInfo.configId
			local elementConfig = V3a9RacingCarConfig.instance:getRacingElementConfig(tonumber(configId))

			if elementConfig then
				element.respawnSec = elementConfig.refreshTime
			end

			element.go = self:_createElementGameObject(element)

			table.insert(self._generatedElements, element)

			return element
		end
	end
end

function RacingTrackElementSpawner:_createElementGameObject(element)
	if gohelper.isNil(self._rootGo) then
		return nil
	end

	local name = string.format("Element_%d_%s_%s", element.ElementType, tostring(element.SourceId), tostring(element.Distance))
	local go = gohelper.create3d(self._rootGo, name)

	if gohelper.isNil(go) then
		return nil
	end

	if element.Pose then
		if not element.Pose.position then
			local pos = {
				x = 0,
				y = 0
			}

			if not element.RouteHeight then
				local heightY = 0

				go.transform.position = element.WorldPosition or Vector3(pos.x, heightY, pos.y)

				if element.Pose then
					local tangent = element.Pose.tangent

					if not element.WorldForward then
						local forward

						if tangent then
							if not Vector3(tangent.x or 0, 0, tangent.y or 0) then
								forward = nil

								local configId = tonumber(element.ElementInfo and element.ElementInfo.configId)
								local configId

								if forward and forward.sqrMagnitude > 0.0001 then
									configId = element.WorldUp

									if not element.WorldUp then
										local up = Vector3(0, 1, 0)

										go.transform.rotation = UnityEngine.Quaternion.LookRotation(forward.normalized, up)
									end
								end

								if configId == 13910 then
									local var_28_7 = V3a9RacingCarScenePreloader.GlideBoostPad

									if not V3a9RacingCarScenePreloader.GlideBoostPad then
										var_28_7 = RacingTrackElementSpawner.TrackElementResByConfigId[configId]

										if not RacingTrackElementSpawner.TrackElementResByConfigId[configId] then
											local res = RacingTrackElementSpawner.TrackElementRes[element.ElementType]

											if res then
												local elementGo = self._scene.preloader:getResource(res)

												if elementGo then
													gohelper.clone(elementGo, go)
												end
											end

											return go
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

function RacingTrackElementSpawner:_buildCoinStringPoints(coinString, settings)
	local controls = self:_parsePointList(coinString.pointList)

	if #controls == 0 then
		return {}
	end

	local safeSpacing = math.max(0.01, coinString.spacing or 4)

	if settings then
		local laneWidth = math.max(0.01, settings.laneWidth or 1)
		local result = {}

		self:_addDistinctPoint(result, controls[1])

		for index = 1, #controls - 1 do
			local from = controls[index]
			local to = controls[index + 1]
			local distanceDelta = to.distance - from.distance
			local laneDelta = (to.lane - from.lane) * laneWidth
			local segmentLength = math.sqrt(distanceDelta * distanceDelta + laneDelta * laneDelta)

			if segmentLength <= 0.001 then
				self:_addDistinctPoint(result, to)
			else
				local stepCount = math.max(1, math.floor(segmentLength / safeSpacing))

				for step = 1, stepCount do
					local t = math.min(1, step * safeSpacing / segmentLength)

					self:_addDistinctPoint(result, self:_lerpPoint(from, to, t))
				end

				self:_addDistinctPoint(result, to)
			end
		end

		return result
	end
end

function RacingTrackElementSpawner:_parsePointList(pointList)
	local parsed = {}

	if not pointList or pointList == "" then
		return parsed
	end

	for token in string.gmatch(pointList, "([^|]+)") do
		token = self:_trim(token)

		local laneStr, distanceStr = string.match(token, "([^#]+)#([^#]+)")

		if laneStr and distanceStr then
			local lane = tonumber(laneStr)
			local distance = tonumber(distanceStr)

			if lane and distance and lane >= 1 then
				table.insert(parsed, {
					lane = lane,
					distance = distance
				})
			end
		end
	end

	if #parsed < 2 then
		return {}
	end

	return parsed
end

function RacingTrackElementSpawner:_lerpPoint(from, to, t)
	return {
		lane = from.lane + (to.lane - from.lane) * t,
		distance = from.distance + (to.distance - from.distance) * t
	}
end

function RacingTrackElementSpawner:_addDistinctPoint(points, point)
	local count = #points

	if count > 0 then
		local last = points[count]

		if math.abs(last.lane - point.lane) <= 0.001 and math.abs(last.distance - point.distance) <= 0.001 then
			return
		end
	end

	table.insert(points, {
		lane = point.lane,
		distance = point.distance
	})
end

function RacingTrackElementSpawner:_round(value)
	return math.floor(value + 0.5)
end

function RacingTrackElementSpawner:_resolveLaneIndices(oneBasedLane, laneCount)
	local safeLaneCount = math.max(1, laneCount or 1)
	local continuousLaneIndex = math.max(0, math.min(safeLaneCount - 1, (oneBasedLane or 1) - 1))
	local coveredLaneIndex = self:_round(continuousLaneIndex)

	return continuousLaneIndex, coveredLaneIndex
end

function RacingTrackElementSpawner:_trim(str)
	return (string.gsub(str, "^%s*(.-)%s*$", "%1"))
end

function RacingTrackElementSpawner:_addMissingWaterfallClimbVisuals(climbs)
	for _, climb in ipairs(climbs or {}) do
		if climb and climb.enabled ~= false then
			if not climb.fromRouteId then
				local routeId = RouteIdMain

				if not climb.fromDistance then
					local distance = 0

					if not self:_hasAuthoredElementAtDistance(routeId, WaterfallVisualElementId, distance) then
						local path, laneCount, routeHeight = self:_tryResolveRoutePath(routeId)

						if path and path:getIsValid() then
							local var_36_5 = self:_resolveWaterfallVisualLaneId(climb, laneCount)

							self:_buildAndAddRouteEntryElement(path, TrackElementType.WaterJet, WaterfallVisualElementId, routeId, distance, visualLaneId, laneCount, routeHeight, 0, string.format("%s:WaterfallVisual", tostring(climb.climbId or routeId)), false)
						end
					end
				end
			end
		end
	end
end

function RacingTrackElementSpawner:_findAerialShortcut(shortcutId)
	if not shortcutId or shortcutId == "" then
		return nil, nil
	end

	for _, shortcut in ipairs((self._trackConfig or nil) and (self._trackConfig.normalShortcuts or {})) do
		if shortcut and shortcut.isAerialShortcut == true and EqualsIgnoreCase(shortcut.shortcutId, shortcutId) then
			return shortcut, RouteIdMain
		end
	end

	for _, route in ipairs((self._trackConfig and self._trackConfig.routeNetwork or nil) and (self._trackConfig.routeNetwork.routes or {})) do
		for _, shortcut in ipairs((route or nil) and (route.normalShortcuts or {})) do
			if shortcut and shortcut.isAerialShortcut == true and EqualsIgnoreCase(shortcut.shortcutId, shortcutId) then
				return shortcut, route.routeId
			end
		end
	end

	return nil, nil
end

function RacingTrackElementSpawner:_isTransferToHighLayeredRoute(transfer)
	if not transfer or not transfer.toRouteId then
		return false
	end

	for _, route in ipairs((self._trackConfig and self._trackConfig.routeNetwork or nil) and (self._trackConfig.routeNetwork.routes or {})) do
		if route and route.enabled ~= false and EqualsIgnoreCase(route.routeId, transfer.toRouteId) then
			return (route.height or 0) > 0.01
		end
	end

	return false
end

function RacingTrackElementSpawner:_spawnAerialShortcutJumpPadVisuals(network)
	local function spawnShortcutVisuals(shortcut, sourceRouteHeight)
		if not shortcut or shortcut.enabled == false or shortcut.isAerialShortcut ~= true then
			return
		end

		local shortcutPath, shortcutLaneCount = self:_tryResolveRoutePath(shortcut.shortcutId)

		if not shortcutPath or not shortcutPath:getIsValid() then
			return
		end

		local exitDistance = AerialShortcut.ResolveExitTriggerDistance(shortcut, shortcutPath:getEndDistance())
		local frames = AerialShortcut.Build3DRoadFrames(shortcut)
		local entryHeightBase = AerialShortcut.ResolveEntryHeightBase(frames, sourceRouteHeight or 0)
		local var_40_0

		if not shortcutLaneCount then
			::label_40_0::

			var_40_0 = shortcut.laneCount or 1
		end

		for laneId = 1, math.max(1, var_40_0) do
			self:_createVisualOnlyAerialExitJumpPad(shortcut, shortcutPath, frames, entryHeightBase, exitDistance, laneId, shortcutLaneCount)
		end
	end

	for _, shortcut in ipairs((self._trackConfig or nil) and (self._trackConfig.normalShortcuts or {})) do
		spawnShortcutVisuals(shortcut, 0)
	end

	for _, route in ipairs((network or nil) and (network.routes or {})) do
		for _, shortcut in ipairs((route or nil) and (route.normalShortcuts or {})) do
			spawnShortcutVisuals(shortcut, route.height or 0)
		end
	end
end

function RacingTrackElementSpawner:_createVisualOnlyAerialExitJumpPad(shortcut, path, frames, entryHeightBase, distance, laneId, laneCount)
	local var_41_0

	if not laneCount then
		::label_41_0::

		var_41_0 = shortcut.laneCount or 1
	end

	local safeLaneCount = math.max(1, var_41_0)
	local laneIndex = LRRU.CsLaneIdToLuaIndex(laneId, safeLaneCount)
	local lateral = path:LaneToLateralOffset(laneIndex, safeLaneCount)
	local roadPose = AerialShortcut.Sample3DRoadPose(shortcut, frames, distance, lateral, 0, entryHeightBase, 0)

	if not roadPose then
		return nil
	end

	local var_41_1 = {}

	if self._elementTypes then
		var_41_1.ElementInfo = self._elementTypes["13909"] or {
			elementId = "13909"
		}
	end

	var_41_1.ElementType = TrackElementType.ShortcutJumpPad
	var_41_1.Distance = distance
	var_41_1.WorldPosition = roadPose.position
	var_41_1.WorldForward = roadPose.forward
	var_41_1.WorldUp = roadPose.up
	var_41_1.RouteId = shortcut.shortcutId
	var_41_1.RouteHeight = roadPose.position.y
	var_41_1.SourceId = string.format("%s:AerialExitVisual:L%d", tostring(shortcut.shortcutId), laneId)

	local element = var_41_1

	return self:_createElementGameObject(element)
end

function RacingTrackElementSpawner:_spawnConfiguredRouteEntryTriggers()
	if self._trackConfig then
		if not self._trackConfig then
			return
		end

		for _, transfer in ipairs(self._trackConfig.transfers or {}) do
			if transfer and transfer.enabled ~= false then
				if self:_isTransferToHighLayeredRoute(transfer) then
					if not TrackElementType.ShortcutJumpPad then
						local visualElementType

						self:_spawnRouteEntryTrigger(transfer.fromRouteId, transfer.triggerElementId, transfer.fromDistance, transfer.fromLaneIds, transfer.fromLaneId, visualElementType)
					end
				end
			end
		end

		for _, drop in ipairs(self._trackConfig.waterDrops or {}) do
			if drop and drop.enabled ~= false then
				self:_spawnRouteEntryTrigger(drop.fromRouteId, drop.triggerElementId, drop.fromDistance, drop.fromLaneIds, drop.fromLaneId)
			end
		end

		for _, glide in ipairs(self._trackConfig.glides or {}) do
			if glide and glide.enabled ~= false and not EqualsIgnoreCase(glide.entryMode, GlideEntryModeShortcutExit) and not self:_findAerialShortcut(glide.fromRouteId) then
				self:_spawnRouteEntryTrigger(glide.fromRouteId, glide.triggerElementId, glide.fromDistance, glide.fromLaneIds, glide.fromLaneId)
			end
		end

		for _, route in ipairs(self._trackConfig.underwaterRoutes or {}) do
			if route and route.enabled ~= false then
				self:_spawnRouteEntryTrigger(route.fromRouteId, route.triggerElementId, route.fromDistance, route.fromLaneIds, route.fromLaneId)

				if route.exitTriggerElementId and route.exitTriggerElementId ~= "" then
					local exitLaneCount = math.max(1, (not route.laneCount or nil) and 1)
					local exitLaneIds = {}

					for i = 1, exitLaneCount do
						exitLaneIds[i] = i
					end

					for _, exit in ipairs(route.exits or {}) do
						if exit then
							self:_spawnRouteEntryTrigger(route.underwaterId, route.exitTriggerElementId, exit.triggerDistance, exitLaneIds, 1)
						end
					end
				end
			end
		end

		for _, route in ipairs(self._trackConfig.snowSlopeRoutes or {}) do
			if route and route.enabled ~= false then
				self:_spawnRouteEntryTrigger(route.fromRouteId, route.triggerElementId, route.fromDistance, route.fromLaneIds, route.fromLaneId)
			end
		end

		for _, route in ipairs(self._trackConfig.waterfallClimbRoutes or {}) do
			if route and route.enabled ~= false then
				local triggerDistance = WaterfallClimb.ResolveEntryTriggerDistance(route)
				local _, sourceLaneCount = self:_tryResolveRoutePath(route.fromRouteId)

				route.fromLaneIds = self:_resolveWaterfallEntryLaneIds(route.fromLaneIds, route.fromLaneId, sourceLaneCount)
				route.fromLaneId = route.fromLaneIds[1]

				self:_spawnRouteEntryTrigger(route.fromRouteId, route.triggerElementId, triggerDistance, route.fromLaneIds, route.fromLaneId)
			end
		end
	end
end

function RacingTrackElementSpawner:_resolveWaterfallEntryLaneIds(laneIds, fallbackLaneId, laneCount)
	local safeLaneCount = math.max(1, laneCount or DefaultLaneCount)
	local resolvedLaneIds = {}
	local seenLaneIds = {}

	for _, rawLaneId in ipairs(laneIds or {}) do
		local laneId = math.max(1, math.min(safeLaneCount, rawLaneId or 1))

		if not seenLaneIds[laneId] then
			seenLaneIds[laneId] = true

			table.insert(resolvedLaneIds, laneId)
		end
	end

	if #resolvedLaneIds == 0 then
		local fallback = math.max(1, math.min(safeLaneCount, fallbackLaneId or 1))

		table.insert(resolvedLaneIds, fallback)
	end

	if #resolvedLaneIds == 1 and safeLaneCount > 1 then
		local anchorLaneId = resolvedLaneIds[1]

		if safeLaneCount <= anchorLaneId then
			if not (anchorLaneId - 1) then
				local adjacentLaneId = anchorLaneId + 1

				table.insert(resolvedLaneIds, adjacentLaneId)
			end
		end
	end

	table.sort(resolvedLaneIds)

	return resolvedLaneIds
end

function RacingTrackElementSpawner:_resolveWaterfallVisualLaneId(climb, laneCount)
	local safeLaneCount = math.max(1, laneCount or DefaultLaneCount)

	if climb and climb.waterfallVisualLaneId ~= nil then
		return math.max(1, math.min(safeLaneCount, climb.waterfallVisualLaneId))
	end

	local coveredLaneIds = self:_resolveWaterfallEntryLaneIds(climb and climb.fromLaneIds, climb and climb.fromLaneId, safeLaneCount)
	local laneIdTotal = 0

	for _, laneId in ipairs(coveredLaneIds) do
		laneIdTotal = laneIdTotal + laneId
	end

	return laneIdTotal / math.max(1, #coveredLaneIds)
end

function RacingTrackElementSpawner:_resolveAuthoredWaterfallVisualLaneId(placed, laneCount)
	if placed then
		if not placed.laneId then
			local authoredLaneId = 1

			if self._trackConfig then
				local network = self._trackConfig.routeNetwork

				for _, climb in ipairs((network or nil) and (network.waterfallClimbRoutes or {})) do
					if climb and climb.enabled ~= false then
						if EqualsIgnoreCase(climb.fromRouteId or RouteIdMain, RouteIdMain) then
							if math.abs((placed.distance or 0) - (climb.fromDistance or 0)) <= 0.5 then
								return self:_resolveWaterfallVisualLaneId(climb, laneCount)
							end
						end
					end
				end

				return authoredLaneId
			end
		end
	end
end

function RacingTrackElementSpawner:_spawnRouteEntryTrigger(fromRouteId, triggerElementId, distance, laneIds, fallbackLaneId, visualElementTypeOverride)
	if not triggerElementId or triggerElementId == "" then
		return
	end

	local path, laneCount, routeHeight = self:_tryResolveRoutePath(fromRouteId)

	if not path then
		return
	end

	local elementType = visualElementTypeOverride or self:_resolveElementType(triggerElementId)
	local lanes = laneIds and #laneIds > 0 and laneIds or {
		fallbackLaneId or 1
	}

	for _, rawLaneId in ipairs(lanes) do
		local laneId = math.max(1, math.min(laneCount, rawLaneId or 1))

		if not self:_hasAuthoredTrigger(fromRouteId, triggerElementId, distance, laneId) then
			self:_buildAndAddRouteEntryElement(path, elementType, triggerElementId, fromRouteId, distance, laneId, laneCount, routeHeight, nil, nil, true)
		end
	end
end

function RacingTrackElementSpawner:_tryResolveRoutePath(routeId)
	if not routeId or routeId == "" or EqualsIgnoreCase(routeId, RouteIdMain) then
		return self._trackPath, self._mainLaneCount, 0
	end

	if self._routePathCache then
		local cached = self._routePathCache[routeId]

		if cached then
			return cached.path, cached.laneCount, cached.routeHeight
		end
	end

	for _, shortcut in ipairs((self._trackConfig or nil) and (self._trackConfig.normalShortcuts or {})) do
		if shortcut and shortcut.enabled ~= false and EqualsIgnoreCase(shortcut.shortcutId, routeId) then
			local path = TrackPath.FromConfig(shortcut.path)

			if path and path:getIsValid() then
				local laneCount = math.max(1, (not shortcut.laneCount or nil) and 1)

				self:_cacheRoutePath(routeId, path, laneCount, 0)

				return path, laneCount, 0
			end

			break
		end
	end

	if self._trackConfig then
		local network = self._trackConfig.routeNetwork

		if not network then
			return nil, DefaultLaneCount, 0
		end

		for _, route in ipairs(network.routes or {}) do
			if route and route.enabled ~= false and EqualsIgnoreCase(route.routeId, routeId) then
				local path = TrackPath.FromConfig(route.path)

				if path and path:getIsValid() then
					local laneCount = math.max(1, (not route.laneCount or nil) and 1)
					local routeHeight = math.max(0, (not route.height or nil) and 0)

					self:_cacheRoutePath(routeId, path, laneCount, routeHeight)

					return path, laneCount, routeHeight
				end

				break
			end
		end

		for _, route in ipairs(network.routes or {}) do
			for _, shortcut in ipairs((route or nil) and (route.normalShortcuts or {})) do
				if shortcut and shortcut.enabled ~= false and EqualsIgnoreCase(shortcut.shortcutId, routeId) then
					local path = TrackPath.FromConfig(shortcut.path)

					if path and path:getIsValid() then
						local laneCount = math.max(1, (not shortcut.laneCount or nil) and 1)
						local routeHeight = math.max(0, (not route.height or nil) and 0)

						self:_cacheRoutePath(routeId, path, laneCount, routeHeight)

						return path, laneCount, routeHeight
					end

					break
				end
			end
		end

		for _, route in ipairs(network.underwaterRoutes or {}) do
			if route and route.enabled ~= false and EqualsIgnoreCase(route.underwaterId, routeId) then
				local path = TrackPath.FromConfig(route.path)

				if path and path:getIsValid() then
					local laneCount = math.max(1, (not route.laneCount or nil) and 1)
					local routeHeight = ((route.startY or 0) + (route.endY or 0)) * 0.5

					self:_cacheRoutePath(routeId, path, laneCount, routeHeight)

					return path, laneCount, routeHeight
				end

				break
			end
		end

		return nil, DefaultLaneCount, 0
	end
end

function RacingTrackElementSpawner:_cacheRoutePath(routeId, path, laneCount, routeHeight)
	self._routePathCache = self._routePathCache or {}
	self._routePathCache[routeId] = {
		path = path,
		laneCount = laneCount,
		routeHeight = routeHeight
	}
end

function RacingTrackElementSpawner:_resolveElementType(elementId)
	if self._elementTypes then
		if self._elementTypes and self._elementTypes.runtimeElementType then
			return self._elementTypes.runtimeElementType
		end

		return TrackElementType.ShortcutJumpPad
	end
end

function RacingTrackElementSpawner:_hasAuthoredTrigger(routeId, elementId, distance, laneId)
	local placedElements = self:_resolveAuthoredPlacedElements(routeId)

	for _, placed in ipairs(placedElements) do
		if placed and placed.enabled ~= false and EqualsIgnoreCase(placed.elementId, elementId) then
			if math.abs((placed.distance or 0) - distance) <= 0.5 then
				if (placed.laneId or 1) == laneId then
					return true
				end
			end
		end
	end

	return false
end

function RacingTrackElementSpawner:_hasAuthoredElementAtDistance(routeId, elementId, distance)
	for _, placed in ipairs(self:_resolveAuthoredPlacedElements(routeId)) do
		if placed and placed.enabled ~= false and EqualsIgnoreCase(placed.elementId, elementId) then
			if math.abs((placed.distance or 0) - (distance or 0)) <= 0.5 then
				return true
			end
		end
	end

	return false
end

function RacingTrackElementSpawner:_resolveAuthoredPlacedElements(routeId)
	local trackData = self._trackData

	if not trackData then
		return {}
	end

	if not routeId or routeId == "" or EqualsIgnoreCase(routeId, RouteIdMain) then
		return trackData.placedElements or {}
	end

	for _, shortcut in ipairs(trackData.normalShortcuts or {}) do
		if shortcut and EqualsIgnoreCase(shortcut.shortcutId, routeId) then
			return shortcut.placedElements or {}
		end
	end

	local authoredNetwork = trackData.routeNetwork

	if not authoredNetwork then
		return {}
	end

	for _, route in ipairs(authoredNetwork.routes or {}) do
		if route and EqualsIgnoreCase(route.routeId, routeId) then
			return route.placedElements or {}
		end

		for _, shortcut in ipairs((route or nil) and (route.normalShortcuts or {})) do
			if shortcut and EqualsIgnoreCase(shortcut.shortcutId, routeId) then
				return shortcut.placedElements or {}
			end
		end
	end

	for _, route in ipairs(authoredNetwork.underwaterRoutes or {}) do
		if route and EqualsIgnoreCase(route.underwaterId, routeId) then
			return route.placedElements or {}
		end
	end

	for _, slope in ipairs(authoredNetwork.snowSlopeRoutes or {}) do
		if slope and EqualsIgnoreCase(slope.slopeId, routeId) then
			return slope.placedElements or {}
		end
	end

	for _, climb in ipairs(authoredNetwork.waterfallClimbRoutes or {}) do
		if climb and EqualsIgnoreCase(climb.climbId, routeId) then
			return climb.placedElements or {}
		end
	end

	for _, glide in ipairs(authoredNetwork.glides or {}) do
		if glide and EqualsIgnoreCase(glide.glideId, routeId) then
			return glide.placedElements or {}
		end
	end

	return {}
end

function RacingTrackElementSpawner:_buildAndAddRouteEntryElement(path, elementType, elementId, routeId, distance, laneId, laneCount, routeHeight, lengthOverride, sourceId, isSpecialRouteEntryTrigger, worldPose)
	local safeLaneCount = math.max(1, laneCount)
	local laneIndex, coveredLaneIndex = self:_resolveLaneIndices(laneId, safeLaneCount)
	local roadWidth = path and path:getIsValid() and math.max(0.01, path:getRoadWidth()) or math.max(0.01, self._mainRoadWidth)
	local laneWidth = roadWidth / safeLaneCount
	local lateral = roadWidth * 0.5 - (laneIndex + 0.5) * laneWidth
	local halfWidth = laneWidth * LaneHalfWidthFactor

	if (lengthOverride or 0) > 0 then
		if not ((lengthOverride or 0) * 0.5) then
			local halfLength = DefaultHalfLength
			local pose = path and path:getIsValid() and path:Sample(distance, lateral) or {
				position = {
					x = 0,
					y = 0
				},
				tangent = {
					x = 0,
					y = 1
				}
			}

			if self._elementTypes then
				local elementInfo = self._elementTypes[elementId]

				elementInfo = elementInfo or {
					elementId = elementId,
					runtimeElementType = elementType
				}

				local var_53_2 = {
					available = true,
					respawnSec = 0,
					respawnRemainingSec = 0,
					ElementInfo = elementInfo,
					ElementType = elementType,
					Distance = distance,
					StartDistance = distance - halfLength,
					EndDistance = distance + halfLength,
					LateralMin = lateral - halfWidth,
					LateralMax = lateral + halfWidth,
					LateralCenter = lateral,
					Pose = pose,
					CoveredLaneStart = coveredLaneIndex,
					CoveredLaneEnd = coveredLaneIndex,
					BlocksEntireRoad = safeLaneCount == 1,
					SourceElementType = elementType,
					SourceId = sourceId and sourceId ~= "" and sourceId or string.format("%s:%s", tostring(routeId), tostring(elementId)),
					RouteId = routeId or RouteIdMain,
					normalizedRouteId = string.lower(tostring(routeId or RouteIdMain)),
					LaneCount = safeLaneCount
				}

				if worldPose and worldPose.position then
					var_53_2.RouteHeight = worldPose.position.y or routeHeight or 0
				end

				if worldPose then
					var_53_2.WorldPosition = worldPose.position or nil
				end

				if worldPose then
					var_53_2.WorldForward = worldPose.forward or nil
				end

				if worldPose then
					var_53_2.WorldUp = worldPose.up or nil
				end

				var_53_2.IsSpecialRouteEntryTrigger = isSpecialRouteEntryTrigger == true

				local element = var_53_2
				local configId = elementInfo and elementInfo.configId
				local elementConfig = V3a9RacingCarConfig.instance:getRacingElementConfig(tonumber(configId))

				if elementConfig then
					element.respawnSec = elementConfig.refreshTime
				end

				element.go = self:_createElementGameObject(element)

				table.insert(self._generatedElements, element)

				return element
			end
		end
	end
end

function RacingTrackElementSpawner:getGeneratedElements()
	return self._generatedElements
end

function RacingTrackElementSpawner:_disposeGeneratedRoots()
	if self._specialTrackRecommendationPresentation then
		self._specialTrackRecommendationPresentation:dispose()
	end

	self._specialTrackRecommendationPresentation = nil

	if not gohelper.isNil(self._rootGo) then
		gohelper.destroy(self._rootGo)
	end

	self._rootGo = nil
end

function RacingTrackElementSpawner:dispose()
	self:_disposeGeneratedRoots()

	self._parentGo = nil
	self._trackPath = nil
	self._generatedElements = {}
	self._trackConfig = nil
	self._elementTypes = nil
	self._trackData = nil
	self._routePathCache = nil
end

return RacingTrackElementSpawner
