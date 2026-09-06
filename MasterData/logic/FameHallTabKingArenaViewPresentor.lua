-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/famehall/view/tab/FameHallTabKingArenaViewPresentor.lua

module("logic.extensions.famehall.view.tab.FameHallTabKingArenaViewPresentor", package.seeall)

local FameHallTabKingArenaViewPresentor = class("FameHallTabKingArenaViewPresentor", ViewPresentor)

function FameHallTabKingArenaViewPresentor:ctor()
	FameHallTabKingArenaViewPresentor.super.ctor(self)
end

function FameHallTabKingArenaViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FameHallTabKingArenaViewPresentor:dependWhatResources()
	return {
		"ui/views/famehall/famehalltabkingarenaview.prefab"
	}
end

function FameHallTabKingArenaViewPresentor:buildViews()
	return {
		FameHallTabKingArenaView.New()
	}
end

function FameHallTabKingArenaViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return FameHallTabKingArenaViewPresentor
