-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/threeelimination/view/ThreeEliminationRankViewPresentor.lua

module("logic.extensions.threeelimination.view.ThreeEliminationRankViewPresentor", package.seeall)

local ThreeEliminationRankViewPresentor = class("ThreeEliminationRankViewPresentor", ViewPresentor)

function ThreeEliminationRankViewPresentor:ctor()
	ThreeEliminationRankViewPresentor.super.ctor(self)
end

function ThreeEliminationRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ThreeEliminationRankViewPresentor:dependWhatResources()
	return {
		"ui/views/threeelimination/threeeliminationrankview.prefab"
	}
end

function ThreeEliminationRankViewPresentor:buildViews()
	return {
		ThreeEliminationRankView.New()
	}
end

return ThreeEliminationRankViewPresentor
