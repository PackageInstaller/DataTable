-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreampainter/view/DreampainterprizeViewPresentor.lua

module("logic.extensions.dreampainter.view.DreampainterprizeViewPresentor", package.seeall)

local DreampainterprizeViewPresentor = class("DreampainterprizeViewPresentor", ViewPresentor)

function DreampainterprizeViewPresentor:ctor()
	DreampainterprizeViewPresentor.super.ctor(self)
end

function DreampainterprizeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DreampainterprizeViewPresentor:dependWhatResources()
	return {
		"ui/views/dreampainter/dreampainterprizeview.prefab"
	}
end

function DreampainterprizeViewPresentor:buildViews()
	return {
		DreampainterprizeView.New()
	}
end

function DreampainterprizeViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return DreampainterprizeViewPresentor
