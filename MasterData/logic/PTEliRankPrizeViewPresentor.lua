-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/eliminator/PTEliRankPrizeViewPresentor.lua

module("logic.extensions.peaktournament.view.eliminator.PTEliRankPrizeViewPresentor", package.seeall)

local PTEliRankPrizeViewPresentor = class("PTEliRankPrizeViewPresentor", ViewPresentor)

function PTEliRankPrizeViewPresentor:ctor()
	PTEliRankPrizeViewPresentor.super.ctor(self)
end

function PTEliRankPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PTEliRankPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/peak/eliminator/ptelirankprizeview.prefab"
	}
end

function PTEliRankPrizeViewPresentor:buildViews()
	return {
		PTEliRankPrizeView.New()
	}
end

return PTEliRankPrizeViewPresentor
