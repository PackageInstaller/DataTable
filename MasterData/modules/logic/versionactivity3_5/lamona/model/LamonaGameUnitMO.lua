-- chunkname: @modules/logic/versionactivity3_5/lamona/model/LamonaGameUnitMO.lua

module("modules.logic.versionactivity3_5.lamona.model.LamonaGameUnitMO", package.seeall)

local LamonaGameUnitMO = class("LamonaGameUnitMO")

function LamonaGameUnitMO:ctor(uid, id, info)
	self._uid = uid
	self._id = id
	self._type = LamonaConfig.instance:getLamonaUnitType(self._id)

	self:setUnitInfo(info)
end

function LamonaGameUnitMO:setUnitInfo(info)
	local x, y, dir, attrDict

	if info then
		x = info.x
		y = info.y
		dir = info.dir
		attrDict = info.attrDict
	end

	self:setGridXY(x, y)
	self:setDirection(dir)

	self._attrDict = {}

	if attrDict then
		for attrKey, attrValue in pairs(attrDict) do
			self:setAttrValue(attrKey, attrValue)
		end
	end
end

function LamonaGameUnitMO:setGridXY(x, y)
	self._gridX = x or 0
	self._gridY = y or 0
end

function LamonaGameUnitMO:setDirection(direction)
	self._direction = direction or LamonaEnum.Const.DefaultDirection
end

function LamonaGameUnitMO:setAttrValue(attrKey, attrValue)
	self._attrDict[attrKey] = math.max(0, attrValue)
end

function LamonaGameUnitMO:getUid()
	return self._uid
end

function LamonaGameUnitMO:getId()
	return self._id
end

function LamonaGameUnitMO:getType()
	return self._type
end

function LamonaGameUnitMO:getGridXY()
	return self._gridX or 0, self._gridY or 0
end

function LamonaGameUnitMO:getDirection()
	return self._direction or LamonaEnum.Const.DefaultDirection
end

function LamonaGameUnitMO:getHasAttr(attrKey)
	return self._attrDict[attrKey] ~= nil
end

function LamonaGameUnitMO:getAttrValue(attrKey)
	return self._attrDict[attrKey] or 0
end

function LamonaGameUnitMO:getMoveTime()
	if not self._moveTime then
		self._moveTime = 0

		local type = self:getType()

		if type == LamonaEnum.UnitType.Player then
			self._moveTime = LamonaConfig.instance:getLamonaConst(LamonaEnum.ConstId.PlayerMoveTime, false, true)
		elseif type == LamonaEnum.UnitType.Ghost then
			self._moveTime = LamonaConfig.instance:getLamonaConst(LamonaEnum.ConstId.GhostMoveTime, false, true)
		end
	end

	return self._moveTime
end

function LamonaGameUnitMO:getUnitInfo()
	local uid = self:getUid()
	local id = self:getId()
	local x, y = self:getGridXY()
	local dir = self:getDirection()
	local attrDict = {}

	for attrKey, attrValue in pairs(self._attrDict) do
		attrDict[attrKey] = attrValue
	end

	return {
		uid = uid,
		id = id,
		x = x,
		y = y,
		dir = dir,
		attrDict = attrDict
	}
end

return LamonaGameUnitMO
