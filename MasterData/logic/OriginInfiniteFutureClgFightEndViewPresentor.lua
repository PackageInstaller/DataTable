-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origininfinitefutureclg/view/OriginInfiniteFutureClgFightEndViewPresentor.lua

module("logic.extensions.origininfinitefutureclg.view.OriginInfiniteFutureClgFightEndViewPresentor", package.seeall)

local OriginInfiniteFutureClgFightEndViewPresentor = class("OriginInfiniteFutureClgFightEndViewPresentor", ViewPresentor)

function OriginInfiniteFutureClgFightEndViewPresentor:ctor()
	OriginInfiniteFutureClgFightEndViewPresentor.super.ctor(self)
end

function OriginInfiniteFutureClgFightEndViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginInfiniteFutureClgFightEndViewPresentor:dependWhatResources()
	return {
		"ui/views/origininfinitefutureclg/origininfinitefutureclgfightendview.prefab"
	}
end

function OriginInfiniteFutureClgFightEndViewPresentor:buildViews()
	return {
		OriginInfiniteFutureClgFightEndView.New()
	}
end

return OriginInfiniteFutureClgFightEndViewPresentor
