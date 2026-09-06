-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingdragonchallenge/view/dominatechallenge/DominateChallengeStageViewPresentor.lua

module("logic.extensions.kingdragonchallenge.view.dominatechallenge.DominateChallengeStageViewPresentor", package.seeall)

local DominateChallengeStageViewPresentor = class("DominateChallengeStageViewPresentor", ViewPresentor)

function DominateChallengeStageViewPresentor:ctor()
	DominateChallengeStageViewPresentor.super.ctor(self)
end

function DominateChallengeStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DominateChallengeStageViewPresentor:dependWhatResources()
	return {
		"ui/views/dominatenuoyachallenge/dominatechallengestageview.prefab"
	}
end

function DominateChallengeStageViewPresentor:buildViews()
	return {
		DominateChallengeStageView.New()
	}
end

return DominateChallengeStageViewPresentor
