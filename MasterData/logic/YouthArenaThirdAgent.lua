-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/agent/YouthArenaThirdAgent.lua

module("logic.extensions.youtharenathird.agent.YouthArenaThirdAgent", package.seeall)

local YouthArenaThirdAgent = class("YouthArenaThirdAgent", BaseAgent)

local function _appendPbList(target, list)
	if list == nil then
		return
	end

	for _, item in ipairs(list) do
		local pbItem = target:add()

		pbItem:ParseFromString(item:SerializeToString())
	end
end

local function _appendDefenseFormList(target, formList)
	for _, data in ipairs(formList or {}) do
		local formInfo = target:add()

		formInfo.form:ParseFromString(data.form:SerializeToString())

		formInfo.buffId = checknumber(data.buffId)
	end
end

function YouthArenaThirdAgent:sendPM_YoungArenaKingS3GetInfoReq(activityId)
	local req = YoungArenaKingS3Extension_pb.PM_YoungArenaKingS3GetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function YouthArenaThirdAgent:handlePM_YoungArenaKingS3GetInfoRes(status, msg)
	if status == 0 then
		YouthArenaThirdController.instance:handlePM_YoungArenaKingS3GetInfoRes(msg)
	end
end

function YouthArenaThirdAgent:handlePM_YoungArenaKingS3NotifyStepChangeRes(status, msg)
	if status == 0 then
		YouthArenaThirdController.instance:handlePM_YoungArenaKingS3NotifyStepChangeRes(msg)
	end
end

function YouthArenaThirdAgent:sendPM_YoungArenaKingS3GetVideoReq(battleIds)
	local req = YoungArenaKingS3Extension_pb.PM_YoungArenaKingS3GetVideoReq()

	for _, battleId in ipairs(battleIds or {}) do
		req.battleId:append(battleId)
	end

	self:sendMsg(req)
end

function YouthArenaThirdAgent:handlePM_YoungArenaKingS3GetVideoRes(status, msg)
	YouthArenaThirdController.instance:handlePM_YoungArenaKingS3GetVideoRes(status, msg)
end

function YouthArenaThirdAgent:sendPM_YoungArenaKingS3GetDefenseForamtionReq(isFun, mode)
	local req = YoungArenaKingS3Extension_pb.PM_YoungArenaKingS3GetDefenseForamtionReq()

	req.isFun = isFun
	req.mode = mode

	self:sendMsg(req)
end

function YouthArenaThirdAgent:handlePM_YoungArenaKingS3GetDefenseForamtionRes(status, msg)
	YouthArenaThirdController.instance:handlePM_YoungArenaKingS3GetDefenseForamtionRes(status, msg)
end

function YouthArenaThirdAgent:sendPM_YoungArenaKingS3SetDefenseForamtionReq(isFun, mode, formList, stepId)
	local req = YoungArenaKingS3Extension_pb.PM_YoungArenaKingS3SetDefenseForamtionReq()

	req.isFun = isFun
	req.mode = mode

	_appendDefenseFormList(req.formList, formList)

	req.stepId = stepId

	self:sendMsg(req)
end

function YouthArenaThirdAgent:handlePM_YoungArenaKingS3SetDefenseForamtionRes(status, msg)
	YouthArenaThirdController.instance:handlePM_YoungArenaKingS3SetDefenseForamtionRes(status, msg)
end

function YouthArenaThirdAgent:sendPM_YoungArenaKingS3GetQualifierInfoReq(activityId, stepId, mode)
	local req = YoungArenaKingS3Extension_pb.PM_YoungArenaKingS3GetQualifierInfoReq()

	req.activityId = activityId
	req.stepId = stepId
	req.mode = mode

	self:sendMsg(req)
end

function YouthArenaThirdAgent:handlePM_YoungArenaKingS3GetQualifierInfoRes(status, msg)
	if status == 0 then
		YouthArenaThirdController.instance:handlePM_YoungArenaKingS3GetQualifierInfoRes(msg)
	end
end

function YouthArenaThirdAgent:sendPM_YoungArenaKingS3QualifierGetNewOpponentReq(activityId, stepId, mode)
	local req = YoungArenaKingS3Extension_pb.PM_YoungArenaKingS3QualifierGetNewOpponentReq()

	req.activityId = activityId
	req.stepId = stepId
	req.mode = mode

	self:sendMsg(req)
end

function YouthArenaThirdAgent:handlePM_YoungArenaKingS3QualifierGetNewOpponentRes(status, msg)
	if status == 0 then
		YouthArenaThirdController.instance:handlePM_YoungArenaKingS3QualifierGetNewOpponentRes(msg)
	end
end

function YouthArenaThirdAgent:sendPM_YoungArenaKingS3QualifierFightReq(activityId, stepId, mode, formList, useSystemProperty)
	local req = YoungArenaKingS3Extension_pb.PM_YoungArenaKingS3QualifierFightReq()

	req.activityId = activityId
	req.stepId = stepId
	req.mode = mode

	_appendPbList(req.formList, formList)

	req.useSystemProperty = checkbool(useSystemProperty)

	self:sendMsg(req)
end

function YouthArenaThirdAgent:handlePM_YoungArenaKingS3QualifierFightRes(status, msg)
	if status == 0 then
		YouthArenaThirdController.instance:handlePM_YoungArenaKingS3QualifierFightRes(msg)
	end
end

function YouthArenaThirdAgent:sendPM_YoungArenaKingS3QualifierRecordsReq(activityId, isFun, mode)
	local req = YoungArenaKingS3Extension_pb.PM_YoungArenaKingS3QualifierRecordsReq()

	req.activityId = activityId
	req.isFun = isFun
	req.mode = mode

	self:sendMsg(req)
end

function YouthArenaThirdAgent:handlePM_YoungArenaKingS3QualifierRecordsRes(status, msg)
	YouthArenaThirdController.instance:handlePM_YoungArenaKingS3QualifierRecordsRes(status, msg)
end

function YouthArenaThirdAgent:sendPM_YoungArenaKingS3QualifierRankInfoReq(activityId, zoneId, stepId)
	local req = YoungArenaKingS3Extension_pb.PM_YoungArenaKingS3QualifierRankInfoReq()

	req.activityId = activityId
	req.zoneId = zoneId
	req.stepId = stepId

	self:sendMsg(req)
end

function YouthArenaThirdAgent:handlePM_YoungArenaKingS3QualifierRankInfoRes(status, msg)
	if status == 0 then
		YouthArenaThirdController.instance:handlePM_YoungArenaKingS3QualifierRankInfoRes(msg)
	end
end

function YouthArenaThirdAgent:sendPM_YoungArenaKingS3QualifierPetRaceRankReq(activityId, stepId, winRank)
	local req = YoungArenaKingS3Extension_pb.PM_YoungArenaKingS3QualifierPetRaceRankReq()

	req.activityId = activityId
	req.stepId = stepId
	req.winRank = winRank

	self:sendMsg(req)
end

function YouthArenaThirdAgent:handlePM_YoungArenaKingS3QualifierPetRaceRankRes(status, msg)
	if status == 0 then
		YouthArenaThirdController.instance:handlePM_YoungArenaKingS3QualifierPetRaceRankRes(msg)
	end
end

function YouthArenaThirdAgent:sendPM_YoungArenaKingS3MyKnockoutInfoReq(activityId)
	local req = YoungArenaKingS3Extension_pb.PM_YoungArenaKingS3MyKnockoutInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function YouthArenaThirdAgent:handlePM_YoungArenaKingS3MyKnockoutInfoRes(status, msg)
	YouthArenaThirdController.instance:handlePM_YoungArenaKingS3MyKnockoutInfoRes(status, msg)
end

function YouthArenaThirdAgent:sendPM_YoungArenaKingS3GetKnockoutScheduleReq(activityId, viewGroupId, roundId)
	local req = YoungArenaKingS3Extension_pb.PM_YoungArenaKingS3GetKnockoutScheduleReq()

	req.activityId = activityId
	req.viewGroupId = viewGroupId
	req.roundId = roundId

	self:sendMsg(req)
end

function YouthArenaThirdAgent:handlePM_YoungArenaKingS3GetKnockoutScheduleRes(status, msg)
	YouthArenaThirdController.instance:handlePM_YoungArenaKingS3GetKnockoutScheduleRes(status, msg)
end

function YouthArenaThirdAgent:sendPM_YoungArenaKingS3GetDisplayInfoReq(activityId)
	local req = YoungArenaKingS3Extension_pb.PM_YoungArenaKingS3GetDisplayInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function YouthArenaThirdAgent:handlePM_YoungArenaKingS3GetDisplayInfoRes(status, msg)
	if status == 0 then
		YouthArenaThirdController.instance:handlePM_YoungArenaKingS3GetDisplayInfoRes(msg)
	end
end

YouthArenaThirdAgent.instance = YouthArenaThirdAgent.New()

return YouthArenaThirdAgent
