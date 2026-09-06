-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2026/main/YearCardPay2026ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2026.main.YearCardPay2026ViewPresentor", package.seeall)

local YearCardPay2026ViewPresentor = class("YearCardPay2026ViewPresentor", ViewPresentor)

function YearCardPay2026ViewPresentor:ctor()
	YearCardPay2026ViewPresentor.super.ctor(self)
end

function YearCardPay2026ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardPay2026ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2026/main/yearcardpay2026view.prefab"
	}
end

function YearCardPay2026ViewPresentor:buildViews()
	return {
		YearCardPay2026View.New()
	}
end

return YearCardPay2026ViewPresentor
