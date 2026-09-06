-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tips/view/PopupCostMatAdjustSingleViewPresentor.lua

module("logic.extensions.tips.view.PopupCostMatAdjustSingleViewPresentor", package.seeall)

local PopupCostMatAdjustSingleViewPresentor = class("PopupCostMatAdjustSingleViewPresentor", ViewWithGuidePresentor)

function PopupCostMatAdjustSingleViewPresentor:ctor()
	PopupCostMatAdjustSingleViewPresentor.super.ctor(self)
end

function PopupCostMatAdjustSingleViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PopupCostMatAdjustSingleViewPresentor:dependWhatResources()
	return {
		"ui/views/tips/popupcostmatadjustview.prefab"
	}
end

function PopupCostMatAdjustSingleViewPresentor:buildViews()
	return {
		PopupCostMatAdjustSingleView.New()
	}
end

return PopupCostMatAdjustSingleViewPresentor
