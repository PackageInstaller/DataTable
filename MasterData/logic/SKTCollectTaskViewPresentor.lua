-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknighttask/view/collection/SKTCollectTaskViewPresentor.lua

module("logic.extensions.saintknighttask.view.collection.SKTCollectTaskViewPresentor", package.seeall)

local SKTCollectTaskViewPresentor = class("SKTCollectTaskViewPresentor", ViewPresentor)

function SKTCollectTaskViewPresentor:ctor()
	SKTCollectTaskViewPresentor.super.ctor(self)
end

function SKTCollectTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SKTCollectTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/saintknighttask/sktcollecttaskview.prefab"
	}
end

function SKTCollectTaskViewPresentor:buildViews()
	return {
		SKTCollectTaskView.New()
	}
end

function SKTCollectTaskViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return SKTCollectTaskViewPresentor
