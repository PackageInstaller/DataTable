-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rune/view/RunechangeapplyPresentor.lua

module("logic.extensions.rune.view.RunechangeapplyPresentor", package.seeall)

local RunechangeapplyPresentor = class("RunechangeapplyPresentor", ViewPresentor)

function RunechangeapplyPresentor:ctor()
	RunechangeapplyPresentor.super.ctor(self)
end

function RunechangeapplyPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RunechangeapplyPresentor:dependWhatResources()
	return {
		"ui/views/rune/runechangeapplyview.prefab"
	}
end

function RunechangeapplyPresentor:buildViews()
	return {
		RunechangeapplyView.New()
	}
end

return RunechangeapplyPresentor
