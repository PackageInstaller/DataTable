-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/threeelimination/view/ThreeEliminationTaskChildViewPresentor.lua

module("logic.extensions.threeelimination.view.ThreeEliminationTaskChildViewPresentor", package.seeall)

local ThreeEliminationTaskChildViewPresentor = class("ThreeEliminationTaskChildViewPresentor", ViewPresentor)

function ThreeEliminationTaskChildViewPresentor:ctor()
	ThreeEliminationTaskChildViewPresentor.super.ctor(self)
end

function ThreeEliminationTaskChildViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ThreeEliminationTaskChildViewPresentor:dependWhatResources()
	return {
		"ui/views/threeelimination/threeeliminationtaskchildview.prefab"
	}
end

function ThreeEliminationTaskChildViewPresentor:buildViews()
	return {
		ThreeEliminationTaskChildView.New()
	}
end

return ThreeEliminationTaskChildViewPresentor
