-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/buffs/effects/ImmuneTrapBuffEffect.lua

ImmuneTrapBuffEffect = class("ImmuneTrapBuffEffect", BuffEffect)

function ImmuneTrapBuffEffect:initialize(config)
	super.initialize(self, config)

	self._filter = config.filter
end

function ImmuneTrapBuffEffect:takeEffect(target, buffObject)
	local targetAgent = buffObject:getActiveTarget()

	if targetAgent ~= nil and self._filter ~= nil then
		targetAgent:addImmuneSelector(self._filter, "trap")
	end

	return true
end

function ImmuneTrapBuffEffect:cancelEffect(target, buffObject)
	local targetAgent = buffObject:getActiveTarget()

	if targetAgent ~= nil and self._filter ~= nil then
		targetAgent:removeImmuneSelector(self._filter)
	end

	return true
end
