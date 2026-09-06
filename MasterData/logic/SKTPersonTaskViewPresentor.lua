-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknighttask/view/SKTPersonTaskViewPresentor.lua

module("logic.extensions.saintknighttask.view.SKTPersonTaskViewPresentor", package.seeall)

local SKTPersonTaskViewPresentor = class("SKTPersonTaskViewPresentor", ViewPresentor)

function SKTPersonTaskViewPresentor:ctor()
	SKTPersonTaskViewPresentor.super.ctor(self)
end

function SKTPersonTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SKTPersonTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/saintknighttask/sktpersontaskview.prefab"
	}
end

function SKTPersonTaskViewPresentor:buildViews()
	return {
		SKTPersonTaskView.New()
	}
end

function SKTPersonTaskViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return SKTPersonTaskViewPresentor
