-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/panelguide/view/PanelGuideViewPresentor.lua

module("logic.extensions.panelguide.view.PanelGuideViewPresentor", package.seeall)

local PanelGuideViewPresentor = class("PanelGuideViewPresentor", ViewPresentor)

function PanelGuideViewPresentor:ctor()
	PanelGuideViewPresentor.super.ctor(self)
end

function PanelGuideViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PanelGuideViewPresentor:dependWhatResources()
	return {
		"ui/views/panelguide/panelguideview.prefab"
	}
end

function PanelGuideViewPresentor:buildViews()
	return {
		PanelGuideView.New()
	}
end

return PanelGuideViewPresentor
