-- chunkname: @modules/logic/versionactivity3_9/racingcar/logic/feedback/RacingLaunchFeedback.lua

module("modules.logic.versionactivity3_9.racingcar.logic.feedback.RacingLaunchFeedback", package.seeall)

local RacingLaunchFeedback = class("RacingLaunchFeedback", LuaCompBase)
local TwoPi = math.pi * 2
local HitStopTimeScale = 0.03
local SpeedLaunchThreshold = 0.6
local SpeedLaunchCooldownSec = 0.35
local ShortcutLaunchConfig = {
	shakeFrequency = 4,
	attackSec = 0.035,
	shakeStrength = 1.1,
	lifeSec = 0.22,
	hitStopFrames = 2,
	fov = 1.2
}
local SpeedLaunchConfig = {
	shakeFrequency = 4,
	attackSec = 0.04,
	shakeStrength = 1.8,
	lifeSec = 0.28,
	hitStopFrames = 2,
	fov = 2.4
}

function RacingLaunchFeedback:init(go)
	self._go = go
	self._playerVehicle = nil
	self._camera = nil
	self._cameraTransform = nil
	self._wasShortcutJumping = false
	self._lastSpeedMultiplier = 1
	self._speedLaunchCooldownSec = 0
	self._launchLife = 0
	self._launchDuration = 0
	self._launchAttackSec = 0
	self._launchFov = 0
	self._launchShakeStrength = 0
	self._launchShakeFrequency = 0
	self._launchSeed = 0
	self._hitStopFrames = 0
	self._hitStopActive = false
	self._savedTimeScale = nil
end

function RacingLaunchFeedback:initialize(playerVehicle)
	self._playerVehicle = playerVehicle

	self:_ensureCameraRefs()

	self._lastSpeedMultiplier = self:_resolveSpeedMultiplier()
end

function RacingLaunchFeedback:lateUpdate(deltaTime)
	self:_updateCooldown(deltaTime)
	self:_detectShortcutLaunch()
	self:_detectSpeedLaunch()
	self:_updateHitStop()
	self:_updateLaunchImpulse(deltaTime)
end

function RacingLaunchFeedback:resetForRestart()
	self._wasShortcutJumping = false
	self._lastSpeedMultiplier = 1
	self._speedLaunchCooldownSec = 0
	self._launchLife = 0
	self._hitStopFrames = 0

	self:_restoreTimeScale()
end

function RacingLaunchFeedback:onDestroy()
	self:resetForRestart()
end

function RacingLaunchFeedback:_detectShortcutLaunch()
	local var_6_0 = self._playerVehicle

	if self._playerVehicle then
		var_6_0 = self._playerVehicle.isShortcutJumping

		if self._playerVehicle.isShortcutJumping then
			local isJumping = self._playerVehicle:isShortcutJumping()

			if isJumping and not self._wasShortcutJumping then
				self:_triggerLaunch(ShortcutLaunchConfig)
			end

			self._wasShortcutJumping = isJumping == true
		end
	end
end

function RacingLaunchFeedback:_detectSpeedLaunch()
	local currentMultiplier = self:_resolveSpeedMultiplier()
	local delta = currentMultiplier - (self._lastSpeedMultiplier or 1)

	if currentMultiplier > 1 and delta >= SpeedLaunchThreshold and self._speedLaunchCooldownSec <= 0 then
		self:_triggerLaunch(SpeedLaunchConfig)

		self._speedLaunchCooldownSec = SpeedLaunchCooldownSec
	end

	self._lastSpeedMultiplier = currentMultiplier
end

function RacingLaunchFeedback:_triggerLaunch(config)
	self._launchLife = config.lifeSec or 0
	self._launchDuration = config.lifeSec or 0
	self._launchAttackSec = config.attackSec or 0.03
	self._launchFov = config.fov or 0
	self._launchShakeStrength = config.shakeStrength or 0
	self._launchShakeFrequency = config.shakeFrequency or 1
	self._launchSeed = Time.time * 19.17 + self._launchFov * 7.31
	self._hitStopFrames = math.max(self._hitStopFrames, config.hitStopFrames or 0)
end

function RacingLaunchFeedback:_updateLaunchImpulse(deltaTime)
	if self._launchLife <= 0 then
		return
	end

	self._launchLife = math.max(0, self._launchLife - deltaTime)

	local duration = math.max(0.001, self._launchDuration)
	local elapsed = duration - self._launchLife
	local attackSec = math.min(self._launchAttackSec, duration)
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
		self._camera.fieldOfView = self._camera.fieldOfView + self._launchFov * envelope
	end

	if not gohelper.isNil(self._cameraTransform) and self._launchShakeStrength > 0 then
		local phase = (Time.time + self._launchSeed) * self._launchShakeFrequency * TwoPi
		local strength = self._launchShakeStrength * envelope
		local pitch = math.sin(phase) * strength
		local yaw = math.sin(phase * 1.19 + 0.6) * strength * 0.45
		local roll = math.sin(phase * 0.87 + 1.4) * strength * 0.3

		self._cameraTransform:Rotate(pitch, yaw, roll)
	end
end

function RacingLaunchFeedback:_updateHitStop()
	if self._hitStopFrames > 0 then
		if not self._hitStopActive then
			self._savedTimeScale = Time.timeScale
			Time.timeScale = HitStopTimeScale
			self._hitStopActive = true
		end

		self._hitStopFrames = self._hitStopFrames - 1

		if self._hitStopFrames <= 0 then
			self:_restoreTimeScale()
		end
	elseif self._hitStopActive then
		self:_restoreTimeScale()
	end
end

function RacingLaunchFeedback:_restoreTimeScale()
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

function RacingLaunchFeedback:_updateCooldown(deltaTime)
	if self._speedLaunchCooldownSec > 0 then
		self._speedLaunchCooldownSec = math.max(0, self._speedLaunchCooldownSec - deltaTime)
	end
end

function RacingLaunchFeedback:_ensureCameraRefs()
	if self._camera and not gohelper.isNil(self._cameraTransform) then
		return
	end

	local camera = CameraMgr.instance:getMainCamera()

	self._camera = camera

	if camera then
		self._cameraTransform = camera.transform or nil
	end
end

function RacingLaunchFeedback:_resolveSpeedMultiplier()
	local playerVehicle = self._playerVehicle

	if not playerVehicle or not playerVehicle.getAttrValue then
		return 1
	end

	local totalBase, totalRatio = playerVehicle:getAttrValue(RacingCarPropEnum.RacingParamId.SpeedMultiplier, playerVehicle._lossFactor)

	return math.max(0, (1 + (totalBase or 0)) * (1 + (totalRatio or 0)))
end

return RacingLaunchFeedback
