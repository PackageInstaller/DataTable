-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/agent/ShowDownAgent.lua

module("logic.extensions.showdown.agent.ShowDownAgent", package.seeall)

local ShowDownAgent = class("ShowDownAgent", BaseAgent)

function ShowDownAgent:sendPM_ShowDown_GetQualifyMainInfoReq(activityId)
	local req = ShowDownExtension_pb.PM_ShowDown_GetQualifyMainInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ShowDownAgent:handlePM_ShowDown_GetQualifyMainInfoRes(status, msg)
	ShowDownController.instance:handlePM_ShowDown_GetQualifyMainInfoRes(status, msg)
end

function ShowDownAgent:sendPM_ShowDown_GetJoyModeInfoReq(activityId)
	local req = ShowDownExtension_pb.PM_ShowDown_GetJoyModeInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ShowDownAgent:handlePM_ShowDown_GetJoyModeInfoRes(status, msg)
	ShowDownController.instance:handlePM_ShowDown_GetJoyModeInfoRes(status, msg)
end

function ShowDownAgent:sendPM_ShowDown_GetTeamMainInfoReq(activityId, groupId)
	local req = ShowDownExtension_pb.PM_ShowDown_GetTeamMainInfoReq()

	req.activityId = activityId
	req.groupId = groupId

	self:sendMsg(req)
end

function ShowDownAgent:handlePM_ShowDown_GetTeamMainInfoRes(status, msg)
	ShowDownController.instance:handlePM_ShowDown_GetTeamMainInfoRes(status, msg)
end

function ShowDownAgent:sendPM_ShowDown_GetMainInfoReq(activityId, groupId)
	local req = ShowDownExtension_pb.PM_ShowDown_GetMainInfoReq()

	req.activityId = activityId
	req.groupId = groupId

	self:sendMsg(req)
end

function ShowDownAgent:handlePM_ShowDown_GetMainInfoRes(status, msg)
	ShowDownController.instance:handlePM_ShowDown_GetMainInfoRes(status, msg)
end

function ShowDownAgent:sendPM_ShowDown_GetScheduleInfoReq(activityId)
	local req = ShowDownExtension_pb.PM_ShowDown_GetScheduleInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ShowDownAgent:handlePM_ShowDown_GetScheduleInfoRes(status, msg)
	if status == 0 then
		ShowDownController.instance:handlePM_ShowDown_GetScheduleInfoRes(msg)
	end
end

function ShowDownAgent:sendPM_ShowDownKnockout_GetBattleOrderReq(activityId, roundId, teamId)
	local req = ShowDownExtension_pb.PM_ShowDownKnockout_GetBattleOrderReq()

	req.activityId = activityId
	req.roundId = roundId
	req.teamId = teamId

	self:sendMsg(req)
end

function ShowDownAgent:handlePM_ShowDownKnockout_GetBattleOrderRes(status, msg)
	if status == 0 then
		ShowDownController.instance:handlePM_ShowDownKnockout_GetBattleOrderRes(msg)
	end
end

function ShowDownAgent:sendPM_ShowDownKnockout_AdjustBattleOrderReq(activityId, roundId, memberIdList)
	local req = ShowDownExtension_pb.PM_ShowDownKnockout_AdjustBattleOrderReq()

	req.activityId = activityId
	req.roundId = roundId

	if memberIdList then
		for _, v in ipairs(memberIdList) do
			req.memberIdList:append(v)
		end
	end

	self:sendMsg(req)
end

function ShowDownAgent:handlePM_ShowDownKnockout_AdjustBattleOrderRes(status, msg)
	if status == 0 then
		ShowDownController.instance:handlePM_ShowDownKnockout_AdjustBattleOrderRes(msg)
	end
end

function ShowDownAgent:sendPM_ShowDown_GetGuessRecordReq(activityId)
	local req = ShowDownExtension_pb.PM_ShowDown_GetGuessRecordReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ShowDownAgent:handlePM_ShowDown_GetGuessRecordRes(status, msg)
	if status == 0 then
		ShowDownController.instance:handlePM_ShowDown_GetGuessRecordRes(msg)
	end
end

function ShowDownAgent:sendPM_ShowDown_GuessReq(activityId, teamId, guessNum)
	local req = ShowDownExtension_pb.PM_ShowDown_GuessReq()

	req.activityId = activityId
	req.teamId = teamId
	req.guessNum = guessNum

	self:sendMsg(req)
end

function ShowDownAgent:handlePM_ShowDown_GuessRes(status, msg)
	if status == 0 then
		ShowDownController.instance:handlePM_ShowDown_GuessRes(msg)
	end
end

function ShowDownAgent:sendPM_ShowDown_GetDisplayInfoReq(activityId)
	local req = ShowDownExtension_pb.PM_ShowDown_GetDisplayInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ShowDownAgent:handlePM_ShowDown_GetDisplayInfoRes(status, msg)
	if status == 0 then
		ShowDownController.instance:handlePM_ShowDown_GetDisplayInfoRes(msg)
	end
end

function ShowDownAgent:sendPM_ShowDown_GetBattleRecordsReq(activityId, stepId, teamId, otherTeamId)
	local req = ShowDownExtension_pb.PM_ShowDown_GetBattleRecordsReq()

	req.activityId = activityId
	req.stepId = stepId
	req.teamId = teamId
	req.otherTeamId = otherTeamId

	self:sendMsg(req)
end

function ShowDownAgent:handlePM_ShowDown_GetBattleRecordsRes(status, msg)
	if status == 0 then
		ShowDownController.instance:handlePM_ShowDown_GetBattleRecordsRes(msg)
	end
end

function ShowDownAgent:sendPM_ShowDown_GetFinalMatchBattleVideoReq(battleId)
	local req = ShowDownExtension_pb.PM_ShowDown_GetFinalMatchBattleVideoReq()

	req.battleId = battleId

	self:sendMsg(req)
end

function ShowDownAgent:handlePM_ShowDown_GetFinalMatchBattleVideoRes(status, msg)
	if status == 0 then
		ShowDownController.instance:handlePM_ShowDown_GetFinalMatchBattleVideoRes(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDown_GetBattleRecordsError, status)
	end
end

function ShowDownAgent:sendPM_ShowDown_GetGroupMatchBattleDetailReq(battleId)
	local req = ShowDownExtension_pb.PM_ShowDown_GetGroupMatchBattleDetailReq()

	req.battleId = battleId

	self:sendMsg(req)
end

function ShowDownAgent:handlePM_ShowDown_GetGroupMatchBattleDetailRes(status, msg)
	if status == 0 then
		ShowDownController.instance:handlePM_ShowDown_GetGroupMatchBattleDetailRes(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.HandlePM_ShowDown_GetBattleRecordsError, status)
	end
end

function ShowDownAgent:sendPM_ShowDown_FinalMatchGuessReq(activityId, guessRank, teamId, guessNum)
	local req = ShowDownExtension_pb.PM_ShowDown_FinalMatchGuessReq()

	req.activityId = activityId
	req.guessRank = guessRank
	req.teamId = teamId
	req.guessNum = guessNum

	self:sendMsg(req)
end

function ShowDownAgent:handlePM_ShowDown_FinalMatchGuessRes(status, msg)
	if status == 0 then
		ShowDownController.instance:handlePM_ShowDown_FinalMatchGuessRes(msg)
	end
end

function ShowDownAgent:sendPM_ShowDown_GetStepInfoReq(activityId)
	local req = ShowDownExtension_pb.PM_ShowDown_GetStepInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ShowDownAgent:handlePM_ShowDown_GetStepInfoRes(status, msg)
	ShowDownController.instance:handlePM_ShowDown_GetStepInfoRes(status, msg)
end

function ShowDownAgent:handlePM_ShowDown_NotifyStepChangeRes(status, msg)
	if status == 0 then
		ShowDownController.instance:handlePM_ShowDown_NotifyStepChangeRes(msg)
	end
end

ShowDownAgent.instance = ShowDownAgent.New()

return ShowDownAgent
