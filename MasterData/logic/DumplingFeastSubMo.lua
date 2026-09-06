-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dumplingfeast/data/DumplingFeastSubMo.lua

module("logic.extensions.dumplingfeast.data.DumplingFeastSubMo", package.seeall)

local DumplingFeastSubMo = class("DumplingFeastSubMo")

function DumplingFeastSubMo:ctor(activityId)
	self._activityId = activityId

	local actData = DumplingFeastConfig.instance:getActivityData(activityId)

	self._dailyBossClgTimes = actData.dailyBossClgTimes
	self._potNum = actData.potNum
	self._bowlNum = actData.bowlNum
	self._maxRollDoughSeconds = actData.maxRollDoughSeconds
	self._maxStuffFillingSeconds = actData.maxStuffFillingSeconds
	self._maxBoilSeconds = actData.maxBoilSeconds
	self._feedLoveDumplingBonus = actData.feedLoveDumplingBonus
	self._oneClickMakeDumplingNeedBestTimes = actData.oneClickMakeDumplingNeedBestTimes
	self._rollDoughNeedItemMatMo = self:_getMatMo(actData.rollDoughNeedItem)
	self._stuffFillingMatMos = {}

	local dumplingDatas = DumplingFeastConfig.instance:getDumplingDatas(self._activityId) or {}

	for _, data in ipairs(dumplingDatas) do
		self._stuffFillingMatMos[data.dumplingId] = self:_getMatMo(data.stuffFillingNeedItem)
	end

	self:_resetData()
end

function DumplingFeastSubMo:_resetData()
	self._creepsIntimacyMap = {}
	self._dumplingMap = {}
	self._lasiStuffFillingDumplingId = 0
	self._potInfos = {}
	self._bowlInfos = {}
	self._lastDoughSeconds = -1
	self._lastFillingSeconds = -1
	self._hasGainMaxIntimacyProgressId = 0
	self._hasGainMaxDamageProgressId = 0
	self._todayBossClgTimes = 0
	self._maxSingleBossDamage = 0
	self._totalBossDamage = 0
end

function DumplingFeastSubMo:dispose()
	self:_resetData()
end

function DumplingFeastSubMo:_getMatMo(matStr)
	local matType, matId, matNum = MaterialMgr.getMatParams(matStr)
	local matName = MaterialMgr.getMaterialsName(matType, matId)

	return {
		matStr = matStr,
		matType = matType,
		matId = matId,
		matNum = matNum,
		matName = matName
	}
end

function DumplingFeastSubMo:handlePM_DumplingFeastInfoRes(msg)
	table.clear(self._creepsIntimacyMap)

	for _, creepsInfo in ipairs(msg.creepsInfos) do
		self._creepsIntimacyMap[creepsInfo.raceId] = creepsInfo.intimacy
	end

	table.clear(self._dumplingMap)

	for _, dumplingInfo in ipairs(msg.dumplingInfos) do
		local dumplingId = dumplingInfo.dumplingId

		self._dumplingMap[dumplingId] = {}

		for _, pair in ipairs(dumplingInfo.qualityToNum) do
			local quality = pair.left

			self._dumplingMap[dumplingId][quality] = pair.right
		end
	end

	table.clear(self._potInfos)

	for _, v in ipairs(msg.potInfo) do
		local info = {}

		info.potId = v.potId
		info.dumplingId = v.dumplingId
		info.boilDumplingTime = checknumber(v.lastBoilTime)
		self._potInfos[info.potId] = info
	end

	table.clear(self._bowlInfos)

	for _, v in ipairs(msg.bowlInfos) do
		local info = {}

		info.bowlId = v.bowlId
		info.dumplingId = v.dumplingIdToQuality.left
		info.quality = v.dumplingIdToQuality.right
		self._bowlInfos[info.bowlId] = info
	end

	self._lastDoughSeconds = msg.lastDoughSeconds
	self._lastFillingSeconds = msg.lastFillingSeconds
	self._hasGainMaxIntimacyProgressId = msg.hasGainMaxIntimacyProgressId
	self._todayBossClgTimes = msg.todayBossClgTimes
	self._maxSingleBossDamage = checknumber(msg.maxSingleBossDamage)
	self._totalBossDamage = checknumber(msg.totalBossDamage)
	self._hasGainMaxDamageProgressId = msg.hasGainMaxDamageProgressId
	self._lasiStuffFillingDumplingId = msg.lasiStuffFillingDumplingId
	self._hasMakeBestDumplingTimes = msg.hasMakeBestDumplingTimes
end

function DumplingFeastSubMo:handlePM_DumplingFeastRollDoughRes(msg)
	self._lastDoughSeconds = msg.seconds
end

function DumplingFeastSubMo:handlePM_DumplingFeastStuffFillingRes(msg)
	self._lastFillingSeconds = msg.seconds
	self._lasiStuffFillingDumplingId = msg.fillingId
end

function DumplingFeastSubMo:handlePM_DumplingFeastBoilDumplingRes(msg)
	local potId = msg.potId

	if not self._potInfos[potId] then
		self._potInfos[potId].potId = potId
		self._potInfos[potId].dumplingId = msg.dumplingId
		self._potInfos[potId].boilDumplingTime = checknumber(msg.boilDumplingTime)
		self._potInfos[potId] = self._potInfos[potId]
		self._lasiStuffFillingDumplingId = 0
	end
end

function DumplingFeastSubMo:handlePM_DumplingFeastTakeOutDumplingRes(msg)
	local potId = msg.potId
	local potInfo = self._potInfos[potId]

	if potInfo then
		potInfo.dumplingId = 0
		potInfo.boilDumplingTime = -1
	end

	local bowlId = msg.bowlId

	if not self._bowlInfos[bowlId] then
		self._bowlInfos[bowlId].dumplingId = msg.dumplingId
		self._bowlInfos[bowlId].quality = msg.quality
		self._bowlInfos[bowlId] = self._bowlInfos[bowlId]

		local maxQuality = DumplingFeastConfig.instance:getMaxQuality(self._activityId)

		if msg.quality == maxQuality then
			self._hasMakeBestDumplingTimes = self._hasMakeBestDumplingTimes + 1
		end
	end
end

function DumplingFeastSubMo:handlePM_DumplingFeastGainDumplingRes(msg)
	self._bowlInfos[msg.bowlId] = nil

	local dumplingId = msg.dumplingId
	local quality = msg.quality

	self._dumplingMap[dumplingId] = self._dumplingMap[dumplingId] or {}
	self._dumplingMap[dumplingId][quality] = (self._dumplingMap[dumplingId][quality] or 0) + 1
end

function DumplingFeastSubMo:handlePM_DumplingFeastFeedRes(msg)
	for _, v in ipairs(msg.dumplingIdToQuality) do
		local dumplingId = v.left
		local quality = v.right

		self._dumplingMap[dumplingId] = self._dumplingMap[dumplingId] or {}
		self._dumplingMap[dumplingId][quality] = self._dumplingMap[dumplingId][quality] or 0

		local curNum = self._dumplingMap[dumplingId][quality]

		self._dumplingMap[dumplingId][quality] = Mathf.Max(0, curNum - 1)
	end

	local raceId = msg.raceId

	self._creepsIntimacyMap[raceId] = msg.intimacy
end

function DumplingFeastSubMo:handlePM_DumplingFeastGainDamageProgressRes(msg)
	self._hasGainMaxDamageProgressId = msg.maxGainProgressId
end

function DumplingFeastSubMo:handlePM_DumplingFeastGainIntimacyProgressRes(msg)
	self._hasGainMaxIntimacyProgressId = msg.maxGainProgressId
end

function DumplingFeastSubMo:handlePM_DumplingFeastBossClgRes(msg)
	return
end

function DumplingFeastSubMo:handlePM_DumplingFeastNotifyBossClgRes(msg)
	if not msg.isTrial then
		local damage = checknumber(msg.damage)

		self._todayBossClgTimes = self._todayBossClgTimes + 1
		self._totalBossDamage = self._totalBossDamage + damage
		self._maxSingleBossDamage = Mathf.Max(self._maxSingleBossDamage, damage)
	end
end

function DumplingFeastSubMo:handlePM_DumplingFeastRankViewRes(msg)
	return
end

function DumplingFeastSubMo:handlePM_DumplingFeastOneClickMakeDumplingRes(msg)
	local dumplingId = msg.dumplingIdToQuality.left
	local quality = msg.dumplingIdToQuality.right
	local num = msg.num

	self._dumplingMap[dumplingId] = self._dumplingMap[dumplingId] or {}
	self._dumplingMap[dumplingId][quality] = (self._dumplingMap[dumplingId][quality] or 0) + num
end

function DumplingFeastSubMo:getPotNum()
	return self._potNum
end

function DumplingFeastSubMo:getBowlNum()
	return self._bowlNum
end

function DumplingFeastSubMo:getMaxRollDoughSeconds()
	return self._maxRollDoughSeconds
end

function DumplingFeastSubMo:getMaxStuffFillingSeconds()
	return self._maxStuffFillingSeconds
end

function DumplingFeastSubMo:getMaxBoilSeconds()
	return self._maxBoilSeconds
end

function DumplingFeastSubMo:getFeedLoveDumplingBonus()
	return self._feedLoveDumplingBonus
end

function DumplingFeastSubMo:getOneClickMakeDumplingNeedBestTimes()
	return self._oneClickMakeDumplingNeedBestTimes
end

function DumplingFeastSubMo:getRollDoughNeedItemMatMo()
	return self._rollDoughNeedItemMatMo
end

function DumplingFeastSubMo:getStuffFillingMatMo(dumplingId)
	return self._stuffFillingMatMos[dumplingId]
end

function DumplingFeastSubMo:getStuffFillingNeedItemNum(dumplingId)
	local stuffingMatMo = self:getStuffFillingMatMo(dumplingId)

	return (stuffingMatMo or nil) and (stuffingMatMo.matNum or 0)
end

function DumplingFeastSubMo:getStuffFillingNeedItemHaveNum(dumplingId)
	local matMo = self:getStuffFillingMatMo(dumplingId)

	return matMo and MaterialModel.instance:getMaterialsNumber(matMo.matType, matMo.matId) or 0
end

function DumplingFeastSubMo:isEnoughStuffFillingNeedItem(dumplingId)
	local needNum = self:getStuffFillingNeedItemNum(dumplingId)
	local haveNum = self:getStuffFillingNeedItemHaveNum(dumplingId)

	return needNum <= haveNum
end

function DumplingFeastSubMo:getCreepsIntimacy(raceId)
	return self._creepsIntimacyMap[raceId] or 0
end

function DumplingFeastSubMo:getAllCreepsIntimacy()
	return self._creepsIntimacyMap
end

function DumplingFeastSubMo:getTotalIntimacy()
	local result = 0

	for _, intimacy in pairs(self._creepsIntimacyMap) do
		result = result + intimacy
	end

	return result
end

function DumplingFeastSubMo:isHasGainPrizeInIntimacy(progressId)
	return progressId <= self._hasGainMaxIntimacyProgressId
end

function DumplingFeastSubMo:isEnoughGetPrizeInIntimacy(progressId)
	local data = DumplingFeastConfig.instance:getIntimacyProgressData(self._activityId, progressId)

	if data then
		if not data.intimacy then
			local intimacy = 0
			local totalIntimacy = self:getTotalIntimacy()

			return intimacy <= totalIntimacy
		end
	end
end

function DumplingFeastSubMo:isCanGetPrizeInIntimacy(progressId)
	return not self:isHasGainPrizeInIntimacy(progressId) and self:isEnoughGetPrizeInIntimacy(progressId)
end

function DumplingFeastSubMo:calculateSingleDumplingIntimacy(dumplingId, quality, creepsId)
	local petData = DumplingFeastConfig.instance:getSupportPetData(self._activityId, creepsId)
	local isLove = petData and petData.loveDumpling and table.indexof(petData.loveDumpling, dumplingId) ~= false or false
	local qualityData = DumplingFeastConfig.instance:getQualityData(self._activityId, quality)

	if qualityData then
		if not qualityData.intimacy then
			local intimacy = 0

			return isLove and self._feedLoveDumplingBonus * intimacy or intimacy
		end
	end
end

function DumplingFeastSubMo:getLastStuffFillingDumplingId()
	return self._lasiStuffFillingDumplingId
end

function DumplingFeastSubMo:getDumplingQualityNum(dumplingId, quality)
	local qualityMap = self._dumplingMap[dumplingId]

	return (qualityMap or nil) and (qualityMap[quality] or 0)
end

function DumplingFeastSubMo:getDumplingTotalNum(dumplingId)
	local total = 0
	local qualityMap = self._dumplingMap[dumplingId]

	if qualityMap then
		for _, num in pairs(qualityMap) do
			total = total + num
		end
	end

	return total
end

function DumplingFeastSubMo:getAllDumplings()
	return self._dumplingMap
end

function DumplingFeastSubMo:getEmptyPotList()
	local list = {}

	for potId = 1, self._potNum do
		if self:isEmptyPot(potId) then
			table.insert(list, potId)
		end
	end

	return list
end

function DumplingFeastSubMo:isEmptyPot(potId)
	local time = self:getPotDumplingBoilTime(potId)

	return time < 0
end

function DumplingFeastSubMo:getPotDumplingId(potId)
	local info = self:getPotInfo(potId)

	return (info or nil) and (info.dumplingId or 0)
end

function DumplingFeastSubMo:getPotDumplingBoilTime(potId)
	local info = self:getPotInfo(potId)

	return (info or nil) and (info.boilDumplingTime or -1)
end

function DumplingFeastSubMo:getPotInfo(potId)
	return self._potInfos[potId]
end

function DumplingFeastSubMo:getAllPots()
	return self._potInfos
end

function DumplingFeastSubMo:getEmptyBowlList()
	local list = {}

	for bowlId = 1, self._bowlNum do
		if self:isEmptyBowl(bowlId) then
			table.insert(list, bowlId)
		end
	end

	return list
end

function DumplingFeastSubMo:isEmptyBowl(bowlId)
	local dumplingId = self:getBowlDumplingId(bowlId)

	return dumplingId <= 0
end

function DumplingFeastSubMo:getBowlDumplingId(bowlId)
	local info = self:getBowlInfo(bowlId)

	return (info or nil) and (info.dumplingId or 0)
end

function DumplingFeastSubMo:getBowlDumplingQuality(bowlId)
	local info = self:getBowlInfo(bowlId)

	return (info or nil) and (info.quality or 0)
end

function DumplingFeastSubMo:getBowlInfo(bowlId)
	return self._bowlInfos[bowlId]
end

function DumplingFeastSubMo:getLastDoughSeconds()
	return self._lastDoughSeconds
end

function DumplingFeastSubMo:getLastFillingSeconds()
	return self._lastFillingSeconds
end

function DumplingFeastSubMo:getHasGainMaxIntimacyProgressId()
	return self._hasGainMaxIntimacyProgressId
end

function DumplingFeastSubMo:getHasGainMaxDamageProgressId()
	return self._hasGainMaxDamageProgressId
end

function DumplingFeastSubMo:isEnoughBossClgTimes()
	return self._todayBossClgTimes < self._dailyBossClgTimes
end

function DumplingFeastSubMo:getTodayBossClgTimes()
	return self._todayBossClgTimes
end

function DumplingFeastSubMo:getDailyBossClgTimes()
	return self._dailyBossClgTimes
end

function DumplingFeastSubMo:getMaxSingleBossDamage()
	return self._maxSingleBossDamage
end

function DumplingFeastSubMo:getTotalBossDamage()
	return self._totalBossDamage
end

function DumplingFeastSubMo:isHasGainPrizeInDamage(progressId)
	return progressId <= self._hasGainMaxDamageProgressId
end

function DumplingFeastSubMo:isEnoughGetPrizeInDamage(progressId)
	local data = DumplingFeastConfig.instance:getDamageProgressData(self._activityId, progressId)
	local damage = checknumber(data and data.damage)

	return damage <= self._totalBossDamage
end

function DumplingFeastSubMo:isCanGetPrizeInDamage(progressId)
	return not self:isHasGainPrizeInDamage(progressId) and self:isEnoughGetPrizeInDamage(progressId)
end

function DumplingFeastSubMo:getHasMakeBestDumplingTimes()
	return self._hasMakeBestDumplingTimes
end

function DumplingFeastSubMo:isCanOpenOneClickMake()
	local hasMakeBestTimes = self:getHasMakeBestDumplingTimes()

	return hasMakeBestTimes >= self._oneClickMakeDumplingNeedBestTimes
end

return DumplingFeastSubMo
