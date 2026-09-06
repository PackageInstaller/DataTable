-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/threeelimination/view/ThreeEliminationBattleViewPresentor.lua

module("logic.extensions.threeelimination.view.ThreeEliminationBattleViewPresentor", package.seeall)

local ThreeEliminationBattleViewPresentor = class("ThreeEliminationBattleViewPresentor", ViewPresentor)

function ThreeEliminationBattleViewPresentor:ctor()
	ThreeEliminationBattleViewPresentor.super.ctor(self)
end

function ThreeEliminationBattleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ThreeEliminationBattleViewPresentor:dependWhatResources()
	return {
		"ui/views/threeelimination/threeeliminationbattleview.prefab"
	}
end

function ThreeEliminationBattleViewPresentor:buildViews()
	return {
		ThreeEliminationBattleView.New()
	}
end

return ThreeEliminationBattleViewPresentor
