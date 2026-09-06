-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/clearstargame/agent/ClearStarGameAgent.lua

module("logic.extensions.clearstargame.agent.ClearStarGameAgent", package.seeall)

local ClearStarGameAgent = class("ClearStarGameAgent", BaseAgent)

function ClearStarGameAgent:sendPM_ClearStarGameInfoReq(activityId)
	local req = ClearStarGameExtension_pb.PM_ClearStarGameInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ClearStarGameAgent:handlePM_ClearStarGameInfoRes(status, msg)
	if status == 0 then
		ClearStarGameController.instance:handleGetInfo(msg)
	end
end

function ClearStarGameAgent:sendPM_ClearStarGameStartReq(activityId, clientKey)
	local req = ClearStarGameExtension_pb.PM_ClearStarGameStartReq()

	req.activityId = activityId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function ClearStarGameAgent:handlePM_ClearStarGameStartRes(status, msg)
	if status == 0 then
		ClearStarGameController.instance:handleStartGame(msg)
	end
end

function ClearStarGameAgent:sendPM_ClearStarGameEndReq(activityId, save, scores_pb_Ary, useItems_pb_Ary, encryptedKey)
	local req = ClearStarGameExtension_pb.PM_ClearStarGameEndReq()

	req.activityId = activityId
	req.save = save

	if scores_pb_Ary ~= nil then
		for i, v1 in ipairs(scores_pb_Ary) do
			local scores = req.scores:add()

			scores:ParseFromString(v1:SerializeToString())
		end
	end

	if useItems_pb_Ary ~= nil then
		for i, v2 in ipairs(useItems_pb_Ary) do
			local useItems = req.useItems:add()

			useItems:ParseFromString(v2:SerializeToString())
		end
	end

	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function ClearStarGameAgent:handlePM_ClearStarGameEndRes(status, msg)
	if status == 0 then
		ClearStarGameController.instance:handleEndGame(msg)
	end
end

function ClearStarGameAgent:sendPM_ClearStarSweepReq(activityId, sweepTimes)
	local req = ClearStarGameExtension_pb.PM_ClearStarSweepReq()

	req.activityId = activityId
	req.sweepTimes = sweepTimes

	self:sendMsg(req)
end

function ClearStarGameAgent:handlePM_ClearStarSweepRes(status, msg)
	if status == 0 then
		ClearStarGameController.instance:handlerSweepGame(msg)
	end
end

ClearStarGameAgent.instance = ClearStarGameAgent.New()

return ClearStarGameAgent
