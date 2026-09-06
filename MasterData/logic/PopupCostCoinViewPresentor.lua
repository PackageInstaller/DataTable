-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tips/view/PopupCostCoinViewPresentor.lua

module("logic.extensions.tips.view.PopupCostCoinViewPresentor", package.seeall)

local PopupCostCoinViewPresentor = class("PopupCostCoinViewPresentor", ViewPresentor)

function PopupCostCoinViewPresentor:ctor()
	PopupCostCoinViewPresentor.super.ctor(self)
end

function PopupCostCoinViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PopupCostCoinViewPresentor:dependWhatResources()
	return {
		"ui/views/tips/popupcostcoinview.prefab"
	}
end

function PopupCostCoinViewPresentor:buildViews()
	return {
		PopupCostCoinView.New()
	}
end

return PopupCostCoinViewPresentor
