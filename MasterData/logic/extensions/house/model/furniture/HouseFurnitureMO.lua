-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/model/furniture/HouseFurnitureMO.lua

module("logic.extensions.house.model.furniture.HouseFurnitureMO", package.seeall)

local M = class("HouseFurnitureMO")
local BunkInfo = class("BunkInfo")

function BunkInfo:ctor(furnitureUUId, index, heroId, code)
	self.furnitureUUId = furnitureUUId
	self.index = index
	self.heroId = heroId
	self.furnitureCode = code
end

function BunkInfo:getFurnitureCfg()
	local furnCfg = BackpackConfig.instance:getConfigByKey(ConfigName.Furniture, self.furnitureCode)

	return furnCfg
end

function M:ctor()
	self._uuid = nil
	self._id = nil
	self._coordX = nil
	self._coordY = nil
	self._angle = nil
	self._roomId = nil
	self._fmodId = nil
	self._dictBunkInfo = {}
	self._isUsed = false
end

function M:setDataByAgent(NO)
	self._uuid = tonumber(NO.uuid)
	self._id = NO.id
	self._coordX = NO.pos.x
	self._coordY = NO.pos.y
	self._angle = NO.angle
	self._roomId = NO.zoneId
	self._fmodId = math.fmod(self._id, 10000)
	self._cfg = BackpackConfig.instance:getConfigByKey(ConfigName.Furniture, self._id)

	table.clear(self._dictBunkInfo)

	for _, bunkNO in ipairs(NO.bunks or {}) do
		local uuid = checknumber(bunkNO.furniture)

		if uuid > 0 then
			local bunkInfo = BunkInfo.New(uuid, bunkNO.index, checknumber(bunkNO.hero), self._id)

			self._dictBunkInfo[bunkInfo.index] = bunkInfo
		end
	end
end

function M:getUUId()
	return self._uuid
end

function M:setUUId(uuid)
	if checknumber(uuid) > 0 then
		self._uuid = uuid
	end
end

function M:getId()
	return self._id
end

function M:getCoordX()
	return self._coordX
end

function M:getCoordY()
	return self._coordY
end

function M:getAngle()
	return self._angle
end

function M:getRoomId()
	return self._roomId
end

function M:getBunkByIdx(idx)
	return self._dictBunkInfo[idx]
end

function M:hasBunk()
	return self._dictBunkInfo[1] ~= nil
end

function M:getBunks()
	return {
		self._dictBunkInfo[1],
		self._dictBunkInfo[2]
	}
end

function M:getFmodId()
	return self._fmodId
end

function M:setUsed(used)
	self._isUsed = used
end

function M:getUsed()
	return self._isUsed
end

function M:getPosInHouseScene()
	local posX, posY, posZ
	local curScene = SceneMgr.instance:getCurScene()

	if curScene and curScene.roomMgr then
		local CO = BackpackConfig.instance:getItemInfoByItemId(self:getId())
		local roomUnit = curScene.roomMgr:getUnitById(self:getRoomId())

		posX, posY, posZ = roomUnit.furnitureMap:getWorldPosByCoord(CO.operaType, self:getCoordX(), self:getCoordY(), 1, 1)
	end

	return posX, posY, posZ
end

function M:isBathRoom()
	return self._cfg.isBathRoom == 1
end

function M:getFitZoneTypes()
	return self._cfg.zoneTypes
end

return M
