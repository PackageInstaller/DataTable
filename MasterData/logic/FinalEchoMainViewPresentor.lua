-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/finalecho/view/FinalEchoMainViewPresentor.lua

module("logic.extensions.finalecho.view.FinalEchoMainViewPresentor", package.seeall)

local FinalEchoMainViewPresentor = class("FinalEchoMainViewPresentor", ViewPresentor)

function FinalEchoMainViewPresentor:ctor()
	FinalEchoMainViewPresentor.super.ctor(self)
end

function FinalEchoMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FinalEchoMainViewPresentor:dependWhatResources()
	return {
		"ui/views/finalecho/finalechomainview.prefab"
	}
end

function FinalEchoMainViewPresentor:buildViews()
	return {
		FinalEchoMainView.New()
	}
end

return FinalEchoMainViewPresentor
