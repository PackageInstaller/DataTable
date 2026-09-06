-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cardhot/view/CardhotViewPresentor.lua

module("logic.extensions.cardhot.view.CardhotViewPresentor", package.seeall)

local CardhotViewPresentor = class("CardhotViewPresentor", ViewPresentor)

function CardhotViewPresentor:ctor()
	CardhotViewPresentor.super.ctor(self)
end

function CardhotViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CardhotViewPresentor:dependWhatResources()
	return {
		"ui/views/activity/cardhot/cardhotview.prefab"
	}
end

function CardhotViewPresentor:buildViews()
	return {
		CardhotView.New()
	}
end

return CardhotViewPresentor
