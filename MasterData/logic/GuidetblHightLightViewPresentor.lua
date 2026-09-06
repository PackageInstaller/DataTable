-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/view/GuidetblHightLightViewPresentor.lua

module("logic.extensions.guide.view.GuidetblHightLightViewPresentor", package.seeall)

local GuidetblHightLightViewPresentor = class("GuidetblHightLightViewPresentor", GuideViewPresentor)

function GuidetblHightLightViewPresentor:ctor()
	GuidetblHightLightViewPresentor.super.ctor(self)

	self.priority = ViewPriorityMgr.BonusViewPriority
end

function GuidetblHightLightViewPresentor:attachToWhichRoot()
	return ViewRootType.Top
end

function GuidetblHightLightViewPresentor:dependWhatResources()
	return {
		"ui/views/guide/guideheadview.prefab"
	}
end

function GuidetblHightLightViewPresentor:buildViews()
	return {
		GuidetblHightLightView.New()
	}
end

return GuidetblHightLightViewPresentor
