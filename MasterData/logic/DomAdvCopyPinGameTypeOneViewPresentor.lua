-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pingame/domadvcopy/DomAdvCopyPinGameTypeOneViewPresentor.lua

module("logic.extensions.pingame.domadvcopy.DomAdvCopyPinGameTypeOneViewPresentor", package.seeall)

local DomAdvCopyPinGameTypeOneViewPresentor = class("DomAdvCopyPinGameTypeOneViewPresentor", ViewPresentor)

function DomAdvCopyPinGameTypeOneViewPresentor:ctor()
	DomAdvCopyPinGameTypeOneViewPresentor.super.ctor(self)
end

function DomAdvCopyPinGameTypeOneViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DomAdvCopyPinGameTypeOneViewPresentor:dependWhatResources()
	return {
		"ui/views/pingame/domadvcopy/domadvcopypingametypeoneview.prefab"
	}
end

function DomAdvCopyPinGameTypeOneViewPresentor:buildViews()
	return {
		DomAdvCopyPinGameTypeOneView.New()
	}
end

return DomAdvCopyPinGameTypeOneViewPresentor
