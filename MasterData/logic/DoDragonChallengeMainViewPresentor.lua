-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dodragonchallenge/view/DoDragonChallengeMainViewPresentor.lua

module("logic.extensions.dodragonchallenge.view.DoDragonChallengeMainViewPresentor", package.seeall)

local DoDragonChallengeMainViewPresentor = class("DoDragonChallengeMainViewPresentor", ViewPresentor)

function DoDragonChallengeMainViewPresentor:ctor()
	DoDragonChallengeMainViewPresentor.super.ctor(self)
end

function DoDragonChallengeMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DoDragonChallengeMainViewPresentor:dependWhatResources()
	return {
		"ui/views/dodragonchallenge/dodragonchallengemainview.prefab"
	}
end

function DoDragonChallengeMainViewPresentor:buildViews()
	return {
		DoDragonChallengeMainView.New()
	}
end

return DoDragonChallengeMainViewPresentor
