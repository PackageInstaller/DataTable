-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/guangyuansushi/GuangYuanSuShiRuleViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.guangyuansushi.GuangYuanSuShiRuleViewPresentor", package.seeall)

local GuangYuanSuShiRuleViewPresentor = class("GuangYuanSuShiRuleViewPresentor", ViewPresentor)

function GuangYuanSuShiRuleViewPresentor:ctor()
	GuangYuanSuShiRuleViewPresentor.super.ctor(self)
end

function GuangYuanSuShiRuleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GuangYuanSuShiRuleViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/guangyuansushi/guangyuansushiruleview.prefab"
	}
end

function GuangYuanSuShiRuleViewPresentor:buildViews()
	return {
		GuangYuanSuShiRuleView.New()
	}
end

return GuangYuanSuShiRuleViewPresentor
