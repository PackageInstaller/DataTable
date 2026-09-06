-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/picturepuzzle/agent/PuzzleJigsawAgent.lua

module("logic.extensions.puzzlejigsaw.agent.PuzzleJigsawAgent", package.seeall)

local PuzzleJigsawAgent = class("PuzzleJigsawAgent", BaseAgent)

function PuzzleJigsawAgent:sendPM_PuzzleJigsawGetInfoReq(actId)
	local req = PuzzleJigsawExtension_pb.PM_PuzzleJigsawGetInfoReq()

	req.actId = actId

	self:sendMsg(req)
end

function PuzzleJigsawAgent:handlePM_PuzzleJigsawGetInfoRes(status, msg)
	if status == 0 then
		PicturepuzzleController.instance:handlePM_PuzzleJigsawGetInfoRes(msg)
	end
end

function PuzzleJigsawAgent:sendPM_PuzzleJigsawStartGameReq(actId, jigsawId, clientKey)
	local req = PuzzleJigsawExtension_pb.PM_PuzzleJigsawStartGameReq()

	req.actId = actId
	req.jigsawId = jigsawId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function PuzzleJigsawAgent:handlePM_PuzzleJigsawStartGameRes(status, msg)
	if status == 0 then
		PicturepuzzleController.instance:handlePM_PuzzleJigsawStartGameRes(msg)
	end
end

function PuzzleJigsawAgent:sendPM_PuzzleJigsawEndGameReq(isPass, clientEncryptedKey)
	local req = PuzzleJigsawExtension_pb.PM_PuzzleJigsawEndGameReq()

	req.isPass = isPass
	req.clientEncryptedKey = clientEncryptedKey

	self:sendMsg(req)
end

function PuzzleJigsawAgent:handlePM_PuzzleJigsawEndGameRes(status, msg)
	if status == 0 then
		PicturepuzzleController.instance:handlePM_PuzzleJigsawEndGameRes()
	end
end

function PuzzleJigsawAgent:sendPM_PuzzleJigsawGainPrizeReq(actId, jigsawId)
	local req = PuzzleJigsawExtension_pb.PM_PuzzleJigsawGainPrizeReq()

	req.actId = actId
	req.jigsawId = jigsawId

	self:sendMsg(req)
end

function PuzzleJigsawAgent:handlePM_PuzzleJigsawGainPrizeRes(status, msg)
	if status == 0 then
		PicturepuzzleController.instance:handlePM_PuzzleJigsawGainFinalPrizeRes()
	end
end

function PuzzleJigsawAgent:sendPM_PuzzleJigsawGainFinalPrizeReq(actId)
	local req = PuzzleJigsawExtension_pb.PM_PuzzleJigsawGainFinalPrizeReq()

	req.actId = actId

	self:sendMsg(req)
end

function PuzzleJigsawAgent:handlePM_PuzzleJigsawGainFinalPrizeRes(status, msg)
	if status == 0 then
		PicturepuzzleController.instance:handlePM_PuzzleJigsawGainFinalPrizeRes(msg)
	end
end

PuzzleJigsawAgent.instance = PuzzleJigsawAgent.New()

return PuzzleJigsawAgent
