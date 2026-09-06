-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/famehall/view/FameHallTabBaseViewPresentor.lua

module("logic.extensions.famehall.view.FameHallTabBaseViewPresentor", package.seeall)

local FameHallTabBaseViewPresentor = class("FameHallTabBaseViewPresentor", ViewPresentor)

function FameHallTabBaseViewPresentor:ctor()
	FameHallTabBaseViewPresentor.super.ctor(self)
end

function FameHallTabBaseViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FameHallTabBaseViewPresentor:dependWhatResources()
	return {
		"ui/views/famehall/famehalltabbaseview.prefab"
	}
end

function FameHallTabBaseViewPresentor:buildViews()
	return {
		FameHallTabBaseView.New()
	}
end

function FameHallTabBaseViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return FameHallTabBaseViewPresentor
