-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/rank/PetrankprizeViewPresentor.lua

module("logic.extensions.handbook.view.rank.PetrankprizeViewPresentor", package.seeall)

local PetrankprizeViewPresentor = class("PetrankprizeViewPresentor", ViewPresentor)

function PetrankprizeViewPresentor:ctor()
	PetrankprizeViewPresentor.super.ctor(self)
end

function PetrankprizeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetrankprizeViewPresentor:dependWhatResources()
	return {
		"ui/views/handbook/petrankprizeview.prefab"
	}
end

function PetrankprizeViewPresentor:buildViews()
	return {
		PetRankPrizeView.New()
	}
end

return PetrankprizeViewPresentor
