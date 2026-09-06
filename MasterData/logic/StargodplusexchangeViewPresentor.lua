-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/StarGodPlusExchange/view/StargodplusexchangeViewPresentor.lua

module("logic.extensions.StarGodPlusExchange.view.StargodplusexchangeViewPresentor", package.seeall)

local StargodplusexchangeViewPresentor = class("StargodplusexchangeViewPresentor", ViewPresentor)

function StargodplusexchangeViewPresentor:ctor()
	StargodplusexchangeViewPresentor.super.ctor(self)
end

function StargodplusexchangeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StargodplusexchangeViewPresentor:dependWhatResources()
	return {
		"ui/views/stargodplusexchange/stargodplusexchange.prefab"
	}
end

function StargodplusexchangeViewPresentor:buildViews()
	return {
		StarGodPlusExchangView.New()
	}
end

return StargodplusexchangeViewPresentor
