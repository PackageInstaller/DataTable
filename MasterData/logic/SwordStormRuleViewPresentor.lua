-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/swordstorm/view/SwordStormRuleViewPresentor.lua

module("logic.extensions.swordstorm.view.SwordStormRuleViewPresentor", package.seeall)

local SwordStormRuleViewPresentor = class("SwordStormRuleViewPresentor", ViewPresentor)

function SwordStormRuleViewPresentor:ctor()
	SwordStormRuleViewPresentor.super.ctor(self)
end

function SwordStormRuleViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SwordStormRuleViewPresentor:dependWhatResources()
	return {
		"ui/views/swordstorm/swordstormruleview.prefab"
	}
end

function SwordStormRuleViewPresentor:buildViews()
	return {
		SwordStormRuleView.New()
	}
end

function SwordStormRuleViewPresentor:onClickOutside()
	self:close()
end

return SwordStormRuleViewPresentor
