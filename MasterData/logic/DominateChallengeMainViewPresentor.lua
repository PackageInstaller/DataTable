-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingdragonchallenge/view/dominatechallenge/DominateChallengeMainViewPresentor.lua

module("logic.extensions.kingdragonchallenge.view.dominatechallenge.DominateChallengeMainViewPresentor", package.seeall)

local DominateChallengeMainViewPresentor = class("DominateChallengeMainViewPresentor", ViewPresentor)

function DominateChallengeMainViewPresentor:ctor()
	DominateChallengeMainViewPresentor.super.ctor(self)
end

function DominateChallengeMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DominateChallengeMainViewPresentor:dependWhatResources()
	return {
		"ui/views/dominatenuoyachallenge/dominatechallengemainview.prefab"
	}
end

function DominateChallengeMainViewPresentor:buildViews()
	return {
		DominateChallengeMainView.New()
	}
end

return DominateChallengeMainViewPresentor
