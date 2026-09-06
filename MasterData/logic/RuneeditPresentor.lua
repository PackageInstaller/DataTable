-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rune/view/RuneeditPresentor.lua

module("logic.extensions.rune.view.RuneeditPresentor", package.seeall)

local RuneeditPresentor = class("RuneeditPresentor", ViewWithGuidePresentor)

function RuneeditPresentor:ctor()
	RuneeditPresentor.super.ctor(self)
end

function RuneeditPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RuneeditPresentor:dependWhatResources()
	return {
		"ui/views/rune/runeeditview.prefab"
	}
end

function RuneeditPresentor:buildViews()
	return {
		RuneeditView.New()
	}
end

function RuneeditPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return RuneeditPresentor
