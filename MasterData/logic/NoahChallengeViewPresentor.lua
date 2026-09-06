-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/noahchallenge/view/NoahChallengeViewPresentor.lua

module("logic.extensions.noahchallenge.view.NoahChallengeViewPresentor", package.seeall)

local NoahChallengeViewPresentor = class("NoahChallengeViewPresentor", ViewPresentor)

function NoahChallengeViewPresentor:ctor()
	NoahChallengeViewPresentor.super.ctor(self)
end

function NoahChallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NoahChallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/noahchallenge/noahchallengeview.prefab"
	}
end

function NoahChallengeViewPresentor:buildViews()
	return {
		NoahChallengeView.New()
	}
end

return NoahChallengeViewPresentor
