-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexingjiangclg/agent/DivineXingJiangClgAgent.lua

module("logic.extensions.divinexingjiangclg.agent.DivineXingJiangClgAgent", package.seeall)

local DivineXingJiangClgAgent = class("DivineXingJiangClgAgent", BaseAgent)

function DivineXingJiangClgAgent:sendPM_DivineXingJiangClgGetInfoReq(activityId)
	local req = DivineXingJiangClgExtension_pb.PM_DivineXingJiangClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineXingJiangClgAgent:handlePM_DivineXingJiangClgGetInfoRes(status, msg)
	if status == 0 then
		DivineXingJiangClgModel.instance:onGetInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineXingJiangClgGetInfoRes)
	end
end

function DivineXingJiangClgAgent:sendPM_DivineXingJiangClgFightReq(activityId, stageId, form)
	local req = DivineXingJiangClgExtension_pb.PM_DivineXingJiangClgFightReq()

	req.activityId = activityId
	req.stageId = stageId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function DivineXingJiangClgAgent:handlePM_DivineXingJiangClgFightRes(status, msg)
	if status == 0 then
		DivineXingJiangClgModel.instance:onFightRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineXingJiangClgFightRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function DivineXingJiangClgAgent:handlePM_DivineXingJiangClgNotifyFightResultRes(status, msg)
	if status == 0 then
		DivineXingJiangClgModel.instance:onNotifyFightResultRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineXingJiangClgNotifyFightResultRes, msg.activityId, msg.stageId)
	end
end

function DivineXingJiangClgAgent:sendPM_DivineXingJiangClgPlayGameReq(activityId, addProgress)
	local req = DivineXingJiangClgExtension_pb.PM_DivineXingJiangClgPlayGameReq()

	req.activityId = activityId
	req.addProgress = addProgress

	self:sendMsg(req)
end

function DivineXingJiangClgAgent:handlePM_DivineXingJiangClgPlayGameRes(status, msg)
	if status == 0 then
		DivineXingJiangClgModel.instance:onPlayGameRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineXingJiangClgPlayGameRes)
	end
end

DivineXingJiangClgAgent.instance = DivineXingJiangClgAgent.New()

return DivineXingJiangClgAgent
