-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/buffs/BuffEffect.lua

BuffEffect = class("BuffEffect", objectlua.Object, _M)

BuffEffect:has("_config", {
	is = "r"
})
BuffEffect:has("_buffValue", {
	is = "r"
})

function BuffEffect:initialize(config)
	super.initialize(self)

	self._config = config

	if config then
		self._callback = config.callback
		self._cancelCallback = config.onCancel
		self._buffValue = config.value or 0
	end
end

function BuffEffect:stack(buff, buffObject)
	local stackingCounts = buffObject:getEffectValue(self, "stackingCounts") or 1

	stackingCounts = stackingCounts + 1

	buffObject:setEffectValue(self, "stackingCounts", stackingCounts)

	local buffValue = buffObject:getEffectValue(self, "buffValue") or self._buffValue

	if buffValue then
		buffValue = buffValue + buff:getBuffValue()

		buffObject:setEffectValue(self, "buffValue", buffValue)
	end

	return true, {
		times = stackingCounts
	}
end

function BuffEffect:remove(buff, buffObject)
	local stackingCounts = buffObject:getEffectValue(self, "stackingCounts") or 1

	stackingCounts = stackingCounts - 1

	buffObject:setEffectValue(self, "stackingCounts", stackingCounts)

	local buffValue = buffObject:getEffectValue(self, "buffValue") or self._buffValue

	if buffValue then
		buffValue = buffValue - buff:getBuffValue()

		buffObject:setEffectValue(self, "buffValue", buffValue)
	end

	return true, {
		times = stackingCounts
	}
end

function BuffEffect:takeEffect(target, buffObject)
	buffObject:setEffectValue(self, "target", target)

	return true, nil
end

function BuffEffect:cancelEffect(target, buffObject, isBroke)
	buffObject:setEffectValue(self, "target", nil)
	buffObject:setEffectValue(self, "buffValue", nil)

	if self._cancelCallback then
		self._cancelCallback(battleContext, target)
	end

	return true, nil
end

function BuffEffect:tick(battleContext, buffObject)
	if self._callback then
		local target = buffObject:getEffectValue(self, "target")
		local stackingCounts = buffObject:getEffectValue(self, "stackingCounts") or 1
		local buffValue = buffObject:getEffectValue(self, "buffValue") or self._buffValue

		self._callback(battleContext, target, buffValue, stackingCounts)
	end
end

function BuffEffect:clone()
	return self.class:new(self._config)
end
