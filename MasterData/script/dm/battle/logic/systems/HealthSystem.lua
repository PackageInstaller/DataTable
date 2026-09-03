-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/systems/HealthSystem.lua

local floor, ceil, max, min = math.floor, math.ceil, math.max, math.min
local next = _G.next

HealthSystem = class("HealthSystem", BattleSubSystem)

HealthSystem:has("_buffSystem", {
	is = "rw"
})

function HealthSystem:initialize()
	super.initialize(self)

	self._deathlessUnits = {}
end

function HealthSystem:startup(battleContext)
	super.startup(self, battleContext)

	self._skillSystem = battleContext:getObject("SkillSystem")

	return self
end

function HealthSystem:disableDamage()
	self._damageDisabled = true
end

function HealthSystem:enableDamage()
	self._damageDisabled = false
end

function HealthSystem:consumeUnitExtraLife(unit, workId)
	local entry = self._deathlessUnits[unit]

	if entry == nil then
		entry = {}
		self._deathlessUnits[unit] = entry
	end

	if workId and entry[workId] then
		return false
	end

	if workId then
		entry[workId] = true
	end

	local hpComp = unit:getComponent("Health")

	if hpComp == nil then
		return
	end

	local result = hpComp:consumeExtraLife()

	if result and result.remain == 0 then
		local sources = result.sources

		assert(sources ~= nil)
		self:_removeBuffsInSources(unit, sources, workId)
	end
end

function HealthSystem:hasExtraLifeConsumingFlag(unit, workId)
	local entry = self._deathlessUnits[unit]

	return entry and entry[workId]
end

function HealthSystem:clearExtraLifeConsumingFlag(unit, workId)
	local entry = self._deathlessUnits[unit]

	if entry and workId then
		entry[workId] = nil

		if next(entry) == nil then
			self._deathlessUnits[unit] = nil
		end
	end
end

function HealthSystem:performHealthDamage(actor, target, damage, lowerLimit, workId, notLastHit)
	if self._damageDisabled then
		return nil
	end

	if not target:isInStages(ULS_Normal) then
		return nil
	end

	local targetHpComp = target:getComponent("Health")

	if targetHpComp == nil then
		return nil
	end

	local dmgIsTable = type(damage) == "table"
	local dmgval = 0

	dmgval = dmgIsTable and floor(damage.val) or floor(damage)

	if dmgval <= 0 then
		return nil
	end

	local prevHpRatio = targetHpComp:getHpRatio()
	local actorGenre
	local targetGenre
	local result = {
		eft = 0,
		raw = dmgval,
		val = targetHpComp:getHp(),
		act = workId,
		notLastHit = notLastHit,
		actorGenre = (actor and actor._genre or nil) and actor._genre,
		targetGenre = (target and target._genre or nil) and target._genre
	}

	if dmgIsTable then
		result.crit = damage.crit
		result.block = damage.block
		result.dotStatus = damage.dotStatus
	end

	local brokenShields
	local tranforHpComp = targetHpComp:getTrasforHpComp()

	if targetHpComp:isImmune() then
		result.immune = true
	elseif tranforHpComp then
		if dmgIsTable then
			damage.val = damage.val * tranforHpComp.radio
		else
			damage = damage * tranforHpComp.radio
		end

		target = tranforHpComp.comp:getEntity()

		local result = self:performHealthDamage(actor, target, damage, lowerLimit, workId, notLastHit)

		if result then
			local transforTarget = target

			return result, transforTarget
		end
	else
		local shieldResult = targetHpComp:consumeShield(dmgval)

		if shieldResult then
			dmgval = dmgval - shieldResult.cost
			result.shldCost = shieldResult.cost
			result.shldVal = shieldResult.val
			brokenShields = shieldResult.sources

			if shieldResult.cost > 0 and brokenShields and #brokenShields > 0 then
				result.brokeShield = true
			end
		end

		if dmgval > 0 then
			local mayConsumeExtraLive = false

			if lowerLimit == nil or lowerLimit < 1 then
				if self:hasExtraLifeConsumingFlag(target, workId) then
					lowerLimit = 1
				elseif targetHpComp:getExtraLives() > 0 then
					mayConsumeExtraLive = true
					lowerLimit = 1
				end
			end

			local damageResult = targetHpComp:applyDamage(dmgval, lowerLimit)

			if damageResult ~= nil then
				result.eft = damageResult.eft
				result.val = damageResult.val

				if mayConsumeExtraLive and damageResult.limited and self:consumeUnitExtraLife(target, workId) then
					result.survived = true
				end

				if damageResult.deadly then
					result.deadly = true

					if target:getUnitType() == BattleUnitType.kMaster and target:getTransformData() == nil then
						result.final = true
					end
				end
			end
		end
	end

	if result and self._processRecorder then
		self._processRecorder:recordObjectEvent(target:getId(), "Hurt", result, workId)
	end

	if brokenShields ~= nil then
		self:_removeBuffsInSources(target, brokenShields, workId)
	end

	local curHpRatio = targetHpComp:getHpRatio()

	if self._eventCenter then
		self._eventCenter:dispatchEvent("EntityHurt", {
			how = "Damage",
			actor = actor,
			target = target,
			hurt = result,
			prevHpRatio = prevHpRatio,
			curHpRatio = curHpRatio,
			workId = workId
		})
	end

	return result
end

function HealthSystem:performCheckDeadlyDamage(actor, target, damage)
	if self._skillSystem then
		self._skillSystem:activateGlobalTrigger("UNIT_DEADHPREDUCE", {
			actor = actor,
			target = target,
			damage = damage
		})
	end
end

function HealthSystem:performHealthReduce(target, damage, workId, actor, isFlyLabel)
	if self._damageDisabled then
		return nil
	end

	if not target:isInStages(ULS_Normal) then
		return nil
	end

	local targetHpComp = target:getComponent("Health")

	if targetHpComp == nil then
		return nil
	end

	local lowerLimit = 1
	local dmgIsTable = type(damage) == "table"
	local dmgval = 0

	dmgval = dmgIsTable and floor(damage.val) or floor(damage)

	if dmgval <= 0 then
		return nil
	end

	local prevHpRatio = targetHpComp:getHpRatio()
	local result = {
		eft = 0,
		raw = dmgval,
		val = targetHpComp:getHp(),
		act = workId
	}

	if dmgIsTable then
		result.crit = damage.crit
		result.block = damage.block
		result.dotStatus = damage.dotStatus
	end

	local brokenShields
	local shieldResult = targetHpComp:consumeShield(dmgval)

	if shieldResult then
		dmgval = dmgval - shieldResult.cost
		result.shldCost = shieldResult.cost
		result.shldVal = shieldResult.val
		brokenShields = shieldResult.sources

		if shieldResult.cost > 0 and brokenShields and #brokenShields > 0 then
			result.brokeShield = true
		end
	end

	if dmgval > 0 then
		local damageResult = targetHpComp:applyDamage(dmgval, lowerLimit)

		if damageResult ~= nil then
			result.eft = damageResult.eft
			result.val = damageResult.val
			result.deadly = damageResult.result
		end
	end

	if result and self._processRecorder then
		result.isFlyLabel = isFlyLabel

		self._processRecorder:recordObjectEvent(target:getId(), "HpReduce", result, workId)
	end

	if brokenShields ~= nil then
		self:_removeBuffsInSources(target, brokenShields, workId)
	end

	local curHpRatio = targetHpComp:getHpRatio()

	if floor(prevHpRatio * 100) ~= floor(curHpRatio * 100) or curHpRatio <= 0 then
		self._skillSystem:activateGlobalTrigger("UNIT_HPCHANGE", {
			how = "Reduce",
			unit = target,
			prevHpPercent = floor(prevHpRatio * 100),
			curHpPercent = floor(curHpRatio * 100),
			actor = actor,
			hurt = result or {}
		})

		if actor and result and result.deadly then
			self._skillSystem:activateGlobalTrigger("UNIT_BEKILLED", {
				unit = target,
				prevHpPercent = floor(prevHpRatio * 100),
				curHpPercent = floor(curHpRatio * 100),
				how = how,
				actor = actor,
				hurt = result
			})
		end
	end

	return result
end

function HealthSystem:performHealthRecovery(actor, target, recovery, workId)
	if not target:isInStages(ULS_Normal) then
		return
	end

	local targetHpComp = target:getComponent("Health")

	if targetHpComp == nil then
		return nil
	end

	local prevHpRatio = targetHpComp:getHpRatio()
	local result

	if type(recovery) == "table" then
		result = targetHpComp:applyRecovery(floor(recovery.val))

		if result then
			result.crit = recovery.crit
		end
	else
		result = targetHpComp:applyRecovery(floor(recovery))
	end

	if result then
		if self._processRecorder then
			self._processRecorder:recordObjectEvent(target:getId(), "Cured", result, workId)
		end

		local curHpRatio = targetHpComp:getHpRatio()

		if self._eventCenter then
			self._eventCenter:dispatchEvent("EntityCure", {
				how = "Recovery",
				actor = actor,
				target = target,
				cure = result,
				prevHpRatio = prevHpRatio,
				curHpRatio = curHpRatio,
				workId = workId
			})
		end
	end

	return result
end

function HealthSystem:performReflection(actor, target, rawDamage, workId)
	local targetAttrComp = target:getComponent("Numeric")
	local reflection = targetAttrComp and targetAttrComp:getAttrValue(kAttrReflection) or 0
	local atkvalue = targetAttrComp and targetAttrComp:getAttrValue(kAttrAttack) or 0

	if reflection <= 0 then
		return nil
	end

	local actorHpComp = actor:getComponent("Health")

	if actorHpComp == nil then
		return nil
	end

	local tranforHpComp = actorHpComp:getTrasforHpComp()

	if tranforHpComp then
		transforActor = tranforHpComp.comp:getEntity()

		return self:performReflection(transforActor, target, rawDamage, workId), transforActor
	end

	local reflection_UpLimit = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Reflection_UpLimit", "content")
	local reflectedValue = max(floor(rawDamage * reflection), 1)
	local reflectedValue = min(reflectedValue, atkvalue * (reflection_UpLimit or 1))
	local result = {
		raw = reflectedValue
	}
	local prevHpRatio = actorHpComp:getHpRatio()
	local brokenShields

	if actorHpComp:isImmune() then
		result.immune = true
	else
		local shieldResult = actorHpComp:consumeShield(reflectedValue)

		if shieldResult then
			reflectedValue = reflectedValue - shieldResult.cost
			result.shldCost = shieldResult.cost
			result.shldVal = shieldResult.val
			brokenShields = shieldResult.sources
		end

		if reflectedValue > 0 then
			local damageResult = actorHpComp:applyDamage(reflectedValue, 1)

			if damageResult ~= nil then
				result.eft = damageResult.eft
				result.val = damageResult.val
			end
		end
	end

	if result.eft == nil then
		result.eft = 0
		result.val = actorHpComp:getHp()
	end

	if self._processRecorder then
		self._processRecorder:recordObjectEvent(actor:getId(), "Reflected", result, workId)
	end

	if brokenShields ~= nil then
		self:_removeBuffsInSources(actor, brokenShields, workId)
	end

	if self._eventCenter then
		local curHpRatio = actorHpComp:getHpRatio()

		self._eventCenter:dispatchEvent("EntityHurt", {
			how = "Reflected",
			actor = target,
			target = actor,
			hurt = result,
			prevHpRatio = prevHpRatio,
			curHpRatio = curHpRatio,
			workId = workId
		})
	end

	return result
end

function HealthSystem:performAbsorption(actor, target, rawDamage, workId)
	local actorAttrComp = actor:getComponent("Numeric")
	local absorption = actorAttrComp and actorAttrComp:getAttrValue(kAttrAbsorption) or 0

	if absorption <= 0 then
		return nil
	end

	local actorHpComp = actor:getComponent("Health")

	if actorHpComp == nil then
		return nil
	end

	local prevHpRatio = actorHpComp:getHpRatio()
	local absorbedValue = max(floor(rawDamage * absorption), 1)
	local result = actorHpComp:applyRecovery(absorbedValue)

	if not result then
		return nil
	end

	if self._processRecorder then
		self._processRecorder:recordObjectEvent(actor:getId(), "Absorb", result, workId)
	end

	if self._eventCenter then
		local curHpRatio = actorHpComp:getHpRatio()

		self._eventCenter:dispatchEvent("EntityCure", {
			how = "Absorb",
			actor = actor,
			target = actor,
			cure = result,
			prevHpRatio = prevHpRatio,
			curHpRatio = curHpRatio,
			workId = workId
		})
	end

	return result
end

function HealthSystem:_removeBuffsInSources(target, sources, workId)
	if sources == nil or self._buffSystem == nil then
		return
	end

	local buffObjects = {}

	for i, source in ipairs(sources) do
		buffObjects[source.buffObj] = true
	end

	local function condition(buffObject)
		return buffObjects[buffObject]
	end

	self._buffSystem:brokeBuffsOnTarget(target, condition, workId)
end
