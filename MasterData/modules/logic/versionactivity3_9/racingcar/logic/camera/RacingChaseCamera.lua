-- chunkname: @modules/logic/versionactivity3_9/racingcar/logic/camera/RacingChaseCamera.lua

module("modules.logic.versionactivity3_9.racingcar.logic.camera.RacingChaseCamera", package.seeall)

local RacingChaseCamera = class("RacingChaseCamera", LuaCompBase)
local WaterfallClimbFollowSmoothTime = 0.035
local WaterfallClimbLookSmoothTime = 0.035
local WaterfallClimbFollowDistanceExtra = 1
local WaterfallClimbYawSharpness = 8
local ShortcutJumpFollowSmoothTime = 0.035
local ShortcutJumpTargetYawSmoothTime = 0.22
local SpeedMultiplierFollowSmoothFactor = 1.3
local SpeedMultiplierFollowScaleEnterSmoothTime = 0.2
local SpeedMultiplierFollowScaleExitSmoothTime = 0.32
local MainRoadCurveFollowScaleMax = 1.4
local MainRoadCurveTurnDeadZoneDeg = 0.4
local MainRoadCurveTurnActiveRangeDeg = 3
local MainRoadCurveFadeInSmoothTime = 0.12
local MainRoadCurveFadeOutSmoothTime = 0.4
local FollowLostWarnDistance = 45
local FollowLostWarnIntervalSec = 1
local NarcissusUltimateId = 7
local NarcissusReleaseEndSec = 0.1
local NarcissusChaseBlendEndSec = 0.16
local NarcissusChaseEndSec = 0.24
local NarcissusSettleEndSec = 0.4
local NarcissusReleaseFollowSmoothTime = 0.12
local NarcissusChaseFollowSmoothTime = 0.07
local NarcissusReleaseYawSmoothTime = 0.08
local NarcissusChaseYawSmoothTime = 0.05
local VEC3_FORWARD = Vector3(0, 0, 1)
local _horizForwardCache = Vector3(0, 0, 1)
local _stableForwardResult = Vector3(0, 0, 1)
local _rawForwardResult = Vector3(0, 0, 1)

function RacingChaseCamera:ctor(camera)
	self._controlledCamera = camera
end

function RacingChaseCamera:init(go)
	self._go = self._controlledCamera.gameObject

	if self._controlledCamera then
		self._transform = self._controlledCamera.transform or nil
	end

	self._target = nil
	self._playerVehicle = nil
	self._followSmoothTime = 0.26
	self._lookSmoothTime = 0.28
	self._targetYawSmoothTime = 0.5
	self._positionDeadZone = 0
	self._lookAheadDistance = 52.5
	self._minimumLookAheadDistance = 42.5
	self._framingUpOffset = 1.72
	self._boostPushDistance = 0.175
	self._boostPushSmoothTime = 0.1
	self._runtimeConfig = nil
	self._cameraConfig = {}
	self._cameraFeelConfig = {}
	self._smoothedFollowX, self._smoothedFollowY, self._smoothedFollowZ = 0, 0, 0
	self._followVelX, self._followVelY, self._followVelZ = 0, 0, 0
	self._smoothedLookX, self._smoothedLookY, self._smoothedLookZ = 0, 0, 0
	self._lookVelX, self._lookVelY, self._lookVelZ = 0, 0, 0
	self._waterfallCameraYawDeg = nil
	self._smoothedTargetForwardX, self._smoothedTargetForwardY, self._smoothedTargetForwardZ = 0, 0, 1
	self._targetForwardVelX, self._targetForwardVelY, self._targetForwardVelZ = 0, 0, 0
	self._smoothedBoostPushDistance = 0
	self._boostPushVelocity = 0
	self._smoothedBoostFov01 = 0
	self._boostFovVelocity = 0
	self._mainRoadCurveTurn01 = 0
	self._mainRoadCurveTurnVelocity = 0
	self._mainRoadCurveFollowScale = 1
	self._smoothedSpeedMultiplierFollowScale = 1
	self._speedMultiplierFollowScaleVelocity = 0
	self._lastMainRoadCurveForwardX = nil
	self._lastMainRoadCurveForwardY = nil
	self._lastMainRoadCurveForwardZ = nil
	self._smoothedProfileDistance = 5.58
	self._smoothedProfileHeight = 5.25
	self._smoothedProfileLookAhead = 3
	self._smoothedProfileLookHeight = 0.6
	self._smoothedProfileRotationSharpness = 22
	self._smoothedProfileFov = 74
	self._profileDistanceVelocity = 0
	self._profileHeightVelocity = 0
	self._profileLookAheadVelocity = 0
	self._profileLookHeightVelocity = 0
	self._profileRotationSharpnessVelocity = 0
	self._profileFovVelocity = 0
	self._hasSmoothedProfileParams = false
	self._subscribedVehicle = nil
	self._initialized = false
	self._hasFollowPosition = false
	self._hasLookTarget = false
	self._hasForwardTarget = false
	self._previousUseVerticalPositionForward = nil
	self._modeTransitionStartOffsetX = 0
	self._modeTransitionStartOffsetY = 0
	self._modeTransitionStartOffsetZ = 0
	self._modeTransitionDurationSec = 0
	self._modeTransitionRemainingSec = 0
	self._followLostWarnCooldownSec = 0
	self._narcissusFollowActive = false
	self._narcissusFollowElapsedSec = 0

	V3a9RacingCarController.instance:registerCallback(V3a9RacingCarEvent.OnUltimateUsed, self._onUltimateUsed, self)
end

function RacingChaseCamera:onStart()
	self:initialize()
	self:_subscribeToVehicle()
end

function RacingChaseCamera:onEnable()
	self:_subscribeToVehicle()
end

function RacingChaseCamera:onDisable()
	self:_unsubscribeFromVehicle()
end

function RacingChaseCamera:onUpdate()
	return
end

function RacingChaseCamera:initialize(config)
	if not config then
		config = V3a9RacingCarModel.instance:getTrackConfig()

		if not config then
			logError("RacingChaseCamera:initialize - trackConfig is nil")

			return
		end
	end

	self._runtimeConfig = config
	self._cameraConfig = config.camera or {}
	self._cameraFeelConfig = config.cameraFeel or {}

	self:_applyCameraFeelConfig(self._cameraFeelConfig)

	self._initialized = true
end

function RacingChaseCamera:setTarget(vehicle)
	self:_unsubscribeFromVehicle()
	self:_resetNarcissusFollowOverride()

	self._playerVehicle = vehicle

	if vehicle then
		self._target = vehicle._go.transform or nil
	end

	self:_subscribeToVehicle()
	self:_resetFollowState()
end

function RacingChaseCamera:lateUpdate(deltaTime)
	self:_ensureInitialized()
	self:_updateNarcissusFollowOverride(deltaTime)

	if not self._target then
		return
	end

	self:_updateSpeedMultiplierFollowScale(deltaTime)

	local cameraConfig = self._cameraConfig

	if not cameraConfig.followDistance then
		local followDistanceTarget = 5.58

		if not cameraConfig.followHeight then
			local followHeightTarget = 5.25

			if not cameraConfig.lookAhead then
				local lookAheadTarget = 3

				if not cameraConfig.lookHeight then
					local lookHeightTarget = 0.6

					if not cameraConfig.rotationSharpness then
						local rotationSharpnessTarget = 22

						if not cameraConfig.baseFov then
							local baseFovTarget = 74

							if not cameraConfig.maxFov then
								local maxFov = 82
								local routeCameraConfig = self:_resolveActiveRouteCameraProfileConfig()

								if routeCameraConfig then
									followDistanceTarget = cameraConfig.followDistance + (routeCameraConfig.distance or 0)
									followHeightTarget = followHeightTarget + (routeCameraConfig.height or 0)
									lookAheadTarget = lookAheadTarget + (routeCameraConfig.lookAhead or 0)
									lookHeightTarget = lookHeightTarget + (routeCameraConfig.lookHeight or 0)
									rotationSharpnessTarget = rotationSharpnessTarget + (routeCameraConfig.rotationSharpness or 0)
									baseFovTarget = baseFovTarget + (routeCameraConfig.FOV or routeCameraConfig.fOV or 0)
								end

								if self:_isWaterfallClimbCameraActive() then
									followDistanceTarget = cameraConfig.followDistance + WaterfallClimbFollowDistanceExtra
								end

								if self._playerVehicle and self._playerVehicle.buffManager then
									local activeBuffs = self._playerVehicle.buffManager:getAllBuffs()

									for _, buff in ipairs(activeBuffs) do
										local buffCameraConfig = buff.cameraConfig

										if buffCameraConfig then
											followDistanceTarget = cameraConfig.followDistance + (buffCameraConfig.distance or 0)
											followHeightTarget = followHeightTarget + (buffCameraConfig.height or 0)
											lookAheadTarget = lookAheadTarget + (buffCameraConfig.lookAhead or 0)
											lookHeightTarget = lookHeightTarget + (buffCameraConfig.lookHeight or 0)
											rotationSharpnessTarget = rotationSharpnessTarget + (buffCameraConfig.rotationSharpness or 0)
											baseFovTarget = baseFovTarget + (buffCameraConfig.fOV or 0)
										end
									end
								end

								followDistanceTarget = math.max(0.1, cameraConfig.followDistance)
								followHeightTarget = math.max(0.1, followHeightTarget)
								lookAheadTarget = math.max(0, lookAheadTarget)

								self:_smoothProfileParams(cameraConfig.followDistance, followHeightTarget, lookAheadTarget, lookHeightTarget, rotationSharpnessTarget, baseFovTarget, deltaTime)

								local cameraFeelConfig = self._cameraFeelConfig
								local boostFovIncreaseSmoothTime = cameraFeelConfig.boostFovIncreaseSmoothTime
								local boostFovDecreaseSmoothTime = cameraFeelConfig.boostFovDecreaseSmoothTime
								local speed01 = self._playerVehicle and self._playerVehicle:getNormalizedSpeed() or 0

								self:_updateMainRoadCurveFollowScale(self:_resolveRawTargetForward(), deltaTime)

								local targetForward = self:_resolveStableTargetForward()
								local positionForward = targetForward

								if self._playerVehicle then
									local specialFollowPosition

									specialFollowPosition = self._playerVehicle.cameraUsesVerticalPositionForward

									if self._playerVehicle.cameraUsesVerticalPositionForward then
										local useVerticalPositionForward = self._playerVehicle:cameraUsesVerticalPositionForward()

										if not useVerticalPositionForward then
											_horizForwardCache.x = positionForward.x
											_horizForwardCache.y = 0
											_horizForwardCache.z = positionForward.z

											local hfSqr = _horizForwardCache.x * _horizForwardCache.x + _horizForwardCache.z * _horizForwardCache.z

											if hfSqr <= 0.001 then
												_horizForwardCache.x = targetForward.x
												_horizForwardCache.z = targetForward.z
												hfSqr = _horizForwardCache.x * _horizForwardCache.x + _horizForwardCache.z * _horizForwardCache.z
											end

											if hfSqr > 0.001 then
												local invLen = 1 / math.sqrt(hfSqr)

												_horizForwardCache.x = _horizForwardCache.x * invLen
												_horizForwardCache.z = _horizForwardCache.z * invLen
												positionForward = _horizForwardCache
											else
												positionForward = VEC3_FORWARD
											end
										end

										local boostPushTarget = self._playerVehicle and math.max(0, self._boostPushDistance) * self._playerVehicle:getBoostCameraPush01() or 0
										local newBoostPushDist, newBoostPushVel = Mathf.SmoothDamp(self._smoothedBoostPushDistance, boostPushTarget, self._boostPushVelocity, math.max(0.01, self._boostPushSmoothTime))

										self._smoothedBoostPushDistance = newBoostPushDist
										self._boostPushVelocity = newBoostPushVel

										if self._playerVehicle and self._playerVehicle.getCameraFollowPosition then
											specialFollowPosition = self._playerVehicle:getCameraFollowPosition()
										end

										local targetX, targetY, targetZ

										if specialFollowPosition then
											targetZ = specialFollowPosition.z
											targetY = specialFollowPosition.y
											targetX = specialFollowPosition.x
										else
											targetX, targetY, targetZ = transformhelper.getPos(self._target)
										end

										if self._hasFollowPosition then
											local verticalPositionModeChanged = not (self._previousUseVerticalPositionForward == nil or self._previousUseVerticalPositionForward == useVerticalPositionForward)

											if verticalPositionModeChanged then
												local goX, goY, goZ = transformhelper.getPos(self._transform)

												self._modeTransitionStartOffsetX = goX - targetX
												self._modeTransitionStartOffsetY = goY - targetY
												self._modeTransitionStartOffsetZ = goZ - targetZ
												self._modeTransitionDurationSec = 0.22
												self._modeTransitionRemainingSec = self._modeTransitionDurationSec
											end

											self._previousUseVerticalPositionForward = useVerticalPositionForward

											local totalFollowDist = self._smoothedProfileDistance + self._smoothedBoostPushDistance
											local desiredX = targetX - positionForward.x * totalFollowDist
											local desiredY = targetY - positionForward.y * totalFollowDist + self._smoothedProfileHeight
											local desiredZ = targetZ - positionForward.z * totalFollowDist

											if self._playerVehicle and self._playerVehicle.getCameraPositionOffset then
												local cameraPositionOffset = self._playerVehicle:getCameraPositionOffset()

												if cameraPositionOffset then
													local m2 = cameraPositionOffset.x * cameraPositionOffset.x + cameraPositionOffset.y * cameraPositionOffset.y + cameraPositionOffset.z * cameraPositionOffset.z

													if m2 > 0.0001 then
														desiredX = desiredX + cameraPositionOffset.x
														desiredY = desiredY + cameraPositionOffset.y
														desiredZ = desiredZ + cameraPositionOffset.z
													end
												end
											end

											local isCountdown = not V3a9RacingCarModel.instance:isRacing()
											local countdownLagDistance = 0
											local effectiveFollowSmoothTime = self:_resolveEffectiveFollowSmoothTime()

											if isCountdown and self._playerVehicle and self._playerVehicle.getCountdownForwardSpeed then
												local forwardSpeed = self._playerVehicle:getCountdownForwardSpeed()

												countdownLagDistance = forwardSpeed * effectiveFollowSmoothTime

												if forwardSpeed * effectiveFollowSmoothTime > 0.001 then
													desiredX = desiredX - positionForward.x * countdownLagDistance
													desiredY = desiredY - positionForward.y * countdownLagDistance
													desiredZ = desiredZ - positionForward.z * countdownLagDistance
												end
											end

											local baseX, baseY, baseZ

											if not self._hasFollowPosition then
												baseZ = desiredZ
												baseY = desiredY
												baseX = desiredX
												self._smoothedFollowX, self._smoothedFollowY, self._smoothedFollowZ = desiredX, desiredY, desiredZ
												self._followVelX, self._followVelY, self._followVelZ = 0, 0, 0
												self._hasFollowPosition = true
											else
												local activeDeadZone = self:_isWaterfallClimbCameraActive() and 0 or math.max(0, self._positionDeadZone)
												local followX, followY, followZ = desiredX, desiredY, desiredZ

												if activeDeadZone > 0 then
													local offX = desiredX - self._smoothedFollowX
													local offY = desiredY - self._smoothedFollowY
													local offZ = desiredZ - self._smoothedFollowZ
													local offSqr = offX * offX + offY * offY + offZ * offZ

													if offSqr <= activeDeadZone * activeDeadZone then
														followZ = self._smoothedFollowZ
														followY = self._smoothedFollowY
														followX = self._smoothedFollowX
													else
														local scale = activeDeadZone / math.sqrt(offSqr)

														followX = desiredX - offX * scale
														followY = desiredY - offY * scale
														followZ = desiredZ - offZ * scale
													end
												end

												if self._modeTransitionRemainingSec > 0 then
													local duration = math.max(0.01, self._modeTransitionDurationSec)
													local transitionT = Mathf.Clamp01(1 - self._modeTransitionRemainingSec / duration)
													local easedT = Mathf.SmoothStep(0, 1, transitionT)
													local startX = targetX + self._modeTransitionStartOffsetX
													local startY = targetY + self._modeTransitionStartOffsetY
													local startZ = targetZ + self._modeTransitionStartOffsetZ
													local controlX = (startX + followX) * 0.5
													local controlY = (startY + followY) * 0.5 + 4
													local controlZ = (startZ + followZ) * 0.5
													local aX = startX + (controlX - startX) * easedT
													local aY = startY + (controlY - startY) * easedT
													local aZ = startZ + (controlZ - startZ) * easedT
													local bX = controlX + (followX - controlX) * easedT
													local bY = controlY + (followY - controlY) * easedT
													local bZ = controlZ + (followZ - controlZ) * easedT

													baseX = aX + (bX - aX) * easedT
													baseY = aY + (bY - aY) * easedT
													baseZ = aZ + (bZ - aZ) * easedT
													self._modeTransitionRemainingSec = math.max(0, self._modeTransitionRemainingSec - deltaTime)
													self._smoothedFollowX, self._smoothedFollowY, self._smoothedFollowZ = baseX, baseY, baseZ
													self._followVelX, self._followVelY, self._followVelZ = 0, 0, 0
												else
													local smoothTime = math.max(0.01, effectiveFollowSmoothTime)

													baseX, self._followVelX = Mathf.SmoothDamp(self._smoothedFollowX, followX, self._followVelX, smoothTime)
													baseY, self._followVelY = Mathf.SmoothDamp(self._smoothedFollowY, followY, self._followVelY, smoothTime)
													baseZ, self._followVelZ = Mathf.SmoothDamp(self._smoothedFollowZ, followZ, self._followVelZ, smoothTime)
													self._smoothedFollowX, self._smoothedFollowY, self._smoothedFollowZ = baseX, baseY, baseZ
												end
											end

											self:_warnIfCameraFollowLost(baseX, baseY, baseZ, targetX, targetY, targetZ, specialFollowPosition, deltaTime)

											local lookBaseX, lookBaseY, lookBaseZ = targetX, targetY, targetZ

											if self._playerVehicle and self._playerVehicle.getCameraLookTargetPosition then
												local specialLookTargetPosition = self._playerVehicle:getCameraLookTargetPosition()

												if specialLookTargetPosition then
													lookBaseX = specialLookTargetPosition.x
													lookBaseY = specialLookTargetPosition.y
													lookBaseZ = specialLookTargetPosition.z
												end
											end

											local activeLookAheadDistance = self._smoothedProfileLookAhead
											local desiredLookX = lookBaseX + targetForward.x * activeLookAheadDistance
											local desiredLookY = lookBaseY + targetForward.y * activeLookAheadDistance + self._smoothedProfileLookHeight
											local desiredLookZ = lookBaseZ + targetForward.z * activeLookAheadDistance

											if isCountdown and countdownLagDistance > 0.001 then
												desiredLookX = desiredLookX - positionForward.x * countdownLagDistance
												desiredLookY = desiredLookY - positionForward.y * countdownLagDistance
												desiredLookZ = desiredLookZ - positionForward.z * countdownLagDistance
											end

											if not self._hasLookTarget then
												self._smoothedLookX, self._smoothedLookY, self._smoothedLookZ = desiredLookX, desiredLookY, desiredLookZ
												self._hasLookTarget = true
											else
												local effectiveLookSmoothTime = math.max(0.01, self._lookSmoothTime)

												if self:_isWaterfallClimbCameraActive() then
													effectiveLookSmoothTime = math.min(effectiveLookSmoothTime, WaterfallClimbLookSmoothTime)
												end

												self._smoothedLookX, self._lookVelX = Mathf.SmoothDamp(self._smoothedLookX, desiredLookX, self._lookVelX, effectiveLookSmoothTime)
												self._smoothedLookY, self._lookVelY = Mathf.SmoothDamp(self._smoothedLookY, desiredLookY, self._lookVelY, effectiveLookSmoothTime)
												self._smoothedLookZ, self._lookVelZ = Mathf.SmoothDamp(self._smoothedLookZ, desiredLookZ, self._lookVelZ, effectiveLookSmoothTime)
											end

											local dirX = self._smoothedLookX - baseX
											local dirY = self._smoothedLookY - baseY
											local dirZ = self._smoothedLookZ - baseZ
											local dirSqr = dirX * dirX + dirY * dirY + dirZ * dirZ

											if dirSqr > 0.001 then
												local invLen = 1 / math.sqrt(dirSqr)

												dirZ = dirZ * invLen
												dirY = dirY * invLen
												dirX = dirX * invLen

												local roll = self._playerVehicle and -self._playerVehicle:getVisualSteeringInput() * speed01 * 0.25 or 0
												local pitchDeg = -math.deg(math.asin(Mathf.Clamp(dirY, -1, 1)))
												local rawYawDeg = math.deg(math.atan2(dirX, dirZ))
												local yawDeg = rawYawDeg

												if self:_isWaterfallClimbCameraActive() then
													local yawBlend = 1 - math.exp(-WaterfallClimbYawSharpness * math.max(0, deltaTime))

													self._waterfallCameraYawDeg = Mathf.LerpAngle(self._waterfallCameraYawDeg or rawYawDeg, rawYawDeg, Mathf.Clamp01(yawBlend))
													yawDeg = self._waterfallCameraYawDeg
												else
													self._waterfallCameraYawDeg = rawYawDeg
												end

												local rotationSpeed = 1 - math.exp(-self._smoothedProfileRotationSharpness * deltaTime)

												transformhelper.setRotationLerp(self._transform, pitchDeg, yawDeg, roll, math.max(0, math.min(1, rotationSpeed)))
											end

											local framingUpOffset = math.max(0, self._framingUpOffset)

											transformhelper.setPos(self._transform, baseX, baseY + framingUpOffset, baseZ)

											if self._controlledCamera then
												local boost01 = self._playerVehicle and self._playerVehicle:getBoostCameraPush01() or 0
												local fovSmoothTime = boost01 > self._smoothedBoostFov01 and math.max(0.01, boostFovIncreaseSmoothTime) or math.max(0.01, boostFovDecreaseSmoothTime)
												local newBoostFov01, newBoostFovVel = Mathf.SmoothDamp(self._smoothedBoostFov01, boost01, self._boostFovVelocity, fovSmoothTime)

												self._smoothedBoostFov01 = newBoostFov01
												self._boostFovVelocity = newBoostFovVel

												local fov01 = Mathf.Clamp01(math.max(speed01, self._smoothedBoostFov01))

												self._controlledCamera.fieldOfView = self._smoothedProfileFov + (maxFov - self._smoothedProfileFov) * fov01
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
end

function RacingChaseCamera:_warnIfCameraFollowLost(camX, camY, camZ, targetX, targetY, targetZ, specialFollowPosition, deltaTime)
	self._followLostWarnCooldownSec = math.max(0, (self._followLostWarnCooldownSec or 0) - math.max(0, deltaTime or 0))

	if self._followLostWarnCooldownSec > 0 or gohelper.isNil(self._go) then
		return
	end

	local offX = camX - targetX
	local offY = camY - targetY
	local offZ = camZ - targetZ
	local offSqr = offX * offX + offY * offY + offZ * offZ

	if offSqr <= FollowLostWarnDistance * FollowLostWarnDistance then
		return
	end

	self._followLostWarnCooldownSec = FollowLostWarnIntervalSec

	local playerVehicle = self._playerVehicle
	local activeProfileId = playerVehicle and playerVehicle.getActiveCameraProfileId and playerVehicle:getActiveCameraProfileId() or 0
	local var_10_1 = tostring(playerVehicle and playerVehicle.isGliding and playerVehicle:isGliding() or false)
	local var_10_2 = tostring(playerVehicle and playerVehicle.isWaterfallClimbing and playerVehicle:isWaterfallClimbing() or false)

	logWarn(string.format("RacingChaseCamera follow lost: distance=%.2f, specialFollow=%s, activeProfileId=%s, glide=%s, waterfall=%s, snow=%s, underwater=%s, waterDrop=%s", math.sqrt(offSqr), specialFollowPosition and "true" or "false", tostring(activeProfileId), var_10_1, var_10_2, tostring(playerVehicle and playerVehicle.isOnSnowSlope and playerVehicle:isOnSnowSlope() or false), tostring(playerVehicle and playerVehicle.isUnderwater and playerVehicle:isUnderwater() or false), tostring(playerVehicle and playerVehicle.isAirWaterDropping and playerVehicle:isAirWaterDropping() or false)))
end

function RacingChaseCamera:_isWaterfallClimbCameraActive()
	local playerVehicle = self._playerVehicle

	if playerVehicle and playerVehicle.isWaterfallClimbCameraActive then
		return playerVehicle:isWaterfallClimbCameraActive()
	end

	local var_11_0

	if playerVehicle then
		::label_11_0::

		var_11_0 = playerVehicle.isWaterfallClimbing and playerVehicle:isWaterfallClimbing()
	end

	return var_11_0
end

function RacingChaseCamera:_isShortcutJumpCameraActive()
	local playerVehicle = self._playerVehicle
	local var_12_0

	if playerVehicle then
		::label_12_0::

		var_12_0 = playerVehicle.isShortcutJumping and playerVehicle:isShortcutJumping()
	end

	return var_12_0
end

function RacingChaseCamera:_onUltimateUsed(ultimateId, caster)
	if ultimateId ~= NarcissusUltimateId or caster ~= self._playerVehicle then
		return
	end

	self._narcissusFollowActive = true
	self._narcissusFollowElapsedSec = 0
end

function RacingChaseCamera:_updateNarcissusFollowOverride(deltaTime)
	if not self._narcissusFollowActive then
		return
	end

	self._narcissusFollowElapsedSec = self._narcissusFollowElapsedSec + math.max(0, deltaTime or 0)

	if self._narcissusFollowElapsedSec >= NarcissusSettleEndSec then
		self:_resetNarcissusFollowOverride()
	end
end

function RacingChaseCamera:_resetNarcissusFollowOverride()
	self._narcissusFollowActive = false
	self._narcissusFollowElapsedSec = 0
end

function RacingChaseCamera:_resolveNarcissusStageProgress(elapsedSec, startSec, endSec)
	local duration = math.max(0.001, endSec - startSec)
	local t = Mathf.Clamp01((elapsedSec - startSec) / duration)

	return t * t * (3 - 2 * t)
end

function RacingChaseCamera:_resolveNarcissusSmoothTime(normalSmoothTime, releaseSmoothTime, chaseSmoothTime)
	if not self._narcissusFollowActive then
		return normalSmoothTime
	end

	if not self._narcissusFollowElapsedSec then
		local elapsedSec = 0

		if elapsedSec < NarcissusReleaseEndSec then
			return releaseSmoothTime
		end

		if elapsedSec < NarcissusChaseBlendEndSec then
			local progress = self:_resolveNarcissusStageProgress(elapsedSec, NarcissusReleaseEndSec, NarcissusChaseBlendEndSec)

			return Mathf.Lerp(releaseSmoothTime, chaseSmoothTime, progress)
		end

		if elapsedSec < NarcissusChaseEndSec then
			return chaseSmoothTime
		end

		local progress = self:_resolveNarcissusStageProgress(elapsedSec, NarcissusChaseEndSec, NarcissusSettleEndSec)

		return Mathf.Lerp(chaseSmoothTime, normalSmoothTime, progress)
	end
end

function RacingChaseCamera:_resolveNarcissusFollowSmoothTime(normalSmoothTime)
	return self:_resolveNarcissusSmoothTime(normalSmoothTime, NarcissusReleaseFollowSmoothTime, NarcissusChaseFollowSmoothTime)
end

function RacingChaseCamera:_resolveNarcissusTargetYawSmoothTime(normalSmoothTime)
	return self:_resolveNarcissusSmoothTime(normalSmoothTime, NarcissusReleaseYawSmoothTime, NarcissusChaseYawSmoothTime)
end

function RacingChaseCamera:_resolveEffectiveFollowSmoothTime()
	local followSmoothTime = math.max(0.01, self._followSmoothTime)

	if self:_isWaterfallClimbCameraActive() then
		local normalSmoothTime = math.min(followSmoothTime, WaterfallClimbFollowSmoothTime)

		return self:_resolveNarcissusFollowSmoothTime(normalSmoothTime)
	end

	if self:_isShortcutJumpCameraActive() then
		local normalSmoothTime = math.min(followSmoothTime, ShortcutJumpFollowSmoothTime)

		return self:_resolveNarcissusFollowSmoothTime(normalSmoothTime)
	end

	local normalSmoothTime = self:_resolveSpeedScaledSmoothTime(followSmoothTime) / math.max(1, self._mainRoadCurveFollowScale or 1)

	return self:_resolveNarcissusFollowSmoothTime(normalSmoothTime)
end

function RacingChaseCamera:_resolveEffectiveTargetYawSmoothTime()
	local targetYawSmoothTime = math.max(0.01, self._targetYawSmoothTime)

	if self:_isShortcutJumpCameraActive() then
		return self:_resolveNarcissusTargetYawSmoothTime(ShortcutJumpTargetYawSmoothTime)
	end

	local normalSmoothTime = self:_resolveSpeedScaledSmoothTime(targetYawSmoothTime) / math.max(1, self._mainRoadCurveFollowScale or 1)

	return self:_resolveNarcissusTargetYawSmoothTime(normalSmoothTime)
end

function RacingChaseCamera:_resolveSpeedMultiplierFollowScaleTarget()
	local playerVehicle = self._playerVehicle

	if not playerVehicle or not playerVehicle.getAttrValue or not RacingCarPropEnum or not RacingCarPropEnum.RacingParamId then
		return 1
	end

	local totalBase, totalRatio = playerVehicle:getAttrValue(RacingCarPropEnum.RacingParamId.SpeedMultiplier, playerVehicle._lossFactor)
	local speedMultiplier = (1 + (totalBase or 0)) * (1 + (totalRatio or 0))

	if speedMultiplier <= 1 then
		return 1
	end

	local extraSpeedMultiplier = math.max(0, speedMultiplier - 1)

	return 1 + extraSpeedMultiplier * SpeedMultiplierFollowSmoothFactor
end

function RacingChaseCamera:_updateSpeedMultiplierFollowScale(deltaTime)
	local targetScale = self:_resolveSpeedMultiplierFollowScaleTarget()
	local currentScale = math.max(1, (not self._smoothedSpeedMultiplierFollowScale or nil) and 1)

	if currentScale < targetScale then
		if not SpeedMultiplierFollowScaleEnterSmoothTime then
			local smoothTime = SpeedMultiplierFollowScaleExitSmoothTime

			self._smoothedSpeedMultiplierFollowScale, self._speedMultiplierFollowScaleVelocity = Mathf.SmoothDamp(currentScale, targetScale, self._speedMultiplierFollowScaleVelocity or 0, smoothTime, math.huge, math.max(0, deltaTime or 0))
		end
	end
end

function RacingChaseCamera:_resolveSpeedScaledSmoothTime(baseSmoothTime)
	local smoothTime = math.max(0.01, baseSmoothTime or 0.01)
	local followSmoothScale = math.max(1, (not self._smoothedSpeedMultiplierFollowScale or nil) and 1)

	return math.max(0.05, math.min(smoothTime, smoothTime / followSmoothScale))
end

function RacingChaseCamera:_ensureInitialized()
	if not self._initialized then
		self:initialize()
	end
end

function RacingChaseCamera:_resetFollowState()
	self._followVelX, self._followVelY, self._followVelZ = 0, 0, 0
	self._lookVelX, self._lookVelY, self._lookVelZ = 0, 0, 0
	self._targetForwardVelX, self._targetForwardVelY, self._targetForwardVelZ = 0, 0, 0
	self._smoothedBoostPushDistance = 0
	self._boostPushVelocity = 0
	self._smoothedBoostFov01 = 0
	self._boostFovVelocity = 0
	self._mainRoadCurveTurn01 = 0
	self._mainRoadCurveTurnVelocity = 0
	self._mainRoadCurveFollowScale = 1
	self._smoothedSpeedMultiplierFollowScale = 1
	self._speedMultiplierFollowScaleVelocity = 0
	self._lastMainRoadCurveForwardX = nil
	self._lastMainRoadCurveForwardY = nil
	self._lastMainRoadCurveForwardZ = nil
	self._hasFollowPosition = false
	self._hasLookTarget = false
	self._hasForwardTarget = false
	self._waterfallCameraYawDeg = nil
	self._previousUseVerticalPositionForward = nil
	self._modeTransitionStartOffsetX = 0
	self._modeTransitionStartOffsetY = 0
	self._modeTransitionStartOffsetZ = 0
	self._modeTransitionDurationSec = 0
	self._modeTransitionRemainingSec = 0
end

function RacingChaseCamera:_updateMainRoadCurveFollowScale(currentForward, deltaTime)
	if not currentForward or currentForward.sqrMagnitude <= 0.001 then
		self:_fadeOutMainRoadCurveFollowScale(deltaTime)

		return
	end

	local forward = currentForward
	local shouldTighten = self:_canApplyMainRoadCurveFollowTighten()
	local rawTurn01 = 0

	if shouldTighten and self._lastMainRoadCurveForwardX then
		local dot = self._lastMainRoadCurveForwardX * forward.x + self._lastMainRoadCurveForwardY * forward.y + self._lastMainRoadCurveForwardZ * forward.z

		dot = math.max(-1, math.min(1, dot))

		local turnAngleDeg = math.deg(math.acos(dot))

		rawTurn01 = Mathf.Clamp01((turnAngleDeg - MainRoadCurveTurnDeadZoneDeg) / math.max(0.001, MainRoadCurveTurnActiveRangeDeg))
	end

	if (self._mainRoadCurveTurn01 or 0) < rawTurn01 then
		if not MainRoadCurveFadeInSmoothTime then
			local smoothTime = MainRoadCurveFadeOutSmoothTime
			local newTurn01, newVelocity = Mathf.SmoothDamp(self._mainRoadCurveTurn01 or 0, rawTurn01, self._mainRoadCurveTurnVelocity or 0, math.max(0.01, smoothTime), math.huge, deltaTime)

			self._mainRoadCurveTurn01 = Mathf.Clamp01(newTurn01)
			self._mainRoadCurveTurnVelocity = newVelocity
			self._mainRoadCurveFollowScale = 1 + (math.max(1, MainRoadCurveFollowScaleMax) - 1) * self._mainRoadCurveTurn01
			self._lastMainRoadCurveForwardX = forward.x
			self._lastMainRoadCurveForwardY = forward.y
			self._lastMainRoadCurveForwardZ = forward.z
		end
	end
end

function RacingChaseCamera:_fadeOutMainRoadCurveFollowScale(deltaTime)
	local newTurn01, newVelocity = Mathf.SmoothDamp(self._mainRoadCurveTurn01 or 0, 0, self._mainRoadCurveTurnVelocity or 0, math.max(0.01, MainRoadCurveFadeOutSmoothTime), math.huge, deltaTime)

	self._mainRoadCurveTurn01 = Mathf.Clamp01(newTurn01)
	self._mainRoadCurveTurnVelocity = newVelocity
	self._mainRoadCurveFollowScale = 1 + (math.max(1, MainRoadCurveFollowScaleMax) - 1) * self._mainRoadCurveTurn01
	self._lastMainRoadCurveForwardX = nil
	self._lastMainRoadCurveForwardY = nil
	self._lastMainRoadCurveForwardZ = nil
end

function RacingChaseCamera:_canApplyMainRoadCurveFollowTighten()
	local playerVehicle = self._playerVehicle

	if not playerVehicle or self:_isWaterfallClimbCameraActive() or self:_isShortcutJumpCameraActive() then
		return false
	end

	if not V3a9RacingCarModel.instance:isRacing() then
		return false
	end

	if playerVehicle._canTightenTrackForwardFollowBySpeed then
		return playerVehicle:_canTightenTrackForwardFollowBySpeed()
	end

	return false
end

function RacingChaseCamera:_resolveRawTargetForward()
	if not self._target then
		_rawForwardResult.x = 0
		_rawForwardResult.y = 0
		_rawForwardResult.z = 1

		return _rawForwardResult
	end

	local forward = self._playerVehicle and self._playerVehicle:getCameraForward() or self._target.forward
	local var_30_0 = self._playerVehicle

	if self._playerVehicle then
		var_30_0 = self._playerVehicle.cameraUsesVerticalForward

		if self._playerVehicle.cameraUsesVerticalForward then
			local useVerticalForward = self._playerVehicle:cameraUsesVerticalForward()
			local x = forward.x

			if useVerticalForward then
				if not forward.y then
					local y = 0
					local z = forward.z
					local sqrMagnitude = x * x + y * y + z * z

					if sqrMagnitude <= 0.001 then
						_rawForwardResult.x = 0
						_rawForwardResult.y = 0
						_rawForwardResult.z = 1

						return _rawForwardResult
					end

					local invLen = 1 / math.sqrt(sqrMagnitude)

					_rawForwardResult.x = x * invLen
					_rawForwardResult.y = y * invLen
					_rawForwardResult.z = z * invLen

					return _rawForwardResult
				end
			end
		end
	end
end

function RacingChaseCamera:_resolveStableTargetForward()
	if not self._target then
		return VEC3_FORWARD
	end

	local forward = self._playerVehicle and self._playerVehicle:getCameraForward() or self._target.forward
	local var_31_0 = self._playerVehicle

	if self._playerVehicle then
		var_31_0 = self._playerVehicle.cameraUsesVerticalForward

		if self._playerVehicle.cameraUsesVerticalForward then
			local useVerticalForward = self._playerVehicle:cameraUsesVerticalForward()
			local fx, fy, fz = forward.x, forward.y, forward.z

			if not useVerticalForward then
				local fSqr = fx * fx + fz * fz

				if fSqr <= 0.001 then
					return VEC3_FORWARD
				end

				local invLen = 1 / math.sqrt(fSqr)

				fz = fz * invLen
				fy = 0
				fx = fx * invLen
			elseif fx * fx + fy * fy + fz * fz <= 0.001 then
				return VEC3_FORWARD
			end

			if not self._hasForwardTarget then
				self._smoothedTargetForwardX, self._smoothedTargetForwardY, self._smoothedTargetForwardZ = fx, fy, fz
				self._hasForwardTarget = true
				_stableForwardResult.x, _stableForwardResult.y, _stableForwardResult.z = fx, fy, fz

				return _stableForwardResult
			end

			local smoothTime = self:_resolveEffectiveTargetYawSmoothTime()

			self._smoothedTargetForwardX, self._targetForwardVelX = Mathf.SmoothDamp(self._smoothedTargetForwardX, fx, self._targetForwardVelX, smoothTime)
			self._smoothedTargetForwardY, self._targetForwardVelY = Mathf.SmoothDamp(self._smoothedTargetForwardY, fy, self._targetForwardVelY, smoothTime)
			self._smoothedTargetForwardZ, self._targetForwardVelZ = Mathf.SmoothDamp(self._smoothedTargetForwardZ, fz, self._targetForwardVelZ, smoothTime)

			local sx, sy, sz = self._smoothedTargetForwardX, self._smoothedTargetForwardY, self._smoothedTargetForwardZ

			if sx * sx + sy * sy + sz * sz <= 0.001 then
				sz = fz
				sy = fy
				sx = fx
				self._smoothedTargetForwardX, self._smoothedTargetForwardY, self._smoothedTargetForwardZ = fx, fy, fz
			end

			if not useVerticalForward then
				sy = 0
				self._smoothedTargetForwardY = 0
			end

			local sfSqr = sx * sx + sy * sy + sz * sz

			if sfSqr > 0.001 then
				local invLen = 1 / math.sqrt(sfSqr)

				_stableForwardResult.x = sx * invLen
				_stableForwardResult.y = sy * invLen
				_stableForwardResult.z = sz * invLen
			else
				_stableForwardResult.x = 0
				_stableForwardResult.y = 0
				_stableForwardResult.z = 1
			end

			return _stableForwardResult
		end
	end
end

function RacingChaseCamera:_subscribeToVehicle()
	if not self._playerVehicle or self._subscribedVehicle == self._playerVehicle then
		return
	end

	self:_unsubscribeFromVehicle()

	self._subscribedVehicle = self._playerVehicle
end

function RacingChaseCamera:_unsubscribeFromVehicle()
	self._subscribedVehicle = nil
end

function RacingChaseCamera:_resolveActiveRouteCameraProfileConfig()
	local playerVehicle = self._playerVehicle

	if not playerVehicle or not playerVehicle.getActiveCameraProfileId then
		return nil
	end

	local profileId = playerVehicle:getActiveCameraProfileId()

	if not profileId or profileId <= 0 then
		return nil
	end

	if self._runtimeConfig then
		local cameraProfiles = self._runtimeConfig.cameraProfiles

		if not cameraProfiles then
			return nil
		end

		for _, profile in ipairs(cameraProfiles) do
			if profile and tonumber(profile.id) == tonumber(profileId) then
				return profile
			end
		end

		return nil
	end
end

function RacingChaseCamera:_smoothProfileParams(distance, height, lookAhead, lookHeight, rotationSharpness, fov, deltaTime)
	if not self._hasSmoothedProfileParams then
		self._smoothedProfileDistance = distance
		self._smoothedProfileHeight = height
		self._smoothedProfileLookAhead = lookAhead
		self._smoothedProfileLookHeight = lookHeight
		self._smoothedProfileRotationSharpness = rotationSharpness
		self._smoothedProfileFov = fov
		self._hasSmoothedProfileParams = true

		return
	end

	if self._cameraFeelConfig then
		local smoothTime = math.max(0.03, math.min(0.75, self._cameraFeelConfig.profileSmoothTime or 0.18))

		self._smoothedProfileDistance, self._profileDistanceVelocity = Mathf.SmoothDamp(self._smoothedProfileDistance, distance, self._profileDistanceVelocity, smoothTime, math.huge, deltaTime)
		self._smoothedProfileHeight, self._profileHeightVelocity = Mathf.SmoothDamp(self._smoothedProfileHeight, height, self._profileHeightVelocity, smoothTime, math.huge, deltaTime)
		self._smoothedProfileLookAhead, self._profileLookAheadVelocity = Mathf.SmoothDamp(self._smoothedProfileLookAhead, lookAhead, self._profileLookAheadVelocity, smoothTime, math.huge, deltaTime)
		self._smoothedProfileLookHeight, self._profileLookHeightVelocity = Mathf.SmoothDamp(self._smoothedProfileLookHeight, lookHeight, self._profileLookHeightVelocity, smoothTime, math.huge, deltaTime)
		self._smoothedProfileRotationSharpness, self._profileRotationSharpnessVelocity = Mathf.SmoothDamp(self._smoothedProfileRotationSharpness, rotationSharpness, self._profileRotationSharpnessVelocity, smoothTime, math.huge, deltaTime)
		self._smoothedProfileFov, self._profileFovVelocity = Mathf.SmoothDamp(self._smoothedProfileFov, fov, self._profileFovVelocity, smoothTime, math.huge, deltaTime)
	end
end

function RacingChaseCamera:_applyCameraFeelConfig(config)
	if not config then
		return
	end

	if config.followSmoothTime and config.followSmoothTime > 0 then
		self._followSmoothTime = config.followSmoothTime or self._followSmoothTime
	end

	if config.lookSmoothTime and config.lookSmoothTime > 0 then
		self._lookSmoothTime = config.lookSmoothTime or self._lookSmoothTime
	end

	if config.targetYawSmoothTime and config.targetYawSmoothTime > 0 then
		self._targetYawSmoothTime = config.targetYawSmoothTime or self._targetYawSmoothTime
	end

	if config.positionDeadZone and config.positionDeadZone >= 0 then
		self._positionDeadZone = config.positionDeadZone or self._positionDeadZone
	end

	if config.lookAheadDistance and config.lookAheadDistance > 0 then
		self._lookAheadDistance = config.lookAheadDistance or self._lookAheadDistance
	end

	if config.minimumLookAheadDistance and config.minimumLookAheadDistance > 0 then
		self._minimumLookAheadDistance = config.minimumLookAheadDistance or self._minimumLookAheadDistance
	end

	if config.framingUpOffset and config.framingUpOffset >= 0 then
		self._framingUpOffset = config.framingUpOffset or self._framingUpOffset
	end

	if config.boostPushDistance and config.boostPushDistance >= 0 then
		self._boostPushDistance = config.boostPushDistance or self._boostPushDistance
	end

	if config.boostPushSmoothTime and config.boostPushSmoothTime > 0 then
		self._boostPushSmoothTime = config.boostPushSmoothTime or self._boostPushSmoothTime
	end

	if config.boostFovIncreaseSmoothTime and config.boostFovIncreaseSmoothTime > 0 then
		self._boostFovIncreaseSmoothTime = config.boostFovIncreaseSmoothTime or self._boostFovIncreaseSmoothTime
	end

	if config.boostFovDecreaseSmoothTime and config.boostFovDecreaseSmoothTime > 0 then
		self._boostFovDecreaseSmoothTime = config.boostFovDecreaseSmoothTime or self._boostFovDecreaseSmoothTime
	end
end

function RacingChaseCamera:_handleCollisionSlowdownApplied(_)
	self._collisionShakeRemainingSec = math.max(self._collisionShakeRemainingSec, self._collisionShakeDurationSec)
	self._ultimateShakeSeed = UnityEngine.Random.value * 100
end

function RacingChaseCamera:onDestroy()
	V3a9RacingCarController.instance:unregisterCallback(V3a9RacingCarEvent.OnUltimateUsed, self._onUltimateUsed, self)
	self:_resetNarcissusFollowOverride()
	self:_unsubscribeFromVehicle()

	self._go = nil
	self._transform = nil
	self._controlledCamera = nil
	self._playerVehicle = nil
	self._target = nil
	self._runtimeConfig = nil
	self._cameraConfig = nil
	self._cameraFeelConfig = nil
end

function RacingChaseCamera:getCameraConfig()
	return self._cameraConfig
end

function RacingChaseCamera:getCameraFeelConfig()
	return self._cameraFeelConfig
end

function RacingChaseCamera:getRuntimeConfig()
	return self._runtimeConfig
end

function RacingChaseCamera:getTarget()
	return self._target
end

function RacingChaseCamera:getPlayerVehicle()
	return self._playerVehicle
end

function RacingChaseCamera:getControlledCamera()
	return self._controlledCamera
end

function RacingChaseCamera:isInitialized()
	return self._initialized
end

function RacingChaseCamera:resetForRestart()
	self:_resetNarcissusFollowOverride()
	self:_resetFollowState()

	self._smoothedFollowX, self._smoothedFollowY, self._smoothedFollowZ = 0, 0, 0
	self._smoothedLookX, self._smoothedLookY, self._smoothedLookZ = 0, 0, 0
	self._smoothedTargetForwardX, self._smoothedTargetForwardY, self._smoothedTargetForwardZ = 0, 0, 1
	self._hasSmoothedProfileParams = false
	self._profileDistanceVelocity = 0
	self._profileHeightVelocity = 0
	self._profileLookAheadVelocity = 0
	self._profileLookHeightVelocity = 0
	self._profileRotationSharpnessVelocity = 0
	self._profileFovVelocity = 0
end

return RacingChaseCamera
