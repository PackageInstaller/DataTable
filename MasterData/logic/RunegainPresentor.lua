-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rune/view/RunegainPresentor.lua

module("logic.extensions.rune.view.RunegainPresentor", package.seeall)

local RunegainPresentor = class("RunegainPresentor", ViewPresentor)

function RunegainPresentor:ctor()
	RunegainPresentor.super.ctor(self)
end

function RunegainPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RunegainPresentor:dependWhatResources()
	return {
		"ui/views/rune/runegainview.prefab"
	}
end

function RunegainPresentor:buildViews()
	return {
		RunegainView.New()
	}
end

return RunegainPresentor
