-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2023/main/YearCardRank2023ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2023.main.YearCardRank2023ViewPresentor", package.seeall)

local YearCardRank2023ViewPresentor = class("YearCardRank2023ViewPresentor", ViewPresentor)

function YearCardRank2023ViewPresentor:ctor()
	YearCardRank2023ViewPresentor.super.ctor(self)
end

function YearCardRank2023ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardRank2023ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2023/main/yearcardrank2023view.prefab"
	}
end

function YearCardRank2023ViewPresentor:buildViews()
	return {
		YearCardRank2023View.New()
	}
end

return YearCardRank2023ViewPresentor
