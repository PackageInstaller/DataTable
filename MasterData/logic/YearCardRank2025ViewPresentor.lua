-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2025/main/YearCardRank2025ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2025.main.YearCardRank2025ViewPresentor", package.seeall)

local YearCardRank2025ViewPresentor = class("YearCardRank2025ViewPresentor", ViewPresentor)

function YearCardRank2025ViewPresentor:ctor()
	YearCardRank2025ViewPresentor.super.ctor(self)
end

function YearCardRank2025ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardRank2025ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2025/main/yearcardrank2025view.prefab"
	}
end

function YearCardRank2025ViewPresentor:buildViews()
	return {
		YearCardRank2025View.New()
	}
end

return YearCardRank2025ViewPresentor
