-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkCampViewPresentor.lua

module("logic.extensions.elementspark.view.ElementSparkCampViewPresentor", package.seeall)

local ElementSparkCampViewPresentor = class("ElementSparkCampViewPresentor", ViewPresentor)

function ElementSparkCampViewPresentor:ctor()
	ElementSparkCampViewPresentor.super.ctor(self)
end

function ElementSparkCampViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ElementSparkCampViewPresentor:dependWhatResources()
	return {
		"ui/views/elementspark/elementsparkcampview.prefab"
	}
end

function ElementSparkCampViewPresentor:buildViews()
	return {
		ElementSparkCampView.New()
	}
end

return ElementSparkCampViewPresentor
