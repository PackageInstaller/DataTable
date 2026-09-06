-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annualactivity/view/GratefulPuzzleViewPresentor.lua

module("logic.extensions.annualactivity.view.GratefulPuzzleViewPresentor", package.seeall)

local GratefulPuzzleViewPresentor = class("GratefulPuzzleViewPresentor", ViewPresentor)

function GratefulPuzzleViewPresentor:ctor()
	GratefulPuzzleViewPresentor.super.ctor(self)
end

function GratefulPuzzleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GratefulPuzzleViewPresentor:dependWhatResources()
	return {
		"ui/views/annualactivity/gratefulpuzzleview.prefab"
	}
end

function GratefulPuzzleViewPresentor:buildViews()
	return {
		GratefulPuzzleView.New()
	}
end

return GratefulPuzzleViewPresentor
