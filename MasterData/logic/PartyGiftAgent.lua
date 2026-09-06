-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/partysummary/agent/PartyGiftAgent.lua

module("logic.extensions.partysummary.agent.PartyGiftAgent", package.seeall)

local PartyGiftAgent = class("PartyGiftAgent", BaseAgent)

function PartyGiftAgent:sendPM_PartyGiftGetInfoReq()
	local req = PartyGiftExtension_pb.PM_PartyGiftGetInfoReq()

	self:sendMsg(req)
end

function PartyGiftAgent:handlePM_PartyGiftGetInfoRes(status, msg)
	PartySummaryController.instance:scSendPartyGiftGetInfo(status, msg)
	PartySummaryController.instance:handlePM_PartyGiftGetInfoRes(msg)
end

function PartyGiftAgent:handlePM_PartyGiftnotifyGiftRes(status, msg)
	PartySummaryController.instance:scSendPartyGiftnotifyGift(status, msg)
end

PartyGiftAgent.instance = PartyGiftAgent.New()

return PartyGiftAgent
