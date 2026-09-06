-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recap2021/agent/Recap2021Agent.lua

module("logic.extensions.recap2021.agent.Recap2021Agent", package.seeall)

local Recap2021Agent = class("Recap2021Agent", BaseAgent)

Recap2021Agent.PM_Recap21GainEditionPrizeRes = "Recap2021Agent_PM_Recap21GainEditionPrizeRes"
Recap2021Agent.PM_Recap21GainLetterPrizeRes = "Recap2021Agent_PM_Recap21GainLetterPrizeRes"
Recap2021Agent.PM_Recap21GetInfoRes = "Recap2021Agent_PM_Recap21GetInfoRes"

function Recap2021Agent:sendPM_Recap21GetInfoReq()
	local req = Recap2021Extension_pb.PM_Recap21GetInfoReq()

	self:sendMsg(req)
end

function Recap2021Agent:handlePM_Recap21GetInfoRes(status, msg)
	if status == 0 then
		-- block empty
	end

	self:dispatch(Recap2021Agent.PM_Recap21GetInfoRes, status, msg)
end

function Recap2021Agent:sendPM_Recap21GainLetterPrizeReq(prizeId)
	local req = Recap2021Extension_pb.PM_Recap21GainLetterPrizeReq()

	req.prizeId = prizeId

	self:sendMsg(req)
end

function Recap2021Agent:handlePM_Recap21GainLetterPrizeRes(status, msg)
	if status == 0 then
		-- block empty
	end

	self:dispatch(Recap2021Agent.PM_Recap21GainLetterPrizeRes, status, msg)
end

function Recap2021Agent:sendPM_Recap21GainEditionPrizeReq(editionId)
	local req = Recap2021Extension_pb.PM_Recap21GainEditionPrizeReq()

	req.editionId = editionId

	self:sendMsg(req)
end

function Recap2021Agent:handlePM_Recap21GainEditionPrizeRes(status, msg)
	if status == 0 then
		-- block empty
	end

	self:dispatch(Recap2021Agent.PM_Recap21GainEditionPrizeRes, status, msg)
end

Recap2021Agent.instance = Recap2021Agent.New()

return Recap2021Agent
