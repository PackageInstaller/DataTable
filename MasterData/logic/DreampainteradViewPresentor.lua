-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreampainter/view/DreampainteradViewPresentor.lua

module("logic.extensions.dreampainter.view.DreampainteradViewPresentor", package.seeall)

local DreampainteradViewPresentor = class("DreampainteradViewPresentor", ViewPresentor)

function DreampainteradViewPresentor:ctor()
	DreampainteradViewPresentor.super.ctor(self)
end

function DreampainteradViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DreampainteradViewPresentor:dependWhatResources()
	return {
		"ui/views/dreampainter/dreampainteradview.prefab"
	}
end

function DreampainteradViewPresentor:buildViews()
	return {
		DreampainteradView.New()
	}
end

function DreampainteradViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return DreampainteradViewPresentor
