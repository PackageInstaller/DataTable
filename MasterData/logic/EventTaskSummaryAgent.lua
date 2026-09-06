-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/agent/EventTaskSummaryAgent.lua

module("logic.extensions.eventtasksummary.agent.EventTaskSummaryAgent", package.seeall)

local EventTaskSummaryAgent = class("EventTaskSummaryAgent", BaseAgent)

function EventTaskSummaryAgent:sendPM_EventTaskSummaryGetInfoReq(activityId)
	local req = EventTaskSummaryExtension_pb.PM_EventTaskSummaryGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function EventTaskSummaryAgent:handlePM_EventTaskSummaryGetInfoRes(status, msg)
	if status == 0 then
		EventTaskSummaryController.instance:onHandleEventTaskSummaryGetInfoRes(msg)
	end
end

function EventTaskSummaryAgent:sendPM_EventTaskSummaryGainTaskPrizeReq(activityId, taskId_i32_Ary)
	local req = EventTaskSummaryExtension_pb.PM_EventTaskSummaryGainTaskPrizeReq()

	req.activityId = activityId

	for _, v in ipairs(taskId_i32_Ary or {}) do
		req.taskId:append(v)
	end

	self:sendMsg(req)
end

function EventTaskSummaryAgent:handlePM_EventTaskSummaryGainTaskPrizeRes(status, msg)
	if status == 0 then
		EventTaskSummaryController.instance:onHandleEventTaskSummaryGainTaskPrizeRes(msg)
	end
end

function EventTaskSummaryAgent:sendPM_EventTaskSummaryViewReq(activityId, id)
	local req = EventTaskSummaryExtension_pb.PM_EventTaskSummaryViewReq()

	req.activityId = activityId
	req.id = id

	self:sendMsg(req)
end

function EventTaskSummaryAgent:handlePM_EventTaskSummaryViewRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

EventTaskSummaryAgent.instance = EventTaskSummaryAgent.New()

return EventTaskSummaryAgent
