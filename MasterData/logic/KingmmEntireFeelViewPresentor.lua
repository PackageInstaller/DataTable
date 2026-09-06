-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingmengmeng/view/KingmmEntireFeelViewPresentor.lua

module("logic.extensions.kingmengmeng.view.KingmmEntireFeelViewPresentor", package.seeall)

local KingmmEntireFeelViewPresentor = class("KingmmEntireFeelViewPresentor", ViewPresentor)

function KingmmEntireFeelViewPresentor:ctor()
	KingmmEntireFeelViewPresentor.super.ctor(self)
end

function KingmmEntireFeelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingmmEntireFeelViewPresentor:dependWhatResources()
	return {
		"ui/views/kingmengmeng/kingmmentirefeelview.prefab"
	}
end

function KingmmEntireFeelViewPresentor:buildViews()
	return {
		KingmmEntireFeelView.New()
	}
end

return KingmmEntireFeelViewPresentor
