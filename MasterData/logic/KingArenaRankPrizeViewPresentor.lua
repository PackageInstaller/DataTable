-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingarena/view/prize/KingArenaRankPrizeViewPresentor.lua

module("logic.extensions.kingarena.view.prize.KingArenaRankPrizeViewPresentor", package.seeall)

local KingArenaRankPrizeViewPresentor = class("KingArenaRankPrizeViewPresentor", ViewPresentor)

function KingArenaRankPrizeViewPresentor:ctor()
	KingArenaRankPrizeViewPresentor.super.ctor(self)
end

function KingArenaRankPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function KingArenaRankPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/kingarena/prize/kingarenarankprizeview.prefab"
	}
end

function KingArenaRankPrizeViewPresentor:buildViews()
	return {
		KingArenaRankPrizeView.New()
	}
end

function KingArenaRankPrizeViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return KingArenaRankPrizeViewPresentor
