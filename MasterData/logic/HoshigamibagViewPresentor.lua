-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hoshigami/view/HoshigamibagViewPresentor.lua

module("logic.extensions.hoshigami.view.HoshigamibagViewPresentor", package.seeall)

local HoshigamibagViewPresentor = class("HoshigamibagViewPresentor", ViewPresentor)

function HoshigamibagViewPresentor:ctor()
	HoshigamibagViewPresentor.super.ctor(self)
end

function HoshigamibagViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HoshigamibagViewPresentor:dependWhatResources()
	return {
		"ui/views/hoshigami/hoshigamibagview.prefab"
	}
end

function HoshigamibagViewPresentor:buildViews()
	return {
		HoshigamibagView.New()
	}
end

function HoshigamibagViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return HoshigamibagViewPresentor
