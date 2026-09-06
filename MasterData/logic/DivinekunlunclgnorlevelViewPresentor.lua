-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekunlun/view/DivinekunlunclgnorlevelViewPresentor.lua

module("logic.extensions.divinekunlun.view.DivinekunlunclgnorlevelViewPresentor", package.seeall)

local DivinekunlunclgnorlevelViewPresentor = class("DivinekunlunclgnorlevelViewPresentor", ViewPresentor)

function DivinekunlunclgnorlevelViewPresentor:ctor()
	DivinekunlunclgnorlevelViewPresentor.super.ctor(self)
end

function DivinekunlunclgnorlevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinekunlunclgnorlevelViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/divinekunlun/divinekunlunclgnorlevelview.prefab"
	}
end

function DivinekunlunclgnorlevelViewPresentor:buildViews()
	return {
		DivinekunlunclgnorlevelView.New()
	}
end

return DivinekunlunclgnorlevelViewPresentor
