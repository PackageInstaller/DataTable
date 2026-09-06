-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pricebreakdiscount/agent/PriceBreakDiscountAgent.lua

module("logic.extensions.pricebreakdiscount.agent.PriceBreakDiscountAgent", package.seeall)

local PriceBreakDiscountAgent = class("PriceBreakDiscountAgent", BaseAgent)

PriceBreakDiscountAgent.PM_PriceBreakDiscountGetInfoRes = "PriceBreakDiscountAgent.PM_PriceBreakDiscountGetInfoRes"
PriceBreakDiscountAgent.PM_PriceBreakDiscountBuyRes = "PriceBreakDiscountAgent.PM_PriceBreakDiscountBuyRes"
PriceBreakDiscountAgent.PM_PriceBreakDiscountSaveCartRes = "PriceBreakDiscountAgent.PM_PriceBreakDiscountSaveCartRes"

function PriceBreakDiscountAgent:sendPM_PriceBreakDiscountGetInfoReq(activityId)
	local req = PriceBreakDiscountExtension_pb.PM_PriceBreakDiscountGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PriceBreakDiscountAgent:handlePM_PriceBreakDiscountGetInfoRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(PriceBreakDiscountAgent.PM_PriceBreakDiscountGetInfoRes, msg, status)
	end
end

function PriceBreakDiscountAgent:sendPM_PriceBreakDiscountBuyReq(activityId, cartItem, inflationMoneyActivityIsOpen)
	local req = PriceBreakDiscountExtension_pb.PM_PriceBreakDiscountBuyReq()

	req.activityId = activityId

	if cartItem ~= nil then
		for i, v1 in ipairs(cartItem) do
			local items = req.cartItem:add()

			items:ParseFromString(v1:SerializeToString())
		end
	end

	req.inflationMoneyActivityIsOpen = inflationMoneyActivityIsOpen

	self:sendMsg(req)
end

function PriceBreakDiscountAgent:handlePM_PriceBreakDiscountBuyRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(PriceBreakDiscountAgent.PM_PriceBreakDiscountBuyRes, msg, status)
	end
end

function PriceBreakDiscountAgent:sendPM_PriceBreakDiscountSaveCartReq(activityId, cartItem)
	local req = PriceBreakDiscountExtension_pb.PM_PriceBreakDiscountSaveCartReq()

	req.activityId = activityId

	if cartItem ~= nil then
		for i, v1 in ipairs(cartItem) do
			local items = req.cartItem:add()

			items:ParseFromString(v1:SerializeToString())
		end
	end

	self:sendMsg(req)
end

function PriceBreakDiscountAgent:handlePM_PriceBreakDiscountSaveCartRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(PriceBreakDiscountAgent.PM_PriceBreakDiscountSaveCartRes, msg, status)
	end
end

PriceBreakDiscountAgent.instance = PriceBreakDiscountAgent.New()

return PriceBreakDiscountAgent
