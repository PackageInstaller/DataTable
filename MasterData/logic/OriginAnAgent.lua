-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originan/agent/OriginAnAgent.lua

module("logic.extensions.originan.agent.OriginAnAgent", package.seeall)

local OriginAnAgent = class("OriginAnAgent", BaseAgent)

function OriginAnAgent:sendPM_OriginAnInfoReq(activityId)
	local req = OriginAnExtension_pb.PM_OriginAnInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginAnAgent:handlePM_OriginAnInfoRes(status, msg)
	if status == 0 then
		OriginAnController.instance:handlePM_OriginAnInfoRes(msg)
	end
end

function OriginAnAgent:sendPM_OriginAnResetExtremeReq(activityId, stageId)
	local req = OriginAnExtension_pb.PM_OriginAnResetExtremeReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function OriginAnAgent:handlePM_OriginAnResetExtremeRes(status, msg)
	if status == 0 then
		OriginAnController.instance:handlePM_OriginAnResetExtremeRes(msg)
	end
end

function OriginAnAgent:sendPM_OriginAnExtremeClgReq(activityId, form, stageId)
	local req = OriginAnExtension_pb.PM_OriginAnExtremeClgReq()

	req.activityId = activityId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function OriginAnAgent:handlePM_OriginAnExtremeClgRes(status, msg)
	if status == 0 then
		OriginAnController.instance:handlePM_OriginAnExtremeClgRes(msg)
	end
end

function OriginAnAgent:handlePM_OriginAnNotifyExtremeClgRes(status, msg)
	if status == 0 then
		OriginAnController.instance:handlePM_OriginAnNotifyExtremeClgRes(msg)
	end
end

function OriginAnAgent:sendPM_OriginAnNormalClgReq(activityId, stageId, form)
	local req = OriginAnExtension_pb.PM_OriginAnNormalClgReq()

	req.activityId = activityId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function OriginAnAgent:handlePM_OriginAnNormalClgRes(status, msg)
	if status == 0 then
		OriginAnController.instance:handlePM_OriginAnNormalClgRes(msg)
	end
end

function OriginAnAgent:handlePM_OriginAnNotifyNormalClgRes(status, msg)
	if status == 0 then
		OriginAnController.instance:handlePM_OriginAnNotifyNormalClgRes(msg)
	end
end

function OriginAnAgent:sendPM_OriginAnGainNormalProgressReq(activityId, progressId)
	local req = OriginAnExtension_pb.PM_OriginAnGainNormalProgressReq()

	req.activityId = activityId
	req.progressId = progressId

	self:sendMsg(req)
end

function OriginAnAgent:handlePM_OriginAnGainNormalProgressRes(status, msg)
	if status == 0 then
		OriginAnController.instance:handlePM_OriginAnGainNormalProgressRes(msg)
	end
end

OriginAnAgent.instance = OriginAnAgent.New()

return OriginAnAgent
