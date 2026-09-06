-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originguangmingwang/view/OriginGuangMingWangMainViewPresentor.lua

module("logic.extensions.originguangmingwang.view.OriginGuangMingWangMainViewPresentor", package.seeall)

local OriginGuangMingWangMainViewPresentor = class("OriginGuangMingWangMainViewPresentor", ViewPresentor)

function OriginGuangMingWangMainViewPresentor:ctor()
	OriginGuangMingWangMainViewPresentor.super.ctor(self)
end

function OriginGuangMingWangMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginGuangMingWangMainViewPresentor:dependWhatResources()
	return {
		"ui/views/originguangmingwang/originguangmingwangmainview.prefab"
	}
end

function OriginGuangMingWangMainViewPresentor:buildViews()
	return {
		OriginGuangMingWangMainView.New()
	}
end

return OriginGuangMingWangMainViewPresentor
