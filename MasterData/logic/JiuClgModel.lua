-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jiuclg/model/JiuClgModel.lua

module("logic.extensions.jiuclg.model.JiuClgModel", package.seeall)

local JiuClgModel = class("JiuClgModel", BaseModel)

JiuClgModel.ExtremeClg = 1
JiuClgModel.NormalClg = 2
JiuClgModel.ChallengeTypeKey = "jiuclgchallengetype"

function JiuClgModel:onInit()
	self:onReset()
end

function JiuClgModel:onReset()
	self._agentDic = {}
end

function JiuClgModel:getAgentInfo(activityId)
	if not self._agentDic[activityId] then
		self._agentDic[activityId] = {}

		self:_initAgent(self._agentDic[activityId])
	end

	return self._agentDic[activityId]
end

function JiuClgModel:_initAgent(info)
	info.activityId = 0
	info.normalClgCurPhaseId = 1
	info.normalClgCurStageId = 1
	info.extremeInfo = nil
	info.btlBalancedValue = 0
	info.needLockCount = 0
	info.formRace = nil
	info.confirmNum = 0
	info.normalFmtMo = nil
	info.extremeFmtMo = nil
end

function JiuClgModel:getNormalFmtMo(activityId)
	local info = self:getAgentInfo(activityId)

	if info.normalFmtMo == nil then
		info.normalFmtMo = JiuClgNormalFmtMo.New()
	end

	return info.normalFmtMo
end

function JiuClgModel:getExtremeFmtMo(activityId)
	local info = self:getAgentInfo(activityId)

	if info.extremeFmtMo == nil then
		info.extremeFmtMo = JiuClgExtremeFmtMo.New()
	end

	return info.extremeFmtMo
end

function JiuClgModel:onJiuClgGetInfoRes(msg)
	local info = self:getAgentInfo(msg.activityId)

	info.activityId = msg.activityId
	info.normalClgCurPhaseId = msg.normalClgCurPhaseId
	info.normalClgCurStageId = msg.normalClgCurStageId
	info.extremeInfo = GameUtil.pbToTable(msg.extremeInfo)

	self:_updateExremeInfoMap(info)
end

function JiuClgModel:onJiuClgNotifyNormalFightResultRes(msg)
	if msg.win then
		local info = self:getAgentInfo(msg.activityId)

		info.normalClgCurPhaseId = msg.newPhaseId
		info.normalClgCurStageId = msg.newStageId
	end
end

function JiuClgModel:onJiuClgNotifyExtremeFightResultRes(msg)
	if msg.win then
		local info = self:getAgentInfo(msg.activityId)

		info.formRace = GameUtil.pbToTable(msg.formRace) or {}
		info.btlBalancedValue = checknumber(msg.btlBalancedValue)
		info.needLockCount = checknumber(msg.needLockCount)
		info.confirmNum = checknumber(msg.confirmNum)
	end
end

function JiuClgModel:onJiuClgExtremeFightConfirmRes(msg)
	if msg:HasField("extremeInfo") then
		local info = self:getAgentInfo(msg.activityId)

		info.extremeInfo = GameUtil.pbToTable(msg.extremeInfo)

		self:_updateExremeInfoMap(info)
	end
end

function JiuClgModel:onJiuClgResetExtremePhaseRes(msg)
	local info = self:getAgentInfo(msg.activityId)

	info.extremeInfo = GameUtil.pbToTable(msg.extremeInfo)

	self:_updateExremeInfoMap(info)
end

function JiuClgModel:_updateExremeInfoMap(info)
	printInfo("test JiuClgModel:_updateExremeInfoMap", info, info.extremeInfo, info.extremeInfo.lockRaceInfo)

	if info and info.extremeInfo and info.extremeInfo.lockRaceInfo then
		info.extremeInfo.lockRaceInfoDic = info.extremeInfo.lockRaceInfoDic or {}

		table.clear(info.extremeInfo.lockRaceInfoDic)

		for i, v1 in ipairs(info.extremeInfo.lockRaceInfo) do
			info.extremeInfo.lockRaceInfoDic[v1.stageId] = info.extremeInfo.lockRaceInfoDic[v1.stageId] or {}

			table.clear(info.extremeInfo.lockRaceInfoDic[v1.stageId])

			if v1.races then
				for i2, raceId in ipairs(v1.races) do
					info.extremeInfo.lockRaceInfoDic[v1.stageId][raceId] = true

					printInfo("test JiuClgModel:_updateExremeInfoMap2", v1.stageId, raceId)
				end
			end
		end
	end
end

function JiuClgModel:isExtremePassAll(activityId)
	local info = self:getAgentInfo(activityId)
	local cfgs = JiuClgConfig.instance:getExtremePhaseCfgList(activityId)

	return info.extremeInfo and info.extremeInfo.curPhaseId and info.extremeInfo.curPhaseId > #cfgs
end

function JiuClgModel:getCurExtremePhaseId(activityId)
	local info = self:getAgentInfo(activityId)

	return (info.extremeInfo or nil) and (info.extremeInfo.curPhaseId or 1)
end

function JiuClgModel:getCurExtremeStageId(activityId)
	local info = self:getAgentInfo(activityId)

	return (info.extremeInfo or nil) and (info.extremeInfo.curStageId or 1)
end

function JiuClgModel:isNormalPassAll(activityId)
	local info = self:getAgentInfo(activityId)
	local cfgs = JiuClgConfig.instance:getNormalPhaseCfgList(activityId)

	return info.normalClgCurPhaseId > #cfgs
end

function JiuClgModel:getCurNormalPhaseId(activityId)
	local info = self:getAgentInfo(activityId)

	return info.normalClgCurPhaseId
end

function JiuClgModel:getCurNormalStageId(activityId)
	local info = self:getAgentInfo(activityId)

	return info.normalClgCurStageId
end

function JiuClgModel:getBtlBalancedValue(activityId)
	local info = self:getAgentInfo(activityId)

	return info.btlBalancedValue
end

function JiuClgModel:getExtremeConfirmNum(activityId)
	local info = self:getAgentInfo(activityId)

	return info.confirmNum
end

function JiuClgModel:getBattleExtremeLockPetList(activityId)
	local info = self:getAgentInfo(activityId)
	local list = {}

	for i, v in ipairs(info.formRace) do
		local info = {}

		info.petId = v.left
		info.raceId = v.right

		table.insert(list, info)
	end

	return list
end

function JiuClgModel:isExtremeLockPet(activityId, stageId, raceId)
	local info = self:getAgentInfo(activityId)

	if info.extremeInfo and info.extremeInfo.lockRaceInfoDic then
		for i = 1, stageId - 1 do
			if info.extremeInfo.lockRaceInfoDic[i] and info.extremeInfo.lockRaceInfoDic[i][raceId] then
				return true
			end
		end
	end
end

function JiuClgModel:getCurExtremeLockList(activityId, stageId)
	local info = self:getAgentInfo(activityId)

	if info.extremeInfo and info.extremeInfo.lockRaceInfo then
		for i, v in ipairs(info.extremeInfo.lockRaceInfo) do
			if v.stageId == stageId then
				return v.races
			end
		end
	end
end

function JiuClgModel:getExtremeNeedLockCount(activityId)
	local info = self:getAgentInfo(activityId)

	return info.needLockCount
end

function JiuClgModel:getCurExtremePhaseId(activityId)
	local info = self:getAgentInfo(activityId)

	if info.extremeInfo then
		return info.extremeInfo.curPhaseId
	else
		return 1
	end
end

function JiuClgModel:getCurExtremeStageId(activityId)
	local info = self:getAgentInfo(activityId)

	if info.extremeInfo then
		return info.extremeInfo.curStageId
	else
		return 1
	end
end

JiuClgModel.instance = JiuClgModel.New()

return JiuClgModel
