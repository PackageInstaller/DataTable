-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/vrspace/view/VrspaceprizeViewPresentor.lua

module("logic.extensions.vrspace.view.VrspaceprizeViewPresentor", package.seeall)

local VrspaceprizeViewPresentor = class("VrspaceprizeViewPresentor", ViewPresentor)

function VrspaceprizeViewPresentor:ctor()
	VrspaceprizeViewPresentor.super.ctor(self)
end

function VrspaceprizeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function VrspaceprizeViewPresentor:dependWhatResources()
	return {
		"ui/views/vrspace/vrspaceprizeview.prefab"
	}
end

function VrspaceprizeViewPresentor:buildViews()
	return {
		VrspaceprizeView.New()
	}
end

return VrspaceprizeViewPresentor
