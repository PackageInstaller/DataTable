-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/model/GaoSiNiaoMapGrid.lua

module("modules.logic.versionactivity3_1.gaosiniao.model.GaoSiNiaoMapGrid", package.seeall)

local GaoSiNiaoMapGrid = class("GaoSiNiaoMapGrid")
local kInvalidDistance = 99999

function GaoSiNiaoMapGrid:ctor(mapMO, index, gridInfo)
	self._mapMO = mapMO
	self.index = {
		x = index[1],
		y = index[2]
	}
	self.type = gridInfo.gtype or GaoSiNiaoEnum.GridType.Empty
	self.ePathType = gridInfo.ptype or GaoSiNiaoEnum.PathType.None
	self.zRot = gridInfo.zRot or 0
	self.bMovable = gridInfo.bMovable or false
	self._distanceToStart = kInvalidDistance
	self._forceInZoneMask = false
	self._forceOutZoneMask = false
end

function GaoSiNiaoMapGrid:distanceToStart()
	return (self:_isConnedStart() or nil) and (self._distanceToStart or kInvalidDistance)
end

function GaoSiNiaoMapGrid:setDistanceToStartByStartGrid(startGridItem)
	local newDist = 0

	newDist = newDist + math.abs(self:x() - startGridItem:x())
	newDist = newDist + math.abs(self:y() - startGridItem:y())
	self._distanceToStart = newDist
end

function GaoSiNiaoMapGrid:setId(id)
	self._id = id
end

function GaoSiNiaoMapGrid:id()
	return self._id
end

function GaoSiNiaoMapGrid:x()
	return self.index.x
end

function GaoSiNiaoMapGrid:y()
	return self.index.y
end

function GaoSiNiaoMapGrid:indexStr()
	return string.format("(%s,%s)", self.index.x, self.index.y)
end

function GaoSiNiaoMapGrid:isIndex(expectX, expectY)
	return self.index.x == expectX and expectY == self.index.y
end

function GaoSiNiaoMapGrid:isEmpty()
	return self.type == GaoSiNiaoEnum.GridType.Empty
end

function GaoSiNiaoMapGrid:isStart()
	return self.type == GaoSiNiaoEnum.GridType.Start
end

function GaoSiNiaoMapGrid:isEnd()
	return self.type == GaoSiNiaoEnum.GridType.End
end

function GaoSiNiaoMapGrid:isWall()
	return self.type == GaoSiNiaoEnum.GridType.Wall
end

function GaoSiNiaoMapGrid:isPortal()
	return self.type == GaoSiNiaoEnum.GridType.Portal
end

function GaoSiNiaoMapGrid:isPath()
	return self.type == GaoSiNiaoEnum.GridType.Path
end

function GaoSiNiaoMapGrid:isFixedPath()
	return self:isPath() and not self.bMovable
end

function GaoSiNiaoMapGrid:rootId()
	if not self._mapMO then
		return self:id()
	end

	return self._mapMO:rootId(self)
end

function GaoSiNiaoMapGrid:isRoot()
	return self:rootId() == self:id()
end

function GaoSiNiaoMapGrid:_getGrid(x, y)
	if not self._mapMO then
		return
	end

	return self._mapMO:getGrid(x, y)
end

function GaoSiNiaoMapGrid:_merge(rhs)
	if not self._mapMO then
		return
	end

	return self._mapMO:merge(self, rhs)
end

function GaoSiNiaoMapGrid:_isConned(rhs)
	if not self._mapMO then
		return
	end

	return self._mapMO:isConned(self, rhs)
end

function GaoSiNiaoMapGrid:_isConnedStart()
	if not self._mapMO then
		return
	end

	return self._mapMO:isConnedStart(self)
end

function GaoSiNiaoMapGrid:_isPlacedBagItem()
	if not self._mapMO then
		return
	end

	return self._mapMO:isPlacedBagItem(self)
end

function GaoSiNiaoMapGrid:_getPlacedBagItem()
	if not self._mapMO then
		return
	end

	return self._mapMO:getPlacedBagItem(self)
end

function GaoSiNiaoMapGrid:_whoActivedPortalGrid()
	if not self._mapMO then
		return
	end

	return self._mapMO:whoActivedPortalGrid()
end

function GaoSiNiaoMapGrid:T()
	self:_getGrid(self:x(), self:y() - 1)
end

function GaoSiNiaoMapGrid:R()
	self:_getGrid(self:x() + 1, self:y())
end

function GaoSiNiaoMapGrid:B()
	self:_getGrid(self:x(), self:y() + 1)
end

function GaoSiNiaoMapGrid:L()
	self:_getGrid(self:x() - 1, self:y())
end

function GaoSiNiaoMapGrid:isConnedT()
	local rhs = self:T()

	if not rhs then
		return false
	end

	return self:_isConned(rhs)
end

function GaoSiNiaoMapGrid:isConnedR()
	local rhs = self:R()

	if not rhs then
		return false
	end

	return self:_isConned(rhs)
end

function GaoSiNiaoMapGrid:isConnedB()
	local rhs = self:B()

	if not rhs then
		return false
	end

	return self:_isConned(rhs)
end

function GaoSiNiaoMapGrid:isConnedL()
	local rhs = self:L()

	if not rhs then
		return false
	end

	return self:_isConned(rhs)
end

function GaoSiNiaoMapGrid:getNeighborGridList()
	local list = {
		false,
		false,
		false,
		false
	}

	for i = 1, 4 do
		local x = self:x() + GaoSiNiaoEnum.dX[i]
		local y = self:y() + GaoSiNiaoEnum.dY[i]
		local grid = self:_getGrid(x, y)

		list[i] = grid or false
	end

	return list
end

function GaoSiNiaoMapGrid:getNeighborWalkableGridList()
	local list = {
		false,
		false,
		false,
		false
	}
	local outZM = self:out_ZoneMask()

	for i = 1, 4 do
		local relativeZoneMask = GaoSiNiaoEnum.bitPos2Dir(i - 1)

		if Bitwise.has(outZM, relativeZoneMask) then
			local x = self:x() + GaoSiNiaoEnum.dX[i]
			local y = self:y() + GaoSiNiaoEnum.dY[i]
			local grid = self:_getGrid(x, y)

			list[i] = grid or false
		end
	end

	return list
end

function GaoSiNiaoMapGrid:getRelativeZoneMask(neighborGrid)
	for i = 1, 4 do
		local relativeZoneMask = GaoSiNiaoEnum.bitPos2Dir(i - 1)
		local x = self:x() + GaoSiNiaoEnum.dX[i]
		local y = self:y() + GaoSiNiaoEnum.dY[i]

		if self:_getGrid(x, y) == neighborGrid then
			return relativeZoneMask
		end
	end

	return GaoSiNiaoEnum.ZoneMask.None
end

function GaoSiNiaoMapGrid:set_forceInZoneMask(zm)
	self._forceInZoneMask = zm
end

function GaoSiNiaoMapGrid:set_forceOutZoneMask(zm)
	self._forceOutZoneMask = zm
end

function GaoSiNiaoMapGrid:_internal_tryConnNeighbor(rhs, relativeZoneMask)
	if not rhs then
		return false
	end

	assert(relativeZoneMask > 0)

	local mask = Bitwise["&"](self:in_ZoneMask(), rhs:out_ZoneMask())

	return (Bitwise.has(mask, GaoSiNiaoEnum.flipDir(relativeZoneMask)))
end

function GaoSiNiaoMapGrid:_protal_ZoneMask_default()
	assert(self:isPortal())

	if self:isConnedT() then
		return GaoSiNiaoEnum.ZoneMask.South
	elseif self:isConnedR() then
		return GaoSiNiaoEnum.ZoneMask.West
	elseif self:isConnedB() then
		return GaoSiNiaoEnum.ZoneMask.North
	elseif self:isConnedL() then
		return GaoSiNiaoEnum.ZoneMask.East
	else
		return GaoSiNiaoEnum.ZoneMask.All
	end
end

function GaoSiNiaoMapGrid:in_ZoneMask()
	if self._forceInZoneMask then
		return self._forceInZoneMask
	end

	local bagItem = self:_getPlacedBagItem()

	if bagItem then
		return bagItem:in_ZoneMask()
	elseif self:isPortal() then
		return self:_protal_ZoneMask_default()
	end

	return self:_in_ZoneMask_default()
end

function GaoSiNiaoMapGrid:out_ZoneMask()
	if self._forceOutZoneMask then
		return self._forceOutZoneMask
	end

	local bagItem = self:_getPlacedBagItem()

	if bagItem then
		return bagItem:out_ZoneMask()
	elseif self:isPortal() then
		return self:_protal_ZoneMask_default()
	end

	return self:_out_ZoneMask_default()
end

function GaoSiNiaoMapGrid:_in_ZoneMask_default()
	if self:isStart() or self:isEnd() then
		return GaoSiNiaoEnum.ZoneMask.All
	elseif self:isWall() or self:isEmpty() then
		return GaoSiNiaoEnum.ZoneMask.None
	elseif self:isFixedPath() then
		return GaoSiNiaoEnum.PathInfo[self.ePathType].inZM
	else
		assert(false, "[in_ZoneMask] unsupported type: " .. tostring(self.type))
	end
end

function GaoSiNiaoMapGrid:_out_ZoneMask_default()
	if self:isStart() or self:isEnd() then
		return GaoSiNiaoEnum.ZoneMask.All
	elseif self:isWall() or self:isEmpty() then
		return GaoSiNiaoEnum.ZoneMask.None
	elseif self:isFixedPath() then
		return GaoSiNiaoEnum.PathInfo[self.ePathType].outZM
	else
		assert(false, "[out_ZoneMask] unsupported type: " .. tostring(self.type))
	end
end

return GaoSiNiaoMapGrid
