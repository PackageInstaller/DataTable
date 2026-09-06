-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamyouth/agent/DreamyouthAgent.lua

module("logic.extensions.dreamyouth.agent.DreamYouthAgent", package.seeall)

local DreamYouthAgent = class("DreamYouthAgent", BaseAgent)

function DreamYouthAgent:sendPM_DreamYouthGetTaskInfosReq(activityId)
	local req = DreamYouthExtension_pb.PM_DreamYouthGetTaskInfosReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DreamYouthAgent:handlePM_DreamYouthGetTaskInfosRes(status, msg)
	if status == 0 then
		DreamyouthController.instance:handleTaskInfo(msg)
	end
end

function DreamYouthAgent:sendPM_DreamYouthGainTaskPrizeReq(activityId, taskId)
	local req = DreamYouthExtension_pb.PM_DreamYouthGainTaskPrizeReq()

	req.activityId = activityId
	req.taskId = taskId
	self.taskId = taskId

	self:sendMsg(req)
end

function DreamYouthAgent:handlePM_DreamYouthGainTaskPrizeRes(status, msg)
	if status == 0 then
		DreamyouthController.instance:handleGainTaskPrize(msg, self.taskId)
	end

	self.taskId = nil
end

function DreamYouthAgent:sendPM_GetDreamYouthStrengthenInfoReq(activityId)
	local req = DreamYouthExtension_pb.PM_GetDreamYouthStrengthenInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DreamYouthAgent:handlePM_GetDreamYouthStrengthenInfoRes(status, msg)
	if status == 0 then
		DreamyouthController.instance:handleStrengthenInfo(msg)
	end
end

function DreamYouthAgent:sendPM_DreamYouthStrengthenReq(activityId, strengthenType, petId, useNum)
	if self.isLockStrengthen then
		return
	end

	self.isLockStrengthen = true

	local req = DreamYouthExtension_pb.PM_DreamYouthStrengthenReq()

	req.activityId = activityId
	req.strengthenType = strengthenType
	req.petId = petId
	req.useNum = useNum
	self._strengthenType = strengthenType

	self:sendMsg(req)
end

function DreamYouthAgent:handlePM_DreamYouthStrengthenRes(status, msg)
	if status == 0 then
		DreamyouthController.instance:handleStrengthen(msg, self._strengthenType)
	end

	self._strengthenType = nil
	self.isLockStrengthen = false
end

DreamYouthAgent.instance = DreamYouthAgent.New()

return DreamYouthAgent
