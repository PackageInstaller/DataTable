-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingmoyanclg/view/KingMoYanClgStageViewPresentor.lua

module("logic.extensions.kingmoyanclg.view.KingMoYanClgStageViewPresentor", package.seeall)

local KingMoYanClgStageViewPresentor = class("KingMoYanClgStageViewPresentor", ViewPresentor)

function KingMoYanClgStageViewPresentor:ctor()
	KingMoYanClgStageViewPresentor.super.ctor(self)
end

function KingMoYanClgStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingMoYanClgStageViewPresentor:dependWhatResources()
	return {
		"ui/views/kingmoyanclg/kingmoyanclgstageview.prefab"
	}
end

function KingMoYanClgStageViewPresentor:buildViews()
	return {
		KingMoYanClgStageView.New()
	}
end

return KingMoYanClgStageViewPresentor
