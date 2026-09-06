-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rune/view/RunetipPresentor.lua

module("logic.extensions.rune.view.RunetipPresentor", package.seeall)

local RunetipPresentor = class("RunetipPresentor", ViewPresentor)

function RunetipPresentor:ctor()
	RunetipPresentor.super.ctor(self)
end

function RunetipPresentor:attachToWhichRoot()
	return ViewRootType.TopMost
end

function RunetipPresentor:dependWhatResources()
	return {
		"ui/views/rune/runetipview.prefab"
	}
end

function RunetipPresentor:buildViews()
	return {
		RunetipView.New()
	}
end

return RunetipPresentor
