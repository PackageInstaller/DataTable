-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/model/MartialContestModel.lua

module("logic.extensions.martialcontest.model.MartialContestModel", package.seeall)

local MartialContestModel = class("MartialContestModel", BaseModel)

MartialContestModel.ReadFlag = "MartialContestModel.ReadFlag"

function MartialContestModel:ctor()
	return
end

function MartialContestModel:onInit()
	self:onReset()

	self._msgInfos = {}
end

function MartialContestModel:onReset()
	self._finalsInfo = nil
	self._finalsInfoMsg = nil
	self._stepFightInfo = {}
	self._qualifierInfo = {}
	self._qualifierDefenseFmtMo = nil
	self._sourceDefenseFmtMo = nil
	self._finalDefenseFmtMo = nil
	self._scoreFmtMo = nil
	self._qualifierFmtMo = nil
	self._equipInfo = {}
	self._defenseFormationInfo = {}
	self._finalFormationInfo = {}
	self._qualifierRecord = {}
	self._qualifierRecordHistoryBestWinStreak = {}
end

function MartialContestModel:saveInfo(msg)
	self._msgInfos[msg.activityId] = GameUtil.pbToTable(msg)
	self._msgInfos[msg.activityId].stepList = self._msgInfos[msg.activityId].stepList or {}

	local data = GameUtil.pbToTable(msg)
	local infoMap = {}

	if data.stepList then
		for i, v in ipairs(data.stepList) do
			infoMap[v.stepId] = v
		end
	end

	self._stepFightInfo[msg.activityId] = infoMap
end

function MartialContestModel:getInfo(activityId)
	return self._msgInfos[activityId]
end

function MartialContestModel:onMCFinalsInfoRes(msg)
	self._finalsInfoMsg = msg
	self._finalsInfo = msg.info
end

function MartialContestModel:getFinalsInfo()
	return self._finalsInfo
end

function MartialContestModel:getFinalsInfoMsg()
	return self._finalsInfoMsg
end

function MartialContestModel:getFinalsBuffIds(activityId)
	local info = self:getFinalFormation(activityId)

	if not info then
		return {}
	end

	return info.buffIds
end

function MartialContestModel:getFightTime(activityId, stepId)
	if self._stepFightInfo[activityId] and self._stepFightInfo[activityId][stepId] then
		return self._stepFightInfo[activityId][stepId].fightTimes
	end

	return 0
end

function MartialContestModel:getCurStepId(activityId)
	if self._msgInfos[activityId] then
		return self._msgInfos[activityId].curStepId
	end

	return 1
end

function MartialContestModel:getQualifierDefenseFmtMo()
	self._qualifierDefenseFmtMo = self._qualifierDefenseFmtMo or MartialContestQualifierDefenseFmtMo.New()

	return self._qualifierDefenseFmtMo
end

function MartialContestModel:getScoreDefenseFmtMo()
	self._sourceDefenseFmtMo = self._sourceDefenseFmtMo or MartialContestScoreDefenseFmtMo.New()

	return self._sourceDefenseFmtMo
end

function MartialContestModel:getFinalDefenseFmtMo()
	self._finalDefenseFmtMo = self._finalDefenseFmtMo or MartialContestFinalDefenseFmtMo.New()

	return self._finalDefenseFmtMo
end

function MartialContestModel:getQualifierFmtMo()
	self._qualifierFmtMo = self._qualifierFmtMo or MartialContestQualifierFmtMo.New()

	return self._qualifierFmtMo
end

function MartialContestModel:getScoreFmtMo()
	self._scoreFmtMo = self._scoreFmtMo or MartialContestScoreFmtMo.New()

	return self._scoreFmtMo
end

function MartialContestModel:saveQualifierInfo(msg)
	self._qualifierInfo[msg.activityId] = self._qualifierInfo[msg.activityId] or {}
	self._qualifierInfo[msg.activityId][msg.stepId] = msg
end

function MartialContestModel:getQualifierInfo(activityId, stepId)
	if self._qualifierInfo[activityId] then
		return self._qualifierInfo[activityId][stepId]
	end
end

function MartialContestModel:getQualifierFightTime(activityId, stepId)
	if self._qualifierInfo[activityId] and self._qualifierInfo[activityId][stepId] then
		return self._qualifierInfo[activityId][stepId].dailyFightTimes
	end

	return 0
end

function MartialContestModel:getEquipLevel(activityId, equipId)
	if self._equipInfo[activityId] then
		return self._equipInfo[activityId][equipId] or 0
	end

	return 0
end

function MartialContestModel:saveEquipInfo(msg)
	local data = GameUtil.pbToTable(msg)

	self._equipInfo[data.activityId] = self._equipInfo[data.activityId] or {}

	if data.equips then
		for i, v in ipairs(data.equips) do
			self._equipInfo[data.activityId][v.equipId] = v.level
		end
	end
end

function MartialContestModel:saveEquipUpgrade(msg)
	local data = GameUtil.pbToTable(msg)

	self._equipInfo[data.activityId] = self._equipInfo[data.activityId] or {}
	self._equipInfo[data.activityId][data.equipId] = self._equipInfo[data.activityId][data.equipId] and self._equipInfo[data.activityId][data.equipId] + 1 or 1
end

function MartialContestModel:saveDefenseForamtion(msg)
	self._defenseFormationInfo[msg.activityId] = GameUtil.pbToTable(msg)
end

function MartialContestModel:getDefenseForamtion(activityId)
	return self._defenseFormationInfo[activityId]
end

function MartialContestModel:saveOpponent(msg)
	if self._qualifierInfo[msg.activityId] and self._qualifierInfo[msg.activityId][msg.stepId] then
		self._qualifierInfo[msg.activityId][msg.stepId].opponent:ParseFromString(msg.opponent:SerializeToString())
	end
end

function MartialContestModel:saveFinalFormation(msg)
	self._finalFormationInfo[msg.activityId] = GameUtil.pbToTable(msg)
end

function MartialContestModel:getFinalFormation(activityId)
	return self._finalFormationInfo[activityId]
end

function MartialContestModel:saveQualifierBattleInfo(msg)
	self._qualifierInfo[msg.activityId] = self._qualifierInfo[msg.activityId] or {}
	self._qualifierInfo[msg.activityId][msg.stepId] = self._qualifierInfo[msg.activityId][msg.stepId] or {}

	local info = self._qualifierInfo[msg.activityId][msg.stepId]

	info.dailyFightTimes = msg.dailyFightTimes
	info.winStreak = msg.winStreak
	info.rankScore = msg.score

	info.opponent:ParseFromString("")

	if self._stepFightInfo[msg.activityId] and self._stepFightInfo[msg.activityId][msg.stepId] then
		self._stepFightInfo[msg.activityId][msg.stepId].fightTimes = msg.dailyFightTimes
	end
end

function MartialContestModel:saveBattleScoreWithOldAndNew(battleMsg, oldScore)
	self._tempBattleResult = GameUtil.pbToTable(battleMsg)
	self._tempOldScore = oldScore
end

function MartialContestModel:getBattleScoreWithOldAndNew()
	return checknumber(self._tempOldScore), checknumber(self._tempBattleResult.score)
end

function MartialContestModel:getTempBattleResult()
	return self._tempBattleResult
end

function MartialContestModel:saveRecordInfo(msg)
	self._qualifierRecord[msg.activityId] = {}
	self._qualifierRecordHistoryBestWinStreak[msg.activityId] = {}

	if msg.records then
		for i, v in ipairs(msg.records) do
			self._qualifierRecord[msg.activityId][msg.stepId] = self._qualifierRecord[msg.activityId][msg.stepId] or {}

			table.insert(self._qualifierRecord[msg.activityId][msg.stepId], v)
		end
	end

	self._qualifierRecordHistoryBestWinStreak[msg.activityId][msg.stepId] = msg.historyBestWinStreak
end

function MartialContestModel:getRecordNos(activityId, stepId)
	if self._qualifierRecord[activityId] then
		return self._qualifierRecord[activityId][stepId] or {}
	end

	return {}
end

function MartialContestModel:getHistoryBestWinStreak(activityId, stepId)
	if self._qualifierRecordHistoryBestWinStreak[activityId] then
		return self._qualifierRecordHistoryBestWinStreak[activityId][stepId] or 0
	end

	return 0
end

function MartialContestModel:getPrizeLimitDailyTips()
	local dataKey = string.format("%s#daily", MartialContestModel.ReadFlag)

	GameUtil.getUserDayData(dataKey)
end

function MartialContestModel:savePrizeLimitDailyTips()
	local dataKey = string.format("%s#daily", MartialContestModel.ReadFlag)

	GameUtil.saveUserDayData(dataKey, true)
end

MartialContestModel.instance = MartialContestModel.New()

return MartialContestModel
