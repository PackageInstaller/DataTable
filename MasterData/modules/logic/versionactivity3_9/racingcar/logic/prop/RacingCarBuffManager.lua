-- chunkname: @modules/logic/versionactivity3_9/racingcar/logic/prop/RacingCarBuffManager.lua

module("modules.logic.versionactivity3_9.racingcar.logic.prop.RacingCarBuffManager", package.seeall)

local RacingCarBuffManager = class("RacingCarBuffManager")

function RacingCarBuffManager:ctor(owner)
	self._owner = owner
	self._activeBuffs = {}
	self._buffIdCounter = 0
	self._immunityMap = {}
	self._toRemoveCache = {}
	self._penetrateRefCount = 0
end

function RacingCarBuffManager:addBuffById(buffId)
	if not self._owner then
		return nil
	end

	local buffMo = V3a9RacingCarConfig.instance:getRacingBuffConfig(buffId)

	if not buffMo then
		logError(string.format("RacingCarBuffManager:addBuffById error, buff config not found, id:%d", buffId))

		return nil
	end

	local buffConfig = buffMo.config
	local effects = buffMo.features

	if not buffConfig.time then
		local duration = 0

		if not buffConfig.includeTypes then
			local stackRule = RacingCarPropEnum.BuffStackRule.Independent

			if not buffConfig.typeId then
				local buffType = 0

				if self:_isImmuned(buffType) then
					return nil
				end

				local existingBuff = self:_getExistingBuffByType(buffType)

				if existingBuff then
					if stackRule == RacingCarPropEnum.BuffStackRule.DurationAdd then
						existingBuff.remainingTime = existingBuff.remainingTime + duration
						existingBuff.duration = existingBuff.duration + duration

						RacingCarSkillManager.instance:executePassiveSkills(self._owner, RacingCarPropEnum.TriggerType.GetBuff, self._owner, buffId)

						return existingBuff.id
					elseif stackRule == RacingCarPropEnum.BuffStackRule.HighReplaceLow then
						if duration > existingBuff.remainingTime then
							self:_removeBuffEffects(existingBuff)
							self:_removeBuffFromList(existingBuff.id)
						else
							return existingBuff.id
						end
					elseif stackRule == RacingCarPropEnum.BuffStackRule.KeepOldRejectNew then
						return existingBuff.id
					end
				end

				self._buffIdCounter = self._buffIdCounter + 1

				local buffInstanceId = self._buffIdCounter
				local buff = {
					isApplied = false,
					id = buffInstanceId,
					buffId = buffId,
					buffType = buffType,
					effects = effects,
					duration = duration,
					remainingTime = duration,
					buffConfig = buffConfig,
					cameraConfig = lua_racing_camera.configDict[buffConfig.camera],
					animConfig = buffConfig.anim
				}

				self:_applyBuffEffects(buff)
				table.insert(self._activeBuffs, buff)
				RacingCarSkillManager.instance:executePassiveSkills(self._owner, RacingCarPropEnum.TriggerType.GetBuff, self._owner, buffId)

				return buffInstanceId
			end
		end
	end
end

function RacingCarBuffManager:addBuff(effectType, params, duration)
	params = params or {}

	local effect = {
		type = effectType
	}

	for k, v in pairs(params) do
		if k ~= "stackRule" then
			effect[k] = v
		end
	end

	if not params.stackRule then
		return self:_addBuffInstance(effectType, {
			effect
		}, duration, params.stackRule, 0)
	end
end

function RacingCarBuffManager:_addBuffInstance(buffType, effects, duration, stackRule, buffId)
	if not self._owner then
		return nil
	end

	if buffId and buffId > 0 and self:_isImmuned(buffId) then
		return nil
	end

	local existingBuff = self:_getExistingBuffByType(buffType)

	if existingBuff then
		if stackRule == RacingCarPropEnum.BuffStackRule.DurationAdd then
			existingBuff.remainingTime = existingBuff.remainingTime + duration
			existingBuff.duration = existingBuff.duration + duration

			return existingBuff.id
		elseif stackRule == RacingCarPropEnum.BuffStackRule.HighReplaceLow then
			if duration > existingBuff.remainingTime then
				self:_removeBuffEffects(existingBuff)
				self:_removeBuffFromList(existingBuff.id)
			else
				return existingBuff.id
			end
		elseif stackRule == RacingCarPropEnum.BuffStackRule.KeepOldRejectNew then
			return existingBuff.id
		end
	end

	self._buffIdCounter = self._buffIdCounter + 1

	local buffInstanceId = self._buffIdCounter
	local buff = {
		isApplied = false,
		id = buffInstanceId,
		buffId = buffId or 0,
		buffType = buffType,
		effects = effects,
		duration = duration,
		remainingTime = duration
	}

	self:_applyBuffEffects(buff)
	table.insert(self._activeBuffs, buff)

	return buffInstanceId
end

function RacingCarBuffManager:removeBuff(buffInstanceId)
	for i, buff in ipairs(self._activeBuffs) do
		if buff.id == buffInstanceId then
			self:_removeBuffEffects(buff)
			table.remove(self._activeBuffs, i)

			return
		end
	end
end

function RacingCarBuffManager:removeBuffById(buffId, count)
	if not buffId or buffId == 0 then
		return
	end

	count = count or 0

	local matched = self._toRemoveCache
	local matchedCount = 0

	for i, buff in ipairs(self._activeBuffs) do
		if buff.buffId == buffId then
			matchedCount = matchedCount + 1
			matched[matchedCount] = i
		end
	end

	if matchedCount == 0 then
		return
	end

	local removeCount = count <= 0 and matchedCount or math.min(count, matchedCount)

	for i = removeCount, 1, -1 do
		local buffIndex = matched[i]
		local buff = self._activeBuffs[buffIndex]

		self:_removeBuffEffects(buff)
		table.remove(self._activeBuffs, buffIndex)
	end

	for i = 1, matchedCount do
		matched[i] = nil
	end
end

function RacingCarBuffManager:removeBuffByType(typeId, count)
	if not typeId or typeId == 0 then
		return
	end

	count = count or 0

	local matched = self._toRemoveCache
	local matchedCount = 0

	for i, buff in ipairs(self._activeBuffs) do
		if buff.buffType == typeId then
			matchedCount = matchedCount + 1
			matched[matchedCount] = i
		end
	end

	if matchedCount == 0 then
		return
	end

	local removeCount = count <= 0 and matchedCount or math.min(count, matchedCount)

	for i = removeCount, 1, -1 do
		local buffIndex = matched[i]
		local buff = self._activeBuffs[buffIndex]

		self:_removeBuffEffects(buff)
		table.remove(self._activeBuffs, buffIndex)
	end

	for i = 1, matchedCount do
		matched[i] = nil
	end
end

function RacingCarBuffManager:update(deltaTime)
	if #self._activeBuffs == 0 then
		return
	end

	local toRemove = self._toRemoveCache
	local toRemoveCount = 0

	for i, buff in ipairs(self._activeBuffs) do
		if buff.duration > 0 then
			buff.remainingTime = buff.remainingTime - deltaTime

			if buff.remainingTime <= 0 then
				toRemoveCount = toRemoveCount + 1
				toRemove[toRemoveCount] = i
			end
		end
	end

	for i = toRemoveCount, 1, -1 do
		local buffIndex = toRemove[i]
		local buff = self._activeBuffs[buffIndex]

		self:_removeBuffEffects(buff)
		table.remove(self._activeBuffs, buffIndex)
	end

	for i = 1, toRemoveCount do
		toRemove[i] = nil
	end
end

function RacingCarBuffManager:clearAll()
	for _, buff in ipairs(self._activeBuffs) do
		self:_removeBuffEffects(buff)
	end

	tabletool.clear(self._activeBuffs)

	self._buffIdCounter = 0
	self._penetrateRefCount = 0
end

function RacingCarBuffManager:getAllBuffs()
	return self._activeBuffs
end

function RacingCarBuffManager:hasBuffType(effectType)
	for _, buff in ipairs(self._activeBuffs) do
		for _, effect in ipairs(buff.effects) do
			if effect.type == effectType then
				return true
			end
		end
	end

	return false
end

function RacingCarBuffManager:getBuffByType(effectType)
	for _, buff in ipairs(self._activeBuffs) do
		for _, effect in ipairs(buff.effects) do
			if effect.type == effectType then
				return buff
			end
		end
	end

	return nil
end

function RacingCarBuffManager:_getExistingBuffByType(buffType)
	for _, buff in ipairs(self._activeBuffs) do
		if buff.buffType == buffType then
			return buff
		end
	end

	return nil
end

function RacingCarBuffManager:_isImmuned(buffId)
	return self._immunityMap[buffId] == true
end

function RacingCarBuffManager:isBuffTypeImmuned(buffType)
	return self:_isImmuned(buffType)
end

function RacingCarBuffManager:_removeBuffFromList(buffInstanceId)
	for i, buff in ipairs(self._activeBuffs) do
		if buff.id == buffInstanceId then
			table.remove(self._activeBuffs, i)

			return
		end
	end
end

function RacingCarBuffManager:_applyBuffEffects(buff)
	for _, effect in ipairs(buff.effects) do
		local effectType = effect.type

		if effectType == RacingCarPropEnum.BuffParamType.Attr then
			self:_applyAttrEffect(effect, buff.id)
		elseif effectType == RacingCarPropEnum.BuffParamType.Immunity then
			self:_applyImmunityEffect(effect)
		elseif effectType == RacingCarPropEnum.BuffParamType.Invisible then
			self:_applyInvisibleEffect(effect)
		elseif effectType == RacingCarPropEnum.BuffParamType.Absorb then
			self:_applyAbsorbEffect(effect)
		elseif effectType == RacingCarPropEnum.BuffParamType.Height then
			self:_applyHeightEffect(effect, buff.id)
		elseif effectType == RacingCarPropEnum.BuffParamType.Restrict then
			self:_applyRestrictEffect(effect)
		elseif effectType == RacingCarPropEnum.BuffParamType.Hide then
			self:_applyHideEffect(effect)
		elseif effectType == RacingCarPropEnum.BuffParamType.Penetrate then
			self:_applyPenetrateEffect(effect, buff.id)
		end
	end

	buff.isApplied = true

	if buff.animConfig and buff.animConfig ~= "" then
		self:_applyBuffAnim(buff.animConfig, buff.id)
	end
end

function RacingCarBuffManager:_removeBuffEffects(buff)
	if not buff.isApplied then
		return
	end

	if buff.animConfig and buff.animConfig ~= "" then
		self:_removeBuffAnim(buff.animConfig, buff.id)
	end

	for _, effect in ipairs(buff.effects) do
		local effectType = effect.type

		if effectType == RacingCarPropEnum.BuffParamType.Attr then
			self:_removeAttrEffect(effect, buff.id)
		elseif effectType == RacingCarPropEnum.BuffParamType.Immunity then
			self:_removeImmunityEffect(effect)
		elseif effectType == RacingCarPropEnum.BuffParamType.Invisible then
			self:_removeInvisibleEffect(effect)
		elseif effectType == RacingCarPropEnum.BuffParamType.Absorb then
			self:_removeAbsorbEffect(effect)
		elseif effectType == RacingCarPropEnum.BuffParamType.Height then
			self:_removeHeightEffect(effect, buff.id)
		elseif effectType == RacingCarPropEnum.BuffParamType.Restrict then
			self:_removeRestrictEffect(effect)
		elseif effectType == RacingCarPropEnum.BuffParamType.Hide then
			self:_removeHideEffect(effect)
		elseif effectType == RacingCarPropEnum.BuffParamType.Penetrate then
			self:_removePenetrateEffect(effect, buff.id)
		end
	end

	buff.isApplied = false
end

function RacingCarBuffManager:_applyAttrEffect(effect, buffInstanceId)
	local paramId = effect.paramId

	if not effect.baseValue then
		if not effect.ratio then
			local ratio = 0

			if self._owner and self._owner.modifyAttribute then
				self._owner:modifyAttribute(paramId, effect.baseValue, ratio, buffInstanceId)
			end
		end
	end
end

function RacingCarBuffManager:_removeAttrEffect(effect, buffInstanceId)
	local paramId = effect.paramId

	if not effect.baseValue then
		if not effect.ratio then
			local ratio = 0

			if self._owner and self._owner.modifyAttribute then
				self._owner:modifyAttribute(paramId, -effect.baseValue, -ratio, buffInstanceId, true)
			end
		end
	end
end

function RacingCarBuffManager:_applyHeightEffect(effect, buffInstanceId)
	if self._owner and self._owner.addBuffHeightOffset then
		self._owner:addBuffHeightOffset(buffInstanceId, effect.heightOffset or 0)
	end
end

function RacingCarBuffManager:_removeHeightEffect(effect, buffInstanceId)
	if self._owner and self._owner.removeBuffHeightOffset then
		self._owner:removeBuffHeightOffset(buffInstanceId)
	end
end

function RacingCarBuffManager:_applyImmunityEffect(effect)
	if not effect.immunityBuffTypes then
		for _, buffId in ipairs(effect.immunityBuffTypes) do
			self._immunityMap[buffId] = true
		end
	end
end

function RacingCarBuffManager:_removeImmunityEffect(effect)
	if not effect.immunityBuffTypes then
		for _, buffId in ipairs(effect.immunityBuffTypes) do
			self._immunityMap[buffId] = nil
		end
	end
end

function RacingCarBuffManager:_applyInvisibleEffect(effect)
	if self._owner and self._owner.setInvisible then
		self._owner:setInvisible(true)
	end
end

function RacingCarBuffManager:_removeInvisibleEffect(effect)
	if self._owner and self._owner.setInvisible then
		self._owner:setInvisible(false)
	end
end

function RacingCarBuffManager:_applyAbsorbEffect(effect)
	if not effect.radius then
		if self._owner and self._owner.setCoinAbsorbRadius then
			self._owner:setCoinAbsorbRadius(effect.radius)
		end
	end
end

function RacingCarBuffManager:_removeAbsorbEffect(effect)
	if self._owner and self._owner.setCoinAbsorbRadius then
		self._owner:setCoinAbsorbRadius(0)
	end
end

function RacingCarBuffManager:_applyRestrictEffect(effect)
	if self._owner and self._owner.setMoveEnabled then
		self._owner:setMoveEnabled(false)
	end
end

function RacingCarBuffManager:_removeRestrictEffect(effect)
	if self._owner and self._owner.setMoveEnabled then
		self._owner:setMoveEnabled(true)
	end
end

function RacingCarBuffManager:_applyHideEffect(effect)
	if self._owner and self._owner.setHide then
		self._owner:setHide(true)
	end
end

function RacingCarBuffManager:_removeHideEffect(effect)
	if self._owner and self._owner.setHide then
		self._owner:setHide(false)
	end
end

function RacingCarBuffManager:_applyPenetrateEffect(effect, buffInstanceId)
	self._penetrateRefCount = self._penetrateRefCount + 1

	if self._penetrateRefCount == 1 and self._owner and self._owner.setPenetrateActive then
		self._owner:setPenetrateActive(true)
	end
end

function RacingCarBuffManager:_removePenetrateEffect(effect, buffInstanceId)
	self._penetrateRefCount = math.max(self._penetrateRefCount - 1, 0)

	if self._penetrateRefCount == 0 and self._owner and self._owner.setPenetrateActive then
		self._owner:setPenetrateActive(false)
	end
end

function RacingCarBuffManager:_applyBuffAnim(animName, buffInstanceId)
	if self._owner and self._owner.playBuffAnim then
		self._owner:playBuffAnim(animName, buffInstanceId)
	end
end

function RacingCarBuffManager:_removeBuffAnim(animName, buffInstanceId)
	if self._owner and self._owner.stopBuffAnim then
		self._owner:stopBuffAnim(animName, buffInstanceId)
	end
end

function RacingCarBuffManager:triggerPenetrate()
	local totalSpeedMul = 0
	local totalAccel = 0

	for _, buff in ipairs(self._activeBuffs) do
		for _, effect in ipairs(buff.effects) do
			if effect.type == RacingCarPropEnum.BuffParamType.Penetrate then
				totalSpeedMul = totalSpeedMul + (effect.speedMultiplier or 0)
				totalAccel = totalAccel + (effect.acceleration or 0)
			end
		end
	end

	if (totalSpeedMul ~= 0 or totalAccel ~= 0) and self._owner and self._owner.onPenetrateTrigger then
		self._owner:onPenetrateTrigger(totalSpeedMul, totalAccel)
	end
end

return RacingCarBuffManager
