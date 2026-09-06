-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2026/main/YearCardSpaceProgress2026ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2026.main.YearCardSpaceProgress2026ViewPresentor", package.seeall)

local YearCardSpaceProgress2026ViewPresentor = class("YearCardSpaceProgress2026ViewPresentor", ViewPresentor)

function YearCardSpaceProgress2026ViewPresentor:ctor()
	YearCardSpaceProgress2026ViewPresentor.super.ctor(self)
end

function YearCardSpaceProgress2026ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardSpaceProgress2026ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2026/main/yearcardspaceprogress2026view.prefab"
	}
end

function YearCardSpaceProgress2026ViewPresentor:buildViews()
	return {
		YearCardSpaceProgress2026View.New()
	}
end

return YearCardSpaceProgress2026ViewPresentor
