-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingisaacclg/view/KingIsaacClgStageViewPresentor.lua

module("logic.extensions.kingisaacclg.view.KingIsaacClgStageViewPresentor", package.seeall)

local KingIsaacClgStageViewPresentor = class("KingIsaacClgStageViewPresentor", ViewPresentor)

function KingIsaacClgStageViewPresentor:ctor()
	KingIsaacClgStageViewPresentor.super.ctor(self)
end

function KingIsaacClgStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingIsaacClgStageViewPresentor:dependWhatResources()
	return {
		"ui/views/kingisaacclg/kingisaacclgstageview.prefab"
	}
end

function KingIsaacClgStageViewPresentor:buildViews()
	return {
		KingIsaacClgStageView.New()
	}
end

return KingIsaacClgStageViewPresentor
