-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dodragonchallenge/view/DoDragonChallengeBossViewPresentor.lua

module("logic.extensions.dodragonchallenge.view.DoDragonChallengeBossViewPresentor", package.seeall)

local DoDragonChallengeBossViewPresentor = class("DoDragonChallengeBossViewPresentor", ViewPresentor)

function DoDragonChallengeBossViewPresentor:ctor()
	DoDragonChallengeBossViewPresentor.super.ctor(self)
end

function DoDragonChallengeBossViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DoDragonChallengeBossViewPresentor:dependWhatResources()
	return {
		"ui/views/dodragonchallenge/dodragonchallengebossview.prefab"
	}
end

function DoDragonChallengeBossViewPresentor:buildViews()
	return {
		DoDragonChallengeBossView.New()
	}
end

return DoDragonChallengeBossViewPresentor
