-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreampainter/view/DreampainterDisplayViewPresentor.lua

module("logic.extensions.dreampainter.view.DreampainterDisplayViewPresentor", package.seeall)

local DreampainterDisplayViewPresentor = class("DreampainterDisplayViewPresentor", ViewPresentor)

function DreampainterDisplayViewPresentor:ctor()
	DreampainterDisplayViewPresentor.super.ctor(self)
end

function DreampainterDisplayViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DreampainterDisplayViewPresentor:dependWhatResources()
	return {
		"ui/views/dreampainter/dreampaintertuweiview.prefab"
	}
end

function DreampainterDisplayViewPresentor:buildViews()
	return {
		DreampainterDispalyView.New()
	}
end

function DreampainterDisplayViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return DreampainterDisplayViewPresentor
