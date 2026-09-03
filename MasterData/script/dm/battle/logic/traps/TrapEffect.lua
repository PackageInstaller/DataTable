-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/traps/TrapEffect.lua

TrapEffect = class("TrapEffect", objectlua.Object, _M)

TrapEffect:has("_config", {
	is = "r"
})
TrapEffect:has("_buffValue", {
	is = "r"
})

function TrapEffect:initialize(config)
	super.initialize(self)

	self._config = config

	if config then
		self._startCallback = config.onStart
		self._tickCallback = config.onTick
		self._cancelCallback = config.onCancel
		self._triggerCallback = config.onTrigger
		self._buffValue = config.value or 0
	end
end

function TrapEffect:putTrap(cell, trapObject)
	trapObject:setEffectValue(self, "targetCell", cell)

	if self._startCallback then
		local buffValue = trapObject:getEffectValue(self, "buffValue") or self._buffValue

		self._startCallback(battleContext, cell, buffValue)
	end

	return true, nil
end

function TrapEffect:cancelTrap(cell, trapObject)
	if self._cancelCallback then
		local buffValue = trapObject:getEffectValue(self, "buffValue") or self._buffValue

		self._cancelCallback(battleContext, cell, buffValue)
	end

	trapObject:setEffectValue(self, "targetCell", nil)
	trapObject:setEffectValue(self, "buffValue", nil)

	return true, nil
end

function TrapEffect:tick(battleContext, trapObject)
	if self._tickCallback then
		local cell = trapObject:getEffectValue(self, "targetCell")
		local target = trapObject:getEffectValue(self, "target")
		local buffValue = trapObject:getEffectValue(self, "buffValue") or self._buffValue

		self._tickCallback(battleContext, cell, target, buffValue)
	end
end

function TrapEffect:trigger(target, battleContext, trapObject)
	trapObject:setEffectValue(self, "target", target)

	if self._triggerCallback then
		local cell = trapObject:getEffectValue(self, "targetCell")
		local target = trapObject:getEffectValue(self, "target")
		local buffValue = trapObject:getEffectValue(self, "buffValue") or self._buffValue

		self._triggerCallback(battleContext, cell, target, buffValue)
	end
end
