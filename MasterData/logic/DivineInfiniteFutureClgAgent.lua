-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineinfinitefutureclg/agent/DivineInfiniteFutureClgAgent.lua

module("logic.extensions.divineinfinitefutureclg.agent.DivineInfiniteFutureClgAgent", package.seeall)

local DivineInfiniteFutureClgAgent = class("DivineInfiniteFutureClgAgent", BaseAgent)

function DivineInfiniteFutureClgAgent:sendPM_DivineInfiniteFutureClgGetInfoReq(activityId)
	local req = DivineInfiniteFutureClgExtension_pb.PM_DivineInfiniteFutureClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineInfiniteFutureClgAgent:handlePM_DivineInfiniteFutureClgGetInfoRes(status, msg)
	if status == 0 then
		DivineinfinitefutureclgModel.instance:setInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineInfiniteFutureClgGetInfoRes)
	end
end

function DivineInfiniteFutureClgAgent:sendPM_DivineInfiniteFutureFightReq(activityId, gridId, form)
	local req = DivineInfiniteFutureClgExtension_pb.PM_DivineInfiniteFutureFightReq()

	req.activityId = activityId
	req.gridId = gridId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function DivineInfiniteFutureClgAgent:handlePM_DivineInfiniteFutureFightRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.DivineInfiniteFutureFightRes)
	end
end

function DivineInfiniteFutureClgAgent:handlePM_NotifyDivineInfiniteFutureFightEndRes(status, msg)
	if status == 0 then
		DivineinfinitefutureclgController.instance:handlePM_NotifyDivineInfiniteFutureFightEndRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.NotifyDivineInfiniteFutureFightEndRes)
	end
end

function DivineInfiniteFutureClgAgent:sendPM_DivineInfiniteFutureClgConfirmReq(activityId, confirmNum, save)
	local req = DivineInfiniteFutureClgExtension_pb.PM_DivineInfiniteFutureClgConfirmReq()

	req.activityId = activityId
	req.confirmNum = confirmNum
	req.save = save

	self:sendMsg(req)
end

function DivineInfiniteFutureClgAgent:handlePM_DivineInfiniteFutureClgConfirmRes(status, msg)
	if status == 0 then
		DivineinfinitefutureclgModel.instance:onConfirmRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineInfiniteFutureClgConfirmRes)
	end
end

function DivineInfiniteFutureClgAgent:sendPM_DivineInfiniteFutureClgValidReq(activityId)
	local req = DivineInfiniteFutureClgExtension_pb.PM_DivineInfiniteFutureClgValidReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineInfiniteFutureClgAgent:handlePM_DivineInfiniteFutureClgValidRes(status, msg)
	if status == 0 then
		DivineinfinitefutureclgController.instance:handlePM_DivineInfiniteFutureClgValidRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineInfiniteFutureClgValidRes)
	end
end

DivineInfiniteFutureClgAgent.instance = DivineInfiniteFutureClgAgent.New()

return DivineInfiniteFutureClgAgent
