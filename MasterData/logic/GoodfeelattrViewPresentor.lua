-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goodfeel/view/GoodfeelattrViewPresentor.lua

module("logic.extensions.goodfeel.view.GoodfeelattrViewPresentor", package.seeall)

local GoodfeelattrViewPresentor = class("GoodfeelattrViewPresentor", ViewPresentor)

function GoodfeelattrViewPresentor:ctor()
	GoodfeelattrViewPresentor.super.ctor(self)
end

function GoodfeelattrViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoodfeelattrViewPresentor:dependWhatResources()
	return {
		"ui/views/goodfeel/goodfeelattrview.prefab"
	}
end

function GoodfeelattrViewPresentor:buildViews()
	return {
		GoodfeelattrView.New()
	}
end

function GoodfeelattrViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GoodfeelattrViewPresentor
