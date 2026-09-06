-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2026/main/YearCardLottery2026ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2026.main.YearCardLottery2026ViewPresentor", package.seeall)

local YearCardLottery2026ViewPresentor = class("YearCardLottery2026ViewPresentor", ViewPresentor)

function YearCardLottery2026ViewPresentor:ctor()
	YearCardLottery2026ViewPresentor.super.ctor(self)
end

function YearCardLottery2026ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardLottery2026ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2026/main/yearcardlottery2026view.prefab"
	}
end

function YearCardLottery2026ViewPresentor:buildViews()
	return {
		YearCardLottery2026View.New()
	}
end

return YearCardLottery2026ViewPresentor
