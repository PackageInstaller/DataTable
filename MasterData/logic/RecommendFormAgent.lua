-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recommendfmt/agent/RecommendFormAgent.lua

module("logic.extensions.recommendform.agent.RecommendFormAgent", package.seeall)

local RecommendFormAgent = class("RecommendFormAgent", BaseAgent)

function RecommendFormAgent:ctor()
	return
end

function RecommendFormAgent:setExtId(extId)
	RecommendFormAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function RecommendFormAgent:sendPM_RecommendFormGetInfoReq()
	local req = RecommendFormExtension_pb.PM_RecommendFormGetInfoReq()

	self:sendMsg(req)
end

function RecommendFormAgent:handlePM_RecommendFormGetInfoRes(status, msg)
	if status == 0 then
		RecommendFmtController.instance:onRecommendFormGetInfo(msg)
	end
end

function RecommendFormAgent:sendPM_RecommendFormUpdateZdlReq(activityId, simpleForm_pb)
	local req = RecommendFormExtension_pb.PM_RecommendFormUpdateZdlReq()

	req.activityId = activityId

	if simpleForm_pb ~= nil then
		req.simpleForm:ParseFromString(simpleForm_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function RecommendFormAgent:handlePM_RecommendFormUpdateZdlRes(status, msg)
	if status == 0 then
		RecommendFmtController.instance:onUpdateCheckFmt(msg)
	end
end

function RecommendFormAgent:sendPM_RecommendFormViewRankReq(startRank, endRank)
	local req = RecommendFormExtension_pb.PM_RecommendFormViewRankReq()

	req.startRank = startRank
	req.endRank = endRank

	self:sendMsg(req)
end

function RecommendFormAgent:handlePM_RecommendFormViewRankRes(status, msg)
	if status == 0 then
		RecommendFmtController.instance:onRecommendFormGetRank(msg)
	end
end

RecommendFormAgent.instance = RecommendFormAgent.New()

return RecommendFormAgent
