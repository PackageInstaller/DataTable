-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingmoyanclg/view/KingMoYanClgMainViewPresentor.lua

module("logic.extensions.kingmoyanclg.view.KingMoYanClgMainViewPresentor", package.seeall)

local KingMoYanClgMainViewPresentor = class("KingMoYanClgMainViewPresentor", ViewPresentor)

function KingMoYanClgMainViewPresentor:ctor()
	KingMoYanClgMainViewPresentor.super.ctor(self)
end

function KingMoYanClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingMoYanClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/kingmoyanclg/kingmoyanclgmainview.prefab"
	}
end

function KingMoYanClgMainViewPresentor:buildViews()
	return {
		KingMoYanClgMainView.New()
	}
end

return KingMoYanClgMainViewPresentor
