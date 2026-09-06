-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/picturepuzzle/view/PicturepuzzleViewPresentor.lua

module("logic.extensions.picturepuzzle.view.PicturepuzzleViewPresentor", package.seeall)

local PicturepuzzleViewPresentor = class("PicturepuzzleViewPresentor", ViewPresentor)

function PicturepuzzleViewPresentor:ctor()
	PicturepuzzleViewPresentor.super.ctor(self)
end

function PicturepuzzleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PicturepuzzleViewPresentor:dependWhatResources()
	return {
		"ui/views/picturepuzzle/picturepuzzleview.prefab"
	}
end

function PicturepuzzleViewPresentor:buildViews()
	return {
		PicturepuzzleView.New()
	}
end

return PicturepuzzleViewPresentor
