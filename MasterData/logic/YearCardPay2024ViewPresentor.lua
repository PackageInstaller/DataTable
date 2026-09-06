-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2024/main/YearCardPay2024ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2024.main.YearCardPay2024ViewPresentor", package.seeall)

local YearCardPay2024ViewPresentor = class("YearCardPay2024ViewPresentor", ViewPresentor)

function YearCardPay2024ViewPresentor:ctor()
	YearCardPay2024ViewPresentor.super.ctor(self)
end

function YearCardPay2024ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardPay2024ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2024/main/yearcardpay2024view.prefab"
	}
end

function YearCardPay2024ViewPresentor:buildViews()
	return {
		YearCardPay2024View.New()
	}
end

return YearCardPay2024ViewPresentor
