-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/festiveflower/view/FestiveflowerrankprizeViewPresentor.lua

module("logic.extensions.festiveflower.view.FestiveflowerrankprizeViewPresentor", package.seeall)

local FestiveflowerrankprizeViewPresentor = class("FestiveflowerrankprizeViewPresentor", ViewPresentor)

function FestiveflowerrankprizeViewPresentor:ctor()
	FestiveflowerrankprizeViewPresentor.super.ctor(self)
end

function FestiveflowerrankprizeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FestiveflowerrankprizeViewPresentor:dependWhatResources()
	return {
		"ui/views/festiveflower/festiveflowerrankprizeview.prefab"
	}
end

function FestiveflowerrankprizeViewPresentor:buildViews()
	return {
		FestiveFlowerRankPrizeView.New()
	}
end

return FestiveflowerrankprizeViewPresentor
