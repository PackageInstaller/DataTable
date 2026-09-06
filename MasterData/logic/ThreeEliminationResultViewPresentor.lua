-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/threeelimination/view/ThreeEliminationResultViewPresentor.lua

module("logic.extensions.threeelimination.view.ThreeEliminationResultViewPresentor", package.seeall)

local ThreeEliminationResultViewPresentor = class("ThreeEliminationResultViewPresentor", ViewPresentor)

function ThreeEliminationResultViewPresentor:ctor()
	ThreeEliminationResultViewPresentor.super.ctor(self)
end

function ThreeEliminationResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ThreeEliminationResultViewPresentor:dependWhatResources()
	return {
		"ui/views/threeelimination/threeeliminationresultview.prefab"
	}
end

function ThreeEliminationResultViewPresentor:buildViews()
	return {
		ThreeEliminationResultView.New()
	}
end

return ThreeEliminationResultViewPresentor
