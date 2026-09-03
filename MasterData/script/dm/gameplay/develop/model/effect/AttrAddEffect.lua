-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/effect/AttrAddEffect.lua

AttrAddEffect = class("AttrAddEffect", Effect, _M)

function AttrAddEffect:initialize(config)
	assert(config ~= nil and config.attrType ~= nil)
	super.initialize(self, config)
end

function AttrAddEffect:takeEffect(target)
	self:_realCalculateEffect(target, 1)
end

function AttrAddEffect:cancelEffect(target)
	self:_realCalculateEffect(target, -1)
end

function AttrAddEffect:getLevel()
	return self:getConfig().level or 1
end

function AttrAddEffect:getAttrType()
	return self:getConfig().attrType
end

function AttrAddEffect:getEffectValue()
	assert(self:getConfig().attrNum)

	return self:getConfig().attrNum or 0
end

function AttrAddEffect:getElementType()
	assert(self:getConfig().elementType)

	return self:getConfig().elementType
end

function AttrAddEffect:_realCalculateEffect(target, multiFactor)
	self:chanegFactorValue(target, multiFactor)
end

function AttrAddEffect:chanegFactorValue(target, multiFactor)
	if self._config.attrType then
		local attrType = self:getAttrType()
		local elementType = self:getElementType()
		local vector = target:getVector(attrType)

		if not vector then
			return
		end

		local attrNum = target:getElement(attrType, elementType)

		attrNum = attrNum + multiFactor * self:getEffectValue()

		target:setElement(attrType, elementType, attrNum)
	end
end
