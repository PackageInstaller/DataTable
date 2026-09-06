-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stknexp/view/StKnExpIslandViewPresentor.lua

module("logic.extensions.stknexp.view.StKnExpIslandViewPresentor", package.seeall)

local StKnExpIslandViewPresentor = class("StKnExpIslandViewPresentor", ViewPresentor)

function StKnExpIslandViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StKnExpIslandViewPresentor:dependWhatResources()
	return {
		"ui/views/stknexp/stknexpislandview.prefab"
	}
end

function StKnExpIslandViewPresentor:buildViews()
	return {
		StKnExpIslandView.New()
	}
end

return StKnExpIslandViewPresentor
