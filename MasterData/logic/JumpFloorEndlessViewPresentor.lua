-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpfloor/view/JumpFloorEndlessViewPresentor.lua

module("logic.extensions.jumpfloor.view.JumpFloorEndlessViewPresentor", package.seeall)

local JumpFloorEndlessViewPresentor = class("JumpFloorEndlessViewPresentor", ViewPresentor)

function JumpFloorEndlessViewPresentor:ctor()
	JumpFloorEndlessViewPresentor.super.ctor(self)
end

function JumpFloorEndlessViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function JumpFloorEndlessViewPresentor:dependWhatResources()
	return {
		"ui/views/jumpfloor/jumpfloorendlessview.prefab"
	}
end

function JumpFloorEndlessViewPresentor:buildViews()
	return {
		JumpFloorEndlessView.New()
	}
end

return JumpFloorEndlessViewPresentor
