-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/duolalight/view/LightGameCopyViewPresentor.lua

module("logic.extensions.duolalight.view.LightGameCopyViewPresentor", package.seeall)

local LightGameCopyViewPresentor = class("LightGameCopyViewPresentor", ViewPresentor)

function LightGameCopyViewPresentor:ctor()
	LightGameCopyViewPresentor.super.ctor(self)
end

function LightGameCopyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LightGameCopyViewPresentor:dependWhatResources()
	return {
		"ui/views/duolalight/lightgamecopyview.prefab"
	}
end

function LightGameCopyViewPresentor:buildViews()
	return {
		LightGameCopyView.New()
	}
end

return LightGameCopyViewPresentor
