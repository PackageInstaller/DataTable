-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonking/agent/DragonKingChallengeAgent.lua

module("logic.extensions.dragonkingchallenge.agent.DragonKingChallengeAgent", package.seeall)

local DragonKingChallengeAgent = class("DragonKingChallengeAgent", BaseAgent)

function DragonKingChallengeAgent:ctor()
	return
end

function DragonKingChallengeAgent:setExtId(extId)
	DragonKingChallengeAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function DragonKingChallengeAgent:sendPM_DragonKingClgGetInfoReq(activityId)
	local req = DragonKingChallengeExtension_pb.PM_DragonKingClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DragonKingChallengeAgent:handlePM_DragonKingClgGetInfoRes(status, msg)
	if status == 0 then
		DragonKingChallengeController.instance:handlePM_DragonKingClgGetInfoRes(msg)
	end
end

function DragonKingChallengeAgent:sendPM_DragonKingClgFightReq(activityId, stageId, form_pb, guardCreepsId_i32_Ary)
	local req = DragonKingChallengeExtension_pb.PM_DragonKingClgFightReq()

	req.activityId = activityId
	req.stageId = stageId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	for i, v1 in ipairs(guardCreepsId_i32_Ary) do
		req.guardCreepsId:append(v1)
	end

	self:sendMsg(req)
end

function DragonKingChallengeAgent:handlePM_DragonKingClgFightRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function DragonKingChallengeAgent:sendPM_DragonKingClgGainProgressPrizeReq(activityId, dataBitId)
	local req = DragonKingChallengeExtension_pb.PM_DragonKingClgGainProgressPrizeReq()

	req.activityId = activityId
	req.dataBitId = dataBitId

	self:sendMsg(req)
end

function DragonKingChallengeAgent:handlePM_DragonKingClgGainProgressPrizeRes(status, msg)
	if status == 0 then
		DragonKingChallengeController.instance:handlePM_DragonKingClgGainProgressPrizeRes(msg)
	end
end

function DragonKingChallengeAgent:sendPM_DragonKingClgGetRankReq(activityId)
	local req = DragonKingChallengeExtension_pb.PM_DragonKingClgGetRankReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DragonKingChallengeAgent:handlePM_DragonKingClgGetRankRes(status, msg)
	if status == 0 then
		DragonKingChallengeController.instance:handlePM_DragonKingClgGetRankRes(msg)
	end
end

function DragonKingChallengeAgent:handlePM_DragonKingClgNotifyFightResultRes(status, msg)
	if status == 0 then
		DragonKingChallengeController.instance:onGetFighMsg(msg)
	end
end

DragonKingChallengeAgent.instance = DragonKingChallengeAgent.New()

return DragonKingChallengeAgent
