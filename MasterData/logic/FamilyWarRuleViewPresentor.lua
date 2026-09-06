-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/war/FamilyWarRuleViewPresentor.lua

module("logic.extensions.newfamily.view.war.FamilyWarRuleViewPresentor", package.seeall)

local FamilyWarRuleViewPresentor = class("FamilyWarRuleViewPresentor", ViewPresentor)

function FamilyWarRuleViewPresentor:ctor()
	FamilyWarRuleViewPresentor.super.ctor(self)
end

function FamilyWarRuleViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FamilyWarRuleViewPresentor:dependWhatResources()
	return {
		"ui/views/newfamily/war/familywarruleview.prefab"
	}
end

function FamilyWarRuleViewPresentor:buildViews()
	return {
		FamilyWarRuleView.New()
	}
end

return FamilyWarRuleViewPresentor
