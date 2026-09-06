-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/famehall/view/tab/FameHallTabTourAreaViewPresentor.lua

module("logic.extensions.famehall.view.tab.FameHallTabTourAreaViewPresentor", package.seeall)

local FameHallTabTourAreaViewPresentor = class("FameHallTabTourAreaViewPresentor", ViewPresentor)

function FameHallTabTourAreaViewPresentor:ctor()
	FameHallTabTourAreaViewPresentor.super.ctor(self)
end

function FameHallTabTourAreaViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FameHallTabTourAreaViewPresentor:dependWhatResources()
	return {
		"ui/views/famehall/famehalltabtourareaview.prefab"
	}
end

function FameHallTabTourAreaViewPresentor:buildViews()
	return {
		FameHallTabTourAreaView.New()
	}
end

function FameHallTabTourAreaViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return FameHallTabTourAreaViewPresentor
