-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonlords/view/DragonBallViewPresentor.lua

module("logic.extensions.dragonlords.view.DragonBallViewPresentor", package.seeall)

local DragonBallViewPresentor = class("DragonBallViewPresentor", ViewPresentor)

function DragonBallViewPresentor:ctor()
	DragonBallViewPresentor.super.ctor(self)
end

function DragonBallViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonBallViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/dragonlords/dragonballview.prefab"
	}
end

function DragonBallViewPresentor:buildViews()
	return {
		DragonBallView.New()
	}
end

return DragonBallViewPresentor
