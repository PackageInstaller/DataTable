-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tonglinshiji/view/TongLinShiJiExtRuleViewPresentor.lua

module("logic.extensions.tonglinshiji.view.TongLinShiJiExtRuleViewPresentor", package.seeall)

local TongLinShiJiExtRuleViewPresentor = class("TongLinShiJiExtRuleViewPresentor", ViewPresentor)

function TongLinShiJiExtRuleViewPresentor:ctor()
	TongLinShiJiExtRuleViewPresentor.super.ctor(self)
end

function TongLinShiJiExtRuleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TongLinShiJiExtRuleViewPresentor:dependWhatResources()
	return {
		"ui/views/tonglinshiji/tonglinshijiextruleview.prefab"
	}
end

function TongLinShiJiExtRuleViewPresentor:buildViews()
	return {
		TongLinShiJiExtRuleView.New()
	}
end

return TongLinShiJiExtRuleViewPresentor
