-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2024/main/YearCardSpaceProgress2024ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2024.main.YearCardSpaceProgress2024ViewPresentor", package.seeall)

local YearCardSpaceProgress2024ViewPresentor = class("YearCardSpaceProgress2024ViewPresentor", ViewPresentor)

function YearCardSpaceProgress2024ViewPresentor:ctor()
	YearCardSpaceProgress2024ViewPresentor.super.ctor(self)
end

function YearCardSpaceProgress2024ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardSpaceProgress2024ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2024/main/yearcardspaceprogress2024view.prefab"
	}
end

function YearCardSpaceProgress2024ViewPresentor:buildViews()
	return {
		YearCardSpaceProgress2024View.New()
	}
end

return YearCardSpaceProgress2024ViewPresentor
