-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pingame/view/PinGameMainViewPresentor.lua

module("logic.extensions.pingame.view.PinGameMainViewPresentor", package.seeall)

local PinGameMainViewPresentor = class("PinGameMainViewPresentor", ViewPresentor)

function PinGameMainViewPresentor:ctor()
	PinGameMainViewPresentor.super.ctor(self)
end

function PinGameMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PinGameMainViewPresentor:dependWhatResources()
	return {
		"ui/views/pingame/pingamemainview.prefab"
	}
end

function PinGameMainViewPresentor:buildViews()
	return {
		PinGameMainView.New()
	}
end

return PinGameMainViewPresentor
