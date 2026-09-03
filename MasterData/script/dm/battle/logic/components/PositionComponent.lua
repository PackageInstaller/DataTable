-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/components/PositionComponent.lua

PositionComponent = class("PositionComponent", BaseComponent, _M)

function PositionComponent:initialize()
	super.initialize(self)
end

function PositionComponent:setPosition(zone, x, y)
	self._zone, self._posx, self._posy = zone, x, y
end

function PositionComponent:getPosition()
	return self._zone, self._posx, self._posy
end

function PositionComponent:setPosX(x)
	self._posx = x
end

function PositionComponent:getPosX()
	return self._posx
end

function PositionComponent:setPosY(y)
	self._posy = y
end

function PositionComponent:getPosY()
	return self._posy
end

function PositionComponent:setZone(zone)
	self._zone = zone
end

function PositionComponent:getZone()
	return self._zone
end

function PositionComponent:setCell(cell)
	self._cell = cell
	self._cellSide = cell and cell:getSide()
end

function PositionComponent:getCell()
	return self._cell
end

function PositionComponent:getCellSide()
	return self._cellSide
end

function PositionComponent:copyComponent(src, ratio)
	return
end
