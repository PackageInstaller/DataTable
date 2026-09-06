-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/partysummary/agent/PotluckDinnerAgent.lua

module("logic.extensions.partysummary.agent.PotluckDinnerAgent", package.seeall)

local PotluckDinnerAgent = class("PotluckDinnerAgent", BaseAgent)

function PotluckDinnerAgent:sendPM_PotluckDinnerInfoReq()
	local req = PotluckDinnerExtension_pb.PM_PotluckDinnerInfoReq()

	self:sendMsg(req)
end

function PotluckDinnerAgent:handlePM_PotluckDinnerInfoRes(status, msg)
	PartySummaryController.instance:scSendPotluckDinnerInfo(msg, status)
end

function PotluckDinnerAgent:sendPM_PotluckDinnerGainPrizeReq(npcId, termId)
	local req = PotluckDinnerExtension_pb.PM_PotluckDinnerGainPrizeReq()

	req.npcId = npcId
	req.termId = termId

	self:sendMsg(req)
end

function PotluckDinnerAgent:handlePM_PotluckDinnerGainPrizeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

PotluckDinnerAgent.instance = PotluckDinnerAgent.New()

return PotluckDinnerAgent
