-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinebounty/agent/DivineBountyAgent.lua

module("logic.extensions.divinebounty.agent.DivineBountyAgent", package.seeall)

local DivineBountyAgent = class("DivineBountyAgent", BaseAgent)

function DivineBountyAgent:sendPM_DivineBountyGetLotteryInfoReq()
	local req = DivineBountyExtension_pb.PM_DivineBountyGetLotteryInfoReq()

	self:sendMsg(req)
end

function DivineBountyAgent:handlePM_DivineBountyGetLotteryInfoRes(status, msg)
	if status == 0 then
		DivineBountyModel.instance:onDivineBountyGetLotteryInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineBountyGetLotteryInfoRes)
	end
end

function DivineBountyAgent:sendPM_DivineBountyLotteryReq(lotteryTimes)
	local req = DivineBountyExtension_pb.PM_DivineBountyLotteryReq()

	req.lotteryTimes = lotteryTimes

	self:sendMsg(req)
end

function DivineBountyAgent:handlePM_DivineBountyLotteryRes(status, msg)
	if status == 0 then
		DivineBountyModel.instance:onDivineBountyLotteryRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineBountyLotteryRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.DivineBountyViewUnlockBlock)
	end
end

function DivineBountyAgent:sendPM_DivineBountyGetShopInfoReq()
	local req = DivineBountyExtension_pb.PM_DivineBountyGetShopInfoReq()

	self:sendMsg(req)
end

function DivineBountyAgent:handlePM_DivineBountyGetShopInfoRes(status, msg)
	if status == 0 then
		DivineBountyModel.instance:onDivineBountyGetShopInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineBountyGetShopInfoRes)
	end
end

function DivineBountyAgent:sendPM_DivineBountyBuyShopItemReq(itemId, count)
	local req = DivineBountyExtension_pb.PM_DivineBountyBuyShopItemReq()

	req.itemId = itemId
	req.count = count

	self:sendMsg(req)
end

function DivineBountyAgent:handlePM_DivineBountyBuyShopItemRes(status, msg)
	if status == 0 then
		DivineBountyModel.instance:onDivineBountyBuyShopItemRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineBountyBuyShopItemRes)
	end
end

DivineBountyAgent.instance = DivineBountyAgent.New()

return DivineBountyAgent
