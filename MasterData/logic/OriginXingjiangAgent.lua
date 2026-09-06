-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orixingjiang/agent/OriginXingjiangAgent.lua

module("logic.extensions.originxingjiang.agent.OriginXingjiangAgent", package.seeall)

local OriginXingjiangAgent = class("OriginXingjiangAgent", BaseAgent)

function OriginXingjiangAgent:sendPM_OriginXingjiangInfoReq(activityId)
	local req = OriginXingjiangExtension_pb.PM_OriginXingjiangInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginXingjiangAgent:handlePM_OriginXingjiangInfoRes(status, msg)
	if status == 0 then
		OrixingjiangModel.instance:setInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.OriginXingjiangInfoRes)
	end
end

function OriginXingjiangAgent:sendPM_OriginXingjiangClgReq(activityId, stageId, petIdToTransmogId, form)
	local req = OriginXingjiangExtension_pb.PM_OriginXingjiangClgReq()

	req.activityId = activityId
	req.stageId = stageId

	for i, v in ipairs(petIdToTransmogId or {}) do
		if v.transmogId > 0 then
			local a = req.petIdToTransmogId:add()

			a.left = v.petId
			a.right = v.transmogId
		end
	end

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function OriginXingjiangAgent:handlePM_OriginXingjiangClgRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.OriginXingjiangClgRes)
	end
end

function OriginXingjiangAgent:handlePM_OriginXingjiangNotifyClgRes(status, msg)
	if status == 0 then
		OrixingjiangController.instance:onNotifyClgRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.OriginXingjiangNotifyClgRes)
	end
end

function OriginXingjiangAgent:sendPM_OriginXingjiangResetReq(activityId, stageId)
	local req = OriginXingjiangExtension_pb.PM_OriginXingjiangResetReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function OriginXingjiangAgent:handlePM_OriginXingjiangResetRes(status, msg)
	if status == 0 then
		local activityId = msg.activityId
		local stageId = msg.stageId

		OrixingjiangModel.instance:onResetRes(activityId, stageId)
		GlobalDispatcher:dispatch(GlobalNotify.OriginXingjiangResetRes)
	end
end

OriginXingjiangAgent.instance = OriginXingjiangAgent.New()

return OriginXingjiangAgent
