-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wishlist/agent/WishListAgent.lua

module("logic.extensions.wishlist.agent.WishListAgent", package.seeall)

local WishListAgent = class("WishListAgent", BaseAgent)

function WishListAgent:sendPM_GetWishListInfoReq(activityId)
	local req = WishListExtension_pb.PM_GetWishListInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function WishListAgent:handlePM_GetWishListInfoRes(status, msg)
	if status == 0 then
		WishListController.instance:handleGetInfo(msg)
	end
end

function WishListAgent:sendPM_SendWishReq(activityId, contentId)
	local req = WishListExtension_pb.PM_SendWishReq()

	req.activityId = activityId
	req.contentId = contentId
	self._temWishId = contentId

	self:sendMsg(req)
end

function WishListAgent:handlePM_SendWishRes(status, msg)
	if status == 0 then
		WishListController.instance:addSendWishId(self._temWishId)
		WishListController.instance:handleSendWish(msg)
	end

	self._temWishId = nil
end

function WishListAgent:sendPM_GainWishPrizeReq(activityId, day)
	local req = WishListExtension_pb.PM_GainWishPrizeReq()

	req.activityId = activityId
	req.day = day
	self._temDay = day

	self:sendMsg(req)
end

function WishListAgent:handlePM_GainWishPrizeRes(status, msg)
	if status == 0 then
		WishListController.instance:addGainPrizeId(self._temDay)
		WishListController.instance:handleGainPrize(msg)
	end

	self._temDay = nil
end

WishListAgent.instance = WishListAgent.New()

return WishListAgent
