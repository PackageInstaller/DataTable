-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/vrspace/view/VrspacenorViewPresentor.lua

module("logic.extensions.vrspace.view.VrspacenorViewPresentor", package.seeall)

local VrspacenorViewPresentor = class("VrspacenorViewPresentor", ViewPresentor)

function VrspacenorViewPresentor:ctor()
	VrspacenorViewPresentor.super.ctor(self)
end

function VrspacenorViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function VrspacenorViewPresentor:dependWhatResources()
	return {
		"ui/views/vrspace/vrspacenorview.prefab"
	}
end

function VrspacenorViewPresentor:buildViews()
	return {
		VrspacenorView.New()
	}
end

return VrspacenorViewPresentor
