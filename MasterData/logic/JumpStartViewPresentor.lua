-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpgame/view/JumpStartViewPresentor.lua

module("logic.extensions.jumpgame.view.JumpStartViewPresentor", package.seeall)

local JumpStartViewPresentor = class("JumpStartViewPresentor", ViewPresentor)

function JumpStartViewPresentor:ctor()
	JumpStartViewPresentor.super.ctor(self)
end

function JumpStartViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function JumpStartViewPresentor:dependWhatResources()
	return {
		"ui/views/jumpgame/jumpstartview.prefab"
	}
end

function JumpStartViewPresentor:buildViews()
	local views = {}
	local view = JumpStartView.New()

	table.insert(views, view)

	return views
end

function JumpStartViewPresentor:onClickOutside()
	UIStateManager.instance:pop()
end

return JumpStartViewPresentor
