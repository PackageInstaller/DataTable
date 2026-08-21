-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/comp/BattleUnitCompTransform.lua

module("logic.battle.unit.comp.BattleUnitCompTransform", package.seeall)

local BattleUnitCompTransform = class("BattleUnitCompTransform", BattleUnitCompBase)

function BattleUnitCompTransform:onInit()
	self._scaleX = 1
	self._isComposite = false
	self._coordinates = false
	self._originalUnionIndex = false

	self:onReuse()
end

function BattleUnitCompTransform:onReuse()
	self._coordinates = Coordinates:createInstance(0, 0)
	self._originalUnionIndex = false

	self:resetCoordinates()
end

function BattleUnitCompTransform:onReset()
	if self._vertices then
		BattleTableUtil.clearReusableTable(self._vertices)

		self._vertices = false
	end

	if self._rectangle then
		self._rectangle:returnSelf()

		self._rectangle = false
	end

	if self._coordinates then
		self._coordinates:returnSelf()

		self._coordinates = false
	end

	self._originalUnionIndex = false
	self._scaleX = 1
	self._isComposite = false
end

function BattleUnitCompTransform:onDestroy()
	self:onReset()
end

function BattleUnitCompTransform:setVertexArray(vertexArray)
	if not vertexArray then
		return
	end

	if not self._vertices then
		self._isComposite = true
		self._vertices = {}
		self._rectangle = Rectangle:createInstance(0, 0, 0, 0)
	else
		BattleTableUtil.clearReusableTable(self._vertices)
	end

	for i = 1, #vertexArray, 2 do
		table.insert(self._vertices, Coordinates:createInstance(vertexArray[i], vertexArray[i + 1]))
	end

	self:recalculateBounds()
end

function BattleUnitCompTransform:recalculateBounds()
	if not self:isComposite() then
		return
	end

	local rectangle = self._rectangle

	for _, vertex in pairs(self._vertices) do
		local x = vertex:getX()
		local z = vertex:getZ()

		if x > rectangle:getMaxx() then
			rectangle:setMaxx(x)
		elseif x < rectangle:getMinx() then
			rectangle:setMinx(x)
		end

		if z > rectangle:getMaxz() then
			rectangle:setMaxz(z)
		elseif z < rectangle:getMinz() then
			rectangle:setMinz(z)
		end
	end
end

function BattleUnitCompTransform:getRectangle()
	return self._rectangle
end

function BattleUnitCompTransform:getVertices()
	return self._vertices
end

function BattleUnitCompTransform:setScaleX(scaleX)
	self._scaleX = scaleX
end

function BattleUnitCompTransform:setCoordinates(x, z)
	self._coordinates:setXZ(x, z)
end

function BattleUnitCompTransform:setOriginalUnionIndex(unionIndex)
	self._originalUnionIndex = unionIndex
end

function BattleUnitCompTransform:getOriginalUnionIndex()
	return self._originalUnionIndex
end

function BattleUnitCompTransform:getCurrentCoordinates()
	if self._originalUnionIndex then
		return BoardIndexConverter.unionIndexToCoordinates(self._originalUnionIndex)
	end

	return self:getCoordinates()
end

function BattleUnitCompTransform:getCoordinates()
	return self._coordinates:getXZ()
end

function BattleUnitCompTransform:resetCoordinates()
	self._coordinates:setXZ(-1, -1)
end

function BattleUnitCompTransform:containsCoordinates(x, z)
	local localX, localZ = self:inverseTransformCoordinates(x, z)

	return self:containsLocalCoordinates(localX, localZ)
end

function BattleUnitCompTransform:testContainsCoordinates(coordinatesX, coordinatesZ, x, z)
	local localX, localZ = self:testInverseTransformCoordinates(coordinatesX, coordinatesZ, x, z)

	return self:containsLocalCoordinates(localX, localZ)
end

function BattleUnitCompTransform:containsLocalCoordinates(localX, localZ)
	if self:isComposite() then
		local vertices = self:getVertices()

		for _, vertex in pairs(vertices) do
			if localX == vertex:getX() and localZ == vertex:getZ() then
				return true
			end
		end

		return false
	else
		return localX == 0 and localZ == 0
	end
end

function BattleUnitCompTransform:isComposite()
	return self._isComposite
end

function BattleUnitCompTransform:transformCoordinates(localX, localZ)
	local coordinates = self._coordinates

	return localX + coordinates:getX(), localZ + coordinates:getZ()
end

function BattleUnitCompTransform:testTransformCoordinates(coordinatesX, coordinatesZ, localX, localZ)
	return localX + coordinatesX, localZ + coordinatesZ
end

function BattleUnitCompTransform:inverseTransformCoordinates(x, z)
	local coordinates = self._coordinates

	return x - coordinates:getX(), z - coordinates:getZ()
end

function BattleUnitCompTransform:testInverseTransformCoordinates(coordinatesX, coordinatesZ, x, z)
	return x - coordinatesX, z - coordinatesZ
end

function BattleUnitCompTransform:inverseTransformToHitVertex(x, z)
	x, z = self:inverseTransformCoordinates(x, z)

	local scaleX = self._scaleX

	if self:isComposite() and scaleX < 0 then
		local rectangle = self._rectangle
		local offsetX = rectangle:getMinx() + rectangle:getMaxx()

		x = -x + offsetX
	end

	return x, z
end

return BattleUnitCompTransform
