-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/buffs/effects/PassiveFunEffect.lua

PassiveFunEffect = class("PassiveFunEffect", BuffEffect)

function PassiveFunEffect:initialize(config)
	super.initialize(self, config)

	self._id = config.id
	self._config = config.config
	self._skillSystem = config.skillSystem
	self._actionList = {}
end

function PassiveFunEffect:takeEffect(target, buffObject)
	local data = {}

	data.skillId = self._id
	data.level = 1
	data.proto = self._id
	data.args = self._config

	local skillComp = target:getComponent("Skill")

	if not skillComp then
		return false
	end

	local skill, isNewPassive = skillComp:addPassiveSkill(data)

	self._skillSystem:buildSkillsForActor_PassiveBuff(target, {
		skill
	}, self._actionList, isNewPassive)
	super.takeEffect(self, target, buffObject)

	return true
end

function PassiveFunEffect:cancelEffect(target, buffObject)
	local _target = buffObject:getEffectValue(self, "target")

	if _target == nil or _target ~= target then
		return false
	end

	target:getComponent("Skill"):removePassiveSkill(self._id)

	local timeTrigger = self._skillSystem:getTimeTrigger()

	for i, v in pairs(self._actionList) do
		if v.timer and timeTrigger then
			timeTrigger:removeAction(target, v.listener)
		end
	end

	for i, v in pairs(self._actionList) do
		self._skillSystem:clearTriggersForActorAction(v.event, target, v.listener)
	end

	return true
end
