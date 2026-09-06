-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/competitionking/agent/CompetitionKingAgent.lua

module("logic.extensions.competitionking.agent.CompetitionKingAgent", package.seeall)

local CompetitionKingAgent = class("CompetitionKingAgent", BaseAgent)

function CompetitionKingAgent:sendPM_CompetitionKingInfoReq(activityId)
	local req = CompetitionKingExtension_pb.PM_CompetitionKingInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function CompetitionKingAgent:handlePM_CompetitionKingInfoRes(status, msg)
	if status == 0 then
		CompetitionKingController.instance:handlePM_CompetitionKingInfoRes(status, msg)
	end
end

function CompetitionKingAgent:sendPM_CompetitionKingGainPrizeReq(activityId, prizeId)
	local req = CompetitionKingExtension_pb.PM_CompetitionKingGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function CompetitionKingAgent:handlePM_CompetitionKingGainPrizeRes(status, msg)
	if status == 0 then
		CompetitionKingController.instance:handlePM_CompetitionKingGainPrizeRes(status, msg)
	end
end

function CompetitionKingAgent:sendPM_CompetitionKingGetRankInfoReq(activityId)
	local req = CompetitionKingExtension_pb.PM_CompetitionKingGetRankInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function CompetitionKingAgent:handlePM_CompetitionKingGetRankInfoRes(status, msg)
	if status == 0 then
		CompetitionKingController.instance:handlePM_CompetitionKingGetRankInfoRes(status, msg)
	end
end

CompetitionKingAgent.instance = CompetitionKingAgent.New()

return CompetitionKingAgent
