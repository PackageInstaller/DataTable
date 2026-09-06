-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2025/main/YearCardLottery2025ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2025.main.YearCardLottery2025ViewPresentor", package.seeall)

local YearCardLottery2025ViewPresentor = class("YearCardLottery2025ViewPresentor", ViewPresentor)

function YearCardLottery2025ViewPresentor:ctor()
	YearCardLottery2025ViewPresentor.super.ctor(self)
end

function YearCardLottery2025ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardLottery2025ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2025/main/yearcardlottery2025view.prefab"
	}
end

function YearCardLottery2025ViewPresentor:buildViews()
	return {
		YearCardLottery2025View.New()
	}
end

return YearCardLottery2025ViewPresentor
