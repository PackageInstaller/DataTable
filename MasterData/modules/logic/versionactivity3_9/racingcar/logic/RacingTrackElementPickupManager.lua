-- chunkname: @modules/logic/versionactivity3_9/racingcar/logic/RacingTrackElementPickupManager.lua

module("modules.logic.versionactivity3_9.racingcar.logic.RacingTrackElementPickupManager", package.seeall)

local RacingTrackElementPickupManager = class("RacingTrackElementPickupManager")
local TrackElementType = RacingTrackElementSpawner.TrackElementType
local WaterfallClimb = require("modules.logic.versionactivity3_9.racingcar.logic.specialtrack.WaterfallClimb")
local Glide = require("modules.logic.versionactivity3_9.racingcar.logic.specialtrack.Glide")
local JumpPadApproachRules = require("modules.logic.versionactivity3_9.racingcar.logic.RacingJumpPadApproachRules")
local NormalizedRouteIdMain = "main"
local PickupDistanceTolerance = 2.5
local PickupLateralTolerance = 0.5
local GlidePickupHeightTolerance = 5
local StartFinishVisualSwapDistance = 300
local StartElementConfigId = 13905
local FinishElementConfigId = 13906
local ShortcutJumpLandingDistanceOffset = 185
local ShortcutJumpDurationSec = 1
local ShortcutJumpHeight = 32
local ShortcutJumpLaunchSpeedMultiplier = 1
local ObstacleSlowdownBuffType = 1012
local ObstacleInvulnerabilitySec = 2
local SpatialHashBucketSize = 20
local MaxElementBuckets = 10
local ForwardVisualCullDistance = 500
local RearVisualRetainDistance = 10
local ForwardVisualCullInterval = 0.1

local function IsFiniteNumber(value)
	return type(value) == "number" and value == value and value ~= math.huge and value ~= -math.huge
end

local function CompareForwardVisualElementDistance(a, b)
	return (a.Distance or 0) < (b.Distance or 0)
end

local function LowerBoundForwardVisualElement(elements, distance)
	local low, high = 1, #elements + 1

	::label_3_0::

	while low < high do
		local middle = math.floor((low + high) * 0.5)

		if middle <= #elements then
			if (elements[middle].Distance or 0) < distance then
				low = middle + 1

				goto label_3_0
			end
		end

		high = middle
	end

	return low
end

local function UpperBoundForwardVisualElement(elements, distance)
	local low, high = 1, #elements + 1

	::label_4_0::

	while low < high do
		local middle = math.floor((low + high) * 0.5)

		if middle <= #elements then
			if (elements[middle].Distance or 0) <= distance then
				low = middle + 1

				goto label_4_0
			end
		end

		high = middle
	end

	return low
end

function RacingTrackElementPickupManager:ctor()
	self._runtimeConfig = nil
	self._elements = {}
	self._player = nil
	self._aiRacers = {}
	self._collisionConfig = {}
	self._boostConfig = {}
	self._playerOverlapPrev = {}
	self._playerOverlapNext = {}
	self._aiOverlapPrev = {}
	self._aiOverlapNext = {}
	self._spatialHash = {}
	self._queryDedupSet = {}
	self._invalidSpatialHashDistanceLogged = false
	self._invalidCandidateDistanceLogged = false
	self._activeRespawns = {}
	self._activeRespawnSet = {}
	self._startFinishVisualStartDistance = 0
	self._startFinishVisualSwapped = false
	self._hasStartFinishVisuals = false
	self._forwardVisualCullRemaining = 0
	self._forwardVisualCullElements = {}
	self._forwardVisualCullElementsByRoute = {}
	self._forwardVisualCullStateByRoute = {}
	self._forwardVisualCullRouteId = nil
	self._forwardVisualCullKeepsMainExit = false
end

function RacingTrackElementPickupManager:initialize(trackConfig, elements, player, aiRacers, trackPath)
	self._runtimeConfig = trackConfig or {}
	self._collisionConfig = self._runtimeConfig.collision or {}
	self._boostConfig = self._runtimeConfig.boost or {}
	self._elements = elements or {}
	self._player = player
	self._aiRacers = aiRacers or {}
	self._trackPath = trackPath

	tabletool.clear(self._activeRespawns)
	tabletool.clear(self._activeRespawnSet)

	for i = 1, #self._elements do
		local element = self._elements[i]

		if not element.available then
			if (element.respawnRemainingSec or 0) > 0 then
				self._activeRespawnSet[element] = true
				self._activeRespawns[#self._activeRespawns + 1] = element
			end
		end
	end

	self:_buildSpatialHash()
	self:_buildForwardVisualCullCache()
	self:_resetStartFinishVisuals()

	self._forwardVisualCullRemaining = 0

	self:_updateForwardVisualCulling(0, true)
end

function RacingTrackElementPickupManager:_buildSpatialHash()
	local hash = self._spatialHash

	for k in pairs(hash) do
		local bucket = hash[k]

		for i = #bucket, 1, -1 do
			bucket[i] = nil
		end

		hash[k] = nil
	end

	local bucketSize = SpatialHashBucketSize
	local maxBuckets = MaxElementBuckets

	for i = 1, #self._elements do
		local element = self._elements[i]

		if not element.StartDistance then
			local startDist = 0

			if not element.EndDistance then
				local endDist = startDist

				if IsFiniteNumber(startDist) and IsFiniteNumber(endDist) then
					local startBucket = math.floor(startDist / bucketSize)
					local endBucket = math.floor(endDist / bucketSize)
					local numBuckets = math.min(endBucket - startBucket + 1, maxBuckets)

					for offset = 0, numBuckets - 1 do
						local b = startBucket + offset
						local bucket = hash[b]

						if not bucket then
							bucket = {}
							hash[b] = bucket
						end

						bucket[#bucket + 1] = element
					end
				elseif not self._invalidSpatialHashDistanceLogged then
					self._invalidSpatialHashDistanceLogged = true

					logError(string.format("RacingTrackElementPickupManager:_buildSpatialHash invalid distance, index=%s start=%s end=%s", tostring(i), tostring(startDist), tostring(endDist)))
				end
			end
		end
	end
end

function RacingTrackElementPickupManager:_getCandidateElements(distance)
	local hash = self._spatialHash
	local dedupSet = self._queryDedupSet
	local result = self._candidateResult

	if not result then
		result = {}
		self._candidateResult = result
	else
		for i = #result, 1, -1 do
			result[i] = nil
		end
	end

	if not IsFiniteNumber(distance) then
		if not self._invalidCandidateDistanceLogged then
			self._invalidCandidateDistanceLogged = true

			logError(string.format("RacingTrackElementPickupManager:_getCandidateElements invalid distance=%s", tostring(distance)))
		end

		return result
	end

	local bucketIdx = math.floor(distance / SpatialHashBucketSize)

	for offset = -1, 1 do
		local b = bucketIdx + offset
		local bucket = hash[b]

		if bucket then
			for i = 1, #bucket do
				local element = bucket[i]

				if not dedupSet[element] then
					dedupSet[element] = true
					result[#result + 1] = element
				end
			end
		end
	end

	return result
end

function RacingTrackElementPickupManager:update(deltaTime)
	self:_updateStartFinishVisuals()
	self:_updateForwardVisualCulling(deltaTime)
	self:_updateRespawn(deltaTime)

	local nextBuf = self._playerOverlapNext

	tabletool.clear(nextBuf)

	if self._player and self._player:hasTrackState() and not self._player:isShortcutJumping() and (not self._player.isPostFinish or not self._player:isPostFinish()) then
		local playerDistance = self:_resolvePickupDistance(self._player:getTrackDistance())
		local playerLateral = self._player:getLateralOffset()

		playerDistance, playerLateral = WaterfallClimb.ResolveElementPickupCoordinates(self._player, playerDistance, playerLateral)

		local playerAltitudeOffset

		playerDistance, playerLateral, playerAltitudeOffset = Glide.ResolveElementPickupCoordinates(self._player, playerDistance, playerLateral)

		local playerRouteId = self._player.getNormalizedRouteId and self._player:getNormalizedRouteId() or NormalizedRouteIdMain
		local prevOverlapping = self._playerOverlapPrev

		tabletool.clear(self._queryDedupSet)

		local candidates = self:_getCandidateElements(playerDistance)

		self:_updateShortcutJumpApproach(self._player, playerDistance, playerLateral, playerRouteId, candidates)

		for ci = 1, #candidates do
			local element = candidates[ci]

			if not element.IsPresentationOnly and not element.available then
				-- block empty
			elseif element.IsPresentationOnly then
				-- block empty
			elseif not self:_elementMatchesRoute(element, playerRouteId) then
				-- block empty
			elseif not self:_elementMatchesGlideHeight(element, playerAltitudeOffset) then
				-- block empty
			elseif element.ElementType == TrackElementType.CoinString then
				local absorbRadius = self._player:getCoinAbsorbRadius()

				if absorbRadius and absorbRadius > 0 then
					if self:_isOverlappingWithAbsorb(element, playerDistance, playerLateral, absorbRadius) and self:_applyToPlayer(element) then
						self:_dispatchCoinAbsorbVisual(element)
						self:_startRespawn(element)

						if element.ElementInfo then
							local configId = element.ElementInfo.configId

							RacingCarSkillManager.instance:executePassiveSkills(self._player, RacingCarPropEnum.TriggerType.GetElement, self._player, tonumber(configId))
						end
					end
				elseif self:_isOverlapping(element, playerDistance, playerLateral) and self:_applyToPlayer(element) then
					if self._player.isItemFlying and self._player:isItemFlying() then
						self:_dispatchCoinAbsorbVisual(element)
					end

					self:_startRespawn(element)

					if element.ElementInfo then
						local configId = element.ElementInfo.configId

						RacingCarSkillManager.instance:executePassiveSkills(self._player, RacingCarPropEnum.TriggerType.GetElement, self._player, tonumber(configId))
					end
				end
			else
				if element.ElementType == TrackElementType.ItemPickup and V3a9RacingCarModel.instance:getGuideParams(V3a9RacingCarEnum.GuideParam.Item) then
					if self:_isWithinDistance(element, playerDistance, playerLateral, 10) then
						V3a9RacingCarModel.instance:setGuideParams(V3a9RacingCarEnum.GuideParam.Item, false)
						V3a9RacingCarController.instance:dispatchEvent(V3a9RacingCarEvent.GuideNearItem)
					end
				elseif element.ElementType == TrackElementType.CoinString and V3a9RacingCarModel.instance:getGuideParams(V3a9RacingCarEnum.GuideParam.Coin) then
					if self:_isWithinDistance(element, playerDistance, playerLateral, 10) then
						V3a9RacingCarModel.instance:setGuideParams(V3a9RacingCarEnum.GuideParam.Coin, false)
						V3a9RacingCarController.instance:dispatchEvent(V3a9RacingCarEvent.GuideNearCoin)
					end
				elseif element.ElementType == TrackElementType.Obstacle and V3a9RacingCarModel.instance:getGuideParams(V3a9RacingCarEnum.GuideParam.Obstacle) and self:_isWithinDistance(element, playerDistance, playerLateral, V3a9RacingCarModel.instance:getGuideParams(V3a9RacingCarEnum.GuideParam.Obstacle)) then
					V3a9RacingCarModel.instance:setGuideParams(V3a9RacingCarEnum.GuideParam.Obstacle, false)
					V3a9RacingCarController.instance:dispatchEvent(V3a9RacingCarEvent.GuideNearObstacle)
				end

				if self:_isOverlapping(element, playerDistance, playerLateral) then
					if not self:_isPersistentElement(element) or not prevOverlapping[element] then
						if self:_applyToPlayer(element) then
							nextBuf[element] = true

							if not element.IsSpecialRouteEntryTrigger then
								self:_startRespawn(element)
							end

							if element.ElementInfo then
								local configId = element.ElementInfo.configId

								RacingCarSkillManager.instance:executePassiveSkills(self._player, RacingCarPropEnum.TriggerType.GetElement, self._player, tonumber(configId))
							end
						end
					else
						nextBuf[element] = true
					end
				end
			end
		end
	end

	self._playerOverlapPrev, self._playerOverlapNext = nextBuf, self._playerOverlapPrev

	self:_updateAiPickup()
end

function RacingTrackElementPickupManager:_updateAiPickup()
	for _, aiRacer in ipairs(self._aiRacers) do
		local prevBuf = self._aiOverlapPrev[aiRacer]
		local nextBuf = self._aiOverlapNext[aiRacer]

		if not prevBuf then
			prevBuf = {}
			self._aiOverlapPrev[aiRacer] = prevBuf
		end

		if not nextBuf then
			nextBuf = {}
			self._aiOverlapNext[aiRacer] = nextBuf
		end

		tabletool.clear(nextBuf)

		if aiRacer and aiRacer:hasTrackState() and not aiRacer:isShortcutJumping() and (not aiRacer.isPostFinish or not aiRacer:isPostFinish()) then
			local aiDistance = self:_resolvePickupDistance(aiRacer:getTrackDistance())
			local aiLateral = aiRacer:getLateralOffset()
			local aiRouteId = aiRacer.getNormalizedRouteId and aiRacer:getNormalizedRouteId() or NormalizedRouteIdMain

			tabletool.clear(self._queryDedupSet)

			local candidates = self:_getCandidateElements(aiDistance)

			self:_updateShortcutJumpApproach(aiRacer, aiDistance, aiLateral, aiRouteId, candidates)

			for ci = 1, #candidates do
				local element = candidates[ci]

				if element.available and not element.IsPresentationOnly and self:_elementMatchesRoute(element, aiRouteId) and element.ElementType ~= TrackElementType.CoinString and self:_isOverlapping(element, aiDistance, aiLateral) then
					if not self:_isPersistentElement(element) or not prevBuf[element] then
						if self:_applyToAiRacer(aiRacer, element) then
							nextBuf[element] = true

							if not self:_isPersistentElement(element) then
								self:_startRespawn(element)
							end

							if element.ElementInfo then
								local configId = element.ElementInfo.configId

								RacingCarSkillManager.instance:executePassiveSkills(aiRacer, RacingCarPropEnum.TriggerType.GetElement, aiRacer, tonumber(configId))
							end
						end
					else
						nextBuf[element] = true
					end
				end
			end
		end

		self._aiOverlapPrev[aiRacer], self._aiOverlapNext[aiRacer] = nextBuf, prevBuf
	end
end

function RacingTrackElementPickupManager:_updateShortcutJumpApproach(racer, distance, lateral, routeId, candidates)
	if not racer or not racer.setJumpPadApproachVisualHeight then
		return
	end

	if racer.isItemFlying and racer:isItemFlying() or racer.isSpecialTrackAirbornePresentationActive and racer:isSpecialTrackAirbornePresentationActive() then
		racer:setJumpPadApproachVisualHeight(0)

		return
	end

	local resolvedHeight = 0

	for i = 1, #(candidates or {}) do
		local element = candidates[i]

		if element.available and not element.IsPresentationOnly and not element.IsSpecialRouteEntryTrigger and element.ElementType == TrackElementType.ShortcutJumpPad and self:_elementMatchesRoute(element, routeId) then
			local lateralMin = (element.LateralMin or 0) - PickupLateralTolerance
			local lateralMax = (element.LateralMax or 0) + PickupLateralTolerance
			local centerDistance = ((element.StartDistance or 0) + (element.EndDistance or 0)) * 0.5
			local approachStartDistance = centerDistance - JumpPadApproachRules.ApproachCenterLeadDistance
			local triggerStartDistance = (element.StartDistance or centerDistance) - PickupDistanceTolerance
			local triggerEndDistance = (element.EndDistance or centerDistance) + PickupDistanceTolerance

			if lateralMin <= lateral and lateral <= lateralMax and approachStartDistance <= distance and distance <= triggerEndDistance then
				local approachDistance = math.min(distance, triggerStartDistance)

				resolvedHeight = math.max(resolvedHeight, JumpPadApproachRules.ResolveApproachHeight(approachDistance, approachStartDistance, triggerStartDistance))
			end
		end
	end

	racer:setJumpPadApproachVisualHeight(resolvedHeight)
end

function RacingTrackElementPickupManager:_elementMatchesRoute(element, currentRouteId)
	local elementRouteId = element.normalizedRouteId

	elementRouteId = elementRouteId or NormalizedRouteIdMain

	return elementRouteId == (currentRouteId or NormalizedRouteIdMain)
end

function RacingTrackElementPickupManager:_elementMatchesGlideHeight(element, currentAltitudeOffset)
	local elementAltitudeOffset = element and element.AltitudeOffset

	if elementAltitudeOffset == nil then
		return true
	end

	return currentAltitudeOffset ~= nil and math.abs(elementAltitudeOffset - currentAltitudeOffset) <= GlidePickupHeightTolerance
end

function RacingTrackElementPickupManager:_resolvePickupDistance(totalDistance)
	totalDistance = totalDistance or 0

	if not self._trackPath then
		return totalDistance
	end

	local trackLength = self._trackPath:getEndDistance() - self._trackPath:getStartDistance()

	if trackLength <= 0 then
		return totalDistance
	end

	local mod = totalDistance % trackLength

	if mod < 0 then
		mod = mod + trackLength
	end

	return mod + self._trackPath:getStartDistance()
end

function RacingTrackElementPickupManager:_isOverlapping(element, distance, lateral)
	local startDist = element.StartDistance - PickupDistanceTolerance
	local endDist = element.EndDistance + PickupDistanceTolerance

	if distance < startDist or endDist < distance then
		return false
	end

	local lateralMin = element.LateralMin - PickupLateralTolerance
	local lateralMax = element.LateralMax + PickupLateralTolerance

	if lateral < lateralMin or lateralMax < lateral then
		return false
	end

	return true
end

function RacingTrackElementPickupManager:_isWithinDistance(element, distance, lateral, threshold)
	local startDist = element.StartDistance - PickupDistanceTolerance - threshold
	local endDist = element.EndDistance + PickupDistanceTolerance + threshold

	if distance < startDist or endDist < distance then
		return false
	end

	local lateralMin = element.LateralMin - PickupLateralTolerance - threshold
	local lateralMax = element.LateralMax + PickupLateralTolerance + threshold

	if lateral < lateralMin or lateralMax < lateral then
		return false
	end

	return true
end

function RacingTrackElementPickupManager:_isOverlappingWithAbsorb(element, distance, lateral, absorbRadius)
	local startDist = element.StartDistance - PickupDistanceTolerance
	local endDist = element.EndDistance + PickupDistanceTolerance

	if distance < startDist or endDist < distance then
		return false
	end

	local lateralMin = element.LateralMin - PickupLateralTolerance - absorbRadius
	local lateralMax = element.LateralMax + PickupLateralTolerance + absorbRadius

	if lateral < lateralMin or lateralMax < lateral then
		return false
	end

	return true
end

function RacingTrackElementPickupManager:_dispatchCoinAbsorbVisual(element)
	if not V3a9RacingCarController or not V3a9RacingCarController.instance or not V3a9RacingCarEvent then
		return
	end

	V3a9RacingCarController.instance:dispatchEvent(V3a9RacingCarEvent.OnCoinAbsorbVisual, element and element.go)
end

function RacingTrackElementPickupManager:_executeElementEffects(configId, target, triggerType)
	local elementConfig = V3a9RacingCarConfig.instance:getRacingElementConfig(tonumber(configId))

	if not elementConfig or not elementConfig.effect then
		return
	end

	local effectList = string.splitToNumber(elementConfig.effect, "|")

	for i, effectId in ipairs(effectList) do
		RacingCarSkillManager.instance:executeEffect(effectId, target, triggerType, target)
	end
end

function RacingTrackElementPickupManager:_applyObstacleImpact(racer, element)
	if element.ElementInfo then
		if racer:getIsPenetrateActive() and racer.buffManager then
			racer.buffManager:triggerPenetrate()
		end

		if racer.isItemFlying and racer:isItemFlying() then
			return true
		end

		if racer:getIsInvisible() then
			return false
		end

		if racer:isInvulnerable() then
			return true
		end

		if racer.buffManager and racer.buffManager.isBuffTypeImmuned and racer.buffManager:isBuffTypeImmuned(ObstacleSlowdownBuffType) then
			return true
		end

		self:_executeElementEffects(element.ElementInfo, racer, RacingCarPropEnum.TriggerType.CarOverlap)

		if racer.resetPerfectDodgeCombo then
			racer:resetPerfectDodgeCombo()
		end

		racer:_setInvulnerableFor(ObstacleInvulnerabilitySec, true)
		RacingCarSkillManager.instance:executePassiveSkills(racer, RacingCarPropEnum.TriggerType.BeImpact, racer)

		return true
	end
end

function RacingTrackElementPickupManager:_applyToPlayer(element)
	local player = self._player
	local elementType = element.ElementType

	if element.ElementInfo then
		local configId = element.ElementInfo.configId

		if element.ElementInfo then
			local elementId = element.ElementInfo.elementId

			if elementId and elementId ~= "" then
				if player.tryActivateRouteTransfer and player:tryActivateRouteTransfer(elementId) then
					self:_executeElementEffects(configId, player, RacingCarPropEnum.TriggerType.CarOverlap)

					return true
				end

				if player.tryActivateUnderwaterRoute and player:tryActivateUnderwaterRoute(elementId) then
					return true
				end

				if player.tryActivateSnowSlopeRoute and player:tryActivateSnowSlopeRoute(elementId) then
					return true
				end

				if player.tryActivateGlide and player:tryActivateGlide(elementId) then
					return true
				end

				if player.tryActivateWaterfallClimbRoute and player:tryActivateWaterfallClimbRoute(elementId) then
					return true
				end

				if player.tryActivateAirWaterDrop and player:tryActivateAirWaterDrop(elementId) then
					return true
				end

				if player.tryActivateUnderwaterExit and player:tryActivateUnderwaterExit(elementId) then
					return true
				end
			end

			if elementType == TrackElementType.CoinString then
				self:_executeElementEffects(configId, player, RacingCarPropEnum.TriggerType.CarOverlap)
				player:addCoinEnergy()

				return true
			elseif elementType == TrackElementType.ItemPickup then
				local elementConfig = V3a9RacingCarConfig.instance:getRacingElementConfig(tonumber(configId))

				if elementConfig then
					if not elementConfig.param then
						local itemListStr = ""
						local itemList = GameUtil.splitString2(itemListStr, true, "|", "#")

						if not itemList or #itemList <= 0 then
							logError("RacingTrackElementPickupManager itemList is empty", configId, itemListStr)

							return false
						end

						local weight = 0

						for i, v in ipairs(itemList) do
							weight = weight + v[2]
						end

						local randomWeight = math.random(0, weight)
						local cumulativeWeight = 0

						for i, v in ipairs(itemList) do
							cumulativeWeight = cumulativeWeight + v[2]

							if randomWeight <= cumulativeWeight or i == #itemList then
								local itemId = v[1]
								local item = V3a9RacingCarConfig.instance:getRacingItemConfig(itemId)

								if player:tryStoreItem(item) then
									AudioMgr.instance:trigger(V3a9RacingCarEnum.AudioId.PlayDiqiuUnlock)
								end

								self:_spawnDaojuEffect(player, element)

								break
							end
						end

						return true
					end
				end
			elseif elementType == TrackElementType.BoostPad then
				AudioMgr.instance:trigger(V3a9RacingCarEnum.AudioId.PlayYuanzhengMrsJiasu)
				self:_executeElementEffects(configId, player, RacingCarPropEnum.TriggerType.CarOverlap)

				return true
			elseif elementType == TrackElementType.Obstacle or elementType == TrackElementType.DangerZone then
				local result = self:_applyObstacleImpact(player, element)

				if result then
					AudioMgr.instance:trigger(V3a9RacingCarEnum.AudioId.PlayBulaochuanBubbleBurst)
				end

				return result
			elseif elementType == TrackElementType.ShortcutJumpPad then
				local applied = self:_applyShortcutJumpPad(player, element)

				if applied then
					self:_executeElementEffects(configId, player, RacingCarPropEnum.TriggerType.CarOverlap)
				end

				return applied
			end

			return false
		end
	end
end

function RacingTrackElementPickupManager:_applyShortcutJumpPad(racer, element)
	if not racer.tryStartShortcutJump or not racer.getLaneCount then
		return false
	end

	if racer.isItemFlying and racer:isItemFlying() then
		return false
	end

	local laneCount = math.max(1, racer:getLaneCount())

	if not element.CoveredLaneStart then
		local coveredStart = 0

		if not element.CoveredLaneEnd then
			local coveredEnd = coveredStart
			local entryLane = Mathf.Clamp(math.floor((coveredStart + coveredEnd) / 2), 0, laneCount - 1)
			local landingLane

			return racer:tryStartShortcutJump(ShortcutJumpLandingDistanceOffset, entryLane < laneCount / 2 and math.min(laneCount - 1, entryLane + 1) or math.max(0, entryLane - 1), laneCount, ShortcutJumpDurationSec, ShortcutJumpHeight, ShortcutJumpLaunchSpeedMultiplier)
		end
	end
end

function RacingTrackElementPickupManager:_applyToAiRacer(aiRacer, element)
	local elementType = element.ElementType

	if element.ElementInfo then
		local configId = element.ElementInfo.configId

		if elementType == TrackElementType.BoostPad then
			self:_executeElementEffects(configId, aiRacer, RacingCarPropEnum.TriggerType.CarOverlap)

			return true
		elseif elementType == TrackElementType.Obstacle or elementType == TrackElementType.DangerZone then
			return self:_applyObstacleImpact(aiRacer, element)
		elseif elementType == TrackElementType.ItemPickup then
			local elementConfig = V3a9RacingCarConfig.instance:getRacingElementConfig(tonumber(configId))

			if elementConfig then
				if not elementConfig.param then
					local itemListStr = ""
					local itemList = GameUtil.splitString2(itemListStr, true, "|", "#")

					if not itemList or #itemList <= 0 then
						return false
					end

					local weight = 0

					for i, v in ipairs(itemList) do
						weight = weight + v[2]
					end

					local randomWeight = math.random(0, weight)
					local cumulativeWeight = 0

					for i, v in ipairs(itemList) do
						cumulativeWeight = cumulativeWeight + v[2]

						if randomWeight <= cumulativeWeight or i == #itemList then
							local itemId = v[1]
							local item = V3a9RacingCarConfig.instance:getRacingItemConfig(itemId)

							if item then
								aiRacer:tryStoreItem(item)
							end

							break
						end
					end

					return true
				end
			end
		elseif elementType == TrackElementType.ShortcutJumpPad then
			return self:_applyShortcutJumpPad(aiRacer, element)
		end

		return false
	end
end

function RacingTrackElementPickupManager:_isPersistentElement(element)
	local elementType = element.ElementType

	return element.IsSpecialRouteEntryTrigger == true or elementType == TrackElementType.BoostPad or elementType == TrackElementType.ShortcutJumpPad or elementType == TrackElementType.Obstacle
end

function RacingTrackElementPickupManager:_startRespawn(element)
	element.available = false
	element.respawnRemainingSec = math.max(0, element.respawnSec or 0)

	self:_setElementVisible(element, false)

	if element.respawnRemainingSec > 0 and not self._activeRespawnSet[element] then
		self._activeRespawnSet[element] = true
		self._activeRespawns[#self._activeRespawns + 1] = element
	end
end

function RacingTrackElementPickupManager:_updateRespawn(deltaTime)
	local activeRespawns = self._activeRespawns

	for i = #activeRespawns, 1, -1 do
		local element = activeRespawns[i]

		element.respawnRemainingSec = math.max(0, element.respawnRemainingSec - deltaTime)

		if element.respawnRemainingSec <= 0 then
			element.available = true

			self:_setElementVisible(element, true)

			self._activeRespawnSet[element] = nil
			activeRespawns[i] = activeRespawns[#activeRespawns]
			activeRespawns[#activeRespawns] = nil
		end
	end
end

function RacingTrackElementPickupManager:_isForwardVisualCullType(elementType)
	return elementType == TrackElementType.Obstacle or elementType == TrackElementType.CoinString or elementType == TrackElementType.BoostPad or elementType == TrackElementType.ItemPickup or elementType == TrackElementType.ShortcutJumpPad
end

function RacingTrackElementPickupManager:_buildForwardVisualCullCache()
	local targetElements = self._forwardVisualCullElements
	local elementsByRoute = self._forwardVisualCullElementsByRoute
	local stateByRoute = self._forwardVisualCullStateByRoute

	tabletool.clear(targetElements)
	tabletool.clear(elementsByRoute)
	tabletool.clear(stateByRoute)

	self._forwardVisualCullRouteId = nil
	self._forwardVisualCullKeepsMainExit = false

	for i = 1, #self._elements do
		local element = self._elements[i]
		local configId = tonumber((element.ElementInfo or nil) and element.ElementInfo.configId)
		local isStartOrFinish = configId == StartElementConfigId or configId == FinishElementConfigId

		if not element.normalizedRouteId then
			local routeId = NormalizedRouteIdMain
			local isNonMainBoostPad = element.ElementType == TrackElementType.BoostPad and routeId ~= NormalizedRouteIdMain

			if self:_isForwardVisualCullType(element.ElementType) and not element.IsPresentationOnly and not element.IsSpecialRouteEntryTrigger and not isStartOrFinish and not isNonMainBoostPad then
				local routeElements = elementsByRoute[routeId]

				if not routeElements then
					routeElements = {}
					elementsByRoute[routeId] = routeElements
				end

				targetElements[#targetElements + 1] = element
				routeElements[#routeElements + 1] = element
			end
		end
	end

	for routeId, routeElements in pairs(elementsByRoute) do
		table.sort(routeElements, CompareForwardVisualElementDistance)

		local currentVisible = {}

		for i = 1, #routeElements do
			currentVisible[routeElements[i]] = true
		end

		stateByRoute[routeId] = {
			currentVisible = currentVisible,
			nextVisible = {}
		}
	end
end

function RacingTrackElementPickupManager:_setRouteElementsRenderersEnabled(routeId, visible)
	local routeElements = self._forwardVisualCullElementsByRoute[routeId]

	if not routeElements then
		return
	end

	for i = 1, #routeElements do
		local element = routeElements[i]

		element.inForwardVisualRange = visible

		self:_setElementRenderersEnabled(element, visible)
	end

	local state = self._forwardVisualCullStateByRoute[routeId]

	if state then
		tabletool.clear(state.currentVisible)
		tabletool.clear(state.nextVisible)

		if visible then
			for i = 1, #routeElements do
				state.currentVisible[routeElements[i]] = true
			end
		end
	end
end

function RacingTrackElementPickupManager:_addForwardVisualRange(routeElements, currentVisible, nextVisible, rangeStart, rangeEnd)
	if rangeEnd < rangeStart then
		return
	end

	local firstIndex = LowerBoundForwardVisualElement(routeElements, rangeStart)
	local endIndex = UpperBoundForwardVisualElement(routeElements, rangeEnd) - 1

	for i = firstIndex, endIndex do
		local element = routeElements[i]

		if element and not nextVisible[element] then
			nextVisible[element] = true

			if not currentVisible[element] then
				element.inForwardVisualRange = true

				self:_setElementRenderersEnabled(element, true)
			end
		end
	end
end

function RacingTrackElementPickupManager:_updateRouteElementsVisualRange(routeId, centerDistance, canWrap, trackLength)
	local routeElements = self._forwardVisualCullElementsByRoute[routeId]
	local state = self._forwardVisualCullStateByRoute[routeId]

	if not routeElements or not state or #routeElements == 0 then
		return
	end

	local currentVisible = state.currentVisible
	local nextVisible = state.nextVisible

	tabletool.clear(nextVisible)

	local rangeStart = centerDistance - RearVisualRetainDistance
	local rangeEnd = centerDistance + ForwardVisualCullDistance

	if canWrap and trackLength > 0 then
		local visualSpan = ForwardVisualCullDistance + RearVisualRetainDistance

		if trackLength <= visualSpan then
			self:_addForwardVisualRange(routeElements, currentVisible, nextVisible, routeElements[1].Distance or 0, routeElements[#routeElements].Distance or 0)
		elseif not routeElements[1].Distance then
			local minimumDistance = 0

			if not routeElements[#routeElements].Distance then
				local maximumDistance = minimumDistance
				local firstShift = math.ceil((rangeStart - maximumDistance) / trackLength)
				local lastShift = math.floor((rangeEnd - minimumDistance) / trackLength)

				for shift = firstShift, lastShift do
					self:_addForwardVisualRange(routeElements, currentVisible, nextVisible, rangeStart - shift * trackLength, rangeEnd - shift * trackLength)
				end
			end
		end
	else
		self:_addForwardVisualRange(routeElements, currentVisible, nextVisible, rangeStart, rangeEnd)
	end

	for element in pairs(currentVisible) do
		if not nextVisible[element] then
			element.inForwardVisualRange = false

			self:_setElementRenderersEnabled(element, false)
		end
	end

	state.currentVisible, state.nextVisible = nextVisible, currentVisible
end

function RacingTrackElementPickupManager:_updateForwardVisualCulling(deltaTime, force)
	self._forwardVisualCullRemaining = (self._forwardVisualCullRemaining or 0) - (deltaTime or 0)

	if not force and self._forwardVisualCullRemaining > 0 then
		return
	end

	self._forwardVisualCullRemaining = ForwardVisualCullInterval

	if not self._player or not self._player.getTrackDistance then
		return
	end

	local playerDistance = self._player:getTrackDistance() or 0

	playerDistance = WaterfallClimb.ResolveElementPickupCoordinates(self._player, playerDistance, 0)
	playerDistance = Glide.ResolveElementPickupCoordinates(self._player, playerDistance, 0)

	local playerRouteId = self._player.getNormalizedRouteId and self._player:getNormalizedRouteId() or NormalizedRouteIdMain
	local trackLength = self._trackPath and self._trackPath:getEndDistance() - self._trackPath:getStartDistance() or 0

	if playerRouteId == NormalizedRouteIdMain then
		if self._trackPath then
			local canWrapMainRoute = true

			if self._trackPath:getIsLoop() then
				canWrapMainRoute = trackLength > 0

				local previousRouteId = self._forwardVisualCullRouteId

				if force then
					for routeId in pairs(self._forwardVisualCullElementsByRoute) do
						if routeId ~= playerRouteId then
							self:_setRouteElementsRenderersEnabled(routeId, false)
						end
					end
				elseif previousRouteId and previousRouteId ~= playerRouteId then
					self:_setRouteElementsRenderersEnabled(previousRouteId, false)
				end

				self._forwardVisualCullRouteId = playerRouteId

				local shortcutExitDistance = self._player.getCurrentMainShortcutExitDistance and self._player:getCurrentMainShortcutExitDistance() or nil
				local currentRouteVisualCenter = playerRouteId == NormalizedRouteIdMain and shortcutExitDistance or playerDistance

				self:_updateRouteElementsVisualRange(playerRouteId, currentRouteVisualCenter, canWrapMainRoute, trackLength)

				if playerRouteId ~= NormalizedRouteIdMain and shortcutExitDistance then
					local var_32_3 = self._trackPath

					if self._trackPath then
						var_32_3 = self._trackPath:getIsLoop()
						var_32_3 = var_32_3 and trackLength > 0
					end

					self:_updateRouteElementsVisualRange(NormalizedRouteIdMain, shortcutExitDistance, var_32_3, trackLength)

					self._forwardVisualCullKeepsMainExit = true
				elseif playerRouteId ~= NormalizedRouteIdMain and self._forwardVisualCullKeepsMainExit then
					self:_setRouteElementsRenderersEnabled(NormalizedRouteIdMain, false)

					self._forwardVisualCullKeepsMainExit = false
				elseif playerRouteId == NormalizedRouteIdMain then
					self._forwardVisualCullKeepsMainExit = false
				end
			end
		end
	end
end

function RacingTrackElementPickupManager:_setElementRenderersEnabled(element, visible)
	local hidden = not visible

	if element.forwardVisualRenderersHidden == nil and not hidden then
		element.forwardVisualRenderersHidden = false

		return
	end

	if element.forwardVisualRenderersHidden == hidden then
		return
	end

	if not element.go or gohelper.isNil(element.go) then
		return
	end

	local renderers = element.forwardVisualRenderers

	if not renderers then
		renderers = {}
		element.forwardVisualRenderers = renderers

		local components = element.go:GetComponentsInChildren(typeof(UnityEngine.Renderer), true)

		if components then
			for i = 0, components.Length - 1 do
				local renderer = components[i]

				if not gohelper.isNil(renderer) then
					renderers[#renderers + 1] = renderer
				end
			end
		end
	end

	if hidden then
		element.forwardVisualRendererStates = element.forwardVisualRendererStates or {}

		local states = element.forwardVisualRendererStates

		tabletool.clear(states)

		for i = 1, #renderers do
			local renderer = renderers[i]

			if not gohelper.isNil(renderer) then
				states[renderer] = renderer.enabled
				renderer.enabled = false
			end
		end
	else
		local states = element.forwardVisualRendererStates

		for i = 1, #renderers do
			local renderer = renderers[i]

			if not gohelper.isNil(renderer) then
				renderer.enabled = not states or states[renderer] ~= false
			end
		end

		if states then
			tabletool.clear(states)
		end
	end

	element.forwardVisualRenderersHidden = hidden
end

function RacingTrackElementPickupManager:_setElementVisible(element, visible)
	if element.go and not gohelper.isNil(element.go) then
		gohelper.setActive(element.go, visible)
	end
end

function RacingTrackElementPickupManager:_resetStartFinishVisuals()
	self._startFinishVisualStartDistance = self._player and self._player.getTotalTrackDistance and self._player:getTotalTrackDistance() or 0
	self._startFinishVisualSwapped = false
	self._hasStartFinishVisuals = false

	for _, element in ipairs(self._elements) do
		local configId = tonumber((element.ElementInfo or nil) and element.ElementInfo.configId)

		if configId == StartElementConfigId or configId == FinishElementConfigId then
			element.IsPresentationOnly = true
			self._hasStartFinishVisuals = true

			self:_setElementVisible(element, configId == StartElementConfigId)
		end
	end
end

function RacingTrackElementPickupManager:_updateStartFinishVisuals()
	if self._startFinishVisualSwapped or not self._hasStartFinishVisuals or not self._player or not self._player.getTotalTrackDistance then
		return
	end

	local currentDistance = self._player:getTotalTrackDistance() or 0
	local forwardDistance = currentDistance - (self._startFinishVisualStartDistance or 0)

	if forwardDistance < StartFinishVisualSwapDistance then
		return
	end

	self._startFinishVisualSwapped = true

	for _, element in ipairs(self._elements) do
		if element.IsPresentationOnly then
			local configId = tonumber((element.ElementInfo or nil) and element.ElementInfo.configId)

			self:_setElementVisible(element, configId == FinishElementConfigId)
		end
	end
end

function RacingTrackElementPickupManager:_getPreloadedResource(res)
	local var_37_0 = GameSceneMgr

	if GameSceneMgr then
		var_37_0 = GameSceneMgr.instance

		if GameSceneMgr.instance then
			local scene = GameSceneMgr.instance:getCurScene()
			local preloader = scene and scene.preloader

			if not preloader or not preloader.getResource then
				return nil
			end

			return preloader:getResource(res)
		end
	end
end

function RacingTrackElementPickupManager:_spawnPropEffect(resPath, parentGo, name)
	if gohelper.isNil(parentGo) then
		return nil
	end

	local prefab = self:_getPreloadedResource(resPath)

	if gohelper.isNil(prefab) then
		return nil
	end

	return gohelper.clone(prefab, parentGo, name)
end

function RacingTrackElementPickupManager:_spawnDaojuEffect(player, element)
	local playerGo = player._go

	if not gohelper.isNil(playerGo) then
		self._playerDaojuBigGo = self._playerDaojuBigGo or self:_spawnPropEffect(V3a9RacingCarScenePreloader.DaojuBig, playerGo, "daoju_big")

		gohelper.setActive(self._playerDaojuBigGo, false)
		gohelper.setActive(self._playerDaojuBigGo, true)
	end
end

function RacingTrackElementPickupManager:dispose()
	self._elements = {}
	self._player = nil
	self._aiRacers = {}
	self._runtimeConfig = nil

	tabletool.clear(self._playerOverlapPrev)
	tabletool.clear(self._playerOverlapNext)
	tabletool.clear(self._aiOverlapPrev)
	tabletool.clear(self._aiOverlapNext)

	for k in pairs(self._spatialHash) do
		local bucket = self._spatialHash[k]

		for i = #bucket, 1, -1 do
			bucket[i] = nil
		end

		self._spatialHash[k] = nil
	end

	tabletool.clear(self._queryDedupSet)

	if self._candidateResult then
		for i = #self._candidateResult, 1, -1 do
			self._candidateResult[i] = nil
		end
	end

	tabletool.clear(self._forwardVisualCullElements)
	tabletool.clear(self._forwardVisualCullElementsByRoute)
	tabletool.clear(self._forwardVisualCullStateByRoute)

	self._forwardVisualCullRouteId = nil
	self._forwardVisualCullKeepsMainExit = false

	if self._playerDaojuBigGo and not gohelper.isNil(self._playerDaojuBigGo) then
		gohelper.destroy(self._playerDaojuBigGo)

		self._playerDaojuBigGo = nil
	end
end

function RacingTrackElementPickupManager:resetForRestart()
	for _, element in ipairs(self._elements) do
		element.available = true
		element.respawnRemainingSec = 0

		self:_setElementVisible(element, true)
	end

	tabletool.clear(self._playerOverlapPrev)
	tabletool.clear(self._playerOverlapNext)
	tabletool.clear(self._aiOverlapPrev)
	tabletool.clear(self._aiOverlapNext)
	tabletool.clear(self._queryDedupSet)
	self:_buildSpatialHash()
	self:_resetStartFinishVisuals()

	self._forwardVisualCullRemaining = 0

	self:_updateForwardVisualCulling(0, true)

	if self._playerDaojuBigGo and not gohelper.isNil(self._playerDaojuBigGo) then
		gohelper.destroy(self._playerDaojuBigGo)

		self._playerDaojuBigGo = nil
	end
end

return RacingTrackElementPickupManager
