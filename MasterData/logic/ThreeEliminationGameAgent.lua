-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/threeelimination/agent/ThreeEliminationGameAgent.lua

module("logic.extensions.threeeliminationgame.agent.ThreeEliminationGameAgent", package.seeall)

local ThreeEliminationGameAgent = class("ThreeEliminationGameAgent", BaseAgent)

function ThreeEliminationGameAgent:sendPM_ThreeEliminationGetInfo4RedPointReq(activityId)
	local req = ThreeEliminationGameExtension_pb.PM_ThreeEliminationGetInfo4RedPointReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ThreeEliminationGameAgent:handlePM_ThreeEliminationGetInfo4RedPointRes(status, msg)
	if status == 0 then
		ThreeEliminationController.instance:handlePM_ThreeEliminationGetInfo4RedPointRes(msg)
	end
end

function ThreeEliminationGameAgent:sendPM_ThreeEliminationGameOpenFuncReq(activityId)
	local req = ThreeEliminationGameExtension_pb.PM_ThreeEliminationGameOpenFuncReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ThreeEliminationGameAgent:handlePM_ThreeEliminationGameOpenFuncRes(status, msg)
	if status == 0 then
		ThreeEliminationController.instance:handlePM_ThreeEliminationGameOpenFuncRes(msg)
	end
end

function ThreeEliminationGameAgent:sendPM_ThreeEliminationGameCloseFuncReq(activityId)
	local req = ThreeEliminationGameExtension_pb.PM_ThreeEliminationGameCloseFuncReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ThreeEliminationGameAgent:handlePM_ThreeEliminationGameCloseFuncRes(status, msg)
	if status == 0 then
		ThreeEliminationController.instance:handlePM_ThreeEliminationGameCloseFuncRes(msg)
	end
end

function ThreeEliminationGameAgent:sendPM_ThreeEliminationGameLvlUpPlayerReq(activityId)
	local req = ThreeEliminationGameExtension_pb.PM_ThreeEliminationGameLvlUpPlayerReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ThreeEliminationGameAgent:handlePM_ThreeEliminationGameLvlUpPlayerRes(status, msg)
	if status == 0 then
		ThreeEliminationController.instance:handlePM_ThreeEliminationGameLvlUpPlayerRes(msg)
	end
end

function ThreeEliminationGameAgent:sendPM_ThreeEliminationGameUnLockBuffReq(activityId, buffId)
	local req = ThreeEliminationGameExtension_pb.PM_ThreeEliminationGameUnLockBuffReq()

	req.activityId = activityId
	req.buffId = buffId

	self:sendMsg(req)
end

function ThreeEliminationGameAgent:handlePM_ThreeEliminationGameUnLockBuffRes(status, msg)
	if status == 0 then
		ThreeEliminationController.instance:handlePM_ThreeEliminationGameUnLockBuffRes(msg)
	end
end

function ThreeEliminationGameAgent:sendPM_ThreeEliminationGameSetBuffUsingReq(activityId, buffId)
	local req = ThreeEliminationGameExtension_pb.PM_ThreeEliminationGameSetBuffUsingReq()

	req.activityId = activityId
	req.buffId = buffId

	self:sendMsg(req)
end

function ThreeEliminationGameAgent:handlePM_ThreeEliminationGameSetBuffUsingRes(status, msg)
	if status == 0 then
		ThreeEliminationController.instance:handlePM_ThreeEliminationGameSetBuffUsingRes(msg)
	end
end

function ThreeEliminationGameAgent:sendPM_ThreeEliminationGameGainHangUpPrizeReq(activityId)
	local req = ThreeEliminationGameExtension_pb.PM_ThreeEliminationGameGainHangUpPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ThreeEliminationGameAgent:handlePM_ThreeEliminationGameGainHangUpPrizeRes(status, msg)
	if status == 0 then
		ThreeEliminationController.instance:handlePM_ThreeEliminationGameGainHangUpPrizeRes(msg)
	end
end

function ThreeEliminationGameAgent:sendPM_ThreeEliminationGameGetRankReq(activityId)
	local req = ThreeEliminationGameExtension_pb.PM_ThreeEliminationGameGetRankReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ThreeEliminationGameAgent:handlePM_ThreeEliminationGameGetRankRes(status, msg)
	if status == 0 then
		ThreeEliminationController.instance:handlePM_ThreeEliminationGameGetRankRes(msg)
	end
end

function ThreeEliminationGameAgent:sendPM_ThreeEliminationGameMoveStepReq(activityId, moveStep, newGainPet, mapInfo)
	local req = ThreeEliminationGameExtension_pb.PM_ThreeEliminationGameMoveStepReq()

	req.activityId = activityId
	req.moveStep = moveStep

	for i, v in ipairs(newGainPet) do
		req.newGainPet:append(v)
	end

	for i, v in ipairs(mapInfo) do
		req.mapInfo:append(v)
	end

	self:sendMsg(req)
end

function ThreeEliminationGameAgent:handlePM_ThreeEliminationGameMoveStepRes(status, msg)
	if status == 0 then
		ThreeEliminationController.instance:handlePM_ThreeEliminationGameMoveStepRes(msg)
	end
end

function ThreeEliminationGameAgent:sendPM_ThreeEliminationGameFightReq(activityId)
	local req = ThreeEliminationGameExtension_pb.PM_ThreeEliminationGameFightReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ThreeEliminationGameAgent:handlePM_ThreeEliminationGameFightRes(status, msg)
	if status == 0 then
		ThreeEliminationController.instance:handlePM_ThreeEliminationGameFightRes(msg)
	end
end

ThreeEliminationGameAgent.instance = ThreeEliminationGameAgent.New()

return ThreeEliminationGameAgent
