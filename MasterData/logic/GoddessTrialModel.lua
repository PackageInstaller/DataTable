-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesstrial/model/GoddessTrialModel.lua

module("logic.extensions.goddesstrial.model.GoddessTrialModel", package.seeall)

local GoddessTrialModel = class("GoddessTrialModel", BaseModel)

function GoddessTrialModel:onInit()
	self:onReset()
end

function GoddessTrialModel:onReset()
	self._normalFmtMo = nil
	self._superFmtMo = nil
	self._bossFmtMo = nil
	self._infos = {}
	self._stepInfo = {}
	self._prizeGainMap = {}
end

function GoddessTrialModel:getNormalFmtMo()
	self._normalFmtMo = self._normalFmtMo or GoddessTrialNormalFmtMo.New()

	return self._normalFmtMo
end

function GoddessTrialModel:getSuperFmtMo()
	self._superFmtMo = self._superFmtMo or GoddessTrialSuperFmtMo.New()

	return self._superFmtMo
end

function GoddessTrialModel:getBossFmtMo()
	self._bossFmtMo = self._bossFmtMo or GoddessTrialBossFmtMo.New()

	return self._bossFmtMo
end

function GoddessTrialModel:saveInfo(msg)
	local data = GameUtil.pbToTable(msg)

	self._infos[data.activityId] = data

	local stepInfo = {}

	if data.stepList then
		for i, v in ipairs(data.stepList) do
			stepInfo[v.stepId] = v
			stepInfo[v.stepId].superStageInfoMap = {}

			if v.superStageId2HistoryMaxScore then
				for j, superStageInfo in ipairs(v.superStageId2HistoryMaxScore) do
					stepInfo[v.stepId].superStageInfoMap[superStageInfo.left] = superStageInfo.right
				end
			end
		end
	end

	self._stepInfo[data.activityId] = stepInfo

	local prizeGainMap = {}

	if data.gainPrizeIds then
		for i, v in ipairs(data.gainPrizeIds) do
			prizeGainMap[v] = true
		end
	end

	self._prizeGainMap[data.activityId] = prizeGainMap
end

function GoddessTrialModel:getPassNormalStageId(activityId, stepId)
	if self._stepInfo[activityId] and self._stepInfo[activityId][stepId] then
		return self._stepInfo[activityId][stepId].maxPassNormalStageId
	end

	return 0
end

function GoddessTrialModel:isSuperStagePass(activityId, stepId, stageId)
	if self._stepInfo[activityId] and self._stepInfo[activityId][stepId] then
		return self._stepInfo[activityId][stepId].superStageInfoMap[stageId] ~= nil
	end

	return false
end

function GoddessTrialModel:getSuperStageScore(activityId, stepId, stageId)
	if self._stepInfo[activityId] and self._stepInfo[activityId][stepId] then
		return checknumber(self._stepInfo[activityId][stepId].superStageInfoMap[stageId])
	end

	return 0
end

function GoddessTrialModel:getCurStepId(activityId)
	if self._infos[activityId] then
		return self._infos[activityId].stepId
	end

	return 0
end

function GoddessTrialModel:saveRankInfo(msg)
	self._rankInfo = GameUtil.pbToTable(msg)
end

function GoddessTrialModel:getRankInfo()
	return self._rankInfo
end

function GoddessTrialModel:saveNormalBattleInfo(msg)
	local data = GameUtil.pbToTable(msg)

	if self._stepInfo[data.activityId] then
		local stepInfo = self._stepInfo[data.activityId][data.option.stepId]

		if not stepInfo then
			stepInfo = {
				stepId = data.option.stepId
			}
			stepInfo.maxPassNormalStageId = 0
			stepInfo.superStageInfoMap = {}
			stepInfo.totalBossScore = 0
			self._stepInfo[data.activityId][data.option.stepId] = stepInfo
		end

		stepInfo.maxPassNormalStageId = data.maxPassNormalStageId
	end
end

function GoddessTrialModel:saveSuperBattleInfo(msg)
	local data = GameUtil.pbToTable(msg)

	if self._stepInfo[data.activityId] then
		local stepInfo = self._stepInfo[data.activityId][data.option.stepId]

		if not stepInfo then
			stepInfo = {
				stepId = data.option.stepId
			}
			stepInfo.maxPassNormalStageId = 0
			stepInfo.superStageInfoMap = {}
			stepInfo.totalBossScore = 0
			self._stepInfo[data.activityId][data.option.stepId] = stepInfo
		end

		stepInfo.superStageInfoMap[data.option.stageId] = data.historyMaxScore
	end
end

function GoddessTrialModel:saveTempSuperBattleResult(msg)
	self._tempResult = GameUtil.pbToTable(msg)
end

function GoddessTrialModel:getTempSuperBattleResult()
	return self._tempResult
end

function GoddessTrialModel:clearTempSuperBattleResult()
	self._tempResult = nil
end

function GoddessTrialModel:getTodayFightBossTimes(activityId)
	if self._infos[activityId] then
		return self._infos[activityId].todayFightBossTimes
	end

	return 0
end

function GoddessTrialModel:getTodayFightBossDamage(activityId)
	if self._infos[activityId] then
		return checknumber(self._infos[activityId].todayMaxBossDamage)
	end

	return 0
end

function GoddessTrialModel:saveBossBattleInfo(msg)
	local data = GameUtil.pbToTable(msg)

	if self._infos[msg.activityId] then
		local info = self._infos[msg.activityId]

		info.todayFightBossTimes = msg.todayFightBossTimes
		info.todayMaxBossDamage = msg.todayMaxBossDamage

		local stepInfo = self._stepInfo[data.activityId][data.option.stepId]

		if not stepInfo then
			stepInfo = {
				stepId = data.option.stepId
			}
			stepInfo.maxPassNormalStageId = 0
			stepInfo.superStageInfoMap = {}
			stepInfo.totalBossScore = 0
			self._stepInfo[data.activityId][data.option.stepId] = stepInfo
		end

		stepInfo.totalBossScore = data.totalBossScore
	end
end

function GoddessTrialModel:getTotalBossScore(activityId, stepId)
	if self._stepInfo[activityId] and self._stepInfo[activityId][stepId] then
		return checknumber(self._stepInfo[activityId][stepId].totalBossScore)
	end

	return 0
end

function GoddessTrialModel:saveTempBossBattleResult(msg)
	self._tempBossResult = GameUtil.pbToTable(msg)
end

function GoddessTrialModel:getTempBossBattleResult()
	return self._tempBossResult
end

function GoddessTrialModel:clearTempBossBattleResult()
	self._tempBossResult = nil
end

function GoddessTrialModel:isGainPrize(activityId, prizeId)
	if self._prizeGainMap[activityId] then
		return self._prizeGainMap[activityId][prizeId] or false
	end

	return false
end

function GoddessTrialModel:savePrizeInfo(msg)
	self._prizeGainMap[msg.activityId] = self._prizeGainMap[msg.activityId] or {}

	if msg.prizeIds then
		for i, v in ipairs(msg.prizeIds) do
			self._prizeGainMap[msg.activityId][v] = true
		end
	end
end

GoddessTrialModel.instance = GoddessTrialModel.New()

return GoddessTrialModel
