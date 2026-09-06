-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/agent/FamilyTaskAgent.lua

module("logic.extensions.newfamily.agent.FamilyTaskAgent", package.seeall)

local FamilyTaskAgent = class("FamilyTaskAgent", BaseAgent)

function FamilyTaskAgent:sendPM_FamilyTaskInfoReq()
	local req = FamilyTaskExtension_pb.PM_FamilyTaskInfoReq()

	self:sendMsg(req)
end

function FamilyTaskAgent:handlePM_FamilyTaskInfoRes(status, msg)
	if status == 0 then
		FamilyHonorController.instance:scPushFamilyTaskInfo(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.UpdataNewFamilyTask, status)
	end
end

function FamilyTaskAgent:sendPM_FamilyTaskGainPrizeReq(taskId_i32_Ary)
	local req = FamilyTaskExtension_pb.PM_FamilyTaskGainPrizeReq()

	for i, v1 in ipairs(taskId_i32_Ary) do
		req.taskId:append(v1)
	end

	self:sendMsg(req)
end

function FamilyTaskAgent:handlePM_FamilyTaskGainPrizeRes(status, msg)
	if status == 0 then
		local newGainPrizeTaskId = msg.newGainPrizeTaskId

		FamilyHonorController.instance:scPushFamilyTaskGainPrize(newGainPrizeTaskId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_FamilyTaskGainPrizeRes, status, msg)
end

FamilyTaskAgent.instance = FamilyTaskAgent.New()

return FamilyTaskAgent
