-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingmengmeng/view/KingmmExtremeBuffViewPresentor.lua

module("logic.extensions.kingmengmeng.view.KingmmExtremeBuffViewPresentor", package.seeall)

local KingmmExtremeBuffViewPresentor = class("KingmmExtremeBuffViewPresentor", ViewPresentor)

function KingmmExtremeBuffViewPresentor:ctor()
	KingmmExtremeBuffViewPresentor.super.ctor(self)
end

function KingmmExtremeBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingmmExtremeBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/kingmengmeng/kingmmextremebuffview.prefab"
	}
end

function KingmmExtremeBuffViewPresentor:buildViews()
	return {
		KingmmExtremeBuffView.New()
	}
end

return KingmmExtremeBuffViewPresentor
