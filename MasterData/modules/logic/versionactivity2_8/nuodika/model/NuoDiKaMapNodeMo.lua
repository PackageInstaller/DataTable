-- chunkname: @modules/logic/versionactivity2_8/nuodika/model/NuoDiKaMapNodeMo.lua

module("modules.logic.versionactivity2_8.nuodika.model.NuoDiKaMapNodeMo", package.seeall)

local NuoDiKaMapNodeMo = pureTable("NuoDiKaMapNodeMo")

function NuoDiKaMapNodeMo:init(node)
	self.x = node[1]
	self.y = node[2]
	self.id = 100 * self.x + self.y
	self.nodeType = node[3]
	self.eventList = {}

	for _, eventId in ipairs(node[4]) do
		table.insert(self.eventList, eventId)
	end

	self.initEventCo = nil

	self:resetNode()
end

function NuoDiKaMapNodeMo:getInitEvent()
	return self.initEventCo
end

function NuoDiKaMapNodeMo:getEvent()
	return self.eventCo
end

function NuoDiKaMapNodeMo:clearEvent()
	self.hp = 0
	self.atk = 0
	self.limitInteract = 0
	self.eventCo = nil
	self.isWarn = false
end

function NuoDiKaMapNodeMo:setNodeEvent(eventId)
	if eventId and eventId > 0 then
		self.eventCo = NuoDiKaConfig.instance:getEventCo(eventId)
	end

	if self.eventCo then
		if self.eventCo.initVisible > 0 then
			if not self.isUnlock and self.eventCo.eventType == NuoDiKaEnum.EventType.Enemy then
				local enemyCo = NuoDiKaConfig.instance:getEnemyCo(self.eventCo.eventParam)
				local skillCo = NuoDiKaConfig.instance:getSkillCo(enemyCo.skillID)
				local triggers = string.splitToNumber(skillCo.trigger, "#")

				if triggers[1] == NuoDiKaEnum.TriggerTimingType.InteractTimes then
					self.interactTimes = triggers[2]
				end
			end

			self.isUnlock = true
		end

		if self.eventCo.eventType == NuoDiKaEnum.EventType.Enemy then
			local enemyCo = NuoDiKaConfig.instance:getEnemyCo(self.eventCo.eventParam)

			self.hp = enemyCo.hp
			self.atk = enemyCo.atk
		end
	end
end

function NuoDiKaMapNodeMo:setNodeUnlock(unlock)
	if not self.isUnlock and unlock and self.eventCo and self.eventCo.eventType == NuoDiKaEnum.EventType.Enemy then
		local enemyCo = NuoDiKaConfig.instance:getEnemyCo(self.eventCo.eventParam)
		local skillCo = NuoDiKaConfig.instance:getSkillCo(enemyCo.skillID)
		local triggers = string.splitToNumber(skillCo.trigger, "#")

		if triggers[1] == NuoDiKaEnum.TriggerTimingType.InteractTimes then
			self.interactTimes = triggers[2]
		end
	end

	self.isUnlock = unlock
end

function NuoDiKaMapNodeMo:isNodeUnlock()
	return self.isUnlock
end

function NuoDiKaMapNodeMo:isNodeHasEnemy()
	if self.eventCo and self.eventCo.eventType == NuoDiKaEnum.EventType.Enemy then
		return true
	end

	return false
end

function NuoDiKaMapNodeMo:setNodeItemUse()
	self.eventCo = nil
end

function NuoDiKaMapNodeMo:isNodeHasItem()
	if self.eventCo and self.eventCo.eventType == NuoDiKaEnum.EventType.Item then
		return true
	end

	return false
end

function NuoDiKaMapNodeMo:reduceHp(hurtCount)
	self.hp = self.hp - hurtCount

	if self.hp <= 0 then
		self:clearEvent()
	end
end

function NuoDiKaMapNodeMo:reduceAtk(atkCount)
	self.atk = self.atk - atkCount
end

function NuoDiKaMapNodeMo:reduceInteract(interactCount)
	if not self.eventCo or self.eventCo.eventType ~= NuoDiKaEnum.EventType.Enemy then
		return
	end

	local enemyCo = NuoDiKaConfig.instance:getEnemyCo(self.eventCo.eventParam)
	local skillCo = NuoDiKaConfig.instance:getSkillCo(enemyCo.skillID)
	local triggers = string.splitToNumber(skillCo.trigger, "#")

	if triggers[1] ~= NuoDiKaEnum.TriggerTimingType.InteractTimes then
		return
	end

	self.interactTimes = self.interactTimes - interactCount

	if self.interactTimes <= 0 then
		self.interactTimes = triggers[2]
	end
end

function NuoDiKaMapNodeMo:isTriggerTypeEnemy()
	if not self.eventCo or self.eventCo.eventType ~= NuoDiKaEnum.EventType.Enemy then
		return false
	end

	local enemyCo = NuoDiKaConfig.instance:getEnemyCo(self.eventCo.eventParam)
	local skillCo = NuoDiKaConfig.instance:getSkillCo(enemyCo.skillID)
	local triggers = string.splitToNumber(skillCo.trigger, "#")

	if triggers[1] ~= NuoDiKaEnum.TriggerTimingType.InteractTimes then
		return false
	end

	return true
end

function NuoDiKaMapNodeMo:gainHp(hpCount)
	self.hp = self.hp + hpCount
end

function NuoDiKaMapNodeMo:gainAtk(atkCount)
	self.atk = self.atk + atkCount
end

function NuoDiKaMapNodeMo:setWarn(warn)
	self.isWarn = warn
end

function NuoDiKaMapNodeMo:resetNode()
	self.isUnlock = false
	self.isWarn = false
	self.eventCo = nil

	local eventId = 0

	self.hp = 0
	self.atk = 0

	if self.nodeType == NuoDiKaEnum.NodeType.Normal then
		eventId = self.eventList[1]
	elseif self.nodeType == NuoDiKaEnum.NodeType.Random then
		eventId = self.eventList[math.random(1, #self.eventList)]
	end

	if eventId and eventId > 0 then
		self.eventCo = NuoDiKaConfig.instance:getEventCo(eventId)
		self.initEventCo = NuoDiKaConfig.instance:getEventCo(eventId)
	end

	if self.eventCo then
		if self.eventCo.initVisible > 0 then
			if not self.isUnlock and self.eventCo.eventType == NuoDiKaEnum.EventType.Enemy then
				local enemyCo = NuoDiKaConfig.instance:getEnemyCo(self.eventCo.eventParam)
				local skillCo = NuoDiKaConfig.instance:getSkillCo(enemyCo.skillID)
				local triggers = string.splitToNumber(skillCo.trigger, "#")

				if triggers[1] == NuoDiKaEnum.TriggerTimingType.InteractTimes then
					self.interactTimes = triggers[2]
				end
			end

			self.isUnlock = true
		end

		if self.eventCo.eventType == NuoDiKaEnum.EventType.Enemy then
			local enemyCo = NuoDiKaConfig.instance:getEnemyCo(self.eventCo.eventParam)

			self.hp = enemyCo.hp
			self.atk = enemyCo.atk
		end
	end
end

function NuoDiKaMapNodeMo:getEventList()
	return self.eventList
end

return NuoDiKaMapNodeMo
