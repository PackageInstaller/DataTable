-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpgame/view/JumpResultViewPresentor.lua

module("logic.extensions.jumpgame.view.JumpResultViewPresentor", package.seeall)

local JumpResultViewPresentor = class("JumpResultViewPresentor", ViewPresentor)

function JumpResultViewPresentor:ctor()
	JumpResultViewPresentor.super.ctor(self)
end

function JumpResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function JumpResultViewPresentor:dependWhatResources()
	return {
		"ui/views/jumpgame/jumpresultview.prefab"
	}
end

function JumpResultViewPresentor:buildViews()
	local views = {}
	local view = JumpResultView.New()

	table.insert(views, view)

	return views
end

return JumpResultViewPresentor
