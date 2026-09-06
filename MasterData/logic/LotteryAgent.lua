-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/agent/LotteryAgent.lua

module("logic.extensions.lottery.agent.LotteryAgent", package.seeall)

local LotteryAgent = class("LotteryAgent", BaseAgent)

LotteryAgent.LotteryDrawRes = "LotteryAgent_LotteryDrawRes"
LotteryAgent.LotteryInfoRes = "LotteryAgent_LotteryInfoRes"
LotteryAgent.LotteryShopInfoRes = "LotteryAgent_LotteryShopInfoRes"
LotteryAgent.LotteryGodShopBuyRes = "LotteryAgent_LotteryGodShopBuyRes"
LotteryAgent.LotteryCommonShopBuyRes = "LotteryAgent_LotteryCommonShopBuyRes"
LotteryAgent.LotteryGodShopInfoRes = "LotteryAgent_LotteryGodShopInfoRes"
LotteryAgent.LotterySelectWishPetRes = "LotteryAgent_LotterySelectWishPetRes"

function LotteryAgent:ctor()
	return
end

function LotteryAgent:setExtId(extId)
	LotteryAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function LotteryAgent:sendLotteryDrawReq(groupId, poolId, times, substituteTimes, discountSubId, handler, handlerObj, errHandler)
	local req = LotteryExtension_pb.LotteryDrawReq()

	req.groupId = groupId
	req.poolId = poolId
	req.times = times
	req.substituteConsumeTimes = substituteTimes
	req.discountSubId = discountSubId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(LotteryAgent.LotteryDrawRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function LotteryAgent:handleLotteryDrawRes(status, msg)
	self:dispatch(LotteryAgent.LotteryDrawRes, status, msg)
end

function LotteryAgent:sendLotteryInfoReq(handler, handlerObj, errHandler)
	local req = LotteryExtension_pb.LotteryInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(LotteryAgent.LotteryInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function LotteryAgent:handleLotteryInfoRes(status, msg)
	self:dispatch(LotteryAgent.LotteryInfoRes, status, msg)
end

function LotteryAgent:sendLotteryShopInfoReq(handler, handlerObj, errHandler)
	local req = LotteryExtension_pb.LotteryShopInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(LotteryAgent.LotteryShopInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function LotteryAgent:handleLotteryShopInfoRes(status, msg)
	self:dispatch(LotteryAgent.LotteryShopInfoRes, status, msg)
end

function LotteryAgent:sendLotteryGodShopBuyReq(itemId, poolId, handler, handlerObj, errHandler)
	local req = LotteryExtension_pb.LotteryGodShopBuyReq()

	req.itemId = itemId
	req.poolId = poolId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(LotteryAgent.LotteryGodShopBuyRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function LotteryAgent:handleLotteryGodShopBuyRes(status, msg)
	self:dispatch(LotteryAgent.LotteryGodShopBuyRes, status, msg)
end

function LotteryAgent:sendLotteryCommonShopBuyReq(itemId, handler, handlerObj, errHandler)
	local req = LotteryExtension_pb.LotteryCommonShopBuyReq()

	req.itemId = itemId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(LotteryAgent.LotteryCommonShopBuyRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function LotteryAgent:handleLotteryCommonShopBuyRes(status, msg)
	self:dispatch(LotteryAgent.LotteryCommonShopBuyRes, status, msg)
end

function LotteryAgent:sendLotteryGodShopInfoReq(poolId, handler, handlerObj, errHandler)
	local req = LotteryExtension_pb.LotteryGodShopInfoReq()

	req.poolId = poolId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(LotteryAgent.LotteryGodShopInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function LotteryAgent:handleLotteryGodShopInfoRes(status, msg)
	self:dispatch(LotteryAgent.LotteryGodShopInfoRes, status, msg)
end

function LotteryAgent:sendLotterySelectWishPetReq(poolId, raceId, handler, handlerObj, errHandler)
	local req = LotteryExtension_pb.LotterySelectWishPetReq()

	req.poolId = poolId
	req.raceId = raceId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(LotteryAgent.LotterySelectWishPetRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function LotteryAgent:handleLotterySelectWishPetRes(status, msg)
	self:dispatch(LotteryAgent.LotterySelectWishPetRes, status, msg)
end

function LotteryAgent:sendPM_UnlockLotteryPoolInGroupReq(groupId)
	local req = LotteryExtension_pb.PM_UnlockLotteryPoolInGroupReq()

	req.groupId = groupId

	self:sendMsg(req)
end

function LotteryAgent:handlePM_UnlockLotteryPoolInGroupRes(status, msg)
	if status == 0 then
		LotteryController.instance:SCAcceptUnlockGroup()
	end
end

function LotteryAgent:sendPM_LotterySelectPrizeInfoReq(poolId)
	local req = LotteryExtension_pb.PM_LotterySelectPrizeInfoReq()

	req.poolId = poolId

	self:sendMsg(req)
end

function LotteryAgent:handlePM_LotterySelectPrizeInfoRes(status, msg)
	if status == 0 then
		LotteryController.instance:scSendLotterySelectPrizeInfo(msg)
	end
end

function LotteryAgent:sendPM_LotterySelectPrizeSetPosReq(poolId, infos)
	local req = LotteryExtension_pb.PM_LotterySelectPrizeSetPosReq()

	req.poolId = poolId

	if infos and #infos > 0 then
		for i = 1, #infos do
			local posInfo = req.posInfo:add()

			posInfo.posId = infos[i].posId
			posInfo.prizeId = infos[i].prizeId
		end
	end

	self:sendMsg(req)
end

function LotteryAgent:handlePM_LotterySelectPrizeSetPosRes(status, msg)
	if status == 0 then
		LotteryController.instance:scSendLotterySelectPrizeSetPos(msg)
	end
end

function LotteryAgent:sendPM_LotterySelectPrizeResetReq(poolId)
	local req = LotteryExtension_pb.PM_LotterySelectPrizeResetReq()

	req.poolId = poolId

	self:sendMsg(req)
end

function LotteryAgent:handlePM_LotterySelectPrizeResetRes(status, msg)
	if status == 0 then
		LotteryController.instance:scSendLotterySelectPrizeReset(msg)
	end
end

function LotteryAgent:sendPM_LotterySelectUpPetReq(poolId, groupId, gridId, raceId)
	local req = LotteryExtension_pb.PM_LotterySelectUpPetReq()

	req.poolId = poolId
	req.groupId = groupId
	req.gridId = gridId
	req.raceId = raceId

	self:sendMsg(req)
end

function LotteryAgent:handlePM_LotterySelectUpPetRes(status, msg)
	if status == 0 then
		LotteryController.instance:handleSelfSelectPetUp(msg)
	end
end

function LotteryAgent:sendPM_LotteryResetUpPetReq(poolId, groupId)
	local req = LotteryExtension_pb.PM_LotteryResetUpPetReq()

	req.poolId = poolId
	req.groupId = groupId

	self:sendMsg(req)
end

function LotteryAgent:handlePM_LotteryResetUpPetRes(status, msg)
	if status == 0 then
		LotteryController.instance:handleResetSelfSelectPetUp(msg)
	end
end

function LotteryAgent:sendPM_LotterySelectUpPrizeReq(poolId, groupId, raceId)
	local req = LotteryExtension_pb.PM_LotterySelectUpPrizeReq()

	req.poolId = poolId
	req.groupId = groupId
	req.raceId = raceId

	self:sendMsg(req)
end

function LotteryAgent:handlePM_LotterySelectUpPrizeRes(status, msg)
	if status == 0 then
		LotteryController.instance:handleSelfSelectPetTimes(msg)
	end
end

LotteryAgent.instance = LotteryAgent.New()

return LotteryAgent
