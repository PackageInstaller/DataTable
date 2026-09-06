-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingmengmeng/view/KingmmMainViewPresentor.lua

module("logic.extensions.kingmengmeng.view.KingmmMainViewPresentor", package.seeall)

local KingmmMainViewPresentor = class("KingmmMainViewPresentor", ViewPresentor)

function KingmmMainViewPresentor:ctor()
	KingmmMainViewPresentor.super.ctor(self)
end

function KingmmMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingmmMainViewPresentor:dependWhatResources()
	return {
		"ui/views/kingmengmeng/kingmmmainview.prefab"
	}
end

function KingmmMainViewPresentor:buildViews()
	return {
		KingmmMainView.New()
	}
end

return KingmmMainViewPresentor
