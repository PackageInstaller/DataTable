-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/buffs/effects/ImmuneBuffEffect.lua

ImmuneBuffEffect = class("ImmuneBuffEffect", BuffEffect)

function ImmuneBuffEffect:initialize(config)
	super.initialize(self, config)

	self._filter = config.filter
end

function ImmuneBuffEffect:takeEffect(target, buffObject)
	local targetAgent = buffObject:getActiveTarget()

	if targetAgent ~= nil and self._filter ~= nil then
		targetAgent:addImmuneSelector(self._filter)
	end

	return true
end

function ImmuneBuffEffect:cancelEffect(target, buffObject)
	local targetAgent = buffObject:getActiveTarget()

	if targetAgent ~= nil and self._filter ~= nil then
		targetAgent:removeImmuneSelector(self._filter)
	end

	return true
end
