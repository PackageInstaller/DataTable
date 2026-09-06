-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/TLCExchangeViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.TLCExchangeViewPresentor", package.seeall)

local TLCExchangeViewPresentor = class("TLCExchangeViewPresentor", ViewPresentor)

function TLCExchangeViewPresentor:ctor()
	TLCExchangeViewPresentor.super.ctor(self)
end

function TLCExchangeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TLCExchangeViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/tlcexchangeview.prefab"
	}
end

function TLCExchangeViewPresentor:buildViews()
	return {
		TLCExchangeView.New()
	}
end

return TLCExchangeViewPresentor
