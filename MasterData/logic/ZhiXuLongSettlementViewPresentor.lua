-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/zhixulong/ZhiXuLongSettlementViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.zhixulong.ZhiXuLongSettlementViewPresentor", package.seeall)

local ZhiXuLongSettlementViewPresentor = class("ZhiXuLongSettlementViewPresentor", ViewPresentor)

function ZhiXuLongSettlementViewPresentor:ctor()
	ZhiXuLongSettlementViewPresentor.super.ctor(self)
end

function ZhiXuLongSettlementViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ZhiXuLongSettlementViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/zhixulong/zhixulongsettlementview.prefab"
	}
end

function ZhiXuLongSettlementViewPresentor:buildViews()
	return {
		ZhiXuLongSettlementView.New()
	}
end

return ZhiXuLongSettlementViewPresentor
