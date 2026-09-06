-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonkingaruishiclg/view/DragonKingARuiShiClgRuleViewPresentor.lua

module("logic.extensions.dragonkingaruishiclg.view.DragonKingARuiShiClgRuleViewPresentor", package.seeall)

local DragonKingARuiShiClgRuleViewPresentor = class("DragonKingARuiShiClgRuleViewPresentor", ViewPresentor)

function DragonKingARuiShiClgRuleViewPresentor:ctor()
	DragonKingARuiShiClgRuleViewPresentor.super.ctor(self)
end

function DragonKingARuiShiClgRuleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonKingARuiShiClgRuleViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonkingaruishiclg/dragonkingaruishiclgruleview.prefab"
	}
end

function DragonKingARuiShiClgRuleViewPresentor:buildViews()
	return {
		DragonKingARuiShiClgRuleView.New()
	}
end

return DragonKingARuiShiClgRuleViewPresentor
