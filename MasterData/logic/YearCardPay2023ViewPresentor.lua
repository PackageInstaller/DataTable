-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2023/main/YearCardPay2023ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2023.main.YearCardPay2023ViewPresentor", package.seeall)

local YearCardPay2023ViewPresentor = class("YearCardPay2023ViewPresentor", ViewPresentor)

function YearCardPay2023ViewPresentor:ctor()
	YearCardPay2023ViewPresentor.super.ctor(self)
end

function YearCardPay2023ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YearCardPay2023ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2023/main/yearcardpay2023view.prefab"
	}
end

function YearCardPay2023ViewPresentor:buildViews()
	return {
		YearCardPay2023View.New()
	}
end

return YearCardPay2023ViewPresentor
