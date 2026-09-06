-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/view/tab/wishtreebottle/WishTreeBottleTaskFrameViewPresentor.lua

module("logic.extensions.eventtasksummary.view.tab.wishtreebottle.WishTreeBottleTaskFrameViewPresentor", package.seeall)

local WishTreeBottleTaskFrameViewPresentor = class("WishTreeBottleTaskFrameViewPresentor", ViewPresentor)

function WishTreeBottleTaskFrameViewPresentor:ctor()
	WishTreeBottleTaskFrameViewPresentor.super.ctor(self)
end

function WishTreeBottleTaskFrameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WishTreeBottleTaskFrameViewPresentor:dependWhatResources()
	return {
		"ui/views/eventtasksummary/wishtreebottle/wishtreebottletaskframeview.prefab"
	}
end

function WishTreeBottleTaskFrameViewPresentor:buildViews()
	return {
		WishTreeBottleTaskFrameView.New()
	}
end

return WishTreeBottleTaskFrameViewPresentor
