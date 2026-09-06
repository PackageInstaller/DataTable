-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpfloor/view/JumpFloorRankViewPresentor.lua

module("logic.extensions.jumpfloor.view.JumpFloorRankViewPresentor", package.seeall)

local JumpFloorRankViewPresentor = class("JumpFloorRankViewPresentor", ViewPresentor)

function JumpFloorRankViewPresentor:ctor()
	JumpFloorRankViewPresentor.super.ctor(self)
end

function JumpFloorRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function JumpFloorRankViewPresentor:dependWhatResources()
	return {
		"ui/views/jumpfloor/jumpfloorrankview.prefab"
	}
end

function JumpFloorRankViewPresentor:buildViews()
	return {
		JumpFloorRankView.New()
	}
end

return JumpFloorRankViewPresentor
