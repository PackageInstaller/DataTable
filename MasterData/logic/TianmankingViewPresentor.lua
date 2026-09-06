-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/tianmanking/TianmankingViewPresentor.lua

module("logic.extensions.tianmanking.view.TianmankingViewPresentor", package.seeall)

local TianmankingViewPresentor = class("TianmankingViewPresentor", ViewPresentor)

function TianmankingViewPresentor:ctor()
	TianmankingViewPresentor.super.ctor(self)
end

function TianmankingViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TianmankingViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/tianmanking/tianmankingview.prefab"
	}
end

function TianmankingViewPresentor:buildViews()
	return {
		TianmankingView.New()
	}
end

return TianmankingViewPresentor
