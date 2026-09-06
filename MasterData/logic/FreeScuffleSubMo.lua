-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/data/FreeScuffleSubMo.lua

module("logic.extensions.freescuffle.data.FreeScuffleSubMo", package.seeall)

local FreeScuffleSubMo = class("FreeScuffleSubMo")
local TimeUnit = 1

function FreeScuffleSubMo:ctor(activityId)
	self._activityId = activityId

	local actData = FreeScuffleConfig.instance:getActData(activityId)

	if actData then
		local matStr = actData.costCoinItem
		local matType, matId, matNum, matName = 0, 0, 0, ""

		if not string.nilorempty(matStr) then
			matType, matId, matNum = MaterialMgr.getMatParams(matStr)
			matName = MaterialMgr.getMaterialsName(matType, matId)
		end

		self._costCoinItem = {
			matStr = matStr,
			matType = matType,
			matId = matId,
			matNum = matNum,
			matName = matName
		}
	end

	if actData then
		local matStr = actData.lotteryCost
		local matType, matId, matNum, matName = 0, 0, 0, ""

		if not string.nilorempty(matStr) then
			matType, matId, matNum = MaterialMgr.getMatParams(matStr)
			matName = MaterialMgr.getMaterialsName(matType, matId)
		end

		self._lotteryCostItem = {
			matStr = matStr,
			matType = matType,
			matId = matId,
			matNum = matNum,
			matName = matName
		}
	end

	self._dailyTimesLimit = checknumber(actData and actData.dailyTimesLimit)
	self._packageEffectTimeMs = checknumber(actData and actData.packageEffectTime) * 1000
	self._shipIdInRaces = {}

	local shipCfg = FreeScuffleConfig.instance:getShipCfg(self._activityId) or {}

	for relationshipId, data in ipairs(shipCfg) do
		if data.petIds then
			for _, raceId in ipairs(data.petIds) do
				self._shipIdInRaces[raceId] = self._shipIdInRaces[raceId] or {}

				table.insert(self._shipIdInRaces[raceId], relationshipId)
			end
		end
	end

	local blockCfg = FreeScuffleConfig.instance:getBlockCfg(activityId) or {}

	self._blockIdList = {}
	self._progressBlocks = {}

	for _, data in ipairs(blockCfg) do
		table.insert(self._blockIdList, data.blockId)

		self._progressBlocks[data.blockId] = 0
	end

	self._workingBlockPets = {}
	self._incCoinInBlocks = {}
	self._petInfos = {}
	self._blockInfos = {}
	self._lastRefreshTimes = {}
	self._historyGainCoin = 0
	self._curCoin = 0
	self._nextEasterEggGameTime = 0
	self._nextRandomEventLotteryTime = 0
	self._nextPackageTime = 0
	self._todayLeftPackageTime = 0
	self._todayLeftEasterEggGameTime = 0
	self._todayLeftRandomEventLotteryTime = 0
	self._historyGainCoint = 0
	self._clientKeyOfEggGame = 0
	self._serverKeyOfEggGame = 0
	self._isOverLastEggGame = false
	self._isOverLastRandomEventLottery = false
	self._isOverPackage = false
	self._battlePetIdDic = {}
	self._bagSkillIds = {}
	self._todayBattleTimes = 0
	self._scorePk = 0
	self._winStreakPk = 0
	self._opponent = nil
	self._defendForm = nil
	self._skillListInPets = {}
	self._packageInfos = {}
	self._taskInfos = {}
	self._sumProgress = 0
	self._hasGainProgressPrizeId = 0

	self:loadNewRecord()
end

function FreeScuffleSubMo:dispose()
	return
end

function FreeScuffleSubMo:handlePM_FreeScuffleGetInfoRes(msg)
	self._historyGainCoin = checknumber(msg.historyGainCoin)

	self:_updateCoin(msg.curCoin)
	self:_updateBlockInfos(msg.blockList, true)
	table.clear(self._petInfos)

	for i, v in ipairs(msg.petList) do
		self:_updatePetInfo(v.raceId, v.level, v.star)
	end

	self._nextEasterEggGameTime = checknumber(msg.lastEasterEggGameTime)
	self._nextRandomEventLotteryTime = checknumber(msg.lastRandomEventLotteryTime)

	self:_updateWorkEventState()
end

function FreeScuffleSubMo:handlePM_FreeScuffleGainCoinRes(msg)
	self:_updateBlockInfos(msg.blockList, false)
	self:_updateCoin(msg.curCoin)

	self._historyGainCoint = checknumber(msg.historyGainCoint)
end

function FreeScuffleSubMo:handlePM_FreeScuffleUnlockBlockRes(msg)
	self:_updateBlockInfos({
		msg.block
	}, false)
	self:_updateCoin(msg.curCoin)
end

function FreeScuffleSubMo:handlePM_FreeScuffleUpgradlePetRes(msg)
	self._petInfos[msg.pet.raceId] = msg.pet

	if msg:HasField("block") then
		self:_updateBlockInfos({
			msg.block
		}, false)
	end

	self:_updateCoin(msg.curCoin)
end

function FreeScuffleSubMo:handlePM_FreeScuffleLotteryRes(msg)
	local starDic
	local poolType = msg.type

	for i, v in ipairs(msg.loteryInfoList) do
		local itemType = v.type

		if itemType == FreeScuffleEnum.DrawCardTypes_WorkPet then
			starDic = starDic or {}

			local raceId = v.itemId

			starDic[raceId] = Mathf.Max(starDic[raceId] or 0, v.curStar)

			self:_updatePetInfo(raceId, (self:isWithPet(raceId) or nil) and self:getPetLevel(raceId), starDic[raceId])
		elseif itemType == FreeScuffleEnum.DrawCardTypes_Skill then
			self._bagSkillIds[v.itemId] = v.itemId
		elseif itemType == FreeScuffleEnum.DrawCardTypes_BattlePet then
			self._battlePetIdDic[v.itemId] = v.itemId
		elseif itemType == FreeScuffleEnum.DrawCardTypes_ExPrize then
			local itemData = FreeScuffleConfig.instance:getLotteryExtraItemData(self._activityId, poolType, v.itemId)

			if itemData then
				if not itemData.coin then
					local coin = 0

					self:_updateCoin(self._curCoin + coin)
				end
			end
		end
	end
end

function FreeScuffleSubMo:handlePM_FreeScuffleTaskInfoRes(msg)
	table.clear(self._taskInfos)

	local taskInfos = GameUtil.pbToTable(msg.taskInfo)

	for i, v in ipairs(taskInfos) do
		self._taskInfos[v.taskId] = v
	end

	self._sumProgress = msg.sumProgress
	self._hasGainProgressPrizeId = GameUtil.pbToTable(msg.hasGainProgressPrizeId) or {}
end

function FreeScuffleSubMo:handlePM_FreeScuffleGainTaskPrizeRes(msg)
	self:_updateCoin(msg.curCoin)

	self._historyGainCoint = checknumber(msg.historyGainCoint)
	self._sumProgress = msg.sumProgress

	local info = self._taskInfos[msg.taskId]

	if info then
		info.hasGainPrize = true
	end
end

function FreeScuffleSubMo:handlePM_FreeScuffleTaskNotifyRes(msg)
	local taskInfos = GameUtil.pbToTable(msg.taskInfo)

	for _, v in ipairs(taskInfos) do
		self._taskInfos[v.taskId] = v
	end
end

function FreeScuffleSubMo:handlePM_FreeScuffleScheduleRes(msg)
	self:_updateBlockInfos(msg.blockList, false)
end

function FreeScuffleSubMo:handlePM_FreeScuffleStartEasterEggGameRes(msg)
	self._serverKeyOfEggGame = msg.serverKey
end

function FreeScuffleSubMo:handlePM_FreeScuffleEndEasterEggGameRes(msg)
	self._clientKeyOfEggGame = 0
	self._serverKeyOfEggGame = 0

	self:_updateCoin(msg.curCoin)

	self._historyGainCoint = checknumber(msg.historyGainCoint)
	self._todayLeftEasterEggGameTime = msg.todayLeftGameTimes
	self._nextEasterEggGameTime = checknumber(msg.nextEasterEggGameTime)

	self:_updateWorkEventState()
end

function FreeScuffleSubMo:handlePM_FreeScuffleDeliverPackageRes(msg)
	self:_updateCoin(msg.curCoin)

	self._historyGainCoint = checknumber(msg.historyGainCoint)
	self._todayLeftPackageTime = checknumber(msg.todayLeftPackageTime)

	local onlyId = self:getOnlyIdInPack(msg.blockId, msg.packageId)
	local info = self:getPackageInfo(onlyId)

	if info then
		info.num = info.num - 1
	end

	if self:isPackageEmpty() then
		self:_onResetPackageData()
	end
end

function FreeScuffleSubMo:handlePM_FreeScuffleRandomEventLotteryRes(msg)
	self:_updateCoin(msg.curCoin)

	self._historyGainCoint = checknumber(msg.historyGainCoint)
	self._todayLeftRandomEventLotteryTime = msg.todayLeftRandomEventLotteryTime
	self._nextRandomEventLotteryTime = checknumber(msg.nextRandomEventLotteryTime)

	self:_updateWorkEventState()
end

function FreeScuffleSubMo:handlePM_FreeScuffleExitInterfaceRes(msg)
	self._nextEasterEggGameTime = 0
	self._nextRandomEventLotteryTime = 0
	self._nextPackageTime = 0
	self._isOverPackage = false
	self._isOverLastEggGame = false
	self._isOverLastRandomEventLottery = false

	self:_onResetPackageData()
	self:_updateWorkEventState()
end

function FreeScuffleSubMo:handlePM_FreeScuffleGainTaskProgressPrizeRes(msg)
	table.insert(self._hasGainProgressPrizeId, msg.progressId)
end

function FreeScuffleSubMo:handlePM_FreeScuffleResetNextPackageRes(msg)
	self._nextPackageTime = checknumber(msg.nextPackageTime)
	self._todayLeftPackageTime = msg.todayLeftPackageTime

	self:_updatePackageInfos(msg.packageInfoList, true)
end

function FreeScuffleSubMo:handlePM_FreeScuffleEnterInterfaceRes(msg)
	self._nextEasterEggGameTime = checknumber(msg.nextEasterEggGameTime)
	self._nextRandomEventLotteryTime = checknumber(msg.nextRandomEventLotteryTime)
	self._nextPackageTime = checknumber(msg.nextPackageTime)
	self._todayLeftPackageTime = msg.todayLeftPackageTime
	self._todayLeftEasterEggGameTime = msg.todayLeftEasterEggGameTime
	self._todayLeftRandomEventLotteryTime = msg.todayLeftRandomEventLotteryTime

	self:_updatePackageInfos(msg.packageInfoList, true)
	self:_updateWorkEventState()
end

function FreeScuffleSubMo:handlePM_FreeScuffleBattleInfoRes(msg)
	table.clear(self._battlePetIdDic)

	for _, v in ipairs(msg.petList) do
		self._battlePetIdDic[v.creepsId] = v.creepsId
	end

	local fmtTypes = {
		FreeScuffleEnum.FmtType_Pk,
		FreeScuffleEnum.FmtType_Defense
	}
	local skills = {
		msg.petList,
		msg.petSkillList
	}
	local skillNum = table.nums(FreeScuffleEnum.SkillIndexs)

	for idx, fmtType in ipairs(fmtTypes) do
		self._skillListInPets[fmtType] = {}

		for _, v in ipairs(skills[idx]) do
			self._skillListInPets[fmtType][v.creepsId] = {}

			for skillIndex = 1, skillNum do
				self._skillListInPets[fmtType][v.creepsId][skillIndex] = v.skillIds[skillIndex] or 0
			end
		end
	end

	table.clear(self._bagSkillIds)

	for i, skillId in ipairs(msg.skillIds) do
		self._bagSkillIds[skillId] = skillId
	end

	self._todayBattleTimes = msg.todayBattleTimes
	self._scorePk = msg.score
	self._winStreakPk = msg.winStreak
	self._opponent = nil

	if msg:HasField("opponent") then
		self._opponent = msg.opponent
	end

	self._defendForm = nil

	if msg:HasField("form") then
		self._defendForm = msg.form
	end
end

function FreeScuffleSubMo:handlePM_FreeScuffleSetFormRes(msg)
	self._defendForm = msg.form
end

function FreeScuffleSubMo:handlePM_FreeScuffleChangeSkillRes(msg)
	return
end

function FreeScuffleSubMo:handlePM_FreeScuffleMatchRes(msg)
	self._opponent = msg.opponent
end

function FreeScuffleSubMo:handlePM_FreeScuffleBattleRes(msg)
	return
end

function FreeScuffleSubMo:handlePM_FreeScuffleBattleNotifyRes(msg)
	self._opponent = nil
	self._todayBattleTimes = msg.todayBattleTimes
	self._winStreakPk = msg.winStreak
	self._score = msg.curScore
end

function FreeScuffleSubMo:_updatePetInfo(raceId, level, star)
	local info = self._petInfos[raceId]

	if info == nil then
		self._petInfos[raceId] = {}
		info = self._petInfos[raceId]
	end

	info.raceId = raceId
	info.level = level
	info.star = star
end

function FreeScuffleSubMo:_updateBlockInfos(blockList, isCover)
	if isCover then
		table.clear(self._blockInfos)
		table.clear(self._lastRefreshTimes)
	end

	for i, v in ipairs(blockList) do
		self._blockInfos[v.blockId] = v
		self._lastRefreshTimes[v.blockId] = checknumber(v.lastRefreshTime)
	end

	table.clear(self._workingBlockPets)

	for blockId, info in pairs(self._blockInfos) do
		if info.raceId > 0 then
			self._workingBlockPets[info.raceId] = blockId
		end
	end
end

function FreeScuffleSubMo:_updateCoin(value)
	self._curCoin = checknumber(value)

	MaterialFacade.instance:UpdateMaterial(self._costCoinItem.matType, self._costCoinItem.matId, self._curCoin)
end

function FreeScuffleSubMo:getTryGainPrizeResultAndTips(isShowTips, taskId)
	local result = GameEnum.ResultCode.Success
	local tips

	if not self:isInActivityTime() then
		result = GameEnum.ResultCode.NotInActTime
		tips = isShowTips and "不在活动时间范围内"
	elseif self:isHasGainOfTask(taskId) then
		result = GameEnum.ResultCode.IsHasGain
		tips = isShowTips and "已领取"
	elseif not self:isEnoughOfTask(taskId) then
		result = GameEnum.ResultCode.NotEnoughProgress
		tips = isShowTips and "未满足要求"
	end

	if isShowTips then
		FloatWordMgr.instance:show(tips)
	end

	return result, tips
end

function FreeScuffleSubMo:getTryUpgradePetResultAndTips(isShowTips, raceId, addLevel)
	local result = GameEnum.ResultCode.Success
	local tips

	if not self:isInActivityTime() then
		result = GameEnum.ResultCode.Error
		tips = isShowTips and "不在活动时间范围内"
	elseif addLevel <= 0 then
		result = GameEnum.ResultCode.Error
		tips = isShowTips and "等级不能倒退"
	elseif FreeScuffleConfig.instance:getPetData(self._activityId, raceId) == nil then
		result = GameEnum.ResultCode.Error
		tips = isShowTips and "未选择精灵"
	elseif not self:isWithPet(raceId) then
		result = GameEnum.ResultCode.Error
		tips = isShowTips and "未拥有此精灵"
	elseif self:isMaxedLevelPet(raceId) then
		result = GameEnum.ResultCode.Error
		tips = isShowTips and "已满级"
	elseif not self:isEnoughCostUpgradePet(raceId, addLevel) then
		result = GameEnum.ResultCode.Error
		tips = isShowTips and string.format("%s不足", self._costCoinItem.matName)
	elseif self:getPetLevel(raceId) + addLevel > self:getMaxPetLevel(raceId) then
		result = GameEnum.ResultCode.Error
		tips = isShowTips and string.format("升级无法超过最大等级")
	end

	if isShowTips then
		FloatWordMgr.instance:show(tips)
	end

	return result, tips
end

function FreeScuffleSubMo:getTrySetWorkBlockPetResultAndTips(isShowTips, blockId, raceId)
	local result = GameEnum.ResultCode.Success
	local tips

	if not self:isInActivityTime() then
		result = GameEnum.ResultCode.Error
		tips = isShowTips and "不在活动时间范围内"
	elseif blockId <= 0 then
		result = GameEnum.ResultCode.Error
		tips = isShowTips and "未选择区域"
	elseif FreeScuffleConfig.instance:getPetData(self._activityId, raceId) == nil then
		result = GameEnum.ResultCode.Error
		tips = isShowTips and "未选择精灵"
	elseif not self:isWithPet(raceId) then
		result = GameEnum.ResultCode.Error
		tips = isShowTips and "未拥有此精灵"
	elseif self:getRaceIdBlock(blockId) == raceId then
		result = GameEnum.ResultCode.Error
		tips = isShowTips and "精灵已在工作区"
	end

	if isShowTips then
		FloatWordMgr.instance:show(tips)
	end

	return result, tips
end

function FreeScuffleSubMo:getTryLotteryResultAndTips(isShowTips, poolType, lotteryTimes)
	local result = GameEnum.ResultCode.Success
	local tips

	if not self:isInActivityTime() then
		result = GameEnum.ResultCode.Error
		tips = isShowTips and "不在活动时间范围内"
	elseif poolType == nil then
		result = GameEnum.ResultCode.Error
		tips = isShowTips and "未选择抽卡池"
	elseif lotteryTimes <= 0 then
		result = GameEnum.ResultCode.Error
		tips = isShowTips and "未选择抽卡次数"
	elseif not self:isEnoughLotteryCost(lotteryTimes) then
		result = GameEnum.ResultCode.Error
		tips = isShowTips and string.format("%s不足", self._lotteryCostItem.matName)
	end

	if isShowTips then
		FloatWordMgr.instance:show(tips)
	end

	return result, tips
end

function FreeScuffleSubMo:isInActivityTime()
	return ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)
end

function FreeScuffleSubMo:onTicking()
	self._nowServerTimeMs = ServerTime.nowMs()

	for _, blockId in ipairs(self._blockIdList) do
		self._lastRefreshTimeTemp = self:getLastRefreshTimeBlock(blockId)
		self._increaseRatio = self:getCoinIncreaseRatioBlock(blockId)
		self._finishAddCoinTime = self:getFinishAddCoinTime(blockId)
		self._leftTimeMs = Mathf.Clamp(self._nowServerTimeMs - self._lastRefreshTimeTemp - 1500, 0, self._finishAddCoinTime - self._lastRefreshTimeTemp)
		self._incCoinInBlocks[blockId] = Mathf.Floor(self._leftTimeMs / 1000) * self._increaseRatio
		self._progressBlocks[blockId] = self._leftTimeMs % (TimeUnit * 1000) / TimeUnit / 1000
	end

	self:_updateWorkEventState()
end

function FreeScuffleSubMo:_updateWorkEventState()
	self._nowServerTimeMs = ServerTime.nowMs()
	self._isNeedDispatchEventTrigger = false
	self._eventTriggerResult = self._nextPackageTime > 0 and self._nowServerTimeMs >= self._nextPackageTime and self._todayLeftPackageTime > 0

	if self._isOverPackage ~= self._eventTriggerResult then
		self._isNeedDispatchEventTrigger = true
		self._isOverPackage = self._eventTriggerResult
	end

	if self._isOverPackage and self._nowServerTimeMs - self._nextPackageTime >= self._packageEffectTimeMs then
		self._isOverPackage = false

		self:_onResetPackageData()
		GlobalDispatcher:dispatch(GlobalNotify.FreeScufflePackageEnd, self._activityId)
	end

	self._eventTriggerResult = self._nextEasterEggGameTime > 0 and self._nowServerTimeMs >= self._nextEasterEggGameTime and self._todayLeftEasterEggGameTime > 0

	if self._isOverLastEggGame ~= self._eventTriggerResult then
		self._isNeedDispatchEventTrigger = true
		self._isOverLastEggGame = self._eventTriggerResult
	end

	self._eventTriggerResult = self._nextRandomEventLotteryTime > 0 and self._nowServerTimeMs >= self._nextRandomEventLotteryTime and self._todayLeftRandomEventLotteryTime > 0

	if self._isOverLastRandomEventLottery ~= self._eventTriggerResult then
		self._isNeedDispatchEventTrigger = true
		self._isOverLastRandomEventLottery = self._eventTriggerResult
	end

	if self._isNeedDispatchEventTrigger then
		self._isNeedDispatchEventTrigger = false

		GlobalDispatcher:dispatch(GlobalNotify.FreeScuffleTriggerEvent, self._activityId)
	end
end

function FreeScuffleSubMo:getProgressBlocks(blockId)
	return self._progressBlocks[blockId] or 0
end

function FreeScuffleSubMo:getTotalInCreaseRatio()
	local result = 0

	for _, blockId in ipairs(self._blockIdList) do
		result = result + self:getCoinIncreaseRatioBlock(blockId)
	end

	return result
end

function FreeScuffleSubMo:getTotalAccumulateCoin()
	local result = 0

	for _, blockId in ipairs(self._blockIdList) do
		result = result + self:getAccumulateCoinInBlock(blockId)
	end

	return result
end

function FreeScuffleSubMo:getAccumulateCoinInBlock(blockId)
	return self:getAccumulateCoinBlock(blockId) + self:getIncreaseValue(blockId)
end

function FreeScuffleSubMo:getIncreaseValue(blockId)
	return self._incCoinInBlocks[blockId]
end

function FreeScuffleSubMo:getHistoryGainCoin()
	return self._historyGainCoin
end

function FreeScuffleSubMo:getCurCoin()
	return self._curCoin
end

function FreeScuffleSubMo:getHistoryGainCoint()
	return self._historyGainCoint
end

function FreeScuffleSubMo:getNextEasterEggGameTime()
	return self._nextEasterEggGameTime
end

function FreeScuffleSubMo:getNextRandomEventLotteryTime()
	return self._nextRandomEventLotteryTime
end

function FreeScuffleSubMo:getNextPackageTime()
	return self._nextPackageTime
end

function FreeScuffleSubMo:getTodayLeftPackageTime()
	return self._todayLeftPackageTime
end

function FreeScuffleSubMo:getTodayLeftEasterEggGameTime()
	return self._todayLeftEasterEggGameTime
end

function FreeScuffleSubMo:getTodayLeftRandomEventLotteryTime()
	return self._todayLeftRandomEventLotteryTime
end

function FreeScuffleSubMo:isOverPackage()
	return self._isOverPackage
end

function FreeScuffleSubMo:isOverLastEggGame()
	return self._isOverLastEggGame
end

function FreeScuffleSubMo:isOverLastRandomEventLottery()
	return self._isOverLastRandomEventLottery
end

function FreeScuffleSubMo:setClientKeyOfEggGame(clientKey)
	self._clientKeyOfEggGame = clientKey
end

function FreeScuffleSubMo:getClientKeyOfEggGame()
	return self._clientKeyOfEggGame
end

function FreeScuffleSubMo:setServerKeyOfEggGame(serverKey)
	self._serverKeyOfEggGame = serverKey
end

function FreeScuffleSubMo:getServerKeyOfEggGame()
	return self._serverKeyOfEggGame
end

function FreeScuffleSubMo:getCostCoinItem()
	return self._costCoinItem
end

function FreeScuffleSubMo:isEnoughLotteryCost(lotteryTimes)
	local with = self:getWithLotteryCostItem()
	local need = lotteryTimes * self._lotteryCostItem.matNum

	return need <= with
end

function FreeScuffleSubMo:getLotteryCostItem()
	return self._lotteryCostItem
end

function FreeScuffleSubMo:getWithLotteryCostItem()
	return MaterialModel.instance:getMaterialsNumber(self._lotteryCostItem.matType, self._lotteryCostItem.matId)
end

function FreeScuffleSubMo:isEnoughCostUpgradePet(raceId, addLevel)
	local cur = self:getPetLevel(raceId)
	local toLevel = cur + addLevel
	local need = self:getCostNumUpgradePet(raceId, cur, toLevel)
	local with = self:getCurCoin()

	return need <= with
end

function FreeScuffleSubMo:getCostNumUpgradePet(raceId, formLevel, toLevel)
	local result = 0
	local maxLevel = self:getMaxPetLevel(raceId)

	toLevel = Mathf.Min(toLevel, maxLevel)

	for level = formLevel + 1, toLevel do
		local cost = self:getCostCoinInPet(raceId, level)

		result = result + cost
	end

	return result
end

function FreeScuffleSubMo:getCoinIncreaseRatioInPet(raceId, level)
	local data = FreeScuffleConfig.instance:getLevelData(self._activityId, raceId, level)

	return checknumber(data and data.coinIncreaseRatio)
end

function FreeScuffleSubMo:getCostCoinInPet(raceId, level)
	local data = FreeScuffleConfig.instance:getLevelData(self._activityId, raceId, level)

	return checknumber(data and data.costCoin)
end

function FreeScuffleSubMo:getBaseIncreaseRatioRace(raceId, level, star)
	local levelData = FreeScuffleConfig.instance:getLevelData(self._activityId, raceId, level)
	local starData = FreeScuffleConfig.instance:getStarData(self._activityId, raceId, star)
	local ratioLevel = checknumber(levelData and levelData.coinIncreaseRatio)
	local ratioStar = checknumber(starData and starData.coinIncreaseRatio)

	return ratioLevel * (1 + ratioStar / 10000)
end

function FreeScuffleSubMo:isMaxedLevelPet(raceId)
	local cur = self:getPetLevel(raceId)
	local max = self:getMaxPetLevel(raceId)

	return max <= cur
end

function FreeScuffleSubMo:getPetLevel(raceId)
	local info = self:_getPetInfo(raceId)

	return (info or nil) and (info.level or -1)
end

function FreeScuffleSubMo:isWithPet(raceId)
	local info = self:_getPetInfo(raceId)

	return info ~= nil
end

function FreeScuffleSubMo:getMaxPetLevel(raceId)
	local cfg = FreeScuffleConfig.instance:getLevelCfg(self._activityId, raceId)
	local data = cfg and cfg[#cfg]

	return (data or nil) and (data.level or 0)
end

function FreeScuffleSubMo:getPetStar(raceId)
	local info = self:_getPetInfo(raceId)

	return (info or nil) and (info.star or 0)
end

function FreeScuffleSubMo:getMaxPetStar(raceId)
	local cfg = FreeScuffleConfig.instance:getStarCfg(self._activityId, raceId)
	local data = cfg and cfg[#cfg]

	return (data or nil) and (data.star or 0)
end

function FreeScuffleSubMo:getPetInfos()
	return self._petInfos
end

function FreeScuffleSubMo:_getPetInfo(raceId)
	return self._petInfos[raceId]
end

function FreeScuffleSubMo:isWorkingPet(raceId)
	return self:getPetWorkingBlock(raceId) > 0
end

function FreeScuffleSubMo:getPetWorkingBlock(raceId)
	return self._workingBlockPets[raceId] or 0
end

function FreeScuffleSubMo:isHaveShipInPet(raceId)
	local list = self._shipIdInRaces[raceId]

	return list ~= nil and #list > 0
end

function FreeScuffleSubMo:getActiveShipInPet(raceId)
	local idList = {}
	local list = self._shipIdInRaces[raceId]

	if list then
		for _, relationshipId in ipairs(list) do
			if self:isActiveShip(relationshipId) then
				table.insert(idList, relationshipId)
			end
		end
	end

	return idList
end

function FreeScuffleSubMo:getShipInPet(raceId)
	return self._shipIdInRaces[raceId] or {}
end

function FreeScuffleSubMo:isActiveShip(relationshipId)
	local result = false
	local data = FreeScuffleConfig.instance:getShipData(self._activityId, relationshipId)
	local petIds = data and data.petIds

	if petIds then
		result = true

		for _, raceId in ipairs(petIds) do
			if not self:isWorkingPet(raceId) then
				result = false

				break
			end
		end
	end

	return result
end

function FreeScuffleSubMo:getUnlockCostCoin(blockId)
	local data = FreeScuffleConfig.instance:getBlockData(self._activityId, blockId)

	return checknumber(data and data.unlockCostCoin)
end

function FreeScuffleSubMo:isUnlockBlock(blockId)
	local info = self:_getBlockInfo(blockId)

	return checkbool(info and info.unlock)
end

function FreeScuffleSubMo:getRaceIdBlock(blockId)
	local info = self:_getBlockInfo(blockId)

	return checknumber(info and info.raceId)
end

function FreeScuffleSubMo:getLastRefreshTimeBlock(blockId)
	return self._lastRefreshTimes[blockId] or 0
end

function FreeScuffleSubMo:getStartAccumulateTimeBlock(blockId)
	local info = self:_getBlockInfo(blockId)

	return checknumber(info and info.startAccumulateTime)
end

function FreeScuffleSubMo:getCoinIncreaseRatioBlock(blockId)
	local info = self:_getBlockInfo(blockId)

	return checknumber(info and info.coinIncreaseRatio)
end

function FreeScuffleSubMo:getAccumulateCoinBlock(blockId)
	local info = self:_getBlockInfo(blockId)

	return checknumber(info and info.accumulateCoin)
end

function FreeScuffleSubMo:getFinishAddCoinTime(blockId)
	local info = self:_getBlockInfo(blockId)

	return checknumber(info and info.finishAddCoinTime)
end

function FreeScuffleSubMo:_getBlockInfo(blockId)
	return self._blockInfos[blockId]
end

function FreeScuffleSubMo:isEnoughBattleTimes()
	local cur = self:getTodayBattleTimes()
	local max = self:getMaxBattleTimes()

	return max <= cur
end

function FreeScuffleSubMo:getTodayBattleTimes()
	return self._todayBattleTimes
end

function FreeScuffleSubMo:getMaxBattleTimes()
	return self._dailyTimesLimit
end

function FreeScuffleSubMo:isWithBatPet(creepsId)
	return self._battlePetIdDic[creepsId] ~= nil
end

function FreeScuffleSubMo:getBattlePetIdDic()
	return self._battlePetIdDic
end

function FreeScuffleSubMo:getSkillListInPets(fmtType)
	return self._skillListInPets[fmtType]
end

function FreeScuffleSubMo:setSkillListInPets(fmtType, value)
	self._skillListInPets[fmtType] = TableUtil.deepcopy(value)
end

function FreeScuffleSubMo:getSkillIdInPets(fmtType, creepsId, skillType)
	local skillLists = self:getSkillListInPets(fmtType)

	return (skillLists and skillLists[creepsId] or nil) and (skillLists[creepsId][FreeScuffleEnum.SkillIndexs[skillType]] or 0)
end

function FreeScuffleSubMo:isWithSkill(skillId)
	return self._bagSkillIds[skillId] ~= nil
end

function FreeScuffleSubMo:getScorePk()
	return self._scorePk
end

function FreeScuffleSubMo:getWinStreakPk()
	return self._winStreakPk
end

function FreeScuffleSubMo:getOpponent()
	return self._opponent
end

function FreeScuffleSubMo:getDefendForm()
	return self._defendForm
end

function FreeScuffleSubMo:_onResetPackageData()
	self._isOverPackage = false
	self._nextPackageTime = 0

	table.clear(self._packageInfos)
end

function FreeScuffleSubMo:isPackageEmpty()
	for k, info in pairs(self._packageInfos) do
		if info.num > 0 then
			return false
		end
	end

	return true
end

function FreeScuffleSubMo:getPackageInfo(onlyId)
	return self._packageInfos[onlyId]
end

function FreeScuffleSubMo:getPackageInfos()
	return self._packageInfos
end

function FreeScuffleSubMo:delPackageInfo(onlyId)
	self._packageInfos[onlyId] = nil
end

function FreeScuffleSubMo:_updatePackageInfos(packageInfoList, isCover)
	if isCover then
		table.clear(self._packageInfos)
	end

	for _, v in ipairs(packageInfoList) do
		for idx = 1, #v.packageIds do
			local info = {}

			info.blockId = v.blockId
			info.packageId = v.packageIds[idx]
			info.num = v.packageNum[idx]
			info.onlyId = self:getOnlyIdInPack(info.blockId, info.packageId)
			self._packageInfos[info.onlyId] = info
		end
	end
end

function FreeScuffleSubMo:getOnlyIdInPack(blockId, packageId)
	return string.format("%s_%s", blockId, packageId)
end

function FreeScuffleSubMo:getTaskState(taskId)
	if self:isHasGainOfTask(taskId) then
		return GameEnum.PrizeState.IsHasGain
	elseif not self:isEnoughOfTask(taskId) then
		return GameEnum.PrizeState.IsNotEnough
	end

	return GameEnum.PrizeState.IsCanGet
end

function FreeScuffleSubMo:isCanGainOfTask(taskId)
	return not self:isHasGainOfTask(taskId) and self:isEnoughOfTask(taskId)
end

function FreeScuffleSubMo:isEnoughOfTask(taskId)
	local cur = self:getProgressTask(taskId)
	local need = self:getMaxProgressOfTask(taskId)

	return need <= cur
end

function FreeScuffleSubMo:getMaxProgressOfTask(taskId)
	local data = FreeScuffleConfig.instance:getTaskData(self._activityId, taskId)

	return checknumber(data and data.maxProgress)
end

function FreeScuffleSubMo:isHasGainOfTask(taskId)
	local info = self:_getTaskInfo(taskId)

	return checkbool(info and info.hasGainPrize)
end

function FreeScuffleSubMo:getProgressTask(taskId)
	local info = self:_getTaskInfo(taskId)

	return checknumber(info and info.curProgress)
end

function FreeScuffleSubMo:_getTaskInfo(taskId)
	return self._taskInfos[taskId]
end

function FreeScuffleSubMo:isCanPrizeProgress(progressId)
	return not self:isHasGainPrizeProgress(progressId) and self:isEnoughPrizeProgress(progressId)
end

function FreeScuffleSubMo:isEnoughPrizeProgress(progressId)
	local data = FreeScuffleConfig.instance:getTaskProgressPrizeData(self._activityId, progressId)
	local need = checknumber(data and data.progress)
	local cur = self:getSumProgress()

	return need <= cur
end

function FreeScuffleSubMo:isHasGainPrizeProgress(progressId)
	return table.indexof(self._hasGainProgressPrizeId, progressId) ~= false
end

function FreeScuffleSubMo:getSumProgress()
	return self._sumProgress
end

function FreeScuffleSubMo:getHasGainProgressPrizeId()
	return self._hasGainProgressPrizeId
end

function FreeScuffleSubMo:isNewItem(itemType, itemId)
	itemType = tostring(itemType)
	itemId = tostring(itemId)

	if self._recordGainItems[itemType] then
		if not self._recordGainItems[itemType][itemId] then
			local isNotNew = false

			return not isNotNew
		end
	end
end

function FreeScuffleSubMo:setNotNewItem(itemType, itemId)
	itemType = tostring(itemType)
	itemId = tostring(itemId)
	self._recordGainItems[itemType] = self._recordGainItems[itemType] or {}
	self._recordGainItems[itemType][itemId] = true
end

function FreeScuffleSubMo:saveNewRecord()
	local key = string.format("freeScuffle_new_record_%s", self._activityId)

	GameUtil.saveUserData(key, self._recordGainItems)
end

function FreeScuffleSubMo:loadNewRecord()
	local key = string.format("freeScuffle_new_record_%s", self._activityId)

	self._recordGainItems = GameUtil.getUserData(key) or {}
end

return FreeScuffleSubMo
