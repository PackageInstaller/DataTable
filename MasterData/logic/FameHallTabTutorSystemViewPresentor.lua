-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/famehall/view/tab/FameHallTabTutorSystemViewPresentor.lua

module("logic.extensions.famehall.view.tab.FameHallTabTutorSystemViewPresentor", package.seeall)

local FameHallTabTutorSystemViewPresentor = class("FameHallTabTutorSystemViewPresentor", ViewPresentor)

function FameHallTabTutorSystemViewPresentor:ctor()
	FameHallTabTutorSystemViewPresentor.super.ctor(self)
end

function FameHallTabTutorSystemViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FameHallTabTutorSystemViewPresentor:dependWhatResources()
	return {
		"ui/views/famehall/famehalltabtutorsystemview.prefab"
	}
end

function FameHallTabTutorSystemViewPresentor:buildViews()
	return {
		FameHallTabTutorSystemView.New()
	}
end

function FameHallTabTutorSystemViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return FameHallTabTutorSystemViewPresentor
