-- chunkname: @modules/logic/room/model/record/RoomTradeTaskModel.lua

module("modules.logic.room.model.record.RoomTradeTaskModel", package.seeall)

local RoomTradeTaskModel = class("RoomTradeTaskModel", BaseModel)

function RoomTradeTaskModel:onGetTradeTaskInfo(msg)
	self:onRefeshTaskMo(msg.infos)

	self.hasGetSupportBonus = msg.hasGetSupportBonus or {}
	self.canGetExtraBonus = msg.canGetExtraBonus

	RoomTradeController.instance:dispatchEvent(RoomTradeEvent.OnGetTradeTaskInfo)
end

function RoomTradeTaskModel:onRefeshTaskMo(infos)
	self._taskMos = self._taskMos or {}

	for i = 1, #infos do
		local info = infos[i]
		local id = info.id
		local co = RoomTradeConfig.instance:getTaskCoById(id)

		if co then
			local level = co.tradeLevel
			local mos = self._taskMos[level]

			if not mos then
				mos = {}
				self._taskMos[level] = mos
			end

			mos[id] = mos[id] or RoomTradeTaskMo.New()

			mos[id]:initMo(info, co)
		end
	end
end

function RoomTradeTaskModel:onReadNewTradeTask(ids)
	for i, id in ipairs(ids) do
		local mo = self:getTaskMo(id)

		mo:setNew(false)
	end

	RoomTradeController.instance:dispatchEvent(RoomTradeEvent.OnReadNewTradeTaskReply)
end

function RoomTradeTaskModel:getTaskMaxLevel()
	return RoomTradeConfig.instance:getTaskMaxLevel()
end

function RoomTradeTaskModel:getLevelTaskMo(level)
	local moList = {}

	if self._taskMos then
		if level then
			if self._taskMos[level] then
				for _, mo in pairs(self._taskMos[level]) do
					if mo:isNormalTask() then
						table.insert(moList, mo)
					end
				end
			end
		else
			for _, mos in pairs(self._taskMos) do
				if mos then
					for _, mo in pairs(mos) do
						if mo:isNormalTask() then
							table.insert(moList, mo)
						end
					end
				end
			end
		end
	end

	return moList
end

function RoomTradeTaskModel:getTaskMo(id)
	for _, mos in pairs(self._taskMos) do
		for _, mo in pairs(mos) do
			if mo.id == id then
				return mo
			end
		end
	end
end

function RoomTradeTaskModel:getFinishLevelTaskCount(level)
	local moList = self:getLevelTaskMo(level)

	if not moList then
		return 0
	end

	local count = 0

	for _, mo in pairs(moList) do
		if mo.hasFinish then
			count = count + 1
		end
	end

	return count
end

function RoomTradeTaskModel:getTaskReward()
	return self.hasGetSupportBonus
end

function RoomTradeTaskModel:getOpenSupportLevel()
	return (ManufactureConfig.instance:getUnlockSystemTradeLevel(RoomTradeEnum.LevelUnlock.LevelBonus))
end

function RoomTradeTaskModel:getOpenOrderLevel()
	return (ManufactureConfig.instance:getUnlockSystemTradeLevel(RoomTradeEnum.LevelUnlock.Order))
end

function RoomTradeTaskModel:getOpenCritterIncubateLevel()
	return (ManufactureConfig.instance:getUnlockSystemTradeLevel(RoomTradeEnum.LevelUnlock.CritterIncubate))
end

function RoomTradeTaskModel:getOpenBuildingLevelUpLevel()
	return (ManufactureConfig.instance:getUnlockSystemTradeLevel(RoomTradeEnum.LevelUnlock.BuildingLevelUp))
end

function RoomTradeTaskModel:onGetLevelBonus(id)
	if not LuaUtil.tableContains(self.hasGetSupportBonus, id) then
		table.insert(self.hasGetSupportBonus, id)
	end
end

function RoomTradeTaskModel:isCanLevelBonus(id)
	local isGot = LuaUtil.tableContains(self.hasGetSupportBonus, id)
	local finishCount = self:getTaskFinishPointCount()
	local co = RoomTradeConfig.instance:getSupportBonusById(id)
	local needTask = co.needTask

	return needTask <= finishCount, isGot
end

function RoomTradeTaskModel:getAllTaskRewards()
	local coList = RoomTradeConfig.instance:getSupportBonusConfig()
	local reward = {}

	if coList then
		for _, co in ipairs(coList) do
			local bonus = co.bonus

			reward[co.id] = GameUtil.splitString2(bonus, true, "|", "#")
		end
	end

	return reward
end

function RoomTradeTaskModel:getTaskPointMaxCount()
	local coList = RoomTradeConfig.instance:getSupportBonusConfig()
	local count = 0
	local page = 0

	if coList then
		for _, co in ipairs(coList) do
			count = math.max(count, co.needTask)
			page = page + 1
		end
	end

	return count, page
end

function RoomTradeTaskModel:getTaskFinishPointCount(level)
	local ids = RoomTradeTaskListModel.instance:getFinishOrNotTaskIds(level, true)

	return #ids
end

function RoomTradeTaskModel:isCanLevelUp()
	local maxLevel = RoomTradeConfig.instance:getMaxLevel()
	local level = ManufactureModel.instance:getTradeLevel()

	if maxLevel <= level then
		return false, level, true
	end

	local curFinishTaskCount, needTaskCount = self:getLevelTaskCount(level)

	return needTaskCount <= curFinishTaskCount, level, false
end

function RoomTradeTaskModel:getLevelTaskCount(level)
	local curFinishTaskCount = self:getFinishLevelTaskCount(level)
	local bounsCo = RoomTradeConfig.instance:getLevelCo(level + 1)

	if bounsCo then
		if not bounsCo.levelUpNeedTask then
			local needTaskCount = 0

			return curFinishTaskCount, needTaskCount
		end
	end
end

function RoomTradeTaskModel:getLevelUnlock(level)
	local unlockList = {}

	if level < 2 then
		return unlockList
	end

	local levelUnlockInfo = ManufactureConfig.instance:getAllLevelUnlockInfo(level)

	if levelUnlockInfo then
		local newBuilding = levelUnlockInfo[RoomTradeEnum.LevelUnlock.NewBuilding]

		if newBuilding then
			for i, buildingId in ipairs(newBuilding) do
				local mo = {
					type = RoomTradeEnum.LevelUnlock.NewBuilding,
					buildingId = buildingId
				}

				table.insert(unlockList, mo)
			end
		end

		local buildingMaxLevel = levelUnlockInfo[RoomTradeEnum.LevelUnlock.BuildingMaxLevel]

		if buildingMaxLevel then
			for _, info in ipairs(buildingMaxLevel) do
				local groupId = info.groupId
				local buildingIds = ManufactureConfig.instance:getBuildingIdsByGroup(groupId)

				for _, buildingId in ipairs(buildingIds) do
					local mo = {
						type = RoomTradeEnum.LevelUnlock.BuildingMaxLevel,
						buildingId = buildingId,
						num = {
							last = info.Level - 1,
							cur = info.Level
						}
					}

					table.insert(unlockList, mo)
				end
			end
		end
	end

	local tradeLevelCo = RoomTradeConfig.instance:getLevelCo(level)
	local preTradeLevelCo = RoomTradeConfig.instance:getLevelCo(level - 1)

	if tradeLevelCo then
		if not string.nilorempty(tradeLevelCo.bonus) then
			local split = string.split(tradeLevelCo.bonus, "|")

			for i, v in ipairs(split) do
				local mo = {
					type = RoomTradeEnum.LevelUnlock.GetBouns,
					bouns = v
				}

				table.insert(unlockList, mo)
			end
		end

		if preTradeLevelCo then
			if tradeLevelCo.maxTrainSlotCount > preTradeLevelCo.maxTrainSlotCount then
				local mo = {
					type = RoomTradeEnum.LevelUnlock.TrainSlotCount,
					num = {
						last = preTradeLevelCo.maxTrainSlotCount,
						cur = tradeLevelCo.maxTrainSlotCount
					}
				}

				table.insert(unlockList, mo)
			end

			if tradeLevelCo.addBlockMax > preTradeLevelCo.addBlockMax then
				local mo = {
					type = RoomTradeEnum.LevelUnlock.BlockMax,
					num = {
						last = preTradeLevelCo.addBlockMax,
						cur = tradeLevelCo.addBlockMax
					}
				}

				table.insert(unlockList, mo)
			end

			if tradeLevelCo.trainsRoundCount > preTradeLevelCo.trainsRoundCount then
				local mo = {
					type = RoomTradeEnum.LevelUnlock.TrainsRoundCount
				}

				table.insert(unlockList, mo)
			end

			local trainsBuildings = ManufactureConfig.instance:getTrainsBuildingCos()
			local minLevel

			for _, co in ipairs(trainsBuildings) do
				minLevel = minLevel and math.min(minLevel, co.placeTradeLevel) or co.placeTradeLevel
			end

			if level == minLevel then
				local mo = {
					type = RoomTradeEnum.LevelUnlock.TransportSystemOpen
				}

				table.insert(unlockList, mo)
			end
		end
	end

	if level == self:getOpenSupportLevel() then
		local mo = {
			type = RoomTradeEnum.LevelUnlock.LevelBonus
		}

		table.insert(unlockList, mo)
	end

	if level == self:getOpenOrderLevel() then
		local mo = {
			type = RoomTradeEnum.LevelUnlock.Order
		}

		table.insert(unlockList, mo)
	end

	if level == self:getOpenCritterIncubateLevel() then
		local mo = {
			type = RoomTradeEnum.LevelUnlock.CritterIncubate
		}

		table.insert(unlockList, mo)
	end

	if level == self:getOpenBuildingLevelUpLevel() then
		local mo = {
			type = RoomTradeEnum.LevelUnlock.BuildingLevelUp
		}

		table.insert(unlockList, mo)
	end

	table.sort(unlockList, self.sortLevelUnlock)

	return unlockList
end

function RoomTradeTaskModel.sortLevelUnlock(a, b)
	if a.type == b.type then
		return
	end

	local a_co = RoomTradeConfig.instance:getLevelUnlockCo(a.type)
	local b_co = RoomTradeConfig.instance:getLevelUnlockCo(b.type)

	if a_co and b_co then
		return a_co.sort < b_co.sort
	end

	return a.type < b.type
end

function RoomTradeTaskModel:getBuildingTaskIcon(buildingId)
	local co = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Building, buildingId)

	return co and ResUrl.getRoomCritterIcon(co.icon)
end

function RoomTradeTaskModel:getCanGetExtraBonus()
	return self.canGetExtraBonus
end

function RoomTradeTaskModel:setCanGetExtraBonus()
	self.canGetExtraBonus = false
end

RoomTradeTaskModel.instance = RoomTradeTaskModel.New()

return RoomTradeTaskModel
