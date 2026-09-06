-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatewar/data/UltimateWarMo.lua

module("logic.extensions.ultimatewar.data.UltimateWarMo", package.seeall)

local UltimateWarMo = class("UltimateWarMo")

function UltimateWarMo:ctor(activityId)
	self._activityId = activityId
	self._finishPlotIds = {}
	self._petLevel = 1
	self._levelPetMos = {}

	local levelCfg = UltimateWarConfig.instance:getPetLevelCfg(activityId)

	if levelCfg then
		local fmo = FightingPowerPetMo.New()

		for _, data in ipairs(levelCfg) do
			fmo:fromChallengeCreepCo(data)

			local petMo = fmo:toBaseBagPetMo()

			petMo:setSupportedPet(true)

			self._levelPetMos[data.petLevel] = petMo
		end
	end

	local matStr = UltimateWarConfig.instance:getGoldMat(self._activityId)

	if not string.nilorempty(matStr) then
		local matType, matId, matNum = MaterialMgr.getMatParams(matStr)

		self._goldMat = {
			matType = matType,
			matId = matId
		}
	else
		self._goldMat = {}
	end

	local pointCfg = UltimateWarConfig.instance:getDefenceLineCfg(self._activityId)

	self._pointInfoDic = {}

	if pointCfg then
		for _, data in ipairs(pointCfg) do
			self._pointInfoDic[data.pointId] = UltimateWarPointInfo.New(self._activityId, data.pointId)
		end
	end

	self._unlockPreCondStepIds = {}
	self._unlockPreCondStepIds[UltimateWarEnum.StepId_One] = true
	self._towerInfoDic = {}

	local towerCfg = UltimateWarConfig.instance:getTowerCfg(self._activityId)

	if towerCfg then
		for _, data in ipairs(towerCfg) do
			self._towerInfoDic[data.towerId] = UltimateWarTowerInfo.New(self._activityId, data.towerId)
		end
	end

	self._bossMaxDamageInSecond = 0
	self._gainTowerBossPrizeIds = {}
	self._beatenBossIds = {}
	self._gainPrizeIdsInFinal = {}
	self._todayCheckIn = false
	self._checkInDays = 0
	self._maxCheckInday = 0

	local maxBuffDataByDay = UltimateWarConfig.instance:getMaxBuffDataByDay(self._activityId)

	if maxBuffDataByDay then
		self._maxCheckInday = maxBuffDataByDay.checkInDays
	end

	self._selectVoteId = 0
	self._voteList = {}
	self._recordList = {}
	self._recordSimpleTemp = nil
	self._reqStepTag = {}
end

function UltimateWarMo:dispose()
	for k, v in pairs(self._pointInfoDic) do
		v:onReset()

		self._pointInfoDic[k] = nil
	end

	for k, v in pairs(self._towerInfoDic) do
		v:onReset()

		self._towerInfoDic[k] = nil
	end

	for k, v in pairs(self._recordList) do
		v:onReset()

		self._recordList[k] = nil
	end

	self._towerBossMsg = nil
end

function UltimateWarMo:getActivityId()
	return self._activityId
end

function UltimateWarMo:handlePM_UltimateWarGetMainInfoRes(msg)
	table.clear(self._finishPlotIds)
	table.insertto(self._finishPlotIds, msg.finishPlotIds)

	self._petLevel = msg.petLevel

	if msg.hasSetDefensePoint then
		self._unlockPreCondStepIds[UltimateWarEnum.StepId_Two] = true
	end

	if msg.hasFightedTower then
		self._unlockPreCondStepIds[UltimateWarEnum.StepId_Three] = true
	end
end

function UltimateWarMo:handlePM_UltimateWarUpPetLevelRes(msg)
	self._petLevel = msg.petLevel
end

function UltimateWarMo:handlePM_UltimateWarFinishPlotRes(msg)
	table.clear(self._finishPlotIds)
	table.insertto(self._finishPlotIds, msg.finishPlotIds)
end

function UltimateWarMo:handlePM_UltimateWarFirstStepInfoRes(msg)
	self:setIsHasReqStep(UltimateWarEnum.StepId_One)

	for _, info in pairs(self._pointInfoDic) do
		info:onReset()
	end

	for _, value in ipairs(msg.pointList) do
		self._pointInfoDic[value.pointId]:updateData(value)
	end
end

function UltimateWarMo:handlePM_UltimateWarDispatchRes(msg)
	self._pointInfoDic[msg.pointList.pointId]:updateData(msg.pointList)

	self._unlockPreCondStepIds[UltimateWarEnum.StepId_Two] = true
end

function UltimateWarMo:handlePM_UltimateWarGainHangingPrizeRes(msg)
	for _, info in pairs(self._pointInfoDic) do
		info:onReset()
	end

	for _, value in ipairs(msg.pointList) do
		self._pointInfoDic[value.pointId]:updateData(value)
	end
end

function UltimateWarMo:handlePM_UltimateWarSecondStepInfoRes(msg)
	self:setIsHasReqStep(UltimateWarEnum.StepId_Two)

	for _, info in pairs(self._towerInfoDic) do
		info:onReset()
	end

	for _, value in ipairs(msg.towerList) do
		self._towerInfoDic[value.towerId]:updateData(value)
	end

	self._bossMaxDamageInSecond = checknumber(msg.bossMaxDamage)

	table.clear(self._gainTowerBossPrizeIds)
	table.insertto(self._gainTowerBossPrizeIds, msg.gainTowerBossPrizeIds)
end

function UltimateWarMo:handlePM_UltimateWarTowerFightRes(msg)
	return
end

function UltimateWarMo:handlePM_UltimateWarContinueTowerFightRes(msg)
	return
end

function UltimateWarMo:handlePM_UltimateWarNotifyTowerFightRes(msg)
	self._unlockPreCondStepIds[UltimateWarEnum.StepId_Three] = true
end

function UltimateWarMo:handlePM_UltimateWarTowerBossFightRes(msg)
	return
end

function UltimateWarMo:handlePM_UltimateWarNotifyTowerBossFightRes(msg)
	self._towerBossMsg = msg
end

function UltimateWarMo:handlePM_UltimateWarGainTowerBossPrizeRes(msg)
	if msg.type == 1 then
		for i, v in ipairs(msg.prizeId) do
			self._towerInfoDic[msg.subId]:addPrizeId(v)
		end
	elseif msg.type == 2 then
		table.insertto(self._gainTowerBossPrizeIds, msg.prizeId)
	end
end

function UltimateWarMo:handlePM_UltimateWarSubmitTowerBossFormRes(msg)
	return
end

function UltimateWarMo:handlePM_UltimateWarThirdStepInfoRes(msg)
	self:setIsHasReqStep(UltimateWarEnum.StepId_Three)
	table.clear(self._beatenBossIds)
	table.insertto(self._beatenBossIds, msg.beatenBossIds)
	table.clear(self._gainPrizeIdsInFinal)
	table.insertto(self._gainPrizeIdsInFinal, msg.gainPrizeIds)

	self._checkInDays = msg.checkInDays
	self._todayCheckIn = checkbool(msg.todayCheckIn)
	self._selectVoteId = msg.selectVoteId
	self._voteList = msg.voteList
end

function UltimateWarMo:handlePM_UltimateWarThirdStepFightRes(msg)
	return
end

function UltimateWarMo:handlePM_UltimateWarThirdStepGainPrizeRes(msg)
	table.insert(self._gainPrizeIdsInFinal, msg.prizeId)
end

function UltimateWarMo:handlePM_UltimateWarThirdStepCheckInRes(msg)
	self._checkInDays = msg.checkInDays
	self._todayCheckIn = checkbool(msg.todayCheckIn)
end

function UltimateWarMo:handlePM_UltimateWarRankViewRes(msg)
	return
end

function UltimateWarMo:handlePM_UltimateWarRecordRes(msg)
	local list = {}

	for idx = #self._recordList, 1, -1 do
		local record = table.remove(self._recordList, idx)

		record:onReset()
		table.insert(list, record)
	end

	for _, v in ipairs(msg.records) do
		local record = table.remove(list, #list)

		if record == nil then
			record = UltimateWarRecord.New()
		end

		record:updateData(v)
		table.insert(self._recordList, record)
	end

	table.clear(list)
	table.sort(self._recordList, function(a, b)
		return a:getDamage() > b:getDamage()
	end)
end

function UltimateWarMo:handlePM_UltimateWarNotifyThirdStepFightRes(msg)
	return
end

function UltimateWarMo:handlePM_UltimateWarVoteRes(msg)
	return
end

function UltimateWarMo:getPetLevel()
	return self._petLevel
end

function UltimateWarMo:getMaxPetLevel()
	return UltimateWarConfig.instance:getMaxLevel(self._activityId)
end

function UltimateWarMo:getLevelPetMo(petLevel)
	return self._levelPetMos[petLevel]
end

function UltimateWarMo:getCurLevelPetMo()
	return self._levelPetMos[self._petLevel]
end

function UltimateWarMo:getGoldMatNum()
	return MaterialModel.instance:getMaterialsNumber(self._goldMat.matType, self._goldMat.matId)
end

function UltimateWarMo:isFinishPlotId(plotId)
	return table.indexof(self._finishPlotIds, plotId) ~= false
end

function UltimateWarMo:isUnLockStep(stepId)
	return self:isUnLockStepByTime(stepId) and self:isUnLockStepByPreCond(stepId)
end

function UltimateWarMo:isUnLockStepByTime(stepId)
	local data = UltimateWarConfig.instance:getStepData(self._activityId, stepId)

	if data then
		return GameUtil.checkIsInTimePeriod(data.openTime, data.endTime)
	end

	return false
end

function UltimateWarMo:isUnLockStepByPreCond(stepId)
	return checkbool(self._unlockPreCondStepIds[stepId])
end

function UltimateWarMo:getPointInfo(pointId)
	return self._pointInfoDic[pointId]
end

function UltimateWarMo:getTowerInfo(towerId)
	return self._towerInfoDic[towerId]
end

function UltimateWarMo:isPassAllTower()
	for _, info in pairs(self._towerInfoDic) do
		if not info:isPassTower() then
			return false
		end
	end

	return true
end

function UltimateWarMo:getBossMaxDamageInSecond()
	return self._bossMaxDamageInSecond
end

function UltimateWarMo:getGainTowerBossPrizeIds()
	return self._gainTowerBossPrizeIds
end

function UltimateWarMo:isCanGetPrizeOfAllInTowerBoss()
	local result = false
	local cfg = UltimateWarConfig.instance:getDamagePrizeCfg(self._activityId)

	if cfg then
		for _, data in ipairs(cfg) do
			if self:isCanGetPrizeInTowerBoss(data.prizeId) then
				result = true

				break
			end
		end
	end

	return result
end

function UltimateWarMo:isCanGetPrizeInTowerBoss(prizeId)
	return not self:isHasGainPrizeInTowerBoss(prizeId) and self:isEnoughPrizeInTowerBoss(prizeId)
end

function UltimateWarMo:isHasGainPrizeInTowerBoss(prizeId)
	return table.indexof(self._gainTowerBossPrizeIds, prizeId) ~= false
end

function UltimateWarMo:isEnoughPrizeInTowerBoss(prizeId)
	local data = UltimateWarConfig.instance:getDamagePrizeData(self._activityId, prizeId)

	if data then
		if not data.damage then
			local need = 0

			return need <= self._bossMaxDamageInSecond
		end
	end
end

function UltimateWarMo:getTowerBossMsg()
	return self._towerBossMsg
end

function UltimateWarMo:isPassAllFinalBoss()
	local cur = self:getBeatBossCount()
	local max = UltimateWarConfig.instance:getFinalBossCount(self._activityId)

	return max <= cur
end

function UltimateWarMo:getBeatBossCount()
	return #self._beatenBossIds
end

function UltimateWarMo:isPassBossInFinal(bossId)
	return table.indexof(self._beatenBossIds, bossId) ~= false
end

function UltimateWarMo:isCanGetPrizeOfAllInFinalBoss()
	local result = false
	local cfg = UltimateWarConfig.instance:getBossPrizeCfg(self._activityId)

	if cfg then
		for _, data in ipairs(cfg) do
			if self:isCanGetPrizeInFinalBoss(data.prizeId) then
				result = true

				break
			end
		end
	end

	return result
end

function UltimateWarMo:isCanGetPrizeInFinalBoss(prizeId)
	return not self:isHasGainPrizeInFinalBoss(prizeId) and self:isEnoughPrizeInFinalBoss(prizeId)
end

function UltimateWarMo:isHasGainPrizeInFinalBoss(prizeId)
	return table.indexof(self._gainPrizeIdsInFinal, prizeId) ~= false
end

function UltimateWarMo:isEnoughPrizeInFinalBoss(prizeId)
	local prizeData = UltimateWarConfig.instance:getBossPrizeData(self._activityId, prizeId)

	if prizeData then
		if not prizeData.beatBossCount then
			local beatBossCount = 0

			return beatBossCount <= self:getBeatBossCount()
		end
	end
end

function UltimateWarMo:getCheckInDays()
	return self._checkInDays
end

function UltimateWarMo:isFullDay()
	return self._checkInDays >= self._maxCheckInday
end

function UltimateWarMo:isTodayCheckIn()
	return self._todayCheckIn
end

function UltimateWarMo:getSelectVoteId()
	return self._selectVoteId
end

function UltimateWarMo:getVoteList()
	return self._voteList
end

function UltimateWarMo:_getVote(voteId)
	for i, v in ipairs(self._voteList) do
		if v.voteId == voteId then
			return v
		end
	end
end

function UltimateWarMo:getVoteCount(voteId)
	local vote = self:_getVote(voteId)

	return (vote or nil) and vote.voteCount
end

function UltimateWarMo:getTowerRecordList()
	return self._recordList
end

function UltimateWarMo:popRecordSimpleTemp()
	self._recordSimpleTemp = nil

	return self._recordSimpleTemp
end

function UltimateWarMo:setRecordSimpleTemp(value)
	self._recordSimpleTemp = value
end

function UltimateWarMo:isHasReqStep(stepId)
	return checkbool(self._reqStepTag[stepId])
end

function UltimateWarMo:setIsHasReqStep(stepId)
	self._reqStepTag[stepId] = true
end

return UltimateWarMo
