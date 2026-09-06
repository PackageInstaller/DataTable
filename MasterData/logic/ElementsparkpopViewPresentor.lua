-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementsparkpopViewPresentor.lua

module("logic.extensions.elementspark.view.ElementsparkpopViewPresentor", package.seeall)

local ElementsparkpopViewPresentor = class("ElementsparkpopViewPresentor", ViewPresentor)

function ElementsparkpopViewPresentor:ctor()
	ElementsparkpopViewPresentor.super.ctor(self)
end

function ElementsparkpopViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ElementsparkpopViewPresentor:dependWhatResources()
	return {
		"ui/views/elementspark/elementsparkpopview.prefab"
	}
end

function ElementsparkpopViewPresentor:buildViews()
	return {
		ElementsparkpopView.New()
	}
end

return ElementsparkpopViewPresentor
