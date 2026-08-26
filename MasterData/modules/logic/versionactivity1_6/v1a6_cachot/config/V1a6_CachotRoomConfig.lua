-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/config/V1a6_CachotRoomConfig.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.config.V1a6_CachotRoomConfig", package.seeall)

local V1a6_CachotRoomConfig = class("V1a6_CachotRoomConfig")

function V1a6_CachotRoomConfig:init(configTable)
	self._roomConfigTable = configTable
	self._roomConfigDict = configTable.configDict
	self._roomConfigList = configTable.configList
end

function V1a6_CachotRoomConfig:getRoomConfigList()
	return self._roomConfigList
end

function V1a6_CachotRoomConfig:getRoomConfigDict()
	return self._roomConfigDict
end

function V1a6_CachotRoomConfig:getCoByRoomId(id)
	return self:getRoomConfigDict()[id]
end

function V1a6_CachotRoomConfig:_initRoomInfo()
	if not self._layerRoomCount then
		self._layerRoomCount = {}

		for difficulty, co in pairs(lua_rogue_difficulty.configDict) do
			local initRoom = co.initRoom

			self._layerRoomCount[difficulty] = self._layerRoomCount[difficulty] or {}

			local layer
			local index = 1
			local roomCo = lua_rogue_room.configDict[initRoom]

			if roomCo then
				layer = roomCo.layer
				self._layerRoomCount[difficulty][roomCo.layer] = {
					count = 1
				}
				self._layerRoomCount[difficulty][layer][initRoom] = index

				local nextRoomCo = lua_rogue_room.configDict[roomCo.nextRoom]
				local roomSet

				if isDebugBuild then
					roomSet = {}
				end

				while nextRoomCo do
					if nextRoomCo.layer == layer then
						index = index + 1
						self._layerRoomCount[difficulty][layer][nextRoomCo.id] = index
						self._layerRoomCount[difficulty][layer].count = self._layerRoomCount[difficulty][layer].count + 1
					else
						index = 1
						layer = nextRoomCo.layer
						self._layerRoomCount[difficulty][nextRoomCo.layer] = {
							count = 1
						}
						self._layerRoomCount[difficulty][layer][nextRoomCo.id] = index
					end

					if roomSet then
						if roomSet[nextRoomCo.nextRoom] then
							logError("房间配置死循环了！！！！！！请检查配置")

							return
						else
							roomSet[nextRoomCo.nextRoom] = true
						end
					end

					nextRoomCo = lua_rogue_room.configDict[nextRoomCo.nextRoom]
				end
			end
		end
	end
end

function V1a6_CachotRoomConfig:getRoomIndexAndTotal(roomId)
	self:_initRoomInfo()

	local roomCo = lua_rogue_room.configDict[roomId]

	if not roomCo then
		return 0, 0
	end

	if roomCo.type == 0 then
		return self:getRoomIndexAndTotal(lua_rogue_difficulty.configDict[roomCo.difficulty].initRoom)
	end

	local info = self._layerRoomCount[roomCo.difficulty][roomCo.layer]

	if not info then
		return 0, 0
	end

	return info[roomCo.id], info.count
end

function V1a6_CachotRoomConfig:getLayerIndexAndTotal(roomId)
	self:_initRoomInfo()

	local roomCo = lua_rogue_room.configDict[roomId]

	if not roomCo then
		return 0, 0
	end

	if roomCo.type == 0 then
		return self:getLayerIndexAndTotal(lua_rogue_difficulty.configDict[roomCo.difficulty].initRoom)
	end

	local info = self._layerRoomCount[roomCo.difficulty]

	if not info then
		return 0, 0
	end

	return roomCo.layer, #info
end

function V1a6_CachotRoomConfig:getLayerName(layer, difficulty)
	for _, v in pairs(self._roomConfigDict) do
		if v.layer == layer and v.difficulty == difficulty then
			return v.name
		end
	end
end

function V1a6_CachotRoomConfig:checkNextRoomIsLastRoom(roomId)
	local co = self._roomConfigDict[roomId]

	if co then
		local nextRoomId = co.nextRoom

		if not nextRoomId then
			return true
		else
			local nextRoomCo = self._roomConfigDict[nextRoomId]

			if nextRoomCo and nextRoomCo.layer ~= co.layer then
				return true
			end
		end
	end

	return false
end

V1a6_CachotRoomConfig.instance = V1a6_CachotRoomConfig.New()

return V1a6_CachotRoomConfig
