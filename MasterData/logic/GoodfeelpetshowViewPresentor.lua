-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goodfeel/view/GoodfeelpetshowViewPresentor.lua

module("logic.extensions.goodfeel.view.GoodfeelpetshowViewPresentor", package.seeall)

local GoodfeelpetshowViewPresentor = class("GoodfeelpetshowViewPresentor", ViewPresentor)

function GoodfeelpetshowViewPresentor:ctor()
	GoodfeelpetshowViewPresentor.super.ctor(self)
end

function GoodfeelpetshowViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoodfeelpetshowViewPresentor:dependWhatResources()
	return {
		"ui/views/goodfeel/goodfeelpetshowview.prefab"
	}
end

function GoodfeelpetshowViewPresentor:buildViews()
	return {
		GoodfeelpetshowView.New(),
		GoodfeelgiftView.New()
	}
end

return GoodfeelpetshowViewPresentor
