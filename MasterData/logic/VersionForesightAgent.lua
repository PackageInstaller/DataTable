-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/versionforesight/agent/VersionForesightAgent.lua

module("logic.extensions.versionforesight.agent.VersionForesightAgent", package.seeall)

local VersionForesightAgent = class("VersionForesightAgent", BaseAgent)

function VersionForesightAgent:sendPM_VersionForesightGetInfoReq(activityId)
	local req = VersionForesightExtension_pb.PM_VersionForesightGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function VersionForesightAgent:handlePM_VersionForesightGetInfoRes(status, msg)
	if status == 0 then
		VersionForesightModel.instance:setInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.VersionForesightGetInfo)
	end
end

function VersionForesightAgent:sendPM_VersionForesightShakeDiceReq(activityId)
	local req = VersionForesightExtension_pb.PM_VersionForesightShakeDiceReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function VersionForesightAgent:handlePM_VersionForesightShakeDiceRes(status, msg)
	if status == 0 then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		VersionForesightModel.instance:setNewInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.VersionForesightShakeDice)
	end
end

function VersionForesightAgent:sendPM_VersionForesightGainBoxPrizeReq(activityId)
	local req = VersionForesightExtension_pb.PM_VersionForesightGainBoxPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function VersionForesightAgent:handlePM_VersionForesightGainBoxPrizeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.VersionForesightGainBoxPrize)
	end
end

VersionForesightAgent.instance = VersionForesightAgent.New()

return VersionForesightAgent
