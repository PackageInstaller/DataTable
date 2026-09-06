-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/vrspace/view/VrspacemainViewPresentor.lua

module("logic.extensions.vrspace.view.VrspacemainViewPresentor", package.seeall)

local VrspacemainViewPresentor = class("VrspacemainViewPresentor", ViewPresentor)

function VrspacemainViewPresentor:ctor()
	VrspacemainViewPresentor.super.ctor(self)
end

function VrspacemainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function VrspacemainViewPresentor:dependWhatResources()
	return {
		"ui/views/vrspace/vrspacemainview.prefab"
	}
end

function VrspacemainViewPresentor:buildViews()
	return {
		VrspacemainView.New()
	}
end

return VrspacemainViewPresentor
