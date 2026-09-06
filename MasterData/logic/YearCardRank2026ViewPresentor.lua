-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2026/main/YearCardRank2026ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2026.main.YearCardRank2026ViewPresentor", package.seeall)

local YearCardRank2026ViewPresentor = class("YearCardRank2026ViewPresentor", ViewPresentor)

function YearCardRank2026ViewPresentor:ctor()
	YearCardRank2026ViewPresentor.super.ctor(self)
end

function YearCardRank2026ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardRank2026ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2026/main/yearcardrank2026view.prefab"
	}
end

function YearCardRank2026ViewPresentor:buildViews()
	return {
		YearCardRank2026View.New()
	}
end

return YearCardRank2026ViewPresentor
