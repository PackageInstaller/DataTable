-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tips/view/PopupCostDiamondViewPresentor.lua

module("logic.extensions.tips.view.PopupCostDiamondViewPresentor", package.seeall)

local PopupCostDiamondViewPresentor = class("PopupCostDiamondViewPresentor", ViewPresentor)

function PopupCostDiamondViewPresentor:ctor()
	PopupCostDiamondViewPresentor.super.ctor(self)
end

function PopupCostDiamondViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PopupCostDiamondViewPresentor:dependWhatResources()
	return {
		"ui/views/tips/popupcostdiamondview.prefab"
	}
end

function PopupCostDiamondViewPresentor:buildViews()
	return {
		PopupCostDiamondView.New()
	}
end

return PopupCostDiamondViewPresentor
