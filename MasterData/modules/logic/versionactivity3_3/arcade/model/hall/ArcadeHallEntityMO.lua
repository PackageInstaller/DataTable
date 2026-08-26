-- chunkname: @modules/logic/versionactivity3_3/arcade/model/hall/ArcadeHallEntityMO.lua

module("modules.logic.versionactivity3_3.arcade.model.hall.ArcadeHallEntityMO", package.seeall)

local ArcadeHallEntityMO = class("ArcadeHallEntityMO")

function ArcadeHallEntityMO:ctor(id)
	self.id = id

	self:initConfig()
	self:initGrid()
end

function ArcadeHallEntityMO:initConfig()
	return
end

function ArcadeHallEntityMO:initGrid()
	self._gridX, self._gridY = 0, 0
	self._posX, self._posY = 0, 0
end

function ArcadeHallEntityMO:setGridPos(x, y)
	self._posX, self._posY = x, y
end

function ArcadeHallEntityMO:setPosZ(z)
	self._posZ = z
end

function ArcadeHallEntityMO:getId()
	return self.id
end

function ArcadeHallEntityMO:getGridSize()
	return self._gridX, self._gridY
end

function ArcadeHallEntityMO:getCfg()
	return self.co
end

function ArcadeHallEntityMO:getGridPos()
	return self._posX, self._posY
end

function ArcadeHallEntityMO:getResPath()
	return
end

function ArcadeHallEntityMO:_getPos(x, y)
	if x == nil or y == nil then
		x, y = ArcadeHallModel.instance:getHeroGrid()
	end

	local _x = ArcadeHallEnum.Const.StartX + (x - 1) * ArcadeHallEnum.Const.GridSize
	local _y = ArcadeHallEnum.Const.StartY + (y - 1) * ArcadeHallEnum.Const.GridSize

	return _x, _y
end

function ArcadeHallEntityMO:getEntityPos()
	return self:_getPos(self._posX, self._posY)
end

function ArcadeHallEntityMO:getCenterPos()
	local x1, y1 = self:getEntityPos()
	local x2, y2 = self:_getPos(self._posX + self._gridX - 1, self._posY + self._gridY - 1)

	return (x1 + x2) * 0.5, y1
end

function ArcadeHallEntityMO:getPosZ()
	return self._posZ or 0
end

return ArcadeHallEntityMO
