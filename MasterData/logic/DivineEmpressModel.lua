-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineempress/model/DivineEmpressModel.lua

module("logic.extensions.divineempress.model.DivineEmpressModel", package.seeall)

local DivineEmpressModel = class("DivineEmpressModel", BaseModel)

DivineEmpressModel.ReadFlag = "DivineEmpressModel.ReadFlag"

function DivineEmpressModel:ctor()
	return
end

function DivineEmpressModel:onInit()
	self:onReset()
end

function DivineEmpressModel:onReset()
	self._extraFmtMo = nil
	self._normalFmtMo = nil
	self._info = {}
	self._extremeInfo = {}
	self._normalInfo = {}
end

function DivineEmpressModel:saveInfo(msg)
	local data = GameUtil.pbToTable(msg)
	local activityId = msg.extremeInfo.activityId

	self._info[activityId] = data

	local extremeInfo = {}
	local extremeStageInfo = {}
	local buffInfo = {}
	local debuffInfo = {}

	if data.extremeInfo.extremeStageInfo then
		for i, v in ipairs(data.extremeInfo.extremeStageInfo) do
			extremeStageInfo[v.stageId] = v

			if v.usedPositiveBuffId ~= 0 then
				buffInfo[v.usedPositiveBuffId] = v.stageId
			end

			if v.usedNegativeBuffId ~= 0 then
				debuffInfo[v.usedNegativeBuffId] = v.stageId
			end
		end
	end

	extremeInfo.stageInfo = extremeStageInfo
	extremeInfo.buffInfo = buffInfo
	extremeInfo.debuffInfo = debuffInfo

	local lockRaceMap = {}

	if data.extremeInfo.lockRaceIds then
		for i, v in ipairs(data.extremeInfo.lockRaceIds) do
			lockRaceMap[v] = true
		end
	end

	extremeInfo.lockRaceMap = lockRaceMap

	local stagePass = {}

	if data.extremeInfo.hasPassStageIds then
		for i, v in ipairs(data.extremeInfo.hasPassStageIds) do
			stagePass[v] = true
		end
	end

	extremeInfo.stagePass = stagePass
	self._extremeInfo[activityId] = extremeInfo

	local normalInfo = {}
	local gainPirze = {}

	if data.commonInfo.gainProgressPrizeIds then
		for i, v in ipairs(data.commonInfo.gainProgressPrizeIds) do
			gainPirze[v] = true
		end
	end

	normalInfo.prizeMap = gainPirze

	local normalStageInfo = {}

	if data.commonInfo.normalStageInfo then
		for i, v in ipairs(data.commonInfo.normalStageInfo) do
			normalStageInfo[v.stageId] = v
		end
	end

	normalInfo.stageInfo = normalStageInfo
	self._normalInfo[activityId] = normalInfo
end

function DivineEmpressModel:saveExtremeInfo(msg)
	local info = self._extremeInfo[msg.activityId]

	for i, v in ipairs(msg.banRaceIds) do
		info.lockRaceMap[v] = true
	end

	local stageInfo = {}

	stageInfo.stageId = msg.stageId
	stageInfo.usedPositiveBuffId = msg.positiveBuffId
	stageInfo.usedNegativeBuffId = msg.negativeBuffId
	stageInfo.banRaceIds = msg.banRaceIds
	info.stageInfo[msg.stageId] = stageInfo

	for i, v in ipairs(stageInfo.banRaceIds) do
		info.lockRaceMap[v] = true
	end

	info.buffInfo[msg.positiveBuffId] = msg.stageId
	info.debuffInfo[msg.negativeBuffId] = msg.stageId
	info.stagePass[msg.stageId] = true

	if msg.changeSetId and self._info[msg.activityId] and self._info[msg.activityId].extremeInfo then
		self._info[msg.activityId].extremeInfo.isPassExtremeClg = true
	end
end

function DivineEmpressModel:saveExtremeResetInfo(msg)
	local info = self._extremeInfo[msg.activityId]
	local stageInfo = info.stageInfo[msg.stageId]

	info.buffInfo[stageInfo.usedPositiveBuffId] = nil
	info.debuffInfo[stageInfo.usedNegativeBuffId] = nil

	for i, v in ipairs(stageInfo.banRaceIds) do
		info.lockRaceMap[v] = nil
	end

	stageInfo.usedPositiveBuffId = 0
	stageInfo.usedNegativeBuffId = 0
	stageInfo.banRaceIds = nil
	info.stagePass[msg.stageId] = nil
end

function DivineEmpressModel:saveResetDailyBuff(msg)
	local stageInfo = self._normalInfo[msg.activityId].stageInfo

	stageInfo[msg.stageId].buffId = msg.buffId

	if self._info[msg.activityId] and self._info[msg.activityId].commonInfo then
		self._info[msg.activityId].commonInfo.leftDailyResetTimes = msg.todayLeftResetTimes
	end
end

function DivineEmpressModel:saveNormalClgInfo(msg)
	local stageInfo = self:getNormalStageInfo(msg.activityId, msg.stageId)

	if stageInfo.immunityTimes < msg.sumImmunityTimes then
		stageInfo.immunityTimes = msg.sumImmunityTimes
	end

	if self._info[msg.activityId] and self._info[msg.activityId].commonInfo then
		self._info[msg.activityId].commonInfo.sumimmunityTimes = msg.maxImmunityTimes
	end
end

function DivineEmpressModel:saveNormalClgGainPrize(msg)
	local prizeMap = {}

	for i, v in ipairs(msg.hasGainProgressPrizeIds) do
		prizeMap[v] = true
	end

	self._normalInfo[msg.activityId].prizeMap = prizeMap
end

function DivineEmpressModel:isBuffUsed(activityId, buffId)
	if self._extremeInfo[activityId] then
		return checknumber(self._extremeInfo[activityId].buffInfo[buffId]) ~= 0
	end

	return false
end

function DivineEmpressModel:isDebuffUsed(activityId, buffId)
	if self._extremeInfo[activityId] then
		return checknumber(self._extremeInfo[activityId].debuffInfo[buffId]) ~= 0
	end

	return false
end

function DivineEmpressModel:getBuffUseBy(activityId, buffId)
	if self._extremeInfo[activityId] then
		return checknumber(self._extremeInfo[activityId].buffInfo[buffId])
	end

	return 0
end

function DivineEmpressModel:getDebuffUseBy(activityId, buffId)
	if self._extremeInfo[activityId] then
		return checknumber(self._extremeInfo[activityId].debuffInfo[buffId])
	end

	return 0
end

function DivineEmpressModel:isRaceLock(activityId, raceId)
	if self._extremeInfo[activityId] then
		return self._extremeInfo[activityId].lockRaceMap[raceId]
	end
end

function DivineEmpressModel:getExtremeStageInfo(activityId, stageId)
	if self._extremeInfo[activityId] then
		return self._extremeInfo[activityId].stageInfo[stageId]
	end
end

function DivineEmpressModel:getExtremeStagePass(activityId, stageId)
	if self._extremeInfo[activityId] then
		return self._extremeInfo[activityId].stagePass[stageId]
	end

	return false
end

function DivineEmpressModel:isPassExtremeClg(activityId)
	if self._info[activityId] and self._info[activityId].extremeInfo then
		return self._info[activityId].extremeInfo.isPassExtremeClg
	end

	return false
end

function DivineEmpressModel:getExtraFmtMo()
	self._extraFmtMo = self._extraFmtMo or DivineEmpressExtraFmtMo.New()

	return self._extraFmtMo
end

function DivineEmpressModel:getNormalFmtMo()
	self._normalFmtMo = self._normalFmtMo or DivineEmpressNormalFmtMo.New()

	return self._normalFmtMo
end

function DivineEmpressModel:getNormalScore(activityId)
	if self._info[activityId] and self._info[activityId].commonInfo then
		return self._info[activityId].commonInfo.sumimmunityTimes
	end

	return false
end

function DivineEmpressModel:isNormalGainPrize(activityId, progressId)
	if self._normalInfo[activityId] then
		return self._normalInfo[activityId].prizeMap[progressId]
	end
end

function DivineEmpressModel:getNormalStageInfo(activityId, stageId)
	if self._normalInfo[activityId] then
		return self._normalInfo[activityId].stageInfo[stageId]
	end
end

function DivineEmpressModel:getLeftDailyResetTimes(activityId)
	if self._info[activityId] and self._info[activityId].commonInfo then
		return self._info[activityId].commonInfo.leftDailyResetTimes
	end

	return false
end

function DivineEmpressModel:saveSelectStageId(stageId)
	self._tempSelectStageId = stageId
end

function DivineEmpressModel:getSelectStageId()
	return self._tempSelectStageId
end

function DivineEmpressModel:saveTempBattleResult(result)
	result = result and GameUtil.pbToTable(result)
	self._tempBattleResult = result
end

function DivineEmpressModel:getTempBattleResult()
	return self._tempBattleResult
end

function DivineEmpressModel:saveTempChangeSetId(changeSetId)
	self._tempChangeSetId = changeSetId
end

function DivineEmpressModel:getTempChangeSetId()
	return self._tempChangeSetId
end

function DivineEmpressModel:getShowNormalClgDailyEffect(activityId, stageId)
	local key = string.format("%sDailyEffect#%d#%d", DivineEmpressModel.ReadFlag, activityId, stageId)

	return GameUtil.getUserDayData(key)
end

function DivineEmpressModel:saveShowNormalClgDailyEffect(activityId, stageId)
	local key = string.format("%sDailyEffect#%d#%d", DivineEmpressModel.ReadFlag, activityId, stageId)

	GameUtil.saveUserDayData(key, true)
end

DivineEmpressModel.instance = DivineEmpressModel.New()

return DivineEmpressModel
