-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/noahchallenge/view/nuoya/NuoyaShenqiChallengeViewPresentor.lua

module("logic.extensions.noahchallenge.view.nuoya.NuoyaShenqiChallengeViewPresentor", package.seeall)

local NuoyaShenqiChallengeViewPresentor = class("NuoyaShenqiChallengeViewPresentor", ViewPresentor)

function NuoyaShenqiChallengeViewPresentor:ctor()
	NuoyaShenqiChallengeViewPresentor.super.ctor(self)
end

function NuoyaShenqiChallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NuoyaShenqiChallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/shenqi/nuoya/nuoyashenqichallengeview.prefab"
	}
end

function NuoyaShenqiChallengeViewPresentor:buildViews()
	return {
		NuoyaShenqiChallengeView.New()
	}
end

return NuoyaShenqiChallengeViewPresentor
