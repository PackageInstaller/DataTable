-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingmengmeng/view/KingmmLevelViewPresentor.lua

module("logic.extensions.kingmengmeng.view.KingmmLevelViewPresentor", package.seeall)

local KingmmLevelViewPresentor = class("KingmmLevelViewPresentor", ViewPresentor)

function KingmmLevelViewPresentor:ctor()
	KingmmLevelViewPresentor.super.ctor(self)
end

function KingmmLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingmmLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/kingmengmeng/kingmmlevelview.prefab"
	}
end

function KingmmLevelViewPresentor:buildViews()
	return {
		KingmmLevelView.New()
	}
end

return KingmmLevelViewPresentor
