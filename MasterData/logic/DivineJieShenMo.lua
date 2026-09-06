-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinejieshen/model/DivineJieShenMo.lua

module("logic.extensions.divinejieshen.model.DivineJieShenMo", package.seeall)

local DivineJieShenMo = class("DivineJieShenMo")

function DivineJieShenMo:ctor(activityId)
	self._activityId = activityId

	local extTowerData = DivineJieShenConfig.instance:getExtTowerData(self._activityId)

	if extTowerData then
		self._towerCount = #extTowerData or 0
	end

	local norStageCfg = DivineJieShenConfig.instance:getNorStageCfg(self._activityId)

	if norStageCfg then
		self._stageCountInNor = #norStageCfg or 0
	end

	self._scoreInExt = {}
	self._passTowerId = 0
	self._passStageId = 0
	self._normalInfo = {}
	self._clientKeyDic = {}
	self._serverKeyDic = {}
end

function DivineJieShenMo:getActivityId()
	return self._activityId
end

function DivineJieShenMo:handlePM_DivineJieShenClgGetInfoRes(msg)
	local extremeInfo = msg.extremeInfo

	self._passTowerId = 0
	self._passStageId = 0

	local passedInfo = extremeInfo.passedInfo

	if passedInfo ~= nil then
		self._scoreInExt[passedInfo.towerId] = {}
		self._scoreInExt[passedInfo.towerId][passedInfo.stageId] = passedInfo.scorePair
		self._passTowerId = passedInfo.towerId
		self._passStageId = passedInfo.stageId
	end

	self._curInfo = extremeInfo.curInfo
	self._scoreInExt[self._curInfo.towerId] = {}
	self._scoreInExt[self._curInfo.towerId][self._curInfo.stageId] = {
		left = self._curInfo.scoreLeft,
		right = self._curInfo.scoreRight
	}
	self._normalInfo = msg.normalInfo
end

function DivineJieShenMo:handlePM_DivineJieShenClgResetExtremeStageRes(msg)
	self._curInfo = msg.curInfo
	self._scoreInExt[self._curInfo.towerId] = {}
	self._scoreInExt[self._curInfo.towerId][self._curInfo.stageId] = {
		left = self._curInfo.scoreLeft,
		right = self._curInfo.scoreRight
	}
end

function DivineJieShenMo:handlePM_DivineJieShenClgNormalRandomTrialRes(msg)
	self._normalInfo = msg.normalInfo
end

function DivineJieShenMo:handlePM_DivineJieShenClgNormalStartGameRes(msg)
	self._serverKeyDic[msg.stageId] = msg.serverKey
end

function DivineJieShenMo:handlePM_DivineJieShenClgNormalFinishGameRes(msg)
	self._clientKeyDic[msg.stageId] = nil
	self._serverKeyDic[msg.stageId] = nil

	if msg.pass and msg.normalInfo then
		self._normalInfo = msg.normalInfo
	end
end

function DivineJieShenMo:handlePM_DivineJieShenClgNormalChallengeStageRes(msg)
	return
end

function DivineJieShenMo:handlePM_DivineJieShenClgNormalChallengeBossRes(msg)
	return
end

function DivineJieShenMo:handlePM_Notify_DivineJieShenClgExtremeChallengeEndRes(msg)
	return
end

function DivineJieShenMo:handlePM_Notify_DivineJieShenClgNormalChallengeStageEndRes(msg)
	if msg.win and msg.normalInfo then
		self._normalInfo = msg.normalInfo
	end
end

function DivineJieShenMo:handlePM_Notify_DivineJieShenClgNormalChallengeBossEndRes(msg)
	return
end

function DivineJieShenMo:getCurTowerIdInExt()
	local nextStageId = self._passStageId + 1

	return self:_isUnlockTower(self._curInfo.towerId) and (nextStageId > self:getStageCount(self._passTowerId) and (self._passTowerId + 1 > self:getTowerCountInExt() and self._passTowerId or self._passTowerId + 1) or self._passTowerId == 0 and self._passTowerId + 1 or self._passTowerId) or self._passTowerId
end

function DivineJieShenMo:isPassAllInExt()
	if self._passTowerId == self:getTowerCountInExt() and self._passStageId == self:getStageCount(self._passTowerId) then
		return true
	end

	return false
end

function DivineJieShenMo:_isUnlockTower(towerId)
	if self._passTowerId == self:getTowerCountInExt() and self._passStageId == self:getStageCount(self._passTowerId) then
		return true
	end

	if towerId > self:getTowerCountInExt() then
		return self:getTowerCountInExt()
	end

	local timeLimitStart = DivineJieShenConfig.instance:getExtTowerData(self._activityId)[towerId].openTime
	local timePeriod = GameUtil.getTimePeriod(timeLimitStart)

	return timePeriod == GameUtil.inTimePeriod
end

function DivineJieShenMo:getStageIdInExt(towerId)
	local stageId = 1

	if towerId < self._passTowerId then
		stageId = self:getStageCount(towerId)
	elseif towerId == self._passTowerId then
		stageId = Mathf.Min(self:getStageCount(towerId), self._passStageId + 1)
	elseif towerId > self._passTowerId then
		stageId = 1
	end

	return stageId
end

function DivineJieShenMo:getTowerCountInExt()
	return self._towerCount
end

function DivineJieShenMo:getStageCount(towerId)
	local datas = DivineJieShenConfig.instance:getExtStageDatas(self._activityId, towerId)

	return (datas or nil) and (#datas or 0)
end

function DivineJieShenMo:getScoreInTeamInExt(towerId, stageId, teamId)
	local score = 0

	if self._scoreInExt[towerId] then
		local scorePair = self._scoreInExt[towerId][(towerId < self._curInfo.towerId or nil) and #DivineJieShenConfig.instance:getExtStageDatas(self._activityId, towerId)]

		if scorePair then
			score = teamId == GameEnum.BattleTeam.Left and scorePair.left or scorePair.right
		end
	end

	return score
end

function DivineJieShenMo:isPassInTeamInExt(towerId, stageId, teamId)
	local isPass = false
	local curTowerId = self:getCurTowerIdInExt()
	local curStageId = self:getStageIdInExt(curTowerId)

	if towerId < curTowerId then
		isPass = true
	elseif towerId == curTowerId then
		if stageId == curStageId then
			local score = self:getScoreInTeamInExt(curTowerId, curStageId, teamId)

			isPass = score > 0
		else
			isPass = stageId < curStageId
		end
	else
		isPass = false
	end

	return isPass
end

function DivineJieShenMo:isPassInStageInExt(towerId, stageId)
	local isPass = false
	local curTowerId = self:getCurTowerIdInExt()
	local curStageId = self:getStageIdInExt(curTowerId)

	if towerId < curTowerId then
		isPass = true
	elseif towerId == curTowerId then
		if stageId == curStageId then
			local data = DivineJieShenConfig.instance:getExtStageData(self._activityId, towerId, stageId)

			if data then
				local left = self:getScoreInTeamInExt(curTowerId, curStageId, GameEnum.BattleTeam.Left)
				local right = self:getScoreInTeamInExt(curTowerId, curStageId, GameEnum.BattleTeam.Right)

				if left > 0 and right > 0 then
					local symbol = data.compareMode

					if symbol == ">=" then
						isPass = right < left or left == right
					elseif symbol == ">" then
						isPass = right < left
					elseif symbol == "=" then
						isPass = left == right
					elseif symbol == "<=" then
						isPass = left < right or left == right
					elseif symbol == "<" then
						isPass = left < right
					end
				else
					isPass = false
				end
			end
		else
			isPass = stageId < curStageId
		end
	else
		isPass = false
	end

	return isPass
end

function DivineJieShenMo:isPassInTowerInExt(towerId)
	if towerId < self._passTowerId then
		return true
	elseif towerId == self._passTowerId and self:isPassInStageInExt(towerId, self._curInfo.stageId) then
		return true
	end

	return false
end

function DivineJieShenMo:getLocakRaceIdsInTeamInExt(towerId, stageId, teamId)
	local curTowerId = self._curInfo.towerId
	local curStageId = self._curInfo.stageId

	return (curTowerId == towerId and curStageId == stageId or nil) and (teamId == GameEnum.BattleTeam.Left and self._curInfo.lockRaceIdsLeft or self._curInfo.lockRaceIdsRight)
end

function DivineJieShenMo:getLocakRaceIdsInStageInExt(towerId, stageId)
	local listLeft = self:getLocakRaceIdsInTeamInExt(towerId, stageId, GameEnum.BattleTeam.Left)
	local listRight = self:getLocakRaceIdsInTeamInExt(towerId, stageId, GameEnum.BattleTeam.Right)
	local list = {}

	table.insertto(list, listLeft)
	table.insertto(list, listRight)

	return list
end

function DivineJieShenMo:getLeftClgTimesInNor()
	return self._normalInfo.leftClgTimes or 0
end

function DivineJieShenMo:getPassedStageIdInNor()
	return self._normalInfo.passedStageId or 0
end

function DivineJieShenMo:getStageCountInNor()
	return self._stageCountInNor
end

function DivineJieShenMo:isPassedStageInNor(stageId)
	if stageId > 0 then
		local passStageId = self:getPassedStageIdInNor()

		return stageId <= passStageId
	else
		return true
	end
end

function DivineJieShenMo:isPassPreStageInNor(stageId)
	return self:isPassedStageInNor(stageId - 1)
end

function DivineJieShenMo:isInTimePeriodStageInNor(stageId)
	local isInTime = false
	local data = DivineJieShenConfig.instance:getNorStageData(self._activityId, stageId)

	if data then
		local timePeriod = GameUtil.getTimePeriod(data.openTime, nil)

		isInTime = timePeriod == GameUtil.inTimePeriod
	end

	return isInTime
end

function DivineJieShenMo:isEnoughTimesInNor()
	local left = self:getLeftClgTimesInNor()

	return left > 0
end

function DivineJieShenMo:getCurStageTrialId()
	return self._normalInfo.curStageTrialId or -1
end

function DivineJieShenMo:getDrawTimesInNor()
	return self._normalInfo.drawTimes or 0
end

function DivineJieShenMo:getCurDrawCostInNor()
	local drawTimes = self:getDrawTimesInNor()
	local data = DivineJieShenConfig.instance:getRedrawCostData(self._activityId, drawTimes)

	return data and data.cost
end

function DivineJieShenMo:isPassBossInNor()
	return self._normalInfo.passBoss or false
end

function DivineJieShenMo:getClientKeyInNor(stageId)
	return self._clientKeyDic[stageId]
end

function DivineJieShenMo:setClientKeyInNor(stageId, clientKey)
	self._clientKeyDic[stageId] = clientKey
end

function DivineJieShenMo:getServerKeyInNor(stageId)
	return self._serverKeyDic[stageId]
end

return DivineJieShenMo
