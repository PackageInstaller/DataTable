-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youngchampionking/view/YoungChampionKingKnockout4playerViewPresentor.lua

module("logic.extensions.youngchampionking.view.YoungChampionKingKnockout4playerViewPresentor", package.seeall)

local YoungChampionKingKnockout4playerViewPresentor = class("YoungChampionKingKnockout4playerViewPresentor", ViewPresentor)

function YoungChampionKingKnockout4playerViewPresentor:ctor()
	YoungChampionKingKnockout4playerViewPresentor.super.ctor(self)
end

function YoungChampionKingKnockout4playerViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YoungChampionKingKnockout4playerViewPresentor:dependWhatResources()
	return {
		"ui/views/youngchampionking/youngchampionkingknockout4playerview.prefab"
	}
end

function YoungChampionKingKnockout4playerViewPresentor:buildViews()
	return {
		YoungChampionKingKnockout4playerView.New()
	}
end

function YoungChampionKingKnockout4playerViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return YoungChampionKingKnockout4playerViewPresentor
