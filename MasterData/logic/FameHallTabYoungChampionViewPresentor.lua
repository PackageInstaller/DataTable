-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/famehall/view/tab/FameHallTabYoungChampionViewPresentor.lua

module("logic.extensions.famehall.view.tab.FameHallTabYoungChampionViewPresentor", package.seeall)

local FameHallTabYoungChampionViewPresentor = class("FameHallTabYoungChampionViewPresentor", ViewPresentor)

function FameHallTabYoungChampionViewPresentor:ctor()
	FameHallTabYoungChampionViewPresentor.super.ctor(self)
end

function FameHallTabYoungChampionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FameHallTabYoungChampionViewPresentor:dependWhatResources()
	return {
		"ui/views/famehall/famehalltabbaseview.prefab"
	}
end

function FameHallTabYoungChampionViewPresentor:buildViews()
	return {
		FameHallTabYoungChampionView.New()
	}
end

function FameHallTabYoungChampionViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return FameHallTabYoungChampionViewPresentor
