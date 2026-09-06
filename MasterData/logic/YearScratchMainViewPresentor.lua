-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearscratch/view/YearScratchMainViewPresentor.lua

module("logic.extensions.yearscratch.view.YearScratchMainViewPresentor", package.seeall)

local YearScratchMainViewPresentor = class("YearScratchMainViewPresentor", ViewPresentor)

function YearScratchMainViewPresentor:ctor()
	YearScratchMainViewPresentor.super.ctor(self)
end

function YearScratchMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearScratchMainViewPresentor:dependWhatResources()
	return {
		"ui/views/yearscratch/yearscratchmainview.prefab"
	}
end

function YearScratchMainViewPresentor:buildViews()
	return {
		YearScratchMainView.New()
	}
end

return YearScratchMainViewPresentor
