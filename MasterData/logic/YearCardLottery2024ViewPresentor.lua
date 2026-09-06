-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2024/main/YearCardLottery2024ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2024.main.YearCardLottery2024ViewPresentor", package.seeall)

local YearCardLottery2024ViewPresentor = class("YearCardLottery2024ViewPresentor", ViewPresentor)

function YearCardLottery2024ViewPresentor:ctor()
	YearCardLottery2024ViewPresentor.super.ctor(self)
end

function YearCardLottery2024ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardLottery2024ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2024/main/yearcardlottery2024view.prefab"
	}
end

function YearCardLottery2024ViewPresentor:buildViews()
	return {
		YearCardLottery2024View.New()
	}
end

return YearCardLottery2024ViewPresentor
