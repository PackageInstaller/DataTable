-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2023/main/YearCardLottery2023ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2023.main.YearCardLottery2023ViewPresentor", package.seeall)

local YearCardLottery2023ViewPresentor = class("YearCardLottery2023ViewPresentor", ViewPresentor)

function YearCardLottery2023ViewPresentor:ctor()
	YearCardLottery2023ViewPresentor.super.ctor(self)
end

function YearCardLottery2023ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardLottery2023ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2023/main/yearcardlottery2023view.prefab"
	}
end

function YearCardLottery2023ViewPresentor:buildViews()
	return {
		YearCardLottery2023View.New()
	}
end

return YearCardLottery2023ViewPresentor
