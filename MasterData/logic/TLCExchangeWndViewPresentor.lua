-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/TLCExchangeWndViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.TLCExchangeWndViewPresentor", package.seeall)

local TLCExchangeWndViewPresentor = class("TLCExchangeWndViewPresentor", ViewPresentor)

function TLCExchangeWndViewPresentor:ctor()
	TLCExchangeWndViewPresentor.super.ctor(self)
end

function TLCExchangeWndViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function TLCExchangeWndViewPresentor:dependWhatResources()
	return {
		"ui/views/activityshop/activityshopexchangebuyview.prefab"
	}
end

function TLCExchangeWndViewPresentor:buildViews()
	return {
		TLCExchangeWndView.New()
	}
end

return TLCExchangeWndViewPresentor
