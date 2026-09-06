-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wishlist/controller/WishListController.lua

module("logic.extensions.wishlist.controller.WishListController", package.seeall)

local WishListController = class("WishListController", BaseController)

WishListController.UpdateViewState = "WishListController.UpdateViewState"

function WishListController:onInit()
	self:onReset()
end

function WishListController:onReset()
	self._curShowWish = nil
	self._hasGainIds = nil
	self._myWishes = nil
	self._hasSendWishToday = false
end

function WishListController:handleGetInfo(msg)
	self._curShowWish = {}

	for _, v in ipairs(msg.wishes) do
		local data = {}

		data.name = v.name
		data.contentId = checkint(v.contentId)

		table.insert(self._curShowWish, data)
	end

	self._hasGainIds = {}

	for _, v in ipairs(msg.gainPrizeIndexes) do
		self._hasGainIds[checkint(v)] = true
	end

	self._myWishes = {}

	for _, v in ipairs(msg.myWishes) do
		table.insert(self._myWishes, checkint(v))
	end

	self._hasSendWishToday = msg.hasSendWishToday

	GlobalDispatcher:dispatch(WishListController.UpdateViewState)
end

function WishListController:handleSendWish(msg)
	self._hasSendWishToday = true

	GlobalDispatcher:dispatch(WishListController.UpdateViewState)
end

function WishListController:handleGainPrize(msg)
	GlobalDispatcher:dispatch(WishListController.UpdateViewState)
end

function WishListController:getCurShowWish()
	return self._curShowWish or {}
end

function WishListController:getMyWishes()
	return self._myWishes or {}
end

function WishListController:getHasGainIds()
	return self._hasGainIds or {}
end

function WishListController:getHasSendWishToday()
	return self._hasSendWishToday
end

function WishListController:addSendWishId(id)
	self._myWishes = self._myWishes or {}

	table.insert(self._myWishes, id)
end

function WishListController:addSendWishId(id)
	self._myWishes = self._myWishes or {}

	table.insert(self._myWishes, id)
end

function WishListController:addGainPrizeId(day)
	self._hasGainIds = self._hasGainIds or {}
	self._hasGainIds[day] = true
end

WishListController.instance = WishListController.New()

return WishListController
