-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domainadventure/view/DomAdvGlobalPrizeViewPresentor.lua

module("logic.extensions.domainadventure.view.DomAdvGlobalPrizeViewPresentor", package.seeall)

local DomAdvGlobalPrizeViewPresentor = class("DomAdvGlobalPrizeViewPresentor", ViewPresentor)

function DomAdvGlobalPrizeViewPresentor:ctor()
	DomAdvGlobalPrizeViewPresentor.super.ctor(self)
end

function DomAdvGlobalPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DomAdvGlobalPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/domainadventure/domadvglobalprizeview.prefab"
	}
end

function DomAdvGlobalPrizeViewPresentor:buildViews()
	return {
		DomAdvGlobalPrizeView.New()
	}
end

return DomAdvGlobalPrizeViewPresentor
