-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rune/view/RuneresolvePresentor.lua

module("logic.extensions.rune.view.RuneresolvePresentor", package.seeall)

local RuneresolvePresentor = class("RuneresolvePresentor", ViewPresentor)

function RuneresolvePresentor:ctor()
	RuneresolvePresentor.super.ctor(self)
end

function RuneresolvePresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RuneresolvePresentor:dependWhatResources()
	return {
		"ui/views/rune/runeresolveview.prefab"
	}
end

function RuneresolvePresentor:buildViews()
	return {
		RuneresolveView.New()
	}
end

return RuneresolvePresentor
