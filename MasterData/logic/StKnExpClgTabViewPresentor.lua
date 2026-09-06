-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stknexp/view/StKnExpClgTabViewPresentor.lua

module("logic.extensions.stknexp.view.StKnExpClgTabViewPresentor", package.seeall)

local StKnExpClgTabViewPresentor = class("StKnExpClgTabViewPresentor", ViewPresentor)

function StKnExpClgTabViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StKnExpClgTabViewPresentor:dependWhatResources()
	return {
		"ui/views/stknexp/stknexpclgtabview.prefab"
	}
end

function StKnExpClgTabViewPresentor:buildViews()
	return {
		StKnExpClgTabView.New()
	}
end

return StKnExpClgTabViewPresentor
