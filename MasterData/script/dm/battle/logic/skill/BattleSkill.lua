-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/skill/BattleSkill.lua

local function updateTable(dst, src)
	if src == nil then
		return dst
	end

	if dst == nil then
		dst = {}
	end

	for k, v in pairs(src) do
		dst[k] = v
	end

	return dst
end

BattleSkillAction = class("BattleSkillAction")

BattleSkillAction:has("_name", {
	is = "r"
})
BattleSkillAction:has("_entryFunction", {
	is = "r"
})
BattleSkillAction:has("_isEntryAction", {
	is = "rwb"
})
BattleSkillAction:has("_ownerSkill", {
	is = "rw"
})
BattleSkillAction:has("_duration", {
	is = "rw"
})
BattleSkillAction:has("_cutInAnimation", {
	is = "rw"
})
BattleSkillAction:has("_proudAnimation", {
	is = "rw"
})
BattleSkillAction:has("_effectRes", {
	is = "rw"
})

function BattleSkillAction:initialize(actionConfig)
	super.initialize(self)

	self["$type"] = "action"
	self._name = actionConfig.name
	self._entryFunction = actionConfig.entry
	self._isEntryAction = false
end

function BattleSkillAction:getFullName()
	local ownerSkill = self._ownerSkill

	if ownerSkill then
		return ownerSkill:getId() .. ":" .. self._name
	else
		return "~:" .. self._name
	end
end

function BattleSkillAction:getSkillScope()
	return self._ownerSkill and self._ownerSkill:getThisScope()
end

function BattleSkillAction:addSynchroLock(lock)
	local synchroLocks = self._synchroLocks

	if synchroLocks == nil then
		synchroLocks = {}
		self._synchroLocks = synchroLocks
	end

	synchroLocks[#synchroLocks + 1] = lock
end

function BattleSkillAction:removeSynchroLock(lock)
	local synchroLocks = self._synchroLocks

	if synchroLocks == nil then
		return
	end

	for i = 1, #synchroLocks do
		if synchroLocks[i] == lock then
			table.remove(synchroLocks, i)
		end
	end
end

function BattleSkillAction:getSynchroLocks()
	return self._synchroLocks
end

BattleSkill = class("BattleSkill")

BattleSkill:has("_id", {
	is = "r"
})
BattleSkill:has("_type", {
	is = "rw"
})
BattleSkill:has("_owner", {
	is = "rw"
})
BattleSkill:has("_level", {
	is = "rw"
})
BattleSkill:has("_prototype", {
	is = "r"
})
BattleSkill:has("_range", {
	is = "r"
})
BattleSkill:has("_dblhitRate", {
	is = "rw"
})
BattleSkill:has("_canDoubleHit", {
	is = "rwb"
})
BattleSkill:has("_canBeHitBack", {
	is = "rwb"
})
BattleSkill:has("_notAskForTarget", {
	is = "rwb"
})

function BattleSkill:initialize(skillConfig)
	super.initialize(self)

	self._id = skillConfig.skillId
	self._level = skillConfig.level or 1
	self._icon = skillConfig.icon
	self._dblhitRate = skillConfig.dblrate or 0
	self._canDoubleHit = skillConfig.dblhit
	self._canBeHitBack = skillConfig.behit
	self._notAskForTarget = skillConfig.notAskForTarget
	self._proto = skillConfig.proto
	self._args = skillConfig.args
	self._range = skillConfig.range
end

function BattleSkill:clone()
	local skill = BattleSkill:new({
		skillId = self._id,
		level = self._level,
		icon = self._icon,
		dblrate = self._dblhitRate,
		dblhit = self._canDoubleHit,
		behit = self._canBeHitBack,
		proto = self._proto,
		args = self._args,
		range = self._range
	})

	skill._skillType = self._skillType

	return skill
end

function BattleSkill:dumpInformation()
	return {
		id = self:getId(),
		type = self:getType(),
		level = self._level,
		icon = self._icon
	}
end

function BattleSkill:getArgs()
	return self._args
end

function BattleSkill:build(globalScope, force)
	if self._prototype and not force then
		return
	end

	self._triggers = nil

	local externalVars = {}

	updateTable(externalVars, self._args)

	externalVars.skill = self
	externalVars.type = self._type
	externalVars.owner = self._owner or globalScope.null
	externalVars.level = self._level

	local prototype = globalScope[self._proto]

	assert(prototype ~= nil, string.format("Skill for name \"%s\" is not defined!", self._proto))

	self._prototype = prototype

	local thisScope = prototype:__new__(externalVars, globalScope)

	self._thisScope = thisScope
	self._actions = {}

	local actionRegistry = thisScope["$actions"]

	if actionRegistry then
		local actions = self._actions

		for _, action in ipairs(actionRegistry) do
			action:setOwnerSkill(self)

			actions[action:getName()] = action
		end

		if self:getDefaultEntry() == nil and actions.main ~= nil then
			self:setDefaultEntry(actions.main)
		end
	end

	return self
end

function BattleSkill:setType(type)
	self._type = type

	if self._thisScope then
		self._thisScope["$type"] = type
	end
end

function BattleSkill:setOwner(owner)
	self._owner = owner

	if self._thisScope then
		self._thisScope["$owner"] = owner
	end
end

function BattleSkill:setLevel(level)
	self._level = level

	if self._thisScope then
		self._thisScope["$level"] = level
	end
end

function BattleSkill:getThisScope()
	return self._thisScope
end

function BattleSkill:getActionByName(name)
	return self._actions and self._actions[name]
end

function BattleSkill:setDefaultEntry(action)
	action:setIsEntryAction(true)

	self._defaultEntry = action
end

function BattleSkill:getDefaultEntry()
	return self._defaultEntry
end

function BattleSkill:setQualifiedEntry(state, action)
	if self._qualifiedEntries == nil then
		self._qualifiedEntries = {}
	end

	action:setIsEntryAction(true)

	self._qualifiedEntries[state] = action
end

function BattleSkill:getQualifiedEntry(state)
	local qualifiedEntries = self._qualifiedEntries

	return qualifiedEntries and qualifiedEntries[state]
end

function BattleSkill:getEntryAction(state)
	local qualifiedEntries = self._qualifiedEntries

	return (qualifiedEntries or nil) and (qualifiedEntries[state] or self._defaultEntry)
end

function BattleSkill:getEntryActions()
	local actions = {
		self._defaultEntry
	}
	local thisScope = self._thisScope
	local actionRegistry = thisScope and thisScope["$actions"]

	if actionRegistry then
		for i, action in ipairs(actionRegistry) do
			if action ~= self._defaultEntry and action:isEntryAction() then
				actions[#actions + 1] = action
			end
		end
	end

	return actions
end

function BattleSkill:addEventTriggeredAction(event, action, priority, oneshot)
	return self:addTriggeredAction({
		event = event,
		priority = priority,
		oneshot = oneshot,
		listener = action
	})
end

function BattleSkill:addTimeTriggeredAction(timer, action, priority)
	return self:addTriggeredAction({
		timer = timer,
		priority = priority,
		listener = action
	})
end

function BattleSkill:addTriggeredAction(trigger)
	local triggers = self._triggers

	if triggers == nil then
		triggers = {}
		self._triggers = triggers
	end

	triggers[#triggers + 1] = trigger
end

function BattleSkill:getTriggeredActions()
	return self._triggers
end
