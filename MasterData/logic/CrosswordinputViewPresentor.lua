-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/crossword/view/CrosswordinputViewPresentor.lua

module("logic.extensions.crossword.view.CrosswordinputViewPresentor", package.seeall)

local CrosswordinputViewPresentor = class("CrosswordinputViewPresentor", ViewPresentor)

function CrosswordinputViewPresentor:ctor()
	CrosswordinputViewPresentor.super.ctor(self)
end

function CrosswordinputViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CrosswordinputViewPresentor:dependWhatResources()
	return {
		"ui/views/crossword/crosswordinputview.prefab"
	}
end

function CrosswordinputViewPresentor:buildViews()
	return {
		CrosswordinputView.New()
	}
end

return CrosswordinputViewPresentor
