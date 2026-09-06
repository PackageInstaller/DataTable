-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pingame/domadvcopy/DomAdvCopyPinGamePlayResultViewPresentor.lua

module("logic.extensions.pingame.domadvcopy.DomAdvCopyPinGamePlayResultViewPresentor", package.seeall)

local DomAdvCopyPinGamePlayResultViewPresentor = class("DomAdvCopyPinGamePlayResultViewPresentor", ViewPresentor)

function DomAdvCopyPinGamePlayResultViewPresentor:ctor()
	DomAdvCopyPinGamePlayResultViewPresentor.super.ctor(self)
end

function DomAdvCopyPinGamePlayResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DomAdvCopyPinGamePlayResultViewPresentor:dependWhatResources()
	return {
		"ui/views/pingame/domadvcopy/domadvcopypingameplayresultview.prefab"
	}
end

function DomAdvCopyPinGamePlayResultViewPresentor:buildViews()
	return {
		DomAdvCopyPinGamePlayResultView.New()
	}
end

return DomAdvCopyPinGamePlayResultViewPresentor
