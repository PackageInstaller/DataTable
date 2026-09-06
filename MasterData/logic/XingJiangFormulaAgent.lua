-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xingjiang/agent/XingJiangFormulaAgent.lua

module("logic.extensions.xingjiangformula.agent.XingJiangFormulaAgent", package.seeall)

local XingJiangFormulaAgent = class("XingJiangFormulaAgent", BaseAgent)

function XingJiangFormulaAgent:sendPM_XingJiangFormulaInfoReq(activityId)
	local req = XingJiangFormulaExtension_pb.PM_XingJiangFormulaInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function XingJiangFormulaAgent:handlePM_XingJiangFormulaInfoRes(status, msg)
	if status == 0 then
		XingJiangModel.instance:getInfos(msg)
	end
end

function XingJiangFormulaAgent:sendPM_XingJiangFormulaChallengeReq(activityId, stageId, teamId, form)
	local req = XingJiangFormulaExtension_pb.PM_XingJiangFormulaChallengeReq()

	req.activityId = activityId
	req.stageId = stageId
	req.teamId = teamId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function XingJiangFormulaAgent:handlePM_XingJiangFormulaChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function XingJiangFormulaAgent:sendPM_XingJiangFormulaResetReq(activityId, stageId, teamId)
	local req = XingJiangFormulaExtension_pb.PM_XingJiangFormulaResetReq()

	req.activityId = activityId
	req.stageId = stageId
	req.teamId = teamId

	self:sendMsg(req)
end

function XingJiangFormulaAgent:handlePM_XingJiangFormulaResetRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function XingJiangFormulaAgent:sendPM_XingJiangFormulaSignInReq(activityId)
	local req = XingJiangFormulaExtension_pb.PM_XingJiangFormulaSignInReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function XingJiangFormulaAgent:handlePM_XingJiangFormulaSignInRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function XingJiangFormulaAgent:sendPM_XingJiangFormulaTaskReq(activityId, taskId)
	local req = XingJiangFormulaExtension_pb.PM_XingJiangFormulaTaskReq()

	req.activityId = activityId
	req.taskId = taskId

	self:sendMsg(req)
end

function XingJiangFormulaAgent:handlePM_XingJiangFormulaTaskRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.PM_IF_FORMULATASKRES)
	end
end

function XingJiangFormulaAgent:handlePM_NotifyXingJiangFormulaChallengeEndRes(status, msg)
	if status == 0 then
		local iswin = msg.isWin
		local nextstage = msg.nextStage
		local team = msg.team

		if iswin then
			XingJiangModel.instance:updateStageInfo(nextstage, team)
		end
	end
end

XingJiangFormulaAgent.instance = XingJiangFormulaAgent.New()

return XingJiangFormulaAgent
