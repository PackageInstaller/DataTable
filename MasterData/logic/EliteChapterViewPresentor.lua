-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotcopy/view/EliteChapterViewPresentor.lua

module("logic.extensions.plotcopy.view.EliteChapterViewPresentor", package.seeall)

local EliteChapterViewPresentor = class("EliteChapterViewPresentor", ViewWithGuidePresentor)

function EliteChapterViewPresentor:ctor()
	EliteChapterViewPresentor.super.ctor(self)
end

function EliteChapterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EliteChapterViewPresentor:dependWhatResources()
	return {
		"ui/views/plotcopy/chapterview.prefab",
		"ui/views/plotcopy/chapterreward.prefab"
	}
end

function EliteChapterViewPresentor:getTempResources()
	return {
		"ui/bigbg/copychapter/fuben_bg01.png",
		UIEffectManager.instance:getEffectPath("fx_ui_juqingfuben/fx_ui_juqingfuben01.prefab")
	}
end

function EliteChapterViewPresentor:buildViews()
	return {
		EliteChapterView.New(),
		ChapterRewardView.New()
	}
end

return EliteChapterViewPresentor
