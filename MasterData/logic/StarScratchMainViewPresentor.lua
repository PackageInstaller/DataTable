-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starscratch/view/StarScratchMainViewPresentor.lua

module("logic.extensions.starscratch.view.StarScratchMainViewPresentor", package.seeall)

local StarScratchMainViewPresentor = class("StarScratchMainViewPresentor", ViewPresentor)

function StarScratchMainViewPresentor:ctor()
	StarScratchMainViewPresentor.super.ctor(self)
end

function StarScratchMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StarScratchMainViewPresentor:dependWhatResources()
	return {
		"ui/views/starscratch/starscratchmainview.prefab"
	}
end

function StarScratchMainViewPresentor:buildViews()
	return {
		StarScratchMainView.New()
	}
end

return StarScratchMainViewPresentor
