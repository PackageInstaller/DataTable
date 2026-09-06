-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemimengliclg/view/DivineMiMengLiClgStageViewPresentor.lua

module("logic.extensions.divinemimengliclg.view.DivineMiMengLiClgStageViewPresentor", package.seeall)

local DivineMiMengLiClgStageViewPresentor = class("DivineMiMengLiClgStageViewPresentor", ViewPresentor)

function DivineMiMengLiClgStageViewPresentor:ctor()
	DivineMiMengLiClgStageViewPresentor.super.ctor(self)
end

function DivineMiMengLiClgStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineMiMengLiClgStageViewPresentor:dependWhatResources()
	return {
		"ui/views/divinemimengliclg/divinemimengliclgstageview.prefab"
	}
end

function DivineMiMengLiClgStageViewPresentor:buildViews()
	return {
		DivineMiMengLiClgStageView.New()
	}
end

return DivineMiMengLiClgStageViewPresentor
