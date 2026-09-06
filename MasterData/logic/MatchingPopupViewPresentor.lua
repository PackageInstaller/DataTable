-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/MatchingPopupViewPresentor.lua

module("logic.extensions.numberbomb.view.MatchingPopupViewPresentor", package.seeall)

local MatchingPopupViewPresentor = class("MatchingPopupViewPresentor", ViewWithGuidePresentor)

function MatchingPopupViewPresentor:ctor()
	MatchingPopupViewPresentor.super.ctor(self)
end

function MatchingPopupViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MatchingPopupViewPresentor:dependWhatResources()
	return {
		"ui/views/numberbomb/numbermatchview.prefab"
	}
end

function MatchingPopupViewPresentor:buildViews()
	return {
		MatchingPopupView.New()
	}
end

return MatchingPopupViewPresentor
