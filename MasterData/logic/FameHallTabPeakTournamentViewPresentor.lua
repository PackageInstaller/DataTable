-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/famehall/view/tab/FameHallTabPeakTournamentViewPresentor.lua

module("logic.extensions.famehall.view.tab.FameHallTabPeakTournamentViewPresentor", package.seeall)

local FameHallTabPeakTournamentViewPresentor = class("FameHallTabPeakTournamentViewPresentor", ViewPresentor)

function FameHallTabPeakTournamentViewPresentor:ctor()
	FameHallTabPeakTournamentViewPresentor.super.ctor(self)
end

function FameHallTabPeakTournamentViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FameHallTabPeakTournamentViewPresentor:dependWhatResources()
	return {
		"ui/views/famehall/famehalltabbaseview.prefab"
	}
end

function FameHallTabPeakTournamentViewPresentor:buildViews()
	return {
		FameHallTabPeakTournamentView.New()
	}
end

function FameHallTabPeakTournamentViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return FameHallTabPeakTournamentViewPresentor
