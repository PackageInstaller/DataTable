-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rune/view/RunePresentor.lua

module("logic.extensions.rune.view.RunePresentor", package.seeall)

local RunePresentor = class("RunePresentor", ViewWithGuidePresentor)

function RunePresentor:ctor()
	RunePresentor.super.ctor(self)
end

function RunePresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RunePresentor:dependWhatResources()
	return {
		"ui/views/rune/runeview.prefab"
	}
end

function RunePresentor:buildViews()
	return {
		RuneView.New()
	}
end

function RunePresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return RunePresentor
