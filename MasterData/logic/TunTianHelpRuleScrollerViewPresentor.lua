-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tuntianhelp/view/TunTianHelpRuleScrollerViewPresentor.lua

module("logic.extensions.tuntianhelp.view.TunTianHelpRuleScrollerViewPresentor", package.seeall)

local TunTianHelpRuleScrollerViewPresentor = class("TunTianHelpRuleScrollerViewPresentor", ViewPresentor)

function TunTianHelpRuleScrollerViewPresentor:ctor()
	TunTianHelpRuleScrollerViewPresentor.super.ctor(self)
end

function TunTianHelpRuleScrollerViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TunTianHelpRuleScrollerViewPresentor:dependWhatResources()
	return {
		"ui/views/tuntianhelp/tuntianhelprulescrollerview.prefab"
	}
end

function TunTianHelpRuleScrollerViewPresentor:buildViews()
	return {
		TunTianHelpRuleScrollerView.New()
	}
end

return TunTianHelpRuleScrollerViewPresentor
