-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkPrizeViewPresentor.lua

module("logic.extensions.elementspark.view.ElementSparkPrizeViewPresentor", package.seeall)

local ElementSparkPrizeViewPresentor = class("ElementSparkPrizeViewPresentor", ViewPresentor)

function ElementSparkPrizeViewPresentor:ctor()
	ElementSparkPrizeViewPresentor.super.ctor(self)
end

function ElementSparkPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ElementSparkPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/elementspark/elementsparkprizeview.prefab"
	}
end

function ElementSparkPrizeViewPresentor:buildViews()
	return {
		ElementSparkPrizeView.New()
	}
end

return ElementSparkPrizeViewPresentor
