-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemimengliclg/view/DivineMiMengLiClgStageResultViewPresentor.lua

module("logic.extensions.divinemimengliclg.view.DivineMiMengLiClgStageResultViewPresentor", package.seeall)

local DivineMiMengLiClgStageResultViewPresentor = class("DivineMiMengLiClgStageResultViewPresentor", ViewPresentor)

function DivineMiMengLiClgStageResultViewPresentor:ctor()
	DivineMiMengLiClgStageResultViewPresentor.super.ctor(self)
end

function DivineMiMengLiClgStageResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineMiMengLiClgStageResultViewPresentor:dependWhatResources()
	return {
		"ui/views/divinemimengliclg/divinemimengliclgstageresultview.prefab"
	}
end

function DivineMiMengLiClgStageResultViewPresentor:buildViews()
	return {
		DivineMiMengLiClgStageResultView.New()
	}
end

return DivineMiMengLiClgStageResultViewPresentor
