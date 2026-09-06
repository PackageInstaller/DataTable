-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newyearpray/view/NewYearPraySceneViewPresentor.lua

module("logic.extensions.newyearpray.view.NewYearPraySceneViewPresentor", package.seeall)

local NewYearPraySceneViewPresentor = class("NewYearPraySceneViewPresentor", ViewPresentor)

function NewYearPraySceneViewPresentor:ctor()
	NewYearPraySceneViewPresentor.super.ctor(self)
end

function NewYearPraySceneViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NewYearPraySceneViewPresentor:dependWhatResources()
	return {
		"ui/views/newyearpray/newyearpraysceneview.prefab"
	}
end

function NewYearPraySceneViewPresentor:buildViews()
	return {
		NewYearPraySceneView.New()
	}
end

return NewYearPraySceneViewPresentor
