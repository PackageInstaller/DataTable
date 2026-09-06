-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/YearCard2022/YearCardPay2022ViewPresentor.lua

module("logic.extensions.yearcard.view.2022.YearCardPay2022ViewPresentor", package.seeall)

local YearCardPay2022ViewPresentor = class("YearCardPay2022ViewPresentor", ViewPresentor)

function YearCardPay2022ViewPresentor:ctor()
	YearCardPay2022ViewPresentor.super.ctor(self)
end

function YearCardPay2022ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardPay2022ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2022/yearcardpay2022view.prefab"
	}
end

function YearCardPay2022ViewPresentor:buildViews()
	return {
		YearCardPay2022View.New()
	}
end

return YearCardPay2022ViewPresentor
