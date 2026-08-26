-- chunkname: @modules/logic/weekwalk/model/WeekwalkInfoMO.lua

module("modules.logic.weekwalk.model.WeekwalkInfoMO", package.seeall)

local WeekwalkInfoMO = pureTable("WeekwalkInfoMO")

function WeekwalkInfoMO:init(info)
	self.time = info.time
	self.endTime = info.endTime
	self.maxLayer = info.maxLayer
	self.issueId = info.issueId
	self.isPopDeepRule = info.isPopDeepRule
	self.isOpenDeep = info.isOpenDeep
	self.isPopShallowSettle = info.isPopShallowSettle
	self.isPopDeepSettle = info.isPopDeepSettle
	self.deepProgress = info.deepProgress
	self._mapInfos = {}
	self._mapInfosMap = {}
	self._mapInfoLayerMap = {}

	if info.mapInfo then
		for i, v in ipairs(info.mapInfo) do
			local info = MapInfoMO.New()

			info:init(v)

			self._mapInfosMap[v.id] = info

			table.insert(self._mapInfos, info)

			local layer = info:getLayer()

			if layer then
				if not self._mapInfoLayerMap[layer] then
					self._mapInfoLayerMap[layer] = info
				else
					logError("WeekwalkInfoMO init error,layer repeat:" .. tostring(layer))
				end
			end
		end
	end

	table.sort(self._mapInfos, WeekwalkInfoMO._sort)
end

function WeekwalkInfoMO._sort(a, b)
	return a.id < b.id
end

function WeekwalkInfoMO:getMapInfos()
	return self._mapInfos
end

function WeekwalkInfoMO:getMapInfoLayer()
	return self._mapInfoLayerMap
end

function WeekwalkInfoMO:getNotFinishedMap()
	local index = #self._mapInfos

	return self._mapInfos[index], index
end

function WeekwalkInfoMO:getNameIndexByBattleId(battleId)
	local targetMap

	for _, map in ipairs(self._mapInfos) do
		if map:getBattleInfo(battleId) then
			targetMap = map

			break
		end
	end

	if not targetMap then
		return
	end

	for i, v in ipairs(lua_weekwalk.configList) do
		if v.id == targetMap.id then
			local sceneConfig = lua_weekwalk_scene.configDict[targetMap.sceneId]

			return sceneConfig.battleName, v.layer
		end
	end
end

function WeekwalkInfoMO:getMapInfo(id)
	return self._mapInfosMap[id]
end

function WeekwalkInfoMO:getMapInfoByLayer(layer)
	for _, map in ipairs(self._mapInfos) do
		if map:getLayer() == layer then
			return map
		end
	end
end

return WeekwalkInfoMO
