-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknightrui/agent/SaintKnightRuiAgent.lua

module("logic.extensions.saintknightrui.agent.SaintKnightRuiAgent", package.seeall)

local SaintKnightRuiAgent = class("SaintKnightRuiAgent", BaseAgent)

function SaintKnightRuiAgent:sendPM_SaintKnightRuiGetInfoReq(activityId)
	local req = SaintKnightRuiExtension_pb.PM_SaintKnightRuiGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SaintKnightRuiAgent:handlePM_SaintKnightRuiGetInfoRes(status, msg)
	if status == 0 then
		SaintKnightRuiModel.instance:onGetInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SaintKnightRuiGetInfo)
	end
end

function SaintKnightRuiAgent:sendPM_SaintKnightRuiPlayStageReq(activityId, stageId, creepsMasterId, form)
	local req = SaintKnightRuiExtension_pb.PM_SaintKnightRuiPlayStageReq()

	req.activityId = activityId
	req.stageId = stageId
	req.creepsMasterId = creepsMasterId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function SaintKnightRuiAgent:handlePM_SaintKnightRuiPlayStageRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.SaintKnightRuiPlayStage)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function SaintKnightRuiAgent:handlePM_SaintKnightRuiBattleWinRes(status, msg)
	if status == 0 then
		SaintKnightRuiModel.instance:onPlayStageRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SaintKnightRuiBattleWinRes)
	end
end

SaintKnightRuiAgent.instance = SaintKnightRuiAgent.New()

return SaintKnightRuiAgent
