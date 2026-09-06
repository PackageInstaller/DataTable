-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpfloor/view/JumpFloorLevelViewPresentor.lua

module("logic.extensions.jumpfloor.view.JumpFloorLevelViewPresentor", package.seeall)

local JumpFloorLevelViewPresentor = class("JumpFloorLevelViewPresentor", ViewPresentor)

function JumpFloorLevelViewPresentor:ctor()
	JumpFloorLevelViewPresentor.super.ctor(self)
end

function JumpFloorLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function JumpFloorLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/jumpfloor/jumpfloorlevelview.prefab"
	}
end

function JumpFloorLevelViewPresentor:buildViews()
	return {
		JumpFloorLevelView.New()
	}
end

return JumpFloorLevelViewPresentor
