-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/justice/view/JusticedifficultyViewPresentor.lua

module("logic.extensions.justice.view.JusticedifficultyViewPresentor", package.seeall)

local JusticedifficultyViewPresentor = class("JusticedifficultyViewPresentor", ViewPresentor)

function JusticedifficultyViewPresentor:ctor()
	JusticedifficultyViewPresentor.super.ctor(self)
end

function JusticedifficultyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function JusticedifficultyViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/justice/justicedifficultyview.prefab"
	}
end

function JusticedifficultyViewPresentor:buildViews()
	return {
		JusticedifficultyView.New()
	}
end

return JusticedifficultyViewPresentor
