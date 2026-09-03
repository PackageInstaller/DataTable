-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/ActivityBlockMapActivity.lua

require("dm.gameplay.activity.model.stageModel.ActivityStage")
require("dm.gameplay.develop.model.team.Team")
require("dm.gameplay.stage.model.StageManager")

ActivityBlockMapActivity = class("ActivityBlockMapActivity", BaseActivity, _M)

ActivityBlockMapActivity:has("_team", {
	is = "rw"
})
ActivityBlockMapActivity:has("_storySet", {
	is = "rw"
})

local litStageType = {
	HARD = "Hard",
	NORMAL = "Normal",
	ELITE = "Elite"
}
local cStageType = {
	[litStageType.NORMAL] = StageType.kNormal,
	[litStageType.ELITE] = StageType.kElite,
	[litStageType.HARD] = StageType.kHard
}

function ActivityBlockMapActivity:initialize()
	self._stagesMap = {}
	self._storySet = {}
	self._stagesMap[litStageType.NORMAL] = {}
	self._stagesMap[litStageType.ELITE] = {}
	self._stagesMap[litStageType.HARD] = {}
	self._mapList = {}
	self._mapList[litStageType.NORMAL] = {}
	self._mapList[litStageType.ELITE] = {}
	self._mapList[litStageType.HARD] = {}
	self._stagesMapIds = {}
end

function ActivityBlockMapActivity:synchronize(data)
	if not data then
		return
	end

	super.synchronize(self, data)

	self._activityConfig = self._activityConfig or self:getActivityConfig()

	if data.team then
		self._team = self._team or Team:new({})

		self._team:synchronize(data.team)
	end

	if data.storySet then
		self._storySet = data.storySet
	end

	if data.stageInfos then
		self:syncStageInfo(data.stageInfos)
	elseif data.storySet then
		self:initStoryInfo()
	end
end

function ActivityBlockMapActivity:syncStageInfo(data)
	for type, v in pairs(data) do
		if not self._stagesMap[type] then
			self._stagesMap[type] = {}
			self._mapList[type] = {}
		end

		for id, map in pairs(v.stageMaps) do
			if not self._stagesMap[type][id] then
				self._stagesMap[type][id] = ActivityStage:new(cStageType[type], id)

				if self._activityConfig.MapSort then
					self._stagesMap[type][id].index = tonumber(self._activityConfig.MapSort[id])
				end

				self._stagesMap[type][id]:setOwner(self)

				self._mapList[type][#self._mapList[type] + 1] = id
				self._stagesMapIds[id] = self._stagesMap[type][id]
			end

			self._stagesMap[type][id]:sync(map)
		end

		if self._activityConfig.MapSort then
			local length = 0

			for k, stage in pairs(self._stagesMap[type]) do
				length = length + 1
			end

			local list = {}
			local mapId
			local len = #list + 1

			for i = 1, length do
				for k, stage in pairs(self._stagesMap[type]) do
					if stage.index == len then
						list[len] = k
						len = #list + 1
					end
				end
			end

			self._mapList[type] = list
		end
	end
end

function ActivityBlockMapActivity:initStoryInfo(data)
	for k, stageList in pairs(self._stagesMap) do
		for _, _stage in pairs(stageList) do
			_stage:initStoryPointMap()
		end
	end
end

function ActivityBlockMapActivity:hasRedPoint()
	for k, stageList in pairs(self._stagesMap) do
		for k, stage in pairs(stageList) do
			if stage and stage:hasRedPoint() then
				return true
			end
		end
	end

	return false
end

function ActivityBlockMapActivity:hasRedPointByType(type)
	for k, stageList in pairs(self._stagesMap) do
		for k, stage in pairs(stageList) do
			if stage and stage:getType() == type and stage:hasRedPoint() then
				return true
			end
		end
	end

	return false
end

function ActivityBlockMapActivity:getStageByStageType(stageType)
	local type = litStageType[stageType]
	local stageMap = self._stagesMap[type]

	return stageMap[self._mapList[type][1]]
end

function ActivityBlockMapActivity:getActivityMapById(mapId)
	local mapType = ConfigReader:getDataByNameIdAndKey("ActivityBlockMap", mapId, "Type")

	if mapType then
		local type = litStageType[mapType]
		local stageMap = self._stagesMap[type]

		for k, stage in pairs(stageMap) do
			if mapId == stage._mapId then
				return stage
			end
		end

		return stageMap[self._mapList[type][1]]
	end
end

function ActivityBlockMapActivity:getPointById(pointId)
	if not pointId then
		return
	end

	local mapid = ConfigReader:getDataByNameIdAndKey("ActivityBlockPoint", pointId, "Map")

	mapid = mapid or ConfigReader:getDataByNameIdAndKey("ActivityStoryPoint", pointId, "Map")

	if not mapid then
		return
	end

	local stage = self:getActivityMapById(mapid)

	return stage:getPointById(pointId)
end

function ActivityBlockMapActivity:getMapIdByStageType(stageType)
	local stage = self:getStageByStageType(stageType)

	return stage:getMapId()
end

function ActivityBlockMapActivity:getMapIdStartTimeByStageType(stageType)
	local stage = self:getStageByStageType(stageType)

	return stage:getStartTimestamp()
end

function ActivityBlockMapActivity:getStageTypeById(pointId)
	local point = self:getPointById(pointId)

	return point:getType()
end

function ActivityBlockMapActivity:getMapIdByPointId(pointId)
	local mapid = ConfigReader:getDataByNameIdAndKey("ActivityBlockPoint", pointId, "Map")

	mapid = mapid or ConfigReader:getDataByNameIdAndKey("ActivityStoryPoint", pointId, "Map")

	return mapid
end

function ActivityBlockMapActivity:getMapByIndex(index, stageType)
	if stageType == nil then
		stageType = StageType.kNormal
	end

	if not litStageType[stageType] then
		local type = litStageType[StageType.kNormal]
		local stageMap = self._stagesMap[type]
		local index = tonumber(index)

		return stageMap[self._mapList[type][index]]
	end
end

function ActivityBlockMapActivity:getAssistEnemyInfo(enemyId)
	local enemyInfo = ConfigReader:getRecordById("EnemyHero", enemyId)

	if not enemyInfo then
		return nil
	end

	local var_15_0 = {
		awakenLevel = 0,
		isNpc = true,
		id = enemyInfo.Id,
		level = enemyInfo.Level,
		star = enemyInfo.Star,
		rareity = enemyInfo.Rarity
	}

	var_15_0.name = Strings:get(enemyInfo.Name or "NPC")
	var_15_0.roleModel = enemyInfo.RoleModel
	var_15_0.type = enemyInfo.Type
	var_15_0.cost = enemyInfo.Cost
	var_15_0.combat = enemyInfo.Combat
	var_15_0.maxStar = HeroStarCountMax

	return var_15_0
end

function ActivityBlockMapActivity:getAssistEnemyList(mapId)
	local list = {}

	for mapId, stage in ipairs(self._stagesMapIds) do
		local points = stage:getIndex2Points()

		for index, pointId in ipairs(points) do
			local assistEnemy = self:getPointById(pointId):getAssistEnemy()

			for i, enemyId in ipairs(assistEnemy) do
				local enemyData = self:getAssistEnemyInfo(enemyId)

				if enemyData then
					list[#list + 1] = enemyData
				end
			end
		end
	end

	return list
end

function ActivityBlockMapActivity:isHeroAttrStarExtra()
	for k, stageList in pairs(self._stagesMap) do
		for _, _stage in pairs(stageList) do
			local points = _stage:getIndex2Points()

			for _, point in ipairs(points) do
				local heroAttrStarExtra = point:getHeroAttrStarExtra()

				if heroAttrStarExtra then
					return true
				end
			end
		end
	end

	return false
end

function ActivityBlockMapActivity:isAllPointPass(stageType)
	for mapId, stage in ipairs(self._stagesMapIds) do
		local points = stage:getIndex2Points()

		for index, pointId in ipairs(points) do
			for _, point in ipairs(points) do
				local isPass = point:isPass()

				if not isPass then
					return false
				end
			end
		end
	end

	return true
end
