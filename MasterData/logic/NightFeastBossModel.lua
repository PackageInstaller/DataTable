-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nightfeastbosschallenge/model/NightFeastBossModel.lua

module("logic.extensions.nightfeastbosschallenge.model.NightFeastBossModel", package.seeall)

local NightFeastBossModel = class("NightFeastBossModel", BaseModel)

function NightFeastBossModel:onInit()
	self:onReset()
end

function NightFeastBossModel:onReset()
	self._agentDic = {}
	self._baseInfoMap = {}
	self._rankInfoMap = {}
	self._bossInfoMap = {}
end

function NightFeastBossModel:getAgentInfo(activityId)
	if not self._agentDic[activityId] then
		self._agentDic[activityId] = {}

		self:_initAgent(self._agentDic[activityId])
	end

	return self._agentDic[activityId]
end

function NightFeastBossModel:_initAgent(info)
	info.activityId = 0
	info.buffPoint = 0
	info.buffLvl = {}
	info.totalDamage = 0
	info.maxDamage = 0
	info.progressPrizeGainedBitId = {}
	info.dailyStageId = {}
	info.dailyPassedStageId = {}
	info.dailyHasResetBuffCount = 0
	info.dailyHasFightBossCount = 0
	info.dailyLockedRaces = {}
	info.rankInfos = {}
	info.myRank = -1
	info.win = false
	info.tempOldPoint = 0
	info.tempNewPoint = 0
	info.curFightDamage = 0
	info.normalCustomFmtMo = nil
	info.bossCustomFmtMo = nil
end

function NightFeastBossModel:getNormalCustomFmtMo(activityId)
	local info = self:getAgentInfo(activityId)

	if info.normalCustomFmtMo == nil then
		info.normalCustomFmtMo = NightFeastNormalCustomFmtMo.New()
	end

	return info.normalCustomFmtMo
end

function NightFeastBossModel:getBossCustomFmtMo(activityId)
	local info = self:getAgentInfo(activityId)

	if info.bossCustomFmtMo == nil then
		info.bossCustomFmtMo = NightFeastBossCustomFmtMo.New()
	end

	return info.bossCustomFmtMo
end

function NightFeastBossModel:onNightFeastBossClgGetInfoRes(msg)
	local info = self:getAgentInfo(msg.activityId)

	info.activityId = msg.activityId
	info.buffPoint = msg.buffPoint
	info.buffLvl = GameUtil.pbToTable(msg.buffLvl) or {}
	info.totalDamage = checknumber(msg.totalDamage)
	info.maxDamage = checknumber(msg.maxDamage)
	info.progressPrizeGainedBitId = GameUtil.pbToTable(msg.progressPrizeGainedBitId) or {}
	info.dailyStageId = GameUtil.pbToTable(msg.dailyStageId) or {}
	info.dailyPassedStageId = GameUtil.pbToTable(msg.dailyPassedStageId) or {}
	info.dailyHasResetBuffCount = msg.dailyHasResetBuffCount
	info.dailyHasFightBossCount = msg.dailyHasFightBossCount
	info.dailyLockedRaces = GameUtil.pbToTable(msg.dailyLockedRaces) or {}

	local baseInfo = GameUtil.pbToTable(msg)

	self._baseInfoMap[msg.activityId] = baseInfo

	local bossInfoMap = {}
	local bossList = baseInfo.bossList

	for _, bossInfo in ipairs(bossList) do
		bossInfoMap[bossInfo.bossId] = bossInfo
	end

	self._bossInfoMap[msg.activityId] = bossInfoMap
end

function NightFeastBossModel:onNightFeastBossClgFight4BuffRes(msg)
	return
end

function NightFeastBossModel:onNightFeastBossClgFight4BuffNotifyFightResultRes(msg)
	local info = self:getAgentInfo(msg.activityId)

	info.win = msg.win

	if msg.win and msg:HasField("totolPoint") then
		info.tempOldPoint = info.buffPoint
		info.tempNewPoint = msg.totolPoint
		info.buffPoint = msg.totolPoint

		if not TableUtil.isHad(info.dailyPassedStageId, msg.stageId) then
			table.insert(info.dailyPassedStageId, msg.stageId)
		end
	else
		info.tempOldPoint = info.buffPoint
		info.tempNewPoint = info.buffPoint
	end
end

function NightFeastBossModel:onNightFeastBossClgFightBossRes(msg)
	return
end

function NightFeastBossModel:onNightFeastBossClgFightBossNotifyFightResultRes(msg)
	local info = self:getAgentInfo(msg.activityId)

	info.curFightDamage = checknumber(msg.curFightDamage)
	info.maxDamage = checknumber(msg.maxDamage)
	info.totalDamage = checknumber(msg.totalDamage)
	info.dailyLockedRaces = GameUtil.pbToTable(msg.dailyLockedRaces)
	info.dailyHasFightBossCount = msg.dailyHasFightBossCount
end

function NightFeastBossModel:onNightFeastBossClgLvlUpBuffRes(msg)
	local info = self:getAgentInfo(msg.activityId)

	info.buffPoint = msg.totolPoint

	local isExist = false

	for i, v in ipairs(info.buffLvl) do
		if v.id == msg.buffInfo.id then
			isExist = true
			v.lvl = msg.buffInfo.lvl
		end
	end

	if not isExist then
		local buffInfo = GameUtil.pbToTable(msg.buffInfo)

		table.insert(info.buffLvl, buffInfo)
	end
end

function NightFeastBossModel:onNightFeastBossClgResetBuffRes(msg)
	local info = self:getAgentInfo(msg.activityId)

	info.buffPoint = msg.totolPoint
	info.dailyHasResetBuffCount = info.dailyHasResetBuffCount + 1
	info.buffLvl = {}
end

function NightFeastBossModel:onNightFeastBossClgGainProgressPrizeRes(msg)
	local info = GameUtil.pbToTable(msg)
	local bossInfo = self:getBossInfo(info.activityId, info.bossId)

	if bossInfo then
		if not bossInfo.progressPrizeGainedBitId then
			if not info.dataBitId then
				local dataBitId = {}

				for _, id in ipairs(dataBitId) do
					table.insert(bossInfo.progressPrizeGainedBitId, id)
				end

				bossInfo.progressPrizeGainedBitId = bossInfo.progressPrizeGainedBitId
			end
		end
	end
end

function NightFeastBossModel:onNightFeastBossClgGetRankRes(msg)
	local info = self:getAgentInfo(msg.activityId)

	info.rankInfos = GameUtil.pbToTable(msg.rankInfos) or {}
	info.myRank = msg.myRank

	local rankInfo = GameUtil.pbToTable(msg)

	if not self._rankInfoMap[msg.activityId] then
		self._rankInfoMap[msg.activityId][msg.bossId] = rankInfo
		self._rankInfoMap[msg.activityId] = self._rankInfoMap[msg.activityId]
	end
end

function NightFeastBossModel:getActivityId()
	if self._activityId then
		return self._activityId
	end

	self._activityId = checknumber(NightFeastBossConfig.instance:getCommonValue("ACTIVITY_ID"))

	return self._activityId
end

function NightFeastBossModel:getActivityType()
	return GameEnum.ActivityType.NightFeastBoss
end

function NightFeastBossModel:getRewardProgress(activityId)
	local info = self:getAgentInfo(activityId)

	return info.totalDamage
end

function NightFeastBossModel:isPlayerRewardGeted(activityId, prizeId)
	local info = self:getAgentInfo(activityId)

	return TableUtil.isHad(info.progressPrizeGainedBitId, prizeId)
end

function NightFeastBossModel:isPlayerRewardCanGet(activityId, prizeId, progress)
	local isScoreEnough = self:getRewardProgress(activityId) >= checknumber(progress)

	return isScoreEnough and not self:isPlayerRewardGeted(activityId, prizeId)
end

function NightFeastBossModel:getRankInfos(activityId)
	local info = self:getAgentInfo(activityId)

	return info.rankInfos
end

function NightFeastBossModel:getMyRank(activityId)
	local info = self:getAgentInfo(activityId)

	return info.myRank
end

function NightFeastBossModel:isCanResetBuffPoint(activityId)
	local info = self:getAgentInfo(activityId)

	if #info.buffLvl > 0 then
		for i, v in ipairs(info.buffLvl) do
			if v.lvl > 0 then
				return true
			end
		end
	end

	return false
end

function NightFeastBossModel:todayResetBuffCount(activityId)
	local info = self:getAgentInfo(activityId)

	return info.dailyHasResetBuffCount
end

function NightFeastBossModel:getBuffLv(activityId, buffId)
	local info = self:getAgentInfo(activityId)

	for i, v in ipairs(info.buffLvl) do
		if v.id == buffId then
			return v.lvl
		end
	end

	return 0
end

function NightFeastBossModel:getDailyHasFightBossCount(activityId)
	local info = self:getAgentInfo(activityId)

	return info.dailyHasFightBossCount
end

function NightFeastBossModel:getDailyStageIds(activityId)
	local info = self:getAgentInfo(activityId)

	return info.dailyStageId
end

function NightFeastBossModel:isDailyPassedStageId(activityId, stageId)
	local info = self:getAgentInfo(activityId)

	return TableUtil.isHad(info.dailyPassedStageId, stageId)
end

function NightFeastBossModel:isPetLock(activityId, raceId)
	local info = self:getAgentInfo(activityId)

	return TableUtil.isHad(info.dailyLockedRaces, raceId)
end

function NightFeastBossModel:getNormalBattleBuffPoint(activityId)
	local info = self:getAgentInfo(activityId)

	return info.tempOldPoint, info.tempNewPoint
end

function NightFeastBossModel:getLeftBuffPoint(activityId)
	local info = self:getAgentInfo(activityId)

	return info.buffPoint
end

function NightFeastBossModel:getCurFightDamage(activityId)
	local info = self:getAgentInfo(activityId)

	return info.curFightDamage
end

function NightFeastBossModel:getTotalDamage(activityId)
	local info = self:getAgentInfo(activityId)

	return info.totalDamage
end

function NightFeastBossModel:getBaseInfo(activityId)
	local baseInfo = self._baseInfoMap[activityId]

	if not baseInfo then
		print(string.format("唐宫夜宴数据未初始化：%s", activityId))
	end

	return baseInfo
end

function NightFeastBossModel:getBossInfoMap(activityId)
	local bossInfoMap = self._bossInfoMap[activityId]

	if not bossInfoMap then
		print(string.format("唐宫夜宴Boss数据未初始化：%s", activityId))
	end

	return bossInfoMap
end

function NightFeastBossModel:getBossInfo(activityId, bossId)
	local bossInfoMap = self:getBossInfoMap(activityId)

	if bossInfoMap then
		return bossInfoMap[bossId]
	end
end

function NightFeastBossModel:getRankInfo(activityId, bossId)
	local rankInfoMap = self._rankInfoMap[activityId]

	if rankInfoMap then
		return rankInfoMap[bossId]
	end
end

NightFeastBossModel.instance = NightFeastBossModel.New()

return NightFeastBossModel
