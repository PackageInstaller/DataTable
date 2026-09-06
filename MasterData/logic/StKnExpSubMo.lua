-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stknexp/data/StKnExpSubMo.lua

module("logic.extensions.stknexp.data.StKnExpSubMo", package.seeall)

local StKnExpSubMo = class("StKnExpSubMo")

function StKnExpSubMo:ctor(activityId)
	self._activityId = activityId

	local actData = StKnExpConfig.instance:getActData(self._activityId)
	local miningCostStr = actData and actData.miningCost
	local matType, matId, matNum = MaterialMgr.getMatParams(miningCostStr)

	self._miningCostMat = {
		matType = matType,
		matId = matId,
		matNum = matNum
	}
	self._islandCostMats = {}

	local islandCfg = StKnExpConfig.instance:getIslandCfg(self._activityId)

	if islandCfg then
		for islandId, data in ipairs(islandCfg) do
			local matType, matId, matNum = MaterialMgr.getMatParams(data.cost)
			local matOnlyId = matType .. ":" .. matId

			self._islandCostMats[islandId] = {
				matType = matType,
				matId = matId,
				matNum = matNum,
				matOnlyId = matOnlyId
			}
		end
	end

	self._zoneInfos = {}
	self._activeBuffs = {}
	self._zoneBossBuffs = {}
	self._islandInfos = {}
	self._levelInfo = {}
	self._changeSetIdsInStage = {}
end

function StKnExpSubMo:dispose()
	return
end

function StKnExpSubMo:handlePM_SaintKnightExpeditionInfoRes(msg)
	table.clear(self._zoneInfos)

	for _, v in ipairs(msg.zones) do
		self._zoneInfos[v.zoneId] = GameUtil.pbToTable(v)
	end

	table.clear(self._levelInfo)

	self._levelInfo = GameUtil.pbToTable(msg.level, self._levelInfo)

	table.clear(self._islandInfos)

	for _, v in ipairs(msg.islands) do
		self._islandInfos[v.islandId] = GameUtil.pbToTable(v)
	end

	self._activeBuffs = self:getActiveBuffIds()
end

function StKnExpSubMo:handlePM_SaintKnightExpeditionMiningRes(msg)
	table.clear(self._levelInfo)

	self._levelInfo = GameUtil.pbToTable(msg.level, self._levelInfo)
end

function StKnExpSubMo:handlePM_SaintKnightExpeditionUpgardeIslandRes(msg)
	self._activeBuffs = self:getActiveBuffIds()

	table.clear(self._islandInfos)

	for _, v in ipairs(msg.islands) do
		self._islandInfos[v.islandId] = GameUtil.pbToTable(v)
	end

	if msg:HasField("changeSetId") then
		self._changeSetIdInUpgarde = msg.changeSetId
	end
end

function StKnExpSubMo:handlePM_SaintKnightExpeditionChallengeRes(msg)
	return
end

function StKnExpSubMo:handlePM_SaintKnightExpeditionBossChallengeRes(msg)
	return
end

function StKnExpSubMo:handlePM_SaintKnightExpeditionGainBossPrizeRes(msg)
	local info = self._zoneInfos[msg.zoneId]

	if info then
		info.gainedPrizeIds = info.gainedPrizeIds or {}

		table.insert(info.gainedPrizeIds, msg.prizeId)
	end
end

function StKnExpSubMo:handlePM_SaintKnightExpeditionStageRankInfoRes(msg)
	return
end

function StKnExpSubMo:handlePM_SaintKnightExpeditionBossRankInfoRes(msg)
	return
end

function StKnExpSubMo:handlePM_NotifySaintKnightExpeditionChallengeEndRes(msg)
	if msg.isWin then
		local info = self._zoneInfos[msg.zoneId]

		if info then
			info.stageId = msg.stageId
		end
	end

	if msg:HasField("changeSetId") then
		local changeSetId = msg.changeSetId

		table.insert(self._changeSetIdsInStage, changeSetId)
	end
end

function StKnExpSubMo:handlePM_NotifySaintKnightExpeditionBossChallengeEndRes(msg)
	if not msg.simulate then
		local info = self._zoneInfos[msg.zoneId]

		if info then
			info.dailyBossTimes = info.dailyBossTimes + 1
			info.totalDamage = msg.damage
		end
	end
end

function StKnExpSubMo:getTryResultAndTipsOneKeyUpgardeIsland(isShowTips)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if result == GameEnum.ResultCode.Success and not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间范围内"
	end

	if result == GameEnum.ResultCode.Success then
		local isCan = false
		local islandIdAndNum = self:getUpgardeIslandIdAndNum()

		for _, v in ipairs(islandIdAndNum) do
			local islandId, num = v.left, v.right

			if num > 0 then
				isCan = true

				break
			end
		end

		if not isCan then
			result = GameEnum.ResultCode.Error
			tips = "缺少升级材料"
		end
	end

	if isShowTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function StKnExpSubMo:getTryResultAndTipsMining(isShowTips)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if result == GameEnum.ResultCode.Success and not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间范围内"
	end

	if result == GameEnum.ResultCode.Success and self:isAllCultMaxLevel() then
		result = GameEnum.ResultCode.Error
		tips = "培养已满级"
	end

	if result == GameEnum.ResultCode.Success then
		local cost = self:getMiningCostNum()
		local matNum = self:getCurMiningMatNum()

		if matNum < cost then
			result = GameEnum.ResultCode.Error
			tips = "道具不足"
		end
	end

	if isShowTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function StKnExpSubMo:isPassClgInZone(zoneId, clgType)
	if clgType == StKnExpEnum.ClgType_Stage then
		local max = self:getMaxStageId(zoneId)

		return self:isPassStage(zoneId, max)
	elseif clgType == StKnExpEnum.ClgType_Boss then
		local cur = self:getCurPrizeIdInBoss(zoneId)
		local max = self:getMaxPrizeIdInBoss(zoneId)

		return max <= cur
	end

	return false
end

function StKnExpSubMo:getClgTypeInZone(zoneId)
	local result

	for _, clgType in ipairs(StKnExpEnum.ClgTypeList) do
		if self:isUnlockClgInZone(zoneId, clgType) then
			result = clgType
		else
			break
		end
	end

	return result
end

function StKnExpSubMo:isUnlockClgInZone(zoneId, clgType)
	local lastClgType = clgType - 1

	if lastClgType <= 0 then
		return true
	else
		return self:isPassClgInZone(zoneId, lastClgType)
	end
end

function StKnExpSubMo:isUnlockZone(zoneId)
	local data = StKnExpConfig.instance:getZoneData(self._activityId, zoneId)

	return GameUtil.getTimePeriod(data.openTime, nil) == GameUtil.inTimePeriod
end

function StKnExpSubMo:isUnlockStage(zoneId, stageId)
	return self:isPassStage(zoneId, stageId)
end

function StKnExpSubMo:isPassStage(zoneId, stageId)
	local cur = self:getCurStageId(zoneId)

	return stageId <= cur
end

function StKnExpSubMo:getMaxStageId(zoneId)
	return StKnExpConfig.instance:getMaxStageId(self._activityId, zoneId)
end

function StKnExpSubMo:getCurStageId(zoneId)
	local info = self:getZoneInfo(zoneId)

	return (info or nil) and (info.stageId or 0)
end

function StKnExpSubMo:getChangeSetIdsInStage()
	return self._changeSetIdsInStage
end

function StKnExpSubMo:setChangeSetIdsInStage(value)
	self._changeSetIdsInStage = value or {}
end

function StKnExpSubMo:isEnoughBossTimesInClg()
	local result = false
	local cfg = StKnExpConfig.instance:getZoneCfg(self._activityId)

	if cfg then
		for _, data in ipairs(cfg) do
			if self:isEnoughBossTimes(data.zoneId) then
				result = true

				break
			end
		end
	end

	return result
end

function StKnExpSubMo:isEnoughBossTimes(zoneId)
	local max = self:getMaxDailyBossTimes(zoneId)
	local cur = self:getDailyBossTimes(zoneId)

	return cur < max
end

function StKnExpSubMo:getMaxDailyBossTimes(zoneId)
	local data = StKnExpConfig.instance:getZoneData(self._activityId, zoneId)

	return (data or nil) and (data.bossTimes or 0)
end

function StKnExpSubMo:getDailyBossTimes(zoneId)
	local info = self:getZoneInfo(zoneId)

	return (info or nil) and (info.dailyBossTimes or 0)
end

function StKnExpSubMo:getTotalDamage(zoneId)
	local info = self:getZoneInfo(zoneId)

	return info and checknumber(info.totalDamage) or 0
end

function StKnExpSubMo:getRankDamage(zoneId)
	local info = self:getZoneInfo(zoneId)

	return info and checknumber(info.rankDamage) or 0
end

function StKnExpSubMo:getRankTime(zoneId)
	local info = self:getZoneInfo(zoneId)

	return info and checknumber(info.rankTime) or 0
end

function StKnExpSubMo:getFirstPassTime(zoneId)
	local info = self:getZoneInfo(zoneId)

	return info and checknumber(info.firstPassTime) or 0
end

function StKnExpSubMo:isPassBossClg()
	local result = false
	local cfg = StKnExpConfig.instance:getZoneCfg(self._activityId)

	if cfg then
		for _, data in ipairs(cfg) do
			if self:isPassBossClgInZone(data.zoneId) then
				result = true

				break
			end
		end
	end

	return result
end

function StKnExpSubMo:isPassBossClgInZone(zoneId)
	local max = self:getMaxPrizeIdInBoss(zoneId)
	local cur = self:getCurPrizeIdInBoss(zoneId)

	return max <= cur
end

function StKnExpSubMo:isCanGetPrizeInBossClg()
	local result = false
	local cfg = StKnExpConfig.instance:getZoneCfg(self._activityId)

	if cfg then
		for _, data in ipairs(cfg) do
			if self:isCanGetPrizeInBossZone(data.zoneId) then
				result = true

				break
			end
		end
	end

	return result
end

function StKnExpSubMo:isCanGetPrizeInBossZone(zoneId)
	local result = false
	local cfg = StKnExpConfig.instance:getBossPrizeCfg(self._activityId, zoneId)

	if cfg then
		for _, data in ipairs(cfg) do
			if self:isCanGetPrizeInBoss(zoneId, data.prizeId) then
				result = true

				break
			end
		end
	end

	return result
end

function StKnExpSubMo:isCanGetPrizeInBoss(zoneId, prizeId)
	return not self:isHasGainPrizeInBoss(zoneId, prizeId) and self:isEnoughGetPrizeInBoss(zoneId, prizeId)
end

function StKnExpSubMo:isHasGainPrizeInBoss(zoneId, prizeId)
	local list = self:getGainedPrizeIds(zoneId)

	return table.indexof(list, prizeId) ~= false
end

function StKnExpSubMo:isEnoughGetPrizeInBoss(zoneId, prizeId)
	local data = StKnExpConfig.instance:getBossPrizeData(self._activityId, zoneId, prizeId)
	local need = checknumber(data and data.damage)
	local cur = self:getTotalDamage(zoneId)

	return need <= cur
end

function StKnExpSubMo:getCurPrizeIdInBoss(zoneId)
	local damage = self:getTotalDamage(zoneId)
	local data = StKnExpConfig.instance:getBossPrizeDataByDamage(self._activityId, zoneId, damage)

	return (data or nil) and (data.prizeId or 0)
end

function StKnExpSubMo:getMaxPrizeIdInBoss(zoneId)
	return StKnExpConfig.instance:getMaxPrizeIdInBoss(self._activityId, zoneId)
end

function StKnExpSubMo:getGainedPrizeIds(zoneId)
	local info = self:getZoneInfo(zoneId)

	return (info or nil) and (info.gainedPrizeIds or {})
end

function StKnExpSubMo:getZoneInfo(zoneId)
	return self._zoneInfos[zoneId]
end

function StKnExpSubMo:getMaxBossBuffNum()
	return StKnExpConfig.instance:getActDataValue(self._activityId, "bossBuffNum", true)
end

function StKnExpSubMo:getActiveBuffNum()
	local count = 0

	for k, v in pairs(self._activeBuffs) do
		count = count + 1
	end

	return count
end

function StKnExpSubMo:isActiveBuff(buffId)
	return self._activeBuffs[buffId] or false
end

function StKnExpSubMo:getSelectBuffsInZone(zoneId)
	return self._zoneBossBuffs[zoneId] or {}
end

function StKnExpSubMo:saveSelectBuffsInZone(zoneId, buffs)
	self._zoneBossBuffs[zoneId] = self._zoneBossBuffs[zoneId] or {}

	table.clear(self._zoneBossBuffs[zoneId])
	table.insertto(self._zoneBossBuffs[zoneId], buffs)
end

function StKnExpSubMo:isAllCultMaxLevel()
	local result = true

	for _, cultType in ipairs(StKnExpEnum.CultTypeList) do
		local cur = self:getCultLevel(cultType)
		local max = self:getMaxCultLevel(cultType)

		if cur < max then
			result = false

			break
		end
	end

	return result
end

function StKnExpSubMo:getProgressByExp(cultType, exp)
	local progress = 0
	local curLevel = self:getCultLevelByExp(cultType, exp)
	local nextLevel = curLevel + 1
	local cfg = self:getCultCfg(cultType)
	local curData = cfg[curLevel]
	local nextData = cfg[nextLevel]

	if nextData == nil then
		progress = 1
	elseif curData then
		if not curData.exp then
			local baseExp = 0

			if nextData then
				if not nextData.exp then
					local nextExp = 0

					progress = nextExp == baseExp and 1 or (exp - baseExp) / (nextExp - baseExp)
				end
			end
		end
	end

	return progress
end

function StKnExpSubMo:getCultLevel(cultType)
	local exp = self:getCultExp(cultType)

	return self:getCultLevelByExp(cultType, exp)
end

function StKnExpSubMo:getCultLevelByExp(cultType, exp)
	local data = self:getCultData(cultType, exp)

	return (data or nil) and (data.level or 0)
end

function StKnExpSubMo:getMaxCultLevel(cultType)
	local cfg = self:getCultCfg(cultType)

	return (cfg or nil) and (#cfg or 0)
end

function StKnExpSubMo:getCultData(cultType, exp)
	local cfg = self:getCultCfg(cultType)

	return MmUtil.binarySearchInSingleKey(cfg, "exp", exp)
end

function StKnExpSubMo:getCultCfg(cultType)
	local funcField = StKnExpEnum.CultLevelFuncFields[cultType]

	return funcField and StKnExpConfig[funcField](StKnExpConfig.instance, self._activityId)
end

function StKnExpSubMo:getCultExp(cultType)
	local field = StKnExpEnum.CultExpFields[cultType]

	return self:_getLevelInfoValue(field)
end

function StKnExpSubMo:_getLevelInfoValue(field)
	return checknumber(self._levelInfo[field])
end

function StKnExpSubMo:getCurMiningMatNum()
	return MaterialModel.instance:getMaterialsNumber(self._miningCostMat.matType, self._miningCostMat.matId)
end

function StKnExpSubMo:getMiningCostNum()
	return self._miningCostMat.matNum
end

function StKnExpSubMo:getMiningCostMat()
	return self._miningCostMat
end

function StKnExpSubMo:getCurIslandGameIndex()
	local index = 0
	local cfg = StKnExpConfig.instance:getIslandGameCfg(self._activityId) or {}

	for idx, data in ipairs(cfg) do
		local condType = data.condType

		if not string.nilorempty(condType) then
			local condParams = data.condParams

			if condType == StKnExpEnum.GameCondType_IslandLevel then
				local islandId, level = checknumber(condParams.islandId), checknumber(condParams.level)
				local curLevel = self:getIslandLevel(islandId)
				local matNum = self:getCurIslandMatNum(islandId)
				local upgardeLevel = self:getUpgardeLevelByMat(islandId, curLevel, matNum)

				if upgardeLevel < level then
					index = idx

					break
				end
			end
		else
			index = idx

			break
		end
	end

	return index
end

function StKnExpSubMo:getActiveBuffIds()
	local buffIds = {}
	local islandCfg = StKnExpConfig.instance:getIslandCfg(self._activityId) or {}

	for islandId, islandData in ipairs(islandCfg) do
		local curLevel = self:getIslandLevel(islandId)
		local levelCfg = StKnExpConfig.instance:getIslandLevelCfg(self._activityId, islandId)

		for level = 0, curLevel do
			local data = levelCfg[level]

			if data and data.islandBuffIds then
				for _, v in ipairs(data.islandBuffIds) do
					buffIds[v] = v
				end
			end
		end
	end

	return buffIds
end

function StKnExpSubMo:getSupportPetIdDic()
	local petIdDic = {}
	local cfg = StKnExpConfig.instance:getSupportCfg(self._activityId) or {}

	for _, data in pairs(cfg) do
		if data.initOpen then
			petIdDic[data.creepsId] = data.creepsId
		end
	end

	local islandCfg = StKnExpConfig.instance:getIslandCfg(self._activityId) or {}

	for islandId, islandData in ipairs(islandCfg) do
		local curLevel = self:getIslandLevel(islandId)
		local levelCfg = StKnExpConfig.instance:getIslandLevelCfg(self._activityId, islandId)

		for level = 0, curLevel do
			local levelData = levelCfg[level]

			if levelData then
				for _, v in ipairs(levelData.lockCreepIds or {}) do
					petIdDic[v] = nil
				end

				for _, v in ipairs(levelData.unlockCreepIds or {}) do
					petIdDic[v] = v
				end
			end
		end
	end

	return petIdDic
end

function StKnExpSubMo:getUpgardeIslandIdAndNum()
	local idAndNumList = {}
	local wallets = {}
	local islandInfoList = {}
	local cfg = StKnExpConfig.instance:getIslandCfg(self._activityId) or {}

	for islandId, data in ipairs(cfg) do
		if not self:isFullMaxLevelIsland(islandId) and self:isUnlockUpgardeTime(islandId) then
			local info = {}

			info.islandId = islandId
			info.level = self:getIslandLevel(islandId)
			info.maxLevel = self:getMaxIslandLevel(islandId)
			info.exp = self:getIslandExp(islandId)
			info.mat = self:getIslandCostMat(islandId)

			table.insert(islandInfoList, info)

			local mat = info.mat
			local num = self:getCurIslandMatNum(islandId)

			wallets[mat.matOnlyId] = {
				mat = mat,
				num = num
			}
		end
	end

	for _, info in ipairs(islandInfoList) do
		local maxLevelData = StKnExpConfig.instance:getIslandLevelData(self._activityId, info.islandId, info.maxLevel)

		if maxLevelData then
			if not maxLevelData.exp then
				local totalExp = 0

				totalExp = Mathf.Max(totalExp - info.exp, 0)

				local eachExpCost = info.mat.matNum
				local needMatCost = totalExp * eachExpCost
				local walletMatNum = wallets[info.mat.matOnlyId].num
				local fitUseMatNum = Mathf.Min(needMatCost, walletMatNum)
				local fitCost = Mathf.Floor(fitUseMatNum / eachExpCost)

				if fitCost > 0 then
					local useNum = fitCost * eachExpCost

					wallets[info.mat.matOnlyId].num = walletMatNum - useNum

					table.insert(idAndNumList, {
						left = info.islandId,
						right = fitCost
					})
				end
			end
		end
	end

	return idAndNumList
end

function StKnExpSubMo:getUpgardeLevelByMat(islandId, curLevel, matNum)
	local eachExpCost = self:getIslandCostNum(islandId)
	local upgardeExp = eachExpCost * matNum
	local data = StKnExpConfig.instance:getIslandLevelData(self._activityId, islandId, curLevel)

	if data then
		if not data.exp then
			local curExp = 0
			local totalExp = curExp + upgardeExp
			local upgardeData = StKnExpConfig.instance:getIslandLevelDataByExp(self._activityId, islandId, totalExp)

			return (upgardeData or nil) and (upgardeData.level or 0)
		end
	end
end

function StKnExpSubMo:isUnlockUpgardeTime(islandId)
	local data = StKnExpConfig.instance:getIslandData(self._activityId, islandId)

	return data and GameUtil.getTimePeriod(data.unlockUpgardeTime, nil) == GameUtil.inTimePeriod or false
end

function StKnExpSubMo:getCurIslandMatNum(islandId)
	local mat = self:getIslandCostMat(islandId)

	return MaterialModel.instance:getMaterialsNumber(mat.matType, mat.matId)
end

function StKnExpSubMo:getIslandCostNum(islandId)
	local mat = self:getIslandCostMat(islandId)

	return mat.matNum
end

function StKnExpSubMo:getIslandCostMat(islandId)
	return self._islandCostMats[islandId]
end

function StKnExpSubMo:isAllIslandFullMax()
	local result = true
	local cfg = StKnExpConfig.instance:getIslandCfg(self._activityId) or {}

	for islandId, data in ipairs(cfg) do
		if not self:isFullMaxLevelIsland(islandId) then
			result = false

			break
		end
	end

	return result
end

function StKnExpSubMo:isFullMaxLevelIsland(islandId)
	local cur = self:getIslandLevel(islandId)
	local max = self:getMaxIslandLevel(islandId)

	return max <= cur
end

function StKnExpSubMo:getIslandLevel(islandId)
	local exp = self:getIslandExp(islandId)
	local data = StKnExpConfig.instance:getIslandLevelDataByExp(self._activityId, islandId, exp)

	return (data or nil) and (data.level or 0)
end

function StKnExpSubMo:getMaxIslandLevel(islandId)
	local cfg = StKnExpConfig.instance:getIslandLevelCfg(self._activityId, islandId)

	return (cfg or nil) and (#cfg or 0)
end

function StKnExpSubMo:getIslandExp(islandId)
	local info = self:_getIslandInfo(islandId)

	return (info or nil) and (info.exp or 0)
end

function StKnExpSubMo:_getIslandInfo(islandId)
	return self._islandInfos[islandId]
end

function StKnExpSubMo:getChangeSetIdInUpgarde()
	return self._changeSetIdInUpgarde
end

function StKnExpSubMo:setChangeSetIdInUpgarde(value)
	self._changeSetIdInUpgarde = nil
end

return StKnExpSubMo
