-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/buffs/effects/NumericEffect.lua

NumericEffect = class("NumericEffect", BuffEffect, _M)

function NumericEffect:initialize(config)
	super.initialize(self, config)

	local effect = config.effect

	self._attrname = string.sub(effect, 2)
	self._operationSymbol = string.sub(effect, 1, 1)
	self._operation = (self._operationSymbol == "+" or self._operationSymbol == "*") and 1 or -1
	self._itemname = config.itemname or {}
	self._uplimit = config.uplimit
	self._descname = self._operation > 0 and "+attr:" .. self._attrname or "-attr:" .. self._attrname
end

function NumericEffect:getTargetAttribute(target, attrname)
	local comp = target and target:getComponent("Numeric")

	if comp == nil then
		return nil
	end

	return comp:getAttribute(attrname)
end

function NumericEffect:takeEffect(target, buffObject)
	local attr = self:getTargetAttribute(target, self._attrname)

	if attr == nil then
		return false
	end

	local item
	local itemname = self._itemname
	local operation = self._operation

	item = operation > 0 and attr:getPositiveItem(true, itemname[1], itemname[2]) or attr:getNegativeItem(true, itemname[1], itemname[2])

	if item == nil then
		return false
	end

	local value = buffObject:getEffectValue(self, "value") or self._buffValue

	value = self:_transferOperationValue(buffObject, value, attr:caculate())

	item:addNumber(value)

	if self._uplimit ~= nil then
		item:addUpperLimit(self._uplimit)
	end

	super.takeEffect(self, target, buffObject)
	buffObject:setEffectValue(self, "targetitem", item)

	return true
end

function NumericEffect:stack(buff, buffObject)
	super.stack(self, buff, buffObject)

	local item = buffObject:getEffectValue(self, "targetitem")

	if item ~= nil then
		local buffValue = buffObject:getEffectValue(self, "buffValue")
		local value = buffObject:getEffectValue(self, "value") or self._buffValue

		item:removeNumber(value)
		item:addNumber(buffValue)
		buffObject:setEffectValue(self, "value", buffValue)

		return true
	else
		local target = buffObject:getEffectValue(self, "target")
		local succ, detail = self:takeEffect(target, buffObject)

		return succ, detail
	end
end

function NumericEffect:remove(buff, buffObject)
	super.remove(self, buff, buffObject)

	local item = buffObject:getEffectValue(self, "targetitem")

	if item ~= nil then
		local buffValue = buffObject:getEffectValue(self, "buffValue")
		local value = buffObject:getEffectValue(self, "value") or self._buffValue

		item:removeNumber(value)
		item:addNumber(buffValue)
		buffObject:setEffectValue(self, "value", buffValue)

		return true
	end
end

function NumericEffect:cancelEffect(target, buffObject)
	local _target = buffObject:getEffectValue(self, "target")

	if _target == nil or _target ~= target then
		return false
	end

	local item = buffObject:getEffectValue(self, "targetitem")

	if item ~= nil then
		local value = buffObject:getEffectValue(self, "value") or self._buffValue

		item:removeNumber(value)

		if self._uplimit ~= nil then
			item:removeUpperLimit(self._uplimit)
		end
	end

	super.cancelEffect(self, target, buffObject)
	buffObject:setEffectValue(self, "value", nil)
	buffObject:setEffectValue(self, "targetitem", nil)

	return true
end

function NumericEffect:_transferOperationValue(buffObject, value, attrValue)
	if (self._operationSymbol == "*" or self._operationSymbol == "/") and not buffObject:getEffectValue(self, "value") then
		self._buffValue = value * attrValue

		return self._buffValue
	end

	return value
end
