-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/parallelkingdragon/view/ParallelkingdragonextViewPresentor.lua

module("logic.extensions.parallelkingdragon.view.ParallelkingdragonextViewPresentor", package.seeall)

local ParallelkingdragonextViewPresentor = class("ParallelkingdragonextViewPresentor", ViewPresentor)

function ParallelkingdragonextViewPresentor:ctor()
	ParallelkingdragonextViewPresentor.super.ctor(self)
end

function ParallelkingdragonextViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ParallelkingdragonextViewPresentor:dependWhatResources()
	return {
		"ui/views/parallelkingdragon/parallelkingdragonextview.prefab"
	}
end

function ParallelkingdragonextViewPresentor:buildViews()
	return {
		ParallelkingdragonextView.New()
	}
end

return ParallelkingdragonextViewPresentor
