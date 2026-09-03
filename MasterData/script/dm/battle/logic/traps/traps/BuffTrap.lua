-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/traps/traps/BuffTrap.lua

BuffTrap = class("BuffTrap", TrapEffect, _M)

function BuffTrap:initialize(buffConfig, buffEffects, source)
	super.initialize(self)

	self._buffConfig = buffConfig
	self._buffEffects = buffEffects
	self._source = source
end

function BuffTrap:trigger(target, battleContext, trapObject)
	local buffSystem = battleContext:getObject("BuffSystem")

	if target and buffSystem then
		local buffConfig = {
			duration = self._buffConfig.duration,
			timing = self._buffConfig.timing,
			display = self._buffConfig.display,
			tags = self._buffConfig.tags
		}
		local buffObject = BuffObject:new(buffConfig, self._buffEffects)

		buffObject:setSource(self._source)

		local groupConfig

		buffSystem:applyBuffOnTarget(target, buffObject, (buffConfig.group ~= nil or nil) and {
			group = self._buffConfig.group,
			limit = self._buffConfig.limit
		})
	end
end
