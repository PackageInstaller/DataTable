-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wishlist/view/WishlistshowViewPresentor.lua

module("logic.extensions.wishlist.view.WishlistshowViewPresentor", package.seeall)

local WishlistshowViewPresentor = class("WishlistshowViewPresentor", ViewPresentor)

function WishlistshowViewPresentor:ctor()
	WishlistshowViewPresentor.super.ctor(self)
end

function WishlistshowViewPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function WishlistshowViewPresentor:dependWhatResources()
	return {
		"ui/views/wishlist/wishlistshowview.prefab"
	}
end

function WishlistshowViewPresentor:buildViews()
	return {
		WishlistshowView.New()
	}
end

return WishlistshowViewPresentor
