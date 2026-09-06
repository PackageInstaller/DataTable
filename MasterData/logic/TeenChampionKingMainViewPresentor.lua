-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TeenChampionKingMainViewPresentor.lua

module("logic.extensions.teenchampionking.view.TeenChampionKingMainViewPresentor", package.seeall)

local TeenChampionKingMainViewPresentor = class("TeenChampionKingMainViewPresentor", ViewPresentor)

function TeenChampionKingMainViewPresentor:ctor()
	TeenChampionKingMainViewPresentor.super.ctor(self)
end

function TeenChampionKingMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TeenChampionKingMainViewPresentor:dependWhatResources()
	return {
		"ui/views/teenchampionking/teenchampionkingmainview.prefab"
	}
end

function TeenChampionKingMainViewPresentor:buildViews()
	return {
		TeenChampionKingMainView.New()
	}
end

function TeenChampionKingMainViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return TeenChampionKingMainViewPresentor
