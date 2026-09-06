-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starscratch/view/StarScratchTaskViewPresentor.lua

module("logic.extensions.threeelimination.view.StarScratchTaskViewPresentor", package.seeall)

local StarScratchTaskViewPresentor = class("StarScratchTaskViewPresentor", ViewPresentor)

function StarScratchTaskViewPresentor:ctor()
	StarScratchTaskViewPresentor.super.ctor(self)
end

function StarScratchTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StarScratchTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/starscratch/starscratchtaskview.prefab"
	}
end

function StarScratchTaskViewPresentor:buildViews()
	return {
		StarScratchTaskView.New()
	}
end

return StarScratchTaskViewPresentor
