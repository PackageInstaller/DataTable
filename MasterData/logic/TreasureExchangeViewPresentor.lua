-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sevendays/view/TreasureExchangeViewPresentor.lua

module("logic.extensions.sevendays.view.TreasureExchangeViewPresentor", package.seeall)

local TreasureExchangeViewPresentor = class("TreasureExchangeViewPresentor", ViewWithGuidePresentor)

function TreasureExchangeViewPresentor:ctor()
	TreasureExchangeViewPresentor.super.ctor(self)
end

function TreasureExchangeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function TreasureExchangeViewPresentor:dependWhatResources()
	return {
		"ui/views/sevendays/treasureexchangeview.prefab"
	}
end

function TreasureExchangeViewPresentor:buildViews()
	return {
		TreasureExchangeView.New()
	}
end

return TreasureExchangeViewPresentor
