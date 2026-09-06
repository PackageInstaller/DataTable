-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teshamu/view/TeShaMuMainViewPresentor.lua

module("logic.extensions.teshamu.view.TeShaMuMainViewPresentor", package.seeall)

local TeShaMuMainViewPresentor = class("TeShaMuMainViewPresentor", ViewPresentor)

function TeShaMuMainViewPresentor:ctor()
	TeShaMuMainViewPresentor.super.ctor(self)
end

function TeShaMuMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TeShaMuMainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/teshamu/teshamumainview.prefab"
	}
end

function TeShaMuMainViewPresentor:buildViews()
	return {
		TeShaMuMainView.New()
	}
end

return TeShaMuMainViewPresentor
