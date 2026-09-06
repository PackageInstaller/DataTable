-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessshop/agent/SurroundByDreamGirlAgent.lua

module("logic.extensions.surroundbydreamgirl.agent.SurroundByDreamGirlAgent", package.seeall)

local SurroundByDreamGirlAgent = class("SurroundByDreamGirlAgent", BaseAgent)

function SurroundByDreamGirlAgent:sendPM_SurroundByDreamGirlInfoReq(activityId)
	local req = SurroundByDreamGirlExtension_pb.PM_SurroundByDreamGirlInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SurroundByDreamGirlAgent:handlePM_SurroundByDreamGirlInfoRes(status, msg)
	if status == 0 then
		GoddessShopController.instance:handlePM_SurroundByDreamGirlInfoRes(msg)
	end
end

function SurroundByDreamGirlAgent:sendPM_SurroundByDreamGirlGainMoneyProgressPrizeReq(activityId, prizeId)
	local req = SurroundByDreamGirlExtension_pb.PM_SurroundByDreamGirlGainMoneyProgressPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function SurroundByDreamGirlAgent:handlePM_SurroundByDreamGirlGainMoneyProgressPrizeRes(status, msg)
	if status == 0 then
		GoddessShopController.instance:handlePM_SurroundByDreamGirlGainMoneyProgressPrizeRes(msg)
	end
end

function SurroundByDreamGirlAgent:sendPM_SurroundByDreamGirlInvestReq(activityId, girlId)
	local req = SurroundByDreamGirlExtension_pb.PM_SurroundByDreamGirlInvestReq()

	req.activityId = activityId
	req.girlId = girlId

	self:sendMsg(req)
end

function SurroundByDreamGirlAgent:handlePM_SurroundByDreamGirlInvestRes(status, msg)
	if status == 0 then
		GoddessShopController.instance:handlePM_SurroundByDreamGirlInvestRes(msg)
	end
end

function SurroundByDreamGirlAgent:sendPM_SurroundByDreamGirlGetGirlTodayChatInfoReq(activityId, girlId)
	local req = SurroundByDreamGirlExtension_pb.PM_SurroundByDreamGirlGetGirlTodayChatInfoReq()

	req.activityId = activityId
	req.girlId = girlId

	self:sendMsg(req)
end

function SurroundByDreamGirlAgent:handlePM_SurroundByDreamGirlGetGirlTodayChatInfoRes(status, msg)
	if status == 0 then
		GoddessShopController.instance:handlePM_SurroundByDreamGirlGetGirlTodayChatInfoRes(msg)
	end
end

function SurroundByDreamGirlAgent:sendPM_SurroundByDreamGirlChatReq(activityId, girlId)
	local req = SurroundByDreamGirlExtension_pb.PM_SurroundByDreamGirlChatReq()

	req.activityId = activityId
	req.girlId = girlId

	self:sendMsg(req)
end

function SurroundByDreamGirlAgent:handlePM_SurroundByDreamGirlChatRes(status, msg)
	GoddessShopController.instance:handlePM_SurroundByDreamGirlChatRes(status, msg)
end

function SurroundByDreamGirlAgent:sendPM_SurroundByDreamGirlSelectAnswerReq(activityId, girlId, answer)
	local req = SurroundByDreamGirlExtension_pb.PM_SurroundByDreamGirlSelectAnswerReq()

	req.activityId = activityId
	req.girlId = girlId
	req.answer = answer

	self:sendMsg(req)
end

function SurroundByDreamGirlAgent:handlePM_SurroundByDreamGirlSelectAnswerRes(status, msg)
	if status == 0 then
		GoddessShopController.instance:handlePM_SurroundByDreamGirlSelectAnswerRes(msg)
	end
end

function SurroundByDreamGirlAgent:sendPM_SurroundByDreamGirlPresentGiftReq(activityId, girlId, giftId, presentNum)
	local req = SurroundByDreamGirlExtension_pb.PM_SurroundByDreamGirlPresentGiftReq()

	req.activityId = activityId
	req.girlId = girlId
	req.giftId = giftId
	req.presentNum = presentNum

	self:sendMsg(req)
end

function SurroundByDreamGirlAgent:handlePM_SurroundByDreamGirlPresentGiftRes(status, msg)
	if status == 0 then
		GoddessShopController.instance:handlePM_SurroundByDreamGirlPresentGiftRes(msg)
	end
end

SurroundByDreamGirlAgent.instance = SurroundByDreamGirlAgent.New()

return SurroundByDreamGirlAgent
