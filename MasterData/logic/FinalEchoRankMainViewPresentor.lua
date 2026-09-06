-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/finalecho/view/FinalEchoRankMainViewPresentor.lua

module("logic.extensions.finalecho.view.FinalEchoRankMainViewPresentor", package.seeall)

local FinalEchoRankMainViewPresentor = class("FinalEchoRankMainViewPresentor", ViewPresentor)

function FinalEchoRankMainViewPresentor:ctor()
	FinalEchoRankMainViewPresentor.super.ctor(self)
end

function FinalEchoRankMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FinalEchoRankMainViewPresentor:dependWhatResources()
	return {
		"ui/views/finalecho/finalechorankmainview.prefab"
	}
end

function FinalEchoRankMainViewPresentor:buildViews()
	return {
		FinalEchoRankMainView.New()
	}
end

return FinalEchoRankMainViewPresentor
