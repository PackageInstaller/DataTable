-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkFormationViewPresentor.lua

module("logic.extensions.elementspark.view.ElementSparkFormationViewPresentor", package.seeall)

local ElementSparkFormationViewPresentor = class("ElementSparkFormationViewPresentor", ViewPresentor)

function ElementSparkFormationViewPresentor:ctor()
	ElementSparkFormationViewPresentor.super.ctor(self)
end

function ElementSparkFormationViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ElementSparkFormationViewPresentor:dependWhatResources()
	return {
		"ui/views/elementspark/elementsparkformationview.prefab"
	}
end

function ElementSparkFormationViewPresentor:buildViews()
	return {
		ElementSparkFormationView.New()
	}
end

return ElementSparkFormationViewPresentor
