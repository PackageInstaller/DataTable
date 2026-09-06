-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexiunuo/view/DivinexiunuolevelViewPresentor.lua

module("logic.extensions.divinexiunuo.view.DivinexiunuolevelViewPresentor", package.seeall)

local DivinexiunuolevelViewPresentor = class("DivinexiunuolevelViewPresentor", ViewPresentor)

function DivinexiunuolevelViewPresentor:ctor()
	DivinexiunuolevelViewPresentor.super.ctor(self)
end

function DivinexiunuolevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinexiunuolevelViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/divinexiunuo/divinexiunuolevelview.prefab"
	}
end

function DivinexiunuolevelViewPresentor:buildViews()
	return {
		DivinexiunuolevelView.New()
	}
end

return DivinexiunuolevelViewPresentor
