-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingdragonchallenge/view/dominatechallenge/DominateChallengeBossViewPresentor.lua

module("logic.extensions.kingdragonchallenge.view.dominatechallenge.DominateChallengeBossViewPresentor", package.seeall)

local DominateChallengeBossViewPresentor = class("DominateChallengeBossViewPresentor", ViewPresentor)

function DominateChallengeBossViewPresentor:ctor()
	DominateChallengeBossViewPresentor.super.ctor(self)
end

function DominateChallengeBossViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DominateChallengeBossViewPresentor:dependWhatResources()
	return {
		"ui/views/dominatenuoyachallenge/dominatechallengebossview.prefab"
	}
end

function DominateChallengeBossViewPresentor:buildViews()
	return {
		DominateChallengeBossView.New()
	}
end

return DominateChallengeBossViewPresentor
