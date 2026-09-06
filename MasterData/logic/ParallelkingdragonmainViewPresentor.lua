-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/parallelkingdragon/view/ParallelkingdragonmainViewPresentor.lua

module("logic.extensions.parallelkingdragon.view.ParallelkingdragonmainViewPresentor", package.seeall)

local ParallelkingdragonmainViewPresentor = class("ParallelkingdragonmainViewPresentor", ViewPresentor)

function ParallelkingdragonmainViewPresentor:ctor()
	ParallelkingdragonmainViewPresentor.super.ctor(self)
end

function ParallelkingdragonmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ParallelkingdragonmainViewPresentor:dependWhatResources()
	return {
		"ui/views/parallelkingdragon/parallelkingdragonmainview.prefab"
	}
end

function ParallelkingdragonmainViewPresentor:buildViews()
	return {
		ParallelkingdragonmainView.New()
	}
end

return ParallelkingdragonmainViewPresentor
