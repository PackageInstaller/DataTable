-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonPassPortBuyViewPresentor.lua

module("logic.extensions.season.view.SeasonPassPortBuyViewPresentor", package.seeall)

local SeasonPassPortBuyViewPresentor = class("SeasonPassPortBuyViewPresentor", ViewPresentor)

function SeasonPassPortBuyViewPresentor:ctor()
	SeasonPassPortBuyViewPresentor.super.ctor(self)
end

function SeasonPassPortBuyViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SeasonPassPortBuyViewPresentor:dependWhatResources()
	return {
		"ui/views/passport/passportbuyview.prefab"
	}
end

function SeasonPassPortBuyViewPresentor:buildViews()
	return {
		SeasonPassPortBuyView.New()
	}
end

return SeasonPassPortBuyViewPresentor
