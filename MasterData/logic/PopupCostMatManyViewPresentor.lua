-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tips/view/PopupCostMatManyViewPresentor.lua

module("logic.extensions.tips.view.PopupCostMatManyViewPresentor", package.seeall)

local PopupCostMatManyViewPresentor = class("PopupCostMatManyViewPresentor", ViewPresentor)

function PopupCostMatManyViewPresentor:ctor()
	PopupCostMatManyViewPresentor.super.ctor(self)
end

function PopupCostMatManyViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PopupCostMatManyViewPresentor:dependWhatResources()
	return {
		"ui/views/activityshop/activityshopexchangebuyview.prefab"
	}
end

function PopupCostMatManyViewPresentor:buildViews()
	return {
		PopupCostMatManyView.New()
	}
end

return PopupCostMatManyViewPresentor
