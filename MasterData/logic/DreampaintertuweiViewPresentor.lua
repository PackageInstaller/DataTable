-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreampainter/view/DreampaintertuweiViewPresentor.lua

module("logic.extensions.dreampainter.view.DreampaintertuweiViewPresentor", package.seeall)

local DreampaintertuweiViewPresentor = class("DreampaintertuweiViewPresentor", ViewPresentor)

function DreampaintertuweiViewPresentor:ctor()
	DreampaintertuweiViewPresentor.super.ctor(self)
end

function DreampaintertuweiViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DreampaintertuweiViewPresentor:dependWhatResources()
	return {
		"ui/views/dreampainter/dreampaintertuweiview.prefab"
	}
end

function DreampaintertuweiViewPresentor:buildViews()
	return {
		DreampaintertuweiView.New()
	}
end

function DreampaintertuweiViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return DreampaintertuweiViewPresentor
