-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hoshigami/view/HoshigamimainViewPresentor.lua

module("logic.extensions.hoshigami.view.HoshigamimainViewPresentor", package.seeall)

local HoshigamimainViewPresentor = class("HoshigamimainViewPresentor", ViewPresentor)

function HoshigamimainViewPresentor:ctor()
	HoshigamimainViewPresentor.super.ctor(self)
end

function HoshigamimainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HoshigamimainViewPresentor:dependWhatResources()
	return {
		"ui/views/hoshigami/hoshigamimainview.prefab"
	}
end

function HoshigamimainViewPresentor:buildViews()
	return {
		HoshigamimainView.New()
	}
end

function HoshigamimainViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return HoshigamimainViewPresentor
