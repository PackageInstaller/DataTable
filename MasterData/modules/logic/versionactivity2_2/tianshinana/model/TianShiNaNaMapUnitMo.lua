-- chunkname: @modules/logic/versionactivity2_2/tianshinana/model/TianShiNaNaMapUnitMo.lua

module("modules.logic.versionactivity2_2.tianshinana.model.TianShiNaNaMapUnitMo", package.seeall)

local TianShiNaNaMapUnitMo = class("TianShiNaNaMapUnitMo")

function TianShiNaNaMapUnitMo:init(co)
	self.co = co
	self.x = co.x
	self.y = co.y
	self.dir = co.dir
	self.isActive = false
end

function TianShiNaNaMapUnitMo:updatePos(x, y, dir)
	self.x = x
	self.y = y
	self.dir = dir
end

function TianShiNaNaMapUnitMo:setActive(isActive)
	self.isActive = isActive
end

function TianShiNaNaMapUnitMo:canWalk()
	return self.co.walkable
end

function TianShiNaNaMapUnitMo:isPosEqual(x, y)
	return x == self.x and y == self.y
end

return TianShiNaNaMapUnitMo
