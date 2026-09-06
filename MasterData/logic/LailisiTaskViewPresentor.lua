-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lailisi/view/LailisiTaskViewPresentor.lua

module("logic.extensions.lailisi.view.LailisiTaskViewPresentor", package.seeall)

local LailisiTaskViewPresentor = class("LailisiTaskViewPresentor", ViewPresentor)

function LailisiTaskViewPresentor:ctor()
	LailisiTaskViewPresentor.super.ctor(self)
end

function LailisiTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LailisiTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/lailisi/lailisitaskview.prefab"
	}
end

function LailisiTaskViewPresentor:buildViews()
	return {
		LailisiTaskView.New()
	}
end

return LailisiTaskViewPresentor
