-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origininfinitefutureclg/view/OriginInfiniteFutureClgMainViewPresentor.lua

module("logic.extensions.origininfinitefutureclg.view.OriginInfiniteFutureClgMainViewPresentor", package.seeall)

local OriginInfiniteFutureClgMainViewPresentor = class("OriginInfiniteFutureClgMainViewPresentor", ViewPresentor)

function OriginInfiniteFutureClgMainViewPresentor:ctor()
	OriginInfiniteFutureClgMainViewPresentor.super.ctor(self)
end

function OriginInfiniteFutureClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginInfiniteFutureClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/origininfinitefutureclg/origininfinitefutureclgmainview.prefab"
	}
end

function OriginInfiniteFutureClgMainViewPresentor:buildViews()
	return {
		OriginInfiniteFutureClgMainView.New()
	}
end

return OriginInfiniteFutureClgMainViewPresentor
