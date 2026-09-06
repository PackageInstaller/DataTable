-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gm/view/gmskininterface/GMSkinInterfaceViewPresentor.lua

module("logic.extensions.gm.view.gmskininterface.GMSkinInterfaceViewPresentor", package.seeall)

local GMSkinInterfaceViewPresentor = class("GMSkinInterfaceViewPresentor", ViewPresentor)

function GMSkinInterfaceViewPresentor:ctor()
	GMSkinInterfaceViewPresentor.super.ctor(self)
end

function GMSkinInterfaceViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GMSkinInterfaceViewPresentor:dependWhatResources()
	return {
		"ui/views/gm/gmskininterface/gmskininterfaceview.prefab"
	}
end

function GMSkinInterfaceViewPresentor:buildViews()
	return {
		GMSkinInterfaceView.New()
	}
end

return GMSkinInterfaceViewPresentor
