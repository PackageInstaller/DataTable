-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/popularitylist/agent/SkinVoteAgent.lua

module("logic.extensions.skinvote.agent.SkinVoteAgent", package.seeall)

local SkinVoteAgent = class("SkinVoteAgent", BaseAgent)

function SkinVoteAgent:sendPM_GetSkinVoteCountsReq(activityId)
	local req = SkinVoteExtension_pb.PM_GetSkinVoteCountsReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SkinVoteAgent:handlePM_GetSkinVoteCountsRes(status, msg)
	if status == 0 then
		PopularityListController.instance:handlePM_GetSkinVoteCountsRes(msg)
	end
end

function SkinVoteAgent:sendPM_SkinVoteReq(activityId, id, comment)
	local req = SkinVoteExtension_pb.PM_SkinVoteReq()

	req.activityId = activityId
	req.id = id

	if not string.nilorempty(comment) then
		req.comment = comment
	end

	self:sendMsg(req)
end

function SkinVoteAgent:handlePM_SkinVoteRes(status, msg)
	if status == 0 then
		PopularityListController.instance:handlePM_SkinVoteRes(msg)
	end
end

function SkinVoteAgent:sendPM_GainYearVersionPrizeReq(activityId, versionId)
	local req = SkinVoteExtension_pb.PM_GainYearVersionPrizeReq()

	req.activityId = activityId
	req.versionId = versionId

	self:sendMsg(req)
end

function SkinVoteAgent:handlePM_GainYearVersionPrizeRes(status, msg)
	if status == 0 then
		PopularityListController.instance:handlePM_GainYearVersionPrizeRes(msg)
	end
end

SkinVoteAgent.instance = SkinVoteAgent.New()

return SkinVoteAgent
