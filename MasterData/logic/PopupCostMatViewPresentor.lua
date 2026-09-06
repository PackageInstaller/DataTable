-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tips/view/PopupCostMatViewPresentor.lua

module("logic.extensions.tips.view.PopupCostMatViewPresentor", package.seeall)

local PopupCostMatViewPresentor = class("PopupCostMatViewPresentor", ViewWithGuidePresentor)

function PopupCostMatViewPresentor:ctor()
	PopupCostMatViewPresentor.super.ctor(self)
end

function PopupCostMatViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PopupCostMatViewPresentor:dependWhatResources()
	return {
		"ui/views/tips/popupcostmatview.prefab"
	}
end

function PopupCostMatViewPresentor:buildViews()
	return {
		PopupCostMatView.New()
	}
end

return PopupCostMatViewPresentor
