-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexiunuo/view/DivinexiunuoresultlViewPresentor.lua

module("logic.extensions.divinexiunuo.view.DivinexiunuoresultlViewPresentor", package.seeall)

local DivinexiunuoresultlViewPresentor = class("DivinexiunuoresultlViewPresentor", ViewPresentor)

function DivinexiunuoresultlViewPresentor:ctor()
	DivinexiunuoresultlViewPresentor.super.ctor(self)
end

function DivinexiunuoresultlViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinexiunuoresultlViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/divinexiunuo/divinexiunuoresultlview.prefab"
	}
end

function DivinexiunuoresultlViewPresentor:buildViews()
	return {
		DivinexiunuoresultlView.New()
	}
end

return DivinexiunuoresultlViewPresentor
