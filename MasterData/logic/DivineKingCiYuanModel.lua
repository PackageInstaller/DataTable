-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingciyuan/model/DivineKingCiYuanModel.lua

module("logic.extensions.divinekingciyuan.model.DivineKingCiYuanModel", package.seeall)

local DivineKingCiYuanModel = class("DivineKingCiYuanModel", BaseModel)

function DivineKingCiYuanModel:onInit()
	self:onReset()
end

function DivineKingCiYuanModel:onReset()
	self._info = {}
	self._fightInfo = {}
end

function DivineKingCiYuanModel:onDivineKingCiYuanGetInfoRes(msg)
	local pb = GameUtil.pbToTable(msg)

	self._info[pb.activityId] = pb.phaseList
end

function DivineKingCiYuanModel:onDivineKingCiYuanNotifyFightResultRes(msg)
	local pb = GameUtil.pbToTable(msg)

	if pb.phaseId == 3 and pb.changeSetId then
		print("暂存奖励 changeSetId = ", pb.changeSetId)
		MaterialController.instance:saveChangeSetToTemp(pb.changeSetId)
	end

	self._fightInfo[pb.activityId] = pb
end

function DivineKingCiYuanModel:onDivineKingCiYuanResetRes(msg)
	DivineKingCiYuanAgent.instance:sendPM_DivineKingCiYuanGetInfoReq(msg.activityId)
end

function DivineKingCiYuanModel:getInfo(activityId)
	return self._info[activityId]
end

function DivineKingCiYuanModel:getCurPhaseId(activityId)
	local phaseList = self._info[activityId]

	if not phaseList then
		return 1
	end

	local curPhaseId = 0

	for i, v in ipairs(phaseList) do
		if not v.isPass then
			break
		end

		curPhaseId = i
	end

	return curPhaseId + 1
end

function DivineKingCiYuanModel:getCurStageId(activityId, phaseId)
	local phaseList = self._info[activityId]

	if not phaseList or not phaseList[phaseId] or not phaseList[phaseId].stageList then
		return 0
	end

	local stageList = phaseList[phaseId].stageList
	local curStageId = 0

	for i, v in ipairs(stageList) do
		if not v.isPass then
			break
		end

		curStageId = i
	end

	return curStageId + 1
end

function DivineKingCiYuanModel:getStageInfos(activityId, phaseId)
	local phaseList = self._info[activityId]

	if phaseList and phaseList[phaseId] then
		return phaseList[phaseId].stageList
	end

	return nil
end

function DivineKingCiYuanModel:getStageInfoById(activityId, phaseId, stageId)
	local stageList = self:getStageInfos(activityId, phaseId)

	if stageList then
		return stageList[stageId]
	end

	return nil
end

function DivineKingCiYuanModel:getFightInfo(activityId)
	return self._fightInfo[activityId]
end

function DivineKingCiYuanModel:getLockRaceIds(activityId, phaseId)
	local lockRaceIds = {}
	local stageList = self:getStageInfos(activityId, phaseId)

	if stageList then
		for i, v in ipairs(stageList) do
			if v.lockRaceIds then
				for i, v in ipairs(v.lockRaceIds) do
					table.insert(lockRaceIds, v)
				end
			end
		end
	end

	return lockRaceIds
end

DivineKingCiYuanModel.instance = DivineKingCiYuanModel.New()

return DivineKingCiYuanModel
