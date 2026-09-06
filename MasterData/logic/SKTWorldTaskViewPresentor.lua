-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknighttask/view/SKTWorldTaskViewPresentor.lua

module("logic.extensions.saintknighttask.view.SKTWorldTaskViewPresentor", package.seeall)

local SKTWorldTaskViewPresentor = class("SKTWorldTaskViewPresentor", ViewPresentor)

function SKTWorldTaskViewPresentor:ctor()
	SKTWorldTaskViewPresentor.super.ctor(self)
end

function SKTWorldTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SKTWorldTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/saintknighttask/sktworldtaskview.prefab"
	}
end

function SKTWorldTaskViewPresentor:buildViews()
	return {
		SKTWorldTaskView.New()
	}
end

function SKTWorldTaskViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return SKTWorldTaskViewPresentor
