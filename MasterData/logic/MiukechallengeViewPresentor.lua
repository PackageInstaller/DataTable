-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miukechallenge/view/MiukechallengeViewPresentor.lua

module("logic.extensions.miukechallenge.view.MiukechallengeViewPresentor", package.seeall)

local MiukechallengeViewPresentor = class("MiukechallengeViewPresentor", ViewPresentor)

function MiukechallengeViewPresentor:ctor()
	MiukechallengeViewPresentor.super.ctor(self)
end

function MiukechallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiukechallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/miukechallenge/miukechallengeview.prefab"
	}
end

function MiukechallengeViewPresentor:buildViews()
	return {
		MiukechallengeView.New()
	}
end

return MiukechallengeViewPresentor
