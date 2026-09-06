-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origininfinitefutureclg/view/OriginInfiniteFutureClgLevelViewPresentor.lua

module("logic.extensions.origininfinitefutureclg.view.OriginInfiniteFutureClgLevelViewPresentor", package.seeall)

local OriginInfiniteFutureClgLevelViewPresentor = class("OriginInfiniteFutureClgLevelViewPresentor", ViewPresentor)

function OriginInfiniteFutureClgLevelViewPresentor:ctor()
	OriginInfiniteFutureClgLevelViewPresentor.super.ctor(self)
end

function OriginInfiniteFutureClgLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginInfiniteFutureClgLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/origininfinitefutureclg/origininfinitefutureclglevelview.prefab"
	}
end

function OriginInfiniteFutureClgLevelViewPresentor:buildViews()
	return {
		OriginInfiniteFutureClgLevelView.New()
	}
end

return OriginInfiniteFutureClgLevelViewPresentor
