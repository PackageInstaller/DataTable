-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firstannualwelfare/view/exchange/ExchangeSelectViewPresentor.lua

module("logic.extensions.firstannualwelfare.exchange.view.ExchangeSelectViewPresentor", package.seeall)

local ExchangeSelectViewPresentor = class("ExchangeSelectViewPresentor", ViewPresentor)

function ExchangeSelectViewPresentor:ctor()
	ExchangeSelectViewPresentor.super.ctor(self)
end

function ExchangeSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExchangeSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/firstannualwelfare/exchange/exchangeselectview.prefab"
	}
end

function ExchangeSelectViewPresentor:buildViews()
	return {
		ExchangeSelectView.New()
	}
end

return ExchangeSelectViewPresentor
