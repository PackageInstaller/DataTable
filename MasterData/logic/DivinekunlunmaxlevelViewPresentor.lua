-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekunlun/view/DivinekunlunmaxlevelViewPresentor.lua

module("logic.extensions.divinekunlun.view.DivinekunlunmaxlevelViewPresentor", package.seeall)

local DivinekunlunmaxlevelViewPresentor = class("DivinekunlunmaxlevelViewPresentor", ViewPresentor)

function DivinekunlunmaxlevelViewPresentor:ctor()
	DivinekunlunmaxlevelViewPresentor.super.ctor(self)
end

function DivinekunlunmaxlevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinekunlunmaxlevelViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/divinekunlun/divinekunlunmaxlevelview.prefab"
	}
end

function DivinekunlunmaxlevelViewPresentor:buildViews()
	return {
		DivinekunlunmaxlevelView.New()
	}
end

return DivinekunlunmaxlevelViewPresentor
