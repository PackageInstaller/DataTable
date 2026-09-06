-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/islandstation/config/IslandStationConfig.lua

module("logic.extensions.islandstation.config.IslandStationConfig", package.seeall)

local IslandStationConfig = class("IslandStationConfig", BaseConfig)

function IslandStationConfig:onInit()
	IslandStationConfig.super.onInit(self)
end

function IslandStationConfig:getNames()
	return {
		"island_station_activity",
		"island_station_shop",
		"island_station_shop_level",
		"island_station_girl",
		"island_station_food",
		"island_station_food_stuff",
		"island_station_cook_book",
		"island_station_dialogue",
		"island_station_girl_npc",
		"island_station_small_game",
		"island_station_damage_prize",
		"island_station_master",
		"island_station_creeps",
		"island_station_support_pet",
		"island_station_story_group",
		"island_station_story",
		"island_station_bubble_words",
		"island_station_find_difference"
	}
end

function IslandStationConfig:handleConfig(name, content)
	if name == "island_station_activity" then
		self._island_station_activity = content
	elseif name == "island_station_shop" then
		self._island_station_shop = content
	elseif name == "island_station_shop_level" then
		self._island_station_shop_level = content
	elseif name == "island_station_girl" then
		self._island_station_girl = content

		self:_sortGirlCfgByShopId()
	elseif name == "island_station_food" then
		self._island_station_food = content

		self:_sortFoodCfgByShopId()
	elseif name == "island_station_food_stuff" then
		self._island_station_food_stuff = content
	elseif name == "island_station_cook_book" then
		self._island_station_cook_book = content
	elseif name == "island_station_dialogue" then
		self._island_station_dialogue = content
	elseif name == "island_station_girl_npc" then
		self._island_station_girl_npc = content
	elseif name == "island_station_small_game" then
		self._island_station_small_game = content
	elseif name == "island_station_damage_prize" then
		self._island_station_damage_prize = content
	elseif name == "island_station_master" then
		self._island_station_master = content
	elseif name == "island_station_creeps" then
		self._island_station_creeps = content
	elseif name == "island_station_support_pet" then
		self._island_station_supporpet = content
	elseif name == "island_station_story_group" then
		self._island_station_story_group = content
	elseif name == "island_station_story" then
		self._island_station_story = content
	elseif name == "island_station_bubble_words" then
		self._island_station_bubble_words = content
	elseif name == "island_station_find_difference" then
		self._island_station_find_difference = content
	end
end

function IslandStationConfig:_sortFoodCfgByShopId()
	self._foodCfgByDic = {}

	for activityId, cfgs in pairs(self._island_station_food) do
		self._foodCfgByDic[activityId] = {}

		local curActDic = self._foodCfgByDic[activityId]

		for i, cfg in pairs(cfgs) do
			curActDic[cfg.shopId] = curActDic[cfg.shopId] or {}

			local curShopFoodCfgList = curActDic[cfg.shopId]

			table.insert(curShopFoodCfgList, cfg)
		end
	end
end

function IslandStationConfig:_sortGirlCfgByShopId()
	self._girlCfgDic = {}

	for activityId, cfgs in pairs(self._island_station_girl) do
		self._girlCfgDic[activityId] = self._girlCfgDic[activityId] or {}

		local curActDic = self._girlCfgDic[activityId]

		for i, cfg in pairs(cfgs) do
			curActDic[cfg.shopId] = curActDic[cfg.shopId] or {}

			local curShopFoodCfgList = curActDic[cfg.shopId]

			table.insert(curShopFoodCfgList, cfg)
		end
	end
end

function IslandStationConfig:getActCfg(activityId)
	return self._island_station_activity[activityId]
end

function IslandStationConfig:getShopCfg(activityId)
	return self._island_station_shop[activityId]
end

function IslandStationConfig:getShopCfgByShopId(activityId, shopId)
	return self._island_station_shop[activityId] and self._island_station_shop[activityId][shopId]
end

function IslandStationConfig:getShopLevelCfg(shopLvPlanId)
	return self._island_station_shop_level[shopLvPlanId]
end

function IslandStationConfig:getShopLevelCfgByLevel(shopLvPlanId, level)
	return self._island_station_shop_level[shopLvPlanId] and self._island_station_shop_level[shopLvPlanId][level]
end

function IslandStationConfig:getGirlCfg(activityId)
	return self._island_station_girl[activityId]
end

function IslandStationConfig:getGirlCfgByGirlId(activityId, girlId)
	return self._island_station_girl[activityId] and self._island_station_girl[activityId][girlId]
end

function IslandStationConfig:getGirlCfgsByShopId(activityId, shopId)
	return self._girlCfgDic[activityId] and self._girlCfgDic[activityId][shopId]
end

function IslandStationConfig:getFoodCfgByFoodId(activityId, foodId)
	return self._island_station_food[activityId] and self._island_station_food[activityId][foodId]
end

function IslandStationConfig:getFoodCfgByShopId(activityId, shopId)
	return self._foodCfgByDic[activityId] and self._foodCfgByDic[activityId][shopId]
end

function IslandStationConfig:getFoodStuffCfg(activityId)
	return self._island_station_food_stuff[activityId]
end

function IslandStationConfig:getFoodStuffCfgById(activityId, foodStuffId)
	return self._island_station_food_stuff[activityId] and self._island_station_food_stuff[activityId][foodStuffId]
end

function IslandStationConfig:getCookBookCfg(activityId)
	return self._island_station_cook_book[activityId]
end

function IslandStationConfig:getCookBookCfgByFoodId(activityId, foodId)
	return self._island_station_cook_book[activityId] and self._island_station_cook_book[activityId][foodId]
end

function IslandStationConfig:getGirlNpcCfg(npcId)
	return self._island_station_girl_npc[npcId]
end

function IslandStationConfig:getSmallGameCfg(activityId)
	return self._island_station_small_game[activityId]
end

function IslandStationConfig:getSmallGameCfgById(activityId, gameStageId)
	return self._island_station_small_game[activityId] and self._island_station_small_game[activityId][gameStageId]
end

function IslandStationConfig:getDamagePrizeCfg(activityId)
	return self._island_station_damage_prize[activityId]
end

function IslandStationConfig:getDamagePrizeCfgById(activityId, prizeId)
	return self._island_station_damage_prize[activityId] and self._island_station_damage_prize[activityId][prizeId]
end

function IslandStationConfig:getMasterCfg(creepMasterId)
	return self._island_station_master[creepMasterId]
end

function IslandStationConfig:getCreepsCfg(creepMasterId)
	return self._island_station_creeps[creepMasterId]
end

function IslandStationConfig:getSupportPetCfg(activityId)
	return self._island_station_supporpet[activityId]
end

function IslandStationConfig:getStoryGroupCfg(activityId)
	return self._island_station_story_group[activityId]
end

function IslandStationConfig:getWordsCfg(activityId)
	return self._island_station_bubble_words[activityId]
end

function IslandStationConfig:getWordsCfgByBubbleId(activityId, bubbleId)
	return self._island_station_bubble_words[activityId] and self._island_station_bubble_words[activityId][bubbleId]
end

function IslandStationConfig:getStoryCfgByGroupId(activityId, groupId)
	return self._island_station_story[activityId] and self._island_station_story[activityId][groupId]
end

function IslandStationConfig:getFindDifferenceCfg()
	return self._island_station_find_difference
end

function IslandStationConfig:getShopMaxLevel(shopLvPlanId)
	return #self._island_station_shop_level[shopLvPlanId]
end

function IslandStationConfig:getShelfNum(shopLvPlanId)
	local shopLevleCfg = self._island_station_shop_level[shopLvPlanId]
	local shopLevleCfgNum = #shopLevleCfg

	return shopLevleCfg[shopLevleCfgNum] and shopLevleCfg[shopLevleCfgNum].unlockPosCount
end

function IslandStationConfig:getGirlFoodCfg(activityId)
	local foodCfgs = self._island_station_food[activityId]
	local girlFoodList = {}

	for i, cfg in ipairs(foodCfgs) do
		if cfg.girlId ~= 0 then
			table.insert(girlFoodList, cfg)
		end
	end

	return girlFoodList
end

function IslandStationConfig:getShopLevel(activityId, shopId, profit)
	local shopCfg = self:getShopCfgByShopId(activityId, shopId)
	local shopLvPlanId = shopCfg.shopLvPlanId
	local shopLvCfgs = self:getShopLevelCfg(shopLvPlanId)
	local curLv = 1

	for i, cfg in ipairs(shopLvCfgs) do
		if profit >= cfg.progress then
			curLv = cfg.level
		end
	end

	return curLv
end

function IslandStationConfig:getNextUnlockShelfLevel(shopLvPlanId, pos)
	local shopLevelCfg = self:getShopLevelCfg(shopLvPlanId)

	for i, cfg in ipairs(shopLevelCfg) do
		if pos == cfg.unlockPosCount then
			return cfg.level
		end
	end

	return 1
end

function IslandStationConfig:getCreepMasterId(activityId)
	local actCfg = self._island_station_activity[activityId]

	return actCfg.bossId
end

function IslandStationConfig:getGirlNameList(activityId)
	local girlCfg = self:getGirlCfg(activityId)
	local girlNameList = {}

	for i, cfg in ipairs(girlCfg) do
		table.insert(girlNameList, cfg.girlName)
	end

	return girlNameList
end

function IslandStationConfig:getGirlFoodDic(activityId)
	local foodCfgs = self._island_station_food[activityId]
	local foodDic = {}

	for i, cfg in ipairs(foodCfgs) do
		if cfg.girlId > 0 then
			foodDic[cfg.girlId] = foodDic[cfg.girlId] or {}

			local curGirlFoodList = foodDic[cfg.girlId]

			table.insert(curGirlFoodList, cfg)
		end
	end

	return foodDic
end

function IslandStationConfig:getFoodNoGirlList(activityId)
	local foodList = {}
	local foodCfgs = self._island_station_food[activityId]

	for i, cfg in ipairs(foodCfgs) do
		if cfg.girlId == 0 then
			table.insert(foodList, cfg)
		end
	end

	return foodList
end

function IslandStationConfig:getFoodCookList(activityId, foodId)
	local cookData = self:getCookBookCfgByFoodId(activityId, foodId)
	local foodCookList = {}

	if cookData then
		for i, data in pairs(cookData) do
			local foodCookData = {}
			local needNum = data.stuffCount
			local foodStuffId = data.foodStuff
			local foodStuffData = self:getFoodStuffCfgById(activityId, foodStuffId)

			foodCookData.num = needNum
			foodCookData.materialStr = foodStuffData.materialStr

			table.insert(foodCookList, foodCookData)
		end
	end

	return foodCookList
end

function IslandStationConfig:getFoodCookDic(activityId, foodId)
	local cookData = self:getCookBookCfgByFoodId(activityId, foodId)
	local foodCookDic = {}

	for i, data in pairs(cookData) do
		foodCookDic[data.foodStuff] = data.stuffCount
	end

	return foodCookDic
end

function IslandStationConfig:getBossId(activityId)
	local actCfg = self:getActCfg(activityId)

	return actCfg and actCfg.bossId
end

function IslandStationConfig:getCookFoodStuffDic(activityId, foodId)
	return self._island_station_cook_book[activityId] and self._island_station_cook_book[activityId][foodId]
end

function IslandStationConfig:isCommonFood(activityId, foodId)
	local foodCfg = self:getFoodCfgByFoodId(activityId, foodId)

	return foodCfg.girlId == 0
end

function IslandStationConfig:getGirlShopAreaNum(activityId, shopId)
	local minId = 1
	local maxId = 1

	if self._girlCfgDic[activityId] then
		if self._girlCfgDic[activityId] then
			minId = self._girlCfgDic[activityId][1].girlId
			maxId = self._girlCfgDic[activityId][1].girlId

			for i, cfg in ipairs(self._girlCfgDic[activityId]) do
				if minId >= cfg.girlId then
					minId = cfg.girlId
				end

				if maxId <= cfg.girlId then
					maxId = cfg.girlId
				end
			end
		end

		return minId, maxId
	end
end

function IslandStationConfig:getDialoguePlanId(activityId, girlId)
	local girlCfg = self:getGirlCfgByGirlId(activityId, girlId)

	return girlCfg.dialoguePlanId
end

function IslandStationConfig:getDialogueCfgs(dialoguePlanId)
	return self._island_station_dialogue[dialoguePlanId]
end

function IslandStationConfig:getDialogueCfg(dialoguePlanId, dialogueId)
	if self._island_station_dialogue[dialoguePlanId] then
		return self._island_station_dialogue[dialoguePlanId][dialogueId]
	end
end

function IslandStationConfig:getDialogueData(dialoguePlanId, dialogueId, id)
	if self._island_station_dialogue[dialoguePlanId] and self._island_station_dialogue[dialoguePlanId][dialogueId] then
		return self._island_station_dialogue[dialoguePlanId][dialogueId][id]
	end
end

function IslandStationConfig:getStoryGroupIdByGirlId(activityId, girlId)
	local groupCfgs = self._island_station_story_group[activityId]

	for i, cfg in ipairs(groupCfgs) do
		if checknumber(cfg.girlId) == girlId then
			return cfg.groupId
		end
	end
end

function IslandStationConfig:getStoryCfgsByGroupId(activityId, groupId)
	return self._island_station_story[activityId] and self._island_station_story[activityId][groupId]
end

function IslandStationConfig:getStoryCfgsByGirlId(activityId, girlId)
	local groupId = self:getStoryGroupIdByGirlId(activityId, girlId)

	return self._island_station_story[activityId] and self._island_station_story[activityId][groupId]
end

function IslandStationConfig:getGirlIdByGroupId(activityId, groupId)
	if self._island_station_story_group[activityId] then
		return self._island_station_story_group[activityId].girlId
	end
end

IslandStationConfig.instance = IslandStationConfig.New()

return IslandStationConfig
