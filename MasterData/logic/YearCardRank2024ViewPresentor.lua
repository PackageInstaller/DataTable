-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2024/main/YearCardRank2024ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2024.main.YearCardRank2024ViewPresentor", package.seeall)

local YearCardRank2024ViewPresentor = class("YearCardRank2024ViewPresentor", ViewPresentor)

function YearCardRank2024ViewPresentor:ctor()
	YearCardRank2024ViewPresentor.super.ctor(self)
end

function YearCardRank2024ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardRank2024ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2024/main/yearcardrank2024view.prefab"
	}
end

function YearCardRank2024ViewPresentor:buildViews()
	return {
		YearCardRank2024View.New()
	}
end

return YearCardRank2024ViewPresentor
