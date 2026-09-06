-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingdragonchallenge/view/dominatechallenge/DominateChallengeUnitpopViewPresentor.lua

module("logic.extensions.kingdragonchallenge.view.dominatechallenge.DominateChallengeUnitpopViewPresentor", package.seeall)

local DominateChallengeUnitpopViewPresentor = class("DominateChallengeUnitpopViewPresentor", ViewPresentor)

function DominateChallengeUnitpopViewPresentor:ctor()
	DominateChallengeUnitpopViewPresentor.super.ctor(self)
end

function DominateChallengeUnitpopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DominateChallengeUnitpopViewPresentor:dependWhatResources()
	return {
		"ui/views/dominatenuoyachallenge/dominatechallengeunitpopview.prefab"
	}
end

function DominateChallengeUnitpopViewPresentor:buildViews()
	return {
		DominateChallengeUnitpopView.New()
	}
end

return DominateChallengeUnitpopViewPresentor
