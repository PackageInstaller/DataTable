-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/systems/BuffSystem.lua

BuffSystem = class("BuffSystem", BattleSubSystem)

function BuffSystem:initialize()
	super.initialize(self)

	self._targetAgentRegistry = {}
end

function BuffSystem:startup(battleContext)
	super.startup(self, battleContext)

	self._skillSystem = battleContext:getObject("SkillSystem")

	return self
end

function BuffSystem:updateOnRoundEnded(target)
	self:updateTiming(target, BuffTiming.kOnRoundEnded)
end

function BuffSystem:updateBeforeActing(target)
	self:updateTiming(target, BuffTiming.kBeforeActing)
end

function BuffSystem:updateAfterActing(target)
	self:updateTiming(target, BuffTiming.kAfterActing)
end

function BuffSystem:updateOnNewSecond(target, elapsed)
	self:updateTiming(target, BuffTiming.kOnNewSecond)
end

function BuffSystem:updateTiming(target, timingMode)
	local targetAgent = self:retrieveTargetAgent(target, false)

	if not targetAgent then
		return
	end

	local buffObjects = targetAgent:selectBuffObjects()

	for _, buffObject in ipairs(buffObjects) do
		if targetAgent:hasBuffObject(buffObject) then
			local result = buffObject:updateTiming(self._battleContext, timingMode)

			if result and self._processRecorder then
				self._processRecorder:recordObjectEvent(targetAgent:getId(), "TickBuff", result)
			end

			if buffObject:isUsedUp() then
				if targetAgent:removeBuffObject(buffObject) then
					local sucess, detail = buffObject:cancelEffect(targetAgent)

					if sucess and self._processRecorder then
						self._processRecorder:recordObjectEvent(targetAgent:getId(), "RmBuff", detail)
					end

					if buffObject:isGroup() then
						targetAgent:discardBuffGroup(buffObject:getGroupId())
					end
				end

				local unit = targetAgent:getTargetObject()

				self._skillSystem:activateSpecificTrigger(unit, "BUFF_ENDED", {
					buff = buffObject,
					unit = unit
				})
				self._skillSystem:activateGlobalTrigger("UNIT_BUFF_ENDED", {
					buff = buffObject,
					unit = unit
				})
			end
		end
	end
end

function BuffSystem:retrieveTargetAgent(target, autoCreate)
	local targetAgentRegistry = self._targetAgentRegistry
	local targetAgent = targetAgentRegistry[target]

	if targetAgent ~= nil or not autoCreate then
		return targetAgent
	end

	targetAgent = BuffTargetAgent:new(target)
	targetAgentRegistry[target] = targetAgent

	return targetAgent
end

function BuffSystem:discardTargetAgent(target)
	local targetAgentRegistry = self._targetAgentRegistry

	targetAgentRegistry[target] = nil

	return targetAgentRegistry[target]
end

function BuffSystem:recordEnterBuffs(target, triggerBuffs)
	if triggerBuffs and #triggerBuffs > 0 then
		local targetAgent = self:retrieveTargetAgent(target, true)

		targetAgent:setEnterBuffs(triggerBuffs)
	end
end

function BuffSystem:triggerEnterBuffs(target)
	local targetAgent = self:retrieveTargetAgent(target)

	if targetAgent then
		local triggerBuffs = targetAgent:getEnterBuffs()

		if not triggerBuffs then
			return
		end

		for _, triggerBuff in ipairs(triggerBuffs) do
			triggerBuff:trigger(target, self)
		end

		targetAgent:setEnterBuffs(nil)
	end
end

function BuffSystem:applyBuffOnTarget(target, buffObject, groupConfig, workId)
	if target == nil or buffObject == nil then
		return nil
	end

	local targetAgent = self:retrieveTargetAgent(target, true)

	assert(targetAgent ~= nil)

	if targetAgent:isImmuneToBuffObject(buffObject) then
		return nil
	end

	if groupConfig ~= nil then
		if groupConfig.limit and groupConfig.limit <= 0 then
			local buffGroup = targetAgent:retrieveBuffGroup(groupConfig.group)

			if buffGroup ~= nil then
				self:cancelBuffEffect(buffGroup)
			end
		else
			local buffGroup = targetAgent:retrieveBuffGroup(groupConfig.group)

			if buffGroup ~= nil then
				local result, detail = self:attachBuffWithGroup(buffObject, buffGroup, groupConfig.limit)

				if detail and self._processRecorder then
					self._processRecorder:recordObjectEvent(buffGroup:getActiveTarget():getId(), "StackBuff", detail, workId)
				end
			else
				local buffGroup = targetAgent:createBuffGroup(groupConfig.group, buffObject)
				local appliedTarget, detail = buffGroup:takeEffect(targetAgent)
				local added = targetAgent:addBuffObject(buffGroup)

				if detail and self._processRecorder then
					self._processRecorder:recordObjectEvent(appliedTarget:getId(), "AddBuff", detail, workId)
				end
			end
		end
	else
		local appliedTarget, detail = buffObject:takeEffect(targetAgent)

		if appliedTarget == nil then
			return nil
		end

		local added = targetAgent:addBuffObject(buffObject)

		if detail and self._processRecorder then
			self._processRecorder:recordObjectEvent(appliedTarget:getId(), "AddBuff", detail, workId)
		end
	end

	local unit = targetAgent:getTargetObject()

	self._skillSystem:activateSpecificTrigger(unit, "BUFF_APPLYED", {
		buff = buffObject
	})
	self._skillSystem:activateGlobalTrigger("UNIT_BUFF_APPLYED", {
		buff = buffObject,
		unit = unit
	})

	return buffObject
end

function BuffSystem:attachBuffWithGroup(buffObject, buffGroup, groupLimit)
	if buffObject == nil or buffGroup == nil then
		return false
	end

	return buffGroup:stack(buffObject, groupLimit)
end

function BuffSystem:detachBuffFromGroup(buffObject)
	local buffGroup = buffObject:getBuffGroup()

	if buffGroup == nil then
		return false
	end

	if buffGroup:remove(buffObject) == nil then
		return false
	end

	return true
end

function BuffSystem:cancelBuffEffect(buffObject, workId, ignoreTriggerEvent)
	local canceledTarget, detail = buffObject:cancelEffect()

	if canceledTarget == nil then
		return nil
	end

	if detail and self._processRecorder then
		self._processRecorder:recordObjectEvent(canceledTarget:getId(), "ClrBuff", detail, workId)
	end

	canceledTarget:removeBuffObject(buffObject)

	if buffObject:isGroup() then
		canceledTarget:discardBuffGroup(buffObject:getGroupId())
	end

	if not ignoreTriggerEvent then
		local unit = canceledTarget:getTargetObject()

		self._skillSystem:activateSpecificTrigger(unit, "BUFF_CANCELED", {
			buff = buffObject,
			unit = unit
		})
		self._skillSystem:activateGlobalTrigger("UNIT_BUFF_CANCELED", {
			buff = buffObject,
			unit = unit
		})
	end

	return canceledTarget:getTargetObject()
end

function BuffSystem:brokeBuffEffect(buffObject, workId)
	local canceledTarget, detail = buffObject:cancelEffect(true)

	if canceledTarget == nil then
		return nil
	end

	if detail and detail and self._processRecorder then
		self._processRecorder:recordObjectEvent(canceledTarget:getId(), "BrkBuff", detail, workId)
	end

	canceledTarget:removeBuffObject(buffObject)

	if buffObject:isGroup() then
		canceledTarget:discardBuffGroup(buffObject:getGroupId())
	end

	local unit = canceledTarget:getTargetObject()

	self._skillSystem:activateSpecificTrigger(unit, "BUFF_BROKED", {
		buff = buffObject,
		unit = unit
	})
	self._skillSystem:activateGlobalTrigger("UNIT_BUFF_BROKED", {
		buff = buffObject,
		unit = unit
	})

	return canceledTarget:getTargetObject()
end

function BuffSystem:dispelBuffsOnTarget(target, condition, workId, ignoreTriggerEvent)
	local targetAgent = self:retrieveTargetAgent(target, false)

	if targetAgent == nil then
		return 0
	end

	local removedBuffs = targetAgent:removeBuffObjectsWithCondition(condition)

	if removedBuffs == nil then
		return 0
	end

	local total = 0

	for i = 1, #removedBuffs do
		local buffObject = removedBuffs[i]

		if buffObject:isGroup() then
			targetAgent:discardBuffGroup(buffObject:getGroupId())
		end

		if self:cancelBuffEffect(buffObject, workId, ignoreTriggerEvent) then
			total = total + 1
		end
	end

	return total
end

function BuffSystem:brokeBuffsOnTarget(target, condition, workId)
	local targetAgent = self:retrieveTargetAgent(target, false)

	if targetAgent == nil then
		return 0
	end

	local removedBuffs = targetAgent:removeBuffObjectsWithCondition(condition)

	if removedBuffs == nil then
		return 0
	end

	local total = 0

	for i = 1, #removedBuffs do
		local buffObject = removedBuffs[i]

		if buffObject:isGroup() then
			targetAgent:discardBuffGroup(buffObject:getGroupId())
		end

		if self:brokeBuffEffect(buffObject, workId) then
			total = total + 1
		end
	end

	return total
end

function BuffSystem:cleanupBuffsOnTarget(target)
	local targetAgent = self:retrieveTargetAgent(target, false)

	if targetAgent == nil then
		return nil
	end

	local removedBuffs = targetAgent:removeBuffObjectsWithCondition()

	if removedBuffs ~= nil then
		for _, buffObject in ipairs(removedBuffs) do
			buffObject:cancelEffect()
		end
	end

	self:discardTargetAgent(target)
end

function BuffSystem:selectBuffsOnTarget(target, condition)
	assert(target ~= nil)

	local targetAgent = self:retrieveTargetAgent(target, false)

	if targetAgent == nil then
		return {}, 0
	end

	return targetAgent:selectBuffObjects(condition)
end

function BuffSystem:stealBuffsOnTarget(actor, target, condition, workId)
	local targetAgent = self:retrieveTargetAgent(target, false)

	if targetAgent == nil then
		return 0
	end

	local removedBuffs = targetAgent:removeBuffObjectsWithCondition(condition)

	if removedBuffs == nil then
		return 0
	end

	local total = 0

	for i = 1, #removedBuffs do
		local buffObject = removedBuffs[i]

		if buffObject:isGroup() then
			targetAgent:discardBuffGroup(buffObject:getGroupId())
		end

		if self:cancelBuffEffect(buffObject, workId) then
			local unit = targetAgent:getTargetObject()

			self._skillSystem:activateSpecificTrigger(unit, "BUFF_STEALED", {
				buff = buffObject,
				unit = unit
			})
			self._skillSystem:activateGlobalTrigger("UNIT_BUFF_STEALED", {
				buff = buffObject,
				unit = unit
			})

			total = total + 1

			self:applyBuffOnTarget(actor, buffObject, nil, workId)
		end
	end

	return total
end

function BuffSystem:cloneBuffsOnTarget(actor, target, condition, workId)
	local targetAgent = self:retrieveTargetAgent(target, false)

	if targetAgent == nil then
		return 0
	end

	local buffs = targetAgent:selectBuffObjects(condition)

	if buffs == nil then
		return 0
	end

	local total = 0

	for i = 1, #buffs do
		local buffObject = buffs[i]

		total = total + 1

		if buffObject._groupId then
			local buffObjs = buffObject:clone()

			for k, v in pairs(buffObjs) do
				self:applyBuffOnTarget(actor, v, nil, workId)
			end
		else
			self:applyBuffOnTarget(actor, buffObject:clone(), nil, workId)
		end
	end

	return total
end
