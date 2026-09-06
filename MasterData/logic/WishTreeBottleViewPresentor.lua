-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wishtreebottle/view/WishTreeBottleViewPresentor.lua

module("logic.extensions.wishtreebottle.view.WishTreeBottleViewPresentor", package.seeall)

local WishTreeBottleViewPresentor = class("WishTreeBottleViewPresentor", ViewPresentor)

function WishTreeBottleViewPresentor:ctor()
	WishTreeBottleViewPresentor.super.ctor(self)
end

function WishTreeBottleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WishTreeBottleViewPresentor:dependWhatResources()
	return {
		"ui/views/wishtreebottle/wishtreebottleview.prefab"
	}
end

function WishTreeBottleViewPresentor:buildViews()
	return {
		WishTreeBottleView.New()
	}
end

return WishTreeBottleViewPresentor
