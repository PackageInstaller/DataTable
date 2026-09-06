-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/parallelkingdragon/view/ParallelkingdragonresultViewPresentor.lua

module("logic.extensions.parallelkingdragon.view.ParallelkingdragonresultViewPresentor", package.seeall)

local ParallelkingdragonresultViewPresentor = class("ParallelkingdragonresultViewPresentor", ViewPresentor)

function ParallelkingdragonresultViewPresentor:ctor()
	ParallelkingdragonresultViewPresentor.super.ctor(self)
end

function ParallelkingdragonresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ParallelkingdragonresultViewPresentor:dependWhatResources()
	return {
		"ui/views/parallelkingdragon/parallelkingdragonresultview.prefab"
	}
end

function ParallelkingdragonresultViewPresentor:buildViews()
	return {
		ParallelkingdragonresultView.New()
	}
end

return ParallelkingdragonresultViewPresentor
