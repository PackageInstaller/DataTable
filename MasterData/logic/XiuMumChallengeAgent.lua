-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiumumchallenge/agent/XiuMumChallengeAgent.lua

module("logic.extensions.xiumumchallenge.agent.XiuMumChallengeAgent", package.seeall)

local XiuMumChallengeAgent = class("XiuMumChallengeAgent", BaseAgent)

function XiuMumChallengeAgent:sendPM_XiuMumChallengeGetInfoReq(activityId)
	local req = XiuMumChallengeExtension_pb.PM_XiuMumChallengeGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function XiuMumChallengeAgent:handlePM_XiuMumChallengeGetInfoRes(status, msg)
	if status == 0 then
		XiuMumChallengeController.instance:handleGetInfo(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.XiuMumChallengeError, status)
	end
end

function XiuMumChallengeAgent:sendPM_XiuMumChallengeSubmitMapReq(activityId, map, road, stageId)
	local req = XiuMumChallengeExtension_pb.PM_XiuMumChallengeSubmitMapReq()

	req.activityId = activityId

	if map then
		for i, v in ipairs(map) do
			local param = req.map:add()

			param:ParseFromString(v:SerializeToString())
		end
	end

	for i, id in ipairs(road) do
		req.road:append(id)
	end

	req.stageId = stageId

	self:sendMsg(req)
end

function XiuMumChallengeAgent:handlePM_XiuMumChallengeSubmitMapRes(status, msg)
	if status == 0 then
		XiuMumChallengeController.instance:handlePassGame(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.XiuMumChallengeError, status)
	end
end

function XiuMumChallengeAgent:sendPM_XiuMumChallengeReq(activityId, id, form)
	local req = XiuMumChallengeExtension_pb.PM_XiuMumChallengeReq()

	req.activityId = activityId
	req.id = id

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function XiuMumChallengeAgent:handlePM_XiuMumChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
		GlobalDispatcher:dispatch(GlobalNotify.XiuMumChallengeError, status)
	end
end

function XiuMumChallengeAgent:handlePM_XiuMumChallengeResultRes(status, msg)
	if status == 0 then
		XiuMumChallengeController.instance:handleFinishChallenge(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.XiuMumChallengeError, status)
	end
end

XiuMumChallengeAgent.instance = XiuMumChallengeAgent.New()

return XiuMumChallengeAgent
