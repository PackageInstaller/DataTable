-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wishtreebottle/view/WishTreeBottleInfoViewPresentor.lua

module("logic.extensions.wishtreebottle.view.WishTreeBottleInfoViewPresentor", package.seeall)

local WishTreeBottleInfoViewPresentor = class("WishTreeBottleInfoViewPresentor", ViewPresentor)

function WishTreeBottleInfoViewPresentor:ctor()
	WishTreeBottleInfoViewPresentor.super.ctor(self)
end

function WishTreeBottleInfoViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WishTreeBottleInfoViewPresentor:dependWhatResources()
	return {
		"ui/views/wishtreebottle/wishtreebottleinfoview.prefab"
	}
end

function WishTreeBottleInfoViewPresentor:buildViews()
	return {
		WishTreeBottleInfoView.New()
	}
end

return WishTreeBottleInfoViewPresentor
