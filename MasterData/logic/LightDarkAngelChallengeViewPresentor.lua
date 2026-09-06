-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teshamu/view/LightDarkAngelChallengeViewPresentor.lua

module("logic.extensions.teshamu.view.LightDarkAngelChallengeViewPresentor", package.seeall)

local LightDarkAngelChallengeViewPresentor = class("LightDarkAngelChallengeViewPresentor", ViewPresentor)

function LightDarkAngelChallengeViewPresentor:ctor()
	LightDarkAngelChallengeViewPresentor.super.ctor(self)
end

function LightDarkAngelChallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LightDarkAngelChallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/lightdarkangel/lightdarkangelchallengeview.prefab"
	}
end

function LightDarkAngelChallengeViewPresentor:buildViews()
	return {
		LightDarkAngelChallengeView.New()
	}
end

return LightDarkAngelChallengeViewPresentor
