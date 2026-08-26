-- chunkname: @modules/logic/versionactivity3_7/wmz/model/WmzMapGridBase.lua

local math_abs = math.abs
local ti = table.insert
local sf = string.format
local string_rep = string.rep

module("modules.logic.versionactivity3_7.wmz.model.WmzMapGridBase", package.seeall)

local WmzMapGridBase = class("WmzMapGridBase")

function WmzMapGridBase.s_ctor(mapMO, cellInfo)
	local res

	if isDebugBuild then
		assert(cellInfo.x, "missing cellInfo.x")
		assert(cellInfo.y, "missing cellInfo.y")
	end

	local pt = cellInfo.pathType
	local ft = cellInfo.floorType

	return WmzMapInfo.s_isTile(pt, ft) and WmzMapTile.New(mapMO, cellInfo) or WmzMapInfo.s_isStart(pt) and WmzMapStart.New(mapMO, cellInfo) or WmzMapCell.New(mapMO, cellInfo)
end

function WmzMapGridBase:ctor(mapMO, cellInfo)
	self._mapMO = mapMO
	self._cellInfo = cellInfo
	self.index = Vector2.New(cellInfo.x, cellInfo.y)

	self:resetToInit()
end

function WmzMapGridBase:resetToInit()
	self._tileId = -1
	self._bWelded = false
	self._bSelected = false
end

function WmzMapGridBase:setWelded(bWelded)
	if isDebugBuild then
		assert(not self:isPathNone(), "invalid call" .. self:indexStr())
	end

	self._bWelded = bWelded
end

function WmzMapGridBase:bWelded()
	return self._bWelded
end

function WmzMapGridBase:setSelected(bSelected)
	self._bSelected = bSelected
end

function WmzMapGridBase:bSelected()
	return self._bSelected
end

function WmzMapGridBase:tileId()
	return self._tileId
end

function WmzMapGridBase:setTileId(tileId)
	self._tileId = tileId or -1
end

function WmzMapGridBase:floorType()
	return self._cellInfo.floorType or WmzEnum.FloorType.Void
end

function WmzMapGridBase:isVoid()
	return self:floorType() == WmzEnum.FloorType.Void
end

function WmzMapGridBase:isNothing()
	return self:isVoid() and self:isPathNone()
end

function WmzMapGridBase:isWall()
	return self:floorType() == WmzEnum.FloorType.Wall
end

function WmzMapGridBase:isPassable()
	return self:floorType() == WmzEnum.FloorType.Passable or self:isPassableEmpty()
end

function WmzMapGridBase:isPassableEmpty()
	return self:floorType() == WmzEnum.FloorType.PassableEmpty
end

function WmzMapGridBase:isEmpty()
	return self:isPassable() and self:isPathNone()
end

function WmzMapGridBase:isPathNone()
	local pt = self:pathType()

	return pt == WmzEnum.PathType.MoveableNone or pt == WmzEnum.PathType.None or self:isPassableEmpty()
end

function WmzMapGridBase:pathType()
	return self._cellInfo.pathType or WmzEnum.PathType.None
end

function WmzMapGridBase:groupId()
	return self._cellInfo.groupId or 0
end

function WmzMapGridBase:zoneId()
	return self._cellInfo.zoneId or 0
end

function WmzMapGridBase:bInZone()
	return self:zoneId() ~= 0
end

function WmzMapGridBase:bHasGroup()
	return self:groupId() ~= 0
end

function WmzMapGridBase:sprite()
	return self._cellInfo.sprite or ""
end

function WmzMapGridBase:finalSprite()
	return self._cellInfo._fSprite or self:sprite()
end

function WmzMapGridBase:isStart()
	local pt = self:pathType()

	return WmzMapInfo.s_isStart(pt)
end

function WmzMapGridBase:isTile()
	local pt = self:pathType()
	local ft = self:floorType()

	return WmzMapInfo.s_isTile(pt, ft)
end

function WmzMapGridBase:setId(id)
	self._id = id
end

function WmzMapGridBase:id()
	return self._id
end

function WmzMapGridBase:x()
	return self.index.x
end

function WmzMapGridBase:y()
	return self.index.y
end

function WmzMapGridBase:xy()
	return self.index:Get()
end

function WmzMapGridBase:indexStr()
	return string.format("(%s,%s)", self.index.x, self.index.y)
end

function WmzMapGridBase:isIndex(expectX, expectY)
	return self.index.x == expectX and expectY == self.index.y
end

function WmzMapGridBase:getCell(x, y)
	if not self._mapMO then
		return
	end

	return self._mapMO:getCell(x, y)
end

function WmzMapGridBase:getTile()
	if not self._mapMO then
		return nil
	end

	return self._mapMO:getTile(self:tileId())
end

function WmzMapGridBase:calcCellFlattenIndex()
	if not self._mapMO then
		return -1
	end

	return self._mapMO:calcCellFlattenIndex(self:x(), self:y())
end

function WmzMapGridBase:T()
	return self:getCell(self:x(), self:y() - 1)
end

function WmzMapGridBase:R()
	return self:getCell(self:x() + 1, self:y())
end

function WmzMapGridBase:B()
	return self:getCell(self:x(), self:y() + 1)
end

function WmzMapGridBase:L()
	return self:getCell(self:x() - 1, self:y())
end

function WmzMapGridBase:isConnedT()
	local rhs = self:T()

	if not rhs then
		return false
	end

	return self:_isConned(rhs)
end

function WmzMapGridBase:isConnedR()
	local rhs = self:R()

	if not rhs then
		return false
	end

	return self:_isConned(rhs)
end

function WmzMapGridBase:isConnedB()
	local rhs = self:B()

	if not rhs then
		return false
	end

	return self:_isConned(rhs)
end

function WmzMapGridBase:isConnedL()
	local rhs = self:L()

	if not rhs then
		return false
	end

	return self:_isConned(rhs)
end

function WmzMapGridBase:getNeighborCellList()
	local list = {
		false,
		false,
		false,
		false
	}

	for i = 1, 4 do
		local x = self:x() + WmzEnum.dX[i]
		local y = self:y() + WmzEnum.dY[i]
		local cellObj = self:getCell(x, y)

		list[i] = cellObj or false
	end

	return list
end

function WmzMapGridBase:getNeighborWalkableCellList()
	local list = {
		false,
		false,
		false,
		false
	}
	local outZM = self:out_ZoneMask()

	for i = 1, 4 do
		local relativeZoneMask = WmzEnum.bitPos2Dir(i - 1)

		if Bitwise.has(outZM, relativeZoneMask) then
			local x = self:x() + WmzEnum.dX[i]
			local y = self:y() + WmzEnum.dY[i]
			local cell = self:getCell(x, y)

			list[i] = cell or false
		end
	end

	return list
end

local kInvalidDist = 19999999

function WmzMapGridBase:calcDistTo(rhs)
	if not rhs then
		return kInvalidDist
	end

	local dist = 0

	dist = dist + math_abs(self:x() - rhs:x())
	dist = dist + math_abs(self:y() - rhs:y())

	return dist
end

function WmzMapGridBase:isNeighbor(rhs)
	return self:calcDistTo(rhs) == 1
end

function WmzMapGridBase:isConned(rhs)
	local relativeZoneMask = self:calcRelativeZoneMask(rhs)

	if relativeZoneMask == WmzEnum.ZoneMask.None then
		return false
	end

	return self:_isConnedNeighbor(rhs, relativeZoneMask)
end

function WmzMapGridBase:dxdy(rhs)
	if not rhs then
		return kInvalidDist, kInvalidDist
	end

	local dx = self:x() - rhs:x()
	local dy = self:y() - rhs:y()

	return dx, dy
end

function WmzMapGridBase:calcRelativeZoneMask(neighborCell)
	if not self:isNeighbor(neighborCell) then
		return WmzEnum.ZoneMask.None
	end

	local dx, dy = neighborCell:dxdy(self)

	return WmzEnum.dydxToMask[dy][dx]
end

function WmzMapGridBase:_isConnedNeighbor(rhs, relativeZoneMask)
	if not rhs then
		return false
	end

	if isDebugBuild then
		assert(self:isNeighbor(rhs))
		assert(relativeZoneMask > 0)
	end

	local mask = Bitwise["&"](self:in_ZoneMask(), rhs:out_ZoneMask())

	return (Bitwise.has(mask, WmzEnum.flipDir(relativeZoneMask)))
end

function WmzMapGridBase:_dump_ZoneMask(refStrBuf, depth)
	depth = depth or 0

	local tab = string_rep("\t", depth)

	ti(refStrBuf, tab .. sf("%s: in=%s, out=%s", self:indexStr(), WmzEnum.dirToStr(self:in_ZoneMask()), WmzEnum.dirToStr(self:out_ZoneMask())))
end

function WmzMapGridBase:_in_ZoneMask_default()
	local pt = self:pathType()

	return WmzEnum.PathInfo[pt].inZM
end

function WmzMapGridBase:_out_ZoneMask_default()
	local pt = self:pathType()

	return WmzEnum.PathInfo[pt].outZM
end

function WmzMapGridBase:in_ZoneMask()
	local tileObj = self:getTile()

	if tileObj then
		return tileObj:_in_ZoneMask_default()
	end

	return self:_in_ZoneMask_default()
end

function WmzMapGridBase:out_ZoneMask()
	local tileObj = self:getTile()

	if tileObj then
		return tileObj:_out_ZoneMask_default()
	end

	return self:_out_ZoneMask_default()
end

return WmzMapGridBase
