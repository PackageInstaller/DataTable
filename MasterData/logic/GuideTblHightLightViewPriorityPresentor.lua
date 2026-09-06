-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/view/GuideTblHightLightViewPriorityPresentor.lua

module("logic.extensions.guide.view.GuideTblHightLightViewPriorityPresentor", package.seeall)

local GuideTblHightLightViewPriorityPresentor = class("GuideTblHightLightViewPriorityPresentor", GuideViewPresentor)

function GuideTblHightLightViewPriorityPresentor:ctor()
	GuideTblHightLightViewPriorityPresentor.super.ctor(self)

	self.priority = ViewPriorityMgr.BonusViewPriority
end

function GuideTblHightLightViewPriorityPresentor:attachToWhichRoot()
	return ViewRootType.Top
end

function GuideTblHightLightViewPriorityPresentor:dependWhatResources()
	return {
		"ui/views/guide/guideheadview.prefab"
	}
end

function GuideTblHightLightViewPriorityPresentor:buildViews()
	return {
		GuidetblHightLightView.New()
	}
end

function GuideTblHightLightViewPriorityPresentor:_onViewShowByHigherPriority()
	local vCount = #self._views

	for i = 1, vCount do
		if self._views[i] and self._views[i]._onDelay then
			self._views[i]:_onDelay()
		end
	end
end

return GuideTblHightLightViewPriorityPresentor
