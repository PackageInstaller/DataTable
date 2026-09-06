-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpfloor/view/JumpFloorGameViewPresentor.lua

module("logic.extensions.jumpfloor.view.JumpFloorGameViewPresentor", package.seeall)

local JumpFloorGameViewPresentor = class("JumpFloorGameViewPresentor", ViewPresentor)

function JumpFloorGameViewPresentor:ctor()
	JumpFloorGameViewPresentor.super.ctor(self)
end

function JumpFloorGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function JumpFloorGameViewPresentor:dependWhatResources()
	return {
		"ui/views/jumpfloor/jumpfloorgameview.prefab"
	}
end

function JumpFloorGameViewPresentor:buildViews()
	return {
		JumpFloorGameView.New()
	}
end

return JumpFloorGameViewPresentor
