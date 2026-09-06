-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/view/card/GodDessContestCardMainViewPresentor.lua

module("logic.extensions.goddesscontest.view.card.GodDessContestCardMainViewPresentor", package.seeall)

local GodDessContestCardMainViewPresentor = class("GodDessContestCardMainViewPresentor", ViewPresentor)

function GodDessContestCardMainViewPresentor:ctor()
	GodDessContestCardMainViewPresentor.super.ctor(self)
end

function GodDessContestCardMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GodDessContestCardMainViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscontest/card/goddesscontestcardmainview.prefab"
	}
end

function GodDessContestCardMainViewPresentor:buildViews()
	return {
		GodDessContestCardMainView.New()
	}
end

return GodDessContestCardMainViewPresentor
