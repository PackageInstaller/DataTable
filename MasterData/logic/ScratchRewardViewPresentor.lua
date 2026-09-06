-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scratch/view/ScratchRewardViewPresentor.lua

module("logic.extensions.scratch.view.ScratchRewardViewPresentor", package.seeall)

local ScratchRewardViewPresentor = class("ScratchRewardViewPresentor", ViewPresentor)

function ScratchRewardViewPresentor:ctor()
	ScratchRewardViewPresentor.super.ctor(self)
end

function ScratchRewardViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ScratchRewardViewPresentor:dependWhatResources()
	return {
		"ui/views/scratch/scratchrewardview.prefab"
	}
end

function ScratchRewardViewPresentor:buildViews()
	return {
		ScratchRewardView.New()
	}
end

return ScratchRewardViewPresentor
