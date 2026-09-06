-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hdsummerlotteryrecommend/view/HdsummerlotteryrecommendViewPresentor.lua

module("logic.extensions.hdsummerlotteryrecommend.view.HdsummerlotteryrecommendViewPresentor", package.seeall)

local HdsummerlotteryrecommendViewPresentor = class("HdsummerlotteryrecommendViewPresentor", ViewPresentor)

function HdsummerlotteryrecommendViewPresentor:ctor()
	HdsummerlotteryrecommendViewPresentor.super.ctor(self)

	self.priority = ViewPriorityMgr.BonusViewPriority
end

function HdsummerlotteryrecommendViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HdsummerlotteryrecommendViewPresentor:dependWhatResources()
	return {
		"ui/views/hdsummerlotteryrecommend/hdsummerlotteryrecommendview.prefab"
	}
end

function HdsummerlotteryrecommendViewPresentor:buildViews()
	return {
		HdsummerlotteryrecommendView.New()
	}
end

return HdsummerlotteryrecommendViewPresentor
