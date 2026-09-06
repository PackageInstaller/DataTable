-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkResourcePopViewPresentor.lua

module("logic.extensions.elementspark.view.ElementSparkResourcePopViewPresentor", package.seeall)

local ElementSparkResourcePopViewPresentor = class("ElementSparkResourcePopViewPresentor", ViewPresentor)

function ElementSparkResourcePopViewPresentor:ctor()
	ElementSparkResourcePopViewPresentor.super.ctor(self)
end

function ElementSparkResourcePopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ElementSparkResourcePopViewPresentor:dependWhatResources()
	return {
		"ui/views/elementspark/elementsparkresourcepopview.prefab"
	}
end

function ElementSparkResourcePopViewPresentor:buildViews()
	return {
		ElementSparkResourcePopView.New()
	}
end

return ElementSparkResourcePopViewPresentor
