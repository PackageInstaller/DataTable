-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/partysummary/view/PartyFoodViewPresentor.lua

module("logic.extensions.partysummary.view.PartyFoodViewPresentor", package.seeall)

local PartyFoodViewPresentor = class("PartyFoodViewPresentor", ViewWithGuidePresentor)

function PartyFoodViewPresentor:ctor()
	PartyFoodViewPresentor.super.ctor(self)
end

function PartyFoodViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PartyFoodViewPresentor:dependWhatResources()
	return {
		"ui/views/partysummary/partyfoodview.prefab"
	}
end

function PartyFoodViewPresentor:buildViews()
	return {
		PartyFoodView.New()
	}
end

return PartyFoodViewPresentor
