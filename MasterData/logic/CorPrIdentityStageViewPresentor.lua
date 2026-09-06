-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/corpr/view/CorPrIdentityStageViewPresentor.lua

module("logic.extensions.corpr.view.CorPrIdentityStageViewPresentor", package.seeall)

local CorPrIdentityStageViewPresentor = class("CorPrIdentityStageViewPresentor", ViewPresentor)

function CorPrIdentityStageViewPresentor:ctor()
	CorPrIdentityStageViewPresentor.super.ctor(self)
end

function CorPrIdentityStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CorPrIdentityStageViewPresentor:dependWhatResources()
	return {
		"ui/views/corpr/corpridentitystageview.prefab"
	}
end

function CorPrIdentityStageViewPresentor:buildViews()
	return {
		CorPrIdentityStageView.New()
	}
end

return CorPrIdentityStageViewPresentor
