-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tonglinshiji/agent/TongLinShiJiAgent.lua

module("logic.extensions.tonglinshiji.agent.TongLinShiJiAgent", package.seeall)

local TongLinShiJiAgent = class("TongLinShiJiAgent", BaseAgent)

function TongLinShiJiAgent:sendPM_JiClgGetInfoReq(activityId)
	local req = JiClgExtension_pb.PM_JiClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function TongLinShiJiAgent:handlePM_JiClgGetInfoRes(status, msg)
	if status == 0 then
		TongLinShiJiController.instance:handlePM_JiClgGetInfoRes(msg)
	end
end

function TongLinShiJiAgent:sendPM_JiClgNormalStageReq(activityId, stageId, form)
	local req = JiClgExtension_pb.PM_JiClgNormalStageReq()

	req.activityId = activityId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function TongLinShiJiAgent:handlePM_JiClgNormalStageRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function TongLinShiJiAgent:sendPM_JiClgNormalBossReq(activityId, practice, form)
	local req = JiClgExtension_pb.PM_JiClgNormalBossReq()

	req.activityId = activityId
	req.practice = practice

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function TongLinShiJiAgent:handlePM_JiClgNormalBossRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function TongLinShiJiAgent:sendPM_JiClgExtremeStageReq(activityId, raceType, stageId, form)
	local req = JiClgExtension_pb.PM_JiClgExtremeStageReq()

	req.activityId = activityId
	req.raceType = raceType
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function TongLinShiJiAgent:handlePM_JiClgExtremeStageRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function TongLinShiJiAgent:handlePM_Notify_JiClgNormalStageEndRes(status, msg)
	if status == 0 then
		TongLinShiJiController.instance:handlePM_Notify_JiClgNormalStageEndRes(msg)
	end
end

function TongLinShiJiAgent:handlePM_Notify_JiClgNormalBossEndRes(status, msg)
	if status == 0 then
		TongLinShiJiController.instance:handlePM_Notify_JiClgNormalBossEndRes(msg)
	end
end

function TongLinShiJiAgent:handlePM_Notify_JiClgExtremeStageEndRes(status, msg)
	if status == 0 then
		TongLinShiJiController.instance:handlePM_Notify_JiClgExtremeStageEndRes(msg)
	end
end

function TongLinShiJiAgent:sendPM_JiClgConfirmExtremeScoreReq(activityId, raceType, stageId, confirm)
	local req = JiClgExtension_pb.PM_JiClgConfirmExtremeScoreReq()

	req.activityId = activityId
	req.raceType = raceType
	req.stageId = stageId
	req.confirm = confirm

	self:sendMsg(req)
end

function TongLinShiJiAgent:handlePM_JiClgConfirmExtremeScoreRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function TongLinShiJiAgent:sendPM_JiClgGainPrizeReq(activityId, prizeType)
	local req = JiClgExtension_pb.PM_JiClgGainPrizeReq()

	req.activityId = activityId
	req.prizeType = prizeType

	self:sendMsg(req)
end

function TongLinShiJiAgent:handlePM_JiClgGainPrizeRes(status, msg)
	if status == 0 then
		TongLinShiJiController.instance:handlePM_JiClgGainPrizeRes(msg)
	end
end

TongLinShiJiAgent.instance = TongLinShiJiAgent.New()

return TongLinShiJiAgent
