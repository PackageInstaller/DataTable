-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/agent/PayShopAgent.lua

module("logic.extensions.payshop.agent.PayShopAgent", package.seeall)

local PayShopAgent = class("PayShopAgent", BaseAgent)

PayShopAgent.GetAllPayShopBuyTimesRes = "PayShopAgent_GetAllPayShopBuyTimesRes"
PayShopAgent.GetConsumeGiftInfoRes = "PayShopAgent_GetConsumeGiftInfoRes"
PayShopAgent.GainConsumeGiftRes = "PayShopAgent_GainConsumeGiftRes"
PayShopAgent.GetAccConsumeGiftInfoRes = "PayShopAgent_GetAccConsumeGiftInfoRes"
PayShopAgent.GainAccConsumeGiftRes = "PayShopAgent_GainAccConsumeGiftRes"
PayShopAgent.GetLevelTimeMachineInfoRes = "PayShopAgent_GetLevelTimeMachineInfoRes"
PayShopAgent.UseLevelTimeMachineRes = "PayShopAgent_UseLevelTimeMachineRes"
PayShopAgent.BuyItemRes = "PayShopAgent_BuyItemRes"
PayShopAgent.NotifyPayShopItemBuySucRes = "PayShopAgent_NotifyPayShopItemBuySucRes"
PayShopAgent.NotifyLevelTimeMachineUseSucRes = "PayShopAgent_NotifyLevelTimeMachineUseSucRes"
PayShopAgent.GetDiscountGiftInfoRes = "PayShopAgent.GetDiscountGiftInfoRes"
PayShopAgent.GainDiscountGiftRes = "PayShopAgent.GainDiscountGiftRes"
PayShopAgent.OneKeyGainDiscountGiftRes = "PayShopAgent.OneKeyGainDiscountGiftRes"

function PayShopAgent:ctor()
	return
end

function PayShopAgent:setExtId(extId)
	PayShopAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function PayShopAgent:sendGetAllPayShopBuyTimesReq(handler, handlerObj, errHandler)
	local req = PayShopExtension_pb.GetAllPayShopBuyTimesReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PayShopAgent.GetAllPayShopBuyTimesRes, handler, handlerObj, errHandler)
	end

	self:sendMsg(req)
end

function PayShopAgent:handleGetAllPayShopBuyTimesRes(status, msg)
	forcePrint("=====RoleDataRequestor:_loadPayShopInfo===back")
	self:dispatch(PayShopAgent.GetAllPayShopBuyTimesRes, status, msg)
end

function PayShopAgent:sendGetConsumeGiftInfoReq(handler, handlerObj, errHandler)
	local req = PayShopExtension_pb.GetConsumeGiftInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PayShopAgent.GetConsumeGiftInfoRes, handler, handlerObj, errHandler)
	end

	self:sendMsg(req)
end

function PayShopAgent:handleGetConsumeGiftInfoRes(status, msg)
	self:dispatch(PayShopAgent.GetConsumeGiftInfoRes, status, msg)
end

function PayShopAgent:sendGainConsumeGiftReq(id, handler, handlerObj, errHandler)
	local req = PayShopExtension_pb.GainConsumeGiftReq()

	req.id = id

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PayShopAgent.GainConsumeGiftRes, handler, handlerObj, errHandler)
	end

	self:sendMsg(req)
end

function PayShopAgent:handleGainConsumeGiftRes(status, msg)
	self:dispatch(PayShopAgent.GainConsumeGiftRes, status, msg)
end

function PayShopAgent:sendGetAccConsumeGiftInfoReq(handler, handlerObj, errHandler)
	local req = PayShopExtension_pb.GetAccConsumeGiftInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PayShopAgent.GetAccConsumeGiftInfoRes, handler, handlerObj, errHandler)
	end

	self:sendMsg(req)
end

function PayShopAgent:handleGetAccConsumeGiftInfoRes(status, msg)
	self:dispatch(PayShopAgent.GetAccConsumeGiftInfoRes, status, msg)
end

function PayShopAgent:sendGainAccConsumeGiftReq(id, handler, handlerObj, errHandler)
	local req = PayShopExtension_pb.GainAccConsumeGiftReq()

	req.id = id

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PayShopAgent.GainAccConsumeGiftRes, handler, handlerObj, errHandler)
	end

	self:sendMsg(req)
end

function PayShopAgent:handleGainAccConsumeGiftRes(status, msg)
	self:dispatch(PayShopAgent.GainAccConsumeGiftRes, status, msg)
end

function PayShopAgent:sendGetLevelTimeMachineInfoReq(handler, handlerObj, errHandler)
	local req = PayShopExtension_pb.GetLevelTimeMachineInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PayShopAgent.GetLevelTimeMachineInfoRes, handler, handlerObj, errHandler)
	end

	self:sendMsg(req)
end

function PayShopAgent:handleGetLevelTimeMachineInfoRes(status, msg)
	self:dispatch(PayShopAgent.GetLevelTimeMachineInfoRes, status, msg)
end

function PayShopAgent:sendUseLevelTimeMachineReq(id, petId, subIndex, handler, handlerObj, errHandler)
	local req = PayShopExtension_pb.UseLevelTimeMachineReq()

	req.id = id
	req.petId = petId

	if subIndex ~= nil then
		req.subIndex = subIndex
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PayShopAgent.UseLevelTimeMachineRes, handler, handlerObj, errHandler)
	end

	self:sendMsg(req)
end

function PayShopAgent:handleUseLevelTimeMachineRes(status, msg)
	self:dispatch(PayShopAgent.UseLevelTimeMachineRes, status, msg)
end

function PayShopAgent:sendBuyItemReq(id, buyTimes, discountPlanId, deduceItemCount)
	local req = PayShopExtension_pb.BuyItemReq()

	req.id = id
	req.buyTimes = buyTimes

	if discountPlanId and discountPlanId > 0 then
		req.discountPlanId = discountPlanId
	end

	if deduceItemCount and deduceItemCount > 0 then
		req.deduceItemCount = deduceItemCount
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PayShopAgent.BuyItemRes, handler, handlerObj, errHandler)
	end

	self:sendMsg(req)
end

function PayShopAgent:handleBuyItemRes(status, msg)
	self:dispatch(PayShopAgent.BuyItemRes, status, msg)
end

function PayShopAgent:handleNotifyPayShopItemBuySucRes(status, msg)
	self:dispatch(PayShopAgent.NotifyPayShopItemBuySucRes, status, msg)
end

function PayShopAgent:handleNotifyLevelTimeMachineUseSucRes(status, msg)
	self:dispatch(PayShopAgent.NotifyLevelTimeMachineUseSucRes, status, msg)
end

function PayShopAgent:sendBatchBuyItemReq(items)
	local req = PayShopExtension_pb.BatchBuyItemReq()

	for i, v in ipairs(items) do
		local item = req.items:add()

		item.id = v.id
		item.buyTimes = v.buyTimes
		item.deduceItemCount = v.deduceItemCount or 0
	end

	self:sendMsg(req)
end

function PayShopAgent:handleBatchBuyItemRes(status, msg)
	if status == 0 then
		self:dispatch(PayShopAgent.BuyItemRes, status, msg)
	end
end

function PayShopAgent:sendGetDiscountGiftInfoReq(activityId)
	local req = PayShopExtension_pb.GetDiscountGiftInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PayShopAgent:handleGetDiscountGiftInfoRes(status, msg)
	if status == 0 then
		-- block empty
	end

	self:dispatch(PayShopAgent.GetDiscountGiftInfoRes, status, msg)
end

function PayShopAgent:sendGainDiscountGiftReq(activityId, giftId)
	local req = PayShopExtension_pb.GainDiscountGiftReq()

	req.activityId = activityId
	req.giftId = giftId

	self:sendMsg(req)
end

function PayShopAgent:handleGainDiscountGiftRes(status, msg)
	if status == 0 then
		-- block empty
	end

	self:dispatch(PayShopAgent.GainDiscountGiftRes, status, msg)
end

function PayShopAgent:sendOneKeyGainDiscountGiftReq(activityId)
	local req = PayShopExtension_pb.OneKeyGainDiscountGiftReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PayShopAgent:handleOneKeyGainDiscountGiftRes(status, msg)
	if status == 0 then
		-- block empty
	end

	self:dispatch(PayShopAgent.OneKeyGainDiscountGiftRes, status, msg)
end

PayShopAgent.instance = PayShopAgent.New()

return PayShopAgent
