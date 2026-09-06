-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dressactivityshop/agent/DressDiscountAgent.lua

module("logic.extensions.dressdiscount.agent.DressDiscountAgent", package.seeall)

local DressDiscountAgent = class("DressDiscountAgent", BaseAgent)

function DressDiscountAgent:ctor()
	return
end

function DressDiscountAgent:setExtId(extId)
	DressDiscountAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function DressDiscountAgent:sendPM_DressDiscountGetInfoReq(activityId)
	local req = DressDiscountExtension_pb.PM_DressDiscountGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DressDiscountAgent:handlePM_DressDiscountGetInfoRes(status, msg)
	if status == 0 then
		DressSellController.instance:onGetDressDiscountInfo(msg)
	end
end

function DressDiscountAgent:sendPM_DressDiscountBuyReq(activityId, id, gapId)
	local req = DressDiscountExtension_pb.PM_DressDiscountBuyReq()

	req.activityId = activityId
	req.id = id
	req.gapId = gapId

	self:sendMsg(req)
end

function DressDiscountAgent:handlePM_DressDiscountBuyRes(status, msg)
	if status == 0 then
		DressSellController.instance:handleBuyMoorSuc(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.DiscountDressMoorBuyError)
	end
end

function DressDiscountAgent:handlePM_DressDiscountNotifySucRes(status, msg)
	DressSellController.instance:handleRmbBuyMoorSuc(msg)
end

function DressDiscountAgent:sendPM_DressDisscountGainCollectPrizeReq(activityId, id)
	local req = DressDiscountExtension_pb.PM_DressDisscountGainCollectPrizeReq()

	req.activityId = activityId
	req.id = id

	self:sendMsg(req)
end

function DressDiscountAgent:handlePM_DressDisscountGainCollectPrizeRes(status, msg)
	if status == 0 then
		DressSellController.instance:handlePM_DressDisscountGainCollectPrizeRes(status, msg)
	end
end

DressDiscountAgent.instance = DressDiscountAgent.New()

return DressDiscountAgent
