-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreampainter/view/DreampainterRankViewPresentor.lua

module("logic.extensions.dreampainter.view.DreampainterRankViewPresentor", package.seeall)

local DreampainterRankViewPresentor = class("DreampainterRankViewPresentor", ViewPresentor)

function DreampainterRankViewPresentor:ctor()
	DreampainterRankViewPresentor.super.ctor(self)
end

function DreampainterRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DreampainterRankViewPresentor:dependWhatResources()
	return {
		"ui/views/dreampainter/dreampaintertuweiview.prefab"
	}
end

function DreampainterRankViewPresentor:buildViews()
	return {
		DreampainterRankView.New()
	}
end

function DreampainterRankViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return DreampainterRankViewPresentor
