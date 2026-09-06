-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/shikongshenglong/SksldifficultyViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.shikongshenglong.SksldifficultyViewPresentor", package.seeall)

local SksldifficultyViewPresentor = class("SksldifficultyViewPresentor", ViewPresentor)

SksldifficultyViewPresentor.chapterChallengeBg = {
	"board_sksl_10",
	"board_sksl_09",
	"board_sksl_11"
}

function SksldifficultyViewPresentor:ctor()
	SksldifficultyViewPresentor.super.ctor(self)
end

function SksldifficultyViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SksldifficultyViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/shikongshenglong/sksldifficultyview.prefab"
	}
end

function SksldifficultyViewPresentor:buildViews()
	return {
		SksldifficultyView.New()
	}
end

return SksldifficultyViewPresentor
