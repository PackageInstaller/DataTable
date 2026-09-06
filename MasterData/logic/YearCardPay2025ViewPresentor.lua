-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2025/main/YearCardPay2025ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2025.main.YearCardPay2025ViewPresentor", package.seeall)

local YearCardPay2025ViewPresentor = class("YearCardPay2025ViewPresentor", ViewPresentor)

function YearCardPay2025ViewPresentor:ctor()
	YearCardPay2025ViewPresentor.super.ctor(self)
end

function YearCardPay2025ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardPay2025ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2025/main/yearcardpay2025view.prefab"
	}
end

function YearCardPay2025ViewPresentor:buildViews()
	return {
		YearCardPay2025View.New()
	}
end

return YearCardPay2025ViewPresentor
