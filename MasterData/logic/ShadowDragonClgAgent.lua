-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shadowdragonclg/agent/ShadowDragonClgAgent.lua

module("logic.extensions.shadowdragonclg.agent.ShadowDragonClgAgent", package.seeall)

local ShadowDragonClgAgent = class("ShadowDragonClgAgent", BaseAgent)

function ShadowDragonClgAgent:sendPM_ShadowDragonClgGetInfoReq(activityId)
	local req = ShadowDragonClgExtension_pb.PM_ShadowDragonClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ShadowDragonClgAgent:handlePM_ShadowDragonClgGetInfoRes(status, msg)
	if status == 0 then
		ShadowdragonclgModel.instance:setInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ShadowDragonClgGetInfoRes)
	end
end

function ShadowDragonClgAgent:sendPM_ShadowDragonClgNowStageFightReq(activityId, stageId, form)
	local req = ShadowDragonClgExtension_pb.PM_ShadowDragonClgNowStageFightReq()

	req.activityId = activityId
	req.stageId = stageId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function ShadowDragonClgAgent:handlePM_ShadowDragonClgNowStageFightRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.ShadowDragonClgNowStageFightRes)
	end
end

function ShadowDragonClgAgent:handlePM_ShadowDragonClgNowStageFightNotifyRes(status, msg)
	if status == 0 then
		ShadowdragonclgController.instance:onNowStageFightNotifyRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ShadowDragonClgNowStageFightNotifyRes)
	end
end

function ShadowDragonClgAgent:sendPM_ShadowDragonClgResetAllStageReq(activityId)
	local req = ShadowDragonClgExtension_pb.PM_ShadowDragonClgResetAllStageReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ShadowDragonClgAgent:handlePM_ShadowDragonClgResetAllStageRes(status, msg)
	if status == 0 then
		ShadowdragonclgModel.instance:onResetAllStageRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ShadowDragonClgResetAllStageRes)
	end
end

function ShadowDragonClgAgent:sendPM_ShadowDragonClgFuturePassStageFightReq(activityId, stageId, form, useBuff, param)
	local req = ShadowDragonClgExtension_pb.PM_ShadowDragonClgFuturePassStageFightReq()

	req.activityId = activityId
	req.stageId = stageId

	req.form:ParseFromString(form:SerializeToString())

	req.useBuff = useBuff
	req.param = param

	self:sendMsg(req)
end

function ShadowDragonClgAgent:handlePM_ShadowDragonClgFuturePassStageFightRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.ShadowDragonClgFuturePassStageFightRes)
	end
end

function ShadowDragonClgAgent:handlePM_ShadowDragonClgFuturePassStageFightNotifyRes(status, msg)
	if status == 0 then
		ShadowdragonclgModel.instance:onFuturePassStageFightNotifyRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ShadowDragonClgFuturePassStageFightNotifyRes)
	end
end

function ShadowDragonClgAgent:sendPM_ShadowDragonClgSelectBuffReq(activityId, stageId, selectBuffId)
	local req = ShadowDragonClgExtension_pb.PM_ShadowDragonClgSelectBuffReq()

	req.activityId = activityId
	req.stageId = stageId
	req.selectBuffId = selectBuffId

	self:sendMsg(req)
end

function ShadowDragonClgAgent:handlePM_ShadowDragonClgSelectBuffRes(status, msg)
	if status == 0 then
		ShadowdragonclgModel.instance:onSelectBuffRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ShadowDragonClgSelectBuffRes)
	end
end

function ShadowDragonClgAgent:sendPM_ShadowDragonClgConfirmReq(activityId, stageId, selectBuffId)
	local req = ShadowDragonClgExtension_pb.PM_ShadowDragonClgConfirmReq()

	req.activityId = activityId
	req.stageId = stageId
	req.selectBuffId = selectBuffId

	self:sendMsg(req)
end

function ShadowDragonClgAgent:handlePM_ShadowDragonClgConfirmRes(status, msg)
	if status == 0 then
		local changeSetId = msg.changeSetId

		ShadowdragonclgModel.instance:onConfirmRes(msg)
		ShadowdragonclgController.instance:saveChangeSetToTemp(changeSetId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.ShadowDragonClgConfirmRes)
end

ShadowDragonClgAgent.instance = ShadowDragonClgAgent.New()

return ShadowDragonClgAgent
