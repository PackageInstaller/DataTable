-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindragonnoah/view/OriginDragonNoahRulePopViewPresentor.lua

module("logic.extensions.origindragonnoah.view.OriginDragonNoahRulePopViewPresentor", package.seeall)

local OriginDragonNoahRulePopViewPresentor = class("OriginDragonNoahRulePopViewPresentor", ViewPresentor)

function OriginDragonNoahRulePopViewPresentor:ctor()
	OriginDragonNoahRulePopViewPresentor.super.ctor(self)
end

function OriginDragonNoahRulePopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginDragonNoahRulePopViewPresentor:dependWhatResources()
	return {
		"ui/views/origindragonnoah/origindragonnoahrulepopview.prefab"
	}
end

function OriginDragonNoahRulePopViewPresentor:buildViews()
	return {
		OriginDragonNoahRulePopView.New()
	}
end

return OriginDragonNoahRulePopViewPresentor
