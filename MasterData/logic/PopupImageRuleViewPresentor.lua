-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tips/view/PopupImageRuleViewPresentor.lua

module("logic.extensions.tips.view.PopupImageRuleViewPresentor", package.seeall)

local PopupImageRuleViewPresentor = class("PopupImageRuleViewPresentor", ViewPresentor)

function PopupImageRuleViewPresentor:ctor()
	PopupImageRuleViewPresentor.super.ctor(self)
end

function PopupImageRuleViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PopupImageRuleViewPresentor:dependWhatResources()
	return {
		"ui/views/tips/popupimageruleview.prefab"
	}
end

function PopupImageRuleViewPresentor:buildViews()
	return {
		PopupImageRuleView.New()
	}
end

return PopupImageRuleViewPresentor
