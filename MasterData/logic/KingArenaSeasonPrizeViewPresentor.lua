-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingarena/view/prize/KingArenaSeasonPrizeViewPresentor.lua

module("logic.extensions.kingarena.view.prize.KingArenaSeasonPrizeViewPresentor", package.seeall)

local KingArenaSeasonPrizeViewPresentor = class("KingArenaSeasonPrizeViewPresentor", ViewPresentor)

function KingArenaSeasonPrizeViewPresentor:ctor()
	KingArenaSeasonPrizeViewPresentor.super.ctor(self)
end

function KingArenaSeasonPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function KingArenaSeasonPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/kingarena/prize/kingarenaseasonprizeview.prefab"
	}
end

function KingArenaSeasonPrizeViewPresentor:buildViews()
	return {
		KingArenaSeasonPrizeView.New()
	}
end

function KingArenaSeasonPrizeViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return KingArenaSeasonPrizeViewPresentor
