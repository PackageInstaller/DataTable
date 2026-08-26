-- chunkname: @modules/logic/versionactivity3_9/racingcar/logic/RacingVehicleControllerBase.lua

module("modules.logic.versionactivity3_9.racingcar.logic.RacingVehicleControllerBase", package.seeall)

local RacingVehicleControllerBase = class("RacingVehicleControllerBase", LuaCompBase)
local ShortcutJumpMinForwardDistance = 12
local ShortcutJumpLandingSinkDepth = 0.3
local ShortcutJumpLandingSinkStart01 = 0.72
local ShortcutJumpCurveA1 = 2.202249550307798
local ShortcutJumpCurveA2 = -3.548013612164279
local ShortcutJumpCurveA3 = 4.784722946847433
local ShortcutJumpCurveA4 = -3.510705315549726
local ShortcutJumpCurveA5 = 1.071746430558772
local BuffAnimLayerIndex = 1
local BuffAnimExitDurationSec = 0.67
local NarcissusAppearNormalizedTime = 0.7
local BuffAnimStateHashes = {
	white = {
		start = UnityEngine.Animator.StringToHash("New Layer.hide_start_white"),
		exit = UnityEngine.Animator.StringToHash("New Layer.hide_end_white")
	},
	orange = {
		start = UnityEngine.Animator.StringToHash("New Layer.hide_start_orange"),
		exit = UnityEngine.Animator.StringToHash("New Layer.hide_end_orange")
	}
}

function RacingVehicleControllerBase:init(go)
	self._haitunGo = gohelper.findChild(go, "anim/v3a9_racing_games_haitun")
	self._buffAnimEffectGo = gohelper.findChild(go, "anim/v3a9_racing_games_haitun_effect")

	local animGo = gohelper.findChild(go, "anim")

	self._animator = animGo and animGo:GetComponent("Animator")
	self._curBuffAnimName = nil
	self._curBuffAnimInstanceId = nil
	self._buffAnimExitInstanceId = nil
	self._narcissusTeleportActive = false
	self._narcissusTeleportHidden = false

	self:_setBuffAnimVisualActive(false)
end

function RacingVehicleControllerBase:getRacerConfig()
	return self._racerConfig
end

function RacingVehicleControllerBase:initRacerConfig(config)
	self._racerConfig = config
	self._lossFactor = tonumber(lua_racing_const.configDict[13920][1001].value)
	self._laneSwitchInputThreshold = tonumber(lua_racing_const.configDict[13920][1002].value)
	self._laneSwitchSpeed = tonumber(lua_racing_const.configDict[13920][1003].value)

	local ultimateId = self._racerConfig.ultimateId
	local ultimateConfig = ultimateId and lua_racing_ultimate.configDict[ultimateId]

	if ultimateConfig and not string.nilorempty(ultimateConfig.energyType) then
		local typeParamList = string.split(ultimateConfig.energyType, "#")
		local ultimateType = tonumber(typeParamList[1])
		local ultimateCostEnergy, ultimateEndRemoveBuff

		if ultimateType == RacingCarPropEnum.UltimateEnergyType.PerSecond then
			ultimateCostEnergy = tonumber(typeParamList[2]) or ultimateConfig.energy
			ultimateEndRemoveBuff = string.splitToNumber(typeParamList[3], ",")
		elseif ultimateType == RacingCarPropEnum.UltimateEnergyType.Segmentation then
			ultimateCostEnergy = tonumber(typeParamList[3]) or ultimateConfig.energy
		elseif ultimateType == RacingCarPropEnum.UltimateEnergyType.All then
			ultimateCostEnergy = ultimateConfig.energy
		end

		self._ultimateParams = {
			ultimateType = ultimateType,
			ultimateConfig = ultimateConfig,
			ultimateCostEnergy = ultimateCostEnergy,
			ultimateEndRemoveBuff = ultimateEndRemoveBuff
		}

		self:setAttributeLimit(RacingCarPropEnum.RacingParamId.UltimateEnergy, 0, ultimateConfig.energy)
	else
		logError("ultimateConfig is nil racerId:", self._racerConfig.id)
	end
end

function RacingVehicleControllerBase:getUltimateParams()
	return self._ultimateParams
end

function RacingVehicleControllerBase:_initVehicleBase(racerId)
	self._racerId = racerId
	self._forwardSpeed = 0
	self._currentSpeedAddValue = 0
	self._currentSpeedRatioValue = 0
	self._baseSpeed3 = 0
	self._accelerated2 = 0
	self._penetrateSpeedMulAdd = 0
	self._penetrateAccelAdd = 0
	self._invulnerabilityRemainingSec = 0
	self._attrModifiers = {}
	self._buffAttrModifiers = {}
	self._attrLimits = {}
	self._isInvisible = 0
	self._coinAbsorbRadius = 0
	self._isMoveRestricted = false
	self._isHidden = false
	self._penetrateActive = false
	self.buffManager = RacingCarBuffManager.New(self)

	self:_initShortcutJumpState()

	self._vehiclePresentation = nil
end

function RacingVehicleControllerBase:_initShortcutJumpState()
	self._shortcutJumpRemainingSec = 0
	self._shortcutJumpDurationSec = 0
	self._shortcutJumpStartDistance = 0
	self._shortcutJumpTargetDistance = 0
	self._shortcutJumpStartLateral = 0
	self._shortcutJumpTargetLateral = 0
	self._shortcutJumpHeight = 0
	self._shortcutJumpSpeedMultiplier = 1
	self._shortcutJumpTakeoffY = 0
	self._shortcutJumpTakeoffXZ = {
		x = 0,
		z = 0
	}
	self._shortcutJumpLandingXZ = {
		x = 0,
		z = 0
	}
	self._shortcutJumpTakeoffForward = {
		x = 0,
		z = 0
	}
end

function RacingVehicleControllerBase:_registerToSkillManager()
	if self._racerId == nil then
		return
	end

	RacingCarSkillManager.instance:registerRacer(self._racerId, self)
end

function RacingVehicleControllerBase:_unregisterFromSkillManager()
	if self._racerId == nil then
		return
	end

	RacingCarSkillManager.instance:unregisterRacer(self._racerId)
end

function RacingVehicleControllerBase:updateBuffs(deltaTime)
	if self.buffManager then
		self.buffManager:update(deltaTime)
	end
end

function RacingVehicleControllerBase:addBuff(buffId)
	if self.buffManager then
		return self.buffManager:addBuffById(buffId)
	end
end

function RacingVehicleControllerBase:clearBuffs()
	if self.buffManager then
		self.buffManager:clearAll()
	end

	self._attrModifiers = {}
	self._buffAttrModifiers = {}
	self._isInvisible = 0
	self._coinAbsorbRadius = 0
	self._penetrateActive = false
	self._penetrateSpeedMulAdd = 0
	self._penetrateAccelAdd = 0
end

function RacingVehicleControllerBase:_resetVehicleBaseForRestart()
	if self._isMoveRestricted then
		self:setMoveEnabled(true)
	end

	if self._isHidden then
		self:setHide(false)
	end

	self._penetrateActive = false
	self._penetrateSpeedMulAdd = 0
	self._penetrateAccelAdd = 0
	self._currentSpeedAddValue = 0
	self._currentSpeedRatioValue = 0
	self._baseSpeed3 = 0
	self._accelerated2 = 0

	self:resetBuffAnimPresentation()
end

function RacingVehicleControllerBase:modifyAttribute(paramId, baseValue, ratio, buffInstanceId, isRemove)
	if not paramId then
		return
	end

	if SLFramework.FrameworkSettings.IsEditor and paramId == RacingCarPropEnum.RacingParamId.UltimateEnergy then
		-- block empty
	end

	if paramId == RacingCarPropEnum.RacingParamId.CurrentSpeed then
		if not isRemove then
			self._currentSpeedAddValue = self._currentSpeedAddValue + baseValue
			self._currentSpeedRatioValue = self._currentSpeedRatioValue + ratio
		end

		return
	end

	if paramId == RacingCarPropEnum.RacingParamId.BaseSpeed3 then
		if (baseValue or 0) > 0 then
			self._baseSpeed3 = self._baseSpeed3 + baseValue
		end

		return
	end

	if paramId == RacingCarPropEnum.RacingParamId.Accelerated2 then
		if (baseValue or 0) > 0 then
			self._accelerated2 = self._accelerated2 + baseValue
		end

		return
	end

	if buffInstanceId then
		local buffModifiers = self._buffAttrModifiers[buffInstanceId]

		if not buffModifiers then
			buffModifiers = {}
			self._buffAttrModifiers[buffInstanceId] = buffModifiers
		end

		local modifier = buffModifiers[paramId]

		if not modifier then
			modifier = {
				ratio = 0,
				base = 0
			}
			buffModifiers[paramId] = modifier
		end

		modifier.base = modifier.base + (baseValue or 0)
		modifier.ratio = modifier.ratio + (ratio or 0)

		if modifier.base == 0 and modifier.ratio == 0 then
			buffModifiers[paramId] = nil

			if next(buffModifiers) == nil then
				self._buffAttrModifiers[buffInstanceId] = nil
			end
		end
	else
		local modifier = self._attrModifiers[paramId]

		if not modifier then
			modifier = {
				ratio = 0,
				base = 0
			}
			self._attrModifiers[paramId] = modifier
		end

		modifier.base = modifier.base + (baseValue or 0)
		modifier.ratio = modifier.ratio + (ratio or 0)

		local limits = self._attrLimits[paramId]

		if limits then
			if limits.min ~= nil then
				modifier.base = math.max(modifier.base, limits.min)
			end

			if limits.max ~= nil then
				modifier.base = math.min(modifier.base, limits.max)
			end
		end
	end
end

function RacingVehicleControllerBase:setAttributeLimit(paramId, minValue, maxValue)
	if not paramId then
		return
	end

	local limits = self._attrLimits[paramId]

	if not limits then
		limits = {}
		self._attrLimits[paramId] = limits
	end

	limits.min = minValue
	limits.max = maxValue

	local modifier = self._attrModifiers[paramId]

	if modifier then
		if minValue ~= nil then
			modifier.base = math.max(modifier.base, minValue)
		end

		if maxValue ~= nil then
			modifier.base = math.min(modifier.base, maxValue)
		end
	end
end

function RacingVehicleControllerBase:setAttribute(paramId, baseValue, ratio)
	if not paramId then
		return
	end

	if paramId == RacingCarPropEnum.RacingParamId.BaseSpeed3 then
		self._baseSpeed3 = baseValue

		return
	end

	if paramId == RacingCarPropEnum.RacingParamId.Accelerated2 then
		self._accelerated2 = baseValue

		return
	end

	logError("RacingVehicleControllerBase:setAttribute: paramId is invalid paramId:", tostring(paramId))
end

function RacingVehicleControllerBase:resetAttribute(paramId)
	local modifier = self._attrModifiers[paramId]

	if modifier then
		self:modifyAttribute(paramId, -modifier.base, -modifier.ratio)
	end

	for buffInstanceId, buffModifiers in pairs(self._buffAttrModifiers) do
		local buffModifier = buffModifiers[paramId]

		if buffModifier then
			self:modifyAttribute(paramId, -buffModifier.base, -buffModifier.ratio, buffInstanceId)
		end
	end
end

function RacingVehicleControllerBase:getAttrValue(paramId)
	local totalBase = 0
	local totalRatio = 0
	local skillModifier = self._attrModifiers[paramId]

	if skillModifier then
		local base = skillModifier.base

		totalBase = totalBase + base
		totalRatio = totalRatio + skillModifier.ratio
	end

	for _, buffModifiers in pairs(self._buffAttrModifiers) do
		local buffModifier = buffModifiers[paramId]

		if buffModifier then
			local base = buffModifier.base

			totalBase = totalBase + base
			totalRatio = totalRatio + buffModifier.ratio
		end
	end

	return totalBase, totalRatio
end

function RacingVehicleControllerBase:getSpecialAttrValue(paramId, lossFactor)
	local totalBase = 0
	local totalRatio = 0
	local maxRatio = 0
	local maxAbsRatio = 0

	for _, buffModifiers in pairs(self._buffAttrModifiers) do
		local buffModifier = buffModifiers[paramId]

		if buffModifier then
			totalBase = totalBase + buffModifier.base

			local r = buffModifier.ratio

			totalRatio = totalRatio + r

			local absR = math.abs(r)

			if maxAbsRatio < absR then
				maxAbsRatio = absR
				maxRatio = r
			end
		end
	end

	if self._currentSpeedRatioValue ~= 0 then
		local speedRatio = self._currentSpeedRatioValue

		self._currentSpeedRatioValue = 0
		totalRatio = totalRatio + speedRatio

		local absSpeedRatio = math.abs(speedRatio)

		if maxAbsRatio < absSpeedRatio then
			maxRatio = speedRatio
		end
	end

	totalRatio = maxRatio + lossFactor * (totalRatio - maxRatio)

	return totalBase, totalRatio
end

function RacingVehicleControllerBase:setInvisible(visible)
	self._isInvisible = self._isInvisible + (visible and 1 or -1)
end

function RacingVehicleControllerBase:getIsInvisible()
	return self._isInvisible > 0
end

function RacingVehicleControllerBase:setCoinAbsorbRadius(radius)
	self._coinAbsorbRadius = math.max(0, radius or 0)
end

function RacingVehicleControllerBase:getCoinAbsorbRadius()
	return self._coinAbsorbRadius
end

function RacingVehicleControllerBase:setMoveEnabled(enabled)
	self._isMoveRestricted = not enabled
end

function RacingVehicleControllerBase:getIsMoveRestricted()
	return self._isMoveRestricted
end

function RacingVehicleControllerBase:setHide(hidden)
	self._isHidden = not not hidden

	if self._haitunGo then
		-- block empty
	else
		logError("RacingVehicleControllerBase:setHide: _haitunGo is nil")
	end
end

function RacingVehicleControllerBase:getIsHidden()
	return self._isHidden
end

function RacingVehicleControllerBase:setPenetrateActive(active)
	self._penetrateActive = not not active
end

function RacingVehicleControllerBase:getIsPenetrateActive()
	return self._penetrateActive
end

function RacingVehicleControllerBase:onPenetrateTrigger(totalSpeedMul, totalAccel)
	self._penetrateSpeedMulAdd = self._penetrateSpeedMulAdd + (totalSpeedMul or 0)
	self._penetrateAccelAdd = self._penetrateAccelAdd + (totalAccel or 0)
end

function RacingVehicleControllerBase:playBuffAnim(animName, buffInstanceId)
	local stateHashes = BuffAnimStateHashes[animName]

	if not stateHashes or not self:_canPlayBuffAnimState(stateHashes.start) then
		return
	end

	TaskDispatcher.cancelTask(self._finishBuffAnimExit, self)

	self._curBuffAnimName = animName
	self._curBuffAnimInstanceId = buffInstanceId
	self._buffAnimExitInstanceId = nil

	self:_setBuffAnimVisualActive(true)
	self:_playBuffAnimState(stateHashes.start)
end

function RacingVehicleControllerBase:stopBuffAnim(animName, buffInstanceId)
	if self._curBuffAnimName ~= animName or self._curBuffAnimInstanceId ~= buffInstanceId then
		return
	end

	local stateHashes = BuffAnimStateHashes[animName]

	self._curBuffAnimName = nil
	self._curBuffAnimInstanceId = nil

	if not stateHashes or not self:_canPlayBuffAnimState(stateHashes.exit) then
		self:resetBuffAnimPresentation()

		return
	end

	self._buffAnimExitInstanceId = buffInstanceId

	self:_playBuffAnimState(stateHashes.exit)
	TaskDispatcher.cancelTask(self._finishBuffAnimExit, self)
	TaskDispatcher.runDelay(self._finishBuffAnimExit, self, BuffAnimExitDurationSec)
end

function RacingVehicleControllerBase:isBuffAnimPresentationActive()
	return self._curBuffAnimInstanceId ~= nil or self._buffAnimExitInstanceId ~= nil
end

function RacingVehicleControllerBase:_canPlayBuffAnimState(stateHash)
	return not gohelper.isNil(self._animator) and self._animator:HasState(BuffAnimLayerIndex, stateHash)
end

function RacingVehicleControllerBase:_playBuffAnimState(stateHash, normalizedTime)
	self._animator.enabled = true

	self._animator:Play(stateHash, BuffAnimLayerIndex, normalizedTime or 0)
	self._animator:Update(0)
end

function RacingVehicleControllerBase:playNarcissusTeleportDisappear()
	local stateHash = BuffAnimStateHashes.white.start

	if not self:_canPlayBuffAnimState(stateHash) then
		return false
	end

	self._narcissusTeleportActive = true
	self._narcissusTeleportHidden = false

	self:_setBuffAnimVisualActive(true)
	self:_playBuffAnimState(stateHash)

	return true
end

function RacingVehicleControllerBase:setNarcissusTeleportHidden()
	if not self._narcissusTeleportActive then
		return
	end

	self._narcissusTeleportHidden = true

	if not gohelper.isNil(self._haitunGo) then
		gohelper.setActive(self._haitunGo, false)
	end

	if not gohelper.isNil(self._buffAnimEffectGo) then
		gohelper.setActive(self._buffAnimEffectGo, false)
	end
end

function RacingVehicleControllerBase:playNarcissusTeleportAppear()
	if not self._narcissusTeleportActive then
		return
	end

	local stateHash = BuffAnimStateHashes.white.exit

	self._narcissusTeleportHidden = false

	self:_setBuffAnimVisualActive(true)

	if self:_canPlayBuffAnimState(stateHash) then
		self:_playBuffAnimState(stateHash, NarcissusAppearNormalizedTime)
	end
end

function RacingVehicleControllerBase:resetNarcissusTeleportPresentation()
	if not self._narcissusTeleportActive then
		return
	end

	self._narcissusTeleportActive = false
	self._narcissusTeleportHidden = false

	self:_setBuffAnimVisualActive(self:isBuffAnimPresentationActive())
end

function RacingVehicleControllerBase:_setBuffAnimVisualActive(active)
	if not gohelper.isNil(self._haitunGo) then
		gohelper.setActive(self._haitunGo, not active)
	end

	if not gohelper.isNil(self._buffAnimEffectGo) then
		gohelper.setActive(self._buffAnimEffectGo, active)
	end
end

function RacingVehicleControllerBase:_finishBuffAnimExit()
	if self._buffAnimExitInstanceId == nil then
		return
	end

	self._buffAnimExitInstanceId = nil

	self:_setBuffAnimVisualActive(false)
end

function RacingVehicleControllerBase:resetBuffAnimPresentation()
	TaskDispatcher.cancelTask(self._finishBuffAnimExit, self)

	self._curBuffAnimName = nil
	self._curBuffAnimInstanceId = nil
	self._buffAnimExitInstanceId = nil
	self._narcissusTeleportActive = false
	self._narcissusTeleportHidden = false

	self:_setBuffAnimVisualActive(false)
end

function RacingVehicleControllerBase:jumpLane(laneOffset)
	return
end

function RacingVehicleControllerBase:isShortcutJumping()
	return self._shortcutJumpRemainingSec > 0
end

function RacingVehicleControllerBase:bindVehiclePresentation(presentation)
	self._vehiclePresentation = presentation
end

function RacingVehicleControllerBase:clearVehiclePresentation(presentation)
	if not presentation or self._vehiclePresentation == presentation then
		self._vehiclePresentation = nil
	end
end

function RacingVehicleControllerBase:setJumpPadApproachVisualHeight(height)
	local presentation = self._vehiclePresentation

	if presentation and presentation.setJumpPadApproachTargetHeight then
		presentation:setJumpPadApproachTargetHeight(height)
	end
end

function RacingVehicleControllerBase:beginJumpPadApproachVisualHandoff()
	local presentation = self._vehiclePresentation

	if presentation and presentation.beginJumpPadApproachHandoff then
		presentation:beginJumpPadApproachHandoff()
	end
end

function RacingVehicleControllerBase:getRacerVisualAttachGo()
	local presentation = self._vehiclePresentation

	if presentation and presentation.getVehicleFxAttachGo then
		local attachGo = presentation:getVehicleFxAttachGo()

		if not gohelper.isNil(attachGo) then
			return attachGo
		end
	end

	return self._go
end

function RacingVehicleControllerBase:getShortcutJumpProgress()
	local duration = math.max(0.0001, (not self._shortcutJumpDurationSec or nil) and 0)

	return Mathf.Clamp01(1 - (self._shortcutJumpRemainingSec or 0) / duration)
end

function RacingVehicleControllerBase:_beginShortcutJump(startDistance, targetDistance, startLateral, targetLateral, durationSec, height, speedMultiplier, takeoffY, jumpData)
	self._shortcutJumpStartDistance = startDistance
	self._shortcutJumpTargetDistance = targetDistance
	self._shortcutJumpStartLateral = startLateral
	self._shortcutJumpTargetLateral = targetLateral
	self._shortcutJumpDurationSec = math.max(0.1, durationSec or 0)
	self._shortcutJumpRemainingSec = self._shortcutJumpDurationSec
	self._shortcutJumpHeight = math.max(0, height or 0)
	self._shortcutJumpSpeedMultiplier = math.max(1, speedMultiplier or 1)
	self._shortcutJumpTakeoffY = takeoffY or 0

	self:beginJumpPadApproachVisualHandoff()

	if jumpData then
		if not jumpData.takeoffXZ then
			local txz = self._shortcutJumpTakeoffXZ

			if not txz.x then
				self._shortcutJumpTakeoffXZ.x = 0
			end

			self._shortcutJumpTakeoffXZ.z = txz.z or 0

			if not jumpData.landingXZ then
				local lxz = self._shortcutJumpLandingXZ

				if not lxz.x then
					self._shortcutJumpLandingXZ.x = 0
				end

				self._shortcutJumpLandingXZ.z = lxz.z or 0

				local dx = lxz.x - txz.x
				local dz = lxz.z - txz.z
				local len = math.sqrt(dx * dx + dz * dz)

				if len > 0.0001 then
					self._shortcutJumpTakeoffForward.x = dx / len
					self._shortcutJumpTakeoffForward.z = dz / len
				else
					self._shortcutJumpTakeoffForward.x = 0
					self._shortcutJumpTakeoffForward.z = 0
				end
			end
		end
	end
end

function RacingVehicleControllerBase:_resolveShortcutJumpTargetDistance(startDistance, landingDistanceOffset)
	return startDistance + math.max(ShortcutJumpMinForwardDistance, landingDistanceOffset or 0)
end

function RacingVehicleControllerBase:_advanceShortcutJump(deltaTime)
	local duration = math.max(0.0001, self._shortcutJumpDurationSec)
	local t = Mathf.Clamp01(1 - self._shortcutJumpRemainingSec / duration)
	local eased = self:_resolveShortcutJumpHorizontalProgress(t)
	local distance = self:_lerp(self._shortcutJumpStartDistance, self._shortcutJumpTargetDistance, eased)
	local lateral = self:_lerp(self._shortcutJumpStartLateral, self._shortcutJumpTargetLateral, eased)
	local heightOffset = math.sin(t * math.pi) * self._shortcutJumpHeight + self:_resolveShortcutJumpLandingSinkOffset(t)

	self._shortcutJumpRemainingSec = math.max(0, self._shortcutJumpRemainingSec - deltaTime)

	local finished = self._shortcutJumpRemainingSec <= 0

	if finished then
		distance = self._shortcutJumpTargetDistance
		lateral = self._shortcutJumpTargetLateral
		heightOffset = 0
	end

	return distance, lateral, heightOffset, finished
end

function RacingVehicleControllerBase:getDistance()
	if self.getTrackDistance then
		return self:getTrackDistance()
	end

	return 0
end

function RacingVehicleControllerBase:_setInvulnerableFor(seconds)
	self._invulnerabilityRemainingSec = math.max(0, seconds or 0)
end

function RacingVehicleControllerBase:isInvulnerable()
	return self._invulnerabilityRemainingSec > 0
end

function RacingVehicleControllerBase:getBaseSpeed()
	if self._racerConfig then
		if not self._racerConfig.baseSpeed then
			local speed = 0
			local totalBase, totalRatio = self:getAttrValue(RacingCarPropEnum.RacingParamId.BaseSpeed1)

			speed = (speed + totalBase) * (1 + totalRatio)

			return math.max(0, speed)
		end
	end
end

function RacingVehicleControllerBase:updateSpeed(deltaTime)
	local baseSpeed = self:getBaseSpeed()

	baseSpeed = baseSpeed + self._baseSpeed3

	local totalBase, totalRatio = self:getSpecialAttrValue(RacingCarPropEnum.RacingParamId.SpeedMultiplier, self._lossFactor)

	if self._penetrateSpeedMulAdd ~= 0 then
		totalBase = totalBase + self._penetrateSpeedMulAdd
		self._penetrateSpeedMulAdd = 0
	end

	local targetSpeed = math.max(0, baseSpeed * (1 + totalBase) * (1 + totalRatio))
	local prevSpeed = self._forwardSpeed + self._currentSpeedAddValue

	if self._currentSpeedAddValue ~= 0 then
		self._currentSpeedAddValue = 0
	end

	local finalSpeed = prevSpeed

	if prevSpeed ~= targetSpeed then
		local acceleration = self._racerConfig.baseAcceleration

		acceleration = acceleration + self._accelerated2

		local accelerationTotalBase, accelerationTotalRatio = self:getAttrValue(RacingCarPropEnum.RacingParamId.Acceleration)

		acceleration = (acceleration + accelerationTotalBase) * (1 + accelerationTotalRatio)

		if self._penetrateAccelAdd ~= 0 then
			acceleration = acceleration + self._penetrateAccelAdd
			self._penetrateAccelAdd = 0
		end

		finalSpeed = targetSpeed < prevSpeed and math.max(targetSpeed, prevSpeed - acceleration * deltaTime) or math.min(targetSpeed, prevSpeed + acceleration * deltaTime)
	end

	local baseMaxSpeed = self._racerConfig.maxSpeed
	local maxSpeedTotalBase, maxSpeedTotalRatio = self:getAttrValue(RacingCarPropEnum.RacingParamId.MaxSpeed)
	local maxSpeed = (baseMaxSpeed + maxSpeedTotalBase) * (1 + maxSpeedTotalRatio)

	finalSpeed = math.min(finalSpeed, maxSpeed)
	self._forwardSpeed = math.max(0, finalSpeed)

	if RacingCarPropEnum.GMSpeed > 0 then
		self._forwardSpeed = RacingCarPropEnum.GMSpeed
	end

	if self._isMoveRestricted then
		self._forwardSpeed = 0
	end
end

function RacingVehicleControllerBase:_lerp(a, b, t)
	return a + (b - a) * t
end

function RacingVehicleControllerBase:_smoothStep(a, b, t)
	t = Mathf.Clamp01(t)

	return a + (b - a) * (t * t * (3 - 2 * t))
end

function RacingVehicleControllerBase:_resolveShortcutJumpHorizontalProgress(t)
	t = Mathf.Clamp01(t)

	local progress = ((((ShortcutJumpCurveA5 * t + ShortcutJumpCurveA4) * t + ShortcutJumpCurveA3) * t + ShortcutJumpCurveA2) * t + ShortcutJumpCurveA1) * t

	return Mathf.Clamp01(progress)
end

function RacingVehicleControllerBase:_resolveShortcutJumpLandingSinkOffset(t)
	local sink01 = Mathf.Clamp01((t - ShortcutJumpLandingSinkStart01) / math.max(0.001, 1 - ShortcutJumpLandingSinkStart01))

	if sink01 <= 0 or sink01 >= 1 then
		return 0
	end

	return -ShortcutJumpLandingSinkDepth * math.sin(sink01 * math.pi)
end

function RacingVehicleControllerBase:_moveTowards(current, target, maxDelta)
	if maxDelta >= math.abs(target - current) then
		return target
	end

	if current < target then
		return current + maxDelta
	else
		return current - maxDelta
	end
end

function RacingVehicleControllerBase:_disposeVehicleBase()
	self:_unregisterFromSkillManager()

	self._vehiclePresentation = nil

	if self.buffManager then
		self.buffManager:clearAll()

		self.buffManager = nil
	end

	self:resetBuffAnimPresentation()

	self._buffAnimEffectGo = nil
	self._haitunGo = nil
	self._animator = nil
	self._attrModifiers = nil
	self._buffAttrModifiers = nil
	self._attrLimits = nil
end

return RacingVehicleControllerBase
