-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingdragonchallenge/view/dominatechallenge/DominateChallengeUnitViewPresentor.lua

module("logic.extensions.kingdragonchallenge.view.dominatechallenge.DominateChallengeUnitViewPresentor", package.seeall)

local DominateChallengeUnitViewPresentor = class("DominateChallengeUnitViewPresentor", ViewPresentor)

function DominateChallengeUnitViewPresentor:ctor()
	DominateChallengeUnitViewPresentor.super.ctor(self)
end

function DominateChallengeUnitViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DominateChallengeUnitViewPresentor:dependWhatResources()
	return {
		"ui/views/dominatenuoyachallenge/dominatechallengeunitview.prefab"
	}
end

function DominateChallengeUnitViewPresentor:buildViews()
	return {
		DominateChallengeUnitView.New()
	}
end

return DominateChallengeUnitViewPresentor
