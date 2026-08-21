-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/datadef/shape/BattleShapeBase.lua

module("logic.battle.datadef.shape.BattleShapeBase", package.seeall)

local BattleShapeBase = class("BattleShapeBase", AbstractGlobalReusable)

function BattleCommandBase:parseServerShapeNO(shapeNO)
	if BattleLog.enableError then
		BattleLog.error("unimplemented method!")
	end
end

function BattleShapeBase:parseShapeConfig(shapeConfig)
	if BattleLog.enableError then
		BattleLog.error("unimplemented method!")
	end
end

function BattleShapeBase:calculateCoveredUnionIndexList(shapeContext, outUnionIndexList)
	if BattleLog.enableError then
		BattleLog.error("unimplemented method!")
	end
end

function BattleShapeBase:calculateBoundingRectangleList(shapeContext, outRectangleList)
	if BattleLog.enableError then
		BattleLog.error("unimplemented method!")
	end
end

function BattleShapeBase:calculateBoundingCircleRadius(shapeContext)
	local outRectangleList = BattleTableUtil.getTempList()

	self:calculateBoundingRectangleList(shapeContext, outRectangleList)

	local resultRectangle = Rectangle:createInfiniteMin()

	for _, rectangle in ipairs(outRectangleList) do
		resultRectangle:union(rectangle)
	end

	local maxValue = math.max(resultRectangle:getMaxx() - resultRectangle:getMinx(), resultRectangle:getMaxz() - resultRectangle:getMinz())
	local radius = math.ceil((maxValue + 1) / 2)

	resultRectangle:returnSelf()
	BattleTableUtil.releaseTempList(outRectangleList)

	return radius
end

function BattleShapeBase:contains(shapeContext, inputUnionIndex)
	local outUnionIndexList = BattleTableUtil.getTempList()

	self:calculateCoveredUnionIndexList(shapeContext, outUnionIndexList)

	for _, unionIndex in ipairs(outUnionIndexList) do
		if inputUnionIndex == unionIndex then
			BattleTableUtil.releaseTempList(outUnionIndexList)

			return true
		end
	end

	BattleTableUtil.releaseTempList(outUnionIndexList)

	return false
end

function BattleShapeBase:onInit()
	return
end

function BattleShapeBase:onReset()
	return
end

function BattleShapeBase:getType()
	if BattleLog.enableError then
		BattleLog.error("unimplemented method!")
	end
end

function BattleShapeBase:equals(other)
	if BattleLog.enableError then
		BattleLog.error("unimplemented method!")
	end
end

function BattleShapeBase:ctor()
	self:onInit()
end

function BattleShapeBase:reuse()
	self:onInit()
end

function BattleShapeBase:reset()
	self:onReset()
end

function BattleShapeBase:destroy()
	self:onReset()
end

return BattleShapeBase
