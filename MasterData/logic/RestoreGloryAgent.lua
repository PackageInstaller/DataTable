-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recastglory/agent/RestoreGloryAgent.lua

module("logic.extensions.restoreglory.agent.RestoreGloryAgent", package.seeall)

local RestoreGloryAgent = class("RestoreGloryAgent", BaseAgent)

function RestoreGloryAgent:sendPM_RestoreGloryGetInfoReq(activityId)
	local req = RestoreGloryExtension_pb.PM_RestoreGloryGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function RestoreGloryAgent:handlePM_RestoreGloryGetInfoRes(status, msg)
	if status == 0 then
		RestoreGloryController.instance:handlePM_RestoreGloryGetInfoRes(msg)
	end
end

function RestoreGloryAgent:sendPM_RestoreGloryGainSpacePrizeReq(activityId, progressId)
	local req = RestoreGloryExtension_pb.PM_RestoreGloryGainSpacePrizeReq()

	req.activityId = activityId
	req.progressId = progressId

	self:sendMsg(req)
end

function RestoreGloryAgent:handlePM_RestoreGloryGainSpacePrizeRes(status, msg)
	if status == 0 then
		RestoreGloryController.instance:handlePM_RestoreGloryGainSpacePrizeRes(msg)
	end
end

function RestoreGloryAgent:sendPM_RestoreGloryReq(activityId, restoreId)
	local req = RestoreGloryExtension_pb.PM_RestoreGloryReq()

	req.activityId = activityId
	req.restoreId = restoreId

	self:sendMsg(req)
end

function RestoreGloryAgent:handlePM_RestoreGloryRes(status, msg)
	if status == 0 then
		RestoreGloryController.instance:handlePM_RestoreGloryRes(status, msg)
	end
end

RestoreGloryAgent.instance = RestoreGloryAgent.New()

return RestoreGloryAgent
