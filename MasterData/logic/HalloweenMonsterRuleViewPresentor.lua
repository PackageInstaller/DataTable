-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/halloweenguest/view/HalloweenMonsterRuleViewPresentor.lua

module("logic.extensions.halloweenguest.view.HalloweenMonsterRuleViewPresentor", package.seeall)

local HalloweenMonsterRuleViewPresentor = class("HalloweenMonsterRuleViewPresentor", ViewWithGuidePresentor)

function HalloweenMonsterRuleViewPresentor:ctor()
	HalloweenMonsterRuleViewPresentor.super.ctor(self)
end

function HalloweenMonsterRuleViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HalloweenMonsterRuleViewPresentor:dependWhatResources()
	return {
		"ui/views/halloweenguest/halloweenmonsterruleview.prefab"
	}
end

function HalloweenMonsterRuleViewPresentor:buildViews()
	return {
		HalloweenMonsterRuleView.New()
	}
end

return HalloweenMonsterRuleViewPresentor
