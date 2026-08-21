-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/datadef/shape/implement/BattleShapeLinkLine.lua

module("logic.battle.datadef.shape.implement.BattleShapeLinkLine", package.seeall)

local BattleShapeLinkLine = class("BattleShapeLinkLine", BattleShapeBase)

function BattleShapeLinkLine:parseServerShapeNO(shapeNO)
	return
end

function BattleShapeLinkLine:parseShapeConfig(shapeConfig)
	return
end

function BattleShapeLinkLine:getType()
	return BattleEnum.Shape.LinkLine
end

function BattleShapeLinkLine:onInit()
	return
end

function BattleShapeLinkLine:onReset()
	return
end

function BattleShapeLinkLine:equals(other)
	return self:getType() == other:getType()
end

function BattleShapeLinkLine:_getFloatXZFromUnionIndex(unionIndex)
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnitOnUnionIndex(unionIndex)

	if not unit or not unit.transform:isComposite() then
		local x, z = BoardIndexConverter.unionIndexToCoordinates(unionIndex)

		return x + 0.5, z + 0.5
	end

	local x, z = unit.transform:getCoordinates()
	local rectangle = unit.transform:getRectangle()
	local minx, maxx, minz, maxz = rectangle:getRanges()
	local dx = (maxx - minx + 1) * 0.5
	local dz = (maxz - minz + 1) * 0.5

	return x + dx, z + dz
end

function BattleShapeLinkLine:_swap(a, b)
	return b, a
end

function BattleShapeLinkLine:_checkSpecialCase(outUnionIndexList, fx0, fz0, fx1, fz1)
	if fx0 == fx1 and fz0 == fz1 then
		local ix0 = math.floor(fx0)
		local iz0 = math.floor(fz0)
		local isx = ix0 == fx0 and math.max(0, ix0 - 1) or ix0
		local isz = iz0 == fz0 and math.max(0, iz0 - 1) or iz0

		for x = isx, ix0 do
			for z = isz, iz0 do
				table.insert(outUnionIndexList, BoardIndexConverter.coordinatesToUnionIndex(x, z))
			end
		end

		return true
	elseif fx0 == fx1 then
		if fz1 < fz0 then
			fz0, fz1 = self:_swap(fz0, fz1)
		end

		local ix0 = math.floor(fx0)
		local iz0 = math.floor(fz0)
		local iz1 = math.floor(fz1)
		local isx = ix0 == fx0 and math.max(0, ix0 - 1) or ix0

		if iz1 == fz1 then
			iz1 = iz1 - 1
		end

		for x = isx, ix0 do
			for z = iz0, iz1 do
				table.insert(outUnionIndexList, BoardIndexConverter.coordinatesToUnionIndex(x, z))
			end
		end

		return true
	elseif fz0 == fz1 then
		if fx1 < fx0 then
			fx0, fx1 = self:_swap(fx0, fx1)
		end

		local ix0 = math.floor(fx0)
		local ix1 = math.floor(fx1)
		local iz0 = math.floor(fz0)
		local isz = iz0 == fz0 and math.max(0, iz0 - 1) or iz0

		if ix1 == fx1 then
			ix1 = ix1 - 1
		end

		for z = isz, iz0 do
			for x = ix0, ix1 do
				table.insert(outUnionIndexList, BoardIndexConverter.coordinatesToUnionIndex(x, z))
			end
		end

		return true
	end

	return false
end

function BattleShapeLinkLine:calculateCoveredUnionIndexList(shapeContext, outUnionIndexList)
	local shapeUnionIndex = shapeContext:getShapeUnionIndex()
	local ownerUnionIndex = shapeContext:getOwnerUnionIndex()
	local fx0, fz0 = self:_getFloatXZFromUnionIndex(ownerUnionIndex)
	local fx1, fz1 = self:_getFloatXZFromUnionIndex(shapeUnionIndex)

	if self:_checkSpecialCase(outUnionIndexList, fx0, fz0, fx1, fz1) then
		return
	end

	local kx = 1 / (fx1 - fx0)
	local kz = 1 / (fz1 - fz0)
	local dx = fx0 < fx1 and 1 or -1
	local dz = fz0 < fz1 and 1 or -1
	local ix = math.floor(fx0)
	local iz = math.floor(fz0)

	if ix == fx0 and dx < 0 then
		ix = ix - 1
	end

	if iz == fz0 and dz < 0 then
		iz = iz - 1
	end

	local ixNext = dx > 0 and ix + dx or ix
	local izNext = dz > 0 and iz + dz or iz
	local tx = (ixNext - fx0) * kx
	local tz = (izNext - fz0) * kz

	table.insert(outUnionIndexList, BoardIndexConverter.coordinatesToUnionIndex(ix, iz))

	repeat
		if tx < tz then
			ix = ix + dx
			ixNext = ixNext + dx
			tx = (ixNext - fx0) * kx
		elseif tx == tz then
			ix = ix + dx
			iz = iz + dz
			ixNext = ixNext + dx
			izNext = izNext + dz
			tx = (ixNext - fx0) * kx
			tz = (izNext - fz0) * kz
		else
			iz = iz + dz
			izNext = izNext + dz
			tz = (izNext - fz0) * kz
		end

		table.insert(outUnionIndexList, BoardIndexConverter.coordinatesToUnionIndex(ix, iz))
	until tx >= 1 and tz >= 1
end

function BattleShapeLinkLine:calculateBoundingRectangleList(shapeContext, outRectangleList)
	local uncheckUnionIndexList = BattleTableUtil.getTempList()
	local outUnionIndexList = BattleTableUtil.getTempList()

	self:calculateCoveredUnionIndexList(shapeContext, uncheckUnionIndexList)
	BattleShapeUtil.validUnionIndexList(uncheckUnionIndexList, outUnionIndexList)

	for _, unionIndex in ipairs(outUnionIndexList) do
		local x, z = BoardIndexConverter.unionIndexToCoordinates(unionIndex)

		table.insert(outRectangleList, Rectangle:createInstance(x, x, z, z))
	end

	BattleTableUtil.releaseTempList(uncheckUnionIndexList)
	BattleTableUtil.releaseTempList(outUnionIndexList)
end

function BattleShapeLinkLine:calculateBoundingCircleRadius(shapeContext)
	local shapeUnionIndex = shapeContext:getShapeUnionIndex()
	local ownerUnionIndex = shapeContext:getOwnerUnionIndex()
	local x0, z0 = BoardIndexConverter.unionIndexToCoordinates(shapeUnionIndex)
	local x1, z1 = BoardIndexConverter.unionIndexToCoordinates(ownerUnionIndex)

	return math.max(x1 - x0, z1 - z0)
end

return BattleShapeLinkLine
