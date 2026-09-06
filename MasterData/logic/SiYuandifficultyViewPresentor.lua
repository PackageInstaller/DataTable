-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/shikongshenglong/SiYuandifficultyViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.shikongshenglong.SiYuandifficultyViewPresentor", package.seeall)

local SiYuandifficultyViewPresentor = class("SiYuandifficultyViewPresentor", ViewPresentor)

SiYuandifficultyViewPresentor.chapterChallengeBg = {
	"board_siyuan_05",
	"board_siyuan_06",
	"board_siyuan_02"
}

function SiYuandifficultyViewPresentor:ctor()
	SiYuandifficultyViewPresentor.super.ctor(self)
end

function SiYuandifficultyViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SiYuandifficultyViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/shikongshenglong/siyuandifficultyview.prefab"
	}
end

function SiYuandifficultyViewPresentor:buildViews()
	return {
		SiYuandifficultyView.New()
	}
end

return SiYuandifficultyViewPresentor
