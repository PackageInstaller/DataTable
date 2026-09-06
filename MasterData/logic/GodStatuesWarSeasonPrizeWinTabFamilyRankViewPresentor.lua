-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/view/GodStatuesWarSeasonPrizeWinTabFamilyRankViewPresentor.lua

module("logic.extensions.godstatueswar.view.GodStatuesWarSeasonPrizeWinTabFamilyRankViewPresentor", package.seeall)

local GodStatuesWarSeasonPrizeWinTabFamilyRankViewPresentor = class("GodStatuesWarSeasonPrizeWinTabFamilyRankViewPresentor", ViewPresentor)

function GodStatuesWarSeasonPrizeWinTabFamilyRankViewPresentor:ctor()
	GodStatuesWarSeasonPrizeWinTabFamilyRankViewPresentor.super.ctor(self)
end

function GodStatuesWarSeasonPrizeWinTabFamilyRankViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GodStatuesWarSeasonPrizeWinTabFamilyRankViewPresentor:dependWhatResources()
	return {
		"ui/views/godstatueswar/godstatueswarseasonprizewintabfamilyrankview.prefab"
	}
end

function GodStatuesWarSeasonPrizeWinTabFamilyRankViewPresentor:buildViews()
	return {
		GodStatuesWarSeasonPrizeWinTabFamilyRankView.New()
	}
end

function GodStatuesWarSeasonPrizeWinTabFamilyRankViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GodStatuesWarSeasonPrizeWinTabFamilyRankViewPresentor
