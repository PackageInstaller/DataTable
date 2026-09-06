-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dodragonchallenge/view/DoDragonChallengeUnitViewPresentor.lua

module("logic.extensions.dodragonchallenge.view.DoDragonChallengeUnitViewPresentor", package.seeall)

local DoDragonChallengeUnitViewPresentor = class("DoDragonChallengeUnitViewPresentor", ViewPresentor)

function DoDragonChallengeUnitViewPresentor:ctor()
	DoDragonChallengeUnitViewPresentor.super.ctor(self)
end

function DoDragonChallengeUnitViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DoDragonChallengeUnitViewPresentor:dependWhatResources()
	return {
		"ui/views/dodragonchallenge/dodragonchallengeunitview.prefab"
	}
end

function DoDragonChallengeUnitViewPresentor:buildViews()
	return {
		DoDragonChallengeUnitView.New()
	}
end

return DoDragonChallengeUnitViewPresentor
