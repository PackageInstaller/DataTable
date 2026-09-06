-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/view/tab/fuyao/FuYaoTaskChildViewPresentor.lua

module("logic.extensions.eventtasksummary.view.tab.fuyao.FuYaoTaskChildViewPresentor", package.seeall)

local FuYaoTaskChildViewPresentor = class("FuYaoTaskChildViewPresentor", ViewPresentor)

function FuYaoTaskChildViewPresentor:ctor()
	FuYaoTaskChildViewPresentor.super.ctor(self)
end

function FuYaoTaskChildViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FuYaoTaskChildViewPresentor:dependWhatResources()
	return {
		"ui/views/eventtasksummary/fuyao/fuyaotaskchildview.prefab"
	}
end

function FuYaoTaskChildViewPresentor:buildViews()
	return {
		FuYaoTaskChildView.New()
	}
end

function FuYaoTaskChildViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return FuYaoTaskChildViewPresentor
