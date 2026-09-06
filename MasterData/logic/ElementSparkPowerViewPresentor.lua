-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkPowerViewPresentor.lua

module("logic.extensions.elementspark.view.ElementSparkPowerViewPresentor", package.seeall)

local ElementSparkPowerViewPresentor = class("ElementSparkPowerViewPresentor", ViewPresentor)

function ElementSparkPowerViewPresentor:ctor()
	ElementSparkPowerViewPresentor.super.ctor(self)
end

function ElementSparkPowerViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ElementSparkPowerViewPresentor:dependWhatResources()
	return {
		"ui/views/elementspark/elementsparkpowerview.prefab"
	}
end

function ElementSparkPowerViewPresentor:buildViews()
	return {
		ElementSparkPowerView.New()
	}
end

return ElementSparkPowerViewPresentor
