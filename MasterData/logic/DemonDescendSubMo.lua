-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/demondescend/data/DemonDescendSubMo.lua

module("logic.extensions.demondescend.data.DemonDescendSubMo", package.seeall)

local DemonDescendSubMo = class("DemonDescendSubMo")

function DemonDescendSubMo:ctor(activityId)
	self._activityId = activityId

	local actData = DemonDescendConfig.instance:getActData(activityId)
	local matStr = actData and actData.wineItem
	local matType, matId, matNum, matName = 0, 0, 0, ""

	if not string.nilorempty(matStr) then
		matType, matId, matNum = MaterialMgr.getMatParams(matStr)
		matName = MaterialMgr.getMaterialsName(matType, matId)
	end

	self._wineItem = {
		matStr = matStr,
		matType = matType,
		matId = matId,
		matNum = matNum,
		matName = matName
	}
	self._buffIdsDefaultUnlock = {}

	local buffCfgs = DemonDescendConfig.instance:getBuffCfgs(activityId) or {}

	for i, cfg in ipairs(buffCfgs) do
		for i, data in ipairs(cfg) do
			if data.isUnlock then
				self._buffIdsDefaultUnlock[data.buffId] = true
			end
		end
	end

	self._hasGainRedWine = 0
	self._hasUnlockStage = 0
	self._todayBossChallengeTime = 0
	self._totalDamage = 0
	self._todayMaxDamage = 0
	self._hasGainProgressId = {}
	self._hasGainBuffId = {}
	self._maxPassStageId = 0
	self._perfectWinStage = {}
	self._isTodaySignIn = false
	self._banRaceIds = {}
	self._bossResMsg = nil

	self:_deserializeActiveBuffs()
end

function DemonDescendSubMo:dispose()
	return
end

function DemonDescendSubMo:handlePM_DemonDescendInfoRes(msg)
	self:_updateRedWine(msg.hasGainRedWine)

	self._hasUnlockStage = msg.hasUnlockStage
	self._todayBossChallengeTime = msg.todayBossChallengeTime
	self._totalDamage = checknumber(msg.totalDamage)
	self._todayMaxDamage = checknumber(msg.todayMaxDamage)
	self._maxPassStageId = msg.maxPassStageId
	self._isTodaySignIn = msg.isTodaySignIn

	MmUtil.fillTableByValues(self._hasGainProgressId, msg.hasGainProgressId, true)
	MmUtil.fillTableByValues(self._hasGainBuffId, msg.hasGainBuffId, true)
	MmUtil.fillTableByValues(self._perfectWinStage, msg.perfectWinStage, true)
	MmUtil.fillTableByValues(self._banRaceIds, msg.banRaceIdList, true)
end

function DemonDescendSubMo:handlePM_DemonDescendUnlockBuffRes(msg)
	MmUtil.fillTableByValues(self._hasGainBuffId, {
		msg.unlockBuff
	}, false)

	local data = DemonDescendConfig.instance:getBuffDataById(self._activityId, msg.unlockBuff)

	if data then
		if not data.requiredRedWine then
			local num = 0

			self:_updateRedWine(Mathf.Max(0, self._hasGainRedWine - num))
		end
	end
end

function DemonDescendSubMo:handlePM_DemonDescendGainProgressPrizeRes(msg)
	self._hasGainProgressId[msg.progressId] = msg.progressId
end

function DemonDescendSubMo:handlePM_DemonDescendCheckInRes(msg)
	self:_updateRedWine(msg.hasGainRedWine)

	self._isTodaySignIn = checkbool(msg.isTodayCheckIn)
end

function DemonDescendSubMo:handlePM_DemonDescendResetBuffRes(msg)
	self:_updateRedWine(msg.redWineNum)
	table.clear(self._hasGainBuffId)

	for buffId, _ in pairs(self._buffIdsDefaultUnlock) do
		self._hasGainBuffId[buffId] = buffId
	end

	self:saveActiveBuffs(nil)
end

function DemonDescendSubMo:handlePM_DemonDescendStageChallengeRes(msg)
	return
end

function DemonDescendSubMo:handlePM_DemonDescendNotifyStageChallengeRes(msg)
	return
end

function DemonDescendSubMo:handlePM_DemonDescendBossChallengeRes(msg)
	return
end

function DemonDescendSubMo:handlePM_DemonDescendNotifyBossChallengeRes(msg)
	self._bossResMsg = msg

	MmUtil.fillTableByValues(self._banRaceIds, msg.banRaceIdList, false)
end

function DemonDescendSubMo:handlePM_DemonDescendRankViewRes(msg)
	return
end

function DemonDescendSubMo:_updateRedWine(value)
	self._hasGainRedWine = checknumber(value)

	MaterialFacade.instance:UpdateMaterial(self._wineItem.matType, self._wineItem.matId, self._hasGainRedWine)
end

function DemonDescendSubMo:getWineItem()
	return self._wineItem
end

function DemonDescendSubMo:getHasGainRedWine()
	return self._hasGainRedWine
end

function DemonDescendSubMo:getHasUnlockStage()
	return self._hasUnlockStage
end

function DemonDescendSubMo:getTodayLeftBossChallengeTime()
	local max = self:getMaxBossChallengeTime()

	return Mathf.Max(max - self._todayBossChallengeTime, 0)
end

function DemonDescendSubMo:getMaxBossChallengeTime()
	local data = DemonDescendConfig.instance:getActData(self._activityId)

	return (data or nil) and (data.dailyBossChallengeTime or 0)
end

function DemonDescendSubMo:isEnoughTimesToBossChallenge()
	local left = self:getTodayLeftBossChallengeTime()

	return left > 0
end

function DemonDescendSubMo:getTotalDamage()
	return self._totalDamage
end

function DemonDescendSubMo:getTodayMaxDamage()
	return self._todayMaxDamage
end

function DemonDescendSubMo:isProgressRewardGained(progressId)
	return self._hasGainProgressId[progressId] ~= nil
end

function DemonDescendSubMo:isOpenStage(stageId)
	return self:isPassStageNormal(stageId - 1) or self:isPassStagePerfect(stageId - 1)
end

function DemonDescendSubMo:isUnlockStage(stageId)
	return stageId <= self:getHasUnlockStage()
end

function DemonDescendSubMo:getMaxPassStageId()
	return self._maxPassStageId
end

function DemonDescendSubMo:getMaxStageId()
	local cfg = DemonDescendConfig.instance:getStageCfg(self._activityId)

	return (cfg or nil) and (#cfg or 0)
end

function DemonDescendSubMo:isPassStageNormal(stageId)
	return stageId <= self._maxPassStageId
end

function DemonDescendSubMo:isPassStagePerfect(stageId)
	return self._perfectWinStage[stageId] ~= nil
end

function DemonDescendSubMo:getCurWineInStage(stageId)
	local num = 0
	local data = DemonDescendConfig.instance:getStageData(self._activityId, stageId)

	if self:isPassStageNormal(stageId) then
		num = num + ((data or nil) and (data.winGainRedWine or 0))
	end

	if self:isPassStagePerfect(stageId) then
		num = num + ((data or nil) and (data.perfectWinGainRedWine or 0))
	end

	return num
end

function DemonDescendSubMo:getMaxWineInStage(stageId)
	local data = DemonDescendConfig.instance:getStageData(self._activityId, stageId)

	return (data or nil) and data.winGainRedWine + data.perfectWinGainRedWine
end

function DemonDescendSubMo:isTodaySignIn()
	return self._isTodaySignIn
end

function DemonDescendSubMo:isCanGetPrize(prizeId)
	return not self:isHasGainPrize(prizeId) and self:isEnoughGetPrize(prizeId)
end

function DemonDescendSubMo:isHasGainPrize(prizeId)
	return self._hasGainProgressId[prizeId] or false
end

function DemonDescendSubMo:isEnoughGetPrize(prizeId)
	local data = DemonDescendConfig.instance:getProgressPrizeData(self._activityId, prizeId)
	local need = data and data.progress
	local cur = self:getTotalDamage()

	return need <= cur
end

function DemonDescendSubMo:isEnoughCostToUnlockBuff(buffType, buffId)
	local cost = self:getCostToUnlockBuff(buffType, buffId)

	return cost <= self._hasGainRedWine
end

function DemonDescendSubMo:getCostToUnlockBuff(buffType, buffId)
	local data = DemonDescendConfig.instance:getBuffDataById(self._activityId, buffId)

	return (data or nil) and (data.requiredRedWine or 0)
end

function DemonDescendSubMo:isBuffUnlocked(buffId)
	return self._hasGainBuffId[buffId] ~= nil
end

function DemonDescendSubMo:isBuffDefaultUnlocked(buffId)
	return self._buffIdsDefaultUnlock[buffId] or false
end

function DemonDescendSubMo:saveActiveBuffs(value)
	self._activeBuffIds = value

	local saveData

	if value then
		saveData = {}

		for buffType, buffIds in pairs(value) do
			local buffType = tostring(buffType)

			saveData[buffType] = {}

			for buffId, isActive in pairs(buffIds) do
				saveData[buffType][tostring(buffId)] = isActive
			end
		end
	end

	local key = string.format("DemonDescend_SaveActiveBuffs_%s", self._activityId)

	GameUtil.saveUserData(key, saveData)
end

function DemonDescendSubMo:getActiveBuffs()
	return self._activeBuffIds or {}
end

function DemonDescendSubMo:_deserializeActiveBuffs()
	local key = string.format("DemonDescend_SaveActiveBuffs_%s", self._activityId)
	local value = GameUtil.getUserData(key) or {}

	self._activeBuffIds = {}

	for buffType, buffIds in pairs(value) do
		local buffType = checknumber(buffType)

		self._activeBuffIds[buffType] = {}

		for buffId, isActive in pairs(buffIds) do
			self._activeBuffIds[buffType][checknumber(buffId)] = checkbool(isActive)
		end
	end
end

function DemonDescendSubMo:isBanRace(raceId)
	return self._banRaceIds[raceId] ~= nil
end

function DemonDescendSubMo:getBanRaceIds()
	return self._banRaceIds
end

function DemonDescendSubMo:getBossResMsg()
	return self._bossResMsg
end

return DemonDescendSubMo
