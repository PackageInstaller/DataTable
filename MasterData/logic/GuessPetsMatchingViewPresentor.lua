-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesspets/view/GuessPetsMatchingViewPresentor.lua

module("logic.extensions.guesspets.view.GuessPetsMatchingViewPresentor", package.seeall)

local GuessPetsMatchingViewPresentor = class("GuessPetsMatchingViewPresentor", ViewPresentor)

function GuessPetsMatchingViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GuessPetsMatchingViewPresentor:dependWhatResources()
	return {
		"ui/views/guesspets/guesspetsmatchview.prefab"
	}
end

function GuessPetsMatchingViewPresentor:buildViews()
	return {
		GuessPetsMatchingView.New()
	}
end

return GuessPetsMatchingViewPresentor
