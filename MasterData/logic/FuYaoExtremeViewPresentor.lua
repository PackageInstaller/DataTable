-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fuyao/view/FuYaoExtremeViewPresentor.lua

module("logic.extensions.fuyao.view.FuYaoExtremeViewPresentor", package.seeall)

local FuYaoExtremeViewPresentor = class("FuYaoExtremeViewPresentor", ViewPresentor)

function FuYaoExtremeViewPresentor:ctor()
	FuYaoExtremeViewPresentor.super.ctor(self)
end

function FuYaoExtremeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FuYaoExtremeViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/fuyao/fuyaoextremeview.prefab"
	}
end

function FuYaoExtremeViewPresentor:buildViews()
	return {
		FuYaoExtremeView.New()
	}
end

return FuYaoExtremeViewPresentor
