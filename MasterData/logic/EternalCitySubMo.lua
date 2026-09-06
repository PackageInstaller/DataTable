-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalcity/data/EternalCitySubMo.lua

module("logic.extensions.eternalcity.data.EternalCitySubMo", package.seeall)

local EternalCitySubMo = class("EternalCitySubMo")

function EternalCitySubMo:ctor(activityId)
	self._activityId = activityId

	local actData = EternalCityConfig.instance:getActivityData(activityId)

	self._buildBuyCostMats = {}
	self._buildSalePriceMats = {}

	local datass = EternalCityConfig.instance:getBuildingDatass(self._activityId) or {}

	for buildingId, datas in ipairs(datass) do
		local data = datas[1]

		if not string.nilorempty(data.buyCost) then
			self._buildBuyCostMats[data.buildingId] = self:_getMatMo(data.buyCost)
		end
	end

	for buildingId, datas in ipairs(datass) do
		self._buildSalePriceMats[buildingId] = {}

		for level, data in ipairs(datas) do
			if not string.nilorempty(data.salePrice) then
				self._buildSalePriceMats[buildingId][level] = self:_getMatMo(data.salePrice)
			end
		end
	end

	self._petRecruitCostMats = {}

	local petPoolDatass = EternalCityConfig.instance:getPetPoolDatass(activityId)

	if petPoolDatass then
		for poolId, datas in ipairs(petPoolDatass) do
			self._petRecruitCostMats[poolId] = {}

			for _, data in pairs(datas) do
				if not string.nilorempty(data.buyCost) then
					self._petRecruitCostMats[poolId][data.creepsId] = self:_getMatMo(data.buyCost)
				end
			end
		end
	end

	self._prosperityRewardMats = {}

	local prosperityDatas = EternalCityConfig.instance:getProsperityDatas(activityId)

	if prosperityDatas then
		for _, data in pairs(prosperityDatas) do
			self._prosperityRewardMats[data.prosperity] = self:_getMatMo(data.reward)
		end
	end

	self._supportPetMos = {}

	local fmo = FightingPowerPetMo.New()
	local supportPetDatas = EternalCityConfig.instance:getSupportPetDatas(activityId)

	if supportPetDatas then
		for k, data in pairs(supportPetDatas) do
			fmo:fromChallengeCreepCo(data)

			local petMo = fmo:toBaseBagPetMo()

			petMo:setSupportedPet(true)

			self._supportPetMos[data.creepsId] = petMo
		end
	end

	self._refreshPoolCostMat = actData and self:_getMatMo(actData.refreshPoolCost)

	if actData then
		self._dailyRecruitTimes = actData.dailyRecruitTimes or 0
	end

	if actData then
		self._bossClgStoreTimesLimit = actData.bossClgStoreTimesLimit or 0
	end

	if actData then
		self._refreshBossClgTime = actData.refreshBossClgTime or 0
	end

	self._maxBuildCount = EternalCityConfig.instance:getCommonValue("MAX_HOLD_BUILDING", true)
	self._mapCol = EternalCityConfig.instance:getCommonValue("MAP_LENGTH", true)
	self._mapRow = EternalCityConfig.instance:getCommonValue("MAP_WIDTH", true)
	self._gainProfitInterval = EternalCityConfig.instance:getCommonValue("MIN_GAIN_PROFIT_TIME", true)

	self:_resetData()
end

function EternalCitySubMo:_resetData()
	self._lastGainProfitTime = 0
	self._prosperity = 0
	self._maxPassStageId = 0
	self._remainBossClgTimes = 0
	self._lastRefreshBossClgTimesTime = 0
	self._historyMaxProsperity = 0
	self._todayRecruitTimes = 0
	self._creepsInfos = {}
	self._buildingNums = {}
	self._placePositionInfos = {}
	self._creepsNumInPlace = {}
	self._poolInfos = {}
	self._stageClgResultMsg = nil
	self._bossClgResultMsg = nil
end

function EternalCitySubMo:dispose()
	self._activityId = nil

	self:_resetData()
end

function EternalCitySubMo:handlePM_EternalCityInfoRes(msg)
	self._lastGainProfitTime = msg.lastGainProfitTime
	self._prosperity = msg.prosperity
	self._maxPassStageId = msg.maxPassStageId
	self._remainBossClgTimes = msg.remainBossClgTimes
	self._lastRefreshBossClgTimesTime = msg.lastRefreshBossClgTimesTime
	self._historyMaxProsperity = msg.historyMaxProsperity
	self._todayRecruitTimes = msg.todayRecruitTimes

	table.clear(self._creepsInfos)

	for _, creepsInfo in ipairs(msg.creepsInfos) do
		self._creepsInfos[creepsInfo.creepsId] = creepsInfo
	end

	table.clear(self._buildingNums)

	for _, v in ipairs(msg.buildingInfos) do
		local buildingId = v.buildingId

		self._buildingNums = MmUtil.checkTable(self._buildingNums, buildingId)
		self._buildingNums[buildingId][v.level] = v.num
	end

	table.clear(self._poolInfos)

	for _, poolInfo in ipairs(msg.poolInfos) do
		self._poolInfos[poolInfo.poolId] = poolInfo
	end

	self._placePositionInfos = {}
	self._creepsNumInPlace = {}

	for _, v in ipairs(msg.placePositionInfos) do
		local info = {}

		info.position = v.position
		info.petIds = {}

		table.insertto(info.petIds, v.petIds)

		info.buildingId = v.buildingId
		info.level = v.level

		table.insert(self._placePositionInfos, info)

		for _, petId in ipairs(info.petIds) do
			self._creepsNumInPlace[petId] = (self._creepsNumInPlace[petId] or 0) + 1
		end
	end
end

function EternalCitySubMo:handlePM_EternalCityRecruitRes(msg)
	local poolInfo = self._poolInfos[msg.poolId]

	if poolInfo then
		poolInfo.isLock = false
		poolInfo.petId = msg.refreshPetId
		poolInfo.hasRefreshTimes = msg.hasRefreshTimes
	end

	local creepsInfo = self._creepsInfos[msg.petId]

	if creepsInfo then
		creepsInfo.num = creepsInfo.num + 1
	else
		local newInfo = {}

		newInfo.creepsId = msg.petId
		newInfo.num = 1
		self._creepsInfos[msg.petId] = newInfo
	end

	self._historyMaxProsperity = msg.historyMaxProsperity
	self._todayRecruitTimes = self._todayRecruitTimes + 1
end

function EternalCitySubMo:handlePM_EternalCityRefreshPoolRes(msg)
	table.clear(self._poolInfos)

	for _, poolInfo in ipairs(msg.poolInfos) do
		self._poolInfos[poolInfo.poolId] = poolInfo
	end
end

function EternalCitySubMo:handlePM_EternalCityBuyBuildingRes(msg)
	local buildingId = msg.buildingId

	self._buildingNums[buildingId] = self._buildingNums[buildingId] or {}
	self._buildingNums[buildingId][1] = (self._buildingNums[buildingId][1] or 0) + msg.num
end

function EternalCitySubMo:handlePM_EternalCitySaleBuildingRes(msg)
	local buildingId = msg.buildingId

	self._buildingNums[buildingId] = self._buildingNums[buildingId] or {}
	self._buildingNums[buildingId][msg.level] = Mathf.Max(0, (self._buildingNums[buildingId][msg.level] or 0) - msg.num)
end

function EternalCitySubMo:handlePM_EternalCityCraftBuildingRes(msg)
	local buildingId = msg.buildingId
	local craftLevel = msg.craftLevel
	local lastLevel = craftLevel - 1

	self._buildingNums[buildingId] = self._buildingNums[buildingId] or {}
	self._buildingNums[buildingId][lastLevel] = Mathf.Max(0, (self._buildingNums[buildingId][lastLevel] or 0) - 2)
	self._buildingNums[buildingId] = self._buildingNums[buildingId] or {}
	self._buildingNums[buildingId][craftLevel] = (self._buildingNums[buildingId][craftLevel] or 0) + 1

	if msg:HasField("oldPosition") then
		local oldX, oldY = msg.oldPosition.left, msg.oldPosition.right
		local key

		for k, v in ipairs(self._placePositionInfos) do
			if v.position.left == oldX and v.position.right == oldY then
				key = k

				break
			end
		end

		if key then
			table.remove(self._placePositionInfos, key)
		end
	end

	if msg:HasField("newPosition") then
		local newX, newY = msg.newPosition.left, msg.newPosition.right
		local placePositionInfo = self:getPlacePositionInfoByPos(newX, newY)

		if placePositionInfo then
			placePositionInfo.buildingId = buildingId
			placePositionInfo.level = craftLevel
		else
			local info = {}

			info.position = msg.newPosition
			info.buildingId = buildingId
			info.level = craftLevel
			info.petIds = {}

			table.insert(self._placePositionInfos, info)
		end
	end
end

function EternalCitySubMo:handlePM_EternalCityPlaceBuildingRes(msg)
	self._historyMaxProsperity = msg.historyMaxProsperity

	local x, y = msg.position.left, msg.position.right
	local info = {}

	info.position = msg.position
	info.buildingId = msg.buildingId
	info.level = msg.level
	info.petIds = {}

	table.insert(self._placePositionInfos, info)
end

function EternalCitySubMo:handlePM_EternalCityUnequipBuildingRes(msg)
	local x, y = msg.position.left, msg.position.right
	local key

	for k, v in ipairs(self._placePositionInfos) do
		if v.position.left == x and v.position.right == y then
			key = k

			break
		end
	end

	if key then
		table.remove(self._placePositionInfos, key)
	end
end

function EternalCitySubMo:handlePM_EternalCityMoveBuildingRes(msg)
	local oldX, oldY = msg.oldPosition.left, msg.oldPosition.right
	local newX, newY = msg.newPosition.left, msg.newPosition.right
	local placePositionInfo = self:getPlacePositionInfoByPos(oldX, oldY)

	if placePositionInfo then
		placePositionInfo.position = msg.newPosition
	end
end

function EternalCitySubMo:handlePM_EternalCityOperaPetRes(msg)
	local buildingId = msg.buildingId
	local level = msg.level
	local x, y = msg.position.left, msg.position.right
	local petIds = msg.petId
	local placePositionInfo = self:getPlacePositionInfoByPos(x, y)

	if placePositionInfo then
		table.clear(placePositionInfo.petIds)
		table.insertto(placePositionInfo.petIds, petIds)
	else
		local info = {}

		info.position = msg.position
		info.petIds = {}

		table.insertto(info.petIds, petIds)

		info.buildingId = buildingId
		info.level = level

		table.insert(self._placePositionInfos, info)
	end

	self._creepsNumInPlace = {}

	for _, info in ipairs(self._placePositionInfos) do
		for _, petId in ipairs(info.petIds) do
			self._creepsNumInPlace[petId] = (self._creepsNumInPlace[petId] or 0) + 1
		end
	end
end

function EternalCitySubMo:handlePM_EternalCityGainProfitRes(msg)
	self._lastGainProfitTime = msg.lastGainProfitTime
end

function EternalCitySubMo:handlePM_EternalCityRankViewRes(msg)
	return
end

function EternalCitySubMo:handlePM_EternalCityNotifyStageClgRes(msg)
	self._stageClgResultMsg = msg

	if msg.isWin then
		self._maxPassStageId = Mathf.Max(msg.stageId, self._maxPassStageId)
	end
end

function EternalCitySubMo:handlePM_EternalCityNotifyBossClgRes(msg)
	self._bossClgResultMsg = msg
	self._remainBossClgTimes = Mathf.Max(0, self._remainBossClgTimes - 1)
end

function EternalCitySubMo:handlePM_EternalCityNotifyProsperityChangeRes(msg)
	self._lastGainProfitTime = msg.lastGainProfitTime
	self._historyMaxProsperity = msg.historyMaxProsperity
end

function EternalCitySubMo:handlePM_EternalCityOperaPoolRes(msg)
	local poolInfo = self._poolInfos[msg.poolId]

	if poolInfo then
		poolInfo.isLock = msg.operaType == EternalCityEnum.PoolOperationType_Lock
	end
end

function EternalCitySubMo:_getMatMo(matStr)
	local mo

	if not string.nilorempty(matStr) then
		local matType, matId, matNum = MaterialMgr.getMatParams(matStr)
		local matName = MaterialMgr.getMaterialsName(matType, matId)

		mo = {
			matStr = matStr,
			matType = matType,
			matId = matId,
			matNum = matNum,
			matName = matName
		}
	end

	return mo
end

function EternalCitySubMo:getLastGainProfitTime()
	return self._lastGainProfitTime
end

function EternalCitySubMo:getGainProfitInterval()
	return self._gainProfitInterval
end

function EternalCitySubMo:getProsperity()
	return self._prosperity
end

function EternalCitySubMo:getHistoryMaxProsperity()
	return self._historyMaxProsperity
end

function EternalCitySubMo:getProsperityRewardMats()
	return self._prosperityRewardMats
end

function EternalCitySubMo:getProsperityRewardMat(prosperity)
	return self._prosperityRewardMats[prosperity]
end

function EternalCitySubMo:getMaxPassStageId()
	return self._maxPassStageId
end

function EternalCitySubMo:isEnoughBossClgTimes()
	return self._remainBossClgTimes > 0
end

function EternalCitySubMo:getRemainBossClgTimes()
	return self._remainBossClgTimes
end

function EternalCitySubMo:getMaxBossClgTimes()
	return self._bossClgStoreTimesLimit
end

function EternalCitySubMo:getLastRefreshBossClgTimesTime()
	return self._lastRefreshBossClgTimesTime
end

function EternalCitySubMo:getRefreshBossClgTime()
	return self._refreshBossClgTime
end

function EternalCitySubMo:getNextRefreshBossClgTimesTime()
	return (self._lastRefreshBossClgTimesTime + self._refreshBossClgTime * 3600 * 1000) / 1000
end

function EternalCitySubMo:getCreepsNum(creepsId)
	local creepsInfo = self._creepsInfos[creepsId]

	return (creepsInfo or nil) and (creepsInfo.num or 0)
end

function EternalCitySubMo:getCreepsInfos()
	return self._creepsInfos
end

function EternalCitySubMo:getCreepsNumInPlace(creepsId)
	return self._creepsNumInPlace[creepsId] or 0
end

function EternalCitySubMo:getSupportPetMo(creepsId)
	return self._supportPetMos[creepsId]
end

function EternalCitySubMo:getPlacePositionInfos()
	return self._placePositionInfos
end

function EternalCitySubMo:getPlacePositionInfoByPos(x, y)
	for _, v in ipairs(self._placePositionInfos) do
		if v.position.left == x and v.position.right == y then
			return v
		end
	end

	return nil
end

function EternalCitySubMo:getCurBuildCount()
	local count = 0

	for _, v in pairs(self._buildingNums) do
		for _, vv in pairs(v) do
			count = count + vv
		end
	end

	return count
end

function EternalCitySubMo:getMaxBuildCount()
	return self._maxBuildCount
end

function EternalCitySubMo:getBuildingNum(buildingId)
	local num = 0

	if self._buildingNums[buildingId] then
		for level, v in pairs(self._buildingNums[buildingId]) do
			num = num + v
		end
	end

	return num
end

function EternalCitySubMo:getBuildingNumByLevel(buildingId, level)
	return (self._buildingNums[buildingId] or nil) and (self._buildingNums[buildingId][level] or 0)
end

function EternalCitySubMo:getBuildingNumInPlace(buildingId, level)
	local num = 0

	for _, v in ipairs(self._placePositionInfos) do
		if v.buildingId == buildingId and v.level == level then
			num = num + 1
		end
	end

	return num
end

function EternalCitySubMo:isEnoughBuyBuildWithCost(buildingId, count)
	local mat = self._buildBuyCostMats[buildingId]
	local need = mat.matNum * count
	local with = self:getBuildBuyCostMatWithNum(buildingId)

	return need <= with
end

function EternalCitySubMo:getBuildBuyCostMat(buildingId)
	return self._buildBuyCostMats[buildingId]
end

function EternalCitySubMo:getBuildBuyCostMatWithNum(buildingId)
	local mat = self._buildBuyCostMats[buildingId]

	return MaterialModel.instance:getMaterialsNumber(mat.matType, mat.matId)
end

function EternalCitySubMo:getBuildSalePriceMat(buildingId, level)
	return self._buildSalePriceMats[buildingId] and self._buildSalePriceMats[buildingId][level]
end

function EternalCitySubMo:getBuildingProductionRate(buildingId, level, x, y)
	local placePositionInfo = self:getPlacePositionInfoByPos(x, y)

	if placePositionInfo then
		if not placePositionInfo.petIds then
			local petIds = {}
			local productionRate = 0

			for _, petId in ipairs(petIds) do
				local petData = EternalCityConfig.instance:getSupportPetData(self._activityId, petId)

				productionRate = productionRate + petData.productionRate
			end

			return productionRate
		end
	end
end

function EternalCitySubMo:getBuildingCurPlacePetNum(buildingId, level, x, y)
	local placePositionInfo = self:getPlacePositionInfoByPos(x, y)

	if placePositionInfo and placePositionInfo.petIds then
		return #placePositionInfo.petIds
	end

	return 0
end

function EternalCitySubMo:getBuildingMinUnlockLevel(buildingId, index)
	local datas = EternalCityConfig.instance:getBuildingDatas(self._activityId, buildingId)

	for level, data in ipairs(datas) do
		if index <= data.canPlacePetNum then
			return level
		end
	end

	return 999
end

function EternalCitySubMo:isUnlockedPlacePet(buildingId, level, index)
	local num = self:getBuildingCanPlacePetNum(buildingId, level)

	return index <= num
end

function EternalCitySubMo:getBuildingMaxPlacePetNum(buildingId)
	local maxLevel = self:getBuildingMaxLevel(buildingId)

	return self:getBuildingCanPlacePetNum(buildingId, maxLevel)
end

function EternalCitySubMo:getBuildingCanPlacePetNum(buildingId, level)
	local buildData = EternalCityConfig.instance:getBuildingData(self._activityId, buildingId, level)

	return (buildData or nil) and (buildData.canPlacePetNum or 0)
end

function EternalCitySubMo:getBuildingMaxLevel(buildingId)
	local datas = EternalCityConfig.instance:getBuildingDatas(self._activityId, buildingId)
	local maxData = datas and datas[#datas]

	return (maxData or nil) and (maxData.level or 0)
end

function EternalCitySubMo:isEnoughRecruitTimes()
	local maxRecruitTimes = self:getMaxRecruitTimes()

	return maxRecruitTimes > self._todayRecruitTimes
end

function EternalCitySubMo:getTodayRecruitTimes()
	return self._todayRecruitTimes
end

function EternalCitySubMo:getMaxRecruitTimes()
	local exAddRecruitTimes = self:getExAddRecruitTimes()

	return self._dailyRecruitTimes + exAddRecruitTimes
end

function EternalCitySubMo:getExAddRecruitTimes()
	local result = 0
	local placePositionInfos = self:getPlacePositionInfos()

	for _, placePositionInfo in ipairs(placePositionInfos) do
		local buildingId = placePositionInfo.buildingId
		local level = placePositionInfo.level
		local x = placePositionInfo.position.left
		local y = placePositionInfo.position.right
		local productionRate = self:getBuildingProductionRate(buildingId, level, x, y)
		local effectData = EternalCityConfig.instance:getBuildingEffectData(self._activityId, buildingId, productionRate)

		if effectData and effectData.type == EternalCityEnum.BuildingEffectType_RecruitPet then
			result = Mathf.Max(result, effectData.bonusRecruitTimes)
		end
	end

	return result
end

function EternalCitySubMo:getReduceRefreshCostPercent()
	local result = 0
	local placePositionInfos = self:getPlacePositionInfos()

	for _, placePositionInfo in ipairs(placePositionInfos) do
		local buildingId = placePositionInfo.buildingId
		local level = placePositionInfo.level
		local x = placePositionInfo.position.left
		local y = placePositionInfo.position.right
		local productionRate = self:getBuildingProductionRate(buildingId, level, x, y)
		local effectData = EternalCityConfig.instance:getBuildingEffectData(self._activityId, buildingId, productionRate)

		if effectData and effectData.type == EternalCityEnum.BuildingEffectType_RefreshPool then
			result = Mathf.Max(result, effectData.reduceRefreshCostPercent)
		end
	end

	return result
end

function EternalCitySubMo:isEnoughRefreshPoolWithCost()
	local need = self:getRefreshPoolCost()
	local with = self:getRefreshPoolCostMatWithNum()

	return need <= with
end

function EternalCitySubMo:getRefreshPoolCostMatWithNum()
	return MaterialModel.instance:getMaterialsNumber(self._refreshPoolCostMat.matType, self._refreshPoolCostMat.matId)
end

function EternalCitySubMo:getRefreshPoolCostMat()
	return self._refreshPoolCostMat
end

function EternalCitySubMo:getRefreshPoolCost()
	local cost = self._refreshPoolCostMat.matNum
	local reducePercent = self:getReduceRefreshCostPercent()

	return Mathf.Max(0, cost * (1 - reducePercent / 100))
end

function EternalCitySubMo:isEnoughPetRecruitWithCost(poolId, creepsId, count)
	local mat = self:getPetRecruitCostMat(poolId, creepsId)

	if mat then
		if not mat.matNum then
			local matNum = 0
			local need = matNum * count
			local with = self:getPetRecruitCostMatWithNum(poolId, creepsId)

			return need <= with
		end
	end
end

function EternalCitySubMo:getPetRecruitCostMatWithNum(poolId, creepsId)
	local mat = self:getPetRecruitCostMat(poolId, creepsId)

	return mat and MaterialModel.instance:getMaterialsNumber(mat.matType, mat.matId) or 0
end

function EternalCitySubMo:getPetRecruitCostMat(poolId, creepsId)
	return self._petRecruitCostMats[poolId] and self._petRecruitCostMats[poolId][creepsId]
end

function EternalCitySubMo:getPoolPetId(poolId)
	local poolInfo = self._poolInfos[poolId]

	return (poolInfo or nil) and (poolInfo.petId or 0)
end

function EternalCitySubMo:getPoolRefreshTimes(poolId)
	local poolInfo = self._poolInfos[poolId]

	return (poolInfo or nil) and (poolInfo.hasRefreshTimes or 0)
end

function EternalCitySubMo:isPoolLocked(poolId)
	local poolInfo = self._poolInfos[poolId]

	return (poolInfo or nil) and (poolInfo.isLock or false)
end

function EternalCitySubMo:getPoolInfo(poolId)
	return self._poolInfos[poolId]
end

function EternalCitySubMo:getStageClgResultMsg()
	return self._stageClgResultMsg
end

function EternalCitySubMo:getBossClgResultMsg()
	return self._bossClgResultMsg
end

function EternalCitySubMo:isPassAllStages()
	return self._maxPassStageId >= #EternalCityConfig.instance:getStageDatas(self._activityId)
end

function EternalCitySubMo:isPassStage(stageId)
	return stageId <= self._maxPassStageId
end

function EternalCitySubMo:isUnlockStage(stageId)
	return self:isUnlockStageByCond(stageId) and self:isUnlockStageByTime(stageId)
end

function EternalCitySubMo:isUnlockStageByTime(stageId)
	local data = EternalCityConfig.instance:getStageData(self._activityId, stageId)
	local openTime = data and data.openTime

	return GameUtil.getTimePeriod(openTime, nil) == GameUtil.inTimePeriod
end

function EternalCitySubMo:isUnlockStageByCond(stageId)
	local lastStageId = stageId - 1

	if lastStageId <= 0 then
		return true
	else
		return self:isPassStage(lastStageId)
	end
end

function EternalCitySubMo:getCanGainProfit()
	return 0
end

return EternalCitySubMo
