-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkTipsViewPresentor.lua

module("logic.extensions.elementspark.view.ElementSparkTipsViewPresentor", package.seeall)

local ElementSparkTipsViewPresentor = class("ElementSparkTipsViewPresentor", ViewPresentor)

function ElementSparkTipsViewPresentor:ctor()
	ElementSparkTipsViewPresentor.super.ctor(self)
end

function ElementSparkTipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ElementSparkTipsViewPresentor:dependWhatResources()
	return {
		"ui/views/elementspark/elementsparktipsview.prefab"
	}
end

function ElementSparkTipsViewPresentor:buildViews()
	return {
		ElementSparkTipsView.New()
	}
end

return ElementSparkTipsViewPresentor
