-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/famehall/view/tab/FameHallTabRankRaceViewPresentor.lua

module("logic.extensions.famehall.view.tab.FameHallTabRankRaceViewPresentor", package.seeall)

local FameHallTabRankRaceViewPresentor = class("FameHallTabRankRaceViewPresentor", ViewPresentor)

function FameHallTabRankRaceViewPresentor:ctor()
	FameHallTabRankRaceViewPresentor.super.ctor(self)
end

function FameHallTabRankRaceViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FameHallTabRankRaceViewPresentor:dependWhatResources()
	return {
		"ui/views/famehall/famehalltabbaseview.prefab"
	}
end

function FameHallTabRankRaceViewPresentor:buildViews()
	return {
		FameHallTabRankRaceView.New()
	}
end

function FameHallTabRankRaceViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return FameHallTabRankRaceViewPresentor
