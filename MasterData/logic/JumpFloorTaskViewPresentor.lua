-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpfloor/view/JumpFloorTaskViewPresentor.lua

module("logic.extensions.jumpfloor.view.JumpFloorTaskViewPresentor", package.seeall)

local JumpFloorTaskViewPresentor = class("JumpFloorTaskViewPresentor", ViewPresentor)

function JumpFloorTaskViewPresentor:ctor()
	JumpFloorTaskViewPresentor.super.ctor(self)
end

function JumpFloorTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function JumpFloorTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/jumpfloor/jumpfloortaskview.prefab"
	}
end

function JumpFloorTaskViewPresentor:buildViews()
	return {
		JumpFloorTaskView.New()
	}
end

return JumpFloorTaskViewPresentor
