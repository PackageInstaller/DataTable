-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangkongunion/agent/ChuangKongUnionAgent.lua

module("logic.extensions.chuangkongunion.agent.ChuangKongUnionAgent", package.seeall)

local ChuangKongUnionAgent = class("ChuangKongUnionAgent", BaseAgent)

function ChuangKongUnionAgent:sendPM_CKUGetBreachFormInfoReq(activityId)
	local req = ChuangKongUnionExtension_pb.PM_CKUGetBreachFormInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ChuangKongUnionAgent:handlePM_CKUGetBreachFormInfoRes(status, msg)
	if status == 0 then
		ChuangkongunionModel.instance:onCKUGetTrialInfoRes(msg)
		ChuangkongunionController.instance:onDataChange(msg)
	end
end

function ChuangKongUnionAgent:sendPM_CKUGetDailyTaskInfoReq(activityId)
	local req = ChuangKongUnionExtension_pb.PM_CKUGetDailyTaskInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ChuangKongUnionAgent:handlePM_CKUGetDailyTaskInfoRes(status, msg)
	if status == 0 then
		ChuangkongunionModel.instance:onCKUGetDailyTaskInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.CKUGetDailyTaskInfoRes)
		ChuangkongunionController.instance:onDataChange(msg)
	end
end

function ChuangKongUnionAgent:sendPM_CKUDoBreachFormTaskReq(activityId, taskId, stage, directPass, form)
	local req = ChuangKongUnionExtension_pb.PM_CKUDoBreachFormTaskReq()

	req.activityId = activityId
	req.taskId = taskId
	req.stage = stage
	req.directPass = directPass

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function ChuangKongUnionAgent:handlePM_CKUDoBreachFormTaskRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function ChuangKongUnionAgent:sendPM_CKUDoDailyTaskReq(activityId, taskId, sweep, params)
	local req = ChuangKongUnionExtension_pb.PM_CKUDoDailyTaskReq()

	req.activityId = activityId
	req.taskId = taskId
	req.sweep = sweep

	if params ~= nil then
		for i, v in ipairs(params) do
			req.params:append(v)
		end
	end

	self:sendMsg(req)
end

function ChuangKongUnionAgent:handlePM_CKUDoDailyTaskRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function ChuangKongUnionAgent:handlePM_CKUBreachFormEndRes(status, msg)
	if status == 0 then
		ChuangkongunionModel.instance:onCKUTrialEndRes(msg)
		ChuangkongunionController.instance:onDataChange(msg)
	end
end

function ChuangKongUnionAgent:handlePM_CKUDailyTaskEndRes(status, msg)
	if status == 0 then
		ChuangkongunionModel.instance:onCKUDailyTaskEndRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.CKUDailyTaskEndRes)
		ChuangkongunionController.instance:onDataChange(msg)
	end
end

ChuangKongUnionAgent.instance = ChuangKongUnionAgent.New()

return ChuangKongUnionAgent
