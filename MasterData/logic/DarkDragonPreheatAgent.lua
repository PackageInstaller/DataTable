-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cardhot/agent/DarkDragonPreheatAgent.lua

module("logic.extensions.cardhot.agent.DarkDragonPreheatAgent", package.seeall)

local DarkDragonPreheatAgent = class("DarkDragonPreheatAgent", BaseAgent)

function DarkDragonPreheatAgent:ctor()
	return
end

function DarkDragonPreheatAgent:setExtId(extId)
	DarkDragonPreheatAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function DarkDragonPreheatAgent:sendPM_DarkDragonPreheatGetInfoReq(activityId)
	local req = DarkDragonPreheatExtension_pb.PM_DarkDragonPreheatGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DarkDragonPreheatAgent:handlePM_DarkDragonPreheatGetInfoRes(status, msg)
	if status == 0 then
		CardHotModel.instance:getGetAllTask(msg)
	end
end

function DarkDragonPreheatAgent:sendPM_DarkDragonPreheatGainTaskPrizeReq(activityId, taskId)
	local req = DarkDragonPreheatExtension_pb.PM_DarkDragonPreheatGainTaskPrizeReq()

	req.activityId = activityId
	req.taskId = taskId

	self:sendMsg(req)
end

function DarkDragonPreheatAgent:handlePM_DarkDragonPreheatGainTaskPrizeRes(status, msg)
	if status == 0 then
		CardHotModel.instance:onGetTaskPrize(msg)
	end
end

function DarkDragonPreheatAgent:sendPM_DarkDragonPreheatGainProgressPrizeReq(activityId, id)
	local req = DarkDragonPreheatExtension_pb.PM_DarkDragonPreheatGainProgressPrizeReq()

	req.activityId = activityId
	req.id = id

	self:sendMsg(req)
end

function DarkDragonPreheatAgent:handlePM_DarkDragonPreheatGainProgressPrizeRes(status, msg)
	if status == 0 then
		CardHotModel.instance:onGetPrize(msg)
	end
end

function DarkDragonPreheatAgent:sendPM_DarkDragonPreheatFinishStoryReq(activityId, taskId)
	local req = DarkDragonPreheatExtension_pb.PM_DarkDragonPreheatFinishStoryReq()

	req.activityId = activityId
	req.taskId = taskId

	self:sendMsg(req)
end

function DarkDragonPreheatAgent:handlePM_DarkDragonPreheatFinishStoryRes(status, msg)
	if status == 0 then
		CardHotModel.instance:onPlayStory(msg)
	end
end

DarkDragonPreheatAgent.instance = DarkDragonPreheatAgent.New()

return DarkDragonPreheatAgent
