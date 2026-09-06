-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firstannualwelfare/view/exchange/ExchangeWorkshopViewPresentor.lua

module("logic.extensions.firstannualwelfare.exchange.view.ExchangeWorkshopViewPresentor", package.seeall)

local ExchangeWorkshopViewPresentor = class("ExchangeWorkshopViewPresentor", ViewPresentor)

function ExchangeWorkshopViewPresentor:ctor()
	ExchangeWorkshopViewPresentor.super.ctor(self)
end

function ExchangeWorkshopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExchangeWorkshopViewPresentor:dependWhatResources()
	return {
		"ui/views/firstannualwelfare/exchange/exchangeworkshopview.prefab"
	}
end

function ExchangeWorkshopViewPresentor:buildViews()
	return {
		ExchangeWorkshopView.New()
	}
end

return ExchangeWorkshopViewPresentor
