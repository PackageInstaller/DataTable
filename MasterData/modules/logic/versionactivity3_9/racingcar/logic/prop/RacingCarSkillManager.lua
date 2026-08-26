-- chunkname: @modules/logic/versionactivity3_9/racingcar/logic/prop/RacingCarSkillManager.lua

module("modules.logic.versionactivity3_9.racingcar.logic.prop.RacingCarSkillManager", package.seeall)

local RacingCarSkillManager = class("RacingCarSkillManager")

function RacingCarSkillManager:ctor()
	self._allRacers = {}
	self._targetsCache = {}
	self._conversionMapCache = {}
end

function RacingCarSkillManager:registerRacer(racerId, controller)
	self._allRacers[racerId] = controller
end

function RacingCarSkillManager:unregisterRacer(racerId)
	local controller = self._allRacers[racerId]

	self._allRacers[racerId] = nil

	if self._targetsCache[1] == controller then
		self._targetsCache[1] = nil
	end
end

function RacingCarSkillManager:executeEffect(effectId, caster, triggerType, triggerTarget, isPassive, otherParams)
	local effectMo = V3a9RacingCarConfig.instance:getRacingEffectConfig(effectId)

	if not effectMo then
		return
	end

	local effectConfig = effectMo.config
	local paramData = effectMo.paramData

	if paramData.triggerType ~= triggerType and paramData.triggerType ~= RacingCarPropEnum.TriggerType.None then
		if not isPassive and triggerType == RacingCarPropEnum.TriggerType.FightStart and RacingCarPropEnum.PassiveTriggerType[paramData.triggerType] then
			self:addPassiveSkill(caster, effectId)
		end

		return
	end

	local targets = self:_getTargets(paramData.targetType, caster, triggerTarget)

	for _, target in ipairs(targets) do
		if not isPassive then
			if RacingCarPropEnum.PassiveTriggerType[paramData.triggerType] then
				self:addPassiveSkill(caster, effectId)
			else
				self:_doEffect(effectConfig.effectType, paramData, target, effectConfig, caster, triggerType, otherParams)
			end
		else
			self:_doEffect(effectConfig.effectType, paramData, target, effectConfig, caster, triggerType, otherParams)
		end
	end

	targets[1] = nil
end

function RacingCarSkillManager:_getTargets(targetType, caster, triggerTarget)
	local cache = self._targetsCache

	cache[1] = nil

	if targetType == RacingCarPropEnum.TargetType.Self then
		cache[1] = caster
	elseif targetType == RacingCarPropEnum.TargetType.TriggerTarget then
		cache[1] = triggerTarget
	elseif targetType == RacingCarPropEnum.TargetType.RankFirst then
		cache[1] = self:_getRankFirst()
	elseif targetType == RacingCarPropEnum.TargetType.RankAheadOne then
		cache[1] = self:_getRankAheadOne(caster)
	end

	return cache
end

function RacingCarSkillManager:_getRankFirst()
	local maxDistance = -math.huge
	local first

	for _, racer in pairs(self._allRacers) do
		local dist = self:_getRacerDistance(racer)

		if maxDistance < dist then
			maxDistance = dist
			first = racer
		end
	end

	return first
end

function RacingCarSkillManager:_getRankAheadOne(caster)
	local casterDist = self:_getRacerDistance(caster)
	local ahead
	local aheadDist = math.huge

	for _, racer in pairs(self._allRacers) do
		if racer ~= caster then
			local dist = self:_getRacerDistance(racer)

			if casterDist < dist and dist < aheadDist then
				aheadDist = dist
				ahead = racer
			end
		end
	end

	return ahead
end

function RacingCarSkillManager:_getRacerDistance(racer)
	if not racer then
		return 0
	end

	if racer.getDistance then
		return racer:getDistance()
	end

	return racer._totalDistance or racer._currentDistance or 0
end

function RacingCarSkillManager:_doEffect(effectType, paramData, target, effectConfig, caster, triggerType, otherParams)
	if effectType == RacingCarPropEnum.SkillParamType.AddBuff then
		self:_doAddBuff(paramData, target, effectConfig)
	elseif effectType == RacingCarPropEnum.SkillParamType.TempFix then
		self:_doTempFix(paramData, target, effectConfig, triggerType)
	elseif effectType == RacingCarPropEnum.SkillParamType.TempSet then
		self:_doTempSet(paramData, target, effectConfig)
	elseif effectType == RacingCarPropEnum.SkillParamType.AddItem then
		self:_doAddItem(paramData, target, effectConfig)
	elseif effectType == RacingCarPropEnum.SkillParamType.AddSkill then
		self:_doAddSkill(paramData, target, effectConfig)
	elseif effectType == RacingCarPropEnum.SkillParamType.JumpTrack then
		self:_doJumpTrack(paramData, target, effectConfig)
	elseif effectType == RacingCarPropEnum.SkillParamType.AddRangBuff then
		self:_doAddRangBuff(paramData, target, effectConfig, caster)
	elseif effectType == RacingCarPropEnum.SkillParamType.RemoveBuff then
		self:_doRemoveBuff(paramData, target, effectConfig)
	elseif effectType == RacingCarPropEnum.SkillParamType.ItemConversion then
		self:_doItemConversion(paramData, target, effectConfig, otherParams)
	end
end

function RacingCarSkillManager:_doAddBuff(paramData, target, effectConfig)
	if target and target.buffManager then
		target.buffManager:addBuffById(paramData.buffId)
	end
end

function RacingCarSkillManager:_doTempFix(paramData, target, effectConfig, triggerType)
	if target and target.modifyAttribute then
		local value = paramData.baseValue

		if triggerType == RacingCarPropEnum.TriggerType.Rank then
			value = value * Time.deltaTime
		end

		target:modifyAttribute(paramData.paramId, value, paramData.ratio)
	end
end

function RacingCarSkillManager:_doTempSet(paramData, target, effectConfig)
	if target and target.setAttribute then
		target:setAttribute(paramData.paramId, paramData.baseValue, paramData.ratio)
	end
end

function RacingCarSkillManager:_doAddItem(paramData, target, effectConfig)
	if not target then
		return
	end

	local itemIds = paramData.itemIds

	if not itemIds or #itemIds == 0 then
		logError("RacingCarSkillManager:_doAddItem itemIds is empty")

		return
	end

	local itemId = itemIds[math.random(1, #itemIds)]
	local itemConfig = V3a9RacingCarConfig.instance:getRacingItemConfig(itemId)

	if not itemConfig then
		logError(string.format("RacingCarSkillManager:_doAddItem itemConfig is nil, itemId:%s", itemId))

		return
	end

	if target.tryStoreItem then
		target:tryStoreItem(itemConfig)
	else
		logError(string.format("RacingCarSkillManager:_doAddItem target has no tryStoreItem, itemId:%s", itemId))
	end
end

function RacingCarSkillManager:_doAddSkill(paramData, target, effectConfig)
	if not target then
		return
	end

	local skillIds = paramData.skillIds

	if not skillIds or #skillIds == 0 then
		logError("RacingCarSkillManager:_doAddSkill skillIds is empty")

		return
	end

	for _, skillId in ipairs(skillIds) do
		if target.addSkill then
			target:addSkill(skillId)
		else
			logError(string.format("RacingCarSkillManager:_doAddSkill target has no addSkill, skillId:%d", skillId))
		end
	end
end

function RacingCarSkillManager:_doJumpTrack(paramData, target, effectConfig)
	if target and target.jumpLane then
		target:jumpLane(paramData.laneOffset)
	end
end

function RacingCarSkillManager:_doAddRangBuff(paramData, target, effectConfig, caster)
	if not caster then
		logError("RacingCarSkillManager:_doAddRangBuff caster is nil")

		return
	end

	local radius = paramData.radius

	if not radius or radius <= 0 then
		logError("RacingCarSkillManager:_doAddRangBuff radius is invalid")

		return
	end

	local buffIds = paramData.buffIds

	if not buffIds or #buffIds == 0 then
		logError("RacingCarSkillManager:_doAddRangBuff buffIds is empty")

		return
	end

	if not paramData.includeSelf then
		local includeSelf = 0
		local casterPos = self:_getRacerPosition(caster)

		if not casterPos then
			return
		end

		local radiusSqr = radius * radius

		for racerId, racer in pairs(self._allRacers) do
			if racer == caster and includeSelf == 1 then
				-- block empty
			else
				local racerPos = self:_getRacerPosition(racer)

				if racerPos then
					local dx = casterPos.x - racerPos.x
					local dz = casterPos.z - racerPos.z
					local distSqr = dx * dx + dz * dz

					if distSqr <= radiusSqr and racer.buffManager then
						for _, buffId in ipairs(buffIds) do
							racer.buffManager:addBuffById(buffId)
						end
					end
				end
			end
		end
	end
end

function RacingCarSkillManager:_doRemoveBuff(paramData, target, effectConfig)
	if target and target.buffManager then
		target.buffManager:removeBuffByType(paramData.removeBuffTypeId, paramData.removeBuffCount)
	end
end

function RacingCarSkillManager:_doItemConversion(paramData, target, effectConfig, otherParams)
	if not target then
		return
	end

	if not target.convertItems then
		logError("RacingCarSkillManager:_doItemConversion target has no convertItems")

		return
	end

	local sourceItemIds = paramData.sourceItemIds
	local destItemIds = paramData.destItemIds

	if not sourceItemIds or #sourceItemIds == 0 or not destItemIds or #destItemIds == 0 then
		logError("RacingCarSkillManager:_doItemConversion sourceItemIds or destItemIds is empty")

		return
	end

	local conversionMap = self._conversionMapCache

	for k in pairs(conversionMap) do
		conversionMap[k] = nil
	end

	for i, sourceId in ipairs(sourceItemIds) do
		local destId = destItemIds[i]

		if destId then
			local newItemConfig = V3a9RacingCarConfig.instance:getRacingItemConfig(destId)

			if newItemConfig then
				conversionMap[sourceId] = newItemConfig
			else
				logError(string.format("RacingCarSkillManager:_doItemConversion destItemConfig is nil, destId:%d", destId))
			end
		end
	end

	target:convertItems(sourceItemIds, conversionMap, otherParams)
end

function RacingCarSkillManager:_getRacerPosition(racer)
	if not racer then
		return nil
	end

	local var_19_0 = racer._transform

	if not racer._transform then
		var_19_0 = racer._go

		if racer._go then
			local t = racer._go.transform

			if t then
				return t.position
			end

			return nil
		end
	end
end

function RacingCarSkillManager:addPassiveSkill(controller, effectId)
	if not controller then
		logError("RacingCarSkillManager:addPassiveSkill controller is nil")

		return
	end

	controller._passiveSkillEffectIds = controller._passiveSkillEffectIds or {}

	table.insert(controller._passiveSkillEffectIds, effectId)
end

function RacingCarSkillManager:executePassiveSkills(controller, triggerType, triggerTarget, triggerTypeParam, otherParams)
	if not controller or not controller._passiveSkillEffectIds then
		return
	end

	for _, effectId in ipairs(controller._passiveSkillEffectIds) do
		local effectMo = V3a9RacingCarConfig.instance:getRacingEffectConfig(effectId)

		if effectMo then
			local paramData = effectMo.paramData

			if paramData.triggerType == triggerType then
				local matched = false

				if triggerType == RacingCarPropEnum.TriggerType.GetItemRand then
					if not paramData.triggerTypeParam then
						local probability = 0

						if probability >= math.random(1, 1000) then
							matched = true
						end
					end
				elseif triggerType == RacingCarPropEnum.TriggerType.Rank then
					local rankList = paramData.triggerTypeParam

					if rankList then
						for _, rank in ipairs(rankList) do
							if rank == triggerTypeParam then
								matched = true

								break
							end
						end
					end
				elseif RacingCarPropEnum.MultiIdTriggerType[triggerType] then
					local idList = paramData.triggerTypeParam

					if idList == nil then
						matched = true
					else
						for _, id in ipairs(idList) do
							if id == triggerTypeParam then
								matched = true

								break
							end
						end
					end
				elseif paramData.triggerTypeParam == nil or paramData.triggerTypeParam == triggerTypeParam then
					matched = true
				end

				if matched then
					self:executeEffect(effectId, controller, triggerType, triggerTarget, true, otherParams)
				end
			end
		end
	end
end

function RacingCarSkillManager:executeInitSkills(controller, effectIds)
	if not controller then
		logError("RacingCarSkillManager:executeInitSkills controller is nil")

		return
	end

	if not effectIds or #effectIds == 0 then
		return
	end

	for _, effectId in ipairs(effectIds) do
		self:executeEffect(effectId, controller, RacingCarPropEnum.TriggerType.FightStart, controller)
	end
end

function RacingCarSkillManager:clearPassiveSkills(controller)
	if not controller or not controller._passiveSkillEffectIds then
		return
	end

	local list = controller._passiveSkillEffectIds

	for i = #list, 1, -1 do
		list[i] = nil
	end
end

RacingCarSkillManager.instance = RacingCarSkillManager.New()

return RacingCarSkillManager
