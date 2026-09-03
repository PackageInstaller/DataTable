-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/effect/AttrFactor.lua

AttrFactor = class("AttrFactor", objectlua.Object, _M)

AttrFactor:has("_vectors", {
	is = "r"
})

function AttrFactor:initialize()
	self:reCreateAttr()
end

function AttrFactor:reCreateAttr()
	self._vectors = {}

	for attrType, _ in pairs(AttrBaseType) do
		self._vectors[attrType] = AttributeCategory:getBaseAttrElement()
	end

	for attrType, _ in pairs(AttrRateFactors) do
		self._vectors[attrType] = AttributeCategory:getRateAttrElement()
	end
end

function AttrFactor:getVector(attrType)
	return self._vectors[attrType]
end

function AttrFactor:getElement(attrType, elementType)
	local vector = self:getVector(attrType)

	return vector[elementType]
end

function AttrFactor:setElement(attrType, elementType, attrNum)
	local vector = self:getVector(attrType)

	if vector[elementType] then
		vector[elementType] = attrNum
	end
end

function AttrFactor:copyAttrFactor(targetFactor)
	for attrType, vector in pairs(targetFactor:getVectors()) do
		local myVector = self:getVector(attrType)

		for elementType, elementNum in pairs(vector) do
			myVector[elementType] = myVector[elementType] + elementNum
		end
	end
end
