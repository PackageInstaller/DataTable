-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youngchampionking/view/YoungChampionKingMainViewPresentor.lua

module("logic.extensions.youngchampionking.view.YoungChampionKingMainViewPresentor", package.seeall)

local YoungChampionKingMainViewPresentor = class("YoungChampionKingMainViewPresentor", ViewPresentor)

function YoungChampionKingMainViewPresentor:ctor()
	YoungChampionKingMainViewPresentor.super.ctor(self)
end

function YoungChampionKingMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YoungChampionKingMainViewPresentor:dependWhatResources()
	return {
		"ui/views/youngchampionking/youngchampionkingmainview.prefab"
	}
end

function YoungChampionKingMainViewPresentor:buildViews()
	return {
		YoungChampionKingMainView.New()
	}
end

function YoungChampionKingMainViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return YoungChampionKingMainViewPresentor
