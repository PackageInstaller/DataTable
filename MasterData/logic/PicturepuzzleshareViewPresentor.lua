-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/picturepuzzle/view/PicturepuzzleshareViewPresentor.lua

module("logic.extensions.picturepuzzle.view.PicturepuzzleshareViewPresentor", package.seeall)

local PicturepuzzleshareViewPresentor = class("PicturepuzzleshareViewPresentor", ViewPresentor)

function PicturepuzzleshareViewPresentor:ctor()
	PicturepuzzleshareViewPresentor.super.ctor(self)
end

function PicturepuzzleshareViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PicturepuzzleshareViewPresentor:dependWhatResources()
	return {
		"ui/views/picturepuzzle/picturepuzzleshareview.prefab"
	}
end

function PicturepuzzleshareViewPresentor:buildViews()
	return {
		PicturepuzzleshareView.New()
	}
end

return PicturepuzzleshareViewPresentor
