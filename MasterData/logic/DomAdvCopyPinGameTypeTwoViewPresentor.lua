-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pingame/domadvcopy/DomAdvCopyPinGameTypeTwoViewPresentor.lua

module("logic.extensions.pingame.domadvcopy.PinGameTypeTwoViewPresentor", package.seeall)

local PinGameTypeTwoViewPresentor = class("PinGameTypeTwoViewPresentor", ViewPresentor)

function PinGameTypeTwoViewPresentor:ctor()
	PinGameTypeTwoViewPresentor.super.ctor(self)
end

function PinGameTypeTwoViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PinGameTypeTwoViewPresentor:dependWhatResources()
	return {
		"ui/views/pingame/domadvcopy/domadvcopypingametypetwoview.prefab"
	}
end

function PinGameTypeTwoViewPresentor:buildViews()
	return {
		DomAdvCopyPinGameTypeTwoView.New()
	}
end

return PinGameTypeTwoViewPresentor
