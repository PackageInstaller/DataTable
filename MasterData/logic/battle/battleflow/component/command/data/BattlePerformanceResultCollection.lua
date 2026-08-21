-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/data/BattlePerformanceResultCollection.lua

module("logic.battle.battleflow.component.command.data.BattlePerformanceResultCollection", package.seeall)

local BattlePerformanceResultCollection = class("BattlePerformanceResultCollection", AbstractGlobalReusable)

function BattlePerformanceResultCollection:parseEventNOList(eventNOList)
	for _, eventNO in ipairs(eventNOList) do
		self:_addEventNO(eventNO)
	end
end

function BattlePerformanceResultCollection:parseEventNO(eventNO)
	self:_addEventNO(eventNO)
end

function BattlePerformanceResultCollection:ctor()
	self.normalList = {}
	self.hpChangedList = {}
	self.entityDeadList = {}
	self.weakPointBrokenList = {}
	self.buffRemovedList = {}
	self.afterPerformanceList = {}
	self.specialPropertyModifiedList = {}
	self.triggeringList = {}
	self.tagEventList = {}
end

function BattlePerformanceResultCollection:reset()
	BattleTableUtil.clearTable(self.normalList)
	BattleTableUtil.clearTable(self.hpChangedList)
	BattleTableUtil.clearTable(self.entityDeadList)
	BattleTableUtil.clearTable(self.weakPointBrokenList)
	BattleTableUtil.clearTable(self.buffRemovedList)
	BattleTableUtil.clearTable(self.afterPerformanceList)
	BattleTableUtil.clearTable(self.specialPropertyModifiedList)
	BattleTableUtil.clearTable(self.triggeringList)
	BattleTableUtil.clearTable(self.tagEventList)
end

function BattlePerformanceResultCollection:destroy()
	self.normalList = nil
	self.hpChangedList = nil
	self.entityDeadList = nil
	self.weakPointBrokenList = nil
	self.buffRemovedList = nil
	self.afterPerformanceList = nil
	self.specialPropertyModifiedList = nil
	self.triggeringList = nil
	self.tagEventList = nil
end

function BattlePerformanceResultCollection:isEntityDead(entityId)
	for i, eventNO in ipairs(self.entityDeadList) do
		if BattleEntityDeadCommand:isDeadByAttackEventNO(eventNO) and eventNO.entityDead.entity == entityId then
			return true
		end
	end

	return false
end

function BattlePerformanceResultCollection:_addEventNO(eventNO)
	if BattleCmdUtil.hasField(eventNO, BattleCmdUtil.cmd_weakPointStatusChanged) then
		table.insert(self.weakPointBrokenList, eventNO)
	elseif BattleCmdUtil.hasField(eventNO, BattleCmdUtil.cmd_entityDead) then
		table.insert(self.entityDeadList, eventNO)
	elseif BattleCmdUtil.hasField(eventNO, BattleCmdUtil.cmd_triggering) then
		table.insert(self.triggeringList, eventNO)
	elseif BattleCmdUtil.hasField(eventNO, BattleCmdUtil.cmd_buffRemoved) or BattleCmdUtil.hasField(eventNO, BattleCmdUtil.cmd_buffRoundDecred) then
		table.insert(self.buffRemovedList, eventNO)
	elseif BattleCmdUtil.hasField(eventNO, BattleCmdUtil.cmd_battleEnded) or BattleCmdUtil.hasField(eventNO, BattleCmdUtil.cmd_plotChainTriggered) then
		table.insert(self.afterPerformanceList, eventNO)
	elseif BattlePropertyModifiedCommand:isSpecialPropertyModifiedCommand(eventNO) then
		table.insert(self.specialPropertyModifiedList, eventNO)
	elseif BattlePropertyModifiedCommand:isHpPropertyModifiedCommand(eventNO) then
		table.insert(self.hpChangedList, eventNO)
	elseif BattleCmdUtil.hasField(eventNO, BattleCmdUtil.cmd_tagTriggered) then
		table.insert(self.tagEventList, eventNO)
	else
		table.insert(self.normalList, eventNO)
	end
end

function BattlePerformanceResultCollection:checkPlayCast(eventNOList)
	if self:checkOnlyTags(eventNOList) then
		return false
	end

	if not PlayerLocalStorageModel.instance:getSimpleSkillCast() then
		return true
	end

	local playCast = false

	for _, eventNO in ipairs(eventNOList) do
		if BattleCmdUtil.hasField(eventNO, BattleCmdUtil.cmd_damaged) or BattleCmdUtil.hasField(eventNO, BattleCmdUtil.cmd_groupEvent) or BattleCmdUtil.hasField(eventNO, BattleCmdUtil.cmd_cured) or BattleCmdUtil.hasField(eventNO, BattleCmdUtil.cmd_positionChanged) or BattleCmdUtil.hasField(eventNO, BattleCmdUtil.cmd_entitiesAdded) or BattleCmdUtil.hasField(eventNO, BattleCmdUtil.cmd_terrainUpdated) or BattleCmdUtil.hasField(eventNO, BattleCmdUtil.cmd_terrainChange) or BattleCmdUtil.hasField(eventNO, BattleCmdUtil.cmd_buffRemoved) or BattleCmdUtil.hasField(eventNO, BattleCmdUtil.cmd_buffRoundDecred) or BattleCmdUtil.hasField(eventNO, BattleCmdUtil.cmd_buffAdded) or BattleCmdUtil.hasField(eventNO, BattleCmdUtil.cmd_entitiesSwapped) then
			playCast = true

			break
		end
	end

	return playCast
end

function BattlePerformanceResultCollection:checkOnlyTags(eventNOList)
	local onlyTags = false

	for _, eventNO in ipairs(eventNOList) do
		if BattleCmdUtil.hasField(eventNO, BattleCmdUtil.cmd_tagTriggered) then
			onlyTags = true
		else
			return false
		end
	end

	return onlyTags
end

function BattlePerformanceResultCollection:hasTagExceptChase()
	for i, eventNO in ipairs(self.tagEventList) do
		local tagId = eventNO.tag.base.tagId
		local tagCO = ActiveSkillConfig.instance:getSkillTagCO(tagId)

		if tagCO and tagCO.typeName ~= BattleConst.Chase then
			return true
		end
	end

	return false
end

function BattlePerformanceResultCollection:getOneVictim()
	for i, eventNO in ipairs(self.normalList) do
		if BattleCmdUtil.hasField(eventNO, BattleCmdUtil.cmd_damaged) then
			return eventNO.damaged.entity
		elseif BattleCmdUtil.hasField(eventNO, BattleCmdUtil.cmd_cured) then
			return eventNO.cured.entity
		elseif BattleCmdUtil.hasField(eventNO, BattleCmdUtil.cmd_entitiesAdded) then
			local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(eventNO.entitiesAdded[1].cell.x, eventNO.entitiesAdded[1].cell.z)

			return eventNO.entitiesAdded[1].id, unionIndex
		elseif BattleCmdUtil.hasField(eventNO, BattleCmdUtil.cmd_skillAdd) then
			return eventNO.skillAdded.entity
		elseif BattleCmdUtil.hasField(eventNO, BattleCmdUtil.cmd_groupEvent) and #eventNO.groupEvent.events > 0 then
			if eventNO.groupEvent.events[1].damaged.entity ~= 0 then
				return eventNO.groupEvent.events[1].damaged.entity
			elseif eventNO.groupEvent.events[1].cured.entity ~= 0 then
				return eventNO.groupEvent.events[1].cured.entity
			end
		end
	end
end

function BattlePerformanceResultCollection:parseEventNOListForMultiRoundAoe(eventNOList)
	for _, eventNO in ipairs(eventNOList) do
		if BattleCmdUtil.hasField(eventNO, BattleCmdUtil.cmd_multiRoundAoeAdd) then
			return eventNO.multiRoundAoeAdd
		end
	end
end

function BattlePerformanceResultCollection:parseEffectNOListForMultiRoundHold(effects)
	for i, effect in ipairs(effects) do
		for _, eventNO in ipairs(effect.events) do
			if BattleCmdUtil.hasField(eventNO, BattleCmdUtil.cmd_multiRoundHold) then
				return eventNO.multiEntityHold
			end
		end
	end
end

function BattlePerformanceResultCollection:parseEventNOListForSkillTriggered(eventNOList)
	for _, eventNO in ipairs(eventNOList) do
		if BattleCmdUtil.hasField(eventNO, BattleCmdUtil.cmd_skillTriggered) then
			return eventNO.skillTriggered
		end
	end
end

function BattlePerformanceResultCollection:tryMergeDamage()
	local enitity2DamageEvent = BattleTableUtil.getTempList()
	local removeEventIdxList = BattleTableUtil.getTempList()

	for i, eventNO in pairs(self.normalList) do
		if BattleCmdUtil.hasField(eventNO, BattleCmdUtil.cmd_damaged) then
			local entityId = eventNO.damaged.entity

			if not enitity2DamageEvent[entityId] then
				enitity2DamageEvent[entityId] = eventNO.damaged
			else
				local DamagedEventNO = enitity2DamageEvent[entityId]

				DamagedEventNO.damageValue = DamagedEventNO.damageValue + eventNO.damaged.damageValue
				DamagedEventNO.weakPointDamage = DamagedEventNO.weakPointDamage + eventNO.damaged.weakPointDamage
				DamagedEventNO.hpDecrement = DamagedEventNO.hpDecrement + eventNO.damaged.hpDecrement
				DamagedEventNO.hpDecrementOverflow = DamagedEventNO.hpDecrementOverflow + eventNO.damaged.hpDecrementOverflow

				table.insert(removeEventIdxList, i)
			end
		end
	end

	for i = #removeEventIdxList, 1, -1 do
		table.remove(self.normalList, removeEventIdxList[i])
	end

	BattleTableUtil.releaseTempList(enitity2DamageEvent)
	BattleTableUtil.releaseTempList(removeEventIdxList)
end

return BattlePerformanceResultCollection
