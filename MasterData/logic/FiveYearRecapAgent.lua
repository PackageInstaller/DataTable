-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fiveyearrecap/agent/FiveYearRecapAgent.lua

module("logic.extensions.fiveyearrecap.agent.FiveYearRecapAgent", package.seeall)

local FiveYearRecapAgent = class("FiveYearRecapAgent", BaseAgent)

function FiveYearRecapAgent:sendPM_FiveYearRecapGetInfoReq(activityId)
	local req = FiveYearRecapExtension_pb.PM_FiveYearRecapGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FiveYearRecapAgent:handlePM_FiveYearRecapGetInfoRes(status, msg)
	FiveYearRecapController.instance:handlePM_FiveYearRecapGetInfoRes(status, msg)
end

function FiveYearRecapAgent:sendPM_FiveYearRecapGainLoginPrizeReq(activityId)
	local req = FiveYearRecapExtension_pb.PM_FiveYearRecapGainLoginPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FiveYearRecapAgent:handlePM_FiveYearRecapGainLoginPrizeRes(status, msg)
	if status == 0 then
		FiveYearRecapController.instance:handlePM_FiveYearRecapGainLoginPrizeRes(msg)
	end
end

function FiveYearRecapAgent:sendPM_FiveYearRecapUnlockReq(activityId, pieceId)
	local req = FiveYearRecapExtension_pb.PM_FiveYearRecapUnlockReq()

	req.activityId = activityId
	req.pieceId = pieceId

	self:sendMsg(req)
end

function FiveYearRecapAgent:handlePM_FiveYearRecapUnlockRes(status, msg)
	if status == 0 then
		FiveYearRecapController.instance:handlePM_FiveYearRecapUnlockRes(msg)
	end
end

function FiveYearRecapAgent:sendPM_FiveYearRecapShareReq(activityId)
	local req = FiveYearRecapExtension_pb.PM_FiveYearRecapShareReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FiveYearRecapAgent:handlePM_FiveYearRecapShareRes(status, msg)
	if status == 0 then
		FiveYearRecapController.instance:handlePM_FiveYearRecapShareRes(msg)
	end
end

FiveYearRecapAgent.instance = FiveYearRecapAgent.New()

return FiveYearRecapAgent
