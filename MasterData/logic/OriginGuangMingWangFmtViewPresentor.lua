-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originguangmingwang/view/OriginGuangMingWangFmtViewPresentor.lua

module("logic.extensions.originguangmingwang.view.OriginGuangMingWangFmtViewPresentor", package.seeall)

local OriginGuangMingWangFmtViewPresentor = class("OriginGuangMingWangFmtViewPresentor", ViewPresentor)

function OriginGuangMingWangFmtViewPresentor:ctor()
	OriginGuangMingWangFmtViewPresentor.super.ctor(self)
end

function OriginGuangMingWangFmtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginGuangMingWangFmtViewPresentor:dependWhatResources()
	return {
		"ui/views/originguangmingwang/originguangmingwangfmtview.prefab"
	}
end

function OriginGuangMingWangFmtViewPresentor:buildViews()
	return {
		OriginGuangMingWangFmtView.New()
	}
end

return OriginGuangMingWangFmtViewPresentor
