-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stknexp/view/StKnExpMainViewPresentor.lua

module("logic.extensions.stknexp.view.StKnExpMainViewPresentor", package.seeall)

local StKnExpMainViewPresentor = class("StKnExpMainViewPresentor", ViewPresentor)

function StKnExpMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StKnExpMainViewPresentor:dependWhatResources()
	return {
		"ui/views/stknexp/stknexpmainview.prefab"
	}
end

function StKnExpMainViewPresentor:buildViews()
	return {
		StKnExpMainView.New()
	}
end

return StKnExpMainViewPresentor
