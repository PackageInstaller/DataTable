-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/view/GuideHeadViewPresentor.lua

module("logic.extensions.guide.view.GuideHeadViewPresentor", package.seeall)

local GuideHeadViewPresentor = class("GuideHeadViewPresentor", GuideViewPresentor)

function GuideHeadViewPresentor:ctor()
	GuideHeadViewPresentor.super.ctor(self)

	self.priority = ViewPriorityMgr.BonusViewPriority
end

function GuideHeadViewPresentor:attachToWhichRoot()
	return ViewRootType.Top
end

function GuideHeadViewPresentor:dependWhatResources()
	return {
		"ui/views/guide/guideheadview.prefab"
	}
end

function GuideHeadViewPresentor:buildViews()
	local views = {}
	local guideHeadView = GuideHeadView.New()

	table.insert(views, guideHeadView)

	return views
end

return GuideHeadViewPresentor
