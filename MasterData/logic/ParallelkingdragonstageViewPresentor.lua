-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/parallelkingdragon/view/ParallelkingdragonstageViewPresentor.lua

module("logic.extensions.parallelkingdragon.view.ParallelkingdragonstageViewPresentor", package.seeall)

local ParallelkingdragonstageViewPresentor = class("ParallelkingdragonstageViewPresentor", ViewPresentor)

function ParallelkingdragonstageViewPresentor:ctor()
	ParallelkingdragonstageViewPresentor.super.ctor(self)
end

function ParallelkingdragonstageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ParallelkingdragonstageViewPresentor:dependWhatResources()
	return {
		"ui/views/parallelkingdragon/parallelkingdragonstageview.prefab"
	}
end

function ParallelkingdragonstageViewPresentor:buildViews()
	return {
		ParallelkingdragonstageView.New()
	}
end

return ParallelkingdragonstageViewPresentor
