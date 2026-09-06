-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/partysummary/view/PartyFoodPrizeViewPresentor.lua

module("logic.extensions.partysummary.view.PartyFoodPrizeViewPresentor", package.seeall)

local PartyFoodPrizeViewPresentor = class("PartyFoodPrizeViewPresentor", ViewWithGuidePresentor)

function PartyFoodPrizeViewPresentor:ctor()
	PartyFoodPrizeViewPresentor.super.ctor(self)
end

function PartyFoodPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PartyFoodPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/partysummary/partyfoodprizeview.prefab"
	}
end

function PartyFoodPrizeViewPresentor:buildViews()
	return {
		PartyFoodPrizeView.New()
	}
end

return PartyFoodPrizeViewPresentor
