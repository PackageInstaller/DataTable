-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/diyimingplus/DiYiMingPlusGameViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.diyimingplus.DiYiMingPlusGameViewPresentor", package.seeall)

local DiYiMingPlusGameViewPresentor = class("DiYiMingPlusGameViewPresentor", ViewPresentor)

function DiYiMingPlusGameViewPresentor:ctor()
	DiYiMingPlusGameViewPresentor.super.ctor(self)
end

function DiYiMingPlusGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DiYiMingPlusGameViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/diyimingplus/diyimingplusgameview.prefab"
	}
end

function DiYiMingPlusGameViewPresentor:buildViews()
	return {
		DiYiMingPlusGameView.New()
	}
end

return DiYiMingPlusGameViewPresentor
