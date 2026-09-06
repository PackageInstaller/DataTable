-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/view/element/ElementpopViewPresentor.lua

module("logic.extensions.formation.view.element.ElementpopViewPresentor", package.seeall)

local ElementpopViewPresentor = class("ElementpopViewPresentor", ViewWithGuidePresentor)

function ElementpopViewPresentor:ctor()
	ElementpopViewPresentor.super.ctor(self)
end

function ElementpopViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ElementpopViewPresentor:dependWhatResources()
	return {
		"ui/views/formation/elementpopview.prefab"
	}
end

function ElementpopViewPresentor:buildViews()
	return {
		ElementpopView.New()
	}
end

return ElementpopViewPresentor
