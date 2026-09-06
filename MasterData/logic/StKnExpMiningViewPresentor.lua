-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stknexp/view/StKnExpMiningViewPresentor.lua

module("logic.extensions.stknexp.view.StKnExpMiningViewPresentor", package.seeall)

local StKnExpMiningViewPresentor = class("StKnExpMiningViewPresentor", ViewPresentor)

function StKnExpMiningViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StKnExpMiningViewPresentor:dependWhatResources()
	return {
		"ui/views/stknexp/stknexpminingview.prefab"
	}
end

function StKnExpMiningViewPresentor:buildViews()
	return {
		StKnExpMiningView.New()
	}
end

return StKnExpMiningViewPresentor
