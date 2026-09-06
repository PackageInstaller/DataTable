-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreampainter/view/DreampaintermainViewPresentor.lua

module("logic.extensions.dreampainter.view.DreampaintermainViewPresentor", package.seeall)

local DreampaintermainViewPresentor = class("DreampaintermainViewPresentor", ViewPresentor)

function DreampaintermainViewPresentor:ctor()
	DreampaintermainViewPresentor.super.ctor(self)
end

function DreampaintermainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DreampaintermainViewPresentor:dependWhatResources()
	return {
		"ui/views/dreampainter/dreampaintermainview.prefab"
	}
end

function DreampaintermainViewPresentor:buildViews()
	return {
		DreampaintermainView.New()
	}
end

return DreampaintermainViewPresentor
