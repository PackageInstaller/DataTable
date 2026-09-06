-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotcopy/view/ChapterRewardGetViewPresentor.lua

module("logic.extensions.plotcopy.view.ChapterRewardGetViewPresentor", package.seeall)

local ChapterRewardGetViewPresentor = class("ChapterRewardGetViewPresentor", ViewPresentor)

function ChapterRewardGetViewPresentor:ctor()
	ChapterRewardGetViewPresentor.super.ctor(self)
end

function ChapterRewardGetViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ChapterRewardGetViewPresentor:dependWhatResources()
	return {
		"ui/views/plotcopy/chapterrewardget.prefab"
	}
end

function ChapterRewardGetViewPresentor:buildViews()
	return {
		ChapterRewardGetView.New()
	}
end

return ChapterRewardGetViewPresentor
