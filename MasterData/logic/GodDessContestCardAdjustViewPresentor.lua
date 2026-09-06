-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/view/card/GodDessContestCardAdjustViewPresentor.lua

module("logic.extensions.goddesscontest.view.card.GodDessContestCardAdustViewPresentor", package.seeall)

local GodDessContestCardAdustViewPresentor = class("GodDessContestCardAdustViewPresentor", ViewPresentor)

function GodDessContestCardAdustViewPresentor:ctor()
	GodDessContestCardAdustViewPresentor.super.ctor(self)
end

function GodDessContestCardAdustViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GodDessContestCardAdustViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscontest/card/goddesscontestcardadjustview.prefab"
	}
end

function GodDessContestCardAdustViewPresentor:buildViews()
	return {
		GodDessContestCardAdjustView.New()
	}
end

return GodDessContestCardAdustViewPresentor
