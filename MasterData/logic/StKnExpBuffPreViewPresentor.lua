-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stknexp/view/StKnExpBuffPreViewPresentor.lua

module("logic.extensions.stknexp.view.StKnExpBuffPreViewPresentor", package.seeall)

local StKnExpBuffPreViewPresentor = class("StKnExpBuffPreViewPresentor", ViewPresentor)

function StKnExpBuffPreViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function StKnExpBuffPreViewPresentor:dependWhatResources()
	return {
		"ui/views/stknexp/stknexpbuffpreview.prefab"
	}
end

function StKnExpBuffPreViewPresentor:buildViews()
	return {
		StKnExpBuffPreView.New()
	}
end

return StKnExpBuffPreViewPresentor
