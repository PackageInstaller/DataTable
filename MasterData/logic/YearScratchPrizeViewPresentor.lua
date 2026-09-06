-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearscratch/view/YearScratchPrizeViewPresentor.lua

module("logic.extensions.yearscratch.view.YearScratchprizeViewPresentor", package.seeall)

local YearScratchprizeViewPresentor = class("YearScratchprizeViewPresentor", ViewPresentor)

function YearScratchprizeViewPresentor:ctor()
	YearScratchprizeViewPresentor.super.ctor(self)
end

function YearScratchprizeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearScratchprizeViewPresentor:dependWhatResources()
	return {
		"ui/views/yearscratch/yearscratchprizeview.prefab"
	}
end

function YearScratchprizeViewPresentor:buildViews()
	return {
		YearScratchPrizeView.New()
	}
end

return YearScratchprizeViewPresentor
