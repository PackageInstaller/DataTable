-- chunkname: @modules/logic/versionactivity3_9/racingcar/logic/feedback/RacingBurstFeedback.lua

module("modules.logic.versionactivity3_9.racingcar.logic.feedback.RacingBurstFeedback", package.seeall)

local RacingBurstFeedback = class("RacingBurstFeedback", LuaCompBase)
local BurstBuffIds = {
	[103031] = true,
	[200012] = true,
	[103021] = true,
	[100021] = true,
	[103011] = true,
	[100022] = true,
	[100013] = true
}
local BurstCameraIds = {
	[103011] = true,
	[103031] = true,
	[103021] = true
}
local LegacyPerfectDodgeFeedbackBuffIds = {
	[100021] = true,
	[100022] = true
}
local PerfectDodgeRollDeg = 10
local PerfectDodgeRollAttackSec = 0.05
local PerfectDodgeRollRecoverSec = 0.18
local GhostCount = 1
local GhostLifeSec = 0.85
local GhostInitialAlpha = 0.72
local GhostAlphaStep = 0.06
local GhostFadeAlphaScale = 0.68
local GhostAlphaUpdateInterval = 0.03333333333333333
local GhostHistoryFrameCount = 4
local GhostHistoryFrameOffsets = {
	4
}
local VisualPivotYOffset = 0
local LeanProfile = {
	Ordinary = {
		sustainPitchDeg = -3.5,
		priority = 1,
		recoverSmoothTime = 0.22,
		impulseLifeSec = 0.18,
		impulsePitchDeg = -8
	},
	Ultimate = {
		sustainPitchDeg = -6,
		priority = 2,
		recoverSmoothTime = 0.3,
		impulseLifeSec = 0.22,
		impulsePitchDeg = -12
	}
}
local LeanProfileByBuffId = {
	[100011] = LeanProfile.Ordinary,
	[100111] = LeanProfile.Ordinary,
	[200011] = LeanProfile.Ultimate,
	[200013] = LeanProfile.Ultimate
}
local LeanAttackSmoothTime = 0.06
local DefaultLeanRecoverSmoothTime = 0.22
local HitStopFrameCount = 4
local HitStopTimeScale = 0.03
local HitStopCooldownFrameCount = 12
local BurstFeedbackCooldownFrameCount = 6
local SpeedFxLifeSec = 0.28
local TwoPi = math.pi * 2
local RadialBlurBaseLevel = 1
local SpeedFxTierConfigs = {
	{
		blurSamplePercent = 0.16,
		radialBlurStrength = 0
	},
	{
		blurSamplePercent = 0.24,
		radialBlurStrength = 0
	},
	{
		blurSamplePercent = 0.32,
		radialBlurStrength = 0
	}
}
local SpeedLineConstId = 1004
local TailWakeConstId = 1005
local DefaultSpeedLineThresholds = {
	95,
	125
}
local DefaultTailWakeThresholds = {
	95,
	125
}
local MinSpeedForVehicleFx = 0.1
local SpeedLineFxPath = V3a9RacingCarScenePreloader.Suduxian
local ItemInvincibleFxPath = V3a9RacingCarScenePreloader.HudunLoop
local CoinFlyFxPath = V3a9RacingCarScenePreloader.Coin
local CoinFlyDurationSec = 0.32
local CoinFlyArcHeight = 1.4
local CoinFlyTargetYOffset = 1.2
local MaxCoinFlyVisualCount = 24
local SpeedLineStateNames = {
	[1] = "v3a9_jingsu_suduxian_1",
	[2] = "v3a9_jingsu_suduxian_2"
}
local TailWakeStateNames = {
	"v3a9_jingsu_tuowei_1",
	"v3a9_jingsu_tuowei_2",
	"v3a9_jingsu_tuowei_3"
}
local AiTailWakeTrailChildPaths = {
	"1/tw2_langhua",
	"2/tw2_langhua_1",
	"2/tw2_langhua_2",
	"3/tw2_langhua_1",
	"3/tw2_langhua_3",
	"3/tw2_langhua_4"
}
local ItemInvincibleBuffId = 400033
local SpeedImpulseThreshold = 0.12
local SpeedImpulseCooldownSec = 1
local SpeedImpulseLifeSec = 0.24
local SpeedImpulseAttackSec = 0.04
local SpeedImpulseTierConfigs = {
	{
		shakeFrequency = 4,
		fov = 0.3,
		shakeStrength = 0.07
	},
	{
		shakeFrequency = 4,
		fov = 0.5,
		shakeStrength = 0.12
	},
	{
		shakeFrequency = 4,
		fov = 0.8,
		shakeStrength = 0.2
	}
}

function RacingBurstFeedback:init(go)
	self._go = go
	self._transform = go.transform
	self._playerVehicle = nil
	self._camera = nil
	self._cameraTransform = nil
	self._visualPivotGo = nil
	self._visualPivotTransform = nil
	self._leanPitch = 0
	self._leanPitchVelocity = 0
	self._leanImpulseLife = 0
	self._leanImpulsePitchDeg = 0
	self._leanImpulsePriority = 0
	self._activeLeanProfile = nil
	self._leanRecoverSmoothTime = DefaultLeanRecoverSmoothTime
	self._perfectDodgeRollElapsedSec = 0
	self._perfectDodgeRollDirection = 0
	self._perfectDodgeFeedbackBuffIds = {}
	self._burstBuffActive = false
	self._knownBuffMap = {}
	self._knownBuffMapSwap = {}
	self._ghosts = {}
	self._ghostPoseHistory = {}
	self._ghostPoseHistoryCursor = 0
	self._hitStopFrames = 0
	self._hitStopCooldownFrames = 0
	self._burstFeedbackCooldownFrames = 0
	self._hitStopActive = false
	self._savedTimeScale = nil
	self._speedFxLife = 0
	self._speedFxTier = 0
	self._speedFxRoot = nil
	self._speedFxCanvasGroup = nil
	self._radialBlurOwned = false
	self._savedRadialBlurLevel = nil
	self._savedBlurSamplePercent = nil
	self._savedIsLocalRadialBlur = nil
	self._savedIsDynamicBlur = nil
	self._activeRadialBlurTier = 0
	self._lastSpeedMultiplier = 1
	self._lastSpeedMultiplierDebuffActive = false
	self._speedImpulseCooldownSec = 0
	self._speedImpulseLife = 0
	self._speedImpulseDuration = 0
	self._speedImpulseTier = 0
	self._speedImpulseSeed = 0
	self._speedLineFxGo = nil
	self._speedLineFxTier = 0
	self._tailWakeFxGo = nil
	self._tailWakeFxTier = 0
	self._aiTailWakeTrailFxGo = nil
	self._aiTailWakeTrailEntries = nil
	self._tailWakeOnly = false
	self._itemInvincibleShieldGo = nil
	self._coinFlyVisuals = {}
	self._coinFlyPool = {}
	self._appliedLeanPitch = nil
	self._appliedLeanRoll = nil
	self._speedLineFxVisible = false
	self._tailWakeFxVisible = false
end

function RacingBurstFeedback:initialize(playerVehicle)
	self._playerVehicle = playerVehicle
	self._tailWakeOnly = false

	self:_cachePerfectDodgeFeedbackBuffIds()

	local camera = CameraMgr.instance:getMainCamera()

	self._camera = camera

	if camera then
		self._cameraTransform = camera.transform or nil
	end

	self:_ensureVisualPivot()
	V3a9RacingCarController.instance:registerCallback(V3a9RacingCarEvent.OnCoinAbsorbVisual, self._onCoinAbsorbVisual, self)
	V3a9RacingCarController.instance:registerCallback(V3a9RacingCarEvent.OnPerfectDodgeFeedback, self._onPerfectDodgeFeedback, self)
	V3a9RacingCarController.instance:registerCallback(V3a9RacingCarEvent.OnNarcissusTeleportFeedback, self._onNarcissusTeleportFeedback, self)
	self:_cacheSpeedThresholds()
end

function RacingBurstFeedback:_onNarcissusTeleportFeedback()
	if self._hitStopCooldownFrames <= 0 then
		self._hitStopFrames = math.max(self._hitStopFrames, HitStopFrameCount)
		self._hitStopCooldownFrames = HitStopCooldownFrameCount
	end

	self._burstFeedbackCooldownFrames = BurstFeedbackCooldownFrameCount
	self._speedFxLife = SpeedFxLifeSec

	self:_ensureSpeedFx()

	for index = 1, GhostCount do
		self:_spawnGhost(index)
	end
end

function RacingBurstFeedback:_cachePerfectDodgeFeedbackBuffIds()
	local buffIds = self._perfectDodgeFeedbackBuffIds

	tabletool.clear(buffIds)

	for buffId in pairs(LegacyPerfectDodgeFeedbackBuffIds) do
		buffIds[buffId] = true
	end

	local playerVehicle = self._playerVehicle
	local effectIds = playerVehicle and playerVehicle._perfectDodgeEffectList

	if V3a9RacingCarConfig then
		local config = V3a9RacingCarConfig.instance

		if not effectIds or not config then
			return
		end

		for _, effectId in ipairs(effectIds) do
			local effectMo = config:getRacingEffectConfig(effectId)

			if effectMo then
				::label_4_0::

				local var_4_1 = effectMo.paramData

				if effectMo.paramData then
					local buffId = effectMo.paramData.buffId

					if buffId and buffId > 0 then
						buffIds[buffId] = true
					end
				end
			end
		end
	end
end

function RacingBurstFeedback:_isPerfectDodgeFeedbackBuff(buff)
	local var_5_0

	if buff then
		::label_5_0::

		var_5_0 = self._perfectDodgeFeedbackBuffIds and self._perfectDodgeFeedbackBuffIds[buff.buffId] == true
	end

	return var_5_0
end

function RacingBurstFeedback:_onPerfectDodgeFeedback(visualDirection)
	local direction = tonumber(visualDirection) or 0

	if math.abs(direction) <= 0.001 then
		return
	end

	direction = Mathf.Sign(direction)

	AudioMgr.instance:trigger(V3a9RacingCarEnum.AudioId.PlayBulaochuanColor)

	if self._hitStopCooldownFrames <= 0 then
		self._hitStopFrames = math.max(self._hitStopFrames, HitStopFrameCount)
		self._hitStopCooldownFrames = HitStopCooldownFrameCount
	end

	self._perfectDodgeRollDirection = direction
	self._perfectDodgeRollElapsedSec = 0.0001
	self._burstFeedbackCooldownFrames = BurstFeedbackCooldownFrameCount
	self._speedFxLife = SpeedFxLifeSec

	self:_ensureSpeedFx()

	for index = 1, GhostCount do
		self:_spawnGhost(index)
	end
end

function RacingBurstFeedback:initializeTailWakeOnly(vehicle)
	self._playerVehicle = vehicle
	self._tailWakeOnly = true
	self._camera = nil
	self._cameraTransform = nil

	self:_cacheSpeedThresholds()
end

function RacingBurstFeedback:lateUpdate(deltaTime)
	if self._tailWakeOnly then
		local speed = self:_resolveForwardSpeed()

		self:_updateTailWakeAsset(self:_resolveTailWakeTier(speed))

		return
	end

	if self:_suppressBurstFeedbackForSpecialAirWaterDrop() then
		self:_updateVehicleSpeedAssets()

		return
	end

	self:_detectBurstBuffs()
	self:_updateVisualLean(deltaTime)
	self:_updateHitStop()
	self:_updateHitStopCooldown()
	self:_updateBurstFeedbackCooldown()
	self:_applyCameraShake()
	self:_updateSpeedImpulse(deltaTime)
	self:_updateGhosts(deltaTime)
	self:_updateSpeedFx(deltaTime)
	self:_updateVehicleSpeedAssets()
	self:_updateItemInvincibleShield()
	self:_updateCoinFlyVisuals(deltaTime)
	self:_recordGhostPoseHistory()
end

function RacingBurstFeedback:_suppressBurstFeedbackForSpecialAirWaterDrop()
	local playerVehicle = self._playerVehicle

	if not playerVehicle or not playerVehicle.isAirWaterDropping or not playerVehicle:isAirWaterDropping() then
		return false
	end

	tabletool.clear(self._knownBuffMap)
	tabletool.clear(self._knownBuffMapSwap)

	self._burstBuffActive = false
	self._burstFeedbackCooldownFrames = 0
	self._speedFxLife = 0
	self._speedImpulseLife = 0

	self:_clearGhosts()
	self:_clearSpeedFx()
	self:_clearItemInvincibleShield()
	self:_clearCoinFlyVisuals()
	self:_restoreRadialBlur()

	return true
end

function RacingBurstFeedback:resetForRestart()
	if self._tailWakeOnly then
		self:_clearVehicleSpeedAssets()

		return
	end

	self:_restoreTimeScale()
	self:_resetVisualLean()
	self:_clearGhosts()
	self:_clearSpeedFx()
	tabletool.clear(self._knownBuffMap)
	tabletool.clear(self._knownBuffMapSwap)

	self._hitStopFrames = 0
	self._hitStopCooldownFrames = 0
	self._burstFeedbackCooldownFrames = 0
	self._lastSpeedMultiplier = 1
	self._lastSpeedMultiplierDebuffActive = false
	self._speedImpulseCooldownSec = 0
	self._speedImpulseLife = 0
	self._speedImpulseDuration = 0
	self._speedImpulseTier = 0

	self:_clearVehicleSpeedAssets()
	self:_clearItemInvincibleShield()
	self:_clearCoinFlyVisuals()
	self:_restoreRadialBlur()
end

function RacingBurstFeedback:onDestroy()
	if self._tailWakeOnly then
		self:_clearVehicleSpeedAssets()

		self._playerVehicle = nil
		self._go = nil
		self._transform = nil

		return
	end

	if V3a9RacingCarController and V3a9RacingCarController.instance then
		V3a9RacingCarController.instance:unregisterCallback(V3a9RacingCarEvent.OnCoinAbsorbVisual, self._onCoinAbsorbVisual, self)
		V3a9RacingCarController.instance:unregisterCallback(V3a9RacingCarEvent.OnPerfectDodgeFeedback, self._onPerfectDodgeFeedback, self)
		V3a9RacingCarController.instance:unregisterCallback(V3a9RacingCarEvent.OnNarcissusTeleportFeedback, self._onNarcissusTeleportFeedback, self)
	end

	self:_restoreTimeScale()
	self:_resetVisualLean()
	self:_destroyGhostPool()
	self:_clearSpeedFx()
	tabletool.clear(self._knownBuffMap)
	tabletool.clear(self._knownBuffMapSwap)

	self._hitStopFrames = 0
	self._hitStopCooldownFrames = 0
	self._burstFeedbackCooldownFrames = 0
	self._lastSpeedMultiplier = 1
	self._lastSpeedMultiplierDebuffActive = false
	self._speedImpulseCooldownSec = 0
	self._speedImpulseLife = 0
	self._speedImpulseDuration = 0
	self._speedImpulseTier = 0

	self:_clearVehicleSpeedAssets()
	self:_clearItemInvincibleShield()
	self:_clearCoinFlyVisuals(true)
	self:_restoreRadialBlur()

	self._go = nil
	self._transform = nil
end

function RacingBurstFeedback:_detectBurstBuffs()
	if self._playerVehicle then
		local buffManager = self._playerVehicle.buffManager

		if not buffManager then
			tabletool.clear(self._knownBuffMap)

			self._burstBuffActive = false
			self._activeLeanProfile = nil

			return
		end

		local activeBuffs = buffManager:getAllBuffs()
		local currentBuffMap = self._knownBuffMapSwap

		tabletool.clear(currentBuffMap)

		local burstBuffActive = false
		local activeLeanProfile

		for _, buff in ipairs(activeBuffs) do
			local instanceId = buff.id

			currentBuffMap[instanceId] = true

			local leanProfile = LeanProfileByBuffId[buff.buffId]

			if leanProfile and (not activeLeanProfile or leanProfile.priority > activeLeanProfile.priority) then
				activeLeanProfile = leanProfile
			end

			if self:_isBurstBuff(buff) then
				burstBuffActive = true
			end

			if not self._knownBuffMap[instanceId] then
				if leanProfile then
					self:_triggerLeanFeedback(leanProfile)
				end

				if self:_isBurstBuff(buff) then
					self:_triggerBurstFeedback(buff)
				end
			end
		end

		self._burstBuffActive = burstBuffActive
		self._activeLeanProfile = activeLeanProfile

		if activeLeanProfile then
			self._leanRecoverSmoothTime = activeLeanProfile.recoverSmoothTime
		end

		self._knownBuffMapSwap = self._knownBuffMap
		self._knownBuffMap = currentBuffMap
	end
end

function RacingBurstFeedback:_triggerLeanFeedback(profile)
	if not profile then
		return
	end

	if self._activeLeanProfile and self._activeLeanProfile.priority > profile.priority then
		return
	end

	if self._leanImpulseLife > 0 then
		if (self._leanImpulsePriority or 0) > profile.priority then
			return
		end
	end

	self._leanImpulsePitchDeg = profile.impulsePitchDeg
	self._leanImpulsePriority = profile.priority
	self._leanImpulseLife = profile.impulseLifeSec
	self._leanRecoverSmoothTime = profile.recoverSmoothTime
end

function RacingBurstFeedback:_isBurstBuff(buff)
	if not buff then
		return false
	end

	if BurstBuffIds[buff.buffId] or self:_isPerfectDodgeFeedbackBuff(buff) then
		return true
	end

	if buff.buffConfig then
		local cameraId = buff.buffConfig.camera

		return BurstCameraIds[cameraId] == true
	end
end

function RacingBurstFeedback:_triggerBurstFeedback(buff)
	if self:_shouldUseHitStop(buff) and self._hitStopCooldownFrames <= 0 then
		self._hitStopFrames = math.max(self._hitStopFrames, HitStopFrameCount)
		self._hitStopCooldownFrames = HitStopCooldownFrameCount

		local direction = self:_resolveLaneSwitchDirection()

		if math.abs(direction) > 0.001 then
			self._perfectDodgeRollDirection = Mathf.Sign(direction)
			self._perfectDodgeRollElapsedSec = 0.0001
		end
	end

	if self._burstFeedbackCooldownFrames > 0 then
		return
	end

	self._burstFeedbackCooldownFrames = BurstFeedbackCooldownFrameCount
	self._speedFxLife = SpeedFxLifeSec

	self:_ensureSpeedFx()

	if self:_shouldSpawnGhost(buff) then
		for index = 1, GhostCount do
			self:_spawnGhost(index)
		end
	end
end

function RacingBurstFeedback:_ensureVisualPivot()
	if not gohelper.isNil(self._visualPivotGo) or gohelper.isNil(self._go) then
		return
	end

	local rootTransform = self._transform
	local children = {}

	for i = 0, rootTransform.childCount - 1 do
		table.insert(children, rootTransform:GetChild(i))
	end

	if #children == 0 then
		return
	end

	self._visualPivotGo = UnityEngine.GameObject.New("racing_visual_pivot")
	self._visualPivotTransform = self._visualPivotGo.transform

	self._visualPivotTransform:SetParent(rootTransform, false)
	transformhelper.setLocalPos(self._visualPivotTransform, 0, VisualPivotYOffset, 0)
	transformhelper.setLocalRotation(self._visualPivotTransform, 0, 0, 0)
	transformhelper.setLocalScale(self._visualPivotTransform, 1, 1, 1)

	for _, child in ipairs(children) do
		if not gohelper.isNil(child) then
			child:SetParent(self._visualPivotTransform, false)
		end
	end
end

function RacingBurstFeedback:_shouldUseHitStop(buff)
	if not self:_isPerfectDodgeFeedbackBuff(buff) then
		return false
	end

	return math.abs(self:_resolveLaneSwitchDirection()) > 0.001
end

function RacingBurstFeedback:_shouldSpawnGhost(buff)
	if not self:_isPerfectDodgeFeedbackBuff(buff) then
		return false
	end

	return math.abs(self:_resolveLaneSwitchDirection()) > 0.001
end

function RacingBurstFeedback:_updateVisualLean(deltaTime)
	self:_ensureVisualPivot()

	if gohelper.isNil(self._visualPivotTransform) then
		return
	end

	if self._leanImpulseLife > 0 then
		self._leanImpulseLife = math.max(0, self._leanImpulseLife - deltaTime)

		if self._leanImpulseLife <= 0 then
			self._leanImpulsePriority = 0
		end
	end

	local targetPitch = 0

	if self._leanImpulseLife > 0 then
		targetPitch = self._leanImpulsePitchDeg or 0
	elseif self._activeLeanProfile then
		targetPitch = self._activeLeanProfile.sustainPitchDeg
	end

	if targetPitch ~= 0 then
		local var_19_0 = LeanAttackSmoothTime

		if not LeanAttackSmoothTime then
			var_19_0 = self._leanRecoverSmoothTime

			if not self._leanRecoverSmoothTime then
				local smoothTime = DefaultLeanRecoverSmoothTime
				local newPitch, newVelocity = Mathf.SmoothDamp(self._leanPitch, targetPitch, self._leanPitchVelocity, smoothTime, math.huge, deltaTime)

				if targetPitch == 0 and math.abs(newPitch) < 0.001 then
					newPitch = 0
					newVelocity = 0
				end

				self._leanPitch = newPitch
				self._leanPitchVelocity = newVelocity

				local roll = self:_updatePerfectDodgeRoll(deltaTime)

				if newPitch ~= self._appliedLeanPitch or roll ~= self._appliedLeanRoll then
					self._appliedLeanPitch = newPitch
					self._appliedLeanRoll = roll

					transformhelper.setLocalRotation(self._visualPivotTransform, newPitch, 0, roll)
				end
			end
		end
	end
end

function RacingBurstFeedback:_updatePerfectDodgeRoll(deltaTime)
	if (self._perfectDodgeRollElapsedSec or 0) > 0 then
		if math.abs(self._perfectDodgeRollDirection or 0) <= 0.001 then
			return 0
		end
	end

	self._perfectDodgeRollElapsedSec = self._perfectDodgeRollElapsedSec + deltaTime

	local elapsed = self._perfectDodgeRollElapsedSec
	local weight = 0

	if elapsed <= PerfectDodgeRollAttackSec then
		local t = Mathf.Clamp01(elapsed / PerfectDodgeRollAttackSec)

		weight = t * t * (3 - 2 * t)
	else
		local recoverElapsed = elapsed - PerfectDodgeRollAttackSec
		local t = Mathf.Clamp01(recoverElapsed / PerfectDodgeRollRecoverSec)

		weight = 1 - t * t * (3 - 2 * t)
	end

	if elapsed >= PerfectDodgeRollAttackSec + PerfectDodgeRollRecoverSec then
		self._perfectDodgeRollElapsedSec = 0
		self._perfectDodgeRollDirection = 0

		return 0
	end

	return -self._perfectDodgeRollDirection * PerfectDodgeRollDeg * weight
end

function RacingBurstFeedback:_resetVisualLean()
	self._leanImpulseLife = 0
	self._burstBuffActive = false
	self._leanPitch = 0
	self._leanPitchVelocity = 0
	self._leanImpulsePitchDeg = 0
	self._leanImpulsePriority = 0
	self._activeLeanProfile = nil
	self._leanRecoverSmoothTime = DefaultLeanRecoverSmoothTime
	self._perfectDodgeRollElapsedSec = 0
	self._perfectDodgeRollDirection = 0
	self._appliedLeanPitch = nil
	self._appliedLeanRoll = nil

	if not gohelper.isNil(self._visualPivotTransform) then
		transformhelper.setLocalRotation(self._visualPivotTransform, 0, 0, 0)
		transformhelper.setLocalPos(self._visualPivotTransform, 0, VisualPivotYOffset, 0)
	end
end

function RacingBurstFeedback:_updateHitStop()
	if self._hitStopFrames <= 0 then
		self:_restoreTimeScale()

		return
	end

	if not self._hitStopActive then
		self._savedTimeScale = Time.timeScale
		Time.timeScale = HitStopTimeScale
		self._hitStopActive = true
	end

	self._hitStopFrames = self._hitStopFrames - 1

	if self._hitStopFrames <= 0 then
		self:_restoreTimeScale()
	end
end

function RacingBurstFeedback:_applyCameraShake()
	local shakeStrength, shakeFrequency = self:_collectActiveCameraShake()

	if shakeStrength <= 0 or shakeFrequency <= 0 then
		return
	end

	if gohelper.isNil(self._cameraTransform) then
		local camera = CameraMgr.instance:getMainCamera()

		if camera then
			self._cameraTransform = camera.transform or nil
		end
	end

	if gohelper.isNil(self._cameraTransform) then
		return
	end

	local phase = Time.time * shakeFrequency * TwoPi
	local pitch = math.sin(phase) * shakeStrength
	local yaw = math.sin(phase * 1.37 + 1.7) * shakeStrength * 0.45
	local roll = math.sin(phase * 0.83 + 2.4) * shakeStrength * 0.25

	self._cameraTransform:Rotate(pitch, yaw, roll)
end

function RacingBurstFeedback:_updateSpeedImpulse(deltaTime)
	local currentMultiplier = self:_resolveSpeedMultiplier()

	if not self._lastSpeedMultiplier then
		local previousMultiplier = 1
		local multiplierDelta = currentMultiplier - previousMultiplier
		local speedMultiplierDebuffActive = self:_hasActiveSpeedMultiplierDebuff()

		if self._speedImpulseCooldownSec > 0 then
			self._speedImpulseCooldownSec = math.max(0, self._speedImpulseCooldownSec - deltaTime)
		end

		if self._lastSpeedMultiplierDebuffActive then
			local isRecoveringFromSpeedDebuff = not (speedMultiplierDebuffActive or multiplierDelta <= 0)

			if not isRecoveringFromSpeedDebuff and currentMultiplier > 1 and multiplierDelta >= SpeedImpulseThreshold and self._speedImpulseCooldownSec <= 0 then
				self:_triggerSpeedImpulse(multiplierDelta)
			end

			self._lastSpeedMultiplier = currentMultiplier
			self._lastSpeedMultiplierDebuffActive = speedMultiplierDebuffActive

			if self._speedImpulseLife <= 0 then
				return
			end

			self._speedImpulseLife = math.max(0, self._speedImpulseLife - deltaTime)

			self:_applySpeedImpulseCamera()
		end
	end
end

function RacingBurstFeedback:_triggerSpeedImpulse(multiplierDelta)
	self._speedImpulseTier = self:_resolveSpeedImpulseTier(multiplierDelta)
	self._speedImpulseLife = SpeedImpulseLifeSec
	self._speedImpulseDuration = SpeedImpulseLifeSec
	self._speedImpulseCooldownSec = SpeedImpulseCooldownSec
	self._speedImpulseSeed = Time.time * 17.31 + multiplierDelta * 13.7
end

function RacingBurstFeedback:_hasActiveSpeedMultiplierDebuff()
	if self._playerVehicle then
		local buffManager = self._playerVehicle.buffManager

		if not buffManager then
			return false
		end

		local activeBuffs = buffManager:getAllBuffs()

		for _, buff in ipairs(activeBuffs) do
			local effects = buff and buff.effects

			if effects then
				for _, effect in ipairs(effects) do
					if effect and effect.type == RacingCarPropEnum.BuffParamType.Attr and effect.paramId == RacingCarPropEnum.RacingParamId.SpeedMultiplier then
						if (effect.baseValue or 0) >= 0 then
							if (effect.ratio or 0) < 0 then
								return true
							end
						end
					end
				end
			end
		end

		return false
	end
end

function RacingBurstFeedback:_resolveSpeedImpulseTier(multiplierDelta)
	if multiplierDelta >= 0.6 then
		return 3
	elseif multiplierDelta >= 0.3 then
		return 2
	end

	return 1
end

function RacingBurstFeedback:_applySpeedImpulseCamera()
	if not SpeedImpulseTierConfigs[self._speedImpulseTier] then
		local config = SpeedImpulseTierConfigs[1]
		local duration = math.max(0.01, self._speedImpulseDuration)
		local elapsed = duration - self._speedImpulseLife
		local attackSec = math.min(SpeedImpulseAttackSec, duration)
		local envelope

		if elapsed <= attackSec then
			envelope = Mathf.Clamp01(elapsed / math.max(0.001, attackSec))
		else
			local decayProgress = Mathf.Clamp01((elapsed - attackSec) / math.max(0.001, duration - attackSec))

			envelope = math.cos(decayProgress * math.pi * 0.5)
		end

		if envelope <= 0 then
			return
		end

		self:_ensureCameraRefs()

		if self._camera then
			self._camera.fieldOfView = self._camera.fieldOfView + (config.fov or 0) * envelope
		end

		if not gohelper.isNil(self._cameraTransform) then
			local phase = (Time.time + self._speedImpulseSeed) * (config.shakeFrequency or 1) * TwoPi
			local strength = (config.shakeStrength or 0) * envelope
			local pitch = math.sin(phase) * strength
			local yaw = math.sin(phase * 1.21 + 0.8) * strength * 0.45
			local roll = math.sin(phase * 0.91 + 1.6) * strength * 0.3

			self._cameraTransform:Rotate(pitch, yaw, roll)
		end
	end
end

function RacingBurstFeedback:_ensureCameraRefs()
	if self._camera and not gohelper.isNil(self._cameraTransform) then
		return
	end

	local camera = CameraMgr.instance:getMainCamera()

	self._camera = camera

	if camera then
		self._cameraTransform = camera.transform or nil
	end
end

function RacingBurstFeedback:_collectActiveCameraShake()
	if self._playerVehicle then
		local buffManager = self._playerVehicle.buffManager

		if not buffManager then
			return 0, 0
		end

		local activeBuffs = buffManager:getAllBuffs()
		local shakeStrength = 0
		local shakeFrequency = 0

		for _, buff in ipairs(activeBuffs) do
			local cameraConfig = buff.cameraConfig

			if cameraConfig then
				shakeStrength = math.max(shakeStrength, cameraConfig.shakeStrength or 0)
				shakeFrequency = math.max(shakeFrequency, cameraConfig.shakeFrequency or 0)
			end
		end

		return shakeStrength, shakeFrequency
	end
end

function RacingBurstFeedback:_updateHitStopCooldown()
	if self._hitStopCooldownFrames > 0 then
		self._hitStopCooldownFrames = self._hitStopCooldownFrames - 1
	end
end

function RacingBurstFeedback:_updateBurstFeedbackCooldown()
	if self._burstFeedbackCooldownFrames > 0 then
		self._burstFeedbackCooldownFrames = self._burstFeedbackCooldownFrames - 1
	end
end

function RacingBurstFeedback:_restoreTimeScale()
	if not self._hitStopActive then
		return
	end

	if not self._savedTimeScale then
		local restoreScale = 1

		Time.timeScale = restoreScale <= HitStopTimeScale + 0.001 and 1 or restoreScale
		self._savedTimeScale = nil
		self._hitStopActive = false
	end
end

function RacingBurstFeedback:_spawnGhost(index)
	if gohelper.isNil(self._go) then
		return
	end

	local ghost = self._ghosts[index]

	if ghost then
		ghost.life = GhostLifeSec
		ghost.duration = GhostLifeSec
		ghost.active = true
		ghost.alphaUpdateElapsed = 0

		local historyPose = self:_resolveGhostHistoryPose(index)

		transformhelper.setPos(ghost.transform, historyPose.posX, historyPose.posY, historyPose.posZ)
		transformhelper.setEulerAngles(ghost.transform, historyPose.eulerX, historyPose.eulerY, historyPose.eulerZ)
		transformhelper.setLocalScale(ghost.transform, historyPose.scaleX, historyPose.scaleY, historyPose.scaleZ)
		gohelper.setActive(ghost.go, true)
		self:_setGhostAlpha(ghost, math.max(0.32, GhostInitialAlpha - index * GhostAlphaStep))

		return
	end

	if self._transform.parent then
		if not self._transform.parent.gameObject then
			local parentGo
			local ghostGo = gohelper.clone(self._go, parentGo, "racing_burst_ghost_" .. index)

			if gohelper.isNil(ghostGo) then
				return
			end

			self:_freezeGhostLogic(ghostGo)

			ghost = {
				alphaUpdateElapsed = 0,
				active = true,
				go = ghostGo,
				transform = ghostGo.transform,
				life = GhostLifeSec,
				duration = GhostLifeSec,
				renderers = ghostGo:GetComponentsInChildren(gohelper.Type_Render, true),
				blocks = {},
				materialCache = {},
				ownedMaterials = {},
				ownedMaterialSet = {}
			}

			local historyPose = self:_resolveGhostHistoryPose(index)

			transformhelper.setPos(ghost.transform, historyPose.posX, historyPose.posY, historyPose.posZ)
			transformhelper.setEulerAngles(ghost.transform, historyPose.eulerX, historyPose.eulerY, historyPose.eulerZ)
			transformhelper.setLocalScale(ghost.transform, historyPose.scaleX, historyPose.scaleY, historyPose.scaleZ)
			self:_setGhostAlpha(ghost, math.max(0.32, GhostInitialAlpha - index * GhostAlphaStep))

			self._ghosts[index] = ghost
		end
	end
end

function RacingBurstFeedback:_resolveLaneSwitchDirection()
	local playerVehicle = self._playerVehicle

	if not playerVehicle then
		return 0
	end

	if not playerVehicle._laneSwitchVisualDirection then
		local direction = 0

		if math.abs(direction) > 0.001 then
			return Mathf.Sign(direction)
		end

		if not playerVehicle._lateralVelocity then
			local lateralVelocity = 0

			if math.abs(lateralVelocity) > 0.01 then
				return Mathf.Sign(lateralVelocity)
			end

			local steering = playerVehicle.getVisualSteeringInput and playerVehicle:getVisualSteeringInput() or 0

			if math.abs(steering) > 0.001 then
				return Mathf.Sign(steering)
			end

			return 0
		end
	end
end

function RacingBurstFeedback:_freezeGhostLogic(ghostGo)
	local behaviours = ghostGo:GetComponentsInChildren(typeof(UnityEngine.Behaviour), true)

	for i = 0, behaviours.Length - 1 do
		behaviours[i].enabled = false
	end

	local colliders = ghostGo:GetComponentsInChildren(typeof(UnityEngine.Collider), true)

	for i = 0, colliders.Length - 1 do
		colliders[i].enabled = false
	end
end

function RacingBurstFeedback:_updateGhosts(deltaTime)
	for index = 1, GhostCount do
		local ghost = self._ghosts[index]

		if ghost and ghost.active then
			ghost.life = ghost.life - deltaTime

			if ghost.life <= 0 then
				ghost.active = false
				ghost.life = 0
				ghost.alphaUpdateElapsed = 0

				self:_setGhostAlpha(ghost, 0)
				gohelper.setActive(ghost.go, false)
			else
				ghost.alphaUpdateElapsed = (ghost.alphaUpdateElapsed or 0) + deltaTime

				if ghost.alphaUpdateElapsed >= GhostAlphaUpdateInterval then
					ghost.alphaUpdateElapsed = ghost.alphaUpdateElapsed % GhostAlphaUpdateInterval

					local alpha = Mathf.Clamp01(ghost.life / ghost.duration) * GhostFadeAlphaScale

					self:_setGhostAlpha(ghost, alpha)
				end
			end
		end
	end
end

function RacingBurstFeedback:_recordGhostPoseHistory()
	if gohelper.isNil(self._transform) then
		return
	end

	self._ghostPoseHistoryCursor = self._ghostPoseHistoryCursor % GhostHistoryFrameCount + 1

	local slot = self._ghostPoseHistory[self._ghostPoseHistoryCursor]

	if not slot then
		slot = {}
		self._ghostPoseHistory[self._ghostPoseHistoryCursor] = slot
	end

	slot.valid = true
	slot.posX, slot.posY, slot.posZ = transformhelper.getPos(self._transform)
	slot.eulerX, slot.eulerY, slot.eulerZ = transformhelper.getEulerAngles(self._transform)
	slot.scaleX, slot.scaleY, slot.scaleZ = transformhelper.getLocalScale(self._transform)
end

function RacingBurstFeedback:_resolveGhostHistoryPose(index)
	if not GhostHistoryFrameOffsets[index] then
		local frameOffset = GhostHistoryFrameCount

		if not self._ghostPoseHistoryCursor then
			local cursor = 0
			local slot = (cursor - frameOffset - 1) % GhostHistoryFrameCount + 1

			if self._ghostPoseHistory then
				if not self._ghostPoseHistory[slot] then
					local historyPose

					if historyPose and historyPose.valid then
						return historyPose
					end

					local fallback = self._ghostPoseFallback

					if not fallback then
						fallback = {}
						self._ghostPoseFallback = fallback
					end

					fallback.posX, fallback.posY, fallback.posZ = transformhelper.getPos(self._transform)
					fallback.eulerX, fallback.eulerY, fallback.eulerZ = transformhelper.getEulerAngles(self._transform)
					fallback.scaleX, fallback.scaleY, fallback.scaleZ = transformhelper.getLocalScale(self._transform)

					return fallback
				end
			end
		end
	end
end

local GhostColorCache = Color.New(0.62, 0.21, 1, 1)

function RacingBurstFeedback:_setGhostAlpha(ghost, alpha)
	if not ghost or not ghost.renderers then
		return
	end

	GhostColorCache.a = alpha

	for i = 0, ghost.renderers.Length - 1 do
		local renderer = ghost.renderers[i]

		if renderer then
			local block = ghost.blocks[i]

			if not block then
				block = UnityEngine.MaterialPropertyBlock.New()
				ghost.blocks[i] = block
			end

			block:SetColor("_Color", GhostColorCache)
			block:SetColor("_MainColor", GhostColorCache)
			block:SetColor("_TintColor", GhostColorCache)
			renderer:SetPropertyBlock(block)

			local materialList = ghost.materialCache[i]

			materialList = materialList or self:_buildGhostMaterialCache(ghost, i, renderer)

			self:_tintCachedMaterials(materialList, GhostColorCache)
		end
	end
end

function RacingBurstFeedback:_buildGhostMaterialCache(ghost, rendererIndex, renderer)
	local materialList = {}
	local materials = renderer.materials

	if materials then
		for m = 0, materials.Length - 1 do
			local material = materials[m]

			if material then
				local offset = #materialList

				materialList[offset + 1] = material
				materialList[offset + 2] = (material:HasProperty("_Color") and 1 or 0) + (material:HasProperty("_MainColor") and 2 or 0) + (material:HasProperty("_TintColor") and 4 or 0)

				if not ghost.ownedMaterialSet[material] then
					ghost.ownedMaterialSet[material] = true
					ghost.ownedMaterials[#ghost.ownedMaterials + 1] = material
				end
			end
		end
	end

	ghost.materialCache[rendererIndex] = materialList

	return materialList
end

function RacingBurstFeedback:_tintCachedMaterials(materialList, color)
	for m = 1, #materialList, 2 do
		local material = materialList[m]
		local propertyFlags = materialList[m + 1]

		if propertyFlags % 2 == 1 then
			material:SetColor("_Color", color)
		end

		if propertyFlags % 4 >= 2 then
			material:SetColor("_MainColor", color)
		end

		if propertyFlags >= 4 then
			material:SetColor("_TintColor", color)
		end
	end
end

function RacingBurstFeedback:_destroyGhostPool()
	for index = 1, GhostCount do
		local ghost = self._ghosts[index]

		if ghost then
			if ghost.blocks then
				for _, block in pairs(ghost.blocks) do
					block:Clear()
				end
			end

			if ghost.ownedMaterials then
				for i = 1, #ghost.ownedMaterials do
					local material = ghost.ownedMaterials[i]

					if not gohelper.isNil(material) then
						UnityEngine.Object.Destroy(material)
					end
				end

				tabletool.clear(ghost.ownedMaterials)
				tabletool.clear(ghost.ownedMaterialSet)
			end

			if not gohelper.isNil(ghost.go) then
				gohelper.destroy(ghost.go)
			end

			self._ghosts[index] = nil
		end
	end
end

function RacingBurstFeedback:_clearGhosts()
	for i = 1, GhostHistoryFrameCount do
		local slot = self._ghostPoseHistory[i]

		if slot then
			slot.valid = false
		end
	end

	self._ghostPoseHistoryCursor = 0

	for index = 1, GhostCount do
		local ghost = self._ghosts[index]

		if ghost then
			ghost.active = false
			ghost.life = 0

			self:_setGhostAlpha(ghost, 0)
			gohelper.setActive(ghost.go, false)
		end
	end
end

function RacingBurstFeedback:_resolveSpeedMultiplier()
	local playerVehicle = self._playerVehicle

	if not playerVehicle or not playerVehicle.getSpecialAttrValue or not RacingCarPropEnum or not RacingCarPropEnum.RacingParamId then
		return 1
	end

	local totalBase, totalRatio = playerVehicle:getSpecialAttrValue(RacingCarPropEnum.RacingParamId.SpeedMultiplier, playerVehicle._lossFactor)

	return math.max(0, (1 + (totalBase or 0)) * (1 + (totalRatio or 0)))
end

function RacingBurstFeedback:_resolveSpeedFxTier()
	local speedMultiplier = self:_resolveSpeedMultiplier()

	if speedMultiplier > 1.6 then
		return 3
	elseif speedMultiplier > 1 then
		return 2
	end

	return 1
end

function RacingBurstFeedback:_ensureSpeedFx()
	local targetTier = self:_resolveSpeedFxTier()

	if not gohelper.isNil(self._speedFxRoot) then
		self:_destroySpeedFxRoot()
	end

	if self._speedFxTier == targetTier then
		return
	end

	self:_destroySpeedFxRoot()
	self:_restoreRadialBlur()

	self._speedFxTier = targetTier
end

function RacingBurstFeedback:_destroySpeedFxRoot()
	if not gohelper.isNil(self._speedFxRoot) then
		gohelper.destroy(self._speedFxRoot)
	end

	self._speedFxTier = 0
	self._speedFxRoot = nil
	self._speedFxCanvasGroup = nil
end

function RacingBurstFeedback:_updateSpeedFx(deltaTime)
	if not self._burstBuffActive then
		local active = self._speedFxLife > 0

		if not active then
			if self._speedFxCanvasGroup then
				self._speedFxCanvasGroup.alpha = 0
			end

			self:_restoreRadialBlur()

			return
		end

		self:_ensureSpeedFx()

		if self._speedFxLife > 0 then
			self._speedFxLife = math.max(0, self._speedFxLife - deltaTime)
		end

		local lifeAlpha = self._burstBuffActive and 1 or Mathf.Clamp01(self._speedFxLife / SpeedFxLifeSec)

		self:_applyRadialBlur(self._speedFxTier, lifeAlpha)
	end
end

function RacingBurstFeedback:_clearSpeedFx()
	self._speedFxLife = 0

	self:_destroySpeedFxRoot()
	self:_restoreRadialBlur()
end

function RacingBurstFeedback:_getRacingConstValue2(constId)
	local var_51_0 = lua_racing_const

	if lua_racing_const then
		var_51_0 = lua_racing_const.configDict

		if lua_racing_const.configDict then
			local dict = lua_racing_const.configDict[13920]
			local co = dict and dict[constId]

			if not co then
				return nil
			end

			return (co.value2 and co.value2 ~= "" or nil) and (co.value2 or co.value)
		end
	end
end

function RacingBurstFeedback:_resolveSpeedLineThresholds()
	return self._cachedSpeedLineFirst or DefaultSpeedLineThresholds[1], self._cachedSpeedLineSecond or DefaultSpeedLineThresholds[2]
end

function RacingBurstFeedback:_resolveTailWakeThresholds()
	return self._cachedTailWakeFirst or DefaultTailWakeThresholds[1], self._cachedTailWakeSecond or DefaultTailWakeThresholds[2]
end

function RacingBurstFeedback:_cacheSpeedThresholds()
	local speedLineValue = self:_getRacingConstValue2(SpeedLineConstId)
	local speedLineValues = speedLineValue and string.splitToNumber(speedLineValue, "#") or nil

	if speedLineValues then
		self._cachedSpeedLineFirst = speedLineValues[1] or DefaultSpeedLineThresholds[1]
	end

	if speedLineValues then
		self._cachedSpeedLineSecond = speedLineValues[2] or DefaultSpeedLineThresholds[2]
	end

	if self._cachedSpeedLineFirst > self._cachedSpeedLineSecond then
		self._cachedSpeedLineFirst, self._cachedSpeedLineSecond = self._cachedSpeedLineSecond, self._cachedSpeedLineFirst
	end

	local tailWakeValue = self:_getRacingConstValue2(TailWakeConstId)
	local tailWakeValues = tailWakeValue and string.splitToNumber(tailWakeValue, "#") or nil

	if tailWakeValues then
		self._cachedTailWakeFirst = tailWakeValues[1] or DefaultTailWakeThresholds[1]
	end

	if tailWakeValues then
		self._cachedTailWakeSecond = tailWakeValues[2] or DefaultTailWakeThresholds[2]
	end

	if self._cachedTailWakeFirst > self._cachedTailWakeSecond then
		self._cachedTailWakeFirst, self._cachedTailWakeSecond = self._cachedTailWakeSecond, self._cachedTailWakeFirst
	end
end

function RacingBurstFeedback:_resolveForwardSpeed()
	local playerVehicle = self._playerVehicle

	if not playerVehicle or not playerVehicle.getForwardSpeed then
		return 0
	end

	return playerVehicle:getForwardSpeed() or 0
end

function RacingBurstFeedback:_resolvePresentationSpeedLineTierOverride()
	local playerVehicle = self._playerVehicle
	local var_56_0

	if not playerVehicle or not playerVehicle.getPresentationSpeedLineTierOverride then
		do return 0 end

		var_56_0 = playerVehicle:getPresentationSpeedLineTierOverride() or 0
	end

	return math.max(0, var_56_0)
end

function RacingBurstFeedback:_resolvePresentationTailWakeTierOverride()
	local playerVehicle = self._playerVehicle
	local var_57_0

	if not playerVehicle or not playerVehicle.getPresentationTailWakeTierOverride then
		do return 0 end

		var_57_0 = playerVehicle:getPresentationTailWakeTierOverride() or 0
	end

	return math.max(0, var_57_0)
end

function RacingBurstFeedback:_resolveSpeedLineTier(speed)
	local presentationOverride = self:_resolvePresentationSpeedLineTierOverride()

	if presentationOverride > 0 then
		return math.min(2, presentationOverride)
	end

	if speed <= MinSpeedForVehicleFx then
		return 0
	end

	local firstThreshold, secondThreshold = self:_resolveSpeedLineThresholds()

	if secondThreshold <= speed then
		return 2
	elseif firstThreshold <= speed then
		return 1
	end

	return 0
end

function RacingBurstFeedback:_resolveTailWakeTier(speed)
	local presentationOverride = self:_resolvePresentationTailWakeTierOverride()

	if presentationOverride > 0 then
		return math.min(3, presentationOverride)
	end

	if speed <= MinSpeedForVehicleFx then
		return 0
	end

	local firstThreshold, secondThreshold = self:_resolveTailWakeThresholds()

	if secondThreshold <= speed then
		return 3
	elseif firstThreshold <= speed then
		return 2
	end

	return 1
end

function RacingBurstFeedback:_getPreloadedResource(res)
	local var_60_0 = GameSceneMgr

	if GameSceneMgr then
		var_60_0 = GameSceneMgr.instance

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

function RacingBurstFeedback:_ensureVehicleFxGo(fieldName, resourcePath, instanceName)
	if not gohelper.isNil(self[fieldName]) then
		return self[fieldName]
	end

	local prefab = self:_getPreloadedResource(resourcePath)

	if gohelper.isNil(prefab) or gohelper.isNil(self._go) then
		return nil
	end

	local parentGo = self._playerVehicle and self._playerVehicle.getRacerVisualAttachGo and self._playerVehicle:getRacerVisualAttachGo() or self._go
	local fxGo = gohelper.clone(prefab, parentGo, instanceName)

	if not gohelper.isNil(fxGo) then
		local fxTransform = fxGo.transform

		transformhelper.setLocalPos(fxTransform, 0, 0, 0)
		transformhelper.setLocalRotation(fxTransform, 0, 0, 0)
		transformhelper.setLocalScale(fxTransform, 1, 1, 1)
	end

	self[fieldName] = fxGo

	return fxGo
end

function RacingBurstFeedback:_ensureSpeedLineFxGo()
	if not gohelper.isNil(self._speedLineFxGo) then
		return self._speedLineFxGo
	end

	local prefab = self:_getPreloadedResource(SpeedLineFxPath)
	local camera = CameraMgr.instance:getMainCamera()
	local cameraGo = camera and camera.gameObject

	if gohelper.isNil(prefab) or gohelper.isNil(cameraGo) then
		return nil
	end

	local fxGo = gohelper.clone(prefab, cameraGo, "racing_speed_line_fx")

	self._speedLineFxGo = fxGo

	self:_updateSpeedLineCameraTransform()

	return fxGo
end

function RacingBurstFeedback:_updateSpeedLineCameraTransform()
	local fxGo = self._speedLineFxGo

	if gohelper.isNil(fxGo) then
		return
	end

	local fxTransform = fxGo.transform

	transformhelper.setLocalPos(fxTransform, 0, 0, 0)
	transformhelper.setLocalRotation(fxTransform, 0, 0, 0)
	transformhelper.setLocalScale(fxTransform, 1, 1, 1)
end

function RacingBurstFeedback:_playVehicleFxTier(fxGo, stateName)
	if gohelper.isNil(fxGo) or not stateName then
		return
	end

	local animator = fxGo:GetComponent(typeof(UnityEngine.Animator))

	animator = animator or fxGo:GetComponentInChildren(typeof(UnityEngine.Animator))

	if animator then
		animator:Play(stateName, 0, 0)
	end
end

function RacingBurstFeedback:_updateVehicleSpeedAssets()
	local speed = self:_resolveForwardSpeed()
	local speedLineTier = self:_resolveSpeedLineTier(speed)
	local tailWakeTier = self:_resolveTailWakeTier(speed)

	self:_updateSpeedLineAsset(speedLineTier)
	self:_updateTailWakeAsset(tailWakeTier)
end

function RacingBurstFeedback:_updateSpeedLineAsset(tier)
	if tier <= 0 then
		if self._speedLineFxVisible and not gohelper.isNil(self._speedLineFxGo) then
			gohelper.setActive(self._speedLineFxGo, false)
			V3a9RacingCarController.instance:dispatchEvent(V3a9RacingCarEvent.ChangeSpeedLine, 0)
		end

		self._speedLineFxVisible = false
		self._speedLineFxTier = 0

		return
	end

	local fxGo = self:_ensureSpeedLineFxGo()

	if gohelper.isNil(fxGo) then
		return
	end

	if not self._speedLineFxVisible then
		gohelper.setActive(fxGo, true)
		self:_updateSpeedLineCameraTransform()

		self._speedLineFxVisible = true
	end

	if self._speedLineFxTier ~= tier then
		self._speedLineFxTier = tier

		self:_playVehicleFxTier(fxGo, SpeedLineStateNames[tier])
		V3a9RacingCarController.instance:dispatchEvent(V3a9RacingCarEvent.ChangeSpeedLine, tier)
	end
end

function RacingBurstFeedback:_getAiTailWakeTrailEntries(fxGo)
	if self._aiTailWakeTrailFxGo == fxGo and self._aiTailWakeTrailEntries then
		return self._aiTailWakeTrailEntries
	end

	local entries = {}

	for _, childPath in ipairs(AiTailWakeTrailChildPaths) do
		local childGo = gohelper.findChild(fxGo, childPath)

		if not gohelper.isNil(childGo) then
			entries[#entries + 1] = {
				go = childGo,
				particle = childGo:GetComponent(typeof(UnityEngine.ParticleSystem))
			}
		end
	end

	self._aiTailWakeTrailFxGo = fxGo
	self._aiTailWakeTrailEntries = entries

	return entries
end

function RacingBurstFeedback:_resetAiTailWakeTrailChildren(fxGo, restart)
	if not self._tailWakeOnly or gohelper.isNil(fxGo) then
		return
	end

	local entries = self:_getAiTailWakeTrailEntries(fxGo)

	for _, entry in ipairs(entries) do
		local childGo = entry.go

		if not gohelper.isNil(childGo) then
			local particle = entry.particle

			if not gohelper.isNil(particle) then
				particle:Stop(true)
				particle:Clear(true)
			end

			if restart then
				gohelper.setActive(childGo, false)
				gohelper.setActive(childGo, true)

				if not gohelper.isNil(particle) and childGo.activeInHierarchy then
					particle:Play(true)
				end
			end
		end
	end
end

function RacingBurstFeedback:_updateTailWakeAsset(tier)
	if tier <= 0 then
		if self._tailWakeFxVisible and not gohelper.isNil(self._tailWakeFxGo) then
			self:_resetAiTailWakeTrailChildren(self._tailWakeFxGo, false)
			gohelper.setActive(self._tailWakeFxGo, false)
		end

		self._tailWakeFxVisible = false
		self._tailWakeFxTier = 0

		return
	end

	local fxGo = self:_ensureVehicleFxGo("_tailWakeFxGo", V3a9RacingCarScenePreloader.Tuowei, "racing_tail_wake_fx")

	if gohelper.isNil(fxGo) then
		return
	end

	local shouldRestartAiTrails = false

	if not self._tailWakeFxVisible then
		gohelper.setActive(fxGo, true)

		self._tailWakeFxVisible = true
		shouldRestartAiTrails = true
	end

	if self._tailWakeFxTier ~= tier then
		self._tailWakeFxTier = tier

		self:_playVehicleFxTier(fxGo, TailWakeStateNames[tier])

		shouldRestartAiTrails = true
	end

	if shouldRestartAiTrails then
		self:_resetAiTailWakeTrailChildren(fxGo, true)
	end
end

function RacingBurstFeedback:_clearVehicleSpeedAssets()
	if not gohelper.isNil(self._speedLineFxGo) then
		gohelper.destroy(self._speedLineFxGo)
	end

	if not gohelper.isNil(self._tailWakeFxGo) then
		gohelper.destroy(self._tailWakeFxGo)
	end

	self._speedLineFxGo = nil
	self._speedLineFxTier = 0
	self._speedLineFxVisible = false
	self._tailWakeFxGo = nil
	self._tailWakeFxTier = 0
	self._tailWakeFxVisible = false
	self._aiTailWakeTrailFxGo = nil
	self._aiTailWakeTrailEntries = nil
end

function RacingBurstFeedback:_onCoinAbsorbVisual(coinGo)
	if gohelper.isNil(coinGo) or gohelper.isNil(self._go) then
		return
	end

	if #self._coinFlyVisuals >= MaxCoinFlyVisualCount then
		return
	end

	local poolCount = #self._coinFlyPool
	local visual = self._coinFlyPool[poolCount]

	if visual then
		self._coinFlyPool[poolCount] = nil
	else
		local prefab = self:_getPreloadedResource(CoinFlyFxPath)
		local sourceGo = gohelper.isNil(prefab) and coinGo or prefab

		if self._transform.parent then
			if not self._transform.parent.gameObject then
				local parentGo = self._go
				local flyGo = gohelper.clone(sourceGo, parentGo, "racing_coin_absorb_fly")

				if gohelper.isNil(flyGo) then
					return
				end

				visual = {
					go = flyGo,
					transform = flyGo.transform
				}
			end
		end
	end

	local coinTransform = coinGo.transform
	local flyGo = visual.go
	local flyTransform = visual.transform
	local startX, startY, startZ = transformhelper.getPos(coinTransform)
	local eulerX, eulerY, eulerZ = transformhelper.getEulerAngles(coinTransform)

	transformhelper.setPos(flyTransform, startX, startY, startZ)
	transformhelper.setEulerAngles(flyTransform, eulerX, eulerY, eulerZ)
	transformhelper.setLocalScale(flyTransform, 1, 1, 1)
	gohelper.setActive(flyGo, true)

	visual.startX = startX
	visual.startY = startY
	visual.startZ = startZ
	visual.elapsed = 0
	visual.duration = CoinFlyDurationSec
	self._coinFlyVisuals[#self._coinFlyVisuals + 1] = visual
end

function RacingBurstFeedback:_updateCoinFlyVisuals(deltaTime)
	if not self._coinFlyVisuals or #self._coinFlyVisuals == 0 then
		return
	end

	local targetBaseX, targetBaseY, targetBaseZ

	if self._transform then
		local px, py, pz = transformhelper.getPos(self._transform)

		targetBaseX = px
		targetBaseY = py + CoinFlyTargetYOffset
		targetBaseZ = pz
	else
		targetBaseZ = 0
		targetBaseY = CoinFlyTargetYOffset
		targetBaseX = 0
	end

	for i = #self._coinFlyVisuals, 1, -1 do
		local visual = self._coinFlyVisuals[i]

		if gohelper.isNil(visual.go) or gohelper.isNil(visual.transform) then
			self._coinFlyVisuals[i] = self._coinFlyVisuals[#self._coinFlyVisuals]
			self._coinFlyVisuals[#self._coinFlyVisuals] = nil
		else
			visual.elapsed = visual.elapsed + deltaTime

			local t = Mathf.Clamp01(visual.elapsed / math.max(0.01, visual.duration or CoinFlyDurationSec))
			local eased = 1 - (1 - t) * (1 - t)
			local arc = math.sin(t * math.pi) * CoinFlyArcHeight
			local startX, startY, startZ = visual.startX, visual.startY, visual.startZ
			local x = startX + (targetBaseX - startX) * eased
			local y = startY + (targetBaseY - startY) * eased + arc
			local z = startZ + (targetBaseZ - startZ) * eased

			transformhelper.setPos(visual.transform, x, y, z)

			if t >= 1 then
				gohelper.setActive(visual.go, false)

				self._coinFlyVisuals[i] = self._coinFlyVisuals[#self._coinFlyVisuals]
				self._coinFlyVisuals[#self._coinFlyVisuals] = nil
				self._coinFlyPool[#self._coinFlyPool + 1] = visual
			end
		end
	end
end

function RacingBurstFeedback:_clearCoinFlyVisuals(destroyPool)
	if not self._coinFlyVisuals then
		return
	end

	for i = #self._coinFlyVisuals, 1, -1 do
		local visual = self._coinFlyVisuals[i]

		self._coinFlyVisuals[i] = nil

		if visual and not gohelper.isNil(visual.go) then
			if destroyPool then
				gohelper.destroy(visual.go)
			else
				gohelper.setActive(visual.go, false)

				self._coinFlyPool[#self._coinFlyPool + 1] = visual
			end
		end
	end

	if destroyPool then
		for i = 1, #self._coinFlyPool do
			local visual = self._coinFlyPool[i]

			if visual and not gohelper.isNil(visual.go) then
				gohelper.destroy(visual.go)
			end
		end

		tabletool.clear(self._coinFlyPool)
	end
end

function RacingBurstFeedback:_hasItemInvincibleBuff()
	if self._playerVehicle then
		local buffManager = self._playerVehicle.buffManager

		if not buffManager then
			return false
		end

		local activeBuffs = buffManager:getAllBuffs()

		for _, buff in ipairs(activeBuffs) do
			if buff and buff.buffId == ItemInvincibleBuffId then
				return true
			end
		end

		return false
	end
end

function RacingBurstFeedback:_updateItemInvincibleShield()
	if not self:_hasItemInvincibleBuff() then
		self:_clearItemInvincibleShield()

		return
	end

	local fxGo = self:_ensureVehicleFxGo("_itemInvincibleShieldGo", ItemInvincibleFxPath, "racing_item_invincible_shield_loop")

	if not gohelper.isNil(fxGo) then
		gohelper.setActive(fxGo, true)
	end
end

function RacingBurstFeedback:_clearItemInvincibleShield()
	if not gohelper.isNil(self._itemInvincibleShieldGo) then
		gohelper.destroy(self._itemInvincibleShieldGo)
	end

	self._itemInvincibleShieldGo = nil
end

function RacingBurstFeedback:_applyRadialBlur(tier, alpha)
	if PostProcessingMgr then
		if not PostProcessingMgr then
			return
		end

		self:_saveRadialBlurState(PostProcessingMgr)

		if not SpeedFxTierConfigs[tier] then
			local blurLevel = RadialBlurBaseLevel + ((not SpeedFxTierConfigs[tier].radialBlurStrength or nil) and 0)
			local samplePercent = (SpeedFxTierConfigs[tier].blurSamplePercent or 0) * Mathf.Clamp01(alpha or 1)

			PostProcessingMgr:setUnitPPValue("IsDynamicBlur", false)
			PostProcessingMgr:setUnitPPValue("isDynamicBlur", false)
			PostProcessingMgr:setUnitPPValue("IsLocalRadialBlur", false)
			PostProcessingMgr:setUnitPPValue("isLocalRadialBlur", false)
			PostProcessingMgr:setUnitPPValue("BlurSamplePercent", samplePercent)
			PostProcessingMgr:setUnitPPValue("blurSamplePercent", samplePercent)
			PostProcessingMgr:setUnitPPValue("RadialBlurLevel", blurLevel)
			PostProcessingMgr:setUnitPPValue("radialBlurLevel", blurLevel)

			self._activeRadialBlurTier = tier
		end
	end
end

function RacingBurstFeedback:_saveRadialBlurState(ppMgr)
	if self._radialBlurOwned or not ppMgr then
		return
	end

	self._savedRadialBlurLevel = ppMgr:getUnitPPValue("RadialBlurLevel") or ppMgr:getUnitPPValue("radialBlurLevel") or 1
	self._savedBlurSamplePercent = ppMgr:getUnitPPValue("BlurSamplePercent") or ppMgr:getUnitPPValue("blurSamplePercent") or 0.5
	self._savedIsLocalRadialBlur = ppMgr:getUnitPPValue("IsLocalRadialBlur")

	if self._savedIsLocalRadialBlur == nil then
		self._savedIsLocalRadialBlur = ppMgr:getUnitPPValue("isLocalRadialBlur") or false
	end

	self._savedIsDynamicBlur = ppMgr:getUnitPPValue("IsDynamicBlur")

	if self._savedIsDynamicBlur == nil then
		self._savedIsDynamicBlur = ppMgr:getUnitPPValue("isDynamicBlur") or false
	end

	self._radialBlurOwned = true
end

function RacingBurstFeedback:_restoreRadialBlur()
	if not self._radialBlurOwned then
		return
	end

	if PostProcessingMgr then
		local ppMgr = PostProcessingMgr.instance

		if ppMgr then
			ppMgr:setUnitPPValue("IsDynamicBlur", self._savedIsDynamicBlur or false)
			ppMgr:setUnitPPValue("isDynamicBlur", self._savedIsDynamicBlur or false)
			ppMgr:setUnitPPValue("IsLocalRadialBlur", self._savedIsLocalRadialBlur or false)
			ppMgr:setUnitPPValue("isLocalRadialBlur", self._savedIsLocalRadialBlur or false)
			ppMgr:setUnitPPValue("BlurSamplePercent", self._savedBlurSamplePercent or 0.5)
			ppMgr:setUnitPPValue("blurSamplePercent", self._savedBlurSamplePercent or 0.5)
			ppMgr:setUnitPPValue("RadialBlurLevel", self._savedRadialBlurLevel or 1)
			ppMgr:setUnitPPValue("radialBlurLevel", self._savedRadialBlurLevel or 1)
		end

		self._radialBlurOwned = false
		self._savedRadialBlurLevel = nil
		self._savedBlurSamplePercent = nil
		self._savedIsLocalRadialBlur = nil
		self._savedIsDynamicBlur = nil
		self._activeRadialBlurTier = 0
	end
end

return RacingBurstFeedback
