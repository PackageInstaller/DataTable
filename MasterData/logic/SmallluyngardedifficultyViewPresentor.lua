-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/shikongshenglong/SmallluyngardedifficultyViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.shikongshenglong.SmallluyngardedifficultyViewPresentor", package.seeall)

local SmallluyngardedifficultyViewPresentor = class("SmallluyngardedifficultyViewPresentor", ViewPresentor)

SmallluyngardedifficultyViewPresentor.chapterChallengeBg = {
	"board_xiaoluyinjiade_02",
	"board_xiaoluyinjiade_03",
	"board_xiaoluyinjiade_04"
}

function SmallluyngardedifficultyViewPresentor:ctor()
	SmallluyngardedifficultyViewPresentor.super.ctor(self)
end

function SmallluyngardedifficultyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SmallluyngardedifficultyViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/shikongshenglong/smallluyngardedifficultyview.prefab"
	}
end

function SmallluyngardedifficultyViewPresentor:buildViews()
	return {
		SmallluyngardedifficultyView.New()
	}
end

return SmallluyngardedifficultyViewPresentor
