-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/datadef/shape/implement/BattleShapeModelRectangle.lua

module("logic.battle.datadef.shape.implement.BattleShapeModelRectangle", package.seeall)

local BattleShapeModelRectangle = class("BattleShapeModelRectangle", BattleShapeBase)

function BattleShapeModelRectangle:parseServerShapeNO(modelRectangleNO)
	self._modelId = modelRectangleNO.modelId
end

function BattleShapeModelRectangle:parseShapeConfig(shapeConfig)
	self._modelId = shapeConfig.modelId
end

function BattleShapeModelRectangle:getType()
	return BattleEnum.Shape.ModelRectangle
end

function BattleShapeModelRectangle:onInit()
	self._modelId = false
end

function BattleShapeModelRectangle:onReset()
	self._modelId = false
end

function BattleShapeModelRectangle:equals(other)
	return self:getType() == other:getType() and self._modelId == other._modelId
end

function BattleShapeModelRectangle:calculateCoveredUnionIndexList(shapeContext, outUnionIndexList)
	local centerUnionIndex = shapeContext:getShapeUnionIndex()
	local modelId = self._modelId
	local flagTable = BattleTableUtil.getTempList()
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local centerUnit = unitMgr:getUnitOnUnionIndex(centerUnionIndex)

	for _, unit in ipairs(unitMgr:getAllUnits()) do
		if unit:getUnitType() == BattleEnum.UnitType.Person and unit.property:getModelCode() == modelId then
			local minx, maxx, minz, maxz = BattleSkillAssist.calculateUnitRect(centerUnit, unit)

			for px = minx, maxx do
				for pz = minz, maxz do
					local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(px, pz)

					if not flagTable[unionIndex] then
						flagTable[unionIndex] = true

						table.insert(outUnionIndexList, unionIndex)
					end
				end
			end
		end
	end

	BattleTableUtil.releaseTempList(flagTable)
end

function BattleShapeModelRectangle:calculateBoundingRectangleList(shapeContext, outRectangleList)
	local centerUnionIndex = shapeContext:getShapeUnionIndex()
	local modelId = self._modelId
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local centerUnit = unitMgr:getUnitOnUnionIndex(centerUnionIndex)

	for _, unit in pairs(unitMgr:getAllUnits()) do
		if unit:getUnitType() == BattleEnum.UnitType.Person and unit.property:getModelCode() == modelId then
			local minx, maxx, minz, maxz = BattleSkillAssist.calculateUnitRect(centerUnit, unit)

			table.insert(outRectangleList, Rectangle:createInstance(minx, maxx, minz, maxz))
		end
	end
end

return BattleShapeModelRectangle
