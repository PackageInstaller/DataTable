-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessglory/agent/GoddessGloryAgent.lua

module("logic.extensions.goddessglory.agent.GoddessGloryAgent", package.seeall)

local GoddessGloryAgent = class("GoddessGloryAgent", BaseAgent)

function GoddessGloryAgent:sendPM_GoddessGloryGetInfoReq(challengeId, stageId)
	local req = GoddessGloryExtension_pb.PM_GoddessGloryGetInfoReq()

	req.challengeId = challengeId
	req.stageId = stageId

	self:sendMsg(req)
end

function GoddessGloryAgent:handlePM_GoddessGloryGetInfoRes(status, msg)
	GoddessGloryController.instance:onGoddessGloryGetInfo(status, msg)
end

function GoddessGloryAgent:sendPM_GoddessGlorySelectPetReq(challengeId, stageId, petIds)
	local req = GoddessGloryExtension_pb.PM_GoddessGlorySelectPetReq()

	req.challengeId = challengeId
	req.stageId = stageId

	for i = 1, #petIds do
		table.insert(req.petIds, petIds[i])
	end

	self:sendMsg(req)
end

function GoddessGloryAgent:handlePM_GoddessGlorySelectPetRes(status, msg)
	GoddessGloryController.instance:onGoddessGloryGetInfo(status, msg)
end

function GoddessGloryAgent:sendPM_GoddessGlorySetFormReq(simpleForm, challengeId, stageId)
	local req = GoddessGloryExtension_pb.PM_GoddessGlorySetFormReq()

	req.simpleForm:ParseFromString(simpleForm:SerializeToString())

	req.challengeId = challengeId
	req.stageId = stageId

	self:sendMsg(req)
end

function GoddessGloryAgent:handlePM_GoddessGlorySetFormRes(status, msg)
	GoddessGloryController.instance:onGoddessGlorySetForm(status, msg)
end

function GoddessGloryAgent:sendPM_GoddessGloryGetFormReq(challengeId, stageId)
	local req = GoddessGloryExtension_pb.PM_GoddessGloryGetFormReq()

	req.challengeId = challengeId
	req.stageId = stageId

	self:sendMsg(req)
end

function GoddessGloryAgent:handlePM_GoddessGloryGetFormRes(status, msg)
	GoddessGloryController.instance:onGoddessGloryGetForm(status, msg)
end

function GoddessGloryAgent:sendPM_GoddessGloryDoEventReq(challengeId, stageId, instanceId, selectId)
	local req = GoddessGloryExtension_pb.PM_GoddessGloryDoEventReq()

	req.challengeId = challengeId
	req.stageId = stageId
	req.instanceId = instanceId
	req.selectId = selectId or 0

	self:sendMsg(req)
end

function GoddessGloryAgent:handlePM_GoddessGloryDoEventRes(status, msg)
	if status == 0 then
		-- block empty
	end

	GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
end

function GoddessGloryAgent:sendPM_GoddessGloryResetReq(challengeId, stageId)
	local req = GoddessGloryExtension_pb.PM_GoddessGloryResetReq()

	req.challengeId = challengeId
	req.stageId = stageId

	self:sendMsg(req)
end

function GoddessGloryAgent:handlePM_GoddessGloryResetRes(status, msg)
	GoddessGloryController.instance:onGoddessGloryReset(status)
end

function GoddessGloryAgent:sendPM_GoddessGloryGetTaskInfoReq(challengeId, stageId)
	local req = GoddessGloryExtension_pb.PM_GoddessGloryGetTaskInfoReq()

	req.challengeId = challengeId
	req.stageId = stageId

	self:sendMsg(req)
end

function GoddessGloryAgent:handlePM_GoddessGloryGetTaskInfoRes(status, msg)
	GoddessGloryController.instance:onGoddessGloryTaskInfo(status, msg)
end

function GoddessGloryAgent:sendPM_GoddessGloryGainPrizeReq(challengeId, stageId, type, taskId)
	local req = GoddessGloryExtension_pb.PM_GoddessGloryGainPrizeReq()

	req.challengeId = challengeId
	req.stageId = stageId
	req.type = type
	req.taskId = taskId

	self:sendMsg(req)
end

function GoddessGloryAgent:handlePM_GoddessGloryGainPrizeRes(status, msg)
	GoddessGloryController.instance:onGoddessGloryGainPrize(status, msg)
end

function GoddessGloryAgent:sendPM_GoddessGloryViewRankReq(challengeId, stageId)
	local req = GoddessGloryExtension_pb.PM_GoddessGloryViewRankReq()

	req.challengeId = challengeId
	req.stageId = stageId

	self:sendMsg(req)
end

function GoddessGloryAgent:handlePM_GoddessGloryViewRankRes(status, msg)
	GoddessGloryController.instance:onGoddessGloryViewRank(status, msg)
end

function GoddessGloryAgent:handlePM_GoddessGloryDoEventOverRes(status, msg)
	if status == 0 then
		GoddessGloryController.instance:onGoddessGloryDoEventOver(msg)
	end
end

function GoddessGloryAgent:sendPM_GoddessGloryGetWeeklyTasksReq(challengeId)
	local req = GoddessGloryExtension_pb.PM_GoddessGloryGetWeeklyTasksReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function GoddessGloryAgent:handlePM_GoddessGloryGetWeeklyTasksRes(status, msg)
	GoddessGloryController.instance:onGoddessGloryGetWeeklyTasks(status, msg)
end

function GoddessGloryAgent:sendPM_GoddessGloryGainWeeklyPrizeReq(challengeId, type, taskId)
	local req = GoddessGloryExtension_pb.PM_GoddessGloryGainWeeklyPrizeReq()

	req.challengeId = challengeId
	req.type = type
	req.taskId = taskId

	self:sendMsg(req)
end

function GoddessGloryAgent:handlePM_GoddessGloryGainWeeklyPrizeRes(status, msg)
	GoddessGloryController.instance:onGoddessGloryGainWeeklyPrize(status, msg)
end

GoddessGloryAgent.instance = GoddessGloryAgent.New()

return GoddessGloryAgent
