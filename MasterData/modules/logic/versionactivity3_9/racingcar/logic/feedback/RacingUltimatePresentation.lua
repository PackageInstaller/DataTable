-- chunkname: @modules/logic/versionactivity3_9/racingcar/logic/feedback/RacingUltimatePresentation.lua

module("modules.logic.versionactivity3_9.racingcar.logic.feedback.RacingUltimatePresentation", package.seeall)

local RacingUltimatePresentation = class("RacingUltimatePresentation", LuaCompBase)
local GrayBlueUltimateId = 5
local GrayBlueRestrictBuffId = 400081
local GrayBlueBubbleOnceDurationSec = 0.45
local BubbleOnceFxPath = V3a9RacingCarScenePreloader.ShuipaoOnce
local BubbleLoopFxPath = V3a9RacingCarScenePreloader.ShuipaoLoop
local StarUltimateId = 6
local StarSpeedLineTierOverride = 2
local StarTailWakeTierOverride = 3
local NarcissusUltimateId = 7
local NarcissusHideStartSec = 0.12
local NarcissusAppearStartSec = 0.45
local NarcissusPresentationEndSec = 0.65
local NarcissusPhaseInactive = 0
local NarcissusPhaseDisappearing = 1
local NarcissusPhaseHidden = 2
local NarcissusPhaseAppearing = 3
local UltimatePoseKind = {
	Acceleration = "acceleration",
	Submerge = "submerge",
	ContinuousRoll = "continuousRoll"
}
local SharedAccelerationPoseProfile = {
	attackPeakSec = 0.08,
	attackPitchDeg = -12,
	recoverSec = 0.22,
	impulseLifeSec = 0.22,
	sustainPitchDeg = -6,
	kind = UltimatePoseKind.Acceleration
}
local HedoneRollDegreesPerSecond = 540
local YamiSubmergeYOffset = -0.9
local UltimatePoseProfileById = {
	SharedAccelerationPoseProfile,
	{
		recoverSec = 0.3,
		enterSec = 0.28,
		kind = UltimatePoseKind.Submerge,
		submergeYOffset = YamiSubmergeYOffset
	},
	[4] = {
		stateName = "rot_z",
		recoverSec = 0.2,
		kind = UltimatePoseKind.ContinuousRoll,
		rollDegreesPerSecond = HedoneRollDegreesPerSecond
	},
	[6] = SharedAccelerationPoseProfile
}

function RacingUltimatePresentation:init(go)
	self._go = go
	self._playerVehicle = nil
	self._posePresentation = nil
	self._poseToken = nil
	self._activeUltimateId = nil
	self._activePoseProfile = nil
	self._poseElapsedSec = 0
	self._poseRecoveryElapsedSec = 0
	self._poseRecovering = false
	self._poseRecoveryFromPitchDeg = 0
	self._poseRecoveryFromRollDeg = 0
	self._poseRecoveryFromYOffset = 0
	self._poseRecoveryTargetRollDeg = 0
	self._currentPoseYOffset = 0
	self._currentPosePitchDeg = 0
	self._currentPoseRollDeg = 0
	self._diveVisualOverrideActive = false
	self._starUltimateFxOverrideActive = false
	self._trackedBuffIds = {}
	self._grayBlueBubbleRecords = {}
	self._grayBlueBubbleRecordCount = 0
	self._narcissusTeleportPhase = NarcissusPhaseInactive
	self._narcissusTeleportElapsedSec = 0
	self._posePayloadCache = {
		rollDeg = 0,
		yawDeg = 0,
		positionYOffset = 0,
		pitchDeg = 0
	}
end

function RacingUltimatePresentation:initialize(playerVehicle, posePresentation)
	self._playerVehicle = playerVehicle
	self._posePresentation = posePresentation

	V3a9RacingCarController.instance:registerCallback(V3a9RacingCarEvent.OnUltimateUsed, self._onUltimateUsed, self)
end

function RacingUltimatePresentation:lateUpdate(deltaTime)
	self:_updateGrayBlueBubble(deltaTime)
	self:_updateNarcissusTeleport(deltaTime)

	local trackedBuffActive = false

	trackedBuffActive = (self._starUltimateFxOverrideActive or self._poseToken) and self:_hasTrackedBuffActive()

	if self._starUltimateFxOverrideActive and not trackedBuffActive then
		self:_setStarUltimateFxOverride(false)
	end

	if not self._poseToken then
		return
	end

	if trackedBuffActive then
		self:_updateActiveUltimatePose(deltaTime)

		return
	end

	self:_updateUltimatePoseRecovery(deltaTime)
end

function RacingUltimatePresentation:resetForRestart()
	self:_clearGrayBlueBubble()
	self:_clearNarcissusTeleport()
	self:_releaseUltimatePose()
end

function RacingUltimatePresentation:onDestroy()
	V3a9RacingCarController.instance:unregisterCallback(V3a9RacingCarEvent.OnUltimateUsed, self._onUltimateUsed, self)
	self:resetForRestart()

	self._playerVehicle = nil
	self._posePresentation = nil
end

function RacingUltimatePresentation:_onUltimateUsed(ultimateId, caster, effectIds)
	if caster ~= self._playerVehicle then
		return
	end

	self:_clearGrayBlueBubble()
	self:_clearNarcissusTeleport()
	self:_releaseUltimatePose()

	self._activeUltimateId = ultimateId

	self:_collectTrackedBuffIds(effectIds)

	if ultimateId == NarcissusUltimateId then
		self:_startNarcissusTeleport()
	end

	if ultimateId == StarUltimateId and next(self._trackedBuffIds) then
		self:_setStarUltimateFxOverride(true)
	end

	if ultimateId == GrayBlueUltimateId then
		self:_startGrayBlueBubble()
	end

	local poseProfile = UltimatePoseProfileById[ultimateId]

	if not poseProfile or not next(self._trackedBuffIds) then
		self._activeUltimateId = nil

		tabletool.clear(self._trackedBuffIds)

		return
	end

	if not self._posePresentation or not self._posePresentation.requestUltimatePose then
		return
	end

	self._activePoseProfile = poseProfile
	self._poseElapsedSec = 0
	self._poseRecoveryElapsedSec = 0
	self._poseRecovering = false
	self._currentPoseYOffset = 0
	self._currentPosePitchDeg = 0
	self._currentPoseRollDeg = 0

	self:_setDiveVisualOverride(poseProfile.kind == UltimatePoseKind.Submerge)

	self._poseToken = self._posePresentation:requestUltimatePose(self:_buildCurrentUltimatePose())
end

function RacingUltimatePresentation:_startNarcissusTeleport()
	local playerVehicle = self._playerVehicle

	if not playerVehicle or not playerVehicle.playNarcissusTeleportDisappear then
		return
	end

	if not playerVehicle:playNarcissusTeleportDisappear() then
		return
	end

	self._narcissusTeleportPhase = NarcissusPhaseDisappearing
	self._narcissusTeleportElapsedSec = 0

	V3a9RacingCarController.instance:dispatchEvent(V3a9RacingCarEvent.OnNarcissusTeleportFeedback)
end

function RacingUltimatePresentation:_updateNarcissusTeleport(deltaTime)
	if self._narcissusTeleportPhase == NarcissusPhaseInactive then
		return
	end

	self._narcissusTeleportElapsedSec = self._narcissusTeleportElapsedSec + math.max(0, deltaTime or 0)

	if self._narcissusTeleportPhase == NarcissusPhaseDisappearing and self._narcissusTeleportElapsedSec >= NarcissusHideStartSec then
		self._narcissusTeleportPhase = NarcissusPhaseHidden

		self._playerVehicle:setNarcissusTeleportHidden()
	end

	if self._narcissusTeleportPhase == NarcissusPhaseHidden and self._narcissusTeleportElapsedSec >= NarcissusAppearStartSec then
		self._narcissusTeleportPhase = NarcissusPhaseAppearing

		self._playerVehicle:playNarcissusTeleportAppear()
	end

	if self._narcissusTeleportPhase == NarcissusPhaseAppearing and self._narcissusTeleportElapsedSec >= NarcissusPresentationEndSec then
		self:_clearNarcissusTeleport()
	end
end

function RacingUltimatePresentation:_clearNarcissusTeleport()
	if self._narcissusTeleportPhase == NarcissusPhaseInactive then
		return
	end

	self._narcissusTeleportPhase = NarcissusPhaseInactive
	self._narcissusTeleportElapsedSec = 0

	if self._playerVehicle and self._playerVehicle.resetNarcissusTeleportPresentation then
		self._playerVehicle:resetNarcissusTeleportPresentation()
	end
end

function RacingUltimatePresentation:_setStarUltimateFxOverride(active)
	if self._starUltimateFxOverrideActive == active then
		return
	end

	self._starUltimateFxOverrideActive = active

	if not self._playerVehicle then
		return
	end

	if active and self._playerVehicle.setUltimateVehicleFxTierOverride then
		self._playerVehicle:setUltimateVehicleFxTierOverride(StarSpeedLineTierOverride, StarTailWakeTierOverride)
	elseif not active and self._playerVehicle.clearUltimateVehicleFxTierOverride then
		self._playerVehicle:clearUltimateVehicleFxTierOverride()
	end
end

function RacingUltimatePresentation:_buildCurrentUltimatePose()
	local pose = self._posePayloadCache

	pose.ultimateId = self._activeUltimateId
	pose.stateName = self._activePoseProfile and self._activePoseProfile.stateName
	pose.positionYOffset = self._currentPoseYOffset or 0
	pose.pitchDeg = self._currentPosePitchDeg or 0
	pose.yawDeg = 0
	pose.rollDeg = self._currentPoseRollDeg or 0

	return pose
end

function RacingUltimatePresentation:_updateActiveUltimatePose(deltaTime)
	local profile = self._activePoseProfile

	if not profile then
		self:_releaseUltimatePose()

		return
	end

	local safeDeltaTime = math.max(0, deltaTime or 0)

	self._poseElapsedSec = (self._poseElapsedSec or 0) + safeDeltaTime

	if profile.kind == UltimatePoseKind.Acceleration then
		self._currentPoseYOffset = 0
		self._currentPosePitchDeg = self:_resolveAccelerationPitchDeg(profile, self._poseElapsedSec)
		self._currentPoseRollDeg = 0
	elseif profile.kind == UltimatePoseKind.Submerge then
		local enterSec = math.max(0.001, (not profile.enterSec or nil) and 0.28)

		self._currentPoseYOffset = Mathf.Lerp(0, profile.submergeYOffset or 0, self:_smoothStep01(self._poseElapsedSec / enterSec))
		self._currentPosePitchDeg = 0
		self._currentPoseRollDeg = 0

		self:_setDiveVisualOverride(true)
	elseif profile.kind == UltimatePoseKind.ContinuousRoll then
		self._currentPoseYOffset = 0
		self._currentPosePitchDeg = 0
		self._currentPoseRollDeg = (self._currentPoseRollDeg or 0) + profile.rollDegreesPerSecond * safeDeltaTime
	end

	self:_pushCurrentUltimatePose()
end

function RacingUltimatePresentation:_resolveAccelerationPitchDeg(profile, elapsedSec)
	local peakSec = math.max(0.001, (not profile.attackPeakSec or nil) and 0.08)
	local impulseLifeSec = math.max(peakSec, (not profile.impulseLifeSec or nil) and peakSec)

	if elapsedSec <= peakSec then
		return Mathf.Lerp(0, profile.attackPitchDeg or 0, self:_smoothStep01(elapsedSec / peakSec))
	end

	if elapsedSec < impulseLifeSec then
		local duration = math.max(0.001, impulseLifeSec - peakSec)
		local progress = (elapsedSec - peakSec) / duration

		return Mathf.Lerp(profile.attackPitchDeg or 0, profile.sustainPitchDeg or 0, self:_smoothStep01(progress))
	end

	return profile.sustainPitchDeg or 0
end

function RacingUltimatePresentation:_updateUltimatePoseRecovery(deltaTime)
	local profile = self._activePoseProfile

	if not profile then
		self:_releaseUltimatePose()

		return
	end

	if not self._poseRecovering then
		self._poseRecovering = true
		self._poseRecoveryElapsedSec = 0
		self._poseRecoveryFromYOffset = self._currentPoseYOffset or 0
		self._poseRecoveryFromPitchDeg = self._currentPosePitchDeg or 0
		self._poseRecoveryFromRollDeg = self._currentPoseRollDeg or 0
		self._poseRecoveryTargetRollDeg = self:_resolveForwardRecoverRollDeg(self._poseRecoveryFromRollDeg)
	end

	self._poseRecoveryElapsedSec = self._poseRecoveryElapsedSec + math.max(0, deltaTime or 0)

	local duration = math.max(0.001, profile.recoverSec or 0.2)
	local progress = self:_smoothStep01(self._poseRecoveryElapsedSec / duration)

	self._currentPoseYOffset = Mathf.Lerp(self._poseRecoveryFromYOffset, 0, progress)
	self._currentPosePitchDeg = Mathf.Lerp(self._poseRecoveryFromPitchDeg, 0, progress)
	self._currentPoseRollDeg = Mathf.Lerp(self._poseRecoveryFromRollDeg, self._poseRecoveryTargetRollDeg, progress)

	if profile.kind == UltimatePoseKind.Submerge then
		self:_setDiveVisualOverride(true)
	end

	self:_pushCurrentUltimatePose()

	if progress >= 1 then
		self:_releaseUltimatePose()
	end
end

function RacingUltimatePresentation:_resolveForwardRecoverRollDeg(rollDeg)
	local current = math.max(0, rollDeg or 0)

	if current <= 0.01 then
		return 0
	end

	return math.ceil(current / 360) * 360
end

function RacingUltimatePresentation:_pushCurrentUltimatePose()
	if not self._poseToken or not self._posePresentation or not self._posePresentation.updateUltimatePose then
		return false
	end

	return self._posePresentation:updateUltimatePose(self._poseToken, self:_buildCurrentUltimatePose())
end

function RacingUltimatePresentation:_smoothStep01(value)
	local t = Mathf.Clamp01(value or 0)

	return t * t * (3 - 2 * t)
end

function RacingUltimatePresentation:_setDiveVisualOverride(active)
	if self._playerVehicle then
		if gohelper.isNil(self._playerVehicle) then
			self._diveVisualOverrideActive = not not active

			return
		end

		if active then
			self._diveVisualOverrideActive = true

			gohelper.setActive(self._playerVehicle, true)

			return
		end

		if not self._diveVisualOverrideActive then
			return
		end

		self._diveVisualOverrideActive = false

		local hidden = self._playerVehicle.getIsHidden and self._playerVehicle:getIsHidden() or self._playerVehicle._isHidden

		gohelper.setActive(self._playerVehicle, not hidden)
	end
end

function RacingUltimatePresentation:_collectTrackedBuffIds(effectIds)
	tabletool.clear(self._trackedBuffIds)

	if not effectIds then
		return
	end

	for _, effectId in ipairs(effectIds) do
		local effectMo = V3a9RacingCarConfig.instance:getRacingEffectConfig(effectId)
		local paramData = effectMo and effectMo.paramData
		local buffId = paramData and paramData.buffId

		if buffId and buffId > 0 and paramData.targetType == RacingCarPropEnum.TargetType.Self then
			self._trackedBuffIds[buffId] = true
		end
	end
end

function RacingUltimatePresentation:_startGrayBlueBubble()
	local skillManager = RacingCarSkillManager.instance
	local racers = skillManager and skillManager._allRacers

	if not racers then
		return
	end

	local records = self._grayBlueBubbleRecords
	local recordCount = 0

	for _, racer in pairs(racers) do
		if self:_hasBuff(racer, GrayBlueRestrictBuffId) then
			recordCount = recordCount + 1

			local record = records[recordCount]

			if not record then
				record = {}
				records[recordCount] = record
			end

			record.target = racer
			record.onceGo = nil
			record.loopGo = nil
			record.onceRemainingSec = GrayBlueBubbleOnceDurationSec

			self:_ensureGrayBlueBubbleFx(record, "onceGo", racer, BubbleOnceFxPath, "racing_gray_blue_bubble_once")
		end
	end

	self._grayBlueBubbleRecordCount = recordCount
end

function RacingUltimatePresentation:_updateGrayBlueBubble(deltaTime)
	local recordCount = self._grayBlueBubbleRecordCount

	if recordCount <= 0 then
		return
	end

	local records = self._grayBlueBubbleRecords
	local index = 1

	while index <= recordCount do
		local record = records[index]

		if not self:_hasBuff(record.target, GrayBlueRestrictBuffId) then
			self:_clearGrayBlueBubbleRecord(record)

			if index ~= recordCount then
				records[index] = records[recordCount]
				records[recordCount] = record
			end

			recordCount = recordCount - 1
		else
			if record.onceRemainingSec > 0 then
				record.onceRemainingSec = math.max(0, record.onceRemainingSec - deltaTime)

				if record.onceRemainingSec <= 0 then
					self:_destroyGrayBlueBubbleRecordFx(record, "onceGo")
					self:_ensureGrayBlueBubbleFx(record, "loopGo", record.target, BubbleLoopFxPath, "racing_gray_blue_bubble_loop")
				end
			else
				self:_ensureGrayBlueBubbleFx(record, "loopGo", record.target, BubbleLoopFxPath, "racing_gray_blue_bubble_loop")
			end

			index = index + 1
		end
	end

	self._grayBlueBubbleRecordCount = recordCount
end

function RacingUltimatePresentation:_hasBuff(racer, buffId)
	local buffManager = racer and racer.buffManager
	local activeBuffs = buffManager and buffManager:getAllBuffs()

	if not activeBuffs then
		return false
	end

	for _, buff in ipairs(activeBuffs) do
		if buff and buff.buffId == buffId then
			return true
		end
	end

	return false
end

function RacingUltimatePresentation:_ensureGrayBlueBubbleFx(record, fieldName, target, resourcePath, instanceName)
	if not gohelper.isNil(record[fieldName]) then
		return record[fieldName]
	end

	local var_23_0 = GameSceneMgr

	if GameSceneMgr then
		var_23_0 = GameSceneMgr.instance

		if GameSceneMgr.instance then
			local scene = GameSceneMgr.instance:getCurScene()
			local preloader = scene and scene.preloader

			if preloader then
				::label_23_0::

				local var_23_1 = preloader.getResource

				if preloader.getResource then
					local prefab = preloader:getResource(resourcePath)
					local targetGo = target and target.getRacerVisualAttachGo and target:getRacerVisualAttachGo() or target and target._go

					if gohelper.isNil(prefab) or gohelper.isNil(targetGo) then
						return nil
					end

					local fxGo = gohelper.clone(prefab, targetGo, instanceName)

					if not gohelper.isNil(fxGo) then
						local fxTransform = fxGo.transform

						transformhelper.setLocalPos(fxTransform, 0, 0, 0)
						transformhelper.setLocalRotation(fxTransform, 0, 0, 0)
						transformhelper.setLocalScale(fxTransform, 1, 1, 1)
					end

					record[fieldName] = fxGo

					return fxGo
				end
			end
		end
	end
end

function RacingUltimatePresentation:_destroyGrayBlueBubbleRecordFx(record, fieldName)
	local fxGo = record and record[fieldName]

	if not gohelper.isNil(fxGo) then
		gohelper.destroy(fxGo)
	end

	if record then
		record[fieldName] = nil
	end
end

function RacingUltimatePresentation:_clearGrayBlueBubbleRecord(record)
	self:_destroyGrayBlueBubbleRecordFx(record, "onceGo")
	self:_destroyGrayBlueBubbleRecordFx(record, "loopGo")

	record.target = nil
	record.onceRemainingSec = 0
end

function RacingUltimatePresentation:_clearGrayBlueBubble()
	local records = self._grayBlueBubbleRecords

	for index = 1, self._grayBlueBubbleRecordCount do
		self:_clearGrayBlueBubbleRecord(records[index])
	end

	self._grayBlueBubbleRecordCount = 0
end

function RacingUltimatePresentation:_hasTrackedBuffActive()
	if not self._playerVehicle or not self._playerVehicle.buffManager then
		return false
	end

	local buffs = self._playerVehicle.buffManager:getAllBuffs()

	if not buffs then
		return false
	end

	for _, buff in ipairs(buffs) do
		if self._trackedBuffIds[buff.buffId] then
			return true
		end
	end

	return false
end

function RacingUltimatePresentation:_releaseUltimatePose()
	self:_setDiveVisualOverride(false)
	self:_setStarUltimateFxOverride(false)

	if self._poseToken and self._posePresentation and self._posePresentation.releaseUltimatePose then
		self._posePresentation:releaseUltimatePose(self._poseToken)
	end

	self._poseToken = nil
	self._activeUltimateId = nil
	self._activePoseProfile = nil
	self._poseElapsedSec = 0
	self._poseRecoveryElapsedSec = 0
	self._poseRecovering = false
	self._poseRecoveryFromPitchDeg = 0
	self._poseRecoveryFromRollDeg = 0
	self._poseRecoveryFromYOffset = 0
	self._poseRecoveryTargetRollDeg = 0
	self._currentPoseYOffset = 0
	self._currentPosePitchDeg = 0
	self._currentPoseRollDeg = 0

	tabletool.clear(self._trackedBuffIds)
end

return RacingUltimatePresentation
