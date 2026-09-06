-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luckyskinlottery/agent/SkinLotteryAgent.lua

module("logic.extensions.skinlottery.agent.SkinLotteryAgent", package.seeall)

local SkinLotteryAgent = class("SkinLotteryAgent", BaseAgent)

function SkinLotteryAgent:sendPM_SkinLotteryPanelInfoReq(activityId)
	local req = SkinLotteryExtension_pb.PM_SkinLotteryPanelInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SkinLotteryAgent:handlePM_SkinLotteryPanelInfoRes(status, msg)
	if status == 0 then
		LuckyDrawNewSkinModel.instance:setViewInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SkinLotteryMainInfo, msg.activityId)
	end
end

function SkinLotteryAgent:sendPM_SkinLotteryRecordsReq(activityId)
	local req = SkinLotteryExtension_pb.PM_SkinLotteryRecordsReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SkinLotteryAgent:handlePM_SkinLotteryRecordsRes(status, msg)
	if status == 0 then
		local records = msg.records

		LuckyDrawNewSkinModel.instance:setRankRollTextInfo(records, msg.activityId)
		GlobalDispatcher:dispatch(GlobalNotify.SkinLotteryTxtInfo, msg.activityId)
	end
end

function SkinLotteryAgent:sendPM_SkinLotteryReq(activityId, inflationMoneyActivityIsOpen, useCoupon)
	inflationMoneyActivityIsOpen = inflationMoneyActivityIsOpen or false

	local req = SkinLotteryExtension_pb.PM_SkinLotteryReq()

	req.activityId = activityId
	req.inflationMoneyActivityIsOpen = inflationMoneyActivityIsOpen
	req.useCoupon = useCoupon

	self:sendMsg(req)
end

function SkinLotteryAgent:handlePM_SkinLotteryRes(status, msg)
	if status == 0 then
		LuckyDrawNewSkinModel.instance:setSkinLotteryInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SkinLotteryBtnInfo, msg.activityId)
	end
end

function SkinLotteryAgent:sendPM_SkinLotteryGetProcessRewardReq(activityId)
	local req = SkinLotteryExtension_pb.PM_SkinLotteryGetProcessRewardReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SkinLotteryAgent:handlePM_SkinLotteryGetProcessRewardRes(status, msg)
	if status == 0 then
		LuckyDrawNewSkinModel.instance:setSkinLotteryGetProcessReward(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SkinLotteryProgress, msg.activityId)
	end
end

function SkinLotteryAgent:sendPM_SkinLotteryRankReq(activityId)
	local req = SkinLotteryExtension_pb.PM_SkinLotteryRankReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SkinLotteryAgent:handlePM_SkinLotteryRankRes(status, msg)
	if status == 0 then
		LuckyDrawNewSkinModel.instance:setRankInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SkinLotteryRankInfo, msg.activityId)
	end
end

function SkinLotteryAgent:sendPM_SkinLotteryFreeChargeRankReq(activityId)
	local req = SkinLotteryExtension_pb.PM_SkinLotteryFreeChargeRankReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SkinLotteryAgent:handlePM_SkinLotteryFreeChargeRankRes(status, msg)
	if status == 0 then
		LuckyDrawNewSkinModel.instance:handlePM_SkinLotteryFreeChargeRankRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.PM_SkinLotteryFreeChargeRankRes, msg.activityId)
	end
end

SkinLotteryAgent.instance = SkinLotteryAgent.New()

return SkinLotteryAgent
