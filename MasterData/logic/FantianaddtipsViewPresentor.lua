-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fantian/view/FantianaddtipsViewPresentor.lua

module("logic.extensions.fantian.view.FantianaddtipsViewPresentor", package.seeall)

local FantianaddtipsViewPresentor = class("FantianaddtipsViewPresentor", ViewPresentor)

function FantianaddtipsViewPresentor:ctor()
	FantianaddtipsViewPresentor.super.ctor(self)
end

function FantianaddtipsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FantianaddtipsViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/fantian/fantianaddtipsview.prefab"
	}
end

function FantianaddtipsViewPresentor:buildViews()
	return {
		FantianaddtipsView.New()
	}
end

return FantianaddtipsViewPresentor
