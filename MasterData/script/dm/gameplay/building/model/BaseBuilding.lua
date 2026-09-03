-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/model/BaseBuilding.lua

BaseBuilding = class("BaseBuilding", objectlua.Object, _M)

BaseBuilding:has("_buildingSystem", {
	is = "rw"
})
BaseBuilding:has("_id", {
	is = "rw"
})
BaseBuilding:has("_configId", {
	is = "rw"
})
BaseBuilding:has("_pos", {
	is = "rw"
})
BaseBuilding:has("_type", {
	is = "rw"
})
BaseBuilding:has("_level", {
	is = "rw"
})
BaseBuilding:has("_direction", {
	is = "rw"
})
BaseBuilding:has("_putHeroList", {
	is = "rw"
})
BaseBuilding:has("_quality", {
	is = "rw"
})
BaseBuilding:has("_usePosList", {
	is = "rw"
})
BaseBuilding:has("_finishTime", {
	is = "rw"
})
BaseBuilding:has("_skinId", {
	is = "rw"
})
BaseBuilding:has("_otherCost", {
	is = "rw"
})
BaseBuilding:has("_levelConfigId", {
	is = "rw"
})
BaseBuilding:has("_status", {
	is = "rw"
})
BaseBuilding:has("_activated", {
	is = "rw"
})
BaseBuilding:has("_revert", {
	is = "rw"
})
BaseBuilding:has("_finishAnimTime", {
	is = "rw"
})

function BaseBuilding:initialize()
	super.initialize(self)

	self._id = ""
	self._pos = cc.p(0, 0)
	self._type = ""
	self._level = 0
	self._direction = 0
	self._quality = 0
	self._usePosList = {}
	self._finishTime = 0
	self._skinId = ""
	self._otherCost = false
	self._levelConfigId = ""
	self._status = 0
	self._activated = false
	self._configId = ""
	self._putHeroList = {}
	self._putHeroPosList = {}
	self._revert = false
end

function BaseBuilding:synchronize(data)
	if data.level then
		self._level = data.level
	end

	if data.finishTime then
		self._finishTime = data.finishTime
	end

	if data.y then
		self._pos.y = data.y
	end

	if data.otherCost ~= nil then
		self._otherCost = data.otherCost
	end

	if data.levelConfigId then
		self._levelConfigId = data.levelConfigId
	end

	if data.status then
		self._status = data.status
	end

	if data.activated ~= nil then
		self._activated = data.activated
	end

	if data.type then
		self._type = data.type
	end

	if data.configId then
		self._configId = data.configId
	end

	if data.curSurfaceId then
		self._skinId = data.curSurfaceId
	end

	if data.x then
		self._pos.x = data.x
	end

	if data.revert ~= nil then
		self._revert = data.revert
	end
end

function BaseBuilding:changeDirection(direction)
	if self._direction ~= direction then
		self._direction = direction

		self:resetUsePosList()
	end
end

function BaseBuilding:resetUsePosList()
	self._usePosList = {}
end

function BaseBuilding:addSkinId(id)
	self._ownSkinIdList[id] = true
end

function BaseBuilding:ownSkinId(id)
	return self._ownSkinIdList[id]
end

function BaseBuilding:getUsePos()
	return self._buildingSystem:getBuildingPosList(self._configId, cc.p(self._pos.x, self._pos.y), self._revert)
end

function BaseBuilding:addPutHero(heroId, offset)
	self._putHeroList[#self._putHeroList + 1] = heroId
	self._putHeroPosList[heroId] = cc.p(offset.x, offset.y)
end

function BaseBuilding:removePutHero(heroId)
	for k, v in pairs(self._putHeroList) do
		if v == heroId then
			table.remove(self._putHeroList, k)

			break
		end
	end

	self._putHeroPosList[heroId] = nil
end

function BaseBuilding:canPutHeroSta()
	local buildInteractionType = ConfigReader:getDataByNameIdAndKey("VillageBuildingSurface", self._skinId, "BuildInteractionType")

	if buildInteractionType then
		local posList = ConfigReader:getDataByNameIdAndKey("VillageInteraction", buildInteractionType, "InteractionFactor")

		if posList and #self._putHeroList < #posList then
			return true
		end
	end

	return false
end

function BaseBuilding:getHeroId(worldPos)
	return self._putHeroList[#self._putHeroList]
end

function BaseBuilding:getHeroPutOffset()
	local buildInteractionType = ConfigReader:getDataByNameIdAndKey("VillageBuildingSurface", self._skinId, "BuildInteractionType")

	if buildInteractionType then
		local posList = ConfigReader:getDataByNameIdAndKey("VillageInteraction", buildInteractionType, "InteractionFactor")

		if posList then
			local useList = {}
			local info

			for k, v in pairs(self._putHeroPosList) do
				local key = v.x .. "_" .. v.y

				useList[key] = true
			end

			for k, v in pairs(posList) do
				local pos = v.deviation
				local key = pos[1] .. "_" .. pos[2]

				if not useList[key] then
					info = v

					break
				end
			end

			if info then
				local pos = info.deviation
				local rotate = info.direction

				return cc.p(pos[1], pos[2]), rotate
			end
		end
	end
end

function BaseBuilding:getResouseNum()
	return 0
end

function BaseBuilding:getResouseNumNoLimit()
	return 0
end

function BaseBuilding:getOutput()
	return 0
end

function BaseBuilding:getStorage()
	return 0
end

function BaseBuilding:getLimit()
	return 0
end
