-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemimengliclg/view/DivineMiMengLiClgStageThreeExViewPresentor.lua

module("logic.extensions.divinemimengliclg.view.DivineMiMengLiClgStageThreeExViewPresentor", package.seeall)

local DivineMiMengLiClgStageThreeExViewPresentor = class("DivineMiMengLiClgStageThreeExViewPresentor", ViewPresentor)

function DivineMiMengLiClgStageThreeExViewPresentor:ctor()
	DivineMiMengLiClgStageThreeExViewPresentor.super.ctor(self)
end

function DivineMiMengLiClgStageThreeExViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineMiMengLiClgStageThreeExViewPresentor:dependWhatResources()
	return {
		"ui/views/divinemimengliclg/divinemimengliclgstagethreeexview.prefab"
	}
end

function DivineMiMengLiClgStageThreeExViewPresentor:buildViews()
	return {
		DivineMiMengLiClgStageThreeExView.New()
	}
end

function DivineMiMengLiClgStageThreeExViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return DivineMiMengLiClgStageThreeExViewPresentor
