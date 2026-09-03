-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/model/EliteStage.lua

require("dm.gameplay.stage.model.Stage")
require("dm.gameplay.stage.model.EliteStageMap")

EliteStage = class("EliteStage", Stage, _M)

function EliteStage:initialize()
	super.initialize(self)

	self._systemName = "Elite_Stage"
	self._initMapUnlockState = false
end

function EliteStage:sync(data)
	local stageMaps = {}

	if data and data.stageMaps then
		stageMaps = data.stageMaps
	end

	if self._index2Maps == nil then
		self._index2Maps = {}
		self._id2Maps = {}

		local mapIds = ConfigReader:getDataByNameIdAndKey("ConfigValue", self:getMapListKey(), "content")
		local mapCount = #mapIds

		for index = 1, mapCount do
			local mapId = mapIds[index]
			local map = EliteStageMap:new(mapId)

			map:setIndex(index)
			map:setOwner(self)
			map:sync(stageMaps[mapId] or {})

			self._index2Maps[index] = map
			self._id2Maps[mapId] = map
		end

		self:setMapCount(mapCount)
	else
		for mapId, mapData in pairs(stageMaps) do
			local map = self._id2Maps[mapId]

			if map == nil then
				assert(false, "EliteStage:sync: mapId unexist : " .. mapId)
			end

			map:sync(mapData)
		end
	end
end

function EliteStage:eliteStageExtraInit()
	if not self._initMapUnlockState then
		self:setUnlockMapIndex(self:getMapCount())
		self:setNewOpenMapIndex(self:getMapCount())

		for index, map in ipairs(self._index2Maps) do
			if not map:isUnlock() then
				self:setUnlockMapIndex(index - 1)
				self:setNewOpenMapIndex(index - 1)

				break
			end
		end

		self._initMapUnlockState = true
	end
end

function EliteStage:getMapConfigName()
	return "BlockMap"
end

function EliteStage:getPointConfigName()
	return "BlockPoint"
end

function EliteStage:getMapListKey()
	return "EliteBlock_MapList"
end
