-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exchange/view/ExchangemainViewPresentor.lua

module("logic.extensions.exchange.view.ExchangemainViewPresentor", package.seeall)

local ExchangemainViewPresentor = class("ExchangemainViewPresentor", ViewPresentor)

function ExchangemainViewPresentor:ctor()
	ExchangemainViewPresentor.super.ctor(self)
end

function ExchangemainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExchangemainViewPresentor:dependWhatResources()
	return {
		"ui/views/exchange/exchangemainview.prefab"
	}
end

function ExchangemainViewPresentor:buildViews()
	return {
		ExchangemainView.New()
	}
end

return ExchangemainViewPresentor
