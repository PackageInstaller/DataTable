-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/view/card/GodDessContestCardArenaViewPresentor.lua

module("logic.extensions.goddesscontest.view.card.GodDessContestCardArenaViewPresentor", package.seeall)

local GodDessContestCardArenaViewPresentor = class("GodDessContestCardArenaViewPresentor", ViewPresentor)

function GodDessContestCardArenaViewPresentor:ctor()
	GodDessContestCardArenaViewPresentor.super.ctor(self)
end

function GodDessContestCardArenaViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GodDessContestCardArenaViewPresentor:dependWhatResources()
	return {
		"ui/views/goddesscontest/card/goddesscontestcardarenaview.prefab"
	}
end

function GodDessContestCardArenaViewPresentor:buildViews()
	return {
		GodDessContestCardArenaView.New()
	}
end

return GodDessContestCardArenaViewPresentor
