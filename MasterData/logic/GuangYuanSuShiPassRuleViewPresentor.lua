-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/guangyuansushi/GuangYuanSuShiPassRuleViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.guangyuansushi.GuangYuanSuShiPassRuleViewPresentor", package.seeall)

local GuangYuanSuShiPassRuleViewPresentor = class("GuangYuanSuShiPassRuleViewPresentor", ViewPresentor)

function GuangYuanSuShiPassRuleViewPresentor:ctor()
	GuangYuanSuShiPassRuleViewPresentor.super.ctor(self)
end

function GuangYuanSuShiPassRuleViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GuangYuanSuShiPassRuleViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/guangyuansushi/guangyuansushipassruleview.prefab"
	}
end

function GuangYuanSuShiPassRuleViewPresentor:buildViews()
	return {
		GuangYuanSuShiPassRuleView.New()
	}
end

return GuangYuanSuShiPassRuleViewPresentor
