-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2025/main/YearCardSpaceProgress2025ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2025.main.YearCardSpaceProgress2025ViewPresentor", package.seeall)

local YearCardSpaceProgress2025ViewPresentor = class("YearCardSpaceProgress2025ViewPresentor", ViewPresentor)

function YearCardSpaceProgress2025ViewPresentor:ctor()
	YearCardSpaceProgress2025ViewPresentor.super.ctor(self)
end

function YearCardSpaceProgress2025ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardSpaceProgress2025ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2025/main/yearcardspaceprogress2025view.prefab"
	}
end

function YearCardSpaceProgress2025ViewPresentor:buildViews()
	return {
		YearCardSpaceProgress2025View.New()
	}
end

return YearCardSpaceProgress2025ViewPresentor
