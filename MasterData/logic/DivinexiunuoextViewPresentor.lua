-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexiunuo/view/DivinexiunuoextViewPresentor.lua

module("logic.extensions.divinexiunuo.view.DivinexiunuoextViewPresentor", package.seeall)

local DivinexiunuoextViewPresentor = class("DivinexiunuoextViewPresentor", ViewPresentor)

function DivinexiunuoextViewPresentor:ctor()
	DivinexiunuoextViewPresentor.super.ctor(self)
end

function DivinexiunuoextViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinexiunuoextViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/divinexiunuo/divinexiunuoextview.prefab"
	}
end

function DivinexiunuoextViewPresentor:buildViews()
	return {
		DivinexiunuoextView.New()
	}
end

return DivinexiunuoextViewPresentor
