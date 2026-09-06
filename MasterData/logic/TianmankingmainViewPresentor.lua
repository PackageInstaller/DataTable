-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/tianmanking/TianmankingmainViewPresentor.lua

module("logic.extensions.tianmanking.view.TianmankingmainViewPresentor", package.seeall)

local TianmankingmainViewPresentor = class("TianmankingmainViewPresentor", ViewPresentor)

function TianmankingmainViewPresentor:ctor()
	TianmankingmainViewPresentor.super.ctor(self)
end

function TianmankingmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TianmankingmainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/tianmanking/tianmankingmainview.prefab"
	}
end

function TianmankingmainViewPresentor:buildViews()
	return {
		TianmankingmainView.New()
	}
end

return TianmankingmainViewPresentor
