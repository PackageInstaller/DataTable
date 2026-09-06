-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/crossword/view/CrosswordmainViewPresentor.lua

module("logic.extensions.crossword.view.CrosswordmainViewPresentor", package.seeall)

local CrosswordmainViewPresentor = class("CrosswordmainViewPresentor", ViewPresentor)

function CrosswordmainViewPresentor:ctor()
	CrosswordmainViewPresentor.super.ctor(self)
end

function CrosswordmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CrosswordmainViewPresentor:dependWhatResources()
	return {
		"ui/views/crossword/crosswordmainview.prefab"
	}
end

function CrosswordmainViewPresentor:buildViews()
	return {
		CrosswordmainView.New()
	}
end

return CrosswordmainViewPresentor
