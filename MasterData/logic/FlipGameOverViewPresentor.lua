-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteam/view/FlipGameOverViewPresentor.lua

module("logic.extensions.dreamteam.view.FlipGameOverViewPresentor", package.seeall)

local FlipGameOverViewPresentor = class("FlipGameOverViewPresentor", ViewPresentor)

function FlipGameOverViewPresentor:ctor()
	FlipGameOverViewPresentor.super.ctor(self)
end

function FlipGameOverViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FlipGameOverViewPresentor:dependWhatResources()
	return {
		"ui/views/dreamteam/smallgame/flipgameoverview.prefab"
	}
end

function FlipGameOverViewPresentor:buildViews()
	return {
		FlipGameOverView.New()
	}
end

return FlipGameOverViewPresentor
