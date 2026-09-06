-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rune/view/RunelevelupPresentor.lua

module("logic.extensions.rune.view.RunelevelupPresentor", package.seeall)

local RunelevelupPresentor = class("RunelevelupPresentor", ViewPresentor)

function RunelevelupPresentor:ctor()
	RunelevelupPresentor.super.ctor(self)
end

function RunelevelupPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RunelevelupPresentor:dependWhatResources()
	return {
		"ui/views/rune/runelevelupview.prefab"
	}
end

function RunelevelupPresentor:buildViews()
	return {
		RunelevelupView.New()
	}
end

return RunelevelupPresentor
