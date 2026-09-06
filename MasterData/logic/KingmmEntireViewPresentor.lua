-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingmengmeng/view/KingmmEntireViewPresentor.lua

module("logic.extensions.kingmengmeng.view.KingmmEntireViewPresentor", package.seeall)

local KingmmEntireViewPresentor = class("KingmmEntireViewPresentor", ViewPresentor)

function KingmmEntireViewPresentor:ctor()
	KingmmEntireViewPresentor.super.ctor(self)
end

function KingmmEntireViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingmmEntireViewPresentor:dependWhatResources()
	return {
		"ui/views/kingmengmeng/kingmmentireview.prefab"
	}
end

function KingmmEntireViewPresentor:buildViews()
	return {
		KingmmEntireView.New()
	}
end

return KingmmEntireViewPresentor
