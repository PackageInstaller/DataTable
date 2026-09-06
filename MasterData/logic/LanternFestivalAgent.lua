-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lanternfestival/agent/LanternFestivalAgent.lua

module("logic.extensions.lanternfestival.agent.LanternFestivalAgent", package.seeall)

local LanternFestivalAgent = class("LanternFestivalAgent", BaseAgent)

function LanternFestivalAgent:sendPM_LanternFestivalGetInfoReq(activityId)
	local req = LanternFestivalExtension_pb.PM_LanternFestivalGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LanternFestivalAgent:handlePM_LanternFestivalGetInfoRes(status, msg)
	if status == 0 then
		LanternFestivalController.instance:handlePM_LanternFestivalGetInfoRes(msg)
	end
end

function LanternFestivalAgent:sendPM_LanternFestivalAnswerChannelQuestionPeq(activityId, answer)
	local req = LanternFestivalExtension_pb.PM_LanternFestivalAnswerChannelQuestionPeq()

	req.activityId = activityId
	req.answer = answer

	self:sendMsg(req)
end

function LanternFestivalAgent:handlePM_LanternFestivalAnswerChannelQuestionPes(status, msg)
	if status == 0 then
		LanternFestivalController.instance:handlePM_LanternFestivalAnswerChannelQuestionPes(msg)
	end
end

function LanternFestivalAgent:sendPM_LanternFestivalfinishPersionQuestionPeq(activityId)
	local req = LanternFestivalExtension_pb.PM_LanternFestivalfinishPersionQuestionPeq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LanternFestivalAgent:handlePM_LanternFestivalfinishPersionQuestionPes(status, msg)
	if status == 0 then
		LanternFestivalController.instance:handlePM_LanternFestivalfinishPersionQuestionPes(msg)
	end
end

function LanternFestivalAgent:sendPM_LanternFestivalGainExtPrizeReq(activityId)
	local req = LanternFestivalExtension_pb.PM_LanternFestivalGainExtPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LanternFestivalAgent:handlePM_LanternFestivalGainExtPrizeRes(status, msg)
	if status == 0 then
		LanternFestivalController.instance:handlePM_LanternFestivalGainExtPrizeRes(msg)
	end
end

function LanternFestivalAgent:sendPM_LanternFestivalExchangeCollectPrizeReq(activityId, prizeId)
	local req = LanternFestivalExtension_pb.PM_LanternFestivalExchangeCollectPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function LanternFestivalAgent:handlePM_LanternFestivalExchangeCollectPrizeRes(status, msg)
	if status == 0 then
		LanternFestivalController.instance:handlePM_LanternFestivalExchangeCollectPrizeRes(msg)
	end
end

LanternFestivalAgent.instance = LanternFestivalAgent.New()

return LanternFestivalAgent
