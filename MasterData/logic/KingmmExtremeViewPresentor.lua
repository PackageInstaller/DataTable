-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingmengmeng/view/KingmmExtremeViewPresentor.lua

module("logic.extensions.kingmengmeng.view.KingmmExtremeViewPresentor", package.seeall)

local KingmmExtremeViewPresentor = class("KingmmExtremeViewPresentor", ViewPresentor)

function KingmmExtremeViewPresentor:ctor()
	KingmmExtremeViewPresentor.super.ctor(self)
end

function KingmmExtremeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingmmExtremeViewPresentor:dependWhatResources()
	return {
		"ui/views/kingmengmeng/kingmmextremeview.prefab"
	}
end

function KingmmExtremeViewPresentor:buildViews()
	return {
		KingmmExtremeView.New()
	}
end

return KingmmExtremeViewPresentor
