-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/leila/LeilaDifficultyViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.leila.LeilaDifficultyViewPresentor", package.seeall)

local LeilaDifficultyViewPresentor = class("LeilaDifficultyViewPresentor", ViewPresentor)

function LeilaDifficultyViewPresentor:ctor()
	LeilaDifficultyViewPresentor.super.ctor(self)
end

function LeilaDifficultyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LeilaDifficultyViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/leila/leiladifficultyview.prefab"
	}
end

function LeilaDifficultyViewPresentor:buildViews()
	return {
		LeilaDifficultyView.New()
	}
end

return LeilaDifficultyViewPresentor
