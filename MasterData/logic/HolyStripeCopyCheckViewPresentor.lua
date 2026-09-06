-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripecopy/view/HolyStripeCopyCheckViewPresentor.lua

module("logic.extensions.holystripecopy.view.HolyStripeCopyCheckViewPresentor", package.seeall)

local HolyStripeCopyCheckViewPresentor = class("HolyStripeCopyCheckViewPresentor", ViewPresentor)

function HolyStripeCopyCheckViewPresentor:ctor()
	HolyStripeCopyCheckViewPresentor.super.ctor(self)
end

function HolyStripeCopyCheckViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HolyStripeCopyCheckViewPresentor:dependWhatResources()
	return {
		"ui/views/holystripecopy/holystripecopycheckview.prefab"
	}
end

function HolyStripeCopyCheckViewPresentor:buildViews()
	return {
		HolyStripeCopyCheckView.New()
	}
end

return HolyStripeCopyCheckViewPresentor
