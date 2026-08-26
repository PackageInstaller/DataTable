-- chunkname: @modules/logic/versionactivity2_4/wuerlixi/model/WuErLiXiMapNodeMo.lua

module("modules.logic.versionactivity2_4.wuerlixi.model.WuErLiXiMapNodeMo", package.seeall)

local WuErLiXiMapNodeMo = pureTable("WuErLiXiMapNodeMo")

function WuErLiXiMapNodeMo:init(node)
	self.x = node[1]
	self.y = node[2]
	self.id = 100 * self.x + self.y
	self.nodeType = node[3]
	self.unit = nil
	self.ray = nil
	self.initUnit = 0
end

function WuErLiXiMapNodeMo:hasActUnit()
	return self.initUnit == 0 and self.unit
end

function WuErLiXiMapNodeMo:setUnit(unitCo)
	self.unit = self.unit or WuErLiXiMapUnitMo.New()

	self.unit:init(unitCo)

	self.initUnit = self.unit.id
end

function WuErLiXiMapNodeMo:setUnitByUnitMo(unitMo, x, y)
	self.unit = self.unit or WuErLiXiMapUnitMo.New()

	self.unit:initByUnitMo(unitMo, x, y)
end

function WuErLiXiMapNodeMo:getNodeUnit()
	return self.unit
end

function WuErLiXiMapNodeMo:setUnitActive(active, signalType, inDir)
	if not self.unit then
		return
	end

	self.unit:setUnitActive(active, signalType, inDir)
end

function WuErLiXiMapNodeMo:setDir(dir, rayDir)
	if not self.unit then
		return
	end

	self.unit:setDir(dir)

	if not rayDir then
		return
	end

	self:setUnitOutDirByRayDir(rayDir)
end

function WuErLiXiMapNodeMo:setUnitOutDirByRayDir(rayDir)
	if not self.unit or not rayDir then
		return
	end

	self.unit:setUnitOutDirByRayDir(rayDir)
end

function WuErLiXiMapNodeMo:isUnitActive(rayDir)
	if not self.unit then
		return false
	end

	return self.unit:isUnitActive(rayDir)
end

function WuErLiXiMapNodeMo:clearUnit()
	self.unit = nil
end

function WuErLiXiMapNodeMo:isNodeShowActive()
	if not self.unit then
		return false
	end

	if self.unit.unitType == WuErLiXiEnum.UnitType.SignalEnd then
		return self.ray
	elseif self.unit.unitType == WuErLiXiEnum.UnitType.Obstacle then
		return self.initUnit == 0
	end

	return self.unit:isUnitActive()
end

function WuErLiXiMapNodeMo:isRayEmitterNode()
	if not self.unit then
		return false
	end

	return self.unit:isRayEmitterUnit()
end

function WuErLiXiMapNodeMo:setUnitByActUnitMo(actUnitMo, x, y)
	self.unit = self.unit or WuErLiXiMapUnitMo.New()

	self.unit:initByActUnitMo(actUnitMo, x, y)
end

function WuErLiXiMapNodeMo:getUnitSignalOutDir()
	if not self.unit then
		return
	end

	return self.unit:getUnitSignalOutDir()
end

function WuErLiXiMapNodeMo:isUnitFreeType()
	if not self.unit then
		return false
	end

	return self.initUnit ~= 0
end

function WuErLiXiMapNodeMo:couldSetRay(rayType)
	if self.unit then
		if self.x ~= self.unit.x or self.y ~= self.unit.y then
			return false
		end

		if not self.unit:couldSetRay(rayType) then
			return false
		end
	end

	return true
end

function WuErLiXiMapNodeMo:setNodeRay(rayId, rayType, rayDir, rayParent)
	if self.unit and not self.unit:couldSetRay(rayType) then
		self.ray = nil

		return
	end

	if not self.ray then
		self.ray = WuErLiXiMapRayMo.New()

		self.ray:init(rayId, rayType, rayDir, rayParent)
	else
		self.ray:reset(rayId, rayType, rayDir, rayParent)
	end
end

function WuErLiXiMapNodeMo:getNodeRay()
	return self.ray
end

function WuErLiXiMapNodeMo:clearNodeRay(rayId)
	if not self.ray or self.ray.rayId ~= rayId then
		return
	end

	self.ray = nil
end

return WuErLiXiMapNodeMo
