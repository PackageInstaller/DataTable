-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/duolammgame/agent/DuoLaMMGameAgent.lua

module("logic.extensions.duolammgame.agent.DuoLaMMGameAgent", package.seeall)

local DuoLaMMGameAgent = class("DuoLaMMGameAgent", BaseAgent)

function DuoLaMMGameAgent:sendPM_DuoLaMMGameGetInfoReq(activityId)
	local req = DuoLaMMGameExtension_pb.PM_DuoLaMMGameGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DuoLaMMGameAgent:handlePM_DuoLaMMGameGetInfoRes(status, msg)
	if status == 0 then
		DuoLaMMGameController.instance:handlePM_DuoLaMMGameGetInfoRes(msg)
	end
end

function DuoLaMMGameAgent:sendPM_DuoLaMMGameBuyGameTimesReq(activityId)
	local req = DuoLaMMGameExtension_pb.PM_DuoLaMMGameBuyGameTimesReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DuoLaMMGameAgent:handlePM_DuoLaMMGameBuyGameTimesRes(status, msg)
	if status == 0 then
		DuoLaMMGameController.instance:handlePM_DuoLaMMGameBuyGameTimesRes(msg)
	end
end

function DuoLaMMGameAgent:sendPM_DuoLaMMGameStartGameReq(activityId, clientKey)
	local req = DuoLaMMGameExtension_pb.PM_DuoLaMMGameStartGameReq()

	req.activityId = activityId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function DuoLaMMGameAgent:handlePM_DuoLaMMGameStartGameRes(status, msg)
	if status == 0 then
		DuoLaMMGameController.instance:handlePM_DuoLaMMGameStartGameRes(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.DuoLaMMGameError, status)
	end
end

function DuoLaMMGameAgent:sendPM_DuoLaMMGameReliveReq(activityId)
	local req = DuoLaMMGameExtension_pb.PM_DuoLaMMGameReliveReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DuoLaMMGameAgent:handlePM_DuoLaMMGameReliveRes(status, msg)
	if status == 0 then
		DuoLaMMGameController.instance:handlePM_DuoLaMMGameReliveRes(msg)
	end
end

function DuoLaMMGameAgent:sendPM_DuoLaMMGameEndGameReq(activityId, ids, encryptedKey)
	local req = DuoLaMMGameExtension_pb.PM_DuoLaMMGameEndGameReq()

	req.activityId = activityId

	for i, v1 in ipairs(ids) do
		req.ids:append(v1)
	end

	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function DuoLaMMGameAgent:handlePM_DuoLaMMGameEndGameRes(status, msg)
	if status == 0 then
		DuoLaMMGameController.instance:handlePM_DuoLaMMGameEndGameRes(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.DuoLaMMGameError, status)
	end
end

DuoLaMMGameAgent.instance = DuoLaMMGameAgent.New()

return DuoLaMMGameAgent
