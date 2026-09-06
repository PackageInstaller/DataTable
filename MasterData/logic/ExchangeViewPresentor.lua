-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exchange/view/ExchangeViewPresentor.lua

module("logic.extensions.exchange.view.ExchangeViewPresentor", package.seeall)

local ExchangeViewPresentor = class("ExchangeViewPresentor", ViewPresentor)

function ExchangeViewPresentor:ctor()
	ExchangeViewPresentor.super.ctor(self)
end

function ExchangeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExchangeViewPresentor:dependWhatResources()
	return {
		"ui/views/exchange/exchangeview.prefab"
	}
end

function ExchangeViewPresentor:buildViews()
	return {
		ExchangeView.New()
	}
end

return ExchangeViewPresentor
