-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lailisi/view/diana/DianaMainViewPresentor.lua

module("logic.extensions.lailisi.view.diana.DianaMainViewPresentor", package.seeall)

local DianaMainViewPresentor = class("DianaMainViewPresentor", ViewPresentor)

function DianaMainViewPresentor:ctor()
	DianaMainViewPresentor.super.ctor(self)
end

function DianaMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DianaMainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/diana/dianamainview.prefab"
	}
end

function DianaMainViewPresentor:buildViews()
	return {
		DianaMainView.New()
	}
end

return DianaMainViewPresentor
