-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinezhongfeiclg/model/DivineZhongFeiClgModel.lua

module("logic.extensions.divinezhongfeiclg.model.DivineZhongFeiClgModel", package.seeall)

local DivineZhongFeiClgModel = class("DivineZhongFeiClgModel", BaseModel)

function DivineZhongFeiClgModel:ctor()
	return
end

function DivineZhongFeiClgModel:onInit()
	self:onReset()
end

function DivineZhongFeiClgModel:onReset()
	self._extraFmtMo = nil
	self._normalFmtMo = nil
	self._extInfo = {}
	self._stageInfo = {}
	self._lockPetMap = {}
	self._normalInfo = {}
	self._gainPrizeMap = {}
end

function DivineZhongFeiClgModel:saveExtInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._extInfo[info.activityId] = info

	local stageInfo = {}

	if info.stages then
		for i, v in ipairs(info.stages) do
			stageInfo[v.stageId] = v
		end
	end

	self._stageInfo[info.activityId] = stageInfo

	local lockMap = {}

	if info.lockRaceIds then
		for i, v in ipairs(info.lockRaceIds) do
			lockMap[v] = true
		end
	end

	self._lockPetMap[info.activityId] = lockMap
end

function DivineZhongFeiClgModel:getExtemeFmtMo()
	self._extraFmtMo = self._extraFmtMo or DivineZhongFeiClgExtFmtMo.New()

	return self._extraFmtMo
end

function DivineZhongFeiClgModel:getNormalFmtMo()
	self._normalFmtMo = self._normalFmtMo or DivineZhongFeiClgNormalFmtMo.New()

	return self._normalFmtMo
end

function DivineZhongFeiClgModel:isPetLock(activityId, raceId)
	if self._lockPetMap[activityId] then
		return self._lockPetMap[activityId][raceId] or false
	end

	return false
end

function DivineZhongFeiClgModel:getLockRaceIds(activityId)
	if self._extInfo[activityId] then
		return self._extInfo[activityId].lockRaceIds or {}
	end

	return {}
end

function DivineZhongFeiClgModel:isExtStagePass(activityId, stageId)
	if self._stageInfo[activityId] then
		return self._stageInfo[activityId][stageId] ~= nil
	end

	return false
end

function DivineZhongFeiClgModel:getExtStageScore(activityId, stageId)
	if self._stageInfo[activityId] and self._stageInfo[activityId][stageId] then
		return checknumber(self._stageInfo[activityId][stageId].killNum)
	end

	return 0
end

function DivineZhongFeiClgModel:getExtStageTotalScore(activityId)
	local totalScore = 0

	if self._stageInfo[activityId] then
		for i, v in pairs(self._stageInfo[activityId]) do
			totalScore = totalScore + v.killNum
		end
	end

	return totalScore
end

function DivineZhongFeiClgModel:isGainExtPassPrize(activityId)
	if self._extInfo[activityId] then
		return self._extInfo[activityId].hadGainPrize
	end

	return false
end

function DivineZhongFeiClgModel:saveExtBattle(msg)
	self._tempExtBattleInfo = GameUtil.pbToTable(msg)
end

function DivineZhongFeiClgModel:getTempExtBattleInfo()
	return self._tempExtBattleInfo
end

function DivineZhongFeiClgModel:saveExtConfirmInfo(msg)
	local stageInfo = {
		stageId = self._tempExtBattleInfo.stageId,
		killNum = self._tempExtBattleInfo.killNum
	}

	if self._extInfo[msg.activityId] then
		self._extInfo[msg.activityId].stages = self._extInfo[msg.activityId].stages or {}

		table.insert(self._extInfo[msg.activityId].stages, stageInfo)

		self._stageInfo[msg.activityId][msg.stageId] = stageInfo
		self._extInfo[msg.activityId].lockRaceIds = self._extInfo[msg.activityId].lockRaceIds or {}

		for i, v in ipairs(self._tempExtBattleInfo.lockRaceIds) do
			table.insert(self._extInfo[msg.activityId].lockRaceIds, v)

			self._lockPetMap[msg.activityId][v] = true
		end

		if msg.isFinish == true then
			self._extInfo[msg.activityId].hadGainPrize = true
		end
	end

	if msg.changeSetId then
		self._tempChangeSetId = msg.changeSetId
	end
end

function DivineZhongFeiClgModel:getTempChengeSetId()
	return self._tempChangeSetId
end

function DivineZhongFeiClgModel:resetTempChengeSetId()
	self._tempChangeSetId = nil
end

function DivineZhongFeiClgModel:saveResetInfo(msg)
	self._lockPetMap[msg.activityId] = {}
	self._stageInfo[msg.activityId] = {}
	self._extInfo[msg.activityId].stages = nil
	self._extInfo[msg.activityId].lockRaceIds = nil
end

function DivineZhongFeiClgModel:saveNormalInfo(msg)
	local data = GameUtil.pbToTable(msg)

	self._normalInfo[msg.activityId] = data

	local gainPrizeMap = {}

	if data.gainedPrizeId then
		for i, v in ipairs(data.gainedPrizeId) do
			gainPrizeMap[v] = true
		end
	end

	self._gainPrizeMap[msg.activityId] = gainPrizeMap
end

function DivineZhongFeiClgModel:getNormalStageScore(activityId)
	if self._normalInfo[activityId] then
		return checknumber(self._normalInfo[activityId].totalDamage)
	end

	return 0
end

function DivineZhongFeiClgModel:getNormalTodayDamage(activityId)
	if self._normalInfo[activityId] then
		return checknumber(self._normalInfo[activityId].todayDamage)
	end

	return 0
end

function DivineZhongFeiClgModel:isGainNormalPrize(activityId, prizeId)
	if self._gainPrizeMap[activityId] then
		return self._gainPrizeMap[activityId][prizeId] or false
	end

	return false
end

function DivineZhongFeiClgModel:saveNormalBattleInfo(msg)
	if self._normalInfo[msg.activityId] then
		local curDamage = checknumber(msg.damage)
		local todayDamage = checknumber(self._normalInfo[msg.activityId].todayDamage)

		if todayDamage < curDamage then
			self._normalInfo[msg.activityId].todayDamage = curDamage
			self._normalInfo[msg.activityId].totalDamage = checknumber(self._normalInfo[msg.activityId].totalDamage) - todayDamage + curDamage
		end
	end
end

function DivineZhongFeiClgModel:saveGainPrize(msg)
	if self._gainPrizeMap[msg.activityId] then
		self._gainPrizeMap[msg.activityId][msg.prizeId] = true
	end
end

DivineZhongFeiClgModel.instance = DivineZhongFeiClgModel.New()

return DivineZhongFeiClgModel
