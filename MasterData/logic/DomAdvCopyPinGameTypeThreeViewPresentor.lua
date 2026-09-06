-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pingame/domadvcopy/DomAdvCopyPinGameTypeThreeViewPresentor.lua

module("logic.extensions.pingame.domadvcopy.PinGameTypeThreeViewPresentor", package.seeall)

local PinGameTypeThreeViewPresentor = class("PinGameTypeThreeViewPresentor", ViewPresentor)

function PinGameTypeThreeViewPresentor:ctor()
	PinGameTypeThreeViewPresentor.super.ctor(self)
end

function PinGameTypeThreeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PinGameTypeThreeViewPresentor:dependWhatResources()
	return {
		"ui/views/pingame/domadvcopy/domadvcopypingametypethreeview.prefab"
	}
end

function PinGameTypeThreeViewPresentor:buildViews()
	return {
		DomAdvCopyPinGameTypeThreeView.New()
	}
end

return PinGameTypeThreeViewPresentor
