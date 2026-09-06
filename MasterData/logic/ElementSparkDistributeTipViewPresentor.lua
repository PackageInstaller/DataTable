-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkDistributeTipViewPresentor.lua

module("logic.extensions.elementspark.view.ElementSparkDistributeTipViewPresentor", package.seeall)

local ElementSparkDistributeTipViewPresentor = class("ElementSparkDistributeTipViewPresentor", ViewPresentor)

function ElementSparkDistributeTipViewPresentor:ctor()
	ElementSparkDistributeTipViewPresentor.super.ctor(self)
end

function ElementSparkDistributeTipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ElementSparkDistributeTipViewPresentor:dependWhatResources()
	return {
		"ui/views/elementspark/elementsparkdistributetipview.prefab"
	}
end

function ElementSparkDistributeTipViewPresentor:buildViews()
	return {
		ElementSparkDistributeTipView.New()
	}
end

return ElementSparkDistributeTipViewPresentor
