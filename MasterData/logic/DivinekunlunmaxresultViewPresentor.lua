-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekunlun/view/DivinekunlunmaxresultViewPresentor.lua

module("logic.extensions.divinekunlun.view.DivinekunlunmaxresultViewPresentor", package.seeall)

local DivinekunlunmaxresultViewPresentor = class("DivinekunlunmaxresultViewPresentor", ViewPresentor)

function DivinekunlunmaxresultViewPresentor:ctor()
	DivinekunlunmaxresultViewPresentor.super.ctor(self)
end

function DivinekunlunmaxresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinekunlunmaxresultViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/divinekunlun/divinekunlunmaxresultview.prefab"
	}
end

function DivinekunlunmaxresultViewPresentor:buildViews()
	return {
		DivinekunlunmaxresultView.New()
	}
end

return DivinekunlunmaxresultViewPresentor
