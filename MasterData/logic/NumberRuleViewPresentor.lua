-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberbomb/view/NumberRuleViewPresentor.lua

module("logic.extensions.numberbomb.view.NumberRuleViewPresentor", package.seeall)

local NumberRuleViewPresentor = class("NumberRuleViewPresentor", ViewWithGuidePresentor)

function NumberRuleViewPresentor:ctor()
	NumberRuleViewPresentor.super.ctor(self)
end

function NumberRuleViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function NumberRuleViewPresentor:dependWhatResources()
	return {
		"ui/views/numberbomb/numberruleview.prefab"
	}
end

function NumberRuleViewPresentor:buildViews()
	return {
		NumberRuleView.New()
	}
end

return NumberRuleViewPresentor
