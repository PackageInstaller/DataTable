-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wishlist/view/WishlistshowView.lua

module("logic.extensions.wishlist.view.WishlistshowView", package.seeall)

local WishlistshowView = class("WishlistshowView", ViewComponent)

function WishlistshowView:buildUI()
	WishlistshowView.super.buildUI(self)

	self._blurBg = goutil.findChildComponent(self.mainGO, "blurBg", "StaticBluredScreen")
	self._btnClose = self:getBtn("blurBg")
	self._txtShowBless = self:getTxt("bless/showBless")
end

function WishlistshowView:bindEvents()
	WishlistshowView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function WishlistshowView:unbindEvents()
	WishlistshowView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function WishlistshowView:onEnter()
	WishlistshowView.super.onEnter(self)
	self._blurBg:Release()
	self._blurBg:Capture()

	self._txtShowBless.text = self:getFirstParam()
end

function WishlistshowView:onExit()
	WishlistshowView.super.onExit(self)
	self._blurBg:Release()
end

return WishlistshowView
