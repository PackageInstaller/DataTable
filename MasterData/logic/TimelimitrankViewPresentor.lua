-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitrank/view/TimelimitrankViewPresentor.lua

module("logic.extensions.timelimitrank.view.TimelimitrankViewPresentor", package.seeall)

local TimelimitrankViewPresentor = class("TimelimitrankViewPresentor", ViewPresentor)

function TimelimitrankViewPresentor:ctor()
	TimelimitrankViewPresentor.super.ctor(self)
end

function TimelimitrankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TimelimitrankViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitrank/timelimitrankview.prefab"
	}
end

function TimelimitrankViewPresentor:buildViews()
	return {
		TimelimitrankView.New()
	}
end

return TimelimitrankViewPresentor
