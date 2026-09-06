-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fanruichallenge/agent/FanRuiChallengeAgent.lua

module("logic.extensions.fanruichallenge.agent.FanRuiChallengeAgent", package.seeall)

local FanRuiChallengeAgent = class("FanRuiChallengeAgent", BaseAgent)

function FanRuiChallengeAgent:sendPM_FanRuiClgGetInfoReq(activityId)
	local req = FanRuiChallengeExtension_pb.PM_FanRuiClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FanRuiChallengeAgent:handlePM_FanRuiClgGetInfoRes(status, msg)
	if status == 0 then
		FanRuiChallengeModel.instance:onGetInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FanRuiClgGetInfoRes)
	end
end

function FanRuiChallengeAgent:sendPM_FanRuiClgFightThemeLifeReq(activityId, form)
	local req = FanRuiChallengeExtension_pb.PM_FanRuiClgFightThemeLifeReq()

	req.activityId = activityId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function FanRuiChallengeAgent:handlePM_FanRuiClgFightThemeLifeRes(status, msg)
	if status == 0 then
		FanRuiChallengeModel.instance:onFightThemeLifeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FanRuiClgFightThemeLifeRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function FanRuiChallengeAgent:handlePM_FanRuiNotifyThemeLifeFightResultRes(status, msg)
	if status == 0 then
		FanRuiChallengeModel.instance:onNotifyThemeLifeFightResultRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FanRuiNotifyThemeLifeFightResultRes)
	end
end

function FanRuiChallengeAgent:sendPM_FanRuiClgFightThemeDestinyReq(activityId, form, projectedReq)
	local req = FanRuiChallengeExtension_pb.PM_FanRuiClgFightThemeDestinyReq()

	req.activityId = activityId

	req.form:ParseFromString(form:SerializeToString())

	for i, v in ipairs(projectedReq) do
		local info = req.projectedReq:add()

		info.type = v.type
		info.choice = v.choice
	end

	self:sendMsg(req)
end

function FanRuiChallengeAgent:sendPM_FanRuiClgProjectedReq(type, choice)
	local req = FanRuiChallengeExtension_pb.PM_FanRuiClgProjectedReq()

	req.type = type
	req.choice = choice

	self:sendMsg(req)
end

function FanRuiChallengeAgent:handlePM_FanRuiClgFightThemeDestinyRes(status, msg)
	if status == 0 then
		FanRuiChallengeModel.instance:onFightThemeDestinyRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FanRuiClgFightThemeDestinyRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function FanRuiChallengeAgent:handlePM_FanRuiNotifyThemeDestinyFightResultRes(status, msg)
	if status == 0 then
		local activityid = msg.activityId
		local oldDestinyProgress = FanRuiChallengeModel.instance:getDestinyPassProgress(activityid)

		FanRuiChallengeModel.instance:onNotifyThemeDestinyFightResultRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FanRuiNotifyThemeDestinyFightResultRes, msg.win, msg.activityId, oldDestinyProgress)
	end
end

function FanRuiChallengeAgent:handlePM_FanRuiClgProjectedRes(status, msg)
	if status == 0 then
		FanRuiChallengeModel.instance:onProjectedRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FanRuiClgProjectedRes)
	end
end

function FanRuiChallengeAgent:sendPM_FanRuiClgFightThemeControlReq(activityId, monsterId, myForm, rivalForm)
	local req = FanRuiChallengeExtension_pb.PM_FanRuiClgFightThemeControlReq()

	req.activityId = activityId
	req.monsterId = monsterId

	req.myForm:ParseFromString(myForm:SerializeToString())
	req.rivalForm:ParseFromString(rivalForm:SerializeToString())
	self:sendMsg(req)
end

function FanRuiChallengeAgent:handlePM_FanRuiClgFightThemeControlRes(status, msg)
	if status == 0 then
		FanRuiChallengeModel.instance:onFightThemeControlRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FanRuiClgFightThemeControlRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function FanRuiChallengeAgent:handlePM_FanRuiNotifyThemeControlFightResultRes(status, msg)
	if status == 0 then
		FanRuiChallengeModel.instance:onNotifyThemeControlFightResultRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FanRuiNotifyThemeControlFightResultRes)
	end
end

function FanRuiChallengeAgent:sendPM_FanRuiClgResetThemeControlStageReq(activityId)
	local req = FanRuiChallengeExtension_pb.PM_FanRuiClgResetThemeControlStageReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FanRuiChallengeAgent:handlePM_FanRuiClgResetThemeControlStageRes(status, msg)
	if status == 0 then
		FanRuiChallengeModel.instance:onResetThemeControlStageRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FanRuiClgResetThemeControlStageRes)
	end
end

FanRuiChallengeAgent.instance = FanRuiChallengeAgent.New()

return FanRuiChallengeAgent
