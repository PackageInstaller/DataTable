-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/view/GodStatuesWarSeasonPrizeWinTabFamilyScoreViewPresentor.lua

module("logic.extensions.godstatueswar.view.GodStatuesWarSeasonPrizeWinTabFamilyScoreViewPresentor", package.seeall)

local GodStatuesWarSeasonPrizeWinTabFamilyScoreViewPresentor = class("GodStatuesWarSeasonPrizeWinTabFamilyScoreViewPresentor", ViewPresentor)

function GodStatuesWarSeasonPrizeWinTabFamilyScoreViewPresentor:ctor()
	GodStatuesWarSeasonPrizeWinTabFamilyScoreViewPresentor.super.ctor(self)
end

function GodStatuesWarSeasonPrizeWinTabFamilyScoreViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GodStatuesWarSeasonPrizeWinTabFamilyScoreViewPresentor:dependWhatResources()
	return {
		"ui/views/godstatueswar/godstatueswarseasonprizewintabfamilyscoreview.prefab"
	}
end

function GodStatuesWarSeasonPrizeWinTabFamilyScoreViewPresentor:buildViews()
	return {
		GodStatuesWarSeasonPrizeWinTabFamilyScoreView.New()
	}
end

function GodStatuesWarSeasonPrizeWinTabFamilyScoreViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GodStatuesWarSeasonPrizeWinTabFamilyScoreViewPresentor
