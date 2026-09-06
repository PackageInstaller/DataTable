-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/threeelimination/view/ThreeEliminationTaskViewPresentor.lua

module("logic.extensions.threeelimination.view.ThreeEliminationTaskViewPresentor", package.seeall)

local ThreeEliminationTaskViewPresentor = class("ThreeEliminationTaskViewPresentor", ViewPresentor)

function ThreeEliminationTaskViewPresentor:ctor()
	ThreeEliminationTaskViewPresentor.super.ctor(self)
end

function ThreeEliminationTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ThreeEliminationTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/threeelimination/threeeliminationtaskview.prefab"
	}
end

function ThreeEliminationTaskViewPresentor:buildViews()
	return {
		ThreeEliminationTaskView.New()
	}
end

return ThreeEliminationTaskViewPresentor
