-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scratch/view/ScratchTaskViewPresentor.lua

module("logic.extensions.scratch.view.ScratchTaskViewPresentor", package.seeall)

local ScratchTaskViewPresentor = class("ScratchTaskViewPresentor", ViewPresentor)

function ScratchTaskViewPresentor:ctor()
	ScratchTaskViewPresentor.super.ctor(self)
end

function ScratchTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ScratchTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/scratch/scratchtaskview.prefab"
	}
end

function ScratchTaskViewPresentor:buildViews()
	return {
		ScratchTaskView.New()
	}
end

return ScratchTaskViewPresentor
