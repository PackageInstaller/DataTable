-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemimengliclg/view/DivineMiMengLiClgStageDebuffViewPresentor.lua

module("logic.extensions.divinemimengliclg.view.DivineMiMengLiClgStageDebuffViewPresentor", package.seeall)

local DivineMiMengLiClgStageDebuffViewPresentor = class("DivineMiMengLiClgStageDebuffViewPresentor", ViewPresentor)

function DivineMiMengLiClgStageDebuffViewPresentor:ctor()
	DivineMiMengLiClgStageDebuffViewPresentor.super.ctor(self)
end

function DivineMiMengLiClgStageDebuffViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DivineMiMengLiClgStageDebuffViewPresentor:dependWhatResources()
	return {
		"ui/views/divinemimengliclg/divinemimengliclgstagedebuffview.prefab"
	}
end

function DivineMiMengLiClgStageDebuffViewPresentor:buildViews()
	return {
		DivineMiMengLiClgStageDebuffView.New()
	}
end

return DivineMiMengLiClgStageDebuffViewPresentor
