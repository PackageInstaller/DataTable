-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/vrspace/view/VrspacebuffViewPresentor.lua

module("logic.extensions.vrspace.view.VrspacebuffViewPresentor", package.seeall)

local VrspacebuffViewPresentor = class("VrspacebuffViewPresentor", ViewPresentor)

function VrspacebuffViewPresentor:ctor()
	VrspacebuffViewPresentor.super.ctor(self)
end

function VrspacebuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function VrspacebuffViewPresentor:dependWhatResources()
	return {
		"ui/views/vrspace/vrspacebuffview.prefab"
	}
end

function VrspacebuffViewPresentor:buildViews()
	return {
		VrspacebuffView.New()
	}
end

return VrspacebuffViewPresentor
