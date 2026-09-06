-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemiruikeclg/agent/DivineMiRuiKeClgAgent.lua

module("logic.extensions.divinemiruikeclg.agent.DivineMiRuiKeClgAgent", package.seeall)

local DivineMiRuiKeClgAgent = class("DivineMiRuiKeClgAgent", BaseAgent)

function DivineMiRuiKeClgAgent:sendPM_DivineMiRuiKeClgGetInfoReq(activityId)
	local req = DivineMiRuiKeClgExtension_pb.PM_DivineMiRuiKeClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineMiRuiKeClgAgent:handlePM_DivineMiRuiKeClgGetInfoRes(status, msg)
	if status == 0 then
		DivineMiRuiKeClgModel.instance:onGetInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineMiRuiKeClgGetInfoRes)
	end
end

function DivineMiRuiKeClgAgent:sendPM_DivineMiRuiKeClgFightReq(activityId, form)
	local req = DivineMiRuiKeClgExtension_pb.PM_DivineMiRuiKeClgFightReq()

	req.activityId = activityId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function DivineMiRuiKeClgAgent:handlePM_DivineMiRuiKeClgFightRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function DivineMiRuiKeClgAgent:handlePM_DivineMiRuiKeClgNotifyFightResultRes(status, msg)
	if status == 0 then
		DivineMiRuiKeClgModel.instance:onNotifyFightResultRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineMiRuiKeClgNotifyFightResultRes, msg, msg.activityId)
	end
end

DivineMiRuiKeClgAgent.instance = DivineMiRuiKeClgAgent.New()

return DivineMiRuiKeClgAgent
