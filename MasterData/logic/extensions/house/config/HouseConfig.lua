-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/config/HouseConfig.lua

module("logic.extensions.house.config.HouseConfig", package.seeall)

local M = class("HouseConfig", BaseConfig)

function M:onInit()
	self._dictPerformCO = {}
	self._dictFurnPerformCO = {}
	self._dictFurnId2Performs = {}
	self._dictHeroLivingRoomWeight = {}
	self._dictRoomUnlockLv = nil
end

function M:getNames()
	return {
		ConfigName.HouseZone,
		ConfigName.HouseRoom,
		ConfigName.HouseWorker,
		ConfigName.HouseConst,
		ConfigName.Elevator,
		ConfigName.HouseRingCameraParam,
		ConfigName.HouseCard,
		ConfigName.HouseFood,
		ConfigName.HousePerform,
		ConfigName.HouseSkill,
		ConfigName.HouseBuff,
		ConfigName.HouseLevel,
		ConfigName.HouseTask,
		ConfigName.HouseTaskLabel,
		ConfigName.HouseThoughtEdu,
		ConfigName.FurniturePerform,
		ConfigName.HouseWord,
		ConfigName.HouseLivingFacilitiesMark,
		ConfigName.WorkPoints
	}
end

function M:handleConfig(name, content)
	M.super.handleConfig(self, name, content)

	if name == ConfigName.HousePerform then
		self:_createPerformCO()
	elseif name == ConfigName.FurniturePerform then
		self:_createFurniturePerformCO()
	elseif name == ConfigName.HouseCard then
		self:_initHeroLivingRoomWeight()
	end
end

function M:getConfig(cfgName)
	return self._dict[cfgName]
end

function M:getConfigList(cfgName)
	local cfg = self._dict[cfgName]

	return cfg.dataList
end

function M:getConfigByKey(cfgName, key)
	local cfg = self:getConfig(cfgName)

	if cfg then
		return cfg[key]
	end

	printError(string.format("no config with name: t_%s", cfgName))
end

function M:getElevatorCoById(id)
	local cfg = self:getConfig(ConfigName.Elevator)

	if cfg and cfg[id] then
		return cfg[id]
	end

	printError(string.format("找不到电梯id配置: %s", id))
end

function M:getRoomCOByType(roomType, subRoomType)
	local cfg = self:getConfig(ConfigName.HouseRoom)

	if cfg and cfg[roomType] then
		return cfg[roomType][subRoomType]
	end
end

function M.getPatrolPoints(key)
	local t = require("logic.config.t_house_patrol_points")

	if not t or type(t) ~= "table" then
		printError("require t_house_patrol_points.lua failed")

		return
	end

	return t[key] or {}
end

function M:getHouseConst(key)
	local data = self:getConfig(ConfigName.HouseConst)

	return data[key]
end

function M:getRandomFood(heroId, withDesk)
	local CO = self:getConfigByKey(ConfigName.HouseCard, heroId)

	if CO then
		local foodListStr = withDesk and CO.foodWithDesk or CO.foodWithoutDesk
		local foods = string.split(foodListStr, "|")
		local totalWeight = 0

		for idx, foodStr in ipairs(foods) do
			local food = string.split(foodStr, "#")

			totalWeight = totalWeight + tonumber(food[2])
		end

		local randomNum = math.random(1, totalWeight)
		local calculWeight = 0

		for idx, foodStr in ipairs(foods) do
			local food = string.split(foodStr, "#")

			calculWeight = calculWeight + tonumber(food[2])

			if randomNum <= calculWeight then
				return tonumber(food[1])
			end
		end
	end

	printWarn("没找到小屋角色配置，用默认的食物id，角色code：", heroId)

	return 1
end

function M:_createPerformCO()
	self._dictPerformCO = {}

	local function _addPerformCO(cfg, isDefault)
		local CO = HousePerformCO.New(cfg)

		self._dictPerformCO[cfg.id] = CO

		CO:setDefault(isDefault)
	end

	local cfgList = self:getConfigList(ConfigName.HousePerform)

	for _, cfg in ipairs(cfgList) do
		_addPerformCO(cfg, false)
	end

	local defaultSingleCfg = {
		performList = "",
		weight = 1,
		interrupt = 1,
		breakConditions = "",
		breakPerformList = "",
		breakTextList = "",
		heroIds = "",
		statusCondition = "",
		peopleNum = 1,
		textList = "",
		id = HouseEnum.DEFAULT_SINGLE_PERFORM_ID
	}
	local defaultDoubleCfg = {
		performList = "",
		weight = 1,
		interrupt = 1,
		breakConditions = "",
		breakPerformList = "",
		breakTextList = "",
		heroIds = "",
		statusCondition = "",
		peopleNum = 2,
		textList = "",
		id = HouseEnum.DEFAULT_DOUBLE_PERFORM_ID
	}

	_addPerformCO(defaultSingleCfg, true)
	_addPerformCO(defaultDoubleCfg, true)
end

function M:getPerformCODict()
	return self._dictPerformCO
end

function M:getPerformCO(id)
	local CO = self._dictPerformCO[id]

	if CO then
		return CO
	end

	printWarn("没有表演配置，id：", id)
end

function M:_createFurniturePerformCO()
	self._dictFurnPerformCO = {}

	local cfgList = self:getConfigList(ConfigName.FurniturePerform)

	for _, cfg in ipairs(cfgList) do
		local CO = FurniturePerformCO.New(cfg)

		self._dictFurnPerformCO[cfg.id] = CO

		local furnitureId = cfg.furnitureId

		if self._dictFurnId2Performs[furnitureId] == nil then
			self._dictFurnId2Performs[furnitureId] = {}
		end

		table.insert(self._dictFurnId2Performs[furnitureId], CO)
	end
end

function M:getFurnPerformCOs(furnitureId)
	return self._dictFurnId2Performs[furnitureId] or {}
end

function M:getFurnPerformCO(performId)
	return self._dictFurnPerformCO[performId]
end

function M:_initHeroLivingRoomWeight()
	local cfgList = self:getConfigList(ConfigName.HouseCard)

	for _, cfg in ipairs(cfgList) do
		if not string.nilorempty(cfg.LivingRoomWeight) then
			local weights = {}

			self._dictHeroLivingRoomWeight[cfg.id] = weights

			local strlist = string.split(cfg.LivingRoomWeight, "|")

			for _, weightStr in ipairs(strlist) do
				local weightList = string.split(weightStr, "#")

				weights[tonumber(weightList[1])] = tonumber(weightList[2])
			end
		end
	end
end

function M:getHeroLivingRoomWeight(heroId, livingRoomType)
	local weight
	local weights = self._dictHeroLivingRoomWeight[heroId]

	if weights then
		weight = weights[livingRoomType]
	end

	return weight or self:getDefaultLivingRoomWeight()
end

function M:getWordCfgsByStatus(status)
	local cfgList = self:getConfigList(ConfigName.HouseWord)
	local list = {}

	for _, cfg in ipairs(cfgList) do
		if cfg.status == status then
			table.insert(list, cfg)
		end
	end

	return list
end

function M:getRoomUnlockLv(roomId)
	if not self._dictRoomUnlockLv then
		self:_setRoomUnlockLv()
	end

	return checknumber(self._dictRoomUnlockLv[roomId])
end

function M:_setRoomUnlockLv()
	self._dictRoomUnlockLv = {}

	local function _getRoomType(id)
		local cfg = self:getConfigByKey(ConfigName.HouseZone, id)

		return cfg.roomType, cfg.size
	end

	local function _getUnlockLv(unlockIdx, targetRoomType, targetRoomSize)
		local cfgList = SupervisorConfig.instance:getConfigList(ConfigName.HouseManager)

		for _, cfg in ipairs(cfgList) do
			local unlockCount = cfg.holdRoomCount

			if targetRoomType == HouseEnum.RoomType.Living then
				unlockCount = cfg.bigZoneCount

				if targetRoomSize == HouseEnum.RoomSize.Small then
					unlockCount = cfg.smallZoneCount
				end
			end

			if unlockIdx <= unlockCount then
				return cfg.level
			end
		end

		return 0
	end

	local shelterUnlockIdx = 0
	local smallRoomUnlockIdx = 0
	local bigRoomUnlockIdx = 0

	for _, id in ipairs(SupervisorConfig.instance:getZoneUnlockOrder()) do
		local roomType, roomSize = _getRoomType(id)

		if roomType == HouseEnum.RoomType.Shelter then
			shelterUnlockIdx = shelterUnlockIdx + 1
			self._dictRoomUnlockLv[id] = _getUnlockLv(shelterUnlockIdx, roomType, roomSize)
		elseif roomType == HouseEnum.RoomType.Living then
			if roomSize == HouseEnum.RoomSize.Small then
				smallRoomUnlockIdx = smallRoomUnlockIdx + 1
				self._dictRoomUnlockLv[id] = _getUnlockLv(smallRoomUnlockIdx, roomType, roomSize)
			else
				bigRoomUnlockIdx = bigRoomUnlockIdx + 1
				self._dictRoomUnlockLv[id] = _getUnlockLv(bigRoomUnlockIdx, roomType, roomSize)
			end
		end
	end
end

function M:getDefaultMoodCost()
	local cfg = self:getConfigByKey(ConfigName.HouseConst, "DefaultMoodCost")

	return cfg.floatValue
end

function M:getSpRoomTotalStore()
	local cfg = self:getConfigByKey(ConfigName.HouseConst, "SpRoomStore")

	return cfg.numValue
end

function M:getSpRoomProductivityNeed(quality)
	local cfg = self:getConfigByKey(ConfigName.HouseConst, "SpRoomProductivityNeed")
	local productStr = string.sub(cfg.strValue, 2, -2)
	local productArr = string.split(productStr, ",")

	for _, product in ipairs(productArr) do
		local arr = string.split(product, ":")

		if tonumber(arr[1]) == quality then
			return tonumber(arr[2])
		end
	end

	printError("特供单人房生产力需求缺少配置，品质：", quality)
end

function M:getSpRoomProductivitySpeed()
	local cfg = self:getConfigByKey(ConfigName.HouseConst, "SpRoomProductivitySpeed")

	return cfg.numValue
end

function M:getChairIdsForLunch()
	local cfg = self:getConfigByKey(ConfigName.HouseConst, "ChairIdsForLunch")

	return cfg.numValues
end

function M:getHousePerformWeight()
	local cfg = self:getConfigByKey(ConfigName.HouseConst, "HousePerformWeight")

	return cfg.numValues
end

function M:getDefaultLivingRoomWeight()
	local cfg = self:getConfigByKey(ConfigName.HouseConst, "DefaultLivingRoomWeight")

	return cfg.numValue
end

function M:getTradingBehaviorWeights()
	local cfg = self:getConfigByKey(ConfigName.HouseConst, "TradingBehaviorWeight")

	return cfg.numValues
end

function M:getShelterBehaviorWeights()
	local cfg = self:getConfigByKey(ConfigName.HouseConst, "ShelterBehaviorWeight")

	return cfg.numValues
end

function M:getEatBehaviorWeights()
	local cfg = self:getConfigByKey(ConfigName.HouseConst, "EatBehaviorWeight")

	return cfg.numValues
end

function M:getSleepBehaviorWeights()
	local cfg = self:getConfigByKey(ConfigName.HouseConst, "SleepBehaviorWeight")

	return cfg.numValues
end

function M:getWordWeights()
	local cfg = self:getConfigByKey(ConfigName.HouseConst, "WordWeight")

	return cfg.numValues
end

function M:getMinScheduleHours(status)
	local cfg = self:getConfigByKey(ConfigName.HouseConst, "MinScheduleHours")

	if status == HouseEnum.WorkStatus.Eat then
		return cfg.numValues[1]
	elseif status == HouseEnum.WorkStatus.Sleep then
		return cfg.numValues[2]
	elseif status == HouseEnum.WorkStatus.Rest then
		return cfg.numValues[3]
	end

	return 0
end

function M:getDragPlayerDuration()
	local cfg = self:getConfigByKey(ConfigName.HouseConst, "DragPlayerDuration")

	return cfg.floatValue
end

function M:getLivingFacilitiesGenderMarkCO(gender)
	local cfg = self:getConfig(ConfigName.HouseLivingFacilitiesMark)

	for _, co in pairs(cfg) do
		if co.markType == HouseEnum.LivingFacilitiesMark.GenderMark and co.condition == gender then
			return co
		end
	end
end

function M:getLivingFacilitiesCampMarkCO(camp)
	local cfg = self:getConfig(ConfigName.HouseLivingFacilitiesMark)

	for _, co in pairs(cfg) do
		if co.markType == HouseEnum.LivingFacilitiesMark.CampMark and co.condition == camp then
			return co
		end
	end
end

M.instance = M.New()

return M
