-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/datadef/shape/BattleShapeContext.lua

module("logic.battle.datadef.shape.BattleShapeContext", package.seeall)

local BattleShapeContext = class("BattleShapeContext", AbstractGlobalReusable)

function BattleShapeContext:create(shapeUnionIndex, ownerUnionIndex)
	local x0, z0 = BoardIndexConverter.unionIndexToCoordinates(ownerUnionIndex)
	local x1, z1 = BoardIndexConverter.unionIndexToCoordinates(shapeUnionIndex)
	local shapeContext = BattleShapeContext:createInstance()

	shapeContext:setShapeUnionIndex(shapeUnionIndex)
	shapeContext:_setOwnerUnionIndex(ownerUnionIndex)
	shapeContext:_setDirection(x1 - x0, z1 - z0)

	return shapeContext
end

function BattleShapeContext:ctor()
	self._shapeUnionIndex = false
	self._ownerUnionIndex = false
	self._direction = Vector3.New()
end

function BattleShapeContext:reset()
	self._shapeUnionIndex = false
	self._ownerUnionIndex = false

	self._direction:Set(0, 0, 0)
end

function BattleShapeContext:copyFrom(fromContext)
	self._shapeUnionIndex = fromContext._shapeUnionIndex
	self._ownerUnionIndex = fromContext._ownerUnionIndex

	self._direction:Set(fromContext._direction:Get())
end

function BattleShapeContext:getShapeUnionIndex()
	return self._shapeUnionIndex
end

function BattleShapeContext:getOwnerUnionIndex()
	return self._ownerUnionIndex
end

function BattleShapeContext:getDirection()
	return self._direction
end

function BattleShapeContext:destroy()
	self:reset()
end

function BattleShapeContext:setShapeUnionIndex(shapeUnionIndex)
	self._shapeUnionIndex = shapeUnionIndex
end

function BattleShapeContext:_setOwnerUnionIndex(ownerUnionIndex)
	self._ownerUnionIndex = ownerUnionIndex
end

function BattleShapeContext:_setDirection(x, z)
	self._direction:Set(x, 0, z)
end

return BattleShapeContext
