-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jisummoner/agent/JiActivityAgent.lua

module("logic.extensions.jisummoner.agent.JiActivityAgent", package.seeall)

local JiActivityAgent = class("JiActivityAgent", BaseAgent)

function JiActivityAgent:sendPM_JiActivityInfoReq()
	local req = JiActivityExtension_pb.PM_JiActivityInfoReq()

	self:sendMsg(req)
end

function JiActivityAgent:handlePM_JiActivityInfoRes(status, msg)
	if status == 0 then
		JiSummonerController.instance:scPushJiActivityInfo(msg)
	end
end

function JiActivityAgent:sendPM_GainJiActivityActivePrizeReq(prizeId)
	local req = JiActivityExtension_pb.PM_GainJiActivityActivePrizeReq()

	req.prizeId = prizeId

	self:sendMsg(req)
end

function JiActivityAgent:handlePM_GainJiActivityActivePrizeRes(status, msg)
	if status == 0 then
		JiSummonerController.instance:scPushGainJiActivityActivePrize()
	end
end

function JiActivityAgent:sendPM_GainJiActivityPlotPrizeReq()
	local req = JiActivityExtension_pb.PM_GainJiActivityPlotPrizeReq()

	self:sendMsg(req)
end

function JiActivityAgent:handlePM_GainJiActivityPlotPrizeRes(status, msg)
	if status == 0 then
		JiSummonerController.instance:scPushGainJiActivityPlotPrize()
	end
end

JiActivityAgent.instance = JiActivityAgent.New()

return JiActivityAgent
