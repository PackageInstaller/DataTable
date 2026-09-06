-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pingame/view/PinGameTypeOneViewPresentor.lua

module("logic.extensions.pingame.view.PinGameTypeOneViewPresentor", package.seeall)

local PinGameTypeOneViewPresentor = class("PinGameTypeOneViewPresentor", ViewPresentor)

function PinGameTypeOneViewPresentor:ctor()
	PinGameTypeOneViewPresentor.super.ctor(self)
end

function PinGameTypeOneViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PinGameTypeOneViewPresentor:dependWhatResources()
	return {
		"ui/views/pingame/pingametypeoneview.prefab"
	}
end

function PinGameTypeOneViewPresentor:buildViews()
	return {
		PinGameTypeOneView.New()
	}
end

return PinGameTypeOneViewPresentor
