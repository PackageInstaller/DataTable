-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementsparkpetshopViewPresentor.lua

module("logic.extensions.elementspark.view.ElementsparkpetshopViewPresentor", package.seeall)

local ElementsparkpetshopViewPresentor = class("ElementsparkpetshopViewPresentor", ViewPresentor)

function ElementsparkpetshopViewPresentor:ctor()
	ElementsparkpetshopViewPresentor.super.ctor(self)
end

function ElementsparkpetshopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ElementsparkpetshopViewPresentor:dependWhatResources()
	return {
		"ui/views/elementspark/elementsparkpetshopview.prefab"
	}
end

function ElementsparkpetshopViewPresentor:buildViews()
	return {
		ElementsparkpetshopView.New()
	}
end

return ElementsparkpetshopViewPresentor
