-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/systems/BattleSkillSystem.lua

local function toSkillAPIFunc(f)
	return function(env, ...)
		return f(...)
	end
end

local kGlobalActiveLock = {}

BattleSkillSystem = class("BattleSkillSystem", BattleSubSystem)

BattleSkillSystem:has("_frameInterval", {
	is = "rw"
})
BattleSkillSystem:has("_globalEnvironment", {
	is = "r"
})
BattleSkillSystem:has("_skillExecutor", {
	is = "r"
})
BattleSkillSystem:has("_skillScheduler", {
	is = "r"
})

function BattleSkillSystem:initialize()
	super.initialize(self)

	self._globalIndices = {}
	self._globalEnvironment = setmetatable({}, {
		__metatable = "private",
		__index = function(t, k)
			local indices = self._globalIndices

			for i = #indices, 1, -1 do
				local val = indices[i][k]

				if val ~= nil then
					rawset(t, k, val)

					return val
				end
			end

			return nil
		end
	})
	self._globalSkillTriggers = {}
	self._specificSkillTriggers = {}
end

function BattleSkillSystem:startup(battleContext)
	super.startup(self, battleContext)

	self._skillExecutor = self:createSkillExecutor()
	self._skillScheduler = BattleSkillScheduler:new(self._skillExecutor)

	return self
end

function BattleSkillSystem:reset()
	return
end

function BattleSkillSystem:update(dt)
	self._skillExecutor:update(dt)
	self._skillScheduler:update(dt)
end

function BattleSkillSystem:stop()
	self._skillScheduler:cancel()
	self._skillExecutor:stopAllActions("finish")
end

function BattleSkillSystem:installBuiltinEnvironment()
	local globals = self._globalEnvironment

	globals.global = globals
	globals["$SkillSystem"] = self

	for name, member in pairs(_G.SkillScriptBuiltins) do
		globals[name] = member
	end

	local math = _G.math

	globals.max = toSkillAPIFunc(math.max)
	globals.min = toSkillAPIFunc(math.min)
	globals.floor = toSkillAPIFunc(math.floor)
	globals.ceil = toSkillAPIFunc(math.ceil)
	globals.abs = toSkillAPIFunc(math.abs)
	globals.sin = toSkillAPIFunc(math.sin)
	globals.cos = toSkillAPIFunc(math.cos)
	globals.random = math.random
	globals.print = toSkillAPIFunc(_G.print)
	globals.assert = toSkillAPIFunc(_G.assert)
	globals.dump = toSkillAPIFunc(_G.dump)
	globals.insert = toSkillAPIFunc(table.insert)
	globals.remove = toSkillAPIFunc(table.remove)
	globals["$next_id"] = 1

	function globals.genID(env)
		local g = env.global

		if not g["$next_id"] then
			g["$next_id"] = g["$next_id"] + 1

			return g["$next_id"]
		end
	end

	globals.kMale = kMale
	globals.kFemale = kFemale
	globals.kTraitDPS = kTraitDPS
	globals.kTraitTANK = kTraitTANK
	globals.kTraitGANK = kTraitGANK

	return globals
end

function BattleSkillSystem:installGlobalEnvironment(skillDevBundle, fastMode)
	local globals = self._globalEnvironment

	if fastMode then
		self._globalIndices[#self._globalIndices + 1] = skillDevBundle
	else
		for name, member in pairs(skillDevBundle) do
			globals[name] = member
		end
	end

	return globals
end

function BattleSkillSystem:createSkillExecutor()
	local skillExecutor = BattleSkillExecutor:new(self._globalEnvironment)

	skillExecutor:setRecorder(self._processRecorder)
	skillExecutor:setDelegate(self)

	return skillExecutor
end

function BattleSkillSystem:cancelSkillsForActor(actor)
	self._skillScheduler:cancel(actor)
end

BattleSkillSystem:implements(ISkillExecutorDelegate)

function BattleSkillSystem:skillActionWillStart(executor, actionEnv, actionArgs)
	return
end

local function mergeHurtsByUnit(hurts)
	local mergedHurts = {}

	for _, hurt in ipairs(hurts) do
		local unit, detail = hurt[1], hurt[2]
		local merged = mergedHurts[unit]

		if merged == nil then
			local var_15_0 = {
				unit = unit
			}

			var_15_0.eft = detail.eft or 0
			var_15_0.crit = detail.crit
			var_15_0.survived = detail.survived
			var_15_0.deadly = detail.deadly
			merged = var_15_0
			mergedHurts[unit] = var_15_0
			mergedHurts[#mergedHurts + 1] = merged
		else
			merged.eft = merged.eft + ((not detail.eft or nil) and 0)
			merged.survived = merged.survived or detail.survived
			merged.deadly = merged.deadly or detail.deadly
			merged.crit = merged.crit or detail.crit
		end
	end

	return mergedHurts
end

function BattleSkillSystem:skillActionDidFinish(executor, actionEnv, reason)
	local global = actionEnv.global
	local healthSystem = global["$HealthSystem"]
	local angerSystem = global["$AngerSystem"]
	local formationSystem = global["$FormationSystem"]
	local references = actionEnv["$references"]

	if references ~= nil then
		actionEnv["$references"] = nil

		for object, cnt in pairs(references) do
			if object.decReferenceCount ~= nil then
				object:decReferenceCount()
			end
		end
	end

	local actor = actionEnv["$actor"]
	local player = actor:getOwner()
	local actorRpComp = actor and actor:getComponent("Anger")
	local hurts = actionEnv["$hurts"]
	local crit = false
	local processed = {}
	local killed = 0

	if hurts then
		local mergedHurts = mergeHurtsByUnit(hurts)

		for _, detail in ipairs(mergedHurts) do
			local from, unit = actor, detail.unit
			local unitHpComp = unit:getComponent("Health")

			if unitHpComp and angerSystem ~= nil and detail.eft ~= nil and detail.eft > 0 then
				self:activateSpecificTrigger(unit, "HURTED", {
					detail = detail,
					attacker = actor
				})

				local battleStatist = self._battleContext:getObject("BattleStatist")

				if battleStatist ~= nil then
					battleStatist:sendStatisticEvent("DoDamage", {
						player = player,
						unit = from,
						target = unit,
						detail = detail
					})
				end
			end

			if healthSystem and detail.survived then
				healthSystem:clearExtraLifeConsumingFlag(unit, actionEnv["$id"])
			end

			if angerSystem and detail.deadly then
				if from then
					local killAnger = unit:getKillAnger()

					if killAnger then
						angerSystem:applyKillAnger(nil, from, killAnger)
					else
						angerSystem:applyAngerRuleOnTarget(nil, from, AngerRules.kKilling)
					end

					self:activateSpecificTrigger(from, "KILL_UNIT", {
						unit = unit
					})
				end

				local master = unit:getOwner():getMasterUnit()
				local masterRage = unit:getMasterRage() or 0

				if masterRage ~= 0 and master then
					angerSystem:applyMasterAnger(nil, master, masterRage)
				end
			end

			if processed[unit] == nil then
				processed[unit] = true

				local items = unit:calcDroppingItems()

				if items then
					if self._processRecorder then
						self._processRecorder:recordObjectEvent(unit:getId(), "Drop", items)
					end

					if self._eventCenter then
						self._eventCenter:dispatchEvent("DropItems", unit, items)
					end
				end

				if detail.deadly then
					killed = killed + 1
				end
			end

			if detail.crit then
				crit = true
			end
		end
	end

	local reflects = actionEnv["$reflects"]

	if reflects then
		local mergedReflects = mergeHurtsByUnit(reflects)

		for _, detail in ipairs(mergedReflects) do
			local unit, from = actor, detail.unit
			local battleStatist = self._battleContext:getObject("BattleStatist")

			if battleStatist ~= nil then
				battleStatist:sendStatisticEvent("DoReflect", {
					player = player,
					unit = from,
					target = unit,
					detail = detail
				})
			end

			if processed[unit] == nil then
				processed[unit] = true

				local items = unit:calcDroppingItems()

				if items then
					if self._processRecorder then
						self._processRecorder:recordObjectEvent(unit:getId(), "Drop", items)
					end

					if self._eventCenter then
						self._eventCenter:dispatchEvent("DropItems", unit, items)
					end
				end
			end
		end
	end

	if crit then
		self:activateGlobalTrigger("UNIT_CRIT", {
			unit = actor
		})
	end

	if killed > 0 then
		local battleStatist = self._battleContext:getObject("BattleStatist")

		if battleStatist ~= nil then
			battleStatist:sendStatisticEvent("SkillKilled", {
				player = player,
				unit = actor,
				skill = actionEnv.this["$skill"],
				killed = killed
			})
		end
	end

	if formationSystem then
		formationSystem:processExcludingUnits(actionEnv["$id"])
	end
end

function BattleSkillSystem:buildSkillsForActor(actor)
	local skillGlobalEnvironment = self._globalEnvironment
	local skillComp = actor:getComponent("Skill")
	local skillList = skillComp:getSkill(kBattlePassiveSkill)

	if skillList then
		for i = 1, #skillList do
			skillList[i]:build(skillGlobalEnvironment)
			self:setupTriggersForActor(actor, skillList[i]:getTriggeredActions())
		end
	end

	local skillList = skillComp:getSkill(kBattleExtraPasvSkill)

	if skillList then
		for i = 1, #skillList do
			skillList[i]:build(skillGlobalEnvironment)
			self:setupTriggersForActor(actor, skillList[i]:getTriggeredActions())
		end
	end

	local skillTypes = {
		kBattleNormalSkill,
		kBattleProudSkill,
		kBattleUniqueSkill,
		kBattleDoubleHitSkill,
		kBattleCounterSkill,
		kBattleDeathSkill,
		kBattleMasterSkill1,
		kBattleMasterSkill2,
		kBattleMasterSkill3
	}

	for i, skillType in ipairs(skillTypes) do
		local skill = skillComp:getSkill(skillType)

		if skill then
			skill:build(skillGlobalEnvironment)
			self:setupSkillSynchroLocks(skill)
			self:setupTriggersForActor(actor, skill:getTriggeredActions())
		end
	end
end

function BattleSkillSystem:buildSkillsForActor_PassiveBuff(actor, skills, actions, isNewPassive)
	if not isNewPassive then
		for i = 1, #skills do
			local triggeredActions = skills[i]:getTriggeredActions()

			for _, entry in ipairs(triggeredActions) do
				actions[entry.listener] = {
					event = entry.event,
					listener = entry.listener,
					timer = entry.timer
				}
			end
		end

		return
	end

	if skills == nil or #skills == 0 then
		return
	end

	local skillGlobalEnvironment = self._globalEnvironment

	for i = 1, #skills do
		local skill = skills[i]

		skill:build(skillGlobalEnvironment)
		self:setupSkillSynchroLocks(skill, actions)
		self:setupTriggersForActorSkill_PassiveBuff(actor, skill, actions)
	end
end

function BattleSkillSystem:clearTriggersForActorAction(name, actor, action)
	if self._globalSkillTriggers[name] ~= nil then
		local trigger = self._globalSkillTriggers[name]

		trigger:removeResponder(action)
	end
end

function BattleSkillSystem:setupTriggersForActorSkill_PassiveBuff(actor, skill, actions)
	local triggeredActions = skill:getTriggeredActions()

	if triggeredActions == nil or #triggeredActions == 0 then
		return
	end

	for _, entry in ipairs(triggeredActions) do
		if entry.event ~= nil then
			self:addEventTriggeredAction(entry.event, actor, entry.listener, entry.priority, entry.oneshot)
		elseif entry.timer ~= nil then
			self:addTimeTriggeredAction(entry.timer, actor, entry.listener, entry.priority)
		end

		actions[entry.listener] = {
			event = entry.event,
			listener = entry.listener,
			timer = entry.timer
		}
	end
end

function BattleSkillSystem:buildSkillsForActorPreEnter(actor)
	local skillGlobalEnvironment = self._globalEnvironment
	local skillComp = actor:getComponent("Skill")
	local skillList = skillComp:getSkill(kBattlePassiveSkill)

	if skillList then
		for i = 1, #skillList do
			skillList[i]:build(skillGlobalEnvironment, true)
			self:setupPreEnterTriggersForActor(actor, skillList[i]:getTriggeredActions())
		end
	end

	local skillList = skillComp:getSkill(kBattleExtraPasvSkill)

	if skillList then
		for i = 1, #skillList do
			skillList[i]:build(skillGlobalEnvironment, true)
			self:setupPreEnterTriggersForActor(actor, skillList[i]:getTriggeredActions())
		end
	end

	local skillTypes = {
		kBattleNormalSkill,
		kBattleProudSkill,
		kBattleUniqueSkill,
		kBattleDoubleHitSkill,
		kBattleCounterSkill,
		kBattleDeathSkill,
		kBattleMasterSkill1,
		kBattleMasterSkill2,
		kBattleMasterSkill3
	}

	for i, skillType in ipairs(skillTypes) do
		local skill = skillComp:getSkill(skillType)

		if skill then
			skill:build(skillGlobalEnvironment, true)
			self:setupSkillSynchroLocks(skill)
			self:setupPreEnterTriggersForActor(actor, skill:getTriggeredActions())
		end
	end
end

function BattleSkillSystem:setupSkillSynchroLocks(skill)
	local skillType = skill:getType()

	if skillType ~= nil and skillType ~= kPassiveSkill then
		for _, action in ipairs(skill:getEntryActions()) do
			action:addSynchroLock(skill:getOwner())
			action:addSynchroLock(kGlobalActiveLock)
		end
	end
end

function BattleSkillSystem:setupTriggersForActor(actor, triggeredActions)
	if triggeredActions == nil or #triggeredActions == 0 then
		return
	end

	for _, entry in ipairs(triggeredActions) do
		if entry.event ~= nil and entry.event ~= "SELF:PRE_ENTER" then
			self:addEventTriggeredAction(entry.event, actor, entry.listener, entry.priority, entry.oneshot)
		elseif entry.timer ~= nil then
			self:addTimeTriggeredAction(entry.timer, actor, entry.listener, entry.priority)
		end
	end
end

function BattleSkillSystem:setupPreEnterTriggersForActor(actor, triggeredActions)
	if triggeredActions == nil or #triggeredActions == 0 then
		return
	end

	for _, entry in ipairs(triggeredActions) do
		if entry.event == "SELF:PRE_ENTER" then
			self:addEventTriggeredAction(entry.event, actor, entry.listener, entry.priority, entry.oneshot)
		end
	end
end

function BattleSkillSystem:clearTriggersForActor(actor)
	assert(actor ~= nil)

	self._specificSkillTriggers[actor] = nil

	for _, trigger in pairs(self._globalSkillTriggers) do
		trigger:removeRespondersOfActor(actor)
	end
end

function BattleSkillSystem:getGlobalTrigger(name, autoCreate)
	local trigger = self._globalSkillTriggers[name]

	if trigger == nil and autoCreate then
		trigger = SkillEventTrigger:new(name)
		self._globalSkillTriggers[name] = trigger
	end

	return trigger
end

function BattleSkillSystem:getSpecificTrigger(object, name, autoCreate)
	local triggersForObject = self._specificSkillTriggers[object]

	if triggersForObject == nil then
		if not autoCreate then
			return nil
		end

		triggersForObject = {}
		self._specificSkillTriggers[object] = triggersForObject
	end

	local trigger = triggersForObject[name]

	if trigger == nil then
		if not autoCreate then
			return nil
		end

		trigger = SkillEventTrigger:new(name)
		triggersForObject[name] = trigger
	end

	return trigger
end

function BattleSkillSystem:addEventTriggeredAction(event, actor, action, priority, oneshot)
	local trigger

	;(event:sub(1, 5) == "SELF:" and self:getSpecificTrigger(actor, event:sub(6), true) or self:getGlobalTrigger(event, true)):addResponder(actor, action, priority, oneshot)
end

function BattleSkillSystem:activateGlobalTrigger(name, args, env)
	local trigger = self:getGlobalTrigger(name, false)

	if not trigger then
		return nil
	end

	return trigger:activate(self._skillScheduler, args)
end

function BattleSkillSystem:activateSpecificTrigger(object, name, args, env)
	local trigger = self:getSpecificTrigger(object, name, false)

	if not trigger then
		return nil
	end

	return trigger:activate(self._skillScheduler, args)
end

function BattleSkillSystem:addTimeTriggeredAction(timer, actor, action, priority)
	local timedTrigger = self._timedTrigger

	if timedTrigger == nil then
		timedTrigger = SkillTimedTrigger:new()
		self._timedTrigger = timedTrigger
	end

	timedTrigger:addAction(timer, actor, action, priority)
end

function BattleSkillSystem:getTimeTrigger()
	return self._timedTrigger
end

function BattleSkillSystem:activateTimingTrigger(time)
	if self._timedTrigger ~= nil then
		self._timedTrigger:update(self._skillScheduler, time)
	end
end
