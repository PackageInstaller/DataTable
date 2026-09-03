-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/condition/Conditionkeeper.lua

require("dm.gameplay.condition.ConditionList")
require("dm.gameplay.condition.ConditionAlgorithm")
require("dm.gameplay.condition.ConditionValue")

Conditionkeeper = class("Conditionkeeper", legs.Actor)

Conditionkeeper:has("_conditionList", {
	is = "r"
})

function Conditionkeeper:initialize()
	super.initialize(self)

	self._valueFuncMap = {}
	self._algorithmMap = {}

	self:initSystem()

	self._conditionList = ConditionList:new()
end

function Conditionkeeper:initSystem()
	self._algorithm = ConditionAlgorithm:new(self)
	self._typeFunction = ConditionValue:new(self)
end

function Conditionkeeper:userInject(injector)
	injector:injectInto(self._algorithm)
	injector:injectInto(self._typeFunction)
end

function Conditionkeeper:synchronize(data)
	if not data then
		return
	end

	self._conditionList:synchronize(data)
end

function Conditionkeeper:getConditionById(id)
	return self._conditionList:getConditionById(id)
end

function Conditionkeeper:syncDevelopConditions(data)
	if not data then
		return
	end

	if data.sectPosLvUp then
		self._conditionList:synchronize(data.sectPosLvUp.tasks)
	end

	if data.sectMannerLvUp then
		local tasks = {}

		for k, value in pairs(data.sectMannerLvUp.tasks) do
			tasks[k .. "_manner"] = value
			tasks[k .. "_manner"].taskId = k .. "_manner"
		end

		self._conditionList:synchronize(tasks)
	end
end

local spStageNameMap = {
	EQUIPMENT = "StageSp_Equipment_Name",
	CRYSTAL = "StageSp_Crystal_Name",
	SKILL_2 = "StageSp_Skill_2_Name",
	SKILL_3 = "StageSp_Skill_3_Name",
	EXP = "StageSp_Exp_Name",
	GOLD = "StageSp_Gold_Name",
	SKILL_1 = "StageSp_Skill_1_Name"
}
local StageName = {
	NORMAL = "Task_UI31",
	ELITE = "Task_UI32"
}
local kPicScore = {
	["0"] = "C",
	["3"] = "S",
	["1"] = "B",
	["2"] = "A"
}

function Conditionkeeper:getConditionDesc(condition, descId)
	local config = ConfigReader:getRecordById("ConditionType", condition.conditionType)

	if config then
		local desc = Strings:get(descId or config.EffectDesc, {
			fontName = TTF_FONT_FZYH_R
		})
		local t = TextTemplate:new(desc)
		local funcMap = {
			type = function(value)
				return Strings:get(StageName[value[1]])
			end,
			quality = function(value)
				local developSystem = self:getInjector():getInstance(DevelopSystem)
				local heroSystem = developSystem:getHeroSystem()

				return (heroSystem:getQualityName(value))
			end,
			kerne = function(value)
				local name = ConfigReader:getDataByNameIdAndKey("MasterCoreSuite", value, "Name")

				return Strings:get(name)
			end,
			rarity = function(value)
				return GameStyle:getHeroRarityText(value)
			end,
			map = function(value)
				local stageSystem = self:getInjector():getInstance(StageSystem)
				local stageMap = stageSystem:getMapById(value)

				return stageMap ~= nil and stageMap:getIndexDesc()
			end,
			point = function(value)
				local stageSystem = self:getInjector():getInstance(StageSystem)
				local mapIndex = stageSystem:getMapIndexByPointId(value)
				local pointIndex = stageSystem:getPointIndexById(value)

				return Strings:get("FactorTransform_Point", {
					map = mapIndex,
					point = pointIndex
				})
			end,
			artifact = function(value)
				local artifactConfig = ConfigReader:getRecordById("ArtifactMain", value)

				return artifactConfig ~= nil and Strings:get(artifactConfig.Name)
			end,
			SourceStage = function(value)
				return spStageNameMap[value] ~= nil and Strings:get(spStageNameMap[value])
			end,
			currency = function(value)
				local itemConfig = ConfigReader:getRecordById("ItemConfig", value)

				return itemConfig ~= nil and Strings:get(itemConfig.Name)
			end,
			shop = function(value)
				local shopConfig = ConfigReader:getRecordById("Shop", value)

				return shopConfig ~= nil and Strings:get(shopConfig.Name)
			end,
			mappoint = function(value)
				local exploreSystem = self:getInjector():getInstance(ExploreSystem)
				local mapObj = exploreSystem:getMapPointObjById(value)

				return mapObj:getName()
			end,
			maptype = function(value)
				local exploreSystem = self:getInjector():getInstance(ExploreSystem)
				local mapObj = exploreSystem:getMapTypesDic(value)

				return mapObj:getName()
			end,
			heroName = function(value)
				local heroConfig = ConfigReader:getRecordById("HeroBase", value)

				return heroConfig ~= nil and Strings:get(heroConfig.Name)
			end,
			tower = function(value)
				local translateId = "TowerStage" .. value

				return Strings:get(translateId)
			end,
			activity = function(value)
				local activityConfig = ConfigReader:getRecordById("Activity", value)

				return activityConfig ~= nil and Strings:get(activityConfig.Title)
			end,
			practicestage = function(value)
				local stagePracticeConfig = ConfigReader:getRecordById("StagePracticeMap", value)

				return stagePracticeConfig ~= nil and Strings:get(stagePracticeConfig.MapName)
			end,
			resourceName = function(value)
				local type = value[1]
				local id = value[2]

				if type == "2" then
					local itemConfig = ConfigReader:getRecordById("ItemConfig", id)

					return itemConfig ~= nil and Strings:get(itemConfig.Name)
				elseif type == "7" and id == "0" then
					local resourceConfig = ConfigReader:getRecordById("ResourcesIcon", id)

					return resourceConfig ~= nil and Strings:get(resourceConfig.Name)
				end
			end,
			translate = function(value)
				return Strings:get(value)
			end,
			PansLabFightPoint = function(value)
				local name = ConfigReader:getDataByNameIdAndKey("PansLabFightPoint", value, "Name")

				return Strings:get(name)
			end,
			PansLabList = function(value)
				local name = ConfigReader:getDataByNameIdAndKey("PansLabList", value, "StoryName")

				return Strings:get(name)
			end,
			blocksp = function(value)
				local name = ConfigReader:getDataByNameIdAndKey("BlockSpPoint", value, "PointName")

				return Strings:get(name)
			end,
			evaluate = function(value)
				return kPicScore[value]
			end
		}

		return t:stringify(condition, funcMap)
	else
		return ""
	end
end

local descMap = {
	KillNum = "VictoryConditions4",
	KeyUnitsDied = "VictoryConditions3",
	TimeOut = {
		SideB = "VictoryConditions1",
		SideA = "VictoryConditions2"
	}
}

function Conditionkeeper:getVictoryConditionsDesc(conditions, extra)
	local condition = conditions[1]

	dump(condition, "condition")

	local desc = descMap[condition.type]

	if desc then
		if condition.type == "TimeOut" then
			return Strings:get(desc[condition.winner])
		end

		if condition.type == "KillNum" then
			local count = condition.factor.count

			return Strings:get(desc, {
				num = count
			})
		end

		if condition.type == "KeyUnitsDied" then
			local tag = condition.factor.unitTag
			local name = ""
			local assist = extra.assist

			for i, v in pairs(assist) do
				local config = ConfigReader:getRecordById("EnemyHero", v.id)

				for _, flag in pairs(config.Flags) do
					if flag == tag then
						name = Strings:get(config.Name)
					end
				end
			end

			return Strings:get(desc, {
				name = name
			})
		end
	end

	return ""
end

function Conditionkeeper:registerConditionValueFunc(key, func)
	self._valueFuncMap[key] = func
end

function Conditionkeeper:registerAlgorlthm(key, algorithm)
	self._algorithmMap[key] = algorithm
end

function Conditionkeeper:isConditionReach(condition)
	local config = ConfigReader:getRecordById("ConditionTypeClient", condition.conditionType)

	if config then
		local aValue
		local func = self._valueFuncMap[config.ConditionType1]
		local algorithm = self._algorithmMap[config.AchieveType1]

		if algorithm then
			return algorithm(self, (func or nil) and func(self, config.ConditionType1), condition.factor1)
		end
	end
end
