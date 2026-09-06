-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/view/OriMatGameSeasonPrizeViewPresentor.lua

module("logic.extensions.orimatgame.view.OriMatGameSeasonPrizeViewPresentor", package.seeall)

local OriMatGameSeasonPrizeViewPresentor = class("OriMatGameSeasonPrizeViewPresentor", ViewPresentor)

function OriMatGameSeasonPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OriMatGameSeasonPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/orimatgame/orimatgameseasonprizeview.prefab"
	}
end

function OriMatGameSeasonPrizeViewPresentor:buildViews()
	return {
		OriMatGameSeasonPrizeView.New()
	}
end

return OriMatGameSeasonPrizeViewPresentor
