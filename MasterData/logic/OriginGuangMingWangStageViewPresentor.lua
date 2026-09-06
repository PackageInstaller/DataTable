-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originguangmingwang/view/OriginGuangMingWangStageViewPresentor.lua

module("logic.extensions.originguangmingwang.view.OriginGuangMingWangStageViewPresentor", package.seeall)

local OriginGuangMingWangStageViewPresentor = class("OriginGuangMingWangStageViewPresentor", ViewPresentor)

function OriginGuangMingWangStageViewPresentor:ctor()
	OriginGuangMingWangStageViewPresentor.super.ctor(self)
end

function OriginGuangMingWangStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginGuangMingWangStageViewPresentor:dependWhatResources()
	return {
		"ui/views/originguangmingwang/originguangmingwangstageview.prefab"
	}
end

function OriginGuangMingWangStageViewPresentor:buildViews()
	return {
		OriginGuangMingWangStageView.New()
	}
end

return OriginGuangMingWangStageViewPresentor
