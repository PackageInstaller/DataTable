-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originguangmingwang/view/OriginGuangMingWangResultViewPresentor.lua

module("logic.extensions.originguangmingwang.view.OriginGuangMingWangResultViewPresentor", package.seeall)

local OriginGuangMingWangResultViewPresentor = class("OriginGuangMingWangResultViewPresentor", ViewPresentor)

function OriginGuangMingWangResultViewPresentor:ctor()
	OriginGuangMingWangResultViewPresentor.super.ctor(self)
end

function OriginGuangMingWangResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OriginGuangMingWangResultViewPresentor:dependWhatResources()
	return {
		"ui/views/originguangmingwang/originguangmingwangresultview.prefab"
	}
end

function OriginGuangMingWangResultViewPresentor:buildViews()
	return {
		OriginGuangMingWangResultView.New()
	}
end

return OriginGuangMingWangResultViewPresentor
