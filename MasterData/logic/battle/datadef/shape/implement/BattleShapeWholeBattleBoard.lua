-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/datadef/shape/implement/BattleShapeWholeBattleBoard.lua

module("logic.battle.datadef.shape.implement.BattleShapeWholeBattleBoard", package.seeall)

local BattleShapeWholeBattleBoard = class("BattleShapeWholeBattleBoard", BattleShapeBase)

function BattleShapeWholeBattleBoard:parseServerShapeNO(shapeNO)
	return
end

function BattleShapeWholeBattleBoard:parseShapeConfig(shapeConfig)
	return
end

function BattleShapeWholeBattleBoard:getType()
	return BattleEnum.Shape.WholeBattleBoard
end

function BattleShapeWholeBattleBoard:equals(other)
	return self:getType() == other:getType()
end

function BattleShapeWholeBattleBoard:calculateCoveredUnionIndexList(shapeContext, outUnionIndexList)
	local boardModel = BattleMgr.instance:getBoardModel()
	local boardMO = boardModel:getActiveBoardMO()

	for _, cellMO in boardMO:ipairs() do
		local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(cellMO:getCoordinates())

		table.insert(outUnionIndexList, unionIndex)
	end
end

function BattleShapeWholeBattleBoard:calculateBoundingRectangleList(shapeContext, outRectangleList)
	local boardModel = BattleMgr.instance:getBoardModel()
	local boardMO = boardModel:getActiveBoardMO()
	local width = boardMO:getWidth()
	local height = boardMO:getHeight()

	table.insert(outRectangleList, Rectangle:createInstance(0, width, 0, height))
end

function BattleShapeWholeBattleBoard:calculateBoundingCircleRadius(shapeContext)
	local boardModel = BattleMgr.instance:getBoardModel()
	local boardMO = boardModel:getActiveBoardMO()
	local width = boardMO:getWidth()
	local height = boardMO:getHeight()
	local widthOrHeight = math.max(width, height)

	return math.ceil(widthOrHeight / 2)
end

function BattleShapeWholeBattleBoard:contains(shapeContext, inputUnionIndex)
	return true
end

return BattleShapeWholeBattleBoard
