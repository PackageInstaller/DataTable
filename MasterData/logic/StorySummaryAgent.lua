-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/storysummary/agent/StorySummaryAgent.lua

module("logic.extensions.storysummary.agent.StorySummaryAgent", package.seeall)

local StorySummaryAgent = class("StorySummaryAgent", BaseAgent)

function StorySummaryAgent:ctor()
	return
end

function StorySummaryAgent:sendPM_StorySummaryInfoReq()
	local req = StorySummaryExtension_pb.PM_StorySummaryInfoReq()

	self:sendMsg(req)
end

function StorySummaryAgent:handlePM_StorySummaryInfoRes(status, msg)
	if status == 0 then
		StorySummaryController.instance:onHandleStorySummaryInfoRes(msg)
	end
end

function StorySummaryAgent:sendPM_StorySummaryFightOrViewReq(chapterId, stageId, form)
	local req = StorySummaryExtension_pb.PM_StorySummaryFightOrViewReq()

	req.requestParams.chapterId = chapterId
	req.requestParams.stageId = stageId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function StorySummaryAgent:handlePM_StorySummaryFightOrViewRes(status, msg)
	StorySummaryController.instance:onHandleStorySummaryFightOrViewRes(status, msg)
end

function StorySummaryAgent:handlePM_NotifyStorySummaryFightEndRes(status, msg)
	StorySummaryController.instance:onHandleNotifyStorySummaryFightEndRes(status, msg)
end

StorySummaryAgent.instance = StorySummaryAgent.New()

return StorySummaryAgent
