-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youngchampionking/view/YoungChampionKingKnockoutMainViewPresentor.lua

module("logic.extensions.youngchampionking.view.YoungChampionKingKnockoutMainViewPresentor", package.seeall)

local YoungChampionKingKnockoutMainViewPresentor = class("YoungChampionKingKnockoutMainViewPresentor", ViewPresentor)

function YoungChampionKingKnockoutMainViewPresentor:ctor()
	YoungChampionKingKnockoutMainViewPresentor.super.ctor(self)
end

function YoungChampionKingKnockoutMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YoungChampionKingKnockoutMainViewPresentor:dependWhatResources()
	return {
		"ui/views/youngchampionking/youngchampionkingknockoutmainview.prefab"
	}
end

function YoungChampionKingKnockoutMainViewPresentor:buildViews()
	return {
		YoungChampionKingKnockoutMainView.New()
	}
end

function YoungChampionKingKnockoutMainViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return YoungChampionKingKnockoutMainViewPresentor
