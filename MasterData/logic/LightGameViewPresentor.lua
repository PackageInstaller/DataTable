-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/duolalight/view/LightGameViewPresentor.lua

module("logic.extensions.duolalight.view.LightGameViewPresentor", package.seeall)

local LightGameViewPresentor = class("LightGameViewPresentor", ViewPresentor)

function LightGameViewPresentor:ctor()
	LightGameViewPresentor.super.ctor(self)
end

function LightGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LightGameViewPresentor:dependWhatResources()
	return {
		"ui/views/duolalight/lightgameview.prefab"
	}
end

function LightGameViewPresentor:buildViews()
	return {
		LightGameView.New()
	}
end

return LightGameViewPresentor
