-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youngchampionking/view/YoungChampionKingKnockout8playerViewPresentor.lua

module("logic.extensions.youngchampionking.view.YoungChampionKingKnockout8playerViewPresentor", package.seeall)

local YoungChampionKingKnockout8playerViewPresentor = class("YoungChampionKingKnockout8playerViewPresentor", ViewPresentor)

function YoungChampionKingKnockout8playerViewPresentor:ctor()
	YoungChampionKingKnockout8playerViewPresentor.super.ctor(self)
end

function YoungChampionKingKnockout8playerViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YoungChampionKingKnockout8playerViewPresentor:dependWhatResources()
	return {
		"ui/views/youngchampionking/youngchampionkingknockout8playerview.prefab"
	}
end

function YoungChampionKingKnockout8playerViewPresentor:buildViews()
	return {
		YoungChampionKingKnockout8playerView.New()
	}
end

function YoungChampionKingKnockout8playerViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return YoungChampionKingKnockout8playerViewPresentor
