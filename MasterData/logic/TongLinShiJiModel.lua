-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tonglinshiji/model/TongLinShiJiModel.lua

module("logic.extensions.tonglinshiji.model.TongLinShiJiModel", package.seeall)

local TongLinShiJiModel = class("TongLinShiJiModel", BaseModel)

TongLinShiJiModel.NOR_PRIZE_TYPE = 1
TongLinShiJiModel.EXT_PRIZE_TYPE = 2

function TongLinShiJiModel:ctor()
	return
end

function TongLinShiJiModel:onInit()
	self:onReset()
end

function TongLinShiJiModel:onReset()
	self._ModelPool = {}
	self._customNorFmtMoPool = {}
	self._customNorBossFmtMoPool = {}
	self._customExtFmtMoPool = {}
	self._changeSetIdList = {}
end

function TongLinShiJiModel:GetModel(activityId)
	if self._ModelPool[activityId] == nil then
		local cur = {}

		cur.normalInfo = {}
		cur.normalInfo.passedStageIds = nil
		cur.normalInfo.todayPassedStageCount = 0
		cur.normalInfo.todayBossClgTimes = 0
		cur.normalInfo.bossLeftHp = 10000
		cur.normalInfo.gainPrize = false
		cur.normalInfo.HurtBoss = 0
		cur.extremeInfo = {}
		cur.extremeInfo.raceTypeInfos = {}
		cur.extremeInfo.gainPrize = false
		cur.extremeInfo.showCurScore = 0
		cur.extremeInfo.showOldScore = 0
		cur.extremeInfo.needConfirm = false
		cur.extremeInfo.isWin = false
		self._ModelPool[activityId] = cur
	end

	return self._ModelPool[activityId]
end

function TongLinShiJiModel:getCustomFmtMo(activityId)
	if self._customFmtMoPool[activityId] == nil then
		self._customFmtMoPool[activityId] = TongLinShiJiFmtMo.New()
	end

	return self._customFmtMoPool[activityId]
end

function TongLinShiJiModel:addChangeSetId(value)
	table.insert(self._changeSetIdList, value)
end

function TongLinShiJiModel:getChangeSetIdCount()
	return #self._changeSetIdList
end

function TongLinShiJiModel:popChangeSetId()
	return table.remove(self._changeSetIdList, #self._changeSetIdList)
end

function TongLinShiJiModel:handlePM_JiClgGetInfoRes(_msg)
	local msg = GameUtil.pbToTable(_msg)
	local curModel = self:GetModel(msg.activityId)

	curModel.normalInfo = msg.normalInfo
	curModel.normalInfo.passedStageIds = msg.normalInfo.passedStageIds
	curModel.extremeInfo = msg.extremeInfo

	if msg.extremeInfo.raceTypeInfos then
		local raceInfos = msg.extremeInfo.raceTypeInfos

		for i, info in pairs(raceInfos) do
			curModel.extremeInfo.raceTypeInfos[info.raceType] = info
		end
	end

	curModel.extremeInfo.gainPrize = msg.extremeInfo.gainPrize or false
end

function TongLinShiJiModel:handlePM_JiClgGainPrizeRes(_msg)
	local msg = GameUtil.pbToTable(_msg)
	local curModel = self:GetModel(msg.activityId)

	self:addChangeSetId(msg.changeSetId)

	if msg.prizeType == 1 then
		curModel.normalInfo.gainPrize = true
	else
		curModel.extremeInfo.gainPrize = true
	end
end

function TongLinShiJiModel:handlePM_Notify_JiClgNormalStageEndRes(_msg)
	local msg = GameUtil.pbToTable(_msg)
	local curModel = self:GetModel(msg.activityId)
	local win = msg.win

	if win then
		curModel.normalInfo.todayPassedStageCount = msg.todayPassedStageCount

		if curModel.normalInfo.passedStageIds then
			table.insert(curModel.normalInfo.passedStageIds, msg.stageId)
		else
			curModel.normalInfo.passedStageIds = {}

			table.insert(curModel.normalInfo.passedStageIds, msg.stageId)
		end
	end
end

function TongLinShiJiModel:handlePM_Notify_JiClgNormalBossEndRes(_msg)
	local msg = GameUtil.pbToTable(_msg)
	local bossCreepsMasterId = TongLinShiJiConfig.instance:getJiActivityData(msg.activityId).normalBossId
	local cfg = TongLinShiJiConfig.instance:getJiCreepsData(bossCreepsMasterId)
	local totalHp = 0

	for creepsId, pet in ipairs(cfg) do
		local attrs = FightingPowerFormula.instance:parseAttrValues(pet.extproperties) or {}
		local curPetHp = attrs[GameEnum.AttrType.Hp]

		totalHp = totalHp + curPetHp
	end

	local curModel = self:GetModel(msg.activityId)
	local hurt = (curModel.normalInfo.bossLeftHp - msg.bossLeftHp) / totalHp * 100

	hurt = math.floor(hurt * 100) / 100
	curModel.normalInfo.HurtBoss = hurt

	local practice = msg.practice

	if not practice then
		curModel.normalInfo.bossLeftHp = msg.bossLeftHp
		curModel.normalInfo.todayBossClgTimes = msg.todayBossClgTimes
	end
end

function TongLinShiJiModel:handlePM_Notify_JiClgExtremeStageEndRes(_msg)
	local msg = GameUtil.pbToTable(_msg)
	local curModel = self:GetModel(msg.activityId)
	local win = msg.win

	if win and curModel.extremeInfo.raceTypeInfos and #curModel.extremeInfo.raceTypeInfos > 0 then
		curModel.extremeInfo.showCurScore = msg.score
		curModel.extremeInfo.showOldScore = msg.oldScore
	end

	curModel.extremeInfo.needConfirm = msg.needConfirm
	curModel.extremeInfo.isWin = msg.win
end

function TongLinShiJiModel:handlePM_JiClgConfirmExtremeScoreRes(_msg)
	local msg = GameUtil.pbToTable(_msg)
	local curModel = self:GetModel(msg.activityId)

	if curModel.extremeInfo.raceTypeInfos and #curModel.extremeInfo.raceTypeInfos > 0 then
		local raceInfo = curModel.extremeInfo.raceTypeInfos[msg.raceType]

		raceInfo.stageScores[msg.stageId] = msg.score
	end
end

function TongLinShiJiModel:FinishNorChallenge(activityId)
	local curModel = self:GetModel(activityId)

	return curModel.normalInfo.gainPrize
end

function TongLinShiJiModel:GetNorBossHP(activityId)
	local curModel = self:GetModel(activityId)

	return curModel.normalInfo.bossLeftHp
end

function TongLinShiJiModel:GetNorBossProgress(activityId)
	local curModel = self:GetModel(activityId)

	return curModel.normalInfo.bossLeftHp
end

function TongLinShiJiModel:GetNorLeftTimes(activityId)
	local curModel = self:GetModel(activityId)
	local todayPassedStageCount = curModel.normalInfo.todayPassedStageCount
	local todayBossClgTimes = curModel.normalInfo.todayBossClgTimes
	local clgStageCount = TongLinShiJiConfig.instance:GetDailyNorStageNum(activityId)
	local clgNorBossCount = TongLinShiJiConfig.instance:GetDailyNorBossNum(activityId)

	return clgStageCount - todayPassedStageCount, clgNorBossCount - todayBossClgTimes
end

function TongLinShiJiModel:CanGainHelp(activityId, stageId)
	local curModel = self:GetModel(activityId)

	if curModel.normalInfo.passedStageIds then
		return table.indexof(curModel.normalInfo.passedStageIds, stageId) ~= false
	end
end

function TongLinShiJiModel:CurNorBossBuffs(activityId)
	local curModel = self:GetModel(activityId)

	return curModel.normalInfo.passedStageIds or {}
end

function TongLinShiJiModel:CurNorBuffsCreepsId(activityId)
	local curModel = self:GetModel(activityId)
	local creepsIds = {}
	local curBuffs = self:CurNorBossBuffs(activityId)

	for _, passId in pairs(curBuffs) do
		local creepsId = TongLinShiJiConfig.instance:GetNorSupportCreepsId(activityId, passId)

		table.insert(creepsIds, creepsId)
	end

	return creepsIds
end

function TongLinShiJiModel:FinishExtChallenge(activityId)
	local curModel = self:GetModel(activityId)

	return curModel.extremeInfo.gainPrize
end

function TongLinShiJiModel:GetCurExtPowers(activityId)
	local curModel = self:GetModel(activityId)
	local powers = {}

	if curModel.extremeInfo.raceTypeInfos and #curModel.extremeInfo.raceTypeInfos > 0 then
		for idx, info in pairs(curModel.extremeInfo.raceTypeInfos) do
			local curTypeTotalScore = 0

			for _, score in pairs(info.stageScores) do
				if score ~= -1 then
					curTypeTotalScore = curTypeTotalScore + score
				end
			end

			powers[info.raceType] = curTypeTotalScore
		end
	end

	return powers
end

function TongLinShiJiModel:GetCurExtTotalPower(activityId)
	local curModel = self:GetModel(activityId)
	local score = 0
	local powers = self:GetCurExtPowers(activityId)

	for k, v in pairs(powers) do
		score = score + v
	end

	return score
end

function TongLinShiJiModel:GetExtPowerTeam(activityId, raceType, teamId)
	local curModel = self:GetModel(activityId)
	local info

	if curModel.extremeInfo.raceTypeInfos then
		info = curModel.extremeInfo.raceTypeInfos[raceType]
	end

	if info then
		return (info.stageScores[teamId] > 0 or nil) and (info.stageScores[teamId] or 0)
	end

	return 0
end

function TongLinShiJiModel:GetOldAndCurScore(activityId)
	local curModel = self:GetModel(activityId)

	return curModel.extremeInfo.showOldScore, curModel.extremeInfo.showCurScore
end

function TongLinShiJiModel:getNorFmtMo(activityId)
	if self._customNorFmtMoPool[activityId] == nil then
		self._customNorFmtMoPool[activityId] = TongLinShiJiNorFmtMo.New()
	end

	return self._customNorFmtMoPool[activityId]
end

function TongLinShiJiModel:getNorBossFmtMo(activityId)
	if self._customNorBossFmtMoPool[activityId] == nil then
		self._customNorBossFmtMoPool[activityId] = TongLinShiJiNorBossFmtMo.New()
	end

	return self._customNorBossFmtMoPool[activityId]
end

function TongLinShiJiModel:getExtFmtMo(activityId)
	if self._customExtFmtMoPool[activityId] == nil then
		self._customExtFmtMoPool[activityId] = TongLinShiJiExtFmtMo.New()
	end

	return self._customExtFmtMoPool[activityId]
end

TongLinShiJiModel.instance = TongLinShiJiModel.New()

return TongLinShiJiModel
