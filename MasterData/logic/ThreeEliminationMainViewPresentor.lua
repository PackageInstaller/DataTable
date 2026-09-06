-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/threeelimination/view/ThreeEliminationMainViewPresentor.lua

module("logic.extensions.threeelimination.view.ThreeEliminationMainViewPresentor", package.seeall)

local ThreeEliminationMainViewPresentor = class("ThreeEliminationMainViewPresentor", ViewPresentor)

function ThreeEliminationMainViewPresentor:ctor()
	ThreeEliminationMainViewPresentor.super.ctor(self)
end

function ThreeEliminationMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ThreeEliminationMainViewPresentor:dependWhatResources()
	return {
		"ui/views/threeelimination/threeeliminationmainview.prefab"
	}
end

function ThreeEliminationMainViewPresentor:buildViews()
	return {
		ThreeEliminationMainView.New()
	}
end

return ThreeEliminationMainViewPresentor
