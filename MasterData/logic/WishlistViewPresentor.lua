-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wishlist/view/WishlistViewPresentor.lua

module("logic.extensions.wishlist.view.WishlistViewPresentor", package.seeall)

local WishlistViewPresentor = class("WishlistViewPresentor", ViewPresentor)

function WishlistViewPresentor:ctor()
	WishlistViewPresentor.super.ctor(self)
end

function WishlistViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WishlistViewPresentor:dependWhatResources()
	return {
		"ui/views/wishlist/wishlistview.prefab"
	}
end

function WishlistViewPresentor:buildViews()
	return {
		WishlistView.New()
	}
end

return WishlistViewPresentor
