-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/scene/unit/component/furniture/UnitCompFurnitureModel.lua

module("logic.extensions.house.scene.unit.component.furniture.UnitCompFurnitureModel", package.seeall)

local M = class("UnitCompFurnitureModel", UnitComponentBase)
local FurnitureOperaType = HouseEnum.FurnitureOperaType
local WallType = HouseEnum.WallType

function M:ctor(unit)
	M.super.ctor(self, unit)
end

function M:onInit()
	self:_resetData()
end

function M:_resetData()
	self._furnitureId = nil
	self._furnitureUUId = nil
	self._coordX = nil
	self._coordY = nil
	self._angle = nil
	self._coordXLen = nil
	self._coordYLen = nil
	self._coordZLen = nil
	self._resPath = nil
	self._originXLen = nil
	self._originYLen = nil
	self._operaType = nil
	self._wallType = nil
	self._rotaType = nil
	self._subType = nil
	self._bunkType = nil
	self._roomUnit = nil
	self._quality = nil
	self._foodMatchSign = nil
	self._isBathRoom = nil
end

function M:onReuse()
	return
end

function M:onReset()
	self:_resetData()
end

function M:onDestroy()
	self:onReset()
end

function M:setFurnitureId(id)
	self._furnitureId = id

	local CO = BackpackConfig.instance:getConfigByKey(ConfigName.Furniture, id)

	self._operaType = CO.operaType
	self._resPath = CO.resPath
	self._coordZLen = CO.coordZLen

	local coordLenList = string.split(CO.coordSize, "#")

	self._originXLen = tonumber(coordLenList[1])
	self._originYLen = tonumber(coordLenList[2])
	self._rotaType = CO.rotaType
	self._subType = CO.subType
	self._bunkType = CO.bunkType
	self._quality = CO.quality
	self._foodMatchSign = CO.foodMatchSign
	self._isBathRoom = CO.isBathRoom
end

function M:getFurnitureId()
	return self._furnitureId
end

function M:setUUId(uuid)
	if checknumber(uuid) > 0 then
		self._furnitureUUId = uuid
	end
end

function M:getUUId()
	return self._furnitureUUId
end

function M:getResUrl()
	return string.format("scene/common-elems/common-myhome/%s.prefab", self._resPath)
end

function M:getOperaType()
	return self._operaType
end

function M:getWallType()
	return self._wallType
end

function M:setCoordX(x)
	self._coordX = x

	self:_refreshWallType()
end

function M:setCoordY(y)
	self._coordY = y
end

function M:setAngle(angle)
	self._angle = MathUtil.normalizeAngle(angle)

	if self._angle == 0 or self._angle == 180 then
		self._coordXLen = self._originXLen
		self._coordYLen = self._originYLen
	else
		self._coordXLen = self._originYLen
		self._coordYLen = self._originXLen
	end
end

function M:setBelongRoom(roomUnit)
	self._roomUnit = roomUnit
end

function M:getBelongRoom()
	return self._roomUnit
end

function M:getCoordX()
	return self._coordX or 0
end

function M:getCoordY()
	return self._coordY or 0
end

function M:getAngle()
	return self._angle or 0
end

function M:getCoordXLen()
	return self._coordXLen
end

function M:getCoordYLen()
	return self._coordYLen
end

function M:getCoordZLen()
	return self._coordZLen
end

function M:getRotaType()
	return self._rotaType
end

function M:getSubType()
	return self._subType
end

function M:getBunkType()
	return self._bunkType
end

function M:getQuality()
	return self._quality
end

function M:getFoodMatchSign()
	return self._foodMatchSign
end

function M:isBathRoom()
	return self._isBathRoom == 1
end

function M:_refreshWallType()
	self._wallType = 0

	if self._operaType == FurnitureOperaType.Wall then
		self._wallType = HouseSceneUtil.CoordXMapToWallType(self._coordX)

		if self._wallType == 0 then
			printWarn("<color=#FF0000>墙家具x坐标配置错误</color>", self._furnitureId)
		end
	end
end

return M
