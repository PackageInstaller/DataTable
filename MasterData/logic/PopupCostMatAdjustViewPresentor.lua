-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tips/view/PopupCostMatAdjustViewPresentor.lua

module("logic.extensions.tips.view.PopupCostMatAdjustViewPresentor", package.seeall)

local PopupCostMatAdjustViewPresentor = class("PopupCostMatAdjustViewPresentor", ViewWithGuidePresentor)

function PopupCostMatAdjustViewPresentor:ctor()
	PopupCostMatAdjustViewPresentor.super.ctor(self)
end

function PopupCostMatAdjustViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PopupCostMatAdjustViewPresentor:dependWhatResources()
	return {
		"ui/views/tips/popupcostmatadjustview.prefab"
	}
end

function PopupCostMatAdjustViewPresentor:buildViews()
	return {
		PopupCostMatAdjustView.New()
	}
end

return PopupCostMatAdjustViewPresentor
