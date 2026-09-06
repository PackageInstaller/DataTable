-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pingame/domadvcopy/DomAdvCopyPinGamePlayViewPresentor.lua

module("logic.extensions.pingame.domadvcopy.DomAdvCopyPinGamePlayViewPresentor", package.seeall)

local DomAdvCopyPinGamePlayViewPresentor = class("DomAdvCopyPinGamePlayViewPresentor", ViewPresentor)

function DomAdvCopyPinGamePlayViewPresentor:ctor()
	DomAdvCopyPinGamePlayViewPresentor.super.ctor(self)
end

function DomAdvCopyPinGamePlayViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DomAdvCopyPinGamePlayViewPresentor:dependWhatResources()
	return {
		"ui/views/pingame/domadvcopy/domadvcopypingameplayview.prefab"
	}
end

function DomAdvCopyPinGamePlayViewPresentor:buildViews()
	return {
		DomAdvCopyPinGamePlayView.New()
	}
end

return DomAdvCopyPinGamePlayViewPresentor
