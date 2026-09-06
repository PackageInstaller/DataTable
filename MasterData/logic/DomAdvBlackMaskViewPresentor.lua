-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domainadventure/view/DomAdvBlackMaskViewPresentor.lua

module("logic.extensions.domainadventure.view.DomAdvBlackMaskViewPresentor", package.seeall)

local DomAdvBlackMaskViewPresentor = class("DomAdvBlackMaskViewPresentor", ViewPresentor)

function DomAdvBlackMaskViewPresentor:ctor()
	DomAdvBlackMaskViewPresentor.super.ctor(self)
end

function DomAdvBlackMaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DomAdvBlackMaskViewPresentor:dependWhatResources()
	return {
		"ui/views/domainadventure/domadvblackmaskview.prefab"
	}
end

function DomAdvBlackMaskViewPresentor:buildViews()
	return {
		DomAdvBlackMaskView.New()
	}
end

function DomAdvBlackMaskViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return DomAdvBlackMaskViewPresentor
