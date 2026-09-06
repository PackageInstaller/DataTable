-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/picturepuzzle/view/PicturepuzzlemainViewPresentor.lua

module("logic.extensions.picturepuzzle.view.PicturepuzzlemainViewPresentor", package.seeall)

local PicturepuzzlemainViewPresentor = class("PicturepuzzlemainViewPresentor", ViewPresentor)

function PicturepuzzlemainViewPresentor:ctor()
	PicturepuzzlemainViewPresentor.super.ctor(self)
end

function PicturepuzzlemainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PicturepuzzlemainViewPresentor:dependWhatResources()
	return {
		"ui/views/picturepuzzle/picturepuzzlemainview.prefab"
	}
end

function PicturepuzzlemainViewPresentor:buildViews()
	return {
		PicturepuzzlemainView.New()
	}
end

return PicturepuzzlemainViewPresentor
