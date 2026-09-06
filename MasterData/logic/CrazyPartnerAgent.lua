-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/crazypartner/agent/CrazyPartnerAgent.lua

module("logic.extensions.crazypartner.agent.CrazyPartnerAgent", package.seeall)

local CrazyPartnerAgent = class("CrazyPartnerAgent", BaseAgent)

function CrazyPartnerAgent:sendPM_CrazyPartnerInfoReq()
	local req = CrazyPartnerExtension_pb.PM_CrazyPartnerInfoReq()

	self:sendMsg(req)
end

function CrazyPartnerAgent:handlePM_CrazyPartnerInfoRes(status, msg)
	CrazyPartnerController.instance:handleGetInfo(status, msg)
end

function CrazyPartnerAgent:sendPM_CrazyPartnerChallengeReq(form, difficulty)
	local req = CrazyPartnerExtension_pb.PM_CrazyPartnerChallengeReq()

	req.form:ParseFromString(form:SerializeToString())

	req.difficulty = difficulty

	self:sendMsg(req)
end

function CrazyPartnerAgent:handlePM_CrazyPartnerChallengeRes(status, msg)
	CrazyPartnerController.instance:handleChallegenResp(status, msg)
end

function CrazyPartnerAgent:sendPM_CrazyPartnerGainPrizeReq(id)
	local req = CrazyPartnerExtension_pb.PM_CrazyPartnerGainPrizeReq()

	req.id = id

	self:sendMsg(req)
end

function CrazyPartnerAgent:handlePM_CrazyPartnerGainPrizeRes(status, msg)
	CrazyPartnerController.instance:handleGainPrize(status, msg)
end

function CrazyPartnerAgent:sendPM_CrazyPartnerDailyRankReq()
	local req = CrazyPartnerExtension_pb.PM_CrazyPartnerDailyRankReq()

	self:sendMsg(req)
end

function CrazyPartnerAgent:handlePM_CrazyPartnerDailyRankRes(status, msg)
	CrazyPartnerController.instance:handleRankInfo(CrazyPartnerConfig.RankTypeDefine.Daily, status, msg)
end

function CrazyPartnerAgent:sendPM_CrazyPartnerTotalRankReq()
	local req = CrazyPartnerExtension_pb.PM_CrazyPartnerTotalRankReq()

	self:sendMsg(req)
end

function CrazyPartnerAgent:handlePM_CrazyPartnerTotalRankRes(status, msg)
	CrazyPartnerController.instance:handleRankInfo(CrazyPartnerConfig.RankTypeDefine.Total, status, msg)
end

function CrazyPartnerAgent:handlePM_CrazyPartnerNotifyChallengeEndRes(status, msg)
	CrazyPartnerController.instance:handleNotifyChallengeEnd(status, msg)
end

CrazyPartnerAgent.instance = CrazyPartnerAgent.New()

return CrazyPartnerAgent
