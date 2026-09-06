-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitrank/view/TimelimitrankprizeViewPresentor.lua

module("logic.extensions.timelimitrank.view.TimelimitrankprizeViewPresentor", package.seeall)

local TimelimitrankprizeViewPresentor = class("TimelimitrankprizeViewPresentor", ViewPresentor)

function TimelimitrankprizeViewPresentor:ctor()
	TimelimitrankprizeViewPresentor.super.ctor(self)
end

function TimelimitrankprizeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TimelimitrankprizeViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitrank/timelimitrankprizeview.prefab"
	}
end

function TimelimitrankprizeViewPresentor:buildViews()
	return {
		TimelimitrankprizeView.New()
	}
end

return TimelimitrankprizeViewPresentor
