-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hdsummerlotteryrecommend/view/PackguangyidatianshiViewPresentor.lua

module("logic.extensions.hdsummerlotteryrecommend.view.PackguangyidatianshiViewPresentor", package.seeall)

local PackguangyidatianshiViewPresentor = class("PackguangyidatianshiViewPresentor", ViewPresentor)

function PackguangyidatianshiViewPresentor:ctor()
	PackguangyidatianshiViewPresentor.super.ctor(self)

	self.priority = ViewPriorityMgr.BonusViewPriority
end

function PackguangyidatianshiViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PackguangyidatianshiViewPresentor:dependWhatResources()
	return {
		"ui/views/hdsummerlotteryrecommend/packguangyidatianshiview.prefab"
	}
end

function PackguangyidatianshiViewPresentor:buildViews()
	return {
		PackguangyidatianshiView.New()
	}
end

return PackguangyidatianshiViewPresentor
