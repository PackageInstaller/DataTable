-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/buffs/TriggerBuff.lua

TriggerBuff = class("TriggerBuff")

function TriggerBuff:initialize(buffConfig, buffEffects)
	super.initialize(self)
	assert(buffEffects ~= nil, "Invalid arguments")

	self._buffConfig = {
		duration = buffConfig.duration,
		timing = buffConfig.timing,
		display = buffConfig.display,
		tags = buffConfig.tags
	}
	self._buffEffects = buffEffects

	if buffConfig.group ~= nil then
		self._groupConfig = {
			group = buffConfig.group,
			limit = buffConfig.limit
		}
	end
end

function TriggerBuff:trigger(unit, buffSystem)
	local buffObject = BuffObject:new(self._buffConfig, self._buffEffects)

	return buffSystem:applyBuffOnTarget(unit, buffObject, self._groupConfig)
end

function TriggerBuff:getBuffConfig()
	return self._buffConfig
end
