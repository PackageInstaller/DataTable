-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stknexp/view/StKnExpIslandUpdateViewPresentor.lua

module("logic.extensions.stknexp.view.StKnExpIslandUpdateViewPresentor", package.seeall)

local StKnExpIslandUpdateViewPresentor = class("StKnExpIslandUpdateViewPresentor", ViewPresentor)

function StKnExpIslandUpdateViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function StKnExpIslandUpdateViewPresentor:dependWhatResources()
	return {
		"ui/views/stknexp/stknexpislandupdateview.prefab"
	}
end

function StKnExpIslandUpdateViewPresentor:buildViews()
	return {
		StKnExpIslandUpdateView.New()
	}
end

return StKnExpIslandUpdateViewPresentor
