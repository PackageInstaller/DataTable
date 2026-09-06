-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/threeelimination/view/ThreeEliminationBufflViewPresentor.lua

module("logic.extensions.threeelimination.view.ThreeEliminationBufflViewPresentor", package.seeall)

local ThreeEliminationBufflViewPresentor = class("ThreeEliminationBufflViewPresentor", ViewPresentor)

function ThreeEliminationBufflViewPresentor:ctor()
	ThreeEliminationBufflViewPresentor.super.ctor(self)
end

function ThreeEliminationBufflViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ThreeEliminationBufflViewPresentor:dependWhatResources()
	return {
		"ui/views/threeelimination/threeeliminationbufflview.prefab"
	}
end

function ThreeEliminationBufflViewPresentor:buildViews()
	return {
		ThreeEliminationBufflView.New()
	}
end

return ThreeEliminationBufflViewPresentor
