-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/agent/FamilySeasonRankAgent.lua

module("logic.extensions.newfamily.agent.FamilySeasonRankAgent", package.seeall)

local FamilySeasonRankAgent = class("FamilySeasonRankAgent", BaseAgent)

function FamilySeasonRankAgent:sendPM_FamilySeasonRankViewRankReq(rankType, seasonId)
	local req = FamilySeasonRankExtension_pb.PM_FamilySeasonRankViewRankReq()

	req.rankType = rankType
	req.seasonId = seasonId

	self:sendMsg(req)
end

function FamilySeasonRankAgent:handlePM_FamilySeasonRankViewRankRes(status, msg)
	if status == 0 then
		FamilyWarController.instance:scPushFamilySeasonRankViewRank(msg)
	end
end

function FamilySeasonRankAgent:sendPM_FamilySeasonRankViewNewRankReq(rankType, seasonId)
	local req = FamilySeasonRankExtension_pb.PM_FamilySeasonRankViewNewRankReq()

	req.rankType = rankType
	req.seasonId = seasonId

	self:sendMsg(req)
end

function FamilySeasonRankAgent:handlePM_FamilySeasonRankViewNewRankRes(status, msg)
	if status == 0 then
		FamilyWarController.instance:handlePM_FamilySeasonRankViewNewRankRes(msg)
	end
end

FamilySeasonRankAgent.instance = FamilySeasonRankAgent.New()

return FamilySeasonRankAgent
