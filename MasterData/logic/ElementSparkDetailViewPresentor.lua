-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkDetailViewPresentor.lua

module("logic.extensions.elementspark.view.ElementSparkDetailViewPresentor", package.seeall)

local ElementSparkDetailViewPresentor = class("ElementSparkDetailViewPresentor", ViewPresentor)

function ElementSparkDetailViewPresentor:ctor()
	ElementSparkDetailViewPresentor.super.ctor(self)
end

function ElementSparkDetailViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ElementSparkDetailViewPresentor:dependWhatResources()
	return {
		"ui/views/elementspark/elementsparkdetailview.prefab"
	}
end

function ElementSparkDetailViewPresentor:buildViews()
	return {
		ElementSparkDetailView.New()
	}
end

return ElementSparkDetailViewPresentor
