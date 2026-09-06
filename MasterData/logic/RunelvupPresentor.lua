-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rune/view/RunelvupPresentor.lua

module("logic.extensions.rune.view.RunelvupPresentor", package.seeall)

local RunelvupPresentor = class("RunelvupPresentor", ViewPresentor)

function RunelvupPresentor:ctor()
	RunelvupPresentor.super.ctor(self)
end

function RunelvupPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RunelvupPresentor:dependWhatResources()
	return {
		"ui/views/rune/runelvupview.prefab"
	}
end

function RunelvupPresentor:buildViews()
	return {
		RunelvupView.New()
	}
end

return RunelvupPresentor
