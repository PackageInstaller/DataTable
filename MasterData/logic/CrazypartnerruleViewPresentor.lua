-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/crazypartner/view/CrazypartnerruleViewPresentor.lua

module("logic.extensions.crazypartner.view.CrazypartnerruleViewPresentor", package.seeall)

local CrazypartnerruleViewPresentor = class("CrazypartnerruleViewPresentor", ViewPresentor)

function CrazypartnerruleViewPresentor:ctor()
	CrazypartnerruleViewPresentor.super.ctor(self)
end

function CrazypartnerruleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CrazypartnerruleViewPresentor:dependWhatResources()
	return {
		"ui/views/crazypartner/crazypartnerruleview.prefab"
	}
end

function CrazypartnerruleViewPresentor:buildViews()
	return {
		CrazyPartnerRuleView.New()
	}
end

return CrazypartnerruleViewPresentor
