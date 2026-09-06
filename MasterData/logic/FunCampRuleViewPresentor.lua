-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/funcampmain/FunCampRuleViewPresentor.lua

module("logic.extensions.funcamp.view.funcampmain.FunCampRuleViewPresentor", package.seeall)

local FunCampRuleViewPresentor = class("FunCampRuleViewPresentor", ViewPresentor)

function FunCampRuleViewPresentor:ctor()
	FunCampRuleViewPresentor.super.ctor(self)
end

function FunCampRuleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FunCampRuleViewPresentor:dependWhatResources()
	return {
		"ui/views/funcamp/funcampruleview.prefab"
	}
end

function FunCampRuleViewPresentor:buildViews()
	return {
		FunCampRuleView.New()
	}
end

return FunCampRuleViewPresentor
