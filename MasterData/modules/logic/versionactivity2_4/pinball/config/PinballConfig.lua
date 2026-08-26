-- chunkname: @modules/logic/versionactivity2_4/pinball/config/PinballConfig.lua

module("modules.logic.versionactivity2_4.pinball.config.PinballConfig", package.seeall)

local PinballConfig = class("PinballConfig", BaseConfig)

function PinballConfig:onInit()
	self._mapCos = {}
	self._taskDict = {}
end

function PinballConfig:reqConfigNames()
	return {
		"activity178_building",
		"activity178_building_hole",
		"activity178_const",
		"activity178_episode",
		"activity178_talent",
		"activity178_task",
		"activity178_score",
		"activity178_resource",
		"activity178_marbles"
	}
end

function PinballConfig:getTaskByActId(activityId)
	local list = self._taskDict[activityId]

	if not list then
		list = {}

		for _, co in ipairs(lua_activity178_task.configList) do
			if co.activityId == activityId then
				table.insert(list, co)
			end
		end

		self._taskDict[activityId] = list
	end

	return list
end

function PinballConfig:getMapCo(mapId)
	if not self._mapCos[mapId] then
		local co = PinballMapCo.New()
		local rawCo = addGlobalModule("modules.configs.pinball.lua_pinball_map_" .. tostring(mapId), "lua_pinball_map_" .. tostring(mapId))

		if not rawCo then
			logError("弹珠地图配置不存在" .. mapId)

			return
		end

		co:init(rawCo)

		self._mapCos[mapId] = co
	end

	return self._mapCos[mapId]
end

function PinballConfig:getConstValue(activityId, id)
	local co = lua_activity178_const.configDict[activityId][id]

	if co then
		return co.value, co.value2
	else
		return 0, ""
	end
end

function PinballConfig:getAllHoleCo(activityId)
	local holeMap = lua_activity178_building_hole.configDict[activityId]

	return holeMap or {}
end

function PinballConfig:getTalentCoByRoot(activityId, talentRoot)
	local cos = {}

	for _, talentCo in pairs(lua_activity178_talent.configDict[activityId]) do
		if talentCo.root == talentRoot then
			table.insert(cos, talentCo)
		end
	end

	return cos
end

function PinballConfig:getAllBuildingCo(activityId, size)
	local buildingDict = lua_activity178_building.configDict[activityId]
	local list = {}

	if not buildingDict then
		return list
	end

	for id, dict in pairs(buildingDict) do
		if dict[1] and dict[1].size == size and dict[1].type ~= PinballEnum.BuildingType.MainCity then
			table.insert(list, dict[1])
		end
	end

	return list
end

function PinballConfig:getScoreLevel(activityId, score)
	local map = lua_activity178_score.configDict[activityId]

	if not map then
		return 0, 0, 0
	end

	local level, baseScore, nextScore = 1, 0, 0

	while true do
		local nextCo = map[level + 1]

		if not nextCo then
			baseScore = map[level].value
			nextScore = map[level].value

			break
		end

		if score >= nextCo.value then
			level = level + 1
		else
			baseScore = map[level].value
			nextScore = nextCo.value

			break
		end
	end

	return level, baseScore, nextScore
end

function PinballConfig:getRandomEpisode(type, noRandomId)
	if not self._episodeByType then
		self._episodeByType = {}

		for _, co in pairs(lua_activity178_episode.configList) do
			self._episodeByType[co.type] = self._episodeByType[co.type] or {}

			table.insert(self._episodeByType[co.type], co)
		end
	end

	if not self._episodeByType[type] then
		return
	end

	local all = {}

	for _, co in pairs(self._episodeByType[type]) do
		if co.condition <= PinballModel.instance.maxProsperity and co.condition2 >= PinballModel.instance.maxProsperity then
			table.insert(all, co)
		end
	end

	local len = #all

	if len <= 0 then
		return
	end

	local selectIndex = math.random(1, len)
	local episodeCo = all[selectIndex]

	if len > 1 and episodeCo.id == noRandomId then
		selectIndex = selectIndex + 1

		if len < selectIndex then
			selectIndex = 1
		end

		episodeCo = all[selectIndex]
	end

	return episodeCo
end

PinballConfig.instance = PinballConfig.New()

return PinballConfig
