-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/miya/MiyaChooseDifficultyViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.miya.MiyaChooseDifficultyViewPresentor", package.seeall)

local MiyaChooseDifficultyViewPresentor = class("MiyaChooseDifficultyViewPresentor", ViewPresentor)

function MiyaChooseDifficultyViewPresentor:ctor()
	MiyaChooseDifficultyViewPresentor.super.ctor(self)
end

function MiyaChooseDifficultyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiyaChooseDifficultyViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/miyachoosedifficultyview.prefab"
	}
end

function MiyaChooseDifficultyViewPresentor:buildViews()
	return {
		MiyaChooseDifficultyView.New()
	}
end

return MiyaChooseDifficultyViewPresentor
