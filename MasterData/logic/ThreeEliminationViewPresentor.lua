-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/threeelimination/view/ThreeEliminationViewPresentor.lua

module("logic.extensions.threeelimination.view.ThreeEliminationViewPresentor", package.seeall)

local ThreeEliminationViewPresentor = class("ThreeEliminationViewPresentor", ViewPresentor)

function ThreeEliminationViewPresentor:ctor()
	ThreeEliminationViewPresentor.super.ctor(self)
end

function ThreeEliminationViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ThreeEliminationViewPresentor:dependWhatResources()
	return {
		"ui/views/threeelimination/threeeliminationview.prefab"
	}
end

function ThreeEliminationViewPresentor:buildViews()
	return {
		ThreeEliminationView.New(),
		ThreeEliminationOtherView.New()
	}
end

return ThreeEliminationViewPresentor
