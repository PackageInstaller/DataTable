-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/config/ZooConfig.lua

module("logic.extensions.zoo.config.ZooConfig", package.seeall)

local ZooConfig = class("ZooConfig", BaseConfig)

ZooConfig.GENENULLERRORTIP = "找不到基因id:%s的配置信息,找策划加上"

function ZooConfig:onInit()
	ZooConfig.super.onInit(self)
end

function ZooConfig:getNames()
	return {
		"zoo_params",
		"zoo_animal",
		"zoo_animal_level",
		"zoo_animal_gene_plan",
		"zoo_animal_gene",
		"zoo_animal_work_gene",
		"zoo_animal_gene_benefit",
		"zoo_travel_man_egg_lottery",
		"zoo_scene_config",
		"zoo_main_building",
		"zoo_building",
		"zoo_restaurant",
		"zoo_exchange_shop",
		"zoo_coffee_shop",
		"zoo_amusement_park",
		"zoo_quarry",
		"zoo_resource_tree",
		"zoo_speed_up_card",
		"zoo_exchange_item"
	}
end

function ZooConfig:handleConfig(name, content)
	if name == "zoo_params" then
		self._zooParams = content
	elseif name == "zoo_animal" then
		self._zooAnimal = content
	elseif name == "zoo_animal_level" then
		self._zooAnimalLevel = content
	elseif name == "zoo_animal_gene_plan" then
		self._zooAnimalGenePlan = content
	elseif name == "zoo_animal_gene" then
		self._zooAnimalGene = content

		for i = 1, #self._zooAnimalGene.dataList do
			self._zooAnimalGene.dataList[i].geneType = 1
		end
	elseif name == "zoo_animal_work_gene" then
		self._zooAnimalWorkGene = content

		for i = 1, #self._zooAnimalWorkGene.dataList do
			self._zooAnimalWorkGene.dataList[i].geneType = 3
		end
	elseif name == "zoo_animal_gene_benefit" then
		self._zooAnimalGeneBenefit = content

		for i = 1, #self._zooAnimalGeneBenefit.dataList do
			self._zooAnimalGeneBenefit.dataList[i].geneType = 2
		end
	elseif name == "zoo_scene_config" then
		self._zooSceneConfig = content
	elseif name == "zoo_travel_man_egg_lottery" then
		self._zooTravelManEgglottery = content
	elseif name == "zoo_main_building" then
		self._zooMainBuilding = content
	elseif name == "zoo_building" then
		self._zooBuildings = content

		self:_initBuildingTypeMaps()
	elseif name == "zoo_restaurant" then
		self._zooRestaurantBuildings = content
	elseif name == "zoo_exchange_shop" then
		self._zooShopBuildings = content
	elseif name == "zoo_coffee_shop" then
		self._zooCafeBuildings = content
	elseif name == "zoo_amusement_park" then
		self._zooAmusementParkBuildings = content
	elseif name == "zoo_quarry" then
		self._zooQuarryBuildings = content
	elseif name == "zoo_resource_tree" then
		self._zooTreeBuildings = content
	elseif name == "zoo_speed_up_card" then
		self._zooSpeedUpCard = content
	elseif name == "zoo_exchange_item" then
		self._exchangeItems = content
	end
end

function ZooConfig:_initBuildingTypeMaps()
	self._buildingTypeMaps = {}

	local allBuildingCos = self:getAllBuildings()

	for i = 1, #allBuildingCos do
		self._buildingTypeMaps[allBuildingCos[i].buildingType] = allBuildingCos[i]
	end
end

function ZooConfig:getZooParamsByKey(key)
	return self._zooParams[key].value
end

function ZooConfig:getAnimalById(animalId)
	return self._zooAnimal[animalId]
end

function ZooConfig:getAnimal()
	return self._zooAnimal
end

function ZooConfig:getAnimalLevelById(level)
	return self._zooAnimalLevel[level]
end

function ZooConfig:getAnimalLevel()
	return self._zooAnimalLevel
end

function ZooConfig:getGene(id)
	if id then
		return self._zooAnimalGene[id]
	end

	return self._zooAnimalGene, self._zooAnimalGene.dataList
end

function ZooConfig:getWorkGeneById(id)
	return self._zooAnimalWorkGene[id]
end

function ZooConfig:getWorkGene()
	return self._zooAnimalWorkGene
end

function ZooConfig:getGeneBenefitById(id)
	return self._zooAnimalGeneBenefit[id]
end

function ZooConfig:getGeneBenefit()
	return self._zooAnimalGeneBenefit
end

function ZooConfig:getZooSceneCo(id)
	return self._zooSceneConfig[id]
end

function ZooConfig:getZooTravelManEgglottery()
	return self._zooTravelManEgglottery.dataList
end

function ZooConfig:getMainBuildingCo(level)
	return self._zooMainBuilding[level]
end

function ZooConfig:getAllMainBuildingCos()
	return self._zooMainBuilding.dataList
end

function ZooConfig:getRestaurantBuildingCo(level)
	return self._zooRestaurantBuildings[level]
end

function ZooConfig:getAllRestaurantBuildingCos()
	return self._zooRestaurantBuildings.dataList
end

function ZooConfig:getShopBuildingCo(level)
	return self._zooShopBuildings[level]
end

function ZooConfig:getAllShopsBuildingCos()
	return self._zooShopBuildings.dataList
end

function ZooConfig:getCafeBuildingCo(level)
	return self._zooCafeBuildings[level]
end

function ZooConfig:getAllCafesBuildingCos()
	return self._zooCafeBuildings.dataList
end

function ZooConfig:getAmusementParkBuildingCo(level)
	return self._zooAmusementParkBuildings[level]
end

function ZooConfig:getAllAmusementParkBuildingCos()
	return self._zooAmusementParkBuildings.dataList
end

function ZooConfig:getQuarryBuildingCo(level)
	return self._zooQuarryBuildings[level]
end

function ZooConfig:getAllQuarryBuildingCos()
	return self._zooQuarryBuildings.dataList
end

function ZooConfig:getTreeBuildingCo(level)
	return self._zooTreeBuildings[level]
end

function ZooConfig:getAllTreeBuildingCos()
	return self._zooTreeBuildings.dataList
end

function ZooConfig:getBuildingCo(id)
	return self._zooBuildings[id]
end

function ZooConfig:getBuildingCoByBuildingType(buildingType)
	return self._buildingTypeMaps[buildingType]
end

function ZooConfig:getAllBuildings()
	return self._zooBuildings.dataList
end

function ZooConfig:getAllSpeedUpCards()
	return self._zooSpeedUpCard.dataList
end

function ZooConfig:getAllExchangeItems()
	return self._exchangeItems.dataList
end

function ZooConfig:getMaxAbsorbTime()
	return checknumber(self:getZooParamsByKey("MAX_ABSORB_TIME")) * 3600
end

function ZooConfig:getAbsorbCDInterval()
	return checknumber(self:getZooParamsByKey("ABSORB_DEVICE_CD_INTERVAL"))
end

function ZooConfig:getBeStolenFriutMaxNum()
	return checknumber(self:getZooParamsByKey("BE_STOLEN_FRUIT_MAX_NUM"))
end

function ZooConfig:getStealFriutMaxNum()
	return checknumber(self:getZooParamsByKey("STEAL_FRUIT_MAX_NUM"))
end

function ZooConfig:getBadActIncMoral()
	return checknumber(self:getZooParamsByKey("BAD_ACT_INC_MORAL"))
end

function ZooConfig:getGoodActIncMoral()
	return checknumber(self:getZooParamsByKey("GOOD_ACT_INC_MORAL"))
end

function ZooConfig:getBadActIncMoralString()
	return string.format(lang("petzoo_moral"), self:getBadActIncMoral())
end

function ZooConfig:getGoodActIncMoralString()
	return string.format(lang("petzoo_moral"), "+" .. self:getGoodActIncMoral())
end

function ZooConfig:getTravelManCD()
	return checknumber(self:getZooParamsByKey("TRAVEL_MAN_CD"))
end

function ZooConfig:getDigTreasureMaxTimes()
	return checknumber(self:getZooParamsByKey("DIG_TREASURE_MAX_TIMES"))
end

function ZooConfig:getFeedCostItem()
	return self:getZooParamsByKey("FEED_COST_ITEM")
end

function ZooConfig:getFeedBuddyAnimalMaxTimes()
	return checknumber(self:getZooParamsByKey("FEED_BUDDY_ANIMAL_TIMES"))
end

function ZooConfig:getInZooInteractDailyTimes()
	return checknumber(self:getZooParamsByKey("IN_ZOO_INTERACT_DAILY_NUM"))
end

function ZooConfig:getMaxAnimalNum()
	return checknumber(self:getZooParamsByKey("MAX_ANIMAL_NUM"))
end

function ZooConfig:getMaxAnimalEggsNum()
	return checknumber(self:getZooParamsByKey("MAX_ANIMAL_EGG_NUM"))
end

function ZooConfig:getRecycleAnimalGain()
	return self:getZooParamsByKey("RECYCLE_ANIMAL_GAIN")
end

function ZooConfig:getChangeAnimalNameCost()
	return self:getZooParamsByKey("CHANGE_ANIMAL_NAME_COST")
end

function ZooConfig:getAbsorbNeedRestHatchTime()
	return checknumber(self:getZooParamsByKey("ABSORB_NEED_REST_HATCH_TIME")) * 60
end

function ZooConfig:getAbsorbDevicePrize()
	return self:getZooParamsByKey("ABSORB_DEVICE_PRIZE")
end

function ZooConfig:getMaxMatchTimes()
	return checknumber(self:getZooParamsByKey("MAX_MATCH_TIMES"))
end

function ZooConfig:getInviteMatchWaitingTime()
	return checknumber(self:getZooParamsByKey("INVITE_PAIR_TIME"))
end

function ZooConfig:getRecycleAnimalNeedLvTime()
	return checknumber(self:getZooParamsByKey("RECYCLE_ANIMAL_NEED_LV"))
end

function ZooConfig:getMatchCDInterval()
	return checknumber(self:getZooParamsByKey("MATCH_CD_INTERVAL")) * 60
end

ZooConfig.instance = ZooConfig.New()

return ZooConfig
