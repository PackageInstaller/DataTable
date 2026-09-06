-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/threeelimination/view/ThreeEliminationLevelViewPresentor.lua

module("logic.extensions.threeelimination.view.ThreeEliminationLevelViewPresentor", package.seeall)

local ThreeEliminationLevelViewPresentor = class("ThreeEliminationLevelViewPresentor", ViewPresentor)

function ThreeEliminationLevelViewPresentor:ctor()
	ThreeEliminationLevelViewPresentor.super.ctor(self)
end

function ThreeEliminationLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ThreeEliminationLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/threeelimination/threeeliminationlevelview.prefab"
	}
end

function ThreeEliminationLevelViewPresentor:buildViews()
	return {
		ThreeEliminationLevelView.New()
	}
end

return ThreeEliminationLevelViewPresentor
