-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lanternriddle/view/FindDifferenceGameViewPresentor.lua

module("logic.extensions.lanternriddle.view.FindDifferenceGameViewPresentor", package.seeall)

local FindDifferenceGameViewPresentor = class("FindDifferenceGameViewPresentor", ViewPresentor)

function FindDifferenceGameViewPresentor:ctor()
	FindDifferenceGameViewPresentor.super.ctor(self)
end

function FindDifferenceGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FindDifferenceGameViewPresentor:dependWhatResources()
	return {
		"ui/views/lanternriddle/differencegameview.prefab"
	}
end

function FindDifferenceGameViewPresentor:buildViews()
	return {
		FindDifferenceGameView.New()
	}
end

return FindDifferenceGameViewPresentor
