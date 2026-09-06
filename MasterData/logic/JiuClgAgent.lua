-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jiuclg/agent/JiuClgAgent.lua

module("logic.extensions.jiuclg.agent.JiuClgAgent", package.seeall)

local JiuClgAgent = class("JiuClgAgent", BaseAgent)

function JiuClgAgent:sendPM_JiuClgGetInfoReq(activityId)
	local req = JiuClgExtension_pb.PM_JiuClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function JiuClgAgent:handlePM_JiuClgGetInfoRes(status, msg)
	if status == 0 then
		JiuClgModel.instance:onJiuClgGetInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.JiuClgGetInfoRes)
	end
end

function JiuClgAgent:sendPM_JiuClgNormalFightReq(activityId, form)
	local req = JiuClgExtension_pb.PM_JiuClgNormalFightReq()

	req.activityId = activityId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function JiuClgAgent:handlePM_JiuClgNormalFightRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function JiuClgAgent:handlePM_JiuClgNotifyNormalFightResultRes(status, msg)
	if status == 0 then
		JiuClgModel.instance:onJiuClgNotifyNormalFightResultRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.JiuClgNotifyNormalFightResultRes)
	end
end

function JiuClgAgent:sendPM_JiuClgExtremeFightReq(activityId, form)
	local req = JiuClgExtension_pb.PM_JiuClgExtremeFightReq()

	req.activityId = activityId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function JiuClgAgent:handlePM_JiuClgExtremeFightRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function JiuClgAgent:handlePM_JiuClgNotifyExtremeFightResultRes(status, msg)
	if status == 0 then
		JiuClgModel.instance:onJiuClgNotifyExtremeFightResultRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.JiuClgNotifyExtremeFightResultRes)
	end
end

function JiuClgAgent:sendPM_JiuClgExtremeFightConfirmReq(activityId, confirmNum, save, lockRaces)
	local req = JiuClgExtension_pb.PM_JiuClgExtremeFightConfirmReq()

	req.activityId = activityId
	req.confirmNum = confirmNum
	req.save = save

	if lockRaces and #lockRaces > 0 then
		for i, v in ipairs(lockRaces) do
			req.lockRaces:append(v)
		end
	end

	self:sendMsg(req)
end

function JiuClgAgent:handlePM_JiuClgExtremeFightConfirmRes(status, msg)
	if status == 0 then
		JiuClgModel.instance:onJiuClgExtremeFightConfirmRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.JiuClgExtremeFightConfirmRes, status)
	end
end

function JiuClgAgent:sendPM_JiuClgResetExtremePhaseReq(activityId)
	local req = JiuClgExtension_pb.PM_JiuClgResetExtremePhaseReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function JiuClgAgent:handlePM_JiuClgResetExtremePhaseRes(status, msg)
	if status == 0 then
		JiuClgModel.instance:onJiuClgResetExtremePhaseRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.JiuClgResetExtremePhaseRes)
	end
end

JiuClgAgent.instance = JiuClgAgent.New()

return JiuClgAgent
