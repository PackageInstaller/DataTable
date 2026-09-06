-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luckymoney/agent/LuckyMoneyAgent.lua

module("logic.extensions.luckymoney.agent.LuckyMoneyAgent", package.seeall)

local LuckyMoneyAgent = class("LuckyMoneyAgent", BaseAgent)

function LuckyMoneyAgent:sendPM_LuckyMoneyGetInfoReq(activityId)
	local req = LuckyMoneyExtension_pb.PM_LuckyMoneyGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LuckyMoneyAgent:handlePM_LuckyMoneyGetInfoRes(status, msg)
	if status == 0 then
		LuckyMoneyController.instance:handlePM_LuckyMoneyGetInfoRes(msg)
	end
end

function LuckyMoneyAgent:sendPM_LuckyMoneyActEndReq(activityId, score)
	local req = LuckyMoneyExtension_pb.PM_LuckyMoneyActEndReq()

	req.activityId = activityId
	req.score = score

	self:sendMsg(req)
end

function LuckyMoneyAgent:handlePM_LuckyMoneyActEndRes(status, msg)
	if status == 0 then
		LuckyMoneyController.instance:handlePM_LuckyMoneyActEndRes(msg)
	end
end

function LuckyMoneyAgent:sendPM_LuckyMoneyGainProgressPrizeReq(activityId, dataBitId)
	local req = LuckyMoneyExtension_pb.PM_LuckyMoneyGainProgressPrizeReq()

	req.activityId = activityId
	req.dataBitId = dataBitId

	self:sendMsg(req)
end

function LuckyMoneyAgent:handlePM_LuckyMoneyGainProgressPrizeRes(status, msg)
	if status == 0 then
		LuckyMoneyController.instance:handlePM_LuckyMoneyGainProgressPrizeRes(msg)
	end
end

LuckyMoneyAgent.instance = LuckyMoneyAgent.New()

return LuckyMoneyAgent
