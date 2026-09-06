-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wishtreebottle/view/WishTreeBottleMainViewPresentor.lua

module("logic.extensions.wishtreebottle.view.WishTreeBottleMainViewPresentor", package.seeall)

local WishTreeBottleMainViewPresentor = class("WishTreeBottleMainViewPresentor", ViewPresentor)

function WishTreeBottleMainViewPresentor:ctor()
	WishTreeBottleMainViewPresentor.super.ctor(self)
end

function WishTreeBottleMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WishTreeBottleMainViewPresentor:dependWhatResources()
	return {
		"ui/views/wishtreebottle/wishtreebottlemainview.prefab"
	}
end

function WishTreeBottleMainViewPresentor:buildViews()
	return {
		WishTreeBottleMainView.New()
	}
end

return WishTreeBottleMainViewPresentor
