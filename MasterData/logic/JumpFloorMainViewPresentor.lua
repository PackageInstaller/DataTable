-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpfloor/view/JumpFloorMainViewPresentor.lua

module("logic.extensions.jumpfloor.view.JumpFloorMainViewPresentor", package.seeall)

local JumpFloorMainViewPresentor = class("JumpFloorMainViewPresentor", ViewPresentor)

function JumpFloorMainViewPresentor:ctor()
	JumpFloorMainViewPresentor.super.ctor(self)
end

function JumpFloorMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function JumpFloorMainViewPresentor:dependWhatResources()
	return {
		"ui/views/jumpfloor/jumpfloormainview.prefab"
	}
end

function JumpFloorMainViewPresentor:buildViews()
	return {
		JumpFloorMainView.New()
	}
end

return JumpFloorMainViewPresentor
