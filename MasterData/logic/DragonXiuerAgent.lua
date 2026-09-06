-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonxiuer/agent/DragonXiuerAgent.lua

module("logic.extensions.dragonxiuer.agent.DragonXiuerAgent", package.seeall)

local DragonXiuerAgent = class("DragonXiuerAgent", BaseAgent)

function DragonXiuerAgent:sendPM_DragonXiuerGetInfoReq(activityId)
	local req = DragonXiuerExtension_pb.PM_DragonXiuerGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DragonXiuerAgent:handlePM_DragonXiuerGetInfoRes(status, msg)
	if status == 0 then
		DragonXiuerController.instance:handlePM_DragonXiuerGetInfoRes(msg)
	end
end

function DragonXiuerAgent:sendPM_DragonXiuerChallengeDestroyModeReq(activityId, stageId, teamIndex, form)
	local req = DragonXiuerExtension_pb.PM_DragonXiuerChallengeDestroyModeReq()

	req.activityId = activityId
	req.stageId = stageId
	req.teamIndex = teamIndex

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DragonXiuerAgent:handlePM_DragonXiuerChallengeDestroyModeRes(status, msg)
	if status == 0 then
		DragonXiuerController.instance:handlePM_DragonXiuerChallengeDestroyModeRes(msg)
	end
end

function DragonXiuerAgent:sendPM_DragonXiuerChallengeSoulModeReq(activityId, form)
	local req = DragonXiuerExtension_pb.PM_DragonXiuerChallengeSoulModeReq()

	req.activityId = activityId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DragonXiuerAgent:handlePM_DragonXiuerChallengeSoulModeRes(status, msg)
	if status == 0 then
		DragonXiuerController.instance:handlePM_DragonXiuerChallengeSoulModeRes(msg)
	end
end

function DragonXiuerAgent:sendPM_DragonXiuerResetDestroyModeTeamReq(activityId, stageId, teamIndex)
	local req = DragonXiuerExtension_pb.PM_DragonXiuerResetDestroyModeTeamReq()

	req.activityId = activityId
	req.stageId = stageId
	req.teamIndex = teamIndex

	self:sendMsg(req)
end

function DragonXiuerAgent:handlePM_DragonXiuerResetDestroyModeTeamRes(status, msg)
	if status == 0 then
		DragonXiuerController.instance:handlePM_DragonXiuerResetDestroyModeTeamRes(msg)
	end
end

function DragonXiuerAgent:handlePM_Notify_DragonXiuerDestroyModeRes(status, msg)
	if status == 0 then
		DragonXiuerController.instance:handlePM_Notify_DragonXiuerDestroyModeRes(msg)
	end
end

function DragonXiuerAgent:handlePM_Notify_DragonXiuerSoulModeRes(status, msg)
	if status == 0 then
		DragonXiuerController.instance:handlePM_Notify_DragonXiuerSoulModeRes(msg)
	end
end

DragonXiuerAgent.instance = DragonXiuerAgent.New()

return DragonXiuerAgent
