-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/model/RoguelikeModel.lua

module("logic.extensions.roguelike.model.RoguelikeModel", package.seeall)

local RoguelikeModel = class("RoguelikeModel", BaseModel)

RoguelikeModel.Challenge1 = 1
RoguelikeModel.Challenge2 = 2

function RoguelikeModel:onInit()
	self:onReset()
end

function RoguelikeModel:onReset()
	self._agentInfo = {}
	self._killRankInfo = nil
	self._passRankInfo = nil
	self._agentDic = {}
	self._rentListMap = {}
	self._rentMoMap = {}
	self._agentDic = {}
end

function RoguelikeModel:getAgentInfo(activityId)
	if not self._agentDic[activityId] then
		self._agentDic[activityId] = {}

		self:_initAgent(self._agentDic[activityId])
	end

	return self._agentDic[activityId]
end

function RoguelikeModel:_initAgent(info)
	info.activityId = 0
	info.rentPetId = {}
	info.globalBuffLvlInfo = {}
	info.globalBuffUsing = {}
	info.phaseInfo = {}
	info.battleActivityId = 0
	info.battlePhaseId = 0
	info.normalFight = false
	info.fightStageId = 0
	info.win = false
	info.canContitueFight = false
	info.selectingDropBuff = nil
	info.totalKillCount = 0
	info.normalFmtMo = nil
	info.extraFmtMo = nil
end

function RoguelikeModel:getNormalFmtMo(activityId)
	local info = self:getAgentInfo(activityId)

	if info.normalFmtMo == nil then
		info.normalFmtMo = RoguelikeFmtMo.New()
	end

	return info.normalFmtMo
end

function RoguelikeModel:getExtraFmtMo(activityId)
	local info = self:getAgentInfo(activityId)

	if info.extraFmtMo == nil then
		info.extraFmtMo = RoguelikeExtraFmtMo.New()
	end

	return info.extraFmtMo
end

function RoguelikeModel:onRoguelikeGetInfoRes(msg)
	local info = self:getAgentInfo(msg.activityId)

	info.activityId = msg.activityId
	info.rentPetId = GameUtil.pbToTable(msg.rentPetId) or {}
	info.globalBuffLvlInfo = GameUtil.pbToTable(msg.globalBuffLvlInfo) or {}
	info.globalBuffUsing = GameUtil.pbToTable(msg.globalBuffUsing) or {}
	info.phaseInfo = GameUtil.pbToTable(msg.phaseInfo) or {}
end

function RoguelikeModel:onRoguelikeLvlUpGlobalBuffRes(msg)
	local info = self:getAgentInfo(msg.activityId)

	if info then
		info.globalBuffLvlInfo = info.globalBuffLvlInfo or {}

		local isNew = true

		for i, v in ipairs(info.globalBuffLvlInfo) do
			if v.left == msg.buffId then
				isNew = false
				v.right = msg.newBuffLvl
			end
		end

		if isNew then
			local t = {}

			t.left = msg.buffId
			t.right = msg.newBuffLvl

			table.insert(info.globalBuffLvlInfo, t)
		end
	end
end

function RoguelikeModel:onRoguelikeResetGlobalBuffLvlRes(msg)
	local info = self:getAgentInfo(msg.activityId)
	local info = self:getAgentInfo(msg.activityId)

	if info then
		info.globalBuffLvlInfo = info.globalBuffLvlInfo or {}

		for i, v in ipairs(info.globalBuffLvlInfo) do
			if v.left == msg.buffId then
				v.right = msg.newBuffLvl
			end
		end
	end
end

function RoguelikeModel:onRoguelikeSetGlobalBuffOnOffRes(msg)
	local info = self:getAgentInfo(msg.activityId)

	if info then
		info.globalBuffUsing = GameUtil.pbToTable(msg.globalBuffUsing) or {}
	end
end

function RoguelikeModel:onRoguelikeSetRentPetUsingOrNotRes(msg)
	local info = self:getAgentInfo(msg.activityId)

	if info then
		info.rentPetId = GameUtil.pbToTable(msg.rentPetId) or {}
	end
end

function RoguelikeModel:onRoguelikeRerandomDropBuffRes(msg)
	local info = self:getAgentInfo(msg.activityId)

	if info.phaseInfo and info.phaseInfo[msg.phaseId] then
		local dropBuffInfo = info.phaseInfo[msg.phaseId].dropBuffInfo

		dropBuffInfo.selectingDropBuff = GameUtil.pbToTable(msg.selectingDropBuff) or {}
		dropBuffInfo.reRandomCount = msg.reRandomCount
	end
end

function RoguelikeModel:onRoguelikeSelectDropBuffRes(msg)
	local info = self:getAgentInfo(msg.activityId)

	if info.phaseInfo and info.phaseInfo[msg.phaseId] then
		info.phaseInfo[msg.phaseId].dropBuffInfo = GameUtil.pbToTable(msg.dropBuffInfo)
	end
end

function RoguelikeModel:onRoguelikeReShuffleDropBuffRes(msg)
	local info = self:getAgentInfo(msg.activityId)

	if info.phaseInfo and info.phaseInfo[msg.phaseId] then
		info.phaseInfo[msg.phaseId].dropBuffInfo = GameUtil.pbToTable(msg.dropBuffInfo)
	end
end

function RoguelikeModel:onRoguelikeGainNormalPrizeRes(msg)
	local info = self:getAgentInfo(msg.activityId)

	if info then
		for i, v in ipairs(info.phaseInfo) do
			if v.phaseId == msg.phaseId then
				v.normalMaxStageIdGainedPrize = msg.normalMaxStageIdGainedPrize

				break
			end
		end
	end
end

function RoguelikeModel:onRoguelikeStartFightRes(msg)
	return
end

function RoguelikeModel:onRoguelikeContunieFightRes(msg)
	return
end

function RoguelikeModel:onRoguelikeNotifyFightResultRes(msg)
	local info = self:getAgentInfo(msg.activityId)

	info.battleActivityId = msg.activityId
	info.battlePhaseId = msg.phaseId
	info.normalFight = msg.normalFight
	info.fightStageId = msg.fightStageId
	info.win = msg.win
	info.canContinueFight = msg.canContinueFight
	info.selectingDropBuff = msg.selectingDropBuff
	info.totalKillCount = msg.totalKillCount

	printInfo("test RoguelikeModel:onRoguelikeNotifyFightResultRes", msg.canContinueFight, info.canContinueFight)

	if msg:HasField("phaseInfo") then
		info.phaseInfo[msg.phaseId] = GameUtil.pbToTable(msg.phaseInfo) or {}
	end
end

function RoguelikeModel:onRoguelikeGetKillRankRes(msg)
	self._killRankInfo = GameUtil.pbToTable(msg)
end

function RoguelikeModel:getKillRankInfo()
	return self._killRankInfo
end

function RoguelikeModel:onRoguelikeGetPassRankRes(msg)
	self._passRankInfo = GameUtil.pbToTable(msg)
end

function RoguelikeModel:getPassRankInfo()
	return self._passRankInfo
end

function RoguelikeModel:getActivityId()
	return 393003
end

function RoguelikeModel:isPhaseUnlock(activityId, phaseId)
	local info = self:getAgentInfo(activityId)

	for i, v in ipairs(info.phaseInfo) do
		if v.phaseId == phaseId then
			return true
		end
	end

	return false
end

function RoguelikeModel:getNormalMaxPassedStageId(activityId, phaseId)
	local info = self:getAgentInfo(activityId)

	for i, v in ipairs(info.phaseInfo) do
		if v.phaseId == phaseId then
			return v.normalMaxStageIdPassed
		end
	end

	return 0
end

function RoguelikeModel:getRentPetIdList(activityId)
	local info = self:getAgentInfo(activityId)

	return info.rentPetId
end

function RoguelikeModel:getNormalMaxGainedStageId(activityId, phaseId)
	local info = self:getAgentInfo(activityId)

	for i, v in ipairs(info.phaseInfo) do
		if v.phaseId == phaseId then
			return v.normalMaxStageIdGainedPrize
		end
	end

	return 0
end

function RoguelikeModel:getRentPetMoList(activityId)
	local list = self._rentListMap[activityId]

	if list == nil then
		list = {}

		local cfgList = RoguelikeConfig.instance:getRentPetList(activityId)

		for k, v in pairs(cfgList or {}) do
			local mo = FightingPowerPetMo.New()

			mo:fromChallengeCreepCo(v)
			table.insert(list, mo)

			self._rentMoMap[activityId] = self._rentMoMap[activityId] or {}
			self._rentMoMap[activityId][mo.petId] = mo
		end

		self._rentListMap[activityId] = list
	end

	return list
end

function RoguelikeModel:getRentPetMo(activityId, petId)
	return self._rentMoMap[activityId] and self._rentMoMap[activityId][petId]
end

function RoguelikeModel:isPassAllNormalLevel(activityId, phaseId)
	local cfgNormalStages = RoguelikeConfig.instance:getNormalStageList(activityId, phaseId)
	local maxStage = #cfgNormalStages
	local info = self:getAgentInfo(activityId)

	if info.phaseInfo and info.phaseInfo[phaseId] then
		return maxStage <= info.phaseInfo[phaseId].normalMaxStageIdPassed
	end
end

function RoguelikeModel:isPassAllExtraLevel(activityId, phaseId)
	local cfgExtraStages = RoguelikeConfig.instance:getExtStageList(activityId, phaseId)
	local maxStage = #cfgExtraStages
	local info = self:getAgentInfo(activityId)

	if info.phaseInfo and info.phaseInfo[phaseId] then
		return maxStage <= info.phaseInfo[phaseId].extMaxStageIdPassed
	end
end

function RoguelikeModel:getNormalPassNum(activityId, phaseId)
	local info = self:getAgentInfo(activityId)

	if info.phaseInfo and info.phaseInfo[phaseId] then
		return info.phaseInfo[phaseId].normalMaxStageIdPassed
	end

	return 0
end

function RoguelikeModel:getExtraPassNum(activityId, phaseId)
	local info = self:getAgentInfo(activityId)

	if info.phaseInfo and info.phaseInfo[phaseId] then
		return info.phaseInfo[phaseId].extMaxStageIdPassed
	end

	return 0
end

function RoguelikeModel:getExtraKillCount(activityId, phaseId)
	local info = self:getAgentInfo(activityId)

	if info.phaseInfo and info.phaseInfo[phaseId] then
		return info.phaseInfo[phaseId].extMaxKillCount
	end

	return 0
end

function RoguelikeModel:isCanContinueFight(activityId, phaseId)
	local info = self:getAgentInfo(activityId)

	if info.battlePhaseId == phaseId then
		return info.canContinueFight
	end
end

function RoguelikeModel:isNormalFight(activityId, phaseId)
	local info = self:getAgentInfo(activityId)

	if info.battlePhaseId == phaseId then
		return info.normalFight
	end
end

function RoguelikeModel:isNeedSelectBuff(activityId, phaseId)
	local info = self:getAgentInfo(activityId)

	if info.phaseInfo and info.phaseInfo[phaseId] and info.phaseInfo[phaseId].dropBuffInfo then
		local dropBuffInfo = info.phaseInfo[phaseId].dropBuffInfo

		if dropBuffInfo.selectingDropBuff and #dropBuffInfo.selectingDropBuff > 0 then
			return true
		end
	end

	return false
end

function RoguelikeModel:getSelectDropBuffs(activityId, phaseId)
	local info = self:getAgentInfo(activityId)

	if info.phaseInfo and info.phaseInfo[phaseId] and info.phaseInfo[phaseId].dropBuffInfo then
		return info.phaseInfo[phaseId].dropBuffInfo.selectingDropBuff
	end
end

function RoguelikeModel:getSelectedDropBuffs(activityId, phaseId)
	local info = self:getAgentInfo(activityId)

	if info.phaseInfo and info.phaseInfo[phaseId] and info.phaseInfo[phaseId].dropBuffInfo then
		return info.phaseInfo[phaseId].dropBuffInfo.selectedDropBuffId or {}
	end
end

function RoguelikeModel:getReRandomCount(activityId, phaseId)
	local info = self:getAgentInfo(activityId)

	if info.phaseInfo and info.phaseInfo[phaseId] and info.phaseInfo[phaseId].dropBuffInfo then
		return info.phaseInfo[phaseId].dropBuffInfo.reRandomCount
	end

	return 0
end

function RoguelikeModel:getGlobalBuffLevel(activityId, buffId)
	local info = self:getAgentInfo(activityId)

	if info and info.globalBuffLvlInfo then
		for i, v in ipairs(info.globalBuffLvlInfo) do
			local id = v.left

			if id == buffId then
				return v.right
			end
		end
	end

	return 1
end

function RoguelikeModel:isUsingGlobalBuff(activityId, buffId)
	local info = self:getAgentInfo(activityId)

	if info and info.globalBuffUsing then
		for i, v in ipairs(info.globalBuffUsing) do
			if v == buffId then
				return true
			end
		end
	end

	return false
end

function RoguelikeModel:getUsingGlobalBuffList(activityId)
	local info = self:getAgentInfo(activityId)

	if info then
		return info.globalBuffUsing or {}
	end
end

function RoguelikeModel:getMaxKillNum(activityId, challengeType)
	local info = self:getAgentInfo(activityId)

	if info and info.phaseInfo and info.phaseInfo[challengeType] then
		return info.phaseInfo[challengeType].extMaxKillCount
	end

	return 0
end

function RoguelikeModel:getPassTime(activityId, challengeType)
	local info = self:getAgentInfo(activityId)

	if info and info.phaseInfo and info.phaseInfo[challengeType] then
		return Mathf.Round(checknumber(info.phaseInfo[challengeType].normalPassedTime) / 1000)
	end

	return 0
end

RoguelikeModel.instance = RoguelikeModel.New()

return RoguelikeModel
