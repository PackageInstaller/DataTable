-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godlongyan/view/cutfruit/CutFruitSceneViewPresentor.lua

module("logic.extensions.godlongyan.view.cutfruit.CutFruitSceneViewPresentor", package.seeall)

local CutFruitSceneViewPresentor = class("CutFruitSceneViewPresentor", ViewPresentor)

function CutFruitSceneViewPresentor:ctor()
	CutFruitSceneViewPresentor.super.ctor(self)
end

function CutFruitSceneViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CutFruitSceneViewPresentor:dependWhatResources()
	return {
		"ui/views/godlongyan/cutfruit/cutfruitsceneview.prefab"
	}
end

function CutFruitSceneViewPresentor:buildViews()
	return {
		CutFruitSceneView.New()
	}
end

return CutFruitSceneViewPresentor
