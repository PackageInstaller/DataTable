-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domainadventure/view/DomAdvNormalEventPrizeViewPresentor.lua

module("logic.extensions.domainadventure.view.DomAdvNormalEventPrizeViewPresentor", package.seeall)

local DomAdvNormalEventPrizeViewPresentor = class("DomAdvNormalEventPrizeViewPresentor", ViewPresentor)

function DomAdvNormalEventPrizeViewPresentor:ctor()
	DomAdvNormalEventPrizeViewPresentor.super.ctor(self)
end

function DomAdvNormalEventPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DomAdvNormalEventPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/domainadventure/domadvnormaleventprizeview.prefab"
	}
end

function DomAdvNormalEventPrizeViewPresentor:buildViews()
	return {
		DomAdvNormalEventPrizeView.New()
	}
end

return DomAdvNormalEventPrizeViewPresentor
