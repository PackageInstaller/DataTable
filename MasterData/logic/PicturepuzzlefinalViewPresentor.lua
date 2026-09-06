-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/picturepuzzle/view/PicturepuzzlefinalViewPresentor.lua

module("logic.extensions.picturepuzzle.view.PicturepuzzlefinalViewPresentor", package.seeall)

local PicturepuzzlefinalViewPresentor = class("PicturepuzzlefinalViewPresentor", ViewPresentor)

function PicturepuzzlefinalViewPresentor:ctor()
	PicturepuzzlefinalViewPresentor.super.ctor(self)
end

function PicturepuzzlefinalViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PicturepuzzlefinalViewPresentor:dependWhatResources()
	return {
		"ui/views/picturepuzzle/picturepuzzlefinalview.prefab"
	}
end

function PicturepuzzlefinalViewPresentor:buildViews()
	return {
		PicturepuzzlefinalView.New()
	}
end

return PicturepuzzlefinalViewPresentor
